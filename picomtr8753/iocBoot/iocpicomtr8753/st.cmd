#!../../bin/linux-x86_64/picomtr8753

## You may have to change picomtr8753 to something else
## everywhere it appears in this file

< envPaths
cd ${TOP}

epicsEnvSet("ENGINEER", "Oksana Ivashkevych")
epicsEnvSet("LOCATION", "XF:16{HutchC}")
epicsEnvSet("EPICS_CA_AUTO_ADDR_LIST", "NO")
epicsEnvSet("EPICS_CA_ADDR_LIST", "10.16.0.255")

## Register all support components
dbLoadDatabase("dbd/picomtr8753.dbd",0,0)
picomtr8753_registerRecordDeviceDriver(pdbbase) 

# Setup IP port for 8752; in our case 8753
drvAsynIPPortConfigure("serial1", "10.16.2.95:23",0,0,0)
asynOctetSetInputEos("serial1",0,">")
asynOctetSetOutputEos("serial1",0,"\r")
asynOctetConnect("serial1", "serial1")

dbLoadRecords("db/asynRecord.db", "P=XF:16IDC-OP,R={picomtr8753},PORT=serial1,ADDR=,OMAX=40,IMAX=40")
#dbLoadRecords("${EPICS_BASE}/db/asynRecord.db", "P=lsx16a:,R=pico1:port,PORT=S1,ADDR=,OMAX=40,IMAX=40")

# asyn debug traces
asynSetTraceMask("serial1",-1,0x9)
asynSetTraceIOMask("serial1",-1,0x2)

# New Focus Picomotor Network Controller (model 87xx) (setup parameters:
#     (1) maximum number of controllers in system
#     (2) maximum number of drivers per controller (1 - 3)
#     (3) motor task polling rate (min=1Hz,max=60Hz)
#var drvPMNC87xxdebug 3
PMNC87xxSetup(1,3,10)
#PMNC87xxSetup(2,3,10)

# New Focus Picomotor Network Controller (model 87xx) configuration parameters:
#     (1) controller# being configured,
#     (2) asyn port name (string)
PMNC87xxConfig(0, "serial1",0)
#PMNC87xxConfig(1, "S1",0)

## Load record instances
dbLoadTemplate("db/motor.substitutions")
dbLoadRecords("db/iocAdminSoft.db","IOC=XF:16IDC-CT{IOC:picomtr8753}"

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

## Start any sequence programs
#seq sncpicomtr8753,"user=oksana"

#autosave/restore machinery
cd ${TOP}/as/req
makeAutosaveFiles()
create_monitor_set("info_positions.req", 5 , "")
create_monitor_set("info_settings.req", 15 , "")

dbl > "/cf-update/xf16idc-ioc1.picomtr.dbl"

