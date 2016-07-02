
*
* CLIPPER AXIS LABEL INTERFACE PROGRAM
*  This program allows you to have control from CLIPPER of the way the axis
*  looks. Please retain an original copy of the program.
*
* DRAWXSCALE:   PRINTS X AXIS SCALE
*
* FUNCTIONS:   RET_VALUE() returns the axis scale value
*              RET_XSIZE() returns the X axis scale number width.
*              RET_XDEC()  returns the number of decimal places.
*              SET_TYPE(0) returns X axis variable type. 0-numeric, 1-date,
*                          2-character.
*              QRETRIEVE() returns the label from the que file.
*
FUNCTION DRAWXSCALE
*
* print X axis scale.
*
DO CASE
*
* log scale and numeric type
*
   CASE SET_TYPE(0) = 0 .AND. SET_XLOG()=1
      X_SCALE( LTRIM( STR( RET_VALUE(), RET_XSIZE(), RET_XDEC() ) ), RET_VALUE() )
*
* date type
*
   CASE SET_TYPE(0) = 1
      X_SCALE( SUBSTR( DTOC( CTOD('01/01/00')+RET_VALUE() ), 1, 5 ), CTOD('01/01/00')+RET_VALUE() )
*
* numeric type
*
   CASE SET_TYPE(0)=0
      X_SCALE( LTRIM( STR( RET_VALUE(), RET_XSIZE(), RET_XDEC() ) ), RET_VALUE() )
*
* character type
*
   CASE SET_TYPE(0)=2
      X_SCALE( TRIM( QRETRIEVE(RET_VALUE() ) ), RET_VALUE() )

ENDCASE

RETURN(0)
*
*---------------------------------------------------------------------------
*
* DRAWYSCALE:   PRINTS Y AXIS SCALE
*
* FUNCTIONS:
*              RET_YSIZE() returns the Y axis scale number width.
*              RET_YDEC()    returns the number of decimal places.
*              QRETRIEVE() returns the label from the que file.
*
FUNCTION DRAWYSCALE
Y_SCALE(LTRIM(STR(RET_VALUE(),RET_YSIZE(RET_SIDE()),RET_YDEC(RET_SIDE()))),RET_VALUE())
RETURN(0)


