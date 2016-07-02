*******************************************************************************
*  G_EXAM39.PRG                                                               *
*  Requirements: None                                                         *
*  Description:                                                               *
*        This program demonstrates the use of the SAY_FMT command, which when *
*        passed a string of commands, can print text in many different ways.  *
*  Chapter 8, Fonts                                                           *
*******************************************************************************
FLIP_INIT(500)
SET_SAYERR(1)
max_fh = FONT_OPEN("RMN8_17.@")
max_fh = FONT_OPEN("OE2_38.@")
max_fh = FONT_OPEN("TTL8_48.@")
M_fstring = "|(100,100)CF6|SAY_FMT can|(200,150)CF5 KF6 A SP8 DD|do many|(300,300) CF4 DR KF15 KB5|things"+SPACE(25)
DO WHILE .T.
   CLEAR
   TEXT
********************************************************************************
SAY_FMT(cFormatString)

  FORMAT CODES:
  (x,y) - Location                      DR - Write text from left to right
  CF<#> - Select font                   DL - Write text from right to left
  KF<#> - Select foreground color       DU - Write text from bottom to top
  KB<#> - Select background color       DD - Write text from top to bottom
  AT    - Align at the top              JS - Justify at the start of the line
  AM    - Align at the center line      JE - Justify at the end of the line
  AB    - Align at the baseline         JC - Justify at the center of the line
  A     - Align at the bottom           R0 - Rotate zero degrees
  SP<#> - Set horizontal spacing value  R1 - Rotate 90 degrees
  UN    - Underline start/stop          R2 - Rotate 180 degrees
                                        R3 - Rotate 270 degrees
*************************************************************************
   ENDTEXT
   @ 22,0 SAY 'String: 'GET M_fstring
   READ
   IF LASTKEY()=27
      EXIT
   ENDIF
   FSCREEN()
   SAY_FMT(ALLTRIM(M_fstring))
   INKEY(0)
   TEXTMODE()
ENDDO
