{$I ACBr.inc}

unit ACBrNFSeWebServices;

interface

uses
  {$IFDEF FPC}
    LResources, Controls, Graphics, Dialogs,
  {$ELSE}
    StrUtils,
  {$ENDIF}
    Classes, SysUtils,
  {$IFDEF CLX}
    QDialogs,
  {$ELSE}
    Dialogs,
  {$ENDIF}
  {$IFDEF ACBrNFSeOpenSSL}
    HTTPSend,
  {$ELSE}
    SOAPHTTPClient, SOAPHTTPTrans, SOAPConst,
    JwaWinCrypt, JwaWinType, WinInet,
    ACBrCAPICOM_TLB, ACBrMSXML2_TLB,
  {$ENDIF}
    pcnGerador, pcnConversao, pcnAuxiliar, pnfsNFSe, pnfsConversao,
    pnfsEnvLoteRpsResposta, pnfsConsSitLoteRpsResposta,
    pnfsConsLoteRpsResposta, pnfsConsNfseporRpsResposta,
    pnfsConsNfseResposta, pnfsCancNfseResposta,
    pnfsGerarNfseResposta,
    ACBrNFSeNotasFiscais, ACBrNFSeConfiguracoes,
    ACBrProvedorGinfesV3, ACBrProvedorPublica, ACBrProvedorRJ,
    ACBrProvedorTiplan, ACBrProvedorISSNet, ACBrProvedorWebISS,
    ACBrProvedorProdemge, ACBrProvedorISSIntel, ACBrProvedorGovBR,
    ACBrProvedorRecife, ACBrProvedorSimplISS, ACBrProvedorThema,
    ACBrProvedorEquiplano, ACBrProvedorfintelISS, ACBrProvedorDigifred,
    ACBrProvedorBetha, ACBrProvedorBetim, ACBrProvedorSaatri;

type

  TWebServicesBase = Class
  private
    procedure DoNFSeEnviarLoteRPS;
    procedure DoNFSeConsultarSituacaoLoteRPS;
    procedure DoNFSeConsultarLoteRPS;
    procedure DoNFSeConsultarNFSeporRPS;
    procedure DoNFSeConsultarNFSe;
    procedure DoNFSeCancelarNFSe;
    procedure DoNFSeGerarNFSe;
    {$IFDEF ACBrNFSeOpenSSL}
      procedure ConfiguraHTTP( HTTP : THTTPSend; Action : AnsiString);
    {$ELSE}
      procedure ConfiguraReqResp( ReqResp : THTTPReqResp);
      procedure OnBeforePost(const HTTPReqResp: THTTPReqResp; Data:Pointer);
    {$ENDIF}
  protected
    FProvedorClass: TProvedorClass;

    FCabMsg: WideString;
    FDadosMsg: AnsiString;
    FDadosSenha: AnsiString;
    FRetornoWS: AnsiString;
    FRetWS: AnsiString;
    FMsg: AnsiString;
    FURL: WideString;
    FConfiguracoes: TConfiguracoes;
    FACBrNFSe : TComponent;
    FHTTP_AG: String;
    FvAssinada: AnsiString;
    FTagI: AnsiString;
    FTagF: AnsiString;
    FPrefixo2: AnsiString;
    FPrefixo3: AnsiString;
    FPrefixo4: AnsiString;
    FNameSpaceCab: AnsiString;
    FNameSpaceDad: AnsiString;
    FVersaoLayOut: AnsiString;
    FVersaoDados: AnsiString;
    FVersaoXML: AnsiString;
    FURLNS1: String;
    FProvedor: TnfseProvedor;
    FxProvedor: String;

    FCabecalho: String;
    FServicoEnviar: String;
    FServicoConSit: String;
    FServicoConLot: String;
    FServicoConRps: String;
    FServicoConNfse: String;
    FServicoCancelar: String;
    FServicoGerar: String;
    FDefTipos: String;

    FNomeCidade: String;
    FRecepcaoLoteRps: String;
    FConsultaLoteRps: String;
    FConsultaNFSeRps: String;
    FConsultaSitLoteRps: String;
    FConsultaNFSe: String;
    FCancelaNFSe: String;
    FGerarNFSe: String;

    procedure LoadMsgEntrada;
    procedure LoadURL;
  public
    function Executar: Boolean; virtual;
    constructor Create(AOwner : TComponent); virtual;
    property CabMsg: WideString read FCabMsg;
    property DadosMsg: AnsiString read FDadosMsg;
    property DadosSenha: AnsiString read FDadosSenha;
    property RetWS: AnsiString read FRetWS;
    property Msg: AnsiString read FMsg;
    property HTTP_AG: String read FHTTP_AG;
    property vAssinada: AnsiString read FvAssinada;
    property TagI: AnsiString read FTagI;
    property TagF: AnsiString read FTagF;
    property Prefixo2: AnsiString read FPrefixo2;
    property Prefixo3: AnsiString read FPrefixo3;
    property Prefixo4: AnsiString read FPrefixo4;
    property NameSpaceCab: AnsiString read FNameSpaceCab;
    property NameSpaceDad: AnsiString read FNameSpaceDad;
    property VersaoLayOut: AnsiString read FVersaoLayOut;
    property VersaoDados: AnsiString read FVersaoDados;
    property VersaoXML: AnsiString read FVersaoXML;
    property URLNS1: String read FURLNS1;
    property Provedor: TnfseProvedor read FProvedor;
    property xProvedor: String read FxProvedor;

    property Cabecalho: String read FCabecalho;
    property ServicoEnviar: String read FServicoEnviar;
    property ServicoConSit: String read FServicoConSit;
    property ServicoConLot: String read FServicoConLot;
    property ServicoConRps: String read FServicoConRps;
    property ServicoConNfse: String read FServicoConNfse;
    property ServicoCancelar: String read FServicoCancelar;
    property ServicoGerar: String read FServicoGerar;
    property DefTipos: String read FDefTipos;

    property NomeCidade: String read FNomeCidade;
    property RecepcaoLoteRps: String read FRecepcaoLoteRps;
    property ConsultaLoteRps: String read FConsultaLoteRps;
    property ConsultaNFSeRps: String read FConsultaNFSeRps;
    property ConsultaSitLoteRps: String read FConsultaSitLoteRps;
    property ConsultaNFSe: String read FConsultaNFSe;
    property CancelaNFSe: String read FCancelaNFSe;
    property GerarNFSe: String read FGerarNFSe;
  end;

  TNFSeEnviarLoteRPS = Class(TWebServicesBase)
  private
    FNumeroLote: Integer;
    FDataRecebimento: TDateTime;
    FProtocolo : String;
    // Incluido por Rodrigo Cantelli
    FNFSeRetorno : TretEnvLote;
    FNotasFiscais : TNotasFiscais;
  public
    function Executar: Boolean; override;
    constructor Create(AOwner : TComponent; ANotasFiscais : TNotasFiscais); reintroduce;
    property NumeroLote: integer read FNumeroLote;
    property DataRecebimento: TDateTime read FDataRecebimento;
    property Protocolo: String read FProtocolo;
    // Incluido por Rodrigo Cantelli
    property NFSeRetorno: TretEnvLote read FNFSeRetorno write FNFSeRetorno;
  end;

  TNFSeConsultarSituacaoLoteRPS = Class(TWebServicesBase)
  private
    FCnpj: String;
    FInscricaoMunicipal: String;
    FProtocolo: String;
    FSituacao: String;
    FNFSeRetorno: TRetSitLote;
    FNotasFiscais : TNotasFiscais;
  public
    function Executar: Boolean; override;
    constructor Create(AOwner : TComponent; ANotasFiscais : TNotasFiscais); reintroduce;
    property Cnpj: String read FCnpj write FCnpj;
    property InscricaoMunicipal: String read FInscricaoMunicipal write FInscricaoMunicipal;
    property Protocolo: String read FProtocolo write FProtocolo;
    property Situacao: String read FSituacao;
    property NFSeRetorno: TRetSitLote read FNFSeRetorno write FNFSeRetorno;
  end;

  TNFSeConsultarLoteRPS = Class(TWebServicesBase)
  private
    FProtocolo: String;
    FNFSeRetorno: TRetLote;
    FNotasFiscais : TNotasFiscais;
    FCNPJ: string;
    FIM: string;
    FArquivoRetorno: WideString;
  public
    function Executar: Boolean; override;
    constructor Create(AOwner : TComponent; ANotasFiscais : TNotasFiscais); reintroduce;
    property Protocolo: String read FProtocolo write FProtocolo;
    property NFSeRetorno: TRetLote read FNFSeRetorno write FNFSeRetorno;
    property NotasFiscais : TNotasFiscais read FNotasFiscais;
    property CNPJ: string read FCNPJ write FCNPJ;
    property IM: string read FIM write FIM;
    property ArquivoRetorno: WideString read FArquivoRetorno write FArquivoRetorno;
  end;

  TNFSeConsultarNfseRPS = Class(TWebServicesBase)
  private
    FNumero: String;
    FSerie: String;
    FTipo: String;
    FCnpj: String;
    FInscricaoMunicipal: String;
    FNFSeRetorno: TRetNfseRps;
    FNotasFiscais : TNotasFiscais;
  public
    function Executar: Boolean; override;
    constructor Create(AOwner : TComponent; ANotasFiscais : TNotasFiscais); reintroduce;
    property Numero: String read FNumero write FNumero;
    property Serie: String read FSerie write FSerie;
    property Tipo: String read FTipo write FTipo;
    property Cnpj: String read FCnpj write FCnpj;
    property InscricaoMunicipal: String read FInscricaoMunicipal write FInscricaoMunicipal;
    property NFSeRetorno: TRetNfseRps read FNFSeRetorno write FNFSeRetorno;
  end;

  TNFSeConsultarNfse = Class(TWebServicesBase)
  private
    FCnpj: String;
    FInscricaoMunicipal: String;
    FDataInicial: TDateTime;
    FDataFinal: TDateTime;
    FNFSeRetorno: TRetNfse;
    FNotasFiscais : TNotasFiscais;
  public
    function Executar: Boolean; override;
    constructor Create(AOwner : TComponent; ANotasFiscais : TNotasFiscais); reintroduce;
    property Cnpj: String read FCnpj write FCnpj;
    property InscricaoMunicipal: String read FInscricaoMunicipal write FInscricaoMunicipal;
    property DataInicial: TDateTime read FDataInicial write FDataInicial;
    property DataFinal: TDateTime read FDataFinal write FDataFinal;
    property NFSeRetorno: TRetNfse read FNFSeRetorno write FNFSeRetorno;
  end;

  TNFSeCancelarNfse = Class(TWebServicesBase)
  private
    FCodigoCancelamento: String;
    FDataHora: TDateTime;
    FNFSeRetorno: TretCancNFSe;
    FNotasFiscais : TNotasFiscais;
    FCNPJ: string;
    FIM: string;
    FNumeroRPS: string;
    FCodigoMunicipio: string;
    FArquivoRetorno: WideString;
  public
    function Executar: Boolean; override;
    constructor Create(AOwner : TComponent; ANotasFiscais : TNotasFiscais); reintroduce;
    property CodigoCancelamento: String read FCodigoCancelamento write FCodigoCancelamento;
    property DataHora: TDateTime read FDataHora write FDataHora;
    property NFSeRetorno: TretCancNFSe read FNFSeRetorno write FNFSeRetorno;
    property NumeroRPS: string read FNumeroRPS write FNumeroRPS;
    property CNPJ: string read FCNPJ write FCNPJ;
    property IM: string read FIM write FIM;
    property CodigoMunicipio: string read FCodigoMunicipio write FCodigoMunicipio;
    property ArquivoRetorno: WideString read FArquivoRetorno write FArquivoRetorno;
  end;

  TNFSeGerarNFSe = Class(TWebServicesBase)
  private
    FNumeroRps: Integer;
    FNFSeRetorno : TGerarretNfse;
    FNotasFiscais : TNotasFiscais;
  public
    function Executar: Boolean; override;
    constructor Create(AOwner : TComponent; ANotasFiscais : TNotasFiscais); reintroduce;

    property NumeroRps: integer read FNumeroRps;
    property NFSeRetorno: TGerarretNfse read FNFSeRetorno write FNFSeRetorno;
  end;

  TWebServices = Class(TWebServicesBase)
  private
    FACBrNFSe: TComponent;
    FEnviar: TNFSeEnviarLoteRPS;
    FConsSitLote: TNFSeConsultarSituacaoLoteRPS;
    FConsLote: TNFSeConsultarLoteRPS;
    FConsNfseRps: TNFSeConsultarNfseRps;
    FConsNfse: TNFSeConsultarNfse;
    FCancNfse: TNFSeCancelarNfse;
    FGerarNfse: TNFSeGerarNfse;
  public
    constructor Create(AFNotaFiscalEletronica: TComponent); reintroduce;
    destructor Destroy; override;
    function Envia(ALote:Integer): Boolean;
    function ConsultaSituacao(ACnpj, AInscricaoMunicipal, AProtocolo: String): Boolean;
    function ConsultaLoteRps(AProtocolo: String;
                             const CarregaProps: boolean = true): Boolean; overload;
    function ConsultaLoteRps(AProtocolo,
                             ACNPJ, AInscricaoMunicipal: string): Boolean; overload;
    function ConsutaNFSeporRps(ANumero, ASerie, ATipo, ACnpj, AInscricaoMunicipal: String): Boolean;
    function ConsutaNFSe(ACnpj, AInscricaoMunicipal: String; ADataInicial, ADataFinal: TDateTime): Boolean;
    function CancelaNFSe(ACodigoCancelamento: String;
                         const CarregaProps: boolean = true): Boolean; overload;
    function CancelaNFSe(ACodigoCancelamento, ANumeroRPS, ACNPJ, AInscricaoMunicipal,
                         ACodigoMunicipio: string): Boolean; overload;
    function Gera(ARps:Integer): Boolean;
  published
    property ACBrNFSe: TComponent read FACBrNFSe write FACBrNFSe;
    property Enviar: TNFSeEnviarLoteRPS read FEnviar write FEnviar;
    property ConsSitLote: TNFSeConsultarSituacaoLoteRPS read FConsSitLote write FConsSitLote;
    property ConsLote: TNFSeConsultarLoteRPS read FConsLote write FConsLote;
    property ConsNfseRps: TNFSeConsultarNfseRps read FConsNfseRps write FConsNfseRps;
    property ConsNfse: TNFSeConsultarNfse read FConsNfse write FConsNfse;
    property CancNfse: TNFSeCancelarNfse read FCancNfse write FCancNfse;
    property GerarNfse: TNFSeGerarNfse read FGerarNfse write FGerarNfse;
  end;

implementation

uses
 {$IFDEF ACBrNFSeOpenSSL}
   ssl_openssl,
 {$ENDIF}
 Math, ACBrUtil, ACBrNFSeUtil, ACBrNFSe;

{$IFNDEF ACBrNFSeOpenSSL}
const
  INTERNET_OPTION_CLIENT_CERT_CONTEXT = 84;
{$ENDIF}

{ TWebServicesBase }
constructor TWebServicesBase.Create(AOwner: TComponent);
begin
 FConfiguracoes := TConfiguracoes( TACBrNFSe( AOwner ).Configuracoes );
 FACBrNFSe      := TACBrNFSe( AOwner );
end;

{$IFDEF ACBrNFSeOpenSSL}
procedure TWebServicesBase.ConfiguraHTTP( HTTP : THTTPSend; Action : AnsiString);
begin
 if FileExists(FConfiguracoes.Certificados.Certificado)
  then HTTP.Sock.SSL.PFXfile := FConfiguracoes.Certificados.Certificado
  else HTTP.Sock.SSL.PFX     := FConfiguracoes.Certificados.Certificado;

  HTTP.Sock.SSL.KeyPassword := FConfiguracoes.Certificados.Senha;

  HTTP.ProxyHost  := FConfiguracoes.WebServices.ProxyHost;
  HTTP.ProxyPort  := FConfiguracoes.WebServices.ProxyPort;
  HTTP.ProxyUser  := FConfiguracoes.WebServices.ProxyUser;
  HTTP.ProxyPass  := FConfiguracoes.WebServices.ProxyPass;

//  HTTP.Sock.RaiseExcept := True;

  HTTP.MimeType  := 'text/xml; charset=utf-8';
  HTTP.UserAgent := '';
  HTTP.Protocol  := '1.1' ;

  HTTP.AddPortNumberToHost := False;
  HTTP.Headers.Add(Action);
end;
{$ELSE}
procedure TWebServicesBase.ConfiguraReqResp(ReqResp: THTTPReqResp);
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

function GetLastErrorText: string;
var
 aMsg: String;
begin
 case GetLastError of
  12030: aMsg := 'A conexão com o servidor foi finalizada.';
  12044: aMsg := 'O Servidor está solicitando autenticação do cliente.';
  12046: aMsg := 'Autorização do cliente não está configurado neste computador.';
  else aMsg := IntToStr(GetLastError);
 end;
 Result := aMsg;
end;

var
 Cert         : ICertificate2;
 CertContext  : ICertContext;
 PCertContext : Pointer;
 ContentHeader: string;
begin
 Cert        := FConfiguracoes.Certificados.GetCertificado;
 CertContext := Cert as ICertContext;
 CertContext.Get_CertContext(Integer(PCertContext));

 if (FProvedor <> proGovBr) and
    (FProvedor <> proSimplISS)
  then begin
   if not InternetSetOption(Data, INTERNET_OPTION_CLIENT_CERT_CONTEXT, PCertContext, Sizeof(CERT_CONTEXT)*5)
    then begin
     if Assigned(TACBrNFSe( FACBrNFSe ).OnGerarLog)
      then TACBrNFSe( FACBrNFSe ).OnGerarLog('ERRO: Erro OnBeforePost: ' + IntToStr(GetLastError));
     raise Exception.Create( 'Erro OnBeforePost: ' + GetLastErrorText {IntToStr(GetLastError)} );
    end;
  end;

 if trim(FConfiguracoes.WebServices.ProxyUser) <> ''
  then begin
   if not InternetSetOption(Data, INTERNET_OPTION_PROXY_USERNAME, PChar(FConfiguracoes.WebServices.ProxyUser), Length(FConfiguracoes.WebServices.ProxyUser))
    then raise Exception.Create( 'Erro OnBeforePost: ' + IntToStr(GetLastError) );
   end;

 if trim(FConfiguracoes.WebServices.ProxyPass) <> ''
  then begin
   if not InternetSetOption(Data, INTERNET_OPTION_PROXY_PASSWORD, PChar(FConfiguracoes.WebServices.ProxyPass),Length (FConfiguracoes.WebServices.ProxyPass))
    then raise Exception.Create( 'Erro OnBeforePost: ' + IntToStr(GetLastError) );
   end;

  if (pos('SCERECEPCAORFB',UpperCase(FURL)) <= 0) and
     (pos('SCECONSULTARFB',UpperCase(FURL)) <= 0) then
   begin

     if FConfiguracoes.WebServices.VersaoSoap = '1.2'
      then ContentHeader := Format(ContentTypeTemplate, ['application/soap+xml; charset=utf-8'])
      else ContentHeader := Format(ContentTypeTemplate, ['text/xml; charset=utf-8']);

     HttpAddRequestHeaders(Data, PChar(ContentHeader), Length(ContentHeader), HTTP_ADDREQ_FLAG_REPLACE);
   end;
  HTTPReqResp.CheckContentType;
end;
{$ENDIF}

procedure TWebServicesBase.DoNFSeEnviarLoteRPS;
var
 i         : Integer;
 vNotas    : WideString;
 URI       : String;
 Separador : String;
begin
 vNotas := '';

 if RightStr(FHTTP_AG, 1) = '/'
  then Separador := ''
  else Separador := '/';

 if FCabecalho <> ''
  then begin
   if Prefixo2 <> ''
    then FNameSpaceCab := ' xmlns:' + stringReplace(Prefixo2, ':', '', []) + '="' + FHTTP_AG + Separador + FCabecalho +'">'
    else FNameSpaceCab := ' xmlns="' + FHTTP_AG + Separador + FCabecalho +'">';
  end
  else FNameSpaceCab := '>';

 if FServicoEnviar <> ''
  then begin
   if (RightStr(FHTTP_AG, 1) = '/')
    then begin
     if Prefixo3 <> ''
      then FNameSpaceDad := 'xmlns:' + stringReplace(Prefixo3, ':', '', []) + '="' + FHTTP_AG + Separador + FServicoEnviar + '"'
      else FNameSpaceDad := 'xmlns="' + FHTTP_AG + Separador + FServicoEnviar + '"';
    end
    else begin
     if Prefixo3 <> ''
      then FNameSpaceDad := 'xmlns:' + stringReplace(Prefixo3, ':', '', []) + '="' + FHTTP_AG + '"'
      else FNameSpaceDad := 'xmlns="' + FHTTP_AG + '"';
    end;
  end
  else FNameSpaceDad := '';

 if (FDefTipos = '') and (FNameSpaceDad <> '')
  then FNameSpaceDad := FNameSpaceDad + '>';

 if FDefTipos <> ''
  then begin
   if Prefixo4 <> ''
    then FNameSpaceDad := FNameSpaceDad +
                        ' xmlns:' + stringReplace(Prefixo4, ':', '', []) + '="' + FHTTP_AG + Separador + FDefTipos + '">'
    else FNameSpaceDad := FNameSpaceDad + ' xmlns="' + FHTTP_AG + Separador + FDefTipos + '">';
  end;

 if FNameSpaceDad = ''
  then FNameSpaceDad := '>'
  else FNameSpaceDad := ' ' + FNameSpaceDad;

 if FConfiguracoes.Certificados.AssinaRPS
  then begin
   for i := 0 to TNFSeEnviarLoteRPS(Self).FNotasFiscais.Count-1 do
    begin
     if (FProvedor in [profintelISS, proSaatri])
      then vNotas := vNotas + '<' + Prefixo4 + 'Rps>' +
                               '<' + Prefixo4 + 'InfDeclaracaoPrestacaoServico' +
                                 RetornarConteudoEntre(TNFSeEnviarLoteRPS(Self).FNotasFiscais.Items[I].XML_Rps_Ass,
                                   '<' + Prefixo4 + 'InfDeclaracaoPrestacaoServico', '</Signature>') +
                               '</Signature>'+
                              '</' + Prefixo4 + 'Rps>'
      else vNotas := vNotas + '<' + Prefixo4 + 'Rps>' +
                               '<' + Prefixo4 + 'InfRps' +
                                 RetornarConteudoEntre(TNFSeEnviarLoteRPS(Self).FNotasFiscais.Items[I].XML_Rps_Ass,
                                   '<' + Prefixo4 + 'InfRps', '</Rps>') +
                              '</' + Prefixo4 + 'Rps>';
    end;
  end
  else begin
   for i := 0 to TNFSeEnviarLoteRPS(Self).FNotasFiscais.Count-1 do
    begin
     if (FProvedor in [profintelISS, proSaatri])
      then vNotas := vNotas + '<' + Prefixo4 + 'Rps>' +
                               '<' + Prefixo4 + 'InfDeclaracaoPrestacaoServico' +
                                 RetornarConteudoEntre(TNFSeEnviarLoteRPS(Self).FNotasFiscais.Items[I].XML_Rps,
                                   '<' + Prefixo4 + 'InfDeclaracaoPrestacaoServico', '</' + Prefixo4 + 'InfDeclaracaoPrestacaoServico>') +
                               '</' + Prefixo4 + 'InfDeclaracaoPrestacaoServico>'+
                              '</' + Prefixo4 + 'Rps>'
      else vNotas := vNotas + '<' + Prefixo4 + 'Rps>' +
                               '<' + Prefixo4 + 'InfRps' +
                                 RetornarConteudoEntre(TNFSeEnviarLoteRPS(Self).FNotasFiscais.Items[I].XML_Rps,
                                   '<' + Prefixo4 + 'InfRps', '</Rps>') +
                              '</' + Prefixo4 + 'Rps>';
    end;
  end;

 FCabMsg := FProvedorClass.Gera_CabMsg(Prefixo2, FVersaoLayOut, FVersaoDados, NameSpaceCab);

 URI := '';

 URI := FProvedorClass.GetURI(URI);

 FTagI := FProvedorClass.Gera_TagI(acRecepcionar, Prefixo3, Prefixo4, NameSpaceDad, FConfiguracoes.WebServices.Identificador, URI);

 FDadosSenha := FProvedorClass.Gera_DadosSenha(FConfiguracoes.WebServices.UserWeb,
                                               FConfiguracoes.WebServices.SenhaWeb);
 FTagF := FProvedorClass.Gera_TagF(acRecepcionar, Prefixo3);

 FDadosMsg := FProvedorClass.Gera_DadosMsgEnviarLote(Prefixo3,
                                                     Prefixo4,
                                                     FConfiguracoes.WebServices.Identificador,
                                                     NameSpaceDad,
                                                     VersaoDados,
                                                     FVersaoXML,
                                                     IntToStr(TNFSeEnviarLoteRps(Self).NumeroLote),
                                                     SomenteNumeros(TNFSeEnviarLoteRPS(Self).FNotasFiscais.Items[0].NFSe.Prestador.Cnpj),
                                                     TNFSeEnviarLoteRPS(Self).FNotasFiscais.Items[0].NFSe.Prestador.InscricaoMunicipal,
                                                     IntToStr(TNFSeEnviarLoteRps(Self).FNotasFiscais.Count),
                                                     vNotas,
                                                     FTagI,
                                                     FTagF);

 if FConfiguracoes.WebServices.Salvar
  then FConfiguracoes.Geral.Save('-xxx1.xml', FDadosMsg);

 FDadosMsg := TNFSeEnviarLoteRPS(Self).FNotasFiscais.AssinarLoteRps(TNFSeEnviarLoteRps(Self).NumeroLote, FDadosMSg);

 if FConfiguracoes.WebServices.Salvar
  then FConfiguracoes.Geral.Save('-xxx2.xml', FDadosMsg);

 // Sugestão de Rodrigo Cantelli
 if FProvedorClass.GetValidarLote
  then begin
   if not(NotaUtil.Valida(FDadosMsg, FMsg,
                          FConfiguracoes.Geral.PathSchemas,
                          FConfiguracoes.WebServices.URL,
                          FConfiguracoes.WebServices.ServicoEnviar,
                          FConfiguracoes.WebServices.Prefixo4))
    then raise Exception.Create('Falha na validação do Lote ' +
                   IntToStr(TNFSeEnviarLoteRps(Self).NumeroLote) + sLineBreak + FMsg);
  end;
end;

procedure TWebServicesBase.DoNFSeConsultarSituacaoLoteRPS;
var
 URI       : String;
 Separador : String;
begin
 if RightStr(FHTTP_AG, 1) = '/'
  then Separador := ''
  else Separador := '/';

 if FCabecalho <> ''
  then begin
   if Prefixo2 <> ''
    then FNameSpaceCab := ' xmlns:' + stringReplace(Prefixo2, ':', '', []) + '="' + FHTTP_AG + Separador + FCabecalho +'">'
    else FNameSpaceCab := ' xmlns="' + FHTTP_AG + Separador + FCabecalho +'">';
  end
  else FNameSpaceCab := '>';

 if FServicoConSit <> ''
  then begin
   if RightStr(FHTTP_AG, 1) = '/'
    then begin
     if Prefixo3 <> ''
    then FNameSpaceDad := 'xmlns:' + stringReplace(Prefixo3, ':', '', []) + '="' + FHTTP_AG + Separador + FServicoConSit + '"'
    else FNameSpaceDad := 'xmlns="' + FHTTP_AG + Separador + FServicoConSit + '"';
    end
    else begin
     if Prefixo3 <> ''
      then FNameSpaceDad := 'xmlns:' + stringReplace(Prefixo3, ':', '', []) + '="' + FHTTP_AG + '"'
      else FNameSpaceDad := 'xmlns="' + FHTTP_AG + '"';
    end;
  end
  else FNameSpaceDad := '';

 if (FDefTipos = '') and (FNameSpaceDad <> '')
  then FNameSpaceDad := FNameSpaceDad + '>';

 if FDefTipos <> ''
  then begin
   if Prefixo4 <> ''
    then FNameSpaceDad := FNameSpaceDad +
                        ' xmlns:' + stringReplace(Prefixo4, ':', '', []) + '="' + FHTTP_AG + Separador + FDefTipos + '">'
    else FNameSpaceDad := FNameSpaceDad +
                        ' xmlns="' + FHTTP_AG + Separador + FDefTipos + '">';
  end;

 if FNameSpaceDad = ''
  then FNameSpaceDad := '>'
  else FNameSpaceDad := ' ' + FNameSpaceDad;

 FCabMsg := FProvedorClass.Gera_CabMsg(Prefixo2, FVersaoLayOut, FVersaoDados, NameSpaceCab);

 URI := '';

 URI := FProvedorClass.GetURI(URI);

 FTagI := FProvedorClass.Gera_TagI(acConsSit, Prefixo3, Prefixo4, NameSpaceDad, FConfiguracoes.WebServices.Identificador, URI);

 FDadosSenha := FProvedorClass.Gera_DadosSenha(FConfiguracoes.WebServices.UserWeb,
                                               FConfiguracoes.WebServices.SenhaWeb);

 FTagF := FProvedorClass.Gera_TagF(acConsSit, Prefixo3);

 FDadosMsg := FProvedorClass.Gera_DadosMsgConsSitLote(Prefixo3,
                                                      Prefixo4,
                                                      NameSpaceDad,
                                                      FVersaoXML,
                                                      TNFSeConsultarSituacaoLoteRPS(Self).Protocolo,
                                                      SomenteNumeros(TNFSeConsultarSituacaoLoteRPS(Self).Cnpj),
                                                      TNFSeConsultarSituacaoLoteRPS(Self).InscricaoMunicipal,
                                                      FTagI,
                                                      FTagF);

 if FProvedorClass.GetAssinarXML(acConsSit)
  then begin
   if not(NotaUtil.AssinarXML(FDadosMsg, URI, FTagI, FTagF,
                   FConfiguracoes.Certificados.GetCertificado, FvAssinada, FMsg))
    then raise Exception.Create('Falha ao assinar o XML ' + FMsg)
    else FDadosMsg := FvAssinada;
  end;
end;

procedure TWebServicesBase.DoNFSeConsultarLoteRPS;
var
 URI       : String;
 Separador : String;
begin
 if RightStr(FHTTP_AG, 1) = '/'
  then Separador := ''
  else Separador := '/';

 if FCabecalho <> ''
  then begin
   if Prefixo2 <> ''
    then FNameSpaceCab := ' xmlns:' + stringReplace(Prefixo2, ':', '', []) + '="' + FHTTP_AG + Separador + FCabecalho +'">'
    else FNameSpaceCab := ' xmlns="' + FHTTP_AG + Separador + FCabecalho +'">';
  end
  else FNameSpaceCab := '>';

 if FServicoConLot <> ''
  then begin
   if RightStr(FHTTP_AG, 1) = '/'
    then begin
     if Prefixo3 <> ''
    then FNameSpaceDad := 'xmlns:' + stringReplace(Prefixo3, ':', '', []) + '="' + FHTTP_AG + Separador + FServicoConLot + '"'
    else FNameSpaceDad := 'xmlns="' + FHTTP_AG + Separador + FServicoConLot + '"';
    end
    else begin
     if Prefixo3 <> ''
      then FNameSpaceDad := 'xmlns:' + stringReplace(Prefixo3, ':', '', []) + '="' + FHTTP_AG + '"'
      else FNameSpaceDad := 'xmlns="' + FHTTP_AG + '"';
    end;
  end
  else FNameSpaceDad := '';

 if (FDefTipos = '') and (FNameSpaceDad <> '')
  then FNameSpaceDad := FNameSpaceDad + '>';

 if FDefTipos <> ''
  then begin
   if Prefixo4 <> ''
    then FNameSpaceDad := FNameSpaceDad +
                        ' xmlns:' + stringReplace(Prefixo4, ':', '', []) + '="' + FHTTP_AG + Separador + FDefTipos + '">'
    else FNameSpaceDad := FNameSpaceDad +
                        ' xmlns="' + FHTTP_AG + Separador + FDefTipos + '">';
  end;

 if FNameSpaceDad = ''
  then FNameSpaceDad := '>'
  else FNameSpaceDad := ' ' + FNameSpaceDad;

 FCabMsg := FProvedorClass.Gera_CabMsg(Prefixo2, FVersaoLayOut, FVersaoDados, NameSpaceCab);

 URI := '';

 URI := FProvedorClass.GetURI(URI);

 FTagI := FProvedorClass.Gera_TagI(acConsLote, Prefixo3, Prefixo4, NameSpaceDad, FConfiguracoes.WebServices.Identificador, URI);

 if (TNFSeConsultarLoteRPS(Self).FCNPJ = '') then
    TNFSeConsultarLoteRPS(Self).FCNPJ:=SomenteNumeros(TNFSeConsultarLoteRPS(Self).FNotasFiscais.Items[0].NFSe.Prestador.Cnpj);
 if (TNFSeConsultarLoteRPS(Self).FIM = '') then
    TNFSeConsultarLoteRPS(Self).FIM:=TNFSeConsultarLoteRPS(Self).FNotasFiscais.Items[0].NFSe.Prestador.InscricaoMunicipal;

 FDadosSenha := FProvedorClass.Gera_DadosSenha(FConfiguracoes.WebServices.UserWeb,
                                               FConfiguracoes.WebServices.SenhaWeb);

 FTagF := FProvedorClass.Gera_TagF(acConsLote, Prefixo3);

 FDadosMsg := FProvedorClass.Gera_DadosMsgConsLote(Prefixo3,
                                                   Prefixo4,
                                                   NameSpaceDad,
                                                   FVersaoXML,
                                                   // Alterado por Rodrigo Cantelli
                                                   TNFSeConsultarLoteRPS(Self).Protocolo,
                                                   TNFSeConsultarLoteRPS(Self).FCNPJ,
                                                   TNFSeConsultarLoteRPS(Self).FIM,
                                                   FTagI,
                                                   FTagF);

 if FProvedorClass.GetAssinarXML(acConsLote)
  then begin
   if not(NotaUtil.AssinarXML(FDadosMsg, URI, FTagI, FTagF,
                   FConfiguracoes.Certificados.GetCertificado, FvAssinada, FMsg))
    then raise Exception.Create('Falha ao assinar o XML ' + FMsg)
    else FDadosMsg := FvAssinada;
  end;
end;

procedure TWebServicesBase.DoNFSeConsultarNFSeporRPS;
var
 URI       : String;
 Separador : String;
begin
 if RightStr(FHTTP_AG, 1) = '/'
  then Separador := ''
  else Separador := '/';

 if FCabecalho <> ''
  then begin
   if Prefixo2 <> ''
    then FNameSpaceCab := ' xmlns:' + stringReplace(Prefixo2, ':', '', []) + '="' + FHTTP_AG + Separador + FCabecalho +'">'
    else FNameSpaceCab := ' xmlns="' + FHTTP_AG + Separador + FCabecalho +'">';
  end
  else FNameSpaceCab := '>';

 if FServicoConRps <> ''
  then begin
   if RightStr(FHTTP_AG, 1) = '/'
    then begin
     if Prefixo3 <> ''
    then FNameSpaceDad := 'xmlns:' + stringReplace(Prefixo3, ':', '', []) + '="' + FHTTP_AG + Separador + FServicoConRps + '"'
    else FNameSpaceDad := 'xmlns="' + FHTTP_AG + Separador + FServicoConRps + '"';
    end
    else begin
     if Prefixo3 <> ''
      then FNameSpaceDad := 'xmlns:' + stringReplace(Prefixo3, ':', '', []) + '="' + FHTTP_AG + '"'
      else FNameSpaceDad := 'xmlns="' + FHTTP_AG + '"';
    end;
  end
  else FNameSpaceDad := '';

 if (FDefTipos = '') and (FNameSpaceDad <> '')
  then FNameSpaceDad := FNameSpaceDad + '>';

 if FDefTipos <> ''
  then begin
   if Prefixo4 <> ''
    then FNameSpaceDad := FNameSpaceDad +
                        ' xmlns:' + stringReplace(Prefixo4, ':', '', []) + '="' + FHTTP_AG + Separador + FDefTipos + '">'
    else FNameSpaceDad := FNameSpaceDad +
                        ' xmlns="' + FHTTP_AG + Separador + FDefTipos + '">';
  end;

 if FNameSpaceDad = ''
  then FNameSpaceDad := '>'
  else FNameSpaceDad := ' ' + FNameSpaceDad;

 FCabMsg := FProvedorClass.Gera_CabMsg(Prefixo2, FVersaoLayOut, FVersaoDados, NameSpaceCab);

 URI := '';

 URI := FProvedorClass.GetURI(URI);

 FTagI := FProvedorClass.Gera_TagI(acConsNFSeRps, Prefixo3, Prefixo4, NameSpaceDad, FConfiguracoes.WebServices.Identificador, URI);

 FDadosSenha := FProvedorClass.Gera_DadosSenha(FConfiguracoes.WebServices.UserWeb,
                                               FConfiguracoes.WebServices.SenhaWeb);

 FTagF := FProvedorClass.Gera_TagF(acConsNFSeRps, Prefixo3);

 FDadosMsg := FProvedorClass.Gera_DadosMsgConsNFSeRPS(Prefixo3,
                                                      Prefixo4,
                                                      FVersaoXML,
                                                      TNFSeConsultarNfseRPS(Self).Numero,
                                                      TNFSeConsultarNfseRPS(Self).Serie,
                                                      TNFSeConsultarNfseRPS(Self).Tipo,
                                                      SomenteNumeros(TNFSeConsultarNfseRPS(Self).Cnpj),
                                                      TNFSeConsultarNfseRPS(Self).InscricaoMunicipal,
                                                      FTagI,
                                                      FTagF);

 if FProvedorClass.GetAssinarXML(acConsNFSeRps)
  then begin
   if not(NotaUtil.AssinarXML(FDadosMsg, URI, FTagI, FTagF,
                   FConfiguracoes.Certificados.GetCertificado, FvAssinada, FMsg))
    then raise Exception.Create('Falha ao assinar o XML ' + FMsg)
    else FDadosMsg := FvAssinada;
  end;

end;

procedure TWebServicesBase.DoNFSeConsultarNFSe;
var
 URI       : String;
 Separador : String;
begin
 if RightStr(FHTTP_AG, 1) = '/'
  then Separador := ''
  else Separador := '/';

 if FCabecalho <> ''
  then begin
   if Prefixo2 <> ''
    then FNameSpaceCab := ' xmlns:' + stringReplace(Prefixo2, ':', '', []) + '="' + FHTTP_AG + Separador + FCabecalho +'">'
    else FNameSpaceCab := ' xmlns="' + FHTTP_AG + Separador + FCabecalho +'">';
  end
  else FNameSpaceCab := '>';

 if FServicoConNfse <> ''
  then begin
   if RightStr(FHTTP_AG, 1) = '/'
    then begin
     if Prefixo3 <> ''
    then FNameSpaceDad := 'xmlns:' + stringReplace(Prefixo3, ':', '', []) + '="' + FHTTP_AG + Separador + FServicoConNfse + '"'
    else FNameSpaceDad := 'xmlns="' + FHTTP_AG + Separador + FServicoConNfse + '"';
    end
    else begin
     if Prefixo3 <> ''
      then FNameSpaceDad := 'xmlns:' + stringReplace(Prefixo3, ':', '', []) + '="' + FHTTP_AG + '"'
      else FNameSpaceDad := 'xmlns="' + FHTTP_AG + '"';
    end;
  end
  else FNameSpaceDad := '';

 if (FDefTipos = '') and (FNameSpaceDad <> '')
  then FNameSpaceDad := FNameSpaceDad + '>';

 if FDefTipos <> ''
  then begin
   if Prefixo4 <> ''
    then FNameSpaceDad := FNameSpaceDad +
                        ' xmlns:' + stringReplace(Prefixo4, ':', '', []) + '="' + FHTTP_AG + Separador + FDefTipos + '">'
    else FNameSpaceDad := FNameSpaceDad +
                        ' xmlns="' + FHTTP_AG + Separador + FDefTipos + '">';
  end;

 if FNameSpaceDad = ''
  then FNameSpaceDad := '>'
  else FNameSpaceDad := ' ' + FNameSpaceDad;

 FCabMsg := FProvedorClass.Gera_CabMsg(Prefixo2, FVersaoLayOut, FVersaoDados, NameSpaceCab);

 URI := '';

 URI := FProvedorClass.GetURI(URI);

 FTagI := FProvedorClass.Gera_TagI(acConsNFSe, Prefixo3, Prefixo4, NameSpaceDad, FConfiguracoes.WebServices.Identificador, URI);

 FDadosSenha := FProvedorClass.Gera_DadosSenha(FConfiguracoes.WebServices.UserWeb,
                                               FConfiguracoes.WebServices.SenhaWeb);

 FTagF := FProvedorClass.Gera_TagF(acConsNFSe, Prefixo3);

 FDadosMsg := FProvedorClass.Gera_DadosMsgConsNFSe(Prefixo3,
                                                   Prefixo4,
                                                   FVersaoXML,
                                                   SomenteNumeros(TNFSeConsultarNfse(Self).Cnpj),
                                                   TNFSeConsultarNfse(Self).InscricaoMunicipal,
                                                   TNFSeConsultarNfse(Self).DataInicial,
                                                   TNFSeConsultarNfse(Self).DataFinal,
                                                   FTagI,
                                                   FTagF);

 if FProvedorClass.GetAssinarXML(acConsNFSe)
  then begin
   if not(NotaUtil.AssinarXML(FDadosMsg, URI, FTagI, FTagF,
                   FConfiguracoes.Certificados.GetCertificado, FvAssinada, FMsg))
    then raise Exception.Create('Falha ao assinar o XML ' + FMsg)
    else FDadosMsg := FvAssinada;
  end;

end;

procedure TWebServicesBase.DoNFSeCancelarNFSe;
var
 URI       : String;
 Separador : String;
begin
 if RightStr(FHTTP_AG, 1) = '/'
  then Separador := ''
  else Separador := '/';

 if FCabecalho <> ''
  then begin
   if Prefixo2 <> ''
    then FNameSpaceCab := ' xmlns:' + stringReplace(Prefixo2, ':', '', []) + '="' + FHTTP_AG + Separador + FCabecalho +'">'
    else FNameSpaceCab := ' xmlns="' + FHTTP_AG + Separador + FCabecalho +'">';
  end
  else FNameSpaceCab := '>';

 if FServicoCancelar <> ''
  then begin
   if RightStr(FHTTP_AG, 1) = '/'
    then begin
     if Prefixo3 <> ''
    then FNameSpaceDad := 'xmlns:' + stringReplace(Prefixo3, ':', '', []) + '="' + FHTTP_AG + Separador + FServicoCancelar + '"'
    else FNameSpaceDad := 'xmlns="' + FHTTP_AG + Separador + FServicoCancelar + '"';
    end
    else begin
     if Prefixo3 <> ''
      then FNameSpaceDad := 'xmlns:' + stringReplace(Prefixo3, ':', '', []) + '="' + FHTTP_AG + '"'
      else FNameSpaceDad := 'xmlns="' + FHTTP_AG + '"';
    end;
  end
  else FNameSpaceDad := '';

 if (FDefTipos = '') and (FNameSpaceDad <> '')
  then FNameSpaceDad := FNameSpaceDad + '>';

 if FDefTipos <> ''
  then begin
   if Prefixo4 <> ''
    then begin
     if (FProvedor = proGINFES)
      then begin
       FVersaoLayOut := '2';
       FVersaoDados  := '2';
       FDefTipos     := 'tipos_v02.xsd';
      end;
     FNameSpaceDad := FNameSpaceDad +
                        ' xmlns:' + stringReplace(Prefixo4, ':', '', []) + '="' + FHTTP_AG + Separador + FDefTipos + '">';
    end
    else FNameSpaceDad := FNameSpaceDad +
                        ' xmlns="' + FHTTP_AG + Separador + FDefTipos + '">';
  end;

 if FNameSpaceDad = ''
  then FNameSpaceDad := '>'
  else FNameSpaceDad := ' ' + FNameSpaceDad;

 if (TNFSeCancelarNfse(Self).FNumeroRPS = '') then
    TNFSeCancelarNfse(Self).FNumeroRPS:=TNFSeCancelarNfse(Self).FNotasFiscais.Items[0].NFSe.Numero;
 if (TNFSeCancelarNfse(Self).FCNPJ = '') then
    TNFSeCancelarNfse(Self).FCNPJ:=SomenteNumeros(TNFSeCancelarNfse(Self).FNotasFiscais.Items[0].NFSe.PrestadorServico.IdentificacaoPrestador.Cnpj);
 if (TNFSeCancelarNfse(Self).FIM = '') then
    TNFSeCancelarNfse(Self).FIM:=TNFSeCancelarNfse(Self).FNotasFiscais.Items[0].NFSe.PrestadorServico.IdentificacaoPrestador.InscricaoMunicipal;
 if (TNFSeCancelarNfse(Self).FCodigoMunicipio = '') then
    TNFSeCancelarNfse(Self).FCodigoMunicipio:=TNFSeCancelarNfse(Self).FNotasFiscais.Items[0].NFSe.PrestadorServico.Endereco.CodigoMunicipio;

 FDadosSenha := FProvedorClass.Gera_DadosSenha(FConfiguracoes.WebServices.UserWeb,
                                               FConfiguracoes.WebServices.SenhaWeb);

 FCabMsg := FProvedorClass.Gera_CabMsg(Prefixo2, FVersaoLayOut, FVersaoDados, NameSpaceCab);

 case FProvedor of
  proSaatri: URI := 'Cancelamento_' + TNFSeCancelarNfse(Self).FCnpj;
 else        URI := 'pedidoCancelamento_' + TNFSeCancelarNfse(Self).FCnpj +
                    TNFSeCancelarNfse(Self).FIM + TNFSeCancelarNfse(Self).FNumeroRPS;
 end;

 URI := FProvedorClass.GetURI(URI);

 FTagI := FProvedorClass.Gera_TagI(acCancelar, Prefixo3, Prefixo4, NameSpaceDad, FConfiguracoes.WebServices.Identificador, URI);

 FTagF := FProvedorClass.Gera_TagF(acCancelar, Prefixo3);

 FDadosMsg := FProvedorClass.Gera_DadosMsgCancelarNFSe(Prefixo4,
                                                       TNFSeCancelarNfse(Self).FNumeroRPS,
                                                       TNFSeCancelarNfse(Self).FCnpj,
                                                       TNFSeCancelarNfse(Self).FIM,
                                                       TNFSeCancelarNfse(Self).FCodigoMunicipio,
                                                       TNFSeCancelarNfse(Self).FCodigoCancelamento,
                                                       FTagI,
                                                       FTagF);

 if FProvedorClass.GetAssinarXML(acCancelar)
  then begin
   if not(NotaUtil.AssinarXML(FDadosMsg, URI, FTagI, FTagF,
                   FConfiguracoes.Certificados.GetCertificado, FvAssinada, FMsg))
    then raise Exception.Create('Falha ao assinar o XML ' + FMsg)
    else FDadosMsg := FvAssinada;
  end;
end;

function TWebServicesBase.Executar: Boolean;
begin
 Result := False;
 LoadMsgEntrada;
 LoadURL;
end;

procedure TWebServicesBase.LoadMsgEntrada;
begin
 FxProvedor := FConfiguracoes.WebServices.xProvedor;
 FProvedor  := FConfiguracoes.WebServices.Provedor;

 FProvedorClass.Free;

 case FProvedor of
  proGINFES:    FProvedorClass := TProvedorGinfesV3.Create;
  proPublica:   FProvedorClass := TProvedorPublica.Create;
  proRJ:        FProvedorClass := TProvedorRJ.Create;
  proTiplan:    FProvedorClass := TProvedorTiplan.Create;
  proISSNet:    FProvedorClass := TProvedorISSNet.Create;
  proWebISS:    FProvedorClass := TProvedorWebISS.Create;
  proProdemge:  FProvedorClass := TProvedorProdemge.Create;
  proISSIntel:  FProvedorClass := TProvedorISSIntel.Create;
  proGovBR:     FProvedorClass := TProvedorGovBR.Create;
  proRecife:    FProvedorClass := TProvedorRecife.Create;
  proSimplISS:  FProvedorClass := TProvedorSimplISS.Create;
  proThema:     FProvedorClass := TProvedorThema.Create;
  proEquiplano: FProvedorClass := TProvedorEquiplano.Create;
  profintelISS: FProvedorClass := TProvedorfintelISS.Create;
  proDigifred:  FProvedorClass := TProvedorDigifred.Create;
  proBetha:     FProvedorClass := TProvedorBetha.Create;
  proBetim:     FProvedorClass := TProvedorBetim.Create;
  proSaatri:    FProvedorClass := TProvedorSaatri.Create;
 end;

 FPrefixo2     := FConfiguracoes.WebServices.Prefixo2;
 FPrefixo3     := FConfiguracoes.WebServices.Prefixo3;
 FPrefixo4     := FConfiguracoes.WebServices.Prefixo4;
 FURLNS1       := FConfiguracoes.WebServices.NameSpace;

 FVersaoLayOut    := FConfiguracoes.WebServices.VersaoCabecalho;
 FVersaoDados     := FConfiguracoes.WebServices.VersaoDados;
 FVersaoXML       := FConfiguracoes.WebServices.VersaoXML;
 FHTTP_AG         := FConfiguracoes.WebServices.URL;
 FCabecalho       := FConfiguracoes.WebServices.Cabecalho;
 FServicoEnviar   := FConfiguracoes.WebServices.ServicoEnviar;
 FServicoConSit   := FConfiguracoes.WebServices.ServicoConSit;
 FServicoConLot   := FConfiguracoes.WebServices.ServicoConLot;
 FServicoConRps   := FConfiguracoes.WebServices.ServicoConRps;
 FServicoConNfse  := FConfiguracoes.WebServices.ServicoConNfse;
 FServicoCancelar := FConfiguracoes.WebServices.ServicoCancelar;
 FServicoGerar    := FConfiguracoes.WebServices.ServicoGerar;
 FDefTipos        := FConfiguracoes.WebServices.DefTipos;

 if self is TNFSeEnviarLoteRps
  then DoNFSeEnviarLoteRps
  else if self is TNFSeConsultarSituacaoLoteRps
  then DoNFSeConsultarSituacaoLoteRps
  else if self is TNFSeConsultarLoteRps
  then DoNFSeConsultarLoteRps
  else if self is TNFSeConsultarNfseRps
  then DoNFSeConsultarNfseporRps
  else if self is TNFSeConsultarNfse
  then DoNFSeConsultarNfse
  else if self is TNFSeCancelarNfse
  then DoNFSeCancelarNfse
  else if self is TNFSeGerarNfse
  then DoNFSeGerarNfse;
end;

procedure TWebServicesBase.LoadURL;
begin
 if FConfiguracoes.WebServices.AmbienteCodigo = 1
  then begin
   FNomeCidade         := FConfiguracoes.WebServices.ProNomeCidade;
   FRecepcaoLoteRps    := FConfiguracoes.WebServices.ProRecepcaoLoteRPS;
   FConsultaLoteRps    := FConfiguracoes.WebServices.ProConsultaLoteRPS;
   FConsultaNFSeRps    := FConfiguracoes.WebServices.ProConsultaNFSeRPS;
   FConsultaSitLoteRps := FConfiguracoes.WebServices.ProConsultaSitLoteRPS;
   FConsultaNFSe       := FConfiguracoes.WebServices.ProConsultaNFSe;
   FCancelaNFSe        := FConfiguracoes.WebServices.ProCancelaNFSe;
   FGerarNFSe          := FConfiguracoes.WebServices.ProGerarNFSe;
  end
  else begin
   FNomeCidade         := FConfiguracoes.WebServices.HomNomeCidade;
   FRecepcaoLoteRps    := FConfiguracoes.WebServices.HomRecepcaoLoteRPS;
   FConsultaLoteRps    := FConfiguracoes.WebServices.HomConsultaLoteRPS;
   FConsultaNFSeRps    := FConfiguracoes.WebServices.HomConsultaNFSeRPS;
   FConsultaSitLoteRps := FConfiguracoes.WebServices.HomConsultaSitLoteRPS;
   FConsultaNFSe       := FConfiguracoes.WebServices.HomConsultaNFSe;
   FCancelaNFSe        := FConfiguracoes.WebServices.HomCancelaNFSe;
   FGerarNFSe          := FConfiguracoes.WebServices.HomGerarNFSe;
  end;

 if self is TNFSeEnviarLoteRps
  then FURL := FRecepcaoLoteRps
  else if self is TNFSeConsultarSituacaoLoteRps
  then FURL := FConsultaSitLoteRps
  else if self is TNFSeConsultarLoteRps
  then FURL := FConsultaLoteRps
  else if self is TNFSeConsultarNfseRps
  then FURL := FConsultaNFSeRps
  else if self is TNFSeConsultarNfse
  then FURL := FConsultaNFSe
  else if self is TNFSeCancelarNfse
  then FURL := FCancelaNFSe
  else if self is TNFSeGerarNfse
  then FURL := FGerarNFSe;
end;

procedure TWebServicesBase.DoNFSeGerarNFSe;
var
 i         : Integer;
 vNotas    : WideString;
 URI       : String;
 Separador : String;
begin
 vNotas := '';

 if RightStr(FHTTP_AG, 1) = '/'
  then Separador := ''
  else Separador := '/';

 if FCabecalho <> ''
  then begin
   if Prefixo2 <> ''
    then FNameSpaceCab := ' xmlns:' + stringReplace(Prefixo2, ':', '', []) + '="' + FHTTP_AG + Separador + FCabecalho +'">'
    else FNameSpaceCab := ' xmlns="' + FHTTP_AG + Separador + FCabecalho +'">';
  end
  else FNameSpaceCab := '>';

 if FServicoGerar <> ''
  then begin
   if RightStr(FHTTP_AG, 1) = '/'
    then begin
     if Prefixo3 <> ''
      then FNameSpaceDad := 'xmlns:' + stringReplace(Prefixo3, ':', '', []) + '="' + FHTTP_AG + Separador + FServicoGerar + '"'
      else FNameSpaceDad := 'xmlns="' + FHTTP_AG + Separador + FServicoGerar + '"';
    end
    else begin
     if Prefixo3 <> ''
      then FNameSpaceDad := 'xmlns:' + stringReplace(Prefixo3, ':', '', []) + '="' + FHTTP_AG + '"'
      else FNameSpaceDad := 'xmlns="' + FHTTP_AG + '"';
    end;
  end
  else FNameSpaceDad := '';

 if (FDefTipos = '') and (FNameSpaceDad <> '')
  then FNameSpaceDad := FNameSpaceDad + '>';

 if FDefTipos <> ''
  then begin
   if Prefixo4 <> ''
    then FNameSpaceDad := FNameSpaceDad +
                        ' xmlns:' + stringReplace(Prefixo4, ':', '', []) + '="' + FHTTP_AG + Separador + FDefTipos + '">'
    else FNameSpaceDad := FNameSpaceDad + ' xmlns="' + FHTTP_AG + Separador + FDefTipos + '">';
  end;

 if FNameSpaceDad = ''
  then FNameSpaceDad := '>'
  else FNameSpaceDad := ' ' + FNameSpaceDad;

 if FConfiguracoes.Certificados.AssinaRPS
  then begin
   for i := 0 to TNFSeGerarNFSe(Self).FNotasFiscais.Count-1 do
    begin
     if (FProvedor in [profintelISS, proSaatri])
      then vNotas := vNotas + '<' + Prefixo4 + 'Rps>' +
                               '<' + Prefixo4 + 'InfDeclaracaoPrestacaoServico' +
                                 RetornarConteudoEntre(TNFSeGerarNFSe(Self).FNotasFiscais.Items[I].XML_Rps_Ass,
                                   '<' + Prefixo4 + 'InfDeclaracaoPrestacaoServico', '</Signature>') +
                               '</Signature>'+
                              '</' + Prefixo4 + 'Rps>'
      else vNotas := vNotas + '<' + Prefixo4 + 'Rps>' +
                               '<' + Prefixo4 + 'InfRps' +
                                 RetornarConteudoEntre(TNFSeGerarNFSe(Self).FNotasFiscais.Items[I].XML_Rps_Ass,
                                   '<' + Prefixo4 + 'InfRps', '</Rps>') +
                              '</' + Prefixo4 + 'Rps>';
    end;
  end
  else begin
   for i := 0 to TNFSeGerarNFSe(Self).FNotasFiscais.Count-1 do
    begin
     if (FProvedor in [profintelISS, proSaatri])
      then vNotas := vNotas + '<' + Prefixo4 + 'Rps>' +
                               '<' + Prefixo4 + 'InfDeclaracaoPrestacaoServico' +
                                 RetornarConteudoEntre(TNFSeGerarNFSe(Self).FNotasFiscais.Items[I].XML_Rps,
                                   '<' + Prefixo4 + 'InfDeclaracaoPrestacaoServico', '</' + Prefixo4 + 'InfDeclaracaoPrestacaoServico>') +
                               '</' + Prefixo4 + 'InfDeclaracaoPrestacaoServico>'+
                              '</' + Prefixo4 + 'Rps>'
      else vNotas := vNotas + '<' + Prefixo4 + 'Rps>' +
                               '<' + Prefixo4 + 'InfRps' +
                                 RetornarConteudoEntre(TNFSeGerarNFSe(Self).FNotasFiscais.Items[I].XML_Rps,
                                   '<' + Prefixo4 + 'InfRps', '</Rps>') +
                              '</' + Prefixo4 + 'Rps>';
    end;
  end;

 FCabMsg := FProvedorClass.Gera_CabMsg(Prefixo2, FVersaoLayOut, FVersaoDados, NameSpaceCab);

 URI := '';

 URI := FProvedorClass.GetURI(URI);

 FTagI := FProvedorClass.Gera_TagI(acGerar, Prefixo3, Prefixo4, NameSpaceDad, FConfiguracoes.WebServices.Identificador, URI);

 FDadosSenha := FProvedorClass.Gera_DadosSenha(FConfiguracoes.WebServices.UserWeb,
                                               FConfiguracoes.WebServices.SenhaWeb);

 FTagF := FProvedorClass.Gera_TagF(acGerar, Prefixo3);

 FDadosMsg := FProvedorClass.Gera_DadosMsgGerarNFSe(Prefixo3,
                                                     Prefixo4,
                                                     FConfiguracoes.WebServices.Identificador,
                                                     NameSpaceDad,
                                                     VersaoDados,
                                                     FVersaoXML,
                                                     IntToStr(TNFSeGerarNFSe(Self).NumeroRps),
                                                     SomenteNumeros(TNFSeGerarNFSe(Self).FNotasFiscais.Items[0].NFSe.Prestador.Cnpj),
                                                     TNFSeGerarNFSe(Self).FNotasFiscais.Items[0].NFSe.Prestador.InscricaoMunicipal,
                                                     IntToStr(TNFSeGerarNFSe(Self).FNotasFiscais.Count),
                                                     vNotas,
                                                     FTagI,
                                                     FTagF);

 if FConfiguracoes.WebServices.Salvar
  then FConfiguracoes.Geral.Save('-xxx1.xml', FDadosMsg);

 FDadosMsg := TNFSeGerarNFSe(Self).FNotasFiscais.AssinarLoteRps(TNFSeGerarNFSe(Self).NumeroRps, FDadosMSg);

 if FConfiguracoes.WebServices.Salvar
  then FConfiguracoes.Geral.Save('-xxx2.xml', FDadosMsg);

 if FProvedorClass.GetValidarLote
  then begin
   if not(NotaUtil.Valida(FDadosMsg, FMsg,
                          FConfiguracoes.Geral.PathSchemas,
                          FConfiguracoes.WebServices.URL,
                          FConfiguracoes.WebServices.ServicoEnviar,
                          FConfiguracoes.WebServices.Prefixo4))
    then raise Exception.Create('Falha na validação do Lote ' +
                   IntToStr(TNFSeEnviarLoteRps(Self).NumeroLote) + sLineBreak + FMsg);
  end;
end;

{ TWebServices }

constructor TWebServices.Create(AFNotaFiscalEletronica: TComponent);
begin
 inherited Create( AFNotaFiscalEletronica );

 FACBrNFSe    := TACBrNFSe(AFNotaFiscalEletronica);
 FEnviar      := TNFSeEnviarLoteRPS.Create(AFNotaFiscalEletronica, TACBrNFSe(AFNotaFiscalEletronica).NotasFiscais);
 FConsSitLote := TNFSeConsultarSituacaoLoteRPS.Create(AFNotaFiscalEletronica, TACBrNFSe(AFNotaFiscalEletronica).NotasFiscais);
 FConsLote    := TNFSeConsultarLoteRPS.Create(AFNotaFiscalEletronica, TACBrNFSe(AFNotaFiscalEletronica).NotasFiscais);
 FConsNfseRps := TNFSeConsultarNfseRPS.Create(AFNotaFiscalEletronica, TACBrNFSe(AFNotaFiscalEletronica).NotasFiscais);
 FConsNfse    := TNFSeConsultarNfse.Create(AFNotaFiscalEletronica, TACBrNFSe(AFNotaFiscalEletronica).NotasFiscais);
 FCancNfse    := TNFSeCancelarNfse.Create(AFNotaFiscalEletronica, TACBrNFSe(AFNotaFiscalEletronica).NotasFiscais);
 FGerarNFSe   := TNFSeGerarNFSe.Create(AFNotaFiscalEletronica, TACBrNFSe(AFNotaFiscalEletronica).NotasFiscais);
end;

destructor TWebServices.Destroy;
begin
 FEnviar.Free;
 FConsSitLote.Free;
 FConsLote.Free;
 FConsNfseRps.Free;
 FConsNfse.Free;
 FCancNfse.Free;
 FGerarNFSe.Free;
 
 inherited;
end;

function TWebServices.Envia(ALote:Integer): Boolean;
begin
 self.Enviar.FNumeroLote := ALote;

 if not (Self.Enviar.Executar)
  then begin
   if Assigned(TACBrNFSe( FACBrNFSe ).OnGerarLog)
    then TACBrNFSe( FACBrNFSe ).OnGerarLog(Self.Enviar.Msg);
   raise Exception.Create(Self.Enviar.Msg);
  end;

 Self.ConsSitLote.Cnpj               := TACBrNFSe( FACBrNFSe ).NotasFiscais.Items[0].NFSe.Prestador.Cnpj;
 Self.ConsSitLote.InscricaoMunicipal := TACBrNFSe( FACBrNFSe ).NotasFiscais.Items[0].NFSe.Prestador.InscricaoMunicipal;
 Self.ConsSitLote.Protocolo          := Self.Enviar.Protocolo;

 Self.ConsLote.Protocolo := Self.Enviar.Protocolo;

 // Alterado por Akai L. Massao Aihara
 if not (TACBrNFSe( FACBrNFSe ).Configuracoes.WebServices.Provedor in [profintelISS, proSaatri])
  then begin
   if not (Self.ConsSitLote.Executar)
    then begin
     if Assigned(TACBrNFSe( FACBrNFSe ).OnGerarLog)
      then TACBrNFSe( FACBrNFSe ).OnGerarLog(Self.ConsSitLote.Msg);
     raise Exception.Create(Self.ConsSitLote.Msg);
    end;
  end;

 if not (Self.ConsLote.Executar)
  then begin
   if Assigned(TACBrNFSe( FACBrNFSe ).OnGerarLog)
    then TACBrNFSe( FACBrNFSe ).OnGerarLog(Self.ConsLote.Msg);
   raise Exception.Create(Self.ConsLote.Msg);
  end;

 Result := true;
end;

function TWebServices.ConsultaSituacao(ACnpj, AInscricaoMunicipal,
  AProtocolo: String): Boolean;
begin
 ACnpj := OnlyNumber(ACnpj);
 if not ValidarCNPJ(ACnpj) then
  raise Exception.Create('CNPJ '+ACnpj+' inválido.');

 Self.ConsSitLote.Cnpj               := ACnpj;
 Self.ConsSitLote.InscricaoMunicipal := AInscricaoMunicipal;
 Self.ConsSitLote.Protocolo          := AProtocolo;

 if not (Self.ConsSitLote.Executar)
  then begin
   if Assigned(TACBrNFSe( FACBrNFSe ).OnGerarLog)
    then TACBrNFSe( FACBrNFSe ).OnGerarLog(Self.ConsSitLote.Msg);
   raise Exception.Create(Self.ConsSitLote.Msg);
  end;

 Result := true;
end;

function TWebServices.ConsultaLoteRps(AProtocolo: String;
  const CarregaProps: boolean): Boolean;
begin
  if CarregaProps then
  begin
     Self.ConsLote.CNPJ := '';
     Self.ConsLote.IM := '';
  end;

 Self.ConsLote.Protocolo := AProtocolo;

 if not (Self.ConsLote.Executar)
  then begin
   if Assigned(TACBrNFSe( FACBrNFSe ).OnGerarLog)
    then TACBrNFSe( FACBrNFSe ).OnGerarLog(Self.ConsLote.Msg);
   raise Exception.Create(Self.ConsLote.Msg);
  end;

 Result := true;
end;

function TWebServices.ConsultaLoteRps(AProtocolo, ACNPJ,
  AInscricaoMunicipal: string): Boolean;
begin
 Self.ConsLote.CNPJ := ACNPJ;
 Self.ConsLote.IM := AInscricaoMunicipal;

 Result := ConsultaLoteRPS(AProtocolo,False);
end;

function TWebServices.ConsutaNFSeporRps(ANumero, ASerie, ATipo, ACnpj,
  AInscricaoMunicipal: String): Boolean;
begin
 ACnpj := OnlyNumber(ACnpj);
 if not ValidarCNPJ(ACnpj) then
  raise Exception.Create('CNPJ '+ACnpj+' inválido.');

 Self.ConsNfseRps.Numero             := ANumero;
 Self.ConsNfseRps.Serie              := ASerie;
 Self.ConsNfseRps.Tipo               := ATipo;
 Self.ConsNfseRps.Cnpj               := ACnpj;
 Self.ConsNfseRps.InscricaoMunicipal := AInscricaoMunicipal;

 if not (Self.ConsNfseRps.Executar)
  then begin
   if Assigned(TACBrNFSe( FACBrNFSe ).OnGerarLog)
    then TACBrNFSe( FACBrNFSe ).OnGerarLog(Self.ConsNfseRps.Msg);
   raise Exception.Create(Self.ConsNfseRps.Msg);
  end;

 Result := true;
end;

function TWebServices.ConsutaNFSe(ACnpj, AInscricaoMunicipal: String;
  ADataInicial, ADataFinal: TDateTime): Boolean;
begin
 ACnpj := OnlyNumber(ACnpj);
 if not ValidarCNPJ(ACnpj) then
  raise Exception.Create('CNPJ '+ACnpj+' inválido.');

 Self.ConsNfse.Cnpj               := ACnpj;
 Self.ConsNfse.InscricaoMunicipal := AInscricaoMunicipal;
 Self.ConsNfse.DataInicial        := ADataInicial;
 Self.ConsNfse.DataFinal          := ADataFinal;

 if not (Self.ConsNfse.Executar)
  then begin
   if Assigned(TACBrNFSe( FACBrNFSe ).OnGerarLog)
    then TACBrNFSe( FACBrNFSe ).OnGerarLog(Self.ConsNfse.Msg);
   raise Exception.Create(Self.ConsNfse.Msg);
  end;

 Result := true;
end;

function TWebServices.CancelaNFSe(ACodigoCancelamento: String;
  const CarregaProps: boolean): Boolean;
begin
  if CarregaProps then
  begin
    Self.CancNfse.NumeroRPS := '';
    Self.CancNfse.CNPJ := '';
    Self.CancNfse.IM := '';
    Self.CancNfse.CodigoMunicipio := '';
  end;

 Self.CancNfse.CodigoCancelamento := ACodigoCancelamento;

 if not (Self.CancNfse.Executar)
  then begin
   if Assigned(TACBrNFSe( FACBrNFSe ).OnGerarLog)
    then TACBrNFSe( FACBrNFSe ).OnGerarLog(Self.CancNfse.Msg);
   raise Exception.Create(Self.CancNfse.Msg);
  end;

 // Incluido por Italo em 03/04/2012
 Self.ConsNfseRps.Numero             := TACBrNFSe( FACBrNFSe ).NotasFiscais.Items[0].NFSe.IdentificacaoRps.Numero;
 Self.ConsNfseRps.Serie              := TACBrNFSe( FACBrNFSe ).NotasFiscais.Items[0].NFSe.IdentificacaoRps.Serie;
 Self.ConsNfseRps.Tipo               := TipoRPSToStr(TACBrNFSe( FACBrNFSe ).NotasFiscais.Items[0].NFSe.IdentificacaoRps.Tipo);
 Self.ConsNfseRps.Cnpj               := TACBrNFSe( FACBrNFSe ).NotasFiscais.Items[0].NFSe.PrestadorServico.IdentificacaoPrestador.Cnpj;
 Self.ConsNfseRps.InscricaoMunicipal := TACBrNFSe( FACBrNFSe ).NotasFiscais.Items[0].NFSe.PrestadorServico.IdentificacaoPrestador.InscricaoMunicipal;

 if not( Self.ConsNfseRps.Executar)
  then begin
   if Assigned(TACBrNFSe( FACBrNFSe ).OnGerarLog)
    then TACBrNFSe( FACBrNFSe ).OnGerarLog(Self.ConsNfseRps.Msg);
   raise Exception.Create(Self.ConsNfseRps.Msg);
  end;

 Result := true;
end;

function TWebServices.CancelaNFSe(ACodigoCancelamento, ANumeroRPS, ACNPJ,
  AInscricaoMunicipal, ACodigoMunicipio: string): Boolean;
begin
  Self.CancNfse.NumeroRPS := ANumeroRPS;
  Self.CancNfse.CNPJ := ACNPJ;
  Self.CancNfse.IM := AInscricaoMunicipal;
  Self.CancNfse.CodigoMunicipio := ACodigoMunicipio;

  Result := CancelaNFSe(ACodigoCancelamento,False);
end;

function TWebServices.Gera(ARps:Integer): Boolean;
begin
 self.GerarNfse.FNumeroRps := ARps;

 if not (Self.GerarNfse.Executar)
  then begin
   if Assigned(TACBrNFSe( FACBrNFSe ).OnGerarLog)
    then TACBrNFSe( FACBrNFSe ).OnGerarLog(Self.GerarNfse.Msg);
   raise Exception.Create(Self.GerarNfse.Msg);
  end;

 Result := true;
end;

{ TNFSeEnviarLoteRPS }
constructor TNFSeEnviarLoteRPS.Create(AOwner : TComponent;
  ANotasFiscais: TNotasFiscais);
begin
 inherited Create(AOwner);

 FNotasFiscais := ANotasFiscais;
end;

function TNFSeEnviarLoteRPS.Executar: Boolean;
var
// NFSeRetorno : TretEnvLote;
 aMsg        : String;
 Texto       : String;
 Acao        : TStringList;
 Stream      : TMemoryStream;
 StrStream   : TStringStream;
 i           : Integer;

 {$IFDEF ACBrNFSeOpenSSL}
   HTTP    : THTTPSend;
 {$ELSE}
   ReqResp : THTTPReqResp;
 {$ENDIF}
begin
 {Result :=} inherited Executar;

 // Incluido por Rodrigo Cantelli
 if Assigned(NFSeRetorno)
  then NFSeRetorno.Free;

 Texto := FProvedorClass.GeraEnvelopeRecepcionarLoteRPS(URLNS1, FCabMSg, FDadosMsg, FDadosSenha);

 Acao      := TStringList.Create;
 Stream    := TMemoryStream.Create;
 Acao.Text := Texto;

 {$IFDEF ACBrNFSeOpenSSL}
   Acao.SaveToStream(Stream);
   HTTP := THTTPSend.Create;
 {$ELSE}
   ReqResp := THTTPReqResp.Create(nil);
   ConfiguraReqResp( ReqResp );
   ReqResp.URL := FURL;
   ReqResp.UseUTF8InHeader := True;

   ReqResp.SoapAction := FProvedorClass.GetSoapAction(acRecepcionar, FNomeCidade);
 {$ENDIF}

 try
  TACBrNFSe( FACBrNFSe ).SetStatus( stNFSeRecepcao );

  if FConfiguracoes.WebServices.Salvar
   then FConfiguracoes.Geral.Save(IntToStr(NumeroLote)+'-env-lot-c.xml', Texto, FConfiguracoes.Arquivos.GetPathGer);

  if FConfiguracoes.Geral.Salvar
   then FConfiguracoes.Geral.Save(IntToStr(NumeroLote)+'-env-lot.xml', FDadosMsg, FConfiguracoes.Arquivos.GetPathGer);

  {$IFDEF ACBrNFSeOpenSSL}
    HTTP.Document.LoadFromStream(Stream);
    ConfiguraHTTP(HTTP, 'SOAPAction: "'+ FProvedorClass.GetSoapAction(acRecepcionar, FNomeCidade) +'"');
    HTTP.HTTPMethod('POST', FURL);

    StrStream := TStringStream.Create('');
    StrStream.CopyFrom(HTTP.Document, 0);

    FRetornoWS := TiraAcentos(ParseText(StrStream.DataString, True));
    FRetWS     := FProvedorClass.GetRetornoWS(acConsSit, FRetornoWS);

    StrStream.Free;
  {$ELSE}
    ReqResp.Execute(Acao.Text, Stream);
    StrStream := TStringStream.Create('');
    StrStream.CopyFrom(Stream, 0);

    FRetornoWS := TiraAcentos(ParseText(StrStream.DataString, True));
    FRetWS     := FProvedorClass.GetRetornoWS(acRecepcionar, FRetornoWS);

    StrStream.Free;
  {$ENDIF}

  if FConfiguracoes.WebServices.Salvar
   then FConfiguracoes.Geral.Save(IntToStr(NumeroLote)+'-rec-c.xml', FRetornoWS, FConfiguracoes.Arquivos.GetPathGer);

  if FConfiguracoes.Geral.Salvar
   then FConfiguracoes.Geral.Save(IntToStr(NumeroLote)+'-rec.xml', FRetWS, FConfiguracoes.Arquivos.GetPathGer);

  NFSeRetorno          := TretEnvLote.Create;
  NFSeRetorno.Prefixo2 := FConfiguracoes.WebServices.Prefixo2;
  NFSeRetorno.Prefixo3 := FConfiguracoes.WebServices.Prefixo3;

  // Alterado por Rodrigo Cantelli
  case FProvedor of
   proBetha: NFSeRetorno.Prefixo3 := '';
  end;

  NFSeRetorno.Leitor.Arquivo := FRetWS;
  NFSeRetorno.LerXml;

  TACBrNFSe( FACBrNFSe ).SetStatus( stNFSeIdle );

  FDataRecebimento := NFSeRetorno.InfRec.DataRecebimento;
  FProtocolo       := NFSeRetorno.InfRec.Protocolo;

  // Lista de Mensagem de Retorno
  FMsg := '';
  if NFSeRetorno.InfRec.MsgRetorno.Count>0
   then begin
    aMsg:='';
    for i:=0 to NFSeRetorno.InfRec.MsgRetorno.Count - 1 do
     begin
      FMsg := FMsg + NFSeRetorno.infRec.MsgRetorno.Items[i].Mensagem + IfThen(FMsg = '', '', ' / ');

      aMsg := aMsg + 'Código Erro : ' + NFSeRetorno.InfRec.MsgRetorno.Items[i].Codigo + LineBreak +
                     'Mensagem... : ' + NFSeRetorno.infRec.MsgRetorno.Items[i].Mensagem + LineBreak+
                     'Correção... : ' + NFSeRetorno.InfRec.MsgRetorno.Items[i].Correcao + LineBreak+
                     'Provedor... : ' + FxProvedor + LineBreak;
     end;
   end
   else begin
    for i:=0 to FNotasFiscais.Count -1 do
     begin
      FNotasFiscais.Items[i].NFSe.Protocolo     := FProtocolo;
      FNotasFiscais.Items[i].NFSe.dhRecebimento := FDataRecebimento;
     end;
    aMsg := 'Numero do Lote : ' + NFSeRetorno.InfRec.NumeroLote + LineBreak +
            'Recebimento... : ' + NotaUtil.SeSenao(FDataRecebimento = 0, '', DateTimeToStr(FDataRecebimento)) + LineBreak +
            'Protocolo..... : ' + FProtocolo + LineBreak +
            'Provedor...... : ' + FxProvedor + LineBreak;
   end;

  if FConfiguracoes.WebServices.Visualizar
   then ShowMessage(aMsg);

  if Assigned(TACBrNFSe( FACBrNFSe ).OnGerarLog)
   then TACBrNFSe( FACBrNFSe ).OnGerarLog(aMsg);

  Result := (NFSeRetorno.InfRec.Protocolo<>'');

//  NFSeRetorno.Free;

 finally
  {$IFDEF ACBrNFSeOpenSSL}
    HTTP.Free;
  {$ELSE}
    ReqResp.Free;
  {$ENDIF}
  Acao.Free;
  Stream.Free;

  NotaUtil.ConfAmbiente;
  TACBrNFSe( FACBrNFSe ).SetStatus( stNFSeIdle );
 end;
end;

{ TNFSeConsultarSituacaoLoteRPS }

constructor TNFSeConsultarSituacaoLoteRPS.Create(AOwner: TComponent; ANotasFiscais : TNotasFiscais);
begin
 inherited Create(AOwner);
  FNotasFiscais := ANotasFiscais;
end;

function TNFSeConsultarSituacaoLoteRPS.Executar: Boolean;

function Processando: Boolean;
var
// NFSeRetorno : TretSitLote;
 aMsg        : String;
 Texto       : String;
 Acao        : TStringList;
 Stream      : TMemoryStream;
 StrStream   : TStringStream;
 Ok          : Boolean;
 i           : Integer;
 xSituacao   : String;

 {$IFDEF ACBrNFSeOpenSSL}
   HTTP    : THTTPSend;
 {$ELSE}
   ReqResp : THTTPReqResp;
 {$ENDIF}
begin
 {Result :=} inherited Executar;

 // Incluido por Rodrigo Cantelli
 if Assigned(NFSeRetorno)
  then NFSeRetorno.Free;

 Texto := FProvedorClass.GeraEnvelopeConsultarSituacaoLoteRPS(URLNS1, FCabMSg, FDadosMsg, FDadosSenha);

 Acao      := TStringList.Create;
 Stream    := TMemoryStream.Create;
 Acao.Text := Texto;

 {$IFDEF ACBrNFSeOpenSSL}
   Acao.SaveToStream(Stream);
   HTTP := THTTPSend.Create;
 {$ELSE}
   ReqResp := THTTPReqResp.Create(nil);
   ConfiguraReqResp( ReqResp );
   ReqResp.URL := FURL;
   ReqResp.UseUTF8InHeader := True;

   ReqResp.SoapAction := FProvedorClass.GetSoapAction(acConsSit, FNomeCidade);
 {$ENDIF}

 try
  TACBrNFSe( FACBrNFSe ).SetStatus( stNFSeConsulta );

  if FConfiguracoes.WebServices.Salvar
   then FConfiguracoes.Geral.Save(Protocolo + '-con-sit-c.xml', Texto, FConfiguracoes.Arquivos.GetPathGer);

  if FConfiguracoes.Geral.Salvar
   then FConfiguracoes.Geral.Save(Protocolo + '-con-sit.xml', FDadosMsg, FConfiguracoes.Arquivos.GetPathGer);

  {$IFDEF ACBrNFSeOpenSSL}
    HTTP.Document.LoadFromStream(Stream);
    ConfiguraHTTP(HTTP, 'SOAPAction: "'+ FProvedorClass.GetSoapAction(acConsSit, FNomeCidade) +'"');
    HTTP.HTTPMethod('POST', FURL);

    StrStream := TStringStream.Create('');
    StrStream.CopyFrom(HTTP.Document, 0);

    FRetornoWS := TiraAcentos(ParseText(StrStream.DataString, True));
    FRetWS     := FProvedorClass.GetRetornoWS(acConsSit, FRetornoWS);

    StrStream.Free;
  {$ELSE}
    ReqResp.Execute(Acao.Text, Stream);
    StrStream := TStringStream.Create('');
    StrStream.CopyFrom(Stream, 0);

    FRetornoWS := TiraAcentos(ParseText(StrStream.DataString, True));
    FRetWS     := FProvedorClass.GetRetornoWS(acConsSit, FRetornoWS);
    
    StrStream.Free;
  {$ENDIF}

  if FConfiguracoes.WebServices.Salvar
   then FConfiguracoes.Geral.Save(Protocolo + '-sit-c.xml', FRetornoWS, FConfiguracoes.Arquivos.GetPathGer);

  if FConfiguracoes.Geral.Salvar
   then FConfiguracoes.Geral.Save(Protocolo + '-sit.xml', FRetWS, FConfiguracoes.Arquivos.GetPathGer);

  NFSeRetorno          := TretSitLote.Create;
  NFSeRetorno.Prefixo2 := FConfiguracoes.WebServices.Prefixo2;
  NFSeRetorno.Prefixo3 := FConfiguracoes.WebServices.Prefixo3;

  // Alterado por Rodrigo Cantelli
  case FProvedor of
   proBetha: NFSeRetorno.Prefixo3 := '';
  end;

  NFSeRetorno.Leitor.Arquivo := FRetWS;
  NFSeRetorno.LerXml;

  TACBrNFSe( FACBrNFSe ).SetStatus( stNFSeIdle );

  FSituacao := NFSeRetorno.InfSit.Situacao;
  // FSituacao: 1 = Não Recebido
  //            2 = Não Processado
  //            3 = Processado com Erro
  //            4 = Processado com Sucesso

  // Lista de Mensagem de Retorno
  FMsg := '';
  if NFSeRetorno.InfSit.MsgRetorno.Count>0
   then begin
    aMsg:='';
    for i:=0 to NFSeRetorno.InfSit.MsgRetorno.Count - 1 do
     begin
      FMsg := FMsg + NFSeRetorno.infSit.MsgRetorno.Items[i].Mensagem + IfThen(FMsg = '', '', ' / ');
      
      aMsg := aMsg + 'Código Erro : ' + NFSeRetorno.InfSit.MsgRetorno.Items[i].Codigo + LineBreak +
                     'Mensagem... : ' + NFSeRetorno.infSit.MsgRetorno.Items[i].Mensagem + LineBreak+
                     'Correção... : ' + NFSeRetorno.InfSit.MsgRetorno.Items[i].Correcao + LineBreak+
                     'Provedor... : ' + FxProvedor + LineBreak;
     end;
   end
   else begin
    for i:=0 to FNotasFiscais.Count -1 do
      FNotasFiscais.Items[i].NFSe.Situacao := FSituacao;

    case StrToSituacaoLoteRPS(Ok, FSituacao) of
     slrNaoRecibo        : xSituacao := 'Não Recebido.';
     slrNaoProcessado    : xSituacao := 'Não Processado.';
     slrProcessadoErro   : xSituacao := 'Processado com Erro.';
     slrProcessadoSucesso: xSituacao := 'Processado com Sucesso.';
    end;
    aMsg := 'Numero do Lote : ' + NFSeRetorno.InfSit.NumeroLote + LineBreak +
            'Situação...... : ' + FSituacao + '-' + xSituacao + LineBreak;
   end;

  if FConfiguracoes.WebServices.Visualizar
   then ShowMessage(aMsg);

  if Assigned(TACBrNFSe( FACBrNFSe ).OnGerarLog)
   then TACBrNFSe( FACBrNFSe ).OnGerarLog(aMsg);

  Result := (FSituacao = '2'); // Não Processado

//  NFSeRetorno.Free;

 finally
  {$IFDEF ACBrNFSeOpenSSL}
    HTTP.Free;
  {$ELSE}
    ReqResp.Free;
  {$ENDIF}
  Acao.Free;
  Stream.Free;

  NotaUtil.ConfAmbiente;
  TACBrNFSe( FACBrNFSe ).SetStatus( stNFSeIdle );
 end;
end;

var
  vCont: Integer;
begin
  {Result :=} inherited Executar;
//  Result := False;

  TACBrNFSe( FACBrNFSe ).SetStatus( stNFSeConsulta );
  Sleep(TACBrNFSe( FACBrNFSe ).Configuracoes.WebServices.AguardarConsultaRet);
  vCont := 10000;
  while Processando do  // Enquanto FSituacao = 2 (Não Processado) tenta mais uma vez
  begin
    if TACBrNFSe( FACBrNFSe ).Configuracoes.WebServices.IntervaloTentativas > 0 then
       sleep(TACBrNFSe( FACBrNFSe ).Configuracoes.WebServices.IntervaloTentativas)
    else
       sleep(vCont);

    if vCont > (TACBrNFSe( FACBrNFSe ).Configuracoes.WebServices.Tentativas * 10000) then
      break;

    vCont := vCont + 10000;
  end;
  TACBrNFSe( FACBrNFSe ).SetStatus( stNFSeIdle );

  Result := (FSituacao = '3') or (FSituacao = '4');
  // FSituacao: 1 = Não Recebido
  //            2 = Não Processado
  //            3 = Processado com Erro
  //            4 = Processado com Sucesso
end;

{ TNFSeConsultarLoteRPS }

constructor TNFSeConsultarLoteRPS.Create(AOwner: TComponent;
  ANotasFiscais: TNotasFiscais);
begin
 inherited Create(AOwner);
  FNotasFiscais := ANotasFiscais;
end;

function TNFSeConsultarLoteRPS.Executar: Boolean;
var
// NFSeRetorno : TretLote;
 aMsg        : String;
 Texto       : String;
 Acao        : TStringList;
 Stream      : TMemoryStream;
 StrStream   : TStringStream;

 {$IFDEF ACBrNFSeOpenSSL}
   HTTP    : THTTPSend;
 {$ELSE}
   ReqResp : THTTPReqResp;
 {$ENDIF}

 Prefixo3      : String;
 Prefixo4      : String;
 FRetListaNfse : AnsiString;
 FRetNfse      : AnsiString;
 i, j, k, p,
 ii            : Integer;
 PathSalvar    : String;
begin
 {Result :=} inherited Executar;

 // Incluido por Rodrigo Cantelli
 if Assigned(NFSeRetorno)
  then NFSeRetorno.Free;

 Texto := FProvedorClass.GeraEnvelopeConsultarLoteRPS(URLNS1, FCabMSg, FDadosMsg, FDadosSenha);

 Acao      := TStringList.Create;
 Stream    := TMemoryStream.Create;
 Acao.Text := Texto;

 {$IFDEF ACBrNFSeOpenSSL}
   Acao.SaveToStream(Stream);
   HTTP := THTTPSend.Create;
 {$ELSE}
   ReqResp := THTTPReqResp.Create(nil);
   ConfiguraReqResp( ReqResp );
   ReqResp.URL := FURL;
   ReqResp.UseUTF8InHeader := True;

   ReqResp.SoapAction := FProvedorClass.GetSoapAction(acConsLote, FNomeCidade);
 {$ENDIF}

 try
  TACBrNFSe( FACBrNFSe ).SetStatus( stNFSeConsulta );

  if FConfiguracoes.WebServices.Salvar
   then FConfiguracoes.Geral.Save(Protocolo + '-con-lot-c.xml', Texto, FConfiguracoes.Arquivos.GetPathGer);

  if FConfiguracoes.Geral.Salvar
   then FConfiguracoes.Geral.Save(Protocolo + '-con-lot.xml', FDadosMsg, FConfiguracoes.Arquivos.GetPathGer);

  {$IFDEF ACBrNFSeOpenSSL}
    HTTP.Document.LoadFromStream(Stream);
    ConfiguraHTTP(HTTP, 'SOAPAction: "'+ FProvedorClass.GetSoapAction(acConsLote, FNomeCidade) +'"');
    HTTP.HTTPMethod('POST', FURL);

    StrStream := TStringStream.Create('');
    StrStream.CopyFrom(HTTP.Document, 0);

    FRetornoWS := TiraAcentos(ParseText(StrStream.DataString, True));
    FRetWS     := FProvedorClass.GetRetornoWS(acConsSit, FRetornoWS);

    StrStream.Free;
  {$ELSE}
    ReqResp.Execute(Acao.Text, Stream);
    StrStream := TStringStream.Create('');
    StrStream.CopyFrom(Stream, 0);

    FRetornoWS := TiraAcentos(ParseText(StrStream.DataString, True));
    FRetWS     := FProvedorClass.GetRetornoWS(acConsLote, FRetornoWS);
    
    StrStream.Free;
  {$ENDIF}

  if FConfiguracoes.WebServices.Salvar
   then FConfiguracoes.Geral.Save(Protocolo + '-lista-nfse-c.xml', FRetornoWS, FConfiguracoes.Arquivos.GetPathGer);

  if FConfiguracoes.Geral.Salvar
   then FConfiguracoes.Geral.Save(Protocolo + '-lista-nfse.xml', NotaUtil.RetirarPrefixos(FRetWS), FConfiguracoes.Arquivos.GetPathGer);
  self.ArquivoRetorno := FRetWS;

  NFSeRetorno          := TretLote.Create;
  NFSeRetorno.Prefixo2 := FConfiguracoes.WebServices.Prefixo2;
  NFSeRetorno.Prefixo3 := FConfiguracoes.WebServices.Prefixo3;
  NFSeRetorno.Prefixo4 := FConfiguracoes.WebServices.Prefixo4;

  Prefixo3             := FConfiguracoes.WebServices.Prefixo3;
  Prefixo4             := FConfiguracoes.WebServices.Prefixo4;

  // Alterado por Rodrigo Cantelli
  case FProvedor of
   proBetha: begin
              NFSeRetorno.Prefixo3 := '';
              Prefixo3             := '';
             end;
   proISSNET: NFSeRetorno.Prefixo4 := '';
  end;

  NFSeRetorno.Leitor.Arquivo := FRetWS;
  NFSeRetorno.LerXml;

  FRetListaNfse := SeparaDados(FRetWS, Prefixo3 + 'ListaNfse');
  i := 0;
  while FRetListaNfse <> '' do
   begin
    // Alterado por Rodrigo Cantelli
    j := Pos('</' + Prefixo3 +
                    NotaUtil.seSenao(FProvedor = proBetha, 'ComplNfse', 'CompNfse') + '>', FRetListaNfse);
    p := Length(trim(Prefixo3));
    if j > 0
     then begin

      // Alterado por Italo em 19/07/2012
      for ii := 0 to NFSeRetorno.ListaNfse.CompNfse.Count -1 do
       begin
        if FNotasFiscais.Items[ii].NFSe.IdentificacaoRps.Numero = NFSeRetorno.ListaNfse.CompNfse.Items[i].Nfse.IdentificacaoRps.Numero
         then begin
          FNotasFiscais.Items[ii].NFSe.CodigoVerificacao := NFSeRetorno.ListaNfse.CompNfse.Items[i].Nfse.CodigoVerificacao;
          FNotasFiscais.Items[ii].NFSe.Numero            := NFSeRetorno.ListaNfse.CompNfse.Items[i].Nfse.Numero;
          FNotasFiscais.Items[ii].NFSe.Competencia       := NFSeRetorno.ListaNfse.CompNfse.Items[i].Nfse.Competencia;
          FNotasFiscais.Items[ii].NFSe.NfseSubstituida   := NFSeRetorno.ListaNfse.CompNfse.Items[i].Nfse.NfseSubstituida;

          FNotasFiscais.Items[ii].NFSe.Servico.xItemListaServico := NFSeRetorno.ListaNfse.CompNfse.Items[i].Nfse.Servico.xItemListaServico;

          FNotasFiscais.Items[ii].NFSe.PrestadorServico.RazaoSocial  := NFSeRetorno.ListaNfse.CompNfse.Items[i].Nfse.PrestadorServico.RazaoSocial;
          FNotasFiscais.Items[ii].NFSe.PrestadorServico.NomeFantasia := NFSeRetorno.ListaNfse.CompNfse.Items[i].Nfse.PrestadorServico.NomeFantasia;

          FNotasFiscais.Items[ii].NFSe.PrestadorServico.IdentificacaoPrestador.Cnpj               := NFSeRetorno.ListaNfse.CompNfse.Items[i].Nfse.PrestadorServico.IdentificacaoPrestador.Cnpj;
          FNotasFiscais.Items[ii].NFSe.PrestadorServico.IdentificacaoPrestador.InscricaoMunicipal := NFSeRetorno.ListaNfse.CompNfse.Items[i].Nfse.PrestadorServico.IdentificacaoPrestador.InscricaoMunicipal;

          FNotasFiscais.Items[ii].NFSe.PrestadorServico.Endereco.Endereco        := NFSeRetorno.ListaNfse.CompNfse.Items[i].Nfse.PrestadorServico.Endereco.Endereco;
          FNotasFiscais.Items[ii].NFSe.PrestadorServico.Endereco.Numero          := NFSeRetorno.ListaNfse.CompNfse.Items[i].Nfse.PrestadorServico.Endereco.Numero;
          FNotasFiscais.Items[ii].NFSe.PrestadorServico.Endereco.Complemento     := NFSeRetorno.ListaNfse.CompNfse.Items[i].Nfse.PrestadorServico.Endereco.Complemento;
          FNotasFiscais.Items[ii].NFSe.PrestadorServico.Endereco.Bairro          := NFSeRetorno.ListaNfse.CompNfse.Items[i].Nfse.PrestadorServico.Endereco.Bairro;
          FNotasFiscais.Items[ii].NFSe.PrestadorServico.Endereco.CodigoMunicipio := NFSeRetorno.ListaNfse.CompNfse.Items[i].Nfse.PrestadorServico.Endereco.CodigoMunicipio;
          FNotasFiscais.Items[ii].NFSe.PrestadorServico.Endereco.UF              := NFSeRetorno.ListaNfse.CompNfse.Items[i].Nfse.PrestadorServico.Endereco.UF;
          FNotasFiscais.Items[ii].NFSe.PrestadorServico.Endereco.CEP             := NFSeRetorno.ListaNfse.CompNfse.Items[i].Nfse.PrestadorServico.Endereco.CEP;
          FNotasFiscais.Items[ii].NFSe.PrestadorServico.Endereco.xMunicipio      := NFSeRetorno.ListaNfse.CompNfse.Items[i].Nfse.PrestadorServico.Endereco.xMunicipio;

          FNotasFiscais.Items[ii].NFSe.PrestadorServico.Contato.Telefone := NFSeRetorno.ListaNfse.CompNfse.Items[i].Nfse.PrestadorServico.Contato.Telefone;
          FNotasFiscais.Items[ii].NFSe.PrestadorServico.Contato.Email    := NFSeRetorno.ListaNfse.CompNfse.Items[i].Nfse.PrestadorServico.Contato.Email;

          FNotasFiscais.Items[ii].NFSe.Tomador.Endereco.xMunicipio := NFSeRetorno.ListaNfse.CompNfse.Items[i].Nfse.Tomador.Endereco.xMunicipio;

          FRetNfse := Copy(FRetListaNfse, 1, j - 1);
          k :=  Pos('<' + Prefixo4 + 'Nfse', FRetNfse);
          FRetNfse := Copy(FRetNfse, k, length(FRetNfse));

          FRetNFSe := FProvedorClass.GeraRetornoNFSe(Prefixo3, FRetNFSe, FNomeCidade);

          if FConfiguracoes.Geral.Salvar
           then begin
            PathSalvar := FConfiguracoes.Arquivos.GetPathNFSe(0);
            FConfiguracoes.Geral.Save(NFSeRetorno.ListaNfse.CompNfse.Items[i].Nfse.Numero + '-nfse.xml',
                                      NotaUtil.RetirarPrefixos(FRetNfse), PathSalvar);
            if FNotasFiscais.Count>0
             then FNotasFiscais.Items[ii].NomeArq := PathWithDelim(PathSalvar) + NFSeRetorno.ListaNfse.CompNfse.Items[i].Nfse.Numero + '-nfse.xml';
           end;

          FRetListaNfse := Copy(FRetListaNfse, j + 11 + p, length(FRetListaNfse));

          FNotasFiscais.Items[ii].XML_NFSe := FRetNfse;

          break;
         end;
       end;

      inc(i);
     end
     else FRetListaNfse:='';
   end;

  TACBrNFSe( FACBrNFSe ).SetStatus( stNFSeIdle );

  // Lista de Mensagem de Retorno
  FMsg := '';
  if NFSeRetorno.ListaNfse.MsgRetorno.Count>0
   then begin
    aMsg:='';
    for i:=0 to NFSeRetorno.ListaNfse.MsgRetorno.Count - 1 do
     begin
      FMsg := FMsg + NFSeRetorno.ListaNfse.MsgRetorno.Items[i].Mensagem + IfThen(FMsg = '', '', ' / ');
      
      aMsg := aMsg + 'Código Erro : ' + NFSeRetorno.ListaNfse.MsgRetorno.Items[i].Codigo + LineBreak +
                     'Mensagem... : ' + NFSeRetorno.ListaNfse.MsgRetorno.Items[i].Mensagem + LineBreak+
                     'Correção... : ' + NFSeRetorno.ListaNfse.MsgRetorno.Items[i].Correcao + LineBreak+
                     'Provedor... : ' + FxProvedor + LineBreak;
     end;

    if FConfiguracoes.WebServices.Visualizar
     then ShowMessage(aMsg);
   end;

  if Assigned(TACBrNFSe( FACBrNFSe ).OnGerarLog)
   then TACBrNFSe( FACBrNFSe ).OnGerarLog(aMsg);

  Result := (FMsg = '');

//  NFSeRetorno.Free;

 finally
  {$IFDEF ACBrNFSeOpenSSL}
    HTTP.Free;
  {$ELSE}
    ReqResp.Free;
  {$ENDIF}
  Acao.Free;
  Stream.Free;

  NotaUtil.ConfAmbiente;
  TACBrNFSe( FACBrNFSe ).SetStatus( stNFSeIdle );
 end;
end;

{ TNFSeConsultarNfseRPS }

constructor TNFSeConsultarNfseRPS.Create(AOwner: TComponent;
  ANotasFiscais: TNotasFiscais);
begin
 inherited Create(AOwner);
  FNotasFiscais := ANotasFiscais;
end;

function TNFSeConsultarNfseRPS.Executar: Boolean;
var
 aMsg        : String;
 Texto       : String;
 Acao        : TStringList;
 Stream      : TMemoryStream;
 StrStream   : TStringStream;

 {$IFDEF ACBrNFSeOpenSSL}
   HTTP    : THTTPSend;
 {$ELSE}
   ReqResp : THTTPReqResp;
 {$ENDIF}

 Prefixo3     : String;
 Prefixo4     : String;
 FRetCompNfse : AnsiString;
 FRetNfse     : AnsiString;
 i, j         : Integer;
 PathSalvar   : String;
begin
 {Result :=} inherited Executar;

 // Incluido por Italo em 17/02/2012
 if Assigned(NFSeRetorno)
  then NFSeRetorno.Free;

 Texto := FProvedorClass.GeraEnvelopeConsultarNFSeporRPS(URLNS1, FCabMSg, FDadosMsg, FDadosSenha);

 Acao      := TStringList.Create;
 Stream    := TMemoryStream.Create;
 Acao.Text := Texto;

 {$IFDEF ACBrNFSeOpenSSL}
   Acao.SaveToStream(Stream);
   HTTP := THTTPSend.Create;
 {$ELSE}
   ReqResp := THTTPReqResp.Create(nil);
   ConfiguraReqResp( ReqResp );
   ReqResp.URL := FURL;
   ReqResp.UseUTF8InHeader := True;

   ReqResp.SoapAction := FProvedorClass.GetSoapAction(acConsNFSeRps, FNomeCidade);
 {$ENDIF}

 try
  TACBrNFSe( FACBrNFSe ).SetStatus( stNFSeConsulta );

  if FConfiguracoes.WebServices.Salvar
   then FConfiguracoes.Geral.Save(Numero + Serie + '-con-nfse-rps-c.xml', Texto, FConfiguracoes.Arquivos.GetPathGer);

  if FConfiguracoes.Geral.Salvar
   then FConfiguracoes.Geral.Save(Numero + Serie + '-con-nfse-rps.xml', FDadosMsg, FConfiguracoes.Arquivos.GetPathGer);

  {$IFDEF ACBrNFSeOpenSSL}
    HTTP.Document.LoadFromStream(Stream);
    ConfiguraHTTP(HTTP, 'SOAPAction: "'+ FProvedorClass.GetSoapAction(acConsNFSeRps, FNomeCidade) +'"');
    HTTP.HTTPMethod('POST', FURL);

    StrStream := TStringStream.Create('');
    StrStream.CopyFrom(HTTP.Document, 0);

    FRetornoWS := TiraAcentos(ParseText(StrStream.DataString, True));
    FRetWS     := FProvedorClass.GetRetornoWS(acConsSit, FRetornoWS);

    StrStream.Free;
  {$ELSE}
    ReqResp.Execute(Acao.Text, Stream);
    StrStream := TStringStream.Create('');
    StrStream.CopyFrom(Stream, 0);

    FRetornoWS := TiraAcentos(ParseText(StrStream.DataString, True));
    FRetWS     := FProvedorClass.GetRetornoWS(acConsNFSeRps, FRetornoWS);
    
    StrStream.Free;
  {$ENDIF}

  if FConfiguracoes.WebServices.Salvar
   then FConfiguracoes.Geral.Save(Numero + Serie + '-comp-nfse-c.xml', FRetornoWS, FConfiguracoes.Arquivos.GetPathGer);

  if FConfiguracoes.Geral.Salvar
   then FConfiguracoes.Geral.Save(Numero + Serie + '-comp-nfse.xml', FRetWS, FConfiguracoes.Arquivos.GetPathGer);

  NFSeRetorno          := TretNfseRps.Create;
  NFSeRetorno.Prefixo2 := FConfiguracoes.WebServices.Prefixo2;
  NFSeRetorno.Prefixo3 := FConfiguracoes.WebServices.Prefixo3;
  NFSeRetorno.Prefixo4 := FConfiguracoes.WebServices.Prefixo4;

  Prefixo3             := FConfiguracoes.WebServices.Prefixo3;
  Prefixo4             := FConfiguracoes.WebServices.Prefixo4;

  // Alterado por Rodrigo Cantelli
  case FProvedor of
   proBetha: begin
              NFSeRetorno.Prefixo3 := '';
              Prefixo3             := '';
             end;
   proISSNET: NFSeRetorno.Prefixo4 := '';
  end;

  NFSeRetorno.Leitor.Arquivo := FRetWS;
  NFSeRetorno.LerXml;

  // Alterado por Rodrigo Cantelli
  if FProvedor = proBetha
   then FRetCompNfse := SeparaDados(FRetWS, Prefixo3 + 'ComplNfse')
   else FRetCompNfse := SeparaDados(FRetWS, Prefixo3 + 'CompNfse');

  i := 0;
  while FRetCompNfse <> '' do
   begin
    j := Pos('</' + Prefixo3 + 'Nfse>', FRetCompNfse);
    if j > 0
     then begin
      FRetNfse := FRetCompNfse;

      FRetNFSe := FProvedorClass.GeraRetornoNFSe(Prefixo3, FRetNFSe, FNomeCidade);

      if FConfiguracoes.Geral.Salvar
       then begin
        PathSalvar := FConfiguracoes.Arquivos.GetPathNFSe(0);
        FConfiguracoes.Geral.Save(NFSeRetorno.ListaNfse.CompNfse.Items[i].Nfse.Numero + '-nfse.xml',
                                  NotaUtil.RetirarPrefixos(FRetNfse), PathSalvar);
        if FNotasFiscais.Count>0
         then FNotasFiscais.Items[i].NomeArq := PathWithDelim(PathSalvar) + NFSeRetorno.ListaNfse.CompNfse.Items[i].Nfse.Numero + '-nfse.xml';
       end;

      FNotasFiscais.Items[i].NFSe.Protocolo         := NFSeRetorno.ListaNfse.CompNfse.Items[i].Nfse.Protocolo;
      FNotasFiscais.Items[i].NFSe.CodigoVerificacao := NFSeRetorno.ListaNfse.CompNfse.Items[i].Nfse.CodigoVerificacao;
      FNotasFiscais.Items[i].NFSe.Numero            := NFSeRetorno.ListaNfse.CompNfse.Items[i].Nfse.Numero;
      FNotasFiscais.Items[i].XML_NFSe               := FRetNfse;

      FRetCompNfse:='';
      inc(i);
     end
     else FRetCompNfse:='';
   end;

  TACBrNFSe( FACBrNFSe ).SetStatus( stNFSeIdle );

  // Lista de Mensagem de Retorno
  FMsg := '';
  if NFSeRetorno.ListaNfse.MsgRetorno.Count>0
   then begin
    aMsg:='';
    for i:=0 to NFSeRetorno.ListaNfse.MsgRetorno.Count - 1 do
     begin
      FMsg := FMsg + NFSeRetorno.ListaNfse.MsgRetorno.Items[i].Mensagem + IfThen(FMsg = '', '', ' / ');
      
      aMsg := aMsg + 'Código Erro : ' + NFSeRetorno.ListaNfse.MsgRetorno.Items[i].Codigo + LineBreak +
                     'Mensagem... : ' + NFSeRetorno.ListaNfse.MsgRetorno.Items[i].Mensagem + LineBreak+
                     'Correção... : ' + NFSeRetorno.ListaNfse.MsgRetorno.Items[i].Correcao + LineBreak+
                     'Provedor... : ' + FxProvedor + LineBreak;
     end;

    if FConfiguracoes.WebServices.Visualizar
     then ShowMessage(aMsg);
   end;

  if Assigned(TACBrNFSe( FACBrNFSe ).OnGerarLog)
   then TACBrNFSe( FACBrNFSe ).OnGerarLog(aMsg);

  Result := (FMsg = '');

 finally
  {$IFDEF ACBrNFSeOpenSSL}
    HTTP.Free;
  {$ELSE}
    ReqResp.Free;
  {$ENDIF}
  Acao.Free;
  Stream.Free;

  NotaUtil.ConfAmbiente;
  TACBrNFSe( FACBrNFSe ).SetStatus( stNFSeIdle );
 end;
end;

{ TNFSeConsultarNfse }

constructor TNFSeConsultarNfse.Create(AOwner: TComponent;
  ANotasFiscais: TNotasFiscais);
begin
 inherited Create(AOwner);
  FNotasFiscais := ANotasFiscais;
end;

function TNFSeConsultarNfse.Executar: Boolean;
var
// NFSeRetorno : TretNfse;
 aMsg        : String;
 Texto       : String;
 Acao        : TStringList;
 Stream      : TMemoryStream;
 StrStream   : TStringStream;

 {$IFDEF ACBrNFSeOpenSSL}
   HTTP    : THTTPSend;
 {$ELSE}
   ReqResp : THTTPReqResp;
 {$ENDIF}

 Prefixo3      : String;
 Prefixo4      : String;
 FRetListaNfse : AnsiString;
 FRetNfse      : AnsiString;
 i, j, k, p    : Integer;
 PathSalvar    : String;
begin
 {Result :=} inherited Executar;

 // Incluido por Rodrigo Cantelli
 if Assigned(NFSeRetorno)
  then NFSeRetorno.Free;

 Texto := FProvedorClass.GeraEnvelopeConsultarNFSe(URLNS1, FCabMSg, FDadosMsg, FDadosSenha);

 Acao      := TStringList.Create;
 Stream    := TMemoryStream.Create;
 Acao.Text := Texto;

 {$IFDEF ACBrNFSeOpenSSL}
   Acao.SaveToStream(Stream);
   HTTP := THTTPSend.Create;
 {$ELSE}
   ReqResp := THTTPReqResp.Create(nil);
   ConfiguraReqResp( ReqResp );
   ReqResp.URL := FURL;
   ReqResp.UseUTF8InHeader := True;

   ReqResp.SoapAction := FProvedorClass.GetSoapAction(acConsNFSe, FNomeCidade);
 {$ENDIF}

 try
  TACBrNFSe( FACBrNFSe ).SetStatus( stNFSeConsulta );

  if FConfiguracoes.WebServices.Salvar
   then FConfiguracoes.Geral.Save(FormatDateTime('yyyymmdd', DataInicial) +
                                  FormatDateTime('yyyymmdd', DataFinal) + '-con-nfse-c.xml', Texto, FConfiguracoes.Arquivos.GetPathGer);

  if FConfiguracoes.Geral.Salvar
   then FConfiguracoes.Geral.Save(FormatDateTime('yyyymmdd', DataInicial) +
                                  FormatDateTime('yyyymmdd', DataFinal) + '-con-nfse.xml', FDadosMsg, FConfiguracoes.Arquivos.GetPathGer);

  {$IFDEF ACBrNFSeOpenSSL}
    HTTP.Document.LoadFromStream(Stream);
    ConfiguraHTTP(HTTP, 'SOAPAction: "'+ FProvedorClass.GetSoapAction(acConsNFSe, FNomeCidade) +'"');
    HTTP.HTTPMethod('POST', FURL);

    StrStream := TStringStream.Create('');
    StrStream.CopyFrom(HTTP.Document, 0);

    FRetornoWS := TiraAcentos(ParseText(StrStream.DataString, True));
    FRetWS     := FProvedorClass.GetRetornoWS(acConsSit, FRetornoWS);

    StrStream.Free;
  {$ELSE}
    ReqResp.Execute(Acao.Text, Stream);
    StrStream := TStringStream.Create('');
    StrStream.CopyFrom(Stream, 0);

    FRetornoWS := TiraAcentos(ParseText(StrStream.DataString, True));
    FRetWS     := FProvedorClass.GetRetornoWS(acConsNFSe, FRetornoWS);
    
    StrStream.Free;
  {$ENDIF}

  if FConfiguracoes.WebServices.Salvar
   then FConfiguracoes.Geral.Save(FormatDateTime('yyyymmdd', DataInicial) +
                                  FormatDateTime('yyyymmdd', DataFinal) + '-lista-nfse-c.xml', FRetornoWS, FConfiguracoes.Arquivos.GetPathGer);

  if FConfiguracoes.Geral.Salvar
   then FConfiguracoes.Geral.Save(FormatDateTime('yyyymmdd', DataInicial) +
                                  FormatDateTime('yyyymmdd', DataFinal) + '-lista-nfse.xml', NotaUtil.RetirarPrefixos(FRetWS), FConfiguracoes.Arquivos.GetPathGer);

  NFSeRetorno          := TretNfse.Create;
  NFSeRetorno.Prefixo2 := FConfiguracoes.WebServices.Prefixo2;
  NFSeRetorno.Prefixo3 := FConfiguracoes.WebServices.Prefixo3;
  NFSeRetorno.Prefixo4 := FConfiguracoes.WebServices.Prefixo4;

  Prefixo3             := FConfiguracoes.WebServices.Prefixo3;
  Prefixo4             := FConfiguracoes.WebServices.Prefixo4;

  // Alterado por Rodrigo Cantelli
  case FProvedor of
   proBetha: begin
              NFSeRetorno.Prefixo3 := '';
              Prefixo3             := '';
             end;
   proISSNET: NFSeRetorno.Prefixo4 := '';
  end;

  NFSeRetorno.Leitor.Arquivo := FRetWS;
  NFSeRetorno.LerXml;

  FRetListaNfse := SeparaDados(FRetWS, Prefixo3 + 'ListaNfse');
  i := 0;
  while FRetListaNfse <> '' do
   begin
    // Alterado por Rodrigo Cantelli
    if FProvedor = proBetha
     then j := Pos('</' + Prefixo3 + 'ComplNfse>', FRetListaNfse)
     else j := Pos('</' + Prefixo3 + 'CompNfse>', FRetListaNfse);

    p := Length(trim(Prefixo3));
    if j > 0
     then begin
      FRetNfse := Copy(FRetListaNfse, 1, j - 1);
      k :=  Pos('<' + Prefixo4 + 'Nfse', FRetNfse);
      FRetNfse := Copy(FRetNfse, k, length(FRetNfse));

      FRetNFSe := FProvedorClass.GeraRetornoNFSe(Prefixo3, FRetNFSe, FNomeCidade);

      if FConfiguracoes.Geral.Salvar
       then begin
        PathSalvar := FConfiguracoes.Arquivos.GetPathNFSe(NFSeRetorno.ListaNfse.CompNfse.Items[i].Nfse.DataEmissao);
        FConfiguracoes.Geral.Save(NFSeRetorno.ListaNfse.CompNfse.Items[i].Nfse.Numero + '-nfse.xml',
                                  NotaUtil.RetirarPrefixos(FRetNfse), PathSalvar);
       end;
      FRetListaNfse := Copy(FRetListaNfse, j + 11 + p, length(FRetListaNfse));
      inc(i);
     end
     else FRetListaNfse:='';
   end;

  TACBrNFSe( FACBrNFSe ).SetStatus( stNFSeIdle );

  // Lista de Mensagem de Retorno
  FMsg := '';
  if NFSeRetorno.ListaNfse.MsgRetorno.Count>0
   then begin
    aMsg:='';
    for i:=0 to NFSeRetorno.ListaNfse.MsgRetorno.Count - 1 do
     begin
      FMsg := FMsg + NFSeRetorno.ListaNfse.MsgRetorno.Items[i].Mensagem + IfThen(FMsg = '', '', ' / ');
      
      aMsg := aMsg + 'Código Erro : ' + NFSeRetorno.ListaNfse.MsgRetorno.Items[i].Codigo + LineBreak +
                     'Mensagem... : ' + NFSeRetorno.ListaNfse.MsgRetorno.Items[i].Mensagem + LineBreak+
                     'Correção... : ' + NFSeRetorno.ListaNfse.MsgRetorno.Items[i].Correcao + LineBreak+
                     'Provedor... : ' + FxProvedor + LineBreak;
     end;

    if FConfiguracoes.WebServices.Visualizar
     then ShowMessage(aMsg);
   end;

  if Assigned(TACBrNFSe( FACBrNFSe ).OnGerarLog)
   then TACBrNFSe( FACBrNFSe ).OnGerarLog(aMsg);

  Result := (FMsg = '');

  (*
  // Incluido por Mauro Gomes
  // apaga o retorno anterior no atributo do WebService, se houver instância
  if Self.NFSeRetorno <> Nil then
     Self.NFSeRetorno.Free;

  // Incluido por Mauro Gomes
  // guarda o retorno atual para processamento posterior da lista de Notas Fiscais
  Self.NFSeRetorno := NFSeRetorno;

  // Comentado por Mauro Gomes
//  NFSeRetorno.Free;
  *)

 finally
  {$IFDEF ACBrNFSeOpenSSL}
    HTTP.Free;
  {$ELSE}
    ReqResp.Free;
  {$ENDIF}
  Acao.Free;
  Stream.Free;

  NotaUtil.ConfAmbiente;
  TACBrNFSe( FACBrNFSe ).SetStatus( stNFSeIdle );
 end;
end;

{ TNFSeCancelarNfse }

constructor TNFSeCancelarNfse.Create(AOwner: TComponent;
  ANotasFiscais: TNotasFiscais);
begin
 inherited Create(AOwner);
  FNotasFiscais := ANotasFiscais;
end;

function TNFSeCancelarNfse.Executar: Boolean;
var
// NFSeRetorno : TretCancNfse;
 aMsg        : String;
 Texto       : String;
 Acao        : TStringList;
 Stream      : TMemoryStream;
 StrStream   : TStringStream;
 i           : Integer;

 {$IFDEF ACBrNFSeOpenSSL}
   HTTP    : THTTPSend;
 {$ELSE}
   ReqResp : THTTPReqResp;
 {$ENDIF}
begin
 {Result :=} inherited Executar;

 // Incluido por Italo em 01/03/2012
 if Assigned(NFSeRetorno)
  then NFSeRetorno.Free;

 Texto := FProvedorClass.GeraEnvelopeCancelarNFSe(URLNS1, FCabMSg, FDadosMsg, FDadosSenha);

 Acao      := TStringList.Create;
 Stream    := TMemoryStream.Create;
 Acao.Text := Texto;

 {$IFDEF ACBrNFSeOpenSSL}
   Acao.SaveToStream(Stream);
   HTTP := THTTPSend.Create;
 {$ELSE}
   ReqResp := THTTPReqResp.Create(nil);
   ConfiguraReqResp( ReqResp );

  if FProvedor = proRJ
   then ReqResp.URL := 'https://notacarioca.rio.gov.br/WSNacional/nfse.asmx?op=CancelarNfse'
   else ReqResp.URL := FURL;

   ReqResp.UseUTF8InHeader := True;

   ReqResp.SoapAction := FProvedorClass.GetSoapAction(acCancelar, FNomeCidade);
 {$ENDIF}

 try
  TACBrNFSe( FACBrNFSe ).SetStatus( stNFSeCancelamento );

  if FConfiguracoes.WebServices.Salvar
   then FConfiguracoes.Geral.Save(TNFSeCancelarNFse(Self).FNotasFiscais.Items[0].NFSe.Numero + '-ped-can-c.xml', Texto, FConfiguracoes.Arquivos.GetPathCan );

  if FConfiguracoes.Geral.Salvar
   then FConfiguracoes.Geral.Save(TNFSeCancelarNFse(Self).FNotasFiscais.Items[0].NFSe.Numero + '-ped-can.xml', FDadosMsg, FConfiguracoes.Arquivos.GetPathCan );

  {$IFDEF ACBrNFSeOpenSSL}
    HTTP.Document.LoadFromStream(Stream);
    ConfiguraHTTP(HTTP, 'SOAPAction: "'+ FProvedorClass.GetSoapAction(acCancelar, FNomeCidade) +'"');
    HTTP.HTTPMethod('POST', FURL);

    StrStream := TStringStream.Create('');
    StrStream.CopyFrom(HTTP.Document, 0);

    FRetornoWS := TiraAcentos(ParseText(StrStream.DataString, True));
    FRetWS     := FProvedorClass.GetRetornoWS(acConsSit, FRetornoWS);

    StrStream.Free;
  {$ELSE}
    ReqResp.Execute(Acao.Text, Stream);
    StrStream := TStringStream.Create('');
    StrStream.CopyFrom(Stream, 0);

    FRetornoWS := TiraAcentos(ParseText(StrStream.DataString, True));
    FRetWS     := FProvedorClass.GetRetornoWS(acCancelar, FRetornoWS);

    StrStream.Free;
  {$ENDIF}

  if FConfiguracoes.WebServices.Salvar
   then FConfiguracoes.Geral.Save(TNFSeCancelarNFse(Self).FNotasFiscais.Items[0].NFSe.Numero + '-can-c.xml', FRetornoWS, FConfiguracoes.Arquivos.GetPathCan);

  if FConfiguracoes.Geral.Salvar
   then FConfiguracoes.Geral.Save(TNFSeCancelarNFse(Self).FNotasFiscais.Items[0].NFSe.Numero + '-can.xml', FRetWS, FConfiguracoes.Arquivos.GetPathCan);
  self.ArquivoRetorno := FRetWS;

  NFSeRetorno          := TretCancNfse.Create;
  NFSeRetorno.Prefixo2 := FConfiguracoes.WebServices.Prefixo2;
  NFSeRetorno.Prefixo3 := FConfiguracoes.WebServices.Prefixo3;
  NFSeRetorno.Prefixo4 := FConfiguracoes.WebServices.Prefixo4;

  // Alterado por Rodrigo Cantelli
  case FProvedor of
   proBetha:  NFSeRetorno.Prefixo3 := '';
   proISSNET: NFSeRetorno.Prefixo4 := '';
  end;

  NFSeRetorno.Leitor.Arquivo := FRetWS;
  NFSeRetorno.LerXml;

  TACBrNFSe( FACBrNFSe ).SetStatus( stNFSeIdle );

  FDataHora := NFSeRetorno.InfCanc.DataHora;

  // Lista de Mensagem de Retorno
  FMsg := '';
  if NFSeRetorno.InfCanc.MsgRetorno.Count>0
   then begin
    aMsg:='';
    for i:=0 to NFSeRetorno.InfCanc.MsgRetorno.Count - 1 do
     begin
      FMsg := FMsg + NFSeRetorno.infCanc.MsgRetorno.Items[i].Mensagem + IfThen(FMsg = '', '', ' / ');
      
      aMsg := aMsg + 'Código Erro : ' + NFSeRetorno.InfCanc.MsgRetorno.Items[i].Codigo + LineBreak +
                     'Mensagem... : ' + NFSeRetorno.infCanc.MsgRetorno.Items[i].Mensagem + LineBreak+
                     'Correção... : ' + NFSeRetorno.InfCanc.MsgRetorno.Items[i].Correcao + LineBreak+
                     'Provedor... : ' + FxProvedor + LineBreak;
     end;
   end
   else aMsg := 'Numero da NFSe : ' + NFSeRetorno.InfCanc.Pedido.IdentificacaoNfse.Numero + LineBreak +
                'Data Hora..... : ' + NotaUtil.SeSenao(FDataHora = 0, '', DateTimeToStr(FDataHora)) + LineBreak;

  if FConfiguracoes.WebServices.Visualizar
   then ShowMessage(aMsg);

  if Assigned(TACBrNFSe( FACBrNFSe ).OnGerarLog)
   then TACBrNFSe( FACBrNFSe ).OnGerarLog(aMsg);

  Result := (FMsg='');

//  NFSeRetorno.Free;

 finally
  {$IFDEF ACBrNFSeOpenSSL}
    HTTP.Free;
  {$ELSE}
    ReqResp.Free;
  {$ENDIF}
  Acao.Free;
  Stream.Free;

  NotaUtil.ConfAmbiente;
  TACBrNFSe( FACBrNFSe ).SetStatus( stNFSeIdle );
 end;
end;

{ TNFSeGerarNFSe }

constructor TNFSeGerarNFSe.Create(AOwner: TComponent;
  ANotasFiscais: TNotasFiscais);
begin
 inherited Create(AOwner);

 FNotasFiscais := ANotasFiscais;
end;

function TNFSeGerarNFSe.Executar: Boolean;
var
 aMsg        : String;
 Texto       : String;
 Acao        : TStringList;
 Stream      : TMemoryStream;
 StrStream   : TStringStream;

 {$IFDEF ACBrNFSeOpenSSL}
   HTTP    : THTTPSend;
 {$ELSE}
   ReqResp : THTTPReqResp;
 {$ENDIF}

 Prefixo3      : String;
 Prefixo4      : String;
 FRetListaNfse : AnsiString;
 FRetNfse      : AnsiString;
 i, j, k, p, ii: Integer;
 PathSalvar    : String;
begin
 inherited Executar;

 if Assigned(NFSeRetorno)
  then NFSeRetorno.Free;

 Texto := FProvedorClass.GeraEnvelopeGerarNFSe(URLNS1, FCabMSg, FDadosMsg, FDadosSenha);

 Acao      := TStringList.Create;
 Stream    := TMemoryStream.Create;
 Acao.Text := Texto;

 {$IFDEF ACBrNFSeOpenSSL}
   Acao.SaveToStream(Stream);
   HTTP := THTTPSend.Create;
 {$ELSE}
   ReqResp := THTTPReqResp.Create(nil);
   ConfiguraReqResp( ReqResp );
   ReqResp.URL := FURL;
   ReqResp.UseUTF8InHeader := True;

   ReqResp.SoapAction := FProvedorClass.GetSoapAction(acGerar, FNomeCidade);
 {$ENDIF}

 try
  TACBrNFSe( FACBrNFSe ).SetStatus( stNFSeRecepcao );

  if FConfiguracoes.WebServices.Salvar
   then FConfiguracoes.Geral.Save(IntToStr(NumeroRps)+'-ger-nfse-c.xml', Texto, FConfiguracoes.Arquivos.GetPathGer);

  if FConfiguracoes.Geral.Salvar
   then FConfiguracoes.Geral.Save(IntToStr(NumeroRps)+'-ger-nfse.xml', FDadosMsg, FConfiguracoes.Arquivos.GetPathGer);

  {$IFDEF ACBrNFSeOpenSSL}
    HTTP.Document.LoadFromStream(Stream);
    ConfiguraHTTP(HTTP, 'SOAPAction: "'+ FProvedorClass.GetSoapAction(acGerar, FNomeCidade) +'"');
    HTTP.HTTPMethod('POST', FURL);

    StrStream := TStringStream.Create('');
    StrStream.CopyFrom(HTTP.Document, 0);

    FRetornoWS := TiraAcentos(ParseText(StrStream.DataString, True));
    FRetWS     := FProvedorClass.GetRetornoWS(acGerar, FRetornoWS);

    StrStream.Free;
  {$ELSE}
    ReqResp.Execute(Acao.Text, Stream);
    StrStream := TStringStream.Create('');
    StrStream.CopyFrom(Stream, 0);

    FRetornoWS := TiraAcentos(ParseText(StrStream.DataString, True));
    FRetWS     := FProvedorClass.GetRetornoWS(acGerar, FRetornoWS);

    StrStream.Free;
  {$ENDIF}

  if FConfiguracoes.WebServices.Salvar
   then FConfiguracoes.Geral.Save(IntToStr(NumeroRps) + '-lista-nfse-c.xml', FRetornoWS, FConfiguracoes.Arquivos.GetPathGer);

  if FConfiguracoes.Geral.Salvar
   then FConfiguracoes.Geral.Save(IntToStr(NumeroRps) + '-lista-nfse.xml', NotaUtil.RetirarPrefixos(FRetWS), FConfiguracoes.Arquivos.GetPathGer);

  NFSeRetorno          := TGerarretNfse.Create;
  NFSeRetorno.Prefixo2 := FConfiguracoes.WebServices.Prefixo2;
  NFSeRetorno.Prefixo3 := FConfiguracoes.WebServices.Prefixo3;
  NFSeRetorno.Prefixo4 := FConfiguracoes.WebServices.Prefixo4;

  Prefixo3             := FConfiguracoes.WebServices.Prefixo3;
  Prefixo4             := FConfiguracoes.WebServices.Prefixo4;

  // Alterado por Rodrigo Cantelli
  case FProvedor of
   proBetha: begin
              NFSeRetorno.Prefixo3 := '';
              Prefixo3             := '';
             end;
   proISSNET: NFSeRetorno.Prefixo4 := '';
  end;

  NFSeRetorno.Leitor.Arquivo := FRetWS;
  NFSeRetorno.LerXml;

  TACBrNFSe( FACBrNFSe ).SetStatus( stNFSeIdle );

  FRetListaNfse := SeparaDados(FRetWS, Prefixo3 + 'ListaNfse');
  i := 0;
  while FRetListaNfse <> '' do
   begin
    // Alterado por Rodrigo Cantelli
    if FProvedor = proBetha
     then j := Pos('</' + Prefixo3 + 'ComplNfse>', FRetListaNfse)
     else j := Pos('</' + Prefixo3 + 'CompNfse>', FRetListaNfse);

    p := Length(trim(Prefixo3));
    if j > 0
     then begin
      FRetNfse := Copy(FRetListaNfse, 1, j - 1);
      k :=  Pos('<' + Prefixo4 + 'Nfse', FRetNfse);
      FRetNfse := Copy(FRetNfse, k, length(FRetNfse));

      FRetNFSe := FProvedorClass.GeraRetornoNFSe(Prefixo3, FRetNFSe, FNomeCidade);

      if FConfiguracoes.Geral.Salvar
       then begin
        PathSalvar := FConfiguracoes.Arquivos.GetPathNFSe(0);
        FConfiguracoes.Geral.Save(NFSeRetorno.ListaNfse.CompNfse.Items[i].Nfse.Numero + '-nfse.xml',
                                      NotaUtil.RetirarPrefixos(FRetNfse), PathSalvar);
        if FNotasFiscais.Count>0
         then FNotasFiscais.Items[i].NomeArq := PathWithDelim(PathSalvar) + NFSeRetorno.ListaNfse.CompNfse.Items[i].Nfse.Numero + '-nfse.xml';
       end;
      FRetListaNfse := Copy(FRetListaNfse, j + 11 + p, length(FRetListaNfse));

      inc(i);
     end
     else FRetListaNfse:='';
   end;
  (*
  i := 0;
  while FRetListaNfse <> '' do
   begin
    if FProvedor = proBetha
     then j := Pos('</' + Prefixo3 + 'ComplNfse>', FRetListaNfse)
     else j := Pos('</' + Prefixo3 + 'CompNfse>', FRetListaNfse);

    p := Length(trim(Prefixo3));
    if j > 0
     then begin

      // Alterado por Italo em 19/07/2012
      for ii := 0 to NFSeRetorno.ListaNfse.CompNfse.Count -1 do
       begin
        if FNotasFiscais.Items[ii].NFSe.IdentificacaoRps.Numero = NFSeRetorno.ListaNfse.CompNfse.Items[i].Nfse.IdentificacaoRps.Numero
         then begin
          FNotasFiscais.Items[ii].NFSe.CodigoVerificacao := NFSeRetorno.ListaNfse.CompNfse.Items[i].Nfse.CodigoVerificacao;
          FNotasFiscais.Items[ii].NFSe.Numero            := NFSeRetorno.ListaNfse.CompNfse.Items[i].Nfse.Numero;
          FNotasFiscais.Items[ii].NFSe.Competencia       := NFSeRetorno.ListaNfse.CompNfse.Items[i].Nfse.Competencia;
          FNotasFiscais.Items[ii].NFSe.NfseSubstituida   := NFSeRetorno.ListaNfse.CompNfse.Items[i].Nfse.NfseSubstituida;

          FNotasFiscais.Items[ii].NFSe.Servico.xItemListaServico := NFSeRetorno.ListaNfse.CompNfse.Items[i].Nfse.Servico.xItemListaServico;

          FNotasFiscais.Items[ii].NFSe.PrestadorServico.RazaoSocial  := NFSeRetorno.ListaNfse.CompNfse.Items[i].Nfse.PrestadorServico.RazaoSocial;
          FNotasFiscais.Items[ii].NFSe.PrestadorServico.NomeFantasia := NFSeRetorno.ListaNfse.CompNfse.Items[i].Nfse.PrestadorServico.NomeFantasia;

          FNotasFiscais.Items[ii].NFSe.PrestadorServico.IdentificacaoPrestador.Cnpj               := NFSeRetorno.ListaNfse.CompNfse.Items[i].Nfse.PrestadorServico.IdentificacaoPrestador.Cnpj;
          FNotasFiscais.Items[ii].NFSe.PrestadorServico.IdentificacaoPrestador.InscricaoMunicipal := NFSeRetorno.ListaNfse.CompNfse.Items[i].Nfse.PrestadorServico.IdentificacaoPrestador.InscricaoMunicipal;

          FNotasFiscais.Items[ii].NFSe.PrestadorServico.Endereco.Endereco        := NFSeRetorno.ListaNfse.CompNfse.Items[i].Nfse.PrestadorServico.Endereco.Endereco;
          FNotasFiscais.Items[ii].NFSe.PrestadorServico.Endereco.Numero          := NFSeRetorno.ListaNfse.CompNfse.Items[i].Nfse.PrestadorServico.Endereco.Numero;
          FNotasFiscais.Items[ii].NFSe.PrestadorServico.Endereco.Complemento     := NFSeRetorno.ListaNfse.CompNfse.Items[i].Nfse.PrestadorServico.Endereco.Complemento;
          FNotasFiscais.Items[ii].NFSe.PrestadorServico.Endereco.Bairro          := NFSeRetorno.ListaNfse.CompNfse.Items[i].Nfse.PrestadorServico.Endereco.Bairro;
          FNotasFiscais.Items[ii].NFSe.PrestadorServico.Endereco.CodigoMunicipio := NFSeRetorno.ListaNfse.CompNfse.Items[i].Nfse.PrestadorServico.Endereco.CodigoMunicipio;
          FNotasFiscais.Items[ii].NFSe.PrestadorServico.Endereco.UF              := NFSeRetorno.ListaNfse.CompNfse.Items[i].Nfse.PrestadorServico.Endereco.UF;
          FNotasFiscais.Items[ii].NFSe.PrestadorServico.Endereco.CEP             := NFSeRetorno.ListaNfse.CompNfse.Items[i].Nfse.PrestadorServico.Endereco.CEP;
          FNotasFiscais.Items[ii].NFSe.PrestadorServico.Endereco.xMunicipio      := NFSeRetorno.ListaNfse.CompNfse.Items[i].Nfse.PrestadorServico.Endereco.xMunicipio;

          FNotasFiscais.Items[ii].NFSe.PrestadorServico.Contato.Telefone := NFSeRetorno.ListaNfse.CompNfse.Items[i].Nfse.PrestadorServico.Contato.Telefone;
          FNotasFiscais.Items[ii].NFSe.PrestadorServico.Contato.Email    := NFSeRetorno.ListaNfse.CompNfse.Items[i].Nfse.PrestadorServico.Contato.Email;

          FNotasFiscais.Items[ii].NFSe.Tomador.Endereco.xMunicipio := NFSeRetorno.ListaNfse.CompNfse.Items[i].Nfse.Tomador.Endereco.xMunicipio;

          FRetNfse := Copy(FRetListaNfse, 1, j - 1);
          k :=  Pos('<' + Prefixo4 + 'Nfse', FRetNfse);
          FRetNfse := Copy(FRetNfse, k, length(FRetNfse));

          FRetNFSe := FProvedorClass.GeraRetornoNFSe(Prefixo3, FRetNFSe, FNomeCidade);

          if FConfiguracoes.Geral.Salvar
           then begin
            PathSalvar := FConfiguracoes.Arquivos.GetPathNFSe(0);
            FConfiguracoes.Geral.Save(NFSeRetorno.ListaNfse.CompNfse.Items[i].Nfse.Numero + '-nfse.xml',
                                      NotaUtil.RetirarPrefixos(FRetNfse), PathSalvar);
            if FNotasFiscais.Count>0
             then FNotasFiscais.Items[ii].NomeArq := PathWithDelim(PathSalvar) + NFSeRetorno.ListaNfse.CompNfse.Items[i].Nfse.Numero + '-nfse.xml';
           end;

          FRetListaNfse := Copy(FRetListaNfse, j + 11 + p, length(FRetListaNfse));

          FNotasFiscais.Items[ii].XML_NFSe := FRetNfse;

          break;
         end;
       end;

      inc(i);
     end
     else FRetListaNfse:='';
   end;
   *)
  TACBrNFSe( FACBrNFSe ).SetStatus( stNFSeIdle );

  // Lista de Mensagem de Retorno
  FMsg := '';
  if NFSeRetorno.ListaNfse.MsgRetorno.Count>0
   then begin
    aMsg:='';
    for i:=0 to NFSeRetorno.ListaNfse.MsgRetorno.Count - 1 do
     begin
      FMsg := FMsg + NFSeRetorno.ListaNfse.MsgRetorno.Items[i].Mensagem + IfThen(FMsg = '', '', ' / ');
      
      aMsg := aMsg + 'Código Erro : ' + NFSeRetorno.ListaNfse.MsgRetorno.Items[i].Codigo + LineBreak +
                     'Mensagem... : ' + NFSeRetorno.ListaNfse.MsgRetorno.Items[i].Mensagem + LineBreak+
                     'Correção... : ' + NFSeRetorno.ListaNfse.MsgRetorno.Items[i].Correcao + LineBreak+
                     'Provedor... : ' + FxProvedor + LineBreak;
     end;

    if FConfiguracoes.WebServices.Visualizar
     then ShowMessage(aMsg);
   end;

  if Assigned(TACBrNFSe( FACBrNFSe ).OnGerarLog)
   then TACBrNFSe( FACBrNFSe ).OnGerarLog(aMsg);

  Result := (FMsg = '');

 finally
  {$IFDEF ACBrNFSeOpenSSL}
    HTTP.Free;
  {$ELSE}
    ReqResp.Free;
  {$ENDIF}
  Acao.Free;
  Stream.Free;

  NotaUtil.ConfAmbiente;
  TACBrNFSe( FACBrNFSe ).SetStatus( stNFSeIdle );
 end;
end;

end.
