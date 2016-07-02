// XGDemo.prg
//
// Date: 3/8/94
// Author: ShaunB.. (Shaun Botha CIS: 70043,2641)
// Purpose: Demo some of the XGETS module's functionality
// Compile: CLIPEPR xgdemo /n/m/w
// Link   : Blinker/RTLink file xgdemo,xgets

#include "xgets.ch"
#include "inkey.ch"
#include "box.ch"

procedure main()
	local a,b, c, getList := {}

	// Init the XGETS module, passing 2 parameters:
	//		a) The block to be used for displaying messages
	//		b) The character to display next to GETs to indicate lookups

	xGetGetSet({|c| showMessage(c)}, chr(16))

	clear screen
	a := b := c := space(25)
	@ 2, 1 say "A:" get a ;
		picture "@!";
		message "This is a message";
		special key K_F2 execute spFunc(_oGet, _nKey)

	// There's a lookup for this get
	@ 3, 1 say "B:" get b ;
		picture "@!";
		lookup theLook(_oGet) ;
		message "Enter a value; [F12] or [Ctrl-F1] for lookup";
		special key K_F2 execute spFunc(_oGet, _nKey)

	// The user will not be able to modify this GET
	@ 4, 1 say "C:" get c ;
		picture "@!";
		message "This field is READONLY";
		special key K_F2 execute spFunc(_oGet, _nKey);
		readonly

	// Associate F1 with all the GETs in the default getList
	special key for gets onkey K_F1 execute helpFunc(_oGet)


	// Mark all GETS as READONLY
	// set gets to readonly

	read

	setColor("")
	clear screen
return


// Called by XGETS when lookup key is pressed
procedure theLook(oGet)
	local nRow, nCol, cColor, xUnder, nKey

	nRow   := row()
	nCol   := col()
	cColor := setColor("N/BG")

	xUnder := saveScreen(0, 0, maxRow(), maxCol())
	@ 5, 5, 7, 60 box B_SINGLE + " "
	@ 6, 6 say "Lookup for get [" + oGet:name + "] - press [Enter] to stuff the GET"
	nKey := inkey(0)
	restScreen(0, 0, maxRow(), maxCol(), xUnder)
	setColor(cColor)
	setPos(nRow, nCol)

	// Demo how to plug a value into the current GET's variable and redisplay
	if nKey == K_ENTER
		oGet:varPut(padr("STUFFED AT: " + time(), 25))
		oGet:updateBuffer()  // This only works if the GET has input focus
	endif
return


// Called by XGETS when K_F2 key is pressed
procedure spFunc(oGet)
	local nRow, nCol, cColor, xUnder

	nRow   := row()
	nCol   := col()
	cColor := setColor("W+/G")

	xUnder := saveScreen(0, 0, maxRow(), maxCol())
	@ 5, 5, 7, 40 box B_SINGLE + " "
	@ 6, 6 say "This is the special key " + oGet:name
	inkey(0)
	restScreen(0, 0, maxRow(), maxCol(), xUnder)
	setColor(cColor)
	setPos(nRow, nCol)
return


// Called by XGETS when K_F1 is pressed
procedure helpFunc(oGet)
	local nRow, nCol, cColor, xUnder, cTxt

	nRow   := row()
	nCol   := col()
	cColor := setColor("W+/BR")

	do case
		case upper(oGet:name) == "A"
			cTxt := "Help for variable [A]"
		case upper(oGet:name) == "B"
			cTxt := "Help for variable [B] - lookup available"
		case upper(oGet:name) == "C"
			cTxt := "Help for variable [C] - readonly"
	endcase

	xUnder := saveScreen(0, 0, maxRow(), maxCol())
	@ 5, 5, 7, len(cTxt)+6 box B_SINGLE + " "
	@ 6, 6 say cTxt
	inkey(0)
	restScreen(0, 0, maxRow(), maxCol(), xUnder)
	setColor(cColor)
	setPos(nRow, nCol)
return


// Called by XGETS to display a message
procedure showMessage(cMsg)
	local nRow, nCol, cColor

	nRow   := row()
	nCol   := col()
	cColor := setColor("W+/B")
	@ 24, 0 say padr(cMsg, maxcol()+1)
	setColor(cColor)
	setPos(nRow, nCol)
return 
