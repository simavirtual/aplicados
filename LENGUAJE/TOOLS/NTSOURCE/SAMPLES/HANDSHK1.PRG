*********** Sample programs for Nantucket Tools II / 5.01 ************
*
* Program     : HANDSHK1.PRG
* Copyright   : (c) 1991, Nantucket  Corp.  All rights reserved.
* Date        : 01/10/90
* Author      : Lothar Bongartz / Michael Peters
* Description : Part 1 of handshake demo
* Compiling   : CLIPPER HANDSHK1
* Linking     : RTLINK FI HANDSHK1 LIB NT250
* Remarks     : The opposite of this demo you will find in the
*               file HANDSHK2.PRG in this directory!
*
* With the programs HANDSHK1.PRG and HANDSHK2.PRG shall be
* demonstrated the behaviour of the serial interface at sending
* in backround under usage of hardware and software handshake.
* To show, that it is working on the sending station both kinds
* of handshake will be turned on. The receiving station simulates
* a remote station, that stops and releases the receiver.
* To be able to observe the behaviour of the sender, this is not
* initiated automatically, but by pressing defined keys.
*
* HANDSHK1 represents the receiver, that shall stop and release
* the sender (the program HANDSHK2.PRG) either via hardware or
* via software handshake. The hardware is consisting of two PC'c
* with standard serial interfaces, which have to be connected as
* follows:
*
* RX/TX (pin 2 and 3 of the interface) are connected crosswise,
* that means pin 2 of computer A with pin 3 of computer B. The
* handshake signals RTS/CTS are connected in the same way -
* pin 4 of computer A with pin 5 of computer B and vice versa
* (for this demo, one of these connections is actually not
* required). At last, the contacts 7 of both interfaces have to
* be connected to produce a frame-ground connection.
*
* The various situations will be initiated by pressing different keys
* on the receiving computer to demonstrate, how the the handshake
* is operating on the sending station.
*
* Space bar : shift status for RTS output
* key F2    : send X-OFF character
* key F3    : send X-ON  character
*
* Now, first the receive program on computer A, then the send
* program on computer B have to be started. As in HANDSHK2 (sender)
* both kinds of handshake are turned on, the data transfer in
* HANDSHK1 (receiver) can be stopped by pressing the space bar
* (hardware handshake) or the F2-key (software handshake) and
* restarted by pressing the space bar or the F3-key.
*
* As the receiver is displaying the number of received characters,
* it is easy to observe if the remote station has been stopped or
* released.
*
* Of course, also higher speed can be set. Depending on the used
* hardware, in the backround can't be send with more than 2400
* baud (8250 interface module). Also the speed of the used PC is
* important!
*
*********************************************************************

#define X_OFF  CHR(19)
#define X_ON   CHR(17)

CLS

 nPort := 1                           // might be changed!

 ? COM_OPEN(nPort, 40000)             // the return values should  ...
 ? COM_INIT(nPort, 300, "N", 8, 1)    // ... be checked

 lStatus = COM_DTR(.T.)
 ? "new status:", lStatus

 nKey = 0
  DO WHILE nKey <> 27                 // cancel with: ESC
   ? COM_COUNT(nPort)                 // number of byte in receive buffer
   nKey   = INKEY(.5)                 // the delay is variable

   IF nKey   = 32                     // BLANK switches handshake signal
    lStatus = .NOT. COM_RTS(nPort)
    ? "new Status:", lStatus
    COM_RTS(nPort, lStatus)
   ENDIF

   IF nKey   = -1                     // X-OFF sent via F2
    COM_SEND(nPort, X_OFF)
   ENDIF

   IF nKey   = -2                     // X-ON  sent via F3
    COM_SEND(nPort, X_ON)
   ENDIF
  ENDDO

 COM_CLOSE(nPort)                     // always close interface!
RETURN

