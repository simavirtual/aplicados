FLIP_INIT(600)
CLEAR SCREEN
SET_SAYERR(1)
N=1
n_row=1
Last=0
M_file="cartogrf.her"
M_ofile="SIM1_16.#   "
first_char=0
vert_off=7
M_ascent=11
M_height=14
M_BG=2
M_AC=3
*
M_start=32
M_end=93
*
*DO WHILE .T.
   DO WHILE .T.
      @ 12,0 SAY 'BG:         'GET M_BG PICT '99'
      @ 13,0 SAY 'Ascent col: 'GET M_AC PICT '99'
      @ 15,0 SAY 'Ascent:     'GET M_ascent PICT '99'
      @ 16,0 SAY 'Push down:  'GET vert_off PICT '99'
      @ 17,0 SAY 'Height:     'GET M_height PICT '99'
      @ 19,0 SAY 'Start chr:  'GET M_start PICT '999'
      @ 20,0 SAY 'End chr:    'GET M_end PICT '999'
      @ 22,0 SAY 'File name:  'GET M_file
      @ 23,0 SAY 'Out File:   'GET M_ofile
      READ
      IF LASTKEY()=27
         RETURN
      ENDIF
      M_file1=TRIM(M_file)
      IF FILE(M_file1)
         dos_handle=FOPEN(M_file1)
         buffer=FREADSTR( dos_handle, 5000)
         EXIT
      ENDIF
   ENDDO
*
   FSCREEN()
   SAY_TEXT(1,14,M_file1)
   horz_pos=35
   vert_pos=35

   HERSTART(-4000, M_start, M_end)
*
   DO WHILE .T.
      char=GET_NEXT()         && Character number
      if char = -999
         EXIT
      endif
      first_char=first_char+1
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
      FLINE(horz_pos, vert_pos, horz_pos+size, vert_pos+M_height, M_BG, 2)
      FLINE(horz_pos-2, vert_pos+M_ascent, horz_pos+size+2, vert_pos+M_ascent, M_AC, 0)

         DO WHILE .T.
            x=GET_NEXT()
            y=GET_NEXT()
            DO CASE
               CASE x = -64 .and. y = -64
                  EXIT
               CASE last_x = -64
                  HERLETTER( char, horz_off+x, vert_off+y, 0, size)
               CASE x = -64
               OTHERWISE
                  FLINE(horz_pos+horz_off+last_x, vert_pos+vert_off+last_y, horz_pos+horz_off+x, vert_pos+vert_off+y, 15, 0)
                  HERLETTER( char, horz_off+x, vert_off+y, 1, size)
            ENDCASE
            last_x=x
            last_y=y
         ENDDO
         horz_pos=horz_pos+35
         if horz_pos > 615
            horz_pos=35
            vert_pos=vert_pos+35
         endif
         if vert_pos > 455
            inkey(0)
            horz_pos=35
            vert_pos=35
         endif
   ENDDO
   inkey(0)
   TEXTMODE()
   HERWRITE(M_ofile, M_ascent, M_height)
*ENDDO


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