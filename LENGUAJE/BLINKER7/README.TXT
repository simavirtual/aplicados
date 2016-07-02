  README.TXT      Blinker 7.0 Release Notes                     12.31.02
  ----------      -------------------------                     --------

  Welcome to Blinker 7.0. This file contains the latest information on
  Blinker, so please read the following sections carefully, and study the
  new sections in the Windows help file BLINKER.HLP, before calling
  technical support.

  In particular, please refer to the 'Quick Start by compiler' section for
  your compiler in the online help, and follow the detailed instructions
  describing how to create, link and run a small test program before
  calling technical support.

  Contents

  1.  General Notes
  2.  Instructions for specific compilers
  3.  DOS extender notes
  4.  New commands
  5.  New functions
  6.  New environment settings
  7.  New error messages
  8.  Credits

  1. General Notes

  Blinker 7.x circumvents a problem in Windows 2000 and Windows XP that
  causes GPFs in mouse enabled DOS extended applications when the mouse
  is moved. To ensure compatibility with Windows XP and later versions
  of Windows,  we strongly recommend relinking all mouse enabled
  applications with   Blinker 7.x - this applies particularly to all
  CA-Clipper 5.3x applications, as CA-Clipper 5.3 installs a mouse handler
  even if the mouse is not used by the application.

  The compression algorithm in Blinker 7.x requires that ALL modules in an
  application, i.e. the .EXE and any .DLLs it uses, must be re-linked with
  the latest Blinker. Run time GPFs will occur if the .EXE file was
  compressed with an older version than the .DLLs, or a Blinker run time
  error 1321 will occur if the .EXE file was compressed with 7.x but a
  .DLL was compressed with an older version.

  2. Instructions for specific compilers

  2.1. Alaska Xbase++ 1.1
  Blinker supports Alaska Xbase++ 1.1 Service Release 1 (1.1 SL1) and
  later for the creation of 32 bit Windows programs, including automatic
  execution of Blinker from PBUILD and full support of the Xbase++
  debugger.

  Please ensure that you are using a minimum of version 1.1 Service
  Release 1, dated June 1998, before contacting us or Alaska for support.
  Using an older version of Xbase++ with Blinker can result in many types
  of errors, including GPFs at link time, the debugger not displaying
  program source code correctly, or Blinker error 1165 on an import
  library for a .DLL.

  Blinker supports linking of OMF object modules and libraries, ensure
  you are using the correct OMF files, and not the COFF format files.

  If you have a problem with an Xbase++ program linked with Blinker,
  always try re-linking the same program with Alink and running it in
  exactly the same environment before contacting Blinkinc for support. If
  the problem also occurs with the program linked with Alink, then it is
  obviously not specific to Blinker, so cannot be supported by Blinkinc.

  2.2. CA-Clipper 5.x Windows programs
  The OBJ subdirectory of the Blinker installation directory includes the
  file MPAR.OBJ which should be linked to all CA-Clipper-for-Windows
  programs. This file fixes a bug in CLIPPER.LIB versions 5.3b and
  earlier which prevented Windows programs from loading when a particular
  internal table was spread across a 32 KB boundary. This could occur in
  CA-Clipper Windows programs of any size, and when it did so, Windows
  would typically display the helpful message 'A device connected to the
  system is not responding' and terminate the program.

  3. DOS extender notes

  3.1. Add on / 3rd party libraries

  The file 3RDPARTY.TXT in the Blinker installation directory contains the
  latest information we have available. The information was supplied by
  the vendors concerned, so is provided on an as is basis and Blinkinc
  makes no guarantee that the information is correct.

  4. New commands
  None

  5. New functions

  BLICPUREL()                                         (CA-CLIPPER 5.x only)

  The Blinker CPU time release function BLICPUREL() corrects an anomaly
  present in all CA-Clipper 5.x DOS and DOS extended applications running
  under 32 bit versions of Windows (95, 98, NT, Windows 2000 and Windows XP).
  CA-Clipper 5.x applications continually poll the keyboard for keystrokes,
  especially when in a Clipper wait state (eg: GET, INKEY, MENU TO, ACHOICE
  etc).

  Under all 32 bit Windows operating systems, this keyboard polling has the
  effect of slowing down ALL tasks running on the system, including other
  applications, background printing tasks and network drivers, resulting in
  poor performance, slow task switching and sporadic network disconnections
  or timeouts.

  Processor usage may be monitored by running the 'Performance Monitor'
  utility supplied with the Windows operating system. Clipper applications
  generally utilize 100% CPU resources, which may be reduced significantly
  through the use of BLICPUREL().

  Purpose:          Release idle time to operating system

  Syntax:           BLICPUREL([nuFreq])

  Parameters:       nuFreq    - frequency that time is released (default 50)

  Returns:          nuFreq -    The current frequency setting.

  Description:      BLICPUREL() is called ONCE at the beginning of the
                    program. Subsequently, whenever the CA-Clipper application
                    is in an idle state, time will be released to the operating
                    system automatically. The parameter 'nuFreq' specifies how
                    frequently time should be released - default is 50.

                    The frequency (nuFreq) parameter may be overridden at run
                    time by setting a 'CPU' parameter in the CLIPPER
                    environment variable:

                    SET CLIPPER=//F:200 //CPU:75

                    or through BLINKER's link time CLIPPER environment settings:

                    BLINKER EXECUTABLE CLIPPER //F:200 //CPU:75

                    in which case the 'nuFreq' parameter will be ignored and
                    the environment setting used instead.

                    Additionally, the variable may be passed as a parameter
                    on the command line when starting the program:

                    MYAPP //CPU:75

  Example:          // Release time to the operating system

  BLICPUREL()       // Use default parameters

  6. New environment settings
  None

  7. New error messages
  None

  8. Contact details
  Blink, Inc.,
  P.O. Box 29858,
  Richmond,
  VA 23242-0858
  USA

  Sales:      (804) 784 2087  sales@blinkinc.com
  Support:    (804) 784 2347  blinkersupport@blinkinc.com
  Web:        www.blinkinc.com
