#!bin/linux-x86_64/snmp2
## You may have to change snmp to something else
## everywhere it appears in this file

epicsEnvSet("ENGINEER", "Larry Hoff x2194")
epicsEnvSet("LOCATION", "CSX (23IDA)")

epicsEnvSet("TOP", "$(PWD)/snmp")

epicsEnvSet("MIBDIRS", "$(PWD)/mibs")

## Register all support components
dbLoadDatabase("dbd/snmp2.dbd")
snmp2_registerRecordDeviceDriver(pdbbase)

## Load record instances

# Newer style 
dbLoadRecords("db/snmpWienerBnl.db" , "SYS=23IDA-CT, D=WienerCrate:VME2, IP = 10.23.2.21")
dbLoadRecords("db/snmpWienerBnl.db" , "SYS=23IDA-CT, D=WienerCrate:VME1, IP = 10.23.2.22")

# PDUs: These require snmp2 and the MIBs download package to be installed
dbLoadRecords("db/AP7900.db", "SYS=XF:23IDA-CT,DEV={RG:A2-PDU:1},IP=10.23.2.155"))
dbLoadRecords("db/AP7900.db", "SYS=XF:23IDA-CT,DEV={RG:B2-PDU:1},IP=10.23.2.156"))
dbLoadRecords("db/AP7900.db", "SYS=XF:23IDA-CT,DEV={RG:B2-PDU:2},IP=10.23.2.157"))
dbLoadRecords("db/AP7900.db", "SYS=XF:23ID1-CT,DEV={RG:C1-PDU:1},IP=10.23.2.158"))
dbLoadRecords("db/AP7900.db", "SYS=XF:23ID1-CT,DEV={RG:C1-PDU:2},IP=10.23.2.159"))
dbLoadRecords("db/AP7900.db", "SYS=XF:23ID1-CT,DEV={RG:C2-PDU:1},IP=10.23.2.160"))
dbLoadRecords("db/AP7900.db", "SYS=XF:23ID1-CT,DEV={RG:C2-PDU:2},IP=10.23.2.161"))
dbLoadRecords("db/AP7900.db", "SYS=XF:23ID1-CT,DEV={RG:D1-PDU:1},IP=10.23.2.162"))
dbLoadRecords("db/AP7900.db", "SYS=XF:23ID1-CT,DEV={RG:D1-PDU:2},IP=10.23.2.163"))
dbLoadRecords("db/AP7900.db", "SYS=XF:23ID1-CT,DEV={RG:D2-PDU:1},IP=10.23.2.164"))
dbLoadRecords("db/AP7900.db", "SYS=XF:23ID1-CT,DEV={RG:D2-PDU:2},IP=10.23.2.165"))
dbLoadRecords("db/AP7900.db", "SYS=XF:23ID1-CT,DEV={RG:E2-PDU:1},IP=10.23.2.166"))
dbLoadRecords("db/AP7900.db", "SYS=XF:23ID1-CT,DEV={RG:E2-PDU:2},IP=10.23.2.167"))
dbLoadRecords("db/AP8959.db", "SYS=XF:23ID1-CT,DEV={RG:E3-PDU:1},IP=10.23.2.169"))
dbLoadRecords("db/AP7930.db", "SYS=XF:23ID1-CT,DEV={RG:E3-PDU:2},IP=10.23.2.151"))

## Set this to see messages from mySub
#var mySubDebug 1
SNMP_DRV_DEBUG(0)
SNMP_DEV_DEBUG(0)

# Each SNMP query message could query multi variables.
# This number needs to be the minimum one of all your agents
snmpMaxVarsPerMsg(30)

dbLoadRecords("db/iocAdminSoft.db", "IOC=23ID:CS{IOC:SNMP}")
dbLoadRecords("db/save_restoreStatus.db", "P=23ID:CS{IOC:SNMP}")

set_savefile_path("${TOP}/as","/save")
set_requestfile_path("${TOP}/as","/req")

set_pass0_restoreFile("snmp_settings.sav")
set_pass1_restoreFile("snmp_settings.sav")

iocInit()

#caPutLogInit("10.0.152.133:7004")


makeAutosaveFileFromDbInfo("as/req/snmp_settings.req", "autosaveFields")
create_monitor_set("snmp_settings.req", 10 , "")

dbl > records.dbl
system "cp records.dbl /cf-update/x23ida-ioc1.SNMP.dbl"
