*******************************************************************************
*  C_EXAM7I.PRG                                                               *
*  Requirements: None                                                         *
*  Description:                                                               *
*        This program demonstrates the interupt driven communications driver  *
*        used to pull information back from the plotter.                      *
*******************************************************************************
FLIP_INIT(2000)
INITDATA(5)
*                           Colors Style Explode
*                            ------ ----- -------
STORE_DATA("IBM",    10000, 14,     5,     0)
STORE_DATA("MAC",    90,     1,     6,     0)
STORE_DATA("COMPAQ", 50,     5,     7,     0)
STORE_DATA("AMIGA",  70,    10,     8,     0)
STORE_DATA("EPSON",  40,    13,     9,    20)
STORE_DATA("NEXT",   10000, 14,     5,     0)
STORE_DATA("UNIX",   9000,   1,     6,     0)
STORE_DATA("BENTLEY",5000,   5,     7,     0)
STORE_DATA("PCBRAND",7000,  10,     8,     0)
STORE_DATA("DELL",   4000,  13,     9,    20)
*
M_out=0
M_patno = 0
M_pat = 0
M_patlen = 1.0
CLEAR SCREEN

DO WHILE .T.
   SET CURSOR ON
   @ 22,0 say 'Output: (0-Screen, 1-Plotter, 2-LPT1, 3-LJIII, 4-File)  'GET M_out PICT '9'
   READ
*
   IF LASTKEY()=27
      EXIT
   ENDIF

   IF M_out =0
      HP_OPEN("SCREEN")
   ELSEIF M_out=1
      HP_SETUP(0)          && HPGL
      ICOM_OPEN( 1, 9600, asc('D'), asc('N'), 1, asc('D') )
      @ 10,0 SAY ICOM_READ( "OE;" )                 && Check for plotter error
      FOR I= 0 TO 8
         J = ICOM_ERROR(I)
         IF J > 0
            ? 'Error: '
            ?? I
         ENDIF
      NEXT
      @ 11,0 SAY ICOM_READ( chr(27)+".E" )
      HP_OPEN("PLOTTER")
   ELSEIF M_out=2
      HP_SETUP(0)          && HPGL
      HP_OPEN("LPT1")
   ELSEIF M_out=3
      HP_SETUP(1)          && HPGL/2
      HP_OPEN("LJIII")
   ELSE
      HP_SETUP(0)          && HPGL
      HP_OPEN("FILE")
   ENDIF
*
   PIE_3D( 20 )
   G_LABEL( "PIE_ASPECT( 0.6 )" )
   PIE_ASPECT(0.6)
   PIE( 1, 50, 50 )
   PIE_ASPECT(1.0)
*
   IF M_out = 0
      inkey(0)
      CLS_SCREEN()
   ELSEIF M_out = 1
      ICOM_CLOSE()
      HP_CLOSE()
   ELSEIF M_out = 3
      LJ3_EJECT()
   ELSE
      HP_CLOSE()
   ENDIF
   TEXTMODE()
ENDDO
