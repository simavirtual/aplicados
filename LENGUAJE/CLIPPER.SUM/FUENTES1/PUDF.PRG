**** PROGRAMA: PUDF.PRG

** PARTE 1
CLEAR
a = {" INCLUSION "," MODIFICACION "," CONSULTA"," FIN"}

@01,01 TO 06,16 DOUBLE          // Define el borde para el MENU

DO WHILE .T.
   resp = ACHOICE(2,2,5,15,a)
   DO CASE
      CASE resp = 1
	   @01,30 SAY "Se selecciono INCLUSION"
	   INKEY(2)
	   @01,30 SAY SPACE(40)
      CASE resp = 2
	   @01,30 SAY "Se selecciono MODIFICACION"
	   INKEY(2)
	   @01,30 SAY SPACE(40)
      CASE resp = 3
	   @01,30 SAY "Se selecciono CONSULTA"
	   INKEY(2)
	   @01,30 SAY SPACE(40)
      CASE resp = 4
	   @01,30 SAY "Se selecciono FIN"
	   INKEY(2)
	   @01,30 SAY SPACE(40)
      CASE resp = 0
	   @01,30 SAY "Se ha presionado <Esc> o una tecla de excepcion"
	   INKEY(2)
	   EXIT
   ENDCASE
ENDDO


** PARTE 2
INKEY(0)
SET SCORE OFF
DO WHILE .T.
   CLEAR
   @00,00 TO 04,76 DOUBLE
   tipo = SPACE(20)
   atributo = SPACE(1)
   @ 1,1 SAY "Digite el directorio/Tipo de archivo a listar: " GET tipo
   READ
   IF UPPER(tipo) = "FIN"
      EXIT
   ENDIF
   @ 2,1 SAY "Archivos: (N)ormales, (H)idden, (D)irectories, (S)ystem, (V)olume";
   GET atributo PICT "!" VALID atributo $ "NHDSV"
   READ

   IF atributo = "S"
      m1 = DIRECTORY("&tipo")
   ELSE
      m1 = DIRECTORY("&tipo","&atributo")
   ENDIF
   qtd = LEN(m1)
   IF qtd > 19
      fundo = 19
   ENDIF
   @03,01 SAY "Total de archivos: "+STR(qtd,4)
   m2 = {}                      // Crea una matriz que sera usada por ACHOICE()

   FOR i = 1 TO qtd
       AADD(m2,PADR(m1[i,1],15)+STR(m1[i,2],5)+" "+DTOC(m1[i,3])+;
       " "+m1[i,4]+" "+m1[i,5])
   NEXT
   @04,00 TO fundo+5,76 DOUBLE
   ACHOICE(5,1,fundo+4,75,m2)
ENDDO