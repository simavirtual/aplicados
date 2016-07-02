*******************************************************************************
*  G_EXAM13.PRG                                                               *
*  Author: Gary Prothero                                                      *
*  Requirements: None                                                         *
*  Description:                                                               *
*        This program demonstrates how to use the graph label commands.  These*
*        commands are used for the graph title, x-axis title, and y-axis      *
*        title.  The fonts for these labels can also be changed, and this is  *
*        done in this program, also.                                          *
*  Chapter 3, Customizing the Graph                                           *
*******************************************************************************
FLIP_INIT(2000)
SET_SAYERR(1)
*
M_type=1
M_Gfont=1
M_Lfont=1
M_Sfont=1
M_type=1
M_text=space(20)
M_text1=space(20)
M_text2=space(20)
M_missval=0
M_misstype=0
M_misstyle=0
*
max_fh=FONT_OPEN("\FLIPPER\FONTS\SSD1_20.@")
max_fh=FONT_OPEN("\FLIPPER\FONTS\OE3_22.@")
max_fh=FONT_OPEN("\FLIPPER\FONTS\TTL8_48.@")
max_fh=FONT_OPEN("\FLIPPER\FONTS\TTL09_33.@")
*
DO WHILE .T.
   CLEAR
   TEXT
   **********************************************************************
   *  Example of setting different fonts for graph and pie chart labels *
   *                                                                    *
   *  G_LABEL(text)     Graph and pie chart titles                      *
   *  X_LABEL(text)     X axis title                                    *
   *  Y_LABEL(text)     Y axis title                                    *
   *                                                                    *
   *  SET_G_FONT(font)  Graph and pie title font                        *
   *  SET_L_FONT(font)  Graph and pie labels font                       *
   *  SET_S_FONT(font)  Graph scale font                                *
   **********************************************************************
   ENDTEXT
*
   INITDATA(5)
   FLP_RESET()
   @ 15,0 SAY 'Graph type:    'GET M_type PICT '9' VALID M_type<5
   @ 16,0 say 'Graph Title:   'GET M_Text
   @ 17,0 say 'X Axis Title:  'GET M_Text1
   @ 18,0 say 'Y Axis Title:  'GET M_Text2
   @ 19,0 say 'Font title:    'GET M_Gfont pict '9' valid M_Gfont>0 .and. M_Gfont<max_fh
   @ 20,0 say 'Font labels:   'GET M_Lfont pict '9' valid M_Gfont>0 .and. M_Gfont<max_fh
   @ 21,0 say 'Font scale:    'GET M_Sfont pict '9' valid M_Gfont>0 .and. M_Gfont<max_fh
   @ 22,0 say 'Missing value: 'GET M_missval pict '99.9'
   @ 23,0 say 'Missing type:  'GET M_misstype pict '9'
   @ 24,0 say 'Missing style: 'GET M_misstyle pict '9'
   READ
   IF LASTKEY()=27
      EXIT
   ENDIF
*
   SET_MISS(M_misstype)
   SET_MVALUE(M_missval)
   SET_MSTYLE(M_misstyle)
*
   SET_G_FONT(M_Gfont)
   SET_L_FONT(M_Lfont)
   SET_S_FONT(M_Sfont)
*
   G_LABEL(TRIM(M_TEXT))
   X_LABEL(TRIM(M_text1))
   Y_LABEL(TRIM(M_text2))
*
   SET_TYPE(1,M_type)
   STORE_DATA("Portland",3)
   STORE_DATA("Vancouver",2)
   STORE_DATA("West Linn",10)
   STORE_DATA("Franklin",1)
   STORE_DATA("Delaware",4)
   STORE_DATA("Hermiston",1)
*
   PLOT()
*
   inkey(0)
   TEXTMODE()
ENDDO
