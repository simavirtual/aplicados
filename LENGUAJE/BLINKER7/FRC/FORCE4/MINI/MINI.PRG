#include system.hdr

text cText static           // text stored in far data segment
This example illustrates the extreme small size of a working Force
application when linked with Blinker 5.1. A Force program consists of
pure native code. Only those modules are linked from the standard
library that are indeed necessary for the application's workings.

The application can be generated using the provided make.bat file. You
do not need to have a Force package for the build. Modules of the
Force 4.0 runtime library that are necessary for this sample program are
included in the provided f40mini.lib file. The Blinker service functions
are excluded from the link for minimizing the application size.
endtext


proc main                   // application code entry point

vardef                      // local variable declaration block
   uint n                   // loop counter (numeric, unsigned integer)
enddef

? cText                     // display some text

// the loop below is only intended to show some characteristics of
// Force coding syntax

for n := 1 to 5
   ?                               // empty line
   if n == 3
      ?? "Current time is", time() // display some text and data
   endif
next

endproc                            // main() function exit point

