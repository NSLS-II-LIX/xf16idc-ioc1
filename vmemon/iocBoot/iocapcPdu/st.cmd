#!../../bin/linux-x86/snmp
## You may have to change snmp to something else
## everywhere it appears in this file

epicsEnvSet("ENGINEER", "Yong Hu")
epicsEnvSet("LOCATION", "Bldg 740 CR")

epicsEnvSet("TOP", "$(PWD)/snmp")

## Register all support components
dbLoadDatabase("dbd/snmp.dbd")
snmp_registerRecordDeviceDriver(pdbbase)

## Load record instances
#epicsSnmpSetSnmpVersion("10.0.144.14", "SNMP_VERSION_1")
#dbLoadRecords("db/apcPdu.db")

dbLoadRecords("db/iocAdminSoft.db", "IOC=CS{IOC:SNMP}")
dbLoadRecords("db/save_restoreStatus.db", "P=CS{IOC:SNMP}")

## Set this to see messages from mySub
#var mySubDebug 1

asSetFilename("/epics/iocs/CtrSwitch-log.acf") 
asSetSubstitutions("P=CtrlSwitch:")

set_savefile_path("${TOP}/as","/save")
set_requestfile_path("${TOP}/as","/req")

set_pass0_restoreFile("snmp_settings.sav")
set_pass1_restoreFile("snmp_settings.sav")

iocInit()
epicsSnmpInit()

caPutLogInit("10.0.152.133:7004")


makeAutosaveFileFromDbInfo("as/req/snmp_settings.req", "autosaveFields")
create_monitor_set("snmp_settings.req", 10 , "")

#dbl > records.dbl
#system "cp records.dbl /cf-update/1wire-cr-rga.SNMP.dbl"
