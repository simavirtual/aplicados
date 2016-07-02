*******************************************************************************
*  G_EXAM04.PRG                                                               *
*  Author: Gary Prothero                                                      *
*  Requirements: None                                                         *
*  Description:                                                               *
*        This program demonstrates many things.  It shows how to use different*
*        data types for the x-axis, such as character, date, and numeric data.*
*        This program demonstrates how to display multiple graphs on one      *
*        screen, and it shows how to use stacked bar charts with different    *
*        fill patterns.                                                       *
*  Chapter 3, Customizing the Graph                                           *
*******************************************************************************
FLIP_INIT(6000)
*
INITDATA(7)
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
STORE_DATA('Ch1',3,20,3,20,3,20)
STORE_DATA('Ch2',5,18,5,18,5,18)
STORE_DATA('Ch3',10,12,10,12,10,12)
STORE_DATA('Ch4',13,15,13,15,13,15)
G_LABEL("Character X axis")
PLOT()
*
INITDATA(7)
SET_AREA(50,0,100,48)
STORE_DATA(DTOC(M_date),3,20,3,20,3,20)
STORE_DATA(DTOC(M_date+5),5,18,5,18,5,18)
STORE_DATA(DTOC(M_date+10),10,12,10,12,10,12)
STORE_DATA(DTOC(M_date+15),13,15,13,15,13,15)
G_LABEL("Dates entered as characters")
PLOT()
*
INITDATA(7)
SET_AREA(0,52,50,100)
STORE_DATA(1,3,20,3,20,3,20)
STORE_DATA(2,5,18,5,18,5,18)
STORE_DATA(3,10,12,10,12,10,12)
STORE_DATA(4,13,15,13,15,13,15)
G_LABEL("Numeric X axis")
PLOT()
*
INITDATA(7)
SET_AREA(50,52,100,100)
STORE_DATA(M_date,3,20,3,20,3,20)
STORE_DATA(M_date+5,5,18,5,18,5,18)
STORE_DATA(M_date+10,10,12,10,12,10,12)
STORE_DATA(M_date+15,13,15,13,15,13,15)
G_LABEL("Date X axis")
PLOT()
*
INKEY(0)
TEXTMODE()
