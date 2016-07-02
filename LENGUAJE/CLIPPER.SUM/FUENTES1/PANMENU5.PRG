**** PROGRAMA PANMENU5.PRG
LOCAL l := 8, c := 30 , opc := 6       // Usadas para el MENU
empresa = "MEGATRON ASESORIA Y ENTRENAMIENTO"
sistema = "CUENTAS POR COBRAR"
programa = "MENU PRINCIPAL"

SET WRAP ON
SET MESSAGE TO 23 CENTER
SET SCORE OFF
SET DATE BRIT
CLEAR

DO WHILE .T.
   @ 0, 0 TO  3,39 DOUBLE
   @ 0,40 TO  3,79 DOUBLE
   @ 4, 0 TO 21,79
   @22, 0 TO 24,79 DOUBLE
   @ 1, 1 SAY empresa
   @ 1,41 SAY sistema
   @ 1,73 SAY LEFT(TIME(),5)
   @ 2,41 SAY programa
   @ 2,70 SAY DATE()
   @ 23,1 SAY "MENSAJE:"

   *** MENU

   @ l  ,c PROMPT "1. INCLUSION" MESSAGE "INCLUSION DE TITULOS"
   @ l+2,c PROMPT "2. ALTERACION" MESSAGE "ALTERACION DE TITULOS"
   @ l+4,c PROMPT "3. CONSULTA" MESSAGE "CONSULTA DE SALDOS"
   @ l+6,c PROMPT "4. EXCLUSION" MESSAGE "ELIMINACION DE TITULOS"
   @ l+8,c PROMPT "5. REPORTES" MESSAGE "ACCIONA MENU DE REPORTES"
   @l+10,c PROMPT "6. SALIR DEL SISTEMA";
           MESSAGE "SALE AL SISTEMA OPERACIONAL"
   MENU TO opc

   DO CASE
      CASE opc = 1
           *DO rotinc
      CASE opc = 2
           *DO rotalt
      CASE opc = 3
           DO rotcon
      CASE opc = 4
           *DO rotexc
      CASE opc = 5
           DO rotrel
      CASE opc = 6
           CLEAR
           QUIT
      OTHERWISE
	   @23,10 SAY "OPCION INVALIDA..."
           INKEY(2)
   ENDCASE
ENDDO

PROCEDURE rotrel
mensagem = SAVESCREEN(12,20,15,60)
@12,20 CLEAR TO 15,60
@12,20,15,60 BOX CHR(176)
@13,22 SAY "ESTA RUTINA NO ESTA DISPONIBLE AUN "
@14,22 SAY "CONTACTE EL CPD PARA MAYORES INFORMES"
INKEY(3)
RESTSCREEN(12,20,15,60,mensagem)

PROCEDURE rotcon
LOCAL l := 11, c := 6
SAVE SCREEN
USE func
@ 5,1,20,78 BOX REPL(CHR(176),9)
@10,5,17,76 BOX REPL(" ",9)
@10,5 TO 17,76 DOUBLE

DO WHILE .NOT. EOF()
   @l,c    SAY codfunc
   @l,c+7  SAY nomefunc
   @l,c+43 SAY salario PICT "@E999,999.99"
   @l,c+55 SAY dataent PICT "@E"
   l++
   IF l > 16
      @ 17,18 SAY " Presione <Enter> para ver el proximo registro "
      tecla = INKEY(0)
      SCROLL(11,06,16,75,1)
      l = 16
   ENDIF
   SKIP
ENDDO

@17,17 SAY "    Presione una tecla para volver al menu...    "
INKEY(0)
RESTORE SCREEN