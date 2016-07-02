/*

    96.03.23    Blinker DOS extended DLL test program

*/

#include <stdio.h>
#include <stdlib.h>

void main(void);
int testprintf (char *testStr);

void main(void)
{
   int results;

   printf ("DOS extended DLL test\n\n");

   results = testprintf ("This was printed from a DLL\n");
   printf ("\nResults = %i\n",results);

   exit(0);
}

