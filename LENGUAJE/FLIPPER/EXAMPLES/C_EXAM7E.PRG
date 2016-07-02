*****************************************************************
* Simple print examples                                         *
*                                                               *
* Replace printer number with proper ID                         *
*****************************************************************
*
FLIP_INIT(1000)
PRT_STAT(1)
*
M_printer = 68
*
PRT_LOAD( M_printer, "LPT1" )
PRT_OPTS(0, 0, 0, 1, 1)                         && Landscape
*
FSCREEN()
FBOX(2, 2, 637, 460, 1)
PAT_SETFIL(1)
FOR I = 1 TO 15
   FBOX( 20*I, 20, 20*I+18, 120, I )
NEXT
PAT_SETFIL(0)
PRT_AREA(0, 0, 10000, 10000, 800, 0, 0, 0 )
TEXTMODE()

FUNCTION PRT_STATUS
IF INKEY()=27
   PRT_ESCAPE(1)
ENDIF
