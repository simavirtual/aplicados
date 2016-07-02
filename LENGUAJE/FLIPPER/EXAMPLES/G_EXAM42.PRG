*******************************************************************************
* LABEL PRINTING EXAMPLE                                                      *
*                                                                             *
*  9 pin or 24 pin dor matrix printer                                         *
*******************************************************************************
*
FLIP_INIT(10)
SET_SAYERR(1)
fh1 = FONT_OPEN( "RMN8_26.@" )
FONT_NEW(fh1)
FONT_ALIGN(fh1,0)

M_x = 4
M_y = 0.5
M_Xmax = 0
M_Ymax = 0
M_inch = 1.5
*
M_dpi = 180                            && Default 24 pin
M_type = 24
M_mult = 1
*
CLEAR SCREEN
M_id = SEL_PRINT()
PRT_LOAD(M_id,"LPT1")
PRT_STAT(1)
DECLARE PRINT_DEF[17]                  && Setup array
PRT_HEADER(PRINT_DEF)                  && Grab information about driver
IF PRINT_DEF[4] = 72
   M_dpi  = 72
   M_type = 24                          && Prints in 8 pin mode
   M_mult = 3
ENDIF
*
CLEAR SCREEN
@ 18,0 SAY IIF(M_dpi=72, '9 pin', '24 pin')+ ' dot matrix'
@ 21,0 SAY 'Label length in inches: 'GET M_inch PICT '9.9'
@ 22,0 SAY 'Label size (inches): '
@ 22,col()+2 GET M_x PICT '9.9'
@ 22,col()+2 GET M_y PICT '9.9'
READ
*
***************
* PRINT
***************
DO WHILE PRT_CHECK(0) == 0
   @ 0,30 SAY 'Printer not ready. <Tap any key>'
   TONE(380,2)
   INKEY(0)
   IF LASTKEY() = 27
      EXIT
   ENDIF
ENDDO
IF LASTKEY() = 27
   RETURN
ENDIF
*
N=0
*
LINES = MPRT_OPEN( M_x*100, M_y*100 )
M_Xmax=GRMAX_X()
M_Ymax=GRMAX_Y()
@ 10,10 SAY M_Ymax
IF M_Ymax % M_type > 0
   M_Ymax = INT(M_Ymax / M_type + 1) * M_type
ENDIF
@ 11,10 SAY M_Ymax
DO WHILE N < 3
   FOR I = 1 TO LINES
      MPRT_SWATH(I)
      FBOX( ATX(0,2), ATY(0,2), ATX(100,2), ATY(100,2), 1 )
      SAY_TEXT( ATX(10,2), ATY(10,2), 'This is a label')
      MPRT_SCRN( 100, 100, 0, 0 )
      IF PRT_ESCAPE()=1
         EXIT
      ENDIF
   NEXT
   IF M_dpi*M_inch > M_Ymax
      SET PRINT ON
      SET CONSOLE OFF
      ?? chr(27)+'J'+chr( (M_dpi*M_inch-M_Ymax)*M_mult )
      SET CONSOLE ON
      SET PRINT OFF
   ENDIF
   N=N+1
ENDDO
MPRT_CLOSE()

FUNCTION PRT_STATUS
@ 0,70 SAY STR(RET_PRTDN(),3,0)+'%'
IF INKEY()=27
   PRT_ESCAPE(1)
ENDIF

FUNCTION SEL_PRINT
number = PRT_LIST("C:\FLIPPER\LIBRARY\PRX_TBL.BIN")
DECLARE PRINT_NAME[number]
PRT_LIST( PRINT_NAME )
@ 3, 9 TO 22, 41 DOUBLE
M_printer = ACHOICE(4,10,21,40,PRINT_NAME)
IF M_printer > 0
   RETURN( VAL( SUBSTR( PRINT_NAME[M_printer], 1, 4 ) ) )
ENDIF
RETURN(0)
