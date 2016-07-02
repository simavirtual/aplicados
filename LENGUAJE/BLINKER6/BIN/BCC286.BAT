:
:  BCC286.BAT       Borland 16 bit compiler driver for DOS extended programs
:
@echo off
echo -DDOSX286 %1 %2 %3 %4 %5 %6 %7 %8 > __xx__
shift 8
bcc @__xx__ %1 %2 %3 %4 %5 %6 %7 %8 %9
del __xx__ > nul
