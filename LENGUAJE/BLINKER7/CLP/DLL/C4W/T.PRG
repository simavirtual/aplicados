*
*  96.03.19    T.PRG
*
*  This program demonstrates calling function STATTEST in a
*  statically linked DLL from the main EXE. It also shows
*  that when a duplicate function exists in the main EXE and
*  in a DLL then the function in the Clip-4-Win EXE will ALWAYS be
*  the one called.

func t
local	hWnd := WinSetup("test", "Clip-4-Win makes this so EASY!")

temp = "Initial"                       // Initialise a variable

? "MAIN: temp =",temp                  // Display it
?
stattest()                             // Call the function in the DLL

? "MAIN: temp =",temp                  // Display its modified value
?
wait                                   // Keep the window open
return NIL                             // All done

function duplicate                     // Duplicate function to show resolution
?
? "DUPLICATE in main EXE"              // Indicate we are in the main EXE
?
return NIL                             // All done

