*********** Sample programs for Nantucket Tools II / 5.01 ************
*
* Program     : FTOKEN.PRG
* Copyright   : (c) 1991, Nantucket  Corp.  All rights reserved.
* Date        : 12/22/90
* Author      : Michael Peters / Lothar Bongartz
* Description : Tokenizing in files of any size
* Compiling   : CLIPPER FTOKEN /N/L
* Linking     : RTLINK FI %1, FTOKEN LIB NT250
*
* Remarks     :
*
* FTOKEN is not an executable program!
*
* This program includes all functions for a file tokenizing.
* Independent of the buffer size, any token (records or words)
* from a file can be read.
* NOTE : The handling is cancelled, when a single token exceeds the
* buffer size.
*
*
* FTOKENINIT(<cDatei>, [<cTrenn>], [<nSkip>]) -> nFehlerkode
* -------------------------------------------------------------------
* This function is called like TOKENINIT() (manual I page 4-117);
* instead of a variable a filename including path is used.
* The function is opening the file and keeping file handling and
* other settings in a STATIC array and a STATIC variable.
* At an error during opening the file the function returns an error
* code according to the table of FERROR(), however as negative value.
*
*
* FTOKENNEXT()
* --------------------------------------------------------------------
* This function returns the next respective token from the buffer.
* It recognizes, when it is necessary to load data from the file because
* of an empty buffer. In doing so it is considered that tokens at the
* end of the buffer could be cut up.
*
*
* FTOKENEND()
* --------------------------------------------------------------------
* This function determines if further tokens are available :
* DO WHILE .NOT. TOKENEND()
*
*
* FTOKENCLOS()
* --------------------------------------------------------------------
* After reading  a l l  token ( FTOKENEND() returns .T. ) the file
* will be closed automatically. If the reading has been cancelled
* in any way, the file has to be closed by FTOKENCLOS().
*
*
* EXAMPLE:
* Within a second tokenizing loop lines from a file will be
* devided in separate words. Lines and words will be numbered.
*
*  ACCEPT "ASCII-file  -> " TO cFile
*  nError := FTOKENINIT(cFile, CHR(13) + CHR(10) + CHR(26), 2)
*
*  IF nError < 0
*   ? "Error :", nError
*  ELSE
*   nRowCnt := 0
*   DO WHILE .NOT. FTOKENEND()
*    ? ; ? "Row  ", NTOC(++nRowCnt, 10, 3)
*    cRow = FTOKENNEXT()
*
*    cTemp = SAVETOKEN()
*     TOKENINIT(@cRow)
*
*     nWordCnt = 0
*     DO WHILE .NOT. TOKENEND()
*       Word = TOKENNEXT()
*       ? "  Word", NTOC(++nWordCnt, 10, 2) + ":", Word
*     ENDDO
*    RESTTOKEN(cTemp)
*   ENDDO
*  ENDIF
*
*  FTOKENCLOS()     // just to make sure
* RETURN
*
*********************************************************************

* The array
*
* [1]  -> (n) file handling
* [2]  -> (n) file size
* [3]  -> (c) sep. sequence
* [4]  -> (n) skip width
* [5]  -> (n) buffer size
* [6]  -> (l) end reached

STATIC FToken := { 0, 0, "", 0, 0, .F. }
STATIC cFtokBuffer := ""


//* initialization of file tokenizer *//

FUNCTION FTOKENINIT(cFile, cSep, nSkip)
 LOCAL nRetVal := 0

 FToken[1] := FOPEN(cFile)

 IF FToken[1] < 0
  nRetVal := -FERROR()
 ELSE
  FToken[2]   := FSEEK(FToken[1], 0, 2)
  FToken[3]   := cSep
  FToken[4]   := nSkip
  FToken[5]   := MIN(MIN(10000, MEMORY(1)*1024), FToken[2])
  FToken[6]   := .F.
  cFtokBuffer := REPLICATE(CHR(0), FToken[5])

  FSEEK(FToken[1], 0, 0)
  FREAD(FToken[1], @cFtokBuffer, FToken[5])

  TOKENINIT(@cFtokBuffer, FToken[3], nSkip)
 ENDIF
RETURN(nRetVal)


//* Get the next respective token from the file buffer *//

FUNCTION FTOKENNEXT()
 LOCAL cToken, nFilePos, nStill2Read

 cToken = TOKENNEXT(cFtokBuffer)

  IF LEN(cToken) >= FToken[5]
   * Token and buffer have the same size, a token is not
   * recognizable. The buffer has to be enhanced or it has
   * been tried to read text from a binary file.
   *
   cToken = ""
   FTOKENCLOS()
  ELSE
   IF TOKENEND()
    * Last token for the current buffer. If the file contains
    * further data, this last token has to be 'illegal' and
    * read again with further data.

    IF FSEEK(FToken[1], 0, 1) < FToken[2]
     * new loading of the buffer
     *
     * If the file has not reached EOF, the last token of the
     * buffer will be ignored, because it is not sure if the
     * token is complete. The file pointer will be moved back to
     * the beginning of the token and a new buffer will be
     * loaded.
     *
     nFilePos    := FSEEK(FToken[1], -((FToken[5] -TOKENAT()) +1) , 1)
     nStill2Read := FToken[2] -nFilePos

      * creating a new, smaller buffer
      *
      IF nStill2Read < FToken[5]
       FToken[5]   := nStill2Read
       cFtokBuffer := REPLICATE(CHR(0), FToken[5])
      ENDIF

     * read the following data into the buffer
     *
     FREAD(FToken[1], @cFtokBuffer, FToken[5])
     TOKENINIT(@cFtokBuffer, FToken[3], FToken[4])
     cToken := TOKENNEXT(cFtokBuffer)
    ELSE
     FTOKENCLOS()
    ENDIF
   ENDIF
  ENDIF
RETURN(cToken)


//* displays if further tokens are existing *//

FUNCTION FTOKENEND()
RETURN(FToken[6])


//* closes the file *//

FUNCTION FTOKENCLOS()
  FCLOSE(FToken[1])
  cFtokBuffer := ""
  FToken := { 0, 0, "", 0, 0, .T. }
RETURN(Nil)

