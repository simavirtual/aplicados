**** PROGRAMA EJEMPLO1.PRG
valor = 30
qtd = 30
articulo = " disquetes "
tot = qtd * valor
? "El valor total de "+STR(qtd,3)+articulo+" es"+STR(tot)

**** PROGRAMA: EJEMPLO2.PRG
CLEAR
SET DATE BRITISH
INPUT "DIGITE  : NOMBRE.............: " TO nome
INPUT "          SALARIO............: " TO sal
INPUT "          CASADO.............: " TO estciv
INPUT "          FECHA DE NACIMIENTO: " TO nasc
situacao = IIF(estciv,"CASADO","SOLTERO")
INKEY(0)
CLEAR
? nome+" NACIDO EL "+DTOC(nasc)
? "GANA"+STR(sal,10,2)
? "Y SU ESTADO CIVIL ES "+situacao

**** PROGRAMA: EJEMPLO5.PRG
** Demostracion de RETURN TO MASTER

CLEAR
c = 1
DO WHILE .T.
   BEGIN SEQUENCE
         WAIT "Estamos en el programa principal, presione algo"
         DO segundo
   ENDSEQUENCE
   ? c          // El valor 5 indica que el control volvio del segundo
		// programa mientras 1 indica que volvio directamente
                // al tercero
ENDDO

PROCEDURE segundo
WAIT "Estamos ahora en el programa principal, presione algo"
DO tercero
c = 5
RETURN

PROCEDURE tercero
? "Estamos ahora en el programa principal"
? "Al presionar <Esc> el control vuelve al primer programa"
x = INKEY(0)
IF x = 27
   x = 10
   BREAK        // Vuelve al primer programa
ENDIF
RETURN          // Vuelve al segundo programa