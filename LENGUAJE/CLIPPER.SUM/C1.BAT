summer %1 /b
plink86 fi %1 LIB CLIPPER,EXTEND VERBOSE
del *.obj
copy %1.exe ..
del %1.exe
cd ..
