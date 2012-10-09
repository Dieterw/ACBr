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


#ifndef _ACBrSintegra_H_
#define _ACBrSintegra_H_

#ifdef __cplusplus
#define DllImport extern "C"
#else
#define DllImport extern
#endif


// Tipos de dados

typedef struct
{
	char CNPJ[15];
	char Inscricao[15];
	char RazaoSocial[36];
	char Cidade[31];
	char Estado[3];
	char Telefone[11];
	double DataInicial;
	double DataFinal;
	int CodigoConvenio;
	int NaturezaInformacoes;
	int FinalidadeArquivo;
} Registro10Rec;

typedef struct
{
	char Responsavel[29];
	char Bairro[14];
	char Cep[9];
	char Numero[6];
	char Complemento[23];
	char Endereco[35];
	char Telefone[13];
} Registro11Rec;

typedef struct
{
	char CPFCNPJ[15];
	char Inscricao[15];
	char UF[3];
	char Situacao[2];
	double Aliquota;
	double Isentas;
	double Icms;
	double ValorContabil;
	double BasedeCalculo;
	double Outras;
	char EmissorDocumento[2];
	char Cfop[5];
	char Serie[4];
	char Modelo[3];
	char Numero[7];
	double DataDocumento;
} Registro50Rec;

typedef struct
{
	char CPFCNPJ[15];
	char Inscricao[15];
	char Estado[3];
	double ValorIpi;
	double ValorContabil;
	char Serie[4];
	double DataDocumento;
	char Cfop[5];
	char Numero[7];
	char Situacao[2];
	double ValorIsentas;
	double ValorOutras;
} Registro51Rec;


// Funções

DllImport int SIN_Create(INTPTR* sinHandle);
DllImport int SIN_Destroy(INTPTR* sinHandle);
DllImport int SIN_GetAtivo(const INTPTR sinHandle);
DllImport int SIN_GetFileName(const INTPTR sinHandle, PCHAR buffer, const int bufferLen);
DllImport int SIN_GetUltimoErro(const INTPTR sinHandle, PCHAR buffer, const int bufferLen);
DllImport int SIN_GetVersaoValidador(const INTPTR sinHandle);
DllImport int SIN_LimparRegistros(const INTPTR sinHandle);
DllImport int SIN_Registro10(const INTPTR sinHandle, const Registro10Rec registro10);
DllImport int SIN_Registro11(const INTPTR sinHandle, const Registro11Rec registro11);
DllImport int SIN_Registro50(const INTPTR sinHandle, const Registro50Rec registro50[], const int count);
DllImport int SIN_Registro51(const INTPTR sinHandle, const Registro51Rec registro51[], const int count);
DllImport int SIN_SetFileName(const INTPTR sinHandle, const PCHAR filename);
DllImport int SIN_SetVersaoValidador(const INTPTR sinHandle, const int Versao);


#endif
