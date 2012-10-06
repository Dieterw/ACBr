Attribute VB_Name = "ACBrBALModule"
''
'' ACBrFramework DefExporter
'' Este arquivo foi gerado automaticamente
''


'' Tipos de dados


'' Funções

Public Declare Function BAL_Ativar Lib "ACBrFramework32.DLL" (ByVal balHandle As Long) As Long
Public Declare Function BAL_Create Lib "ACBrFramework32.DLL" (ByRef balHandle As Long) As Long
Public Declare Function BAL_Desativar Lib "ACBrFramework32.DLL" (ByVal balHandle As Long) As Long
Public Declare Function BAL_Destroy Lib "ACBrFramework32.DLL" (ByRef balHandle As Long) As Long
Public Declare Function BAL_GetAtivo Lib "ACBrFramework32.DLL" (ByVal balHandle As Long) As Long
Public Declare Function BAL_GetModelo Lib "ACBrFramework32.DLL" (ByVal balHandle As Long) As Long
Public Declare Function BAL_GetModeloStr Lib "ACBrFramework32.DLL" (ByVal balHandle As Long, ByVal buffer As String, ByVal bufferLen As Long) As Long
Public Declare Function BAL_GetPorta Lib "ACBrFramework32.DLL" (ByVal balHandle As Long, ByVal buffer As String, ByVal bufferLen As Long) As Long
Public Declare Function BAL_GetUltimaResposta Lib "ACBrFramework32.DLL" (ByVal balHandle As Long, ByVal buffer As String, ByVal bufferLen As Long) As Long
Public Declare Function BAL_GetUltimoErro Lib "ACBrFramework32.DLL" (ByVal balHandle As Long, ByVal buffer As String, ByVal bufferLen As Long) As Long
Public Declare Function BAL_GetUltimoPesoLido Lib "ACBrFramework32.DLL" (ByVal balHandle As Long, ByRef peso As Double) As Long
Public Declare Function BAL_LePeso Lib "ACBrFramework32.DLL" (ByVal balHandle As Long, ByVal timeout As Long, ByRef peso As Double) As Long
Public Declare Function BAL_SetModelo Lib "ACBrFramework32.DLL" (ByVal balHandle As Long, ByVal modelo As Long) As Long
Public Declare Function BAL_SetPorta Lib "ACBrFramework32.DLL" (ByVal balHandle As Long, ByVal porta As String) As Long
