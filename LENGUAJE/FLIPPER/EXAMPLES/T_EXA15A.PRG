*
* T_EXAM15.PRG
*
FLIP_INIT(6000)
HP_SETUP(1)                && Setup for LaserJet III
SET_SAYERR(1)

nFont1=FONT_OPEN("\FLIPPER\FONTS\RMN8_15.@")
nFont2=FONT_OPEN("\FLIPPER\FONTS\RMN8_26.@")
*
M_ans1 = 1
M_depth = 20               && Depth of the 3d wedge
M_tether = 1               && Line from edge to label 0-no, 1-yes
M_shove = 1                && Separate labels if overlaping 0-no, 1-yes
M_style = 1
M_fraction = 70
*
DO WHILE .T.
   SET CURSOR ON
   @ 15,0 SAY 'Type (1-6):         'GET M_ans1 PICT '9'
   @ 16,0 SAY '3d depth:           'GET M_depth PICT '99'
   @ 17,0 SAY 'Tether (0,1):       'GET M_tether PICT '9'
   @ 18,0 SAY 'Shove (0,1):        'GET M_shove PICT '9'
   @ 19,0 SAY 'Style (0,1,2):      'GET M_style PICT '9'
   @ 20,0 SAY 'Fraction (0 - 100): 'GET M_fraction PICT '999'
   READ
   IF LASTKEY()=27
      EXIT
   ENDIF
*
   M_ans=1
   @ 22,0 SAY 'Output: '
   @ 22,col()+2 PROMPT 'Screen'
   @ 22,col()+2 PROMPT 'Printer'
   @ 22,col()+2 PROMPT 'File'
   MENU TO M_ans
   IF LASTKEY()=27
      EXIT
   ENDIF
*
   FLP_RESET()
   INITDATA(5)
*
   SET_G_FONT(nFont2)
   SET_L_FONT(nFont1)
*                           Colors Style Explode
*                            ------ ----- -------
   STORE_DATA("IBM",   10000, 14,     5,     0)
   STORE_DATA("MAC",    90,    1,     6,     0)
   STORE_DATA("COMPAQ", 50,    5,     7,     0)
   STORE_DATA("AMIGA",  70,   10,     8,     0)
   STORE_DATA("EPSON",  40,   13,     9,    20)
   STORE_DATA("IBM",   10000, 14,     5,     0)
   STORE_DATA("MAC",    9000,  1,     6,     0)
   STORE_DATA("COMPAQ", 5000,  5,     7,     0)
   STORE_DATA("AMIGA",  7000, 10,     8,     0)
   STORE_DATA("EPSON",  4000, 13,     9,    20)
*
   IF M_ans = 2
      HP_OPEN('LJIII')
   ELSEIF M_ans = 3
      HP_OPEN('LJIII_FILE')
   ENDIF
*
   PIE_3D( M_depth, M_shove, M_tether, M_style, M_fraction )
*
   DO CASE
      CASE M_ans1 = 1
         G_LABEL("This is a standard PIE chart")
         PIE(1)
      CASE M_ans1 = 2
         G_LABEL("Labels set to 20")
         PIE_COLORS(2)
         PIE_STYLE(3)
         PIE_EXPLOD(4)
         PIE_LABEL(20)
         PIE( 1, 50, 50, 25 )
      CASE M_ans1 = 3
         G_LABEL( "PIE( 1, 25, 25, 6)" )
         PIE( 1, 25, 25, 5 )
      CASE M_ans1 = 4
         G_LABEL( "PIE_ROTATE(5000)" )
         PIE_ROTATE(5000)
         PIE( 1 )
      CASE M_ans1 = 5
         G_LABEL( "PIE_ASPECT( 0.6 )" )
         PIE_ASPECT(0.6)
         PIE( 1, 50, 50 )
         PIE_ASPECT(1.0)
      CASE M_ans1 = 6
         G_LABEL( "PIE_ASPECT( 1.2 )" )
         PIE_ASPECT(1.2)
         PIE( 1, 40, 40, 20 )
         PIE_ASPECT(1.0)
   ENDCASE

   IF M_ans > 1
      LJ3_EJECT()
      HP_CLOSE()
   ELSE
      inkey(0)
   ENDIF
   TEXTMODE()
ENDDO
