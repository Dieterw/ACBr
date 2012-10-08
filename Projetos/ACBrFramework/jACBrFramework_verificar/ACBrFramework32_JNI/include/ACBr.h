#ifndef _ACBR_API_H_
#define _ACBR_API_H_

#ifdef __cplusplus
#define DllImport extern "C"
#else
#define DllImport extern
#endif

typedef void* ACBR_HANDLE;
typedef char* PCHAR;
typedef char BOOL;

typedef struct
{
      char Indice[4];
      double Aliquota;
      char Tipo;
      double Total;
      char Sequencia;
} AliquotaRec;


typedef struct
{
      char Indice[4];
      char Descricao[30];
      BOOL PermiteVinculado;
      double Total;
} FormaPagamentoRec;

typedef struct
{
    char Indice[4];
    char Descricao[30];
    BOOL PermiteVinculado;
    char FormaPagamento[4];
    double Total;
    int Contador;
} ComprovanteNaoFiscalRec;

#define ECF_Modelo_Nenhum 0
#define ECF_Modelo_NaoFiscal 1
#define ECF_Modelo_Bematech 2
#define ECF_Modelo_Sweda 3
#define ECF_Modelo_Daruma 4
#define ECF_Modelo_Schalter 5
#define ECF_Modelo_Mecaf 6
#define ECF_Modelo_Yanco 7
#define ECF_Modelo_DataRegis 8
#define ECF_Modelo_Urano 9
#define ECF_Modelo_ICash 10
#define ECF_Modelo_Quattro 11
#define ECF_Modelo_FiscNET 12
#define ECF_Modelo_Epson 13
#define ECF_Modelo_NCR 14
#define ECF_Modelo_SwedaSTX 15

#define ECF_ESTADO_NaoInicializada 0
#define ECF_ESTADO_Desconhecido 1
#define ECF_ESTADO_Livre 2
#define ECF_ESTADO_Venda 3
#define ECF_ESTADO_Pagamento 4
#define ECF_ESTADO_Relatorio 5
#define ECF_ESTADO_Bloqueada 6
#define ECF_ESTADO_RequerZ 7
#define ECF_ESTADO_RequerX 8
#define ECF_ESTADO_NaoFiscal 9

#define BAL_MODELO_Nenhum 0
#define BAL_MODELO_Filizola 1
#define BAL_MODELO_Toledo 2
#define BAL_MODELO_Urano 3

/*ECF*/

DllImport int ECF_Create(const ACBR_HANDLE* ecfHandle);
DllImport int ECF_Destroy(const ACBR_HANDLE* ecfHandle);
DllImport int ECF_GetUltimoErro(const ACBR_HANDLE ecfHandle, PCHAR buffer, const int bufferLen);
DllImport int ECF_Ativar(const ACBR_HANDLE ecfHandle);
DllImport int ECF_Desativar(const ACBR_HANDLE ecfHandle);
DllImport int ECF_GetModelo(const ACBR_HANDLE ecfHandle);
DllImport int ECF_SetModelo(const ACBR_HANDLE ecfHandle, const int modelo);
DllImport int ECF_GetPorta(const ACBR_HANDLE ecfHandle, PCHAR buffer, const int bufferLen);
DllImport int ECF_SetPorta(const ACBR_HANDLE ecfHandle, const PCHAR porta);
DllImport int ECF_GetTimeOut(const ACBR_HANDLE ecfHandle);
DllImport int ECF_SetTimeOut(const ACBR_HANDLE ecfHandle, const int timeOut);
DllImport int ECF_GetAtivo(const ACBR_HANDLE ecfHandle);
DllImport int ECF_GetColunas(const ACBR_HANDLE ecfHandle);
DllImport int ECF_GetAguardandoResposta(const ACBR_HANDLE ecfHandle);
DllImport int ECF_GetComandoEnviado(const ACBR_HANDLE ecfHandle, PCHAR buffer, const int bufferLen);
DllImport int ECF_GetRespostaComando(const ACBR_HANDLE ecfHandle, PCHAR buffer, const int bufferLen);
DllImport int ECF_GetComandoLOG(const ACBR_HANDLE ecfHandle, PCHAR buffer, const int bufferLen);
DllImport int ECF_SetComandoLOG(const ACBR_HANDLE ecfHandle, const PCHAR comandoLog);
DllImport int ECF_GetAguardaImpressao(const ACBR_HANDLE ecfHandle);
DllImport int ECF_SetAguardaImpressao(const ACBR_HANDLE ecfHandle, BOOL aguardaImpressao);
DllImport int ECF_GetModeloStr(const ACBR_HANDLE ecfHandle, PCHAR buffer, const int bufferLen);
DllImport int ECF_GetRFDID(const ACBR_HANDLE ecfHandle, PCHAR buffer, const int bufferLen);
DllImport int ECF_GetDataHora(const ACBR_HANDLE ecfHandle, double* value);
DllImport int ECF_GetNumCupom(const ACBR_HANDLE ecfHandle, PCHAR buffer, const int bufferLen);
DllImport int ECF_GetNumCOO(const ACBR_HANDLE ecfHandle, PCHAR buffer, const int bufferLen);
DllImport int ECF_GetNumLoja(const ACBR_HANDLE ecfHandle, PCHAR buffer, const int bufferLen);
DllImport int ECF_GetNumECF(const ACBR_HANDLE ecfHandle, PCHAR buffer, const int bufferLen);
DllImport int ECF_GetNumSerie(const ACBR_HANDLE ecfHandle, PCHAR buffer, const int bufferLen);
DllImport int ECF_GetNumVersao(const ACBR_HANDLE ecfHandle, PCHAR buffer, const int bufferLen);
DllImport int ECF_GetDataMovimento(const ACBR_HANDLE ecfHandle, double* value);
DllImport int ECF_GetDataHoraSB(const ACBR_HANDLE ecfHandle, double* value);
DllImport int ECF_GetCNPJ(const ACBR_HANDLE ecfHandle, PCHAR buffer, const int bufferLen);
DllImport int ECF_GetIE(const ACBR_HANDLE ecfHandle, PCHAR buffer, const int bufferLen);
DllImport int ECF_GetIM(const ACBR_HANDLE ecfHandle, PCHAR buffer, const int bufferLen);
DllImport int ECF_GetCliche(const ACBR_HANDLE ecfHandle, PCHAR buffer, const int bufferLen);
DllImport int ECF_GetUsuarioAtual(const ACBR_HANDLE ecfHandle, PCHAR buffer, const int bufferLen);
DllImport int ECF_GetSubModeloECF(const ACBR_HANDLE ecfHandle, PCHAR buffer, const int bufferLen);
DllImport int ECF_GetPAF(const ACBR_HANDLE ecfHandle, PCHAR buffer, const int bufferLen);
DllImport int ECF_GetNumCRZ(const ACBR_HANDLE ecfHandle, PCHAR buffer, const int bufferLen);
DllImport int ECF_GetNumCRO(const ACBR_HANDLE ecfHandle, PCHAR buffer, const int bufferLen);
DllImport int ECF_GetNumCCF(const ACBR_HANDLE ecfHandle, PCHAR buffer, const int bufferLen);
DllImport int ECF_GetNumGNF(const ACBR_HANDLE ecfHandle, PCHAR buffer, const int bufferLen);
DllImport int ECF_GetNumGRG(const ACBR_HANDLE ecfHandle, PCHAR buffer, const int bufferLen);
DllImport int ECF_GetNumCDC(const ACBR_HANDLE ecfHandle, PCHAR buffer, const int bufferLen);
DllImport int ECF_GetNumCOOInicial(const ACBR_HANDLE ecfHandle, PCHAR buffer, const int bufferLen);
DllImport int ECF_GetVendaBruta(const ACBR_HANDLE ecfHandle, double* value);
DllImport int ECF_GetGrandeTotal(const ACBR_HANDLE ecfHandle, double* value);
DllImport int ECF_GetTotalCancelamentos(const ACBR_HANDLE ecfHandle, double* value);
DllImport int ECF_GetTotalDescontos(const ACBR_HANDLE ecfHandle, double* value);
DllImport int ECF_GetTotalAcrescimos(const ACBR_HANDLE ecfHandle, double* value);
DllImport int ECF_GetTotalTroco(const ACBR_HANDLE ecfHandle, double* value);
DllImport int ECF_GetTotalSubstituicaoTributaria(const ACBR_HANDLE ecfHandle, double* value);
DllImport int ECF_GetTotalNaoTributado(const ACBR_HANDLE ecfHandle, double* value);
DllImport int ECF_GetTotalIsencao(const ACBR_HANDLE ecfHandle, double* value);
DllImport int ECF_GetTotalCancelamentosISSQN(const ACBR_HANDLE ecfHandle, double* value);
DllImport int ECF_GetTotalDescontosISSQN(const ACBR_HANDLE ecfHandle, double* value);
DllImport int ECF_GetTotalAcrescimosISSQN(const ACBR_HANDLE ecfHandle, double* value);
DllImport int ECF_GetTotalSubstituicaoTributariaISSQN(const ACBR_HANDLE ecfHandle, double* value);
DllImport int ECF_GetTotalNaoTributadoISSQN(const ACBR_HANDLE ecfHandle, double* value);
DllImport int ECF_GetTotalIsencaoISSQN(const ACBR_HANDLE ecfHandle, double* value);
DllImport int ECF_GetTotalNaoFiscal(const ACBR_HANDLE ecfHandle, double* value);
DllImport int ECF_GetNumUltItem(const ACBR_HANDLE ecfHandle);
DllImport int ECF_GetEmLinha(const ACBR_HANDLE ecfHandle, const int timeOut);
DllImport int ECF_GetPoucoPapel(const ACBR_HANDLE ecfHandle);
DllImport int ECF_GetEstado(const ACBR_HANDLE ecfHandle);
DllImport int ECF_GetHorarioVerao(const ACBR_HANDLE ecfHandle);
DllImport int ECF_GetArredonda(const ACBR_HANDLE ecfHandle);
DllImport int ECF_GetTermica(const ACBR_HANDLE ecfHandle);
DllImport int ECF_GetMFD(const ACBR_HANDLE ecfHandle);
DllImport int ECF_GetIdentificaConsumidorRodape(const ACBR_HANDLE ecfHandle);
DllImport int ECF_GetSubTotal(const ACBR_HANDLE ecfHandle, double* value);
DllImport int ECF_GetTotalPago(const ACBR_HANDLE ecfHandle, double* value);
DllImport int ECF_GetGavetaAberta(const ACBR_HANDLE ecfHandle);
DllImport int ECF_GetChequePronto(const ACBR_HANDLE ecfHandle);
DllImport int ECF_GetIntervaloAposComando(const ACBR_HANDLE ecfHandle);
DllImport int ECF_SetIntervaloAposComando(const ACBR_HANDLE ecfHandle, const int intervalo);
DllImport int ECF_GetDescricaoGrande(const ACBR_HANDLE ecfHandle);
DllImport int ECF_SetDescricaoGrande(const ACBR_HANDLE ecfHandle, BOOL descricaoGrande);
DllImport int ECF_GetGavetaSinalInvertido(const ACBR_HANDLE ecfHandle);
DllImport int ECF_SetGavetaSinalInvertido(const ACBR_HANDLE ecfHandle, BOOL gavetaSinalInvertido);
DllImport int ECF_GetOperador(const ACBR_HANDLE ecfHandle, PCHAR buffer, const int bufferLen);
DllImport int ECF_SetOperador(const ACBR_HANDLE ecfHandle, const PCHAR operador);
DllImport int ECF_GetLinhasEntreCupons(const ACBR_HANDLE ecfHandle);
DllImport int ECF_SetLinhasEntreCupons(const ACBR_HANDLE ecfHandle, const int linhasEntreCupons);
DllImport int ECF_GetDecimaisPreco(const ACBR_HANDLE ecfHandle);
DllImport int ECF_SetDecimaisPreco(const ACBR_HANDLE ecfHandle, const int decimaisPreco);
DllImport int ECF_GetDecimaisQtd(const ACBR_HANDLE ecfHandle);
DllImport int ECF_SetDecimaisQtd(const ACBR_HANDLE ecfHandle, const int decimaisQtd);
DllImport int ECF_IdentificaConsumidor(const ACBR_HANDLE ecfHandle, const PCHAR cpfCnpj, const PCHAR nome, const PCHAR endereco);
DllImport int ECF_AbreCupom(const ACBR_HANDLE ecfHandle, const PCHAR cpfCnpj, const PCHAR nome, const PCHAR endereco);
DllImport int ECF_LegendaInmetroProximoItem(const ACBR_HANDLE ecfHandle);
DllImport int ECF_VendeItem(const ACBR_HANDLE ecfHandle, const PCHAR codigo, const PCHAR descricao, const PCHAR aliquotaICMS, const double qtd, const double valorUnitario, const double descontoPorc, const PCHAR unidade, const PCHAR tipoDescontoAcrescimo, const PCHAR descontoAcrescimo);
DllImport int ECF_DescontoAcrescimoItemAnterior(const ACBR_HANDLE ecfHandle, const double valorDescontoAcrescimo, const PCHAR descontoAcrescimo);
DllImport int ECF_SubtotalizaCupom(const ACBR_HANDLE ecfHandle, const double descontoAcrescimo, const PCHAR mensagemRodape);
DllImport int ECF_EfetuaPagamento(const ACBR_HANDLE ecfHandle, const PCHAR codFormaPagto, const double valor, const PCHAR observacao, BOOL imprimeVinculado);
DllImport int ECF_EstornaPagamento(const ACBR_HANDLE ecfHandle, const PCHAR codFormaPagtoEstornar, const PCHAR codFormaPagtoEfetivar, const double valor, const PCHAR observacao);
DllImport int ECF_FechaCupom(const ACBR_HANDLE ecfHandle, const PCHAR observacao);
DllImport int ECF_CancelaCupom(const ACBR_HANDLE ecfHandle);
DllImport int ECF_CancelaItemVendido(const ACBR_HANDLE ecfHandle, const int numItem);
DllImport int ECF_CancelaItemVendidoParcial(const ACBR_HANDLE ecfHandle, const int numItem, const double quantidade);
DllImport int ECF_CancelaDescontoAcrescimoItem(const ACBR_HANDLE ecfHandle, const int numItem);
DllImport int ECF_CancelaDescontoAcrescimoSubTotal(const ACBR_HANDLE ecfHandle, char tipoAcrescimoDesconto);
DllImport int ECF_LeituraX(const ACBR_HANDLE ecfHandle);
DllImport int ECF_ReducaoZ(const ACBR_HANDLE ecfHandle);
DllImport int ECF_AbreRelatorioGerencial(const ACBR_HANDLE ecfHandle, const int indice);
DllImport int ECF_LinhaRelatorioGerencial(const ACBR_HANDLE ecfHandle, const PCHAR linha, const int indiceBMP);
DllImport int ECF_AbreCupomVinculado(const ACBR_HANDLE ecfHandle, const PCHAR coo, const PCHAR codFormaPagto, const double valor);
DllImport int ECF_AbreCupomVinculadoCNF(const ACBR_HANDLE ecfHandle, const PCHAR coo, const PCHAR codFormaPagto, const PCHAR codComprovanteNaoFiscal, const double valor);
DllImport int ECF_LinhaCupomVinculado(const ACBR_HANDLE ecfHandle, const PCHAR linha);
DllImport int ECF_FechaRelatorio(const ACBR_HANDLE ecfHandle);
DllImport int ECF_PulaLinhas(const ACBR_HANDLE ecfHandle, const int numLinhas);
DllImport int ECF_CortaPapel(const ACBR_HANDLE ecfHandle, BOOL corteParcial);
DllImport int ECF_GetAliquota(const ACBR_HANDLE ecfHandle, AliquotaRec* aliquota, const int index);
DllImport int ECF_CarregaAliquotas(const ACBR_HANDLE ecfHandle);
DllImport int ECF_LerTotaisAliquota(const ACBR_HANDLE ecfHandle);
DllImport int ECF_ProgramaAliquota(const ACBR_HANDLE ecfHandle, const double aliquota, char tipo, const PCHAR posicao);
DllImport int ECF_GetFormaPagamento(const ACBR_HANDLE ecfHandle, FormaPagamentoRec* formaPagamento, const int index);
DllImport int ECF_CarregaFormasPagamento(const ACBR_HANDLE ecfHandle);
DllImport int ECF_LerTotaisFormaPagamento(const ACBR_HANDLE ecfHandle);
DllImport int ECF_ProgramaFormaPagamento(const ACBR_HANDLE ecfHandle, const PCHAR descricao, BOOL permiteVinculado, const PCHAR posicao);
DllImport int ECF_GetComprovanteNaoFiscal(const ACBR_HANDLE ecfHandle, ComprovanteNaoFiscalRec* comprovanteNaoFiscal, const int index);
DllImport int ECF_CarregaComprovantesNaoFiscais(const ACBR_HANDLE ecfHandle);
DllImport int ECF_LerTotaisComprovanteNaoFiscal(const ACBR_HANDLE ecfHandle);
DllImport int ECF_ProgramaComprovanteNaoFiscal(const ACBR_HANDLE ecfHandle, const PCHAR descricao, const PCHAR tipo, const PCHAR posicao);
DllImport int ECF_Sangria(const ACBR_HANDLE ecfHandle, const double valor, const PCHAR obs);
DllImport int ECF_Suprimento(const ACBR_HANDLE ecfHandle, const double valor, const PCHAR obs);
DllImport int ECF_AbreGaveta(const ACBR_HANDLE ecfHandle);

/*BALANÇA*/

DllImport int BAL_Create(const ACBR_HANDLE* balHandle);
DllImport int BAL_Destroy(const ACBR_HANDLE* balHandle);

DllImport int BAL_GetUltimoErro(const ACBR_HANDLE balHandle, PCHAR buffer, const int bufferLen);
DllImport int BAL_Ativar(const ACBR_HANDLE balHandle);
DllImport int BAL_Desativar(const ACBR_HANDLE balHandle);
DllImport int BAL_GetModelo(const ACBR_HANDLE balHandle);
DllImport int BAL_SetModelo(const ACBR_HANDLE balHandle, const int modelo);
DllImport int BAL_GetModeloStr(const ACBR_HANDLE balHandle, PCHAR buffer, const int bufferLen);
DllImport int BAL_GetPorta(const ACBR_HANDLE balHandle, PCHAR buffer, const int bufferLen);
DllImport int BAL_SetPorta(const ACBR_HANDLE balHandle, const PCHAR porta);
DllImport int BAL_GetAtivo(const ACBR_HANDLE balHandle);
DllImport int BAL_GetUltimoPesoLido(const ACBR_HANDLE balHandle, double* value);
DllImport int BAL_GetUltimaResposta(const ACBR_HANDLE balHandle, PCHAR buffer, const int bufferLen);
DllImport int BAL_LePeso(const ACBR_HANDLE balHandle, const int timeout, double* value);

#endif