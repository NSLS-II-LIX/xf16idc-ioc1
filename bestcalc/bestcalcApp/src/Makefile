TOP=../..

include $(TOP)/configure/CONFIG
#----------------------------------------
#  ADD MACRO DEFINITIONS AFTER THIS LINE
#=============================

#=============================
# Build the IOC application

PROD_IOC = bestcalc
# bestcalc.dbd will be created and installed
DBD += bestcalc.dbd

# bestcalc.dbd will be made up from these files:
bestcalc_DBD += base.dbd

# Include dbd files from all support applications:
bestcalc_DBD += calcSupport.dbd

# Add all the support libraries needed by this IOC
bestcalc_LIBS += calc

# bestcalc_registerRecordDeviceDriver.cpp derives from bestcalc.dbd
bestcalc_SRCS += bestcalc_registerRecordDeviceDriver.cpp

# Build the main IOC entry point on workstation OSs.
bestcalc_SRCS_DEFAULT += bestcalcMain.cpp
bestcalc_SRCS_vxWorks += -nil-

# Add support from base/src/vxWorks if needed
#bestcalc_OBJS_vxWorks += $(EPICS_BASE_BIN)/vxComLibrary

# Finally link to the EPICS Base libraries
bestcalc_LIBS += $(EPICS_BASE_IOC_LIBS)

#===========================

include $(TOP)/configure/RULES
#----------------------------------------
#  ADD RULES AFTER THIS LINE

