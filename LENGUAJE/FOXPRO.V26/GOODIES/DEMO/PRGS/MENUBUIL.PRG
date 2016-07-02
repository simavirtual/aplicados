on key label escape do escout
on escape do escout
set escape on
clear typeahead
set blink off
*o bigchars with 6,18," Menu|Builder"
do bigchars with 6,8,"Generador|de men£s"
do apause
for cnt = 1 to 18
	release window ("letter"+alltrim(str(cnt)))
endfor
set blink on
set sysmenu automatic

DEFINE WINDOW marque1 from 18,5 to 21,75 DOUBLE COLOR SCHEME 12;
	TITLE " FoxPro 2.5 - Generador de men£s " SHADOW
ACTIVATE WINDOW marque1
@ 0,1 say "       Con el Generador de men£s de FoxPro le resultar  muy "          
@ 1,1 say "           f cil dise¤ar sus propios sistemas de men£s."
do apause

*
* Move Menu Builder text from marque to center of the screen.
*

define window menusys from 20,37 to 20,48 none noshadow COLOR SCHEME 12
@ 1,31 say "Generador de men£s" color w+/r
activate window menusys
@ 0,0 say "Generador de men£s"
move window menusys to 19,37
do inpause with 4
move window menusys to 18,37
do inpause with 4
release window menusys
define window menusys from 17,37 to 17,48 none noshadow
activate window menusys
@ 0,0 say "Generador de men£s"  COLOR GR+/B
for cnt = 17 to 8 step -1
	move window menusys to cnt,37
	do inpause with 4
endfor
for cnt = 37 to 30 step -1
	move window menusys to 8,cnt
	do inpause with 4
endfor

DEFINE WINDOW laserm ;
	FROM 2, 3 ;
	TO 18,74 ;
	NOFLOAT ;
	NOCLOSE ;
	SHADOW ;
	NONE ;
	COLOR SCHEME 8

*       ÖÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ·
*       º                                                         º
*       º                  LASERM Screen Layout                   º
*       º                                                         º 
*       ÓÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ½
*    

ACTIVATE WINDOW laserm NOSHOW
@ 0,0 TO 16,71 PANEL ;
	COLOR W/W     
@ 3,2 TO 14,54 ;
	COLOR B/BG    
@ 2,6 SAY "Instrucci¢n"
@ 2,48 SAY "Opci¢n"
@ 2,30 SAY "Resultado"
@ 4,56 SAY  "Barra de men£s" ;
	COLOR B/BG    
@ 3,55 SAY "ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿" ;
	COLOR B/BG    
@ 4,55 SAY "³" ;
	COLOR B/BG    
@ 4,70 SAY "³" ;
	COLOR B/BG    
@ 5,55 SAY "ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ" ;
	COLOR B/BG    
@ 7,57 SAY "<  Probar  > " ;
	COLOR B/BG    
@ 10,56 TO 14,69
@ 10,58 SAY " Elemento "
@ 11,58 SAY "<Insertar>" ;
	COLOR W/BG    
@ 13,58 SAY "< Quitar >" ;
	COLOR W/BG    
@ 4,50 SAY "[X]" ;
	COLOR B/BG    
@ 5,50 SAY "[X]" ;
	COLOR B/BG    
@ 6,50 SAY "[X]" ;
	COLOR B/BG    
@ 7,50 SAY "[X]" ;
	COLOR B/BG    
@ 4,4 SAY "" ;
	COLOR B/BG    
@ 5,4 SAY "" ;
	COLOR B/BG    
@ 6,4 SAY "" ;
	COLOR B/BG    
@ 7,4 SAY "" ;
	COLOR B/BG    
@ 7,6 SAY "E\<ntorno  " ;
	COLOR W+/W    
@ 7,23 SAY "Comando " ;
	COLOR W+/W    
@ 7,33 SAY "*              " ;
	COLOR W+/W    
@ 6,33 SAY "*              " ;
	COLOR W+/W    
@ 5,33 SAY "*              " ;
	COLOR W+/W    
@ 4,33 SAY "*              " ;
	COLOR W+/W    
@ 6,23 SAY "Comando " ;
	COLOR W+/W    
@ 5,23 SAY "Comando " ;
	COLOR W+/W    
@ 4,23 SAY "Comando " ;
	COLOR W+/W    
@ 6,6 SAY "Ta\<bla        " ;
	COLOR W+/W    
@ 5,6 SAY "\<Edici¢n      " ;
	COLOR W+/W    
@ 4,6 SAY "\<Sistema      " ;
	COLOR W+/W    
@ 0,31 SAY "LASERM.MNX" ;
	COLOR GR+/W   
@ 0,0 SAY "ş" ;
	COLOR GR+/W   

ACTIVATE WINDOW laserm

release window menusys

move window marque1 to 20,7
ACTIVATE WINDOW marque1
clear
@ 0,1 say "   Para crear un men£ basta con escribir las instrucciones y los"          
@ 1,1 say "              comandos que se ejecutar n en cada caso."
do apause

ACTIVATE WINDOW marque1
clear
@ 0,1 say "   Es muy f cil crear men£s emergentes y jerarqu¡as de submen£s."          
@ 1,1 say "         Tambi‚n puede crear m‚todos abreviados de teclado."
do apause
release window laserm
ACTIVATE WINDOW marque1
clear
@ 0,1 say "    Una vez definidos los men£s y los comandos, FoxPro genera"          
@ 1,1 say "    el programa necesario para utilizar ese sistema de men£s."
do apause
activate screen
hide window botmess
type laserm.mpr
do apause
clear
show window botmess
ACTIVATE WINDOW marque1
clear
@ 0,1 say "   Una vez generado el programa, podr  ejecutarlo directamente o"          
@ 1,1 say "        insertarlo en cualquiera de sus aplicaciones FoxPro."
do apause
SET SYSMENU TO 

SET SYSMENU AUTOMATIC

DEFINE PAD _pwg0fuz8n OF _MSYSMENU PROMPT "\<Sistema" COLOR SCHEME 3 ;
	KEY ALT+S, "ALT+S" 
DEFINE PAD _pwg0fuz96 OF _MSYSMENU PROMPT "\<Edici¢n" COLOR SCHEME 3 ;
	KEY ALT+E, ""
DEFINE PAD _pwg0fuz9k OF _MSYSMENU PROMPT "Ta\<bla" COLOR SCHEME 3 ;
	KEY ALT+B, ""
DEFINE PAD _pwg0fuz9y OF _MSYSMENU PROMPT "E\<ntorno" COLOR SCHEME 3 ;
	KEY ALT+N, "ALT+N"

DEFINE WINDOW datapop ;
	FROM 1, 0 ;
	TO 11,21 ;
	NOFLOAT ;
	NOCLOSE ;
	SHADOW ;
	NONE ;
	COLOR SCHEME 4

ACTIVATE WINDOW datapop NOSHOW
@ 3,0 TO 3,21 ;
	COLOR N/W     
@ 0,0 TO 10,21 ;
	COLOR N/W     
@ 8,0 TO 8,21 ;
	COLOR N/W     
@ 8,0 SAY "Ã" ;
	COLOR N/W     
@ 8,21 SAY "´" ;
	COLOR N/W     
@ 3,0 SAY "Ã" ;
	COLOR N/W     
@ 3,21 SAY "´" ;
	COLOR N/W     

@ 1,2 SAY "A" ;
	COLOR N/W     
@ 1,3 SAY "y" ;
	COLOR W+/W    
@ 1,4 SAY "uda..." ;
	COLOR N/W     
@ 1,18 SAY "F1" ;
	COLOR W+/W    

@ 2,2 SAY "Arc" ;
	COLOR N/W     
@ 2,5 SAY "h" ;
	COLOR W+/W    
@ 2,6 SAY "ivador" ;
	COLOR N/W     

@ 4,2 SAY "C" ;
	COLOR W+/W    
@ 4,3 SAY "alculadora" ;
	COLOR N/W     

@ 5,4 SAY "l" ;
	COLOR W+/W    
@ 5,2 SAY "Ca" ;
	COLOR N/W     
@ 5,5 SAY "endario/Agenda" ;
	COLOR N/W    
	 
@ 6,2 SAY "T" ;
	COLOR W+/W    
@ 6,3 SAY "abla ASCII" ;
	COLOR N/W     

@ 7,2 SAY "Pu" ;
	COLOR N/W     
@ 7,4 SAY "z" ;
	COLOR W+/W    
@ 7,5 SAY "zle" ;
	COLOR N/W     

@ 9,2 SAY "S" ;
	COLOR W+/W    
@ 9,3 SAY "alir" ;
	COLOR N/W     

ACTIVATE WINDOW datapop
do apause
release window datapop

DEFINE WINDOW datapop ;
	FROM 1, 8 ;
	TO 10,23 ;
	NOFLOAT ;
	NOCLOSE ;
	SHADOW ;
	NONE ;
	COLOR SCHEME 4

ACTIVATE WINDOW datapop NOSHOW
@ 0,0 TO 9,15 ;
	COLOR N/W     
@ 3,0 TO 3,15 ;
	COLOR N/W     
@ 7,0 TO 7,15 ;
	COLOR N/W     
@ 7,0 SAY "Ã" ;
	COLOR N/W     
@ 7,15 SAY "´" ;
	COLOR N/W     
@ 3,0 SAY "Ã" ;
	COLOR N/W     
@ 3,15 SAY "´" ;
	COLOR N/W     

@ 1,2 SAY "D" ;
	COLOR W+/W    
@ 1,3 SAY "eshacer" ;
	COLOR N/W     

@ 2,2 SAY "R" ;
	COLOR W+/W    
@ 2,3 SAY "ehacer" ;
	COLOR N/W     

@ 4,2 SAY "Cor" ;
	COLOR N/W     
@ 4,5 SAY "t" ;
	COLOR W+/W    
@ 4,6 SAY "ar" ;
	COLOR N/W     

@ 5,2 SAY "C" ;
	COLOR W+/W    
@ 5,3 SAY "opiar" ;
	COLOR N/W     

@ 6,2 SAY "P" ;
	COLOR W+/W    
@ 6,3 SAY "egar" ;
	COLOR N/W     

@ 8,2 SAY "S" ;
	COLOR W+/W    
@ 8,3 SAY "elecci¢n" ;
	COLOR N/W     

@ 1,13 SAY "^Z" ;
	COLOR W+/W    
@ 2,13 SAY "^R" ;
	COLOR W+/W    
@ 4,13 SAY "^X" ;
	COLOR W+/W    
@ 5,13 SAY "^C" ;
	COLOR W+/W    
@ 6,13 SAY "^V" ;
	COLOR W+/W    
@ 8,13 SAY "^S" ;
	COLOR W+/W    

ACTIVATE WINDOW datapop
do apause
release window datapop

DEFINE WINDOW datapop ;
	FROM 1, 14 ;
	TO 9,33 ;
	NOFLOAT ;
	NOCLOSE ;
	SHADOW ;
	NONE ;
	COLOR SCHEME 4

ACTIVATE WINDOW datapop NOSHOW
@ 0,0 TO 8,19 ;
	COLOR N/W     
@ 5,0 TO 5,19 ;
	COLOR N/W     
@ 5,0 SAY "Ã" ;
	COLOR N/W     
@ 5,19 SAY "´" ;
	COLOR N/W     

@ 1,2 SAY "E" ;
	COLOR N/W     
@ 1,3 SAY "x" ;
	COLOR W+/W    
@ 1,4 SAY "aminar" ;
	COLOR N/W     

@ 2,2 SAY "A" ;
	COLOR W+/W    
@ 2,3 SAY "¤adir" ;
	COLOR N/W     

@ 4,2 SAY "R" ;
	COLOR W+/W    
@ 4,3 SAY "informe..." ;
	COLOR N/W     

@ 7,2 SAY "E" ;
	COLOR W+/W    
@ 7,3 SAY "mpaquetar" ;
	COLOR N/W     

@ 3,2 SAY "I" ;
	COLOR W+/W    
@ 3,3 SAY "r a..." ;
	COLOR N/W     

@ 6,2 SAY "B" ;
	COLOR W+/W    
@ 6,3 SAY "orrar" ;
	COLOR N/W     

@ 6,16 SAY "^B" ;
	COLOR W+/W    
* @ 1,16 SAY "^B" ;
*	COLOR W+/W    

ACTIVATE WINDOW datapop
do apause
release window datapop

DEFINE WINDOW datapop ;
	FROM 1, 24 ;
	TO 6,42 ;
	NOFLOAT ;
	NOCLOSE ;
	SHADOW ;
	NONE ;
	COLOR SCHEME 4

ACTIVATE WINDOW datapop NOSHOW
@ 0,0 TO 5,17 ;
	COLOR N/W     
@ 1,2 SAY "B" ;
	COLOR W+/W    
@ 1,3 SAY "arra de estado" ;
	COLOR N/W     
@ 2,2 SAY "R" ;
	COLOR W+/W    
@ 3,2 SAY "V" ;
	COLOR W+/W    
@ 4,2 SAY "M" ;
	COLOR W+/W    
@ 2,3 SAY "eloj" ;
	COLOR N/W     
@ 3,3 SAY "ideo extendido" ;
	COLOR N/W     
@ 4,3 SAY "e" ;
	COLOR N/W     
@ 4,4 SAY "n£s estables" ;
	COLOR N/W     

ACTIVATE WINDOW datapop
do apause
release window datapop

*********************
do overnout
*********************
procedure overnout
set escape off
on escape *
on key label escape *
if wexist("marque1")
	release window marque1
endif
if wexist("menusys")
	release window menusys
endif
if wexist("laserm")
	release window laserm
endif
if wexist("datapop")
	release window datapop
endif
for cnt = 1 to 18
	if wexist("letter"+alltrim(str(cnt)))
		release window ("letter"+alltrim(str(cnt)))
	endif
endfor
set sysmenu to default
activate screen
clear
close databases
return to rundemo

procedure escout
escpress = .t.
do overnout
return

procedure effect2
parameters startx,starty,instr1,instr2,instr3
nlines = 3
if empty(instr3)
	nlines = nlines - 1
endif
if empty(instr2)
	nlines = nlines - 1
endif
size = max(len(instr1),len(instr2),len(instr3))
wincnt = 0
xcnt = 0
for cnt = 1 to nlines
	wincnt = wincnt + 1
	define window ("ef2win"+alltrim(str(wincnt))) from startx+xcnt,starty to;
		startx+xcnt,starty+len(eval("instr"+alltrim(str(cnt))))-1 none color scheme 7
	activate window ("ef2win"+alltrim(str(wincnt))) noshow
	for cnt2 = 1 to len(eval("instr"+alltrim(str(cnt)))) step 2
		@ 0,cnt2-1 say substr(eval("instr"+alltrim(str(cnt))),cnt2,1)
	endfor
	move window ("ef2win"+alltrim(str(wincnt))) to 0,starty
	show window ("ef2win"+alltrim(str(wincnt)))
	for cnt3 = 0 to startx+xcnt
		move window ("ef2win"+alltrim(str(wincnt))) to cnt3,starty
		do inpause with 4
	endfor

	define window ("ef2win"+alltrim(str(wincnt+1))) from startx+xcnt,starty to;
		startx+xcnt,starty+len(eval("instr"+alltrim(str(cnt))))-1 none color scheme 7
	activate window ("ef2win"+alltrim(str(wincnt+1))) noshow
	for cnt2 = 2 to len(eval("instr"+alltrim(str(cnt)))) step 2
		@ 0,cnt2-1 say substr(eval("instr"+alltrim(str(cnt))),cnt2,1)
	endfor
	move window ("ef2win"+alltrim(str(wincnt+1))) to 24,starty
	show window ("ef2win"+alltrim(str(wincnt+1)))
	for cnt3 = 24 to startx+xcnt+1 step -1
		move window ("ef2win"+alltrim(str(wincnt+1))) to cnt3,starty
		do inpause with 4
	endfor
	release window ("ef2win"+alltrim(str(wincnt+1)))
	activate window ("ef2win"+alltrim(str(wincnt)))
	for cnt2 = 2 to len(eval("instr"+alltrim(str(cnt)))) step 2
		@ 0,cnt2-1 say substr(eval("instr"+alltrim(str(cnt))),cnt2,1)
	endfor
	
	xcnt = xcnt+1
endfor

do apause

for cnt = 1 to wincnt
	release window ("ef2win"+alltrim(str(cnt)))
endfor
return
