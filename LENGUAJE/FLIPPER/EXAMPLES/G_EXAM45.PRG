************************************************************
*  Print labels to screen and to HPGL/2 the same way.      *
************************************************************
*
FLIP_INIT(6000,100)
SET_SAYERR()
DECLARE Arrot[4]
DECLARE Ardir[4]

FONT_OPEN("RMN7_25.@")
Arrot[1]="zero"
Arrot[2]="90 deg"
Arrot[3]="180 deg"
Arrot[4]="270 deg"

Ardir[1]="rt to lf"
Ardir[2]="lf to rt"
Ardir[3]="bott to top"
Ardir[4]="top to bott"

M_color = 1
G_font0 = 3
M_ans = 1
M_justify = 0
M_align = 0

DO WHILE .T.
   CLEAR SCREEN
   @ 22,0 SAY 'Output:'
   @ 22, col()+2 PROMPT 'SCREEN'
   @ 22, col()+2 PROMPT 'LaserJet III'
   @ 22, col()+2 PROMPT 'Color'
   @ 22, col()+2 PROMPT 'Font'
   @ 22, col()+2 PROMPT 'Justify'
   MENU TO M_ans
*
   DO CASE
      CASE LASTKEY()=27
         EXIT
      CASE M_ans = 1
      CASE M_ans = 2
         HP_SETUP(1)                    && LJ-III landscape
         M_ans1=1
         @ 23,0 PROMPT 'LPT1'
         @ 23,col()+2 PROMPT 'File'
         MENU TO M_ans1
         IF M_ans1 = 1
            HP_OPEN('LJIII')
         ELSE
            HP_OPEN('LJIII_FILE')
         ENDIF
      CASE M_ans = 3
         @ 20,0 SAY 'BG Color: 'GET M_color PICT '99'
         READ
         LOOP
      CASE M_ans = 4
         @ 20,0 SAY 'Font handle: 'GET G_font0 PICT '9' VALID G_font0 < 5
         READ
         LOOP
      CASE M_ans = 5
         @ 19,0 SAY 'Align: (0-top, 1-middle, 2-baseline, 3-bottom) 'GET M_align PICT '9' VALID M_justify < 4
         @ 20,0 SAY 'Justify: (0-start, 1-center, 2-end)            'GET M_justify PICT '9' VALID M_justify < 3
         READ
         LOOP
   ENDCASE
*
   FSCREEN()
   SHOW_STUFF(M_ans)
*
   IF M_ans = 2
      LJ3_EJECT()
      HP_CLOSE()
   ELSE
      TEXTMODE()
   ENDIF
ENDDO


FUNCTION SHOW_STUFF
PARA M_ans

   FONT_NEW( G_font0 )
   FONT_COLOR( G_font0, 15, M_color)
   IF M_ans = 1
      mx = ATX(50,2)
      my = ATY(50,2)
   ELSE
      my = 10
   ENDIF
   FOR I=0 to 3                   && possible rotate modes
      IF M_ans = 2
         mx = 50
         my = my + 200
      ENDIF

      FONT_ROTAT( g_font0, I )
      FOR J=0 to 3               && possible line_dir modes
         LINE_DIR(J)            && top to bott = 3
         LINE_JUST( M_justify )
         FONT_ALIGN( G_font0, M_align )
         IF M_ans = 1
            SAY_TEXT( mx, my, Arrot[I+1]+' '+Ardir[J+1])
            SET_XOR(1)
            FLINE( mx, my-100, mx, my+100,7)
            FLINE( mx-100, my, mx+100, my,7)
            SET_XOR(0)
            inkey(0)
            IF LASTKEY()=27
               RETURN
            ENDIF
            CLS_SCREEN()
         ELSE
            FLINE( mx, my-20, mx, my+20,15)
            FLINE( mx-20, my, mx+20, my,15)
            SAY_TEXT( mx, my, Arrot[I+1]+' '+Ardir[J+1])
            mx = mx + 150
         ENDIF
      NEXT
   NEXT
