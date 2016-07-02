****************************************************
*                                                  *
*    C_EXAM07.PRG  -  Tests HPGL LaserJet III      *
*                                                  *
****************************************************
FLIP_INIT(1000)
HP_SETUP(1)                && Setup for LaserJet III
SET_SAYERR(1)
CLEAR SCREEN
SET CURSOR OFF
*
INITDATA(2)
*
stroke=FONT_OPEN("C:\FLIPPER\FONTS\SIM1_32.#")     && Open stroke font
SET_S_FONT(stroke)
SET_L_FONT(stroke)
SET_G_FONT(stroke)
*
USE TEST
*
SET_TYPE(1,1)
*
* Setup up for Plot
*
DO WHILE .NOT. EOF()
   @ 23,0 SAY STORE_DATA(XNUMBER,NUMBER1)
   SKIP
ENDDO
G_LABEL("Graph Title")
X_LABEL("X axis label")
Y_LABEL("Y axis label")
*
M_font = stroke
M_fg = 7
M_bg = -1
M_pat=2
M_linepat=0
M_dir=0
M_out=1
M_OBJECTS="57"
M_size = 100
M_angle = 0
M_align = 2
*
DO WHILE .T.
   SET CURSOR OFF
   OBJ_CHART()
   @ 6,20 PROMPT 'Screen'
   @ row()+1,20 PROMPT 'HPGL LJ-III'
   @ row()+1,20 PROMPT 'Images:'
   @ row()+1,20 PROMPT 'Orientation '+STR(HP_ROTATE(),2)
   @ row()+1,20 PROMPT 'Fill Pattern '+str(M_pat,2)
   @ row()+1,20 PROMPT 'Line Pattern '+str(M_linepat,2)
   @ row()+1,20 PROMPT 'Line Width'
   @ row()+1,20 PROMPT 'Font '+str(M_font,2)
   MENU TO M_out
*
   DO CASE
      CASE M_out = 0
         EXIT
      CASE M_out = 2
         M_ans=1
         @ 22,col()+2 SAY 'Output: '
         @ 22,col()+2 PROMPT 'Printer'
         @ 22,col()+2 PROMPT 'File'
         MENU TO M_ans
         DO CASE
            CASE M_ans = 1
               HP_OPEN('LJIII')
            CASE M_ans = 2
               HP_OPEN('LJIII_FILE')
            OTHERWISE
               LOOP
         ENDCASE
*         HPGL_SEND("SD1,21,2,1,4,25,5,1,6,0,7,5;SS;")   && Must have more
      CASE M_out = 3                                    && then 1 meg on LJIII
         SEL_IMAGE()
         LOOP
      CASE M_out = 4
         IF HP_ROTATE() = 0
            HP_ROTATE( 90 )
         ELSE
            HP_ROTATE( 0 )
         ENDIF
         LOOP
      CASE M_out = 5
         SET CURSOR ON
         @ 22,0 SAY 'Fill Pattern: 'GET M_pat PICT '99'
         READ
         LOOP
      CASE M_out = 6
         SET CURSOR ON
         @ 22,0 SAY 'Line Pattern: 'GET M_linepat PICT '99'
         READ
         LOOP
      CASE M_out = 7
         SET CURSOR ON
         SET_LINEWD()
         LOOP
      CASE M_out = 8
         SET CURSOR ON
         @ 16,0 SAY 'Font handle: 'GET M_font PICT '99'
         @ 17,0 SAY 'Foreground:  'GET M_fg PICT '99'
         @ 18,0 SAY 'Background:  'GET M_bg PICT '99'
         @ 19,0 SAY 'Alignment:   'GET M_align PICT '9'
         READ
         IF FRET_TYPE(M_font) = 1
            @ 20,0 SAY 'Size:        'GET M_size PICT '999'
            @ 21,0 SAY 'Angle:       'GET M_angle PICT '9999'
         ELSE
            @ 20,0 SAY 'Size:        'GET M_size PICT '9'
            @ 21,0 SAY 'Angle:       'GET M_angle PICT '9'
            @ 22,0 SAY 'Direction:   'GET M_dir PICT '9'
         ENDIF
         READ
         IF UPDATED()
            FONT_NEW(M_font)
            FONT_COLOR(M_font, M_fg, M_bg )
         ENDIF
         LOOP
   ENDCASE
*
   FSCREEN()
*
   IF '1'$M_OBJECTS
      PLOT()
   ENDIF
   IF '2'$M_OBJECTS
      PIE(1)
   ENDIF
   IF '3'$M_OBJECTS
      PAT_SETFIL( M_PAT )
      FCIRCLE(   100, 100, 50, 14 )
      FOVAL(     100, 200, 40, 60, 14 )
      FCIRCL_ARC(100, 300, 50, 900, 2700, 14 )
      FOVAL_ARC( 100, 400, 50, 40, 900, 2700, 14 )
      FPIE(      300, 100, 50, 900, 2700, 14 )
      FPIE_OVAL( 300, 200, 50, 40, 900, 2700, 14 )
      FCIRC_CLOS( 300, 300, 50, 900, 2700, 14 )
      FOVAL_CLOS(300, 400, 50, 40, 900, 2700, 14 )
      PAT_SETFIL( 0 )
   ENDIF
   IF '4'$M_OBJECTS
      DECLARE M_POINTS[10]             && Summer87 compatible
      M_POINTS[1] = 0
      M_POINTS[2] = 0
      M_POINTS[3] = 20
      M_POINTS[4] = 0
      M_POINTS[5] = 28
      M_POINTS[6] = 40

      M_POINTS[7] = 16
      M_POINTS[8] = 30
      M_POINTS[9] = 0
      M_POINTS[10]= 0
      FOR I = 0 TO 10
         PAT_SETFIL(I)
         FPOLY_LINE( I*40+50, 140, M_POINTS, 15-I)
      NEXT
      PAT_SETFIL( 0 )
   ENDIF
   IF '5'$M_OBJECTS
      PAT_SETLIN( M_linepat )
      FLINE( 200, 300, 400, 300, 15 )
      FLINE( 300, 200, 300, 400, 15 )
      PAT_SETLIN( 0 )
   ENDIF
   IF '6'$M_OBJECTS
      PAT_SETFIL( M_pat )
      FBOX( 134, 156, 234, 300, 14 )
      PAT_SETFIL( 0 )
   ENDIF
   IF '7'$M_OBJECTS
      SAY_TEXT(300,270,'HELLO WORLD 1')
      LINE_JUST(1)
      SAY_TEXT(300,300,'HELLO WORLD 2')
      LINE_JUST(2)
      SAY_TEXT(300,330,'HELLO WORLD 3')

      LINE_JUST(0)
      IF FRET_TYPE(M_font) = 1
         FONT_ROTAT(M_font, M_angle)
      ELSE
         FONT_ROTAT(M_font, M_angle)
         LINE_DIR( M_dir )
      ENDIF
      FONT_ALIGN(M_font, M_align)

      SAY_TEXT(300,270,'HELLO WORLD 4')

      LINE_DIR( 1 )                          && Reset font
      FONT_ROTAT(M_font, 0)
      FONT_ALIGN(M_font, 2)
   ENDIF
*
   DO CASE
      CASE M_out = 1
         inkey(0)
         SET CURSOR OFF
      CASE M_out = 2
         LJ3_EJECT()
         HP_CLOSE()
   ENDCASE
   TEXTMODE()
ENDDO

FUNCTION OBJ_CHART
*
CLEAR SCREEN
@ 8,30
IF '1'$M_OBJECTS
   ?? "PLOT"
ENDIF
IF '2'$M_OBJECTS
   ?? " PIE"
ENDIF
IF '3'$M_OBJECTS
   ?? " ARC"
ENDIF
IF '4'$M_OBJECTS
   ?? " POLYGON"
ENDIF
IF '5'$M_OBJECTS
   ?? " LINE"
ENDIF
IF '6'$M_OBJECTS
   ?? " BOX"
ENDIF
IF '7'$M_OBJECTS
   ?? " TEXT"
ENDIF

FUNCTION SEL_IMAGE
FOR X = 1 TO 12
   @ 5+X,24 SAY SPACE(20)
NEXT
@ 7,25 TO 17,42 DOUBLE
DO WHILE .T.
   FOR I = 1 TO 7
      IF STR(I,1,0)$M_OBJECTS
         @ I+7,26 SAY '*'
         @ 17,26 SAY CHR(205)
      ELSE
         @ I+7,26 SAY ' '
         @ 17,26 SAY CHR(205)
      ENDIF
   NEXT
   @ 8,28 PROMPT 'PLOT    '
   @ 9,28 PROMPT 'PIE     '
   @ 10,28 PROMPT 'ARC     '
   @ 11,28 PROMPT 'POLYGON '
   @ 12,28 PROMPT 'LINE    '
   @ 13,28 PROMPT 'BOX     '
   @ 14,28 PROMPT 'TEXT    '
   MENU TO M_select
   DO CASE
      CASE M_select = 0
         EXIT
      CASE M_select = 1 .and. ! '1'$M_OBJECTS
         M_OBJECTS=M_OBJECTS+'1'
      CASE M_select = 1 .and. '1'$M_OBJECTS
         M_OBJECTS=SUBSTR(M_OBJECTS,1,AT("1",M_OBJECTS)-1) + SUBSTR(M_OBJECTS,AT("1",M_OBJECTS)+1,LEN(M_OBJECTS)) + ' '
      CASE M_select = 2 .and. ! '2'$M_OBJECTS
         M_OBJECTS=M_OBJECTS+'2'
      CASE M_select = 2 .and. '2'$M_OBJECTS
         M_OBJECTS=SUBSTR(M_OBJECTS,1,AT("2",M_OBJECTS)-1) + SUBSTR(M_OBJECTS,AT("2",M_OBJECTS)+1,LEN(M_OBJECTS)) + ' '
      CASE M_select = 3 .and. ! '3'$M_OBJECTS
         M_OBJECTS=M_OBJECTS+'3'
      CASE M_select = 3 .and. '3'$M_OBJECTS
         M_OBJECTS=SUBSTR(M_OBJECTS,1,AT("3",M_OBJECTS)-1) + SUBSTR(M_OBJECTS,AT("3",M_OBJECTS)+1,LEN(M_OBJECTS)) + ' '
      CASE M_select = 4 .and. ! '4'$M_OBJECTS
         M_OBJECTS=M_OBJECTS+'4'
      CASE M_select = 4 .and. '4'$M_OBJECTS
         M_OBJECTS=SUBSTR(M_OBJECTS,1,AT("4",M_OBJECTS)-1) + SUBSTR(M_OBJECTS,AT("4",M_OBJECTS)+1,LEN(M_OBJECTS)) + ' '
      CASE M_select = 5 .and. ! '5'$M_OBJECTS
         M_OBJECTS=M_OBJECTS+'5'
      CASE M_select = 5 .and. '5'$M_OBJECTS
         M_OBJECTS=SUBSTR(M_OBJECTS,1,AT("5",M_OBJECTS)-1) + SUBSTR(M_OBJECTS,AT("5",M_OBJECTS)+1,LEN(M_OBJECTS)) + ' '
      CASE M_select = 6 .and. ! '6'$M_OBJECTS
         M_OBJECTS=M_OBJECTS+'6'
      CASE M_select = 6 .and. '6'$M_OBJECTS
         M_OBJECTS=SUBSTR(M_OBJECTS,1,AT("6",M_OBJECTS)-1) + SUBSTR(M_OBJECTS,AT("6",M_OBJECTS)+1,LEN(M_OBJECTS)) + ' '
      CASE M_select = 7 .and. ! '7'$M_OBJECTS
         M_OBJECTS=M_OBJECTS+'7'
      CASE M_select = 7 .and. '7'$M_OBJECTS
         M_OBJECTS=SUBSTR(M_OBJECTS,1,AT("7",M_OBJECTS)-1) + SUBSTR(M_OBJECTS,AT("7",M_OBJECTS)+1,LEN(M_OBJECTS)) + ' '
   ENDCASE
ENDDO

FUNCTION SET_LINEWD
DECLARE WID_ARRAY[16]
@ 3,10 TO 20,20 DOUBLE
FOR I=0 to 15
   WID_ARRAY[I+1] = HP_LNSTYLE( I ) /100
   @ 4+I, 12 GET WID_ARRAY[I+1] PICT '99.99'
NEXT
READ
IF UPDATED()
   FOR I=0 to 15
      HP_LNSTYLE( I, WID_ARRAY[I+1]*100 )
   NEXT
ENDIF
