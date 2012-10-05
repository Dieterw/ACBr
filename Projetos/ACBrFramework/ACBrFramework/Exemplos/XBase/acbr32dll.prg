*Function GetUltimoErro(const handle: PHandle; Buffer : pChar; const BufferLen : Integer) : Integer
DECLARE INTEGER GetUltimoErro IN ACBr32.DLL INTEGER iHandle, STRING @cBuffer, INTEGER iBufferLen

*Function ECF_Create(var ecfHandle: PECFHandle): Integer
DECLARE INTEGER ECF_Create IN ACBr32.DLL INTEGER @iECFHandle

*Function ECF_Destroy(var ecfHandle: PECFHandle): Integer
DECLARE INTEGER ECF_Destroy IN ACBr32.DLL INTEGER @iECFHandle

*Function ECF_Ativar(const ecfHandle: PECFHandle) : Integer
DECLARE INTEGER ECF_Ativar IN ACBr32.DLL INTEGER iECFHandle

*Function ECF_Desativar(const ecfHandle: PECFHandle) : Integer
DECLARE INTEGER ECF_Desativar IN ACBr32.DLL INTEGER iECFHandle

** Funções mapeando as propriedades do componente

*Function ECF_GetModelo(const ecfHandle: PECFHandle) : Integer
DECLARE INTEGER ECF_GetModelo IN ACBr32.DLL INTEGER iECFHandle

*Function ECF_SetModelo(const ecfHandle: PECFHandle; const Modelo : Integer) : Integer
DECLARE INTEGER ECF_SetModelo IN ACBr32.DLL INTEGER iECFHandle, INTEGER iModelo

*Function ECF_GetPorta(const ecfHandle: PECFHandle; Buffer : pChar; const BufferLen : Integer) : Integer 
DECLARE INTEGER ECF_GetPorta IN ACBr32.DLL INTEGER iECFHandle, STRING @cBuffer, INTEGER iBufferLen

*Function ECF_SetPorta(const ecfHandle: PECFHandle; const Porta : pChar) : Integer
DECLARE INTEGER ECF_SetPorta IN ACBr32.DLL INTEGER iECFHandle, STRING cPorta

*Function ECF_GetTimeOut(const ecfHandle: PECFHandle) : Integer
DECLARE INTEGER ECF_GetTimeOut IN ACBr32.DLL INTEGER iECFHandle

*Function ECF_SetTimeOut(const ecfHandle: PECFHandle; const TimeOut : Integer) : Integer
DECLARE INTEGER ECF_SetTimeOut IN ACBr32.DLL INTEGER iECFHandle, INTEGER iTimeOut

*Function ECF_GetAtivo(const ecfHandle: PECFHandle) : Integer
DECLARE INTEGER ECF_GetAtivo IN ACBr32.DLL INTEGER iECFHandle

*Function ECF_GetColunas(const ecfHandle: PECFHandle) : Integer 
DECLARE INTEGER ECF_GetColunas IN ACBr32.DLL INTEGER iECFHandle

*Function ECF_GetAguardandoResposta(const ecfHandle: PECFHandle) : Integer 
DECLARE INTEGER ECF_GetAguardandoResposta IN ACBr32.DLL INTEGER iECFHandle

*Function ECF_GetComandoEnviado(const ecfHandle: PECFHandle; Buffer : pChar; const BufferLen : Integer) : Integer 
DECLARE INTEGER ECF_GetComandoEnviado IN ACBr32.DLL INTEGER iECFHandle, STRING @cBuffer, INTEGER iBufferLen

*Function ECF_GetRespostaComando(const ecfHandle: PECFHandle; Buffer : pChar; const BufferLen : Integer) : Integer 
DECLARE INTEGER ECF_GetRespostaComando IN ACBr32.DLL INTEGER iECFHandle, STRING @cBuffer, INTEGER iBufferLen

*Function ECF_GetComandoLOG(const ecfHandle: PECFHandle; Buffer : pChar; const BufferLen : Integer) : Integer 
DECLARE INTEGER ECF_GetComandoLOG IN ACBr32.DLL INTEGER iECFHandle, STRING @cBuffer, INTEGER iBufferLen

*Function ECF_SetComandoLOG(const ecfHandle: PECFHandle; const ComandoLog : pChar) : Integer 
DECLARE INTEGER ECF_SetComandoLOG IN ACBr32.DLL INTEGER iECFHandle, STRING cComandoLog

*Function ECF_GetAguardaImpressao(const ecfHandle: PECFHandle) : Integer 
DECLARE INTEGER ECF_GetAguardaImpressao IN ACBr32.DLL INTEGER iECFHandle

*Function ECF_SetAguardaImpressao(const ecfHandle: PECFHandle; const AguardaImpressao : Boolean) : Integer 
DECLARE INTEGER ECF_SetAguardaImpressao IN ACBr32.DLL INTEGER iECFHandle, STRING bAguardaImpressao

*Function ECF_GetModeloStr(const ecfHandle: PECFHandle; Buffer : pChar; const BufferLen : Integer) : Integer 
DECLARE INTEGER ECF_GetModeloStr IN ACBr32.DLL INTEGER iECFHandle, STRING @cBuffer, INTEGER iBufferLen

*Function ECF_GetRFDID(const ecfHandle: PECFHandle; Buffer : pChar; const BufferLen : Integer) : Integer 
DECLARE INTEGER ECF_GetRFDID IN ACBr32.DLL INTEGER iECFHandle, STRING @cBuffer, INTEGER iBufferLen

*Function ECF_GetDataHora(const ecfHandle: PECFHandle; var ticks : Double) : Integer 
DECLARE INTEGER ECF_GetDataHora IN ACBr32.DLL INTEGER iECFHandle, DOUBLE @dTicks

*Function ECF_GetDataHoraStr(const ecfHandle: PECFHandle; Buffer : pChar; const BufferLen : Integer) : Integer 
DECLARE INTEGER ECF_GetDataHoraStr IN ACBr32.DLL INTEGER iECFHandle, STRING @cBuffer, INTEGER iBufferLen

*Function ECF_GetNumCupom(const ecfHandle: PECFHandle; Buffer : pChar; const BufferLen : Integer) : Integer 
DECLARE INTEGER ECF_GetNumCupom IN ACBr32.DLL INTEGER iECFHandle, STRING @cBuffer, INTEGER iBufferLen

*Function ECF_GetNumCOO(const ecfHandle: PECFHandle; Buffer : pChar; const BufferLen : Integer) : Integer 
DECLARE INTEGER ECF_GetNumCOO IN ACBr32.DLL INTEGER iECFHandle, STRING @cBuffer, INTEGER iBufferLen

*Function ECF_GetNumLoja(const ecfHandle: PECFHandle; Buffer : pChar; const BufferLen : Integer) : Integer 
DECLARE INTEGER ECF_GetNumLoja IN ACBr32.DLL INTEGER iECFHandle, STRING @cBuffer, INTEGER iBufferLen

*Function ECF_GetNumECF(const ecfHandle: PECFHandle; Buffer : pChar; const BufferLen : Integer) : Integer 
DECLARE INTEGER ECF_GetNumECF IN ACBr32.DLL INTEGER iECFHandle, STRING @cBuffer, INTEGER iBufferLen

*Function ECF_GetNumSerie(const ecfHandle: PECFHandle; Buffer : pChar; const BufferLen : Integer) : Integer 
DECLARE INTEGER ECF_GetNumSerie IN ACBr32.DLL INTEGER iECFHandle, STRING @cBuffer, INTEGER iBufferLen

*Function ECF_GetNumVersao(const ecfHandle: PECFHandle; Buffer : pChar; const BufferLen : Integer) : Integer 
DECLARE INTEGER ECF_GetNumVersao IN ACBr32.DLL INTEGER iECFHandle, STRING @cBuffer, INTEGER iBufferLen

*Function ECF_GetDataMovimento(const ecfHandle: PECFHandle; var ticks : Double) : Integer 
DECLARE INTEGER ECF_GetDataMovimento IN ACBr32.DLL INTEGER iECFHandle, DOUBLE @dTicks

*Function ECF_GetDataMovimentoStr(const ecfHandle: PECFHandle; Buffer : pChar; const BufferLen : Integer) : Integer 
DECLARE INTEGER ECF_GetDataMovimentoStr IN ACBr32.DLL INTEGER iECFHandle, STRING @cBuffer, INTEGER iBufferLen

*Function ECF_GetDataHoraSB(const ecfHandle: PECFHandle; var ticks : Double) : Integer 
DECLARE INTEGER ECF_GetDataHoraSB IN ACBr32.DLL INTEGER iECFHandle, DOUBLE @dTicks

*Function ECF_GetDataHoraSBStr(const ecfHandle: PECFHandle; Buffer : pChar; const BufferLen : Integer) : Integer 
DECLARE INTEGER ECF_GetDataHoraSBStr IN ACBr32.DLL INTEGER iECFHandle, STRING @cBuffer, INTEGER iBufferLen

*Function ECF_GetCNPJ(const ecfHandle: PECFHandle; Buffer : pChar; const BufferLen : Integer) : Integer 
DECLARE INTEGER ECF_GetCNPJ IN ACBr32.DLL INTEGER iECFHandle, STRING @cBuffer, INTEGER iBufferLen

*Function ECF_GetIE(const ecfHandle: PECFHandle; Buffer : pChar; const BufferLen : Integer) : Integer 
DECLARE INTEGER ECF_GetIE IN ACBr32.DLL INTEGER iECFHandle, STRING @cBuffer, INTEGER iBufferLen

*Function ECF_GetIM(const ecfHandle: PECFHandle; Buffer : pChar; const BufferLen : Integer) : Integer 
DECLARE INTEGER ECF_GetIM IN ACBr32.DLL INTEGER iECFHandle, STRING @cBuffer, INTEGER iBufferLen

*Function ECF_GetCliche(const ecfHandle: PECFHandle; Buffer : pChar; const BufferLen : Integer) : Integer 
DECLARE INTEGER ECF_GetCliche IN ACBr32.DLL INTEGER iECFHandle, STRING @cBuffer, INTEGER iBufferLen

*Function ECF_GetUsuarioAtual(const ecfHandle: PECFHandle; Buffer : pChar; const BufferLen : Integer) : Integer ; cdecl ; expor
DECLARE INTEGER ECF_GetUsuarioAtual IN ACBr32.DLL INTEGER iECFHandle, STRING @cBuffer, INTEGER iBufferLen

*Function ECF_GetSubModeloECF(const ecfHandle: PECFHandle; Buffer : pChar; const BufferLen : Integer) : Integer 
DECLARE INTEGER ECF_GetSubModeloECF IN ACBr32.DLL INTEGER iECFHandle, STRING @cBuffer, INTEGER iBufferLen

*Function ECF_GetPAF(const ecfHandle: PECFHandle; Buffer : pChar; const BufferLen : Integer) : Integer 
DECLARE INTEGER ECF_GetSubModeloECF IN ACBr32.DLL INTEGER iECFHandle, STRING @cBuffer, INTEGER iBufferLen

*Function ECF_GetNumCRZ(const ecfHandle: PECFHandle; Buffer : pChar; const BufferLen : Integer) : Integer 
DECLARE INTEGER ECF_GetNumCRZ IN ACBr32.DLL INTEGER iECFHandle, STRING @cBuffer, INTEGER iBufferLen

*Function ECF_GetNumCRO(const ecfHandle: PECFHandle; Buffer : pChar; const BufferLen : Integer) : Integer
DECLARE INTEGER ECF_GetNumCRO IN ACBr32.DLL INTEGER iECFHandle, STRING @cBuffer, INTEGER iBufferLen

*Function ECF_GetNumCCF(const ecfHandle: PECFHandle; Buffer : pChar; const BufferLen : Integer) : Integer 
DECLARE INTEGER ECF_GetNumCCF IN ACBr32.DLL INTEGER iECFHandle, STRING @cBuffer, INTEGER iBufferLen

*Function ECF_GetNumGNF(const ecfHandle: PECFHandle; Buffer : pChar; const BufferLen : Integer) : Integer 
DECLARE INTEGER ECF_GetNumGNF IN ACBr32.DLL INTEGER iECFHandle, STRING @cBuffer, INTEGER iBufferLen

*Function ECF_GetNumGRG(const ecfHandle: PECFHandle; Buffer : pChar; const BufferLen : Integer) : Integer 
DECLARE INTEGER ECF_GetNumGRG IN ACBr32.DLL INTEGER iECFHandle, STRING @cBuffer, INTEGER iBufferLen

*Function ECF_GetNumCDC(const ecfHandle: PECFHandle; Buffer : pChar; const BufferLen : Integer) : Integer 
DECLARE INTEGER ECF_GetNumCDC IN ACBr32.DLL INTEGER iECFHandle, STRING @cBuffer, INTEGER iBufferLen

*Function ECF_GetNumCOOInicial(const ecfHandle: PECFHandle; Buffer : pChar; const BufferLen : Integer) : Integer 
DECLARE INTEGER ECF_GetNumCOOInicial IN ACBr32.DLL INTEGER iECFHandle, STRING @cBuffer, INTEGER iBufferLen

*Function ECF_GetVendaBruta(const ecfHandle: PECFHandle; var VendaBruta : Double) : Integer 
DECLARE INTEGER ECF_GetVendaBruta IN ACBr32.DLL INTEGER iECFHandle, DOUBLE @dVendaBruta

*Function ECF_GetGrandeTotal(const ecfHandle: PECFHandle; var GrandeTotal : Double ) : Integer 
DECLARE INTEGER ECF_GetGrandeTotal IN ACBr32.DLL INTEGER iECFHandle, DOUBLE @dGrandeTotal

*Function ECF_GetTotalCancelamentos(const ecfHandle: PECFHandle; var TotalCancelamentos : Double ) : Integer 
DECLARE INTEGER ECF_GetTotalCancelamentos IN ACBr32.DLL INTEGER iECFHandle, DOUBLE @dTotalCancelamentos

*Function ECF_GetTotalDescontos(const ecfHandle: PECFHandle; var TotalDescontos : Double ) : Integer 
DECLARE INTEGER ECF_GetTotalDescontos IN ACBr32.DLL INTEGER iECFHandle, DOUBLE @dTotalDescontos

*Function ECF_GetTotalAcrescimos(const ecfHandle: PECFHandle; var TotalAcrescimos : Double ) : Integer 
DECLARE INTEGER ECF_GetTotalAcrescimos IN ACBr32.DLL INTEGER iECFHandle, DOUBLE @dTotalAcrescimos

*Function ECF_GetTotalTroco(const ecfHandle: PECFHandle; var TotalTroco : Double ) : Integer 
DECLARE INTEGER ECF_GetTotalTroco IN ACBr32.DLL INTEGER iECFHandle, DOUBLE @dTotalTroco

*Function ECF_GetTotalSubstituicaoTributaria(const ecfHandle: PECFHandle; var TotalSubstituicaoTributaria : Double) : Integer 
DECLARE INTEGER ECF_GetTotalSubstituicaoTributaria IN ACBr32.DLL INTEGER iECFHandle, DOUBLE @dTotalSubstituicaoTributaria

*Function ECF_GetTotalNaoTributado(const ecfHandle: PECFHandle; var TotalNaoTributado : Double) : Integer 
DECLARE INTEGER ECF_GetTotalNaoTributado IN ACBr32.DLL INTEGER iECFHandle, DOUBLE @dTotalNaoTributado

*Function ECF_GetTotalIsencao(const ecfHandle: PECFHandle; var TotalIsencao : Double) : Integer 
DECLARE INTEGER ECF_GetTotalIsencao IN ACBr32.DLL INTEGER iECFHandle, DOUBLE @dTotalIsencao

*Function ECF_GetTotalCancelamentosISSQN(const ecfHandle: PECFHandle; var TotalCancelamentosISSQN : Double) : Integer 
DECLARE INTEGER ECF_GetTotalCancelamentosISSQN IN ACBr32.DLL INTEGER iECFHandle, DOUBLE @dTotalCancelamentosISSQN

*Function ECF_GetTotalDescontosISSQN(const ecfHandle: PECFHandle; var TotalDescontosISSQN : Double) : Integer 
DECLARE INTEGER ECF_GetTotalDescontosISSQN IN ACBr32.DLL INTEGER iECFHandle, DOUBLE @dTotalDescontosISSQN

*Function ECF_GetTotalAcrescimosISSQN(const ecfHandle: PECFHandle; var TotalAcrescimosISSQN : Double) : Integer 
DECLARE INTEGER ECF_GetTotalAcrescimosISSQN IN ACBr32.DLL INTEGER iECFHandle, DOUBLE @dTotalAcrescimosISSQN

*Function ECF_GetTotalSubstituicaoTributariaISSQN(const ecfHandle: PECFHandle; var TotalSubstituicaoTributariaISSQN : Double) : Integer 
DECLARE INTEGER ECF_GetTotalSubstituicaoTributariaISSQN IN ACBr32.DLL INTEGER iECFHandle, DOUBLE @dTotalAcrescimosISSQN

*Function ECF_GetTotalNaoTributadoISSQN(const ecfHandle: PECFHandle; var TotalNaoTributadoISSQN : Double) : Integer 
DECLARE INTEGER ECF_GetTotalNaoTributadoISSQN IN ACBr32.DLL INTEGER iECFHandle, DOUBLE @dTotalNaoTributadoISSQN

*Function ECF_GetTotalIsencaoISSQN(const ecfHandle: PECFHandle; var TotalIsencaoISSQN : Double) : Integer 
DECLARE INTEGER ECF_GetTotalIsencaoISSQN IN ACBr32.DLL INTEGER iECFHandle, DOUBLE @dTotalIsencaoISSQN

*Function ECF_GetTotalNaoFiscal(const ecfHandle: PECFHandle; var TotalNaoFiscal : Double) : Integer 
DECLARE INTEGER ECF_GetTotalNaoFiscal IN ACBr32.DLL INTEGER iECFHandle, DOUBLE @dTotalNaoFiscal

*Function ECF_GetNumUltItem(const ecfHandle: PECFHandle) : Integer 
DECLARE INTEGER ECF_GetNumUltItem IN ACBr32.DLL INTEGER iECFHandle

** ECF - Flags

*Function ECF_GetEmLinha(const ecfHandle: PECFHandle; const TimeOut : Integer) : Integer 
DECLARE INTEGER ECF_GetEmLinha IN ACBr32.DLL INTEGER iECFHandle, INTEGER iTimeOut

*Function ECF_GetPoucoPapel(const ecfHandle: PECFHandle) : Integer 
DECLARE INTEGER ECF_GetPoucoPapel IN ACBr32.DLL INTEGER iECFHandle

*Function ECF_GetEstado(const ecfHandle: PECFHandle) : Integer 
DECLARE INTEGER ECF_GetEstado IN ACBr32.DLL INTEGER iECFHandle

*Function ECF_GetHorarioVerao(const ecfHandle: PECFHandle) : Integer 
DECLARE INTEGER ECF_GetHorarioVerao IN ACBr32.DLL INTEGER iECFHandle

*Function ECF_GetArredonda(const ecfHandle: PECFHandle) : Integer 
DECLARE INTEGER ECF_GetArredonda IN ACBr32.DLL INTEGER iECFHandle

*Function ECF_GetTermica(const ecfHandle: PECFHandle) : Integer 
DECLARE INTEGER ECF_GetTermica IN ACBr32.DLL INTEGER iECFHandle

*Function ECF_GetMFD(const ecfHandle: PECFHandle) : Integer 
DECLARE INTEGER ECF_GetMFD IN ACBr32.DLL INTEGER iECFHandle

*Function ECF_GetIdentificaConsumidorRodape(const ecfHandle: PECFHandle) : Integer 
DECLARE INTEGER ECF_GetIdentificaConsumidorRodape IN ACBr32.DLL INTEGER iECFHandle

*Function ECF_GetSubTotal(const ecfHandle: PECFHandle; var SubTotal : double) : Integer 
DECLARE INTEGER ECF_GetSubTotal IN ACBr32.DLL INTEGER iECFHandle, DOUBLE @dSubTotal

*Function ECF_GetTotalPago(const ecfHandle: PECFHandle; var TotalPago : double) : Integer 
DECLARE INTEGER ECF_GetTotalPago IN ACBr32.DLL INTEGER iECFHandle, DOUBLE @dTotalPago

*Function ECF_GetGavetaAberta(const ecfHandle: PECFHandle) : Integer 
DECLARE INTEGER ECF_GetGavetaAberta IN ACBr32.DLL INTEGER iECFHandle

*Function ECF_GetChequePronto(const ecfHandle: PECFHandle) : Integer 
DECLARE INTEGER ECF_GetChequePronto IN ACBr32.DLL INTEGER iECFHandle

*Function ECF_GetIntervaloAposComando(const ecfHandle: PECFHandle) : Integer 
DECLARE INTEGER ECF_GetIntervaloAposComando IN ACBr32.DLL INTEGER iECFHandle

*Function ECF_SetIntervaloAposComando(const ecfHandle: PECFHandle; const Intervalo : Integer) : Integer 
DECLARE INTEGER ECF_SetIntervaloAposComando IN ACBr32.DLL INTEGER iECFHandle, INTEGER iIntervalo

*Function ECF_GetDescricaoGrande(const ecfHandle: PECFHandle) : Integer 
DECLARE INTEGER ECF_GetDescricaoGrande IN ACBr32.DLL INTEGER iECFHandle

*Function ECF_SetDescricaoGrande(const ecfHandle: PECFHandle; const DescricaoGrande : Boolean) : Integer 
DECLARE INTEGER ECF_SetDescricaoGrande IN ACBr32.DLL INTEGER iECFHandle, STRING bDescricaoGrande

*Function ECF_GetGavetaSinalInvertido(const ecfHandle: PECFHandle) : Integer 
DECLARE INTEGER ECF_GetGavetaSinalInvertido IN ACBr32.DLL INTEGER iECFHandle

*Function ECF_SetGavetaSinalInvertido(const ecfHandle: PECFHandle; const GavetaSinalInvertido : Boolean) : Integer 
DECLARE INTEGER ECF_SetGavetaSinalInvertido IN ACBr32.DLL INTEGER iECFHandle, STRING bGavetaSinalInvertido

*Function ECF_GetOperador(const ecfHandle: PECFHandle; Buffer : pChar; const BufferLen : Integer) : Integer 
DECLARE INTEGER ECF_GetOperador IN ACBr32.DLL INTEGER iECFHandle, STRING @cBuffer, INTEGER iBufferLen

*Function ECF_SetOperador(const ecfHandle: PECFHandle; const Operador : pChar) : Integer 
DECLARE INTEGER ECF_SetOperador IN ACBr32.DLL INTEGER iECFHandle, STRING cOperador

*Function ECF_GetLinhasEntreCupons(const ecfHandle: PECFHandle) : Integer 
DECLARE INTEGER ECF_GetLinhasEntreCupons IN ACBr32.DLL INTEGER iECFHandle

*Function ECF_SetLinhasEntreCupons(const ecfHandle: PECFHandle; const LinhasEntreCupons : Integer) : Integer 
DECLARE INTEGER ECF_SetLinhasEntreCupons IN ACBr32.DLL INTEGER iECFHandle, INTEGER iLinhasEntreCupons

*Function ECF_GetDecimaisPreco(const ecfHandle: PECFHandle) : Integer 
DECLARE INTEGER ECF_GetDecimaisPreco IN ACBr32.DLL INTEGER iECFHandle

*Function ECF_SetDecimaisPreco(const ecfHandle: PECFHandle; const DecimaisPreco : Integer) : Integer 
DECLARE INTEGER ECF_SetDecimaisPreco IN ACBr32.DLL INTEGER iECFHandle, INTEGER iDecimaisPreco

*Function ECF_GetDecimaisQtd(const ecfHandle: PECFHandle) : Integer 
DECLARE INTEGER ECF_GetDecimaisQtd IN ACBr32.DLL INTEGER iECFHandle

*Function ECF_SetDecimaisQtd(const ecfHandle: PECFHandle; const DecimaisQtd : Integer) : Integer 
DECLARE INTEGER ECF_SetDecimaisQtd IN ACBr32.DLL INTEGER iECFHandle, INTEGER iDecimaisQtd

** Métodos do componente

*Function ECF_IdentificaConsumidor(const ecfHandle: PECFHandle; const CPF_CNPJ, Nome, Endereco : pChar) : Integer 
DECLARE INTEGER ECF_IdentificaConsumidor IN ACBr32.DLL INTEGER iECFHandle, STRING cCPF_CNPJ, STRING cNome, STRING cEndereco

*Function ECF_AbreCupom(const ecfHandle: PECFHandle; const CPF_CNPJ, Nome, Endereco : pChar) : Integer
DECLARE INTEGER ECF_AbreCupom IN ACBr32.DLL INTEGER iECFHandle, STRING cCPF_CNPJ, STRING cNome, STRING cEndereco

*Function ECF_LegendaInmetroProximoItem(const ecfHandle: PECFHandle) : Integer
DECLARE INTEGER ECF_LegendaInmetroProximoItem IN ACBr32.DLL INTEGER iECFHandle

*Function ECF_VendeItem(const ecfHandle: PECFHandle;
const Codigo, Descricao, AliquotaICMS : pChar;
const Qtd, ValorUnitario, DescontoPorc : Double;
const Unidade, TipoDescontoAcrescimo, DescontoAcrescimo : pChar) : Integer 
DECLARE INTEGER ECF_VendeItem IN ACBr32.DLL INTEGER iECFHandle,;
	STRING cCodigo, STRING cDescricao, STRING cAliquotaICMS,;
	DOUBLE dQtd, DOUBLE dValorUnitario, DOUBLE DescontoPorc,;
	STRING cUnidade, STRING cTipoDescontoAcrescimo, STRING cDescontoAcrescimo

*Function ECF_DescontoAcrescimoItemAnterior(const ecfHandle: PECFHandle;
const ValorDescontoAcrescimo : Double; const DescontoAcrescimo : pChar) : Integer 
DECLARE INTEGER ECF_DescontoAcrescimoItemAnterior IN ACBr32.DLL INTEGER iECFHandle,;
	DOUBLE dValorDescontoAcrescimo, STRING cDescontoAcrescimo

*Function ECF_SubtotalizaCupom(const ecfHandle: PECFHandle; const DescontoAcrescimo : Double ; const MensagemRodape : pChar) : Integer
DECLARE INTEGER ECF_SubtotalizaCupom IN ACBr32.DLL INTEGER iECFHandle, DOUBLE dDescontoAcrescimo, STRING cMensagemRodape

*Function ECF_EfetuaPagamento(const ecfHandle: PECFHandle; const CodFormaPagto : pChar; const Valor : Double; const Observacao : pChar ; const ImprimeVinculado : Boolean) : Integer 
DECLARE INTEGER ECF_EfetuaPagamento IN ACBr32.DLL INTEGER iECFHandle, STRING cCodFormaPagto, DOUBLE dValor, STRING cObservacao, STRING bImprimeVinculado

*Function ECF_EstornaPagamento(const ecfHandle: PECFHandle; const CodFormaPagtoEstornar : pChar; const CodFormaPagtoEfetivar : pChar; const Valor: Double; const Observacao : pChar) : Integer 
DECLARE INTEGER ECF_EstornaPagamento IN ACBr32.DLL INTEGER iECFHandle, STRING cCodFormaPagtoEstornar, STRING cCodFormaPagtoEfetivar, DOUBLE dValor, STRING cObservacao

*Function ECF_FechaCupom(const ecfHandle: PECFHandle; const Observacao : pChar) : Integer 
DECLARE INTEGER ECF_FechaCupom IN ACBr32.DLL INTEGER iECFHandle, STRING cObservacao

*Function ECF_CancelaCupom(const ecfHandle: PECFHandle) : Integer 
DECLARE INTEGER ECF_CancelaCupom IN ACBr32.DLL INTEGER iECFHandle

*Function ECF_CancelaItemVendido(const ecfHandle: PECFHandle; const NumItem : Integer ) : Integer 
DECLARE INTEGER ECF_CancelaItemVendido IN ACBr32.DLL INTEGER iECFHandle, INTEGER iNumItem

*Function ECF_CancelaItemVendidoParcial(const ecfHandle: PECFHandle; const NumItem : Integer; const Quantidade : Double ) : Integer 
DECLARE INTEGER ECF_CancelaItemVendidoParcial IN ACBr32.DLL INTEGER iECFHandle, INTEGER iNumItem

*Function ECF_CancelaDescontoAcrescimoItem(const ecfHandle: PECFHandle; const NumItem : Integer) : Integer 
DECLARE INTEGER ECF_CancelaDescontoAcrescimoItem IN ACBr32.DLL INTEGER iECFHandle, INTEGER iNumItem

*Function ECF_CancelaDescontoAcrescimoSubTotal(const ecfHandle: PECFHandle; const TipoAcrescimoDesconto : Char) : Integer 
DECLARE INTEGER ECF_CancelaDescontoAcrescimoSubTotal IN ACBr32.DLL INTEGER iECFHandle, STRING cTipoAcrescimoDesconto

** Relatórios

*Function ECF_LeituraX(const ecfHandle: PECFHandle) : Integer 
DECLARE INTEGER ECF_LeituraX IN ACBr32.DLL INTEGER iECFHandle

*Function ECF_ReducaoZ(const ecfHandle: PECFHandle) : Integer 
DECLARE INTEGER ECF_ReducaoZ IN ACBr32.DLL INTEGER iECFHandle

*Function ECF_AbreRelatorioGerencial(const ecfHandle: PECFHandle; const Indice : Integer) : Integer 
DECLARE INTEGER ECF_AbreRelatorioGerencial IN ACBr32.DLL INTEGER iECFHandle, INTEGER iIndice

*Function ECF_LinhaRelatorioGerencial(const ecfHandle: PECFHandle; const Linha : pChar; const IndiceBMP : Integer) : Integer 
DECLARE INTEGER ECF_LinhaRelatorioGerencial IN ACBr32.DLL INTEGER iECFHandle, STRING cLinha, INTEGER iIndiceBMP

*Function ECF_AbreCupomVinculado(const ecfHandle: PECFHandle; const COO, CodFormaPagto : pChar; const Valor : Double) : Integer ; cdecl ; overload; export
DECLARE INTEGER ECF_AbreCupomVinculado IN ACBr32.DLL INTEGER iECFHandle, STRING cCOO, STRING cCodFormaPagto, DOUBLE dValor

*Function ECF_AbreCupomVinculado(const ecfHandle: PECFHandle; const COO, CodFormaPagto, CodComprovanteNaoFiscal : pChar; const Valor : Double) : Integer ; overload
*DECLARE INTEGER ECF_AbreCupomVinculado IN ACBr32.DLL INTEGER iECFHandle, string cCOO, string cCodFormaPagto, string cCodComprovanteNaoFiscal, double dValor

*Function ECF_LinhaCupomVinculado(const ecfHandle: PECFHandle; const Linha : pChar) : Integer 
DECLARE INTEGER ECF_LinhaCupomVinculado IN ACBr32.DLL INTEGER iECFHandle, STRING cLinha

*Function ECF_FechaRelatorio(const ecfHandle: PECFHandle) : Integer 
DECLARE INTEGER ECF_FechaRelatorio IN ACBr32.DLL INTEGER iECFHandle

*Function ECF_PulaLinhas(const ecfHandle: PECFHandle; const NumLinhas : Integer) : Integer 
DECLARE INTEGER ECF_PulaLinhas IN ACBr32.DLL INTEGER iECFHandle, INTEGER iNumLinhas

*Function ECF_CortaPapel(const ecfHandle: PECFHandle; const CorteParcial : Boolean) : Integer 
DECLARE INTEGER ECF_CortaPapel IN ACBr32.DLL INTEGER iECFHandle, INTEGER bCorteParcial

** Alíquotas

*Function ECF_GetAliquota(const ecfHandle: PECFHandle; var retAliquota : TAliquotaRec; const index : Integer) : Integer 
*DECLARE INTEGER ECF_GetAliquota IN ACBr32.DLL INTEGER iECFHandle, INTEGER @iRetAliquota, INTEGER iTAliquotaRec, INTEGER iIndex
DECLARE INTEGER ECF_GetAliquota IN ACBr32.DLL INTEGER iECFHandle, INTEGER @iRetAliquota, INTEGER iIndex

*Function ECF_CarregaAliquotas(const ecfHandle: PECFHandle) : Integer 
DECLARE INTEGER ECF_CarregaAliquotas IN ACBr32.DLL INTEGER iECFHandle

*Function ECF_GetAliquotasStr(const ecfHandle: PECFHandle; Buffer : pChar; const BufferLen : Integer) : Integer 
DECLARE INTEGER ECF_GetAliquotasStr IN ACBr32.DLL INTEGER iECFHandle, STRING @cBuffer, INTEGER iBufferLen

*Function ECF_LerTotaisAliquota(const ecfHandle: PECFHandle) : Integer 
DECLARE INTEGER ECF_LerTotaisAliquota IN ACBr32.DLL INTEGER iECFHandle

*Function ECF_LerTotaisAliquotaStr(const ecfHandle: PECFHandle; Buffer : pChar; const BufferLen : Integer) : Integer 
DECLARE INTEGER ECF_LerTotaisAliquotaStr IN ACBr32.DLL INTEGER iECFHandle, STRING @cBuffer, INTEGER iBufferLen

*Function ECF_ProgramaAliquota(const ecfHandle: PECFHandle; const Aliquota : Double; const Tipo : Char) : Integer 
DECLARE INTEGER ECF_ProgramaAliquota IN ACBr32.DLL INTEGER iECFHandle, DOUBLE dAliquota, STRING cTipo

*Function ECF_AchaIcmsAliquota(const ecfHandle: PECFHandle;  const Aliq : Double ; const Tipo : Char ; var ret_pos : pchar ) : Integer 
DECLARE INTEGER ECF_AchaIcmsAliquota IN ACBr32.DLL INTEGER iECFHandle, DOUBLE dAliq, STRING cTipo, STRING @cRet_Pos

** Forma de pagamento

*Function ECF_GetFormaPagamento(const ecfHandle: PECFHandle; var retFormaPagamento : TFormaPagamentoRec; const index : Integer) : Integer 
DECLARE INTEGER ECF_GetFormaPagamento IN ACBr32.DLL INTEGER iECFHandle, INTEGER @iretFormaPagamento, INTEGER iIndex

*Function ECF_CarregaFormasPagamento(const ecfHandle: PECFHandle) : Integer 
DECLARE INTEGER ECF_CarregaFormasPagamento IN ACBr32.DLL INTEGER iECFHandle

*Function ECF_LerTotaisFormaPagamento(const ecfHandle: PECFHandle) : Integer 
DECLARE INTEGER ECF_LerTotaisFormaPagamento IN ACBr32.DLL INTEGER iECFHandle

*Function ECF_GetFormasPagamentoStr(const ecfHandle: PECFHandle; Buffer : pChar; const BufferLen : Integer) : Integer 
DECLARE INTEGER ECF_GetFormasPagamentoStr IN ACBr32.DLL INTEGER iECFHandle, STRING @cBuffer, INTEGER iBufferLen

*Function ECF_LerTotaisFormaPagamentoStr(const ecfHandle: PECFHandle; Buffer : pChar; const BufferLen : Integer) : Integer 
DECLARE INTEGER ECF_LerTotaisFormaPagamentoStr IN ACBr32.DLL INTEGER iECFHandle, STRING @cBuffer, INTEGER iBufferLen

*Function ECF_ProgramaFormaPagamento(const ecfHandle: PECFHandle; const Descricao : pChar ; const PermiteVinculado : Boolean) : Integer 
DECLARE INTEGER ECF_ProgramaFormaPagamento IN ACBr32.DLL INTEGER iECFHandle, STRING cDescricao, STRING cPermiteVinculado

** Não Fiscais

*Function ECF_GetComprovanteNaoFiscal(const ecfHandle: PECFHandle; var retComprovanteNaoFiscal : TComprovanteNaoFiscalRec; const index : Integer) : Integer 
DECLARE INTEGER ECF_GetComprovanteNaoFiscal IN ACBr32.DLL INTEGER iECFHandle, INTEGER @iretComprovanteNaoFiscal, INTEGER iIndex

*Function ECF_CarregaComprovantesNaoFiscais(const ecfHandle: PECFHandle) : Integer 
DECLARE INTEGER ECF_CarregaComprovantesNaoFiscais IN ACBr32.DLL INTEGER iECFHandle

*Function ECF_LerTotaisComprovanteNaoFiscal(const ecfHandle: PECFHandle) : Integer 
DECLARE INTEGER ECF_LerTotaisComprovanteNaoFiscal IN ACBr32.DLL INTEGER iECFHandle

*Function ECF_ComprovantesNaoFiscais(const ecfHandle: PECFHandle; var v_ComprovantesNaoFiscais : pchar ) : Integer 
DECLARE INTEGER ECF_ComprovantesNaoFiscais IN ACBr32.DLL INTEGER iECFHandle, STRING @cv_ComprovantesNaoFiscais

*Function ECF_LerTotaisComprovante(const ecfHandle: PECFHandle; var v_LerTotaisComprovante : pchar ) : Integer 
DECLARE INTEGER ECF_LerTotaisComprovante IN ACBr32.DLL INTEGER iECFHandle, STRING @cv_LerTotaisComprovante

*Function ECF_ProgramaComprovanteNaoFiscal(const ecfHandle: PECFHandle; const Descricao, Tipo : pChar) : Integer 
DECLARE INTEGER ECF_ProgramaComprovanteNaoFiscal IN ACBr32.DLL INTEGER iECFHandle, STRING cDescricao, STRING cTipo

*Function ECF_TestaPodeAbrirCupom(const ecfHandle: PECFHandle) : Integer 
DECLARE INTEGER ECF_TestaPodeAbrirCupom IN ACBr32.DLL INTEGER iECFHandle

*Function ECF_Sangria(const ecfHandle: PECFHandle; const Valor: Double; const Obs: pChar) : Integer 
DECLARE INTEGER ECF_Sangria IN ACBr32.DLL INTEGER iECFHandle, DOUBLE dValor, STRING cObs

*Function ECF_Suprimento(const ecfHandle: PECFHandle; const Valor: Double; const Obs: pChar) : Integer 
DECLARE INTEGER ECF_Suprimento IN ACBr32.DLL INTEGER iECFHandle, DOUBLE dValor, STRING cObs

*Function ECF_AbreGaveta(const ecfHandle: PECFHandle) : Integer 
DECLARE INTEGER ECF_AbreGaveta IN ACBr32.DLL INTEGER iECFHandle

*Function ECF_MudaHorarioVerao(const ecfHandle: PECFHandle) : Integer 
DECLARE INTEGER ECF_MudaHorarioVerao IN ACBr32.DLL INTEGER iECFHandle

*Function ECF_MudaArredondamento(const ecfHandle: PECFHandle;  const Arredondar: Boolean) : Integer 
DECLARE INTEGER ECF_MudaArredondamento IN ACBr32.DLL INTEGER iECFHandle, STRING bArredondar

*Modelos de ECF
#DEFINE ECF_Nenhum 0
#DEFINE ECF_NaoFiscal 1
#DEFINE ECF_Bematech 2
#DEFINE ECF_Sweda 3
#DEFINE ECF_Daruma 4
#DEFINE ECF_Schalter 5
#DEFINE ECF_Mecaf 6
#DEFINE ECF_Yanco 7
#DEFINE ECF_DataRegis 8
#DEFINE ECF_Urano 9
#DEFINE ECF_ICash 10
#DEFINE ECF_Quattro 11
#DEFINE ECF_FiscNET 12
#DEFINE ECF_Epson 13
#DEFINE ECF_NCR 14
#DEFINE ECF_SwedaSTX 15

* ESTADOS DO ECF
#DEFINE ESTADO_NaoInicializada 0
#DEFINE ESTADO_Desconhecido 1
#DEFINE ESTADO_Livre 2
#DEFINE ESTADO_Venda 3
#DEFINE ESTADO_Pagamento 4
#DEFINE ESTADO_Relatorio 5
#DEFINE ESTADO_Bloqueada 6
#DEFINE ESTADO_RequerZ 7
#DEFINE ESTADO_RequerX 8
#DEFINE ESTADO_NaoFiscal 9

CLEAR

** Inicializa a impressora
iHandle = 0
ECF_Create(@iHandle)

ECF_SetPorta(iHandle, "COM1")
ECF_SetModelo(iHandle, ECF_Bematech)
ret = ECF_Ativar(iHandle)

* Verificando o RETORNO do ECF_Ativar
* O ideal é que esta verificação seja feita após qualquer chamada
IF ret = -1 then
msgErro = SPACE(256)
GetUltimoErro(iHandle, @msgErro, LEN(msgErro))
?msgErro
endif

INKEY(1)

** As funções abaixo retornam os valores corretos
? ECF_GetModelo(iHandle) && Retorna 4
? ECF_GetEstado(iHandle) && Retorna 2
? ECF_GetAtivo(iHandle)  && Retorna 1

INKEY(1)

** O relatório gerencial é impresso sem problemas
ECF_AbreRelatorioGerencial(iHandle, 0)
ECF_LinhaRelatorioGerencial(iHandle, "Teste 1", 0)
ECF_LinhaRelatorioGerencial(iHandle, "Teste 2", 0)

ECF_PulaLinhas(iHandle, 5)
ECF_CortaPapel(iHandle, 0);

ECF_LinhaRelatorioGerencial(iHandle, "Teste 3", 0)
ECF_LinhaRelatorioGerencial(iHandle, "Teste 4", 0)
ECF_LinhaRelatorioGerencial(iHandle, "Teste 5", 0)
ECF_FechaRelatorio(iHandle)

INKEY(1)

** Aliquotas cadastradas na impressora
** 25,00
** 18,00
** 12,00
** 07,00
** 05,00
** 17,00

** Retornando Alíquotas do ECF
aliquotas = SPACE(1024)
?ECF_CarregaAliquotas(iHandle)
?ECF_GetAliquotasStr(iHandle, @aliquotas, LEN(aliquotas))
? aliquotas

** Retornando Data/Hora do ECF
DataHora = SPACE(20)           
? ECF_GetDataHoraStr(iHandle, @DataHora, LEN(DataHora))
? DataHora 

INKEY(1)

** Retornando o número do cupom
NumCupom = SPACE(6)
? ECF_GetNumCupom(iHandle, @NumCupom, LEN(NumCupom))
? NumCupom


ECF_Desativar(iHandle)
ECF_Destroy(@iHandle)