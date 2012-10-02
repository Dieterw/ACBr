#include <stdlib.h>

#include "jni.h"
#include "JNIHelper.h"

#include "ACBr.h"
#include "JACBrECF.h"

JNIEXPORT void JNICALL Java_jACBr_ACBrECF_create(JNIEnv *env, jobject obj)
{
	ACBR_HANDLE handle;
	int ret = ECF_Create(&handle);
	CheckResult(env, handle, ret);
	
	if (ret >= 0) SetACBrHandle(env, obj, handle);
}

JNIEXPORT void JNICALL Java_jACBr_ACBrECF_destroy(JNIEnv *env, jobject obj)
{
	ACBR_HANDLE handle = GetACBrHandle(env, obj);
	int ret = ECF_Destroy(&handle);
	CheckResult(env, handle, ret);
	
	if (ret >= 0) SetACBrHandle(env, obj, (ACBR_HANDLE)NULL);
}

JNIEXPORT void JNICALL Java_jACBr_ACBrECF_ativar(JNIEnv *env, jobject obj)
{
	ACBR_HANDLE handle = GetACBrHandle(env, obj);
	int ret = ECF_Ativar(handle);
	CheckResult(env, handle, ret);
}

JNIEXPORT void JNICALL Java_jACBr_ACBrECF_desativar(JNIEnv *env, jobject obj)
{
	ACBR_HANDLE handle = GetACBrHandle(env, obj);
	int ret = ECF_Desativar(handle);
	CheckResult(env, handle, ret);
}

JNIEXPORT jint JNICALL Java_jACBr_ACBrECF_getModelo(JNIEnv *env, jobject obj)
{
	return GetInt(&ECF_GetModelo, env, obj);
}

JNIEXPORT void JNICALL Java_jACBr_ACBrECF_setModelo(JNIEnv *env, jobject obj, jint modelo)
{
	SetInt(&ECF_SetModelo, env, obj, modelo);
}

JNIEXPORT jstring JNICALL Java_jACBr_ACBrECF_getPorta(JNIEnv *env, jobject obj)
{
	return GetString(&ECF_GetPorta, env, obj);
}

JNIEXPORT void JNICALL Java_jACBr_ACBrECF_setPorta(JNIEnv *env, jobject obj, jstring porta)
{
	SetString(&ECF_SetPorta, env, obj, porta);
}

JNIEXPORT jboolean JNICALL Java_jACBr_ACBrECF_getAtivo(JNIEnv *env, jobject obj)
{
	return GetBool(&ECF_GetAtivo, env, obj);
}

JNIEXPORT jint JNICALL Java_jACBr_ACBrECF_getColunas(JNIEnv *env, jobject obj)
{
	return GetInt(&ECF_GetColunas, env, obj);
}

JNIEXPORT jint JNICALL Java_jACBr_ACBrECF_getTimeOut(JNIEnv *env, jobject obj)
{
	return GetInt(&ECF_GetTimeOut, env, obj);
}

JNIEXPORT void JNICALL Java_jACBr_ACBrECF_setTimeOut(JNIEnv *env, jobject obj, jint timeout)
{
	return SetInt(&ECF_SetTimeOut, env, obj, timeout);
}

JNIEXPORT jboolean JNICALL Java_jACBr_ACBrECF_getAguardandoResposta(JNIEnv *env, jobject obj)
{
	return GetBool(&ECF_GetAguardandoResposta, env, obj);
}

JNIEXPORT jbyteArray JNICALL Java_jACBr_ACBrECF_getComandoEnviado(JNIEnv *env, jobject obj)
{
	return GetByteArray(&ECF_GetComandoEnviado, env, obj);
}

JNIEXPORT jbyteArray JNICALL Java_jACBr_ACBrECF_getRespostaComando(JNIEnv *env, jobject obj)
{
	return GetByteArray(&ECF_GetRespostaComando, env, obj);
}

JNIEXPORT jstring JNICALL Java_jACBr_ACBrECF_getComandoLOG(JNIEnv *env, jobject obj)
{
	return GetString(&ECF_GetComandoLOG, env, obj);
}

JNIEXPORT void JNICALL Java_jACBr_ACBrECF_setComandoLOG(JNIEnv *env, jobject obj, jstring comandoLog)
{
	SetString(&ECF_SetComandoLOG, env, obj, comandoLog);
}

JNIEXPORT jboolean JNICALL Java_jACBr_ACBrECF_getAguardaImpressao(JNIEnv *env, jobject obj)
{
	return GetBool(&ECF_GetAguardaImpressao, env, obj);
}

JNIEXPORT void JNICALL Java_jACBr_ACBrECF_setAguardaImpressao(JNIEnv *env, jobject obj, jboolean aguardaImpressao)
{
	return SetBool(&ECF_SetAguardaImpressao, env, obj, aguardaImpressao);
}

JNIEXPORT jstring JNICALL Java_jACBr_ACBrECF_getModeloStr(JNIEnv *env, jobject obj)
{
	return GetString(&ECF_GetModeloStr, env, obj);
}

JNIEXPORT jstring JNICALL Java_jACBr_ACBrECF_getRFDID(JNIEnv *env, jobject obj)
{
	return GetString(&ECF_GetRFDID, env, obj);
}

JNIEXPORT jobject JNICALL Java_jACBr_ACBrECF_getDataHora(JNIEnv *env, jobject obj)
{
	return GetDate(&ECF_GetDataHora, env, obj);
}

JNIEXPORT jstring JNICALL Java_jACBr_ACBrECF_getNumCupom(JNIEnv *env, jobject obj)
{
	return GetString(&ECF_GetNumCupom, env, obj);
}

JNIEXPORT jstring JNICALL Java_jACBr_ACBrECF_getNumCOO(JNIEnv *env, jobject obj)
{
	return GetString(&ECF_GetNumCOO, env, obj);
}

JNIEXPORT jstring JNICALL Java_jACBr_ACBrECF_getNumLoja(JNIEnv *env, jobject obj)
{
	return GetString(&ECF_GetNumLoja, env, obj);
}

JNIEXPORT jstring JNICALL Java_jACBr_ACBrECF_getNumECF(JNIEnv *env, jobject obj)
{
	return GetString(&ECF_GetNumECF, env, obj);
}

JNIEXPORT jstring JNICALL Java_jACBr_ACBrECF_getNumSerie(JNIEnv *env, jobject obj)
{
	return GetString(&ECF_GetNumSerie, env, obj);
}

JNIEXPORT jstring JNICALL Java_jACBr_ACBrECF_getNumVersao(JNIEnv *env, jobject obj)
{
	return GetString(&ECF_GetNumVersao, env, obj);
}

JNIEXPORT jobject JNICALL Java_jACBr_ACBrECF_getDataMovimento(JNIEnv *env, jobject obj)
{
	return GetDate(&ECF_GetDataMovimento, env, obj);
}

JNIEXPORT jobject JNICALL Java_jACBr_ACBrECF_getDataHoraSB(JNIEnv *env, jobject obj)
{
	return GetDate(&ECF_GetDataHoraSB, env, obj);
}

JNIEXPORT jstring JNICALL Java_jACBr_ACBrECF_getCNPJ(JNIEnv *env, jobject obj)
{
	return GetString(&ECF_GetCNPJ, env, obj);
}

JNIEXPORT jstring JNICALL Java_jACBr_ACBrECF_getIE(JNIEnv *env, jobject obj)
{
	return GetString(&ECF_GetIE, env, obj);
}

JNIEXPORT jstring JNICALL Java_jACBr_ACBrECF_getIM(JNIEnv *env, jobject obj)
{
	return GetString(&ECF_GetIM, env, obj);
}

JNIEXPORT jstring JNICALL Java_jACBr_ACBrECF_getCliche(JNIEnv *env, jobject obj)
{
	return GetString(&ECF_GetCliche, env, obj);
}

JNIEXPORT jstring JNICALL Java_jACBr_ACBrECF_getUsuarioAtual(JNIEnv *env, jobject obj)
{
	return GetString(&ECF_GetUsuarioAtual, env, obj);
}

JNIEXPORT jstring JNICALL Java_jACBr_ACBrECF_getSubModeloECF(JNIEnv *env, jobject obj)
{
	return GetString(&ECF_GetSubModeloECF, env, obj);
}

JNIEXPORT jstring JNICALL Java_jACBr_ACBrECF_getPAF(JNIEnv *env, jobject obj)
{
	return GetString(&ECF_GetPAF, env, obj);
}

JNIEXPORT jstring JNICALL Java_jACBr_ACBrECF_getNumCRZ(JNIEnv *env, jobject obj)
{
	return GetString(&ECF_GetNumCRZ, env, obj);
}

JNIEXPORT jstring JNICALL Java_jACBr_ACBrECF_getNumCRO(JNIEnv *env, jobject obj)
{
	return GetString(&ECF_GetNumCRO, env, obj);
}

JNIEXPORT jstring JNICALL Java_jACBr_ACBrECF_getNumCCF(JNIEnv *env, jobject obj)
{
	return GetString(&ECF_GetNumCCF, env, obj);
}

JNIEXPORT jstring JNICALL Java_jACBr_ACBrECF_getNumGNF(JNIEnv *env, jobject obj)
{
	return GetString(&ECF_GetNumGNF, env, obj);
}

JNIEXPORT jstring JNICALL Java_jACBr_ACBrECF_getNumGRG(JNIEnv *env, jobject obj)
{
	return GetString(&ECF_GetNumGRG, env, obj);
}

JNIEXPORT jstring JNICALL Java_jACBr_ACBrECF_getNumCDC(JNIEnv *env, jobject obj)
{
	return GetString(&ECF_GetNumCDC, env, obj);
}

JNIEXPORT jstring JNICALL Java_jACBr_ACBrECF_getNumCOOInicial(JNIEnv *env, jobject obj)
{
	return GetString(&ECF_GetNumCOOInicial, env, obj);
}

JNIEXPORT jdouble JNICALL Java_jACBr_ACBrECF_getVendaBruta(JNIEnv *env, jobject obj)
{
	return GetDouble(&ECF_GetVendaBruta, env, obj);
}

JNIEXPORT jdouble JNICALL Java_jACBr_ACBrECF_getGrandeTotal(JNIEnv *env, jobject obj)
{
	return GetDouble(&ECF_GetGrandeTotal, env, obj);
}

JNIEXPORT jdouble JNICALL Java_jACBr_ACBrECF_getTotalCancelamentos(JNIEnv *env, jobject obj)
{
	return GetDouble(&ECF_GetTotalCancelamentos, env, obj);
}

JNIEXPORT jdouble JNICALL Java_jACBr_ACBrECF_getTotalDescontos(JNIEnv *env, jobject obj)
{
	return GetDouble(&ECF_GetTotalDescontos, env, obj);
}

JNIEXPORT jdouble JNICALL Java_jACBr_ACBrECF_getTotalAcrescimos(JNIEnv *env, jobject obj)
{
	return GetDouble(&ECF_GetTotalAcrescimos, env, obj);
}

JNIEXPORT jdouble JNICALL Java_jACBr_ACBrECF_getTotalTroco(JNIEnv *env, jobject obj)
{
	return GetDouble(&ECF_GetTotalTroco, env, obj);
}

JNIEXPORT jdouble JNICALL Java_jACBr_ACBrECF_getTotalSubstituicaoTributaria(JNIEnv *env, jobject obj)
{
	return GetDouble(&ECF_GetTotalSubstituicaoTributaria, env, obj);
}

JNIEXPORT jdouble JNICALL Java_jACBr_ACBrECF_getTotalNaoTributado(JNIEnv *env, jobject obj)
{
	return GetDouble(&ECF_GetTotalNaoTributado, env, obj);
}

JNIEXPORT jdouble JNICALL Java_jACBr_ACBrECF_getTotalIsencao(JNIEnv *env, jobject obj)
{
	return GetDouble(&ECF_GetTotalIsencao, env, obj);
}

JNIEXPORT jdouble JNICALL Java_jACBr_ACBrECF_getTotalCancelamentosISSQ(JNIEnv *env, jobject obj)
{
	return GetDouble(&ECF_GetTotalCancelamentosISSQN, env, obj);
}

JNIEXPORT jdouble JNICALL Java_jACBr_ACBrECF_getTotalDescontosISSQ(JNIEnv *env, jobject obj)
{
	return GetDouble(&ECF_GetTotalDescontosISSQN, env, obj);
}

JNIEXPORT jdouble JNICALL Java_jACBr_ACBrECF_getTotalAcrescimosISSQ(JNIEnv *env, jobject obj)
{
	return GetDouble(&ECF_GetTotalAcrescimosISSQN, env, obj);
}

JNIEXPORT jdouble JNICALL Java_jACBr_ACBrECF_getTotalSubstituicaoTributariaISSQ(JNIEnv *env, jobject obj)
{
	return GetDouble(&ECF_GetTotalSubstituicaoTributariaISSQN, env, obj);
}

JNIEXPORT jdouble JNICALL Java_jACBr_ACBrECF_getTotalNaoTributadoISSQ(JNIEnv *env, jobject obj)
{
	return GetDouble(&ECF_GetTotalNaoTributadoISSQN, env, obj);
}

JNIEXPORT jdouble JNICALL Java_jACBr_ACBrECF_getTotalIsencaoISSQ(JNIEnv *env, jobject obj)
{
	return GetDouble(&ECF_GetTotalIsencaoISSQN, env, obj);
}

JNIEXPORT jdouble JNICALL Java_jACBr_ACBrECF_getTotalNaoFiscal(JNIEnv *env, jobject obj)
{
	return GetDouble(&ECF_GetTotalNaoFiscal, env, obj);
}

JNIEXPORT jint JNICALL Java_jACBr_ACBrECF_getNumUltItem(JNIEnv *env, jobject obj)
{
	return GetInt(&ECF_GetNumUltItem, env, obj);
}

JNIEXPORT jboolean JNICALL Java_jACBr_ACBrECF_getEmLinha(JNIEnv *env, jobject obj, jint timeOut)
{
	ACBR_HANDLE handle = GetACBrHandle(env, obj);
	int ret = ECF_GetEmLinha(handle, (int)timeOut);
	CheckResult(env, handle, ret);
	
	return (jboolean)(ret == 1);
}

JNIEXPORT jboolean JNICALL Java_jACBr_ACBrECF_getPoucoPapel(JNIEnv *env, jobject obj)
{
	return GetBool(&ECF_GetPoucoPapel, env, obj);
}

JNIEXPORT jint JNICALL Java_jACBr_ACBrECF_getEstado(JNIEnv *env, jobject obj)
{
	return GetInt(&ECF_GetEstado, env, obj);
}

JNIEXPORT jboolean JNICALL Java_jACBr_ACBrECF_getHorarioVerao(JNIEnv *env, jobject obj)
{
	return GetBool(&ECF_GetHorarioVerao, env, obj);
}

JNIEXPORT jboolean JNICALL Java_jACBr_ACBrECF_getArredonda(JNIEnv *env, jobject obj)
{
	return GetBool(&ECF_GetArredonda, env, obj);
}

JNIEXPORT jboolean JNICALL Java_jACBr_ACBrECF_getTermica(JNIEnv *env, jobject obj)
{
	return GetBool(&ECF_GetTermica, env, obj);
}

JNIEXPORT jboolean JNICALL Java_jACBr_ACBrECF_getMFD(JNIEnv *env, jobject obj)
{
	return GetBool(&ECF_GetMFD, env, obj);
}

JNIEXPORT jboolean JNICALL Java_jACBr_ACBrECF_getIdentificaConsumidorRodape(JNIEnv *env, jobject obj)
{
	return GetBool(&ECF_GetIdentificaConsumidorRodape, env, obj);
}

JNIEXPORT jdouble JNICALL Java_jACBr_ACBrECF_getSubTotal(JNIEnv *env, jobject obj)
{
	return GetDouble(&ECF_GetSubTotal, env, obj);
}

JNIEXPORT jdouble JNICALL Java_jACBr_ACBrECF_getTotalPago(JNIEnv *env, jobject obj)
{
	return GetDouble(&ECF_GetTotalPago, env, obj);
}

JNIEXPORT jboolean JNICALL Java_jACBr_ACBrECF_getGavetaAberta(JNIEnv *env, jobject obj)
{
	return GetBool(&ECF_GetGavetaAberta, env, obj);
}

JNIEXPORT jboolean JNICALL Java_jACBr_ACBrECF_getChequePronto(JNIEnv *env, jobject obj)
{
	return GetBool(&ECF_GetChequePronto, env, obj);
}

JNIEXPORT jint JNICALL Java_jACBr_ACBrECF_getIntervaloAposComando(JNIEnv *env, jobject obj)
{
	return GetInt(&ECF_GetIntervaloAposComando, env, obj);
}

JNIEXPORT void JNICALL Java_jACBr_ACBrECF_setIntervaloAposComando(JNIEnv *env, jobject obj, jint intervalo)
{
	return SetInt(&ECF_SetIntervaloAposComando, env, obj, intervalo);
}

JNIEXPORT jboolean JNICALL Java_jACBr_ACBrECF_getDescricaoGrande(JNIEnv *env, jobject obj)
{
	return GetBool(&ECF_GetDescricaoGrande, env, obj);
}

JNIEXPORT void JNICALL Java_jACBr_ACBrECF_setDescricaoGrande(JNIEnv *env, jobject obj, jboolean descricaoGrande)
{
	return SetBool(&ECF_SetDescricaoGrande, env, obj, descricaoGrande);
}

JNIEXPORT jboolean JNICALL Java_jACBr_ACBrECF_getGavetaSinalInvertido(JNIEnv *env, jobject obj)
{
	return GetBool(&ECF_GetGavetaSinalInvertido, env, obj);
}

JNIEXPORT void JNICALL Java_jACBr_ACBrECF_setGavetaSinalInvertido(JNIEnv *env, jobject obj, jboolean gavetaSinalInvertido)
{
	SetBool(&ECF_SetGavetaSinalInvertido, env, obj, gavetaSinalInvertido);
}

JNIEXPORT jstring JNICALL Java_jACBr_ACBrECF_getOperador(JNIEnv *env, jobject obj)
{
	return GetString(&ECF_GetOperador, env, obj);
}

JNIEXPORT void JNICALL Java_jACBr_ACBrECF_setOperador(JNIEnv *env, jobject obj, jstring operador)
{
	SetString(&ECF_SetOperador, env, obj, operador);
}

JNIEXPORT jint JNICALL Java_jACBr_ACBrECF_getLinhasEntreCupons(JNIEnv *env, jobject obj)
{
	return GetInt(&ECF_GetLinhasEntreCupons, env, obj);
}

JNIEXPORT void JNICALL Java_jACBr_ACBrECF_setLinhasEntreCupons(JNIEnv *env, jobject obj, jint linhasEntreCupons)
{
	SetInt(&ECF_SetLinhasEntreCupons, env, obj, linhasEntreCupons);
}

JNIEXPORT jint JNICALL Java_jACBr_ACBrECF_getDecimaisPreco(JNIEnv *env, jobject obj)
{
	return GetInt(&ECF_GetDecimaisPreco, env, obj);
}

JNIEXPORT void JNICALL Java_jACBr_ACBrECF_setDecimaisPreco(JNIEnv *env, jobject obj, jint decimaisPreco)
{
	SetInt(&ECF_SetDecimaisPreco, env, obj, decimaisPreco);
}

JNIEXPORT jint JNICALL Java_jACBr_ACBrECF_getDecimaisQtd(JNIEnv *env, jobject obj)
{
	return GetInt(&ECF_GetDecimaisQtd, env, obj);
}

JNIEXPORT void JNICALL Java_jACBr_ACBrECF_setDecimaisQtd(JNIEnv *env, jobject obj, jint decimaisQtd)
{
	SetInt(&ECF_SetDecimaisQtd, env, obj, decimaisQtd);
}

JNIEXPORT void JNICALL Java_jACBr_ACBrECF_identificaConsumidor(JNIEnv *env, jobject obj, jstring cpfCnpj, jstring nome, jstring endereco)
{
	ACBR_HANDLE handle = GetACBrHandle(env, obj);
	
	jboolean isCopy = (jboolean)false;
	
	const char* nCpfCnpj = env->GetStringUTFChars(cpfCnpj, &isCopy);
	const char* nNome = env->GetStringUTFChars(nome, &isCopy);
	const char* nEndereco = env->GetStringUTFChars(endereco, &isCopy);

	int ret = ECF_IdentificaConsumidor(handle, (PCHAR)nCpfCnpj, (PCHAR)nNome, (PCHAR)nEndereco);
	
	env->ReleaseStringUTFChars(cpfCnpj, nCpfCnpj);
	env->ReleaseStringUTFChars(nome, nNome);
	env->ReleaseStringUTFChars(endereco, nEndereco);

	CheckResult(env, handle, ret);
}

JNIEXPORT void JNICALL Java_jACBr_ACBrECF_abreCupom(JNIEnv *env, jobject obj, jstring cpfCnpj, jstring nome, jstring endereco)
{
	ACBR_HANDLE handle = GetACBrHandle(env, obj);
	
	jboolean isCopy = (jboolean)false;
	
	const char* nCpfCnpj = env->GetStringUTFChars(cpfCnpj, &isCopy);
	const char* nNome = env->GetStringUTFChars(nome, &isCopy);
	const char* nEndereco = env->GetStringUTFChars(endereco, &isCopy);

	int ret = ECF_AbreCupom(handle, (PCHAR)nCpfCnpj, (PCHAR)nNome, (PCHAR)nEndereco);

	env->ReleaseStringUTFChars(cpfCnpj, nCpfCnpj);
	env->ReleaseStringUTFChars(nome, nNome);
	env->ReleaseStringUTFChars(endereco, nEndereco);

	CheckResult(env, handle, ret);
}

JNIEXPORT jboolean JNICALL Java_jACBr_ACBrECF_legendaInmetroProximoItem(JNIEnv *env, jobject obj)
{
	return GetBool(&ECF_LegendaInmetroProximoItem, env, obj);
}

JNIEXPORT void JNICALL Java_jACBr_ACBrECF_vendeItem(JNIEnv *env, jobject obj, jstring codigo, jstring descricao, jstring aliquotaICMS, jdouble qtd, jdouble valorUnitario, jdouble descontoPorc, jstring unidade, jstring tipoDescontoAcrescimo, jstring descontoAcrescimo)
{
	ACBR_HANDLE handle = GetACBrHandle(env, obj);
	
	jboolean isCopy = (jboolean)false;
	
	const char* nCodigo = env->GetStringUTFChars(codigo, &isCopy);
	const char* nDescricao = env->GetStringUTFChars(descricao, &isCopy);
	const char* nAliquotaICMS = env->GetStringUTFChars(aliquotaICMS, &isCopy);
	const char* nUnidade = env->GetStringUTFChars(unidade, &isCopy);
	const char* nTipoDescontoAcrescimo = env->GetStringUTFChars(tipoDescontoAcrescimo, &isCopy);
	const char* nDescontoAcrescimo = env->GetStringUTFChars(descontoAcrescimo, &isCopy);

	char __TipoDescontoAcrescimo[2];
	__TipoDescontoAcrescimo[0] = nTipoDescontoAcrescimo[0];
	__TipoDescontoAcrescimo[1] = 0;

	char __DescontoAcrescimo[2];
	__DescontoAcrescimo[0] = nDescontoAcrescimo[0];
	__DescontoAcrescimo[1] = 0;

	int ret = ECF_VendeItem(handle, (PCHAR)nCodigo, (PCHAR)nDescricao, (PCHAR)nAliquotaICMS, (double)qtd, (double)valorUnitario, (double)descontoPorc, (PCHAR)nUnidade, (PCHAR)__TipoDescontoAcrescimo, (PCHAR)__DescontoAcrescimo);

	env->ReleaseStringUTFChars(codigo, nCodigo);
	env->ReleaseStringUTFChars(descricao, nDescricao);
	env->ReleaseStringUTFChars(aliquotaICMS, nAliquotaICMS);
	env->ReleaseStringUTFChars(unidade, nUnidade);
	env->ReleaseStringUTFChars(tipoDescontoAcrescimo, nTipoDescontoAcrescimo);
	env->ReleaseStringUTFChars(descontoAcrescimo, nDescontoAcrescimo);

	CheckResult(env, handle, ret);
}

JNIEXPORT void JNICALL Java_jACBr_ACBrECF_descontoAcrescimoItemAnterior(JNIEnv *env, jobject obj, jdouble valorDescontoAcrescimo, jstring descontoAcrescimo)
{
	ACBR_HANDLE handle = GetACBrHandle(env, obj);

	jboolean isCopy = (jboolean)false;
	const char* nDescontoAcrescimo = env->GetStringUTFChars(descontoAcrescimo, &isCopy);

	int ret = ECF_DescontoAcrescimoItemAnterior(handle, (double)valorDescontoAcrescimo, (PCHAR)nDescontoAcrescimo);

	env->ReleaseStringUTFChars(descontoAcrescimo, nDescontoAcrescimo);

	CheckResult(env, handle, ret);
}

JNIEXPORT void JNICALL Java_jACBr_ACBrECF_subtotalizaCupom(JNIEnv *env, jobject obj, jdouble descontoAcrescimo, jstring mensagemRodape)
{
	ACBR_HANDLE handle = GetACBrHandle(env, obj);

	jboolean isCopy = (jboolean)false;
	const char* nMensagemRodape = env->GetStringUTFChars(mensagemRodape, &isCopy);

	int ret = ECF_SubtotalizaCupom(handle, (double)descontoAcrescimo, (PCHAR)nMensagemRodape);

	env->ReleaseStringUTFChars(mensagemRodape, nMensagemRodape);

	CheckResult(env, handle, ret);
}

JNIEXPORT void JNICALL Java_jACBr_ACBrECF_efetuaPagamento(JNIEnv *env, jobject obj, jstring codFormaPagto, jdouble valor, jstring observacao, jboolean imprimeVinculado)
{
	ACBR_HANDLE handle = GetACBrHandle(env, obj);

	jboolean isCopy = (jboolean)false;
	const char* nCodFormaPagto = env->GetStringUTFChars(codFormaPagto, &isCopy);
	const char* nObservacao = env->GetStringUTFChars(observacao, &isCopy);

	int ret = ECF_EfetuaPagamento(handle, (PCHAR)nCodFormaPagto, (double)valor, (PCHAR)nObservacao, (BOOL)imprimeVinculado);

	env->ReleaseStringUTFChars(codFormaPagto, nCodFormaPagto);
	env->ReleaseStringUTFChars(observacao, nObservacao);

	CheckResult(env, handle, ret);
}

JNIEXPORT void JNICALL Java_jACBr_ACBrECF_estornaPagamento(JNIEnv *env, jobject obj, jstring codFormaPagtoEstornar, jstring codFormaPagtoEfetivar, jdouble valor, jstring observacao)
{
	ACBR_HANDLE handle = GetACBrHandle(env, obj);

	jboolean isCopy = (jboolean)false;
	const char* nCodFormaPagtoEstornar = env->GetStringUTFChars(codFormaPagtoEstornar, &isCopy);
	const char* nCodFormaPagtoEfetivar = env->GetStringUTFChars(codFormaPagtoEfetivar, &isCopy);
	const char* nObservacao = env->GetStringUTFChars(observacao, &isCopy);

	int ret = ECF_EstornaPagamento(handle, (PCHAR)nCodFormaPagtoEstornar, (PCHAR)nCodFormaPagtoEfetivar, (double)valor, (PCHAR)nObservacao);

	env->ReleaseStringUTFChars(codFormaPagtoEstornar, nCodFormaPagtoEstornar);
	env->ReleaseStringUTFChars(codFormaPagtoEfetivar, nCodFormaPagtoEfetivar);
	env->ReleaseStringUTFChars(observacao, nObservacao);

	CheckResult(env, handle, ret);
}

JNIEXPORT void JNICALL Java_jACBr_ACBrECF_fechaCupom(JNIEnv *env, jobject obj, jstring observacao)
{
	ACBR_HANDLE handle = GetACBrHandle(env, obj);

	jboolean isCopy = (jboolean)false;
	const char* nObservacao = env->GetStringUTFChars(observacao, &isCopy);

	int ret = ECF_FechaCupom(handle, (PCHAR)nObservacao);

	env->ReleaseStringUTFChars(observacao, nObservacao);

	CheckResult(env, handle, ret);
}

JNIEXPORT void JNICALL Java_jACBr_ACBrECF_cancelaCupom(JNIEnv *env, jobject obj)
{
	ACBR_HANDLE handle = GetACBrHandle(env, obj);
	int ret = ECF_CancelaCupom(handle);
	CheckResult(env, handle, ret);
}

JNIEXPORT void JNICALL Java_jACBr_ACBrECF_cancelaItemVendido(JNIEnv *env, jobject obj, jint numItem)
{
	ACBR_HANDLE handle = GetACBrHandle(env, obj);
	int ret = ECF_CancelaItemVendido(handle, (int)numItem);
	CheckResult(env, handle, ret);
}

JNIEXPORT void JNICALL Java_jACBr_ACBrECF_cancelaItemVendidoParcial(JNIEnv *env, jobject obj, jint numItem, jdouble quantidade)
{
	ACBR_HANDLE handle = GetACBrHandle(env, obj);
	int ret = ECF_CancelaItemVendidoParcial(handle, (int)numItem, (double)quantidade);
	CheckResult(env, handle, ret);
}

JNIEXPORT void JNICALL Java_jACBr_ACBrECF_cancelaDescontoAcrescimoItem(JNIEnv *env, jobject obj, jint numItem)
{
	ACBR_HANDLE handle = GetACBrHandle(env, obj);
	int ret =ECF_CancelaDescontoAcrescimoItem(handle, (int)numItem);
	CheckResult(env, handle, ret);
}

JNIEXPORT void JNICALL Java_jACBr_ACBrECF_cancelaDescontoAcrescimoSubTotal(JNIEnv *env, jobject obj, jchar tipoAcrescimoDesconto)
{
	ACBR_HANDLE handle = GetACBrHandle(env, obj);
	int ret = ECF_CancelaDescontoAcrescimoSubTotal(handle, (char)tipoAcrescimoDesconto);
	CheckResult(env, handle, ret);
}

JNIEXPORT void JNICALL Java_jACBr_ACBrECF_leituraX(JNIEnv *env, jobject obj)
{
	ACBR_HANDLE handle = GetACBrHandle(env, obj);
	int ret = ECF_LeituraX(handle);
	CheckResult(env, handle, ret);
}

JNIEXPORT void JNICALL Java_jACBr_ACBrECF_reducaoZ(JNIEnv *env, jobject obj)
{
	ACBR_HANDLE handle = GetACBrHandle(env, obj);
	int ret = ECF_ReducaoZ(handle);
	CheckResult(env, handle, ret);
}

JNIEXPORT void JNICALL Java_jACBr_ACBrECF_abreRelatorioGerencial(JNIEnv *env, jobject obj, jint indice)
{
	ACBR_HANDLE handle = GetACBrHandle(env, obj);
	int ret = ECF_AbreRelatorioGerencial(handle, (int)indice);
	CheckResult(env, handle, ret);
}

JNIEXPORT void JNICALL Java_jACBr_ACBrECF_linhaRelatorioGerencial(JNIEnv *env, jobject obj, jstring linha, jint indiceBMP)
{
	ACBR_HANDLE handle = GetACBrHandle(env, obj);

	jboolean isCopy = (jboolean)false;
	const char* nLinha = env->GetStringUTFChars(linha, &isCopy);

	int ret = ECF_LinhaRelatorioGerencial(handle, (PCHAR)nLinha, (int)indiceBMP);

	env->ReleaseStringUTFChars(linha, nLinha);

	CheckResult(env, handle, ret);
}

JNIEXPORT void JNICALL Java_jACBr_ACBrECF_abreCupomVinculado(JNIEnv *env, jobject obj, jstring coo, jstring codFormaPagto, jdouble valor)
{
	ACBR_HANDLE handle = GetACBrHandle(env, obj);

	jboolean isCopy = (jboolean)false;
	const char* nCoo = env->GetStringUTFChars(coo, &isCopy);
	const char* nCodFormaPagto = env->GetStringUTFChars(codFormaPagto, &isCopy);

	int ret = ECF_AbreCupomVinculado(handle, (PCHAR)nCoo, (PCHAR)nCodFormaPagto, (double)valor);

	env->ReleaseStringUTFChars(coo, nCoo);
	env->ReleaseStringUTFChars(codFormaPagto, nCodFormaPagto);

	CheckResult(env, handle, ret);
}


JNIEXPORT void JNICALL Java_jACBr_ACBrECF_abreCupomVinculadoCNF(JNIEnv *env, jobject obj, jstring coo, jstring codFormaPagto, jstring codComprovanteNaoFiscal, jdouble valor)
{
	ACBR_HANDLE handle = GetACBrHandle(env, obj);

	jboolean isCopy = (jboolean)false;
	const char* nCoo = env->GetStringUTFChars(coo, &isCopy);
	const char* nCodFormaPagto = env->GetStringUTFChars(codFormaPagto, &isCopy);
	const char* nCodComprovanteNaoFiscal = env->GetStringUTFChars(codComprovanteNaoFiscal, &isCopy);

	int ret = ECF_AbreCupomVinculadoCNF(handle, (PCHAR)nCoo, (PCHAR)nCodFormaPagto, (PCHAR)nCodComprovanteNaoFiscal, (double)valor);

	env->ReleaseStringUTFChars(coo, nCoo);
	env->ReleaseStringUTFChars(codFormaPagto, nCodFormaPagto);
	env->ReleaseStringUTFChars(codComprovanteNaoFiscal, nCodComprovanteNaoFiscal);

	CheckResult(env, handle, ret);
}

JNIEXPORT void JNICALL Java_jACBr_ACBrECF_linhaCupomVinculado(JNIEnv *env, jobject obj, jstring linha)
{
	ACBR_HANDLE handle = GetACBrHandle(env, obj);

	jboolean isCopy = (jboolean)false;
	const char* nLinha = env->GetStringUTFChars(linha, &isCopy);
	
	int ret = ECF_LinhaCupomVinculado(handle, (PCHAR)nLinha);

	env->ReleaseStringUTFChars(linha, nLinha);

	CheckResult(env, handle, ret);
}

JNIEXPORT void JNICALL Java_jACBr_ACBrECF_fechaRelatorio(JNIEnv *env, jobject obj)
{
	ACBR_HANDLE handle = GetACBrHandle(env, obj);	
	int ret = ECF_FechaRelatorio(handle);
	CheckResult(env, handle, ret);
}

JNIEXPORT void JNICALL Java_jACBr_ACBrECF_pulaLinhas(JNIEnv *env, jobject obj, jint numLinhas)
{
	ACBR_HANDLE handle = GetACBrHandle(env, obj);	
	int ret = ECF_PulaLinhas(handle, (int)numLinhas);
	CheckResult(env, handle, ret);
}

JNIEXPORT void JNICALL Java_jACBr_ACBrECF_cortaPapel(JNIEnv *env, jobject obj, jboolean corteParcial)
{
	ACBR_HANDLE handle = GetACBrHandle(env, obj);	
	int ret = ECF_CortaPapel(handle, (BOOL)corteParcial);
	CheckResult(env, handle, ret);
}

JNIEXPORT void JNICALL Java_jACBr_ACBrECF_getAliquotaN(JNIEnv *env, jobject obj, jobject aliquota, jint index)
{
	ACBR_HANDLE handle = GetACBrHandle(env, obj);
	
	AliquotaRec aliquotaRec;
	int ret = ECF_GetAliquota(handle, &aliquotaRec, (int)index);
	CheckResult(env, handle, ret);

	if (ret >= 0)
	{
		jclass clazz = env->GetObjectClass(aliquota);
		jfieldID indiceFieldID = env->GetFieldID(clazz, "indice", "Ljava/lang/String;");
		jfieldID aliquotaFieldID = env->GetFieldID(clazz, "aliquota", "D");
		jfieldID tipoFieldID = env->GetFieldID(clazz, "tipo", "C");
		jfieldID totalFieldID = env->GetFieldID(clazz, "total", "D");
		jfieldID sequenciaFieldID = env->GetFieldID(clazz, "sequencia", "I");

		env->SetObjectField(aliquota, indiceFieldID, env->NewStringUTF(aliquotaRec.Indice));
		env->SetDoubleField(aliquota, aliquotaFieldID, (jdouble)aliquotaRec.Aliquota);
		env->SetCharField(aliquota, tipoFieldID, (jchar)aliquotaRec.Tipo);
		env->SetDoubleField(aliquota, totalFieldID, (jdouble)aliquotaRec.Total);
		env->SetIntField(aliquota, sequenciaFieldID, (jint)aliquotaRec.Sequencia);
	}
}

JNIEXPORT jint JNICALL Java_jACBr_ACBrECF_carregaAliquotasN(JNIEnv *env, jobject obj)
{
	ACBR_HANDLE handle = GetACBrHandle(env, obj);
	int ret = ECF_CarregaAliquotas(handle);
	CheckResult(env, handle, ret);

	return (jint)ret;
}

JNIEXPORT void JNICALL Java_jACBr_ACBrECF_programaAliquota(JNIEnv *env, jobject obj, jdouble aliquota, jchar tipo, jstring posicao)
{
	ACBR_HANDLE handle = GetACBrHandle(env, obj);

	jboolean isCopy = (jboolean)false;
	const char* nPosicao = env->GetStringUTFChars(posicao, &isCopy);

	int ret = ECF_ProgramaAliquota(handle, (double)aliquota, (char)tipo, (PCHAR)nPosicao);

	env->ReleaseStringUTFChars(posicao, nPosicao);

	CheckResult(env, handle, ret);
}

JNIEXPORT void JNICALL Java_jACBr_ACBrECF_getFormaPagamentoN(JNIEnv *env, jobject obj, jobject formaPagamento, jint index)
{
	ACBR_HANDLE handle = GetACBrHandle(env, obj);
	
	FormaPagamentoRec formaPagamentoRec;
	int ret = ECF_GetFormaPagamento(handle, &formaPagamentoRec, (int)index);
	CheckResult(env, handle, ret);

	if (ret >= 0)
	{
		jclass clazz = env->GetObjectClass(formaPagamento);
		jfieldID indiceFieldID = env->GetFieldID(clazz, "indice", "Ljava/lang/String;");
		jfieldID descricaoFieldID = env->GetFieldID(clazz, "descricao", "Ljava/lang/String;");
		jfieldID permiteVinculadoFieldID = env->GetFieldID(clazz, "permiteVinculado", "Z");
		jfieldID totalFieldID = env->GetFieldID(clazz, "total", "D");
		
		env->SetObjectField(formaPagamento, indiceFieldID, env->NewStringUTF(formaPagamentoRec.Indice));
		env->SetObjectField(formaPagamento, descricaoFieldID, env->NewStringUTF(formaPagamentoRec.Descricao));
		env->SetCharField(formaPagamento, permiteVinculadoFieldID, (jboolean)formaPagamentoRec.PermiteVinculado);
		env->SetDoubleField(formaPagamento, totalFieldID, (jdouble)formaPagamentoRec.Total);
	}
}

JNIEXPORT jint JNICALL Java_jACBr_ACBrECF_carregaFormasPagamentoN(JNIEnv *env, jobject obj)
{
	ACBR_HANDLE handle = GetACBrHandle(env, obj);
	int ret = ECF_CarregaFormasPagamento(handle);
	CheckResult(env, handle, ret);

	return (jint)ret;
}

JNIEXPORT void JNICALL Java_jACBr_ACBrECF_programaFormaPagamento(JNIEnv *env, jobject obj, jstring descricao, jboolean permiteVinculado)
{
	ACBR_HANDLE handle = GetACBrHandle(env, obj);

	jboolean isCopy = (jboolean)false;
	const char* nDescricao = env->GetStringUTFChars(descricao, &isCopy);

	int ret = ECF_ProgramaFormaPagamento(handle, (PCHAR)nDescricao, (BOOL)permiteVinculado, "");

	env->ReleaseStringUTFChars(descricao, nDescricao);

	CheckResult(env, handle, ret);
}

JNIEXPORT void JNICALL Java_jACBr_ACBrECF_getComprovanteNaoFiscalN(JNIEnv *env, jobject obj, jobject comprovanteNaoFiscal, jint index)
{
	ACBR_HANDLE handle = GetACBrHandle(env, obj);
	ComprovanteNaoFiscalRec nComprovanteNaoFiscal;
	int ret = ECF_GetComprovanteNaoFiscal(handle, &nComprovanteNaoFiscal, (int)index);
	CheckResult(env, handle, ret);

	if (ret >=0)
	{
		jclass clazz = env->GetObjectClass(comprovanteNaoFiscal);
		jfieldID indiceFieldID = env->GetFieldID(clazz, "indice", "Ljava/lang/String;");
		jfieldID descricaoFieldID = env->GetFieldID(clazz, "descricao", "Ljava/lang/String;");
		jfieldID formaPagamentoFieldID = env->GetFieldID(clazz, "formaPagamento", "Ljava/lang/String;");
		jfieldID contadorFieldID = env->GetFieldID(clazz, "contador", "I");
		jfieldID permiteVinculadoFieldID = env->GetFieldID(clazz, "permiteVinculado", "Z");
		jfieldID totalFieldID = env->GetFieldID(clazz, "total", "D");
		
		env->SetObjectField(comprovanteNaoFiscal, indiceFieldID, env->NewStringUTF(nComprovanteNaoFiscal.Indice));
		env->SetObjectField(comprovanteNaoFiscal, descricaoFieldID, env->NewStringUTF(nComprovanteNaoFiscal.Descricao));
		env->SetObjectField(comprovanteNaoFiscal, formaPagamentoFieldID, env->NewStringUTF(nComprovanteNaoFiscal.FormaPagamento));
		env->SetIntField(comprovanteNaoFiscal, contadorFieldID, nComprovanteNaoFiscal.Contador);
	}
}

JNIEXPORT jint JNICALL Java_jACBr_ACBrECF_carregaComprovantesNaoFiscaisN(JNIEnv *env, jobject obj)
{
	ACBR_HANDLE handle = GetACBrHandle(env, obj);
	int ret = ECF_CarregaComprovantesNaoFiscais(handle);
	CheckResult(env, handle, ret);

	return (jint)ret;
}

JNIEXPORT void JNICALL Java_jACBr_ACBrECF_programaComprovanteNaoFiscal(JNIEnv *env, jobject obj, jstring descricao, jstring tipo)
{
	ACBR_HANDLE handle = GetACBrHandle(env, obj);
	
	jboolean isCopy = (jboolean)false;
	const char* nDescricao = env->GetStringUTFChars(descricao, &isCopy);
	const char* nTipo = env->GetStringUTFChars(tipo, &isCopy);

	int ret = ECF_ProgramaComprovanteNaoFiscal(handle, (PCHAR)nDescricao, (PCHAR)nTipo, "");

	env->ReleaseStringUTFChars(descricao, nDescricao);
	env->ReleaseStringUTFChars(tipo, nTipo);

	CheckResult(env, handle, ret);
}

JNIEXPORT void JNICALL Java_jACBr_ACBrECF_sangria(JNIEnv *env, jobject obj, jdouble valor, jstring obs)
{
	ACBR_HANDLE handle = GetACBrHandle(env, obj);	

	jboolean isCopy = (jboolean)false;
	const char* nObs = env->GetStringUTFChars(obs, &isCopy);

	int ret = ECF_Sangria(handle, (double)valor, (PCHAR)nObs);

	env->ReleaseStringUTFChars(obs, nObs);
	
	CheckResult(env, handle, ret);
}

JNIEXPORT void JNICALL Java_jACBr_ACBrECF_suprimento(JNIEnv *env, jobject obj, jdouble valor, jstring obs)
{
	ACBR_HANDLE handle = GetACBrHandle(env, obj);	

	jboolean isCopy = (jboolean)false;
	const char* nObs = env->GetStringUTFChars(obs, &isCopy);

	int ret = ECF_Suprimento(handle, (double)valor, (PCHAR)nObs);

	env->ReleaseStringUTFChars(obs, nObs);
	
	CheckResult(env, handle, ret);
}

JNIEXPORT void JNICALL Java_jACBr_ACBrECF_abreGaveta(JNIEnv *env, jobject obj)
{
	ACBR_HANDLE handle = GetACBrHandle(env, obj);	
	int ret = ECF_AbreGaveta(handle);
	CheckResult(env, handle, ret);
}