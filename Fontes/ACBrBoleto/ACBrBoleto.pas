{******************************************************************************}
{ Projeto: Componentes ACBr                                                    }
{  Biblioteca multiplataforma de componentes Delphi para interação com equipa- }
{ mentos de Automação Comercial utilizados no Brasil                           }
{                                                                              }
{ Direitos Autorais Reservados (c) 2009 Daniel Simoes de Almeida               }
{                                                                              }
{ Colaboradores nesse arquivo:   Juliana Rodrigues Prado                       }
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
|* 02/10/2009: André Ferreira de Moraes,  Daniel Simões de Almeida
|*  - Esboço das Classes
|*
|* 01/04/2010: Juliana Rodrigues Prado Tamizou,  Daniel Simões de Almeida
|*  - Primeira Versao ACBrBoleto
|*  Componente desenvolvido usando como base os projetos GBBoleto, RLBoleto,
|*  FreeBoleto, OpenBoleto, JFMBoleto e outras dicas encontradas na internet
******************************************************************************}
{$I ACBr.inc}

unit ACBrBoleto;

interface
uses ACBrBase,  {Units da ACBr}
     {$IFDEF FPC}
       LResources,
     {$ENDIF}
     SysUtils, ACBrValidador,
     {$IFDEF COMPILER6_UP} Types, {$ELSE} Windows, {$ENDIF}
     Graphics, Contnrs, Classes;

const
  CACBrBoleto_Versao = '0.0.10a' ;

type
  TACBrTitulo = class;
  TACBrBoletoFCClass = class;
  TACBrCedente = class;
  TACBrBanco  = class;
  TACBrBoleto = class;

  { TACBrBancoClass }

  TACBrBancoClass = class
  private
     function GetNumero: Integer;

  protected
    fpDigito: Integer;
    fpNome:   String;
    fpModulo: TACBrCalcDigito;
    fpAOwner: TACBrBanco;
    fpTamanhoMaximoNossoNum: Integer;
    function CalcularFatorVencimento(const DataVencimento: TDateTime): String; virtual;
    function CalcularDigitoCodigoBarras(const CodigoBarras: String): String; virtual;
  public
    Constructor create(AOwner: TACBrBanco);
    Destructor Destroy; override ;

    property ACBrBanco : TACBrBanco      read fpAOwner;
    property Numero    : Integer         read GetNumero;
    property Digito    : Integer         read fpDigito;
    property Nome      : String          read fpNome;
    Property Modulo    : TACBrCalcDigito read fpModulo;
    property TamanhoMaximoNossoNum: Integer    read fpTamanhoMaximoNossoNum;

    function CalcularDigitoVerificador(const ACBrTitulo : TACBrTitulo): String; virtual;

    function MontarCodigoBarras(const ACBrTitulo : TACBrTitulo): String; virtual;
    function MontarCampoNossoNumero(const ACBrTitulo : TACBrTitulo): String; virtual;
    function MontarLinhaDigitavel(const CodigoBarras: String): String; virtual;
    function MontarCampoCodigoCedente(const ACBrTitulo: TACBrTitulo): String; virtual;

    function GerarRegistroHeader400(NumeroRemessa : Integer): String;    Virtual;
    function GerarRegistroHeader240(NumeroRemessa : Integer): String;    Virtual;
    function GerarRegistroTransacao400(ACBrTitulo : TACBrTitulo): String; Virtual;
    function GerarRegistroTransacao240(ACBrTitulo : TACBrTitulo): String; Virtual;
    function GerarRegistroTrailler400(ARemessa:TStringList): String;  Virtual;
    function GerarRegistroTrailler240(ARemessa:TStringList): String;  Virtual;

    function CalcularNomeArquivoRemessa(const DirArquivo: String): String; Virtual;
  end;


  { TACBrBanco }

  TACBrBanco = class(TComponent)
  private
    fACBrBoleto        : TACBrBoleto;
    fNumeroBanco       : Integer;
    fBancoClass        : TACBrBancoClass;
    function GetNome   : String;
    function GetDigito : Integer;
    function GetTamanhoMaximoNossoNum : Integer;
    procedure SetDigito(const AValue: Integer);
    procedure SetNome(const AValue: String);
    procedure SetNumero(const AValue: Integer);
  public
    constructor Create( AOwner : TComponent); override;

    property ACBrBoleto : TACBrBoleto     read fACBrBoleto;
    property BancoClass : TACBrBancoClass read fBancoClass ;
    property TamanhoMaximoNossoNum :Integer read GetTamanhoMaximoNossoNum;

    function CalcularDigitoVerificador(const ACBrTitulo : TACBrTitulo): String;

    function MontarCampoCodigoCedente(const ACBrTitulo: TACBrTitulo): String;
    function MontarCampoNossoNumero(const ACBrTitulo :TACBrTitulo): String;
    function MontarCodigoBarras(const ACBrTitulo : TACBrTitulo): String;
    function MontarLinhaDigitavel(const CodigoBarras: String): String;

    function GerarRegistroHeader400(NumeroRemessa : Integer): String;
    function GerarRegistroHeader240(NumeroRemessa : Integer): String;
    function GerarRegistroTransacao400(ACBrTitulo : TACBrTitulo): String;
    function GerarRegistroTransacao240(ACBrTitulo : TACBrTitulo): String;
    function GerarRegistroTrailler400(ARemessa:TStringList): String;
    function GerarRegistroTrailler240(ARemessa:TStringList): String;

    function CalcularNomeArquivoRemessa(const DirArquivo: String): String;
  published
    property Numero    : Integer        read fNumeroBanco    write SetNumero default 0;
    property Digito    : Integer        read GetDigito  write SetDigito stored false;
    property Nome      : String         read GetNome    write SetNome   stored false;
  end;

  TACBrTipoBoleto = (tbCliEmite,tbBancoEmite,tbBancoReemite,tbBancoNaoReemite);
  TACBrTipoInscricao = (tiPessoaFisica, tiPessoaJuridica, tiOutro);

  { TACBrCedente }

  TACBrCedente = class(TComponent)
  private
    fCodigoCedente: String;
    fNomeCedente   : String;
    fAgencia       : String;
    fAgenciaDigito : String;
    fConta         : String;
    fContaDigito   : String;
    fModalidade    : String;
    fConvenio      : String;
    fTipoBoleto    : TACBrTipoBoleto;
    fCNPJCPF       : String;
    fTipoInscricao : TACBrTipoInscricao;
    procedure SetCNPJCPF ( const AValue: String ) ;
  public
    constructor Create( AOwner : TComponent ) ; override ;
    destructor Destroy; override;
  published
    property Nome         : String read fNomeCedente   write fNomeCedente;
    property CodigoCedente: String read fCodigoCedente write fCodigoCedente;
    property Agencia      : String read fAgencia       write fAgencia;
    property AgenciaDigito: String read fAgenciaDigito write fAgenciaDigito;
    property Conta        : String read fConta         write fConta;
    property ContaDigito  : String read fContaDigito   write fContaDigito;
    property Modalidade   : String read fModalidade    write fModalidade;
    property Convenio     : String read fConvenio      write fConvenio;
    property TipoBoleto   : TACBrTipoBoleto read fTipoBoleto    write fTipoBoleto default tbCliEmite ;
    {Todo: Validar CNPJCPF - SetCNPJCPF}
    property CNPJCPF      : String  read fCNPJCPF  write SetCNPJCPF;
    property TipoInscricao: TACBrTipoInscricao  read fTipoInscricao write fTipoInscricao default tiPessoaJuridica;
  end;

  TACBrPessoa = (pFisica,pJuridica,pOutras);

  TACBrSacado = class
  private
    fTipoPessoa  : TACBrPessoa;
    fNomeSacado  : String;
    fCNPJCPF     : String;
    fAvalista    : String;
    fLogradouro  : String;
    fNumero      : String;
    fComplemento : String;
    fBairro      : String;
    fCidade      : String;
    fUF          : String;
    fCEP         : String;
    fEmail       : String;
    fFone        : String;
  public
    property Pessoa      : TACBrPessoa read fTipoPessoa  write fTipoPessoa;
    property NomeSacado  : String  read fNomeSacado  write fNomeSacado;
    property CNPJCPF     : String  read fCNPJCPF     write fCNPJCPF;
    property Avalista    : String  read fAvalista    write fAvalista;
    property Logradouro  : String  read fLogradouro  write fLogradouro;
    property Numero      : String  read fNumero      write fNumero;
    property Complemento : String  read fComplemento write fComplemento;
    property Bairro      : String  read fBairro      write fBairro;
    property Cidade      : String  read fCidade      write fCidade;
    property UF          : String  read fUF          write fUF;
    property CEP         : String  read fCEP         write fCEP;
    property Email       : String  read fEmail       write fEmail;
    property Fone        : String  read fFone        write fFone;
  end;

  {Tipos de ocorrências permitidas no arquivos remessa / retorno}
  TACBrTipoOcorrencia =
  (
    {Ocorrências para arquivo remessa}
    toRemessaRegistrar,
    toRemessaBaixar,
    toRemessaDebitarEmConta,
    toRemessaConcederAbatimento,
    toRemessaCancelarAbatimento,
    toRemessaConcederDesconto,
    toRemessaCancelarDesconto,
    toRemessaAlterarVencimento,
    toRemessaProtestar,
    toRemessaSustarProtesto,
    toRemessaCancelarIntrucaoProtestoBaixa,
    toRemessaCancelarInstrucaoProtesto,
    toRemessaDispensarJuros,
    toRemessaAlterarNomeEnderecoSacado,
    toRemessaAlterarNumeroControle,
    toRemessaOutrasOcorrencias,

    {Ocorrências para arquivo retorno}
    toRetornoRegistroConfirmado,
    toRetornoRegistroRecusado,
    toRetornoComandoRecusado,
    toRetornoLiquidado,
    toRetornoLiquidadoEmCartorio,
    toRetornoLiquidadoParcialmente,
    toRetornoLiquidadoSaldoRestante,
    toRetornoLiquidadoSemRegistro,
    toRetornoLiquidadoPorConta,
    toRetornoBaixaSolicitada,
    toRetornoBaixado,
    toRetornoBaixadoPorDevolucao,
    toRetornoBaixadoFrancoPagamento,
    toRetornoBaixaPorProtesto,
    toRetornoRecebimentoInstrucaoBaixar,
    toRetornoBaixaOuLiquidacaoEstornada,
    toRetornoTituloEmSer,
    toRetornoRecebimentoInstrucaoConcederAbatimento,
    toRetornoAbatimentoConcedido,
    toRetornoRecebimentoInstrucaoCancelarAbatimento,
    toRetornoAbatimentoCancelado,
    toRetornoRecebimentoInstrucaoConcederDesconto,
    toRetornoDescontoConcedido,
    toRetornoRecebimentoInstrucaoCancelarDesconto,
    toRetornoDescontoCancelado,
    toRetornoRecebimentoInstrucaoAlterarDados,
    toRetornoDadosAlterados,
    toRetornoRecebimentoInstrucaoAlterarVencimento,
    toRetornoVencimentoAlterado,
    toRetornoAlteracaoDadosNovaEntrada,
    toRetornoAlteracaoDadosBaixa,
    toRetornoRecebimentoInstrucaoProtestar,
    toRetornoProtestado,
    toRetornoRecebimentoInstrucaoSustarProtesto,
    toRetornoProtestoSustado,
    toRetornoInstrucaoProtestoRejeitadaSustadaOuPendente,
    toRetornoDebitoEmConta,
    toRetornoRecebimentoInstrucaoAlterarNomeSacado,
    toRetornoNomeSacadoAlterado,
    toRetornoRecebimentoInstrucaoAlterarEnderecoSacado,
    toRetornoEnderecoSacadoAlterado,
    toRetornoEncaminhadoACartorio,
    toRetornoRetiradoDeCartorio,
    toRetornoRecebimentoInstrucaoDispensarJuros,
    toRetornoJurosDispensados,
    toRetornoManutencaoTituloVencido,
    toRetornoRecebimentoInstrucaoAlterarTipoCobranca,
    toRetornoTipoCobrancaAlterado,
    toRetornoDespesasProtesto,
    toRetornoDespesasSustacaoProtesto,
    toRetornoDebitoCustasAntecipadas,
    toRetornoCustasCartorioDistribuidor,
    toRetornoCustasEdital,
    toRetornoProtestoOuSustacaoEstornado,
    toRetornoDebitoTarifas,
    toRetornoAcertoDepositaria,
    toRetornoOutrasOcorrencias
  );

  { TACBrTitulo }

  TACBrTitulo = class
  private
    fInstrucao1        : String;
    fInstrucao2        : String;
    fLocalPagamento    : String;
    fPercentualMulta   : Double;
    fSeuNumero         : String;
    fVencimento        : TDateTime;
    fDataDocumento     : TDateTime;
    fNumeroDocumento   : String;
    fEspecieDoc        : String;
    fAceite            : String;
    fDataProcessamento : TDateTime;
    fNossoNumero       : String;
    fUsoBanco          : String;
    fCarteira          : String;
    fEspecieMod        : String;
    fValorDocumento    : Currency;
    fMensagem          : TStrings;
    fInstrucoes        : TStrings;
    fSacado            : TACBrSacado;

    fTipoOcorrencia                 : TACBrTipoOcorrencia;
    fOcorrenciaOriginal             : String;
    fDescricaoOcorrenciaOriginal    : String;
    fMotivoRejeicaoComando          : String;
    fDescricaoMotivoRejeicaoComando : String;

    fDataOcorrencia       : TDateTime;
    fDataCredito          : TDateTime;
    fDataAbatimento       : TDateTime;
    fDataDesconto         : TDateTime;
    fDataMoraJuros        : TDateTime;
    fDataProtesto         : TDateTime;
    fDataBaixa            : TDateTime;
    fValorDespesaCobranca : Currency;
    fValorAbatimento      : Currency;
    fValorDesconto        : Currency;
    fValorMoraJuros       : Currency;
    fValorIOF             : Currency;
    fValorOutrasDespesas  : Currency;
    fValorOutrosCreditos  : Currency;
    fValorRecebido        : Currency;
    fReferencia           : String;
    fVersao               : String;
    fACBrBoleto           : TACBrBoleto;

    procedure SetNossoNumero ( const AValue: String ) ;
   public
     constructor Create(ACBrBoleto:TACBrBoleto);
     destructor Destroy; override;

     property ACBrBoleto        : TACBrBoleto read fACBrBoleto;
     property LocalPagamento    : String      read fLocalPagamento    write fLocalPagamento;
     property Vencimento        : TDateTime   read fVencimento        write fVencimento;
     property DataDocumento     : TDateTime   read fDataDocumento     write fDataDocumento;
     property NumeroDocumento   : String      read fNumeroDocumento   write fNumeroDocumento ;
     property EspecieDoc        : String      read fEspecieDoc        write fEspecieDoc;
     property Aceite            : String      read fAceite            write fAceite;
     property DataProcessamento : TDateTime   read fDataProcessamento write fDataProcessamento;
     property NossoNumero       : String      read fNossoNumero       write SetNossoNumero;
     property UsoBanco          : String      read fUsoBanco          write fUsoBanco;
     property Carteira          : String      read fCarteira          write fCarteira;
     property EspecieMod        : String      read fEspecieMod        write fEspecieMod;
     property ValorDocumento    : Currency    read fValorDocumento    write fValorDocumento;
     property Mensagem          : TStrings    read fMensagem          write fMensagem;
     property Instrucao1        : String      read fInstrucao1        write fInstrucao1;
     property Instrucao2        : String      read fInstrucao2        write fInstrucao2;
     property Sacado            : TACBrSacado read fSacado            write fSacado;

     property TipoOcorrencia                 : TACBrTipoOcorrencia read fTipoOcorrencia  write fTipoOcorrencia default toRemessaRegistrar ;
     property OcorrenciaOriginal             : String    read fOcorrenciaOriginal  write fOcorrenciaOriginal;
     property DescricaoOcorrenciaOriginal    : String    read fDescricaoOcorrenciaOriginal  write fDescricaoOcorrenciaOriginal;
     property MotivoRejeicaoComando          : String    read fMotivoRejeicaoComando  write fMotivoRejeicaoComando;
     property DescricaoMotivoRejeicaoComando : String    read fDescricaoMotivoRejeicaoComando  write fDescricaoMotivoRejeicaoComando;
     property DataOcorrencia                 : TDateTime read fDataOcorrencia  write fDataOcorrencia;
     property DataCredito                    : TDateTime read fDataCredito  write fDataCredito;
     property DataAbatimento                 : TDateTime read fDataAbatimento  write fDataAbatimento;
     property DataDesconto                   : TDateTime read fDataDesconto  write fDataDesconto;
     property DataMoraJuros                  : TDateTime read fDataMoraJuros  write fDataMoraJuros;
     property DataProtesto                   : TDateTime read fDataProtesto  write fDataProtesto;
     property DataBaixa                      : TDateTime read fDataBaixa  write fDataBaixa;

     property ValorDespesaCobranca : Currency read fValorDespesaCobranca  write fValorDespesaCobranca;
     property ValorAbatimento      : Currency read fValorAbatimento  write fValorAbatimento;
     property ValorDesconto        : Currency read fValorDesconto  write fValorDesconto;
     property ValorMoraJuros       : Currency read fValorMoraJuros  write fValorMoraJuros;
     property ValorIOF             : Currency read fValorIOF  write fValorIOF;
     property ValorOutrasDespesas  : Currency read fValorOutrasDespesas  write fValorOutrasDespesas;
     property ValorOutrosCreditos  : Currency read fValorOutrosCreditos  write fValorOutrosCreditos;
     property ValorRecebido        : Currency read fValorRecebido  write fValorRecebido;
     property Referencia           : String   read fReferencia  write fReferencia;
     property Versao               : String   read fVersao  write fVersao;
     property SeuNumero            : String   read fSeuNumero write fSeuNumero;
     property PercentualMulta      : Double   read fPercentualMulta write fPercentualMulta;
   end;

  { TListadeBoletos }
  TListadeBoletos = class(TObjectList)
  protected
    procedure SetObject (Index: Integer; Item: TACBrTitulo);
    function  GetObject (Index: Integer): TACBrTitulo;
    procedure Insert (Index: Integer; Obj: TACBrTitulo);
  public
    function Add (Obj: TACBrTitulo): Integer;
    property Objects [Index: Integer]: TACBrTitulo
      read GetObject write SetObject; default;
  end;

TACBrBolLayOut = (lPadrao, lCarne, lFatura) ;

TACBrLayoutRemessa = (c400, c240);

{ TACBrBoleto }
TACBrBoleto = class( TACBrComponent )
  private
    fBanco: TACBrBanco;
    fACBrBoletoFC: TACBrBoletoFCClass;
    fDirArqRemessa: String;
    fLayoutRemessa: TACBrLayoutRemessa;
    fImprimirMensagemPadrao: boolean;
    fListadeBoletos : TListadeBoletos;
    fCedente        : TACBrCedente;
    fNomeArqRemessa: String;
    function GetAbout: String;
    procedure SetAbout(const AValue: String);
    procedure SetACBrBoletoFC(const Value: TACBrBoletoFCClass);
    procedure SetDirArqRemessa(const AValue: String);
    procedure SetNomeArqRemessa(const AValue: String);
  protected
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property ListadeBoletos : TListadeBoletos read fListadeBoletos write fListadeBoletos ;

    function CriarTituloNaLista: TACBrTitulo;

    procedure Imprimir;

    procedure GerarPDF;
    procedure GerarHTML;

    procedure AdicionarMensagensPadroes(Titulo : TACBrTitulo; AStringList: TStrings);

    procedure GerarRemessa(NumeroRemessa : Integer);
  published
    property About : String read GetAbout write SetAbout stored False ;

    property Cedente        : TACBrCedente       read fCedente                write fCedente ;
    property Banco          : TACBrBanco         read fBanco                  write fBanco;
    property NomeArqRemessa : String             read fNomeArqRemessa         write SetNomeArqRemessa;
    property DirArqRemessa  : String             read fDirArqRemessa          write SetDirArqRemessa;
    property LayoutRemessa  : TACBrLayoutRemessa read fLayoutRemessa          write fLayoutRemessa default c400;
    property ImprimirMensagemPadrao : Boolean    read fImprimirMensagemPadrao write fImprimirMensagemPadrao default True;
    property ACBrBoletoFC : TACBrBoletoFCClass   read fACBrBoletoFC           write SetACBrBoletoFC;
    procedure ChecarDadosObrigatorios;
  end;

{TACBrBoletoFCClass}
TACBrBoletoFCFiltro = (fiNenhum, fiPDF, fiHTML ) ;

TACBrBoletoFCOnObterLogo = procedure( const PictureLogo : TPicture; const NumeroBanco: Integer ) of object ;

TACBrBoletoFCClass = class(TACBrComponent)
  private
    fDirLogo        : String;
    fFiltro: TACBrBoletoFCFiltro;
    fLayOut         : TACBrBolLayOut;
    fMostrarPreview : Boolean;
    fMostrarSetup: Boolean;
    fNomeArquivo: String;
    fNumCopias      : Integer;
    fOnObterLogo : TACBrBoletoFCOnObterLogo ;
    fSoftwareHouse  : String;
    function GetAbout: String;
    function GetArqLogo: String;
    function GetDirLogo: String;
    procedure SetAbout(const AValue: String);
    procedure SetACBrBoleto(const Value: TACBrBoleto);
    procedure SetDirLogo(const AValue: String);
  protected
    fpAbout : String ;
    fACBrBoleto : TACBrBoleto;
    procedure SetNumCopias(AValue: Integer);
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
  public
    Constructor Create(AOwner: TComponent); override;

    procedure Imprimir; virtual;
    procedure GerarPDF; virtual;
    procedure GerarHTML; virtual;

    procedure CarregaLogo( const PictureLogo : TPicture; const NumeroBanco: Integer ) ;

    property ArquivoLogo : String read GetArqLogo;
  published
    property About : String read GetAbout write SetAbout stored False ;

    property OnObterLogo    : TACBrBoletoFCOnObterLogo read fOnObterLogo write fOnObterLogo ;
    property ACBrBoleto     : TACBrBoleto     read fACBrBoleto     write SetACBrBoleto ;
    property LayOut         : TACBrBolLayOut  read fLayOut         write fLayOut         default lPadrao;
    property DirLogo        : String          read GetDirLogo      write SetDirLogo;
    property MostrarPreview : Boolean         read fMostrarPreview write fMostrarPreview default True ;
    property MostrarSetup   : Boolean         read fMostrarSetup   write fMostrarSetup   default True ;
    property NumCopias      : Integer         read fNumCopias      write SetNumCopias    default 1;
    property Filtro         : TACBrBoletoFCFiltro read fFiltro     write fFiltro         default fiNenhum ;
    property NomeArquivo    : String          read fNomeArquivo    write fNomeArquivo ;
    property SoftwareHouse  : String          read fSoftwareHouse  write fSoftwareHouse;
  end;

procedure Register;

implementation

Uses ACBrUtil, ACBrBancoBradesco, ACBrBancoBrasil, ACBrBancoItau, Forms,
     {$IFDEF COMPILER6_UP} StrUtils {$ELSE} ACBrD5{$ENDIF},
     Math;

{$IFNDEF FPC}
   {$R ACBrBoleto.dcr}
{$ENDIF}

procedure Register;
begin
   RegisterComponents('ACBr', [TACBrBoleto]);
end;

{ TACBrCedente }
procedure TACBrCedente.SetCNPJCPF ( const AValue: String ) ;
var
   ACbrValidador: TACBrValidador;
begin
   if CNPJCPF = AValue then
      exit;

   if TipoInscricao <> tiOutro then
   begin
      ACbrValidador := TACBrValidador.Create(Self);
      try
        with ACbrValidador do
        begin
          if TipoInscricao = tiPessoaFisica then
             TipoDocto := docCPF
          else
             TipoDocto := docCNPJ;

          IgnorarChar := './-';
          RaiseExcept := True;
          Documento   := AValue;
          Validar;    // Dispara Exception se Documento estiver errado
		  
          fCNPJCPF := AValue;
        end;
      finally
         ACbrValidador.Free;
      end;
   end;
end;

constructor TACBrCedente.Create( AOwner : TComponent );
begin
  inherited Create(AOwner);

  fNomeCedente   := '';
  fAgencia       := '';
  fAgenciaDigito := '';
  fConta         := '';
  fContaDigito   := '';
  fModalidade    := '';
  fConvenio      := '';
  fTipoBoleto    := tbCliEmite;
end;

destructor TACBrCedente.Destroy;
begin
  inherited;
end;

procedure TACBrTitulo.SetNossoNumero ( const AValue: String ) ;
begin
   with ACBrBoleto.Banco do
   begin
      if Length(trim(AValue)) > TamanhoMaximoNossoNum then
         raise Exception.Create('Tamanho Máximo do Nosso Número é '+ IntToStr(TamanhoMaximoNossoNum)+ '.');

      fNossoNumero := padR(trim(AValue),TamanhoMaximoNossoNum,'0');
   end;
end;

{ TACBrTitulo }

constructor TACBrTitulo.Create(ACBrBoleto:TACBrBoleto);
begin
  inherited Create;

  fACBrBoleto        := ACBrBoleto;
  fLocalPagamento    := 'Pagar preferencialmente nas agencias do '+ ACBrBoleto.Banco.Nome;
  fVencimento        := 0;
  fDataDocumento     := 0;
  fNumeroDocumento   := '';
  fEspecieDoc        := 'DM';
  fAceite            := 'N';
  fDataProcessamento := now;
  fNossoNumero       := '';
  fUsoBanco          := '';
  fCarteira          := '';
  fEspecieMod        := '';
  fValorDocumento    := 0;
  fMensagem          := TStringList.Create;
  fInstrucoes        := TStringList.Create;
  fSacado            := TACBrSacado.Create;
  fTipoOcorrencia                 := toRemessaRegistrar;
  fOcorrenciaOriginal             := '';
  fDescricaoOcorrenciaOriginal    := '';
  fMotivoRejeicaoComando          := '';
  fDescricaoMotivoRejeicaoComando := '';

  fDataOcorrencia       := 0;
  fDataCredito          := 0;
  fDataAbatimento       := 0;
  fDataDesconto         := 0;
  fDataMoraJuros        := 0;
  fDataProtesto         := 0;
  fDataBaixa            := 0;
  fValorDespesaCobranca := 0;
  fValorAbatimento      := 0;
  fValorDesconto        := 0;
  fValorMoraJuros       := 0;
  fValorIOF             := 0;
  fValorOutrasDespesas  := 0;
  fValorOutrosCreditos  := 0;
  fValorRecebido        := 0;
  fReferencia           := '';
  fVersao               := '';
end;

destructor TACBrTitulo.Destroy;
begin
  fMensagem.Free;
  fSacado.Free;
  fInstrucoes.Free;
  inherited;
end;

procedure TACBrBoleto.SetACBrBoletoFC ( const Value: TACBrBoletoFCClass ) ;
Var OldValue: TACBrBoletoFCClass;
begin
  if Value <> fACBrBoletoFC then
  begin
     if Assigned(fACBrBoletoFC) then
        fACBrBoletoFC.RemoveFreeNotification(Self);

     OldValue      := fACBrBoletoFC ;   // Usa outra variavel para evitar Loop Infinito
     fACBrBoletoFC := Value;            // na remoção da associação dos componentes

     if Assigned(OldValue) then
        if Assigned(OldValue.ACBrBoleto) then
           OldValue.ACBrBoleto := nil ;

     if Value <> nil then
     begin
        Value.FreeNotification(self);
        Value.ACBrBoleto := self ;
     end ;
  end ;

end;

function TACBrBoleto.GetAbout: String;
begin
  Result := 'ACBrBoleto Ver: '+CACBrBoleto_Versao;
end;

procedure TACBrBoleto.SetAbout(const AValue: String);
begin
  {}
end;

procedure TACBrBoleto.SetDirArqRemessa(const AValue: String);
begin
  fDirArqRemessa := PathWithDelim( AValue );
end;

procedure TACBrBoleto.SetNomeArqRemessa(const AValue: String);
var
  APath : AnsiString;
begin
  if fNomeArqRemessa = AValue then
     exit;

  fNomeArqRemessa := ExtractFileName( AValue );
  APath           := ExtractFilePath( AValue );

  if APath <> '' then
     DirArqRemessa := APath;
end;

procedure TACBrBoleto.Notification ( AComponent: TComponent;
   Operation: TOperation ) ;
begin
   inherited Notification ( AComponent, Operation ) ;

   if (Operation = opRemove) and (fACBrBoletoFC <> nil) and (AComponent is TACBrBoletoFCClass) then
     fACBrBoletoFC := nil ;
end;

{ TACBrBoleto }

constructor TACBrBoleto.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  fACBrBoletoFC           := nil;
  fImprimirMensagemPadrao := True;

  fListadeBoletos := TListadeBoletos.Create(true);

  fCedente      := TACBrCedente.Create(self);
  fCedente.Name := 'Cedente';
  {$IFDEF COMPILER6_UP}
   fCedente.SetSubComponent(True);   // Ajustando como SubComponente para aparecer no ObjectInspector
  {$ENDIF}

  fBanco := TACBrBanco.Create(self);
  fBanco.Name := 'Banco';
  {$IFDEF COMPILER6_UP}
   fBanco.SetSubComponent(True);   // Ajustando como SubComponente para aparecer no ObjectInspector
  {$ENDIF}
end;

destructor TACBrBoleto.Destroy;
begin
  fListadeBoletos.Free;
  fCedente.Free;
  fBanco.Free;

  inherited;
end;

function TACBrBoleto.CriarTituloNaLista: TACBrTitulo;
var
   I : Integer;
begin
  I      := fListadeBoletos.Add(TACBrTitulo.Create(self));
  Result := fListadeBoletos[I];
end;

Procedure TACBrBoleto.Imprimir;
begin
  if not Assigned(ACBrBoletoFC) then
     raise Exception.Create( 'Nenhum componente "ACBrBoletoFC" associado' ) ;

  ChecarDadosObrigatorios;

  ACBrBoletoFC.Imprimir;
end;

procedure TACBrBoleto.GerarPDF;
begin
   if not Assigned(ACBrBoletoFC) then
     raise Exception.Create( 'Nenhum componente "ACBrBoletoFC" associado' ) ;

  ChecarDadosObrigatorios;

  ACBrBoletoFC.GerarPDF;
end;

procedure TACBrBoleto.GerarHTML;
begin
   if not Assigned(ACBrBoletoFC) then
     raise Exception.Create( 'Nenhum componente "ACBrBoletoFC" associado' ) ;

   ChecarDadosObrigatorios;

   ACBrBoletoFC.GerarHTML;
end;

Procedure TACBrBoleto.AdicionarMensagensPadroes( Titulo : TACBrTitulo; AStringList: TStrings );
begin
   if not ImprimirMensagemPadrao  then
      exit;

   with Titulo do
   begin
      if DataProtesto <> 0 then
         AStringList.Add('Protestar em ' + FormatDateTime('dd/mm/yyyy',DataProtesto));

      if ValorAbatimento <> 0 then
      begin
         if DataAbatimento <> 0 then
            AStringList.Add( 'Conceder abatimento de ' +
                             FormatCurr('R$ #,##0.00',ValorAbatimento) +
                             ' para pagamento ate ' + FormatDateTime('dd/mm/yyyy',DataAbatimento))
         else
            AStringList.Add( 'Conceder abatimento de ' +
                             FormatCurr('R$ #,##0.00',ValorAbatimento) +
                             ' para pagamento ate ' + FormatDateTime('dd/mm/yyyy',Vencimento));
      end;

      if ValorDesconto <> 0 then
      begin
         if DataDesconto <> 0 then
            AStringList.Add( 'Conceder desconto de '                       +
                             FormatCurr('R$ #,##0.00',ValorDesconto)       +
                             ' por dia de antecipação para pagamento até ' +
                             FormatDateTime('dd/mm/yyyy',DataDesconto))
         else
            AStringList.Add( 'Conceder desconto de '                 +
                             FormatCurr('R$ #,##0.00',ValorDesconto) +
                             ' por dia de antecipaçao');
      end;

      if ValorMoraJuros <> 0 then
      begin
         if DataMoraJuros <> 0 then
            AStringList.Add( 'Cobrar juros de '                               +
                             FormatCurr('R$ #,##0.00',ValorMoraJuros)         +
                             ' por dia de atraso para pagamento a partir de ' +
                             FormatDateTime('dd/mm/yyyy',DataMoraJuros))
         else
            AStringList.Add( 'Cobrar juros de '                       +
                             FormatCurr('R$ #,##0.00',ValorMoraJuros) +
                             ' por dia de atraso');
      end;

      if PercentualMulta <> 0 then
         AStringList.Add('Cobrar Multa de ' +
                         FormatCurr('R$ #,##0.00',ValorDocumento*( 1+ PercentualMulta/100)-ValorDocumento) +
                         ' após o vencimento.');
   end;
end;

{ TListadeBoletos }

procedure TListadeBoletos.SetObject ( Index: Integer; Item: TACBrTitulo ) ;
begin
   inherited SetItem (Index, Item) ;
end;

function TListadeBoletos.GetObject ( Index: Integer ) : TACBrTitulo;
begin
   Result := inherited GetItem(Index) as TACBrTitulo ;
end;

procedure TListadeBoletos.Insert ( Index: Integer; Obj: TACBrTitulo ) ;
begin
   inherited Insert(Index, Obj);
end;

function TListadeBoletos.Add ( Obj: TACBrTitulo ) : Integer;
begin
   Result := inherited Add(Obj) ;
end;

function TACBrBanco.GetNome: String;
begin
   Result := ACBrStr(fBancoClass.Nome);
end;

function TACBrBanco.GetDigito: Integer;
begin
   Result := fBancoClass.Digito;
end;

function TACBrBanco.GetTamanhoMaximoNossoNum: Integer;
begin
   Result := BancoClass.TamanhoMaximoNossoNum;
end;

procedure TACBrBanco.SetDigito(const AValue: Integer);
begin
  {Apenas para aparecer no ObjectInspector do D7}
end;

procedure TACBrBanco.SetNome(const AValue: String);
begin
  {Apenas para aparecer no ObjectInspector do D7}
end;

procedure TACBrBanco.SetNumero(const AValue: Integer);
begin
   if fNumeroBanco = AValue then
      exit;

   fBancoClass.Free;

   case AValue of
      001 : fBancoClass := TACBrBancoBrasil.create(Self);
      237 : fBancoClass := TACBrBancoBradesco.create(Self);
      341 : fBancoClass := TACBrBancoItau.Create(self);
   else
      fBancoClass := TACBrBancoClass.create(Self);
   end;

   fNumeroBanco := AValue;
end;

{ TACBrBanco }

constructor TACBrBanco.Create ( AOwner: TComponent ) ;
begin
   inherited Create ( AOwner ) ;

   if not (AOwner is TACBrBoleto) then
      raise Exception.Create('Aowner deve ser do tipo TACBrBoleto');

   fACBrBoleto  := TACBrBoleto(AOwner);
   fNumeroBanco := 0;

   fBancoClass := TACBrBancoClass.create(Self);
end;

function TACBrBanco.CalcularDigitoVerificador ( const ACBrTitulo: TACBrTitulo
   ) : String;
begin
   Result:=  BancoClass.CalcularDigitoVerificador(ACBrTitulo);
end;

function TACBrBanco.MontarCampoNossoNumero ( const ACBrTitulo: TACBrTitulo
   ) : String;
begin
   Result:= BancoClass.MontarCampoNossoNumero(ACBrTitulo);
end;

function TACBrBanco.MontarCodigoBarras ( const ACBrTitulo: TACBrTitulo) : String;
begin
   Result:= BancoClass.MontarCodigoBarras(ACBrTitulo);
end;

function TACBrBanco.MontarLinhaDigitavel ( const CodigoBarras:String) : String;
begin
   Result:= BancoClass.MontarLinhaDigitavel(CodigoBarras);
end;

function TACBrBanco.GerarRegistroHeader400(NumeroRemessa: Integer): String;
begin
  Result :=  BancoClass.GerarRegistroHeader400( NumeroRemessa );
end;

function TACBrBanco.GerarRegistroHeader240(NumeroRemessa: Integer): String;
begin
  Result :=  BancoClass.GerarRegistroHeader240( NumeroRemessa );
end;

function TACBrBanco.GerarRegistroTransacao400(ACBrTitulo: TACBrTitulo): String;
begin
  Result := BancoClass.GerarRegistroTransacao400( ACBrTitulo );
end;

function TACBrBanco.GerarRegistroTransacao240(ACBrTitulo: TACBrTitulo): String;
begin
  Result := BancoClass.GerarRegistroTransacao240( ACBrTitulo );
end;

function TACBrBanco.GerarRegistroTrailler400(ARemessa: TStringList): String;
begin
  Result := BancoClass.GerarRegistroTrailler400( ARemessa );
end;

function TACBrBanco.GerarRegistroTrailler240(ARemessa: TStringList): String;
begin
  Result := BancoClass.GerarRegistroTrailler240( ARemessa );
end;

function TACBrBanco.CalcularNomeArquivoRemessa(const DirArquivo: String ): String;
begin
  BancoClass.CalcularNomeArquivoRemessa( DirArquivo );
end;

function TACBrBanco.MontarCampoCodigoCedente(
  const ACBrTitulo: TACBrTitulo): String;
begin
  Result:= BancoClass.MontarCampoCodigoCedente(ACBrTitulo);
end;


{ TACBrBancoClass }

function TACBrBancoClass.CalcularDigitoVerificador(const ACBrTitulo :TACBrTitulo ): String;
begin
   Result:= '';
end;
 function TACBrBancoClass.GetNumero: Integer;
begin
   Result:= ACBrBanco.Numero;
end;

function TACBrBancoClass.CalcularFatorVencimento(const DataVencimento: TDatetime) : String;
begin
   Result := IntToStr( Trunc(DataVencimento - EncodeDate(1997,10,07)) );
end;

function TACBrBancoClass.CalcularDigitoCodigoBarras (
   const CodigoBarras: String ) : String;
begin
   Modulo.CalculoPadrao;
   Modulo.Documento := CodigoBarras;
   Modulo.Calcular;

   Result:= IntToStr(Modulo.DigitoFinal);
end;

function TACBrBancoClass.CalcularNomeArquivoRemessa ( const DirArquivo: String) : String;
var
  Sequencia :Integer;
  Diretorio, NomeFixo, NomeArq: String;
begin
   Sequencia := 0;

   with ACBrBanco.ACBrBoleto do
   begin
      if DirArqRemessa = '' then
      begin
         Diretorio := ExtractFilePath(Application.ExeName)+'remessa'+PathDelim;

         if not DirectoryExists(Diretorio) then
            CreateDir(Diretorio);

         DirArqRemessa := Diretorio;
      end;

      if NomeArqRemessa = '' then
       begin
         NomeFixo := DirArqRemessa + 'cb' + FormatDateTime( 'ddmm', Now );

         repeat
            Inc( Sequencia );
            NomeArq := NomeFixo + IntToStrZero( Sequencia, 2 ) + '.rem'
         until not FileExists( NomeArq ) ;

         Result := NomeArq;
       end
      else
         Result := DirArqRemessa + NomeArqRemessa ;
   end;
end;

function TACBrBancoClass.MontarCodigoBarras ( const ACBrTitulo: TACBrTitulo) : String;
begin
   Result:= '';
end;

function TACBrBancoClass.MontarCampoNossoNumero ( const ACBrTitulo: TACBrTitulo
   ) : String;
begin
   Result:= ACBrTitulo.NossoNumero;
end;

function TACBrBancoClass.MontarLinhaDigitavel (const CodigoBarras: String): String;
var
  Campo1, Campo2, Campo3, Campo4, Campo5: String;
begin
   fpModulo.FormulaDigito        := frModulo10;
   fpModulo.MultiplicadorInicial := 1;
   fpModulo.MultiplicadorFinal   := 2;
   fpModulo.MultiplicadorAtual   := 2;


  {Campo 1(Código Banco,Tipo de Moeda,5 primeiro digitos do Campo Livre) }
   fpModulo.Documento := IntToStrZero(Numero,3)+'9'+Copy(CodigoBarras,20,5);
   fpModulo.Calcular;

   Campo1 := copy( fpModulo.Documento, 1, 5) + '.' +
             copy( fpModulo.Documento, 6, 4) +
             IntToStr( fpModulo.DigitoFinal );

  {Campo 2(6ª a 15ª posições do campo Livre)}
   fpModulo.Documento:= copy( CodigoBarras, 25, 10);
   fpModulo.Calcular;

   Campo2 := Copy( fpModulo.Documento, 1, 5) + '.' +
             Copy( fpModulo.Documento, 6, 5) +
             IntToStr( fpModulo.DigitoFinal );

  {Campo 3 (16ª a 25ª posições do campo Livre)}
   fpModulo.Documento:= copy( CodigoBarras, 35, 10);
   fpModulo.Calcular;

   Campo3 := Copy( fpModulo.Documento, 1, 5) + '.' +
             Copy( fpModulo.Documento, 6, 5) +
             IntToStr( fpModulo.DigitoFinal );

  {Campo 4 (Digito Verificador Nosso Numero)}
   Campo4 := Copy( CodigoBarras, 5, 1);

  {Campo 5 (Fator de Vencimento e Valor do Documento)}
   Campo5 := Copy( CodigoBarras, 6, 14);

   Result := Campo1+' '+Campo2+' '+Campo3+' '+Campo4+' '+Campo5;
end;

procedure TACBrBoleto.GerarRemessa( NumeroRemessa : Integer );
var
   SLRemessa   : TStringList;
   ContTitulos : Integer;
   NomeArq     : String ;
begin
   if ListadeBoletos.Count < 1 then
      raise Exception.Create(ACBrStr('Lista de Boletos está vazia'));

   ChecarDadosObrigatorios;

   if not DirectoryExists(fDirArqRemessa) then
      ForceDirectories( fDirArqRemessa );

   if not DirectoryExists(fDirArqRemessa) then
      raise Exception.Create( ACBrStr('Diretório inválido '+fDirArqRemessa) );

   if Trim( NomeArqRemessa ) = '' then
      NomeArq := Banco.CalcularNomeArquivoRemessa( DirArqRemessa )
   else
      NomeArq := DirArqRemessa + NomeArqRemessa;

   SLRemessa := TStringList.Create;
   try
      if LayoutRemessa =c400 then
      begin
         SLRemessa.Add( Banco.GerarRegistroHeader400( NumeroRemessa ) );

         for ContTitulos:= 0 to ListadeBoletos.Count-1 do
             SLRemessa.Add( Banco.GerarRegistroTransacao400( ListadeBoletos[ContTitulos] ) );

         SLRemessa.Add( Banco.GerarRegistroTrailler400( SLRemessa ) );
      end
      else
      begin
        SLRemessa.Add( Banco.GerarRegistroHeader240( NumeroRemessa ) );

         for ContTitulos:= 0 to ListadeBoletos.Count-1 do
             SLRemessa.Add( Banco.GerarRegistroTransacao240( ListadeBoletos[ContTitulos] ) );

         SLRemessa.Add( Banco.GerarRegistroTrailler240( SLRemessa ) );
      end;
      SLRemessa.SaveToFile( NomeArq );

   finally
      SLRemessa.Free;
   end;
end;

procedure TACBrBoleto.ChecarDadosObrigatorios;
begin
   if (Cedente.Nome= '') or (cedente.Conta = '') or (Cedente.ContaDigito ='') or
      (Cedente.Agencia = '') or (Cedente.AgenciaDigito = '') then
     raise Exception.Create('Informações do Cedente Imcompletas');
end;

{ TACBrBancoClass }

constructor TACBrBancoClass.create(AOwner: TACBrBanco);
begin
   inherited create;

   fpAOwner := AOwner;
   fpDigito := 0;
   fpNome   := 'Não definido';
   fpTamanhoMaximoNossoNum := 10;
   fpModulo := TACBrCalcDigito.Create;
end;

destructor TACBrBancoClass.Destroy;
begin
   fpModulo.Free;
   Inherited Destroy;
end;

function TACBrBancoClass.GerarRegistroHeader400( NumeroRemessa: Integer): String;
begin
  { Método implementado apenas para evitar Warnings de compilação (poderia ser abstrato)
    Você de fazer "override" desse método em todas as classes filhas de TACBrBancoClass }
  //Result := '' ;
  raise Exception.Create( ACBrStr('Geracao do arquivo Remessa em 400 colunas não implementada o banco '+ Nome+'.')) ;
end;

function TACBrBancoClass.GerarRegistroHeader240 ( NumeroRemessa: Integer
   ) : String;
begin
   raise Exception.Create( ACBrStr('Geracao do arquivo Remessa em 240 colunas não implementada para o banco '+ Nome+'.')) ;
end;

function TACBrBancoClass.GerarRegistroTrailler400( ARemessa: TStringList): String;
begin
  { Método implementado apenas para evitar Warnings de compilação (poderia ser abstrato)
    Você de fazer "override" desse método em todas as classes filhas de TACBrBancoClass }
  Result := '' ;
end;

function TACBrBancoClass.MontarCampoCodigoCedente(
  const ACBrTitulo: TACBrTitulo): String;
begin
  Result := '';
end;


function TACBrBancoClass.GerarRegistroTrailler240 ( ARemessa: TStringList
   ) : String;
begin
   Result:= '';
end;

function TACBrBancoClass.GerarRegistroTransacao400(  ACBrTitulo: TACBrTitulo): String;
begin
  { Método implementado apenas para evitar Warnings de compilação (poderia ser abstrato)
    Você de fazer "override" desse método em todas as classes filhas de TACBrBancoClass }
   Result:= '';
end;

function TACBrBancoClass.GerarRegistroTransacao240 ( ACBrTitulo: TACBrTitulo
   ) : String;
begin
   Result:= '';
end;

{ TACBrBoletoFCClass }

constructor TACBrBoletoFCClass.Create ( AOwner: TComponent ) ;
begin
   inherited Create ( AOwner ) ;

   fpAbout         := 'ACBrBoletoFCClass' ;
   fACBrBoleto     := nil;
   fLayOut         := lPadrao;
   fNumCopias      := 1;
   fMostrarPreview := True;
   fMostrarSetup   := True;
   fFiltro         := fiNenhum;
   fNomeArquivo    := '' ;
end;

procedure TACBrBoletoFCClass.Notification ( AComponent: TComponent;
   Operation: TOperation ) ;
begin
   inherited Notification ( AComponent, Operation ) ;

   if (Operation = opRemove) and (fACBrBoleto <> nil) and (AComponent is TACBrBoleto) then
      fACBrBoleto := nil ;
end;

procedure TACBrBoletoFCClass.CarregaLogo(const PictureLogo : TPicture; const NumeroBanco: Integer ) ;
begin
  if Assigned( fOnObterLogo ) then
     fOnObterLogo( PictureLogo, NumeroBanco)
  else
   begin
     if FileExists( ArquivoLogo ) then
        PictureLogo.LoadFromFile( ArquivoLogo );
   end ;
end ;

procedure TACBrBoletoFCClass.SetACBrBoleto ( const Value: TACBrBoleto ) ;
  Var OldValue : TACBrBoleto ;
begin
  if Value <> fACBrBoleto then
  begin
     if Assigned(fACBrBoleto) then
        fACBrBoleto.RemoveFreeNotification(Self);

     OldValue    := fACBrBoleto ;   // Usa outra variavel para evitar Loop Infinito
     fACBrBoleto := Value;          // na remoção da associação dos componentes

     if Assigned(OldValue) then
        if Assigned(OldValue.ACBrBoletoFC) then
           OldValue.ACBrBoletoFC := nil ;

     if Value <> nil then
     begin
        Value.FreeNotification(self);
        Value.ACBrBoletoFC := self ;
     end ;
  end ;

end;

procedure TACBrBoletoFCClass.SetDirLogo(const AValue: String);
begin
  fDirLogo := PathWithDelim( AValue );
end;

function TACBrBoletoFCClass.GetArqLogo: String;
begin
   Result := DirLogo + IntToStrZero( ACBrBoleto.Banco.Numero, 3)+'.bmp';
end;

function TACBrBoletoFCClass.GetAbout: String;
begin
  Result := fpAbout ;
end;

function TACBrBoletoFCClass.GetDirLogo: String;
begin
  if fDirLogo = '' then
     Result := '.' + PathDelim + 'logos' + PathDelim
  else
     Result := fDirLogo;
end;

procedure TACBrBoletoFCClass.SetAbout(const AValue: String);
begin
  {}
end;

procedure TACBrBoletoFCClass.SetNumCopias ( AValue: Integer ) ;
begin
  fNumCopias := max( 1, Avalue);
end;

procedure TACBrBoletoFCClass.Imprimir;
begin
   if not Assigned(fACBrBoleto) then
      raise Exception.Create(ACBrStr('Componente não está associado a ACBrBoleto'));

   if fACBrBoleto.ListadeBoletos.Count < 1 then
      raise Exception.Create(ACBrStr('Lista de Boletos está vazia'));
end;

procedure TACBrBoletoFCClass.GerarPDF;
var
   FiltroAntigo         : TACBrBoletoFCFiltro;
   MostrarPreviewAntigo : Boolean;
   MostrarSetupAntigo   : Boolean;
begin
   if NomeArquivo = '' then
      raise Exception.Create( ACBrStr('NomeArquivo não especificado')) ;

   FiltroAntigo         := Filtro;
   MostrarPreviewAntigo := MostrarPreview;
   MostrarSetupAntigo   := MostrarSetup;
   try
     Filtro         := fiPDF;
     MostrarPreview := false;
     MostrarSetup   := false;

     Imprimir;
   finally
     Filtro         := FiltroAntigo;
     MostrarPreview := MostrarPreviewAntigo;
     MostrarSetup   := MostrarSetupAntigo;
   end;
end;

procedure TACBrBoletoFCClass.GerarHTML;
var
   FiltroAntigo         : TACBrBoletoFCFiltro;
   MostrarPreviewAntigo : Boolean;
   MostrarSetupAntigo   : Boolean;
begin
   if NomeArquivo = '' then
      raise Exception.Create( ACBrStr('NomeArquivo não especificado')) ;

   FiltroAntigo         := Filtro;
   MostrarPreviewAntigo := MostrarPreview;
   MostrarSetupAntigo   := MostrarSetup;

   try
     Filtro         := fiHTML;
     MostrarPreview := false;
     MostrarSetup   := false;

     Imprimir;
   finally
     Filtro         := FiltroAntigo;
     MostrarPreview := MostrarPreviewAntigo;
     MostrarSetup   := MostrarSetupAntigo;
   end;
end;

{$ifdef FPC}
initialization
   {$I ACBrBoleto.lrs}
{$endif}

end.

