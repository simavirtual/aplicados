*********** Sample programs for CA-Clipper Tools / 5.2 ************
*
* Program     : NBDCHAT.PRG
* Copyright   : (c) 1992-93, Computer Associates International.
*               All rights reserved.
* Date        : 08/16/91
* Author      : Ralf Saborowski
* Description : Simple NetBIOS chatting application. Start on
*               two workstation with NetBIOS abilities, enter
*               a NetBIOS name on every station and the name of
*               the other station as callname and input on a
*               workstation will simultaniously appear on the
*               screen of the other workstation. Using group
*               names and several workstations is also funny.
*
*               Easily to port to other protocolls!
*
* Compiling   : CLIPPER NBDCHAT
* Linking     : RTLINK FI NBDCHAT,CTUS LIB CT
*
*******************************************************************
#include "inkey.ch"
#include "setcurs.ch"
#include "ctppc.ch"

LOCAL cLocalName,nLocalName
LOCAL cCallName
LOCAL nSndHwnd
LOCAL nRecHwnd
LOCAL nHandle,nSndHandle
LOCAL nKey

CLS

IF !ISNETBIOS()

  ?
  ?
  ?
  ? 'Error: NetBIOS not active!'
  DIE()

ENDIF

SETBOXGROW(10)

cLocalName:=cCallName:=SPACE(15)

// Get own NetBIOS Name
nLocalName=GetName('Local Name',@cLocalName,.T.)

// Get Callname
GetName('Callname',@cCallName,.F.)

// open chat windows
nRecHwnd=WOPEN(0,0,MAXROW()/2,MAXCOL())
WBOX(4)
@ -1,5 SAY '[Receiving for '+cLocalName+']'
CLS

WSELECT(0)

nSndHwnd=WOPEN(MAXROW()/2+1,0,MAXROW(),MAXCOL())
WBOX(4)
@ -1,5 SAY '[Sending to '+cCallName+']'
CLS

// Buffer
nHandle=NBDOPEN(nLocalName,512,512,cCallName)
PPCKEY(nHandle,255,PPC_RECSUC)

WHILE .T.
  nKey=INKEY(0)

  DO CASE
   CASE nKey=255
     WSELECT(nRecHwnd)
     ?? PPCREAD(nHandle)
     WSELECT(nSndHwnd)
   CASE nKey=K_ESC
     PPCCANCEL(nHandle)
     DIE()
   CASE nKey=K_RETURN
     PPCWRITE(nHandle,CHR(10)+CHR(13))
     ?
   CASE nKey>=0 .AND. nKey<255
     PPCWRITE(nHandle,CHR(nKey))
     ?? CHR(nKey)
  ENDCASE
ENDDO

FUNCTION GetName(cText,cName,lModus)
  LOCAL nLen:=LEN(cText)+21
  LOCAL nLeft:=INT((MAXCOL()-nLen)/2)
  LOCAL nWahl,nName


  WOPEN(11,nLeft,13,nLeft+nLen-1,.T.)
  WBOX(4)


  WHILE .T.
    @ 0,1 SAY cText+':' GET cName
    READ
    IF LASTKEY()=K_ESC
      Die()
    ENDIF

    cName=TRIM(cName)

    IF lModus

      // group or station
      SETCURSOR(SC_NONE)
      WOPEN(9,34,14,45,.T.)
      @  0,0  TO 5,11 DOUBLE
      @  2,1  TO 2,10 DOUBLE
      @  2,0  SAY CHR(204)
      @  2,11 SAY CHR(185)
      @  1,2 SAY 'Nametype'
      @  3,2 PROMPT 'Station '
      @  4,2 PROMPT 'Group   '
      MENU to nWahl
      WCLOSE()

      DO CASE
        CASE nWahl=1
          nName=NBADDNAME(cName)
        CASE nWahl=2
          nName=NBADDGROUP(cName)
        OTHERWISE
         DIE()
      ENDCASE

      IF nName>0
        EXIT
      ENDIF
    ELSE
      EXIT
    ENDIF
    SETCURSOR(SC_NORMAL)
  ENDDO

  WCLOSE()
  IF LASTKEY()=K_ESC
    Die()
  ENDIF
  SETCURSOR(SC_NORMAL)

RETURN(nName)

FUNCTION DIE()
  WSELECT(0)
  QUIT
RETURN(NIL)
