/*

    96.02.08    Blinker Windows DLL test program

*/

#include <windows.h>
#include <dos.h>
#include <stdio.h>
#include <blinker.h>

static char buffer [200];              // Where to construct the answer

char * __export test (void)            // Indicate an exported function
{
    struct _diskfree_t drvinfo;
    unsigned drive;

    _dos_getdrive( &drive );           // Get the current drive

    _dos_getdiskfree(
       drive, &drvinfo );              // Get the free space

    sprintf( buffer,"Disk space free : %ld",
            (long)drvinfo.avail_clusters *
            drvinfo.sectors_per_cluster *
            drvinfo.bytes_per_sector );

   return (buffer);                    // Return pointer to the buffer
}
