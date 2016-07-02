@echo off
REM this file makes initest.exe

clipper initest /n /w

rtlink fi initest lib ofgini,classy,samples,clipper

rem This compiles and links good with rtlink and blinker 2.x, however,
rem i have had trouble linking this with blinker 3.0.
