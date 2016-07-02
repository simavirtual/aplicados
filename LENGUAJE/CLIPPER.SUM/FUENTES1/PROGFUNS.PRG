*  NOMBRE DEL ARCHIVO: PROGFUNS.PRG
*  POR: JOSE ANTONIO RAMALHO
*  NOTA: CAIXA POSTAL 62.574 CEP 01295 SAO PAULO
*  FECHA: 12/16/90
*  DESC:
*  LLAMADO POR:
*  ARCHIVOS DE DATOS:
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
      @14,10 SAY "CARGO....: " GET mcar VALID pesquisa("cargos",mcar)
      @16,10 SAY "SECCION..: " GET mset VALID pesquisa("setores",mset)
      READ
   ENDIF
   *** RESTO DEL PROGRAMA DE INCLUSION
   ***
ENDDO
CLEAR


FUNCTION pesquisa(arquivo,chave)
arqatual = DBF()
SELECT &arquivo
SEEK chave
IF EOF()
   @23,10 SAY "CONTENIDO INVALIDO. NO SE ENCUENTRA"
   INKEY(2)
   @23,10 SAY SPACE(60)
   SELECT &arqatual
   RETURN(.F.)
ENDIF
SELECT @arqatual
RETURN(.T.)