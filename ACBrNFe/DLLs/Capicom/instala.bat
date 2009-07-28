@ECHO OFF

ECHO *** Copiando as DLLs ***
if NOT EXIST %windir%\System32\capicom.dll copy capicom.dll %windir%\System32
if EXIST %windir%\System32\capicom.dll echo CAPICOM.DLL copiada com Sucesso!
if NOT EXIST %windir%\System32\capicom.dll echo Nao foi possivel copiar CAPICOM.DLL!

if NOT EXIST %windir%\System32\msxml5.dll  copy msxml5.dll  %windir%\System32
if EXIST %windir%\System32\msxml5.dll echo MSXML5.DLL copiada com Sucesso!
if NOT EXIST %windir%\System32\msxml5.dll echo Nao foi possivel copiar MSXML5.DLL!

if NOT EXIST %windir%\System32\msxml5r.dll copy msxml5r.dll %windir%\System32
if EXIST %windir%\System32\msxml5r.dll echo MSXML5R.DLL copiada com Sucesso!
if NOT EXIST %windir%\System32\msxml5r.dll echo Nao foi possivel copiar MSXML5R.DLL

ECHO .

ECHO *** Registrando as DLLs ***
ECHO Em caso de problemas no registro das DLL's, verifique se possui 
ECHO direitos de Administrador sobre o prompt do MS-DOS.
regsvr32 %windir%\System32\capicom.dll 
regsvr32 %windir%\System32\msxml5.dll 

ECHO .

pause