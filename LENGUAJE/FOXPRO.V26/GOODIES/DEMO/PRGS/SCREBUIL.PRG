on key label escape do escout
on escape do escout
set escape on
clear typeahead
set blink off
do bigchars with 6,4," Generador |de pantallas"
do apause
for cnt = 1 to 24
	release window ("letter"+alltrim(str(cnt)))
endfor
set blink on
set sysmenu automatic

DEFINE WINDOW marque1 from 18,7 to 21,74 DOUBLE COLOR SCHEME 12;
	TITLE " FoxPro 2.5 - Generador de pantallas " SHADOW
ACTIVATE WINDOW marque1
@ 0,1 say "El Generador de pantallas de FoxPro le permite dise¤ar pantallas "          
@ 1,1 say "de edici¢n e introducci¢n de datos."
do apause

*
* Move Screen Builder text from marque to center of the screen.
*

define window menusys from 19,18 to 19,39 none noshadow COLOR SCHEME 12
@ 0,4 say "Generador de pantallas" color w+/r
activate window menusys
@ 0,0 say "Generador de pantallas"
move window menusys to 18,18
do inpause with 4
release window menusys
define window menusys from 17,18 to 17,31 none noshadow
activate window menusys
@ 0,0 say "Generador de pantallas"  COLOR GR+/B
for cnt = 17 to 8 step -1
	move window menusys to cnt,18
	do inpause with 4
endfor
for cnt = 18 to 30
	move window menusys to 8,cnt
	do inpause with 4
endfor

DEFINE WINDOW laser ;
	FROM 1, 0 ;
	TO 24,76 ;
	TITLE " Biblioteca de Discos L ser " ;
	FLOAT ;
	CLOSE ;
	SHADOW ;
	MINIMIZE ;
	NONE ;
	COLOR SCHEME 1

*       ÖÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ·
*       º                                                         º
*       º                   LASER Screen Layout                   º
*       º                                                         º 
*       ÓÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ½
*    

ACTIVATE WINDOW laser NOSHOW
@ 4,3 SAY "T¡tulo"
@ 6,3 SAY "Precio"
@ 12,17 SAY "Calificaci¢n"
@ 7,3 SAY "F_compra"
@ 8,25 SAY "Duraci¢n"
@ 7,25 SAY "Caras"
@ 9,25 SAY "A¤o"
@ 6,45 SAY "Comentarios"
@ 5,3 SAY "N§Cat logo"
@ 8,3 SAY "Calidad"
@ 9,3 SAY "Cr¡tica"
@ 18,17 SAY "Orden"
@ 4,60 SAY "N§ Reg."
@ 15,17 SAY "Estudio"
@ 4,45 SAY "Borrado:"
@ 0,0 TO 23,76 PANEL ;
	COLOR W/W     
@ 2,1 TO 22,75 ;
	COLOR GR+/B   
@ 2,28 SAY "    Discos L ser   " ;
	COLOR GR+/B   
@ 1,1 TO 1,75 PANEL ;
	COLOR BG/BG   
@ 1,2 SAY "L:  0 C:  0  " ;
	COLOR W+/BG   
@ 1,14 SAY "º" ;
	COLOR W+/BG   
@ 1,29 SAY "º" ;
	COLOR W+/BG   
@ 1,24 SAY "Move" ;
	COLOR W+/BG   
@ 0,0 SAY "ş" ;
	COLOR GR+/W   
@ 0,76 SAY "ğ" ;
	COLOR GR+/W   
@ 23,76 SAY "ù" ;
	COLOR GR+/W   
@ 4,14 SAY "4: t¡tulo..................." ;
	COLOR W+/BG   
@ 5,14 SAY "5: n£mcat." ;
	COLOR W+/BG   
@ 6,14 SAY "6: pre" ;
	COLOR W+/BG   
@ 7,14 SAY "7: compr" ;
	COLOR W+/BG   
@ 8,14 SAY "8:" ;
	COLOR W+/BG   
@ 9,14 SAY "9" ;
	COLOR W+/BG   
@ 7,35 SAY "10" ;
	COLOR W+/BG   
@ 8,35 SAY "11:" ;
	COLOR W+/BG   
@ 9,35 SAY "12: " ;
	COLOR W+/BG   
@ 4,54 SAY "2: i" ;
	COLOR W+/BG   
@ 4,69 SAY "1: r" ;
	COLOR W+/BG   
@ 7,45 SAY "13: descripc................" ;
	COLOR N/W     
@ 8,45 SAY "............................" ;
	COLOR N/W     
@ 9,45 SAY "............................" ;
	COLOR N/W     
@ 10,45 SAY "............................" ;
	COLOR N/W     
@ 11,45 SAY "............................" ;
	COLOR N/W     
@ 7,73 SAY "" ;
	COLOR W/N     
@ 8,73 SAY "Û" ;
	COLOR N/N     
@ 9,73 SAY "Û" ;
	COLOR N/N     
@ 10,73 SAY "Û" ;
	COLOR N/N     
@ 11,73 SAY "" ;
	COLOR W/N     
@ 13,30 SAY "[ ] Copia digital" ;
	COLOR GR+/B   
@ 14,30 SAY "[ ] Audio digital" ;
	COLOR GR+/B   
@ 15,30 SAY "[ ] Est‚reo" ;
	COLOR GR+/B   
@ 16,30 SAY "[ ] Sonido envolvente" ;
	COLOR GR+/B   
@ 17,30 SAY "[ ] Sistema CX" ;
	COLOR GR+/B   
@ 18,30 SAY "[ ] Codificada" ;
	COLOR GR+/B   
@ 19,30 SAY "[ ] Sistema LB" ;
	COLOR GR+/B   
@ 13,52 SAY "[ ] Formato CAV" ;
	COLOR GR+/B   
@ 14,52 SAY "[ ] Blanco y negro" ;
	COLOR GR+/B   
@ 15,52 SAY "[ ] Subtitulada" ;
	COLOR GR+/B   
@ 16,52 SAY "[ ] Doblada" ;
	COLOR GR+/B   
@ 17,52 SAY "[ ] Muda" ;
	COLOR GR+/B   
@ 18,52 SAY "[ ] Comentarios" ;
	COLOR GR+/B   
@ 19,52 SAY "[ ] Suplementos" ;
	COLOR GR+/B   
@ 11,4 SAY "ÚÄÄÄÄÄÄÄÄÄÄ¿" ;
	COLOR GR+/B   
@ 12,4 SAY "³" ;
	COLOR GR+/B   
@ 12,15 SAY "³" ;
	COLOR GR+/B   
@ 13,4 SAY "ÀÄÄÄÄÄÄÄÄÄÄÙ" ;
	COLOR GR+/B   
@ 12,5 SAY "14: califi" ;
	COLOR GR+/B   
@ 14,4 SAY "ÚÄÄÄÄÄÄÄÄÄÄ¿" ;
	COLOR GR+/B   
@ 15,4 SAY "³" ;
	COLOR GR+/B   
@ 15,15 SAY "³" ;
	COLOR GR+/B   
@ 16,4 SAY "ÀÄÄÄÄÄÄÄÄÄÄÙ" ;
	COLOR GR+/B   
@ 15,5 SAY "15: estudi" ;
	COLOR GR+/B   
@ 17,4 SAY "ÚÄÄÄÄÄÄÄÄÄÄ¿" ;
	COLOR GR+/B   
@ 18,4 SAY "³" ;
	COLOR GR+/B   
@ 18,15 SAY "³" ;
	COLOR GR+/B   
@ 19,4 SAY "ÀÄÄÄÄÄÄÄÄÄÄÙ" ;
	COLOR GR+/B   
@ 18,7 SAY "N§ Reg." ;
	COLOR GR+/B   
@ 21,7 SAY "<  |   >   <       >   <       >   <   |  >   <  Salir >" ;
	COLOR GR+/B   
@ 0,36 SAY "LASER.SCX" ;
	COLOR GR+/W   

ACTIVATE WINDOW laser

hide window menusys
hide window marque1
activate screen
do apause
do effect2 with 5,12,"ÍÍ Texto normal","",""
do effect2 with 6,26,"ÍÍ Campos de la tabla","",""
do effect2 with 13,17,"ÍÍ Men£s emergentes","",""
do effect2 with 14,2,"Casilla de verificaci¢n ÍÍ","",""
do effect2 with 8,23,"µrea de edici¢n ÍÍ","para el campo","Comentarios"
do effect2 with 22,28,"ÍÍ Botones de comando ÍÍ","",""

release window laser
do effect2 with 10,31," El Generador de  ",;
					  " pantallas genera ",;
					  " programas FoxPro "
activate window marque1
clear
@ 0,1 say "       El Generador de pantallas genera programas FoxPro"      
activate screen
hide window botmess
type laserc.prg
do apause
clear
show window botmess
hide window marque1
do effect2 with 10,31," Este programa  ",;
					  " FoxPro produce ",;
					  " una pantalla   "

DEFINE WINDOW laser ;
	FROM INT((SROW()-22)/2),INT((SCOL()-75)/2) ;
	TO INT((SROW()-22)/2)+21,INT((SCOL()-75)/2)+74 ;
	TITLE " Biblioteca de Discos L ser " ;
	FLOAT ;
	CLOSE ;
	SHADOW ;
	MINIMIZE ;
	COLOR SCHEME 1

*
*	Initialize the arrays
*

select 	distinct studio;
		order by studio;
		from laser;
		into arra studs
		
select 	distinct rating;
		order by rating;
		from laser;
		into arra rats

*       ÖÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ·
*       º                                                         º
*       º                   LASER Screen Layout                   º
*       º                                                         º 
*       ÓÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ½
*    
select 0
ACTIVATE WINDOW laser NOSHOW
@ 1,2 SAY "T¡tulo"
@ 3,2 SAY "Precio"
@ 9,15 SAY "Calificaci¢n"
@ 4,2 SAY "F_compra"
@ 5,24 SAY "Duraci¢n"
@ 4,24 SAY "Caras"
@ 6,24 SAY "A¤o"
@ 3,43 SAY "Comentarios"
@ 2,2 SAY "N§Cat logo"
@ 5,2 SAY "Calidad"
@ 6,2 SAY "Cr¡tica"
@ 15,15 SAY "Orden"
@ 1,58 SAY "N§ Reg."
@ 12,15 SAY "Estudio"
@ 1,43 SAY "Borrado:"
@ 1,67 SAY recno() ;
	SIZE 1,4 ;
	PICTURE "9,999"
@ 1,52 SAY iif(DELETED(),'Yes','No ') ;
	SIZE 1,4
@ 18,5 GET action ;
	PICTURE "@*HN |;;;|;Salir" ;
	SIZE 1,10,3 ;
	DEFAULT 3 
@ 1,13 GET laser.title ;
	SIZE 1,28  ;
	DEFAULT " "
@ 2,13 GET laser.catno ;
	SIZE 1,10  ;
	DEFAULT " "
@ 3,13 GET laser.price ;
	SIZE 1,6  ;
	DEFAULT 0 ;
	PICTURE "999.99"
@ 4,13 GET laser.acquired ;
	SIZE 1,8  ;
	DEFAULT {  /  /  }
@ 5,13 GET laser.xquality ;
	SIZE 1,2  ;
	DEFAULT 0
@ 6,13 GET laser.critics ;
	SIZE 1,1  ;
	DEFAULT 0
@ 4,34 GET laser.sides ;
	SIZE 1,2  ;
	DEFAULT 0
@ 5,34 GET laser.duration ;
	SIZE 1,3  ;
	DEFAULT 0
@ 6,34 GET laser.year ;
	SIZE 1,4  ;
	DEFAULT 0
@ 4,43 EDIT laser.descript ;
	SIZE 5,29,0 ;
	DEFAULT " " ;
	SCROLL
@ 8,2 GET rating ;
	PICTURE "@^" ;
	FROM rats ;
	SIZE 3,12 ;
	DEFAULT 1 ;
	COLOR SCHEME 1, 2
@ 11,2 GET studio ;
	PICTURE "@^" ;
	FROM studs ;
	SIZE 3,12 ;
	DEFAULT 1 ;
	COLOR SCHEME 1, 2
@ 14,2 GET ord ;
	PICTURE "@^ N§ Reg.;T¡tulo;N§ Cat logo;A¤o;Calidad;Cr¡tica" ;
	SIZE 3,12 ;
	DEFAULT "N§ Reg."	 ;
	COLOR SCHEME 1, 2
@ 10,28 GET laser.xdigital ;
	PICTURE "@*C Copia digital" ;
	SIZE 1,20 ;
	DEFAULT 0
@ 11,28 GET laser.sdigital ;
	PICTURE "@*C Audio digital" ;
	SIZE 1,17 ;
	DEFAULT 0
@ 12,28 GET laser.stereo ;
	PICTURE "@*C Est‚reo" ;
	SIZE 1,10 ;
	DEFAULT 0
@ 13,28 GET laser.surround ;
	PICTURE "@*C Sonido envolvente" ;
	SIZE 1,18 ;
	DEFAULT 0
@ 14,28 GET laser.cx ;
	PICTURE "@*C Sistema CX" ;
	SIZE 1,14 ;
	DEFAULT 0
@ 15,28 GET laser.closecap ;
	PICTURE "@*C Codificada" ;
	SIZE 1,20 ;
	DEFAULT 0
@ 16,28 GET laser.letterbox ;
	PICTURE "@*C Sistema LB" ;
	SIZE 1,15 ;
	DEFAULT 0
@ 10,50 GET laser.cav ;
	PICTURE "@*C Formato CAV" ;
	SIZE 1,14 ;
	DEFAULT 0
@ 11,50 GET laser.blk_wht ;
	PICTURE "@*C Blanco y negro" ;
	SIZE 1,19 ;
	DEFAULT 0
@ 12,50 GET laser.subtitled ;
	PICTURE "@*C Subtitulada" ;
	SIZE 1,13 ;
	DEFAULT 0
@ 13,50 GET laser.dubbed ;
	PICTURE "@*C Doblada" ;
	SIZE 1,10 ;
	DEFAULT 0
@ 14,50 GET laser.silent ;
	PICTURE "@*C Muda" ;
	SIZE 1,10 ;
	DEFAULT 0
@ 15,50 GET laser.commentary ;
	PICTURE "@*C Comentarios" ;
	SIZE 1,14 ;
	DEFAULT 0
@ 16,50 GET laser.supplement ;
	PICTURE "@*C Suplementos" ;
	SIZE 1,15 ;
	DEFAULT 0

ACTIVATE WINDOW laser


do apause
close databases
release window laser

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
if wexist("laser")
	release window laser
endif
for cnt = 1 to 24
	if wexist("letter"+alltrim(str(cnt)))
		release window ("letter"+alltrim(str(cnt)))
	endif
endfor
for cnt = 1 to 3
	if wexist ("ef2win"+alltrim(str(cnt)))
		release window ("ef2win"+alltrim(str(cnt)))
	endif
endfor
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
		do inpause with 2
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
		do inpause with 2
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
