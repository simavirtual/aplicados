******************************************************************************
*  C_EXAM08.PRG                             *
*  Author: David Prothero, ProWorks                  *
*  Requirements: Microsoft Compatible Mouse                *
*  Description:                             *
*        This program contains two functions, GET_PATH(), and GET_FILE().    *
*        GET_PATH() simply opens a requestor and allows the user to type     *
*        in a path.  The function then returns the typed in path.  The       *
*        second function, GET_FILE(), is the main function, which returns    *
*        a file name.  You must pass it a string for the path (which can be  *
*        obtained with GET_PATH(), if you wish) and it will find all of the  *
*        files in the specified path.  An example path is "C:\CAD\*.*", which*
*        will show all of the files in the cad directory.  Note, you can, and*
*        must use wildcards.                      *
*                               *
******************************************************************************
FLIP_INIT(6000)
SET SCOREBOARD OFF
FSCREEN()
req_font = FONT_OPEN( "\FLIPPER\FONTS\file_req.@" )
SET_SAYERR(1)
INIT_VIDEO( 1, 0 , 0 )
*
M_buttons = MS_RESET()
*
IF M_buttons = 0
   @ 10,10 SAY 'No mouse present!'
   @ 11,10 SAY 'Press any key.'
   INKEY(0)
ENDIF
MS_CURON()
*
M_path1 = "C:\CAD\*.@"+SPACE(25)
DO WHILE .T.
   M_path = GET_PATH(M_path1)
   M_path1 = M_path
   IF M_path = "ESC"
      EXIT
   ENDIF
   CLS_SCREEN()
*
   M_file = GET_FILE(M_path)
   IF M_file = "NEW PATH"
      CLS_SCREEN()
      LOOP
   ENDIF
   @ 10,10 SAY "FILE: "+M_file
   @ 11,10 SAY "PRESS <ENTER>"
   INKEY(0)
   CLS_SCREEN()
ENDDO
MS_CUROFF()
TEXTMODE()


FUNCTION GET_FILE
PARAMETER M_search_f
*
DECLARE M_show_f[10]
M_file_cnt = ADIR(ALLTRIM(M_search_f))
*
IF M_file_cnt = 0
   RETURN "NO FILES"
ENDIF
*
DECLARE M_f_list[M_file_cnt]
ADIR(ALLTRIM(M_search_f),M_f_list)
*
M_file_req = MENU_OPEN( req_font, 1, 0, 1, 1, 3, 1 )
*
IF M_file_cnt < 10
   FOR v = 1 TO M_file_cnt
      M_show_f[v] = ALLTRIM(M_f_list[v])+SPACE(13 - LEN(ALLTRIM(M_f_list[v])))
   NEXT
   FOR n = M_file_cnt + 1 TO 10
      M_show_f[n] = SPACE(13)
   NEXT
ELSE
   FOR v = 1 TO 10
      M_show_f[v] = ALLTRIM(M_f_list[v])+SPACE(13 - LEN(ALLTRIM(M_f_list[v])))
   NEXT
ENDIF
*
FOR mn = 1 TO 10
   IF M_show_f[mn] = SPACE(13)
      MENU_ITEM( M_file_req, 4+mn, 10, 1, 0, M_show_f[mn], 0, 1 )
   ELSE
      MENU_ITEM( M_file_req, 4+mn, 10, 1, 0, M_show_f[mn], 1, 0 )
   ENDIF
NEXT
*
MENU_ITEM( M_file_req, 5, 24, 1, 0, " < ", 1, 0 )
MENU_ITEM( M_file_req, 10, 24, 1, 0, " > ", 1, 0 )
*
M_s_path = "Path: "+ALLTRIM(M_search_f)
I_path = MENU_ITEM( M_file_req, 3, 10, 1, 0, M_s_path, 1, 0 )
M_start = 1
*
MENU_WAKE( M_file_req )
DO WHILE .T.
   M_key = KEY_PRESS()
*
   IF M_key # 32
      LOOP
   ENDIF
   M_ans = KP_ITEM_NO()
   IF M_ans = 11
      IF M_start = 1
         LOOP
      ENDIF
      M_show_f[1] = M_f_list[M_start - 1]
      BUTTON_EDT( M_file_req, 1, 0, ALLTRIM(M_show_f[1])+SPACE(13-LEN(ALLTRIM(M_show_f[1]))) )
      FOR v = 2 TO 10
         M_show_f[v] = M_f_list[M_start + v - 2]
         BUTTON_EDT( M_file_req, v, 0, ALLTRIM(M_show_f[v])+SPACE(13-LEN(ALLTRIM(M_show_f[v]))) )
      NEXT
      M_start = M_start - 1
   ENDIF
   IF M_ans = 12
      IF M_show_f[10] = SPACE(13) .OR. M_show_f[10] = M_f_list[M_file_cnt]
         LOOP
      ENDIF
      FOR v = 1 TO 10
         M_show_f[v] = M_f_list[M_start + v]
         BUTTON_EDT( M_file_req, v, 0, ALLTRIM(M_show_f[v])+SPACE(13-LEN(ALLTRIM(M_show_f[v]))) )
      NEXT
      M_start = M_start + 1
   ENDIF
   IF M_ans < 11
      IF M_ans < 1
         LOOP
      ENDIF
      IF M_show_f[M_ans] = SPACE(13)
         LOOP
      ENDIF
      EXIT
   ENDIF
   IF M_ans = I_path
      EXIT
   ENDIF
ENDDO
MENU_SLEEP( M_file_req )
*
IF M_ans = I_path
   M_ret_str = "NEW PATH"
ELSE
   M_ret_str = ALLTRIM(M_show_f[M_ans])
ENDIF
*
CLR_MENU( M_file_req )
RETURN M_ret_str


FUNCTION GET_PATH
PARAMETER M_u_path
*
M_path_req = MENU_OPEN( req_font, 1, 0, 0, 1, 2, 1 )
*
MENU_ITEM( M_path_req, 3, 10, 1, 0, "Enter path below:             ", 0, -2 )
MENU_ITEM( M_path_req, 4, 10, 1, 0, "                              ", 0, -2 )
MENU_ITEM( M_path_req, 5, 10, 1, 0, "                              ", 0, -2 )
MENU_ITEM( M_path_req, 6, 10, 1, 0, "                              ", 0, -2 )
MENU_ITEM( M_path_req, 7, 10, 1, 0, "(Press ESC to abort.)       ", 0, -2 )
MENU_WAKE( M_path_req )
*
SET CURSOR ON
@ 11, 15 GET M_u_path PICTURE "@K"
READ
SET CURSOR OFF
*
IF LASTKEY() = 27
   M_u_path = "ESC"
ENDIF
*
MENU_SLEEP( M_path_req )
CLR_MENU( M_path_req )
*
RETURN M_u_path
