*******************************************************************************
*  G_EXAM26.PRG                                                               *
*  Requirements: None                                                         *
*  Description:                                                               *
*        This program demonstrates the use of the REGRESS() function to draw  *
*        a regression line.  You can regress either linear or log data.       *
*  Chapter 6, Additional Features After the Graph is Displayed                *
*******************************************************************************
FLIP_INIT(600)
M_regress=1
M_log=0
DO WHILE .T.
   INITDATA(2)
   CLEAR
   TEXT
   ************************************************************************
   *        REGRESS(Y column)                                             *
   *                                                                      *
   *        N=RET_YINTER()     y intercept                                *
   *        N=RET_COEF()       correlation coefficient                    *
   *        N=RET_SLOPE()      slope of line                              *
   ************************************************************************
   ENDTEXT
*

   @ 22,0 SAY 'Log? (1/0)              'GET M_log PICT '9' range 0,1
   READ
*
   IF LASTKEY()=27
      EXIT
   ENDIF
*
   SET_YLOG(M_log)
*
   SET_TYPE(1,5)
*
   STORE_DATA(  4.45,    93.70)
   STORE_DATA(  6.09,   298.81)
   STORE_DATA( 11.17,   524.09)
   STORE_DATA( 12.29,   596.62)
   STORE_DATA( 12.36,   529.94)
   STORE_DATA( 12.36,   506.81)
   STORE_DATA( 12.36,   488.38)
   STORE_DATA( 12.36,   529.13)
   STORE_DATA( 12.36,   626.79)
   STORE_DATA( 12.29,   574.24)
   STORE_DATA( 11.49,   520.90)
   STORE_DATA(  6.91,   347.23)
   STORE_DATA(  4.61,   101.02)
   STORE_DATA(  3.51,    75.91)
   STORE_DATA(  5.50,   253.28)
   STORE_DATA( 10.97,   399.40)
   STORE_DATA( 12.29,   567.03)
   STORE_DATA( 12.36,   569.66)
   STORE_DATA( 12.36,   519.86)
   STORE_DATA( 12.24,   470.75)
   STORE_DATA( 12.36,   511.26)
   STORE_DATA( 10.13,   585.79)
   STORE_DATA( 10.65,   591.65)
   STORE_DATA(  6.94,   498.57)
   STORE_DATA(  6.66,   361.39)
   STORE_DATA(  2.41,   167.99)
*
   M_Srow=1
   M_Erow=RET_COUNT()
   DO WHILE .T.
      BUFF_LIMIT()                        && Set full buffer for plot
      PLOT()
*
      BUFF_LIMIT( M_Srow, M_Erow )        && Limit buffer for regression
      REGRESS( M_regress )
*
      IF SET_YLOG()=1
         SAY_TEXT(ATX(20,0),ATY(20,0),'Log(Y)='+LTRIM(STR(RET_SLOPE(),8,2))+'X + '+LTRIM(STR(RET_YINTER(),8,2)))
      ELSE
         SAY_TEXT(ATX(20,0),ATY(20,0),'Y='+LTRIM(STR(RET_SLOPE(),8,2))+'X + '+LTRIM(STR(RET_YINTER(),8,2)))
      ENDIF
      inkey(0)
      TEXTMODE()
*
      @ 21,0 say 'Start row           'GET M_Srow PICT '999' range 1,RET_COUNT()
      @ 22,0 say 'Ending row          'GET M_Erow PICT '999' range 1,RET_COUNT()
      READ
*
      IF LASTKEY()=27
         EXIT
      ENDIF
   ENDDO
ENDDO
