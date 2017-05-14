#!../../bin/linux-x86_64/smaract

## You may have to change smaract to something else
## everywhere it appears in this file

< envPaths

cd ${TOP}

epicsEnvSet("EPICS_CA_AUTO_ADDR_LIST", "NO")
epicsEnvSet("EPICS_CA_ADDR_LIST", "10.16.0.255")

## Register all support components
dbLoadDatabase("dbd/smaract.dbd",0,0)
smaract_registerRecordDeviceDriver(pdbbase) 

drvAsynIPPortConfigure("P0","10.16.2.98:5000")

smarActMCSCreateController("motor", "P0", 3, 0.1, 1.0)
smarActMCSCreateAxis("motor", 0, 0)
smarActMCSCreateAxis("motor", 1, 1)
smarActMCSCreateAxis("motor", 2, 2)

## Load record instances
dbLoadTemplate("db/motor.substitutions")
#dbLoadRecords("db/asynComm.db","P=LIX{MC:1},PORT=tsrv1-P13,ADDR=0")

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

cd ${TOP}/as/req
makeAutosaveFiles()
create_monitor_set("info_positions.req", 5 , "")
create_monitor_set("info_settings.req", 15 , "")

#dbl > "/cf-update/xf11ida-ioc1.mc5.dbl"
dbl > /cf-update/xf16idc-ioc1.mc15-smaract.dbl
