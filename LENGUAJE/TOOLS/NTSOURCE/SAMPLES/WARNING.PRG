*********** Sample programs for Nantucket Tools II / 5.01 ************
*
* Program     : WARNING.PRG
* Copyright   : (c) 1991, Nantucket  Corp.  All rights reserved.
* Date        : 20/10/90
* Author      : Lothar Bongartz / Michael Peters
* Description   Tone sequences with the SOUND() function
* Compiling   : CLIPPER WARNING
* Linking     : RTLINK FI WARNING LIB NT250
* Remarks     : Another interesting example for playing
*               sound files you will find in SPLAY.PRG
*
*******************************************************************

* The following sequence is showing an example for an acoustic
* warning, e.g. used in FONTEDIT.PRG

 warn_sound = I2BIN(300) +I2BIN( 10);   // to relax ..........
            + I2BIN(400) +I2BIN( 10);   // tone frequency in hertz,
            + I2BIN(500) +I2BIN( 10);   // duration in 1/100 seconds
            + I2BIN(600) +I2BIN( 10);
            + I2BIN(700) +I2BIN( 10);
            + I2BIN(800) +I2BIN( 10);
            + I2BIN(900) +I2BIN( 10)    // 7 tones in ascending frequency


 SOUND(Warn_sound)
