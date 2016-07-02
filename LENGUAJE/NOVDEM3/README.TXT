README.WRI          NOVLIB 3.0 Demonstration Notes              96.06.20
==========          ==============================              ========

Welcome to the NOVLIB  3.0 Demonstration. Unlike most demonstration
software, the NOVLIB 3.00 demonstration allows you to create and run
your own programs using any of the features of the retail version of
NOVLIB, which we feel is the best way for you to evaluate NOVLIB.

Please read the following sections carefully, and study the Windows help
file NOVLIB.HLP, which contains the documentation for the product.

Contents

 1.  General Notes
 2.  Demonstration restrictions
 3.  Additional and Changed NOVLIB Functions
 4.  Additional static libraries
 5.  Watcom C/C++ Notes
 6.  Delphi Notes
 7.  Visual Basic Notes
 8.  CA-Visual Objects Notes
 9.  CA-Clipper Notes
10. Credits

1. General Notes

The Demonstration version of NOVLIB 3.0 can be used to create NetWare
aware programs (with some restrictions noted below) using any of the
supported languages:

C/C++ (16 bit)
Microsoft Visual Basic (16 bit)
Borland Delphi 1.x (16 bit)
CA-Visual Objects 1.x (16 bit)
CA-Clipper 5.x
CA-Clipper Summer '87

When using NOVLIB with NetWare 4.x, the user must be logged in using
Bindery Emulation mode. 

2. Restrictions

*************************************************************************
  The Demo restrictions present in this demonstration version of NOVLIB
              ARE NOT PRESENT IN THE RETAIL VERSION!
*************************************************************************

The following restrictions are present in the demonstration version of
NOVLIB 3.0 when linking with the STATIC libraries (applies to C/C++ and
CA-Clipper Dos and Windows programs that do NOT use NOVLIB.DLL):

Restriction(1): You must LINK your program using the DEMONSTRATION
version of Blinker. No other linker (Microsoft Link, TLink, RTLink or
the commercial version of Blinker) will be able to process NOVLIB.LIB,
NOVLIBCL.LIB, NOVDOS.LIB or NOVWIN.LIB. The demonstration version of
Blinker restricts the execution time of your program to 5 minutes, and
displays a message when your program exits. If you do not posess the
demonstration version of Blinker, you may obtain a free copy by
contacting us at the addresses listed at the end of this document.

The following restrictions are present in the demonstration version of
NOVLIB 3.0 when using the supplied DLLs (applies to C/C++, Visual Basic,
Borland Delphi, CA-Visual Objects and CA-Clipper Windows programs):

Restriction(1): NOVLIB will display a message box when your program
accesses the DLL for the first time and subsequently at intervals of 30
seconds until the program terminates.

Restriction(2): NOVLIB will only allow one program to use it at any
given time. If more than one program tries to access NOVLIB, the second
or subsequent programs will receive error return codes, and a message
box will be displayed indicating that only one program may use NOVLIB at
a time.

If you are using the DLL version of NOVLIB and a language that uses
import libraries, you may link the IMPORT libraries using ANY linker you
choose. These libraries (NOVIMP.LIB and NOVIMPCL.LIB are not encrypted).

3. Additional and Changed Functions

NWGetErrorGet() / NWSetErrorGet()

Certain NOVLIB functions perform a 'get' and 'set' operation - for
example UsrFullNameSet() returns the current full name of a user, and
then sets the name to a specified value. NWGetErrorGet() and
NWSetErrorGet() allow you to determine the NetWare error code if either
of these operations fail.

QueAddGet() / QueAddSet()

Contrary to the printed documentation, the names of these functions are
actually QueAddStateGet() and QueAddStateSet(). For CA-Clipper the names
are QueAddStaGet() and QueAddStaSet().

QueFileAdd()

Contrary to the printed documentation, QueFileAdd() can be used to add
local files to a print queue in addition to files residing on a network
drive.

QueServerGet() / QueServerSet()

Contrary to the printed documentation, the names of these functions are
actually QueServiceStateGet() and QueServiceStateSet(). For CA-Clipper
the names are QueSrvStaGet() and QueSrvStaSet().

UsrCurConsoleOperatorTest()

Determine if the current logged in user is a console operator on the
current fileserver.

4. Additional Libraries

Two library files are provided that are not mentioned in the printed
documentation - NOVDOS.LIB and NOVWIN.LIB. If your program is linked
with the static library file NOVLIB.LIB, you must also link NOVDOS.LIB
if your program is a DOS program, or NOVWIN.LIB if your program is a
Windows program. If your program uses NOVLIB.DLL, it is not necessary
(and you should not) link either of these libraries.

5. Watcom C/C++ Notes

Watcom C/C++ users who are using the static libraries must link the file
NWATCOM.OBJ, which can be found in the C\OBJ directory of the
installation directory.

6. Delphi Notes

The install program places NOVLIB.DCU in the DELPHI subdirectory of the
NOVLIB installation directory. Please copy NOVLIB.DCU into your
Delphi\Lib directory. 

7. Visual Basic Notes

The install program places NOVLIB.BAS in the VB subdirectory of the
NOVLIB installation directory. If required, it should be manually copied
to your VB directory.

The Visual Basic demonstration programs are saved in Visual Basic 3.0
format. Visual Basic 4.0 will import and convert these files as requried
to the new format.

8. CA-Visual Objects Notes

Two AEF's are supplied for CA-Visual Objects, NOVLIBS.AEF which uses
'strict' syntax and NOVLIB.AEF which uses 'relaxed' or 'Clipper' syntax.
If you choose to use the 'relaxed' syntax, your program will require
NOVLIBVO.DLL at runtime, in addition to NOVLIB.DLL. If you choose the
'strict' syntax, your program will require only NOVLIB.DLL.

9. CA-Clipper Notes

You cannot link the demonstration version of NOVLIB 3.0 with EXOSPACE,
RTLink or Blinker 1.0 for CA-Clipper (bundled with CA-Clipper 5.3), you
MUST link using the demonstration version of Blinker.

NOVLIB 3.0 is fully compatible with Blinker in real mode, dual mode and
protected mode. The retail version of NOVLIB 3.0 is compatible with
CA-Exospace in protected mode, however CA-Exospace cannot be used with
this demonstration.

NOVLIB 3.0 is 99% overlayable when linked with Blinker in real mode, the
non-overlayable modules are involved with IPX/SPX events and are very
similar to interrupt handlers. Please use the supplied link script
(LIB\NOVLIB30.LNK) when overlaying NOVLIB to force these modules into
the root of your program.

10. Credits

Blink, Inc                  Blink, Inc Ltd.
8001 West Broad Street,     P.O. Box 9
Richmond,                   Penarth,
VA 23294,                   South Glamorgan,
USA.                        UK. CF64 5XF

Tel (804) 747-6700          Tel +44 (1222) 712444
Fax (804) 747-4200          Fax +44 (1222) 700888
BBS (804) 747-7333

The installation program used to install the NOVLIB 3.0 Demonstration,
INSTALL, is licensed software provided by Knowledge Dynamics Corp, P.O.
Box 780068, San Antonio, Texas, 78278 (USA). INSTALL is Copyright c
1987-1994 by Knowledge Dynamics Corp which reserves all copyright
protection worldwide. INSTALL is provided to you for the exclusive
purpose of installing NOVLIB. Blinkinc is exclusively responsible for
the support of NOVLIB, including support during the installation phase.
In no event will Knowledge Dynamics Corp provide any technical support
for the NOVLIB demonstration.
