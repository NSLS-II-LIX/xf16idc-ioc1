epicsEnvSet("PREFIX",    "XF:16IDC-ES")
epicsEnvSet("RECORD",    "{NSLS_EM:1}")
epicsEnvSet("PORT",      "NSLS_EM")
epicsEnvSet("TEMPLATE",  "NSLS_EM")
epicsEnvSet("QSIZE",     "20")
epicsEnvSet("RING_SIZE", "10000")
epicsEnvSet("TSPOINTS",  "1000")
epicsEnvSet("BROADCAST", "10.16.2.173")
epicsEnvSet("MODULE_ID", "0")

# Load asynRecord record
dbLoadRecords("$(ASYN)/db/asynRecord.db", "P=$(PREFIX), R=$(RECORD)asyn1,PORT=TCP_Command_$(PORT),ADDR=0,OMAX=256,IMAX=256")

drvNSLS_EMConfigure("$(PORT)", "$(BROADCAST)", $(MODULE_ID), $(RING_SIZE))

asynSetTraceIOMask("UDP_$(PORT)", 0, 2)
asynSetTraceMask("UDP_$(PORT)", 0, 9)
asynSetTraceIOMask("TCP_Command_$(PORT)", 0, 2)
#asynSetTraceMask("TCP_Command_$(PORT)", 0, 9)
asynSetTraceIOMask("TCP_Data_$(PORT)", 0, 2)
#asynSetTraceMask("TCP_Data_$(PORT)", 0, 9)

dbLoadRecords("$(QUADEM)/db/$(TEMPLATE).template", "P=$(PREFIX), R=$(RECORD), PORT=$(PORT)")

< commonPlugins.cmd

asynSetTraceIOMask("$(PORT)",0,2)
#asynSetTraceMask("$(PORT)",  0,9)

< saveRestore.cmd

iocInit()

# save settings every thirty seconds
create_monitor_set("auto_settings.req",30,"P=$(PREFIX), R=$(RECORD)")
