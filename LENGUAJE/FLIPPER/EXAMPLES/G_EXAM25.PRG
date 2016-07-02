****************************************************
*                                                  *
*    G_EXAM25.PRG  -  Return Print Driver Info     *
*                                                  *
****************************************************
FLIP_INIT(1000)
CLEAR SCREEN
*
number = PRT_LIST("C:\FLIPPER\LIBRARY\PRX_TBL.BIN") && Return number of printers
? 'number: '
?? number
DECLARE PRINT_NAME[number]
PRT_LIST( PRINT_NAME )
*
M_ans = ACHOICE(2,10,22,40,PRINT_NAME)
IF M_ans > 0
   M_id = VAL(SUBSTR(PRINT_NAME[M_ans],1,4))
   ? M_id
   wait
ENDIF
