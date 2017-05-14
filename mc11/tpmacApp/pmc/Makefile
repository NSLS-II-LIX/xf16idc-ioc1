# Makefie for creating homing PMAC program
#
TOP = ../..
include $(TOP)/configure/CONFIG
include $(TOP)/configure/CONFIG_PMC

## These files will be build by expanding templates using MSI
PMC += xf16idc-mc11-homing.pmc
PMC += xf16idc-mc11-plc05-cpu.pmc

## These files will be copied unchanged to the installation directory
PMC_INSTALLS += xf16idc-mc11-plc01.pmc


## These files are used as templates for the MSI expansion
PMC_TEMPLATES += $(PMACUTIL)/pmc/PLC_cpu_load.pmc
PMC_TEMPLATES += $(PMACUTIL)/pmc/home_to_enc_ref_template.pmc
PMC_TEMPLATES += $(PMACUTIL)/pmc/home_to_limit_template.pmc

include $(TOP)/configure/RULES_PMC
