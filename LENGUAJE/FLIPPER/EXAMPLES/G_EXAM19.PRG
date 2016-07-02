*******************************************************************************
*  G_EXAM19.PRG                                                               *
*  Requirements: None                                                         *
*  Description:                                                               *
*        This program demonstrates the font commands.  Text can be rotated,   *
*        underlined, and written in different directions.  You can also change*
*        the foreground and background color for it.                          *
*  Chapter 8, Fonts                                                           *
*******************************************************************************
FLIP_INIT(1000)
SET_SAYERR(1)
M_TEXT='HELLO WORLD'+SPACE(40)
max_fh=FONT_OPEN("\FLIPPER\FONTS\SSD1_20.@")
max_fh=FONT_OPEN("\FLIPPER\FONTS\TTL09_33.@")
*
M_x=100
M_y=100
*
M_fg=0
M_bg=0
M_thick=0
M_pos=0
M_ucolr=0
DO WHILE .T.
*
   M_font = FONT_CURR()
   FONT_COLOR(M_font, @M_fg, @M_bg)
   M_rot = FONT_ROTAT(M_font)
   FONT_UNDER(M_font, @M_pos, @M_thick, @M_ucolr)
   M_space = FONT_SPACE(M_font)
   M_align = FONT_ALIGN(M_font)
*
   M_dir=LINE_DIR()
   M_under=LINE_UNDER()
   M_just=LINE_JUST()
*
   CLEAR
   @ 2,0 SAY 'Current font: '
   ?? FONT_CURR()
   @ 3,0 SAY 'Fonts loaded: '
   ?? max_fh
*
   @ 9,0 SAY 'Font:           'GET M_font PICT '99' RANGE 0,max_fh
   @ 10,0 SAY 'X,Y position:  '
   @ 10,col()+2 GET M_x pict '999'
   @ 10,col()+2 GET M_y pict '999'
   @ 11,0 SAY 'Text:           'GET M_TEXT
   @ 12,0 SAY 'Color: F/B     '
   @ 12,col()+2 GET M_fg pict '99'
   @ 12,col()+2 GET M_bg pict '99'
   @ 13,0 SAY 'Rotation: 0-3: '
   @ 13,col()+2 GET M_rot pict '9'
   @ 14,0 SAY 'Direction 0-3: '
   @ 14,col()+2 GET M_dir pict '9'
   @ 15,0 SAY 'Spacing:       '
   @ 15,col()+2 GET M_space pict '9'
   @ 16,0 SAY 'Underline: 1/0 '
   @ 16,col()+2 GET M_under pict '9' valid M_under<2
   @ 17,0 SAY 'Underline:     '
   @ 17,col()+2 GET M_pos pict '99'
   @ 17,col()+2 GET M_thick pict '99' valid M_thick>=0
   @ 17,col()+2 GET M_ucolr pict '99' valid M_ucolr>=0 .and. M_ucolr<16
   @ 18,0 SAY 'Justify:   0-2 '
   @ 18,col()+2 GET M_just pict '9' valid M_just<3
   @ 19,0 SAY 'Alignment: 0-3 '
   @ 19,col()+2 GET M_align pict '9' valid M_align<4
   READ
   IF LASTKEY()=27
      EXIT
   ENDIF
*
   FSCREEN()
   FONT_NEW(M_font)
*
   M_draw='C2 BM'+str(M_x,3)+','+str(M_y,3)+'NU10 ND10 NL10 NR110'
   FDRAW(M_draw)
*
   FONT_UNDER(FONT_CURR(),M_pos,M_thick,M_ucolr)
   FONT_ALIGN(FONT_CURR(),M_align)
*
   FONT_SPACE(FONT_CURR(),M_space)
   FONT_ROTAT(FONT_CURR(),M_rot)
*
   LINE_UNDER(M_under)
   LINE_DIR(M_dir)
   LINE_JUST(M_just)
   FONT_COLOR(FONT_CURR(),M_fg,M_bg)
*
   SAY_TEXT(M_x,M_y,TRIM(M_TEXT))
*
   INKEY(0)
*
   TEXTMODE()
ENDDO
