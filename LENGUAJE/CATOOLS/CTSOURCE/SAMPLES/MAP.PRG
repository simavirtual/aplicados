*********** Sample programs for CA-Clipper Tools / 5.2 ************
*
* Program     : MAP.PRG
* Copyright   : (c) 1992-93, Computer Associates International.
*               All rights reserved.
* Date        : 05/20/92
* Author      : Michael Peters
* Compiling   : CLIPPER MAP /n
* Linking     : RTLINK FI MAP LIB CT
*
* Description : This program is supposed to 100% emulate the behaviour
*               of the Novell Netware MAP utility, while this probably
*               won't be the case.
*
*               May be used as .EXE or as UDF!
*************************************************************************


#include "CTNNET.CH"
#include "CTNNMSG.CH"


FUNCTION MAP(cParams)
 LOCAL lROOT := .F., lDEL  := .F., lREM  := .F.
 LOCAL lINS  := .F., lNEXT := .F., lDESC := .F.
 LOCAL cToken := "", cDrive := "", cPath, cTmpDrive, cMapping, lGo, cPrompt
 LOCAL cMapServer, cUsername, cPwd, nSDrive, cVolume, cOrgPath, lDOSTask
 LOCAL lSuccess := .F., i, cMapInfo, nSearch


 IF NNETWORK()
  SET INTENSITY OFF
  SET CONFIRM ON

  lDOSTask := EMPTY(PROCNAME(1))

  IF lDOSTask
   // function is start function (called from DOS)
   cParams := DOSPARAM()
  ENDIF

  CHARREPL("\", @cParams, "/")
  cParams := UPPER(cParams)


  TOKENINIT(@cParams, " =" +CHR(9))

  DO WHILE .NOT. TOKENEND()
   cToken := TOKENNEXT(cParams)

   IF IsOption(cToken)
    lROOT := lROOT .OR. cToken == "ROOT"
    lDEL  := lDEL  .OR. cToken =  "DEL"
    lREM  := lREM  .OR. cToken =  "REM"
    lINS  := lINS  .OR. cToken =  "INS"
    lNEXT := lNEXT .OR. cToken =  "N"
    lDESC := lDESC .OR. (cToken = "N" .AND. RIGHT(cToken, 1) = "-")
   ELSEIF IsDriveID(cToken)
    cDrive := CHARREM(":", cToken)
    cPath  := TOKENNEXT(cParams)
   ELSE
    cPath  := cToken
   ENDIF
  ENDDO


* Der folgende Code ist der Original-Code fr den Kommando-Interpreter
* und wurde gegen obigen Code ausgetauscht. Soweit obiger Code in allen
* Versuchen funktioniert, kann der folgende ausgesternte Code gel”scht
* werden - es muá also nur getestet werden.

*  DO WHILE IsOption(cToken) .AND. .NOT. TOKENEND()
*   lROOT := lROOT .OR. cToken == "ROOT"
*   lDEL  := lDEL  .OR. cToken =  "DEL"
*   lREM  := lREM  .OR. cToken =  "REM"
*   lINS  := lINS  .OR. cToken =  "INS"
*   lNEXT := lNEXT .OR. cToken =  "N"
*   lDESC := lDESC .OR. (cToken = "N" .AND. RIGHT(cToken, 1) = "-")
*
*   cToken := TOKENNEXT(cParams)
*  ENDDO
*
*  IF IsDriveID(cToken)
*   cDrive := CHARREM(":", cToken)
*   cPath  := TOKENNEXT(cParams)
*  ELSE
*   cPath  := cToken
*  ENDIF

  IF lDEL .OR. lREM
   IF IsDriveID(cDrive +":")
    // Delete mapping for cDrive
    //
    IF cDrive = "S"
     // delete search drive mapping
     //
     cMapping := NNETMAPINF(cDrive, .T.)

     IF .NOT. EMPTY(cMapping)
      lGo := .T.

      IF .NOT. NETDISK(NNETMAPINF(cDrive), .F.)
       ? "Attempt to delete a local drive search mapping."
       lGo := MapYesNo("Are you sure, you want to delete this search mapping? (Y/N): ")
      ENDIF

      IF lGo
       // delete it
       //
       cTmpDrive := SUBSTR(NNETMAPINF(cDrive, .F.), 1, 2)

       IF NNETMAP(cDrive)
        ? "The mapping for drive " + cTmpDrive + " has been deleted."
       ELSE
        // I can't imagine any error to occure here ...
       ENDIF
      ENDIF
     ELSE
      ? "Attempted operation on invalid drive."
     ENDIF
    ELSE
     // delete regular drive mapping
     //
     IF NNETMAP(cDrive)
      ? "The mapping for drive " + cDrive + " has been deleted."
     ELSE
      ? "Attempted operation on invalid drive."
     ENDIF
    ENDIF
   ELSE
    ? "Attempt to map network drive to unmapped drive or local drive."
   ENDIF
  ELSE
   IF EMPTY(cPath)
     IF EMPTY(cDrive)
      IF lROOT .OR. lNEXT .OR. lINS .OR. lDEL .OR. lREM
       ? "Attempt to map network drive to unmapped drive or local drive."
      ELSE
       // list all mappings
       //
       FOR i = 1 to 26
         cTmpDrive := CHR(64 +i)
         cMapInfo  := NNETMAPINF(CHR(64 +i), .F.)
         nSearch   := NNETSEARCH(cTmpDrive)

         IF cTmpDrive+":" == cMapInfo  .OR. NNETMAPMOD(cTmpDrive) = 128
          ? "Drive  " + cTmpDrive + ":   maps to a local disk."
         ELSEIF .NOT. EMPTY(cMapInfo) .AND. NNETSEARCH(cTmpDrive) = 0
          IF NNETFAKDEP(cTmpDrive) = -1
           ? "Drive  " + cTmpDrive + ": = " + ATREPL(":", cMapInfo, ":  \")
          ELSE
           ? "Drive  " + cTmpDrive + ": = " + cMapInfo + "  \"
          ENDIF
         ENDIF
       NEXT I

       ? "      --=--"

       FOR i = 1 TO 16
        cMapping := NNETMAPINF("S" +NTOC(i), .F.)

        IF .NOT. EMPTY(cMapping)
          ? "SEARCH" + NTOC(i) + ":  = " + cMapping + " " +;
            IF(SUBSTR(cMapping, 3, 1) == ".";
              .AND. NETDISK(SUBSTR(cMapping, 1, 1)),;
               NetPathDisp(NNETMAPINF("S" +NTOC(i), .T.),;
               NNETFAKDEP(cMapping) >= 0),;
               "")
        ENDIF
       NEXT i
      ENDIF
     ELSE
       IF lROOT .OR. lNEXT
        ? "Attempt to map network drive to unmapped drive or local drive."
       ELSEIF lINS
        ? "Could not interpret command line."
       ELSE
        // list mapping for specific drive 'cDrive'
        //
         cMapInfo  := NNETMAPINF(cDrive, .F.)

         IF cDrive+":" == cMapInfo  .OR. NNETMAPMOD(cDrive) = 128
          ? "Drive  " + cDrive + ":   maps to a local disk."
         ELSEIF .NOT. EMPTY(cMapInfo)
          ? "Drive  " + cDrive + ": = " + ATREPL(":", cMapInfo, ":  \")
         ELSE
          ? "Drive  " + cDrive + ":   is not defined."
         ENDIF
       ENDIF
     ENDIF
   ELSE
    // Do the mapping
    // depending on ROOT, INS, NEXT
    //
    // check target drive for being an existing local drive already
    //
    // check if the path to be mapped is accessible. Otherwise
    // attach (Login) to that appropriate server ...

    cOrgPath := cPath

    IF lNEXT
     cDrive := NNETNXTFRE(lDESC)
    ELSEIF EMPTY(cDrive)
     cDrive := DISKNAME()
    ENDIF

    IF ":" $ cPath
     cToken   := BEFORATNUM(":", cPath, 1)
     cPath    := AFTERATNUM(":", cPath, 1)

     IF "/" $ cToken
      cMapServer := BEFORATNUM("/", cToken, 1)
      cVolume    := AFTERATNUM("/", cToken, 1)
     ELSE
      cVolume    := cToken
      cMapServer := NNETSNAME()
     ENDIF
    ELSE
     cMapServer := NNETSNAME()
     cVolume    := TOKEN(NNETMAPINF(cDrive, .F.), "/\:", 2)
    ENDIF

    cPath := cMapServer +"/" + cVolume +":" +cPath

    lGo := .T.

    IF .NOT. NNETLOGGED(cMapServer)
     // ask for username to be attached ...
     //
      ? "Enter username for server " + cMapServer + ": "
      cUsername := UPPER(ALLTRIM(GetInput(.T., 47, "")))

      IF NNETLOGIN(cUsername, "", cMapServer) = 0
       // ask for password for that user ...
       //
        ? "Enter the password for user " + cUsername +;
          " on server " + cMapServer + ": "
        cPwd := UPPER(ALLTRIM(GetInput(.F., 15, "")))

        lGo  := ( NNETLOGIN(cUsername, cPwd, cMapServer) > 0 )

        IF lGo
         ? "Your station is attached to server " + cMapServer + "."
        ENDIF
      ELSE
       ? "Your station is attached to server " + cMapServer + "."
      ENDIF
    ENDIF

    IF lGo
     IF NNETMAPMOD(cDrive) = 128 .AND. LEN(cDrive) = 1
      // check for drive to be a local drive ...
      // but not for search drives !
      //
       ? "Drive " + cDrive + ": is in use by a local drive."
       lGo := MapYesNo("Do you want to assign it as network drive? (Y/N) ")
     ENDIF

     IF lGo
      // store the next drive to be used in descending order
      // this will be the drive to be used by a search mapping
      //
      cTmpDrive := NNETNXTFRE(.T.)

      IF NNETMAP(cDrive, cPath, lROOT, .F., lINS)
       lSuccess := .T.

       IF LEN(cDrive) >= 2
        nSdrive := NTOC(NNETSEARCH(cTmpDrive))
        ? "SEARCH" + nSDrive + ":  = " +;
          cTmpDrive + ":. " +;
          NetPathDisp(NNETMAPINF("S" +nSDrive, .T.),;
          NNETFAKDEP("S" +nSDrive) >= 0)
       ELSE
          IF NNETFAKDEP(cTmpDrive) = -1
           ? "Drive  " + cDrive + ": = " +;
             ATREPL(":", NNETMAPINF(cDrive, .T.), ":  \")
          ELSE
           ? "Drive  " + cDrive + ": = " +;
             NNETMAPINF(cDrive, .T.) + "  \"
          ENDIF
       ENDIF
      ELSE
       ? "Directory " +CHR(34) + cOrgPath +CHR(34) + " is not locatable."
      ENDIF
     ENDIF
    ELSE
     ? "The following drive mapping operation could not be completed."
     ? "    " + CHR(34) + cDrive + ":=" + cPath + CHR(34)
    ENDIF
   ENDIF
  ENDIF
 ELSE
  ? "No Novell network or shell not loaded."
  RETURN(NIL)
 ENDIF

 IF lDOSTask
  ?
  RETURN(NIL)
 ELSE
  RETURN(lSuccess)
 ENDIF

 RETURN(NIL)


FUNCTION NetPathDisp(cNetPath, lFake)

 IF .NOT. EMPTY(cNetPath)
  CHARREPL("/", @cNetPath, "\")
  cNetPath := "[" +;
              IF(lFake,;
                 cNetPath + "  \",;
                 ;
                 BEFORATNUM(":", cNetPath, 1) +;
                 ":  \" + AFTERATNUM(":", cNetPath, 1);
                );
              + "]"
 ENDIF

 RETURN(cNetPath)

FUNCTION MapYesNo(cMessage)
 LOCAL cPrompt := "X"

  DO WHILE "YES" <> ALLTRIM(UPPER(cPrompt)) .AND.;
           "NO"  <> ALLTRIM(UPPER(cPrompt))
   ? cMessage
   cPrompt := "Y  "

   @ ROW(), COL() GET cPrompt
   READ

   ?? CHR(10)
  ENDDO

 RETURN( "YES" = ALLTRIM(UPPER(cPrompt)) )


FUNCTION IsDriveID(cString)
 LOCAL lIsDrive, cDrive
 cDrive := BEFORATNUM(":", cString, 1)

 lIsDrive := RIGHT(cString, 1) == ":"       .AND.;
                                                 ;
             (  LEN(cDrive) = 1             .AND.;
                ASC(cDrive) >= 65           .AND.;
                ASC(cDrive) <= 90                ;
                                                 ;
             .OR.                                ;
                                                 ;
               cDrive = "S"                 .AND.;
               LEN(cDrive) <= 3             .AND.;
               VAL(SUBSTR(cDrive, 2)) >= 1  .AND.;
               VAL(SUBSTR(cDrive, 2)) <= 16 )

 RETURN(lIsDrive)

FUNCTION IsVolume(cString)
 // Volume names always collide with the search drive names S1 .. S16
 // So by just checking something which is supposed to be a volume
 // name with this function, you cannot be absolutely sure.
 // Only if the string to be checked was part of a path and additionally
 // follows the rules of this function, definetely a volume was meant.

 RETURN( RIGHT(cString, 1) == ":" .AND.;
         .NOT. IsDriveID(cString) .AND.;
         .NOT. "/" $ cString              )

FUNCTION IsOption(cString)
 LOCAL lIsOption

 lIsOption := .NOT. "/" $ cString .AND.;
              .NOT. IsVolume(cString) .AND.;
              .NOT. IsDriveID(cString)

 RETURN(lIsOption)
