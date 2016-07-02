**** PROGRAMA: VIDEO01.PRG
CLEAR
? "dddd"
? "zzzz"
?? "tttt"
?? "yyyy"
nome = "Michele"
valor = 23500.67
? nome,valor
? nome+STR(valor,8,2)
?? DATE()
INKEY(0)

**** PROGRAMA: VIDEO02.PRG
CLEAR
USE func                   // Abre el archivo
SET PRINT ON               // Activa la impresora
? REPL("-",55)
DO WHILE .NOT. EOF()
   ? codfunc+" "
   ?? nomefunc
   ?? salario
   SKIP
ENDDO
? REPL("-",55)
SET PRINT OFF
USE

**** PROGRAMA VIDEO03.PRG
CLEAR
nome = "Vanessa"
texto = "aAaAaAaAaA"
valor = 1200.56
valor2 = -560.78

USE func
GOTO 2       // Vuelve el registro dos como el registro actual

@ 01,01 SAY "NOMBRE...: " + nomefunc
@ 02,01 SAY "SALARIO..:"
@ 02,12 SAY salario PICT "999,999.99"
@ 01,30 SAY "ADMISION.:"+DTOC(dataent)
@ 03,01 SAY "DESCUENTO:"
@ 03,12 say valor2 PICTURE "999,999.99"
@ 04,01 SAY "TOTAL....:"
@ 04,12 SAY salario+valor2 PICTURE "999,999.99"
@ 05,01 SAY REPL ("=",78)
@ 06,01 SAY texto PICT "!!!"
@ 07,01 SAY texto PICT "@!"
@ 08,01 SAY valor PICT "***,***.**"
@ 09,01 SAY valor PICT "$$$,$$$.$$"
@ 10,01 SAY valor PICT "@B999,999.99"
@ 12,01 SAY valor PICT "@C999,999.99"
@ 13,01 SAY valor2 PICT "@X999,999.99"
@ 15,01 SAY DATE() PICT "@D"
@ 16,01 SAY DATE() PICT "@E"

**** PROGRAMA VIDEO04.PRG
CLEAR
USE func                    // Abre el archivo
@ROW(),01 SAY REPL("-",55)
DO WHILE .NOT. EOF()
   @ROW()+1,01    SAY codfunc
   @ROW(),COL()+6 SAY nomefunc PICT "@!"
   @ROW(),COL()+2 SAY salario PICT "@E999,999.99"
   SKIP
ENDDO
@ROW()+1,01 SAY REPL("-",55)
USE

**** PROGRAMA: VIDEO22.PRG
CLEAR
USE func
? REPL("-",55)
c = 1
DO WHILE .NOT. EOF()
   ? codfunc + " "
   ?? nomefunc
   ?? salario
   c++
   IF c > 15
      WAIT "PRESIONE UNA TECLA PARA VER LA SIGUIENTE PANTALLA ..."
      CLEAR
      c = 1
   ENDIF
   SKIP
ENDDO
? REPL("-",55)
USE

**** PROGRAMA: VIDEOBUF.PRG
DO WHILE .T.
   CLEAR
   cod = SPACE(3); nome = SPACE(30); cep := SPACE(5)
   cidade := SPACE(20); estado = SPACE(2)
   @ 1, 2 SAY "Codigo...:" GET cod
   READ
   IF LASTKEY() = 27
      EXIT
   ENDIF
   @ 2, 2 SAY "Nombre...:" GET nome
   @ 3, 2 SAY "ZIP......:" GET cep
   READ
   IF VAL(cep) < 6000 .AND. VAL(cep) >= 1000
      KEYBOARD "SAO PAULO"+CHR(13)+"SP"
   ENDIF
   @ 4, 2 SAY "Ciudad...:" GET cidade
   @ 5, 2 SAY "Estado...:" GET estado
   READ
   INKEY(2)               // Solo para ver el ultimo GET
ENDDO

**** PROGRAMA: VIDEOCLE.PRG
USE func
CLEAR
GOTO 2
@ 1, 1 SAY "Nombre..:" GET nomefunc
@ 2, 1 SAY "Salario.:" GET salario PICTURE "@E999,999.99"
@ 3, 1 SAY "Admision:" GET dataent
CLEAR GETS
INKEY(0)
USE

**** PROGRAMA: VIDEOCUR.PRG
CLEAR
nome = SPACE(20)
valor = 0
admissao = CTOD("")
ok = .F.

@10,10 SAY "NOMBRE....:" GET nome PICT "@A!"
@12,10 SAY "HONORARIOS:" GET valor PICT "99,999.99"
SET CURSOR OFF
READ
SET CURSOR ON
@14,10 SAY "ADMISION .:" GET admissao
@16,10 SAY "SITUACION.:" GET ok PICT "L"
READ

**** PROGRAMA: VIDEODDI.PRG
CLEAR
SET DELIMITERS TO "{}"
SET DELIMITERS ON
SET INTENSITY OFF
nome = SPACE(20)
valor = 0
admissao = CTOD("")
ok = .F.

@10,10 SAY "NOMBRE....:" GET nome PICT "@A!"
@12,10 SAY "HONORARIOS:" GET valor PICT "99,999.99"
SET DELIMITERS OFF
@14,10 SAY "ADMISION..:" GET admissao
@16,10 SAY "SITUACION.:" GET ok PICT "L"
READ

**** PROGRAMA: VIDEODEL.PRG
CLEAR
SET DELIMITERS TO "{}"
SET DELIMITERS ON
nome = SPACE(20)
valor = 0
admissao = CTOD("")
ok = .F.
@10,10 SAY "NOMBRE....:" GET nome PICT "@A!"
@12,10 SAY "HONORARIOS:" GET valor PICT "99,999.99"
SET DELIMITERS OFF
@14,10 SAY "ADMISION..:" GET admissao
@16,10 SAY "SITUACION.:" GET ok PICT "L"
READ

**** PROGRAMA: VIDEOINV.PRG
USE func
CLEAR
GOTO 2
SET INTENSITY OFF
@ 1, 1 SAY "NOMBRE..:" GET nomefunc
@ 2, 1 SAY "SALARIO.:" GET salario PICTURE "@E999,999.99"
SET INTENSITY ON
@ 3, 1 SAY "ADMISION:" GET dataent
READ

**** PROGRAMA: VIDEOTEC.PRG
CLEAR
SET TALK OFF
nada = 0
DO WHILE nada <> 13       && Termina cuando presione <Enter>
   nada=INKEY()

   DO CASE
      CASE nada = 4
           @23,10 SAY  "PRESIONO LA FLECHA DERECHA"
           WAIT
           CLEAR
      CASE nada = 65
           @23,10 SAY "PRESIONO LA LETRA A"
           WAIT
           CLEAR
      CASE nada = 19
           @23,10 SAY "PRESIONO LA FLECHA IZQUIERDA"
           WAIT
           CLEAR
      CASE nada = 18
           @23,10 SAY "PRESIONO Pg Up"
           WAIT
           CLEAR
      CASE nada = 286
           @23,10 SAY "PRESIONO <Alt A>"
           WAIT
           CLEAR
   ENDCASE
ENDDO

**** PROGRAMA: VIDEOVAL.PRG
cod = SPACE(3)
DO WHILE .T.
   CLEAR
   mcod = SPACE(3)
   msetor = SPACE(1)
   mcargo = SPACE(15)
   @10,10 SAY "CODIGO..:" GET mcod
   READ
   IF mcod = "FIN"
      EXIT
   ENDIF
   @12,10 SAY "SECTOR..:" GET msetor VALID msetor $ "ABCDE"
   @14,10 SAY "CARGO ..:" GET mcargo
   adm = CTOD(" ")
   sal = 0
   minimo = 3600
   maximo = minimo * 50
   @16,10 SAY "ADMISION:" GET adm RANGE CTOD("01/01/70"), DATE()
   @18,10 SAY "SALARIO.:" GET sal RANGE minimo, maximo
   READ
ENDDO

**** PROGRAMA: VIDEOWHE.PRG
CLEAR
STORE SPACE(1) TO sexo, chapa, esp, papa
@10,10 SAY "SEXO.." GET sexo PICT "!" VALID sexo $ "MF"
@12,10 SAY "EXAMEN DE PAPA NICOLAU OK (S/N)" GET papa;
WHEN sexo = "F"
@14,10 SAY "ESPERMOGRAMA OK (S/N)" GET esp;
WHEN sexo = "M"
@16,10 SAY "PLACA DE LOS PULMONES OK" GET chapa
READ