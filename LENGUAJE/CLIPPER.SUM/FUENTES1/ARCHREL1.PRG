**** ARCHIVO: ARCHREL1.PRG
CLEAR
USE func
USE cargos  NEW
INDEX ON codcar TO indcodca
USE setores NEW
INDEX ON codset TO indcodse
SELECT func
l = 1; c = 1

DO WHILE .NOT. EOF()
   @l,c   SAY (STR(RECNO(),3))
   @l,c+5 SAY LEFT(nomefunc,20)
   clave1 = codcar
   clave2 = codset
   SELE cargos
   SEEK clave1
   IF FOUND()
      @l,c+30 SAY (STR(RECNO(),3))
      @l,c+35 SAY codcar
      @l,c+40 SAY (LEFT(nomecar,10))
   ELSE
      @l,c+40 SAY "NO ENCONTRADO"
   ENDIF
   SELECT setores
   SEEK clave2
   IF FOUND()
      @l,c+55 SAY (STR(RECNO(),3))
      @l,c+60 SAY codset
      @l,c+64 SAY nomeset
   ELSE
      @l,c+60 SAY "NO ENCONTRADO"
   ENDIF
   SELECT func
   l++
   SKIP
ENDDO
INKEY(0)