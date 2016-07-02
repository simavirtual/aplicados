/*

    96.03.23    Blinker Windows dynamic DLL demonstration program

*/

#include <windows.h>
#include <string.h>

typedef char * (* TEST) (int) ;        // Good coding to define its parameters

static char LibName[] = "D.DLL" ;      // The library it is in
static char FunName[] = "TESTEXP" ;    // The function we want to call

static int  Active = 0 ;               // This is tacky but easier

long FAR PASCAL _export WndProc (HWND, UINT, UINT, LONG) ;

int PASCAL WinMain (HANDLE hInstance, HANDLE hPrevInstance,
                    LPSTR lpszCmdParam, int nCmdShow)
     {
     static char szAppName[50] = "Dynamic DLL test " ;
     HWND        hwnd ;
     MSG         msg ;
     WNDCLASS    wndclass ;

     // Access parameter

     strcat (szAppName, lpszCmdParam);

     if (!hPrevInstance)
          {
          wndclass.style         = CS_HREDRAW | CS_VREDRAW ;
          wndclass.lpfnWndProc   = WndProc ;
          wndclass.cbClsExtra    = 0 ;
          wndclass.cbWndExtra    = 0 ;
          wndclass.hInstance     = hInstance ;
          wndclass.hIcon         = LoadIcon (NULL, IDI_APPLICATION) ;
          wndclass.hCursor       = LoadCursor (NULL, IDC_ARROW) ;
          wndclass.hbrBackground = GetStockObject (WHITE_BRUSH) ;
          wndclass.lpszMenuName  = NULL ;
          wndclass.lpszClassName = szAppName ;

          RegisterClass (&wndclass) ;
	  }

     hwnd = CreateWindow (szAppName,         // Window class name
                    "Dynamic DLL test",      // Window caption
                    WS_OVERLAPPEDWINDOW,     // Window style
                    CW_USEDEFAULT,           // Initial x position
                    CW_USEDEFAULT,           // Initial y position
                    CW_USEDEFAULT,           // Initial x size
                    CW_USEDEFAULT,           // Initial y size
                    NULL,                    // Parent window handle
                    NULL,                    // Window menu handle
                    hInstance,               // Program instance handle
                    NULL) ;                  // Creation parameters

     ShowWindow (hwnd, nCmdShow) ;
     UpdateWindow (hwnd) ;

     while (GetMessage (&msg, NULL, 0, 0))
          {
          TranslateMessage (&msg) ;
          DispatchMessage (&msg) ;
          }
     return msg.wParam ;
     }

long FAR PASCAL _export WndProc (HWND hwnd, UINT message, UINT wParam,
                                                          LONG lParam)
     {
     PAINTSTRUCT ps ;
     RECT        rect ;
     char        msgbuf [100] ;
     HWND        hLibInst ;
     TEST        TestPtr ;
     int         WasOK = 0 ;

     switch (message)
          {
          case WM_PAINT:
               if ( Active ) break;    // This is tacky but easier

               Active++;

               BeginPaint (hwnd, &ps) ;

               GetClientRect (hwnd, &rect) ;

               wsprintf (msgbuf, "Press a key to call %s in library %s",
                         FunName, LibName);
               MessageBox (hwnd, msgbuf, "",
                   MB_APPLMODAL | MB_ICONQUESTION | MB_OK);

/* Attempt to load the library */

               if ( (hLibInst = LoadLibrary (LibName)) > HINSTANCE_ERROR )
                  {
                  TestPtr = (TEST) GetProcAddress (hLibInst, FunName);
                  if ( TestPtr )
                     {
                     wsprintf (msgbuf, "%s returned ", FunName);
                     strcat (msgbuf, (*TestPtr) (1));
                     WasOK++;
                     }
                  else
                     wsprintf (msgbuf, "%s%s%s", FunName,
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

               MessageBox (hwnd, msgbuf, "",
                   MB_APPLMODAL | (WasOK ? MB_ICONINFORMATION : MB_ICONEXCLAMATION) | MB_OK);

/* Unload the library */

               if (hLibInst > HINSTANCE_ERROR)
                  FreeLibrary (hLibInst);

               PostQuitMessage (0) ;

               EndPaint (hwnd, &ps) ;
               return 0 ;

          case WM_DESTROY:
               PostQuitMessage (0) ;
               return 0 ;
          }

     return DefWindowProc (hwnd, message, wParam, lParam) ;
     }

