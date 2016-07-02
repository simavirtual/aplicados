**** PROGRAMA: EXIBEVAR.PRG
a = 5
? "a tiene el valor de: ", a
WAIT "Estamos en la rutina principal"
um()
dois()
?
WAIT "Regresamos a la rutina principal"
? "El valor de a = ", a

FUNCTION um
STATIC a := 20
?
? "a tiene el valor de: ", a
WAIT "Estamos en la funcion um()"
RETURN NIL

FUNCTION dois
STATIC a := 100
?
? "a tiene el valor de: ",a
WAIT "Estamos en la funcion dois()"
RETURN NIL