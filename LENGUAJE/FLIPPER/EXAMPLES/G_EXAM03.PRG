*******************************************************************************
*  G_EXAM03.PRG                                                               *
*  Author: Gary Prothero                                                      *
*  Requirements: None                                                         *
*  Description:                                                               *
*        This program demonstrates the calculation of the flipper buffer with *
*        INITDATA().  Simply type in the number of columns and it'll return   *
*        the number of rows that can be used with a 3000 byte buffer.  It also*
*        demonstrates the use of error handling, and returning errors that    *
*        occurred within your Flipper program.                                *
*  Chapter 2, Initialization and Setup                                        *
*******************************************************************************
FLIP_INIT(3000)
SET_SAYERR(1)
M_columns=2
INITDATA(M_columns)
DO WHILE .T.
   CLEAR
   TEXT
   ******************************************************************
   * Example of INITDATA(columns)                                   *
   *                                                                *
   * Parameters: columns - number of columns of data                *
   *                                                                *
   ******************************************************************
   ENDTEXT
*
   @ 8,10 SAY 'Calculate number of rows in buffer:'
   @ 10,10 SAY '3000 bytes initialized / '+LTRIM(STR(RET_COLS(),3,0))+' Columns / 8 bytes per number = '+LTRIM(STR(RET_ROWS(),3,0))+' Rows'
   @ 21,60 SAY 'Columns: '+STR(RET_COLS(),3,0)    && Return columns
   @ 22,60 SAY 'Rows:    '+STR(RET_ROWS(),3,0)    && Return rows
   @ 22,0 say 'Columns: 'GET M_columns PICT '99'
   READ
   IF LASTKEY()=27
      EXIT
   ENDIF
*
   INITDATA(M_columns)        && <----- INITDATA FUNCTION page 2-3
*
   IF RET_ERROR() > 0
      CLEAR
      TEXT
      The sound you just heard indicates an error!!! The function in which
      the error occurred and the error number can be returned with RET_ERROR()
      and RET_ERRFUN(). You can see I returned the error and function and
      displayed it below. Look up the error on pages 10-2 and 10-3. The error
      flag is reset to zero with the INITDATA function is issued again.
      ENDTEXT
      @ 20,20 SAY 'Error: '+STR(RET_ERROR(),2)+' Function: '+STR(RET_ERRFUN(),2)
      inkey(0)
   ENDIF
ENDDO
