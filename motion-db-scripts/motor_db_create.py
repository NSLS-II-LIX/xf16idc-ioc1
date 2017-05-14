#!/usr/bin/env python

import sys
import re
import argparse

from MotorConfig import *

def main():
    desc = 'Create motor database files.'
    parser = argparse.ArgumentParser(description = desc)
    parser.add_argument('--input_file', required = True)
    parser.add_argument('--rack', required = True)
    parser.add_argument('--controllers', nargs = '+', required = True)
    parser.add_argument(
            '--pad_controller_num', 
            required = False, 
            default = True,
            help = 'Add leading zero to controller number?')

    args = parser.parse_args()

    input_file = args.input_file

    config = MotorConfig()
    config.rack = args.rack
    config.controllers = [int(x) for x in args.controllers]
    config.pad_controller_num = args.pad_controller_num

    print 'Controller numbers: {0}'.format(config.controllers)

    config.read_file(input_file)

    config.set_column_widths()

    print config.column_widths

    create_autohome_subst(config)
    create_motor_subst(config)
    create_motor_status_subst(config)
    create_pmac_status_subst(config)
    create_pmac_asyn_motor_subst(config)

def create_autohome_subst(config):
    PLC_OFFSET = 7

    autohome_format_string = "{{{0:{1}} {2:{3}} {4:{5}} {6:{7}}}}\n"

    autohome_file = open('autohome.substitutions','w')

    autohome_file.write("file \"db/autohome.db\"\n")
    autohome_file.write("{\n")
    autohome_file.write("pattern\n")
    autohome_file.write(autohome_format_string.format(\
            "SYS,", config.column_widths["system"],\
            "DEV,", config.column_widths["device"],\
            "PLC,", 5,\
            "PORT", 6))

    for motor in sorted(
            config.motors,
            key = lambda dict: (dict["controller"], dict["axis_number"])):
        port = "P" + str(config.controllers.index(motor["controller"]))

        autohome_file.write(autohome_format_string.format(\
                "\""+motor["system"]+"\",", config.column_widths["system"],\
                "\"{"+motor["device"]+"}\",", config.column_widths["device"],\
                str(motor["homing"])+",", config.column_widths["homing"],\
                port, 6))

    autohome_file.write("}\n")

def create_motor_subst(config):

    motor_format_string = "{{{0:{1}} {2:{3}} {4:{5}} {6:{7}} {8:{9}} "
    motor_format_string += "{10:{11}} {12:{13}} {14:{15}} {16:{17}} "
    motor_format_string += "{18:{19}} {20:{21}}}}\n"

    motor_subst_file = open('motor.substitutions','w')

    motor_subst_file.write("file \"db/motor.db\"\n")
    motor_subst_file.write("{\n")
    motor_subst_file.write("pattern\n")
    motor_subst_file.write(motor_format_string.format(\
            "P,", config.column_widths["system"],\
            "M,", config.column_widths["device"],\
            "MOTOR,", 7,\
            "PORT,", 6,\
            "ADDR,", max(6,config.column_widths["axis_number"]), \
            "DESC,", max(6,config.column_widths["desc"]), \
            "DTYP,", len('asynMotor,'), \
            "MRES,", max(6,config.column_widths["mres"]), \
            "EGU,", max(5,config.column_widths["egu"]), \
            "PREC,", max(6,config.column_widths["prec"]),  \
            "ALIAS", max(6,config.column_widths["alias"])))

    for motor in sorted(config.motors,\
            key = lambda dict: (dict["controller"], dict["axis_number"])):
        #for motor in sorted(config.motors, key = lambda tup: tup[4]):
        port = "\"P" + str(config.controllers.index(motor["controller"])) + "\","
        motor_port = "\"M" + str(config.controllers.index(motor["controller"])) + "\","

        motor_subst_file.write(motor_format_string.format(\
                "\""+motor["system"]+"\",", config.column_widths["system"],\
                "\"{"+motor["device"]+"}Mtr\",", config.column_widths["device"],\
                motor_port, 7,\
                port, 6, \
                str(motor["axis_number"])+",", max(6,config.column_widths["axis_number"]), \
                "\""+str(motor["desc"])+"\",", max(6,config.column_widths["desc"]), \
                "asynMotor,", len('asynMotor'), \
                "\""+str(motor["mres"])+"\",", max(6,config.column_widths["mres"]), \
                "\""+motor["egu"]+"\",", max(5,config.column_widths["egu"]), \
                str(motor["prec"])+",", max(6,config.column_widths["prec"]),  \
                "\""+motor["alias"]+"\"", max(6,config.column_widths["alias"])))


    motor_subst_file.write("}\n")

def create_motor_status_subst(config):
    motorstatus_format_string = "{{{0:{1}} {2:{3}} {4:{5}} {6:{7}}}}\n"
    motorstatus_lines = ""
    pmacstatusaxis_lines = ""
    mc_format_string = config.get_mc_format_string()

    for motor in sorted(config.motors, \
            key = lambda dict: (dict["controller"], dict["axis_number"])):
        port = "\"P" + str(config.controllers.index(motor["controller"])) + "\","

        motorstatus_lines += motorstatus_format_string.format(\
                "\""+motor["system"]+"\",", config.column_widths["system"],
                "\"{"+motor["device"]+"}\",", config.column_widths["device"],
                port, 6,
                str(motor["axis_number"]), 5)

        # Create the entry for the detail motor status 
        #
        # Replace the secondary subsystem with CT and the secondary instance with
        # the rack location

        # This regex adds the CT subsystem in place of the defined subsystem in the
        # PV name.
        replacement_pattern = r'\1CT'
        sub = r'(.+:.+-)[A-Z]+(:?.*)'
        system = "\""+ re.sub(sub, replacement_pattern,motor["system"]) + "\","

        device = "\"{"+mc_format_string.format(motor["controller"]) + "-Ax:" + \
                str(motor["axis_number"]) + "}\","

        # Save the length of the motor controller device for use in formatting
        device_len = len(device)
    
        pmacstatusaxis_lines += motorstatus_format_string.format(
                system, 
                config.column_widths["system"] + 1,
                device, 
                device_len,
                port, 
                6,
                str(motor["axis_number"]), 
                5)

    motor_status_subst_file = open('motorstatus.substitutions','w')

    motor_status_subst_file.write("file \"db/motorstatus.db\"\n")
    motor_status_subst_file.write("{\n")
    motor_status_subst_file.write("pattern\n")
    motor_status_subst_file.write(motorstatus_format_string.format(\
            "SYS,", config.column_widths["system"],\
            "DEV,", config.column_widths["device"],\
            "PORT,", 6,\
            "AXIS", 5))
    motor_status_subst_file.write(motorstatus_lines)
    motor_status_subst_file.write("}\n\n")

    motor_status_subst_file.write("file \"db/pmacStatusAxis.db\"\n")
    motor_status_subst_file.write("{\n")
    motor_status_subst_file.write("pattern\n")
    motor_status_subst_file.write(motorstatus_format_string.format(\
            "SYS,", config.column_widths["system"]+1,\
            "DEV,", device_len,\
            "PORT,", 6,\
            "AXIS", 5))
    motor_status_subst_file.write(pmacstatusaxis_lines)
    motor_status_subst_file.write("}\n")

def create_pmac_status_subst(config):
    motorstatus_format_string = "{{{0:{1}} {2:{3}} {4:{5}} {6:{7}} {8:{9}} {10:{11}}}}\n"
    pmac_status_subst_file = open('pmacStatus.substitutions','w')

    pmac_status_subst_file.write("file \"db/pmacStatus.db\"\n")
    pmac_status_subst_file.write("{\n")
    pmac_status_subst_file.write("pattern\n")
    #pmac_status_subst_file.write("{ SYS,     PMAC,      VERSION,  PLC,   PORT, NAXES}\n")
    pmac_status_subst_file.write(motorstatus_format_string.format(\
            "SYS,", config.column_widths["system"] + 1,\
            "PMAC,", 8,\
            "VERSION", len("VERSION") + 1,\
            "PLC", len("PLC") + 1,\
            "PORT,", 6,\
            "NAXES", 6))

    controllers = {}

    for motor in sorted(config.motors, \
            key = lambda dict: (dict["controller"], dict["axis_number"])):
        if motor["controller"] not in controllers.keys():
            controllers[motor["controller"]] = True

            # This regex adds the CT subsystem in place of the defined subsystem in the
            # PV name.
            replacement_pattern = r'\1CT'
            sub = r'(.+:.+-)[A-Z]+(:?.*)'
            system = "\""+ re.sub(sub,replacement_pattern,motor["system"]) + "\","
            
            mc_format_string = config.get_mc_format_string()
            device = "\"" + mc_format_string.format(motor["controller"]) + "\","
            port = "\"P" + str(config.controllers.index(motor["controller"])) + "\","
            #pmac_status_subst_file.write("{ " + system + ", " + device +\
                  #", \"1\",  5, " + port + ", 8 }\n")
            pmac_status_subst_file.write(motorstatus_format_string.format(\
                    system, config.column_widths["system"] + 1,\
                    device, 8,\
                    "\"1\"", len("VERSION") + 1,\
                    "5", len("PLC") + 1,\
                    port, 6,\
                    "8", 6))

    pmac_status_subst_file.write("}\n")

def create_pmac_asyn_motor_subst(config):
    pmac_asyn_motor_format_string = "{{{0:{1}} {2:{3}} {4:{5}} {6:{7}} {8:{9}}\
            {10:{11}} {12:{13}} {14:{15}} {16:{17}}}}\n"

    pmac_asyn_motor_subst_file = open('pmac_asyn_motor.substitutions','w')

    pmac_asyn_motor_subst_file.write("file \"db/pmac_asyn_motor.db\"\n")
    pmac_asyn_motor_subst_file.write("{\n")
    pmac_asyn_motor_subst_file.write("pattern\n")
    pmac_asyn_motor_subst_file.write(pmac_asyn_motor_format_string.format(\
            "SYS,", config.column_widths["system"],\
            "DEV,", config.column_widths["device"],\
            "MOTOR,", len("MOTOR, "),\
            "SPORT,", len("SPORT, "),\
            "ADDR,", config.column_widths["axis_number"],\
            "DESC,", config.column_widths["desc"],\
            "DTYP", len("asynMotor, "),\
            "PREC,", config.column_widths["prec"],\
            "EGU", config.column_widths["egu"]))


    for motor in sorted(config.motors, \
            key = lambda dict: (dict["controller"], dict["axis_number"])):
      #for motor in sorted(config.motors, key = lambda tup: tup[4]):
        port = "P" + str(config.controllers.index(motor["controller"]))
        motor_port = "M" + str(config.controllers.index(motor["controller"]))
        line = pmac_asyn_motor_format_string.format(\
                "\"" + motor["system"] + "\", ", config.column_widths["system"],\
                "\"{" + motor["device"] + "}\", ", config.column_widths["device"],\
                "\"" + motor_port + "\", ", len("MOTOR, "),\
                "\"" + port + "\", ", len("SPORT, "),\
                str(motor["axis_number"]) + ", ", config.column_widths["axis_number"],\
                "\"" + str(motor["desc"]) + "\", ", config.column_widths["desc"],\
                "asynMotor, ", len("asynMotor, "),\
                str(motor["prec"]) + ", ", config.column_widths["prec"],\
                "\"" + motor["egu"] + "\"", config.column_widths["egu"])

        pmac_asyn_motor_subst_file.write(line)

    pmac_asyn_motor_subst_file.write("}\n")


if __name__ == '__main__':
    main()


