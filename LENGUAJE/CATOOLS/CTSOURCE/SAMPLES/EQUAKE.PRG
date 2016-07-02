*********** Sample programs for CA-Clipper Tools / 5.2 ************
*
* Program     : EQUAKE.PRG
* Copyright   : (c) 1991-93, Computer Associates International.
*               All rights reserved.
* Date        : 08/23/90
* Author      : Lothar Bongartz / Michael Peters
* Description : The screen will be moved pixelwise.
*               You will get the impression of a little
*               earthquake.
*               With the function EGAPALETTE (19, <n>) the screen will
*               be moved <n> pixel to the left.
*
*                n      pixel moving
*                -------------------
*                0        1
*                1        2
*                2        3
*                3        4
*                4        5
*                5        6
*                6        7
*                7        8
*
*                8   (reset)
*
* Compiling   : CLIPPER EQUAKE
* Linking     : RTLINK FI EQUAKE LIB CT
*
* Remarks     : The procedure has been tested with different EGA-
*               and VGA-adapters, but we can't assure that it is
*               working with any type of these adapters.
*
*********************************************************************
 EARTHQUAKE()
RETURN


//* function EARTHQUAKE *//

FUNCTION EARTHQUAKE
 LOCAL i, cPict

 IF ISEGA()
    WAITPERIOD(100)
    SAVE SCREEN TO cPict
    RESTORE SCREEN FROM LEFT(cPict, 2) + cPict

    DO WHILE WAITPERIOD()
       FOR i = 0 TO 7
        EGAPALETTE (19, i)
       NEXT

       FOR i = 6 TO 0 STEP -1
        EGAPALETTE (19, i)
       NEXT

       EGAPALETTE (19, 8)
    ENDDO

    MILLISEC(10)
    RESTORE SCREEN FROM cPict
 ELSE
    CLEAR
    ?
    ?
    ? "Can only be used on EGA- and VGA-adapters !"
    ?
 ENDIF
RETURN

