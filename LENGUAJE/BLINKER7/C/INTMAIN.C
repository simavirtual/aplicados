/*
      96.11.12    INTMAIN.C

      Contrived example of real and protected mode interrupt handler
*/

#include <conio.h>
#include <stdio.h>
#include <stdlib.h>

#include <blinker.h>
#include <blx286.h>

#define REALINTNO 0x1b
#define PROTINTNO 0x1b

REALPTR oldreal;
PINTHAN oldprot;

#ifdef __WATCOMC__

#pragma aux (BLXMSC) inithandler;      /* Force underscore before names  */
#pragma aux (BLXMSC) prothandler;      /* when using WATCOM C/C++        */
#pragma aux (BLXMSC) realhandler;
#pragma aux asmcall = "int 1bh";       /* Macro for assembly instruction */

#endif

void inithandler (void);
void prothandler (void);
void realhandler (void);

void main(int argc)
{
   long i;
   char c = 0;

   REALPTR newreal;
   PINTHAN newprot;

   inithandler();
   DosGetSegBase (SELECTOROF (realhandler), (PULONG) &i);

   newreal = (REALPTR) ((i << 12) + OFFSETOF (realhandler));
   newprot = (PINTHAN) prothandler;

   printf("About to hook protected mode interrupt.\n");

   if (DosSetProtVec(PROTINTNO, newprot, &oldprot) == 0)
      {
      printf("Protected mode interrupt hooked successfully %Fp\n",oldprot);

      if (DosSetRealVec(REALINTNO, newreal, &oldreal) == 0)
         {
         printf("Real mode interrupt hooked successfully %Fp\n",oldreal);

         printf("\nPress Ctl Break for real mode int 0x1b ('-')");
         printf("\nPress other key for protected mode int 0x1b ('.')");
         printf("\nor Enter to terminate the program\n");

         while ((c = getch())!= 0x0d)     // Loop until Enter
            {
#ifdef __WATCOMC__
            asmcall ();
#else
            _asm  int 1bh                 // Issue 0x1bh in prot mode
#endif
            }
         printf ("\n");
         if (DosSetRealVec(REALINTNO, oldreal, NULL) == 0)
            printf("\nReal interrupt handler deinstalled.\n");
         else
            printf("\nUnable to deinstall real interrupt handler.\n");
         }
      else
         printf("Unable to hook real interrupt.\n");

      if (DosSetProtVec(PROTINTNO, oldprot, NULL) == 0)
         printf("Protected interrupt handler deinstalled.\n");
      else
         printf("Unable to deinstall protected interrupt handler.\n");
      }
   else
      printf("Unable to hook protected interrupt.\n");
}
