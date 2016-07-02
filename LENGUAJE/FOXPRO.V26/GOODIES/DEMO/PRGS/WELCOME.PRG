* * * * * * * * * * * * * * * * * * * * * * * * * *
* WELCOME is the procedure that provides the actions for
* the Welcome to FoxPro topic.
*
clear typeahead
set escape on
on key label escape do escout
on escape do escout
activate screen
clear

** display intro sceen in large font
set blink off  && for proper colors
* do bigchars with 6,14,"Welcome|   to| FoxPro"
do bigchars with 6,4,"Bienvenidos|     a|   FoxPro"
do apause
for cnt = 1 to 28
	release window ("letter"+alltrim(str(cnt)))
endfor
set blink on
SET SYSMENU TO 

SET SYSMENU AUTOMATIC

DEFINE PAD _pw30kdvp0 OF _MSYSMENU PROMPT "\<Sistema" COLOR SCHEME 3 ;
	KEY ALT+S, ""
DEFINE PAD _pw30kdvvd OF _MSYSMENU PROMPT "\<Archivo" COLOR SCHEME 3 ;
	KEY ALT+A, ""
DEFINE PAD _pw30kdvwb OF _MSYSMENU PROMPT "\<Edici¢n" COLOR SCHEME 3 ;
	KEY ALT+E, ""
DEFINE PAD _pw30kdvy4 OF _MSYSMENU PROMPT "Ta\<bla" COLOR SCHEME 3 ;
	KEY ALT+B, ""
DEFINE PAD _pw30kdvz5 OF _MSYSMENU PROMPT "\<Registro" COLOR SCHEME 3 ;
	KEY ALT+R, ""
DEFINE PAD _pw30kdw02 OF _MSYSMENU PROMPT "\<Programa" COLOR SCHEME 3 ;
	KEY ALT+P, ""
DEFINE PAD _pw30kdw1p OF _MSYSMENU PROMPT "\<Ventana" COLOR SCHEME 3 ;
	KEY ALT+V, ""

DEFINE WINDOW welcome1 from 14,5 to 21,75 DOUBLE COLOR SCHEME 12 TITLE " Bienvenidos a FoxPro 2.5 " SHADOW
ACTIVATE WINDOW welcome1
@ 1,1 say "                 Bienvenidos a la AutoDemo de FoxPro"                    
@ 3,1 say " En esta Demo ver  algunas de las numerosas herramientas de FoxPro"
@ 4,1 say " que le permitir n trabajar con sus datos. Con estas herramientas"
@ 5,1 say " es muy f cil crear y editar datos, y extraer valiosa informaci¢n."
do apause
release window welcome1

DEFINE WINDOW welcome2 from 17,5 to 21,75 DOUBLE COLOR SCHEME 12 TITLE " Bienvenidos a FoxPro 2.5 " SHADOW
ACTIVATE WINDOW welcome2

@ 0,1 say "   Para comunicarse con FoxPro puede utilizar mouse o teclado, lo"
@ 1,1 say "   que prefiera. Para indicarle a FoxPro lo que tiene que hacer, "
@ 2,1 say "   basta seleccionar las opciones deseadas del sistema de men£s."
do apause
define window menusys from 20,54 to 20,70 none noshadow COLOR SCHEME 12
@ 2,48 say "sistema de men£s" color w+/r
activate window menusys
@ 0,0 say "sistema de men£s"
for cnt = 20 to 17 step -1
	move window menusys to cnt,54
	do inpause with 4
endfor
release window menusys
define window menusys from 16,54 to 16,70 none noshadow
activate window menusys
@ 0,0 say "sistema de men£s"  COLOR GR+/B
for cnt = 16 to 2 step -1
	move window menusys to cnt,54
	do inpause with 4
endfor

for cnt = 48 to 64
	move window menusys to 2,cnt
	do inpause with 4
endfor
release window menusys

define window littlewin from 1,1 to 14,36 none noshadow 
activate window littlewin 
@ 0,0 say "       "  COLOR GR+/B
@ 1,0 say " Barra de men£s del sistema"  COLOR GR+/B
for cnt = 46 to 26 step -1
	move window littlewin to 1,cnt
	do inpause with 4
endfor
DEFINE WINDOW syspop ;
	FROM 1, 0 ;
	TO 13,25 ;
	NOFLOAT ;
	NOCLOSE ;
	SHADOW ;
	NONE ;
	COLOR SCHEME 4

ACTIVATE WINDOW syspop NOSHOW
@ 4,0 TO 4,25 ;
	COLOR N/W     
@ 0,0 TO 12,25 ;
	COLOR N/W     
@ 4,0 SAY "Ã" ;
	COLOR N/W     
@ 4,25 SAY "´" ;
	COLOR N/W     
@ 1,2 SAY "A" ;
	COLOR W+/W    
@ 1,3 SAY "cerca de FoxPro..." ;
	COLOR N/W     
@ 2,2 SAY "Ay" ;
	COLOR N/W    
@ 2,4 SAY "u" ;
	COLOR W+/W    
@ 2,5 SAY "da..." ;
	COLOR N/W     
@ 3,2 SAY "M" ;
	COLOR W+/W    
@ 3,3 SAY "acros..." ;
	COLOR N/W     
@ 2,21 SAY "F1" ;
	COLOR W+/W    
@ 5,5 SAY "h" ;
	COLOR W+/W    
@ 6,2 SAY "C" ;
	COLOR W+/W    
@ 5,2 SAY "Arc" ;
	COLOR N/W     
@ 5,6 SAY "ivador" ;
	COLOR N/W     
@ 6,3 SAY "alculadora" ;
	COLOR N/W     
@ 7,4 SAY "l" ;
	COLOR W+/W    
@ 7,2 SAY "Ca" ;
	COLOR N/W     
@ 7,5 SAY "endario/Agenda" ;
	COLOR N/W     
@ 8,2 SAY "Caract" ;
	COLOR N/W     
@ 8,9 SAY "res especiales" ;
	COLOR N/W     
@ 8,8 SAY "e" ;
	COLOR W+/W    
*@ 9,2 SAY "ASC" ;
*	COLOR N/W     
@ 9,2 SAY "T" ;
	COLOR W+/W    
@ 9,3 SAY "abla ASCII" ;
	COLOR N/W     
@ 10,2 SAY "Ca" ;
	COLOR N/W     
@ 10,4 SAY "p" ;
	COLOR W+/W    
@ 10,5 SAY "turar" ;
	COLOR N/W     
@ 11,2 SAY "Pu" ;
	COLOR N/W     
@ 11,4 SAY "z" ;
	COLOR W+/W    
@ 11,5 SAY "zle" ;
	COLOR N/W     

show WINDOW syspop
activate window littlewin
@ 0,0 say "                           "  COLOR GR+/B
@ 1,0 say " Barra de men£s del sistema"  COLOR GR+/B
do inpause with 4
@ 1,0 say "                           "  COLOR GR+/B
@ 2,0 say " Barra de men£s del sistema"  COLOR GR+/B
do inpause with 4
@ 2,0 say "                           "  COLOR GR+/B
@ 3,0 say " Barra de men£s del sistema"  COLOR GR+/B
do inpause with 4
@ 3,0 say "                           "  COLOR GR+/B
@ 4,0 say " Barra de men£s del sistema"  COLOR GR+/B
do inpause with 4
@ 4,0 say "                           "  COLOR GR+/B
@ 5,0 say " Barra de men£s del sistema"  COLOR GR+/B
do inpause with 4
@ 5,0 say "                           "  COLOR GR+/B
@ 6,0 say " Barra de men£s del sistema"  COLOR GR+/B
do inpause with 4
@ 6,0 say "ÍÍÍ Men£ del sistema      "  COLOR GR+/B
do inpause with 4
@ 5,0 say "Ä¿"  COLOR GR+/B
@ 6,0 say "  ÆÍ Men£ del sistema      "  COLOR GR+/B
@ 7,0 say "ÄÙ"  COLOR GR+/B
do inpause with 4
@ 4,0 say "Ä¿"  COLOR GR+/B
@ 5,0 say "  ³"  COLOR GR+/B
@ 7,0 say "  ³"  COLOR GR+/B
@ 8,0 say "ÄÙ"  COLOR GR+/B
do inpause with 4
@ 3,0 say "Ä¿"  COLOR GR+/B
@ 4,0 say "  ³"  COLOR GR+/B
@ 8,0 say "  ³"  COLOR GR+/B
@ 9,0 say "ÄÙ"  COLOR GR+/B
do inpause with 4
@ 2,0 say "Ä¿"  COLOR GR+/B
@ 3,0 say "  ³"  COLOR GR+/B
@ 9,0 say "  ³"  COLOR GR+/B
@ 10,0 say "ÄÙ"  COLOR GR+/B
do inpause with 4
@ 1,0 say "Ä¿"  COLOR GR+/B
@ 2,0 say "  ³"  COLOR GR+/B
@ 10,0 say "  ³"  COLOR GR+/B
@ 11,0 say "ÄÙ"  COLOR GR+/B
do inpause with 4
@ 0,0 say "Ä¿"  COLOR GR+/B
@ 1,0 say "  ³"  COLOR GR+/B
@ 11,0 say "  ³"  COLOR GR+/B
@ 12,0 say "ÄÙ"  COLOR GR+/B
do apause

DEFINE WINDOW filepop ;
	FROM 1, 10 ;
	TO 14,37 ;
	NOFLOAT ;
	NOCLOSE ;
	SHADOW ;
	NONE ;
	COLOR SCHEME 4

ACTIVATE WINDOW filepop NOSHOW
@ 0,0 TO 13,27 ;
	COLOR N/W     
@ 4,0 TO 4,27 ;
	COLOR N/W     
@ 8,0 TO 8,27 ;
	COLOR N/W     
@ 11,0 TO 11,27 ;
	COLOR N/W     
@ 11,0 SAY "Ã" ;
	COLOR N/W     
@ 11,27 SAY "´" ;
	COLOR N/W     
@ 8,0 SAY "Ã" ;
	COLOR N/W     
@ 8,27 SAY "´" ;
	COLOR N/W     
@ 4,0 SAY "Ã" ;
	COLOR N/W     
@ 4,27 SAY "´" ;
	COLOR N/W     
@ 1,2 SAY "N" ;
	COLOR W+/W    
@ 2,2 SAY "A" ;
	COLOR W+/W    
@ 3,2 SAY "C" ;
	COLOR W+/W    
@ 1,3 SAY "uevo..." ;
	COLOR N/W     
@ 2,3 SAY "brir..." ;
	COLOR N/W     
@ 3,3 SAY "errar" ;
	COLOR N/W     
@ 5,2 SAY "G" ;
	COLOR W+/W    
@ 5,3 SAY "uardar" ;
	COLOR N/W     
@ 6,2 SAY "Guardar c" ;
	COLOR N/W     
@ 6,11 SAY "o" ;
	COLOR W+/W    
@ 6,12 SAY "mo..." ;
	COLOR N/W     
@ 7,2 SAY "R" ;
	COLOR W+/W    
@ 7,3 SAY "evertir" ;
	COLOR N/W     
@ 9,3 SAY "specificar impresora..." ;
	COLOR N/W     
@ 9,2 SAY "E" ;
	COLOR W+/W    
*@ 9,2 SAY "Pr" ;
*	COLOR N/W     
@ 10,2 SAY "I" ;
	COLOR W+/W    
@ 10,3 SAY "mprimir..." ;
	COLOR N/W     
@ 12,2 SAY "S" ;
	COLOR W+/W    
@ 12,3 SAY "alir" ;
	COLOR N/W     
release window syspop

activate window littlewin
@ 6,0 say "  ÆÍ Men£ Archivo       "  COLOR GR+/B
@ 12,0 say "  ³"  COLOR GR+/B
@ 13,0 say "ÄÙ"  COLOR GR+/B
*for cnt = 25 to 30 
for cnt = 25 to 38 
	move window littlewin to 1,cnt
	do inpause with 4
endfor

ACTIVATE WINDOW filepop
do apause
DEFINE WINDOW editpop ;
	FROM 1, 19 ;
	TO 19,52 ;
	NOFLOAT ;
	NOCLOSE ;
	SHADOW ;
	NONE ;
	COLOR SCHEME 4

ACTIVATE WINDOW editpop NOSHOW
@ 0,0 TO 18,33 ;
	COLOR N/W     
@ 3,0 TO 3,33 ;
	COLOR N/W     
@ 8,0 TO 8,33 ;
	COLOR N/W     
@ 10,0 TO 10,33 ;
	COLOR N/W     
@ 16,0 TO 16,33 ;
	COLOR N/W     
@ 16,0 SAY "Ã" ;
	COLOR N/W     
@ 16,33 SAY "´" ;
	COLOR N/W     
@ 10,0 SAY "Ã" ;
	COLOR N/W     
@ 10,33 SAY "´" ;
	COLOR N/W     
@ 8,0 SAY "Ã" ;
	COLOR N/W     
@ 8,33 SAY "´" ;
	COLOR N/W     
@ 3,0 SAY "Ã" ;
	COLOR N/W     
@ 3,33 SAY "´" ;
	COLOR N/W     
@ 1,2 SAY "D" ;
	COLOR W+/W    
@ 2,2 SAY "R" ;
	COLOR W+/W    
@ 1,3 SAY "eshacer" ;
	COLOR N/W     
@ 2,3 SAY "ehacer" ;
	COLOR N/W     
@ 4,2 SAY "Cor" ;
	COLOR N/W     
@ 4,6 SAY "ar" ;
	COLOR N/W     
@ 4,5 SAY "t" ;
	COLOR W+/W    
@ 5,2 SAY "C" ;
	COLOR W+/W    
@ 5,3 SAY "opiar" ;
	COLOR N/W     
@ 6,2 SAY "P" ;
	COLOR W+/W    
@ 6,3 SAY "egar" ;
	COLOR N/W     
@ 7,2 SAY "Borrar" ;
	COLOR N/W     
@ 9,3 SAY "eleccionar todo" ;
	COLOR N/W     
@ 9,2 SAY "S" ;
	COLOR W+/W    
* @ 9,10 SAY "ll" ;
*	COLOR N/W     
@ 11,3 SAY "r a l¡nea... " ;
	COLOR N/W     
@ 11,2 SAY "I" ;
	COLOR W+/W    
*@ 11,8 SAY "ine..." ;
*	COLOR N/W     
@ 12,2 SAY "B" ;
	COLOR W+/W    
@ 12,3 SAY "uscar..." ;
	COLOR N/W     
@ 13,2 SAY "Buscar si" ;
	COLOR N/W     
@ 13,11 SAY "g" ;
	COLOR W+/W    
@ 13,12 SAY "uiente" ;
	COLOR N/W     
@ 14,2 SAY "Ree" ;
	COLOR N/W     
@ 14,5 SAY "m" ;
	COLOR W+/W    
@ 14,6 SAY "plazar/Buscar siguiente" ;
	COLOR N/W     
@ 15,2 SAY "Reemplazar todo" ;
	COLOR N/W     
@ 17,2 SAY "Prefere" ;
	COLOR N/W     
@ 17,9 SAY "n" ;
	COLOR W+/W    
@ 17,10 SAY "cias..." ;
	COLOR N/W     
@ 1,30 SAY "^Z" ;
	COLOR W+/W    
@ 2,30 SAY "^R" ;
	COLOR W+/W    
@ 4,30 SAY "^X" ;
	COLOR W+/W    
@ 5,30 SAY "^C" ;
	COLOR W+/W    
@ 6,30 SAY "^V" ;
	COLOR W+/W    
@ 9,30 SAY "^A" ;
	COLOR W+/W    
@ 12,30 SAY "^F" ;
	COLOR W+/W    
@ 13,30 SAY "^G" ;
	COLOR W+/W    
@ 14,30 SAY "^E" ;
	COLOR W+/W    

release window filepop

activate window littlewin
@ 6,0 say "  ÆÍ Men£ Edici¢n        "  COLOR GR+/B
for cnt = 38 to 53 
	move window littlewin to 1,cnt
	do inpause with 4
endfor

ACTIVATE WINDOW editpop
do apause
DEFINE WINDOW datapop ;
	FROM 1, 28 ;
	TO 19,46 ;
	NOFLOAT ;
	NOCLOSE ;
	SHADOW ;
	NONE ;
	COLOR SCHEME 4

ACTIVATE WINDOW datapop NOSHOW
@ 0,0 TO 18,18 ;
	COLOR N/W     
@ 3,0 TO 3,18 ;
	COLOR N/W     
@ 8,0 TO 8,18 ;
	COLOR N/W     
@ 15,0 TO 15,18 ;
	COLOR N/W     
@ 15,0 SAY "Ã" ;
	COLOR N/W     
@ 15,18 SAY "´" ;
	COLOR N/W     
@ 8,0 SAY "Ã" ;
	COLOR N/W     
@ 8,18 SAY "´" ;
	COLOR N/W     
@ 3,0 SAY "Ã" ;
	COLOR N/W     
@ 3,18 SAY "´" ;
	COLOR N/W     
@ 1,2 SAY "Con";
	COLOR N/W     
@ 1,5 SAY "f" ;
	COLOR W+/W    
@ 1,6 SAY "igurar..." ;
	COLOR N/W     
@ 2,2 SAY "E" ;
	COLOR N/W     
@ 2,3 SAY "x" ;
	COLOR W+/W    
@ 2,4 SAY "aminar" ;
	COLOR N/W     
@ 4,2 SAY "A" ;
	COLOR W+/W    
@ 5,2 SAY "C" ;
	COLOR W+/W    
@ 6,2 SAY "O" ;
	COLOR W+/W    
@ 7,2 SAY "T" ;
	COLOR W+/W    
@ 4,3 SAY "¤adir desde..." ;
	COLOR N/W     
@ 5,3 SAY "opiar a..." ;
	COLOR N/W     
@ 6,3 SAY "rdenar..." ;
	COLOR N/W     
@ 7,3 SAY "otal..." ;
	COLOR N/W     
*@ 9,2 SAY "A" ;
*	COLOR N/W     
@ 9,2 SAY "P" ;
	COLOR W+/W    
@ 9,3 SAY "romedio..." ;
	COLOR N/W     
*@ 10,2 SAY "C" ;
*	COLOR N/W     
@ 10,2 SAY "R" ;
	COLOR W+/W    
@ 10,3 SAY "ecuento..." ;
	COLOR N/W     
@ 11,3 SAY "uma..." ;
	COLOR N/W     
@ 11,2 SAY "S" ;
	COLOR W+/W    
*@ 11,5 SAY "..." ;
*	COLOR N/W     
@ 12,2 SAY "Ca" ;
	COLOR N/W     
@ 12,4 SAY "l" ;
	COLOR W+/W    
@ 12,5 SAY "cular..." ;
	COLOR N/W     
@ 13,2 SAY "I" ;
	COLOR W+/W    
@ 14,2 SAY "E" ;
	COLOR W+/W    
@ 13,3 SAY "nforme..." ;
	COLOR N/W     
@ 14,3 SAY "tiqueta..." ;
	COLOR N/W     
@ 16,7 SAY "u" ;
	COLOR W+/W    
@ 16,8 SAY "etar" ;
	COLOR N/W     
@ 16,2 SAY "Empaq" ;
	COLOR N/W     
@ 17,2 SAY "Reinde" ;
	COLOR N/W     
@ 17,8 SAY "x" ;
	COLOR W+/W    
@ 17,9 SAY "ar" ;
	COLOR N/W     

release window editpop

activate window littlewin
@ 6,0 say "  ÆÍ Men£ Tabla   "  COLOR GR+/B
@ 12,0 say "ÄÙ"  COLOR GR+/B
@ 13,0 say "   "  COLOR GR+/B
for cnt = 55 to 47 step -1 
	move window littlewin to 1,cnt
	do inpause with 4
endfor

ACTIVATE WINDOW datapop
do apause
DEFINE WINDOW recopop ;
	FROM 1, 35 ;
	TO 13,50 ;
	NOFLOAT ;
	NOCLOSE ;
	SHADOW ;
	NONE ;
	COLOR SCHEME 4

ACTIVATE WINDOW recopop NOSHOW
@ 0,0 TO 12,15 ;
	COLOR N/W     
@ 3,0 TO 3,15 ;
	COLOR N/W     
@ 8,0 TO 8,15 ;
	COLOR N/W     
@ 8,0 SAY "Ã" ;
	COLOR N/W     
@ 8,15 SAY "´" ;
	COLOR N/W     
@ 3,0 SAY "Ã" ;
	COLOR N/W     
@ 3,15 SAY "´" ;
	COLOR N/W     
@ 1,2 SAY "A" ;
	COLOR W+/W    
@ 1,3 SAY "¤adir" ;
	COLOR N/W     
@ 2,3 SAY "ambiar" ;
	COLOR N/W     
@ 2,2 SAY "C" ;
	COLOR W+/W    
@ 4,2 SAY "I" ;
	COLOR W+/W    
@ 5,2 SAY "E" ;
	COLOR W+/W    
@ 6,3 SAY "o" ;
	COLOR W+/W    
@ 7,2 SAY "B" ;
	COLOR W+/W    
@ 10,2 SAY "l" ;
	COLOR W+/W    
@ 11,2 SAY "D" ;
	COLOR W+/W    
@ 9,2 SAY "R" ;
	COLOR W+/W    
@ 4,3 SAY "r a..." ;
	COLOR N/W     
@ 5,3 SAY "ncontrar..." ;
	COLOR N/W     
@ 6,2 SAY "C" ;
	COLOR N/W     
@ 6,4 SAY "ntinuar" ;
	COLOR N/W     
@ 7,3 SAY "uscar..." ;
	COLOR N/W     
@ 9,3 SAY "eemplazar" ;
	COLOR N/W     
@ 10,2 SAY "E" ;
	COLOR N/W     
@ 10,3 SAY "liminar..." ;
	COLOR N/W     
@ 11,3 SAY "esmarcar..." ;
	COLOR N/W     
@ 6,12 SAY "^O" ;
	COLOR W+/W    
release window datapop

activate window littlewin
@ 6,0 say "  ÆÍ Men£ Registro      "  COLOR GR+/B
for cnt = 46 to 51
	move window littlewin to 1,cnt
	do inpause with 4
endfor

ACTIVATE WINDOW recopop
do apause
DEFINE WINDOW progpop ;
	FROM 1, 45 ;
	TO 11,59 ;
	NOFLOAT ;
	NOCLOSE ;
	SHADOW ;
	NONE ;
	COLOR SCHEME 4

ACTIVATE WINDOW progpop NOSHOW
@ 0,0 TO 10,14 ;
	COLOR N/W     
@ 2,0 TO 2,14 ;
	COLOR N/W     
@ 5,0 TO 5,14 ;
	COLOR N/W     
@ 5,0 SAY "Ã" ;
	COLOR N/W     
@ 5,14 SAY "´" ;
	COLOR N/W     
@ 2,0 SAY "Ã" ;
	COLOR N/W     
@ 2,14 SAY "´" ;
	COLOR N/W     
@ 3,2 SAY "C" ;
	COLOR W+/W    
@ 4,2 SAY "R" ;
	COLOR W+/W    
@ 6,4 SAY "m" ;
	COLOR W+/W    
@ 7,4 SAY "n" ;
	COLOR W+/W    
@ 8,4 SAY "x" ;
	COLOR W+/W    
@ 9,5 SAY "G" ;
	COLOR W+/W    
@ 3,3 SAY "ancelar" ;
	COLOR N/W     
@ 4,3 SAY "eanudar" ;
	COLOR N/W     
@ 6,2 SAY "Co" ;
	COLOR N/W     
@ 6,5 SAY "pilar..." ;
	COLOR N/W     
@ 7,2 SAY "Ge" ;
	COLOR N/W     
@ 7,5 SAY "erar..." ;
	COLOR N/W     
@ 8,2 SAY "Fo" ;
	COLOR N/W     
@ 8,5 SAY "Doc" ;
	COLOR N/W     
@ 9,2 SAY "Fox" ;
	COLOR N/W     
@ 9,6 SAY "raph..." ;
	COLOR N/W     
*@ 1,11 SAY "^E" ;
*	COLOR W+/W    
@ 4,11 SAY "^R" ;
	COLOR W+/W    
@ 1,3 SAY "jecutar..." ;
	COLOR N/W     
@ 1,2 SAY "E" ;
	COLOR W+/W    

release window recopop

activate window littlewin
for cnt = 50 to 19 step -1
	move window littlewin to 1,cnt
	do inpause with 4
endfor
@ 0,0 say "   "  COLOR GR+/B
@ 12,0 say "   "  COLOR GR+/B
do inpause with 4
@ 1,0 say "   "  COLOR GR+/B
@ 11,0 say "   "  COLOR GR+/B
do inpause with 4
@ 2,0 say "   "  COLOR GR+/B
@ 10,0 say "   "  COLOR GR+/B
do inpause with 4
@ 3,0 say "   "  COLOR GR+/B
@ 9,0 say "   "  COLOR GR+/B
do inpause with 4
@ 4,0 say "   "  COLOR GR+/B
@ 8,0 say "   "  COLOR GR+/B
do inpause with 4
@ 5,0 say "   "  COLOR GR+/B
@ 7,0 say "   "  COLOR GR+/B
do inpause with 4
@ 6,0 say "  ÆÍÍÍÍÍÍÍMen£ Programa"  COLOR GR+/B
do inpause with 4
@ 6,0 say "  ÆÍÍÍÍMen£ Programa   "  COLOR GR+/B
do inpause with 4
@ 6,0 say "  ÆÍMen£ Programa      "  COLOR GR+/B
do inpause with 4
@ 6,0 say "  Men£ Programa        "  COLOR GR+/B
do inpause with 4
@ 6,0 say "  Men£ ProgramaÍÍÍÍÍµ  "  COLOR GR+/B
do inpause with 4
@ 6,0 say "  Men£ ProgramaÍÍÍÍÍÍµ  "  COLOR GR+/B
do inpause with 4
@ 6,0 say "  Men£ ProgramaÍÍÍÍÍÍÍµ  "  COLOR GR+/B
@ 7,0 say "                      ³  "  COLOR GR+/B
do inpause with 4
@ 8,0 say "                      ³  "  COLOR GR+/B
@ 5,0 say "                      ³  "  COLOR GR+/B
do inpause with 4
@ 9,0 say "                      ³  "  COLOR GR+/B
@ 4,0 say "                      ³  "  COLOR GR+/B
do inpause with 4
@ 10,0 say "                      ÀÄ"  COLOR GR+/B
@ 3,0 say "                      ³  "  COLOR GR+/B
do inpause with 4
@ 2,0 say "                      ³  "  COLOR GR+/B
@ 1,0 say "                      ³  "  COLOR GR+/B
do inpause with 4
@ 0,0 say "                      ÚÄ"  COLOR GR+/B

ACTIVATE WINDOW progpop
do apause
DEFINE WINDOW windpop ;
	FROM 1, 55 ;
	TO 16,71 ;
	NOFLOAT ;
	NOCLOSE ;
	SHADOW ;
	NONE ;
	COLOR SCHEME 4

ACTIVATE WINDOW windpop NOSHOW
@ 0,0 TO 15,16 ;
	COLOR N/W     
@ 3,0 TO 3,16 ;
	COLOR N/W     
@ 10,0 TO 10,16 ;
	COLOR N/W     
@ 10,0 SAY "Ã" ;
	COLOR N/W     
@ 10,16 SAY "´" ;
	COLOR N/W     
@ 3,0 SAY "Ã" ;
	COLOR N/W     
@ 3,16 SAY "´" ;
	COLOR N/W     
@ 1,2 SAY "Oc" ;
	COLOR N/W    
@ 1,4 SAY "u" ;
	COLOR W+/W    
@ 2,2 SAY "B" ;
	COLOR W+/W    
@ 4,2 SAY "M" ;
	COLOR W+/W    
@ 5,2 SAY "T" ;
	COLOR W+/W    
@ 6,2 SAY "Z" ;
	COLOR W+/W    
@ 7,3 SAY "o" ;
	COLOR W+/W    
@ 8,2 SAY "R" ;
	COLOR W+/W    
@ 9,4 SAY "l" ;
	COLOR W+/W    
@ 12,2 SAY "D" ;
	COLOR W+/W    
@ 13,2 SAY "S" ;
	COLOR W+/W    
@ 14,2 SAY "V" ;
	COLOR W+/W    
@ 1,5 SAY "ltar" ;
	COLOR N/W     
@ 2,3 SAY "orrar" ;
	COLOR N/W     
@ 4,3 SAY "over" ;
	COLOR N/W     
@ 5,3 SAY "ama¤o" ;
	COLOR N/W     
@ 6,3 SAY "oom " ;
	COLOR N/W     
@ 7,2 SAY "Z" ;
	COLOR N/W     
@ 8,3 SAY "ecorrer" ;
	COLOR N/W     
@ 9,2 SAY "Co" ;
	COLOR N/W     
@ 9,5 SAY "or..." ;
	COLOR N/W     
@ 11,2 SAY "Comandos" ;
	COLOR N/W     
@ 12,3 SAY "epuraci¢n" ;
	COLOR N/W     
@ 13,3 SAY "eguimiento" ;
	COLOR N/W     
@ 14,3 SAY "er" ;
	COLOR N/W     
@ 11,12 SAY "^F2" ;
	COLOR W+/W    
@ 8,12 SAY "^F1" ;
	COLOR W+/W    
@ 7,12 SAY "^F9" ;
	COLOR W+/W    
@ 6,11 SAY "^F10" ;
	COLOR W+/W    
@ 5,12 SAY "^F8" ;
	COLOR W+/W    
@ 5,12 SAY "^F7" ;
	COLOR W+/W    
@ 6,7 SAY "" ;
	COLOR N/W     
@ 7,8 SAY "" ;
	COLOR N/W     
@ 7,4 SAY "om" ;
	COLOR N/W     
release window progpop

activate window littlewin
@ 6,0 say  "        Men£ Ventana Íµ  "  COLOR GR+/B
@ 10,0 say "                      ³  "  COLOR GR+/B
@ 11,0 say "                      ³  "  COLOR GR+/B
@ 12,0 say "                      ³  "  COLOR GR+/B
@ 13,0 say "                      ÀÄ"  COLOR GR+/B
do inpause with 4
for cnt = 19 to 29
	move window littlewin to 1,cnt
	do inpause with 4
endfor

ACTIVATE WINDOW windpop
do apause
@ 14,0 say "                         "  COLOR GR+/B
@ 0,0 say "                         "  COLOR GR+/B
do inpause with 4
release window windpop
@ 13,0 say "                         "  COLOR GR+/B
@ 0,0 say "                         "  COLOR GR+/B
do inpause with 4
@ 12,0 say "                         "  COLOR GR+/B
@ 1,0 say "                         "  COLOR GR+/B
do inpause with 4
@ 11,0 say "                         "  COLOR GR+/B
@ 2,0 say "                         "  COLOR GR+/B
do inpause with 4
@ 10,0 say "                         "  COLOR GR+/B
@ 3,0 say "                         "  COLOR GR+/B
do inpause with 4
@ 9,0 say "                         "  COLOR GR+/B
@ 4,0 say "                         "  COLOR GR+/B
do inpause with 4
@ 8,0 say "                         "  COLOR GR+/B
@ 5,0 say "                         "  COLOR GR+/B
do inpause with 4
release window littlewin

define window menusys from 7,54 to 7,70 none noshadow
activate window menusys
@ 0,0 say "sistema de men£s"  COLOR GR+/B
for cnt = 7 to 16
	move window menusys to cnt,54
	do inpause with 4
endfor
release window menusys
define window menusys from 17,54 to 17,70 none noshadow COLOR SCHEME 12
activate window menusys
@ 0,0 say "sistema de men£s"
for cnt = 17 to 19
	move window menusys to cnt,54
	do inpause with 4
endfor
do inpause with 6

activate window welcome2
release window menusys
@ 0,1 say "  Los detalles adicionales acerca de lo que FoxPro debe hacer se "
@ 1,1 say "  indican mediante cuadros de di logo, que contienen botones de  "
@ 2,1 say "  comando, botones radio, listas, casillas de verificaci¢n, etc. "
do apause

declare fakeit(9)
fakeit(1) = "[..]"
fakeit(2) = "[DBFS]"
fakeit(3) = "[SAMPLES]"
fakeit(4) = "CLIENTES.DBF"
fakeit(5) = "DETALLES.DBF"
fakeit(6) = "FACTURAS.DBF"
fakeit(7) = "OFICINAS"
fakeit(8) = "PARTES"
fakeit(9) = "VENDEDOR"
	
DEFINE WINDOW fakediag ;
		FROM 3,15 TO 20,64;
		FLOAT ;
		NOCLOSE ;
		SHADOW ;
		DOUBLE ;
		COLOR SCHEME 5



ACTIVATE WINDOW fakediag NOSHOW
@ 1,35 GET drive ;
	PICTURE "@^ C" ;
	SIZE 3,11 ;
	DEFAULT "C"	
@ 2,28 SAY "Unidad"
@ 6,24 SAY "Directorio"
@ 5,35 GET thedir ;
	PICTURE "@^ FOXPRO" ;
	SIZE 3,11 ;
	DEFAULT "FOXPRO"	
@ 9,36 GET y ;
	PICTURE "@*VN   \!Abrir ; Nuevo  ;Cancelar" ;
	SIZE 1,10,1 ;
	DEFAULT 0
@ 0,3 SAY "Abrir:"
@ 1,1 GET z ;
	PICTURE "@&N" ;
	FROM fakeit ;
	SIZE 10,18 ;
	DEFAULT 1 ;
	COLOR SCHEME 6
@ 11,3 GET w ;
	PICTURE "@*C Todos" ;
	SIZE 1,13 ;
	DEFAULT 0
@ 12,2 GET v ;
	PICTURE "@^ Pantalla" ;
	SIZE 3,16 ;
	DEFAULT "Pantalla"	
@ 13,19 SAY "Tipo"
@ 15,3 GET u ;
	PICTURE "@*C Restablecer entorno" ;
	SIZE 1,23 ;
	DEFAULT 1

define window menusys from 18,26 to 18,44 none noshadow COLOR SCHEME 12
activate window menusys
@ 0,0 say "cuadros de di logo"
move window menusys to 18,20
activate window welcome2
@ 1,20 say "cuadros de di logo" color w+/r
release window menusys
define window menusys from 15,26 to 17,39 none noshadow
activate window menusys
@ 0,0 say "    Cuadros   "  COLOR GR+/B   && Lexitrans
@ 1,0 say "      de      "  COLOR GR+/B               
@ 2,0 say "    di logo   "  COLOR GR+/B   && Lexitrans
for cnt = 15 to 8 step -1
	move window menusys to cnt,26
	do inpause with 30
endfor

for cnt = 26 to 1 step -1 
	move window menusys to 8,cnt
	do inpause with 30
endfor
@ 0,0 say "              "  COLOR GR+/B   && Lexitrans
@ 1,0 say "    Lista ÍÍ "  COLOR GR+/B               
@ 2,0 say "              "  COLOR GR+/B   && Lexitrans
do inpause with 30	
ACTIVATE WINDOW fakediag
hide window welcome2
do apause	
activate window menusys
@ 0,0 say "   Casilla   " color GR+/B
@ 1,0 say "   de     ÍÍ" color GR+/B
@ 2,0 say "verificaci¢n " color GR+/B
for cnt = 8 to 14
	move window menusys to cnt,1
	do inpause with 30
endfor
if speed = 4
	for cnt2 = 1 to 50
		nullst = "null"
	endfor
else
	do inpause with 30	
endif
	do inpause with 413     && Lexitrans
@ 0,0 say "Control      " color GR+/B
@ 1,0 say "emergente ÍÍ" color GR+/B
@ 2,0 say "             " color GR+/B
do inpause with 30	
for cnt = 14 to 16
	move window menusys to cnt,1
	do inpause with 30
endfor
if speed = 4
	for cnt2 = 1 to 50
		nullst = "null"
	endfor
else
	do inpause with 30	
endif

	do inpause with 413     && Lexitrans
@ 0,0 say "   Casilla   " color GR+/B
@ 1,0 say "   de     ÍÍ" color GR+/B
@ 2,0 say "verificaci¢n " color GR+/B
for cnt = 16 to 18
	move window menusys to cnt,1
	do inpause with 30
endfor
if speed = 4
	for cnt2 = 1 to 50
		nullst = "null"
	endfor
else
	do inpause with 30	
endif

	do inpause with 413     && Lexitrans
@ 0,0 SAY "    Bot¢n    " COLOR GR+/B
@ 1,0 say "    de       " color GR+/B
@ 2,0 SAY "ÍÍ comando  " COLOR GR+/B
for cnt = 18 to 12 step -1
	move window menusys to cnt,1
	do inpause with 30
endfor
do inpause with 30
activate window fakediag	
for cnt = 0 to 15
	move window menusys to 12,cnt
	do inpause with 30
endfor
move window menusys to 12,51
for cnt = 51 to 67
	move window menusys to 12,cnt
	do inpause with 30
endfor
if speed = 4
	for cnt2 = 1 to 50
		nullst = "null"
	endfor
else
	do inpause with 30	
endif
for cnt = 12 to 14
	move window menusys to cnt,67
	do inpause with 30
endfor
do inpause with 30
for cnt = 14 to 16
	move window menusys to cnt,67
	do inpause with 30
endfor
if speed = 4
	for cnt2 = 1 to 50
		nullst = "null"
	endfor
else
	do inpause with 30	
endif

hide WINDOW fakediag
activate window menusys
@ 0,0 say "    Cuadros   "  COLOR GR+/B   && Lexitrans
@ 1,0 say "      de      "  COLOR GR+/B               
@ 2,0 say "    di logo   "  COLOR GR+/B   && Lexitrans
move window menusys to 15,26
do inpause with 30
show window welcome2
for cnt = 26 to 22 step -1
	move window menusys to 15,cnt
	do inpause with 30
endfor
release window menusys
define window menusys from 17,20 to 17,37 none noshadow COLOR SCHEME 12
activate window menusys
@ 0,0 say "cuadros de di logo"
move window menusys to 18,20
do inpause with 300

activate window welcome2
release window menusys
clear
@ 0,1 say " Seguro que alguna vez ha tenido un problema y no hab¡a nadie para"
@ 1,1 say "  ayudarle. FoxPro le ofrece ayuda en todo momento con su sistema  "
@ 2,1 say "   interactivo que contiene cientos y cientos de temas de ayuda."
do apause
if NOT empty(alltrim(set("HELP",1)))
	if set('HELP') = "OFF"
		helpset = "OFF"
		set help on
	else
		helpset = "ON"
	endif
	clear typeahead
	set typeahead to 128
	for cnt = 1 to 126
		keyboard "{RIGHTARROW}"
	endfor
	keyboard "{CTRL+W}"
	HELP
	clear typeahead
	if helpset = "OFF"
		set help off
	endif
else
	wait window "No se encuentra el archivo de ayuda" timeout 3
endif

activate window welcome2
clear
@ 0,1 say "Si solicita ayuda cuando est  en un determinado cuadro de di logo, "
@ 1,1 say "FoxPro le informar  detalladamente sobre ese cuadro de di logo."
@ 2,1 say "Tambi‚n le ofrecer  una £til lista de temas relacionados con ello."
do apause
hide window welcome2
define window menusys from 18,50 to 19,62 none noshadow
activate window menusys
@ 0,0 say "ÍÍ Cuadro de"  COLOR GR+/B
@ 1,0 say "Abrir archivo"  COLOR GR+/B
move window fakediag to 3,14
activate WINDOW fakediag
for cnt = 50 to 66
	move window menusys to 18,cnt
	do inpause with 30
endfor

do inpause with 30

faketext =	"ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿                     "+;
 			"³          Abrir archivo          ³                     "+;
 			"ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ                     "+;
 			"Cuando en el men£ Archivo elige el comando Abrir...,    "+;
 			"aparece el cuadro de di logo Abrir que le permite abrir "+;
 			"archivos ya existentes. Este cuadro de di logo aparece  "+;
 			"otras veces en FoxPro, siempre que tenga que abrir un   "+;
 			"archivo. Por ejemplo, cuando tiene que abrir un informe "+;
 			"aparece un cuadro de di logo Abrir Informe, mostrando   "+;
 			"en una lista los archivos de ese tipo. Las categor¡as o "+;
 			"tipos de archivos se determinan por sus extensiones.    "+;
 			"                                                        "+;
 			"                                                        "

DEFINE WINDOW fakehelp ;
	FROM 2, 2 ;
	TO 15,75 ;
	TITLE "Ayuda" ;
	NOFLOAT ;
	NOCLOSE ;
	SHADOW ;
	NONE ;
	COLOR SCHEME 8

ACTIVATE WINDOW fakehelp NOSHOW
@ 1,15 TO 12,15 ;
	COLOR W/BG    
@ 2,1 GET helpbut ;
	PICTURE "@*VN    \!\<Temas   ; \<Siguiente ; \<Anterior  ;  \<Ver m s  " ;
	SIZE 1,11,1 ;
	DEFAULT 1
@ 10,2 GET helppop ;
	PICTURE "@^ Ver m s;temas" ;
	SIZE 3,12 ;
	DEFAULT "Ver m s"	 ;
	COLOR SCHEME 8, 8
@ 0,0 TO 13,73 PANEL ;
	COLOR W/BG    
@ 1,17 EDIT faketext ;
	SIZE 12,56,0 ;
	DEFAULT " " ;
	COLOR SCHEME 17
@ 0,35 SAY "Ayuda" ;
	COLOR GR+/W   
@ 0,0 SAY "þ" ;
	COLOR GR+/W   
@ 0,73 SAY "ð" ;
	COLOR GR+/W   
@ 13,73 SAY "" ;
	COLOR GR+/W   

ACTIVATE WINDOW fakehelp
release window menusys
do effect1 with 8,49,"ÚÄÄÄÄ Ayuda para ÄÄÄ¿","    Abrir archivo  "
do effect1 with 3,28,"    Temas de ayuda   ","ÄÄÄÄÄÄÄÄÄÙ          "
do effect1 with 5,28,"    Siguiente tema   ","ÄÄÄÄÄÄÄÄÄÙ          "
do effect1 with 7,28,"    Tema anterior    ","ÄÄÄÄÄÄÄÄÄÙ          "
do effect1 with 9,28,"    Lista 'Ver m s'  ","ÄÄÄÄÄÄÄtemas        "

@ 10,21 say "l" color w+/r
do inpause with 30
@ 10,22 say "i" color w+/r
do inpause with 30
@ 10,23 say "s" color w+/r
do inpause with 30
@ 10,24 say "t" color w+/r
do inpause with 30
@ 10,25 say "a" color w+/r
do inpause with 30
@ 8,1 say "<  Ver m s  >" color w+/r
do inpause with 45

faketext =	"ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿                     "+;
            "³             Lista               ³                     "+;
            "ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ                     "+;
            "Las listas se utilizan para seleccionar un valor entre  "+;
            "diversos elementos relacionados entre s¡. Una lista se  "+;
            "representa mediante un rect ngulo en el que se muestra  "+;
            "un valor. Cuando el usuario selecciona la lista en una  "+;
            "pantalla de entrada de datos, aparece la lista entera:  "+;
            "con todos sus elementos.                                "+;
            "                                                        "+;
            "Una lista puede contener valores enumerados o extra¡dos "+;
            "de una matriz. En el primer caso, para definir la lista "
ACTIVATE WINDOW fakehelp
@ 1,17 EDIT faketext ;
	SIZE 12,56,0 ;
	DEFAULT " " ;
	COLOR SCHEME 17
@ 8,1 say "<Vea tambi‚n>" color b/gb
do apause

DEFINE WINDOW freltop ;
	FROM 12,5;
	TO 20,31 ;
	NOFLOAT ;
	NOCLOSE ;
	SHADOW ;
	NONE ;
	COLOR SCHEME 8

ACTIVATE WINDOW freltop NOSHOW
@ 0,0 TO 8,26 COLOR B/BG    
@ 2,0 say "ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´" COLOR B/BG 
@ 1,2 SAY "Abrir archivo"
@ 3,2 SAY "Elegir campo/variable"
@ 4,2 SAY "Miniprogramas"
@ 5,2 SAY "Comentarios"
@ 6,2 SAY "Generador de expresiones"
@ 7,2 SAY "Generador de pantallas"

ACTIVATE WINDOW freltop
do effect1 with 13,42," Temas relacionados  ","ÄÄÄÄÄÄÄÄÙ         "

release window fakehelp
release window freltop
release window fakediag

activate window welcome2
clear
@ 0,1 say "   Casi todo el trabajo en FoxPro se hace en ventanas, que usted  "
@ 1,1 say "   puede manipular (abrir, cerrar, mover, minimizar, etc.)."
do apause
define window fakewin from 2,2 to 10,30 system shadow grow close zoom;
 minimize title "Una ventana..." color scheme 8
activate window fakewin
@ 0,1 say "...abierta" color gr+/bg
do inpause with 30
@ 0,1 say "Abierta"
@ 1,1 say "...movi‚ndose" color gr+/bg
for r = 2 to 15
	move window fakewin to r,2
	do inpause with 30
endfor
for c = 2 to 30
	move window fakewin to 15,c
	do inpause with 30
endfor
for r = 15 to 2 step -1
	move window fakewin to r,30
	do inpause with 30
endfor
for c = 30 to 2 step -1
	move window fakewin to 2,c
	do inpause with 30
endfor
@ 1,1 say "Movida a otra posici¢n."
@ 2,1 say "...para ajustar tama¤o"  color gr+/bg
do apause

for cnt = 31 to 71
	zoom window fakewin norm from 2,2 to 10,cnt
endfor

@ 2,1 say "Con su tama¤o ajustado.   "
@ 3,1 say "...para minimizarla         " color gr+/bg
do apause

zoom window fakewin min
do apause
zoom window fakewin norm
@ 3,1 say "Que ya no est  minimizada.        "
@ 4,1 say "...para ampliarla como la pantalla" color gr+/bg
do apause

zoom window fakewin max
@ 4,1 say "Ampliada con Zoom como la pantalla." color gr+/bg
do apause
zoom window fakewin norm
@ 4,1 say "Sin aplicar el Zoom.               "
do apause
release window fakewin

*******************************
* desk accessory section

activate window welcome2
clear
@ 0,1 say "  FoxPro le ofrece diversos accesorios de escritorio que le pueden"
@ 1,1 say "  resultar muy £tiles: archivador, calendario, tabla de caracteres"
@ 2,1 say "  especiales, tabla ASCII e incluso un peque¤o puzzle."
do apause


********************************
* define fake filer window

DEFINE WINDOW filerwin ;
	FROM 2, 2 ;
	TO 21,76 ;
	NOFLOAT ;
	CLOSE ;
	SHADOW ;
	NONE ;
	COLOR SCHEME 8

ACTIVATE WINDOW filerwin NOSHOW
@ 0,0 TO 19,74 PANEL ;
	COLOR W/BG    
@ 0,0 SAY "þ" ;
	COLOR GR+/W   
@ 17,3 GET fx ;
	PICTURE "@*VN Buscar;Editar" ;
	SIZE 1,8,0 ;
	DEFAULT 1
@ 17,13 GET fx ;
	PICTURE "@*VN   Copiar  ;Atributos" ;
	SIZE 1,10,0 ;
	DEFAULT 1
@ 17,25 GET fx ;
	PICTURE "@*VN       Mover   ;Cambiar nombre" ;
	SIZE 1,16,0 ;
	DEFAULT 1
@ 17,43 GET fx ;
	PICTURE "@*VN Eliminar; Tama¤o " ;
	SIZE 1,10,0 ;
	DEFAULT 1
@ 17,55 GET fx ;
	PICTURE "@*VN Ordenar; Arbol " ;
	SIZE 1,9,0 ;
	DEFAULT 1
@ 16,53 TO 16,72
@ 13,56 GET fx ;
	PICTURE "@*VN Marcar todo; Desmarcar ; Invertir" ;
	SIZE 1,13,0 ;
	DEFAULT 1
@ 9,53 TO 9,72
@ 10,55 SAY "Filtro"
@ 11,57 SAY "*.*         " ;
	COLOR W+/W    
@ 7,54 SAY "Dir."
@ 4,54 SAY "Unidad"
@ 3,61 GET fx ;
	PICTURE "@^ C;D" ;
	SIZE 3,10 ;
	DEFAULT "C"	 ;
	COLOR SCHEME 8, 8
@ 6,61 GET fx ;
	PICTURE "@^ DEMO; DEMO" ;
	SIZE 3,10 ;
	DEFAULT "DEMO"	 ;
	COLOR SCHEME 8, 8
@ 3,3 TO 16,52 ;
	COLOR B/BG    
@ 2,5 SAY "Nombre"
@ 2,16 SAY "Ext"
@ 2,21 SAY "Tama¤o"
@ 2,28 SAY "Ult¦ modificaci¢n"
@ 2,47 SAY "Atrib"
@ 3,52 SAY "Ü" ;
	COLOR B/BG    
@ 14,52 SAY "Û" ;
	COLOR B/BG    
@ 5,52 SAY "" ;
	COLOR BG/B    
@ 4,52 SAY "" ;
	COLOR BG/B    
@ 15,52 SAY "" ;
	COLOR BG/B    
@ 16,52 SAY "ß" ;
	COLOR B/BG    
@ 13,52 SAY "Û" ;
	COLOR B/BG    
@ 12,52 SAY "Û" ;
	COLOR B/BG    
@ 11,52 SAY "Û" ;
	COLOR B/BG    
@ 8,52 SAY "Û" ;
	COLOR B/BG    
@ 10,52 SAY "Û" ;
	COLOR B/BG    
@ 9,52 SAY "Û" ;
	COLOR B/BG    
@ 7,52 SAY "Û" ;
	COLOR B/BG    
@ 6,52 SAY "Û" ;
	COLOR B/BG    
@ 4,5 SAY "[..]                    08-May-93  2:16p  ...."
@ 5,5 SAY "DEMO      .APP  356178  23-May-93  4:23p  .a.."
@ 6,5 SAY "EJEMPLO   .DBF    4248  23-May-93  7:17a  .a.."
@ 7,5 SAY "EJEMPLO   .FRX    4696  23-May-93 12:55p  .a.."
@ 8,5 SAY "EJEMPLO   .PJX    7835  23-May-93  4:39a  .a.."
@ 9,5 SAY "EJEMPLO   .QPR     331  23-May-93  8:45a  .a.."
@ 0,35 SAY "Archivador" ;
	COLOR GR+/W   

ACTIVATE WINDOW filerwin
activate window welcome2
clear
@ 0,1 say " El Archivador de FoxPro le permite manipular archivos: copiarlos,"
@ 1,1 say "   borrarlos, cambiar sus atributos, encontrarlos, etc. Tambi‚n"
@ 2,1 say "       puede copiar, mover y eliminar directorios completos."
do apause
********************************
hide window welcome2
activate window calendar
define window menusys from 2,22 to 10,45 none color scheme 8
activate window menusys
@ 1,0 say "  La demo de FoxPro 2.5"
@ 2,0 say "  ha sido magn¡fica."
@ 3,0 say "  hay que comprarlo"
@ 4,0 say "  inmediatamente."
do apause
activate window special
do apause
activate window ascii
do apause
activate window puzzle
do apause
activate window calculator
do apause
release window calculator
do inpause with 300
release window puzzle
do inpause with 300
release window ascii
do inpause with 300
release window special
do inpause with 300
release window menusys
release window calendar
do inpause with 300
release window filerwin

release window welcome2
do overnout

procedure overnout
set escape off
on escape *
on key label escape *
if wexist("welcome1")
	release window welcome1
endif
if wexist("welcome2")
	release window welcome2
endif
if wexist("syspop")
	release window syspop
endif
if wexist("filepop")
	release window filepop
endif
if wexist("littlewin")
	release window littlewin
endif
if wexist("menusys")
	release window menusys
endif
if wexist("editpop")
	release window editpop
endif
if wexist("datapop")
	release window datapop
endif
if wexist("recopop")
	release window recopop
endif
if wexist("progpop")
	release window progpop
endif
if wexist("windpop")
	release window windpop
endif
if wexist("fakediag")
	release window fakediag
endif
if wexist("fakehelp")
	release window fakehelp
endif
if wexist("freltop")
	release window freltop
endif
if wexist("enlarge")
	release window enlarge
endif
if wexist("fakewin")
	release window fakewin
endif
if wexist("help")
	release window help
endif
if wexist("calendar")
	release window calendar
endif
if wexist("calculator")
	release window calculator
endif
if wexist("special")
	release window special
endif
if wexist("ascii")
	release window ascii
endif
if wexist("puzzle")
	release window puzzle
endif
if wexist("filerwin")
	release window filerwin
endif
for cnt = 1 to 28
	if wexist("letter"+alltrim(str(cnt)))
		release window ("letter"+alltrim(str(cnt)))
	endif
endfor
set sysmenu to default
set sysmenu off
activate screen
clear
clear typeahead
return to rundemo

procedure escout
escpress = .t.
do overnout
return
	
procedure effect1
parameters xfrom, yfrom, textstr1, textstr2
yto = yfrom
define window enlarge from xfrom,yfrom to xfrom+1,yto none color scheme 7
activate window enlarge
for z = 1 to 10
	do inpause with 30
	zoom window enlarge norm from xfrom, yfrom-1 to xfrom+1, yto+1
	yfrom = yfrom - 1
	yto = yto + 1
endfor
@ 0,0 say textstr1
@ 1,0 say textstr2
do apause
for z = 1 to 10
	do inpause with 30
	zoom window enlarge norm from xfrom, yfrom+1 to xfrom+1, yto-1
	yfrom = yfrom + 1
	yto = yto - 1
endfor
release window enlarge
return
