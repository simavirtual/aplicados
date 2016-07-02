*       ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
*       ³                                                         ³
*       ³ 09/15/93            ADDUSERS.PRG               21:14:45 ³
*       ³                                                         ³
*       ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´
*       ³                                                         ³
*       ³ Autor                                                   ³
*       ³                                                         ³
*       ³ Copyright (c) 1993 Empresa                              ³
*       ³ Direcci¢n                                               ³
*       ³ Ciudad,     C.P.                                        ³
*       ³ Pa¡s                                                    ³
*       ³                                                         ³
*       ³ Descripci¢n:                                            ³
*       ³ Este programa lo ha generado autom ticamente GENSCRN.   ³
*       ³                                                         ³
*       ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

PARAMETERS m.cardid

*       ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
*       ³                                                         ³
*       ³   ADDUSERS/MS-DOS: c¢digo de preprograma - SECCIàN 1    ³
*       ³                                                         ³
*       ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
*

#REGION 1


#REGION 0
REGIONAL m.currarea, m.talkstat, m.compstat

IF SET("TALK") = "ON"
	SET TALK OFF
	m.talkstat = "ON"
ELSE
	m.talkstat = "OFF"
ENDIF
m.compstat = SET("COMPATIBLE")
SET COMPATIBLE FOXPLUS

*       ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
*       ³                                                         ³
*       ³            MS-DOS: definiciones de ventanas             ³
*       ³                                                         ³
*       ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
*

IF NOT WEXIST("_qj919jbkj")
	DEFINE WINDOW _qj919jbkj ;
		FROM INT((SROW()-14)/2),INT((SCOL()-66)/2) ;
		TO INT((SROW()-14)/2)+13,INT((SCOL()-66)/2)+65 ;
		FLOAT ;
		NOCLOSE ;
		SHADOW ;
		NOMINIMIZE ;
		DOUBLE ;
		COLOR SCHEME 5
ENDIF


*       ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
*       ³                                                         ³
*       ³   ADDUSERS/MS-DOS: c¢digo de preprograma - SECCIàN 2    ³
*       ³                                                         ³
*       ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
*

#REGION 1
PRIVATE m.mover, m.user, m.allcnt, m.saverec, m.usrcnt, m.limit, ;
	allusers, m.status, m.savearea,  m.userlast, m.userfirst

SET EXACT ON
m.user = 1
m.userlast = ""
m.status   = .T.
m.savearea = SELECT()
DIMENSION allusers[1,3]
allusers = ""

IF NOT locatedb("carduser",1)
	RETURN
ENDIF

m.saverec = RECNO()
SELECT DISTINCT lastname, firstname, ;
	ALLTRIM(firstname)+" "+ALLTRIM(lastname) ;
	FROM carduser ;
	INTO ARRAY allusers

m.allcnt = ALEN(allusers,1)

IF EMPTY(users)
	m.usrcnt = 0
ELSE
	m.usrcnt = 1
	m.limit  = ALEN(users,1)
	DO WHILE m.usrcnt <= m.limit
		IF EMPTY(users[m.usrcnt,1])
			EXIT
		ENDIF
		m.usrcnt = m.usrcnt + 1
	ENDDO
	m.usrcnt = m.usrcnt - 1
ENDIF

*       ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
*       ³                                                         ³
*       ³        ADDUSERS/MS-DOS: distribuci¢n de pantalla        ³
*       ³                                                         ³
*       ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
*

#REGION 1
IF WVISIBLE("_qj919jbkj")
	ACTIVATE WINDOW _qj919jbkj SAME
ELSE
	ACTIVATE WINDOW _qj919jbkj NOSHOW
ENDIF
@ 2,25 GET m.mover ;
	PICTURE "@*VN \<Mover;  \<Quitar  ;\\Quitar \<todos;\<Nuevo nombre;\!\<Aceptar" ;
	SIZE 1,14,1 ;
	DEFAULT 1 ;
	VALID _qj919jevd()
@ 1,1 GET m.alluser ;
 	PICTURE "@&N" ;
	FROM allusers ;
	RANGE 3, m.allcnt ;
	SIZE 10,22 ;
	DEFAULT 1 ;
	VALID _qj919jfht() ;
	COLOR SCHEME 5
@ 1,40 GET m.user ;
 	PICTURE "@&N" ;
	FROM users ;
	RANGE 3, usrcnt ;
	SIZE 6,22 ;
	DEFAULT 1 ;
	VALID _qj919jfyv() ;
	COLOR SCHEME 5
@ 7,54 GET m.gethelp ;
	PICTURE "@*HN A\<yuda" ;
	SIZE 1,8,1 ;
	DEFAULT 1 ;
	VALID _qj919jgdy()
@ 8,41 GET m.userlast ;
	SIZE 1,22 ;
	DEFAULT " " ;
	PICTURE "@K" ;
	WHEN _qj919jgoy() ;
	VALID _qj919jgux() ;
	ERROR "Blank entries are not allowed" ;
	DISABLE
@ 10,41 GET m.userfirst ;
	SIZE 1,15 ;
	DEFAULT " " ;
	PICTURE "@K" ;
	WHEN _qj919jh6s() ;
	VALID _qj919jhg4() ;
	DISABLE
@ 0,2 SAY "Lista de selecci¢n:" ;
	SIZE 1,19, 0
@ 0,41 SAY "Usuarios autorizados:" ;
	SIZE 1,21, 0
@ 7,41 SAY "Apellido:" ;
	SIZE 1,9, 0
@ 9,41 SAY "Nombre:" ;
	SIZE 1,7, 0

IF NOT WVISIBLE("_qj919jbkj")
	ACTIVATE WINDOW _qj919jbkj
ENDIF

READ CYCLE MODAL ;
	WHEN _qj919ji57() ;
	ACTIVATE _qj919ji5r() ;
	SHOW _qj919ji5u()

RELEASE WINDOW _qj919jbkj

#REGION 0
IF m.talkstat = "ON"
	SET TALK ON
ENDIF
IF m.compstat = "ON"
	SET COMPATIBLE ON
ENDIF


*       ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
*       ³                                                         ³
*       ³         ADDUSERS/MS-DOS: c¢digo de postprograma         ³
*       ³                                                         ³
*       ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
*

#REGION 1
SET EXACT OFF

ON KEY LABEL esc
SELECT (m.savearea)
RETURN m.status

*
* ALREADYIN - Check if name already in the list.
*


*       ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
*       ³                                                         ³
*       ³  ADDUSERS/MS-DOS: procedimientos y funciones de apoyo   ³
*       ³                                                         ³
*       ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
*

#REGION 1
FUNCTION alreadyin
PARAMETER m.newname
SET EXACT OFF
IF ASCAN(users, ALLTRIM(m.newname)) <> 0
	RETURN .T.
ENDIF
SET EXACT ON
RETURN .F.

*
* ESCHANDLER - Handle ESC-aping out of a field.
*
PROCEDURE eschandler
ON KEY LABEL esc
m.userlast  = SPACE(22)
m.userfirst = SPACE(14)
SHOW GET m.userlast DISABLE
SHOW GET m.userfirst DISABLE


*       ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
*       ³                                                         ³
*       ³ _QJ919JEVD           m.mover VALID                      ³
*       ³                                                         ³
*       ³ Funci¢n origen:                                         ³
*       ³                                                         ³
*       ³ Plataforma de origen: MS-DOS                            ³
*       ³ Pantalla de origen:   ADDUSERS,    N§ de registro:    2 ³
*       ³ Variable:             m.mover                           ³
*       ³ Llamada por:          VALID (cl usula)                  ³
*       ³ Tipo de objeto:       Bot¢n de comando                  ³
*       ³ N§ de miniprograma:   1                                 ³
*       ³                                                         ³
*       ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
*
FUNCTION _qj919jevd     &&  m.mover VALID
#REGION 1
DO CASE
CASE m.mover = 1
	IF alreadyin(allusers[m.alluser,3]))
		WAIT WINDOW "Entrada duplicada" NOWAIT
		RETURN .F.
	ENDIF
	IF m.usrcnt+1 > ALEN(users,1)
		DIMENSION users[m.usrcnt+1,3]
	ENDIF
	users[m.usrcnt+1,1] = allusers[m.alluser,1]
	users[m.usrcnt+1,2] = allusers[m.alluser,2]
	users[m.usrcnt+1,3] = allusers[m.alluser,3]
	m.usrcnt = m.usrcnt + 1
	m.user = m.usrcnt
	SHOW GET m.mover, 2 ENABLE
	IF m.usrcnt > 1
		SHOW GET m.mover, 3 ENABLE
	ENDIF
	SHOW GET m.user
CASE m.mover = 2
	= ADEL(users, m.user)
	m.usrcnt = m.usrcnt - 1
	m.user = m.usrcnt
	
	IF m.usrcnt = 0
		SHOW GET m.mover, 2 DISABLE
		SHOW GET m.mover, 3 DISABLE
	ENDIF
	SHOW GET m.user
CASE m.mover = 3
	users = ""
	m.usrcnt = 0
	SHOW GET m.mover, 2 DISABLE
	SHOW GET m.mover, 3 DISABLE
	SHOW GET m.user
CASE m.mover = 4
	m.userlast  = SPACE(22)
	m.userfirst = SPACE(14)
	SHOW GET m.userlast ENABLE
	_CUROBJ = OBJNUM(m.userlast)
CASE m.mover = 5
	CLEAR READ
ENDCASE


*       ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
*       ³                                                         ³
*       ³ _QJ919JFHT           m.alluser VALID                    ³
*       ³                                                         ³
*       ³ Funci¢n origen:                                         ³
*       ³                                                         ³
*       ³ Plataforma de origen: MS-DOS                            ³
*       ³ Pantalla de origen:   ADDUSERS,    N§ de registro:    3 ³
*       ³ Variable:             m.alluser                         ³
*       ³ Llamada por:          VALID (cl usula)                  ³
*       ³ Tipo de objeto:       Lista                             ³
*       ³ N§ de miniprograma:   2                                 ³
*       ³                                                         ³
*       ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
*
FUNCTION _qj919jfht     &&  m.alluser VALID
#REGION 1
IF alreadyin(allusers[m.alluser,3])
	WAIT WINDOW "Entrada duplicada" NOWAIT
	RETURN .F.
ENDIF
IF m.usrcnt+1 > ALEN(users,1)
	DIMENSION users[m.usrcnt+1,3]
ENDIF
	
users[m.usrcnt+1,1] = allusers[m.alluser,1]
users[m.usrcnt+1,2] = allusers[m.alluser,2]
users[m.usrcnt+1,3] = allusers[m.alluser,3]
m.usrcnt = m.usrcnt + 1
m.user = m.usrcnt

SHOW GET m.mover, 2 ENABLE
IF m.usrcnt > 1
	SHOW GET m.mover, 3 ENABLE
ENDIF
SHOW GET m.user
		


*       ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
*       ³                                                         ³
*       ³ _QJ919JFYV           m.user VALID                       ³
*       ³                                                         ³
*       ³ Funci¢n origen:                                         ³
*       ³                                                         ³
*       ³ Plataforma de origen: MS-DOS                            ³
*       ³ Pantalla de origen:   ADDUSERS,    N§ de registro:    4 ³
*       ³ Variable:             m.user                            ³
*       ³ Llamada por:          VALID (cl usula)                  ³
*       ³ Tipo de objeto:       Lista                             ³
*       ³ N§ de miniprograma:   3                                 ³
*       ³                                                         ³
*       ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
*
FUNCTION _qj919jfyv     &&  m.user VALID
#REGION 1
= ADEL(users, m.user)
m.usrcnt = m.usrcnt - 1
m.user = m.usrcnt
		
IF m.usrcnt = 0
	SHOW GET m.mover, 2 DISABLE
	SHOW GET m.mover, 3 DISABLE
ENDIF
SHOW GET m.user


*       ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
*       ³                                                         ³
*       ³ _QJ919JGDY           m.gethelp VALID                    ³
*       ³                                                         ³
*       ³ Funci¢n origen:                                         ³
*       ³                                                         ³
*       ³ Plataforma de origen: MS-DOS                            ³
*       ³ Pantalla de origen:   ADDUSERS,    N§ de registro:    5 ³
*       ³ Variable:             m.gethelp                         ³
*       ³ Llamada por:          VALID (cl usula)                  ³
*       ³ Tipo de objeto:       Bot¢n de comando                  ³
*       ³ N§ de miniprograma:   4                                 ³
*       ³                                                         ³
*       ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
*
FUNCTION _qj919jgdy     &&  m.gethelp VALID
#REGION 1
HELP ş Editar usuarios de tarjetas

*       ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
*       ³                                                         ³
*       ³ _QJ919JGOY           m.userlast WHEN                    ³
*       ³                                                         ³
*       ³ Funci¢n origen:                                         ³
*       ³                                                         ³
*       ³ Plataforma de origen: MS-DOS                            ³
*       ³ Pantalla de origen:   ADDUSERS,    N§ de registro:    6 ³
*       ³ Variable:             m.userlast                        ³
*       ³ Llamada por:          WHEN (cl usula)                   ³
*       ³ Tipo de objeto:       Campo                             ³
*       ³ N§ de miniprograma:   5                                 ³
*       ³                                                         ³
*       ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
*
FUNCTION _qj919jgoy     &&  m.userlast WHEN
#REGION 1
ON KEY LABEL esc DO eschandler


*       ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
*       ³                                                         ³
*       ³ _QJ919JGUX           m.userlast VALID                   ³
*       ³                                                         ³
*       ³ Funci¢n origen:                                         ³
*       ³                                                         ³
*       ³ Plataforma de origen: MS-DOS                            ³
*       ³ Pantalla de origen:   ADDUSERS,    N§ de registro:    6 ³
*       ³ Variable:             m.userlast                        ³
*       ³ Llamada por:          VALID (cl usula)                  ³
*       ³ Tipo de objeto:       Campo                             ³
*       ³ N§ de miniprograma:   6                                 ³
*       ³                                                         ³
*       ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
*
FUNCTION _qj919jgux     &&  m.userlast VALID
#REGION 1
IF EMPTY(m.userlast)
	RETURN .F.
ENDIF

SHOW GET m.userfirst ENABLE
_CUROBJ = OBJNUM(m.userfirst)

*       ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
*       ³                                                         ³
*       ³ _QJ919JH6S           m.userfirst WHEN                   ³
*       ³                                                         ³
*       ³ Funci¢n origen:                                         ³
*       ³                                                         ³
*       ³ Plataforma de origen: MS-DOS                            ³
*       ³ Pantalla de origen:   ADDUSERS,    N§ de registro:    7 ³
*       ³ Variable:             m.userfirst                       ³
*       ³ Llamada por:          WHEN (cl usula)                   ³
*       ³ Tipo de objeto:       Campo                             ³
*       ³ N§ de miniprograma:   7                                 ³
*       ³                                                         ³
*       ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
*
FUNCTION _qj919jh6s     &&  m.userfirst WHEN
#REGION 1
ON KEY LABEL esc DO eschandler

*       ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
*       ³                                                         ³
*       ³ _QJ919JHG4           m.userfirst VALID                  ³
*       ³                                                         ³
*       ³ Funci¢n origen:                                         ³
*       ³                                                         ³
*       ³ Plataforma de origen: MS-DOS                            ³
*       ³ Pantalla de origen:   ADDUSERS,    N§ de registro:    7 ³
*       ³ Variable:             m.userfirst                       ³
*       ³ Llamada por:          VALID (cl usula)                  ³
*       ³ Tipo de objeto:       Campo                             ³
*       ³ N§ de miniprograma:   8                                 ³
*       ³                                                         ³
*       ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
*
FUNCTION _qj919jhg4     &&  m.userfirst VALID
#REGION 1
IF EMPTY(m.userfirst)
	WAIT WINDOW "No se permiten entradas en blanco" NOWAIT
	RETURN .F.
ENDIF
IF alreadyin(ALLTRIM(m.userfirst)+" "+ALLTRIM(m.userlast))
	WAIT WINDOW "Entrada duplicada" NOWAIT
	RETURN .F.
ENDIF

IF m.usrcnt+1 > ALEN(users,1)
	DIMENSION users[m.usrcnt+1,3]
ENDIF
	
users[m.usrcnt+1,1] = m.userlast
users[m.usrcnt+1,2] = m.userfirst
users[m.usrcnt+1,3] = ALLTRIM(users[m.usrcnt+1,2])+;
	" "+ALLTRIM(users[m.usrcnt+1,1])

m.usrcnt = m.usrcnt + 1
m.user = m.usrcnt
	
SHOW GET m.mover, 2 ENABLE
IF m.usrcnt > 1
	SHOW GET m.mover, 3 ENABLE
ENDIF
SHOW GET m.user
	
m.userlast  = SPACE(22)
m.userfirst = SPACE(14)
SHOW GET m.userlast DISABLE
SHOW GET m.userfirst DISABLE

_CUROBJ = OBJNUM(m.mover)


*       ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
*       ³                                                         ³
*       ³ _QJ919JI57           WHEN de instrucci¢n READ           ³
*       ³                                                         ³
*       ³ Funci¢n origen:                                         ³
*       ³                                                         ³
*       ³                                                         ³
*       ³ Plataforma origen:      MS-DOS                          ³
*       ³ Pantalla origen:        ADDUSERS                        ³
*       ³ Llamado por:            Instrucci¢n READ                ³
*       ³ N§ de miniprograma:     9                               ³
*       ³                                                         ³
*       ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
*
FUNCTION _qj919ji57     && WHEN de instrucci¢n READ
*
* When Code from screen: ADDUSERS
*
#REGION 1
IF EMPTY(m.cardid)
	WAIT WINDOW "Primero debe introducir el ID de tarjeta" NOWAIT
	m.status = .F.
	RETURN .F.
ENDIF

*       ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
*       ³                                                         ³
*       ³ _QJ919JI5R           ACTIVATE de cl sula READ           ³
*       ³                                                         ³
*       ³ Funci¢n origen:                                         ³
*       ³                                                         ³
*       ³                                                         ³
*       ³ Plataforma origen:      MS-DOS                          ³
*       ³ Pantalla origen:        ADDUSERS                        ³
*       ³ Llamado por:            Instrucci¢n READ                ³
*       ³ N§ de miniprograma:     10                              ³
*       ³                                                         ³
*       ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
*
FUNCTION _qj919ji5r     && Read Level Activate
*
* Activate Code from screen: ADDUSERS
*
#REGION 1
SHOW GET m.mover, 1 PROMPT "\<Mover"+CHR(26)
SHOW GET m.mover, 2 PROMPT CHR(27)+" \<Quitar"

IF EMPTY(allusers)
	SHOW GET m.alluser DISABLE
ENDIF
IF m.usrcnt=0
	SHOW GET m.mover, 2 DISABLE
ENDIF

*       ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
*       ³                                                         ³
*       ³ _QJ919JI5U           SHOW de instrucci¢n READ           ³
*       ³                                                         ³
*       ³ Funci¢n origen:                                         ³
*       ³                                                         ³
*       ³                                                         ³
*       ³ Plataforma origen:      MS-DOS                          ³
*       ³ Pantalla origen:        ADDUSERS                        ³
*       ³ Llamado por:            Instrucci¢n READ                ³
*       ³ N§ de miniprograma:     11                              ³
*       ³                                                         ³
*       ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
*
FUNCTION _qj919ji5u     && SHOW de instrucci¢n READ
PRIVATE currwind
STORE WOUTPUT() TO currwind
*
* Show Code from screen: ADDUSERS
*
#REGION 1
IF m.usrcnt > 1
	SHOW GET m.mover, 3 ENABLE
ENDIF
IF NOT EMPTY(currwind)
	ACTIVATE WINDOW (currwind) SAME
ENDIF