TOP=../..

include $(TOP)/configure/CONFIG
#----------------------------------------
#  ADD MACRO DEFINITIONS AFTER THIS LINE
#=============================

#=============================
# Build the IOC application

PROD_IOC = smaract
# smaract.dbd will be created and installed
DBD += smaract.dbd

# smaract.dbd will be made up from these files:
smaract_DBD += base.dbd

# Include dbd files from all support applications:
smaract_DBD += asyn.dbd
smaract_DBD += motorSupport.dbd
smaract_DBD += drvAsynIPPort.dbd
smaract_DBD += drvAsynSerialPort.dbd
smaract_DBD += devSmarActMCSMotor.dbd
smaract_DBD += asSupport.dbd
smaract_DBD += calcSupport.dbd


# Add all the support libraries needed by this IOC
smaract_LIBS += smarActMCSMotor motor asyn autosave calc

# smaract_registerRecordDeviceDriver.cpp derives from smaract.dbd
smaract_SRCS += smaract_registerRecordDeviceDriver.cpp

# Build the main IOC entry point on workstation OSs.
smaract_SRCS_DEFAULT += smaractMain.cpp
smaract_SRCS_vxWorks += -nil-

# Add support from base/src/vxWorks if needed
#smaract_OBJS_vxWorks += $(EPICS_BASE_BIN)/vxComLibrary

# Finally link to the EPICS Base libraries
smaract_LIBS += $(EPICS_BASE_IOC_LIBS)

#===========================

include $(TOP)/configure/RULES
#----------------------------------------
#  ADD RULES AFTER THIS LINE

