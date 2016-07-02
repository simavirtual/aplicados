on key label escape do escout
on escape do escout
set escape on
set blink off
clear typeahead
do bigchars with 8,10,"RQBE/SQL"
do apause
for cnt = 1 to 8
	release window ("letter"+alltrim(str(cnt)))
endfor
set blink on
set sysmenu automatic
DEFINE WINDOW rqbe1 from 16,7 to 21,74 DOUBLE COLOR SCHEME 12 TITLE " FoxPro 2.5 - RQBE/SQL " SHADOW
ACTIVATE WINDOW rqbe1
@ 0,1 say " RQBE significa Consulta Relacional seg£n Ejemplo (en inglÇs)."                    
@ 1,1 say " RQBE le permite obtener con rapidez informaci¢n significativa"
@ 2,1 say " a partir de sus tablas o bases de datos. La ventana RQBE es el" 
@ 3,1 say " centro de control para construir sus consultas."
do apause
define window menusys from 19,47 to 19,58 none noshadow COLOR SCHEME 12
@ 2,46 say "ventana RQBE" color w+/r
activate window menusys
@ 0,0 say "ventana RQBE"
for cnt = 19 to 16 step -1
	move window menusys to cnt,46
	do inpause with 4
endfor
release window menusys
define window menusys from 15,47 to 15,58 none noshadow
activate window menusys
@ 0,0 say "ventana RQBE"  COLOR GR+/B
for cnt = 15 to 8 step -1
	move window menusys to cnt,46
	do inpause with 4
endfor
for cnt = 46 to 35 step -1
	move window menusys to 8,cnt
	do inpause with 4
endfor

DEFINE WINDOW rqbescr ;
	FROM 1, 1 ;
	TO 22,78 ;
	NOFLOAT ;
	NOCLOSE ;
	SHADOW ;
	NONE ;
	COLOR SCHEME 8

*       ÷ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ∑
*       ∫                                                         ∫
*       ∫                  RQBESCR Screen Layout                  ∫
*       ∫                                                         ∫ 
*       ”ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒΩ
*    

ACTIVATE WINDOW rqbescr NOSHOW
@ 0,0 TO 21,77 PANEL ;
	COLOR W/W     
@ 10,1 TO 10,76 ;
	COLOR W/BG    
@ 1,17 TO 10,17 ;
	COLOR W/BG    
@ 1,60 TO 10,60 ;
	COLOR W/BG    
@ 7,60 TO 7,76 ;
	COLOR W/BG    
@ 7,60 SAY "√" ;
	COLOR W/BG    
@ 10,60 SAY "¡" ;
	COLOR W/BG    
@ 10,17 SAY "¡" ;
	COLOR W/BG    
@ 1,4 SAY "Tablas"
@ 2,2 TO 7,15 ;
	COLOR B/BG    
@ 3,4 SAY "CLIENTES"
@ 4,4 SAY "FACTURAS"
@ 5,4 SAY "VENDEDOR"
@ 3,3 SAY ""
@ 8,5 SAY "<" ;
	COLOR B/BG    
@ 8,12 SAY ">" ;
	COLOR B/BG    
@ 8,6 SAY "A"
@ 8,7 SAY "§adir" ;
	COLOR B/BG    
@ 9,5 SAY "<" ;
	COLOR B/BG    
@ 9,12 SAY ">" ;
	COLOR B/BG    
@ 9,6 SAY "B"
@ 9,7 SAY "orrar" ;
	COLOR B/BG    
@ 1,21 SAY "Campos de salida"
@ 2,19 TO 9,37 ;
	COLOR B/BG    
@ 3,20 SAY ""
@ 3,20 SAY "" ;
	COLOR B+/BG   
@ 4,20 SAY "" ;
	COLOR B+/BG   
@ 5,20 SAY "" ;
	COLOR B+/BG   
@ 6,20 SAY "" ;
	COLOR B+/BG   
@ 7,20 SAY "" ;
	COLOR B+/BG   
@ 8,20 SAY "" ;
	COLOR B/BG    
@ 3,21 SAY " 1"
@ 4,22 SAY "2"
@ 3,23 SAY ""
@ 4,23 SAY ""
@ 3,25 SAY "NOMBRE"
@ 4,25 SAY "IMP_FACTUR"
@ 5,25 SAY "EMPRESA"
@ 6,25 SAY "CONTACTO"
@ 7,25 SAY "TELêFONO"
@ 3,39 SAY "[X]  ampos..." ;
	COLOR B/BG    
@ 5,39 SAY "[X] Or enar por..." ;
	COLOR B/BG    
@ 7,39 SAY "[ ] Agr par por..." ;
	COLOR B/BG    
@ 8,39 SAY "[ ] Co diciones..." ;
	COLOR B/BG    
@ 5,45 SAY "d"
@ 3,43 SAY "C"
@ 7,46 SAY "u"
@ 8,45 SAY "n"
@ 1,64 SAY "Destino"
@ 2,62 SAY "⁄ƒƒƒƒƒƒƒƒƒƒƒƒø" ;
	COLOR B/BG    
@ 3,62 SAY "≥" ;
	COLOR B/BG    
@ 4,62 SAY "¿ƒƒƒƒƒƒƒƒƒƒƒƒŸ" ;
	COLOR B/BG    
@ 3,75 SAY "≥" ;
	COLOR B/BG    
@ 3,65 SAY "Examinar" ;
	COLOR B/BG    
@ 6,62 SAY "[ ] Opciones..." ;
	COLOR W/BG    
@ 5,62 SAY "EJEMPLO       " ;
	COLOR W+/W    
@ 8,63 SAY "<   er SQL >"
@ 9,63 SAY "Æ"
@ 9,65 SAY "Consultar "
@ 9,74 SAY "Ø"
@ 9,65 SAY "C"
@ 8,66 SAY "V"
@ 11,4 SAY "Nombre"
@ 11,26 SAY "NO"
@ 13,26 SAY "[ ]" ;
	COLOR B/BG    
@ 14,26 SAY "[ ]" ;
	COLOR B/BG    
@ 15,26 SAY "[ ]" ;
	COLOR B/BG    
@ 12,1 TO 20,66 ;
	COLOR B/BG    
@ 13,2 SAY "" ;
	COLOR B/BG    
@ 14,2 SAY "" ;
	COLOR B/BG    
@ 15,2 SAY "" ;
	COLOR B/BG    
@ 13,3 SAY "›" ;
	COLOR B/BG    
@ 14,3 SAY "›" ;
	COLOR B/BG    
@ 13,4 SAY "FACTURAS.COD_CLIENT  " ;
	COLOR W+/W    
@ 16,4 SAY "                     " ;
	COLOR W+/W    
@ 15,4 SAY "FACTURAS.IMP_FACTUR  " ;
	COLOR W+/W    
@ 14,4 SAY "VENDEDOR.COD_OFIC    " ;
	COLOR W+/W    
@ 15,30 SAY "Mayor que" ;
	COLOR W+/W    
@ 13,30 SAY "Como     " ;
	COLOR W+/W    
@ 14,30 SAY "Como     " ;
	COLOR W+/W    
@ 15,63 SAY "[ ]" ;
	COLOR B/BG    
@ 14,63 SAY "[ ]" ;
	COLOR B/BG    
@ 13,63 SAY "[ ]" ;
	COLOR B/BG    
@ 11,40 SAY "Ejemplo"
@ 11,61 SAY "MA mi"
@ 11,63 SAY "˜"
@ 12,67 SAY "selecci¢n"
@ 15,40 SAY "2500                  " ;
	COLOR W+/W    
@ 14,40 SAY "CLIENTES.COD_OFIC     " ;
	COLOR W+/W    
@ 13,40 SAY "CLIENTES.COD_OFIC     " ;
	COLOR W+/W    
@ 11,67 SAY "Criterios"
@ 14,67 SAY "< nsertar>" ;
	COLOR B/BG    
@ 16,67 SAY "<  uitar >" ;
	COLOR B/BG    
@ 18,67 SAY "<   bien >" ;
	COLOR B/BG    
@ 18,69 SAY "O"
@ 16,69 SAY "Q"
@ 14,68 SAY "I"
@ 0,0 SAY "˛" ;
	COLOR GR+/W   
@ 0,32 SAY "RQBE - EJEMPLO" ;
	COLOR GR+/W   

ACTIVATE WINDOW rqbescr

do apause
define window arrow from 4,50 to 4,69 none color scheme 8
activate window arrow noshow
@ 0,0 say "ÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕ<<<" color r/bg
move window arrow to 4,79
show window arrow
for cnt = 79 to 17 step -1
	move window arrow to 4,cnt
endfor
@ 0,2 say "—" color r/bg
@ 0,15 say "—" color r/bg
define window sign6 from 5,19 to 5,32 none color scheme 8
activate window sign6
@ 0,0 say "¿ƒƒƒƒƒƒƒƒƒƒƒƒŸ" color r/bg
do inpause with 4

define window sign1 from 5,19 to 5,32 none color scheme 8
move window sign6 to 6,19
activate window sign1
@ 0,0 say "√ƒƒƒƒƒƒƒƒƒƒƒƒ¥" color r/bg
do inpause with 4

define window sign2 from 6,19 to 6,32 none color scheme 8
move window sign6 to 7,19
activate window sign2
@ 0,0 say "  Tablas que  " color gr+/r
do inpause with 4

define window sign3 from 7,19 to 7,32 none color scheme 8
move window sign6 to 8,19
activate window sign3
@ 0,0 say " se usar†n en " color gr+/r
do inpause with 4

define window sign4 from 8,19 to 8,32 none color scheme 8
move window sign6 to 9,19
activate window sign4
@ 0,0 say " la consulta  " color gr+/r
do inpause with 4

define window sign5 from 9,19 to 9,32 none color scheme 8
move window sign6 to 10,19
activate window sign5
@ 0,0 say "     RQBE     " color gr+/r
do inpause with 4
do apause

hide window sign5
move window sign6 to 9,19
do inpause with 4

hide window sign4
move window sign6 to 8,19
do inpause with 4

hide window sign3
move window sign6 to 7,19
do inpause with 4

hide window sign2
move window sign6 to 6,19
do inpause with 4

hide window sign1
move window sign6 to 5,19
do inpause with 4

hide window sign6
activate window arrow
@ 0,2 say "Õ" color r/bg
@ 0,15 say "Õ" color r/bg
for cnt = 4 to 21
	move window arrow to cnt,17
endfor
hide window arrow
************************
move window arrow to 4,79
show window arrow
for cnt = 79 to 39 step -1
	move window arrow to 4,cnt
endfor
activate window arrow
@ 0,2 say "—" color r/bg
@ 0,15 say "—" color r/bg
move window sign6 to 5,41
activate window sign6
do inpause with 4

move window sign1 to 5,41
move window sign6 to 6,41
activate window sign1
do inpause with 4

move window sign2 to 6,41
move window sign6 to 7,41
activate window sign2
@ 0,0 say "    Campos    " color gr+/r
do inpause with 4

move window sign3 to 7,41
move window sign6 to 8,41
activate window sign3
@ 0,0 say " seleccionados" color gr+/r
do inpause with 4

move window sign4 to 8,41
move window sign6 to 9,41
activate window sign4
@ 0,0 say "  para esta   " color gr+/r
do inpause with 4

move window sign5 to 9,41
move window sign6 to 10,41
activate window sign5
@ 0,0 say "   consulta   " color gr+/r
do inpause with 4
do apause

hide window sign5
move window sign6 to 9,41
do inpause with 4

hide window sign4
move window sign6 to 8,41
do inpause with 4

hide window sign3
move window sign6 to 7,41
do inpause with 4

hide window sign2
move window sign6 to 6,41
do inpause with 4

hide window sign1
move window sign6 to 5,41
do inpause with 4

hide window sign6
activate window arrow
@ 0,2 say "Õ" color r/bg
@ 0,15 say "Õ" color r/bg
for cnt = 4 to 21
	move window arrow to cnt,39
endfor
hide window arrow
****************************
*  fake Select fields dialog

DEFINE WINDOW fakesele ;
	FROM INT((SROW()-19)/2) + 2,INT((SCOL()-77)/2) ;
	TO INT((SROW()-19)/2)+20,INT((SCOL()-77)/2)+76 ;
	NOFLOAT ;
	NOCLOSE ;
	SHADOW ;
	DOUBLE ;
	COLOR SCHEME 5

ACTIVATE WINDOW fakesele NOSHOW
@ 0,8 SAY "Campos de tablas"
@ 11,1 TO 16,29
@ 11,4 SAY " Funciones/Expresiones "
@ 12,3 GET x ;
	PICTURE "@^  Funciones " ;
	SIZE 3,15 ;
	DEFAULT " Funciones "	 ;
	COLOR SCHEME 5, 5
@ 2,31 GET x ;
	PICTURE "@*VN   \<Mover    ;   \<Todos    " ;
	SIZE 1,12,1 ;
	DEFAULT 1
@ 1,46 TO 10,73 ;
	COLOR W/RB    
@ 2,47 SAY ""
@ 3,47 SAY ""
@ 4,47 SAY ""
@ 5,47 SAY ""
@ 9,47 SAY "" ;
	COLOR W/RB    
@ 7,47 SAY "" ;
	COLOR W/RB    
@ 8,47 SAY "" ;
	COLOR W/RB    
@ 7,31 GET x ;
	PICTURE "@*VN       \<Quitar  ;Quitar t\<odos" ;
	SIZE 1,12,1 ;
	DEFAULT 1
@ 6,47 SAY ""
@ 0,49 SAY "Destino seleccionado"
@ 11,52 GET xx ;
	PICTURE "@*C \<Sin duplicados" ;
	SIZE 1,17 ;
	DEFAULT 0
@ 12,52 GET xx ;
	PICTURE "@*C Ta\<bla cruzada" ;
	SIZE 1,17 ;
	DEFAULT 0
@ 14,56 SAY "ÆAceptar Ø"
@ 16,56 SAY "<Cancelar>"
@ 2,2 SAY "CLIENTES.COD_CLIENT    ≥ C " ;
	COLOR W+/BG   
@ 9,2 SAY "CLIENTES.COD_CLIENT    ≥ C " ;
	COLOR W+/BG   
@ 3,2 SAY "CLIENTES.EMPRESA       ≥ C " ;
	COLOR W/BG    
@ 4,2 SAY "CLIENTES.CONTACTO      ≥ C " ;
	COLOR W/BG    
@ 5,2 SAY "CLIENTES.DIRECCION     ≥ C " ;
	COLOR W+/BG   
@ 6,2 SAY "CLIENTES.CIUDAD        ≥ C " ;
	COLOR W+/BG   
@ 7,2 SAY "CLIENTES.ESTADO        ≥ C " ;
	COLOR W+/BG   
@ 8,2 SAY "CLIENTES.COD_POSTAL    ≥ C " ;
	COLOR W+/BG   
@ 9,2 SAY "CLIENTES.TELêFONO      ≥ C " ;
	COLOR W/BG    
@ 2,48 SAY "    REPVENT.NOMBRE       " ;
	COLOR W+/BG   
@ 3,48 SAY "    FACTURAS.IMP_FACTUR  " ;
	COLOR W+/BG   
@ 4,48 SAY "    CLIENTES.EMPRESA     " ;
	COLOR W+/BG   
@ 5,48 SAY "    CLIENTES.CONTACTO    " ;
	COLOR W+/BG   
@ 6,48 SAY "    CLIENTES.TELêFONO    " ;
	COLOR W+/BG   
@ 7,48 SAY "                         " ;
	COLOR W+/BG   
@ 8,48 SAY "                         " ;
	COLOR W+/BG   
@ 9,48 SAY "                         " ;
	COLOR W+/BG   
@ 15,3 SAY "                         " ;
	COLOR W+/BG   
@ 2,40 SAY chr(26)
@ 4,40 SAY chr(26)
@ 1,1 TO 10,29 ;
	COLOR W/RB    
@ 1,29 SAY "‹" ;
	COLOR W/RB    
@ 2,29 SAY "" ;
	COLOR RB/W    
@ 3,29 SAY "" ;
	COLOR RB/W    
@ 4,29 SAY "€" ;
	COLOR W/RB    
@ 5,29 SAY "€" ;
	COLOR W/RB    
@ 6,29 SAY "€" ;
	COLOR W/RB    
@ 7,29 SAY "€" ;
	COLOR W/RB    
@ 8,29 SAY "€" ;
	COLOR W/RB    
@ 9,29 SAY "" ;
	COLOR RB/W    
@ 10,29 SAY "ﬂ" ;
	COLOR W/RB    

ACTIVATE WINDOW fakesele
	
DEFINE WINDOW seletitl ;
	FROM 2, 0 ;
	TO 4,23 ;
	NOFLOAT ;
	NOCLOSE ;
	SHADOW ;
	DOUBLE ;
	COLOR SCHEME 1

ACTIVATE WINDOW seletitl
@ 0,1 SAY "Selecci¢n de campos"
do apause
release window seletitl
release window fakesele

**************************
move window arrow to 4,79
show window arrow
for cnt = 79 to 25 step -1
	move window arrow to 4,cnt
endfor
activate window arrow
@ 0,2 say "—" color r/bg
@ 0,15 say "—" color r/bg
move window sign6 to 5,27
activate window sign6
do inpause with 4

move window sign1 to 5,27
move window sign6 to 6,27
activate window sign1
do inpause with 4

move window sign2 to 6,27
move window sign6 to 7,27
activate window sign2
@ 0,0 say "   Orden en   " color gr+/r
do inpause with 4

move window sign3 to 7,27
move window sign6 to 8,27
activate window sign3
@ 0,0 say "  el que los  " color gr+/r
do inpause with 4

move window sign4 to 8,27
move window sign6 to 9,27
activate window sign4
@ 0,0 say " datos se van " color gr+/r
do inpause with 4

move window sign5 to 9,27
move window sign6 to 10,27
activate window sign5
@ 0,0 say "  a mostrar   " color gr+/r
do inpause with 4
do apause

hide window sign5
move window sign6 to 9,27
do inpause with 4

hide window sign4
move window sign6 to 8,27
do inpause with 4

hide window sign3
move window sign6 to 7,27
do inpause with 4

hide window sign2
move window sign6 to 6,27
do inpause with 4

hide window sign1
move window sign6 to 5,27
do inpause with 4

hide window sign6
activate window arrow
@ 0,2 say "Õ" color r/bg
@ 0,15 say "Õ" color r/bg
for cnt = 4 to 21
	move window arrow to cnt,25
endfor
hide window arrow
**************************
*  fake Order fields dialog
DEFINE WINDOW fakeorde ;
	FROM 5, 3 ;
	TO 22,76 ;
	NOFLOAT ;
	NOCLOSE ;
	SHADOW ;
	DOUBLE ;
	COLOR SCHEME 5


ACTIVATE WINDOW fakeorde NOSHOW
@ 2,30 GET x ;
	PICTURE "@*VN \<Mover ;\<Quitar" ;
	SIZE 1,12,1 ;
	DEFAULT 1
@ 1,1 TO 14,25 ;
	COLOR W/RB    
@ 0,3 SAY "Destino seleccionado"
@ 12,31 SAY "ÆAceptar Ø"
@ 14,31 SAY "<Cancelar>"
@ 1,47 SAY ""
@ 2,47 SAY ""
@ 3,47 SAY ""
@ 8,47 SAY "" ;
	COLOR W/RB    
@ 6,47 SAY "" ;
	COLOR W/RB    
@ 7,47 SAY "" ;
	COLOR W/RB    
@ 1,46 TO 14,70 ;
	COLOR W/RB    
@ 11,47 SAY "" ;
	COLOR W/RB    
@ 9,47 SAY "" ;
	COLOR W/RB    
@ 10,47 SAY "" ;
	COLOR W/RB    
@ 12,47 SAY "" ;
	COLOR W/RB    
@ 4,47 SAY "" ;
	COLOR W/RB    
@ 5,47 SAY "" ;
	COLOR W/RB    
@ 6,27 TO 10,44
@ 6,28 SAY " Sentido "
@ 0,48 SAY "Criterios de ordenaci¢n"
@ 2,2 SAY " REPVENT.NOMBRE        " ;
	COLOR W/BG    
@ 3,2 SAY " FACTURAS.IMP_FACTUR   " ;
	COLOR W/BG    
@ 4,2 SAY " CLIENTES.EMPRESA      " ;
	COLOR W+/BG   
@ 5,2 SAY " CLIENTES.CONTACTO     " ;
	COLOR W+/BG   
@ 6,2 SAY " CLIENTES.TELêFONO     " ;
	COLOR W+/BG   
@ 7,2 SAY "                       " ;
	COLOR W+/BG   
@ 8,2 SAY "                       " ;
	COLOR W+/BG   
@ 9,2 SAY "                       " ;
	COLOR W+/BG   
@ 10,2 SAY "                       " ;
	COLOR W+/BG   
@ 11,2 SAY "                       " ;
	COLOR W+/BG   
@ 12,2 SAY "                       " ;
	COLOR W+/BG   
@ 2,48 SAY "   REPVENT.NOMBRE    " ;
	COLOR W+/BG   
@ 3,48 SAY "   FACTURAS.IMP_FACTU" ;
	COLOR W+/BG   
@ 4,48 SAY "                      " ;
	COLOR W+/BG   
@ 5,48 SAY "                      " ;
	COLOR W+/BG   
@ 6,48 SAY "                      " ;
	COLOR W+/BG   
@ 7,48 SAY "                      " ;
	COLOR W+/BG   
@ 8,48 SAY "                      " ;
	COLOR W+/BG   
@ 9,48 SAY "                      " ;
	COLOR W+/BG   
@ 10,48 SAY "                      " ;
	COLOR W+/BG   
@ 11,48 SAY "                      " ;
	COLOR W+/BG   
@ 12,48 SAY "                      " ;
	COLOR W+/BG   
@ 7,28 GET x ;
	PICTURE "@*RVN \<Ascendente;\<Descendente" ;
	SIZE 1,14,0 ;
	DEFAULT 1
@ 9,28 GET xx ;
	PICTURE "@*C \<MAY=min" ;
	SIZE 1,15 ;
	DEFAULT 0
@ 13,48 SAY "                      " ;
	COLOR W+/BG   
@ 13,47 SAY "" ;
	COLOR W/RB    
@ 13,2 SAY "                       " ;
	COLOR W+/BG   
@ 2,38 SAY chr(26)

ACTIVATE WINDOW fakeorde
**************************
DEFINE WINDOW ordetitl ;
	FROM 2, 0 ;
	TO 4,23 ;
	NOFLOAT ;
	NOCLOSE ;
	SHADOW ;
	DOUBLE ;
	COLOR SCHEME 1

ACTIVATE WINDOW ordetitl
@ 0,1 SAY "   Ordenar campos"
do apause
release window ordetitl
release window fakeorde
*************************
define window arrow2 from 4,50 to 4,69 none color scheme 8
activate window arrow2 noshow
@ 0,0 say ">>>ÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕ" color r/bg
move window arrow2 to 4,0
show window arrow2
for cnt = 0 to 43
	move window arrow2 to 4,cnt
endfor

DEFINE WINDOW fakepop ;
	FROM 3, 64 ;
	TO 9,79 ;
	NOFLOAT ;
	NOCLOSE ;
	SHADOW ;
	NONE ;
	COLOR SCHEME 8

ACTIVATE WINDOW fakepop NOSHOW
@ 0,0 TO 6,15 ;
	COLOR B/BG    
@ 1,2 SAY "Examinar"
@ 2,2 SAY "Informe/Etiqu"
@ 3,2 SAY "Tabla/DBF"
@ 4,2 SAY "Cursor"
@ 5,2 SAY "Graph"

ACTIVATE WINDOW fakepop
do inpause with 4
hide window fakepop
do inpause with 4
show window fakepop
do inpause with 4
hide window fakepop
do inpause with 4
show window fakepop

activate window arrow2
@ 0,4 say "—" color r/bg
@ 0,17 say "—" color r/bg
move window sign6 to 5,47
activate window sign6
do inpause with 4

move window sign1 to 5,47
move window sign6 to 6,47
activate window sign1
do inpause with 4

move window sign2 to 6,47
move window sign6 to 7,47
activate window sign2
@ 0,0 say "    Destinos   " color gr+/r
do inpause with 4

move window sign3 to 7,47
move window sign6 to 8,47
activate window sign3
@ 0,0 say " del resultado" color gr+/r
do inpause with 4

move window sign4 to 8,47
move window sign6 to 9,47
activate window sign4
@ 0,0 say "    de la     " color gr+/r
do inpause with 4

move window sign5 to 9,47
move window sign6 to 10,47
activate window sign5
@ 0,0 say "   consulta   " color gr+/r
do inpause with 4
do apause

hide window sign5
move window sign6 to 9,47
do inpause with 4

hide window sign4
move window sign6 to 8,47
do inpause with 4

hide window sign3
move window sign6 to 7,47
do inpause with 4

hide window sign2
move window sign6 to 6,47
do inpause with 4

hide window sign1
move window sign6 to 5,47
do inpause with 4

hide window sign6
activate window arrow2
@ 0,4 say "Õ" color r/bg
@ 0,17 say "Õ" color r/bg
for cnt = 4 to 21
	move window arrow2 to cnt,43
endfor
hide window arrow2

release window fakepop
***********************
move window arrow2 to 7,0
show window arrow2
for cnt = 0 to 43
	move window arrow2 to 7,cnt
endfor

activate window arrow2
@ 0,4 say "—" color r/bg
@ 0,17 say "—" color r/bg
move window sign6 to 8,47
activate window sign6
do inpause with 4

move window sign1 to 8,47
move window sign6 to 9,47
activate window sign1
do inpause with 4

move window sign2 to 9,47
move window sign6 to 10,47
activate window sign2
@ 0,0 say "   Opciones   " color gr+/r
do inpause with 4

move window sign3 to 10,47
move window sign6 to 11,47
activate window sign3
@ 0,0 say "   de salida  " color gr+/r
do inpause with 4

move window sign4 to 11,47
move window sign6 to 12,47
activate window sign4
@ 0,0 say "   para la    " color gr+/r
do inpause with 4

move window sign5 to 12,47
move window sign6 to 13,47
activate window sign5
@ 0,0 say "   consulta   " color gr+/r
do inpause with 4
do apause

hide window sign5
move window sign6 to 12,47
do inpause with 4

hide window sign4
move window sign6 to 11,47
do inpause with 4

hide window sign3
move window sign6 to 10,47
do inpause with 4

hide window sign2
move window sign6 to 9,47
do inpause with 4

hide window sign1
move window sign6 to 8,47
do inpause with 4

hide window sign6
activate window arrow2
@ 0,4 say "Õ" color r/bg
@ 0,17 say "Õ" color r/bg
for cnt = 7 to 21
	move window arrow2 to cnt,43
endfor
hide window arrow2
***************************
DEFINE WINDOW fakedisp ;
	FROM 4, 2 ;
	TO 23,76 ;
	NOFLOAT ;
	NOCLOSE ;
	SHADOW ;
	DOUBLE ;
	COLOR SCHEME 5

ACTIVATE WINDOW fakedisp NOSHOW
@ 10,52 SAY "ÆAceptar Ø"
@ 12,52 SAY "<Cancelar>"
@ 0,1 SAY "Opciones de presentaci¢n RQBE:"
@ 2,2 TO 17,43
@ 2,4 SAY " Opciones de formato"
@ 3,4 GET x ;
	PICTURE "@*RVN En panta\<lla;\<Informe;E\<tiqueta" ;
	SIZE 1,18,0 ;
	DEFAULT 2
@ 6,8 GET xx ;
	PICTURE "@*C Nomb\<re de formulario" ;
	SIZE 1,26 ;
	DEFAULT 0
@ 7,12 SAY "                     " ;
	COLOR W+/BG   
@ 8,8 GET xx ;
	PICTURE "@*C Informe \<r†pido" ;
	SIZE 1,19 ;
	DEFAULT 0
@ 9,8 GET xx ;
	PICTURE "@*C \<Presentaci¢n preliminar" ;
	SIZE 1,24 ;
	DEFAULT 0
@ 10,8 GET xx ;
	PICTURE "@*C \<Mostrar s¢lo info resumen" ;
	SIZE 1,26 ;
	DEFAULT 0
@ 11,8 GET xx ;
	PICTURE "@*C \<Expulsar p†g. antes de informe" ;
	SIZE 1,28 ;
	DEFAULT 0
@ 12,8 GET xx ;
	PICTURE "@*C \<Encabezado del informe" ;
	SIZE 1,18 ;
	DEFAULT 0
@ 13,12 SAY "                     " ;
	COLOR W+/BG   
@ 14,8 GET xx ;
	PICTURE "@*C Suprimir encabezados de \<columna" ;
	SIZE 1,28 ;
	DEFAULT 0
@ 15,8 GET xx ;
	PICTURE "@*RHN CONSOLE O\<N;CONSOLE \<OFF" ;
	SIZE 1,15,0 ;
	DEFAULT 1
@ 2,44 TO 6,70
@ 2,45 SAY " Destinos "
@ 3,46 GET xx ;
	PICTURE "@*C A im\<presora" ;
	SIZE 1,14 ;
	DEFAULT 0
@ 4,46 GET xx ;
	PICTURE "@*C A arc\<hivo" ;
	SIZE 1,11 ;
	DEFAULT 0
@ 4,59 SAY "          " ;
	COLOR W+/BG   
@ 8,28 SAY "[ ] Sobrescr." ;
	COLOR W/RB    
@ 16,12 SAY "[ ] Pausa entre pantallas" ;
	COLOR W/RB    
@ 5,50 SAY "[ ] Sobrescr." ;
	COLOR W/RB    

ACTIVATE WINDOW fakedisp
do apause
release window fakedisp
**************************
move window arrow2 to 9,0
show window arrow2
for cnt = 0 to 43
	move window arrow2 to 9,cnt
endfor

activate window arrow2
@ 0,4 say "—" color r/bg
@ 0,17 say "—" color r/bg
move window sign6 to 10,47
activate window sign6
do inpause with 4

move window sign1 to 10,47
move window sign6 to 11,47
activate window sign1
do inpause with 4

move window sign2 to 11,47
move window sign6 to 12,47
activate window sign2
@ 0,0 say "    Vea la    " color gr+/r
do inpause with 4

move window sign3 to 12,47
move window sign6 to 13,47
activate window sign3
@ 0,0 say " instrucci¢n  " color gr+/r
do inpause with 4

move window sign4 to 13,47
move window sign6 to 14,47
activate window sign4
@ 0,0 say "  SQL que se  " color gr+/r
do inpause with 4

move window sign5 to 14,47
move window sign6 to 15,47
activate window sign5
@ 0,0 say "    genera   " color gr+/r
do inpause with 4
do apause

hide window sign5
move window sign6 to 14,47
do inpause with 4

hide window sign4
move window sign6 to 13,47
do inpause with 4

hide window sign3
move window sign6 to 12,47
do inpause with 4

hide window sign2
move window sign6 to 11,47
do inpause with 4

hide window sign1
move window sign6 to 10,47
do inpause with 4

hide window sign6
activate window arrow2
@ 0,4 say "Õ" color r/bg
@ 0,17 say "Õ" color r/bg
for cnt = 9 to 21
	move window arrow2 to cnt,43
endfor
hide window arrow2
**************************
define window sqlwin from 5,9 to 15,71 system 
activate window sqlwin
@ 0,1 say "SELECT VENDEDOR.NOMBRE, FACTURAS.IMP_FACTUR, CLIENTES.EMPRESA,;"
@ 1,1 say "  CLIENTES.CONTACTO, CLIENTES.TELêFONO;"
@ 2,1 say " FROM CLIENTES, FACTURAS, REPVENT;"
@ 3,1 say " WHERE FACTURAS.COD_CLIENT = CLIENTES.COD_CLIENT;"
@ 4,1 say "   AND REPVENT.COD_OFIC = CLIENTES.COD_OFIC;"
@ 5,1 say "   AND FACTURAS.IMP_FACTUR > 2500;"
@ 6,1 say " ORDER BY REPVENT.NOMBRE, FACTURAS.IMP_FACTUR DESCENDING;"
@ 7,1 say " INTO CURSOR EJEMPLO"
@ 8,1 say "BROWSE NOMODIFY"
do apause
release window sqlwin
**************************
move window arrow2 to 10,0
show window arrow2
for cnt = 0 to 43
	move window arrow2 to 10,cnt
endfor

activate window arrow2
@ 0,4 say "—" color r/bg
@ 0,17 say "—" color r/bg
move window sign6 to 11,47
activate window sign6
do inpause with 4

move window sign1 to 11,47
move window sign6 to 12,47
activate window sign1
do inpause with 4

move window sign2 to 12,47
move window sign6 to 13,47
activate window sign2
@ 0,0 say "   El bot¢n   " color gr+/r
do inpause with 4

move window sign3 to 13,47
move window sign6 to 14,47
activate window sign3
@ 0,0 say "  ÆConsultarØ " color gr+/r
do inpause with 4

move window sign4 to 14,47
move window sign6 to 15,47
activate window sign4
@ 0,0 say "   realiza    " color gr+/r
do inpause with 4

move window sign5 to 15,47
move window sign6 to 16,47
activate window sign5
@ 0,0 say "  la consulta " color gr+/r
do inpause with 4
do apause

hide window sign5
move window sign6 to 15,47
do inpause with 4

hide window sign4
move window sign6 to 14,47
do inpause with 4

hide window sign3
move window sign6 to 13,47
do inpause with 4

hide window sign2
move window sign6 to 12,47
do inpause with 4

hide window sign1
move window sign6 to 11,47
do inpause with 4

hide window sign6
activate window arrow2
@ 0,4 say "Õ" color r/bg
@ 0,17 say "Õ" color r/bg
for cnt = 10 to 21
	move window arrow2 to cnt,43
endfor
hide window arrow2
********************************
move window arrow2 to 10,0
show window arrow2
for cnt = 0 to 43
	move window arrow2 to 10,cnt
endfor

activate window arrow2
@ 0,4 say "—" color r/bg
@ 0,17 say "—" color r/bg
move window sign6 to 11,47
activate window sign6
do inpause with 4

move window sign1 to 11,47
move window sign6 to 12,47
activate window sign1
do inpause with 4

move window sign2 to 12,47
move window sign6 to 13,47
activate window sign2
@ 0,0 say " Esta consulta" color gr+/r
do inpause with 4

move window sign3 to 13,47
move window sign6 to 14,47
activate window sign3
@ 0,0 say "  produce una " color gr+/r
do inpause with 4

move window sign4 to 14,47
move window sign6 to 15,47
activate window sign4
@ 0,0 say "  ventana con " color gr+/r
do inpause with 4

move window sign5 to 15,47
move window sign6 to 16,47
activate window sign5
@ 0,0 say "   sus datos  " color gr+/r
do inpause with 4
do apause

hide window sign5
move window sign6 to 15,47
do inpause with 4

hide window sign4
move window sign6 to 14,47
do inpause with 4

hide window sign3
move window sign6 to 13,47
do inpause with 4

hide window sign2
move window sign6 to 12,47
do inpause with 4

hide window sign1
move window sign6 to 11,47
do inpause with 4

hide window sign6
activate window arrow2
@ 0,4 say "Õ" color r/bg
@ 0,17 say "Õ" color r/bg
for cnt = 10 to 21
	move window arrow2 to cnt,43
endfor
hide window arrow2
********************************
select 0
use sampleq
browse normal preference sampleq nowait
do apause
use

release window rqbescr

activate window menusys
for cnt = 35 to 46 
	move window menusys to 8,cnt
	do inpause with 4
endfor
for cnt = 8 to 15
	move window menusys to cnt,46
	do inpause with 4
endfor
release window menusys
define window menusys from 16,46 to 16,57 none noshadow COLOR SCHEME 12
activate window menusys
@ 0,0 say "ventana RQBE"
for cnt = 16 to 19
	move window menusys to cnt,46
	do inpause with 4
endfor
do inpause with 40
	
*********************
do overnout
*********************
procedure overnout
set escape off
on escape *
on key label escape *
if wexist("rqbe1")
	release window rqbe1
endif
if wexist("arrow")
	release window arrow
endif
if wexist("arrow2")
	release window arrow2
endif
if wexist("RQBESCR")
	release window rqbescr
endif
if wexist("sign1")
	release window sign1
endif
if wexist("sign2")
	release window sign2
endif
if wexist("sign3")
	release window sign3
endif
if wexist("sign4")
	release window sign4
endif
if wexist("sign5")
	release window sign5
endif
if wexist("sign6")
	release window sign6
endif
if wexist("fakesele")
	release window fakesele
endif
if wexist("seletitl")
	release window seletitl
endif
if wexist("ordetitl")
	release window ordetitl
endif
if wexist("sqlwin")
	release window sqlwin
endif
if wexist("menusys")
	release window menusys
endif
if wexist("fakepop")
	release window fakepop
endif
if wexist("fakedisp")
	release window fakedisp
endif
if wexist("fakeorde")
	release window fakeorde
endif
if wexist("sampleq")
	release window sampleq
endif
if wexist("tempbrow")
	release window tempbrow
endif
for cnt = 1 to 8
	if wexist("letter"+alltrim(str(cnt)))
		release window ("letter"+alltrim(str(cnt)))
	endif
endfor
activate screen
clear
close databases
return to rundemo

procedure escout
clear typeahead
escpress = .t.
do overnout
return

