*********** Sample programs for Nantucket Tools II / 5.01 ********
*
* Program     : CHK4BOMB.PRG
* Copyright   : (c) 1991, Nantucket  Corp.  All rights reserved.
* Date        : 08/16/90
* Author      : Lothar Bongartz
* Description : This program is searching for text sequences
*               within .OBJ or .COM files. A sequence is a text,
*               when at least 4 sequential displayable characters
*               are found.
* Compiling   : CLIPPER CHK4BOMB
* Linking     : RTLINK FI CHK4BOMB LIB NT250
* Remarks     : The program is 'supposing' by the mean of certain
*               rules, what is text and what is no text.
*
*******************************************************************

PARAMETER cFileName
cFileContens := FILESTR(cFileName)

 cChange := cFileContens              // save original

* change all valid characters to ASCII 255

 CSETREF(.T.)                         // speeds up changing

 RANGEREPL(226,   8, @cChange, 255)   // Åber '·' und unter Tab
 RANGEREPL( 10,  31, @cChange, 255)   // Åber Tab und unter ' '
 RANGEREPL(123, 128, @cChange, 255)   // Åber 'z' und unter 'Å'
 RANGEREPL(130, 131, @cChange, 255)   // Åber 'Å' und unter 'Ñ'
 RANGEREPL(133, 141, @cChange, 255)   // Åber 'Ñ' und unter 'é'
 RANGEREPL(143, 147, @cChange, 255)   // Åber 'é' und unter 'î'
 RANGEREPL(149, 152, @cChange, 255)   // Åber 'î' und unter 'ô'
 RANGEREPL(155, 224, @cChange, 255)   // Åber 'ö' und unter '·'

 nEndPos  := LEN(cFileContens) +1
 nIgnore  := 0
 nPos1    := POSEQUAL(cFileContens, cChange, 4, n)

 DO WHILE nPos1 <> 0
   nPos2 := POSDIFF(cFileContens, cChange, nPos1 +3)

   IF nPos2 = 0
     nPos2 := nEndePos
   ENDIF

   ? SUBSTR(cFileContens, nPos1, nPos2 -nPos1)
   nIgnore := nPos2
   nPos1   := POSEQUAL(cFileContens, cChange, 4, nIgnore)
 ENDDO
RETURN
