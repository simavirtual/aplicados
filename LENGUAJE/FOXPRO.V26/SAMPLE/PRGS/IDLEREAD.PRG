*:*********************************************************************
*:
*:  Arch. proced.: C:\ORGANIZE\IDLEREAD.PRG
*:
*:        Sistema: Aplicaci¢n ORGANIZER
*:          Autor: Microsoft Corporation
*:      Copyright (c) 1992, Microsoft Corporation
*:  éltima modif.: 01/09/93     10:51
*:
*:  Procs./Funcs.: DOFIRSTAPP()
*:               : IDLELOOP()
*:
*:       Llamadas: ERRORHANDLER   (procedimiento de UTILITY.PRG)
*:               : STRIPEXT       (procedimiento de UTILITY.PRG)
*:               : STRIPPATH      (procedimiento de UTILITY.PRG)
*:               : SETUP          (procedimiento de UTILITY.PRG)
*:               : MAINMENU.MPR
*:               : DOFIRSTAPP()   (funci¢n de IDLEREAD.PRG)
*:               : IDLELOOP()     (funci¢n de IDLEREAD.PRG)
*:               : CLEANUP        (procedimiento de UTILITY.PRG)
*:
*:      Documentado el 01/09/93 a las 10:52        FoxDoc  versi¢n 2.07á
*:*********************************************************************
*
* Inicializa variables, prepara el entorno.
*
SET PROCEDURE TO utility
ON ERROR DO errorhandler WITH MESSAGE(), LINENO()
CLEAR PROGRAM
CLEAR GETS

IF SET("TALK") = "ON"
	SET TALK OFF
	m.talkstat = "ON"
ELSE
	m.talkstat = "OFF"
ENDIF

mdevice  = ""
m.area   = 0
m.exact  = ""
m.safety = ""
m.deci   = 0
m.escap  = ""
m.noti   = ""
m.deli   = ""
m.memow  = 0
m.oldhelp = SET("HELP",1)
m.helpset = SET("HELP")
m.resoset = SET("RESOURCE")
m.oldreso = SET("RESOURCE",1)

IF TYPE("m.hidecomm") = "U"
	m.hidecomm = WVISIBLE("commands")
ENDIF

m.macrosave = "savmacro.fky"
m.idlequit = .F.
m.module   = LOWER(stripext(strippath(SYS(16))))
m.tobedone = m.module + ".spr"

DO setup

PUSH MENU _msysmenu
RELEASE POPUPS organizer, moneymanag

DO mainmenu.mpr

*
* Lanza GET-LESS READ.
*
READ WHEN dofirstapp() ;
	VALID idleloop()

*
* Postprograma y reinicio del entorno.
*
POP MENU _msysmenu
CLEAR WINDOW ALL

DO cleanup
DO closdbfs
SET COLOR OF SCHEME 1 TO
IF RDLEVEL() = 0
	SET PROCEDURE TO
ENDIF

*!*********************************************************************
*!
*!        Funci¢n: DOFIRSTAPP()
*!
*!    Llamada por: IDLEREAD.PRG                  
*!
*!*********************************************************************
*
* DOFIRSTAPP - Llama a la primera aplicaci¢n al forzar al
*				READ de foundation a evaluar su cl usula VALID.
*
FUNCTION dofirstapp
CLEAR READ

*!*********************************************************************
*!
*!        Funci¢n: IDLELOOP()
*!
*!    Llamada por: IDLEREAD.PRG                  
*!
*!*********************************************************************
*
* IDLELOOP - Procesamiento del bucle de espera de instrucciones.
*
FUNCTION idleloop
PRIVATE m.temp, m.ontop

IF m.idlequit
	RETURN .T.
ENDIF

IF LEN(m.tobedone) > 0
	m.temp = m.tobedone
	m.tobedone = ""
	DO (m.temp)
	RETURN .F.
ENDIF

m.ontop = LOWER(WONTOP())

DO CASE
CASE m.ontop = "convertir"
	DO (m.ontop+".app")
CASE m.ontop = "familia" OR m.ontop = "restaurantes" OR ;
		m.ontop = "cr‚dito" OR m.ontop = "cuentas" OR ;
		m.ontop = "trans"
	SHOW WINDOW controles TOP
	IF m.ontop = "cuentas"
		SHOW WINDOW 'Detalles' TOP
	ENDIF
	DO (m.ontop+".spr")
CASE m.ontop = "detalles" OR m.ontop = "details.service"
	m.temp = "accnts.spr"
	SHOW WINDOW "Detalles" TOP
	SHOW WINDOW controles TOP
	DO (m.temp)
CASE m.ontop = "controles"
	m.temp = ""
	DO CASE
	CASE WVISIBLE("familia")
		m.temp = "family.spr"
	CASE WVISIBLE("restaurantes")
		m.temp = "restaurs.spr"
	CASE WVISIBLE("cr‚dito")
		m.temp = "credit.spr"
	CASE WVISIBLE("trans")
		m.temp = "trans.spr"
	CASE WVISIBLE("cuentas")
		m.temp = "accnts.spr"
		SHOW WINDOW "Detalles" TOP
	ENDCASE
	IF NOT EMPTY(m.temp)
		SHOW WINDOW controles TOP
		DO (m.temp)
	ENDIF
ENDCASE

RETURN .F.

*: EOF: IDLEREAD.PRG
