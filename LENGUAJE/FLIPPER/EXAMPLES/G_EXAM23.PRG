*******************************************************************************
*  G_EXAM23.PRG                                                               *
*  Requirements: None                                                         *
*  Description:                                                               *
*        This program demonstrates the use of the FDRAW() function, which     *
*        takes a format string of commands and follows them to create a       *
*        drawing on the graphics screen.                                      *
*  Chapter 10, Special Drawing Functions                                      *
*******************************************************************************
FLIP_INIT(1000)
M_screen=1
M_format="M100,100 C1 R20 D20 L20 U20                                      "
DO WHILE .T.
   CLEAR
   TEXT
   ************************************************************************
   * Example of FDRAW:                                                    *
   *                                                                      *
   * FDRAW(Format string) -                                               *
   ************************************************************************
   ENDTEXT
*
   @ 22,0 SAY 'Format: 'GET M_format
   READ
   IF LASTKEY()=27
      EXIT
   ENDIF
*
   FSCREEN()
   FDRAW(M_format)
   inkey(0)
   TEXTMODE()
ENDDO
