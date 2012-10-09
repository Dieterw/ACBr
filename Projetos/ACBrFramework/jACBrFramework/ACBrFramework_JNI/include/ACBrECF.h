/**
* ACBrFramework DefExporter
* Este arquivo foi gerado automaticamente
**/



#ifndef ACBr
#define ACBr

typedef void* INTPTR;
typedef char* PCHAR;
typedef char BOOL;

#endif


#ifndef _ACBrECF_H_
#define _ACBrECF_H_

#ifdef __cplusplus
#define DllImport extern "C"
#else
#define DllImport extern
#endif


// Tipos de dados

typedef struct
{
	char Indice[4];
	double Aliquota;
	BOOL Tipo;
	double Total;
	BOOL Sequencia;
} AliquotaRec;

typedef struct
{
	char Indice[4];
	char Descricao[30];
	BOOL PermiteVinculado;
	char FormaPagamento[4];
	double Total;
	int Contador;
} ComprovanteNaoFiscalRec;

typedef struct
{
	int COO;
	int CFD;
	double CancelamentoISSQN;
	int GNFC;
	int CRO;
	double ValorVendaBruta;
	INTPTR TotalizadoresNaoFiscais;
	int TotalizadoresNaoFiscaisLen;
	INTPTR ICMS;
	int ICMSLen;
	double AcrescimoICMS;
	double DescontoICMS;
	double NaoTributadoICMS;
	INTPTR RelatorioGerencial;
	int RelatorioGerencialLen;
	int CRZ;
	INTPTR ISSQN;
	int ISSQNLen;
	int GRG;
	double ValorGrandeTotal;
	double AcrescimoISSQN;
	double NaoTributadoISSQN;
	double IsentoICMS;
	double SubstituicaoTributariaICMS;
	double DataDaImpressora;
	double TotalOperacaoNaoFiscal;
	double DescontoISSQN;
	double CancelamentoOPNF;
	double AcrescimoOPNF;
	double DescontoOPNF;
	double CancelamentoICMS;
	int GNF;
	double IsentoISSQN;
	double SubstituicaoTributariaISSQN;
	double VendaLiquida;
	int CFC;
	int CCF;
	double TotalISSQN;
	double TotalICMS;
	int CDC;
	int CCDC;
	int NCN;
	double DataDoMovimento;
	INTPTR MeiosDePagamento;
	int MeiosDePagamentoLen;
	char NumeroCOOInicial[30];
	char NumeroDoECF[30];
	char NumeroDeSerie[30];
	char NumeroDeSerieMFD[30];
	char NumeroDaLoja[30];
	double TotalTroco;
} DadosRZRec;

typedef struct
{
	char Numero[14];
	int COO_Cupom;
	int COO_Dav;
	char Titulo[31];
	double Valor;
	double DtEmissao;
} DAVsRec;

typedef struct
{
	char Indice[4];
	char Descricao[30];
	BOOL PermiteVinculado;
	double Total;
	double Data;
	char TipoDoc[30];
} FormaPagamentoRec;

typedef struct
{
	char Texto[49];
} RelatorioGerencialLinha;

typedef struct
{
	int Count;
	RelatorioGerencialLinha Linhas[];
} RelatorioGerencial;


typedef struct
{
	char Indice[4];
	char Descricao[30];
	int Contador;
} RelatorioGerencialRec;


// Funções

DllImport int ECF_AbreCupom(const INTPTR ecfHandle, const PCHAR cpfCnpj, const PCHAR nome, const PCHAR endereco);
DllImport int ECF_AbreCupomVinculado(const INTPTR ecfHandle, const PCHAR coo, const PCHAR codFormaPagto, const double valor);
DllImport int ECF_AbreCupomVinculadoCNF(const INTPTR ecfHandle, const PCHAR coo, const PCHAR codFormaPagto, const PCHAR codComprovanteNaoFiscal, const double valor);
DllImport int ECF_AbreGaveta(const INTPTR ecfHandle);
DllImport int ECF_AbreNaoFiscal(const INTPTR ecfHandle, const PCHAR cpfCnpj);
DllImport int ECF_AbreRelatorioGerencial(const INTPTR ecfHandle, const int indice);
DllImport int ECF_AcharECF(const INTPTR ecfHandle, const BOOL Modelo, const BOOL Porta, const int TimeOut);
DllImport int ECF_AcharPorta(const INTPTR ecfHandle, const int TimeOut);
DllImport int ECF_Ativar(const INTPTR ecfHandle);
DllImport int ECF_CancelaCupom(const INTPTR ecfHandle);
DllImport int ECF_CancelaDescontoAcrescimoItem(const INTPTR ecfHandle, const int numItem);
DllImport int ECF_CancelaDescontoAcrescimoSubTotal(const INTPTR ecfHandle, const char tipoAcrescimoDesconto);
DllImport int ECF_CancelaItemVendido(const INTPTR ecfHandle, const int numItem);
DllImport int ECF_CancelaItemVendidoParcial(const INTPTR ecfHandle, const int numItem, const double quantidade);
DllImport int ECF_CancelaNaoFiscal(const INTPTR ecfHandle);
DllImport int ECF_CarregaAliquotas(const INTPTR ecfHandle);
DllImport int ECF_CarregaComprovantesNaoFiscais(const INTPTR ecfHandle);
DllImport int ECF_CarregaFormasPagamento(const INTPTR ecfHandle);
DllImport int ECF_CarregaRelatoriosGerenciais(const INTPTR ecfHandle);
DllImport int ECF_CorrigeEstadoErro(const INTPTR ecfHandle, const BOOL reducaoZ);
DllImport int ECF_CortaPapel(const INTPTR ecfHandle, const BOOL corteParcial);
DllImport int ECF_Create(INTPTR* ecfHandle);
DllImport int ECF_DAV_Abrir(const INTPTR ecfHandle, const double emissao, const PCHAR decrdocumento, const PCHAR numero, const PCHAR situacao, const PCHAR vendedor, const PCHAR observacao, const PCHAR cpfCnpj, const PCHAR nome, const PCHAR endereco);
DllImport int ECF_DAV_Fechar(const INTPTR ecfHandle, const PCHAR observacao);
DllImport int ECF_DAV_RegistrarItem(const INTPTR ecfHandle, const PCHAR codigo, const PCHAR descricao, const PCHAR unidade, const double quantidade, const double vlrunitario, const double desconto, const double acrescimo, const BOOL cancelado);
DllImport int ECF_Desativar(const INTPTR ecfHandle);
DllImport int ECF_DescontoAcrescimoItemAnterior(const INTPTR ecfHandle, const double valorDescontoAcrescimo, const PCHAR descontoAcrescimo);
DllImport int ECF_Destroy(INTPTR* ecfHandle);
DllImport int ECF_DestroyDadosReducaoZClass(const INTPTR ecfHandle, INTPTR* dadosRZ);
DllImport int ECF_EfetuaPagamento(const INTPTR ecfHandle, const PCHAR codFormaPagto, const double valor, const PCHAR observacao, const BOOL imprimeVinculado);
DllImport int ECF_EfetuaPagamentoNaoFiscal(const INTPTR ecfHandle, const PCHAR codFormaPagto, const double valor, const PCHAR observacao, const BOOL imprimeVinculado);
DllImport int ECF_EstornaPagamento(const INTPTR ecfHandle, const PCHAR codFormaPagtoEstornar, const PCHAR codFormaPagtoEfetivar, const double valor, const PCHAR observacao);
DllImport int ECF_FechaCupom(const INTPTR ecfHandle, const PCHAR observacao);
DllImport int ECF_FechaNaoFiscal(const INTPTR ecfHandle, const PCHAR observacao);
DllImport int ECF_FechaRelatorio(const INTPTR ecfHandle);
DllImport int ECF_GetAguardaImpressao(const INTPTR ecfHandle);
DllImport int ECF_GetAguardandoResposta(const INTPTR ecfHandle);
DllImport int ECF_GetAliquota(const INTPTR ecfHandle, AliquotaRec* aliquota, const int index);
DllImport int ECF_GetArredonda(const INTPTR ecfHandle);
DllImport int ECF_GetAtivo(const INTPTR ecfHandle);
DllImport int ECF_GetBaud(const INTPTR ecfHandle);
DllImport int ECF_GetChequePronto(const INTPTR ecfHandle);
DllImport int ECF_GetCliche(const INTPTR ecfHandle, PCHAR buffer, const int bufferLen);
DllImport int ECF_GetCNPJ(const INTPTR ecfHandle, PCHAR buffer, const int bufferLen);
DllImport int ECF_GetColunas(const INTPTR ecfHandle);
DllImport int ECF_GetComandoEnviado(const INTPTR ecfHandle, PCHAR buffer, const int bufferLen);
DllImport int ECF_GetComandoLOG(const INTPTR ecfHandle, PCHAR buffer, const int bufferLen);
DllImport int ECF_GetComprovanteNaoFiscal(const INTPTR ecfHandle, ComprovanteNaoFiscalRec* comprovanteNaoFiscal, const int index);
DllImport int ECF_GetDadosReducaoZ(const INTPTR ecfHandle, PCHAR buffer, const int bufferLen);
DllImport int ECF_GetDadosReducaoZClass(const INTPTR ecfHandle, INTPTR* dadosRZ);
DllImport int ECF_GetDadosUltimaReducaoZ(const INTPTR ecfHandle, PCHAR buffer, const int bufferLen);
DllImport int ECF_GetDataBits(const INTPTR ecfHandle);
DllImport int ECF_GetDataHora(const INTPTR ecfHandle, double* value);
DllImport int ECF_GetDataHoraSB(const INTPTR ecfHandle, double* value);
DllImport int ECF_GetDataMovimento(const INTPTR ecfHandle, double* value);
DllImport int ECF_GetDecimaisPreco(const INTPTR ecfHandle);
DllImport int ECF_GetDecimaisQtd(const INTPTR ecfHandle);
DllImport int ECF_GetDescricaoGrande(const INTPTR ecfHandle);
DllImport int ECF_GetEmLinha(const INTPTR ecfHandle, const int timeOut);
DllImport int ECF_GetEstado(const INTPTR ecfHandle);
DllImport int ECF_GetFormaPagamento(const INTPTR ecfHandle, FormaPagamentoRec* formaPagamento, const int index);
DllImport int ECF_GetGavetaAberta(const INTPTR ecfHandle);
DllImport int ECF_GetGavetaSinalInvertido(const INTPTR ecfHandle);
DllImport int ECF_GetGrandeTotal(const INTPTR ecfHandle, double* value);
DllImport int ECF_GetHandShake(const INTPTR ecfHandle);
DllImport int ECF_GetHardFlow(const INTPTR ecfHandle);
DllImport int ECF_GetHorarioVerao(const INTPTR ecfHandle);
DllImport int ECF_GetIdentificaConsumidorRodape(const INTPTR ecfHandle);
DllImport int ECF_GetIE(const INTPTR ecfHandle, PCHAR buffer, const int bufferLen);
DllImport int ECF_GetIM(const INTPTR ecfHandle, PCHAR buffer, const int bufferLen);
DllImport int ECF_GetIntervaloAposComando(const INTPTR ecfHandle);
DllImport int ECF_GetLinhasEntreCupons(const INTPTR ecfHandle);
DllImport int ECF_GetMFD(const INTPTR ecfHandle);
DllImport int ECF_GetModelo(const INTPTR ecfHandle);
DllImport int ECF_GetModeloStr(const INTPTR ecfHandle, PCHAR buffer, const int bufferLen);
DllImport int ECF_GetNumCCF(const INTPTR ecfHandle, PCHAR buffer, const int bufferLen);
DllImport int ECF_GetNumCDC(const INTPTR ecfHandle, PCHAR buffer, const int bufferLen);
DllImport int ECF_GetNumCOO(const INTPTR ecfHandle, PCHAR buffer, const int bufferLen);
DllImport int ECF_GetNumCOOInicial(const INTPTR ecfHandle, PCHAR buffer, const int bufferLen);
DllImport int ECF_GetNumCRO(const INTPTR ecfHandle, PCHAR buffer, const int bufferLen);
DllImport int ECF_GetNumCRZ(const INTPTR ecfHandle, PCHAR buffer, const int bufferLen);
DllImport int ECF_GetNumCupom(const INTPTR ecfHandle, PCHAR buffer, const int bufferLen);
DllImport int ECF_GetNumECF(const INTPTR ecfHandle, PCHAR buffer, const int bufferLen);
DllImport int ECF_GetNumGNF(const INTPTR ecfHandle, PCHAR buffer, const int bufferLen);
DllImport int ECF_GetNumGRG(const INTPTR ecfHandle, PCHAR buffer, const int bufferLen);
DllImport int ECF_GetNumLoja(const INTPTR ecfHandle, PCHAR buffer, const int bufferLen);
DllImport int ECF_GetNumSerie(const INTPTR ecfHandle, PCHAR buffer, const int bufferLen);
DllImport int ECF_GetNumUltItem(const INTPTR ecfHandle);
DllImport int ECF_GetNumVersao(const INTPTR ecfHandle, PCHAR buffer, const int bufferLen);
DllImport int ECF_GetOperador(const INTPTR ecfHandle, PCHAR buffer, const int bufferLen);
DllImport int ECF_GetPAF(const INTPTR ecfHandle, PCHAR buffer, const int bufferLen);
DllImport int ECF_GetParity(const INTPTR ecfHandle);
DllImport int ECF_GetPorta(const INTPTR ecfHandle, PCHAR buffer, const int bufferLen);
DllImport int ECF_GetPoucoPapel(const INTPTR ecfHandle);
DllImport int ECF_GetRelatoriosGerenciais(const INTPTR ecfHandle, RelatorioGerencialRec* relatorio, const int index);
DllImport int ECF_GetRespostaComando(const INTPTR ecfHandle, PCHAR buffer, const int bufferLen);
DllImport int ECF_GetRFDID(const INTPTR ecfHandle, PCHAR buffer, const int bufferLen);
DllImport int ECF_GetSoftFlow(const INTPTR ecfHandle);
DllImport int ECF_GetStopBits(const INTPTR ecfHandle);
DllImport int ECF_GetSubModeloECF(const INTPTR ecfHandle, PCHAR buffer, const int bufferLen);
DllImport int ECF_GetSubTotal(const INTPTR ecfHandle, double* value);
DllImport int ECF_GetTermica(const INTPTR ecfHandle);
DllImport int ECF_GetTimeOut(const INTPTR ecfHandle);
DllImport int ECF_GetTotalAcrescimos(const INTPTR ecfHandle, double* value);
DllImport int ECF_GetTotalAcrescimosISSQN(const INTPTR ecfHandle, double* value);
DllImport int ECF_GetTotalCancelamentos(const INTPTR ecfHandle, double* value);
DllImport int ECF_GetTotalCancelamentosISSQN(const INTPTR ecfHandle, double* value);
DllImport int ECF_GetTotalDescontos(const INTPTR ecfHandle, double* value);
DllImport int ECF_GetTotalDescontosISSQN(const INTPTR ecfHandle, double* value);
DllImport int ECF_GetTotalIsencao(const INTPTR ecfHandle, double* value);
DllImport int ECF_GetTotalIsencaoISSQN(const INTPTR ecfHandle, double* value);
DllImport int ECF_GetTotalNaoFiscal(const INTPTR ecfHandle, double* value);
DllImport int ECF_GetTotalNaoTributado(const INTPTR ecfHandle, double* value);
DllImport int ECF_GetTotalNaoTributadoISSQN(const INTPTR ecfHandle, double* value);
DllImport int ECF_GetTotalPago(const INTPTR ecfHandle, double* value);
DllImport int ECF_GetTotalSubstituicaoTributaria(const INTPTR ecfHandle, double* value);
DllImport int ECF_GetTotalSubstituicaoTributariaISSQN(const INTPTR ecfHandle, double* value);
DllImport int ECF_GetTotalTroco(const INTPTR ecfHandle, double* value);
DllImport int ECF_GetUltimoErro(const INTPTR ecfHandle, PCHAR buffer, const int bufferLen);
DllImport int ECF_GetUsuarioAtual(const INTPTR ecfHandle, PCHAR buffer, const int bufferLen);
DllImport int ECF_GetVendaBruta(const INTPTR ecfHandle, double* value);
DllImport int ECF_IdentificaConsumidor(const INTPTR ecfHandle, const PCHAR cpfCnpj, const PCHAR nome, const PCHAR endereco);
DllImport int ECF_IdentificaPAF(const INTPTR ecfHandle, const PCHAR nomeVersao, const PCHAR md5);
DllImport int ECF_LegendaInmetroProximoItem(const INTPTR ecfHandle);
DllImport int ECF_LeituraMemoriaFiscalArquivoData(const INTPTR ecfHandle, const double dataInicial, const double dataFinal, const PCHAR nomeArquivo, const BOOL simplificada);
DllImport int ECF_LeituraMemoriaFiscalArquivoReducao(const INTPTR ecfHandle, const int reducaoInicial, const int reducaoFinal, const PCHAR nomeArquivo, const BOOL simplificada);
DllImport int ECF_LeituraMemoriaFiscalData(const INTPTR ecfHandle, const double dataInicial, const double dataFinal, const BOOL simplificada);
DllImport int ECF_LeituraMemoriaFiscalReducao(const INTPTR ecfHandle, const int reducaoInicial, const int reducaoFinal, const BOOL simplificada);
DllImport int ECF_LeituraMemoriaFiscalSerialData(const INTPTR ecfHandle, const double dataInicial, const double dataFinal, const BOOL simplificada, PCHAR buffer, const int bufferLen);
DllImport int ECF_LeituraMemoriaFiscalSerialReducao(const INTPTR ecfHandle, const int reducaoInicial, const int reducaoFinal, const BOOL simplificada, PCHAR buffer, const int bufferLen);
DllImport int ECF_LeituraX(const INTPTR ecfHandle);
DllImport int ECF_LerTotaisAliquota(const INTPTR ecfHandle);
DllImport int ECF_LerTotaisComprovanteNaoFiscal(const INTPTR ecfHandle);
DllImport int ECF_LerTotaisFormaPagamento(const INTPTR ecfHandle);
DllImport int ECF_LerTotaisRelatoriosGerenciais(const INTPTR ecfHandle);
DllImport int ECF_LinhaCupomVinculado(const INTPTR ecfHandle, const PCHAR linha);
DllImport int ECF_LinhaRelatorioGerencial(const INTPTR ecfHandle, const PCHAR linha, const int indiceBMP);
DllImport int ECF_PafMF_GerarCAT52(const INTPTR ecfHandle, const double DataInicial, const double DataFinal, const PCHAR CaminhoArquivo);
DllImport int ECF_PafMF_LMFC_Cotepe1704(const INTPTR ecfHandle, const double DataInicial, const double DataFinal, const PCHAR CaminhoArquivo);
DllImport int ECF_PafMF_LMFC_Cotepe1704_CRZ(const INTPTR ecfHandle, const int CRZInicial, const int CRZFinal, const PCHAR CaminhoArquivo);
DllImport int ECF_PafMF_LMFC_Espelho(const INTPTR ecfHandle, const double DataInicial, const double DataFinal, const PCHAR CaminhoArquivo);
DllImport int ECF_PafMF_LMFC_Espelho_CRZ(const INTPTR ecfHandle, const int CRZInicial, const int CRZFinal, const PCHAR CaminhoArquivo);
DllImport int ECF_PafMF_LMFC_Impressao(const INTPTR ecfHandle, const double DataInicial, const double DataFinal);
DllImport int ECF_PafMF_LMFC_Impressao_CRZ(const INTPTR ecfHandle, const int CRZInicial, const int CRZFinal);
DllImport int ECF_PafMF_LMFS_Espelho(const INTPTR ecfHandle, const double DataInicial, const double DataFinal, const PCHAR CaminhoArquivo);
DllImport int ECF_PafMF_LMFS_Espelho_CRZ(const INTPTR ecfHandle, const int CRZInicial, const int CRZFinal, const PCHAR CaminhoArquivo);
DllImport int ECF_PafMF_LMFS_Impressao(const INTPTR ecfHandle, const double DataInicial, const double DataFinal);
DllImport int ECF_PafMF_LMFS_Impressao_CRZ(const INTPTR ecfHandle, const int CRZInicial, const int CRZFinal);
DllImport int ECF_PafMF_LX_Impressao(const INTPTR ecfHandle);
DllImport int ECF_PafMF_MFD_Cotepe1704(const INTPTR ecfHandle, const double DataInicial, const double DataFinal, const PCHAR CaminhoArquivo);
DllImport int ECF_PafMF_MFD_Cotepe1704_COO(const INTPTR ecfHandle, const int COOInicial, const int COOFinal, const PCHAR CaminhoArquivo);
DllImport int ECF_PafMF_MFD_Espelho(const INTPTR ecfHandle, const double DataInicial, const double DataFinal, const PCHAR CaminhoArquivo);
DllImport int ECF_PafMF_MFD_Espelho_COO(const INTPTR ecfHandle, const int COOInicial, const int COOFinal, const PCHAR CaminhoArquivo);
DllImport int ECF_PafMF_RelDAVEmitidos(const INTPTR ecfHandle, const DAVsRec DAVs[], const int index, const PCHAR TituloRelatorio, const PCHAR IndiceRelatorio);
DllImport int ECF_PafMF_RelIdentificacaoPafECF(const INTPTR ecfHandle, const INTPTR aacHandle, const int IndiceRelatorio);
DllImport int ECF_PafMF_RelMeiosPagamento(const INTPTR ecfHandle, const FormaPagamentoRec formasPagamento[], const int count, const PCHAR TituloRelatorio, const int IndiceRelatorio);
DllImport int ECF_ProgramaAliquota(const INTPTR ecfHandle, const double aliquota, const char tipo, const PCHAR posicao);
DllImport int ECF_ProgramaComprovanteNaoFiscal(const INTPTR ecfHandle, const PCHAR descricao, const PCHAR tipo, const PCHAR posicao);
DllImport int ECF_ProgramaFormaPagamento(const INTPTR ecfHandle, const PCHAR descricao, const BOOL permiteVinculado, const PCHAR posicao);
DllImport int ECF_ProgramaRelatoriosGerenciais(const INTPTR ecfHandle, const PCHAR descricao, const PCHAR posicao);
DllImport int ECF_PulaLinhas(const INTPTR ecfHandle, const int numLinhas);
DllImport int ECF_ReducaoZ(const INTPTR ecfHandle);
DllImport int ECF_RegistraItemNaoFiscal(const INTPTR ecfHandle, const PCHAR codCNF, const double value, const PCHAR obs);
DllImport int ECF_RelatorioGerencial(const INTPTR ecfHandle, const RelatorioGerencial Relatorio, const int Via, const int Indice);
DllImport int ECF_Sangria(const INTPTR ecfHandle, const double valor, const PCHAR obs);
DllImport int ECF_SetAAC(const INTPTR ecfHandle, const INTPTR aacHandle);
DllImport int ECF_SetAguardaImpressao(const INTPTR ecfHandle, const BOOL aguardaImpressao);
DllImport int ECF_SetBaud(const INTPTR ecfHandle, const int baud);
DllImport int ECF_SetComandoLOG(const INTPTR ecfHandle, const PCHAR comandoLog);
DllImport int ECF_SetDataBits(const INTPTR ecfHandle, const int dataBits);
DllImport int ECF_SetDecimaisPreco(const INTPTR ecfHandle, const int decimaisPreco);
DllImport int ECF_SetDecimaisQtd(const INTPTR ecfHandle, const int decimaisQtd);
DllImport int ECF_SetDescricaoGrande(const INTPTR ecfHandle, const BOOL descricaoGrande);
DllImport int ECF_SetEAD(const INTPTR ecfHandle, const INTPTR eadHandle);
DllImport int ECF_SetGavetaSinalInvertido(const INTPTR ecfHandle, const BOOL gavetaSinalInvertido);
DllImport int ECF_SetHandShake(const INTPTR ecfHandle, const int handShake);
DllImport int ECF_SetHardFlow(const INTPTR ecfHandle, const BOOL hardFlow);
DllImport int ECF_SetIntervaloAposComando(const INTPTR ecfHandle, const int intervalo);
DllImport int ECF_SetLinhasEntreCupons(const INTPTR ecfHandle, const int linhasEntreCupons);
DllImport int ECF_SetModelo(const INTPTR ecfHandle, const int modelo);
DllImport int ECF_SetOperador(const INTPTR ecfHandle, const PCHAR operador);
DllImport int ECF_SetParity(const INTPTR ecfHandle, const int parity);
DllImport int ECF_SetPorta(const INTPTR ecfHandle, const PCHAR porta);
DllImport int ECF_SetSoftFlow(const INTPTR ecfHandle, const BOOL softFlow);
DllImport int ECF_SetStopBits(const INTPTR ecfHandle, const int stopBits);
DllImport int ECF_SetTimeOut(const INTPTR ecfHandle, const int timeOut);
DllImport int ECF_SubtotalizaCupom(const INTPTR ecfHandle, const double descontoAcrescimo, const PCHAR mensagemRodape);
DllImport int ECF_SubtotalizaNaoFiscal(const INTPTR ecfHandle, const double descontoAcrescimo, const PCHAR mensagemRodape);
DllImport int ECF_Suprimento(const INTPTR ecfHandle, const double valor, const PCHAR obs);
DllImport int ECF_VendeItem(const INTPTR ecfHandle, const PCHAR codigo, const PCHAR descricao, const PCHAR aliquotaICMS, const double qtd, const double valorUnitario, const double descontoPorc, const PCHAR unidade, const PCHAR tipoDescontoAcrescimo, const PCHAR descontoAcrescimo);


#endif
