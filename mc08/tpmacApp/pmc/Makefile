# Makefie for creating homing PMAC program
#
TOP = ../..
include $(TOP)/configure/CONFIG
include $(TOP)/configure/CONFIG_PMC

## These files will be build by expanding templates using MSI
PMC += xf16idc-mc08-homing.pmc
PMC += xf16idc-mc08-plc05-cpu.pmc
PMC += xf16idc-mc08-brake.pmc

## These files will be copied unchanged to the installation directory
PMC_INSTALLS += xf16idc-mc08-plc01.pmc
PMC_INSTALLS += xf16idc-mc08-plc07-holding.pmc
#PMC_INSTALLS += xf28idc-mc08-plc01.pmc
#PMC_INSTALLS +=  xf16idc-mc08-backup.CFG

## These files are used as templates for the MSI expansion
PMC_TEMPLATES += $(PMACUTIL)/pmc/PLC_cpu_load.pmc
PMC_TEMPLATES += $(PMACUTIL)/pmc/home_to_enc_ref_template.pmc
#PMC_TEMPLATES += $(PMACUTIL)/pmc/home_to_limit_template.pmc

include $(TOP)/configure/RULES_PMC
