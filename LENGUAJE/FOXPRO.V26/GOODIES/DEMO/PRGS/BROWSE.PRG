clear typeahead
on escape do escout
on key label escape do escout
set escape on
activate screen
clear

set blink off
do bigchars with 8,13,"Examinar"
do apause
for cnt = 1 to 8
	release window ("letter"+alltrim(str(cnt)))
endfor
set blink on
set sysmenu to default
set sysmenu automatic

DEFINE WINDOW browse1 from 18,5 to 21,75 DOUBLE COLOR SCHEME 12 TITLE " FoxPro 2.5 - EXAMINAR " SHADOW
ACTIVATE WINDOW browse1
@ 0,1 say "   FoxPro le ofrece una eficaz herramienta para ver y editar sus" 
@ 1,1 say "   datos: la ventana Examinar." 
do apause
define window menusys from 20,19 to 20,34 none noshadow COLOR SCHEME 12
activate window menusys
@ 0,0 say "ventana Examinar"
move window menusys to 19,19
activate window browse1
@ 1,14 say "ventana Examinar" color w+/r
move window menusys to 18,19
do inpause with 4
release window menusys
define window menusys from 17,19 to 17,34 none noshadow
activate window menusys
@ 0,0 say "ventana Examinar"  COLOR GR+/B
for cnt = 17 to 9 step -1
	move window menusys to cnt,19
	do inpause with 4
endfor
for cnt = 19 to 32 
	move window menusys to 9,cnt
	do inpause with 4
endfor

select 1
use customer
go record 10

release window menusys

clear typeahead
play macro browse1
browse preference browsem normal
do inpause with 200

ACTIVATE WINDOW browse1
clear
@ 0,1 say "         Puede adaptar la ventana Examinar a sus necesidades.   "
do apause
set escape off
play macro browse2
browse preference browse2 normal
set escape on

ACTIVATE WINDOW browse1
clear
@ 0,1 say "     La ventana Examinar ofrece una alternativa a ver sus datos"
@ 1,1 say "     en filas y columnas: el modo Cambiar. "
do apause
set escape off
play macro dochange
change preference changem normal
set escape on

ACTIVATE WINDOW browse1
clear
@ 0,1 say " Puede dividir la ventana Examinar en dos particiones; cada una de"
@ 1,1 say " ellas puede estar en un modo. "
do apause
set escape off
play macro dopart
brows pref custpart normal
set escape on
use

ACTIVATE WINDOW browse1
clear
@ 0,1 say " Es posible almacenar cualquier tipo de informaci¢n en una base de"
@ 1,1 say " datos o 'tabla' de FoxPro. Por ejemplo, podr  almacenar:"
do apause


***************
* Memo example 1 - descriptive text

define window memowin from 6,15 to 16,65 system color scheme 8

use demomemo
browse preference memo1 normal nowait noclear
do inpause with 40
define window mmw from 5,25 to 5,29 none
activate window mmw noshow
@ 0,0 say "Memo " color W+/B
show window mmw
do inpause with 40

modify memo notes window memowin nowait

define window recs from 12,30 to 16,50 double color scheme 7
activate window recs
do colorsay with 0,0," Texto descriptivo "
do colorsay with 1,0,"    de cualquier   "
do colorsay with 2,0,"      longitud     "
do apause
set escape off
play macro memoscrol
modify memo notes window memowin
set escape on
do colorsay with 2,0,"      longitud     "
do colorsay with 1,0,"    de cualquier   "
do colorsay with 0,0," Texto descriptivo "
release window recs
release window memowin
***************
* Memo example 2 - programs

define window memowin from 6,15 to 16,65 system color scheme 8
do inpause with 40
zoom window mmw norm from 5,25 to 5,28
move window mmw to 5,31
do inpause with 40

modify memo code window memowin nowait

* display message
define window recs from 12,30 to 16,50 double color scheme 7
activate window recs
do colorsay with 0,0,"  Programa FoxPro  "
do colorsay with 1,0,"  real almacenado  "
do colorsay with 2,0,"  en un campo Memo "
do apause
do colorgo with 2,0,"  en un campo Memo "
do colorgo with 1,0,"  real almacenado  "
do colorgo with 0,0,"  Programa FoxPro  "
release window recs

release window memowin
release window demomemo.code
release window demomemo.code

***************
* Memo example 3

define window memowin from 11,30 to 15,53 double color scheme 7
activate window memowin
do colorsay with 0,0," Un campo Memo puede  "
do colorsay with 1,0," tener datos binarios "
do colorsay with 2,0," tales como im genes  "
do apause
do colorgo with 2,0," tales como im genes  "
do colorgo with 1,0," tener datos binarios "
do colorgo with 0,0," Un campo Memo puede  "
release window memowin

release window mmw
do overnout

procedure overnout
set escape off
on escape *
on key label escape *
if wexist("browse1")
	release window browse1
endif
if wexist("menusys")
	release window menusys
endif
if wexist("memowin")
	release window memowin
endif
if wexist("curs")
	release window curs
endif
if wexist("recs")
	release window recs
endif
if wexist("customer")
	release window customer
endif
if wexist("browwin")
	release window browwin
endif
for cnt = 1 to 8
	if wexist("letter"+alltrim(str(cnt)))
		release window ("letter"+alltrim(str(cnt)))
	endif
endfor

select 1
use

set sysmenu off
set sysmenu to default
activate screen
clear
if lastkey() = 27
	escpress = .t.
endif
return to rundemo
	
procedure escout
escpress = .t.
clear typeahead
do overnout
return

procedure colorsay
parameters startx,starty,instr1

@ startx,starty say instr1 color GR/R
do inpause with 4
@ startx,starty say instr1 color R+/R
do inpause with 4
@ startx,starty say instr1 color BR/R
do inpause with 4
@ startx,starty say instr1 color BR+/R
do inpause with 4
@ startx,starty say instr1 color BG/R
do inpause with 4
@ startx,starty say instr1 color G/R
do inpause with 4
@ startx,starty say instr1 color G+/R
do inpause with 4
@ startx,starty say instr1 color GR+/R
do inpause with 4
return

procedure colorgo
parameters startx,starty,instr1

@ startx,starty say instr1 color GR+/R
do inpause with 4
@ startx,starty say instr1 color G+/R
do inpause with 4
@ startx,starty say instr1 color G/R
do inpause with 4
@ startx,starty say instr1 color BG/R
do inpause with 4
@ startx,starty say instr1 color BR+/R
do inpause with 4
@ startx,starty say instr1 color BR/R
do inpause with 4
@ startx,starty say instr1 color R+/R
do inpause with 4
@ startx,starty say instr1 color GR/R
do inpause with 4
@ startx,starty say instr1 color R/R
do inpause with 4
return

