#!../../bin/linux-x86_64/PSJena

## You may have to change PSJena to something else
## everywhere it appears in this file

< envPaths

cd ${TOP} #/iocBoot/${IOC}

epicsEnvSet("ENGINEER", "Oksana Ivashkevych")
epicsEnvSet("LOCATION", "XF:16{HutchB}")
epicsEnvSet("EPICS_CA_AUTO_ADDR_LIST", "NO")
epicsEnvSet("EPICS_CA_ADDR_LIST", "10.16.0.255")


## Register all support components
dbLoadDatabase("dbd/PSJena.dbd",0,0)
PSJena_registerRecordDeviceDriver(pdbbase) 

drvAsynIPPortConfigure("JenaSerial","10.16.2.56:4001")
#Add debugging
asynSetTraceIOMask("JenaSerial",0,2)
asynSetTraceMask("JenaSerial",0,9)

# Piezosystem Jena EDS motor controller/driver setup parameters:
#     (1) maximum number of controllers in system
#     (2) maximum drives per controller
#     (3) motor task polling rate (min=1Hz, max=60Hz)
#drvPIJEDSdebug=1
PIJEDSSetup(1, 2, 60)
###PIJEDSSetup(1, 2, 10)

# Piezosystem Jena EDS controller/driver configuration parameters:
#     (1) controller being configured
#     (2) asyn port name (string)
#     (3) asyn address (GPIB)
PIJEDSConfig(0, "JenaSerial", 0)
###PIJEDSSetup(1, 2, 10)

# Piezosystem Jena EDS controller/driver configuration parameters:
#     (1) controller being configured
#     (2) asyn port name (string)
#     (3) asyn address (GPIB)
PIJEDSConfig(0, "JenaSerial", 0)

## Load record instances
dbLoadTemplate("db/motor.substitutions")
#dbLoadRecords("db/PiezoSysJena.db")
dbLoadRecords("db/asynRecord.db","P=asyn:, R=PiezoSysJena, PORT=JenaSerial, ADDR=0, OMAX=0, IMAX=0")
dbLoadRecords("db/iocAdminSoft.db","IOC=XF:16IDC-CT{IOC:PSJena}")

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
#seq sncPSJena,"user=oksana"

#autosave/restore machinery
cd ${TOP}/as/req
makeAutosaveFiles()
create_monitor_set("info_positions.req", 5 , "")
create_monitor_set("info_settings.req", 15 , "")

dbl > "/cf-update/xf16idc-ioc1.PSJena.dbl"

