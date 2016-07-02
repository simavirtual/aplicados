/*

    96.03.23    Blinker test program to dynamically call a Windows DLL

*/

#include <windows.h>
#include <stdio.h>
#include <string.h>

typedef char * (* TEST) (int);         // Good coding to define its parameters

static char LibName[] = "c:\\D.DLL";       // The library it is in
static char FunName[] = "TESTEXP";     // The function we want to call

void main (void)
{
   char        msgbuf [100];
   HWND        hLibInst;
   TEST        TestPtr;
   int         WasOK = 0;

   printf ("Hello\n");                 // Indicate we are up and running

   printf ("Press a key to call %s in library %s ",
               FunName, LibName);

   _asm mov ah,0
   _asm int 16h                        // Get a key stroke

/* Attempt to load the library */

   if ( (hLibInst = LoadLibrary (LibName)) > HINSTANCE_ERROR )
      {
      TestPtr = (TEST) GetProcAddress (hLibInst, FunName);
      if ( TestPtr )
         {
         sprintf (msgbuf, "%s returned ", FunName);
         strcat (msgbuf, (*TestPtr) (1));
         WasOK++;
         }
      else
         sprintf (msgbuf, "%s%s%s", FunName,
                           " does not exist in library ",
                           LibName);
      }
   else
      {
      if (hLibInst == 2)
         strcpy (msgbuf, "Unable to find ");
      else
         strcpy (msgbuf, "Error loading ");
      strcat (msgbuf, LibName);
      }

/* Display the result */

   printf ("\n%s\n",msgbuf);

/* Unload the library */

   if (hLibInst > HINSTANCE_ERROR)
      FreeLibrary (hLibInst);

   printf ("Goodbye\n");               // Indicate we are out of here
}
