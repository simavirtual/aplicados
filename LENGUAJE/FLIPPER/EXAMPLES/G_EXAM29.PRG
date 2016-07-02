*******************************************************************************
*  G_EXAM29.PRG                                                               *
*  Requirements: None                                                         *
*  Description:                                                               *
*        This program does many things.  It changes the screen palette,       *
*        the fonts for the graph titles, showed multiple graph types on the   *
*        same screen, and used multiple data types for the x-axis.            *
*  Chapters 3, 5, & 6                                                         *
*******************************************************************************
FLIP_INIT(6000)
SET_SAYERR(1)
*
INITDATA(7)
*
mm_sfont=FONT_OPEN("\FLIPPER\FONTS\RMN8_12.@")
mm_lfont=FONT_OPEN("\FLIPPER\FONTS\RMN8_17.@")
*
SET_S_FONT(mm_sfont)
SET_L_FONT(mm_sfont)
SET_G_FONT(mm_lfont)
FONT_NEW(mm_lfont)
*
M_date=CTOD('03/15/88')
*
SET_TYPE(1,4)
SET_TYPE(2,4)
SET_TYPE(3,4)
SET_TYPE(4,4)
SET_TYPE(5,4)
SET_TYPE(6,4)
*
SET_AREA(0,0,50,48)
STORE_DATA('1',3,20,3,20,3,20)
STORE_DATA('2',5,18,5,18,5,18)
STORE_DATA('3',10,12,10,12,10,12)
STORE_DATA('4',13,15,13,15,13,15)
G_LABEL("Stacked Bar Charts")
PLOT()
*
SET_TYPE(1,3)
SET_TYPE(2,3)
SET_TYPE(3,3)
SET_TYPE(4,3)
SET_TYPE(5,3)
SET_TYPE(6,3)
INITDATA(7)
SET_AREA(50,0,100,48)
STORE_DATA("A" ,3 ,4 ,7  ,20 ,28 ,20)
STORE_DATA("B" ,5 ,8 ,15 ,19 ,25 ,18)
STORE_DATA("C" ,1 ,2 ,6  ,12 ,15 ,12)
STORE_DATA("D" ,2 ,5 ,8  ,11 ,13 ,8)
G_LABEL("Cluster Bar Charts")
PLOT()
*
SET_TYPE(1,1)
SET_TYPE(2,1)
SET_TYPE(3,1)
SET_TYPE(4,1)
SET_TYPE(5,1)
SET_TYPE(6,1)
INITDATA(7)
SET_AREA(0,52,50,100)
STORE_DATA(DTOC(M_date)   ,2 ,4 ,7  ,20 ,28 ,20)
STORE_DATA(DTOC(M_date+5) ,5 ,8 ,15 ,19 ,25 ,18)
STORE_DATA(DTOC(M_date+10),1 ,3 ,6  ,12 ,15 ,12)
STORE_DATA(DTOC(M_date+15),2 ,5 ,8  ,11 ,13 ,8)
G_LABEL("Line Charts")
PLOT()
*
INITDATA(7)
SET_AREA(50,52,100,100)
STORE_DATA("White" ,2, 0 )
STORE_DATA("Yellow" ,4, 0 )
STORE_DATA("Magenta" ,1, 0 )
STORE_DATA("Red" ,3, 20 )
PIE_EXPLOD(2)
G_LABEL("Pie Chart")
PIE( 1, 75, 75, 8 )
*
INKEY(0)
TEXTMODE()
