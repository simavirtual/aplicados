*********** Sample programs for Nantucket Tools II / 5.01 *********
*
* Program     : INDICATE.PRG
* Copyright   : (c) 1991, Nantucket  Corp.  All rights reserved.
* Date        : 10/24/90
* Author      : Michael Peters / Lothar Bongartz
* Description : Display of indicators for CAPS-, SCROLL-, NUM-LOCK
* Compiling   : CLIPPER INDICATE
* Linking     : RTLINK FI INDICATE LIB NT250
* Remarks     :
*
* An automatical status display of CAPS-LOCK, NUM-LOCK and
* SCROLL-LOCK, completely handled in backround.
*
*******************************************************************

* All color attributes have been selected independent of any
* esthetic criterion ......

  IF ISCOLOR()
   cAttrib1 := "W/B"
   cAttrib2 := "R/G"
   cAttrib3 := "GR+/B"
   cAttrib4 := "W/R"
   cAttrib5 := "W/B"
   cAttrib6 := "R/B"
  ELSE
   cAttrib1 := "W/N"
   cAttrib2 := "W+/N"
   cAttrib3 := "W/N"
   cAttrib4 := "W*/N"
   cAttrib5 := "W/N"
   cAttrib6 := "N/W"
  ENDIF

  SHOWKEY("C", 24, 15, " UPPER     ", " LOWER      ", cAttrib1, cAttrib2)
  SHOWKEY("N", 24, 35, " CALC      ", " WRITE      ", cAttrib3, cAttrib4)
  SHOWKEY("S", 24, 55, " SCROLL ON ", " SCROLL OFF ", cAttrib5, cAttrib6)

 * The supervision of the three shift keys happens automatically!

 CLS
  cVar1 = [A standard GET field. Please use the NUM, LOCK,               ]
  cVar2 = [SCROLL LOCK or CAPS LOCK key to change the indicators!        ]

  @ 10, 10 GET cVar1
  @ 11, 10 GET cVar2
  READ

 * The supervision of NUM LOCK will be stopped

  SHOWKEY("N")

 CLS
  cVar1 = [ The supervision of NUM LOCK has been stopped by calling      ]
  cVar2 = [ the function SCHOWKEY("N").                                  ]

  @ 10, 10 GET cVar1
  @ 11, 10 GET cVar2
  READ

 * All supervisions of shift keys will be stopped

  SHOWKEY()

 CLS
  cVar1 = [  The supervision of NUM, SCROLL and CAPS LOCK has been       ]
  cVar2 = [  stopped by calling the function SCHOWKEY().                 ]

  @ 10, 10 GET cVar1
  @ 11, 10 GET cVar2
  READ

RETURN
