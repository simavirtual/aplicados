*****
* The UDF() function that controls the sample text editor
*****
function dmmemof

*****
* Remember, CUSTOM passes MVPARM1, MVPARM2 and MVPARM3
*****
mvudf_val=0
mvstroke=lastkey()
setcursor(.f.)
if mvparm1=0
    say(24,45," [Line: "+trim(str(mvparm2,iif(mvparm2<100,2,3),0))+"] ")
    say(24,57," [Column: "+trim(str(mvparm3,2,0))+"] ")
    mvudf_val=32
endif
setcursor(.t.)
return mvudf_val
 