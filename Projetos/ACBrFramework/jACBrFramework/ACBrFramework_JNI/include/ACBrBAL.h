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


#ifndef _ACBrBAL_H_
#define _ACBrBAL_H_

#ifdef __cplusplus
#define DllImport extern "C"
#else
#define DllImport extern
#endif


// Tipos de dados


// Funções

DllImport int BAL_Ativar(const INTPTR balHandle);
DllImport int BAL_Create(INTPTR* balHandle);
DllImport int BAL_Desativar(const INTPTR balHandle);
DllImport int BAL_Destroy(INTPTR* balHandle);
DllImport int BAL_GetAtivo(const INTPTR balHandle);
DllImport int BAL_GetModelo(const INTPTR balHandle);
DllImport int BAL_GetModeloStr(const INTPTR balHandle, PCHAR buffer, const int bufferLen);
DllImport int BAL_GetPorta(const INTPTR balHandle, PCHAR buffer, const int bufferLen);
DllImport int BAL_GetUltimaResposta(const INTPTR balHandle, PCHAR buffer, const int bufferLen);
DllImport int BAL_GetUltimoErro(const INTPTR balHandle, PCHAR buffer, const int bufferLen);
DllImport int BAL_GetUltimoPesoLido(const INTPTR balHandle, double* peso);
DllImport int BAL_LePeso(const INTPTR balHandle, const int timeout, double* peso);
DllImport int BAL_SetModelo(const INTPTR balHandle, const int modelo);
DllImport int BAL_SetPorta(const INTPTR balHandle, const PCHAR porta);


#endif
