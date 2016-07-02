*******************************************************************************
*  C_EXAM7D.PRG                                                               *
*  Requirements: None                                                         *
*  Description:                                                               *
*        This program demonstrates the interupt driven communications driver  *
*        used to pull information back from the plotter.                      *
*******************************************************************************
FLIP_INIT(600)
HP_SETUP(0)
M_out=0
M_patno = 0
M_pat = 0
M_patlen = 1.0
CLEAR SCREEN

DO WHILE .T.
   SET CURSOR ON
   @ 22,0 say 'Output: (0-Screen, 1-Plotter, 2-File)  'GET M_out PICT '9'
   READ
*
   IF LASTKEY()=27
      EXIT
   ENDIF

   IF M_out =0
      HP_OPEN("SCREEN")
   ELSEIF M_out=1
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
   ELSE
      HP_OPEN("FILE")
   ENDIF
*
   FSCREEN()
*
* Drawing lines
*
   FPSET( 10, 10, 1 )
   FLINE( 20, 20, 100, 100, 2 )
   PLINE( 160, 60, 100, 2700, 5 )
   FBOX( 30, 30, 200, 200, 3 )
   FCIRCL_ARC(400, 400, 100, 250, 1500, 4 )
   FOVAL_ARC(100, 300, 70, 100, 150, 1200, 4 )

   FOR I = 0 TO 10
      PAT_SETLIN( I )
      FLINE( 10, I*5+300, 630, I*5+300, 15-I )
   NEXT
   PAT_SETLIN( 0 )

    FOR I = 0 TO 12
       SAY_MARK( I*30+30, 400, I, 15-I )
    NEXT

    IF M_out = 0
       inkey(0)
       CLS_SCREEN()
    ENDIF
 *
 *  Drawing fill figures
 *
    FOR I = 0 TO 10
       PAT_SETFIL( I )
       FBOX( I*50+50, 75, I*50+90, 100, 15-I )
    NEXT
    PAT_SETFIL( 0 )

    M_POINTS := { 0, 0, 20, 0, 28, 40, 16, 30, 0, 0 }
    FOR I = 0 TO 10
       PAT_SETFIL(I)
       FPOLY_LINE( I*50+50, 140, M_POINTS, 15-I)
    NEXT
    PAT_SETFIL( 0 )

    FOR I = 0 TO 10
       PAT_SETFIL( I )
       FCIRCLE( I*50+50, 230, 20, 15-I )
    NEXT
    PAT_SETFIL( 0 )

    FOR I = 0 TO 10
       PAT_SETFIL( I )
       FPIE( I*50+50, 300, 20, 250, 1800, 15-I )
    NEXT
    PAT_SETFIL( 0 )

    FOR I = 0 TO 10
       PAT_SETFIL( I )
       FOVAL( I*50+50, 370, 20, 15, 15-I )
    NEXT
    PAT_SETFIL( 0 )

   IF M_out = 0
      inkey(0)
      CLS_SCREEN()
   ELSEIF M_out = 1
      ICOM_CLOSE()
      HP_CLOSE()
   ELSE
      HP_CLOSE()
   ENDIF
   TEXTMODE()
ENDDO
