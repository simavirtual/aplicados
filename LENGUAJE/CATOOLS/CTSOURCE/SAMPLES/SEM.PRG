*********** Sample programs for CA-Clipper Tools / 5.2 ************
*
* Program     : SEM.PRG
* Copyright   : (c) 1992-93, Computer Associates International.
*               All rights reserved.
* Author      : Ralf Saborowski
* Description : How to use Netware semaphores for license
*               limitation....
* Compiling   : CLIPPER SEM
* Linking     : RTLINK FI SEM LIB CT
*
*******************************************************************

LOCAL nSemHandle


// Open Semaphore

nSemHandle=NNETSEMOPN('SEM.PRG')

// Get open count

?  'Application currently active on '+NTOC(NNETSEMOPC(nSemHandle))
?? ' workstation(s)!'

// Close semaphore

NNETSEMCLO(nSemHandle)
