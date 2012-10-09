{$I ACBr.inc}

unit ACBrNFSeWebServices;

interface

uses
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
    pnfsConsNfseResposta, pnfsCancNfseResposta, pnfsConfiguraURL,
    ACBrNFSeNotasFiscais, ACBrNFSeConfiguracoes;

type

  TWebServicesBase = Class
  private
    procedure DoNFSeEnviarLoteRPS;
    procedure DoNFSeConsultarSituacaoLoteRPS;
    procedure DoNFSeConsultarLoteRPS;
    procedure DoNFSeConsultarNFSeporRPS;
    procedure DoNFSeConsultarNFSe;
    procedure DoNFSeCancelarNFSe;
    {$IFDEF ACBrNFSeOpenSSL}
      procedure ConfiguraHTTP( HTTP : THTTPSend; Action : AnsiString);
    {$ELSE}
      procedure ConfiguraReqResp( ReqResp : THTTPReqResp);
      procedure OnBeforePost(const HTTPReqResp: THTTPReqResp; Data:Pointer);
    {$ENDIF}
  protected
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
    FURLProvedor: String;
    FCabecalho: String;
    FServicoEnviar: String;
    FServicoConSit: String;
    FServicoConLot: String;
    FServicoConRps: String;
    FServicoConNfse: String;
    FServicoCancelar: String;
    FDefTipos: String;
    FRecepcaoLoteRps: String;
    FConsultaLoteRps: String;
    FConsultaNFSeRps: String;
    FConsultaSitLoteRps: String;
    FConsultaNFSe: String;
    FCancelaNFSe: String;

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
    property URLProvedor: String read FURLProvedor;
    property Cabecalho: String read FCabecalho;
    property ServicoEnviar: String read FServicoEnviar;
    property ServicoConSit: String read FServicoConSit;
    property ServicoConLot: String read FServicoConLot;
    property ServicoConRps: String read FServicoConRps;
    property ServicoConNfse: String read FServicoConNfse;
    property ServicoCancelar: String read FServicoCancelar;
    property DefTipos: String read FDefTipos;
    property RecepcaoLoteRps: String read FRecepcaoLoteRps;
    property ConsultaLoteRps: String read FConsultaLoteRps;
    property ConsultaNFSeRps: String read FConsultaNFSeRps;
    property ConsultaSitLoteRps: String read FConsultaSitLoteRps;
    property ConsultaNFSe: String read FConsultaNFSe;
    property CancelaNFSe: String read FCancelaNFSe;
  end;

  TNFSeEnviarLoteRPS = Class(TWebServicesBase)
  private
    FNumeroLote: Integer;
    FDataRecebimento: TDateTime;
    FProtocolo : String;
    FNotasFiscais : TNotasFiscais;
  public
    function Executar: Boolean; override;
    constructor Create(AOwner : TComponent; ANotasFiscais : TNotasFiscais); reintroduce;
    property NumeroLote: integer read FNumeroLote;
    property DataRecebimento: TDateTime read FDataRecebimento;
    property Protocolo: String read FProtocolo;
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
  public
    function Executar: Boolean; override;
    constructor Create(AOwner : TComponent; ANotasFiscais : TNotasFiscais); reintroduce;
    property Protocolo: String read FProtocolo write FProtocolo;
    property NFSeRetorno: TRetLote read FNFSeRetorno write FNFSeRetorno;
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
  public
    function Executar: Boolean; override;
    constructor Create(AOwner : TComponent; ANotasFiscais : TNotasFiscais); reintroduce;
    property CodigoCancelamento: String read FCodigoCancelamento write FCodigoCancelamento;
    property DataHora: TDateTime read FDataHora write FDataHora;
    property NFSeRetorno: TretCancNFSe read FNFSeRetorno write FNFSeRetorno;
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
  public
    constructor Create(AFNotaFiscalEletronica: TComponent); reintroduce;
    destructor Destroy; override;
    function Envia(ALote:Integer): Boolean;
    function ConsultaSituacao(ACnpj, AInscricaoMunicipal, AProtocolo: String): Boolean;
    function ConsultaLoteRps(AProtocolo: String): Boolean;
    function ConsutaNFSeporRps(ANumero, ASerie, ATipo, ACnpj, AInscricaoMunicipal: String): Boolean;
    function ConsutaNFSe(ACnpj, AInscricaoMunicipal: String; ADataInicial, ADataFinal: TDateTime): Boolean;
    function CancelaNFSe(ACodigoCancelamento: String): Boolean;

  published
    property ACBrNFSe: TComponent read FACBrNFSe write FACBrNFSe;
    property Enviar: TNFSeEnviarLoteRPS read FEnviar write FEnviar;
    property ConsSitLote: TNFSeConsultarSituacaoLoteRPS read FConsSitLote write FConsSitLote;
    property ConsLote: TNFSeConsultarLoteRPS read FConsLote write FConsLote;
    property ConsNfseRps: TNFSeConsultarNfseRps read FConsNfseRps write FConsNfseRps;
    property ConsNfse: TNFSeConsultarNfse read FConsNfse write FConsNfse;
    property CancNfse: TNFSeCancelarNfse read FCancNfse write FCancNfse;
  end;

implementation

uses
 {$IFDEF ACBrNFSeOpenSSL}
   ssl_openssl,
 {$ENDIF}
 IniFiles, Math, ACBrUtil, ACBrNFSeUtil, ACBrNFSe;

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

 if not InternetSetOption(Data, INTERNET_OPTION_CLIENT_CERT_CONTEXT, PCertContext, Sizeof(CERT_CONTEXT)*5)
  then begin
   if Assigned(TACBrNFSe( FACBrNFSe ).OnGerarLog)
    then TACBrNFSe( FACBrNFSe ).OnGerarLog('ERRO: Erro OnBeforePost: ' + IntToStr(GetLastError));
   raise Exception.Create( 'Erro OnBeforePost: ' + GetLastErrorText {IntToStr(GetLastError)} );
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
 i      : Integer;
 vNotas : WideString;
begin
 vNotas := '';

 if FCabecalho <> ''
  then begin
   if Prefixo2<>''
    then FNameSpaceCab := ' xmlns:' + stringReplace(Prefixo2, ':', '', []) + '="' + FHTTP_AG + FCabecalho +'">'
    else FNameSpaceCab := ' xmlns="' + FHTTP_AG + FCabecalho +'">';
  end
  else FNameSpaceCab := '>';

 if FServicoEnviar <> ''
  then begin
   if Prefixo3<>''
    then FNameSpaceDad := 'xmlns:' + stringReplace(Prefixo3, ':', '', []) + '="' + FHTTP_AG + FServicoEnviar + '"'
    else FNameSpaceDad := 'xmlns="' + FHTTP_AG + FServicoEnviar + '"';
  end
  else FNameSpaceDad := '';

 if (FDefTipos = '') and (FNameSpaceDad <> '')
  then FNameSpaceDad := FNameSpaceDad + '>';

 if FDefTipos <> ''
  then begin
   if Prefixo4<>''
    then FNameSpaceDad := FNameSpaceDad +
                        ' xmlns:' + stringReplace(Prefixo4, ':', '', []) + '="' + FHTTP_AG + FDefTipos + '">'
    else FNameSpaceDad := FNameSpaceDad + ' xmlns="' + FHTTP_AG + FDefTipos + '">';
  end;

 if FNameSpaceDad = ''
  then FNameSpaceDad := '>'
  else FNameSpaceDad := ' ' + FNameSpaceDad;

 if FConfiguracoes.Certificados.AssinarRPS
  then begin
   for i := 0 to TNFSeEnviarLoteRPS(Self).FNotasFiscais.Count-1 do
    vNotas := vNotas + '<' + Prefixo4 + 'Rps>' +
                        '<' + Prefixo4 + 'InfRps' +
                         RetornarConteudoEntre(TNFSeEnviarLoteRPS(Self).FNotasFiscais.Items[I].XML_Rps_Ass,
                              '<' + Prefixo4 + 'InfRps', '</Rps>') +
                       '</' + Prefixo4 + 'Rps>';
  end
  else begin
   for i := 0 to TNFSeEnviarLoteRPS(Self).FNotasFiscais.Count-1 do
    vNotas := vNotas + '<' + Prefixo4 + 'Rps>' +
                        '<' + Prefixo4 + 'InfRps' +
                         RetornarConteudoEntre(TNFSeEnviarLoteRPS(Self).FNotasFiscais.Items[I].XML_Rps,
                              '<' + Prefixo4 + 'InfRps', '</Rps>') +
                       '</' + Prefixo4 + 'Rps>';
  end;

 FCabMsg   := '<' + Prefixo2 + 'cabecalho versao="'  + FVersaoLayOut + '"' + NameSpaceCab +
               '<versaoDados>' + FVersaoDados + '</versaoDados>'+
              '</' + Prefixo2 + 'cabecalho>';

 if (FURLProvedor = 'GovBR')
  then FTagI := '<' + Prefixo3 + 'EnviarLoteRpsEnvio>'
  else FTagI := '<' + Prefixo3 + 'EnviarLoteRpsEnvio' + NameSpaceDad;

 FDadosSenha := '';

 if (FURLProvedor = 'SimplISS')
  then begin
   FDadosSenha := '<P1 xmlns="http://www.sistema.com.br/Sistema.Ws.Nfse.Cn">' +
                    SomenteNumeros(TNFSeEnviarLoteRPS(Self).FNotasFiscais.Items[0].NFSe.Prestador.Cnpj) +
                  '</P1>' +
                  '<P2 xmlns="http://www.sistema.com.br/Sistema.Ws.Nfse.Cn">' +
                    FConfiguracoes.WebServices.SenhaWeb +
                  '</P2>';
  end;

 FDadosMsg := '<' + Prefixo3 + 'LoteRps'+
                NotaUtil.SeSenao(FConfiguracoes.WebServices.Identificador <> '',
                                 ' ' + FConfiguracoes.WebServices.Identificador +
                                 '="' +
                                 NotaUtil.SeSenao((FURLProvedor <> 'GovBR'),
                                 IntToStr(TNFSeEnviarLoteRps(Self).NumeroLote), '') +
                                 '"', '') +
                NotaUtil.SeSenao((FURLProvedor = 'SimplISS'), NameSpaceDad, '') +
                NotaUtil.SeSenao((FURLProvedor = 'Prodemge') or
                                 (FURLProvedor = 'WebISS') or
                                 (FURLProvedor = 'Equiplano'), ' versao="' + VersaoDados + '"', '') +
                NotaUtil.SeSenao((FURLProvedor = 'SimplISS'), '', '>') +
               '<' + Prefixo4 + 'NumeroLote>' +
                IntToStr(TNFSeEnviarLoteRps(Self).NumeroLote) +
               '</' + Prefixo4 + 'NumeroLote>' +

               NotaUtil.SeSenao(FVersaoXML = '1',

                 '<' + Prefixo4 + 'CpfCnpj>' +
                 '<' + Prefixo4 + 'Cnpj>' +
                  SomenteNumeros(TNFSeEnviarLoteRPS(Self).FNotasFiscais.Items[0].NFSe.Prestador.Cnpj) +
                 '</' + Prefixo4 + 'Cnpj>' +
                 '</' + Prefixo4 + 'CpfCnpj>',

                 '<' + Prefixo4 + 'Cnpj>' +
                  SomenteNumeros(TNFSeEnviarLoteRPS(Self).FNotasFiscais.Items[0].NFSe.Prestador.Cnpj) +
                 '</' + Prefixo4 + 'Cnpj>') +

               '<' + Prefixo4 + 'InscricaoMunicipal>' +
                TNFSeEnviarLoteRPS(Self).FNotasFiscais.Items[0].NFSe.Prestador.InscricaoMunicipal +
               '</' + Prefixo4 + 'InscricaoMunicipal>' +
               '<' + Prefixo4 + 'QuantidadeRps>' +
                IntToStr(TNFSeEnviarLoteRps(Self).FNotasFiscais.Count) +
               '</' + Prefixo4 + 'QuantidadeRps>' +
               '<' + Prefixo4 + 'ListaRps>' +
                vNotas +
               '</' + Prefixo4 + 'ListaRps>' +
              '</' + Prefixo3 + 'LoteRps>';

 FTagF     := '</' + Prefixo3 + 'EnviarLoteRpsEnvio>';

 if (FURLProvedor <> 'SimplISS')
  then FDadosMsg := FTagI + FDadosMsg + FTagF;

 if FConfiguracoes.Geral.Salvar
  then FConfiguracoes.Geral.Save('-xxx.xml', FDadosMsg);

 FDadosMsg := TNFSeEnviarLoteRPS(Self).FNotasFiscais.AssinarLoteRps(TNFSeEnviarLoteRps(Self).NumeroLote, FDadosMSg);

 if (FURLProvedor <> 'GovBR') and (FURLProvedor <> 'SimplISS')
  then begin
   if not(NotaUtil.Valida(FDadosMsg, FMsg, FConfiguracoes.Geral.PathSchemas,
                          FConfiguracoes.WebServices.ConfigSchemas, FConfiguracoes.WebServices.Prefixo4))
    then raise Exception.Create('Falha na validação do Lote ' +
                   IntToStr(TNFSeEnviarLoteRps(Self).NumeroLote) + sLineBreak + FMsg);
  end;
end;

procedure TWebServicesBase.DoNFSeConsultarSituacaoLoteRPS;
begin
 if FCabecalho <> ''
  then begin
   if Prefixo2<>''
    then FNameSpaceCab := ' xmlns:' + stringReplace(Prefixo2, ':', '', []) + '="' + FHTTP_AG + FCabecalho +'">'
    else FNameSpaceCab := ' xmlns="' + FHTTP_AG + FCabecalho +'">';
  end
  else FNameSpaceCab := '>';

 if FServicoConSit <> ''
  then begin
   if Prefixo3<>''
    then FNameSpaceDad := 'xmlns:' + stringReplace(Prefixo3, ':', '', []) + '="' + FHTTP_AG + FServicoConSit + '"'
    else FNameSpaceDad := 'xmlns="' + FHTTP_AG + FServicoConSit + '"';
  end
  else FNameSpaceDad := '';

 if (FDefTipos = '') and (FNameSpaceDad <> '')
  then FNameSpaceDad := FNameSpaceDad + '>';

 if FDefTipos <> ''
  then begin
   if Prefixo4<>''
    then FNameSpaceDad := FNameSpaceDad +
                        ' xmlns:' + stringReplace(Prefixo4, ':', '', []) + '="' + FHTTP_AG + FDefTipos + '">'
    else FNameSpaceDad := FNameSpaceDad +
                        ' xmlns="' + FHTTP_AG + FDefTipos + '">';
  end;

 FCabMsg   := '<' + Prefixo2 + 'cabecalho versao="'  + FVersaoLayOut + '"' + NameSpaceCab +
               '<versaoDados>' + FVersaoDados + '</versaoDados>'+
              '</' + Prefixo2 + 'cabecalho>';

 if (FURLProvedor = 'GovBR') or (FURLProvedor = 'SimplISS')
  then FTagI := '<' + Prefixo3 + 'ConsultarSituacaoLoteRpsEnvio>'
  else FTagI := '<' + Prefixo3 + 'ConsultarSituacaoLoteRpsEnvio ' + NameSpaceDad;

 FDadosSenha := '';

 if (FURLProvedor = 'SimplISS')
  then begin
   FDadosSenha := '<P1 xmlns="http://www.sistema.com.br/Sistema.Ws.Nfse.Cn">' +
                    SomenteNumeros(TNFSeConsultarSituacaoLoteRPS(Self).Cnpj) +
                  '</P1>' +
                  '<P2 xmlns="http://www.sistema.com.br/Sistema.Ws.Nfse.Cn">' +
                    FConfiguracoes.WebServices.SenhaWeb +
                  '</P2>';
  end;

 FDadosMsg := '<' + Prefixo3 + 'Prestador' +
                NotaUtil.SeSenao(FURLProvedor = 'SimplISS', ' ' + NameSpaceDad, '>') +

               NotaUtil.SeSenao(FVersaoXML = '1',

                 '<' + Prefixo4 + 'CpfCnpj>' +
                 '<' + Prefixo4 + 'Cnpj>' +
                  SomenteNumeros(TNFSeConsultarSituacaoLoteRPS(Self).Cnpj) +
                 '</' + Prefixo4 + 'Cnpj>' +
                 '</' + Prefixo4 + 'CpfCnpj>',

                 '<' + Prefixo4 + 'Cnpj>' +
                  SomenteNumeros(TNFSeConsultarSituacaoLoteRPS(Self).Cnpj) +
                 '</' + Prefixo4 + 'Cnpj>') +

               '<' + Prefixo4 + 'InscricaoMunicipal>' +
                TNFSeConsultarSituacaoLoteRPS(Self).InscricaoMunicipal +
               '</' + Prefixo4 + 'InscricaoMunicipal>' +
              '</' + Prefixo3 + 'Prestador>' +
              '<' + Prefixo3 + 'Protocolo' +
                NotaUtil.SeSenao(FURLProvedor = 'SimplISS', ' ' + NameSpaceDad, '>') +
               TNFSeConsultarSituacaoLoteRPS(Self).Protocolo +
              '</' + Prefixo3 + 'Protocolo>';

 FTagF     := '</' + Prefixo3 + 'ConsultarSituacaoLoteRpsEnvio>';

 if (FURLProvedor = 'GINFES')
  then begin
   if not(NotaUtil.AssinarXML(FDadosMsg, '', FTagI, FTagF,
                   FConfiguracoes.Certificados.GetCertificado, FvAssinada, FMsg))
    then raise Exception.Create('Falha ao assinar o XML ' + FMsg)
    else FDadosMsg := FvAssinada;
  end
  else FDadosMsg := FTagI + FDadosMsg + FTagF;

 if FConfiguracoes.Geral.Salvar
  then FConfiguracoes.Geral.Save(TNFSeConsultarSituacaoLoteRps(Self).Protocolo + '-con-sit.xml', FDadosMsg, FConfiguracoes.Arquivos.GetPathGer);

end;

procedure TWebServicesBase.DoNFSeConsultarLoteRPS;
begin
 if FCabecalho <> ''
  then begin
   if Prefixo2<>''
    then FNameSpaceCab := ' xmlns:' + stringReplace(Prefixo2, ':', '', []) + '="' + FHTTP_AG + FCabecalho +'">'
    else FNameSpaceCab := ' xmlns="' + FHTTP_AG + FCabecalho +'">';
  end
  else FNameSpaceCab := '>';

 if FServicoConLot <> ''
  then begin
   if Prefixo3<>''
    then FNameSpaceDad := 'xmlns:' + stringReplace(Prefixo3, ':', '', []) + '="' + FHTTP_AG + FServicoConLot + '"'
    else FNameSpaceDad := 'xmlns="' + FHTTP_AG + FServicoConLot + '"';
  end
  else FNameSpaceDad := '';

 if (FDefTipos = '') and (FNameSpaceDad <> '')
  then FNameSpaceDad := FNameSpaceDad + '>';

 if FDefTipos <> ''
  then begin
   if Prefixo4<>''
    then FNameSpaceDad := FNameSpaceDad +
                        ' xmlns:' + stringReplace(Prefixo4, ':', '', []) + '="' + FHTTP_AG + FDefTipos + '">'
    else FNameSpaceDad := FNameSpaceDad +
                        ' xmlns="' + FHTTP_AG + FDefTipos + '">';
  end;

 FCabMsg   := '<' + Prefixo2 + 'cabecalho versao="'  + FVersaoLayOut + '"' + NameSpaceCab +
               '<versaoDados>' + FVersaoDados + '</versaoDados>'+
              '</' + Prefixo2 + 'cabecalho>';

 if (FURLProvedor = 'GovBR') or (FURLProvedor = 'SimplISS')
  then FTagI := '<' + Prefixo3 + 'ConsultarLoteRpsEnvio>'
  else FTagI := '<' + Prefixo3 + 'ConsultarLoteRpsEnvio ' + NameSpaceDad;

 FDadosSenha := '';

 if (FURLProvedor = 'SimplISS')
  then begin
   FDadosSenha := '<P1 xmlns="http://www.sistema.com.br/Sistema.Ws.Nfse.Cn">' +
                    SomenteNumeros(TNFSeConsultarLoteRPS(Self).FNotasFiscais.Items[0].NFSe.Prestador.Cnpj) +
                  '</P1>' +
                  '<P2 xmlns="http://www.sistema.com.br/Sistema.Ws.Nfse.Cn">' +
                    FConfiguracoes.WebServices.SenhaWeb +
                  '</P2>';
  end;

 FDadosMsg := '<' + Prefixo3 + 'Prestador' +
                NotaUtil.SeSenao(FURLProvedor = 'SimplISS', ' ' + NameSpaceDad, '>') +

// FDadosMsg := '<' + Prefixo3 + 'Prestador>' +

               NotaUtil.SeSenao(FVersaoXML = '1',

                 '<' + Prefixo4 + 'CpfCnpj>' +
                 '<' + Prefixo4 + 'Cnpj>' +
                  SomenteNumeros(TNFSeConsultarLoteRPS(Self).FNotasFiscais.Items[0].NFSe.Prestador.Cnpj) +
                 '</' + Prefixo4 + 'Cnpj>' +
                 '</' + Prefixo4 + 'CpfCnpj>',

                 '<' + Prefixo4 + 'Cnpj>' +
                  SomenteNumeros(TNFSeConsultarLoteRPS(Self).FNotasFiscais.Items[0].NFSe.Prestador.Cnpj) +
                 '</' + Prefixo4 + 'Cnpj>') +

               '<' + Prefixo4 + 'InscricaoMunicipal>' +
                TNFSeConsultarLoteRPS(Self).FNotasFiscais.Items[0].NFSe.Prestador.InscricaoMunicipal+
               '</' + Prefixo4 + 'InscricaoMunicipal>' +
              '</' + Prefixo3 + 'Prestador>' +
              '<' + Prefixo3 + 'Protocolo' +
                NotaUtil.SeSenao(FURLProvedor = 'SimplISS', ' ' + NameSpaceDad, '>') +
               TNFSeConsultarLoteRPS(Self).Protocolo +
              '</' + Prefixo3 + 'Protocolo>';

 FTagF     := '</' + Prefixo3 + 'ConsultarLoteRpsEnvio>';

 if (FURLProvedor = 'GINFES')
  then begin
   if not(NotaUtil.AssinarXML(FDadosMsg, '', FTagI, FTagF,
                   FConfiguracoes.Certificados.GetCertificado, FvAssinada, FMsg))
    then raise Exception.Create('Falha ao assinar o XML ' + FMsg)
    else FDadosMsg := FvAssinada;
  end
  else FDadosMsg := FTagI + FDadosMsg + FTagF;
end;

procedure TWebServicesBase.DoNFSeConsultarNFSeporRPS;
begin
 if FCabecalho <> ''
  then begin
   if Prefixo2<>''
    then FNameSpaceCab := ' xmlns:' + stringReplace(Prefixo2, ':', '', []) + '="' + FHTTP_AG + FCabecalho +'">'
    else FNameSpaceCab := ' xmlns="' + FHTTP_AG + FCabecalho +'">';
  end
  else FNameSpaceCab := '>';

 if FServicoConRps <> ''
  then begin
   if Prefixo3<>''
    then FNameSpaceDad := 'xmlns:' + stringReplace(Prefixo3, ':', '', []) + '="' + FHTTP_AG + FServicoConRps + '"'
    else FNameSpaceDad := 'xmlns="' + FHTTP_AG + FServicoConRps + '"';
  end
  else FNameSpaceDad := '';

 if (FDefTipos = '') and (FNameSpaceDad <> '')
  then FNameSpaceDad := FNameSpaceDad + '>';

 if FDefTipos <> ''
  then begin
   if Prefixo4<>''
    then FNameSpaceDad := FNameSpaceDad +
                        ' xmlns:' + stringReplace(Prefixo4, ':', '', []) + '="' + FHTTP_AG + FDefTipos + '">'
    else FNameSpaceDad := FNameSpaceDad +
                        ' xmlns="' + FHTTP_AG + FDefTipos + '">';
  end;

 FCabMsg   := '<' + Prefixo2 + 'cabecalho versao="'  + FVersaoLayOut + '"' + NameSpaceCab +
               '<versaoDados>' + FVersaoDados + '</versaoDados>'+
              '</' + Prefixo2 + 'cabecalho>';

 if (FURLProvedor = 'GovBR') or (FURLProvedor = 'SimplISS')
  then FTagI := '<' + Prefixo3 + 'ConsultarNfseRpsEnvio>'
  else FTagI := '<' + Prefixo3 + 'ConsultarNfseRpsEnvio ' + NameSpaceDad;

 FDadosSenha := '';

 if (FURLProvedor = 'SimplISS')
  then begin
   FDadosSenha := '<P1 xmlns="http://www.sistema.com.br/Sistema.Ws.Nfse.Cn">' +
                    SomenteNumeros(TNFSeConsultarNfseRPS(Self).Cnpj) +
                  '</P1>' +
                  '<P2 xmlns="http://www.sistema.com.br/Sistema.Ws.Nfse.Cn">' +
                    FConfiguracoes.WebServices.SenhaWeb +
                  '</P2>';
  end;

 FDadosMsg := '<' + Prefixo3 + 'IdentificacaoRps>' +
               '<' + Prefixo4 + 'Numero>' +
                TNFSeConsultarNfseRPS(Self).Numero +
               '</' + Prefixo4 + 'Numero>' +
               '<' + Prefixo4 + 'Serie>' +
                TNFSeConsultarNfseRPS(Self).Serie +
               '</' + Prefixo4 + 'Serie>' +
               '<' + Prefixo4 + 'Tipo>' +
                TNFSeConsultarNfseRPS(Self).Tipo +
               '</' + Prefixo4 + 'Tipo>' +
              '</' + Prefixo3 + 'IdentificacaoRps>' +
              '<' + Prefixo3 + 'Prestador>' +

               NotaUtil.SeSenao(FVersaoXML = '1',

                 '<' + Prefixo4 + 'CpfCnpj>' +
                 '<' + Prefixo4 + 'Cnpj>' +
                  SomenteNumeros(TNFSeConsultarNfseRPS(Self).Cnpj) +
                 '</' + Prefixo4 + 'Cnpj>' +
                 '</' + Prefixo4 + 'CpfCnpj>',

                 '<' + Prefixo4 + 'Cnpj>' +
                  SomenteNumeros(TNFSeConsultarNfseRPS(Self).Cnpj) +
                 '</' + Prefixo4 + 'Cnpj>') +

               '<' + Prefixo4 + 'InscricaoMunicipal>' +
                TNFSeConsultarNfseRPS(Self).InscricaoMunicipal +
               '</' + Prefixo4 + 'InscricaoMunicipal>' +
              '</' + Prefixo3 + 'Prestador>';

 FTagF := '</' + Prefixo3 + 'ConsultarNfseRpsEnvio>';

 if (FURLProvedor = 'GINFES')
  then begin
   if not(NotaUtil.AssinarXML(FDadosMsg, '', FTagI, FTagF,
                   FConfiguracoes.Certificados.GetCertificado, FvAssinada, FMsg))
    then raise Exception.Create('Falha ao assinar o XML ' + FMsg)
    else FDadosMsg := FvAssinada;
  end
  else FDadosMsg := FTagI + FDadosMsg + FTagF;

end;

procedure TWebServicesBase.DoNFSeConsultarNFSe;
begin
 if FCabecalho <> ''
  then begin
   if Prefixo2<>''
    then FNameSpaceCab := ' xmlns:' + stringReplace(Prefixo2, ':', '', []) + '="' + FHTTP_AG + FCabecalho +'">'
    else FNameSpaceCab := ' xmlns="' + FHTTP_AG + FCabecalho +'">';
  end
  else FNameSpaceCab := '>';

 if FServicoConNfse <> ''
  then begin
   if Prefixo3<>''
    then FNameSpaceDad := 'xmlns:' + stringReplace(Prefixo3, ':', '', []) + '="' + FHTTP_AG + FServicoConNfse + '"'
    else FNameSpaceDad := 'xmlns="' + FHTTP_AG + FServicoConNfse + '"';
  end
  else FNameSpaceDad := '';

 if (FDefTipos = '') and (FNameSpaceDad <> '')
  then FNameSpaceDad := FNameSpaceDad + '>';

 if FDefTipos <> ''
  then begin
   if Prefixo4<>''
    then FNameSpaceDad := FNameSpaceDad +
                        ' xmlns:' + stringReplace(Prefixo4, ':', '', []) + '="' + FHTTP_AG + FDefTipos + '">'
    else FNameSpaceDad := FNameSpaceDad +
                        ' xmlns="' + FHTTP_AG + FDefTipos + '">';
  end;

 FCabMsg   := '<' + Prefixo2 + 'cabecalho versao="'  + FVersaoLayOut + '"' + NameSpaceCab +
               '<versaoDados>' + FVersaoDados + '</versaoDados>'+
              '</' + Prefixo2 + 'cabecalho>';

 if (FURLProvedor = 'GovBR') or (FURLProvedor = 'SimplISS')
  then FTagI := '<' + Prefixo3 + 'ConsultarNfseEnvio>'
  else FTagI := '<' + Prefixo3 + 'ConsultarNfseEnvio ' + NameSpaceDad;

 FDadosSenha := '';

 if (FURLProvedor = 'SimplISS')
  then begin
   FDadosSenha := '<P1 xmlns="http://www.sistema.com.br/Sistema.Ws.Nfse.Cn">' +
                    SomenteNumeros(TNFSeConsultarNfse(Self).Cnpj) +
                  '</P1>' +
                  '<P2 xmlns="http://www.sistema.com.br/Sistema.Ws.Nfse.Cn">' +
                    FConfiguracoes.WebServices.SenhaWeb +
                  '</P2>';
  end;

 FDadosMsg := '<' + Prefixo3 + 'Prestador>' +

               NotaUtil.SeSenao(FVersaoXML = '1',

                 '<' + Prefixo4 + 'CpfCnpj>' +
                 '<' + Prefixo4 + 'Cnpj>' +
                  SomenteNumeros(TNFSeConsultarNfse(Self).Cnpj) +
                 '</' + Prefixo4 + 'Cnpj>' +
                 '</' + Prefixo4 + 'CpfCnpj>',

                 '<' + Prefixo4 + 'Cnpj>' +
                  SomenteNumeros(TNFSeConsultarNfse(Self).Cnpj) +
                 '</' + Prefixo4 + 'Cnpj>') +

               '<' + Prefixo4 + 'InscricaoMunicipal>' +
                TNFSeConsultarNfse(Self).InscricaoMunicipal +
               '</' + Prefixo4 + 'InscricaoMunicipal>' +
              '</' + Prefixo3 + 'Prestador>';

 if (TNFSeConsultarNfse(Self).DataInicial>0) and
    (TNFSeConsultarNfse(Self).DataFinal>0)
  then FDadosMsg := FDadosMsg + '<' + Prefixo3 + 'PeriodoEmissao>' +
                                 '<' + Prefixo3 + 'DataInicial>' +
                                  FormatDateTime('yyyy-mm-dd', TNFSeConsultarNfse(Self).DataInicial) +
                                 '</' + Prefixo3 + 'DataInicial>' +
                                 '<' + Prefixo3 + 'DataFinal>' +
                                  FormatDateTime('yyyy-mm-dd', TNFSeConsultarNfse(Self).DataFinal) +
                                 '</' + Prefixo3 + 'DataFinal>' +
                                '</' + Prefixo3 + 'PeriodoEmissao>';

 FTagF     := '</' + Prefixo3 + 'ConsultarNfseEnvio>';

 if (FURLProvedor = 'GINFES')
  then begin
   if not(NotaUtil.AssinarXML(FDadosMsg, '', FTagI, FTagF,
                   FConfiguracoes.Certificados.GetCertificado, FvAssinada, FMsg))
    then raise Exception.Create('Falha ao assinar o XML ' + FMsg)
    else FDadosMsg := FvAssinada;
  end
  else FDadosMsg := FTagI + FDadosMsg + FTagF;

end;

procedure TWebServicesBase.DoNFSeCancelarNFSe;
var
 URI: String;
begin
 if FCabecalho <> ''
  then begin
   if Prefixo2<>''
    then FNameSpaceCab := ' xmlns:' + stringReplace(Prefixo2, ':', '', []) + '="' + FHTTP_AG + FCabecalho +'">'
    else FNameSpaceCab := ' xmlns="' + FHTTP_AG + FCabecalho +'">';
  end
  else FNameSpaceCab := '>';

 if FServicoCancelar <> ''
  then begin
   if Prefixo3<>''
    then FNameSpaceDad := 'xmlns:' + stringReplace(Prefixo3, ':', '', []) + '="' + FHTTP_AG + FServicoCancelar + '"'
    else FNameSpaceDad := 'xmlns="' + FHTTP_AG + FServicoCancelar + '"';
  end
  else FNameSpaceDad := '';

 if (FDefTipos = '') and (FNameSpaceDad <> '')
  then FNameSpaceDad := FNameSpaceDad + '>';

 if FDefTipos <> ''
  then begin
   if Prefixo4<>''
    then begin
     if (FURLProvedor = 'GINFES')
      then FDefTipos := 'tipos_v02.xsd';
     FNameSpaceDad := FNameSpaceDad +
                        ' xmlns:' + stringReplace(Prefixo4, ':', '', []) + '="' + FHTTP_AG + FDefTipos + '">';
    end
    else FNameSpaceDad := FNameSpaceDad +
                        ' xmlns="' + FHTTP_AG + FDefTipos + '">';
  end;

 FDadosSenha := '';

 if (FURLProvedor = 'SimplISS')
  then begin
   FDadosSenha := '<P1 xmlns="http://www.sistema.com.br/Sistema.Ws.Nfse.Cn">' +
                    SomenteNumeros(TNFSeCancelarNfse(Self).FNotasFiscais.Items[0].NFSe.PrestadorServico.IdentificacaoPrestador.Cnpj) +
                  '</P1>' +
                  '<P2 xmlns="http://www.sistema.com.br/Sistema.Ws.Nfse.Cn">' +
                    FConfiguracoes.WebServices.SenhaWeb +
                  '</P2>';
  end;

 if (FURLProvedor = 'GINFES')
  then begin
   FVersaoLayOut := '2';
   FVersaoDados  := '2';
//   FTagI := '<' + Prefixo3 + 'CancelarNfseEnvio ' + NameSpaceDad;
     FTagI := '<CancelarNfseEnvio' + ' xmlns="http://www.ginfes.com.br/servico_cancelar_nfse_envio"' +
                                     ' xmlns:' + stringReplace(Prefixo4, ':', '', []) + '="http://www.ginfes.com.br/tipos">';
   URI:='';

   FDadosMsg := '<Prestador>' +
                 '<' + Prefixo4 + 'Cnpj>' +
                  SomenteNumeros(TNFSeCancelarNfse(Self).FNotasFiscais.Items[0].NFSe.PrestadorServico.IdentificacaoPrestador.Cnpj) +
                 '</' + Prefixo4 + 'Cnpj>' +
                 '<' + Prefixo4 + 'InscricaoMunicipal>' +
                  TNFSeCancelarNfse(Self).FNotasFiscais.Items[0].NFSe.PrestadorServico.IdentificacaoPrestador.InscricaoMunicipal +
                 '</' + Prefixo4 + 'InscricaoMunicipal>' +
                '</Prestador>' +
                '<NumeroNfse>' +
                  TNFSeCancelarNfse(Self).FNotasFiscais.Items[0].NFSe.Numero +
                '</NumeroNfse>';
   {
  FDadosMsg := '<Prestador>' +
                '<' + 'tipos:' + 'Cnpj>' +
                  SomenteNumeros(TNFSeCancelarNfse(Self).FNotasFiscais.Items[0].NFSe.PrestadorServico.IdentificacaoPrestador.Cnpj) +
                '</' + 'tipos:' + 'Cnpj>' +
                '<' + 'tipos:' + 'InscricaoMunicipal>' +
                  TNFSeCancelarNfse(Self).FNotasFiscais.Items[0].NFSe.PrestadorServico.IdentificacaoPrestador.InscricaoMunicipal +
                '</' + 'tipos:' + 'InscricaoMunicipal>' +
                '</Prestador>' +
                '<NumeroNfse>' +
                  TNFSeCancelarNfse(Self).FNotasFiscais.Items[0].NFSe.Numero +
                '</NumeroNfse>';
  }
//   FTagF := '</' + Prefixo3 + 'CancelarNfseEnvio>';
   FTagF := '</CancelarNfseEnvio>';
  end
  else begin
   FCabMsg   := '<' + Prefixo2 + 'cabecalho versao="'  + FVersaoLayOut + '"' + NameSpaceCab +
                 '<versaoDados>' + FVersaoDados + '</versaoDados>'+
                '</' + Prefixo2 + 'cabecalho>';

   URI := 'pedidoCancelamento_' +
              SomenteNumeros(TNFSeCancelarNfse(Self).FNotasFiscais.Items[0].NFSe.PrestadorServico.IdentificacaoPrestador.Cnpj +
              TNFSeCancelarNfse(Self).FNotasFiscais.Items[0].NFSe.PrestadorServico.IdentificacaoPrestador.InscricaoMunicipal +
              TNFSeCancelarNfse(Self).FNotasFiscais.Items[0].NFSe.Numero);

   if (FURLProvedor = 'GovBR') or (FURLProvedor = 'SimplISS')
    then begin
     FTagI := '<' + Prefixo3 + 'CancelarNfseEnvio>' +
               '<' + Prefixo3 + 'Pedido' +
                     NotaUtil.SeSenao(FURLProvedor = 'SimplISS', ' ' + NameSpaceDad, '>') +
                '<' + Prefixo4 + 'InfPedidoCancelamento>';
     URI := '';
    end
    else FTagI := '<' + Prefixo3 + 'CancelarNfseEnvio ' + NameSpaceDad +
                   '<' + Prefixo3 + 'Pedido>' +
                    '<' + Prefixo4 + 'InfPedidoCancelamento Id="' + URI + '">';

   FDadosMsg := '<' + Prefixo4 + 'IdentificacaoNfse>' +
                 '<' + Prefixo4 + 'Numero>' +
                  TNFSeCancelarNfse(Self).FNotasFiscais.Items[0].NFSe.Numero +
                 '</' + Prefixo4 + 'Numero>' +
                 '<' + Prefixo4 + 'Cnpj>' +
                  SomenteNumeros(TNFSeCancelarNfse(Self).FNotasFiscais.Items[0].NFSe.PrestadorServico.IdentificacaoPrestador.Cnpj) +
                 '</' + Prefixo4 + 'Cnpj>' +
                 '<' + Prefixo4 + 'InscricaoMunicipal>' +
                  TNFSeCancelarNfse(Self).FNotasFiscais.Items[0].NFSe.PrestadorServico.IdentificacaoPrestador.InscricaoMunicipal +
                 '</' + Prefixo4 + 'InscricaoMunicipal>' +
                 '<' + Prefixo4 + 'CodigoMunicipio>' +
                  TNFSeCancelarNfse(Self).FNotasFiscais.Items[0].NFSe.PrestadorServico.Endereco.CodigoMunicipio +
                 '</' + Prefixo4 + 'CodigoMunicipio>' +
                '</' + Prefixo4 + 'IdentificacaoNfse>' +
                '<' + Prefixo4 + 'CodigoCancelamento>' +

                 // Codigo de Cancelamento
                 // 1 - Erro de emissão
                 // 2 - Serviço não concluido
                 // 3 - RPS Cancelado na Emissão

                 TNFSeCancelarNfse(Self).FCodigoCancelamento +

//                '</' + Prefixo4 + 'CodigoCancelamento>';

                '</' + Prefixo4 + 'CodigoCancelamento>' +
               '</' + Prefixo4 + 'InfPedidoCancelamento>';
(*
   FTagF     :=  '</' + Prefixo4 + 'InfPedidoCancelamento>' +
                '</' + Prefixo3 + 'Pedido>' +
               '</' + Prefixo3 + 'CancelarNfseEnvio>';
*)
   FTagF     := '</' + Prefixo3 + 'Pedido>' +
               '</' + Prefixo3 + 'CancelarNfseEnvio>';
  end;

 if (FURLProvedor = 'GINFES') or (FURLProvedor = 'Prodemge')
  then begin
   if not(NotaUtil.AssinarXML(FDadosMsg,
                   NotaUtil.SeSenao(FURLProvedor = 'GINFES', '', URI), FTagI, FTagF,
                   FConfiguracoes.Certificados.GetCertificado, FvAssinada, FMsg))
    then raise Exception.Create('Falha ao assinar o XML ' + FMsg)
    else FDadosMsg := FvAssinada;
  end
  else FDadosMsg := FTagI + FDadosMsg + FTagF;
end;

function TWebServicesBase.Executar: Boolean;
begin
 Result := False;
 LoadMsgEntrada;
 LoadURL;
end;

procedure TWebServicesBase.LoadMsgEntrada;
var
 IniFile       : String;
 Ini           : TIniFile;
 ACodigoSchema : String;
begin
 FURLProvedor  := FConfiguracoes.WebServices.Provedor;
 FPrefixo2     := FConfiguracoes.WebServices.Prefixo2;
 FPrefixo3     := FConfiguracoes.WebServices.Prefixo3;
 FPrefixo4     := FConfiguracoes.WebServices.Prefixo4;
 FURLNS1       := FConfiguracoes.WebServices.NameSpace;
 ACodigoSchema := FConfiguracoes.WebServices.ConfigSchemas;

 if ACodigoSchema = ''
  then raise Exception.Create('Código do Schema não Informado.');

 IniFile := PathWithDelim(FConfiguracoes.Geral.PathSchemas) + 'Config_Schemas.ini';

 Ini := TIniFile.Create( IniFile );
 try
  FVersaoLayOut    := ini.ReadString(ACodigoSchema, 'VersaoCabecalho', '');
  FVersaoDados     := ini.ReadString(ACodigoSchema, 'VersaoDados',     '');
  FVersaoXML       := ini.ReadString(ACodigoSchema, 'VersaoXML',       '');
  FHTTP_AG         := ini.ReadString(ACodigoSchema, 'URL',             '');
  FCabecalho       := ini.ReadString(ACodigoSchema, 'Cabecalho',       '');
  FServicoEnviar   := ini.ReadString(ACodigoSchema, 'ServicoEnviar',   '');
  FServicoConSit   := ini.ReadString(ACodigoSchema, 'ServicoConSit',   '');
  FServicoConLot   := ini.ReadString(ACodigoSchema, 'ServicoConLot',   '');
  FServicoConRps   := ini.ReadString(ACodigoSchema, 'ServicoConRps',   '');
  FServicoConNfse  := ini.ReadString(ACodigoSchema, 'ServicoConNfse',  '');
  FServicoCancelar := ini.ReadString(ACodigoSchema, 'ServicoCancelar', '');
  FDefTipos        := ini.ReadString(ACodigoSchema, 'DefTipos',        '');
 finally
  Ini.Free;
 end;

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
  then DoNFSeCancelarNfse;
end;

procedure TWebServicesBase.LoadURL;
var
 IniFile       : String;
 Ini           : TIniFile;
 ACodigoURL : String;
begin
 ACodigoURL := FConfiguracoes.WebServices.ConfigURL;

 if ACodigoURL = ''
  then raise Exception.Create('Código do URL não Informado.');

 IniFile := PathWithDelim(FConfiguracoes.Geral.PathSchemas) + 'Config_URL.ini';

 Ini := TIniFile.Create( IniFile );
 try
  if FConfiguracoes.WebServices.AmbienteCodigo = 1
   then begin
    FRecepcaoLoteRps    := ini.ReadString(ACodigoURL, 'ProRecepcaoLoteRPS',    '');
    FConsultaLoteRps    := ini.ReadString(ACodigoURL, 'ProConsultaLoteRPS',    '');
    FConsultaNFSeRps    := ini.ReadString(ACodigoURL, 'ProConsultaNFSeRPS',    '');
    FConsultaSitLoteRps := ini.ReadString(ACodigoURL, 'ProConsultaSitLoteRPS', '');
    FConsultaNFSe       := ini.ReadString(ACodigoURL, 'ProConsultaNFSe',       '');
    FCancelaNFSe        := ini.ReadString(ACodigoURL, 'ProCancelaNFSe',        '');
   end
   else begin
    FRecepcaoLoteRps    := ini.ReadString(ACodigoURL, 'HomRecepcaoLoteRPS',    '');
    FConsultaLoteRps    := ini.ReadString(ACodigoURL, 'HomConsultaLoteRPS',    '');
    FConsultaNFSeRps    := ini.ReadString(ACodigoURL, 'HomConsultaNFSeRPS',    '');
    FConsultaSitLoteRps := ini.ReadString(ACodigoURL, 'HomConsultaSitLoteRPS', '');
    FConsultaNFSe       := ini.ReadString(ACodigoURL, 'HomConsultaNFSe',       '');
    FCancelaNFSe        := ini.ReadString(ACodigoURL, 'HomCancelaNFSe',        '');
   end;
 finally
  Ini.Free;
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
  then FURL := FCancelaNFSe;
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
end;

destructor TWebServices.Destroy;
begin
 FEnviar.Free;
 FConsSitLote.Free;
 FConsLote.Free;
 FConsNfseRps.Free;
 FConsNfse.Free;
 FCancNfse.Free;

 inherited;
end;

function TWebServices.Envia(ALote:Integer): Boolean;
begin
 self.Enviar.FNumeroLote := ALote;

 if not(Self.Enviar.Executar)
  then begin
   if Assigned(TACBrNFSe( FACBrNFSe ).OnGerarLog)
    then TACBrNFSe( FACBrNFSe ).OnGerarLog(Self.Enviar.Msg);
   raise Exception.Create(Self.Enviar.Msg);
  end;

 Self.ConsSitLote.Cnpj               := TACBrNFSe( FACBrNFSe ).NotasFiscais.Items[0].NFSe.Prestador.Cnpj;
 Self.ConsSitLote.InscricaoMunicipal := TACBrNFSe( FACBrNFSe ).NotasFiscais.Items[0].NFSe.Prestador.InscricaoMunicipal;
 Self.ConsSitLote.Protocolo          := Self.Enviar.Protocolo;

 Self.ConsLote.Protocolo := Self.Enviar.Protocolo;

 if not(Self.ConsSitLote.Executar)
  then begin
   if Assigned(TACBrNFSe( FACBrNFSe ).OnGerarLog)
    then TACBrNFSe( FACBrNFSe ).OnGerarLog(Self.ConsSitLote.Msg);
   raise Exception.Create(Self.ConsSitLote.Msg);
  end;

 if not(Self.ConsLote.Executar)
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
 if not(Self.ConsSitLote.Executar)
  then begin
   if Assigned(TACBrNFSe( FACBrNFSe ).OnGerarLog)
    then TACBrNFSe( FACBrNFSe ).OnGerarLog(Self.ConsSitLote.Msg);
   raise Exception.Create(Self.ConsSitLote.Msg);
  end;

 Result := true;
end;

function TWebServices.ConsultaLoteRps(AProtocolo: String): Boolean;
begin
 Self.ConsLote.Protocolo := AProtocolo;

 if not(Self.ConsLote.Executar)
  then begin
   if Assigned(TACBrNFSe( FACBrNFSe ).OnGerarLog)
    then TACBrNFSe( FACBrNFSe ).OnGerarLog(Self.ConsLote.Msg);
   raise Exception.Create(Self.ConsLote.Msg);
  end;

 Result := true;
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
 if not(Self.ConsNfseRps.Executar)
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
 if not(Self.ConsNfse.Executar)
  then begin
   if Assigned(TACBrNFSe( FACBrNFSe ).OnGerarLog)
    then TACBrNFSe( FACBrNFSe ).OnGerarLog(Self.ConsNfse.Msg);
   raise Exception.Create(Self.ConsNfse.Msg);
  end;

 Result := true;
end;

function TWebServices.CancelaNFSe(ACodigoCancelamento: String): Boolean;
begin
 Self.CancNfse.CodigoCancelamento := ACodigoCancelamento;
 if not(Self.CancNfse.Executar)
  then begin
   if Assigned(TACBrNFSe( FACBrNFSe ).OnGerarLog)
    then TACBrNFSe( FACBrNFSe ).OnGerarLog(Self.CancNfse.Msg);
   raise Exception.Create(Self.CancNfse.Msg);
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
 NFSeRetorno : TretEnvLote;
 aMsg        : String;
 Texto       : String;
 Acao        : TStringList;
 Stream      : TMemoryStream;
 StrStream   : TStringStream;
 Ok          : Boolean;
 i           : Integer;

 {$IFDEF ACBrNFSeOpenSSL}
   HTTP    : THTTPSend;
 {$ELSE}
   ReqResp : THTTPReqResp;
 {$ENDIF}

begin
 {Result :=} inherited Executar;

// TnfseProvedor = ( proTiplan, proISSNET, proWebISS, proGINFES, proDSF, proProdemge, proAbaco, proBetha, proEquiplano, proISSIntel, proProdam );
 case StrToProvedor(Ok, FURLProvedor) of
  proRJ    : Texto := '<?xml version="1.0" encoding="utf-8"?>' +
                      '<soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">'+
                         '<soap:Body>' +
                          '<RecepcionarLoteRpsRequest xmlns="' + URLNS1 + '/">' +
                           '<inputXML>' +
                               StringReplace(StringReplace(FDadosMsg,
                                                           '<', '&lt;', [rfReplaceAll]), '>', '&gt;', [rfReplaceAll]) +
                           '</inputXML>' +
                          '</RecepcionarLoteRpsRequest>' +
                         '</soap:Body>' +
                       '</soap:Envelope>';
  proTiplan    : Texto := '<?xml version="1.0" encoding="utf-8"?>' +
                          '<soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">' +
                           '<soap:Body>' +
                            '<RecepcionarLoteRpsRequest xmlns="' + URLNS1 + '/">' +
                             '<inputXML>' +
                               StringReplace(StringReplace(FDadosMsg,
                                                           '<', '&lt;', [rfReplaceAll]), '>', '&gt;', [rfReplaceAll]) +
                             '</inputXML>' +
                            '</RecepcionarLoteRpsRequest>' +
                           '</soap:Body>' +
                          '</soap:Envelope>';
  proISSNET    : Texto := '<?xml version="1.0" encoding="utf-8"?>' +
                          '<soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">' +
                           '<soap:Body>' +
                            '<RecepcionarLoteRps xmlns="' + URLNS1 + '">' +
                             '<xml>' +
                               '&lt;?xml version="1.0" encoding="utf-8"?&gt;' +
                               StringReplace(StringReplace(
                                             {'<nfseCabecMsg>' + FCabMsg + '</nfseCabecMsg>' + '<nfseDadosMsg>' +}
                                             FDadosMsg {+ '</nfseDadosMsg>'},
                                                           '<', '&lt;', [rfReplaceAll]), '>', '&gt;', [rfReplaceAll]) +
                             '</xml>' +
                            '</RecepcionarLoteRps>' +
                           '</soap:Body>' +
                          '</soap:Envelope>';
  proWebISS    : Texto := '<?xml version="1.0" encoding="utf-8"?>' +
                          '<s:Envelope xmlns:s="http://schemas.xmlsoap.org/soap/envelope/">' +
                           '<s:Body>' +
                            '<RecepcionarLoteRps xmlns="' + URLNS1 + '/">' +
                             '<cabec>' +
                              '&lt;?xml version="1.0" encoding="utf-8"?&gt;' +
                               StringReplace(StringReplace(FCabMsg, '<', '&lt;', [rfReplaceAll]), '>', '&gt;', [rfReplaceAll]) +
                             '</cabec>' +
                             '<msg>' +
                              '&lt;?xml version="1.0" encoding="utf-8"?&gt;' +
                               StringReplace(StringReplace(FDadosMsg, '<', '&lt;', [rfReplaceAll]), '>', '&gt;', [rfReplaceAll]) +
                             '</msg>' +
                            '</RecepcionarLoteRps>' +
                           '</s:Body>' +
                          '</s:Envelope>';
  proGINFES    : Texto := '<?xml version="1.0" encoding="utf-8"?>' +
                          '<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/">' +
                           '<soapenv:Body>' +
                            '<ns1:RecepcionarLoteRpsV3 xmlns:ns1="' + URLNS1 + '">' +
                             '<arg0>' + FCabMsg + '</arg0>' +
                             '<arg1>' + FDadosMsg + '</arg1>' +
                            '</ns1:RecepcionarLoteRpsV3>' +
                           '</soapenv:Body>' +
                          '</soapenv:Envelope>';
  proDSF       : Texto := '';
  proProdemge  : Texto := '<?xml version="1.0" encoding="utf-8"?>' +
                          '<s:Envelope xmlns:s="http://schemas.xmlsoap.org/soap/envelope/">' +
                           '<s:Body>' +
                            '<ns2:RecepcionarLoteRpsRequest xmlns:ns2="' + URLNS1 + '">' +
                             '<nfseCabecMsg>' +
                              '&lt;?xml version="1.0" encoding="utf-8"?&gt;' +
                              StringReplace(StringReplace(FCabMsg, '<', '&lt;', [rfReplaceAll]), '>', '&gt;', [rfReplaceAll]) +
                             '</nfseCabecMsg>' +
                             '<nfseDadosMsg>' +
                              '&lt;?xml version="1.0" encoding="utf-8"?&gt;' +
                              StringReplace(StringReplace(FDadosMsg, '<', '&lt;', [rfReplaceAll]), '>', '&gt;', [rfReplaceAll]) +
                             '</nfseDadosMsg>' +
                            '</ns2:RecepcionarLoteRpsRequest>' +
                           '</s:Body>' +
                          '</s:Envelope>';
  proAbaco     : Texto := '';
  proBetha     : Texto := '';
  proEquiplano : Texto := '<?xml version="1.0" encoding="utf-8"?>' +
                          '<s:Envelope xmlns:s="http://schemas.xmlsoap.org/soap/envelope/">' +
                           '<s:Body>' +
                            '<esRecepcionarLoteRps xmlns="' + URLNS1 + '">' +
                             '<nrVersaoXml>' +
                              '1' +
                             '</nrVersaoXml>' +
                             '<xml>' +
                              '&lt;?xml version="1.0" encoding="utf-8"?&gt;' +
                              StringReplace(StringReplace(FDadosMsg, '<', '&lt;', [rfReplaceAll]), '>', '&gt;', [rfReplaceAll]) +
                             '</xml>' +
                            '</esRecepcionarLoteRps>' +
                           '</s:Body>' +
                          '</s:Envelope>';
  proISSIntel  : Texto := '';
  proProdam    : Texto := '';
  proGovBR     : Texto := '<?xml version="1.0" encoding="utf-8"?>' +
                          '<s:Envelope xmlns:s="http://schemas.xmlsoap.org/soap/envelope/" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">' +
                           '<s:Body>' +
                            '<RecepcionarLoteRps xmlns="' + URLNS1 + '/">' +
                             '<xmlEnvio>' +
                              '&lt;?xml version="1.0" encoding="utf-8"?&gt;' +
                              StringReplace(StringReplace(FDadosMsg, '<', '&lt;', [rfReplaceAll]), '>', '&gt;', [rfReplaceAll]) +
                             '</xmlEnvio>' +
                            '</RecepcionarLoteRps>' +
                           '</s:Body>' +
                          '</s:Envelope>';
  proRecife    : Texto := '<?xml version="1.0" encoding="utf-8"?>' +
                          '<soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">' +
                           '<soap:Body>' +
                            '<EnviarLoteRpsEnvio xmlns="' + URLNS1 + '">' +
                             '<MensagemXML>' +
                               StringReplace(StringReplace(FDadosMsg, '<', '&lt;', [rfReplaceAll]), '>', '&gt;', [rfReplaceAll]) +
                             '</MensagemXML>' +
                            '</EnviarLoteRpsEnvio>' +
                           '</soap:Body>' +
                          '</soap:Envelope>';
  proSimplISS  : Texto := '<?xml version="1.0" encoding="utf-8"?>' +
                          '<s:Envelope xmlns:s="http://schemas.xmlsoap.org/soap/envelope/"' +
                                     ' xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"' +
                                     ' xmlns:xsd="http://www.w3.org/2001/XMLSchema">' +
                           '<s:Body>' +
                            '<RecepcionarLoteRps xmlns="' + URLNS1 + '">' +
                             '<EnviarLoteRpsEnvio>' +
                              FDadosMsg +
                             '</EnviarLoteRpsEnvio>' +
                             '<pParam>' +
                               FDadosSenha +
                             '</pParam>' +
                            '</RecepcionarLoteRps>' +
                           '</s:Body>' +
                          '</s:Envelope>';
  proThema     : Texto := '<?xml version="1.0" encoding="utf-8"?>' +
                          '<soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"' +
                                        ' xmlns:xsd="http://www.w3.org/2001/XMLSchema"' +
                                        ' xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">' +
                           '<soap:Body>' +
                            '<recepcionarLoteRps xmlns="' + URLNS1 + '">' +
                             '<xml>' +
                               '&lt;?xml version="1.0" encoding="utf-8"?&gt;' +
                               StringReplace(StringReplace(
                                             {'<nfseCabecMsg>' + FCabMsg + '</nfseCabecMsg>' + '<nfseDadosMsg>' +}
                                             FDadosMsg {+ '</nfseDadosMsg>'},
                                                           '<', '&lt;', [rfReplaceAll]), '>', '&gt;', [rfReplaceAll]) +
                             '</xml>' +
                            '</recepcionarLoteRps>' +
                           '</soap:Body>' +
                          '</soap:Envelope>';
  proPublica   : Texto := '<?xml version="1.0" encoding="utf-8"?>' +
                          '<soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"' +
                                        ' xmlns:xsd="http://www.w3.org/2001/XMLSchema"' +
                                        ' xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">' +
                           '<soap:Body>' +
                            '<RecepcionarLoteRps xmlns="' + URLNS1 + '">' +
                             '<XML>' +
                               '&lt;?xml version="1.0" encoding="utf-8"?&gt;' +
                               StringReplace(StringReplace(
                                             {'<nfseCabecMsg>' + FCabMsg + '</nfseCabecMsg>' + '<nfseDadosMsg>' +}
                                             FDadosMsg {+ '</nfseDadosMsg>'},
                                                           '<', '&lt;', [rfReplaceAll]), '>', '&gt;', [rfReplaceAll]) +
                             '</XML>' +
                            '</RecepcionarLoteRps>' +
                           '</soap:Body>' +
                          '</soap:Envelope>';
  else Texto := '';
 end;

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

   case StrToProvedor(Ok, FURLProvedor) of
    proRJ        : ReqResp.SoapAction := 'http://notacarioca.rio.gov.br/RecepcionarLoteRps';
    proTiplan    : ReqResp.SoapAction := 'http://www.nfe.com.br/RecepcionarLoteRps';
    proISSNET    : ReqResp.SoapAction := 'http://www.issnetonline.com.br/webservice/nfd/RecepcionarLoteRps';
    proWebISS    : ReqResp.SoapAction := 'http://tempuri.org/INfseServices/RecepcionarLoteRps';
    proGINFES    : ReqResp.SoapAction := '';
    proDSF       : ReqResp.SoapAction := '';
    proProdemge  : ReqResp.SoapAction := 'http://ws.bhiss.pbh.gov.br/RecepcionarLoteRps';
    proAbaco     : ReqResp.SoapAction := '';
    proBetha     : ReqResp.SoapAction := '';
    proEquiplano : ReqResp.SoapAction := 'urn:esRecepcionarLoteRps';
    proISSIntel  : ReqResp.SoapAction := '';
    proProdam    : ReqResp.SoapAction := '';
    proGovBR     : ReqResp.SoapAction := 'http://tempuri.org/INFSEGeracao/RecepcionarLoteRps';
    proRecife    : ReqResp.SoapAction := 'http://www.abrasf.org.br/ABRASF/arquivos/nfse.xsd/WSNacional/RecepcionarLoteRps';
    proSimplISS  : ReqResp.SoapAction := 'http://www.sistema.com.br/Sistema.Ws.Nfse/INfseService/RecepcionarLoteRps';
    proThema     : ReqResp.SoapAction := '';
    proPublica   : ReqResp.SoapAction := '';
//    proThema     : ReqResp.SoapAction := 'urn:recepcionarLoteRps';

    else ReqResp.SoapAction := '';
   end;
 {$ENDIF}

 try
  TACBrNFSe( FACBrNFSe ).SetStatus( stNFSeRecepcao );

  if FConfiguracoes.Geral.Salvar
   then FConfiguracoes.Geral.Save(IntToStr(NumeroLote)+'-env-lot-c.xml', Texto, FConfiguracoes.Arquivos.GetPathGer);

  if FConfiguracoes.Geral.Salvar
   then FConfiguracoes.Geral.Save(IntToStr(NumeroLote)+'-env-lot.xml', FDadosMsg, FConfiguracoes.Arquivos.GetPathGer);

  {$IFDEF ACBrNFSeOpenSSL}
    HTTP.Document.LoadFromStream(Stream);
    ConfiguraHTTP(HTTP,'SOAPAction: "http://tempuri.org/INfseServices/RecepcionarLoteRps"');
    HTTP.HTTPMethod('POST', FURL);

    StrStream := TStringStream.Create('');
    StrStream.CopyFrom(HTTP.Document, 0);
    FRetWS := SeparaDados( ParseText(StrStream.DataString, True),'RecepcionarLoteRpsV3');
    StrStream.Free;
  {$ELSE}
    ReqResp.Execute(Acao.Text, Stream);
    StrStream := TStringStream.Create('');
    StrStream.CopyFrom(Stream, 0);
    FRetornoWS := TiraAcentos(ParseText(StrStream.DataString, True));

    case StrToProvedor(Ok, FURLProvedor) of
     proRJ        : FRetWS := SeparaDados( FRetornoWS, 'outputXML' );
     proTiplan    : FRetWS := SeparaDados( FRetornoWS, 'outputXML' );
     proISSNET    : begin
                     FRetWS := SeparaDados( FRetornoWS, 'RecepcionarLoteRpsResult' );
                     FRetWS := StringReplace(FRetWS, ' xmlns="http://www.issnetonline.com.br/webserviceabrasf/vsd/servico_enviar_lote_rps_resposta.xsd"', '', [rfReplaceAll]);
                     FRetWS := StringReplace(FRetWS, ' xmlns="http://www.issnetonline.com.br/webserviceabrasf/vsd/tipos_complexos.xsd"', '', [rfReplaceAll]);
                    end;
     proWebISS    : FRetWS := SeparaDados( FRetornoWS, 'RecepcionarLoteRpsResult' );
     proGINFES    : FRetWS := SeparaDados( FRetornoWS, 'return' );
     proDSF       : FRetWS := SeparaDados( FRetornoWS, '' );
     proProdemge  : FRetWS := SeparaDados( FRetornoWS, 'outputXML' );
     proAbaco     : FRetWS := SeparaDados( FRetornoWS, '' );
     proBetha     : FRetWS := SeparaDados( FRetornoWS, '' );
     proEquiplano : FRetWS := SeparaDados( FRetornoWS, 'ns:return' );
     proISSIntel  : FRetWS := SeparaDados( FRetornoWS, '' );
     proProdam    : FRetWS := SeparaDados( FRetornoWS, '' );
     proGovBR     : FRetWS := SeparaDados( FRetornoWS, 'RecepcionarLoteRpsResult' );
     proRecife    : begin
                     FRetWS := SeparaDados( FRetornoWS, 'EnviarLoteRpsResposta>' );
                     FRetWS := FRetWS + '</EnviarLoteRpsResposta>';
                    end;
     proSimplISS  : begin
                     FRetWS := SeparaDados( FRetornoWS, 'RecepcionarLoteRpsResult' );
                     FRetWS := StringReplace(FRetWS, ' xmlns="http://www.sistema.com.br/Nfse/arquivos/nfse_3.xsd"', '', [rfReplaceAll]);
                     FRetWS := '<EnviarLoteRpsResposta xmlns="http://www.sistema.com.br/Nfse/arquivos/nfse_3.xsd">' +
                                 FRetWS +
                               '</EnviarLoteRpsResposta>';
                    end;

     proThema     : FRetWS := SeparaDados( FRetornoWS, 'recepcionarLoteRpsResponse' );
     proPublica   : FRetWS := SeparaDados( FRetornoWS, 'RecepcionarLoteRpsResponse' );
     else FRetWS := SeparaDados( FRetornoWS, 'outputXML' );
    end;

    StrStream.Free;
  {$ENDIF}

  if FConfiguracoes.Geral.Salvar
   then FConfiguracoes.Geral.Save(IntToStr(NumeroLote)+'-rec-c.xml', FRetornoWS, FConfiguracoes.Arquivos.GetPathGer);

  if FConfiguracoes.Geral.Salvar
   then FConfiguracoes.Geral.Save(IntToStr(NumeroLote)+'-rec.xml', FRetWS, FConfiguracoes.Arquivos.GetPathGer);

  NFSeRetorno                := TretEnvLote.Create;
  NFSeRetorno.Prefixo2       := FConfiguracoes.WebServices.Prefixo2;
  NFSeRetorno.Prefixo3       := FConfiguracoes.WebServices.Prefixo3;
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
      FMsg := FMsg + NFSeRetorno.infRec.MsgRetorno.Items[i].Mensagem + ' / ';
      aMsg := aMsg + 'Código Erro : ' + NFSeRetorno.InfRec.MsgRetorno.Items[i].Codigo + LineBreak +
                     'Mensagem... : ' + NFSeRetorno.infRec.MsgRetorno.Items[i].Mensagem + LineBreak+
                     'Correção... : ' + NFSeRetorno.InfRec.MsgRetorno.Items[i].Correcao + LineBreak+
                     'Provedor... : ' + FURLProvedor + LineBreak;
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
            'Provedor...... : ' + FURLProvedor + LineBreak;
   end;

  if FConfiguracoes.WebServices.Visualizar
   then ShowMessage(aMsg);

  if Assigned(TACBrNFSe( FACBrNFSe ).OnGerarLog)
   then TACBrNFSe( FACBrNFSe ).OnGerarLog(aMsg);

  Result := (NFSeRetorno.InfRec.Protocolo<>'');

  NFSeRetorno.Free;

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
 NFSeRetorno : TretSitLote;
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

// TnfseProvedor = ( proTiplan, proISSNET, proWebISS, proGINFES, proDSF, proProdemge, proAbaco, proBetha, proEquiplano, proISSIntel, proProdam );
 case StrToProvedor(Ok, FURLProvedor) of
  proRJ      : Texto := '<?xml version="1.0" encoding="utf-8"?>' +
                          '<soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">' +
                           '<soap:Body>' +
                            '<ConsultarSituacaoLoteRpsRequest xmlns="' + URLNS1 + '/">' +
                             '<inputXML>' +
                               StringReplace(StringReplace(FDadosMsg,
                                                           '<', '&lt;', [rfReplaceAll]), '>', '&gt;', [rfReplaceAll]) +
                             '</inputXML>' +
                            '</ConsultarSituacaoLoteRpsRequest>' +
                           '</soap:Body>' +
                          '</soap:Envelope>';
  proTiplan    : Texto := '<?xml version="1.0" encoding="utf-8"?>' +
                          '<soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">' +
                           '<soap:Body>' +
                            '<ConsultarSituacaoLoteRpsRequest xmlns="' + URLNS1 + '/">' +
                             '<inputXML>' +
                               StringReplace(StringReplace(FDadosMsg,
                                                           '<', '&lt;', [rfReplaceAll]), '>', '&gt;', [rfReplaceAll]) +
                             '</inputXML>' +
                            '</ConsultarSituacaoLoteRpsRequest>' +
                           '</soap:Body>' +
                          '</soap:Envelope>';
  proISSNET    : Texto := '<?xml version="1.0" encoding="utf-8"?>' +
                          '<soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">' +
                           '<soap:Body>' +
                            '<ConsultaSituacaoLoteRPS xmlns="' + URLNS1 + '">' +
                             '<xml>' +
                               '&lt;?xml version="1.0" encoding="utf-8"?&gt;' +
                               StringReplace(StringReplace({'<nfseCabecMsg>' + FCabMsg + '</nfseCabecMsg>' +
                                                           '<nfseDadosMsg>' +} FDadosMsg {+ '</nfseDadosMsg>'},
                                                           '<', '&lt;', [rfReplaceAll]), '>', '&gt;', [rfReplaceAll]) +
                             '</xml>' +
                            '</ConsultaSituacaoLoteRPS>' +
                           '</soap:Body>' +
                          '</soap:Envelope>';
  proWebISS    : Texto := '<?xml version="1.0" encoding="utf-8"?>' +
                          '<s:Envelope xmlns:s="http://schemas.xmlsoap.org/soap/envelope/">' +
                           '<s:Body>' +
                            '<ConsultarSituacaoLoteRps xmlns="' + URLNS1 + '/">' +
                             '<cabec>' +
                              '&lt;?xml version="1.0" encoding="utf-8"?&gt;' +
                               StringReplace(StringReplace(FCabMsg, '<', '&lt;', [rfReplaceAll]), '>', '&gt;', [rfReplaceAll]) +
                             '</cabec>' +
                             '<msg>' +
                              '&lt;?xml version="1.0" encoding="utf-8"?&gt;' +
                               StringReplace(StringReplace(FDadosMsg, '<', '&lt;', [rfReplaceAll]), '>', '&gt;', [rfReplaceAll]) +
                             '</msg>' +
                            '</ConsultarSituacaoLoteRps>' +
                           '</s:Body>' +
                          '</s:Envelope>';
  proGINFES    : Texto := '<?xml version="1.0" encoding="utf-8"?>' +
                          '<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/">' +
                           '<soapenv:Body>' +
                            '<ns1:ConsultarSituacaoLoteRpsV3 xmlns:ns1="' + URLNS1 + '">' +
                             '<arg0>' + FCabMsg + '</arg0>' +
                             '<arg1>' + FDadosMsg + '</arg1>' +
                            '</ns1:ConsultarSituacaoLoteRpsV3>' +
                           '</soapenv:Body>' +
                          '</soapenv:Envelope>';
  proDSF       : Texto := '';
  proProdemge  : Texto := '<?xml version="1.0" encoding="utf-8"?>' +
                          '<soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">' +
                           '<soap:Body>' +
                            '<ns2:ConsultarSituacaoLoteRpsRequest xmlns:ns2="' + URLNS1 + '">' +
                             '<nfseCabecMsg>' +
                              StringReplace(StringReplace(FCabMsg, '<', '&lt;', [rfReplaceAll]), '>', '&gt;', [rfReplaceAll]) +
                             '</nfseCabecMsg>' +
                             '<nfseDadosMsg>' +
                              StringReplace(StringReplace(FDadosMsg, '<', '&lt;', [rfReplaceAll]), '>', '&gt;', [rfReplaceAll]) +
                             '</nfseDadosMsg>' +
                            '</ns2:ConsultarSituacaoLoteRpsRequest>' +
                           '</soap:Body>' +
                          '</soap:Envelope>';
  proAbaco     : Texto := '';
  proBetha     : Texto := '';
  proEquiplano : Texto := '';
  proISSIntel  : Texto := '';
  proProdam    : Texto := '';
  proGovBR     : Texto := '<?xml version="1.0" encoding="utf-8"?>' +
                          '<s:Envelope xmlns:s="http://schemas.xmlsoap.org/soap/envelope/" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">' +
                           '<s:Body>' +
                            '<ConsultarSituacaoLoteRps xmlns="' + URLNS1 + '/">' +
                             '<xmlEnvio>' +
                              '&lt;?xml version="1.0" encoding="utf-8"?&gt;' +
                               StringReplace(StringReplace(FDadosMsg, '<', '&lt;', [rfReplaceAll]), '>', '&gt;', [rfReplaceAll]) +
                             '</xmlEnvio>' +
                            '</ConsultarSituacaoLoteRps>' +
                           '</s:Body>' +
                          '</s:Envelope>';
  proRecife    : Texto := '<?xml version="1.0" encoding="utf-8"?>' +
                          '<soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">' +
                           '<soap:Body>' +
                            '<ConsultarSituacaoLoteRpsEnvio xmlns="' + URLNS1 + '">' +
                             '<MensagemXML>' +
                               StringReplace(StringReplace(
                                             {'<nfseCabecMsg>' + FCabMsg + '</nfseCabecMsg>' + '<nfseDadosMsg>' +}
                                             FDadosMsg {+ '</nfseDadosMsg>'},
                                                           '<', '&lt;', [rfReplaceAll]), '>', '&gt;', [rfReplaceAll]) +
                             '</MensagemXML>' +
                            '</ConsultarSituacaoLoteRpsEnvio>' +
                           '</soap:Body>' +
                          '</soap:Envelope>';
  proSimplISS  : Texto := '<?xml version="1.0" encoding="utf-8"?>' +
                          '<s:Envelope xmlns:s="http://schemas.xmlsoap.org/soap/envelope/"' +
                                     ' xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"' +
                                     ' xmlns:xsd="http://www.w3.org/2001/XMLSchema">' +
                           '<s:Body>' +
                            '<ConsultarSituacaoLoteRps xmlns="' + URLNS1 + '">' +
//                             '<ConsultarSituacaoLoteRpsEnvio>' +
                              FDadosMsg +
//                             '</ConsultarSituacaoLoteRpsEnvio>' +
                             '<pParam>' +
                               FDadosSenha +
                             '</pParam>' +
                            '</ConsultarSituacaoLoteRps>' +
                           '</s:Body>' +
                          '</s:Envelope>';
  proThema     : Texto := '<?xml version="1.0" encoding="utf-8"?>' +
                          '<soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">' +
                           '<soap:Body>' +
                            '<ConsultaSituacaoLoteRPS xmlns="' + URLNS1 + '">' +
                             '<xml>' +
                              '&lt;?xml version="1.0" encoding="utf-8"?&gt;' +
                              StringReplace(StringReplace({'<nfseCabecMsg>' + FCabMsg + '</nfseCabecMsg>' +
                                                           '<nfseDadosMsg>' +} FDadosMsg {+ '</nfseDadosMsg>'},
                                                           '<', '&lt;', [rfReplaceAll]), '>', '&gt;', [rfReplaceAll]) +
                             '</xml>' +
                            '</ConsultaSituacaoLoteRPS>' +
                           '</soap:Body>' +
                          '</soap:Envelope>';
  proPublica   : Texto := '<?xml version="1.0" encoding="utf-8"?>' +
                          '<soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">' +
                           '<soap:Body>' +
                            '<ConsultaSituacaoLoteRPS xmlns="' + URLNS1 + '">' +
                             '<XML>' +
                               '&lt;?xml version="1.0" encoding="utf-8"?&gt;' +
                               StringReplace(StringReplace({'<nfseCabecMsg>' + FCabMsg + '</nfseCabecMsg>' +
                                                           '<nfseDadosMsg>' +} FDadosMsg {+ '</nfseDadosMsg>'},
                                                           '<', '&lt;', [rfReplaceAll]), '>', '&gt;', [rfReplaceAll]) +
                             '</XML>' +
                            '</ConsultaSituacaoLoteRPS>' +
                           '</soap:Body>' +
                          '</soap:Envelope>';
  else Texto := '';
 end;

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

   case StrToProvedor(Ok, FURLProvedor) of
    proRJ        : ReqResp.SoapAction := 'http://notacarioca.rio.gov.br/ConsultarSituacaoLoteRps';
    proTiplan    : ReqResp.SoapAction := 'http://www.nfe.com.br/ConsultarSituacaoLoteRps';
    proISSNET    : ReqResp.SoapAction := 'http://www.issnetonline.com.br/webservice/nfd/ConsultaSituacaoLoteRPS';
    proWebISS    : ReqResp.SoapAction := 'http://tempuri.org/INfseServices/ConsultarSituacaoLoteRps';
    proGINFES    : ReqResp.SoapAction := '';
    proDSF       : ReqResp.SoapAction := '';
    proProdemge  : ReqResp.SoapAction := 'http://ws.bhiss.pbh.gov.br/ConsultarSituacaoLoteRps';
    proAbaco     : ReqResp.SoapAction := '';
    proBetha     : ReqResp.SoapAction := '';
    proEquiplano : ReqResp.SoapAction := '';
    proISSIntel  : ReqResp.SoapAction := '';
    proProdam    : ReqResp.SoapAction := '';
    proGovBR     : ReqResp.SoapAction := 'http://tempuri.org/INFSEConsultas/ConsultarSituacaoLoteRps';
    proRecife    : ReqResp.SoapAction := 'http://www.abrasf.org.br/ABRASF/arquivos/nfse.xsd/WSNacional/ConsultarSituacaoLoteRps';
    proSimplISS  : ReqResp.SoapAction := 'http://www.sistema.com.br/Sistema.Ws.Nfse/INfseService/ConsultarSituacaoLoteRps';
    proThema     : ReqResp.SoapAction := '';
    proPublica   : ReqResp.SoapAction := '';

    else ReqResp.SoapAction := '';
   end;
 {$ENDIF}

 try
  TACBrNFSe( FACBrNFSe ).SetStatus( stNFSeConsulta );

  if FConfiguracoes.Geral.Salvar
   then FConfiguracoes.Geral.Save(Protocolo + '-con-sit-c.xml', Texto, FConfiguracoes.Arquivos.GetPathGer);

  if FConfiguracoes.Geral.Salvar
   then FConfiguracoes.Geral.Save(Protocolo + '-con-sit.xml', FDadosMsg, FConfiguracoes.Arquivos.GetPathGer);

  {$IFDEF ACBrNFSeOpenSSL}
    HTTP.Document.LoadFromStream(Stream);
    ConfiguraHTTP(HTTP,'SOAPAction: "http://tempuri.org/INfseServices/ConsultarSituacaoLoteRps"');
    HTTP.HTTPMethod('POST', FURL);

    StrStream := TStringStream.Create('');
    StrStream.CopyFrom(HTTP.Document, 0);
    FRetWS := SeparaDados( ParseText(StrStream.DataString, True),'ConsultarSituacaoLoteRpsV3');
    StrStream.Free;
  {$ELSE}
    ReqResp.Execute(Acao.Text, Stream);
    StrStream := TStringStream.Create('');
    StrStream.CopyFrom(Stream, 0);
    FRetornoWS := TiraAcentos(ParseText(StrStream.DataString, True));

    case StrToProvedor(Ok, FURLProvedor) of
     proRJ        : FRetWS := SeparaDados( FRetornoWS, 'outputXML' );
     proTiplan    : FRetWS := SeparaDados( FRetornoWS, 'outputXML' );
     proISSNET    : begin
                     FRetWS := SeparaDados( FRetornoWS, 'ConsultaSituacaoLoteRPSResult' );
                     FRetWS := StringReplace(FRetWS, ' xmlns="http://www.issnetonline.com.br/webserviceabrasf/vsd/servico_consultar_situacao_lote_rps_resposta.xsd"', '', [rfReplaceAll]);
                     FRetWS := StringReplace(FRetWS, ' xmlns="http://www.issnetonline.com.br/webserviceabrasf/vsd/tipos_complexos.xsd"', '', [rfReplaceAll]);
                    end;
     proWebISS    : FRetWS := SeparaDados( FRetornoWS, 'ConsultarSituacaoLoteRpsResult' );
     proGINFES    : FRetWS := SeparaDados( FRetornoWS, 'return' );
     proDSF       : FRetWS := SeparaDados( FRetornoWS, '' );
     proProdemge  : FRetWS := SeparaDados( FRetornoWS, 'outputXML' );
     proAbaco     : FRetWS := SeparaDados( FRetornoWS, '' );
     proBetha     : FRetWS := SeparaDados( FRetornoWS, '' );
     proEquiplano : FRetWS := SeparaDados( FRetornoWS, '' );
     proISSIntel  : FRetWS := SeparaDados( FRetornoWS, '' );
     proProdam    : FRetWS := SeparaDados( FRetornoWS, '' );
     proGovBR     : FRetWS := SeparaDados( FRetornoWS, 'ConsultarSituacaoLoteRpsResult' );
     proRecife    : FRetWS := SeparaDados( FRetornoWS, 'ConsultarSituacaoLoteRpsResposta' );
     proSimplISS  : begin
                     FRetWS := SeparaDados( FRetornoWS, 'ConsultarSituacaoLoteRpsResult' );
                     FRetWS := StringReplace(FRetWS, ' xmlns="http://www.sistema.com.br/Nfse/arquivos/nfse_3.xsd"', '', [rfReplaceAll]);
                     FRetWS := '<ConsultarSituacaoLoteRpsResposta xmlns="http://www.sistema.com.br/Nfse/arquivos/nfse_3.xsd">' +
                                 FRetWS +
                               '</ConsultarSituacaoLoteRpsResposta>';
                    end;
     proThema     : FRetWS := SeparaDados( FRetornoWS, 'consultarSituacaoLoteRpsResponse' );
     proPublica   : FRetWS := SeparaDados( FRetornoWS, 'ConsultarSituacaoLoteRpsResponse' );

     else FRetWS := SeparaDados( FRetornoWS, 'outputXML' );
    end;

    StrStream.Free;
  {$ENDIF}

  if FConfiguracoes.Geral.Salvar
   then FConfiguracoes.Geral.Save(Protocolo + '-sit-c.xml', FRetornoWS, FConfiguracoes.Arquivos.GetPathGer);

  if FConfiguracoes.Geral.Salvar
   then FConfiguracoes.Geral.Save(Protocolo + '-sit.xml', FRetWS, FConfiguracoes.Arquivos.GetPathGer);

  NFSeRetorno                := TretSitLote.Create;
  NFSeRetorno.Prefixo2       := FConfiguracoes.WebServices.Prefixo2;
  NFSeRetorno.Prefixo3       := FConfiguracoes.WebServices.Prefixo3;
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
      FMsg := FMsg + NFSeRetorno.infSit.MsgRetorno.Items[i].Mensagem + ' / ';
      aMsg := aMsg + 'Código Erro : ' + NFSeRetorno.InfSit.MsgRetorno.Items[i].Codigo + LineBreak +
                     'Mensagem... : ' + NFSeRetorno.infSit.MsgRetorno.Items[i].Mensagem + LineBreak+
                     'Correção... : ' + NFSeRetorno.InfSit.MsgRetorno.Items[i].Correcao + LineBreak+
                     'Provedor... : ' + FURLProvedor + LineBreak;
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

  NFSeRetorno.Free;

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

  {
  if FNFSeRetorno.CStat = 104 then
   begin
    Result := Confirma(FNFeRetorno.ProtNFe);
    fChaveNfe  := FNFeRetorno.ProtNFe.Items[0].chNFe;
    fProtocolo := FNFeRetorno.ProtNFe.Items[0].nProt;
    fcStat     := FNFeRetorno.ProtNFe.Items[0].cStat;
   end;
  }
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
 NFSeRetorno : TretLote;
 aMsg        : String;
 Texto       : String;
 Acao        : TStringList;
 Stream      : TMemoryStream;
 StrStream   : TStringStream;
 Ok          : Boolean;

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

// TnfseProvedor = ( proTiplan, proISSNET, proWebISS, proGINFES, proDSF, proProdemge, proAbaco, proBetha, proEquiplano, proISSIntel, proProdam );
 case StrToProvedor(Ok, FURLProvedor) of
  proRJ        : Texto := '<?xml version="1.0" encoding="utf-8"?>' +
                          '<soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">' +
                           '<soap:Body>' +
                            '<ConsultarLoteRpsRequest xmlns="' + URLNS1 + '/">' +
                             '<inputXML>' +
                               StringReplace(StringReplace(FDadosMsg,
                                                           '<', '&lt;', [rfReplaceAll]), '>', '&gt;', [rfReplaceAll]) +
                             '</inputXML>' +
                            '</ConsultarLoteRpsRequest>' +
                           '</soap:Body>' +
                          '</soap:Envelope>';
  proTiplan    : Texto := '<?xml version="1.0" encoding="utf-8"?>' +
                          '<soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">' +
                           '<soap:Body>' +
                            '<ConsultarLoteRpsRequest xmlns="' + URLNS1 + '/">' +
                             '<inputXML>' +
                               StringReplace(StringReplace(FDadosMsg,
                                                           '<', '&lt;', [rfReplaceAll]), '>', '&gt;', [rfReplaceAll]) +
                             '</inputXML>' +
                            '</ConsultarLoteRpsRequest>' +
                           '</soap:Body>' +
                          '</soap:Envelope>';
  proISSNET    : Texto := '<?xml version="1.0" encoding="utf-8"?>' +
                          '<soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">' +
                           '<soap:Body>' +
                            '<ConsultarLoteRps xmlns="' + URLNS1 + '">' +
                             '<xml>' +
                               '&lt;?xml version="1.0" encoding="utf-8"?&gt;' +
                               StringReplace(StringReplace({'<nfseCabecMsg>' + FCabMsg + '</nfseCabecMsg>' +
                                                           '<nfseDadosMsg>' +} FDadosMsg {+ '</nfseDadosMsg>'},
                                                           '<', '&lt;', [rfReplaceAll]), '>', '&gt;', [rfReplaceAll]) +
                             '</xml>' +
                            '</ConsultarLoteRps>' +
                           '</soap:Body>' +
                          '</soap:Envelope>';
  proWebISS    : Texto := '<?xml version="1.0" encoding="utf-8"?>' +
                          '<s:Envelope xmlns:s="http://schemas.xmlsoap.org/soap/envelope/">' +
                           '<s:Body>' +
                            '<ConsultarLoteRps xmlns="' + URLNS1 + '/">' +
                             '<cabec>' +
                              '&lt;?xml version="1.0" encoding="utf-8"?&gt;' +
                               StringReplace(StringReplace(FCabMsg, '<', '&lt;', [rfReplaceAll]), '>', '&gt;', [rfReplaceAll]) +
                             '</cabec>' +
                             '<msg>' +
                              '&lt;?xml version="1.0" encoding="utf-8"?&gt;' +
                               StringReplace(StringReplace(FDadosMsg, '<', '&lt;', [rfReplaceAll]), '>', '&gt;', [rfReplaceAll]) +
                             '</msg>' +
                            '</ConsultarLoteRps>' +
                           '</s:Body>' +
                          '</s:Envelope>';
  proGINFES    : Texto := '<?xml version="1.0" encoding="utf-8"?>' +
                          '<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/">' +
                           '<soapenv:Body>' +
                            '<ns1:ConsultarLoteRpsV3 xmlns:ns1="' + URLNS1 + '">' +
                             '<arg0>' + FCabMsg + '</arg0>' +
                             '<arg1>' + FDadosMsg + '</arg1>' +
                            '</ns1:ConsultarLoteRpsV3>' +
                           '</soapenv:Body>' +
                          '</soapenv:Envelope>';
  proDSF       : Texto := '';
  proProdemge  : Texto := '<?xml version="1.0" encoding="utf-8"?>' +
                          '<soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">' +
                           '<soap:Body>' +
                            '<ns2:ConsultarLoteRpsRequest xmlns:ns2="' + URLNS1 + '">' +
                             '<nfseCabecMsg>' +
                              StringReplace(StringReplace(FCabMsg, '<', '&lt;', [rfReplaceAll]), '>', '&gt;', [rfReplaceAll]) +
                             '</nfseCabecMsg>' +
                             '<nfseDadosMsg>' +
                              StringReplace(StringReplace(FDadosMsg, '<', '&lt;', [rfReplaceAll]), '>', '&gt;', [rfReplaceAll]) +
                             '</nfseDadosMsg>' +
                            '</ns2:ConsultarLoteRpsRequest>' +
                           '</soap:Body>' +
                          '</soap:Envelope>';
  proAbaco     : Texto := '';
  proBetha     : Texto := '';
  proEquiplano : Texto := '';
  proISSIntel  : Texto := '';
  proProdam    : Texto := '';
  proGovBR     : Texto := '<?xml version="1.0" encoding="utf-8"?>' +
                          '<s:Envelope xmlns:s="http://schemas.xmlsoap.org/soap/envelope/" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">' +
                           '<s:Body>' +
                            '<ConsultarLoteRps xmlns="' + URLNS1 + '/">' +
                             '<xmlEnvio>' +
                              '&lt;?xml version="1.0" encoding="utf-8"?&gt;' +
                               StringReplace(StringReplace(FDadosMsg, '<', '&lt;', [rfReplaceAll]), '>', '&gt;', [rfReplaceAll]) +
                             '</xmlEnvio>' +
                            '</ConsultarLoteRps>' +
                           '</s:Body>' +
                          '</s:Envelope>';
  proRecife    : Texto := '<?xml version="1.0" encoding="utf-8"?>' +
                          '<soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">' +
                           '<soap:Body>' +
                            '<ConsultarLoteRpsEnvio xmlns="' + URLNS1 + '">' +
                             '<MensagemXML>' +
                               StringReplace(StringReplace(
                                             {'<nfseCabecMsg>' + FCabMsg + '</nfseCabecMsg>' + '<nfseDadosMsg>' +}
                                             FDadosMsg {+ '</nfseDadosMsg>'},
                                                           '<', '&lt;', [rfReplaceAll]), '>', '&gt;', [rfReplaceAll]) +
                             '</MensagemXML>' +
                            '</ConsultarLoteRpsEnvio>' +
                           '</soap:Body>' +
                          '</soap:Envelope>';
  proSimplISS  : Texto := '<?xml version="1.0" encoding="utf-8"?>' +
                          '<s:Envelope xmlns:s="http://schemas.xmlsoap.org/soap/envelope/"' +
                                     ' xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"' +
                                     ' xmlns:xsd="http://www.w3.org/2001/XMLSchema">' +
                           '<s:Body>' +
                            '<ConsultarLoteRps xmlns="' + URLNS1 + '">' +
//                             '<ConsultarLoteRpsEnvio>' +
                              FDadosMsg +
//                             '</ConsultarLoteRpsEnvio>' +
                             '<pParam>' +
                               FDadosSenha +
                             '</pParam>' +
                            '</ConsultarLoteRps>' +

                           '</s:Body>' +
                          '</s:Envelope>';
  else Texto := '';
 end;

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

   case StrToProvedor(Ok, FURLProvedor) of
    proRJ        : ReqResp.SoapAction := 'http://notacarioca.rio.gov.br/ConsultarLoteRps';
    proTiplan    : ReqResp.SoapAction := 'http://www.nfe.com.br/ConsultarLoteRps';
    proISSNET    : ReqResp.SoapAction := 'http://www.issnetonline.com.br/webservice/nfd/ConsultarLoteRps';
    proWebISS    : ReqResp.SoapAction := 'http://tempuri.org/INfseServices/ConsultarLoteRps';
    proGINFES    : ReqResp.SoapAction := '';
    proDSF       : ReqResp.SoapAction := '';
    proProdemge  : ReqResp.SoapAction := 'http://ws.bhiss.pbh.gov.br/ConsultarLoteRps';
    proAbaco     : ReqResp.SoapAction := '';
    proBetha     : ReqResp.SoapAction := '';
    proEquiplano : ReqResp.SoapAction := '';
    proISSIntel  : ReqResp.SoapAction := '';
    proProdam    : ReqResp.SoapAction := '';
    proGovBR     : ReqResp.SoapAction := 'http://tempuri.org/INFSEConsultas/ConsultarLoteRps';
    proRecife    : ReqResp.SoapAction := 'http://www.abrasf.org.br/ABRASF/arquivos/nfse.xsd/WSNacional/ConsultarLoteRps';
    proSimplISS  : ReqResp.SoapAction := 'http://www.sistema.com.br/Sistema.Ws.Nfse/INfseService/ConsultarLoteRps';

    else ReqResp.SoapAction := '';
   end;
 {$ENDIF}

 try
  TACBrNFSe( FACBrNFSe ).SetStatus( stNFSeConsulta );

  if FConfiguracoes.Geral.Salvar
   then FConfiguracoes.Geral.Save(Protocolo + '-con-lot-c.xml', Texto, FConfiguracoes.Arquivos.GetPathGer);

  if FConfiguracoes.Geral.Salvar
   then FConfiguracoes.Geral.Save(Protocolo + '-con-lot.xml', FDadosMsg, FConfiguracoes.Arquivos.GetPathGer);

  {$IFDEF ACBrNFSeOpenSSL}
    HTTP.Document.LoadFromStream(Stream);
    ConfiguraHTTP(HTTP,'SOAPAction: "http://tempuri.org/INfseServices/ConsultarLoteRps"');
    HTTP.HTTPMethod('POST', FURL);

    StrStream := TStringStream.Create('');
    StrStream.CopyFrom(HTTP.Document, 0);
    FRetWS := SeparaDados( ParseText(StrStream.DataString, True),'ConsultarLoteRpsV3');
    StrStream.Free;
  {$ELSE}
    ReqResp.Execute(Acao.Text, Stream);
    StrStream := TStringStream.Create('');
    StrStream.CopyFrom(Stream, 0);
    FRetornoWS := TiraAcentos(ParseText(StrStream.DataString, True));

    case StrToProvedor(Ok, FURLProvedor) of
     proRJ        : FRetWS := SeparaDados( FRetornoWS, 'outputXML' );
     proTiplan    : FRetWS := SeparaDados( FRetornoWS, 'outputXML' );
     proISSNET    : begin
                     FRetWS := SeparaDados( FRetornoWS, 'ConsultarLoteRpsResult' );
                     FRetWS := StringReplace(FRetWS, ' xmlns="http://www.issnetonline.com.br/webserviceabrasf/vsd/servico_consultar_lote_rps_resposta.xsd"', '', [rfReplaceAll]);
                     FRetWS := StringReplace(FRetWS, ' xmlns="http://www.issnetonline.com.br/webserviceabrasf/vsd/tipos_complexos.xsd"', '', [rfReplaceAll]);
                    end;
     proWebISS    : FRetWS := SeparaDados( FRetornoWS, 'ConsultarLoteRpsResult' );
     proGINFES    : FRetWS := SeparaDados( FRetornoWS, 'return' );
     proDSF       : FRetWS := SeparaDados( FRetornoWS, '' );
     proProdemge  : FRetWS := SeparaDados( FRetornoWS, 'outputXML' );
     proAbaco     : FRetWS := SeparaDados( FRetornoWS, '' );
     proBetha     : FRetWS := SeparaDados( FRetornoWS, '' );
     proEquiplano : FRetWS := SeparaDados( FRetornoWS, '' );
     proISSIntel  : FRetWS := SeparaDados( FRetornoWS, '' );
     proProdam    : FRetWS := SeparaDados( FRetornoWS, '' );
     proGovBR     : FRetWS := SeparaDados( FRetornoWS, 'ConsultarLoteRpsResult' );
     proRecife    : FRetWS := SeparaDados( FRetornoWS, 'ConsultarLoteRpsRpsResposta' );
     proSimplISS  : begin
                     FRetWS := SeparaDados( FRetornoWS, 'ConsultarLoteRpsResult' );
                     FRetWS := StringReplace(FRetWS, ' xmlns="http://www.sistema.com.br/Nfse/arquivos/nfse_3.xsd"', '', [rfReplaceAll]);
                     FRetWS := '<ConsultarLoteRpsResposta xmlns="http://www.sistema.com.br/Nfse/arquivos/nfse_3.xsd">' +
                                 FRetWS +
                               '</ConsultarLoteRpsResposta>';
                    end;

     else FRetWS := SeparaDados( FRetornoWS, 'outputXML' );
    end;

    StrStream.Free;
  {$ENDIF}

  if FConfiguracoes.Geral.Salvar
   then FConfiguracoes.Geral.Save(Protocolo + '-lista-nfse-c.xml', FRetornoWS, FConfiguracoes.Arquivos.GetPathGer);

  if FConfiguracoes.Geral.Salvar
   then FConfiguracoes.Geral.Save(Protocolo + '-lista-nfse.xml', FRetWS, FConfiguracoes.Arquivos.GetPathGer);

  NFSeRetorno                := TretLote.Create;
  NFSeRetorno.Prefixo2       := FConfiguracoes.WebServices.Prefixo2;
  NFSeRetorno.Prefixo3       := FConfiguracoes.WebServices.Prefixo3;
  if StrToProvedor(Ok, FURLProvedor) = proISSNET
   then NFSeRetorno.Prefixo4 := ''
   else NFSeRetorno.Prefixo4 := FConfiguracoes.WebServices.Prefixo4;
  NFSeRetorno.Leitor.Arquivo := FRetWS;
  NFSeRetorno.LerXml;

  Prefixo3 := FConfiguracoes.WebServices.Prefixo3;
  Prefixo4 := FConfiguracoes.WebServices.Prefixo4;

  FRetListaNfse := SeparaDados(FRetWS, Prefixo3 + 'ListaNfse');
  i := 0;
  while FRetListaNfse <> '' do
   begin
//    j := Pos('</' + Prefixo4 + 'Nfse>', FRetListaNfse);
    j := Pos('</' + Prefixo3 + 'CompNfse>', FRetListaNfse);
    p := Length(trim(Prefixo3));
    if j > 0
     then begin
      FNotasFiscais.Items[i].NFSe.CodigoVerificacao := NFSeRetorno.ListaNfse.CompNfse.Items[i].Nfse.CodigoVerificacao;
      FNotasFiscais.Items[i].NFSe.Numero            := NFSeRetorno.ListaNfse.CompNfse.Items[i].Nfse.Numero;
      FNotasFiscais.Items[i].NFSe.Competencia       := NFSeRetorno.ListaNfse.CompNfse.Items[i].Nfse.Competencia;
      FNotasFiscais.Items[i].NFSe.NfseSubstituida   := NFSeRetorno.ListaNfse.CompNfse.Items[i].Nfse.NfseSubstituida;

      FNotasFiscais.Items[i].NFSe.Servico.xItemListaServico := NFSeRetorno.ListaNfse.CompNfse.Items[i].Nfse.Servico.xItemListaServico;

      FNotasFiscais.Items[i].NFSe.PrestadorServico.RazaoSocial  := NFSeRetorno.ListaNfse.CompNfse.Items[i].Nfse.PrestadorServico.RazaoSocial;
      FNotasFiscais.Items[i].NFSe.PrestadorServico.NomeFantasia := NFSeRetorno.ListaNfse.CompNfse.Items[i].Nfse.PrestadorServico.NomeFantasia;

      FNotasFiscais.Items[i].NFSe.PrestadorServico.IdentificacaoPrestador.Cnpj               := NFSeRetorno.ListaNfse.CompNfse.Items[i].Nfse.PrestadorServico.IdentificacaoPrestador.Cnpj;
      FNotasFiscais.Items[i].NFSe.PrestadorServico.IdentificacaoPrestador.InscricaoMunicipal := NFSeRetorno.ListaNfse.CompNfse.Items[i].Nfse.PrestadorServico.IdentificacaoPrestador.InscricaoMunicipal;

      FNotasFiscais.Items[i].NFSe.PrestadorServico.Endereco.Endereco        := NFSeRetorno.ListaNfse.CompNfse.Items[i].Nfse.PrestadorServico.Endereco.Endereco;
      FNotasFiscais.Items[i].NFSe.PrestadorServico.Endereco.Numero          := NFSeRetorno.ListaNfse.CompNfse.Items[i].Nfse.PrestadorServico.Endereco.Numero;
      FNotasFiscais.Items[i].NFSe.PrestadorServico.Endereco.Complemento     := NFSeRetorno.ListaNfse.CompNfse.Items[i].Nfse.PrestadorServico.Endereco.Complemento;
      FNotasFiscais.Items[i].NFSe.PrestadorServico.Endereco.Bairro          := NFSeRetorno.ListaNfse.CompNfse.Items[i].Nfse.PrestadorServico.Endereco.Bairro;
      FNotasFiscais.Items[i].NFSe.PrestadorServico.Endereco.CodigoMunicipio := NFSeRetorno.ListaNfse.CompNfse.Items[i].Nfse.PrestadorServico.Endereco.CodigoMunicipio;
      FNotasFiscais.Items[i].NFSe.PrestadorServico.Endereco.UF              := NFSeRetorno.ListaNfse.CompNfse.Items[i].Nfse.PrestadorServico.Endereco.UF;
      FNotasFiscais.Items[i].NFSe.PrestadorServico.Endereco.CEP             := NFSeRetorno.ListaNfse.CompNfse.Items[i].Nfse.PrestadorServico.Endereco.CEP;
      FNotasFiscais.Items[i].NFSe.PrestadorServico.Endereco.xMunicipio      := NFSeRetorno.ListaNfse.CompNfse.Items[i].Nfse.PrestadorServico.Endereco.xMunicipio;

      FNotasFiscais.Items[i].NFSe.PrestadorServico.Contato.Telefone := NFSeRetorno.ListaNfse.CompNfse.Items[i].Nfse.PrestadorServico.Contato.Telefone;
      FNotasFiscais.Items[i].NFSe.PrestadorServico.Contato.Email    := NFSeRetorno.ListaNfse.CompNfse.Items[i].Nfse.PrestadorServico.Contato.Email;

      FNotasFiscais.Items[i].NFSe.Tomador.Endereco.xMunicipio :=NFSeRetorno.ListaNfse.CompNfse.Items[i].Nfse.Tomador.Endereco.xMunicipio;
      (*
      FRetNfse := Copy(FRetListaNfse, 1, j - 1);
      k :=  Pos('<' + Prefixo4 + 'Numero', FRetNfse);
      FRetNfse := Copy(FRetNfse, k, length(FRetNfse));

      case StrToProvedor(Ok, FURLProvedor) of
       proTiplan    : FRetNfse := '<?xml version="1.0" encoding="utf-8"?>' +
                                  '<' + Prefixo4 + 'Nfse xmlns="http://www.abrasf.org.br/ABRASF/arquivos/">' +
                                  '<' + Prefixo4 + 'InfNfse Id="NFSe' + NFSeRetorno.ListaNfse.CompNfse.Items[i].Nfse.Numero + '">' +
                                    FRetNfse +
                                  '</' + Prefixo4 + 'Nfse>';
       proISSNET    : FRetNfse := '<?xml version="1.0" encoding="utf-8"?>' +
                                  '<' + Prefixo4 + 'Nfse xmlns:tc="http://www.issnetonline.com.br/webserviceabrasf/vsd/tipos_complexos.xsd">' +
                                  '<' + Prefixo4 + 'InfNfse Id="NFSe' + NFSeRetorno.ListaNfse.CompNfse.Items[i].Nfse.Numero + '">' +
                                    FRetNfse +
                                  '</' + Prefixo4 + 'Nfse>';
       proWebISS    : FRetNfse := '<?xml version="1.0" encoding="utf-8"?>' +
                                  '<' + Prefixo4 + 'Nfse xmlns="http://www.abrasf.org.br/nfse">' +
                                  '<' + Prefixo4 + 'InfNfse Id="NFSe' + NFSeRetorno.ListaNfse.CompNfse.Items[i].Nfse.Numero + '">' +
                                    FRetNfse +
                                  '</' + Prefixo4 + 'Nfse>';
       proGINFES    : FRetNfse := '<?xml version="1.0" encoding="utf-8"?>' +
                                  '<' + Prefixo4 + 'Nfse xmlns:ns4="http://www.ginfes.com.br/tipos_v03.xsd">' +
                                  '<' + Prefixo4 + 'InfNfse Id="nfse' + NFSeRetorno.ListaNfse.CompNfse.Items[i].Nfse.Numero + '">' +
                                    FRetNfse +
                                  '</' + Prefixo4 + 'Nfse>';
       proDSF       : FRetNfse := '';
       proProdemge  : FRetNfse := '<?xml version="1.0" encoding="utf-8"?>' +
                                  '<' + Prefixo4 + 'Nfse xmlns="http://www.abrasf.org.br/nfse">' +
                                  '<' + Prefixo4 + 'InfNfse Id="NFSe' + NFSeRetorno.ListaNfse.CompNfse.Items[i].Nfse.Numero + '">' +
                                    FRetNfse +
                                  '</' + Prefixo4 + 'Nfse>';
       proAbaco     : FRetNfse := '';
       proBetha     : FRetNfse := '';
       proEquiplano : FRetNfse := '';
       proISSIntel  : FRetNfse := '';
       proProdam    : FRetNfse := '';
       proGovBR     : FRetNfse := '<?xml version="1.0" encoding="utf-8"?>' +
                                  '<' + Prefixo4 + 'Nfse xmlns="http://www.abrasf.org.br/ABRASF/arquivos/">' +
                                  '<' + Prefixo4 + 'InfNfse Id="NFSe' + NFSeRetorno.ListaNfse.CompNfse.Items[i].Nfse.Numero + '">' +
                                    FRetNfse +
                                  '</' + Prefixo4 + 'Nfse>';
       proRecife    : FRetNfse := '';

       else FRetNfse := '';
      end;
      *)

      FRetNfse := Copy(FRetListaNfse, 1, j - 1);
      k :=  Pos('<' + Prefixo4 + 'Nfse', FRetNfse);
      FRetNfse := Copy(FRetNfse, k, length(FRetNfse));

      case StrToProvedor(Ok, FURLProvedor) of
       proRJ        : FRetNfse := '<?xml version="1.0" encoding="utf-8"?>' +
                                  '<' + Prefixo3 + 'CompNfse xmlns="http://www.abrasf.org.br/ABRASF/arquivos/">' +
                                    FRetNfse +
                                  '</' + Prefixo3 + 'CompNfse>';
       proTiplan    : FRetNfse := '<?xml version="1.0" encoding="utf-8"?>' +
                                  '<' + Prefixo3 + 'CompNfse xmlns="http://www.abrasf.org.br/ABRASF/arquivos/">' +
                                    FRetNfse +
                                  '</' + Prefixo3 + 'CompNfse>';
       proISSNET    : FRetNfse := '<?xml version="1.0" encoding="utf-8"?>' +
                                  '<' + {Prefixo4 +} 'CompNfse xmlns:tc="http://www.issnetonline.com.br/webserviceabrasf/vsd/tipos_complexos.xsd">' +
                                    FRetNfse +
                                  '</' + {Prefixo4 +} 'CompNfse>';
       proWebISS    : FRetNfse := '<?xml version="1.0" encoding="utf-8"?>' +
                                  '<' + Prefixo3 + 'CompNfse xmlns="http://www.abrasf.org.br/nfse">' +
                                    FRetNfse +
                                  '</' + Prefixo3 + 'CompNfse>';
       proGINFES    : FRetNfse := '<?xml version="1.0" encoding="utf-8"?>' +
                                  '<' + {Prefixo3 +} 'CompNfse xmlns:ns4="http://www.ginfes.com.br/tipos_v03.xsd">' +
                                    FRetNfse +
                                  '</' + {Prefixo3 +} 'CompNfse>';
       proDSF       : FRetNfse := '';
       proProdemge  : FRetNfse := '<?xml version="1.0" encoding="utf-8"?>' +
                                  '<' + Prefixo3 + 'CompNfse xmlns="http://www.abrasf.org.br/nfse">' +
                                    FRetNfse +
                                  '</' + Prefixo3 + 'CompNfse>';
       proAbaco     : FRetNfse := '';
       proBetha     : FRetNfse := '';
       proEquiplano : FRetNfse := '';
       proISSIntel  : FRetNfse := '';
       proProdam    : FRetNfse := '';
       proGovBR     : FRetNfse := '<?xml version="1.0" encoding="utf-8"?>' +
                                  '<' + Prefixo3 + 'CompNfse xmlns="http://www.abrasf.org.br/ABRASF/arquivos/">' +
                                    FRetNfse +
                                  '</' + Prefixo3 + 'CompNfse>';
       proRecife    : FRetNfse := '';
       proSimplISS  : FRetNfse := '<?xml version="1.0" encoding="utf-8"?>' +
                                  '<' + Prefixo3 + 'CompNfse xmlns="http://www.sistema.com.br/Nfse/arquivos/nfse_3.xsd">' +
                                    FRetNfse +
                                  '</' + Prefixo3 + 'CompNfse>';

       else FRetNfse := '';
      end;

      if FConfiguracoes.Geral.Salvar
       then begin
        PathSalvar := FConfiguracoes.Arquivos.GetPathNFSe(0);
        FConfiguracoes.Geral.Save(NFSeRetorno.ListaNfse.CompNfse.Items[i].Nfse.Numero + '-nfse.xml', FRetNfse, PathSalvar);
        if FNotasFiscais.Count>0
         then FNotasFiscais.Items[i].NomeArq := PathWithDelim(PathSalvar) + NFSeRetorno.ListaNfse.CompNfse.Items[i].Nfse.Numero + '-nfse.xml';
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
      FMsg := FMsg + NFSeRetorno.ListaNfse.MsgRetorno.Items[i].Mensagem + ' / ';
      aMsg := aMsg + 'Código Erro : ' + NFSeRetorno.ListaNfse.MsgRetorno.Items[i].Codigo + LineBreak +
                     'Mensagem... : ' + NFSeRetorno.ListaNfse.MsgRetorno.Items[i].Mensagem + LineBreak+
                     'Correção... : ' + NFSeRetorno.ListaNfse.MsgRetorno.Items[i].Correcao + LineBreak+
                     'Provedor... : ' + FURLProvedor + LineBreak;
     end;

    if FConfiguracoes.WebServices.Visualizar
     then ShowMessage(aMsg);
   end;

  if Assigned(TACBrNFSe( FACBrNFSe ).OnGerarLog)
   then TACBrNFSe( FACBrNFSe ).OnGerarLog(aMsg);

  Result := (FMsg = '');

  NFSeRetorno.Free;

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
// NFSeRetorno : TretNfseRps;
 aMsg        : String;
 Texto       : String;
 Acao        : TStringList;
 Stream      : TMemoryStream;
 StrStream   : TStringStream;
 Ok          : Boolean;

 {$IFDEF ACBrNFSeOpenSSL}
   HTTP    : THTTPSend;
 {$ELSE}
   ReqResp : THTTPReqResp;
 {$ENDIF}

 Prefixo3     : String;
 Prefixo4     : String;
 FRetCompNfse : AnsiString;
 FRetNfse     : AnsiString;
 i, j, k, p   : Integer;
 PathSalvar   : String;
begin
 {Result :=} inherited Executar;

 // Incluido por Italo em 17/02/2012
 if Assigned(NFSeRetorno)
  then NFSeRetorno.Free;

// TnfseProvedor = ( proTiplan, proISSNET, proWebISS, proGINFES, proDSF, proProdemge, proAbaco, proBetha, proEquiplano, proISSIntel, proProdam );
 case StrToProvedor(Ok, FURLProvedor) of
  proRJ        : Texto := '<?xml version="1.0" encoding="utf-8"?>' +
                          '<soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">' +
                           '<soap:Body>' +
                            '<ConsultarNfsePorRpsRequest xmlns="' + URLNS1 + '/">' +
                             '<inputXML>' +
                               StringReplace(StringReplace(FDadosMsg,
                                                           '<', '&lt;', [rfReplaceAll]), '>', '&gt;', [rfReplaceAll]) +
                             '</inputXML>' +
                            '</ConsultarNfsePorRpsRequest>' +
                           '</soap:Body>' +
                          '</soap:Envelope>';
  proTiplan    : Texto := '<?xml version="1.0" encoding="utf-8"?>' +
                          '<soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">' +
                           '<soap:Body>' +
                            '<ConsultarNfsePorRpsRequest xmlns="' + URLNS1 + '/">' +
                             '<inputXML>' +
                               StringReplace(StringReplace(FDadosMsg,
                                                           '<', '&lt;', [rfReplaceAll]), '>', '&gt;', [rfReplaceAll]) +
                             '</inputXML>' +
                            '</ConsultarNfsePorRpsRequest>' +
                           '</soap:Body>' +
                          '</soap:Envelope>';
  proISSNET    : Texto := '<?xml version="1.0" encoding="utf-8"?>' +
                          '<soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">' +
                           '<soap:Body>' +
                            '<ConsultarNFSePorRPS xmlns="' + URLNS1 + '">' +
                             '<xml>' +
                               '&lt;?xml version="1.0" encoding="utf-8"?&gt;' +
                               StringReplace(StringReplace({'<nfseCabecMsg>' + FCabMsg + '</nfseCabecMsg>' +
                                                           '<nfseDadosMsg>' +} FDadosMsg {+ '</nfseDadosMsg>'},
                                                           '<', '&lt;', [rfReplaceAll]), '>', '&gt;', [rfReplaceAll]) +
                             '</xml>' +
                            '</ConsultarNFSePorRPS>' +
                           '</soap:Body>' +
                          '</soap:Envelope>';
  proWebISS    : Texto := '<?xml version="1.0" encoding="utf-8"?>' +
                          '<s:Envelope xmlns:s="http://schemas.xmlsoap.org/soap/envelope/">' +
                           '<s:Body>' +
                            '<ConsultarNfsePorRps xmlns="' + URLNS1 + '/">' +
                             '<cabec>' +
                              '&lt;?xml version="1.0" encoding="utf-8"?&gt;' +
                               StringReplace(StringReplace(FCabMsg, '<', '&lt;', [rfReplaceAll]), '>', '&gt;', [rfReplaceAll]) +
                             '</cabec>' +
                             '<msg>' +
                              '&lt;?xml version="1.0" encoding="utf-8"?&gt;' +
                               StringReplace(StringReplace(FDadosMsg, '<', '&lt;', [rfReplaceAll]), '>', '&gt;', [rfReplaceAll]) +
                             '</msg>' +
                            '</ConsultarNfsePorRps>' +
                           '</s:Body>' +
                          '</s:Envelope>';
  proGINFES    : Texto := '<?xml version="1.0" encoding="utf-8"?>' +
                          '<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/">' +
                           '<soapenv:Body>' +
                            '<ns1:ConsultarNfsePorRpsV3 xmlns:ns1="' + URLNS1 + '">' +
                             '<arg0>' + FCabMsg + '</arg0>' +
                             '<arg1>' + FDadosMsg + '</arg1>' +
                            '</ns1:ConsultarNfsePorRpsV3>' +
                           '</soapenv:Body>' +
                          '</soapenv:Envelope>';
  proDSF       : Texto := '';
  proProdemge  : Texto := '<?xml version="1.0" encoding="utf-8"?>' +
                          '<soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">' +
                           '<soap:Body>' +
                            '<ns2:ConsultarNfsePorRpsRequest xmlns:ns2="' + URLNS1 + '">' +
                             '<nfseCabecMsg>' +
                              StringReplace(StringReplace(FCabMsg, '<', '&lt;', [rfReplaceAll]), '>', '&gt;', [rfReplaceAll]) +
                             '</nfseCabecMsg>' +
                             '<nfseDadosMsg>' +
                              StringReplace(StringReplace(FDadosMsg, '<', '&lt;', [rfReplaceAll]), '>', '&gt;', [rfReplaceAll]) +
                             '</nfseDadosMsg>' +
                            '</ns2:ConsultarNfsePorRpsRequest>' +
                           '</soap:Body>' +
                          '</soap:Envelope>';
  proAbaco     : Texto := '';
  proBetha     : Texto := '';
  proEquiplano : Texto := '';
  proISSIntel  : Texto := '';
  proProdam    : Texto := '';
  proGovBR     : Texto := '<?xml version="1.0" encoding="utf-8"?>' +
                          '<s:Envelope xmlns:s="http://schemas.xmlsoap.org/soap/envelope/" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">' +
                           '<s:Body>' +
                            '<ConsultarNfsePorRps xmlns="' + URLNS1 + '/">' +
                             '<xmlEnvio>' +
                              '&lt;?xml version="1.0" encoding="utf-8"?&gt;' +
                               StringReplace(StringReplace(FDadosMsg, '<', '&lt;', [rfReplaceAll]), '>', '&gt;', [rfReplaceAll]) +
                             '</xmlEnvio>' +
                            '</ConsultarNfsePorRps>' +
                           '</s:Body>' +
                          '</s:Envelope>';
  proRecife    : Texto := '<?xml version="1.0" encoding="utf-8"?>' +
                          '<soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">' +
                           '<soap:Body>' +
                            '<ConsultarNfseRpsEnvio xmlns="' + URLNS1 + '">' +
                             '<MensagemXML>' +
                               StringReplace(StringReplace(
                                             {'<nfseCabecMsg>' + FCabMsg + '</nfseCabecMsg>' + '<nfseDadosMsg>' +}
                                             FDadosMsg {+ '</nfseDadosMsg>'},
                                                           '<', '&lt;', [rfReplaceAll]), '>', '&gt;', [rfReplaceAll]) +
                             '</MensagemXML>' +
                            '</ConsultarNfseRpsEnvio>' +
                           '</soap:Body>' +
                          '</soap:Envelope>';
  proSimplISS  : Texto := '<?xml version="1.0" encoding="utf-8"?>' +
                          '<s:Envelope xmlns:s="http://schemas.xmlsoap.org/soap/envelope/"' +
                                     ' xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"' +
                                     ' xmlns:xsd="http://www.w3.org/2001/XMLSchema">' +
                           '<s:Body>' +
                            '<ConsultarNfsePorRps xmlns="' + URLNS1 + '">' +
//                             '<ConsultarNFsePorRpsEnvio>' +
                              FDadosMsg +
//                             '</ConsultarNfsePorRpsEnvio>' +
                             '<pParam>' +
                               FDadosSenha +
                             '</pParam>' +
                            '</ConsultarNfsePorRps>' +
                           '</s:Body>' +
                          '</s:Envelope>';

  else Texto := '';
 end;

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

   case StrToProvedor(Ok, FURLProvedor) of
    proRJ        : ReqResp.SoapAction := 'http://notacarioca.rio.gov.br/ConsultarNfsePorRps';
    proTiplan    : ReqResp.SoapAction := 'http://www.nfe.com.br/ConsultarNfsePorRps';
    proISSNET    : ReqResp.SoapAction := 'http://www.issnetonline.com.br/webservice/nfd/ConsultarNFSePorRPS';
    proWebISS    : ReqResp.SoapAction := 'http://tempuri.org/INfseServices/ConsultarNfsePorRps';
    proGINFES    : ReqResp.SoapAction := '';
    proDSF       : ReqResp.SoapAction := '';
    proProdemge  : ReqResp.SoapAction := 'http://ws.bhiss.pbh.gov.br/ConsultarNfsePorRps';
    proAbaco     : ReqResp.SoapAction := '';
    proBetha     : ReqResp.SoapAction := '';
    proEquiplano : ReqResp.SoapAction := '';
    proISSIntel  : ReqResp.SoapAction := '';
    proProdam    : ReqResp.SoapAction := '';
    proGovBR     : ReqResp.SoapAction := 'http://tempuri.org/INFSEConsultas/ConsultarNfsePorRps';
    proRecife    : ReqResp.SoapAction := 'http://www.abrasf.org.br/ABRASF/arquivos/nfse.xsd/WSNacional/ConsultarNfsePorRps';
    proSimplISS  : ReqResp.SoapAction := 'http://www.sistema.com.br/Sistema.Ws.Nfse/INfseService/ConsultarNfsePorRps';

    else ReqResp.SoapAction := '';
   end;
 {$ENDIF}

 try
  TACBrNFSe( FACBrNFSe ).SetStatus( stNFSeConsulta );

  if FConfiguracoes.Geral.Salvar
   then FConfiguracoes.Geral.Save(Numero + Serie + '-con-nfse-rps-c.xml', Texto, FConfiguracoes.Arquivos.GetPathGer);

  if FConfiguracoes.Geral.Salvar
   then FConfiguracoes.Geral.Save(Numero + Serie + '-con-nfse-rps.xml', FDadosMsg, FConfiguracoes.Arquivos.GetPathGer);

  {$IFDEF ACBrNFSeOpenSSL}
    HTTP.Document.LoadFromStream(Stream);
    ConfiguraHTTP(HTTP,'SOAPAction: "http://tempuri.org/INfseServices/ConsultarNfsePorRps"');
    HTTP.HTTPMethod('POST', FURL);

    StrStream := TStringStream.Create('');
    StrStream.CopyFrom(HTTP.Document, 0);
    FRetWS := SeparaDados( ParseText(StrStream.DataString, True),'ConsultarNfsePorRpsV3');
    StrStream.Free;
  {$ELSE}
    ReqResp.Execute(Acao.Text, Stream);
    StrStream := TStringStream.Create('');
    StrStream.CopyFrom(Stream, 0);
    FRetornoWS := TiraAcentos(ParseText(StrStream.DataString, True));

    case StrToProvedor(Ok, FURLProvedor) of
     proRJ        : FRetWS := SeparaDados( FRetornoWS, 'outputXML' );
     proTiplan    : FRetWS := SeparaDados( FRetornoWS, 'outputXML' );
     proISSNET    : begin
                     FRetWS := SeparaDados( FRetornoWS, 'ConsultarNFSePorRPSResult' );
                     FRetWS := StringReplace(FRetWS, ' xmlns="http://www.issnetonline.com.br/webserviceabrasf/vsd/servico_consultar_nfse_rps_resposta.xsd"', '', [rfReplaceAll]);
                     FRetWS := StringReplace(FRetWS, ' xmlns="http://www.issnetonline.com.br/webserviceabrasf/vsd/tipos_complexos.xsd"', '', [rfReplaceAll]);
                    end;
     proWebISS    : FRetWS := SeparaDados( FRetornoWS, 'ConsultarNfsePorRpsResult' );
     proGINFES    : FRetWS := SeparaDados( FRetornoWS, 'return' );
     proDSF       : FRetWS := SeparaDados( FRetornoWS, '' );
     proProdemge  : FRetWS := SeparaDados( FRetornoWS, 'outputXML' );
     proAbaco     : FRetWS := SeparaDados( FRetornoWS, '' );
     proBetha     : FRetWS := SeparaDados( FRetornoWS, '' );
     proEquiplano : FRetWS := SeparaDados( FRetornoWS, '' );
     proISSIntel  : FRetWS := SeparaDados( FRetornoWS, '' );
     proProdam    : FRetWS := SeparaDados( FRetornoWS, '' );
     proGovBR     : FRetWS := SeparaDados( FRetornoWS, 'ConsultarNfsePorRpsResult' );
     proRecife    : begin
                     FRetWS := SeparaDados( FRetornoWS, 'ConsultarNfseRpsResposta>' );
                     FRetWS := FRetWS + '</ConsultarNfseRpsResposta>';
                    end;
     proSimplISS  : begin
                     FRetWS := SeparaDados( FRetornoWS, 'ConsultarNfsePorRpsResult' );
                     FRetWS := StringReplace(FRetWS, ' xmlns="http://www.sistema.com.br/Nfse/arquivos/nfse_3.xsd"', '', [rfReplaceAll]);
                     FRetWS := '<ConsultarNfseRpsResposta xmlns="http://www.sistema.com.br/Nfse/arquivos/nfse_3.xsd">' +
                                 FRetWS +
                               '</ConsultarNfseRpsResposta>';
                    end;

     else FRetWS := SeparaDados( FRetornoWS, 'outputXML' );
    end;

    StrStream.Free;
  {$ENDIF}

  if FConfiguracoes.Geral.Salvar
   then FConfiguracoes.Geral.Save(Numero + Serie + '-comp-nfse-c.xml', FRetornoWS, FConfiguracoes.Arquivos.GetPathGer);

  if FConfiguracoes.Geral.Salvar
   then FConfiguracoes.Geral.Save(Numero + Serie + '-comp-nfse.xml', FRetWS, FConfiguracoes.Arquivos.GetPathGer);

  NFSeRetorno                := TretNfseRps.Create;
  NFSeRetorno.Prefixo2       := FConfiguracoes.WebServices.Prefixo2;
  NFSeRetorno.Prefixo3       := FConfiguracoes.WebServices.Prefixo3;
  if StrToProvedor(Ok, FURLProvedor) = proISSNET
   then NFSeRetorno.Prefixo4 := ''
   else NFSeRetorno.Prefixo4 := FConfiguracoes.WebServices.Prefixo4;
  NFSeRetorno.Leitor.Arquivo := FRetWS;
  NFSeRetorno.LerXml;

  Prefixo3 := FConfiguracoes.WebServices.Prefixo3;
  Prefixo4 := FConfiguracoes.WebServices.Prefixo4;

  FRetCompNfse := SeparaDados(FRetWS, Prefixo3 + 'CompNfse');
  i := 0;
  while FRetCompNfse <> '' do
   begin
    j := Pos('</' + Prefixo3 + 'Nfse>', FRetCompNfse);
    p := Length(trim(Prefixo3));
    if j > 0
     then begin
      FRetNfse := FRetCompNfse;
      {
      FRetNfse := Copy(FRetCompNfse, 1, j - 1);
      k :=  Pos('<' + Prefixo4 + 'Nfse', FRetNfse);
      FRetNfse := Copy(FRetNfse, k, length(FRetNfse));
      }
      case StrToProvedor(Ok, FURLProvedor) of
       proRJ        : FRetNfse := '<?xml version="1.0" encoding="utf-8"?>' +
                                  '<' + Prefixo3 + 'CompNfse xmlns="http://www.abrasf.org.br/ABRASF/arquivos/">' +
                                    FRetNfse +
                                  '</' + Prefixo3 + 'CompNfse>';
       proTiplan    : FRetNfse := '<?xml version="1.0" encoding="utf-8"?>' +
                                  '<' + Prefixo3 + 'CompNfse xmlns="http://www.abrasf.org.br/ABRASF/arquivos/">' +
                                    FRetNfse +
                                  '</' + Prefixo3 + 'CompNfse>';
       proISSNET    : FRetNfse := '<?xml version="1.0" encoding="utf-8"?>' +
                                  '<' + {Prefixo3 +} 'CompNfse xmlns:tc="http://www.issnetonline.com.br/webserviceabrasf/vsd/tipos_complexos.xsd">' +
                                    FRetNfse +
                                  '</' + {Prefixo3 +} 'CompNfse>';
       proWebISS    : FRetNfse := '<?xml version="1.0" encoding="utf-8"?>' +
                                  '<' + Prefixo3 + 'CompNfse xmlns="http://www.abrasf.org.br/nfse">' +
                                    FRetNfse +
                                  '</' + Prefixo3 + 'CompNfse>';
       proGINFES    : FRetNfse := '<?xml version="1.0" encoding="utf-8"?>' +
                                  '<' + {Prefixo3 +} 'CompNfse xmlns:ns4="http://www.ginfes.com.br/tipos_v03.xsd">' +
                                    FRetNfse +
                                  '</' + {Prefixo3 +} 'CompNfse>';
       proDSF       : FRetNfse := '';
       proProdemge  : FRetNfse := '<?xml version="1.0" encoding="utf-8"?>' +
                                  '<' + Prefixo3 + 'CompNfse xmlns="http://www.abrasf.org.br/nfse">' +
                                    FRetNfse +
                                  '</' + Prefixo3 + 'CompNfse>';
       proAbaco     : FRetNfse := '';
       proBetha     : FRetNfse := '';
       proEquiplano : FRetNfse := '';
       proISSIntel  : FRetNfse := '';
       proProdam    : FRetNfse := '';
       proGovBR     : FRetNfse := '<?xml version="1.0" encoding="utf-8"?>' +
                                  '<' + Prefixo3 + 'CompNfse xmlns="http://www.abrasf.org.br/ABRASF/arquivos/">' +
                                    FRetNfse +
                                  '</' + Prefixo3 + 'CompNfse>';
       proRecife    : FRetNfse := '';
       proSimplISS  : FRetNfse := '<?xml version="1.0" encoding="utf-8"?>' +
                                  '<' + Prefixo3 + 'CompNfse xmlns="http://www.sistema.com.br/Nfse/arquivos/nfse_3.xsd">' +
                                    FRetNfse +
                                  '</' + Prefixo3 + 'CompNfse>';

       else FRetNfse := '';
      end;

      if FConfiguracoes.Geral.Salvar
       then begin
        PathSalvar := FConfiguracoes.Arquivos.GetPathNFSe(0);
        FConfiguracoes.Geral.Save(NFSeRetorno.ListaNfse.CompNfse.Items[i].Nfse.Numero + '-nfse.xml', FRetNfse, PathSalvar);
        if FNotasFiscais.Count>0
         then FNotasFiscais.Items[i].NomeArq := PathWithDelim(PathSalvar) + NFSeRetorno.ListaNfse.CompNfse.Items[i].Nfse.Numero + '-nfse.xml';
       end;

//      FRetCompNfse := Copy(FRetCompNfse, j + 11 + p, length(FRetCompNfse));
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
      FMsg := FMsg + NFSeRetorno.ListaNfse.MsgRetorno.Items[i].Mensagem + ' / ';
      aMsg := aMsg + 'Código Erro : ' + NFSeRetorno.ListaNfse.MsgRetorno.Items[i].Codigo + LineBreak +
                     'Mensagem... : ' + NFSeRetorno.ListaNfse.MsgRetorno.Items[i].Mensagem + LineBreak+
                     'Correção... : ' + NFSeRetorno.ListaNfse.MsgRetorno.Items[i].Correcao + LineBreak+
                     'Provedor... : ' + FURLProvedor + LineBreak;
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

{ TNFSeConsultarNfse }

constructor TNFSeConsultarNfse.Create(AOwner: TComponent;
  ANotasFiscais: TNotasFiscais);
begin
 inherited Create(AOwner);
  FNotasFiscais := ANotasFiscais;
end;

function TNFSeConsultarNfse.Executar: Boolean;
var
 NFSeRetorno : TretNfse;
 aMsg        : String;
 Texto       : String;
 Acao        : TStringList;
 Stream      : TMemoryStream;
 StrStream   : TStringStream;
 Ok          : Boolean;

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

// TnfseProvedor = ( proTiplan, proISSNET, proWebISS, proGINFES, proDSF, proProdemge, proAbaco, proBetha, proEquiplano, proISSIntel, proProdam );
 case StrToProvedor(Ok, FURLProvedor) of
  proRJ        : Texto := '<?xml version="1.0" encoding="utf-8"?>' +
                          '<soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">' +
                           '<soap:Body>' +
                            '<ConsultarNfseRequest xmlns="' + URLNS1 + '/">' +
                             '<inputXML>' +
                               StringReplace(StringReplace(FDadosMsg,
                                                           '<', '&lt;', [rfReplaceAll]), '>', '&gt;', [rfReplaceAll]) +
                             '</inputXML>' +
                            '</ConsultarNfseRequest>' +
                           '</soap:Body>' +
                          '</soap:Envelope>';
  proTiplan    : Texto := '<?xml version="1.0" encoding="utf-8"?>' +
                          '<soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">' +
                           '<soap:Body>' +
                            '<ConsultarNfseRequest xmlns="' + URLNS1 + '/">' +
                             '<inputXML>' +
                               StringReplace(StringReplace(FDadosMsg,
                                                           '<', '&lt;', [rfReplaceAll]), '>', '&gt;', [rfReplaceAll]) +
                             '</inputXML>' +
                            '</ConsultarNfseRequest>' +
                           '</soap:Body>' +
                          '</soap:Envelope>';
  proISSNET    : Texto := '<?xml version="1.0" encoding="utf-8"?>' +
                          '<soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">' +
                           '<soap:Body>' +
                            '<ConsultarNfse xmlns="' + URLNS1 + '">' +
                             '<xml>' +
                               '&lt;?xml version="1.0" encoding="utf-8"?&gt;' +
                               StringReplace(StringReplace({'<nfseCabecMsg>' + FCabMsg + '</nfseCabecMsg>' +
                                                           '<nfseDadosMsg>' +} FDadosMsg {+ '</nfseDadosMsg>'},
                                                           '<', '&lt;', [rfReplaceAll]), '>', '&gt;', [rfReplaceAll]) +
                             '</xml>' +
                            '</ConsultarNfse>' +
                           '</soap:Body>' +
                          '</soap:Envelope>';
  proWebISS    : Texto := '<?xml version="1.0" encoding="utf-8"?>' +
                          '<s:Envelope xmlns:s="http://schemas.xmlsoap.org/soap/envelope/">' +
                           '<s:Body>' +
                            '<ConsultarNfse xmlns="' + URLNS1 + '/">' +
                             '<cabec>' +
                              '&lt;?xml version="1.0" encoding="utf-8"?&gt;' +
                               StringReplace(StringReplace(FCabMsg, '<', '&lt;', [rfReplaceAll]), '>', '&gt;', [rfReplaceAll]) +
                             '</cabec>' +
                             '<msg>' +
                              '&lt;?xml version="1.0" encoding="utf-8"?&gt;' +
                               StringReplace(StringReplace(FDadosMsg, '<', '&lt;', [rfReplaceAll]), '>', '&gt;', [rfReplaceAll]) +
                             '</msg>' +
                            '</ConsultarNfse>' +
                           '</s:Body>' +
                          '</s:Envelope>';
  proGINFES    : Texto := '<?xml version="1.0" encoding="utf-8"?>' +
                          '<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/">' +
                           '<soapenv:Body>' +
                            '<ns1:ConsultarNfseV3 xmlns:ns1="' + URLNS1 + '">' +
                             '<arg0>' + FCabMsg + '</arg0>' +
                             '<arg1>' + FDadosMsg + '</arg1>' +
                            '</ns1:ConsultarNfseV3>' +
                           '</soapenv:Body>' +
                          '</soapenv:Envelope>';
  proDSF       : Texto := '';
  proProdemge  : Texto := '<?xml version="1.0" encoding="utf-8"?>' +
                          '<soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">' +
                           '<soap:Body>' +
                            '<ns2:ConsultarNfseRequest xmlns:ns2="' + URLNS1 + '">' +
                             '<nfseCabecMsg>' +
                              StringReplace(StringReplace(FCabMsg, '<', '&lt;', [rfReplaceAll]), '>', '&gt;', [rfReplaceAll]) +
                             '</nfseCabecMsg>' +
                             '<nfseDadosMsg>' +
                              StringReplace(StringReplace(FDadosMsg, '<', '&lt;', [rfReplaceAll]), '>', '&gt;', [rfReplaceAll]) +
                             '</nfseDadosMsg>' +
                            '</ns2:ConsultarNfseRequest>' +
                           '</soap:Body>' +
                          '</soap:Envelope>';
  proAbaco     : Texto := '';
  proBetha     : Texto := '';
  proEquiplano : Texto := '';
  proISSIntel  : Texto := '';
  proProdam    : Texto := '';
  proGovBR     : Texto := '<?xml version="1.0" encoding="utf-8"?>' +
                          '<s:Envelope xmlns:s="http://schemas.xmlsoap.org/soap/envelope/" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">' +
                           '<s:Body>' +
                            '<ConsultarNfse xmlns="' + URLNS1 + '/">' +
                             '<xmlEnvio>' +
                              '&lt;?xml version="1.0" encoding="utf-8"?&gt;' +
                               StringReplace(StringReplace(FDadosMsg, '<', '&lt;', [rfReplaceAll]), '>', '&gt;', [rfReplaceAll]) +
                             '</xmlEnvio>' +
                            '</ConsultarNfse>' +
                           '</s:Body>' +
                          '</s:Envelope>';
  proRecife    : Texto := '<?xml version="1.0" encoding="utf-8"?>' +
                          '<soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">' +
                           '<soap:Body>' +
                            '<ConsultarNfseEnvio xmlns="' + URLNS1 + '">' +
                             '<MensagemXML>' +
                               StringReplace(StringReplace(
                                             {'<nfseCabecMsg>' + FCabMsg + '</nfseCabecMsg>' + '<nfseDadosMsg>' +}
                                             FDadosMsg {+ '</nfseDadosMsg>'},
                                                           '<', '&lt;', [rfReplaceAll]), '>', '&gt;', [rfReplaceAll]) +
                             '</MensagemXML>' +
                            '</ConsultarNfseEnvio>' +
                           '</soap:Body>' +
                          '</soap:Envelope>';
  proSimplISS  : Texto := '<?xml version="1.0" encoding="utf-8"?>' +
                          '<s:Envelope xmlns:s="http://schemas.xmlsoap.org/soap/envelope/"' +
                                     ' xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"' +
                                     ' xmlns:xsd="http://www.w3.org/2001/XMLSchema">' +
                           '<s:Body>' +
                            '<ConsultarNfse xmlns="' + URLNS1 + '">' +
//                             '<ConsultarNfseEnvio>' +
                              FDadosMsg +
//                             '</ConsultarNfseEnvio>' +
                             '<pParam>' +
                               FDadosSenha +
                             '</pParam>' +
                            '</ConsultarNfse>' +
                           '</s:Body>' +
                          '</s:Envelope>';

  else Texto := '';
 end;

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

   case StrToProvedor(Ok, FURLProvedor) of
    proRJ        : ReqResp.SoapAction := 'http://notacarioca.rio.gov.br/ConsultarNfse';
    proTiplan    : ReqResp.SoapAction := 'http://www.nfe.com.br/ConsultarNfse';
    proISSNET    : ReqResp.SoapAction := 'http://www.issnetonline.com.br/webservice/nfd/ConsultarNfse';
    proWebISS    : ReqResp.SoapAction := 'http://tempuri.org/INfseServices/ConsultarNfse';
    proGINFES    : ReqResp.SoapAction := '';
    proDSF       : ReqResp.SoapAction := '';
    proProdemge  : ReqResp.SoapAction := 'http://ws.bhiss.pbh.gov.br/ConsultarNfse';
    proAbaco     : ReqResp.SoapAction := '';
    proBetha     : ReqResp.SoapAction := '';
    proEquiplano : ReqResp.SoapAction := '';
    proISSIntel  : ReqResp.SoapAction := '';
    proProdam    : ReqResp.SoapAction := '';
    proGovBR     : ReqResp.SoapAction := 'http://tempuri.org/INFSEConsultas/ConsultarNfse';
    proRecife    : ReqResp.SoapAction := 'http://www.abrasf.org.br/ABRASF/arquivos/nfse.xsd/WSNacional/ConsultarNfse';
    proSimplISS  : ReqResp.SoapAction := 'http://www.sistema.com.br/Sistema.Ws.Nfse/INfseService/ConsultarNfse';

    else ReqResp.SoapAction := '';
   end;
 {$ENDIF}

 try
  TACBrNFSe( FACBrNFSe ).SetStatus( stNFSeConsulta );

  if FConfiguracoes.Geral.Salvar
   then FConfiguracoes.Geral.Save(FormatDateTime('yyyymmdd', DataInicial) +
                                  FormatDateTime('yyyymmdd', DataFinal) + '-con-nfse-c.xml', Texto, FConfiguracoes.Arquivos.GetPathGer);

  if FConfiguracoes.Geral.Salvar
   then FConfiguracoes.Geral.Save(FormatDateTime('yyyymmdd', DataInicial) +
                                  FormatDateTime('yyyymmdd', DataFinal) + '-con-nfse.xml', FDadosMsg, FConfiguracoes.Arquivos.GetPathGer);

  {$IFDEF ACBrNFSeOpenSSL}
    HTTP.Document.LoadFromStream(Stream);
    ConfiguraHTTP(HTTP,'SOAPAction: "http://tempuri.org/INfseServices/ConsultarNfse"');
    HTTP.HTTPMethod('POST', FURL);

    StrStream := TStringStream.Create('');
    StrStream.CopyFrom(HTTP.Document, 0);
    FRetWS := SeparaDados( ParseText(StrStream.DataString, True),'ConsultarNfseV3');
    StrStream.Free;
  {$ELSE}
    ReqResp.Execute(Acao.Text, Stream);
    StrStream := TStringStream.Create('');
    StrStream.CopyFrom(Stream, 0);
    FRetornoWS := TiraAcentos(ParseText(StrStream.DataString, True));

    case StrToProvedor(Ok, FURLProvedor) of
     proRJ        : FRetWS := SeparaDados( FRetornoWS, 'outputXML' );
     proTiplan    : FRetWS := SeparaDados( FRetornoWS, 'outputXML' );
     proISSNET    : begin
                     FRetWS := SeparaDados( FRetornoWS, 'ConsultarNfseResult' );
                     FRetWS := StringReplace(FRetWS, ' xmlns="http://www.issnetonline.com.br/webserviceabrasf/vsd/servico_consultar_nfse_resposta.xsd"', '', [rfReplaceAll]);
                     FRetWS := StringReplace(FRetWS, ' xmlns="http://www.issnetonline.com.br/webserviceabrasf/vsd/tipos_complexos.xsd"', '', [rfReplaceAll]);
                    end;
     proWebISS    : FRetWS := SeparaDados( FRetornoWS, 'ConsultarNfseResult' );
     proGINFES    : FRetWS := SeparaDados( FRetornoWS, 'return' );
     proDSF       : FRetWS := SeparaDados( FRetornoWS, '' );
     proProdemge  : FRetWS := SeparaDados( FRetornoWS, 'outputXML' );
     proAbaco     : FRetWS := SeparaDados( FRetornoWS, '' );
     proBetha     : FRetWS := SeparaDados( FRetornoWS, '' );
     proEquiplano : FRetWS := SeparaDados( FRetornoWS, '' );
     proISSIntel  : FRetWS := SeparaDados( FRetornoWS, '' );
     proProdam    : FRetWS := SeparaDados( FRetornoWS, '' );
     proGovBR     : FRetWS := SeparaDados( FRetornoWS, 'ConsultarNfseResult' );
     proRecife    : begin
                     FRetWS := SeparaDados( FRetornoWS, 'ConsultarNfseResposta>' );
                     FRetWS := FRetWS + '</ConsultarNfseResposta>';
                    end;
     proSimplISS  : begin
                     FRetWS := SeparaDados( FRetornoWS, 'ConsultarNfseResult' );
                     FRetWS := StringReplace(FRetWS, ' xmlns="http://www.sistema.com.br/Nfse/arquivos/nfse_3.xsd"', '', [rfReplaceAll]);
                     FRetWS := '<ConsultarNfseResposta xmlns="http://www.sistema.com.br/Nfse/arquivos/nfse_3.xsd">' +
                                 FRetWS +
                               '</ConsultarNfseResposta>';
                    end;

     else FRetWS := SeparaDados( FRetornoWS, 'outputXML' );
    end;

    StrStream.Free;
  {$ENDIF}

  if FConfiguracoes.Geral.Salvar
   then FConfiguracoes.Geral.Save(FormatDateTime('yyyymmdd', DataInicial) +
                                  FormatDateTime('yyyymmdd', DataFinal) + '-lista-nfse-c.xml', FRetornoWS, FConfiguracoes.Arquivos.GetPathGer);

  if FConfiguracoes.Geral.Salvar
   then FConfiguracoes.Geral.Save(FormatDateTime('yyyymmdd', DataInicial) +
                                  FormatDateTime('yyyymmdd', DataFinal) + '-lista-nfse.xml', FRetWS, FConfiguracoes.Arquivos.GetPathGer);

  NFSeRetorno                := TretNfse.Create;
  NFSeRetorno.Prefixo2       := FConfiguracoes.WebServices.Prefixo2;
  NFSeRetorno.Prefixo3       := FConfiguracoes.WebServices.Prefixo3;
  if StrToProvedor(Ok, FURLProvedor) = proISSNET
   then NFSeRetorno.Prefixo4 := ''
   else NFSeRetorno.Prefixo4 := FConfiguracoes.WebServices.Prefixo4;
  NFSeRetorno.Leitor.Arquivo := FRetWS;
  NFSeRetorno.LerXml;

  Prefixo3 := FConfiguracoes.WebServices.Prefixo3;
  Prefixo4 := FConfiguracoes.WebServices.Prefixo4;

  FRetListaNfse := SeparaDados(FRetWS, Prefixo3 + 'ListaNfse');
  i := 0;
  while FRetListaNfse <> '' do
   begin
    (*
    j := Pos('</' + Prefixo4 + 'Nfse>', FRetListaNfse);
    if j > 0
     then begin
      FRetNfse := Copy(FRetListaNfse, 1, j - 1);
      k :=  Pos('<' + Prefixo4 + 'Numero', FRetNfse);
      FRetNfse := Copy(FRetNfse, k, length(FRetNfse));

      case StrToProvedor(Ok, FURLProvedor) of
       proTiplan    : FRetNfse := '<?xml version="1.0" encoding="utf-8"?>' +
                                  '<' + Prefixo4 + 'Nfse xmlns="http://www.abrasf.org.br/ABRASF/arquivos/">' +
                                  '<' + Prefixo4 + 'InfNfse Id="NFSe' + NFSeRetorno.ListaNfse.CompNfse.Items[i].Nfse.Numero + '">' +
                                    FRetNfse +
                                  '</' + Prefixo4 + 'Nfse>';
       proISSNET    : FRetNfse := '<?xml version="1.0" encoding="utf-8"?>' +
                                  '<' + Prefixo4 + 'Nfse xmlns:tc="http://www.issnetonline.com.br/webserviceabrasf/vsd/tipos_complexos.xsd">' +
                                  '<' + Prefixo4 + 'InfNfse Id="NFSe' + NFSeRetorno.ListaNfse.CompNfse.Items[i].Nfse.Numero + '">' +
                                    FRetNfse +
                                  '</' + Prefixo4 + 'Nfse>';
       proWebISS    : FRetNfse := '<?xml version="1.0" encoding="utf-8"?>' +
                                  '<' + Prefixo4 + 'Nfse xmlns="http://www.abrasf.org.br/nfse">' +
                                  '<' + Prefixo4 + 'InfNfse Id="NFSe' + NFSeRetorno.ListaNfse.CompNfse.Items[i].Nfse.Numero + '">' +
                                    FRetNfse +
                                  '</' + Prefixo4 + 'Nfse>';
       proGINFES    : FRetNfse := '<?xml version="1.0" encoding="utf-8"?>' +
                                  '<' + Prefixo4 + 'Nfse xmlns:ns4="http://www.ginfes.com.br/tipos_v03.xsd">' +
                                  '<' + Prefixo4 + 'InfNfse Id="nfse' + NFSeRetorno.ListaNfse.CompNfse.Items[i].Nfse.Numero + '">' +
                                    FRetNfse +
                                  '</' + Prefixo4 + 'Nfse>';
       proDSF       : FRetNfse := '';
       proProdemge  : FRetNfse := '<?xml version="1.0" encoding="utf-8"?>' +
                                  '<' + Prefixo4 + 'Nfse xmlns="http://www.abrasf.org.br/nfse">' +
                                  '<' + Prefixo4 + 'InfNfse Id="NFSe' + NFSeRetorno.ListaNfse.CompNfse.Items[i].Nfse.Numero + '">' +
                                    FRetNfse +
                                  '</' + Prefixo4 + 'Nfse>';
       proAbaco     : FRetNfse := '';
       proBetha     : FRetNfse := '';
       proEquiplano : FRetNfse := '';
       proISSIntel  : FRetNfse := '';
       proProdam    : FRetNfse := '';
       proGovBR     : FRetNfse := '<?xml version="1.0" encoding="utf-8"?>' +
                                  '<' + Prefixo4 + 'Nfse xmlns="http://www.abrasf.org.br/ABRASF/arquivos/">' +
                                  '<' + Prefixo4 + 'InfNfse Id="NFSe' + NFSeRetorno.ListaNfse.CompNfse.Items[i].Nfse.Numero + '">' +
                                    FRetNfse +
                                  '</' + Prefixo4 + 'Nfse>';
       proRecife    : FRetNfse := '';

       else FRetNfse := '';
      end;

      if FConfiguracoes.Geral.Salvar
       then begin
        PathSalvar := FConfiguracoes.Arquivos.GetPathNFSe(0);
        FConfiguracoes.Geral.Save(NFSeRetorno.ListaNfse.CompNfse.Items[i].Nfse.Numero + '-nfse.xml', FRetNfse, PathSalvar);
        if FNotasFiscais.Count>0
         then FNotasFiscais.Items[i].NomeArq := PathWithDelim(PathSalvar) + NFSeRetorno.ListaNfse.CompNfse.Items[i].Nfse.Numero + '-nfse.xml';
       end;

      FRetListaNfse := Copy(FRetListaNfse, j + 11, length(FRetListaNfse));
      inc(i);
     end
     else FRetListaNfse:='';
    *)
    j := Pos('</' + Prefixo3 + 'CompNfse>', FRetListaNfse);
    p := Length(trim(Prefixo3));
    if j > 0
     then begin
      FRetNfse := Copy(FRetListaNfse, 1, j - 1);
      k :=  Pos('<' + Prefixo4 + 'Nfse', FRetNfse);
      FRetNfse := Copy(FRetNfse, k, length(FRetNfse));

      case StrToProvedor(Ok, FURLProvedor) of
       proRJ        : FRetNfse := '<?xml version="1.0" encoding="utf-8"?>' +
                                  '<' + Prefixo3 + 'CompNfse xmlns="http://www.abrasf.org.br/ABRASF/arquivos/">' +
                                    FRetNfse +
                                  '</' + Prefixo3 + 'CompNfse>';
       proTiplan    : FRetNfse := '<?xml version="1.0" encoding="utf-8"?>' +
                                  '<' + Prefixo3 + 'CompNfse xmlns="http://www.abrasf.org.br/ABRASF/arquivos/">' +
                                    FRetNfse +
                                  '</' + Prefixo3 + 'CompNfse>';
       proISSNET    : FRetNfse := '<?xml version="1.0" encoding="utf-8"?>' +
                                  '<' + {Prefixo3 +} 'CompNfse xmlns:tc="http://www.issnetonline.com.br/webserviceabrasf/vsd/tipos_complexos.xsd">' +
                                    FRetNfse +
                                  '</' + {Prefixo3 +} 'CompNfse>';
       proWebISS    : FRetNfse := '<?xml version="1.0" encoding="utf-8"?>' +
                                  '<' + Prefixo3 + 'CompNfse xmlns="http://www.abrasf.org.br/nfse">' +
                                    FRetNfse +
                                  '</' + Prefixo3 + 'CompNfse>';
       proGINFES    : FRetNfse := '<?xml version="1.0" encoding="utf-8"?>' +
                                  '<' + {Prefixo3 +} 'CompNfse xmlns:ns4="http://www.ginfes.com.br/tipos_v03.xsd">' +
                                    FRetNfse +
                                  '</' + {Prefixo3 +} 'CompNfse>';
       proDSF       : FRetNfse := '';
       proProdemge  : FRetNfse := '<?xml version="1.0" encoding="utf-8"?>' +
                                  '<' + Prefixo3 + 'CompNfse xmlns="http://www.abrasf.org.br/nfse">' +
                                    FRetNfse +
                                  '</' + Prefixo3 + 'CompNfse>';
       proAbaco     : FRetNfse := '';
       proBetha     : FRetNfse := '';
       proEquiplano : FRetNfse := '';
       proISSIntel  : FRetNfse := '';
       proProdam    : FRetNfse := '';
       proGovBR     : FRetNfse := '<?xml version="1.0" encoding="utf-8"?>' +
                                  '<' + Prefixo3 + 'CompNfse xmlns="http://www.abrasf.org.br/ABRASF/arquivos/">' +
                                    FRetNfse +
                                  '</' + Prefixo3 + 'CompNfse>';
       proRecife    : FRetNfse := '';
       proSimplISS  : FRetNfse := '<?xml version="1.0" encoding="utf-8"?>' +
                                  '<' + Prefixo3 + 'CompNfse xmlns="http://www.sistema.com.br/Nfse/arquivos/nfse_3.xsd">' +
                                    FRetNfse +
                                  '</' + Prefixo3 + 'CompNfse>';

       else FRetNfse := '';
      end;

      if FConfiguracoes.Geral.Salvar
       then begin
        PathSalvar := FConfiguracoes.Arquivos.GetPathNFSe(0);
        FConfiguracoes.Geral.Save(NFSeRetorno.ListaNfse.CompNfse.Items[i].Nfse.Numero + '-nfse.xml', FRetNfse, PathSalvar);
        if FNotasFiscais.Count>0
         then FNotasFiscais.Items[i].NomeArq := PathWithDelim(PathSalvar) + NFSeRetorno.ListaNfse.CompNfse.Items[i].Nfse.Numero + '-nfse.xml';
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
      FMsg := FMsg + NFSeRetorno.ListaNfse.MsgRetorno.Items[i].Mensagem + ' / ';
      aMsg := aMsg + 'Código Erro : ' + NFSeRetorno.ListaNfse.MsgRetorno.Items[i].Codigo + LineBreak +
                     'Mensagem... : ' + NFSeRetorno.ListaNfse.MsgRetorno.Items[i].Mensagem + LineBreak+
                     'Correção... : ' + NFSeRetorno.ListaNfse.MsgRetorno.Items[i].Correcao + LineBreak+
                     'Provedor... : ' + FURLProvedor + LineBreak;
     end;

    if FConfiguracoes.WebServices.Visualizar
     then ShowMessage(aMsg);
   end;

  if Assigned(TACBrNFSe( FACBrNFSe ).OnGerarLog)
   then TACBrNFSe( FACBrNFSe ).OnGerarLog(aMsg);

  Result := (FMsg = '');

  NFSeRetorno.Free;

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
 Ok          : Boolean;
 i           : Integer;

 {$IFDEF ACBrNFSeOpenSSL}
   HTTP    : THTTPSend;
 {$ELSE}
   ReqResp : THTTPReqResp;
 {$ENDIF}

 {Prefixo3      : String;
 Prefixo4      : String;
 FRetListaNfse : AnsiString;
 FRetNfse      : AnsiString;
 i, j, k       : Integer;}
begin
 {Result :=} inherited Executar;

 // Incluido por Italo em 01/03/2012
 if Assigned(NFSeRetorno)
  then NFSeRetorno.Free;


// TnfseProvedor = ( proTiplan, proISSNET, proWebISS, proGINFES, proDSF, proProdemge, proAbaco, proBetha, proEquiplano, proISSIntel, proProdam );
 case StrToProvedor(Ok, FURLProvedor) of
  proRJ        : Texto := '<?xml version="1.0" encoding="utf-8"?>' +
                          '<soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">' +
                           '<soap:Body>' +
                            '<CancelarNfseRequest xmlns="' + URLNS1 + '/">' +
                             '<inputXML>' +
                               StringReplace(StringReplace(FDadosMsg,
                                                           '<', '&lt;', [rfReplaceAll]), '>', '&gt;', [rfReplaceAll]) +
                             '</inputXML>' +
                            '</CancelarNfseRequest>' +
                           '</soap:Body>' +
                          '</soap:Envelope>';
  proTiplan    : Texto := '<?xml version="1.0" encoding="utf-8"?>' +
                          '<soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">' +
                           '<soap:Body>' +
                            '<CancelarNfseRequest xmlns="' + URLNS1 + '/">' +
                             '<inputXML>' +
                               StringReplace(StringReplace(FDadosMsg,
                                                           '<', '&lt;', [rfReplaceAll]), '>', '&gt;', [rfReplaceAll]) +
                             '</inputXML>' +
                            '</CancelarNfseRequest>' +
                           '</soap:Body>' +
                          '</soap:Envelope>';
  proISSNET    : Texto := '<?xml version="1.0" encoding="utf-8"?>' +
                          '<soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">' +
                           '<soap:Body>' +
                            '<CancelarNfse xmlns="' + URLNS1 + '">' +
                             '<xml>' +
                               '&lt;?xml version="1.0" encoding="utf-8"?&gt;' +
                               StringReplace(StringReplace({'<nfseCabecMsg>' + FCabMsg + '</nfseCabecMsg>' +
                                                           '<nfseDadosMsg>' +} FDadosMsg {+ '</nfseDadosMsg>'},
                                                           '<', '&lt;', [rfReplaceAll]), '>', '&gt;', [rfReplaceAll]) +
                             '</xml>' +
                            '</CancelarNfse>' +
                           '</soap:Body>' +
                          '</soap:Envelope>';
  proWebISS    : Texto := '<?xml version="1.0" encoding="utf-8"?>' +
                          '<s:Envelope xmlns:s="http://schemas.xmlsoap.org/soap/envelope/">' +
                           '<s:Body>' +
                            '<CancelarNfse xmlns="' + URLNS1 + '/">' +
                             '<cabec>' +
                              '&lt;?xml version="1.0" encoding="utf-8"?&gt;' +
                               StringReplace(StringReplace(FCabMsg, '<', '&lt;', [rfReplaceAll]), '>', '&gt;', [rfReplaceAll]) +
                             '</cabec>' +
                             '<msg>' +
                              '&lt;?xml version="1.0" encoding="utf-8"?&gt;' +
                               StringReplace(StringReplace(FDadosMsg, '<', '&lt;', [rfReplaceAll]), '>', '&gt;', [rfReplaceAll]) +
                             '</msg>' +
                            '</CancelarNfse>' +
                           '</s:Body>' +
                          '</s:Envelope>';
  proGINFES    : Texto := '<?xml version="1.0" encoding="utf-8"?>' +
                          '<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/">' +
                           '<soapenv:Body>' +
                            '<ns1:CancelarNfse xmlns:ns1="' + URLNS1 + '">' +
                            '<arg0>' +
                             '&lt;?xml version="1.0" encoding="utf-8"?&gt;' +
                             StringReplace(StringReplace(FDadosMsg, '<', '&lt;', [rfReplaceAll]), '>', '&gt;', [rfReplaceAll]) +
                            '</arg0>' +
                            '</ns1:CancelarNfse>' +
                           '</soapenv:Body>' +
                          '</soapenv:Envelope>';
  proDSF       : Texto := '';
  proProdemge  : Texto := '<?xml version="1.0" encoding="utf-8"?>' +
                          '<soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">' +
                           '<soap:Body>' +
                            '<ns2:CancelarNfseRequest xmlns:ns2="' + URLNS1 + '">' +
                             '<nfseCabecMsg>' +
                              StringReplace(StringReplace(FCabMsg, '<', '&lt;', [rfReplaceAll]), '>', '&gt;', [rfReplaceAll]) +
                             '</nfseCabecMsg>' +
                             '<nfseDadosMsg>' +
                              StringReplace(StringReplace(FDadosMsg, '<', '&lt;', [rfReplaceAll]), '>', '&gt;', [rfReplaceAll]) +
                             '</nfseDadosMsg>' +
                            '</ns2:CancelarNfseRequest>' +
                           '</soap:Body>' +
                          '</soap:Envelope>';
  proAbaco     : Texto := '';
  proBetha     : Texto := '';
  proEquiplano : Texto := '';
  proISSIntel  : Texto := '';
  proProdam    : Texto := '';
  proGovBR     : Texto := '<?xml version="1.0" encoding="utf-8"?>' +
                          '<s:Envelope xmlns:s="http://schemas.xmlsoap.org/soap/envelope/" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">' +
                           '<s:Body>' +
                            '<CancelarNfse xmlns="' + URLNS1 + '/">' +
                             '<xmlEnvio>' +
                               StringReplace(StringReplace(FDadosMsg, '<', '&lt;', [rfReplaceAll]), '>', '&gt;', [rfReplaceAll]) +
                             '</xmlEnvio>' +
                            '</CancelarNfse>' +
                           '</s:Body>' +
                          '</s:Envelope>';
  proRecife    : Texto := '<?xml version="1.0" encoding="utf-8"?>' +
                          '<soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">' +
                           '<soap:Body>' +
                            '<CancelarNfseEnvio xmlns="' + URLNS1 + '">' +
                             '<MensagemXML>' +
                               StringReplace(StringReplace(
                                             {'<nfseCabecMsg>' + FCabMsg + '</nfseCabecMsg>' + '<nfseDadosMsg>' +}
                                             FDadosMsg {+ '</nfseDadosMsg>'},
                                                           '<', '&lt;', [rfReplaceAll]), '>', '&gt;', [rfReplaceAll]) +
                             '</MensagemXML>' +
                            '</CancelarNfseEnvio>' +
                           '</soap:Body>' +
                          '</soap:Envelope>';
  proSimplISS  : Texto := '<?xml version="1.0" encoding="utf-8"?>' +
                          '<s:Envelope xmlns:s="http://schemas.xmlsoap.org/soap/envelope/"' +
                                     ' xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"' +
                                     ' xmlns:xsd="http://www.w3.org/2001/XMLSchema">' +
                           '<s:Body>' +
                            '<CancelarNfse xmlns="' + URLNS1 + '">' +
//                             '<CancelarNfseEnvio>' +
                              FDadosMsg +
//                             '</CancelarNfseEnvio>' +
                             '<pParam>' +
                               FDadosSenha +
                             '</pParam>' +
                            '</CancelarNfse>' +
                           '</s:Body>' +
                          '</s:Envelope>';

  else Texto := '';
 end;

 Acao      := TStringList.Create;
 Stream    := TMemoryStream.Create;
 Acao.Text := Texto;

 {$IFDEF ACBrNFSeOpenSSL}
   Acao.SaveToStream(Stream);
   HTTP := THTTPSend.Create;
 {$ELSE}
   ReqResp := THTTPReqResp.Create(nil);
   ConfiguraReqResp( ReqResp );

   if(FURLProvedor = 'RJ')
    then ReqResp.URL := 'https://notacarioca.rio.gov.br/WSNacional/nfse.asmx?op=CancelarNfse'
    else ReqResp.URL := FURL;

   ReqResp.UseUTF8InHeader := True;

   case StrToProvedor(Ok, FURLProvedor) of
    proRJ        : ReqResp.SoapAction := 'http://notacarioca.rio.gov.br/CancelarNfse';
    proTiplan    : ReqResp.SoapAction := 'http://www.nfe.com.br/CancelarNfse';
    proISSNET    : ReqResp.SoapAction := 'http://www.issnetonline.com.br/webservice/nfd/CancelarNfse';
    proWebISS    : ReqResp.SoapAction := 'http://tempuri.org/INfseServices/CancelarNfse';
    proGINFES    : ReqResp.SoapAction := '';
    proDSF       : ReqResp.SoapAction := '';
    proProdemge  : ReqResp.SoapAction := 'http://ws.bhiss.pbh.gov.br/CancelarNfse';
    proAbaco     : ReqResp.SoapAction := '';
    proBetha     : ReqResp.SoapAction := '';
    proEquiplano : ReqResp.SoapAction := '';
    proISSIntel  : ReqResp.SoapAction := '';
    proProdam    : ReqResp.SoapAction := '';
    proGovBR     : ReqResp.SoapAction := 'http://tempuri.org/INFSEGeracao/CancelarNfse';
    proRecife    : ReqResp.SoapAction := 'http://www.abrasf.org.br/ABRASF/arquivos/nfse.xsd/WSNacional/CancelarNfse';
    proSimplISS  : ReqResp.SoapAction := 'http://www.sistema.com.br/Sistema.Ws.Nfse/INfseService/CancelarNfse';

    else ReqResp.SoapAction := '';
   end;
 {$ENDIF}

 try
  TACBrNFSe( FACBrNFSe ).SetStatus( stNFSeConsulta );

  if FConfiguracoes.Arquivos.Salvar
   then FConfiguracoes.Geral.Save(TNFSeCancelarNFse(Self).FNotasFiscais.Items[0].NFSe.Numero + '-ped-can-c.xml', Texto, FConfiguracoes.Arquivos.GetPathCan );

  if FConfiguracoes.Geral.Salvar
   then FConfiguracoes.Geral.Save(TNFSeCancelarNFse(Self).FNotasFiscais.Items[0].NFSe.Numero + '-ped-can.xml', FDadosMsg, FConfiguracoes.Arquivos.GetPathCan );

  {$IFDEF ACBrNFSeOpenSSL}
    HTTP.Document.LoadFromStream(Stream);
    ConfiguraHTTP(HTTP,'SOAPAction: "http://tempuri.org/INfseServices/CancelarNfse"');
    HTTP.HTTPMethod('POST', FURL);

    StrStream := TStringStream.Create('');
    StrStream.CopyFrom(HTTP.Document, 0);
    FRetWS := SeparaDados( ParseText(StrStream.DataString, True),'CancelarNfse');
    StrStream.Free;
  {$ELSE}
    ReqResp.Execute(Acao.Text, Stream);
    StrStream := TStringStream.Create('');
    StrStream.CopyFrom(Stream, 0);
    FRetornoWS := TiraAcentos(ParseText(StrStream.DataString, True));

    case StrToProvedor(Ok, FURLProvedor) of
     proRJ        : FRetWS := SeparaDados( FRetornoWS, 'outputXML' );
     proTiplan    : FRetWS := SeparaDados( FRetornoWS, 'outputXML' );
     proISSNET    : begin
                     FRetWS := SeparaDados( FRetornoWS, 'CancelarNfseResult' );
                     FRetWS := StringReplace(FRetWS, ' xmlns="http://www.issnetonline.com.br/webserviceabrasf/vsd/servico_cancelar_nfse_resposta.xsd"', '', [rfReplaceAll]);
                     FRetWS := StringReplace(FRetWS, ' xmlns="http://www.issnetonline.com.br/webserviceabrasf/vsd/tipos_complexos.xsd"', '', [rfReplaceAll]);
                    end;
     proWebISS    : FRetWS := SeparaDados( FRetornoWS, 'CancelarNfseResult' );
     proGINFES    : FRetWS := SeparaDados( FRetornoWS, 'return' );
     proDSF       : FRetWS := SeparaDados( FRetornoWS, '' );
     proProdemge  : FRetWS := SeparaDados( FRetornoWS, 'outputXML' );
     proAbaco     : FRetWS := SeparaDados( FRetornoWS, '' );
     proBetha     : FRetWS := SeparaDados( FRetornoWS, '' );
     proEquiplano : FRetWS := SeparaDados( FRetornoWS, '' );
     proISSIntel  : FRetWS := SeparaDados( FRetornoWS, '' );
     proProdam    : FRetWS := SeparaDados( FRetornoWS, '' );
     proGovBR     : FRetWS := SeparaDados( FRetornoWS, 'CancelarNfseResult' );
     proRecife    : begin
                     FRetWS := SeparaDados( FRetornoWS, 'CancelarNfseResposta>' );
                     FRetWS := FRetWS + '</CancelarNfseResposta>';
                    end;
     proSimplISS  : begin
                     FRetWS := SeparaDados( FRetornoWS, 'CancelarNfseResult' );
                     FRetWS := StringReplace(FRetWS, ' xmlns="http://www.sistema.com.br/Nfse/arquivos/nfse_3.xsd"', '', [rfReplaceAll]);
                     FRetWS := '<CancelarNfseResposta xmlns="http://www.sistema.com.br/Nfse/arquivos/nfse_3.xsd">' +
                                 FRetWS +
                               '</CancelarNfseResposta>';
                    end;

     else FRetWS := SeparaDados( FRetornoWS, 'outputXML' );
    end;

    StrStream.Free;
  {$ENDIF}

  if FConfiguracoes.Geral.Salvar
   then FConfiguracoes.Geral.Save(TNFSeCancelarNFse(Self).FNotasFiscais.Items[0].NFSe.Numero + '-can-c.xml', FRetornoWS, FConfiguracoes.Arquivos.GetPathCan);

  if FConfiguracoes.Geral.Salvar
   then FConfiguracoes.Geral.Save(TNFSeCancelarNFse(Self).FNotasFiscais.Items[0].NFSe.Numero + '-can.xml', FRetWS, FConfiguracoes.Arquivos.GetPathCan);

  NFSeRetorno                := TretCancNfse.Create;
  NFSeRetorno.Prefixo2       := FConfiguracoes.WebServices.Prefixo2;
  NFSeRetorno.Prefixo3       := FConfiguracoes.WebServices.Prefixo3;
  if StrToProvedor(Ok, FURLProvedor) = proISSNET
   then NFSeRetorno.Prefixo4 := ''
   else NFSeRetorno.Prefixo4 := FConfiguracoes.WebServices.Prefixo4;
  NFSeRetorno.Leitor.Arquivo := FRetWS;
  NFSeRetorno.LerXml;

  {
  // TnfsePadraoLayout = ( plABRASF, plGINFES );
  if FConfiguracoes.WebServices.PadraoLayout = plABRASF
   then begin
    Prefixo3 := '';
    Prefixo4 := '';
   end
   else begin
    Prefixo3 := 'ns3:';
    Prefixo4 := 'ns4:';
   end;

  FRetListaNfse := SeparaDados(FRetWS, Prefixo3 + 'ListaNfse');
  i := 0;
  while FRetListaNfse <> '' do
   begin
    j := Pos('</' + Prefixo4 + 'Nfse>', FRetListaNfse);
    if j > 0
     then begin
      FRetNfse := Copy(FRetListaNfse, 1, j - 1);
      k :=  Pos('<' + Prefixo4 + 'InfNfse>', FRetNfse);
      FRetNfse := Copy(FRetNfse, k + 13, length(FRetNfse));
      FRetNfse := '<?xml version="1.0" encoding="UTF-8" standalone="yes" ?>' +
                  '<' + Prefixo4 + 'Nfse xmlns:ns4="http://www.ginfes.com.br/tipos_v03.xsd">' +
                  '<' + Prefixo4 + 'InfNfse Id="nfse' + NFSeRetorno.ListaNfse.CompNfse.Items[i].Nfse.Numero + '">' +
                    FRetNfse +
                  '</' + Prefixo4 + 'Nfse>';

      if FConfiguracoes.Geral.Salvar
       then begin
        PathSalvar := FConfiguracoes.Arquivos.GetPathNFSe(0);
        FConfiguracoes.Geral.Save(NFSeRetorno.ListaNfse.CompNfse.Items[i].Nfse.Numero + '-nfse.xml', FRetNfse, PathSalvar);
        if FNotasFiscais.Count>0
         then FNotasFiscais.Items[i].NomeArq := PathWithDelim(PathSalvar) + NFSeRetorno.ListaNfse.CompNfse.Items[i].Nfse.Numero + '-nfse.xml';
       end;

      FRetListaNfse := Copy(FRetListaNfse, j + 11, length(FRetListaNfse));
      inc(i);
     end
     else FRetListaNfse:='';
   end;
  }

  TACBrNFSe( FACBrNFSe ).SetStatus( stNFSeIdle );

  FDataHora := NFSeRetorno.InfCanc.DataHora;

  // Lista de Mensagem de Retorno
  FMsg := '';
  if NFSeRetorno.InfCanc.MsgRetorno.Count>0
   then begin
    aMsg:='';
    for i:=0 to NFSeRetorno.InfCanc.MsgRetorno.Count - 1 do
     begin
      FMsg := FMsg + NFSeRetorno.infCanc.MsgRetorno.Items[i].Mensagem + ' / ';
      aMsg := aMsg + 'Código Erro : ' + NFSeRetorno.InfCanc.MsgRetorno.Items[i].Codigo + LineBreak +
                     'Mensagem... : ' + NFSeRetorno.infCanc.MsgRetorno.Items[i].Mensagem + LineBreak+
                     'Correção... : ' + NFSeRetorno.InfCanc.MsgRetorno.Items[i].Correcao + LineBreak+
                     'Provedor... : ' + FURLProvedor + LineBreak;
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

end.
