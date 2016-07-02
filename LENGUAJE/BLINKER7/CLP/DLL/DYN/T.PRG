*
*  96.03.23    T.PRG
*
*  This program demonstrates calling function STATTEST in a
*  dynamically linked DLL from the main EXE. It also shows
*  that when a duplicate function exists in the main EXE and
*  in a DLL then the function in the main EXE will ALWAYS be
*  the one called.

func t

temp = "Initial"                       // Initialise a variable

? "MAIN: temp =",temp                  // Display it
?

dllnme = "D.DLL"                       // Name of the DLL to use
funnme = "DYNTEST"                     // Name of the function to call
funpa1 = "Hello"                       // Function parameter 1
funpa2 = 1234                          // Function parameter 2 ....
funres = 0                             // Dummy function result in case fails

libhan = BLILIBLOD (dllnme)            // Dynamically load the DLL

if libhan > 32                         // If it loaded successfully

//          ******************         // EITHER (most efficient and controlled)

   funhan = BLIFUNHAN (libhan,funnme)  // Get the function handle
   if funhan <> 0                      // If the function was found

                                       // Call function with (multiple) params
      funres = BLIFUNCAL (funpa1,funpa2,funhan)
                                       // Note that function handle is LAST
   else
      ? "DLL file", dllnme, "does not contain function", funnme
      ?
   endif

//          ******************         // OR (easiest but less efficient)

//    funres = &funnme (funpa1,funpa2) // Gives a runtime error if not found
                                       // But also works even if the function
                                       // Was not exported !!

//          ******************         // END

   ? "Function", funnme, "returned", funres // Display the results
   ?

   BLILIBFRE (libhan)                  // Free the library when finished

else
   ? "DLL file ", dllnme, "not found or failed to load"
   ?
endif

? "MAIN: temp =",temp                  // Display its modified value
?
return NIL                             // All done

function duplicate                     // Duplicate function to show resolution
?
? "DUPLICATE in main EXE"              // Indicate we are in the main EXE
?
return NIL                             // All done

