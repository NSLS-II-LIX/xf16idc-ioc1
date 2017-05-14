#!/bin/bash

# Script to create all required databases from CSV file extracted from design
# report motor listing. 
#
# The script will generate the files and then copy them into the relevant local
# repository directories.

./motor_db_create.py LT-R-XFD-CO-DR-SRX-002_Rev1.xlsx RG:A2 1 && cp -v *.substitutions ~/local/data/work/hg/repos/xf/05id/ioc/xf05ida-ioc1/mc1/tpmacApp/Db

./motor_db_create.py LT-R-XFD-CO-DR-SRX-002_Rev1.xlsx RG:A2 2 && cp -v *.substitutions ~/local/data/work/hg/repos/xf/05id/ioc/xf05ida-ioc1/mc2/tpmacApp/Db

./motor_db_create.py LT-R-XFD-CO-DR-SRX-002_Rev1.xlsx RG:A2 3 && cp -v *.substitutions ~/local/data/work/hg/repos/xf/05id/ioc/xf05ida-ioc1/mc3/tpmacApp/Db




