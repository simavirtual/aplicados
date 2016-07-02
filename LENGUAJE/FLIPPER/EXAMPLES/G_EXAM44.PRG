*******************************************************************************
*  G_EXAM46.PRG                                                               *
*  Author: Gary Prothero                                                      *
*  Requirements: None                                                         *
*  Description:                                                               *
*       This demonstrates the ADD_YSCALE function.                            *
*******************************************************************************
FLIP_INIT(6000)
USE TEST
INITDATA(2)
*
SET_TYPE(1,1)
*
DO WHILE .NOT. EOF()
   @ 23,0 SAY STORE_DATA(XNUMBER,NUMBER1)
   SKIP
ENDDO
*
SET_AREA( 0, 0, 90, 95 )
PLOT()
*
HORZ_LINE( 4 )
ADD_YSCALE( ABS_XMAX()+15, 1, 0, 10, 1, 3, 4, 6)  && Only after first displayed
inkey(0)
*
TEXTMODE()
