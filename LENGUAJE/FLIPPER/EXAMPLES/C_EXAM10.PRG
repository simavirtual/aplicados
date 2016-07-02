* Program Name: curmake.prg
* Author: Karl Lalonde
* Copyright (c) 1990 by Kolinahr Software
*-----------------------------------------------------------------------------
* Description: Original Creation.
* Comments:        605-584-4986   before 3:30 MST
* Lewd Comments:   605-578-2683   after  5:00  "
*---------------------------- ALL RIGHTS RESERVED ----------------------------
*****************************************************************************
*
*  Gary...you wanted to see this when it was done...hope you like. KAL
*
*  A Mouse cursor design utility.
*  Not elegant but functional.
*
* Note: This utility requires a data file with the following stru:
*
*Record#  FIELD_NAME FIELD_TYPE FIELD_LEN FIELD_DEC
*      1  ARRAY      C                 15         0
*      2  VAL1       N                  1         0
*      3  VAL2       N                  1         0
*      4  VAL3       N                  1         0
*      5  VAL4       N                  1         0
*      6  VAL5       N                  1         0
*      7  VAL6       N                  1         0
*      8  VAL7       N                  1         0
*      9  VAL8       N                  1         0
*     10  VAL9       N                  1         0
*     11  VAL10      N                  1         0
*     12  VAL11      N                  1         0
*     13  VAL12      N                  1         0
*     14  VAL13      N                  1         0
*     15  VAL14      N                  1         0
*     16  VAL15      N                  1         0
*     17  VAL16      N                  1         0
*     18  FINAL      N                  8         0
*     19  FINALSTR   C                 30         0
*
* Also, the RMN8_15 font has to been in the directory.
*
* The normal rack of disclaimers...
*     This beast works for me. If it doesn't for you, or you machine blows
* up, or there is a supernova, that's your problem.
*
* Uses Flipper 5 fns.
*
******************************************************************************
PUBLIC screen_mask[16], cursor_mask[16]

IF !FILE('CURTYPE.DBF')
   CREATE HOLD
   APPEND BLANK
   REPLACE FIELD_NAME WITH 'ARRAY'
   REPLACE FIELD_TYPE WITH 'C'
   REPLACE FIELD_LEN WITH 15
   REPLACE FIELD_DEC WITH 0
   APPEND BLANK
   REPLACE FIELD_NAME WITH 'VAL1'
   REPLACE FIELD_TYPE WITH 'N'
   REPLACE FIELD_LEN WITH 1
   REPLACE FIELD_DEC WITH 0
   APPEND BLANK
   REPLACE FIELD_NAME WITH 'VAL2'
   REPLACE FIELD_TYPE WITH 'N'
   REPLACE FIELD_LEN WITH 1
   REPLACE FIELD_DEC WITH 0
   APPEND BLANK
   REPLACE FIELD_NAME WITH 'VAL3'
   REPLACE FIELD_TYPE WITH 'N'
   REPLACE FIELD_LEN WITH 1
   REPLACE FIELD_DEC WITH 0
   APPEND BLANK
   REPLACE FIELD_NAME WITH 'VAL4'
   REPLACE FIELD_TYPE WITH 'N'
   REPLACE FIELD_LEN WITH 1
   REPLACE FIELD_DEC WITH 0
   APPEND BLANK
   REPLACE FIELD_NAME WITH 'VAL5'
   REPLACE FIELD_TYPE WITH 'N'
   REPLACE FIELD_LEN WITH 1
   REPLACE FIELD_DEC WITH 0
   APPEND BLANK
   REPLACE FIELD_NAME WITH 'VAL6'
   REPLACE FIELD_TYPE WITH 'N'
   REPLACE FIELD_LEN WITH 1
   REPLACE FIELD_DEC WITH 0
   APPEND BLANK
   REPLACE FIELD_NAME WITH 'VAL7'
   REPLACE FIELD_TYPE WITH 'N'
   REPLACE FIELD_LEN WITH 1
   REPLACE FIELD_DEC WITH 0
   APPEND BLANK
   REPLACE FIELD_NAME WITH 'VAL8'
   REPLACE FIELD_TYPE WITH 'N'
   REPLACE FIELD_LEN WITH 1
   REPLACE FIELD_DEC WITH 0
   APPEND BLANK
   REPLACE FIELD_NAME WITH 'VAL9'
   REPLACE FIELD_TYPE WITH 'N'
   REPLACE FIELD_LEN WITH 1
   REPLACE FIELD_DEC WITH 0
   APPEND BLANK
   REPLACE FIELD_NAME WITH 'VAL10'
   REPLACE FIELD_TYPE WITH 'N'
   REPLACE FIELD_LEN WITH 1
   REPLACE FIELD_DEC WITH 0
   APPEND BLANK
   REPLACE FIELD_NAME WITH 'VAL11'
   REPLACE FIELD_TYPE WITH 'N'
   REPLACE FIELD_LEN WITH 1
   REPLACE FIELD_DEC WITH 0
   APPEND BLANK
   REPLACE FIELD_NAME WITH 'VAL12'
   REPLACE FIELD_TYPE WITH 'N'
   REPLACE FIELD_LEN WITH 1
   REPLACE FIELD_DEC WITH 0
   APPEND BLANK
   REPLACE FIELD_NAME WITH 'VAL13'
   REPLACE FIELD_TYPE WITH 'N'
   REPLACE FIELD_LEN WITH 1
   REPLACE FIELD_DEC WITH 0
   APPEND BLANK
   REPLACE FIELD_NAME WITH 'VAL14'
   REPLACE FIELD_TYPE WITH 'N'
   REPLACE FIELD_LEN WITH 1
   REPLACE FIELD_DEC WITH 0
   APPEND BLANK
   REPLACE FIELD_NAME WITH 'VAL15'
   REPLACE FIELD_TYPE WITH 'N'
   REPLACE FIELD_LEN WITH 1
   REPLACE FIELD_DEC WITH 0
   APPEND BLANK
   REPLACE FIELD_NAME WITH 'VAL16'
   REPLACE FIELD_TYPE WITH 'N'
   REPLACE FIELD_LEN WITH 1
   REPLACE FIELD_DEC WITH 0
   APPEND BLANK
   REPLACE FIELD_NAME WITH 'FINAL'
   REPLACE FIELD_TYPE WITH 'N'
   REPLACE FIELD_LEN WITH 8
   REPLACE FIELD_DEC WITH 0
   APPEND BLANK
   REPLACE FIELD_NAME WITH 'FINALSTR'
   REPLACE FIELD_TYPE WITH 'C'
   REPLACE FIELD_LEN WITH 30
   REPLACE FIELD_DEC WITH 0

   CREATE CURTYPE FROM HOLD
   ERASE('HOLD.DBF')
   FOR I=1 to 32
      APPEND BLANK
   NEXT
ENDIF

USE CURTYPE

refresh = .T.
initmask = .F.

CLEAR
@ 5,5 SAY "Do you want to clear the data file first(Y/N)?" GET refresh PICTURE "Y"
READ

IF refresh
   REPLACE ALL VAL1 WITH 0,;
            VAL2  WITH 0,;
            VAL3  WITH 0,;
            VAL4  WITH 0,;
            VAL5  WITH 0,;
            VAL6  WITH 0,;
            VAL7  WITH 0,;
            VAL8  WITH 0,;
            VAL9  WITH 0,;
            VAL10 WITH 0,;
            VAL11 WITH 0,;
            VAL12 WITH 0,;
            VAL13 WITH 0,;
            VAL14 WITH 0,;
            VAL15 WITH 0,;
            VAL16 WITH 0,;
            FINAL WITH 0
  @ 6,5 SAY "Initialize screen mask to ONES(Y/N)?        " GET initmask PICTURE "Y"
  READ
   IF initmask
      REPLACE ALL VAL1 WITH 1,;
               VAL2  WITH 1,;
               VAL3  WITH 1,;
               VAL4  WITH 1,;
               VAL5  WITH 1,;
               VAL6  WITH 1,;
               VAL7  WITH 1,;
               VAL8  WITH 1,;
               VAL9  WITH 1,;
               VAL10 WITH 1,;
               VAL11 WITH 1,;
               VAL12 WITH 1,;
               VAL13 WITH 1,;
               VAL14 WITH 1,;
               VAL15 WITH 1,;
               VAL16 WITH 1  FOR RECNO() < 17
   ENDIF
ENDIF

flip_init(600)

number = MS_RESET()
IF number = 0
   ? "You need mouse to run this...press any key to continue"
   INKEY(0)
   CANCEL
ENDIF
SET_SAYERR(1)

memfont = FONT_OPEN("\FLIPPER\FONTS\RMN8_15.@")

FSCREEN()
CLS_SCREEN(15)
MS_CURSOR(1)
MS_CURON()

SAY_FIXED(27,0,memfont,4,15,'Point to colored area and press left button')
SAY_FIXED(28,0,memfont,4,15,'Right button tests cursor - both to quit')

for i=10 to 170 STEP 10
    FLINE(i,10,i,170,1,1)
    FLINE(i,200,i,360,1,1)
next

for i=10 to 170 STEP 10
    FLINE(10,i,170,i,1,1)
    FLINE(10,i+190,170,i+190,1,1)
next

IF .NOT. refresh
  SET_XOR(1)
  MSKLOAD1()
  SET_XOR(0)
ENDIF

IF initmask
  SET_XOR(1)
  MSKLOAD2()
  SET_XOR(0)
ENDIF

SAY_FIXED(10,19,memfont,4,15,'Screen Mask')
SAY_FIXED(23,19,memfont,4,15,'Cursor Mask')

M_row = 0
M_col = 0
Msx   = 0
Msy   = 0

DO WHILE .T.
   M_but=KEY_PRESS()

   DO CASE
      CASE KP_BUTTON() = 3
          EXIT

      CASE KP_BUTTON() = 2
          CURTEST()

   OTHERWISE

      Msx   = KP_ABS_X()
      Msy   = KP_ABS_Y()

      M_row = INT(Msy/10)
      y1    = M_row * 10
      y2    = y1 + 10


      M_col = INT(Msx/10)
      x1    = M_col * 10
      x2    = x1 + 10

      SAY_FIXED(5,35,memfont,1,15,'Row:  '+str(M_row,4))
      SAY_FIXED(6,35,memfont,1,15,'Col:  '+str(M_col,4))
      SAY_FIXED(7,35,memfont,1,15,'X:    '+str(Msx,4))
      SAY_FIXED(8,35,memfont,1,15,'Y:    '+str(Msy,4))

      IF M_row > 16 .AND. M_row < 20 .OR. M_row < 1 .OR. M_row > 36
          LOOP
      ENDIF

      IF M_col < 1 .OR. M_col > 16
          LOOP
      ENDIF

      IF M_row > 16
          GO M_row - 3
      ELSE
          GO M_row
      ENDIF

      DO CASE
         CASE M_col = 1
              REPLACE VAL1 WITH IF(VAL1=1,0,1)
              STORE VAL1 TO dispflag
         CASE M_col = 2
              REPLACE VAL2 WITH IF(VAL2=1,0,1)
              STORE VAL2 TO dispflag
         CASE M_col = 3
              REPLACE VAL3 WITH IF(VAL3=1,0,1)
              STORE VAL3 TO dispflag
         CASE M_col = 4
              REPLACE VAL4 WITH IF(VAL4=1,0,1)
              STORE VAL4 TO dispflag
         CASE M_col = 5
              REPLACE VAL5 WITH IF(VAL5=1,0,1)
              STORE VAL5 TO dispflag
         CASE M_col = 6
              REPLACE VAL6 WITH IF(VAL6=1,0,1)
              STORE VAL6 TO dispflag
         CASE M_col = 7
              REPLACE VAL7 WITH IF(VAL7=1,0,1)
              STORE VAL7 TO dispflag
         CASE M_col = 8
              REPLACE VAL8 WITH IF(VAL8=1,0,1)
              STORE VAL8 TO dispflag
         CASE M_col = 9
              REPLACE VAL9 WITH IF(VAL9=1,0,1)
              STORE VAL9 TO dispflag
         CASE M_col = 10
              REPLACE VAL10 WITH IF(VAL10=1,0,1)
              STORE VAL10 TO dispflag
         CASE M_col = 11
              REPLACE VAL11 WITH IF(VAL11=1,0,1)
              STORE VAL11 TO dispflag
         CASE M_col = 12
              REPLACE VAL12 WITH IF(VAL12=1,0,1)
              STORE VAL12 TO dispflag
         CASE M_col = 13
              REPLACE VAL13 WITH IF(VAL13=1,0,1)
              STORE VAL13 TO dispflag
         CASE M_col = 14
              REPLACE VAL14 WITH IF(VAL14=1,0,1)
              STORE VAL14 TO dispflag
         CASE M_col = 15
              REPLACE VAL15 WITH IF(VAL15=1,0,1)
              STORE VAL15 TO dispflag
         CASE M_col = 16
              REPLACE VAL16 WITH IF(VAL16=1,0,1)
              STORE VAL16 TO dispflag
      ENDCASE

      SET_XOR(1)
       x1 = x1 + 1
       x2 = x2 - 1
       y1 = y1 + 1
       y2 = y2 - 1

      MS_CUROFF()
      FLINE(x1,y1,x2,y2,2,1)
      SET_XOR(0)

      MS_CURON()
   ENDCASE
ENDDO
MS_CUROFF()

TEXTMODE()
CLEAR
fil = SPACE(8)
@ 5,5 SAY "Enter name of file to send design to: " GET fil
READ
IF fil = SPACE(8)
    RETURN
    CANCEL
ENDIF

fil = ALLTRIM(fil)+".CUR"

REPLACE ALL FINAL WITH VAL16         +;
                       VAL15 * 2     +;
                       VAL14 * 4     +;
                       VAL13 * 8     +;
                       VAL12 * 16    +;
                       VAL11 * 32    +;
                       VAL10 * 64    +;
                       VAL9  * 128   +;
                       VAL8  * 256   +;
                       VAL7  * 512   +;
                       VAL6  * 1024  +;
                       VAL5  * 2048  +;
                       VAL4  * 4096  +;
                       VAL3  * 8192  +;
                       VAL2  * 16384 +;
                       VAL1  * 32768

REPLACE ALL FINALSTR WITH ARRAY + ALLTRIM(STR(FINAL))
COPY ALL TO (fil)

RETURN
CLOSE DATA

FUNCTION CURTEST
REPLACE ALL FINAL WITH VAL16         +;
                       VAL15 * 2     +;
                       VAL14 * 4     +;
                       VAL13 * 8     +;
                       VAL12 * 16    +;
                       VAL11 * 32    +;
                       VAL10 * 64    +;
                       VAL9  * 128   +;
                       VAL8  * 256   +;
                       VAL7  * 512   +;
                       VAL6  * 1024  +;
                       VAL5  * 2048  +;
                       VAL4  * 4096  +;
                       VAL3  * 8192  +;
                       VAL2  * 16384 +;
                       VAL1  * 32768

    COMMIT
    GO TOP
    FOR I = 1 TO 16
        screen_mask[I] = FINAL
        SKIP
    NEXT

    FOR I = 1 TO 16
        cursor_mask[I] = FINAL
        SKIP
    NEXT
    CUR_DEFINE( 1, 1, screen_mask, cursor_mask )
    MS_CURSOR(9)
    KEY_PRESS()
    MS_CURSOR(1)
RETURN .T.


FUNCTION MSKLOAD1
  GO TOP
  FOR I = 1 TO 32
    GO I

    row = IF(I > 16, I+3,I)
    y1  = (row * 10) + 1
    y2  = y1 + 8

    FOR J = 1 TO 16
         DO CASE
            CASE J = 1
                 STORE VAL1 TO test
            CASE J = 2
                 STORE VAL2 TO test
            CASE J = 3
                 STORE VAL3 TO test
            CASE J = 4
                 STORE VAL4 TO test
            CASE J = 5
                 STORE VAL5 TO test
            CASE J = 6
                 STORE VAL6 TO test
            CASE J = 7
                 STORE VAL7 TO test
            CASE J = 8
                 STORE VAL8 TO test
            CASE J = 9
                 STORE VAL9 TO test
            CASE J = 10
                 STORE VAL10 TO test
            CASE J = 11
                 STORE VAL11 TO test
            CASE J = 12
                 STORE VAL12 TO test
            CASE J = 13
                 STORE VAL13 TO test
            CASE J = 14
                 STORE VAL14 TO test
            CASE J = 15
                 STORE VAL15 TO test
            CASE J = 16
                 STORE VAL16 TO test
         ENDCASE

         IF test = 1
            x1   = (J * 10) + 1
            x2   = x1 + 8
            FLINE(x1,y1,x2,y2,2,1)
         ENDIF
    NEXT
  NEXT

RETURN .T.

FUNCTION MSKLOAD2
  GO TOP
  FOR I = 1 TO 16
    row = IF(I > 16, I+3,I)
    y1  = (row * 10) + 1
    y2  = y1 + 8
    FOR J = 1 TO 16
       x1   = (J * 10) + 1
       x2   = x1 + 8
       FLINE(x1,y1,x2,y2,2,1)
    NEXT
  NEXT

RETURN .T.
                                                                                                                      