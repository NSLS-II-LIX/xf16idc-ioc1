#!../../bin/linux-x86_64/smaract

## You may have to change smaract to something else
## everywhere it appears in this file

< envPaths

cd ${TOP}

#epicsEnvSet("EPICS_CA_AUTO_ADDR_LIST", "NO")
#epicsEnvSet("EPICS_CA_ADDR_LIST", "10.11.0.255")

## Register all support components
dbLoadDatabase("dbd/smaract.dbd",0,0)
smaract_registerRecordDeviceDriver(pdbbase) 

#drvAsynIPPortConfigure("tsrv1-P13","192.168.0.121:5000")
drvAsynIPPortConfigure("P0","10.16.2.94:5000")

#drvAsynIPPortConfigure("tsrv1-P13", "xf11ida-tsrv1:4013")
#drvAsynSerialPortConfigure("tsrv1-P13", "/dev/ttyUSB0")
#asynSetOption ("tsrv1-P13", 0, "baud",    "9600")
#asynSetOption ("tsrv1-P13", 0, "bits",    "8")
#asynSetOption ("tsrv1-P13", 0, "parity",  "none")
#asynSetOption ("tsrv1-P13", 0, "stop",    "1")
#asynSetOption ("tsrv1-P13", 0, "clocal",  "N")

smarActMCSCreateController("motor", "P0", 3, 0.1, 1.0)
smarActMCSCreateAxis("motor", 0, 0)
smarActMCSCreateAxis("motor", 1, 1)
smarActMCSCreateAxis("motor", 2, 2)
#smarActMCSCreateAxis("motor", 3, 3)
#smarActMCSCreateAxis("motor", 4, 4)
#smarActMCSCreateAxis("motor", 5, 5)

## Load record instances
dbLoadTemplate("db/motor.substitutions")
#dbLoadRecords("$(EPICS_BASE)/db/2slit.db", "P=XF:11IDA-OP,SLIT={Slt:MB-Ax:X},mXp={Slt:MB-Ax:O}Mtr,mXn={Slt:MB-Ax:I}Mtr")
#dbLoadRecords("$(EPICS_BASE)/db/2slit.db", "P=XF:11IDA-OP,SLIT={Slt:MB-Ax:Y},mXp={Slt:MB-Ax:T}Mtr,mXn={Slt:MB-Ax:B}Mtr")
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

## more autosave/restore machinery
cd ${TOP}/as/req
makeAutosaveFiles()
create_monitor_set("info_positions.req", 5 , "")
create_monitor_set("info_settings.req", 15 , "")

#dbl > "/cf-update/xf11ida-ioc1.mc5.dbl"
