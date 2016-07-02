*********************************************************************
*                                                                   *
* This example only works in Summer '87 because the Clipper screen  *
* drivers have not yet been provide by Nantucket.                   *
*                                                                   *
*********************************************************************
*
FLIP_INIT(1000)
SET_SAYERR(1)
DRV_SETUP(25,80)
SET COLOR TO "W/N,N/W,,N,N/W"       && temporary black & white color
*
USE TEST1
mm_font=FONT_OPEN("\FLIPPER\FONTS\FIX4_08.@")
mm_font=FONT_OPEN("\FLIPPER\FONTS\FIX5_08.@")
CLEAR SCREEN
*
M_mode=2
@ 21,0 SAY 'Mode: '
@ 21,col()+2 PROMPT 'Text'
@ 21,col()+2 PROMPT 'Graphics'
MENU TO M_mode
IF M_mode=2
   FSCREEN()
ENDIF
*
IF RET_BIOS() < 10
   mm_font=1
ELSE
   mm_font=2
ENDIF
IF RET_BIOS() > 9 .and. RET_BIOS() # 15 .and. RET_BIOS() #17
   is_color=.T.
   SET COLOR TO "GR+/N,N/GR,,N,R/RB"
ELSE
   is_color=.F.
   SET COLOR TO "W/N,N/W,,N,N/W"
ENDIF
*
SET CURSOR ON
*
DO WHILE .T.
   CLEAR SCREEN
   M_ANS=1
   @ 1,2 TO 18,38 double
   M_col=col()+2
   @ row()+1,M_col PROMPT 'SAY'
   @ row()+1,M_col PROMPT 'GET'
   @ row()+1,M_col PROMPT 'DBEDIT'
   @ row()+1,M_col PROMPT 'MEMOEDIT'
   @ row()+1,M_col PROMPT 'CLEAR SCREEN'
   @ row()+1,M_col PROMPT 'CURSOR'
   @ row()+1,M_col PROMPT 'NEW FONT'
   @ row()+1,M_col PROMPT 'SCREEN MODE'
   @ row()+1,M_col PROMPT 'CURSOR OFF'
   @ row()+1,M_col PROMPT 'CURSOR ON'
   @ row()+1,M_col PROMPT 'SCREEN SIZE'
   @ row()+1,M_col PROMPT 'SAVE SCREEN'
   MENU TO M_ANS
*
   DO CASE
      CASE M_ans=0
         EXIT
      CASE M_ans=1
         @ 20,10 SAY 'HELLO FROM SAY'
         inkey(0)
         @ 20,10
      CASE M_ans=2
         M_TEXT="This is a get!!    "
         @ 21,10 SAY 'This is a get: 'GET M_TEXT
         @ 22,10 SAY 'This is a get: 'GET M_TEXT
         READ
      CASE M_ans=3
         GOTO TOP
         DBEDIT(0,0,10,40,.F.)
      CASE M_ans=4
         CLEAR SCREEN
         NOTES=""
         @ 1,0 say 'ษออออออออออออออออออหอออออออออออออออออออออหออออออออออออออหออออออออออออออออออออออป'
         @ 2,0 say 'บ CURSOR:  <-- --> บ            UP  DOWN บ    DELETE    บ Insert Mode: Ins     บ'
         @ 3,0 say 'บ  Char: <-    ->  บ Line:             บ Char:    Del บ                      บ'
         @ 4,0 say 'บ  Word: ^<-   ^-> บ Page:    PgUp  PgDn บ Word:    ^T  บ Save:  ^W            บ'
         @ 5,0 say 'บ  Line: Home  End บ Window: ^PgUp ^PgDn บ Line:    ^Y  บ Abort: Esc           บ'
         @ 6,0 say 'บ                  บ Memo:   ^Home ^End  บ              บ                      บ'
         @ 7,0 say 'ศออออออออออออออออออสอออออออออออออออออออออสออออออออออออออสออออออออออออออออออออออผ'
         @ 8,4 TO 13,76
         NOTES=MEMOEDIT(NOTES,9,5,12,75,.T.)
      CASE M_ans=5
         CLEAR SCREEN
         inkey(0)
      CASE M_ans=6
         M_color=15           && Default color
         M_height=15          && Default color
         @ 21,0 SAY 'Enter cursor color:  'GET M_color PICT '99' RANGE 0,15
         @ 22,0 SAY 'Enter cursor height: 'GET M_height PICT '99'
         READ
         IF UPDATED()
            DRV_CURSOR(M_color,M_height)
         ENDIF
      CASE M_ans=7
         M_font=mm_font     && Default color
         @ 22,0 SAY 'Enter font handle: 'GET M_font PICT '9'
         READ
         CLEAR SCREEN
         DRV_FONT(M_font)
      CASE M_ans=8
         SET_PROG()
      CASE M_ans=9
         SET CURSOR OFF          && Standard Clipper Stuff
      CASE M_ans=10
         SET CURSOR ON           && Standard Clipper Stuff
      CASE M_ans=11
         M_rowset=0             && Number of rows
         M_colset=0             && Number of columns
*
         @ 21,0 SAY 'Enter rows:    'GET M_rowset PICT '999'
         @ 22,0 SAY 'Enter columns: 'GET M_colset PICT '999'
         READ
         IF UPDATED()
            DRV_SIZE(M_rowset,M_colset)
         ENDIF
         FOR I=0 to M_rowset
            @ I,0 SAY REPL(chr(177),M_colset)
         NEXT
         inkey(0)
         CLEAR SCREEN
      CASE M_ans=12
         winbuff = SAVESCREEN( 1, 2, 18, 38 )
         RESTSCREEN( 3, 4, 20, 40, winbuff )
         inkey(0)
   ENDCASE
ENDDO
TEXTMODE()

PROCEDURE SET_PROG

TEXTMODE()
M_mode=2
@ 21,0 SAY 'Mode: '
@ 21,col()+2 PROMPT 'Text'
@ 21,col()+2 PROMPT 'Graphics'
MENU TO M_mode
*
IF M_mode=2
   M_fdisp=4
   @ 22,0 SAY 'Display: '
   @ 22,col()+2 PROMPT 'CGA'
   @ 22,col()+3 PROMPT 'EGA'
   @ 22,col()+3 PROMPT 'VGA'
   @ 22,col()+3 PROMPT 'Hercules'
   MENU TO M_fdisp
*
   M_fmode=1
   @ 23,0 SAY 'Flipper mode: '
   IF M_fdisp > 0 .and. !M_fdisp=4
      @ 23,col()+2 PROMPT '320 x 200'
   ENDIF
   IF M_fdisp > 0 .and. !M_fdisp=4
      @ 23,col()+3 PROMPT '640 x 200'
   ENDIF
   IF M_fdisp > 1 .and. !M_fdisp=4
      @ 23,col()+3 PROMPT '640 x 350'
   ENDIF
   IF M_fdisp > 2 .and. !M_fdisp=4
      @ 23,col()+3 PROMPT '640 x 480'
   ENDIF
   IF M_fdisp = 4
      @ 23,col()+3 PROMPT 'Hercules'
   ENDIF
   MENU TO M_fmode
*
   DO CASE
      CASE M_fdisp=1
         SET_DISPLY(1)
      CASE M_fdisp=2
         SET_DISPLY(3)
      CASE M_fdisp=3
         SET_DISPLY(4)
      CASE M_fdisp=4
         SET_DISPLY(9)
   ENDCASE
   DO CASE
      CASE M_fmode=1
         GRAPHMODE(1)
      CASE M_fmode=2
         GRAPHMODE(2)
      CASE M_fmode=3
         GRAPHMODE(3)
      CASE M_fmode=4
         GRAPHMODE(4)
      CASE M_fmode=5
         GRAPHMODE(9)
   ENDCASE
   DO CASE
      CASE RET_CARD()=1                            && CGA
         SET COLOR TO "B/N,N/B,,N,N/B"
      CASE RET_CARD()=3                            && EGA
         SET COLOR TO "GR+/N,N/GR,,N,R/RB"
      CASE RET_CARD()=4                            && VGA
         SET COLOR TO "GR+/N,N/GR,,N,R/RB"
      CASE RET_CARD()=9                            && HERCULES
         SET COLOR TO "B/N,N/B,,N,N/B"
   ENDCASE
ENDIF
IF M_mode=2
   FSCREEN()
ENDIF