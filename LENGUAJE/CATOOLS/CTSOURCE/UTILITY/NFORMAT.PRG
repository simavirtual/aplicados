*********** Sample programs for CA-Clipper Tools / 5.2 ************
*
* Program     : NFORMAT.PRG - disk formatting utility
* Copyright   : (c) 1991-93, Computer Associates International.
*               All rights reserved.
* Date        : 03/21/90
* Author      : Friedhelm Goeder / Michael Peters
* Description : NFORMAT [<Drive>] [<Format>] [<Option>]
*
*               <Drive>  = drive name e.g. "A:", "B:"
*                          default A:
*
*               <Format> = valid disk format
*                          /4    (360kB in 1,2MB disk drive)
*                          /160
*                          /180
*                          /320
*                          /360
*                          /720
*                          /1200 (default for drive A:)
*                          /1440 (default for drive B:)
*
*                          /V - program queries volume name
*
* Compiling   : CLIPPER NFORMAT
* Linking     : RTLINK FI NFORMAT LIB CT
*
* Remarks     : To link this program with other applications, it has
*               to be compiled as follows:
*
*                CLIPPER NFORMAT -N /D_F_ONLY
*
*               Formatting can be called with the function
*
*                DF([<cDrive>],[<cFormat>],[<cFmtOption>])
*
*
*********************************************************************
cls
#include "INKEY.CH"

#define COLOR_NORM  1
#define COLOR_HIGH  2
#define COLOR_TITEL 3
#define COLOR_TABL  4

#define MONO1  "W/N"
#define MONO2  "+W/N"
#define MONO3  "N/W"
#define MONO4  "+W/N"
#define COLOR1 "+W/BG"
#define COLOR2 "+G/BG"
#define COLOR3 "+RG/BG"
#define COLOR4 "+W/W"

* Usage as UDF within an application (s. remarks!)
*
#ifndef _F_ONLY
 PRIVAT cDrive, nFormat, cOptions

 SET SCOREBOARD OFF
 SET CONFIRM ON

  cDosParam := DOSPARAM()
  cOrgParam := cDosParam +""
  lError    := "?" $ cDosParam
  cOptions  := ""

  TOKENINIT(@cDosParam, " /")

   DO WHILE .NOT. TOKENEND()
    cToken := TOKENNEXT()

    cChar  := SUBSTR(cOrgParam, TOKENAT() -1, 1)

    IF cChar = "/" .OR. cChar = "-"   // Token delimiter
     IF ISDIGIT(cToken)
      nFormat := VAL(cToken)
     ELSE
      cOptions := cOptions + cToken
     ENDIF
    ELSE
     IF ISALPHA(cToken)
      cDrive := cToken
     ENDIF
    ENDIF
   ENDDO

  IF .NOT. lError
    lError := ( DF(cDrive, nFormat, cOptions) = -9 )
  ENDIF

  IF lError
    ? "NFORMAT [<Drive>] [<Format>] [<Option>]"
    ? "   <Drive>  = drive name e.g. A:, B:"
    ? "              default A:"
    ? "   <Format> = valid disk format"
    ? "              /4      (360kB in 1,2MB disk drive)"
    ? "              /160"
    ? "              /180"
    ? "              /320"
    ? "              /360"
    ? "              /720"
    ? "              /1200   (default for drive A:)"
    ? "              /1440   (default for drive B:)"
    ? "   <Option> = /V - program queries a volume name"
    ?
  ENDIF
 RETURN
#endif


FUNCTION DF(cDrive, nFormat, FmtOption)
LOCAL cDosScreen  := SAVESCREEN(7, 15, 16, 60)
LOCAL cDosColor   := SETCOLOR()
LOCAL cDosCursor  := ROW()*256 + COL()
LOCAL aDefFormats := { 360, 1200, 720, 1440 }
LOCAL lVol        := .F.
LOCAL lDriveLegal := .F.
LOCAL lErrCode, vName

PRIVATE lTrk80
PRIVAT aColorTable := IF(ISCOLOR(),{COLOR1,COLOR2,COLOR3,COLOR4},;
                                   {MONO1,MONO2,MONO3,MONO4})

*** check optional parameters and provide with default values
*
  IF VALTYPE(cDrive) <> "C"
   cDrive := "A:"                   // Default drive
  ELSE
   cDrive := UPPER(SUBSTR(cDrive, 1, 1)) + ":"
  ENDIF

  IF VALTYPE(nFormat) <> "N"
   nFormat := 0
  ENDIF

  IF VALTYPE(FmtOption) = "C"      // check options
   lVol := "V" $ UPPER(FmtOption)
  ENDIF

  lDriveLegal := cDrive $ "A:B:"

  IF lDriveLegal
   IF nFormat = 0                   // Default formats
    nFormat := aDefFormats[FLOPPYTYPE(cDrive)]
   ELSEIF nFormat = 4
    nFormat := aDefFormats[1]
   ENDIF
  ENDIF

  IF lDriveLegal .AND.;
     "|" + NTOC(nFormat, 10, 4) $;
     "| 160| 180| 320| 360| 720|1200|1440"

   lTrk80 := nFormat > 360

   SETCOLOR(aColorTable[COLOR_NORM])
    @ 7,15 TO 16,60 DOUBLE
    @ 8,16 CLEAR TO 15,59

   SETCOLOR(aColorTable[COLOR_TITEL])
    @ 7,25 SAY "[    disk formatting    ]"
   SETCOLOR(aColorTable[COLOR_NORM])

   @ 09,17 SAY "0"
   @ 10,17 SAY "1"

   DO WHILE LASTKEY() <> K_ESC
     SETCOLOR(aColorTable[COLOR_TABL])
      @ 9,19,10,58 BOX REPLICATE(" ", 9)
     SETCOLOR(aColorTable[COLOR_NORM])

     IF lTrk80
       @ 8,19 SAY "0....1....2....3....4....5....6....7...."
     ELSE
       @ 8,19 SAY "0....+....1....+....2....+....3....+...."
     ENDIF

     @ 12,18 SAY "Please insert disk in drive " + cDrive + "  (" +;
                 IIF(nFormat < 1000, STR(nFormat, 3) + "kB",;
                                     STR(nFormat /1000, 3, 1) + "MB") + ")"
     @ 13,18 SAY "Press any key to continue ..........."
     @ 15,18 SAY "[ESC]-Cancel   "

     lErrCode = IF(INKEY(0) == K_ESC, -3, 0)

     IF lErrCode = 0
       @ 12,16 CLEAR TO 14,59
       @ 12,17 SAY "Formatting disk in drive _  (___xx)"
       @ 13,17 SAY "Head __ Track __"

      SETCOLOR(aColorTable[COLOR_HIGH])
       @ 12,42 SAY cDrive
       @ 12,46 SAY IIF(nFormat < 1000,;
                   STR(nFormat, 3) + "kB", STR(nFormat/1000, 3, 1) + "MB")

       lErrCode := DISKFORMAT(cDrive, nFormat, "CONTROL", "No system.....", 5)

       IF lErrCode = 0
         SETCOLOR(aColorTable[COLOR_NORM])
         IF lVol
           SOUND(400, 2, .T.)
           @ 12,16 CLEAR TO 14,59
           vName := SPACE(11)
           @ 12,18 SAY "Volume name  :" GET vName PICT "@!"
           READ
           @ 12,16 CLEAR TO 14,59

           vName := CHARREM(" .", vName)
           IF .NOT. EMPTY(vName)
             VOLUME(cDrive + vName)
           ENDIF
         ENDIF

         IF MSG("Format another disk ? (Y/N)", "YN") = "N"
           EXIT
         ENDIF
       ELSEIF lErrCode = -2
         IF MSG("Invalid capacity for drive " + cDrive +;
                ";format another disk ? (Y/N)", "YN") = "N"
           EXIT
         ENDIF
       ELSEIF lErrCode = -3
         IF MSG("Cancelled by user;" +;
                "format another disk ? (Y/N)", "YN") = "N"
           EXIT
         ENDIF
       ELSEIF lErrCode = -4
         IF MSG("Formatting error;" +;
                "format another disk ? (Y/N)", "YN") = "N"
           EXIT
         ENDIF
       ELSE
         EXIT
       ENDIF
     ENDIF
   ENDDO

   RESTSCREEN(7, 15, 16, 60, cDosScreen)
   SETCOLOR(cDosColor)
   @ cDosCursor/256, cDosCursor % 256 SAY ""
  ELSE
   lErrCode = -9
  ENDIF
RETURN(lErrCode)


***********************************
* DISKFORMAT() Control UDF
*
FUNCTION CONTROL(nTrack, nHead)
LOCAL ret_val
  IF nTrack >= 0
    SETCOLOR(aColorTable[COLOR_TABL])

     IF lTrk80
      @ 9 +nHead, 19 +nTrack/2 SAY IIF(nTrack %2 > 0, "Þ", "Û")
     ELSE
      @ 9 +nHead,19 +nTrack SAY "Û"
     ENDIF

    SETCOLOR(aColorTable[COLOR_HIGH])
     @ 13,22 SAY nHead PICTURE "99"
     @ 13,31 SAY nTrack PICTURE "99"

    ret_val := if(inkey() == K_ESC, 2, 0)
  ELSE
    MSG("Initializing disk ............")
    ret_val := 0
  ENDIF
RETURN(ret_val)


*****************************************************
* message display and query of confirmation
*
STATIC FUNCTION MSG(msg, val_keys)
LOCAL ret_val, old_color := SETCOLOR(aColorTable[COLOR_NORM])

 IF val_keys <> NIL
  SOUND(200, 2, .T.)
  val_keys := val_keys + chr(K_ESC)
 ENDIF

 @ 12,16 CLEAR TO 14,59

 IF ";" $ msg
  @ 12,18 SAY SUBSTR(msg, 1, at(";", msg) -1)
  @ 13,18 SAY SUBSTR(msg, at(";", msg) +1)
 ELSE
  @ 12,18 SAY msg
 ENDIF

 ret_val := " "
 IF val_keys <> NIL
  DO WHILE .T.
   ret_val := UPPER(CHR(INKEY(0)))
   IF VALTYPE(val_keys) == "C"
     IF ret_val $ val_keys
      EXIT
     ENDIF
   ELSE
     EXIT
   ENDIF
  ENDDO
 ENDIF

 SETCOLOR(old_color)
RETURN(ret_val)

