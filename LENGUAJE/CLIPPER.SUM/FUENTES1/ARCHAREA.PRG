**** ARCHIVO: ARCHAREA.PRG
CLEAR
USE func
USE cargos NEW
USE setores NEW
SELE func
l = 1; c = 1
DO WHILE .NOT. EOF()
   @l,c    SAY (STR(RECNO(),3))
   @l,c+05 SAY LEFT(nomefunc,20)
   @l,c+30 SAY B->(STR(RECNO(),3))
   @l,c+35 SAY B->codcar
   @l,c+40 SAY B->(LEFT(nomecar,10))
   @l,c+55 SAY C->(STR(RECNO(),3))
   @l,c+60 SAY C->nomeset 
   l++
   SKIP 
ENDDO