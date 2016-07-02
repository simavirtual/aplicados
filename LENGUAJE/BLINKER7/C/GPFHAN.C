/*
      Replacement GPF Handler test
*/

#include <stdio.h>
#include <stdlib.h>

#include <blx286.h>

PEXCHAN prevhandler;

void printstr (char *s)       /* Cannot use library screen handling */
{
   char c;

   while (c = *(s++))         /* Until end of string */
      {
      __asm  mov ah,0eh
      __asm  mov al,c
      __asm  int 10h          /* Display teletype */
      }
}

void __interrupt __far gpfhandler(EXCEP_FRAME ef)
{
   char  errmsg [80];

   printstr ("Replacement GPF handler\n\r");
   printstr ("-----------------------\n\r");
   sprintf (errmsg,"Error code = %04x\n\r",ef.error_code);
   printstr (errmsg);
   sprintf (errmsg,"     CS:IP = %04x:%04x\n",ef.ret_cs,ef.ret_ip);
   printstr (errmsg);

   DosSetExceptionHandler (0x0d,prevhandler,NULL);
   exit (255);
}

int main (void)
{
   PEXCHAN newhandler;

   newhandler = gpfhandler;
   if (DosSetExceptionHandler (0x0d,newhandler,&prevhandler) == 0)
   {
      *((USHORT __far *) 0x22222222L) = 1;

      printf("Somehow no exception occurred\n");
      DosSetExceptionHandler (0x0d,prevhandler,NULL);
   }
   return (1);
}

