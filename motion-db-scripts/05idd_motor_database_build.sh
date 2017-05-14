#!/bin/bash

# Script to create all required databases from CSV file extracted from design
# report motor listing. 
#
# The script will generate the files and then copy them into the relevant local
# repository directories.

./motor_db_create.py LT-R-XFD-CO-DR-SRX-002_Rev1.xlsx RG:D2 1 && \
	cp -v *.substitutions ~/local/data/work/hg/repos/xf/05id/ioc/xf05idd-ioc1/mc01/tpmacApp/Db

#./motor_db_create.py LT-R-XFD-CO-DR-SRX-002_Rev1.xlsx RG:D2 2 && cp -v *.substitutions ~/local/data/work/hg/repos/xf/28id/ioc/xf05idd-ioc1/mc2/tpmacApp/Db

#./motor_db_create.py LT-R-XFD-CO-DR-SRX-002_Rev1.xlsx RG:D2 3 && cp -v *.substitutions ~/local/data/work/hg/repos/xf/28id/ioc/xf05idd-ioc1/mc3/tpmacApp/Db

#./motor_db_create.py LT-R-XFD-CO-DR-SRX-002_Rev1.xlsx RG:D3 4 && cp -v *.substitutions ~/local/data/work/hg/repos/xf/28id/ioc/xf05idd-ioc1/mc4/tpmacApp/Db

#./motor_db_create.py LT-R-XFD-CO-DR-SRX-002_Rev1.xlsx RG:D3 5 && cp -v *.substitutions ~/local/data/work/hg/repos/xf/28id/ioc/xf05idd-ioc1/mc5/tpmacApp/Db

#./motor_db_create.py LT-R-XFD-CO-DR-SRX-002_Rev1.xlsx RG:D3 6 && cp -v *.substitutions ~/local/data/work/hg/repos/xf/28id/ioc/xf05idd-ioc1/mc6/tpmacApp/Db

#./motor_db_create.py LT-R-XFD-CO-DR-SRX-002_Rev1.xlsx RG:D3 7 && cp -v *.substitutions ~/local/data/work/hg/repos/xf/28id/ioc/xf05idd-ioc1/mc7/tpmacApp/Db
