{******************************************************************************}
{ Projeto: Componente ACBrNFe                                                  }
{  Biblioteca multiplataforma de componentes Delphi para emissão de Nota Fiscal}
{ eletrônica - NFe - http://www.nfe.fazenda.gov.br                          }
{                                                                              }
{ Direitos Autorais Reservados (c) 2008 Wemerson Souto                         }
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
{******************************************************************************}

{******************************************************************************
|* Historico
|*
|* 16/12/2008: Wemerson Souto
|*  - Doação do componente para o Projeto ACBr
******************************************************************************}
{$I ACBr.inc}

unit ACBrNFeWebServices;

interface

uses Classes, SysUtils,
  {$IFDEF VCL} Dialogs, {$ELSE} QDialogs, {$ENDIF}
  {$IFDEF ACBrNFeOpenSSL}
    HTTPSend,
  {$ELSE}
     SoapHTTPClient, SOAPHTTPTrans, WinInet, ACBrNFeCAPICOM_TLB,
  {$ENDIF}
  pcnNFe, pcnNFeW,
  pcnRetConsReciNFe, pcnRetConsCad, pcnAuxiliar, pcnConversao,
  ACBrNFeNotasFiscais,
  ACBrNFeConfiguracoes ;

type

  TWebServicesBase = Class
  private
    procedure DoNFeStatusServico;
    procedure DoNFeRecepcao;
    procedure DoNFeRetRecepcao;
    procedure DoNFeRecibo;    
    procedure DoNFeConsulta;
    procedure DoNFeCancelamento;
    procedure DoNFeInutilizacao;
    procedure DoNFeConsultaCadastro;
    {$IFDEF ACBrNFeOpenSSL}
       procedure ConfiguraHTTP( HTTP : THTTPSend; Action : AnsiString);
    {$ELSE}
       procedure ConfiguraRio( Rio : THTTPRIO);
       procedure OnBeforePost(const HTTPReqResp: THTTPReqResp; Data:Pointer);
    {$ENDIF}
  protected
    FCabMsg: WideString;
    FDadosMsg: AnsiString;
    FRetWS: AnsiString;
    FMsg: AnsiString;
    FURL: WideString;
    FConfiguracoes: TConfiguracoes;
    FACBrNFe : TComponent;
    procedure LoadMsgEntrada;
    procedure LoadURL;
  public
    function Executar: Boolean;virtual;
    constructor Create(AOwner : TComponent); virtual;
    property CabMsg: WideString read FCabMsg;
    property DadosMsg: AnsiString read FDadosMsg;
    property RetWS: AnsiString read FRetWS;
    property Msg: AnsiString read FMsg;
  end;

  TNFeStatusServico = Class(TWebServicesBase)
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

  TNFeRecepcao = Class(TWebServicesBase)
  private
    FLote: Integer;
    FRecibo : String;
    FNotasFiscais : TNotasFiscais;
    FTpAmb: TpcnTipoAmbiente;
    FverAplic: String;
    FcStat: Integer;
    FcUF: Integer;
    FxMotivo: String;
    FdhRecbto: TDateTime;
    FTMed: Integer;
  public
    function Executar: Boolean; override;
    constructor Create(AOwner : TComponent; ANotasFiscais : TNotasFiscais);reintroduce;
    property Recibo: String read FRecibo;
    property TpAmb: TpcnTipoAmbiente read FTpAmb;
    property verAplic: String read FverAplic;
    property cStat: Integer read FcStat;
    property cUF: Integer read FcUF;
    property xMotivo: String read FxMotivo;
    property dhRecbto: TDateTime read FdhRecbto;
    property TMed: Integer read FTMed;
    property Lote: Integer read FLote write FLote;
  end;

  TNFeRetRecepcao = Class(TWebServicesBase)
  private
    FRecibo: String;
    FProtocolo: String;
    FChaveNFe: String; 
    FNotasFiscais: TNotasFiscais;
    FNFeRetorno: TRetConsReciNFe;
    FTpAmb: TpcnTipoAmbiente;
    FverAplic: String;
    FcStat: Integer;
    FcUF: Integer;
    FxMotivo: String;
    function Confirma(AInfProt: TProtNFeCollection): Boolean;
  public
    function Executar: Boolean; override;
    constructor Create(AOwner : TComponent; ANotasFiscais : TNotasFiscais);reintroduce;
    destructor destroy; override;
    property TpAmb: TpcnTipoAmbiente read FTpAmb;
    property verAplic: String read FverAplic;
    property cStat: Integer read FcStat;
    property cUF: Integer read FcUF;
    property xMotivo: String read FxMotivo;
    property Recibo: String read FRecibo write FRecibo;
    property Protocolo: String read FProtocolo write FProtocolo;
    property ChaveNFe: String read FChaveNFe write FChaveNFe;
    property NFeRetorno: TRetConsReciNFe read FNFeRetorno write FNFeRetorno;
  end;

  TNFeRecibo = Class(TWebServicesBase)
  private
    FRecibo: String;
    FNFeRetorno: TRetConsReciNFe;
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
    property NFeRetorno: TRetConsReciNFe read FNFeRetorno write FNFeRetorno;
  end;

  TNFeConsulta = Class(TWebServicesBase)
  private
    FNFeChave: WideString;
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
    property NFeChave: WideString read FNFeChave write FNFeChave;
    property Protocolo: WideString read FProtocolo write FProtocolo;
    property DhRecbto: TDateTime read FDhRecbto write FDhRecbto;
    property XMotivo: WideString read FXMotivo write FXMotivo;
    property TpAmb: TpcnTipoAmbiente read FTpAmb;
    property verAplic: String read FverAplic;
    property cStat: Integer read FcStat;
    property cUF: Integer read FcUF;
    property digVal: String read FdigVal;
  end;

  TNFeCancelamento = Class(TWebServicesBase)
  private
    FNFeChave: WideString;
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
    property NFeChave: WideString read FNFeChave write FNFeChave;
    property Protocolo: WideString read FProtocolo write FProtocolo;
    property Justificativa: WideString read FJustificativa write SetJustificativa;
  end;

  TNFeInutilizacao = Class(TWebServicesBase)
  private
    FNFeChave: WideString;
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
    property NFeChave: WideString read FNFeChave write FNFeChave;
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

  TNFeConsultaCadastro = Class(TWebServicesBase)
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

  TWebServices = Class(TWebServicesBase)
  private
    FACBrNFe : TComponent;
    FStatusServico: TNFeStatusServico;
    FEnviar: TNFeRecepcao;
    FRetorno: TNFeRetRecepcao;
    FRecibo: TNFeRecibo;
    FConsulta: TNFeConsulta;
    FCancelamento: TNFeCancelamento;
    FInutilizacao: TNFeInutilizacao;
    FConsultaCadastro: TNFeConsultaCadastro;
  public
    constructor Create(AFNotaFiscalEletronica: TComponent);reintroduce;
    destructor Destroy; override;
    function Envia(ALote: Integer): Boolean;
    procedure Cancela(AJustificativa: String);
    procedure Inutiliza(CNPJ, AJustificativa: String; Ano, Modelo, Serie, NumeroInicial, NumeroFinal : Integer);
  published
    property ACBrNFe: TComponent read FACBrNFe write FACBrNFe;
    property StatusServico: TNFeStatusServico read FStatusServico write FStatusServico;
    property Enviar: TNFeRecepcao read FEnviar write FEnviar;
    property Retorno: TNFeRetRecepcao read FRetorno write FRetorno;
    property Recibo: TNFeRecibo read FRecibo write FRecibo;
    property Consulta: TNFeConsulta read FConsulta write FConsulta;
    property Cancelamento: TNFeCancelamento read FCancelamento write FCancelamento;
    property Inutilizacao: TNFeInutilizacao read FInutilizacao write FInutilizacao;
    property ConsultaCadastro: TNFeConsultaCadastro read FConsultaCadastro write FConsultaCadastro;
  end;

implementation

uses {$IFDEF ACBrNFeOpenSSL}
        ssl_openssl,
     {$ELSE}
        ACBrNFeNfeStatusServicoU, ACBrNFeNfeRecepcaoU,
        ACBrNFeNfeRetRecepcaoU, ACBrNFeNfeConsultaU,
        ACBrNFeNfeCancelamentoU, ACBrNFeNfeInutilizacaoU,
        ACBrNFeCadConsultaCadastroU,
     {$ENDIF}
     ACBrNFeUtil, ACBrNFe,
     pcnGerador, pcnCabecalho,
     pcnConsStatServ, pcnRetConsStatServ,
     pcnCancNFe, pcnRetCancNFe,
     pcnConsSitNFe, pcnRetConsSitNFe,
     pcnInutNFe, pcnRetInutNFe,
     pcnRetEnvNFe, pcnConsReciNFe ,
     pcnConsCad,
     pcnNFeR, pcnLeitor, pcnProcNFe;

{$IFNDEF ACBrNFeOpenSSL}
const
  INTERNET_OPTION_CLIENT_CERT_CONTEXT = 84;
{$ENDIF}

{ TWebServicesBase }
constructor TWebServicesBase.Create(AOwner: TComponent);
begin
  FConfiguracoes := TConfiguracoes( TACBrNFe( AOwner ).Configuracoes );
  FACBrNFe       := TACBrNFe( AOwner );
end;

{$IFDEF ACBrNFeOpenSSL}
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
  HTTP.Protocol := '1.1' ;
  HTTP.AddPortNumberToHost := False;
  HTTP.Headers.Add(Action);
end;

{$ELSE}
procedure TWebServicesBase.ConfiguraRio( Rio : THTTPRIO);
begin
  if FConfiguracoes.WebServices.ProxyHost <> '' then
   begin
     Rio.HTTPWebNode.Proxy        := FConfiguracoes.WebServices.ProxyHost+':'+FConfiguracoes.WebServices.ProxyPort;
     Rio.HTTPWebNode.UserName     := FConfiguracoes.WebServices.ProxyUser;
     Rio.HTTPWebNode.Password     := FConfiguracoes.WebServices.ProxyPass;
   end;
  Rio.HTTPWebNode.OnBeforePost := OnBeforePost;
end;

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

procedure TWebServicesBase.DoNFeCancelamento;
var
  Cabecalho : TCabecalho;
  CancNFe: TcancNFe;
begin
  Cabecalho := TCabecalho.Create;
  Cabecalho.Versao       := NFecabMsg;
  Cabecalho.VersaoDados  := NFecancNFe;
  Cabecalho.GerarXML;

  FCabMsg := Cabecalho.Gerador.ArquivoFormatoXML;
  Cabecalho.Free;

  CancNFe := TcancNFe.Create;
  CancNFe.schema  := TsPL005c;
  CancNFe.chNFe   := TNFeCancelamento(Self).NFeChave;
  CancNFe.tpAmb   := TpcnTipoAmbiente(FConfiguracoes.WebServices.AmbienteCodigo-1);
  CancNFe.nProt   := TNFeCancelamento(Self).Protocolo;
  CancNFe.xJust   := TNFeCancelamento(Self).Justificativa;
  CancNFe.GerarXML;

{$IFDEF ACBrNFeOpenSSL}
  if not(NotaUtil.Assinar(CancNFe.Gerador.ArquivoFormatoXML, TConfiguracoes(FConfiguracoes).Certificados.Certificado , TConfiguracoes(FConfiguracoes).Certificados.Senha, FDadosMsg, FMsg)) then
    raise Exception.Create('Falha ao assinar Cancelamento Nota Fiscal Eletrônica '+LineBreak+FMsg);
{$ELSE}
  if not(NotaUtil.Assinar(CancNFe.Gerador.ArquivoFormatoXML, TConfiguracoes(FConfiguracoes).Certificados.GetCertificado , FDadosMsg, FMsg)) then
    raise Exception.Create('Falha ao assinar Cancelamento de Nota Fiscal Eletrônica '+LineBreak+FMsg);
{$ENDIF}

  if not(NotaUtil.Valida(FDadosMsg, FMsg)) then
    raise Exception.Create('Falha na validação dos dados do cancelamento '+LineBreak+FMsg);

  CancNFe.Free;
end;

procedure TWebServicesBase.DoNFeConsulta;
var
  Cabecalho  : TCabecalho;
  ConsSitNFe : TConsSitNFe;
begin
  Cabecalho := TCabecalho.Create;
  Cabecalho.Versao       := NFecabMsg;
  Cabecalho.VersaoDados  := NFeconsSitNFe;
  Cabecalho.GerarXML;

  FCabMsg := Cabecalho.Gerador.ArquivoFormatoXML;
  Cabecalho.Free;

  ConsSitNFe    := TConsSitNFe.Create;
  ConsSitNFe.schema := TsPL005c;
  ConsSitNFe.TpAmb := TpcnTipoAmbiente(FConfiguracoes.WebServices.AmbienteCodigo-1);
  ConsSitNFe.chNFe  := TNFeConsulta(Self).NFeChave;
  ConsSitNFe.GerarXML;

  FDadosMsg := ConsSitNFe.Gerador.ArquivoFormatoXML;
  ConsSitNFe.Free;
end;

procedure TWebServicesBase.DoNFeInutilizacao;
var
  Cabecalho: TCabecalho;
  InutNFe: TinutNFe;
begin
  Cabecalho := TCabecalho.Create;
  Cabecalho.Versao       := NFecabMsg;
  Cabecalho.VersaoDados  := NFeinutNFe;
  Cabecalho.GerarXML;

  FCabMsg := Cabecalho.Gerador.ArquivoFormatoXML;
  Cabecalho.Free;

  InutNFe := TinutNFe.Create;
  InutNFe.schema  := TsPL005c;
  InutNFe.tpAmb   := TpcnTipoAmbiente(FConfiguracoes.WebServices.AmbienteCodigo-1);
  InutNFe.cUF     := FConfiguracoes.WebServices.UFCodigo;
  InutNFe.ano     := TNFeInutilizacao(Self).Ano;
  InutNFe.CNPJ    := TNFeInutilizacao(Self).CNPJ;
  InutNFe.modelo  := TNFeInutilizacao(Self).Modelo;
  InutNFe.serie   := TNFeInutilizacao(Self).Serie;
  InutNFe.nNFIni  := TNFeInutilizacao(Self).NumeroInicial;
  InutNFe.nNFFin  := TNFeInutilizacao(Self).NumeroFinal;
  InutNFe.xJust   := TNFeInutilizacao(Self).Justificativa;
  InutNFe.GerarXML;

{$IFDEF ACBrNFeOpenSSL}
  if not(NotaUtil.Assinar(InutNFe.Gerador.ArquivoFormatoXML, TConfiguracoes(FConfiguracoes).Certificados.Certificado , TConfiguracoes(FConfiguracoes).Certificados.Senha, FDadosMsg, FMsg)) then
    raise Exception.Create('Falha ao assinar Inutilização Nota Fiscal Eletrônica '+LineBreak+FMsg);
{$ELSE}
  if not(NotaUtil.Assinar(InutNFe.Gerador.ArquivoFormatoXML, TConfiguracoes(FConfiguracoes).Certificados.GetCertificado , FDadosMsg, FMsg)) then
    raise Exception.Create('Falha ao assinar Inutilização Nota Fiscal Eletrônica '+LineBreak+FMsg);
{$ENDIF}

  InutNFe.Free
end;

procedure TWebServicesBase.DoNFeConsultaCadastro;
var
  Cabecalho: TCabecalho;
  ConCadNFe: TConsCad;
begin
  Cabecalho := TCabecalho.Create;
  Cabecalho.Versao       := NFecabMsg;
  Cabecalho.VersaoDados  := NFeconsCad;
  Cabecalho.GerarXML;

  FCabMsg := Cabecalho.Gerador.ArquivoFormatoXML;
  Cabecalho.Free;

  ConCadNFe := TConsCad.Create;
  ConCadNFe.schema := TsPL005c;
  ConCadNFe.UF     := TNFeConsultaCadastro(Self).UF;
  ConCadNFe.IE     := TNFeConsultaCadastro(Self).IE;
  ConCadNFe.CNPJ   := TNFeConsultaCadastro(Self).CNPJ;
  ConCadNFe.CPF    := TNFeConsultaCadastro(Self).CPF;
  ConCadNFe.GerarXML;

  FDadosMsg := ConCadNFe.Gerador.ArquivoFormatoXML;

  ConCadNFe.Free
end;

procedure TWebServicesBase.DoNFeRecepcao;
var
  Cabecalho: TCabecalho;
  i: Integer;
  vNotas: WideString;
begin
  Cabecalho := TCabecalho.Create;
  Cabecalho.Versao       := NFecabMsg;
  Cabecalho.VersaoDados  := NFenviNFe;
  Cabecalho.GerarXML;

  FCabMsg := Cabecalho.Gerador.ArquivoFormatoXML;
  Cabecalho.Free;

  vNotas := '';
  for i := 0 to TNFeRecepcao(Self).FNotasFiscais.Count-1 do
    vNotas := vNotas + TNFeRecepcao(Self).FNotasFiscais.Items[I].XML;

  FDadosMsg := '<?xml version="1.0" encoding="UTF-8" standalone="no"?>'+
               '<enviNFe xmlns="http://www.portalfiscal.inf.br/nfe" versao="'+NFenviNFe+'">'+
               '<idLote>'+IntToStr(TNFeRecepcao(Self).Lote)+'</idLote>'+vNotas+'</enviNFe>';

end;

procedure TWebServicesBase.DoNFeRetRecepcao;
var
  Cabecalho: TCabecalho;
  ConsReciNFe: TConsReciNFe;
begin
  Cabecalho := TCabecalho.Create;
  Cabecalho.Versao       := NFecabMsg;
  Cabecalho.VersaoDados  := NFeconsReciNFe;
  Cabecalho.GerarXML;

  FCabMsg := Cabecalho.Gerador.ArquivoFormatoXML;
  Cabecalho.Free;

  ConsReciNFe   := TConsReciNFe.Create;
  ConsReciNFe.schema := TsPL005c;
  ConsReciNFe.tpAmb  := TpcnTipoAmbiente(FConfiguracoes.WebServices.AmbienteCodigo-1);
  ConsReciNFe.nRec   := TNFeRetRecepcao(Self).Recibo;
  ConsReciNFe.GerarXML;

  FDadosMsg := ConsReciNFe.Gerador.ArquivoFormatoXML;
  ConsReciNFe.Free;
end;

procedure TWebServicesBase.DoNFeRecibo;
var
  Cabecalho: TCabecalho;
  ConsReciNFe: TConsReciNFe;
begin
  Cabecalho := TCabecalho.Create;
  Cabecalho.Versao       := NFecabMsg;
  Cabecalho.VersaoDados  := NFeconsReciNFe;
  Cabecalho.GerarXML;

  FCabMsg := Cabecalho.Gerador.ArquivoFormatoXML;
  Cabecalho.Free;

  ConsReciNFe   := TConsReciNFe.Create;
  ConsReciNFe.schema := TsPL005c;
  ConsReciNFe.tpAmb  := TpcnTipoAmbiente(FConfiguracoes.WebServices.AmbienteCodigo-1);
  ConsReciNFe.nRec   := TNFeRecibo(Self).Recibo;
  ConsReciNFe.GerarXML;

  FDadosMsg := ConsReciNFe.Gerador.ArquivoFormatoXML;
  ConsReciNFe.Free;
end;

procedure TWebServicesBase.DoNFeStatusServico;
var
  Cabecalho : TCabecalho;
  ConsStatServ: TConsStatServ;
begin
  Cabecalho  := TCabecalho.Create;
  Cabecalho.Versao      := NFecabMsg;
  Cabecalho.VersaoDados := NFeconsStatServ;
  Cabecalho.GerarXML;

  FCabMsg := Cabecalho.Gerador.ArquivoFormatoXML;
  Cabecalho.Free;

  ConsStatServ := TConsStatServ.create;
  ConsStatServ.schema := TsPL005c;
//  ConsStatServ.Versao := NFeconsStatServ;
  ConsStatServ.TpAmb  := TpcnTipoAmbiente(FConfiguracoes.WebServices.AmbienteCodigo-1);
  ConsStatServ.CUF    := FConfiguracoes.WebServices.UFCodigo;
//  ConsStatServ.XServ  := 'STATUS';

  ConsStatServ.GerarXML;

  FDadosMsg := ConsStatServ.Gerador.ArquivoFormatoXML;
  ConsStatServ.Free;

end;

function TWebServicesBase.Executar: Boolean;
begin
  Result := False;
  LoadMsgEntrada;
  LoadURL;
end;

procedure TWebServicesBase.LoadMsgEntrada;
begin
  if self is TNFeStatusServico then
    DoNFeStatusServico
  else if self is TNFeRecepcao then
    DoNFeRecepcao
  else if self is TNFeRetRecepcao then
    DoNFeRetRecepcao
  else if self is TNFeRecibo then
    DoNFeRecibo
  else if self is TNFeConsulta then
    DONFeConsulta
  else if self is TNFeCancelamento then
    DONFeCancelamento
  else if self is TNFeInutilizacao then
    DoNFeInutilizacao
  else if self is TNFeConsultaCadastro then
    DoNFeConsultaCadastro
end;

procedure TWebServicesBase.LoadURL;
begin
  if self is TNFeStatusServico then
    FURL  := NotaUtil.GetURL(FConfiguracoes.WebServices.UFCodigo, FConfiguracoes.WebServices.AmbienteCodigo, FConfiguracoes.Geral.FormaEmissaoCodigo, LayNfeStatusServico)
  else if self is TNFeRecepcao then
    FURL  := NotaUtil.GetURL(FConfiguracoes.WebServices.UFCodigo, FConfiguracoes.WebServices.AmbienteCodigo, FConfiguracoes.Geral.FormaEmissaoCodigo, LayNfeRecepcao)
  else if (self is TNFeRetRecepcao) or (self is TNFeRecibo) then
    FURL  := NotaUtil.GetURL(FConfiguracoes.WebServices.UFCodigo, FConfiguracoes.WebServices.AmbienteCodigo, FConfiguracoes.Geral.FormaEmissaoCodigo, LayNfeRetRecepcao)
  else if self is TNFeConsulta then
    FURL  := NotaUtil.GetURL(FConfiguracoes.WebServices.UFCodigo, FConfiguracoes.WebServices.AmbienteCodigo, FConfiguracoes.Geral.FormaEmissaoCodigo, LayNfeConsulta)
  else if self is TNFeCancelamento then
    FURL  := NotaUtil.GetURL(FConfiguracoes.WebServices.UFCodigo, FConfiguracoes.WebServices.AmbienteCodigo, FConfiguracoes.Geral.FormaEmissaoCodigo, LayNfeCancelamento)
  else if self is TNFeInutilizacao then
    FURL  := NotaUtil.GetURL(FConfiguracoes.WebServices.UFCodigo, FConfiguracoes.WebServices.AmbienteCodigo, FConfiguracoes.Geral.FormaEmissaoCodigo, LayNfeInutilizacao)
  else if self is TNFeConsultaCadastro then
    FURL  := NotaUtil.GetURL(UFparaCodigo(TNFeConsultaCadastro(Self).UF), FConfiguracoes.WebServices.AmbienteCodigo, FConfiguracoes.Geral.FormaEmissaoCodigo, LayNfeCadastro)
end;

{ TWebServices }

procedure TWebServices.Cancela(AJustificativa: String);
begin
  if not(Self.StatusServico.Executar) then
    raise Exception.Create(Self.StatusServico.Msg);

  if not(Self.Consulta.Executar) then
    raise Exception.Create(Self.Consulta.Msg);

  Self.Cancelamento.NFeChave      := Self.Consulta.FNFeChave;
  Self.Cancelamento.Protocolo     := Self.Consulta.FProtocolo;
  Self.Cancelamento.Justificativa := AJustificativa;
  if not(Self.Cancelamento.Executar) then
    raise Exception.Create(Self.Cancelamento.Msg);
end;

procedure TWebServices.Inutiliza(CNPJ, AJustificativa: String; Ano, Modelo, Serie, NumeroInicial, NumeroFinal : Integer);
begin
  if not(Self.StatusServico.Executar) then
    raise Exception.Create(Self.StatusServico.Msg);

  Self.Inutilizacao.NFeChave      := 'ID';
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

constructor TWebServices.Create(AFNotaFiscalEletronica: TComponent);
begin
 inherited Create( AFNotaFiscalEletronica );
  FACBrNFe          := TACBrNFe(AFNotaFiscalEletronica);
  FStatusServico    := TNFeStatusServico.Create(AFNotaFiscalEletronica);
  FEnviar           := TNFeRecepcao.Create(AFNotaFiscalEletronica, TACBrNFe(AFNotaFiscalEletronica).NotasFiscais);
  FRetorno          := TNFeRetRecepcao.Create(AFNotaFiscalEletronica, TACBrNFe(AFNotaFiscalEletronica).NotasFiscais);
  FRecibo           := TNFeRecibo.Create(AFNotaFiscalEletronica);
  FConsulta         := TNFeConsulta.Create(AFNotaFiscalEletronica);
  FCancelamento     := TNFeCancelamento.Create(AFNotaFiscalEletronica);
  FInutilizacao     := TNFeInutilizacao.Create(AFNotaFiscalEletronica);
  FConsultaCadastro := TNFeConsultaCadastro.Create(AFNotaFiscalEletronica);
end;

destructor TWebServices.Destroy;
begin
  FStatusServico.Free;
  FEnviar.Free;
  FRetorno.Free;
  FRecibo.Free;
  FConsulta.Free;
  FCancelamento.Free;
  FInutilizacao.Free;
  FConsultaCadastro.Free;
  inherited;
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

{ TNFeStatusServico }
function TNFeStatusServico.Executar: Boolean;
var
  NFeRetorno: TRetConsStatServ;

  {$IFDEF ACBrNFeOpenSSL}
     Texto : String;
     Acao  : TStringList ;
     Stream: TMemoryStream;
     StrStream: TStringStream;
     HTTP: THTTPSend;
  {$ELSE}
     Nota: NfeStatusServico;
     Rio: THTTPRIO;
  {$ENDIF}
begin
  Result := inherited Executar;

  {$IFDEF ACBrNFeOpenSSL}
     Acao := TStringList.Create;
     Stream := TMemoryStream.Create;
     Texto := '<?xml version="1.0" encoding="utf-8"?>';
     Texto := Texto + '<soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">';
     Texto := Texto +   '<soap:Body>';
     Texto := Texto + '    <nfeStatusServicoNF xmlns="http://www.portalfiscal.inf.br/nfe/wsdl/NfeStatusServico">';
     Texto := Texto + '      <nfeCabecMsg>';

     Texto := Texto + NotaUtil.ParseText(FCabMsg,False);

     Texto := Texto + '      </nfeCabecMsg>';
     Texto := Texto + '      <nfeDadosMsg>';

     Texto := Texto + NotaUtil.ParseText(FDadosMsg,False);

     Texto := Texto + '      </nfeDadosMsg>';
     Texto := Texto + '    </nfeStatusServicoNF>';
     Texto := Texto + '  </soap:Body>';
     Texto := Texto + '</soap:Envelope>';
     Acao.Text := Texto;

     Acao.SaveToStream(Stream);

     HTTP := THTTPSend.Create;
  {$ELSE}
     Rio := THTTPRIO.Create(nil);
     ConfiguraRio( Rio );
  {$ENDIF}

  try
    TACBrNFe( FACBrNFe ).SetStatus( stNFeStatusServico );
    if FConfiguracoes.Geral.Salvar then
      FConfiguracoes.Geral.Save(FormatDateTime('yyyymmddhhnnss',Now)+'-ped-sta.xml', FDadosMsg);

    try
      {$IFDEF ACBrNFeOpenSSL}
         HTTP.Document.LoadFromStream(Stream);
         ConfiguraHTTP(HTTP,'SOAPAction: "http://www.portalfiscal.inf.br/nfe/wsdl/NfeStatusServico/nfeStatusServicoNF"');
         HTTP.HTTPMethod('POST', FURL);
         StrStream := TStringStream.Create('');
         StrStream.CopyFrom(HTTP.Document, 0);

         FRetWS := NotaUtil.SeparaDados( NotaUtil.ParseText(StrStream.DataString, True),'nfeStatusServicoNFResult');
         StrStream.Free;
      {$ELSE}
         Nota   := GetNfeStatusServico( False, FURL, Rio);
         FRetWS := Nota.nfeStatusServicoNF(FCabMsg, FDadosMsg);
      {$ENDIF}
      NFeRetorno := TRetConsStatServ.Create;
      NFeRetorno.Leitor.Arquivo := FRetWS;
      NFeRetorno.LerXml;

      TACBrNFe( FACBrNFe ).SetStatus( stIdle );
      if FConfiguracoes.WebServices.Visualizar then
      begin
        ShowMessage(//'Versão Leiaute : '+NFeRetorno.verAplic+LineBreak+
                    'Ambiente : '+TpAmbToStr(NFeRetorno.tpAmb)+LineBreak+
                    'Versão Aplicativo : '+NFeRetorno.verAplic+LineBreak+
                    'Status Código : '+IntToStr(NFeRetorno.cStat)+LineBreak+
                    'Status Descrição : '+NFeRetorno.xMotivo+LineBreak+
                    'UF : '+CodigoParaUF(NFeRetorno.cUF)+LineBreak+
                    'Recebimento : '+DateTimeToStr(NFeRetorno.dhRecbto)+LineBreak+
                    'Tempo Médio : '+IntToStr(NFeRetorno.TMed)+LineBreak+
                    'Retorno : '+DateTimeToStr(NFeRetorno.dhRetorno)+LineBreak+
                    'Observação : '+NFeRetorno.xObs);
      end;

      FtpAmb    := NFeRetorno.tpAmb;
      FverAplic := NFeRetorno.verAplic;
      FcStat    := NFeRetorno.cStat;
      FxMotivo  := NFeRetorno.xMotivo;
      FcUF      := NFeRetorno.cUF;
      FdhRecbto := NFeRetorno.dhRecbto;
      FTMed     := NFeRetorno.TMed;
      FdhRetorno:= NFeRetorno.dhRetorno;
      FxObs     := NFeRetorno.xObs;

      FMsg   := NFeRetorno.XMotivo+ LineBreak+NFeRetorno.XObs;
      Result := (NFeRetorno.CStat = 107);
      NFeRetorno.Free;

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
    {$IFDEF ACBrNFeOpenSSL}
       HTTP.Free;
       Acao.Free;
       Stream.Free;
    {$ELSE}
//       Rio.Free;
    {$ENDIF}
    NotaUtil.ConfAmbiente;
    TACBrNFe( FACBrNFe ).SetStatus( stIdle );
  end;
end;

{ TNFeRecepcao }
constructor TNFeRecepcao.Create(AOwner : TComponent;
  ANotasFiscais: TNotasFiscais);
begin
  inherited Create(AOwner);
  FNotasFiscais := ANotasFiscais;
end;

function TNFeRecepcao.Executar: Boolean;
var
  NFeRetorno: TretEnvNFe;
  {$IFDEF ACBrNFeOpenSSL}
     Texto : String;
     Acao  : TStringList ;
     Stream: TMemoryStream;
     StrStream: TStringStream;
     HTTP: THTTPSend;
  {$ELSE}
     Nota: NfeRecepcao;
     Rio: THTTPRIO;
  {$ENDIF}
begin
  Result := inherited Executar;
  {$IFDEF ACBrNFeOpenSSL}
     Acao := TStringList.Create;
     Stream := TMemoryStream.Create;
     Texto := '<?xml version="1.0" encoding="utf-8"?>';
     Texto := Texto + '<soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">';
     Texto := Texto + '  <soap:Body>';
     Texto := Texto + '    <nfeRecepcaoLote xmlns="http://www.portalfiscal.inf.br/nfe/wsdl/NfeRecepcao">';
     Texto := Texto + '      <nfeCabecMsg>';

     Texto := Texto + NotaUtil.ParseText(FCabMsg,False);

     Texto := Texto + '      </nfeCabecMsg>';
     Texto := Texto + '      <nfeDadosMsg>';

     Texto := Texto + NotaUtil.ParseText(FDadosMsg,False);

     Texto := Texto + '      </nfeDadosMsg>';
     Texto := Texto + '    </nfeRecepcaoLote>';
     Texto := Texto + '  </soap:Body>';
     Texto := Texto + '</soap:Envelope>';
     Acao.Text := Texto;

     Acao.SaveToStream(Stream);

     HTTP := THTTPSend.Create;
  {$ELSE}
     Rio := THTTPRIO.Create(nil);
     ConfiguraRio(Rio);
  {$ENDIF}
  try
    TACBrNFe( FACBrNFe ).SetStatus( stNFeRecepcao );
    if FConfiguracoes.Geral.Salvar then
      FConfiguracoes.Geral.Save(IntToStr(Lote)+'-env-lot.xml', FDadosMsg);
    {$IFDEF ACBrNFeOpenSSL}
       HTTP.Document.LoadFromStream(Stream);
       ConfiguraHTTP(HTTP,'SOAPAction: "http://www.portalfiscal.inf.br/nfe/wsdl/NfeRecepcao/nfeRecepcaoLote"');
       HTTP.HTTPMethod('POST', FURL);

       StrStream := TStringStream.Create('');
       StrStream.CopyFrom(HTTP.Document, 0);
       FRetWS := NotaUtil.SeparaDados( NotaUtil.ParseText(StrStream.DataString, True),'nfeRecepcaoLoteResult');
       StrStream.Free;
    {$ELSE}
       Nota   := GetNfeRecepcao( False, FURL, Rio);
       FRetWS := Nota.nfeRecepcaoLote(FCabMsg, FDadosMsg);
    {$ENDIF}
    NFeRetorno := TretEnvNFe.Create;
    NFeRetorno.Leitor.Arquivo := FRetWS;
    NFeRetorno.LerXml;

    TACBrNFe( FACBrNFe ).SetStatus( stIdle );
    if FConfiguracoes.WebServices.Visualizar then
    begin
      ShowMessage(//'Versão Leiaute : '+NFeRetorno.Versao+LineBreak+
                  'Ambiente : '+TpAmbToStr(NFeRetorno.TpAmb)+LineBreak+
                  'Versão Aplicativo : '+NFeRetorno.verAplic+LineBreak+
                  'Status Código : '+IntToStr(NFeRetorno.cStat)+LineBreak+
                  'Status Descrição : '+NFeRetorno.xMotivo+LineBreak+
                  'UF : '+CodigoParaUF(NFeRetorno.cUF)+LineBreak+
                  'Recibo : '+NFeRetorno.infRec.nRec+LineBreak+
                  'Recebimento : '+DateTimeToStr(NFeRetorno.InfRec.dhRecbto)+LineBreak+
                  'Tempo Médio : '+IntToStr(NFeRetorno.InfRec.TMed)+LineBreak);
    end;
    FTpAmb    := NFeRetorno.TpAmb;
    FverAplic := NFeRetorno.verAplic;
    FcStat    := NFeRetorno.cStat;
    FxMotivo  := NFeRetorno.xMotivo;
    FdhRecbto := NFeRetorno.infRec.dhRecbto;
    FTMed     := NFeRetorno.infRec.tMed;
    FcUF      := NFeRetorno.cUF;

    FMsg    := NFeRetorno.xMotivo;
    FRecibo := NFeRetorno.infRec.nRec;
    Result := (NFeRetorno.CStat = 103);

    NFeRetorno.Free;

    if FConfiguracoes.Geral.Salvar then
      FConfiguracoes.Geral.Save(IntToStr(Lote)+'-rec.xml', FRetWS);

  finally
    {$IFDEF ACBrNFeOpenSSL}
       HTTP.Free;
       Acao.Free;
       Stream.Free;
    {$ELSE}
//       Rio.Free;
    {$ENDIF}
    NotaUtil.ConfAmbiente;
    TACBrNFe( FACBrNFe ).SetStatus( stIdle );
  end;
end;

{ TNFeRetRecepcao }
function TNFeRetRecepcao.Confirma(AInfProt: TProtNFeCollection): Boolean;
var
  i,j : Integer;
  AProcNFe: TProcNFe;
begin
  Result := False;

  //Setando os retornos das notas fiscais;
  for i:= 0 to AInfProt.Count-1 do
  begin
    for j:= 0 to FNotasFiscais.Count-1 do
    begin
      if 'NFe'+AInfProt.Items[i].chNFe = FNotasFiscais.Items[j].NFe.InfNFe.Id  then
      begin
        FNotasFiscais.Items[j].Confirmada := (AInfProt.Items[i].cStat = 100);
        FNotasFiscais.Items[j].Msg        := AInfProt.Items[i].xMotivo;
        FNotasFiscais.Items[j].NFe.procNFe.tpAmb    := AInfProt.Items[i].tpAmb;
        FNotasFiscais.Items[j].NFe.procNFe.verAplic := AInfProt.Items[i].verAplic;
        FNotasFiscais.Items[j].NFe.procNFe.chNFe    := AInfProt.Items[i].chNFe;
        FNotasFiscais.Items[j].NFe.procNFe.dhRecbto := AInfProt.Items[i].dhRecbto;
        FNotasFiscais.Items[j].NFe.procNFe.nProt    := AInfProt.Items[i].nProt;
        FNotasFiscais.Items[j].NFe.procNFe.digVal   := AInfProt.Items[i].digVal;
        FNotasFiscais.Items[j].NFe.procNFe.cStat    := AInfProt.Items[i].cStat;
        FNotasFiscais.Items[j].NFe.procNFe.xMotivo  := AInfProt.Items[i].xMotivo;
        if FConfiguracoes.Geral.Salvar then
        begin
           AProcNFe:=TProcNFe.Create;
           AProcNFe.PathNFe:=FConfiguracoes.Geral.PathSalvar+'\'+FNFeRetorno.ProtNFe.Items[j].chNFe+'-nfe.xml';
           AProcNFe.PathRetConsReciNFe:=FConfiguracoes.Geral.PathSalvar+'\'+FNFeRetorno.nRec+'-pro-rec.xml';
           AProcNFe.GerarXML;
           AProcNFe.Gerador.SalvarArquivo(FConfiguracoes.Geral.PathSalvar+'\'+FNFeRetorno.ProtNFe.Items[j].chNFe+'-nfe.xml');
           AProcNFe.Free;
        end;
        break;
      end;
    end;
  end;

  //Verificando se existe alguma nota confirmada
  for i:= 0 to FNotasFiscais.Count-1 do
  begin
    if FNotasFiscais.Items[i].Confirmada then
    begin
      Result := True;
      break;
    end;
  end;

  //Verificando se existe alguma nota nao confirmada
  for i:= 0 to FNotasFiscais.Count-1 do
  begin
    if not(FNotasFiscais.Items[i].Confirmada) then
    begin
      FMsg   := 'Nota(s) não confirmadas:'+LineBreak;
      break;
    end;
  end;

  //Montando a mensagem de retorno para as notas nao confirmadas
  for i:= 0 to FNotasFiscais.Count-1 do
  begin
    if not(FNotasFiscais.Items[i].Confirmada) then
      FMsg:= FMsg+IntToStr(FNotasFiscais.Items[i].NFe.Ide.nNF)+'->'+FNotasFiscais.Items[i].Msg+LineBreak;
  end;
end;

constructor TNFeRetRecepcao.Create(AOwner : TComponent;
  ANotasFiscais: TNotasFiscais);
begin
  inherited Create(AOwner);
  FNotasFiscais := ANotasFiscais;
end;

destructor TNFeRetRecepcao.destroy;
begin
   if assigned(FNFeRetorno) then
      FNFeRetorno.Free;
   inherited;
end;

function TNFeRetRecepcao.Executar: Boolean;
  function Processando: Boolean;
  var
    {$IFDEF ACBrNFeOpenSSL}
       Texto : String;
       Acao  : TStringList ;
       Stream: TMemoryStream;
       StrStream: TStringStream;
       HTTP: THTTPSend;
    {$ELSE}
       Nota: NfeRetRecepcao;
       Rio: THTTPRIO;
    {$ENDIF}
  begin
    {$IFDEF ACBrNFeOpenSSL}
       Acao := TStringList.Create;
       Stream := TMemoryStream.Create;
       Texto := '<?xml version="1.0" encoding="utf-8"?>';
       Texto := Texto + '<soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">';
       Texto := Texto + '  <soap:Body>';
       Texto := Texto + '    <nfeRetRecepcao xmlns="http://www.portalfiscal.inf.br/nfe/wsdl/NfeRetRecepcao">';
       Texto := Texto + '      <nfeCabecMsg>';

       Texto := Texto + NotaUtil.ParseText(FCabMsg,False);

       Texto := Texto + '      </nfeCabecMsg>';
       Texto := Texto + '      <nfeDadosMsg>';

       Texto := Texto + NotaUtil.ParseText(FDadosMsg,False);

       Texto := Texto + '      </nfeDadosMsg>';
       Texto := Texto + '    </nfeRetRecepcao>';
       Texto := Texto + '  </soap:Body>';
       Texto := Texto + '</soap:Envelope>';

       Acao.Text := Texto;

       Acao.SaveToStream(Stream);

       HTTP := THTTPSend.Create;
    {$ELSE}
       Rio := THTTPRIO.Create(nil);
       ConfiguraRio(Rio);
    {$ENDIF}
    try
      TACBrNFe( FACBrNFe ).SetStatus( stNfeRetRecepcao );
      if FConfiguracoes.Geral.Salvar then
        FConfiguracoes.Geral.Save(Recibo+'-ped-rec.xml', FDadosMsg);

      {$IFDEF ACBrNFeOpenSSL}
         HTTP.Document.LoadFromStream(Stream);
         ConfiguraHTTP(HTTP,'SOAPAction: "http://www.portalfiscal.inf.br/nfe/wsdl/NfeRetRecepcao/nfeRetRecepcao"');
         HTTP.HTTPMethod('POST', FURL);

         StrStream := TStringStream.Create('');
         StrStream.CopyFrom(HTTP.Document, 0);

         FRetWS := NotaUtil.SeparaDados( NotaUtil.ParseText(StrStream.DataString, True),'nfeRetRecepcaoResult');
         StrStream.Free;
      {$ELSE}
         Nota   := GetNfeRetRecepcao( False, FURL, Rio);
         FRetWS := Nota.nfeRetRecepcao(FCabMsg, FDadosMsg);
      {$ENDIF}
      if assigned(FNFeRetorno) then
         FNFeRetorno.Free;

      if FConfiguracoes.Geral.Salvar then
         FConfiguracoes.Geral.Save(Recibo+'-pro-rec.xml', FRetWS);

      FNFeRetorno := TRetConsReciNFe.Create;
      FNFeRetorno.Leitor.Arquivo := FRetWS;
      FNFeRetorno.LerXML;

      TACBrNFe( FACBrNFe ).SetStatus( stIdle );
      if FConfiguracoes.WebServices.Visualizar then
      begin
        ShowMessage(//'Versão Leiaute : '+FNFeRetorno.Versao+LineBreak+
                    'Ambiente : '+TpAmbToStr(FNFeRetorno.TpAmb)+LineBreak+
                    'Versão Aplicativo : '+FNFeRetorno.verAplic+LineBreak+
                    'Recibo : '+FNFeRetorno.nRec+LineBreak+
                    'Status Código : '+IntToStr(FNFeRetorno.cStat)+LineBreak+
                    'Status Descrição : '+FNFeRetorno.xMotivo+LineBreak+
                    'UF : '+CodigoParaUF(FNFeRetorno.cUF)+LineBreak);
      end;
      FTpAmb    := FNFeRetorno.TpAmb;
      FverAplic := FNFeRetorno.verAplic;
      FcStat    := FNFeRetorno.cStat;
      FcUF      := FNFeRetorno.cUF;
      FMsg      := FNFeRetorno.xMotivo;
      FxMotivo  := FNFeRetorno.xMotivo;

      Result := FNFeRetorno.CStat = 105;
      if FNFeRetorno.CStat = 104 then
      begin
         FMsg   := FNFeRetorno.ProtNFe.Items[0].xMotivo;
         FxMotivo  := FNFeRetorno.ProtNFe.Items[0].xMotivo;
      end;

    finally
      {$IFDEF ACBrNFeOpenSSL}
         HTTP.Free;
         Acao.Free;
         Stream.Free;
      {$ELSE}
//         Rio.Free;
      {$ENDIF}
      NotaUtil.ConfAmbiente;
      TACBrNFe( FACBrNFe ).SetStatus( stIdle );
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

  if FNFeRetorno.CStat = 104 then
    Result := Confirma(FNFeRetorno.ProtNFe);

  fChaveNfe  := FNFeRetorno.ProtNFe.Items[0].chNFe;
  fProtocolo := FNFeRetorno.ProtNFe.Items[0].nProt;
  fcStat     := FNFeRetorno.ProtNFe.Items[0].cStat;

//  FNFeRetorno.Free;
end;

{ TNFeRecibo }
constructor TNFeRecibo.Create(AOwner : TComponent);
begin
  inherited Create(AOwner);
end;

destructor TNFeRecibo.destroy;
begin
   if assigned(FNFeRetorno) then
      FNFeRetorno.Free;
  inherited;
end;

function TNFeRecibo.Executar: Boolean;
var
 {$IFDEF ACBrNFeOpenSSL}
    Texto : String;
    Acao  : TStringList ;
    Stream: TMemoryStream;
    StrStream: TStringStream;
    HTTP: THTTPSend;
 {$ELSE}
    Nota: NfeRetRecepcao;
    Rio: THTTPRIO;
 {$ENDIF}
begin
   Result := inherited Executar;

 {$IFDEF ACBrNFeOpenSSL}
    Acao := TStringList.Create;
    Stream := TMemoryStream.Create;
    Texto := '<?xml version="1.0" encoding="utf-8"?>';
    Texto := Texto + '<soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">';
    Texto := Texto + '  <soap:Body>';
    Texto := Texto + '    <nfeRetRecepcao xmlns="http://www.portalfiscal.inf.br/nfe/wsdl/NfeRetRecepcao">';
    Texto := Texto + '      <nfeCabecMsg>';

    Texto := Texto + NotaUtil.ParseText(FCabMsg,False);

    Texto := Texto + '      </nfeCabecMsg>';
    Texto := Texto + '      <nfeDadosMsg>';

    Texto := Texto + NotaUtil.ParseText(FDadosMsg,False);

    Texto := Texto + '      </nfeDadosMsg>';
    Texto := Texto + '    </nfeRetRecepcao>';
    Texto := Texto + '  </soap:Body>';
    Texto := Texto + '</soap:Envelope>';

    Acao.Text := Texto;

    Acao.SaveToStream(Stream);

    HTTP := THTTPSend.Create;
 {$ELSE}
    Rio := THTTPRIO.Create(nil);
    ConfiguraRio(Rio);
 {$ENDIF}
 try
   TACBrNFe( FACBrNFe ).SetStatus( stNfeRetRecepcao );
   if FConfiguracoes.Geral.Salvar then
     FConfiguracoes.Geral.Save(Recibo+'-ped-rec.xml', FDadosMsg);

   {$IFDEF ACBrNFeOpenSSL}
      HTTP.Document.LoadFromStream(Stream);
      ConfiguraHTTP(HTTP,'SOAPAction: "http://www.portalfiscal.inf.br/nfe/wsdl/NfeRetRecepcao/nfeRetRecepcao"');
      HTTP.HTTPMethod('POST', FURL);

      StrStream := TStringStream.Create('');
      StrStream.CopyFrom(HTTP.Document, 0);

      FRetWS := NotaUtil.SeparaDados( NotaUtil.ParseText(StrStream.DataString, True),'nfeRetRecepcaoResult');
      StrStream.Free;
   {$ELSE}
      Nota   := GetNfeRetRecepcao( False, FURL, Rio);
      FRetWS := Nota.nfeRetRecepcao(FCabMsg, FDadosMsg);
   {$ENDIF}
   if assigned(FNFeRetorno) then
      FNFeRetorno.Free;
   FNFeRetorno := TRetConsReciNFe.Create;
   FNFeRetorno.Leitor.Arquivo := FRetWS;
   FNFeRetorno.LerXML;

   TACBrNFe( FACBrNFe ).SetStatus( stIdle );
   if FConfiguracoes.WebServices.Visualizar then
   begin
     ShowMessage(//'Versão Leiaute : '+FNFeRetorno.Versao+LineBreak+
                 'Ambiente : '+TpAmbToStr(FNFeRetorno.TpAmb)+LineBreak+
                 'Versão Aplicativo : '+FNFeRetorno.verAplic+LineBreak+
                 'Recibo : '+FNFeRetorno.nRec+LineBreak+
                 'Status Código : '+IntToStr(FNFeRetorno.cStat)+LineBreak+
                 'Status Descrição : '+FNFeRetorno.ProtNFe.Items[0].xMotivo+LineBreak+
                 'UF : '+CodigoParaUF(FNFeRetorno.cUF)+LineBreak);
   end;
   FTpAmb    := FNFeRetorno.TpAmb;
   FverAplic := FNFeRetorno.verAplic;
   FcStat    := FNFeRetorno.cStat;
   FxMotivo  := FNFeRetorno.xMotivo;
   FcUF      := FNFeRetorno.cUF;

   Result := FNFeRetorno.CStat = 104;
   FMsg   := FNFeRetorno.xMotivo;

 finally
   {$IFDEF ACBrNFeOpenSSL}
      HTTP.Free;
      Acao.Free;
      Stream.Free;
   {$ELSE}
//      Rio.Free;
   {$ENDIF}
   NotaUtil.ConfAmbiente;
   TACBrNFe( FACBrNFe ).SetStatus( stIdle );
 end;
end;

{ TNFeConsulta }
function TNFeConsulta.Executar: Boolean;
var
  NFeRetorno: TRetConsSitNFe;
  AProcNFe: TProcNFe;
  i : Integer;
  {$IFDEF ACBrNFeOpenSSL}
     Texto : String;
     Acao  : TStringList ;
     Stream: TMemoryStream;
     StrStream: TStringStream;
     HTTP: THTTPSend;
  {$ELSE}
     Nota: NfeConsulta;
     Rio: THTTPRIO;
  {$ENDIF}
begin
  Result := inherited Executar;

  {$IFDEF ACBrNFeOpenSSL}
     Acao := TStringList.Create;
     Stream := TMemoryStream.Create;
     Texto := '<?xml version="1.0" encoding="utf-8"?>';
     Texto := Texto + '<soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">';
     Texto := Texto + '  <soap:Body>';
     Texto := Texto + '    <nfeConsultaNF xmlns="http://www.portalfiscal.inf.br/nfe/wsdl/NfeConsulta">';
     Texto := Texto + '      <nfeCabecMsg>';

     Texto := Texto + NotaUtil.ParseText(FCabMsg,False);

     Texto := Texto + '      </nfeCabecMsg>';
     Texto := Texto + '      <nfeDadosMsg>';

     Texto := Texto + NotaUtil.ParseText(FDadosMsg,False);

     Texto := Texto + '      </nfeDadosMsg>';
     Texto := Texto + '    </nfeConsultaNF>';
     Texto := Texto + '  </soap:Body>';
     Texto := Texto + '</soap:Envelope>';
     Acao.Text := Texto;

     Acao.SaveToStream(Stream);

     HTTP := THTTPSend.Create;
  {$ELSE}
     Rio := THTTPRIO.Create(nil);
     ConfiguraRio(Rio);
  {$ENDIF}
  try
    TACBrNFe( FACBrNFe ).SetStatus( stNfeConsulta );
    if FConfiguracoes.Geral.Salvar then
      FConfiguracoes.Geral.Save(FNFeChave+'-ped-sit.xml', FDadosMsg);

    {$IFDEF ACBrNFeOpenSSL}
       HTTP.Document.LoadFromStream(Stream);
       ConfiguraHTTP(HTTP,'SOAPAction: "http://www.portalfiscal.inf.br/nfe/wsdl/NfeConsulta/nfeConsultaNF"');
       HTTP.HTTPMethod('POST', FURL);

       StrStream := TStringStream.Create('');
       StrStream.CopyFrom(HTTP.Document, 0);

       FRetWS := NotaUtil.SeparaDados( NotaUtil.ParseText(StrStream.DataString, True),'nfeConsultaNFResult');
       StrStream.Free;
    {$ELSE}
       Nota   := GetNfeConsulta( False, FURL, Rio);
       FRetWS := Nota.nfeConsultaNF(FCabMsg, FDadosMsg);
    {$ENDIF}
    NFeRetorno := TRetConsSitNFe.Create;
    NFeRetorno.Leitor.Arquivo := FRetWS;
    NFeRetorno.LerXML;
    FProtocolo := NFeRetorno.nProt;

    TACBrNFe( FACBrNFe ).SetStatus( stIdle );
    if FConfiguracoes.WebServices.Visualizar then
    begin
      ShowMessage(//'Versão Leiaute : '+NFeRetorno.Versao+LineBreak+
                  'Identificador : '+NFeRetorno.chNFe+LineBreak+
                  'Ambiente : '+TpAmbToStr(NFeRetorno.TpAmb)+LineBreak+
                  'Versão Aplicativo : '+NFeRetorno.verAplic+LineBreak+
                  'Status Código : '+IntToStr(NFeRetorno.CStat)+LineBreak+
                  'Status Descrição : '+NFeRetorno.xMotivo+LineBreak+
                  'UF : '+CodigoParaUF(NFeRetorno.cUF)+LineBreak+
                  'Chave Acesso : '+NFeRetorno.ChNFe+LineBreak+
                  'Recebimento : '+DateTimeToStr(NFeRetorno.DhRecbto)+LineBreak+
                  'Protocolo : '+NFeRetorno.nProt+LineBreak+
                  'Digest Value : '+NFeRetorno.digVal+LineBreak);
    end;
    FTpAmb    := NFeRetorno.TpAmb;
    FverAplic := NFeRetorno.verAplic;
    FcStat    := NFeRetorno.cStat;
    FcUF      := NFeRetorno.cUF;
    FdigVal   := NFeRetorno.digVal;
    FdhRecbto := NFeRetorno.DhRecbto;
    FxMotivo  := NFeRetorno.xMotivo;

    FMsg   := NFeRetorno.XMotivo;
    Result := (NFeRetorno.CStat in [100,101,110]);

    for i:= 0 to TACBrNFe( FACBrNFe ).NotasFiscais.Count-1 do
     begin
        if TACBrNFe( FACBrNFe ).NotasFiscais.Items[i].NFe.infNFe.ID = FNFeChave then
         begin
           TACBrNFe( FACBrNFe ).NotasFiscais.Items[i].NFe.procNFe.tpAmb    := NFeRetorno.tpAmb;
           TACBrNFe( FACBrNFe ).NotasFiscais.Items[i].NFe.procNFe.verAplic := NFeRetorno.verAplic;
           TACBrNFe( FACBrNFe ).NotasFiscais.Items[i].NFe.procNFe.chNFe    := NFeRetorno.chNFe;
           TACBrNFe( FACBrNFe ).NotasFiscais.Items[i].NFe.procNFe.dhRecbto := NFeRetorno.dhRecbto;
           TACBrNFe( FACBrNFe ).NotasFiscais.Items[i].NFe.procNFe.nProt    := NFeRetorno.nProt;
           TACBrNFe( FACBrNFe ).NotasFiscais.Items[i].NFe.procNFe.digVal   := NFeRetorno.digVal;
           TACBrNFe( FACBrNFe ).NotasFiscais.Items[i].NFe.procNFe.cStat    := NFeRetorno.cStat;
           TACBrNFe( FACBrNFe ).NotasFiscais.Items[i].NFe.procNFe.xMotivo  := NFeRetorno.xMotivo;
           break;
         end;
     end;

    NFeRetorno.Free;

    if FConfiguracoes.Geral.Salvar then
     begin
       FConfiguracoes.Geral.Save(FNFeChave+'-sit.xml', FRetWS);
       if FileExists(FConfiguracoes.Geral.PathSalvar+'\'+FNFeChave+'-nfe.xml') then
        begin
          AProcNFe:=TProcNFe.Create;
          AProcNFe.PathNFe:=FConfiguracoes.Geral.PathSalvar+'\'+FNFeChave+'-nfe.xml';
          AProcNFe.PathRetConsSitNFe:=FConfiguracoes.Geral.PathSalvar+'\'+FNFeChave+'-sit.xml';
          AProcNFe.GerarXML;
          AProcNFe.Gerador.SalvarArquivo(FConfiguracoes.Geral.PathSalvar+'\'+FNFeChave+'-nfe.xml');
          AProcNFe.Free;
        end;
     end;
  finally
    {$IFDEF ACBrNFeOpenSSL}
       HTTP.Free;
       Acao.Free;
       Stream.Free;
    {$ELSE}
//       Rio.Free;
    {$ENDIF}
    NotaUtil.ConfAmbiente;
    TACBrNFe( FACBrNFe ).SetStatus( stIdle );
  end;
end;

{ TNFeCancelamento }
function TNFeCancelamento.Executar: Boolean;
var
  NFeRetorno: TRetCancNFe;

  {$IFDEF ACBrNFeOpenSSL}
     Texto : String;
     Acao  : TStringList ;
     Stream: TMemoryStream;
     StrStream: TStringStream;
     HTTP: THTTPSend;
  {$ELSE}
     Nota: NfeCancelamento;
     Rio: THTTPRIO;
  {$ENDIF}
begin
  Result := inherited Executar;

  {$IFDEF ACBrNFeOpenSSL}
     Acao := TStringList.Create;
     Stream := TMemoryStream.Create;
     Texto := '<?xml version="1.0" encoding="utf-8"?>';
     Texto := Texto + '<soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">';
     Texto := Texto + '  <soap:Body>';
     Texto := Texto + '    <nfeCancelamentoNF xmlns="http://www.portalfiscal.inf.br/nfe/wsdl/NfeCancelamento">';
     Texto := Texto + '      <nfeCabecMsg>';

     Texto := Texto + NotaUtil.ParseText(FCabMsg,False);

     Texto := Texto + '      </nfeCabecMsg>';
     Texto := Texto + '      <nfeDadosMsg>';

     Texto := Texto + NotaUtil.ParseText(FDadosMsg,False);

     Texto := Texto + '      </nfeDadosMsg>';
     Texto := Texto + '    </nfeCancelamentoNF>';
     Texto := Texto + '  </soap:Body>';
     Texto := Texto + '</soap:Envelope>';
     Acao.Text := Texto;

     Acao.SaveToStream(Stream);

     HTTP := THTTPSend.Create;
  {$ELSE}
     Rio := THTTPRIO.Create(nil);
     ConfiguraRio(Rio);
  {$ENDIF}
  try
    TACBrNFe( FACBrNFe ).SetStatus( stNfeCancelamento );
    if FConfiguracoes.Geral.Salvar then
      FConfiguracoes.Geral.Save(FNFeChave+'-ped-can.xml', FDadosMsg);

    {$IFDEF ACBrNFeOpenSSL}
       HTTP.Document.LoadFromStream(Stream);
       ConfiguraHTTP(HTTP,'SOAPAction: "http://www.portalfiscal.inf.br/nfe/wsdl/NfeCancelamento/nfeCancelamentoNF"');
       HTTP.HTTPMethod('POST', FURL);

       StrStream := TStringStream.Create('');
       StrStream.CopyFrom(HTTP.Document, 0);
       FRetWS := NotaUtil.SeparaDados( NotaUtil.ParseText(StrStream.DataString, True),'nfeCancelamentoNFResult');
       StrStream.Free;
    {$ELSE}
       Nota   := GetNfeCancelamento(False, FURL, Rio);
       FRetWS := Nota.nfeCancelamentoNF(FCabMsg, FDadosMsg);
    {$ENDIF}

    NFeRetorno := TRetCancNFe.Create;
    NFeRetorno.Leitor.Arquivo := FRetWS;
    NFeRetorno.LerXml;

    TACBrNFe( FACBrNFe ).SetStatus( stIdle );
    if FConfiguracoes.WebServices.Visualizar then
    begin
      ShowMessage(//'Versão Leiaute : '+NFeRetorno.Versao+LineBreak+
                  'Identificador : '+ NFeRetorno.chNFE+LineBreak+
                  'Ambiente : '+TpAmbToStr(NFeRetorno.TpAmb)+LineBreak+
                  'Versão Aplicativo : '+NFeRetorno.verAplic+LineBreak+
                  'Status Código : '+IntToStr(NFeRetorno.cStat)+LineBreak+
                  'Status Descrição : '+NFeRetorno.xMotivo+LineBreak+
                  'UF : '+CodigoParaUF(NFeRetorno.cUF)+LineBreak+
                  'Chave Acesso : '+NFeRetorno.chNFE+LineBreak+
                  'Recebimento : '+DateTimeToStr(NFeRetorno.DhRecbto)+LineBreak+
                  'Protocolo : '+NFeRetorno.nProt+LineBreak);
    end;
    FTpAmb    := NFeRetorno.TpAmb;
    FverAplic := NFeRetorno.verAplic;
    FcStat    := NFeRetorno.cStat;
    FxMotivo  := NFeRetorno.xMotivo;
    FcUF      := NFeRetorno.cUF;
    FDhRecbto := NFeRetorno.dhRecbto;
    Fprotocolo:= NFeRetorno.nProt;

    FMsg   := NFeRetorno.XMotivo;
    Result := (NFeRetorno.CStat = 101);
    NFeRetorno.Free;

    if FConfiguracoes.Geral.Salvar then
      FConfiguracoes.Geral.Save(FNFeChave+'-can.xml', FRetWS);
  finally
    {$IFDEF ACBrNFeOpenSSL}
       HTTP.Free;
       Acao.Free;
       Stream.Free;
    {$ELSE}
//       Rio.Free;
    {$ENDIF}
    NotaUtil.ConfAmbiente;
    TACBrNFe( FACBrNFe ).SetStatus( stIdle );
  end;
end;

procedure TNFeCancelamento.SetJustificativa(AValue: WideString);
begin
  if NotaUtil.EstaVazio(AValue) then
    raise Exception.Create('Informar uma Justificativa para cancelar a Nota Fiscal Eletronica')
  else
    AValue := NotaUtil.TrataString(AValue);

  if Length(AValue) < 15 then
    FJustificativa := NotaUtil.PadE(AValue, 15,'-')
  else
    FJustificativa := AValue;
end;

{ TNFeInutilizacao }
function TNFeInutilizacao.Executar: Boolean;
var
  NFeRetorno: TRetInutNFe;
  {$IFDEF ACBrNFeOpenSSL}
     Texto : String;
     Acao  : TStringList ;
     Stream: TMemoryStream;
     StrStream: TStringStream;
     HTTP: THTTPSend;
  {$ELSE}
     Nota: NfeInutilizacao;
     Rio: THTTPRIO;
  {$ENDIF}
begin
  Result := inherited Executar;

  {$IFDEF ACBrNFeOpenSSL}
     Acao := TStringList.Create;
     Stream := TMemoryStream.Create;
     Texto := '<?xml version="1.0" encoding="utf-8"?>';
     Texto := Texto + '<soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">';
     Texto := Texto + '  <soap:Body>';
     Texto := Texto + '    <nfeInutilizacaoNF xmlns="http://www.portalfiscal.inf.br/nfe/wsdl/NfeInutilizacao">';
     Texto := Texto + '      <nfeCabecMsg>';

     Texto := Texto + NotaUtil.ParseText(FCabMsg,False);

     Texto := Texto + '      </nfeCabecMsg>';
     Texto := Texto + '      <nfeDadosMsg>';

     Texto := Texto + NotaUtil.ParseText(FDadosMsg,False);

     Texto := Texto + '      </nfeDadosMsg>';
     Texto := Texto + '    </nfeInutilizacaoNF>';
     Texto := Texto + '  </soap:Body>';
     Texto := Texto + '</soap:Envelope>';
     Acao.Text := Texto;

     Acao.SaveToStream(Stream);

     HTTP := THTTPSend.Create;
  {$ELSE}
     Rio := THTTPRIO.Create(nil);
     ConfiguraRio(Rio);
  {$ENDIF}
  try
    TACBrNFe( FACBrNFe ).SetStatus( stNfeInutilizacao );
    if FConfiguracoes.Geral.Salvar then
      FConfiguracoes.Geral.Save(FormatDateTime('yyyymmddhhnnss',Now)+FNFeChave+'-ped-inu.xml', FDadosMsg);

    {$IFDEF ACBrNFeOpenSSL}
       HTTP.Document.LoadFromStream(Stream);
       ConfiguraHTTP(HTTP,'SOAPAction: "http://www.portalfiscal.inf.br/nfe/wsdl/NfeInutilizacao/nfeInutilizacaoNF"');
       HTTP.HTTPMethod('POST', FURL);

       StrStream := TStringStream.Create('');
       StrStream.CopyFrom(HTTP.Document, 0);
       FRetWS := NotaUtil.SeparaDados( NotaUtil.ParseText(StrStream.DataString, True),'nfeInutilizacaoNFResult');
       StrStream.Free;
    {$ELSE}
       Nota   := GetNfeInutilizacao(False, FURL, Rio);
       FRetWS := Nota.nfeInutilizacaoNF(FCabMsg, FDadosMsg);
    {$ENDIF}

    NFeRetorno := TRetInutNFe.Create;
    NFeRetorno.Leitor.Arquivo := FRetWS;
    NFeRetorno.LerXml;

    TACBrNFe( FACBrNFe ).SetStatus( stIdle );
    if FConfiguracoes.WebServices.Visualizar then
    begin
      ShowMessage('Ambiente : '+TpAmbToStr(NFeRetorno.TpAmb)+LineBreak+
                  'Versão Aplicativo : '+NFeRetorno.verAplic+LineBreak+
                  'Status Código : '+IntToStr(NFeRetorno.cStat)+LineBreak+
                  'Status Descrição : '+NFeRetorno.xMotivo+LineBreak+
                  'UF : '+CodigoParaUF(NFeRetorno.cUF)+LineBreak+
                  'Recebimento : '+DateTimeToStr(NFeRetorno.dhRecbto));
    end;
    FTpAmb    := NFeRetorno.TpAmb;
    FverAplic := NFeRetorno.verAplic;
    FcStat    := NFeRetorno.cStat;
    FxMotivo  := NFeRetorno.xMotivo;
    FcUF      := NFeRetorno.cUF ;
    FdhRecbto := NFeRetorno.dhRecbto;
    Fprotocolo:= NFeRetorno.nProt;
    FMsg   := NFeRetorno.XMotivo;
    Result := (NFeRetorno.cStat = 102);
    NFeRetorno.Free;

    if FConfiguracoes.Geral.Salvar then
      FConfiguracoes.Geral.Save(FormatDateTime('yyyymmddhhnnss',Now)+FNFeChave+'-inu.xml', FRetWS);
  finally
    {$IFDEF ACBrNFeOpenSSL}
       HTTP.Free;
       Acao.Free;
       Stream.Free;
    {$ELSE}
//       Rio.Free;
    {$ENDIF}
    NotaUtil.ConfAmbiente;
    TACBrNFe( FACBrNFe ).SetStatus( stIdle );
  end;
end;

procedure TNFeInutilizacao.SetJustificativa(AValue: WideString);
begin
  if NotaUtil.EstaVazio(AValue) then
    raise Exception.Create('Informar uma Justificativa para Inutilização de numeração da Nota Fiscal Eletronica')
  else
    AValue := NotaUtil.TrataString(AValue);    

  if Length(Trim(AValue)) < 15 then
   raise Exception.Create('A Justificativa para Inutilização de numeração da Nota Fiscal Eletronica deve ter no minimo 15 caracteres')
  else
    FJustificativa := Trim(AValue);
end;

{ TNFeConsultaCadastro }
function TNFeConsultaCadastro.Executar: Boolean;
var
  {$IFDEF ACBrNFeOpenSSL}
     Texto : String;
     Acao  : TStringList ;
     Stream: TMemoryStream;
     StrStream: TStringStream;
     HTTP: THTTPSend;
  {$ELSE}
     Nota: CadConsultaCadastro;
     Rio: THTTPRIO;
  {$ENDIF}
begin
  Result := inherited Executar;

  {$IFDEF ACBrNFeOpenSSL}
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

     HTTP := THTTPSend.Create;
  {$ELSE}
     Rio := THTTPRIO.Create(nil);
     ConfiguraRio(Rio);
  {$ENDIF}
  try
    TACBrNFe( FACBrNFe ).SetStatus( stNFeCadastro );
    if FConfiguracoes.Geral.Salvar then
      FConfiguracoes.Geral.Save(FormatDateTime('yyyymmddhhnnss',Now)+'-ped-cad.xml', FDadosMsg);

    {$IFDEF ACBrNFeOpenSSL}
       HTTP.Document.LoadFromStream(Stream);
       ConfiguraHTTP(HTTP,'SOAPAction: "http://www.portalfiscal.inf.br/nfe/wsdl/CadConsultaCadastro/consultaCadastro"');
       HTTP.HTTPMethod('POST', FURL);

       StrStream := TStringStream.Create('');
       StrStream.CopyFrom(HTTP.Document, 0);
       FRetWS := NotaUtil.SeparaDados( NotaUtil.ParseText(StrStream.DataString, True),'consultaCadastroResult');
       StrStream.Free;
    {$ELSE}
       Nota   := GetCadConsultaCadastro(False, FURL, Rio);
       FRetWS := Nota.consultaCadastro(FCabMsg, FDadosMsg);
    {$ENDIF}

    if assigned(FRetConsCad) then
       FRetConsCad.Free;
    FRetConsCad := TRetConsCad.Create;
    FRetConsCad.Leitor.Arquivo := FRetWS;
    FRetConsCad.LerXml;

    TACBrNFe( FACBrNFe ).SetStatus( stIdle );
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
//    FRetConsCad.Free;

    if FConfiguracoes.Geral.Salvar then
      FConfiguracoes.Geral.Save(FormatDateTime('yyyymmddhhnnss',Now)+'-cad.xml', FRetWS);
  finally
    {$IFDEF ACBrNFeOpenSSL}
       HTTP.Free;
       Acao.Free;
       Stream.Free;
    {$ELSE}
//       Rio.Free;
    {$ENDIF}
    NotaUtil.ConfAmbiente;
    TACBrNFe( FACBrNFe ).SetStatus( stIdle );
  end;
end;


end.
