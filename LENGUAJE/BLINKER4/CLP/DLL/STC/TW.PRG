*
*  96.02.25    TW.PRG
*
*  This program demonstrates calling function STATTEST in a
*  statically linked DLL from a Windows EXE. It also shows
*  that when a duplicate function exists in the main EXE and
*  in a DLL then the function in the main EXE will ALWAYS be
*  the one called.
*
*  You will need to replace MESSAGE with the appropriate function
*  for Clip4Win or FiveWin, and update the D.PRG for the DLL
*

func t

temp = "Initial"                       // Initialise a variable

MESSAGE ("MAIN: temp = " + temp)       // Display it

stattest()                             // Call the function in the DLL

MESSAGE ("MAIN: temp = " + temp)       // Display its modified value

return NIL                             // All done

function duplicate                     // Duplicate function to show resolution

MESSAGE ("DUPLICATE in main EXE")      // Indicate we are in the main EXE

return NIL                             // All done

