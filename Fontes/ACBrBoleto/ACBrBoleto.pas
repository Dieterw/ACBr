{******************************************************************************}
{ Projeto: Componentes ACBr                                                    }
{  Biblioteca multiplataforma de componentes Delphi para interação com equipa- }
{ mentos de Automação Comercial utilizados no Brasil                           }
{                                                                              }
{ Direitos Autorais Reservados (c) 2009 Daniel Simoes de Almeida               }
{                                       André Ferreira de Moraes               }
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
|* 02/10/2009:André Ferreira de Moraes
|* 01/04/2010:Juliana Rodrigues Prado Tamizou
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
     {$IFDEF COMPILER6_UP} Types {$ELSE} Windows {$ENDIF}
     ,Contnrs, Classes;

type
  TACBrTitulo = class;
  TACBrBoletoFCClass = class;
  TACBrCedente = class;
  TACBrBanco  = class;
  TACBrBoleto = class;

  { TACBrBancoClass }

  TACBrBancoClass = class
  private

  protected
    fpNumero: Integer;
    fpDigito: Integer;
    fpNome:   String;
    fpModulo: TACBrCalcDigito;
    fpAOwner: TACBrBanco;
    fpTamanhoMaximoNossoNum: Integer;
    function CalcularFatorVencimento(const DataVencimento: TDateTime): String; virtual;
    function CalcularDigitoCodigoBarras(const CodigoBarras: String): String; virtual;
  public
    Constructor create(AOwner: TACBrBanco);
    Destructor Destroy;

    property ACBrBanco : TACBrBanco      read fpAOwner;
    property Numero    : Integer         read fpNumero;
    property Digito    : Integer         read fpDigito;
    property Nome      : String          read fpNome;
    Property Modulo    : TACBrCalcDigito read fpModulo;
    property TamanhoMaximoNossoNum: Integer    read fpTamanhoMaximoNossoNum;
    function CalcularDigitoVerificador(const ACBrTitulo : TACBrTitulo): String; virtual;
    function MontarCodigoBarras(const ACBrTitulo : TACBrTitulo): String; virtual;
    function MontarLinhaDigitavel(const CodigoBarras: String): String; virtual;
  end;

  TACBrTipoBanco = (banNaoDefinido,banBradesco,banItau);

  { TACBrBanco }

  TACBrBanco = class(TComponent)
  private
    fACBrBoleto        : TACBrBoleto;
    fTipoBanco         : TACBrTipoBanco;
    fBancoClass        : TACBrBancoClass;
    function GetNome   : String;
    function GetNumero : Integer;
    function GetDigito : Integer;
    function GetTamanhoMaximoNossoNum : Integer;
    procedure SetTipoBanco ( const AValue: TACBrTipoBanco );
  public
    constructor Create( AOwner : TComponent); override;

    property ACBrBoleto : TACBrBoleto     read fACBrBoleto;
    property BancoClass : TACBrBancoClass read fBancoClass ;
    property Numero     : Integer         read GetNumero;
    property Digito     : Integer         read GetDigito;
    property Nome       : String          read GetNome;
    property TamanhoMaximoNossoNum :Integer read GetTamanhoMaximoNossoNum;

    function CalcularDigitoVerificador(const ACBrTitulo : TACBrTitulo): String;
    function MontarCodigoBarras(const ACBrTitulo : TACBrTitulo): String;
    function MontarLinhaDigitavel(const CodigoBarras: String): String;
  published
    property TipoBanco : TACBrTipoBanco read fTipoBanco write SetTipoBanco default banNaoDefinido;
  end;

  TACBrTipoBoleto = (tbCliEmite,tbBancoEmite,tbBancoReemite,tbBancoNaoReemite);

  TACBrCedente = class(TComponent)
  private
    fNomeCedente   : String;
    fAgencia       : String;
    fAgenciaDigito : String;
    fConta         : String;
    fContaDigito   : String;
    fModalidade    : String;
    fConvenio      : String;
    fTipoBoleto    : TACBrTipoBoleto;
  public
    constructor Create( AOwner : TComponent ) ; override ;
    destructor Destroy; override;
  published
    property Nome         : String read fNomeCedente     write fNomeCedente;
    property Agencia      : String read fAgencia         write fAgencia;
    property AgenciaDigito: String read fAgenciaDigito write fAgenciaDigito;
    property Conta        : String read fConta           write fConta;
    property ContaDigito  : String read fContaDigito write fContaDigito;
    property Modalidade   : String read fModalidade  write fModalidade;
    property Convenio     : String read fConvenio    write fConvenio;
    property TipoBoleto   : TACBrTipoBoleto read fTipoBoleto    write fTipoBoleto default tbCliEmite ;
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
    fLocalPagamento    : String;
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
     property LocalPagamento    : String    read fLocalPagamento  write fLocalPagamento;
     property Vencimento        : TDateTime read fVencimento  write fVencimento;
     property DataDocumento     : TDateTime read fDataDocumento  write fDataDocumento;
     property NumeroDocumento   : String    read fNumeroDocumento  write fNumeroDocumento ;
     property EspecieDoc        : String    read fEspecieDoc  write fEspecieDoc;
     property Aceite            : String    read fAceite write fAceite;
     property DataProcessamento : TDateTime read fDataProcessamento  write fDataProcessamento;
     property NossoNumero       : String    read fNossoNumero  write SetNossoNumero;
     property UsoBanco          : String    read fUsoBanco  write fUsoBanco;
     property Carteira          : String    read fCarteira  write fCarteira;
     property EspecieMod        : String    read fEspecieMod  write fEspecieMod;
     property ValorDocumento    : Currency  read fValorDocumento   write fValorDocumento;
     property Mensagem          : TStrings  read fMensagem  write fMensagem;
     property Instrucoes        : TStrings  read fInstrucoes  write fInstrucoes;
     property Sacado            : TACBrSacado   read fSacado  write fSacado;

     property TipoOcorrencia                 : TACBrTipoOcorrencia read fTipoOcorrencia  write fTipoOcorrencia default toRemessaRegistrar ;
     property OcorrenciaOriginal             : String read fOcorrenciaOriginal  write fOcorrenciaOriginal;
     property DescricaoOcorrenciaOriginal    : String read fDescricaoOcorrenciaOriginal  write fDescricaoOcorrenciaOriginal;
     property MotivoRejeicaoComando          : String read fMotivoRejeicaoComando  write fMotivoRejeicaoComando;
     property DescricaoMotivoRejeicaoComando : String read fDescricaoMotivoRejeicaoComando  write fDescricaoMotivoRejeicaoComando;
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
     property Referencia           : String read fReferencia  write fReferencia;
     property Versao               : String read fVersao  write fVersao;
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

{ TACBrBoleto }
TACBrBoleto = class( TACBrComponent )
  private
    fBanco: TACBrBanco;
    fACBrBoletoFC: TACBrBoletoFCClass;
    fListadeBoletos : TListadeBoletos;
    fCedente        : TACBrCedente;
    procedure SetACBrBoletoFC(const Value: TACBrBoletoFCClass);
  protected
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property ListadeBoletos : TListadeBoletos read fListadeBoletos write fListadeBoletos ;

    function CriarTituloNaLista: TACBrTitulo;
  published
    property Cedente  : TACBrCedente          read fCedente      write fCedente ;
    property Banco    : TACBrBanco            read fBanco        write fBanco;
    property ACBrBoletoFC :TACBrBoletoFCClass read fACBrBoletoFC write SetACBrBoletoFC;
  end;

{TACBrBoletoFCClass}

TACBrBoletoFCClass = class(TACBrComponent)
  private
    fDirLogo        : String;
    fLayOut         : TACBrBolLayOut;
    fMostrarPreview : Boolean;
    fNumCopias      : Integer;
    fSoftwareHouse  : String;
    procedure SetACBrBoleto(const Value: TACBrBoleto);
    procedure ErroAbstract( NomeProcedure : String ) ;
  protected
    fACBrBoleto : TACBrBoleto;
    procedure SetNumCopias(AValue: Integer);
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
  public
    Constructor Create(AOwner: TComponent); override;
    procedure Imprimir; virtual;
  published
    property ACBrBoleto     :TACBrBoleto     read fACBrBoleto     write SetACBrBoleto ;
    property LayOut         :TACBrBolLayOut  read fLayOut         write fLayOut  default lPadrao;
    property DirLogo        :String          read fDirLogo        write fDirLogo;
    property MostrarPreview :Boolean         read fMostrarPreview write fMostrarPreview;
    property NumCopias      :Integer         read fNumCopias      write SetNumCopias default 1;
    property SoftwareHouse  :String          read fSoftwareHouse  write fSoftwareHouse;
  end;

procedure Register;

implementation

Uses ACBrUtil,ACBrBancoBradesco,
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
var
   Tam: Integer;
begin
   Tam := ACBrBoleto.Banco.TamanhoMaximoNossoNum;
   if Length(trim(AValue)) > Tam then
      raise Exception.Create('Tamanho Máximo do Nosso Número é '+ IntToStr(Tam)+ '.');

   fNossoNumero := padR(trim(AValue),Tam,'0');
end;

{ TACBrTitulo }

constructor TACBrTitulo.Create(ACBrBoleto:TACBrBoleto);
begin
  inherited Create;

  fACBrBoleto        := ACBrBoleto;
  fLocalPagamento    := '';
  fVencimento        := 0;
  fDataDocumento     := 0;
  fNumeroDocumento   := '';
  fEspecieDoc        := '';
  fAceite            := '';
  fDataProcessamento := 0;
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

  fACBrBoletoFC:= nil;

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
var I: Integer;
begin
   I      := fListadeBoletos.Add(TACBrTitulo.Create(self));
   Result := fListadeBoletos[I];
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

procedure TACBrBanco.SetTipoBanco ( const AValue: TACBrTipoBanco ) ;
begin
   if fTipoBanco = AValue then
      exit;

   fBancoClass.Free;

   case AValue of
      banBradesco : fBancoClass := TACBrBancoBradesco.create(Self);
      banItau     : fBancoClass := TACBrBancoClass.create(Self);
   else
      fBancoClass := TACBrBancoClass.create(Self);
   end;
   fTipoBanco := AValue;
end;

function TACBrBanco.GetNome: String;
begin
   Result:= ACBrStr(fBancoClass.Nome);
end;

function TACBrBanco.GetNumero: Integer;
begin
   Result:= fBancoClass.Numero;
end;

function TACBrBanco.GetDigito: Integer;
begin
   Result := fBancoClass.Digito;
end;

function TACBrBanco.GetTamanhoMaximoNossoNum: Integer;
begin
   Result := BancoClass.TamanhoMaximoNossoNum;
end;

{ TACBrBanco }

constructor TACBrBanco.Create ( AOwner: TComponent ) ;
begin
   inherited Create ( AOwner ) ;

   if not (AOwner is TACBrBoleto) then
      raise Exception.Create('Aowner deve ser do tipo TACBrBoleto');

   fACBrBoleto := TACBrBoleto(AOwner);
   fTipoBanco  := banNaoDefinido;

   fBancoClass := TACBrBancoClass.create(Self);
end;

function TACBrBanco.CalcularDigitoVerificador ( const ACBrTitulo: TACBrTitulo
   ) : String;
begin
   Result:=  BancoClass.CalcularDigitoVerificador(ACBrTitulo);
end;

function TACBrBanco.MontarCodigoBarras ( const ACBrTitulo: TACBrTitulo) : String;
begin
   Result:= BancoClass.MontarCodigoBarras(ACBrTitulo);
end;

function TACBrBanco.MontarLinhaDigitavel ( const CodigoBarras:String) : String;
begin
   Result:= BancoClass.MontarLinhaDigitavel(CodigoBarras);
end;

function TACBrBancoClass.CalcularDigitoVerificador(const ACBrTitulo :TACBrTitulo ): String;
begin
   Result:= '';
end;

function TACBrBancoClass.CalcularFatorVencimento(const DataVencimento: TDatetime) : String;
begin
   Result := IntToStr( Trunc(DataVencimento - EncodeDate(1997,10,07)));
end;

function TACBrBancoClass.CalcularDigitoCodigoBarras (
   const CodigoBarras: String ) : String;
begin
   Modulo.CalculoPadrao;
   Modulo.Calcular;

   Result:= IntToStr(Modulo.DigitoFinal);
end;

function TACBrBancoClass.MontarCodigoBarras ( const ACBrTitulo: TACBrTitulo) : String;
begin
   Result:= '';
end;

function TACBrBancoClass.MontarLinhaDigitavel (const CodigoBarras: String): String;
var
  Campo1,Campo2,Campo3,Campo4,Campo5: String;
begin
   fpModulo.FormulaDigito := frModulo10;
   fpModulo.MultiplicadorInicial := 1;
   fpModulo.MultiplicadorFinal   := 2;
   fpModulo.MultiplicadorAtual   := 2;


  {Campo 1(Código Banco,Tipo de Moeda,5 primeiro digitos do Campo Livre) }
   fpModulo.Documento := IntToStr(fpNumero)+'9'+Copy(CodigoBarras,20,5);
   fpModulo.Calcular;

   Campo1 := copy(fpModulo.Documento,1,5)+'.'+copy(fpModulo.Documento,6,4)+
             inttostr(fpModulo.DigitoFinal);

  {Campo 2(6ª a 15ª posições do campo Livre)}
   fpModulo.Documento := copy(CodigoBarras,25,10);
   fpModulo.Calcular;

   Campo2 := Copy(fpModulo.Documento,1,5)+'.'+Copy(fpModulo.Documento,6,5)+
             inttostr(fpModulo.DigitoFinal);

  {Campo 3 (16ª a 25ª posições do campo Livre)}
   fpModulo.Documento := copy(CodigoBarras,35,10);
   fpModulo.Calcular;

   Campo3 := Copy(fpModulo.Documento,1,5)+'.'+Copy(fpModulo.Documento,6,5)+
             inttostr(fpModulo.DigitoFinal);

  {Campo 4 (Digito Verificador Nosso Numero)}
   Campo4 := Copy(CodigoBarras,5,1);

  {Campo 5 (Fator de Vencimento e Valor do Documento)}
   Campo5 := Copy(CodigoBarras,6,14);

   Result := Campo1+' '+Campo2+' '+Campo3+' '+Campo4+' '+Campo5;
end;

{ TACBrBancoClass }

constructor TACBrBancoClass.create(AOwner: TACBrBanco);
begin
   inherited create;

   fpAOwner := AOwner;
   fpNumero := 0;
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

{ TACBrBoletoFCClass }

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

procedure TACBrBoletoFCClass.ErroAbstract ( NomeProcedure: String ) ;
begin
   raise Exception.Create( ACBrStr('Procedure: '+NomeProcedure+' não implementada' ) ) ;
end;

procedure TACBrBoletoFCClass.SetNumCopias ( AValue: Integer ) ;
begin
  fNumCopias := max(1,Avalue);
end;

procedure TACBrBoletoFCClass.Notification ( AComponent: TComponent;
   Operation: TOperation ) ;
begin
   inherited Notification ( AComponent, Operation ) ;

   if (Operation = opRemove) and (fACBrBoleto <> nil) and (AComponent is TACBrBoleto) then
      fACBrBoleto := nil ;
end;

constructor TACBrBoletoFCClass.Create ( AOwner: TComponent ) ;
begin
   inherited Create ( AOwner ) ;
   fACBrBoleto:= nil;
   fLayOut    := lPadrao;
   fNumCopias := 1;
end;

procedure TACBrBoletoFCClass.Imprimir;
begin
   ErroAbstract('Imprimir');
end;

{$ifdef FPC}
initialization
   {$I ACBrBoleto.lrs}
{$endif}

end.

