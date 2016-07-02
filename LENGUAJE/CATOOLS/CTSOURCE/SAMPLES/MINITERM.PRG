*********** Sample programs for CA-Clipper Tools / 5.2 ************
*
* Program     : MINITERM.PRG
* Copyright   : (c) 1991-93, Computer Associates International.
*               All rights reserved.
* Date        : 11/24/90
* Author      : Michael Peters / Lothar Bongartz
* Description : Minimal communication program for the serial
*               interface
* Compiling   : CLIPPER MINITERM
* Linking     : RTLINK FI MINITERM LIB CT
* Remarks     :
*
* MINITERM is a minimal communication program reduced to the
* kernel of the real problems.
* It is only to show how to build up a serial communication,
* e.g. with a modem.
*
*******************************************************************

*******************************************************************
* Open and initialize the interface
*******************************************************************

 CLS
 @ 2, 0 SAY CENTER("MINITERM - minimal terminal program - cancel with ALT-X")

 SETRC(4, 0)
 nComPort := 0
 INPUT "number of interface (1-4) -> " TO nComPort

 nBaud     := 2400
 cParity   := "N"
 nDatabit  := 8
 nStopbit  := 1
 nBuffSize := 1000

 * fault tolerant open and initialize of the interface

 SETRC(6, 0)

 IF COM_OPEN(nComPort, nBuffSize)
   IF COM_INIT(nComPort, nBaud, cParity, nDatabit, nStopbit)
    DIALOG()
   ELSE
    ? "interface could not be initialized - please verify!"
   ENDIF

   COM_CLOSE(nComPort)
 ELSE
  ? "interface could not be opened - please verify!"
 ENDIF

RETURN

************************************************************************

FUNCTION DIALOG()

 * In contrast to BASIC, through COM_OPEN(), COM_INIT() the
 * DTR output signal of the serial interface is not activated, as this
 * handling has not to be absolutely correct.
 * Usually however, modems need an active DTR to answer. The function
 * should be called as follows:

  COM_DTR(nComPort, .T.)
  MILLISEC(1000)                     // The modem should have some time ...

 * Now, the initialization of the modem could follow.
 * The basis for the following example is a HAYES- or compatible
 * modem, that is interpreting the so-called AT commands.
 * At first, the modem gets a RESET (ATZ), then ECHO (E) and
 * 'LONG RESULT CODES' (V) will be activated --> the modem returns
 * an echo for every received character and confirms commands with
 * e.g. 'OK'.
 * NOTE : Not always, the enhanced commands of 'Hayes compatible'
 * modems are compatible. For further details please see the
 * manual of your modem!

  ? SEND2MODEM(nComPort, "ATZ" + CHR(13))
  ? SEND2MODEM(nComPort, "ATE1 V1" + CHR(13))

 *

**************************************************************************
*  MAIN PROCEDURE
**************************************************************************

* The main task of the terminal program is the output of keyboard
* inputs to the interface and, at an activated local echo, on the
* screen, as well as the output of received characters on the local
* screen.
* The 'local echo' is only needed, if, for any reason, the remote
* station does not return an echo and nevertheless the input has
* to be seen on the screen.
*
* Additionally, the program is handling BACKSPACES:
* The cursor is moved back one position, the position gets one
* blank and the cursor is moved back again.
* NOTE: FULL DUPLEX MODE (echo of the remote station) is handling
*       only arriving backspaces (sent by an echo),
*       HALF DUPLEX MODE (local echo) is also converting input
*       backspaces.
*
* Special function, as seen in other commercial communication
* programs, can be saved in any key sequence.
* EXAMPLES:
* 'ALT H' interrupts the DTR signal for 1.5 seconds and an
* existing modem connection usually breaks down.
* 'F2' turns local echo on and off.
* 'F3' clears the screen.
* 'ALT X' quits the program.
*

 lEcho := .F.
 nKey  := INKEY()

 DO WHILE nKey <> 301
  DO CASE
    CASE nKey = 291                  // ALT-H
       COM_DTR(nComPort, .F.)        // interrupt DTR for 1.5 sec.
       MILLISEC(1500)
       COM_DTR(nComPort, .T.)
    CASE nKey = 13
       * Add lineFeed to carriageReturn
       COM_SEND(nComPort, CHR(13) + CHR(10))
       IF lEcho
        ?
       ENDIF
    CASE nKey = 8                    // backspace handling
      COM_SEND(nComPort, nKey)       // single numeric character -> Port
      IF lEcho .AND. COL() > 0
        SETRC(ROW(), COL() -1)
         ?? " "
        SETRC(ROW(), COL() -1)
      ENDIF
    CASE nKey > 0
      COM_SEND(nComPort, nKey)         // single numeric character -> Port
      IF lEcho
       ?? CHR(nKey)                  // pos. local echo
      ENDIF
    CASE nKey = -1
      lEcho := .NOT. lEcho           // shift echo mode
    CASE nKey = -2
      @ 0,0 CLEAR                    // clear screen
    CASE nKey = -3
     * any user routines like dial directories and others can be called.
  ENDCASE

  IF COM_COUNT(nComPort) > 0
   cChar := COM_READ(nComPort, 1)    // output of received characters

   * pos. handle backspace
   *
    IF cChar = CHR(8)
     IF COL() > 0
       SETRC(ROW(), COL() -1)
        ?? " "
       SETRC(ROW(), COL() -1)
     ENDIF
    ELSE
     ?? cChar
    ENDIF
  ENDIF

  nKey := INKEY()
 ENDDO
RETURN("")


******************************************************************
FUNCTION SEND2MODEM(nComPort, cModemCmd)
LOCAL cChar := "", cModemResult := "", lLfDetected := .F.
*
* The following function is used to send AT commands to HAYES
* compatible modems and to wait, until the modem has processed
* the command.
* Depending on the ATEn- and ATVn- settings of the modem (echo
* ON/OFF, long/short result codes), not only CR, but also other
* different returns are possible.
*
* If echo is turned on, the sent command sequence including CR
* will be returned.
* If echo is turned off, at 'long results' CR + LF + <answer> +
* CR + LF , at 'short results' (digits) only the digit and CR
* will be returned.

* Therefore, the following function is adding the received
* characters. If the received part is exactly corresponding
* to the sent part, it will be displayed (echo) and discarded
* at once.
*
* A single CR in the variable cModemResult will also be discarded,
* CR's before the real 'result code' are not interesting.
*
* LF's are discarded on principal, but the function is able to
* notice if there was a LF or not. If the dataflow was containing
* a LF, after recognition of the real 'result code' a terminating LF
* has to be expected and discarded to avoid 'garbage' in the buffer.
* Depending on ATVn, there is not always a LF at the end of a
* 'result code'!
*
* If, under consideration of these rules, a CR is received and
* the variable cModemResult is containing other data, this has to
* be the valid 'result code'.
*
* The described method is certainly more elegant than waiting a
* fixed time for an answer. As a lot of programs do that, they
* need a lot of time e.g. to initialize a modem.
*
* We will hope, that all HAYES compatible modems are doing like
* the used US-ROBOTICS!
*
 COM_FLUSH(nComPort)                 // remove pos. garbage
 COM_SFLUSH(nComPort)                // do.
 COM_SEND(nComPort, cModemCmd)       // send to modem

 WAITPERIOD(200)

 DO WHILE COM_SCOUNT(nComPort) > 0 .AND. WAITPERIOD()
  * At interrupt controlled transmission you have to wait until
  * all data have been sent.
 ENDDO

 IF COM_SCOUNT(nComPort) = 0
  WAITPERIOD(200)

  DO WHILE (cChar <> CHR(13) .OR. LEN(cModemResult) <= 1) .AND. WAITPERIOD()
   IF COM_COUNT(nComPort) > 0
    cChar := COM_READ(nComPort, 1)

    IF cChar = CHR(10)
     lLfDetected  := .T.
    ELSE
     cModemResult := cModemResult + cChar
    ENDIF

    IF cModemResult == cModemCmd     // discard command echo
     ? cModemResult
     cModemResult := ""
    ENDIF

    IF cModemResult == CHR(13)       // discard leading (single) CR
     cModemResult := ""
    ENDIF
   ENDIF
  ENDDO

  IF "" = cModemResult
    cModemResult := "fault at AT command   : " + cModemCmd
  ELSE
   IF lLfDetected                    // ev. wait for terminating LF
     cChar = ""
     WAITPERIOD(50)
     DO WHILE cChar <> CHR(10) .AND. WAITPERIOD()
      cChar := COM_READ(nComPort, 1)
     ENDDO
   ENDIF
  ENDIF

  cModemResult := cModemResult + CHR(10)
 ENDIF

RETURN(cModemResult)