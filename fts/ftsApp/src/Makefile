TOP=../..

include $(TOP)/configure/CONFIG
#----------------------------------------
#  ADD MACRO DEFINITIONS AFTER THIS LINE
#=============================

#=============================
# Build the IOC application

PROD_IOC = fts
DBD += fts.dbd

fts_DBD += base.dbd
fts_DBD += asyn.dbd
fts_DBD += drvAsynIPPort.dbd
fts_DBD += stream.dbd
fts_DBD += asSupport.dbd
fts_DBD += devIocStats.dbd
fts_DBD += menuScan.dbd

fts_LIBS += asyn stream autosave devIocStats

fts_SRCS += fts_registerRecordDeviceDriver.cpp

fts_SRCS_DEFAULT += ftsMain.cpp
fts_SRCS_vxWorks += -nil-

#fts_OBJS_vxWorks += $(EPICS_BASE_BIN)/vxComLibrary

fts_LIBS += $(EPICS_BASE_IOC_LIBS)

include $(TOP)/configure/RULES

