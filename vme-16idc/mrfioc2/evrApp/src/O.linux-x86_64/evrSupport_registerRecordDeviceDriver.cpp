/* THIS IS A GENERATED FILE. DO NOT EDIT! */
/* Generated from ../evrSupport.dbd */

#include <string.h>

#include "epicsStdlib.h"
#include "iocsh.h"
#include "iocshRegisterCommon.h"
#include "registryCommon.h"

extern "C" {

epicsShareExtern dset *pvar_dset_devLOEVRPulserMap;
epicsShareExtern dset *pvar_dset_devSIEVR;
epicsShareExtern dset *pvar_dset_devEventEVR;
epicsShareExtern dset *pvar_dset_devLOEVRMap;
epicsShareExtern dset *pvar_dset_devWfMailbox;
epicsShareExtern dset *pvar_dset_devNtpShmLiOk;
epicsShareExtern dset *pvar_dset_devNtpShmLiFail;
epicsShareExtern dset *pvar_dset_devNtpShmAiDelta;

static const char * const deviceSupportNames[8] = {
    "devLOEVRPulserMap",
    "devSIEVR",
    "devEventEVR",
    "devLOEVRMap",
    "devWfMailbox",
    "devNtpShmLiOk",
    "devNtpShmLiFail",
    "devNtpShmAiDelta"
};

static const dset * const devsl[8] = {
    pvar_dset_devLOEVRPulserMap,
    pvar_dset_devSIEVR,
    pvar_dset_devEventEVR,
    pvar_dset_devLOEVRMap,
    pvar_dset_devWfMailbox,
    pvar_dset_devNtpShmLiOk,
    pvar_dset_devNtpShmLiFail,
    pvar_dset_devNtpShmAiDelta
};

epicsShareExtern drvet *pvar_drvet_ntpShared;

static const char *driverSupportNames[1] = {
    "ntpShared"
};

static struct drvet *drvsl[1] = {
    pvar_drvet_ntpShared
};

epicsShareExtern void (*pvar_func_asub_evr)(void);
epicsShareExtern void (*pvar_func_EVRTime_Registrar)(void);
epicsShareExtern void (*pvar_func_ntpShmRegister)(void);

int evrSupport_registerRecordDeviceDriver(DBBASE *pbase)
{
    const char *bldTop = "/home/oksana/temp/vme-16id/mrfioc2";
    const char *envTop = getenv("TOP");

    if (envTop && strcmp(envTop, bldTop)) {
        printf("Warning: IOC is booting with TOP = \"%s\"\n"
               "          but was built with TOP = \"%s\"\n",
               envTop, bldTop);
    }

    if (!pbase) {
        printf("pdbbase is NULL; you must load a DBD file first.\n");
        return -1;
    }

    registerDevices(pbase, 8, deviceSupportNames, devsl);
    registerDrivers(pbase, 1, driverSupportNames, drvsl);
    (*pvar_func_asub_evr)();
    (*pvar_func_EVRTime_Registrar)();
    (*pvar_func_ntpShmRegister)();
    return 0;
}

/* registerRecordDeviceDriver */
static const iocshArg registerRecordDeviceDriverArg0 =
                                            {"pdbbase",iocshArgPdbbase};
static const iocshArg *registerRecordDeviceDriverArgs[1] =
                                            {&registerRecordDeviceDriverArg0};
static const iocshFuncDef registerRecordDeviceDriverFuncDef =
                {"evrSupport_registerRecordDeviceDriver",1,registerRecordDeviceDriverArgs};
static void registerRecordDeviceDriverCallFunc(const iocshArgBuf *)
{
    evrSupport_registerRecordDeviceDriver(*iocshPpdbbase);
}

} // extern "C"
/*
 * Register commands on application startup
 */
static int Registration() {
    iocshRegisterCommon();
    iocshRegister(&registerRecordDeviceDriverFuncDef,
        registerRecordDeviceDriverCallFunc);
    return 0;
}

static int done = Registration();
