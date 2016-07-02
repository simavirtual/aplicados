*********** Sample programs for CA-Clipper Tools / 5.2 ************
*
* Program     : MELODIES.PRG
* Copyright   : (c) 1991-93, Computer Associates International.
*               All rights reserved.
* Date        : 12/12/90
* Author      : Lothar Bongartz / Michael Peters
* Description : playing of sound files
*
*     PLEASE DON'T EXPECT THE HIGHEST MUSICAL ENJOYMENT!
*
* The program MELODIES.EXE can be started with the parameters >PATH<
* and >FILE SPECIFICATION<. Without parameter, all .SND files of the
* current directory will be played. The melodies are not played in
* the backround, it is impossible to cancel the program or to start
* other programs.
*
* The melodies are played in 1/18.2 sound mode, that's why the
* logical parameter is .T.. The tones are read from the file
* as strings:
*
*  I2BIN(<frequency>) + I2BIN(<duration>)  + ...    // resp. 4 Byte!
*
* Compiling   : CLIPPER MELODIES
* Linking     : RTLINK FI MELODIES LIB CT
* Remarks     :
*
* Another example for the creating of melodies as a string you will
* find in the file WARNING.PRG
*
*********************************************************************

 cDosParam := UPPER(CHARREM(" ", DOSPARAM())) + " "

 IF Empty(cDosParam)
  cFilespec := "*.SND"
  cPath     := ""
 ELSE
  cFileSpec := TOKEN(cDosParam, ":\")            // last token in FileSpec
  cPath     := BEFORATNUM(cFileSpec, cDosParam)  // part before the last token

  IF EMPTY(cFileSpec)
   cFileSpec := "*.SND"
  ELSE
   cFileSpec := TRIM(cFileSpec)

   IF .NOT. "." $ cFileSpec
    cFileSpec := cFileSpec + ".SND"
   ENDIF
  ENDIF
 ENDIF

 cFile = FILESEEK(cPath + cFilespec)

 DO WHILE .NOT. EMPTY(cFile)
   cMusic = FILESTR(cPath + cFile)
   ? cPath + PADRIGHT(cFile, 12), LEN(cMusic)
   SOUND(cMusic, .T.)

   cFile = FILESEEK()                            // searching next entry
 ENDDO
RETURN
