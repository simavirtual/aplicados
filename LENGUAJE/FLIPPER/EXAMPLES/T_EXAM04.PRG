*
* T_EXAM04.PRG  ( Page 1-10 )
*
FLIP_INIT(1000)
SET_SAYERR(1)

mFont1 = FONT_OPEN("\FLIPPER\FONTS\TTL8_48.@")
mFont2 = FONT_OPEN("\FLIPPER\FONTS\OE3_22.@")
mFont3 = FONT_OPEN("\FLIPPER\FONTS\SSD1_20.@")

INITDATA(7)

SET_TYPE(1,1)
SET_TYPE(2,1)
SET_TYPE(3,1)
SET_TYPE(4,1)
SET_TYPE(5,1)
SET_TYPE(6,1)

STORE_DATA("IBM",    10, 200, 100, 76, .58, 24)
STORE_DATA("MAC",    9,  180, 90,  69, .63, 21)
STORE_DATA("COMPAQ", 5,  125, 60,  48, .41, 13)
STORE_DATA("AMIGA",  7,  105, 50,  45, .22, 10)
STORE_DATA("EPSON",  4,  40,  34,  -5, .24, 11)

G_LABEL("COMPUTER SALES")
X_LABEL("Computer Company")
Y_LABEL("Computers Sold")
SET_G_FONT(mFont1)
SET_L_FONT(mFont2)
SET_S_FONT(mFont3)

PLOT()

INKEY(0)
TEXTMODE()

