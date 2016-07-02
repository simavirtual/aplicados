*       ÖÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ·
*       º                                                         º
*       º 05/10/94               scaffold.prg            11:05:42 º
*       º                                                         º
*       ÇÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¶
*       º                                                         º
*       º Descripci¢n:	                                            º
*       º Este programa fue generado autom ticamente por FoxApp.     º
*       º                                                         º
*       ÓÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ½
*
*       Para ejecutar esta aplicaci¢n, escriba DO PERSVENT.APP
*
* Configurar el entorno Runtime
CREATE VIEW appview
SET TALK OFF
PUSH MENU _msysmenu
PUSH KEY CLEAR
fxapp_error = ON('ERROR')
fxapp_esc   = ON('ESCAPE')
SET SAFETY OFF
SAVE MACROS TO foxapp
SET SAFETY ON
SET DELETED ON
SET ESCAPE OFF
SET STEP OFF
SET ECHO OFF
SET PROCEDURE TO appproc.prg
SET CURSOR ON
m.set_point = SET("POINT")
CLOSE DATABASES
ON ERROR DO apperror WITH PROGRAM(),MESSAGE(),MESSAGE(1),LINENO(),ERROR()

IF _WINDOWS OR _MAC
   * Guardar la fuente de pantalla actual y establecerla en algo razonable.
   m.scrn_font   = WFONT(1,"")
   m.scrn_fsize  = WFONT(2,"")
   m.scrn_fstyle = WFONT(3,"")
   MODIFY WINDOW SCREEN FONT "FoxFont",10 STYLE ""
ENDIF

IF TYPE("BAILOUT") <> "U"
   RELEASE m.bailout
ENDIF
IF TYPE("DBFNAME") <> "U"
   RELEASE m.dbfname
ENDIF
IF TYPE("WIN_NAME") <> "U"
   RELEASE m.win_name
ENDIF
IF TYPE("FILT_EXPR") <> "U"
   RELEASE m.filt_expr
ENDIF
IF TYPE("SRCHTERM") <> "U"
   RELEASE m.srchterm
ENDIF
regen = .F.
EXTERNAL PROCEDURE getdest, getorder, appabout, ;
                    appsrch, prtopts, prtsetup

PUBLIC bailout, dbfname, win_name, wiz_screen, filt_expr, srchterm
m.bailout = .F.
m.dbfname = "C:\FPD26\SAMPLE\CATALOG\PERSVENT.DBF"     && database name
m.qprpath = justpath(m.dbfname) && query file path
m.filt_expr = ""                && filter expression, if any
m.srchterm = SPACE(60)          && search term
m.win_name = ""                 && name assigned below
m.wiz_screen = .F.              && assume false for now

* Define constants for addressing DBFLIST
m.numareas   = 25
m.numcols    = 13
m.cstemnum   = 1
m.relstrnum  = 2
m.pfldnum    = 3
m.cfldnum    = 4
m.cdbfnum    = 5
m.pdbfnum    = 6
m.srownum    = 7
m.scolnum    = 8
m.erownum    = 9
m.ecolnum    = 10
m.arranged   = 11
m.thefont    = 12
m.cascadenum = 13
m.ctrlrow    = 20
m.ctrlcol    = 3
m.nextdbf    = 0
DO DefineDbf                    && define the DBFLIST array


* Agregar al men£ principal de la aplicaci¢n
DO "APPMENU.PRG"

* Abrir la tabla principal
m.stem = makealias(juststem(m.dbfname))
IF USED(m.stem)
   SELECT (m.stem)
ELSE
   SELECT 0
   IF !FILE(m.dbfname)
      m.dbfname = GETFILE('DBF',"Por favor, localice la tabla "+JustStem(m.dbfname)+"")
   ENDIF
   IF EMPTY(m.dbfname) OR !FILE(m.dbfname)
      DO alert WITH "La tabla " +m.stem+" no se encontr¢."
      DO cleanup
      RETURN
   ELSE
      USE (m.dbfname)
   ENDIF
ENDIF
* Aseg£rese de que el ¡ndice existe y est  asociado
IF EMPTY(CDX(1))
   IF !FILE(forceext(m.dbfname,'CDX'))
      DO invert WITH m.dbfname
   ELSE
      SET INDEX TO (forceext(m.dbfname,'CDX'))
   ENDIF
ENDIF
SET ORDER TO 1

IF RECCOUNT() = 0
   APPEND BLANK
ELSE
   IF RECCOUNT() < 10
      COUNT FOR !DELETED() TO notdel
      IF m.notdel = 0
         APPEND BLANK  && se han borrado todos los registros
      ENDIF
   ENDIF
ENDIF
GOTO TOP

CLEAR
m.win_name = "PERSVENT"
m.wiz_screen = .F.
DO WHILE !m.bailout
   * Configurar las tablas relacionadas
   DO setrelat
   * Mostrar el archivo de la pantalla principal
   DO "persvent.spr"
   * Aseg£rese de que la tabla no se ha cerrado inesperadamente
   m.stem = makealias(juststem(m.dbfname))
   IF !USED(m.stem)
      SELECT 0
      USE (m.dbfname)
   ENDIF
ENDDO
DO cleanup
RETURN


*******************************************************************
PROCEDURE cleanup
* Limpiar despu‚s de la aplicaci¢n
SET PROCEDURE TO
CLOSE DATABASES
CLEAR WINDOWS
IF _WINDOWS OR _MAC
   MODIFY WINDOW SCREEN FONT m.scrn_font, m.scrn_fsize STYLE m.scrn_fstyle
ENDIF
IF SET('TALK') = 'ON'
   SET TALK OFF
   m.t_stat = 'ON'
ELSE
   m.t_stat = 'OFF'
ENDIF
SET TALK OFF
* Restaurar tablas, ¡ndices y entorno
IF FILE("appview.vue")
   SET VIEW TO appview
   SET TALK OFF
   DELETE FILE appview.vue
ENDIF
IF FILE("foxapp.fky")
   RESTORE MACROS FROM foxapp
   DELETE FILE foxapp.fky
ENDIF
IF m.t_stat = "ON"
   SET TALK ON
ENDIF
SET POINT TO "&set_point"
POP KEY ALL
POP MENU _msysmenu
CLEAR PROGRAM

* Restaurar las rutinas originales de escape y de error
IF TYPE('fxapp_error') = 'C'
   ON ERROR &fxapp_error
ENDIF

IF TYPE('fxapp_esc') = 'C'
   ON ESCAPE &fxapp_esc
ENDIF

SET SAFETY ON
RELEASE m.bailout, m.dbfname, m.win_name, m.wiz_screen, m.filt_expr, m.srchterm, m.skipvar, m.act3
RELEASE dbflist
RETURN

*******************************************************************
PROCEDURE setrelat
* Este procedimiento abre tablas subsidiarias (si las hay) y
* establece relaciones entre la tabla principal y las tablas 
* subsidiarias. Estar  vac¡o si no hay tablas subsidiarias.
RETURN


*******************************************************************
PROCEDURE definedbf
* Define la matriz dbflist
PUBLIC dbflist[m.numareas,m.numcols]
DBFLIST[1,1] = ''
DBFLIST[1,2] = ''
DBFLIST[1,3] = ''
DBFLIST[1,4] = ''
DBFLIST[1,5] = ''
DBFLIST[1,6] = ''
DBFLIST[1,7] = ''
DBFLIST[1,8] = ''
DBFLIST[1,9] = ''
DBFLIST[1,10] = ''
DBFLIST[1,11] = ''
DBFLIST[1,12] = ''
DBFLIST[1,13] = ''
DBFLIST[2,1] = ''
DBFLIST[2,2] = ''
DBFLIST[2,3] = ''
DBFLIST[2,4] = ''
DBFLIST[2,5] = ''
DBFLIST[2,6] = ''
DBFLIST[2,7] = ''
DBFLIST[2,8] = ''
DBFLIST[2,9] = ''
DBFLIST[2,10] = ''
DBFLIST[2,11] = ''
DBFLIST[2,12] = ''
DBFLIST[2,13] = ''
DBFLIST[3,1] = ''
DBFLIST[3,2] = ''
DBFLIST[3,3] = ''
DBFLIST[3,4] = ''
DBFLIST[3,5] = ''
DBFLIST[3,6] = ''
DBFLIST[3,7] = ''
DBFLIST[3,8] = ''
DBFLIST[3,9] = ''
DBFLIST[3,10] = ''
DBFLIST[3,11] = ''
DBFLIST[3,12] = ''
DBFLIST[3,13] = ''
DBFLIST[4,1] = ''
DBFLIST[4,2] = ''
DBFLIST[4,3] = ''
DBFLIST[4,4] = ''
DBFLIST[4,5] = ''
DBFLIST[4,6] = ''
DBFLIST[4,7] = ''
DBFLIST[4,8] = ''
DBFLIST[4,9] = ''
DBFLIST[4,10] = ''
DBFLIST[4,11] = ''
DBFLIST[4,12] = ''
DBFLIST[4,13] = ''
DBFLIST[5,1] = ''
DBFLIST[5,2] = ''
DBFLIST[5,3] = ''
DBFLIST[5,4] = ''
DBFLIST[5,5] = ''
DBFLIST[5,6] = ''
DBFLIST[5,7] = ''
DBFLIST[5,8] = ''
DBFLIST[5,9] = ''
DBFLIST[5,10] = ''
DBFLIST[5,11] = ''
DBFLIST[5,12] = ''
DBFLIST[5,13] = ''
DBFLIST[6,1] = ''
DBFLIST[6,2] = ''
DBFLIST[6,3] = ''
DBFLIST[6,4] = ''
DBFLIST[6,5] = ''
DBFLIST[6,6] = ''
DBFLIST[6,7] = ''
DBFLIST[6,8] = ''
DBFLIST[6,9] = ''
DBFLIST[6,10] = ''
DBFLIST[6,11] = ''
DBFLIST[6,12] = ''
DBFLIST[6,13] = ''
DBFLIST[7,1] = ''
DBFLIST[7,2] = ''
DBFLIST[7,3] = ''
DBFLIST[7,4] = ''
DBFLIST[7,5] = ''
DBFLIST[7,6] = ''
DBFLIST[7,7] = ''
DBFLIST[7,8] = ''
DBFLIST[7,9] = ''
DBFLIST[7,10] = ''
DBFLIST[7,11] = ''
DBFLIST[7,12] = ''
DBFLIST[7,13] = ''
DBFLIST[8,1] = ''
DBFLIST[8,2] = ''
DBFLIST[8,3] = ''
DBFLIST[8,4] = ''
DBFLIST[8,5] = ''
DBFLIST[8,6] = ''
DBFLIST[8,7] = ''
DBFLIST[8,8] = ''
DBFLIST[8,9] = ''
DBFLIST[8,10] = ''
DBFLIST[8,11] = ''
DBFLIST[8,12] = ''
DBFLIST[8,13] = ''
DBFLIST[9,1] = ''
DBFLIST[9,2] = ''
DBFLIST[9,3] = ''
DBFLIST[9,4] = ''
DBFLIST[9,5] = ''
DBFLIST[9,6] = ''
DBFLIST[9,7] = ''
DBFLIST[9,8] = ''
DBFLIST[9,9] = ''
DBFLIST[9,10] = ''
DBFLIST[9,11] = ''
DBFLIST[9,12] = ''
DBFLIST[9,13] = ''
DBFLIST[10,1] = ''
DBFLIST[10,2] = ''
DBFLIST[10,3] = ''
DBFLIST[10,4] = ''
DBFLIST[10,5] = ''
DBFLIST[10,6] = ''
DBFLIST[10,7] = ''
DBFLIST[10,8] = ''
DBFLIST[10,9] = ''
DBFLIST[10,10] = ''
DBFLIST[10,11] = ''
DBFLIST[10,12] = ''
DBFLIST[10,13] = ''
DBFLIST[11,1] = ''
DBFLIST[11,2] = ''
DBFLIST[11,3] = ''
DBFLIST[11,4] = ''
DBFLIST[11,5] = ''
DBFLIST[11,6] = ''
DBFLIST[11,7] = ''
DBFLIST[11,8] = ''
DBFLIST[11,9] = ''
DBFLIST[11,10] = ''
DBFLIST[11,11] = ''
DBFLIST[11,12] = ''
DBFLIST[11,13] = ''
DBFLIST[12,1] = ''
DBFLIST[12,2] = ''
DBFLIST[12,3] = ''
DBFLIST[12,4] = ''
DBFLIST[12,5] = ''
DBFLIST[12,6] = ''
DBFLIST[12,7] = ''
DBFLIST[12,8] = ''
DBFLIST[12,9] = ''
DBFLIST[12,10] = ''
DBFLIST[12,11] = ''
DBFLIST[12,12] = ''
DBFLIST[12,13] = ''
DBFLIST[13,1] = ''
DBFLIST[13,2] = ''
DBFLIST[13,3] = ''
DBFLIST[13,4] = ''
DBFLIST[13,5] = ''
DBFLIST[13,6] = ''
DBFLIST[13,7] = ''
DBFLIST[13,8] = ''
DBFLIST[13,9] = ''
DBFLIST[13,10] = ''
DBFLIST[13,11] = ''
DBFLIST[13,12] = ''
DBFLIST[13,13] = ''
DBFLIST[14,1] = ''
DBFLIST[14,2] = ''
DBFLIST[14,3] = ''
DBFLIST[14,4] = ''
DBFLIST[14,5] = ''
DBFLIST[14,6] = ''
DBFLIST[14,7] = ''
DBFLIST[14,8] = ''
DBFLIST[14,9] = ''
DBFLIST[14,10] = ''
DBFLIST[14,11] = ''
DBFLIST[14,12] = ''
DBFLIST[14,13] = ''
DBFLIST[15,1] = ''
DBFLIST[15,2] = ''
DBFLIST[15,3] = ''
DBFLIST[15,4] = ''
DBFLIST[15,5] = ''
DBFLIST[15,6] = ''
DBFLIST[15,7] = ''
DBFLIST[15,8] = ''
DBFLIST[15,9] = ''
DBFLIST[15,10] = ''
DBFLIST[15,11] = ''
DBFLIST[15,12] = ''
DBFLIST[15,13] = ''
DBFLIST[16,1] = ''
DBFLIST[16,2] = ''
DBFLIST[16,3] = ''
DBFLIST[16,4] = ''
DBFLIST[16,5] = ''
DBFLIST[16,6] = ''
DBFLIST[16,7] = ''
DBFLIST[16,8] = ''
DBFLIST[16,9] = ''
DBFLIST[16,10] = ''
DBFLIST[16,11] = ''
DBFLIST[16,12] = ''
DBFLIST[16,13] = ''
DBFLIST[17,1] = ''
DBFLIST[17,2] = ''
DBFLIST[17,3] = ''
DBFLIST[17,4] = ''
DBFLIST[17,5] = ''
DBFLIST[17,6] = ''
DBFLIST[17,7] = ''
DBFLIST[17,8] = ''
DBFLIST[17,9] = ''
DBFLIST[17,10] = ''
DBFLIST[17,11] = ''
DBFLIST[17,12] = ''
DBFLIST[17,13] = ''
DBFLIST[18,1] = ''
DBFLIST[18,2] = ''
DBFLIST[18,3] = ''
DBFLIST[18,4] = ''
DBFLIST[18,5] = ''
DBFLIST[18,6] = ''
DBFLIST[18,7] = ''
DBFLIST[18,8] = ''
DBFLIST[18,9] = ''
DBFLIST[18,10] = ''
DBFLIST[18,11] = ''
DBFLIST[18,12] = ''
DBFLIST[18,13] = ''
DBFLIST[19,1] = ''
DBFLIST[19,2] = ''
DBFLIST[19,3] = ''
DBFLIST[19,4] = ''
DBFLIST[19,5] = ''
DBFLIST[19,6] = ''
DBFLIST[19,7] = ''
DBFLIST[19,8] = ''
DBFLIST[19,9] = ''
DBFLIST[19,10] = ''
DBFLIST[19,11] = ''
DBFLIST[19,12] = ''
DBFLIST[19,13] = ''
DBFLIST[20,1] = ''
DBFLIST[20,2] = ''
DBFLIST[20,3] = ''
DBFLIST[20,4] = ''
DBFLIST[20,5] = ''
DBFLIST[20,6] = ''
DBFLIST[20,7] = ''
DBFLIST[20,8] = ''
DBFLIST[20,9] = ''
DBFLIST[20,10] = ''
DBFLIST[20,11] = ''
DBFLIST[20,12] = ''
DBFLIST[20,13] = ''
DBFLIST[21,1] = ''
DBFLIST[21,2] = ''
DBFLIST[21,3] = ''
DBFLIST[21,4] = ''
DBFLIST[21,5] = ''
DBFLIST[21,6] = ''
DBFLIST[21,7] = ''
DBFLIST[21,8] = ''
DBFLIST[21,9] = ''
DBFLIST[21,10] = ''
DBFLIST[21,11] = ''
DBFLIST[21,12] = ''
DBFLIST[21,13] = ''
DBFLIST[22,1] = ''
DBFLIST[22,2] = ''
DBFLIST[22,3] = ''
DBFLIST[22,4] = ''
DBFLIST[22,5] = ''
DBFLIST[22,6] = ''
DBFLIST[22,7] = ''
DBFLIST[22,8] = ''
DBFLIST[22,9] = ''
DBFLIST[22,10] = ''
DBFLIST[22,11] = ''
DBFLIST[22,12] = ''
DBFLIST[22,13] = ''
DBFLIST[23,1] = ''
DBFLIST[23,2] = ''
DBFLIST[23,3] = ''
DBFLIST[23,4] = ''
DBFLIST[23,5] = ''
DBFLIST[23,6] = ''
DBFLIST[23,7] = ''
DBFLIST[23,8] = ''
DBFLIST[23,9] = ''
DBFLIST[23,10] = ''
DBFLIST[23,11] = ''
DBFLIST[23,12] = ''
DBFLIST[23,13] = ''
DBFLIST[24,1] = ''
DBFLIST[24,2] = ''
DBFLIST[24,3] = ''
DBFLIST[24,4] = ''
DBFLIST[24,5] = ''
DBFLIST[24,6] = ''
DBFLIST[24,7] = ''
DBFLIST[24,8] = ''
DBFLIST[24,9] = ''
DBFLIST[24,10] = ''
DBFLIST[24,11] = ''
DBFLIST[24,12] = ''
DBFLIST[24,13] = ''
DBFLIST[25,1] = ''
DBFLIST[25,2] = ''
DBFLIST[25,3] = ''
DBFLIST[25,4] = ''
DBFLIST[25,5] = ''
DBFLIST[25,6] = ''
DBFLIST[25,7] = ''
DBFLIST[25,8] = ''
DBFLIST[25,9] = ''
DBFLIST[25,10] = ''
DBFLIST[25,11] = ''
DBFLIST[25,12] = ''
DBFLIST[25,13] = ''


*******************************************************************