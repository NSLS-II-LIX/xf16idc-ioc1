epicsEnvSet("PREFIX",    "XF:16IDC-ES")
epicsEnvSet("RECORD",    "{TETRAMM:1}")
epicsEnvSet("PORT",      "TetrAMM")
epicsEnvSet("TEMPLATE",  "TetrAMM")
epicsEnvSet("QSIZE",     "20")
epicsEnvSet("RING_SIZE", "10000")
epicsEnvSet("TSPOINTS",  "2048")
epicsEnvSet("IP",        "10.16.2.171:10001")

#drvAsynIPPortConfigure("portName","hostInfo",priority,noAutoConnect,
#                        noProcessEos)
drvAsynIPPortConfigure("IP_$(PORT)", "$(IP)", 0, 0, 0)
asynOctetSetInputEos("IP_$(PORT)",  0, "\r\n")
asynOctetSetOutputEos("IP_$(PORT)", 0, "\r")

# Set both TRACE_IO_ESCAPE (for ASCII command/response) and TRACE_IO_HEX (for binary data)
asynSetTraceIOMask("IP_$(PORT)", 0, 6)
#asynSetTraceFile("IP_$(PORT)",   0, "AHxxx.out")
#asynSetTraceMask("IP_$(PORT)",   0,  9)
asynSetTraceIOTruncateSize("IP_$(PORT)", 0, 4000)

# Load asynRecord record
dbLoadRecords("$(ASYN)/db/asynRecord.db", "P=$(PREFIX), R=asyn1,PORT=IP_$(PORT),ADDR=0,OMAX=256,IMAX=256")

drvTetrAMMConfigure("$(PORT)", "IP_$(PORT)", $(RING_SIZE))
dbLoadRecords("$(QUADEM)/db/$(TEMPLATE).template", "P=$(PREFIX), R=$(RECORD), PORT=$(PORT)")

< commonPlugins.cmd

asynSetTraceIOMask("$(PORT)",0,2)
#asynSetTraceMask("$(PORT)",  0,9)

< saveRestore.cmd

iocInit()

# save settings every thirty seconds
create_monitor_set("auto_settings.req",30,"P=$(PREFIX), R=$(RECORD)")
