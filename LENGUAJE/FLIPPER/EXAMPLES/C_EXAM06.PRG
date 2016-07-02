*******************************************************************************
*  C_EXAM06.PRG                                                               *
*  Requirements: Microsoft Compatible Mouse                                   *
*  Description:                                                               *
*        This program demonstrates the use of the mouse to add either bit-    *
*        mapped text or stroke text.  It demonstrates the use of color and    *
*        justification.  It also lets you move the bit-mapped text around on  *
*        the screen and actually scale the stroke text.  This also shows how  *
*        to use a viewport to clip objects that go outside of it.  This is    *
*        yet another implementation of the menuing system.                    *
*  Chapter 14, Cad Functions                                                  *
*******************************************************************************
FLIP_INIT(1,1)                   && Initialize flipper
SET SCOREBOARD OFF
SET_SAYERR(1)
CLEAR SCREEN
SET CURSOR OFF
*
mem_font=FONT_OPEN("\FLIPPER\FONTS\RMN8_15.@")
stroke=FONT_OPEN("\FLIPPER\FONTS\SIM1_32.#")     && Open stroke font
*
M_font = mem_font
M_fg = 15
M_bg =-1
*
top_menu=0
drop_menu1=0
diag_box1=0
*
M_rows = 0
M_cols = 0
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
   MENU_WAKE( top_menu )
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
            REGN_ON()
      ENDCASE
*
      DO CASE
         CASE KP_MENU()=top_menu
            MENU_EDIT( top_menu, 0 )            && Turn off highlighting
            REGN_OFF()                          && Turn off mouse regions
            DO CASE
               CASE KP_ITEM_NO() = 1
                  MENU_WAKE( drop_menu1 )  && Wake drop down menu
               CASE KP_ITEM_NO() = 2
                  EXIT
            ENDCASE
      ENDCASE
*
      VIEW_SWAP(0,0)
      SAY_FIXED(M_rows-1, 0, 2, 14, 0, 'Event: '+STR(M_event,3,0);
         +', Menu: '+STR(KP_MENU(),2,0);
         +', Item: '+STR(KP_ITEM_NO(),2,0);
         +', Button: '+STR(KP_BUTTON(),2,0);
         +', Region: '+STR(MS_REGION(),2,0))
      VIEW_SWAP(vh,0)
*
      IF M_event = 32                  && Right button pressed
         DO CASE
            CASE KP_MENU() = drop_menu1 .and. KP_ITEM_NO() = 1
               diag_box1=MENU_OPEN( 2, 2, 0, M_font, 1, 3, 1)
               MENU_ITEM( diag_box1,2, 20, ASC("1"), 1, "Bit 8x8",1,0)
               MENU_ITEM( diag_box1,2, 29, ASC("2"), 1, "Bit 8x14",1,0)
               MENU_ITEM( diag_box1,2, 39, ASC("3"), 1, "Bit 8x16",1,0)
               MENU_ITEM( diag_box1,2, 49, ASC("4"), 1, "Roman",1,0)
               MENU_ITEM( diag_box1,2, 56, ASC("5"), 1, "Stroke",1,0)
               MENU_ITEM( diag_box1,4, 20, ""      , 1, "Change Font?",0,-2)
               MENU_ITEM( diag_box1,5, 20, ""      , 1, "Current: "+STR(M_font,2,0),0,-2)
               M_ans = MENU_ONLY( diag_box1 )
               IF M_ans > 0
                  M_font = M_ans
               ENDIF
               CLR_MENU( diag_box1 )
            CASE KP_MENU() = drop_menu1 .and. KP_ITEM_NO() = 2
               VIEW_SWAP(0,0)
               SAY_FIXED(M_rows-1, 0, 2, 14, 0, 'Mark Object')
               VIEW_SWAP(vh,0)
            CASE KP_MENU() = drop_menu1 .and. KP_ITEM_NO() = 3
               LINE_DIR( TXT_DIR( LINE_DIR() ) )
            CASE KP_MENU() = drop_menu1 .and. KP_ITEM_NO() = 4
               LINE_JUST( TXT_JUST( LINE_JUST() ) )
            CASE KP_MENU() = drop_menu1 .and. KP_ITEM_NO() = 5
               FONT_ALIGN( M_font, TXT_ALIGN( FONT_ALIGN(M_font) ) )
            CASE KP_MENU() = drop_menu1 .and. KP_ITEM_NO() = 6
               FONT_ROTAT( M_font, TXT_ROTATE( FONT_ROTAT(M_font) ) )
            CASE KP_MENU() = drop_menu1 .and. KP_ITEM_NO() = 7
               FONT_COLOR( M_font, @M_fg, @M_bg )
               M_fg = SEL_COLOR( M_fg )
               FONT_COLOR( M_font, M_fg, M_bg )
            CASE KP_MENU() = drop_menu1 .and. KP_ITEM_NO() = 8
               FONT_COLOR( M_font, @M_fg, @M_bg )
               M_bg=SEL_COLOR( M_bg )
               FONT_COLOR( M_font, M_fg, M_bg )
         ENDCASE
      ELSE
         DO CASE
            CASE M_event = 64
               obj=OBJ_HOTPNT()
               IF obj > 0
                  OBJ_EDIT(4,.f.,.f.,.f.,.f.,1)
                  REGN_SET(1,2)
                  OBJ_MOVPNT()
                  REGN_SET(1,8)
                  OBJ_EDIT(4,.f.,.f.,.f.,.f.,1)
               ENDIF
            CASE MS_REGION() = 1 .and. KP_BUTTON() = 2
               MS_CUROFF()
               MS_OBJECT(20, M_fg, M_bg, M_font, "")
               MS_CURON()
         ENDCASE
      ENDIF
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
top_menu=MENU_OPEN( 2, 2, 0, 0, 1, 1, 0 )
MENU_ITEM( top_menu, 0, 5, ASC("T"), 0, "Text", 1, 0 )
MENU_ITEM( top_menu, 0, 11, ASC("Q"), 0, "Quit", 1, 0 )
*
drop_menu1=MENU_OPEN( 2, 2, 0, 1, 1, 2, 1)
MENU_ITEM( drop_menu1, 2, 5, ASC("T"), 0, "Type      ", 1, 0 )
MENU_ITEM( drop_menu1, 3, 5, ASC("S"), 0, "Size      ", 1, 0 )
MENU_ITEM( drop_menu1, 4, 5, ASC("D"), 0, "Direction ", 1, 0 )
MENU_ITEM( drop_menu1, 5, 5, ASC("J"), 0, "Justify   ", 1, 0 )
MENU_ITEM( drop_menu1, 6, 5, ASC("A"), 0, "Align     ", 1, 0 )
MENU_ITEM( drop_menu1, 7, 5, ASC("R"), 0, "Rotation  ", 1, 0 )
MENU_ITEM( drop_menu1, 8, 5, ASC("C"), 0, "FG Color  ", 1, 0 )
MENU_ITEM( drop_menu1, 9, 5, ASC("B"), 0, "BG Color  ", 1, 0 )
*
vh=VIEW_OPEN(ATX(11,2), ATY(5,2), ATX(95,2), ATY(95,2) , 0, 0)
SET_WORLD(100, 0, 0, 0, 1, -1)   && setup square coordinate system
*
* Draw a line around viewport
*
x1 = VIEW_XMIN()-1
y1 = VIEW_YMIN()-1
x2 = x1+VIEW_WIDE()+1
y2 = y1+VIEW_HIGH()+1
VIEW_SWAP(0,0)
FBOX(x1, y1, x2, y2, 15)
VIEW_SWAP(vh,0)
*
MS_CURSOR(7)                     && Set cursor shape to type 1
REGN_INIT(1)
REGN_SET( 1, ATX(0,2), ATY(0,2), ATX(100,2), ATY(100,2), 0, 8)
HOT_VIEW( 1 )
*
MS_SETXY( 200, 200)              && Set cursor positioning
MS_CURON()                       && Turn mouse cursor on
RETURN vh

FUNCTION UN_SETUP
CLR_ALL()
MS_HALT()                        && End mouse interupt routine

FUNCTION SEL_COLOR
PARAMETER M_COLOR
diag_box1 = MENU_OPEN( 2, 2, 0, M_COLOR+1, 1, 2, 1)
FOR I=0 TO 15
   BUTTON_ADD( diag_box1, 100, I*20+100, 150, I*20+118, I, 0, 1, I )
NEXT
MENU_ITEM(diag_box1,4, 10,""      ,1,"Color?",0,-2)
M_ans = MENU_ONLY( diag_box1 )
CLR_MENU( diag_box1 )
RETURN( M_ans-1 )

FUNCTION TXT_JUST
PARAMETER M_JUST
diag_box1 = MENU_OPEN( 2, 2, 0, M_JUST+1, 1, 3, 1)
MENU_ITEM(diag_box1,6, 20,ASC("S"),1,"Start",1,0)
MENU_ITEM(diag_box1,6, 27,ASC("M"),1,"Middle",1,0)
MENU_ITEM(diag_box1,6, 35,ASC("E"),1,"End",1,0)
MENU_ITEM(diag_box1,4, 20,""      ,1,"Text Justification?",0,-2)
M_ans = MENU_ONLY( diag_box1 )
CLR_MENU( diag_box1 )
RETURN( M_ans-1 )

FUNCTION TXT_ALIGN
PARAMETER M_ALIGN
diag_box1 = MENU_OPEN( 2, 2, 0, M_ALIGN+1, 1, 3, 1)
MENU_ITEM(diag_box1,6, 20,ASC("T"),1,"Top",1,0)
MENU_ITEM(diag_box1,6, 25,ASC("C"),1,"Center",1,0)
MENU_ITEM(diag_box1,6, 33,ASC("B"),1,"Baseline",1,0)
MENU_ITEM(diag_box1,6, 43,ASC("D"),1,"Bottom",1,0)
MENU_ITEM(diag_box1,4, 20,""      ,1,"Text Registration?",0,-2)
M_ans = MENU_ONLY( diag_box1 )
CLR_MENU( diag_box1 )
RETURN( M_ans-1 )

FUNCTION TXT_ROTATE
PARAMETER M_ROTATE
IF M_font < stroke
   diag_box1 = MENU_OPEN( 2, 2, 0, M_ROTATE+1, 1, 3, 1)
   MENU_ITEM(diag_box1,6, 20,ASC("1"),1," 0 ",1,0)
   MENU_ITEM(diag_box1,6, 25,ASC("2"),1," 90 ",1,0)
   MENU_ITEM(diag_box1,6, 32,ASC("3"),1," 180 ",1,0)
   MENU_ITEM(diag_box1,6, 39,ASC("4"),1," 270 ",1,0)
   MENU_ITEM(diag_box1,4, 20,""      ,1,"Text Rotation?",0,-2)
   M_ans = MENU_ONLY( diag_box1 )
   CLR_MENU( diag_box1 )
ELSE
   M_ans = 1
ENDIF
RETURN( M_ans-1 )

FUNCTION TXT_DIR
PARAMETER M_DIR
IF M_font < stroke
   diag_box1 = MENU_OPEN( 2, 2, 0, M_DIR+1, 1, 3, 1)
   MENU_ITEM(diag_box1,6, 20,ASC("L"),1," Left ",1,0)
   MENU_ITEM(diag_box1,6, 28,ASC("R"),1," Right ",1,0)
   MENU_ITEM(diag_box1,6, 37,ASC("U"),1," Up ",1,0)
   MENU_ITEM(diag_box1,6, 43,ASC("D"),1," Down ",1,0)
   MENU_ITEM(diag_box1,4, 20,""      ,1,"Text Rotation?",0,-2)
   M_ans = MENU_ONLY( diag_box1 )
   CLR_MENU( diag_box1 )
ELSE
   M_ans = 1
ENDIF
RETURN( M_ans-1 )
