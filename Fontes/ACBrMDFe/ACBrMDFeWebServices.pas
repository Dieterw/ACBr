{******************************************************************************}
{ Projeto: Componente ACBrMDFe                                                 }
{  Biblioteca multiplataforma de componentes Delphi                            }
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
|* 01/08/2012: Italo Jurisato Junior
|*  - Doação do componente para o Projeto ACBr
******************************************************************************}

{$I ACBr.inc}

unit ACBrMDFeWebServices;

interface

uses
  Classes, SysUtils,
  {$IFDEF VCL} Dialogs, {$ELSE} QDialogs, {$ENDIF}
  {$IFDEF ACBrMDFeOpenSSL}
    HTTPSend,
  {$ELSE}
     SOAPHTTPTrans, WinInet, ACBrCAPICOM_TLB,
     {SoapHTTPClient, }SOAPConst,{ JwaWinCrypt,}
  {$ENDIF}
  pcnAuxiliar, pcnConversao,
  ACBrMDFeConfiguracoes, ACBrMDFeManifestos,
  pmdfeRetConsReciMDFe, pmdfeProcMDFe, pmdfeConsReciMDFe,
  pmdfeEnvEventoMDFe, pmdfeRetEnvEventoMDFe,
  pmdfeRetEnvMDFe, ActiveX;

type

  TWebServicesBase = Class
  private
  	procedure DoMDFeStatusServico;
    procedure DoMDFeConsulta;
    procedure DoMDFeRecepcao;
    procedure DoMDFeRetRecepcao;
    procedure DoMDFeRecibo;
    procedure DoMDFeEnvEvento;

    {$IFDEF ACBrMDFeOpenSSL}
       procedure ConfiguraHTTP( HTTP : THTTPSend; Action : AnsiString);
    {$ELSE}
       procedure ConfiguraReqResp( ReqResp : THTTPReqResp);
       procedure OnBeforePost(const HTTPReqResp: THTTPReqResp; Data:Pointer);
    {$ENDIF}
  protected
    FCabMsg: AnsiString;
    FDadosMsg: AnsiString;
    FRetornoWS: AnsiString;
    FRetWS: AnsiString;
    FMsg: AnsiString;
    FURL: WideString;
    FConfiguracoes: TConfiguracoes;
    FACBrMDFe : TComponent;
    FPathArqEnv: AnsiString;
    FPathArqResp: AnsiString;
    procedure LoadMsgEntrada;
    procedure LoadURL;
  public
    function Executar: Boolean;virtual;
    constructor Create(AOwner : TComponent); virtual;
    property CabMsg: AnsiString read FCabMsg;
    property DadosMsg: AnsiString read FDadosMsg;
    property RetornoWS: AnsiString read FRetornoWS;
    property RetWS: AnsiString read FRetWS;
    property Msg: AnsiString read FMsg;
    property PathArqEnv: AnsiString read FPathArqEnv;
    property PathArqResp: AnsiString read FPathArqResp;
  end;

  TMDFeStatusServico = Class(TWebServicesBase)
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

  TMDFeRecepcao = Class(TWebServicesBase)
  private
    FLote: Integer;
    FRecibo : String;
    FMDFes : TManifestos;
    FTpAmb: TpcnTipoAmbiente;
    FverAplic: String;
    FcStat: Integer;
    FcUF : Integer;
    FxMotivo: String;
    FdhRecbto: TDateTime;
    FTMed: Integer;
    function GetLote: Integer;
  public
    function Executar: Boolean; override;
    constructor Create(AOwner : TComponent; AMDFes : TManifestos);reintroduce;
    property Recibo: String read FRecibo;
    property TpAmb: TpcnTipoAmbiente read FTpAmb;
    property verAplic: String read FverAplic;
    property cStat: Integer read FcStat;
    property cUF: Integer read FcUF;
    property xMotivo: String read FxMotivo;
    property dhRecbto: TDateTime read FdhRecbto;
    property TMed: Integer read FTMed;
    property Lote: Integer read GetLote write FLote;
  end;

  TMDFeRetRecepcao = Class(TWebServicesBase)
  private
    FRecibo: String;
    FProtocolo: String;
    FChaveMDFe: String;
    FMDFes: TManifestos;
    FMDFeRetorno: TRetConsReciMDFe;
    FTpAmb: TpcnTipoAmbiente;
    FverAplic: String;
    FcStat: Integer;
    FcUF: Integer;
    FxMotivo: String;
    FcMsg: Integer;
    FxMsg: String;
    function Confirma(AInfProt: TProtMDFeCollection): Boolean;
  public
    function Executar: Boolean; override;
    constructor Create(AOwner : TComponent; AManifestos : TManifestos);reintroduce;
    destructor destroy; override;
    property TpAmb: TpcnTipoAmbiente read FTpAmb;
    property verAplic: String read FverAplic;
    property cStat: Integer read FcStat;
    property cUF: Integer read FcUF;
    property xMotivo: String read FxMotivo;
    property cMsg: Integer read FcMsg;
    property xMsg: String read FxMsg;
    property Recibo: String read FRecibo write FRecibo;
    property Protocolo: String read FProtocolo write FProtocolo;
    property ChaveMDFe: String read FChaveMDFe write FChaveMDFe;
    property MDFeRetorno: TRetConsReciMDFe read FMDFeRetorno write FMDFeRetorno;
  end;

  TMDFeRecibo = Class(TWebServicesBase)
  private
    FRecibo: String;
    FMDFeRetorno: TRetConsReciMDFe;
    FTpAmb: TpcnTipoAmbiente;
    FverAplic: String;
    FcStat: Integer;
    FxMotivo: String;
    FcUF: Integer;
    FxMsg: String;
    FcMsg: Integer;
  public
    function Executar: Boolean; override;
    constructor Create(AOwner : TComponent);reintroduce;
    destructor destroy; override;
    property TpAmb: TpcnTipoAmbiente read FTpAmb;
    property verAplic: String read FverAplic;
    property cStat: Integer read FcStat;
    property xMotivo: String read FxMotivo;
    property cUF: Integer read FcUF;
    property xMsg: String read FxMsg;
    property cMsg: Integer read FcMsg;
    property Recibo: String read FRecibo write FRecibo;
    property MDFeRetorno: TRetConsReciMDFe read FMDFeRetorno write FMDFeRetorno;
  end;

  TMDFeConsulta = Class(TWebServicesBase)
  private
    FMDFeChave: WideString;
    FProtocolo: WideString;
    FDhRecbto: TDateTime;
    FXMotivo: WideString;
    FTpAmb : TpcnTipoAmbiente;
    FverAplic : String;
    FcStat : Integer;
    FcUF : Integer;
    FdigVal : String;
    FprotMDFe: TProcMDFe;
  public
    constructor Create(AOwner : TComponent); reintroduce;
    destructor Destroy; override;

    function Executar: Boolean;override;
    property MDFeChave: WideString read FMDFeChave write FMDFeChave;
    property Protocolo: WideString read FProtocolo write FProtocolo;
    property DhRecbto: TDateTime read FDhRecbto write FDhRecbto;
    property XMotivo: WideString read FXMotivo write FXMotivo;
    property TpAmb: TpcnTipoAmbiente read FTpAmb;
    property verAplic: String read FverAplic;
    property cStat: Integer read FcStat;
    property cUF: Integer read FcUF;
    property digVal: String read FdigVal;
    property protMDFe: TProcMDFe read FprotMDFe write FprotMDFe;
  end;

  TMDFeEnvEvento = Class(TWebServicesBase)
  private
    FidLote: Integer;
    Fversao: String;
    FEvento: TEventoMDFe;
    FcStat: Integer;
    FxMotivo: String;
    FTpAmb: TpcnTipoAmbiente;
    FEventoRetorno: TRetEventoMDFe;
  public
    constructor Create(AOwner : TComponent; AEvento : TEventoMDFe);reintroduce;
    destructor Destroy; override;
    function Executar: Boolean; override;

    property idLote: Integer               read FidLote      write FidLote;
    property versao: String                read Fversao      write Fversao;
    property cStat: Integer                read FcStat;
    property xMotivo: String               read FxMotivo;
    property TpAmb: TpcnTipoAmbiente       read FTpAmb;
    property EventoRetorno: TRetEventoMDFe  read FEventoRetorno;
  end;

  TWebServices = Class(TWebServicesBase)
  private
    FACBrMDFe : TComponent;
    FStatusServico: TMDFeStatusServico;
    FEnviar: TMDFeRecepcao;
    FRetorno: TMDFeRetRecepcao;
    FRecibo: TMDFeRecibo;
    FConsulta: TMDFeConsulta;
    FEnvEvento: TMDFeEnvEvento;
  public
    constructor Create(AFMDFe: TComponent);reintroduce;
    destructor Destroy; override;
    function Envia(ALote: Integer): Boolean;
//  published
    property ACBrMDFe: TComponent read FACBrMDFe write FACBrMDFe;
    property StatusServico: TMDFeStatusServico read FStatusServico write FStatusServico;
    property Enviar: TMDFeRecepcao read FEnviar write FEnviar;
    property Retorno: TMDFeRetRecepcao read FRetorno write FRetorno;
    property Recibo: TMDFeRecibo read FRecibo write FRecibo;
    property Consulta: TMDFeConsulta read FConsulta write FConsulta;
    property EnvEvento: TMDFeEnvEvento read FEnvEvento write FEnvEvento;
  end;

implementation

uses
{$IFDEF ACBrMDFeOpenSSL}
  ssl_openssl,
{$ENDIF}
  ACBrUtil, ACBrDFeUtil, ACBrMDFeUtil, ACBrMDFe,
  pcnGerador, pcnCabecalho, pcnLeitor,
  pmdfeConsStatServ, pmdfeRetConsStatServ,
  pmdfeConsSitMDFe, pmdfeRetConsSitMDFe;

{$IFNDEF ACBrMDFeOpenSSL}
const
  INTERNET_OPTION_CLIENT_CERT_CONTEXT = 84;
{$ENDIF}

{ TWebServicesBase }
constructor TWebServicesBase.Create(AOwner: TComponent);
begin
  FConfiguracoes := TConfiguracoes( TACBrMDFe( AOwner ).Configuracoes );
  FACBrMDFe      := TACBrMDFe( AOwner );
end;

{$IFDEF ACBrMDFeOpenSSL}
procedure TWebServicesBase.ConfiguraHTTP( HTTP : THTTPSend; Action : AnsiString);
begin
  if FileExists(FConfiguracoes.Certificados.Certificado) then
    HTTP.Sock.SSL.PFXfile := FConfiguracoes.Certificados.Certificado
  else
    HTTP.Sock.SSL.PFX     := FConfiguracoes.Certificados.Certificado;

  HTTP.Sock.SSL.KeyPassword := FConfiguracoes.Certificados.Senha;

  HTTP.ProxyHost := FConfiguracoes.WebServices.ProxyHost;
  HTTP.ProxyPort := FConfiguracoes.WebServices.ProxyPort;
  HTTP.ProxyUser := FConfiguracoes.WebServices.ProxyUser;
  HTTP.ProxyPass := FConfiguracoes.WebServices.ProxyPass;

//  HTTP.Sock.RaiseExcept := True;

  HTTP.MimeType  := 'text/xml; charset=utf-8';
  HTTP.UserAgent := '';
  HTTP.Protocol  := '1.1';

  HTTP.AddPortNumberToHost := False;
  HTTP.Headers.Add(Action);
end;

{$ELSE}
procedure TWebServicesBase.ConfiguraReqResp( ReqResp : THTTPReqResp);
begin
  if FConfiguracoes.WebServices.ProxyHost <> '' then
   begin
     ReqResp.Proxy    := FConfiguracoes.WebServices.ProxyHost+':'+FConfiguracoes.WebServices.ProxyPort;
     ReqResp.UserName := FConfiguracoes.WebServices.ProxyUser;
     ReqResp.Password := FConfiguracoes.WebServices.ProxyPass;
   end;
  ReqResp.OnBeforePost := OnBeforePost;
end;

procedure TWebServicesBase.OnBeforePost(const HTTPReqResp: THTTPReqResp;
  Data: Pointer);
var
  Cert         : ICertificate2;
  CertContext  : ICertContext;
  PCertContext : Pointer;
  ContentHeader: string;
begin
  Cert        := FConfiguracoes.Certificados.GetCertificado;
  CertContext := Cert as ICertContext;
  CertContext.Get_CertContext(Integer(PCertContext));

  if not InternetSetOption(Data, INTERNET_OPTION_CLIENT_CERT_CONTEXT, PCertContext,SizeOf(CertContext)*5) then
   begin
     if Assigned(TACBrMDFe( FACBrMDFe ).OnGerarLog) then
        TACBrMDFe( FACBrMDFe ).OnGerarLog('ERRO: Erro OnBeforePost: ' + IntToStr(GetLastError));
     raise Exception.Create( 'Erro OnBeforePost: ' + IntToStr(GetLastError) );
   end;

   if trim(FConfiguracoes.WebServices.ProxyUser) <> '' then begin
     if not InternetSetOption(Data, INTERNET_OPTION_PROXY_USERNAME, PChar(FConfiguracoes.WebServices.ProxyUser), Length(FConfiguracoes.WebServices.ProxyUser)) then
       raise Exception.Create( 'Erro OnBeforePost: ' + IntToStr(GetLastError) );
   end;
   if trim(FConfiguracoes.WebServices.ProxyPass) <> '' then begin
     if not InternetSetOption(Data, INTERNET_OPTION_PROXY_PASSWORD, PChar(FConfiguracoes.WebServices.ProxyPass),Length (FConfiguracoes.WebServices.ProxyPass)) then
       raise Exception.Create( 'Erro OnBeforePost: ' + IntToStr(GetLastError) );
   end;

  ContentHeader := Format(ContentTypeTemplate, ['application/soap+xml; charset=utf-8']);
  HttpAddRequestHeaders(Data, PChar(ContentHeader), Length(ContentHeader), HTTP_ADDREQ_FLAG_REPLACE);
end;
{$ENDIF}

procedure TWebServicesBase.DoMDFeConsulta;
var
  ConsSitMDFe : TConsSitMDFe;
begin
  ConsSitMDFe        := TConsSitMDFe.Create;
  ConsSitMDFe.TpAmb  := TpcnTipoAmbiente(FConfiguracoes.WebServices.AmbienteCodigo-1);
  ConsSitMDFe.chMDFe := TMDFeConsulta(Self).MDFeChave;

  ConsSitMDFe.GerarXML;

  FDadosMsg := ConsSitMDFe.Gerador.ArquivoFormatoXML;
  ConsSitMDFe.Free;

//  FDadosMsg := StringReplace( FDadosMsg, '<'+ENCODING_UTF8_STD+'>', '', [rfReplaceAll] ) ;
//  FDadosMsg := StringReplace( FDadosMsg, '<'+ENCODING_UTF8+'>', '', [rfReplaceAll] ) ;
//  FDadosMsg := StringReplace( FDadosMsg, '<?xml version="1.0"?>', '', [rfReplaceAll] ) ;
end;

procedure TWebServicesBase.DoMDFeRecepcao;
var
  i    : Integer;
  vMDFes: WideString;
begin
  vMDFes := '';
  for i := 0 to TMDFeRecepcao(Self).FMDFes.Count-1 do
    vMDFes := vMDFes + TMDFeRecepcao(Self).FMDFes.Items[I].XML;

  vMDFes := StringReplace( vMDFes, '<?xml version="1.0" encoding="UTF-8" ?>', '', [rfReplaceAll] );
  vMDFes := StringReplace( vMDFes, '<?xml version="1.0" encoding="UTF-8"?>' , '', [rfReplaceAll] );

  FDadosMsg := '<enviMDFe xmlns="http://www.portalfiscal.inf.br/mdfe" versao="' + MDFeenviMDFe + '">' +
               '<idLote>' + IntToStr(TMDFeRecepcao(Self).Lote) + '</idLote>' + vMDFes + '</enviMDFe>';

  if Length(FDadosMsg) > (500 * 1024) then
   begin
      if Assigned(TACBrMDFe(Self.FACBrMDFe).OnGerarLog) then
         TACBrMDFe(Self.FACBrMDFe).OnGerarLog('ERRO: Tamanho do XML de Dados superior a 500 Kbytes. Tamanho atual: '+FloatToStr(Int(Length(FDadosMsg)/500))+' Kbytes');
      raise Exception.Create('ERRO: Tamanho do XML de Dados superior a 500 Kbytes. Tamanho atual: '+FloatToStr(Int(Length(FDadosMsg)/500))+' Kbytes');
      exit;
   end;
end;

procedure TWebServicesBase.DoMDFeRetRecepcao;
var
  ConsReciMDFe: TConsReciMDFe;
begin
  ConsReciMDFe       := TConsReciMDFe.Create;
  ConsReciMDFe.tpAmb := TpcnTipoAmbiente(FConfiguracoes.WebServices.AmbienteCodigo-1);
  ConsReciMDFe.nRec  := TMDFeRetRecepcao(Self).Recibo;

  ConsReciMDFe.GerarXML;

  FDadosMsg := ConsReciMDFe.Gerador.ArquivoFormatoXML;
  ConsReciMDFe.Free;

//  FDadosMsg := StringReplace( FDadosMsg, '<'+ENCODING_UTF8_STD+'>', '', [rfReplaceAll] ) ;
//  FDadosMsg := StringReplace( FDadosMsg, '<'+ENCODING_UTF8+'>', '', [rfReplaceAll] ) ;
//  FDadosMsg := StringReplace( FDadosMsg, '<?xml version="1.0"?>', '', [rfReplaceAll] ) ;
end;

procedure TWebServicesBase.DoMDFeRecibo;
var
  Cabecalho: TCabecalho;
  ConsReciMDFe: TConsReciMDFe;
begin
  Cabecalho             := TCabecalho.Create;
  Cabecalho.Versao      := MDFecabMsg;
  Cabecalho.VersaoDados := MDFeconsReciMDFe;

  Cabecalho.GerarXML;

  FCabMsg := Cabecalho.Gerador.ArquivoFormatoXML;
  Cabecalho.Free;

  ConsReciMDFe       := TConsReciMDFe.Create;
  ConsReciMDFe.tpAmb := TpcnTipoAmbiente(FConfiguracoes.WebServices.AmbienteCodigo-1);
  ConsReciMDFe.nRec  := TMDFeRecibo(Self).Recibo;

  ConsReciMDFe.GerarXML;

  FDadosMsg := ConsReciMDFe.Gerador.ArquivoFormatoXML;
  ConsReciMDFe.Free;
end;

procedure TWebServicesBase.DoMDFeStatusServico;
var
  ConsStatServ: TConsStatServ;
begin
  ConsStatServ       := TConsStatServ.create;
  ConsStatServ.TpAmb := TpcnTipoAmbiente(FConfiguracoes.WebServices.AmbienteCodigo-1);
  ConsStatServ.CUF   := FConfiguracoes.WebServices.UFCodigo;

  ConsStatServ.GerarXML;

  FDadosMsg := ConsStatServ.Gerador.ArquivoFormatoXML;
  ConsStatServ.Free;

//  FDadosMsg := StringReplace( FDadosMsg, '<'+ENCODING_UTF8_STD+'>', '', [rfReplaceAll] ) ;
//  FDadosMsg := StringReplace( FDadosMsg, '<'+ENCODING_UTF8+'>', '', [rfReplaceAll] ) ;
//  FDadosMsg := StringReplace( FDadosMsg, '<?xml version="1.0"?>', '', [rfReplaceAll] ) ;
end;

procedure TWebServicesBase.DoMDFeEnvEvento;
var
  EventoMDFe : TEventoMDFe;
  i : integer;
begin
  EventoMDFe        := TEventoMDFe.Create;
  EventoMDFe.idLote := TMDFeEnvEvento(Self).idLote;

  for i := 0 to TMDFeEnvEvento(Self).FEvento.Evento.Count-1 do
   begin
     with EventoMDFe.Evento.Add do
      begin
        infEvento.tpAmb      := TpcnTipoAmbiente(FConfiguracoes.WebServices.AmbienteCodigo-1);
        infEvento.CNPJ       := TMDFeEnvEvento(Self).FEvento.Evento[i].InfEvento.CNPJ;
        infEvento.chMDFe     := TMDFeEnvEvento(Self).FEvento.Evento[i].InfEvento.chMDFe;
        infEvento.dhEvento   := TMDFeEnvEvento(Self).FEvento.Evento[i].InfEvento.dhEvento;
        infEvento.tpEvento   := TMDFeEnvEvento(Self).FEvento.Evento[i].InfEvento.tpEvento;
        infEvento.nSeqEvento := TMDFeEnvEvento(Self).FEvento.Evento[i].InfEvento.nSeqEvento;

        case InfEvento.tpEvento of
          teCancelamento:
          begin
            infEvento.detEvento.nProt := TMDFeEnvEvento(Self).FEvento.Evento[i].InfEvento.detEvento.nProt;
            infEvento.detEvento.xJust := TMDFeEnvEvento(Self).FEvento.Evento[i].InfEvento.detEvento.xJust;
          end;
          teEncerramento:
          begin
            infEvento.detEvento.nProt := TMDFeEnvEvento(Self).FEvento.Evento[i].InfEvento.detEvento.nProt;
            infEvento.detEvento.dtEnc := TMDFeEnvEvento(Self).FEvento.Evento[i].InfEvento.detEvento.dtEnc;
            infEvento.detEvento.cUF   := TMDFeEnvEvento(Self).FEvento.Evento[i].InfEvento.detEvento.cUF;
            infEvento.detEvento.cMun  := TMDFeEnvEvento(Self).FEvento.Evento[i].InfEvento.detEvento.cMun;
          end;
        end;
      end;
   end;

  EventoMDFe.GerarXML;

  {$IFDEF ACBrMDFeOpenSSL}
  if not(NotaUtil.Assinar(EventoMDFe.Gerador.ArquivoFormatoXML, TConfiguracoes(FConfiguracoes).Certificados.Certificado , TConfiguracoes(FConfiguracoes).Certificados.Senha, FDadosMsg, FMsg)) then
     begin
       if Assigned(TACBrMDFe( FACBrMDFe ).OnGerarLog) then
          TACBrMDFe( FACBrMDFe ).OnGerarLog('Falha ao assinar o Envio de Evento '+LineBreak+FMsg);
       raise EACBrMDFeException.Create('Falha ao assinar o Envio de Evento '+LineBreak+FMsg);
     end;
  {$ELSE}
  if not(MDFeUtil.Assinar(EventoMDFe.Gerador.ArquivoFormatoXML, TConfiguracoes(FConfiguracoes).Certificados.GetCertificado , FDadosMsg, FMsg)) then
     begin
       if Assigned(TACBrMDFe( FACBrMDFe ).OnGerarLog) then
          TACBrMDFe( FACBrMDFe ).OnGerarLog('Falha ao assinar o Envio de Evento '+LineBreak+FMsg);
       raise EACBrMDFeException.Create('Falha ao assinar o Envio de Evento '+LineBreak+FMsg);
     end;
  {$ENDIF}

  if not(MDFeUtil.Valida(FDadosMsg, FMsg, TACBrMDFe( FACBrMDFe ).Configuracoes.Geral.PathSchemas)) then
     begin
       if Assigned(TACBrMDFe( FACBrMDFe ).OnGerarLog) then
          TACBrMDFe( FACBrMDFe ).OnGerarLog('Falha na validação dos dados do Envio de Evento '+LineBreak+FMsg);
       raise EACBrMDFeException.Create('Falha na validação dos dados do Envio de Evento '+LineBreak+FMsg);
     end;

  for i := 0 to TMDFeEnvEvento(Self).FEvento.Evento.Count-1 do
   begin
      TMDFeEnvEvento(Self).FEvento.Evento[i].InfEvento.id := EventoMDFe.Evento[i].InfEvento.id;
   end;
  EventoMDFe.Free;

  FDadosMsg := StringReplace( FDadosMsg, '<'+ENCODING_UTF8_STD+'>', '', [rfReplaceAll] ) ;
  FDadosMsg := StringReplace( FDadosMsg, '<'+ENCODING_UTF8+'>', '', [rfReplaceAll] ) ;
  FDadosMsg := StringReplace( FDadosMsg, '<?xml version="1.0"?>', '', [rfReplaceAll] ) ;
end;

function TWebServicesBase.Executar: Boolean;
begin
  Result := False;
  LoadMsgEntrada;
  LoadURL;
end;

procedure TWebServicesBase.LoadMsgEntrada;
begin
  if self is TMDFeStatusServico then
    DoMDFeStatusServico
  else if self is TMDFeRecepcao then
    DoMDFeRecepcao
  else if self is TMDFeRetRecepcao then
    DoMDFeRetRecepcao
  else if self is TMDFeRecibo then
    DoMDFeRecibo
  else if self is TMDFeConsulta then
    DoMDFeConsulta
  else if Self is TMDFeEnvEvento then
    DoMDFeEnvEvento
end;

procedure TWebServicesBase.LoadURL;
begin
  if self is TMDFeStatusServico then
    FURL := MDFeUtil.GetURL(FConfiguracoes.WebServices.UFCodigo, FConfiguracoes.WebServices.AmbienteCodigo, FConfiguracoes.Geral.FormaEmissaoCodigo, LayMDFeStatusServico)
  else if self is TMDFeRecepcao then
    FURL := MDFeUtil.GetURL(FConfiguracoes.WebServices.UFCodigo, FConfiguracoes.WebServices.AmbienteCodigo, FConfiguracoes.Geral.FormaEmissaoCodigo, LayMDFeRecepcao)
  else if (self is TMDFeRetRecepcao) or (self is TMDFeRecibo) then
    FURL := MDFeUtil.GetURL(FConfiguracoes.WebServices.UFCodigo, FConfiguracoes.WebServices.AmbienteCodigo, FConfiguracoes.Geral.FormaEmissaoCodigo, LayMDFeRetRecepcao)
  else if self is TMDFeConsulta then
    FURL := MDFeUtil.GetURL(FConfiguracoes.WebServices.UFCodigo, FConfiguracoes.WebServices.AmbienteCodigo, FConfiguracoes.Geral.FormaEmissaoCodigo, LayMDFeConsulta)
  else if self is TMDFeEnvEvento then
    FURL := MDFeUtil.GetURL(FConfiguracoes.WebServices.UFCodigo, FConfiguracoes.WebServices.AmbienteCodigo, FConfiguracoes.Geral.FormaEmissaoCodigo, LayMDFeEvento)
end;

{ TWebServices }
constructor TWebServices.Create(AFMDFe: TComponent);
begin
 inherited Create( AFMDFe );
  FACBrMDFe      := TACBrMDFe(AFMDFe);
  FStatusServico := TMDFeStatusServico.Create(AFMDFe);
  FEnviar        := TMDFeRecepcao.Create(AFMDFe, TACBrMDFe(AFMDFe).Manifestos);
  FRetorno       := TMDFeRetRecepcao.Create(AFMDFe, TACBrMDFe(AFMDFe).Manifestos);
  FRecibo        := TMDFeRecibo.create(AFMDFe);
  FConsulta      := TMDFeConsulta.Create(AFMDFe);
  FEnvEvento     := TMDFeEnvEvento.Create(AFMDFe,TACBrMDFe(AFMDFe).EventoMDFe);
end;

destructor TWebServices.Destroy;
begin
  FStatusServico.Free;
  FEnviar.Free;
  FRetorno.Free;
  FRecibo.Free;
  FConsulta.Free;
  FEnvEvento.Free;
  inherited;
end;

function TWebServices.Envia(ALote: Integer): Boolean;
begin
  self.Enviar.FLote := ALote;
  if not(Self.Enviar.Executar) then
     begin
       if Assigned(TACBrMDFe( FACBrMDFe ).OnGerarLog) then
          TACBrMDFe( FACBrMDFe ).OnGerarLog(Self.Enviar.Msg);
       raise Exception.Create(Self.Enviar.Msg);
     end;

  Self.Retorno.Recibo := Self.Enviar.Recibo;
  if not(Self.Retorno.Executar) then
     begin
       if Assigned(TACBrMDFe( FACBrMDFe ).OnGerarLog) then
          TACBrMDFe( FACBrMDFe ).OnGerarLog(Self.Retorno.Msg);
       raise Exception.Create(Self.Retorno.Msg);
     end;
  Result := true;
end;

{ TMDFeStatusServico }
function TMDFeStatusServico.Executar: Boolean;
var
  MDFeRetorno: TRetConsStatServ;
  aMsg  : string;
  Texto : String;
  Acao  : TStringList ;
  Stream: TMemoryStream;
  StrStream: TStringStream;

  {$IFDEF ACBrMDFeOpenSSL}
     HTTP: THTTPSend;
  {$ELSE}
     ReqResp: THTTPReqResp;
  {$ENDIF}
begin
  inherited Executar;

  Result := False;
  
  Acao   := TStringList.Create;
  Stream := TMemoryStream.Create;

  Texto := '<?xml version="1.0" encoding="utf-8"?>';
  Texto := Texto + '<soap12:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap12="http://www.w3.org/2003/05/soap-envelope">';
  Texto := Texto +   '<soap12:Header>';
  Texto := Texto +     '<mdfeCabecMsg xmlns="http://www.portalfiscal.inf.br/mdfe/wsdl/MDFeStatusServico">';
  Texto := Texto +       '<cUF>'+IntToStr(FConfiguracoes.WebServices.UFCodigo)+'</cUF>';
  Texto := Texto +       '<versaoDados>'+MDFeconsStatServ+'</versaoDados>';
  Texto := Texto +     '</mdfeCabecMsg>';
  Texto := Texto +   '</soap12:Header>';
  Texto := Texto +   '<soap12:Body>';
  Texto := Texto +     '<mdfeDadosMsg xmlns="http://www.portalfiscal.inf.br/mdfe/wsdl/MDFeStatusServico">';
  Texto := Texto + FDadosMsg;
  Texto := Texto +     '</mdfeDadosMsg>';
  Texto := Texto +   '</soap12:Body>';
  Texto := Texto + '</soap12:Envelope>';

  Acao.Text := Texto;

  {$IFDEF ACBrMDFeOpenSSL}
     Acao.SaveToStream(Stream);
     HTTP := THTTPSend.Create;
  {$ELSE}
     ReqResp := THTTPReqResp.Create(nil);
     ConfiguraReqResp( ReqResp );
     ReqResp.URL := Trim(FURL);
     ReqResp.UseUTF8InHeader := True;
     ReqResp.SoapAction := 'http://www.portalfiscal.inf.br/mdfe/wsdl/MDFeStatusServico/mdfeStatusServicoMDF';
  {$ENDIF}

  try
    TACBrMDFe( FACBrMDFe ).SetStatus( stMDFeStatusServico );
    if FConfiguracoes.Geral.Salvar then
      FConfiguracoes.Geral.Save(FormatDateTime('yyyymmddhhnnss',Now)+'-ped-sta.xml', FDadosMsg);

    try
      {$IFDEF ACBrMDFeOpenSSL}
         HTTP.Document.LoadFromStream(Stream);
         ConfiguraHTTP(HTTP,'SOAPAction: "http://www.portalfiscal.inf.br/mdfe/wsdl/MDFeStatusServico/mdfeStatusServicoMDF"');
         HTTP.HTTPMethod('POST', FURL);
         StrStream := TStringStream.Create('');
         StrStream.CopyFrom(HTTP.Document, 0);

         FRetornoWS := TiraAcentos(ParseText(StrStream.DataString, True));
         FRetWS := SeparaDados( FRetornoWS, 'mdfeStatusServicoMDFResult');
         StrStream.Free;
      {$ELSE}
         ReqResp.Execute(Acao.Text, Stream);
         StrStream := TStringStream.Create('');
         StrStream.CopyFrom(Stream, 0);
         FRetornoWS := TiraAcentos(ParseText(StrStream.DataString, True));
         FRetWS := SeparaDados( FRetornoWS, 'mdfeStatusServicoMDFResult');
         StrStream.Free;
      {$ENDIF}
      MDFeRetorno := TRetConsStatServ.Create;
      MDFeRetorno.Leitor.Arquivo := FRetWS;
      MDFeRetorno.LerXml;

      TACBrMDFe( FACBrMDFe ).SetStatus( stMDFeIdle );
      aMsg := 'Ambiente : '+TpAmbToStr(MDFeRetorno.tpAmb)+LineBreak+
              'Versão Aplicativo : '+MDFeRetorno.verAplic+LineBreak+
              'Status Código : '+IntToStr(MDFeRetorno.cStat)+LineBreak+
              'Status Descrição : '+MDFeRetorno.xMotivo+LineBreak+
              'UF : '+CodigoParaUF(MDFeRetorno.cUF)+LineBreak+
              'Recebimento : '+DFeUtil.SeSenao(MDFeRetorno.DhRecbto = 0, '', DateTimeToStr(MDFeRetorno.dhRecbto))+LineBreak+
              'Tempo Médio : '+IntToStr(MDFeRetorno.TMed)+LineBreak+
              'Retorno : '+ DFeUtil.SeSenao(MDFeRetorno.dhRetorno = 0, '', DateTimeToStr(MDFeRetorno.dhRetorno))+LineBreak+
              'Observação : '+MDFeRetorno.xObs;
      if FConfiguracoes.WebServices.Visualizar then
        ShowMessage(aMsg);

      if Assigned(TACBrMDFe( FACBrMDFe ).OnGerarLog) then
         TACBrMDFe( FACBrMDFe ).OnGerarLog(aMsg);

      FtpAmb     := MDFeRetorno.tpAmb;
      FverAplic  := MDFeRetorno.verAplic;
      FcStat     := MDFeRetorno.cStat;
      FxMotivo   := MDFeRetorno.xMotivo;
      FcUF       := MDFeRetorno.cUF;
      FdhRecbto  := MDFeRetorno.dhRecbto;
      FTMed      := MDFeRetorno.TMed;
      FdhRetorno := MDFeRetorno.dhRetorno;
      FxObs      := MDFeRetorno.xObs;

      if TACBrMDFe( FACBrMDFe ).Configuracoes.WebServices.AjustaAguardaConsultaRet then
         TACBrMDFe( FACBrMDFe ).Configuracoes.WebServices.AguardarConsultaRet := FTMed * 1000;

      FMsg   := MDFeRetorno.XMotivo + LineBreak+MDFeRetorno.XObs;

      Result := (MDFeRetorno.CStat = 107); // 107 = Serviço em Operação
      MDFeRetorno.Free;

      if FConfiguracoes.Geral.Salvar then
        FConfiguracoes.Geral.Save(FormatDateTime('yyyymmddhhnnss',Now)+'-sta.xml', FRetWS);

    except on E: Exception do
      begin
       if Assigned(TACBrMDFe( FACBrMDFe ).OnGerarLog) then
          TACBrMDFe( FACBrMDFe ).OnGerarLog('WebService Consulta Status serviço:'+LineBreak+
                                          '- Inativo ou Inoperante tente novamente.'+LineBreak+
                                          '- '+E.Message);
       raise Exception.Create('WebService Consulta Status serviço:'+LineBreak+
                              '- Inativo ou Inoperante tente novamente.'+LineBreak+
                              '- '+E.Message);
      end;
    end;

  finally
    {$IFDEF ACBrMDFeOpenSSL}
       HTTP.Free;
    {$ELSE}
      ReqResp.Free;
    {$ENDIF}
    Acao.Free;
    Stream.Free;
    DFeUtil.ConfAmbiente;
    TACBrMDFe( FACBrMDFe ).SetStatus( stMDFeIdle );
  end;
end;

{ TMDFeRecepcao }
constructor TMDFeRecepcao.Create(AOwner: TComponent; AMDFes: TManifestos);
begin
  inherited Create(AOwner);
  FMDFes := AMDFes;
end;

function TMDFeRecepcao.Executar: Boolean;
var
  MDFeRetorno: TretEnvMDFe;
  aMsg  : string;
  Texto : String;
  Acao  : TStringList ;
  Stream: TMemoryStream;
  StrStream: TStringStream;

  {$IFDEF ACBrMDFeOpenSSL}
     HTTP: THTTPSend;
  {$ELSE}
     ReqResp: THTTPReqResp;
  {$ENDIF}
begin
  inherited Executar;

  Result := False;
  Acao   := TStringList.Create;
  Stream := TMemoryStream.Create;

  Texto := '<?xml version="1.0" encoding="utf-8"?>';
  Texto := Texto + '<soap12:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap12="http://www.w3.org/2003/05/soap-envelope">';
  Texto := Texto +   '<soap12:Header>';
  Texto := Texto +     '<mdfeCabecMsg xmlns="http://www.portalfiscal.inf.br/mdfe/wsdl/MDFeRecepcao">';
  Texto := Texto +       '<cUF>'+IntToStr(FConfiguracoes.WebServices.UFCodigo)+'</cUF>';
  Texto := Texto +       '<versaoDados>'+MDFeenviMDFe+'</versaoDados>';
  Texto := Texto +     '</mdfeCabecMsg>';
  Texto := Texto +   '</soap12:Header>';
  Texto := Texto +   '<soap12:Body>';
  Texto := Texto +     '<mdfeDadosMsg xmlns="http://www.portalfiscal.inf.br/mdfe/wsdl/MDFeRecepcao">';
  Texto := Texto + FDadosMsg;
  Texto := Texto +     '</mdfeDadosMsg>';
  Texto := Texto +   '</soap12:Body>';
  Texto := Texto + '</soap12:Envelope>';

  Acao.Text := Texto;

  {$IFDEF ACBrMDFeOpenSSL}
     Acao.SaveToStream(Stream);
     HTTP := THTTPSend.Create;
  {$ELSE}
     ReqResp := THTTPReqResp.Create(nil);
     ConfiguraReqResp( ReqResp );
     ReqResp.URL := Trim(FURL);
     ReqResp.UseUTF8InHeader := True;
     ReqResp.SoapAction := 'http://www.portalfiscal.inf.br/mdfe/wsdl/MDFeRecepcao/mdfeRecepcaoLote';
  {$ENDIF}

  try
    TACBrMDFe( FACBrMDFe ).SetStatus( stMDFeRecepcao );
    if FConfiguracoes.Geral.Salvar then
      FConfiguracoes.Geral.Save(IntToStr(Lote)+'-env-lot.xml', FDadosMsg);

    try
      {$IFDEF ACBrMDFeOpenSSL}
         HTTP.Document.LoadFromStream(Stream);
         ConfiguraHTTP(HTTP,'SOAPAction: "http://www.portalfiscal.inf.br/mdfe/wsdl/MDFeRecepcao/mdfeRecepcaoLote"');
         HTTP.HTTPMethod('POST', FURL);

         StrStream := TStringStream.Create('');
         StrStream.CopyFrom(HTTP.Document, 0);
         FRetornoWS := TiraAcentos(ParseText(StrStream.DataString, True));
         FRetWS := SeparaDados( FRetornoWS, 'mdfeRecepcaoLoteResult');
         StrStream.Free;
      {$ELSE}
         ReqResp.Execute(Acao.Text, Stream);
         StrStream := TStringStream.Create('');
         StrStream.CopyFrom(Stream, 0);
         FRetornoWS := TiraAcentos(ParseText(StrStream.DataString, True));
         FRetWS := SeparaDados( FRetornoWS, 'mdfeRecepcaoLoteResult');
         StrStream.Free;
      {$ENDIF}
      MDFeRetorno := TretEnvMDFe.Create;
      MDFeRetorno.Leitor.Arquivo := FRetWS;
      MDFeRetorno.LerXml;

      TACBrMDFe( FACBrMDFe ).SetStatus( stMDFeIdle );
      aMsg := 'Ambiente : '+TpAmbToStr(MDFeRetorno.tpAmb)+LineBreak+
                      'Versão Aplicativo : '+MDFeRetorno.verAplic+LineBreak+
                      'Status Código : '+IntToStr(MDFeRetorno.cStat)+LineBreak+
                      'Status Descrição : '+MDFeRetorno.xMotivo+LineBreak+
                      'UF : '+CodigoParaUF(MDFeRetorno.cUF)+LineBreak+
                      'Recebimento : '+DFeUtil.SeSenao(MDFeRetorno.InfRec.dhRecbto = 0, '', DateTimeToStr(MDFeRetorno.InfRec.dhRecbto))+LineBreak+
                      'Tempo Médio : '+IntToStr(MDFeRetorno.infRec.tMed)+LineBreak+
                      'Número Recibo: '+MDFeRetorno.infRec.nRec;
      if FConfiguracoes.WebServices.Visualizar then
        ShowMessage(aMsg);

      if Assigned(TACBrMDFe( FACBrMDFe ).OnGerarLog) then
         TACBrMDFe( FACBrMDFe ).OnGerarLog(aMsg);

      FtpAmb    := MDFeRetorno.tpAmb;
      FverAplic := MDFeRetorno.verAplic;
      FcStat    := MDFeRetorno.cStat;
      FxMotivo  := MDFeRetorno.xMotivo;
      FcUF      := MDFeRetorno.cUF;
      FdhRecbto := MDFeRetorno.infRec.dhRecbto;
      FTMed     := MDFeRetorno.infRec.tMed;
      FRecibo   := MDFeRetorno.infRec.nRec;
      FMsg      := MDFeRetorno.XMotivo;

      Result := (MDFeRetorno.CStat = 103); // 103 = Lote Recebido

      MDFeRetorno.Free;

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
    {$IFDEF ACBrMDFeOpenSSL}
       HTTP.Free;
    {$ELSE}
      ReqResp.Free;
    {$ENDIF}
    Acao.Free;
    Stream.Free;
    DFeUtil.ConfAmbiente;
    TACBrMDFe( FACBrMDFe ).SetStatus( stMDFeIdle );
  end;
end;

function TMDFeRecepcao.GetLote: Integer;
begin
  Result := FLote;
end;

{ TMDFeRetRecepcao }
function TMDFeRetRecepcao.Confirma(AInfProt: TProtMDFeCollection): Boolean;
var
  i,j     : Integer;
  AProcMDFe: TProcMDFe;
begin
  Result := False;

  //Setando os retornos dos Manifestos;
  for i := 0 to AInfProt.Count-1 do
  begin
    for j := 0 to FMDFes.Count-1 do
    begin
      if AInfProt.Items[i].chMDFe = StringReplace(FMDFes.Items[j].MDFe.InfMDFe.Id,'MDFe','',[rfIgnoreCase]) then
       begin
         FMDFes.Items[j].Confirmada             := (AInfProt.Items[i].cStat = 100); // 100 = Autorizao o Uso
         FMDFes.Items[j].Msg                    := AInfProt.Items[i].xMotivo;
         FMDFes.Items[j].MDFe.procMDFe.tpAmb    := AInfProt.Items[i].tpAmb;
         FMDFes.Items[j].MDFe.procMDFe.verAplic := AInfProt.Items[i].verAplic;
         FMDFes.Items[j].MDFe.procMDFe.chMDFe   := AInfProt.Items[i].chMDFe;
         FMDFes.Items[j].MDFe.procMDFe.dhRecbto := AInfProt.Items[i].dhRecbto;
         FMDFes.Items[j].MDFe.procMDFe.nProt    := AInfProt.Items[i].nProt;
         FMDFes.Items[j].MDFe.procMDFe.digVal   := AInfProt.Items[i].digVal;
         FMDFes.Items[j].MDFe.procMDFe.cStat    := AInfProt.Items[i].cStat;
         FMDFes.Items[j].MDFe.procMDFe.xMotivo  := AInfProt.Items[i].xMotivo;

         if FConfiguracoes.Geral.Salvar or DFeUtil.NaoEstaVazio(FMDFes.Items[j].NomeArq) then
          begin
            if FileExists(PathWithDelim(FConfiguracoes.Geral.PathSalvar)+AInfProt.Items[i].chMDFe+'-mdfe.xml') and
               FileExists(PathWithDelim(FConfiguracoes.Geral.PathSalvar)+FMDFeRetorno.nRec+'-pro-rec.xml') then
             begin
               AProcMDFe := TProcMDFe.Create;
               AProcMDFe.PathMDFe := PathWithDelim(FConfiguracoes.Geral.PathSalvar)+AInfProt.Items[i].chMDFe+'-mdfe.xml';
               AProcMDFe.PathRetConsReciMDFe := PathWithDelim(FConfiguracoes.Geral.PathSalvar)+FMDFeRetorno.nRec+'-pro-rec.xml';

               AProcMDFe.GerarXML;

               if DFeUtil.NaoEstaVazio(AProcMDFe.Gerador.ArquivoFormatoXML) then
                begin
                  if DFeUtil.NaoEstaVazio(FMDFes.Items[j].NomeArq) then
                     AProcMDFe.Gerador.SalvarArquivo(FMDFes.Items[j].NomeArq)
                  else
                     AProcMDFe.Gerador.SalvarArquivo(PathWithDelim(FConfiguracoes.Geral.PathSalvar)+AInfProt.Items[i].chMDFe+'-mdfe.xml');
                end;
               AProcMDFe.Free;
             end;
          end;
         if FConfiguracoes.Arquivos.Salvar then
            if FConfiguracoes.Arquivos.EmissaoPathMDFe then
               FMDFes.Items[j].SaveToFile(PathWithDelim(FConfiguracoes.Arquivos.GetPathMDFe(FMDFes.Items[j].MDFe.Ide.dhEmi))+StringReplace(FMDFes.Items[j].MDFe.InfMDFe.Id,'MDFe','',[rfIgnoreCase])+'-mdfe.xml')
            else
               FMDFes.Items[j].SaveToFile(PathWithDelim(FConfiguracoes.Arquivos.GetPathMDFe)+StringReplace(FMDFes.Items[j].MDFe.InfMDFe.Id,'MDFe','',[rfIgnoreCase])+'-mdfe.xml');
         break;
       end;
    end;
  end;

  //Verificando se existe algum Manifesto confirmado
  for i := 0 to FMDFes.Count-1 do
  begin
    if FMDFes.Items[i].Confirmada then
    begin
      Result := True;
      break;
    end;
  end;

  //Verificando se existe algum Manifesto nao confirmado
  for i := 0 to FMDFes.Count-1 do
  begin
    if not(FMDFes.Items[i].Confirmada) then
    begin
      FMsg := 'Manifesto(s) não confirmado(s):'+LineBreak;
      break;
    end;
  end;

  //Montando a mensagem de retorno para os Manifestos nao confirmados
  for i := 0 to FMDFes.Count-1 do
  begin
    if not(FMDFes.Items[i].Confirmada) then
      FMsg := FMsg+IntToStr(FMDFes.Items[i].MDFe.Ide.nMDF)+'->'+FMDFes.Items[i].Msg+LineBreak;
  end;
end;

constructor TMDFeRetRecepcao.Create(AOwner: TComponent;
  AManifestos: TManifestos);
begin
  inherited Create(AOwner);
  FMDFes := AManifestos;
end;

destructor TMDFeRetRecepcao.destroy;
begin
   if assigned(FMDFeRetorno) then
      FMDFeRetorno.Free;
   inherited;
end;

function TMDFeRetRecepcao.Executar: Boolean;

 function Processando: Boolean;
 var
    aMsg  : string;
    Texto : String;
    Acao  : TStringList ;
    Stream: TMemoryStream;
    StrStream: TStringStream;
    {$IFDEF ACBrMDFeOpenSSL}
       HTTP: THTTPSend;
    {$ELSE}
       ReqResp: THTTPReqResp;
    {$ENDIF}
 begin
    Acao   := TStringList.Create;
    Stream := TMemoryStream.Create;

    Texto := '<?xml version="1.0" encoding="utf-8"?>';
    Texto := Texto + '<soap12:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap12="http://www.w3.org/2003/05/soap-envelope">';
    Texto := Texto +   '<soap12:Header>';
    Texto := Texto +     '<mdfeCabecMsg xmlns="http://www.portalfiscal.inf.br/mdfe/wsdl/MDFeRetRecepcao">';
    Texto := Texto +       '<cUF>'+IntToStr(FConfiguracoes.WebServices.UFCodigo)+'</cUF>';
    Texto := Texto +       '<versaoDados>'+MDFeconsReciMDFe+'</versaoDados>';
    Texto := Texto +     '</mdfeCabecMsg>';
    Texto := Texto +   '</soap12:Header>';
    Texto := Texto +   '<soap12:Body>';
    Texto := Texto +     '<mdfeDadosMsg xmlns="http://www.portalfiscal.inf.br/mdfe/wsdl/MDFeRetRecepcao">';
    Texto := Texto + FDadosMsg;
    Texto := Texto +     '</mdfeDadosMsg>';
    Texto := Texto +   '</soap12:Body>';
    Texto := Texto + '</soap12:Envelope>';

    Acao.Text := Texto;

    {$IFDEF ACBrMDFeOpenSSL}
       Acao.SaveToStream(Stream);
       HTTP := THTTPSend.Create;
    {$ELSE}
       ReqResp := THTTPReqResp.Create(nil);
       ConfiguraReqResp( ReqResp );
       ReqResp.URL := Trim(FURL);
       ReqResp.UseUTF8InHeader := True;
       ReqResp.SoapAction := 'http://www.portalfiscal.inf.br/mdfe/wsdl/MDFeRetRecepcao/mdfeRetRecepcao';
    {$ENDIF}

    try
      TACBrMDFe( FACBrMDFe ).SetStatus( stMDFeRetRecepcao );
      if assigned(FMDFeRetorno) then
         FMDFeRetorno.Free;

      if FConfiguracoes.Geral.Salvar then
        FConfiguracoes.Geral.Save(Recibo+'-ped-rec.xml', FDadosMsg);

      {$IFDEF ACBrMDFeOpenSSL}
         HTTP.Document.LoadFromStream(Stream);
         ConfiguraHTTP(HTTP,'SOAPAction: "http://www.portalfiscal.inf.br/mdfe/wsdl/MDFeRetRecepcao/mdfeRetRecepcao"');
         HTTP.HTTPMethod('POST', FURL);

         StrStream := TStringStream.Create('');
         StrStream.CopyFrom(HTTP.Document, 0);
         FRetornoWS := TiraAcentos(ParseText(StrStream.DataString, True));
         FRetWS := SeparaDados( FRetornoWS, 'mdfeRetRecepcaoResult');
         StrStream.Free;
      {$ELSE}
         ReqResp.Execute(Acao.Text, Stream);
         StrStream := TStringStream.Create('');
         StrStream.CopyFrom(Stream, 0);
         FRetornoWS := TiraAcentos(ParseText(StrStream.DataString, True));
         FRetWS := SeparaDados( FRetornoWS, 'mdfeRetRecepcaoResult');
         StrStream.Free;
      {$ENDIF}
      if FConfiguracoes.Geral.Salvar then
         FConfiguracoes.Geral.Save(Recibo+'-pro-rec.xml', FRetWS);

      FMDFeRetorno := TRetConsReciMDFe.Create;
      FMDFeRetorno.Leitor.Arquivo := FRetWS;
      FMDFeRetorno.LerXML;

      TACBrMDFe( FACBrMDFe ).SetStatus( stMDFeIdle );
      aMsg := 'Ambiente : '+TpAmbToStr(FMDFeRetorno.TpAmb)+LineBreak+
              'Versão Aplicativo : '+FMDFeRetorno.verAplic+LineBreak+
              'Recibo : '+FMDFeRetorno.nRec+LineBreak+
              'Status Código : '+IntToStr(FMDFeRetorno.cStat)+LineBreak+
              'Status Descrição : '+FMDFeRetorno.xMotivo+LineBreak+
              'UF : '+CodigoParaUF(FMDFeRetorno.cUF)+LineBreak;
      if FConfiguracoes.WebServices.Visualizar then
        ShowMessage(aMsg);

      if Assigned(TACBrMDFe( FACBrMDFe ).OnGerarLog) then
         TACBrMDFe( FACBrMDFe ).OnGerarLog(aMsg);

      FTpAmb    := FMDFeRetorno.TpAmb;
      FverAplic := FMDFeRetorno.verAplic;
      FcStat    := FMDFeRetorno.cStat;
      FcUF      := FMDFeRetorno.cUF;
      FMsg      := FMDFeRetorno.xMotivo;
      FxMotivo  := FMDFeRetorno.xMotivo;

      Result := FMDFeRetorno.CStat = 105; // 105 = Lote em Processamento
      if FMDFeRetorno.CStat = 104 then    // 104 = Lote Processado
      begin
         FMsg     := FMDFeRetorno.ProtMDFe.Items[0].xMotivo;
         FxMotivo := FMDFeRetorno.ProtMDFe.Items[0].xMotivo;
      end;

    finally
      {$IFDEF ACBrMDFeOpenSSL}
         HTTP.Free;
      {$ELSE}
         ReqResp.Free;
      {$ENDIF}
      Acao.Free;
      Stream.Free;
      DFeUtil.ConfAmbiente;
      TACBrMDFe( FACBrMDFe ).SetStatus( stMDFeIdle );
    end;
 end;

var
  vCont: Integer;
begin
  inherited Executar;
  Result := False;

  TACBrMDFe( FACBrMDFe ).SetStatus( stMDFeRetRecepcao );
  Sleep(TACBrMDFe( FACBrMDFe ).Configuracoes.WebServices.AguardarConsultaRet);
  vCont := 1000;
  while Processando do
  begin
    if TACBrMDFe( FACBrMDFe ).Configuracoes.WebServices.IntervaloTentativas > 0 then
       sleep(TACBrMDFe( FACBrMDFe ).Configuracoes.WebServices.IntervaloTentativas)
    else
       sleep(vCont);

    if vCont > (TACBrMDFe( FACBrMDFe ).Configuracoes.WebServices.Tentativas * 1000) then
      break;

    vCont := vCont + 1000;
  end;
  TACBrMDFe( FACBrMDFe ).SetStatus( stMDFeIdle );

  if FMDFeRetorno.CStat = 104 then  // 104 = Lote Processado
   begin
    Result     := Confirma(FMDFeRetorno.ProtMDFe);
    fChaveMDFe := FMDFeRetorno.ProtMDFe.Items[0].chMDFe;
    fProtocolo := FMDFeRetorno.ProtMDFe.Items[0].nProt;
    fcStat     := FMDFeRetorno.ProtMDFe.Items[0].cStat;
   end;
end;

{ TMDFeRecibo }

constructor TMDFeRecibo.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
end;

destructor TMDFeRecibo.destroy;
begin
   if assigned(FMDFeRetorno) then
      FMDFeRetorno.Free;
  inherited;
end;

function TMDFeRecibo.Executar: Boolean;
var
 aMsg  : string;
 Texto : String;
 Acao  : TStringList ;
 Stream: TMemoryStream;
 StrStream: TStringStream;
// MotivoAux : String;
 {$IFDEF ACBrMDFeOpenSSL}
    HTTP: THTTPSend;
 {$ELSE}
    ReqResp: THTTPReqResp;
 {$ENDIF}
begin
  if assigned(FMDFeRetorno) then
   FMDFeRetorno.Free;

  inherited Executar;

  Acao   := TStringList.Create;
  Stream := TMemoryStream.Create;

  Texto := '<?xml version="1.0" encoding="utf-8"?>';
  Texto := Texto + '<soap12:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap12="http://www.w3.org/2003/05/soap-envelope">';
  Texto := Texto +   '<soap12:Header>';
  Texto := Texto +     '<mdfeCabecMsg xmlns="http://www.portalfiscal.inf.br/mdfe/wsdl/MDFeRetRecepcao">';
  Texto := Texto +       '<cUF>'+IntToStr(FConfiguracoes.WebServices.UFCodigo)+'</cUF>';
  Texto := Texto +       '<versaoDados>'+MDFeconsReciMDFe+'</versaoDados>';
  Texto := Texto +     '</mdfeCabecMsg>';
  Texto := Texto +   '</soap12:Header>';
  Texto := Texto +   '<soap12:Body>';
  Texto := Texto +     '<mdfeDadosMsg xmlns="http://www.portalfiscal.inf.br/mdfe/wsdl/MDFeRetRecepcao">';
  Texto := Texto + FDadosMsg;
  Texto := Texto +     '</mdfeDadosMsg>';
  Texto := Texto +   '</soap12:Body>';
  Texto := Texto + '</soap12:Envelope>';

  Acao.Text := Texto;

  {$IFDEF ACBrMDFeOpenSSL}
    Acao.SaveToStream(Stream);
    HTTP := THTTPSend.Create;
  {$ELSE}
     ReqResp := THTTPReqResp.Create(nil);
     ConfiguraReqResp( ReqResp );
     ReqResp.URL := Trim(FURL);
     ReqResp.UseUTF8InHeader := True;
     ReqResp.SoapAction := 'http://www.portalfiscal.inf.br/mdfe/wsdl/MDFeRetRecepcao/mdfeRetRecepcao';
  {$ENDIF}

 FMDFeRetorno := TRetConsReciMDFe.Create;
 try
   TACBrMDFe( FACBrMDFe ).SetStatus( stMDFeRetRecepcao );

   if FConfiguracoes.Geral.Salvar then
     FConfiguracoes.Geral.Save(Recibo+'-ped-rec.xml', FDadosMsg);

   {$IFDEF ACBrMDFeOpenSSL}
      HTTP.Document.LoadFromStream(Stream);
      ConfiguraHTTP(HTTP,'SOAPAction: "http://www.portalfiscal.inf.br/mdfe/wsdl/MDFeRetRecepcao/mdfeRetRecepcao"');
      HTTP.HTTPMethod('POST', FURL);

      StrStream := TStringStream.Create('');
      StrStream.CopyFrom(HTTP.Document, 0);
      FRetornoWS := TiraAcentos(ParseText(StrStream.DataString, True));
      FRetWS := SeparaDados( FRetornoWS, 'mdfeRetRecepcaoResult');
      StrStream.Free;
   {$ELSE}
      ReqResp.Execute(Acao.Text, Stream);
      StrStream := TStringStream.Create('');
      StrStream.CopyFrom(Stream, 0);
      FRetornoWS := TiraAcentos(ParseText(StrStream.DataString, True));
      FRetWS := SeparaDados( FRetornoWS, 'mdfeRetRecepcaoResult');
      StrStream.Free;
   {$ENDIF}

   if FConfiguracoes.Geral.Salvar then
    FConfiguracoes.Geral.Save(Recibo+'-pro-rec.xml', FRetWS);

   FMDFeRetorno.Leitor.Arquivo := FRetWS;
   FMDFeRetorno.LerXML;

   TACBrMDFe( FACBrMDFe ).SetStatus( stMDFeIdle );
   aMsg := 'Ambiente : '+TpAmbToStr(FMDFeRetorno.TpAmb)+LineBreak+
           'Versão Aplicativo : '+FMDFeRetorno.verAplic+LineBreak+
           'Recibo : '+FMDFeRetorno.nRec+LineBreak+
           'Status Código : '+IntToStr(FMDFeRetorno.cStat)+LineBreak+
           'Status Descrição : '+FMDFeRetorno.xMotivo+LineBreak+
           'UF : '+CodigoParaUF(FMDFeRetorno.cUF)+LineBreak;
   if FConfiguracoes.WebServices.Visualizar then
     ShowMessage(aMsg);

//   if FMDFeRetorno.ProtMDFe.Count > 0 then
//     MotivoAux := FMDFeRetorno.ProtMDFe.Items[0].xMotivo
//   else
//     MotivoAux := '';

   if Assigned(TACBrMDFe( FACBrMDFe ).OnGerarLog) then
      TACBrMDFe( FACBrMDFe ).OnGerarLog(aMsg);

   FTpAmb    := FMDFeRetorno.TpAmb;
   FverAplic := FMDFeRetorno.verAplic;
   FcStat    := FMDFeRetorno.cStat;
   FxMotivo  := FMDFeRetorno.xMotivo;
   FcUF      := FMDFeRetorno.cUF;
   FMsg      := FMDFeRetorno.xMotivo;
//   FxMotivo  := MotivoAux;

//   Result := FMDFeRetorno.CStat = 105; // Lote em Processamento
//   FMsg   := MotivoAux;
   Result := FMDFeRetorno.CStat = 104;

 finally
   {$IFDEF ACBrMDFeOpenSSL}
      HTTP.Free;
   {$ELSE}
      ReqResp.Free;
   {$ENDIF}
   Acao.Free;
   Stream.Free;
   DFeUtil.ConfAmbiente;
   TACBrMDFe( FACBrMDFe ).SetStatus( stMDFeIdle );
 end;
end;

{ TMDFeConsulta }
constructor TMDFeConsulta.Create(AOwner: TComponent);
begin
  FConfiguracoes := TConfiguracoes( TACBrMDFe( AOwner ).Configuracoes );
  FACBrMDFe      := TACBrMDFe( AOwner );

  FprotMDFe := TProcMDFe.Create;
//  FretCancMDFe := TRetCancMDFe.Create;
end;

destructor TMDFeConsulta.Destroy;
begin
  FprotMDFe.Free;
//  FretCancMDFe.Free;
end;

function TMDFeConsulta.Executar: Boolean;
var
  MDFeRetorno: TRetConsSitMDFe;
  aMsg : String;
  AProcMDFe: TProcMDFe;
  i: Integer;
  Texto : String;
  Acao  : TStringList ;
  Stream: TMemoryStream;
  StrStream: TStringStream;
  wAtualiza: boolean;

  {$IFDEF ACBrMDFeOpenSSL}
     HTTP: THTTPSend;
  {$ELSE}
     ReqResp: THTTPReqResp;
  {$ENDIF}
begin
  inherited Executar;

  Acao   := TStringList.Create;
  Stream := TMemoryStream.Create;

  Texto := '<?xml version="1.0" encoding="utf-8"?>';
  Texto := Texto + '<soap12:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap12="http://www.w3.org/2003/05/soap-envelope">';
  Texto := Texto +   '<soap12:Header>';
  Texto := Texto +     '<mdfeCabecMsg xmlns="http://www.portalfiscal.inf.br/mdfe/wsdl/MDFeConsulta">';
  Texto := Texto +       '<cUF>'+IntToStr(FConfiguracoes.WebServices.UFCodigo)+'</cUF>';
  Texto := Texto +       '<versaoDados>'+MDFeconsSitMDFe+'</versaoDados>';
  Texto := Texto +     '</mdfeCabecMsg>';
  Texto := Texto +   '</soap12:Header>';
  Texto := Texto +   '<soap12:Body>';
  Texto := Texto +     '<mdfeDadosMsg xmlns="http://www.portalfiscal.inf.br/mdfe/wsdl/MDFeConsulta">';
  Texto := Texto + FDadosMsg;
  Texto := Texto +     '</mdfeDadosMsg>';
  Texto := Texto +   '</soap12:Body>';
  Texto := Texto + '</soap12:Envelope>';

  Acao.Text := Texto;

  {$IFDEF ACBrMDFeOpenSSL}
     Acao.SaveToStream(Stream);
     HTTP := THTTPSend.Create;
  {$ELSE}
     ReqResp := THTTPReqResp.Create(nil);
     ConfiguraReqResp( ReqResp );
     ReqResp.URL := Trim(FURL);
     ReqResp.UseUTF8InHeader := True;
     ReqResp.SoapAction := 'http://www.portalfiscal.inf.br/mdfe/wsdl/MDFeConsulta/mdfeConsultaMDF';
  {$ENDIF}
  MDFeRetorno := TRetConsSitMDFe.Create;
  try
    TACBrMDFe( FACBrMDFe ).SetStatus( stMDFeConsulta );
    if FConfiguracoes.Geral.Salvar then
      FConfiguracoes.Geral.Save(FMDFeChave+'-ped-sit.xml', FDadosMsg);

    {$IFDEF ACBrMDFeOpenSSL}
       HTTP.Document.LoadFromStream(Stream);
       ConfiguraHTTP(HTTP,'SOAPAction: "http://www.portalfiscal.inf.br/mdfe/wsdl/MDFeConsulta/mdfeConsultaMDF"');
       HTTP.HTTPMethod('POST', FURL);

       StrStream := TStringStream.Create('');
       StrStream.CopyFrom(HTTP.Document, 0);
       FRetornoWS := TiraAcentos(ParseText(StrStream.DataString, True));
       FRetWS := SeparaDados( FRetornoWS, 'mdfeConsultaMDFResult');
       StrStream.Free;
    {$ELSE}
       ReqResp.Execute(Acao.Text, Stream);
       StrStream := TStringStream.Create('');
       StrStream.CopyFrom(Stream, 0);
       FRetornoWS := TiraAcentos(ParseText(StrStream.DataString, True));
       FRetWS := SeparaDados( FRetornoWS, 'mdfeConsultaMDFResult');
       StrStream.Free;
    {$ENDIF}

    MDFeRetorno.Leitor.Arquivo := FRetWS;
    MDFeRetorno.LerXML;

    FTpAmb     := MDFeRetorno.TpAmb;
    FverAplic  := MDFeRetorno.verAplic;
    FcStat     := MDFeRetorno.cStat;
    FxMotivo   := MDFeRetorno.xMotivo;
    FcUF       := MDFeRetorno.cUF;
    FMDFeChave := MDFeRetorno.chMDFe;
    FMsg       := MDFeRetorno.XMotivo;

    FprotMDFe.PathMDFe            := MDFeRetorno.protMDFe.PathMDFe;
    FprotMDFe.PathRetConsReciMDFe := MDFeRetorno.protMDFe.PathRetConsReciMDFe;
    FprotMDFe.PathRetConsSitMDFe  := MDFeRetorno.protMDFe.PathRetConsSitMDFe;
    FprotMDFe.PathRetConsSitMDFe  := MDFeRetorno.protMDFe.PathRetConsSitMDFe;
    FprotMDFe.tpAmb               := MDFeRetorno.protMDFe.tpAmb;
    FprotMDFe.verAplic            := MDFeRetorno.protMDFe.verAplic;
    FprotMDFe.chMDFe              := MDFeRetorno.protMDFe.chMDFe;
    FprotMDFe.dhRecbto            := MDFeRetorno.protMDFe.dhRecbto;
    FprotMDFe.nProt               := MDFeRetorno.protMDFe.nProt;
    FprotMDFe.digVal              := MDFeRetorno.protMDFe.digVal;
    FprotMDFe.cStat               := MDFeRetorno.protMDFe.cStat;
    FprotMDFe.xMotivo             := MDFeRetorno.protMDFe.xMotivo;
    (*
    FretCancMDFe.tpAmb    := MDFeRetorno.retCancMDFe.tpAmb;
    FretCancMDFe.verAplic := MDFeRetorno.retCancMDFe.verAplic;
    FretCancMDFe.cStat    := MDFeRetorno.retCancMDFe.cStat;
    FretCancMDFe.xMotivo  := MDFeRetorno.retCancMDFe.xMotivo;
    FretCancMDFe.cUF      := MDFeRetorno.retCancMDFe.cUF;
    FretCancMDFe.chMDFe   := MDFeRetorno.retCancMDFe.chMDFe;
    FretCancMDFe.dhRecbto := MDFeRetorno.retCancMDFe.dhRecbto;
    FretCancMDFe.nProt    := MDFeRetorno.retCancMDFe.nProt;
    *)
    FProtocolo := FprotMDFe.nProt; // MDFeUtil.SeSenao(MDFeUtil.NaoEstaVazio(MDFeRetorno.retCancMDFe.nProt),MDFeRetorno.retCancMDFe.nProt,MDFeRetorno.protMDFe.nProt);
    FDhRecbto  := FprotMDFe.dhRecbto; // MDFeUtil.SeSenao(MDFeRetorno.retCancMDFe.dhRecbto <> 0,MDFeRetorno.retCancMDFe.dhRecbto,MDFeRetorno.protMDFe.dhRecbto);

    TACBrMDFe( FACBrMDFe ).SetStatus( stMDFeIdle );
    
    aMsg := 'Identificador : ' + MDFeRetorno.protMDFe.chMDFe + LineBreak +
            'Ambiente : ' + TpAmbToStr(MDFeRetorno.TpAmb) + LineBreak +
            'Versão Aplicativo : ' + MDFeRetorno.verAplic + LineBreak +
            'Status Código : ' + IntToStr(MDFeRetorno.CStat) + LineBreak +
            'Status Descrição : ' + MDFeRetorno.xMotivo + LineBreak +
            'UF : ' + CodigoParaUF(MDFeRetorno.cUF) + LineBreak +
            'Chave Acesso : ' + FMDFeChave + LineBreak +
            'Recebimento : ' + DateTimeToStr(FDhRecbto) + LineBreak +
            'Protocolo : ' + FProtocolo + LineBreak +
            'Digest Value : ' + MDFeRetorno.protMDFe.digVal + LineBreak;

    if FConfiguracoes.WebServices.Visualizar then
      ShowMessage(aMsg);

    if Assigned(TACBrMDFe( FACBrMDFe ).OnGerarLog) then
       TACBrMDFe( FACBrMDFe ).OnGerarLog(aMsg);

    Result := (MDFeRetorno.cStat in [100, 101, 110, 132]);
    // 100 = Autorizado o Uso
    // 101 = Cancelamento Homologado
    // 110 = Uso Denegado
    // 132 = Encerrado

    if FConfiguracoes.Geral.Salvar  then
      FConfiguracoes.Geral.Save(FMDFeChave+'-sit.xml', FRetWS);

    for i := 0 to TACBrMDFe( FACBrMDFe ).Manifestos.Count-1 do
     begin
        if StringReplace(TACBrMDFe( FACBrMDFe ).Manifestos.Items[i].MDFe.infMDFe.ID,'MDFe','',[rfIgnoreCase]) = FMDFeChave then
         begin
            watualiza := true;
            if ((MDFeRetorno.cStat = 101) and // 101 = Cancelamento Homologado
                (FConfiguracoes.Geral.AtualizarXMLCancelado=false)) then
               wAtualiza := False;

            TACBrMDFe( FACBrMDFe ).Manifestos.Items[i].Confirmada := (MDFeRetorno.protMDFe.cStat = 100); // 100 = Autorizado o Uso
            if wAtualiza then
            begin
              TACBrMDFe( FACBrMDFe ).Manifestos.Items[i].Msg                    := FprotMDFe.xMotivo;
              TACBrMDFe( FACBrMDFe ).Manifestos.Items[i].MDFe.procMDFe.tpAmb    := FprotMDFe.tpAmb;
              TACBrMDFe( FACBrMDFe ).Manifestos.Items[i].MDFe.procMDFe.verAplic := FprotMDFe.verAplic;
              TACBrMDFe( FACBrMDFe ).Manifestos.Items[i].MDFe.procMDFe.chMDFe   := FprotMDFe.chMDFe;
              TACBrMDFe( FACBrMDFe ).Manifestos.Items[i].MDFe.procMDFe.dhRecbto := FprotMDFe.dhRecbto;
              TACBrMDFe( FACBrMDFe ).Manifestos.Items[i].MDFe.procMDFe.nProt    := FprotMDFe.nProt;
              TACBrMDFe( FACBrMDFe ).Manifestos.Items[i].MDFe.procMDFe.digVal   := FprotMDFe.digVal;
              TACBrMDFe( FACBrMDFe ).Manifestos.Items[i].MDFe.procMDFe.cStat    := FprotMDFe.cStat;
              TACBrMDFe( FACBrMDFe ).Manifestos.Items[i].MDFe.procMDFe.xMotivo  := FprotMDFe.xMotivo;
            end;

            if ((FileExists(PathWithDelim(FConfiguracoes.Geral.PathSalvar)+FMDFeChave+'-mdfe.xml') or
                DFeUtil.NaoEstaVazio(TACBrMDFe( FACBrMDFe ).Manifestos.Items[i].NomeArq))
               and wAtualiza) then
            begin
             AProcMDFe := TProcMDFe.Create;

             if DFeUtil.NaoEstaVazio(TACBrMDFe( FACBrMDFe ).Manifestos.Items[i].NomeArq)
              then AProcMDFe.PathMDFe := TACBrMDFe( FACBrMDFe ).Manifestos.Items[i].NomeArq
              else AProcMDFe.PathMDFe := PathWithDelim(FConfiguracoes.Geral.PathSalvar)+FMDFeChave+'-mdfe.xml';
              
             AProcMDFe.PathRetConsSitMDFe := PathWithDelim(FConfiguracoes.Geral.PathSalvar)+FMDFeChave+'-sit.xml';

             AProcMDFe.GerarXML;

             if DFeUtil.NaoEstaVazio(AProcMDFe.Gerador.ArquivoFormatoXML) then
                AProcMDFe.Gerador.SalvarArquivo(AProcMDFe.PathMDFe);
             AProcMDFe.Free;
            end;

            if FConfiguracoes.Arquivos.Salvar and wAtualiza then
            begin
              if FConfiguracoes.Arquivos.EmissaoPathMDFe then
                 TACBrMDFe( FACBrMDFe ).Manifestos.Items[i].SaveToFile(PathWithDelim(FConfiguracoes.Arquivos.GetPathMDFe(TACBrMDFe( FACBrMDFe ).Manifestos.Items[i].MDFe.Ide.dhEmi))+StringReplace(TACBrMDFe( FACBrMDFe ).Manifestos.Items[i].MDFe.InfMDFe.Id,'MDFe','',[rfIgnoreCase])+'-mdfe.xml')
              else
                 TACBrMDFe( FACBrMDFe ).Manifestos.Items[i].SaveToFile(PathWithDelim(FConfiguracoes.Arquivos.GetPathMDFe)+StringReplace(TACBrMDFe( FACBrMDFe ).Manifestos.Items[i].MDFe.InfMDFe.Id,'MDFe','',[rfIgnoreCase])+'-mdfe.xml');
            end;

            break;
         end;
     end;

    //MDFeRetorno.Free;

    if (TACBrMDFe( FACBrMDFe ).Manifestos.Count <= 0) then
     begin
       if FConfiguracoes.Geral.Salvar then
        begin
          if FileExists(PathWithDelim(FConfiguracoes.Geral.PathSalvar)+FMDFeChave+'-mdfe.xml') then
           begin
             AProcMDFe := TProcMDFe.Create;
             AProcMDFe.PathMDFe := PathWithDelim(FConfiguracoes.Geral.PathSalvar)+FMDFeChave+'-mdfe.xml';
             AProcMDFe.PathRetConsSitMDFe := PathWithDelim(FConfiguracoes.Geral.PathSalvar)+FMDFeChave+'-sit.xml';

             AProcMDFe.GerarXML;

             if DFeUtil.NaoEstaVazio(AProcMDFe.Gerador.ArquivoFormatoXML) then
                AProcMDFe.Gerador.SalvarArquivo(AProcMDFe.PathMDFe);
             AProcMDFe.Free;
           end;
        end;
     end;

  finally
    {$IFDEF ACBrMDFeOpenSSL}
       HTTP.Free;
    {$ELSE}
      ReqResp.Free;
    {$ENDIF}
    MDFeRetorno.Free;
    Acao.Free;
    Stream.Free;
    DFeUtil.ConfAmbiente;
    TACBrMDFe( FACBrMDFe ).SetStatus( stMDFeIdle );
  end;
end;

{ TMDFeEnvEvento }
constructor TMDFeEnvEvento.Create(AOwner: TComponent; AEvento: TEventoMDFe);
begin
  inherited Create(AOwner);

  FEvento := AEvento;
end;

destructor TMDFeEnvEvento.Destroy;
begin
  if Assigned(FEventoRetorno) then
     FEventoRetorno.Free;
  inherited;
end;

function TMDFeEnvEvento.Executar: Boolean;
var
  aMsg: string;
  Texto : String;
  Acao  : TStringList ;
  Stream: TMemoryStream;
  StrStream: TStringStream;
  wProc  : TStringList ;
  i,j : integer;
  Leitor : TLeitor;
  {$IFDEF ACBrMDFeOpenSSL}
     HTTP: THTTPSend;
  {$ELSE}
     ReqResp: THTTPReqResp;
  {$ENDIF}
begin
  FEvento.idLote := idLote;
  if Assigned(FEventoRetorno) then
     FEventoRetorno.Free;

  inherited Executar;

  Acao   := TStringList.Create;
  Stream := TMemoryStream.Create;

  Texto := '<?xml version="1.0" encoding="utf-8"?>';
  Texto := Texto + '<soap12:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap12="http://www.w3.org/2003/05/soap-envelope">';
  Texto := Texto +   '<soap12:Header>';
  Texto := Texto +     '<mdfeCabecMsg xmlns="http://www.portalfiscal.inf.br/mdfe/wsdl/MDFeRecepcaoEvento">';
  Texto := Texto +       '<cUF>'+IntToStr(FConfiguracoes.WebServices.UFCodigo)+'</cUF>';
  Texto := Texto +       '<versaoDados>'+MDFeEventoMDFe+'</versaoDados>';
  Texto := Texto +     '</mdfeCabecMsg>';
  Texto := Texto +   '</soap12:Header>';
  Texto := Texto +   '<soap12:Body>';
  Texto := Texto +     '<mdfeDadosMsg xmlns="http://www.portalfiscal.inf.br/mdfe/wsdl/MDFeRecepcaoEvento">';
  Texto := Texto +       FDadosMsg;
  Texto := Texto +     '</mdfeDadosMsg>';
  Texto := Texto +   '</soap12:Body>';
  Texto := Texto +'</soap12:Envelope>';

  Acao.Text := Texto;

   {$IFDEF ACBrMDFeOpenSSL}
     Acao.SaveToStream(Stream);
     HTTP := THTTPSend.Create;
  {$ELSE}
     ReqResp := THTTPReqResp.Create(nil);
     ConfiguraReqResp( ReqResp );
     ReqResp.URL := FURL;
     ReqResp.UseUTF8InHeader := True;
     ReqResp.SoapAction := 'http://www.portalfiscal.inf.br/mdfe/wsdl/MDFeRecepcaoEvento/mdfeRecepcaoEvento';
  {$ENDIF}

  try
    TACBrMDFe( FACBrMDFe ).SetStatus( stMDFeEvento );
    FPathArqEnv := IntToStr(FEvento.idLote)+ '-ped-evento.xml';

    if FConfiguracoes.Geral.Salvar then
      FConfiguracoes.Geral.Save(FPathArqEnv, FDadosMsg);

    if FConfiguracoes.Arquivos.Salvar then
      FConfiguracoes.Geral.Save(FPathArqEnv, FDadosMsg, FConfiguracoes.Arquivos.GetPathMDFe);

    {$IFDEF ACBrMDFeOpenSSL}
       HTTP.Document.LoadFromStream(Stream);
       ConfiguraHTTP(HTTP,'SOAPAction: "http://www.portalfiscal.inf.br/mdfe/wsdl/MDFeRecepcaoEvento/mdfeRecepcaoEvento"');
       HTTP.HTTPMethod('POST', FURL);

       StrStream := TStringStream.Create('');
       StrStream.CopyFrom(HTTP.Document, 0);
       FRetornoWS := TiraAcentos(ParseText(StrStream.DataString, True));
       FRetWS := SeparaDados( FRetornoWS,'mdfeRecepcaoEventoResult');
       StrStream.Free;
    {$ELSE}
       ReqResp.Execute(Acao.Text, Stream);
       StrStream := TStringStream.Create('');
       StrStream.CopyFrom(Stream, 0);
       FRetornoWS := TiraAcentos(ParseText(StrStream.DataString, True));
       FRetWS := SeparaDados( FRetornoWS,'mdfeRecepcaoEventoResult');
       StrStream.Free;
    {$ENDIF}

    FPathArqResp := IntToStr(FEvento.idLote) + '-eve.xml';
    if FConfiguracoes.Geral.Salvar then
      FConfiguracoes.Geral.Save(FPathArqResp, FRetWS);

    if FConfiguracoes.Arquivos.Salvar then
      FConfiguracoes.Geral.Save(FPathArqResp, FRetWS, FConfiguracoes.Arquivos.GetPathMDFe);

    FEventoRetorno                := TRetEventoMDFe.Create;
    FEventoRetorno.Leitor.Arquivo := FRetWS;
    FEventoRetorno.LerXml;

    TACBrMDFe( FACBrMDFe ).SetStatus( stMDFeIdle );
    aMsg := 'Ambiente : '+TpAmbToStr(EventoRetorno.retEvento.Items[0].RetInfEvento.tpAmb)+LineBreak+
            'Versão Aplicativo : '+EventoRetorno.retEvento.Items[0].RetInfEvento.verAplic+LineBreak+
            'Status Código : '+IntToStr(EventoRetorno.retEvento.Items[0].RetInfEvento.cStat)+LineBreak+
            'Status Descrição : '+EventoRetorno.retEvento.Items[0].RetInfEvento.xMotivo+LineBreak+
            'Recebimento : '+DFeUtil.SeSenao(EventoRetorno.retEvento.Items[0].RetInfEvento.dhRegEvento = 0, '',
                                              DateTimeToStr(EventoRetorno.retEvento.Items[0].RetInfEvento.dhRegEvento));

    if FConfiguracoes.WebServices.Visualizar then
      ShowMessage(aMsg);

    if Assigned(TACBrMDFe( FACBrMDFe ).OnGerarLog) then
       TACBrMDFe( FACBrMDFe ).OnGerarLog(aMsg);

    FcStat   := EventoRetorno.retEvento.Items[0].RetInfEvento.cStat;
    FxMotivo := EventoRetorno.retEvento.Items[0].RetInfEvento.xMotivo;
    FMsg     := EventoRetorno.retEvento.Items[0].RetInfEvento.xMotivo;
    FTpAmb   := EventoRetorno.retEvento.Items[0].RetInfEvento.tpAmb;

    Result   := (FcStat = 128) or (FcStat = 135) or (FcStat = 136);

    FPathArqResp := IntToStr(FEvento.idLote) + '-eve.xml';
    if FConfiguracoes.Geral.Salvar then
      FConfiguracoes.Geral.Save(FPathArqResp, FRetWS);

    if FConfiguracoes.Arquivos.Salvar then
      FConfiguracoes.Geral.Save(FPathArqResp, FRetWS, FConfiguracoes.Arquivos.GetPathMDFe);

    //gerar arquivo proc de evento
    if Result then
    begin
      Leitor := TLeitor.Create;
      for i := 0 to FEvento.Evento.Count-1 do
       begin
        for j := 0 to EventoRetorno.retEvento.Count-1 do
         begin
           if FEvento.Evento.Items[i].InfEvento.chMDFe = EventoRetorno.retEvento.Items[j].RetInfEvento.chMDFe then
            begin
              wProc := TStringList.Create;
              wProc.Add('<?xml version="1.0" encoding="UTF-8" ?>');
              wProc.Add('<procEventoMDFe versao="' + MDFeEventoMDFe + '" xmlns="http://www.portalfiscal.inf.br/mdfe">');

              wProc.Add('<eventoMDFe versao="' + MDFeEventoMDFe + '">');
              Leitor.Arquivo := FDadosMSG;
              wProc.Add(UTF8Encode(Leitor.rExtrai(1, 'infEvento', '', i + 1)));
              wProc.Add('</infEvento>');

              wProc.Add('<Signature xmlns="http://www.w3.org/2000/09/xmldsig#">');
              Leitor.Arquivo := FDadosMSG;
              wProc.Add(UTF8Encode(Leitor.rExtrai(1, 'SignedInfo', '', i + 1)));
              wProc.Add('</SignedInfo>');
              Leitor.Arquivo := FDadosMSG;
              wProc.Add(UTF8Encode(Leitor.rExtrai(1, 'SignatureValue', '', i + 1)));
              wProc.Add('</SignatureValue>');
              Leitor.Arquivo := FDadosMSG;
              wProc.Add(UTF8Encode(Leitor.rExtrai(1, 'KeyInfo', '', i + 1)));
              wProc.Add('</KeyInfo>');
              wProc.Add('</Signature>');

              wProc.Add('</eventoMDFe>');

              wProc.Add('<retEventoMDFe versao="' + MDFeEventoMDFe + '">');
              Leitor.Arquivo := FRetWS;
              wProc.Add(UTF8Encode(Leitor.rExtrai(1, 'infEvento', '', j + 1)));
              wProc.Add('</infEvento>');
              wProc.Add('</retEventoMDFe>');

              wProc.Add('</procEventoMDFe>');

              EventoRetorno.retEvento.Items[j].RetInfEvento.XML := wProc.Text;

              if FConfiguracoes.Geral.Salvar then
                 FConfiguracoes.Geral.Save(FEvento.Evento.Items[i].InfEvento.chMDFe + '-ProcEventoMDFe.xml', wProc.Text);
              if FConfiguracoes.Arquivos.Salvar then
                 FConfiguracoes.Geral.Save(FEvento.Evento.Items[i].InfEvento.chMDFe + '-ProcEventoMDFe.xml', wProc.Text, FConfiguracoes.Arquivos.GetPathMDFe);
              wProc.Free;
              break;
            end;
         end;
       end;
      Leitor.Free;
    end;
  finally
    {$IFDEF ACBrMDFeOpenSSL}
       HTTP.Free;
    {$ELSE}
       ReqResp.Free;
    {$ENDIF}
    Acao.Free;
    Stream.Free;
    DFeUtil.ConfAmbiente;
    TACBrMDFe( FACBrMDFe ).SetStatus( stMDFeIdle );
  end;
end;

end.
