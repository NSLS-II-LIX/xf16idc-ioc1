TOP=../..

include $(TOP)/configure/CONFIG
#----------------------------------------
#  ADD MACRO DEFINITIONS AFTER THIS LINE
#=============================

#=============================
# Build the IOC application

PROD_IOC = misc
# misc.dbd will be created and installed
DBD += misc.dbd

# misc.dbd will be made up from these files:
misc_DBD += base.dbd

# Include dbd files from all support applications:
#misc_DBD += xxx.dbd

# Add all the support libraries needed by this IOC
#misc_LIBS += xxx

# misc_registerRecordDeviceDriver.cpp derives from misc.dbd
misc_SRCS += misc_registerRecordDeviceDriver.cpp

# Build the main IOC entry point on workstation OSs.
misc_SRCS_DEFAULT += miscMain.cpp
misc_SRCS_vxWorks += -nil-

# Add support from base/src/vxWorks if needed
#misc_OBJS_vxWorks += $(EPICS_BASE_BIN)/vxComLibrary

# Finally link to the EPICS Base libraries
misc_LIBS += $(EPICS_BASE_IOC_LIBS)

#===========================

include $(TOP)/configure/RULES
#----------------------------------------
#  ADD RULES AFTER THIS LINE

