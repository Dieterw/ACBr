*Function GetUltimoErro(const handle: PHandle; Buffer : pChar; const BufferLen : Integer) : Integer
DECLARE INTEGER GetUltimoErro IN CURDIR() + "ACBr32.dll" INTEGER iHandle, STRING @cBuffer, INTEGER iBufferLen

*Function ECF_Create(var ecfHandle: PECFHandle): Integer
DECLARE INTEGER ECF_Create IN CURDIR() + "ACBr32.dll" INTEGER @iECFHandle

*Function ECF_Destroy(var ecfHandle: PECFHandle): Integer
DECLARE INTEGER ECF_Destroy IN CURDIR() + "ACBr32.dll" INTEGER @iECFHandle

*Function ECF_Ativar(const ecfHandle: PECFHandle) : Integer
DECLARE INTEGER ECF_Ativar IN CURDIR() + "ACBr32.dll" INTEGER iECFHandle

*Function ECF_Desativar(const ecfHandle: PECFHandle) : Integer
DECLARE INTEGER ECF_Desativar IN CURDIR() + "ACBr32.dll" INTEGER iECFHandle

** Funções mapeando as propriedades do componente

*Function ECF_GetModelo(const ecfHandle: PECFHandle) : Integer
DECLARE INTEGER ECF_GetModelo IN CURDIR() + "ACBr32.dll" INTEGER iECFHandle

*Function ECF_SetModelo(const ecfHandle: PECFHandle; const Modelo : Integer) : Integer
DECLARE INTEGER ECF_SetModelo IN CURDIR() + "ACBr32.dll" INTEGER iECFHandle, INTEGER iModelo

*Function ECF_GetPorta(const ecfHandle: PECFHandle; Buffer : pChar; const BufferLen : Integer) : Integer
DECLARE INTEGER ECF_GetPorta IN CURDIR() + "ACBr32.dll" INTEGER iECFHandle, STRING @cBuffer, INTEGER iBufferLen

*Function ECF_SetPorta(const ecfHandle: PECFHandle; const Porta : pChar) : Integer
DECLARE INTEGER ECF_SetPorta IN CURDIR() + "ACBr32.dll" INTEGER iECFHandle, STRING cPorta

*Function ECF_GetTimeOut(const ecfHandle: PECFHandle) : Integer
DECLARE INTEGER ECF_GetTimeOut IN CURDIR() + "ACBr32.dll" INTEGER iECFHandle

*Function ECF_SetTimeOut(const ecfHandle: PECFHandle; const TimeOut : Integer) : Integer
DECLARE INTEGER ECF_SetTimeOut IN CURDIR() + "ACBr32.dll" INTEGER iECFHandle, INTEGER iTimeOut

*Function ECF_GetAtivo(const ecfHandle: PECFHandle) : Integer
DECLARE INTEGER ECF_GetAtivo IN CURDIR() + "ACBr32.dll" INTEGER iECFHandle

*Function ECF_GetColunas(const ecfHandle: PECFHandle) : Integer
DECLARE INTEGER ECF_GetColunas IN CURDIR() + "ACBr32.dll" INTEGER iECFHandle

*Function ECF_GetAguardandoResposta(const ecfHandle: PECFHandle) : Integer
DECLARE INTEGER ECF_GetAguardandoResposta IN CURDIR() + "ACBr32.dll" INTEGER iECFHandle

*Function ECF_GetComandoEnviado(const ecfHandle: PECFHandle; Buffer : pChar; const BufferLen : Integer) : Integer
DECLARE INTEGER ECF_GetComandoEnviado IN CURDIR() + "ACBr32.dll" INTEGER iECFHandle, STRING @cBuffer, INTEGER iBufferLen

*Function ECF_GetRespostaComando(const ecfHandle: PECFHandle; Buffer : pChar; const BufferLen : Integer) : Integer
DECLARE INTEGER ECF_GetRespostaComando IN CURDIR() + "ACBr32.dll" INTEGER iECFHandle, STRING @cBuffer, INTEGER iBufferLen

*Function ECF_GetComandoLOG(const ecfHandle: PECFHandle; Buffer : pChar; const BufferLen : Integer) : Integer
DECLARE INTEGER ECF_GetComandoLOG IN CURDIR() + "ACBr32.dll" INTEGER iECFHandle, STRING @cBuffer, INTEGER iBufferLen

*Function ECF_SetComandoLOG(const ecfHandle: PECFHandle; const ComandoLog : pChar) : Integer
DECLARE INTEGER ECF_SetComandoLOG IN CURDIR() + "ACBr32.dll" INTEGER iECFHandle, STRING cComandoLog

*Function ECF_GetAguardaImpressao(const ecfHandle: PECFHandle) : Integer
DECLARE INTEGER ECF_GetAguardaImpressao IN CURDIR() + "ACBr32.dll" INTEGER iECFHandle

*Function ECF_SetAguardaImpressao(const ecfHandle: PECFHandle; const AguardaImpressao : Boolean) : Integer
DECLARE INTEGER ECF_SetAguardaImpressao IN CURDIR() + "ACBr32.dll" INTEGER iECFHandle, INTEGER bAguardaImpressao

*Function ECF_GetModeloStr(const ecfHandle: PECFHandle; Buffer : pChar; const BufferLen : Integer) : Integer
DECLARE INTEGER ECF_GetModeloStr IN CURDIR() + "ACBr32.dll" INTEGER iECFHandle, STRING @cBuffer, INTEGER iBufferLen

*Function ECF_GetRFDID(const ecfHandle: PECFHandle; Buffer : pChar; const BufferLen : Integer) : Integer
DECLARE INTEGER ECF_GetRFDID IN CURDIR() + "ACBr32.dll" INTEGER iECFHandle, STRING @cBuffer, INTEGER iBufferLen

*Function ECF_GetDataHora(const ecfHandle: PECFHandle; var ticks : Double) : Integer
DECLARE INTEGER ECF_GetDataHora IN CURDIR() + "ACBr32.dll" INTEGER iECFHandle, DOUBLE @dTicks

*Function ECF_GetDataHoraStr(const ecfHandle: PECFHandle; Buffer : pChar; const BufferLen : Integer) : Integer
DECLARE INTEGER ECF_GetDataHoraStr IN CURDIR() + "ACBr32.dll" INTEGER iECFHandle, STRING @cBuffer, INTEGER iBufferLen

*Function ECF_GetNumCupom(const ecfHandle: PECFHandle; Buffer : pChar; const BufferLen : Integer) : Integer
DECLARE INTEGER ECF_GetNumCupom IN CURDIR() + "ACBr32.dll" INTEGER iECFHandle, STRING @cBuffer, INTEGER iBufferLen

*Function ECF_GetNumCOO(const ecfHandle: PECFHandle; Buffer : pChar; const BufferLen : Integer) : Integer
DECLARE INTEGER ECF_GetNumCOO IN CURDIR() + "ACBr32.dll" INTEGER iECFHandle, STRING @cBuffer, INTEGER iBufferLen

*Function ECF_GetNumLoja(const ecfHandle: PECFHandle; Buffer : pChar; const BufferLen : Integer) : Integer
DECLARE INTEGER ECF_GetNumLoja IN CURDIR() + "ACBr32.dll" INTEGER iECFHandle, STRING @cBuffer, INTEGER iBufferLen

*Function ECF_GetNumECF(const ecfHandle: PECFHandle; Buffer : pChar; const BufferLen : Integer) : Integer
DECLARE INTEGER ECF_GetNumECF IN CURDIR() + "ACBr32.dll" INTEGER iECFHandle, STRING @cBuffer, INTEGER iBufferLen

*Function ECF_GetNumSerie(const ecfHandle: PECFHandle; Buffer : pChar; const BufferLen : Integer) : Integer
DECLARE INTEGER ECF_GetNumSerie IN CURDIR() + "ACBr32.dll" INTEGER iECFHandle, STRING @cBuffer, INTEGER iBufferLen

*Function ECF_GetNumVersao(const ecfHandle: PECFHandle; Buffer : pChar; const BufferLen : Integer) : Integer
DECLARE INTEGER ECF_GetNumVersao IN CURDIR() + "ACBr32.dll" INTEGER iECFHandle, STRING @cBuffer, INTEGER iBufferLen

*Function ECF_GetDataMovimento(const ecfHandle: PECFHandle; var ticks : Double) : Integer
DECLARE INTEGER ECF_GetDataMovimento IN CURDIR() + "ACBr32.dll" INTEGER iECFHandle, DOUBLE @dTicks

*Function ECF_GetDataMovimentoStr(const ecfHandle: PECFHandle; Buffer : pChar; const BufferLen : Integer) : Integer
DECLARE INTEGER ECF_GetDataMovimentoStr IN CURDIR() + "ACBr32.dll" INTEGER iECFHandle, STRING @cBuffer, INTEGER iBufferLen

*Function ECF_GetDataHoraSB(const ecfHandle: PECFHandle; var ticks : Double) : Integer
DECLARE INTEGER ECF_GetDataHoraSB IN CURDIR() + "ACBr32.dll" INTEGER iECFHandle, DOUBLE @dTicks

*Function ECF_GetDataHoraSBStr(const ecfHandle: PECFHandle; Buffer : pChar; const BufferLen : Integer) : Integer
DECLARE INTEGER ECF_GetDataHoraSBStr IN CURDIR() + "ACBr32.dll" INTEGER iECFHandle, STRING @cBuffer, INTEGER iBufferLen

*Function ECF_GetCNPJ(const ecfHandle: PECFHandle; Buffer : pChar; const BufferLen : Integer) : Integer
DECLARE INTEGER ECF_GetCNPJ IN CURDIR() + "ACBr32.dll" INTEGER iECFHandle, STRING @cBuffer, INTEGER iBufferLen

*Function ECF_GetIE(const ecfHandle: PECFHandle; Buffer : pChar; const BufferLen : Integer) : Integer
DECLARE INTEGER ECF_GetIE IN CURDIR() + "ACBr32.dll" INTEGER iECFHandle, STRING @cBuffer, INTEGER iBufferLen

*Function ECF_GetIM(const ecfHandle: PECFHandle; Buffer : pChar; const BufferLen : Integer) : Integer
DECLARE INTEGER ECF_GetIM IN CURDIR() + "ACBr32.dll" INTEGER iECFHandle, STRING @cBuffer, INTEGER iBufferLen

*Function ECF_GetCliche(const ecfHandle: PECFHandle; Buffer : pChar; const BufferLen : Integer) : Integer
DECLARE INTEGER ECF_GetCliche IN CURDIR() + "ACBr32.dll" INTEGER iECFHandle, STRING @cBuffer, INTEGER iBufferLen

*Function ECF_GetUsuarioAtual(const ecfHandle: PECFHandle; Buffer : pChar; const BufferLen : Integer) : Integer ; cdecl ; expor
DECLARE INTEGER ECF_GetUsuarioAtual IN CURDIR() + "ACBr32.dll" INTEGER iECFHandle, STRING @cBuffer, INTEGER iBufferLen

*Function ECF_GetSubModeloECF(const ecfHandle: PECFHandle; Buffer : pChar; const BufferLen : Integer) : Integer
DECLARE INTEGER ECF_GetSubModeloECF IN CURDIR() + "ACBr32.dll" INTEGER iECFHandle, STRING @cBuffer, INTEGER iBufferLen

*Function ECF_GetPAF(const ecfHandle: PECFHandle; Buffer : pChar; const BufferLen : Integer) : Integer
DECLARE INTEGER ECF_GetPAF IN CURDIR() + "ACBr32.dll" INTEGER iECFHandle, STRING @cBuffer, INTEGER iBufferLen

*Function ECF_GetNumCRZ(const ecfHandle: PECFHandle; Buffer : pChar; const BufferLen : Integer) : Integer
DECLARE INTEGER ECF_GetNumCRZ IN CURDIR() + "ACBr32.dll" INTEGER iECFHandle, STRING @cBuffer, INTEGER iBufferLen

*Function ECF_GetNumCRO(const ecfHandle: PECFHandle; Buffer : pChar; const BufferLen : Integer) : Integer
DECLARE INTEGER ECF_GetNumCRO IN CURDIR() + "ACBr32.dll" INTEGER iECFHandle, STRING @cBuffer, INTEGER iBufferLen

*Function ECF_GetNumCCF(const ecfHandle: PECFHandle; Buffer : pChar; const BufferLen : Integer) : Integer
DECLARE INTEGER ECF_GetNumCCF IN CURDIR() + "ACBr32.dll" INTEGER iECFHandle, STRING @cBuffer, INTEGER iBufferLen

*Function ECF_GetNumGNF(const ecfHandle: PECFHandle; Buffer : pChar; const BufferLen : Integer) : Integer
DECLARE INTEGER ECF_GetNumGNF IN CURDIR() + "ACBr32.dll" INTEGER iECFHandle, STRING @cBuffer, INTEGER iBufferLen

*Function ECF_GetNumGRG(const ecfHandle: PECFHandle; Buffer : pChar; const BufferLen : Integer) : Integer
DECLARE INTEGER ECF_GetNumGRG IN CURDIR() + "ACBr32.dll" INTEGER iECFHandle, STRING @cBuffer, INTEGER iBufferLen

*Function ECF_GetNumCDC(const ecfHandle: PECFHandle; Buffer : pChar; const BufferLen : Integer) : Integer
DECLARE INTEGER ECF_GetNumCDC IN CURDIR() + "ACBr32.dll" INTEGER iECFHandle, STRING @cBuffer, INTEGER iBufferLen

*Function ECF_GetNumCOOInicial(const ecfHandle: PECFHandle; Buffer : pChar; const BufferLen : Integer) : Integer
DECLARE INTEGER ECF_GetNumCOOInicial IN CURDIR() + "ACBr32.dll" INTEGER iECFHandle, STRING @cBuffer, INTEGER iBufferLen

*Function ECF_GetVendaBruta(const ecfHandle: PECFHandle; var VendaBruta : Double) : Integer
DECLARE INTEGER ECF_GetVendaBruta IN CURDIR() + "ACBr32.dll" INTEGER iECFHandle, DOUBLE @dVendaBruta

*Function ECF_GetGrandeTotal(const ecfHandle: PECFHandle; var GrandeTotal : Double ) : Integer
DECLARE INTEGER ECF_GetGrandeTotal IN CURDIR() + "ACBr32.dll" INTEGER iECFHandle, DOUBLE @dGrandeTotal

*Function ECF_GetTotalCancelamentos(const ecfHandle: PECFHandle; var TotalCancelamentos : Double ) : Integer
DECLARE INTEGER ECF_GetTotalCancelamentos IN CURDIR() + "ACBr32.dll" INTEGER iECFHandle, DOUBLE @dTotalCancelamentos

*Function ECF_GetTotalDescontos(const ecfHandle: PECFHandle; var TotalDescontos : Double ) : Integer
DECLARE INTEGER ECF_GetTotalDescontos IN CURDIR() + "ACBr32.dll" INTEGER iECFHandle, DOUBLE @dTotalDescontos

*Function ECF_GetTotalAcrescimos(const ecfHandle: PECFHandle; var TotalAcrescimos : Double ) : Integer
DECLARE INTEGER ECF_GetTotalAcrescimos IN CURDIR() + "ACBr32.dll" INTEGER iECFHandle, DOUBLE @dTotalAcrescimos

*Function ECF_GetTotalTroco(const ecfHandle: PECFHandle; var TotalTroco : Double ) : Integer
DECLARE INTEGER ECF_GetTotalTroco IN CURDIR() + "ACBr32.dll" INTEGER iECFHandle, DOUBLE @dTotalTroco

*Function ECF_GetTotalSubstituicaoTributaria(const ecfHandle: PECFHandle; var TotalSubstituicaoTributaria : Double) : Integer
DECLARE INTEGER ECF_GetTotalSubstituicaoTributaria IN CURDIR() + "ACBr32.dll" INTEGER iECFHandle, DOUBLE @dTotalSubstituicaoTributaria

*Function ECF_GetTotalNaoTributado(const ecfHandle: PECFHandle; var TotalNaoTributado : Double) : Integer
DECLARE INTEGER ECF_GetTotalNaoTributado IN CURDIR() + "ACBr32.dll" INTEGER iECFHandle, DOUBLE @dTotalNaoTributado

*Function ECF_GetTotalIsencao(const ecfHandle: PECFHandle; var TotalIsencao : Double) : Integer
DECLARE INTEGER ECF_GetTotalIsencao IN CURDIR() + "ACBr32.dll" INTEGER iECFHandle, DOUBLE @dTotalIsencao

*Function ECF_GetTotalCancelamentosISSQN(const ecfHandle: PECFHandle; var TotalCancelamentosISSQN : Double) : Integer
DECLARE INTEGER ECF_GetTotalCancelamentosISSQN IN CURDIR() + "ACBr32.dll" INTEGER iECFHandle, DOUBLE @dTotalCancelamentosISSQN

*Function ECF_GetTotalDescontosISSQN(const ecfHandle: PECFHandle; var TotalDescontosISSQN : Double) : Integer
DECLARE INTEGER ECF_GetTotalDescontosISSQN IN CURDIR() + "ACBr32.dll" INTEGER iECFHandle, DOUBLE @dTotalDescontosISSQN

*Function ECF_GetTotalAcrescimosISSQN(const ecfHandle: PECFHandle; var TotalAcrescimosISSQN : Double) : Integer
DECLARE INTEGER ECF_GetTotalAcrescimosISSQN IN CURDIR() + "ACBr32.dll" INTEGER iECFHandle, DOUBLE @dTotalAcrescimosISSQN

*Function ECF_GetTotalSubstituicaoTributariaISSQN(const ecfHandle: PECFHandle; var TotalSubstituicaoTributariaISSQN : Double) : Integer
DECLARE INTEGER ECF_GetTotalSubstituicaoTributariaISSQN IN CURDIR() + "ACBr32.dll" INTEGER iECFHandle, DOUBLE @dTotalAcrescimosISSQN

*Function ECF_GetTotalNaoTributadoISSQN(const ecfHandle: PECFHandle; var TotalNaoTributadoISSQN : Double) : Integer
DECLARE INTEGER ECF_GetTotalNaoTributadoISSQN IN CURDIR() + "ACBr32.dll" INTEGER iECFHandle, DOUBLE @dTotalNaoTributadoISSQN

*Function ECF_GetTotalIsencaoISSQN(const ecfHandle: PECFHandle; var TotalIsencaoISSQN : Double) : Integer
DECLARE INTEGER ECF_GetTotalIsencaoISSQN IN CURDIR() + "ACBr32.dll" INTEGER iECFHandle, DOUBLE @dTotalIsencaoISSQN

*Function ECF_GetTotalNaoFiscal(const ecfHandle: PECFHandle; var TotalNaoFiscal : Double) : Integer
DECLARE INTEGER ECF_GetTotalNaoFiscal IN CURDIR() + "ACBr32.dll" INTEGER iECFHandle, DOUBLE @dTotalNaoFiscal

*Function ECF_GetNumUltItem(const ecfHandle: PECFHandle) : Integer
DECLARE INTEGER ECF_GetNumUltItem IN CURDIR() + "ACBr32.dll" INTEGER iECFHandle

** ECF - Flags

*Function ECF_GetEmLinha(const ecfHandle: PECFHandle; const TimeOut : Integer) : Integer
DECLARE INTEGER ECF_GetEmLinha IN CURDIR() + "ACBr32.dll" INTEGER iECFHandle, INTEGER iTimeOut

*Function ECF_GetPoucoPapel(const ecfHandle: PECFHandle) : Integer
DECLARE INTEGER ECF_GetPoucoPapel IN CURDIR() + "ACBr32.dll" INTEGER iECFHandle

*Function ECF_GetEstado(const ecfHandle: PECFHandle) : Integer
DECLARE INTEGER ECF_GetEstado IN CURDIR() + "ACBr32.dll" INTEGER iECFHandle

*Function ECF_GetHorarioVerao(const ecfHandle: PECFHandle) : Integer
DECLARE INTEGER ECF_GetHorarioVerao IN CURDIR() + "ACBr32.dll" INTEGER iECFHandle

*Function ECF_GetArredonda(const ecfHandle: PECFHandle) : Integer
DECLARE INTEGER ECF_GetArredonda IN CURDIR() + "ACBr32.dll" INTEGER iECFHandle

*Function ECF_GetTermica(const ecfHandle: PECFHandle) : Integer
DECLARE INTEGER ECF_GetTermica IN CURDIR() + "ACBr32.dll" INTEGER iECFHandle

*Function ECF_GetMFD(const ecfHandle: PECFHandle) : Integer
DECLARE INTEGER ECF_GetMFD IN CURDIR() + "ACBr32.dll" INTEGER iECFHandle

*Function ECF_GetIdentificaConsumidorRodape(const ecfHandle: PECFHandle) : Integer
DECLARE INTEGER ECF_GetIdentificaConsumidorRodape IN CURDIR() + "ACBr32.dll" INTEGER iECFHandle

*Function ECF_GetSubTotal(const ecfHandle: PECFHandle; var SubTotal : double) : Integer
DECLARE INTEGER ECF_GetSubTotal IN CURDIR() + "ACBr32.dll" INTEGER iECFHandle, DOUBLE @dSubTotal

*Function ECF_GetTotalPago(const ecfHandle: PECFHandle; var TotalPago : double) : Integer
DECLARE INTEGER ECF_GetTotalPago IN CURDIR() + "ACBr32.dll" INTEGER iECFHandle, DOUBLE @dTotalPago

*Function ECF_GetGavetaAberta(const ecfHandle: PECFHandle) : Integer
DECLARE INTEGER ECF_GetGavetaAberta IN CURDIR() + "ACBr32.dll" INTEGER iECFHandle

*Function ECF_GetChequePronto(const ecfHandle: PECFHandle) : Integer
DECLARE INTEGER ECF_GetChequePronto IN CURDIR() + "ACBr32.dll" INTEGER iECFHandle

*Function ECF_GetIntervaloAposComando(const ecfHandle: PECFHandle) : Integer
DECLARE INTEGER ECF_GetIntervaloAposComando IN CURDIR() + "ACBr32.dll" INTEGER iECFHandle

*Function ECF_SetIntervaloAposComando(const ecfHandle: PECFHandle; const Intervalo : Integer) : Integer
DECLARE INTEGER ECF_SetIntervaloAposComando IN CURDIR() + "ACBr32.dll" INTEGER iECFHandle, INTEGER iIntervalo

*Function ECF_GetDescricaoGrande(const ecfHandle: PECFHandle) : Integer
DECLARE INTEGER ECF_GetDescricaoGrande IN CURDIR() + "ACBr32.dll" INTEGER iECFHandle

*Function ECF_SetDescricaoGrande(const ecfHandle: PECFHandle; const DescricaoGrande : Boolean) : Integer
DECLARE INTEGER ECF_SetDescricaoGrande IN CURDIR() + "ACBr32.dll" INTEGER iECFHandle, INTEGER bDescricaoGrande

*Function ECF_GetGavetaSinalInvertido(const ecfHandle: PECFHandle) : Integer
DECLARE INTEGER ECF_GetGavetaSinalInvertido IN CURDIR() + "ACBr32.dll" INTEGER iECFHandle

*Function ECF_SetGavetaSinalInvertido(const ecfHandle: PECFHandle; const GavetaSinalInvertido : Boolean) : Integer
DECLARE INTEGER ECF_SetGavetaSinalInvertido IN CURDIR() + "ACBr32.dll" INTEGER iECFHandle, INTEGER bGavetaSinalInvertido

*Function ECF_GetOperador(const ecfHandle: PECFHandle; Buffer : pChar; const BufferLen : Integer) : Integer
DECLARE INTEGER ECF_GetOperador IN CURDIR() + "ACBr32.dll" INTEGER iECFHandle, STRING @cBuffer, INTEGER iBufferLen

*Function ECF_SetOperador(const ecfHandle: PECFHandle; const Operador : pChar) : Integer
DECLARE INTEGER ECF_SetOperador IN CURDIR() + "ACBr32.dll" INTEGER iECFHandle, STRING cOperador

*Function ECF_GetLinhasEntreCupons(const ecfHandle: PECFHandle) : Integer
DECLARE INTEGER ECF_GetLinhasEntreCupons IN CURDIR() + "ACBr32.dll" INTEGER iECFHandle

*Function ECF_SetLinhasEntreCupons(const ecfHandle: PECFHandle; const LinhasEntreCupons : Integer) : Integer
DECLARE INTEGER ECF_SetLinhasEntreCupons IN CURDIR() + "ACBr32.dll" INTEGER iECFHandle, INTEGER iLinhasEntreCupons

*Function ECF_GetDecimaisPreco(const ecfHandle: PECFHandle) : Integer
DECLARE INTEGER ECF_GetDecimaisPreco IN CURDIR() + "ACBr32.dll" INTEGER iECFHandle

*Function ECF_SetDecimaisPreco(const ecfHandle: PECFHandle; const DecimaisPreco : Integer) : Integer
DECLARE INTEGER ECF_SetDecimaisPreco IN CURDIR() + "ACBr32.dll" INTEGER iECFHandle, INTEGER iDecimaisPreco

*Function ECF_GetDecimaisQtd(const ecfHandle: PECFHandle) : Integer
DECLARE INTEGER ECF_GetDecimaisQtd IN CURDIR() + "ACBr32.dll" INTEGER iECFHandle

*Function ECF_SetDecimaisQtd(const ecfHandle: PECFHandle; const DecimaisQtd : Integer) : Integer
DECLARE INTEGER ECF_SetDecimaisQtd IN CURDIR() + "ACBr32.dll" INTEGER iECFHandle, INTEGER iDecimaisQtd

** Métodos do componente

*Function ECF_IdentificaConsumidor(const ecfHandle: PECFHandle; const CPF_CNPJ, Nome, Endereco : pChar) : Integer
DECLARE INTEGER ECF_IdentificaConsumidor IN CURDIR() + "ACBr32.dll" INTEGER iECFHandle, STRING cCPF_CNPJ, STRING cNome, STRING cEndereco

*Function ECF_AbreCupom(const ecfHandle: PECFHandle; const CPF_CNPJ, Nome, Endereco : pChar) : Integer
DECLARE INTEGER ECF_AbreCupom IN CURDIR() + "ACBr32.dll" INTEGER iECFHandle, STRING cCPF_CNPJ, STRING cNome, STRING cEndereco

*Function ECF_LegendaInmetroProximoItem(const ecfHandle: PECFHandle) : Integer
DECLARE INTEGER ECF_LegendaInmetroProximoItem IN CURDIR() + "ACBr32.dll" INTEGER iECFHandle

*Function ECF_VendeItem(const ecfHandle: PECFHandle;
const Codigo, Descricao, AliquotaICMS : pChar;
const Qtd, ValorUnitario, DescontoPorc : Double;
const Unidade, TipoDescontoAcrescimo, DescontoAcrescimo : pChar) : Integer
DECLARE INTEGER ECF_VendeItem IN CURDIR() + "ACBr32.dll" INTEGER iECFHandle,;
	STRING cCodigo, STRING cDescricao, STRING cAliquotaICMS,;
	DOUBLE dQtd, DOUBLE dValorUnitario, DOUBLE DescontoPorc,;
	STRING cUnidade, STRING cTipoDescontoAcrescimo, STRING cDescontoAcrescimo

*Function ECF_DescontoAcrescimoItemAnterior(const ecfHandle: PECFHandle;
const ValorDescontoAcrescimo : Double; const DescontoAcrescimo : pChar) : Integer
DECLARE INTEGER ECF_DescontoAcrescimoItemAnterior IN CURDIR() + "ACBr32.dll" INTEGER iECFHandle,;
	DOUBLE dValorDescontoAcrescimo, STRING cDescontoAcrescimo

*Function ECF_SubtotalizaCupom(const ecfHandle: PECFHandle; const DescontoAcrescimo : Double ; const MensagemRodape : pChar) : Integer
DECLARE INTEGER ECF_SubtotalizaCupom IN CURDIR() + "ACBr32.dll" INTEGER iECFHandle, DOUBLE dDescontoAcrescimo, STRING cMensagemRodape

*Function ECF_EfetuaPagamento(const ecfHandle: PECFHandle; const CodFormaPagto : pChar; const Valor : Double; const Observacao : pChar ; const ImprimeVinculado : Boolean) : Integer
DECLARE INTEGER ECF_EfetuaPagamento IN CURDIR() + "ACBr32.dll" INTEGER iECFHandle, STRING cCodFormaPagto, DOUBLE dValor, STRING cObservacao, INTEGER bImprimeVinculado

*Function ECF_EstornaPagamento(const ecfHandle: PECFHandle; const CodFormaPagtoEstornar : pChar; const CodFormaPagtoEfetivar : pChar; const Valor: Double; const Observacao : pChar) : Integer
DECLARE INTEGER ECF_EstornaPagamento IN CURDIR() + "ACBr32.dll" INTEGER iECFHandle, STRING cCodFormaPagtoEstornar, STRING cCodFormaPagtoEfetivar, DOUBLE dValor, STRING cObservacao

*Function ECF_FechaCupom(const ecfHandle: PECFHandle; const Observacao : pChar) : Integer
DECLARE INTEGER ECF_FechaCupom IN CURDIR() + "ACBr32.dll" INTEGER iECFHandle, STRING cObservacao

*Function ECF_CancelaCupom(const ecfHandle: PECFHandle) : Integer
DECLARE INTEGER ECF_CancelaCupom IN CURDIR() + "ACBr32.dll" INTEGER iECFHandle

*Function ECF_CancelaItemVendido(const ecfHandle: PECFHandle; const NumItem : Integer ) : Integer
DECLARE INTEGER ECF_CancelaItemVendido IN CURDIR() + "ACBr32.dll" INTEGER iECFHandle, INTEGER iNumItem

*Function ECF_CancelaItemVendidoParcial(const ecfHandle: PECFHandle; const NumItem : Integer; const Quantidade : Double ) : Integer
DECLARE INTEGER ECF_CancelaItemVendidoParcial IN CURDIR() + "ACBr32.dll" INTEGER iECFHandle, INTEGER iNumItem

*Function ECF_CancelaDescontoAcrescimoItem(const ecfHandle: PECFHandle; const NumItem : Integer) : Integer
DECLARE INTEGER ECF_CancelaDescontoAcrescimoItem IN CURDIR() + "ACBr32.dll" INTEGER iECFHandle, INTEGER iNumItem

*Function ECF_CancelaDescontoAcrescimoSubTotal(const ecfHandle: PECFHandle; const TipoAcrescimoDesconto : Char) : Integer
DECLARE INTEGER ECF_CancelaDescontoAcrescimoSubTotal IN CURDIR() + "ACBr32.dll" INTEGER iECFHandle, STRING cTipoAcrescimoDesconto

** Relatórios

*Function ECF_LeituraX(const ecfHandle: PECFHandle) : Integer
DECLARE INTEGER ECF_LeituraX IN CURDIR() + "ACBr32.dll" INTEGER iECFHandle

*Function ECF_ReducaoZ(const ecfHandle: PECFHandle) : Integer
DECLARE INTEGER ECF_ReducaoZ IN CURDIR() + "ACBr32.dll" INTEGER iECFHandle

*Function ECF_AbreRelatorioGerencial(const ecfHandle: PECFHandle; const Indice : Integer) : Integer
DECLARE INTEGER ECF_AbreRelatorioGerencial IN CURDIR() + "ACBr32.dll" INTEGER iECFHandle, INTEGER iIndice

*Function ECF_LinhaRelatorioGerencial(const ecfHandle: PECFHandle; const Linha : pChar; const IndiceBMP : Integer) : Integer
DECLARE INTEGER ECF_LinhaRelatorioGerencial IN CURDIR() + "ACBr32.dll" INTEGER iECFHandle, STRING cLinha, INTEGER iIndiceBMP

*Function ECF_AbreCupomVinculado(const ecfHandle: PECFHandle; const COO, CodFormaPagto : pChar; const Valor : Double) : Integer ; cdecl ; overload; export
DECLARE INTEGER ECF_AbreCupomVinculado IN CURDIR() + "ACBr32.dll" INTEGER iECFHandle, STRING cCOO, STRING cCodFormaPagto, DOUBLE dValor

*Function ECF_AbreCupomVinculado(const ecfHandle: PECFHandle; const COO, CodFormaPagto, CodComprovanteNaoFiscal : pChar; const Valor : Double) : Integer ; overload
*DECLARE INTEGER ECF_AbreCupomVinculado IN curdir() + "ACBr32.dll" INTEGER iECFHandle, string cCOO, string cCodFormaPagto, string cCodComprovanteNaoFiscal, double dValor

*Function ECF_LinhaCupomVinculado(const ecfHandle: PECFHandle; const Linha : pChar) : Integer
DECLARE INTEGER ECF_LinhaCupomVinculado IN CURDIR() + "ACBr32.dll" INTEGER iECFHandle, STRING cLinha

*Function ECF_FechaRelatorio(const ecfHandle: PECFHandle) : Integer
DECLARE INTEGER ECF_FechaRelatorio IN CURDIR() + "ACBr32.dll" INTEGER iECFHandle

*Function ECF_PulaLinhas(const ecfHandle: PECFHandle; const NumLinhas : Integer) : Integer
DECLARE INTEGER ECF_PulaLinhas IN CURDIR() + "ACBr32.dll" INTEGER iECFHandle, INTEGER iNumLinhas

*Function ECF_CortaPapel(const ecfHandle: PECFHandle; const CorteParcial : Boolean) : Integer
DECLARE INTEGER ECF_CortaPapel IN CURDIR() + "ACBr32.dll" INTEGER iECFHandle, INTEGER bCorteParcial

** Alíquotas

*Function ECF_GetAliquota(const ecfHandle: PECFHandle; var retAliquota : TAliquotaRec; const index : Integer) : Integer
DECLARE INTEGER ECF_GetAliquota IN CURDIR() + "ACBr32.dll" INTEGER iECFHandle, INTEGER @iRetAliquota, INTEGER iIndex

*Function ECF_CarregaAliquotas(const ecfHandle: PECFHandle) : Integer
DECLARE INTEGER ECF_CarregaAliquotas IN CURDIR() + "ACBr32.dll" INTEGER iECFHandle

*Function ECF_GetAliquotasStr(const ecfHandle: PECFHandle; Buffer : pChar; const BufferLen : Integer) : Integer
DECLARE INTEGER ECF_GetAliquotasStr IN CURDIR() + "ACBr32.dll" INTEGER iECFHandle, STRING @cBuffer, INTEGER iBufferLen

*Function ECF_LerTotaisAliquota(const ecfHandle: PECFHandle) : Integer
DECLARE INTEGER ECF_LerTotaisAliquota IN CURDIR() + "ACBr32.dll" INTEGER iECFHandle

*Function ECF_LerTotaisAliquotaStr(const ecfHandle: PECFHandle; Buffer : pChar; const BufferLen : Integer) : Integer
DECLARE INTEGER ECF_LerTotaisAliquotaStr IN CURDIR() + "ACBr32.dll" INTEGER iECFHandle, STRING @cBuffer, INTEGER iBufferLen

*Function ECF_ProgramaAliquota(const ecfHandle: PECFHandle; const Aliquota : Double; const Tipo : Char) : Integer
DECLARE INTEGER ECF_ProgramaAliquota IN CURDIR() + "ACBr32.dll" INTEGER iECFHandle, DOUBLE dAliquota, STRING cTipo

*Function ECF_AchaIcmsAliquota(const ecfHandle: PECFHandle;  const Aliq : Double ; const Tipo : Char ; var ret_pos : pchar ) : Integer
DECLARE INTEGER ECF_AchaIcmsAliquota IN CURDIR() + "ACBr32.dll" INTEGER iECFHandle, DOUBLE dAliq, STRING cTipo, STRING @cRet_Pos

** Forma de pagamento

*Function ECF_GetFormaPagamento(const ecfHandle: PECFHandle; var retFormaPagamento : TFormaPagamentoRec; const index : Integer) : Integer
DECLARE INTEGER ECF_GetFormaPagamento IN CURDIR() + "ACBr32.dll" INTEGER iECFHandle, INTEGER @iretFormaPagamento, INTEGER iIndex

*Function ECF_CarregaFormasPagamento(const ecfHandle: PECFHandle) : Integer
DECLARE INTEGER ECF_CarregaFormasPagamento IN CURDIR() + "ACBr32.dll" INTEGER iECFHandle

*Function ECF_LerTotaisFormaPagamento(const ecfHandle: PECFHandle) : Integer
DECLARE INTEGER ECF_LerTotaisFormaPagamento IN CURDIR() + "ACBr32.dll" INTEGER iECFHandle

*Function ECF_GetFormasPagamentoStr(const ecfHandle: PECFHandle; Buffer : pChar; const BufferLen : Integer) : Integer
DECLARE INTEGER ECF_GetFormasPagamentoStr IN CURDIR() + "ACBr32.dll" INTEGER iECFHandle, STRING @cBuffer, INTEGER iBufferLen

*Function ECF_LerTotaisFormaPagamentoStr(const ecfHandle: PECFHandle; Buffer : pChar; const BufferLen : Integer) : Integer
DECLARE INTEGER ECF_LerTotaisFormaPagamentoStr IN CURDIR() + "ACBr32.dll" INTEGER iECFHandle, STRING @cBuffer, INTEGER iBufferLen

*Function ECF_ProgramaFormaPagamento(const ecfHandle: PECFHandle; const Descricao : pChar ; const PermiteVinculado : Boolean) : Integer
DECLARE INTEGER ECF_ProgramaFormaPagamento IN CURDIR() + "ACBr32.dll" INTEGER iECFHandle, STRING cDescricao, INTEGER cPermiteVinculado

** Não Fiscais

*Function ECF_GetComprovanteNaoFiscal(const ecfHandle: PECFHandle; var retComprovanteNaoFiscal : TComprovanteNaoFiscalRec; const index : Integer) : Integer
DECLARE INTEGER ECF_GetComprovanteNaoFiscal IN CURDIR() + "ACBr32.dll" INTEGER iECFHandle, INTEGER @iretComprovanteNaoFiscal, INTEGER iIndex

*Function ECF_CarregaComprovantesNaoFiscais(const ecfHandle: PECFHandle) : Integer
DECLARE INTEGER ECF_CarregaComprovantesNaoFiscais IN CURDIR() + "ACBr32.dll" INTEGER iECFHandle

*Function ECF_LerTotaisComprovanteNaoFiscal(const ecfHandle: PECFHandle) : Integer
DECLARE INTEGER ECF_LerTotaisComprovanteNaoFiscal IN CURDIR() + "ACBr32.dll" INTEGER iECFHandle

*Function ECF_ComprovantesNaoFiscais(const ecfHandle: PECFHandle; var v_ComprovantesNaoFiscais : pchar ) : Integer
DECLARE INTEGER ECF_ComprovantesNaoFiscais IN CURDIR() + "ACBr32.dll" INTEGER iECFHandle, STRING @cv_ComprovantesNaoFiscais

*Function ECF_LerTotaisComprovante(const ecfHandle: PECFHandle; var v_LerTotaisComprovante : pchar ) : Integer
DECLARE INTEGER ECF_LerTotaisComprovante IN CURDIR() + "ACBr32.dll" INTEGER iECFHandle, STRING @cv_LerTotaisComprovante

*Function ECF_ProgramaComprovanteNaoFiscal(const ecfHandle: PECFHandle; const Descricao, Tipo : pChar) : Integer
DECLARE INTEGER ECF_ProgramaComprovanteNaoFiscal IN CURDIR() + "ACBr32.dll" INTEGER iECFHandle, STRING cDescricao, STRING cTipo

*Function ECF_TestaPodeAbrirCupom(const ecfHandle: PECFHandle) : Integer
DECLARE INTEGER ECF_TestaPodeAbrirCupom IN CURDIR() + "ACBr32.dll" INTEGER iECFHandle

*Function ECF_Sangria(const ecfHandle: PECFHandle; const Valor: Double; const Obs: pChar) : Integer
DECLARE INTEGER ECF_Sangria IN CURDIR() + "ACBr32.dll" INTEGER iECFHandle, DOUBLE dValor, STRING cObs

*Function ECF_Suprimento(const ecfHandle: PECFHandle; const Valor: Double; const Obs: pChar) : Integer
DECLARE INTEGER ECF_Suprimento IN CURDIR() + "ACBr32.dll" INTEGER iECFHandle, DOUBLE dValor, STRING cObs

*Function ECF_AbreGaveta(const ecfHandle: PECFHandle) : Integer
DECLARE INTEGER ECF_AbreGaveta IN CURDIR() + "ACBr32.dll" INTEGER iECFHandle

*Function ECF_MudaHorarioVerao(const ecfHandle: PECFHandle) : Integer
DECLARE INTEGER ECF_MudaHorarioVerao IN CURDIR() + "ACBr32.dll" INTEGER iECFHandle

*Function ECF_MudaArredondamento(const ecfHandle: PECFHandle;  const Arredondar: Boolean) : Integer
DECLARE INTEGER ECF_MudaArredondamento IN CURDIR() + "ACBr32.dll" INTEGER iECFHandle, INTEGER bArredondar
