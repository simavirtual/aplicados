*------------------------------------------------------------------------
*-LngMulti.ch
*------------------------------------------------------------------------

/*
  ���������������������� LngMulti Version 1.1 ��������������������������
  �                                                                    ��
  ����������¿ File       : LngMult.ch                                 ��
  ������ ���Ŵ Description: #INCLUDE this file for multilingual support��
  ����� � ��Ŵ                                                         ��
  ����  �  �Ŵ Author     : Marc Gagnon Copyright (c) 1993-1994        ��
  ���   �   Ŵ              All rights reserved (CIS 71175,437)        ��
  ��    �    �                                                         ��
  ������������ Licence    : Freeware (use and distribute freely,       ��
  �                         provided that credits and copyright        ��
  �                         notices always appear in this file.        ��
  �                                                                    ��
  ���������������������������������������������������������������������ٰ
    ���������������������������������������������������������������������
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
