set talk off
x = ""
x = x + iif(letterbox,"Cod ","")
x = x + iif(xdigital, "XD  ","")
x = x + iif(sdigital, "SD   ","")
x = x + iif(stereo,   "Est ","")
x = x + iif(surround, "Env  ","")
x = x + iif(cx,       "CX   ","")
x = x + iif(closecap, "Tel  ","")
x = x + iif(blk_wht,  "B/N   ","")
x = x + iif(cav,      "CAV   ","")
x = x + iif(subtitled,"ST   ","")
x = x + iif(dubbed,   "Do   ","")
x = x + iif(silent,   "Mu  ","")
x = x + iif(supplement,"+   ","")
x = x + iif(commentary,"Com ","")
x = x + iif(kids,      "Ni� ","")

return trim(x)
