*******************************************************************************
*  G_EXAM43.PRG                                                               *
*  Author: Gary Prothero                                                      *
*  Requirements: Link FLIPTEXT.OBJ into your program as a file.               *
*  Description:                                                               *
*     This is an examples of implementing the screen drivers for Clipper 5.01.*
*     Since Nantucket has not yet released the screen driver API information  *
*     I had to modify the screen driver source code.  However  FLIPTEXT.OBJ  *
*     should run Clipper in graphics mode transparently.                      *
*     SETMODE(43,80) or SETMODE(50,80) can be used to extend the rows for the *
*     screen drivers. At this time time you can only display 80 columns, this *
*     should change when the API is released.                                 *
*                                                                             *
*     FLIPTEXT.OBJ should be linked in as a FI in the script file             *
*     If you want a flashing cursor use MYCURSOR module in the root.          *
*         _FlpCursor(1)              && Turn on blinking cursor               *
*         _FlpCursor(0)              && Turn off blinking cursor              *
*         (Turn on after you enter graphics mode)                             *
*                             *                                               *
*     DRV_BEGIN()    - Starts the screen drivers. Must be in graphics mode    *
*     DRV_END()      - Ends the screen drivers. Allows Clipper to run in      *
*                      text mode.                                             *
*     DRV_FONT(fh)   - Set the font to be used for the screen drivers         *
*     DRV_CURSOR(fg) - Set the color for the cursor.                          *
*                                                                             *
*     The blinking cursor is in CLIP50.LIB in a module called MYCURSOR.OBJ.   *
*     This module needs to be in the root. (BLINK502.LNK for blinker)         *
*******************************************************************************
M_bios = FLIP_INIT(1,1)
SET_SAYERR(1)
IF M_bios > 9 .and. M_bios # 15 .and. M_bios #17            && Color
   SET COLOR TO "GR+/B,B/GR,,B,R/W"
   IF M_bios == 18
      scrn_font = 3
   ELSE
      scrn_font = 2
   ENDIF
ELSE
   SET COLOR TO "W/N,N/W,,N,N/W"                               && BW
   scrn_font = 1
ENDIF
*
FONT_OPEN("C:\FLIPPER\FONTS\FIX4_08.@")
FONT_OPEN("C:\FLIPPER\FONTS\FIX5_08.@")
FONT_OPEN("C:\FLIPPER\FONTS\RMN9_14.@")
*
DRV_FONT( scrn_font )
NOTES=""
SETMODE(50,80)
DO WHILE .T.
   CLEAR SCREEN
   @ 22,0 SAY 'Set mode: '
   @ 22,col()+2 PROMPT 'TEXT'
   @ 22,col()+2 PROMPT 'GRAPHICS'
   @ 22,col()+2 PROMPT 'FONT'
   @ 22,col()+2 PROMPT 'CURSOR'
   MENU TO M_ans
   CLEAR SCREEN
   DO CASE
      CASE M_ans = 0
         RETURN
      CASE M_ans = 1
      CASE M_ans = 2
         FSCREEN()
         DRV_BEGIN()
*         _FlpCursor(1)              && Turn on blinking cursor
      CASE M_ans = 3
         @ 22,0
         @ 22,0 SAY 'Enter font number: 'GET scrn_font PICT '9' VALID FONT_CURR(scrn_font) > 0
         READ
         IF UPDATED()
            DRV_FONT( scrn_font )
         ENDIF
         LOOP
      CASE M_ans = 4
         M_color = 15           && Default color
         M_height = 15          && Default color
         @ 21,0 SAY 'Enter cursor color:  'GET M_color PICT '99' RANGE 0,15
         @ 22,0 SAY 'Enter cursor height: 'GET M_height PICT '99'
         READ
         IF UPDATED()
            DRV_CURSOR( M_color, M_height )
         ENDIF
         LOOP
   ENDCASE
*
   WAIT                                && Testing cursor
   SET CURSOR OFF
   WAIT
   SET CURSOR ON
*
   @ 1,0 SAY "Menu example A "
   @ 22,0 SAY 'MENU TO EXAMPLE: '
   @ 22,col()+2 PROMPT 'ONE'
   @ 22,col()+2 PROMPT 'TWO'
   @ 22,col()+2 PROMPT 'THREE'
   @ 22,col()+2 PROMPT 'FOUR'
   MENU TO M_choice

   @ 1,0 SAY "Box example B  "
   B_SINGLE =    ( CHR(218) + CHR(196) + CHR(191) + CHR(179) + ;
                  CHR(217) + CHR(196) + CHR(192) + CHR(179) )
   @ 8, 0, 17, 79 BOX B_SINGLE
   @ 10,10 SAY 'HELLO'
   @ 15,10 SAY 'Gary'
   @ 24,32 SAY '>> Tap any key <<'
   inkey(0)
*
   @ 1,0 SAY "Scroll example C"
   SCROLL( 9, 1, 16, 78, 1 )
   @ 24,32 SAY '>> Tap any key <<'
   inkey(0)
   SCROLL( 9, 1, 16, 78, 2 )
   @ 24,32 SAY '>> Tap any key <<'
   inkey(0)
*
   @ 1,0 SAY "Save screen example D"
   SAVE SCREEN
   CLEAR SCREEN
   @ 24,32 SAY '>> Tap any key <<'
   inkey(0)
   @ 1,0 SAY "Restore screen example E"
   RESTORE SCREEN
   @ 24,32 SAY '>> Tap any key <<'
   inkey(0)
*
   CLEAR SCREEN
   @ 1,0 SAY "Restore screen example F"
   M_get=space(20)
   M_get1=space(30)
   M_get2=space(40)
   @ 20,0 SAY 'This is a GET: 'GET M_get
   @ 21,0 SAY 'Another GET:   'GET M_get1
   @ 22,0 SAY 'Third GET:     'GET M_get2
   READ
*
   CLEAR SCREEN
   USE TEST1
   GOTO TOP
   DBEDIT(14,10,23,70,.F.)
*
   CLEAR SCREEN
   @ 1,0 say 'ษออออออออออออออออออหอออออออออออออออออออออหออออออออออออออหออออออออออออออออออออออป'
   @ 2,0 say 'บ CURSOR:  <-- --> บ            UP  DOWN บ    DELETE    บ Insert Mode: Ins     บ'
   @ 3,0 say 'บ  Char: <-    ->  บ Line:             บ Char:    Del บ                      บ'
   @ 4,0 say 'บ  Word: ^<-   ^-> บ Page:    PgUp  PgDn บ Word:    ^T  บ Save:  ^W            บ'
   @ 5,0 say 'บ  Line: Home  End บ Window: ^PgUp ^PgDn บ Line:    ^Y  บ Abort: Esc           บ'
   @ 6,0 say 'บ                  บ Memo:   ^Home ^End  บ              บ                      บ'
   @ 7,0 say 'ศออออออออออออออออออสอออออออออออออออออออออสออออออออออออออสออออออออออออออออออออออผ'
   @ 8,4 TO 13,76
   NOTES=MEMOEDIT(NOTES,9,5,12,75,.T.)

   winbuff = SAVESCREEN( 1, 2, 18, 38 )
   RESTSCREEN( 3, 4, 20, 40, winbuff )
   inkey(0)
*
   IF M_ans = 1
      @ 1,0 SAY 'Clipper text colors'
   ELSE
      @ 1,0 SAY 'Flipper graphic text colors'
   ENDIF
   DECLARE A[16]
   A[1]='N'
   A[2]='B'
   A[3]='G'
   A[4]='BG'
   A[5]='R'
   A[6]='RB'
   A[7]='GR'
   A[8]='W'
   A[9]='N+'
   A[10]='B+'
   A[11]='G+'
   A[12]='BG+'
   A[13]='R+'
   A[14]='RB+'
   A[15]='GR+'
   A[16]='W+'
   @ 3,0 CLEAR
   FG=1
   BG=1
   HORZ=0
   VERT=5
   DO WHILE FG<=16
      VERT=VERT+1
      DO WHILE BG<=8
         TRY=A[FG]+'/'+A[BG]
         SET COLOR TO &TRY
         @ VERT,HORZ SAY STR(FG-1,2)+STR(BG-1,2)
         VERT=VERT+1
         BG=BG+1
      ENDDO
      BG=1
      FG=FG+1
      HORZ=HORZ+5
      VERT=5
   ENDDO
   SET COLOR TO &STANDARD
   INKEY(0)
*
   DO CASE
      CASE M_ans = 1
      CASE M_ans = 2
*        _FlpCursor(0)                 && Turn off blinking cursor
         TEXTMODE()
         DRV_END()
   ENDCASE
ENDDO

