*******************************************************************************
*  G_EXAM15.PRG                                                               *
*  Requirements: None                                                         *
*  Description:                                                               *
*        This program demonstrates how to set up your own axis scale.  You can*
*        set axis labels and tick marks off or on and you can even make your  *
*        own.                                                                 *
*  Chapter 3, Customizing the Graph                                           *
*******************************************************************************
FLIP_INIT(1000)
*
NO=0
YES=1
M_xgone=NO
M_ygone=NO
M_xtick=YES
M_ytick=YES
M_Xlabel=0
M_Ylabel=0
SET_BOXOFF(YES)         && Turn frame off for graph
*
DO WHILE .T.
   CLEAR
   TEXT
******************************************************************************
* EXAMPLE OF AXIS PARAMETERS:                                                *
*  SET_XGONE()  - set X axis off            (default NO=0)                   *
*  SET_YGONE()  - set Y axis off            (default NO=0)                   *
*  SET_XTICK()  - set X axis tick marks off (default YES=1)                  *
*  SET_YTICK()  - set Y axis tick marks off (default YES=1)                  *
*  X_SCALE()    - These two functions are used in the GRAPHICS.PRG to place  *
*  Y_SCALE()      the X and Y axis labels. You can use them to design your   *
*                 own axis. We will introduce them in this example, and you  *
*                 can look at GRAPHICS.PRG for more detailed application.    *
*                                                                            *
*  If the X axis or Y axis are turned off, the program ask if you wish to    *
*  place a label on the axis. If a number is enter between the maximum and   *
*  minimum values, then a label will be placed in that position.             *
*  Frame was turned off with SET_BOXOFF(YES)                                 *
******************************************************************************
   ENDTEXT
   INITDATA(3)
*
   @ 17,0 SAY 'Set X axis off (1,0):   'GET M_xgone PICT '9'
   @ 18,0 SAY 'Set Y axis off (1,0):   'GET M_ygone PICT '9'
   @ 19,0 SAY 'Set X ticks on? 1,0):   'GET M_xtick PICT '9'
   @ 20,0 SAY 'Set Y ticks on? (1,0):  'GET M_ytick PICT '9'
   READ
   IF LASTKEY()=27
      EXIT
   ENDIF
*
   IF M_Xgone=YES
      M_Xlabel=5
      @ 21,0 SAY 'Place X label at: 'GET M_Xlabel pict '99'
      READ
   ENDIF
*
   IF M_Ygone=YES
      M_Ylabel=5
      @ 22,0 SAY 'Place Y label at: 'GET M_Ylabel pict '99'
      READ
   ENDIF
 *
   SET_XGONE(M_xgone)
   SET_YGONE(M_ygone)
   SET_Xtick(M_xtick)
   SET_Ytick(M_ytick)
*
   SET_TYPE(1,1)
   SET_TYPE(2,1)
   USE TEST
   DO WHILE .not. EOF()
      @ 23,0 SAY STORE_DATA(xnumber,number1,number2)
      SKIP
   ENDDO
   *
   PLOT()
*
   IF M_Xlabel>0 .and. SET_XGONE()=1
      X_SCALE(LTRIM(STR(M_Xlabel,RET_XSIZE(),RET_XDEC())),M_Xlabel)
   ENDIF
*
   IF M_Ylabel>0 .and. SET_YGONE()=1
      Y_SCALE(LTRIM(STR(M_Ylabel,RET_YSIZE(),RET_YDEC())),M_Ylabel)
   ENDIF
*
   inkey(0)
   TEXTMODE()
ENDDO

