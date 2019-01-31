#!/epics/src/motor-synapps/bin/linux-x86_64/WithAsyn

#errlogInit(5000)
< envPaths
# Tell EPICS all about the record types, device-support modules, drivers,
# etc. in this build from CARS
dbLoadDatabase("$(TOP)/dbd/WithAsyn.dbd")
WithAsyn_registerRecordDeviceDriver(pdbbase)

drvAsynIPPortConfigure("serial1", "10.16.2.99:5000",0,0,0)
asynOctetSetInputEos("serial1",0,"\r")
asynOctetSetOutputEos("serial1",0,"\r")
#asynSetTraceIOMask("serial1", 0, 2)
#asynSetTraceMask("serial1", 0, 255)

# MCB4BCreateController("$(INSTANCE)", "$(PORT)", $(NUM_AXES=1), $(MOVING_POLL=$(POLL_RATE=100)), $(IDLE_POLL=$(POLL_RATE=100)))
MCB4BCreateController("MCB4B2", "serial1", 8, 500, 100)

### Motors
dbLoadTemplate "motor.substitutions.mcb4b2"

dbLoadRecords("$(ASYN)/db/asynRecord.db","P=XF:16IDC-ES:,R=serial1,PORT=serial1,ADDR=0,OMAX=80,IMAX=80")

iocInit

dbl > "/cf-update/xf16idc-ioc1.mcb4b2.dbl"

# This IOC does not use save/restore, so set values of some PVs
dbpf("XF:16IDC-OP{Slt:Gs-Ax:dX}Mtr.VELO", "0.5")
dbpf("XF:16IDC-OP{Slt:Gs-Ax:dY}Mtr.VELO", "0.5")
dbpf("XF:16IDC-OP{Slt:Gs-Ax:X}Mtr.VELO", "0.25")
dbpf("XF:16IDC-OP{Slt:Gs-Ax:Y}Mtr.VELO", "0.25")

#dbpf("IOC:m2.RTRY", "0")
#dbpf("IOC:m2.TWV", "0.1")
#dbpf("IOC:m3.RTRY", "0")
#dbpf("IOC:m3.TWV", "0.1")
#dbpf("IOC:m4.RTRY", "0")
#dbpf("IOC:m4.TWV", "0.1")
