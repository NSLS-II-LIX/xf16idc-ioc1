TOP=../..

include $(TOP)/configure/CONFIG
#----------------------------------------
#  ADD MACRO DEFINITIONS AFTER THIS LINE
#=============================
#USR_CFLAGS += -I/usr/local/include        #Path to snmp if ness.
USR_CFLAGS += `net-snmp-config --cflags`
USR_CFLAGS += -DNETSNMP_NO_INLINE
USR_LDFLAGS += `net-snmp-config --libs`

#==================================================
# The following will built and instaled:
# dbd/devSnmp.dbd
# include/devSnmp.h
# bin/<arch>/snmp2
# lib/<arch>/libdevSnmp.a
#=============================
# build an ioc application

# This is what we will be building from here:
# create library for OSI type driver
LIBRARY_IOC += devSnmp

# This is for vxWorks specific drivers.
# Don't forget to substitute your driver name.
# create library for linking will install in <lib>
# LIBRARY_vxWorks += devSnmp

# create munch file for dynamic loading will install in <bin>
PROD_IOC += snmp2

# The following line makes the devSnmp.h file
# This is needed for Record support. So uncomment
# the following line if you are making record support.
##DBDINC += devSnmp
# devSnmp.dbd will be created from devSnmpInclude.dbd
DBD += devSnmp.dbd
DBD += snmp2.dbd

# Add locally compiled object code
devSnmp_SRCS += drvSnmp.c
devSnmp_SRCS += devSnmp.c
devSnmp_SRCS += snmpRegister.cpp

# The following builds sncExample as a component of devSnmp
# Also in devSnmpInclude.dbd uncomment #registrar(sncExampleRegistrar)
#devSnmp_SRCS += sncExample.stt
#devSnmp_LIBS += seq pv

# The PROD_IOC_vxWorks is built from the same srcs and must include
# the registry routines.
snmp2_SRCS += $(devSnmp_SRCS) snmp2Main.cpp
snmp2_SRCS += snmp2_registerRecordDeviceDriver.cpp

snmp2_DBD += base.dbd
snmp2_DBD += devSnmp.dbd
snmp2_DBD += system.dbd
snmp2_DBD += devIocStats.dbd
snmp2_DBD += asSupport.dbd
snmp2_DBD += caPutLog.dbd

snmp2_LIBS += $(EPICS_BASE_IOC_LIBS)
snmp2_LIBS += devIocStats
snmp2_LIBS += autosave
snmp2_LIBS += caPutLog

#===========================

include $(TOP)/configure/RULES
#----------------------------------------
#  ADD RULES AFTER THIS LINE

