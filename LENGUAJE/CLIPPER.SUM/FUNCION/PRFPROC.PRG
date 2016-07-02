CLEAR
 USE FUNC
 VALOR=0
 ULTIMO=LASTREC()
 TERMOH(VALOR)
 T=0
 C=0
 DO WHILE .NOT. EOF()
    T=T+SALARIO
    SKIP
    INKEY(0)
    VALOR=(++C)*100/ULTIMO
    TERMOH(VALOR)
 ENDDO
 INKEY(0)
 REST SCREEN FROM PANTALLA   
 
 
 TESTA=0
 
 USE FUNC
 VALOR=0
 ULTIMO=LASTREC()
 TERMOV(VALOR)
 T=0
 C=0
 DO WHILE .NOT. EOF()
    T=T+SALARIO
    VALOR=(++C)*100/ULTIMO
    TERMOV(VALOR)
    SKIP
 ENDDO
 INKEY(0)
 REST SCREEN FROM PANTALLA
 
 USE FUNC
 VALOR=0
 ULTIMO=LASTREC()
 TERMOV(VALOR)
 T=0
 C=0
 DO WHILE .NOT. EOF()
    T=T+SALARIO
    VALOR=(++C)*100/ULTIMO
    TERMOV(VALOR)
    MUESTRAREC(2,2)
    AVANZAREC(5,10)
 ENDDO
 INKEY(0)
 REST SCREEN FROM PANTALLA
 
 
 AGUARDE(05,10,4,.T.,)
 RESTORE SCREEN FROM PANTALLA
 
 AGUARDE(38,20,,.F.,"PROCESANDO ARCHIVO DE FUNCIONARIOS")
 **COMANDOS PARA LISTAR O PROCESAR EL ARCHIVO
 T=0
 USE FUNC
 DO WHILE .NOT. EOF()
    T+=SALARIO
    INKEY(.5)
    SKIP
 ENDDO
 RESTORE SCREEN FROM PANTALLA
 
 ****************************************
 FUNCTION AGUARDE(LIN1,COL1,TEMPO,PISCA,TEXTO)
 PUBLIC PANTALLA ; SAVE SCREEN TO PANTALLA
 IF PCOUNT()<>5
 RETURN NIL
 ENDIF
 IF LIN1>17
    LIN1=17
 ENDIF
 IF COL1>25
    COL1=25
 ENDIF
 IF TEMPO=NIL
    TEMPO=.01
 ENDIF
 IF PISCA=NIL
    PISCA=.F.
 ENDIF
 IF TEXTO=NIL
    TEXTO="P R O C E S A N D O..."
 ENDIF
 CORANTIG=SETCOLOR()
 SETCOLOR("w/n")
 @ LIN1+7,COL1+2 SAY REPLICATE(CHR(220),50)
 FOR I = LIN1 TO LIN1+7
    @ I,COL1+52 SAY CHR(219)
 NEXT
 IF PISCA
    SETCOLOR("*+r/+B")
 ELSE
    SETCOLOR("+R/+B")
 ENDIF
 @ LIN1-1,COL1-1,LIN1+6,COL1+50 box "         "
 @ LIN1++,COL1 SAY "€€€€€€ €€€€€€ €    € €€€€€€ €€€€€€ €€€€€  €€€€€€"
 @ LIN1++,COL1 SAY "€    € €      €    € €    € €    € €    € €"
 @ LIN1++,COL1 SAY "€€€€€€ €  €€€ €    € €€€€€€ €ﬂﬂﬂﬂ€ €    € €€€€€"
 @ LIN1++,COL1 SAY "€    € €    € €    € €    € €‹€€ﬂ  €    € €"
 @ LIN1++,COL1 SAY "€    € €€€€€€ €€€€€€ €    € €   ‹€ €€€€€  €€€€€€"
 @ LIN1++,COL1 SAY REPL(CHR(223),49)
 IF PISCA
    SETCOLOR("+R/+B")
 ENDIF
 @ LIN1++,COL1 SAY LEFT(TEXTO,50)
 SETCOLOR("&CORANTIG")
 INKEY(TEMPO)
 RETURN NIL
 
 
 *********************************************
 FUNCTION TERMOH(VALOR)
 IF valor <=1
    PUBLIC PANTALLA ; SAVE SCREEN TO PANTALLA
       SETCOLOR("w+/n")
    @ 15,09 SAY "…ÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕª"
    @ 16,09 SAY "∫           PORCENTAJE DE TARIFA EJECUTADA              ∫"
    @ 17,09 SAY "«ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ∫"
    @ 18,09 SAY "∫  1   10   20   30  40   50   60   70   80   90   100  ∫"
    @ 19,09 SAY "∫⁄Ÿ...|....|....|....|....|....|....|....|....|....¿ø   ∫"
    @ 20,09 SAY "∫≥                                                  ≥   ∫"
    @ 21,09 SAY "∫¿ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒŸ   ∫"
    @ 22,09 SAY "»ÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕº"
 ELSE
    @ 20,11 SAY REPLICATE(CHR(219),valor/2)
 ENDIF
 RETURN NIL
 ******************************************************
 FUNCTION TERMOV(VALOR,COR)
 IF valor <=1
    PUBLIC PANTALLA ; SAVE SCREEN TO PANTALLA
    COR1=COR
    IF COR1=NIL
      SETCOLOR("W+/N")
    ELSE
      SETCOLOR("&COR1")
    ENDIF
    @ 01,58 SAY "…ÕÕÕÀÕÕÕÕÕÕÕÕÕÕª"
    @ 02,58 SAY "∫ P ∫⁄ƒƒƒ¬ƒ100 ∫"
    @ 03,58 SAY "∫ O ∫≥   ≥     ∫"
    @ 04,58 SAY "∫ R ∫≥   ≥     ∫"
    @ 05,58 SAY "∫ C ∫≥   ≥     ∫"
    @ 06,58 SAY "∫ E ∫≥   √ƒ80  ∫"
    @ 07,58 SAY "∫ N ∫≥   ≥     ∫"
    @ 08,58 SAY "∫ T ∫≥   ≥     ∫"
    @ 09,58 SAY "∫ A ∫≥   ≥     ∫"
    @ 10,58 SAY "∫ J ∫≥   √ƒ60  ∫"
    @ 11,58 SAY "∫ E ∫≥   ≥     ∫"
    @ 12,58 SAY "∫   ∫≥   ≥     ∫"
    @ 13,58 SAY "∫   ∫≥   ≥     ∫"
    @ 14,58 SAY "∫ E ∫≥   √ƒ40  ∫"
    @ 15,58 SAY "∫ J ∫≥   ≥     ∫"
    @ 16,58 SAY "∫ E ∫≥   ≥     ∫"
    @ 17,58 SAY "∫ C ∫≥   ≥     ∫"
    @ 18,58 SAY "∫ U ∫≥   √ƒ20  ∫"
    @ 19,58 SAY "∫ T ∫≥   ≥     ∫"
    @ 20,58 SAY "∫ A ∫≥   ≥     ∫"
    @ 21,58 SAY "∫ D ∫≥   ≥     ∫"
    @ 22,58 SAY "∫ O ∫≥   ≥     ∫"
    @ 23,58 SAY "∫   ∫¿ƒƒƒ¡ƒ0   ∫"
    @ 24,58 SAY "»ÕÕÕ ÕÕÕÕÕÕÕÕÕÕº"
 ELSE
    INKEY(0)
    linha=(valor/5)
    linha=23-linha
    linha=IIF(linha<3,3,linha)
    @ linha,64 SAY REPLICATE(CHR(219),3)
 ENDIF
 RETURN NIL
 
 ******************************************
 FUNCTION MUESTRAREC(lin1,col1)
 PUBLIC TESTA:=0
 IF TESTA=0
    IF LIN1=NIL
       lin1=1
    ENDIF
    IF COL1=NIL
       col1=45
    ENDIF
    @ LIN1,COL1 CLEAR TO LIN1+2,COL1+34
    @ LIN1,COL1 TO LIN1+2,COL1+34
    @ LIN1+1,COL1+1 SAY "REGISTROS:"
    @ LIN1+1,COL()+1 SAY LASTREC() PICT "@B 999999"
    @ LIN1+1,COL1+17 SAY "ACTUAL :"
    TESTA=1
 ENDIF
 @ lin1+1,col1+27 SAY STRZERO(RECNO(),6)
 RETURN NIL
   
 **************************************************
 FUNCTION AVANZAREC(lin1,col1)
 if lin1=nil
    LIN1=21
 ENDIF
 IF COL1=NIL
    COL1=10
 ENDIF
   
 SKIP
   
 IF EOF()
    LINHA=SAVESCREEN(LIN1,COL1,LIN1+2,COL1+30)
    @ LIN1,COL1 CLEAR TO LIN1+2,COL1+30
    CORANTIG=SETCOLOR()
    SETCOLOR("W*+/+B")
    @ LIN1,COL1 TO LIN1+2,COL1+30
    @ LIN1+1,COL1+1 SAY "FIN DE ARCHIVO ENCONTRADO!..."
    INKEY(2)
    SETCOLOR("&CORANTIG")
    RETURN (.t.)
 ENDIF
 RETURN (.f.)
 
 *********************************************
 FUNCTION RETROREC(LIN1,COL1)
 if lin1=nil
    LIN1=21
 ENDIF
 IF COL1=NIL
    COL1=10
 ENDIF
 
 SKIP -1
 
 IF EOF()
    LINHA=SAVESCREEN(LIN1,COL1,LIN1+2,COL1+30)
    @ LIN1,COL1 CLEAR TO LIN1+2,COL1+30
    CORANTIG=SETCOLOR()
    SETCOLOR("W*+/+B")
    @ LIN1,COL1 TO LIN1+2,COL1+30
    @ LIN1+1,COL1+1 SAY "INICIO DE ARCHIVO ENCONTRADO!..."
    INKEY(2)
    SETCOLOR("&CORANTIG")
    RETURN (.t.)
 ENDIF
 RETURN (.f.)
 *****************************
        

