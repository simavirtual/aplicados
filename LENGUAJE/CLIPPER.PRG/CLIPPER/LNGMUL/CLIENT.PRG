*------------------------------------------------------------------------
*-Client.prg
*------------------------------------------------------------------------

/*
  ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ LngMulti Version 1.1 ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ
  ³                                                                    ³°
  ³ÚÂÂÂÂÂÂÂÂÂ¿ File       : Client.prg                                 ³°
  ³ÃÅÅÅÅ ÅÅÅÅ´ Description: Demo of embeded multilingual capabilities  ³°
  ³ÃÅÅÅ Û ÅÅÅ´                                                         ³°
  ³ÃÅÅ  Û  ÅÅ´ Author     : Marc Gagnon Copyright (c) 1993-1994        ³°
  ³ÃÅ   Û   Å´              All rights reserved (CIS 71175,437)        ³°
  ³Ã    þ    ´                                                         ³°
  ³ÀÁÁÁÁÁÁÁÁÁÙ Licence    : Freeware (use and distribute freely,       ³°
  ³                         provided that credits and copyright        ³°
  ³                         notices always appear in this file.        ³°
  ³                                                                    ³°
  ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ°
    °°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°
*/

#INCLUDE "LngMulti.ch"  // Place before CH's with linguistic expressions
#INCLUDE "InKey.ch"

*------------------------------------------------------------------------
FUNCTION Client()

  LOCAL lnKey

  SET DATE FORMAT TO IN ENGLISH "MM/DD/YY"                              ;
                     IN FRENCH  "DD/MM/YY"                              ;
                     IN SPANISH "YY.MM.DD"


  USE Client EXCLUSIVE

  Welcome()

  DO WHILE LastKey() # K_ESC

     Form()

     lnKey := InKey( 0 )

     DO CASE
        CASE lnKey == K_UP   .OR. lnKey == K_PGUP
             Client->( dbSkip( -1 ) )

        CASE lnKey == K_DOWN .OR. lnKey == K_PGDN
             IF Client->( RecNo() ) < Client->( LastRec() )
                Client->( dbSkip(  1 ) )
             ENDIF
     ENDCASE

  ENDDO

  Bye()

RETURN( NIL )


*------------------------------------------------------------------------
STATIC FUNCTION Welcome()

  CLS

  ? IN ENGLISH "Welcome to the multiligual client management system"    ;
    IN FRENCH  "Bienvenu au systŠme de gestion de clients multilingue"  ;
    IN SPANISH "Bienvendos al systema multilinguas de gesti•n de los clientes"
  ?
  ?
  ? ( IN ENGLISH "Press any key to continue"                            ;
      IN FRENCH  "Appuyez sur une touche pour continuer"                ;
      IN SPANISH "Apretar la tecla para continuar"                      ;
    ) + "..."

  Inkey( 0 )

  CLS

RETURN( NIL )


*------------------------------------------------------------------------
STATIC FUNCTION Bye()

  CLS
  ? IN ENGLISH "Thank you, see you next time!"                          ;
    IN FRENCH  "Merci, … la prochaine!"                                 ;
    IN SPANISH "Gracias, hasta la proxima!"

  ?
  ? "LngMulti.ch v1.1 : Marc Gagnon (c) 1993-94 (CIS 71175,437)"
  ?
RETURN( NIL )


*------------------------------------------------------------------------
STATIC FUNCTION Form()

 LOCAL GetList := {}

 @  0, 0 SAY PadC( IN ENGLISH "Client form"                             ;
                   IN FRENCH  "Dossier client"                          ;
                   IN SPANISH "Fichero cliente",                        ;
                   80                                                   ;
                 )                                                      ;
             COLOR "W+/B"

 @  2, 0 SAY IN ENGLISH "Client #:"                                     ;
             IN FRENCH  "N§ client  :"                                  ;
             IN SPANISH "N§ cliente:"                                   ;
         GET Client->cCode

 @  3, 0 SAY IN ENGLISH "Name    :"                                     ;
             IN FRENCH  "Nom        :"                                  ;
             IN SPANISH "Nombre    :"                                   ;
         GET Client->cName

 @  4, 0 SAY IN ENGLISH "Address :"                                     ;
             IN FRENCH  "Adresse    :"                                  ;
             IN SPANISH "Direccion :"                                   ;
         GET Client->cAddr

 @  5, 0 SAY IN ENGLISH "City    :"                                     ;
             IN FRENCH  "Ville      :"                                  ;
             IN SPANISH "Ciudad    :"                                   ;
         GET Client->cCity

 @  6, 0 SAY IN ENGLISH "State   :"                                     ;
             IN FRENCH  "Province   :"                                  ;
             IN SPANISH "Estado    :"                                   ;
         GET Client->cState

 @  7, 0 SAY IN ENGLISH "Country :"                                     ;
             IN FRENCH  "Pays       :"                                  ;
             IN SPANISH "Pas      :"                                   ;
         GET Client->cCtry

 @  8, 0 SAY IN ENGLISH "Zip     :"                                     ;
             IN FRENCH  "Code post  :"                                  ;
             IN SPANISH "Code post :"                                   ;
         GET Client->cZip

 @ 10, 0 SAY IN ENGLISH "Phone   :"                                     ;
             IN FRENCH  "T‚l‚phone  :"                                  ;
             IN SPANISH "Telefono  :"                                   ;
         GET Client->cPhone

 @ 12, 0 SAY IN ENGLISH "Birth   :"                                     ;
             IN FRENCH  "Naissance  :"                                  ;
             IN SPANISH "Nacimiento:"                                   ;
         GET Client->dBirth

 @ MaxRow(), 0 SAY IN ENGLISH "<PageUp>-Previous  <PageDown>-Next  <Esc>-Quit"      ;
                   IN FRENCH  "<PageUp>-Pr‚c‚dent  <PageDown>-Suivant <Esc>-Quitter";
                   IN SPANISH "<PageUp>-Anterior  <PageDown>-Siguente  <Esc>-Salir"

RETURN( NIL )
