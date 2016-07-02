*
* C_EXAM7F.PRG - ANOTHER POSTSCRIPT PRINTING EXAMPLE
*
FLIP_INIT(1000)
PS_SETUP()

mFont1 = FONT_OPEN("TTL8_48.@")
mFont2 = FONT_OPEN("OE3_22.@")
mFont3 = FONT_OPEN("SSD1_20.@")

INITDATA(11)

STORE_DATA("IBM",    10, 200, 100, 76, .58, 24, 130, 16, 58, 124)
STORE_DATA("MAC",    9,  180, 90,  69, .63, 21, 60,  89, 63, 121)
STORE_DATA("COMPAQ", 5,  125, 60,  48, .41, 13, 80,  58, 41, 113)
STORE_DATA("AMIGA",  7,  105, 50,  45, .22, 10, 150, 35, 22, 110)
STORE_DATA("EPSON",  4,  40,  34,  -5, .24, 11, 134,  5, 24, 111)

G_LABEL("COMPUTER SALES")
X_LABEL("Computer Company")
Y_LABEL("Computers Sold")
SET_G_FONT(mFont1)
SET_L_FONT(mFont2)
SET_S_FONT(mFont3)

DO WHILE .T.
   CLEAR SCREEN

   @ 21, 0 SAY "Type: "
   @ 21, col()+2 PROMPT 'Line'
   @ 21, col()+2 PROMPT 'Area'
   @ 21, col()+2 PROMPT 'Bar'
   @ 21, col()+2 PROMPT 'Stacked bar'
   @ 21, col()+2 PROMPT 'Points'
   MENU TO M_type

   SET_TYPE(1,M_type)
   SET_TYPE(2,M_type)
   SET_TYPE(3,M_type)
   SET_TYPE(4,M_type)
   SET_TYPE(5,M_type)
   SET_TYPE(6,M_type)
   SET_TYPE(7,M_type)
   SET_TYPE(8,M_type)
   SET_TYPE(9,M_type)
   SET_TYPE(10,M_type)

   @ 22, 0 SAY "Output: "
   @ 22, col()+2 PROMPT 'Screen'
   @ 22, col()+2 PROMPT 'PS printer'
   @ 22, col()+2 PROMPT 'PS file'
   MENU TO M_ans
   DO CASE
      CASE M_ans = 0
         EXIT
      CASE M_ans = 2
         PS_OPEN('LPT1')
      CASE M_ans = 3
         PS_OPEN('FILE')
   ENDCASE

   PLOT()

   IF M_ans > 1
      PS_EJECT()
      PS_CLOSE()
   ELSE
      inkey(0)
      TEXTMODE()
   ENDIF

ENDDO
