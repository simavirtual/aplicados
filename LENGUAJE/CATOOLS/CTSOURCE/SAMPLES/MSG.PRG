*********** Sample programs for CA-Clipper Tools / 5.2 ************
*
* Program     : MSG.PRG
* Copyright   : (c) 1992-93, Computer Associates International.
*               All rights reserved.
* Date        : 05/04/91
* Author      : Ralf Saborowski
* Description : Shows how to use Netware broadcast messages
*               for notification purposes. Screen will be
*               updated if any other station running the
*               same program changes the currently edited record.
*
*               All users on workstations running this program
*               should be members of a Netware group called
*               CUSTOMDBF. Use Novell's SYSCON utility or CA-Clipper
*               Tools functions to create and maintain this group!
*
* Compiling   : CLIPPER MSG
* Linking     : RTLINK FI MSG LIB CT
*
*******************************************************************


#include "inkey.ch"

LOCAL cLast,cName,nAmount
LOCAL lExit:=.F.

CLS
USE custom NEW SHARED

@ 5,5 SAY 'Lastname:'
@ 7,5 SAY 'Name:'
@ 9,5 SAY 'Amount:'

// Init message system
NNETMSGOPN(1)
SETKEY(255,{|p,l,v|Refresh(@cLast,@cName,@nAmount,@lExit)})
NNETMSGKEY(255)

WHILE .NOT. lExit
  // assign values to input variables
  ReadRec(@cLast,@cName,@nAmount)

  // (re)display GET fields
  @ 5,14 GET cLast
  @ 7,14 GET cName
  @ 9,14 GET nAmount PICTURE '999999.99'

  // flush broadcast buffer
  NNETMSGCLR()
  lExit=.T.
  READ
ENDDO
IF LASTKEY()!=K_ESC
  WriteRec(cLast,cName,nAmount)
ENDIF

WAIT ''                 // I'm not waiting on a lady,
                        // I'm just waiting on a friend...

NNETMSGCLO()

RETURN

// read current record in input variables
FUNCTION ReadRec(cLast,cName,nAmount)
  // force buffer refresh
  GOTO RECNO()
  cLast=FIELD->LastName
  cName=FIELD->Name
  nAmount=FIELD->Saldo
RETURN(NIL)

// write act. variables into current record
// and send a change notification to all
// members of group CUSTUMDBF
FUNCTION WriteRec(cLast,cName,nAmount)
  LOCAL cMsg
  IF RLOCK()
    FIELD->LastName=cLast
    FIELD->Name=cName
    FIELD->Saldo=nAmount
    cMsg=PADR('CUSTOM',8)+STR(RECNO(),10)
    NNETSNDGRP('CUSTOMDBF',cMsg,.T.)
    UNLOCK
  ENDIF
RETURN(NIL)

// check if variables have to be refreshed
FUNCTION Refresh(cLast,cName,nAmount,lExit)
  LOCAL cMsg:=NNETMSGRD()

  @ 0,0 SAY cMsg

  IF TRIM(LEFT(cMsg,6))='CUSTOM' .AND.;
     VAL(SUBSTR(cMsg,9))=RECNO()
     CLEAR GETS
     lExit=.F.
  ENDIF

RETURN(NIL)
