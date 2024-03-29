#!/epics/src/motor-synapps/bin/linux-x86_64/WithAsyn

#errlogInit(5000)
< envPaths
< /epics/common/xf16idc-ioc1-netsetup.cmd
# Tell EPICS all about the record types, device-support modules, drivers,
# etc. in this build from CARS
dbLoadDatabase("$(TOP)/dbd/WithAsyn.dbd")
WithAsyn_registerRecordDeviceDriver(pdbbase)

drvAsynIPPortConfigure("serial1", "xf16idc-mc-mcb4b1.nsls2.bnl.local:5000",0,0,0)
asynOctetSetInputEos("serial1",0,"\r")
asynOctetSetOutputEos("serial1",0,"\r")
#asynSetTraceIOMask("serial1", 0, 2)
#asynSetTraceMask("serial1", 0, 255)

#MCB4BCreateController("MCB4B1", "serial1", 4, 10000, 5000)
MCB4BCreateController("MCB4B1", "serial1", 4, 1000, 500)

### Motors
dbLoadTemplate "motor.substitutions.mcb4b"

dbLoadRecords("$(ASYN)/db/asynRecord.db","P=XF:16IDC-ES:Sol,R=serial1,PORT=serial1,ADDR=0,OMAX=80,IMAX=80")
#dbLoadRecords("$(ASYN)/db/asynRecord.db","P=IOC:,R=serial1,PORT=serial1,ADDR=0,OMAX=80,IMAX=80")

iocInit

dbl > "/cf-update/xf16idc-ioc1.mcb4b.dbl"

# This IOC does not use save/restore, so set values of some PVs
dbpf("XF:16IDC-ES:Sol{Enc-Ax:Y}Mtr.RTRY", "0")
dbpf("XF:16IDC-ES:Sol{Enc-Ax:Y}Mtr.TWV", "0.1")
#dbpf("IOC:m2.RTRY", "0")
#dbpf("IOC:m2.TWV", "0.1")
#dbpf("IOC:m3.RTRY", "0")
#dbpf("IOC:m3.TWV", "0.1")
#dbpf("IOC:m4.RTRY", "0")
#dbpf("IOC:m4.TWV", "0.1")
