/*

    96.03.23    Blinker DOS extended DLL test program

*/

#undef _WINDLL                      /* Allow all the DOS functions */

#include <stdio.h>
#include <blinker.h>
#include <blx286.h>

int __export testprintf (char *testStr)
{
   printf ("Blinker version number = %d\n",BLIVERNUM());
   printf ("TESTSTR = %s",testStr);
   return 1;
}

