****************************************************
*                                                  *
*    C_EXAM07.PRG  -  Tests printing routines      *
*                     Print screen                 *
****************************************************
FLIP_INIT(1000)
HP_SETUP(1)             && Special code for LaserJet3
HP_ROTATE(90)           && Landscape
SET_SAYERR(1)
CLEAR SCREEN
*
INITDATA(5)
*
stroke=FONT_OPEN("C:\FLIPPER\FONTS\SIM1_32.#")     && Open stroke font
SET_S_FONT(stroke)
SET_L_FONT(stroke)
SET_G_FONT(stroke)
*
DECLARE M_objarr[7]
*
DECLARE PRINT_DEF[17]
M_printer = 0
number = PRT_LIST("C:\FLIPPER\LIBRARY\PRX_TBL.BIN") && Return number of printers
DECLARE PRINT_NAME[number]
PRT_LIST( PRINT_NAME )
*
USE TEST
*
SET_TYPE(1,3)
SET_TYPE(2,1)
SET_TYPE(3,1)
SET_TYPE(4,1)
SET_STYLE(4,7)
M_orient = 0
M_start = 0
M_end = 0
*
* Setup up for Plot
*
DO WHILE .NOT. EOF()
   @ 23,0 SAY STORE_DATA(XCHARACTER, NUMBER1, NUMBER2, NUMBER3, NUMBER4)
   SKIP
ENDDO
G_LABEL("Graph Title")
X_LABEL("X axis label")
Y_LABEL("Y axis label")
Y_LABEL("Y axis 2",2)
*
* Print screen
M_shade = 0
M_WhiteBlack = 0
M_top=0
M_left=0
M_xsize=6                               && Horizontal size in inches
M_ysize=4.5                             && Vertical size in inches
M_offset=0
M_Yposition=100
*
M_pat=2
M_dir=0
M_output=1
M_OBJECTS="1"
M_p1x = 0
M_p1y = 0
M_p2x = 0
M_p2y = 0
SET KEY -1 TO SEL_IMAGE
SET KEY -3 TO SEL_ORIENT
SET KEY -4 TO SEL_PAT
SET KEY -5 TO SEL_ROTATE
SET KEY -6 TO SEL_PRINT
SET KEY -7 TO SEL_OFFSET
SET KEY -8 TO SEL_OPTION
SET KEY -9 TO SEL_SIZE
SET KEY -10 TO PJ_COLORS
SET KEY -11 TO PJ_SHADES
FONT_NEW(2)
*
*
M_display = RET_DISPLY()
M_mode = RET_CARD()
@ 21,0 SAY 'Display: 'GET M_display PICT '9'
@ 22,0 SAY 'Mode:    'GET M_mode PICT '99'
READ
IF LASTKEY()=27
   RETURN
ENDIF
SET_DISPLY(M_display)
GRAPHMODE(M_mode)
*
*
DO WHILE .T.
   SET CURSOR ON
   SET CURSOR OFF
   SET COLOR TO GR+/B
   CLEAR SCREEN
   IF( M_start > 0 )
      @ 1,60 SAY 'Time: '+STR( (M_end-M_start)/18.2, 5 ,0 )+' seconds'
   ENDIF
   @ 2,60 SAY MEMORY(0)
   @ 0,0 TO 24,79 DOUBLE
   CENTER(0,"Printing Example")
   @ 2,25 SAY 'Place image to:'
   @ 3,24 TO 9,49 DOUBLE
   @ row(),25 PROMPT 'Screen                  '
   @ row()+1,25 PROMPT 'Printer -  Memory Screen'
   @ row()+1,25 PROMPT 'Printer -  Screen dump  '
   @ row()+1,25 PROMPT 'HPGL LJ-III             '
   @ row()+1,25 PROMPT 'Exit                    '
   @ 17,1 TO 24,78
   CENTER(17,"Function Keys")
   OBJ_CHART()
   @ 18,2 SAY 'F2 - Graphic Elements: See Chart Above'
   IF M_orient = 0
      @ 20,2 SAY 'F4 - Rotation:      Landscape'
   ELSE
      @ 20,2 SAY 'F4 - Rotation:      Portrait '
   ENDIF
   @ 21,2 SAY 'F5 - Line Pattern:     '+str(M_pat,1)
   @ 22,2 SAY 'F6 - Font Direction:   '+str(M_dir,1)
   IF M_printer = 0
      @ 23,2 SAY 'F7 - Print # Not set'
   ELSE
      @ 23,2 SAY 'F7 - Print #'+str(M_printer,3)+' :      '+TRIM(PRINT_DEF[2])
   ENDIF
   SEP_LINE()
   @ 18,50 SAY 'F8  - Margins      '+ALLTRIM(str(M_top,3))+' - '+ALLTRIM(str(M_left,3))
   @ 19,50 SAY 'F9  - Options      '+str(M_shade,1)+' - '+str(M_WhiteBlack,1)
   @ 20,50 SAY 'F10 - Image size   '+str(M_xsize,1)+' - '+str(M_ysize,1)
   @ 21,50 SAY 'Shift F1 - Colors'
   @ 22,50 SAY 'Shift F2 - Shades'
   MENU TO M_output
   IF LASTKEY()=27
      EXIT
   ENDIF
   IF LASTKEY()=3
      LOOP
   ENDIF
*
   IF M_output > 1 .and. M_output < 4
      IF PRT_CHECK(0) == 0             && Check LPT1
         CENTER( 9, "Printer Off Line")
         ? chr(7)
         inkey(0)
         LOOP
      ENDIF
      IF M_printer = 0
         CENTER( 9, "Printer Not Set")
         ? chr(7)
         inkey(0)
         LOOP
      ENDIF
   ENDIF
*
   NUM_SWATHS = 1
*
   DO CASE
      CASE M_output = 1
         FSCREEN()
      CASE M_output = 2
         PRT_STAT(1)
         PRT_OPTS(M_orient,M_shade,M_whiteBlack,0,0,1)
         NUM_SWATHS = MPRT_OPEN(M_xsize*100, M_ysize*100, 10000)
      CASE M_output = 3
         PRT_STAT(1)
         PRT_OPTS(M_orient,M_shade,M_whiteBlack,1,0)
         PRT_SCALE(2)
         FSCREEN()
      CASE M_output = 4
         HP_SETUP(1)          && Special code for LaserJet3
         HP_OPEN('LJIII')
         HPGL_SEND("SD1,21,2,1,4,25,5,1,6,0,7,5;SS;")
      CASE M_output = 5
         EXIT
   ENDCASE
*
   M_start=RET_TIME()
   FOR I=1 TO NUM_SWATHS
      MPRT_SWATH(I)
*
      IF '1'$M_OBJECTS
         PLOT()
         LEGEND_SET(1,"Computers Sold")
         LEGEND_SET(2,"Computer Sales")
         LEGEND_SET(3,"Overhead minus wages")
         LEGEND_SET(4,"Profits")
         LEGEND_SAY( ATX(10,2), ATY(18,2), 1, 0, 0, 3, 0)
      ENDIF
      IF '2'$M_OBJECTS
         PIE_3D( 90 )
         PIE_ASPECT( 0.6 )
         PIE( 1, 50, 50 )
         PIE_ASPECT(1.0)
      ENDIF
      IF '3'$M_OBJECTS
         FCIRCL_ARC( 300, 300, 100, 100, 2700, 14 )
      ENDIF
      IF '4'$M_OBJECTS
         PAT_SETFIL( M_PAT )
         FCIRCLE( 100, 100, 50, 14 )
         FOVAL( 100, 200, 40, 60, 14 )
         FCIRCL_ARC( 100, 300, 50, 900, 2700, 14 )
         FOVAL_ARC( 100, 400, 50, 40, 900, 2700, 14 )
         FPIE( 300, 100, 50, 900, 2700, 14 )
         FPIE_OVAL( 300, 200, 50, 40, 900, 2700, 14 )
         PAT_SETFIL( 0 )
      ENDIF
      IF '5'$M_OBJECTS
         FLINE( 100, 100, 200, 200, 15 )
      ENDIF
      IF '6'$M_OBJECTS
         FBOX( ATX(0,2), ATY(0,2), ATX(100,2), ATY(100,2), 14 )
         FBOX( 10, 10, 101, 101, 15 )
         FBOX( 134, 156, 234, 300, 14 )
      ENDIF
      IF '7'$M_OBJECTS
         FONT_ROTAT( 2, M_dir )
         SAY_TEXT(150,150,'HELLO WORLD lower')
      ENDIF
      IF '8'$M_OBJECTS
         PAT_SETFIL( 1 )
         FOR J = 0 TO 15
            FBOX( J*50+50, 75, J*50+90, 100, 15-J )
         NEXT
         PAT_SETFIL( 0 )
      ENDIF
      IF M_output=2
         MPRT_SCRN(100, 100, M_left*100, M_top*100)
         IF PRT_ESCAPE() = 1
            EXIT
         ENDIF
      ENDIF
   NEXT
*
   DO CASE
      CASE M_output = 1
         inkey(0)
         TEXTMODE()
         SET CURSOR OFF
      CASE M_output = 2
         MPRT_CLOSE()
         IF PRT_CHECK(0) = 1
            EJECT
         ENDIF
         PRT_HANDLE()
      CASE M_output = 3
         PRT_SCREEN(M_xsize*100, M_ysize*100, M_left*100, M_top*100)
         SET CURSOR OFF
         TEXTMODE()
      CASE M_output = 4
         HP_CLOSE()
         LJ3_EJECT()
   ENDCASE
   M_end=RET_TIME()
ENDDO
SET COLOR TO
SET CURSOR ON
CLEAR SCREEN

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
   @ 9,28 PROMPT 'ARC     '
   @ 10,28 PROMPT 'CIRCLE  '
   @ 11,28 PROMPT 'LINE    '
   @ 12,28 PROMPT 'BOX     '
   @ 13,28 PROMPT 'TEXT    '
   @ 14,28 PROMPT 'FILL BOX'
   @ 16,28 PROMPT 'CLEAR   '
   MENU TO M_select
   DO CASE
      CASE M_select = 0
         EXIT
      CASE M_select = 1 .and. ! '1'$M_OBJECTS
         M_OBJECTS=M_OBJECTS+'1'
      CASE M_select = 2 .and. ! '2'$M_OBJECTS
         M_OBJECTS=M_OBJECTS+'2'
      CASE M_select = 3 .and. ! '3'$M_OBJECTS
         M_OBJECTS=M_OBJECTS+'3'
      CASE M_select = 4 .and. ! '4'$M_OBJECTS
         @ 15,26 SAY 'Y position: 'GET M_Yposition PICT '999'
         READ
         @ 15,26 SAY SPACE(16)
         M_OBJECTS=M_OBJECTS+'4'
      CASE M_select = 5 .and. ! '5'$M_OBJECTS
         M_OBJECTS=M_OBJECTS+'5'
      CASE M_select = 6 .and. ! '6'$M_OBJECTS
         M_OBJECTS=M_OBJECTS+'6'
      CASE M_select = 7 .and. ! '7'$M_OBJECTS
         M_OBJECTS=M_OBJECTS+'7'
      CASE M_select = 8
         M_OBJECTS=""
   ENDCASE
ENDDO
KEYBOARD( chr(3) )

FUNCTION SEL_ORIENT
IF M_orient = 1
   HP_ROTATE(90)           && Landscape
   M_orient = 0
ELSE
   HP_ROTATE(0)            && Portrait
   M_orient = 1
ENDIF
KEYBOARD( chr(3) )

FUNCTION SEL_PAT
SET CURSOR ON
FOR X = 1 TO 5
   @ 5+X,23 SAY SPACE(14)
NEXT
@ 8,25 SAY 'Pattern: '
@ 7,24 TO 9,35 DOUBLE
@ 8,34 GET M_pat PICT '9'
READ
SET CURSOR OFF
KEYBOARD( chr(3) )

FUNCTION SEL_ROTATE
SET CURSOR ON
FOR X = 1 TO 5
   @ 5+X,23 SAY SPACE(21)
NEXT
@ 8,25 SAY 'Font direction: '
@ 7,24 TO 9,42 DOUBLE
@ 8,41 GET M_dir PICT '9'
READ
SET CURSOR OFF
KEYBOARD( chr(3) )

FUNCTION SEL_PRINT
@ 3, 9 TO 22, 41 DOUBLE
M_printer = ACHOICE(4,10,21,40,PRINT_NAME)
IF M_printer > 0
   M_id = VAL( SUBSTR( PRINT_NAME[M_printer], 27, 4 ) )
   PRT_LOAD( M_id, "LPT1" )
   PRT_HEADER(PRINT_DEF)
ENDIF
KEYBOARD( chr(3) )

FUNCTION SEL_OFFSET
SET CURSOR ON
FOR X = 1 TO 6
   @ 5+X,23 SAY SPACE(17)
NEXT
@ 8,25 SAY 'X offset: '
@ 9,25 SAY 'Y offset: '
@ 7,24 TO 10,38 DOUBLE
@ 8,35 GET M_left PICT '9.9'
@ 9,35 GET M_top PICT '9.9'
READ
SET CURSOR OFF
KEYBOARD( chr(3) )

FUNCTION SEL_SIZE
SET CURSOR ON
FOR X = 1 TO 6
   @ 5+X,23 SAY SPACE(25)
NEXT
@ 8,25 SAY 'X size (inches): '
@ 9,25 SAY 'Y size (inches): '
@ 7,24 TO 10,46 DOUBLE
@ 8,42 GET M_xsize PICT '9.99'
@ 9,42 GET M_ysize PICT '9.99'
READ
SET CURSOR OFF
KEYBOARD( chr(3) )

FUNCTION SEL_OPTION
SET CURSOR ON
FOR X = 1 TO 6
   @ 5+X,23 SAY SPACE(18)
NEXT
@ 8,25 SAY 'Shading:     '
@ 9,25 SAY 'White/Black: '
@ 7,24 TO 10,39 DOUBLE
@ 8,38 GET M_shade PICT '9'
@ 9,38 GET M_WhiteBlack PICT '9'
READ
SET CURSOR OFF
KEYBOARD( chr(3) )

FUNCTION PJ_COLORS
CLEAR SCREEN
DECLARE COLOR_ARRY[16]
FOR i=0 to 15
   COLOR_ARRY[i+1] = COLR_TABLE(i)
NEXT
DO WHILE .T.
   @ 5,50
   FOR i=0 to 15
      @ i+5,50 SAY i PICT '99 -'
      @ i+5,55 SAY COLOR_ARRY[i+1] PICT '99'
   NEXT
   M_pal=0
   M_color=COLOR_ARRY[M_pal+1]
   SET CURSOR ON
   @ 17,10 SAY 'Palette #:   'GET M_pal PICT '99' RANGE 0,15
   @ 18,10 SAY 'Color #:     'GET M_color PICT '99' RANGE 0,63
   READ
   IF LASTKEY() = 27
      EXIT
   ENDIF
   SET CURSOR OFF
   IF UPDATED()
      COLOR_ARRY[M_pal+1] = M_color
   ENDIF
ENDDO
COLR_TABLE( COLOR_ARRY )
KEYBOARD( chr(3) )

FUNCTION PJ_SHADES
CLEAR SCREEN
DECLARE SHADE_ARRY[3]
DO WHILE .T.
*
   @ 5,50
   FOR i=0 to 15
      SHAD_TABLE( @i, SHADE_ARRY )
      @ i+5,50 SAY i PICT '99-'
      FOR j=1 to 3
         @ i+5,col()+2 SAY SHADE_ARRY[j] PICT '99'
      NEXT
   NEXT
*
   M_pal=0
   M_shade1=90
   M_shade2=88
   M_shade3=85
   SET CURSOR ON
   @ 17,10 SAY 'Palette #:   'GET M_pal PICT '99' RANGE 0,15
   @ 18,10 SAY 'Shade #1:    'GET M_shade1 PICT '99' RANGE 4,90
   @ 19,10 SAY 'Shade #2:    'GET M_shade2 PICT '99' RANGE 4,88
   @ 20,10 SAY 'Shade #3:    'GET M_shade3 PICT '99' RANGE 6,85
   READ
   SET CURSOR OFF
   IF LASTKEY() = 27
      EXIT
   ENDIF
   IF UPDATED()
      SHADE_ARRY[1] = M_shade1
      SHADE_ARRY[2] = M_shade2
      SHADE_ARRY[3] = M_shade3
      SHAD_TABLE( M_pal, SHADE_ARRY )
   ENDIF
ENDDO
KEYBOARD( chr(3) )

FUNCTION CENTER
PARAMETER M_row, M_string
*
A = LEN(M_string)
B = 80 - A
C = B/2
@ M_row,C SAY M_string


FUNCTION SEP_LINE
*
@ 17,49 SAY 'Â'
FOR X = 18 TO 23
   @ X,49 SAY '³'
NEXT
@ 24,49 SAY 'Ï'
*
@ 24,1 SAY 'Ï'
FOR X = 2 TO 48
   @ 24,X SAY 'Í'
NEXT
FOR X = 50 TO 77
   @ 24,X SAY 'Í'
NEXT
@ 24,78 SAY 'Ï'


FUNCTION OBJ_CHART
*
FOR X = 1 TO 7
   M_objarr[X] = ""
NEXT
IF '1'$M_OBJECTS
   M_objarr[1] = "PLOT"
ENDIF
IF '2'$M_OBJECTS
   M_objarr[1] = "PIE"
ENDIF
IF '3'$M_OBJECTS
   M_objarr[2] = "ARC"
ENDIF
IF '4'$M_OBJECTS
   M_objarr[3] = "CIRCLE"
ENDIF
IF '5'$M_OBJECTS
   M_objarr[4] = "LINE"
ENDIF
IF '6'$M_OBJECTS
   M_objarr[5] = "BOX"
ENDIF
IF '7'$M_OBJECTS
   M_objarr[6] = "TEXT"
ENDIF
IF '8'$M_OBJECTS
   M_objarr[7] = "FILL BOX"
ENDIF
*
FOR X = 3 TO 13
   @ X,3 SAY SPACE(19)
NEXT
@ 4,4 SAY 'Graphic Elements:'
@ 5,3 SAY CHR(195)
FOR X = 4 TO 21
   @ 5,X SAY CHR(196)
NEXT
@ 5,22 SAY CHR(180)
M_curr = 6
FOR X = 1 TO 7
   IF !EMPTY(M_objarr[X])
      @ M_curr,4 SAY M_objarr[X]
      M_curr = M_curr + 1
   ENDIF
NEXT
@ 3,3 TO M_curr,22

FUNCTION PRT_STATUS
IF RET_BIOS() = 1000
   @ 0,70 SAY STR(RET_PRTDN(),3,0)+'%'
ELSE
   SAY_FIXED(0,70,1,15,0,STR(RET_PRTDN(),3,0)+'%')
ENDIF
IF INKEY()=27
   PRT_ESCAPE(1)
ENDIF
