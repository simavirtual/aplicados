/**************************************************************
*
* PHAPI.H       97.11.06
*
***************************************************************/

#include <blx286.h>

#ifndef __BORLANDC__
typedef void (_interrupt _far *PIHANDLER)(REGS16 regs);
#else
typedef void (_interrupt _far *PIHANDLER)(REGS16BOR regs);
#endif

typedef void (_interrupt _far *PEHANDLER)(EXCEP_FRAME regs);
