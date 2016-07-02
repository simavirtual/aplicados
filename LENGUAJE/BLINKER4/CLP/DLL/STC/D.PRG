*
*  96.02.09    D.PRG
*
*  This program demonstrates a function STATTEST in a
*  statically linked DLL which is called from the main EXE.
*  It also shows that when a duplicate function exists in
*  the main EXE and in a DLL then the function in the main
*  EXE will ALWAYS be the one called.
*

func stattest                          // Function in a statically linked DLL

? "DLL : temp =",temp                  // Display the variable

temp = "This is STATTEST in the DLL"   // Modify its value

? "DLL : temp =",temp                  // Display its new value

? "Static value true",NetMode()        // Show a static function is set up

duplicate ()                           // Call function duplicated in main EXE

return NIL                             // All done

static func NetMode( lNewMode )        // Static function
   
static lOpenMode := .T.                // Initialised static variable

return ( iif( lNewMode != NIL, lOpenMode := lNewMode, lOpenMode ))

func duplicate                         // Function duplicated in the EXE
?
? "DUPLICATE in the DLL"               // Would indicate we are in the DLL
?
return NIL                             // All done

