  Library: oFgIni.lib v1.0

  Author: Felix H. Gonzalez
          P.O. Box 133
          Aurora, CO 80040-0133

          CompuServe address - 71203, 2025
          America Online address - Lion291822

  oFgIni is an object library written 100% in Clipper 5.x using Class(y)
  2.0x. To use oFgIni you must own Classy 2.0b or higher. It allows the
  Clipper programmer to create and manage .ini files just like Windows 3.x.
  oFgIni will return the following types "C", "L", "N", and "D".

  See example file and oFgIni.ng for usage.

  Linking:

  rtlink fi MyProgram lib oFgIni, Classy, Samples, Clipper

  oFgIni.lib must be linked before Classy or you'll get an error. It also
  uses function FileEval() and FileSize() from clipper's samples.lib.

  Note: if linking with other libraries use the MODULE...FROM... command
  for FileSize() and FileEval() if these names exist in other libraries.

  Example:

  MODULE FileSize FROM samples.lib
  MODULE FileEval FROM samples.lib

  oFgIni is free to all who wish to use it. The source code may obtained by
  sending ( 12.00 for disk, or 9.00 with C-Serve or AOL address ) to the 
  authors' address. Make checks or money orders payable to Felix H. Gonzalez.


  Source Code Order Information

  Name    __________________________________________________

  Address __________________________________________________

          __________________________________________________

  Compu-Serve Address    ___________________________________

  America Online Address ___________________________________

  Disksize ______________  ( if desired, send 12.00 )

  If I receive your Compu-Serve or America Online Address, I will send
  you the source code files directly by modem.

  Please note: If you like this object, please let me know, via C-Serve
  or AOL.


  Happy computing,
  Felix
