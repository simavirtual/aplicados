*****************************************************************
*_ Nombre.....: PANTDIGI.FMT
*_ Fecha......: 1-29-91
*_ Notas......: Arch. de formato utiliza " " como delimitadores!
*****************************************************************
*_ Procesamiento de los @ SAY GETS 
*_ Formato de la P gina: 1

@ 5,12 TO 14,67 DOUBLE
@ 7,14 SAY "CODSAC"
@ 7,25 GET codsac PICTURE "XXXX"
@ 8,14 SAY "NOMBRESAC"
@ 8,25 GET nomesac PICTURE "XXXXXXXXXXXXXXXXXXXXXXXX"
@ 9,14 SAY "DIRECCION"
@ 9,25 GET endereco PICTURE "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
@10,14 SAY "CIUDAD"
@10,25 GET cidade PICTURE "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
@11,14 SAY "ESTADO"
@11,25 GET estado PICTURE "XX"
@12,14 SAY "ULTCOMPRA"
@12,25 GET ultcompra
