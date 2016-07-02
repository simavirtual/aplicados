FLIP_INIT(600)
CLEAR SCREEN

N=1
n_row=1
Last=0
M_file=space(20)
first_char=0
M_vert_off=7
M_ascent=11
M_height=14
M_BG=2
M_AC=3
*
M_start=32
M_end=93
*
IF FILE('fontset.mem')
   RESTORE FROM fontset additive
ENDIF
*
DO WHILE .T.
   DO WHILE .T.
      @ 12,0 SAY 'BG:         'GET M_BG PICT '99'
      @ 13,0 SAY 'Ascent col: 'GET M_AC PICT '99'
      @ 15,0 SAY 'Ascent:     'GET M_ascent PICT '99'
      @ 16,0 SAY 'Push down:  'GET M_vert_off PICT '99'
      @ 17,0 SAY 'Height:     'GET M_height PICT '99'
      @ 22,0 SAY 'File name:  'GET M_file
      READ
      IF LASTKEY()=27
         RETURN
      ENDIF
      SAVE TO fontset all Like M_*
      M_file1=TRIM(M_file)
      IF FILE(M_file1)
         dos_handle=FOPEN(M_file1)
         buffer=FREADSTR( dos_handle, 5000)
         EXIT
      ENDIF
   ENDDO
*
   FSCREEN()
   horz_pos=50
   vert_pos=35
*
   PRESS=0
   DO WHILE PRESS#27
      char=GET_NEXT()         && Character number
      if char = -999
         EXIT
      endif
      if first_char=0
         first_char=char
      endif
      x_ext=GET_NEXT()        && Extent
      y_ext=GET_NEXT()

      horz_off = ABS(x_ext)
      size=(y_ext-x_ext+1)
*
      x=0
      y=0
      last_x=-64
      last_y=-64
*
      FLINE(horz_pos, vert_pos, horz_pos+size, vert_pos+M_height, M_BG, 1)
      FLINE(horz_pos-2, vert_pos+M_ascent, horz_pos+size+2, vert_pos+M_ascent, M_AC, 0)

         DO WHILE .T.
            x=GET_NEXT()
            y=GET_NEXT()
            DO CASE
               CASE x = -64 .and. y = -64
                  EXIT
               CASE last_x = -64
               CASE x = -64
               OTHERWISE
                  FLINE(horz_pos+horz_off+last_x, vert_pos+M_vert_off+last_y, horz_pos+horz_off+x, vert_pos+M_vert_off+y, 15, 0)
            ENDCASE
            last_x=x
            last_y=y
         ENDDO
         horz_pos=horz_pos+35
         if horz_pos > 615
            horz_pos=50
            vert_pos=vert_pos+35
            SAY_TEXT(0,vert_pos+15,str(char,4,0))
         endif
         if vert_pos > 435
            SAY_TEXT(1,14,TRIM(M_file1)+'  '+str(first_char,5,0)+' - '+str(char,5,0))
*            PRT_SCREEN("LPT1", 2, "PRX.TBL", 0, 0, 639, 479)
*            EJECT
            horz_pos=50
            vert_pos=35
            first_char=0
            CLS_SCREEN()
            inkey(0)
         endif
      PRESS=INKEY()
   ENDDO
   FCLOSE(dos_handle)
   inkey(0)
   TEXTMODE()
ENDDO

FUNCTION GET_NEXT
string=""
DO WHILE   SUBSTR(buffer,N,1) = " ";
      .or. SUBSTR(buffer,N,1) = ":";
      .or. SUBSTR(buffer,N,1) = chr(10);
      .or. SUBSTR(buffer,N,1) = chr(13)
   IF N=5000
      buffer=FREADSTR( dos_handle, 5000)
      N=0
   ENDIF
   N=N+1
   LOOP
ENDDO
*
DO WHILE SUBSTR(buffer,N,1) # " ";
   .and. SUBSTR(buffer,N,1) # ":";
   .and. SUBSTR(buffer,N,1) # chr(10);
   .and. SUBSTR(buffer,N,1) # chr(13)
   string=string+SUBSTR(buffer,N,1)
   IF N=5000
      buffer=FREADSTR( dos_handle, 5000)
      N=0
   ENDIF
   N=N+1
ENDDO
RETURN val(string)
