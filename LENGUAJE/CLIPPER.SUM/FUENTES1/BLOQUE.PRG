**** PROGRAMA: CB1.PRG
** Usando code block

b1 := {|| x >< y}
? EVAL(b1)

**** PROGRAMA: CB2.PRG
** Usando macro
exp := " x >< y "
? &exp

**** PROGRAMA: CB3.PRG

accion1 := "incfun()"

nada = &accion1

accion2 := {|| altfun()}

EVAL(accion2)

FUNCTION altfun
@23,10 SAY "Se activo la rutina de modificacion"
INKEY(3)
RETURN NIL

**** PROGRAMA: CB4.PRG

accion1 := "incfun()"

nada = &accion1

accion2 := {|| altfun()}

EVAL(accion2)

FUNCTION incfun
@23,10 SAY "Se activo la rutina de modificacion"
INKEY(3)
RETURN NIL

**** PROGRAMA: CB2M.PRG
**
LOCAL menu := {{"Inclusion ","incluir registros",{|| incfun()}},;
              {"Alteraci¢n","alterar registros",{|| altfun()}},;
              {"F i n     ","abandona sistema",{|| fin()}}}
DO WHILE .T.
   CLEAR
   FOR i = 1 TO LEN(menu)
       @ 1,i*15 PROMPT menu[i,1] MESSAGE menu[i,2]
   NEXT
   menu TO op
   IF op = 0
      op = 3      // Obliga a salir del sistema
   ENDIF

   EVAL(menu[op,3])
ENDDO

FUNCTION incfun
@23,10 SAY "Se activo la rutina de inclusion"
INKEY(3)
RETURN NIL

FUNCTION altfun
@23,10 SAY "Se activo la rutina de alteracion"
INKEY(3)
RETURN NIL

FUNCTION fin
QUIT
RETURN NIL