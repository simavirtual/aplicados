*Demonstrates the Flipper CAD system.
FLIP_INIT(1000,200)              && Initialize flipper
SET SCOREBOARD OFF
SET_SAYERR(1)
CLEAR SCREEN
SET CURSOR OFF
*
mem_font=FONT_OPEN("C:\FLIPPER\FONTS\RMN8_15.@")
stroke=FONT_OPEN("C:\FLIPPER\FONTS\SIM1_32.#")     && Open stroke font
mem_icon=FONT_OPEN("C:\FLIPPER\FONTS\PAINT1.@")
*
M_font=stroke
M_fg = -1
M_bg = -1
*
M_snaptype = 0
M_debug = .f.
*
M_top = 0
M_left= 0
fg_color=11
bg_color=1
cl_color=7
M_xscale=400
M_xorigin=0
M_yorigin=0
M_filename=space(8)
*
M_printer = 65                         && HP laserJet  300 dpi
M_orient  = 0                          && Landscape
M_HorzInch= 4.0
M_VertInch= 2.5
PRT_LIST("C:\FLIPPER\LIBRARY\PRX_TBL.BIN")
PRT_LOAD( M_printer, "LPT1" )          && Parallel Printing
DECLARE PRINT_DEF[17]                  && Setup array
PRT_HEADER(PRINT_DEF)                  && Grab information about driver
*
main_menu=0
sub_menu1=0
sub_menu2=0
top_menu=0
drop_menu1=0
drop_menu2=0
drop_menu3=0
drop_menu4=0
diag_box1=0
M_scrl1=0
M_scrl2=0
*
M_display = RET_DISPLY()
M_mode = RET_CARD()
*
DO WHILE .T.
   @ 20,0 SAY 'Display:          'GET M_display PICT '9'
   @ 21,0 SAY 'Mode:             'GET M_mode PICT '99'
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
   M_rows=0                         && Hold number of screen rows
   M_columns=0                      && Holds number of screen columns
*
   vh=SETUP_MAP()                   && Setup program
*
   MENU_WAKE( main_menu )
   MENU_WAKE( sub_menu1 )
   MENU_WAKE( top_menu )
   SCRL_WAKE( M_scrl1 )
   SCRL_WAKE( M_scrl2 )
*
   DO WHILE .T.
      M_event = KEY_PRESS()         && Get some keyboard or mouse event
*
*  Menuing sytem maintenance
*
      DO CASE
         CASE IS_MENU_ON( drop_menu1 ) = 1
            MENU_EDIT( top_menu, 2 )
            MENU_SLEEP( drop_menu1 )
            REGN_ON()
         CASE IS_MENU_ON( drop_menu2 ) = 1
            MENU_EDIT( top_menu, 2 )
            MENU_SLEEP( drop_menu2 )
            REGN_ON()
         CASE IS_MENU_ON( drop_menu3 ) = 1
            MENU_EDIT( top_menu, 2 )
            MENU_SLEEP( drop_menu3 )
            REGN_ON()
         CASE IS_MENU_ON( drop_menu4 ) = 1
            MENU_EDIT( top_menu, 2 )
            MENU_SLEEP( drop_menu4 )
            REGN_ON()
      ENDCASE
*
      DO CASE
         CASE KP_MENU() = main_menu .and. KP_ITEM_NO() = 1
         CASE KP_MENU() = main_menu .and. KP_ITEM_NO() > 1
            DO CASE
               CASE IS_MENU_ON( sub_menu1 ) = 1
                  MENU_SLEEP( sub_menu1 )
               CASE IS_MENU_ON( sub_menu2 ) = 1
                  MENU_SLEEP( sub_menu2 )
            ENDCASE
            MENU_WAKE( KP_ITEM_NO() )
         CASE KP_MENU()=top_menu .and. KP_BUTTON()==1
            MENU_EDIT( top_menu, 0 )            && Turn off highlighting
            REGN_OFF()
            DO CASE
               CASE KP_ITEM_NO() = 1
                  MENU_WAKE( top_menu+KP_ITEM_NO() )  && Wake drop down menu
               CASE KP_ITEM_NO() = 2
                  MENU_WAKE( top_menu+KP_ITEM_NO() )  && Wake drop down menu
               CASE KP_ITEM_NO() = 3
                  MENU_WAKE( top_menu+KP_ITEM_NO() )  && Wake drop down menu
               CASE KP_ITEM_NO() = 4
                  MENU_WAKE( top_menu+KP_ITEM_NO() )  && Wake drop down menu
               CASE KP_ITEM_NO() = 5
                  IF YN_RESPONSE("Quit?")
                     EXIT
                  ENDIF
            ENDCASE
      ENDCASE
*
      IF M_debug
         VIEW_SWAP(0,0)
         MS_CUROFF()
         SAY_FIXED(M_rows-1,0,mem_font,fg_color,bg_color,'Event: '+STR(M_event,3,0);
               +', Menu: '+STR(KP_MENU(),2,0);
               +', Item: '+STR(KP_ITEM_NO(),2,0);
               +', Button: '+STR(KP_BUTTON(),2,0);
               +', Region: '+STR(MS_REGION(),2,0) )
         MS_CURON()
         VIEW_SWAP(vh,0)
      ENDIF
*
      IF MS_REGION() = 1                                 && In Drawing area?
         IF KP_BUTTON() = 1                              && Button 1 pressed?
            IF BUTTON_CUR(main_menu) = 2                 && Main menu 2 active?
               DO CASE
                  CASE BUTTON_CUR( sub_menu1 ) = 1       && Sub menu button 1 active?
                     MS_OBJECT(10, -1, 2, 0, "Circle")
                  CASE BUTTON_CUR( sub_menu1 ) = 2
                     MS_OBJECT(12, -1, 3, 0, "Arc of circle")
                  CASE BUTTON_CUR( sub_menu1 ) = 3
                     MS_OBJECT(11, -1, 4, 0, "Oval")
                  CASE BUTTON_CUR( sub_menu1 ) = 4
                     MS_OBJECT(13, -1, 5, 0, "Arc of oval")
                  CASE BUTTON_CUR( sub_menu1 ) = 5
                     MS_OBJECT(1, -1, 6, 0, "Box type")
                  CASE BUTTON_CUR( sub_menu1 ) = 6
                     MS_OBJECT(2, -1, 2, 0, "Polyline")
                  CASE BUTTON_CUR( sub_menu1 ) = 7
                     MS_OBJECT(20, M_fg, M_bg, M_font, "Text")
                  CASE BUTTON_CUR( sub_menu1 ) = 8
                     MS_OBJECT(3, -1, 0, 0, "Line")
                  CASE BUTTON_CUR( sub_menu1 ) = 9
                     ZOOM_IN()
               ENDCASE
            ENDIF
            IF BUTTON_CUR(main_menu) = 3
               DO CASE
*                          * Mark and Unmark an object *
                  CASE BUTTON_CUR( sub_menu2 ) = 1 .and. M_event = 64
                     IF HOT_MARKED() = 1
                        OBJ_EDIT(4, .f., .f. ,.f. ,.f., 0)   && turn mark off
                     ELSE
                        OBJ_EDIT(4, .f., .f. ,.f. ,.f., 1)   && turn mark off
                     ENDIF
                  CASE BUTTON_CUR( sub_menu2 ) = 2
                     M_result = MS_OBJECT(1,7,-1,1)
                     IF M_result = 1
                        MARK_WIND(2)         && mark objects totally inside window
                     ENDIF
                  CASE BUTTON_CUR( sub_menu2 ) = 3 .and. M_event = 64
                     obj=OBJ_HOTPNT()
                     IF obj > 0
                        REGN_SET(1,2)
                        OBJ_MOVPNT()
                        REGN_SET(1,8)
                     ENDIF
                  CASE BUTTON_CUR( sub_menu2 ) = 4 .and. (M_event = 64 .or. M_snaptype = 1)
                     REGN_SET(1,1)
                     IF M_snaptype = 1
                        MARK_SNAP()
                     ELSE
                        OBJ_MOVE()
                     ENDIF
                     REGN_SET(1,8)
                  CASE BUTTON_CUR( sub_menu2 ) = 6 .and. M_event = 64
                     m_x = KP_SCALE_X()+6
                     m_y = KP_SCALE_Y()+6
                     OBJ_COPY( HOT_LAYER(), HOT_NUMBER(), LAYER_CURR(), 0, m_x, m_y)
                  CASE BUTTON_CUR( sub_menu2 ) = 7
                     MOVE_ORIGIN()
                  CASE BUTTON_CUR( sub_menu2 ) = 8 .and. M_event = 64
                     OBJ_DELETE(4)              && 4 - delete hot object
                  CASE BUTTON_CUR( sub_menu2 ) = 9
                     ZOOM_IN()
               ENDCASE
            ENDIF
         ENDIF
      ELSE
         DO CASE                                && Not in drawing area
            CASE KP_MENU()=sub_menu1
               DO CASE
                  CASE KP_ITEM_NO() = 10
                     SET_WORLD(M_xscale,0,0,0,1,-1)
                     POS_SIZE()
                     CLS_SCREEN()
                     OBJS_MAP()
               ENDCASE
            CASE KP_MENU()=sub_menu2
               DO CASE
                  CASE KP_ITEM_NO() = 1 .and. KP_BUTTON() = 2
                     OBJ_EDIT( 0, .f., .f., .f., .f., 0 )
                     OBJS_MAP()        && auto map is off, so remap ourselves
                  CASE KP_ITEM_NO() = 4 .and. KP_BUTTON() = 2
                     IF M_snaptype = 0
                        BUTTON_EDT(KP_MENU(), .f., .f., chr(10))
                        M_snaptype=1
                     ELSE
                        BUTTON_EDT(KP_MENU(), .f., .f., chr(8))
                        M_snaptype=0
                     ENDIF
                  CASE KP_ITEM_NO() = 5
                     IF KP_BUTTON() = 2
                        MARK_BREAK()            && Break marked objects
                     ELSE
                        MARK_COMB()             && Combine marked objects
                     ENDIF
                                                && Reset origin to original
                  CASE KP_ITEM_NO() = 7 .and. KP_BUTTON() = 2
                     SET_WORLD(WLD_XSCALE(),0,M_xorigin,M_yorigin,1,-1)
                     CLS_SCREEN()
                     OBJS_MAP()
                                                && Reset world to full view
                  CASE KP_ITEM_NO() = 10
                     SET_WORLD(M_xscale,0,M_xorigin,M_yorigin,1,-1)
                     POS_SIZE()
                     CLS_SCREEN()
                     OBJS_MAP()
               ENDCASE
            CASE KP_MENU()=drop_menu1 .and. KP_BUTTON()=1
               DO CASE
                  CASE KP_ITEM_NO() = 1
                     IF CAD_SETUP(18) == 1
                        CAD_SETUP(18,0)                    && Orthogonal OFF
                        BUTTON_EDT(KP_MENU(), .f., .f., "Ortho Off")
                     ELSE
                        CAD_SETUP(18,1)                    && Orthogonal ON
                        BUTTON_EDT(KP_MENU(), .f., .f., "Ortho On ")
                     ENDIF
                  CASE KP_ITEM_NO() = 2 .or. KP_ITEM_NO() = 3  && Save/Restore
                     M_filename=FILE_NAME("Enter file name: ", M_filename)
                     IF !EMPTY(M_filename)
                        M_filename=TRIM(M_filename)+".CAD"
                        IF KP_ITEM_NO() = 3
                           OBJS_SAVE( M_filename )
                        ELSE
                           OBJS_READ( M_filename )
                        ENDIF
                     ENDIF
                  CASE KP_ITEM_NO() = 4
                     IF YN_RESPONSE("Delete all objects?")
                        OBJ_DELETE(0)              && 0 - delete all object
                     ENDIF
                  CASE KP_ITEM_NO() = 5
                     REGN_OFF()
                     diag_box1=MENU_OPEN( mem_font, 2, 0, 0, 1, 3, 1)
                     MENU_ITEM(diag_box1,7, 20,ASC("1"),1,"Layer 1",1,0)
                     MENU_ITEM(diag_box1,8, 20,ASC("2"),1,"Layer 2",1,0)
                     MENU_ITEM(diag_box1,9, 20,ASC("3"),1,"Layer 3",1,0)
                     MENU_ITEM(diag_box1,10,20,ASC("4"),1,"Layer 4",1,0)
                     MENU_ITEM(diag_box1,4, 20,""      ,1,"Change Layer?",0,-2)
                     MENU_ITEM(diag_box1,5, 20,""      ,1,"Current: "+STR(LAYER_CURR(),1,0),0,-2)
                     M_ans = MENU_ONLY( diag_box1 )
                     IF M_ans > 0
                        LAYER_CURR(M_ans)
                     ENDIF
                     MENU_EDIT( top_menu, 1 )
                     CLR_MENU( diag_box1 )
                     REGN_ON()
                  CASE KP_ITEM_NO() = 6            && Debuging stuff
                     IF M_debug
                        M_debug = .f.
                     ELSE
                        M_debug = .t.
                     ENDIF
               ENDCASE
            CASE KP_MENU()=drop_menu2
               DO CASE
                  CASE KP_ITEM_NO() = 1
                     INVENTORY()
                  CASE KP_ITEM_NO() = 6
                     IF YN_RESPONSE("Delete objects in layer "+STR(LAYER_CURR(),2,0)+"?")
                        OBJ_DELETE(2)          && 2 - delete current layer objects
                     ENDIF
               ENDCASE
            CASE KP_MENU()=drop_menu3
               DO CASE
                  CASE KP_ITEM_NO() = 1               && Font handle
                     REGN_OFF()
                     diag_box1=MENU_OPEN( mem_font, 2, 0, 0, 1, 3, 1)
                     MENU_ITEM(diag_box1,7, 20,ASC("1"),1,"Bit 8x8  ",1,0)
                     MENU_ITEM(diag_box1,8, 20,ASC("2"),1,"Bit 8x14 ",1,0)
                     MENU_ITEM(diag_box1,9, 20,ASC("3"),1,"Bit 8x16 ",1,0)
                     MENU_ITEM(diag_box1,10, 20,ASC("4"),1,"Bit Roman",1,0)
                     MENU_ITEM(diag_box1,11,20,ASC("5"),1,"Stroke   ",1,0)
                     MENU_ITEM(diag_box1,4, 20,""      ,1,"Change Font?",0,-2)
                     MENU_ITEM(diag_box1,5, 20,""      ,1,"Current: "+STR(M_font,2,0),0,-2)
                     M_ans = MENU_ONLY( diag_box1 )
                     IF M_ans > 0
                        M_font = M_ans
                     ENDIF
                     CLR_MENU( diag_box1 )
                     REGN_ON()
                  CASE KP_ITEM_NO() = 2               && Text Size
                  CASE KP_ITEM_NO() = 3               && Text direction
                     REGN_OFF()
                     diag_box1=MENU_OPEN( mem_font, 2, 0, 0, 1, 3, 1)
                     MENU_ITEM(diag_box1,6, 20,ASC("1"),1,"Right to left",1,0)
                     MENU_ITEM(diag_box1,7, 20,ASC("2"),1,"Left to right",1,0)
                     MENU_ITEM(diag_box1,8, 20,ASC("3"),1,"Bottom to top",1,0)
                     MENU_ITEM(diag_box1,9, 20,ASC("4"),1,"Top to Bottom",1,0)
                     MENU_ITEM(diag_box1,4, 20,""      ,1,"Text Direction?",0,-2)
                     M_ans = MENU_ONLY( diag_box1 )
                     IF M_ans > 0 .and. FRET_TYPE(M_font) == 0
                        LINE_DIR( M_ans-1 )
                     ENDIF
                     CLR_MENU( diag_box1 )
                     REGN_ON()
                  CASE KP_ITEM_NO() = 4               && Text Justification
                  CASE KP_ITEM_NO() = 5               && Text Alignment
                  CASE KP_ITEM_NO() = 6               && Text Rotation
                     REGN_OFF()
                     diag_box1=MENU_OPEN( mem_font, 2, 0, 0, 1, 3, 1)
                     MENU_ITEM(diag_box1,6, 20,ASC("1"),1,"  0",1,0)
                     MENU_ITEM(diag_box1,7, 20,ASC("2"),1," 90",1,0)
                     MENU_ITEM(diag_box1,8, 20,ASC("3"),1,"180",1,0)
                     MENU_ITEM(diag_box1,9, 20,ASC("4"),1,"270",1,0)
                     MENU_ITEM(diag_box1,4, 20,""      ,1,"Text Rotation?",0,-2)
                     M_ans = MENU_ONLY( diag_box1 )
                     IF M_ans > 0 .and. FRET_TYPE(M_font) == 0
                        FONT_ROTAT( M_font, M_ans-1 )
                     ENDIF
                     CLR_MENU( diag_box1 )
                     REGN_ON()
                  CASE KP_ITEM_NO() = 7               && Text foreground color
                     FONT_COLOR( M_font, @M_fg, @M_bg )
                     M_fg=SEL_COLOR( M_fg )
                     FONT_COLOR( M_font, M_fg, M_bg )
                  CASE KP_ITEM_NO() = 8               && Text background color
                     FONT_COLOR( M_font, @M_fg, @M_bg )
                     M_bg=SEL_COLOR( M_bg )
                     FONT_COLOR( M_font, M_fg, M_bg )
               ENDCASE
            CASE KP_MENU()=drop_menu4
               SET COLOR TO B/W,W+/B
               DO CASE
                  CASE KP_ITEM_NO() = 1  && Print
                     GRID_SET(0)
                     PRT_OPTS(M_orient,0,0,0,0)
                     NUM_SWATHS = MPRT_OPEN(M_HorzInch*100, M_VertInch*100)
                     FOR I=1 TO NUM_SWATHS
                        MPRT_SWATH(I)
                        OBJS_MAP()
                        MPRT_SCRN( 100, 100, M_top*100, M_left*100)      && No position prints whole screen
                     NEXT
                     ?? CHR(7)
                     MPRT_CLOSE()
                     GRID_SET(1,fg_color,40,40)
                  CASE KP_ITEM_NO() = 2  && Set Orientation
                     VIEW_SWAP(0,0)
                     diag_box1=MENU_OPEN( mem_font, 0, 0, 0, 1, 3, 1)
                     MENU_ITEM(diag_box1,6,20,ASC("L"),0,"Landscape"  ,1,0)
                     MENU_ITEM(diag_box1,6,32,ASC("P"),0,"Portrait"   ,1,0)
                     MENU_ITEM(diag_box1,4,20,""      ,1,"Which Orientation?",0,-2)
                     M_ans=MENU_ONLY( diag_box1 )
                     IF M_ans = 1
                        M_orient = 0
                     ELSEIF M_ans = 2
                        M_orient = 1
                     ENDIF
                     MENU_EDIT( top_menu, 1 )
                     CLR_MENU( diag_box1 )
                     VIEW_SWAP(vh,0)
                  CASE KP_ITEM_NO() = 3  && Set Size
                     VIEW_SWAP(0,0)
                     SET CURSOR ON
                     @ M_rows-1,10 SAY 'Inches width: 'GET M_HorzInch PICT '99.9'
                     READ
                     M_VertInch = M_HorzInch * ( WLD_YSCALE() / WLD_XSCALE() )
                     @ M_rows-1,col()+3 SAY 'Inches high: 'GET M_VertInch PICT '99.9'
                     READ
                     SET CURSOR OFF
                     @ M_rows-1,10 SAY SPACE(60)
                     VIEW_SWAP(vh,0)
                  CASE KP_ITEM_NO() = 4  && Set Margins
                     VIEW_SWAP(0,0)
                     SET CURSOR ON
                     @ M_rows-1,10 SAY 'Inches top: 'GET M_top PICT '99.9'
                     @ M_rows-1,col()+3 SAY 'Inches left: 'GET M_left PICT '99.9'
                     READ
                     SET CURSOR OFF
                     @ M_rows-1,10 SAY SPACE(60)
                     VIEW_SWAP(vh,0)
                  CASE KP_ITEM_NO() = 5  && Set Printer
                     VIEW_SWAP(0,0)
                     SET CURSOR ON
                     M_ans=M_printer
                     @ M_rows-1,10 SAY 'Printer number: 'GET M_ans PICT '99'
                     READ
                     IF UPDATED()
                        M_printer=M_ans
                        PRT_LOAD(M_printer,"LPT1")
                        PRT_HEADER(PRINT_DEF)
                        M_HorzDPI = PRINT_DEF[3]
                        M_VertDPI = PRINT_DEF[4]
                     ENDIF
                     SET CURSOR OFF
                     @ M_rows-1,10 SAY SPACE(60)
                     VIEW_SWAP(vh,0)
                  CASE KP_ITEM_NO() = 6  && Eject
                     EJECT
               ENDCASE
            OTHERWISE
               M_item=SCRL_HOT( M_scrl1 )
               IF M_item > 0
                  x_origin = (M_item - 1) * 100
                  SET_WORLD(WLD_XSCALE(),0,x_origin,WLD_YORG(),1,-1)   && setup square coordinate system
                  CLS_SCREEN()
                  OBJS_MAP()
               ENDIF
               M_item=SCRL_HOT( M_scrl2 )
               IF M_item > 0
                  y_origin = (M_item - 1) * 100
                  SET_WORLD(WLD_XSCALE(),0,WLD_XORG(),y_origin,1,-1)   && setup square coordinate system
                  CLS_SCREEN()
                  OBJS_MAP()
               ENDIF
         ENDCASE
      ENDIF
      LOOP
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
*
*  Setup Clipper Text and MONO colors
*
M_font=1
IF RET_BIOS() >12               && If EGA or higher
   M_font=2
ENDIF
IF RET_BIOS()=6 .or. RET_BIOS()=15 .or. RET_BIOS()=17 .or. RET_BIOS()=9
   fg_color=1
   bg_color=0
   cl_color=0
   M_bw=1
   SET COLOR TO B/N,N/B                && If Black & White
ELSE
   fg_color=11
   bg_color=1
   cl_color=1
   M_bw=0
   SET COLOR TO B/W,W+/B               && IF EGA/VGA color system
ENDIF
SAY_FIXED( @M_rows, @M_columns, mem_font)  && Return # of rows and columns
*
CLS_SCREEN(cl_color)                   && Clear graphics screen to white
*
INIT_VIDEO(1, 0 )
LAYER_OPEN(11)                         && open first layer with default_color 11
LAYER_OPEN(12)
LAYER_OPEN(13)
LAYER_OPEN(14)
LAYER_CURR(1)
*
MENU_COLOR( 0, 7, 15, 8, 0, 0, 9, 2, 1, 3, 1, 1, 8, 6, 15, 0, 12, 14 )
main_menu=MENU_OPEN( mem_icon, 6, 0, 2, 0, 0, 0)
MENU_ITEM(main_menu,1,0,59,0,chr(1), 1,0)  && F1-Help
MENU_ITEM(main_menu,2,0,60,1,chr(22),1,0)  && F2-Draw
MENU_ITEM(main_menu,2,1,61,1,chr(21),1,0)  && F3-Edit
*
sub_menu1=MENU_OPEN( mem_icon, 6, 0, 1, 0, 0, 0)
MENU_ITEM(sub_menu1,4,0,62,1,chr(11),1,0)  && F3 - Circle
MENU_ITEM(sub_menu1,4,1,63,1,chr(12),1,0)  && F4 - Arc of circle
MENU_ITEM(sub_menu1,5,0,64,1,chr(13),1,0)  && F5 - Oval
MENU_ITEM(sub_menu1,5,1,65,1,chr(30),1,0)  && F6 - Arc of oval
MENU_ITEM(sub_menu1,6,0,66,1,chr(14),1,0)  && F7 - Box
MENU_ITEM(sub_menu1,6,1,67,1,chr(15),1,0)  && F8 - Polyline
MENU_ITEM(sub_menu1,7,0,68,1,chr(16),1,0)  && F9 - Stroke text
MENU_ITEM(sub_menu1,7,1,69,1,chr(25),1,0)  && F10- Line
MENU_ITEM(sub_menu1,8,0,70,1,chr(4) ,1,0)  &&    - Zoom
MENU_ITEM(sub_menu1,8,1,71,1,chr(3) ,0,0)  &&    - Full
*
sub_menu2=MENU_OPEN( mem_icon, 6, 0, 1, 0, 0, 0)
MENU_ITEM(sub_menu2,4,0,62,1,chr(23),1,0)     && F3 - Mark
MENU_ITEM(sub_menu2,4,1,63,1,chr(24),1,0)     && F4 - Window
MENU_ITEM(sub_menu2,5,0,64,1,chr(7) ,1,0)     && F5 - Move point
MENU_ITEM(sub_menu2,5,1,65,1,chr(8) ,1,0)     && F6 - Move object
MENU_ITEM(sub_menu2,6,0,66,1,chr(5) ,0,0)     && F7 - Combine/breakup
MENU_ITEM(sub_menu2,6,1,67,1,chr(10),1,0)     && F8 - Copy objects
MENU_ITEM(sub_menu2,7,0,68,1,chr(27),1,0)     && F9 - Origin
MENU_ITEM(sub_menu2,7,1,69,1,chr(6) ,1,0)     && F10- Del
MENU_ITEM(sub_menu2,8,0,70,1,chr(4) ,1,0)     && F9 - Zoom
MENU_ITEM(sub_menu2,8,1,71,1,chr(3) ,0,0)     && F10- Full
*
top_menu=MENU_OPEN( mem_font, 6, 0, 0, 2, 1, 0 )
MENU_ITEM(top_menu,0,1, ASC("D"),0,"Drawing",1,0)  && -Drawing
MENU_ITEM(top_menu,0,7, ASC("L"),0," Layer ",1,0)  && -Layer
MENU_ITEM(top_menu,0,13,ASC("T"),0," Text  ",1,0) && -Text
MENU_ITEM(top_menu,0,19,ASC("P"),0," Print ",1,0)  && -Print
MENU_ITEM(top_menu,0,25,ASC("Q"),0," Quit  ",1,0) && -Quit
*
drop_menu1=MENU_OPEN( mem_font, 6, 0, 0, 1, 2, 1)
MENU_ITEM(drop_menu1,2,1,ASC("O"),0,"Ortho Off",1,0)
MENU_ITEM(drop_menu1,3,1,ASC("R"),0,"Retrieve ",1,0)
MENU_ITEM(drop_menu1,4,1,ASC("S"),0,"Save     ",1,0)
MENU_ITEM(drop_menu1,5,1,ASC("E"),0,"Erase    ",1,0)
MENU_ITEM(drop_menu1,6,1,ASC("L"),0,"Layer    ",1,0)
MENU_ITEM(drop_menu1,7,1,ASC("D"),0,"Debug    ",1,0)   && Debuging stuff
*
drop_menu2=MENU_OPEN( mem_font, 6, 0, 0, 1, 2, 1)
MENU_ITEM(drop_menu2,2,9,ASC("L"),0,"List    ",1,0)
MENU_ITEM(drop_menu2,3,9,ASC("D"),0,"Display ",1,0)
MENU_ITEM(drop_menu2,4,9,ASC("C"),0,"Color   ",1,0)
MENU_ITEM(drop_menu2,5,9,ASC("R"),0,"Retrieve",1,0)
MENU_ITEM(drop_menu2,6,9,ASC("S"),0,"Save    ",1,0)
MENU_ITEM(drop_menu2,7,9,ASC("E"),0,"Erase   ",1,0)
*
drop_menu3=MENU_OPEN( mem_font, 6, 0, 0, 1, 2, 1)
MENU_ITEM(drop_menu3,2,15,ASC("T"),0,"Type     ",1,0)
MENU_ITEM(drop_menu3,3,15,ASC("S"),0,"Size     ",1,0)
MENU_ITEM(drop_menu3,4,15,ASC("D"),0,"Direction",1,0)
MENU_ITEM(drop_menu3,5,15,ASC("J"),0,"Justify  ",1,0)
MENU_ITEM(drop_menu3,6,15,ASC("A"),0,"Align    ",1,0)
MENU_ITEM(drop_menu3,7,15,ASC("R"),0,"Rotation ",1,0)
MENU_ITEM(drop_menu3,8,15,ASC("C"),0,"Color    ",1,0)
*
drop_menu4=MENU_OPEN( mem_font, 6, 0, 0, 1, 2, 1)
MENU_ITEM(drop_menu4,2,20,ASC("G"),0,"Go          ",1,0)
MENU_ITEM(drop_menu4,3,20,ASC("O"),0,"Orientation ",1,0)
MENU_ITEM(drop_menu4,4,20,ASC("I"),0,"Image Width ",1,0)
MENU_ITEM(drop_menu4,5,20,ASC("M"),0,"Image Margin",1,0)
MENU_ITEM(drop_menu4,6,20,ASC("P"),0,"Printer No. ",1,0)
MENU_ITEM(drop_menu4,7,20,ASC("E"),0,"Eject       ",1,0)
*
*
vh=VIEW_OPEN(ATX(12,2), ATY(6,2), ATX(95,2), ATY(95,2) , 0, 0)
SET_WORLD(M_xscale,0,0,0,1,-1)   && setup square coordinate system
x1 = VIEW_XMIN()-1
y1 = VIEW_YMIN()-1
x2 = x1+VIEW_WIDE()+1
y2 = y1+VIEW_HIGH()+1
IF M_bw=1
   VIEW_SWAP(0,0)
   FLINE(x1, y1, x2, y2, 1, 2)
   VIEW_SWAP(vh,0)
ENDIF
M_scrl1 = SCRL_OPEN( 0, x1+3, x2-3, y2+3, 8)
M_scrl2 = SCRL_OPEN( 1, y1+3, y2-3, x2+3, 8)
*
* Placement and attributes for current position of mouse
*
POS_SIZE()                       && No parameters - automatic sizing
POS_ATTR(0,50,mem_font)          && x, y, font
POS_COLOR(fg_color,9)            && fg, bg
POS_REFER()                      && Cursor reference coordinates
*                                   No parameters set reference to origin
POS_ONOFF(1,1,1)                 && Set on_or_off, position region, snap region
*
* Set up a grid at 40 horizontal and 40 vertical
*
GRID_SET(1,fg_color,40,40)       && GRID_SET(On_or_Off, color, horz, vert)
*
* Set the cursor you want as a default before REGN_INIT, in this case 7
MS_CURSOR(7)
REGN_INIT(1)
REGN_SET( 1, ATX(0,2), ATY(0,2), ATX(100,2), ATY(100,2), 0, 8)
HOT_VIEW( 1 )
*
MS_SETXY( 200, 200)              && Set cursor positioning
MS_CURON()                       && Turn mouse cursor on
*
OBJS_MAP()                       && Place grids on drawing surface
*
CAD_SETUP( 17, 0 )               && Turn auto remapping off
*
RETURN(vh)                       && Return from function


FUNCTION UN_SETUP
PARAMETER vh
CLR_ALL()
VIEW_CLOSE(vh)                   && Close viewport
MS_HALT()                        && End mouse interupt routine


FUNCTION ENTER_TEXT
VIEW_SWAP(0,0)
SET CURSOR ON
STRING=SPACE(40)
M_XSize=100
M_YSize=100
M_angle=0
@ M_rows-1,10 SAY 'Enter text: 'GET STRING
READ
SET CURSOR OFF
@ M_rows-1,10 SAY SPACE(66)
VIEW_SWAP(vh,0)
*
IF !LASTKEY()=27
   DECLARE POINTS[8]
   POINTS[1]=KP_SCALE_X()        && X position (World Coord)
   POINTS[2]=KP_SCALE_Y()        && Y Position (World Coord)
   POINTS[3]=1                   && Justification (0,1,2)
   POINTS[4]=2                   && Registration (0,1,2,3)
   POINTS[5]=M_XSize             && Horizontal Scale (World Coord)
   POINTS[6]=M_YSize             && Vertical Scale (World Coord)
   POINTS[7]=M_angle             && Angle (0-3600)
   POINTS[8]=TRIM(STRING)        && Text
   OBJ_ADD(4, 6, -1, M_font,POINTS,"TEXT") && (type, fg_color, bg_color, font, array, desc)
ENDIF

FUNCTION ZOOM_IN

M_result = MS_OBJECT(1,7,-1,1)
IF M_result=1
*                                           && Select largest value
   IF ABS(RET_END_X() - RET_STR_X()) < ABS(RET_END_Y() - RET_STR_Y())
      M_scale= ( MAX(RET_STR_Y(), RET_END_Y()) - MIN(RET_STR_Y(), RET_END_Y()) ) / ( WLD_YSCALE() / WLD_XSCALE() )
   ELSE
      M_scale=MAX(RET_STR_X(), RET_END_X()) - MIN(RET_STR_X(), RET_END_X())
   ENDIF
   SET_WORLD(M_scale, 0, MIN(RET_STR_X(), RET_END_X()), MIN(RET_STR_Y(),RET_END_Y()),1,-1)
   POS_SIZE()
   CLS_SCREEN()
   OBJS_MAP()
ENDIF

FUNCTION GRAB_DATA

IF HOT_NUMBER() > 0
   num=OBJ_ARRSIZ()
   DECLARE RET_ARRAY[num]
   OBJ_ARRPNT(RET_ARRAY)
   width = 0
   dec = 0
   POS_SIZE( @width, @dec )
   DO CASE
      CASE RET_ARRAY[1] < 4                                 && Line and boxes
         @ 1,10 SAY       'Type object: '+STR(RET_ARRAY[1],2)
         @ row()+1,10 SAY 'Color:       '+STR(RET_ARRAY[2],2)
         @ row()+1,10 SAY 'Fill:        '+STR(RET_ARRAY[3],2)
         @ row()+1,10 SAY 'Pattern:     '+STR(RET_ARRAY[4],2)
         @ row()+1,10 SAY 'Description: '+RET_ARRAY[5]
         i=6
         vert=6
         DO WHILE i < num
            @ vert,10 SAY STR(RET_ARRAY[i],width,dec)+","+STR(RET_ARRAY[i+1],width,dec)+" -"+STR(RET_ARRAY[i+2],2,0)
            i=i+3
            vert=vert+1
            IF vert > 22
               KEY_PRESS()
               vert=6
            ENDIF
         ENDDO
      CASE RET_ARRAY[1] = 20                                && Text
         @ 1,10 SAY       'Type object:      '+STR(RET_ARRAY[1],2)
         @ row()+1,10 SAY 'Color foreground: '+STR(RET_ARRAY[2],2)
         @ row()+1,10 SAY 'Color background: '+STR(RET_ARRAY[3],2)
         @ row()+1,10 SAY 'Font handle: '+STR(RET_ARRAY[4],2)
         @ row()+1,10 SAY 'Description: '+RET_ARRAY[5]
         @ row()+1,10 SAY 'Horz:        '+STR(RET_ARRAY[6],width,dec)
         @ row()+1,10 SAY 'Vert:        '+STR(RET_ARRAY[7],width,dec)
         @ row()+1,10 SAY 'Justify:     '+STR(RET_ARRAY[8],5,0)
         @ row()+1,10 SAY 'Registr:     '+STR(RET_ARRAY[9],5,0)
         @ row()+1,10 SAY 'X size:      '+STR(RET_ARRAY[10],5,0)
         @ row()+1,10 SAY 'Y size:      '+STR(RET_ARRAY[11],5,0)
         @ row()+1,10 SAY 'Angle:       '+STR(RET_ARRAY[12],5,3)
         @ row()+1,10 SAY 'Direction:   '+STR(RET_ARRAY[13],5,0)
         @ row()+1,10 SAY 'Text:        '+RET_ARRAY[14]
      CASE RET_ARRAY[1] > 9                                 && Circles and ARCS
         @ 1,10 SAY       'Type object: '+STR(RET_ARRAY[1],2)
         @ row()+1,10 SAY 'Color:       '+STR(RET_ARRAY[2],2)
         @ row()+1,10 SAY 'Fill:        '+STR(RET_ARRAY[3],2)
         @ row()+1,10 SAY 'Pattern:     '+STR(RET_ARRAY[4],2)
         @ row()+1,10 SAY 'Description: '+RET_ARRAY[5]
         @ row()+1,10 SAY 'Horz:   '+STR(RET_ARRAY[6],width,dec)
         @ row()+1,10 SAY 'Vert:   '+STR(RET_ARRAY[7],width,dec)
         @ row()+1,10 SAY 'Radius: '+STR(RET_ARRAY[8],width,dec)
         @ row()+1,10 SAY 'Start:  '+STR(RET_ARRAY[9],5,3)
         @ row()+1,10 SAY 'End:    '+STR(RET_ARRAY[10],5,3)
         @ row()+1,10 SAY 'Aspect: '+STR(RET_ARRAY[11],5,3)
   ENDCASE
   KEY_PRESS()
   OBJS_MAP()
ENDIF


FUNCTION INVENTORY

IF LAYER_INFO() > 0
   MS_CUROFF()
   num = LAYER_INFO()
   DECLARE RET_ARRAY[ num ], RET_HOT[ num ]
   LAYER_INFO( LAYER_CURR(), RET_ARRAY, RET_HOT )
   I=1
   VERT=3
   DO WHILE I <= NUM
      @ VERT,9 SAY IF( RET_HOT[I] = 1,'*',' ' )
      @ VERT,10 SAY RET_ARRAY[I]
      IF VERT > 22
         M_EV = KEY_PRESS()
         VERT=3
      ENDIF
      VERT=VERT+1
      I=I+1
   ENDDO
   KEY_PRESS()
   CLS_SCREEN()
   OBJS_MAP()
   MS_CURON()
ENDIF

FUNCTION MOVE_ORIGIN

M_result=MS_OBJECT(3,7,-1,1)
IF M_result = 1
   x_origin = WLD_XORG() - ( RET_END_X() - RET_STR_X() )
   y_origin = WLD_YORG() - ( RET_END_Y() - RET_STR_Y() )
   SET_WORLD(WLD_XSCALE(),0,x_origin,y_origin,1,-1)   && setup square coordinate system
   CLS_SCREEN()
   OBJS_MAP()
ENDIF

FUNCTION YN_RESPONSE
PARAMETER M_text

REGN_OFF()
diag_box1=MENU_OPEN( mem_font, 2, 0, 0, 1, 3, 1)
MENU_ITEM(diag_box1,6,20,ASC("Y"),0,"Yes"  ,1,0)
MENU_ITEM(diag_box1,6,26,ASC("N"),0,"No"   ,1,0)
MENU_ITEM(diag_box1,4,20,""      ,1,M_text,0,-2)
M_ans = MENU_ONLY( diag_box1 )
*
MENU_EDIT( top_menu, 1 )
CLR_MENU( diag_box1 )
REGN_ON()
*
IF M_ans = 1
   RETURN .T.
ELSE
   RETURN .F.
ENDIF

FUNCTION FILE_NAME
PARAMETER M_text, M_filename
?? CHR(7)
VIEW_SWAP(0,0)
M_ans=1
SET CURSOR ON
@ M_rows-1,10 SAY M_text GET M_filename
READ
SET CURSOR OFF
@ M_rows-1,10 SAY SPACE( LEN(M_text)+LEN(M_filename)+1 )
VIEW_SWAP(vh,0)
RETURN(M_filename)

FUNCTION SEL_COLOR
PARAMETER M_COLOR
diag_box1 = MENU_OPEN( mem_font, 2, 0, 0, 1, 2, 1)
FOR I=0 TO 15
   BUTTON_ADD( diag_box1, 100, I*20+100, 150, I*20+118, I, 0, 1, I )
NEXT
M_ans = MENU_ONLY( diag_box1 )
RETURN( M_ans-1 )
