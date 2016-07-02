*******************************************************************************
*  G_EXAM10.PRG                                                               *
*  Requirements: None                                                         *
*  Description:                                                               *
*        This program demonstrates how to use the SET_XLOG() and SET_YLOG()   *
*        functions.  These functions use a log scale instead of a linear      *
*        scale.                                                               *
*  Chapter 3, Customizing the Graph                                           *
*******************************************************************************
FLIP_INIT(600)
HP_SETUP(0,1,9600,0,8,1)
M_log=0
M_y1=1
m_y2=10000
M_type=1
M_out=0
M_style=1
M_line=0
max_fh=FONT_OPEN("\FLIPPER\FONTS\TTL09_33.@")
SET PRINT ON
SET PRINT OFF
SET CONSOLE ON
SET CONSOLE OFF
DO WHILE .T.
   CLEAR SCREEN
   TEXT
   *******************************************************************
   * Example: SET_XLOG()                                             *
   *          SET_YLOG()                                             *
   *                                                                 *
   *           Data in buffer:     X          Y                      *
   *                             ----      -----                     *
   *                                1          3                     *
   *                                2         50                     *
   *                                5       1000                     *
   *                               12       3000                     *
   *                               50      10000                     *
   *                              123      13000                     *
   *******************************************************************
   ENDTEXT

   INITDATA(2)
   FLP_RESET()
*
   @ 18,0 say 'Output: 'GET M_out PICT '9'
   @ 19,0 say 'Type: 'GET M_type PICT '9'
   @ 20,0 say 'Line pattern: 'GET M_line PICT '99'
   @ 21,0 say 'Style:        'GET M_style PICT '99'
   @ 22,0 say 'Log: (0-numeric scale, 1-X log, 2-Y log, 3-both log): 'GET M_log PICT '9'
   READ
*
   IF LASTKEY()=27
      EXIT
   ENDIF
*
   SET_XLOG(0)
   SET_YLOG(0)
   DO CASE
      CASE M_log=1
         SET_XLOG(1)
      CASE M_log=2
         SET_YLOG(1)
      CASE M_log=3
         SET_XLOG(1)
         SET_YLOG(1)
   ENDCASE
*
   SET_TYPE(1,M_type)
*
   STORE_DATA(1,3)
   STORE_DATA(2,50)
   STORE_DATA(5,1000)
   STORE_DATA(12,3000)
   STORE_DATA(50,10000)
   STORE_DATA(123,13000)
*
   SET_STYLE(1, M_style)
   SET_LN_PAT(1,M_line)
*
   HP_OPEN(IF(M_out=0,"SCREEN",IF(M_out=1,"PLOTTER","FILE")))
   PLOT()

   IF M_out=0
      INKEY(0)
   ELSE
      HP_CLOSE()
   ENDIF

   TEXTMODE()
ENDDO