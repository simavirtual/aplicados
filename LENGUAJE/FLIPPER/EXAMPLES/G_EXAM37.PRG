*******************************************************************************
*  G_EXAM37.PRG                                                               *
*  Requirements: None                                                         *
*  Description:                                                               *
*        This example demonstrates the use of the viewport scaling functions. *
*        I shows how when you change different attributes for the SET_WORLD() *
*        function, how a line can change position and size, all using the same*
*        parameters in the FLINE() command.  What changes the line's shape is *
*        the changing of the scale for the viewport.                          *
*  Chapter 11, Viewport & Scaling Functions                                   *
*******************************************************************************
FLIP_INIT(1000)
SET_SAYERR(1)
*
M_horz=100
M_vert=100
M_x_origin=0
M_y_origin=0
M_x_dir=1
M_y_dir=1
M_x1=10
M_y1=10
M_x2=90
M_y2=90
*
DO WHILE .T.
   CLEAR
   TEXT
   ************************************************************************
   * Example 37: Viewport scaling                                         *
   *                                                                      *
   *  1. First tap PgDn to see the standard plot.                         *
   *  2. Next, enter -1 for Ydir (notice the direction of the line        *
   *  3. Change the Xorg and Yorg to 10,10 (notice the new line position) *
   *  4. Play with other values and see the result                        *
   ************************************************************************
   ENDTEXT
*
   @ 12,10 say 'Viewport Scaling'
   @ 13,12 SAY 'Xscale: 'GET M_horz PICT '999'
   @ 14,12 SAY 'Yscale: 'GET M_vert PICT '999'
   @ 15,12 SAY 'Xorg:   'GET M_x_origin PICT '999'
   @ 16,12 SAY 'Yorg:   'GET M_y_origin PICT '999'
   @ 17,12 SAY 'Xdir:   'GET M_x_dir PICT '99'
   @ 18,12 SAY 'Ydir:   'GET M_y_dir PICT '99'
   @ 21,12 SAY 'x1, y1: 'GET M_x1 pict '999'
   @ 21,col()+2 GET M_y1 pict '999'
   @ 22,12 SAY 'x2, y2: 'GET M_x2 pict '999'
   @ 22,col()+2 GET M_y2 pict '999'
   READ
*
   IF LASTKEY()=27
      QUIT
   ENDIF
*
   FSCREEN()
*
   vw_handle=VIEW_OPEN(320,0,639,175,2,0)
   SET_WORLD(M_horz,M_vert,M_x_origin,M_y_origin,M_x_dir,M_y_dir)
*
   FLINE( ATX(M_x1,0), ATY(M_y1,0), ATX(M_x2,0), ATY(M_y2,0), 14)
*
   INKEY(0)
*
   VIEW_CLOSE(vw_handle, 0)
*
   TEXTMODE()
ENDDO
