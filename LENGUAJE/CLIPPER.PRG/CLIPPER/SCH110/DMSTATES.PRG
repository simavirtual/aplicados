*****
* UDF to check for a valid state
*****
function dmstates
if upper(mvstate) $ "CA,WA,OR,NV,UT"
    return .t.
else
    *****
    * You may wish to declare an array such as this outside of the
    * UDF in order to save time on slower machines...
    *****
    public mvwest[5]
    mvwest[1]="CA"
    mvwest[2]="WA"
    mvwest[3]="OR"
    mvwest[4]="NV"
    mvwest[5]="UT"
    mvudfscrn=savescreen(07,10,20,70)
    superbox(08,45,16,66,.f.,"",.t.)
    superbox(10,46,10,65,.f.,"",.f.)
    say(09,47,"  Select a State")
    mvselect=achoice(11,55,15,56,mvwest)
    if mvselect<>0
        mvstate=mvwest[mvselect]
    else
        mvstate=space(2)
    endif
    mvudfscrn=restscreen(07,10,20,70,mvudfscrn)
    return .f.
endif
return .f.
 