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


class Serial_device:
    def __init__(self, sock_addr):
        self.delay = 0.05
        self.sock = socket.create_connection(sock_addr)

    def comm(self, cmd, get_ret=True, verbose=True):
        if verbose: 
            print(cmd)
        self.sock.send(cmd.encode())
        if get_ret:
            time.sleep(self.delay)
            ret = self.sock.recv(256)
            if verbose:
                print(ret)
            ret = ret.decode('utf8','ignore')
            return ret

    def set_delay(self, t):
        self.delay = t

        
class MaxiGaugeController(Serial_device):
    def __init__(self, sock_addr, N_gauges):
        super().__init__(sock_addr)
        self.N_gauges = N_gauges
        self.record = {}

    def send(self, command, verbose=False):
        """ command should be sent with "\n" termination
            the controller acknowleges with <ACK> = b'\x15\r\n'
            then send <ENQ> = "\05\n"
            the controller resopnds with the result
        """
        while True:
            ret = self.comm(command+'\n', verbose=verbose)
            if ret == '\x06\r\n':
                break
            if verbose:
                print("unrecognized response from controller: ", ret[0], ret[1])
            time.sleep(0.5)
        ret = self.comm("\05\n", verbose=verbose)
        #print(ret)
        return ret

    def read_gauges(self):
        """ read all gauges and record returned string 
        """
        for i in range(1, self.N_gauges+1):
            self.record[i] = self.pressure(i)              
   
        threading.Timer(1.0, self.read_gauges).start()
 
    def pressure(self, gauge_number, verbose=False):
        """ response to the "PRn" command is S,x.xxxEsx
            the status S can be 
            x = 0: Measurement data okay
                1: Underrange
                2: Overrange
                3: Sensor error
                4: Sensor off
                5: No sensor
                6: Identification error
        """
        if gauge_number<1 or gauge_number>5:
            print("invalid gauge_number:", gauge_number)
            raise ValueError(gauge_number)
            
        message = ["OK", "UNDER", "OVER", "ERROR", "OFF", "NO GAUGE", "ID ERR"]
        while True:
            ret = self.send("PR%d" % gauge_number, verbose=verbose)
            if verbose:
                print(ret)
            try: 
                ms, ps = ret.strip("\n\r").split(",")
                ms = int(ms)
                psf = float(ps)
            except ValueError:
                continue
            else:
                break 
        if ms>0:
            msg = message[ms]
        else:
            msg = ps
        return msg,psf


class myDriver(Driver):
    def __init__(self):
        super().__init__()
        
        ## controller from CMS/X9, Baud rate is set to 9600
        ## connected to Moxa in C hutch, port 4
        self.maxi = MaxiGaugeController(("10.16.2.50", 7004), 2)
        self.maxi.read_gauges()

    def read(self, reason):
        if reason == '1}P:Raw-I':
            value = self.maxi.record[1][0]
        elif reason == '1}P-I':
            value = self.maxi.record[1][1]
        elif reason == '2}P:Raw-I':
            value = self.maxi.record[2][0]
        elif reason == '2}P-I':
            value = self.maxi.record[2][1]
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

