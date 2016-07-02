*****
* A sample programmable text editor.
*****

*****
* "dmmemof" is the UDF() function that CUSTOM uses to control the 
* editor...
*****
superbox(00,00,24,79,.t.,"²",.f.)
superbox(04,09,21,71,.t.,"",.t.)
say(02,25,"    The Sample Text Editor    ")
setcursor(.t.)
mv_udfname="dmmemof"
mvtext=memoedit(memoread("dmtext.txt"),5,10,20,70,.t.,"CUSTOM") 

*****
* if desired, you can write the text back to disk with:
* memowrit("dmtext.txt",mvtext)
*****
setcursor(.f.)
return
