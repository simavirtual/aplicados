******************************************************************************
*  C_EXAM01.PRG                                                              *
*  Requirements: None                                                        *
*  Description:                                                              *
*        This program demonstrates the use of the SAY_FIXED() function.      *
*        SAY_FIXED() is used to display text on the screen in fixed spacing, *
*        rather than proportional spacing.  It can also be used to calculate *
*        the maximum rows and columns for a certain font.                    *
*  Chapter 8, Fonts                                                          *
******************************************************************************
FLIP_INIT(1,1)                   && Initialize flipper

CLEAR SCREEN
*
SET_SAYERR(1)
FONT_OPEN("\FLIPPER\FONTS\RMN8_15.@") && Open Proportional spaced font from disk
*
M_display = RET_DISPLY()
M_mode = RET_CARD()
M_row =1
M_col =0
M_font=4
M_fg  =15
M_bg  =0
S_rows=-1
S_cols=-1
M_templet="A"
*
DO WHILE .T.
   IF !S_rows=-1                    && only say after 1 time in graphics
      @ 10,0 SAY "Screen Rows:    "+STR(S_rows,3,0)
      @ 11,0 SAY "Screen Columns: "+STR(S_cols,3,0)
   ENDIF
   @ 13,0 SAY "Display:  "GET M_display PICT "9"
   @ 14,0 SAY "Mode:     "GET M_mode PICT "99"
   @ 16,0 SAY "Row:      "GET M_row
   @ 17,0 SAY "Column:   "GET M_col
   @ 18,0 SAY "Font:     "GET M_font RANGE 1,4
   @ 19,0 SAY "FG:       "GET M_fg
   @ 20,0 SAY "BG:       "GET M_bg
   @ 21,0 SAY "Template: "GET M_templet PICT 'A'
   READ
   IF LASTKEY()=27
      EXIT
   ENDIF
*
   SET_DISPLY(M_display)
   GRAPHMODE(M_mode)
*
   FSCREEN()                           && To graphics mode
*
*  Traditional SAY_TEXT with proportional spaced fonts
*
   FONT_COLOR(M_font,M_fg,M_bg)
   FONT_NEW(M_font)
   FONT_ALIGN(M_font,0)
   SAY_TEXT(0,0,"HELLO There from SAY_TEXT <- proportional spacing")
*
*  Get the screen rows and column with this font and the active graphics screen
*  You also can set the templet letter for spacing proportional as fixed text
*
   SAY_FIXED( @S_rows, @S_cols, M_font, ASC(M_templet))   && Pass row and column by reference
*
*  New SAY_FIXED says each letter a fixed spacing according to the size of
*  the capital A. Also demonstates using compiled fonts.
*
   SAY_FIXED( M_row, M_col, M_font, M_fg, M_bg, "HELLO There from Fixed spacing")
   FBOX( ATX(M_col,3), ATY(M_row,3), ATX(M_col+29,4), ATY(M_row,4), 15)
   inkey(0)
   TEXTMODE()
ENDDO
