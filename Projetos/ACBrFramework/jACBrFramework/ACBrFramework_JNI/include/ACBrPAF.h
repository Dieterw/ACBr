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


#ifndef _ACBrPAF_H_
#define _ACBrPAF_H_

#ifdef __cplusplus
#define DllImport extern "C"
#else
#define DllImport extern
#endif


// Tipos de dados

typedef struct
{
	char BOMBA[4];
	char BICO[4];
	double DATA;
	double HORA;
	char MOTIVO[51];
	char CNPJ_EMPRESA[15];
	char CPF_TECNICO[12];
	char NRO_LACRE_ANTES[16];
	char NRO_LACRE_APOS[16];
	double ENCERRANTE_ANTES;
	double ENCERRANTE_APOS;
	BOOL RegistroValido;
} RegistroB2Rec;

typedef struct
{
	char ID_ABASTECIMENTO[16];
	char TANQUE[4];
	char BOMBA[4];
	char BICO[4];
	char COMBUSTIVEL[21];
	double DATA_ABASTECIMENTO;
	double HORA_ABASTECIMENTO;
	double ENCERRANTE_INICIAL;
	double ENCERRANTE_FINAL;
	char STATUS_ABASTECIMENTO[11];
	char NRO_SERIE_ECF[15];
	double DATA;
	double HORA;
	int COO;
	int NRO_NOTA_FISCAL;
	double VOLUME;
	BOOL RegistroValido;
} RegistroC2Rec;

typedef struct
{
	int QTD_D3;
	char NUM_FAB[21];
	char MF_ADICIONAL[2];
	char TIPO_ECF[8];
	char MARCA_ECF[21];
	char MODELO_ECF[21];
	char COO[7];
	char NUM_DAV[14];
	double DT_DAV;
	char TIT_DAV[31];
	double VLT_DAV;
	char COO_DFV[7];
	char NUMERO_ECF[4];
	char NOME_CLIENTE[41];
	char CPF_CNPJ[15];
	BOOL RegistroValido;
} RegistroD2Rec;

typedef struct
{
	double DT_INCLUSAO;
	int NUM_ITEM;
	char COD_ITEM[15];
	char DESC_ITEM[101];
	double QTDE_ITEM;
	char UNI_ITEM[4];
	double VL_UNIT;
	double VL_DESCTO;
	double VL_ACRES;
	double VL_TOTAL;
	int DEC_VL_UNIT;
	int DEC_QTDE_ITEM;
	char SIT_TRIB[2];
	double ALIQ;
	char IND_CANC[2];
	BOOL RegistroValido;
} RegistroD3Rec;

typedef struct
{
	char COD_MERC[15];
	char DESC_MERC[51];
	char UN_MED[7];
	double QTDE_EST;
	BOOL RegistroValido;
} RegistroE2Rec;

typedef struct
{
	char CNPJ_CRED_CARTAO[15];
	int COO;
	int CCF;
	double VLR_TROCO;
	double DT_TROCO;
	char CPF[15];
	char Titulo[8];
	BOOL RegistroValido;
} RegistroH2Rec;

typedef struct
{
	char RAZAOSOCIAL[51];
	char UF[3];
	char CNPJ[15];
	char IE[15];
	char IM[15];
} RegistroHD1Rec;

typedef struct
{
	char RAZAOSOCIAL[51];
	char UF[3];
	char CNPJ[15];
	char IE[15];
	char IM[15];
	char NUM_FAB[21];
	char MF_ADICIONAL[2];
	char TIPO_ECF[8];
	char MARCA_ECF[21];
	char MODELO_ECF[21];
	double DT_EST;
	BOOL RegistroValido;
	BOOL InclusaoExclusao;
} RegistroHD2Rec;

typedef struct
{
	int QTD_N3;
	char LAUDO[11];
	char NOME[51];
	char VERSAO[11];
} RegistroN2Rec;

typedef struct
{
	char NOME_ARQUIVO[51];
	char MD5[33];
} RegistroN3Rec;

typedef struct
{
	char COD_MERC_SERV[15];
	char DESC_MERC_SERV[51];
	char UN_MED[7];
	char IAT[2];
	char IPPT[2];
	char ST[2];
	double ALIQ;
	double VL_UNIT;
	BOOL RegistroValido;
} RegistroP2Rec;

typedef struct
{
	char NUM_FAB[21];
	char MF_ADICIONAL[2];
	char TIPO_ECF[8];
	char MARCA_ECF[16];
	char MODELO_ECF[21];
	char VERSAO_SB[11];
	double DT_INST_SB;
	double HR_INST_SB;
	int NUM_SEQ_ECF;
	char CNPJ[15];
	char IE[15];
	char CNPJ_SH[15];
	char IE_SH[15];
	char IM_SH[15];
	char NOME_SH[41];
	char NOME_PAF[41];
	char VER_PAF[11];
	char COD_MD5[33];
	double DT_INI;
	double DT_FIN;
	char ER_PAF_ECF[5];
	BOOL InclusaoExclusao;
	BOOL RegistroValido;
} RegistroR1Rec;

typedef struct
{
	int QTD_R3;
	int NUM_USU;
	int CRZ;
	int COO;
	int CRO;
	double DT_MOV;
	double DT_EMI;
	double HR_EMI;
	double VL_VBD;
	char PAR_ECF[2];
	double DT_FIN;
	BOOL RegistroValido;
} RegistroR2Rec;

typedef struct
{
	char TOT_PARCIAL[8];
	double VL_ACUM;
	BOOL RegistroValido;
} RegistroR3Rec;

typedef struct
{
	int QTD_R5;
	int QTD_R7;
	int NUM_USU;
	int NUM_CONT;
	int COO;
	double DT_INI;
	double SUB_DOCTO;
	double SUB_DESCTO;
	char TP_DESCTO[2];
	double SUB_ACRES;
	char TP_ACRES[2];
	double VL_TOT;
	char CANC[2];
	double VL_CA;
	char ORDEM_DA[2];
	char NOME_CLI[41];
	char CNPJ_CPF[15];
	BOOL RegistroValido;
} RegistroR4Rec;

typedef struct
{
	int NUM_ITEM;
	char COD_ITEM[15];
	char DESC_ITEM[101];
	double QTDE_ITEM;
	char UN_MED[4];
	double VL_UNIT;
	double DESCTO_ITEM;
	double ACRES_ITEM;
	double VL_TOT_ITEM;
	char COD_TOT_PARC[8];
	char IND_CANC[2];
	double QTDE_CANC;
	double VL_CANC;
	double VL_CANC_ACRES;
	char IAT[2];
	char IPPT[2];
	int QTDE_DECIMAL;
	int VL_DECIMAL;
	BOOL RegistroValido;
} RegistroR5Rec;

typedef struct
{
	int QTD_R7;
	int NUM_USU;
	int COO;
	int GNF;
	int GRG;
	int CDC;
	char DENOM[3];
	double DT_FIN;
	double HR_FIN;
	BOOL RegistroValido;
} RegistroR6Rec;

typedef struct
{
	int CCF;
	int GNF;
	char MP[16];
	double VL_PAGTO;
	char IND_EST[2];
	double VL_EST;
	BOOL RegistroValido;
} RegistroR7Rec;


// Funções

DllImport int PAF_AssinarArquivoComEAD(const INTPTR eadHandle, const PCHAR Arquivo);
DllImport int PAF_Create(INTPTR* pafHandle);
DllImport int PAF_Destroy(INTPTR* pafHandle);
DllImport int PAF_GetAssinarArquivo(const INTPTR pafHandle);
DllImport int PAF_GetChaveRSA(const INTPTR aacHandle, PCHAR buffer, const int bufferLen);
DllImport int PAF_GetCurMascara(const INTPTR pafHandle, PCHAR buffer, const int bufferLen);
DllImport int PAF_GetDelimitador(const INTPTR pafHandle, PCHAR buffer, const int bufferLen);
DllImport int PAF_GetPath(const INTPTR pafHandle, PCHAR buffer, const int bufferLen);
DllImport int PAF_GetTrimString(const INTPTR pafHandle);
DllImport int PAF_GetUltimoErro(const INTPTR pafHandle, PCHAR buffer, const int bufferLen);
DllImport int PAF_SaveFileTXT_B(const INTPTR pafHandle, const RegistroHD1Rec RegistroB1, const RegistroB2Rec RegistroB2[], const int CountB2, const PCHAR Arquivo);
DllImport int PAF_SaveFileTXT_C(const INTPTR pafHandle, const RegistroHD1Rec RegistroC1, const RegistroC2Rec RegistroC2[], const int CountC2, const PCHAR Arquivo);
DllImport int PAF_SaveFileTXT_D(const INTPTR pafHandle, const RegistroHD1Rec RegsitroD1Rec, const RegistroD2Rec RegsitroD2Rec[], const int CountD2, const RegistroD3Rec RegsitroD3Rec[], const PCHAR Arquivo);
DllImport int PAF_SaveFileTXT_E(const INTPTR pafHandle, const RegistroHD2Rec RegsitroE1Rec, const RegistroE2Rec RegsitroE2Rec[], const int CountE2, const PCHAR Arquivo);
DllImport int PAF_SaveFileTXT_H(const INTPTR pafHandle, const RegistroHD2Rec RegsitroH1Rec, const RegistroH2Rec RegsitroH2Rec[], const int CountH2, const PCHAR Arquivo);
DllImport int PAF_SaveFileTXT_N(const INTPTR pafHandle, const RegistroHD1Rec RegsitroN1Rec, const RegistroN2Rec RegsitroN2Rec, const RegistroN3Rec RegsitroN3Rec[], const PCHAR Arquivo);
DllImport int PAF_SaveFileTXT_P(const INTPTR pafHandle, const RegistroHD1Rec RegsitroP1Rec, const RegistroP2Rec RegsitroP2Rec[], const int CountP2, const PCHAR Arquivo);
DllImport int PAF_SaveFileTXT_R(const INTPTR pafHandle, const RegistroR1Rec RegsitroR1Rec, const RegistroR2Rec RegsitroR2Rec[], const int CountR2, const RegistroR3Rec RegsitroR3Rec[], const RegistroR4Rec RegsitroR4Rec[], const int CountR4, const RegistroR5Rec RegsitroP5Rec[], const RegistroR6Rec RegsitroR6Rec[], const int CountR6, const RegistroR7Rec RegsitroR7Rec[], const PCHAR Arquivo);
DllImport int PAF_SetAAC(const INTPTR pafHandle, const INTPTR aacHandle);
DllImport int PAF_SetAssinarArquivo(const INTPTR pafHandle, const BOOL Assinar);
DllImport int PAF_SetChaveRSA(const INTPTR aacHandle, const PCHAR chave);
DllImport int PAF_SetCurMascara(const INTPTR pafHandle, const PCHAR CurMascara);
DllImport int PAF_SetDelimitador(const INTPTR pafHandle, const PCHAR Delimitador);
DllImport int PAF_SetEAD(const INTPTR pafHandle, const INTPTR eadHandle);
DllImport int PAF_SetPath(const INTPTR pafHandle, const PCHAR porta);
DllImport int PAF_SetTrimString(const INTPTR pafHandle, const BOOL TrimString);


#endif
