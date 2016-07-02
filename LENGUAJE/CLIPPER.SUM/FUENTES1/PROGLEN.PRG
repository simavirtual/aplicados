**** PROGRAMA: PROGLEN.PRG

mat := {}
? LEN(mat)      // Retorna cero

PRIVATE a[5]
? LEN(a)        // Retorna cinco

b := ARRAY(12)
? LEN(b)        // Retorna 12

c := ARRAY(5,10)
? LEN(c)        // Retorna 5 (primera dimensi¢n)

DECLARE d[10][12][4]
? LEN(d)        // Retorna 10 que es el numero de elementos de
                // la primera dimensi¢n
? LEN(d[1])     // Retorna 12 que es el numero de elementos de
                // la segunda dimensi¢n
? LEN(d[1,1])   // Retorna 4  que es el numero de elementos de
                // la tercera dimensi¢n

e := {"JOSE ANTONIO ALVES RAMALHO","LEONILDA ALVES","",{20,30,34}}

? LEN(e)        // Retorna  4
? LEN(e[1])     // Retorna 26
? LEN(e[2])     // Retorna 14
? LEN(e[3])     // Retorna  0
? LEN(e[4])     // Retorna  3 (Numero de elementos de la submatriz)