#!bin/linux-x86-debug/snmp
## You may have to change snmp to something else
## everywhere it appears in this file

epicsEnvSet("ENGINEER", "Michael Davidsaver x3698")
epicsEnvSet("LOCATION", "Bldg 740 CR")

epicsEnvSet("TOP", "$(PWD)/snmp")

## Register all support components
dbLoadDatabase("dbd/snmp.dbd")
snmp_registerRecordDeviceDriver(pdbbase)

## Load record instances

# Older style
dbLoadRecords("db/wiener.db" , "SYS=INJ-CS, D=WienerCrate:Q3A, IP = 10.0.133.202")
dbLoadRecords("db/wiener.db" , "SYS=INJ-CS, D=WienerCrate:Q2A, IP = 10.0.133.203")

# Newer style in ISB
dbLoadRecords("db/wiener-bnl.db" , "SYS=BR-CS, D=WienerCrate:D3A, IP = 10.0.133.236")
dbLoadRecords("db/wiener-bnl.db" , "SYS=BR-CS, D=WienerCrate:P1A, IP = 10.0.133.249")

dbLoadRecords("db/wiener-bnl.db" , "SYS=BST-CS, D=WienerCrate:E1A, IP = 10.0.133.242")

dbLoadRecords("db/wiener-bnl.db" , "SYS=BR-CS, D=WienerCrate:B2A, IP = 10.0.133.252")
dbLoadRecords("db/wiener-bnl.db" , "SYS=BR-CS, D=WienerCrate:B2B, IP = 10.0.133.251")

dbLoadRecords("db/wiener-bnl.db" , "SYS=BR-CS, D=WienerCrate:A2A, IP = 10.0.132.38")
dbLoadRecords("db/wiener-bnl.db" , "SYS=BR-CS, D=WienerCrate:A3A, IP = 10.0.132.34")

## SR

dbLoadRecords("db/wiener-bnl.db" , "SYS=SR-CS, D=WienerCrate:CRB4, IP = 10.0.133.197")

## P2 (continued)

dbLoadRecords("db/wiener-bnl.db" , "SYS=SR:C01-CS, D=WienerCrate:D1, IP = 10.0.132.1")
dbLoadRecords("db/wiener-bnl.db" , "SYS=SR:C02-CS, D=WienerCrate:D1, IP = 10.0.132.2")
dbLoadRecords("db/wiener-bnl.db" , "SYS=SR:C03-CS, D=WienerCrate:D1, IP = 10.0.132.3")
dbLoadRecords("db/wiener-bnl.db" , "SYS=SR:C04-CS, D=WienerCrate:D1, IP = 10.0.132.4")

## P3

dbLoadRecords("db/wiener-bnl.db" , "SYS=SR:C05-CS, D=WienerCrate:D1, IP = 10.0.132.5")
dbLoadRecords("db/wiener-bnl.db" , "SYS=SR:C06-CS, D=WienerCrate:D1, IP = 10.0.132.6")
dbLoadRecords("db/wiener-bnl.db" , "SYS=SR:C07-CS, D=WienerCrate:D1, IP = 10.0.132.7")
dbLoadRecords("db/wiener-bnl.db" , "SYS=SR:C08-CS, D=WienerCrate:D1, IP = 10.0.132.8")
dbLoadRecords("db/wiener-bnl.db" , "SYS=SR:C09-CS, D=WienerCrate:D1, IP = 10.0.132.9")
dbLoadRecords("db/wiener-bnl.db" , "SYS=SR:C10-CS, D=WienerCrate:D1, IP = 10.0.132.10")

## P4

dbLoadRecords("db/wiener-bnl.db" , "SYS=SR:C11-CS, D=WienerCrate:D1, IP = 10.0.132.11")
dbLoadRecords("db/wiener-bnl.db" , "SYS=SR:C12-CS, D=WienerCrate:D1, IP = 10.0.132.12")
dbLoadRecords("db/wiener-bnl.db" , "SYS=SR:C13-CS, D=WienerCrate:D1, IP = 10.0.132.13")
dbLoadRecords("db/wiener-bnl.db" , "SYS=SR:C14-CS, D=WienerCrate:D1, IP = 10.0.132.14")
dbLoadRecords("db/wiener-bnl.db" , "SYS=SR:C15-CS, D=WienerCrate:D1, IP = 10.0.132.15")
dbLoadRecords("db/wiener-bnl.db" , "SYS=SR:C16-CS, D=WienerCrate:D1, IP = 10.0.132.16")

## P5

dbLoadRecords("db/wiener-bnl.db" , "SYS=SR:C17-CS, D=WienerCrate:D1, IP = 10.0.132.17")
dbLoadRecords("db/wiener-bnl.db" , "SYS=SR:C18-CS, D=WienerCrate:D1, IP = 10.0.132.18")
dbLoadRecords("db/wiener-bnl.db" , "SYS=SR:C19-CS, D=WienerCrate:D1, IP = 10.0.132.19")
dbLoadRecords("db/wiener-bnl.db" , "SYS=SR:C20-CS, D=WienerCrate:D1, IP = 10.0.132.20")
dbLoadRecords("db/wiener-bnl.db" , "SYS=SR:C21-CS, D=WienerCrate:D1, IP = 10.0.132.21")
dbLoadRecords("db/wiener-bnl.db" , "SYS=SR:C22-CS, D=WienerCrate:D1, IP = 10.0.132.22")

## P1
dbLoadRecords("db/wiener-bnl.db" , "SYS=SR:C23-CS, D=WienerCrate:D1, IP = 10.0.132.23")
dbLoadRecords("db/wiener-bnl.db" , "SYS=SR:C24-CS, D=WienerCrate:D1, IP = 10.0.132.24")
dbLoadRecords("db/wiener-bnl.db" , "SYS=SR:C25-CS, D=WienerCrate:D1, IP = 10.0.132.25")
dbLoadRecords("db/wiener-bnl.db" , "SYS=SR:C26-CS, D=WienerCrate:D1, IP = 10.0.132.26")
dbLoadRecords("db/wiener-bnl.db" , "SYS=SR:C27-CS, D=WienerCrate:D1, IP = 10.0.132.27")
dbLoadRecords("db/wiener-bnl.db" , "SYS=SR:C28-CS, D=WienerCrate:D1, IP = 10.0.132.28")

## P2

dbLoadRecords("db/wiener-bnl.db" , "SYS=SR:C29-CS, D=WienerCrate:D1, IP = 10.0.132.29")
dbLoadRecords("db/wiener-bnl.db" , "SYS=SR:C30-CS, D=WienerCrate:D1, IP = 10.0.132.30")

# Extras
dbLoadRecords("db/wiener-bnl.db" , "SYS=SR:C15-CS, D=WienerCrate:G2, IP = 10.0.132.59")
dbLoadRecords("db/wiener-bnl.db" , "SYS=SR:C21-CS, D=WienerCrate:G2, IP = 10.0.132.45")
dbLoadRecords("db/wiener-bnl.db" , "SYS=SR:C28-CS, D=WienerCrate:G1, IP = 10.0.132.72")
dbLoadRecords("db/wiener-bnl.db" , "SYS=SR:C29-CS, D=WienerCrate:F1, IP = 10.0.132.66")
dbLoadRecords("db/wiener-bnl.db" , "SYS=SR:C30-CS, D=WienerCrate:G2, IP = 10.0.132.57")
dbLoadRecords("db/wiener-bnl.db" , "SYS=SR:C30-CS, D=WienerCrate:Q2, IP = 10.0.132.49")

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

dbl > records.dbl
system "cp records.dbl /cf-update/1wire-cr-rga.SNMP.dbl"
