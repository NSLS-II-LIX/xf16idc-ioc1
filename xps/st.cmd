#!/epics/src/motor-synapps/bin/linux-x86_64/WithAsyn
# revised from /epics/src/motor-synapps/iocBoot/iocWithAsyn/st.cmd.xps
# refer to https://confluence.slac.stanford.edu/display/PCDS/Newport+XPS+Series+Motor+Controllers
errlogInit(5000)
< envPaths
# Tell EPICS all about the record types, device-support modules, drivers,
# etc. in this build from CARS
dbLoadDatabase("$(TOP)/dbd/WithAsyn.dbd")
WithAsyn_registerRecordDeviceDriver(pdbbase)

### Motors
dbLoadTemplate "motor.substitutions"

dbLoadTemplate "XPSAux.substitutions"

# cards (total controllers)
XPSSetup(1)

# card, IP, PORT, number of axes, active poll period (ms), idle poll period (ms)
XPSConfig(0, "10.16.2.100", 5001, 3, 10, 5000)

# asynPort, IP address, IP port, poll period (ms)
XPSAuxConfig("XPS_AUX1", "10.16.2.100", 5001, 50)
#asynSetTraceMask("XPS_AUX1", 0, 255)
#asynSetTraceIOMask("XPS_AUX1", 0, 2)

# XPsyn port, driver name, controller index, max. axes)
drvAsynMotorConfigure("XPS1", "motorXPS", 0, 3)
XPSInterpose("XPS1")

# card ,  axis, groupName.positionerName, step/EGU (must be reciprocal to MRES)
XPSConfigAxis(0,0,"Group1.Pos",              10000) 
# VP-5ZA, 0.06um min step

XPSConfigAxis(0,1,"Group2.Pos",              10000) 
# VP-25XA, 0.1um min step

XPSConfigAxis(0,2,"Group3.Pos",               2000) 
# URS50BCC

#XPSConfigAxis(0,3,"Group4.Pos",               1000)
# ILS100PP

XPSEnableSetPosition(0)
#XPSEnableSetPosition("XPS1", 0)
#XPSSetPositionSettlingTime(XPS1, 200)

iocInit

# This IOC does not use save/restore, so set values of some PVs
#dbpf("IOC:m1.RTRY", "0")
#dbpf("IOC:m1.TWV", "0.1")
#dbpf("IOC:m2.RTRY", "0")
#dbpf("IOC:m2.TWV", "0.1")
#dbpf("IOC:m3.RTRY", "0")
#dbpf("IOC:m3.TWV", "0.1")
