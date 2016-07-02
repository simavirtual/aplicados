on key label escape do escout
on escape do escout
set escape on
clear typeahead
set blink off
* do bigchars with 6,20,"Report|Writer"
do bigchars with 6,4," Generador |de informes"
do apause
for cnt = 1 to 23
	release window ("letter"+alltrim(str(cnt)))
endfor
set blink on

SET SYSMENU TO default

SET SYSMENU AUTOMATIC

DEFINE WINDOW marque1 from 18,7 to 21,74 DOUBLE COLOR SCHEME 12;
	TITLE " FoxPro 2.5 - Generador de informes " SHADOW
ACTIVATE WINDOW marque1
@ 0,1 say "El Generador de informes de FoxPro le permite dise¤ar r pida y"          
@ 1,1 say "f cilmente todo tipo de informes, incluso los m s complejos."
do apause

*
* Move Report Writer text from marque to center of the screen.
*

define window menusys from 19,18 to 19,30 none noshadow COLOR SCHEME 12
@ 0,4 say "Generador de informes" color w+/r
activate window menusys
@ 0,0 say "Generador de informes"
move window menusys to 18,18
do inpause with 4
release window menusys
define window menusys from 17,18 to 17,30 none noshadow
activate window menusys
@ 0,0 say "Generador de informes"  COLOR GR+/B
for cnt = 17 to 8 step -1
	move window menusys to cnt,18
	do inpause with 4
endfor
for cnt = 18 to 30
	move window menusys to 8,cnt
	do inpause with 4
endfor

modify report sample nowait
do apause
do effect5 with 2,11,"ÍÍ Encabezado de p gina: ",;
					 " datos que se muestran en ",;
					 " la parte superior de     ",;
	                 " cada una de las p ginas. "
do effect5 with 7,11,"ÍÍ Encabezado de grupo:  ",;
                     " datos que se muestran al ",;
                     " empezar a imprimir cada  ",;
					 " uno de los grupos.       "
do effect5 with 8,11,"ÍÍ Informaci¢n de detalle: ",;
					 " los datos que se muestran  ",;
					 " por cada registro de la    ",;
					 " tabla.                     "
do effect5 with 9,11,"ÍÍ Pie de grupo:         ",;
                     " datos que se muestran al ",;
                     " acabar de imprimir cada  ",;
					 " uno de los grupos.       "
do effect5 with 12,11,"ÍÍ Pie de p gina:        ",;
					  " datos que se muestran en ",;
					  " la parte inferior de     ",;
	                  " cada una de las p ginas. "
do effect5 with 13,11,"ÍÍ Banda Resumen:        ",;
					  " datos que se muestran al ",;
					  " terminar de imprimir el  ",;
					  " informe.                 "
do effect5 with 8,41,"ÍÍ Total de facturas:      ",;
					 " importe almacenado en la   ",;
					 " tabla. Cada registro tiene ",;
					 " los datos de una factura.  "
do effect5 with 10,41,"ÍÍ Total de facturas:   ",;
					  " calculado por grupo     ",;
					  " (cada grupo corresponde ",;
					  " a un vendedor).         "
do effect5 with 15,41,"ÍÍ Total de facturas: ",;
					  " calculado para todo   ",;
					  " el informe (todos los ",;
					  " registros).           "

***********************
* show an example report
define window leftperf from 0,0 to 24,2 color scheme 18
activate window leftperf noshow
for cnt = 0 to 22
	@ cnt,0 say "o"
endfor
define window rightperf from 0,77 to 24,79 color scheme 18
activate window rightperf noshow
for cnt = 0 to 22
	@ cnt,0 say "o"
endfor
define window repobody from 0,2 to 24,77 color scheme 18
activate window repobody noshow
text

 28/05/93           Ranking de ventas por vendedor          P g. 1
ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
³ Vendedor           Total        Empresa            Contacto     ³
ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Bill Diaddigo        3321,66 Vaultec Studies     Ken Bott          
Bill Diaddigo        2615,58 Mixing Systems &    Larry Locey       
                    ÄÄÄÄÄÄÄÄ
                     5937,24

Bob Wubben           3160,93 Univ Diego Corp     Dave Mccarthy     
Bob Wubben           3024,57 Oil & Gallery       Paul Schuartz     
Bob Wubben           2827,62 Hammerman Systems   Paul Dixon        
Bob Wubben           2721,19 Atec Data Service   Randy Keji        
                    ÄÄÄÄÄÄÄÄ
                    11734,31

Carolyn Macioce      2538,18 The Automated       Ann Casey         
Carolyn Macioce      2525,09 Herring Inc.        Bruce Smith       
                    ÄÄÄÄÄÄÄÄ
                     5063,27

Daniel Small         3160,93 Univ Diego Corp     Dave Mccarthy     
Daniel Small         3024,57 Oil & Gallery       Paul Schuartz     
endtext

move window repobody to 24,2
move window leftperf to 24,0
move window rightperf to 24,77
show window leftperf
show window rightperf
show window repobody
for cnt = 24 to 1 step -1
	move window leftperf to cnt,0
	move window rightperf to cnt,77
	move window repobody to cnt,2
	do inpause with 4
endfor

do apause
release window leftperf
release window rightperf
release window repobody


*
* Move Report Writer text from the center of the screen back into  
* marque text.
*
release window sample
activate window menusys
for cnt = 35 to 18 step -1 
	move window menusys to 8,cnt
	do inpause with 4
endfor
for cnt = 8 to 17
	move window menusys to cnt,18
	do inpause with 4
endfor
release window menusys
define window menusys from 18,18 to 18,30 none noshadow COLOR SCHEME 12
activate window menusys
@ 0,0 say "Generador de informes"
move window menusys to 19,18
do inpause with 40
*********************

do overnout
* end of main routine

*********************
*
* effect 5 brings together six windows from edges of the screen
*
procedure effect5
parameters startx,starty,text1,text2,text3,text4

* determine length for widest window
size = max(len(text1),len(text2),len(text3),len(text4)) + 4

* define and fill six windows
define window ef5win1 from startx,starty to startx,starty + size - 1;
	none noshadow color scheme 7
activate window ef5win1 noshow
@ 0,0 say "É"
for cnt = 1 to size - 2
	@ 0,cnt say "Í"
endfor
@ 0,size - 1 say "»"

define window ef5win2 from startx,starty to startx,starty + size - 1;
	none noshadow color scheme 7
activate window ef5win2 noshow
@ 0,0 say "º"
@ 0,round((size/2)-(len(text1)/2),0) say text1
@ 0,size - 1 say "º"

define window ef5win3 from startx,starty to startx,starty + size - 1;
	none noshadow color scheme 7
activate window ef5win3 noshow
@ 0,0 say "º"
@ 0,round((size/2)-(len(text2)/2),0) say text2
@ 0,size - 1 say "º"

define window ef5win4 from startx,starty to startx,starty + size - 1;
	none noshadow color scheme 7
activate window ef5win4 noshow
@ 0,0 say "º"
@ 0,round((size/2)-(len(text3)/2),0) say text3
@ 0,size - 1 say "º"

define window ef5win5 from startx,starty to startx,starty + size - 1;
	none noshadow color scheme 7
activate window ef5win5 noshow
@ 0,0 say "º"
@ 0,round((size/2)-(len(text4)/2),0) say text4
@ 0,size - 1 say "º"

define window ef5win6 from startx,starty to startx,starty + size - 1;
	none noshadow color scheme 7
activate window ef5win6 noshow
@ 0,0 say "È"
for cnt = 1 to size - 2
	@ 0,cnt say "Í"
endfor
@ 0,size - 1 say "¼"

* move windows to starting positions
move window ef5win1 to 0,35
move window ef5win2 to 0,0
move window ef5win3 to 0,80 - size
move window ef5win4 to 24,80 - size
move window ef5win5 to 24,0
move window ef5win6 to 24,35

* move windows to ending positions
show window ef5win3
for cnt = 0 to startx + 2
	move window ef5win3 to cnt,80 - size
endfor
for cnt = 80 - size to starty step -1
	move window ef5win3 to startx + 2,cnt
endfor

show window ef5win5
for cnt = 24 to startx + 4 step -1
	move window ef5win5 to cnt,0
endfor
for cnt = 0 to starty
	move window ef5win5 to startx + 4,cnt
endfor

show window ef5win2
for cnt = 0 to startx + 1
	move window ef5win2 to cnt,0
endfor
for cnt = 0 to starty
	move window ef5win2 to startx + 1,cnt
endfor

show window ef5win4
for cnt = 24 to startx + 3 step -1
	move window ef5win4 to cnt,80 - size
endfor
for cnt = 79 to starty step -1
	move window ef5win4 to startx + 3,cnt
endfor

if starty < 35
	direction = -1
else
	direction = 1
endif

show window ef5win6
for cnt = 24 to startx + 5
	move window ef5win6 to cnt,35
endfor
for cnt = 35 to starty step direction
	move window ef5win6 to startx + 5,cnt
endfor

show window ef5win1
for cnt = 0 to startx
	move window ef5win1 to cnt,35
endfor
for cnt = 35 to starty step direction
	move window ef5win1 to startx,cnt
endfor

do apause

* move windows out of there
activate window ef5win1
do while wlrow() > 0 and wlcol() > 0
	move window ef5win1 by -1,-1
enddo
release window ef5win1

activate window ef5win2
do while wlrow() > 0
	move window ef5win2 by -1,0
enddo
release window ef5win2

activate window ef5win3
do while wlrow() > 0 and wlcol() < 79
	move window ef5win3 by -1,1
enddo
release window ef5win3

activate window ef5win4
do while wlrow() < 24 and wlcol() < 79
	move window ef5win4 by 1,1
enddo
release window ef5win4

activate window ef5win5
do while wlrow() < 24
	move window ef5win5 by 1,0
enddo
release window ef5win5

activate window ef5win6
do while wlrow() < 24 and wlcol() > 0
	move window ef5win6 by 1,-1
enddo
release window ef5win6

return

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
if wexist("ef5win1")
	release window ef5win1
endif
if wexist("ef5win2")
	release window ef5win2
endif
if wexist("ef5win3")
	release window ef5win3
endif
if wexist("ef5win4")
	release window ef5win4
endif
if wexist("ef5win5")
	release window ef5win5
endif
if wexist("ef5win6")
	release window ef5win6
endif
for cnt = 1 to 23
	if wexist("letter"+alltrim(str(cnt)))
		release window ("letter"+alltrim(str(cnt)))
	endif
endfor
if wexist("leftperf")
	release window leftperf
endif
if wexist("rightperf")
	release window rightperf
endif
if wexist("repobody")
	release window repobody
endif
set sysmenu off
set sysmenu to default
activate screen
clear
close databases

return to rundemo

procedure escout
escpress = .t.
do overnout
return

