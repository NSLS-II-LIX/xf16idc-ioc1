#!/bin/bash

# Script to create all required databases from CSV file extracted from design
# report motor listing. 
#
# The script will generate the files and then copy them into the relevant local
# repository directories.

#./motor_db_create.py LT-R-XFD-CO-DR-XPD-002_Rev1.xlsx RG:C1 1 && cp -v *.substitutions ~/local/data/work/hg/repos/xf/28id/ioc/xf28idc-ioc1/mc1/tpmacApp/Db
#./motor_db_create.py LT-R-XFD-CO-DR-XPD-002_Rev1.xlsx RG:C1 2 && cp -v *.substitutions ~/local/data/work/hg/repos/xf/28id/ioc/xf28idc-ioc1/mc2/tpmacApp/Db
#./motor_db_create.py LT-R-XFD-CO-DR-XPD-002_Rev1.xlsx RG:C1 3 && cp -v *.substitutions ~/local/data/work/hg/repos/xf/28id/ioc/xf28idc-ioc1/mc3/tpmacApp/Db
#./motor_db_create.py LT-R-XFD-CO-DR-XPD-002_Rev1.xlsx RG:C1 4 && cp -v *.substitutions ~/local/data/work/hg/repos/xf/28id/ioc/xf28idc-ioc1/mc4/tpmacApp/Db
#./motor_db_create.py LT-R-XFD-CO-DR-XPD-002_Rev1.xlsx RG:C2 5 && cp -v *.substitutions ~/local/data/work/hg/repos/xf/28id/ioc/xf28idc-ioc1/mc5/tpmacApp/Db
#./motor_db_create.py LT-R-XFD-CO-DR-XPD-002_Rev1.xlsx RG:C2 7 && cp -v *.substitutions ~/local/data/work/hg/repos/xf/28id/ioc/xf28idc-ioc1/mc07/tpmacApp/Db
./motor_db_create.py --input_file LT-R-XFD-CO-DR-XPD-002_Rev1.xlsx --rack RG:C2 --controller 8 --pad_controller_num True && cp -v *.substitutions ~/local/data/work/hg/repos/xf/28id/ioc/xf28idc-ioc1/mc08/tpmacApp/Db
