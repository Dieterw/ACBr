Attribute VB_Name = "ACBrAACModule"
''
'' ACBrFramework DefExporter
'' Este arquivo foi gerado automaticamente
''


'' Tipos de dados

Public Type TECFAutorizado
	ValorGT As Double
	NumeroSerie As String * 30
	CRO As Long
	CNI As Long
	DtHrAtualizado As Double
End Type


'' Funções

Public Declare Function AAC_AbrirArquivo Lib "ACBrFramework32.DLL" (ByVal aacHandle As Long) As Long
Public Declare Function AAC_AtualizarValorGT Lib "ACBrFramework32.DLL" (ByVal aacHandle As Long, ByVal numSerie As String, ByRef grandTotal As Double) As Long
Public Declare Function AAC_Create Lib "ACBrFramework32.DLL" (ByRef aacHandle As Long) As Long
Public Declare Function AAC_Destroy Lib "ACBrFramework32.DLL" (ByRef aacHandle As Long) As Long
Public Declare Function AAC_GetArqLOG Lib "ACBrFramework32.DLL" (ByVal aacHandle As Long, ByVal buffer As String, ByVal bufferLen As Long) As Long
Public Declare Function AAC_GetChave Lib "ACBrFramework32.DLL" (ByVal aacHandle As Long, ByVal buffer As String, ByVal bufferLen As Long) As Long
Public Declare Function AAC_GetNomeArquivoAux Lib "ACBrFramework32.DLL" (ByVal aacHandle As Long, ByVal buffer As String, ByVal bufferLen As Long) As Long
Public Declare Function AAC_GetParams Lib "ACBrFramework32.DLL" (ByVal aacHandle As Long, ByVal buffer As String, ByVal bufferLen As Long) As Long
Public Declare Function AAC_GetUltimoErro Lib "ACBrFramework32.DLL" (ByVal aacHandle As Long, ByVal buffer As String, ByVal bufferLen As Long) As Long
Public Declare Function AAC_IdentPaf_ECFsAutorizados_Clear Lib "ACBrFramework32.DLL" (ByVal aacHandle As Long) As Long
Public Declare Function AAC_IdentPaf_ECFsAutorizados_Count Lib "ACBrFramework32.DLL" (ByVal aacHandle As Long) As Long
Public Declare Function AAC_IdentPaf_ECFsAutorizados_Get Lib "ACBrFramework32.DLL" (ByVal aacHandle As Long, ByRef retAutorizado As TECFAutorizado, ByVal index As Long) As Long
Public Declare Function AAC_IdentPaf_ECFsAutorizados_New Lib "ACBrFramework32.DLL" (ByVal aacHandle As Long, ByVal ecfAutorizado As TECFAutorizado) As Long
Public Declare Function AAC_IdentPaf_Empresa_GetCNPJ Lib "ACBrFramework32.DLL" (ByVal aacHandle As Long, ByVal buffer As String, ByVal bufferLen As Long) As Long
Public Declare Function AAC_IdentPaf_Empresa_GetIE Lib "ACBrFramework32.DLL" (ByVal aacHandle As Long, ByVal buffer As String, ByVal bufferLen As Long) As Long
Public Declare Function AAC_IdentPaf_Empresa_GetIM Lib "ACBrFramework32.DLL" (ByVal aacHandle As Long, ByVal buffer As String, ByVal bufferLen As Long) As Long
Public Declare Function AAC_IdentPaf_Empresa_GetRazaoSocial Lib "ACBrFramework32.DLL" (ByVal aacHandle As Long, ByVal buffer As String, ByVal bufferLen As Long) As Long
Public Declare Function AAC_IdentPaf_Empresa_SetCNPJ Lib "ACBrFramework32.DLL" (ByVal aacHandle As Long, ByVal cnpj As String) As Long
Public Declare Function AAC_IdentPaf_Empresa_SetIE Lib "ACBrFramework32.DLL" (ByVal aacHandle As Long, ByVal ie As String) As Long
Public Declare Function AAC_IdentPaf_Empresa_SetIM Lib "ACBrFramework32.DLL" (ByVal aacHandle As Long, ByVal im As String) As Long
Public Declare Function AAC_IdentPaf_Empresa_SetRazaoSocial Lib "ACBrFramework32.DLL" (ByVal aacHandle As Long, ByVal razaoSocial As String) As Long
Public Declare Function AAC_IdentPaf_GetNumeroLaudo Lib "ACBrFramework32.DLL" (ByVal aacHandle As Long, ByVal buffer As String, ByVal bufferLen As Long) As Long
Public Declare Function AAC_IdentPaf_GetVersaoER Lib "ACBrFramework32.DLL" (ByVal aacHandle As Long, ByVal buffer As String, ByVal bufferLen As Long) As Long
Public Declare Function AAC_IdentPaf_Paf_GetBancoDados Lib "ACBrFramework32.DLL" (ByVal aacHandle As Long, ByVal buffer As String, ByVal bufferLen As Long) As Long
Public Declare Function AAC_IdentPaf_Paf_GetBarSimilarBalanca Lib "ACBrFramework32.DLL" (ByVal aacHandle As Long) As Long
Public Declare Function AAC_IdentPaf_Paf_GetBarSimilarECFComum Lib "ACBrFramework32.DLL" (ByVal aacHandle As Long) As Long
Public Declare Function AAC_IdentPaf_Paf_GetBarSimilarECFRestaurante Lib "ACBrFramework32.DLL" (ByVal aacHandle As Long) As Long
Public Declare Function AAC_IdentPaf_Paf_GetCupomMania Lib "ACBrFramework32.DLL" (ByVal aacHandle As Long) As Long
Public Declare Function AAC_IdentPaf_Paf_GetDAVConfAnexoII Lib "ACBrFramework32.DLL" (ByVal aacHandle As Long) As Long
Public Declare Function AAC_IdentPaf_Paf_GetDAVDiscrFormula Lib "ACBrFramework32.DLL" (ByVal aacHandle As Long) As Long
Public Declare Function AAC_IdentPaf_Paf_GetEmitePED Lib "ACBrFramework32.DLL" (ByVal aacHandle As Long) As Long
Public Declare Function AAC_IdentPaf_Paf_GetIndiceTecnicoProd Lib "ACBrFramework32.DLL" (ByVal aacHandle As Long) As Long
Public Declare Function AAC_IdentPaf_Paf_GetIntegracaoPafECF Lib "ACBrFramework32.DLL" (ByVal aacHandle As Long) As Long
Public Declare Function AAC_IdentPaf_Paf_GetLinguagem Lib "ACBrFramework32.DLL" (ByVal aacHandle As Long, ByVal buffer As String, ByVal bufferLen As Long) As Long
Public Declare Function AAC_IdentPaf_Paf_GetMinasLegal Lib "ACBrFramework32.DLL" (ByVal aacHandle As Long) As Long
Public Declare Function AAC_IdentPaf_Paf_GetNome Lib "ACBrFramework32.DLL" (ByVal aacHandle As Long, ByVal buffer As String, ByVal bufferLen As Long) As Long
Public Declare Function AAC_IdentPaf_Paf_GetRealizaDAVECF Lib "ACBrFramework32.DLL" (ByVal aacHandle As Long) As Long
Public Declare Function AAC_IdentPaf_Paf_GetRealizaDAVNaoFiscal Lib "ACBrFramework32.DLL" (ByVal aacHandle As Long) As Long
Public Declare Function AAC_IdentPaf_Paf_GetRealizaDAVOS Lib "ACBrFramework32.DLL" (ByVal aacHandle As Long) As Long
Public Declare Function AAC_IdentPaf_Paf_GetRealizaLancamentoMesa Lib "ACBrFramework32.DLL" (ByVal aacHandle As Long) As Long
Public Declare Function AAC_IdentPaf_Paf_GetRealizaPreVenda Lib "ACBrFramework32.DLL" (ByVal aacHandle As Long) As Long
Public Declare Function AAC_IdentPaf_Paf_GetRecompoeGT Lib "ACBrFramework32.DLL" (ByVal aacHandle As Long) As Long
Public Declare Function AAC_IdentPaf_Paf_GetSistemaOperacional Lib "ACBrFramework32.DLL" (ByVal aacHandle As Long, ByVal buffer As String, ByVal bufferLen As Long) As Long
Public Declare Function AAC_IdentPaf_Paf_GetTipoDesenvolvimento Lib "ACBrFramework32.DLL" (ByVal aacHandle As Long) As Long
Public Declare Function AAC_IdentPaf_Paf_GetTipoFuncionamento Lib "ACBrFramework32.DLL" (ByVal aacHandle As Long) As Long
Public Declare Function AAC_IdentPaf_Paf_GetTotalizaValoresLista Lib "ACBrFramework32.DLL" (ByVal aacHandle As Long) As Long
Public Declare Function AAC_IdentPaf_Paf_GetTransfDAV Lib "ACBrFramework32.DLL" (ByVal aacHandle As Long) As Long
Public Declare Function AAC_IdentPaf_Paf_GetTransfPreVenda Lib "ACBrFramework32.DLL" (ByVal aacHandle As Long) As Long
Public Declare Function AAC_IdentPaf_Paf_GetUsaImpressoraNaoFiscal Lib "ACBrFramework32.DLL" (ByVal aacHandle As Long) As Long
Public Declare Function AAC_IdentPaf_Paf_GetVersao Lib "ACBrFramework32.DLL" (ByVal aacHandle As Long, ByVal buffer As String, ByVal bufferLen As Long) As Long
Public Declare Function AAC_IdentPaf_Paf_PrincipalExe_GetMD5 Lib "ACBrFramework32.DLL" (ByVal aacHandle As Long, ByVal buffer As String, ByVal bufferLen As Long) As Long
Public Declare Function AAC_IdentPaf_Paf_PrincipalExe_GetNome Lib "ACBrFramework32.DLL" (ByVal aacHandle As Long, ByVal buffer As String, ByVal bufferLen As Long) As Long
Public Declare Function AAC_IdentPaf_Paf_PrincipalExe_SetMD5 Lib "ACBrFramework32.DLL" (ByVal aacHandle As Long, ByVal md5Exe As String) As Long
Public Declare Function AAC_IdentPaf_Paf_PrincipalExe_SetNome Lib "ACBrFramework32.DLL" (ByVal aacHandle As Long, ByVal exePrincipal As String) As Long
Public Declare Function AAC_IdentPaf_Paf_SetBancoDados Lib "ACBrFramework32.DLL" (ByVal aacHandle As Long, ByVal banco As String) As Long
Public Declare Function AAC_IdentPaf_Paf_SetBarSimilarBalanca Lib "ACBrFramework32.DLL" (ByVal aacHandle As Long, ByVal check As Boolean) As Long
Public Declare Function AAC_IdentPaf_Paf_SetBarSimilarECFComum Lib "ACBrFramework32.DLL" (ByVal aacHandle As Long, ByVal check As Boolean) As Long
Public Declare Function AAC_IdentPaf_Paf_SetBarSimilarECFRestaurante Lib "ACBrFramework32.DLL" (ByVal aacHandle As Long, ByVal check As Boolean) As Long
Public Declare Function AAC_IdentPaf_Paf_SetCupomMania Lib "ACBrFramework32.DLL" (ByVal aacHandle As Long, ByVal check As Boolean) As Long
Public Declare Function AAC_IdentPaf_Paf_SetDAVConfAnexoII Lib "ACBrFramework32.DLL" (ByVal aacHandle As Long, ByVal check As Boolean) As Long
Public Declare Function AAC_IdentPaf_Paf_SetDAVDiscrFormula Lib "ACBrFramework32.DLL" (ByVal aacHandle As Long, ByVal check As Boolean) As Long
Public Declare Function AAC_IdentPaf_Paf_SetEmitePED Lib "ACBrFramework32.DLL" (ByVal aacHandle As Long, ByVal check As Boolean) As Long
Public Declare Function AAC_IdentPaf_Paf_SetIndiceTecnicoProd Lib "ACBrFramework32.DLL" (ByVal aacHandle As Long, ByVal check As Boolean) As Long
Public Declare Function AAC_IdentPaf_Paf_SetIntegracaoPafECF Lib "ACBrFramework32.DLL" (ByVal aacHandle As Long, ByVal tipo As Long) As Long
Public Declare Function AAC_IdentPaf_Paf_SetLinguagem Lib "ACBrFramework32.DLL" (ByVal aacHandle As Long, ByVal linguagem As String) As Long
Public Declare Function AAC_IdentPaf_Paf_SetMinasLegal Lib "ACBrFramework32.DLL" (ByVal aacHandle As Long, ByVal check As Boolean) As Long
Public Declare Function AAC_IdentPaf_Paf_SetNome Lib "ACBrFramework32.DLL" (ByVal aacHandle As Long, ByVal nome As String) As Long
Public Declare Function AAC_IdentPaf_Paf_SetRealizaDAVECF Lib "ACBrFramework32.DLL" (ByVal aacHandle As Long, ByVal check As Boolean) As Long
Public Declare Function AAC_IdentPaf_Paf_SetRealizaDAVNaoFiscal Lib "ACBrFramework32.DLL" (ByVal aacHandle As Long, ByVal check As Boolean) As Long
Public Declare Function AAC_IdentPaf_Paf_SetRealizaDAVOS Lib "ACBrFramework32.DLL" (ByVal aacHandle As Long, ByVal check As Boolean) As Long
Public Declare Function AAC_IdentPaf_Paf_SetRealizaLancamentoMesa Lib "ACBrFramework32.DLL" (ByVal aacHandle As Long, ByVal check As Boolean) As Long
Public Declare Function AAC_IdentPaf_Paf_SetRealizaPreVenda Lib "ACBrFramework32.DLL" (ByVal aacHandle As Long, ByVal check As Boolean) As Long
Public Declare Function AAC_IdentPaf_Paf_SetRecompoeGT Lib "ACBrFramework32.DLL" (ByVal aacHandle As Long, ByVal check As Boolean) As Long
Public Declare Function AAC_IdentPaf_Paf_SetSistemaOperacional Lib "ACBrFramework32.DLL" (ByVal aacHandle As Long, ByVal sistema As String) As Long
Public Declare Function AAC_IdentPaf_Paf_SetTipoDesenvolvimento Lib "ACBrFramework32.DLL" (ByVal aacHandle As Long, ByVal tipo As Long) As Long
Public Declare Function AAC_IdentPaf_Paf_SetTipoFuncionamento Lib "ACBrFramework32.DLL" (ByVal aacHandle As Long, ByVal tipo As Long) As Long
Public Declare Function AAC_IdentPaf_Paf_SetTotalizaValoresLista Lib "ACBrFramework32.DLL" (ByVal aacHandle As Long, ByVal check As Boolean) As Long
Public Declare Function AAC_IdentPaf_Paf_SetTransfDAV Lib "ACBrFramework32.DLL" (ByVal aacHandle As Long, ByVal check As Boolean) As Long
Public Declare Function AAC_IdentPaf_Paf_SetTransfPreVenda Lib "ACBrFramework32.DLL" (ByVal aacHandle As Long, ByVal check As Boolean) As Long
Public Declare Function AAC_IdentPaf_Paf_SetUsaImpressoraNaoFiscal Lib "ACBrFramework32.DLL" (ByVal aacHandle As Long, ByVal check As Boolean) As Long
Public Declare Function AAC_IdentPaf_Paf_SetVersao Lib "ACBrFramework32.DLL" (ByVal aacHandle As Long, ByVal versao As String) As Long
Public Declare Function AAC_IdentPaf_SetNumeroLaudo Lib "ACBrFramework32.DLL" (ByVal aacHandle As Long, ByVal razaoSocial As String) As Long
Public Declare Function AAC_IdentPaf_SetVersaoER Lib "ACBrFramework32.DLL" (ByVal aacHandle As Long, ByVal razaoSocial As String) As Long
Public Declare Function AAC_SalvarArquivo Lib "ACBrFramework32.DLL" (ByVal aacHandle As Long) As Long
Public Declare Function AAC_SetArqLOG Lib "ACBrFramework32.DLL" (ByVal aacHandle As Long, ByVal caminho As String) As Long
Public Declare Function AAC_SetChave Lib "ACBrFramework32.DLL" (ByVal aacHandle As Long, ByVal chave As String) As Long
Public Declare Function AAC_SetNomeArquivoAux Lib "ACBrFramework32.DLL" (ByVal aacHandle As Long, ByVal caminho As String) As Long
Public Declare Function AAC_SetParams Lib "ACBrFramework32.DLL" (ByVal aacHandle As Long, ByVal parametros As String) As Long
Public Declare Function AAC_VerificarGTECF Lib "ACBrFramework32.DLL" (ByVal aacHandle As Long, ByVal numSerie As String, ByRef grandTotal As Double) As Long
