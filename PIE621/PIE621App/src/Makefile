TOP=../..

include $(TOP)/configure/CONFIG
#----------------------------------------
#  ADD MACRO DEFINITIONS AFTER THIS LINE
#=============================

#=============================
# Build the IOC application

PROD_IOC = PIE621
# PIE621.dbd will be created and installed
DBD += PIE621.dbd

# PIE621.dbd will be made up from these files:
PIE621_DBD += base.dbd

# Include dbd files from all support applications:
#PIE621_DBD += xxx.dbd
PIE621_DBD += asyn.dbd
PIE621_DBD += drvAsynIPPort.dbd
PIE621_DBD += drvAsynSerialPort.dbd
PIE621_DBD += stream.dbd
PIE621_DBD += calcSupport.dbd
# Motor support
PIE621_DBD += motorSupport.dbd
PIE621_DBD += devPIMotor.dbd
# Autosave
PIE621_DBD += asSupport.dbd 
# St
PIE621_DBD += devIocStats.dbd


# Add all the support libraries needed by this IOC
#PIE621_LIBS += xxx
PIE621_LIBS += asyn
PIE621_LIBS += stream
PIE621_LIBS += motor
PIE621_LIBS += PI
PIE621_LIBS += autosave
PIE621_LIBS += calc
PIE621_LIBS += sscan
PIE621_LIBS += devIocStats

# PIE621_registerRecordDeviceDriver.cpp derives from PIE621.dbd
PIE621_SRCS += PIE621_registerRecordDeviceDriver.cpp

# Build the main IOC entry point on workstation OSs.
PIE621_SRCS_DEFAULT += PIE621Main.cpp
PIE621_SRCS_vxWorks += -nil-

# Add support from base/src/vxWorks if needed
#PIE621_OBJS_vxWorks += $(EPICS_BASE_BIN)/vxComLibrary

# Finally link to the EPICS Base libraries
PIE621_LIBS += $(EPICS_BASE_IOC_LIBS)

#===========================

include $(TOP)/configure/RULES
#----------------------------------------
#  ADD RULES AFTER THIS LINE

