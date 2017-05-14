#!../../bin/linux-x86_64/PIE621

## You may have to change PIE621 to something else
## everywhere it appears in this file

< envPaths

cd ${TOP} #/iocBoot/${IOC}

epicsEnvSet("ENGINEER", "Oksana Ivashkevych")
epicsEnvSet("LOCATION", "XF:16{HutchC}")
epicsEnvSet("EPICS_CA_AUTO_ADDR_LIST", "NO")
epicsEnvSet("EPICS_CA_ADDR_LIST", "10.16.0.255")


## Register all support components
dbLoadDatabase("dbd/PIE621.dbd",0,0)
PIE621_registerRecordDeviceDriver(pdbbase) 

drvAsynIPPortConfigure("PISerial_1","10.16.2.57:4003")
#Add debugging
asynSetTraceIOMask("PISerial_1",0,2)
asynSetTraceMask("PISerial_1",0,9)

# PIE816Setup("Max. controller count", "Polling rate")
PIE816Setup(1, 5)
# PIE816Config("Card being configured", "asyn port name", "asyn address")
PIE816Config(0, "PISerial_1", 0)
PIE816Config(1, "PISerial_1", 0)

## Load record instances
dbLoadTemplate("db/motor.substitutions")
dbLoadRecords("db/asynRecord.db","P=asyn:, R=PI, PORT=PISerial_1, ADDR=0, OMAX=0, IMAX=0")
dbLoadRecords("db/iocAdminSoft.db","IOC=XF:16IDC-CT{IOC:PI621}")

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
#seq sncPIE621,"user=oksana"

utosave/restore machinery
cd ${TOP}/as/req
makeAutosaveFiles()
create_monitor_set("info_positions.req", 5 , "")
create_monitor_set("info_settings.req", 15 , "")

dbl > "/cf-update/xf16idc-ioc1.PIE621.dbl"

