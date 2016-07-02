*****
* Edit the existing database
*****
clearscrn()
superbox(0,0,24,79,.t.,"²",.f.)
superbox(02,05,04,75,.f.,"",.t.)
say(03,28,"Edit the Address Database")
superbox(05,05,20,75,.f.,"",.t.)
say(20,11,"ENTER-Select/Deselect for Edit  DEL-Delete record  ESC-Exit")
do while .t.
    *****
    * See the Dbedit() description in the online help to see how the 
    * CUSTOM option is used.
    *****
    mv_udfname="dmedit"
    dbedit(06,06,19,74,.t.,"custom")
    if lastkey()=27
        return
    endif
enddo
return
