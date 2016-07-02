// XGets.prg
//
// Date   : 03/09/94
// Author : ShaunB.. (Shaun Botha CIS: 70043,2641)
// Purpose: Provide special handling for GETs
// Compile: CLIPPER xgets /n/m/w/es2
// Link   : Any way you want <g>!

#include "inkey.ch"
#include "getexit.ch"
#include "xgets.ch"

static bgMsg    := nil		// Block to be eval'd when we display a message
static cgLkChar := ""		// Character to be displayed for lookup GETs


// Reader for XGETs
procedure xGetReader(oGet)
	local nKey, cMsg, bLookup, xUnder, nPos, bKeyBlock, lReadOnly

	if getPreValidate(oGet)
		// Prep for the message
		if !empty(nPos := ascan(oGet:cargo, {|i| i[1] == GC_MESSAGE }))
			cMsg := oGet:cargo[nPos, 2]
		endif

		// Prep for the lookup
		if !empty(nPos := ascan(oGet:cargo, {|i| i[1] == GC_LOOKUP }))
			bLookup := oGet:cargo[nPos, 2]
		endif

		// Check readonly flag
		lReadOnly := (ascan(oGet:cargo, {|i| i[1] == GC_READONLY }) != 0)

		// Display the message
		if !empty(cMsg) .and. !empty(bgMsg)
			eval(bgMsg, cMsg)
		endif

		// If this is a lookup then display the lookup arrow
		if !empty(bLookup) .and. !empty(cgLkChar)
			xUnder := saveScreen(oGet:row, oGet:col-1, oGet:row, oGet:col-1)
			@ oGet:row, oGet:col-1 say cgLkChar
		endif

		// Give focus to the GET
		oGet:setFocus()

		// While the day away....
		while oGet:exitState == GE_NOEXIT
			if oGet:typeOut
				oGet:exitState := GE_ENTER
			endif

			while oGet:exitState == GE_NOEXIT
				nKey := inkey(0)

				// Process setKey()'s
			   if ( bKeyBlock := setkey( nKey ) ) != nil
			      getDoSetKey( bKeyBlock, oGet )
					loop
				endif

				if isSpecial(oGet, nKey)
					applySpecial(oGet, nKey)
				elseif !lReadOnly .and.;
						 (nKey == K_LOOKUP .or. nKey == K_ALT_LOOKUP) .and.;
						 !empty(bLookup)
					eval(bLookup, oGet)
				else
					if !lReadOnly
						GetApplyKey(oGet, nKey)
					else
						if nKey == K_UP     .or.;
							nKey == K_DOWN   .or.;
							nKey == K_LEFT   .or.;
							nKey == K_RIGHT  .or.;
							nKey == K_HOME   .or.;
							nKey == K_END    .or.;
							nKey == K_PGUP   .or.;
							nKey == K_PGDN   .or.;
							nKey == K_CTRL_W .or.;
							nKey == K_ENTER  .or.;
							nKey == K_ESC
							GetApplyKey(oGet, nKey)
						endif
					endif
				endif
			enddo

			if !getPostValidate(oGet)
				oGet:exitState := GE_NOEXIT
			endif
		enddo

		oGet:killFocus()

		if !empty(bLookup) .and. !empty(cgLkChar)
			restScreen(oGet:row, oGet:col-1, oGet:row, oGet:col-1, xUnder)
		endif
	endif
return


// Get/Set for the bgMsg and cgLkChar statics defined in this module
function xGetGetSet(bMsg, cLkChar)
	local aRet
	aRet := {bgMsg, cgLkChar}
	if pcount() > 1
		bgMsg    := bMsg
		cgLkChar := cLkChar
	endif
return aRet


// Set the message to be associated with the get
procedure xGetMsg(oGet, cMsg)
	initXGet(oGet)
	aadd(oGet:cargo, {GC_MESSAGE, cMsg})
return


// Set the lookup
procedure xGetLookup(oGet, bLookup)
	initXGet(oGet)
	aadd(oGet:cargo, {GC_LOOKUP, bLookup})
return


// Set the special key
procedure xGetSpKey(oGet, nKey, bKeyBlock)
	initXGet(oGet)
	aadd(oGet:cargo, {GC_SPECKEY, nKey, bKeyBlock})
return


// Mark the GET as READONLY
procedure xGetRdOnly(oGet)
	initXGet(oGet)
	aadd(oGet:cargo, {GC_READONLY})
return



// Tell whether 'nKey' is defined as special for the GET
static function isSpecial(oGet, nKey)
return ascan(oGet:cargo, {|i| i[1] == GC_SPECKEY .and. i[2] == nKey }) != 0


// Eval all blocks for a specific keystroke
static procedure applySpecial(oGet, nKey)
	local x

	for x := 1 to len(oGet:cargo)
		if oGet:cargo[x, 1] == GC_SPECKEY .and.;
			oGet:cargo[x, 2] == nKey
			eval(oGet:cargo[x, 3], oGet, nKey)
		endif
	next x
return


// Initialize the GET - ie setup the cargo and reader instance vars
static procedure initXGet(oGet)
	if oGet:cargo == nil
		oGet:cargo := {}
	endif
	if oGet:reader == nil
		oGet:reader := {|oGet| xGetReader(oGet)}
	endif
return
