*******************************************************************************
*  G_EXAM20.PRG                                                               *
*  Requirements: None                                                         *
*  Description:                                                               *
*        This program demonstrates the use of the missing value functions.    *
*        With these functions you can have a great amount of control on how   *
*        the missing values are found and how they are shown on the screen.   *
*  Chapter 3, Customizing the Graph                                           *
*******************************************************************************
FLIP_INIT(1000)
M_missing=0.00
M_type=0
M_misstyle=0
ON=1
OFF=0
*
DO WHILE .T.
   CLEAR
   TEXT
   ***********************************************************************
   * Example of setting missing values                                   *
   *                                                                     *
   *  SET_MISSING()    types  0 - no missing values                      *
   *  SET_MVALUE()            1 - eliminate values = missing             *
   *                          2 - eliminate values < missing             *
   *  <--Data-->              3 - eliminate values > missing             *
   *   X  Y1  Y2              4 - same as one but include X column 0     *
   *   1   2   5                                                         *
   *   3   4   8                                                         *
   *   8  16  12                                                         *
   *  12  12  18                                                         *
   *  17   8   2                                                         *
   ***********************************************************************
   ENDTEXT
   INITDATA(3)
*
   @ 20,0 SAY 'Missing type:      'GET M_type PICT '9' VALID M_type < 5
   @ 21,0 SAY 'Set missing value: 'GET M_missing
   @ 22,0 SAY 'Set missing style: 'GET M_misstyle PICT '9' VALID M_misstyle < 2
   READ
   IF LASTKEY()=27
      EXIT
   ENDIF
*
   SET_TYPE(1,1)
   SET_TYPE(2,1)
*
   STORE_DATA(1, 2,  5)
   STORE_DATA(3, 4,  8)
   STORE_DATA(8, 16,12)
   STORE_DATA(12,12,18)
   STORE_DATA(17, 8, 2)
*
   SET_XSPACE(ON)
   SET_YSPACE(ON)
   SET_MISS(0)
   G_LABEL('Original graph with no missing values')
   PLOT()
   INKEY(0)
*
   SET_MISS(M_type)
   SET_MVALUE(M_missing)
   SET_MSTYLE(M_misstyle)
   CLS_SCREEN()
   G_LABEL('New graph with missing values')
   PLOT()
   INKEY(0)
*
   TEXTMODE()
ENDDO
