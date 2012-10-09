ECHO OFF
REM dumpbin /exports "..\x86\ACBrFramework32.dll" /Out:.\x86\ACBrFramework32.def
LIB /DEF:.\x86\ACBrFramework32.def /OUT:.\x86\ACBrFramework32.lib /MACHINE:X86

REM dumpbin /exports "..\x64\ACBrFramework64.dll" /Out:.\x64\ACBrFramework64.def
LIB /DEF:.\x64\ACBrFramework64.def /OUT:.\x64\ACBrFramework64.lib  /MACHINE:X64