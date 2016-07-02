*  NOMBRE DEL ARCHIVO: ACHOICE2.PRG
*  POR: JOSE ANTONIO RAMALHO
*  NOTA: CAIXA POSTAL 62.574 CEP 01295 SAO PAULO
*  FECHA: 12/16/90
*  DESC:
*  LLAMADO POR:
*  ARCHIVOS DE DATOS:
*  PROGRAMA ACHOICE2.PRG
*
** Ejemplo 1 uso de ACHOICE() con ADIR()

DECLARE arq[ADIR("*.DBF")]
ADIR("*.DBF",arq)
IF LEN(arq) = 0
   @23,10 SAY "NO HAY ARCHIVOS DE DATOS EN ESTE DIRECTORIO"
   INKEY(3)
   RETURN
ENDIF

DO WHILE .T.
   CLEAR
   moldura(2,2,10,15,.F.,"Archivo")
   opc = ACHOICE(3,3,9,14,arq)
   IF opc = 0
      EXIT
   ENDIF
   arquivo = arq[opc]
   USE &arquivo
   ** Ejemplo 2 uso de ACHOICE() con AFIELDS()
   c = FCOUNT()
   DECLARE nomes[c], tipo[c], tam[c], dec[c], resumo[c]
   AFIELDS(nomes,tipo,tam,dec)
   FOR i = 1 TO c
       nomes[i] = nomes[i]+REPLICATE(" ",(10-LEN(nomes[i])))
       resumo[i] = nomes[i]+" | " +tipo[i]+"  |"+STR(tam[i],3)+" | "+;
       STR(dec[i],2)
   NEXT

   @12,02 CLEAR TO 22,30
   @12,02 TO 22,30
   @12,06 SAY "NOMBRE"
   @12,15 SAY "TIPO"
   @12,20 SAY "TAM"
   @12,26 SAY "DEC"
   ACHOICE(13,3,21,29,resumo)
   @02,33 CLEAR TO 22,77
ENDDO
CLEAR

FUNCTION moldura
PARAMETERS topo, esq, dir, baixo, tipo, texto
IF PCOUNT() < 6
   @23,10 SAY "NUMERO DE PARAMETROS INVALIDO"
   RETURN(.F.)
ENDIF
IF tipo
   @topo,esq TO dir,baixo DOUBLE
ELSE
   @topo,esq TO dir,baixo
ENDIF
IF LEN(texto) > 0
   tam = baixo - esq
   novapos = (tam-LEN(texto))/2
   @topo,esq+novapos SAY texto
ENDIF
RETURN(.T.)
