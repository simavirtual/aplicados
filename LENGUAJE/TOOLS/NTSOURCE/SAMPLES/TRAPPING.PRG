*********** Sample programs for Nantucket Tools II / 5.0 ************
*
* Program     : TRAPPING.PRG
* Copyright   : (c) 1991, Nantucket  Corp.  All rights reserved
* Date        : 12/12/90
* Author      : Lothar Bongartz / Michael Peters
* Description : Example for traps on any key
* Compiling   : CLIPPER TRAPPING
* Linking     : RTLINK FI TRAPPING, NT2US50 LIB NT250
* Remarks     : Start the program and enter  USA
*
*******************************************************************

 CLS

 cKeyVar := ""               // variable for 'history'
 SET TYPEAHEAD TO 200        // enough buffer is important

 TRAPANYKEY("GETIT")         // define the TRAP procedure

 cInVar := SPACE(70)         // an input mask as example
 @ 1, 0 GET cInVar
 READ
RETURN

 PROCEDURE GETIT
 PARAMETER nKey
 cKeyVar := RIGHT(cKeyVar + CHR(nKey), 3)
  IF UPPER(cKeyVar) == "USA"
   KEYSEND(CHARMIX(CHR(8)+CHR(8) + "United States of America", CHR(0)), .T.)
  ELSE
   KEYSEND(I2BIN(nKey), .T.)
  ENDIF
 RETURN

