echo off
dumpbin /exports "..\x86\ACBrFramework32.dll" /Out:ACBrFramework32.def
LIB /DEF:ACBrFramework32.def /OUT:ACBrFramework32.lib