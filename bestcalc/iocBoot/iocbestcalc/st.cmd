#!../../bin/linux-x86_64/bestcalc

## You may have to change bestcalc to something else
## everywhere it appears in this file

epicsEnvSet("ENGINEER", "LIX")
epicsEnvSet("LOCATION", "XF:16{RG:C1}")
epicsEnvSet("EPICS_CA_AUTO_ADDR_LIST", "NO")
epicsEnvSet("EPICS_CA_ADDR_LIST", "10.16.0.255")

#< envPaths

## Register all support components
dbLoadDatabase("../../dbd/bestcalc.dbd",0,0)
bestcalc_registerRecordDeviceDriver(pdbbase) 

## Load record instances
dbLoadRecords("../../db/bestcalc.db","user=softioc,P=XF:16IDB-CT{Best}")

iocInit()

## Start any sequence programs
#seq sncbestcalc,"user=softioc"
