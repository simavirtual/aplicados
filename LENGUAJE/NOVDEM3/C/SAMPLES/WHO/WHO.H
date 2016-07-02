long FAR PASCAL _export WndProc( HWND, UINT, UINT, LONG );
void GetConnectionList( void );
void GetFileList( void );
void GetConnectionInfo( HWND );

BOOL InitApplication( HANDLE );
BOOL InitInstance( HANDLE, int );

#include "resource.h"
