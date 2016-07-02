*
*  96.02.09    T.PRG
*
*  This program demonstrates calling function STATTEST in a
*  statically linked DLL from the main EXE. It also shows
*  that when a duplicate function exists in the main EXE and
*  in a DLL then the function in the main EXE will ALWAYS be
*  the one called.

func t

temp = "Initial"                       // Initialise a variable

? "MAIN: temp =",temp                  // Display it
?
stattest()                             // Call the function in the DLL

? "MAIN: temp =",temp                  // Display its modified value
?
return NIL                             // All done

function duplicate                     // Duplicate function to show resolution
?
? "DUPLICATE in main EXE"              // Indicate we are in the main EXE
?
return NIL                             // All done

