*******************************************************************************
*  G_EXAM30.PRG                                                               *
*  Requirements: None                                                         *
*  Description:                                                               *
*        This program demonstrates the use of multiple cycles with log        *
*        scaling.  It also uses two separate y-axis.                          *
*  Chapter3, Customizing the Graph                                            *
*******************************************************************************
FLIP_INIT(6000)
SET_SAYERR(1)
M_cycle=3
DO WHILE .T.
   CLEAR
   @ 22,0 SAY 'Set number of cycles: 'GET M_cycle PICT '9'
   READ
   IF LASTKEY()=27
      EXIT
   ENDIF
*
   INITDATA(3)
*
   SET_YLOG(1,1)
   SET_YLOG(1,2)
*
   SET_TYPE(1,1)
   SET_TYPE(2,1)
   SET_YSIDE(2,2)
   SET_GRID(1,1)
*
   STORE_DATA(1,300,0.00001)
   STORE_DATA(2,560,0.00005)
   STORE_DATA(5,1000,0.0001)
   STORE_DATA(12,3000,0.0012)
   STORE_DATA(50,10000,0.0016)
   STORE_DATA(123,13000,0.009)
*
*  To manually set the number of cycles
*
   SET_YMAN(1)                      && Set ON manual scaling left axis
   SET_YMIN(0)                      && Set minimum to 0 calculates
                                    &&   the number of cycles from the maximum
   SET_YMAX(10000)                  && Set maximum to 10,000
   SET_YINC(M_cycle)                && Set number of cycles
*
   SET_YMAN(1,2)                    && Set ON manual scaling right axis
   SET_YMIN(0.001,2)                && Set minimum to 0.001
   SET_YMAX(0,2)                    && Set maximum to 0 which indicates
                                    &&   to set number of cycles from minimum
   SET_YINC(M_cycle,2)              && Set number of cycles
*
* ***************************
*
   PLOT()
   INKEY(0)
   TEXTMODE()
ENDDO
