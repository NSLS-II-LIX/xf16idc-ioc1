import sys
import pkg_resources

# Check for correct version of xlrd package
xlrd_version = pkg_resources.get_distribution("xlrd").version.split('.')

if int(xlrd_version[0]) == 0 and int(xlrd_version[1]) < 8:
    print 'xlrd version is too old. This requires at least 0.8.0'
    sys.exit()

from xlrd import open_workbook

class MotorConfig:
    def __init__(self):
        self.rack = ""
        self.controllers = []
        self.motors = []
        self.column_keys = ("controller", "rack", "pv_name", "axis_number", \
                "desc", "egu", "prec", "mres", "alias", "system", "device", "homing")
        self.int_column_keys = ("controller", "axis_number", "prec", \
                "homing")
        self.str_column_keys = ("system", "device", "desc", "alias", "mres")
        self.column_titles = {"controller":"Controller", \
                "rack":"Rack",\
                "pv_name":"Full axis name",\
                "axis_number":"Axis",\
                "desc":"Motion axis",\
                "egu":"EGU",\
                "prec":"PREC",\
                "mres":"MRES",\
                "alias":"ALIAS",\
                "homing":"Homing PLC"}
        self.column_numbers = {}
        self.column_widths = {}
        for key in self.column_keys:
            self.column_widths[key] = 0
        self.motion_axis_tabname = "Motion axis summary"

    def set_column_widths(self):
        for motor in self.motors:
            for key in self.column_keys:
                if len(str(motor[key])) > self.column_widths[key]:
                    self.column_widths[key] = len(str(motor[key]))
        for key in self.str_column_keys:
            self.column_widths[key] += 4
        # Allow for the Mtr in the device name
        self.column_widths["device"] += 4

        # Set minimum width for some numeric columns
        self.column_widths["axis_number"] = max(self.column_widths["axis_number"],
                len("ADDR, "))
        self.column_widths["prec"] = max(self.column_widths["prec"],
                len("PREC, "))
        self.column_widths["homing"] = max(self.column_widths["homing"],
                len("PLC, "))

    def read_file(self, input_file_name):
        input_file = open_workbook(input_file_name)

        motor_input_sheet = input_file.sheet_by_name(self.motion_axis_tabname)

        # Process the header rows and find the columns with the relevant keywords
        header_rows = 0

        for row in range(motor_input_sheet.nrows):
            header_rows += 1
            values = motor_input_sheet.row_values(row, 0)

            for k in self.column_titles.keys():
                if self.column_titles[k] in values:
                    self.column_numbers[k] = values.index(self.column_titles[k])

            if len(self.column_titles) == len(self.column_numbers):
                # Found all the header columns
                break

        # Check that we found all the column titles
        if len(self.column_titles) != len(self.column_numbers):
            print 'Could not find all the required colunns.'
            print 'The following column titles could not be found:'
            for k in self.column_titles.keys():
                if k not in self.column_numbers.keys():
                    print self.column_titles[k]
            sys.exit()

        print 'Column titles: {0}'.format(self.column_titles)
        print 'Column numbers: {0}'.format(self.column_numbers)
        print 'Number of header rows = {0:d}'.format(header_rows)

        # Now get the motor configurations

        for row in range(header_rows, motor_input_sheet.nrows):
            values = motor_input_sheet.row_values(row, 0)
            # Test if we actually have entries in the rack and controller columns
            if values[self.column_numbers['rack']] != "" and \
                    values[self.column_numbers['controller']] != "":

                # Sanity check in the controller
                if isinstance(values[self.column_numbers['controller']], basestring):
                    print 'We have found a string in the controller field on row {}. Skipping this line'.format(row)
                    continue
                # Test if we have the right rack and controller
                if values[self.column_numbers['rack']] == self.rack and \
                        int(values[self.column_numbers['controller']]) in self.controllers:
                    pv_name = values[self.column_numbers['pv_name']]
                    motor_dict = {}
                    # Check if the PV name has the {} characters. If not, assume it is not
                    # required as a PV in EPICS.
                    if '{' in pv_name and '}' in pv_name: 
                        # Get the required values from the input line
                        for key in self.column_keys:
                            if key != 'system' and key != 'device':
                                motor_dict[key] = values[self.column_numbers[key]]
                        # Convert the integer values to ints
                        for key in self.int_column_keys:
                            if motor_dict[key] == '':
                                print 'Missing data in {} column for row {}'.format(key, row)
                                sys.exit(1)
                            motor_dict[key] = int(motor_dict[key])

                        # Add in the system and device names to the dictionary
                        motor_dict['system'] = motor_dict['pv_name'].split('{')[0]
                        motor_dict['device'] = motor_dict['pv_name'].split('{')[1].split('}')[0]

                        # Save all the relevant information as a dictionary for easier retrieval
                        # later on
                        self.motors.append(motor_dict)

        if len(self.motors) == 0:
            print 'Could not find any motors for the given controller.'
            sys.exit()

        print 'Motors = {0}'.format(self.motors)
            
            

    def get_mc_format_string(self):
        if self.pad_controller_num:
            return "MC:{0:02d}"
        else:
            return "MC:{0:d}"



