#batch
#if __Error
#else
    IF EXIST $(__OutFile) DEL $(__OutFile)
    EXOSPACE @$(__ScriptFile) >> $(__LogFile)
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
    EXOSPACE    ENVIRONMENT CLIPPER $(__ClipperName)
#endif

#if __ClipperEnv
    EXOSPACE    EXECUTABLE CLIPPER $(__ClipperEnv)
#endif

#if __Packages
    EXOSPACE    PACKAGE $(__Packages)
#endif

#more "just testing diagnostic"

#if __NoDefLibs
    NODEFLIB
#endif

#if __IgnoreError
    EXOSPACE    EXECUTABLE NODELETE
#endif

#if __ClipperOver
    EXOSPACE    ENVIRONMENT OVERRIDE
#endif

#if __StackSize
    STACK       $(__StackSize)
#endif

#if __ProcDepth
    EXOSPACE    PROCEDURE DEPTH $(__ProcDepth)
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

#gen __Lib
#sep        ", "
    LIBRARY $(__Lib)
#endgen

