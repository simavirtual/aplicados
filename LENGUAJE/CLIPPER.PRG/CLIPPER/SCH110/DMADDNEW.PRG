*****
* Add a new record to the database
*****
clearscrn()
setconfirm(.t.)
setbell(.t.)
superbox(0,0,24,79,.t.,"²",.f.)
superbox(05,5,17,70,.f.,"",.t.)
do while .t.
    mvlast=space(15)
    mvfirst=space(15)
    mvstreet=space(25)
    mvcity=space(25)
    mvstate=space(2)
    mvzip=space(5)
    mvphone=space(13)
    setcursor(.t.)
    readexit(.f.)
    sayget(08,8," Last Name: ","mvlast")
    sayget(09,8,"First Name: ","mvfirst")
    sayget(10,8,"    Street: ","mvstreet")
    sayget(11,8,"      City: ","mvcity")
    sayget(12,8,"     State: ","mvstate","","udf('dmstates')")
    sayget(13,8,"       Zip: ","mvzip")
    sayget(14,8,"     Phone: ","mvphone","(999)999-9999")
    read
    readexit()
    if lastkey()=27
        return
    endif
    if rlock()
        appblank()
        insert("lastname","mvlast")
        insert("firstname","mvfirst")
        insert("street","mvstreet")
        insert("city","mvcity")
        insert("state","mvstate")
        insert("zip","mvzip")
        insert("phone","mvphone")
        runlock()
    else
        message("Unable to lock record for update")
    endif
enddo
return
