  README.TXT      Blinker 6.0 Release Notes                     01.01.01
  ----------      -------------------------                     --------

  Welcome to Blinker 6.0. This file contains the latest information on
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
  5.  New environment settings
  6.  New error messages
  7.  Credits

  1. General Notes

  Blinker 6.x circumvents a problem in Windows 2000 that causes GPFs in
  mouse enabled DOS extended applications when the mouse is moved. To
  ensure compatibility with Windows 2000 and later versions of Windows,
  we strongly recommend relinking all mouse enabled applications with
  Blinker 6.x - this applies particularly to all CA-Clipper 5.3x
  applications, as CA-Clipper 5.3 installs a mouse hanndler even if the
  mouse is not used.

  The compression algorithm in Blinker 6.x requires that ALL modules in an
  application, i.e. the .EXE and any .DLLs it uses, must be re-linked with
  the latest Blinker. Run time GPFs will occur if the .EXE file was
  compressed with an older version than the .DLLs, or a Blinker run time
  error 1321 will occur if the .EXE file was compressed with 6.x but a
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

  5. New environment settings
  None

  6. New error messages
  None

  7. Contact details
  Blink, Inc.,
  P.O. Box 29858,
  Richmond,
  VA 23242-0858
  USA

  Sales:      (804) 784 2087  sales@blinkinc.com
  Support:    (804) 784 2347  blinkersupport@blinkinc.com
  Web:        www.blinkinc.com
