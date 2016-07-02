
PROCEDURE PS_OPEN
PARAMETER PS_NAME
DO CASE
*
*  Plot to screen when passed parameter is blank or equal to key word SCREEN
*
   CASE UPPER(TRIM(PS_NAME)) = "FILE" .or. UPPER(TRIM(PS_NAME)) = "LPT1"
      IF UPPER(TRIM(PS_NAME)) = "FILE"
         PS_NAME="ps_file."+LTRIM(STR(PS_ROTATE(),2))
         SET DEVICE TO SCREEN
         SET CURSOR ON
         @ 0,0
         @ 0,0 say 'Enter File Name: 'GET PS_NAME PICT '@K'
         READ
         SET CURSOR OFF
         SET PRINTER TO &PS_NAME
      ENDIF
      PLOT_OUT(2)
      SET CONSOLE OFF
      SET PRINT ON
      ?? '%!PS-Adobe-2.0'
      ? '%%DocumentFonts: (atend)'
      ? '%%Title: Postscript Generated File'
      ? '%%Creator: Flipper'
      ? '%%CreationDate: '+DTOC( DATE() )
      ? '%%For: User'
      ? '%%Pages: 1'
      ? '%%BoundingBox: 0 0 612 792'
      ? '%%EndComments'
      ? 'initgraphics'
      PS_SETUP()
      IF PS_ROTATE() = 90
         ? '612 0 translate'
         ? '90 rotate'
      ENDIF
      ?
      SET PRINT OFF
      SET CONSOLE ON
ENDCASE

FUNCTION PS_CLOSE
IF RET_HP() > 0
   TEXTMODE()
ENDIF
SET PRINTER TO

