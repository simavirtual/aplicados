**** ARCHIVO: ARCHSETD.PRG
** FILTRADO DE REGISTROS MARCADOS PARA ELIMINACION
CLEAR
USE func           // Asumimos que se eliminaron los registros
                   // del ultimo ejemplo.
SET DELETED ON
GOTO TOP
DO WHILE .NOT. EOF()
   ? RECNO(), codfunc, PADL(nomefunc,30), salario, DELETED()
   SKIP
ENDDO
INKEY(0)
CLEAR