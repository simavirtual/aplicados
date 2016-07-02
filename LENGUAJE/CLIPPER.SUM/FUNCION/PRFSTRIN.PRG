* FILE NAME: PRFSTRING.PRG
* BY: 
* NOTICE: 
* DATE: 7/18/91                                             
* DESC:
* CALLED BY:
* DATA FILES:
CLEAR                                                              
LOGO("MEGATRON",1,10)                                              
LOGO("ASSESSORIA",7,04)                                            
LOGO("      E   ",13,04)                                           
LOGO("TREINAMENTO",19,02)                                          
INKEY(0)                                                           
CLEAR                                                              
LOGO("ABCDEFGHIJK",0,1)                                            
LOGO("LMNOPQRSTUV",6,1)                                            
LOGO("XWYZ",12,1)                                                  
LOGO("1234567890",19,1)                                            
INKEY(0)                                                           
                                                                   
                                                                   
CLEAR                                                              
MAYUSC(10,10,"BARBARA BACH")                                       
?                                                                  
? MAYUSC(,,"NILSA COURA MENDES")                                   
? MAYUSC(,,"MEGATRON ASSESSORIA E TREINAMENTO")                    
? MAYUSC(,,"MARINA DA GLORIA DOS SANTOS E SILVA")                  
INKEY(0)
                                                     
CLEAR                                                              
BLOQUE={|| QOUT(MAYUSC(,,NOMEFUNC))}                               
USE FUNC                                                           
DBEVAL(BLOQUE)                                                     
INKEY(0)                                                           
                                                                   
                                                                   
CLEAR                                                              
PRIVATE X:=ARRAY(7) , M1:={1,2,3}                                  
B1:={|ELE| QOUT(PADL(ELE,40),VALTYPE(ELE))}                        
USE FUNC                                                           
GOTO 2                                                             
                                                                   
X[1]=GENERACAR(NOMEFUNC)                                           
X[2]=GENERACAR(SALARIO)                                            
X[3]=GENERACAR(DATAENT)                                            
X[4]=GENERACAR(GREMIO)                                             
X[5]=GENERACAR(COMENT)                                             
X[6]=GENERACAR(M1)                                                 
X[7]=GENERACAR(B1)                                                 
                                                                   
AEVAL(X,B1)                                                        
                                                                   
USE                                                                
INKEY(0)                                                           
                                                                   
                                                                   
CLEAR                                                              
EXPANDE(1,1,"JOSE ANTONIO RAMALHO")                                
CENTRACAD(10,10,EXPANDE(,,"EDITORA MAKRON BOOKS"),60,"N/W")        
                                                                   
INKEY(0)                                                           
CLEAR
DIAGASCD("BENEFICIOS EN EL PERIODO:>",20,10,"N/W")                 
INKEY(0)
DIAGASCD("FELIZ",10,25)                                            
DIAGASCD("NAVIDAD",10,28)                                          
DIAGASCD("Y UN ",10,31)                                            
DIAGASCD("PROSPERO",10,34,"R/W")                                   
DIAGASCD("AЅO",10,37)                                              
DIAGASCD("NUEVO",10,40)                                            
INKEY(0)                                                           
                                                                   
CLEAR                                                              
DIAGDESC("PERDIDAS EN EL PERIODO: >",02,01)                        
DIAGDESC("FELIZ",10,25)                                            
DIAGDESC("NAVIDAD",10,28)                                          
DIAGDESC("Y UN ",10,31)

DIAGDESC("PROSPERO",10,34,"R/W")                                   
DIAGDESC("AЅO",10,37)                                              
DIAGDESC("NUEVO",10,40)                                            
INKEY(0)                                                           
                                                                   
CLEAR                                                              
MUEVEIZQ(01,01,"MEGATRON ASSESSORIA E TREINAMENTO ")               
MUEVEIZQ(07,20)                                                    
MUEVEIZQ(,,"OI GENTE ..")                                          
MUEVEDER(01,01,"MEGATRON ASSESSORIA E TREINAMENTO ")               
MUEVEDER(07,20)                                                    
MUEVEDER(,,"OI GENTE ..")                                          
                                                                   
                                                                   
                                                                   
CLEAR
CENTRACAD(01,10,"JOSE ANTONIO",30,"R/W")                           
CENTRACAD(02,00,"MAKRON BOOKS")                                    
CENTRACAD(04,40,"CENTRALIZACION",40,"N/W")                         
CENTRACAD(06,00,"MEGATRON",20)                                     
@ 10,10 TO 13,33                                                   
CENTRACAD(10,12,"OPCIONES",20,"N/W")                               
INKEY(0)                                                           
                                                                   
CLEAR                                                              
TEXTO="MAKRON BOOKS-MEGATRON"                                      
@ 01,01 TO LEN(TEXTO)+2,03                                         
@ 01,77 TO LEN(TEXTO)+2,79                                         
COLUMNA(TEXTO,02,02)                                               
COLUMNA(TEXTO,02,78)                                               

INKEY(0)                                                           
CLEAR                                                              
COLUMNA("MENU PRINCIPAL",01,05)                                    
INKEY(0)                                                           
COLUMNA("FELIZ ANO NOVO",12,02)                                    
INKEY(0)                                                           
COLUMNA("FELIZ",10,25)                                             
COLUMNA("NAVIDAD",10,27)                                           
COLUMNA("Y UN" ,10,29)                                             
COLUMNA("PROSPERO",10,31)                                          
COLUMNA("AЅO NUEVO",10,33)                                         
INKEY(0)                                                           
                                                                   
CLEAR                                                              
BOXTEXTO(10,10,23,27,"CANTIDADES A RECIBIR")                       
INKEY(0)                                                           
BOXTEXTO(0,0,24,79,"MAKRON BOOKS")                                 
INKEY(0)

BOXTEXTO(05,40,20,75)                                              
INKEY(0)                                                           
                                                                   
CLEAR                                                              
FOR I = 0 TO 24                                                    
   @ I,39 SAY "|"                                                    
NEXT                                                               
texto="Menu principal"                                             
@ 1,centra(texto)    SAY TEXTO                                     
@ 3,centra(texto,40) SAY TEXTO                                     
TEXTO="Sistema de Cantidades a recibir"                            
@ 5,centra(texto) SAY TEXTO                                        
TEXTO="Megatron Assessoria e Treinamento Ltda."                    
@ 7,centra(TEXTO) SAY TEXTO                                        
inkey(0)                                                           
                                                                   
*  FILE NAME: FUNCSTR.PRG                                          
*  BY: Jose Antonio Ramalho                                        
*  NOTICE: Megatron  Assessoria e Treinamento ltda.                
*  DATE: 01/04/91                                                  
*  DESC: BIBLIOTECA DE FUNCIONES DE CADENA DE CARACTERES           
********************************************************           
FUNCTION EXPANDE(LIN,COL,texto)                                    
local textonuevo:=" "                                              
FOR i = 1 TO LEN(texto)                                            
   textonuevo+=SUBSTR(texto,i,1)+space(1)                          
NEXT                                                               
IF LIN=NIL .AND. COL=NIL                                           
   RETURN (LTRIM(textonuevo))                                        
ELSE                                                               
   @ LIN,COL SAY LTRIM(TEXTONUEVO)                                   
   RETURN NIL                                                        
ENDIF                                                              
                                                                   
                                                                   
********************************************************           
FUNCTION MAYUSC(LIN,COL,texto)                                     
local excep:={" Do "," Dos "," Da "," Das "," De ", " E "," Del "} 
nuevotexto=space(1)+LOWER(texto)                                   
FIN:=LEN(TEXTO)                                                    
FOR I = 1 TO FIN                                                   
   IF SUBSTR(nuevotexto,i,1)=" "                                   
      nuevotexto=  STUFF(nuevotexto,i+1,1,;                          
         UPPER(SUBSTR(nuevotexto,i+1,1)))                               
   ENDIF                                                           
NEXT                                                               
TAMANHO=LEN(EXCEP)                                                 
FOR i=1 TO TAMANHO

   IF EXCEP[i] $ nuevotexto                                        
      nuevotexto=STUFF(nuevotexto,AT(EXCEP[i],nuevotexto),;        
      LEN(EXCEP[i]),LOWER(EXCEP[i]))                               
   ENDIF                                                           
NEXT                                                               
IF LIN=NIL .OR. COL=NIL                                            
   RETURN (LTRIM(nuevotexto))                                       
ELSE                                                              
   @ LIN,COL SAY LTRIM(NUEVOTEXTO)                                  
   RETURN NIL                                                       
ENDIF                                                              
                                                                   
************************************************                   
FUNCTION COLUMNA(texto,h_lin,h_col)                                
FIN:=LEN(TEXTO:=TRIM(TEXTO))                                       
IF FIN > (24-h_lin)  // NO CABE EN LA PANTALLA                     
   RETURN (.F.)                                                    
ENDIF                                                              
FOR I = 0 TO FIN-1                                                 
   @ h_lin+I,h_col SAY SUBSTR(texto,I+1,1)                         
NEXT                                                               
RETURN NIL                                                         
                                                                   
************************************************                  
FUNCTION BOXTEXTO(f_lin1,f_col1,f_lin2,f_col2,texto)               
IF PCOUNT()<4                                                      
   RETURN(.F.)                                                       
ENDIF                                                              
IF TEXTO=NIL                                                       
   texto="*"                                                        
ENDIF                                                              
longitud=f_col2-f_col1+1                                           
altura=f_lin2-f_lin1                                               
texto=TRIM(texto)+" "                                              
textobox=REPLICATE(texto,INT(80/LEN(texto)+3))                     
@ f_lin1,f_col1 SAY (LEFT(textobox,longitud))                      
pos=1                                                              
pos2=longitud                                                      
DO WHILE pos <= altura                                             
   @ f_lin1+(pos),f_col1 SAY SUBSTR(textobox,pos+1,1)              
   @ f_lin1+(pos),f_col2 SAY SUBSTR(textobox,pos2+pos,1)           
   pos=pos+1                                                       
ENDDO                                                              
@ f_lin2,f_col1 SAY (SUBSTR(textobox,altura+1,longitud))           
                                                                   
RETURN NIL                                                         
                                                                   
******************************************************

FUNCTION DIAGDESC(texto, LIN,COL,COLOR)                            
TAMANHO:= LEN(texto:=TRIM(texto))                                  
IF TAMANHO > (24-LIN) .OR. TAMANHO > (80-COL)                      
   RETURN (.F.)                                                    
ENDIF                                                              
soma=0                                                             
COLORANTIG=SETCOLOR()                                              
IF COLOR<>NIL                                                      
   NUEVOCOLOR=COLOR                                                  
   SETCOLOR("&NUEVOCOLOR.")                                          
ENDIF                                                              
DO WHILE soma<=TAMANHO                                             
   @ LIN+soma,COL+soma SAY SUBST(texto,soma+1,1)                   
   soma++                                                          
ENDDO                                                              
SETCOLOR("&COLORANTIG.")                                           
RETURN NIL                                                         
                                                                   
*************************************************                  
FUNCTION DIAGASCD(texto, LIN,COL,COLOR)                            
TAMANHO:= LEN(texto:=TRIM(texto))                                  
IF TAMANHO > (LIN) .OR. TAMANHO > (80-COL)                         
   RETURN (.F.)                                                    
ENDIF                                                              
COLORANTIG=SETCOLOR()                                              
IF COLOR<>NIL                                                      
   NUEVOCOLOR=COLOR                                                  
   SETCOLOR("&NUEVOCOLOR.")                                          
ENDIF                                                              
somacol=0                                                          
DO WHILE somacol<=TAMANHO                                          
   @ LIN,COL+somacol SAY SUBST(texto,somacol+1,1)                  
   somacol++                                                       
   LIN-= 1                                                         
ENDDO                                                              
SETCOLOR("&COLORANTIG.")                                           
RETURN NIL                                                         
                                                                   
*************************************************                  
FUNCTION CENTRA                                                    
PARAMETERS texto,long_linea                                        
texto=TRIM(texto)                                                  
IF LONG_LINEA=NIL                                                  
   long_linea=80     && SUPONE LA LONGITUD DE LA PANTALLA          
ENDIF                                                              
RETURN ((long_linea-LEN(texto))/2)                                 
                                                                   
*************************************************

FUNCTION CENTRACAD(LIN,COL,texto,long_string,COLOR)                
texto=TRIM(texto)                                                  
IF LONG_STRING=NIL                                                 
   RETURN(.F.)                                                      
ENDIF                                                              
nuevapos=(long_string-LEN(texto))/2                                
final=SPACE(nuevapos-1)+texto                                      
final=final+SPACE(long_string-LEN(final))                          
IF COLOR<>NIL                                                      
   COLORANTIG=SETCOLOR()                                             
   NUEVOCOLOR=COLOR                                                  
   SETCOLOR("&NUEVOCOLOR.")                                          
   @ LIN,COL SAY FINAL                                               
   SETCOLOR("&COLORANTIG.")                                          
ELSE                                                              
   @ LIN,COL SAY FINAL                                               
ENDIF                                                              
RETURN NIL                                                         
                                                                   
****************************************************               
FUNCTION MUEVEIZQ(LIN1,COL1,TEXTO)                                 
CURSTAT=SETCURSOR()                                                
SETCURSOR(0)                                                       
IF LIN1=NIL                                                        
   LIN1=22                                                           
ENDIF                                                              
IF COL1=NIL                                                        
   COL1=20                                                           
ENDIF                                                              
IF TEXTO=NIL                                                       
   TEXTO="PULSE UNA TECLA PARA CONTINUAR..."                         
ENDIF                                                              
TV=SAVESCREEN(LIN1-1,COL1-1,LIN1+1,COL1+LEN(TEXTO)+1)              
@ LIN1-1,COL1-1 TO LIN1+1,COL1+LEN(TEXTO)+1                        
PARADA=0                                                           
DO WHILE PARADA=0                                                  
   PARADA=INKEY(.1)    && controla la velocidad                       
   @ LIN1,COL1 SAY SUBSTR(TEXTO,1,40)                                 
   TEXTO=SUBSTR(TEXTO,2,40)+SUBSTR(TEXTO,1,1)                       
ENDDO                                                              
RESTSCREEN(LIN1-1,COL1-1,LIN1+1,COL1+LEN(TEXTO)+1,TV)              
SETCURSOR(CURSTAT)                                                 
RETURN NIL                                                         
                                                                   
****************************************************               
FUNCTION MUEVEDER(LIN1,COL1,TEXTO)                                 
CURSTAT=SETCURSOR()                                                
SETCURSOR(0)

IF LIN1=NIL                                                        
   LIN1=22                                                           
ENDIF                                                              
IF COL1=NIL                                                        
   COL1=20                                                           
ENDIF                                                              
IF TEXTO=NIL                                                       
   TEXTO="PULSE UNA TECLA PARA CONTINUAR..."                         
ENDIF                                                              
TAMANHO=LEN(TEXTO)                                                 
TV=SAVESCREEN(LIN1-1,COL1-1,LIN1+1,COL1+TAMANHO+1)                 
@ LIN1-1,COL1-1 TO LIN1+1,COL1+LEN(TEXTO)+1                        
PARADA=0                                                           
DO WHILE PARADA=0                                                  
   PARADA=INKEY(.1)    && controla la velocidad                       
   @ LIN1,COL1 SAY SUBSTR(TEXTO,1,40)                                 
   TEXTO=RIGHT(TEXTO,1)+SUBSTR(TEXTO,1,TAMANHO-1)                   
ENDDO                                                              
RESTSCREEN(LIN1-1,COL1-1,LIN1+1,COL1+TAMANHO+1,TV)                 
SETCURSOR(CURSTAT)
RETURN NIL


***************************************************
FUNCTION GENERACAR (VAR1)       
IF VALTYPE(VAR1)="U"            
   RETURN (.F.)                 
ELSE                            
   TIPO=VALTYPE(VAR1)           
ENDIF                           
DO CASE                         
CASE TIPO="C"                   
   FINAL=VAR1                   
CASE TIPO="D"                   
   FINAL=DTOC(VAR1)             
CASE TIPO="N"                   
   FINAL=STR(VAR1)              
CASE TIPO="L"                   
   FINAL=IIF(VAR1,"Si","No")    
CASE TIPO="M"               
   FINAL=VAR1                
CASE TIPO="A"              
   FINAL="MATRIZ"            
CASE TIPO ="B"              
   FINAL="BLOQUE"
ENDCASE                         
RETURN(FINAL)


**************************************************
FUNCTION LOGO(TEXTO,LIN,COL)
LOCAL L1,L2,L3,L4,L5,G[6,36]

IF LEN(TEXTO) >11                                              
   @ 23,10 SAY "ESTAN PERMITIDOS 11 CARACTERES COMO MAXIMO"    
   INKEY(3)                                                    
   RETURN(.F.)                                                 
ENDIF                                                          
IF LIN=NIL                                                     
   LIN=10                                                      
ENDIF                                                          
IF COL=NIL                                                     
   COL=1                                                       
ENDIF                                                          

G[1,1]="A"                         
G[2,1]="мллллм "           
G[3,1]="л    л "           
G[4,1]="лллллл "           
G[5,1]="л    л "           
G[6,1]="л    л "           
                           
G[1,2]="B"                 
G[2,2]="лллллм "           
G[3,2]="л    л "           
G[4,2]="ллллл  "           
G[5,2]="л    л "           
G[6,2]="лллллп "           
                           
g[1,3]="C"                 
G[2,3]="лллллл "           
G[3,3]="л      "           
G[4,3]="л      "           
G[5,3]="л      "           
G[6,3]="лллллл "           
                           
G[1,4]="D"                 
G[2,4]="лллллм "           
G[3,4]="л    л "           
G[4,4]="л    л "           
G[5,4]="л    л "           
G[6,4]="лллллп "           
                           
G[1,5]="E"                 
G[2,5]="лллллл "           
G[3,5]="л      "           
G[4,5]="ллллл  "
G[5,5]="л      "           
G[6,5]="лллллл "           
                           
G[1,6]="F"                 
G[2,6]="лллллл "           
G[3,6]="л      "           
G[4,6]="ллл    "           
G[5,6]="л      "           
G[6,6]="л      "           
                           
G[1,7]="G"                 
G[2,7]="лллллл "           
G[3,7]="л    п "           
G[4,7]="л  ллл "           
G[5,7]="л    л "           
G[6,7]="лллллл "           
                           
G[1,8]="H"                 
G[2,8]="л    л "           
G[3,8]="л    л "           
G[4,8]="лллллл "           
G[5,8]="л    л "           
G[6,8]="л    л "           
                           
G[1,9]="I"                 
G[2,9]="  ллл  "           
G[3,9]="   л   "           
G[4,9]="   л   "           
G[5,9]="   л   "           
G[6,9]="  ллл  "           
                           
g[1,10]="J"                
G[2,10]="     л "          
G[3,10]="     л "          
G[4,10]="     л "          
G[5,10]="л    л "          
G[6,10]="лллллл "          
                           
G[1,11]="K"                
G[2,11]="л    л "          
G[3,11]="л  мп  "          
G[4,11]="ллл    "          
G[5,11]="л  пм  "          
G[6,11]="л    л "          
                           
G[1,12]="L"                
G[2,12]="л      "          
G[3,12]="л      "
G[4,12]="л      "          
G[5,12]="л    л "          
G[6,12]="лллллл "          
                           
G[1,13]="M"                
G[2,13]="ллнолл "          
G[3,13]="л но л "          
G[4,13]="л но л "          
G[5,13]="л лл л "          
G[6,13]="л    л "          
                           
G[1,14]="N"                
G[2,14]="лн   л "          
G[3,14]="лон  л "          
G[4,14]="л он л "          
G[5,14]="л  онл "          
G[6,14]="л   ол "          
                           
G[1,15]="O"                
G[2,15]="лллллл "          
G[3,15]="л    л "          
G[4,15]="л    л "          
G[5,15]="л    л "          
G[6,15]="лллллл "          
                           
G[1,16]="P"                
G[2,16]="лллллм "          
G[3,16]="л    л "          
G[4,16]="лллллп "          
G[5,16]="л      "          
G[6,16]="л      "          
                           
G[1,17]="Q"                
G[2,17]="лллллл "          
G[3,17]="л    л "          
G[4,17]="л    л "          
G[5,17]="л    л "          
G[6,17]="пппппл "          
                           
G[1,18]="R"                
G[2,18]="лллллм "          
G[3,18]="л    л "          
G[4,18]="лллллп "          
G[5,18]="л  ллм "          
G[6,18]="л    л "          
                           
G[1,19]="S"                
G[2,19]="лллллл "
G[3,19]="л      "          
G[4,19]="лллллл "          
G[5,19]="     л "          
G[6,19]="лллллл "          
                           
G[1,20]="T"                
G[2,20]="лллллл "          
G[3,20]="  лл   "          
G[4,20]="  лл   "          
G[5,20]="  лл   "          
G[6,20]="  лл   "          
                           
G[1,21]="U"                
G[2,21]="л    л "          
G[3,21]="л    л "          
G[4,21]="л    л "          
G[5,21]="л    л "          
G[6,21]="лллллл "          
                           
G[1,22]="V"                
G[2,22]="л    л "          
G[3,22]="л    л "          
G[4,22]="л    л "          
G[5,22]=" л  л  "          
G[6,22]="  он   "          
                           
G[1,23]="X"                
G[2,23]="л    л "          
G[3,23]="он  он "          
G[4,23]="  лл   "          
G[5,23]="он  он "          
G[6,23]="л    л "          
                           
G[1,24]="Y"                
G[2,24]="л    л "          
G[3,24]="л    л "          
G[4,24]=" л  л  "          
G[5,24]="  лл   "          
G[6,24]="  лл   "          
                           
G[1,25]="W"                
G[2,25]="л    л "          
G[3,25]="л лл л "          
G[4,25]="л но л "          
G[5,25]="л но л "          
G[6,25]="ллнолл "          
                           
G[1,26]="Z"
G[2,26]="лллллл "          
G[3,26]="     л "          
G[4,26]="лллллп "          
G[5,26]="л      "          
G[6,26]="лллллл "          
                           
G[1,27]="1"                
G[2,27]="  лл   "          
G[3,27]="   л   "          
G[4,27]="   л   "          
G[5,27]="   л   "          
G[6,27]="  ллл  "          
                           
G[1,28]="2"                
G[2,28]="лллллл "          
G[3,28]="     л "          
G[4,28]="лллллл "          
G[5,28]="л      "          
G[6,28]="лллллл "          
                           
G[1,29]="3"                
G[2,29]="лллллм "          
G[3,29]="     л "          
G[4,29]="ллллл  "          
G[5,29]="     л "          
G[6,29]="лллллп "          
                           
G[1,30]="4"                
G[2,30]="л    л "          
G[3,30]="л    л "          
G[4,30]="лллллл "          
G[5,30]="     л "          
G[6,30]="     л "          
                           
G[1,31]="5"                
G[2,31]="лллллл "          
G[3,31]="л      "          
G[4,31]="лллллл "          
G[5,31]="     л "          
G[6,31]="лллллл "          
                           
G[1,32]="6"                
G[2,32]="лл     "          
G[3,32]="л      "          
G[4,32]="лллллл "          
G[5,32]="л    л "          
G[6,32]="лллллл "          

G[1,33]="7"                
G[2,33]="лллллл "          
G[3,33]="     л "          
G[4,33]="     л "          
G[5,33]="     л "          
G[6,33]="     л "          
                           
G[1,34]="8"                
G[2,34]="лллллл "          
G[3,34]="л    л "          
G[4,34]="лллллл "          
G[5,34]="л    л "          
G[6,34]="лллллл "          
                           
G[1,35]="9"                
G[2,35]="лллллл "          
G[3,35]="л    л "          
G[4,35]="лллллл "          
G[5,35]="     л "          
G[6,35]="    лл "          
                           
G[1,36]="0"                
G[2,36]="лллллл "          
G[3,36]="л  л л "          
G[4,36]="л л  л "          
G[5,36]="лл   л "          
G[6,36]="лллллл "          
                                                      
L1:= L2:= L3:= L4:= L5:="" 
                           
Z=1                        
DO WHILE Z<=LEN(TEXTO)             
   LETRA=UPPER(SUBS(TEXTO,Z,1))          
   IF LETRA=" "                          
       L1=L1+SPACE(5)                     
       L2=L2+SPACE(5)                     
       L3=L3+SPACE(5)                     
       L4=L4+SPACE(5)                     
       L5=L5+SPACE(5)                     
   ELSE                                  
      indice=ASCAN(g[1],letra)           
      IF INDICE<>0                       
         L1+=g[2,INDICE]                 
         L2+=G[3,INDICE]                 
         L3+=G[4,INDICE]                 
         L4+=G[5,INDICE]                 
         L5+=G[6,INDICE]                 
      ENDIF                               

   ENDIF                                 
   Z=Z+1                                 
ENDDO                                    
@ LIN++,COL SAY L1                       
@ LIN++,COL SAY L2                       
@ LIN++,COL SAY L3                       
@ LIN++,COL SAY L4                       
@ LIN++,COL SAY L5                       
RETURN NIL
