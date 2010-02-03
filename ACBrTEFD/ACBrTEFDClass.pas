{******************************************************************************}
{ Projeto: Componentes ACBr                                                    }
{  Biblioteca multiplataforma de componentes Delphi para interação com equipa- }
{ mentos de Automação Comercial utilizados no Brasil                           }
{                                                                              }
{ Direitos Autorais Reservados (c) 2004 Daniel Simoes de Almeida               }
{                                                                              }
{ Colaboradores nesse arquivo:                                                 }
{                                                                              }
{  Você pode obter a última versão desse arquivo na pagina do  Projeto ACBr    }
{ Componentes localizado em      http://www.sourceforge.net/projects/acbr      }
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
|* 21/11/2009: Daniel Simoes de Almeida
|*  - Primeira Versao: Criaçao e Distribuiçao da Primeira Versao
******************************************************************************}

{$I ACBr.inc}

unit ACBrTEFDClass ;

interface

uses
  Classes, SysUtils, contnrs
  {$IFNDEF CONSOLE}
    {$IFDEF VisualCLX}
       ,QForms, QDialogs, QControls
    {$ELSE}
       ,Forms, Dialogs, Controls
    {$ENDIF}
  {$ENDIF} ;

const
   CACBrTEFD_Versao      = '1.2b' ;
   CACBrTEFD_EsperaSTS   = 7 ;
   CACBrTEFD_EsperaSleep = 250 ;
   CACBrTEFD_NumVias     = 2 ;

type

  { Tipos de TEF Existente. Cado novo Tipo de Tef precisa de uma NOVA Classe,
    filha de  TACBrTEFDClass }
  TACBrTEFDTipo = ( gpNenhum, gpTefDial, gpTefDisc, gpHiperTef, gpCliSiTef
                    {, gpGoodCard, gpFoxWin} ) ;

  TACBrTEFDReqEstado = ( reqNenhum,             // Nennhuma Requisição em andamento
                         reqIniciando,          // Iniciando uma nova Requisicao
                         reqCriandoArquivo,     // Arquivo Temporário de requisição está sendo criado
                         reqAguardandoResposta,  // Requisição Escrita, Aguardando Resposta
                         reqConferindoResposta, // Verifica se o STS é válido
                         reqFinalizada ) ;

  TACBrTEFDRespEstado = ( respNenhum,              // Nennhuma Resposta em andamento
                          respAguardandoResposta,   // Requisição Escrita, Aguardando Resposta
                          respProcessando,         // Processando a Resposta
                          respConcluida ) ;

  EACBrTEFDErro              = class(Exception) ;
  EACBrTEFDGPNaoResponde     = class(EACBrTEFDErro) ;
  EACBrTEFDGPNaoInicializado = class(EACBrTEFDErro) ;
  EACBrTEFDSTSInvalido       = class(EACBrTEFDErro) ;
  EACBrTEFDArquivo           = class(EACBrTEFDErro) ;
  EACBrTEFDECF               = class(EACBrTEFDErro) ;

  TACBrTEFDAguardaRespEvent = procedure( Arquivo: String;
     SegundosTimeOut : Integer; var Interromper : Boolean) of object ;

  TACBrTEFDOperacaoMensagem = ( opmOK, opmYesNo,
                                opmExibirMsgOperador, opmRemoverMsgOperador,
                                opmExibirMsgCliente, opmRemoverMsgCliente,
                                opmDestaqueVia ) ;

  TACBrTEFDReq = class ;
  TACBrTEFDResp = class ;
  TACBrTEFDRespostasPendentes = class ;

  TACBrTEFDAntesFinalizarReq = procedure( Req : TACBrTEFDReq ) of object ;
  TACBrTEFDMudaEstadoReq     = procedure( EstadoReq  : TACBrTEFDReqEstado  ) of object ;
  TACBrTEFDMudaEstadoResp    = procedure( EstadoResp : TACBrTEFDRespEstado ) of object ;

  TACBrTEFDDepoisConfirmarTransacoes = procedure( RespostasPendentes :
     TACBrTEFDRespostasPendentes ) of object ;

  TACBrTEFDExibeMsg = procedure( Operacao : TACBrTEFDOperacaoMensagem;
     Mensagem : String; var AModalResult : TModalResult ) of object ;

  TACBrTEFDOperacaoECF = ( opeAbreGerencial, opeFechaGerencial,
                           opePulaLinhas, opeSubTotalizaCupom, opeFechaCupom,
                           opeFechaVinculado, opeCancelaCupom ) ;

  TACBrTEFDBloqueiaMouseTeclado = procedure( Bloqueia : Boolean;
     var Tratado : Boolean ) of object ;

  TACBrTEFDExecutaAcao = procedure( var Tratado : Boolean ) of object ;

  TACBrTEFDComandaECF = procedure( Operacao : TACBrTEFDOperacaoECF; Resp : TACBrTEFDResp;
     var RetornoECF : Integer ) of object ; { -1 - Não tratado, 0 - Erro na Execucao, 1 - Sucesso }

  TACBrTEFDComandaECFPagamento = procedure( IndiceECF : String; Valor : Double;
     var RetornoECF : Integer ) of object ; { -1 - Não tratado, 0 - Erro na Execucao, 1 - Sucesso }

  TACBrTEFDComandaECFAbreVinculado = procedure( COO, IndiceECF : String; Valor : Double;
     var RetornoECF : Integer ) of object ; { -1 - Não tratado, 0 - Erro na Execucao, 1 - Sucesso }

  TACBrTEFDTipoRelatorio = ( trGerencial, trVinculado ) ;

  TACBrTEFDComandaECFImprimeVia = procedure( TipoRelatorio : TACBrTEFDTipoRelatorio;
     Via : Integer; ImagemComprovante : TStringList;
     var RetornoECF : Integer ) of object ; { -1 - Não tratado, 0 - Erro na Execucao, 1 - Sucesso }

  TACBrTEFDInfoECF = ( ineSubTotal,  // Valor do Saldo restante "A Pagar" do Cupom
                       ineEstadoECF  // Estado do ECF "L" Livre, "V" Em Venda de Itens,
                                     //               "P" Em Pagamento,
                                     //               "C" CDC ou Vinculado
                                     //               "G" Relatório Gerencial
                                     //               "O" Outro
                     ) ;

  TACBrTEFDObterInfoECF = procedure( Operacao : TACBrTEFDInfoECF;
     var RetornoECF : String  ) of object ;
  { TACBrTEFDLinhaInformacao }

  TACBrTEFDLinhaInformacao = class
  private
    fInformacao : AnsiString;

    function GetAsDate : TDateTime;
    function GetAsFloat : Double;
    function GetAsInteger : Integer;
    function GetAsTime : TDateTime;
    function GetAsTimeStamp : TDateTime;
    function GetAsTimeStampSQL : TDateTime;
    procedure SetAsDate(const AValue : TDateTime);
    procedure SetAsFloat(const AValue : Double);
    procedure SetAsInteger(const AValue : Integer);
    procedure SetAsTime(const AValue : TDateTime);
    procedure SetAsTimeStamp(const AValue : TDateTime);
    procedure SetAsTimeStampSQL(const AValue : TDateTime);
  public
    property AsString   : AnsiString read fInformacao    write fInformacao ;
    property AsDate     : TDateTime  read GetAsDate      write SetAsDate ;
    property AsTime     : TDateTime  read GetAsTime      write SetAsTime ;
    property AsTimeStamp: TDateTime  read GetAsTimeStamp write SetAsTimeStamp ;
    property AsTimeStampSQL: TDateTime  read GetAsTimeStampSQL write SetAsTimeStampSQL ;
    property AsInteger  : Integer    read GetAsInteger   write SetAsInteger ;
    property AsFloat    : Double     read GetAsFloat     write SetAsFloat ;
  end ;

   { TACBrTEFDLinha }

   TACBrTEFDLinha = class
   private
     fIdentificacao : SmallInt;
     fInformacao : TACBrTEFDLinhaInformacao;
     fLinha : AnsiString;
     fSequencia : SmallInt;
   protected
     function GetLinha : AnsiString; virtual;
     procedure SetLinha(const AValue : AnsiString); virtual;
   public
     constructor Create ;
     destructor Destroy ; override;

     property Linha : AnsiString read GetLinha write SetLinha ;

     property Identificacao : SmallInt read fIdentificacao write fIdentificacao  ;
     property Sequencia     : SmallInt read fSequencia     write fSequencia ;
     property Informacao    : TACBrTEFDLinhaInformacao read fInformacao ;
   end ;

   { TACBrTEFDArquivo }

   TACBrTEFDArquivo = class
   private
      fStringList : TStringList ;
      fLinha      : TACBrTEFDLinha ;
      function AchaLinha(const Identificacao : Integer;
         const Sequencia : Integer = 0 ) : Integer;
      function GetCount : Integer;
      function GetLinha(Index : Integer) : TACBrTEFDLinha;
   public
     constructor Create ;
     destructor Destroy ; override;

     procedure Clear ;

     property Conteudo : TStringList read fStringList ;
     property Count    : Integer read GetCount ;
     property Linha [Index: Integer]: TACBrTEFDLinha read GetLinha ;

     procedure GravarArquivo( const NomeArquivo : String;
        DoFlushToDisk : Boolean = False ) ;
     procedure LeArquivo( const NomeArquivo : String ) ;

     procedure GravaInformacao( const Identificacao : Integer;
        const Sequencia : Integer; const Informacao : AnsiString ) ; overload;
     procedure GravaInformacao( const Identificacao : Integer;
        const Sequencia : Integer; const Informacao : TACBrTEFDLinhaInformacao ) ; overload;
     function LeInformacao( const Identificacao : Integer;
        const Sequencia : Integer = 0 ) : TACBrTEFDLinhaInformacao ;

     function LeLinha( const Identificacao : Integer;
        const Sequencia : Integer = 0) : TACBrTEFDLinha ;
   end ;

   { TACBrTEFDReq }

   TACBrTEFDReq = class
   private
     fAgencia : String;
     fAgenciaDC : String;
     fBanco : String;
     fCheque : String;
     fChequeDC : String;
     fCMC7 : String;
     fConta : String;
     fContaDC : String;
     fConteudo   : TACBrTEFDArquivo;
     fDataCheque : TDateTime;
     fDataHoraTransacaoComprovante : TDateTime;
     fDocumentoPessoa : String;
     fFinalizacao : String;
     fInformacao : TACBrTEFDLinhaInformacao;
     fHeader : String;
     fID : Integer;
     fMoeda : Integer;
     fNSU : String;
     fRede : String;
     fTipoPessoa : AnsiChar;
     fValorTotal : Double;
     fDocumentoVinculado : String;
     procedure SetAgencia(const AValue : String);
     procedure SetAgenciaDC(const AValue : String);
     procedure SetBanco(const AValue : String);
     procedure SetCheque(const AValue : String);
     procedure SetChequeDC(const AValue : String);
     procedure SetCMC7(const AValue : String);
     procedure SetConta(const AValue : String);
     procedure SetContaDC(const AValue : String);
     procedure SetDataCheque(const AValue : TDateTime);
     procedure SetDataHoraTransacaoComprovante(const AValue : TDateTime);
     procedure SetDocumentoPessoa(const AValue : String);
     procedure SetFinalizacao(const AValue : String);
     procedure SetHeader(const AValue : String);
     procedure SetID(const AValue : Integer);
     procedure SetMoeda(const AValue : Integer);
     procedure SetNSU(const AValue : String);
     procedure SetRede(const AValue : String);
     procedure SetTipoPessoa(const AValue : AnsiChar);
     procedure SetValorTotal(const AValue : Double);
     procedure SetDocumentoVinculado(const AValue : String);
   public
     constructor Create ;
     destructor Destroy ; override;

     procedure Clear ;

     property Conteudo : TACBrTEFDArquivo read fConteudo ;

     property Header            : String    read fHeader             write SetHeader ;
     property ID                : Integer   read fID                 write SetID ;
     property DocumentoVinculado: String    read fDocumentoVinculado write SetDocumentoVinculado ;
     property ValorTotal        : Double    read fValorTotal         write SetValorTotal ;
     property Moeda             : Integer   read fMoeda              write SetMoeda ;
     property CMC7              : String    read fCMC7               write SetCMC7 ;
     property TipoPessoa        : AnsiChar  read fTipoPessoa         write SetTipoPessoa ;
     property DocumentoPessoa   : String    read fDocumentoPessoa    write SetDocumentoPessoa ;
     property DataCheque        : TDateTime read fDataCheque         write SetDataCheque ;
     property Rede              : String    read fRede               write SetRede ;
     property NSU               : String    read fNSU                write SetNSU ;
     property Finalizacao       : String    read fFinalizacao        write SetFinalizacao ;
     property Banco             : String    read fBanco              write SetBanco ;
     property Agencia           : String    read fAgencia            write SetAgencia ;
     property AgenciaDC         : String    read fAgenciaDC          write SetAgenciaDC ;
     property Conta             : String    read fConta              write SetConta ;
     property ContaDC           : String    read fContaDC            write SetContaDC ;
     property Cheque            : String    read fCheque             write SetCheque ;
     property ChequeDC          : String    read fChequeDC           write SetChequeDC ;
     property DataHoraTransacaoComprovante : TDateTime read fDataHoraTransacaoComprovante write SetDataHoraTransacaoComprovante ;

     procedure GravaInformacao( const Identificacao : Integer;
        const Sequencia : Integer; const Informacao : String ) ;
   end;


   { Definindo novo tipo para armazenar as Parcelas }

   { TACBrTEFDRespParcela }

   TACBrTEFDRespParcela = class
    private
       fsVencimentoParcela: TDateTime;
       fsValorParcela: Double;
       fsNSUParcela: String;
    public
       constructor create ;

       property Vencimento : TDateTime read fsVencimentoParcela write fsVencimentoParcela ;
       property Valor      : Double    read fsValorParcela      write fsValorParcela ;
       property NSUParcela : String    read fsNSUParcela        write fsNSUParcela ;
   end;


   { TACBrTEFDRespParcelas }
   { Lista de Objetos do tipo TACBrTEFParcela }

   TACBrTEFDRespParcelas = class(TObjectList)
     protected
       procedure SetObject (Index: Integer; Item: TACBrTEFDRespParcela);
       function GetObject (Index: Integer): TACBrTEFDRespParcela;
     public
       function Add (Obj: TACBrTEFDRespParcela): Integer;
       procedure Insert (Index: Integer; Obj: TACBrTEFDRespParcela);
       property Objects [Index: Integer]: TACBrTEFDRespParcela
         read GetObject write SetObject; default;
     end;


   { TACBrTEFDResp }

   TACBrTEFDResp = class
   protected
     fpAgencia : String;
     fpAgenciaDC : String;
     fpAutenticacao : String;
     fpArqBackup : String;
     fpBanco : String;
     fpCheque : String;
     fpChequeDC : String;
     fpCMC7 : String;
     fpCNFEnviado : Boolean;
     fpCodigoAutorizacaoTransacao : Integer;
     fpConta : String;
     fpContaDC : String;
     fpConteudo : TACBrTEFDArquivo;
     fpDataCheque : TDateTime;
     fpDataHoraTransacaoCancelada : TDateTime;
     fpDataHoraTransacaoComprovante : TDateTime;
     fpDataHoraTransacaoHost : TDateTime;
     fpDataHoraTransacaoLocal : TDateTime;
     fpDataPreDatado : TDateTime;
     fpDocumentoPessoa : String;
     fpFinalizacao : String;
     fpHeader : String;
     fpID : Integer;
     fpIndiceFPG_ECF : String;
     fpMoeda : Integer;
     fpNomeAdministradora : String;
     fpNSU : String;
     fpNSUTransacaoCancelada : String;
     fpNumeroLoteTransacao : Integer;
     fpOrdemPagamento : Integer;
     fpQtdLinhasComprovante : Integer;
     fpQtdParcelas : Integer;
     fpRede : String;
     fpStatusTransacao : String;
     fpTextoEspecialCliente : String;
     fpTextoEspecialOperador : String;
     fpTipoGP : TACBrTEFDTipo;
     fpTipoPessoa : AnsiChar;
     fpTipoTransacao : Integer;
     fpTrailer : String;
     fpValorTotal : Double;
     fpDocumentoVinculado : String;
     fpTipoParcelamento : Integer;
     fpParcelas : TACBrTEFDRespParcelas ;
     fpImagemComprovante1aVia : TStringList ;
     fpImagemComprovante2aVia : TStringList ;

     procedure SetCNFEnviado(const AValue : Boolean);
     procedure SetIndiceFPG_ECF(const AValue : String);
     procedure SetArqBackup(const AValue : String);
     procedure SetOrdemPagamento(const AValue : Integer);
   protected
     function GetTransacaoAprovada : Boolean; virtual;

   public
     constructor Create ;
     destructor Destroy ; override;

     procedure Assign( Source : TACBrTEFDResp ) ;
     procedure ConteudoToProperty; virtual;

     procedure Clear ;
     procedure LeArquivo( const NomeArquivo : String ) ;
     Function LeInformacao( const Identificacao : Integer;
        const Sequencia : Integer = 0 ) : TACBrTEFDLinhaInformacao ;

     property Conteudo : TACBrTEFDArquivo read fpConteudo ;

     property Header                      : String    read fpHeader ;
     property ID                          : Integer   read fpID ;
     property DocumentoVinculado          : String    read fpDocumentoVinculado ;
     property ValorTotal                  : Double    read fpValorTotal ;
     property Moeda                       : Integer   read fpMoeda ;
     property CMC7                        : String    read fpCMC7 ;
     property TipoPessoa                  : AnsiChar  read fpTipoPessoa ;
     property DocumentoPessoa             : String    read fpDocumentoPessoa ;
     property DataCheque                  : TDateTime read fpDataCheque ;
     property Rede                        : String    read fpRede ;
     property NSU                         : String    read fpNSU ;
     property Finalizacao                 : String    read fpFinalizacao ;
     property StatusTransacao             : String    read fpStatusTransacao ;
     property TransacaoAprovada           : Boolean   read GetTransacaoAprovada ;
     property TipoTransacao               : Integer   read fpTipoTransacao ;
     property CodigoAutorizacaoTransacao  : Integer   read fpCodigoAutorizacaoTransacao ;
     property NumeroLoteTransacao         : Integer   read fpNumeroLoteTransacao ;
     property DataHoraTransacaoHost       : TDateTime read fpDataHoraTransacaoHost ;
     property DataHoraTransacaoLocal      : TDateTime read fpDataHoraTransacaoLocal ;
     property TipoParcelamento            : Integer   read fpTipoParcelamento ;
     property QtdParcelas                 : Integer   read fpQtdParcelas ;
     property DataPreDatado               : TDateTime read fpDataPreDatado ;
     property NSUTransacaoCancelada       : String    read fpNSUTransacaoCancelada ;
     property DataHoraTransacaoCancelada  : TDateTime read fpDataHoraTransacaoCancelada ;
     property QtdLinhasComprovante        : Integer   read fpQtdLinhasComprovante ;
     property TextoEspecialOperador       : String    read fpTextoEspecialOperador ;
     property TextoEspecialCliente        : String    read fpTextoEspecialCliente ;
     property Autenticacao                : String    read fpAutenticacao ;
     property Banco                       : String    read fpBanco ;
     property Agencia                     : String    read fpAgencia ;
     property AgenciaDC                   : String    read fpAgenciaDC ;
     property Conta                       : String    read fpConta ;
     property ContaDC                     : String    read fpContaDC ;
     property Cheque                      : String    read fpCheque ;
     property ChequeDC                    : String    read fpChequeDC ;
     property NomeAdministradora          : String    read fpNomeAdministradora ;
     property DataHoraTransacaoComprovante: TDateTime read fpDataHoraTransacaoComprovante ;
     property Trailer                     : String    read fpTrailer ;

     property Parcelas : TACBrTEFDRespParcelas read fpParcelas ;

     property ImagemComprovante1aVia : TStringList read fpImagemComprovante1aVia ;
     property ImagemComprovante2aVia : TStringList read fpImagemComprovante2aVia ;

     property ArqBackup      : String  read fpArqBackup       write SetArqBackup ;
     property TipoGP : TACBrTEFDTipo   read fpTipoGP          write fpTipoGP ;

     property IndiceFPG_ECF  : String  read fpIndiceFPG_ECF   write SetIndiceFPG_ECF ;
     property CNFEnviado     : Boolean read fpCNFEnviado      write SetCNFEnviado ;
     property OrdemPagamento : Integer read fpOrdemPagamento  write SetOrdemPagamento ;
   end;

   { TACBrTEFDRespTXT }

   TACBrTEFDRespTXT = class( TACBrTEFDResp )
   private
     function GetTrailerOK : Boolean;
   protected
     function GetTransacaoAprovada : Boolean; override;
   public
     procedure ConteudoToProperty; override;
     property TrailerOk : Boolean read GetTrailerOK ;
   end;

   { TACBrTEFDRespostasPendentes }

   TACBrTEFDRespostasPendentes = class(TObjectList)
   private
      fSaldoAPagar : Double;
      function GetSaldoRestante : Double;
      function GetTotalPago : Double;
   protected
      procedure SetObject (Index: Integer; Item: TACBrTEFDResp);
      function GetObject (Index: Integer): TACBrTEFDResp;
   public
      function Add (Obj: TACBrTEFDResp): Integer;
      procedure Insert (Index: Integer; Obj: TACBrTEFDResp);
      property Objects [Index: Integer]: TACBrTEFDResp
        read GetObject write SetObject; default;
      property SaldoAPagar   : Double read fSaldoAPagar write fSaldoAPagar ;
      property TotalPago     : Double read GetTotalPago ;
      property SaldoRestante : Double read GetSaldoRestante ;
   end;

   TACBrTEFDArrayGrupoRespostasPendentes = array of record
      IndiceFPG_ECF  : String ;
      OrdemPagamento : Integer ;
      Total  : Double ;
   end ;

   { TACBrTEFDClass }

   TACBrTEFDClass = class( TComponent )
   private
     fInicializado : Boolean;
     fArqLOG : String;
     fArqReq : String;
     fArqTmp : String;
     fArqResp: String;
     fArqSTS : String;

     fAutoAtivarGP : Boolean;
     fEsperaSTS : Integer;
     fGPExeName : String;
     fHabilitado : Boolean;

     procedure SetArqReq(const AValue : String);
     procedure SetArqResp(const AValue : String);
     procedure SetArqSTS(const AValue : String);
     procedure SetArqTmp(const AValue : String);
     procedure SetInicializado(const AValue : Boolean);
     procedure SetGPExeName(const AValue : String);

   protected
     fpReq  : TACBrTEFDReq ;
     fpResp : TACBrTEFDResp ;
     fpTipo : TACBrTEFDTipo;
     fpIDSeq: Integer ;
     fpNumVias : Integer;
     fpAguardandoResposta : Boolean ;

     procedure SetNumVias(const AValue : Integer); virtual;

     procedure IniciarRequisicao( AHeader : String; AID : Integer = 0 ); virtual;
     procedure FinalizarRequisicao ; virtual;
     Function VerificarRespostaRequisicao : Boolean ; virtual;
     Procedure LerRespostaRequisicao ; virtual;
     procedure FinalizarResposta( ApagarArqResp : Boolean ) ; virtual;

     Function CopiarResposta : String ; virtual;

     procedure ProcessarResposta ; virtual;
     procedure ProcessarRespostaPagamento(const SaldoAPagar : Double;
        const IndiceFPG_ECF : String; const Valor : Double); virtual;

     procedure VerificarIniciouRequisicao; virtual;

     procedure ImprimirRelatorio ; virtual;

     Procedure VerificarTransacaoPagamento(Valor : Double;
        var SaldoAPagar : Double); virtual;

   protected
     property AutoAtivarGP : Boolean read fAutoAtivarGP write fAutoAtivarGP
       default True ;

     property EsperaSTS : Integer read fEsperaSTS write fEsperaSTS
        default CACBrTEFD_EsperaSTS ;

     property ArqTemp  : String read fArqTmp    write SetArqTmp ;
     property ArqReq   : String read fArqReq    write SetArqReq ;
     property ArqSTS   : String read fArqSTS    write SetArqSTS  ;
     property ArqResp  : String read fArqResp   write SetArqResp ;
     property GPExeName: String read fGPExeName write SetGPExeName ;
   public
     constructor Create( AOwner : TComponent ) ; override;
     destructor Destroy ; override;

     property Tipo : TACBrTEFDTipo read fpTipo ;

     property NumVias : Integer read fpNumVias write SetNumVias
        default CACBrTEFD_NumVias ;

     property Req  : TACBrTEFDReq  read fpReq  ;
     property Resp : TACBrTEFDResp read fpResp ;

     property AguardandoResposta : Boolean read fpAguardandoResposta ;

     procedure GravaLog(AString: AnsiString);

     property Inicializado : Boolean read fInicializado write SetInicializado ;
     procedure VerificaInicializado ;

     procedure Inicializar ; virtual;
     procedure DesInicializar ; virtual;

     procedure AtivarGP ; virtual;
     procedure VerificaAtivo ; virtual;

     procedure CancelarTransacoesPendentesClass; virtual;

     Procedure ATV ; virtual;
     Function ADM : Boolean; virtual;
     Function CRT( Valor : Double; IndiceFPG_ECF : String;
        DocumentoVinculado : String = ''; Moeda : Integer = 0 ) : Boolean; virtual;
     Function CHQ( Valor : Double; IndiceFPG_ECF : String;
        DocumentoVinculado : String = ''; CMC7 : String = '';
        TipoPessoa : AnsiChar = 'F'; DocumentoPessoa : String = '';
        DataCheque : TDateTime = 0; Banco   : String = '';
        Agencia    : String = ''; AgenciaDC : String = '';
        Conta      : String = ''; ContaDC   : String = '';
        Cheque     : String = ''; ChequeDC  : String = '') : Boolean; virtual;
     Procedure NCN ; overload; virtual;
     Procedure NCN(Rede, NSU, Finalizacao : String;
        Valor : Double = 0; DocumentoVinculado : String = '') ;
        overload; virtual; 
     Procedure CNF ; overload; virtual;
     Procedure CNF(Rede, NSU, Finalizacao : String;
        DocumentoVinculado : String = ''); overload; virtual;
     Function CNC : Boolean ; overload; virtual;
     Function CNC(Rede, NSU : String; DataHoraTransacao : TDateTime;
        Valor : Double) : Boolean; overload; virtual;
   published
     property ArqLOG : String read fArqLOG write fArqLOG ;

     Property Habilitado: Boolean read fHabilitado write fHabilitado
       default False ;
   end;

   { Lista de Objetos do tipo TACBrTEFDClass }

   { TACBrTEFDClasses }

   TACBrTEFDClassList = class(TObjectList)
     protected
       procedure SetObject (Index: Integer; Item: TACBrTEFDClass);
       function GetObject (Index: Integer): TACBrTEFDClass;
       procedure Insert (Index: Integer; Obj: TACBrTEFDClass);
     public
       function Add (Obj: TACBrTEFDClass): Integer;
       property Objects [Index: Integer]: TACBrTEFDClass
         read GetObject write SetObject; default;
     end;

   { TACBrTEFDClassTXT }

   TACBrTEFDClassTXT = class( TACBrTEFDClass )
   published
     constructor Create( AOwner : TComponent ) ; override;

     property AutoAtivarGP ;

     property NumVias;
     property EsperaSTS;

     property ArqTemp  ;
     property ArqReq   ;
     property ArqSTS   ;
     property ArqResp  ;
     property GPExeName;
   end;


implementation

Uses ACBrUtil, ACBrTEFD, dateutils, StrUtils, Math, ACBrTEFDCliSiTef;

{ TACBrTEFDLinhaInformacao }

function TACBrTEFDLinhaInformacao.GetAsDate : TDateTime;
var
   DataStr : String;
begin
  DataStr := OnlyNumber(Trim(fInformacao)) ;

  try
     Result := EncodeDate( StrToInt(copy(DataStr,5,4)),
                           StrToInt(copy(DataStr,3,2)),
                           StrToInt(copy(DataStr,1,2)) ) ;
  except
     Result := 0 ;
  end;
end;

function TACBrTEFDLinhaInformacao.GetAsFloat : Double;
Var
  Info : String ;
begin
  Info := StringReplace( fInformacao, ',','',[rfReplaceAll] );
  Info := StringReplace( Info       , '.','',[rfReplaceAll] );

  Result := StrToIntDef( Info ,0) / 100 ;
end;

function TACBrTEFDLinhaInformacao.GetAsInteger : Integer;
begin
  Result := StrToIntDef(fInformacao,0);
end;

function TACBrTEFDLinhaInformacao.GetAsTime : TDateTime;
var
   TimeStr : String;
begin
  TimeStr := OnlyNumber(Trim(fInformacao)) ;

  try
     Result := EncodeTime( StrToInt(copy(TimeStr,1,2)),
                           StrToInt(copy(TimeStr,3,2)),
                           StrToInt(copy(TimeStr,5,2)), 0) ;
  except
     Result := 0 ;
  end;
end;

function TACBrTEFDLinhaInformacao.GetAsTimeStamp : TDateTime;
var
   DateTimeStr : String;
begin
  DateTimeStr := OnlyNumber(Trim(fInformacao)) ;

  try
     Result := EncodeDateTime( YearOf(now),
                               StrToInt(copy(DateTimeStr,3,2)),
                               StrToInt(copy(DateTimeStr,1,2)),
                               StrToInt(copy(DateTimeStr,5,2)),
                               StrToInt(copy(DateTimeStr,7,2)),
                               StrToInt(copy(DateTimeStr,9,2)), 0) ;
  except
     Result := 0 ;
  end;
end;

function TACBrTEFDLinhaInformacao.GetAsTimeStampSQL : TDateTime;
var
   DateTimeStr : String;
begin
  DateTimeStr := OnlyNumber(Trim(fInformacao)) ;

  try
     Result := EncodeDateTime( StrToInt(copy(DateTimeStr,1,4)),
                               StrToInt(copy(DateTimeStr,5,2)),
                               StrToInt(copy(DateTimeStr,7,2)),
                               StrToInt(copy(DateTimeStr,9,2)),
                               StrToInt(copy(DateTimeStr,11,2)),
                               StrToInt(copy(DateTimeStr,13,2)), 0) ;
  except
     Result := 0 ;
  end;
end;

procedure TACBrTEFDLinhaInformacao.SetAsDate(const AValue : TDateTime);
begin
  if AValue = 0 then
     fInformacao := ''
  else
     fInformacao := FormatDateTime('DDMMYYYY',AValue)
end;

procedure TACBrTEFDLinhaInformacao.SetAsFloat(const AValue : Double);
begin
  if AValue = 0 then
     fInformacao := ''
  else
     fInformacao := IntToStr(Trunc(SimpleRoundTo( AValue * 100 ,0)));
end;

procedure TACBrTEFDLinhaInformacao.SetAsInteger(const AValue : Integer);
begin
  if AValue = 0 then
     fInformacao := ''
  else
     fInformacao := IntToStr( AValue );
end;

procedure TACBrTEFDLinhaInformacao.SetAsTime(const AValue : TDateTime);
begin
  if AValue = 0 then
     fInformacao := ''
  else
     fInformacao := FormatDateTime('HHNNSS',AValue)
end;

procedure TACBrTEFDLinhaInformacao.SetAsTimeStamp(const AValue : TDateTime);
begin
  if AValue = 0 then
     fInformacao := ''
  else
     fInformacao := FormatDateTime('DDMMHHNNSS',AValue)
end;

procedure TACBrTEFDLinhaInformacao.SetAsTimeStampSQL(const AValue : TDateTime);
begin
  if AValue = 0 then
     fInformacao := ''
  else
     fInformacao := FormatDateTime('YYYYMMDDHHNNSS',AValue)
end;


{ TACBrTEFDLinha }

constructor TACBrTEFDLinha.Create;
begin
  inherited ;

  fInformacao := TACBrTEFDLinhaInformacao.Create;
end;

destructor TACBrTEFDLinha.Destroy;
begin
  if Assigned( fInformacao ) then
     fInformacao.Free ;

  inherited Destroy;
end;

function TACBrTEFDLinha.GetLinha : AnsiString;
begin
   if fLinha <> '' then
      Result := fLinha
   else
      Result := IntToStrZero(fIdentificacao,3)+'-'+IntToStrZero(fSequencia,3)+
                ' = '+Informacao.AsString ;
end;

procedure TACBrTEFDLinha.SetLinha(const AValue : AnsiString);
begin
   if fLinha = AValue then exit;

   fLinha := Trim(AValue);

   try
     fIdentificacao := StrToInt(copy(fLinha,1,3));
     fSequencia     := StrToInt(copy(fLinha,5,3));
     Informacao.AsString := Trim(copy( fLinha, pos('=',fLinha) + 1, Length(fLinha) )) ;
   except
     fIdentificacao := 0 ;
     fSequencia     := 0 ;
     fLinha         := '' ;
     Informacao.AsString := '' ;

     raise ;
   end;
end;


{ TACBrTEFDArquivo }

constructor TACBrTEFDArquivo.Create;
begin
  inherited ;

  fLinha := TACBrTEFDLinha.Create;
  fStringList := TStringList.Create;
  fStringList.Sorted := True ;
end;

destructor TACBrTEFDArquivo.Destroy;
begin
  fStringList.Free ;
  fLinha.Free ;

  Inherited ;
end;

procedure TACBrTEFDArquivo.Clear;
begin
  fStringList.Clear;
end;

procedure TACBrTEFDArquivo.GravarArquivo(const NomeArquivo : String;
   DoFlushToDisk : Boolean = False );
begin
  fStringList.SaveToFile(NomeArquivo);

  if DoFlushToDisk then
     FlushToDisk( ExtractFileDrive( NomeArquivo ) );
end;

procedure TACBrTEFDArquivo.LeArquivo(const NomeArquivo : String);
begin
  fStringList.Clear;
  if not FilesExists( NomeArquivo ) then
     raise EACBrTEFDArquivo.Create( ACBrStr( 'Arquivo: '+sLineBreak+
                                      NomeArquivo+sLineBreak+'não encontrado' ) ) ;
  fStringList.LoadFromFile( NomeArquivo );
end;

procedure TACBrTEFDArquivo.GravaInformacao(const Identificacao : Integer;
   const Sequencia : Integer; const Informacao : AnsiString);
Var
  I : Integer ;
  ALinha : TACBrTEFDLinha ;
begin
  if Informacao = '' then exit ;

  ALinha := TACBrTEFDLinha.Create;
  try
     ALinha.Identificacao       := Identificacao ;
     ALinha.Sequencia           := Sequencia ;
     ALinha.Informacao.AsString := Informacao ;

     I := AchaLinha(Identificacao, Sequencia) ;
     if I > 0 then
        fStringList.Delete(I);  // Remove o Antigo

     fStringList.Add( ALinha.Linha ) ;
  finally
     ALinha.Free ;
  end;
end;

procedure TACBrTEFDArquivo.GravaInformacao( const Identificacao : Integer;
   const Sequencia : Integer; const Informacao : TACBrTEFDLinhaInformacao ) ;
begin
  GravaInformacao(Identificacao,Sequencia,Informacao.AsString);
end;

function TACBrTEFDArquivo.AchaLinha(const Identificacao : Integer;
  const Sequencia : Integer = 0 ) : Integer;
Var
  NomeCampo : String;
  I : Integer;
begin
  NomeCampo := IntToStrZero(Identificacao,3)+'-'+IntToStrZero(Sequencia,3);

  Result := -1 ;
  I      := 0 ;
  while (Result < 0) and (I < fStringList.Count) do
  begin
     if copy(fStringList[I],1,Length(NomeCampo)) = NomeCampo then
        Result := I;
     Inc( I ) ;
  end;
end;

function TACBrTEFDArquivo.GetCount : Integer;
begin
   Result := Conteudo.Count;
end;

function TACBrTEFDArquivo.GetLinha(Index : Integer) : TACBrTEFDLinha;
begin
  fLinha.Linha := Conteudo[Index];
  Result := fLinha;
end;

function TACBrTEFDArquivo.LeLinha(const Identificacao : Integer;
  const Sequencia : Integer = 0 ) : TACBrTEFDLinha;
Var
  I : Integer ;
begin
  I := AchaLinha(Identificacao, Sequencia) ;

  if I > -1 then
     fLinha.Linha := fStringList[I]
  else
   begin
     fLinha.Identificacao := Identificacao;
     fLinha.Sequencia     := Sequencia;
     fLinha.Informacao.AsString := '' ;
   end;

  Result := fLinha;
end;

function TACBrTEFDArquivo.LeInformacao(const Identificacao : Integer;
  const Sequencia : Integer = 0) : TACBrTEFDLinhaInformacao;
begin
  Result := LeLinha(Identificacao, Sequencia).Informacao ;
end;

{ TACBrTEFDReq }

constructor TACBrTEFDReq.Create ;
begin
  inherited Create;

  fConteudo      := TACBrTEFDArquivo.Create;
  fInformacao    := TACBrTEFDLinhaInformacao.Create;

  Clear;
end;

destructor TACBrTEFDReq.Destroy;
begin
  fInformacao.Free ;
  fConteudo.Free;

  inherited ;
end;

procedure TACBrTEFDReq.Clear;
begin
  fConteudo.Clear;

  fID     := 0 ;
  fHeader := '' ;
end;

procedure TACBrTEFDReq.GravaInformacao(const Identificacao : Integer;
   const Sequencia : Integer; const Informacao : String);
begin
   fConteudo.GravaInformacao( Identificacao, Sequencia, Informacao);
end;

procedure TACBrTEFDReq.SetHeader(const AValue : String);
begin
  fConteudo.GravaInformacao(0,0,AValue);
  fHeader := AValue;
end;

procedure TACBrTEFDReq.SetID(const AValue : Integer);
begin
  fInformacao.AsInteger := AValue;
  fConteudo.GravaInformacao(1,0,fInformacao);
  fID := AValue;
end;

procedure TACBrTEFDReq.SetDocumentoVinculado(const AValue : String);
begin
  fDocumentoVinculado := OnlyNumber(AValue);
  fConteudo.GravaInformacao(2,0,fDocumentoVinculado);
end;

procedure TACBrTEFDReq.SetValorTotal(const AValue : Double);
begin
  fInformacao.AsFloat := AValue;
  fConteudo.GravaInformacao(3,0,fInformacao);
  fValorTotal := AValue;
end;

procedure TACBrTEFDReq.SetMoeda(const AValue : Integer);
begin
  fInformacao.AsInteger := AValue;
  fConteudo.GravaInformacao(4,0,fInformacao);
  fMoeda := AValue;
end;

procedure TACBrTEFDReq.SetCMC7(const AValue : String);
begin
  fConteudo.GravaInformacao(5,0,AValue);
  fCMC7 := AValue;
end;

procedure TACBrTEFDReq.SetTipoPessoa(const AValue : AnsiChar);
begin
  fConteudo.GravaInformacao(6,0,AValue);
  fTipoPessoa := AValue;
end;

procedure TACBrTEFDReq.SetDocumentoPessoa(const AValue : String);
begin
  fConteudo.GravaInformacao(7,0,AValue);
  fDocumentoPessoa := AValue;
end;

procedure TACBrTEFDReq.SetDataCheque(const AValue : TDateTime);
begin
  fInformacao.AsDate := AValue;
  fConteudo.GravaInformacao(8,0,fInformacao);
  fDataCheque := AValue;
end;

procedure TACBrTEFDReq.SetRede(const AValue : String);
begin
  fConteudo.GravaInformacao(10,0,AValue);
  fRede := AValue;
end;

procedure TACBrTEFDReq.SetNSU(const AValue : String);
begin
  fNSU := OnlyNumber(AValue);
  fConteudo.GravaInformacao(12,0,fNSU);
end;

procedure TACBrTEFDReq.SetDataHoraTransacaoComprovante(const AValue : TDateTime);
begin
  fInformacao.AsDate := AValue;
  fConteudo.GravaInformacao(22,0,fInformacao);
  fInformacao.AsTime := AValue;
  fConteudo.GravaInformacao(23,0,fInformacao);
  fDataHoraTransacaoComprovante := AValue;
end;

procedure TACBrTEFDReq.SetFinalizacao(const AValue : String);
begin
  fConteudo.GravaInformacao(27,0,AValue);
  fFinalizacao := AValue;
end;

procedure TACBrTEFDReq.SetBanco(const AValue : String);
begin
  fConteudo.GravaInformacao(33,0,AValue);
  fBanco := AValue;
end;

procedure TACBrTEFDReq.SetAgencia(const AValue : String);
begin
  fConteudo.GravaInformacao(34,0,AValue);
  fAgencia := AValue;
end;

procedure TACBrTEFDReq.SetAgenciaDC(const AValue : String);
begin
  fConteudo.GravaInformacao(35,0,AValue);
  fAgenciaDC := AValue;
end;

procedure TACBrTEFDReq.SetConta(const AValue : String);
begin
  fConteudo.GravaInformacao(36,0,AValue);
  fConta := AValue;
end;

procedure TACBrTEFDReq.SetContaDC(const AValue : String);
begin
  fConteudo.GravaInformacao(37,0,AValue);
  fContaDC := AValue;
end;

procedure TACBrTEFDReq.SetCheque(const AValue : String);
begin
  fConteudo.GravaInformacao(38,0,AValue);
  fCheque := AValue;
end;

procedure TACBrTEFDReq.SetChequeDC(const AValue : String);
begin
  fConteudo.GravaInformacao(39,0,AValue);
  fChequeDC := AValue;
end;


{ TACBrTEFDResp }

constructor TACBrTEFDResp.Create ;
begin
  inherited Create ;

  fpConteudo := TACBrTEFDArquivo.Create;
  fpParcelas := TACBrTEFDRespParcelas.create(True) ;

  fpImagemComprovante1aVia := TStringList.Create;
  fpImagemComprovante2aVia := TStringList.Create;

  Clear ;
end;

destructor TACBrTEFDResp.Destroy;
begin
  fpConteudo.Free;
  fpParcelas.Free ;

  fpImagemComprovante1aVia.Free ;
  fpImagemComprovante2aVia.Free ;

  inherited ;
end;

procedure TACBrTEFDResp.Assign(Source : TACBrTEFDResp);
begin
  Conteudo.Clear;
  Conteudo.Conteudo.Assign(Source.Conteudo.Conteudo);
  ConteudoToProperty;

  ArqBackup := Source.ArqBackup; { ArqBackup não é salva em Conteudo (memory only) }
  TipoGP    := Source.TipoGP;    { TipoGP não é salva em Conteudo (memory only) }
end;

procedure TACBrTEFDResp.ConteudoToProperty;
begin
   {}
end;

procedure TACBrTEFDResp.Clear;
begin
   fpConteudo.Clear;
   fpParcelas.Clear;
   fpImagemComprovante1aVia.Clear;
   fpImagemComprovante2aVia.Clear;

   fpHeader                       := '' ;
   fpID                           := 0 ;
   fpAgencia                      := '' ;
   fpAgenciaDC                    := '';
   fpAutenticacao                 := '';
   fpBanco                        := '' ;
   fpCheque                       := '' ;
   fpChequeDC                     := '' ;
   fpCMC7                         := '' ;
   fpCodigoAutorizacaoTransacao   := 0 ;
   fpConta                        := '' ;
   fpContaDC                      := '' ;
   fpDataCheque                   := 0 ;
   fpDataHoraTransacaoCancelada   := 0 ;
   fpDataHoraTransacaoComprovante := 0 ;
   fpDataHoraTransacaoHost        := 0 ;
   fpDataHoraTransacaoLocal       := 0 ;
   fpDataPreDatado                := 0 ;
   fpDocumentoPessoa              := '' ;
   fpFinalizacao                  := '' ;
   fpMoeda                        := 0 ;
   fpNomeAdministradora           := '' ;
   fpNSU                          := '' ;
   fpNSUTransacaoCancelada        := '' ;
   fpNumeroLoteTransacao          := 0 ;
   fpQtdLinhasComprovante         := 0 ;
   fpQtdParcelas                  := 0 ;
   fpRede                         := '' ;
   fpStatusTransacao              := '' ;
   fpTextoEspecialCliente         := '' ;
   fpTextoEspecialOperador        := '' ;
   fpTipoPessoa                   := ' ';
   fpTipoTransacao                := 0 ;
   fpTrailer                      := '' ;
   fpValorTotal                   := 0 ;
   fpDocumentoVinculado           := '' ;
   fpTipoParcelamento             := 0 ;

   fpCNFEnviado     := False ;
   fpIndiceFPG_ECF  := '' ;
   fpOrdemPagamento := 0 ;

   fpArqBackup := '' ;
end;

procedure TACBrTEFDResp.LeArquivo(const NomeArquivo : String);
begin
  Clear;
  Conteudo.LeArquivo(NomeArquivo);

  ConteudoToProperty;
end;

procedure TACBrTEFDResp.SetCNFEnviado(const AValue : Boolean);
begin
  fpConteudo.GravaInformacao(899,1,IfThen(AValue,'S','N'));
  fpCNFEnviado := AValue;
end;

procedure TACBrTEFDResp.SetIndiceFPG_ECF(const AValue : String);
begin
  fpConteudo.GravaInformacao(899,2,AValue);
  fpIndiceFPG_ECF := AValue;
end;

procedure TACBrTEFDResp.SetArqBackup(const AValue : String);
begin
  fpArqBackup := Trim( AValue );
end;

procedure TACBrTEFDResp.SetOrdemPagamento(const AValue : Integer);
begin
  fpConteudo.GravaInformacao(899,3,IntToStr(AValue));
  fpOrdemPagamento := AValue;
end;

function TACBrTEFDResp.GetTransacaoAprovada: Boolean;
begin
   Result := True ;   { Abstrata }
end;

function TACBrTEFDResp.LeInformacao(const Identificacao : Integer;
   const Sequencia : Integer) : TACBrTEFDLinhaInformacao;
begin
   Result := Conteudo.LeInformacao(Identificacao,Sequencia);
end;

{ TACBrTEFDRespTXT }

procedure TACBrTEFDRespTXT.ConteudoToProperty;
var
   Linha : TACBrTEFDLinha ;
   I     : Integer;
   Parc  : TACBrTEFDRespParcela;
   LinStr: AnsiString ;
begin
   fpDataHoraTransacaoComprovante := 0 ;
   fpImagemComprovante1aVia.Clear;
   fpImagemComprovante2aVia.Clear;

   for I := 0 to Conteudo.Count - 1 do
   begin
     Linha := Conteudo.Linha[I];

     case Linha.Identificacao of
       0   : fpHeader                     := Linha.Informacao.AsString;
       1   : fpID                         := Linha.Informacao.AsInteger;
       2   : fpDocumentoVinculado         := Linha.Informacao.AsString;
       3   : fpValorTotal                 := Linha.Informacao.AsFloat;
       4   : fpMoeda                      := Linha.Informacao.AsInteger;
       5   : fpCMC7                       := Linha.Informacao.AsString;
       6   : fpTipoPessoa                 := padL(Linha.Informacao.AsString, 1 )[ 1 ];
       7   : fpDocumentoPessoa            := Linha.Informacao.AsString;
       8   : fpDataCheque                 := Linha.Informacao.AsDate;
       9   : fpStatusTransacao            := Linha.Informacao.AsString;
       10  : fpRede                       := Linha.Informacao.AsString;
       11  : fpTipoTransacao              := Linha.Informacao.AsInteger;
       12  : fpNSU                        := Linha.Informacao.AsString;
       13  : fpCodigoAutorizacaoTransacao := Linha.Informacao.AsInteger;
       14  : fpNumeroLoteTransacao        := Linha.Informacao.AsInteger;
       15  : fpDataHoraTransacaoHost      := Linha.Informacao.AsTimeStamp;
       16  : fpDataHoraTransacaoLocal     := Linha.Informacao.AsTimeStamp;
       17  : fpTipoParcelamento           := Linha.Informacao.AsInteger;
       18  : fpQtdParcelas                := Linha.Informacao.AsInteger;
       22  : fpDataHoraTransacaoComprovante := fpDataHoraTransacaoComprovante +
                                               Linha.Informacao.AsDate;
       23  : fpDataHoraTransacaoComprovante := fpDataHoraTransacaoComprovante +
                                              Linha.Informacao.AsTime;
       24  : fpDataPreDatado              := Linha.Informacao.AsDate;
       25  : fpNSUTransacaoCancelada      := Linha.Informacao.AsString;
       26  : fpDataHoraTransacaoCancelada := Linha.Informacao.AsTimeStamp;
       27  : fpFinalizacao                := Linha.Informacao.AsString;
       28  : fpQtdLinhasComprovante       := Linha.Informacao.AsInteger;
       29  :
         begin
           LinStr := Linha.Informacao.AsString ;
           if LeftStr(LinStr,1) = '"' then
              Delete(LinStr,1,1);
           if RightStr(LinStr,1) = '"' then
              Delete(LinStr,Length(LinStr),1);

           fpImagemComprovante1aVia.Add( LinStr );
         end ;
       30  : fpTextoEspecialOperador      := Linha.Informacao.AsString;
       31  : fpTextoEspecialCliente       := Linha.Informacao.AsString;
       32  : fpAutenticacao               := Linha.Informacao.AsString;
       33  : fpBanco                      := Linha.Informacao.AsString;
       34  : fpAgencia                    := Linha.Informacao.AsString;
       35  : fpAgenciaDC                  := Linha.Informacao.AsString;
       36  : fpConta                      := Linha.Informacao.AsString;
       37  : fpContaDC                    := Linha.Informacao.AsString;
       38  : fpCheque                     := Linha.Informacao.AsString;
       39  : fpChequeDC                   := Linha.Informacao.AsString;
       40  : fpNomeAdministradora         := Linha.Informacao.AsString;
       899 :  // Tipos de Uso Interno do ACBrTEFD
        begin
          case Linha.Sequencia of
            1 : fpCNFEnviado     := (UpperCase( Linha.Informacao.AsString ) = 'S' );
            2 : fpIndiceFPG_ECF  := Linha.Informacao.AsString ;
            3 : fpOrdemPagamento := Linha.Informacao.AsInteger ;
          end;
        end;
       999 : fpTrailer           := Linha.Informacao.AsString ;
     end;
   end ;

   // TEF Discado, 1 a 2 via são iguais //
   fpImagemComprovante2aVia.AddStrings( fpImagemComprovante1aVia );

   fpParcelas.Clear;
   for I := 1 to fpQtdParcelas do
   begin
      Parc := TACBrTEFDRespParcela.create;
      Parc.Vencimento := LeInformacao( 19 , I).AsDate ;
      Parc.Valor      := LeInformacao( 20 , I).AsFloat ;
      Parc.NSUParcela := LeInformacao( 21 , I).AsString ;

      fpParcelas.Add(Parc);
   end;
end;

function TACBrTEFDRespTXT.GetTransacaoAprovada : Boolean;
begin
   Result := (StrToIntDef(Trim(fpStatusTransacao),-1) = 0) or
             (UpperCase(Trim(fpStatusTransacao)) = 'P1') ;  // Consulta de Cheque
end;

function TACBrTEFDRespTXT.GetTrailerOK : Boolean;
begin
  Result :=  (fpTrailer <> '') ;
end;


{ TACBrTEFDRespParcela }

constructor TACBrTEFDRespParcela.create;
begin
   fsValorParcela      := 0 ;
   fsVencimentoParcela := 0 ;
   fsNSUParcela        := '' ;
end;

{ TACBrTEFDRespParcelas }

procedure TACBrTEFDRespParcelas.SetObject(Index : Integer;
   Item : TACBrTEFDRespParcela);
begin
  inherited SetItem (Index, Item) ;
end;

function TACBrTEFDRespParcelas.GetObject(Index : Integer ) : TACBrTEFDRespParcela;
begin
   Result := inherited GetItem(Index) as TACBrTEFDRespParcela ;
end;

function TACBrTEFDRespParcelas.Add(Obj : TACBrTEFDRespParcela) : Integer;
begin
   Result := inherited Add(Obj) ;
end;

procedure TACBrTEFDRespParcelas.Insert(Index : Integer;
   Obj : TACBrTEFDRespParcela);
begin
   inherited Insert(Index, Obj);
end;

{ TACBrTEFDClassTXT }

constructor TACBrTEFDClassTXT.Create(AOwner : TComponent);
begin
   inherited Create(AOwner);

   if Assigned( fpResp ) then
      fpResp.Free ;

   fpResp := TACBrTEFDRespTXT.Create;
   fpResp.TipoGP := Tipo;
end;

{ TACBrTEFDClass }

constructor TACBrTEFDClass.Create(AOwner : TComponent);
begin
  if not (AOwner is TACBrTEFD) then
     raise EACBrTEFDErro.Create( ACBrStr('TACBrTEFDClass deve ser criado por TACBrTEFD') ) ;

  inherited Create(AOwner);

  fAutoAtivarGP := True ;
  fArqLOG       := '' ;
  fArqReq       := '' ;
  fArqTmp       := '' ;
  fArqResp      := '' ;
  fArqSTS       := '' ;
  fpTipo        := gpNenhum ;
  fpIDSeq       := SecondOfTheDay(now) ;
  fpNumVias     := CACBrTEFD_NumVias ;

  fpAguardandoResposta := False ;

  fEsperaSTS := CACBrTEFD_EsperaSTS ;

  fpResp := TACBrTEFDResp.Create;
  fpReq  := TACBrTEFDReq.Create;

  TACBrTEFD(Owner).EstadoReq  := reqNenhum;
  TACBrTEFD(Owner).EstadoResp := respNenhum;
end;

destructor TACBrTEFDClass.Destroy;
begin
  fpResp.Free ;
  fpReq.Free ;

  inherited Destroy;
end;

procedure TACBrTEFDClass.VerificaInicializado;
begin
  if not fInicializado then
     raise EACBrTEFDGPNaoInicializado.Create(
        ACBrStr('Gerenciador Padrão: '+Name+' não foi inicializado')) ;
end;

procedure TACBrTEFDClass.SetInicializado(const AValue : Boolean);
begin
  if AValue then
     Inicializar
  else
     DesInicializar ;
end;

procedure TACBrTEFDClass.Inicializar;
begin
  if Inicializado then exit ;

  ApagaEVerifica( ArqTemp );  // Apagando Arquivo Temporario anterior //
  ApagaEVerifica( ArqReq );   // Apagando Arquivo de Requisicao anterior //
  ApagaEVerifica( ArqSTS );   // Apagando Arquivo de Status anterior //

  fInicializado := True ;
  GravaLog( Name +' Inicializado' );

  CancelarTransacoesPendentesClass ;

  VerificaAtivo;
end;

procedure TACBrTEFDClass.DesInicializar;
begin
  fInicializado := False ;
  GravaLog( Name +' DesInicializado' );
end;

procedure TACBrTEFDClass.VerificaAtivo;
begin
  try
    ATV;
  except
    on E : EACBrTEFDGPNaoResponde do
     begin
       if AutoAtivarGP then
       begin
         TACBrTEFD(Owner).DoExibeMsg( opmOK,
               'O Gerenciador Padrão não ativo e será ativado automaticamente!');
         AtivarGP;
         ATV;
       end;
     end;
    else
      raise ;
  end;
end;

Procedure TACBrTEFDClass.ATV ;
begin
  IniciarRequisicao('ATV');
  FinalizarRequisicao;
end;

Function TACBrTEFDClass.ADM : Boolean;
begin
  Result := False ;
  VerificaAtivo;              { VisaNET exige um ATV antes de cada transação }

  IniciarRequisicao('ADM');
  { Não há campos extras a adcionar na Requisicao ADM }
  FinalizarRequisicao;

  LerRespostaRequisicao;
  Result := Resp.TransacaoAprovada ;
  try
     ProcessarResposta ;         { Faz a Impressão e / ou exibe Mensagem ao Operador }
  finally
     FinalizarResposta( True ) ; { True = Apaga Arquivo de Resposta }
  end;
end;

Function TACBrTEFDClass.CRT( Valor : Double; IndiceFPG_ECF : String;
   DocumentoVinculado: String = ''; Moeda : Integer = 0 ) : Boolean;
var
   SaldoAPagar : Double;
begin
  Result      := False ;
  SaldoAPagar := 0 ;
  VerificarTransacaoPagamento( Valor, SaldoAPagar );

  IniciarRequisicao('CRT');
  Req.DocumentoVinculado  := DocumentoVinculado;
  Req.ValorTotal          := Valor;
  Req.Moeda               := Moeda;
  FinalizarRequisicao;

  ProcessarRespostaPagamento( SaldoAPagar, IndiceFPG_ECF, Valor);
  Result := Resp.TransacaoAprovada;
end;

Function TACBrTEFDClass.CHQ( Valor : Double; IndiceFPG_ECF : String;
   DocumentoVinculado : String = ''; CMC7 : String = '';
   TipoPessoa : AnsiChar = 'F'; DocumentoPessoa : String = '';
   DataCheque : TDateTime = 0; Banco   : String = '';
   Agencia    : String = ''; AgenciaDC : String = '';
   Conta      : String = ''; ContaDC   : String = '';
   Cheque     : String = ''; ChequeDC  : String = '') : Boolean;
var
   SaldoAPagar : Double;
begin
  Result      := False ;
  SaldoAPagar := 0 ;
  VerificarTransacaoPagamento( Valor, SaldoAPagar );

  IniciarRequisicao('CHQ');
  Req.DocumentoVinculado := DocumentoVinculado;
  Req.ValorTotal         := Valor;
  Req.CMC7               := CMC7;
  Req.TipoPessoa         := TipoPessoa;
  Req.DocumentoPessoa    := DocumentoPessoa;
  Req.DataCheque         := DataCheque;
  Req.Banco              := Banco;
  Req.Agencia            := Agencia;
  Req.AgenciaDC          := AgenciaDC;
  Req.Conta              := Conta;
  Req.ContaDC            := ContaDC;
  Req.Cheque             := Cheque;
  Req.ChequeDC           := ChequeDC;
  FinalizarRequisicao;

  ProcessarRespostaPagamento( SaldoAPagar, IndiceFPG_ECF, Valor);
  Result := Resp.TransacaoAprovada;
end;

Function TACBrTEFDClass.CNC : Boolean ;
Var
  OldResp : TACBrTEFDRespTXT ;
begin
  Result  := False ;
  OldResp := TACBrTEFDRespTXT.Create;
  try
     OldResp.Assign(Resp);      { Salvando dados da Resposta Atual }

     VerificaAtivo;             { VisaNET exige um ATV antes de cada transação }

     IniciarRequisicao('CNC');
     Req.DocumentoVinculado           := OldResp.DocumentoVinculado;
     Req.ValorTotal                   := OldResp.ValorTotal;
     Req.CMC7                         := OldResp.CMC7;
     Req.TipoPessoa                   := OldResp.TipoPessoa;
     Req.DocumentoPessoa              := OldResp.DocumentoPessoa;
     Req.DataCheque                   := OldResp.DataCheque;
     Req.Rede                         := OldResp.Rede;
     Req.NSU                          := OldResp.NSU;
     Req.DataHoraTransacaoComprovante := OldResp.DataHoraTransacaoComprovante;
     Req.Finalizacao                  := OldResp.Finalizacao;
     Req.Banco                        := OldResp.Banco;
     Req.Agencia                      := OldResp.Agencia;
     Req.AgenciaDC                    := OldResp.AgenciaDC;
     Req.Conta                        := OldResp.Conta;
     Req.ContaDC                      := OldResp.ContaDC;
     Req.Cheque                       := OldResp.Cheque;
     Req.ChequeDC                     := OldResp.ChequeDC;
     FinalizarRequisicao;

     LerRespostaRequisicao;
     Result := Resp.TransacaoAprovada;

     try
        ProcessarResposta ;         { Faz a Impressão e / ou exibe Mensagem ao Operador }
     finally
        FinalizarResposta( True ) ; { True = Apaga Arquivo de Resposta }
     end;
  finally
     OldResp.Free;
  end;
end;

Function TACBrTEFDClass.CNC( Rede, NSU : String; DataHoraTransacao :
   TDateTime; Valor : Double) : Boolean;
begin
  Result := False ;
  VerificaAtivo;             { VisaNET exige um ATV antes de cada transação }

  IniciarRequisicao('CNC');
  Req.ValorTotal                   := Valor;
  Req.Rede                         := Rede;
  Req.NSU                          := NSU;
  Req.DataHoraTransacaoComprovante := DataHoraTransacao;
  FinalizarRequisicao;

  LerRespostaRequisicao;
  Result := Resp.TransacaoAprovada;
  try
     ProcessarResposta ;         { Faz a Impressão e / ou exibe Mensagem ao Operador }
  finally
     FinalizarResposta( True ) ; { True = Apaga Arquivo de Resposta }
  end;
end;

Procedure TACBrTEFDClass.CNF ;
begin
  CNF( Resp.Rede, Resp.NSU, Resp.Finalizacao, Resp.DocumentoVinculado ) ;
end;

Procedure TACBrTEFDClass.CNF( Rede, NSU, Finalizacao : String;
  DocumentoVinculado : String = '') ;
begin
  VerificaAtivo;         { VisaNET exige um ATV antes de cada transação }

  IniciarRequisicao('CNF');
  Req.DocumentoVinculado := DocumentoVinculado;
  Req.Rede               := Rede;
  Req.NSU                := NSU;
  Req.Finalizacao        := Finalizacao;

  FinalizarRequisicao;
end;

procedure TACBrTEFDClass.NCN;
begin
  NCN( Resp.Rede, Resp.NSU, Resp.Finalizacao, Resp.ValorTotal,
       Resp.DocumentoVinculado );
end;

procedure TACBrTEFDClass.NCN(Rede, NSU, Finalizacao : String;
  Valor : Double = 0; DocumentoVinculado : String = '');
Var
  MsgStr : String ;
begin
  VerificaAtivo;         { VisaNET exige um ATV antes de cada transação }

  IniciarRequisicao('NCN');
  Req.DocumentoVinculado := DocumentoVinculado;
  Req.Rede               := Rede;
  Req.NSU                := NSU;
  Req.Finalizacao        := Finalizacao;

  FinalizarRequisicao;

  MsgStr := '' ;
  if Rede <> '' then
     MsgStr := MsgStr + 'Rede: '+Rede + sLineBreak;
  if NSU <> '' then
     MsgStr := MsgStr + 'NSU: '+NSU + sLineBreak;
  if Valor <> 0 then
     MsgStr := MsgStr + 'Valor: '+FormatFloat('0.00',Valor);

  MsgStr := 'Última Transação TEF foi cancelada' +
            IfThen(MsgStr <> '' , sLineBreak+sLineBreak, '' ) +
            MsgStr ;

  TACBrTEFD(Owner).DoExibeMsg( opmOK, MsgStr ) ;
end;

procedure TACBrTEFDClass.AtivarGP;
begin
  if (GPExeName = '') then
     raise EACBrTEFDErro.Create(ACBrStr('Nome do executável do Gerenciador Padrão não definido'));

  VerificaInicializado;

  RunCommand( GPExeName );
  Sleep(2000);
  TACBrTEFD(Owner).RestaurarFocoAplicacao;
end;

procedure TACBrTEFDClass.IniciarRequisicao( AHeader : String;
   AID : Integer = 0);
begin
  if fpAguardandoResposta then
     raise Exception.Create( ACBrStr( 'Requisição anterior não concluida' ) ) ;

  { Verificanso se a Classe de TEF está Inicializado }
  VerificaInicializado ;

  TACBrTEFD(Owner).EstadoReq := reqIniciando;
  GravaLog( Name +' IniciarRequisicao: '+AHeader );

  { Limpando da Memória os dados do Objeto de Requisicao e Resposta }
  Req.Clear;
  Resp.Clear ;

  ApagaEVerifica( ArqTemp );  // Apagando Arquivo Temporario anterior //
  ApagaEVerifica( ArqReq  );  // Apagando Arquivo de Requisicao anterior //
  ApagaEVerifica( ArqResp );  // Apagando Arquivo de Resposta anterior //
  ApagaEVerifica( ArqSTS  );  // Apagando Arquivo de Status anterior //

  if AID > 0 then
     fpIDSeq := AID
  else
     fpIDSeq := fpIDSeq + 1 ;

  Req.Header := AHeader;
  Req.ID     := fpIDSeq;
  Req.Conteudo.GravarArquivo( ArqTemp );
end;

procedure TACBrTEFDClass.FinalizarRequisicao;
Var
  TempoInicioEspera, TempoFimEspera : TDateTime ;
  Interromper : Boolean ;
begin
  VerificarIniciouRequisicao;

  with TACBrTEFD(Owner) do
  begin
     EstadoReq := reqCriandoArquivo;

     if Assigned( OnAntesFinalizarRequisicao ) then
        OnAntesFinalizarRequisicao( Self.Req );
  end ;

  GravaLog( Name +' FinalizarRequisicao: '+Req.Header+', Fechando arquivo: '+ArqTemp);
  Req.Conteudo.GravaInformacao(999,999,'0');
  Req.Conteudo.GravarArquivo( ArqTemp, True ); { True = DoFlushToDisk }

  GravaLog( Name +' FinalizarRequisicao: '+Req.Header+', Renomeando: '+ArqTemp+' para: '+ArqReq);
  if not RenameFile( ArqTemp, ArqReq ) then
     raise EACBrTEFDArquivo.Create( ACBrStr( 'Erro ao Renomear:' + sLineBreak +
                                ArqTemp + 'para:' + sLineBreak + ArqReq ) ) ;

  TACBrTEFD(Owner).EstadoReq := reqAguardandoResposta;

  TempoInicioEspera := now ;
  TempoFimEspera    := IncSecond(TempoInicioEspera, EsperaSTS );
  Interromper       := False ;
  fpAguardandoResposta := True ;
  try
     repeat
        Sleep( TACBrTEFD(Owner).EsperaSleep );  // Necessário Para não sobrecarregar a CPU //

        GravaLog( Name +' FinalizarRequisicao: '+Req.Header+', Aguardando: '+ArqSTS );
        with TACBrTEFD(Owner) do
        begin
           if Assigned( OnAguardaResp ) then
              OnAguardaResp( ArqSTS, SecondsBetween(TempoFimEspera, Now), Interromper ) ;
        end;
     until FileExists( ArqSTS ) or ( now > TempoFimEspera ) or Interromper;
  finally
     fpAguardandoResposta := False ;
     with TACBrTEFD(Owner) do
     begin
        if Assigned( OnAguardaResp ) then
           OnAguardaResp( ArqSTS, -1, Interromper ) ;
     end;
  end;

  if not FileExists( ArqSTS ) then
     raise EACBrTEFDGPNaoResponde.Create( ACBrStr( 'O gerenciador padrão '+Self.Name+' não está ativo!' )) ;

  TACBrTEFD(Owner).EstadoReq := reqConferindoResposta;

  GravaLog( Name +' FinalizarRequisicao: '+Req.Header+', Verificando conteudo de: '+ArqSTS );
  Resp.LeArquivo( ArqSTS );

  DeleteFile( ArqTemp );
  DeleteFile( ArqSTS );

  if not VerificarRespostaRequisicao then
  begin
    DeleteFile( ArqResp );

    Req.Clear;
    Resp.Clear;

    raise EACBrTEFDSTSInvalido.Create( ACBrStr('Falha na comunicação com o Gereciador Padrão: '+Name) ) ;
  end;

  TACBrTEFD(Owner).EstadoReq := reqFinalizada;
end;

Function TACBrTEFDClass.VerificarRespostaRequisicao : Boolean ;
begin
  Result := True ;
  if Resp is TACBrTEFDRespTXT then
    with TACBrTEFDRespTXT( Resp ) do
      Result := (Header = Req.Header) and (ID = Req.ID) and TrailerOk ;
end;

procedure TACBrTEFDClass.LerRespostaRequisicao;
var
   TempoInicioEspera : Double;
   Interromper, OK   : Boolean;

begin
  VerificarIniciouRequisicao;
  Resp.Clear;

  TACBrTEFD(Owner).EstadoResp  := respAguardandoResposta;
  Interromper := False ;
  OK          := False ;
  try
     while not (OK or Interromper) do
     begin
        TempoInicioEspera := now ;
        fpAguardandoResposta := True ;
        try
           repeat
              Sleep( TACBrTEFD(Owner).EsperaSleep );  // Necessário Para não sobrecarregar a CPU //

              GravaLog( Name +' LeRespostaRequisicao: '+Req.Header+', Aguardando: '+ArqResp );
              with TACBrTEFD(Owner) do
              begin
                 if Assigned( OnAguardaResp ) then
                    OnAguardaResp( ArqResp, SecondsBetween(TempoInicioEspera, Now),
                                   Interromper ) ;
              end ;
           until FileExists( ArqResp ) or Interromper ;
        finally
           fpAguardandoResposta := False ;
           with TACBrTEFD(Owner) do
           begin
              if Assigned( OnAguardaResp ) then
                 OnAguardaResp( ArqResp, -1, Interromper ) ;
           end ;
        end;

        GravaLog( Name +' LeRespostaRequisicao: '+Req.Header+', Verificando conteudo de: '+ArqResp );
        Resp.LeArquivo( ArqResp );
        Ok := VerificarRespostaRequisicao ;

        if not Ok then
        begin
           GravaLog( Name +' LeRespostaRequisicao: '+Req.Header+', Arquivo inválido desprezado: "'+ArqResp+'"'+sLineBreak +
                     Resp.Conteudo.Conteudo.Text );
           Resp.Clear;
           DeleteFile( ArqResp );
        end ;
     end ;
  finally
    Resp.TipoGP := Tipo;
    TACBrTEFD(Owner).EstadoResp := respNenhum;
    DeleteFile( ArqReq );  // Apaga a Requisicao (caso o G.P. nao tenha apagado)
  end ;
end;

procedure TACBrTEFDClass.ProcessarResposta ;
var
   RespostaPendente: TACBrTEFDRespTXT;
begin
  VerificarIniciouRequisicao;

  with TACBrTEFD(Owner) do
  begin
     EstadoResp := respProcessando;

     //GravaLog( Resp.Conteudo.Conteudo.Text );
     if Resp.QtdLinhasComprovante > 0 then
      begin
         { Cria cópia do Objeto Resp, e salva no ObjectList "RespostasPendentes" }
         RespostaPendente := TACBrTEFDRespTXT.Create ;
         try
            RespostaPendente.Assign( Resp );
            RespostasPendentes.Add( RespostaPendente );

            ImprimirRelatorio ;

            if Assigned( OnDepoisConfirmarTransacoes ) then
               OnDepoisConfirmarTransacoes( RespostasPendentes );
         finally
            RespostasPendentes.Clear;
         end;
      end
     else
        if Resp.TextoEspecialOperador <> '' then
           DoExibeMsg( opmOK, Resp.TextoEspecialOperador )
  end ;
end;

procedure TACBrTEFDClass.FinalizarResposta( ApagarArqResp : Boolean );
begin
   TACBrTEFD(Owner).EstadoResp := respConcluida;

   if ApagarArqResp then
      ApagaEVerifica( ArqResp );

   Req.Clear;
   Resp.Clear;
end;

procedure TACBrTEFDClass.CancelarTransacoesPendentesClass;
Var
  ArquivosVerficar    : TStringList ;
  RespostaCancela     : TACBrTEFDResp ;
  RespostasCanceladas : TObjectList ;
  I, Topo             : Integer;
  JaCancelado         : Boolean ;
  ArqMask             : String;
begin
  ArquivosVerficar    := TStringList.Create;
  RespostasCanceladas := TObjectList.create(True);

  try
     ArquivosVerficar.Clear;
     RespostasCanceladas.Clear;

     { Achando Arquivos de Backup deste GP }
     ArqMask := TACBrTEFD(Owner).PathBackup + PathDelim + 'ACBr_' + Self.Name + '_*.tef' ;
     FindFiles( ArqMask, ArquivosVerficar, True );

     { Vamos processar primeiro os CNCs e ADMs, e as Não Confirmadas }
     I    := ArquivosVerficar.Count-1 ;
     Topo := 0 ;
     while I > Topo do
     begin
        Resp.LeArquivo( ArquivosVerficar[ I ] );

        if (pos(Resp.Header, 'CNC,ADM') > 0) or (not Resp.CNFEnviado) then
         begin
           ArquivosVerficar.Move(I,Topo);
           Topo := Topo + 1;
         end
        else
           I := I - 1 ;
     end;

     { Adicionando Arquivo de Resposta deste GP (se ainda não foi apagado) }
     if FileExists( ArqResp ) then
        ArquivosVerficar.Add( ArqResp );

     { Enviando NCN ou CNC para todos os arquivos encontrados }
     while ArquivosVerficar.Count > 0 do
     begin
        if not FileExists( ArquivosVerficar[ 0 ] ) then
        begin
           ArquivosVerficar.Delete( 0 );
           Continue;
        end;

        Resp.LeArquivo( ArquivosVerficar[ 0 ] );

        {  Verificando se essa Resposta já foi cancela em outro arquivo }
        JaCancelado := False ;
        I := 0 ;
        while (not JaCancelado) and (I < RespostasCanceladas.Count) do
        begin
           if RespostasCanceladas[I] is TACBrTEFDRespTXT then
            begin
              with TACBrTEFDRespTXT( RespostasCanceladas[I] ) do
              begin
                 JaCancelado := (Resp.Rede        = Rede)        and
                                (Resp.NSU         = NSU)         and
                                (Resp.Finalizacao = Finalizacao) and
                                (Resp.ValorTotal  = ValorTotal) ;
              end;
            end
           else if RespostasCanceladas[I] is TACBrTEFDRespCliSiTef then
            begin
              with TACBrTEFDRespCliSiTef( RespostasCanceladas[I] ) do
              begin
                 JaCancelado := (Resp.DocumentoVinculado = DocumentoVinculado) ;
              end;
            end;

           Inc( I ) ;
        end;

        if not JaCancelado then
         begin
           { Ciando cópia da Resposta Atual }
           if Tipo = gpCliSiTef then
              RespostaCancela := TACBrTEFDRespCliSiTef.Create
           else
              RespostaCancela := TACBrTEFDRespTXT.Create;
           RespostaCancela.Assign( Resp );

           { Enviando NCN ou CNC }
           try
              if Resp.CNFEnviado then
               begin
                 if not CNC then
                    raise EACBrTEFDErro.Create('recusada') ;
               end
              else
                 NCN;

              DeleteFile( ArquivosVerficar[ 0 ] );
              ArquivosVerficar.Delete( 0 );

              { Adicionando na lista de Respostas Canceladas }
              RespostasCanceladas.Add( RespostaCancela );
           except
           end;
         end
        else
         begin
           DeleteFile( ArquivosVerficar[ 0 ] );
           ArquivosVerficar.Delete( 0 );
         end;
     end;
  finally
     ArquivosVerficar.Free;
     RespostasCanceladas.Free;
  end;
end;

procedure TACBrTEFDClass.ImprimirRelatorio;
Var
  I : Integer;
  TempoInicio : TDateTime ;
  ImpressaoOk, RemoverMsg : Boolean ;
  Est : AnsiChar ;
  ArqBackup : String ;
begin
  VerificarIniciouRequisicao;

  if Resp.QtdLinhasComprovante < 1 then
     exit ;

  CopiarResposta ;

  ImpressaoOk := False ;
  RemoverMsg  := False ;
  TempoInicio := now ;

  with TACBrTEFD( Owner ) do
  begin
     try
        BloquearMouseTeclado( True );

        while not ImpressaoOk do
        begin
           try
              try
                 Est := EstadoECF;

                 if Est <> 'L' then
                 begin
                    { Fecha Vinculado ou Gerencial ou Cupom, se ficou algum aberto por Desligamento }
                    case Est of
                      'C'      : ComandarECF( opeFechaVinculado );
                      'G', 'R' : ComandarECF( opeFechaGerencial );
                      'V', 'P' : ComandarECF( opeCancelaCupom );
                    end;

                    if EstadoECF <> 'L' then
                       raise EACBrTEFDECF.Create( ACBrStr('ECF não está LIVRE') ) ;
                 end;

                 TempoInicio := now ;
                 if Self.Resp.TextoEspecialOperador <> '' then
                 begin
                    RemoverMsg := True ;
                    DoExibeMsg( opmExibirMsgOperador, Self.Resp.TextoEspecialOperador ) ;
                 end;

                 if Self.Resp.TextoEspecialCliente <> '' then
                 begin
                    RemoverMsg := True ;
                    DoExibeMsg( opmExibirMsgCliente, Self.Resp.TextoEspecialCliente ) ;
                 end;

                 ComandarECF( opeAbreGerencial ) ;

                 I := 1 ;
                 while I <= self.NumVias do
                 begin
                   if I = 1 then
                      ECFImprimeVia( trGerencial, I, Self.Resp.ImagemComprovante1aVia  )
                   else
                      ECFImprimeVia( trGerencial, I, Self.Resp.ImagemComprovante2aVia  ) ;

                    if I < self.NumVias  then
                    begin
                       ComandarECF( opePulaLinhas ) ;
                       DoExibeMsg( opmDestaqueVia, 'Destaque a '+IntToStr(I)+'ª Via') ;
                    end;

                    Inc( I ) ;
                 end;

                 ComandarECF( opeFechaGerencial );
                 ImpressaoOk := True ;

              finally
                 { Removendo a mensagem do Operador }
                 if RemoverMsg then
                 begin
                    { Verifica se Mensagem Ficou pelo menos por 5 segundos }
                    if ImpressaoOk then
                    begin
                       while SecondsBetween(now,TempoInicio) < 5 do
                       begin
                          Sleep(EsperaSleep) ;
                          Application.ProcessMessages;
                       end;
                    end;

                    DoExibeMsg( opmRemoverMsgOperador, '' ) ;
                    DoExibeMsg( opmRemoverMsgCliente, '' ) ;
                 end;
              end;

           except
              on EACBrTEFDECF do ImpressaoOk := False ;
              else
                 raise ;
           end;

           if not ImpressaoOk then
           begin
             if DoExibeMsg( opmYesNo, 'Impressora não responde'+sLineBreak+
                                      'Tentar novamente ?') <> mrYes then
                break ;
           end;
        end;
     finally
       { Enviando CNF ou NCN e apagando Arquivo de Backup }
       ArqBackup := Resp.ArqBackup ;
       while FileExists( ArqBackup ) do
       begin
          try
             if ImpressaoOk then
                self.CNF
             else
                self.NCN ;

             DeleteFile( ArqBackup ) ;

          except
          end;
       end ;

       BloquearMouseTeclado( False );
     end ;

     if not ImpressaoOk then
        raise EACBrTEFDECF.Create( ACBrStr('Impressão de Relatório Falhou' ) ) ;
  end;
end;

Function TACBrTEFDClass.CopiarResposta : String;
Var
   I : Integer ;
begin
  Result := '' ;
//VerificarIniciouRequisicao;

  with TACBrTEFD(Owner) do
  begin
     I := 1 ;
     repeat
        Result := PathBackup + PathDelim + 'ACBr_' +
                  Self.Name + '_' + IntToStrZero(I,3) + '.tef' ;
        Inc( I ) ;
     until not FileExists( Result );

     Resp.Conteudo.GravarArquivo( Result, True );   { True = DoFlushToDisk }
     Resp.ArqBackup := Result ;
  end;
end;

procedure TACBrTEFDClass.ProcessarRespostaPagamento( const SaldoAPagar : Double;
   const IndiceFPG_ECF : String; const Valor : Double);
var
  UltimaTransacao : Boolean ;
  ImpressaoOk : Boolean;
  ArqBack : String ;
  RespostaPendente : TACBrTEFDRespTXT;
begin
  UltimaTransacao := (Valor >= SaldoAPagar);

  LerRespostaRequisicao;

  with TACBrTEFD(Owner) do
  begin
     if not Self.Resp.TransacaoAprovada then
     begin
       ProcessarResposta;           { Exibe a Mensagem ao Operador }
       FinalizarResposta( True ) ;  { True = Apaga Arquivo de Resposta }

                               { Ja tem RespostasPendentes ? }
       if UltimaTransacao and ( RespostasPendentes.Count > 0 ) then
       begin
          if DoExibeMsg( opmYesNo, 'Gostaria de continuar a transação com outra(s)' +
                                   'forma(s) de pagamento ?' ) <> mrYes then
          begin
             ComandarECF( opeCancelaCupom );
             CancelarTransacoesPendentes;
          end;
       end;

       exit ;
     end ;

     Self.Resp.IndiceFPG_ECF := IndiceFPG_ECF;

     { Cria Arquivo de Backup, contendo inclusive informacoess internas como :
       899 - 001 : CNFEnviado (S, N)
       899 - 002 : IndiceFPG_ECF : String
       899 - 003 : OrdemPagamento : Integer
     }
     ArqBack := CopiarResposta ;

     { Cria cópia do Objeto Resp, e salva no ObjectList "RespostasPendentes" }
     RespostaPendente := TACBrTEFDRespTXT.Create ;
     RespostaPendente.Assign( Resp );
     RespostasPendentes.Add( RespostaPendente );

     if AutoEfetuarPagamento then
     begin
        ImpressaoOk := False ;

        try
           while not ImpressaoOk do
           begin
              try
                 ECFPagamento( IndiceFPG_ECF, Valor );
                 RespostaPendente.OrdemPagamento := RespostasPendentes.Count + 1 ;
                 ImpressaoOk := True ;
              except
                 on EACBrTEFDECF do ImpressaoOk := False ;
                 else
                    raise ;
              end;

              if not ImpressaoOk then
              begin
                 if DoExibeMsg( opmYesNo, 'Impressora não responde'+sLineBreak+
                                          'Tentar novamente ?') <> mrYes then
                 begin
                    try ComandarECF(opeCancelaCupom); except {Exceção Muda} end ;
                    break ;
                 end;
              end;
           end;
        finally
           if not ImpressaoOk then
              CancelarTransacoesPendentes;
        end;
     end;

     RespostasPendentes.SaldoAPagar := SaldoAPagar;

     if RespostasPendentes.SaldoRestante > 0 then  { Se Multiplos Cartoes, deve enviar um CNF }
      begin
        self.CNF;

        { Atualizando Arquivo de Backup com a Informacao de que o CNF já foi enviado }
        RespostaPendente.CNFEnviado := True ;
        if ArqBack <> '' then
           RespostaPendente.Conteudo.GravarArquivo( ArqBack, True ) ;   { True = DoFlushToDisk }

        FinalizarResposta( True );     { True = Apaga Arquivo de Resposta }
      end
     else
      begin
        FinalizarResposta( False );    { False = NAO Apaga Arquivo de Resposta }

        if AutoFinalizarCupom then
        begin
           FinalizarCupom;
           ImprimirTransacoesPendentes;
        end;
      end ;
  end;
end;

procedure TACBrTEFDClass.VerificarIniciouRequisicao;
begin
   if Req.Header = '' then
      raise EACBrTEFDErro.Create( ACBrStr( 'Nenhuma Requisição Iniciada' ) ) ;
end;

Procedure TACBrTEFDClass.VerificarTransacaoPagamento(Valor : Double;
  var SaldoAPagar : Double);
var
   SubTotal : String;
begin
   if (Valor <= 0) then
      raise Exception.Create( ACBrStr( 'Valor inválido' ) );

   { Lendo o SubTotal do ECF }
   with TACBrTEFD(Owner) do
   begin
     if not (EstadoECF in ['V','P']) then
        raise Exception.Create( ACBrStr('ECF deve estar em Venda ou Pagamento'));

     SubTotal    := '' ;
     SaldoAPagar := 0 ;

     try
        OnInfoECF( ineSubTotal, SubTotal ) ;
     except
        On E : Exception do
           raise EACBrTEFDECF.Create(E.Message);
     end;

     SaldoAPagar := StringToFloatDef( SubTotal, -2);

     if SaldoAPagar = -2 then
        raise Exception.Create( ACBrStr( 'Erro na conversão do Valor Retornado em:'+
                                         'OnInfoECF( ineSubTotal, SaldoAPagar )' ) );

     if (Valor > SaldoAPagar) then
        raise Exception.Create( ACBrStr( 'Operação TEF deve ser igual ao '+
                                         'Saldo a Pagar' ) );

     if (not MultiplosCartoes) and (Valor < SaldoAPagar) then
        raise Exception.Create(
               ACBrStr( 'Multiplos Cartões não habilitado.' + sLineBreak +
                        'Valor da Operação TEF deve ser igual ao Saldo a Pagar' ) );
   end;

   VerificaAtivo;              { VisaNET exige um ATV antes de cada transação }
end;

procedure TACBrTEFDClass.SetArqReq(const AValue : String);
begin
  fArqReq := Trim( AValue ) ;
end;

procedure TACBrTEFDClass.SetArqResp(const AValue : String);
begin
  fArqResp := Trim( AValue ) ;
end;

procedure TACBrTEFDClass.SetArqSTS(const AValue : String);
begin
  fArqSTS := Trim( AValue ) ;
end;

procedure TACBrTEFDClass.SetArqTmp(const AValue : String);
begin
  fArqTmp := Trim( AValue ) ;
end;

procedure TACBrTEFDClass.SetGPExeName(const AValue : String);
begin
  fGPExeName := Trim( AValue ) ;
end;

procedure TACBrTEFDClass.SetNumVias(const AValue : Integer);
begin
   fpNumVias := AValue;
end;

procedure TACBrTEFDClass.GravaLog(AString : AnsiString);
begin
  if fArqLOG = '' then
     exit ;

  try
     WriteToTXT( fArqLOG, '-- '+FormatDateTime('dd/mm/yy hh:nn:ss',now) +
                          sLineBreak + AString, True);
  except
  end ;
end;

{ TACBrTEFDClasses }

procedure TACBrTEFDClassList.SetObject(Index : Integer; Item : TACBrTEFDClass);
begin
  inherited SetItem (Index, Item) ;
end;

function TACBrTEFDClassList.GetObject(Index : Integer) : TACBrTEFDClass;
begin
  Result := inherited GetItem(Index) as TACBrTEFDClass ;
end;

procedure TACBrTEFDClassList.Insert(Index : Integer; Obj : TACBrTEFDClass);
begin
  inherited Insert(Index, Obj);
end;

function TACBrTEFDClassList.Add(Obj : TACBrTEFDClass) : Integer;
begin
  Result := inherited Add(Obj) ;
end;


{ TACBrTEFDRespostasPendentes }

function TACBrTEFDRespostasPendentes.GetSaldoRestante : Double;
begin
   Result := RoundTo( SaldoAPagar - TotalPago, -2) ;
end;

function TACBrTEFDRespostasPendentes.GetTotalPago : Double;
var
   I : Integer;
begin
  Result := 0 ;
  For I := 0 to Count-1 do
    Result := Result + TACBrTEFDResp(Items[I]).ValorTotal;

  Result := RoundTo( Result, -2);
end;

procedure TACBrTEFDRespostasPendentes.SetObject(Index : Integer; Item : TACBrTEFDResp);
begin
  inherited SetItem (Index, Item) ;
end;

function TACBrTEFDRespostasPendentes.GetObject(Index : Integer ) : TACBrTEFDResp;
begin
   Result := inherited GetItem(Index) as TACBrTEFDResp ;
end;

function TACBrTEFDRespostasPendentes.Add(Obj : TACBrTEFDResp) : Integer;
begin
   Result := inherited Add(Obj) ;
end;

procedure TACBrTEFDRespostasPendentes.Insert(Index : Integer; Obj : TACBrTEFDResp);
begin
  inherited Insert(Index, Obj);
end;

end.

