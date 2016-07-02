                       README.TXT
**********************************************************
  Microsoft(R) FoxPro(R) Version 2.6 Professional Edition
  Library Construction Kit for Windows(TM) and MS-DOS(R)

    (C)1994 Microsoft Corporation. All Rights Reserved.

  This file contains additions and corrections to the
  FoxPro Library Construction Kit Developer's Guide.
**********************************************************

=========
CONTENTS
=========

Part   Description
----   -----------
 1     Installation
 2     Additions to LCK Developer's Guide Since Printing
 3     Corrections to LCK Developer's Guide Since Printing
----------------------------------------------------------


=====================
Part 1: Installation
=====================

Installing the Professional Edition of FoxPro 2.6
-------------------------------------------------
The Professional Edition of FoxPro 2.6 includes the
following kits:

Distribution Kit
Connectivity Kit
Library Construction Kit
WorkGroup Extensions (FoxPro for Windows only) 

To install the Professional Edition of FoxPro, first install
the main FoxPro product, then follow the installation 
instructions included with each individual kit.  The order 
in which the kits are installed does not matter.
----------------------------------------------------------


==========================================================
Part 2: Additions to LCK Developer's Guide Since Printing
==========================================================
In the LCK Developer's Guide, references to FoxPro 2.5 
should be read as references to FoxPro 2.6.
----------------------------------------------------------

The EXAMPLES directory contains a FoxPro database with all
the example code that is used in the manual.  Simply
search for the function with example code you wish to
copy and then extract the code from the memo field. You
are free to use this code in your own applications.
-----------------------------------------------------------

The following function has been added:

WHANDLE _WMainWindow( )

Description:
_WMainWindow( ) returns the WHANDLE of the main FoxPro
window in FoxPro for Windows or of the FoxPro desktop
in FoxPro for MS-DOS.

Example:
The following example writes a message to the main FoxPro
window in FoxPro for Windows or to the FoxPro desktop in
FoxPro for MS-DOS.

FoxPro Code:

   SET LIBRARY TO WMAIN
   = EXWMAIN()

C Code:

   #include <pro_ext.h>

   void FAR example(ParamBlk FAR *parm)
   {
        WHANDLE wh = _WMainWindow();
        _WPutStr(wh, "\nThis is the main FoxPro window or desktop.");
   }

   FoxInfo myFoxInfo[] = {
        {"EXWMAIN", example, 0, ""},
   };

   FoxTable _FoxTable = {
        (FoxTable FAR *) 0, sizeof(myFoxInfo)/sizeof(FoxInfo), myFoxInfo
   };
----------------------------------------------------------


===================================================
Part 3: Corrections to LCK Developer's Guide Since 
        Printing
===================================================

Page 2: In the Reverse.C example:

The comment "/* Check to see if we can allocate the memory
needed. */" is missing the end comment marker */.

The three-line comment "Since this routine doesn't call
any functions that cause memory reorganization . . . 
prior to de-referencing them (_HandToPtr)" is missing the
single line comment marker // in the second and third
lines.

This statement:

   for (i = 0; i << parm->p[0].val.ev_length; i++)
            *(out_string--) = *(in_string++);

should be:

   for (i = 0; i < parm->p[0].val.ev_length; i++)
            *(out_string--) = *(in_string++);

Change the "<<" in the original example to "<".
----------------------------------------------------------

Page 5: The Value Structure Fields table should include
the General FoxPro data type.  The applicable fields and
their values are listed below:

val.ev_type = 'G'
val.ev_width = FCHAN
val.ev_long = length of general field
val.ev_real = offset of general field
----------------------------------------------------------

Page 6: The data type FPFI, a FAR pointer to a function
returning Int, is mistakenly listed as "FPDI".
----------------------------------------------------------

Page 7: In addition to the Point, Rect and EventRec data
structures, PointP and RectP should be included. PointP
and RectP are identical to Point and Rect except that
Point and Rect coordinates are in rows and columns while
PointP and RectP coordinates are in pixels.
----------------------------------------------------------

Page 12: The example

    if (parm->p[0].val.ev_type='C'
                x=parm->p[0].val.ev_length

should be:

   if (parm->p[0].val.ev_type=='C')
                x=parm->p[0].val.ev_length;

Use an expression ==, a closed parenthesis at the end of
the first line, and a semicolon at the end of the second
line.
----------------------------------------------------------

Page 22: When compiling a .PLB library in Microsoft C7 or
Visual C/C++, you need to use the following command line:

CL /O /ALw /Zp /GW

When linking a .PLB library in Microsoft C7 or C8, you 
need to use the /NOE and /NONULLS switches.

Leaving out /NOE can cause redefinition errors. Leaving
out /NONULLS will cause FoxPro not to recognize the .PLB
as a valid library.
----------------------------------------------------------

Page 25: The section heading for the makefile on this page
is incorrect. It should say "Microsoft C/C++ Makefile for
MS-DOS" instead of "WATCOM C Makefile for MS-DOS." 
----------------------------------------------------------

Page 26: The  makefile on this page should have the
following section heading: "WATCOM C Makefile for MS-DOS."
----------------------------------------------------------

Page 39: The example doesn't work as intended in all
cases. To have it work, you need to change the following
line:

   (( char FAR *) _HandToPtr(p1.ev_handle))[p1.ev_length] = '\0';

to:

   (( char FAR *) _HandToPtr(p0.ev_handle))[p0.ev_length - 1] = '\0';
   (( char FAR *) _HandToPtr(p1.ev_handle))[p1.ev_length - 1] = '\0';
----------------------------------------------------------

Page 85: The following information applies to the 
_DBSeek( ) function: The struct Value passed to _DBSeek( )
(via a pointer) must be of ev_type == 'N' when seeking a
numeric field even if that field has 0 decimal digits.
If the struct Value has an ev_type of 'I', _DBSeek( )will
return the internal error number -302, "Data type
mismatch."
----------------------------------------------------------

Page 109: The struct EDENV documented with _EdGetEnv( ) isn't
correct. The actual structure from PRO_EXT.H appears
as follows:

NOTE:  (R) indicates that this member is read-only and
       can't be set using _EdSetEnv( ).

       (B) indicates that these members takes on one of
       two Boolean values: 1 = true or 0 = false.


typedef struct
{
   char            filename[MAXFILENAME]; // (R)
   EDPOS           length;       // # of bytes in text. (R)
   unsigned short  lenLimit;     // Max allowable length. 0 = infinite.

   unsigned short  dirty,        // Has the file been changed? (R, B)
                   autoIndent,   // Auto indent? (B)
                   backup,       // Make backup files? (B)
                   addLineFeeds, // Add line feeds when saving? (B)
                   autoCompile,  // Shall we auto compile this thing? (B)
                   addCtrlZ,     // Add end of file ctrl-z? (B)
                   savePrefs,    // Save edit preferences? (B)
                   dragAndDrop,  // Allow drag-and-drop. (B)
                   readOnly,     // 0 = not r/o, 1 = file is r/o,
                                 // 2 = file is r/w, opened r/o,
                                 // 3 = file is r/o, opened r/o. (R)
                   status,       // Display status bar? (B)
                   lockPrefs,    // Can update the preferences ? (B)
                   insertMode;   // (B)

   short   wrap;       // If < 0, new line at Return only.
   EDPOS   selStart;   // Selection start. (R)
   EDPOS   selEnd;     // Selection end. (R)
   EDPOS   selAnchor;  // Selection anchor point. (R)
   short   justMode;   // Justification (0 = left, 1 = right, 2 = center).
   short   tabWidth;   // TAB size in spaces.

   char    fontName[MAXFONTNAME];
   short   fontSize;
   short   fontStyle;  // 0 = plain, 1 = bold, 2 = italic, 3 = bold italic.
   short   kind;       // Kind of editor session; EDCOMMAND, EDPROGRAM, etc.
                       // defined in pro_ext.h. (R)
} EDENV;
----------------------------------------------------------

Page 122: The syntax for _EdOpenFile() is missing the
"mode" argument.  It should read:

   _EdOpenFile(TEXT *filename, int mode)

   TEXT *filename;      /* File to open. */
   int mode;            /* Mode option. */
	
The following Mode options are available:
FO_READONLY, FO_WRITEONLY, FO_READWRITE.
----------------------------------------------------------

Page 315: zoomEvent is a FoxPro for MS-DOS event.  You
can't trap for this event in FoxPro for Windows.
----------------------------------------------------------

In an EventHandler in the FoxPro for Windows Library
Construction Kit, if you make a call to FoxPro which
generates another event, the original event record may be
changed.  This won't happen in the FoxPro for MS-DOS
Library Construction Kit. The following example
illustrates this:

#include <pro_ext.h>

int         g_eventid = 0;         // Our event handler.

FAR EventHandler(WHandle theWindow, EventRec FAR *ev)
{
        Point     pt;
    switch (ev->what)              // Determine the event type.
    {
        case keyDownEvent:
                        if (theWindow == _WMainWindow())
                                return NO;
                        else
                        {
                                pt.h = 35;
                                pt.v = 10;

                        // This causes the event handler to be re-entered.
                                _WSize(theWindow, pt);	
                        }
                        _PutStr("\nDone with the keyDownEvent");
                        break;

                case sizeEvent:
                        _PutStr("\nSize Event received.");
                        break;

                        default:
                        return NO;
        }
        return NO;
}

FAR EventExit()
{
    _DeActivateHandler(g_eventid);     // Get rid of our event handler.
}


FAR Quotes(ParamBlk FAR *parm)
{
    //  Set up our event handler.
    g_eventid = _ActivateHandler(EventHandler);
}


FoxInfo myFoxInfo[] = {
    {"QUOTES", Quotes, 0, ""},
    {"EVENTEXIT", EventExit, CALLONUNLOAD, ""}
};

FoxTable _FoxTable = {
    (FoxTable FAR *)0, sizeof(myFoxInfo) / sizeof(FoxInfo), myFoxInfo
};
----------------------------------------------------------

                      =================
                      End of README.TXT
                      =================
