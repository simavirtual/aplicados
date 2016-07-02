#include <stdio.h>
#include <pro_ext.h>

void FAR hello( ParamBlk FAR *parm )
  {
    WHANDLE wh;
    Point pt;

    wh = _WOpen( 10, 20, 14, 50,
		WMINIMIZE + MOVE + SHADOW + CLOSE,
		DIALOG_SCHEME,
		0,
		WO_DOUBLEBOX );
	if( wh != 0 ) {
	_WSetTitle( wh, "HELLO" );
	_WSetFooter( wh, "WATCOM C" );
	_WShow( wh );
	pt.h = 9;
	pt.v = 1;
	_WPosCursor( wh, pt );
	_WPutStr( wh, "Hello world" );
    }
    _RetInt( 0L, 1 );
  }

FoxInfo myFoxInfo[] = {
	{ "HELLO", (FPFI) hello, 0, "?" }
};

FoxTable _FoxTable = {
    (FoxTable FAR *) 0,
    sizeof( myFoxInfo) / sizeof( FoxInfo ),
    myFoxInfo
};
