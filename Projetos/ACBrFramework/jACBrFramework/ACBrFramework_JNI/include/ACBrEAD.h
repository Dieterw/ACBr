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


#ifndef _ACBrEAD_H_
#define _ACBrEAD_H_

#ifdef __cplusplus
#define DllImport extern "C"
#else
#define DllImport extern
#endif


// Tipos de dados


// Funções

DllImport int EAD_AssinarArquivoComEAD(const INTPTR eadHandle, const PCHAR Arquivo, const BOOL Remove);
DllImport int EAD_CalcularChavePublica(const INTPTR eadHandle, PCHAR ChavePUB, const int bufferLen);
DllImport int EAD_CalcularEADArquivo(const INTPTR eadHandle, const PCHAR Arquivo, PCHAR Hash, const int bufferLen);
DllImport int EAD_CalcularHashArquivo(const INTPTR eadHandle, const PCHAR Arquivo, const int HashType, PCHAR Hash, const int bufferLen);
DllImport int EAD_CalcularModuloeExpoente(const INTPTR eadHandle, PCHAR Modulo, PCHAR Expoente, const int bufferLen);
DllImport int EAD_ConverteXMLeECFcParaOpenSSL(const INTPTR eadHandle, const PCHAR Arquivo);
DllImport int EAD_Create(INTPTR* eadHandle);
DllImport int EAD_Destroy(INTPTR* eadHandle);
DllImport int EAD_GerarChaves(const INTPTR eadHandle, PCHAR ChavePUB, PCHAR ChavePRI, const int bufferLen);
DllImport int EAD_GerarXMLeECFc(const INTPTR eadHandle, const PCHAR NomeSH, const PCHAR PathArquivo);
DllImport int EAD_GerarXMLeECFc_NP(const INTPTR eadHandle, const PCHAR NomeSH);
DllImport int EAD_GetChavePrivada(const INTPTR eadHandle, PCHAR buffer, const int bufferLen);
DllImport int EAD_GetChavePublica(const INTPTR eadHandle, PCHAR buffer, const int bufferLen);
DllImport int EAD_GetUltimoErro(const INTPTR eadHandle, PCHAR buffer, const int bufferLen);
DllImport int EAD_SetChavePrivada(const INTPTR eadHandle, const PCHAR chave);
DllImport int EAD_SetChavePublica(const INTPTR eadHandle, const PCHAR chave);
DllImport int EAD_VerificarEADArquivo(const INTPTR eadHandle, const PCHAR Arquivo);


#endif
