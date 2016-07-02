*******************************************************************************
*  G_EXAM08.PRG                                                               *
*  Requirements: None                                                         *
*  Description:                                                               *
*        This program demonstrates moving a cursor point on screen and        *
*        returning the value of the point on the X and Y axis back to your    *
*        Clipper applications.                                                *
*  Chapter 11, Viewport and Scaling Functions                                 *
*******************************************************************************
CLEAR SCREEN
TEXT
   ***********************************************************************
   * Example program demonstrating moving a cursor point on screen and   *
   * returning the value of the point on the X and Y axis back to your   *
   * clipper application.                                                *
   *                                                                     *
   * ATX() find relative horizontal pixel location                       *
   * ATY() find relative vertical pixel location                         *
   *                                                                     *
   * ABS_TO_X(absolute X point,type) returns the value of the point on   *
   *                                 the X axis.                         *
   * ABS_TO_Y(absolute Y point,type) returns the value of the point on   *
   *                                 the Y axis.                         *
   * SET_XOR() allows you to draw over other figures without destroying  *
   *           the underlying pixels.  (0 is OFF, 1 is ON)               *
   *                                                                     *
   * Use the arrow keys to move the point on the screen. Start with left *
   *                                                     arrow key.      *
   *                   >>> TAP ANY KEY TO BEGIN <<<                      *
   ***********************************************************************
ENDTEXT
inkey(0)
*
DO WHILE LASTKEY() # 27
   FLIP_INIT(6000)
   USE TEST
   INITDATA(2)
*
   STORE_DATA(1,3)                           && Store data into buffer
   STORE_DATA(12,5)
   STORE_DATA(56,10)
   STORE_DATA(123,3)
*
   SET_TYPE(1,1)
   G_LABEL("Use arrow keys to move point")
   PLOT()
*
* m_cnt-1 is the last data item in the buffer
*
   m_cnt=RET_COUNT()
*
* return the last data item (m_cnt) for column 0 (x axis) and column 1 (Y axis)
*
   m_d1=STORE_VAL(m_cnt,0)
   m_d2=STORE_VAL(m_cnt,1)
*
* find pixel location of last data point using ATX() and ATY() function, the
* second parameter is 1 for relative to the axis scale position.
*
   m_x=ATX(m_d1,1)
   m_y=ATY(m_d2,1)
*
   m_x1=m_x
   m_y1=m_y
   m_xstart=m_x
   m_ystart=m_y
   SET_XOR(1)            && set XORING on
*
   DO WHILE .T.
      SAY_TEXT(ATX(20,0),ATY(90,0),str(ABS_TO_X(m_x,1),6,2)+' '+str(ABS_TO_Y(m_y,1),6,2))
*                                    |
*                                   ABS_TO_X() returns scale value based on cursor
*                                   position.
*
      FLINE( m_xstart, m_ystart, m_x, m_y, 15)
      INKEY(0)
      DO CASE
         CASE LASTKEY()=27
            exit
         CASE LASTKEY()=24
            m_y1=m_y+1
         CASE LASTKEY()=5
            m_y1=m_y-1
         CASE LASTKEY()=4
            m_x1=m_x+1
         CASE LASTKEY()=19
            m_x1=m_x-1
      ENDCASE
      FLINE( m_xstart, m_ystart, m_x, m_y, 15 )
*
* Say text again to erase with XOR
*
      SAY_TEXT( ATX(20,0),ATY(90,0),str(ABS_TO_X(m_x,1),6,2)+' '+str(ABS_TO_Y(m_y,1),6,2))
      m_x=m_x1
      m_y=m_y1
   ENDDO
   TEXTMODE()
ENDDO