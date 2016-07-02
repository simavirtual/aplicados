rem
rem  96.03.15  MAKE.BAT
rem
rem  This batch file compiles and links the sample programs to create
rem  a DOS extended EXE which uses a dynamically linked Windows DLL.
rem

%BLICOMCMD% t.c
%BLILNKCMD% @t%BLICOMNME% out %BLIOUTDIR%t.exe %BLILNKOPT%

%BLICOMCMD% %BLIDLLOPT% d.c
%BLILNKCMD% @dw%BLICOMNME% out %BLIOUTDIR%d.dll %BLILNKOPT%

%BLICOMCMD% %BLIWINOPT% tw.c
%BLILNKCMD% @tw%BLICOMNME% out %BLIOUTDIR%tw.exe %BLILNKOPT%

