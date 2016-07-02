*******************************************************************************
*  S_EXAM02.PRG                                                               *
*  Author: Gary Prothero                                                      *
*  Requirements: SCANNER.LIB                                                  *
*  Description:                                                               *
*       This is an example of scanning documents to a PCX file from an HP     *
*       SCANJET or SCANJETplus.                                               *
*******************************************************************************
FLIP_INIT(1,1)
SET_SAYERR(1)
*
DO WHILE .T.
   wait
   IF LASTKEY()=27
      EXIT
   ENDIF
   M_status = HPS_OPEN(ASC('R'), 0, "d:")
   DO CASE
      CASE M_status = 1
         @ 0,30 SAY '** Error '+ALLTRIM(STR(M_status,3))+': Driver not installed.'
      CASE M_status = 2
         @ 0,30 SAY '** Error '+ALLTRIM(STR(M_status,3))+': Is scanner turned off.'
   ENDCASE
   IF FILE("GARY.PCX")
      ERASE GARY.PCX
   ENDIF
   M_status = HPS_SCAN( "GARY.PCX" )
   IF M_status > 0
      @ 0,30 SAY '** Error '+ALLTRIM(STR(M_status,3))+'Scanner did not complete.'
      TONE(380,2)
      INKEY(0)
   ENDIF
   M_status = HPS_CLOSE()
*
   TOP0=00
   LEF0=00
   RIAR=60
   LFAR=60
   PGUP=50
   PGDN=50
   CLR = 0
*
   FSCREEN()
   DO WHILE .T.
      CLS_SCREEN()
      FPCX_PUT( LEF0, TOP0, 'P', "GARY.PCX", 15, 0 )
      INKEY(0)
      IF LASTKEY()=27
         EXIT
      ENDIF
      IF LASTKEY()=08 .OR. LASTKEY()=19
         LEF0=LEF0-LFAR
      ENDIF
      IF LASTKEY()=09 .OR. LASTKEY()=04
         LEF0=LEF0+RIAR
      ENDIF
      IF LASTKEY()=18 .OR. LASTKEY()=05
         TOP0=TOP0-PGUP
      ENDIF
      IF LASTKEY()=24 .OR. LASTKEY()=03
         TOP0=TOP0+PGDN
      ENDIF
      IF LASTKEY()=01
         LEF0=0
         TOP0=0
      ENDIF
   ENDDO
   TEXTMODE()
ENDDO
