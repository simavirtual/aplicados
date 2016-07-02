/*

	Simple Bindery Viewer demonstration

    by Goth.

*/


#include <windows.h>
#include <stdio.h>
#include <string.h>
#include "novlibc.h"
#include "bindview.h"

static HWND hListBox1, hListBox2, hDisplayBox, hUserButton, hGroupButton, hFSButton;
static WORD objType = USER;
static char szAppName[] = "BindView";

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

		hListBox1 = GetDlgItem( hWnd, LISTBOX_1 );
		hListBox2 = GetDlgItem( hWnd, LISTBOX_2 );
		hDisplayBox = GetDlgItem( hWnd, DISPLAY_BOX );
		hUserButton = GetDlgItem( hWnd, USER_BUTTON );
		hGroupButton = GetDlgItem( hWnd, GROUP_BUTTON );
		hFSButton = GetDlgItem( hWnd, FS_BUTTON );

		SendMessage( hUserButton, BM_SETCHECK, 1, 0L );
		SendMessage( hGroupButton, BM_SETCHECK, 0, 0L );
		SendMessage( hFSButton, BM_SETCHECK, 0, 0L );

		GetObjectList();
        
		ShowWindow( hWnd, nCmdShow );

        return( TRUE );
        
	}
        
        
long FAR PASCAL _export WndProc( HWND hWnd, UINT message, UINT wParam, LONG lParam )
{

	char 			szBuffer[50];
	char 			szName[50];
	static short	xChar, yChar;
	static short	xClient, yClient;
	WORD			x;

	long			objectID = -1;

	int				completionCode;
	char			objectName[48];
	char			searchObjectName[48];
	WORD			objectType;
	long			sequenceNumber = -1;
	char			propertyName[16];
	char			propertyFlags;

	int				segmentNumber = 1;
	BYTE			propertyValue[128];

	switch ( message )
	{

		case WM_SETFOCUS:
				SetFocus( hListBox1 );
				break;

		case WM_COMMAND:

				if ( ( wParam == LISTBOX_1 ) && ( HIWORD( lParam ) == LBN_SELCHANGE ) )
				{

					x = (WORD) SendMessage( hListBox1, LB_GETCURSEL, 0, 0L );
					x = (WORD) SendMessage( hListBox1, LB_GETTEXT, x, (LONG) szBuffer );

					SendMessage( hListBox2, LB_RESETCONTENT, 0, 0L );
					SendMessage( hListBox2, WM_SETREDRAW, FALSE, 0L );
                    SendMessage( hDisplayBox, LB_RESETCONTENT, 0, 0L );
                    SendMessage( hDisplayBox, WM_SETREDRAW, TRUE, 0L );

					strcpy( objectName, szBuffer );
					objectType = objType;

                    ObjPropertyList( objectName, objectType, "*", TRUE, propertyName ) ;

                    completionCode = NWErrorGet();

					if( completionCode == 0 )
                    {
						SendMessage( hListBox2, LB_ADDSTRING, 0, (LONG)propertyName );

						while ( 1 )
						{

                            ObjPropertyList( "", NOVDEFINT, "*", FALSE, propertyName ) ;

                            completionCode = NWErrorGet();

							if ( completionCode == 0xFB )
								break;

							if ( completionCode )
							{
                                sprintf( szBuffer, "ERROR : ObjPropertyList returned %X", completionCode );
                                MessageBox( NULL, szBuffer, "ObjPropertyList", MB_OK | MB_ICONHAND );
							  	break;
							}

							SendMessage( hListBox2, LB_ADDSTRING, 0, (LONG)propertyName );

						}

					}

					InvalidateRect( hListBox2, NULL, TRUE );
					SendMessage( hListBox2, WM_SETREDRAW, TRUE, 0L );
				}

				if ( ( wParam == LISTBOX_2 ) && ( HIWORD( lParam ) == LBN_SELCHANGE ) )
				{
					x = (WORD) SendMessage( hListBox1, LB_GETCURSEL, 0, 0L );
					x = (WORD) SendMessage( hListBox1, LB_GETTEXT, x, (LONG) objectName );

 					x = (WORD) SendMessage( hListBox2, LB_GETCURSEL, 0, 0L );
					x = (WORD) SendMessage( hListBox2, LB_GETTEXT, x, (LONG) propertyName );

					SendMessage( hDisplayBox, LB_RESETCONTENT, 0, 0L );
					SendMessage( hDisplayBox, WM_SETREDRAW, FALSE, 0L );

					strcpy( searchObjectName, objectName );
					objectType = objType;
					segmentNumber = 1;

					while ( 1 )
					{

                        propertyFlags = PrpFlagGet( searchObjectName, objectType, propertyName );
                        ItmPropertyValueGet( searchObjectName, objectType, propertyName, segmentNumber, propertyValue );
                        completionCode = NWErrorGet();

						if ( ( completionCode == 0xEC ) || ( completionCode == 0xFB ) )
							break;

						if ( completionCode )
						{
                            sprintf( szBuffer, "ERROR : ItmPropertyValueGet returned %X", completionCode );
                            MessageBox( NULL, szBuffer, "ItmPropertyValueGet", MB_OK | MB_ICONHAND );
						  	break;
						}

						if ( !strcmp( propertyName, "NET_ADDRESS" ) )
						{
							PrintNetAddress( propertyValue );
							break;
						}

						if ( propertyFlags && SET )
						{
							for ( x = 0; x < 32; x++ )
							{
                                objectID = NovLongSwap( *((LONG *)(propertyValue + (x*4))) );

								if ( !objectID )
					 				break;

                                ObjNameGet( objectID, objectName ) ;

                                completionCode = NWErrorGet();

								if ( completionCode )
								{
                                    sprintf( szBuffer, "ERROR : ObjNameGet returned %X", completionCode );
                                    MessageBox( NULL, szBuffer, "ObjNameGet", MB_OK | MB_ICONHAND );
								  	break;
								}

								strcpy( szBuffer, objectName );
                                GetObjectType( szName, objectType );
								strcat( szBuffer, szName );
								SendMessage( hDisplayBox, LB_ADDSTRING, 0, (LONG) szBuffer );

							}


				    	}
						else
						{
							if ( !strcmp( propertyName, "IDENTIFICATION" ) )
								SendMessage( hDisplayBox, LB_ADDSTRING, 0, (LONG) propertyValue );
							else
                                SendMessage( hDisplayBox, LB_ADDSTRING, 0, (LONG)((LPSTR)("Value read, Unknown format")) );

                         }

						segmentNumber++;
					}

					InvalidateRect( hDisplayBox, NULL, TRUE );
					SendMessage( hDisplayBox, WM_SETREDRAW, TRUE, 0L );
				}

				if ( wParam == USER_BUTTON )
				{
					SendMessage( hUserButton, BM_SETCHECK, 1, 0L );
					SendMessage( hGroupButton, BM_SETCHECK, 0, 0L );
					SendMessage( hFSButton, BM_SETCHECK, 0, 0L );
					objType = USER;

					GetObjectList();
				}

				if ( wParam == GROUP_BUTTON )
				{
					SendMessage( hUserButton, BM_SETCHECK, 0, 0L );
					SendMessage( hGroupButton, BM_SETCHECK, 1, 0L );
					SendMessage( hFSButton, BM_SETCHECK, 0, 0L );
					objType = GROUP;

					GetObjectList();
				}

				if ( wParam == FS_BUTTON )
				{
					SendMessage( hUserButton, BM_SETCHECK, 0, 0L );
					SendMessage( hGroupButton, BM_SETCHECK, 0, 0L );
					SendMessage( hFSButton, BM_SETCHECK, 1, 0L );
					objType = SERVER;

					GetObjectList();
				}

				break;

		case WM_DESTROY:
            NovTaskEnd();
			PostQuitMessage( 0 );
			break;

		default:
			return DefWindowProc( hWnd, message, wParam, lParam );
	}

	return 0;
}


void GetObjectList( void )
{
	char		szBuffer[50];
 	int			completionCode;
	WORD		searchObjectType;
	char		objectName[48];

	SendMessage( hDisplayBox, LB_RESETCONTENT, 0, 0L );
	SendMessage( hListBox1, LB_RESETCONTENT, 0, 0L );
	SendMessage( hListBox2, LB_RESETCONTENT, 0, 0L );
	SendMessage( hListBox1, WM_SETREDRAW, FALSE, 0L );

  	searchObjectType = objType;

    FSObjectList( "*", searchObjectType, TRUE, objectName );

    completionCode = NWErrorGet();

	if( completionCode == 0 )
	{

		SendMessage( hListBox1, LB_ADDSTRING, 0, (LONG)objectName );

  		while ( 1 )
  		{

            FSObjectList( "", NOVDEFINT, FALSE, objectName );

            completionCode = NWErrorGet();

			if ( completionCode == 0xfc )
				break;

			if ( completionCode )
			{
                sprintf( szBuffer, "ERROR : FSObjectList returned %X", completionCode );
                MessageBox( NULL, szBuffer, "FSObjectList", MB_OK | MB_ICONHAND );
		  		break;
			}

  			SendMessage( hListBox1, LB_ADDSTRING, 0, (LONG)objectName );
		}

	}

	InvalidateRect( hListBox1, NULL, TRUE );
	SendMessage( hListBox1, WM_SETREDRAW, TRUE, 0L );

}

void GetObjectType( char *szBuffer, int objectType )
{
	*szBuffer = NULL;
	switch( objectType )
	{
		case 1:
			strcpy( szBuffer, " (User)" );
			break;
		case 2:
			strcpy( szBuffer, " (Group)" );
			break;
		case 3:
			strcpy( szBuffer, " (Print Queue)" );
			break;
		case 4:
			strcpy( szBuffer, " (File Server)" );
			break;
		default:
			strcpy( szBuffer, " (Unknown)" );
			break;
	}
}

void PrintNetAddress( LPSTR netAddress )
{

	char	szAddress[50];

	sprintf( szAddress, "%02X%02X%02X%02X:%02X%02X%02X%02X%02X%02X:%02X%02X",
		netAddress[0],	netAddress[1],	netAddress[2],	netAddress[3],
		netAddress[4],	netAddress[5],	netAddress[6],	netAddress[7],
		netAddress[8],	netAddress[9],	netAddress[10], netAddress[11] );

	SendMessage( hDisplayBox, LB_ADDSTRING, 0, (LONG)szAddress );
}

