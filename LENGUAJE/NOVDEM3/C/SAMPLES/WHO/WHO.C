/*

	Who

    by Goth.

*/


#include <windows.h>
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include "novlibc.h"
#include "who.h"

static HWND hListBox1, hDisplayBox;
static char szAppName[] = "Who";
WORD wTimer = 0;
WORD wInterval = 1000;
long ConnectionNumber;

int PASCAL WinMain( HANDLE hInstance, HANDLE hPrevInstance, LPSTR lpszCmdLine, int nCmdShow )
{

	MSG			msg;

   	if(!hPrevInstance)
		if( !InitApplication( hInstance ) )
			return( FALSE );	                           

 	if( !InitInstance( hInstance, nCmdShow ) )
  		return( FALSE );

	while ( GetMessage( &msg, NULL, 0, 0 ) )
	{
		TranslateMessage( &msg );
		DispatchMessage( &msg );
	}

	return( msg.wParam );
}


BOOL InitApplication( HANDLE hInstance )
     {    
     
     	  WNDCLASS wndclass;
     
          wndclass.style         = CS_HREDRAW | CS_VREDRAW ;
          wndclass.lpfnWndProc   = WndProc ;
          wndclass.cbClsExtra    = 0 ;
          wndclass.cbWndExtra    = DLGWINDOWEXTRA ;
          wndclass.hInstance     = hInstance ;
          wndclass.hIcon         = LoadIcon( hInstance, MAKEINTRESOURCE( IDI_ICON1 ) ) ;
          wndclass.hCursor       = LoadCursor (NULL, IDC_ARROW) ;
          wndclass.hbrBackground = GetStockObject(WHITE_BRUSH) ;
          wndclass.lpszMenuName  = NULL ;
          wndclass.lpszClassName = szAppName ;

          return( RegisterClass (&wndclass) );
	  }


BOOL InitInstance( HANDLE hInstance, int nCmdShow )
	{
		HWND hWnd;
		
		hWnd = CreateDialog( hInstance, szAppName, 0, NULL );

		if( !hWnd )
			return( FALSE );

        WSConnNumberGet();
        if (NWErrorGet() != 0)
        {
            MessageBox( hWnd, "This program requires a Novell Network", "Error", MB_OK | MB_ICONEXCLAMATION );
            NovTaskEnd() ;
			DestroyWindow( hWnd );
            return( FALSE );
        }

        if( !UsrCurConsoleOperatorTest() )
		{
            MessageBox( hWnd, "This program requires Console Operator or Supervisor Status", "Error", MB_OK | MB_ICONEXCLAMATION );
            NovTaskEnd() ;
			DestroyWindow( hWnd );
			return( FALSE );
		}	

		hListBox1 = GetDlgItem( hWnd, IDC_LIST1 );
		hDisplayBox = GetDlgItem( hWnd, IDC_LIST2 );
        SetDlgItemInt(hWnd, IDC_EDIT1, wInterval, FALSE);

		GetConnectionList();
        
		ShowWindow( hWnd, nCmdShow );

        return( TRUE );
        
	}
        
        
long FAR PASCAL _export WndProc( HWND hWnd, UINT message, UINT wParam, LONG lParam )
{

	static int	Counter = 0;

	switch ( message )
	{

		case WM_CREATE:

				wTimer = SetTimer(hWnd, ID_TIMER, wInterval, NULL);
				break;

		case WM_SETFOCUS:
				SetFocus( hListBox1 );
				break;

		case WM_COMMAND:

				if( wParam == IDC_BUTTON1 )
				{
					DestroyWindow( hWnd );
					break;
				}	

				if( wParam == IDOK )
				{

		        	wInterval = GetDlgItemInt(hWnd, IDC_EDIT1, NULL, FALSE);
    		        KillTimer(hWnd, ID_TIMER);
					wTimer = SetTimer(hWnd, ID_TIMER, wInterval, NULL);
					break;
				}	

				if ( ( wParam == IDC_LIST1 ) && ( HIWORD( lParam ) == LBN_SELCHANGE ) )
				{
					GetFileList();
                    GetConnectionInfo( hWnd );

                }
				break;

        case WM_TIMER:

                if(++Counter == 10)
                {
                    Counter = 0;
                    GetFileList();
                }

	            break;

		case WM_DESTROY:
	            if( wTimer )
    	        	KillTimer(hWnd, ID_TIMER);
                NovTaskEnd();
                PostQuitMessage( 0 );
				break;

		default:
			return DefWindowProc( hWnd, message, wParam, lParam );
	}

	return 0;
}


void GetConnectionList( void )
{
	char		szBuffer[80];
 	int			completionCode;
	int			PeakConnections;
	int			i;
	char		objectName[48];

	SendMessage( hDisplayBox, LB_RESETCONTENT, 0, 0L );
	SendMessage( hListBox1, LB_RESETCONTENT, 0, 0L );
	SendMessage( hListBox1, WM_SETREDRAW, FALSE, 0L );

    PeakConnections = FSPeakConnGet();

    completionCode = NWErrorGet();

	if( completionCode == -5 )
	{
        sprintf( szBuffer, "ERROR : FSPeakConnGet returned %X", completionCode );
        MessageBox( NULL, szBuffer, "FSPeakConnGet", MB_OK | MB_ICONHAND );
	}

	for( i = 1; i <= PeakConnections; i++ )
	{
               
     WSLoginNameGet(i, objectName );

        if( *(objectName) != '\0' )
        {
        	                                 
			sprintf( szBuffer, "%3u %s", i, objectName );
			
			SendMessage( hListBox1, LB_ADDSTRING, 0, (LONG)szBuffer );
			
        }

	}

	InvalidateRect( hListBox1, NULL, TRUE );
	SendMessage( hListBox1, WM_SETREDRAW, TRUE, 0L );

}

void GetFileList( void )
{

	char 			szBuffer[132];
    char            fileName[128];
	int				x;
	char			objectName[48];
	char			searchObjectName[48];
	WORD			sequenceNumber;

	x = (WORD) SendMessage( hListBox1, LB_GETCURSEL, 0, 0L );
	SendMessage( hListBox1, LB_GETTEXT, x, (LONG) objectName );

	if( !( x == LB_ERR ) )
	{

		SendMessage( hDisplayBox, LB_RESETCONTENT, 0, 0L );
		SendMessage( hDisplayBox, WM_SETREDRAW, FALSE, 0L );

		strcpy( searchObjectName, objectName );
		ConnectionNumber = atol( searchObjectName );
		sequenceNumber = 1;

		while ( 1 )
		{
            FilOpenFileList( (WORD)ConnectionNumber, sequenceNumber, fileName );
            sprintf( szBuffer, "%s", fileName );

            if( !NWErrorGet() )
				SendMessage( hDisplayBox, LB_ADDSTRING, 0, (LONG)szBuffer );
			else
				break;	

			sequenceNumber++;
		}

		InvalidateRect( hDisplayBox, NULL, TRUE );
		SendMessage( hDisplayBox, WM_SETREDRAW, TRUE, 0L );
		
	}	

}

void GetConnectionInfo( HWND hWnd )
{

	char	szAddress[50];
    char    NetAddress[15];
    char    NodeAddress[15];
    char    LoginDate[11];
    char    LoginTime[9];
	char	Month[3];
	char	Months[12][10] = { "January", "February", "March", "April", "May", "June", "July", "August",
     				           "September", "October", "November", "December" };

    WSNetAddressGet( (WORD)ConnectionNumber, NetAddress );
    WSNodeAddressGet( (WORD)ConnectionNumber, NodeAddress );

    sprintf( szAddress, " %s:%s", NetAddress, NodeAddress );

	SetDlgItemText( hWnd, IDC_EDIT5, szAddress );
	
    WSLoginDateGet( (WORD)ConnectionNumber, LoginDate ) ;

	strncpy( Month, LoginDate + 4, 2 );   
	Month[2] = '\0';

    sprintf( szAddress, " %s  %2.2s,  %4.4s", Months[atoi( Month ) - 1], (LoginDate + 6), LoginDate );

	SetDlgItemText( hWnd, IDC_EDIT3, szAddress );

    WSLoginTimeGet( (WORD)ConnectionNumber, LoginTime );

    sprintf( szAddress, " %s", LoginTime );
	
	SetDlgItemText( hWnd, IDC_EDIT4, szAddress );
	
}
