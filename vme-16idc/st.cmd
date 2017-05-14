#
# Environment variables must be set from DHCP
# RACK - Rack group letter and rack number (eg. RACK="C1")

epicsEnvSet("ENGINEER","oksana x7028")
epicsEnvSet("EPICS_CA_MAX_ARRAY_BYTES","1000000")
epicsEnvSet("HOSTNAME", "xf16idc-ioc-vme1")
epicsEnvSet("IOCNAME", "${IOCNAME}")

## Register all support components
dbLoadDatabase("dbd/mrf.dbd")
mrf_registerRecordDeviceDriver(pdbbase)

installRTEMSHack()

bspExtVerbosity=0

## EVRs
mrmEvrSetupVME("EVR1",2,0x20000000,3,0x26)

dbLoadRecords("db/evr-vmerf-230.db","SYS=XF:16ID-TS, D=EVR:${RACK}, EVR=EVR1")

## Stats
dbLoadRecords("db/iocAdminRTEMS.db", "IOC=XF:16ID-CT{IOC:VME}")

# Don't use accelerator access file
#asSetFilename("/cf-update/acf/default.acf")
#asSetFilename("/common/CtrSwitch-log.acf")
#asSetSubstitutions("P=CtrlSwitch:")

set_savefile_path("/mnt/as","/save")
set_requestfile_path("/mnt/as","/req")

set_pass0_restoreFile("mrf_settings.sav")
set_pass0_restoreFile("mrf_values.sav")
set_pass1_restoreFile("mrf_values.sav")
set_pass1_restoreFile("mrf_waveforms.sav")

iocInit()

makeAutosaveFileFromDbInfo("../as/req/mrf_settings.req", "autosaveFields_pass0")
makeAutosaveFileFromDbInfo("../as/req/mrf_values.req", "autosaveFields")
makeAutosaveFileFromDbInfo("../as/req/mrf_waveforms.req", "autosaveFields_pass1")

create_monitor_set("mrf_settings.req", 15 , "")
create_monitor_set("mrf_values.req", 15 , "")
create_monitor_set("mrf_waveforms.req", 30 , "")

# Don't use accelerator server
#caPutLogInit("ioclog.cs.nsls2.local:7004")

dbl > /cf-update/${HOSTNAME}.${IOCNAME}.dbl
