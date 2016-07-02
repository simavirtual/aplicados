*******************************************************************************
*  G_EXAM01.PRG                                                               *
*  Author: Gary Prothero                                                      *
*  Requirements: None                                                         *
*  Description:                                                               *
*       This is a simple example of a line graph.  It demonstrates how little *
*       code you need to generate your first graph.                           *
*  Introduction                                                               *
*******************************************************************************
FLIP_INIT(6000)
USE TEST
INITDATA(2)
*
SET_TYPE(1,5)
*
DO WHILE .NOT. EOF()
   @ 23,0 SAY STORE_DATA(XNUMBER,NUMBER1)
   SKIP
ENDDO
*
PLOT()
LEGEND_SET(1,"TEXT")
LEGEND_SAY( 100, 100, 0 )
inkey(0)
*
TEXTMODE()
