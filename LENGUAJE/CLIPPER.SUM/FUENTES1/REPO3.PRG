**** PROGRAMA: REPO3.PRG
CLEAR
SELE B
IF .NOT. FILE("indcodca.ntx")
   USE cargos
   INDEX ON codcar TO indcodca
 ELSE
   USE cargos INDEX indcodca
ENDIF

SELE A

IF .NOT. FILE("indset.ntx")
   USE func
   INDEX ON codset TO indset
ELSE
   USE func INDEX indset
ENDIF

SET RELATION TO codcar INTO cargos

REPORT FORM func2 TO PRINT

CLOSE ALL