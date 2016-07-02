
// IRESET.PRG
// This utility resets a users account if it has been locked out
// by the intruder lock out mechanism, allowing the user to login
// again. < tell them to remember they're password next time ! >
// To use it you must have SUPERVISOR equivalence.
//
// usage: IRESET <USRGETNME>
// 
// written by Goth.
//

#include "novlib.ch"   // dont need it this time, but it's useful

PUBLIC nError := 0
PUBLIC nLockValue := 0

parameters cUserName

// was the user name passed ?
if ( cUserName == NIL )
  ? "Usage: IRESET <User Name>"
  ?
  quit
endif

// does the user exist ?
if( OBJIDGET( cUserName, 1 ) == -1 )
  ? "Error: user "+cUserName+" not known at this server"
  ?
  quit
endif

// am I supervisor or equivalent
if( ( OBJIDGET( WSLOGNMEGET(), 1 ) != 1 ) .AND.;
              !SETPRPIDTST( WSLOGNMEGET(), 1, "SUPERVISOR", 1, "SECURITY_EQUALS" ) )
  ? "Error: you require SUPERVISOR equivalence to reset a locked account."
  ?
  quit
endif

// get first byte of lock WORD, shift 8 bits to left
nLockValue := ITMPRPBYTGET( cUserName, 1, "LOGIN_CONTROL", 69 ) * 256

// did a NetWare error occur ?
if( NWERRORGET() != 0 )
  ? "Error: a NetWare error type "+ltrim(str(NWERRORGET()))+" has occurred"
  ?
  quit
endif

// get second byte of WORD add to first
nLockValue += ITMPRPBYTGET( cUserName, 1, "LOGIN_CONTROL", 70 )

// is it 65535 ( which is 0xFFFF or -1 in C speak )
if( nLockValue == 65535 )

  // write zero's to the lock out WORD
  nLockValue := ITMPRPBYTSET( cUserName, 1, "LOGIN_CONTROL", 69, 0 )
  nLockValue += ITMPRPBYTSET( cUserName, 1, "LOGIN_CONTROL", 70, 0 )

  // did they not change ?
  if( nLockValue != 0 )
    ? "Error: a NetWare error type "+ltrim(str(NWERRORGET()))+" has occurred"
    ?
    quit
  else
    ? "User "+cUserName+"'s account is now unlocked"
    ?
  endif

else
  // operator head space error
  ? "Error: User "+cUserName+" is not locked out."
  ?
  quit
endif


