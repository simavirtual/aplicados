
*  HPGL INTERFACE - Clipper 5.0
*
*  CLIPPER 5.0 version of HPGL interface. Does not require ERRORSYS.PRG.
*  This function is already in the CLIP50.LIB library and is provided if
*  you wish to make any modifications.
*
#include "error.ch"

PROCEDURE HP_OPEN
PARAMETER HP_NAME
DO CASE
*
*  Plot to plotter directly when passed parameter equal to key word PLOTTER
*  Assumes RS-232C serial connection
*
   CASE UPPER(TRIM(HP_NAME)) = "PLOTTER" .OR. UPPER(TRIM(HP_NAME)) = "COM"
      ErrorBlock( {|e| HP_Error(e)} )
      PLOT_OUT(1)
      HP_NAME='COM'+STR(RET_COM(),1)   && Include ERRORSYS.PRG modifications
      SET PRINTER TO &HP_NAME          && when linking your application.
      HP_SETUP()
*
*  Plot to file when passed parameter is equal to FILE
*
   CASE UPPER(TRIM(HP_NAME)) = "FILE";
        .or. UPPER(TRIM(HP_NAME)) = "LJIII_FILE"
      HPNAME="hp_file."+LTRIM(STR(HP_ROTATE(),2))
      SET DEVICE TO SCREEN
      SET CURSOR ON
      @ 0,0
      @ 0,0 say 'Enter File Name: 'GET HPNAME PICT '@K'
      READ
      SET CURSOR OFF
*
      PLOT_OUT(2)
      SET PRINTER TO &HPNAME
      HP_SETUP()                  && type 0 default to landscape
      IF UPPER(TRIM(HP_NAME)) = "LJIII_FILE"
         HPGL_SEND(chr(27)+"%0B")   && Setup LJ-III
      ENDIF
*
*  Plot to laser through LPT1:
*
   CASE UPPER(TRIM(HP_NAME)) = "LJIII" .OR. UPPER(TRIM(HP_NAME)) = "LPT1"
      PLOT_OUT(1)                && Sets driver to LJIII, use color pal as pen width
      IF UPPER(TRIM(HP_NAME)) = "LJIII"
         HPGL_SEND(chr(27)+"%0B")   && Setup LJ-III
      ENDIF
      HP_SETUP()                 && Initializes startup variables
ENDCASE

FUNCTION HP_CLOSE
IF RET_HP() > 0
   TEXTMODE()
ENDIF
SET PRINTER TO
DO ErrorSys

FUNCTION LJ3_EJECT
SET CONSOLE OFF
SET PRINT ON
HPGL_SEND(chr(27)+"%1A")   && HPGL OFF
EJECT
SET PRINT OFF
SET CONSOLE ON

FUNCTION HP_Error(e)
IF RET_HP() > 0
   return(.t.)
ENDIF

