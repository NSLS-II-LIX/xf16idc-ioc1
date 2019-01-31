TOP=../..

include $(TOP)/configure/CONFIG
#----------------------------------------
#  ADD MACRO DEFINITIONS AFTER THIS LINE
#=============================

#=============================
# Build the IOC application

PROD_IOC = PSJena
# PSJena.dbd will be created and installed
DBD += PSJena.dbd

# PSJena.dbd will be made up from these files:
PSJena_DBD += base.dbd

# Include dbd files from all support applications:
#PSJena_DBD += xxx.dbd
PSJena_DBD += asyn.dbd
PSJena_DBD += drvAsynIPPort.dbd
PSJena_DBD += drvAsynSerialPort.dbd
PSJena_DBD += stream.dbd
PSJena_DBD += calcSupport.dbd
# Motor Support
PSJena_DBD += motorSupport.dbd
PSJena_DBD += devPIJena.dbd
# Autosave
PSJena_DBD += asSupport.dbd
# St
PSJena_DBD += devIocStats.dbd

# Add all the support libraries needed by this IOC
#PSJena_LIBS += xxx
PSJena_LIBS += asyn
PSJena_LIBS += stream
PSJena_LIBS += motor
PSJena_LIBS += PIJena
PSJena_LIBS += autosave
PSJena_LIBS += calc
PSJena_LIBS += sscan
PSJena_LIBS += devIocStats

# PSJena_registerRecordDeviceDriver.cpp derives from PSJena.dbd
PSJena_SRCS += PSJena_registerRecordDeviceDriver.cpp

# Build the main IOC entry point on workstation OSs.
PSJena_SRCS_DEFAULT += PSJenaMain.cpp
PSJena_SRCS_vxWorks += -nil-

# Add support from base/src/vxWorks if needed
#PSJena_OBJS_vxWorks += $(EPICS_BASE_BIN)/vxComLibrary

# Finally link to the EPICS Base libraries
PSJena_LIBS += $(EPICS_BASE_IOC_LIBS)

#===========================

include $(TOP)/configure/RULES
#----------------------------------------
#  ADD RULES AFTER THIS LINE

