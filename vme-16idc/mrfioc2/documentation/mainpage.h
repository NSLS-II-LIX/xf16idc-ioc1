#ifndef MAINPAGE_H
#define MAINPAGE_H

// No code.  Just Doxygen documentation

/**

@mainpage mrfioc2 Timing System Driver for MRF products

@section whatisit What is it?

A driver for VME and PCI cards from Micro Research Finland for implementing a distributed
timing system.

@url http://www.mrf.fi/

@section whereis Source

Releases can be found at @url http://sourceforge.net/projects/epics/files/mrfioc2/

This module is versioned with Mercurial and can be viewed at
@url http://epics.hg.sourceforge.net/hgweb/epics/mrfioc2/

Or checked out with

hg clone http://epics.hg.sourceforge.net:8000/hgroot/epics/mrfioc2

The canonical version of this page is @url http://epics.sourceforge.net/mrfioc2/

@subsection requires Requires

EPICS Base >= 3.14.8.2

@url http://www.aps.anl.gov/epics/

MSI (Macro expension tool)

@url http://www.aps.anl.gov/epics/extensions/msi/index.php

devLib2

@url http://epics.sourceforge.net/devlib2/

RTEMS >= 4.9.x, vxWorks >=6.7, or Linux >= 2.6.26.

@section hardware Supported Hardware

Event Generators.  Current only the VME-EVG-230

Event Receivers.  VME-EVR-230RF, PMC-EVR-230, cPCI-EVR-230, cPCI-EVRTG-300

@note Support for the VME-EVR-230 (non-RF) is present, but has not been tested.

@section doc Documentation

User documentation can be found in the form of usage manuals for both the
<a href="evr-usage.pdf">Receiver</a>
and
<a href="evg-usage.pdf">Generator</a>

Those interested in the implementation for the Receiver might wish to start with mrmEvrSetupPCI()
and mrmEvrSetupVME() or the ::EVRMRM class.

For the generator see mrmEvgSetupVME() or the ::evgMrm class.

@section changelog Changelog

@subsection v202 2.0.2 (XXXX)

@subsubsection v202bug Bug fixes


@li wrong width for RVAL causes endianness issue
@li re-enable of CML output during setMode not conditional
@li Fix EVG driver init w/o hardware.  This was crashing.
@li Update locking for EVR.  Take lock for all device support actions.

@subsubsection v202feat Features

@li Updated recommended firmware version for PCI EVRs to 6.
@li Compile in VCS version or release number.  Add a PV which reads this.
@li Read SFP EEPROM information (eg. module serial#, temperature, and incoming optical power).
    Requires firmware >=5.  For version 5 must be from 25 May 2012 or later.
@li Add mapping record for Prescaler reset action to the example EVR databases.
@li Support and documentation for firmware update of PMC-EVR-230 devices on Linux.

@warning The default mapping for prescaler reset is now disabled.
         This is an incompatible change.  Anyone using this feature
         with a customized database should update their database
         to include this mapping record!

@subsection v201 2.0.1 (Apr. 2012)

@subsubsection v201bug Bug fixes

@li Fix several vxWorks build issues
@li Correct initial mapping for EVR output channels to Force Low (aka. Off)
@li Fix readback of EVG sequencer run mode.
@li Limit number of soft event send retries
@li More check for EVG and EVR during initialization.
     Should now catch old firmware versions and CSR address mapping problems.
@li Delay enabling VME interrupts for EVG until later during IOC startup.
@li Fix autosave/restore of CML output bit patterns.
@li Remove rear transition module definitions from default EVG db template
@li Fix locking issue in data buffer tx/rx.
    A deadlock would occur when trying to send a buffer with the link mode
    set to dbus only.

@subsubsection v201feat Features

@li Added evralias.db to facilitate creation of PV name aliases for EVR
    delay generator channels.
@li Always reset all EVG multiplexed counters when a divider value is changed.
@li Add counter to track number of times each EVG sequencer is run.
@li Add mrmEvrForward() shell function to configure EVR event forwarding to downstream EVRs.

@subsection ver20 2.0 (Sept. 2011)

@li Initial release.

@author Michael Davidsaver <mdavidsaver@bnl.gov>

@author Jayesh Shah <jshah@bnl.gov>

@author Eric Bj�rklund <bjorklund@lanl.gov>

*/

#endif // MAINPAGE_H
