Attribute VB_Name = "ACBrEADModule"
''
'' ACBrFramework DefExporter
'' Este arquivo foi gerado automaticamente
''


'' Tipos de dados


'' Funções

Public Declare Function EAD_AssinarArquivoComEAD Lib "ACBrFramework32.DLL" (ByVal eadHandle As Long, ByVal Arquivo As String, ByVal Remove As Boolean) As Long
Public Declare Function EAD_CalcularChavePublica Lib "ACBrFramework32.DLL" (ByVal eadHandle As Long, ByVal ChavePUB As String, ByVal bufferLen As Long) As Long
Public Declare Function EAD_CalcularEADArquivo Lib "ACBrFramework32.DLL" (ByVal eadHandle As Long, ByVal Arquivo As String, ByVal Hash As String, ByVal bufferLen As Long) As Long
Public Declare Function EAD_CalcularHashArquivo Lib "ACBrFramework32.DLL" (ByVal eadHandle As Long, ByVal Arquivo As String, ByVal HashType As Long, ByVal Hash As String, ByVal bufferLen As Long) As Long
Public Declare Function EAD_CalcularModuloeExpoente Lib "ACBrFramework32.DLL" (ByVal eadHandle As Long, ByVal Modulo As String, ByVal Expoente As String, ByVal bufferLen As Long) As Long
Public Declare Function EAD_ConverteXMLeECFcParaOpenSSL Lib "ACBrFramework32.DLL" (ByVal eadHandle As Long, ByVal Arquivo As String) As Long
Public Declare Function EAD_Create Lib "ACBrFramework32.DLL" (ByRef eadHandle As Long) As Long
Public Declare Function EAD_Destroy Lib "ACBrFramework32.DLL" (ByRef eadHandle As Long) As Long
Public Declare Function EAD_GerarChaves Lib "ACBrFramework32.DLL" (ByVal eadHandle As Long, ByVal ChavePUB As String, ByVal ChavePRI As String, ByVal bufferLen As Long) As Long
Public Declare Function EAD_GerarXMLeECFc Lib "ACBrFramework32.DLL" (ByVal eadHandle As Long, ByVal NomeSH As String, ByVal PathArquivo As String) As Long
Public Declare Function EAD_GerarXMLeECFc_NP Lib "ACBrFramework32.DLL" (ByVal eadHandle As Long, ByVal NomeSH As String) As Long
Public Declare Function EAD_GetChavePrivada Lib "ACBrFramework32.DLL" (ByVal eadHandle As Long, ByVal buffer As String, ByVal bufferLen As Long) As Long
Public Declare Function EAD_GetChavePublica Lib "ACBrFramework32.DLL" (ByVal eadHandle As Long, ByVal buffer As String, ByVal bufferLen As Long) As Long
Public Declare Function EAD_GetUltimoErro Lib "ACBrFramework32.DLL" (ByVal eadHandle As Long, ByVal buffer As String, ByVal bufferLen As Long) As Long
Public Declare Function EAD_SetChavePrivada Lib "ACBrFramework32.DLL" (ByVal eadHandle As Long, ByVal chave As String) As Long
Public Declare Function EAD_SetChavePublica Lib "ACBrFramework32.DLL" (ByVal eadHandle As Long, ByVal chave As String) As Long
Public Declare Function EAD_VerificarEADArquivo Lib "ACBrFramework32.DLL" (ByVal eadHandle As Long, ByVal Arquivo As String) As Long
