rem
rem  96.03.15  MAKE.BAT
rem
rem  This batch file compiles and links the sample programs to create
rem  a DOS extended EXE which uses DBU from a DLL.
rem

%BLICOMCMD% t.prg %BLICOMOPT%
%BLILNKCMD% @t out %BLIOUTDIR%t.exe %BLILNKOPT%

%BLILNKCMD% @dbudll out %BLIOUTDIR%dbudll.dll %BLILNKOPT%

