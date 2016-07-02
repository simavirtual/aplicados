*******************************************************************************
*  G_EXAM09.PRG                                                               *
*  Requirements: None                                                         *
*  Description:                                                               *
*        This program demonstrates the use of the SET_TYPE() command.  It     *
*        allows you to set the different graph types in Flipper.  Graph types *
*        inclued line, point, bar, stacked bar, and pie.                      *
*  Chapter 3, Customizing the Graph                                           *
*******************************************************************************
FLIP_INIT(600)
HP_SETUP(0,1,9600,0,8,1)
M_out=0
M_type=1
DO WHILE .T.
   INITDATA(2)
   CLEAR
   TEXT
   ************************************************************************
   *        SET_TYPE(column,type)                                         *
   *                                column- y column value                *
   *                                type  - type graph  1-line            *
   *                                                    2-area            *
   *                                                    3-bar             *
   *                                                    4-stacked         *
   *                                                    5-point           *
   *                                                   >5-pie             *
   *                                                                      *
   *        The X value is automatically set. SET_TYPE(0)  0 - numeric    *
   *                                                       1 - date       *
   *                                                       2 - character  *
   ************************************************************************
   ENDTEXT
*
   @ 18,10 SAY 'X axis type: '+STR(SET_TYPE(0),1,0)
   @ 19,10 SAY 'Y axis type: '+STR(SET_TYPE(1),1,0)
   @ 21,0 say 'Output: 'GET M_out PICT '9'
   @ 22,0 say 'Type:   'GET M_type PICT '9' valid M_type > 0 .AND. M_type < 10
   READ
*
   IF LASTKEY()=27
      EXIT
   ENDIF
*
   SET_TYPE(1,M_type)
   STORE_DATA('Jan',3)
   STORE_DATA('Feb',5)
   STORE_DATA('Mar',7)
   STORE_DATA('Apr',3)
   STORE_DATA('May',3.51)
   STORE_DATA('Jun',5)
   STORE_DATA('Jul',6.3)
   STORE_DATA('Aug',3)
   STORE_DATA('Sep',4.5)
   STORE_DATA('Oct',8.5)
   STORE_DATA('Nov',10.2)
   STORE_DATA('Dec',11.5)
*
   HP_OPEN(IF(M_out=0,"SCREEN",IF(M_out=1,"PLOTTER","FILE")))
   IF M_type > 5
      PIE(1)
   ELSE
      PLOT()
   ENDIF
   IF M_out=0
      INKEY(0)
   ELSE
      HP_CLOSE()
   ENDIF
   TEXTMODE()
*
ENDDO
