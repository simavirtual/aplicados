*******************************************************************************
*  G_EXAM12.PRG                                                               *
*  Requirements: None                                                         *
*  Description:                                                               *
*        This program demonstrates the use of SET_STYLE() and SET_TYPE() to   *
*        change the line styles of the lines in Flipper.                      *
*  Chapter 3, Customizing the Graph                                           *
*******************************************************************************
FLIP_INIT(1000)
HP_SETUP(0,1,9600,0,8,1)                   && Initialize RS232 port 9600 baud
*
SET MESSAGE TO 23
M_ans=1
M_out=0
DO WHILE .T.
   CLEAR
   TEXT
   *********************************************************************
   * Example of setting different line styles                          *
   *                                                                   *
   *  SET_STYLE()                                                      *
   *  SET_TYPE()                                                       *
   *                                                                   *
   *********************************************************************
   ENDTEXT
*
   INITDATA(8)
   @ 12,18 SAY 'Type'
   @ 12,28 SAY 'Style'
   @ 12,38 SAY 'Y side'
   @ 13,10 SAY 'X:  '
   @ 14,10 SAY 'Y1: '
   @ 15,10 SAY 'Y2: '
   @ 16,10 SAY 'Y3: '
   @ 17,10 SAY 'Y4: '
   @ 18,10 SAY 'Y5: '
   @ 19,10 SAY 'Y6: '
   @ 20,10 SAY 'Y7: '
*
   FOR I=0 to RET_COLS()-1
      @ 13+I,20 SAY SET_TYPE(I) PICT '99'
   NEXT
*
   FOR I=1 to RET_COLS()-1
      @ 13+I,30 SAY SET_STYLE(I) PICT '99'
   NEXT
*
   FOR I=1 to RET_COLS()-1
      @ 13+I,40 SAY SET_YSIDE(I) PICT '99'
   NEXT
*
   @ 22,0 PROMPT 'Type' MESSAGE 'Set each Y columns style'
   @ 22,COL()+2 PROMPT 'Style' MESSAGE 'Set each Y columns type'
   @ 22,COL()+2 PROMPT 'YSide' MESSAGE 'Set column y side'
   @ 22,COL()+2 PROMPT 'Mark Size' MESSAGE 'Set set of Point Marker'
   @ 22,COL()+2 PROMPT 'Display' MESSAGE 'Show the graph'
   @ 22,col()+2 PROMPT IF(M_out=0,'Screen',IF(M_out=1,'Plotter','File'))
   MENU TO M_ans
*
   DO CASE
      CASE M_ans=0
         EXIT
      CASE M_ans=1
         CLEAR
         M_col=1
         M_type=1
         @ 21,0 say 'Column: 'GET M_col PICT '9'
         @ 22,0 say 'Type:   'GET M_type PICT '9' valid M_type < 6
         READ
         IF LASTKEY()=27
            LOOP
         ENDIF
         IF M_col=0
            FOR I=1 to RET_COLS()-1
               SET_TYPE(I,M_type)
            NEXT
         ELSE
            SET_TYPE(M_col,M_type)
         ENDIF
      CASE M_ans=2
         CLEAR
         M_col=1
         M_style=1
         @ 21,0 say 'Column:      'GET M_col PICT '9'
         @ 22,0 say 'Style:       'GET M_style PICT '99'
         READ
         IF LASTKEY()=27
            LOOP
         ENDIF
         IF M_col=0
            FOR I=1 to RET_COLS()-1
               SET_STYLE(I,I+M_style)
            NEXT
         ELSE
            SET_STYLE(M_col,M_style)
         ENDIF
      CASE M_ans=3
         CLEAR
         M_col=1
         M_side=1
         @ 21,0 say 'Column:                 'GET M_col PICT '9'
         @ 22,0 say 'Y Side: 1-left, 2-right 'GET M_side PICT '9' valid M_side < 3
         READ
         IF LASTKEY()=27
            LOOP
         ENDIF
         SET_YSIDE(M_col,M_side)
      CASE M_ans=4
         CLEAR
         M_xmsize=0
         M_ymsize=0
         MARK_SIZE(@M_xmsize,@M_ymsize)
         @ 21,0 say 'X mark size: 'GET M_xmsize PICT '999'
         @ 22,0 say 'Y mark size: 'GET M_ymsize PICT '999'
         READ
         IF LASTKEY()=27
            LOOP
         ENDIF
         MARK_SIZE(M_xmsize,M_ymsize)
      CASE M_ans=5
         SET_AREA(0,0,100,100)
         HP_OPEN(IF(M_out=0,"SCREEN",IF(M_out=1,"PLOTTER","FILE")))
         USE TEST
         DO WHILE .not. EOF()
            @ 23,0 SAY STORE_DATA(Xdate,xnumber,number1,number2,number3,number4,negative,number4-number3 )
            SKIP
         ENDDO
   *
         PLOT()
         SET_YSIDE(0,0)
         HORZ_LINE(6)
         IF RET_HP()=0
            inkey(0)
         ENDIF
         TEXTMODE()
      CASE M_ans=6
         M_out = M_out + 1
         IF M_out=3
            M_out=0
         ENDIF
   ENDCASE
ENDDO