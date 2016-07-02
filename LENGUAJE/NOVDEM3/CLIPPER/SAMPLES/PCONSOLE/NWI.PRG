
// ********************************************************************
// *ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿*
// *³                                                                ³*
// *³  NWI3.PRG: Some functions for emulating the look and feel of   ³*
// *³                    the NetWare Utilities                       ³*
// *³                                                                ³*
// *³          Developed from Goth's DEMO.PRG by Rich Miller         ³*
// *³             (C) 1994 ASM Inc.  All Rights Reserved.            ³*
// *³                                                                ³*
// *ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ*
// ********************************************************************


#include "achoice.ch"
#include "inkey.ch"
#include "novlib.ch"

MEMVAR cpMenuName		// For any Help() routine you may have

//
// Draw NetWare-alike background
//
FUNCTION BackGnd( cVerString )
	LOCAL I,cDmy

	// Cyan upper portion of screen
	Color(2)
	@ 0,0 CLEAR TO 3,79
	@ 0,0 TO 3,79

	// Patterned background
	Color(0)
	FOR I = 4 TO 24
		@ I,0 SAY REPLICATE( "°", 80 )
	NEXT

	// Output passed "version string"
	Color(2)
	@ 1,2 SAY cVerString

	// Assemble date string and output it
	cDmy := PADC( ( CDOW( DATE() )), 9)		+ " "  + ;
			CMONTH( DATE() )				+ " "  + ;
			ALLTRIM(STR(  DAY( DATE() )))	+ ", " + ;
			ALLTRIM(STR( YEAR( DATE() )))
	@ 1,40 SAY PADL( cDmy, 28 )

	// Clean up
	Color(0)

RETURN NIL


//
// Display cHeader centered on line 3
//
FUNCTION Title(cHeader)
	Color(2)
	@ 2,10 CLEAR TO 2,70
	@ 2,( 80 - LEN(cHeader) )/2 SAY cHeader
	Color(0)
RETURN NIL



//
// Display user data via Title() function
//
FUNCTION UserTitle
	Title(  "User "				+RTRIM( SUBSTR( WSLOGNMEGET(),1,15 ) ) +;
			" on File Server "	+RTRIM( SUBSTR( FSNMEGET()   ,1,15 ) ) +;
			" Connection "		+LTRIM(    STR( WSCONNUMGET()      ) ) )
return NIL



//
// Novell-esque 'Exit? Yes/No' box
//
FUNCTION AskExit( cPrgName )
	LOCAL prompts := { "No          ", "Yes         " }
    LOCAL menuchoice
	LOCAL cScrBit

	cScrBit := SAVESCREEN( 11,31,16,47 )

	// Draw menu box
	ExpBox( 11,31,16,47, " Exit " + cPrgName, .T. )
	Color(3)

	// Ask the user
	menuchoice := ACHOICE( 14,34,15,46, prompts,,, 2 )

	RESTSCREEN( 11,31,16,47, cScrBit )

RETURN IIF( menuchoice == 2, .T., .F. )		// Return whether to quit




//
// Sets one of a number of colors
//
FUNCTION Color( nColor )
	LOCAL aColors := {  {"bg/b,b/w" ,"w/n,n/w" },;
		  				{"gr+/b,b/w","w+/n,n/w"},;
		  				{"b/bg,b/w" ,"n/w,w/n" },;
		  				{"w+/b,b/w" ,"w/n,n/w" },;
		  				{"r/bg"     ,"n/w,w/n" }   }

	SET(_SET_COLOR, aColors[ nColor+1, IIF(ISCOLOR(),1,2) ] )

RETURN NIL




//
// Single-line box, very simple, with title cordoned off
//
FUNCTION SingleBox( t,l,b,r, cTitle )
	LOCAL cSaveBox

	cSaveBox := SAVESCREEN( t,l,b,r )

	Color(1)

	@t,l CLEAR TO b,r
	@t,l TO b,r
	@t+2,l TO t+2,r
	@t+2,l SAY "Ã"
	@t+2,r SAY "´"

	@t+1,l+1 SAY PADC( cTitle, (r-l)-1 )

RETURN cSaveBox




//
// Draw an exploding box to the size and specs below.
//
FUNCTION ExpBox(t,l,b,r,title,line,select)
	LOCAL height, width, t1, l1, b1, r1, cScr

	cScr := SAVESCREEN(t,l,b,r)		// Pass back to calling routine
	Color(1)

	// Do the following (exploding effect) if no 'select' parameter
	IF VALTYPE(select) = "U"
		height := b - t
		width := r - l
		t1 := t + (height / 2); l1 := l + (width / 2)
		b1 := b - (height / 2); r1 := r - (width / 2)

		DO WHILE t1-1 > t .OR. l1 > l
			@ t1,l1 CLEAR TO b1,r1
			@ t1,l1 TO b1,r1 DOUBLE
			IF t1-1 > t
				t1--; b1++
			ENDIF
			IF l1 > l
				l1--; r1++
			ENDIF
		ENDDO
		@ t,l CLEAR TO b,r

		// Draw white line at left (for pick lists)
		IF line
			Color(3)
			@ t+3,l+2 TO b-1,l+2
			Color(1)
		ENDIF

	// If 'select' param exists and is .F., draw in white
	ELSEIF (select == .f.)
		Color(3)
	ENDIF

	// Draw final double border
	@ t,l TO b,r DOUBLE
	@ t+2,l+1 TO t+2,r-1 DOUBLE
	@ t+2,l SAY "Ì"
	@ t+2,r SAY "¹"

	// Output title
	@ t+1,l+((R-L-LEN(title))/2) SAY title

RETURN cScr




//
// NetWare-alike menu using ExpBox() and MENU TO
//
FUNCTION NWMenu( t,l,b,r, cTitle, aMenu, ;
					CBArg1, CBArg2, lMainMenu, cPrgName, cHlpName )
	LOCAL cBox1, nCount, nChoice

	/*
	 *
	 * aMenu is an array of subarrays (2D); each subarray has a
	 * MENU TO heading and a code block to execute when that
	 * heading is chosen.
	 *
	 * CBArg1 and CBArg2 are values passed to the code block.
	 *
	 */

	cBox1 := ExpBox( t,l,b,r, cTitle, .T. )

	// Loop until ESC pressed
	WHILE .T.
		cpMenuName := cHlpName		// For benefit of Help()
		//@0,0 SAY PADR( cpMenuName, 15 )

		ExpBox( t,l,b,r, cTitle, .T., .T. )
		Color(3)

		// Lay out and exec the menu
		FOR nCount = 1 TO LEN( aMenu )
			@ ((t+2)+nCount), (l+3) PROMPT aMenu[nCount,1]
		NEXT
		MENU TO nChoice

		IF nChoice > 0          	// If not ESC...
			ExpBox( t,l,b,r, cTitle, .T., .F. )

			// Evaluate the code block
			EVAL( aMenu[nChoice,2], CBArg1, CBArg2 )

		ELSE
			// If this is the main menu, ask before exiting to DOS
			IF ( VALTYPE(lMainMenu) != "U" ) .AND. ( lMainMenu == .T. )
				ExpBox( t,l,b,r, cTitle, .T., .F. )
				IF AskExit( cPrgName )
					EXIT
				ENDIF
			ELSE
				EXIT            	// Else just quit function
			ENDIF

		ENDIF
	END

	// Clean up
	RESTSCREEN( t,l,b,r, cBox1 )

RETURN NIL




//
// Use ExpBox() to draw a quick picklist in the NetWare style
//
FUNCTION NWPickList( t,l,b,r, cTitle, lExplode, aListItems, nRightLine )
	LOCAL cBox1, nSelect

	cBox1 := ExpBox( t,l,b,r, cTitle, lExplode )

	Color(3)

	// Draw the line at right
	IF nRightLine != 0
		@ t+3, r-nRightLine TO b-1, r-nRightLine
	ENDIF

	WHILE (nSelect := ACHOICE( t+3,l+3,b-1,            ;
						IIF( nRightLine != 2,r-1,r-3), ;
						aListItems                       )) != 0
	END

	RESTSCREEN( t,l,b,r, cBox1 )

RETURN nSelect




//
// Black-on-green help box, like NetWare's;
// Never knew this would be so involved!
//
// BEWARE! This function uses recursion to
// emulate the page-up and page-down func-
// tionality of NetWare help. Excessive
// use of PgUp and PgDn (over 100 times)
// will run the program out of stack!
//
FUNCTION HelpBox( aMsg, nIndex )
	LOCAL nColor := SETCOLOR( "N/G" ), nCursor := SETCURSOR( 0 )
	LOCAL nHeight,nWidth,nTop,nLeft,nBot,nRight,cScr,cBox,nKey,lSingle := .F.

	// Check for single-line flag (255 in nIndex)
	IF nIndex == 255
		lSingle := .T.
		nIndex := 1
	ENDIF

	// Calc dimensions of help box
	nHeight:= aMsg[nIndex,2]; nWidth:= aMsg[nIndex,3]
	nTop := 15 - (nHeight/2); nBot  := nTop  + (nHeight-1)
	nLeft:= 40 - (nWidth /2); nRight:= nLeft + (nWidth -1)

	// Grab background & clr area
	cScr := SAVESCREEN( nTop,nLeft,nBot,nRight )
	@nTop,nLeft CLEAR TO nBot,nRight

	// Get the lines right
	IF .NOT. lSingle
		@nTop,nLeft TO nBot,nRight DOUBLE
	ELSE
		@nTop,nLeft TO nBot,nRight
	ENDIF

	//
	// Display the message with MEMOEDIT for ease of formatting,
	// but kill MEMOEDIT object immediately, so user's not stuck
	// panning around the help message!
	//
	KEYBOARD CHR( K_CTRL_W )	// Kill the MEMOEDIT immediately
	MEMOEDIT( aMsg[nIndex,1], nTop+1, nLeft+1, nBot-1, nRight-1, .F. )

	//Handle keystrokes
	WHILE ( nKey := INKEY(0) ) != K_ESC
		DO CASE

			CASE nKey == K_PGUP
				IF nIndex > 1
					RESTSCREEN( nTop,nLeft,nBot,nRight, cScr )
					SETCOLOR( nColor )
					SETCURSOR( nCursor )
					HelpBox( aMsg, --nIndex )

					RETURN NIL

				ELSE
					cBox := SAVESCREEN( 13,21,15,58 )
					@13,21 CLEAR TO 15,58
					@13,21 TO 15,58
					@14,22 SAY " There is no preceding HELP screen. "
					TONE( 500, 2 )	// Exactly like Novell's beep!
					INKEY( 2 )
					RESTSCREEN( 13,21,15,58, cBox )

				ENDIF

			CASE nKey == K_PGDN
				IF nIndex < LEN( aMsg )
					RESTSCREEN( nTop,nLeft,nBot,nRight, cScr )
					SETCOLOR( nColor )
					SETCURSOR( nCursor )
					HelpBox( aMsg, ++nIndex )

					RETURN NIL

				ELSE
					cBox := SAVESCREEN( 13,23,15,55 )
					@13,23 CLEAR TO 15,55
					@13,23 TO 15,55
					@14,24 SAY " This is the last help screen. "
					TONE( 500, 2 )	// Exactly like Novell's beep!
					INKEY( 2 )
					RESTSCREEN( 13,23,15,55, cBox )

				ENDIF

			CASE nKey == K_F1
				//
				// Show Key Mapping Help
				//

			OTHERWISE
				//
				// Throw up "not a valid key" box
				//

		ENDCASE

	END

	// Clean up
	RESTSCREEN( nTop,nLeft,nBot,nRight, cScr )
	SETCOLOR( nColor )
	SETCURSOR( nCursor )

RETURN NIL





//
// Cool timer; called by NOVLIB IniTimEvt() function
//
FUNCTION EFunc()
	LOCAL cOldColor:=SETCOLOR(), cTime:="", cHour:=""
	LOCAL nRow, nCol, nCurCurs

	// Get ready...
	nRow := ROW()
	nCol := COL()
	Color(2)

	// Assemble string
	cTime := cFullTime()

	// Kill cursor and output string
	nCurCurs := SETCURSOR( 0 )	// Cursor off; save prev
	@ 1,70 SAY cTime

	// Clean up
	SETCURSOR( nCurCurs )		// Reinstate original cursor
	@nRow,nCol SAY ""			// Move to orig position
	SETCOLOR( cOldColor )		// Restore color

RETURN NIL




//
// Convert a numeric object type to a descriptive string
//
FUNCTION cObjType( nType )
	LOCAL cType

	// Pretty much self-explanatory
	DO CASE
		CASE nType == OT_USER
			cType := "User"
		CASE nType == OT_USER_GROUP
			cType := "Group"
		CASE nType == OT_PRINT_SERVER
			cType := "Print Server"
		OTHERWISE
			cType := "Unknown"
	ENDCASE

RETURN cType




//
// Convert a date value to a formatted text string
// For example, 10/20/94 would become "October 20, 1994"
//
FUNCTION cFullDate( dInDate )
	RETURN CMONTH( dInDate )             					+ " "  + ;
		   ALLTRIM(STR(VAL( SUBSTR(DTOC( dInDate ),4,2) )))	+ ", " + ;
		   STR( YEAR(dInDate), 4 )



//
// Return the time, formatted for 12-hour am/pm
//
FUNCTION cFullTime( cTime, lShowSec )
	LOCAL nHour   := IIF(VALTYPE(cTime)!="U", ;
						VAL(LEFT(cTime,2))  , ;
						VAL(LEFT(TIME(),2))   ;
						)
	LOCAL nTimLng := IIF( lShowSec == .T., 6, 3 )

RETURN	IIF( nHour > 12,          		  ;
			STR( nHour-12, 2 ),   		  ;
			STR( nHour   , 2 )    		  ;
			)                   		+ ;
		IIF(VALTYPE(cTime)!="U", 		  ;
			SUBSTR( cTime, 3, nTimLng ),  ;
			SUBSTR( TIME(), 3, nTimLng )  ;
			)  							+ ;
		IIF( nHour > 12, " pm", " am" )



//
// Convert a byte (from ITMPRPSETBYTE(), for example) to a 2-byte hex string
//
FUNCTION HexByte( nValue )

	LOCAL LookTbl := {  "0","1","2","3","4","5","6","7", ;
						"8","9","A","B","C","D","E","F"    }

RETURN  LookTbl[ int(nValue / 16) + 1 ] + ;	// 'Sixteens' digit
		LookTbl[    (nValue % 16) + 1 ]		// 'Ones' digit




//
// Wait for ESC, allowing for Help key
//
FUNCTION WaitEsc( cProc, nLine, cVar )
	LOCAL nKey

	WHILE (nKey := INKEY(0)) != K_ESC
		IF nKey == K_F1
			Help( cProc, nLine, cVar )	// Pass values from prev fn
		ENDIF
	END

RETURN NIL




///////////////////////////////////////////////////
//                                               //
// Special GET system modifications/replacements //
//                                               //
///////////////////////////////////////////////////

#include "getexit.ch"

//
// Yes/No GET that returns "Yes" or "No " when Y or N pressed
//
FUNCTION GetYN( oGet )
	LOCAL nKey, nCursor := SETCURSOR( 0 )

	oGet:display()

	// Read the GET if the WHEN condition is satisfied
	IF ( GetPreValidate( oGet ) )

		// Activate the GET for reading
		oGet:setFocus()

		WHILE ( oGet:exitState == GE_NOEXIT )

			// Check for initial typeout (no editable positions)
			IF ( oGet:typeOut )
				oGet:exitState := GE_ENTER
			ENDIF

			// Apply keystrokes until exit
			WHILE ( oGet:exitState == GE_NOEXIT )

				nKey := INKEY(0)
				// Activate cursor
				SETCURSOR( 1 )

				DO CASE

					CASE (nKey == ASC("Y")) .OR. (nKey == ASC("y"))
						oGet:varPut("Yes")

					CASE (nKey == ASC("N")) .OR. (nKey == ASC("n"))
						oGet:varPut("No ")

					CASE nKey == K_ESC	// Translate ESC into Ctrl-W
						GetApplyKey( oGet, K_CTRL_W )

					OTHERWISE
						GetApplyKey( oGet, nKey )

				END CASE

				oGet:updateBuffer()

			END

			// Disallow exit if the VALID condition is not satisfied
			IF ( !GetPostValidate( oGet ) )
				oGet:exitState := GE_NOEXIT
			ENDIF

		END

		// De-activate the GET

		oGet:killFocus()

	ENDIF

	SETCURSOR( nCursor )

RETURN NIL



//
// Pick List GET
//
// Statistics for size and behavior of the pick list box are
// passed in an array in the instance variable oGet:cargo.
// The first 7 elements are passed directly to ExpBox(), and
// the eighth is a subarray of text vars for the ACHOICE().
//
FUNCTION GetChoice( oGet )
	LOCAL nKey,cScr,nChoice,nCursor := SETCURSOR( 0 )

	oGet:display()

	// Read the GET if the WHEN condition is satisfied
	IF ( GetPreValidate( oGet ) )

		// Activate the GET for reading
		oGet:setFocus()

		WHILE ( oGet:exitState == GE_NOEXIT )

			// Check for initial typeout (no editable positions)
			IF ( oGet:typeOut )
				oGet:exitState := GE_ENTER
			ENDIF

			// Apply keystrokes until exit
			WHILE ( oGet:exitState == GE_NOEXIT )

				nKey := INKEY(0)
				// Activate cursor
				SETCURSOR( 1 )

				DO CASE

					// Translate ESC into Ctrl-W
					CASE nKey == K_ESC
						GetApplyKey( oGet, K_CTRL_W )

					// These keys get passed straight through
					CASE (nKey == K_F1    ) .OR. ;
						 (nKey == K_UP    ) .OR. ;
						 (nKey == K_DOWN  )
						GetApplyKey( oGet, nKey )

					// These keys get ignored
					CASE (nKey == K_LEFT  ) .OR. ;
						 (nKey == K_RIGHT ) .OR. ;
						 (nKey == K_TAB   ) .OR. ;
						 (nKey == K_SH_TAB)
						// Do nothing!

					// Anything else,
					OTHERWISE
						IIF(nKey!=K_ENTER, TONE(500,2), )

						cScr := ExpBox( oGet:cargo[1],;
										oGet:cargo[2],;
										oGet:cargo[3],;
										oGet:cargo[4],;
										oGet:cargo[5],;
										oGet:cargo[6],;
										oGet:cargo[7] ;
										)

						Color(3)

						nChoice := ACHOICE( oGet:cargo[1]+3,;
											oGet:cargo[2]+3,;
											oGet:cargo[3]-1,;
											oGet:cargo[4]-1,;
											oGet:cargo[8],,,;
											ASCAN( oGet:cargo[8], ;
												   oGet:varGet()  ;
													)             ;
											)

						IF nChoice != 0		// If other than ESC
							oGet:varPut( oGet:cargo[8][nChoice] )
						ENDIF

						RESTSCREEN( oGet:cargo[1],;
									oGet:cargo[2],;
									oGet:cargo[3],;
									oGet:cargo[4], cScr )

						IF nChoice != 0
							oGet:exitState := GE_ENTER
						ENDIF

				END CASE

				oGet:updateBuffer()

			END

			// Disallow exit if the VALID condition is not satisfied
			IF ( !GetPostValidate( oGet ) )
				oGet:exitState := GE_NOEXIT
			ENDIF

		END

		// De-activate the GET

		oGet:killFocus()

	ENDIF

	SETCURSOR( nCursor )

RETURN NIL



/***
*
*  GetReader()
*
*  Standard modal read of a single GET
*
*  Modified for PCONSOL2 by Rich Miller
*
*/
PROCEDURE GetReader( oGet )
	LOCAL nCursor := SETCURSOR( 0 )		// Kill cursor but save state

	// Read the GET if the WHEN condition is satisfied
	IF ( GetPreValidate( oGet ) )

		// Activate the GET for reading
		oGet:setFocus()

		WHILE ( oGet:exitState == GE_NOEXIT )

			// Check for initial typeout (no editable positions)
			IF ( oGet:typeOut )
				oGet:exitState := GE_ENTER
			ENDIF

			// Apply keystrokes until exit
			WHILE ( oGet:exitState == GE_NOEXIT )
				GetApplyKey( oGet, INKEY( 0 ) )
				// Activate cursor
				SETCURSOR( 1 )
			ENDDO

			// Disallow exit if the VALID condition is not satisfied
			IF ( !GetPostValidate( oGet ) )
				oGet:exitState := GE_NOEXIT
			ENDIF
		ENDDO

		// De-activate the GET
		oGet:killFocus()

	ENDIF

	SETCURSOR( nCursor )				// Restore cursor to prev state

RETURN
