#ifndef _jACBrFramework_ECF_H_
#define _jACBrFramework_ECF_H_

#include "jni.h"

#ifdef __cplusplus
extern "C" {
#endif


JNIEXPORT void JNICALL Java_jACBrFramework_ACBrECF_create(JNIEnv *env, jobject obj);
JNIEXPORT void JNICALL Java_jACBrFramework_ACBrECF_destroy(JNIEnv *env, jobject obj);
JNIEXPORT void JNICALL Java_jACBrFramework_ACBrECF_ativar(JNIEnv *env, jobject obj);
JNIEXPORT void JNICALL Java_jACBrFramework_ACBrECF_desativar(JNIEnv *env, jobject obj);
JNIEXPORT jint JNICALL Java_jACBrFramework_ACBrECF_getModelo(JNIEnv *env, jobject obj);
JNIEXPORT void JNICALL Java_jACBrFramework_ACBrECF_setModelo(JNIEnv *env, jobject obj, jint modelo);
JNIEXPORT jstring JNICALL Java_jACBrFramework_ACBrECF_getPorta(JNIEnv *env, jobject obj);
JNIEXPORT void JNICALL Java_jACBrFramework_ACBrECF_setPorta(JNIEnv *env, jobject obj, jstring porta);
JNIEXPORT jboolean JNICALL Java_jACBrFramework_ACBrECF_getAtivo(JNIEnv *env, jobject obj);
JNIEXPORT jint JNICALL Java_jACBrFramework_ACBrECF_getColunas(JNIEnv *env, jobject obj);
JNIEXPORT jint JNICALL Java_jACBrFramework_ACBrECF_getTimeOut(JNIEnv *env, jobject obj);
JNIEXPORT void JNICALL Java_jACBrFramework_ACBrECF_setTimeOut(JNIEnv *env, jobject obj, jint timeout);
JNIEXPORT jboolean JNICALL Java_jACBrFramework_ACBrECF_getAguardandoResposta(JNIEnv *env, jobject obj);
JNIEXPORT jbyteArray JNICALL Java_jACBrFramework_ACBrECF_getComandoEnviado(JNIEnv *env, jobject obj);
JNIEXPORT jbyteArray JNICALL Java_jACBrFramework_ACBrECF_getRespostaComando(JNIEnv *env, jobject obj);
JNIEXPORT jstring JNICALL Java_jACBrFramework_ACBrECF_getComandoLOG(JNIEnv *env, jobject obj);
JNIEXPORT void JNICALL Java_jACBrFramework_ACBrECF_setComandoLOG(JNIEnv *env, jobject obj, jstring comandoLog);
JNIEXPORT jboolean JNICALL Java_jACBrFramework_ACBrECF_getAguardaImpressao(JNIEnv *env, jobject obj);
JNIEXPORT void JNICALL Java_jACBrFramework_ACBrECF_setAguardaImpressao(JNIEnv *env, jobject obj, jboolean aguardaImpressao);
JNIEXPORT jstring JNICALL Java_jACBrFramework_ACBrECF_getModeloStr(JNIEnv *env, jobject obj);
JNIEXPORT jstring JNICALL Java_jACBrFramework_ACBrECF_getRFDID(JNIEnv *env, jobject obj);
JNIEXPORT jobject JNICALL Java_jACBrFramework_ACBrECF_getDataHora(JNIEnv *env, jobject obj);
JNIEXPORT jstring JNICALL Java_jACBrFramework_ACBrECF_getNumCupom(JNIEnv *env, jobject obj);
JNIEXPORT jstring JNICALL Java_jACBrFramework_ACBrECF_getNumCOO(JNIEnv *env, jobject obj);
JNIEXPORT jstring JNICALL Java_jACBrFramework_ACBrECF_getNumLoja(JNIEnv *env, jobject obj);
JNIEXPORT jstring JNICALL Java_jACBrFramework_ACBrECF_getNumECF(JNIEnv *env, jobject obj);
JNIEXPORT jstring JNICALL Java_jACBrFramework_ACBrECF_getNumSerie(JNIEnv *env, jobject obj);
JNIEXPORT jstring JNICALL Java_jACBrFramework_ACBrECF_getNumVersao(JNIEnv *env, jobject obj);
JNIEXPORT jobject JNICALL Java_jACBrFramework_ACBrECF_getDataMovimento(JNIEnv *env, jobject obj);
JNIEXPORT jobject JNICALL Java_jACBrFramework_ACBrECF_getDataHoraSB(JNIEnv *env, jobject obj);
JNIEXPORT jstring JNICALL Java_jACBrFramework_ACBrECF_getCNPJ(JNIEnv *env, jobject obj);
JNIEXPORT jstring JNICALL Java_jACBrFramework_ACBrECF_getIE(JNIEnv *env, jobject obj);
JNIEXPORT jstring JNICALL Java_jACBrFramework_ACBrECF_getIM(JNIEnv *env, jobject obj);
JNIEXPORT jstring JNICALL Java_jACBrFramework_ACBrECF_getCliche(JNIEnv *env, jobject obj);
JNIEXPORT jstring JNICALL Java_jACBrFramework_ACBrECF_getUsuarioAtual(JNIEnv *env, jobject obj);
JNIEXPORT jstring JNICALL Java_jACBrFramework_ACBrECF_getSubModeloECF(JNIEnv *env, jobject obj);
JNIEXPORT jstring JNICALL Java_jACBrFramework_ACBrECF_getPAF(JNIEnv *env, jobject obj);
JNIEXPORT jstring JNICALL Java_jACBrFramework_ACBrECF_getNumCRZ(JNIEnv *env, jobject obj);
JNIEXPORT jstring JNICALL Java_jACBrFramework_ACBrECF_getNumCRO(JNIEnv *env, jobject obj);
JNIEXPORT jstring JNICALL Java_jACBrFramework_ACBrECF_getNumCCF(JNIEnv *env, jobject obj);
JNIEXPORT jstring JNICALL Java_jACBrFramework_ACBrECF_getNumGNF(JNIEnv *env, jobject obj);
JNIEXPORT jstring JNICALL Java_jACBrFramework_ACBrECF_getNumGRG(JNIEnv *env, jobject obj);
JNIEXPORT jstring JNICALL Java_jACBrFramework_ACBrECF_getNumCDC(JNIEnv *env, jobject obj);
JNIEXPORT jstring JNICALL Java_jACBrFramework_ACBrECF_getNumCOOInicial(JNIEnv *env, jobject obj);
JNIEXPORT jdouble JNICALL Java_jACBrFramework_ACBrECF_getVendaBruta(JNIEnv *env, jobject obj);
JNIEXPORT jdouble JNICALL Java_jACBrFramework_ACBrECF_getGrandeTotal(JNIEnv *env, jobject obj);
JNIEXPORT jdouble JNICALL Java_jACBrFramework_ACBrECF_getTotalCancelamentos(JNIEnv *env, jobject obj);
JNIEXPORT jdouble JNICALL Java_jACBrFramework_ACBrECF_getTotalDescontos(JNIEnv *env, jobject obj);
JNIEXPORT jdouble JNICALL Java_jACBrFramework_ACBrECF_getTotalAcrescimos(JNIEnv *env, jobject obj);
JNIEXPORT jdouble JNICALL Java_jACBrFramework_ACBrECF_getTotalTroco(JNIEnv *env, jobject obj);
JNIEXPORT jdouble JNICALL Java_jACBrFramework_ACBrECF_getTotalSubstituicaoTributaria(JNIEnv *env, jobject obj);
JNIEXPORT jdouble JNICALL Java_jACBrFramework_ACBrECF_getTotalNaoTributado(JNIEnv *env, jobject obj);
JNIEXPORT jdouble JNICALL Java_jACBrFramework_ACBrECF_getTotalIsencao(JNIEnv *env, jobject obj);
JNIEXPORT jdouble JNICALL Java_jACBrFramework_ACBrECF_getTotalCancelamentosISSQ(JNIEnv *env, jobject obj);
JNIEXPORT jdouble JNICALL Java_jACBrFramework_ACBrECF_getTotalDescontosISSQ(JNIEnv *env, jobject obj);
JNIEXPORT jdouble JNICALL Java_jACBrFramework_ACBrECF_getTotalAcrescimosISSQ(JNIEnv *env, jobject obj);
JNIEXPORT jdouble JNICALL Java_jACBrFramework_ACBrECF_getTotalSubstituicaoTributariaISSQ(JNIEnv *env, jobject obj);
JNIEXPORT jdouble JNICALL Java_jACBrFramework_ACBrECF_getTotalNaoTributadoISSQ(JNIEnv *env, jobject obj);
JNIEXPORT jdouble JNICALL Java_jACBrFramework_ACBrECF_getTotalIsencaoISSQ(JNIEnv *env, jobject obj);
JNIEXPORT jdouble JNICALL Java_jACBrFramework_ACBrECF_getTotalNaoFiscal(JNIEnv *env, jobject obj);
JNIEXPORT jint JNICALL Java_jACBrFramework_ACBrECF_getNumUltItem(JNIEnv *env, jobject obj);
JNIEXPORT jboolean JNICALL Java_jACBrFramework_ACBrECF_getEmLinha(JNIEnv *env, jobject obj, jint timeOut);
JNIEXPORT jboolean JNICALL Java_jACBrFramework_ACBrECF_getPoucoPapel(JNIEnv *env, jobject obj);
JNIEXPORT jint JNICALL Java_jACBrFramework_ACBrECF_getEstado(JNIEnv *env, jobject obj);
JNIEXPORT jboolean JNICALL Java_jACBrFramework_ACBrECF_getHorarioVerao(JNIEnv *env, jobject obj);
JNIEXPORT jboolean JNICALL Java_jACBrFramework_ACBrECF_getArredonda(JNIEnv *env, jobject obj);
JNIEXPORT jboolean JNICALL Java_jACBrFramework_ACBrECF_getTermica(JNIEnv *env, jobject obj);
JNIEXPORT jboolean JNICALL Java_jACBrFramework_ACBrECF_getMFD(JNIEnv *env, jobject obj);
JNIEXPORT jboolean JNICALL Java_jACBrFramework_ACBrECF_getIdentificaConsumidorRodape(JNIEnv *env, jobject obj);
JNIEXPORT jdouble JNICALL Java_jACBrFramework_ACBrECF_getSubTotal(JNIEnv *env, jobject obj);
JNIEXPORT jdouble JNICALL Java_jACBrFramework_ACBrECF_getTotalPago(JNIEnv *env, jobject obj);
JNIEXPORT jboolean JNICALL Java_jACBrFramework_ACBrECF_getGavetaAberta(JNIEnv *env, jobject obj);
JNIEXPORT jboolean JNICALL Java_jACBrFramework_ACBrECF_getChequePronto(JNIEnv *env, jobject obj);
JNIEXPORT jint JNICALL Java_jACBrFramework_ACBrECF_getIntervaloAposComando(JNIEnv *env, jobject obj);
JNIEXPORT void JNICALL Java_jACBrFramework_ACBrECF_setIntervaloAposComando(JNIEnv *env, jobject obj, jint intervalo);
JNIEXPORT jboolean JNICALL Java_jACBrFramework_ACBrECF_getDescricaoGrande(JNIEnv *env, jobject obj);
JNIEXPORT void JNICALL Java_jACBrFramework_ACBrECF_setDescricaoGrande(JNIEnv *env, jobject obj, jboolean descricaoGrande);
JNIEXPORT jboolean JNICALL Java_jACBrFramework_ACBrECF_getGavetaSinalInvertido(JNIEnv *env, jobject obj);
JNIEXPORT void JNICALL Java_jACBrFramework_ACBrECF_setGavetaSinalInvertido(JNIEnv *env, jobject obj, jboolean gavetaSinalInvertido);
JNIEXPORT jstring JNICALL Java_jACBrFramework_ACBrECF_getOperador(JNIEnv *env, jobject obj);
JNIEXPORT void JNICALL Java_jACBrFramework_ACBrECF_setOperador(JNIEnv *env, jobject obj, jstring operador);
JNIEXPORT jint JNICALL Java_jACBrFramework_ACBrECF_getLinhasEntreCupons(JNIEnv *env, jobject obj);
JNIEXPORT void JNICALL Java_jACBrFramework_ACBrECF_setLinhasEntreCupons(JNIEnv *env, jobject obj, jint linhasEntreCupons);
JNIEXPORT jint JNICALL Java_jACBrFramework_ACBrECF_getDecimaisPreco(JNIEnv *env, jobject obj);
JNIEXPORT void JNICALL Java_jACBrFramework_ACBrECF_setDecimaisPreco(JNIEnv *env, jobject obj, jint decimaisPreco);
JNIEXPORT jint JNICALL Java_jACBrFramework_ACBrECF_getDecimaisQtd(JNIEnv *env, jobject obj);
JNIEXPORT void JNICALL Java_jACBrFramework_ACBrECF_setDecimaisQtd(JNIEnv *env, jobject obj, jint decimaisQtd);
JNIEXPORT void JNICALL Java_jACBrFramework_ACBrECF_identificaConsumidor(JNIEnv *env, jobject obj, jstring cpfCnpj, jstring nome, jstring endereco);
JNIEXPORT void JNICALL Java_jACBrFramework_ACBrECF_abreCupom(JNIEnv *env, jobject obj, jstring cpfCnpj, jstring nome, jstring endereco);
JNIEXPORT jboolean JNICALL Java_jACBrFramework_ACBrECF_legendaInmetroProximoItem(JNIEnv *env, jobject obj);
JNIEXPORT void JNICALL Java_jACBrFramework_ACBrECF_vendeItem(JNIEnv *env, jobject obj, jstring codigo, jstring descricao, jstring aliquotaICMS, jdouble qtd, jdouble valorUnitario, jdouble descontoPorc, jstring unidade, jstring tipoDescontoAcrescimo, jstring descontoAcrescimo);
JNIEXPORT void JNICALL Java_jACBrFramework_ACBrECF_descontoAcrescimoItemAnterior(JNIEnv *env, jobject obj, jdouble valorDescontoAcrescimo, jstring descontoAcrescimo);
JNIEXPORT void JNICALL Java_jACBrFramework_ACBrECF_subtotalizaCupom(JNIEnv *env, jobject obj, jdouble descontoAcrescimo, jstring mensagemRodape);
JNIEXPORT void JNICALL Java_jACBrFramework_ACBrECF_efetuaPagamento(JNIEnv *env, jobject obj, jstring codFormaPagto, jdouble valor, jstring observacao, jboolean imprimeVinculado);
JNIEXPORT void JNICALL Java_jACBrFramework_ACBrECF_estornaPagamento(JNIEnv *env, jobject obj, jstring codFormaPagtoEstornar, jstring codFormaPagtoEfetivar, jdouble valor, jstring observacao);
JNIEXPORT void JNICALL Java_jACBrFramework_ACBrECF_fechaCupom(JNIEnv *env, jobject obj, jstring observacao);
JNIEXPORT void JNICALL Java_jACBrFramework_ACBrECF_cancelaCupom(JNIEnv *env, jobject obj);
JNIEXPORT void JNICALL Java_jACBrFramework_ACBrECF_cancelaItemVendido(JNIEnv *env, jobject obj, jint numItem);
JNIEXPORT void JNICALL Java_jACBrFramework_ACBrECF_cancelaItemVendidoParcial(JNIEnv *env, jobject obj, jint numItem, jdouble quantidade);
JNIEXPORT void JNICALL Java_jACBrFramework_ACBrECF_cancelaDescontoAcrescimoItem(JNIEnv *env, jobject obj, jint numItem);
JNIEXPORT void JNICALL Java_jACBrFramework_ACBrECF_cancelaDescontoAcrescimoSubTotal(JNIEnv *env, jobject obj, jchar tipoAcrescimoDesconto);
JNIEXPORT void JNICALL Java_jACBrFramework_ACBrECF_leituraX(JNIEnv *env, jobject obj);
JNIEXPORT void JNICALL Java_jACBrFramework_ACBrECF_reducaoZ(JNIEnv *env, jobject obj);
JNIEXPORT void JNICALL Java_jACBrFramework_ACBrECF_abreRelatorioGerencial(JNIEnv *env, jobject obj, jint indice);
JNIEXPORT void JNICALL Java_jACBrFramework_ACBrECF_linhaRelatorioGerencial(JNIEnv *env, jobject obj, jstring linha, jint indiceBMP);
JNIEXPORT void JNICALL Java_jACBrFramework_ACBrECF_abreCupomVinculado(JNIEnv *env, jobject obj, jstring coo, jstring codFormaPagto, jdouble valor);
JNIEXPORT void JNICALL Java_jACBrFramework_ACBrECF_abreCupomVinculadoCNF(JNIEnv *env, jobject obj, jstring coo, jstring codFormaPagto, jstring codComprovanteNaoFiscal, jdouble valor);
JNIEXPORT void JNICALL Java_jACBrFramework_ACBrECF_linhaCupomVinculado(JNIEnv *env, jobject obj, jstring linha);
JNIEXPORT void JNICALL Java_jACBrFramework_ACBrECF_fechaRelatorio(JNIEnv *env, jobject obj);
JNIEXPORT void JNICALL Java_jACBrFramework_ACBrECF_pulaLinhas(JNIEnv *env, jobject obj, jint numLinhas);
JNIEXPORT void JNICALL Java_jACBrFramework_ACBrECF_cortaPapel(JNIEnv *env, jobject obj, jboolean corteParcial);

JNIEXPORT void JNICALL Java_jACBrFramework_ACBrECF_getAliquotaN(JNIEnv *env, jobject obj, jobject aliquota, jint index);
JNIEXPORT jint JNICALL Java_jACBrFramework_ACBrECF_carregaAliquotasN(JNIEnv *env, jobject obj);
JNIEXPORT void JNICALL Java_jACBrFramework_ACBrECF_programaAliquota(JNIEnv *env, jobject obj, jdouble aliquota, jchar tipo, jstring posicao);

JNIEXPORT void JNICALL Java_jACBrFramework_ACBrECF_getFormaPagamentoN(JNIEnv *env, jobject obj, jobject formaPagamento, jint index);
JNIEXPORT jint JNICALL Java_jACBrFramework_ACBrECF_carregaFormasPagamentoN(JNIEnv *env, jobject obj);
JNIEXPORT void JNICALL Java_jACBrFramework_ACBrECF_programaFormaPagamento(JNIEnv *env, jobject obj, jstring descricao, jboolean permiteVinculado, jstring posicao);

JNIEXPORT void JNICALL Java_jACBrFramework_ACBrECF_getComprovanteNaoFiscalN(JNIEnv *env, jobject obj, jobject comprovanteNaoFiscal, jint index);
JNIEXPORT jint JNICALL Java_jACBrFramework_ACBrECF_carregaComprovantesNaoFiscaisN(JNIEnv *env, jobject obj);
JNIEXPORT void JNICALL Java_jACBrFramework_ACBrECF_programaComprovanteNaoFiscal(JNIEnv *env, jobject obj, jstring descricao, jstring tipo, jstring posicao);

JNIEXPORT void JNICALL Java_jACBrFramework_ACBrECF_sangria(JNIEnv *env, jobject obj, jdouble valor, jstring obs);
JNIEXPORT void JNICALL Java_jACBrFramework_ACBrECF_suprimento(JNIEnv *env, jobject obj, jdouble valor, jstring obs);
JNIEXPORT void JNICALL Java_jACBrFramework_ACBrECF_abreGaveta(JNIEnv *env, jobject obj);

#ifdef __cplusplus
} /* extern "C" */
#endif /* __cplusplus */

#endif