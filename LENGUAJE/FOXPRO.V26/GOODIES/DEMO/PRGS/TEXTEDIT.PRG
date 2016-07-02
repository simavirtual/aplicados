on key label escape do escout
on escape do escout
set escape on
set blink off
do bigchars with 8,8," Edici¢n|de textos"
do apause
for cnt = 1 to 18
	release window ("letter"+alltrim(str(cnt)))
endfor
set blink on

SET SYSMENU TO default

SET SYSMENU AUTOMATIC


DEFINE WINDOW marque1 from 18,7 to 21,74 DOUBLE COLOR SCHEME 12;
	TITLE " FoxPro 2.5 - Editor de textos " SHADOW
ACTIVATE WINDOW marque1
@ 0,1 say "El editor de textos incorporado en FoxPro le permite mucho m s"          
@ 1,1 say "que escribir y modificar textos."
do apause

*
* Move Text Editor text from marque to center of the screen.
*

define window menusys from 19,27 to 19,37 none noshadow COLOR SCHEME 12
@ 0,4 say "editor de textos" color w+/r
activate window menusys
@ 0,0 say "editor de textos"
move window menusys to 18,27
do inpause with 4
release window menusys
define window menusys from 17,27 to 17,37 none noshadow
activate window menusys
@ 0,0 say "editor de textos"  COLOR GR+/B
for cnt = 17 to 8 step -1
	move window menusys to cnt,27
	do inpause with 4
endfor
for cnt = 27 to 35
	move window menusys to 8,cnt
	do inpause with 4
endfor

define window fakestat from 3,2 to 3,75 none
activate window fakestat noshow
@ 0,0 say "   L: 352    C: 1    INS         NUM                                      ";
 color w+/b

modi comm laserc save nowait
show window fakestat

do effect21 with 4,25," En la l¡nea de estado se ",;
 					  " muestran los n£meros de  ",;
 					  " l¡nea y columna, y el    ",;
 					  " estado de diversas teclas"

modify command sampleq save nowait
do effect21 with 20,25," Puede abrir las ventanas ",;
					   " de edici¢n que desee.    "
					   
define window faketext from 10,9 to 18,69 none color scheme 8
activate window faketext noshow
@ 0,0 say "SELECT VENDEDOR.NOMBRE,FACTURAS.IMP_FACTUR,CLIENTES.EMPRESA,;" color w+/r
@ 1,0 say "   CLIENTES.CONTACTO, CLIENTES.TELFONO;                     " color w+/r
@ 2,0 say "  FROM CLIENTES, FACTURAS, VENDEDOR;                         " color w+/r
@ 3,0 say "  WHERE FACTURAS.COD_CLIENT = CLIENTES.COD_CLIENT;           " color w+/r
@ 4,0 say "    AND VENDEDOR.COD_OFIC = CLIENTES.COD_OFIC;               " color w+/r
@ 5,0 say "    AND FACTURAS.IMP_FACTUR > 2500;                          " color w+/r
@ 6,0 say "  ORDER BY VENDEDOR.NOMBRE, FACTURAS.IMP_FACTUR DESCENDING;  " color w+/r
@ 7,0 say "  INTO CURSOR EJEMPLO                                        " color w+/r
@ 8,0 say " BROWSE NOMODIFY                                             " color w+/r

show window faketext
do effect21 with 20,25," Puede seleccionar partes de  ",;
					   " la pantalla, incluso grandes,",;
					   " para manipularlas. As¡, para ",;
					   " copiar este texto y...       "
					   
hide window faketext
activate window laserc
activate window fakestat

do effect21 with 12,10," situarlo en este programa, el  ",;
 					   " editor de textos de FoxPro le  ",;
 					   " resultar  de gran ayuda.       "

activate window faketext noshow
@ 0,0 say "SELECT VENDEDOR.NOMBRE,FACTURAS.IMP_FACTUR,CLIENTES.EMPRESA,;"
@ 1,0 say "   CLIENTES.CONTACTO, CLIENTES.TELFONO;                     "
@ 2,0 say "  FROM CLIENTES, FACTURAS, VENDEDOR;                         " 
@ 3,0 say "  WHERE FACTURAS.COD_CLIENT = CLIENTES.COD_CLIENT;           "
@ 4,0 say "    AND VENDEDOR.COD_OFIC = CLIENTES.COD_OFIC;               "
@ 5,0 say "    AND FACTURAS.IMP_FACTUR > 2500;                          "
@ 6,0 say "  ORDER BY VENDEDOR.NOMBRE, FACTURAS.IMP_FACTUR DESCENDING;  "  
@ 7,0 say "  INTO CURSOR EJEMPLO                                        "  
@ 8,0 say " BROWSE NOMODIFY                                             " 
move window faketext to 5,2
show window faketext
do apause

release window sampleq
release window fakestat
release window faketext
release window laserc

*
* Move Text Editor text from the center of the screen back into  
* marque text.
*
activate window menusys
for cnt = 35 to 27 step -1
	move window menusys to 8,cnt
	do inpause with 4
endfor
for cnt = 8 to 18
	move window menusys to cnt,27
	do inpause with 4
endfor
release window menusys
define window menusys from 18,27 to 18,37 none noshadow COLOR SCHEME 12
activate window menusys
@ 0,0 say "editor de textos"
move window menusys to 19,27
do inpause with 40
	
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
if wexist("laserc")
	release window laserc
endif
if wexist("fakestat")
	release window fakestat
endif
if wexist("faketext")
	release window faketext
endif
if wexist("sampleq")
	release window sampleq
endif
if wexist("upleft")
	release window upleft
endif
if wexist("upright")
	release window upright
endif
if wexist("lowleft")
	release window lowleft
endif
if wexist("lowright")
	release window lowright
endif
for cnt = 1 to 18
	if wexist("letter"+alltrim(str(cnt)))
		release window ("letter"+alltrim(str(cnt)))
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

procedure effect21
parameters xstart,ystart,instr1,instr2,instr3,instr4

length = parameters() - 2
if length < 2 
	return
endif

width = 0
for cnt = 1 to length
	if len(evaluate("instr"+alltrim(str(cnt)))) > width
		width = len(evaluate("instr"+alltrim(str(cnt))))
	endif
endfor

define window upleft from xstart,ystart to ;
 xstart+ceiling(length/2)-1,ystart+ceiling(width/2)-1 none color scheme 7
activate window upleft noshow
xcnt = 0
for cnt = 1 to ceiling(length/2)
	@ 0 + xcnt,0 say substr(evaluate("instr"+alltrim(str(cnt))),1,ceiling(width/2))
	xcnt = xcnt + 1
endfor
move window upleft to 1,0
show window upleft

define window upright from xstart,ystart to ;
 xstart+ceiling(length/2)-1,ystart+ceiling(width/2)-1 none color scheme 7
activate window upright noshow
xcnt = 0
for cnt = 1 to ceiling(length/2)
	@ 0 + xcnt,0 say substr(evaluate("instr"+alltrim(str(cnt))),ceiling(width/2)+1)
	xcnt = xcnt + 1
endfor
move window upright to 1,80-ceiling(width/2)
show window upright

define window lowleft from xstart,ystart to ;
 xstart+ceiling(length/2)-1,ystart+ceiling(width/2)-1 none color scheme 7
activate window lowleft noshow
xcnt = 0
for cnt = ceiling(length/2)+1 to length
	@ 0 + xcnt,0 say substr(evaluate("instr"+alltrim(str(cnt))),1,ceiling(width/2))
	xcnt = xcnt + 1
endfor
move window lowleft to 23,0
show window lowleft

define window lowright from xstart,ystart to ;
 xstart+ceiling(length/2)-1,ystart+ceiling(width/2)-1 none color scheme 7
activate window lowright noshow
xcnt = 0
for cnt = ceiling(length/2)+1 to length
	@ 0 + xcnt,0 say substr(evaluate("instr"+alltrim(str(cnt))),ceiling(width/2)+1)
	xcnt = xcnt + 1
endfor
move window lowright to 23,80-ceiling(width/2)
show window lowright

for cnt = 1 to xstart
	move window upleft to cnt,0
endfor
for cnt = 0 to ystart
	move window upleft to xstart,cnt
endfor

for cnt = 1 to xstart
	move window upright to cnt,80-ceiling(width/2)
endfor
for cnt = 80-ceiling(width/2) to ystart+ceiling(width/2) step -1
	move window upright to xstart,cnt
endfor

for cnt = 23 to xstart+ceiling(length/2) step -1
	move window lowleft to cnt,0
endfor
for cnt = 0 to ystart
	move window lowleft to xstart+ceiling(length/2),cnt
endfor

for cnt = 23 to xstart+ceiling(length/2) step -1
	move window lowright to cnt,80-ceiling(width/2)
endfor
for cnt = 80-ceiling(width/2) to ystart+ceiling(width/2) step -1
	move window lowright to xstart+ceiling(length/2),cnt
endfor

do apause

release window upleft
release window upright
release window lowleft
release window lowright
