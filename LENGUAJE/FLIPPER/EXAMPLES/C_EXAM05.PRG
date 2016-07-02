*******************************************************************************
*  C_EXAM5A.PRG                                                               *
*  Requirements: Microsoft Compatible Mouse                                   *
*  Description:                                                               *
*     This program demonstrates the use of adding objects with OBJ_ADD.       *
*  Chapter 14, Cad Functions                                                  *
*******************************************************************************
FLIP_INIT(1,1)                   && Initialize flipper
SET SCOREBOARD OFF
SET_SAYERR(1)
CLEAR SCREEN
SET CURSOR OFF
*
mem_icon=FONT_OPEN("\FLIPPER\FONTS\PAINT1.@")
stroke=FONT_OPEN("\FLIPPER\FONTS\SIM1_32.#")     && Open stroke font
*
icon_menu=0
top_menu=0
drop_menu1=0
drop_menu2=0
M_debug = .t.
*
M_rows = 0
M_cols = 0
M_pattern = 0
M_color = 15
*
M_display = RET_DISPLY()
M_mode = RET_CARD()
*
DO WHILE .T.
   @ 20,0 SAY 'Display: 'GET M_display PICT '9'
   @ 21,0 SAY 'Mode:    'GET M_mode PICT '99'
   READ
*
   IF LASTKEY()=27
      EXIT
   ENDIF
*
   SET_DISPLY(M_display)
   GRAPHMODE(M_mode)
*
   FSCREEN()                        && To graphics mode
*
   vh=SETUP_MAP()                   && Setup program
*
   MENU_WAKE( icon_menu )
   MENU_WAKE( top_menu )
   DECLARE obj_array[100]
*
   DO WHILE .T.
      M_event = KEY_PRESS()         && Get some keyboard or mouse event
*
*  Menuing sytem maintenance
*
      DO CASE
         CASE IS_MENU_ON( drop_menu1 ) = 1
            MENU_EDIT( top_menu, 1 )
            MENU_SLEEP( drop_menu1 )
         CASE IS_MENU_ON( drop_menu2 ) = 1
            MENU_EDIT( top_menu, 1 )
            MENU_SLEEP( drop_menu2 )
      ENDCASE
*
      DO CASE
         CASE KP_MENU() = icon_menu
         CASE KP_MENU() = top_menu
            MENU_EDIT( top_menu, 0 )            && Turn off highlighting
            DO CASE
               CASE KP_ITEM_NO() = 1
                  M_pattern = MENU_ONLY( drop_menu1 )-1  && Wake drop down menu
                  MENU_EDIT( top_menu, 1 )
               CASE KP_ITEM_NO() = 2
                  M_color = MENU_ONLY( drop_menu2 )-1  && Wake drop down menu
                  MENU_EDIT( top_menu, 1 )
               CASE KP_ITEM_NO() = 3
                  EXIT
            ENDCASE
         CASE MS_REGION() == 1 .and. KP_BUTTON() == 1
            DO CASE
               CASE BUTTON_CUR( icon_menu ) = 1       && Sub menu button 1 active?
                  MS_OBJECT(10, M_color, M_pattern, 0, "Circle")
               CASE BUTTON_CUR( icon_menu ) = 2
                  MS_OBJECT(12, M_color, M_pattern, 0, "Arc of circle")
               CASE BUTTON_CUR( icon_menu ) = 3
                  MS_OBJECT(11, M_color, M_pattern, 0, "Oval")
               CASE BUTTON_CUR( icon_menu ) = 4
                  MS_OBJECT(13, M_color, M_pattern, 0, "Arc of oval")
               CASE BUTTON_CUR( icon_menu ) = 5
                  MS_OBJECT(1, M_color, M_pattern, 0, "Box type")
               CASE BUTTON_CUR( icon_menu ) = 6
                  MS_OBJECT(4, M_color, 0, 0, "Polyline")
               CASE BUTTON_CUR( icon_menu ) = 7
                  MS_OBJECT(20, M_color, 0, stroke, "Text")
               CASE BUTTON_CUR( icon_menu ) = 8
                  MS_OBJECT(3, M_color, M_pattern, 0, "Line")
               CASE BUTTON_CUR( icon_menu ) = 9
                  MS_OBJECT(2, M_color, M_pattern, 0, "Polygon")
            ENDCASE
      ENDCASE
   ENDDO
*
   UN_SETUP(vh)                           && Restore back to pre-setup
   TEXTMODE()
ENDDO

****************************************************************
*
*  Setup program to handle mouse and display cursor position
*
****************************************************************

FUNCTION SETUP_MAP

M_buttons=MS_RESET()             && Setup mouse driver
IF M_buttons=0                   && Check button number not zero
   @ 22,0 SAY 'No mouse driver'
   inkey(0)
   quit
ENDIF
*
SAY_FIXED( @M_rows, @M_cols, 2)  && Return # of rows and columns
*
INIT_VIDEO(1, 0, 0)
*
MENU_COLOR( 0, 7, 15, 8, 0, 0, 9, 2, 1, 3, 1, 1, 8, 6, 15, 0, 12, 14 )
*
icon_menu = MENU_OPEN( mem_icon, 6, 0, 1, 0, 0, 0)
MENU_ITEM(icon_menu,4,0,61,1,chr(11),1,0)  && F3 - Circle
MENU_ITEM(icon_menu,4,1,62,1,chr(12),1,0)  && F4 - Arc of circle
MENU_ITEM(icon_menu,5,0,63,1,chr(13),1,0)  && F5 - Oval
MENU_ITEM(icon_menu,5,1,64,1,chr(30),1,0)  && F6 - Arc of oval
MENU_ITEM(icon_menu,6,0,65,1,chr(14),1,0)  && F7 - Box
MENU_ITEM(icon_menu,6,1,66,1,chr(15),1,0)  && F8 - Polyline
MENU_ITEM(icon_menu,7,0,67,1,chr(16),1,0)  && F9 - text
MENU_ITEM(icon_menu,7,1,68,1,chr(25),1,0)  && F10 - Line
MENU_ITEM(icon_menu,8,0,69,1,chr(15),1,0)  && F9 - Polygon
*
top_menu = MENU_OPEN( 2, 2, 0, 0, 1, 1, 0 )
MENU_ITEM(top_menu,0, 0, ASC("F"), 0, "^Fill style", 1, 0)
MENU_ITEM(top_menu,0,11, ASC("C"), 0, "^Colors", 1, 0)
MENU_ITEM(top_menu,0,18, ASC("Q"), 0, "^Quit", 1, 0)
*
drop_menu1 = MENU_OPEN( 2, 2, 0, M_pattern, 1, 4, 1)
FOR I=0 TO 10
   BUTTON_ADD( drop_menu1, 40, I*20+60, 90, I*20+72, I, 0, 1, 13, .f., I )
NEXT

drop_menu2 = MENU_OPEN( 2, 2, 0, M_color, 1, 4, 1)
FOR I=0 TO 15
   BUTTON_ADD( drop_menu2, 100, I*20+60, 150, I*20+72, I, 0, 1, I )
NEXT

vh=VIEW_OPEN(ATX(12,2), ATY(5,2), ATX(95,2), ATY(95,2) , 0, 0)
SET_WORLD(400, 0, 0, 0, 1, -1)   && setup square coordinate system
*
* Draw a line around viewport
*
x1 = VIEW_XMIN()-1
y1 = VIEW_YMIN()-1
x2 = x1+VIEW_WIDE()+1
y2 = y1+VIEW_HIGH()+1
VIEW_SWAP(0,0)
FBOX(x1, y1, x2, y2, 1, 2)
VIEW_SWAP(vh,0)
*
* Placement and attributes for current position of mouse
*
POS_SIZE()                       && No parameters - automatic sizing
POS_ATTR(0,45,2)                 && x, y, font
POS_COLOR(1,9)                   && fg, bg
POS_REFER()                      && Cursor reference coordinates
*                                   No parameters set reference to origin
POS_ONOFF(1,1,1)                 && Set on_or_off, position region, snap region
*
* Set up a grid at 40 horizontal and 40 vertical
*
GRID_SET(1,15,20,20)       && GRID_SET(On_or_Off, color, horz, vert)
*
MS_CURSOR(7)                     && Set cursor shape to type 1
REGN_INIT(1)
REGN_SET( 1, ATX(0,2), ATY(0,2), ATX(100,2), ATY(100,2), 0, 8)
HOT_VIEW( 1 )
*
MS_SETXY( 200, 200)              && Set cursor positioning
MS_CURON()                       && Turn mouse cursor on
OBJS_MAP()


FUNCTION UN_SETUP
CLR_ALL()
MS_HALT()                        && End mouse interupt routine

