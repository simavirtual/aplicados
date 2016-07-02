// XGets.ch
//
// Date   : 3/8/94
// Author : ShaunB.. (Shaun Botha CIS: 70043,2641)
// Purpose: Header file for XGETS module

// Signatures for XGETS extensions
#define GC_MESSAGE      "MESSAGE"
#define GC_LOOKUP	"LOOKUP"
#define GC_SPECKEY	"SPECKEY"
#define GC_READONLY	"READONLY"

// Use these keys for lookups
#define K_LOOKUP	K_F12
#define K_ALT_LOOKUP    K_CTRL_F1

// Associate a message with a GET
#xcommand @ <row>, <col> GET <var>					;
		[<clauses>]						;
		MESSAGE <msg>						;
	=>								;
	@ <row>, <col> GET <var>					;
		[<clauses>]						;
	;	xGetMsg(atail(getList), <msg>)


// Associate a lookup procedure with a GET
#xcommand @ <row>, <col> GET <var>					;
		[<clauses>]						;
		LOOKUP [USING] <lkp>					;
	=>								;
	@ <row>, <col> GET <var>					;
		[<clauses>]						;
	;	xGetLookup(atail(getList), {|_oGet|<lkp>})


// Associate a special keystroke with a GET
#xcommand @ <row>, <col> GET <var>					;
		[<clauses>]						;
		SPECIAL KEY <key> [EXECUTE] <keyblock>			;
	=>								;
	@ <row>, <col> GET <var>					;
		[<clauses>]						;
	;	xGetSpKey(atail(getList), <key>, {|_oGet, _nKey|<keyblock>})


// Flag a GET as 'READONLY' - ie user cannot alter data in the get
#xcommand @ <row>, <col> GET <var>					;
		[<clauses>]						;
		READONLY						;
	=>								;
	@ <row>, <col> GET <var>					;
		[<clauses>]						;
	;	xGetRdOnly(atail(getList))



// Associate a special key with all GETs in the default getList
#xcommand SPECIAL KEY [FOR] GETS					;
		[ONKEY] <key> 						;
		[EXECUTE] <keyblock> 					;
	=>								;
	aeval(getList, {|g| xGetSpKey(g, <key>, {|_oGet, _nKey|<keyblock>}) })



// Associate a special key with all GETs in the specified getList
#xcommand SPECIAL KEY [FOR] GETLIST <getlist>				;
		[ONKEY] <key> 						;
		[EXECUTE] <keyblock> 					;
	=>;
	aeval(<getlist>, {|g| xGetSpKey(g, <key>, {|_oGet, _nKey|<keyblock>}) })



// Flag all GETs in the default getList as 'READONLY'
#xcommand SET GETS [TO] READONLY					;
	=>								;
		aeval(getlist, {|g| xGetRdOnly(g) })



// Flag all GETs in the specified getList as 'READONLY'
#xcommand SET GETLIST <getlist> [TO] READONLY				;
	=>								;
		aeval(<getlist>, {|g| xGetRdOnly(g) })
