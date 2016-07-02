M={100,"MAKRON",{1,"MEGATRON",.F.},DATE()}
M1={}
B={|X| X * 100}
C="SAINT TROPEZ"
D=CTOD("09/04/91")
L=.T.
N=0
N1=123.45
N2=0.56
N3=300
N4=451

C1=""
C2="    "
D1=CTOD("")

CLEAR
? "PRUEBA DE ISPAR()"
?
? ISPAR(N),N
? ISPAR(N1),N1
? ISPAR(N2),N2
? ISPAR(N3),N3
? ISPAR(N4),N4
INKEY(0)

CLEAR
? "PRUEBA DE ISIMPAR()"
?
? ISIMPAR(N),N
? ISIMPAR(N1),N1
? ISIMPAR(N2),N2
? ISIMPAR(N3),N3
? ISIMPAR(N4),N4
INKEY(0)

CLEAR
? "PRUEBA DE ISINT()"
?
? ISINT(N),N
? ISINT(N1),N1
? ISINT(N2),N2
? ISINT(N3),N3
? ISINT(N4),N4
INKEY(0)


CLEAR
? "PRUEBA DE ISDEC()"
?
? ISDEC(N),N
? ISDEC(N1),N1
? ISDEC(N2),N2
? ISDEC(N3),N3
? ISDEC(N4),N4
INKEY(0)

CLEAR
? "PRUEBA DE ISMULT()"
?
? ISMULT(200,11), "200,11"
? ISMULT(200,10), "200,10"
? ISMULT(45,5),   "45,5"
? ISMULT(27,3),   "27,3"
? ISMULT(24,4),   "24,4"
? ISMULT(24,3),   "24,3"
INKEY(0)


CLEAR
? "PRUEBA DE ISCAR()"
?
? ISCAR(200),200
? ISCAR(DATE()),DATE()
? ISCAR("JOSE ANTONIO"),"JOSE ANTONIO"
? ISCAR(C),"C"
? ISCAR(D),"D"
? ISCAR(B),"B"
? ISCAR(M),"M"
? ISCAR(M[2]),"M[2]"
? ISCAR(M[3,1]),"M[3,1]"
? ISCAR(M[3,2]),"M[3,2]"
? ISCAR(L) ,"L"
INKEY(0)

CLEAR
? "PRUEBA DE ISNUM()"
?
? ISNUM(200),200
? ISNUM(DATE()),DATE()
? ISNUM("JOSE ANTONIO"),"JOSE ANTONIO"
? ISNUM(C),"C"
? ISNUM(D),"D"
? ISNUM(B),"B"
? ISNUM(M),"M"
? ISNUM(M[2]),"M[2]"
? ISNUM(M[3,1]),"M[3,1]"
? ISNUM(M[3,2]),"M[3,2]"
? ISNUM(L),"L"
INKEY(0)


CLEAR
? "PRUEBA DE ISBLOQUE()"
?
? ISBLOQUE(200),200
? ISBLOQUE(DATE()),DATE()
? ISBLOQUE("JOSE ANTONIO"),"JOSE ANTONIO"
? ISBLOQUE(C),"C"
? ISBLOQUE(D),"D"
? ISBLOQUE(B),"B"
? ISBLOQUE(M),"M"
? ISBLOQUE(M[2]),"M[2]"
? ISBLOQUE(M[3,1]),"M[3,1]"
? ISBLOQUE(M[3,2]),"M[3,2]"
? ISBLOQUE(L),"L"
INKEY(0)

CLEAR
? "PRUEBA DE ISLOGI()"
?
? ISLOGIC(200),200
? ISLOGIC(DATE()),DATE()
? ISLOGIC("JOSE ANTONIO"),"JOSE ANTONIO"
? ISLOGIC(C),"C"
? ISLOGIC(D),"D"
? ISLOGIC(B),"B"
? ISLOGIC(M),"M"
? ISLOGIC(M[2]),"M[2]"
? ISLOGIC(M[3,1]),"M[3,1]"
? ISLOGIC(M[3,3]),"M[3,3]"
? ISLOGIC(L),"L"
INKEY(0)

CLEAR
? "PRUEBA DE ISFECHA()"
?
? ISFECHA(200),200
? ISFECHA(DATE()),DATE()
? ISFECHA("JOSE ANTONIO"),"JOSE ANTONIO"
? ISFECHA(C),"C"
? ISFECHA(D),"D"
? ISFECHA(B),"B"
? ISFECHA(M),"M"
? ISFECHA(M[2]),"M[2]"
? ISFECHA(M[3,1]),"M[3,1]"
? ISFECHA(M[3,2]),"M[3,3]"
? ISFECHA(L),"L"
INKEY(0)

CLEAR
? "PRUEBA DE ISMAT()"
?
? ISMAT(200),200
? ISMAT(DATE()),DATE()
? ISMAT("JOSE ANTONIO"),"JOSE ANTONIO"
? ISMAT(C),"C"
? ISMAT(D),"D"
? ISMAT(B),"B"
? ISMAT(M),"M"
? ISMAT(M[3]),"M[3]"
? ISMAT(M[3,1]),"M[3,1]"
? ISMAT(M[3,2]),"M[3,3]"
? ISMAT(L),"L"
INKEY(0)

USE FUNC
TEXTO=COMENT
CLEAR
? "PRUEBA DE ISMEMO()"
?
? ISMEMO(200),200
? ISMEMO(DATE()),DATE()
? ISMEMO("JOSE ANTONIO"),"JOSE ANTONIO"
? ISMEMO(C),"C"
? ISMEMO(D),"D"
? ISMEMO(B),"B"
? ISMEMO(M),"M"
? ISMEMO(M[3]),"M[3]"
? ISMEMO(M[3,1]),"M[3,1]"
? ISMEMO(M[3,2]),"M[3,3]"
? ISMEMO(L),"L"
? ISMEMO(COMENT),"COMENT"
? ISMEMO(TEXTO),"TEXTO"
INKEY(0)
USE

CLEAR
? "PRUEBA DE ISEMPTY()"
?
? ISEMPTY(200),200
? ISEMPTY(DATE()),DATE()
? ISEMPTY("JOSE ANTONIO"),"JOSE ANTONIO"
? ISEMPTY(C),"C"
? ISEMPTY(D),"D"
? ISEMPTY(B),"B"
? ISEMPTY(M),"M"
? ISEMPTY(M[3]),"M[3]"
? ISEMPTY(M[3,1]),"M[3,1]"
? ISEMPTY(M[3,2]),"M[3,3]"
? ISEMPTY(m1),"M1"
? ISEMPTY(L),"L"
? ISEMPTY(N),"N"
? ISEMPTY(N1),"N1"
? ISEMPTY(C1),"C1"
? ISEMPTY(C2),"C2"
? ISEMPTY(D1),"D1"
INKEY(0)





*************************************************************
FUNCTION ISCAR(var1)
RETURN (VALTYPE(VAR1)="C")

*************************************************************
FUNCTION ISFECHA(var1)
RETURN (VALTYPE(VAR1)="D")

*************************************************************
FUNCTION ISLOGIC(var1)
RETURN (VALTYPE(VAR1)="L")


*************************************************************
FUNCTION ISMAT(var1)
RETURN (VALTYPE(VAR1)="A")

*************************************************************
FUNCTION ISMEMO(var1)
RETURN (VALTYPE(VAR1)="M")

*************************************************************
FUNCTION ISNUM(var1)
RETURN (VALTYPE(VAR1)="N")

***************************************************
FUNCTION ISBLOQUE(var1)
RETURN VALTYPE(VAR1)="B"

**************************************************************
FUNCTION ISEMPTY(var1)
TIPO=VALTYPE(VAR1)
DO CASE
CASE tipo="C"
   RETURN (VAR1=SPACE(LEN(var1)))
CASE tipo="N"
   RETURN (var1==0)
CASE tipo="D"
   RETURN (var1=CTOD("  /  /  "))
CASE TIPO="A"
   RETURN (LEN(VAR1)=0)
OTHERWISE
   RETURN ("TIPO INCOMPATIBLE PARA PRUEBA")
ENDCASE

****************************************************
FUNCTION ISINT(var1)
IF VALTYPE(VAR1)<>"N"
   TONE(3000,1)
   TONE(1500,1)
   TONE(100,1)
   RETURN "ERROR ISINT ACEPTA SOLO NUMEROS COMO ARGUMENTO"
ENDIF
RETURN (var1-int(var1) =0)
****************************************************
FUNCTION ISDEC(var1)
LOCAL var2
IF VALTYPE(VAR1)<>"N"
   TONE(3000,1)
   TONE(1500,1)
   TONE(100,1)
   RETURN "ERROR ISDEC() ACEPTA SOLO NUMEROS COMO ARGUMENTO"
ENDIF
var2=INT(var1)
var2=var1-var2
IF var2 <>0 .AND. INT(var1)=0
   RETURN (.T.)
ELSE
   RETURN (.F.)
ENDIF

***************************************************
FUNCTION ISPAR(VAR1)
IF VALTYPE(VAR1)<>"N"
   TONE(3000,1)
   TONE(1500,1)
   TONE(100,1)
   RETURN "ERROR ISPAR() ACEPTA SOLO NUMEROS COMO ARGUMENTO"
ENDIF
IF VAR1 > 0 .AND. VAR1 <1
   RETURN .F.  
ELSE  
   IF VAR1 <> INT(VAR1)  
      RETURN .F.  
   ELSE  
      RETURN (MOD(VAR1,2)= 0 )  
   ENDIF  
ENDIF  
  
**************************************************
FUNCTION ISIMPAR(var1)
IF VALTYPE(VAR1)<>"N"
   TONE(3000,1)
   TONE(1500,1)
   TONE(100,1)
   RETURN "ERROR ISIMPAR() ACEPTA SOLO NUMEROS COMO ARGUMENTO"
ENDIF
IF VAR1= 0
   RETURN .F.
ELSE
   IF INT(VAR1)<>VAR1
      RETURN .F.
   ELSE
      RETURN (MOD(VAR1,2)<>0 )
   ENDIF
ENDIF
**************************************************
FUNCTION ISMULT(var1,var2)    // VAR1=NUMERO, VAR2=BASE
IF VALTYPE(VAR1)<>"N" .OR. VALTYPE(VAR2) <>"N"
   TONE(3000,1)
   TONE(1500,1)
   TONE(100,1)
   RETURN "ERROR ISIMPAR() ACEPTA SOLO NUMEROS COMO ARGUMENTO"
ENDIF
IF var1/var2=INT(var1/var2)
   RETURN (.T.)
ELSE
   RETURN (.F.)
ENDIF
         
         
