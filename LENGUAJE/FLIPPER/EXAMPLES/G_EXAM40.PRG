*******************************************************************************
*  G_EXAM40.PRG                                                               *
*  Requirements: None                                                         *
*  Description:                                                               *
*        This program demonstrates the use of the Flipper get system.  The    *
*        system is very similar to the Clipper get system, but is more        *
*        specialized for the graphics screen.                                 *
*  Chapter 10, Special Drawing Functions                                      *
*******************************************************************************
FLIP_INIT(10)
SET_SAYERR(1)
max_fh=FONT_OPEN("\flipper\fonts\RMN8_26.@")
max_fh=FONT_OPEN("\flipper\fonts\SSD1_20.@")
*
CLEAR SCREEN
*
M_font=3
M_curs = 1
M_SFG=1
M_SBG=0
M_EFG=2
M_EBG=4
M_GFG=3
M_GBG=1
DO WHILE .T.
*
   SET CURSOR ON
   @ 15,0 SAY '     Cursor: 'GET M_curs PICT '9' RANGE 0,1
   @ 16,0 SAY 'Font number: 'GET M_font RANGE 1,max_fh
   @ 17,0 SAY '     Say FG: 'GET M_SFG PICT '99'
   @ 18,0 SAY '     Say BG: 'GET M_SBG PICT '99'
   @ 19,0 SAY 'Enhanced FG: 'GET M_EFG PICT '99'
   @ 20,0 SAY 'Enhanced BG: 'GET M_EBG PICT '99'
   @ 21,0 SAY '     Get FG: 'GET M_GFG PICT '99'
   @ 22,0 SAY '     Get BG: 'GET M_GBG PICT '99'
   READ
   IF LASTKEY()=27
      EXIT
   ENDIF
*
   FONT_NEW(M_font)
*
   SET CURSOR OFF
   FSCREEN()
   GET_CURSOR(M_curs)                               && Turn cursor on or off
   GET_GETCLR(M_SFG,M_SBG,M_EFG,M_EBG,M_GFG,M_GBG)  && Set colors of SAY's
   GET_SAY(100,100,"Get: ")
   M_TEXT1= GET_GET(.f.,.f.,space(25),"")           && GET_GET(x,y,text,picture)
   TEXTMODE()
   ? M_TEXT1
   wait
*
ENDDO
