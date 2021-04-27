#!../../bin/linux-x86_64/bestcalc

## You may have to change bestcalc to something else
## everywhere it appears in this file

epicsEnvSet("ENGINEER", "LIX")
epicsEnvSet("LOCATION", "XF:16{RG:C1}")

#< envPaths

## Register all support components
dbLoadDatabase("../../dbd/bestcalc.dbd",0,0)
bestcalc_registerRecordDeviceDriver(pdbbase) 

## Load record instances
dbLoadRecords("../../db/bestcalc.db","user=softioc,P=XF:16IDB-CT{Best}")

< /epics/common/xf16idc-ioc1-netsetup.cmd
iocInit()

## Start any sequence programs
#seq sncbestcalc,"user=softioc"
