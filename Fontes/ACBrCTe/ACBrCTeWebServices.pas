{******************************************************************************}
{ Projeto: Componente ACBrCTe                                                  }
{  Biblioteca multiplataforma de componentes Delphi para emissão de Nota Fiscal}
{ eletrônica - CTe - http://www.CTe.fazenda.gov.br                             }
{                                                                              }
{ Direitos Autorais Reservados (c) 2008 Wiliam Zacarias da Silva Rosa          }
{                                       Wemerson Souto                         }
{                                       Daniel Simoes de Almeida               }
{                                       André Ferreira de Moraes               }
{                                                                              }
{ Colaboradores nesse arquivo:                                                 }
{                                                                              }
{  Você pode obter a última versão desse arquivo na pagina do Projeto ACBr     }
{ Componentes localizado em http://www.sourceforge.net/projects/acbr           }
{                                                                              }
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
{ Wiliam Zacarias da Silva Rosa  -  wrosa2009@yahoo.com.br -  www.motta.com.br }
{                                                                              }
{******************************************************************************}

{******************************************************************************
|* Historico
|*
|* 16/12/2008: Wemerson Souto
|*  - Doação do componente para o Projeto ACBr
|* 10/08/2009 : Wiliam Zacarias da Silva Rosa
|*  - Criadas classes e procedimentos para acesso aos webservices
|* 08/03/2010 : Bruno - Rhythmus Informatica
|* Corrigida função DoCTeRecepcao
******************************************************************************}
{$I ACBr.inc}

unit ACBrCTeWebServices;

interface

uses Classes, SysUtils,
  {$IFDEF VCL} Dialogs, {$ELSE} QDialogs, {$ENDIF}
  {$IFDEF ACBrCTeOpenSSL}
    HTTPSend,
  {$ELSE}
     SOAPHTTPTrans, WinInet, ACBrCAPICOM_TLB,
  {$ENDIF}
  pcnAuxiliar, pcnConversao, pcteRetConsCad,
  ACBrCTeConfiguracoes, ACBrCteConhecimentos,
  pcteRetConsReciCTe, pcteProcCte, pcteConsReciCTe, pcteRetEnvCTe;

type

  TWebServicesBase = Class
  private
  	procedure DoCTeStatusServico;
    procedure DoCTeConsultaCadastro;
    procedure DoCTeConsulta;
    procedure DoCTeCancelamento;
    procedure DoCTeInutilizacao;
    procedure DoCTeRecepcao;
    procedure DoCTeRetRecepcao;
    procedure DoCTeRecibo;

    {$IFDEF ACBrCTeOpenSSL}
       procedure ConfiguraHTTP( HTTP : THTTPSend; Action : AnsiString);
    {$ELSE}
       procedure OnBeforePost(const HTTPReqResp: THTTPReqResp; Data:Pointer);
    {$ENDIF}
  protected
    FCabMsg: AnsiString;
    FDadosMsg: AnsiString;
    FRetWS: AnsiString;
    FMsg: AnsiString;
    FURL: WideString;
    FConfiguracoes: TConfiguracoes;
    FACBrCTe : TComponent;
    procedure LoadMsgEntrada;
    procedure LoadURL;
  public
    function Executar: Boolean;virtual;
    constructor Create(AOwner : TComponent); virtual;
    property DadosMsg: AnsiString read FDadosMsg;
    property RetWS: AnsiString read FRetWS;
    property Msg: AnsiString read FMsg;
  end;

  TCTeStatusServico = Class(TWebServicesBase)
  private
    FtpAmb : TpcnTipoAmbiente;
    FverAplic : String;
    FcStat : Integer;
    FxMotivo : String;
    FcUF : Integer;
    FdhRecbto : TDateTime;
    FTMed : Integer;
    FdhRetorno : TDateTime;
    FxObs :  String;
  public
    function Executar: Boolean; override;
    property tpAmb : TpcnTipoAmbiente read FtpAmb;
    property verAplic : String read FverAplic;
    property cStat : Integer read FcStat;
    property xMotivo : String read FxMotivo;
    property cUF : Integer read FcUF;
    property dhRecbto : TDateTime read FdhRecbto;
    property TMed : Integer read FTMed;
    property dhRetorno : TDateTime read FdhRetorno;
    property xObs :  String read FxObs;
  end;

  TCTeConsultaCadastro = Class(TWebServicesBase)
  private
    FverAplic: String;
    FcStat: Integer;
    FxMotivo: String;
    FUF: String;
    FIE: String;
    FCNPJ: String;
    FCPF: String;
    FcUF: Integer;
    FdhCons: TDateTime;
    FRetConsCad : TRetConsCad;
  public
    function Executar: Boolean;override;
    property verAplic: String read FverAplic;
    property cStat: Integer read FcStat;
    property xMotivo: String read FxMotivo;
    property DhCons: TDateTime read FdhCons;
    property cUF: Integer read FcUF;
    property RetConsCad: TRetConsCad read FRetConsCad;
    property UF:   String read FUF write FUF;
    property IE:   String read FIE write FIE;
    property CNPJ: String read FCNPJ write FCNPJ;
    property CPF:  String read FCPF write FCPF;
  end;

  TCTeConsulta = Class(TWebServicesBase)
  private
    FCTeChave: WideString;
    FProtocolo: WideString;
    FDhRecbto: TDateTime;
    FXMotivo: WideString;
    FTpAmb : TpcnTipoAmbiente;
    FverAplic : String;
    FcStat : Integer;
    FcUF : Integer;
    FdigVal : String;
  public
    function Executar: Boolean;override;
    property CTeChave: WideString read FCTeChave write FCTeChave;
    property Protocolo: WideString read FProtocolo write FProtocolo;
    property DhRecbto: TDateTime read FDhRecbto write FDhRecbto;
    property XMotivo: WideString read FXMotivo write FXMotivo;
    property TpAmb: TpcnTipoAmbiente read FTpAmb;
    property verAplic: String read FverAplic;
    property cStat: Integer read FcStat;
    property cUF: Integer read FcUF;
    property digVal: String read FdigVal;
  end;

  TCTeCancelamento = Class(TWebServicesBase)
  private
    FCTeChave: WideString;
    FProtocolo: WideString;
    FJustificativa: WideString;
    FTpAmb: TpcnTipoAmbiente;
    FverAplic: String;
    FcStat: Integer;
    FxMotivo: String;
    FcUF: Integer;
    FDhRecbto: TDateTime;
    procedure SetJustificativa(AValue: WideString);
  public
    function Executar: Boolean;override;
    property TpAmb: TpcnTipoAmbiente read FTpAmb;
    property verAplic: String read FverAplic;
    property cStat: Integer read FcStat;
    property xMotivo: String read FxMotivo;
    property cUF: Integer read FcUF;
    property DhRecbto: TDateTime read FDhRecbto;
    property CTeChave: WideString read FCTeChave write FCTeChave;
    property Protocolo: WideString read FProtocolo write FProtocolo;
    property Justificativa: WideString read FJustificativa write SetJustificativa;
  end;

  TCTeInutilizacao = Class(TWebServicesBase)
  private
    FCTeChave: WideString;
    FProtocolo: string;
    FModelo: Integer;
    FSerie: Integer;
    FCNPJ: String;
    FAno: Integer;
    FNumeroInicial: Integer;
    FNumeroFinal: Integer;
    FJustificativa: WideString;
    FTpAmb: TpcnTipoAmbiente;
    FverAplic: String;
    FcStat: Integer;
    FxMotivo : String;
    FcUF: Integer;
    FdhRecbto: TDateTime;
    procedure SetJustificativa(AValue: WideString);
  public
    function Executar: Boolean;override;
    property CTeChave: WideString read FCTeChave write FCTeChave;
    property Protocolo: String read FProtocolo write FProtocolo;
    property Modelo: Integer read FModelo write FModelo;
    property Serie: Integer read FSerie write FSerie;
    property CNPJ: String read FCNPJ write FCNPJ;
    property Ano: Integer read FAno write FAno;
    property NumeroInicial: Integer read FNumeroInicial write FNumeroInicial;
    property NumeroFinal: Integer read FNumeroFinal write FNumeroFinal;
    property Justificativa: WideString read FJustificativa write SetJustificativa;
    property TpAmb: TpcnTipoAmbiente read FTpAmb;
    property verAplic: String read FverAplic;
    property cStat: Integer read FcStat;
    property xMotivo : String read FxMotivo;
    property cUF: Integer read FcUF;
    property dhRecbto: TDateTime read FdhRecbto;
  end;

  TCTeRecepcao = Class(TWebServicesBase)
  private
    FLote: Integer;
    FRecibo : String;
    FCTes : TConhecimentos;
    FTpAmb: TpcnTipoAmbiente;
    FverAplic: String;
    FcStat: Integer;
    FxMotivo: String;
    FdhRecbto: TDateTime;
    FTMed: Integer;
    FcUF : Integer;
  public
    function Executar: Boolean; override;
    constructor Create(AOwner : TComponent; ACTes : TConhecimentos);reintroduce;
    property Recibo: String read FRecibo;
    property TpAmb: TpcnTipoAmbiente read FTpAmb;
    property verAplic: String read FverAplic;
    property cStat: Integer read FcStat;
    property xMotivo: String read FxMotivo;
    property dhRecbto: TDateTime read FdhRecbto;
    property TMed: Integer read FTMed;
    property Lote: Integer read FLote write FLote;
    property cUF : Integer read FcUF;
  end;

  TCteRetRecepcao = Class(TWebServicesBase)
  private
    FRecibo: String;
    FProtocolo: String;
    FChaveCte: String;
    FCTes: TConhecimentos;
    FCteRetorno: TRetConsReciCTe;
    FTpAmb: TpcnTipoAmbiente;
    FverAplic: String;
    FcStat: Integer;
    FcUF: Integer;
    FxMotivo: String;
    function Confirma(AInfProt: TProtCteCollection): Boolean;
  public
    function Executar: Boolean; override;
    constructor Create(AOwner : TComponent; AConhecimentos : TConhecimentos);reintroduce;
    destructor destroy; override;
    property TpAmb: TpcnTipoAmbiente read FTpAmb;
    property verAplic: String read FverAplic;
    property cStat: Integer read FcStat;
    property cUF: Integer read FcUF;
    property xMotivo: String read FxMotivo;
    property Recibo: String read FRecibo write FRecibo;
    property Protocolo: String read FProtocolo write FProtocolo;
    property ChaveCte: String read FChaveCte write FChaveCte;
    property CteRetorno: TRetConsReciCte read FCteRetorno write FCteRetorno;
  end;

  TCteRecibo = Class(TWebServicesBase)
  private
    FRecibo: String;
    FCTeRetorno: TRetConsReciCTe;
    FTpAmb: TpcnTipoAmbiente;
    FverAplic: String;
    FcStat: Integer;
    FxMotivo: String;
    FcUF: Integer;
  public
    function Executar: Boolean; override;
    constructor Create(AOwner : TComponent);reintroduce;
    destructor destroy; override;
    property TpAmb: TpcnTipoAmbiente read FTpAmb;
    property verAplic: String read FverAplic;
    property cStat: Integer read FcStat;
    property xMotivo: String read FxMotivo;
    property cUF: Integer read FcUF;
    property Recibo: String read FRecibo write FRecibo;
    property CTeRetorno: TRetConsReciCTe read FCTeRetorno write FCTeRetorno;
  end;

  TWebServices = Class(TWebServicesBase)
  private
    FACBrCTe : TComponent;
    FStatusServico: TCTeStatusServico;
    FConsultaCadastro: TCTeConsultaCadastro;
    FConsulta: TCTeConsulta;
    FCancelamento: TCTeCancelamento;
    FInutilizacao: TCTeInutilizacao;
    FEnviar: TCTeRecepcao;
    FRetorno: TCTeRetRecepcao;
    FRecibo: TCTeRecibo;
  public
    constructor Create(AFCTe: TComponent);reintroduce;
    procedure Cancela(AJustificativa: String);
    procedure Inutiliza(CNPJ, AJustificativa: String; Ano, Modelo, Serie, NumeroInicial, NumeroFinal : Integer);
    function Envia(ALote: Integer): Boolean;
    destructor Destroy; override;
  published
    property ACBrCTe: TComponent read FACBrCTe write FACBrCTe;
    property StatusServico: TCTeStatusServico read FStatusServico write FStatusServico;
    property ConsultaCadastro: TCTeConsultaCadastro read FConsultaCadastro write FConsultaCadastro;
    property Consulta: TCTeConsulta read FConsulta write FConsulta;
    property Cancelamento: TCTeCancelamento read FCancelamento write FCancelamento;
    property Inutilizacao: TCTeInutilizacao read FInutilizacao write FInutilizacao;
    property Enviar: TCTeRecepcao read FEnviar write FEnviar;
    property Recibo: TCTeRecibo read FRecibo write FRecibo;
    property Retorno: TCTeRetRecepcao read FRetorno write FRetorno;
  end;

implementation

uses {$IFDEF ACBrCTeOpenSSL}
        ssl_openssl,
     {$ENDIF}
     ACBrNFeUtil, ACBrCTeUtil, ACBrCTe,
     pcnGerador, pcnCabecalho, pcnLeitor,
     pcteConsStatServ, pcteRetConsStatServ,
     pcteConsCad,
     pcteConsSitCTe, pcteRetConsSitCTe,
     pcteCancCTe, pcteRetCancCTe,
     pcteInutCTe, pcteRetInutCTe;

{$IFNDEF ACBrCTeOpenSSL}
const
  INTERNET_OPTION_CLIENT_CERT_CONTEXT = 84;
{$ENDIF}

{ TWebServicesBase }
constructor TWebServicesBase.Create(AOwner: TComponent);
begin
  FConfiguracoes := TConfiguracoes( TACBrCTe( AOwner ).Configuracoes );
  FACBrCTe       := TACBrCTe( AOwner );
end;

{$IFDEF ACBrCTeOpenSSL}
procedure TWebServicesBase.ConfiguraHTTP( HTTP : THTTPSend; Action : AnsiString);
begin
  HTTP.Sock.SSL.PFXfile     := FConfiguracoes.Certificados.Certificado;
  HTTP.Sock.SSL.KeyPassword := FConfiguracoes.Certificados.Senha;

  HTTP.ProxyHost  := FConfiguracoes.WebServices.ProxyHost;
  HTTP.ProxyPort  := FConfiguracoes.WebServices.ProxyPort;
  HTTP.ProxyUser  := FConfiguracoes.WebServices.ProxyUser;
  HTTP.ProxyPass  := FConfiguracoes.WebServices.ProxyPass;

  HTTP.Sock.RaiseExcept := True;

  HTTP.MimeType := 'text/xml; charset=utf-8';
  HTTP.UserAgent := '';
  HTTP.Protocol := '1.2' ;
  HTTP.AddPortNumberToHost := False;
  HTTP.Headers.Add(Action);
end;

{$ELSE}

procedure TWebServicesBase.OnBeforePost(const HTTPReqResp: THTTPReqResp;
  Data: Pointer);
var
  Cert         : ICertificate2;
  CertContext  : ICertContext;
  PCertContext : Pointer;
begin
  Cert := FConfiguracoes.Certificados.GetCertificado;
  CertContext :=  Cert as ICertContext;
  CertContext.Get_CertContext(Integer(PCertContext));

  if not InternetSetOption(Data, INTERNET_OPTION_CLIENT_CERT_CONTEXT, PCertContext,sizeof(CertContext)*5) then
    raise Exception.Create( 'Erro OnBeforePost: ' + IntToStr(GetLastError) );
end;
{$ENDIF}

procedure TWebServicesBase.DoCTeStatusServico;
var
  ConsStatServ: TConsStatServ;
begin
  ConsStatServ := TConsStatServ.create;
  ConsStatServ.schema := TsPL005c;
  ConsStatServ.TpAmb  := TpcnTipoAmbiente(FConfiguracoes.WebServices.AmbienteCodigo-1);
  ConsStatServ.CUF    := FConfiguracoes.WebServices.UFCodigo;

  ConsStatServ.GerarXML;

  FDadosMsg := ConsStatServ.Gerador.ArquivoFormatoXML;
  ConsStatServ.Free;
end;

procedure TWebServicesBase.DoCTeConsultaCadastro;
var
  Cabecalho: TCabecalho;
  ConCadCTe: TConsCad;
begin
  Cabecalho := TCabecalho.Create;
  Cabecalho.Versao       := NFecabMsg;
  Cabecalho.VersaoDados  := NFeconsCad;
  Cabecalho.GerarXML;

  FCabMsg := Cabecalho.Gerador.ArquivoFormatoXML;
  Cabecalho.Free;

  ConCadCTe := TConsCad.Create;
  ConCadCTe.schema := TsPL005c;
  ConCadCTe.UF     := TCTeConsultaCadastro(Self).UF;
  ConCadCTe.IE     := TCTeConsultaCadastro(Self).IE;
  ConCadCTe.CNPJ   := TCTeConsultaCadastro(Self).CNPJ;
  ConCadCTe.CPF    := TCTeConsultaCadastro(Self).CPF;
  ConCadCTe.GerarXML;

  FDadosMsg := ConCadCTe.Gerador.ArquivoFormatoXML;

  ConCadCTe.Free
end;

procedure TWebServicesBase.DoCTeConsulta;
var
  ConsSitCTe : TConsSitCTe;
begin
  ConsSitCTe    := TConsSitCTe.Create;
  ConsSitCTe.schema := TsPL005c;
  ConsSitCTe.TpAmb := TpcnTipoAmbiente(FConfiguracoes.WebServices.AmbienteCodigo-1);
  ConsSitCTe.chCTe  := TCTeConsulta(Self).CTeChave;
  ConsSitCTe.GerarXML;

  FDadosMsg := ConsSitCTe.Gerador.ArquivoFormatoXML;
  ConsSitCTe.Free;
end;

procedure TWebServicesBase.DoCTeCancelamento;
var
  CancCTe: TcancCTe;
begin
  CancCTe := TcancCTe.Create;
  CancCTe.schema  := TsPL005c;
  CancCTe.chCTe   := TCTeCancelamento(Self).CTeChave;
  CancCTe.tpAmb   := TpcnTipoAmbiente(FConfiguracoes.WebServices.AmbienteCodigo-1);
  CancCTe.nProt   := TCTeCancelamento(Self).Protocolo;
  CancCTe.xJust   := TCTeCancelamento(Self).Justificativa;
  CancCTe.GerarXML;

{$IFDEF ACBrCTeOpenSSL}
  if not(CTeUtil.Assinar(CancCTe.Gerador.ArquivoFormatoXML, TConfiguracoes(FConfiguracoes).Certificados.Certificado , TConfiguracoes(FConfiguracoes).Certificados.Senha, FDadosMsg, FMsg)) then
    raise Exception.Create('Falha ao assinar Cancelamento de CT-e'+LineBreak+FMsg);
{$ELSE}
  if not(CTeUtil.Assinar(CancCTe.Gerador.ArquivoFormatoXML, TConfiguracoes(FConfiguracoes).Certificados.GetCertificado , FDadosMsg, FMsg)) then
    raise Exception.Create('Falha ao assinar Cancelamento de CT-e'+LineBreak+FMsg);
{$ENDIF}

  if not(CTeUtil.Valida(FDadosMsg, FMsg)) then
   raise Exception.Create('Falha na validação dos dados do cancelamento '+LineBreak+FMsg);

  CancCTe.Free;
end;

procedure TWebServicesBase.DoCTeInutilizacao;
var
  InutCTe: TinutCTe;
begin
  InutCTe := TinutCTe.Create;
  InutCTe.schema  := TsPL005c;
  InutCTe.tpAmb   := TpcnTipoAmbiente(FConfiguracoes.WebServices.AmbienteCodigo-1);
  InutCTe.cUF     := FConfiguracoes.WebServices.UFCodigo;
  InutCTe.ano     := TCTeInutilizacao(Self).Ano;
  InutCTe.CNPJ    := TCTeInutilizacao(Self).CNPJ;
  InutCTe.modelo  := TCTeInutilizacao(Self).Modelo;
  InutCTe.serie   := TCTeInutilizacao(Self).Serie;
  InutCTe.nNFIni  := TCTeInutilizacao(Self).NumeroInicial;
  InutCTe.nNFFin  := TCTeInutilizacao(Self).NumeroFinal;
  InutCTe.xJust   := TCTeInutilizacao(Self).Justificativa;
  InutCTe.GerarXML;

{$IFDEF ACBrCTeOpenSSL}
  if not(CTeUtil.Assinar(InutCTe.Gerador.ArquivoFormatoXML, TConfiguracoes(FConfiguracoes).Certificados.Certificado , TConfiguracoes(FConfiguracoes).Certificados.Senha, FDadosMsg, FMsg)) then
    raise Exception.Create('Falha ao assinar Inutilização do CT-e'+LineBreak+FMsg);
{$ELSE}
  if not(CTeUtil.Assinar(InutCTe.Gerador.ArquivoFormatoXML, TConfiguracoes(FConfiguracoes).Certificados.GetCertificado , FDadosMsg, FMsg)) then
    raise Exception.Create('Falha ao assinar Inutilização do CT-e'+LineBreak+FMsg);
{$ENDIF}

  InutCTe.Free
end;

procedure TWebServicesBase.DoCTeRecepcao;
var
  i: Integer;
  vCtes: WideString;
begin
  vCtes := '';
  for i := 0 to TCTeRecepcao(Self).FCTes.Count-1 do
    vCtes := vCtes + TCTeRecepcao(Self).FCTes.Items[I].XML;

  vCtes := StringReplace( vCtes, '<?xml version="1.0" encoding="UTF-8" ?>', '', [rfReplaceAll] );
  vCtes := StringReplace( vCtes, '<?xml version="1.0" encoding="UTF-8"?>' , '', [rfReplaceAll] );

  FDadosMsg := '<enviCTe xmlns="http://www.portalfiscal.inf.br/cte" versao="'+CTenviCTe+'">'+
               '<idLote>'+IntToStr(TCTeRecepcao(Self).Lote)+'</idLote>'+vCtes+'</enviCTe>';
end;

function TWebServicesBase.Executar: Boolean;
begin
  Result := False;
  LoadMsgEntrada;
  LoadURL;
end;

procedure TWebServicesBase.LoadMsgEntrada;
begin
  if self is TCTeStatusServico then
    DoCTeStatusServico
  else if self is TCTeConsultaCadastro then
    DoCTeConsultaCadastro
  else if self is TCTeConsulta then
    DoCTeConsulta
  else if self is TCTeCancelamento then
    DoCTeCancelamento
  else if self is TCTeInutilizacao then
    DoCTeInutilizacao
  else if self is TCTeRecepcao then
    DoCTeRecepcao
  else if self is TCTeRetRecepcao then
    DoCTeRetRecepcao
  else if self is TCTeRecibo then
    DoCTeRecibo
end;

procedure TWebServicesBase.LoadURL;
begin
  if self is TCTeStatusServico then
    FURL  := CTeUtil.GetURL(FConfiguracoes.WebServices.UFCodigo, FConfiguracoes.WebServices.AmbienteCodigo, FConfiguracoes.Geral.FormaEmissaoCodigo, LayCTeStatusServico)
  else if self is TCTeConsultaCadastro then
    FURL  := CTeUtil.GetURL(FConfiguracoes.WebServices.UFCodigo, FConfiguracoes.WebServices.AmbienteCodigo, FConfiguracoes.Geral.FormaEmissaoCodigo, LayCTeCadastro)
  else if self is TCTeConsulta then
    FURL  := CTeUtil.GetURL(FConfiguracoes.WebServices.UFCodigo, FConfiguracoes.WebServices.AmbienteCodigo, FConfiguracoes.Geral.FormaEmissaoCodigo, LayCTeConsultaCT)
  else if self is TCTeCancelamento then
    FURL  := CTeUtil.GetURL(FConfiguracoes.WebServices.UFCodigo, FConfiguracoes.WebServices.AmbienteCodigo, FConfiguracoes.Geral.FormaEmissaoCodigo, LayCTeCancelamento)
  else if self is TCTeInutilizacao then
    FURL  := CTeUtil.GetURL(FConfiguracoes.WebServices.UFCodigo, FConfiguracoes.WebServices.AmbienteCodigo, FConfiguracoes.Geral.FormaEmissaoCodigo, LayCTeInutilizacao)
  else if self is TCTeRecepcao then
    FURL  := CTeUtil.GetURL(FConfiguracoes.WebServices.UFCodigo, FConfiguracoes.WebServices.AmbienteCodigo, FConfiguracoes.Geral.FormaEmissaoCodigo, LayCTeRecepcao)
  else if (self is TCTeRetRecepcao) or (self is TCTeRecibo) then
    FURL  := CTeUtil.GetURL(FConfiguracoes.WebServices.UFCodigo, FConfiguracoes.WebServices.AmbienteCodigo, FConfiguracoes.Geral.FormaEmissaoCodigo, LayCTeRetRecepcao)
end;

procedure TWebServicesBase.DoCTeRetRecepcao;
var
  ConsReciCTe: TConsReciCTe;
begin
  ConsReciCTe   := TConsReciCTe.Create;
  ConsReciCTe.schema := TsPL005c;
  ConsReciCTe.tpAmb  := TpcnTipoAmbiente(FConfiguracoes.WebServices.AmbienteCodigo-1);
  ConsReciCTe.nRec   := TCTeRetRecepcao(Self).Recibo;
  ConsReciCTe.GerarXML;

  FDadosMsg := ConsReciCTe.Gerador.ArquivoFormatoXML;
  ConsReciCTe.Free;
end;

procedure TWebServicesBase.DoCTeRecibo;
var
  ConsReciCTe: TConsReciCTe;
begin
  ConsReciCTe   := TConsReciCTe.Create;
  ConsReciCTe.schema := TsPL005c;
  ConsReciCTe.tpAmb  := TpcnTipoAmbiente(FConfiguracoes.WebServices.AmbienteCodigo-1);
  ConsReciCTe.nRec   := TCTeRecibo(Self).Recibo;
  ConsReciCTe.GerarXML;

  FDadosMsg := ConsReciCTe.Gerador.ArquivoFormatoXML;
  ConsReciCTe.Free;
end;

{ TWebServices }
constructor TWebServices.Create(AFCTe: TComponent);
begin
 inherited Create( AFCTe );
  FACBrCTe          := TACBrCTe(AFCTe);
  FStatusServico    := TCTeStatusServico.Create(AFCTe);
  FConsultaCadastro := TCTeConsultaCadastro.Create(AFCTe);
  FConsulta         := TCTeConsulta.Create(AFCTe);
  FCancelamento     := TCTeCancelamento.Create(AFCTe);
  FInutilizacao     := TCTeInutilizacao.Create(AFCTe);
  FEnviar           := TCTeRecepcao.Create(AFCTe, TACBrCTe(AFCTe).Conhecimentos);
  FRetorno          := TCTeRetRecepcao.Create(AFCTe, TACBrCTe(AFCTe).Conhecimentos);
  FRecibo           := TCTeRecibo.create(AFCTe);
end;

procedure TWebServices.Cancela(AJustificativa: String);
begin
  if not(Self.StatusServico.Executar) then
    raise Exception.Create(Self.StatusServico.Msg);

  if not(Self.Consulta.Executar) then
    raise Exception.Create(Self.Consulta.Msg);

  Self.Cancelamento.CTeChave      := Self.Consulta.CTeChave;
  Self.Cancelamento.Protocolo     := Self.Consulta.FProtocolo;
  Self.Cancelamento.Justificativa := AJustificativa;
  if not(Self.Cancelamento.Executar) then
    raise Exception.Create(Self.Cancelamento.Msg);
end;

procedure TWebServices.Inutiliza(CNPJ, AJustificativa: String; Ano, Modelo, Serie, NumeroInicial, NumeroFinal : Integer);
begin
  if not(Self.StatusServico.Executar) then
    raise Exception.Create('WebService Consulta Status serviço:'+LineBreak+
                               '- Inativo ou Inoperante tente novamente.'+LineBreak+
                               Self.StatusServico.Msg);

  Self.Inutilizacao.CTeChave  := 'ID';
  Self.Inutilizacao.CNPJ   := CNPJ;
  Self.Inutilizacao.Modelo := Modelo;
  Self.Inutilizacao.Serie  := Serie;
  Self.Inutilizacao.Ano    := Ano;
  Self.Inutilizacao.NumeroInicial := NumeroInicial;
  Self.Inutilizacao.NumeroFinal   := NumeroFinal;
  Self.Inutilizacao.Justificativa := AJustificativa;

  if not(Self.Inutilizacao.Executar) then
    raise Exception.Create(Self.Inutilizacao.Msg);
end;

function TWebServices.Envia(ALote: Integer): Boolean;
begin
  if not(Self.StatusServico.Executar) then
    raise Exception.Create(Self.StatusServico.Msg);

  self.Enviar.FLote := ALote;
  if not(Self.Enviar.Executar) then
    raise Exception.Create(Self.Enviar.Msg);

  Self.Retorno.Recibo := Self.Enviar.Recibo;

  if not(Self.Retorno.Executar) then
    raise Exception.Create(Self.Retorno.Msg);

  Result := true;
end;

destructor TWebServices.Destroy;
begin
  FStatusServico.Free;
  FConsultaCadastro.Free;
  FConsulta.Free;
  FCancelamento.Free;
  FInutilizacao.Free;
  FEnviar.Free;
  FRetorno.Free;
  FRecibo.Free;
  inherited;
end;

{ TCTeStatusServico }
function TCTeStatusServico.Executar: Boolean;
var
  CTeRetorno: TRetConsStatServ;
  Texto : String;
  Acao  : TStringList ;
  Stream: TMemoryStream;
  StrStream: TStringStream;

  {$IFDEF ACBrCTeOpenSSL}
     HTTP: THTTPSend;
  {$ELSE}
     ReqResp: THTTPReqResp;
  {$ENDIF}
begin
  Result := inherited Executar;

  Acao := TStringList.Create;
  Stream := TMemoryStream.Create;

  Texto := '<?xml version="1.0" encoding="utf-8"?>';
  Texto := Texto + '<soap12:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap12="http://www.w3.org/2003/05/soap-envelope">';
  Texto := Texto +   '<soap12:Header>';
  Texto := Texto +     '<cteCabecMsg xmlns="http://www.portalfiscal.inf.br/cte/wsdl/CteStatusServico">';
  Texto := Texto +       '<cUF>'+IntToStr(FConfiguracoes.WebServices.UFCodigo)+'</cUF>';
  Texto := Texto +       '<versaoDados>'+CTeconsStatServ+'</versaoDados>';
  Texto := Texto +     '</cteCabecMsg>';
  Texto := Texto +   '</soap12:Header>';
  Texto := Texto +   '<soap12:Body>';
  Texto := Texto +     '<cteDadosMsg xmlns="http://www.portalfiscal.inf.br/cte/wsdl/CteStatusServico">';
  Texto := Texto + FDadosMsg;
  Texto := Texto +     '</cteDadosMsg>';
  Texto := Texto +   '</soap12:Body>';
  Texto := Texto + '</soap12:Envelope>';

  Acao.Text := Texto;
  Acao.SaveToStream(Stream);

  {$IFDEF ACBrCTeOpenSSL}
     HTTP := THTTPSend.Create;
  {$ELSE}
     ReqResp := THTTPReqResp.Create(nil);
     ReqResp.OnBeforePost := OnBeforePost;
     ReqResp.URL := FURL;
     ReqResp.UseUTF8InHeader := True;
     ReqResp.SoapAction := 'http://www.portalfiscal.inf.br/cte/wsdl/CteStatusServico/cteStatusServicoCT';
  {$ENDIF}

  try
    TACBrCTe( FACBrCTe ).SetStatus( stCTeStatusServico );
    if FConfiguracoes.Geral.Salvar then
      FConfiguracoes.Geral.Save(FormatDateTime('yyyymmddhhnnss',Now)+'-ped-sta.xml', FDadosMsg);

    try
      {$IFDEF ACBrCTeOpenSSL}
         HTTP.Document.LoadFromStream(Stream);
         ConfiguraHTTP(HTTP,'SOAPAction: "http://www.portalfiscal.inf.br/cte/wsdl/CteStatusServico/cteStatusServicoCT"');
         HTTP.HTTPMethod('POST', FURL);
         StrStream := TStringStream.Create('');
         StrStream.CopyFrom(HTTP.Document, 0);
         FRetWS := CTeUtil.SeparaDados( NotaUtil.ParseText(StrStream.DataString, True),'cteStatusServicoCTResult');
         StrStream.Free;
      {$ELSE}
         ReqResp.Execute(Acao.Text, Stream);
         StrStream := TStringStream.Create('');
         StrStream.CopyFrom(Stream, 0);
         FRetWS := CTeUtil.SeparaDados( NotaUtil.ParseText(StrStream.DataString, True),'cteStatusServicoCTResult');
         StrStream.Free;
      {$ENDIF}
      CTeRetorno := TRetConsStatServ.Create;
      CTeRetorno.Leitor.Arquivo := FRetWS;
      CTeRetorno.LerXml;

      TACBrCTe( FACBrCTe ).SetStatus( stCTeIdle );
      if FConfiguracoes.WebServices.Visualizar then
      begin
          ShowMessage('Ambiente : '+TpAmbToStr(CTeRetorno.tpAmb)+LineBreak+
                      'Versão Aplicativo : '+CTeRetorno.verAplic+LineBreak+
                      'Status Código : '+IntToStr(CTeRetorno.cStat)+LineBreak+
                      'Status Descrição : '+CTeRetorno.xMotivo+LineBreak+
                      'UF : '+CodigoParaUF(CTeRetorno.cUF)+LineBreak+
                      'Recebimento : '+DateTimeToStr(CTeRetorno.dhRecbto)+LineBreak+
                      'Tempo Médio : '+IntToStr(CTeRetorno.TMed)+LineBreak+
                      'Retorno : '+DateTimeToStr(CTeRetorno.dhRetorno)+LineBreak+
                      'Observação : '+CTeRetorno.xObs);
      end;

      FtpAmb    := CTeRetorno.tpAmb;
      FverAplic := CTeRetorno.verAplic;
      FcStat    := CTeRetorno.cStat;
      FxMotivo  := CTeRetorno.xMotivo;
      FcUF      := CTeRetorno.cUF;
      FdhRecbto := CTeRetorno.dhRecbto;
      FTMed     := CTeRetorno.TMed;
      FdhRetorno:= CTeRetorno.dhRetorno;
      FxObs     := CTeRetorno.xObs;

      FMsg   := CTeRetorno.XMotivo+ LineBreak+CTeRetorno.XObs;
      Result := (CTeRetorno.CStat = 107);
      CTeRetorno.Free;

      if FConfiguracoes.Geral.Salvar then
        FConfiguracoes.Geral.Save(FormatDateTime('yyyymmddhhnnss',Now)+'-sta.xml', FRetWS);

    except on E: Exception do
      begin
        raise Exception.Create('WebService Consulta Status serviço:'+LineBreak+
                               '- Inativo ou Inoperante tente novamente.'+LineBreak+
                               '- '+E.Message);
      end;
    end;
  finally
    {$IFDEF ACBrCTeOpenSSL}
       HTTP.Free;
    {$ENDIF}
    Acao.Free;
    Stream.Free;
    NotaUtil.ConfAmbiente;
    TACBrCTe( FACBrCTe ).SetStatus( stCTeIdle );
  end;
end;

{ TCTeConsultaCadastro }
function TCTeConsultaCadastro.Executar: Boolean;
var
  Texto : String;
  Acao  : TStringList ;
  Stream: TMemoryStream;
  StrStream: TStringStream;

  {$IFDEF ACBrCTeOpenSSL}
     HTTP: THTTPSend;
  {$ELSE}
     ReqResp: THTTPReqResp;
  {$ENDIF}
begin
  Result := inherited Executar;

  Acao := TStringList.Create;
  Stream := TMemoryStream.Create;
  Texto := '<?xml version="1.0" encoding="utf-8"?>';
  Texto := Texto + '<soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">';
  Texto := Texto + '  <soap:Body>';
  Texto := Texto + '    <consultaCadastro xmlns="http://www.portalfiscal.inf.br/nfe/wsdl/CadConsultaCadastro">';
  Texto := Texto + '      <nfeCabecMsg>';

  Texto := Texto + NotaUtil.ParseText(FCabMsg,False);

  Texto := Texto + '      </nfeCabecMsg>';
  Texto := Texto + '      <nfeDadosMsg>';

  Texto := Texto + NotaUtil.ParseText(FDadosMsg,False);

  Texto := Texto + '      </nfeDadosMsg>';
  Texto := Texto + '    </consultaCadastro>';
  Texto := Texto + '  </soap:Body>';
  Texto := Texto + '</soap:Envelope>';

  Acao.Text := Texto;
  Acao.SaveToStream(Stream);


  {$IFDEF ACBrCTeOpenSSL}
     HTTP := THTTPSend.Create;
  {$ELSE}
     ReqResp := THTTPReqResp.Create(nil);
     ReqResp.OnBeforePost := OnBeforePost;
     ReqResp.URL := FURL;
     ReqResp.UseUTF8InHeader := True;
     ReqResp.SoapAction := 'http://www.portalfiscal.inf.br/nfe/wsdl/CadConsultaCadastro/consultaCadastro';
  {$ENDIF}
  try
    TACBrCTe( FACBrCTe ).SetStatus( stCTeCadastro );
    if FConfiguracoes.Geral.Salvar then
      FConfiguracoes.Geral.Save(FormatDateTime('yyyymmddhhnnss',Now)+'-ped-cad.xml', FDadosMsg);

    {$IFDEF ACBrCTeOpenSSL}
       HTTP.Document.LoadFromStream(Stream);
       ConfiguraHTTP(HTTP,'SOAPAction: "http://www.portalfiscal.inf.br/nfe/wsdl/CadConsultaCadastro/consultaCadastro"');
       HTTP.HTTPMethod('POST', FURL);

       StrStream := TStringStream.Create('');
       StrStream.CopyFrom(HTTP.Document, 0);
       FRetWS := CTeUtil.SeparaDados( NotaUtil.ParseText(StrStream.DataString, True),'consultaCadastroResult');
       StrStream.Free;
    {$ELSE}
       ReqResp.Execute(Acao.Text, Stream);
       StrStream := TStringStream.Create('');
       StrStream.CopyFrom(Stream, 0);
       FRetWS := CTeUtil.SeparaDados( NotaUtil.ParseText(StrStream.DataString, True),'consultaCadastroResult');
       StrStream.Free;
    {$ENDIF}

    if FRetConsCad = nil then
       FRetConsCad := TRetConsCad.Create;
    FRetConsCad.Leitor.Arquivo := FRetWS;
    FRetConsCad.LerXml;

    TACBrCTe( FACBrCTe ).SetStatus( stCTeIdle );
    if FConfiguracoes.WebServices.Visualizar then
    begin
        ShowMessage('Versão Aplicativo : '+FRetConsCad.verAplic+LineBreak+
                    'Status Código : '+IntToStr(FRetConsCad.cStat)+LineBreak+
                    'Status Descrição : '+FRetConsCad.xMotivo+LineBreak+
                    'UF : '+CodigoParaUF(FRetConsCad.cUF)+LineBreak+
                    'Consulta : '+DateTimeToStr(FRetConsCad.dhCons));
    end;
    FverAplic := FRetConsCad.verAplic;
    FcStat    := FRetConsCad.cStat;
    FxMotivo  := FRetConsCad.xMotivo;
    FdhCons   := FRetConsCad.dhCons;
    FcUF      := FRetConsCad.cUF ;

    if FRetConsCad.cStat = 111 then
     begin
       FUF   := FRetConsCad.UF ;
       FIE   := FRetConsCad.IE ;
       FCNPJ := FRetConsCad.CNPJ ;
       FCPF  := FRetConsCad.CPF ;
     end;

    FMsg      := FRetConsCad.XMotivo;

    if FConfiguracoes.Geral.Salvar then
      FConfiguracoes.Geral.Save(FormatDateTime('yyyymmddhhnnss',Now)+'-cad.xml', FRetWS);
  finally
    {$IFDEF ACBrCTeOpenSSL}
       HTTP.Free;
    {$ENDIF}
    Acao.Free;
    Stream.Free;
    NotaUtil.ConfAmbiente;
    TACBrCTe( FACBrCTe ).SetStatus( stCTeIdle );
  end;
end;

{ TCTeConsulta }
function TCTeConsulta.Executar: Boolean;
var
  CTeRetorno: TRetConsSitCTe;
  Texto : String;
  Acao  : TStringList ;
  Stream: TMemoryStream;
  StrStream: TStringStream;

  {$IFDEF ACBrCTeOpenSSL}
     HTTP: THTTPSend;
  {$ELSE}
     ReqResp: THTTPReqResp;
  {$ENDIF}
begin
  Result := inherited Executar;

  Acao := TStringList.Create;
  Stream := TMemoryStream.Create;

  Texto := '<?xml version="1.0" encoding="utf-8"?>';
  Texto := Texto + '<soap12:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap12="http://www.w3.org/2003/05/soap-envelope">';
  Texto := Texto +   '<soap12:Header>';
  Texto := Texto +     '<cteCabecMsg xmlns="http://www.portalfiscal.inf.br/cte/wsdl/CteConsulta">';
  Texto := Texto +       '<cUF>'+IntToStr(FConfiguracoes.WebServices.UFCodigo)+'</cUF>';
  Texto := Texto +       '<versaoDados>'+CTeconsSitCTe+'</versaoDados>';
  Texto := Texto +     '</cteCabecMsg>';
  Texto := Texto +   '</soap12:Header>';
  Texto := Texto +   '<soap12:Body>';
  Texto := Texto +     '<cteDadosMsg xmlns="http://www.portalfiscal.inf.br/cte/wsdl/CteConsulta">';
  Texto := Texto + FDadosMsg;
  Texto := Texto +     '</cteDadosMsg>';
  Texto := Texto +   '</soap12:Body>';
  Texto := Texto + '</soap12:Envelope>';

  Acao.Text := Texto;
  Acao.SaveToStream(Stream);
  {$IFDEF ACBrCTeOpenSSL}
     HTTP := THTTPSend.Create;
  {$ELSE}
     ReqResp := THTTPReqResp.Create(nil);
     ReqResp.OnBeforePost := OnBeforePost;
     ReqResp.URL := FURL;
     ReqResp.UseUTF8InHeader := True;
     ReqResp.SoapAction := 'http://www.portalfiscal.inf.br/cte/wsdl/CteConsulta/cteConsultaCT';
  {$ENDIF}
  try
    TACBrCTe( FACBrCTe ).SetStatus( stCTeConsulta );
    if FConfiguracoes.Geral.Salvar then
      FConfiguracoes.Geral.Save(FCTeChave+'-ped-sit.xml', FDadosMsg);

    {$IFDEF ACBrCTeOpenSSL}
       HTTP.Document.LoadFromStream(Stream);
       ConfiguraHTTP(HTTP,'SOAPAction: "http://www.portalfiscal.inf.br/cte/wsdl/CteConsulta/cteConsultaCT"');
       HTTP.HTTPMethod('POST', FURL);

       StrStream := TStringStream.Create('');
       StrStream.CopyFrom(HTTP.Document, 0);

       FRetWS := CTeUtil.SeparaDados( NotaUtil.ParseText(StrStream.DataString, True),'cteConsultaCTResult');
       StrStream.Free;
    {$ELSE}
       ReqResp.Execute(Acao.Text, Stream);
       StrStream := TStringStream.Create('');
       StrStream.CopyFrom(Stream, 0);
       FRetWS := CTeUtil.SeparaDados( NotaUtil.ParseText(StrStream.DataString, True),'cteConsultaCTResult');
       StrStream.Free;
    {$ENDIF}
    CTeRetorno := TRetConsSitCTe.Create;
    CTeRetorno.Leitor.Arquivo := FRetWS;
    CTeRetorno.LerXML;
    FProtocolo := CTeRetorno.protCTe;

    TACBrCTe( FACBrCTe ).SetStatus( stCTeIdle );
    if FConfiguracoes.WebServices.Visualizar then
    begin
        ShowMessage(  'Ambiente : '+TpAmbToStr(CTeRetorno.TpAmb)+LineBreak+
                      'Versão Aplicativo : '+CTeRetorno.verAplic+LineBreak+
                      'Status Código : '+IntToStr(CTeRetorno.CStat)+LineBreak+
                      'Status Descrição : '+CTeRetorno.xMotivo+LineBreak+
                      'UF : '+CodigoParaUF(CTeRetorno.cUF)+LineBreak+
                      'Protocolo : '+CTeRetorno.protCTe+LineBreak+
                      'Prot. Cancelamento : '+CTeRetorno.retCancCTe+LineBreak);
    end;
    FTpAmb    := CTeRetorno.TpAmb;
    FverAplic := CTeRetorno.verAplic;
    FcStat    := CTeRetorno.cStat;
    FcUF      := CTeRetorno.cUF;
    FxMotivo  := CTeRetorno.xMotivo;

    FMsg   := CTeRetorno.XMotivo;
    Result := (CTeRetorno.CStat in [100,101,110]);
    CTeRetorno.Free;

    if FConfiguracoes.Geral.Salvar then
      FConfiguracoes.Geral.Save(FCTeChave+'-sit.xml', FRetWS);
  finally
    {$IFDEF ACBrCTeOpenSSL}
       HTTP.Free;
    {$ENDIF}
    Acao.Free;
    Stream.Free;
    NotaUtil.ConfAmbiente;
    TACBrCTe( FACBrCTe ).SetStatus( stCTeIdle );
  end;
end;

{ TCTeCancelamento }
function TCTeCancelamento.Executar: Boolean;
var
  CTeRetorno: TRetCancCTe;

  Texto : String;
  Acao  : TStringList ;
  Stream: TMemoryStream;
  StrStream: TStringStream;
  {$IFDEF ACBrCTeOpenSSL}
     HTTP: THTTPSend;
  {$ELSE}
     ReqResp: THTTPReqResp;
  {$ENDIF}
begin
  Result := inherited Executar;

  Acao := TStringList.Create;
  Stream := TMemoryStream.Create;

  Texto := '<?xml version="1.0" encoding="utf-8"?>';
  Texto := Texto + '<soap12:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap12="http://www.w3.org/2003/05/soap-envelope">';
  Texto := Texto +   '<soap12:Header>';
  Texto := Texto +     '<cteCabecMsg xmlns="http://www.portalfiscal.inf.br/cte/wsdl/CteCancelamento">';
  Texto := Texto +       '<cUF>'+IntToStr(FConfiguracoes.WebServices.UFCodigo)+'</cUF>';
  Texto := Texto +       '<versaoDados>'+CTecancCTe+'</versaoDados>';
  Texto := Texto +     '</cteCabecMsg>';
  Texto := Texto +   '</soap12:Header>';
  Texto := Texto +   '<soap12:Body>';
  Texto := Texto +     '<cteDadosMsg xmlns="http://www.portalfiscal.inf.br/cte/wsdl/CteCancelamento">';
  Texto := Texto + FDadosMsg;
  Texto := Texto +     '</cteDadosMsg>';
  Texto := Texto +   '</soap12:Body>';
  Texto := Texto + '</soap12:Envelope>';

  Acao.Text := Texto;
  Acao.SaveToStream(Stream);
  {$IFDEF ACBrCTeOpenSSL}
     HTTP := THTTPSend.Create;
  {$ELSE}
     ReqResp := THTTPReqResp.Create(nil);
     ReqResp.OnBeforePost := OnBeforePost;
     ReqResp.URL := FURL;
     ReqResp.UseUTF8InHeader := True;
     ReqResp.SoapAction := 'http://www.portalfiscal.inf.br/cte/wsdl/CteCancelamento/cteCancelamentoCT';
  {$ENDIF}
  try
    TACBrCTe( FACBrCTe ).SetStatus( stCTeCancelamento );
    if FConfiguracoes.Geral.Salvar then
      FConfiguracoes.Geral.Save(FCTeChave+'-ped-can.xml', FDadosMsg);

    {$IFDEF ACBrCTeOpenSSL}
       HTTP.Document.LoadFromStream(Stream);
       ConfiguraHTTP(HTTP,'SOAPAction: "http://www.portalfiscal.inf.br/cte/wsdl/CteCancelamento/cteCancelamentoCT"');
       HTTP.HTTPMethod('POST', FURL);

       StrStream := TStringStream.Create('');
       StrStream.CopyFrom(HTTP.Document, 0);
       FRetWS := CTeUtil.SeparaDados( NotaUtil.ParseText(StrStream.DataString, True),'cteCancelamentoCTResult');
       StrStream.Free;
    {$ELSE}
       ReqResp.Execute(Acao.Text, Stream);
       StrStream := TStringStream.Create('');
       StrStream.CopyFrom(Stream, 0);
       FRetWS := CTeUtil.SeparaDados( NotaUtil.ParseText(StrStream.DataString, True),'cteCancelamentoCTResult');
       StrStream.Free;
    {$ENDIF}

    CTeRetorno := TRetCancCTe.Create;
    CTeRetorno.Leitor.Arquivo := FRetWS;
    CTeRetorno.LerXml;

    TACBrCTe( FACBrCTe ).SetStatus( stCTeIdle );
    if FConfiguracoes.WebServices.Visualizar then
    begin
        ShowMessage('Identificador : '+ CTeRetorno.chCTe+LineBreak+
                  'Ambiente : '+TpAmbToStr(CTeRetorno.TpAmb)+LineBreak+
                  'Versão Aplicativo : '+CTeRetorno.verAplic+LineBreak+
                  'Status Código : '+IntToStr(CTeRetorno.cStat)+LineBreak+
                  'Status Descrição : '+CTeRetorno.xMotivo+LineBreak+
                  'UF : '+CodigoParaUF(CTeRetorno.cUF)+LineBreak+
                  'Chave Acesso : '+CTeRetorno.chCTe+LineBreak+
                  'Recebimento : '+DateTimeToStr(CTeRetorno.DhRecbto)+LineBreak+
                  'Protocolo : '+CTeRetorno.nProt+LineBreak);
    end;

    FTpAmb    := CTeRetorno.TpAmb;
    FverAplic := CTeRetorno.verAplic;
    FcStat    := CTeRetorno.cStat;
    FxMotivo  := CTeRetorno.xMotivo;
    FcUF      := CTeRetorno.cUF;
    FDhRecbto := CTeRetorno.dhRecbto;
    Fprotocolo:= CTeRetorno.nProt;

    FMsg   := CTeRetorno.XMotivo;
    Result := (CTeRetorno.CStat = 101);
    CTeRetorno.Free;

    if FConfiguracoes.Geral.Salvar then
      FConfiguracoes.Geral.Save(FCTeChave+'-can.xml', FRetWS);
  finally
    {$IFDEF ACBrCTeOpenSSL}
       HTTP.Free;
    {$ENDIF}
    Acao.Free;
    Stream.Free;
    NotaUtil.ConfAmbiente;
    TACBrCTe( FACBrCTe ).SetStatus( stCTeIdle );
  end;
end;

procedure TCTeCancelamento.SetJustificativa(AValue: WideString);
begin
  if NotaUtil.EstaVazio(AValue) then
    raise Exception.Create('Informar uma Justificativa para cancelar o Conhecimento')
  else
    AValue := NotaUtil.TrataString(AValue);

  if Length(AValue) < 15 then
    FJustificativa := NotaUtil.PadE(AValue, 15,'-')
  else
    FJustificativa := AValue;
end;

{ TCTeInutilizacao }
function TCTeInutilizacao.Executar: Boolean;
var
  CTeRetorno: TRetInutCTe;
  Texto : String;
  Acao  : TStringList ;
  Stream: TMemoryStream;
  StrStream: TStringStream;
  {$IFDEF ACBrCTeOpenSSL}
     HTTP: THTTPSend;
  {$ELSE}
     ReqResp: THTTPReqResp;
  {$ENDIF}
begin
  Result := inherited Executar;

  Acao := TStringList.Create;
  Stream := TMemoryStream.Create;
  Texto := '<?xml version="1.0" encoding="utf-8"?>';
  Texto := Texto + '<soap12:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap12="http://www.w3.org/2003/05/soap-envelope">';
  Texto := Texto + '<soap12:Header>';
  Texto := Texto + '<cteCabecMsg xmlns="http://www.portalfiscal.inf.br/cte/wsdl/CteInutilizacao">';
  Texto := Texto + '<cUF>'+IntToStr(FConfiguracoes.WebServices.UFCodigo)+'</cUF>';
  Texto := Texto + '<versaoDados>'+CTeinutCTe+'</versaoDados>';
  Texto := Texto + '</cteCabecMsg>';
  Texto := Texto + '</soap12:Header>';
  Texto := Texto + '<soap12:Body>';
  Texto := Texto + '<cteDadosMsg xmlns="http://www.portalfiscal.inf.br/cte/wsdl/CteInutilizacao">';
  Texto := Texto + FDadosMsg;
  Texto := Texto + '</cteDadosMsg>';
  Texto := Texto + '</soap12:Body>';
  Texto := Texto + '</soap12:Envelope>';

  Acao.Text := Texto;
  Acao.SaveToStream(Stream);

  {$IFDEF ACBrCTeOpenSSL}
     HTTP := THTTPSend.Create;
  {$ELSE}
     ReqResp := THTTPReqResp.Create(nil);
     ReqResp.OnBeforePost := OnBeforePost;
     ReqResp.URL := FURL;
     ReqResp.UseUTF8InHeader := True;
     ReqResp.SoapAction := 'http://www.portalfiscal.inf.br/cte/wsdl/CteInutilizacao/cteInutilizacaoCT';
  {$ENDIF}
  try
    TACBrCTe( FACBrCTe ).SetStatus( stCTeInutilizacao );
    if FConfiguracoes.Geral.Salvar then
      FConfiguracoes.Geral.Save(FormatDateTime('yyyymmddhhnnss',Now)+FCTeChave+'-ped-inu.xml', FDadosMsg);

    {$IFDEF ACBrCTeOpenSSL}
       HTTP.Document.LoadFromStream(Stream);
       ConfiguraHTTP(HTTP,'SOAPAction: "http://www.portalfiscal.inf.br/cte/wsdl/CteInutilizacao/cteInutilizacaoCT"');
       HTTP.HTTPMethod('POST', FURL);

       StrStream := TStringStream.Create('');
       StrStream.CopyFrom(HTTP.Document, 0);
       FRetWS := CTeUtil.SeparaDados( NotaUtil.ParseText(StrStream.DataString, True),'cteInutilizacaoCTResult');
       StrStream.Free;
    {$ELSE}
       ReqResp.Execute(Acao.Text, Stream);
       StrStream := TStringStream.Create('');
       StrStream.CopyFrom(Stream, 0);
       FRetWS := CTeUtil.SeparaDados( NotaUtil.ParseText(StrStream.DataString, True),'cteInutilizacaoCTResult');
       StrStream.Free;
    {$ENDIF}

    CTeRetorno := TRetInutCTe.Create;
    CTeRetorno.Leitor.Arquivo := FRetWS;
    CTeRetorno.LerXml;

    TACBrCTe( FACBrCTe ).SetStatus( stCTeIdle );
    if FConfiguracoes.WebServices.Visualizar then
    begin
        ShowMessage('Ambiente : '+TpAmbToStr(CTeRetorno.TpAmb)+LineBreak+
                   'Versão Aplicativo : '+CTeRetorno.verAplic+LineBreak+
                   'Status Código : '+IntToStr(CTeRetorno.cStat)+LineBreak+
                   'Status Descrição : '+CTeRetorno.xMotivo+LineBreak+
                   'UF : '+CodigoParaUF(CTeRetorno.cUF)+LineBreak+
                   'Recebimento : '+DateTimeToStr(CTeRetorno.dhRecbto));
    end;

    FTpAmb    := CTeRetorno.TpAmb;
    FverAplic := CTeRetorno.verAplic;
    FcStat    := CTeRetorno.cStat;
    FxMotivo  := CTeRetorno.xMotivo;
    FcUF      := CTeRetorno.cUF ;
    FdhRecbto := CTeRetorno.dhRecbto;
    Fprotocolo:= CTeRetorno.nProt;
    FMsg   := CTeRetorno.XMotivo;
    Result := (CTeRetorno.cStat = 102);
    CTeRetorno.Free;

    if FConfiguracoes.Geral.Salvar then
      FConfiguracoes.Geral.Save(FormatDateTime('yyyymmddhhnnss',Now)+FCTeChave+'-inu.xml', FRetWS);
  finally
    {$IFDEF ACBrCTeOpenSSL}
       HTTP.Free;
    {$ENDIF}
    Acao.Free;
    Stream.Free;
    NotaUtil.ConfAmbiente;
    TACBrCTe( FACBrCTe ).SetStatus( stCTeIdle );
  end;
end;

procedure TCTeInutilizacao.SetJustificativa(AValue: WideString);
begin
  if NotaUtil.EstaVazio(AValue) then
    raise Exception.Create('Informar uma Justificativa para Inutilização de numeração do Conhecimento')
  else
    AValue := NotaUtil.TrataString(AValue);

  if Length(Trim(AValue)) < 15 then
   raise Exception.Create('A Justificativa para Inutilização de numeração do Conhecimento deve ter no minimo 15 caracteres')
  else
    FJustificativa := Trim(AValue);
end;

constructor TCTeRecepcao.Create(AOwner: TComponent; ACTes: TConhecimentos);
begin
  inherited Create(AOwner);
  FCTes := ACTes;
end;

function TCTeRecepcao.Executar: Boolean;
var
  CTeRetorno: TretEnvCTe;
  Texto : WideString;
  Acao  : TStringList ;
  Stream: TMemoryStream;
  StrStream: TStringStream;
  {$IFDEF ACBrCTeOpenSSL}
     HTTP: THTTPSend;
  {$ELSE}
     ReqResp: THTTPReqResp;
  {$ENDIF}
begin
  Result := inherited Executar;
  Acao := TStringList.Create;
  Stream := TMemoryStream.Create;

  Texto := '<?xml version="1.0" encoding="utf-8"?>';
  Texto := Texto + '<soap12:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap12="http://www.w3.org/2003/05/soap-envelope">';
  Texto := Texto +   '<soap12:Header>';
  Texto := Texto +     '<cteCabecMsg xmlns="http://www.portalfiscal.inf.br/cte/wsdl/CteRecepcao">';
  Texto := Texto +       '<cUF>'+IntToStr(FConfiguracoes.WebServices.UFCodigo)+'</cUF>';
  Texto := Texto +       '<versaoDados>'+CTeenvCte+'</versaoDados>';
  Texto := Texto +     '</cteCabecMsg>';
  Texto := Texto +   '</soap12:Header>';
  Texto := Texto +   '<soap12:Body>';
  Texto := Texto +     '<cteDadosMsg xmlns="http://www.portalfiscal.inf.br/cte/wsdl/CteRecepcao">';
  Texto := Texto + FDadosMsg;
  Texto := Texto +     '</cteDadosMsg>';
  Texto := Texto +   '</soap12:Body>';
  Texto := Texto + '</soap12:Envelope>';

  Acao.Text := Texto;
  Acao.SaveToStream(Stream);
  {$IFDEF ACBrCTeOpenSSL}
     HTTP := THTTPSend.Create;
  {$ELSE}
     ReqResp := THTTPReqResp.Create(nil);
     ReqResp.OnBeforePost := OnBeforePost;
     ReqResp.URL := FURL;
     ReqResp.UseUTF8InHeader := True;
     ReqResp.SoapAction := 'http://www.portalfiscal.inf.br/cte/wsdl/CteRecepcao/cteRecepcaoLote';
  {$ENDIF}

  try
    TACBrCTe( FACBrCTe ).SetStatus( stCTeRecepcao );
    if FConfiguracoes.Geral.Salvar then
      FConfiguracoes.Geral.Save(FormatDateTime('yyyymmddhhnnss',Now)+'-env-lot.xml', FDadosMsg);

    try
      {$IFDEF ACBrCTeOpenSSL}
         HTTP.Document.LoadFromStream(Stream);
         ConfiguraHTTP(HTTP,'SOAPAction: "http://www.portalfiscal.inf.br/cte/wsdl/CteRecepcao/cteRecepcaoLote"');
         HTTP.HTTPMethod('POST', FURL);
         StrStream := TStringStream.Create('');
         StrStream.CopyFrom(HTTP.Document, 0);
         FRetWS := CTeUtil.SeparaDados( NotaUtil.ParseText(StrStream.DataString, True),'cteRecepcaoLoteResult');
         StrStream.Free;
      {$ELSE}
         ReqResp.Execute(Acao.Text, Stream);
         StrStream := TStringStream.Create('');
         StrStream.CopyFrom(Stream, 0);
         FRetWS := CTeUtil.SeparaDados( NotaUtil.ParseText(StrStream.DataString, True),'cteRecepcaoLoteResult');
         StrStream.Free;
      {$ENDIF}
      CTeRetorno := TretEnvCTe.Create;
      CTeRetorno.Leitor.Arquivo := FRetWS;
      CTeRetorno.LerXml;

      TACBrCTe( FACBrCTe ).SetStatus( stCTeIdle );
      if FConfiguracoes.WebServices.Visualizar then
      begin
          ShowMessage('Ambiente : '+TpAmbToStr(CTeRetorno.tpAmb)+LineBreak+
                      'Versão Aplicativo : '+CTeRetorno.verAplic+LineBreak+
                      'Status Código : '+IntToStr(CTeRetorno.cStat)+LineBreak+
                      'Status Descrição : '+CTeRetorno.xMotivo+LineBreak+
                      'UF : '+CodigoParaUF(CTeRetorno.cUF)+LineBreak+
                      'Recebimento : '+DateTimeToStr(CTeRetorno.infRec.dhRecbto)+LineBreak+
                      'Tempo Médio : '+IntToStr(CTeRetorno.infRec.tMed)+LineBreak+
                      'Número Recibo: '+CTeRetorno.infRec.nRec);
      end;

      FtpAmb    := CTeRetorno.tpAmb;
      FverAplic := CTeRetorno.verAplic;
      FcStat    := CTeRetorno.cStat;
      FxMotivo  := CTeRetorno.xMotivo;
      FcUF      := CTeRetorno.cUF;
      FdhRecbto := CTeRetorno.infRec.dhRecbto;
      FTMed     := CTeRetorno.infRec.tMed;
      FRecibo   := CTeRetorno.infRec.nRec;

      FMsg   := CTeRetorno.XMotivo;
      Result := (CTeRetorno.CStat = 103);
      CTeRetorno.Free;

    if FConfiguracoes.Geral.Salvar then
      FConfiguracoes.Geral.Save(IntToStr(Lote)+'-rec.xml', FRetWS);

    except on E: Exception do
      begin
        raise Exception.Create('WebService Retorno de Recepção:'+LineBreak+
                               '- Inativo ou Inoperante tente novamente.'+LineBreak+
                               '- '+E.Message);
      end;
    end;

  finally
    {$IFDEF ACBrCTeOpenSSL}
       HTTP.Free;
    {$ENDIF}
    Acao.Free;
    Stream.Free;
    NotaUtil.ConfAmbiente;
    TACBrCTe( FACBrCTe ).SetStatus( stCTeIdle );
  end;
end;
{ TCteRetRecepcao }

function TCteRetRecepcao.Confirma(AInfProt: TProtCteCollection): Boolean;
var
  i,j : Integer;
  AProcCTe: TProcCte;
begin
  Result := False;

  //Setando os retornos dos conhecimentos;
  for i:= 0 to AInfProt.Count-1 do
  begin
    for j:= 0 to FCTes.Count-1 do
    begin
      if 'CTe'+AInfProt.Items[i].chCTe = FCTes.Items[j].CTe.InfCTe.Id  then
//      if AInfProt.Items[i].chCTe = FCTes.Items[j].CTe.InfCTe.Id  then
      begin
        FCTes.Items[j].Confirmada := (AInfProt.Items[i].cStat = 100);
        FCTes.Items[j].Msg        := AInfProt.Items[i].xMotivo;
        AProcCTe:=TProcCTe.Create;
        AProcCTe.PathCTe:=FConfiguracoes.Geral.PathSalvar+'\'+FCTeRetorno.ProtCTe.Items[j].chCTe+'-CTe.xml';
        AProcCTe.PathRetConsReciCTe:=FConfiguracoes.Geral.PathSalvar+'\'+FCTeRetorno.nRec+'-pro-rec.xml';
        AProcCTe.GerarXML;
        AProcCTe.Gerador.SalvarArquivo(FConfiguracoes.Geral.PathSalvar+'\'+FCTeRetorno.ProtCTe.Items[j].chCTe+'-CTe.xml');
        FCTes.Items[j].XML := AProcCTe.Gerador.ArquivoFormatoXML;
        AProcCTe.Free;
        break;
      end;
    end;
  end;

  //Verificando se existe algum Conhecimento confirmada
  for i:= 0 to FCTes.Count-1 do
  begin
    if FCTes.Items[i].Confirmada then
    begin
      Result := True;
      break;
    end;
  end;

  //Verificando se existe algum Conhecimento nao confirmada
  for i:= 0 to FCTes.Count-1 do
  begin
    if not(FCTes.Items[i].Confirmada) then
    begin
      FMsg   := 'Conhecimento(s) não confirmado(s):'+LineBreak;
      break;
    end;
  end;

  //Montando a mensagem de retorno para os Conhecimento nao confirmadas
  for i:= 0 to FCTes.Count-1 do
  begin
    if not(FCTes.Items[i].Confirmada) then
      FMsg:= FMsg+IntToStr(FCTes.Items[i].CTe.Ide.nCT)+'->'+FCTes.Items[i].Msg+LineBreak;
  end;
end;

constructor TCteRetRecepcao.Create(AOwner: TComponent;
  AConhecimentos: TConhecimentos);
begin
  inherited Create(AOwner);
  FCTes := AConhecimentos;
end;

destructor TCteRetRecepcao.destroy;
begin
   if assigned(FCteRetorno) then
      FCteRetorno.Free;
   inherited;
end;

function TCteRetRecepcao.Executar: Boolean;
  function Processando: Boolean;
  var
    Texto : String;
    Acao  : TStringList ;
    Stream: TMemoryStream;
    StrStream: TStringStream;
    {$IFDEF ACBrCTeOpenSSL}
       HTTP: THTTPSend;
    {$ELSE}
       ReqResp: THTTPReqResp;
       //Conhecimento: CteRetRecepcao;
    {$ENDIF}
  begin
    Acao := TStringList.Create;
    Stream := TMemoryStream.Create;

    Texto := '<?xml version="1.0" encoding="utf-8"?>';
    Texto := Texto + '<soap12:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap12="http://www.w3.org/2003/05/soap-envelope">';
    Texto := Texto +   '<soap12:Header>';
    Texto := Texto +     '<cteCabecMsg xmlns="http://www.portalfiscal.inf.br/cte/wsdl/CteRetRecepcao">';
    Texto := Texto +       '<cUF>'+IntToStr(FConfiguracoes.WebServices.UFCodigo)+'</cUF>';
    Texto := Texto +       '<versaoDados>'+CTeconsReciCTe+'</versaoDados>';
    Texto := Texto +     '</cteCabecMsg>';
    Texto := Texto +   '</soap12:Header>';
    Texto := Texto +   '<soap12:Body>';
    Texto := Texto +     '<cteDadosMsg xmlns="http://www.portalfiscal.inf.br/cte/wsdl/CteRetRecepcao">';
    Texto := Texto + FDadosMsg;
    Texto := Texto +     '</cteDadosMsg>';
    Texto := Texto +   '</soap12:Body>';
    Texto := Texto + '</soap12:Envelope>';

    Acao.Text := Texto;
    Acao.SaveToStream(Stream);

    {$IFDEF ACBrCTeOpenSSL}
       HTTP := THTTPSend.Create;
    {$ELSE}
       ReqResp := THTTPReqResp.Create(nil);
       ReqResp.OnBeforePost := OnBeforePost;
       ReqResp.URL := FURL;
       ReqResp.UseUTF8InHeader := True;
       ReqResp.SoapAction := 'http://www.portalfiscal.inf.br/cte/wsdl/CteRetRecepcao/cteRetRecepcao';
    {$ENDIF}
    try
      TACBrCTe( FACBrCTe ).SetStatus( stCTeRetRecepcao );
      if FConfiguracoes.Geral.Salvar then
        FConfiguracoes.Geral.Save(Recibo+'-ped-rec.xml', FDadosMsg);

      {$IFDEF ACBrCTeOpenSSL}
         HTTP.Document.LoadFromStream(Stream);
         ConfiguraHTTP(HTTP,'SOAPAction: "http://www.portalfiscal.inf.br/cte/wsdl/CteRetRecepcao/cteRetRecepcao"');
         HTTP.HTTPMethod('POST', FURL);

         StrStream := TStringStream.Create('');
         StrStream.CopyFrom(HTTP.Document, 0);

         FRetWS := CTeUtil.SeparaDados( NotaUtil.ParseText(StrStream.DataString, True),'cteRetRecepcaoResult');
         StrStream.Free;
      {$ELSE}
         ReqResp.Execute(Acao.Text, Stream);
         StrStream := TStringStream.Create('');
         StrStream.CopyFrom(Stream, 0);
         FRetWS := CTeUtil.SeparaDados( NotaUtil.ParseText(StrStream.DataString, True),'cteRetRecepcaoResult');

         StrStream.Free;
      {$ENDIF}
      if assigned(FCteRetorno) then
         FCteRetorno.Free;

      if FConfiguracoes.Geral.Salvar then
         FConfiguracoes.Geral.Save(Recibo+'-pro-rec.xml', FRetWS);

      FCteRetorno := TRetConsReciCTe.Create;
      FCteRetorno.Leitor.Arquivo := FRetWS;
      FCteRetorno.LerXML;

      TACBrCTe( FACBrCTe ).SetStatus( stCTeIdle );
      if FConfiguracoes.WebServices.Visualizar then
      begin
          ShowMessage('Ambiente : '+TpAmbToStr(FCTeRetorno.TpAmb)+LineBreak+
                      'Versão Aplicativo : '+FCTeRetorno.verAplic+LineBreak+
                      'Recibo : '+FCTeRetorno.nRec+LineBreak+
                      'Status Código : '+IntToStr(FCTeRetorno.cStat)+LineBreak+
                      'Status Descrição : '+FCTeRetorno.xMotivo+LineBreak+
                      'UF : '+CodigoParaUF(FCTeRetorno.cUF)+LineBreak);
      end;

      FTpAmb    := FCTeRetorno.TpAmb;
      FverAplic := FCTeRetorno.verAplic;
      FcStat    := FCTeRetorno.cStat;
      FcUF      := FCTeRetorno.cUF;
      FMsg      := FCTeRetorno.xMotivo;
      FxMotivo  := FCTeRetorno.xMotivo;

      Result := FCTeRetorno.CStat = 105;
      if FCTeRetorno.CStat = 104 then
      begin
         FMsg   := FCTeRetorno.ProtCTe.Items[0].xMotivo;
         FxMotivo  := FCTeRetorno.ProtCte.Items[0].xMotivo;
      end;

    finally
      {$IFDEF ACBrCTeOpenSSL}
         HTTP.Free;
      {$ENDIF}
      Acao.Free;
      Stream.Free;
      NotaUtil.ConfAmbiente;
      TACBrCTe( FACBrCTe ).SetStatus( stCTeIdle );
    end;
  end;

var
  vCont: Integer;
begin
  Result := inherited Executar;
  Result := False;

  vCont := 1000;
  while Processando do
  begin
    sleep(vCont);
    if vCont > 5000 then
      break;
    vCont := vCont +1000;
  end;

  if FCTeRetorno.CStat = 104 then
  begin
    Result := Confirma(FCTeRetorno.ProtCTe);

    FChaveCte  := FCTeRetorno.ProtCTe.Items[0].chCTe;
    fProtocolo := FCTeRetorno.ProtCTe.Items[0].nProt;
    fcStat     := FCTeRetorno.ProtCTe.Items[0].cStat;
  end;

//  FCTeRetorno.Free;
end;

{ TCteRecibo }

constructor TCteRecibo.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
end;

destructor TCteRecibo.destroy;
begin
   if assigned(FCTeRetorno) then
      FCTeRetorno.Free;
  inherited;
end;

function TCteRecibo.Executar: Boolean;
var
 Texto : String;
 Acao  : TStringList ;
 Stream: TMemoryStream;
 StrStream: TStringStream;
 MotivoAux : String;

 {$IFDEF ACBrCTeOpenSSL}
    HTTP: THTTPSend;
 {$ELSE}
    ReqResp: THTTPReqResp;
 {$ENDIF}
begin
   Result := inherited Executar;
   Acao := TStringList.Create;
   Stream := TMemoryStream.Create;

   Texto := '<?xml version="1.0" encoding="utf-8"?>';
   Texto := Texto + '<soap12:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap12="http://www.w3.org/2003/05/soap-envelope">';
   Texto := Texto +   '<soap12:Header>';
   Texto := Texto +     '<cteCabecMsg xmlns="http://www.portalfiscal.inf.br/cte/wsdl/CteRetRecepcao">';
   Texto := Texto +       '<cUF>'+IntToStr(FConfiguracoes.WebServices.UFCodigo)+'</cUF>';
   Texto := Texto +       '<versaoDados>'+CTeconsReciCTe+'</versaoDados>';
   Texto := Texto +     '</cteCabecMsg>';
   Texto := Texto +   '</soap12:Header>';
   Texto := Texto +   '<soap12:Body>';
   Texto := Texto +     '<cteDadosMsg xmlns="http://www.portalfiscal.inf.br/cte/wsdl/CteRetRecepcao">';
   Texto := Texto + FDadosMsg;
   Texto := Texto +     '</cteDadosMsg>';
   Texto := Texto +   '</soap12:Body>';
   Texto := Texto + '</soap12:Envelope>';

   Acao.Text := Texto;
   Acao.SaveToStream(Stream);

 {$IFDEF ACBrCTeOpenSSL}
    HTTP := THTTPSend.Create;
 {$ELSE}
       ReqResp := THTTPReqResp.Create(nil);
       ReqResp.OnBeforePost := OnBeforePost;
       ReqResp.URL := FURL;
       ReqResp.UseUTF8InHeader := True;
       ReqResp.SoapAction := 'http://www.portalfiscal.inf.br/cte/wsdl/CteRetRecepcao/cteRetRecepcao';
 {$ENDIF}
 try
   TACBrCTe( FACBrCTe ).SetStatus( stCTeRetRecepcao );
   if FConfiguracoes.Geral.Salvar then
     FConfiguracoes.Geral.Save(Recibo+'-ped-rec.xml', FDadosMsg);

   {$IFDEF ACBrCTeOpenSSL}
      HTTP.Document.LoadFromStream(Stream);
      ConfiguraHTTP(HTTP,'SOAPAction: "http://www.portalfiscal.inf.br/cte/wsdl/CteRetRecepcao/cteRetRecepcao"');
      HTTP.HTTPMethod('POST', FURL);

      StrStream := TStringStream.Create('');
      StrStream.CopyFrom(HTTP.Document, 0);

      FRetWS := CTeUtil.SeparaDados( NotaUtil.ParseText(StrStream.DataString, True),'cteRetRecepcaoResult');
      StrStream.Free;
   {$ELSE}
      ReqResp.Execute(Acao.Text, Stream);
      StrStream := TStringStream.Create('');
      StrStream.CopyFrom(Stream, 0);
      FRetWS := CTeUtil.SeparaDados( NotaUtil.ParseText(StrStream.DataString, True),'cteRetRecepcaoResult');
      StrStream.Free;
   {$ENDIF}
   if assigned(FCTeRetorno) then
      FCTeRetorno.Free;
   FCTeRetorno := TRetConsReciCTe.Create;
   FCTeRetorno.Leitor.Arquivo := FRetWS;
   FCTeRetorno.LerXML;

   TACBrCTe( FACBrCTe ).SetStatus( stCTeIdle );
   if FCTeRetorno.ProtCTe.Count > 0 then
     MotivoAux := FCTeRetorno.ProtCTe.Items[0].xMotivo
   else
     MotivoAux := '';

   if FConfiguracoes.WebServices.Visualizar then
   begin
      ShowMessage('Ambiente : '+TpAmbToStr(FCTeRetorno.TpAmb)+LineBreak+
                  'Versão Aplicativo : '+FCTeRetorno.verAplic+LineBreak+
                  'Recibo : '+FCTeRetorno.nRec+LineBreak+
                  'Status Código : '+IntToStr(FCTeRetorno.cStat)+LineBreak+
                  'Status Descrição : '+MotivoAux+LineBreak+
                  'UF : '+CodigoParaUF(FCTeRetorno.cUF)+LineBreak);
   end;

   FTpAmb    := FCTeRetorno.TpAmb;
   FverAplic := FCTeRetorno.verAplic;
   FcStat    := FCTeRetorno.cStat;
   FxMotivo  := MotivoAux;
   FcUF      := FCTeRetorno.cUF;

   Result := FCTeRetorno.CStat = 105;
   FMsg   := MotivoAux;

 finally
   {$IFDEF ACBrCTeOpenSSL}
      HTTP.Free;
   {$ENDIF}
   Acao.Free;
   Stream.Free;
   NotaUtil.ConfAmbiente;
   TACBrCTe( FACBrCTe ).SetStatus( stCTeIdle );
 end;
end;

end.
