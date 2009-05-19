@ECHO OFF

ECHO *** Copiando as DLLs ***
if NOT EXIST %windir%\System32\capicom.dll copy capicom.dll %windir%\System32
if NOT EXIST %windir%\System32\msxml5.dll  copy msxml5.dll  %windir%\System32
if NOT EXIST %windir%\System32\msxml5r.dll copy msxml5r.dll %windir%\System32

ECHO *** Registrando as DLLs ***
regsvr32 %windir%\System32\capicom.dll /s
regsvr32 %windir%\System32\msxml5.dll /s
regsvr32 %windir%\System32\msxml5r.dll /s
