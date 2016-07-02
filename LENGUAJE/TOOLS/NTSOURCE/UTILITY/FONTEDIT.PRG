*********** Sample programs for Nantucket Tools II / 5.0 ************
*
* Program     : FONTEDIT.PRG
* Copyright   : (c) 1991, Nantucket  Corp.  All rights reserved.
* Date        : 12/23/90
* Author      : Lothar Bongartz
* Description : Font editor for EGA/VGA screen fonts
* Compiling   : CLIPPER FONTEDIT
* Linking     : RTLINK FI FONTEDIT, NT2US50 LIB NT250
* Remarks     : /
*
*******************************************************************

author := "Lothar Bongartz"

 PARAMETERS fontfile_in, fontfile_out, set_pixel

 info := "Font editor for Nantucket TOOLS II, " +author +" 1989 - 1991"

 DO CASE
  CASE MAXFONT() = 0
   ? info
   ? "Screen adapter not suitable"
   QUIT
  CASE MAXCOL() < 79
   ? info
   ? "Screen mode not suitable"
   QUIT
 ENDCASE

 IF VALTYPE(set_pixel) <> "U"
  set_pixel := VAL(set_pixel)
  ScnPixel  := (MAXROW() +1) * CHARPIX()
  temp      := ScnPixel /24
  IF set_pixel < 5 .OR. set_pixel >= temp
    ? info
    ? "Pixel parameter has to be >= 5 and < " +NTOC(temp)+"."
    QUIT
  ENDIF
 ELSE
  set_pixel := 0
 ENDIF

 Font_Mask := "*.0*"                    // file mask for font files
 write_com := .T.                       // create auto loading (.COM) file?
 old_caps  := KSETCAPS(.F.)             // Caps lock off, save setting

 Esc       := 27
 crlf      := CHR(13) +CHR(10)          // "carriage return, line feed"
 void      := .T.                       // return for functions without return value


 CSETREF(.T.)                           // no return at reference
 READINSERT(.T.)                        // insert mode ON
 CSETSNOW(.F.)                          // no 'SNOW' delay neccessary
 SETBOXGROW(4)                          // draw boxes with delay
 SET SCOREBOARD OFF
 WSTEP(1, 1)                            // interactive stepwise window moving

 SET DECIMALS TO 0

 SETCANCEL(.F.)                         // no Alt-C
 SETKXLAT(3, Esc)                       // Ctrl-C (not PgDn!) to Esc
 SETKXLAT(302, Esc)                     // Alt-C

*SETKXLAT(301, Esc)                     // Alt-X to Esc could be disturbing
                                        // in Clipper debugger!

 SET MARGIN TO 2                        // printer margin
 PMAXROW := 65                          // printer page length
 SETTAB(8)                              // TAB width (for help text)
 SETPAGE(0)                             // 1st screen page active
 PAGECOPY(0, 1)                         // save 1st screen page to 2nd page
 PageSize := SCREENSIZE()

 SETCLEARB(" ")                         // delete with ' '


 DECLARE num[8]

 menu_max := 6                          // max. 10!
 DECLARE menu_label[menu_max]
 *              = "*********"           // max. length: 9
 menu_label[01] := "READ"
 menu_label[02] := "SAVE"
 menu_label[03] := "PRINT"
 menu_label[04] := "ROM FONT"
 menu_label[05] := "?GA MODES"
 menu_label[06] := "PX HEIGHT"

 row_menu_max := 3                       // max. 10!
 DECLARE row_menu_label[row_menu_max]
 *                  = "*********"       // max. length: 9
 row_menu_label[01] := "DUPLICATE"
 row_menu_label[02] := "INSERT"
 row_menu_label[03] := "DELETE"

 DO CASE
  CASE ISVGA()
   mode_max := 3
   DECLARE mode_label[mode_max]
   mode_label[01] := " 8"
   mode_label[02] := "14"
   mode_label[03] := "16"
  CASE ISEGA()
   mode_max := 2
   DECLARE mode_label[mode_max]
   mode_label[01] := " 8"
   mode_label[02] := "14"
  OTHERWISE                              // MCGA
   mode_max := 0
 ENDCASE

 mode_command := mode_max
 menu_command := 1
 row_command  := 1
 menu_font    := 1


 DECLARE fkey_label[11]
 *              = "**********"          // max. length: 9
 fkey_label[01] := "HELP"
 fkey_label[02] := "FONTS"
 fkey_label[03] := "LINES"
 fkey_label[04] := "COLUMNS"
 fkey_label[05] := "MIRRORING" +CHR(18)  // rows
 fkey_label[06] := "MIRRORING" +CHR(29)  // columns
 fkey_label[07] := "ROTATE"
 fkey_label[08] := "INVERT"
 fkey_label[09] := "COPY"
 fkey_label[10] := "ORIGINAL"
 fkey_label[11] := "OVERLAY"

 message_window := .F.                // no window open for messages
 move_flag      := .F.                // window not relocatable interactively

*****************************************************************************

 Pixel       := CHARPIX()
 lScroll     := ( Pixel > 16 .OR. MAXROW(.T.) < 24 )
 lSynchMode  := .T.

 cPatience   := "please be patient ....  "
 memory      := "RAM-FONT"               // default for font source

 screen_sep  := CHR(221)                 // "Ý" for screen partitioning

 bit_add     := CHR(144)                 // " " CHR(32) +144 -> "°"CHR(176)
 bit_string  := REPLICATE(CHR(75), 8)    //     CHR(75) +144 -> "Û"CHR(219)
 bit_printer := REPLICATE(CHR(176), 8)   // for printer

 warn_sound  := I2BIN(300) +I2BIN( 10);  // to relax  ...
              + I2BIN(400) +I2BIN( 10);  // tone frequency in hertz,
              + I2BIN(500) +I2BIN( 10);  // tone duration in 1/100 seconds
              + I2BIN(600) +I2BIN( 10);
              + I2BIN(700) +I2BIN( 10);
              + I2BIN(800) +I2BIN( 10);
              + I2BIN(900) +I2BIN( 10)   // 7 tones in ascending tone frequency


* create auto loading (.COM) file?
*
 IF write_com
  * file header for separate font loader
  *
   font_head   := FILESTR("FONTLOAD.COM")
   font_offset := LEN(font_head)
 ELSE
   font_head   := ""
   font_offset := 158
 ENDIF

 help_file  := "FONTEDIT.HLP"            // file with help text

 * sequence of help texts in help file:

 font_1     :=  1                        // fontedit      1
 font_2     :=  2                        // fontedit      2
 menu_menu_ :=  3                        // menu_select   menu_command
 scrn_scree :=  4                        // scrn_mode     ScreenMode
 pixe_get_n :=  5                        // pixel_mode    get_new_pixel
 pixe_f_mod :=  6                        // pixel_mode    f_modi
 get__font_ :=  7                        // get_file_name font_mask
 get__temp  :=  8                        // get_file_name temp
 ausw_i     :=  9                        // selection     i
 rows_row_c := 10                        // rows          row_command
 cols_temp_ := 11                        // cols          temp_s
 copy_org   := 12                        // copy_font     org
 copy_sourc := 13                        // copy_font     source
 copy_desti := 14                        // copy_font     destination
 copy_lengt := 15                        // copy_font     length
 or_f_or_so := 16                        // or_font       or_source
 or_f_desti := 17                        // or_font       destination
 or_f_lengt := 18                        // or_font       length

 help_num := 18
 DECLARE help_win[help_num]

 help_text := FILESTR(help_file)         // help texts = file contents
  IF EMPTY(help_text)
    info("Help file " + help_file + " can not be found  ")
    SOUND(warn_sound)
     FOR i = 1 TO help_num
      help_win[i] := ""
     NEXT i
    info()
  ELSE
    TOKENINIT(@help_text, screen_sep)   // Token = help text
     FOR i = 1 TO help_num
      temp := TOKENNEXT()
      * remove first and last crlf:
      help_win[i] := SUBSTR(temp, 3, LEN(temp) -4)
     NEXT i
  ENDIF
 RELEASE help_text

 InHelp   := .F.
 InSelect := .F.

 cur_asc    := ASC("A")                // first character
 cur_row    := 1                       // Pixel position row (base 1)
 cur_col    := 1                       // Pixel position column (base 1)
 cur_cursor := 0

 or_source  := "_ "                    // default overlay character
 first_time := .T.                     // first time in main loop


                        *** MAIN LOOP ***


DO WHILE .T.

 SET CURSOR OFF                       // we have an own cursor

 IF lSynchMode
   FONTSELECT(1, 2)                   // normal output: font 1, intensity: 2
   font_string := GETFONT(1)          // get font ...
   SETFONT(font_string, 2)            // ... and copy in font area 2
   Pixel := CHARPIX()                 // number of pixel rows per character
 ENDIF

 IF lScroll
   SETMAXROW(pixel +8, 255)
 ENDIF

 EGAPALETTE("W+", "W")                    // turn off intensity

 org_string := font_string
 font_len   := LEN(font_string)

 IF ISCOLOR()
   Color_1    := "W /B, B/W, R,, W /R"
   Color_2    := "W+/B, W/B,  ,, W+/R" // intensity only for font selection
   curs_c_on  := COLORTON("R")         // create edit cursor
   curs_c_off := COLORTON("W/B")       // delete edit cursor
   show_c_on  := COLORTON("B/W")       // SHOWKEY colors =
   show_c_off := COLORTON("W/B")       // normal + intensity of Color_1
 ELSE
   Color_1    := "W /N, N/W, W,, W /N"
   Color_2    := "W+/N, W/N,  ,, W+/N" // intensity only for font selection
   curs_c_on  := COLORTON("N/W")       // create edit cursor
   curs_c_off := COLORTON("W/N")       // delete edit cursor
   show_c_on  := COLORTON("N/W")       // SHOWKEY colors =
   show_c_off := COLORTON("W/N")       // normal + intensity of Color_1
 ENDIF

 SET COLOR TO &Color_1
 CLEAR

 set_bit  := .F.                       // set pixel : no
 bit_pic  := "0"                       // pixel display character
 set_drag := .F.

 FOR i = 1 TO 11
   STANDARD()                         // standard color parameter
   @ 2 * (i -1) +1,67 SAY STR(i, 2)   // function key number
   ENHANCED()                         // enhanced color parameter

   *  pad with spaces to total length

   cOldColor := SETCOLOR()
   SET COLOR TO w/rb
    @ 2 * (i -1) +1,69 SAY " " +PADRIGHT(fkey_label[i], 10)
   SETCOLOR(cOldColor)
 NEXT i

 ENHANCED()                             // enhanced color parameter
  @ 0,0 SAY CENTER(info, 80, .T.)
 STANDARD()                             // standard color parameter

 info_row_2 := MAXROW()
 info_row_1 := info_row_2 -1

 WBOARD(1, 0, info_row_1 -1, 255)       // protect from window
 WMODE(.T., .T., .T., .T.)              // all 4 pages subsitutable
 WSETMOVE(.F.)                          // NOT relocatable interaktively

 DECLARE col_move[pixel]

 FOR i = 1 to pixel                        // default: italic
   col_move[i] := INT((1 +pixel /2 -i) /3) // 1st number > : to the right
 NEXT i                                    // last number <: toggle more

 IF first_time
   first_time := .F.
   NoPixelCng := .T.

   DO CASE
    CASE VALTYPE(fontfile_in) <> "C"
     fontfile_in := memory
    CASE .NOT. font_load(fontfile_in)
     fontfile_in := memory
    OTHERWISE
     _UPPER(@fontfile_in)
   ENDCASE

   IF VALTYPE(fontfile_out) <> "C"
     fontfile_out := fontfile_in
     changed      := .F.
   ELSE
     _UPPER(@fontfile_out)
     changed      := .T.
   ENDIF
 ENDIF

 fontfile_out := TOKEN(fontfile_out, ".", 1) + "." + NTOC(pixel, 10, 3, "0")

 font_info()
 @ info_row_1,18 SAY screen_sep
 @ info_row_2,18 SAY screen_sep

 screen_info()
 @ info_row_1,39 SAY screen_sep
 @ info_row_2,39 SAY screen_sep

 @ info_row_1,42 SAY "Pixel Mode:       Ý  Pull Mode: "
 @ info_row_2,42 SAY "Character processing:   "

 edit_w := 0
 show_set_bit()                          // show pixel set mode
 show_set_drag()

 ShowKeyOn()

 original_w := WOPEN(1, 00, pixel +6, 21, .T.)   // delete window contents
 char_box("Original")

 edit_w     := WOPEN(1, 22, pixel +6, 43, .T.)   // delete window contents
 char_box("Edit")

 asc_w      := WOPEN(1, 44, 16    +6, 65, .T.)   // delete window contents
 asc_box()

 cur_window := asc_w                  // start with the other one!

 new_asc(cur_asc)
 change_window()

 NoPixelCng := .T.                    // return to loop

 DO WHILE NoPixelCng                  // control variable pixel modification
                                      // .F.: return to main loop
  * create edit cursor
   COLORWIN(cur_row -1, 2 * cur_col -2,;
            cur_row -1, 2 * cur_col -1, curs_c_on)

   IF cur_window = edit_w
     SETRC(cur_row -1, 2 * cur_col -2)
   ELSE
     SETRC(cur_cursor)
   ENDIF

   CLEAR TYPEAHEAD
   command := INKEY(0)

   char_pic  := SUBSTR(font_string, cur_asc * pixel +1, pixel)
   temp_pic  := char_pic
   temp_font := font_string

   DO CASE                               // window independant commands
    CASE command =   9                   // TAB
      change_window()
      LOOP
    CASE command = Esc .OR. command = 0  // Esc / Alt-C
      IF ask_y_n("Exit program  ")
        IF font_string <> GETFONT(1)
          IF ask_y_n("set "+memory +"   ")
            SETFONT(font_string, 1)
          ENDIF
        ENDIF
        ask_save()
        SHOWKEY()                        // reset SHOWKEY
        SET COLOR TO                     // reset VGA border
        WACLOSE()
         IF PageSize = SCREENSIZE()
           PAGECOPY(1, 0)                // restore former screen contents
         ELSE
           CLEAR
         ENDIF
        SETRC(0)
        KSETCAPS(old_caps)               // restore caps lock
        FONTSELECT(1)                    // normal output: font 1, intensity: 1
        EGAPALETTE("W+", "W")            // intensity is back
        QUIT                             // end of program
      ENDIF
      LOOP
   CASE command = 28                     // F1 help
      DO help WITH "FONTEDIT", 0, "1"    // m_prg, m_line, m_var
      IF LASTKEY() <> Esc
        DO help WITH "FONTEDIT", 0, "2"  // 2nd help page
      ENDIF
      LOOP
   CASE command <  0                     // function keys
      DO CASE
       CASE command = -1                 // F2 fonts
         menu_select()
         IF NoPixelCng                   // control variable pixel modification
           WSELECT(0)                    // physical screen
            font_info()
           WSELECT(edit_w)               // edit
         ENDIF
       CASE command = -2                 // F3 rows
         rows()
       CASE command = -3                 // F4 columns
         cols()
       CASE command = -4                 // F5 mirroring rows
         IF .NOT. KSETCAPS()             // caps lock ON: process all char.
           FONTROTATE(@char_pic, 3, pixel)
         ELSE
           FONTROTATE(@font_string, 3, pixel)
         ENDIF
       CASE command = -5                 // F6 mirroring columns
         IF .NOT. KSETCAPS()             // caps lock ON: process all char.
           FONTROTATE(@char_pic, 2)
         ELSE
           FONTROTATE(@font_string, 2)
         ENDIF
       CASE command = -6                 // F7 rotate
         IF pixel < 8
           IF .NOT. KSETCAPS()           // caps lock ON: process all char.
            turn_pic(@char_pic)
           ELSE
            do_the_font("turn_pic")
           ENDIF
         ELSE
           off := (pixel -8) /2
           IF .NOT. KSETCAPS()           // caps lock ON: process all char.
             FONTROTATE(@char_pic, 1, pixel, off)
           ELSE
             FONTROTATE(@font_string, 1, pixel, off)
           ENDIF
         ENDIF
       CASE command = -7                 // F8 invert
         IF .NOT. KSETCAPS()             // caps lock ON: process all char.
           CHARNOT(@char_pic)
         ELSE
           CHARNOT(@font_string)
         ENDIF
       CASE command = -8                 // F9 copy
         copy_font()
       CASE command = -9                 // F10 original
         IF .NOT. KSETCAPS()             // caps lock ON: process all char.
           char_pic := SUBSTR(org_string, cur_asc * pixel +1, pixel)
         ELSE
           font_string := org_string
         ENDIF
       CASE (command < -9 .AND. ;
            command >= -19) ;
            .OR. command = -40          // F11 overlay (incl. shift-F)
         or_font()
       OTHERWISE
         LOOP
      ENDCASE
    CASE cur_window = asc_w              // Ascii Table
      DO CASE
       CASE command = 13                 // enter
         change_window()
       CASE command =  5                 // up arrow
         new_asc(cur_asc -16)
       CASE command = 19                 // left arrow
         new_asc(cur_asc  -1)
       CASE command = 24                 // down arrow
         new_asc(cur_asc +16)
       CASE command =  4                 // right arrow
         new_asc(cur_asc  +1)
       CASE command =  1                 // home
         new_asc(cur_asc  -cur_asc %16)
       CASE command =  6                 // end
         new_asc(cur_asc  -cur_asc %16 +15)
       CASE command = 18                 // PgUp
         new_asc(cur_asc %16)
       CASE command =  3                 // PgDn
         new_asc(cur_asc %16 +240)
       CASE command = 31                 // ctrl-PgUp
         new_asc(0)
       CASE command = 30                 // ctrl-PgDn
         new_asc(255)
       OTHERWISE
         new_asc(command)
      ENDCASE
     LOOP
    OTHERWISE                            // cur_window = edit_w (Edit)
     * delete edit cursor
      COLORWIN(cur_row -1, 2 * cur_col -2,;
               cur_row -1, 2 * cur_col -1, curs_c_off)

      new_row := cur_row
      new_col := cur_col

      DO CASE
       CASE command =  5                                // up
         new_row := IF(new_row > 1, new_row -1, 1)      // pixel
         drag()
       CASE command = 19                                // left
         new_col := IF(new_col > 1, new_col -1, 1)      // wrap: 8
         drag()
       CASE command = 24                                // down
         new_row := IF(new_row < pixel, new_row +1, pixel) // wrap: 1
         drag()
       CASE command =  4                                // right
         new_col := IF(new_col <8    , new_col +1, 8)   // wrap: 1
         drag()
       CASE command =  1                                // home
         new_col := 1
       CASE command =  6                                // end
         new_col := 8
       CASE command = 18                                // PgUp
         new_asc(cur_asc  -1)
       CASE command =  3                 // PgDn
         new_asc(cur_asc  +1)
       CASE command = 31                 // ctrl-PgUp
         new_row := 1
         new_col := 1
       CASE command = 30                 // ctrl-PgDn
         new_row := pixel
         new_col := 8
       CASE command = 32                 // Space
         edit_pixel(2)
         show_set_bit()                  // show pixel set mode
       CASE command = 22                 // Ins
         edit_pixel(1)
       CASE command =  7                 // Del
         edit_pixel(0)
       CASE command = 45                 // -
         set_bit  := .F.                 // set pixel : no
         bit_pic  := "0"                 // pixel display character
         show_set_bit()                  // show pixel set mode
       CASE command = 43                 // +
         set_bit  := .T.                 // set pixel : yes
         bit_pic  := "1"                 // pixel display character
         show_set_bit()                  // show pixel set mode
       CASE command = 13                 // Enter
         set_drag := .NOT. set_drag
         show_set_drag()
       OTHERWISE
*        new_asc(command)
         LOOP
      ENDCASE

      cur_row := new_row
      cur_col := new_col
   ENDCASE

   DO CASE
    CASE .NOT. NoPixelCng            // control variable pixel modification
    CASE font_string <> temp_font
      IF lSynchMode
        SETFONT(font_string, 2)
      ENDIF

      changed := .T.
      SETMAXROW(MAXROW(.T.))
       _SAYWRAP(show_string(font_string), 0, 0)  // Refresh
      SETMAXROW(MAXROW(.T.), 255)
    CASE char_pic <> temp_pic
      POSREPL(@font_string, char_pic, cur_asc * pixel +1)

      IF lSynchMode
        SETFONT(char_pic, 2, cur_asc, 1)
      ENDIF

      changed := .T.
      SETMAXROW(MAXROW(.T.))
       _SAYWRAP(show_string(font_string), 0, 0)  // Refresh
      SETMAXROW(MAXROW(.T.), 255)
   ENDCASE
 ENDDO                                            // NoPixelCng

 WACLOSE()                             // close all windows
 SHOWKEY()                             // stop caps lock monitoring
ENDDO

RETURN

**************************************************************************

FUNCTION char_box
PARAMETERS cTitle

 WBOX(4)                                // double, without delete
 ?? "    1 2 3 4 5 6 7 8"               // always a width of 8 pixel
 ?

  FOR i = 1 TO pixel
   ? STR(i, 2)
  NEXT i

 ?
 ? " " + CENTER(cTitle)
 WFORMAT(1, 2, 1, 0)                    // modify output restriction
 WBOX(5)                                // single, without delete

RETURN void

**************************************************************************

FUNCTION asc_box
 WBOX(4)                                // double, withoyt delete
 ?? "   0123456789ABCDEF"               // 16 character columns
 ?

 FOR i = 0 to 15                        // * 16 character rows =256
  ? NTOC(i, 16, 2)
 NEXT i

 WFORMAT(1, 2, 1, 0)                    // modify output restriction
 WBOX(5)                                // single, without delete

 SET COLOR TO &Color_2                  // window saves color
                                        // (color for font selection)
 _SAYWRAP(CHARNOLIST(), 0, 0)           // character string with all ASCII char.

 WSELECT(edit_w)                        // Edit

RETURN void

**************************************************************************

FUNCTION new_asc
PARAMETERS ASCII_VAL

 SETMAXROW(MAXROW(.T.))
 WSELECT(asc_w)

 @ cur_asc /16, cur_asc %16 SAY CHR(cur_asc)    // delete former cursor

 cur_asc := NUMLOW(ascii_val +256)

 UNSELECTED()
 @ cur_asc /16, cur_asc %16 SAY CHR(cur_asc)    // mark new cursor
 ENHANCED()                                     // enhanced color parameter
 cur_cursor := ROW()

 WFORMAT( 0, -3, -2, 0)                   // modify output restriction
 @ 17,02 SAY "Hex " +NTOC(cur_asc,16,2)
 @ 17,12 SAY "Dez " +STR( cur_asc,   3)
 STANDARD()                               // standard color parameter
 @ 17,09 SAY CHR(cur_asc)
 WFORMAT( 0,  3,  2, 0)                   // modify output restriction

 WSELECT(original_w)
 _SAYWRAP(show_string(org_string), 0, 0)

 WSELECT(edit_w)
 _SAYWRAP(show_string(font_string), 0, 0)

 SETMAXROW(MAXROW(.T.), 255)
RETURN void

**************************************************************************

FUNCTION show_string
PARAMETERS font
 char_pic := SUBSTR(font, cur_asc * pixel +1, pixel)
 s := ""
  FOR y = 1 TO pixel
   n := ASCPOS(char_pic, y)                      // one byte per line
   s := s +BITTOC(n, bit_string, .T.)
  NEXT y
 CHARADD(@s, bit_add)
RETURN CHARMIX(s, s)

**************************************************************************

FUNCTION print_it                       //

message_wait("print can be cancelled with >ESC<")
 DO CASE
  CASE LASTKEY() = Esc
  CASE .NOT. PRINTREADY()
   info("printer not ready")
   SOUND(warn_sound)
   info()
  CASE .NOT. KSETCAPS()                  // caps lock ON: process all characters
   SET CONSOLE OFF
   SET PRINTER ON
   char_pic := SUBSTR(font_string, cur_asc * pixel +1, pixel)
   FOR y = 1 TO pixel
     n := ASCPOS(char_pic, y)            // one byte per line
     s := BITTOC(n, bit_printer, .T.)
     ? CHARMIX(s, s)
   NEXT y
   ? "    CHR(" + NTOC(cur_asc) + ")"
   ?
   IF PROW() +2 +pixel >PMAXROW
     EJECT
   ENDIF
  OTHERWISE
   info(cPatience)
   r := ROW()
   c := COL() -2
   SET CONSOLE OFF
   SET PRINTER ON
   FOR x = 1 TO font_len STEP pixel *4
     @ r, c SAY STR((font_len -x) /pixel, 3)
     FOR y = 0 TO pixel -1
       s := ""
       FOR z = 0 TO 3
         n := ASCPOS(font_string, x +y +z *pixel)      // one byte per line
         s := s +BITTOC(n, bit_printer, .T.) +"  "
       NEXT z
       ? TRIM(CHARMIX(s, s))
     NEXT y
     ?
     FOR z = 0 TO 3
       ?? PADRIGHT("    CHR(" + NTOC((x -1) /pixel +z) + ")", 20)
     NEXT z
     ?
     IF PROW() +2 +pixel > PMAXROW
       EJECT
     ENDIF
     IF INKEY() = Esc
       EXIT
     ENDIF
   NEXT x
   IF PROW() >1
     EJECT
   ENDIF
   info()
 ENDCASE

 SET PRINTER OFF
 SET CONSOLE ON
RETURN void

**************************************************************************

FUNCTION show_set_bit                   // show pixel set mode

 WSELECT(0)                             // physical screen

  IF set_bit
    ENHANCED()                          // enhanced color parameter
    @ info_row_1, 55 SAY "ON "
    STANDARD()                          // standard color parameter
  ELSE
    @ info_row_1, 55 SAY "OFF"
  ENDIF

 WSELECT(edit_w)                        // Edit

RETURN void

**************************************************************************

FUNCTION show_set_drag

 WSELECT(0)                             // physical screen

  IF set_drag
    ENHANCED()                          // enhanced color parameter
    @ info_row_1, 75 SAY "ON "
    STANDARD()                          // standard color parameter
  ELSE
    @ info_row_1, 75 SAY "OFF"
  ENDIF

 WSELECT(edit_w)                        // Edit

RETURN void

**************************************************************************

FUNCTION turn_pic
PARAMETERS new_char_pic
PRIVAT s, i, j

 s := ""

 FOR i = 1 TO pixel
   num[i] := 0
   FOR j = 1 TO pixel
      n := ASCPOS(new_char_pic, j)               // one byte per line
      IF ISBIT(n, 9 -i)
        num[i] := SETBIT(num[i], 9 -j)
      ENDIF
   NEXT j
   s := CHR(num[i]) +s
 NEXT i

 new_char_pic := s
RETURN void

**************************************************************************

FUNCTION dup_row
PARAMETERS new_char_pic
 ascii_val    := ASCPOS(new_char_pic, cur_row)
 new_char_pic := LEFT(POSINS(new_char_pic, CHR(ascii_val), cur_row), pixel)
RETURN void

**************************************************************************

FUNCTION ins_row
PARAMETERS new_char_pic
 ascii_val    := IF(set_bit, 255, 0)
 new_char_pic := LEFT(POSINS(new_char_pic, chr(ascii_val), cur_row), pixel)
RETURN void

**************************************************************************

FUNCTION del_row
PARAMETERS new_char_pic
 new_char_pic := POSDEL(new_char_pic, cur_row, 1) +CHR(0)
RETURN void

**************************************************************************

FUNCTION font_load
PARAMETERS new_fontfile_in
LOCAL lRetVal := .T.

 _UPPER(@new_fontfile_in)
 info_string := "Font file  " +new_fontfile_in
 info(info_string + " will be loaded")

  IF .NOT. Load_It()
   SOUND(warn_sound)
   lRetVal := .F.
  ENDIF

 info()
RETURN (lRetVal)

**************************************************************************

FUNCTION Load_It

 IF .NOT. FILE(new_fontfile_in)
   info(info_string +" not found")
   RETURN .F.
 ENDIF

 s   := FILESTR(new_fontfile_in)
 s   := CHARUNPACK(s)
 ext := TOKEN(new_fontfile_in, ".")

 font_pixel := ASCPOS(s, font_offset)       // if "our" COM file

 DO CASE
  CASE ext = "COM" .AND. author $ s .AND. LEN(s) =font_offset +font_pixel *256
   s := RIGHT(s, font_pixel *256)
  CASE ext = "COM" .AND. SUBSTR(s, 11, 11) = "PC Magazine"
   font_pixel := ASCPOS(s, 51)
   s := SUBSTR(s, 100, font_pixel *256)
  CASE ext = "FNT" .AND. LEFT(s, 2) = "ªU"  // 55AAh
   font_pixel := ASCPOS(s, 5)
   s := SUBSTR(s, 9, font_pixel *256)
  OTHERWISE
   temp := INT(COUNTRIGHT(s, "@") /16)
   s    := POSDEL(s, temp *16)
   font_pixel := LEN(S) /256
 ENDCASE

 IF font_pixel <> INT(font_pixel) .OR. font_pixel < 1 .OR. font_pixel > 32
   info(info_string + ": wrong format")
   RETURN .F.
 ENDIF


* font setting
*
 IF font_pixel <> pixel
   info_string := " " + info_string + crlf;
                + " is created for " + NTOC(font_pixel);
                + " instead of "   + NTOC(pixel) + " pixel."

   IF ask_y_n(info_string +crlf +" convert file font")
     Pixel_Convert(@s)
     changed := .T.
   ELSE
     WACLOSE()
     CLEAR

     IF SETFONT(s, 1, .T.) <> 0
       info(info_string +": could not be loaded")
       RETURN .F.
     ELSE
      lSynchMode := .T.
      NoPixelCng := .F.

      IF !EMPTY(TOKEN(fontfile_out, ".", 2))
        fontfile_out := TOKEN(fontfile_out, ".", 1) +;
                        "." + NTOC(pixel, 10, 3, "0")
      ENDIF
     ENDIF
     changed := .F.
   ENDIF
 ENDIF

 IF NoPixelCng
   IF lSynchMode
    * The 'real' font can be displayed in the ASCII window
    *
     SETFONT(s, 2)
   ENDIF

   font_string := s
 ENDIF
RETURN .T.

**************************************************************************

FUNCTION change_window

 WSELECT(cur_window)

 IF cur_window = asc_w
   SET COLOR TO &Color_1
   WFORMAT(-1,-1,-1,-1)                 // modify output restriction
   WBOX(5)                              // single, without delete
   SET COLOR TO &Color_2

   cur_window := edit_w
   WSELECT(cur_window)

   UNSELECTED()
   WFORMAT(-1,-1,-1,-1)                 // modify output restriction
   WBOX(5)                              // single, without delete
   STANDARD()                           // standard color parameter
 ELSE
   WFORMAT(-1,-1,-1,-1)                 // modify output restriction
   WBOX(5)                              // single, without delete

   cur_window := asc_w
   WSELECT(cur_window)

   SET COLOR TO &Color_1
   UNSELECTED()
   WFORMAT(-1,-1,-1,-1)                 // modify output restriction
   WBOX(5)                              // single, without delete
   SET COLOR TO &Color_2
 ENDIF

 WSELECT(edit_w)                        // Edit

RETURN void

**************************************************************************

FUNCTION message
PARAMETERS cTitle

 IF message_window                      // message window open?
   WCLOSE()                             // close window
   message_window := .F.                // no message window open
   WSETMOVE(move_flag)                  // window relocatable interactively?
 ENDIF

 IF VALTYPE(cTitle) ="C"
   IF .NOT. crlf $ cTitle
     cTitle := " " +cTitle
   ENDIF

   message_cols   := MIN(MAXLINE(cTitle) +1, 77)
   start_col      := (77 - message_cols) / 2

   message_rows   := MIN(NUMLINE(cTitle, 80), MAXROW(.T.) -6)
   start_row      := (MAXROW(.T.) - message_rows) / 2 - 2

   move_flag      := WSETMOVE(.T.)       // window relocatable interactively
   message_window := .T.                 // message window open

   WOPEN(start_row,;
         start_col,;
         start_row +message_rows +3,;
         start_col +message_cols +2)
   SET CURSOR OFF
   WBOX()                               // double, with delete
   ? cTitle
 ENDIF
RETURN void

**************************************************************************

FUNCTION info
PARAMETERS cTitle

  DO WHILE WAITPERIOD() .AND. INKEY() = 0
  ENDDO

  IF VALTYPE(cTitle) = "C"
   message(cTitle)
   WAITPERIOD(100)        // each info visible for at least
   *                         1 second
  ELSE
   message()              // close message window
   WAITPERIOD(1)          // reset
  ENDIF

RETURN void

**************************************************************************

FUNCTION ask_y_n
PARAMETERS cTitle
PRIVAT command

 cTitle := cTitle +" Y/N"
 message(cTitle)
 SET CURSOR ON                          // cursor visible for input

  command := UPPER(CHR(INKEY()))

  DO WHILE .NOT. command $ "YN"
    command := UPPER(CHR(INKEY()))
  ENDDO

 message()                              // close message window
RETURN(command = "Y")

**************************************************************************

FUNCTION ask_save
 IF changed
   IF ask_y_n("save "+fontfile_out)
     save_it()
   ENDIF
 ENDIF
RETURN void

**************************************************************************

FUNCTION save_it
 info("Saving " +  fontfile_out)
 String_0 := CHARPACK(font_string, 0)
 String_1 := CHARPACK(font_string, 1)
 String_f := IF(LEN(String_0) < LEN(String_1), String_0, String_1)

 IF STRFILE(String_f, fontfile_out) <= 0
   info(fontfile_out +" could not be saved")
   SOUND(warn_sound)
 ELSE
   changed := .F.
   IF .NOT. EMPTY(font_head)
     font_com := TOKEN(fontfile_out, ".", 1) + ".COM"
     STRFILE(POSCHAR(font_head, pixel, font_offset) +font_string, font_com)
     SETFDATI(font_com, "00:" + NTOC(pixel, 10, 2, "0"))
   ENDIF
 ENDIF
 info()
RETURN void

**************************************************************************

PROCEDURE help
PARAMETERS m_prg, m_line, m_var
PRIVAT OldCursor

 IF .NOT. InHelp
   InHelp    := .T.
   OldCursor := CSETCURS(.T.)           // cursor visible for centering
   m_var     := LEFT(m_prg, 4) +"_" +LEFT(m_var, 5)

   IF EMPTY(help_win[&m_var])
     info(" help file " +help_file +" destroyed" +crlf;
          + " help text number '" +NTOC(&m_var) +"' can not be found")
     SOUND(warn_sound)
   ELSE
     info(help_win[&m_var])
   ENDIF

   INKEY(0)
   info()
   CSETCURS(OldCursor)
   InHelp := .F.
 ENDIF
RETURN

**************************************************************************

FUNCTION menu_select

 WSETMOVE(.T.)                          // window relocatable interaktively
 WOPEN(01, 66, 22, 79)
 WBOX()                                 // double, with delete

 ENHANCED()                             // enhanced color parameter
  @ 0,0 SAY CENTER(fkey_label[2], .T.)  // Fonts
 STANDARD()                             // standard color parameter

 FOR i = 1 TO menu_max
  * pad with spaces to total length
   @ 2 * (i -1) +2, 00 PROMPT STR(i % 10, 2) +;
                              " " + PADRIGHT(menu_label[i], 9)
 NEXT i

 MENU TO menu_command

 DO CASE
  CASE menu_command = 1                  // read
   temp := fontfile_in
   IF get_file_name(@fontfile_in, menu_label[1])
     ask_save()
     IF .NOT. font_load(fontfile_in)
       fontfile_in := temp
     ENDIF
   ENDIF
  CASE menu_command = 2                  // save
   IF get_file_name(@fontfile_out, menu_label[2])
    IF "." $ fontfile_out .AND. TOKEN(fontfile_out) <> NTOC(pixel, 10, 3, "0")
      message_wait("Extension is reserved for output file.")
    ENDIF

    fontfile_out := TOKEN(fontfile_out, ".", 1) +"." +NTOC(pixel, 10, 3, "0")
    save_it()
   ENDIF
  CASE menu_command = 3                  // print
   print_it()
  CASE menu_command = 4                  // ROM font
   ask_save()
   IF FONTRESET()                        // reset palettes and border
     FONTSELECT(1, 2)                    // norm. output : font 1, intensity: 2
     EGAPALETTE("W+", "W")               // intensity only for font selection
     changed      := .F.
     font_string  := GETFONT(1)
     fontfile_in  := memory
     fontfile_out := memory
     * VGA border is set only via SET COLOR
     SET COLOR TO &Color_1
   ELSE
     info("No ROM font available for this character height!")
     SOUND(warn_sound)
     info()
   ENDIF
  CASE menu_command = 5        // select number of lines
   scrn_mode()
  CASE menu_command = 6        // select font pixel height
   pixel_mode()
 ENDCASE

 WCLOSE()                     // close window
 WSETMOVE(.F.)                // NOT relocatable interactively
RETURN void

**************************************************************************

FUNCTION scrn_mode
 WSETMOVE(.T.)    // window relocatable interactively
 WOPEN(MAXROW(.T.) /2 -5, 29, MAXROW(.T.) /2 +4, 51)
 WBOX()

  ENHANCED()
   @ 0,0 SAY CENTER("Display Mode", .T.)
  STANDARD()

   IF ISVGA()
    @ 2, 4 PROMPT "1 - 25 lines"
    @ 4, 4 PROMPT "2 - 28 lines"
    @ 6, 4 PROMPT "3 - 50 lines"
   ELSE
    @ 2, 4 PROMPT "1 - 25 lines"
    @ 4, 4 PROMPT "2 - 43 lines"
   ENDIF

  MENU TO ScreenMode

  IF LASTKEY() <> 27
    ask_save()
    WACLOSE()
    SHOWKEY()

    IF ScreenMode = 1            // 25 lines on VGA (25 *16 =400)
     IF ISCOLOR()
       CGA80()
     ELSE
       MONOCHROME()
     ENDIF
    ELSE
     DO CASE
      CASE ScreenMode = 2
       IF ISVGA()
         VGA28()                 // 28 lines on VGA (28 *14 =392)
       ELSE
         EGA43()                 // 43 lines on EGA (43 * 8 =344)
       ENDIF
      CASE ScreenMode = 3
        VGA50()                  // 50 lines on VGA (50 * 8 =400)
     ENDCASE
    ENDIF

    changed      := .T.
    font_string  := GETFONT(1)
    fontfile_in  := memory
    fontfile_out := memory
    lScroll      := .F.
    lSynchMode   := .T.
    NoPixelCng   := .F.
  ENDIF

 WCLOSE()
 WSETMOVE(.F.)    // NOT relocatable interactively any longer
 ShowKeyOn()
RETURN void

**************************************************************************

FUNCTION pixel_mode
 SET CURSOR ON

 WSETMOVE(.T.)
 WOPEN(MAXROW(.T.) /2 -4, 25, MAXROW(.T.) /2 +4, 55)
 WBOX()

  ask_save()
  @ 01,00 CLEAR

  ENHANCED()
   @ 0,0 SAY CENTER("Pixel Height", .T.)
  STANDARD()

  get_new_pixel := pixel
  @ 03,MAXCOL() /2 -5 GET get_new_pixel VALID inrange(5, 32)
  @ 05,00 SAY CENTER("5 to 32")
  READ

  IF LASTKEY() <> 27 .AND. get_new_pixel <> Pixel
   changed    := .T.
   NoPixelCng := .F.
   font_pixel := Pixel

   IF get_new_pixel = 8 .OR. get_new_pixel = 14 .OR. get_new_pixel = 16
    WACLOSE()
    SHOWKEY()

    DO CASE
     CASE get_new_pixel = 8
      VGA50()
     CASE get_new_pixel = 14 .AND. ISVGA()
      VGA28()
     OTHERWISE
      IF ISCOLOR()
       CGA80()
      ELSE
       MONOCHROME()
      ENDIF
    ENDCASE

    lSynchMode := .T.
    lScroll    := .F.
   ELSE
    ENHANCED()
     @ 0,0 SAY CENTER("Font display", .T.)
    STANDARD()

    @ 03,04 PROMPT "1 -  Synchron mode "
    @ 05,04 PROMPT "2 - Asynchron mode "
    MENU TO F_Modus

    IF LASTKEY() <> 27
     WACLOSE()
     SHOWKEY()

     DO CASE
      CASE F_Modus = 1
       lSynchMode := .T.
       Pixel      := get_new_pixel
       lScroll    := ( Pixel > 16 )
       Pixel_Convert(@font_string)
       CLEAR
       SETFONT(font_string, 1, .T.)

      CASE F_Modus = 2
       IF ISVGA()
        IF get_new_pixel >= 20
         VGA50()
        ELSE
         IF Get_new_pixel >= 17
          VGA28()
         ELSE
          IF ISCOLOR()
           CGA80()
          ELSE
           MONOCHROME()
          ENDIF
         ENDIF
        ENDIF
       ELSE
        IF Get_new_pixel >= 17
         EGA43()
        ELSE
         IF ISCOLOR()
          CGA80()
         ELSE
          MONOCHROME()
         ENDIF
        ENDIF
       ENDIF

       lSynchMode := .F.
       lScroll    := .F.
       Pixel      := get_new_pixel
       Pixel_Convert(@font_string)
     ENDCASE
    ENDIF
   ENDIF
  ENDIF

 WCLOSE()
 WSETMOVE(.F.)
 ShowKeyOn()
 SET CURSOR OFF
RETURN void

**************************************************************************

FUNCTION get_file_name
PARAMETERS new_file, file_type
PRIVATE temp

 WSETMOVE(.T.)                          // window relocatable interactively
 WOPEN(9, 7, 17, 73)
 WBOX()                                 // double, with delete

 SET KEY -1 TO FileSelect               // F2
 temp      := PADRIGHT(new_file, 53)    // pad with spaces to total length
 Font_Mask := PADRIGHT(Font_Mask, 53)   // pad with spaces to total length

 @ 01,01 SAY "mask "
 @ 01,11 GET Font_Mask PICTURE "@!"     // file mask for font files
 @ 03,01 SAY file_type
 @ 03,11 GET temp PICTURE "@K!"
 @ 05,11 SAY "F2   select"

 SET CURSOR ON                          // cursor visible for input
 READ

 Font_Mask := TRIM(Font_Mask)
 IF EMPTY(Font_Mask)
   Font_Mask := Font_Mask +"*.*"
 ENDIF

  result := .F.
  temp   := TRIM(temp)
  SET KEY -1 TO                          // F2

  DO CASE
   CASE LASTKEY() = Esc
    *
   CASE temp == memory
    SOUND(warn_sound)
   CASE FILEVALID(TOKEN(temp, ":\"))
    new_file := temp
    result   := .T.
   OTHERWISE
    SOUND(warn_sound)
  ENDCASE

 WCLOSE()                               // close window
 WSETMOVE(.F.)
RETURN(result)

**************************************************************************

PROCEDURE FileSelect
PARAMETERS  m_prg, m_line, m_var

 IF .NOT. InSelect
  InSelect := .T.

  n := 0
  s := ""

  IF m_var = "FONT_MASK"
    cFile := FILESEEK("*.", 16, .T.)      // file mask for font files
  ELSE
    IF EMPTY(Font_Mask)
      POSREPL(@Font_Mask, "*.*", 1)
    ENDIF

    cFile := FILESEEK(TRIM(Font_Mask))    // file mask for font files
  ENDIF

  DO WHILE .NOT. EMPTY(cFile)
    ++n
    s     := s +cFile +" "                // space is delimiter
    cFile := FILESEEK()
  ENDDO

  IF n = 0
    message_wait("no file available")
  ELSE
    WSETMOVE(.T.)
    WOPEN(01, 66, 22, 79)
    WBOX()                               // double, with delete

    offset := 0
    max_n  := MAXROW() +1

    DO WHILE .T.
      @ 00, 00 CLEAR
      FOR i = 1 TO MIN(max_n, n -offset)
        cFile := TOKEN(s, " ", offset +i)
        @ i -1, 0 PROMPT PADRIGHT(TOKEN(cFile, ".", 1), 8) +".";
                         + PADRIGHT(TOKEN(cFile, ".", 2), 3)
      NEXT i

      MENU TO menu_font

      DO CASE
       CASE LASTKEY() = Esc
         EXIT
       CASE LASTKEY() = 18               // PgUp
         offset := MAX(0, offset -max_n)
         LOOP
       CASE LASTKEY() =  3               // PgDn
         IF offset +max_n <= n
            offset := offset +max_n
         ENDIF
         LOOP
       CASE menu_font > 0 .AND. m_var = "FONT_MASK"
         Font_Mask := PADRIGHT(;
                         TOKEN(s, " ", offset +menu_font) + "\*.0*",;
                         LEN(Font_Mask))
         EXIT
       CASE menu_font > 0
         DO CASE
          CASE "\" $Font_Mask
            temp_Mask := LEFT(Font_Mask, ATNUM("\", Font_Mask))
          CASE ":" $Font_Mask
            temp_Mask := LEFT(Font_Mask, 2)
          OTHERWISE
            temp_Mask := ""
         ENDCASE
         temp := PADRIGHT(;
                    temp_Mask +TOKEN(s, " ", offset +menu_font), LEN(temp))
         EXIT
      ENDCASE
    ENDDO

    WCLOSE()                             // close window
    WSETMOVE(.F.)                        // NOT relocatable interactively
  ENDIF

  InSelect := .F.
 ENDIF
RETURN

**************************************************************************

FUNCTION font_info
PRIVATE Filespec, Fontname, ScnPixel

 Filespec := TOKEN(fontfile_in, ":\")    // file name
 Fontname := TOKEN(Filespec,".",1)       // font name
 ScnPixel := (MAXROW() +1) * CHARPIX()

 @ info_row_1,01 SAY "Font : " + PADRIGHT(Fontname, 8)
 @ info_row_2,01 SAY "Pixel: " + STR(Pixel,2) + " | " + STR(ScnPixel,3)

RETURN void

**************************************************************************

FUNCTION screen_info
PRIVATE nRows

 @ info_row_1, 21 SAY "Rows :  " + STR(MAXROW() +1, 3)
  IF .NOT. lScroll
    nRows := (MAXROW() +1) * CHARPIX() /Pixel
    ?? " | " + IF(nRows < 256, STR(nRows, 3), "***")
  ENDIF
 @ info_row_2,21 SAY "Mode :  " + POSDEL(GETMODE(), AT("()", GETMODE()), 2)

RETURN void

**************************************************************************

FUNCTION rows

 WSETMOVE(.T.)                           // window relocatable interactively
 WOPEN(01, 66, 22, 79)
 WBOX()                                  // double, with delete

 ENHANCED()                              // enhanced color parameter
  @ 0,0 SAY CENTER(fkey_label[3], .T.)   // lines
 STANDARD()                              // standard color parameter

 FOR i = 1 TO row_menu_max
   *  pad with spaces to total length
   *
   @ 2 * (i -1) +2, 00 PROMPT STR(i % 10, 2) +" ";
                       + PADRIGHT(row_menu_label[i], 9)
 NEXT i

 MENU TO row_command

 DO CASE
  CASE row_command = 1                  // duplicate
   IF .NOT. KSETCAPS()                  // caps lock ON: process all characters
     dup_row(@char_pic)
   ELSE
     do_the_font("dup_row")
   ENDIF
  CASE row_command = 2                  // insert
   IF .NOT. KSETCAPS()                  // caps lock ON: process all characters
     ins_row(@char_pic)
   ELSE
     do_the_font("ins_row")
   ENDIF
  CASE row_command = 3                  // delete
   IF .NOT. KSETCAPS()                  // caps lock ON: process all characters
     del_row(@char_pic)
   ELSE
     do_the_font("del_row")
   ENDIF
 ENDCASE

 WCLOSE()                               // close window
 WSETMOVE(.F.)                          // NOT relocatable interactively
RETURN void

**************************************************************************

FUNCTION cols
PRIVAT temp

 WSETMOVE(.T.)
 WOPEN(01, 44, 22, 65)
 WBOX()                                 // double, with delete

 ENHANCED()                             // enhanced color parameter
  @ 0,0 SAY CENTER(fkey_label[4], .T.)  // columns
 STANDARD()                             // standard color parameter

 temp_s := "temp_"

 FOR i = 1 TO pixel
   temp  := temp_s +NTOC(i)
   &temp := col_move[i]
   @ 01 +i, 00 SAY STR(i, 2)
   @ 01 +i, 06 GET &temp RANGE -8, 8
 NEXT i

 @ 19,01 SAY "Del / Ins  Pixel  "

 SET CURSOR ON                          // cursor visible for input
 READ

 IF LASTKEY() <> Esc
   FOR i = 1 TO pixel
     temp := temp_s +NTOC(i)
     col_move[i] := &temp
   NEXT i
   IF KSETCAPS()                        // caps lock ON: process all characters
     do_the_font("do_cols")
   ELSE
     do_cols(@char_pic)
   ENDIF
 ENDIF

 WCLOSE()                               // close window
 WSETMOVE(.F.)
RETURN void

**************************************************************************

FUNCTION copy_font
PRIVAT temp

 WSETMOVE(.T.)
 copy_w := WOPEN(1, 00, 12, 43)
 WBOX()                                  // double, with delete

 ENHANCED()                              // enhanced color parameter
  @ 0,0 SAY CENTER(fkey_label[9], .T.)   // copy
 STANDARD()                              // standard color parameter

 org         := "O"
 source      := CHR(cur_asc) +" "
 destination := source
 length      := IF(KSETCAPS(), 256 -cur_asc, 1) // caps lock ON: all characters

 @ 02,01 SAY "from [O]riginal / [E]dit" GET org PICTURE "!" VALID org $ "OE"

 @ 04,01 SAY "start position source"
 @ 04,25 GET source      PICTURE "@K" VALID hex(source)
 @ 04,29 SAY nchar_show(nval(source))

 @ 06,01 SAY "start position target"
 @ 06,25 GET destination PICTURE "@K" VALID hex(destination)
 @ 06,29 SAY nchar_show(nval(destination))

 @ 08,01 SAY "number of characters"
 @ 08,25 GET length

 SET CURSOR ON                           // cursor visible for input
 READ

 IF length > 0 .AND. LASTKEY() <> Esc
   length := MIN(length, 256 -nval(source))
   length := MIN(length, 256 -nval(destination))
   temp   := IF(org ="O", org_string, font_string)
   temp   := SUBSTR(temp, nval(source) *pixel +1, length *pixel)

   POSREPL(@font_string, temp, nval(destination) *pixel +1)
   new_asc(nval(destination))
   WSELECT(copy_w)
 ENDIF

 WCLOSE()                                // close window
 WSETMOVE(.F.)
RETURN void

**************************************************************************

FUNCTION or_font
PRIVAT temp_s, temp_d

 WSETMOVE(.T.)                            // window relocatable interactively
 or_w := WOPEN(1, 00, 10, 43)
 WBOX()                                   // double, with delete

 ENHANCED()                               // enhanced color parameter
  @ 0,0 SAY CENTER(fkey_label[11], .T.)   // overlay
 STANDARD()                               // standard color parameter

 destination := CHR(cur_asc) +" "
 length      := IF(KSETCAPS(), 256 -cur_asc, 1) // caps lock ON: all characters

 @ 02,16 SAY "source"
 @ 02,25 GET or_source   PICTURE "@K" VALID hex(or_source)
 @ 02,29 SAY nchar_show(nval(or_source))

 @ 04,01 SAY "start position target"
 @ 04,25 GET destination PICTURE "@K" VALID hex(destination)
 @ 04,29 SAY nchar_show(nval(destination))

 @ 06,01 SAY "number of characters"
 @ 06,25 GET length

 SET CURSOR ON                           // cursor visible for input
 READ

 IF length > 0 .AND. LASTKEY() <> Esc
   length := MIN(length, 256 -nval(destination))
   temp_s := SUBSTR(font_string, nval(or_source)   *pixel +1, pixel)
   temp_d := SUBSTR(font_string, nval(destination) *pixel +1, length *pixel)
   CHAROR(@temp_d, temp_s)

   POSREPL(@font_string, temp_d, nval(destination) *pixel +1)
   new_asc(nval(destination))
   WSELECT(or_w)
 ENDIF

 WCLOSE()                               // close window
 WSETMOVE(.F.)                          // NOT relocatable interactively
RETURN void

**************************************************************************

FUNCTION hex
PARAMETER Char
 @ GETFLDROW(), GETFLDCOL() +4 SAY nchar_show(nval(Char))
RETURN .T.

**************************************************************************
FUNCTION nval
PARAMETER Char

 IF LEN(TRIM(Char)) >1
   RETURN CTON(Char, 16)
 ELSE
   RETURN ASC(Char)
 ENDIF

**************************************************************************

FUNCTION nchar_show
PARAMETER nChar
 *
RETURN NTOC(nChar, 16, 2) +" " +CHR(nChar) +"  Dez " +STR(nChar, 3)

**************************************************************************

FUNCTION inorder
PARAMETERS p1, p2, p3
 *
RETURN p1 <= p2 .AND. p2 <= p3

**************************************************************************

FUNCTION inrange
PARAMETERS n1, n2
 n := READVAR()
 IF inorder(n1, &n, n2)
   RETURN .T.
 ELSE
   message_wait("Valid range is between " +NTOC(N1) +" and " +NTOC(N2))
   RETURN .F.
 ENDIF

**************************************************************************

FUNCTION message_wait
PARAMETERS wait_info
 info(wait_info +". Press any key")
 INKEY(0)
 info()
RETURN void

**************************************************************************
**************************************************************************

FUNCTION edit_pixel
PARAMETERS edit_mode

 IF .NOT. KSETCAPS()              // caps lock ON: process all characters
   do_edit_pixel(@char_pic)
 ELSE
   do_the_font("do_edit_pixel")
 ENDIF
RETURN void

**************************************************************************

FUNCTION do_edit_pixel
PARAMETERS work_char_pic

 row_asc := ASCPOS(work_char_pic, cur_row)       // one byte per line
 row_pic := NTOC(row_asc, 2, 8, "0")

 DO CASE
  CASE edit_mode = 2                             // space
    set_bit := .NOT. ISBIT(row_asc, 9 -cur_col)  // base 1
    bit_pic := IF(set_bit, "1", "0")             // pixel display character
    POSCHAR(@row_pic, bit_pic, cur_col)
  CASE edit_mode = 1                             // Ins
    row_pic := LEFT(POSINS(row_pic, bit_pic, cur_col), 8)
  OTHERWISE                                      // Del
    row_pic := POSDEL(row_pic, cur_col, 1) +"0"  // bit_pic
 ENDCASE

 row_asc := CTON(row_pic, 2)
 POSCHAR(@work_char_pic, row_asc, cur_row)
RETURN void

**************************************************************************

FUNCTION do_cols
PARAMETERS work_char_pic
PRIVAT i

 FOR i = 1 TO pixel
   row_asc := ASCPOS(work_char_pic, i)            // one byte per line
   row_asc := row_asc /2 **col_move[i]
   POSCHAR(@work_char_pic, row_asc, i)
 NEXT i

RETURN void

**************************************************************************

FUNCTION drag                    // pull +cursor

 IF set_drag
   IF .NOT. KSETCAPS()           // caps lock ON: process all characters
     do_drag(@char_pic)
   ELSE
     do_the_font("do_drag")
   ENDIF
 ENDIF
RETURN void

**************************************************************************

FUNCTION do_drag                              // pull +cursor
PARAMETERS work_char_pic

 row_asc := ASCPOS(work_char_pic, new_row)     // one byte per line
 row_pic := NTOC(row_asc, 2, 8, "0")

 POSCHAR(@row_pic, bit_pic, new_col)

 row_asc := CTON(row_pic, 2)
 POSCHAR(@work_char_pic, row_asc, new_row)
RETURN void

**************************************************************************

FUNCTION do_the_font
PARAMETERS font_func

 info(cPatience)
 r := ROW()
 c := COL() -2
 font_func := font_func +"(@s)"
 new_font  := ""

 FOR i = 0 TO 255
   @ r, c SAY STR(255 -i, 3)
   s := SUBSTR(font_string, i * pixel +1, pixel)
   NUL(&font_func)                      // NUL() avoids 'assignment error'
   new_font := new_font +s
 NEXT i

 font_string := new_font
 info()
RETURN void

****************************************************************************

FUNCTION Pixel_Convert
PARAMETERS s

 info("Pixel converting is in process. " + cPatience)
 r := ROW()
 c := COL() -2

 DO CASE
  CASE font_pixel >= pixel *2
    s          := CHAREVEN(s)
    font_pixel := font_pixel /2
  CASE font_pixel *2 <= pixel
    s          := CHARMIX(s, s)
    font_pixel := font_pixel *2
 ENDCASE

 diff    := ABS(font_pixel - pixel)
 up_diff := INT(diff /2)
 new_s   := ""

 DO CASE
  CASE font_pixel < pixel
    down_diff := diff -up_diff
    FOR i = 0 TO 255
      @ r, c SAY STR(255 -i, 3)
      temp := SUBSTR(s, i * font_pixel +1, font_pixel)
      DO CASE
       CASE i >= 176 .AND. i <= 178                       // 176, 177, 178
         temp  := REPLICATE(LEFT(temp, 2),16)             // 2 lines
         new_s := new_s +LEFT(temp, pixel)
       CASE (i >= 179 .AND. i <= 223);                    // 179 - 223 (graphik)
         .OR. i =8 .OR. i =10 .OR. i =244 .OR. i =245     // cards, ô õ
         up_temp   := REPLICATE(LEFT(temp,1),  up_diff)   // upper row
         down_temp := REPLICATE(RIGHT(temp,1), down_diff) // lowest row
         new_s     := new_s +up_temp +temp +down_temp
       OTHERWISE
         up_temp   := REPLICATE(CHR(0), up_diff)          // space lines
         down_temp := REPLICATE(CHR(0), down_diff)
         new_s     := new_s +up_temp +temp +down_temp
      ENDCASE
    NEXT i
  CASE font_pixel > pixel
    up_diff := up_diff +1                             // SUBSTR starts with 1
    FOR i = 0 TO 255
      @ r, c SAY STR(255 -i, 3)
      new_s := new_s +SUBSTR(s, i * font_pixel +up_diff, font_pixel -diff)
    NEXT i
  OTHERWISE
    new_s := s
 ENDCASE

 s := new_s
 info()

RETURN void

****************************************************************************

FUNCTION ShowKeyOn

 SHOWKEY("C", info_row_2, 68, "  all   ", " single ", show_c_on, show_c_off)

RETURN void

****************************************************************************
********************************  Datei-Ende  ******************************

