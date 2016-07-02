*********** Sample programs for Nantucket Tools II / 5.01 ********
*
* Program     : HANDSHK2.PRG
* Copyright   : (c) 1991, Nantucket  Corp.  All rights reserved.
* Date        : 01/10/91
* Author      : Lothar Bongartz / Michael Peters
* Description : Part 2 of handshake demo
* Compiling   : CLIPPER HANDSHK2
* Linking     : RTLINK FI HANDSHK2 LIB NT250
* Remarks     : The opposite of this demo you will find in the
*               file HANDSHK1.PRG in this directory! There, you
*               also will find a detailed description of both
*               programs.
*
*******************************************************************

CLS

 nPort := 1

 ? COM_OPEN(nPort, 1000, 30000)      // a big send buffer
 ? COM_INIT(nPort, 300, "N", 8, 1)

 ? COM_HARD(nPort, .T.)              // both kinds of handshake..
 ? COM_SOFT(nPort, .T.)              // ... at the same time!

 String = REPLICATE("123", 10000)    // a string with 30k ...
 COM_SEND(nPort, String)             // ... into the buffer

 nKey   = 0
 DO WHILE nKey   <> 27
  ? SECONDS(), COM_SCOUNT(nPort)     // what is left in the send buffer ?
  nKey   = INKEY()
 ENDDO

 ? COM_CLOSE(nPort)                  // always close the port!
RETURN

