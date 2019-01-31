#!../../bin/linux-x86_64/fts

< envPaths

cd $(TOP)

epicsEnvSet("ENGINEER",                "Stu Myers")
epicsEnvSet("LOCATION",                "XF:16IDC")
epicsEnvSet("EPICS_CA_AUTO_ADDR_LIST", "NO")
epicsEnvSet("EPICS_CA_ADDR_LIST",      "10.16.0.255")
epicsEnvSet("STREAM_PROTOCOL_PATH",    "ftsApp/Db")
epicsEnvSet("PREFIX",                  "XF:17ID-ES:LIX")
#epicsEnvSet("FTS_IP",                  "xf16idc-fts1:49151")
epicsEnvSet("FTS_IP",                  "10.16.2.194:49151")
epicsEnvSet("PORT",                    "FTS")

dbLoadDatabase("dbd/fts.dbd",0,0)
fts_registerRecordDeviceDriver(pdbbase) 

drvAsynIPPortConfigure("$(PORT)", "$(FTS_IP)")
dbLoadRecords("db/fts.db","P=$(PREFIX),R={FTS:1},PORT=$(PORT)")

iocInit()

#dbpf $(PREFIX){FTS:1}ReadCalib-Cmd.PROC 1
