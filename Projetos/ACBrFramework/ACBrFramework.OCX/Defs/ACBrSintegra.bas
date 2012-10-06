Attribute VB_Name = "ACBrSintegraModule"
''
'' ACBrFramework DefExporter
'' Este arquivo foi gerado automaticamente
''


'' Tipos de dados

Public Type Registro10Rec
	CNPJ As String * 15
	Inscricao As String * 15
	RazaoSocial As String * 36
	Cidade As String * 31
	Estado As String * 3
	Telefone As String * 11
	DataInicial As Double
	DataFinal As Double
	CodigoConvenio As Long
	NaturezaInformacoes As Long
	FinalidadeArquivo As Long
End Type


'' Funções

Public Declare Function SIN_Create Lib "ACBrFramework32.DLL" (ByRef sinHandle As Long) As Long
Public Declare Function SIN_Destroy Lib "ACBrFramework32.DLL" (ByRef sinHandle As Long) As Long
Public Declare Function SIN_GetAtivo Lib "ACBrFramework32.DLL" (ByVal sinHandle As Long) As Long
Public Declare Function SIN_GetFileName Lib "ACBrFramework32.DLL" (ByVal sinHandle As Long, ByVal buffer As String, ByVal bufferLen As Long) As Long
Public Declare Function SIN_GetUltimoErro Lib "ACBrFramework32.DLL" (ByVal sinHandle As Long, ByVal buffer As String, ByVal bufferLen As Long) As Long
Public Declare Function SIN_GetVersaoValidador Lib "ACBrFramework32.DLL" (ByVal sinHandle As Long) As Long
Public Declare Function SIN_LimparRegistros Lib "ACBrFramework32.DLL" (ByVal sinHandle As Long) As Long
Public Declare Function SIN_Registro10 Lib "ACBrFramework32.DLL" (ByVal sinHandle As Long, ByVal registro10 As Registro10Rec) As Long
Public Declare Function SIN_SetFileName Lib "ACBrFramework32.DLL" (ByVal sinHandle As Long, ByVal filename As String) As Long
Public Declare Function SIN_SetVersaoValidador Lib "ACBrFramework32.DLL" (ByVal sinHandle As Long, ByVal Versao As Long) As Long
