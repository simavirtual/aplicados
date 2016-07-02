*******************************************************************************
*  G_EXAM11.PRG                                                               *
*  Author: Gary Prothero                                                      *
*  Requirements: None                                                         *
*  Description:                                                               *
*        This program demonstrates two color manipulation functions, SET_PAL()*
*        and SET_COLOR().  These manipulate the color palette to give you     *
*        different color combinations.                                        *
*  Chapter 2, Initialization and Setup;Chapter 3, Customizing the Graph       *
*******************************************************************************
FLIP_INIT(1000)
*
M_CGA=0
DO WHILE .T.
   CLEAR
   INITDATA(5)
*
   M_ans=1
   @ 22,0 PROMPT 'Set Palette'
   @ 22,COL()+2 PROMPT 'Column colors'
   @ 22,COL()+2 PROMPT 'Show graph'
   MENU TO M_ans
*
   DO CASE
      CASE M_ans=0
         EXIT
      CASE M_ans=1
         M_pal=0
         M_color=SET_PAL(M_pal)
         DO WHILE LASTKEY()#27
            CLEAR
            I=0
            J=0
            @ 2+I,6 say 'Palette  Color'
            @ 3+I,6 say '-------  -----'
            FOR I=0 to 15
               J = SET_PAL(I)
               @ 4+I,8 say I PICT '99'
               @ 4+I,16 say STR(J,2)
            NEXT
            @ 22,0 say 'Enter Palette number and Color'
            @ 22,32 get M_pal pict '99'
            @ 22,36 get M_color pict '99'
            @ 24,0 SAY 'PgDn to see palette'
            READ
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
            ELSEIF LASTKEY()=18
               @ 1,0 SAY 'Clipper text colors'
               DECLARE A[16]
               A[1]='N'
               A[2]='B'
               A[3]='G'
               A[4]='BG'
               A[5]='R'
               A[6]='RB'
               A[7]='GR'
               A[8]='W'
               A[9]='N+'
               A[10]='B+'
               A[11]='G+'
               A[12]='BG+'
               A[13]='R+'
               A[14]='RB+'
               A[15]='GR+'
               A[16]='W+'
               @ 3,0 CLEAR
               FG=1
               BG=1
               HORZ=0
               VERT=5
               DO WHILE FG<=16
                  VERT=VERT+1
                  DO WHILE BG<=8
                     TRY=A[FG]+'/'+A[BG]
                     SET COLOR TO &TRY
                     @ VERT,HORZ SAY STR(FG-1,2)+STR(BG-1,2)
                     VERT=VERT+1
                     BG=BG+1
                  ENDDO
                  BG=1
                  FG=FG+1
                  HORZ=HORZ+5
                  VERT=5
               ENDDO
               SET COLOR TO &STANDARD
               INKEY(0)
            ELSE
               IF UPDATED()
                  SET_PAL(M_pal,M_color)
               ENDIF
            ENDIF
         ENDDO
      CASE M_ans=2
         M_pal=0
         M_col=0
         CLEAR
         @ 1,5 say 'Function : palette position = SET_COLOR( column [, palette position] )'
         @ 3,6 say 'Column  Palette   Color '
         @ 4,6 say '  #     Position  Number'
         @ 5,6 say '------  -------   ------'
         FOR I=1 to RET_COLS()-1
            J =  SET_COLOR(I)
            @ 5+I,9 say I PICT '99'
            @ 5+I,16 say STR( J )
            @ 5+I,26 say STR( SET_PAL(J) )
         NEXT
         @ 21,0 say 'Column:         'GET M_col PICT '99'
         @ 22,0 say 'Palette number: 'GET M_pal PICT '99'
         READ
         IF LASTKEY()=27
            LOOP
         ENDIF
         SET_COLOR( M_col, M_pal)
      CASE M_ans=3
         M_Frame=0
         M_Grid=0
         M_Scale=0
         M_ScaleTit=0
         M_Title=0
         M_Legend=0
         M_Bg=0
         GRF_COLORS( @M_Frame, @M_Grid, @M_Scale, @M_ScaleTit, @M_Title, @M_Legend, @M_Bg )
         @ 15     , 0 SAY 'Frame:       'GET M_Frame
         @ row()+1, 0 SAY 'Grid:        'GET M_Grid
         @ row()+1, 0 SAY 'Scale:       'GET M_Scale
         @ row()+1, 0 SAY 'Scale Title: 'GET M_ScaleTit
         @ row()+1, 0 SAY 'Title:       'GET M_Title
         @ row()+1, 0 SAY 'Legend:      'GET M_Legend
         @ row()+1, 0 SAY 'Bg:          'GET M_Bg
         READ
         IF UPDATED()
            GRF_COLORS( M_Frame, M_Grid, M_Scale, M_ScaleTit, M_Title, M_Legend, M_Bg )
         ENDIF

         G_LABEL('GRAPH TITLE COLOR')
         X_LABEL('X TITLE COLOR')
         Y_LABEL('Y TITLE COLOR')
*
         SET_TYPE(1,3)
         SET_TYPE(2,3)
         SET_TYPE(3,3)
         SET_TYPE(4,3)
         SET_TYPE(5,3)
*
         STORE_DATA("< 1",83,45,23,15)
         STORE_DATA("1-5",124,76,45,20)
         STORE_DATA("6-10",89,56,34,16)
         STORE_DATA("11-18",45,34,23,12)
         STORE_DATA("19-55",34,23,12,8)
         STORE_DATA("> 55",125,82,67,20)
         LEGEND_SET( 1, "Column 1" )
         LEGEND_SET( 2, "Column 2" )
         LEGEND_SET( 3, "Column 3" )
         LEGEND_SET( 4, "Column 4" )
*
         PLOT()
*
         LEGEND_SAY( ATX(80,2), ATY(20,2), 1 )
*
         inkey(0)
         TEXTMODE()
   ENDCASE
ENDDO
