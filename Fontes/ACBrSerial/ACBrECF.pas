{******************************************************************************}
{ Projeto: Componentes ACBr                                                    }
{  Biblioteca multiplataforma de componentes Delphi para interação com equipa- }
{ mentos de Automação Comercial utilizados no Brasil                           }
{                                                                              }
{ Direitos Autorais Reservados (c) 2004 Daniel Simoes de Almeida               }
{                                                                              }
{ Colaboradores nesse arquivo: Alexandre Rocha Lima e Marcondes                }
{                                                                              }
{  Você pode obter a última versão desse arquivo na pagina do  Projeto ACBr    }
{ Componentes localizado em      http://www.sourceforge.net/projects/acbr      }
{                                                                              }
{ Esse arquivo usa a classe  SynaSer   Copyright (c)2001-2003, Lukas Gebauer   }
{  Project : Ararat Synapse     (Found at URL: http://www.ararat.cz/synapse/)  }
{                                                                              }
{  Esta biblioteca é software livre; você pode redistribuí-la e/ou modificá-la }
{ sob os termos da Licença Pública Geral Menor do GNU conforme publicada pela  }
{ Free Software Foundation; tanto a versão 2.1 da Licença, ou (a seu critério) }
{ qualquer versão posterior.                                                   }
{                                                                              }
{  Esta biblioteca é distribuída na expectativa de que seja útil, porém, SEM   }
{ NENHUMA GARANTIA; nem mesmo a garantia implícita de COMERCIABILIDADE OU      }
{ ADEQUAÇÃO A UMA FINALIDADE ESPECÍFICA. Consulte a Licença Pública Geral Menor}
{ do GNU para mais detalhes. (Arquivo LICENÇA.TXT ou LICENSE.TXT)              }
{                                                                              }
{  Você deve ter recebido uma cópia da Licença Pública Geral Menor do GNU junto}
{ com esta biblioteca; se não, escreva para a Free Software Foundation, Inc.,  }
{ no endereço 59 Temple Street, Suite 330, Boston, MA 02111-1307 USA.          }
{ Você também pode obter uma copia da licença em:                              }
{ http://www.opensource.org/licenses/lgpl-license.php                          }
{                                                                              }
{ Daniel Simões de Almeida  -  daniel@djsystem.com.br  -  www.djsystem.com.br  }
{              Praça Anita Costa, 34 - Tatuí - SP - 18270-410                  }
{                                                                              }
{******************************************************************************}

{******************************************************************************
|* Historico
|*
|* 19/05/2004: Daniel Simoes de Almeida
|*  - Primeira Versao: Criaçao e Distribuiçao da Primeira Versao
|* 20/05/2004:  Alexandre Rocha Lima e Marcondes
|*  - Primeira Versao Multi-plataforma: Compatibilidade entre VCL e VisualCLX
|* 23/06/2004:  Daniel Simoes de Almeida
|*  - Propriedade NumVersao mudou de Integer para String para compatibilizar com
|*    alguns modelos de ECF
|*  - Propriedades renomeadas: (Melhor organizaçao visual das Propriedades)
|*    MsgTempoInicio -> TempoInicioMsg,
|*    MsgExibe       -> ExibeMensagem.
|*  - Evento OnMsgAguarde teve seu parametro modificado de:
|*    TempoRestante : Integer -> Mensagem : String
|*  - Novas Propriedades:
|*    DescricaoGrande : Boolean default false;
|*    MsgRelatorio, MsgPausaRelatorio : String;
|*    PausaRelatorio : Integer  default 5
|*    LinhasEntreCupons : Integer  default 7
|*    FormMsgColor : TColor
|*    FormMsgFonte : TFonte
|*  - Novos Metodos:
|*    RelatorioGerencial(Relatorio : TStrings; Vias : Integer = 1)
|*    AbreRelatorioGerencial
|*    LinhaRelatorioGerencial( Linha : String )
|*    CupomVinculado(COO, CodFormaPagto : String; Valor : Double
|*              Relatorio : TStrings; Vias : Integer = 1)
|*    AbreCupomVinculado(COO, CodFormaPagto : String; Valor : Double)
|*    LinhaCupomVinculado( Linha : String )
|* 30/06/2004:  Daniel Simoes de Almeida
|*  - Metodo  CorrigeEstadoErro  implementado
|* 10/06/2004:  Daniel Simoes de Almeida
|*  - Adicionada sobrecarga ao método MudaHorarioVerao.
|*    Procedure MudaHorarioVerao( EHorarioVerao : Boolean ) ;
|*    - Nesse novo método não será aberta nenhuma janela ShowModal
|* 03/05/2006:  Daniel Simoes de Almeida
|*  - Métodos LinhaRelatorioGerencial e LinhaCupomVinculado agora permitem
|*    informar várias linhas separadas por #10 ou #13+#10
|*    - Se o ECF for Térmico (MFD) e permitir informar várias linhas
|*      simultaneamente, impressão de linhas será muito mais rápida
|* 23/05/2006:  Daniel Simoes de Almeida
|*   - Adicionado método: PulaLinhas( NumLinhas : Integer = 0 ) ;
|* 29/06/2006:  Daniel Simoes de Almeida
|*   - Adicionado propriedade: GavetaSinalInvertido : Boolean default False
|* 05/07/2007:  Daniel Simoes de Almeida
|*   - Adicionado propriedade: NumCCF (necessaria para o RFD)
|*   - Adicionado o método IdentificaConsumidor
|* 05/03/2008:  Alexsander Rosa
|*   - Adicionado o método IdentificaOperador
|* 10/04/2008:  Daniel Simoes de Almeida
|*   - método IdentificaOperador ligado a propriedade Operador. Todos os
|*     modelos de ECF revisados com a possibilidade de informar o Operador
|*   - Adicionado método: CortaPapel( CorteParcial : Boolean = false) ;
|*   - Adicionado método: Sangria( const Valor: Double; Obs: String;
|*       DescricaoCNF: String = 'SANGRIA'; DescricaoFPG: String = 'DINHEIRO')
|*   - Adicionado método: Suprimento( const Valor: Double; Obs: String;
|*       DescricaoCNF: String = 'SUPRIMENTO'; DescricaoFPG: String = 'DINHEIRO')
|* 24/04/2008:  Daniel Simoes de Almeida
|*   - Metodo VendeItem modificado, adicionado parametro:
|*     DescontoAcrescimo : String = 'D' que permite definir se é Desc ou Acresc
|* 25/04/2008:  Daniel Simoes de Almeida
|*   - Adicionada a propriedade: MsgTrabalhando = "Impressora está trabalhando"
|*   - Modificado mecanismo TimeOut em LeResposta.
|*     - LeResposta detecta quando o ECF está enviando dados pela serial e com
|*     isso NAO inicia a contagem regressiva de TimeOut, e exibe o texto de
|*     "MsgTrabalhando"
|*   - Removido o texto "-- CORTE AQUI --" do método genêrico de Corte de Papel
|*     ( a VISANET (TEF) não gostou :(  )
|* 17/01/2009:  Daniel Simoes de Almeida
|*   - Modificado método AchaFPGDescricao, adicionando o parâmetro:
|*     BuscaExata : Boolean = False )
|*   - Modificado método AchaCNFDescricao, adicionando o parâmetro:
|*     BuscaExata : Boolean = False )
|* 03/02/2009:  Daniel Simoes de Almeida
|*   - Removido IfThen de algumas Units para compatibilizar com FPC 2.2.3
******************************************************************************}

{$I ACBr.inc}

Unit ACBrECF ;

interface
uses ACBrBase, ACBrDevice, ACBrECFClass, ACBrRFD, ACBrEAD,{Units da ACBr}
     SysUtils , ACBrConsts, Classes
     {$IFNDEF CONSOLE}
        {$IFDEF VisualCLX}, QControls, QForms, QDialogs, QGraphics, QStdCtrls{$ENDIF}
        {$IFDEF VCL}, Controls, Forms, Dialogs, Graphics, StdCtrls {$ENDIF}
     {$ENDIF} ;

const
   CACBrECF_Versao = '1.0.0' ;

type

{ Modelos de ECF Suportados pelo Componente TACBrECF atualmente
  Diveresos fabricantes usam o chipset da Mecaf como por exemplo:
  Elgin, Digiarte, Zanthus, Acr, Aoki, Chronos, Promcomp, TrendsSTS, Unigraph.
  Isso pode ser indentificado por alguma indicação no corpo do equipamento.
  Entretanto não há garantia de plena compatibilidade entre os diferentes
  equipamentos. (Favor reportar possiveis BUGS) }
TACBrECFModelo = (ecfNenhum, ecfNaoFiscal, ecfBematech, ecfSweda, ecfDaruma,
                  ecfSchalter, ecfMecaf, ecfYanco, ecfDataRegis, ecfUrano,
                  ecfICash, ecfQuattro, ecfFiscNET, ecfEpson, ecfNCR,
                  ecfSwedaSTX );

// fhaut - Assinatura de métodos
TACBrECFEventoOnError = procedure( var Tratado : Boolean) of object ;
TACBrECFOnAbreCupom = procedure(const CPF_CNPJ, Nome, Endereco : String ) of object ;
TACBrECFOnVendeItem = procedure(const Codigo, Descricao, AliquotaICMS : String ;
  const Qtd, ValorUnitario, ValorDescontoAcrescimo : Double;
  const Unidade, TipoDescontoAcrescimo, DescontoAcrescimo : String ) of object ;
TACBrECFOnSubtotalizaCupom = procedure( const DescontoAcrescimo: Double;
  const MensagemRodape : AnsiString ) of object ;
TACBrECFOnEfetuaPagamento = procedure( const CodFormaPagto: String;
  const Valor: Double; const Observacao: AnsiString;
  const ImprimeVinculado: Boolean ) of object ;
TACBrECFOnFechaCupom = procedure( const Observacao: AnsiString;
  const IndiceBMP : Integer) of object ;
TACBrECFOnCancelaItemVendido = procedure( const NumItem: Integer) of object ;
TACBrECFOnAbreNaoFiscal = procedure( const CPF_CNPJ: String ) of object ;
TACBrECFOnSubtotalizaNaoFiscal = procedure( const DescontoAcrescimo: Double;
  const MensagemRodape: AnsiString ) of object ;
TACBrECFOnEfetuaPagamentoNaoFiscal = procedure(const CodFormaPagto: String;
  const Valor: Double; const Observacao: AnsiString;
  const ImprimeVinculado: Boolean ) of object ;
TACBrECFOnFechaNaoFiscal = procedure( const Observacao: AnsiString;
  const IndiceBMP : Integer ) of object ;
TACBrECFOnSangria = procedure(const Valor: Double; const Obs: AnsiString;
  const DescricaoCNF, DescricaoFPG: String ) of object ;
TACBrECFOnSuprimento = procedure( const Valor: Double; const Obs: AnsiString;
  const DescricaoCNF, DescricaoFPG: String) of object ;
TACBrECFOnRelatorioGerencial = procedure( const Indice: Integer ) of object ;
TACBrECFOnErrorAbreRelatorioGerencial = procedure(var Tratado: Boolean;
  const Indice: Integer ) of object ;
TACBrECFOnChangeEstado = procedure( const EstadoAnterior, EstadoAtual :
  TACBrECFEstado ) of object ;


{ Componente ACBrECF }

{ TACBrECF }

TACBrECF = class( TACBrComponent )
  private
    fsDevice  : TACBrDevice ;   { SubComponente ACBrDevice }
    fsACBrEAD: TACBrEAD;       /// Classe usada para AssinarArquivo com assinatura EAD.

    { Propriedades do Componente ACBrECF }
    fsAtivo  : Boolean;
    fsProcurandoECF   : Boolean ;
    fsProcurandoPorta : Boolean ;
    fsModelo : TACBrECFModelo;
    fsMensagemRodape : String ;
    fsRegistrouRFDCNF : Boolean ;
    fsSubTotalPagto :Double; //lampada
    fsIndiceGerencial : Integer ;
    {$IFNDEF CONSOLE}
      fsFormMsgColor : TColor ;
      fsFormMsgFont  : TFont ;
      fsMemoOperacao : String ;
      fsMemoBobina: TMemo ;
      fsMemoParams: TStrings;
      fsOnBobinaAdicionaLinhas: TACBrECFBobinaAdicionaLinhas;
      fsMemoColunas: Integer ;
      fsMemoHTML: Boolean ;
      fsMemoHTMLTitleSise: Integer ;
      fsMemoHTMLFont: String ;
      fsMemoCabecalho, fsMemoRodape ,fsMemoCabItens, fsMemoMascItens : String ;
      fsMemoItens: Integer ;
    {$ENDIF}

    fsECF : TACBrECFClass ;  { Classe com instancia do ECF de fsModelo }
    fsRFD : TACBrRFD ;
    fsDadosReducaoZClass: TACBrECFDadosRZ; {Class com instacia para guadar dados da RZ.}
    fOnAntesAbreCupom : TACBrECFOnAbreCupom;
    fOnDepoisAbreCupom  : TACBrECFOnAbreCupom;
    fOnErrorAbreCupom  : TACBrECFEventoOnError;
    fOnAntesVendeItem : TACBrECFOnVendeItem;
    fOnDepoisVendeItem  : TACBrECFOnVendeItem;
    fOnErrorVendeItem  : TACBrECFEventoOnError;
    fOnAntesSubtotalizaCupom: TACBrECFOnSubtotalizaCupom;
    fOnDepoisSubtotalizaCupom: TACBrECFOnSubtotalizaCupom;
    fOnErrorSubtotalizaCupom: TACBrECFEventoOnError;
    fOnAntesEfetuaPagamento : TACBrECFOnEfetuaPagamento;
    fOnDepoisEfetuaPagamento  : TACBrECFOnEfetuaPagamento;
    fOnErrorEfetuaPagamento  : TACBrECFEventoOnError;
    fOnAntesFechaCupom : TACBrECFOnFechaCupom;
    fOnDepoisFechaCupom  : TACBrECFOnFechaCupom;
    fOnErrorFechaCupom  : TACBrECFEventoOnError;
    fOnAntesCancelaCupom : TNotifyEvent;
    fOnDepoisCancelaCupom  : TNotifyEvent;
    fOnErrorCancelaCupom  : TACBrECFEventoOnError;
    fOnAntesCancelaItemVendido : TACBrECFOnCancelaItemVendido;
    fOnDepoisCancelaItemVendido  : TACBrECFOnCancelaItemVendido;
    fOnErrorCancelaItemVendido  : TACBrECFEventoOnError;
    fOnAntesAbreNaoFiscal : TACBrECFOnAbreNaoFiscal;
    fOnDepoisAbreNaoFiscal  : TACBrECFOnAbreNaoFiscal;
    fOnErrorAbreNaoFiscal  : TACBrECFEventoOnError;
    fOnAntesSubtotalizaNaoFiscal : TACBrECFOnSubtotalizaNaoFiscal;
    fOnDepoisSubtotalizaNaoFiscal  : TACBrECFOnSubtotalizaNaoFiscal;
    fOnErrorSubtotalizaNaoFiscal  : TACBrECFEventoOnError;
    fOnAntesEfetuaPagamentoNaoFiscal : TACBrECFOnEfetuaPagamentoNaoFiscal;
    fOnDepoisEfetuaPagamentoNaoFiscal  : TACBrECFOnEfetuaPagamentoNaoFiscal;
    fOnErrorEfetuaPagamentoNaoFiscal  : TACBrECFEventoOnError;
    fOnAntesFechaNaoFiscal : TACBrECFOnFechaNaoFiscal;
    fOnDepoisFechaNaoFiscal  : TACBrECFOnFechaNaoFiscal;
    fOnErrorFechaNaoFiscal  : TACBrECFEventoOnError;
    fOnAntesCancelaNaoFiscal : TNotifyEvent;
    fOnDepoisCancelaNaoFiscal  : TNotifyEvent;
    fOnErrorCancelaNaoFiscal  : TACBrECFEventoOnError;
    fOnAntesSangria : TACBrECFOnSangria;
    fOnDepoisSangria  : TACBrECFOnSangria;
    fOnErrorSangria  : TACBrECFEventoOnError;
    fOnAntesSuprimento : TACBrECFOnSuprimento;
    fOnDepoisSuprimento  : TACBrECFOnSuprimento;
    fOnErrorSuprimento  : TACBrECFEventoOnError;
    fOnAntesLeituraX : TNotifyEvent;
    fOnDepoisLeituraX  : TNotifyEvent;
    fOnErrorLeituraX  : TACBrECFEventoOnError;
    fOnAntesReducaoZ : TNotifyEvent;
    fOnDepoisReducaoZ  : TNotifyEvent;
    fOnErrorReducaoZ  : TACBrECFEventoOnError;
    fOnAntesAbreRelatorioGerencial : TACBrECFOnRelatorioGerencial;
    fOnDepoisAbreRelatorioGerencial  : TACBrECFOnRelatorioGerencial;
    fOnErrorAbreRelatorioGerencial  : TACBrECFOnErrorAbreRelatorioGerencial;
    fOnAntesAbreCupomVinculado : TNotifyEvent;
    fOnDepoisAbreCupomVinculado  : TNotifyEvent;
    fOnErrorAbreCupomVinculado  : TACBrECFEventoOnError;
    fOnAntesFechaRelatorio : TNotifyEvent;
    fOnDepoisFechaRelatorio  : TNotifyEvent;
    fOnErrorFechaRelatorio  : TACBrECFEventoOnError;
    fOnChangeEstado : TACBrECFOnChangeEstado;

    fsGavetaSinalInvertido: Boolean;
    fsIdentificarOperador : Boolean;
    fsOnPAFCalcEAD: TACBrEADCalc;

    function GetArredondaItemMFD : Boolean ;
    procedure SetArredondaItemMFD(const AValue : Boolean) ;
    procedure SetAtivo(const Value: Boolean);
    procedure SetModelo(const Value: TACBrECFModelo);
    procedure SetPorta(const Value: String);
    procedure SetRetentar(const Value: Boolean);
    procedure SetTimeOut(const Value: Integer);
    procedure SetIntervaloAposComando(const Value: Integer);
    procedure SetMsgAguarde(const Value: String);
    procedure SetMsgTrabalhando(const Value: String);
    procedure SetMsgRelatorio(const Value: String);
    procedure SetPausaRelatorio(const Value: Integer);
    procedure SetTempoInicioMsg(const Value: Integer);
    procedure SetBloqueiaMouseTeclado(const Value: Boolean);
    procedure SetExibeMensagem(const Value: Boolean);
    procedure SetMsgPoucoPapel(const Value: Integer);
    procedure SetDescricaoGrande(const Value: Boolean);
    procedure SetOnMsgAguarde(const Value: TACBrECFMsgAguarde);
    procedure SetOnAguardandoRespostaChange(const Value: TNotifyEvent);
    procedure SetOnMsgPoucoPapel(const Value: TNotifyEvent);
    procedure SetOnMsgRetentar(const Value: TACBrECFMsgRetentar);

    function GetPorta: String;
    function GetRetentar: Boolean;
    function GetTimeOut: Integer;
    function GetIntervaloAposComando: Integer ;
    function GetBloqueiaMouseTeclado: Boolean;
    function GetMsgAguarde: String;
    function GetMsgTrabalhando: String;
    function GetMsgRelatorio: String;
    function GetPausaRelatorio: Integer;
    function GetExibeMensagem: Boolean;
    function GetTempoInicioMsg: Integer;
    function GetMsgPoucoPapel: Integer;
    function GetOnMsgAguarde: TACBrECFMsgAguarde;
    function GetOnAguardandoRespostaChange: TNotifyEvent;
    function GetOnMsgPoucoPapel: TNotifyEvent;
    function GetOnMsgRetentar: TACBrECFMsgRetentar;

    function GetAguardandoRespostaClass: Boolean;
    function GetColunasClass: Integer;
    function GetComandoEnviadoClass: AnsiString;
    function GetRespostaComandoClass: AnsiString;
    function GetDataHoraClass: TDateTime;
    function GetNumCupomClass: String;
    function GetNumECFClass: String;
    function GetNumSerieClass: String;
    function GetNumSerieMFDClass: String;
    function GetNumVersaoClass: String;
    function GetEstadoClass: TACBrECFEstado;
    function GetPoucoPapelClass: Boolean;
    function GetChequeProntoClass: Boolean;
    function GetGavetaAbertaClass: Boolean;
    function GetSubTotalClass: Double;
    function GetTotalPagoClass: Double;
    function GetAliquotasClass: TACBrECFAliquotas;
    function GetFormasPagamentoClass: TACBrECFFormasPagamento;
    function GetComprovantesNaoFiscaisClass : TACBrECFComprovantesNaoFiscais;
    function GetRelatoriosGerenciaisClass : TACBrECFRelatoriosGerenciais;
    function GetModeloStrClass: String;
    function GetRFDIDClass: String;
    function GetDescricaoGrande: Boolean;
    function GetMsgPausaRelatorio: String;
    procedure SetMsgPausaRelatorio(const Value: String);
    function GetLinhasEntreCupons: Integer;
    procedure SetLinhasEntreCupons(const Value: Integer);
    function GetMaxLinhasBuffer: Integer;
    procedure SetMaxLinhasBuffer(const Value: Integer);
    {$IFNDEF CONSOLE}
      procedure SetFormMsgFonte(const Value: TFont);
      procedure SetMemoBobina(const Value: TMemo);
      procedure SetMemoParams(const Value: TStrings);
      procedure MemoAdicionaLinha( Linhas : String ) ;

      Function MemoAssigned : Boolean ;
      procedure MemoAdicionaCabecalho ;
      Function MemoTraduzCode( Linha : String ) : String ;
      procedure MemoTitulo(ATitulo : String) ;
      procedure MemoSubtotaliza(DescontoAcrescimo: Double);
      procedure MemoEfetuaPagamento(Descricao: String; Valor: Double;
          Observacao: String) ;
    {$ENDIF}
    function GetOperador: String;
    procedure SetOperador(const Value: String);
    function GetHorarioVeraoClass: Boolean;
    function GetArredondaClass: Boolean;
    function GetMFDClass: Boolean;
    function GetTermicaClass: Boolean;
    function GetIdentificaConsumidorRodapeClass: Boolean;
    function GetNumLojaClass: String;
    function GetNumCROClass: String;
    function GetNumCCFClass: String;
    function GetNumGNFClass: String;
    function GetNumGRGClass: String;
    function GetNumCDCClass: String;
    function GetNumCFCClass: String;
    function GetNumGNFCClass: String;
    function GetNumCFDClass: String;
    function GetNumNCNClass: String;
    function GetNumCCDCClass: String;
    function GetArredondaPorQtd: Boolean;
    procedure SetArredondaPorQtd(const Value: Boolean);
    function GetDecimaisPreco: Integer;
    procedure SetDecimaisPreco(const Value: Integer);
    function GetDecimaisQtd: Integer;
    procedure SetDecimaisQtd(const Value: Integer);
    function GetAguardaImpressao: Boolean;
    procedure SetAguardaImpressao(const Value: Boolean);
    function GetUnidadesMedidaClass: TACBrECFUnidadesMedida;

    procedure DoAcharPorta ;

    function GetArqLOG: String;
    procedure SetArqLOG(const Value: String);
    function GetComandoLOGClass: AnsiString;
    procedure SetComandoLOGClass(const Value: AnsiString);
    function GetCNPJClass: String;
    function GetIEClass: String;
    function GetIMClass: String;  //IMS 28/09/2009
    function GetClicheClass: String;  //IMS 28/09/2009
    function GetUsuarioAtualClass: String;  //IMS 09/10/2009
    function GetDataHoraSBClass: TDateTime; //IMS 20/10/2009
    function GetSubModeloECFClass: String ; //IMS 20/10/2009

    function GetPAFClass: String;
    function GetDadosReducaoZ: AnsiString;
    function GetDadosUltimaReducaoZ: AnsiString;
    function GetDataMovimentoClass: TDateTime;
    function GetGrandeTotalClass: Double;
    function GetNumCOOInicialClass: String;
    function GetNumCRZClass: String ;
    function GetVendaBrutaClass: Double;
    function GetTotalAcrescimosClass: Double;
    function GetTotalCancelamentosClass: Double;
    function GetTotalDescontosClass: Double;
    function GetTotalTrocoClass: Double;
    function GetTotalSubstituicaoTributariaClass: Double;
    function GetTotalNaoTributadoClass: Double;
    function GetTotalIsencaoClass: Double;
    function GetTotalNaoFiscalClass: Double;
    function GetTotalAcrescimosISSQNClass: Double;
    function GetTotalCancelamentosISSQNClass: Double;
    function GetTotalDescontosISSQNClass: Double;
    function GetTotalAcrescimosOPNFClass: Double;
    function GetTotalCancelamentosOPNFClass: Double;
    function GetTotalDescontosOPNFClass: Double;
    function GetTotalIsencaoISSQNClass: Double;
    function GetTotalNaoTributadoISSQNClass: Double;
    function GetTotalSubstituicaoTributariaISSQNClass: Double;
    function GetNumUltimoItemClass: Integer;
    function GetConsumidorClass: TACBrECFConsumidor;
    function GetCodBarrasClass: TACBrECFCodBarras;
    procedure SetRFD(const Value: TACBrRFD);
    Function RFDAtivo : Boolean ;
    function GetAbout: String;
    procedure SetAbout(const Value: String);
    function GetParamDescontoISSQNClass: Boolean;
    function GetMFAdicional: String;
    function GetOnPAFGetKeyRSA: TACBrEADGetChave;
    procedure SetOnPAFGetKeyRSA(const Value: TACBrEADGetChave);
  protected
    fpUltimoEstadoObtido: TACBrECFEstado;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;

  public
    constructor Create(AOwner: TComponent); override;
    Destructor Destroy  ; override ;

    procedure Ativar ;
    procedure Desativar ;
    property Ativo : Boolean read fsAtivo write SetAtivo ;

    property ECF : TACBrECFClass read fsECF ;

    function TestarDialog : Boolean ;
    function AcharECF( ProcuraModelo: Boolean = true;
                       ProcuraPorta : Boolean = true;
                       ATimeOut : Integer = 3): Boolean ;
    function AcharPorta(ATimeOut: Integer = 3): Boolean;

    { Propriedades lidas da Classe Instanciada em fsECF }
    Property Colunas            : Integer     read GetColunasClass ;
    Property AguardandoResposta : Boolean     read GetAguardandoRespostaClass ;
    Property ComandoEnviado     : AnsiString  read GetComandoEnviadoClass ;
    Property RespostaComando    : AnsiString  read GetRespostaComandoClass ;
    property ComandoLOG         : AnsiString  read GetComandoLOGClass
       write SetComandoLOGClass ;

    Property AguardaImpressao : Boolean read GetAguardaImpressao
                 write SetAguardaImpressao ;

    { ECF - Variaveis }
    Property ModeloStr : String    read GetModeloStrClass;
    Property RFDID     : String    read GetRFDIDClass;
    Property DataHora  : TDateTime read GetDataHoraClass ;
    Property NumCupom  : String    read GetNumCupomClass ;
    Property NumCOO    : String    read GetNumCupomClass ;
    Property NumLoja   : String    read GetNumLojaClass  ;
    Property NumECF    : String    read GetNumECFClass   ;
    Property NumSerie  : String    read GetNumSerieClass ;
    Property NumSerieMFD  : String read GetNumSerieMFDClass ;
    Property NumVersao : String    read GetNumVersaoClass;

    { Dados da Reducao Z - Registro 60M }
    Property DadosReducaoZ : AnsiString  read GetDadosReducaoZ ;
    Property DadosUltimaReducaoZ : AnsiString  read GetDadosUltimaReducaoZ ;
    Property DadosReducaoZClass: TACBrECFDadosRZ read fsDadosReducaoZClass;

    { Retorna String com todos os valores no formato: Campo = Valor (1 por linha)}
    Property DataMovimento      : TDateTime  read GetDataMovimentoClass ;
    Property DataHoraSB         : TDateTime  read GetDataHoraSBClass ; //IMS 20/10/2009
    Property CNPJ               : String     read GetCNPJClass ;
    Property IE                 : String     read GetIEClass ;
    Property IM                 : String     read GetIMClass ;  //IMS 28/09/2009
    Property Cliche             : String     read GetClicheClass ;  //IMS 28/09/2009
    Property UsuarioAtual       : String     read GetUsuarioAtualClass ;  //IMS 09/10/2009
    Property SubModeloECF       : String     read GetSubModeloECFClass ; //IMS 20/10/2009
    Property MFAdicional        : String     read GetMFAdicional ;

    Property PAF                : String     read GetPAFClass ;
    Property NumCRZ             : String     read GetNumCRZClass ;
    Property NumCRO             : String     read GetNumCROClass ;
    Property NumCCF             : String     read GetNumCCFClass ;
    Property NumGNF             : String     read GetNumGNFClass ;
    Property NumGRG             : String     read GetNumGRGClass ;
    Property NumCDC             : String     read GetNumCDCClass ;
    Property NumCFC             : String     read GetNumCFCClass ;
    Property NumGNFC            : String     read GetNumGNFCClass ;
    Property NumCFD             : String     read GetNumCFDClass ;
    Property NumNCN             : String     read GetNumNCNClass ;
    Property NumCCDC            : String     read GetNumCCDCClass ;
    Property NumCOOInicial      : String     read GetNumCOOInicialClass ;
    Property VendaBruta         : Double     read GetVendaBrutaClass ;
    Property GrandeTotal        : Double     read GetGrandeTotalClass ;
    Property TotalCancelamentos : Double     read GetTotalCancelamentosClass ;
    Property TotalDescontos     : Double     read GetTotalDescontosClass ;
    Property TotalAcrescimos    : Double     read GetTotalAcrescimosClass ;
    Property TotalTroco         : Double     read GetTotalTrocoClass ;
    Property TotalSubstituicaoTributaria : Double
       read GetTotalSubstituicaoTributariaClass ;
    Property TotalNaoTributado  : Double     read GetTotalNaoTributadoClass ;
    Property TotalIsencao       : Double     read GetTotalIsencaoClass ;

    Property TotalCancelamentosISSQN          : Double read GetTotalCancelamentosISSQNClass;
    Property TotalDescontosISSQN              : Double read GetTotalDescontosISSQNClass;
    Property TotalAcrescimosISSQN             : Double read GetTotalAcrescimosISSQNClass;
    Property TotalCancelamentosOPNF           : Double read GetTotalCancelamentosOPNFClass;
    Property TotalDescontosOPNF               : Double read GetTotalDescontosOPNFClass;
    Property TotalAcrescimosOPNF              : Double read GetTotalAcrescimosOPNFClass;
    Property TotalSubstituicaoTributariaISSQN : Double read GetTotalSubstituicaoTributariaISSQNClass;
    Property TotalNaoTributadoISSQN           : Double read GetTotalNaoTributadoISSQNClass;
    Property TotalIsencaoISSQN                : Double read GetTotalIsencaoISSQNClass;

    Property TotalNaoFiscal     : Double     read GetTotalNaoFiscalClass ;
    Property NumUltItem         : Integer    read GetNumUltimoItemClass ;

    { Aliquotas de ICMS }
    Property Aliquotas : TACBrECFAliquotas read GetAliquotasClass ;
    procedure CarregaAliquotas ;
    procedure LerTotaisAliquota ;
    function AchaICMSAliquota( Aliquota : Double; Tipo : Char = ' ' ) :
       TACBrECFAliquota ;  overload ; 
    function AchaICMSAliquota( var AliquotaICMS : String ) :
       TACBrECFAliquota ;  overload ;
    function AchaICMSIndice( Indice : String ) : TACBrECFAliquota ;
    Procedure ProgramaAliquota( Aliquota : Double; Tipo : Char = 'T';
       Posicao : String = '') ;

    { Formas de Pagamento }
    Property FormasPagamento : TACBrECFFormasPagamento
                               read GetFormasPagamentoClass;
    procedure CarregaFormasPagamento ;
    procedure LerTotaisFormaPagamento ;
    function AchaFPGDescricao( Descricao : String;
       BuscaExata : Boolean = False; IgnorarCase : Boolean = True ) :
       TACBrECFFormaPagamento ;
    function AchaFPGIndice( Indice : String ) : TACBrECFFormaPagamento ;
    Procedure ProgramaFormaPagamento( var Descricao: String;
       PermiteVinculado : Boolean = true; Posicao : String = '') ;

    { Comprovantes Nao Fiscais (CNF) }
    Property ComprovantesNaoFiscais : TACBrECFComprovantesNaoFiscais
                               read GetComprovantesNaoFiscaisClass;
    procedure CarregaComprovantesNaoFiscais ;
    procedure LerTotaisComprovanteNaoFiscal ;
    function AchaCNFDescricao( Descricao : String;
       BuscaExata : Boolean = False; IgnorarCase : Boolean = True  ) :
       TACBrECFComprovanteNaoFiscal ;
    function AchaCNFIndice( Indice : String ) : TACBrECFComprovanteNaoFiscal ;
    function AchaCNFFormaPagamento( CodFPG : String ) :
       TACBrECFComprovanteNaoFiscal ;
    Procedure ProgramaComprovanteNaoFiscal( var Descricao: String;
       Tipo : String = ''; Posicao : String = '') ;

    { RelatoriosGerenciais (RG) }
    Property RelatoriosGerenciais : TACBrECFRelatoriosGerenciais
                               read GetRelatoriosGerenciaisClass;
    procedure CarregaRelatoriosGerenciais ;
    procedure LerTotaisRelatoriosGerenciais ;
    function AchaRGDescricao( Descricao : String;
       BuscaExata : Boolean = False; IgnorarCase : Boolean = True  ) :
       TACBrECFRelatorioGerencial ;
    function AchaRGIndice( Indice : String ) : TACBrECFRelatorioGerencial ;
    Procedure ProgramaRelatoriosGerenciais( var Descricao: String;
       Posicao : String = '') ;

    { Unidades de Medida (UMD) }
    Property UnidadesMedida : TACBrECFUnidadesMedida
                               read GetUnidadesMedidaClass;
    procedure CarregaUnidadesMedida ;
    function AchaUMDDescricao( Descricao : String ) : TACBrECFUnidadeMedida ;
    function AchaUMDIndice( Indice : String ) : TACBrECFUnidadeMedida ;
    Procedure ProgramaUnidadeMedida( var Descricao: String) ;

    { ECF - Flags }
    Function EmLinha( lTimeOut : Integer = 1) : Boolean ;
    Property PoucoPapel   : Boolean        read GetPoucoPapelClass ;
    Property Estado       : TACBrECFEstado read GetEstadoClass ;
    Property HorarioVerao : Boolean        read GetHorarioVeraoClass ;
    Property Arredonda    : Boolean        read GetArredondaClass ;
    Property Termica      : Boolean        read GetTermicaClass ;
    Property MFD          : Boolean        read GetMFDClass ;
    Property ParamDescontoISSQN : Boolean  read GetParamDescontoISSQNClass ;
    Property IdentificaConsumidorRodape : Boolean read GetIdentificaConsumidorRodapeClass ;

    { Procedimentos de Cupom Fiscal }
    property Consumidor : TACBrECFConsumidor read GetConsumidorClass ;
    { Grava dados do Consumidor para ser usado na Abertura ou Fechamento do Cupom }
    Procedure IdentificaConsumidor( CPF_CNPJ : String; Nome : String = '';
       Endereco : String = '') ;
    Procedure AbreCupom( CPF_CNPJ : String = ''; Nome : String = '';
       Endereco : String = '') ;
    procedure LegendaInmetroProximoItem; 
    Procedure VendeItem( Codigo, Descricao : String; AliquotaICMS : String;
       Qtd : Double ; ValorUnitario : Double; ValorDescontoAcrescimo : Double = 0;
       Unidade : String = ''; TipoDescontoAcrescimo : String = '%';
       DescontoAcrescimo : String = 'D' ) ;
    Procedure DescontoAcrescimoItemAnterior( ValorDescontoAcrescimo : Double = 0;
       DescontoAcrescimo : String = 'D' ) ;
    Procedure SubtotalizaCupom( DescontoAcrescimo : Double = 0;
       MensagemRodape : AnsiString = '') ;
    Procedure EfetuaPagamento( CodFormaPagto : String; Valor : Double;
       Observacao : AnsiString = ''; ImprimeVinculado : Boolean = false) ;
    { Para quebrar linhas nos parametros Observacao use: '|' (pipe),
       #10 ou chr(10).      Geralmente o ECF aceita no máximo 8 linhas }
    procedure EstornaPagamento(const CodFormaPagtoEstornar,
      CodFormaPagtoEfetivar : String; const Valor: Double;
      Observacao : AnsiString = '') ;
    Procedure FechaCupom( Observacao : AnsiString = ''; IndiceBMP : Integer  = 0) ;
    Procedure CancelaCupom ;
    Procedure CancelaItemVendido( NumItem : Integer ) ;
    procedure CancelaItemVendidoParcial( NumItem : Integer; Quantidade : Double);
    procedure CancelaDescontoAcrescimoItem( NumItem : Integer);
    procedure CancelaDescontoAcrescimoSubTotal(TipoAcrescimoDesconto: Char); //A -> Acrescimo D -> Desconto

    Property Subtotal  : Double read GetSubTotalClass ;
    Property TotalPago : Double read GetTotalPagoClass ;

    { Procedimentos de Cupom Não Fiscal }
    Procedure NaoFiscalCompleto( CodCNF : String; Valor : Double;
       CodFormaPagto  : String; Obs : AnsiString = ''; IndiceBMP : Integer = 0 ) ;
    Procedure AbreNaoFiscal( CPF_CNPJ : String = '') ;
    Procedure RegistraItemNaoFiscal( CodCNF : String; Valor : Double;
       Obs : AnsiString = '' ) ;
    Procedure SubtotalizaNaoFiscal( DescontoAcrescimo : Double = 0;
       MensagemRodape: AnsiString = '') ;
    Procedure EfetuaPagamentoNaoFiscal( CodFormaPagto : String; Valor : Double;
       Observacao : AnsiString = ''; ImprimeVinculado : Boolean = false) ;
    Procedure FechaNaoFiscal( Observacao : AnsiString = ''; IndiceBMP : Integer = 0) ;
    Procedure CancelaNaoFiscal ;

    procedure Sangria( const Valor: Double; Obs: AnsiString;
       DescricaoCNF: String = 'SANGRIA'; DescricaoFPG: String = 'DINHEIRO') ;
    procedure Suprimento( const Valor: Double; Obs: AnsiString;
       DescricaoCNF: String = 'SUPRIMENTO'; DescricaoFPG: String = 'DINHEIRO') ;

    { Gaveta de dinheiro }
    Procedure AbreGaveta  ;
    Property GavetaAberta : Boolean read GetGavetaAbertaClass ;

    { Relatorios }
    Procedure LeituraX ;
    Procedure LeituraXSerial( Linhas : TStringList ) ; overload ;
    Procedure LeituraXSerial( NomeArquivo : String  ); overload ;
    Procedure ReducaoZ( DataHora : TDateTime = 0 ) ;
    Procedure RelatorioGerencial(Relatorio : TStrings; const Vias : Integer = 1;
      const Indice: Integer = 0) ;
    Procedure AbreRelatorioGerencial(Indice: Integer = 0) ;
    Procedure LinhaRelatorioGerencial( const Linha : AnsiString;
      const IndiceBMP: Integer = 0 ) ;
    Procedure CupomVinculado(COO, CodFormaPagto : String; Valor : Double;
              Relatorio : TStrings; Vias : Integer = 1) ; overload ;
    Procedure CupomVinculado(COO, CodFormaPagto, CodComprovanteNaoFiscal :
       String; Valor : Double;  Relatorio : TStrings;
       Vias : Integer = 1) ; overload ;
    Procedure AbreCupomVinculado(COO, CodFormaPagto : String;
       Valor : Double) ; overload ;
    Procedure AbreCupomVinculado(COO, CodFormaPagto, CodComprovanteNaoFiscal :
       String; Valor : Double) ; overload ;
    Procedure LinhaCupomVinculado( const Linha : AnsiString ) ;
    Procedure FechaRelatorio ;
    Procedure PulaLinhas( const NumLinhas : Integer = 0 ) ;
    Procedure CortaPapel( const CorteParcial : Boolean = false) ;

    { Cheques }
    Procedure ImprimeCheque(Banco : String; Valor : Double ; Favorecido,
       Cidade : String; Data : TDateTime ;Observacao : String = '') ;
    Procedure CancelaImpressaoCheque ;
    Function LeituraCMC7 : AnsiString ; 
    Property ChequePronto : Boolean read GetChequeProntoClass ;

    { Utilitarios e Diversos }
    Procedure MudaHorarioVerao ; overload ;
    Procedure MudaHorarioVerao( EHorarioVerao : Boolean ) ; overload ;
    Procedure MudaArredondamento( Arredondar : Boolean ) ;
    Procedure PreparaTEF ; { Carrega as Formas, de Pagamento e CNF,
                             verifica por Vinculos, etc Particular de cada ECF }
    Procedure CorrigeEstadoErro( ReducaoZ: Boolean = True ) ; { Verifica o estado da impressora e
                                    tenta deixar em estado Livre }
    Procedure ImpactoAgulhas( NivelForca : Integer = 2);
    Procedure LeituraMemoriaFiscal( DataInicial, DataFinal : TDateTime;
       Simplificada : Boolean = False ) ; overload ;

    Procedure LeituraMemoriaFiscal( ReducaoInicial, ReducaoFinal : Integer;
       Simplificada : Boolean = False) ; overload ;
    Procedure LeituraMemoriaFiscalSerial( DataInicial, DataFinal : TDateTime;
       Linhas : TStringList; Simplificada : Boolean = False ) ; overload ;
    Procedure LeituraMemoriaFiscalSerial( ReducaoInicial, ReducaoFinal : Integer;
       Linhas : TStringList; Simplificada : Boolean = False ) ; overload ;
    Procedure LeituraMemoriaFiscalSerial( DataInicial, DataFinal : TDateTime;
       NomeArquivo : String; Simplificada : Boolean = False ) ; overload ;
    Procedure LeituraMemoriaFiscalSerial( ReducaoInicial, ReducaoFinal : Integer;
       NomeArquivo : String; Simplificada : Boolean = False ) ; overload ;

    procedure TestaSeE_MFD;
    Procedure LeituraMFDSerial( DataInicial, DataFinal : TDateTime;
       Linhas : TStringList; Documentos : TACBrECFTipoDocumentoSet = [docTodos]  ) ; overload ;
    Procedure LeituraMFDSerial( COOInicial, COOFinal : Integer;
       Linhas : TStringList; Documentos : TACBrECFTipoDocumentoSet = [docTodos]  ) ; overload ;
    Procedure LeituraMFDSerial( DataInicial, DataFinal : TDateTime;
       NomeArquivo : String; Documentos : TACBrECFTipoDocumentoSet = [docTodos]  ) ; overload ;
    Procedure LeituraMFDSerial( COOInicial, COOFinal : Integer;
       NomeArquivo : String; Documentos : TACBrECFTipoDocumentoSet = [docTodos]  ) ; overload ;

    Procedure EspelhoMFD_DLL( DataInicial, DataFinal : TDateTime;
       NomeArquivo : AnsiString; Documentos : TACBrECFTipoDocumentoSet = [docTodos]  ) ; overload ;
    Procedure EspelhoMFD_DLL( COOInicial, COOFinal : Integer;
       NomeArquivo : AnsiString; Documentos : TACBrECFTipoDocumentoSet = [docTodos]  ) ; overload ;
    Procedure ArquivoMFD_DLL( DataInicial, DataFinal : TDateTime;
       NomeArquivo : AnsiString; Documentos : TACBrECFTipoDocumentoSet = [docTodos];
       Finalidade: TACBrECFFinalizaArqMFD = finMFD ) ; overload ;
    Procedure ArquivoMFD_DLL( COOInicial, COOFinal : Integer;
       NomeArquivo : AnsiString; Documentos : TACBrECFTipoDocumentoSet = [docTodos];
       Finalidade: TACBrECFFinalizaArqMFD = finMFD) ; overload ;

    Procedure IdentificaOperador( Nome : String) ;
    Procedure IdentificaPAF( Linha1, Linha2 : String) ;
    Function RetornaInfoECF( Registrador : String ) : AnsiString;

    procedure ArredondarPorQtd( var Qtd: Double; const ValorUnitario: Double;
       const Precisao : Integer = -2 ) ;
       
    Function EnviaComando( cmd : AnsiString): AnsiString; overload;
    { Permitindo mudar o TimeOut padrao }
    Function EnviaComando( cmd : AnsiString; lTimeOut : Integer): AnsiString;
       overload ;

    { Gera erro se nao puder abrir Cupom, informando o motivo }
    Procedure TestaPodeAbrirCupom ;

    { Obs: De/Codifica e Verifica Textos C-->  Codifica D--> Decodifica V--> Verifica }
     //---Informação De/Codificada
     //---No Caso da opção "V" a função ira retornar:
     //--- True  se as informaçõe coicidem com os valores atuais
     //--- False se não coicidem
    function DecodificaTexto(Operacao: Char; Texto: String; var Resposta: String): Boolean;

    { Metodo para imprimir o Código de Barras em Fechamento de CF "MSG PROMO"; }
    { Não Fiscal Vinculado; Gerencial }
    property CodigodeBarras : TACBrECFCodBarras read GetCodBarrasClass ;

    { Grava dados do Código de Barras para ser usado nos Documento }
    Procedure InformaCodBarras( TipoBarra: TACBrECFTipoCodBarra; LanguraBarra,
      AlturaBarra: Integer; CodBarra: String; ImprimeCodEmbaixo: Boolean) ;

    {$IFNDEF CONSOLE}
     Procedure MemoLeParams ;
     Property MemoItens : Integer read fsMemoItens write fsMemoItens ;
    {$ENDIF}

    procedure PafMF_LX_Impressao;

    procedure PafMF_LMFC_Impressao(const CRZInicial, CRZFinal: Integer); overload;
    procedure PafMF_LMFC_Impressao(const DataInicial, DataFinal: TDateTime); overload;
    procedure PafMF_LMFC_Espelho(const CRZInicial, CRZFinal: Integer;
      const PathArquivo: String); overload;
    procedure PafMF_LMFC_Espelho(const DataInicial, DataFinal: TDateTime;
      const PathArquivo: String); overload;
    procedure PafMF_LMFC_Cotepe1704(const CRZInicial, CRZFinal: Integer;
      const PathArquivo: String); overload;
    procedure PafMF_LMFC_Cotepe1704(const DataInicial, DataFinal: TDateTime;
      const PathArquivo: String); overload;

    procedure PafMF_LMFS_Impressao(const CRZInicial, CRZFinal: Integer); overload;
    procedure PafMF_LMFS_Impressao(const DataInicial, DataFinal: TDateTime); overload;
    procedure PafMF_LMFS_Espelho(const CRZInicial, CRZFinal: Integer;
      const PathArquivo: String); overload;
    procedure PafMF_LMFS_Espelho(const DataInicial, DataFinal: TDateTime;
      const PathArquivo: String); overload;

    procedure PafMF_MFD_Espelho(const COOInicial, COOFinal: Integer;
      const PathArquivo: String); overload;
    procedure PafMF_MFD_Espelho(const DataInicial, DataFinal: TDateTime;
      const PathArquivo: String); overload;
    procedure PafMF_MFD_Cotepe1704(const COOInicial, COOFinal: Integer;
      const PathArquivo: String); overload;
    procedure PafMF_MFD_Cotepe1704(const DataInicial, DataFinal: TDateTime;
      const PathArquivo: String); overload;

    procedure PafMF_RelMeiosPagamento(
      const AFormasPagamento: TACBrECFFormasPagamento;
      const ATituloRelatorio: String = '';
      const AIndiceRelatorio: Integer = 0);

    procedure PafMF_RelDAVEmitidos(const DAVsEmitidos: TACBrECFDAVs;
      const TituloRelatorio: String = '';
      const IndiceRelatorio: Integer = 0);

    procedure PafMF_RelIdentificacaoPafECF(
      const IdentificacaoPaf: TACBrECFIdentificacaoPAF;
      const IndiceRelatorio: Integer = 0);


    function AssinaArquivoComEAD(Arquivo: String): Boolean;

  published
     property About : String read GetAbout write SetAbout stored False ;
     property Modelo : TACBrECFModelo read fsModelo write SetModelo
                 default ecfNenhum ;
     property Porta : String read GetPorta write SetPorta ;
     property ReTentar : Boolean read GetRetentar write SetRetentar
                 default true;
     property TimeOut : Integer read GetTimeOut write SetTimeOut
                 default cTimeout ;
     property IntervaloAposComando : Integer read GetIntervaloAposComando
                 write SetIntervaloAposComando default cACBrIntervaloAposComando ;
     property DescricaoGrande : Boolean read GetDescricaoGrande
                 write SetDescricaoGrande default false ;
     property GavetaSinalInvertido : Boolean read fsGavetaSinalInvertido
                 write fsGavetaSinalInvertido default false ;

     property Operador   : String read GetOperador   write SetOperador ;
     property MsgAguarde : String read GetMsgAguarde write SetMsgAguarde ;
     property MsgTrabalhando : String read GetMsgTrabalhando write SetMsgTrabalhando ;
     property ExibeMensagem : Boolean read GetExibeMensagem write SetExibeMensagem
                 default true ;
     property TempoInicioMsg : Integer read  GetTempoInicioMsg
                 write SetTempoInicioMsg default cACBrTempoInicioMsg ;
     property ArredondaPorQtd : Boolean read GetArredondaPorQtd
                 write SetArredondaPorQtd default false ;
     property ArredondaItemMFD : Boolean read GetArredondaItemMFD
                 write SetArredondaItemMFD default false ;
     property BloqueiaMouseTeclado : Boolean read  GetBloqueiaMouseTeclado
                 write SetBloqueiaMouseTeclado default true ;
     property MsgPoucoPapel : Integer read  GetMsgPoucoPapel
                 write SetMsgPoucoPapel  default cACBrMsgPoucoPapel ;
     property MsgRelatorio : String read  GetMsgRelatorio
                 write SetMsgRelatorio ;
     property PausaRelatorio : Integer read  GetPausaRelatorio
                 write SetPausaRelatorio default cACBrPausaRelatorio ;
     property MsgPausaRelatorio : String read  GetMsgPausaRelatorio
                 write SetMsgPausaRelatorio ;
     property LinhasEntreCupons : Integer read  GetLinhasEntreCupons
                 write SetLinhasEntreCupons default cACBrLinhasEntreCupons ;
     property MaxLinhasBuffer : Integer read  GetMaxLinhasBuffer
                 write SetMaxLinhasBuffer default cACBrMaxLinhasBuffer ;
    {$IFNDEF CONSOLE}
       property FormMsgFonte : TFont read  fsFormMsgFont  write SetFormMsgFonte ;
       property FormMsgColor: TColor read  fsFormMsgColor write fsFormMsgColor ;
    {$ENDIF}

     property OnMsgAguarde : TACBrECFMsgAguarde   read  GetOnMsgAguarde
                                                  write SetOnMsgAguarde ;
     property OnAguardandoRespostaChange : TNotifyEvent
        read GetOnAguardandoRespostaChange write SetOnAguardandoRespostaChange ;
     property OnMsgPoucoPapel : TNotifyEvent read  GetOnMsgPoucoPapel
                                             write SetOnMsgPoucoPapel ;
     property OnMsgRetentar : TACBrECFMsgRetentar read  GetOnMsgRetentar
                                                  write SetOnMsgRetentar ;

    // fhaut 2010-09-11
    property OnAntesAbreCupom : TACBrECFOnAbreCupom
       read FOnAntesAbreCupom write FOnAntesAbreCupom;
    property OnDepoisAbreCupom : TACBrECFOnAbreCupom
       read FOnDepoisAbreCupom write FOnDepoisAbreCupom;
    property OnErrorAbreCupom : TACBrECFEventoOnError
       read FOnErrorAbreCupom write FOnErrorAbreCupom;
    property OnAntesVendeItem : TACBrECFOnVendeItem
       read FOnAntesVendeItem write FOnAntesVendeItem;
    property OnDepoisVendeItem : TACBrECFOnVendeItem
       read FOnDepoisVendeItem write FOnDepoisVendeItem;
    property OnErrorVendeItem : TACBrECFEventoOnError
       read FOnErrorVendeItem write FOnErrorVendeItem;
    property OnAntesSubtotalizaCupom: TACBrECFOnSubtotalizaCupom
       read FOnAntesSubtotalizaCupom write FOnAntesSubtotalizaCupom;
    property OnDepoisSubtotalizaCupom: TACBrECFOnSubtotalizaCupom
       read FOnDepoisSubtotalizaCupom write FOnDepoisSubtotalizaCupom;
    property OnErrorSubtotalizaCupom: TACBrECFEventoOnError
       read FOnErrorSubtotalizaCupom write FOnErrorSubtotalizaCupom;
    property OnAntesEfetuaPagamento : TACBrECFOnEfetuaPagamento
       read FOnAntesEfetuaPagamento write FOnAntesEfetuaPagamento;
    property OnDepoisEfetuaPagamento : TACBrECFOnEfetuaPagamento
       read FOnDepoisEfetuaPagamento write FOnDepoisEfetuaPagamento;
    property OnErrorEfetuaPagamento : TACBrECFEventoOnError
       read FOnErrorEfetuaPagamento write FOnErrorEfetuaPagamento;
    property OnAntesFechaCupom : TACBrECFOnFechaCupom
       read FOnAntesFechaCupom write FOnAntesFechaCupom;
    property OnDepoisFechaCupom : TACBrECFOnFechaCupom
       read FOnDepoisFechaCupom write FOnDepoisFechaCupom;
    property OnErrorFechaCupom : TACBrECFEventoOnError
       read FOnErrorFechaCupom write FOnErrorFechaCupom;
    property OnAntesCancelaCupom : TNotifyEvent
       read FOnAntesCancelaCupom write FOnAntesCancelaCupom;
    property OnDepoisCancelaCupom : TNotifyEvent
       read FOnDepoisCancelaCupom write FOnDepoisCancelaCupom;
    property OnErrorCancelaCupom : TACBrECFEventoOnError
       read FOnErrorCancelaCupom write FOnErrorCancelaCupom;
    property OnAntesCancelaItemVendido : TACBrECFOnCancelaItemVendido
       read FOnAntesCancelaItemVendido write FOnAntesCancelaItemVendido;
    property OnDepoisCancelaItemVendido : TACBrECFOnCancelaItemVendido
       read FOnDepoisCancelaItemVendido write FOnDepoisCancelaItemVendido;
    property OnErrorCancelaItemVendido : TACBrECFEventoOnError
       read FOnErrorCancelaItemVendido write FOnErrorCancelaItemVendido;
    property OnAntesAbreNaoFiscal : TACBrECFOnAbreNaoFiscal
       read FOnAntesAbreNaoFiscal write FOnAntesAbreNaoFiscal;
    property OnDepoisAbreNaoFiscal : TACBrECFOnAbreNaoFiscal
       read FOnDepoisAbreNaoFiscal write FOnDepoisAbreNaoFiscal;
    property OnErrorAbreNaoFiscal : TACBrECFEventoOnError
       read FOnErrorAbreNaoFiscal write FOnErrorAbreNaoFiscal;
    property OnAntesSubtotalizaNaoFiscal : TACBrECFOnSubtotalizaNaoFiscal
       read FOnAntesSubtotalizaNaoFiscal write FOnAntesSubtotalizaNaoFiscal;
    property OnDepoisSubtotalizaNaoFiscal : TACBrECFOnSubtotalizaNaoFiscal
       read FOnDepoisSubtotalizaNaoFiscal write FOnDepoisSubtotalizaNaoFiscal;
    property OnErrorSubtotalizaNaoFiscal : TACBrECFEventoOnError
       read FOnErrorSubtotalizaNaoFiscal write FOnErrorSubtotalizaNaoFiscal;
    property OnAntesEfetuaPagamentoNaoFiscal : TACBrECFOnEfetuaPagamentoNaoFiscal
       read FOnAntesEfetuaPagamentoNaoFiscal write FOnAntesEfetuaPagamentoNaoFiscal;
    property OnDepoisEfetuaPagamentoNaoFiscal : TACBrECFOnEfetuaPagamentoNaoFiscal
       read FOnDepoisEfetuaPagamentoNaoFiscal write FOnDepoisEfetuaPagamentoNaoFiscal;
    property OnErrorEfetuaPagamentoNaoFiscal : TACBrECFEventoOnError
       read FOnErrorEfetuaPagamentoNaoFiscal write FOnErrorEfetuaPagamentoNaoFiscal;
    property OnAntesFechaNaoFiscal : TACBrECFOnFechaNaoFiscal
       read FOnAntesFechaNaoFiscal write FOnAntesFechaNaoFiscal;
    property OnDepoisFechaNaoFiscal : TACBrECFOnFechaNaoFiscal
       read FOnDepoisFechaNaoFiscal write FOnDepoisFechaNaoFiscal;
    property OnErrorFechaNaoFiscal : TACBrECFEventoOnError
       read FOnErrorFechaNaoFiscal write FOnErrorFechaNaoFiscal;
    property OnAntesCancelaNaoFiscal : TNotifyEvent
       read FOnAntesCancelaNaoFiscal write FOnAntesCancelaNaoFiscal;
    property OnDepoisCancelaNaoFiscal : TNotifyEvent
       read FOnDepoisCancelaNaoFiscal write FOnDepoisCancelaNaoFiscal;
    property OnErrorCancelaNaoFiscal : TACBrECFEventoOnError
       read FOnErrorCancelaNaoFiscal write FOnErrorCancelaNaoFiscal;
    property OnAntesSangria : TACBrECFOnSangria
       read FOnAntesSangria write FOnAntesSangria;
    property OnDepoisSangria : TACBrECFOnSangria
       read FOnDepoisSangria write FOnDepoisSangria;
    property OnErrorSangria : TACBrECFEventoOnError
       read FOnErrorSangria write FOnErrorSangria;
    property OnAntesSuprimento : TACBrECFOnSuprimento
       read FOnAntesSuprimento write FOnAntesSuprimento;
    property OnDepoisSuprimento : TACBrECFOnSuprimento
       read FOnDepoisSuprimento write FOnDepoisSuprimento;
    property OnErrorSuprimento : TACBrECFEventoOnError
       read FOnErrorSuprimento write FOnErrorSuprimento;
    property OnAntesLeituraX : TNotifyEvent
       read FOnAntesLeituraX write FOnAntesLeituraX;
    property OnDepoisLeituraX : TNotifyEvent
       read FOnDepoisLeituraX write FOnDepoisLeituraX;
    property OnErrorLeituraX : TACBrECFEventoOnError
       read FOnErrorLeituraX write FOnErrorLeituraX;
    property OnAntesReducaoZ : TNotifyEvent
       read FOnAntesReducaoZ write FOnAntesReducaoZ;
    property OnDepoisReducaoZ : TNotifyEvent
       read FOnDepoisReducaoZ write FOnDepoisReducaoZ;
    property OnErrorReducaoZ : TACBrECFEventoOnError
       read FOnErrorReducaoZ write FOnErrorReducaoZ;
    property OnAntesAbreRelatorioGerencial : TACBrECFOnRelatorioGerencial
       read FOnAntesAbreRelatorioGerencial write FOnAntesAbreRelatorioGerencial;
    property OnDepoisAbreRelatorioGerencial : TACBrECFOnRelatorioGerencial
       read FOnDepoisAbreRelatorioGerencial write FOnDepoisAbreRelatorioGerencial;
    property OnErrorAbreRelatorioGerencial : TACBrECFOnErrorAbreRelatorioGerencial
       read FOnErrorAbreRelatorioGerencial write FOnErrorAbreRelatorioGerencial;
    property OnAntesAbreCupomVinculado : TNotifyEvent
       read FOnAntesAbreCupomVinculado write FOnAntesAbreCupomVinculado;
    property OnDepoisAbreCupomVinculado : TNotifyEvent
       read FOnDepoisAbreCupomVinculado write FOnDepoisAbreCupomVinculado;
    property OnErrorAbreCupomVinculado : TACBrECFEventoOnError
       read FOnErrorAbreCupomVinculado write FOnErrorAbreCupomVinculado;
    property OnAntesFechaRelatorio : TNotifyEvent
       read FOnAntesFechaRelatorio write FOnAntesFechaRelatorio;
    property OnDepoisFechaRelatorio : TNotifyEvent
       read FOnDepoisFechaRelatorio write FOnDepoisFechaRelatorio;
    property OnErrorFechaRelatorio : TACBrECFEventoOnError
       read FOnErrorFechaRelatorio write FOnErrorFechaRelatorio;
    property OnChangeEstado : TACBrECFOnChangeEstado
       read FOnChangeEstado write FOnChangeEstado;
    // fim fhaut

    // eventos para assinatura de arquivos do menu fiscl
    property OnPAFCalcEAD: TACBrEADCalc
      read fsOnPAFCalcEAD write fsOnPAFCalcEAD;
    property OnPAFGetKeyRSA: TACBrEADGetChave
      read GetOnPAFGetKeyRSA write SetOnPAFGetKeyRSA;

     property DecimaisPreco : Integer read GetDecimaisPreco
        write SetDecimaisPreco default 3 ;
     property DecimaisQtd : Integer read GetDecimaisQtd
        write SetDecimaisQtd default 3 ;

    {$IFNDEF CONSOLE}
       property MemoBobina : TMemo    read fsMemoBobina write SetMemoBobina ;
       property MemoParams : TStrings read fsMemoParams write SetMemoParams ;
       property OnBobinaAdicionaLinhas : TACBrECFBobinaAdicionaLinhas
          read  fsOnBobinaAdicionaLinhas write fsOnBobinaAdicionaLinhas ;
    {$ENDIF}
     { Instancia do Componente ACBrDevice, será passada para fsECF.create }
     property Device : TACBrDevice read fsDevice ;
     property RFD    : TACBrRFD    read fsRFD write SetRFD ;
     property ArqLOG : String read GetArqLOG write SetArqLOG ;
end ;

implementation
Uses ACBrUtil, ACBrECFBematech, ACBrECFNaoFiscal, ACBrECFDaruma, ACBrECFSchalter,
     ACBrECFMecaf, ACBrECFSweda, ACBrECFDataRegis, ACBrECFUrano, ACBrECFYanco,
     ACBrECFICash, ACBrECFQuattro, ACBrECFFiscNET, ACBrECFEpson, ACBrECFNCR,
     ACBrECFSwedaSTX, {ACBrECFSCU, }
    {$IFDEF COMPILER6_UP} StrUtils {$ELSE}ACBrD5 ,Windows {$ENDIF}, Math,
    IniFiles ;

{ TACBrECF }
constructor TACBrECF.Create(AOwner: TComponent);
begin
  inherited create( AOwner );

  { Inicializando as Variaveis Internas }
  fsSubTotalPagto   := 0;//lampada
  fsIndiceGerencial := 0;
  fsAtivo           := false ;
  fsProcurandoECF   := false ;
  fsProcurandoPorta := false ;
  fsMensagemRodape  := '' ;
  fsRegistrouRFDCNF := False ;
  fsIdentificarOperador := True ;

  fsACBrEAD := TACBrEAD.Create(Self);

  { Instanciando SubComponente TACBrDevice }
  fsDevice := TACBrDevice.Create( self ) ;  { O dono é o proprio componente }
  fsDevice.Name := 'ACBrDevice' ;      { Apenas para aparecer no Object Inspector}
  {$IFDEF COMPILER6_UP}
  fsDevice.SetSubComponent( true );{ para gravar no DFM/XFM }
  {$ENDIF}
  fsDevice.Porta := 'COM1';

  {$IFNDEF CONSOLE}
    fsFormMsgFont  := TFont.create ;
    fsFormMsgColor :=  {$IFDEF VisualCLX} clNormalHighlight {$ELSE}
                                          clHighlight      {$ENDIF};
    fsMemoBobina := nil ;

    fsMemoItens     := 0 ;
    {$IFDEF MSWINDOWS}
    fsMemoHTMLFont  := '<font size="2" face="Lucida Console">' ;
    {$ELSE}
    fsMemoHTMLFont  := '<font size="5" face="Fixed">' ;
    {$ENDIF}
    fsMemoCabecalho := '' ;
    fsMemoRodape    := '' ;
    fsMemoCabItens  := '' ;
    fsMemoColunas   := 48 ;
    fsMemoHTML      := True ;
    fsMemoHTMLTitleSise:= 2 ;
                       {....+....1....+....2....+....3....+....4....+....5
                        ITEM   CODIGO     DESCRICAO
                        QTD         x UNITARIO       Aliq     VALOR (R$) }
    fsMemoMascItens := 'III CCCCCCCCCCCCC DDDDDDDDDDDDDDDDDDDDDDDDDDDDDD'+
                       'QQQQQQQQ UU x VVVVVVVVVVVVV AAAAAA TTTTTTTTTTTTT' ;
                 
    fsMemoParams := TStringList.Create ;
    fsMemoParams.Add( '[Cabecalho]' ) ;
    fsMemoParams.Add( 'LIN000=<center><b>Nome da Empresa</b></center>' ) ;
    fsMemoParams.Add( 'LIN001=<center>Nome da Rua , 1234  -  Bairro</center>' );
    fsMemoParams.Add( 'LIN002=<center>Cidade  -  UF  -  99999-999</center>' );
    fsMemoParams.Add( 'LIN003=<center>CNPJ: 01.234.567/0001-22    IE: 012.345.678.90</center>' );
    fsMemoParams.Add( 'LIN004=<table width=100%><tr><td align=left><code>Data</code> <code>Hora</code></td><td align=right>COO: <b><code>NumCupom</code></b></td></tr></table>' );
    fsMemoParams.Add( 'LIN005=<hr>' ) ;
    fsMemoParams.Add( ' ' ) ;
    fsMemoParams.Add( '[Cabecalho_Item]' );
    fsMemoParams.Add( 'LIN000=ITEM   CODIGO     DESCRICAO' ) ;
    fsMemoParams.Add( 'LIN001=QTD         x UNITARIO       Aliq     VALOR (R$)' );
    fsMemoParams.Add( 'LIN002=<hr>' ) ;
    fsMemoParams.Add( 'MascaraItem='+fsMemoMascItens );
    fsMemoParams.Add( ' ' ) ;
    fsMemoParams.Add( '[Rodape]' ) ;
    fsMemoParams.Add( 'LIN000=<hr>' ) ;
    fsMemoParams.Add( 'LIN001=<table width=100%><tr><td align=left><code>Data</code> <code>Hora</code></td><td align=right>Projeto ACBr: <b><code>ACBR</code></b></td></tr></table>' );
    fsMemoParams.Add( 'LIN002=<center>Obrigado Volte Sempre</center>' ) ;
    fsMemoParams.Add( 'LIN003=<hr>' ) ;
    fsMemoParams.Add( ' ' ) ;
    fsMemoParams.Add( '[Formato]' );
    fsMemoParams.Add( 'Colunas=48' ) ;
    fsMemoParams.Add( 'HTML=1' ) ;
    fsMemoParams.Add( 'HTML_Title_Size=2' ) ;
    fsMemoParams.Add( 'HTML_Font='+fsMemoHTMLFont ) ;
  {$ENDIF}

  { Instanciando fsECF com modelo Generico (ECFClass) }
  fsECF := TACBrECFClass.create( self ) ;

  { Instanciando fsDadosReducaoZClass para armazenar dados da redução Z}
  fsDadosReducaoZClass := TACBrECFDadosRZ.Create;
end;

destructor TACBrECF.Destroy;
begin
  Ativo := false ;

  if Assigned( fsECF ) then
     FreeAndNil( fsECF ) ;

  FreeAndNil( fsACBrEAD );
  FreeAndNil( fsDevice ) ;
  FreeAndNil( fsDadosReducaoZClass ) ;

  {$IFNDEF CONSOLE}
    fsFormMsgFont.Free ;
    fsMemoParams.Free ;
  {$ENDIF}

  inherited Destroy;
end;

procedure TACBrECF.SetModelo(const Value: TACBrECFModelo);
var wRetentar : Boolean ;   { Variaveis de Trabalho, usadas para transportar }
    wTimeOut  : Integer ;   { as informações de uma Classe ECF antiga para a }
    wMsgAguarde : String ;  { do novo modelo que será instanciada }
    wMsgTrabalhando : String ;
    wOperador   : String ;
    wMsgRelatorio : String ;
    wPausaRelatorio : Integer ;
    wLinhasEntreCupons : Integer ;
    wMaxLinhasBuffer : Integer ;
    wArredondaPorQtd : Boolean ;
    wArredondaItemMFD : Boolean ;
    wDecimaisPreco : Integer ;
    wDecimaisQtd : Integer ;
    wArqLOG : String ;
    wExibeMensagem   : Boolean ;
    wTempoInicioMsg : Integer ;
    wBloqueiaMouseTeclado : Boolean ;
    wMsgPoucoPapel : Integer ;
//  wOnMsgErro : TACBrECFExibeErroEvent ;
    wOnMsgAguarde : TACBrECFMsgAguarde ;
    wOnMsgPoucoPapel : TNotifyEvent ;
    wOnMsgRetentar : TACBrECFMsgRetentar ;
    wOnAguardandoRespostaChange : TNotifyEvent ;
    wDescricaoGrande : Boolean ;
    wIntervaloAposComando : Integer ;
begin
  if fsModelo = Value then exit ;

  if fsAtivo then
     raise Exception.Create(ACBrStr(cACBrECFSetModeloException));

  wRetentar             := ReTentar ;
  wTimeOut              := TimeOut ;
  wIntervaloAposComando := IntervaloAposComando ;
  wBloqueiaMouseTeclado := BloqueiaMouseTeclado ;
  wMsgAguarde           := MsgAguarde ;
  wMsgTrabalhando       := MsgTrabalhando ;
  wOperador             := Operador ;
  wMsgRelatorio         := MsgRelatorio ;
  wPausaRelatorio       := PausaRelatorio ;
  wLinhasEntreCupons    := LinhasEntreCupons ;
  wMaxLinhasBuffer      := MaxLinhasBuffer ;
  wArredondaPorQtd      := ArredondaPorQtd ;
  wArredondaItemMFD     := ArredondaItemMFD ;
  wDecimaisPreco        := DecimaisPreco ;
  wArqLOG               := ArqLOG ;
  wDecimaisQtd          := DecimaisQtd ;
  wExibeMensagem        := ExibeMensagem ;
  wTempoInicioMsg       := TempoInicioMsg ;
  wMsgPoucoPapel        := MsgPoucoPapel ;
//  wOnMsgErro          := OnMsgErro ;
  wOnMsgAguarde         := OnMsgAguarde ;
  wOnMsgPoucoPapel      := OnMsgPoucoPapel ;
  wOnMsgRetentar        := OnMsgRetentar ;
  wDescricaoGrande      := DescricaoGrande ;
  wOnAguardandoRespostaChange := OnAguardandoRespostaChange ;

  FreeAndNil( fsECF ) ;

  { Instanciando uma nova classe de acordo com fsModelo }
  case Value of
    ecfBematech  : fsECF := TACBrECFBematech.create( Self ) ;
    ecfDaruma    : fsECF := TACBrECFDaruma.create( Self ) ;
    ecfSchalter  : fsECF := TACBrECFSchalter.create( Self ) ;
    ecfMecaf     : fsECF := TACBrECFMecaf.create( Self ) ;
    ecfSweda     : fsECF := TACBrECFSweda.Create( self );
    ecfYanco     : fsECF := TACBrECFYanco.create( Self ) ;
    ecfDataRegis : fsECF := TACBrECFDataRegis.create( Self ) ;
    ecfUrano     : fsECF := TACBrECFUrano.create( Self ) ;
    ecfNaoFiscal : fsECF := TACBrECFNaoFiscal.create( Self ) ;
    ecfICash     : fsECF := TACBrECFICash.create( Self ) ;
    ecfQuattro   : fsECF := TACBrECFQuattro.create( Self ) ;
    ecfFiscNET   : fsECF := TACBrECFFiscNET.create( Self ) ;
    ecfEpson     : fsECF := TACBrECFEpson.create( Self ) ;
    ecfNCR       : fsECF := TACBrECFNCR.create( Self ) ;
    ecfSwedaSTX  : fsECF := TACBrECFSwedaSTX.Create( self );
  else
     fsECF := TACBrECFClass.create( Self ) ;
  end;

  { Passando propriedades da Classe anterior para a Nova Classe }
  Retentar             := wRetentar ;
  TimeOut              := wTimeOut ;
  IntervaloAposComando := wIntervaloAposComando ;
  TempoInicioMsg       := wTempoInicioMsg ;
  Operador             := wOperador ;
  MsgAguarde           := wMsgAguarde ;
  MsgTrabalhando       := wMsgTrabalhando ;
  MsgRelatorio         := wMsgRelatorio ;
  PausaRelatorio       := wPausaRelatorio ;
  LinhasEntreCupons    := wLinhasEntreCupons ;
  MaxLinhasBuffer      := wMaxLinhasBuffer ;
  ArredondaPorQtd      := wArredondaPorQtd ;
  ArredondaItemMFD     := wArredondaItemMFD ;
  DecimaisPreco        := wDecimaisPreco ;
  ArqLOG               := wArqLOG ;
  DecimaisQtd          := wDecimaisQtd ;
  ExibeMensagem        := wExibeMensagem ;
  BloqueiaMouseTeclado := wBloqueiaMouseTeclado ;
  MsgPoucoPapel        := wMsgPoucoPapel ;
//OnMsgErro            := wOnMsgErro ;
  OnMsgAguarde         := wOnMsgAguarde ;
  OnMsgPoucoPapel      := wOnMsgPoucoPapel ;
  OnMsgRetentar        := wOnMsgRetentar ;
  OnAguardandoRespostaChange := wOnAguardandoRespostaChange ;
  DescricaoGrande      := wDescricaoGrande ;

  fsModelo := Value;
end;

procedure TACBrECF.SetAtivo(const Value: Boolean);
begin
  if Value then
     Ativar
  else
     Desativar ;
end;

procedure TACBrECF.Ativar;
begin
  if fsAtivo then exit ;

  if fsModelo = ecfNenhum then
     raise Exception.Create(ACBrStr('Modelo não definido'));

  if ((Porta = '') or (LowerCase(Porta) = 'procurar')) then
     AcharPorta ;

  ComandoLOG := DateToStr(now)+ ' Ativar' ;
  fsECF.Ativar ;
  fsAtivo := true ;

  //Se o ecf foi desligado durante o cupom, continua do ultimo
  if (Estado in [estVenda, estPagamento]) then
  begin
     {$IFNDEF CONSOLE}
     fsMemoItens     := NumUltItem;
     {$ENDIF}
     fsSubTotalPagto := Subtotal;
  end;

  {$IFNDEF CONSOLE}
   if MemoAssigned then
   begin
      MemoLeParams ;
   end ;
  {$ENDIF}

  if Assigned( fsRFD ) then
  begin
     if (Modelo <> ecfNaoFiscal) and ( not (MFD and fsRFD.IgnoraEcfMfd)) then
     begin
        try
           fsRFD.Ativar ;
        except
           Desativar ;
           raise ;
        end ;
     end ;
  end ;

  if fsIdentificarOperador then
  begin
     try
        IdentificaOperador(Operador);
     except
     end ;
  end ;
end;

procedure TACBrECF.Desativar;
begin
  if not fsAtivo then exit ;

  ComandoLOG := DateToStr(now)+ ' Desativar' ;
  fsECF.Desativar ;
  fsAtivo := false;

  if RFDAtivo then
     fsRFD.Desativar ;
end;

function TACBrECF.GetPorta: String;
begin
  result := fsDevice.Porta ;
end;

procedure TACBrECF.SetPorta(const Value: String);
begin
  fsDevice.Porta := Value ;
end;

function TACBrECF.GetRetentar: Boolean;
begin
  result := fsECF.Retentar ;
end;

procedure TACBrECF.SetRetentar(const Value: Boolean);
begin
   fsECF.Retentar := Value ;
end;

function TACBrECF.GetTimeOut: Integer;
begin
  Result := fsDevice.TimeOut ;
end;

procedure TACBrECF.SetTimeOut(const Value: Integer);
begin
   fsDevice.TimeOut := Value ;
end;

function TACBrECF.GetIntervaloAposComando: Integer;
begin
  Result := fsECF.IntervaloAposComando ;
end;

procedure TACBrECF.SetIntervaloAposComando(const Value: Integer);
begin
  fsECF.IntervaloAposComando := Value ;
end;

function TACBrECF.GetOperador: String;
begin
  Result := fsECF.Operador ;
end;

procedure TACBrECF.SetOperador(const Value: String);
begin
  if Operador = Value then exit ;

  fsECF.Operador := Value ;
  fsIdentificarOperador := True ;
end;

function TACBrECF.GetMsgAguarde: String;
begin
  Result := fsECF.MsgAguarde ;
end;

procedure TACBrECF.SetMsgAguarde(const Value: String);
begin
  fsECF.MsgAguarde := Value ;
end;

function TACBrECF.GetMsgTrabalhando: String;
begin
  Result := fsECF.MsgTrabalhando
end;

procedure TACBrECF.SetMsgTrabalhando(const Value: String);
begin
  fsECF.MsgTrabalhando := Value ;
end;

function TACBrECF.GetMsgRelatorio: String;
begin
  result := fsECF.MsgRelatorio ;
end;

procedure TACBrECF.SetMsgRelatorio(const Value: String);
begin
  fsECF.MsgRelatorio := Value ;
end;

function TACBrECF.GetPausaRelatorio: Integer;
begin
  result := fsECF.PausaRelatorio ;
end;

procedure TACBrECF.SetPausaRelatorio(const Value: Integer);
begin
  fsECF.PausaRelatorio := Value ;
end;

function TACBrECF.GetLinhasEntreCupons: Integer;
begin
  result := fsECF.LinhasEntreCupons ;
end;

procedure TACBrECF.SetLinhasEntreCupons(const Value: Integer);
begin
  fsECF.LinhasEntreCupons := Value ;
end;

function TACBrECF.GetMaxLinhasBuffer: Integer;
begin
  result := fsECF.MaxLinhasBuffer ;
end;

procedure TACBrECF.SetMaxLinhasBuffer(const Value: Integer);
begin
  fsECF.MaxLinhasBuffer := Value ;
end;

function TACBrECF.GetMsgPausaRelatorio: String;
begin
  result := fsECF.MsgPausaRelatorio ;
end;

procedure TACBrECF.SetMsgPausaRelatorio(const Value: String);
begin
  fsECF.MsgPausaRelatorio := Value ;
end;

function TACBrECF.GetTempoInicioMsg: Integer;
begin
  Result := fsECF.TempoInicioMsg ;
end;

procedure TACBrECF.SetTempoInicioMsg(const Value: Integer);
begin
  if Value > TimeOut then
     fsECF.TempoInicioMsg := TimeOut
  else
     fsECF.TempoInicioMsg := Value ;
end;

function TACBrECF.GetArredondaPorQtd: Boolean;
begin
  Result := fsECF.ArredondaPorQtd ;
end;

procedure TACBrECF.SetArredondaPorQtd(const Value: Boolean);
begin
  fsECF.ArredondaPorQtd := Value ;
end;

function TACBrECF.GetArredondaItemMFD : Boolean ;
begin
  Result := fsECF.ArredondaItemMFD;
end;

procedure TACBrECF.SetArredondaItemMFD(const AValue : Boolean) ;
begin
  fsECF.ArredondaItemMFD := AValue;
end;

function TACBrECF.GetDecimaisPreco: Integer;
begin
  Result := fsECF.DecimaisPreco ;
end;

procedure TACBrECF.SetDecimaisPreco(const Value: Integer);
begin
  if (Value < 0) or (Value > 3) then
     raise Exception.Create(ACBrStr(cACBrECFSetDecimaisPrecoException));

  fsECF.DecimaisPreco := Value ;
end;

function TACBrECF.GetDecimaisQtd: Integer;
begin
  Result := fsECF.DecimaisQtd ;
end;

procedure TACBrECF.SetDecimaisQtd(const Value: Integer);
begin
  if (Value < 0) or (Value > 4) then
     raise Exception.Create(ACBrStr(cACBrECFSetDecimaisQtdException));

  fsECF.DecimaisQtd := Value ;
end;

function TACBrECF.GetArqLOG: String;
begin
  Result := fsECF.ArqLOG ;
end;

procedure TACBrECF.SetArqLOG(const Value: String);
begin
  fsECF.ArqLOG := Value ;
end;

function TACBrECF.GetAguardaImpressao: Boolean;
begin
  Result := fsECF.AguardaImpressao ;
end;

procedure TACBrECF.SetAguardaImpressao(const Value: Boolean);
begin
  fsECF.AguardaImpressao := Value ;
end;

function TACBrECF.GetExibeMensagem: Boolean;
begin
  Result := fsECF.ExibeMensagem ;
end;

procedure TACBrECF.SetExibeMensagem(const Value: Boolean);
begin
  fsECF.ExibeMensagem := Value;
end;

function TACBrECF.GetBloqueiaMouseTeclado: Boolean;
begin
  Result := fsECf.BloqueiaMouseTeclado ;
end;

procedure TACBrECF.SetBloqueiaMouseTeclado(const Value: Boolean);
begin
  fsECF.BloqueiaMouseTeclado := Value;
end;

function TACBrECF.GetMsgPoucoPapel: Integer;
begin
  Result := fsECf.MsgPoucoPapel ;
end;

procedure TACBrECF.SetMsgPoucoPapel(const Value: Integer);
begin
  fsECF.MsgPoucoPapel := Value;
end;

function TACBrECF.GetParamDescontoISSQNClass: Boolean;
begin
  ComandoLOG := 'ParamDescontoISSQNClass' ;
  Result := fsECF.ParamDescontoISSQN ;
end;

function TACBrECF.GetDescricaoGrande: Boolean;
begin
  Result := fsECF.DescricaoGrande ;
end;

procedure TACBrECF.SetDescricaoGrande(const Value: Boolean);
begin
  fsECF.DescricaoGrande := Value ;
end;

{$IFNDEF CONSOLE}
  procedure TACBrECF.SetFormMsgFonte(const Value: TFont);
  begin
    fsFormMsgFont.Assign( Value ) ;
  end;
{$ENDIF}

function TACBrECF.GetOnMsgAguarde: TACBrECFMsgAguarde;
begin
  Result := fsECF.OnMsgAguarde ;
end;

procedure TACBrECF.SetOnMsgAguarde(const Value: TACBrECFMsgAguarde);
begin
  fsECF.OnMsgAguarde := Value ;
end;

function TACBrECF.GetOnMsgPoucoPapel: TNotifyEvent;
begin
  Result := fsECF.OnMsgPoucoPapel ;
end;

procedure TACBrECF.SetOnMsgPoucoPapel(const Value: TNotifyEvent);
begin
  fsECF.OnMsgPoucoPapel := Value ;
end;

function TACBrECF.GetOnMsgRetentar: TACBrECFMsgRetentar;
begin
  Result := fsECF.OnMsgRetentar ;
end;

function TACBrECF.GetOnPAFGetKeyRSA: TACBrEADGetChave;
begin
  Result := fsACBrEAD.OnGetChavePrivada;
end;

procedure TACBrECF.SetOnMsgRetentar(const Value: TACBrECFMsgRetentar);
begin
  fsECF.OnMsgRetentar := Value ;
end;

procedure TACBrECF.SetOnPAFGetKeyRSA(const Value: TACBrEADGetChave);
begin
  fsACBrEAD.OnGetChavePrivada := Value;
end;

procedure TACBrECF.SetOnAguardandoRespostaChange( const Value: TNotifyEvent);
begin
  fsECF.OnAguardandoRespostaChange := Value ;
end;

function TACBrECF.GetOnAguardandoRespostaChange: TNotifyEvent;
begin
  Result := fsECF.OnAguardandoRespostaChange ;
end;

{function TACBrECF.GetOnMsgErro: TACBrECFExibeErroEvent;
begin
  Result := fsECF.OnMsgErro ;
end;

procedure TACBrECF.SetOnMsgErro(const Value: TACBrECFExibeErroEvent);
begin
  fsECF.OnMsgErro := Value ;
end;}

function TACBrECF.TestarDialog: Boolean;
var wAtivo : Boolean ;
    wNumSerie, wNumECF, wStrDate : String ;
    WDataHora : TDateTime ;
    Msg : String ;
begin
  wAtivo := Ativo ;

  try
     if not Ativo then
        Ativo := true ;

     wNumSerie := NumSerie ;
     wNumECF   := NumECF ;
     WDataHora := DataHora ;
     DateTimeToString(wStrDate,'dd/mm/yyyy hh:nn:ss ', wDataHora) ;

     Msg := 'Impressora: '+fsECF.ModeloStr + sLineBreak +
            'Versão: '+NumVersao + sLineBreak +
            'Colunas: '+IntToStr(Colunas)+ sLineBreak + sLineBreak +
            'Numero de Serie: '+wNumSerie+ sLineBreak +
            'Numero do ECF: '+wNumECF+ sLineBreak +
            'Data / Hora: '+wStrDate ;

     Msg := ACBrStr(Msg);
     {$IFNDEF CONSOLE}
       MessageDlg(Msg, mtInformation ,[mbOk],0) ;
     {$ELSE}
       writeln( Msg ) ;
     {$ENDIF}
  finally
     Result := Ativo ;
     Ativo := wAtivo ;
  end ;
end;

function TACBrECF.GetAguardandoRespostaClass: Boolean;
begin
  Result := fsECF.AguardandoResposta ;
end;

function TACBrECF.GetColunasClass: Integer;
begin
  Result := fsECF.Colunas ;
end;

function TACBrECF.GetComandoEnviadoClass: AnsiString;
begin
  Result := fsECF.ComandoEnviado ;
end;

function TACBrECF.GetRespostaComandoClass: AnsiString;
begin
  Result := fsECF.RespostaComando ;
end;

function TACBrECF.GetComandoLOGClass: AnsiString;
begin
  Result := fsECF.ComandoLOG ;
end;

procedure TACBrECF.SetComandoLOGClass(const Value: AnsiString);
begin
  fsECF.ComandoLOG := Value ;
  fsECF.ComandoEnviado  := '' ;
  fsECF.RespostaComando := '' ;
end;

function TACBrECF.GetModeloStrClass: String;
begin
  Result := ACBrStr( fsECF.ModeloStr );
end;

function TACBrECF.GetRFDIDClass: String;
begin
  Result := fsECF.RFDID ;
end;

function TACBrECF.GetDataHoraClass: TDateTime;
begin
  ComandoLOG := 'DataHora' ;
  Result := fsECF.DataHora ;
end;

function TACBrECF.GetNumCupomClass: String;
begin
  ComandoLOG := 'NumCupom' ;
  Result := fsECF.NumCupom ;
end;

function TACBrECF.GetNumECFClass: String;
begin
  ComandoLOG := 'NumECF' ;
  Result := fsECF.NumECF ;
end;

function TACBrECF.GetNumCROClass: String;
begin
  ComandoLOG := 'NumCRO' ;
  Result := fsECF.NumCRO ;
end;

function TACBrECF.GetNumCCFClass: String;
begin
  ComandoLOG := 'NumCCF' ;
  Result := fsECF.NumCCF ;
end;

function TACBrECF.GetNumGNFCClass: String;
begin
  ComandoLOG := 'NumGNFC' ;
  Result := fsECF.NumGNFC ;
end;

function TACBrECF.GetNumGNFClass: String;
begin
  ComandoLOG := 'NumGNF' ;
  Result := fsECF.NumGNF ;
end;

function TACBrECF.GetNumGRGClass: String;
begin
  ComandoLOG := 'NumGRG' ;
  Result := fsECF.NumGRG ;
end;

function TACBrECF.GetNumCDCClass: String;
begin
  ComandoLOG := 'NumCDC' ;
  Result := fsECF.NumCDC ;
end;

function TACBrECF.GetNumCFCClass: String;
begin
  ComandoLOG := 'NumCFC' ;
  Result := fsECF.NumCFC ;
end;

function TACBrECF.GetNumCFDClass: String;
begin
  ComandoLOG := 'NumCFD' ;
  Result := fsECF.NumCFD ;
end;

function TACBrECF.GetNumNCNClass: String;
begin
  ComandoLOG := 'NumNCN' ;
  Result := fsECF.NumNCN ;
end;

function TACBrECF.GetNumCCDCClass: String;
begin
  ComandoLOG := 'NumCCDC' ;
  Result := fsECF.NumCCDC ;
end;

function TACBrECF.GetNumLojaClass: String;
begin
  ComandoLOG := 'NumLoja' ;
  Result := fsECF.NumLoja ;
end;

function TACBrECF.GetNumSerieClass: String;
begin
  ComandoLOG := 'NumSerie' ;
  Result := fsECF.NumSerie ;
end;

function TACBrECF.GetNumSerieMFDClass: String;
begin
  ComandoLOG := 'NumSerieMFD' ;
  Result := fsECF.NumSerieMFD ;
end;

function TACBrECF.GetNumVersaoClass: String;
begin
  ComandoLOG := 'NumVersao' ;
  Result := fsECF.NumVersao ;
end;

function TACBrECF.EmLinha(lTimeOut: Integer): Boolean;
begin
  Result := fsECF.EmLinha(lTimeOut) ;
end;

function TACBrECF.GetEstadoClass: TACBrECFEstado;
begin
  ComandoLOG := 'Estado' ;
  Result := fsECF.Estado ;

  if Result <> fpUltimoEstadoObtido then
  begin
     try
        if Assigned( FOnChangeEstado ) then
           FOnChangeEstado( fpUltimoEstadoObtido, Result);
     finally
        fpUltimoEstadoObtido := Result;
     end;
  end ;
end;

function TACBrECF.GetPoucoPapelClass: Boolean;
begin
  ComandoLOG := 'PoucoPapel' ;
  Result := fsECF.PoucoPapel ;
end;

function TACBrECF.GetArredondaClass: Boolean;
begin
  ComandoLOG := 'Arredonda' ;
  Result := fsECF.Arredonda ;
end;

function TACBrECF.GetHorarioVeraoClass: Boolean;
begin
  ComandoLOG := 'HorarioVerao' ;
  Result := fsECF.HorarioVerao ;
end;

function TACBrECF.GetMFAdicional: String;
var
  Letra: AnsiChar;
begin
  ComandoLOG := 'MF Adicional' ;

  Letra := PadL(RightStr(fsECF.NumSerie, 1),1)[1];
  if CharIsAlpha(Letra) then
    Result := Letra
  else
    Result := '';
end;

function TACBrECF.GetMFDClass: Boolean;
begin
  Result := fsECF.MFD ;
end;

function TACBrECF.GetTermicaClass: Boolean;
begin
  Result := fsECF.Termica ;
end;

function TACBrECF.GetIdentificaConsumidorRodapeClass: Boolean;
begin
  Result := fsECF.IdentificaConsumidorRodape ;
end;


function TACBrECF.GetCNPJClass: String;
begin
  ComandoLOG := 'CNPJ' ;
  Result := Trim(fsECF.CNPJ) ;
end;

function TACBrECF.GetIEClass: String;
begin
  ComandoLOG := 'IE' ;
  Result := Trim(fsECF.IE) ;
end;

//IMS 28/09/2009
function TACBrECF.GetIMClass: String;
begin
  ComandoLOG := 'IM' ;
  Result := Trim(fsECF.IM) ;
end;
function TACBrECF.GetClicheClass: String;
begin
  ComandoLOG := 'Cliche' ;
  Result := Trim(fsECF.Cliche) ;  // Trim remove eventuais #0
end;
//IMS 09/10/2009
function TACBrECF.GetUsuarioAtualClass: String;
begin
  ComandoLOG := 'UsuarioAtual' ;
  Result := fsECF.UsuarioAtual ;
end;
//IMS 20/10/2009
function TACBrECF.GetDataHoraSBClass: TDateTime;
begin
  ComandoLOG := 'DataHoraSB' ;
  Result := fsECF.DataHoraSB ;
end;
function TACBrECF.GetSubModeloECFClass: String;
begin
  ComandoLOG := 'SubModeloECF' ;
  Result := fsECF.SubModeloECF ;
end;
//IMS

function TACBrECF.GetPAFClass: String;
begin
  ComandoLOG := 'PAF' ;
  Result := fsECF.PAF ;
end;

function TACBrECF.GetDataMovimentoClass: TDateTime;
begin
  ComandoLOG := 'DataMovimento' ;
  Result := fsECF.DataMovimento ;
end;

function TACBrECF.GetGrandeTotalClass: Double;
begin
  ComandoLOG := 'GrandeTotal' ;
  Result := RoundTo( fsECF.GrandeTotal, -2) ;
end;

function TACBrECF.GetNumCOOInicialClass: String;
begin
  ComandoLOG := 'NumCOOInicial' ;
  Result := fsECF.NumCOOInicial ;
end;

function TACBrECF.GetNumCRZClass: String;
begin
  ComandoLOG := 'NumCRZ' ;
  Result := fsECF.NumCRZ ;
end;

function TACBrECF.GetTotalAcrescimosClass: Double;
begin
  ComandoLOG := 'TotalAcrescimos' ;
  Result := RoundTo( fsECF.TotalAcrescimos, -2) ;
end;

function TACBrECF.GetTotalCancelamentosClass: Double;
begin
  ComandoLOG := 'TotalCancelamentos' ;
  Result := RoundTo( fsECF.TotalCancelamentos, -2) ;
end;

function TACBrECF.GetTotalDescontosClass: Double;
begin
  ComandoLOG := 'TotalDescontos' ;
  Result := RoundTo( fsECF.TotalDescontos, -2) ;
end;

function TACBrECF.GetTotalTrocoClass: Double;
begin
  ComandoLOG := 'TotalTroco' ;
  Result := RoundTo( fsECF.TotalTroco, -2) ;
end;

function TACBrECF.GetTotalSubstituicaoTributariaClass: Double;
begin
  ComandoLOG := 'TotalSubstituicaoTributaria' ;
  Result := RoundTo( fsECF.TotalSubstituicaoTributaria, -2) ;
end;

function TACBrECF.GetTotalIsencaoClass: Double;
begin
  ComandoLOG := 'TotalIsencao' ;
  Result := RoundTo( fsECF.TotalIsencao, -2) ;
end;

function TACBrECF.GetTotalNaoFiscalClass: Double;
begin
  ComandoLOG := 'TotalNaoFiscal' ;
  Result := RoundTo( fsECF.TotalNaoFiscal, -2) ;
end;

function TACBrECF.GetTotalNaoTributadoClass: Double;
begin
  ComandoLOG := 'TotalNaoTributado' ;
  Result := RoundTo( fsECF.TotalNaoTributado, -2) ;
end;

function TACBrECF.GetTotalAcrescimosISSQNClass: Double;
begin
  ComandoLOG := 'TotalAcrescimosISSQN';
  Result := RoundTo( fsECF.TotalAcrescimosISSQN, -2);
end;

function TACBrECF.GetTotalCancelamentosISSQNClass: Double;
begin
  ComandoLOG := 'TotalCancelamentosISSQN';
  Result := RoundTo( fsECF.TotalCancelamentosISSQN, -2);
end;

function TACBrECF.GetTotalDescontosISSQNClass: Double;
begin
  ComandoLOG := 'TotalDescontosISSQN';
  Result := RoundTo( fsECF.TotalDescontosISSQN, -2);
end;

function TACBrECF.GetTotalAcrescimosOPNFClass: Double;
begin
  ComandoLOG := 'TotalAcrescimosOPNF';
  Result := RoundTo( fsECF.TotalAcrescimosOPNF, -2);
end;

function TACBrECF.GetTotalCancelamentosOPNFClass: Double;
begin
  ComandoLOG := 'TotalCancelamentosOPNF';
  Result := RoundTo( fsECF.TotalCancelamentosOPNF, -2);
end;

function TACBrECF.GetTotalDescontosOPNFClass: Double;
begin
  ComandoLOG := 'TotalDescontosOPNF';
  Result := RoundTo( fsECF.TotalDescontosOPNF, -2);
end;

function TACBrECF.GetTotalSubstituicaoTributariaISSQNClass: Double;
begin
  ComandoLOG := 'TotalSubstituicaoTributariaISSQN';
  Result := RoundTo( fsECF.TotalSubstituicaoTributariaISSQN, -2);
end;

function TACBrECF.GetTotalIsencaoISSQNClass: Double;
begin
  ComandoLOG := 'TotalIsencaoISSQN';
  Result := RoundTo( fsECF.TotalIsencaoISSQN, -2);
end;

function TACBrECF.GetTotalNaoTributadoISSQNClass: Double;
begin
  ComandoLOG := 'TotalNaoTributadoISSQN';
  Result := RoundTo( fsECF.TotalNaoTributadoISSQN, -2);
end;

function TACBrECF.GetVendaBrutaClass: Double;
begin
  ComandoLOG := 'VendaBruta' ;
  Result := RoundTo( fsECF.VendaBruta, -2) ;
end;

function TACBrECF.GetNumUltimoItemClass: Integer;
begin
  ComandoLOG := 'NumUltimoItem' ;
  Result := fsECF.NumUltItem ;
end;

function TACBrECF.GetDadosReducaoZ: AnsiString;
Var
  I    : Integer ;
  Aliq : TACBrECFAliquota ;
  FPG  : TACBrECFFormaPagamento ;
  CNF  : TACBrECFComprovanteNaoFiscal ;
  RG   : TACBrECFRelatorioGerencial ;
begin
  { Alimenta a class com os dados atuais do ECF }
  with fsDadosReducaoZClass do
  begin
     Clear ;
     
     DataDaImpressora  := Self.DataHora;

     { REDUÇÃO Z }
     try
        DataDoMovimento := Self.DataMovimento;
     except
     end ;

     try
        NumeroDeSerie := Self.NumSerie;
     except
     end ;

     try
        NumeroDeSerieMFD := Self.NumSerieMFD;
     except
     end ;

     try
        NumeroDoECF  := Self.NumECF;
        NumeroDaLoja := Self.NumLoja;
     except
     end ;

     try
        NumeroCOOInicial := Self.NumCOOInicial;
     except
     end ;

     { CONTADORES }
     try
        COO := StrToIntDef(Self.NumCOO,0);
     except
     end ;

     try
        GNF := StrToIntDef(Self.NumGNF,0);
     except
     end ;

     try
        CRO := StrToIntDef(Self.NumCRO,0);
     except
     end ;

     try
        CRZ := StrToIntDef(Self.NumCRZ,0);
     except
     end ;

     try
        CCF := StrToIntDef(Self.NumCCF,0);
     except
     end ;

     try
        CDC := StrToIntDef(Self.NumCDC,0);
     except
     end ;

     try
        CFC := StrToIntDef(Self.NumCFC,0);
     except
     end ;

     try
        GRG := StrToIntDef(Self.NumGRG,0);
     except
     end ;

     try
        GNFC := StrToIntDef(Self.NumGNFC,0);
     except
     end ;

     try
        CFD := StrToIntDef(Self.NumCFD,0);
     except
     end ;

     try
        NCN := StrToIntDef(Self.NumNCN,0);
     except
     end ;

     try
        CCDC := StrToIntDef(Self.NumCCDC,0);
     except
     end ;



     { TOTALIZADORES }
     try
        ValorGrandeTotal  := Self.GrandeTotal;
     except
     end ;

     try
        ValorVendaBruta := Self.VendaBruta;
     except
     end ;

     try
        CancelamentoICMS := Self.TotalCancelamentos;
     except
     end ;

     try
        DescontoICMS := Self.TotalDescontos;
     except
     end ;

//     try
//        TotalISSQN := Self.TotalNaoTributadoISSQN; //Total ISSQN e Total Não tributado são coisas diferentes... ???
//     except
//     end ;

     try
        CancelamentoISSQN := Self.TotalCancelamentosISSQN;
     except
     end ;

     try
        DescontoISSQN := Self.TotalDescontosISSQN;
     except
     end ;

     try
        AcrescimoICMS := Self.TotalAcrescimos;
     except
     end ;

     try
        AcrescimoISSQN := Self.TotalAcrescimosISSQN;
     except
     end ;

     try
        CancelamentoOPNF := Self.TotalCancelamentosOPNF;
     except
     end ;

     try
        DescontoOPNF := Self.TotalDescontosOPNF;
     except
     end ;

     try
        AcrescimoOPNF := Self.TotalAcrescimosOPNF;
     except
     end ;

     { Copiando objetos de ICMS e ISS}
     try
        CarregaAliquotas;
        LerTotaisAliquota;

        for I := 0 to Self.Aliquotas.Count - 1 do
        begin
           Aliq := TACBrECFAliquota.Create ;
           Aliq.Assign( Self.Aliquotas[I] );

           if Self.Aliquotas[I].Tipo = 'S' then
              ISSQN.Add( Aliq )
           else
              ICMS.Add( Aliq )
        end;
     except
     end;

     try
        SubstituicaoTributariaICMS  := Self.TotalSubstituicaoTributaria;
     except
     end ;

     try
        IsentoICMS := Self.TotalIsencao;
     except
     end ;

     try
        NaoTributadoICMS := Self.TotalNaoTributado;
     except
     end ;

     { ISSQN }
     try
        SubstituicaoTributariaISSQN := Self.TotalSubstituicaoTributariaISSQN;
     except
     end ;

     try
        IsentoISSQN := Self.TotalIsencaoISSQN;
     except
     end ;

     try
        NaoTributadoISSQN := Self.TotalNaoTributadoISSQN;
     except
     end ;

     VendaLiquida :=
      VendaBruta -
      CancelamentoICMS -
      DescontoICMS -
      TotalISSQN -
      CancelamentoISSQN -
      DescontoISSQN;

     { TOTALIZADORES NÃO FISCAIS }
     try
        CarregaComprovantesNaoFiscais ;
        LerTotaisComprovanteNaoFiscal ;

        For I := 0 to Self.ComprovantesNaoFiscais.Count-1 do
        begin
           CNF := TACBrECFComprovanteNaoFiscal.Create ;

           CNF.Assign( Self.ComprovantesNaoFiscais[I] );
           TotalizadoresNaoFiscais.Add( CNF ) ;
        end ;

        TotalOperacaoNaoFiscal := Self.TotalNaoFiscal;
     except
     end ;

     { RELATÓRIO GERENCIAL }
     try
        CarregaRelatoriosGerenciais ;

        For I := 0 to Self.RelatoriosGerenciais.Count-1 do
        begin
           RG := TACBrECFRelatorioGerencial.Create ;

           RG.Assign( Self.RelatoriosGerenciais[I] );
           RelatorioGerencial.Add( RG ) ;
        end ;
     except
     end ;

     { MEIOS DE PAGAMENTO }
     try
        CarregaFormasPagamento ;
        LerTotaisFormaPagamento ;

        For I := 0 to Self.FormasPagamento.Count-1 do
        begin
           FPG := TACBrECFFormaPagamento.Create ;

           FPG.Assign( Self.FormasPagamento[I] );
           MeiosDePagamento.Add( FPG ) ;
        end ;

        TotalTroco := Self.TotalTroco;
     except
     end ;
  end;

  ///// Montando o INI com as informações /////

  Result := '[ECF]'+sLineBreak ;
  Result := Result + 'DataMovimento = ' +
               FormatDateTime('dd/mm/yy', fsDadosReducaoZClass.DataDoMovimento) + sLineBreak ;
  Result := Result + 'NumSerie = ' + fsDadosReducaoZClass.NumeroDeSerie + sLineBreak ;
  Result := Result + 'NumSerieMFD = ' + fsDadosReducaoZClass.NumeroDeSerieMFD + sLineBreak ;
  Result := Result + 'NumECF = ' + fsDadosReducaoZClass.NumeroDoECF + sLineBreak ;
  Result := Result + 'NumLoja = ' + fsDadosReducaoZClass.NumeroDaLoja + sLineBreak ;
  Result := Result + 'NumCOOInicial = ' + fsDadosReducaoZClass.NumeroCOOInicial + sLineBreak ;
  Result := Result + 'NumCOO = ' + FormatFloat('000000', fsDadosReducaoZClass.COO) + sLineBreak ;
  Result := Result + 'NumCRZ = ' + FormatFloat('000000', fsDadosReducaoZClass.CRZ) + sLineBreak ;
  Result := Result + 'NumCRO = ' + FormatFloat('000000', fsDadosReducaoZClass.CRO) + sLineBreak ;
  Result := Result + 'NumGNF = ' + FormatFloat('000000', fsDadosReducaoZClass.GNF) + sLineBreak ;
  Result := Result + 'NumCCF = ' + FormatFloat('000000', fsDadosReducaoZClass.CCF) + sLineBreak ;
  Result := Result + 'NumCFD = ' + FormatFloat('000000', fsDadosReducaoZClass.CFD) + sLineBreak ;
  Result := Result + 'NumCDC = ' + FormatFloat('000000', fsDadosReducaoZClass.CDC) + sLineBreak ;
  Result := Result + 'NumGRG = ' + FormatFloat('000000', fsDadosReducaoZClass.GRG) + sLineBreak ;
  Result := Result + 'NumGNFC = ' + FormatFloat('000000', fsDadosReducaoZClass.GNFC) + sLineBreak ;
  Result := Result + 'NumCFC = ' + FormatFloat('000000', fsDadosReducaoZClass.CFC) + sLineBreak ;
  Result := Result + 'NumNCN = ' + FormatFloat('000000', fsDadosReducaoZClass.NCN) + sLineBreak ;
  Result := Result + 'NumCCDC = ' + FormatFloat('000000', fsDadosReducaoZClass.CCDC) + sLineBreak ;

  Result := Result + sLineBreak + '[Totalizadores]'+sLineBreak;
  Result := Result + 'VendaBruta = ' + FloatToStr(fsDadosReducaoZClass.ValorVendaBruta) + sLineBreak ;
  Result := Result + 'GrandeTotal = ' + FloatToStr(fsDadosReducaoZClass.ValorGrandeTotal) + sLineBreak ;
  Result := Result + 'TotalDescontos = ' + FloatToStr(fsDadosReducaoZClass.DescontoICMS) + sLineBreak ;
  Result := Result + 'TotalCancelamentos = ' + FloatToStr(fsDadosReducaoZClass.CancelamentoICMS) + sLineBreak ;
  Result := Result + 'TotalAcrescimos = ' + FloatToStr(fsDadosReducaoZClass.AcrescimoICMS) + sLineBreak ;
  Result := Result + 'TotalDescontosISSQN = ' + FloatToStr(fsDadosReducaoZClass.DescontoISSQN) + sLineBreak;
  Result := Result + 'TotalCancelamentosISSQN = ' + FloatToStr(fsDadosReducaoZClass.CancelamentoISSQN) + sLineBreak;
  Result := Result + 'TotalAcrescimosISSQN = ' + FloatToStr(fsDadosReducaoZClass.AcrescimoISSQN) + sLineBreak;
  Result := Result + 'TotalNaoFiscal = ' + FloatToStr(fsDadosReducaoZClass.TotalOperacaoNaoFiscal) + sLineBreak ;
  Result := Result + 'TotalDescontosOPNF = ' + FloatToStr(fsDadosReducaoZClass.DescontoOPNF) + sLineBreak;
  Result := Result + 'TotalCancelamentosOPNF = ' + FloatToStr(fsDadosReducaoZClass.CancelamentoOPNF) + sLineBreak;
  Result := Result + 'TotalAcrescimosOPNF = ' + FloatToStr(fsDadosReducaoZClass.AcrescimoOPNF) + sLineBreak;

  Result := Result + sLineBreak + '[Aliquotas]'+sLineBreak ;

  For I := 0 to Aliquotas.Count-1 do
  begin
     Result := Result +
               FormatFloat('00', I+1 )+
               Aliquotas[I].Tipo +
               IntToStrZero(Round(Aliquotas[I].Aliquota*100),4) + ' = '+
               FloatToStr(Aliquotas[I].Total) + sLineBreak ;
  end ;

  Result := Result + sLineBreak + '[OutrasICMS]'+sLineBreak ;
  Result := Result + 'TotalSubstituicaoTributaria = ' +
            FloatToStr(fsDadosReducaoZClass.SubstituicaoTributariaICMS) + sLineBreak ;
  Result := Result + 'TotalNaoTributado = ' +
            FloatToStr(fsDadosReducaoZClass.NaoTributadoICMS) + sLineBreak ;
  Result := Result + 'TotalIsencao = ' +
            FloatToStr(fsDadosReducaoZClass.IsentoICMS) + sLineBreak ;
  Result := Result + 'TotalSubstituicaoTributariaISSQN = ' +
            FloatToStr(fsDadosReducaoZClass.SubstituicaoTributariaISSQN) + sLineBreak;
  Result := Result + 'TotalNaoTributadoISSQN = ' +
            FloatToStr(fsDadosReducaoZClass.NaoTributadoISSQN) + sLineBreak;
  Result := Result + 'TotalIsencaoISSQN = ' +
            FloatToStr(fsDadosReducaoZClass.IsentoISSQN) + sLineBreak;

  Result := Result + sLineBreak + '[NaoFiscais]'+sLineBreak ;
  with fsDadosReducaoZClass do
  begin
     For I := 0 to TotalizadoresNaoFiscais.Count-1 do
        Result := Result + padL(TotalizadoresNaoFiscais[I].Indice,2) + '_' +
                           TotalizadoresNaoFiscais[I].Descricao +' = '+
                           FloatToStr(TotalizadoresNaoFiscais[I].Total) + sLineBreak ;
  end;
end;

function TACBrECF.GetDadosUltimaReducaoZ: AnsiString;
begin
  Result := fsECF.DadosUltimaReducaoZ ;
end ;

procedure TACBrECF.AbreCupom(CPF_CNPJ: String = ''; Nome : String = '';
   Endereco : String = '') ;
var
  Tratado : Boolean;
begin
  if RFDAtivo then
     fsRFD.VerificaParametros ;

  if Assigned( fOnAntesAbreCupom ) then
     fOnAntesAbreCupom( CPF_CNPJ, Nome, Endereco);

  if Trim(CPF_CNPJ) + Trim(Nome) + Trim(Endereco) <> '' then
     IdentificaConsumidor(CPF_CNPJ, Nome, Endereco);

  if fsIdentificarOperador then
  begin
     try
        IdentificaOperador(Operador);
     except
     end ;
  end ;

  ComandoLOG := 'AbreCupom( '+CPF_CNPJ+', '+NOME+', '+ENDERECO+' )' ;
  try
    Tratado := False;
    fsECF.AbreCupom ;
  except
     if Assigned( FOnErrorAbreCupom ) then
        FOnErrorAbreCupom(Tratado);

     if not Tratado then
        raise;
  end;

  {$IFNDEF CONSOLE}
   if MemoAssigned then
   begin
      fsMemoOperacao := 'abrecupom' ;
      MemoAdicionaCabecalho ;

      if Trim(CPF_CNPJ) <> '' then
      begin
         MemoAdicionaLinha(LeftStr('CPF/CNPJ Consumidor: '+CPF_CNPJ, fsMemoColunas)) ;
         MemoAdicionaLinha( '<hr>' ) ;
      end ;

      if fsModelo = ecfNaoFiscal then
         MemoTitulo('CUPOM NAO FISCAL')
      else
         MemoTitulo('CUPOM FISCAL');
         
      MemoAdicionaLinha( fsMemoCabItens );
   end ;
  {$ENDIF}

  if RFDAtivo then
     fsRFD.AbreCupom ;

  if Assigned( FOnDepoisAbreCupom ) then
     FOnDepoisAbreCupom(CPF_CNPJ, Nome, Endereco);

end;

Procedure TACBrECF.IdentificaConsumidor( CPF_CNPJ : String; Nome : String = '';
       Endereco : String = '') ;
begin
  fsECF.Consumidor.AtribuiConsumidor(CPF_CNPJ, Nome, Endereco);
end;

function TACBrECF.GetConsumidorClass: TACBrECFConsumidor;
begin
  Result := fsECF.Consumidor ;
end;


procedure TACBrECF.CancelaCupom;
  Var Docto     : String ;
      OldEstado : TACBrECFEstado ;
      SubTot    : Double ;
      Tratado   : Boolean;
begin
  if RFDAtivo then
     fsRFD.VerificaParametros ;
     
  OldEstado := estDesconhecido ;
  SubTot    := 0 ;
  Docto     := '' ;

  if RFDAtivo {$IFNDEF CONSOLE}or MemoAssigned {$ENDIF} then
  begin
     OldEstado := Estado ;
     SubTot    := Subtotal ;
     Docto     := IntToStrZero( StrToInt(NumCupom) ,6) ;
  end ;

  ComandoLOG := 'CancelaCupom' ;

  if Assigned( fOnAntesCancelaCupom ) then
     fOnAntesCancelaCupom(Self);

  try
    Tratado := False;
    fsECF.CancelaCupom ;
  except
     if Assigned( FOnErrorCancelaCupom ) then
        FOnErrorCancelaCupom(Tratado);

     if not Tratado then
        raise;
  end;

  if RFDAtivo then
     fsRFD.CancelaCupom( StrToInt(Docto) ) ;

  fsMensagemRodape := '' ;
  Consumidor.Zera ;
  CodigodeBarras.Zera;

  {$IFNDEF CONSOLE}
   if MemoAssigned then
   begin
      fsMemoOperacao := 'cancelacupom' ;

      if OldEstado in [estVenda, estPagamento] then
       begin
          MemoTitulo('*** CUPOM CANCELADO ***');

          if OldEstado = estVenda then
             MemoAdicionaLinha( '<table width=100%><tr>'+
              '<td align=left>TOTAL R$</td>'+
              '<td align=right><b>'+FormatFloat('###,##0.00',SubTot)+'</b></td>'+
              '</tr></table>') ;

           MemoAdicionaLinha( fsMemoRodape );
       end
      else
       begin
          MemoAdicionaCabecalho ;
          MemoTitulo('*** CUPOM CANCELADO ***');
          MemoAdicionaLinha( '<table width=100%><tr>'+
              '<td align=left>COO do Cupom Cancelado:</td>'+
              '<td align=right><b>'+Docto+'</b></td>'+
              '</tr></table>' + sLineBreak + sLineBreak +
              '<table width=100%><tr>'+
              '<td align=left>Valor da Operacao  R$:</td>'+
              '<td align=right><b>'+FormatFloat('#,###,##0.00',SubTot)+'</b></td>'+
              '</tr></table>' + sLineBreak + sLineBreak +
              fsMemoRodape ) ;
       end ;
   end ;
  {$ENDIF}

  if Assigned( fOnDepoisCancelaCupom ) then
     FOnDepoisCancelaCupom(Self);

end;

procedure TACBrECF.TestaPodeAbrirCupom;
begin
  ComandoLOG := 'TestaPodeAbrirCupom' ;
  fsECF.TestaPodeAbrirCupom ;
end;

{ Insere Legenda do Imetro para o Proximo Item a ser vendido }
procedure TACBrECF.LegendaInmetroProximoItem;
begin
  ComandoLOG := 'LegendaInmetroProximoItem' ;
  fsECF.LegendaInmetroProximoItem ;
end;

{ Vende o Item }
procedure TACBrECF.VendeItem(Codigo, Descricao: String; AliquotaICMS : String ;
  Qtd: Double; ValorUnitario: Double; ValorDescontoAcrescimo: Double;
  Unidade: String; TipoDescontoAcrescimo : String; DescontoAcrescimo : String);
 Var AliquotaECF : String ;
     Aliquota    : TACBrECFAliquota ;
     Tratado : Boolean;
{$IFNDEF CONSOLE}
     Linha, Buffer, StrQtd, StrPreco, StrDescAcre : String ;
     Total, PorcDesc, ValDesc : Double ;
{$ENDIF}
begin
  Qtd           := RoundTo( Qtd, -DecimaisQtd) ;
  ValorUnitario := RoundTo( ValorUnitario, -DecimaisPreco) ;

  if Qtd <= 0 then
     raise EACBrECFCMDInvalido.Create( ACBrStr(cACBrECFVendeItemQtdeException) );

  if ValorUnitario <= 0 then
     raise EACBrECFCMDInvalido.Create( ACBrStr(cACBrECFVendeItemValorUnitException) );

  if ValorDescontoAcrescimo < 0 then
     raise EACBrECFCMDInvalido.Create( ACBrStr(cACBrECFVendeItemDescAcreException) );

  AliquotaICMS := UpperCase( Trim(AliquotaICMS) ) ;
  if AliquotaICMS = '' then
     raise EACBrECFCMDInvalido.Create( ACBrStr(cACBrECFVendeItemAliqICMSException) );

  DescontoAcrescimo := UpperCase(DescontoAcrescimo) ;
  if DescontoAcrescimo = '' then
     DescontoAcrescimo := 'D' ;

  { Retorna em "AliquotaECF" (por referencia) a String de aliquota que deve
    ser enviada para o ECF }
  AliquotaECF := AliquotaICMS ;

  { convertendo IS1, IS2 = "SI";   FS1, FS2 = "SF";   NS1, NS2 = "SN" }
  if copy(AliquotaICMS,1,2) = 'FS' then
     AliquotaECF := 'SF'
  else if copy(AliquotaICMS,1,2) = 'NS' then
     AliquotaECF := 'SN'
  else if copy(AliquotaICMS,1,2) = 'IS' then
     AliquotaECF := 'SI' ;

  Aliquota    := AchaICMSAliquota( AliquotaECF ) ;

  { Verificando se precisa Arredondar por Qtd }
  if ArredondaPorQtd and (not Arredonda) then
     ArredondarPorQtd( Qtd, ValorUnitario );

  { Usando unidade Default "UN" para evitar problemas em RFD e alguns ECFs que exigem Unidade }
  if Trim( Unidade ) = '' then
     Unidade := 'UN' ;
     
  ComandoLOG := 'VendeItem( '+Codigo+' , '+Descricao+' , '+
                     AliquotaICMS+' , '+FloatToStr(Qtd)+' , '+
                     FloatToStr(ValorUnitario)+' , '+
                     FloatToStr(ValorDescontoAcrescimo)+' , '+Unidade+' , '+
                     TipoDescontoAcrescimo+' , '+DescontoAcrescimo+' )';

  if Assigned( fOnAntesVendeItem ) then
     fOnAntesVendeItem( Codigo, Descricao, AliquotaECF, Qtd, ValorUnitario,
                     ValorDescontoAcrescimo, Unidade, TipoDescontoAcrescimo,
                     DescontoAcrescimo);

  try
    Tratado := False;
    fsECF.VendeItem( Codigo, Descricao, AliquotaECF, Qtd, ValorUnitario,
                     ValorDescontoAcrescimo, Unidade, TipoDescontoAcrescimo,
                     DescontoAcrescimo );
  except
     if Assigned( FOnErrorVendeItem ) then
        FOnErrorVendeItem(Tratado);

     if not Tratado then
        raise;
  end;


  {$IFNDEF CONSOLE}
   if MemoAssigned then
   begin
      fsMemoOperacao := 'vendeitem' ;

     Inc( fsMemoItens ) ;

     if Qtd = Round( Qtd ) then
        StrQtd := FormatFloat('#######0',Qtd )
     else
        StrQtd := FormatFloat('###0.000',Qtd ) ;

     if RoundTo( ValorUnitario, -2 ) = ValorUnitario then
        StrPreco := FormatFloat('###,##0.00',ValorUnitario )
     else
        StrPreco := FormatFloat('##,##0.000',ValorUnitario ) ;

     if self.Arredonda then
        Total := RoundTo( Qtd * ValorUnitario, -2)
     else
        Total := TruncFix( Qtd * ValorUnitario * 100 ) / 100 ;

     { Inserindo na String da fsMascaraItem }
     Linha := fsMemoMascItens ;
     Linha := StuffMascaraItem( Linha, fsMemoMascItens, 'I', IntToStrZero(fsMemoItens,3)) ;
     Linha := StuffMascaraItem( Linha, fsMemoMascItens, 'C', Codigo ) ;
     Linha := StuffMascaraItem( Linha, fsMemoMascItens, 'D', Descricao ) ;
     Linha := StuffMascaraItem( Linha, fsMemoMascItens, 'Q', StrQtd, True ) ;
     Linha := StuffMascaraItem( Linha, fsMemoMascItens, 'U', Unidade ) ;
     Linha := StuffMascaraItem( Linha, fsMemoMascItens, 'V', StrPreco ) ;
     Linha := StuffMascaraItem( Linha, fsMemoMascItens, 'A', AliquotaICMS ) ;
     Linha := StuffMascaraItem( Linha, fsMemoMascItens, 'T', FormatFloat('###,##0.00', Total ), True) ;

     { Quebrando a linha em várias de acordo com o tamanho das colunas }
     Buffer := '' ;
     while Linha <> '' do
     begin
        Buffer := Buffer + copy(Linha,1,fsMemoColunas) + sLineBreak ;
        Linha  := copy(Linha,fsMemoColunas + 1,Length(Linha)) ;
     end ;

     MemoAdicionaLinha( Buffer );

     if ValorDescontoAcrescimo > 0 then
     begin
        if TipoDescontoAcrescimo = '%' then
         begin
           PorcDesc := -ValorDescontoAcrescimo ;
           if self.Arredonda then
              ValDesc  := -RoundTo(Total * (ValorDescontoAcrescimo / 100), -2)
           else
              ValDesc  := TruncFix(Total * ValorDescontoAcrescimo) / -100 ;
         end
        else
         begin
           PorcDesc := -RoundTo( (ValorDescontoAcrescimo / Total) * 100, -2) ;
           ValDesc  := -ValorDescontoAcrescimo ;
         end ;

        StrDescAcre := 'DESCONTO' ;
        if DescontoAcrescimo <> 'D' then  // default, DescontoAcrescimo = 'D'
        begin
           ValDesc     := -ValDesc ;
           PorcDesc    := -PorcDesc ;
           StrDescAcre := 'ACRESCIMO' ;
        end ;

        Total := RoundTo(Total + ValDesc, -2) ;

        MemoAdicionaLinha( '<table width=100%><tr>'+
           '<td align=left>'+StrDescAcre+' '+FormatFloat('#0.00', PorcDesc)+'%</td>'+
           '<td align=center>'+FormatFloat('##,##0.00',ValDesc)+'</td>'+
           '<td align=right>'+FormatFloat('###,##0.00',Total)+'</td></tr></table>') ;
     end ;

   end ;
  {$ENDIF}

  if RFDAtivo then
  begin
     case AliquotaICMS[1] of
       'I' : AliquotaICMS := 'I1' ;
       'N' : AliquotaICMS := 'N1' ;
       'F' : AliquotaICMS := 'F1' ;
     else
        if Aliquota <> nil then
           AliquotaICMS := IntToStrZero(Aliquota.Sequencia,2) + Aliquota.Tipo +
                           IntToStrZero(Round(Aliquota.Aliquota*100),4) 
        else
           AliquotaICMS := '' ;
     end ;

     if ValorDescontoAcrescimo > 0 then
     begin
        { RFD aceita apenas desconto em Valor, convertendo... }
        if TipoDescontoAcrescimo = '%' then
           ValorDescontoAcrescimo := RoundTo( RoundTo(ValorUnitario*Qtd,-2) *
                                              ValorDescontoAcrescimo / 100  , -2 ) ;
        { RFD considera Descontos, valores negativos, Acrescimos positivos }
        if DescontoAcrescimo = 'D' then
           ValorDescontoAcrescimo := -ValorDescontoAcrescimo ;
     end ;

     fsRFD.VendeItem( Codigo, Descricao, Qtd, ValorUnitario, Unidade,
                      ValorDescontoAcrescimo, AliquotaICMS ) ;

  end ;

  if Assigned( FOnDepoisVendeItem ) then
     FOnDepoisVendeItem( Codigo, Descricao, AliquotaICMS, Qtd, ValorUnitario, ValorDescontoAcrescimo, Unidade, TipoDescontoAcrescimo, DescontoAcrescimo);

end;

procedure TACBrECF.DescontoAcrescimoItemAnterior( ValorDescontoAcrescimo: Double;
  DescontoAcrescimo: String);
{$IFNDEF CONSOLE}
Var
  StrDescAcre : String ;
{$ENDIF}
begin
  if ValorDescontoAcrescimo < 0 then
     raise EACBrECFCMDInvalido.Create( ACBrStr(cACBrECFVendeItemDescAcreException) );

  DescontoAcrescimo := UpperCase(DescontoAcrescimo) ;
  if DescontoAcrescimo = '' then
     DescontoAcrescimo := 'D' ;

  fsECF.DescontoAcrescimoItemAnterior(ValorDescontoAcrescimo, DescontoAcrescimo );

  {$IFNDEF CONSOLE}
   if MemoAssigned then
   begin
      fsMemoOperacao := 'descontoacrescimoitemanterior' ;

      StrDescAcre := 'DESCONTO' ;
      if DescontoAcrescimo <> 'D' then  // default, DescontoAcrescimo = 'D'
         StrDescAcre := 'ACRESCIMO' ;

      StrDescAcre := StrDescAcre + ' ' +
                     FormatFloat('##,##0.00',ValorDescontoAcrescimo) ;

      MemoAdicionaLinha( StrDescAcre ) ;
   end ;
  {$ENDIF}

  { TODO: inserir Desconto no RFD }

end;


{ Cancela o Acrescimo ou o Desconto do Item informado }
procedure TACBrECF.CancelaDescontoAcrescimoItem(NumItem: Integer);
begin
  ComandoLOG := 'CancelaDescontoAcrescimoItem' ;
  fsECF.CancelaDescontoAcrescimoItem(NumItem) ;
end;

procedure TACBrECF.CancelaImpressaoCheque;
begin
  ComandoLOG := 'CancelaImpressaoCheque' ;
  fsECF.CancelaImpressaoCheque ;
end;

procedure TACBrECF.CancelaItemVendido(NumItem: Integer);
var
  Tratado : Boolean;
begin
  ComandoLOG := 'CancelaItemVendido( '+IntToStr(NumItem)+' )' ;

  if Assigned( fOnAntesCancelaItemVendido ) then
     fOnAntesCancelaItemVendido( NumItem);

  try
    Tratado := False;
    fsECF.CancelaItemVendido( NumItem );
  except
     if Assigned( FOnErrorCancelaItemVendido ) then
        FOnErrorCancelaItemVendido(Tratado);

     if not Tratado then
        raise;
  end;

  {$IFNDEF CONSOLE}
   if MemoAssigned then
   begin
      fsMemoOperacao := 'cancelaitemvendido' ;
      MemoAdicionaLinha( '<b>CANCELADO ITEM:</b> '+IntToStrZero( NumItem,3) ) ;
   end ;
  {$ENDIF}

  if RFDAtivo then
     fsRFD.CancelaItemVendido( NumItem ) ;

  if Assigned( fOnDepoisCancelaItemVendido ) then
     FOnDepoisCancelaItemVendido( NumItem);

end;

procedure TACBrECF.SubtotalizaCupom(DescontoAcrescimo: Double;
   MensagemRodape : AnsiString );
var
  Tratado : Boolean;
begin
  { Ajustando valores acima de 2 Decimais }
  DescontoAcrescimo := RoundTo( DescontoAcrescimo, -2) ;

  { Tirando os Acentos e trocando todos os #13+#10 por #10 }
  fsMensagemRodape := TiraAcentos( StringReplace(MensagemRodape,CR+LF,#10,[rfReplaceAll]) );
  fsMensagemRodape := StringReplace(fsMensagemRodape,'|',#10,[rfReplaceAll]) ;

  { Acumula fsMensagemRodape na memória para usar em FechaCupom. Alguns ECFs
    como a DataRegis não possuem metodo de Fechamento. O Fechamento é efetuado
    assim que o Total Pago atinge o valor do Cupom, nesse caso, a Msg de rodapé
    deve ser enviada antes dos Pagamentos }

  ComandoLOG := 'SubtotalizaCupom( '+FloatToStr(DescontoAcrescimo)+' , '+
                    fsMensagemRodape+' )';

  if Assigned( fOnAntesSubtotalizaCupom ) then
     fOnAntesSubtotalizaCupom( DescontoAcrescimo, MensagemRodape);

  try
    Tratado := False;
    fsECF.SubtotalizaCupom( DescontoAcrescimo, fsMensagemRodape );
  except
     if Assigned( FOnErrorSubtotalizaCupom ) then
        FOnErrorSubtotalizaCupom(Tratado);

     if not Tratado then
        raise;
  end;

  {$IFNDEF CONSOLE}
   if MemoAssigned then
      MemoSubtotaliza(DescontoAcrescimo);
  {$ENDIF}

  if RFDAtivo then
     fsRFD.SubTotalizaCupom( DescontoAcrescimo ) ;

  if Assigned( FOnDepoisSubtotalizaCupom ) then
     FOnDepoisSubtotalizaCupom( DescontoAcrescimo, fsMensagemRodape);

end;

{ Cancela o Acrescimo ou Desconto do Subtotal do Cupom }
procedure TACBrECF.CancelaDescontoAcrescimoSubTotal(
  TipoAcrescimoDesconto: Char);
begin
  ComandoLOG := 'CancelaDescontoAcrescimoSubTotal' ;
  fsECF.CancelaDescontoAcrescimoSubTotal(TipoAcrescimoDesconto) ;
end;

{ Cancela um item parcialmente }
procedure TACBrECF.CancelaItemVendidoParcial(NumItem: Integer;
  Quantidade: Double);
begin
  ComandoLOG := 'CancelaItemVendidoParcial' ;
  fsECF.CancelaItemVendidoParcial(NumItem,Quantidade);
end;

procedure TACBrECF.EfetuaPagamento(CodFormaPagto: String; Valor: Double;
  Observacao: AnsiString; ImprimeVinculado: Boolean);
Var
  FPG     : TACBrECFFormaPagamento ;
  Tratado : Boolean;
begin
  FPG := AchaFPGIndice( CodFormaPagto ) ;
  if FPG = nil then
     raise Exception.Create(Format(ACBrStr(cACBrECFAchaFPGIndiceException), [ CodFormaPagto ])) ;

  if ImprimeVinculado and (not FPG.PermiteVinculado) then
     raise Exception.Create(Format(ACBrStr(cACBrECFFPGPermiteVinculadoException), [ CodFormaPagto ])) ;

  Observacao := TrimRight(Observacao) ;
  { Tirando os Acentos e os #13 e #10 }
  Observacao := TiraAcentos( Observacao );
  Observacao := StringReplace(Observacao,CR,'',[rfReplaceAll]) ;
  Observacao := StringReplace(Observacao,LF,'',[rfReplaceAll]) ;

  Valor := RoundTo( Valor, -2) ;  { Ajustando valores acima de 2 Decimais }

  ComandoLOG := 'EfetuaPagamento( '+CodFormaPagto+' , '+
                    FloatToStr(Valor)+' , '+Observacao+', '+
                    BoolToStr( ImprimeVinculado)+' )';

  if Assigned( fOnAntesEfetuaPagamento ) then
     fOnAntesEfetuaPagamento( CodFormaPagto, Valor, Observacao, ImprimeVinculado);

  try
    Tratado := False;
    fsECF.EfetuaPagamento( CodFormaPagto, Valor, Observacao, ImprimeVinculado);
  except
     if Assigned( fOnErrorEfetuaPagamento ) then
        fOnErrorEfetuaPagamento(Tratado);

     if not Tratado then
        raise;
  end;

  {$IFNDEF CONSOLE}
   if MemoAssigned then
      MemoEfetuaPagamento(FPG.Descricao, Valor, Observacao);
  {$ENDIF}

  if RFDAtivo then
     fsRFD.EfetuaPagamento( FPG.Descricao, Valor ) ;

  if Assigned( fOnDepoisEfetuaPagamento ) then
     fOnDepoisEfetuaPagamento( CodFormaPagto, Valor, Observacao, ImprimeVinculado);

end;

{ Estorna um Pagamento Efetuado }
procedure TACBrECF.EstornaPagamento(const CodFormaPagtoEstornar,
   CodFormaPagtoEfetivar : String; const Valor: Double;
   Observacao : AnsiString = '') ;
begin
  ComandoLOG := 'EstornaPagamento( '+CodFormaPagtoEstornar+', '+
           CodFormaPagtoEfetivar+', '+ FloatToStr(Valor)+' , '+Observacao +' )';
  fsECF.EstornaPagamento( CodFormaPagtoEstornar,CodFormaPagtoEfetivar,
                          Valor, Observacao);
end;

procedure TACBrECF.FechaCupom(Observacao: AnsiString; IndiceBMP : Integer);
var
  Tratado : Boolean;
begin
  if (Observacao = '') then
     Observacao := fsMensagemRodape ;

  if not Consumidor.Enviado then
  begin
     if Consumidor.Documento <> '' then
        Observacao := Observacao + '|CPF/CNPJ consumidor: '+Consumidor.Documento ;

     if Consumidor.Nome <> '' then
        Observacao := Observacao + '|Nome: '+Consumidor.Nome ;

     if Consumidor.Endereco <> '' then
        Observacao := Observacao + '|Endereco: '+Consumidor.Endereco ;
  end ;

  { Tirando os Acentos e trocando todos os #13+#10 por #10 }
  Observacao := TiraAcentos( StringReplace(Observacao,CR+LF,#10,[rfReplaceAll]) );
  Observacao := StringReplace(Observacao,'|',#10,[rfReplaceAll]) ;

  ComandoLOG := 'FechaCupom( '+Observacao+' )' ;

  if Assigned( fOnAntesFechaCupom ) then
     fOnAntesFechaCupom( Observacao, IndiceBMP);

  try
    Tratado := False;
    fsECF.FechaCupom( Observacao, IndiceBMP ) ;
  except
     if Assigned( fOnErrorFechaCupom ) then
        fOnErrorFechaCupom(Tratado);

     if not Tratado then
        raise;
  end;

  {$IFNDEF CONSOLE}
   if MemoAssigned then
   begin
      fsMemoOperacao := 'fechacupom' ;

      Observacao := AjustaLinhas( Observacao, fsMemoColunas, 8 ) ;
      MemoAdicionaLinha( Observacao + sLineBreak + fsMemoRodape );
   end ;
  {$ENDIF}

  if RFDAtivo then
     fsRFD.FechaCupom ;

  if Assigned( fOnDepoisFechaCupom ) then
     fOnDepoisFechaCupom( Observacao, IndiceBMP);

  fsMensagemRodape := '' ;
  Consumidor.Zera ;
  CodigodeBarras.Zera ;

end;


procedure TACBrECF.Sangria(const Valor: Double; Obs: AnsiString;
   DescricaoCNF: String; DescricaoFPG: String ) ;
Var
  Tratado : Boolean;
begin
  if DescricaoCNF = '' then
     DescricaoCNF := 'SANGRIA' ;

  if DescricaoFPG = '' then
     DescricaoFPG := 'DINHEIRO' ;

  if Assigned( fOnAntesSangria ) then
     fOnAntesSangria( Valor, Obs, DescricaoCNF, DescricaoFPG);

  ComandoLOG := 'Sangria( '+FloatToStr(Valor)+', '+Obs+', '+DescricaoCNF+', '+DescricaoFPG+' )' ;
  try
    Tratado := False;
    fsECF.Sangria( Valor, Obs, DescricaoCNF, DescricaoFPG );
  except
     if Assigned( FOnErrorSangria ) then
        FOnErrorSangria(Tratado);

     if not Tratado then
        raise;
  end;

  if Assigned( FOnDepoisSangria ) then
     FOnDepoisSangria( Valor, Obs, DescricaoCNF, DescricaoFPG);

end;

procedure TACBrECF.Suprimento(const Valor: Double; Obs: AnsiString;
   DescricaoCNF: String; DescricaoFPG: String ) ;
Var
  Tratado : Boolean;
begin
  if DescricaoCNF = '' then
     DescricaoCNF := 'SUPRIMENTO' ;

  if DescricaoFPG = '' then
     DescricaoFPG := 'DINHEIRO' ;

  if Assigned( fOnAntesSuprimento ) then
     fOnAntesSuprimento( Valor, Obs, DescricaoCNF, DescricaoFPG);

  ComandoLOG := 'Suprimento( '+FloatToStr(Valor)+', '+Obs+', '+DescricaoCNF+', '+DescricaoFPG+' )' ;
  try
    Tratado := False;
    fsECF.Suprimento( Valor, Obs, DescricaoCNF, DescricaoFPG );
  except
     if Assigned( fOnErrorSuprimento ) then
        fOnErrorSuprimento(Tratado);

     if not Tratado then
        raise;
  end;

  if Assigned( fOnDepoisSuprimento ) then
     fOnDepoisSuprimento( Valor, Obs, DescricaoCNF, DescricaoFPG);
end;


procedure TACBrECF.NaoFiscalCompleto(CodCNF: String; Valor: Double;
  CodFormaPagto: String; Obs: AnsiString; IndiceBMP : Integer);
begin
  if RFDAtivo then
     fsRFD.VerificaParametros ;

  { Ajustando valores acima de 2 Decimais }
  Valor := RoundTo( Valor, -2) ;

  ComandoLOG := 'NaoFiscalCompleto(' +CodCNF+' , '+FloatToStr(Valor)+' , '+
                CodFormaPagto+' , '+Obs+' )' ;
  fsECF.NaoFiscalCompleto(CodCNF, Valor, CodFormaPagto, Obs, IndiceBMP);

  if RFDAtivo and (not fsRegistrouRFDCNF) then
     fsRFD.Documento('CN');

  fsRegistrouRFDCNF := False ;
end;

procedure TACBrECF.AbreNaoFiscal(CPF_CNPJ: String);
Var
  Tratado : Boolean;
begin
  if RFDAtivo then
     fsRFD.VerificaParametros ;

  ComandoLOG := 'AbreNaoFiscal( '+CPF_CNPJ+' )' ;

  if Assigned( fOnAntesAbreNaoFiscal ) then
     fOnAntesAbreNaoFiscal(CPF_CNPJ);

  try
    Tratado := False;
    fsECF.AbreNaoFiscal( CPF_CNPJ );
  except
     if Assigned( fOnErrorAbreNaoFiscal ) then
        fOnErrorAbreNaoFiscal(Tratado);

     if not Tratado then
        raise;
  end;

  {$IFNDEF CONSOLE}
   if MemoAssigned then
   begin
      fsMemoOperacao := 'abrenaofiscal' ;
      MemoAdicionaCabecalho ;

      if Trim(CPF_CNPJ) <> '' then
      begin
         MemoAdicionaLinha(LeftStr('CPF/CNPJ Consumidor: '+CPF_CNPJ, fsMemoColunas)) ;
         MemoAdicionaLinha( '<hr>' ) ;
      end ;

      MemoTitulo('CUPOM NAO FISCAL');
   end ;
  {$ENDIF}

  if RFDAtivo then
  begin
     fsRFD.Documento('CN');
     fsRegistrouRFDCNF := True ;
  end ;

  if Assigned( fOnDepoisAbreNaoFiscal ) then
     fOnDepoisAbreNaoFiscal( CPF_CNPJ);

end;

procedure TACBrECF.RegistraItemNaoFiscal(CodCNF: String; Valor: Double;
  Obs: AnsiString = '');
 Var CNF : TACBrECFComprovanteNaoFiscal ;
begin
  CNF := AchaCNFIndice( CodCNF ) ;
  if CNF = nil then
     raise Exception.Create(Format(ACBrStr(cACBrECFRegistraItemNaoFiscalException), [CodCNF] )) ;

  { Tirando os Acentos de OBS }
  Obs := TiraAcentos( TrimRight(Obs) );
  { Ajustando valores acima de 2 Decimais }
  Valor := RoundTo( Valor, -2) ;

  ComandoLOG := 'RegistraItemNaoFiscal( '+CodCNF+' , '+ FloatToStr( Valor )+
                ' , '+Obs + ' )';
  fsECF.RegistraItemNaoFiscal(CodCNF, Valor, Obs);

  {$IFNDEF CONSOLE}
   if MemoAssigned then
   begin
      Inc( fsMemoItens ) ;

      if Trim(Obs) <> '' then
         Obs := sLineBreak + Obs ;

      MemoAdicionaLinha( '<table width=100%><tr>'+
                         '<td align=left>'+IntToStrZero( fsMemoItens, 3)+'</td>'+
                         '<td align=left>'+CNF.Descricao+'</td>'+
                         '<td align=right>'+FormatFloat('#,###,##0.00',Valor)+'</td>'+
                         '</tr></table>' + Obs ) ;
   end ;
  {$ENDIF}
end;

procedure TACBrECF.CancelaNaoFiscal;
Var
  Tratado : Boolean;
begin
  ComandoLOG := 'CancelaNaoFiscal';

  if Assigned( fOnAntesCancelaNaoFiscal ) then
     fOnAntesCancelaNaoFiscal(Self);

  try
    Tratado := False;
    fsECF.CancelaNaoFiscal ;
  except
     if Assigned( FOnErrorCancelaNaoFiscal ) then
        FOnErrorCancelaNaoFiscal(Tratado);

     if not Tratado then
        raise;
  end;

  {$IFNDEF CONSOLE}
  // TODO
  {$ENDIF}

  if RFDAtivo then
     fsRFD.Documento('NC');

  if Assigned( FOnDepoisCancelaNaoFiscal ) then
     FOnDepoisCancelaNaoFiscal(Self);
end;

procedure TACBrECF.EfetuaPagamentoNaoFiscal(CodFormaPagto: String;
  Valor: Double; Observacao: AnsiString; ImprimeVinculado: Boolean);
Var
  FPG     : TACBrECFFormaPagamento ;
  Tratado : Boolean;
begin
  FPG := AchaFPGIndice( CodFormaPagto ) ;
  if FPG = nil then
     raise Exception.Create(Format(ACBrStr(cACBrECFAchaFPGIndiceException),
                                   [ CodFormaPagto ] )) ;

  if ImprimeVinculado and (not FPG.PermiteVinculado) then
     raise Exception.Create(Format(ACBrStr(cACBrECFFPGPermiteVinculadoException),
                                   [ CodFormaPagto ] )) ;

  Observacao := TrimRight(Observacao) ;
  { Tirando os Acentos e os #13 e #10 }
  Observacao := TiraAcentos( Observacao );
  Observacao := StringReplace(Observacao,CR,'',[rfReplaceAll]) ;
  Observacao := StringReplace(Observacao,LF,'',[rfReplaceAll]) ;

  Valor := RoundTo( Valor, -2) ;  { Ajustando valores acima de 2 Decimais }

  ComandoLOG := 'EfetuaPagamentoNaoFiscal( '+CodFormaPagto+' , '+
                    FloatToStr(Valor)+' , '+Observacao+', '+
                    BoolToStr( ImprimeVinculado)+' )';

  if Assigned( fOnAntesEfetuaPagamentoNaoFiscal ) then
     fOnAntesEfetuaPagamentoNaoFiscal( CodFormaPagto, Valor, Observacao, ImprimeVinculado);

  try
    Tratado := False;
    fsECF.EfetuaPagamentoNaoFiscal( CodFormaPagto, Valor, Observacao,
                                  ImprimeVinculado);
  except
     if Assigned( FOnErrorEfetuaPagamentoNaoFiscal ) then
        FOnErrorEfetuaPagamentoNaoFiscal(Tratado);

     if not Tratado then
        raise;
  end;

  {$IFNDEF CONSOLE}
   if MemoAssigned then
      MemoEfetuaPagamento(FPG.Descricao, Valor, Observacao);
  {$ENDIF}

  if RFDAtivo then
     fsRFD.EfetuaPagamento( FPG.Descricao, Valor ) ;

  if Assigned( FOnDepoisEfetuaPagamentoNaoFiscal ) then
     FOnDepoisEfetuaPagamentoNaoFiscal( CodFormaPagto, Valor, Observacao, ImprimeVinculado);

end;

procedure TACBrECF.SubtotalizaNaoFiscal(DescontoAcrescimo: Double;
   MensagemRodape: AnsiString);
Var
  Tratado : Boolean;
begin
  { Ajustando valores acima de 2 Decimais }
  DescontoAcrescimo := RoundTo( DescontoAcrescimo, -2) ;

  { Tirando os Acentos e trocando todos os #13+#10 por #10 }
  fsMensagemRodape := TiraAcentos( StringReplace(MensagemRodape,CR+LF,#10,[rfReplaceAll]) );
  fsMensagemRodape := StringReplace(fsMensagemRodape,'|',#10,[rfReplaceAll]) ;

  { Acumula fsMensagemRodape na memória para usar em FechaCupom. Alguns ECFs
    como a DataRegis não possuem metodo de Fechamento. O Fechamento é efetuado
    assim que o Total Pago atinge o valor do Cupom, nesse caso, a Msg de rodapé
    deve ser enviada antes dos Pagamentos }

  ComandoLOG := 'SubtotalizaNaoFiscal( '+FloatToStr(DescontoAcrescimo)+' , '+
                    fsMensagemRodape+' )';

  if Assigned( fOnAntesSubtotalizaNaoFiscal ) then
     fOnAntesSubtotalizaNaoFiscal( DescontoAcrescimo, MensagemRodape);

  try
    Tratado := False;
    fsECF.SubtotalizaNaoFiscal( DescontoAcrescimo, fsMensagemRodape );
  except
     if Assigned( fOnErrorSubtotalizaNaoFiscal ) then
        fOnErrorSubtotalizaNaoFiscal(Tratado);

     if not Tratado then
        raise;
  end;

  {$IFNDEF CONSOLE}
   if MemoAssigned then
      MemoSubtotaliza( DescontoAcrescimo );
  {$ENDIF}

  if Assigned( fOnDepoisSubtotalizaNaoFiscal ) then
     fOnDepoisSubtotalizaNaoFiscal( DescontoAcrescimo, MensagemRodape);

end;

procedure TACBrECF.FechaNaoFiscal(Observacao: AnsiString; IndiceBMP : Integer);
Var
  Tratado : Boolean;
begin
  if (Observacao = '') then
     Observacao := fsMensagemRodape ;

  { Tirando os Acentos e trocando todos os #13+#10 por #10 }
  Observacao := TiraAcentos( StringReplace(Observacao,CR+LF,#10,[rfReplaceAll]) );
  Observacao := StringReplace(Observacao,'|',#10,[rfReplaceAll]) ;

  ComandoLOG := 'FechaNaoFiscal( '+Observacao+' )' ;

  if Assigned( fOnAntesFechaNaoFiscal ) then
     fOnAntesFechaNaoFiscal(Observacao, IndiceBMP);

  try
    Tratado := False;
    fsECF.FechaNaoFiscal( Observacao, IndiceBMP ) ;
  except
     if Assigned( FOnErrorFechaNaoFiscal ) then
        FOnErrorFechaNaoFiscal(Tratado);

     if not Tratado then
        raise;
  end;

  fsMensagemRodape := '' ;
  Consumidor.Zera ;

  {$IFNDEF CONSOLE}
   if MemoAssigned then
   begin
      fsMemoOperacao := 'fechanaofiscal' ;

      Observacao := AjustaLinhas( Observacao, fsMemoColunas, 8 ) ;
      MemoAdicionaLinha( Observacao + sLineBreak + fsMemoRodape );
   end ;
  {$ENDIF}

  if Assigned( FOnDepoisFechaNaoFiscal ) then
     FOnDepoisFechaNaoFiscal(Observacao, IndiceBMP);

end;

procedure TACBrECF.CorrigeEstadoErro(ReducaoZ: Boolean);
begin
  ComandoLOG := 'CorrigeEstadoErro' ;
  fsECF.CorrigeEstadoErro(ReducaoZ) ;
end;

function TACBrECF.EnviaComando(cmd: AnsiString ): AnsiString;
begin
  ComandoLOG := 'EnviaComando( '+cmd+' )' ;
  Result := fsECF.EnviaComando( cmd ) ;
end;

function TACBrECF.EnviaComando(cmd: AnsiString; lTimeOut: Integer): AnsiString;
begin
  ComandoLOG := 'EnviaComando( '+cmd+', '+IntToStr(lTimeOut)+' )' ;
  Result := fsECF.EnviaComando( cmd, lTimeOut ) ;
end;

procedure TACBrECF.FechaRelatorio;
{$IFNDEF CONSOLE}
 Var OldEstado : TACBrECFEstado ;
{$ENDIF}
Var
  Tratado : Boolean;
begin
  {$IFNDEF CONSOLE}
  OldEstado := estDesconhecido ;
   if MemoAssigned then
      OldEstado := Estado ;
  {$ENDIF}

  ComandoLOG := 'FechaRelatorio' ;

  if Assigned( fOnAntesFechaRelatorio ) then
     fOnAntesFechaRelatorio(Self);

  try
    Tratado := False;
    fsECF.FechaRelatorio ;
  except
     if Assigned( FOnErrorFechaRelatorio ) then
        FOnErrorFechaRelatorio(Tratado);

     if not Tratado then
        raise;
  end;

  {$IFNDEF CONSOLE}
   if MemoAssigned then
   begin
      if OldEstado <> Estado then
      begin
         fsMemoOperacao := 'fecharelatorio' ;
         MemoAdicionaLinha( fsMemoRodape );
      end ;
   end ;
  {$ENDIF}

  if Assigned( FOnDepoisFechaRelatorio ) then
     FOnDepoisFechaRelatorio(Self);

end;

procedure TACBrECF.PulaLinhas(const NumLinhas: Integer);
begin
  ComandoLOG := 'PulaLinhas( '+IntToStr(NumLinhas)+' ) ';
  fsECF.PulaLinhas( NumLinhas );

  {$IFNDEF CONSOLE}
   if MemoAssigned then
   begin
      fsMemoOperacao := 'pulalinhas' ;
      MemoAdicionaLinha( StringReplace(StringOfChar(#10, NumLinhas ),#10,sLineBreak,[rfReplaceAll]) );
   end ;
  {$ENDIF}
end;

Procedure TACBrECF.CortaPapel( const CorteParcial : Boolean ) ;
begin
  ComandoLOG := 'CortaPapel';
  fsECF.CortaPapel( CorteParcial ) ;
end;

function TACBrECF.GetChequeProntoClass: Boolean;
begin
  ComandoLOG := 'ChequePronto' ;
  Result := fsECF.ChequePronto ;
end;

procedure TACBrECF.AbreGaveta;
begin
  ComandoLOG := 'AbreGaveta' ;
  fsECF.AbreGaveta ;
end;

function TACBrECF.GetGavetaAbertaClass: Boolean;
begin
  ComandoLOG := 'GavetaAberta' ;
  Result := fsECF.GavetaAberta ;

  if fsGavetaSinalInvertido then
     Result := not Result ;
end;

function TACBrECF.GetSubTotalClass: Double;
begin
  ComandoLOG := 'Subtotal' ;
  Result := RoundTo( fsECF.Subtotal, -2) ;
end;

function TACBrECF.GetTotalPagoClass: Double;
begin
  ComandoLOG := 'TotalPago' ;
  Result := RoundTo( fsECF.TotalPago, -2) ;
end;

procedure TACBrECF.ImpactoAgulhas( NivelForca : Integer = 2);
begin
  ComandoLOG := 'ImpactoAgulhas( '+IntToStr(NivelForca)+' )' ;
  fsECF.ImpactoAgulhas( NivelForca ) ;
end;

procedure TACBrECF.LeituraMemoriaFiscal(ReducaoInicial, ReducaoFinal: Integer;
   Simplificada : Boolean = False);
begin
  if RFDAtivo then
     fsRFD.VerificaParametros ;
     
  ComandoLOG := 'LeituraMemoriaFiscal( '+IntToStr(ReducaoInicial)+' , '+
                    IntToStr(ReducaoFinal)+' ,'+BoolToStr(Simplificada)+' )';
  fsECF.LeituraMemoriaFiscal(ReducaoInicial, ReducaoFinal, Simplificada);

  if RFDAtivo then
     fsRFD.Documento('MF');
end;

procedure TACBrECF.LeituraMemoriaFiscal(DataInicial, DataFinal: TDateTime;
   Simplificada : Boolean);
begin
  if RFDAtivo then
     fsRFD.VerificaParametros ;
     
  ComandoLOG := 'LeituraMemoriaFiscal( '+DateToStr(DataInicial)+' , '+
                    DateToStr(DataFinal)+' ,'+BoolToStr(Simplificada)+' )';
  fsECF.LeituraMemoriaFiscal(DataInicial, DataFinal, Simplificada);

  if RFDAtivo then
     fsRFD.Documento('MF');
end;

procedure TACBrECF.LeituraMemoriaFiscalSerial(ReducaoInicial,
   ReducaoFinal: Integer; Linhas : TStringList; Simplificada : Boolean );
begin
  ComandoLOG := 'LeituraMemoriaFiscalSerial( '+IntToStr(ReducaoInicial)+' , '+
                    IntToStr(ReducaoFinal)+' , Linhas ,'+
                    BoolToStr(Simplificada)+' )';
  fsECF.LeituraMemoriaFiscalSerial( ReducaoInicial, ReducaoFinal, Linhas,
                                    Simplificada ) ;
end;

procedure TACBrECF.LeituraMemoriaFiscalSerial(DataInicial,
   DataFinal: TDateTime; Linhas : TStringList; Simplificada : Boolean );
begin
  ComandoLOG := 'LeituraMemoriaFiscalSerial( '+DateToStr(DataInicial)+' , '+
                    DateToStr(DataFinal)+' , Linhas ,'+BoolToStr(Simplificada)+' )';
  fsECF.LeituraMemoriaFiscalSerial( DataInicial, DataFinal, Linhas,
                                    Simplificada) ;
end;

procedure TACBrECF.LeituraMemoriaFiscalSerial(ReducaoInicial,
  ReducaoFinal: Integer; NomeArquivo: String; Simplificada: Boolean);
 Var AStringList : TStringList ;
begin
  ComandoLOG := 'LeituraMemoriaFiscalSerial( '+IntToStr(ReducaoInicial)+' , '+
                    IntToStr(ReducaoFinal)+' , '+NomeArquivo+' ,'+
                    BoolToStr(Simplificada)+' )';
  AStringList := TStringList.Create ;
  try
     fsECF.LeituraMemoriaFiscalSerial( ReducaoInicial, ReducaoFinal, AStringList,
                                       Simplificada ) ;

     AStringList.SaveToFile(NomeArquivo);
  finally
     AStringList.Free ;
  end ;
end;

procedure TACBrECF.LeituraMemoriaFiscalSerial(DataInicial,
  DataFinal: TDateTime; NomeArquivo: String; Simplificada: Boolean);
 Var AStringList : TStringList ;
begin
  ComandoLOG := 'LeituraMemoriaFiscalSerial( '+DateToStr(DataInicial)+' , '+
                    DateToStr(DataFinal)+' , '+NomeArquivo+' ,'+
                    BoolToStr(Simplificada)+' )';
  AStringList := TStringList.Create ;
  try
     fsECF.LeituraMemoriaFiscalSerial( DataInicial, DataFinal, AStringList,
                                       Simplificada ) ;

     AStringList.SaveToFile(NomeArquivo);
  finally
     AStringList.Free ;
  end ;
end;


procedure TACBrECF.TestaSeE_MFD ;
begin
  if not MFD then
     raise Exception.Create( ACBrStr('ECF '+fsECF.ModeloStr+' não é MFD') ) ;
end ;

procedure TACBrECF.LeituraMFDSerial(DataInicial, DataFinal: TDateTime;
  Linhas: TStringList; Documentos : TACBrECFTipoDocumentoSet );
begin
  TestaSeE_MFD ;

  ComandoLOG := 'LeituraMFDSerial( '+DateToStr(DataInicial)+' , '+
                    DateToStr(DataFinal)+' , Linhas) ';
  fsECF.LeituraMFDSerial( DataInicial, DataFinal, Linhas, Documentos ) ;
end;

procedure TACBrECF.LeituraMFDSerial(COOInicial, COOFinal: Integer;
  Linhas: TStringList; Documentos : TACBrECFTipoDocumentoSet );
begin
  TestaSeE_MFD ;

  ComandoLOG := 'LeituraMFDSerial( '+IntToStr(COOInicial)+' , '+
                    IntToStr(COOFinal)+' , Linhas) ';
  fsECF.LeituraMFDSerial( COOInicial, COOFinal, Linhas, Documentos ) ;
end;

procedure TACBrECF.LeituraMFDSerial(DataInicial, DataFinal: TDateTime;
  NomeArquivo: String; Documentos: TACBrECFTipoDocumentoSet);
 Var AStringList : TStringList ;
begin
  TestaSeE_MFD ;

  ComandoLOG := 'LeituraMFDSerial( '+DateToStr(DataInicial)+' , '+
                    DateToStr(DataFinal)+' , '+NomeArquivo+' ) ';
  AStringList := TStringList.Create ;
  try
     fsECF.LeituraMFDSerial( DataInicial, DataFinal, AStringList, Documentos ) ;

     AStringList.SaveToFile(NomeArquivo);
  finally
     AStringList.Free ;
  end ;
end;

procedure TACBrECF.LeituraMFDSerial(COOInicial, COOFinal: Integer;
  NomeArquivo: String; Documentos: TACBrECFTipoDocumentoSet);
 Var AStringList : TStringList ;
begin
  TestaSeE_MFD ;

  ComandoLOG := 'LeituraMFDSerial( '+IntToStr(COOInicial)+' , '+
                    IntToStr(COOFinal)+' , '+NomeArquivo+' ) ';
  AStringList := TStringList.Create ;
  try
     fsECF.LeituraMFDSerial( COOInicial, COOFinal, AStringList, Documentos ) ;

     AStringList.SaveToFile(NomeArquivo);
  finally
     AStringList.Free ;
  end ;
end;

procedure TACBrECF.EspelhoMFD_DLL(DataInicial, DataFinal: TDateTime;
  NomeArquivo: AnsiString; Documentos: TACBrECFTipoDocumentoSet);
begin
  TestaSeE_MFD ;

  ComandoLOG := 'EspelhoMFD_DLL( '+DateToStr(DataInicial)+' , '+
                    DateToStr(DataFinal)+' , '+NomeArquivo+' ) ';
  fsECF.EspelhoMFD_DLL( DataInicial, DataFinal, NomeArquivo, Documentos ) ;
end;

procedure TACBrECF.EspelhoMFD_DLL(COOInicial, COOFinal: Integer;
  NomeArquivo: AnsiString; Documentos: TACBrECFTipoDocumentoSet);
begin
  TestaSeE_MFD ;

  ComandoLOG := 'EspelhoMFD_DLL( '+IntToStr(COOInicial)+' , '+
                    IntToStr(COOFinal)+' , '+NomeArquivo+' ) ';
  fsECF.EspelhoMFD_DLL( COOInicial, COOFinal, NomeArquivo, Documentos ) ;
end;

procedure TACBrECF.ArquivoMFD_DLL(DataInicial, DataFinal: TDateTime;
  NomeArquivo: AnsiString; Documentos: TACBrECFTipoDocumentoSet;
  Finalidade: TACBrECFFinalizaArqMFD);
begin
  TestaSeE_MFD ;

  ComandoLOG := 'ArquivoMFD_DLL( '+DateToStr(DataInicial)+' , '+
                    DateToStr(DataFinal)+' , '+NomeArquivo+' ) ';
  fsECF.ArquivoMFD_DLL( DataInicial, DataFinal, NomeArquivo, Documentos, Finalidade ) ;
end;

procedure TACBrECF.ArquivoMFD_DLL(COOInicial, COOFinal: Integer;
  NomeArquivo: AnsiString; Documentos: TACBrECFTipoDocumentoSet;
  Finalidade: TACBrECFFinalizaArqMFD);
begin
  TestaSeE_MFD ;

  ComandoLOG := 'ArquivoMFD_DLL( '+IntToStr(COOInicial)+' , '+
                    IntToStr(COOFinal)+' , '+NomeArquivo+' ) ';
  fsECF.ArquivoMFD_DLL( COOInicial, COOFinal, NomeArquivo, Documentos, Finalidade ) ;
end;

procedure TACBrECF.ImprimeCheque(Banco: String; Valor: Double; Favorecido,
  Cidade: String; Data: TDateTime; Observacao: String);
begin
  Observacao := TrimRight(Observacao) ;
  { Tirando os Acentos e os #13 e #10 }
  Observacao := TiraAcentos( Observacao );
  Observacao := StringReplace(Observacao,CR,'',[rfReplaceAll]) ;
  Observacao := StringReplace(Observacao,LF,'',[rfReplaceAll]) ;

  Valor := RoundTo( Valor, -2) ;  { Ajustando valores acima de 2 Decimais }

  ComandoLOG := 'ImprimeCheque( '+Banco+' , '+FloatToStr(Valor)+' , '+
                    Favorecido+' , '+Cidade+' , '+DateToStr(Data)+' , '+
                    Observacao+' )';
  fsECF.ImprimeCheque( Banco, Valor, Favorecido, Cidade, Data, Observacao );
end;

Function TACBrECF.LeituraCMC7 : AnsiString ;
begin
  ComandoLOG := 'LeituraCMC7';
  Result := fsECF.LeituraCMC7 ;
end;

procedure TACBrECF.LeituraX;
Var
  wRespostaComando : AnsiString ;
  Tratado          : Boolean;
begin
  if RFDAtivo then
     fsRFD.VerificaParametros ;

  ComandoLOG := 'LeituraX' ;
  if Assigned( fOnAntesLeituraX ) then
     fOnAntesLeituraX(Self);

  try
    Tratado := False;
    fsECF.LeituraX ;
  except
     if Assigned( fOnErrorLeituraX ) then
        fOnErrorLeituraX(Tratado);

     if not Tratado then
        raise;
  end;

  {$IFNDEF CONSOLE}
   if MemoAssigned then
   begin
      fsMemoOperacao := 'leiturax' ;
      MemoAdicionaCabecalho ;
      MemoTitulo('LEITURA X');
      MemoAdicionaLinha( fsMemoRodape );
   end ;
  {$ENDIF}

  if RFDAtivo then
  begin
     wRespostaComando := fsECF.RespostaComando ;
     fsRFD.Documento('LX') ;
     fsECF.RespostaComando := wRespostaComando ;
  end ;

  if Assigned( fOnDepoisLeituraX ) then
     fOnDepoisLeituraX(Self);

end;

procedure TACBrECF.LeituraXSerial(Linhas: TStringList);
begin
  ComandoLOG := 'LeituraXSerial( Linhas )' ;
  fsECF.LeituraXSerial( Linhas ) ;
end;

procedure TACBrECF.LeituraXSerial(NomeArquivo: String);
 Var AStringList : TStringList ;
begin
  ComandoLOG := 'LeituraXSerial( '+NomeArquivo+' )' ;
  AStringList := TStringList.Create ;
  try
     fsECF.LeituraXSerial(AStringList);

     AStringList.SaveToFile(NomeArquivo);
  finally
     AStringList.Free ;
  end ;
end;


procedure TACBrECF.MudaHorarioVerao;
begin
  ComandoLOG := 'MudaHorarioVerao' ;
  fsECF.MudaHorarioVerao ;
end;

procedure TACBrECF.MudaHorarioVerao(EHorarioVerao: Boolean);
begin
  ComandoLOG := 'MudaHorarioVerao( '+BoolToStr(EHorarioVerao)+' )' ;
  fsECF.MudaHorarioVerao(EHorarioVerao) ;
end;

procedure TACBrECF.MudaArredondamento(Arredondar: Boolean);
begin
  ComandoLOG := 'MudaArredondamento( '+BoolToStr(Arredondar)+' )' ;
  fsECF.MudaArredondamento(Arredondar) ;
end;

procedure TACBrECF.PreparaTEF;
begin
  ComandoLOG := 'PreparaTEF' ;
  fsECF.PreparaTEF ;
end;

procedure TACBrECF.ReducaoZ(DataHora: TDateTime);
Var
  RedZ    : AnsiString ;
  Est     : TACBrECFEstado ;
  Tratado : Boolean;
begin
  Est := Estado ;
  if RFDAtivo then
  begin
     fsRFD.VerificaParametros ;
     RedZ := DadosReducaoZ ;  { Salva antes, pois alguns ECFs zeram valores após a Z }
  end ;

  try
     ComandoLOG := 'ReducaoZ( '+DateToStr(DataHora)+' )' ;

     if Assigned( fOnAntesReducaoZ ) then
        fOnAntesReducaoZ(Self);

     try
       Tratado := False;
       fsECF.ReducaoZ( DataHora ) ;
     except
        if Assigned( fOnErrorReducaoZ ) then
           fOnErrorReducaoZ(Tratado);

        if not Tratado then
           raise;
     end;
  finally
      if Est <> Estado then
      begin
        {$IFNDEF CONSOLE}
         if MemoAssigned then
         begin
            fsMemoOperacao := 'reducaoz' ;
            MemoAdicionaCabecalho ;
            MemoTitulo('REDUCAO Z');
            MemoAdicionaLinha( fsMemoRodape );
         end ;
        {$ENDIF}

        if RFDAtivo then
           fsRFD.ReducaoZ( RedZ ) ;
      end ;
  end ;

  if Assigned( fOnDepoisReducaoZ ) then
     fOnDepoisReducaoZ(Self);

end;

function TACBrECF.GetAliquotasClass: TACBrECFAliquotas;
begin
  ComandoLOG := 'Aliquotas' ;
  Result := fsECF.Aliquotas ;
end;

procedure TACBrECF.CarregaAliquotas;
begin
  ComandoLOG := 'CarregaAliquotas' ;
  fsECF.CarregaAliquotas ;
end;

procedure TACBrECF.LerTotaisAliquota;
begin
  ComandoLOG := 'LerTotaisAliquota' ;
  fsECF.LerTotaisAliquota ;
end;

function TACBrECF.AchaICMSAliquota( var AliquotaICMS: String): TACBrECFAliquota;
begin
  ComandoLOG := 'AchaICMSAliquota( '+AliquotaICMS+' )' ;
  Result := fsECF.AchaICMSAliquota( AliquotaICMS ) ;
end;

function TACBrECF.AchaICMSAliquota(Aliquota: Double; Tipo : Char ):
   TACBrECFAliquota;
begin
  ComandoLOG := 'AchaICMSAliquota( '+FloatToStr(Aliquota)+' , '+Tipo+' )' ;
  Result := fsECF.AchaICMSAliquota( Aliquota, Tipo ) ;
end;

function TACBrECF.AchaICMSIndice(Indice: String): TACBrECFAliquota;
begin
  ComandoLOG := 'AchaICMSIndice( '+Indice+' )' ;
  Result := fsECF.AchaICMSIndice( Indice ) ;
end;

procedure TACBrECF.ProgramaAliquota(Aliquota: Double; Tipo: Char;
   Posicao : String);
begin
  ComandoLOG := 'ProgramaAliquota( '+FloatToStr(Aliquota)+' , '+Tipo+' , '+
                    Posicao+' )';
  fsECF.ProgramaAliquota(Aliquota, Tipo, Posicao);
end;

function TACBrECF.GetFormasPagamentoClass: TACBrECFFormasPagamento;
begin
  ComandoLOG := 'FormasPagamento' ;
  Result := fsECF.FormasPagamento ;
end;

procedure TACBrECF.CarregaFormasPagamento;
begin
  ComandoLOG := 'CarregaFormasPagamento' ;
  fsECF.CarregaFormasPagamento ;
end;

procedure TACBrECF.LerTotaisFormaPagamento;
begin
  ComandoLOG := 'LerTotaisFormaPagamento' ;
  fsECF.LerTotaisFormaPagamento ;
end;

function TACBrECF.AchaFPGDescricao(Descricao: String; BuscaExata : Boolean;
   IgnorarCase : Boolean ): TACBrECFFormaPagamento;
begin
  ComandoLOG := 'AchaFPGDescricao( '+Descricao+', '+BoolToStr(BuscaExata)+', '+
                                                    BoolToStr(IgnorarCase)+' )' ;
  Result := fsECF.AchaFPGDescricao( Descricao, BuscaExata, IgnorarCase ) ;
end;

function TACBrECF.AchaFPGIndice(Indice: String): TACBrECFFormaPagamento;
begin
  ComandoLOG := 'AchaFPGIndice( '+Indice+' )' ;
  Result := fsECF.AchaFPGIndice( Indice ) ;
end;

procedure TACBrECF.ProgramaFormaPagamento(var Descricao: String;
  PermiteVinculado: Boolean; Posicao : String);
begin
  ComandoLOG := 'ProgramaFormaPagamento( '+Descricao+' , '+
                    BoolToStr(PermiteVinculado)+' , '+Posicao+' )' ;
  fsECF.ProgramaFormaPagamento(Descricao, PermiteVinculado, Posicao);
end;

function TACBrECF.GetRelatoriosGerenciaisClass: TACBrECFRelatoriosGerenciais;
begin
  ComandoLOG := 'RelatoriosGerenciais' ;
  Result := fsECF.RelatoriosGerenciais ;
end;

procedure TACBrECF.CarregaRelatoriosGerenciais;
begin
  ComandoLOG := 'CarregaRelatoriosGerenciais' ;
  fsECF.CarregaRelatoriosGerenciais ;
end;

procedure TACBrECF.LerTotaisRelatoriosGerenciais ;
begin
  ComandoLOG := 'LerTotaisRelatoriosGerenciais' ;
  fsECF.LerTotaisRelatoriosGerenciais ;
end ;

function TACBrECF.AchaRGDescricao(Descricao: String; BuscaExata: Boolean;
   IgnorarCase : Boolean ): TACBrECFRelatorioGerencial;
begin
  ComandoLOG := 'AchaRGDescricao( '+Descricao+', '+BoolToStr(BuscaExata)+', '+
                                                   BoolToStr(IgnorarCase)+' )' ;
  Result := fsECF.AchaRGDescricao( Descricao, BuscaExata, IgnorarCase ) ;
end;

function TACBrECF.AchaRGIndice(
  Indice: String): TACBrECFRelatorioGerencial;
begin
  ComandoLOG := 'AchaRGIndice( '+Indice+' )' ;
  Result := fsECF.AchaRGIndice( Indice ) ;
end;


procedure TACBrECF.ProgramaRelatoriosGerenciais(var Descricao: String;
  Posicao: String);
begin
  ComandoLOG := 'ProgramaRelatoriosGerenciais( '+Descricao+' , '+ Posicao+' )';
  fsECF.ProgramaRelatorioGerencial(Descricao, Posicao);
end;


function TACBrECF.GetComprovantesNaoFiscaisClass: TACBrECFComprovantesNaoFiscais;
begin
  ComandoLOG := 'ComprovantesNaoFiscais' ;
  Result := fsECF.ComprovantesNaoFiscais ;
end;

procedure TACBrECF.CarregaComprovantesNaoFiscais;
begin
  ComandoLOG := 'CarregaComprovantesNaoFiscais' ;
  fsECF.CarregaComprovantesNaoFiscais ;
end;

procedure TACBrECF.LerTotaisComprovanteNaoFiscal;
begin
  ComandoLOG := 'LerTotaisComprovanteNaoFiscal' ;
  fsECF.LerTotaisComprovanteNaoFiscal ;
end;

function TACBrECF.AchaCNFDescricao( Descricao: String; BuscaExata : Boolean;
   IgnorarCase : Boolean ): TACBrECFComprovanteNaoFiscal;
begin
  ComandoLOG := 'AchaCNFDescricao( '+Descricao+', '+BoolToStr(BuscaExata)+', '+
                                                    BoolToStr(IgnorarCase)+' )' ;
  Result := fsECF.AchaCNFDescricao( Descricao, BuscaExata, IgnorarCase ) ;
end;

function TACBrECF.AchaCNFIndice(
  Indice: String): TACBrECFComprovanteNaoFiscal;
begin
  ComandoLOG := 'AchaCNFIndice( '+Indice+' )' ;
  Result := fsECF.AchaCNFIndice( Indice ) ;
end;

function TACBrECF.AchaCNFFormaPagamento(
  CodFPG: String): TACBrECFComprovanteNaoFiscal;
begin
  ComandoLOG := 'AchaCNFFormaPagamento( '+CodFPG+' )' ;
  Result := fsECF.AchaCNFFormaPagamento( CodFPG ) ;
end;

procedure TACBrECF.ProgramaComprovanteNaoFiscal(var Descricao: String;
  Tipo: String; Posicao : String);
begin
  ComandoLOG := 'ProgramaComprovanteNaoFiscal( '+Descricao+' , '+Tipo+' , '+
                    Posicao+' )';
  fsECF.ProgramaComprovanteNaoFiscal(Descricao, Tipo, Posicao);
end;


function TACBrECF.AchaUMDDescricao(
  Descricao: String): TACBrECFUnidadeMedida;
begin
  ComandoLOG := 'AchaUMDDescricao( '+Descricao+' )' ;
  Result := fsECF.AchaUMDDescricao( Descricao ) ;
end;

function TACBrECF.AchaUMDIndice(Indice: String): TACBrECFUnidadeMedida;
begin
  ComandoLOG := 'AchaUMDIndice( '+Indice+' )' ;
  Result := fsECF.AchaUMDIndice( Indice ) ;
end;

procedure TACBrECF.CarregaUnidadesMedida;
begin
  ComandoLOG := 'CarregaUnidadesMedida' ;
  fsECF.CarregaUnidadesMedida ;
end;

function TACBrECF.GetUnidadesMedidaClass: TACBrECFUnidadesMedida;
begin
  ComandoLOG := 'UnidadesMedida' ;
  Result := fsECF.UnidadesMedida ;
end;

procedure TACBrECF.ProgramaUnidadeMedida(var Descricao: String);
begin
  ComandoLOG := 'ProgramaUnidadeMedida( '+Descricao+' )';
  fsECF.ProgramaUnidadeMedida(Descricao);
end;

procedure TACBrECF.RelatorioGerencial(Relatorio: TStrings; const Vias: Integer;
  const Indice: Integer);
begin
  ComandoLOG := 'RelatorioGerencial( ' + Relatorio.Text + ' , ' +
                    IntToStr(Vias) + ' , ' + IntToStr(indice) + ' )' ;
  fsECF.RelatorioGerencial( Relatorio, Vias, Indice ) ;
end;

procedure TACBrECF.AbreRelatorioGerencial(Indice: Integer);
Var 
  Tratado : Boolean;
begin
  if RFDAtivo then
     fsRFD.VerificaParametros ;

  fsIndiceGerencial := Indice;
  ComandoLOG := 'AbreRelatorioGerencial' ;

  if Assigned( fOnAntesAbreRelatorioGerencial ) then
     fOnAntesAbreRelatorioGerencial( Indice);

  try
    Tratado := False;
    fsECF.AbreRelatorioGerencial(Indice) ;
  except
     if Assigned( FOnErrorAbreRelatorioGerencial ) then
        FOnErrorAbreRelatorioGerencial(Tratado, Indice);

     if not Tratado then
        raise;
  end;

  {$IFNDEF CONSOLE}
   if MemoAssigned then
   begin
      fsMemoOperacao := 'abrerelatoriogerencial' ;
      MemoAdicionaCabecalho ;
      MemoTitulo('RELATORIO GERENCIAL');
   end ;
  {$ENDIF}

  if RFDAtivo then
     fsRFD.Documento('RG') ;

  if Assigned( FOnDepoisAbreRelatorioGerencial ) then
     FOnDepoisAbreRelatorioGerencial( Indice);

end;

procedure TACBrECF.LinhaRelatorioGerencial(const Linha: AnsiString;
  const IndiceBMP: Integer);
Var
  Texto, Buffer : String ;
  Lin   : Integer ;
  SL    : TStringList ;

  Procedure TentaImprimirLinhas( Texto: AnsiString; IndiceBMP: Integer )  ;
  var
     Est : TACBrECFEstado ;
     OldTimeOut : LongInt ;
  begin
     ComandoLOG := 'LinhaRelatorioGerencial( "'+Texto+'", '+IntToStr(IndiceBMP)+' )';
     try
        fsECF.LinhaRelatorioGerencial( Texto, IndiceBMP ) ;
     except
        // Não conseguiu imprimir ? Verifique se o relatório foi fechado pelo ECF //
        OldTimeOut := TimeOut;
        TimeOut    := max(TimeOut,5);  // Tenta ler o Estado por 5 seg ou mais
        try
           Est := Estado;              // Lendo o estado do ECF

           if Est = estLivre then
           begin
              // Está Livre, provavelmente foi fechado por longo tempo de
              // impressao... (O ECF é obrigado a fechar o Gerencial após 2
              // minutos de Impressão). Vamos abrir um Novo Gerencial e Tentar
              // novamente
              AbreRelatorioGerencial(fsIndiceGerencial);
              fsECF.LinhaRelatorioGerencial( Texto, IndiceBMP );
           end ;
        finally
           TimeOut := OldTimeOut;
        end ;
     end ;
  end ;

begin
  if MaxLinhasBuffer < 1 then
   begin
     ComandoLOG := 'LinhaRelatorioGerencial( "'+Texto+'", '+IntToStr(IndiceBMP)+' )';
     fsECF.LinhaRelatorioGerencial( Linha, IndiceBMP ) ;
   end
  else
   begin
     Texto  := '' ;
     Buffer := AjustaLinhas(Linha, Colunas) ;
     SL     := TStringList.Create ;
     try
        SL.Text := Buffer ;

        For Lin := 0 to SL.Count - 1 do
        begin
           Texto := Texto + SL[Lin] + sLineBreak;

           if (Lin mod MaxLinhasBuffer) = 0 then
           begin
              TentaImprimirLinhas( Texto, IndiceBMP ) ;
              Texto := '' ;
           end ;
        end ;

        if Texto <> '' then
           TentaImprimirLinhas( Texto, IndiceBMP ) ;
     finally
        SL.Free ;
     end ;
   end ;

  {$IFNDEF CONSOLE}
   if MemoAssigned then
   begin
      fsMemoOperacao := 'linharelatoriogerencial' ;
      Buffer := AjustaLinhas( Linha, fsMemoColunas) ;
      MemoAdicionaLinha( Buffer );
   end ;
  {$ENDIF}
end;

procedure TACBrECF.CupomVinculado(COO, CodFormaPagto: String;
  Valor: Double; Relatorio: TStrings; Vias: Integer);
begin
  Valor := RoundTo( Valor, -2) ;  { Ajustando valores acima de 2 Decimais }

  ComandoLOG := 'CupomVinculado( '+COO+' , '+CodFormaPagto+' , '+
                    FloatToStr(Valor)+' , '+Relatorio.Text+' , '+
                    IntToStr(Vias)+' )';
  fsECF.CupomVinculado( COO, CodFormaPagto, '' , Valor, Relatorio, Vias );
end;

procedure TACBrECF.CupomVinculado(COO, CodFormaPagto,
  CodComprovanteNaoFiscal: String; Valor: Double; Relatorio: TStrings;
  Vias: Integer);
begin
  Valor := RoundTo( Valor, -2) ;  { Ajustando valores acima de 2 Decimais }

  ComandoLOG := 'CupomVinculado( '+COO+' , '+CodFormaPagto+' , '+
                    CodComprovanteNaoFiscal+' , '+
                    FloatToStr(Valor)+' , '+Relatorio.Text+' , '+
                    IntToStr(Vias)+' )';
  fsECF.CupomVinculado( COO, CodFormaPagto, CodComprovanteNaoFiscal, Valor,
                        Relatorio, Vias );
end;

procedure TACBrECF.AbreCupomVinculado(COO, CodFormaPagto: String;
   Valor: Double);
Var
  Tratado : Boolean;
begin
  Valor := RoundTo( Valor, -2) ;  { Ajustando valores acima de 2 Decimais }

  if Assigned( fOnAntesAbreCupomVinculado ) then
     fOnAntesAbreCupomVinculado(Self);

  ComandoLOG := 'AbreCupomVinculado( '+COO+' , '+CodFormaPagto+' , '+
                    FloatToStr(Valor)+' )';

  try
    Tratado := False;
    fsECF.AbreCupomVinculado( COO, CodFormaPagto, '', Valor);
  except
     if Assigned( fOnErrorAbreCupomVinculado ) then
        fOnErrorAbreCupomVinculado(Tratado);

     if not Tratado then
        raise;
  end;


  {$IFNDEF CONSOLE}
   if MemoAssigned then
   begin
      fsMemoOperacao := 'abrecupomvinculado' ;
      MemoAdicionaCabecalho ;
      MemoTitulo('CUPOM VINCULADO');
   end ;
  {$ENDIF}

  if RFDAtivo then
     fsRFD.Documento('CC') ;

  if Assigned( fOnDepoisAbreCupomVinculado ) then
     fOnDepoisAbreCupomVinculado(Self);

end;

procedure TACBrECF.AbreCupomVinculado(COO, CodFormaPagto,
  CodComprovanteNaoFiscal: String; Valor: Double);
begin
  Valor := RoundTo( Valor, -2) ;  { Ajustando valores acima de 2 Decimais }

  ComandoLOG := 'AbreCupomVinculado( '+COO+' , '+CodFormaPagto+' , '+
                    CodComprovanteNaoFiscal+' , '+FloatToStr(Valor)+' )';
  fsECF.AbreCupomVinculado( COO, CodFormaPagto, CodComprovanteNaoFiscal, Valor);
  
  {$IFNDEF CONSOLE}
   if MemoAssigned then
   begin
      fsMemoOperacao := 'abrecupomvinculado' ;
      MemoAdicionaCabecalho ;
      MemoTitulo('CUPOM VINCULADO');
   end ;
  {$ENDIF}
  
  if RFDAtivo then
     fsRFD.Documento('CC') ;
end;

procedure TACBrECF.LinhaCupomVinculado(const Linha: AnsiString);
Var
  Texto, Buffer : String ;
  Lin   : Integer ;
  SL    : TStringList ;
begin
  if MaxLinhasBuffer < 1 then
   begin
     ComandoLOG := 'LinhaCupomVinculado( '+Linha+' )';
     fsECF.LinhaCupomVinculado( Linha )
   end
  else
   begin
     Texto  := '' ;
     Buffer := AjustaLinhas(Linha, Colunas) ;
     SL     := TStringList.Create ;
     try
        SL.Text := Buffer ;

        For Lin := 0 to SL.Count - 1 do
        begin
           Texto := Texto + SL[Lin] + sLineBreak;
           if (Lin mod MaxLinhasBuffer) = 0 then
           begin
              ComandoLOG := 'LinhaCupomVinculado( '+Texto+' )';
              fsECF.LinhaCupomVinculado( Texto ) ;
              Texto := '' ;
           end ;
        end ;

        if Texto <> '' then
        begin
           ComandoLOG := 'LinhaCupomVinculado( '+Texto+' )';
           fsECF.LinhaCupomVinculado( Texto ) ;
        end ;
     finally
        SL.Free ;
     end ;
   end ;

  {$IFNDEF CONSOLE}
   if MemoAssigned then
   begin
      fsMemoOperacao := 'linhacupomvinculado' ;
      Buffer := AjustaLinhas( Linha, fsMemoColunas) ;
      MemoAdicionaLinha( Buffer );
   end ;
  {$ENDIF}
end;


{------------------------------------------------------------------------------}
function TACBrECF.AcharECF( ProcuraModelo : Boolean; ProcuraPorta  : Boolean;
                            ATimeOut : Integer) : Boolean ;
Var I : Integer ;
begin
  Result := false ;
  if fsProcurandoECF then exit ; { para evitar chamadas recursivas }

  if not (ProcuraModelo or ProcuraPorta) then exit ; { nada a fazer }

  if ProcuraPorta then
     Porta := 'procurar' ;

  try
     fsProcurandoECF := true ;

     if not ProcuraModelo then
        Result := AcharPorta(ATimeOut)
     else
      begin
        For I := 2 to Integer(High(TACBrECFModelo)) do { Pula ecfNenhum, ecfNaoFiscal }
        begin
           try
              if not fsProcurandoECF then
                 break ;

              Modelo := TACBrECFModelo( I ) ;

              if AcharPorta( ATimeOut ) then
              begin
                 Result := true ;
                 Break ;
              end ;
           except
           end ;
        end ;
      end
  finally
     fsProcurandoECF := false ;
     Desativar ;
     if (not Result) and ProcuraModelo then
        Modelo := ecfNenhum ;
  end ;
end;

function TACBrECF.AcharPorta(ATimeOut : Integer): Boolean;
Var wPorta : String ;
    wTimeOut  : Integer ;
    wRetentar : Boolean ;
begin
  Result := false ;
  if fsProcurandoPorta then exit ;  { para evitar chamadas recursivas }

  if fsModelo = ecfNenhum then
     raise Exception.Create(ACBrStr(cACBrECFModeloNaoDefinidoException));

  if Modelo = ecfNaoFiscal then
     raise Exception.Create(Format(ACBrStr(cACBrECFModeloBuscaPortaException),
                                   [ ModeloStr ])) ;

  wPorta   := Porta ;
  wTimeOut := TimeOut ;
  wRetentar:= ReTentar ;
  try
     fsProcurandoPorta := true ;
     ReTentar := false ;
     if ATimeOut <> 0 then
        TimeOut := ATimeOut ;

     {$IFNDEF CONSOLE}
       fsECF.FormMsgControla := False ;
       fsECF.FormMsgDoProcedure( DoAcharPorta, ord('C') ) ;
     {$ELSE}
       DoAcharPorta ;
     {$ENDIF}

     if Porta = 'abortado' then
     begin
        Porta := '' ;
        fsProcurandoECF := false ;
     end ;

     Result := (Porta <> '') ;
  finally
     {$IFNDEF CONSOLE}
       fsECF.FormMsgControla := True ;
     {$ENDIF}
     fsProcurandoPorta := false ;
     TimeOut := wTimeOut ;
     Retentar:= wReTentar ;
     if not Result then
     begin
        Desativar ;
        Porta := wPorta ;
     end ;
  end ;
end;

{------------------------------------------------------------------------------}
procedure TACBrECF.DoAcharPorta ;
  Function AtivarECF : Boolean ;
    Var Msg : String ;

  begin
     Result := false ;
     try
        Desativar ;
        try
           Device.Serial.Purge ;
        except
        end ;
        Msg := Format( ACBrStr(cACBrECFMsgDoAcharPorta), [ModeloStr, Porta] );
        if (ExibeMensagem or BloqueiaMouseTeclado) then
           Msg := Msg {$IFDEF VisualCLX}+sLineBreak{$ENDIF} +
                  ' Pressione <C> para cancelar' ;

        {$IFNDEF CONSOLE}
          fsECF.FormMsgPinta( Msg ) ;
          if not (fsECF.FormMsgEstado = fmsProcessando) then
             exit ;
        {$ENDIF}

        Ativar ;      { Se não Ativar gera uma Exceção }
        Result := true ;
     except
     end ;
  end ;

Var I : Integer ;
    Achou : Boolean ;
    SL : TStringList ;
begin
  Achou := false ;
  
  if (Porta = '') or (LowerCase(Porta) = 'procurar') then
   begin
     SL := TStringList.Create;
     try
        Device.AcharPortasSeriais( SL );

        I := 0 ;
        while (I < SL.Count) and (not Achou)
          {$IFNDEF CONSOLE} and (fsECF.FormMsgEstado = fmsProcessando) {$ENDIF} do
        begin
           Porta := SL[I] ;
           Achou := AtivarECF ;
           Inc( I ) ;
        end ;
     finally
        SL.Free ;
     end ;
   end
  else
     Achou := AtivarECF ;

  if not Achou then
  begin
     sleep(200) ;
     {$IFNDEF CONSOLE}
       if fsECF.FormMsgEstado = fmsAbortado then
          Porta := 'abortado'
       else
     {$ENDIF}
          Porta := '' ;
  end ;
end;

{$IFNDEF CONSOLE}
 procedure TACBrECF.SetMemoBobina(const Value: TMemo);
 begin
   if Value <> fsMemoBobina then
   begin
      if Assigned(fsMemoBobina) then
         fsMemoBobina.RemoveFreeNotification(Self);

      fsMemoBobina := Value;

      if Value <> nil then
         Value.FreeNotification(self);
   end ;
 end;

 procedure TACBrECF.SetMemoParams(const Value: TStrings);
 begin
   fsMemoParams.Assign(Value);
 end;

 procedure TACBrECF.MemoAdicionaCabecalho;
 begin
   MemoLeParams ;
   MemoAdicionaLinha( fsMemoCabecalho ) ;
   fsMemoItens     := 0 ;  { Zera contador de Itens }
   fsSubTotalPagto := 0;   {Zera o total pago verificador da bobina} //lampada 
 end;

 procedure TACBrECF.MemoTitulo(ATitulo: String) ;
 begin
   MemoAdicionaLinha( '<h' +IntToStr(fsMemoHTMLTitleSise)+'><center>'+
                      ATitulo+'</center></h'+IntToStr(fsMemoHTMLTitleSise)+'>' ) ;
 end;

 function TACBrECF.MemoAssigned: Boolean;
 begin
   Result := Assigned( fsMemoBobina ) or Assigned( fsOnBobinaAdicionaLinhas ) ;
 end;

 procedure TACBrECF.MemoSubtotaliza(DescontoAcrescimo: Double );
 Var
    S : String ;
 begin
   fsMemoOperacao  := 'subtotalizanaofiscal' ;
   fsSubTotalPagto := Subtotal;

   {Para que na condição de pagamento, não precise ficar pegando toda hora}
   {o subtotal, evitando ficar mandando para a impressora }
   if DescontoAcrescimo <> 0 then
   begin
      if DescontoAcrescimo < 0 then
         S := 'Desconto '
      else
         S := 'Acrescimo' ;

      MemoAdicionaLinha( '<table width=100%><tr>'+
                         '<td align=left><b>SUBTOTAL   R$</b></td>'+
                         '<td align=right>'+FormatFloat('#,###,##0.00',
                         fsSubTotalPagto - DescontoAcrescimo)+'</td>'+
                         '</tr></table>' ) ;
      MemoAdicionaLinha( '<table width=100%><tr>'+
                         '<td align=left><b>'+S+'  R$</b></td>'+
                         '<td align=right>'+FormatFloat('#,###,##0.00',DescontoAcrescimo)+'</td>'+
                         '</tr></table>' ) ;
   end ;

   MemoTitulo( '<table width=100%><tr>'+
               '<td align=left>TOTAL  R$</td>'+
               '<td align=right>'+FormatFloat('#,###,##0.00',fsSubTotalPagto)+'</td>'+
               '</tr></table>' ) ;

   fsMemoItens := 0 ;  { Zera para acumular o numero de Pagamentos }
 end ;

 procedure TACBrECF.MemoEfetuaPagamento(Descricao: String; Valor: Double;
    Observacao: String) ;
 Var
    TotPago,  Troco : Double ;
 begin
    fsMemoOperacao := 'efetuapagamento' ;
    Inc( fsMemoItens ) ;

    MemoAdicionaLinha( '<table width=100%><tr>'+
                       '<td align=left><b>'+Descricao+'</b></td>'+
                       '<td align=right>'+FormatFloat('#,###,##0.00',Valor)+'</td>'+
                       '</tr></table>' ) ;

    Observacao := AjustaLinhas( Observacao, fsMemoColunas, 2 ) ;
    MemoAdicionaLinha( Observacao );

    TotPago := TotalPago ;  { Le valores do ECF }
//  fsTotalPago := fsTotalPago + Valor;

    if TotPago >= fsSubTotalPagto then   { Ultrapassou o Valor do Cupom }
    begin
       if fsMemoItens > 1 then
          MemoAdicionaLinha( '<table width=100%><tr>'+
                             '<td align=left><b>S O M A  R$</b></td>'+
                             '<td align=right>'+FormatFloat('#,###,##0.00',TotPago)+'</td>'+
                             '</tr></table>' ) ;

      if TotPago > fsSubTotalPagto then  { Tem TROCO ? }
      begin
         Troco  := RoundTo(TotPago - fsSubTotalPagto,-2) ;
         MemoTitulo( '<table width=100%><tr>'+
                     '<td align=left>TROCO  R$</td>'+
                     '<td align=right>'+FormatFloat('#,###,##0.00',Troco)+'</td>'+
                     '</tr></table>' ) ;
      end ;
   end ;
 end ;


 procedure TACBrECF.MemoLeParams;
  Var I : Integer ;
      T, S : String ;
      INI : TMemIniFile ;
 begin
   INI := TMemIniFile.Create('acbrecfmemo.ini') ;
   try
      INI.SetStrings( fsMemoParams );

      fsMemoColunas       := INI.ReadInteger('Formato','Colunas', fsMemoColunas) ;
      fsMemoHTML          := INI.ReadBool('Formato','HTML', fsMemoHTML) ;
      fsMemoHTMLTitleSise := INI.ReadInteger('Formato','HTML_Title_Size',
                                             fsMemoHTMLTitleSise) ;
      fsMemoHTMLFont      := INI.ReadString('Formato','HTML_Font', fsMemoHTMLFont) ;
      fsMemoMascItens     := INI.ReadString('Cabecalho_Item','MascaraItem',
                                             fsMemoMascItens) ;

      fsMemoCabecalho := '' ;
      I := 0 ;
      while true do
      begin
         S := 'LIN'+IntToStrZero( I, 3) ;
         T := INI.ReadString('Cabecalho', S, '*FIM*') ;

         if T = '*FIM*' then break ;

         fsMemoCabecalho := fsMemoCabecalho + T + sLineBreak ;
         Inc( I ) ;
      end ;

      fsMemoRodape := '' ;
      I := 0 ;
      while true do
      begin
         S := 'LIN'+IntToStrZero( I, 3) ;
         T := INI.ReadString('Rodape', S, '*FIM*') ;

         if T = '*FIM*' then break ;

         fsMemoRodape := fsMemoRodape + T + sLineBreak ;
         Inc( I ) ;
      end ;

      fsMemoCabItens := '' ;
      I := 0 ;
      while true do
      begin
         S := 'LIN'+IntToStrZero( I, 3) ;
         T := INI.ReadString('Cabecalho_Item', S, '*FIM*') ;

         if T = '*FIM*' then break ;

         fsMemoCabItens := fsMemoCabItens + T + sLineBreak ;
         Inc( I ) ;
      end ;
   finally
      INI.Free ;
   end ;
 end;

 procedure TACBrECF.MemoAdicionaLinha(Linhas: String);
  Var SL : TStringList ;
      I,P : Integer ;
      NewLinhas,L,L2  : String ;
      InHTML, Centraliza, Tabela : Boolean ;
 begin
   if Linhas = '' then exit ;

   Linhas := StringReplace(Linhas,CR+LF,#10,[rfReplaceAll]) ;
   Linhas := StringReplace(Linhas,sLineBreak,#10,[rfReplaceAll]) ;
   Linhas := StringReplace(Linhas,#10,sLineBreak,[rfReplaceAll]) ;

   Linhas := MemoTraduzCode( Linhas ) ;

   { Processando linha a linha conforme o valor de fsMemoHTML }
   NewLinhas := '' ;
   SL := TStringList.Create ;
   try
      SL.Text := Linhas ;

      For I := 0 to SL.Count-1 do
      begin
         L := SL[I] ;

         if fsMemoHTML then
          begin
            if pos(LowerCase(RightStr(L,9)),'</center></left></right></table><br><hr>') = 0 then
               L := L + '<br>' ;

            { Html não respeita espaços grandes }
            L := StringReplace(L,'  ','&nbsp;&nbsp;',[rfReplaceAll]) ;
            if LeftStr(L,1) = ' ' then
               L := '&nbsp;' + copy(L,2,Length(L)) ;
          end
         else
          begin
            if LowerCase( Trim(L) ) = '<hr>' then
               L2 := StringofChar('-',fsMemoColunas)
            else
             begin
               L          := StringReplace(L,'<br>',sLineBreak,[rfReplaceAll]) ;
               Centraliza := (pos('<center>',LowerCase(L)) > 0) ;  { é para centralizar ? }
               Tabela     := (pos('<tr>',LowerCase(L)) > 0) ;      { é Tabela }
               if Tabela then
               begin
                  L := StringReplace(L,'</td>','|',[rfReplaceAll]) ;
                  P := LastDelimiter('|',L) ; { Remove ultimo separador }
                  L := StuffString(L,P,1,'') ;
               end ;

               { Removendo todas as TAGs HTML }
               L2         := '' ;
               InHTML     := False ;
               For P := 1 to Length( L ) do
               begin
                  if not InHTML then
                   begin
                     if (L[P] = '<') and (PosEx('>',L,P) > 0)  then
                        InHTML := True
                     else
                        L2 := L2 + L[P] ;
                   end
                  else
                     if L[P] = '>' then
                        InHTML := False ;
               end ;

               if Tabela then
                  L2 := padS( L2, fsMemoColunas,'|')
               else if Centraliza then
                  L2 := padC( L2, fsMemoColunas) ;
             end ;

            L := L2 + sLineBreak ;
          end ;

         NewLinhas := NewLinhas + L  ;
      end ;

      if not fsMemoHTML then
       begin
         { Remove ultima quebra de linha (para não ficar um pulo a mais ) }
         if RightStr(NewLinhas,Length(sLineBreak)) = sLineBreak then
            NewLinhas := LeftStr(NewLinhas,Length(NewLinhas)-Length(sLineBreak)) ;
       end
      else
         { Insere comando de formatação de fonte }
         if fsMemoHTMLFont <> '' then
            NewLinhas := fsMemoHTMLFont + NewLinhas + '</font>' ;
   finally
      SL.Free ;
   end ;

   if Assigned( fsMemoBobina ) then
      fsMemoBobina.Lines.Add( NewLinhas ) ;

   if Assigned( fsOnBobinaAdicionaLinhas ) then
      fsOnBobinaAdicionaLinhas( NewLinhas, fsMemoOperacao ) ;
 end;

function TACBrECF.MemoTraduzCode(Linha: String): String;
var P1, P2 : Integer ;
    Code, Buffer : AnsiString ;
begin
  while True do
  begin
     Buffer := LowerCase(Linha) ;
     P1     := pos('<code>',Buffer) ;
     P2     := pos('</code>',Buffer) ;

     if (P1 = 0) or (P2 < P1) then
        break ;

     Code := copy( Buffer, P1+6, P2-P1-6) ;

     if Code = 'data' then
        Code := FormatDateTime('dd/mm/yyyy',now)
     else if Code = 'hora' then
        Code := FormatDateTime('hh:nn:ss',now)
     else if Code = 'numcupom' then
        Code := NumCupom
     else if Code = 'numcoo' then
        Code := NumCOO
     else if Code = 'numserie' then
        Code := NumSerie
     else if Code = 'numseriemfd' then
        Code := NumSerieMFD
     else if Code = 'numecf' then
        Code := NumECF
     else if Code = 'acbr' then
        Code := ACBR_VERSAO ;

     Linha := copy(Linha,1,P1-1) + Code + copy(Linha,P2+7,Length(Linha)) ;
  end ;

  Result := Linha ;
end;
{$ENDIF}

procedure TACBrECF.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);

  {$IFNDEF CONSOLE}
   if (Operation = opRemove) and (fsMemoBobina <> nil) and (AComponent is TMemo) then
   begin
      fsMemoBobina := nil ;
   end ;
  {$ENDIF}

  if (Operation = opRemove) and (fsRFD <> nil) and (AComponent is TACBrRFD) then
     fsRFD := nil ;
end;

procedure TACBrECF.SetRFD(const Value: TACBrRFD);
 Var OldValue: TACBrRFD ;
begin
  if fsAtivo then
     raise Exception.Create(ACBrStr(cACBrECFSetRFDException));

  if Value <> fsRFD then
  begin
     if Assigned(fsRFD) then
        fsRFD.RemoveFreeNotification(Self);

     OldValue := fsRFD ;   // Usa outra variavel para evitar Loop Infinito
     fsRFD    := Value;    // na remoção da associação dos componentes

     if Assigned(OldValue) then
        if Assigned(OldValue.ECF) then
           OldValue.ECF := nil ;

     if Value <> nil then
     begin
        Value.FreeNotification(self);
        Value.ECF := self ;
     end ;
  end ;
end;

function TACBrECF.RFDAtivo: Boolean;
begin
  Result := False ;
  if Assigned( fsRFD ) then
     Result := fsRFD.Ativo ;
end;

procedure TACBrECF.ArredondarPorQtd(var Qtd: Double; const ValorUnitario: Double;
       const Precisao : Integer = -2 );
Var Pot, AddVal : Double ;
    TotalRound, TotalTrunc : Integer ;
begin
  Pot    := Power(10, -Precisao) ;
  AddVal := 1 / Power(10,DecimaisQtd) ;

  TotalRound := Trunc(SimpleRoundTo( Qtd * ValorUnitario * Pot, 0)) ;
  TotalTrunc := TruncFix(Qtd * ValorUnitario * Pot)  ;

  while TotalTrunc < TotalRound do
  begin
     Qtd        := RoundTo(Qtd + AddVal, -DecimaisQtd) ;
     TotalTrunc := TruncFix(Qtd * ValorUnitario * Pot)  ;

   { Se passou do Valor Arredondado, é melhor deixar utimo valor (truncado)
     Isso pode ocorrer se o Preço Unitário é grande...
     nesses casos não há como ajustar... :-(                                }
     if TotalTrunc > TotalRound then
     begin
        Qtd := RoundTo(Qtd - AddVal, -DecimaisQtd) ;
        break ;
     end ;
  end ;
end;

function TACBrECF.AssinaArquivoComEAD(Arquivo: String): Boolean;
begin
  if Assigned( fsOnPAFCalcEAD ) then
     fsOnPAFCalcEAD( Arquivo )
  else
     fsACBrEAD.AssinarArquivoComEAD( Arquivo ) ;

  Result := True;
end;

procedure TACBrECF.IdentificaOperador(Nome: String);
begin
  ComandoLOG := 'IdentificaOperador('+Nome+')';

  fsECF.IdentificaOperador(Nome);
  fsECF.Operador := Nome ;
  fsIdentificarOperador := False ;
end;

procedure TACBrECF.IdentificaPAF(Linha1, Linha2: String);
begin
  ComandoLOG := 'IdentificaPAF('+Linha1+' , '+Linha2+')';

  fsECF.IdentificaPAF(Linha1, Linha2);
end;

Function TACBrECF.RetornaInfoECF( Registrador : String ) : AnsiString;
begin
  ComandoLOG := 'RetornaInfoECF('+Registrador+')';

  Result := fsECF.RetornaInfoECF( Registrador );
end;

function TACBrECF.GetCodBarrasClass: TACBrECFCodBarras;
begin
  Result := fsECF.CodBarras ;
end;

function TACBrECF.DecodificaTexto(Operacao: Char; Texto: String;
  var Resposta: String): Boolean;
begin
   ComandoLOG := 'DecodificaTexto';
   Result := fsECF.DecodificaTexto(Operacao,Texto,Resposta) ;
end;

procedure TACBrECF.InformaCodBarras(TipoBarra: TACBrECFTipoCodBarra;
  LanguraBarra, AlturaBarra: Integer; CodBarra: String;
  ImprimeCodEmbaixo: Boolean);
begin
  fsECF.CodBarras.AdicionarCodBarra(TipoBarra, LanguraBarra, AlturaBarra,
      CodBarra, ImprimeCodEmbaixo);
end;


(* Muita coisa a fazer....

LeituraXSerial

CancelaUltimoItem( 0 )

07 GNF (Contador Geral de Operação Não Fiscal)
Número do GNF relativo ao respectivo documento, quando houver

08 GRG (Contador Geral de Relatório Gerencial)
Número do GRG relativo ao respectivo documento (vide item 6.16.1.4)

09 CDC (Contador de Comprovante de Crédito ou Débito)
Número do CDC relativo ao respectivo documento
(vide item 6.16.1.5)

- DescontoItemVendido

- TotalDescontosISS
- TotalAcrescimosISS
- TotalCancelamentosISS

- Aliquotas: FS, NS e IS (Substituição, Nao icidencia e Isenção em ISSQN)

- TotalSubstituicaoTributariaISS
- TotalNaoTributadoISS
- TotalIsencaoISS
 *)

function TACBrECF.GetAbout: String;
begin
   Result := 'ACBrECF Ver: '+CACBrECF_Versao;
end;

procedure TACBrECF.SetAbout(const Value: String);
begin
   {}
end;

//*** Opcoes do menu fiscal do paf-ecf

procedure TACBrECF.PafMF_LX_Impressao;
begin
  Self.LeituraX;
end;

procedure TACBrECF.PafMF_LMFC_Impressao(const CRZInicial, CRZFinal: Integer);
begin
  Self.LeituraMemoriaFiscal(CRZInicial, CRZFinal, False);
end;

procedure TACBrECF.PafMF_LMFC_Impressao(const DataInicial,
  DataFinal: TDateTime);
begin
  Self.LeituraMemoriaFiscal(DataInicial, DataFinal, False);
end;

procedure TACBrECF.PafMF_LMFC_Espelho(const CRZInicial, CRZFinal: Integer;
  const PathArquivo: String);
begin
  Self.LeituraMemoriaFiscalSerial(CRZInicial, CRZFinal, PathArquivo, False);
  Self.AssinaArquivoComEAD(PathArquivo);
end;

procedure TACBrECF.PafMF_LMFC_Espelho(const DataInicial, DataFinal: TDateTime;
  const PathArquivo: String);
begin
  Self.LeituraMemoriaFiscalSerial(DataInicial, DataFinal, PathArquivo, False);
  Self.AssinaArquivoComEAD(PathArquivo);
end;

procedure TACBrECF.PafMF_LMFC_Cotepe1704(const CRZInicial, CRZFinal: Integer;
  const PathArquivo: String);
begin
  Self.ArquivoMFD_DLL(CRZInicial, CRZFinal, PathArquivo, [docTodos], finMF);
  Self.AssinaArquivoComEAD(PathArquivo);
end;

procedure TACBrECF.PafMF_LMFC_Cotepe1704(const DataInicial, DataFinal: TDateTime;
  const PathArquivo: String);
begin
  Self.ArquivoMFD_DLL(DataInicial, DataFinal, PathArquivo, [docTodos], finMF);
  Self.AssinaArquivoComEAD(PathArquivo);
end;

procedure TACBrECF.PafMF_LMFS_Impressao(const CRZInicial, CRZFinal: Integer);
begin
  Self.LeituraMemoriaFiscal(CRZInicial, CRZFinal, True);
end;

procedure TACBrECF.PafMF_LMFS_Impressao(const DataInicial,
  DataFinal: TDateTime);
begin
  Self.LeituraMemoriaFiscal(DataInicial, DataFinal, True);
end;

procedure TACBrECF.PafMF_LMFS_Espelho(const CRZInicial, CRZFinal: Integer;
  const PathArquivo: String);
begin
  Self.LeituraMemoriaFiscalSerial(CRZInicial, CRZFinal, PathArquivo, True);
  Self.AssinaArquivoComEAD(PathArquivo);
end;

procedure TACBrECF.PafMF_LMFS_Espelho(const DataInicial, DataFinal: TDateTime;
  const PathArquivo: String);
begin
  Self.LeituraMemoriaFiscalSerial(DataInicial, DataFinal, PathArquivo, True);
  Self.AssinaArquivoComEAD(PathArquivo);
end;

procedure TACBrECF.PafMF_MFD_Espelho(const COOInicial, COOFinal: Integer;
  const PathArquivo: String);
begin
  Self.EspelhoMFD_DLL(CooInicial, CooFinal, PathArquivo, [docTodos]);
  Self.AssinaArquivoComEAD(PathArquivo);
end;

procedure TACBrECF.PafMF_MFD_Espelho(const DataInicial, DataFinal: TDateTime;
  const PathArquivo: String);
begin
  Self.EspelhoMFD_DLL(DataInicial, DataFinal, PathArquivo, [docTodos]);
  Self.AssinaArquivoComEAD(PathArquivo);
end;

procedure TACBrECF.PafMF_MFD_Cotepe1704(const COOInicial, COOFinal: Integer;
  const PathArquivo: String);
begin
  Self.ArquivoMFD_DLL(CooInicial, CooFinal, PathArquivo, [docTodos], finMFD);
  Self.AssinaArquivoComEAD(PathArquivo);
end;

procedure TACBrECF.PafMF_MFD_Cotepe1704(const DataInicial, DataFinal: TDateTime;
  const PathArquivo: String);
begin
  Self.ArquivoMFD_DLL(DataInicial, DataFinal, PathArquivo, [docTodos], finMFD);
  Self.AssinaArquivoComEAD(PathArquivo);
end;

procedure TACBrECF.PafMF_RelMeiosPagamento(
  const AFormasPagamento: TACBrECFFormasPagamento;
  const ATituloRelatorio: String;
  const AIndiceRelatorio: Integer);
var
  DataAtual: TDateTime;
  Relatorio: TStringList;
  I: Integer;
  TamLin: Integer;
  SubTTFiscal: Double;
  SubTTNFiscal: Double;
  FPAcumuladas: TACBrECFFormasPagamento;
  FPTotalizado: TACBrECFFormasPagamento;

  function ProcurarDataDescricao(const AFormaPagto: TACBrECFFormaPagamento;
    const AFormasPagamento: TACBrECFFormasPagamento) :TACBrECFFormaPagamento;
  var
    I: Integer;
  begin
    Result := nil;
    for I := 0 to AFormasPagamento.Count - 1 do
    begin
      if (AFormaPagto.Data = AFormasPagamento[I].Data) and
        (AnsiUpperCase(AFormasPagamento[I].Descricao) = AnsiUpperCase(AFormaPagto.Descricao)) then
      begin
        Result := AFormasPagamento[I];
        Exit;
      end;
    end;
  end;

  procedure AcumularValorFP(const AFormaPagto: TACBrECFFormaPagamento;
    var ALista: TACBrECFFormasPagamento);
  var
    FP: TACBrECFFormaPagamento;
  begin
    FP := ProcurarDataDescricao(AFormaPagto, ALista);
    if FP <> nil then
    begin
      FP.ValorFiscal    := FP.ValorFiscal    + AFormaPagto.ValorFiscal;
      FP.ValorNaoFiscal := FP.ValorNaoFiscal + AFormaPagto.ValorNaoFiscal;
    end
    else
    begin
      with ALista.New do
      begin
        Data           := AFormaPagto.Data;
        Descricao      := AFormaPagto.Descricao;
        ValorFiscal    := AFormaPagto.ValorFiscal;
        ValorNaoFiscal := AFormaPagto.ValorNaoFiscal;
      end;
    end;
  end;

  procedure AddCabecalho(const AData: TDateTime);
  begin
    if AData > 0 then
    begin
      Relatorio.Add('');
      Relatorio.Add(padC('DATA DE ACUMULACAO: ' + FormatDateTime('dd/mm/yyyy', AData), TamLin));
      Relatorio.Add('');
    end;

    Relatorio.Add('Identificacao      Vl. Fiscal     Vl. Nao Fiscal');
    Relatorio.Add(LinhaSimples(TamLin));
  end;

  procedure AddSubTotal;
  begin
    Relatorio.Add(LinhaSimples(TamLin));
    Relatorio.Add(Format('Sub-Total          R$%12.2n R$%12.2n', [SubTTFiscal, SubTTNFiscal]));
    Relatorio.Add('');
    Relatorio.Add('');

    SubTTFiscal  := 0.00;
    SubTTNFiscal := 0.00;
  end;

begin
  TamLin := 48;//fsECF.Colunas;

  // montagem do relatorio
  Relatorio := TStringList.Create;
  try
    Relatorio.Clear;
    Relatorio.Add('');

    if AIndiceRelatorio <= 0 then
      Relatorio.Add(padC('MEIOS DE PAGAMENTO', TamLin));

    if Trim(ATituloRelatorio) <> '' then
      Relatorio.Add(padC(ATituloRelatorio, TamLin));

    // ********* impressão do relatório acumulando por data e descricao ********
    FPAcumuladas := TACBrECFFormasPagamento.Create;
    FPTotalizado := TACBrECFFormasPagamento.Create;
    try
      // acumular as formas por data e descricao
      FPAcumuladas.Clear;
      AFormasPagamento.Ordenar;
      for I := 0 to AFormasPagamento.Count - 1 do
        AcumularValorFP(AFormasPagamento[I], FPAcumuladas);

      // gerar o relatório
      DataAtual := 0.0;
      FPAcumuladas.Ordenar;
      for I := 0 to FPAcumuladas.Count - 1 do
      begin
        if DataAtual <> FPAcumuladas[I].Data then
        begin
          // SUB-TOTAL
          if (DataAtual > 0) then
            AddSubTotal;

          // cabecalho
          DataAtual := FPAcumuladas[I].Data;
          AddCabecalho(DataAtual);
        end;

        // dados dos pagamentos
        Relatorio.Add(Format('%s %s %s', [
          padL(FPAcumuladas[I].Descricao, 18),
          Format('R$%12.2n', [FPAcumuladas[I].ValorFiscal]),
          Format('R$%12.2n', [FPAcumuladas[I].ValorNaoFiscal])
        ]));

        // acumuladores
        AcumularValorFP(FPAcumuladas[I], FPTotalizado);
        SubTTFiscal  := SubTTFiscal  + FPAcumuladas[I].ValorFiscal;
        SubTTNFiscal := SubTTNFiscal + FPAcumuladas[I].ValorNaoFiscal;
      end;

      // sub-total do ultimo dia
      AddSubTotal;

      // ************ impressão do total geral ************
      Relatorio.Add('');
      Relatorio.Add(padC('TOTAL GERAL', TamLin));
      if Trim(ATituloRelatorio) <> '' then
        Relatorio.Add(padC(ATituloRelatorio, TamLin));

      Relatorio.Add('');
      AddCabecalho(0);

      // acumular os valores totais das formas
      FPAcumuladas.Clear;
      FPTotalizado.Ordenar;
      for I := 0 to FPTotalizado.Count - 1 do
      begin
        FPTotalizado[I].Data := 0;
        AcumularValorFP(FPTotalizado[I], FPAcumuladas);
      end;

      SubTTFiscal  := 0.00;
      SubTTNFiscal := 0.00;
      FPAcumuladas.Ordenar;
      for I := 0 to FPAcumuladas.Count - 1 do
      begin
        Relatorio.Add(Format('%s %s %s', [
          padL(FPAcumuladas[I].Descricao, 18),
          Format('R$%12.2n', [FPAcumuladas[I].ValorFiscal]),
          Format('R$%12.2n', [FPAcumuladas[I].ValorNaoFiscal])
        ]));

        SubTTFiscal  := SubTTFiscal  + FPAcumuladas[I].ValorFiscal;
        SubTTNFiscal := SubTTNFiscal + FPAcumuladas[I].ValorNaoFiscal;
      end;

      // somatorio total
      Relatorio.Add(LinhaSimples(TamLin));
      Relatorio.Add(Format('TOTAL              R$%12.2n R$%12.2n', [SubTTFiscal, SubTTNFiscal]));
      Relatorio.Add('');
    finally
      FPTotalizado.Free;
    end;

    // impressão do relatório
    Self.RelatorioGerencial(Relatorio, 1, AIndiceRelatorio);
  finally
    Relatorio.Free;
  end;
end;

procedure TACBrECF.PafMF_RelDAVEmitidos(const DAVsEmitidos: TACBrECFDAVs;
  const TituloRelatorio: String;
  const IndiceRelatorio: Integer);
var
  Relatorio: TStringList;
  TamanhoLinha: Integer;
  I: Integer;
begin
  // montagem do relatorio
  Relatorio := TStringList.Create;
  try
    TamanhoLinha  := fsECF.Colunas;

    Relatorio.Clear;
    Relatorio.Add('');

    if IndiceRelatorio <= 0 then
      Relatorio.Add(padC('DAV EMITIDOS', TamanhoLinha));

    if Trim(TituloRelatorio) <> '' then
    begin
      Relatorio.Add(padC(TituloRelatorio, TamanhoLinha));
      Relatorio.Add('');
    end;

    Relatorio.Add('NUMERO  TITULO  EMISSAO  COO  CCF  VL.TOTAL');
    Relatorio.Add(LinhaSimples(TamanhoLinha));

    DAVsEmitidos.Ordenar;
    for I := 0 to DAVsEmitidos.Count - 1 do
    begin
      Relatorio.Add(Format('%10.10d %s', [DAVsEmitidos[I].Numero, PadL(DAVsEmitidos[I].Titulo, TamanhoLinha - 11)]));
      Relatorio.Add(Format('%s %6.6d %6.6d R$ %s', [
        FormatDateTime('dd/mm/yyyy', DAVsEmitidos[I].DtEmissao),
        DAVsEmitidos[I].COO_Dav,
        DAVsEmitidos[I].COO_Cupom,
        PadR(FormatFloat(',#0.00', DAVsEmitidos[I].Valor), TamanhoLinha - 28, ' ')
      ]));
      Relatorio.Add('');
    end;

    Relatorio.Add(LinhaSimples(TamanhoLinha));
    Relatorio.Add(Format('%d DAV listado(s)', [DAVsEmitidos.Count]));

    // impressão do relatório
    Self.RelatorioGerencial(Relatorio, 1, IndiceRelatorio);
  finally
    Relatorio.Free;
  end;
end;

procedure TACBrECF.PafMF_RelIdentificacaoPafECF(
  const IdentificacaoPaf: TACBrECFIdentificacaoPAF;
  const IndiceRelatorio: Integer);
var
  Relatorio: TStringList;
  I: Integer;
  TamLin: Integer;
begin
  Relatorio := TStringList.Create;
  try
    TamLin := ECF.Colunas;

    Relatorio.Clear;
    Relatorio.Add('');

    if IndiceRelatorio <= 0 then
      Relatorio.Add(padC('IDENTIFICACAO DO PAF-ECF', TamLin));

    Relatorio.Add(LinhaDupla(TamLin));
    Relatorio.Add(padC('LAUDO NUMERO: ' + IdentificacaoPaf.NumeroLaudo, TamLin));
    Relatorio.Add(LinhaDupla(TamLin));

    Relatorio.Add('');
    Relatorio.Add(padC('EMPRESA DESENVOLVEDORA', TamLin));
    Relatorio.Add(LinhaSimples(TamLin));
    Relatorio.Add('CNPJ........: ' + IdentificacaoPaf.Empresa.CNPJ);
    Relatorio.Add('Razao Social: ' + IdentificacaoPaf.Empresa.RazaoSocial);
    Relatorio.Add('Endereco....: ' + IdentificacaoPaf.Empresa.Endereco);
    Relatorio.Add('Cidade/UF...: ' + IdentificacaoPaf.Empresa.Cidade + '/' + IdentificacaoPaf.Empresa.Uf);
    Relatorio.Add('CEP.........: ' + IdentificacaoPaf.Empresa.Cep);
    Relatorio.Add('Telefone....: ' + IdentificacaoPaf.Empresa.Telefone);
    Relatorio.Add('Contato.....: ' + IdentificacaoPaf.Empresa.Contato);

    Relatorio.Add('');
    Relatorio.Add(padC('IDENTIFICACAO DO PAF-ECF', TamLin));
    Relatorio.Add(LinhaSimples(TamLin));
    Relatorio.Add('Nome Comerc.: ' + IdentificacaoPaf.Paf.Nome);
    Relatorio.Add('Versao......: ' + IdentificacaoPaf.Paf.Versao);
    Relatorio.Add('Versao ER...: ' + IdentificacaoPaf.VersaoER);
    Relatorio.Add('Princ. Exec.: ' + IdentificacaoPaf.Paf.PrincipalExe.Nome);
    Relatorio.Add('MD5.........: ' + IdentificacaoPaf.Paf.PrincipalExe.MD5);

    Relatorio.Add('');
    Relatorio.Add(padC('OUTROS ARQUIVOS UTILIZADOS', TamLin));
    Relatorio.Add(LinhaSimples(TamLin));
    for I := 0 to IdentificacaoPaf.OutrosArquivos.Count - 1 do
    begin
      Relatorio.Add(ExtractFileName(IdentificacaoPaf.OutrosArquivos[I].Nome));
      Relatorio.Add('MD5: ' + IdentificacaoPaf.OutrosArquivos[I].MD5);
    end;

    Relatorio.Add('');
    Relatorio.Add(padC('ARQ. LISTA AUTENTICADOS', TamLin));
    Relatorio.Add(LinhaSimples(TamLin));
    Relatorio.Add(ExtractFileName(IdentificacaoPaf.ArquivoListaAutenticados.Nome));
    Relatorio.Add('MD5: ' + IdentificacaoPaf.ArquivoListaAutenticados.MD5);

    Relatorio.Add('');
    Relatorio.Add(padC('ECFS AUTORIZADOS', TamLin));
    Relatorio.Add(LinhaSimples(TamLin));
    for I := 0 to IdentificacaoPaf.ECFsAutorizados.Count - 1 do
      Relatorio.Add(IdentificacaoPaf.ECFsAutorizados.Strings[I]);

    // impressão do relatório
    Self.RelatorioGerencial(Relatorio, 1, IndiceRelatorio);
  finally
    Relatorio.Free;
  end;
end;

end.

