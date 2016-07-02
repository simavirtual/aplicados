*------------------------------------------------------------------------
*-LngMulti.ch
*------------------------------------------------------------------------

/*
  ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ LngMulti Version 1.1 ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ
  ³                                                                    ³°
  ³ÚÂÂÂÂÂÂÂÂÂ¿ File       : LngMult.ch                                 ³°
  ³ÃÅÅÅÅ ÅÅÅÅ´ Description: #INCLUDE this file for multilingual support³°
  ³ÃÅÅÅ Û ÅÅÅ´                                                         ³°
  ³ÃÅÅ  Û  ÅÅ´ Author     : Marc Gagnon Copyright (c) 1993-1994        ³°
  ³ÃÅ   Û   Å´              All rights reserved (CIS 71175,437)        ³°
  ³Ã    ş    ´                                                         ³°
  ³ÀÁÁÁÁÁÁÁÁÁÙ Licence    : Freeware (use and distribute freely,       ³°
  ³                         provided that credits and copyright        ³°
  ³                         notices always appear in this file.        ³°
  ³                                                                    ³°
  ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ°
    °°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°
*/

*-Set the default language when none is defined
*------------------------------------------------------------------------
  #IFNDEF FRENCH
    #IFNDEF ENGLISH
      #IFNDEF SPANISH
         #INCLUDE "LngDef.ch"
      #ENDIF
    #ENDIF
  #ENDIF


*-Language support sections
*------------------------------------------------------------------------

*-Check if French is defined
  #IFNDEF FRENCH
*-     If not remove all french expressions
       #xTRANSLATE IN FRENCH <xExpr> =>
  #ELSE
*-     Redefine french expressions as being the expressions to keep
       #UNDEF  FRENCH
       #DEFINE FRENCH _LNGMULTI_
  #ENDIF


*-Check if English is defined
  #IFNDEF ENGLISH
*-     If not remove all English expressions
       #xTRANSLATE IN ENGLISH <xExpr> =>
  #ELSE
*-     Redefine English expressions as being the expressions to keep
       #UNDEF  ENGLISH
       #DEFINE ENGLISH _LNGMULTI_
  #ENDIF

*-Check if Spanish is defined
  #IFNDEF SPANISH
*-     If not remove all Spanish expressions
       #xTRANSLATE IN SPANISH <xExpr> =>
  #ELSE
*-     Redefine Spanish expressions as being the expressions to keep
       #UNDEF  SPANISH
       #DEFINE SPANISH _LNGMULTI_
  #ENDIF

*-Keep only the expressions from the selected language (strip the key words)
  #xTRANSLATE IN _LNGMULTI_ <xExpr> => <xExpr>
