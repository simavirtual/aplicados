*******************************************************************************
*  G_EXAM34.PRG                                                               *
*  Requirements: None                                                         *
*  Description:                                                               *
*        This program demonstrates the plotting of your graph by using only   *
*        a specified portion of the buffer.  You can then re-scale the graph  *
*        to this data, or you can use the old scale.                          *
*  Chapter 5, Displaying Graphs & Charts                                      *
*******************************************************************************
FLIP_INIT(600)
INITDATA(3)
SET_TYPE(1,1)
SET_TYPE(2,1)
STORE_DATA(1,3,102)
STORE_DATA(3,5,95)
STORE_DATA(5,7,83)
STORE_DATA(7,15,76)
STORE_DATA(12,25,62)
STORE_DATA(15,45,57)
STORE_DATA(19,66.3,43)
STORE_DATA(24,73,35)
STORE_DATA(30,84.5,31)
STORE_DATA(37,98.5,21)
STORE_DATA(45,100.2,15)
STORE_DATA(56,110.5,3)
STORE_DATA(65,130,1)
STORE_DATA(76,160,3)
*
M_Srow=1
M_Erow=RET_COUNT()
M_rescale=0
*
DO WHILE .T.
   PLOT( M_rescale )
   inkey(0)
*
   TEXTMODE()
*
   @ 20,0 SAY 'Start row  'GET M_Srow PICT '999' range 1,RET_COUNT()
   @ 21,0 SAY 'Ending row 'GET M_Erow PICT '999' range 1,RET_COUNT()
   @ 22,0 SAY 'Re-scale   'GET M_rescale PICT '9' range 0,2
   @ 23,0 SAY ' 0 - axis & plot,  1 - plot data on last axis,  2 - draw axis only'
   READ
*
   IF LASTKEY()=27
      EXIT
   ENDIF
   BUFF_LIMIT( M_Srow, M_Erow )
*
ENDDO
