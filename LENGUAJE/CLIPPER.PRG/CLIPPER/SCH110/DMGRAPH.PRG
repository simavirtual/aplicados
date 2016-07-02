clearscrn()
graphon()
graphmode(0)
mvxsize=graphstat("NUMXPIXELS")
mvysize=graphstat("NUMYPIXELS")
graphcolor(7)
graphbox("clear",0,0,mvxsize-1,mvysize-1)
graphbox("clear",50,30,mvxsize-30,mvysize-60)
graphsay(02,30,7,"WIDGET SALES FOR 1992")
graphsay(22,13,7,"1st qtr          2nd qtr          3rd qtr           4th qtr")
graphsay(07,04,7,"T")
graphsay(08,04,7,"h")
graphsay(09,04,7,"o")
graphsay(10,04,7,"u")
graphsay(11,04,7,"s")
graphsay(12,04,7,"a")
graphsay(13,04,7,"n")
graphsay(14,04,7,"d")
graphsay(15,04,7,"s")

graphcolor(2)
graphbox("solid",100,200,150,mvysize-61)

graphcolor(3)
graphbox("solid",233,150,283,mvysize-61)

graphcolor(4)
graphbox("solid",369,100,419,mvysize-61)

graphcolor(5)
graphbox("solid",513,50,563,mvysize-61)

graphsay(24,02,7,"Press any key to continue...")
inkey(0)

*****
* Clear the graphics screen
*****
graphmode(0)

*****
* Boxes
*****
graphcolor(7)
graphbox("clear",0,0,mvxsize/2-1,mvysize/2-1)
graphbox("clear",0,mvysize/2+1,mvxsize/2-1,mvysize-1)
graphbox("clear",mvxsize/2+1,0,mvxsize-1,mvysize-1)

*****
* Line graph
*****
graphcolor(2)
graphbox("clear",20,20,300,150)
graphcolor(3)
graphline(40,140,280,40)
graphcolor(4)
graphline(40,120,280,60)
graphcolor(5)
graphline(40,100,280,80)
graphsay(12,13,7,"Line Graph...")

*****
* Graph text
*****
graphsay(05,45,1,"This is a sample of the text")
graphsay(07,45,2,"that can be displayed on a")
graphsay(09,45,3,"graphic screen.  Note how the")
graphsay(11,45,4,"text color can be changed at will.")
graphsay(13,45,5,"Placing text on a graphic screen is")
graphsay(15,45,6,"is as easy as placing text on a")
graphsay(17,45,7,"text screen. Here is a command:")
graphsay(20,45,2,"    GRAPHSAY(10,15,7,'HELLO')")

*****
* circles
*****
mvsx=40
mvsy=200
mvex=280
mvey=320
mvcolor=1
do while .t.
    graphcolor(mvcolor)
    graphcirc("solid",mvsx,mvsy,mvex,mvey)
    mvcolor=mvcolor+1
    if mvcolor>15
        mvcolor=1
    endif
    
    mvkey=inkey()
    if mvkey=27
        exit
    endif
enddo
graphoff()
return


 