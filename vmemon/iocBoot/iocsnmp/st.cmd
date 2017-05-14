#!../../bin/linux-x86/snmp
## You may have to change snmp to something else
## everywhere it appears in this file
< envPaths
epicsEnvSet("ENGINEER", "Jayesh Shah x3612")
epicsEnvSet("LOCATION", "Bldg 902B Rm18")

cd ${TOP}

## Register all support components
dbLoadDatabase("dbd/snmp.dbd")
snmp_registerRecordDeviceDriver(pdbbase)

## Load record instances

########################
#       APC PDU        #
########################
#epicsSnmpSetSnmpVersion("10.0.131.32", "SNMP_VERSION_1")
#dbLoadRecords("db/apcPdu.db")

########################
#   WIENER VME CRATE   #
########################
#dbLoadRecords("db/wiener.db" , "SYS=TST, D=Wiener, IP=10.0.131.33")

dbLoadRecords("db/iocAdminSoft.db", "IOC=TST-CS{IOC:SNMP}")
dbLoadRecords("db/save_restoreStatus.db", "P=TST-CS{IOC:SNMP}")

## Set this to see messages from mySub
#var mySubDebug 1

set_savefile_path("${PWD}/as","/save")
set_requestfile_path("${PWD}/as","/req")

set_pass0_restoreFile("snmp_settings.sav")
set_pass1_restoreFile("snmp_settings.sav")

cd ${TOP}/iocBoot/${IOC}
iocInit()
epicsSnmpInit()

makeAutosaveFileFromDbInfo("as/req/snmp_settings.req", "autosaveFields")
create_monitor_set("snmp_settings.req", 10 , "")

dbl > ../records.dbl
system "cp ../records.dbl /cf-update/32.SNMP"

