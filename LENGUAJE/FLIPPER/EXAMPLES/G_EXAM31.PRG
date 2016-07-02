*******************************************************************************
*  G_EXAM31.PRG                                                               *
*  Requirements: None                                                         *
*  Description:                                                               *
*        This function demonstrates the use of the SPLINE() function, which   *
*        can fit a curve through specified points.                            *
*                                                                             *
*        SPLINE(nYColumn,[nType],[nIncrement],[nTension],[nPixRes],[nRndRes]) *
*             nType - 0-near points, 1-through points                         *
*             nIncrement - number of segments 0.05 = 20 segments (default)    *
*                                             0.01 = 100 segments             *
*                                             0.10 = 10 segment               *
*             nTension - type 1:closeness of curve to points 0.1 - 0.9        *
*             nPixRes - draw after nPixRes pixels from starting point         *
*             nRndRes - draw when rounding of point is less than nRndRes      *
*                                                                             *
*  Chapter 6, Additional Features After the Graph is Displayed                *
*******************************************************************************
FLIP_INIT(6000)
PS_SETUP()                && Setup for postscript
*
max_fh=FONT_OPEN("\flipper\fonts\RMN8_21.@")
max_fh=FONT_OPEN("\flipper\fonts\RMN8_30.@")
*
INITDATA(2)
SET_TYPE(1,5)
*
STORE_DATA(100, 30)
STORE_DATA(130, 35)
STORE_DATA(180, 45)
STORE_DATA(225, 55)
STORE_DATA(270, 70)
STORE_DATA(280, 85)
STORE_DATA(365, 105)
STORE_DATA(420, 130)
STORE_DATA(480, 220)
STORE_DATA(520, 230)
STORE_DATA(557, 300)
STORE_DATA(580, 385)
STORE_DATA(600, 470)
*
spl   = 1
tens  = 0.5
seg   = 0.05
resol = 3
rnd = 0.2
*
DO WHILE .T.
   @ 16,15 SAY "Spline type:         " get spl picture "9"
   @ 17,15 SAY "Tension:             " get tens picture "99.99"
   @ 18,15 SAY "Segments:            " get seg picture "9.999"
   @ 19,15 SAY "Pixel resolution:    " get resol picture "9"
   @ 20,15 SAY "Rounding resolution: " get rnd picture "9.99"
   READ
   IF LASTKEY()=27
      EXIT
   ENDIF
*
   M_ans=1
   @ 22,0 SAY 'Output: '
   @ 22,col()+2 PROMPT 'Screen'
   @ 22,col()+2 PROMPT 'Postscript printer'
   @ 22,col()+2 PROMPT 'Postscript file'
   MENU TO M_ans
   IF LASTKEY()=27
      EXIT
   ENDIF
   G_LABEL("SPLINE fits curve through points")
   SET_G_FONT(4)
   SET_S_FONT(3)
*
   IF M_ans = 2
      PS_OPEN('LPT1')
   ELSEIF M_ans = 3
      PS_OPEN('FILE')
   ENDIF
*
   PLOT()
*
   SPLINE(1, spl, seg, tens, resol, rnd)         && Through points
*
   IF M_ans > 1
      PS_EJECT()
      PS_CLOSE()
   ELSE
      inkey(0)
   ENDIF
*
   TEXTMODE()
ENDDO
