#!/epics/src/motor-synapps/bin/linux-x86_64/WithAsyn
# revised from /epics/src/motor-synapps/iocBoot/iocWithAsyn/st.cmd.xps
# refer to https://confluence.slac.stanford.edu/display/PCDS/Newport+XPS+Series+Motor+Controllers
errlogInit(5000)
< envPaths
< /epics/common/xf16idc-ioc1-netsetup.cmd

epicsEnvSet("XPS_IP", "xf16idc-mc-xps-q8.nsls2.bnl.local")
epicsEnvSet("XPS_PORT", "5001")

# Tell EPICS all about the record types, device-support modules, drivers,
# etc. in this build from CARS
dbLoadDatabase("$(TOP)/dbd/WithAsyn.dbd")
WithAsyn_registerRecordDeviceDriver(pdbbase)

### Motors
dbLoadTemplate "motor.substitutions_2019Apr"
dbLoadTemplate "XPSAux.substitutions_2017Dec20"

# portName, IPAddress, IPPort, numAxes, movingPollPeriod, idlePollPeriod, 
# enableSetPosition, setPositionSettlingTime
XPSCreateController("XPS1", "$(XPS_IP)", $(XPS_PORT), 5, 10, 500, 0, 500)
asynSetTraceIOMask("XPS1", 0, 2)

# asynPort, IP address, IP port, poll period (ms)
XPSAuxConfig("XPS_AUX1", "$(XPS_IP)", $(XPS_PORT), 50)

# positioners
#   ch 1: GTS30V,  min inc motion = 0.1 um, max speed = 10 mm/s   
#   ch 2: VP-25XA, min inc motion = 0.1 um, max speed = 25 mm/s    
#   ch 3: URS75BCC, min inc motion = 2 mdeg, max speed = 80 deg/s   
#   ch 4: TRA12PPD,  min inc motion = 0.1 um, max speed = 0.4 mm/s        
# optional:
#   ch 5: URS50BCC
# use manual configuration in the web interface
# add "Single axes" group "X" and "Y"
# then add "Multiple" group "scan", with members rY, X and Y

# XPSName, axis, positionerName, stepsPerUnit
#XPSCreateAxis("XPS1",0,"scan.Y",              "10000")
#XPSCreateAxis("XPS1",1,"scan.X",              "10000")
#XPSCreateAxis("XPS1",2,"scan.rY",              "1000")
XPSCreateAxis("XPS1",3,"Group4.Pos",               "1000")
#XPSCreateAxis("XPS1",4,"rY1.Pos",              "10000")
#XPSCreateAxis("XPS1",3,"Group4.Pos",               "1000")

iocInit

