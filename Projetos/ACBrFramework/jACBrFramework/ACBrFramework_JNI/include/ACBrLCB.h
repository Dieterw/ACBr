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


#ifndef _ACBrLCB_H_
#define _ACBrLCB_H_

#ifdef __cplusplus
#define DllImport extern "C"
#else
#define DllImport extern
#endif


// Tipos de dados


// Funções

DllImport int LCB_Ativar(const INTPTR lcbHandle);
DllImport int LCB_Create(INTPTR* lcbHandle);
DllImport int LCB_Desativar(const INTPTR lcbHandle);
DllImport int LCB_Destroy(INTPTR* lcbHandle);
DllImport int LCB_GetAtivo(const INTPTR lcbHandle);
DllImport int LCB_GetPorta(const INTPTR lcbHandle, PCHAR buffer, const int bufferLen);
DllImport int LCB_GetUltimoErro(const INTPTR lcbHandle, PCHAR buffer, const int bufferLen);
DllImport int LCB_SetPorta(const INTPTR lcbHandle, const PCHAR porta);


#endif
