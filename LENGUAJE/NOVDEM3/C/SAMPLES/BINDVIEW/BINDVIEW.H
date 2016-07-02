#define DISPLAY_BOX		102
#define FS_BUTTON		110
#define GROUP_BUTTON	109
#define LISTBOX_1		100
#define LISTBOX_2		101
#define USER_BUTTON		108

#define SET				2

#define USER			1
#define GROUP			2
#define SERVER			4

long FAR PASCAL _export WndProc( HWND, UINT, UINT, LONG );
void GetObjectList( void );
void GetObjectType( char *szBuffer, int objectType );
void PrintNetAddress( LPSTR  netAddress );

BOOL InitApplication( HANDLE );
BOOL InitInstance( HANDLE, int );

#include "resource.h"
