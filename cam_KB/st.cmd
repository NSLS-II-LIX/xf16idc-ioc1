#!/epics/support/areaDetector/ADProsilica/iocs/prosilicaIOC/bin/linux-x86_64/prosilicaApp
< /epics/support/areaDetector/ADProsilica/iocs/prosilicaIOC/iocBoot/iocProsilica/envPaths

errlogInit(20000)

epicsEnvSet("CTPREFIX",   "XF:16IDA-CT{cam_KB}")
epicsEnvSet("PREFIX", "XF:16IDA-BI{Cam:KB}")
epicsEnvSet("PORT",   "cam")
epicsEnvSet("QSIZE",  "20")
epicsEnvSet("XSIZE",  "780")
epicsEnvSet("YSIZE",  "580")
epicsEnvSet("NCHANS", "2048")
epicsEnvSet("CBUFFS", "500")
epicsEnvSet("EPICS_DB_INCLUDE_PATH", "$(ADCORE)/db")
epicsEnvSet("NELM",       "904800")
epicsEnvSet("CAM_IP",     "xf16ida-cam-KB.nsls2.bnl.local")
epicsEnvSet("HOSTNAME",   "xf16idc-ioc1.nsls2.bnl.local")
epicsEnvSet("IOCNAME",    "cam_KB")
epicsEnvSet("EPICS_CA_MAX_ARRAY_BYTES", "4000000")
epicsEnvSet("EPICS_DB_INCLUDE_PATH", "$(ADCORE)/db")

dbLoadDatabase("$(TOP)/dbd/prosilicaApp.dbd")
prosilicaApp_registerRecordDeviceDriver(pdbbase)

# prosilicaConfig(portName,    # The name of the asyn port to be created
#                 cameraId,    # Unique ID, IP address, or IP name of the camera
#                 maxBuffers,  # Maximum number of NDArray buffers driver can allocate. 0=unlimited
#                 maxMemory,   # Maximum memory bytes driver can allocate. 0=unlimited
#                 priority,    # EPICS thread priority for asyn port driver 0=default
#                 stackSize,   # EPICS thread stack size for asyn port driver 0=default
#                 maxPvAPIFrames) # Number of frames to allocate in PvAPI driver. Default=2.
# The simplest way to determine the uniqueId of a camera is to run the Prosilica GigEViewer application, 
# select the camera, and press the "i" icon on the bottom of the main window to show the camera information for this camera. 
# The Unique ID will be displayed on the first line in the information window.
prosilicaConfig("$(PORT)", "$(CAM_IP)", 50, 0)

#asynSetTraceIOMask("$(PORT)",0,2)
#asynSetTraceMask("$(PORT)",0,255)

dbLoadRecords("$(ADPROSILICA)/db/prosilica.template","P=$(PREFIX),R=,PORT=$(PORT),ADDR=0,TIMEOUT=1")

# Create a standard arrays plugin, set it to get data from first Prosilica driver.
NDStdArraysConfigure("Image1", 5, 0, "$(PORT)", 0, 0)

# Use this line if you only want to use the Prosilica in 8-bit mode.  It uses an 8-bit waveform record
# NELEMENTS is set large enough for a 1360x1024x3 image size, which is the number of pixels in RGB images from the GC1380CH color camera. 
# Must be at least as big as the maximum size of your camera images
#dbLoadRecords("$(ADCORE)/db/NDStdArrays.template", "P=$(PREFIX),R=image1:,PORT=Image1,ADDR=0,TIMEOUT=1,NDARRAY_PORT=$(PORT),TYPE=Int8,FTVL=UCHAR,NELEMENTS=$(NELM)")

# Use this line if you want to use the Prosilica in 8,12 or 16-bit modes.  
# It uses an 16-bit waveform record, so it uses twice the memory and bandwidth required for only 8-bit data.
dbLoadRecords("$(ADCORE)/db/NDStdArrays.template", "P=$(PREFIX),R=image1:,PORT=Image1,ADDR=0,TIMEOUT=1,NDARRAY_PORT=$(PORT),TYPE=Int16,FTVL=SHORT,NELEMENTS=$(NELM)")

# Load all other plugins using commonPlugins.cmd
< $(ADCORE)/iocBoot/commonPlugins.cmd
set_requestfile_path("$(ADPROSILICA)/prosilicaApp/Db")

#dbLoadRecords("$(TOP)/db/iocAdminSoft.db","IOC=$(CTPREFIX)")

#NDPvaConfigure("PVA1", 20, 0, "$(PORT)", 0, "$(PREFIX)Pva1:Image", 0, 0, 0)
#dbLoadRecords("NDPva.template", "P=$(PREFIX),R=Pva1:,PORT=PVA1,ADDR=0,TIMEOUT=1,NDARRAY_PORT=$(PORT)")
#startPVAServer()

< /epics/common/xf16idc-ioc1-netsetup.cmd
iocInit()

# save things every thirty seconds
create_monitor_set("auto_settings.req", 30,"P=$(PREFIX)")
dbl > /cf-update/$(HOSTNAME).$(IOCNAME).dbl

