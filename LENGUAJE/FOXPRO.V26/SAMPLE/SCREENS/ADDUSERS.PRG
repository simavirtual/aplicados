*       旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
*       �                                                         �
*       � 09/15/93            ADDUSERS.PRG               21:14:45 �
*       �                                                         �
*       쳐컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
*       �                                                         �
*       � Autor                                                   �
*       �                                                         �
*       � Copyright (c) 1993 Empresa                              �
*       � Direcci줻                                               �
*       � Ciudad,     C.P.                                        �
*       � Pa죛                                                    �
*       �                                                         �
*       � Descripci줻:                                            �
*       � Este programa lo ha generado autom쟴icamente GENSCRN.   �
*       �                                                         �
*       읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�

PARAMETERS m.cardid

*       旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
*       �                                                         �
*       �   ADDUSERS/MS-DOS: c줰igo de preprograma - SECCI�N 1    �
*       �                                                         �
*       읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
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

*       旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
*       �                                                         �
*       �            MS-DOS: definiciones de ventanas             �
*       �                                                         �
*       읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
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


*       旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
*       �                                                         �
*       �   ADDUSERS/MS-DOS: c줰igo de preprograma - SECCI�N 2    �
*       �                                                         �
*       읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
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

*       旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
*       �                                                         �
*       �        ADDUSERS/MS-DOS: distribuci줻 de pantalla        �
*       �                                                         �
*       읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
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
@ 0,2 SAY "Lista de selecci줻:" ;
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


*       旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
*       �                                                         �
*       �         ADDUSERS/MS-DOS: c줰igo de postprograma         �
*       �                                                         �
*       읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
*

#REGION 1
SET EXACT OFF

ON KEY LABEL esc
SELECT (m.savearea)
RETURN m.status

*
* ALREADYIN - Check if name already in the list.
*


*       旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
*       �                                                         �
*       �  ADDUSERS/MS-DOS: procedimientos y funciones de apoyo   �
*       �                                                         �
*       읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
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


*       旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
*       �                                                         �
*       � _QJ919JEVD           m.mover VALID                      �
*       �                                                         �
*       � Funci줻 origen:                                         �
*       �                                                         �
*       � Plataforma de origen: MS-DOS                            �
*       � Pantalla de origen:   ADDUSERS,    N� de registro:    2 �
*       � Variable:             m.mover                           �
*       � Llamada por:          VALID (cl쟵sula)                  �
*       � Tipo de objeto:       Bot줻 de comando                  �
*       � N� de miniprograma:   1                                 �
*       �                                                         �
*       읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
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


*       旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
*       �                                                         �
*       � _QJ919JFHT           m.alluser VALID                    �
*       �                                                         �
*       � Funci줻 origen:                                         �
*       �                                                         �
*       � Plataforma de origen: MS-DOS                            �
*       � Pantalla de origen:   ADDUSERS,    N� de registro:    3 �
*       � Variable:             m.alluser                         �
*       � Llamada por:          VALID (cl쟵sula)                  �
*       � Tipo de objeto:       Lista                             �
*       � N� de miniprograma:   2                                 �
*       �                                                         �
*       읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
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
		


*       旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
*       �                                                         �
*       � _QJ919JFYV           m.user VALID                       �
*       �                                                         �
*       � Funci줻 origen:                                         �
*       �                                                         �
*       � Plataforma de origen: MS-DOS                            �
*       � Pantalla de origen:   ADDUSERS,    N� de registro:    4 �
*       � Variable:             m.user                            �
*       � Llamada por:          VALID (cl쟵sula)                  �
*       � Tipo de objeto:       Lista                             �
*       � N� de miniprograma:   3                                 �
*       �                                                         �
*       읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
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


*       旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
*       �                                                         �
*       � _QJ919JGDY           m.gethelp VALID                    �
*       �                                                         �
*       � Funci줻 origen:                                         �
*       �                                                         �
*       � Plataforma de origen: MS-DOS                            �
*       � Pantalla de origen:   ADDUSERS,    N� de registro:    5 �
*       � Variable:             m.gethelp                         �
*       � Llamada por:          VALID (cl쟵sula)                  �
*       � Tipo de objeto:       Bot줻 de comando                  �
*       � N� de miniprograma:   4                                 �
*       �                                                         �
*       읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
*
FUNCTION _qj919jgdy     &&  m.gethelp VALID
#REGION 1
HELP � Editar usuarios de tarjetas

*       旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
*       �                                                         �
*       � _QJ919JGOY           m.userlast WHEN                    �
*       �                                                         �
*       � Funci줻 origen:                                         �
*       �                                                         �
*       � Plataforma de origen: MS-DOS                            �
*       � Pantalla de origen:   ADDUSERS,    N� de registro:    6 �
*       � Variable:             m.userlast                        �
*       � Llamada por:          WHEN (cl쟵sula)                   �
*       � Tipo de objeto:       Campo                             �
*       � N� de miniprograma:   5                                 �
*       �                                                         �
*       읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
*
FUNCTION _qj919jgoy     &&  m.userlast WHEN
#REGION 1
ON KEY LABEL esc DO eschandler


*       旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
*       �                                                         �
*       � _QJ919JGUX           m.userlast VALID                   �
*       �                                                         �
*       � Funci줻 origen:                                         �
*       �                                                         �
*       � Plataforma de origen: MS-DOS                            �
*       � Pantalla de origen:   ADDUSERS,    N� de registro:    6 �
*       � Variable:             m.userlast                        �
*       � Llamada por:          VALID (cl쟵sula)                  �
*       � Tipo de objeto:       Campo                             �
*       � N� de miniprograma:   6                                 �
*       �                                                         �
*       읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
*
FUNCTION _qj919jgux     &&  m.userlast VALID
#REGION 1
IF EMPTY(m.userlast)
	RETURN .F.
ENDIF

SHOW GET m.userfirst ENABLE
_CUROBJ = OBJNUM(m.userfirst)

*       旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
*       �                                                         �
*       � _QJ919JH6S           m.userfirst WHEN                   �
*       �                                                         �
*       � Funci줻 origen:                                         �
*       �                                                         �
*       � Plataforma de origen: MS-DOS                            �
*       � Pantalla de origen:   ADDUSERS,    N� de registro:    7 �
*       � Variable:             m.userfirst                       �
*       � Llamada por:          WHEN (cl쟵sula)                   �
*       � Tipo de objeto:       Campo                             �
*       � N� de miniprograma:   7                                 �
*       �                                                         �
*       읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
*
FUNCTION _qj919jh6s     &&  m.userfirst WHEN
#REGION 1
ON KEY LABEL esc DO eschandler

*       旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
*       �                                                         �
*       � _QJ919JHG4           m.userfirst VALID                  �
*       �                                                         �
*       � Funci줻 origen:                                         �
*       �                                                         �
*       � Plataforma de origen: MS-DOS                            �
*       � Pantalla de origen:   ADDUSERS,    N� de registro:    7 �
*       � Variable:             m.userfirst                       �
*       � Llamada por:          VALID (cl쟵sula)                  �
*       � Tipo de objeto:       Campo                             �
*       � N� de miniprograma:   8                                 �
*       �                                                         �
*       읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
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


*       旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
*       �                                                         �
*       � _QJ919JI57           WHEN de instrucci줻 READ           �
*       �                                                         �
*       � Funci줻 origen:                                         �
*       �                                                         �
*       �                                                         �
*       � Plataforma origen:      MS-DOS                          �
*       � Pantalla origen:        ADDUSERS                        �
*       � Llamado por:            Instrucci줻 READ                �
*       � N� de miniprograma:     9                               �
*       �                                                         �
*       읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
*
FUNCTION _qj919ji57     && WHEN de instrucci줻 READ
*
* When Code from screen: ADDUSERS
*
#REGION 1
IF EMPTY(m.cardid)
	WAIT WINDOW "Primero debe introducir el ID de tarjeta" NOWAIT
	m.status = .F.
	RETURN .F.
ENDIF

*       旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
*       �                                                         �
*       � _QJ919JI5R           ACTIVATE de cl쟳ula READ           �
*       �                                                         �
*       � Funci줻 origen:                                         �
*       �                                                         �
*       �                                                         �
*       � Plataforma origen:      MS-DOS                          �
*       � Pantalla origen:        ADDUSERS                        �
*       � Llamado por:            Instrucci줻 READ                �
*       � N� de miniprograma:     10                              �
*       �                                                         �
*       읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
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

*       旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
*       �                                                         �
*       � _QJ919JI5U           SHOW de instrucci줻 READ           �
*       �                                                         �
*       � Funci줻 origen:                                         �
*       �                                                         �
*       �                                                         �
*       � Plataforma origen:      MS-DOS                          �
*       � Pantalla origen:        ADDUSERS                        �
*       � Llamado por:            Instrucci줻 READ                �
*       � N� de miniprograma:     11                              �
*       �                                                         �
*       읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
*
FUNCTION _qj919ji5u     && SHOW de instrucci줻 READ
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