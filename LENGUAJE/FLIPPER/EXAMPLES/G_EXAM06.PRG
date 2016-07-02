*******************************************************************************
*  G_EXAM06.PRG                                                               *
*  Requirements: None                                                         *
*  Description:                                                               *
*        This program demonstrates the use of the SET_XSKIP() function. This  *
*        function allows you to skip x-axis labels on your graph.             *
*  Chapter 3, Customizing the Graph                                           *
*******************************************************************************
FLIP_INIT(600)                               && Create 600 byte buffer
M_skip = 1
DO WHILE .T.
   CLEAR
   TEXT
   *******************************************************************
   * Example: SET_XSKIP(number)                                      *
   *                                                                 *
   * Parameters: number  - skip number of labels                     *
   *                                                                 *
   *******************************************************************
   ENDTEXT
*
   INITDATA(2)                               && Configure buffer for 2 columns
*
   SET_TYPE(1,1)                             && Set array column 1 to line
   STORE_DATA(1,3)                           && Store data into buffer
   STORE_DATA(12,5)
   STORE_DATA(56,10)
   STORE_DATA(123,3)
*
   @ 22,60 SAY 'Skipped: '+STR(M_skip,2,0)    && Return current number
   @ 22,0 say 'X Axis Skip: 'GET M_skip PICT '9'
   READ
*
   IF LASTKEY()=27
      EXIT
   ENDIF
*
   SET_XSKIP(M_skip)                         && Set number to skip
*
   PLOT()                                    && Plot graph to screen
   inkey(0)
   TEXTMODE()                                && Return to CLIPPER text mode
*
ENDDO
