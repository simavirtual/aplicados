#include <CAUSEWAY.API>
#include <EXTEND.API>
#include <ITEM.API>

//
// This file has some sample Clipper-callable functions that demonstrate
// the use of the CauseWay C API.  The functions are also somewhat useful
// in and of themselves.
//
// All code herein is committed to the Public Domain; do with it what you
// will.  No warranties expressed or implied.
//

CLIPPER ActiveHost( void )
{
   // Get and return the active host.  0 == raw, 1 == VCPI, 2 == DPMI.

   auto SYSINFO sysInfo;

   _cwInfo( &sysInfo );

   _retni( ( sysInfo.SysFlags >> 2 ) & 3 );  // Isolate host bits

   return;
}



CLIPPER IsVMM( void )
{
   // Return .T. if Virtual Memory Manager available, otherwise .F.

   auto SYSINFO sysInfo;

   _cwInfo( &sysInfo );

   _retl( sysInfo.SysFlags & 2 );   // Isolate VMM bit

   return;
}



CLIPPER cwVersion( void )
{
   // Return extender version as either numeric or string, depending on
   // value of incoming parameter.

   auto CWVERSION ver;

   if ( _parni( 1 ) == 1 )
   {
      _cwVersion( &ver );

      _retnd( ( double ) ver.cwVerMajor +
          ( ( ( double ) ver.cwVerMinor ) / 100 ) );
   }
   else
      _retc( _cwVersionZ() );

   return;
}



// The two functions GetLowMem() and FreeLowMem() allow allocating low DOS
// memory to conserve it against CauseWay allocations, in the event that
// the DOS memory is desired at a later time.  Call GetLowMem early in
// the program before other allocations are made.  Release the memory
// prior to any making any allocations that require low DOS
// memory allocations or which use low DOS memory, such as RUN.  Afterwards,
// reallocate the low DOS memory with GetLowMem if you may need it later,
// as CauseWay will consider any freed memory as fair game for future
// memory allocations.

CLIPPER GetLowMem( void )
{
   // Allocate low memory using incoming size parameter.  Returns a
   // memory handle if successful; zero otherwise.

   auto long ulSize;

   ulSize = _parnl( 1 ) + 15; // Round up if necessary

   ulSize /= 16;              // Convert bytes to paragraphs

   _retni( _cwGetMemDOS( ( unsigned int ) ulSize ) );

   return;
}



CLIPPER FreeLowMem( void )
{
   // Free low DOS memory previously allocated with GetLowMem().
   // Receives a memory handle and returns .T. or .F. to indicate
   // whether the memory was deallocated.

   _retl( _cwRelMemDOS( _parni( 1 ) ) );

   return;
}