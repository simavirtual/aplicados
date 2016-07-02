@echo off

rem This batch file generates the mini.exe sample application

rem Compile with Force 4.0

force -Gsa -Zl mini.prg

blinker nob bli exe nob fi mini.obj li f40mini.lib

