*********** Sample programs for Nantucket Tools II / 5.01 ********
*
* Program     : COLOBOX.PRG
* Copyright   : (c) 1991, Nantucket  Corp.  All rights reserved.
* Date        : 01/11/90
* Author      : Lothar Bongartz
* Description : Examples for multi color boxes
* Compiling   : CLIPPER COLOBOX
* Linking     : RTLINK FI COLOBOX, NT2US50 LIB NT250
* Remarks     : There are only created color areas, no windows!
*
*******************************************************************

CLEAR SCREEN

 COLORBOX(02, 05, 09, 60, "/b", "/gr")
 COLORBOX(01, 25, 17, 53, "/bg", "/rb")
 COLORBOX(10, 10, 20, 20, "/r", "/b")
 COLORBOX(15, 15, 22, 50, "/g", "/r")
 COLORBOX(15, 52, 22, 70, "/w+", "/gr")

 @ MAXROW(), 0 SAY CENTER("Examples for colored boxes  Ù")
 INKEY(0)
RETURN

FUNCTION COLORBOX
PARAMETERS u_row, u_col, b_row, b_col, out_color, in_color

  COLORWIN(u_row, u_col, b_row, b_col, out_color)

RETURN( COLORWIN(u_row +1, u_col +1, b_row -1, b_col -1, in_color) )

