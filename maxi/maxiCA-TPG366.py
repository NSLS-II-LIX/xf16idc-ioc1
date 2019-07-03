#!/opt/conda/bin/python3
#
# CA for the Pfeiffer MaxiGuge controller
#

import threading,socket,time

from pcaspy import Driver, SimpleServer

prefix = 'XF:16IDC-VA:{ES-Maxi:'

# PV list

pvdb = {
    "1}P:Raw-I"       : {'type' : 'string', 'scan' : 1.0},
    "1}P-I"           : {'type' : 'float', 'scan' : 1.0},   
    "2}P:Raw-I"       : {'type' : 'string', 'scan' : 1.0},
    "2}P-I"           : {'type' : 'float', 'scan' : 1.0},
}


class MaxiGaugeController():
    def __init__(self, sock_addr, N_gauges=6):
        self.sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        self.sock.connect(sock_addr)
        self.sock.settimeout(2)
        self.N_gauges = N_gauges
        self.record = {}

        # ask the controller to continuously send back pressure readings every second
        self.sock.sendall("COM\r\n".encode())
        time.sleep(1)
        self.read_gauges()

    def read_gauges(self):
        """ read all gauges and record returned string 
        """
        message = ["OK", "UNDER", "OVER", "ERROR", "OFF", "NO GAUGE", "ID ERR"]
        ret = self.sock.recv(4096).decode().split('\r\n')
        flag = True        

        for i in reversed(range(len(ret))):
            msg = ret[i].split(',')
            if len(msg)<2*self.N_gauges:  # incomplete message
                continue
            flag = False
            print(msg)
            for k in range(self.N_gauges):
                st = int(msg[2*k])
                pv = float(msg[2*k+1])
                if st==0:
                    st = ("%5.2e" % pv)
                else:
                    st = message[st]
                self.record[k] = [st, pv] 
        if flag: # was not able to read a complete message
            time.sleep(1)

        threading.Timer(1.0, self.read_gauges).start()
 

class myDriver(Driver):
    def __init__(self):
        super().__init__()
        
        # new TPG 366 controller, 10.16.2.142
        self.maxi = MaxiGaugeController(("10.16.2.142", 8000))

    def read(self, reason):
        if reason == '1}P:Raw-I':
            value = self.maxi.record[0][0]
        elif reason == '1}P-I':
            value = self.maxi.record[0][1]
        elif reason == '2}P:Raw-I':
            value = self.maxi.record[1][0]
        elif reason == '2}P-I':
            value = self.maxi.record[1][1]
        else:
            value = self.getParam(reason)
        print(reason, value)
        return value            

    def write(self, reason, value):
        status = True

        # store the values
        if status:
            self.setParam(reason, value)
        return status

if __name__ == '__main__':
    server = SimpleServer()
    server.createPV(prefix, pvdb)
    driver = myDriver()

    # process CA transactions
    while True:
        server.process(0.1)

