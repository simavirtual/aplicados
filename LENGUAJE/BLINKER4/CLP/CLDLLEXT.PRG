
************************************************************************************************
*                                                                                              *
*         96.01.28            Clipper 5.x extra externals when using DLLs                      *
*                                                                                              *
************************************************************************************************

************************************************************************************************
*                                                                                              *
*         Compile and link this module to the main EXE if you are using one or more            *
*         of the following CA-Clipper libraries in one or more of your DLLs                    *
*                                                                                              *
************************************************************************************************

func     cldllext             // Extra external definitions for CA-Clipper

EXTERNAL DBFCDX               // Include this symbol when using the DBFCDX library

EXTERNAL DBFMDX               // Include this symbol when using the DBFMDX library

EXTERNAL DBFNDX               // Include this symbol when using the DBFNDX library

EXTERNAL GBMPDISP             // Include these symbols when using LLIBG library
EXTERNAL GBMPLOAD
EXTERNAL GFNTERASE
EXTERNAL GFNTLOAD
EXTERNAL GFRAME
EXTERNAL GMODE
EXTERNAL GRECT
EXTERNAL GWRITEAT
EXTERNAL MHIDE
EXTERNAL MSHOW

return NIL
