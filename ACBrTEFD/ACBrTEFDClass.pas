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
   CACBrTEFD_Versao      = '0.5a' ;
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

  TACBrTEFDAntesFinalizarReq = procedure( Req : TACBrTEFDReq ) of object ;
  TACBrTEFDMudaEstadoReq     = procedure( EstadoReq  : TACBrTEFDReqEstado  ) of object ;
  TACBrTEFDMudaEstadoResp    = procedure( EstadoResp : TACBrTEFDRespEstado ) of object ;

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
    procedure SetAsDate(const AValue : TDateTime);
    procedure SetAsFloat(const AValue : Double);
    procedure SetAsInteger(const AValue : Integer);
    procedure SetAsTime(const AValue : TDateTime);
    procedure SetAsTimeStamp(const AValue : TDateTime);
  public
    property AsString   : AnsiString read fInformacao    write fInformacao ;
    property AsDate     : TDateTime  read GetAsDate      write SetAsDate ;
    property AsTime     : TDateTime  read GetAsTime      write SetAsTime ;
    property AsTimeStamp: TDateTime  read GetAsTimeStamp write SetAsTimeStamp ;
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
   private
     fAgencia : String;
     fAgenciaDC : String;
     fAutenticacao : String;
     fArqBackup : String;
     fBanco : String;
     fCheque : String;
     fChequeDC : String;
     fCMC7 : String;
     fCNFEnviado : Boolean;
     fCodigoAutorizacaoTransacao : Integer;
     fConta : String;
     fContaDC : String;
     fConteudo : TACBrTEFDArquivo;
     fDataCheque : TDateTime;
     fDataHoraTransacaoCancelada : TDateTime;
     fDataHoraTransacaoComprovante : TDateTime;
     fDataHoraTransacaoHost : TDateTime;
     fDataHoraTransacaoLocal : TDateTime;
     fDataPreDatado : TDateTime;
     fDocumentoPessoa : String;
     fFinalizacao : String;
     fHeader : String;
     fID : Integer;
     fIndiceFPG_ECF : String;
     fMoeda : Integer;
     fNomeAdministradora : String;
     fNSU : String;
     fNSUTransacaoCancelada : String;
     fNumeroLoteTransacao : Integer;
     fOrdemPagamento : Integer;
     fQtdLinhasComprovante : Integer;
     fQtdParcelas : Integer;
     fRede : String;
     fStatusTransacao : String;
     fTextoEspecialCliente : String;
     fTextoEspecialOperador : String;
     fTipoGP : TACBrTEFDTipo;
     fTipoPessoa : AnsiChar;
     fTipoTransacao : Integer;
     fTrailer : String;
     fValorTotal : Double;
     fDocumentoVinculado : String;
     fTipoParcelamento : Integer;
     fParcelas : TACBrTEFDRespParcelas ;
     fImagemComprovante : TStringList ;

     procedure ConteudoToProperty;

     function GetTrailerOK : Boolean;
     function GetTransacaoAprovada : Boolean;
     procedure SetCNFEnviado(const AValue : Boolean);
     procedure SetIndiceFPG_ECF(const AValue : String);
     procedure SetArqBackup(const AValue : String);
     procedure SetOrdemPagamento(const AValue : Integer);

   public
     constructor Create ;
     destructor Destroy ; override;

     procedure Assign( Source : TACBrTEFDResp ) ;

     procedure Clear ;
     procedure LeArquivo( const NomeArquivo : String ) ;
     Function LeInformacao( const Identificacao : Integer;
        const Sequencia : Integer = 0 ) : TACBrTEFDLinhaInformacao ;

     property Conteudo : TACBrTEFDArquivo read fConteudo ;

     property Header                      : String    read fHeader ;
     property ID                          : Integer   read fID ;
     property DocumentoVinculado          : String    read fDocumentoVinculado ;
     property ValorTotal                  : Double    read fValorTotal ;
     property Moeda                       : Integer   read fMoeda ;
     property CMC7                        : String    read fCMC7 ;
     property TipoPessoa                  : AnsiChar  read fTipoPessoa ;
     property DocumentoPessoa             : String    read fDocumentoPessoa ;
     property DataCheque                  : TDateTime read fDataCheque ;
     property Rede                        : String    read fRede ;
     property NSU                         : String    read fNSU ;
     property Finalizacao                 : String    read fFinalizacao ;
     property StatusTransacao             : String    read fStatusTransacao ;
     property TransacaoAprovada           : Boolean   read GetTransacaoAprovada ;
     property TipoTransacao               : Integer   read fTipoTransacao ;
     property CodigoAutorizacaoTransacao  : Integer   read fCodigoAutorizacaoTransacao ;
     property NumeroLoteTransacao         : Integer   read fNumeroLoteTransacao ;
     property DataHoraTransacaoHost       : TDateTime read fDataHoraTransacaoHost ;
     property DataHoraTransacaoLocal      : TDateTime read fDataHoraTransacaoLocal ;
     property TipoParcelamento            : Integer   read fTipoParcelamento ;
     property QtdParcelas                 : Integer   read fQtdParcelas ;
     property DataPreDatado               : TDateTime read fDataPreDatado ;
     property NSUTransacaoCancelada       : String    read fNSUTransacaoCancelada ;
     property DataHoraTransacaoCancelada  : TDateTime read fDataHoraTransacaoCancelada ;
     property QtdLinhasComprovante        : Integer   read fQtdLinhasComprovante ;
     property TextoEspecialOperador       : String    read fTextoEspecialOperador ;
     property TextoEspecialCliente        : String    read fTextoEspecialCliente ;
     property Autenticacao                : String    read fAutenticacao ;
     property Banco                       : String    read fBanco ;
     property Agencia                     : String    read fAgencia ;
     property AgenciaDC                   : String    read fAgenciaDC ;
     property Conta                       : String    read fConta ;
     property ContaDC                     : String    read fContaDC ;
     property Cheque                      : String    read fCheque ;
     property ChequeDC                    : String    read fChequeDC ;
     property NomeAdministradora          : String    read fNomeAdministradora ;
     property DataHoraTransacaoComprovante: TDateTime read fDataHoraTransacaoComprovante ;
     property Trailer   : String  read fTrailer ;
     property TrailerOk : Boolean read GetTrailerOK ;

     property Parcelas          : TACBrTEFDRespParcelas read fParcelas ;
     property ImagemComprovante : TStringList           read fImagemComprovante ;

     property ArqBackup      : String  read fArqBackup       write SetArqBackup ;
     property TipoGP : TACBrTEFDTipo   read fTipoGP          write fTipoGP ;

     property IndiceFPG_ECF  : String  read fIndiceFPG_ECF   write SetIndiceFPG_ECF ;
     property CNFEnviado     : Boolean read fCNFEnviado      write SetCNFEnviado ;
     property OrdemPagamento : Integer read fOrdemPagamento  write SetOrdemPagamento ;
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
     fNumVias : Integer;

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

     procedure IniciarRequisicao( AHeader : String; AID : Integer = 0 ); virtual;
     procedure FinalizarRequisicao ; virtual;
     Function VerificarRespostaRequisicao : Boolean ; virtual;
     Procedure LerRespostaRequisicao ; virtual;
     procedure ProcessarResposta ; virtual;
     procedure FinalizarResposta( ApagarArqResp : Boolean ) ; virtual;

     procedure CopiarResposta( AdicionaEmRespostasPendentes : Boolean ) ; virtual;
     procedure ProcessarRespostaPagamento(const SaldoAPagar : Double;
        const IndiceFPG_ECF : String; const Valor : Double); virtual;

     procedure VerificarIniciouRequisicao;

     procedure ImprimirRelatorio ; virtual;

     Procedure VerificarTransacaoPagamento(Valor : Double;
        var SaldoAPagar : Double); virtual;

   protected
     property AutoAtivarGP : Boolean read fAutoAtivarGP write fAutoAtivarGP
       default True ;

     property ArqTemp  : String read fArqTmp    write SetArqTmp ;
     property ArqReq   : String read fArqReq    write SetArqReq ;
     property ArqSTS   : String read fArqSTS    write SetArqSTS  ;
     property ArqResp  : String read fArqResp   write SetArqResp ;
     property GPExeName: String read fGPExeName write SetGPExeName ;


   public
     constructor Create( AOwner : TComponent ) ; override;
     destructor Destroy ; override;

     property Tipo : TACBrTEFDTipo read fpTipo ;

     property Req  : TACBrTEFDReq  read fpReq  ;
     property Resp : TACBrTEFDResp read fpResp ;

     procedure GravaLog(AString: AnsiString);

     property Inicializado : Boolean read fInicializado write SetInicializado ;
     procedure VerificaInicializado ;

     procedure Inicializar ; virtual;
     procedure DesInicializar ; virtual;

     procedure AtivarGP ; virtual;
     procedure VerificaAtivo ; virtual;

     procedure CancelarTransacoesPendentesClass; virtual;

     procedure ATV ; virtual;
     procedure ADM ; virtual;
     procedure CRT( Valor : Double; IndiceFPG_ECF : String;
        DocumentoVinculado : String = ''; Moeda : Integer = 0 ); virtual;
     procedure CHQ( Valor : Double; IndiceFPG_ECF : String;
        DocumentoVinculado : String = ''; CMC7 : String = '';
        TipoPessoa : AnsiChar = 'F'; DocumentoPessoa : String = '';
        DataCheque : TDateTime = 0; Banco   : String = '';
        Agencia    : String = ''; AgenciaDC : String = '';
        Conta      : String = ''; ContaDC   : String = '';
        Cheque     : String = ''; ChequeDC  : String = ''); virtual;
     procedure NCN; overload; virtual;
     procedure NCN(Rede, NSU, Finalizacao : String;
        Valor : Double = 0; DocumentoVinculado : String = '');
        overload; virtual; 
     procedure CNF ; overload; virtual;
     procedure CNF(Rede, NSU, Finalizacao : String;
        DocumentoVinculado : String = ''); overload; virtual; 
     procedure CNC ; overload; virtual;
     procedure CNC(Rede, NSU : String; DataHoraTransacao : TDateTime;
        Valor : Double); overload; virtual;

   published
     property ArqLOG : String read fArqLOG write fArqLOG ;

     Property Habilitado: Boolean read fHabilitado write fHabilitado
       default False ;
     property NumVias   : Integer read fNumVias   write fNumVias
        default CACBrTEFD_NumVias ;
     property EsperaSTS : Integer read fEsperaSTS write fEsperaSTS
        default CACBrTEFD_EsperaSTS ;
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

   TACBrTEFDClassTXT = class( TACBrTEFDClass )
   published
     property AutoAtivarGP ;

     property ArqTemp  ;
     property ArqReq   ;
     property ArqSTS   ;
     property ArqResp  ;
     property GPExeName;
   end;


implementation

Uses ACBrUtil, ACBrTEFD, dateutils, StrUtils, Math;

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
begin
  Result := StrToIntDef(fInformacao,0) / 100 ;
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
     if I < 0 then
        fStringList.Add(ALinha.Linha)
     else
        fStringList[I] := ALinha.Linha ;
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

  fConteudo := TACBrTEFDArquivo.Create;
  fParcelas := TACBrTEFDRespParcelas.create(True) ;
  fImagemComprovante := TStringList.Create;

  Clear ;
end;

destructor TACBrTEFDResp.Destroy;
begin
  fConteudo.Free;
  fParcelas.Free ;
  fImagemComprovante.Free ;

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

procedure TACBrTEFDResp.Clear;
begin
   fConteudo.Clear;
   fParcelas.Clear;
   fImagemComprovante.Clear;

   fHeader                       := '' ;
   fID                           := 0 ;
   fAgencia                      := '' ;
   fAgenciaDC                    := '';
   fAutenticacao                 := '';
   fBanco                        := '' ;
   fCheque                       := '' ;
   fChequeDC                     := '' ;
   fCMC7                         := '' ;
   fCodigoAutorizacaoTransacao   := 0 ;
   fConta                        := '' ;
   fContaDC                      := '' ;
   fDataCheque                   := 0 ;
   fDataHoraTransacaoCancelada   := 0 ;
   fDataHoraTransacaoComprovante := 0 ;
   fDataHoraTransacaoHost        := 0 ;
   fDataHoraTransacaoLocal       := 0 ;
   fDataPreDatado                := 0 ;
   fDocumentoPessoa              := '' ;
   fFinalizacao                  := '' ;
   fMoeda                        := 0 ;
   fNomeAdministradora           := '' ;
   fNSU                          := '' ;
   fNSUTransacaoCancelada        := '' ;
   fNumeroLoteTransacao          := 0 ;
   fQtdLinhasComprovante         := 0 ;
   fQtdParcelas                  := 0 ;
   fRede                         := '' ;
   fStatusTransacao              := '' ;
   fTextoEspecialCliente         := '' ;
   fTextoEspecialOperador        := '' ;
   fTipoPessoa                   := ' ';
   fTipoTransacao                := 0 ;
   fTrailer                      := '' ;
   fValorTotal                   := 0 ;
   fDocumentoVinculado           := '' ;
   fTipoParcelamento             := 0 ;

   fCNFEnviado     := False ;
   fIndiceFPG_ECF  := '' ;
   fOrdemPagamento := 0 ;

   fArqBackup := '' ;
end;

procedure TACBrTEFDResp.LeArquivo(const NomeArquivo : String);
begin
  Clear;
  Conteudo.LeArquivo(NomeArquivo);

  ConteudoToProperty;
end;

procedure TACBrTEFDResp.ConteudoToProperty;
var
   Linha : TACBrTEFDLinha ;
   I     : Integer;
   Parc  : TACBrTEFDRespParcela;
   LinStr: AnsiString ;
begin
   fDataHoraTransacaoComprovante := 0 ;
   fImagemComprovante.Clear;

   for I := 0 to Conteudo.Count - 1 do
   begin
     Linha := Conteudo.Linha[I];

     case Linha.Identificacao of
       0   : fHeader                     := Linha.Informacao.AsString;
       1   : fID                         := Linha.Informacao.AsInteger;
       2   : fDocumentoVinculado         := Linha.Informacao.AsString;
       3   : fValorTotal                 := Linha.Informacao.AsFloat;
       4   : fMoeda                      := Linha.Informacao.AsInteger;
       5   : fCMC7                       := Linha.Informacao.AsString;
       6   : fTipoPessoa                 := padL(Linha.Informacao.AsString, 1 )[ 1 ];
       7   : fDocumentoPessoa            := Linha.Informacao.AsString;
       8   : fDataCheque                 := Linha.Informacao.AsDate;
       9   : fStatusTransacao            := Linha.Informacao.AsString;
       10  : fRede                       := Linha.Informacao.AsString;
       11  : fTipoTransacao              := Linha.Informacao.AsInteger;
       12  : fNSU                        := Linha.Informacao.AsString;
       13  : fCodigoAutorizacaoTransacao := Linha.Informacao.AsInteger;
       14  : fNumeroLoteTransacao        := Linha.Informacao.AsInteger;
       15  : fDataHoraTransacaoHost      := Linha.Informacao.AsTimeStamp;
       16  : fDataHoraTransacaoLocal     := Linha.Informacao.AsTimeStamp;
       17  : fTipoParcelamento           := Linha.Informacao.AsInteger;
       18  : fQtdParcelas                := Linha.Informacao.AsInteger;
       22  : fDataHoraTransacaoComprovante := fDataHoraTransacaoComprovante +
                                              Linha.Informacao.AsDate;
       23  : fDataHoraTransacaoComprovante := fDataHoraTransacaoComprovante +
                                              Linha.Informacao.AsTime;
       24  : fDataPreDatado              := Linha.Informacao.AsDate;
       25  : fNSUTransacaoCancelada      := Linha.Informacao.AsString;
       26  : fDataHoraTransacaoCancelada := Linha.Informacao.AsTimeStamp;
       27  : fFinalizacao                := Linha.Informacao.AsString;
       28  : fQtdLinhasComprovante       := Linha.Informacao.AsInteger;
       29  :
         begin
           LinStr := Linha.Informacao.AsString ;
           if LeftStr(LinStr,1) = '"' then
              Delete(LinStr,1,1);
           if RightStr(LinStr,1) = '"' then
              Delete(LinStr,Length(LinStr),1);

           fImagemComprovante.Add( LinStr );
         end ;
       30  : fTextoEspecialOperador      := Linha.Informacao.AsString;
       31  : fTextoEspecialCliente       := Linha.Informacao.AsString;
       32  : fAutenticacao               := Linha.Informacao.AsString;
       33  : fBanco                      := Linha.Informacao.AsString;
       34  : fAgencia                    := Linha.Informacao.AsString;
       35  : fAgenciaDC                  := Linha.Informacao.AsString;
       36  : fConta                      := Linha.Informacao.AsString;
       37  : fContaDC                    := Linha.Informacao.AsString;
       38  : fCheque                     := Linha.Informacao.AsString;
       39  : fChequeDC                   := Linha.Informacao.AsString;
       40  : fNomeAdministradora         := Linha.Informacao.AsString;
       899 :  // Tipos de Uso Interno do ACBrTEFD
        begin
          case Linha.Sequencia of
            1 : fCNFEnviado     := (UpperCase( Linha.Informacao.AsString ) = 'S' );
            2 : fIndiceFPG_ECF  := Linha.Informacao.AsString ;
            3 : fOrdemPagamento := Linha.Informacao.AsInteger ;
          end;
        end;
       999 : fTrailer           := Linha.Informacao.AsString ;
     end;
   end ;

   fParcelas.Clear;
   for I := 1 to fQtdParcelas do
   begin
      Parc := TACBrTEFDRespParcela.create;
      Parc.Vencimento := LeInformacao( 19 , I).AsDate ;
      Parc.Valor      := LeInformacao( 20 , I).AsFloat ;
      Parc.NSUParcela := LeInformacao( 21 , I).AsString ;

      fParcelas.Add(Parc);
   end;
end;

function TACBrTEFDResp.GetTrailerOK : Boolean;
begin
  Result :=  (fTrailer <> '') ;
end;

function TACBrTEFDResp.GetTransacaoAprovada : Boolean;
begin
   Result := (StrToIntDef(Trim(fStatusTransacao),-1) = 0) or
             (UpperCase(Trim(fStatusTransacao)) = 'P1') ;  // Consulta de Cheque
end;

procedure TACBrTEFDResp.SetCNFEnviado(const AValue : Boolean);
begin
  fConteudo.GravaInformacao(899,1,IfThen(AValue,'S','N'));
  fCNFEnviado := AValue;
end;

procedure TACBrTEFDResp.SetIndiceFPG_ECF(const AValue : String);
begin
  fConteudo.GravaInformacao(899,2,AValue);
  fIndiceFPG_ECF := AValue;
end;

procedure TACBrTEFDResp.SetArqBackup(const AValue : String);
begin
  fArqBackup := Trim( AValue );
end;

procedure TACBrTEFDResp.SetOrdemPagamento(const AValue : Integer);
begin
  fConteudo.GravaInformacao(899,3,IntToStr(AValue));
  fOrdemPagamento := AValue;
end;

function TACBrTEFDResp.LeInformacao(const Identificacao : Integer;
   const Sequencia : Integer) : TACBrTEFDLinhaInformacao;
begin
   Result := Conteudo.LeInformacao(Identificacao,Sequencia);
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

  fEsperaSTS := CACBrTEFD_EsperaSTS ;
  fNumVias   := CACBrTEFD_NumVias ;

  fpReq  := TACBrTEFDReq.Create;
  fpResp := TACBrTEFDResp.Create;
  fpResp.TipoGP := Tipo;

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

procedure TACBrTEFDClass.ATV;
begin
  IniciarRequisicao('ATV');
  FinalizarRequisicao;
end;

procedure TACBrTEFDClass.ADM;
begin
  VerificaAtivo;              { VisaNET exige um ATV antes de cada transação }

  IniciarRequisicao('ADM');
  { Não há campos extras a adcionar na Requisicao ADM }
  FinalizarRequisicao;

  LerRespostaRequisicao;
  ProcessarResposta ;          { Faz a Impressão e / ou exibe Mensagem ao Operador }
  FinalizarResposta( True ) ; { True = Apaga Arquivo de Resposta }
end;

procedure TACBrTEFDClass.CRT( Valor : Double; IndiceFPG_ECF : String;
   DocumentoVinculado: String = ''; Moeda : Integer = 0 );
var
   SaldoAPagar : Double;
begin
  SaldoAPagar := 0 ;
  VerificarTransacaoPagamento( Valor, SaldoAPagar );

  IniciarRequisicao('CRT');
  Req.DocumentoVinculado  := DocumentoVinculado;
  Req.ValorTotal          := Valor;
  Req.Moeda               := Moeda;
  FinalizarRequisicao;

  ProcessarRespostaPagamento( SaldoAPagar, IndiceFPG_ECF, Valor);
end;

procedure TACBrTEFDClass.CHQ( Valor : Double; IndiceFPG_ECF : String;
   DocumentoVinculado : String = ''; CMC7 : String = '';
   TipoPessoa : AnsiChar = 'F'; DocumentoPessoa : String = '';
   DataCheque : TDateTime = 0; Banco   : String = '';
   Agencia    : String = ''; AgenciaDC : String = '';
   Conta      : String = ''; ContaDC   : String = '';
   Cheque     : String = ''; ChequeDC  : String = '');
var
   SaldoAPagar : Double;
begin
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
end;

procedure TACBrTEFDClass.CNC;
Var
  OldResp : TACBrTEFDResp ;
begin
  OldResp := TACBrTEFDResp.Create;
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
     ProcessarResposta;           { Faz a Impressão e / ou exibe Mensagem ao Operador }
     FinalizarResposta( True ) ; { True = Apaga Arquivo de Resposta }
  finally
     OldResp.Free;
  end;
end;

procedure TACBrTEFDClass.CNC( Rede, NSU : String; DataHoraTransacao :
   TDateTime; Valor : Double);
begin
  VerificaAtivo;             { VisaNET exige um ATV antes de cada transação }

  IniciarRequisicao('CNC');
  Req.ValorTotal                   := Valor;
  Req.Rede                         := Rede;
  Req.NSU                          := NSU;
  Req.DataHoraTransacaoComprovante := DataHoraTransacao;
  FinalizarRequisicao;

  LerRespostaRequisicao;
  ProcessarResposta;           { Faz a Impressão e / ou exibe Mensagem ao Operador }
  FinalizarResposta( True ) ; { True = Apaga Arquivo de Resposta }
end;

procedure TACBrTEFDClass.CNF;
begin
  CNF( Resp.Rede, Resp.NSU, Resp.Finalizacao, Resp.DocumentoVinculado ) ;
end;

procedure TACBrTEFDClass.CNF( Rede, NSU, Finalizacao : String;
  DocumentoVinculado : String = '');
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

  MsgStr := 'Última Transação TEF foi cancelada'+sLineBreak+sLineBreak ;
  if Rede <> '' then
     MsgStr := MsgStr + 'Rede: '+Rede + sLineBreak;
  if NSU <> '' then
     MsgStr := MsgStr + 'NSU: '+NSU + sLineBreak;
  if Valor <> 0 then
     MsgStr := MsgStr + 'Valor: '+FormatFloat('0.00',Valor);

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
     fpIDSeq := SecondOfTheDay(now) ;

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
  repeat
     Sleep( TACBrTEFD(Owner).EsperaSleep );  // Necessário Para não sobrecarregar a CPU //

     GravaLog( Name +' FinalizarRequisicao: '+Req.Header+', Aguardando: '+ArqSTS );
     with TACBrTEFD(Owner) do
     begin
        if Assigned( OnAguardaResp ) then
           OnAguardaResp( ArqSTS, SecondsBetween(TempoFimEspera, Now), Interromper ) ;
     end;
  until FileExists( ArqSTS ) or ( now > TempoFimEspera ) or Interromper;

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
  Result := (Resp.Header = Req.Header) and
            (Resp.ID     = Req.ID)     and
             Resp.TrailerOk ;
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
begin
  VerificarIniciouRequisicao;

  with TACBrTEFD(Owner) do
  begin
     EstadoResp := respProcessando;

     if Resp.QtdLinhasComprovante > 0 then
        ImprimirRelatorio
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
           with TACBrTEFDResp( RespostasCanceladas[I] ) do
           begin
              JaCancelado := (Resp.Rede        = Rede)        and
                             (Resp.NSU         = NSU)         and
                             (Resp.Finalizacao = Finalizacao) and
                             (Resp.ValorTotal  = ValorTotal) ;
           end;
           Inc( I ) ;
        end;

        if not JaCancelado then
         begin
           { Ciando cópia da Resposta Atual }
           RespostaCancela := TACBrTEFDResp.Create;
           RespostaCancela.Assign( Resp );

           { Enviando NCN ou CNC }
           try
              if Resp.CNFEnviado then
                 CNC
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

  CopiarResposta( False );

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
                    { Fecha Vinculado ou Gerencial, se ficou algum aberto por Desligamento }
                    case Est of
                      'C'      : ComandarECF( opeFechaVinculado );
                      'G', 'R' : ComandarECF( opeFechaGerencial );
                    end;

                    if EstadoECF <> 'L' then
                       raise EACBrTEFDECF.Create( ACBrStr('ECF não está LIVRE') ) ;
                 end;

                 TempoInicio := now ;
                 if Resp.TextoEspecialOperador <> '' then
                 begin
                    RemoverMsg := True ;
                    DoExibeMsg( opmExibirMsgOperador, Resp.TextoEspecialOperador ) ;
                 end;

                 if Resp.TextoEspecialCliente <> '' then
                 begin
                    RemoverMsg := True ;
                    DoExibeMsg( opmExibirMsgCliente, Resp.TextoEspecialCliente ) ;
                 end;

                 ComandarECF( opeAbreGerencial ) ;

                 I := 1 ;
                 while I <= NumVias do
                 begin
                    ECFImprimeVia( trGerencial, I, Resp.ImagemComprovante );

                    if I < NumVias  then
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
  end;
end;

procedure TACBrTEFDClass.CopiarResposta( AdicionaEmRespostasPendentes : Boolean );
Var
   ArqBak : String;
   I : Integer ;
   RespPendente : TACBrTEFDResp;
begin
  VerificarIniciouRequisicao;

  with TACBrTEFD(Owner) do
  begin
     I := 1 ;
     repeat
        ArqBak := PathBackup + PathDelim + 'ACBr_' +
                  Self.Name + '_' + IntToStrZero(I,3) + '.tef' ;
        Inc( I ) ;
     until not FileExists( ArqBak );

     Resp.Conteudo.GravarArquivo( ArqBak, True );   { True = DoFlushToDisk }
     Resp.ArqBackup := ArqBak ;

     if AdicionaEmRespostasPendentes then
     begin
        { Cria cópia do Objeto Resp, e salva no ObjectList "RespostasPendentes" }
        RespPendente := TACBrTEFDResp.Create ;
        RespPendente.Assign( Resp );

        RespostasPendentes.Add( RespPendente );
     end;
  end;
end;

procedure TACBrTEFDClass.ProcessarRespostaPagamento( const SaldoAPagar : Double;
   const IndiceFPG_ECF : String; const Valor : Double);
var
  UltimaTransacao : Boolean ;
  ImpressaoOk : Boolean;
begin
  UltimaTransacao := (Valor >= SaldoAPagar);

  LerRespostaRequisicao;

  with TACBrTEFD(Owner) do
  begin
     if not Self.Resp.TransacaoAprovada then
     begin
       ProcessarResposta;           { Exibe a Mensagem ao Operador }
       FinalizarResposta( True ) ;  { True = Apaga Arquivo de Resposta }

                               { Ja tem RespostasPendentes }
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

     if AutoEfetuarPagamento then
     begin
        ImpressaoOk := False ;

        try
           while not ImpressaoOk do
           begin
              try
                 ECFPagamento( IndiceFPG_ECF, Valor );
                 Self.Resp.OrdemPagamento := RespostasPendentes.Count + 1 ;
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

     { Cria Arquivo de Backup, contendo inclusive informacoess internas como :
       899 - 001 : CNFEnviado (S, N)
       899 - 002 : IndiceFPG_ECF : String
       899 - 003 : OrdemPagamento : Integer
     }
     CopiarResposta( True );     { True = Adiciona Resp em RespostasPendentes }

     RespostasPendentes.SaldoAPagar := SaldoAPagar;

     if RespostasPendentes.SaldoRestante > 0 then  { Se Multiplos Cartoes, deve enviar um CNF }
      begin
       self.CNF;

       { Atualizando Arquivo de Backup com a Informacao de que o CNF já foi enviado }
       with RespostasPendentes[RespostasPendentes.Count - 1 ] do
       begin
          CNFEnviado := True ;
          Conteudo.GravarArquivo( ArqBackup, True ) ;   { True = DoFlushToDisk }
       end;

       FinalizarResposta( True );      { True = Apaga Arquivo de Resposta }
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

procedure TACBrTEFDRespostasPendentes.SetObject(Index : Integer;
   Item : TACBrTEFDResp);
begin
  inherited SetItem (Index, Item) ;
end;

function TACBrTEFDRespostasPendentes.GetObject(Index : Integer
   ) : TACBrTEFDResp;
begin
   Result := inherited GetItem(Index) as TACBrTEFDResp ;
end;

function TACBrTEFDRespostasPendentes.Add(Obj : TACBrTEFDResp) : Integer;
begin
   Result := inherited Add(Obj) ;
end;

procedure TACBrTEFDRespostasPendentes.Insert(Index : Integer;
   Obj : TACBrTEFDResp);
begin
  inherited Insert(Index, Obj);
end;

end.


