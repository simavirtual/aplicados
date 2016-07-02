*******************************************************************************
* DISPLAY / PRINT GRAPHICS(PCX) FILE IN CLIPPER WITH FLIPPER
*
*     FPCX_PUT( nX, nY, cAction, cFileName [ nFg, nBg ] )
*
*     a. 16 colors PCX picture on EGA/VGA screen - nFg, nBg has no effect
*
*     b. Mono PCX picture on EGA/VGA screen      - nFg is color of foreground,
*                                                  nBg color of background
*
*     c. 16 color PCX on Mono screen             - nFg selects video plane to
*           nFg 15 = 00001111 (All planes)         display. The bit position
*                4 = 00000100 (Plane 3)            determines which planes
*                3 = 00000011 (Plane 1&2)          will be displayed.
*                9 = 00001001 (Plane 4&1)
*           The first plane is placed with cAction, and the remaining planes
*           are OR'd to the previous image.
*******************************************************************************
*
FLIP_INIT(6000)
SET_SAYERR(1)
FIL9=SPACE(25)
M_FG=15
M_BG=0
M_bios=0
M_color=2
M_image=1
M_box=1
M_x1=50
M_y1=20
M_x2=90
M_y2=90
*******************************************************************************
* PROCESS
*******************************************************************************
DO WHILE .T.
   CLEAR
   @ 1,1 TO 6,79
   @ 2,65 SAY 'Memory:'+STR(MEMORY(0),6,0)
   @ 2,2 SAY 'Filename.ext '+CHR(16) GET FIL9 PICTURE '!!!!!!!!!!!!!!!!!!!!!!!!!'
   READ
   IF LASTKEY()=27 .OR. EMPTY(FIL9)
      EXIT
   ENDIF
   @ 3,2 SAY 'Screen type: '
   @ 3,col()+2 PROMPT 'Mono'
   @ 3,col()+2 PROMPT 'Color'
   MENU TO M_color
   DO CASE
      CASE M_color=1
         GRAPHMODE(9)
      CASE M_color=2
         GRAPHMODE(4)
      OTHERWISE
         LOOP
   ENDCASE
   IF M_bios > 0
      @ 3,65 SAY 'Bios mode:'+STR(M_bios,3,0)
   ENDIF
   @ 3,30 SAY 'Image color - fg: '
   @ 3,col()+2 GET M_fg PICT '99'
   @ 3,col()+2 SAY 'bg: '
   @ 3,col()+2 GET M_bg PICT '99'
   READ
   FIL0=ALLTRIM(FIL9)
   IF .NOT. FILE(FIL0)
      @ 2,2 CLEAR TO 2,37
      @ 2,2 SAY '&FIL0 NOT FOUND * <Esc>'
      TONE(380,2)
      INKEY(0)
      LOOP
   ENDIF
*
   @ 04,02 PROMPT 'Normal'
   @ 04,col()+2 PROMPT 'Reverse'
   MENU TO M_image
   @ 24,0 SAY M_image
   IF M_image=0
      LOOP
   ENDIF
*
   @ 05,02 PROMPT 'Screen'
   @ 05,col()+2 PROMPT 'Print'
   MENU TO SOP0
   IF SOP0=0
      LOOP
   ENDIF
*
   @ 05,40 SAY 'Viewport: '
   @ 05,col()+2 PROMPT 'Off'
   @ 05,col()+2 PROMPT 'On'
   MENU TO M_box
   IF M_box=0
      LOOP
   ENDIF
   IF M_box=2
      @ 22,0 SAY 'Viewport size   % upper-left: '
      @ 22,col()+2 GET M_x1 PICT '999'
      @ 22,col()+2 GET M_y1 PICT '999'
      @ 22,col()+3 SAY '  % lower-right: '
      @ 22,col()+2 GET M_x2 PICT '999'
      @ 22,col()+2 GET M_y2 PICT '999'
      READ
   ENDIF
   ***************
   * SCREEN
   ***************
   IF SOP0=1
      ***************
      * HEADER
      ***************
      DECLARE HEADER[12]
      PCX_HEADER(FIL0,HEADER,1)
      @ 06,01 TO 23,40
      @ 07,02 SAY '          Header information'
      @ 09,02 SAY 'Manufacturer '+CHR(16)+' '+ALLTRIM(STR(HEADER[01],05))
      @ 10,02 SAY 'Version      '+CHR(16)+' '+ALLTRIM(STR(HEADER[02],05))
      @ 11,02 SAY 'Encoding     '+CHR(16)+' '+ALLTRIM(STR(HEADER[03],05))
      @ 12,02 SAY 'Bits/pel     '+CHR(16)+' '+ALLTRIM(STR(HEADER[04],05))
      @ 13,02 SAY 'Left         '+CHR(16)+' '+ALLTRIM(STR(HEADER[05],05))
      @ 14,02 SAY 'Top          '+CHR(16)+' '+ALLTRIM(STR(HEADER[06],05))
      @ 15,02 SAY 'Right        '+CHR(16)+' '+ALLTRIM(STR(HEADER[07],05))
      @ 16,02 SAY 'Bottom       '+CHR(16)+' '+ALLTRIM(STR(HEADER[08],05))
      @ 17,02 SAY 'Horz res     '+CHR(16)+' '+ALLTRIM(STR(HEADER[09],05))
      @ 18,02 SAY 'Vert res     '+CHR(16)+' '+ALLTRIM(STR(HEADER[10],05))
      @ 19,02 SAY 'N/planes     '+CHR(16)+' '+ALLTRIM(STR(HEADER[11],05))
      @ 20,02 SAY 'Bytes/line   '+CHR(16)+' '+ALLTRIM(STR(HEADER[12],05))
      @ 22,02 SAY 'Press any key or <Esc> to Quit ......'
      INKEY(0)
      IF LASTKEY()=27
         LOOP
      ENDIF
      TOP0=00
      LEF0=00
      RIAR=60
      LFAR=60
      PGUP=50
      PGDN=50
      CLEAR SCREEN
      @ 10,10 SAY '>>> USE ARROWS KEYS TO SCROLL IMAGE <<<'
      wait
      FSCREEN()
      CLS_SCREEN( M_bg )
      IF M_box = 2
         FBOX( ATX(M_x1,2)-1, ATY(M_y1,2)-1, ATX(M_x2,2)+1, ATY(M_y2,2)+1,15)
         VIEW_OPEN(ATX(M_x1,2), ATY(M_y1,2), ATX(M_x2,2), ATY(M_y2,2), 0, 0)
      ENDIF
      M_bios=RET_BIOS()
      DO WHILE .T.
         CLS_SCREEN( M_bg )
         FPCX_PUT( LEF0, TOP0, IF(M_image=1,'P','R'), FIL0, M_fg, M_bg )
         INKEY(0)
         ***************
         * ESC
         ***************
         IF LASTKEY()=27
            EXIT
         ENDIF
         ***********************
         * BACKSPACE/LEFT ARROW
         ***********************
         IF LASTKEY()=08 .OR. LASTKEY()=19
            LEF0=LEF0-LFAR
         ENDIF
         ***********************
         * TAB / RIGHT ARROW
         ***********************
         IF LASTKEY()=09 .OR. LASTKEY()=04
            LEF0=LEF0+RIAR
         ENDIF
         ***********************
         * UP ARROW / PAGE UP
         ***********************
         IF LASTKEY()=18 .OR. LASTKEY()=05
            TOP0=TOP0-PGUP
         ENDIF
         ***********************
         * DOWN ARROW /PAGE DOWN
         ***********************
         IF LASTKEY()=24 .OR. LASTKEY()=03
            TOP0=TOP0+PGDN
         ENDIF
         ***********************
         * HOME
         ***********************
         IF LASTKEY()=01
            LEF0=0
            TOP0=0
         ENDIF
      ENDDO
   ENDIF
   ***************
   * PRINT
   ***************
   IF SOP0=2
      DO WHILE PRT_CHECK(0) == 0
         @ 0,30 SAY 'Printer not ready. <Tap any key>'
         TONE(380,2)
         INKEY(0)
         IF LASTKEY() = 27
            EXIT
         ENDIF
      ENDDO
      IF LASTKEY() = 27
         LOOP
      ENDIF
      SET CONSOLE OFF
      M_id = SEL_PRINT()
      PRT_LOAD(M_id,"LPT1")
      PRT_STAT(1)
      LINES = MPRT_OPEN(800,1000)
      M_time = RET_TIME()
      FOR I = 1 TO LINES
         MPRT_SWATH(I)
         FPCX_PUT( 1, 1, IF(M_image=1,'P','R'), FIL0 )
         MPRT_SCRN( 100, 100, 0, 0 )
         IF PRT_ESCAPE()=1
            EXIT
         ENDIF
      NEXT
      M_time1 = RET_TIME()
      MPRT_CLOSE()
      SET CONSOLE ON
      EJECT
      @ 23,0 SAY (M_time1-M_time)/18.2/60
   ENDIF
   TEXTMODE()
ENDDO
*******************************************************************************
* RETURN / QUIT
*******************************************************************************
CLEAR SCREEN
QUIT

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