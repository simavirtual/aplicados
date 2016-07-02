*******************************************************************************
*  G_EXAM21.PRG                                                               *
*  Requirements: None                                                         *
*  Description:                                                               *
*       This is a simple example of a trig functions.                         *
*******************************************************************************
FLIP_INIT(60)
M_angle=0
M_horz=0
M_vert=0
CLEAR SCREEN
DO WHILE .T.
   @ 19,0 SAY "Enter angle in tenth's of degrees (0 - 3600) "GET M_angle PICT "9999"
   @ 21,0 SAY "Enter horizontal offset: "GET M_horz PICT "9999"
   @ 22,0 SAY "Enter vertical offset:   "GET M_vert PICT "9999"
   READ
   IF LASTKEY()=27
      EXIT
   ENDIF
   @ 10,10 SAY 'Sine =   '
   ?? SINE(M_angle)
   @ 11,10 SAY 'Cosine = '
   ?? COSINE(M_angle)
   @ 12,10 SAY 'Angle =  '
   ?? ARCTANGENT( M_horz, M_vert )
ENDDO