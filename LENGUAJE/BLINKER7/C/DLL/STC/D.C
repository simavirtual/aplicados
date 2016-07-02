/*

    97.12.17    Blinker Windows DLL test program

*/

#include <windows.h>
#include <dos.h>
#include <stdio.h>
#include <blinker.h>

static char buffer [200];              // Where to construct the answer

char * __export test (void)            // Indicate an exported function
{
    struct diskfree_t drvinfo;
    unsigned drive;

    _dos_getdrive( &drive );           // Get the current drive

    _dos_getdiskfree(
       drive, &drvinfo );              // Get the free space

    sprintf( buffer,"disk space free : %ld",
            (long)drvinfo.avail_clusters *
            drvinfo.sectors_per_cluster *
            drvinfo.bytes_per_sector );

   return (buffer);                    // Return pointer to the buffer
}

BOOL CALLBACK LibMain (HINSTANCE hinst, WORD wDataSeg,
                       WORD cbHeapSize, LPSTR lpszCmdLine)
{
    // Reference parameters

    hinst++;
    wDataSeg++;
    cbHeapSize++;
    lpszCmdLine++;

    // Nothing to do.

    return (TRUE);
}

BOOL CALLBACK _export _loadds _WEP(BOOL fSystemExit)
{
    // Nothing to do.

    return (fSystemExit);
}

