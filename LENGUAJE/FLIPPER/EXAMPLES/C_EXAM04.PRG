*******************************************************************************
*  C_EXAM04.PRG                                                               *
*  Requirements: Microsoft Compatible Mouse                                   *
*  Description:                                                               *
*        This program demonstrates the menuing system.  While the menus, don't*
*        really do anything, the program does display which menus were        *
*        selected.                                                            *
*  Chapter 13, Menus & Buttons                                                *
*******************************************************************************
FLIP_INIT(1,1)                   && Initialize flipper
SET_SAYERR(1)
CLEAR SCREEN
SET CURSOR OFF
*
mem_icon=FONT_OPEN("C:\FLIPPER\FONTS\PAINT1.@")            && Opening font from disk
mem_font=FONT_OPEN("C:\FLIPPER\FONTS\RMN8_15.@")
*
M_debug = .f.
icon_menu=0
top_menu=0
drop_menu1=0
drop_menu2=0
drop_menu3=0
diag_box1=0
*
M_rows = 0
M_cols = 0
fg_color = 15
bg_color = 0
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
   M_scrl1=SCRL_OPEN( 1, 100, 310, ATX(90,2), 8 )
   M_scrl2=SCRL_OPEN( 0, 100, 310, ATY(85,2), 4 )
   SCRL_WAKE( M_scrl1 )
   SCRL_WAKE( M_scrl2 )
   MENU_WAKE( icon_menu )
   MENU_WAKE( top_menu )
*
   M_stuff=""
   DO WHILE .T.
      M_event = KEY_PRESS()         && Get some keyboard or mouse event
*
*  Menuing sytem maintenance
*
      IF M_event = 2
         M_stuff = M_stuff + chr( KP_ASCII() )
         SAY_FIXED(M_rows-2,0,mem_font,fg_color,bg_color,M_stuff)
      ENDIF
*
      DO CASE
         CASE IS_MENU_ON( drop_menu1 ) = 1
            MENU_EDIT( top_menu, 1 )
            MENU_SLEEP( drop_menu1 )
         CASE IS_MENU_ON( drop_menu2 ) = 1
            MENU_EDIT( top_menu, 1 )
            MENU_SLEEP( drop_menu2 )
         CASE IS_MENU_ON( drop_menu3 ) = 1
            MENU_EDIT( top_menu, 1 )
            MENU_SLEEP( drop_menu3 )
      ENDCASE
*
      DO CASE
         CASE KP_MENU() = icon_menu
         CASE KP_MENU()=top_menu
            MENU_EDIT( top_menu, 0 )            && Turn off highlighting
            DO CASE
               CASE KP_ITEM_NO() = 1
                  MENU_WAKE( drop_menu1 )  && Wake drop down menu
               CASE KP_ITEM_NO() = 2
                  MENU_ONLY( drop_menu2 )  && Wake drop down menu
                  MENU_EDIT( top_menu, 1 )
               CASE KP_ITEM_NO() = 3
                  MENU_ONLY( drop_menu3 )  && Wake drop down menu
                  MENU_EDIT( top_menu, 1 )
               CASE KP_ITEM_NO() = 4
                  M_ans = MENU_ONLY( diag_box1 )
                  IF M_ans = 1
                     EXIT
                  ENDIF
                  MENU_EDIT( top_menu, 1 )
            ENDCASE
         OTHERWISE
            M_item = SCRL_HOT(M_scrl1)
            IF M_item > 0
               MENU_EDIT( icon_menu, .f., .f., M_item )
            ENDIF
            M_item = SCRL_HOT(M_scrl2)
            IF M_item > 0
               MENU_EDIT( top_menu, .f., .f., M_item )
            ENDIF
      ENDCASE
*
      IF M_debug
         VIEW_SWAP(0,0)
         MS_CUROFF()
         SAY_FIXED(M_rows-2,0,mem_font,fg_color,bg_color,'Event: '+STR(M_event,3,0);
               +', Menu: '+STR(KP_MENU(),2,0);
               +', Item: '+STR(KP_ITEM_NO(),2,0);
               +', Button: '+STR(KP_BUTTON(),2,0);
               +', Region: '+STR(MS_REGION(),2,0) )
         MS_CURON()
         VIEW_SWAP(vh,0)
      ENDIF
*
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
SAY_FIXED( @M_rows, @M_cols, mem_font)  && Return # of rows and columns
*
INIT_VIDEO(1, SPACE(20000))
*
MENU_COLOR( 0, 7, 15, 8, 0, 0, 9, 2, 1, 3, 1, 1, 8, 6, 15, 0, 12, 14 )
*
*
icon_menu=MENU_OPEN( mem_icon, 6, 0, 1, 0, 0, 0)
MENU_ITEM(icon_menu,4,0,61,1,chr(11),1,0)  && F3 - Circle
MENU_ITEM(icon_menu,4,1,62,1,chr(12),1,0)  && F4 - Arc of circle
MENU_ITEM(icon_menu,5,0,63,1,chr(13),1,0)  && F5 - Oval
MENU_ITEM(icon_menu,5,1,64,1,chr(30),1,0)  && F6 - Arc of oval
MENU_ITEM(icon_menu,6,0,65,1,chr(14),1,0)  && F7 - Box
MENU_ITEM(icon_menu,6,1,66,1,chr(15),1,0)  && F8 - Polyline
MENU_ITEM(icon_menu,7,0,67,1,chr(16),1,0)  && F9 - Stroke text
MENU_ITEM(icon_menu,7,1,68,1,chr(16),1,0)  && F10- Bit mapped text
*
top_menu=MENU_OPEN( mem_font, 2, 0, 1, 1, 1, 0 )
MENU_ITEM(top_menu,0,1, ASC("F"),0," ^First  ",1,0)
MENU_ITEM(top_menu,0,9, ASC("C"),0," ^Colors ",1,0)
MENU_ITEM(top_menu,0,17,ASC("M"),0,"   ^Map  ",1,0)
MENU_ITEM(top_menu,0,25,ASC("Q"),0,"  ^Quit  ",1,0)
*
drop_menu1=MENU_OPEN( mem_font, 6, 0, 1, 1, 4, 1)
MENU_ITEM(drop_menu1,2,0,ASC("1"),0," ^1st ",1,0)
MENU_ITEM(drop_menu1,3,0,ASC("2"),0," ^2nd ",1,0)
MENU_ITEM(drop_menu1,4,0,ASC("3"),0," ^3rd ",1,0)
MENU_ITEM(drop_menu1,5,0,ASC("4"),0," ^4th ",1,0)
*
drop_menu2 = MENU_OPEN( mem_font, 2, 0, 1, 1, 4, 1)
FOR I=0 TO 15
   BUTTON_ADD( drop_menu2, 100, I*20+60, 150, I*20+72, I, 0, 1, I )
NEXT
*
drop_menu3 = MENU_OPEN( mem_font, 0, 0, 0, 2, 0, 0)
BUTTON_ADD( drop_menu3, 100, 100, 110, 110, '1', 0, 1, 1 )
BUTTON_ADD( drop_menu3, 200, 100, 210, 110, '2', 0, 1, 1 )
BUTTON_ADD( drop_menu3, 150, 150, 160, 160, '3', 0, 1, 1 )
BUTTON_ADD( drop_menu3, 300, 300, 310, 310, '4', 0, 1, 1 )
BUTTON_ADD( drop_menu3, 400, 400, 420, 420, '5', 0, 1, 1,"|(395,410) JE AC KF15 KB-1|HELLO" )
*
diag_box1=MENU_OPEN( mem_font, 2, 0, 2, 2, 3, 1)
MENU_ITEM(diag_box1,6,17,ASC("Y"),0,"^Yes"  ,1,0)
MENU_ITEM(diag_box1,6,22,ASC("N"),0,"^No"   ,1,0)
MENU_ITEM(diag_box1,4,17,""      ,1,"Quit",0,-2)

MS_CURSOR(1)                     && Set cursor shape to type 1
MS_SETXY( 200, 200)              && Set cursor positioning
MS_CURON()                       && Turn mouse cursor on


FUNCTION UN_SETUP
PARAMETER vw_handle
CLR_ALL()
MS_HALT()                        && End mouse interupt routine

*
* This function is called each time a new button is highlighted
*
FUNCTION BUTTONCALL
MS_CUROFF()
SAY_FIXED(M_rows-1,0,mem_font,fg_color,bg_color,'Menu: '+STR(KP_MENU(),2,0);
   +', Item: '+STR(KP_ITEM_NO(),2,0) )
MS_CURON()

