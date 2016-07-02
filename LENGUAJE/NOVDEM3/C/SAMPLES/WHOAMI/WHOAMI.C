/*

  a ( sort of ) emulation of NetWare's WHOAMI utility for Windows,
  using NOVLIB functions.

  by Goth.

  tested: MSVC 1.5.LIB	Small,	Medium,	Large.
                   DLL	N/A		N/A		Large.
*/


#include <windows.h>
#include <string.h>
#include <stdio.h>
#include <stdlib.h>
#include "novlibc.h"

BOOL InitApplication( HANDLE );
BOOL InitInstance( HANDLE, int );

long FAR PASCAL _export WndProc(HWND, UINT, UINT, LONG);

static char szAppName[] = "Who Am I ?" ;

int PASCAL WinMain (HANDLE hInstance, HANDLE hPrevInstance,
                    LPSTR lpszCmdParam, int nCmdShow)
     {

	    MSG         msg;

     	if(!hPrevInstance)
			if( !InitApplication( hInstance ) )
				return( FALSE );

	 	if( !InitInstance( hInstance, nCmdShow ) )
	  		return( FALSE );

     	while (GetMessage (&msg, NULL, NULL, NULL))
     	{
        	TranslateMessage (&msg) ;
        	DispatchMessage (&msg) ;
     	}

     	return( msg.wParam );

     }

BOOL InitApplication( HANDLE hInstance )
     {

     	  WNDCLASS wndclass;

          wndclass.style         = CS_HREDRAW | CS_VREDRAW ;
          wndclass.lpfnWndProc   = WndProc ;
          wndclass.cbClsExtra    = 0 ;
          wndclass.cbWndExtra    = 0 ;
          wndclass.hInstance     = hInstance ;
          wndclass.hIcon         = LoadIcon ( hInstance, "NLWHO" ) ;
          wndclass.hCursor       = LoadCursor (NULL, IDC_ARROW) ;
          wndclass.hbrBackground = GetStockObject(WHITE_BRUSH) ;
          wndclass.lpszMenuName  = "NOVLIB Demo";
          wndclass.lpszClassName = szAppName ;

          return( RegisterClass (&wndclass) );
	  }

BOOL InitInstance( HANDLE hInstance, int nCmdShow )
     {

     	HWND hWnd;

     	hWnd = CreateWindow (szAppName,          // window class name
			            szAppName,               // window caption
            	        WS_OVERLAPPEDWINDOW,     // window style
                	    CW_USEDEFAULT,           // initial x position
                    	CW_USEDEFAULT,           // initial y position
            	        CW_USEDEFAULT,           // initial x size
            	        CW_USEDEFAULT,           // initial y size
            	        NULL,                    // parent window handle
           		        NULL,                    // window menu handle
                    	hInstance,               // program instance handle
				    	NULL) ;		             // creation parameters

		if( !hWnd )
			return( FALSE );

     	return(TRUE);

     }

long FAR PASCAL _export WndProc (HWND hWnd, UINT message, UINT wParam, LONG lParam)
     {

     char	ServerName[48];
     char	LoginName[48];
     char	LoginDate[11];
     char	LoginTime[11];
     char	NetWareVer[5];
	 char	MyText[200];
     char	Month[3];
     int	ConnNum;
     int    OldServer;
     int	NewServer;
     int	Result;
     int    ServerCount;

	 char	Months[12][10] = { "January", "February", "March", "April", "May", "June", "July", "August",
     				           "September", "October", "November", "December" };



     switch (message)
          {

          case WM_CREATE:

            WSConnNumberGet();
            if( NWErrorGet() == 0 )
            {
                OldServer = FSPreferredConnGet();
				NewServer = 1;
                ServerCount = 0;
                while(NewServer <=8 )
				{
                    FSPreferredConnSet( NewServer );
                    if( NWErrorGet() == 0 )
			    	{
                        ServerCount++;
                        FSNameGet(NOVDEFINT, ServerName) ;
                        WSLoginNameGet(NOVDEFINT, LoginName) ;
                        WSLoginDateGet(NOVDEFINT, LoginDate);
                        WSLoginTimeGet(NOVDEFINT, LoginTime) ;
                        NWVersionNumberGet( NetWareVer) ;
             			strncpy( Month, LoginDate + 4, 2 );
             			Month[2] = '\0';

                        ConnNum = WSConnNumberGet();

             			sprintf( MyText,
             			"You are user %s attached to server %s, connection %u.\nServer %s is running NetWare V%s(%u) Rev. %c.\nLogin time: %s   %2.2s,  %4.4s   %s\n",
                        LoginName, ServerName, ConnNum, ServerName, NetWareVer, FSConnMaxGet(),
                        ( (char)(NWRevisionNumberGet()) + 'A' ), Months[atoi( Month ) - 1], (LoginDate + 6), LoginDate,LoginTime );

                        FSPreferredConnSet(OldServer); // Switch back to default

                        Result = MessageBox( hWnd, MyText, szAppName, MB_OK | MB_ICONEXCLAMATION );

					}
                    NewServer++;
                }
                FSPreferredConnSet( OldServer );
                if( NWErrorGet() == 0 )
                  {
                    FSNameGet(NOVDEFINT, ServerName);
                    sprintf( MyText, "You are attached to %u servers\nYour preferred server is %s.", ServerCount, ServerName );
                    MessageBox( hWnd, MyText, szAppName, MB_OK | MB_ICONINFORMATION );
                  }
                  else
                  {
                    sprintf( MyText, "Error - result= : %04X\n - OldServer = %04X - NWErrorGet() = %04X",FSPreferredConnGet(),OldServer, NWErrorGet());
                    MessageBox(hWnd, MyText, szAppName, MB_OK | MB_ICONINFORMATION );
                    MessageBox( hWnd, "Unable to set preferred server", "ERROR !", MB_OK | MB_ICONEXCLAMATION );
                  }
            }
            else
                MessageBox( hWnd, "This program requires a Novell Network?", "ERROR !", MB_OK | MB_ICONEXCLAMATION );

            DestroyWindow( hWnd );
			break;

          case WM_DESTROY:
             NovTaskEnd() ;      // Terminate our instance
             PostQuitMessage (0) ;
             break;


          default:
	     	 return DefWindowProc (hWnd, message, wParam, lParam) ;

          }

		  return 0;
     }
