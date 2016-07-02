**** PROGRAMA: VARLOCAL.PRG
v1 = 500        // v1 fue creada como PRIVATE
CLEAR
? "Ejemplo de variable LOCAL"
?
? "Variable v1 antes de la ejecucion de las rutinas ",v1
DO func1
?
? "Estamos fuera de FUNC1 despues de su ejecucion ",v1
INKEY(0)
CLEAR

PROCEDURE func1
LOCAL v1
v1 = 100
?
? "Estamos en la rutina FUNC1....v1 = ",v1
INKEY(0)
DO func2
?
? "Volvamos a FUNC1....v1 = ",v1
? "                    v2 = ",IF(TYPE("v2") = "U","NO  EXISTE",v2)


PROCEDURE func2
LOCAL v2
v2 = 300
?
? "Estamos en la rutina FUNC2....v1 = ", v1
? "                              v2 = ", v2
INKEY(0)

**** PROGRAMA: VARPRIV.PRG
CLEAR
? "Ejemplo de variable PRIVATE"
?
PRIVATE v1
v1 = 500
? "Variable v1 antes de la ejecucion de las rutinas ",v1
DO func1
?
? "Estamos fuera de FUNC1 despues de su ejecucion ",v1
INKEY(0)
CLEAR

PROCEDURE func1
PRIVATE v1
v1 := 100
?
? "Estamos en la rutina FUNC1....v1 = ",v1
INKEY(0)
DO func2
?
? "Volvemos a FUNC1...v1 = ",v1
? "                   v2 = ",IF(TYPE("v2") = "U","NO  EXISTE",v2)

PROCEDURE func2
PRIVATE v2
v1 = 200
v2 = 300
?
? "Estamos en la rutina FUNC2....v1 = ", v1
? "                              v2 = ", v2
INKEY(0)

**** PROGRAMA: VARPUBL.PRG
CLEAR
? "Ejemplo de variable PUBLIC"
?
PUBLIC v1 := 500
? "Variable v1 antes de ejecutar las rutinas ",v1
DO func1
?
? "Estamos fuera de FUNC1 despues de su ejecucion ",v1
INKEY(0)
CLEAR

PROCEDURE func1
v1 := 100
?
? "Estamos dentro de la rutina FUNC1....v1 = ",v1
INKEY(0)
DO func2
?
? "Volvemos a FUNC1....v1 = ",v1
? "                    v2 = ",v2


PROCEDURE func2
PUBLIC v2
v1 := 200
v2 := 300
?
? "Estamos en la rutina FUNC2...v1 = ", v1
? "                             v2 = ", v2
INKEY(0)

**** PROGRAMA: VARSTAT.PRG
STATIC v1
v1 = 500
CLEAR
? "Ejemplo de variable STATIC"
?
? "Variable v1 antes de ejecutar las rutinas ",v1
DO func1
?
? "Estamos fuera de FUNC1 despues de su ejecucion ",v1
INKEY(0)
CLEAR

PROCEDURE func1
STATIC v1
v1 = 100
?
? "Estamos en la rutina FUNC1....v1 = ",v1
INKEY(0)
DO func2
?
? "Volvemos a FUNC1....v1 = ",v1
? "                    v2 = ",IF(TYPE("v2") = "U","NO  EXISTE",v2)

PROCEDURE func2
STATIC v2
v2 := 300

? "Estamos en la rutina FUNC2....v1 = ",IF(TYPE("v1") = "U","NO  EXISTE",v1)
v1 = 222
?
? "Alterando el valor de v1 = ",v1
? "                      v2 = ",v2
INKEY(0)