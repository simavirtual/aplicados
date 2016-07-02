****************************************************
*                                                  *
*    C_EXAM07.PRG  -  Tests postscript printing    *
*                                                  *
****************************************************
FLIP_INIT(1000)
PS_SETUP()
SET_SAYERR(1)
CLEAR SCREEN
SET CURSOR OFF
*
INITDATA(3)
*
stroke=FONT_OPEN("C:\FLIPPER\FONTS\SIM1_32.#")     && Open stroke font
SET_S_FONT(stroke)
SET_L_FONT(stroke)
SET_G_FONT(stroke)
*
USE TEST
*
SET_TYPE(1,1)
SET_TYPE(2,1)
SET_YSIDE(2,2)
*
* Setup up for Plot
*
DO WHILE .NOT. EOF()
   @ 23,0 SAY STORE_DATA(XCHARACTER,NUMBER1,NUMBER2)
   SKIP
ENDDO
G_LABEL("Graph Title")
X_LABEL("X axis label")
Y_LABEL("Y axis label")
Y_LABEL("Y axis label 2",2)
*
* Print screen
M_rotate = 0
M_p1x = 0
M_p1y = 0
M_p2x = 0
M_p2y = 0
*
M_pat=2
M_linepat=0
M_dir=0
M_out=1
M_OBJECTS="2"
FONT_NEW(2)
*
PIE_3D( 20 )
PIE_ASPECT(0.6)
*
DO WHILE .T.
   SET CURSOR OFF
   OBJ_CHART()
   @ 6,20 PROMPT 'Screen'
   @ row()+1,20 PROMPT 'Postscript'
   @ row()+1,20 PROMPT 'Images:'
   @ row()+1,20 PROMPT 'Orientation '+STR(PS_ROTATE(),2)
   @ row()+1,20 PROMPT 'Fill Pattern '+str(M_pat,2)
   @ row()+1,20 PROMPT 'Line Pattern '+str(M_linepat,2)
   @ row()+1,20 PROMPT 'Line Width'
   @ row()+1,20 PROMPT 'Image size'
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
               PS_OPEN('LPT1')
            CASE M_ans = 2
               PS_OPEN('FILE')
            OTHERWISE
               LOOP
         ENDCASE
      CASE M_out = 3
         SEL_IMAGE()
         LOOP
      CASE M_out = 4
         IF PS_ROTATE() = 0
            PS_ROTATE( 90 )
         ELSE
            PS_ROTATE( 0 )
         ENDIF
         SET_IMGSIZ("*** Image size RESET due to rotation of output ***")
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
         SET_IMGSIZ("*** Image size retained ***")
         LOOP
   ENDCASE
*
   FSCREEN()
*
   IF '1'$M_OBJECTS
      SET_YSPACE( 1 )
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
      SAY_TEXT(300,270,'HELLO WORLD lower y p q 1')
      LINE_JUST(1)
      SAY_TEXT(300,300,'HELLO WORLD lower y p q 2')
      LINE_JUST(2)
      SAY_TEXT(300,330,'HELLO WORLD lower y p q 3')

      LINE_JUST(0)
      FONT_ROTAT(2, 1)
      FONT_ALIGN(2, 0)
      LINE_DIR( 2 )                 && For screen
      SAY_TEXT(300,270,'HELLO WORLD lower y p q 3')
      LINE_DIR( 1 )
      FONT_ROTAT(2, 0)
      FONT_ALIGN(2, 2)
   ENDIF
   IF '8'$M_OBJECTS
      SAY_MARK( ATX(35,2), ATY(50,2), 2, 3 )
      SAY_TEXT( ATX(40,2), ATY(50,2), "HELLO WORLD" )
   ENDIF
*
   DO CASE
      CASE M_out = 1
         inkey(0)
         TEXTMODE()
         SET CURSOR OFF
      CASE M_out = 2
         PS_EJECT()
         PS_CLOSE()
   ENDCASE
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
IF '8'$M_OBJECTS
   ?? " LEGEND"
ENDIF

FUNCTION SEL_IMAGE
FOR X = 1 TO 12
   @ 5+X,24 SAY SPACE(20)
NEXT
@ 7,25 TO 17,42 DOUBLE
DO WHILE .T.
   FOR I = 1 TO 8
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
   @ 15,28 PROMPT 'LEGEND  '
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
      CASE M_select = 8 .and. ! '8'$M_OBJECTS
         M_OBJECTS=M_OBJECTS+'8'
      CASE M_select = 8 .and. '8'$M_OBJECTS
         M_OBJECTS=SUBSTR(M_OBJECTS,1,AT("8",M_OBJECTS)-1) + SUBSTR(M_OBJECTS,AT("8",M_OBJECTS)+1,LEN(M_OBJECTS)) + ' '
   ENDCASE
ENDDO

FUNCTION SET_LINEWD
DECLARE WID_ARRAY[16]
@ 3,10 TO 20,20 DOUBLE
FOR I=0 to 15
   WID_ARRAY[I+1] = PS_LNSTYLE( I ) / 100
   @ 4+I, 12 GET WID_ARRAY[I+1] PICT '999.99'
NEXT
READ
IF UPDATED()
   FOR I=0 to 15
      PS_LNSTYLE( I, WID_ARRAY[I+1]*100 )
   NEXT
ENDIF

FUNCTION SET_IMGSIZ
PARA MESSAGE
PS_ROTATE( @M_rotate, @M_p1x, @M_p1y, @M_p2x, @M_p2y )
SET CURSOR ON
@ 21,0 SAY 'Image placement-(in 1/72th of an inch): '
@ 21,col()+2 SAY 'Orientation: '+STR(M_rotate,2)
@ 22,0 SAY '  p2: '
@ 22,col()+2 GET M_p1x PICT '999'
@ 22,col()+2 GET M_p1y PICT '999'
@ 22,col()+4 SAY '  p2: '
@ 22,col()+2 GET M_p2x PICT '999'
@ 22,col()+2 GET M_p2y PICT '999'
@ 23,0 SAY MESSAGE
READ
IF UPDATED()
   PS_ROTATE(M_rotate, M_p1x, M_p1y, M_p2x, M_p2y )
ENDIF
