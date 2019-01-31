#!../../bin/linux-x86_64/zebra

## You may have to change zebra to something else
## everywhere it appears in this file

< envPaths

cd "$(TOP)"

epicsEnvSet("ENGINEER", "LIX")
epicsEnvSet("LOCATION", "XF:16ID")
epicsEnvSet("EPICS_CA_AUTO_ADDR_LIST", "NO")
epicsEnvSet("EPICS_CA_ADDR_LIST", "10.16.0.255")

## Register all support components
dbLoadDatabase("dbd/zebra.dbd",0,0)
zebra_registerRecordDeviceDriver(pdbbase) 

drvAsynIPPortConfigure("ty_zebra","10.16.2.50:7003")

#zebraConfig(Port, SerialPort, MaxPosCompPoints)
zebraConfig("ZEBRA", "ty_zebra", 100000)

## Load record instances
dbLoadRecords("db/zebra.db",        "P=XF:16IDC-ES,Q={Zeb:1}")
dbLoadRecords("db/iocAdminSoft.db", "IOC=XF:16IDC-CT{IOC:Zeb1}")

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
