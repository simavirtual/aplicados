*********** Sample programs for Nantucket Tools II / 5.01 **********
*
* Program     : FILECNT.PRG
* Copyright   : (c) 1991, Nantucket  Corp.  All rights reserved.
* Date        : 10/22/90
* Author      : Michael Peters / Lothar Bongartz
* Description : Counting files of a specified name group
* Compiling   : CLIPPER FILECNT
* Linking     : RTLINK FI FILECNT LIB NT250
* Remarks     :
*
* During the execution of the program Clipper 5.0 is possibly
* creating a swap file. At a file mask *.* this file is included.
* It will be deleted at the end of the program.
*
* As Subdirectories also "." and ".." are included.
*
* For a better result control the comment line "?" within the
* DO WHILE can be used.
*
*******************************************************************

* locate the number of directory entries

 SET DATE AMERICAN

 ? ".PRG-files  :  ", NTOC(FileCount("*.PRG"), 10, 4)
 ? ".DBF-files  :  ", NTOC(FileCount("*.DBF"), 10, 4)
 ? " All files  :  ", NTOC(FileCount("*.*"), 10, 4)
 ? "Subdirectories:", NTOC(FileCount("*.*", 16, .T.), 10, 4)
RETURN


//* Function for counting the files  *//

FUNCTION FileCount()
 PARAMETERS cFileMask, nFileAttr, lExact
 LOCAL nCount, cFile

 IF TYPE("nFileAttr") <> "N"
   nFileAttr := 32               // Default value
 ENDIF

 IF TYPE("lExact") <> "L"
   lExact := .F.                 // Default value
 ENDIF

 nCount := 0
 cFile  := FILESEEK(cFileMask, nFileAttr, lExact)       // Search first

  DO WHILE .NOT. EMPTY(cFile)
   ++nCount
*   ? PADRIGHT(cFile, 15), PADRIGHT(DTOC(FILEDATE()), 10), FILETIME()
   cFile := FILESEEK()                                  // Search next
  ENDDO
RETURN(nCount)

