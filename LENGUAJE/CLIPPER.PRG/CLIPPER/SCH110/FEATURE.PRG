*****
* Use list box to control and scroll feature list
*****
imgsave(100,50,540,430,380,"feature")
mv_udfname="ftrlist"
imglistbox(100,50,540,430,2,1,15,8,8,0) 
mscrsoroff()
imgrestore(100,50,540,430,380,"feature",0) 
mscrsoron()
return