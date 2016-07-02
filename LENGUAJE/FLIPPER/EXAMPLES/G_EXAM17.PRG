*******************************************************************************
*  G_EXAM17.PRG                                                               *
*  Author: Gary Prothero                                                      *
*  Requirements: None                                                         *
*  Description:                                                               *
*        This program demonstrates the use of the manual scaling commands.    *
*        You can set part or all of the automatic scaling routine. If you set *
*        the Max value only, then that Max value will replace the actual Max  *
*        value in the data set for that column, but it will still             *
*        automatically scale the axis. You can set the Min and Max values for *
*        the column, and those values will replace the actual Max and Min     *
*        values from that column. Then those values will be be automatically  *
*        scaled. However, if you set all three values (Max, Min, Inc), then   *
*        the scale will be manually scaled using those three values. You must *
*        switch to manual scaling with the SET_YMAN() function.               *
*  Chapter 3, Customizing the Graph                                           *
*******************************************************************************
FLIP_INIT(1000)
SET_SAYERR(1)
max_fh=FONT_OPEN("\FLIPPER\FONTS\SSD1_20.@")
X_MIN=ctod('01/01/89')
X_MAX=ctod('01/30/89')
X_INC=10
m_title=space(20)
*
ON=1
OFF=0
*
m_date=ctod('01/01/89')
DO WHILE .T.
   CLEAR
   TEXT
   ************************************************************************
   * Example of axis scaling routines:                                    *
   *                                                                      *
   *  SET_XMIN(value)  - set minimum X axis value                         *
   *  SET_XMAX(value)  - set maximum X axis value                         *
   *  SET_XINC(value)  - set increment between labels                     *
   *  SET_XMAN()       - set manual scaling on (will not use above values *
   *                                            unless SET_XMAN() issued  *
   *                                                                      *
   * This example will show the automatic graph first then the manually   *
   * scaled graph.                                                        *
   ************************************************************************
   ENDTEXT
*
   INITDATA(3)

   SET_G_FONT(1)

   @ 20,0 SAY 'X min: 'GET X_MIN
   @ 21,0 SAY 'X max: 'GET X_MAX
   @ 22,0 SAY 'X inc: 'GET X_INC PICT '999'
   READ
   IF LASTKEY()=27
      EXIT
   ENDIF
*
   SET_XINC(X_inc)
   SET_XMAX(X_max)
   SET_XMIN(X_min)
*
   SET_TYPE(1,1)
   SET_TYPE(2,1)
*
   STORE_DATA(M_DATE,2,5)
   STORE_DATA(M_DATE+5,4,8)
   STORE_DATA(M_DATE+10,16,12)
   STORE_DATA(M_DATE+15,12,18)
   STORE_DATA(M_DATE+25,8,2)
*
   G_LABEL('Automatic scaling')
   PLOT()
   INKEY(0)
*
   CLS_SCREEN()
   SET_XMAN(ON)
   G_LABEL('Manual scaling')
   PLOT()
   INKEY(0)
   SET_XMAN(OFF)
*
   TEXTMODE()
ENDDO
