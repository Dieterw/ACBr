Attribute VB_Name = "ACBrECFModule"
''
'' ACBrFramework DefExporter
'' Este arquivo foi gerado automaticamente
''


'' Tipos de dados

Public Type AliquotaRec
	Indice As String * 4
	Aliquota As Double
	Tipo As Boolean
	Total As Double
	Sequencia As Boolean
End Type

Public Type ComprovanteNaoFiscalRec
	Indice As String * 4
	Descricao As String * 30
	PermiteVinculado As Boolean
	FormaPagamento As String * 4
	Total As Double
	Contador As Long
End Type

Public Type DadosRZRec
	COO As Long
	CFD As Long
	CancelamentoISSQN As Double
	GNFC As Long
	CRO As Long
	ValorVendaBruta As Double
	TotalizadoresNaoFiscais As Long
	TotalizadoresNaoFiscaisLen As Long
	ICMS As Long
	ICMSLen As Long
	AcrescimoICMS As Double
	DescontoICMS As Double
	NaoTributadoICMS As Double
	RelatorioGerencial As Long
	RelatorioGerencialLen As Long
	CRZ As Long
	ISSQN As Long
	ISSQNLen As Long
	GRG As Long
	ValorGrandeTotal As Double
	AcrescimoISSQN As Double
	NaoTributadoISSQN As Double
	IsentoICMS As Double
	SubstituicaoTributariaICMS As Double
	DataDaImpressora As Double
	TotalOperacaoNaoFiscal As Double
	DescontoISSQN As Double
	CancelamentoOPNF As Double
	AcrescimoOPNF As Double
	DescontoOPNF As Double
	CancelamentoICMS As Double
	GNF As Long
	IsentoISSQN As Double
	SubstituicaoTributariaISSQN As Double
	VendaLiquida As Double
	CFC As Long
	CCF As Long
	TotalISSQN As Double
	TotalICMS As Double
	CDC As Long
	CCDC As Long
	NCN As Long
	DataDoMovimento As Double
	MeiosDePagamento As Long
	MeiosDePagamentoLen As Long
	NumeroCOOInicial As String * 30
	NumeroDoECF As String * 30
	NumeroDeSerie As String * 30
	NumeroDeSerieMFD As String * 30
	NumeroDaLoja As String * 30
	TotalTroco As Double
End Type

Public Type DAVsRec
	Numero As String * 14
	COO_Cupom As Long
	COO_Dav As Long
	Titulo As String * 31
	Valor As Double
	DtEmissao As Double
End Type

Public Type FormaPagamentoRec
	Indice As String * 4
	Descricao As String * 30
	PermiteVinculado As Boolean
	Total As Double
	Data As Double
	TipoDoc As String * 30
End Type

Public Type RelatorioGerencialRec
	Indice As String * 4
	Descricao As String * 30
	Contador As Long
End Type


'' Funções

Public Declare Function ECF_AbreCupom Lib "ACBrFramework32.DLL" (ByVal ecfHandle As Long, ByVal cpfCnpj As String, ByVal nome As String, ByVal endereco As String) As Long
Public Declare Function ECF_AbreCupomVinculado Lib "ACBrFramework32.DLL" (ByVal ecfHandle As Long, ByVal coo As String, ByVal codFormaPagto As String, ByVal valor As Double) As Long
Public Declare Function ECF_AbreCupomVinculadoCNF Lib "ACBrFramework32.DLL" (ByVal ecfHandle As Long, ByVal coo As String, ByVal codFormaPagto As String, ByVal codComprovanteNaoFiscal As String, ByVal valor As Double) As Long
Public Declare Function ECF_AbreGaveta Lib "ACBrFramework32.DLL" (ByVal ecfHandle As Long) As Long
Public Declare Function ECF_AbreNaoFiscal Lib "ACBrFramework32.DLL" (ByVal ecfHandle As Long, ByVal cpfCnpj As String) As Long
Public Declare Function ECF_AbreRelatorioGerencial Lib "ACBrFramework32.DLL" (ByVal ecfHandle As Long, ByVal indice As Long) As Long
Public Declare Function ECF_AcharECF Lib "ACBrFramework32.DLL" (ByVal ecfHandle As Long, ByVal Modelo As Boolean, ByVal Porta As Boolean, ByVal TimeOut As Long) As Long
Public Declare Function ECF_AcharPorta Lib "ACBrFramework32.DLL" (ByVal ecfHandle As Long, ByVal TimeOut As Long) As Long
Public Declare Function ECF_Ativar Lib "ACBrFramework32.DLL" (ByVal ecfHandle As Long) As Long
Public Declare Function ECF_CancelaCupom Lib "ACBrFramework32.DLL" (ByVal ecfHandle As Long) As Long
Public Declare Function ECF_CancelaDescontoAcrescimoItem Lib "ACBrFramework32.DLL" (ByVal ecfHandle As Long, ByVal numItem As Long) As Long
Public Declare Function ECF_CancelaDescontoAcrescimoSubTotal Lib "ACBrFramework32.DLL" (ByVal ecfHandle As Long, ByVal tipoAcrescimoDesconto As String) As Long
Public Declare Function ECF_CancelaItemVendido Lib "ACBrFramework32.DLL" (ByVal ecfHandle As Long, ByVal numItem As Long) As Long
Public Declare Function ECF_CancelaItemVendidoParcial Lib "ACBrFramework32.DLL" (ByVal ecfHandle As Long, ByVal numItem As Long, ByVal quantidade As Double) As Long
Public Declare Function ECF_CancelaNaoFiscal Lib "ACBrFramework32.DLL" (ByVal ecfHandle As Long) As Long
Public Declare Function ECF_CarregaAliquotas Lib "ACBrFramework32.DLL" (ByVal ecfHandle As Long) As Long
Public Declare Function ECF_CarregaComprovantesNaoFiscais Lib "ACBrFramework32.DLL" (ByVal ecfHandle As Long) As Long
Public Declare Function ECF_CarregaFormasPagamento Lib "ACBrFramework32.DLL" (ByVal ecfHandle As Long) As Long
Public Declare Function ECF_CorrigeEstadoErro Lib "ACBrFramework32.DLL" (ByVal ecfHandle As Long, ByVal reducaoZ As Boolean) As Long
Public Declare Function ECF_CortaPapel Lib "ACBrFramework32.DLL" (ByVal ecfHandle As Long, ByVal corteParcial As Boolean) As Long
Public Declare Function ECF_Create Lib "ACBrFramework32.DLL" (ByRef ecfHandle As Long) As Long
Public Declare Function ECF_DAV_Abrir Lib "ACBrFramework32.DLL" (ByVal ecfHandle As Long, ByVal emissao As Double, ByVal decrdocumento As String, ByVal numero As String, ByVal situacao As String, ByVal vendedor As String, ByVal observacao As String, ByVal cpfCnpj As String, ByVal nome As String, ByVal endereco As String) As Long
Public Declare Function ECF_DAV_Fechar Lib "ACBrFramework32.DLL" (ByVal ecfHandle As Long, ByVal observacao As String) As Long
Public Declare Function ECF_DAV_RegistrarItem Lib "ACBrFramework32.DLL" (ByVal ecfHandle As Long, ByVal codigo As String, ByVal descricao As String, ByVal unidade As String, ByVal quantidade As Double, ByVal vlrunitario As Double, ByVal desconto As Double, ByVal acrescimo As Double, ByVal cancelado As Boolean) As Long
Public Declare Function ECF_Desativar Lib "ACBrFramework32.DLL" (ByVal ecfHandle As Long) As Long
Public Declare Function ECF_DescontoAcrescimoItemAnterior Lib "ACBrFramework32.DLL" (ByVal ecfHandle As Long, ByVal valorDescontoAcrescimo As Double, ByVal descontoAcrescimo As String) As Long
Public Declare Function ECF_Destroy Lib "ACBrFramework32.DLL" (ByRef ecfHandle As Long) As Long
Public Declare Function ECF_DestroyDadosReducaoZClass Lib "ACBrFramework32.DLL" (ByVal ecfHandle As Long, ByRef dadosRZ As Long) As Long
Public Declare Function ECF_EfetuaPagamento Lib "ACBrFramework32.DLL" (ByVal ecfHandle As Long, ByVal codFormaPagto As String, ByVal valor As Double, ByVal observacao As String, ByVal imprimeVinculado As Boolean) As Long
Public Declare Function ECF_EfetuaPagamentoNaoFiscal Lib "ACBrFramework32.DLL" (ByVal ecfHandle As Long, ByVal codFormaPagto As String, ByVal valor As Double, ByVal observacao As String, ByVal imprimeVinculado As Boolean) As Long
Public Declare Function ECF_EstornaPagamento Lib "ACBrFramework32.DLL" (ByVal ecfHandle As Long, ByVal codFormaPagtoEstornar As String, ByVal codFormaPagtoEfetivar As String, ByVal valor As Double, ByVal observacao As String) As Long
Public Declare Function ECF_FechaCupom Lib "ACBrFramework32.DLL" (ByVal ecfHandle As Long, ByVal observacao As String) As Long
Public Declare Function ECF_FechaNaoFiscal Lib "ACBrFramework32.DLL" (ByVal ecfHandle As Long, ByVal observacao As String) As Long
Public Declare Function ECF_FechaRelatorio Lib "ACBrFramework32.DLL" (ByVal ecfHandle As Long) As Long
Public Declare Function ECF_GetAguardaImpressao Lib "ACBrFramework32.DLL" (ByVal ecfHandle As Long) As Long
Public Declare Function ECF_GetAguardandoResposta Lib "ACBrFramework32.DLL" (ByVal ecfHandle As Long) As Long
Public Declare Function ECF_GetAliquota Lib "ACBrFramework32.DLL" (ByVal ecfHandle As Long, ByRef aliquota As AliquotaRec, ByVal index As Long) As Long
Public Declare Function ECF_GetArredonda Lib "ACBrFramework32.DLL" (ByVal ecfHandle As Long) As Long
Public Declare Function ECF_GetAtivo Lib "ACBrFramework32.DLL" (ByVal ecfHandle As Long) As Long
Public Declare Function ECF_GetBaud Lib "ACBrFramework32.DLL" (ByVal ecfHandle As Long) As Long
Public Declare Function ECF_GetChequePronto Lib "ACBrFramework32.DLL" (ByVal ecfHandle As Long) As Long
Public Declare Function ECF_GetCliche Lib "ACBrFramework32.DLL" (ByVal ecfHandle As Long, ByVal buffer As String, ByVal bufferLen As Long) As Long
Public Declare Function ECF_GetCNPJ Lib "ACBrFramework32.DLL" (ByVal ecfHandle As Long, ByVal buffer As String, ByVal bufferLen As Long) As Long
Public Declare Function ECF_GetColunas Lib "ACBrFramework32.DLL" (ByVal ecfHandle As Long) As Long
Public Declare Function ECF_GetComandoEnviado Lib "ACBrFramework32.DLL" (ByVal ecfHandle As Long, ByVal buffer As String, ByVal bufferLen As Long) As Long
Public Declare Function ECF_GetComandoLOG Lib "ACBrFramework32.DLL" (ByVal ecfHandle As Long, ByVal buffer As String, ByVal bufferLen As Long) As Long
Public Declare Function ECF_GetComprovanteNaoFiscal Lib "ACBrFramework32.DLL" (ByVal ecfHandle As Long, ByRef comprovanteNaoFiscal As ComprovanteNaoFiscalRec, ByVal index As Long) As Long
Public Declare Function ECF_GetDadosReducaoZ Lib "ACBrFramework32.DLL" (ByVal ecfHandle As Long, ByVal buffer As String, ByVal bufferLen As Long) As Long
Public Declare Function ECF_GetDadosReducaoZClass Lib "ACBrFramework32.DLL" (ByVal ecfHandle As Long, ByRef dadosRZ As Long) As Long
Public Declare Function ECF_GetDadosUltimaReducaoZ Lib "ACBrFramework32.DLL" (ByVal ecfHandle As Long, ByVal buffer As String, ByVal bufferLen As Long) As Long
Public Declare Function ECF_GetDataBits Lib "ACBrFramework32.DLL" (ByVal ecfHandle As Long) As Long
Public Declare Function ECF_GetDataHora Lib "ACBrFramework32.DLL" (ByVal ecfHandle As Long, ByRef value As Double) As Long
Public Declare Function ECF_GetDataHoraSB Lib "ACBrFramework32.DLL" (ByVal ecfHandle As Long, ByRef value As Double) As Long
Public Declare Function ECF_GetDataMovimento Lib "ACBrFramework32.DLL" (ByVal ecfHandle As Long, ByRef value As Double) As Long
Public Declare Function ECF_GetDecimaisPreco Lib "ACBrFramework32.DLL" (ByVal ecfHandle As Long) As Long
Public Declare Function ECF_GetDecimaisQtd Lib "ACBrFramework32.DLL" (ByVal ecfHandle As Long) As Long
Public Declare Function ECF_GetDescricaoGrande Lib "ACBrFramework32.DLL" (ByVal ecfHandle As Long) As Long
Public Declare Function ECF_GetEmLinha Lib "ACBrFramework32.DLL" (ByVal ecfHandle As Long, ByVal timeOut As Long) As Long
Public Declare Function ECF_GetEstado Lib "ACBrFramework32.DLL" (ByVal ecfHandle As Long) As Long
Public Declare Function ECF_GetFormaPagamento Lib "ACBrFramework32.DLL" (ByVal ecfHandle As Long, ByRef formaPagamento As FormaPagamentoRec, ByVal index As Long) As Long
Public Declare Function ECF_GetGavetaAberta Lib "ACBrFramework32.DLL" (ByVal ecfHandle As Long) As Long
Public Declare Function ECF_GetGavetaSinalInvertido Lib "ACBrFramework32.DLL" (ByVal ecfHandle As Long) As Long
Public Declare Function ECF_GetGrandeTotal Lib "ACBrFramework32.DLL" (ByVal ecfHandle As Long, ByRef value As Double) As Long
Public Declare Function ECF_GetHandShake Lib "ACBrFramework32.DLL" (ByVal ecfHandle As Long) As Long
Public Declare Function ECF_GetHardFlow Lib "ACBrFramework32.DLL" (ByVal ecfHandle As Long) As Long
Public Declare Function ECF_GetHorarioVerao Lib "ACBrFramework32.DLL" (ByVal ecfHandle As Long) As Long
Public Declare Function ECF_GetIdentificaConsumidorRodape Lib "ACBrFramework32.DLL" (ByVal ecfHandle As Long) As Long
Public Declare Function ECF_GetIE Lib "ACBrFramework32.DLL" (ByVal ecfHandle As Long, ByVal buffer As String, ByVal bufferLen As Long) As Long
Public Declare Function ECF_GetIM Lib "ACBrFramework32.DLL" (ByVal ecfHandle As Long, ByVal buffer As String, ByVal bufferLen As Long) As Long
Public Declare Function ECF_GetIntervaloAposComando Lib "ACBrFramework32.DLL" (ByVal ecfHandle As Long) As Long
Public Declare Function ECF_GetLinhasEntreCupons Lib "ACBrFramework32.DLL" (ByVal ecfHandle As Long) As Long
Public Declare Function ECF_GetMFD Lib "ACBrFramework32.DLL" (ByVal ecfHandle As Long) As Long
Public Declare Function ECF_GetModelo Lib "ACBrFramework32.DLL" (ByVal ecfHandle As Long) As Long
Public Declare Function ECF_GetModeloStr Lib "ACBrFramework32.DLL" (ByVal ecfHandle As Long, ByVal buffer As String, ByVal bufferLen As Long) As Long
Public Declare Function ECF_GetNumCCF Lib "ACBrFramework32.DLL" (ByVal ecfHandle As Long, ByVal buffer As String, ByVal bufferLen As Long) As Long
Public Declare Function ECF_GetNumCDC Lib "ACBrFramework32.DLL" (ByVal ecfHandle As Long, ByVal buffer As String, ByVal bufferLen As Long) As Long
Public Declare Function ECF_GetNumCOO Lib "ACBrFramework32.DLL" (ByVal ecfHandle As Long, ByVal buffer As String, ByVal bufferLen As Long) As Long
Public Declare Function ECF_GetNumCOOInicial Lib "ACBrFramework32.DLL" (ByVal ecfHandle As Long, ByVal buffer As String, ByVal bufferLen As Long) As Long
Public Declare Function ECF_GetNumCRO Lib "ACBrFramework32.DLL" (ByVal ecfHandle As Long, ByVal buffer As String, ByVal bufferLen As Long) As Long
Public Declare Function ECF_GetNumCRZ Lib "ACBrFramework32.DLL" (ByVal ecfHandle As Long, ByVal buffer As String, ByVal bufferLen As Long) As Long
Public Declare Function ECF_GetNumCupom Lib "ACBrFramework32.DLL" (ByVal ecfHandle As Long, ByVal buffer As String, ByVal bufferLen As Long) As Long
Public Declare Function ECF_GetNumECF Lib "ACBrFramework32.DLL" (ByVal ecfHandle As Long, ByVal buffer As String, ByVal bufferLen As Long) As Long
Public Declare Function ECF_GetNumGNF Lib "ACBrFramework32.DLL" (ByVal ecfHandle As Long, ByVal buffer As String, ByVal bufferLen As Long) As Long
Public Declare Function ECF_GetNumGRG Lib "ACBrFramework32.DLL" (ByVal ecfHandle As Long, ByVal buffer As String, ByVal bufferLen As Long) As Long
Public Declare Function ECF_GetNumLoja Lib "ACBrFramework32.DLL" (ByVal ecfHandle As Long, ByVal buffer As String, ByVal bufferLen As Long) As Long
Public Declare Function ECF_GetNumSerie Lib "ACBrFramework32.DLL" (ByVal ecfHandle As Long, ByVal buffer As String, ByVal bufferLen As Long) As Long
Public Declare Function ECF_GetNumUltItem Lib "ACBrFramework32.DLL" (ByVal ecfHandle As Long) As Long
Public Declare Function ECF_GetNumVersao Lib "ACBrFramework32.DLL" (ByVal ecfHandle As Long, ByVal buffer As String, ByVal bufferLen As Long) As Long
Public Declare Function ECF_GetOperador Lib "ACBrFramework32.DLL" (ByVal ecfHandle As Long, ByVal buffer As String, ByVal bufferLen As Long) As Long
Public Declare Function ECF_GetPAF Lib "ACBrFramework32.DLL" (ByVal ecfHandle As Long, ByVal buffer As String, ByVal bufferLen As Long) As Long
Public Declare Function ECF_GetParity Lib "ACBrFramework32.DLL" (ByVal ecfHandle As Long) As Long
Public Declare Function ECF_GetPorta Lib "ACBrFramework32.DLL" (ByVal ecfHandle As Long, ByVal buffer As String, ByVal bufferLen As Long) As Long
Public Declare Function ECF_GetPoucoPapel Lib "ACBrFramework32.DLL" (ByVal ecfHandle As Long) As Long
Public Declare Function ECF_GetRelatoriosGerenciais Lib "ACBrFramework32.DLL" (ByVal ecfHandle As Long, ByRef relatorio As RelatorioGerencialRec, ByVal index As Long) As Long
Public Declare Function ECF_GetRespostaComando Lib "ACBrFramework32.DLL" (ByVal ecfHandle As Long, ByVal buffer As String, ByVal bufferLen As Long) As Long
Public Declare Function ECF_GetRFDID Lib "ACBrFramework32.DLL" (ByVal ecfHandle As Long, ByVal buffer As String, ByVal bufferLen As Long) As Long
Public Declare Function ECF_GetSoftFlow Lib "ACBrFramework32.DLL" (ByVal ecfHandle As Long) As Long
Public Declare Function ECF_GetStopBits Lib "ACBrFramework32.DLL" (ByVal ecfHandle As Long) As Long
Public Declare Function ECF_GetSubModeloECF Lib "ACBrFramework32.DLL" (ByVal ecfHandle As Long, ByVal buffer As String, ByVal bufferLen As Long) As Long
Public Declare Function ECF_GetSubTotal Lib "ACBrFramework32.DLL" (ByVal ecfHandle As Long, ByRef value As Double) As Long
Public Declare Function ECF_GetTermica Lib "ACBrFramework32.DLL" (ByVal ecfHandle As Long) As Long
Public Declare Function ECF_GetTimeOut Lib "ACBrFramework32.DLL" (ByVal ecfHandle As Long) As Long
Public Declare Function ECF_GetTotalAcrescimos Lib "ACBrFramework32.DLL" (ByVal ecfHandle As Long, ByRef value As Double) As Long
Public Declare Function ECF_GetTotalAcrescimosISSQN Lib "ACBrFramework32.DLL" (ByVal ecfHandle As Long, ByRef value As Double) As Long
Public Declare Function ECF_GetTotalCancelamentos Lib "ACBrFramework32.DLL" (ByVal ecfHandle As Long, ByRef value As Double) As Long
Public Declare Function ECF_GetTotalCancelamentosISSQN Lib "ACBrFramework32.DLL" (ByVal ecfHandle As Long, ByRef value As Double) As Long
Public Declare Function ECF_GetTotalDescontos Lib "ACBrFramework32.DLL" (ByVal ecfHandle As Long, ByRef value As Double) As Long
Public Declare Function ECF_GetTotalDescontosISSQN Lib "ACBrFramework32.DLL" (ByVal ecfHandle As Long, ByRef value As Double) As Long
Public Declare Function ECF_GetTotalIsencao Lib "ACBrFramework32.DLL" (ByVal ecfHandle As Long, ByRef value As Double) As Long
Public Declare Function ECF_GetTotalIsencaoISSQN Lib "ACBrFramework32.DLL" (ByVal ecfHandle As Long, ByRef value As Double) As Long
Public Declare Function ECF_GetTotalNaoFiscal Lib "ACBrFramework32.DLL" (ByVal ecfHandle As Long, ByRef value As Double) As Long
Public Declare Function ECF_GetTotalNaoTributado Lib "ACBrFramework32.DLL" (ByVal ecfHandle As Long, ByRef value As Double) As Long
Public Declare Function ECF_GetTotalNaoTributadoISSQN Lib "ACBrFramework32.DLL" (ByVal ecfHandle As Long, ByRef value As Double) As Long
Public Declare Function ECF_GetTotalPago Lib "ACBrFramework32.DLL" (ByVal ecfHandle As Long, ByRef value As Double) As Long
Public Declare Function ECF_GetTotalSubstituicaoTributaria Lib "ACBrFramework32.DLL" (ByVal ecfHandle As Long, ByRef value As Double) As Long
Public Declare Function ECF_GetTotalSubstituicaoTributariaISSQN Lib "ACBrFramework32.DLL" (ByVal ecfHandle As Long, ByRef value As Double) As Long
Public Declare Function ECF_GetTotalTroco Lib "ACBrFramework32.DLL" (ByVal ecfHandle As Long, ByRef value As Double) As Long
Public Declare Function ECF_GetUltimoErro Lib "ACBrFramework32.DLL" (ByVal ecfHandle As Long, ByVal buffer As String, ByVal bufferLen As Long) As Long
Public Declare Function ECF_GetUsuarioAtual Lib "ACBrFramework32.DLL" (ByVal ecfHandle As Long, ByVal buffer As String, ByVal bufferLen As Long) As Long
Public Declare Function ECF_GetVendaBruta Lib "ACBrFramework32.DLL" (ByVal ecfHandle As Long, ByRef value As Double) As Long
Public Declare Function ECF_IdentificaConsumidor Lib "ACBrFramework32.DLL" (ByVal ecfHandle As Long, ByVal cpfCnpj As String, ByVal nome As String, ByVal endereco As String) As Long
Public Declare Function ECF_IdentificaPAF Lib "ACBrFramework32.DLL" (ByVal ecfHandle As Long, ByVal nomeVersao As String, ByVal md5 As String) As Long
Public Declare Function ECF_LegendaInmetroProximoItem Lib "ACBrFramework32.DLL" (ByVal ecfHandle As Long) As Long
Public Declare Function ECF_LeituraMemoriaFiscalArquivoData Lib "ACBrFramework32.DLL" (ByVal ecfHandle As Long, ByVal dataInicial As Double, ByVal dataFinal As Double, ByVal nomeArquivo As String, ByVal simplificada As Boolean) As Long
Public Declare Function ECF_LeituraMemoriaFiscalArquivoReducao Lib "ACBrFramework32.DLL" (ByVal ecfHandle As Long, ByVal reducaoInicial As Long, ByVal reducaoFinal As Long, ByVal nomeArquivo As String, ByVal simplificada As Boolean) As Long
Public Declare Function ECF_LeituraMemoriaFiscalData Lib "ACBrFramework32.DLL" (ByVal ecfHandle As Long, ByVal dataInicial As Double, ByVal dataFinal As Double, ByVal simplificada As Boolean) As Long
Public Declare Function ECF_LeituraMemoriaFiscalReducao Lib "ACBrFramework32.DLL" (ByVal ecfHandle As Long, ByVal reducaoInicial As Long, ByVal reducaoFinal As Long, ByVal simplificada As Boolean) As Long
Public Declare Function ECF_LeituraMemoriaFiscalSerialData Lib "ACBrFramework32.DLL" (ByVal ecfHandle As Long, ByVal dataInicial As Double, ByVal dataFinal As Double, ByVal simplificada As Boolean, ByVal buffer As String, ByVal bufferLen As Long) As Long
Public Declare Function ECF_LeituraMemoriaFiscalSerialReducao Lib "ACBrFramework32.DLL" (ByVal ecfHandle As Long, ByVal reducaoInicial As Long, ByVal reducaoFinal As Long, ByVal simplificada As Boolean, ByVal buffer As String, ByVal bufferLen As Long) As Long
Public Declare Function ECF_LeituraX Lib "ACBrFramework32.DLL" (ByVal ecfHandle As Long) As Long
Public Declare Function ECF_LerTotaisAliquota Lib "ACBrFramework32.DLL" (ByVal ecfHandle As Long) As Long
Public Declare Function ECF_LerTotaisComprovanteNaoFiscal Lib "ACBrFramework32.DLL" (ByVal ecfHandle As Long) As Long
Public Declare Function ECF_LerTotaisFormaPagamento Lib "ACBrFramework32.DLL" (ByVal ecfHandle As Long) As Long
Public Declare Function ECF_LinhaCupomVinculado Lib "ACBrFramework32.DLL" (ByVal ecfHandle As Long, ByVal linha As String) As Long
Public Declare Function ECF_LinhaRelatorioGerencial Lib "ACBrFramework32.DLL" (ByVal ecfHandle As Long, ByVal linha As String, ByVal indiceBMP As Long) As Long
Public Declare Function ECF_PafMF_GerarCAT52 Lib "ACBrFramework32.DLL" (ByVal ecfHandle As Long, ByVal DataInicial As Double, ByVal DataFinal As Double, ByVal CaminhoArquivo As String) As Long
Public Declare Function ECF_PafMF_LMFC_Cotepe1704 Lib "ACBrFramework32.DLL" (ByVal ecfHandle As Long, ByVal DataInicial As Double, ByVal DataFinal As Double, ByVal CaminhoArquivo As String) As Long
Public Declare Function ECF_PafMF_LMFC_Cotepe1704_CRZ Lib "ACBrFramework32.DLL" (ByVal ecfHandle As Long, ByVal CRZInicial As Long, ByVal CRZFinal As Long, ByVal CaminhoArquivo As String) As Long
Public Declare Function ECF_PafMF_LMFC_Espelho Lib "ACBrFramework32.DLL" (ByVal ecfHandle As Long, ByVal DataInicial As Double, ByVal DataFinal As Double, ByVal CaminhoArquivo As String) As Long
Public Declare Function ECF_PafMF_LMFC_Espelho_CRZ Lib "ACBrFramework32.DLL" (ByVal ecfHandle As Long, ByVal CRZInicial As Long, ByVal CRZFinal As Long, ByVal CaminhoArquivo As String) As Long
Public Declare Function ECF_PafMF_LMFC_Impressao Lib "ACBrFramework32.DLL" (ByVal ecfHandle As Long, ByVal DataInicial As Double, ByVal DataFinal As Double) As Long
Public Declare Function ECF_PafMF_LMFC_Impressao_CRZ Lib "ACBrFramework32.DLL" (ByVal ecfHandle As Long, ByVal CRZInicial As Long, ByVal CRZFinal As Long) As Long
Public Declare Function ECF_PafMF_LMFS_Espelho Lib "ACBrFramework32.DLL" (ByVal ecfHandle As Long, ByVal DataInicial As Double, ByVal DataFinal As Double, ByVal CaminhoArquivo As String) As Long
Public Declare Function ECF_PafMF_LMFS_Espelho_CRZ Lib "ACBrFramework32.DLL" (ByVal ecfHandle As Long, ByVal CRZInicial As Long, ByVal CRZFinal As Long, ByVal CaminhoArquivo As String) As Long
Public Declare Function ECF_PafMF_LMFS_Impressao Lib "ACBrFramework32.DLL" (ByVal ecfHandle As Long, ByVal DataInicial As Double, ByVal DataFinal As Double) As Long
Public Declare Function ECF_PafMF_LMFS_Impressao_CRZ Lib "ACBrFramework32.DLL" (ByVal ecfHandle As Long, ByVal CRZInicial As Long, ByVal CRZFinal As Long) As Long
Public Declare Function ECF_PafMF_LX_Impressao Lib "ACBrFramework32.DLL" (ByVal ecfHandle As Long) As Long
Public Declare Function ECF_PafMF_MFD_Cotepe1704 Lib "ACBrFramework32.DLL" (ByVal ecfHandle As Long, ByVal DataInicial As Double, ByVal DataFinal As Double, ByVal CaminhoArquivo As String) As Long
Public Declare Function ECF_PafMF_MFD_Cotepe1704_COO Lib "ACBrFramework32.DLL" (ByVal ecfHandle As Long, ByVal COOInicial As Long, ByVal COOFinal As Long, ByVal CaminhoArquivo As String) As Long
Public Declare Function ECF_PafMF_MFD_Espelho Lib "ACBrFramework32.DLL" (ByVal ecfHandle As Long, ByVal DataInicial As Double, ByVal DataFinal As Double, ByVal CaminhoArquivo As String) As Long
Public Declare Function ECF_PafMF_MFD_Espelho_COO Lib "ACBrFramework32.DLL" (ByVal ecfHandle As Long, ByVal COOInicial As Long, ByVal COOFinal As Long, ByVal CaminhoArquivo As String) As Long
Public Declare Function ECF_PafMF_RelDAVEmitidos Lib "ACBrFramework32.DLL" (ByVal ecfHandle As Long, ByRef DAVs() As DAVsRec, ByVal index As Long, ByVal TituloRelatorio As String, ByVal IndiceRelatorio As String) As Long
Public Declare Function ECF_PafMF_RelIdentificacaoPafECF Lib "ACBrFramework32.DLL" (ByVal ecfHandle As Long, ByVal aacHandle As Long, ByVal IndiceRelatorio As Long) As Long
Public Declare Function ECF_PafMF_RelMeiosPagamento Lib "ACBrFramework32.DLL" (ByVal ecfHandle As Long, ByRef formasPagamento() As FormaPagamentoRec, ByVal count As Long, ByVal TituloRelatorio As String, ByVal IndiceRelatorio As Long) As Long
Public Declare Function ECF_ProgramaAliquota Lib "ACBrFramework32.DLL" (ByVal ecfHandle As Long, ByVal aliquota As Double, ByVal tipo As String, ByVal posicao As String) As Long
Public Declare Function ECF_ProgramaComprovanteNaoFiscal Lib "ACBrFramework32.DLL" (ByVal ecfHandle As Long, ByVal descricao As String, ByVal tipo As String, ByVal posicao As String) As Long
Public Declare Function ECF_ProgramaFormaPagamento Lib "ACBrFramework32.DLL" (ByVal ecfHandle As Long, ByVal descricao As String, ByVal permiteVinculado As Boolean, ByVal posicao As String) As Long
Public Declare Function ECF_ProgramaRelatoriosGerenciais Lib "ACBrFramework32.DLL" (ByVal ecfHandle As Long, ByVal descricao As String, ByVal posicao As String) As Long
Public Declare Function ECF_PulaLinhas Lib "ACBrFramework32.DLL" (ByVal ecfHandle As Long, ByVal numLinhas As Long) As Long
Public Declare Function ECF_ReducaoZ Lib "ACBrFramework32.DLL" (ByVal ecfHandle As Long) As Long
Public Declare Function ECF_RegistraItemNaoFiscal Lib "ACBrFramework32.DLL" (ByVal ecfHandle As Long, ByVal codCNF As String, ByVal value As Double, ByVal obs As String) As Long
Public Declare Function ECF_Sangria Lib "ACBrFramework32.DLL" (ByVal ecfHandle As Long, ByVal valor As Double, ByVal obs As String) As Long
Public Declare Function ECF_SetAAC Lib "ACBrFramework32.DLL" (ByVal ecfHandle As Long, ByVal aacHandle As Long) As Long
Public Declare Function ECF_SetAguardaImpressao Lib "ACBrFramework32.DLL" (ByVal ecfHandle As Long, ByVal aguardaImpressao As Boolean) As Long
Public Declare Function ECF_SetBaud Lib "ACBrFramework32.DLL" (ByVal ecfHandle As Long, ByVal baud As Long) As Long
Public Declare Function ECF_SetComandoLOG Lib "ACBrFramework32.DLL" (ByVal ecfHandle As Long, ByVal comandoLog As String) As Long
Public Declare Function ECF_SetDataBits Lib "ACBrFramework32.DLL" (ByVal ecfHandle As Long, ByVal dataBits As Long) As Long
Public Declare Function ECF_SetDecimaisPreco Lib "ACBrFramework32.DLL" (ByVal ecfHandle As Long, ByVal decimaisPreco As Long) As Long
Public Declare Function ECF_SetDecimaisQtd Lib "ACBrFramework32.DLL" (ByVal ecfHandle As Long, ByVal decimaisQtd As Long) As Long
Public Declare Function ECF_SetDescricaoGrande Lib "ACBrFramework32.DLL" (ByVal ecfHandle As Long, ByVal descricaoGrande As Boolean) As Long
Public Declare Function ECF_SetGavetaSinalInvertido Lib "ACBrFramework32.DLL" (ByVal ecfHandle As Long, ByVal gavetaSinalInvertido As Boolean) As Long
Public Declare Function ECF_SetHandShake Lib "ACBrFramework32.DLL" (ByVal ecfHandle As Long, ByVal handShake As Long) As Long
Public Declare Function ECF_SetHardFlow Lib "ACBrFramework32.DLL" (ByVal ecfHandle As Long, ByVal hardFlow As Boolean) As Long
Public Declare Function ECF_SetIntervaloAposComando Lib "ACBrFramework32.DLL" (ByVal ecfHandle As Long, ByVal intervalo As Long) As Long
Public Declare Function ECF_SetLinhasEntreCupons Lib "ACBrFramework32.DLL" (ByVal ecfHandle As Long, ByVal linhasEntreCupons As Long) As Long
Public Declare Function ECF_SetModelo Lib "ACBrFramework32.DLL" (ByVal ecfHandle As Long, ByVal modelo As Long) As Long
Public Declare Function ECF_SetOperador Lib "ACBrFramework32.DLL" (ByVal ecfHandle As Long, ByVal operador As String) As Long
Public Declare Function ECF_SetParity Lib "ACBrFramework32.DLL" (ByVal ecfHandle As Long, ByVal parity As Long) As Long
Public Declare Function ECF_SetPorta Lib "ACBrFramework32.DLL" (ByVal ecfHandle As Long, ByVal porta As String) As Long
Public Declare Function ECF_SetSoftFlow Lib "ACBrFramework32.DLL" (ByVal ecfHandle As Long, ByVal softFlow As Boolean) As Long
Public Declare Function ECF_SetStopBits Lib "ACBrFramework32.DLL" (ByVal ecfHandle As Long, ByVal stopBits As Long) As Long
Public Declare Function ECF_SetTimeOut Lib "ACBrFramework32.DLL" (ByVal ecfHandle As Long, ByVal timeOut As Long) As Long
Public Declare Function ECF_SubtotalizaCupom Lib "ACBrFramework32.DLL" (ByVal ecfHandle As Long, ByVal descontoAcrescimo As Double, ByVal mensagemRodape As String) As Long
Public Declare Function ECF_SubtotalizaNaoFiscal Lib "ACBrFramework32.DLL" (ByVal ecfHandle As Long, ByVal descontoAcrescimo As Double, ByVal mensagemRodape As String) As Long
Public Declare Function ECF_Suprimento Lib "ACBrFramework32.DLL" (ByVal ecfHandle As Long, ByVal valor As Double, ByVal obs As String) As Long
Public Declare Function ECF_VendeItem Lib "ACBrFramework32.DLL" (ByVal ecfHandle As Long, ByVal codigo As String, ByVal descricao As String, ByVal aliquotaICMS As String, ByVal qtd As Double, ByVal valorUnitario As Double, ByVal descontoPorc As Double, ByVal unidade As String, ByVal tipoDescontoAcrescimo As String, ByVal descontoAcrescimo As String) As Long
