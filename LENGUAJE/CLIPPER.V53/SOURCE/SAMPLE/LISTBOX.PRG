/***
*
*  LISTBOX.PRG
*
*  Sample listbox program
*
*  Copyright (c) 1990-1995, Computer Associates International Inc.
*  All rights reserved.
*
*  NOTE: Compile with /n
*
*/

// Manifest Constant Definitions
#DEFINE S_ADD     "Add"
#DEFINE S_EDIT    "Edit"
#DEFINE S_REPORT  "Report"
#DEFINE S_QUIT    "Quit"

// Filewide variable declarations go here; we have none

PROCEDURE Main
// Local variable declarations
LOCAL cChoice

// Continuous loop redisplays listbox after each
// function return
DO WHILE .T.

  // Function call to create the listbox
  cChoice := CreateListbox()

  // Clear the screen
  CLEAR

  // CASE structure to make function call based
  // on return value of CreateListbox()
  DO CASE

    // Functions below do not do much, but are
    // placed at the bottom of this file for
    // completeness
    CASE cChoice = S_ADD
      AddRecs()

    CASE cChoice = S_EDIT
      EditRecs()

    CASE cChoice = S_REPORT
      Reports()

    // If cChoice does not match any of the above
    // (S_QUIT was chosen), then we should EXIT
    OTHERWISE
      EXIT

  ENDCASE

ENDDO

RETURN


FUNCTION CreateListbox()

// Local variable declarations

// Array of choices
LOCAL aChoices := { S_ADD, S_EDIT, S_REPORT, S_QUIT }
// Set the default value to S_ADD
LOCAL cListChoice := S_ADD

// Clear the screen
CLEAR

// Create the listbox with our four choices
@ 1,31,6,45 GET cListChoice LISTBOX aChoices

// Get the user's input
READ

// Return the choice
RETURN(cListChoice)


FUNCTION AddRecs()
// Add records routine goes here
@ 1,1 SAY "Adding records..."
WAIT
RETURN NIL


FUNCTION EditRecs()
// Edit records routine goes here
@ 1,1 SAY "Editing records..."
WAIT
RETURN NIL


FUNCTION Reports()
// Reports routine goes here
@ 1,1 SAY "Running reports..."
WAIT
RETURN NIL
