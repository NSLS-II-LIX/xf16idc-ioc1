#!../../bin/linux-x86_64/misc

< envPaths

epicsEnvSet("EPICS_CA_AUTO_ADDR_LIST", "NO")
epicsEnvSet("EPICS_CA_ADDR_LIST",      "10.16.0.255")

dbLoadDatabase("../../dbd/misc.dbd",0,0)
misc_registerRecordDeviceDriver(pdbbase) 

dbLoadRecords("../../db/Gonio_Motions.db","P=XF:16IDC-ES{ClkCtr}")
dbLoadRecords("../../db/cb_params_office.db","P=XF:16IDC-ES{Comm}")
dbLoadRecords("../../db/misc.db","P=XF:16IDC-ES")
dbLoadRecords("../../db/thresholds.db","P=XF:16IDC-ES")

iocInit()
