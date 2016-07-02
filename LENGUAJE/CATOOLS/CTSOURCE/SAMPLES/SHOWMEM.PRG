*********** Sample programs for CA-Clipper Tools / 5.2 ************
*
* Program     : SHOWMEM.PRG
* Copyright   : (c) 1991-93, Computer Associates International.
*               All rights reserved.
* Date        : 10/23/90
* Author      : Lothar Bongartz
* Description : Display the contents of a MEM file
* Compiling   : CLIPPER SHOWMEM
* Linking     : RTLINK FI SHOWMEM LIB CT
* Remarks     : /
*
*******************************************************************

* Display the contents of MEM files


 CLS
 ?
 ?

 Var_1 := .T.
 Var_2 := 12.3456
 Var_3 := DATE()
 Var_4 := repl("a", 260)             //"ShowMemFile"

 SAVE TO Temp                        // create a MEM file
  ShowMemFile("Temp.Mem")
 DELETEFILE("Temp.Mem")              // delete the MEM file
RETURN


//* function for displaying the MEM file *//

FUNCTION ShowMemFile
PARAMETER File
 LOCAL nOffset, nLen, nNum, cName, cType, nSize, nDec, xContens

 cStr    := FILESTR(File)
 nLen    := LEN(cStr) -1
 nOffset := 0
 nNum    := 0

 DO WHILE nOffset < nLen
   cName   := LEFT(ATADJUST(CHR(0), SUBSTR(cStr, nOffset +1, 10), 11, 1), 10)
   cType   := CHR(ASCPOS(cStr, nOffset +12) %128)    // CLIPPER adds 128
   nSize   := ASCPOS(cStr, nOffset +17)
   nDec    := ASCPOS(cStr, nOffset +18)
   nOffset := nOffset +40

   ? NTOC(nNum, 10, 3) + ": "

   DO CASE
   CASE cType = "L"
     nOffset  := nOffset -7
     xContens := (ASCPOS(cStr, nOffset) > 0)
     ?? cName, cType, "     1    ", xContens
   CASE cType = "N"
     xContens := CTOF(SUBSTR(cStr, nOffset -7,  8))
     xContens := STR(xContens, nSize, nDec)    // only for representation
     ?? cName, cType, NTOC(nSize, 10, 6),;
        NTOC(nDec, 10, 2), "", LTRIM(xContens)
   CASE cType = "D"
     xContens := STOD() +BIN2L(SUBSTR(cStr, nOffset -4,  4)) /128 -6291456
     ?? cName, cType, "     8    ", xContens
   CASE cType = "C"
     nSize    := BIN2W(CHR(nSize) + CHR(nDec))
     --nSize                               // ending nul will be included
     xContens := SUBSTR(cStr, nOffset -7, MIN(nSize, 49))
     nOffset  := nOffset -7 +nSize
     ?? cName, cType, NTOC(nSize, 10, 6),;
        "   ", xContens + IIF(nSize > 49, " " + CHR(26), "")
   OTHERWISE
     EXIT
   ENDCASE

   ++nNum
 ENDDO
RETURN(nNum)