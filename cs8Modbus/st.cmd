#!/epics/src/modbus/bin/linux-x86_64/modbusApp

epicsEnvSet("EPICS_CA_AUTO_ADDR_LIST", 	"NO")
epicsEnvSet("EPICS_CA_ADDR_LIST", 	"10.16.0.255 10.16.3.255")

epicsEnvSet("MODBUS",	"/epics/src/modbus")
epicsEnvSet("CS8IP",	"10.16.2.192")
#epicsEnvSet("CS8IP",	"xf16idc-robot1")
epicsEnvSet("PREFIX",	"XF:16IDC-ES:LIX{CS8}")
epicsEnvSet("IOSCAN",    "I/O Intr")

dbLoadDatabase("$(MODBUS)/dbd/modbus.dbd")
modbus_registerRecordDeviceDriver(pdbbase)

drvAsynIPPortConfigure("TX40-CS8",    "$(CS8IP):502", 0, 0, 1)

modbusInterposeConfig("TX40-CS8", 0, 0, 0)

# Name, Asyn port, Slave addr, Function code, Address offset, Address len, Data type (0=UINT16,4=INT16), Poll (ms), PLC type
drvModbusAsynConfigure("LIX-WRITE2DI", "TX40-CS8", "0", "5", "0x0000", "64", "0", "500", "CS8")
drvModbusAsynConfigure("LIX-READDO",   "TX40-CS8", "0", "1", "0x0040", "32", "0", "500", "CS8")
drvModbusAsynConfigure("LIX-WRITE2AI", "TX40-CS8", "0", "6", "0x0000", "16", "0", "500", "CS8")
drvModbusAsynConfigure("LIX-WRITE2AIF","TX40-CS8", "0", "16","0x0010", "32", "7", "500", "CS8")
drvModbusAsynConfigure("LIX-READAOF",  "TX40-CS8", "0", "3", "0x0030", "16", "7", "500", "CS8")


# Read from Epics bi and Write to CS8 digital inputs
dbLoadRecords("cs8bi.template", "P=$(PREFIX),   PORT=LIX-WRITE2DI,INP=XF:16IDC-ES:LIX{FTS:1}Status-I,	    OFFSET=0x01,R=Collission")
dbLoadRecords("cs8bi.template",	"P=$(PREFIX),	PORT=LIX-WRITE2DI,INP=XF:16IDC-ES:Sol{ctrl}HolderPresent,   OFFSET=0x02,R=StageStatus")
dbLoadRecords("ai2bi.template", "P=$(PREFIX),   PORT=LIX-WRITE2DI,INPA=XF:16IDC-ES:Sol{ctrl}EMSolReady,     INPB=XF:16IDC-ES:Sol{ctrl}EMSolReady, CALC=(A==1),OFFSET=0x03,R=StageReady")
dbLoadRecords("ai2bi.template", "P=$(PREFIX),	PORT=LIX-WRITE2DI,INPA=XF:16IDC-ES:Chalet{ctrl}drlimit1_sts,INPB=XF:16IDC-ES:Chalet{ctrl}drlimit2_sts,   CALC=(A==1&B==0),	OFFSET=0x04,R=StorageReady")

dbLoadRecords("cs8bi.template", "P=$(PREFIX),	PORT=LIX-WRITE2DI,INP=XF:16IDC-ES:Chalet{ctrl}tray01_sts,	OFFSET=0x20,R=Tray1Sts")
dbLoadRecords("cs8bi.template", "P=$(PREFIX),	PORT=LIX-WRITE2DI,INP=XF:16IDC-ES:Chalet{ctrl}tray02_sts,	OFFSET=0x21,R=Tray2Sts")
dbLoadRecords("cs8bi.template", "P=$(PREFIX),	PORT=LIX-WRITE2DI,INP=XF:16IDC-ES:Chalet{ctrl}tray03_sts,	OFFSET=0x22,R=Tray3Sts")
dbLoadRecords("cs8bi.template", "P=$(PREFIX),	PORT=LIX-WRITE2DI,INP=XF:16IDC-ES:Chalet{ctrl}tray04_sts,	OFFSET=0x23,R=Tray4Sts")
dbLoadRecords("cs8bi.template", "P=$(PREFIX),	PORT=LIX-WRITE2DI,INP=XF:16IDC-ES:Chalet{ctrl}tray05_sts,	OFFSET=0x24,R=Tray5Sts")
dbLoadRecords("cs8bi.template", "P=$(PREFIX),	PORT=LIX-WRITE2DI,INP=XF:16IDC-ES:Chalet{ctrl}tray06_sts,	OFFSET=0x25,R=Tray6Sts")
dbLoadRecords("cs8bi.template", "P=$(PREFIX),	PORT=LIX-WRITE2DI,INP=XF:16IDC-ES:Chalet{ctrl}tray07_sts,	OFFSET=0x26,R=Tray7Sts")
dbLoadRecords("cs8bi.template", "P=$(PREFIX),	PORT=LIX-WRITE2DI,INP=XF:16IDC-ES:Chalet{ctrl}tray08_sts,	OFFSET=0x27,R=Tray8Sts")
dbLoadRecords("cs8bi.template", "P=$(PREFIX),	PORT=LIX-WRITE2DI,INP=XF:16IDC-ES:Chalet{ctrl}tray09_sts,	OFFSET=0x28,R=Tray9Sts")
dbLoadRecords("cs8bi.template", "P=$(PREFIX),	PORT=LIX-WRITE2DI,INP=XF:16IDC-ES:Chalet{ctrl}tray10_sts,	OFFSET=0x29,R=Tray10Sts")
dbLoadRecords("cs8bi.template", "P=$(PREFIX),	PORT=LIX-WRITE2DI,INP=XF:16IDC-ES:Chalet{ctrl}tray11_sts,	OFFSET=0x2A,R=Tray11Sts")
dbLoadRecords("cs8bi.template", "P=$(PREFIX),	PORT=LIX-WRITE2DI,INP=XF:16IDC-ES:Chalet{ctrl}tray12_sts,	OFFSET=0x2B,R=Tray12Sts")
dbLoadRecords("cs8bi.template", "P=$(PREFIX),	PORT=LIX-WRITE2DI,INP=XF:16IDC-ES:Chalet{ctrl}tray13_sts,	OFFSET=0x2C,R=Tray13Sts")
dbLoadRecords("cs8bi.template", "P=$(PREFIX),	PORT=LIX-WRITE2DI,INP=XF:16IDC-ES:Chalet{ctrl}tray14_sts,	OFFSET=0x2D,R=Tray14Sts")
dbLoadRecords("cs8bi.template", "P=$(PREFIX),	PORT=LIX-WRITE2DI,INP=XF:16IDC-ES:Chalet{ctrl}tray15_sts,	OFFSET=0x2E,R=Tray15Sts")
dbLoadRecords("cs8bi.template", "P=$(PREFIX),	PORT=LIX-WRITE2DI,INP=XF:16IDC-ES:Chalet{ctrl}tray16_sts,	OFFSET=0x2F,R=Tray16Sts")
dbLoadRecords("cs8bi.template", "P=$(PREFIX),	PORT=LIX-WRITE2DI,INP=XF:16IDC-ES:Chalet{ctrl}tray17_sts,	OFFSET=0x30,R=Tray17Sts")
dbLoadRecords("cs8bi.template", "P=$(PREFIX),	PORT=LIX-WRITE2DI,INP=XF:16IDC-ES:Chalet{ctrl}tray18_sts,	OFFSET=0x31,R=Tray18Sts")
dbLoadRecords("cs8bi.template", "P=$(PREFIX),	PORT=LIX-WRITE2DI,INP=XF:16IDC-ES:Chalet{ctrl}tray19_sts,	OFFSET=0x32,R=Tray19Sts")
dbLoadRecords("cs8bi.template", "P=$(PREFIX),	PORT=LIX-WRITE2DI,INP=XF:16IDC-ES:Chalet{ctrl}tray20_sts,	OFFSET=0x33,R=Tray20Sts")
dbLoadRecords("cs8bi.template", "P=$(PREFIX),	PORT=LIX-WRITE2DI,INP=XF:16IDC-ES:Chalet{ctrl}drlimit1_sts,	OFFSET=0x34,R=DoorOpenSts")
dbLoadRecords("cs8bi.template", "P=$(PREFIX),	PORT=LIX-WRITE2DI,INP=XF:16IDC-ES:Chalet{ctrl}drlimit2_sts,	OFFSET=0x35,R=DoorCloseSts")



# Read from CS8 digital outputs and Write to Epics bo
dbLoadRecords("cs8bo.template", "P=$(PREFIX),   PORT=LIX-READDO,SCAN=$(IOSCAN),OFFSET=0x00,     OUTPUT=XF:16IDC-ES:Chalet{ctrl}door_sel, R=Door")
#dbLoadRecords("cs8bo.template", "P=$(PREFIX),   PORT=LIX-READDO,SCAN=$(IOSCAN),OFFSET=0x01,     OUTPUT=XF:16IDC-ES:LIX,                 R=StageRest")
#dbLoadRecords("cs8bo.template", "P=$(PREFIX),   PORT=LIX-READDO,SCAN=$(IOSCAN),OFFSET=0x02,     OUTPUT=XF:16IDC-ES:LIX,                 R=StorageReset")


# Read analog inputs from Epics and Write to CS8
dbLoadRecords("cs8ai.template", "P=$(PREFIX),PORT=LIX-WRITE2AIF,INP=XF:16IDC-ES:LIX{FTS:1}ForceX-I,       	PREC=5,OFFSET=0x00, R=Fx")
dbLoadRecords("cs8ai.template", "P=$(PREFIX),PORT=LIX-WRITE2AIF,INP=XF:16IDC-ES:LIX{FTS:1}ForceY-I,       	PREC=5,OFFSET=0x02, R=Fy")
dbLoadRecords("cs8ai.template", "P=$(PREFIX),PORT=LIX-WRITE2AIF,INP=XF:16IDC-ES:LIX{FTS:1}ForceZ-I,       	PREC=5,OFFSET=0x04, R=Fz")
dbLoadRecords("cs8ai.template", "P=$(PREFIX),PORT=LIX-WRITE2AIF,INP=XF:16IDC-ES:LIX{FTS:1}TorqueX-I,       	PREC=5,OFFSET=0x06, R=Tx")
dbLoadRecords("cs8ai.template", "P=$(PREFIX),PORT=LIX-WRITE2AIF,INP=XF:16IDC-ES:LIX{FTS:1}TorqueY-I,       	PREC=5,OFFSET=0x08, R=Ty")
dbLoadRecords("cs8ai.template", "P=$(PREFIX),PORT=LIX-WRITE2AIF,INP=XF:16IDC-ES:LIX{FTS:1}TorqueZ-I,       	PREC=5,OFFSET=0x0A, R=Tz")




iocInit()


