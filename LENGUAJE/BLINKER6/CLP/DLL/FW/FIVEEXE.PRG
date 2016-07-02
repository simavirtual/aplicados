/*
 ﬁﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ›
 ﬁ  FiveExe                                             ›
 ﬁ  Libraries :  Clipper/FiveWin                        ›
 ﬁ‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹›*/

 
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
 ﬁﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ›
 ﬁ  BuildMenu                                           ›
 ﬁ‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹›*/

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

