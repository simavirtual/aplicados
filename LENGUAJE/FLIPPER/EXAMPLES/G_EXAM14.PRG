*******************************************************************************
*  G_EXAM14.PRG                                                               *
*  Requirements: None                                                         *
*  Description:                                                               *
*        This program demonstrates the use of grids on your graph.  You can   *
*        set different grid types, line patterns and grid colors with three   *
*        simple commands used in this program.                                *
*  Chapter 3, Customizing the Graph                                           *
*******************************************************************************
FLIP_INIT(1000)
*
M_axis=0
M_grid=0
M_pat=0
M_color=1
DO WHILE .T.
   CLEAR
   TEXT
   ***********************************************************************
   * Example of setting grid                                             *
   *                                                                     *
   *  SET_GRID()    Axis   0-X axis, 1-Left Y axis, 2-Right Y axis       *
   *                Grid   0-Off, 1-On                                   *
   *                Pattern 0 to 10                                      *
   ***********************************************************************
   ENDTEXT
*
   INITDATA(3)
*
   FOR I=0 to 2
      @ 15+I,10 SAY 'Axis '+STR(I,1)+IIF( SET_GRID(I) = 1, " On" , " Off" )
   NEXT
   @ 19,0 SAY 'Set grid axis (0,1,2): 'GET M_axis PICT '9' valid M_axis < 3
   @ 20,0 SAY 'Set grid (0/1):        'GET M_grid PICT '9' valid M_grid < 2
   @ 21,0 SAY 'Set pattern number:    'GET M_pat PICT '99' valid M_pat < 11
   @ 22,0 SAY 'Set grid color    :    'GET M_color PICT '99' valid M_color>0 .and. M_color<16
   READ
   IF LASTKEY()=27
      EXIT
   ENDIF
*
   SET_GRID(M_axis, M_grid, M_pat)
   GRF_COLORS( .f., M_color)
*
   SET_TYPE(1,1)
   SET_TYPE(2,1)
   USE TEST
   DO WHILE .not. EOF()
      @ 23,0 SAY STORE_DATA(Xdate,xnumber,number1)
      SKIP
   ENDDO
   *
   PLOT()
   inkey(0)
   TEXTMODE()
ENDDO
