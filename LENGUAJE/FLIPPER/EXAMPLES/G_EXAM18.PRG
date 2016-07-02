*******************************************************************************
*  G_EXAM18.PRG                                                               *
*  Requirements: None                                                         *
*  Description:                                                               *
*        This program demonstrates the use of STORE_VAL() to store a value to *
*        the specified row,column pair in the buffer.                         *
*  Chapter 4, Data Storage                                                    *
*******************************************************************************
FLIP_INIT(1000)
M_row=1
M_column=1
M_value=0
DO WHILE .T.
   CLEAR
   TEXT
   ************************************************************************
   * Example of STORE_VAL function                                        *
   *                                                                      *
   *       STORE_VAL(row, column, value)                                  *
   *                                                                      *
   * This is an example of using STORE_VAL and AUTO_SCALE. You can store  *
   * a single value into the buffer after it is filled with data. A graph *
   * will be displayed, then after you tap the space bar you will have    *
   * the opportunity to enter a single value into the buffer. The graph   *
   * will be re-scaled with AUTO_SCALE and re-displayed.                  *
   *                                                                      *
   ************************************************************************
   ENDTEXT
   inkey(0)
*
   INITDATA(3)
*
   SET_TYPE(1,1)
   SET_TYPE(2,1)
*
   STORE_DATA(1,2,5)
   STORE_DATA(3,4,8)
   STORE_DATA(8,3,2)
   STORE_DATA(12,1,3)
   STORE_DATA(17,0,2)
   STORE_DATA(19,-2,1)
   STORE_DATA(30,1,-1)
   STORE_DATA(38,1,2)
   STORE_DATA(42,2,1)
   STORE_DATA(57,0,2)
*
   G_LABEL('Place single value in the buffer')
*
   DO WHILE .T.
*
      PLOT()
      INKEY(0)
*
      TEXTMODE()
*
      CLEAR SCREEN
      ? 'Row  '
      ?? 'Column 0  '
      ?? 'Column 1  '
      ?? 'Column 2  '
      ? '---  '
      ?? '--------  '
      ?? '--------  '
      ?? '--------  '
      FOR I=1 TO RET_COUNT()
         ? TRANSFORM(I,'999')
         ?? '  '
         ?? TRANSFORM(STORE_VAL(I,0),'99999999')
         ?? '  '
         ?? TRANSFORM(STORE_VAL(I,1),'99999999')
         ?? '  '
         ?? TRANSFORM(STORE_VAL(I,2),'99999999')
      NEXT
*
      @ 18,0 SAY 'Change a buffer value:'
      @ 20,0 say 'Row:    'GET M_row PICT '999'
      @ 21,0 say 'Column: 'GET M_column PICT '999' range 0,RET_COLS()-1
      @ 22,0 say 'Value:  'GET M_value PICT '999'
      READ
      IF LASTKEY()=27
         EXIT
      ENDIF
*
      STORE_VAL(M_row,M_column,M_value)
      AUTO_SCALE()
*
   ENDDO
   EXIT
ENDDO
