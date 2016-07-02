* CLIPPER TMPTEST
* BLINKER FI TMPTEST,HELPSYS LIB HELPSYS2
*   or
* RTLINK FILE TMPTEST HELPSYS LIB HELPSYS2
*
* Remember to link in HELPSYS.obj and include HELPSYS2.LIB
*
* This program does not do anything other than provide a few fields
* to demonstrate HELPSYS 2.0

FIELD Field1, Field2, Field3 in Test

CLEAR SCREEN
USE TEST
@ 1,1 GET Field1
@ 3,1 GET Field2
@ 5,1 GET Field3

READ

USE   // Close Database

