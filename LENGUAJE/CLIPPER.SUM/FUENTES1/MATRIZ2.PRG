**** PROGRAMA: MATRIZ2.PRG

centratexto({"Estimado usuario: ha cometido un",;
             "error deber¡a mirar con atenci¢n qu‚",;
             "c¢digos se permiten para este tipo de",;
             "producto."})

centratexto({})

FUNCTION centratexto(m)
LOCAL qtd := maior := 0
AADD(m,"")
AADD(m,"Presione algo para continuar..")
qtd = LEN(m)

IF qtd > 22
   @23,10 SAY "Pueden exhibirse un maximo de 22 lineas"
   INKEY(2)
   RETURN(.F.)
ENDIF
SET CURSOR OFF
FOR i = 1 TO qtd
    maior = MAX(maior,LEN(m[i]))
NEXT
l1 = (24 - qtd) / 2
c1 = (80 - maior) / 2

corantig = SETCOLOR()
SETCOLOR("w+/r")
telaant = SAVESCREEN(l1-1,c1-1,l1+qtd+1,c1+maior)
@l1-1,c1-1 CLEAR TO l1+qtd+1,c1+maior
@l1-1,c1-1 TO l1+qtd+1,c1+maior
FOR i = 1 TO qtd
    @l1+(i-1),c1 SAY m[i]
NEXT i
INKEY(0)
RESTSCREEN(l1-1,c1-1,l1+qtd+1,c1+maior,telaant)
SET CURSOR ON
SETCOLOR(corantig)
RETURN(.T.)