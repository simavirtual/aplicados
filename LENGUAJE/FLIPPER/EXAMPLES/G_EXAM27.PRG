FLIP_INIT(2000)

DO WHILE .T.

* Prepare the Graph
   INITDATA(5)
   SET_AREA(0,0,100,92)
   FOR i = 1 TO 4
       SET_TYPE(i,3)
   NEXT
   SET_LN_PAT(1,0)
   SET_LN_PAT(2,2)
   SET_LN_PAT(3,3)
   SET_LN_PAT(4,6)
   SET_STYLE(1,1)
   SET_STYLE(2,8)
   SET_STYLE(3,3)
   SET_STYLE(4,5)
   FOR i = 1 TO 4
       SET_COLOR(i,i+9)
   NEXT
   SET_GRID(1,1,4)

* How many data points do we send?
   howmany = 0
   @ 24, 0 SAY 'How many ? ' GET howmany PICT '999'
   READ
   IF howmany = 0
      RETURN
   ENDIF

* Send howmany by 4 data points
   FOR i = 1 TO howmany
       STORE_DATA(i, i, i+1, i+2, i+3)
   NEXT

* Display the screen
   FSCREEN()
   PLOT()
   INKEY(0)
   FLP_RESET()
   TEXTMODE()

ENDDO
