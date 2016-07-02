**** PROGRAMA: MENUPRIN.PRG
CLEAR
@08,30 SAY "MENU PRINCIPAL"
@10,30 PROMPT "I N C L U S I O N"
@12,30 PROMPT "A L T E R A C I O N"
@14,30 PROMPT "C O N S U L T A"
@16,30 PROMPT "F I N"
MENU TO op
DO CASE
   CASE op = 1
        DO inc
   CASE op = 2
        DO alt
   CASE op = 3
        DO cons
   CASE op = 4
        CLEAR
        CLOSE ALL
        RETURN
ENDCASE