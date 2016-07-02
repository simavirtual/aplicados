*******************************************************************************
*  S_EXAM01.PRG                                                               *
*  Author: Gary Prothero                                                      *
*  Requirements: SCANNER.OBJ                                                  *
*  Description:                                                               *
*       This is an example of scanning documents to a PCX file from an HP     *
*       SCANJET or SCANJETplus. You can also print the image.                 *
*                                                                             *
*******************************************************************************
FLIP_INIT(1,1)
SET_SAYERR(1)
*
LO             = ASC('L')  && Scanner Inquire Type
NOM            = ASC('R')
HI             = ASC('H')
*
*  result = HPS_INQ( CommandNo, Value, @Inquire )
*
SCALE          =  1
DECI_WIN       =  2
PEL_WIN        =  3
RESOLUTION     =  4
DO_DITHER      =  5
DO_GRAY_SC     =  6
INTENSITY      = 16
CONTRAST       = 17
NEGATIVE       = 18
MIRROR         = 19
AUTO_BGRND     = 20
DATA_TYPE      = 21
BITS_PER_P     = 22
DITHER_PAT     = 23
ADF_AVAILABLE  = 30
PIXELS_PER_LINE= 35
BYTES_PER_LINE = 36
LINES_PER_SCAN = 37
ADF_READY      = 38
PIXELS_PER_INCH= 39
MODEL_NUMBER   = 40

/* Scanner library function returns and error codes */
OKAY               = 0  && No Error
NO_ACCESS          = 1  && Communication Error
BAD_ACCESS         = 2
BAD_COMMAND        = 3
BAD_RESPONSE       = 4
NULL_RESPONSE      = 5
BAD_CMD_FORMAT     = 6  && Scanner Error
ILLEGAL_CMD        = 7
ILLEGAL_WND        = 8
PARAM_ERR          = 9
SCALE_ERR          = 10
DITHER_ERR         = 11
TONE_MAP_ERR       = 12
LAMP_ERR           = 13
ADF_JAM            = 14
HOME_MISSING       = 15
SCAN_ERR           = 16
HPS_FILE_OPEN_ERR  = 17
HPS_FILE_WRITE_ERR = 18
OUT_OF_MEM_ERR     = 19

CLEAR SCREEN
*
M_id = 0
M_id=SEL_PRINT(61)
*
DECLARE SCANNER[30]
AFILL(SCANNER,0)
DECLARE GRAYCOLORS[16]
SCAN_HEAD()
*
DO WHILE .T.
   @ 22,0 SAY 'Select?'
   @ 22,col()+1 PROMPT 'Flags'
   @ 22,col()+1 PROMPT 'Resolution'
   @ 22,col()+1 PROMPT 'ScanWindow'
   @ 22,col()+1 PROMPT 'PrtWindow'
   @ 22,col()+1 PROMPT 'GrayColors'
   @ 22,col()+1 PROMPT 'Reset'
   @ 22,col()+2 PROMPT 'Scan'
   @ 22,col()+1 PROMPT 'Show'
   @ 22,col()+1 PROMPT 'Print'
   MENU TO M_ans
   DO CASE
      CASE M_ans = 0
         EXIT
      CASE M_ans = 7
         M_status = HPS_OPEN( NOM, 0 )
         DO CASE
            CASE M_status = 1
               @ 0,30 SAY '** Error '+ALLTRIM(STR(M_status,3))+': Driver not installed.'
            CASE M_status = 2
               @ 0,30 SAY '** Error '+ALLTRIM(STR(M_status,3))+': Is scanner turned off.'
         ENDCASE
         IF FILE("GARY.PCX")
            ERASE GARY.PCX
         ENDIF
         M_status = HPS_SCAN( "GARY.PCX" )
         IF M_status > 0
            @ 0,30 SAY '** Error '+ALLTRIM(STR(M_status,3))+'Scanner did not complete.'
            TONE(380,2)
            INKEY(0)
         ENDIF
         M_status = HPS_CLOSE()
      CASE M_ans = 8
         CLEAR SCREEN
         DECLARE HEADER[12]
         PCX_HEADER("GARY.PCX",HEADER)
         @ 06,01 TO 23,40
         @ 07,02 SAY '          Header information'
         @ 09,02 SAY 'Manufacturer '+CHR(16)+' '+ALLTRIM(STR(HEADER[01],05))
         @ 10,02 SAY 'Version      '+CHR(16)+' '+ALLTRIM(STR(HEADER[02],05))
         @ 11,02 SAY 'Encoding     '+CHR(16)+' '+ALLTRIM(STR(HEADER[03],05))
         @ 12,02 SAY 'Bits/pel     '+CHR(16)+' '+ALLTRIM(STR(HEADER[04],05))
         @ 13,02 SAY 'Left         '+CHR(16)+' '+ALLTRIM(STR(HEADER[05],05))
         @ 14,02 SAY 'Top          '+CHR(16)+' '+ALLTRIM(STR(HEADER[06],05))
         @ 15,02 SAY 'Right        '+CHR(16)+' '+ALLTRIM(STR(HEADER[07],05))
         @ 16,02 SAY 'Bottom       '+CHR(16)+' '+ALLTRIM(STR(HEADER[08],05))
         @ 17,02 SAY 'Horz res     '+CHR(16)+' '+ALLTRIM(STR(HEADER[09],05))
         @ 18,02 SAY 'Vert res     '+CHR(16)+' '+ALLTRIM(STR(HEADER[10],05))
         @ 19,02 SAY 'N/planes     '+CHR(16)+' '+ALLTRIM(STR(HEADER[11],05))
         @ 20,02 SAY 'Bytes/line   '+CHR(16)+' '+ALLTRIM(STR(HEADER[12],05))
         @ 22,02 SAY 'Press any key or <Esc> to Quit ......'
         INKEY(0)
*
         TOP0=00
         LEF0=00
         RIAR=60
         LFAR=60
         PGUP=50
         PGDN=50
         CLR = 0
*
         FSCREEN()
         DO WHILE .T.
            CLS_SCREEN()
            FPCX_PUT( LEF0, TOP0, 'P', "GARY.PCX", 15, 0 )
            INKEY(0)
            IF LASTKEY()=27
               EXIT
            ENDIF
            IF LASTKEY()=08 .OR. LASTKEY()=19
               LEF0=LEF0-LFAR
            ENDIF
            IF LASTKEY()=09 .OR. LASTKEY()=04
               LEF0=LEF0+RIAR
            ENDIF
            IF LASTKEY()=18 .OR. LASTKEY()=05
               TOP0=TOP0-PGUP
            ENDIF
            IF LASTKEY()=24 .OR. LASTKEY()=03
               TOP0=TOP0+PGDN
            ENDIF
            IF LASTKEY()=01
               LEF0=0
               TOP0=0
            ENDIF
         ENDDO
         TEXTMODE()
      CASE M_ans = 9          &&  PRINT
         DO WHILE PRT_CHECK(0) == 0
            @ 0,30 SAY 'Printer not ready. <Tap any key>'
            TONE(380,2)
            INKEY(0)
            IF LASTKEY() = 27
               EXIT
            ENDIF
         ENDDO
         IF LASTKEY() = 27
            LOOP
         ENDIF
         SET CONSOLE OFF
         IF M_id > 0
            PRT_STAT(1)
            LINES = MPRT_OPEN(SCANNER[27]*100,SCANNER[28]*100)
            FOR I = 1 TO LINES
               MPRT_SWATH(I)
               FPCX_PUT( 0, 0, 'P', "GARY.PCX" )
               MPRT_SCRN( 100, 100, SCANNER[25]*100, SCANNER[26]*100 )
               IF PRT_ESCAPE()=1
                  EXIT
               ENDIF
            NEXT
            MPRT_CLOSE()
            SET CONSOLE ON
            EJECT
         ENDIF
      OTHERWISE
         SCAN_EDIT(M_ans)
   ENDCASE
   SCAN_HEAD()
ENDDO

FUNCTION SCAN_HEAD
HPS_STATE(SCANNER)
CLEAR SCREEN
@ 01,01 to 20,78 double
@ 02,02      SAY 'Data           '+CHR(16)+' '+ALLTRIM(STR(SCANNER[01],05))
@ row()+1,02 SAY 'Dither pattern '+CHR(16)+' '+ALLTRIM(STR(SCANNER[02],05))
@ row()+1,02 SAY 'Intensity      '+CHR(16)+' '+ALLTRIM(STR(SCANNER[03],05))
@ row()+1,02 SAY 'Contrast       '+CHR(16)+' '+ALLTRIM(STR(SCANNER[04],05))
@ row()+1,02 SAY 'Negative       '+CHR(16)+' '+ALLTRIM(STR(SCANNER[05],05))
@ row()+1,02 SAY 'Mirror         '+CHR(16)+' '+ALLTRIM(STR(SCANNER[06],05))
@ row()+1,02 SAY 'Auto back      '+CHR(16)+' '+ALLTRIM(STR(SCANNER[07],05))
@ row()+1,02 SAY 'X resolution   '+CHR(16)+' '+ALLTRIM(STR(SCANNER[08],05))
@ row()+1,02 SAY 'Y resolution   '+CHR(16)+' '+ALLTRIM(STR(SCANNER[09],05))
@ row()+1,02 SAY 'X scale        '+CHR(16)+' '+ALLTRIM(STR(SCANNER[10],05))
@ row()+1,02 SAY 'Y scale        '+CHR(16)+' '+ALLTRIM(STR(SCANNER[11],05))
@ 14,19 SAY '<--Scanner-->'
@ 15,02        SAY 'X left         '+CHR(16)+' '+STR(SCANNER[20]/300,5,2)+' inches'
@ row()+1,02   SAY 'Y top          '+CHR(16)+' '+STR(SCANNER[21]/300,5,2)+' inches'
@ row()+1,02 SAY 'X offset       '+CHR(16)+' '+STR(SCANNER[22]/300,5,2)+' inches'
@ row()+1,02 SAY 'Y offset       '+CHR(16)+' '+STR(SCANNER[23]/300,5,2)+' inches'
SCANNER[27] = SCANNER[22]/300*SCANNER[10]/100
SCANNER[28] = SCANNER[23]/300*SCANNER[11]/100
@ 14,36 SAY '<--Printer-->'
@ 15,36      SAY STR(SCANNER[25],5,2)+' inches'
@ row()+1,36 SAY STR(SCANNER[26],5,2)+' inches'
@ row()+1,36 SAY STR(SCANNER[27],5,2)+' inches'
@ row()+1,36 SAY STR(SCANNER[28],5,2)+' inches'
@ 02,33 SAY '<----File Size---->'
@ 03,33 SAY 'Model          '+CHR(16)+' '+ALLTRIM(SCANNER[13])
@ row()+1,33 SAY 'Auto feed      '+CHR(16)+' '+IIF(SCANNER[14]=1,'Yes','No')
@ row()+1,33 SAY 'Bits per pel   '+CHR(16)+' '+ALLTRIM(STR(SCANNER[12],05))
@ row()+1,33 SAY 'Columns        '+CHR(16)+' '+ALLTRIM(STR(SCANNER[15],05))
@ row()+1,33 SAY 'Bytes          '+CHR(16)+' '+ALLTRIM(STR(SCANNER[16],05))
@ row()+1,33 SAY 'Rows           '+CHR(16)+' '+ALLTRIM(STR(SCANNER[17],05))
@ row()+1,33 SAY 'Size           '+CHR(16)+' '+ALLTRIM(STR(SCANNER[18],10))
@ row()+1,33 SAY 'PCX image      '+CHR(16)+' '+IIF(SCANNER[24]=1,'Yes','No')
HPS_COLOR(GRAYCOLORS)
@ 02,63 SAY '<-Gray Color->'
FOR I=1 TO 16
   @ row()+1,65 SAY STR(I-1,2)+' '+CHR(16)
   @ row(),col()+1 SAY GRAYCOLORS[I] PICT '99'
NEXT

FUNCTION SCAN_EDIT
PARAMETER M_edit
DO CASE
   CASE M_edit = 1
      @ 02,19 GET SCANNER[01] PICT '9'   && data
      @ row()+1,19 GET SCANNER[02] PICT '9'   && dither
      @ row()+1,19 GET SCANNER[03] PICT '9'   && intensity
      @ row()+1,19 GET SCANNER[04] PICT '9'   && contrast
      @ row()+1,19 GET SCANNER[05] PICT '9'   && negative
      @ row()+1,19 GET SCANNER[06] PICT '9'   && mirror
      @ row()+1,19 GET SCANNER[07] PICT '9'   && autoback
      READ
      IF UPDATED()
         M_status = HPS_SETUP( DATA_TYPE, SCANNER[1] )
         M_status = HPS_SETUP( DITHER_PAT, SCANNER[2] )
         M_status = HPS_SETUP( INTENSITY, SCANNER[3] )
         M_status = HPS_SETUP( CONTRAST, SCANNER[4] )
         M_status = HPS_SETUP( NEGATIVE, SCANNER[5] )
         M_status = HPS_SETUP( MIRROR, SCANNER[6] )
         M_status = HPS_SETUP( AUTO_BGRND, SCANNER[7] )
      ENDIF
   CASE M_edit = 2
      @ 09,19 GET SCANNER[08] PICT '999'   && X resolution
      @ row()+1,19 GET SCANNER[09] PICT '999'   && Y resolution
      @ row()+1,19 GET SCANNER[10] PICT '999'   && X scale
      @ row()+1,19 GET SCANNER[11] PICT '999'   && Y scale
      READ
      IF UPDATED()
         M_status = HPS_SETUP( RESOLUTION, SCANNER[08], SCANNER[09] )
         M_status = HPS_SETUP( SCALE, SCANNER[10], SCANNER[11] )
      ENDIF
   CASE M_edit = 3
      M_x1 = SCANNER[20] / 300
      M_y1 = SCANNER[21] / 300
      M_xoffset = SCANNER[22] / 300
      M_yoffset = SCANNER[23] / 300
      @ 15,19 GET M_x1 PICT '99.99'          && X window
      @ row()+1,19 GET M_y1 PICT '99.99'          && Y window
      @ row()+1,19 GET M_xoffset PICT '99.99'     && X offset
      @ row()+1,19 GET M_yoffset PICT '99.99'     && Y offset
      READ
      IF UPDATED()
         SCANNER[20] = M_x1 * 300
         SCANNER[21] = M_y1 * 300
         SCANNER[22] = M_xoffset * 300
         SCANNER[23] = M_yoffset * 300
         M_status = HPS_SETUP( PEL_WIN, SCANNER[20], SCANNER[21], SCANNER[22], SCANNER[23] )
         HPS_PRINT( SCANNER[27], SCANNER[28] )
      ENDIF
   CASE M_edit = 4
      @ 15,36 GET SCANNER[25] PICT '99.99'     && X window
      @ row()+1,36 GET SCANNER[26] PICT '99.99'     && Y window
      @ row()+1,36 GET SCANNER[27] PICT '99.99'     && X offset
      @ row()+1,36 GET SCANNER[28] PICT '99.99'     && Y offset
      READ
      IF UPDATED()
         HPS_PRINT( SCANNER[27], SCANNER[28] )
      ENDIF
   CASE M_edit = 5
      DO WHILE .T.
         @ 02,69 SAY ''
         FOR I=1 TO 16
            @ row()+1,70 GET GRAYCOLORS[I] PICT '99'
            @ row(),75 SAY SET_PAL(I-1) PICT '99'
         NEXT
         READ
         IF LASTKEY()=27
            EXIT
         ENDIF
         IF LASTKEY()=3
            FSCREEN()
            CLS_SCREEN()
            FOR I=0 TO 15
               LINE_JUST(2)
               SAY_TEXT(ATX(10,0),ATY(I*5,0)+10,str(I,2)+'-')
               PAT_SETFIL( 1 )
               FBOX( ATX(10,0), ATY(I*5,0)+2, ATX(10,0)+100, ATY(I*5,0)+10, I)
               LINE_JUST(0)
               SAY_TEXT(ATX(10,0)+100,ATY(I*5,0)+10,'-'+str(SET_PAL(I),2))
            NEXT
            PAT_SETFIL( 0 )
            INKEY(0)
            TEXTMODE()
         ENDIF
         IF UPDATED()
            HPS_COLOR(GRAYCOLORS)
            AFILL(GRAYCOLORS,.f.)
            HPS_COLOR(GRAYCOLORS)
         ENDIF
      ENDDO
   CASE M_edit = 6
      HPS_RESET()
      SCANNER[27] = SCANNER[22] / 300
      SCANNER[28] = SCANNER[23] / 300
      HPS_PRINT( SCANNER[27], SCANNER[28] )
ENDCASE

FUNCTION PRT_STATUS
@ 0,70 SAY STR(RET_PRTDN(),3,0)+'%'
IF INKEY()=27
   PRT_ESCAPE(1)
ENDIF

FUNCTION SEL_PRINT
PARAMETER M_dflt
number = PRT_LIST("C:\FLIPPER\LIBRARY\PRX_TBL.BIN")
DECLARE PRINT_NAME[number], SELECTABLE[number]
PRT_LIST( PRINT_NAME )
@ 3, 9 TO 22, 41 DOUBLE
M_id = 0
M_printer = ACHOICE(4,10,21,40,PRINT_NAME,.T.,"",M_dflt)
IF M_printer > 0
   M_id = VAL( SUBSTR( PRINT_NAME[M_printer], 1, 4 ) )
   PRT_LOAD(M_id,"LPT1")
ENDIF
RETURN(M_id)

