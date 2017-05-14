#!/bin/bash

# Script to create all required databases from CSV file extracted from design
# report motor listing. 
#
# The script will generate the files and then copy them into the relevant local
# repository directories.

#./motor_db_create.py --input_file LT-R-XFD-CO-DR-LiX-001_Rev6.xlsx --rack RG:A1 --controllers 1
#	cp -v *.substitutions /epics/iocs/mc01/tpmacApp/Db/

#./motor_db_create.py --input_file LT-R-XFD-CO-DR-LiX-001_Rev6.xlsx --rack RG:A1 --controllers 2
#        cp -v *.substitutions /epics/iocs/mc02/tpmacApp/Db/

#./motor_db_create.py --input_file LT-R-XFD-CO-DR-LiX-001_Rev6.xlsx --rack RG:A1 --controllers 3
#        cp -v *.substitutions /epics/iocs/mc03/tpmacApp/Db/

#./motor_db_create.py --input_file LT-R-XFD-CO-DR-LiX-001_Rev6.xlsx --rack RG:A1 --controllers 4
#        cp -v *.substitutions /epics/iocs/mc04/tpmacApp/Db/

#./motor_db_create.py --input_file LT-R-XFD-CO-DR-LiX-001_Rev6.xlsx --rack RG:B1 --controllers 5
#        cp -v *.substitutions /epics/iocs/mc05/tpmacApp/Db/

#./motor_db_create.py --input_file LT-R-XFD-CO-DR-LiX-001_Rev7.xlsx --rack RG:C2 --controllers 8
#        cp -v *.substitutions /epics/iocs/mc08/tpmacApp/Db/

#./motor_db_create.py --input_file LT-R-XFD-CO-DR-LiX-001_Rev7.xlsx --rack RG:C2 --controllers 9
#        cp -v *.substitutions /epics/iocs/mc09/tpmacApp/Db/

#./motor_db_create.py --input_file LT-R-XFD-CO-DR-LiX-001_Rev7.xlsx --rack RG:B1 --controllers 6
#        cp -v *.substitutions /epics/iocs/mc06/tpmacApp/Db/

#./motor_db_create.py --input_file LT-R-XFD-CO-DR-LiX-001_Rev7a.xlsx --rack RG:B1 --controllers 7
#        cp -v *.substitutions /epics/iocs/mc07/tpmacApp/Db/

./motor_db_create.py --input_file LT-R-XFD-CO-DR-LiX-001_Rev7.xlsx --rack RG:C2 --controllers 10
	cp -v *.substitutions /epics/iocs/mc10/tpmacApp/Db/
