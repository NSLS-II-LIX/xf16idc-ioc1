#!../../bin/linux-x86/snmp
##!../../bin/linux-x86/UPS_IOC

## You may have to change UPS_IOC to something else
## everywhere it appears in this file

< envPaths
cd ${TOP}
epicsEnvSet("MIBDIRS","$(PWD)/mibs")
epicsSnmpSetSnmpVersion("10.0.130.40","SNMP_VERSION_1")
epicsSnmpSetSnmpVersion("10.0.145.1","SNMP_VERSION_1")
epicsSnmpSetSnmpVersion("10.0.145.2","SNMP_VERSION_1")
epicsSnmpSetSnmpVersion("10.0.145.3","SNMP_VERSION_1")
epicsSnmpSetSnmpVersion("10.0.145.4","SNMP_VERSION_1")
epicsSnmpSetSnmpVersion("10.0.145.5","SNMP_VERSION_1")
epicsSnmpSetSnmpVersion("10.0.145.6","SNMP_VERSION_1")
epicsSnmpSetSnmpVersion("10.0.145.7","SNMP_VERSION_1")
epicsSnmpSetSnmpVersion("10.0.145.8","SNMP_VERSION_1")
epicsSnmpSetSnmpVersion("10.0.145.9","SNMP_VERSION_1")
epicsSnmpSetSnmpVersion("10.0.145.10","SNMP_VERSION_1")
epicsSnmpSetSnmpVersion("10.0.145.11","SNMP_VERSION_1")
epicsSnmpSetSnmpVersion("10.0.145.12","SNMP_VERSION_1")
epicsSnmpSetSnmpVersion("10.0.145.13","SNMP_VERSION_1")
epicsSnmpSetSnmpVersion("10.0.145.14","SNMP_VERSION_1")
epicsSnmpSetSnmpVersion("10.0.145.15","SNMP_VERSION_1")
epicsSnmpSetSnmpVersion("10.0.145.16","SNMP_VERSION_1")
epicsSnmpSetSnmpVersion("10.0.145.17","SNMP_VERSION_1")
epicsSnmpSetSnmpVersion("10.0.145.18","SNMP_VERSION_1")
epicsSnmpSetSnmpVersion("10.0.145.19","SNMP_VERSION_1")
epicsSnmpSetSnmpVersion("10.0.145.20","SNMP_VERSION_1")
epicsSnmpSetSnmpVersion("10.0.145.21","SNMP_VERSION_1")
epicsSnmpSetSnmpVersion("10.0.145.22","SNMP_VERSION_1")
epicsSnmpSetSnmpVersion("10.0.145.23","SNMP_VERSION_1")
epicsSnmpSetSnmpVersion("10.0.145.24","SNMP_VERSION_1")
epicsSnmpSetSnmpVersion("10.0.145.25","SNMP_VERSION_1")
epicsSnmpSetSnmpVersion("10.0.145.26","SNMP_VERSION_1")
epicsSnmpSetSnmpVersion("10.0.145.27","SNMP_VERSION_1")
epicsSnmpSetSnmpVersion("10.0.145.28","SNMP_VERSION_1")
epicsSnmpSetSnmpVersion("10.0.145.29","SNMP_VERSION_1")
epicsSnmpSetSnmpVersion("10.0.145.30","SNMP_VERSION_1")
epicsSnmpSetSnmpVersion("10.0.145.31","SNMP_VERSION_1")
epicsSnmpSetSnmpVersion("10.0.145.32","SNMP_VERSION_1")
epicsSnmpSetSnmpVersion("10.0.145.33","SNMP_VERSION_1")
epicsSnmpSetSnmpVersion("10.0.145.34","SNMP_VERSION_1")
epicsSnmpSetSnmpVersion("10.0.145.35","SNMP_VERSION_1")
epicsSnmpSetSnmpVersion("10.0.145.36","SNMP_VERSION_1")
epicsSnmpSetSnmpVersion("10.0.145.37","SNMP_VERSION_1")
epicsSnmpSetSnmpVersion("10.0.145.38","SNMP_VERSION_1")
epicsSnmpSetSnmpVersion("10.0.145.39","SNMP_VERSION_1")
epicsSnmpSetSnmpVersion("10.0.145.40","SNMP_VERSION_1")
epicsSnmpSetSnmpVersion("10.0.145.41","SNMP_VERSION_1")
epicsSnmpSetSnmpVersion("10.0.145.42","SNMP_VERSION_1")
epicsSnmpSetSnmpVersion("10.0.145.43","SNMP_VERSION_1")
epicsSnmpSetSnmpVersion("10.0.145.44","SNMP_VERSION_1")
epicsSnmpSetSnmpVersion("10.0.145.45","SNMP_VERSION_1")
epicsSnmpSetSnmpVersion("10.0.145.60","SNMP_VERSION_1")
## Register all support components
dbLoadDatabase("dbd/snmp.dbd",0,0)
snmp_registerRecordDeviceDriver(pdbbase) 

## Load record instances
dbLoadRecords("db/ToshibaUPS.db")
dbLoadRecords("db/MitsubishiUPS.db")
dbLoadRecords("db/ToshibaUPSEyeIII.db")


iocInit()
epicsSnmpInit

## Start any sequence programs
#seq sncUPS_IOC,"user=jdalesio"
