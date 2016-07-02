/*

    96.03.23    Blinker Windows static DLL demonstration program

*/

#include <windows.h>
#include <string.h>

char * test (void);                    // Good coding to define its parameters

long FAR PASCAL _export WndProc (HWND, UINT, UINT, LONG) ;

int PASCAL WinMain (HANDLE hInstance, HANDLE hPrevInstance,
                    LPSTR lpszCmdParam, int nCmdShow)
     {
     static char szAppName[] = "Static DLL test " ;
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
                    "Static DLL test",       // Window caption
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
     HDC         hdc ;
     PAINTSTRUCT ps ;
     RECT        rect ;
     char        msgbuf [100] ;

     switch (message)
          {
          case WM_PAINT:
               hdc = BeginPaint (hwnd, &ps) ;

               GetClientRect (hwnd, &rect) ;

/* Call the DLL */

               wsprintf (msgbuf, "TEST returned %s", test());

/* Display the result */

               DrawText (hdc, msgbuf, -1, &rect,
                         DT_SINGLELINE | DT_CENTER | DT_VCENTER) ;

               EndPaint (hwnd, &ps) ;
               return 0 ;

          case WM_DESTROY:
               PostQuitMessage (0) ;
               return 0 ;
          }

     return DefWindowProc (hwnd, message, wParam, lParam) ;
     }

