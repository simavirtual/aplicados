**** PROGRAMA PANMENU3.PRG
LOCAL l := 8; c := 30; opc = 6        // Utilizadas para el MENU

empresa = "MEGATRON ASESORIA Y ENTRENAMIENTO"
sistema = "CUENTAS POR COBRAR"
programa = "MENU PRINCIPAL"
SET MESSAGE TO 23
SET WRAP ON
SET SCORE OFF
SET DATE BRIT
CLEAR

DO WHILE .T.
   @ 0, 0 TO 3,39 DOUBLE
   @ 0,40 TO 3,79 DOUBLE
   @ 4, 0 TO 21,79
   @22, 0 TO 24,79 DOUBLE
   @ 1, 1 SAY empresa
   @ 1,41 SAY sistema
   @ 1,73 SAY LEFT(TIME(),5)
   @ 2,41 SAY programa
   @ 2,70 SAY DATE()
   @23, 1 SAY "MENSAJE:"

   *** MENU

   @ l  ,c PROMPT "1. INCLUSION" MESSAGE "INCLUSION DE TITULOS"
   @ l+2,c PROMPT "2. ALTERACION";
           MESSAGE "MODIFICACION DE TITULOS"
   @ l+4,c PROMPT "3. CONSULTA" MESSAGE "CONSULTA DE SALDOS"
   @ l+6,c PROMPT "4. EXCLUSION" MESSAGE "ELIMINACION DE TITULOS"
   @ l+8,c PROMPT "5. REPORTES";
           MESSAGE "ACCIONA MENU DE REPORTES"
   @l+10,c PROMPT "6. SALIR DEL SISTEMA";
           MESSAGE "VUELVE AL SISTEMA OPERACIONAL"
   MENU TO opc

   DO CASE
      CASE opc = 1
           *DO rotinc
      CASE opc = 2
           *DO rotalt
      CASE opc = 3
           *DO rotcon
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
           @23,10 SAY SPACE(60)
   ENDCASE
ENDDO

PROCEDURE rotrel
mensagem = SAVESCREEN(12,20,15,60)
@12,20 CLEAR TO 16,60
@12,20,15,60 BOX CHR(176)
@13,22 SAY "ESA RUTINA NO ESTA DISPONIBLE AUN"
@14,22 SAY "CONTACTE EL CPD PARA MAYORES INFORMES"
INKEY(3)
RESTSCREEN(12,20,15,60,mensagem)