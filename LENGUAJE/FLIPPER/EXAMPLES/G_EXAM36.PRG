*******************************************************************************
*  G_EXAM36.PRG                                                               *
*  Requirements: None                                                         *
*  Description:                                                               *
*        This program demonstrates how to place a point using coordinates     *
*        on the graph scale.                                                  *
*  Chapter 11, Viewport & Scaling Functions                                   *
*******************************************************************************
FLIP_INIT(1000)
M_x=3
M_y=50
*
DO WHILE .T.
   CLEAR
*
   @ 22,0 say 'Enter a screen coordinate position (x,y):'
   @ 22,43 get M_x pict '999'
   @ 22,50 get M_y pict '999'
   READ
*
   IF LASTKEY()=27
      QUIT
   ENDIF
*
   INITDATA(2)
   SET_TYPE(1,1)
   SET_AREA(10,10,90,90)
   STORE_DATA("< 1",83,45,23,15)
   STORE_DATA("1-5",124,76,45,20)
   STORE_DATA("6-10",89,56,34,16)
   STORE_DATA("11-18",45,34,23,12)
   STORE_DATA("19-55",34,23,12,8)
   STORE_DATA("> 55",125,82,67,20)
*
   PLOT()
*
   FLINE(ATX(M_x,1)-10, ATY(M_y,1), ATX(M_x,1)+10, ATY(M_y,1),14)
   FLINE(ATX(M_x,1), ATY(M_y,1)-10, ATX(M_x,1), ATY(M_y,1)+10,14)
*
   INKEY(0)
*
   TEXTMODE()
ENDDO
