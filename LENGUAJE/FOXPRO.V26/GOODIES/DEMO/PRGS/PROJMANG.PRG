on key label escape do escout
on escape do escout
set escape on
clear typeahead
set blink off
* do bigchars with 6,2,"  Project|Management"
do bigchars with 6,2,  "Administr.|de proyectos"
do apause
for cnt = 1 to 23
	release window ("letter"+alltrim(str(cnt)))
endfor
set blink on
set sysmenu to default
set sysmenu automatic

DEFINE WINDOW marque1 from 18,5 to 22,74 DOUBLE COLOR SCHEME 12;
	TITLE " FoxPro 2.5 - Administrador de proyectos" SHADOW
ACTIVATE WINDOW marque1
@ 0,1 say " El Administrador de proyectos de FoxPro unifica y coordina todos "
@ 1,1 say " los elementos que constituyen una aplicaci¢n.  Basta especificar "
@ 2,1 say " los archivos, programas, informes, etc. que FoxPro debe incluir."
do apause

*
* Move Project Manager text from marque to center of the screen.
*

define window menusys from 19,16 to 19,30 none noshadow COLOR SCHEME 12
@ 0,5 say "Administrador de proyectos" color w+/r
activate window menusys
@ 0,0 say "Administrador de proyectos"
move window menusys to 18,16
do inpause with 4
release window menusys
define window menusys from 17,16 to 17,30 none noshadow
activate window menusys
@ 0,0 say "Administrador de proyectos"  COLOR GR+/B
for cnt = 17 to 8 step -1
	move window menusys to cnt,16
	do inpause with 4
endfor
for cnt = 16 to 35
	move window menusys to 8,cnt
	do inpause with 4
endfor

DEFINE WINDOW project ;
	FROM 3, 16 ;
	TO 16,62 ;
	FLOAT ;
	CLOSE ;
	SHADOW ;
	NONE ;
	COLOR SCHEME 8

ACTIVATE WINDOW project NOSHOW
@ 3,34 GET df ;
	PICTURE "@*VN Editar;  Info ; A¤adir; Quitar;Generar" ;
	SIZE 1,10,1 ;
	DEFAULT 1
@ 1,4 SAY "Nombre"
@ 1,20 SAY "Tipo"
@ 2,2 TO 12,31 ;
	COLOR B/BG    
@ 3,4 SAY "IR_A"
@ 4,4 SAY "LASER"
@ 5,4 SAY "LASER"
@ 6,4 SAY "LASER"
@ 7,4 SAY "LASERM"
@ 8,4 SAY "INFORME"
@ 3,19 SAY "Pantallas"
@ 4,19 SAY "Tabla"
@ 5,19 SAY "Informe"
@ 6,19 SAY "Pantallas"
@ 7,19 SAY "Men£"
@ 8,19 SAY "Pantallas"
@ 4,17 SAY "þ"
@ 6,17 SAY ""
@ 0,0 TO 13,46 PANEL ;
	COLOR W/BG    
@ 0,19 SAY "APP1.PJX" ;
	COLOR GR+/W   
@ 0,46 SAY "ð" ;
	COLOR GR+/W   
@ 0,0 SAY "þ" ;
	COLOR GR+/W   
@ 13,46 SAY "ù" ;
	COLOR GR+/W   

ACTIVATE WINDOW project
release window menusys
do apause
release window project

ACTIVATE WINDOW marque1
clear
@ 0,1 say "FoxPro coordinar  todos los elementos de su aplicaci¢n; por lo que"
@ 1,1 say "usted se podr  dedicar a aspectos m s creativos del desarrollo de"
@ 2,1 say "aplicaciones."
do apause

define window appwin1 from 1,1 to 1,27 none color scheme 7
activate window appwin1 noshow
@ 0,0 say "ÉÍÍÍÍÍÍ "
@ 0,8 say "Aplicaci¢n" color w+/r
@ 0,19 say " ÍÍÍÍÍÍ»"	

define window appwin2 from 1,1 to 1,27 none color scheme 7
activate window appwin2 noshow
@ 0,0 say "º        Programas        º"

define window appwin3 from 1,1 to 1,27 none color scheme 7
activate window appwin3 noshow
@ 0,0 say "º        Pantallas        º"

define window appwin4 from 1,1 to 1,27 none color scheme 7
activate window appwin4 noshow
@ 0,0 say "º          Men£s          º"

define window appwin5 from 1,1 to 1,27 none color scheme 7
activate window appwin5 noshow
@ 0,0 say "º        Consultas        º"

define window appwin6 from 1,1 to 1,27 none color scheme 7
activate window appwin6 noshow
@ 0,0 say "º        Informes         º"

define window appwin7 from 1,1 to 1,27 none color scheme 7
activate window appwin7 noshow
@ 0,0 say "º        Etiquetas        º"

define window appwin8 from 1,1 to 1,27 none color scheme 7
activate window appwin8 noshow
@ 0,0 say "º Bibliotecas API externasº"

define window appwin9 from 1,1 to 1,27 none color scheme 7
activate window appwin9 noshow
@ 0,0 say "º   Archivos de formato   º"

define window appwin10 from 1,1 to 1,27 none color scheme 7
activate window appwin10 noshow
@ 0,0 say "º   Variables de memoria  º"

define window appwin11 from 1,1 to 1,27 none color scheme 7
activate window appwin11 noshow
@ 0,0 say "º    Macros de teclado    º"

define window appwin12 from 1,1 to 1,27 none color scheme 7
activate window appwin12 noshow
@ 0,0 say "º      Tablas/¡ndices     º"

define window appwin13 from 1,1 to 1,27 none color scheme 7
activate window appwin13 noshow
@ 0,0 say "º    Archivos de texto    º"

define window appwin14 from 1,1 to 1,27 none color scheme 7
activate window appwin14 noshow
@ 0,0 say "ÈÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼"

move window appwin1 to 1,27
move window appwin2 to 1,0
move window appwin3 to 1,0
move window appwin4 to 1,0
move window appwin5 to 1,54
move window appwin6 to 1,54
move window appwin7 to 1,54
move window appwin8 to 24,54
move window appwin9 to 24,54
move window appwin10 to 24,54
move window appwin11 to 24,0
move window appwin12 to 24,0
move window appwin13 to 24,0
move window appwin14 to 24,27

for cnt = 1 to 14
	show window ("appwin"+alltrim(str(cnt)))
endfor

hide window marque1

x = 1
for cnt = 0 to 27
	if x < 5
		move window appwin2 to x,cnt
	else
		move window appwin2 to 4,cnt
	endif
	if x < 8
		move window appwin5 to x,54-cnt
	else
		move window appwin5 to 7,54-cnt
	endif
	if 24-x > 9
		move window appwin8 to 25-x,54-cnt
	else
		move window appwin8 to 10,54-cnt
	endif
	if 24-x > 12
		move window appwin11 to 25-x,cnt
	else
		move window appwin11 to 13,cnt
	endif
	do inpause with 4
	x = x + 1
endfor	 
x = 1
for cnt = 0 to 27
	if x < 6
		move window appwin3 to x,cnt
	else
		move window appwin3 to 5,cnt
	endif
	if x < 9
		move window appwin6 to x,54-cnt
	else
		move window appwin6 to 8,54-cnt
	endif
	if 24-x > 10
		move window appwin9 to 25-x,54-cnt
	else
		move window appwin9 to 11,54-cnt
	endif
	if 24-x > 13
		move window appwin12 to 25-x,cnt
	else
		move window appwin12 to 14,cnt
	endif
	do inpause with 4
	x = x + 1
endfor	 
x = 1
for cnt = 0 to 27
	if x < 7
		move window appwin4 to x,cnt
	else
		move window appwin4 to 6,cnt
	endif
	if x < 10
		move window appwin7 to x,54-cnt
	else
		move window appwin7 to 9,54-cnt
	endif
	if 24-x > 11
		move window appwin10 to 25-x,54-cnt
	else
		move window appwin10 to 12,54-cnt
	endif
	if 24-x > 14
		move window appwin13 to 25-x,cnt
	else
		move window appwin13 to 15,cnt
	endif
	do inpause with 4
	x = x + 1
endfor	 
move window appwin1 to 2,27
do inpause with 4
move window appwin1 to 3,27
do inpause with 4
for cnt = 24 to 16 step -1
	move window appwin14 to cnt,27
	do inpause with 4
endfor
show window marque1
do apause

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
if wexist("sample")
	release window sample
endif
if wexist("project")
	release window project
endif
for cnt = 1 to 23
	if wexist("letter"+alltrim(str(cnt)))
		release window ("letter"+alltrim(str(cnt)))
	endif
endfor
for cnt = 1 to 14
	if wexist("appwin"+alltrim(str(cnt)))
		release window ("appwin"+alltrim(str(cnt)))
	endif
endfor
set sysmenu off
set sysmenu to default
activate screen
clear
return to rundemo

procedure escout
escpress = .t.
do overnout
return

