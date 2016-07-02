rem
rem  96.03.15  MAKE.BAT
rem
rem  This batch file compiles and links the sample programs to create
rem  a DOS extended EXE which uses a DOS extended DLL.
rem

%BLICOMCMD% t.c

%BLICOMCMD% %BLIDLLOPT% d.c
%BLILNKCMD% @d%BLICOMNME% out %BLIOUTDIR%d.dll %BLILNKOPT%

BLILIB /ID %BLIOUTDIR%d.dll /OL %BLIOUTDIR%d.lib /SM /NP

%BLILNKCMD% @t%BLICOMNME% out %BLIOUTDIR%t.exe %BLILNKOPT%

