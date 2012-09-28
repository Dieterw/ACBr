echo off
dumpbin /exports "..\x86\ACBr32.dll" /Out:ACBr32.def
LIB /DEF:ACBr32.def /OUT:ACBr32.lib