*******************************************************************************
*  G_EXAM16.PRG                                                               *
*  Author: Gary Prothero                                                      *
*  Requirements: None                                                         *
*  Description:                                                               *
*        This program demonstrates a few graph enhancement functions.  The    *
*        main functions demonstrated are SET_OLAP(), SET_ZLINE(), and         *
*        HISTOGRAM().                                                         *
*  Chapter 3, Customizing the Graph                                           *
*******************************************************************************
FLIP_INIT(2000)
M_zeroline=0.00
M_type=1
M_olap=1
M_Xaxis=1
M_hist=0
DO WHILE .T.
   CLEAR
   TEXT
   ************************************************************************
   * Example of graph enhancement functions.                              *
   *                                                                      *
   *  SET_OLAP(0/1)    - set axis to either skip or overlap labels        *
   *  SET_ZLINE(value) - set a reference line for bars to start. (try 1)  *
   *  HISTOGRAM(0/1)   - sets no space between the bars. Must be set to   *
   *                     character type on X Axis and bar type on Y Axis. *
   *                                                                      *
   * This example will redraw the graph adding new data by 2's.           *
   * When the graph displays - tap the space bar to see a new graph with  *
   * new data. This can serve to help you understand how the axis are     *
   * scaled when creating a line, bar, or pie chart. Spend some time      *
   * playing with this example - there's a lot to learn here!!!           *
   ************************************************************************
   ENDTEXT
*
   INITDATA(2)
*
   M_DATE=CTOD('07/16/87')
   @ 18,0 SAY 'Zeroline position?  'GET M_zeroline
   @ 19,0 SAY 'Graph type? (1-6):  'GET M_type PICT '9' valid M_type > 0 .and. M_type < 7
   @ 20,0 SAY 'Multi level? (0/1)  'GET M_olap PICT '9'
   @ 21,0 SAY 'Histogram? (0/1)    'GET M_hist PICT '9' valid M_hist=0 .or. M_hist=1
   @ 22,0 SAY 'Store type? (1,2,3) 'GET M_Xaxis PICT '9'
   @ 22,25 SAY '<------------------------------------'
   @ 19,58 to 23,75 double
   @ 20,60 SAY '1 = numeric'
   @ 21,60 SAY '2 = date'
   @ 22,60 SAY '3 = character'
   READ
*
   IF LASTKEY()=27
      EXIT
   ENDIF
*
   SET_TYPE(1,M_type)
   SET_ZLINE(M_zeroline)
   SET_OLAP(M_olap)
   HISTOGRAM(M_hist)
*
   i=1
   DO WHILE .NOT. lastkey()=27
      DO CASE
         CASE M_Xaxis=1
            STORE_DATA(I,I)
         CASE M_Xaxis=2
            STORE_DATA(M_DATE+I,I)
         CASE M_Xaxis=3
            M_DATE1=DTOC(M_DATE+I)
            STORE_DATA( M_DATE1,I)
      ENDCASE
*
      IF M_type==6
         PIE(1)
      ELSE
         PLOT()
      ENDIF
*
      inkey(0)
      CLS_SCREEN()
      I=I+2
   ENDDO
   TEXTMODE()
ENDDO
