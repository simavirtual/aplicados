/****************************************************************************
* Blinker swap function demo
*
* Force 4.0
*
* Compile: FORCE swapdemo
* Link   : BLINKER FILE swapdemo LIB force
*
****************************************************************************/

#include blinker.hdr
#include io.hdr


#pragma W_GET_LOCAL-


#define TRUE   .t.
#define FALSE  .f.


proc main

vardef
   char( 100 ) cKeyString
   logical     lStatus
enddef

if ! SWPGETPID( "swapdemo.prg" )

   // If we're not already running

   ? "Force Swap example"
   ? "=================="
   ?
   ? "Swap defaults      "
   ?
   ? "Use EMS memory                  : ", SWPUSEEMS( FALSE )
   ? "Use XMS memory                  : ", SWPUSEXMS( FALSE )
   ? "Use UMBs                        : ", SWPUSEUMB( FALSE )
   ? "Save/restore video mode         : ", SWPVIDMDE( FALSE )
   ? "Save/restore directory          : ", SWPCURDIR( FALSE )
   ? "Display message                 : ", SWPDISMSG( FALSE )
   ? "Wait for keypress               : ", SWPGETKEY( FALSE )
   ? "Suppress <Ctrl><Alt><Del>       : ", SWPNOBOOT( FALSE )
   ?

   ? "Program already running?        : ", SWPGETPID( "swapdemo.prg" )
   ? "Set program ID to swapdemo.prg  : ", SWPSETPID( "swapdemo.prg" )
   ?

   // enable ems / xms / umbs

   lStatus := SWPUSEEMS( TRUE )
   lStatus := SWPUSEXMS( TRUE )
   lStatus := SWPUSEUMB( TRUE )

   // save / restore current directory and video mode
   // video buffer contents are not saved

   lStatus := SWPCURDIR( TRUE )
   lStatus := SWPVIDMDE( TRUE )

   ? "Shelling to DOS...(Type EXIT to return)"
   ? "Run swapdemo again to see SWPGETPID()."
   ? "-------------------------------------------------------------------------"

   // Set a new prompt

   lStatus := SWPSETENV( "PROMPT=Force SwapDemo - $p$g" )

   cKeyString := "'dir /w'{enter}'swapdemo'"
   lStatus := SWPKEYBRD( cKeyString )

   // status := SWPRUNCMD(ChildProg, Memory, Shell Directory, Temporary directory)

   lStatus := SWPRUNCMD( "", 0, "", "" )

   ? "-------------------------------------------------------------------------"
   ? "Back from shell, status is      : ", lStatus
   ? "Major error code is             : ", SWPERRMAJ()
   ? "Minor error code is             : ", SWPERRMIN()
   ? "Child process return code was   : ", SWPERRLEV()
   ? "Child process return string was : ", SWPGETSTRFOR()

else
   clear
   // we're already running, terminate the program
   cKeyString := "                           "
   @ 0, 0 say "This is the second invocation of Swapdemo"
   @ 1, 0 say "Please enter a message to return to the parent"
   @ 2, 0 say "Message : " get cKeyString
   read
   lStatus := swpsetstr( "swapdemo.prg", "Value : " )
   lStatus := swpaddstr( "swapdemo.prg", cKeyString )
   @ 4, 0 say "Type EXIT to return to previous swapdemo.prg"
   @ 6, 0 say ""
   quit
endif

endproc

