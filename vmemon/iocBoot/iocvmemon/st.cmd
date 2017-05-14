#!../../bin/linux-x86_64/snmp
## You may have to change snmp to something else
## everywhere it appears in this file

epicsEnvSet("TOP","/epics/iocs/vmemon")
epicsEnvSet("IOC", "iocvmemon")
cd /epics/iocs/vmemon

epicsEnvSet("ENGINEER", "Oksana Ivashkevych x7028")
epicsEnvSet("LOCATION", "XF16ID Rack Group C2")
epicsEnvSet("MIBDIRS", "$(PWD)/mibs")
epicsEnvSet("MIBS", "WIENER-CRATE-MIB")
#epicsEnvSet("TOP", "$(PWD)")

## Register all support components
dbLoadDatabase("dbd/snmp.dbd")
snmp_registerRecordDeviceDriver(pdbbase)

## Load record instances

# Newer style in ISB
dbLoadRecords("db/wiener-bnl.db" , "SYS=XF16ID-CS, D=WienerCrate:C2, IP = 10.16.2.21")

# IOC Admin
dbLoadRecords("db/iocAdminSoft.db", "IOC=XF:16IDC-CT{IOC:SNMP}")
dbLoadRecords("db/save_restoreStatus.db", "P=XF:16IDC-CT{IOC:SNMP}")

## Set this to see messages from mySub
#var mySubDebug 1

# Set path to access control file, if present
#asSetFilename("/epics/iocs/CtrSwitch-log.acf") 
#asSetSubstitutions("P=CtrlSwitch:")

set_savefile_path("${TOP}/as","/save")
set_requestfile_path("${TOP}/as","/req")

set_pass0_restoreFile("snmp_settings.sav")
set_pass1_restoreFile("snmp_settings.sav")

iocInit()
epicsSnmpInit()

# Specify beamline caputlog server and port, if present
#caPutLogInit("")

makeAutosaveFileFromDbInfo("as/req/snmp_settings.req", "autosaveFields")
create_monitor_set("snmp_settings.req", 10 , "")

dbl > records.dbl
system "cp records.dbl /cf-update/xf16idc-ioc1.vmemon.dbl"
