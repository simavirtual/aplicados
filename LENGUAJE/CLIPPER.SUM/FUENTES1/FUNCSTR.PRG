*  FILE NAME: FUNCSTR.PRG
*  BY: Jose Antonio Ramalho
*  NOTICE: Megatron  Assessoria e Treinamento ltda.
*  DATE: 01/04/91
*  DESC: BIBLIOTECA DE FUNCOES DE STRING
********************************************************

CLEAR
expande(1,1,"EDITORIAL McGraw-Hill")
centrastr(10,10,expande(,,"Clipper 5.01"),60,"N/W")
INKEY(0)

CLEAR
 ?
 ? minuscula(,,"BRASIL, CHILE Y COLOMBIA")
 ? minuscula(,,"GLORIA DE ROSAS")
 ? minuscula(,,"LOPE DE LA VEGA")
INKEY(0)

CLEAR
columna("MENU PRINCIPAL",01,05)
INKEY(0)

CLEAR
diagdesc("FIN DEL PROGRAMA",02,01)
INKEY(0)

********************************************************
FUNCTION expande(lin,col,texto)
LOCAL textonuevo:=" "
FOR i = 1 TO LEN(texto)
    textonuevo += SUBSTR(texto,i,1) + SPACE(1)
NEXT
IF lin = NIL .AND. col = NIL
   RETURN (LTRIM(textonuevo))
ELSE
   @lin,col SAY LTRIM(textonuevo)
   RETURN NIL
ENDIF

********************************************************
FUNCTION minuscula(lin,col,texto)
LOCAL menos := {" De "," La "," Los "," Y"}
nuevotexto = SPACE(1) + LOWER(texto)
fin := LEN(texto)
FOR i = 1 TO fin
    IF SUBSTR(nuevotexto,i,1)=" "
       nuevotexto=  STUFF(nuevotexto,i+1,1,;
       UPPER(SUBSTR(nuevotexto,i+1,1)))
    ENDIF
NEXT
tamano = LEN(menos)
FOR i = 1 TO tamano
    IF menos[i] $ nuevotexto
       nuevotexto = STUFF(nuevotexto,AT(menos[i],nuevotexto),;
       LEN(menos[i]),LOWER(menos[i]))
    ENDIF
NEXT
IF lin = NIL .OR. col = NIL
   RETURN(LTRIM(nuevotexto))
ELSE
  @lin,col SAY LTRIM(nuevotexto)
  RETURN NIL
ENDIF

************************************************
FUNCTION columna(texto,h_lin,h_col)
fin := LEN(texto := TRIM(texto))
IF fin > (24 - h_lin)
   RETURN(.F.)
ENDIF
FOR i = 0 TO fin - 1
    @h_lin+i,h_col SAY SUBSTR(texto,i+1,1)
NEXT
RETURN NIL

******************************************************
FUNCTION diagdesc(texto, lin,col,cor)
tamano:= LEN(texto:=TRIM(texto))
IF tamano > (24-lin) .OR. tamano > (80-col)
   RETURN(.F.)
ENDIF
soma = 0
corantig = SETCOLOR()
IF cor <> NIL
   novacor = cor
   SETCOLOR("&novacor.")
ENDIF
DO WHILE soma <= tamano
   @lin+soma,col+soma SAY SUBST(texto,soma+1,1)
   soma++
ENDDO
SETCOLOR("&corantig.")
RETURN NIL

*************************************************
FUNCTION centrastr(lin,col,texto,larg_string,cor)
texto = TRIM(texto)
IF larg_string = NIL
   RETURN(.F.)
ENDIF
novapos = (larg_string-LEN(texto))/2
final = SPACE(novapos-1) + texto
final = final + SPACE(larg_string - LEN(final))
IF cor <> NIL
    corantig = SETCOLOR()
    novacor = cor
    SETCOLOR("&novacor.")
    @ lin,col SAY final
    SETCOLOR("&corantig.")
ELSE
    @lin,col SAY final
ENDIF
RETURN NIL

****************************************************