#batch
LIB $(__OutFile) @$(__ScriptFile); >> $(__LogFile)
#endbatch
#assign allObjs     = __ObjMain
#assign allObjs    += __Obj
#gen allObjs
#sep    " -+"
#more   " &"
-+$(allObjs)
#endgen
