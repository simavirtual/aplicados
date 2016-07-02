**** PROGRAMA PANTGRAB.PRG
LOCAL l := 8; c := 30; opc = 6        // Utilizadas en el MENU
empresa = "MEGATRON ASESORIA Y ENTRENAMIENTO"
sistema = "CUENTAS POR COBRAR"
programa = "INCLUSION"
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
   @23, 1 SAY "MENSAJE:"

   *** MENU

   @l   ,c  SAY "1. INCLUSION"
   @l+2 ,c  SAY "2. ALTERACION"
   @l+4 ,c  SAY "3. CONSULTA"
   @l+6 ,c  SAY "4. EXCLUSION"
   @l+8 ,c  SAY "5. REPORTES"
   @l+10,c  SAY "6. SALIR DEL SISTEMA"
   @l+12,c  SAY "DIGITE SU OPCION ->" GET opc PICT "9"
   READ
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
SAVE SCREEN TO mensagem
@12,20 CLEAR TO 15,60
@12,20,15,60 BOX CHR(176)
@13,22 SAY "ESTA RUTINA NO ESTA DISPONIBLE AUN"
@14,22 SAY "CONTACTE EL CPD PARA MAYORES INFORMES"
INKEY(3)
RESTORE SCREEN FROM mensagem