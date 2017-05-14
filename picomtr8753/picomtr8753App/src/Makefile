TOP=../..

include $(TOP)/configure/CONFIG
#----------------------------------------
#  ADD MACRO DEFINITIONS AFTER THIS LINE
#=============================

#=============================
# Build the IOC application

PROD_IOC = picomtr8753
# picomtr8753.dbd will be created and installed
DBD += picomtr8753.dbd

# picomtr8753.dbd will be made up from these files:
picomtr8753_DBD += base.dbd

# Include dbd files from all support applications:
#picomtr8753_DBD += xxx.dbd
picomtr8753_DBD += asyn.dbd
picomtr8753_DBD += drvAsynIPPort.dbd
picomtr8753_DBD += drvAsynSerialPort.dbd
#picomtr8753_DBD += stream.dbd
picomtr8753_DBD += calcSupport.dbd
# Motor Support
picomtr8753_DBD += motorSupport.dbd
picomtr8753_DBD += motorRecord.dbd
picomtr8753_DBD += devNewFocus.dbd
# Autosave
picomtr8753_DBD += asSupport.dbd
# St
picomtr8753_DBD += devIocStats.dbd

# Add all the support libraries needed by this IOC
#picomtr8753_LIBS += xxx

picomtr8753_LIBS += asyn
#picomtr8753_LIBS += stream
picomtr8753_LIBS += motor
picomtr8753_LIBS += autosave
picomtr8753_LIBS += calc
picomtr8753_LIBS += sscan
picomtr8753_LIBS += devIocStats
picomtr8753_LIBS += NewFocus


# picomtr8753_registerRecordDeviceDriver.cpp derives from picomtr8753.dbd
picomtr8753_SRCS += picomtr8753_registerRecordDeviceDriver.cpp

# Build the main IOC entry point on workstation OSs.
picomtr8753_SRCS_DEFAULT += picomtr8753Main.cpp
picomtr8753_SRCS_vxWorks += -nil-

# Add support from base/src/vxWorks if needed
#picomtr8753_OBJS_vxWorks += $(EPICS_BASE_BIN)/vxComLibrary

# Finally link to the EPICS Base libraries
picomtr8753_LIBS += $(EPICS_BASE_IOC_LIBS)

#===========================

include $(TOP)/configure/RULES
#----------------------------------------
#  ADD RULES AFTER THIS LINE

