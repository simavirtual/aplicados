*********** Sample programs for CA-Clipper Tools / 5.2 ************
*
* Program     : VIRTUAL.PRG
* Copyright   : (c) 1991-93, Computer Associates International.
*               All rights reserved.
* Date        : 11/24/90
* Author      : Michael Peters / Lothar Bongartz
* Description : GET mask with 200 fields on virtual screen
* Compiling   : CLIPPER VIRTUAL
* Linking     : RTLINK FI VIRTUAL, CTUS LIB CT
* Remarks     :
*
* The program creates a virtual screen with 200 rows, where a get mask
* with 200 fields is shown ( 2 columns with 100 fields each and one
* space line). By moving the cursor to top or bottom of the screen,
* it will be scrolled automatically (if necessary and possible).
* This program shall demonstrate, how a virtual screen can be defined
* and scrolled automatically in dependance of the cursor position.
* Off course, this scrolling is not only valid in GET masks.
*
*******************************************************************

 CGA80()
 SET SCOREBOARD OFF

 SETMAXROW(199)
 DECLARE InVar[MAXROW() +1]

  FOR i =1 TO MAXROW() STEP 2
   InVar[i]    = i
   InVar[i +1] = i +1
   @i, 2 SAY "InVar_" +NTOC(i,    10, 3, "0") GET InVar[i]
   @i,42 SAY "InVar_" +NTOC(i +1, 10, 3, "0") GET InVar[i +1]
  NEXT i

 SETMAXROW(MAXROW(), 2)

 READ
RETURN