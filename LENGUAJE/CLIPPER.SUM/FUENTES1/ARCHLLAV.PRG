**** ARCHIVO: ARCHLLAV.PRG
CLEAR
USE func
INDEX ON codset+codcar TO setcar
secao = "A"
funcao = "4"
SEEK secao+funcao
DISPLAY nomefunc, codcar, codset, salario
INKEY(0)
? REPL("-",70)
USE func INDEX indsetno
llave = "B"
SEEK llave
IF FOUND()
   DO WHILE .NOT. EOF()
      IF llave = codset
	 ? nomefunc, codcar, codset
	 SKIP
      ELSE
	 EXIT
      ENDIF
   ENDDO
ENDIF
?
? "Fin de la busqueda"