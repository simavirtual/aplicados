#
#  CA-Clipper 5.3 template to create a Blinker EXTENDED mode program
#

#batch
#if __Error
#else
    BLINKER @$(__ScriptFile) >> $(__LogFile)
#endif
#endbatch

    OUTPUT    $(__OutFile)

#if __Map
#if __MapFile
    MAP=$(__MapFile)
#else
    MAP=$R(__OutFile).MAP S,A
#endif
#else
#message You have not requested a map.
#endif

#if __ClipperName
    BLINKER ENVIRONMENT CLIPPER $(__ClipperName)
#endif

#if __ClipperEnv
    BLINKER EXECUTABLE CLIPPER $(__ClipperEnv)
#endif

#if __Packages
#message BLINKER does not require or support packages
#endif

#if __NoDefLibs
    NODEFLIB
#endif

#if __IgnoreError
    BLINKER EXECUTABLE NODELETE
#endif

#if __ClipperOver
    BLINKER ENVIRONMENT OVERRIDE
#endif

#if __StackSize
    STACK       $(__StackSize)
#endif

#if __ProcDepth
    BLINKER PROCEDURE DEPTH $(ProcDepth)
#endif

#assign allObjs     = __ObjMain
#assign allObjs    += __Obj
#assign allObjs    += __ObjExtra

#gen allObjs
#sep        ", "
#more     "^n    FILE    "
#write      "    FILE    "
$(allObjs)
#endgen

#gen __Mod
    MODULE  $(__Mod) FROM $(__Mod)
#endgen

    SEARCH BLXCLP53

#gen __Lib
#sep        ", "
    LIBRARY $(__Lib)
#endgen

    BLINKER EXECUTABLE EXTENDED
