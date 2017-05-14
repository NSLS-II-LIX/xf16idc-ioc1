#!/bin/bash

# Script to create all required databases from CSV file extracted from design
# report motor listing. 
#
# The script will generate the files and then copy them into the relevant local
# repository directories.

./motor_db_create.py LT-R-XFD-CO-DR-XPD-002_Rev1.xlsx RG:A1 1
cp -v *.substitutions ~/local/data/work/hg/repos/xf/28id/ioc/xf28ida-ioc1/mc1/tpmacApp/Db

./motor_db_create.py LT-R-XFD-CO-DR-XPD-002_Rev1.xlsx RG:A1 2
cp -v *.substitutions ~/local/data/work/hg/repos/xf/28id/ioc/xf28ida-ioc1/mc2/tpmacApp/Db

./motor_db_create.py LT-R-XFD-CO-DR-XPD-002_Rev1.xlsx RG:A1 3
cp -v *.substitutions ~/local/data/work/hg/repos/xf/28id/ioc/xf28ida-ioc1/mc3/tpmacApp/Db

./motor_db_create.py LT-R-XFD-CO-DR-XPD-002_Rev1.xlsx RG:A1 4 5
cp -v *.substitutions ~/local/data/work/hg/repos/xf/28id/ioc/xf28ida-ioc1/mc4_5/tpmacApp/Db



