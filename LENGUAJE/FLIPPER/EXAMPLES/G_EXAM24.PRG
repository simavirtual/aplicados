*******************************************************************************
*  G_EXAM24.PRG                                                               *
*  Requirements: Some free disk space, optional PCX file.                     *
*  Description:                                                               *
*        This program demonstrates the use of the picture saving functions.   *
*        You can save pictures in Flipper's own 'PIC' format, or in the 'PCX' *
*        format.  You can even convert between the two.  You can also have    *
*        multiple pictures being used on separate video pages.                *
*  Chapter 9, Saving Pictures                                                 *
*******************************************************************************
FLIP_INIT(600)
SET MESSAGE TO 23
M_open=.f.
M_index=0
M_avail=0
M_type=1
M_index=0
USE TEST
IF FILE('TESTPIC.PIC')
   pic_handle=FPIC_OPEN("TESTPIC.PIC")
ELSE
   pic_handle=FPIC_CREAT("TESTPIC.PIC",25)
ENDIF
*
M_ans=1
DO WHILE .T.
   CLEAR
   TEXT
   ***********************************************************************
   * Saving and retrieving pictures in files:                            *
   *                                                                     *
   *  pic_handle=FPIC_CREAT("file name",number of pictures)              *
   *  pic_handle=FPIC_OPEN("file name")                                  *
   *  FPIC_CLOSE(pic_handle)                                             *
   *  index=FPIC_GET(x1,y1,x2,y2,index,pic_handle)                       *
   *  FPIC_PUT(x,y,index,pic_handle)                                     *
   *  FPIC_DEL(index)                                                    *
   *  FPIC_PACK("file name","temp file")                                 *
   *                                                                     *
   *  This example displays a graph and allows you to save it to a       *
   *  picture number in a file, then recall the graph back to the screen.*
   ***********************************************************************
   ENDTEXT
   INITDATA(2)
*
   SET_TYPE(1,1)
   GOTO TOP
   DO WHILE .not. EOF()
      STORE_DATA(xnumber,number1)
      SKIP
   ENDDO
*
   M_picmode=RET_PICTYP(pic_handle)
   @ 19,50 SAY 'File mode: '+IF(M_picmode=1,'4 color CGA',IF(M_picmode=9,'Black & White','4 video planes'))
   @ 20,50 SAY 'File size: '+STR(RET_FSIZE(pic_handle),3)
   @ 21,50 SAY 'Last index:'+STR(M_index,3)
   @ 22,0 PROMPT 'Save' MESSAGE 'Displays then saves the picture to the first available file location'
   @ 22,COL()+2 PROMPT 'Display' MESSAGE 'Displays a saved picture'
   @ 22,COL()+2 PROMPT 'Delete' MESSAGE 'Delete a saved picture from file'
   @ 22,COL()+2 PROMPT 'Pack' MESSAGE 'Pack the file to remove picture and reduce file size'
   @ 22,COL()+2 PROMPT 'PCX HEADER' MESSAGE 'Show pcx header information'
   @ 22,col()+2 PROMPT 'PCX DIRECT' MESSAGE 'Show PCX file direct to screen'
   @ 22,col()+2 PROMPT 'PIC->PCX' MESSAGE 'Write PIC to a PCX file'
   @ 22,col()+2 PROMPT 'PCX->PIC' MESSAGE 'Write PCX to a PIC index'
   @ 22,col()+2 PROMPT 'Palette' MESSAGE 'Set the color palette'
   MENU TO M_ans
*
   DO CASE
      CASE M_ans=0
         FPIC_CLOSE(pic_handle)
         EXIT
      CASE M_ans=1
*
         M_ind1=0
         M_x1=0
         M_y1=0
         M_x2=100
         M_y2=100
         clear screen
         @ 19,0 CLEAR
         @ 19,0 say 'Index number: 'GET M_ind1 pict '99'
         @ 21,0 SAY 'Upper left (0-100):'
         @ 21,col()+2 GET M_x1 pict '999' RANGE 0,100
         @ 21,col()+2 GET M_y1 pict '999' RANGE 0,100
         @ 22,0 SAY 'Lower right (0-100):'
         @ 22,col()+2 GET M_x2 pict '999' RANGE 0,100
         @ 22,col()+2 GET M_y2 pict '999' RANGE 0,100
         READ
         IF LASTKEY()=27
            loop
         ENDIF
*
         SET_TYPE(1,M_type)
         PLOT()
*
         M_index=FPIC_GET( ATX(M_x1,2), ATY(M_y1,2), ATX(M_x2,2), ATY(M_y2,2), M_ind1, pic_handle )
*
         SAY_TEXT(100,100,'Bios mode:'+STR(RET_BIOS(),3))
         SAY_TEXT(100,110,'Pic type: '+STR(RET_PICTYP(pic_handle),3))
         SAY_TEXT(100,120,'Index:    '+STR(M_index,2))
         inkey(0)
         TEXTMODE()
      CASE M_ans=2
         @ 22,0
         @ 22,0 SAY 'Enter picture index: 'GET M_index PICT '99'
         READ
*
         IF LASTKEY()=27
            LOOP
         ENDIF
*
         IF IS_FINDEX(pic_handle,M_index) = 1
            FSCREEN()
            FPIC_PUT(0,0,M_index,pic_handle)
            SAY_TEXT(100,100,'Bios mode:'+STR(RET_BIOS(),3))
            SAY_TEXT(100,110,'Pic type: '+STR(RET_PICTYP(pic_handle),3))
            inkey(0)
            TEXTMODE()
         ELSE
            @ 23,0 SAY 'No picture for index '+str(M_index,3)
            wait
         ENDIF
      CASE M_ans=3
         @ 22,0
         @ 22,0 SAY 'Enter picture index: 'GET M_index PICT '99'
         READ
*
         IF LASTKEY()=27
            LOOP
         ENDIF
         FPIC_DEL(M_index,pic_handle)
      CASE M_ans=4
         FPIC_CLOSE(pic_handle)
         FPIC_PACK("TESTPIC.PIC","TEMP.PIC")
         FPIC_OPEN("TESTPIC.PIC")
*      CASE M_ans=5
*         @ 20,0 CLEAR
*         @ 22,0 SAY 'Index:   'GET M_avail PICT '999'
*         READ
*         @ 22,60 SAY IF(IS_FINDEX(pic_handle,M_avail)=1,'Index occupied','Index open')
*         inkey(0)
      CASE M_ans=5
         @ 3,0 CLEAR
         M_name=space(20)
         DECLARE HEADER[12]
         @ 22,0 SAY 'PCX File Name: 'GET M_name
         READ
         PCX_HEADER(M_name, HEADER)
         @ 5,10 SAY 'Mfg:        '+STR(HEADER[1],5)
         @ 6,10 SAY 'Version:    '+STR(HEADER[2],5)
         @ 7,10 SAY 'Encoding:   '+STR(HEADER[3],5)
         @ 8,10 SAY 'Bits/pel:   '+STR(HEADER[4],5)
         @ 9,10 SAY 'left:       '+STR(HEADER[5],5)
         @ 10,10 SAY 'top:        '+STR(HEADER[6],5)
         @ 11,10 SAY 'right:      '+STR(HEADER[7],5)
         @ 12,10 SAY 'bottom:     '+STR(HEADER[8],5)
         @ 13,10 SAY 'Horz res:   '+STR(HEADER[9],5)
         @ 14,10 SAY 'Vert res:   '+STR(HEADER[10],5)
         @ 15,10 SAY 'N planes:   '+STR(HEADER[11],5)
         @ 16,10 SAY 'Bytes/line: '+STR(HEADER[12],5)
         inkey(0)
      CASE M_ans=6
         M_x=0
         M_y=0
         M_type='P'
         M_name=space(20)
         @ 20,0 CLEAR
         @ 20,0 SAY 'X,Y position:  'GET M_x PICT '9999'
         @ 20,col()+2 GET M_y PICT '9999'
         @ 21,0 SAY 'Type (PAOXR):  'GET M_type PICT 'A' valid M_type$'PAOXR'
         @ 22,0 SAY 'PCX File Name: 'GET M_name
         READ
         FSCREEN()
         CLS_SCREEN(15)
         FPCX_PUT( M_x, M_y, M_type, TRIM(M_name) )
         inkey(0)
         TEXTMODE()
      CASE M_ans=7
         M_name=space(20)
         M_x1=0
         M_y1=0
         M_x2=GRMAX_X()
         M_y2=GRMAX_Y()
         @ 20,0 CLEAR
         @ 21,0 SAY 'Which Index number: 'GET M_avail PICT '999'
         @ 22,0 SAY 'PCX File Name:      'GET M_name
         READ
         IF IS_FINDEX(pic_handle,M_avail) = 1
            PIC_TO_PCX( pic_handle, M_avail, TRIM(M_name), 4, GRMAX_X(), GRMAX_Y())
         ELSE
            @ 22,60 SAY 'No picture'
            ? chr(7)
            inkey(0)
         ENDIF
      CASE M_ans=8
         M_name=space(20)
         @ 20,0 CLEAR
         @ 21,0 SAY 'Which Index number: 'GET M_avail PICT '999'
         @ 22,0 SAY 'PCX File Name:      'GET M_name
         READ
         IF IS_FINDEX(pic_handle,M_avail) = 1
            @ 22,60 SAY 'Picture already there'
            ? chr(7)
            inkey(0)
         ELSE
            PCX_TO_PIC(pic_handle,M_avail,M_name)
         ENDIF
      CASE M_ans=9
         M_pal=0
         M_color=0
         DO WHILE LASTKEY()#27
            CLEAR
            I=0
            J=0
            @ 2+I,6 say 'Palette  '+IF(RET_HP()=1,'Pen','Color')
            @ 3+I,6 say '-------  -----'
            FOR I=0 to 15
               @ 4+I,8 say I PICT '99'
               @ 4+I,16 say STR(SET_PAL(I),2)
            NEXT
            @ 22,0 SAY 'Enter Palette number and '+IF(RET_HP()=1,'Pen','Color')
            @ 22,32 GET M_pal pict '99'
            @ 22,36 GET M_color pict '99'
            @ 24,0 SAY 'PgDn to see palette, Escape to exit back to the Main menu'
            READ
            IF LASTKEY()=3
               FSCREEN()
               CLS_SCREEN()
               FOR I=0 TO 15
                  LINE_JUST(2)
                  SAY_TEXT(ATX(10,0),ATY(I*5,0)+10,str(I,2)+'-')
                  PAT_SETFIL(1)
                  FBOX(ATX(10,0),ATY(I*5,0)+2,ATX(10,0)+100,ATY(I*5,0)+10,I )
                  PAT_SETFIL(0)
                  LINE_JUST(0)
                  SAY_TEXT(ATX(10,0)+100,ATY(I*5,0)+10,'-'+str(SET_PAL(I),2))
               NEXT
               INKEY(0)
               TEXTMODE()
            ELSE
               IF UPDATED()
                  SET_PAL(M_pal,M_color)
               ENDIF
            ENDIF
         ENDDO
   ENDCASE
ENDDO