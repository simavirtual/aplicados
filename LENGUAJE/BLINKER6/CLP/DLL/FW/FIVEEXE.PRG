/*
 ��������������������������������������������������������
 �  FiveExe                                             �
 �  Libraries :  Clipper/FiveWin                        �
 ��������������������������������������������������������*/

 
 /* INCLUDES */
 #INCLUDE 'FIVEWIN.CH'
      
 STATIC oWnd   
 
 PROCEDURE MAIN()

   SET 3DLOOK ON

    DEFINE WINDOW oWnd ; 
     TITLE "FiveDll Test" ;
      MENU BuildMenu()

   ACTIVATE WINDOW oWnd 
   SET 3DLOOK OFF

  RETURN

/*
 ��������������������������������������������������������
 �  BuildMenu                                           �
 ��������������������������������������������������������*/

 FUNCTION BuildMenu()
    LOCAL ;
       oMenu

       MENU oMenu
         MENUITEM "&Information"
         MENU
           MENUITEM "&DLL"     ACTION HelloWorld()
           MENUITEM "&About"   ACTION MsgInfo( "Blinker4/FiveWin Demo" ) 
           SEPARATOR
           MENUITEM "E&xit..." ACTION oWnd:End()
         ENDMENU
       ENDMENU

 RETURN oMenu

