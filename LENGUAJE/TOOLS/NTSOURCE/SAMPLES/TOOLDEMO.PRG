*********** Sample programs for Nantucket Tools II / 5.01 *********
*
* Program     : TOOLDEMO.PRG
* Copyright   : (c) 1991, Nantucket  Corp.  All rights reserved.
* Date        : 08/10/90
* Author      : Lothar Bongartz / Michael Peters
* Description : Various examples for the Clipper Tools
* Compiling   : CLIPPER TOOLDEMO /N
* Linking     : - to be used only in conjunction with other programs -
*
* Remarks     :
*
* TOOLDEMO is not an executable program!
*
* In this file you will find a number of demo programs, functions or
* procedures for Clipper Tools II.
* Knowingly, all programs have not been optimized in speed and size.
* It has been taken care of a clear program code including a good
* documentation.
*
**************************************************************************

*========================================================================
*=========================================================================
FUNCTION MAIN
CLS

 ? ; ? ; ?
 ? "This file is containing a collection of functions to"
 ? "demonstrate the Clipper Tools II / 5.0"
 ? "This demonstration is not an executable program,"
 ? "but you can use all functions in your own programs."
 ?

RETURN(NIL)

**************************************************************************
*
* Function : CRYPTHDR()
* Copyright: (c) 1990, 1991  Nantucket GmbH Leverkusen
* Date     : 10/11/90
* Author   : Lothar Bongartz / Michael Peters
* Return   : LOGICAL, .T. when successful, otherwise .F.
* Usage    : With this function, the header of a DBF file can be
*            encrypted. Only programs with this function and the
*            correct password have a data access.
*            The first function call with a password is coding the
*            header, the next call with the same password is
*            decoding .. and so on ...
* Notes    : The header will be encrypted from byte 10. So, the
*            length entry in byte 8/9 can not be lost. However,
*            all field specifications will be encrypted.
*            At an attempt to open the database under dBASE,
*            the message 'Database encrypted' will be returned.
*
* Example  : CRYPTHDR("STOCK.DBF", "NANTUCKET")
*
**************************************************************************
FUNCTION CRYPTHDR(cFileName, cPassWord)
LOCAL nRetcode := .F., nSize, cDBFHeader, lWritten

 IF FILE(cFileName)
  * 2 Byte (size) read from header
   nSize := BIN2I(FILESTR(cFileName, 2, 8)) -10

  * read the complete header with the computed size
   DBFHeader := FILESTR(cFileName, nSize, 10)
   CRYPT(@cDBFHeader, cPassWord)     // faster per Reference!

  * overwrite the file with the coded/decoded header
   lWritten := STRFILE(cDBFHeader, cFileName, .T., 10)
   nRetcode := (lWritten > 0)        // additional check
 ENDIF
RETURN(nRetcode)

*************************************************************************
* Function : BSOUND()
* Copyright: (c) 1990, 1991  Nantucket GmbH Leverkusen
* Author   : Markus Breitkopf, Nantucket GmbH
* Date     : 07/22/90
* Return   : CHARACTER STRING returns the converted string.
* Usage    : The function is called BSOUND(), as the converted
*            strings sound like baby language.
*            In this way, other similar sounding strings can
*            be searched.
*
* Example  : INDEX ON BSOUND(field) TO SIMILAR
**************************************************************************
FUNCTION BSOUND(cString)

 * The sequence of exchange is very important, so it is impossible,
 * to combine e.g. the two WORDREPL!

 * remove all multiple strings
  cString := CHARONE(cString)

 * 2 byte groups convert in single byte
  cString := WORDTOCHAR("SCCZTZTSDSPHPFTHUE", cString, "CCCCCVVTY")

 * when the string length is not changed, it is faster per reference!
  WORDREPL("QUEU", @cString, "KVOY", .T.)

 * 2 byte groups convert in single byte again
  cString := Wordtochar("AEOEKS", cString, "EOX")

 * the rest per Reference!
  WORDREPL("AIEIEY", @cString, "AY", .T.)
  CHARREPL("KGQUIJSFWPT", @cString, "CCCYYYSVVBD")

RETURN(cString)

*************************************************************************
* Function : RECSTRING()
* Copyright: (c) 1990, 1991  Nantucket GmbH Leverkusen
* Author   : Michael Peters, Nantucket GmbH
* Date     : 08/14/90
* Return   : CHARACTER STRING returns a complete record as a string
* Usage    : This function converts a complete record with fields of
*            any datatype into a string.
* Example  :
*            * process identical records only once!
*            USE file
*
*            DO WHILE .NOT. EOF()
*              rec  := RECSTRING()  // 1st record
*              ? ........           // display of data
*              SKIP
*               DO WHILE RECSTRING() = rec
*                 SKIP
*               ENDDO
*            ENDDO
*
**************************************************************************
FUNCTION RECSTRING
LOCAL nFields, cField, cString, I

 cString := ""
 nFields := FCOUNT()                  // number of fields

 FOR I = 1 to nFields
  cField  := FIELD(I)                 // field name
  cString := cString + XTOC(&cField)  // any field -> convert string
 NEXT I

RETURN(cString)

*************************************************************************
* Function : ROWS
* Copyright: (c) 1990, 1991  Nantucket GmbH Leverkusen
* Author   : Michael Peters, Nantucket GmbH
* Date     : 09/14/90
* Usage    : The text from a file is read and processed by the line.
*            What you are doing with the single rows within the
*            function is your turn.
*
* Notes    : No blank lines are available!
*            A file size over 64 kB is not allowed!
*            See also: FTOKEN.PRG
*
* Example : DO ROWS WITH "C:\AUTOEXEC.BAT"
*
**************************************************************************
FUNCTION ROWS(cFileName)
LOCAL cFileText, cLine

  IF "" <> FILESEEK(cFileName)
    cFileText := FILESTR(cFileName)

    TOKENINIT(@cFileText, CHR(13)+CHR(10), 2) // initialize ! @ !

    DO WHILE .NOT. TOKENEND()
     * each row can be processed
     * for example converted in capital letters
     *
      cLine := TOKENNEXT(cFileText)          // get next row
      ?? UPPER(cLine) + CHR(13) + CHR(10)
    ENDDO
  ENDIF
RETURN(NIL)

*************************************************************************
* Function : LIST_STRU
* Copyright: (c) 1990, 1991  Nantucket GmbH Leverkusen
* Author   : Michael Peters, Nantucket GmbH
* Date     : 05/18/89
* Usage    : With this procedure, the structure of a database
*            can be displayed. The form is similar to dBASE.
*
* Example  : DO LIST_STRU WITH "client"
*
**************************************************************************
FUNCTION LIST_STRU(cFileName)
LOCAL nRange, nFcount

 nRange := SELECT()     // save former select area
  USE &cFileName NEW

  ? "Fiels  Fieldname   Type  Length  Dec"
  nFcount := FCOUNT()   // number of fields

  FOR I = 1 to nFcount
   ? STR(I, 5), " " + PADRIGHT(FIELD(I), 11),;
     FIELDTYPE(I), STR(FIELDSIZE(I), 10), STR(FIELDDECI(I), 4)
  NEXT I

  ? "** Total **          " + STR(RECSIZE(), 10)
  USE
 SELECT (nRange)
RETURN(NIL)

*************************************************************************
* Function : GETENVPARM()
* Copyright: (c) 1990, 1991  Nantucket GmbH Leverkusen
* Author   : Michael Peters, Nantucket GmbH
* Date     : 05/18/89
* Return   : CHARACTER STRING Parameter of environment variable
* Usage    : With this function, parameter(s) of an environment
*            variable can be determined.
* Notes    : This function is more tolerant than Clipper's GETE(),
*            as blanks between variable and parameter are allowed.
*
* Example  : ? GETENVPARM("CLIPPER")   // parameter to CLIPPER var.
*
**************************************************************************
FUNCTION GETENVPARM(cVariable)
LOCAL cVar, nPos, cPar := ""

 * The function determines the position of the specified variable.
 * In the remaining string, the second token is searched under
 * usage of the separators BLANK, "=" and CR. This token is
 * corresponding to the parameter of the variables.

  cVar := UPPER(ENVSTRING())      // get environment
  cVar := CHARONE(" ", Var)       // remove multiple blank
  cVar := ATREPL(" =", Var, "=")  // remove blank before "="

  nPos := AT(Variable + "=", Var) // position in environment

  IF Pos > 0                      // variable found?
    cVar := SUBSTR(Var, Pos)
    cPar := TOKEN(Var, "= " + CHR(13), 2)   // 2. token -> parameter
  ENDIF

RETURN(cPar)

**************************************************************************
* Function : SCANFILES()
* Copyright: (c) 1990, 1991  Nantucket GmbH Leverkusen
* Author   : Michael Peters / Lothar Bongartz
* Date     : 06/20/90
* Return   : CHARACTER STRING The function returns a NUL String.
* Usage    : With this function a directory including all
*            subdirectories can be passed. All files specified via
*            FileSpec (also with wild cards) can be processed
*            anyway. In this way, programs like XDEL, FILEFIND etc
*            can be implemented in a Clipper application.
*
* Example  : cFilespec  := "*.PRG"  // All .PRG files
*            cStartPath := "\"      // begin in ROOT directory
*            SCANFILES(cStartPath)
*
**************************************************************************
FUNCTION SCANFILES(cPath)
LOCAL cSeekEnv, cFile               // takes FILESEEK environment

* work out subdirectories
 cFile := FILESEEK(cPath + "*.*", 16,.T.)

 DO WHILE .NOT. EMPTY(cFile)
   IF cFile <> "."                  // ".." and "." are dummys
     IF ISBIT(FILEATTR(),5)         // subdirectories ?
       cSeekEnv := SAVEFSEEK()      // save FILESEEK environment

        * recursive call with extended path!
        SCANFILES(cPath + cFile + "\")

       RESTFSEEK(cSeekEnv)          // recover environment
     ENDIF
   ENDIF
  cFile := FILESEEK()               // searching next file
 ENDDO

 cFile := FILESEEK(cPath + cFileSpec , 32)

 DO WHILE .NOT. EMPTY(cFile)
  * found files can be processed
   ? cPath + cFile
   cFile := FILESEEK()              // searching next file
 ENDDO

RETURN(NIL)                         // return value unimportant

**************************************************************************
* Function : BLANKREC()
* Copyright: (c) 1990, 1991  Nantucket GmbH Leverkusen
* Author   : Lothar Bongartz
* Datum    : 08/12/90
* Return   : LOGICAL The function returns only .F.
* Usage    : The function is able to delete all fields of the
*            current record in the active select area.
* Notes    : In opposite to BLANKREC() you will find the function
*            EMPTYREC().
*
* Example  : LIST FOR BLANKREC()   // deletes all, displays none
*
**************************************************************************
FUNCTION BLANKREC
LOCAL nFcount, I
 nFcount:= FCOUNT()                 // number of fields

 FOR I = 1 TO nFcount
   FIELDPUT(I, BLANK(FIELDGET(I)))  // delete field contents
 NEXT I

RETURN(NIL)

**************************************************************************
* Function : EMPTYREC()
* Copyright: (c) 1990, 1991  Nantucket GmbH Leverkusen
* Author   : Lothar Bongartz
* Date     : 07/10/90
* Return   : LOGICAL Returns .T., when the record is empty.
* Usage    : The function returns .T., when all fields of the current
*            record in the active select area are empty.
* Notes    : This function is not using special Tools II commands,
*            it is only shown as completion to the above mentioned
*            BLANKREC() function.
*
* Example  : LIST FOR .NOT. EMPTYREC()    // all not empty records
*
**************************************************************************
FUNCTION EMPTYREC
LOCAL nFcount, I := 1
 nFcount   := FCOUNT()                            // number of fields
 DO WHILE EMPTY(FIELDGET(I)) .AND. I <= nFcount
   I++
 ENDDO

RETURN( I > nFcount )


***********************************************************************
***********************************************************************
***********           Common problems and examples          ***********
***********************************************************************
***********************************************************************

* A number, up to 999, shall be displayed as a string without
* leading blanks.

* under Clipper:
*
*  ? LTRIM(STR(<nNum>, 3))

* with Toolbox
*
*  ? NTOC(<nNum>)      // decimal system is default


************************************************************************
* Via index, you want to seek for the right justified part of a word,
* for example all words ending with BUS.

* Indexing
* The field is mirrored, but without blanks
*
*  INDEX ON CHARMIRR(<cField>, .T.) TO Index

* Search
*
*  SEEK CHARMIRR(<cWord>)

************************************************************************
* After the input of path and file name, the two components have to
* be displayed separately.

PROCEDURE PATH1
 * path and filename have been entered: "C:\X1\X2\TEST.TXT"
 *
  ACCEPT "Please enter path  -> " TO cFileSpec

 * Remove blanks first, then append one blank.
 * So, a blank is returned as last token, when cFileSpec
 * is ending with a separator  - cFile is EMPTY.
 *
  cFileSpec = CHARREM(" ", cFileSpec) + " "
  cFile = TOKEN(cFileSpec, ":\")       // get last token
  cPath = BEFORATNUM(cFile, cFileSpec) // part before the file

   IF EMPTY(cFile)
    cFile := "*.xxx"                   // default FileSpec
   ELSE
    cFile := TRIM(cFile)               // remove the appended blank

    IF .NOT. "." $ cFile
     cFile := cFile + ".yyy"           // default extension
    ENDIF
   ENDIF

  ? cFile
  ? cPath
RETURN

* A path can also end with a directory name. This can be checked
* with FILEATTR().
* In this case instead of a file name *.* has been used.

PROCEDURE PATH2
  ACCEPT "enter path -> " TO cFileSpec

  IF NUMAND(FILEATTR(cFileSpec),16) = 16    // path a directory?
    cFile := "*.*"                          // default for file name
    cPath := cFileSpec                      // path as before
  ELSE
    * < separate cFileSpec, s. PATH1 >
  ENDIF

  ? cFile
  ? cPath
RETURN

**************************************************************************
* Modification of CONFIG.SYS and reboot of the system
*
* The function NUMFILES() finds out, if the number of files has
* been defined > 20 (FILES parameter). If not, the CONFIG.SYS will
* be modified and the system rebooted.
* The original CONFIG.SYS will be saved under CONFIG.BAK.
*
* This procedure conforms to an extension of the former
* described procedure ROWS.

 IF NUMFILES() <= 20                // current system value
  cFileName := "C:\CONFIG.SYS"
  cFilesNew := 30                   // new value for FILES=

  cCrLf := CHR(13) + CHR(10)

  IF "" <> FILESEEK(cFileName)
    cFileText = FILESTR(cFileName)  // read file

   * create backup file
    RENAMEFILE(cFileName, TOKEN(cFileName, "." ,1) + ".BAK")

    TOKENINIT(@cFileText, cCrLf, 2) // prepare ! @ !

    DO WHILE .NOT. TOKENEND()
      cLine := TOKENNEXT(cFileText) // get next row
       IF UPPER(CHARREM(" ", cLine)) = "FILES="   // search FILES=
        * remove former numbers, append new number
        * so, also the indents remain obtained
        cLine := CHARREM("0123456789", TRIM(cLine)) + NTOC(cFilesNew)
       ENDIF
      STRFILE(cLine + cCrLf, cFileName, .T.)
    ENDDO

    BOOTWARM()                      // activate new value!
  ENDIF
 ENDIF
RETURN

**************************************************************************
* It is checked, if the active Clipper application has been started
* in the current path.

 ? EXENAME() = ( DISKNAME() + ":" + DIRNAME() )  // path identical -> .T.

