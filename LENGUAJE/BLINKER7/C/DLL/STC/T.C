/*

    96.03.23    Blinker test program to statically call a Windows DLL

*/

#include <stdio.h>

char * test (void);                    // Declare the DLL function

void main (void)
{
   printf ("Hello\n");                 // Indicate we are up and running

   printf ("TEST returned %s\n",test());  // Call the DLL and display the result

   printf ("Goodbye\n");               // Indicate we are out of here
}
