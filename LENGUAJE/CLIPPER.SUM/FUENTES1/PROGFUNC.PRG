*  NOMBRE DEL ARCHIVO: PROGFUNC.PRG
*  POR: JOSE ANTONIO RAMALHO
*  NOTA: CAIXA POSTAL 62.574 CEP 01295 SAO PAULO
*  FECHA: 12/16/90
*  DESC:
*  LLAMADO POR:
*  ARCHIVOS DE DATOS:
ALTD(1)
USE func NEW
INDEX ON codfunc TO indcod
USE cargos NEW
INDEX ON codcar TO indcar
USE setores NEW
INDEX ON codset TO indset
SELECT 1
DO WHILE .T.
   CLEAR
   mcod = SPACE(3)
   mnome = SPACE(30)
   mset := mcar := SPACE(1)
   @10,10 SAY "CODIGO...: " GET mcod PICTURE "@N!"
   READ
   IF mcod = "FIN"
      EXIT
   ENDIF
   SEEK mcod
   IF EOF()
      @12,10 SAY "NOMBRE...: " GET mnome
      @14,10 SAY "CARGO....: " GET mcar VALID cargos->(pesquisa(mcar))
      @16,10 SAY "SECCION..: " GET mset VALID setores->(pesquisa(mset))
      READ
   ENDIF
   ** Resto del programa de INCLUSION
   **
ENDDO
CLEAR


FUNCTION pesquisa(chave)
SEEK chave
IF EOF()
   @23,10 SAY "CONTENIDO INVALIDO. NO SE ENCUENTRA"
   INKEY(2)
   @23,10 SAY SPACE(60)
   RETURN(.F.)
ENDIF
RETURN(.T.)