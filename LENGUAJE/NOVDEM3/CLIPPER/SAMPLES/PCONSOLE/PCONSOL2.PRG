
/****************************************************************************
 *                                                                          *
 * PCONSOL2.PRG  V1.00 แ                                                    *
 * NOVLIB Demonstration program                                             *
 * (C) 1994 ASM Inc.  All Rights Reserved.                                  *
 *                                                                          *
 * by Rich Miller, with help from Goth                                      *
 *                                                                          *
 ****************************************************************************/

#include "ACHOICE.ch"
#include "INKEY.ch"
#include "novlib.ch"

#define PC2_VERSION "1.00"

MEMVAR cpMenuName	// Okay, so I had to make one concession to PUBLIC!

STATIC aPassMe[2]

// ******************************************************************
// *ษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป*
// *บ         Main program code and "look and feel" inits          บ*
// *ศออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ*
// ******************************************************************
FUNCTION Main( cCmdLine )
	// Set up the menu
	LOCAL aPrompts := { ;
						{"Change Current File Server", {|| ChgFS()  }}, ;
						{"Print Queue Information   ", {|| PQInfo() }}, ;
						{"Print Server Information  ", {|| PSInfo() }}  ;
					 }

	IF ( .NOT. EMPTY(cCmdLine) ) .AND. ( "?" $ cCmdLine )
		// Help message
		? "PCONSOL2, Copyright 1995 Blinkinc"
		? "Press Alt-F1 while running for credits" ; ?
		RETURN NIL
	ENDIF

	// 'Secret' credits screen
	SET KEY K_ALT_F1 TO CredScrn

	// Behavioral switches
	SET SCOREBOARD OFF
	SET CURSOR OFF
	READEXIT(.F.)
	CLS
    SETCANCEL( .F. )			// Comment to enable Ctrl-Break and Alt-C

	// NetWare-esque "Splash Screen."
	// Really only for looks; 2 sec delay.
	BlueSplash()

	// Draw the background...
	BackGnd("NetWare Print Console II  V" + PC2_VERSION)
	UserTitle()              	// Tell the user who he/she is
	TIMEVTINI( "EFunc", -10 )   // Set up a 10-sec-update clock

	// Main Menu
	NWMenu( 8,25,14,54, ;
		"Available Options", aPrompts,,, .T., "PConsol2", "Main" )

	// Clean up before exiting to DOS
	TIMEVTINI( "EFunc" )        // Kill the timer
	SET COLOR TO                // Vanilla DOS colors
	CLS							// Wipe screen
	SET(_SET_CURSOR,1)			// Restore the cursor

RETURN NIL

// ********************************************************************
// *ษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป*
// *บ                    Main program code ends                      บ*
// *ศออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ*
// ********************************************************************



// ********************************************************************
// **                  ChgFS() -- Change File Server                 **
// ********************************************************************
FUNCTION ChgFS()
	LOCAL Servers[8],ServerNo,OldServer,NewServer,screen1,nCurrPos
	cpMenuName := "NOHELP"

	//
	// Compile a list of all file servers for the user to choose from
	//

	OldServer := FSPREFCONGET()		// Save current server

	// Use FSSETPREF() to get all servers
	FOR ServerNo = 1 TO 8
		// What test should we use here?
  		IF !EMPTY( FSNMEGET(ServerNo) )
			FSPREFCONSET(ServerNo)
    		Servers[ServerNo] := ;
				PADR(FSNMEGET(),20)+"ณ "+PADR(WSLOGNMEGET(),24)
		ENDIF
	NEXT
	Servers := ASORT( Servers )		// Sort the array for looks

	FSPREFCONSET( OldServer )			// Reinstate current server

	// Draw the choice box
	screen1 := SAVESCREEN(8,17,19,62)
	ExpBox(8,17,19,62," File Server           User Name",.f.)
	Color(3)
	@ 11,19 TO 18,19
	@ 11,40 TO 18,40

	// Make sure we're pointing to the current svr in ACHOICE()
	nCurrPos := ;
		ASCAN(Servers, PADR(FSNMEGET(),20)+"ณ "+PADR(WSLOGNMEGET(),24) )

	// Show the choices
	IF (NewServer := ACHOICE( 11,20,18,61,Servers,,,nCurrPos )) != 0
  		FSPREFCONSET( FSCONIDGET( ALLTRIM( LEFT( Servers[NewServer], 20 ) ) ) )
	ENDIF

	UserTitle()						// Tell us who we are

	RESTSCREEN(8,17,19,62,screen1)

RETURN NIL




// ********************************************************************
// **                  PQInfo() -- Print Queue Info                  **
// ********************************************************************
FUNCTION PQInfo()
	STATIC nQID
	LOCAL aQueues[8], cQueue, nIndex, nChoice, nOldChoice := 1
	LOCAL aQInfo[7], Jobs[100], cBox1

	cpMenuName := "PQIList"		// Announce for HELP's benefit
	//@0,0 SAY PADR( cpMenuName, 15 )

	// Grab names of all queues
	nIndex := 1
	cQueue = FSOBJLST( "*", OT_PRINT_QUEUE )	// Search for all queues
	WHILE .not. EMPTY( cQueue )
		aQueues[nIndex] := cQueue
		nIndex++
		cQueue = FSOBJLST()						// Keep going until empty
	END
	aQueues := ASORT( aQueues )					// Alpha sort the array

	// Prepare for Print Queues menu
	cBox1 := SAVESCREEN( 6,6,22,31 )
	ExpBox(6,6,22,31," Print Queues",.t.)
	Color(3)
	@ 9,29 TO 21,29

	// Wait here for ESC if no queues available
	IF nIndex == 1
		WaitEsc( PROCNAME(), PROCLINE(), READVAR() )
	ENDIF

	// Go on if queues are available
	WHILE (nChoice := ACHOICE(9,9,21,28, aQueues,,, nOldChoice)) != 0

		nOldChoice := nChoice		// Save nChoice for later

		// Get Queue ID from nChoice for later use
		nQID := OBJIDGET( aQueues[nChoice], OT_PRINT_QUEUE )

   		ExpBox(6,6,22,31," Print Queues",.t.,.f.)

		// Prepare for Print Queue Information menu

		aQInfo := ;
	  {	{"Current Print Job Entries ", {|nQID| PJEntries(nQID)          }},;
		{"Current Queue Status      ", {|nQID| PQStatus(nQID)           }},;
		{"Currently Attached Servers", {|nQID| CurrSvrs(nQID)           }},;
		{"Print Queue ID            ", {|nQID| PQID(nQID)               }},;
		{"Queue Operators           ", {|nQID| QList(nQID,"Q_OPERATORS")}},;
		{"Queue Servers             ", {|nQID| QList(nQID,"Q_SERVERS"  )}},;
		{"Queue Users               ", {|nQID| QList(nQID,"Q_USERS"    )}}  }

		// Put it all in a NetWare-esque menu; pass nQID for code block
		NWMenu( 9,44,19,73, ;
			"Print Queue Information", aQInfo, nQID,,,,, "PQInfo" )

		// Clean up...
   		ExpBox(6,6,22,31," Print Queues",.t.,.t.)
		Color(3)

	END

	RESTSCREEN( 6,6,22,31, cBox1 )

RETURN NIL		// ***************** PQInfo() end *************************



///////////////////////
// Print Job Entries //
///////////////////////
FUNCTION PJEntries( nQID )
	STATIC CurrJob
	LOCAL cBox3, QScr
	LOCAL JobCount, JobNumber, JobChoice, Jobs[100], nKey
	LOCAL aPacket

	//LOCAL aTargSvrs[9], nNumServers := 0, cPServer

	// GET variables
	LOCAL oGet1,oGet2,oGet3
	LOCAL lUsrHold,lOpHold,lDefer

	LOCAL cDesc,cUsrHold,cOpHold,nSrvSeq,nCopies
	LOCAL cDefer,dDefDate,cDefTime

	LOCAL GetList := {}

	LOCAL lCleared

	// Put up list of jobs in the queue
	cBox3 := ExpBox(4,0,24,79,"",.t.)

	@ 5,3 SAY ;
		"Seq Banner Name  Description" + space(31) + "Form Status  Job"

	//
	// Get a list of all print jobs and their info
	// for the ACHOICE()
	//

	// Assemble the array of print jobs from which user will select
	JobCount := QUEQJBLST(nQID)
	FOR CurrJob = 1 TO JobCount
		JobNumber := QUEQJBLST()

		// Build the string for the selection list
		Jobs[CurrJob] := ;
			PADL(STR(CurrJob,3),3)								+ " " + ;
			PADR(LEFT(QJBBANSET(nQID,JobNumber),12),12)			+ " " + ;
			PADR(LEFT(QJBDSCSET(nQID,JobNumber),41),41)		+ " " + ;
			PADL(STR(0,4),4)									+ " " + ;
			IIF(QJBADDTST(nQID,JobNumber),"Adding","Ready ")	+ " " + ;
			STR(JobNumber,5)			// Done building string
	NEXT


	// Put up the famous "Queue Entries" screen (the heart of PCONSOLE)

	DO WHILE .t.
		Color(3)

		// If no entries, hold screen here anyway
		IF JobCount == 0
			WaitEsc( PROCNAME(), PROCLINE(), READVAR() )
		ENDIF

		// So the ACHOICE() handler can see 'em
		aPassMe[1] := JobNumber
		aPassMe[2] := nQID

		// If there are entries, continue here
		IF (JobChoice := ACHOICE(7,3,20,78,Jobs,,"PJHandler")) == 0
			exit						// Back out on ESC
		else
			CurrJob := val(right(Jobs[JobChoice],5))

			// Establish whether it's OK to edit the record
			lCleared := ;
				QUEOPRTST(WSLOGNMEGET(),OBJNMEGET(nQID)) ;
					.OR. ;
				WSLOGNMEGET() == OBJNMEGET(QJBUSRIDGET(nQID,CurrJob))

			//
			// Set up vars for GETs
			//
			cDesc    := PADR( QJBDSCGET(nQID,CurrJob), 49 )
			lUsrHold := QJBUSRHLDGET(nQID,CurrJob)
			cUsrHold := IIF(lUsrHold, "Yes", "No " )
			lOpHold  := QJBOPRHLDGET(nQID,CurrJob)
			cOpHold  := IIF(lOpHold, "Yes", "No " )
			nSrvSeq  := QJBPSNGET(nQID,CurrJob)
			nCopies  := QJBCPYGET(nQID,CurrJob)
			lDefer   := !EMPTY(QJBDEFDTEGET(nQID,CurrJob))
			cDefer   := IIF(lDefer, "Yes", "No " )
			dDefDate := QJBDEFDTEGET(nQID,CurrJob)
			cDefTime := QJBDEFTMEGET(nQID,CurrJob)

			//
			// Keep Drawing...
			//
			Color(1)

			QScr := ExpBox(4,0,24,79,"Print Queue Entry Information",.t.)
			@ 7,2 CLEAR TO 23,2 		// Erase line to left of box

			@ 7, 1 SAY "Print job:"
			@ 8, 1 SAY "Client:"
			@ 9, 1 SAY "Description:"
			@10, 1 SAY "Status:"
			@12, 1 SAY "User Hold:"
			@13, 1 SAY "Operator Hold:"
			@14, 1 SAY "Service Sequence:"

			@16, 1 SAY "Number of copies:"
			@17, 1 SAY "File contents:"
			@18, 1 SAY "Tab size:"
			@19, 1 SAY "Suppress form feed:"
			@20, 1 SAY "Notify when done:"
			@22, 1 SAY "Target server:"

			@ 7,39 SAY "File size:     "
			@12,39 SAY "Job Entry Date:"
			@13,39 SAY "Job Entry Time:"
			@16,39 SAY "Form:          "
			@17,39 SAY "Print banner:  "
			@18,39 SAY "Name:          "
			@19,39 SAY "Banner name:   "
			@21,39 SAY "Defer printing:"
			@22,39 SAY "Target date:   "
			@23,39 SAY "Target time:   "

			Color(3)

			SETCOLOR( ",,,,W+/B" )

		DISPBEGIN()		// Buffer rest of screen output for snappy display

			//
			// Display unchangeable info
			//
			@ 7,21 SAY LTRIM(STR(CurrJob))
			@ 8,21 SAY TRIM(SUBSTR(USRNMEGET(QJBUSRIDGET(nQID,CurrJob)),1,35)) + ;
						"[" + LTRIM(STR(QJBWSGET(nQID,CurrJob))) + "]"
			@10,21 SAY IIF(QJBADDTST(nQID,CurrJob),"Adding",;
						"Ready To Be Serviced, Waiting For Print Server")

			@ 7,58 SAY LTRIM( STR(QJBSIZEGET(nQID,CurrJob)) )
			@12,58 SAY cFullDate( QJBDTEGET(nQID,CurrJob) )
			@13,58 SAY LTRIM( cFullTime( QJBTMEGET(nQID,CurrJob), .T. ) )

			// Not yet supported by NOVLIB
			@17,21 SAY "*" // File Contents
			@18,21 SAY "*" // Tab Size
			@19,21 SAY "*" // Suppress FF
			@20,21 SAY "*" // Notify when done
			@22,21 SAY "*" // Target Server
		 	@16,58 SAY "*" // Form
			@17,58 SAY "*" // Print Banner
			@18,58 SAY "*" // Name
			@19,58 SAY "*" // Banner Name

			//
			// Parade of the GETs
			//

			@9,21 GET cDesc PICTURE "@K "+REPLICATE("X",49) WHEN lCleared

			// Yes/No GET
			@12,21 SAY cUsrHold
            oGet1 := GetNew( 12,21,, "cUsrHold", "AAA" )
			oGet1:preBlock:= {|| lCleared }
			oGet1:block   := {|cVal| IF(PCOUNT()>0, cUsrHold:=cVal, cUsrHold) }
			oGet1:reader  := {|oGet| GetYN(oGet) }
            AADD( GetList, oGet1 )

			// Yes/No GET
			@13,21 SAY cOpHold
            oGet2 := GetNew( 13,21,, "cOpHold", "AAA" )
			oGet2:preBlock:= {|| lCleared }
			oGet2:block   := {|cVal| IF(PCOUNT()>0, cOpHold:=cVal, cOpHold) }
			oGet2:reader  := {|oGet| GetYN(oGet) }
            AADD( GetList, oGet2 )

			@14,21 GET nSrvSeq PICTURE "@B 999" WHEN lCleared
			@16,21 GET nCopies PICTURE "@B 99999" WHEN lCleared

			// Yes/No GET
			@21,58 SAY cDefer
            oGet3 := GetNew( 21,58,, "cDefer", "AAA" )
			oGet3:preBlock:= {|| lCleared }
			oGet3:block   := {|cVal| IF(PCOUNT()>0, cDefer:=cVal, cDefer) }
			oGet3:reader  := {|oGet| GetYN(oGet) }
            AADD( GetList, oGet3 )

			@22,58 GET dDefDate WHEN cDefer == "Yes" .AND. lCleared
			@23,58 GET cDefTime WHEN cDefer == "Yes" .AND. lCleared

		DISPEND()		// Flush screen update buffer

			SET CURSOR ON
			READ
			SET CURSOR OFF

			IF .NOT. lCleared
				WaitEsc( PROCNAME(), PROCLINE(), READVAR() )
			ELSE
				//
				// Translate and set all results
				//
				QJBDSCSET(nQID,CurrJob,cDesc)
				QJBUSRHLDSET(nQID,CurrJob,(cUsrHold=="Yes"))
				QJBOPRHLDSET(nQID,CurrJob,(cOpHold=="Yes"))
				QJBPSNSET(nQID,CurrJob,nSrvSeq)
				QJBCPYSET(nQID,CurrJob,nCopies)
				QJBDEFDTESET(nQID,CurrJob,dDefDate)
				QJBDEFTMESET(nQID,CurrJob,cDefTime)
			ENDIF

		ENDIF

		// Clean up...
		RESTSCREEN(4,0,23,79,Qscr)

	END

	RESTSCREEN( 4,0,24,79, cBox3 )

RETURN NIL




//
// Handle obscure keyboard stuff for PJEntries()' ACHOICE()
//
FUNCTION PJHandler( nMode, nCurElement, nRowPos )
	LOCAL nRetVal := AC_CONT, nKey := LASTKEY()
	LOCAL cBox, nChoice
	DO CASE

		// Default stuff
		CASE nMode == AC_IDLE
			nRetVal := AC_CONT
		CASE nMode == AC_HITTOP
			TONE( 100, 3 )
		CASE nMode == AC_HITBOTTOM
			TONE( 100, 3 )

		// Here's where it gets interesting
		CASE nMode == AC_EXCEPT
			DO CASE
				CASE nKey == K_RETURN
					nRetVal := AC_SELECT
				CASE nKey == K_ESC
					nRetVal := AC_ABORT

				//
				// New keys go here!
				//
				CASE nKey == K_DEL
					//
					// Ask: delete current print job?
					//

					// Dehilite Box
					ExpBox(4,0,24,79,;
						"  Seq Banner Name  Description" ;
						+ space(31) + "Form Status  Job",;
						.f.,.f.)

					cBox := ExpBox( 11,29,16,50," Delete Queue Entry",.T. )

					color(3)
					nChoice := ACHOICE( 14,32,15,49, {"No","Yes"},,,2 )

					IF nChoice == 2
						//QueDelQjb( aPassMe[2], aPassMe[1] )
						ALERT( "Job "+LTRIM(STR(aPassMe[1])) ;
							+ ", Queue " + LTRIM(OBJNMEGET(aPassMe[2])) ;
							+" would have been deleted." ;
							)
					ENDIF

					RESTSCREEN( 11,29,16,50, cBox )

					// Re-hilite box
					ExpBox(4,0,24,79,;
						"  Seq Banner Name  Description" ;
						+ space(31) + "Form Status  Job",;
						.f.,.t.)

				CASE nKey == K_INS
					// Add new print job (?)

				OTHERWISE
					nRetVal := AC_GOTO
			ENDCASE
	ENDCASE

RETURN nRetVal



//
// Delete a Queue Job if have sufficient rights...
//
FUNCTION DelJob( nQID, nJob )
	// Still expanding here...
RETURN NIL




////////////////////////
// Print Queue Status //
////////////////////////
FUNCTION PQStatus( nQID )
	LOCAL cBox1, nCount := 0, nSvrID, lCleared, lSuccess
	LOCAL GetList := {}, oGet1, oGet2, oGet3
	LOCAL cCanPlace, cCanSvc, cCanAtch

	// Check whether we've got queue operator status
	lCleared := IIF( QUEOPRTST( WSLOGNMEGET(), OBJNMEGET(nQID) ), .T., .F. )

	// Count the number of attached servers
	nSvrID := SETPRPVALGET( OBJNMEGET(nQID), OT_PRINT_QUEUE, ;
						"Q_SERVERS", nCount + 1 )
	WHILE ( nSvrID != 0 )
		nCount++
		nSvrID := SETPRPVALGET( OBJNMEGET(nQID), OT_PRINT_QUEUE, ;
						"Q_SERVERS", nCount + 1 )
	END

	// GET variables
	cCanPlace := IIF(  QUEADDGET( nQID ), "Yes", "No " )
	cCanSvc   := IIF(!QUEHALTGET( nQID ), "Yes", "No " )
	cCanAtch  := IIF(  QUESRVSTASET( nQID ), "Yes", "No " )

	cBox1 := SAVESCREEN( 9,16,19,63 )

	SingleBox( 9,16,19,63, "Current Queue Status" )

	@12,17 SAY "Number of entries in queue:"
	@13,17 SAY "Number of servers attached:"
	@15,17 SAY "Operator Flags"
	@16,17 SAY "   Users can place entries in queue:"
	@17,17 SAY "   Servers can service entries in queue:"
	@18,17 SAY "   New servers can attach to queue:"

	Color(3)

	SETCOLOR( ",,,,W+/B" )		// Special for unselected GETs

	@12,59 SAY "  " + LTRIM( STR( QUEQJBLST( nQID ) ) )	// # of print jobs
	@13,59 SAY PADL( ALLTRIM( STR( nCount ) ), 3 )		// # of servers

	IF lCleared
		// Special Yes/No GET object
		@16,59 SAY cCanPlace
        oGet1 := GetNew( 16,59,, cCanPlace, "AAA" )
		oGet1:block := {|cVal| IF(PCOUNT()>0, cCanPlace:=cVal, cCanPlace) }
		oGet1:reader := {|oGet| GetYN(oGet) }
        AADD( GetList, oGet1 )

		// Special Yes/No GET object
		@17,59 SAY cCanSvc
        oGet2 := GetNew( 17,59,, cCanSvc, "AAA" )
		oGet2:block := {|cVal| IF(PCOUNT()>0, cCanSvc:=cVal, cCanSvc) }
		oGet2:reader := {|oGet| GetYN(oGet) }
        AADD( GetList, oGet2 )

		// Special Yes/No GET object
		@18,59 SAY cCanAtch
        oGet3 := GetNew( 18,59,, cCanAtch, "AAA" )
		oGet3:block := {|cVal| IF(PCOUNT()>0, cCanAtch:=cVal, cCanAtch) }
		oGet3:reader := {|oGet| GetYN(oGet) }
        AADD( GetList, oGet3 )

		SET CURSOR ON

		READ

		SET CURSOR OFF


		//
		// Handle YES-NO / .T.-.F. conversion
		//
		// May require some checking,
		// but we've got clearance if we're here at all
		//

		QUEADDSET( nQID, ("Y" $ cCanPlace) )

		IIF( NWGETERROR()!=0, ALERT("ERROR 1"), )

		IF ( "Y" $ cCanPlace ) != QUEADDGET(nQID)
			ALERT("ERROR 1A")
		ENDIF


		QUEHALTSET( nQID, ("N" $ cCanSvc) )

		IIF( NWGETERROR()!=0, ALERT("ERROR 2"), )

		IF ( "N" $ cCanSvc ) != QUEHALTGET(nQID)
			ALERT("ERROR 2A")
		ENDIF


		QUESRVSTASET( nQID, ("Y" $ cCanAtch) )

		IIF( NWGETERROR()!=0, ALERT("ERROR 3"), )

		IF ( "Y" $ cCanAtch ) != QUESRVSTAGET(nQID)
			ALERT("ERROR 3A")
		ENDIF


	ELSE
		@16,59 SAY cCanPlace
		@17,59 SAY cCanSvc
		@18,59 SAY cCanAtch
		WaitEsc( PROCNAME(), PROCLINE(), READVAR() )

	ENDIF


	RESTSCREEN( 9,16,19,63, cBox1 )

RETURN NIL




////////////////////////////////
// Currently Attached Servers //
////////////////////////////////

// This is lengthy because we need to
// riffle through the Bindery for attached servers
// (No NOVLIB function to do this yet!)

// ** Remember to test with multiple servers for screen painting!! **

FUNCTION CurrSvrs( nQID )
	LOCAL cBox1, nNumServers, nCount, aServers[8], cPServer
	LOCAL nTop, nBot

	//
	// Get list of PServers currently connected & the list's length
	//

	// Initialize
	nNumServers := 0

	/*******************************************************************
	 *                                                                 *
	 * Since NOVLIB does not currently offer a function to return a    *
	 * list of the print servers attached to a given queue, CurrSvrs() *
	 * uses NOVLIB's SETPRPSETVAL() function to retrieve the values of *
	 * the Q_SERVERS property for the current queue.                   *
	 *                                                                 *
	 *******************************************************************/

	// Get the first attached server
	cPServer := OBJNMEGET(                    ;
					SETPRPVALGET(             ;
							OBJNMEGET(nQID),  ;
							OT_PRINT_QUEUE,   ;
							"Q_SERVERS",      ;
							1                 ;
						   )                  ;
						  )

	// Get the rest, if any
	WHILE ( !EMPTY( cPServer ) ) .AND. ( NWERRORGET() == 0 )

		nNumServers++
		aServers[ nNumServers ] := cPServer

		cPServer := OBJNMEGET(                    ;
						SETPRPVALGET(             ;
								OBJNMEGET(nQID),  ;
								OT_PRINT_QUEUE,   ;
								"Q_SERVERS",      ;
								nNumServers + 1   ;
							   )                  ;
							  )

	END

	// Insert dummy value if no servers found
	IF EMPTY( aServers[1] )
		nNumServers := 1
		aServers[ nNumServers ] := "NONE"
	ENDIF

	// Calculate box vertical dimensions from list length
	nTop := MAX( 13 - nNumServers, 5 )	// Just guessing here
	nBot := MIN( 17 - nNumServers, 23 )

	//
	// Show us the list
	//

	cBox1 := SingleBox( nTop, 4, nBot, 36, "Currently Attached Servers" )

	Color(3)

	// Display list on screen, just like NetWare!
	FOR nCount := 1 TO nNumServers
		@( (nTop + 2) + nCount),5 SAY ;
			" ณ" + PADR( aServers[nCount], 20 ) + "ณ   " + "***"
	NEXT

	WaitEsc( PROCNAME(), PROCLINE(), READVAR() )

	RESTSCREEN( nTop, 4, nBot, 36, cBox1 )

RETURN NIL



//////////////////////
// Current Queue ID //
//////////////////////
FUNCTION PQID( nQID )
	LOCAL cBox

	cBox := SAVESCREEN( 18,43,21,74 )

	Color(1)
	@18,43 CLEAR TO 21,74
	@18,43 TO 21,74

	@19,44 SAY "Object ID:  "
	@20,44 SAY "On File Server: "

	Color(3)

	@19,56 SAY NOVSTRHEXGET( nQID )	// NOVLIB: Convert numbers to hex strings
	@20,60 SAY FSNMEGET()			// NOVLIB: Name of the current server

	WaitEsc( PROCNAME(), PROCLINE(), READVAR() )

	RESTSCREEN( 18,43,21,74, cBox )

RETURN NIL




////////////////////////////
// List Queue Prop Values //
////////////////////////////
FUNCTION QList( nQID, cQProp )
	LOCAL screen1, cListItem, aList[255], nCount := 0, nItemID, cTitle

	// Compile a list of the specified property's values (via cQProp)

	nItemID := SETPRPVALGET( OBJNMEGET(nQID), ;
			   	 		OT_PRINT_QUEUE,   ;
			   	 		cQProp,           ;
			   	 		nCount + 1        ;
						)

	cListItem := PADR(OBJNMEGET( nItemID ), 18) + ;
				 "ณ (" + cObjType( OBJTYPGET( nItemID ) ) + ")"

	WHILE nItemID != 0	// While not turning up blanks
		nCount++
		aList[ nCount ] := cListItem
		nItemID := SETPRPVALGET( OBJNMEGET(nQID), ;
				   	 		OT_PRINT_QUEUE,   ;
				   	 		cQProp,           ;
				   	 		nCount + 1        ;
							)

		cListItem := PADR( OBJNMEGET( nItemID ), 18) + ;
					 "ณ (" + cObjType( OBJTYPGET( nItemID ) ) + ")"

	END // list compilation

	aList := ASORT( aList )

	// Choose the title to show -- Operators, Servers, Users

	DO CASE
		CASE cQProp == "Q_OPERATORS"
			cTitle := "Operators"
		CASE cQProp == "Q_SERVERS"
			cTitle := "Servers"
		CASE cQProp == "Q_USERS"
			cTitle := "Users"
		OTHERWISE
			cTitle := "* ERROR *"
	ENDCASE

	NWPickList( 6,40,22,77, "Queue " + cTitle, .T., aList, 16 )

RETURN NIL




// ********************************************************************
// **                  PSInfo() -- Print Server Info                 **
// ********************************************************************
FUNCTION PSInfo()
	LOCAL cPSvr, aPSvrs[8], nPSID, aPSInfo
	LOCAL nChoice, nOldChoice, nIndex, cBox1

    // Avoid this menu for now
//    ALERT( "This menu option temporarily disabled." )
//    RETURN NIL
    // Remove these lines when done

	// Prepare for Print Servers menu
	cBox1 := ExpBox(6,6,22,31,"Print Servers",.t.)
	Color(3)
	@ 9,29 TO 21,29

	// Grab names of all pservers
	nIndex := 1
	cPSvr = FSOBJLST( "*", OT_PRINT_SERVER )	// Search for all pservers
	WHILE .not. EMPTY( cPSvr )
		aPSvrs[nIndex] := cPSvr
		nIndex++
		cPSvr = FSOBJLST()						// Keep going until empty
	END
	aPSvrs := ASORT( aPSvrs )					// Alpha sort the array

	// Wait here for ESC if no queues available
	IF nIndex == 1
		WHILE ( INKEY(0) != K_ESC )
		END
	ENDIF

	// Go on if pservers available
	WHILE (nChoice := ACHOICE(9,9,21,28, aPSvrs,,, nOldChoice)) != 0

		nOldChoice := nChoice		// Save choice for later

		// Get Server ID from nChoice for later use
		nPSID := OBJIDGET( aPSvrs[nChoice], OT_PRINT_SERVER )

   		ExpBox(6,6,22,31,"Print Servers",.t.,.f.)

		// Prepare for Print Server Information menu

		aPSInfo := ;
	  {	{"Full Name                  ",{|nPSID|PSFullName(nPSID)           }},;
		{"Print Server ID            ",{|nPSID|PQID(nPSID)                 }},;
		{"Print Server Operators     ",{|nPSID|PSList(nPSID,"PS_OPERATORS")}},;
		{"Print Server Status/Control",{|nPSID|PSStat(nPSID)               }},;
		{"Print Server Users         ",{|nPSID|PSList(nPSID,"PS_USERS")    }} }

		// Put it all in a NetWare-esque menu; pass nPSID for code block
		NWMenu( 6,44,14,74, ;
			"Print Server Information", aPSInfo, nPSID,,,,, "PSInfo" )

		// Clean up...
   		ExpBox(6,6,22,31," Print Servers",.t.,.t.)
		Color(3)

	END

	RESTSCREEN( 6,6,22,31, cBox1 )

RETURN NIL		// ***************** PSInfo() end *************************




//////////////////////////////////////////
// List Print Server Operators or Users //
//////////////////////////////////////////
FUNCTION PSList( nPSID, cPSProp )
	LOCAL screen1, cListItem, aList[255], nCount := 0, nItemID, cTitle

	//
	// Compile a list of the specified property's values (via cPSProp)
	//

	nItemID := SETPRPVALGET( OBJNMEGET(nPSID),;
			   	 		OT_PRINT_SERVER,  ;
			   	 		cPSProp,          ;
			   	 		nCount + 1        ;
						)

	// Construct a string for the ACHOICE() array
	cListItem := PADR(OBJNMEGET( nItemID ), 18) + ;
				 "ณ (" + cObjType( OBJTYPGET( nItemID ) ) + ")"

	WHILE nItemID != 0				// While not turning up blanks
		nCount++
		aList[ nCount ] := cListItem
		nItemID := SETPRPVALGET( OBJNMEGET(nPSID),;
				   	 		OT_PRINT_SERVER,  ;
				   	 		cPSProp,          ;
				   	 		nCount + 1        ;
							)

		cListItem := PADR(OBJNMEGET( nItemID ), 18) + ;
					 "ณ (" + cObjType( OBJTYPGET( nItemID ) ) + ")"
	END

	aList := ASORT( aList )			// Alpha sort the array

	// Choose the title to show -- Operators/Users

	DO CASE
		CASE cPSProp == "PS_OPERATORS"
			cTitle := " Print Server Operators"
		CASE cPSProp == "PS_USERS"
			cTitle := " Server Users"
		OTHERWISE
			cTitle := "* ERROR *"
	ENDCASE

	// Show us the choices
	NWPickList( 6,40,22,77, cTitle, .T., aList, 16 )

RETURN NIL



////////////////////////////
// Print Server Full Name //
////////////////////////////
FUNCTION PSFullName( nPSID )
	LOCAL cBox

	cBox := SAVESCREEN( 19,1,21,77 )

	Color(1)
	// Clear the box
	@19,1 CLEAR TO 21,77
	@19,1 TO 21,77
	@20,3 SAY "Full Name:"

	Color(3)

	IF !EMPTY( OBJPRPLST( OBJNMEGET(nPSID), ;
				OT_PRINT_SERVER, "IDENTIFICATION" ) )

		@20,15 SAY LEFT( ITMPRPVALGET( OBJNMEGET(nPSID), OT_PRINT_SERVER, ;
								"IDENTIFICATION", 1 ), 60 )
	ENDIF

	WHILE INKEY(0) != K_ESC			// Wait for ESC to clear
	END

	RESTSCREEN( 19,1,21,77, cBox )

RETURN NIL




///////////////////////////////////
// Print Server Status / Control //
///////////////////////////////////

#define PI_NOTIFY 1	//
#define PI_STATUS 2 // These values are for the following 2 functions
#define PI_QUEUES 3 //

FUNCTION PSStat( nPSID )
	LOCAL aMenu[5]

	// Log into PSID's pserver
	IF PSWSLOGIN( OBJNMEGET( nPSID ) ) == -1
		ALERT( "Couldn't log into server: " + OBJNMEGET( nPSID ) )
		RETURN NIL
	ENDIF

	aMenu  :=  { ;
		{"File Servers Being Serviced    ", {|| FSServ()           }}, ;
		{"Notify List for Printer        ", {|| PrtInfo(PI_NOTIFY) }}, ;
		{"Printer Status                 ", {|| PrtInfo(PI_STATUS) }}, ;
		{"Queues Serviced by Printer     ", {|| PrtInfo(PI_QUEUES) }}, ;
		{"Server Info                    ", {|| PSvrInfo()         }}  ;
			   }

	NWMenu( 7,42,15,76, ;
		" Print Server Status and Control", aMenu, nPSID,,,,, "PSStat" )

	// Log out again
	IF !PSWSLOGOUT()
		ALERT( "Couldn't log out of server: " + OBJNMEGET( nPSID ) )
		RETURN NIL
	ENDIF

RETURN NIL





/////////////////////////////////////////////////////
// Choose a printer for some of PSStat()'s options //
/////////////////////////////////////////////////////
FUNCTION PrtInfo( nMode )
	LOCAL cBox, cBox2
	LOCAL aPrinters[256], nPIndex, nCount, nAIndex := 1, nChoice := 1
	LOCAL nTop, nBot
	LOCAL bBlock

	// Put up 'Please Wait' box
	SETBLINK(.T.)					// Allow blinking text
	Color(1)
	cBox2 := SAVESCREEN( 12,12,16,26 )
	@12,12 CLEAR TO 16,26
	@12,12 TO 16,26
	@14,14 SAY "Please Wait" COLOR "GR+/B*"


	// This scan is limited to the first
	// 32 printers for speed purposes.
	//
	// For thoroughness, 256 printers
	// (nPIndex 0 to 255) should be checked,
	// but be prepared for a wait!
	//
	FOR nPIndex := 0 TO 32			// Check first 32 printers
		IF PRNSTATGET( nPIndex ) != -1
			aPrinters[nAIndex] := ;
				PADR( PRNNMEGET( nPIndex ), 26 ) + ;
				"ณ " + ;
				PADL( ALLTRIM( STR( nPIndex ) ), 2 )
			nAIndex++
		ENDIF
	NEXT

	asize( aPrinters, --nAIndex )	// Trim aPrinters and nAIndex together

	//
	// Make aPrinters a 2-D array for passing to NWMenu()
	//
	FOR nCount := 1 TO len(aPrinters)

		// Construct code block for each printer
		// based on code passed to function.
		DO CASE
			CASE nMode == PI_NOTIFY
				bBlock := &("{|| NfyList(" + STR(nCount-1,3) + ") }")

			CASE nMode == PI_STATUS
				bBlock := &("{|| PrtStat(" + STR(nCount-1,3) + ") }")

			CASE nMode == PI_QUEUES
				bBlock := &("{|| PrtQList(" + STR(nCount-1,3) + ") }")
		ENDCASE

		// Incorporate the code block into new subarray
		aPrinters[nCount] := { aPrinters[nCount] , bBlock }
	NEXT

	// Calculate T and B of choice box
	nTop := MAX( 13-(nAIndex/2), 5 )
	nBot := MIN( 16+(nAIndex/2), 23 )

	// Clean up
	SETBLINK(.F.)					// Disallow blinking text
	RESTSCREEN( 12,12,16,26, cBox2 )// Blow away "please wait" box

	// Put up the choice box
	NWMenu( nTop,2,nBot,35, ;
		"Active Printers", aPrinters,,,,, "PrtInfo" )

RETURN nChoice




/////////////////////////////////////////////
// List file servers serviced by a pserver //
/////////////////////////////////////////////
FUNCTION FSServ()
	LOCAL cBox, nCount := 0, cServer, aServers[8]

	// Build the array of servers
	cServer := PSFSLIST( .T. )
	WHILE !EMPTY( cServer )
		aServers[++nCount] := cServer
		cServer := PSFSLIST( .F. )
	END

	aServers := ASORT( aServers )	// Alpha sort the array

	NWPickList( 7,42,20,75,"File Servers Being Serviced",.T.,aServers,2 )

RETURN NIL




///////////////////////////////////////////
// List all notify objects for a printer //
///////////////////////////////////////////
FUNCTION NfyList( nPrt )
	LOCAL cBox, nCount := 0, aNfyObj[255], cNfyObj, cNfyStr
	LOCAL nChoice, nOldChoice := 1

	cBox := ExpBox( 7,1,20,78, "", .T. )

	@8,2 SAY "  File Server          Notify Name                " + ;
			   "Notify Type    First  Next"

	//
	// Use PrnLstNfyObj() to get the list of notify objects
	// for the current printer; NfyObjGetSrv(), etc. all
	// operate on the last notify object retrieved by the
	// PrnLstNfyObj() call.
	//

	cNfyObj := PRNNFYOBJLST( nPrt )
	WHILE !EMPTY(cNfyObj)
		cNfyStr :=  PADR(NFYOBJSRVGET(),21) + ;
					PADR(cNfyObj,27) + ;
					PADR(NFYOBJTYPGET(),15) + ;
					PADR(NFYOBJFSTINVGET(),7) + ;
					NFYOBJNXTINVGET()
		aNfyObj[++nCount] := cNfystr
		cNfyObj := PRNNFYOBJLST( nPrt )
	END

	// Wait for ESC if no notify objects
	IF nCount == 0
		WaitEsc( PROCNAME(), PROCLINE(), READVAR() )
	ENDIF

	// Else show the choices
	WHILE (nChoice := ACHOICE( 10,4,19,77, aNfyObj,,,nOldChoice )) != 0
		nOldChoice := nChoice
	END

	// Clean up
	RESTSCREEN( 7,1,20,78, cBox )

RETURN NIL




/////////////////////////////////////////////////
// Give information on the status of a printer //
/////////////////////////////////////////////////
FUNCTION PrtStat( nPrt )
	LOCAL cBox, nStat, nQMode

	DISPBEGIN()		// Calling all these functions can be slow, so
					// buffer screen output for appearance of speed.

	cBox := SingleBox( 5,1,22,78, ("Status of " + PRNNMEGET(nPrt)) )

	@ 8, 2 SAY "Status:           "
	@10, 2 SAY "Service mode:     "
	@11, 2 SAY "Mounted form:     "
	@13, 2 SAY "File server:      "
	@14, 2 SAY "Queue:            "
	@15, 2 SAY "Job number:       "
	@16, 2 SAY "Description:      "
	@17, 2 SAY "Form:             "
	@19, 2 SAY "Copies requested: "
	@20, 2 SAY "Size of 1 copy:   "
	@21, 2 SAY "Percent completed:"
	@19,42 SAY "Finished:"
	@20,42 SAY "Finished:"

	Color(3)

	// Handle Status code
	nStat := PRNSTATGET(nPrt)		// Only check function once
	DO CASE
		CASE nStat == 0
			@ 8,22 SAY "Waiting for job"
		CASE nStat == 1
			@ 8,22 SAY "Waiting for form to be changed"
		CASE nStat == 2
			@ 8,22 SAY "Printing"
		CASE nStat == 3
			@ 8,22 SAY "Paused"
		CASE nStat == 4
			@ 8,22 SAY "Stopped"
		CASE nStat == 5
			@ 8,22 SAY "Marking top of form or ejecting page"
		CASE nStat == 6
			@ 8,22 SAY "Ready to go down"
		CASE nStat == 7
			@ 8,22 SAY "Not connected"
		OTHERWISE
			@ 8,22 SAY "** Unknown **"
	ENDCASE

	// Handle Queue Mode code
	nQMode := PRNQUEMDEGET(nPrt)	// Only check function once
	DO CASE
		CASE nQMode == 0
			@10,22 SAY "Change forms as needed"
		CASE nQMode == 1
			@10,22 SAY "Minimize form changes within queues"
		CASE nQMode == 2
			@10,22 SAY "Never change forms"
		CASE nQMode == 3
			@10,22 SAY "Minimize form changes across queues"
		OTHERWISE
			@10,22 SAY "** Unknown **"
	ENDCASE

	@11,22 SAY ALLTRIM(STR(PRNFRMNUMGET(nPrt)))

	// Only do the rest if there's a print job up...
	IF PJBFRMNUMGET(nPrt) != -1
		@13,22 SAY PRNQUEFSGET(nPrt)
		@14,22 SAY PJBQUEGET(nPrt)
		@15,22 SAY ALLTRIM(STR(PJBNUMGET(nPrt)))
		@16,22 SAY PJBDESCGET(nPrt)
		@17,22 SAY PRNFRMNMEGET(nPrt)
		@19,22 SAY ALLTRIM(STR(PJBCOPYTODOGET(nPrt)))
		@20,22 SAY ALLTRIM(STR(PJBSIZEGET(nPrt)))
		@21,22 SAY ALLTRIM(STR(int((PJBBYTDNEGET(nPrt)/PJBSIZEGET(nPrt))*100)))
		@19,53 SAY ALLTRIM(STR(PJBCPYDNEGET(nPrt)))
		@20,53 SAY ALLTRIM(STR(PJBBYTDNEGET(nPrt)))
	ENDIF

	DISPEND()		// End screen buffering and show the screen

	WaitEsc( PROCNAME(), PROCLINE(), READVAR() )

	RESTSCREEN( 5,1,22,78, cBox )

RETURN NIL




///////////////////////////////////////////
// List all queues serviced by a printer //
///////////////////////////////////////////
FUNCTION PrtQList( nPrt )
	LOCAL cBox, cQueue, aQueues[255], nCount := 0, nChoice

	// Construct the array of strings to choose from
	cQueue := PRNQUELST( nPrt )
	WHILE !EMPTY(cQueue)
		aQueues[++nCount] := ;
			PADR(PRNQUEFSGET(),21) + ;
			PADR(cQueue,34) + ;
			PADL(ALLTRIM(STR(PRNQUEPTYGET())),2)
		cQueue := PRNQUELST()
	END

	// Draw the box and show the list
	cBox := ExpBox( 7,8,20,71, "", .T. )
	@8,9 SAY "  File Server          Queue                          Priority"

	WHILE ( nChoice := ACHOICE(10,11,19,70, aQueues) ) != 0
	END

	RESTSCREEN( 7,8,20,71, cBox )

RETURN NIL




///////////////////////
// Print Server Info //
///////////////////////
FUNCTION PSvrInfo()
	LOCAL cBox, nCount, nPCount := 0

	// Get the number of printers on this pserver;
	// remember, nCount should go up to 256 for a full list!
	FOR nCount := 0 TO 32
		IF PRNSTATGET( nCount ) != -1
			nPCount++
		ENDIF
	NEXT

	cBox := SingleBox( 10,12,18,67, "Print Server Info/Status" )

	Color(1)
	@13,14 SAY "Print server version: "
	@14,14 SAY "Print server type:    "
	@15,14 SAY "Number of printers:   "
	@16,14 SAY "Queue service modes:  "
	@17,14 SAY "Current server status:"

	Color(3)

	// "*": Not yet in NOVLIB
	@13,37 SAY "*.*.*"
	@14,37 SAY "***********"
	@15,37 SAY ALLTRIM(STR(nPCount))
	@16,37 SAY "*"
	@17,37 SAY "*****"

	WaitEsc( PROCNAME(), PROCLINE(), READVAR() )

	RESTSCREEN( 10,12,18,67, cBox )

RETURN NIL




// Cyan on Blue Startup Screen
FUNCTION BlueSplash()

	SETCOLOR( "BG+/B" )
	CLS
	@0,0 SAY "NetWare Print Console II  V" + PC2_VERSION
	@1,0 SAY "Copyright (c) 1995 by Blinkinc.  All Rights Reserved."

	INKEY(2)	// This is a two-second pause, maybe too long for some.

RETURN NIL




// Context-sensitive help; a very long CASE statement

FUNCTION Help( cProc, nLine, cVar )
	LOCAL cEOL := CHR( 13 ) + CHR( 10 ), aTempA, aTempB, aTempC, aTemp

	DO CASE
		CASE ( cProc == "PJENTRIES" .AND. EMPTY(cVar) )
			// Only if no READ on
			HelpBox( ;
		{ {	" Print Jobs List                       Help 1 of 1"+cEOL+;
			"อออออออออออออออออออออออออออออออออออออออออออออออออออ"+;
			" This is the list of print jobs that are in the   "+cEOL+;
			" queue. It is updated every five seconds. You have"+cEOL+;
			" the following options:                           "+cEOL+;
			                                                    +cEOL+;
			" <Enter>    Show detailed information about a job."+cEOL+;
			" <Delete>   Remove selected jobs from the queue.  "+cEOL+;
			" <Insert>   Add new print jobs to the queue.      ";
				, 11, 53  }  };
				,1 )

		CASE ( cProc == "PJENTRIES" .AND. ( .NOT. EMPTY(cVar) ) )
			// Only IF READ is on
			HelpBox( ;
		{ {	" Job Entry                          Help 1 of 1"+cEOL+;
            "ออออออออออออออออออออออออออออออออออออออออออออออออ"+;
			" These are the specifications for the job you  "+cEOL+;
			" selected. If you are the owner of the job, or "+cEOL+;
			" a queue operator, you can change most of the  "+cEOL+;
			" specifications. Press <Escape> when you are   "+cEOL+;
			" finished.                                     ";
				, 9, 50   }  };
				,1 )

		CASE ( cProc == "PQINFO" .AND. cpMenuName == "PQIList" )
			HelpBox( ;
		{ {	" Print Queues Menu                       Help 1 of 1"+cEOL+;
            "อออออออออออออออออออออออออออออออออออออออออออออออออออออ"+;
			" This is a list of print queues on this file        "+cEOL+;
			" server. You can select and examine any queue in the"+cEOL+;
			" list.  If you are a supervisor or supervisor       "+cEOL+;
			" equivalent user, you can add, delete, or rename    "+cEOL+;
			" print queues.                                      "+cEOL+;
			                                                      +cEOL;
				, 9, 55   }  };
				,1 )

		CASE ( cProc == "NWMENU" .AND. cpMenuName == "PQInfo" )

			aTemp := ;
		{ {	" Print Queue Information Menu             Help 1 of 3"+cEOL+;
            "ออออออออออออออออออออออออออออออออออออออออออออออออออออออ"+;
			" These options are available to all users:           "+cEOL+;
			                                                       +cEOL+;
			" PRINT QUEUE ID: Shows the Object ID and file server "+cEOL+;
			" name of the selected print queue.                   "+cEOL+;
			                                                       +cEOL+;
			" QUEUE SERVERS: Lists the print servers that can     "+cEOL+;
			" service this queue. Queue operators can add or      "+cEOL+;
			" delete servers from this list.                      "+cEOL+;
			                                                       +cEOL+;
			" QUEUE USERS: Lists the users who can submit jobs to "+cEOL+;
			" this queue. Queue operators can add or delete       "+cEOL+;
			" users from this list.                               ";
				, 17, 56   }, ;
		  {	" Print Queue Information Menu            Help 2 of 3 "+cEOL+;
            "ออออออออออออออออออออออออออออออออออออออออออออออออออออออ"+;
			" These options are available to authorized queue     "+cEOL+;
			" users, queue operators, and supervisors:            "+cEOL+;
			                                                       +cEOL+;
			" CURRENT PRINT JOB ENTRIES: Lists the jobs currently "+cEOL+;
			" in this queue and allows jobs to be submitted or    "+cEOL+;
			" deleted.  Also allows you to view and change        "+cEOL+;
			" information about a particular print job.           "+cEOL+;
			                                                       +cEOL+;
			" CURRENT QUEUE STATUS: Shows the current status of   "+cEOL+;
			" this print queue and allows user with appropriate   "+cEOL+;
			" rights to set or change operator flags.             "+cEOL+;
			                                                       +cEOL+;
			" CURRENTLY ATTACHED SERVERS: Lists the print servers "+cEOL+;
			" that are currently attached and servicing jobs from "+cEOL+;
			" this queue.                                         ";
				, 19, 56   }, ;
		  {	" Print Queue Information Menu           Help 3 of 3 "+cEOL+;
            "อออออออออออออออออออออออออออออออออออออออออออออออออออออ"+;
			" This option is available only to supervisors:      "+cEOL+;
			"                                                    "+cEOL+;
			" QUEUE OPERATORS: Lists the current queue operators "+cEOL+;
			" and allows the supervisor or supervisor equivalent "+cEOL+;
			" to add and delete queue operators.                 "+cEOL;
			+cEOL+cEOL+cEOL+cEOL+cEOL+cEOL+cEOL+cEOL+"";
				, 17, 56   }  }

			HelpBox( aTemp, 1 )

		CASE cpMenuName == "NOHELP"
			HelpBox( ;
		{ {	"No specific application help is      "+cEOL+;
			"available at this point.  Pressing   "+cEOL+;
			"the HELP key again will display a    "+cEOL+;
			"list of the function key assignments "+cEOL+;
			"on your machine.                     ";
				, 7, 40  } };
				, 255;			// NOHELP special case
				)

		OTHERWISE
			ALERT( "No Help Yet" )
	ENDCASE

RETURN NIL


// Credits Screen
FUNCTION CredScrn()
	LOCAL cEOL := CHR(13)+CHR(10)
	LOCAL cMsg, cScr

	cMsg := "With help from Goth, Jud, Alan and Malc"     +cEOL+;
			""+cEOL+;
			"A demonstration of the power and versatility"+cEOL+;
			"of NOVLIB, simply the best Novell NetWare"   +cEOL+;
			"library for CA-Clipper or any language!"     +cEOL+;
			""+cEOL+;
			"Copyright 1995 Blinkinc."

	cScr := ExpBox( 7,16,17,63, "PCONSOL2 by Rich Miller", .f. )

	KEYBOARD CHR( K_CTRL_W )	// Kill the MEMOEDIT immediately
	color(3)
	MEMOEDIT( cMsg, 10,18,16,62, .F. )

	WaitEsc( PROCNAME(), PROCLINE(), READVAR() )

	RESTSCREEN( 7,16,17,63, cScr )

RETURN NIL
