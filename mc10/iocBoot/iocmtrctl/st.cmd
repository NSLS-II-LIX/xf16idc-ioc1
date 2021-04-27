#!../../bin/linux-x86_64/tpmac

## You may have to change tpmac to something else
## everywhere it appears in this file

< envPaths
< /epics/common/xf16idc-ioc1-netsetup.cmd

cd ${TOP} #/iocBoot/${IOC}

epicsEnvSet("ENGINEER", "LIX")
epicsEnvSet("LOCATION", "XF:16{RG:C2}")
epicsEnvSet("STREAM_PROTOCOL_PATH", "/usr/share/epics-pmacutil-dev/protocol")

## Register all support components
dbLoadDatabase("dbd/tpmac.dbd",0,0)
tpmac_registerRecordDeviceDriver(pdbbase) 

# pmacAsynIPConfigure() is a wrapper for drvAsynIPPort::drvAsynIPPortConfigure() and
# pmacAsynIPPort::pmacAsynIPPortConfigureEos().
# See pmacAsynIPPort.c
pmacAsynIPConfigure("P0","xf16idc-mc10.nsls2.bnl.local:1025")

# WARNING: a trace-mask of containing 0x10 will TRACE_FLOW (v. noisy!!)
#asynSetTraceMask("P0",-1,0x9)
#asynSetTraceIOMask("P0",-1,0x2)

# pmacAsynMotorCreate(port,addr,card,nAxes)
# see pmacAsynMotor.c
#pmacAsynMotorCreate("P0", 0, 1, 4);

#New model 3 driver
#pmacCreateController(motor record port name, low level port, low level port address, num axes, moving polling period (ms), idle polling period (ms))
pmacCreateController("M0","P0",0,9,100,1000)

# Setup the motor Asyn layer (port, drvet name, card, nAxes+1)
#drvAsynMotorConfigure("M0", "pmacAsynMotor", 1, 5)

#New model 3 driver
pmacCreateAxis("M0", 1)
pmacCreateAxis("M0", 2)
pmacCreateAxis("M0", 3)
pmacCreateAxis("M0", 4)
pmacCreateAxis("M0", 5)
pmacCreateAxis("M0", 6)
pmacCreateAxis("M0", 7)
pmacCreateAxis("M0", 8)


# Disable the limits disabled check for some axes (normally this should be left enabled)
# pmacDisableLimitsCheck(string portname, int axis, int allAxes)
#### disable limit check for all axes
#pmacDisableLimitsCheck("M0", 0, 1)
#### disable limit check for axis 3
#pmacDisableLimitsCheck("M0", 3, 0)

#Set the axis scale factor
#pmacSetAxisScale("M0", 1, 1)

#Set the encoder axis for an open loop axis.
#pmacSetOpenLoopEncoderAxis(const char *controller, int axis, int encoder_axis)
#pmacSetOpenLoopEncoderAxis("PMAC1", 1, 2)

# Initialize the coord-system(port,addr,cs,ref,prog#)
#pmacAsynCoordCreate("P0",0,5,5,10)
# setup the coord-sys(portName,drvel-name,ref#(from create),nAxes+1)
#drvAsynMotorConfigure("CS5","pmacAsynCoord",5,9)

# set the scaling correctly for the coordinate system axes
#pmacSetCoordStepsPerUnit(2,5,1.0)

# change poll rates (card, poll-period in ms)
#pmacSetMovingPollPeriod( 1, 100 )
#pmacSetIdlePollPeriod( 1, 1000 )
#pmacSetCoordMovingPollPeriod(5,200)
#pmacSetCoordIdlePollPeriod(5,2000)


## Load record instances
dbLoadTemplate("db/motor.substitutions")
dbLoadRecords("db/asynComm.db","P=XF:16IDC-CT{MC:10},PORT=P0,ADDR=0")
dbLoadTemplate("db/motorstatus.substitutions")
dbLoadRecords("db/pmacStatus.db","SYS=XF:16IDC-CT,PMAC=MC:10,VERSION=1,PLC=5,PORT=P0,NAXES=8")
dbLoadTemplate("db/pmac_asyn_motor.substitutions")
#no homing implemented for this motorcontroller
#dbLoadTemplate("db/autohome.substitutions")
#dbLoadTemplate("db/cs.substitutions")
dbLoadRecords("db/iocAdminSoft.db","IOC=XF:16IDC-CT{IOC:MC10}")

## autosave/restore machinery
save_restoreSet_Debug(0)
save_restoreSet_IncompleteSetsOk(1)
save_restoreSet_DatedBackupFiles(1)

set_savefile_path("${TOP}/as","/save")
set_requestfile_path("${TOP}/as","/req")

set_pass0_restoreFile("info_positions.sav")
set_pass0_restoreFile("info_settings.sav")
set_pass1_restoreFile("info_settings.sav")

iocInit()

## more autosave/restore machinery
cd ${TOP}/as/req
makeAutosaveFiles()
create_monitor_set("info_positions.req", 5 , "")
create_monitor_set("info_settings.req", 15 , "")

dbl > "/cf-update/xf16idc-ioc1.mc7.dbl"
