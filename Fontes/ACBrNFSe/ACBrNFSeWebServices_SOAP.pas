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
    pnfsConsNfseResposta, pnfsCancNfseResposta,
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
    FURLNS1: String;

    procedure LoadMsgEntrada;
    procedure LoadURL;
  public
    function Executar: Boolean; virtual;
    constructor Create(AOwner : TComponent); virtual;
    property CabMsg: WideString read FCabMsg;
    property DadosMsg: AnsiString read FDadosMsg;
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
    property URLNS1: String read FURLNS1;
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
 ACBrUtil,
 ACBrNFSeUtil, ACBrNFSe, Math;

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
     ReqResp.Proxy        := FConfiguracoes.WebServices.ProxyHost+':'+FConfiguracoes.WebServices.ProxyPort;
     ReqResp.UserName     := FConfiguracoes.WebServices.ProxyUser;
     ReqResp.Password     := FConfiguracoes.WebServices.ProxyPass;
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

 if not InternetSetOption(Data, INTERNET_OPTION_CLIENT_CERT_CONTEXT, PCertContext, Sizeof(CERT_CONTEXT)*5)
  then begin
   if Assigned(TACBrNFSe( FACBrNFSe ).OnGerarLog)
    then TACBrNFSe( FACBrNFSe ).OnGerarLog('ERRO: Erro OnBeforePost: ' + IntToStr(GetLastError));
   raise Exception.Create( 'Erro OnBeforePost: ' + IntToStr(GetLastError) );
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
     //TnfsePadraoLayout = ( plABRASF, plGINFES );
     case FConfiguracoes.WebServices.PadraoLayout of
      plABRASF: ContentHeader := Format(ContentTypeTemplate, ['text/xml; charset=utf-8']);
      plGINFES: ContentHeader := Format(ContentTypeTemplate, ['application/soap+xml; charset=utf-8']);
     end;
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

 //TnfsePadraoLayout = ( plABRASF, plGINFES );
 case FConfiguracoes.WebServices.PadraoLayout of
  plABRASF: begin
             FHTTP_AG      := HTTP_ABRASF;
             FPrefixo2     := '';
             FPrefixo3     := '';
             FPrefixo4     := '';
             FNameSpaceCab := 'xmlns="' + FHTTP_AG + 'nfse.xsd">';
             FNameSpaceDad := 'xmlns="' + FHTTP_AG + 'nfse.xsd">';
             FVersaoLayOut := VersaoLayOut_ABRASF;
             FVersaoDados  := VersaoDados_ABRASF;
            end;
  plGINFES: begin
             FHTTP_AG      := HTTP_GINFES;
             FPrefixo2     := 'ns2:';
             FPrefixo3     := 'ns3:';
             FPrefixo4     := Prefixo;
             FNameSpaceCab := 'xmlns:ns2="' + FHTTP_AG + 'cabecalho_v03.xsd">';
             FNameSpaceDad := 'xmlns:ns3="' + FHTTP_AG + 'servico_enviar_lote_rps_envio_v03.xsd"' +
                      ' xmlns:' + stringReplace(Prefixo, ':', '', []) + '="' + FHTTP_AG + 'tipos_v03.xsd">';
             FVersaoLayOut := VersaoLayOut_GINFES;
             FVersaoDados  := VersaoDados_GINFES;
            end;
 end;

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

 FCabMsg   := '<' + Prefixo2 + 'cabecalho versao="'  + VersaoLayOut + '" ' + NameSpaceCab +
               '<versaoDados>' + VersaoDados + '</versaoDados>'+
              '</' + Prefixo2 + 'cabecalho>';

 FTagI     := '<' + Prefixo3 + 'EnviarLoteRpsEnvio ' + NameSpaceDad;

 FDadosMsg := '<' + Prefixo3 + 'LoteRps Id="' + IntToStr(TNFSeEnviarLoteRps(Self).NumeroLote) +
                NotaUtil.SeSenao(FConfiguracoes.WebServices.PadraoLayout = plABRASF, '" versao="' + VersaoDados_ABRASF, '') + '">' +
               '<' + Prefixo4 + 'NumeroLote>' +
                IntToStr(TNFSeEnviarLoteRps(Self).NumeroLote) +
               '</' + Prefixo4 + 'NumeroLote>' +
               '<' + Prefixo4 + 'Cnpj>' +
                TNFSeEnviarLoteRPS(Self).FNotasFiscais.Items[0].NFSe.Prestador.Cnpj +
               '</' + Prefixo4 + 'Cnpj>' +
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

 FDadosMsg := FTagI + FDadosMsg + FTagF;

 FDadosMsg := TNFSeEnviarLoteRPS(Self).FNotasFiscais.AssinarLoteRps(TNFSeEnviarLoteRps(Self).NumeroLote, FDadosMSg);

 if not(NotaUtil.Valida(FDadosMsg, FMsg, FConfiguracoes.Geral.PathSchemas,
                        FConfiguracoes.Geral.NameSpace, FConfiguracoes.WebServices.PadraoLayout))
  then raise Exception.Create('Falha na validação do Lote ' +
                 IntToStr(TNFSeEnviarLoteRps(Self).NumeroLote) + sLineBreak + FMsg);
end;

procedure TWebServicesBase.DoNFSeConsultarSituacaoLoteRPS;
begin
 //TnfsePadraoLayout = ( plABRASF, plGINFES );
 case FConfiguracoes.WebServices.PadraoLayout of
  plABRASF: begin
             FHTTP_AG      := HTTP_ABRASF;
             FPrefixo2     := '';
             FPrefixo3     := '';
             FPrefixo4     := '';
             FNameSpaceCab := 'xmlns="' + FHTTP_AG + 'nfse.xsd">';
             FNameSpaceDad := 'xmlns="' + FHTTP_AG + 'nfse.xsd">';
             FVersaoLayOut := VersaoLayOut_ABRASF;
             FVersaoDados  := VersaoDados_ABRASF;
            end;
  plGINFES: begin
             FHTTP_AG      := HTTP_GINFES;
             FPrefixo2     := 'ns2:';
             FPrefixo3     := 'ns3:';
             FPrefixo4     := Prefixo;
             FNameSpaceCab := 'xmlns:ns2="' + FHTTP_AG + 'cabecalho_v03.xsd">';
             FNameSpaceDad := 'xmlns:ns3="' + FHTTP_AG + 'servico_consultar_situacao_lote_rps_envio_v03.xsd"' +
                      ' xmlns:' + stringReplace(Prefixo, ':', '', []) + '="' + FHTTP_AG + 'tipos_v03.xsd">';
             FVersaoLayOut := VersaoLayOut_GINFES;
             FVersaoDados  := VersaoDados_GINFES;
            end;
 end;

 FCabMsg   := '<' + Prefixo2 + 'cabecalho versao="'  + VersaoLayOut + '" ' + NameSpaceCab +
               '<versaoDados>' + VersaoDados + '</versaoDados>'+
              '</' + Prefixo2 + 'cabecalho>';

 FTagI     := '<' + Prefixo3 + 'ConsultarSituacaoLoteRpsEnvio ' + NameSpaceDad;

 FDadosMsg := '<' + Prefixo3 + 'Prestador>' +
               '<' + Prefixo4 + 'Cnpj>' +
                TNFSeConsultarSituacaoLoteRPS(Self).Cnpj +
               '</' + Prefixo4 + 'Cnpj>' +
               '<' + Prefixo4 + 'InscricaoMunicipal>' +
                TNFSeConsultarSituacaoLoteRPS(Self).InscricaoMunicipal +
               '</' + Prefixo4 + 'InscricaoMunicipal>' +
              '</' + Prefixo3 + 'Prestador>' +
              '<' + Prefixo3 + 'Protocolo>' +
               TNFSeConsultarSituacaoLoteRPS(Self).Protocolo +
              '</' + Prefixo3 + 'Protocolo>';

 FTagF     := '</' + Prefixo3 + 'ConsultarSituacaoLoteRpsEnvio>';

 if FConfiguracoes.WebServices.PadraoLayout = plGINFES
  then begin
   if not(NotaUtil.AssinarXML(FDadosMsg, '', FTagI, FTagF,
                   FConfiguracoes.Certificados.GetCertificado, FvAssinada, FMsg))
    then raise Exception.Create('Falha ao assinar o XML ' + FMsg)
    else FDadosMsg := FvAssinada;
  end
  else FDadosMsg := FTagI + FDadosMsg + FTagF;
  
 if FConfiguracoes.Geral.Salvar
  then FConfiguracoes.Geral.Save(TNFSeConsultarSituacaoLoteRps(Self).Protocolo + '-con-sit.xml', FDadosMsg);

end;

procedure TWebServicesBase.DoNFSeConsultarLoteRPS;
begin
 //TnfsePadraoLayout = ( plABRASF, plGINFES );
 case FConfiguracoes.WebServices.PadraoLayout of
  plABRASF: begin
             FHTTP_AG      := HTTP_ABRASF;
             FPrefixo2     := '';
             FPrefixo3     := '';
             FPrefixo4     := '';
             FNameSpaceCab := 'xmlns="' + FHTTP_AG + 'nfse.xsd">';
             FNameSpaceDad := 'xmlns="' + FHTTP_AG + 'nfse.xsd">';
             FVersaoLayOut := VersaoLayOut_ABRASF;
             FVersaoDados  := VersaoDados_ABRASF;
            end;
  plGINFES: begin
             FHTTP_AG      := HTTP_GINFES;
             FPrefixo2     := 'ns2:';
             FPrefixo3     := 'ns3:';
             FPrefixo4     := Prefixo;
             FNameSpaceCab := 'xmlns:ns2="' + FHTTP_AG + 'cabecalho_v03.xsd">';
             FNameSpaceDad := 'xmlns:ns3="' + FHTTP_AG + 'servico_consultar_lote_rps_envio_v03.xsd"' +
                      ' xmlns:' + stringReplace(Prefixo, ':', '', []) + '="' + FHTTP_AG + 'tipos_v03.xsd">';
             FVersaoLayOut := VersaoLayOut_GINFES;
             FVersaoDados  := VersaoDados_GINFES;
            end;
 end;

 FCabMsg   := '<' + Prefixo2 + 'cabecalho versao="'  + VersaoLayOut + '" ' + NameSpaceCab +
               '<versaoDados>' + VersaoDados + '</versaoDados>'+
              '</' + Prefixo2 + 'cabecalho>';

 FTagI     := '<' + Prefixo3 + 'ConsultarLoteRpsEnvio ' + NameSpaceDad;

 FDadosMsg := '<' + Prefixo3 + 'Prestador>' +
               '<' + Prefixo4 + 'Cnpj>' +
                TNFSeConsultarLoteRPS(Self).FNotasFiscais.Items[0].NFSe.Prestador.Cnpj+
               '</' + Prefixo4 + 'Cnpj>' +
               '<' + Prefixo4 + 'InscricaoMunicipal>' +
                TNFSeConsultarLoteRPS(Self).FNotasFiscais.Items[0].NFSe.Prestador.InscricaoMunicipal+
               '</' + Prefixo4 + 'InscricaoMunicipal>' +
              '</' + Prefixo3 + 'Prestador>' +
              '<' + Prefixo3 + 'Protocolo>' +
               TNFSeConsultarLoteRPS(Self).Protocolo +
              '</' + Prefixo3 + 'Protocolo>';

 FTagF     := '</' + Prefixo3 + 'ConsultarLoteRpsEnvio>';

 if FConfiguracoes.WebServices.PadraoLayout = plGINFES
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
 //TnfsePadraoLayout = ( plABRASF, plGINFES );
 case FConfiguracoes.WebServices.PadraoLayout of
  plABRASF: begin
             FHTTP_AG      := HTTP_ABRASF;
             FPrefixo2     := '';
             FPrefixo3     := '';
             FPrefixo4     := '';
             FNameSpaceCab := 'xmlns="' + FHTTP_AG + 'nfse.xsd">';
             FNameSpaceDad := 'xmlns="' + FHTTP_AG + 'nfse.xsd">';
             FVersaoLayOut := VersaoLayOut_ABRASF;
             FVersaoDados  := VersaoDados_ABRASF;
            end;
  plGINFES: begin
             FHTTP_AG      := HTTP_GINFES;
             FPrefixo2     := 'ns2:';
             FPrefixo3     := 'ns3:';
             FPrefixo4     := Prefixo;
             FNameSpaceCab := 'xmlns:ns2="' + FHTTP_AG + 'cabecalho_v03.xsd">';
             FNameSpaceDad := 'xmlns:ns3="' + FHTTP_AG + 'servico_consultar_nfse_rps_envio_v03.xsd"' +
                      ' xmlns:' + stringReplace(Prefixo, ':', '', []) + '="' + FHTTP_AG + 'tipos_v03.xsd">';
             FVersaoLayOut := VersaoLayOut_GINFES;
             FVersaoDados  := VersaoDados_GINFES;
            end;
 end;

 FCabMsg   := '<' + Prefixo2 + 'cabecalho versao="'  + VersaoLayOut + '" ' + NameSpaceCab +
               '<versaoDados>' + VersaoDados + '</versaoDados>'+
              '</' + Prefixo2 + 'cabecalho>';

 FTagI     := '<' + Prefixo3 + 'ConsultarNfseRpsEnvio ' + NameSpaceDad;

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
               '<' + Prefixo4 + 'Cnpj>' +
                TNFSeConsultarNfseRPS(Self).Cnpj +
               '</' + Prefixo4 + 'Cnpj>' +
               '<' + Prefixo4 + 'InscricaoMunicipal>' +
                TNFSeConsultarNfseRPS(Self).InscricaoMunicipal +
               '</' + Prefixo4 + 'InscricaoMunicipal>' +
              '</' + Prefixo3 + 'Prestador>';

 FTagF     := '</' + Prefixo3 + 'ConsultarNfseRpsEnvio>';

 if FConfiguracoes.WebServices.PadraoLayout = plGINFES
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
 //TnfsePadraoLayout = ( plABRASF, plGINFES );
 case FConfiguracoes.WebServices.PadraoLayout of
  plABRASF: begin
             FHTTP_AG      := HTTP_ABRASF;
             FPrefixo2     := '';
             FPrefixo3     := '';
             FPrefixo4     := '';
             FNameSpaceCab := 'xmlns="' + FHTTP_AG + 'nfse.xsd">';
             FNameSpaceDad := 'xmlns="' + FHTTP_AG + 'nfse.xsd">';
             FVersaoLayOut := VersaoLayOut_ABRASF;
             FVersaoDados  := VersaoDados_ABRASF;
            end;
  plGINFES: begin
             FHTTP_AG      := HTTP_GINFES;
             FPrefixo2     := 'ns2:';
             FPrefixo3     := 'ns3:';
             FPrefixo4     := Prefixo;
             FNameSpaceCab := 'xmlns:ns2="' + FHTTP_AG + 'cabecalho_v03.xsd">';
             FNameSpaceDad := 'xmlns:ns3="' + FHTTP_AG + 'servico_consultar_nfse_envio_v03.xsd"' +
                      ' xmlns:' + stringReplace(Prefixo, ':', '', []) + '="' + FHTTP_AG + 'tipos_v03.xsd">';
             FVersaoLayOut := VersaoLayOut_GINFES;
             FVersaoDados  := VersaoDados_GINFES;
            end;
 end;

 FCabMsg   := '<' + Prefixo2 + 'cabecalho versao="'  + VersaoLayOut + '" ' + NameSpaceCab +
               '<versaoDados>' + VersaoDados + '</versaoDados>'+
              '</' + Prefixo2 + 'cabecalho>';

 FTagI     := '<' + Prefixo3 + 'ConsultarNfseEnvio ' + NameSpaceDad;

 FDadosMsg := '<' + Prefixo3 + 'Prestador>' +
               '<' + Prefixo4 + 'Cnpj>' +
                TNFSeConsultarNfse(Self).Cnpj +
               '</' + Prefixo4 + 'Cnpj>' +
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

 if FConfiguracoes.WebServices.PadraoLayout = plGINFES
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
 //TnfsePadraoLayout = ( plABRASF, plGINFES );
 case FConfiguracoes.WebServices.PadraoLayout of
  plABRASF: begin
             FHTTP_AG      := HTTP_ABRASF;
             FPrefixo2     := '';
             FPrefixo3     := '';
             FPrefixo4     := '';
             FNameSpaceCab := 'xmlns="' + FHTTP_AG + 'nfse.xsd">';
             FNameSpaceDad := 'xmlns="' + FHTTP_AG + 'nfse.xsd">';
             FVersaoLayOut := VersaoLayOut_ABRASF;
             FVersaoDados  := VersaoDados_ABRASF;
            end;
  plGINFES: begin
             FHTTP_AG      := HTTP_GINFES;
             FPrefixo2     := 'ns2:';
             FPrefixo3     := 'ns3:';
             FPrefixo4     := Prefixo;
             FNameSpaceCab := 'xmlns:ns2="' + FHTTP_AG + 'cabecalho_v03.xsd">';
             FNameSpaceDad := 'xmlns:ns3="' + FHTTP_AG + 'servico_cancelar_nfse_envio_v03.xsd"' +
                      ' xmlns:' + stringReplace(Prefixo, ':', '', []) + '="' + FHTTP_AG + 'tipos_v03.xsd">';
             FVersaoLayOut := VersaoLayOut_GINFES;
             FVersaoDados  := VersaoDados_GINFES;
            end;
 end;

 FCabMsg   := '<' + Prefixo2 + 'cabecalho versao="'  + VersaoLayOut + '" ' + NameSpaceCab +
               '<versaoDados>' + VersaoDados + '</versaoDados>'+
              '</' + Prefixo2 + 'cabecalho>';

 FTagI     := '<' + Prefixo3 + 'CancelarNfseEnvio ' + NameSpaceDad +
               '<' + Prefixo3 + 'Pedido>';

 URI       := 'pedidoCancelamento_' +
              TNFSeCancelarNfse(Self).FNotasFiscais.Items[0].NFSe.PrestadorServico.IdentificacaoPrestador.Cnpj +
              TNFSeCancelarNfse(Self).FNotasFiscais.Items[0].NFSe.PrestadorServico.IdentificacaoPrestador.InscricaoMunicipal +
              TNFSeCancelarNfse(Self).FNotasFiscais.Items[0].NFSe.Numero;

 FDadosMsg := '<' + Prefixo4 + 'InfPedidoCancelamento Id="' + URI + '">' +
               '<' + Prefixo4 + 'IdentificacaoNfse>' +
                '<' + Prefixo4 + 'Numero>' +
                 TNFSeCancelarNfse(Self).FNotasFiscais.Items[0].NFSe.Numero +
                '</' + Prefixo4 + 'Numero>' +
                '<' + Prefixo4 + 'Cnpj>' +
                 TNFSeCancelarNfse(Self).FNotasFiscais.Items[0].NFSe.PrestadorServico.IdentificacaoPrestador.Cnpj +
                '</' + Prefixo4 + 'Cnpj>' +
                '<' + Prefixo4 + 'InscricaoMunicipal>' +
                 TNFSeCancelarNfse(Self).FNotasFiscais.Items[0].NFSe.PrestadorServico.IdentificacaoPrestador.InscricaoMunicipal +
                '</' + Prefixo4 + 'InscricaoMunicipal>' +
                '<' + Prefixo4 + 'CodigoMunicipio>' +
                 TNFSeCancelarNfse(Self).FNotasFiscais.Items[0].NFSe.PrestadorServico.Endereco.CodigoMunicipio +
                '</' + Prefixo4 + 'CodigoMunicipio>' +
               '</' + Prefixo4 + 'IdentificacaoNfse>' +
               '<' + Prefixo4 + 'CodigoCancelamento>' +
                TNFSeCancelarNfse(Self).FCodigoCancelamento +
               '</' + Prefixo4 + 'CodigoCancelamento>' +
              '</' + Prefixo4 + 'InfPedidoCancelamento>';

 FTagF     :=   '</' + Prefixo3 + 'Pedido>' +
              '</' + Prefixo3 + 'CancelarNfseEnvio>';

 if not(NotaUtil.AssinarXML(FDadosMsg, URI, FTagI, FTagF,
                 FConfiguracoes.Certificados.GetCertificado, FvAssinada, FMsg))
  then raise Exception.Create('Falha ao assinar o XML ' + FMsg)
  else FDadosMsg := FvAssinada;

end;

function TWebServicesBase.Executar: Boolean;
begin
 Result := False;
 LoadMsgEntrada;
 LoadURL;
end;

procedure TWebServicesBase.LoadMsgEntrada;
begin
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
begin
 if self is TNFSeEnviarLoteRps
  then FURL := NotaUtil.GetURL(FConfiguracoes.WebServices.CodigoMunicipio, FConfiguracoes.WebServices.AmbienteCodigo, FConfiguracoes.Geral.PathSchemas, LayNfseRecepcaoLote)
  else if self is TNFSeConsultarSituacaoLoteRps
  then FURL := NotaUtil.GetURL(FConfiguracoes.WebServices.CodigoMunicipio, FConfiguracoes.WebServices.AmbienteCodigo, FConfiguracoes.Geral.PathSchemas, LayNfseConsultaSitLoteRps)
  else if self is TNFSeConsultarLoteRps
  then FURL := NotaUtil.GetURL(FConfiguracoes.WebServices.CodigoMunicipio, FConfiguracoes.WebServices.AmbienteCodigo, FConfiguracoes.Geral.PathSchemas, LayNfseConsultaLote)
  else if self is TNFSeConsultarNfseRps
  then FURL := NotaUtil.GetURL(FConfiguracoes.WebServices.CodigoMunicipio, FConfiguracoes.WebServices.AmbienteCodigo, FConfiguracoes.Geral.PathSchemas, LayNfseConsultaNfseRps)
  else if self is TNFSeConsultarNfse
  then FURL := NotaUtil.GetURL(FConfiguracoes.WebServices.CodigoMunicipio, FConfiguracoes.WebServices.AmbienteCodigo, FConfiguracoes.Geral.PathSchemas, LayNfseConsultaNfse)
  else if self is TNFSeCancelarNfse
  then FURL := NotaUtil.GetURL(FConfiguracoes.WebServices.CodigoMunicipio, FConfiguracoes.WebServices.AmbienteCodigo, FConfiguracoes.Geral.PathSchemas, LayNfseCancelaNfse);
{
 FURL := NotaUtil.SeSenao(FConfiguracoes.WebServices.AmbienteCodigo=1,
                          FConfiguracoes.WebServices.URL_Producao,
                          FConfiguracoes.WebServices.URL_Homologacao);
}
 //TnfsePadraoLayout = ( plABRASF, plGINFES );
 case FConfiguracoes.WebServices.PadraoLayout of
  plABRASF: FURLNS1 := NotaUtil.SeSenao(FConfiguracoes.WebServices.AmbienteCodigo=1,
                          'http://producao.abrasf.com.br',
                          'http://homologacao.agrasf.com.br');
  plGINFES: FURLNS1 := NotaUtil.SeSenao(FConfiguracoes.WebServices.AmbienteCodigo=1,
                          'http://producao.ginfes.com.br',
                          'http://homologacao.ginfes.com.br');
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

 Self.ConsLote.Protocolo          := Self.Enviar.Protocolo;

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

 {$IFDEF ACBrNFSeOpenSSL}
   HTTP    : THTTPSend;
 {$ELSE}
   ReqResp : THTTPReqResp;
 {$ENDIF}
begin
 Result := inherited Executar;

 Texto := '<?xml version="1.0" encoding="utf-8"?>' +
          '<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/">' +
           '<soapenv:Body>' +
            '<ns1:RecepcionarLoteRpsV3 xmlns:ns1="' + URLNS1 + '">' +
             '<arg0>' + FCabMsg + '</arg0>' +
             '<arg1>' + FDadosMsg + '</arg1>' +
            '</ns1:RecepcionarLoteRpsV3>' +
           '</soapenv:Body>' +
          '</soapenv:Envelope>';

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
   ReqResp.SoapAction := '';
 {$ENDIF}

 try
  TACBrNFSe( FACBrNFSe ).SetStatus( stNFSeRecepcao );

  if FConfiguracoes.Geral.Salvar
   then FConfiguracoes.Geral.Save(IntToStr(NumeroLote)+'-env-lot.xml', FDadosMsg);

  {$IFDEF ACBrNFSeOpenSSL}
    HTTP.Document.LoadFromStream(Stream);
    ConfiguraHTTP(HTTP,'SOAPAction: "http://www.portalfiscal.inf.br/nfe/wsdl/NfeRecepcao/nfeRecepcaoLote"');
    HTTP.HTTPMethod('POST', FURL);

    StrStream := TStringStream.Create('');
    StrStream.CopyFrom(HTTP.Document, 0);
    FRetWS := NotaUtil.SeparaDados( NotaUtil.ParseText(StrStream.DataString, True),'RecepcionarLoteRpsV3');
    StrStream.Free;
  {$ELSE}
    ReqResp.Execute(Acao.Text, Stream);
    StrStream := TStringStream.Create('');
    StrStream.CopyFrom(Stream, 0);
    FRetornoWS := NotaUtil.ParseText(StrStream.DataString, True);
    FRetWS := TiraAcentos(NotaUtil.SeparaDados( FRetornoWS, 'return' ));
    StrStream.Free;
  {$ENDIF}

  if FConfiguracoes.Geral.Salvar
   then FConfiguracoes.Geral.Save(IntToStr(NumeroLote)+'-rec.xml', FRetWS);

  NFSeRetorno                := TretEnvLote.Create;
  NFSeRetorno.LayOut         := FConfiguracoes.WebServices.PadraoLayout;
  NFSeRetorno.Leitor.Arquivo := FRetWS;
  NFSeRetorno.LerXml;

  TACBrNFSe( FACBrNFSe ).SetStatus( stNFSeIdle );

  FDataRecebimento := NFSeRetorno.InfRec.DataRecebimento;
  FProtocolo       := NFSeRetorno.InfRec.Protocolo;

  // Lista de Mensagem de Retorno
  if NFSeRetorno.InfRec.MsgRetorno.Count>0
   then FMsg := NFSeRetorno.infRec.MsgRetorno.Items[0].Mensagem
   else FMsg := '';

  if FMsg=''
   then aMsg := 'Numero do Lote : ' + NFSeRetorno.InfRec.NumeroLote + LineBreak +
                'Recebimento... : ' + NotaUtil.SeSenao(FDataRecebimento = 0, '', DateTimeToStr(FDataRecebimento)) + LineBreak +
                'Protocolo..... : ' + FProtocolo + LineBreak
   else aMsg := 'Código Erro : ' + NFSeRetorno.InfRec.MsgRetorno.Items[0].Codigo + LineBreak +
                'Mensagem... : ' + FMsg + LineBreak+
                'Correção... : ' + NFSeRetorno.InfRec.MsgRetorno.Items[0].Correcao + LineBreak;

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

{ TNFeRetRecepcao }
{function TNFeRetRecepcao.Confirma(AInfProt: TProtNFeCollection): Boolean;
var
  i,j : Integer;
  AProcNFSe: TProcNFSe;
begin
  Result := False;

  //Setando os retornos das notas fiscais;
  for i:= 0 to AInfProt.Count-1 do
  begin
    for j:= 0 to FNotasFiscais.Count-1 do
    begin
      if AInfProt.Items[i].chNFe = StringReplace(FNotasFiscais.Items[j].NFe.InfNFe.Id,'NFe','',[rfIgnoreCase]) then
       begin
         FNotasFiscais.Items[j].Confirmada := (AInfProt.Items[i].cStat = 100);
         FNotasFiscais.Items[j].Msg        := AInfProt.Items[i].xMotivo;
         FNotasFiscais.Items[j].NFSe.procNFe.tpAmb    := AInfProt.Items[i].tpAmb;
         FNotasFiscais.Items[j].NFSe.procNFe.verAplic := AInfProt.Items[i].verAplic;
         FNotasFiscais.Items[j].NFSe.procNFe.chNFe    := AInfProt.Items[i].chNFe;
         FNotasFiscais.Items[j].NFSe.procNFe.dhRecbto := AInfProt.Items[i].dhRecbto;
         FNotasFiscais.Items[j].NFSe.procNFe.nProt    := AInfProt.Items[i].nProt;
         FNotasFiscais.Items[j].NFSe.procNFe.digVal   := AInfProt.Items[i].digVal;
         FNotasFiscais.Items[j].NFSe.procNFe.cStat    := AInfProt.Items[i].cStat;
         FNotasFiscais.Items[j].NFSe.procNFe.xMotivo  := AInfProt.Items[i].xMotivo;
         if FConfiguracoes.Geral.Salvar or NotaUtil.NaoEstaVazio(FNotasFiscais.Items[j].NomeArq) then
          begin
            if FileExists(PathWithDelim(FConfiguracoes.Geral.PathSalvar)+AInfProt.Items[i].chNFe+'-nfe.xml') and
               FileExists(PathWithDelim(FConfiguracoes.Geral.PathSalvar)+FNFeRetorno.nRec+'-pro-rec.xml') then
             begin
               AProcNFe:=TProcNFe.Create;
               AProcNFe.PathNFSe:=PathWithDelim(FConfiguracoes.Geral.PathSalvar)+AInfProt.Items[i].chNFe+'-nfe.xml';
               AProcNFe.PathRetConsReciNFe:=PathWithDelim(FConfiguracoes.Geral.PathSalvar)+FNFeRetorno.nRec+'-pro-rec.xml';
               AProcNFe.GerarXML;
               if NotaUtil.NaoEstaVazio(AProcNFe.Gerador.ArquivoFormatoXML) then
                begin
                  if NotaUtil.NaoEstaVazio(FNotasFiscais.Items[j].NomeArq) then
                     AProcNFe.Gerador.SalvarArquivo(FNotasFiscais.Items[j].NomeArq)
                  else
                     AProcNFe.Gerador.SalvarArquivo(PathWithDelim(FConfiguracoes.Geral.PathSalvar)+AInfProt.Items[i].chNFe+'-nfe.xml');
                end;
               AProcNFe.Free;
             end;
          end;
         if FConfiguracoes.Arquivos.Salvar then
            if FConfiguracoes.Arquivos.EmissaoPathNFSe then
               FNotasFiscais.Items[j].SaveToFile(PathWithDelim(FConfiguracoes.Arquivos.GetPathNFSe(FNotasFiscais.Items[j].NFe.Ide.dEmi))+StringReplace(FNotasFiscais.Items[j].NFe.InfNFe.Id,'NFe','',[rfIgnoreCase])+'-nfe.xml')
            else
               FNotasFiscais.Items[j].SaveToFile(PathWithDelim(FConfiguracoes.Arquivos.GetPathNFSe)+StringReplace(FNotasFiscais.Items[j].NFe.InfNFe.Id,'NFe','',[rfIgnoreCase])+'-nfe.xml');
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
end;}

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

 {$IFDEF ACBrNFSeOpenSSL}
   HTTP    : THTTPSend;
 {$ELSE}
   ReqResp : THTTPReqResp;
 {$ENDIF}
begin
 Result := inherited Executar;

 Texto := '<?xml version="1.0" encoding="utf-8"?>' +
          '<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/">' +
           '<soapenv:Body>' +
            '<ns1:ConsultarSituacaoLoteRpsV3 xmlns:ns1="' + URLNS1 + '">' +
             '<arg0>' + FCabMsg + '</arg0>' +
             '<arg1>' + FDadosMsg + '</arg1>' +
            '</ns1:ConsultarSituacaoLoteRpsV3>' +
           '</soapenv:Body>' +
          '</soapenv:Envelope>';

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
   ReqResp.SoapAction := '';
 {$ENDIF}

 try
  TACBrNFSe( FACBrNFSe ).SetStatus( stNFSeConsulta );

  if FConfiguracoes.Geral.Salvar
   then FConfiguracoes.Geral.Save(Protocolo + '-con-sit.xml', FDadosMsg);

  {$IFDEF ACBrNFSeOpenSSL}
    HTTP.Document.LoadFromStream(Stream);
    ConfiguraHTTP(HTTP,'SOAPAction: "http://www.portalfiscal.inf.br/nfe/wsdl/NfeRecepcao/nfeRecepcaoLote"');
    HTTP.HTTPMethod('POST', FURL);

    StrStream := TStringStream.Create('');
    StrStream.CopyFrom(HTTP.Document, 0);
    FRetWS := NotaUtil.SeparaDados( NotaUtil.ParseText(StrStream.DataString, True),'ConsultarSituacaoLoteRpsV3');
    StrStream.Free;
  {$ELSE}
    ReqResp.Execute(Acao.Text, Stream);
    StrStream := TStringStream.Create('');
    StrStream.CopyFrom(Stream, 0);
    FRetornoWS := NotaUtil.ParseText(StrStream.DataString, True);
    FRetWS := TiraAcentos(NotaUtil.SeparaDados( FRetornoWS, 'return' ));
    StrStream.Free;
  {$ENDIF}

  if FConfiguracoes.Geral.Salvar
   then FConfiguracoes.Geral.Save(Protocolo + '-sit.xml', FRetWS);

  NFSeRetorno                := TretSitLote.Create;
  NFSeRetorno.LayOut         := FConfiguracoes.WebServices.PadraoLayout;
  NFSeRetorno.Leitor.Arquivo := FRetWS;
  NFSeRetorno.LerXml;

  TACBrNFSe( FACBrNFSe ).SetStatus( stNFSeIdle );

  FSituacao := NFSeRetorno.InfSit.Situacao;

  // Lista de Mensagem de Retorno
  if NFSeRetorno.InfSit.MsgRetorno.Count>0
   then FMsg := NFSeRetorno.InfSit.MsgRetorno.Items[0].Mensagem
   else FMsg := '';

  if FMsg=''
   then aMsg := 'Numero do Lote : ' + NFSeRetorno.InfSit.NumeroLote + LineBreak +
                'Situacao...... : ' + FSituacao + LineBreak
   else aMsg := 'Código Erro : ' + NFSeRetorno.InfSit.MsgRetorno.Items[0].Codigo + LineBreak +
                'Mensagem... : ' + FMsg + LineBreak+
                'Correção... : ' + NFSeRetorno.InfSit.MsgRetorno.Items[0].Correcao + LineBreak;

  if FConfiguracoes.WebServices.Visualizar
   then ShowMessage(aMsg);

  if Assigned(TACBrNFSe( FACBrNFSe ).OnGerarLog)
   then TACBrNFSe( FACBrNFSe ).OnGerarLog(aMsg);

  Result := (FSituacao = '2');

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
  Result := inherited Executar;
  Result := False;

  TACBrNFSe( FACBrNFSe ).SetStatus( stNFSeConsulta );
  Sleep(TACBrNFSe( FACBrNFSe ).Configuracoes.WebServices.AguardarConsultaRet);
  vCont := 10000;
  while Processando do
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

 {$IFDEF ACBrNFSeOpenSSL}
   HTTP    : THTTPSend;
 {$ELSE}
   ReqResp : THTTPReqResp;
 {$ENDIF}

 Prefixo3      : String;
 Prefixo4      : String;
 FRetListaNfse : AnsiString;
 FRetNfse      : AnsiString;
 i, j, k       : Integer;
begin
 Result := inherited Executar;

 Texto := '<?xml version="1.0" encoding="utf-8"?>' +
          '<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/">' +
           '<soapenv:Body>' +
            '<ns1:ConsultarLoteRpsV3 xmlns:ns1="' + URLNS1 + '">' +
             '<arg0>' + FCabMsg + '</arg0>' +
             '<arg1>' + FDadosMsg + '</arg1>' +
            '</ns1:ConsultarLoteRpsV3>' +
           '</soapenv:Body>' +
          '</soapenv:Envelope>';

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
   ReqResp.SoapAction := '';
 {$ENDIF}

 try
  TACBrNFSe( FACBrNFSe ).SetStatus( stNFSeConsulta );

  if FConfiguracoes.Geral.Salvar
   then FConfiguracoes.Geral.Save(Protocolo + '-con-lot.xml', FDadosMsg);

  {$IFDEF ACBrNFSeOpenSSL}
    HTTP.Document.LoadFromStream(Stream);
    ConfiguraHTTP(HTTP,'SOAPAction: "http://www.portalfiscal.inf.br/nfe/wsdl/NfeRecepcao/nfeRecepcaoLote"');
    HTTP.HTTPMethod('POST', FURL);

    StrStream := TStringStream.Create('');
    StrStream.CopyFrom(HTTP.Document, 0);
    FRetWS := NotaUtil.SeparaDados( NotaUtil.ParseText(StrStream.DataString, True),'ConsultarLoteRpsV3');
    StrStream.Free;
  {$ELSE}
    ReqResp.Execute(Acao.Text, Stream);
    StrStream := TStringStream.Create('');
    StrStream.CopyFrom(Stream, 0);
    FRetornoWS := NotaUtil.ParseText(StrStream.DataString, True);
    FRetWS := TiraAcentos(NotaUtil.SeparaDados( FRetornoWS, 'return' ));
    StrStream.Free;
  {$ENDIF}

  if FConfiguracoes.Geral.Salvar
   then FConfiguracoes.Geral.Save(Protocolo + '-lista-nfse.xml', FRetWS);

  NFSeRetorno                := TretLote.Create;
  NFSeRetorno.LayOut         := FConfiguracoes.WebServices.PadraoLayout;
  NFSeRetorno.Leitor.Arquivo := FRetWS;
  NFSeRetorno.LerXml;

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

  FRetListaNfse := NotaUtil.SeparaDados(FRetWS, Prefixo3 + 'ListaNfse');
  i := 0;
  while FRetListaNfse <> '' do
   begin
    j := Pos('</' + Prefixo4 + 'Nfse>', FRetListaNfse);
    if j > 0
     then begin
      FNotasFiscais.Items[i].NFSe.CodigoVerificacao := NFSeRetorno.ListaNfse.CompNfse.Items[i].Nfse.CodigoVerificacao;
      FNotasFiscais.Items[i].NFSe.Numero            := NFSeRetorno.ListaNfse.CompNfse.Items[i].Nfse.Numero;

      FRetNfse := Copy(FRetListaNfse, 1, j - 1);
      k :=  Pos('<' + Prefixo4 + 'InfNfse>', FRetNfse);
      FRetNfse := Copy(FRetNfse, k + 13, length(FRetNfse));
      FRetNfse := '<?xml version="1.0" encoding="UTF-8" standalone="yes" ?>' +
                  '<' + Prefixo4 + 'Nfse xmlns:ns4="http://www.ginfes.com.br/tipos_v03.xsd">' +
                  '<' + Prefixo4 + 'InfNfse Id="nfse' + NFSeRetorno.ListaNfse.CompNfse.Items[i].Nfse.Numero + '">' +
                    FRetNfse +
                  '</' + Prefixo4 + 'Nfse>';

      if FConfiguracoes.Geral.Salvar
       then FConfiguracoes.Geral.Save(NFSeRetorno.ListaNfse.CompNfse.Items[i].Nfse.Numero + '-nfse.xml', FRetNfse);

      FRetListaNfse := Copy(FRetListaNfse, j + 11, length(FRetListaNfse));
      inc(i);
     end
     else FRetListaNfse:='';
   end;

  TACBrNFSe( FACBrNFSe ).SetStatus( stNFSeIdle );

  // Lista de Mensagem de Retorno
  if NFSeRetorno.ListaNfse.MsgRetorno.Count>0
   then FMsg := NFSeRetorno.ListaNfse.MsgRetorno.Items[0].Mensagem
   else FMsg := '';

  if FMsg<>''
   then begin
    aMsg := 'Código Erro : ' + NFSeRetorno.ListaNfse.MsgRetorno.Items[0].Codigo + LineBreak +
            'Mensagem... : ' + FMsg + LineBreak+
            'Correção... : ' + NFSeRetorno.ListaNfse.MsgRetorno.Items[0].Correcao + LineBreak;

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
 NFSeRetorno : TretNfseRps;
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
 i, j, k      : Integer;
begin
 Result := inherited Executar;

 Texto := '<?xml version="1.0" encoding="utf-8"?>' +
          '<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/">' +
           '<soapenv:Body>' +
            '<ns1:ConsultarNfseRpsEnvioV3 xmlns:ns1="' + URLNS1 + '">' +
             '<arg0>' + FCabMsg + '</arg0>' +
             '<arg1>' + FDadosMsg + '</arg1>' +
            '</ns1:ConsultarNfseRpsEnvioV3>' +
           '</soapenv:Body>' +
          '</soapenv:Envelope>';

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
   ReqResp.SoapAction := '';
 {$ENDIF}

 try
  TACBrNFSe( FACBrNFSe ).SetStatus( stNFSeConsulta );

  if FConfiguracoes.Geral.Salvar
   then FConfiguracoes.Geral.Save(Numero + Serie + '-con-nfse-rps.xml', FDadosMsg);

  {$IFDEF ACBrNFSeOpenSSL}
    HTTP.Document.LoadFromStream(Stream);
    ConfiguraHTTP(HTTP,'SOAPAction: "http://www.portalfiscal.inf.br/nfe/wsdl/NfeRecepcao/nfeRecepcaoLote"');
    HTTP.HTTPMethod('POST', FURL);

    StrStream := TStringStream.Create('');
    StrStream.CopyFrom(HTTP.Document, 0);
    FRetWS := NotaUtil.SeparaDados( NotaUtil.ParseText(StrStream.DataString, True),'ConsultarNfsePorRpsV3');
    StrStream.Free;
  {$ELSE}
    ReqResp.Execute(Acao.Text, Stream);
    StrStream := TStringStream.Create('');
    StrStream.CopyFrom(Stream, 0);
    FRetornoWS := NotaUtil.ParseText(StrStream.DataString, True);
    FRetWS := TiraAcentos(NotaUtil.SeparaDados( FRetornoWS, 'return' ));
    StrStream.Free;
  {$ENDIF}

  if FConfiguracoes.Geral.Salvar
   then FConfiguracoes.Geral.Save(Numero + Serie + '-comp-nfse.xml', FRetWS);

  NFSeRetorno                := TretNfseRps.Create;
  NFSeRetorno.LayOut         := FConfiguracoes.WebServices.PadraoLayout;
  NFSeRetorno.Leitor.Arquivo := FRetWS;
  NFSeRetorno.LerXml;

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

  FRetCompNfse := NotaUtil.SeparaDados(FRetWS, Prefixo3 + 'CompNfse');
  i := 0;
  while FRetCompNfse <> '' do
   begin
    j := Pos('</' + Prefixo4 + 'Nfse>', FRetCompNfse);
    if j > 0
     then begin
      FRetNfse := Copy(FRetCompNfse, 1, j - 1);
      k :=  Pos('<' + Prefixo4 + 'InfNfse>', FRetNfse);
      FRetNfse := Copy(FRetNfse, k + 13, length(FRetNfse));
      FRetNfse := '<?xml version="1.0" encoding="UTF-8" standalone="yes" ?>' +
                  '<' + Prefixo4 + 'Nfse xmlns:ns4="http://www.ginfes.com.br/tipos_v03.xsd">' +
                  '<' + Prefixo4 + 'InfNfse Id="nfse' + NFSeRetorno.ListaNfse.CompNfse.Items[i].Nfse.Numero + '">' +
                    FRetNfse +
                  '</' + Prefixo4 + 'Nfse>';

      if FConfiguracoes.Geral.Salvar
       then FConfiguracoes.Geral.Save(NFSeRetorno.ListaNfse.CompNfse.Items[i].Nfse.Numero + '-nfse.xml', FRetNfse);

      FRetCompNfse := Copy(FRetCompNfse, j + 11, length(FRetCompNfse));
      inc(i);
     end
     else FRetCompNfse:='';
   end;

  TACBrNFSe( FACBrNFSe ).SetStatus( stNFSeIdle );

  // Lista de Mensagem de Retorno
  if NFSeRetorno.ListaNfse.MsgRetorno.Count>0
   then FMsg := NFSeRetorno.ListaNfse.MsgRetorno.Items[0].Mensagem
   else FMsg := '';

  if FMsg<>''
   then begin
    aMsg := 'Código Erro : ' + NFSeRetorno.ListaNfse.MsgRetorno.Items[0].Codigo + LineBreak +
            'Mensagem... : ' + FMsg + LineBreak+
            'Correção... : ' + NFSeRetorno.ListaNfse.MsgRetorno.Items[0].Correcao + LineBreak;

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

 {$IFDEF ACBrNFSeOpenSSL}
   HTTP    : THTTPSend;
 {$ELSE}
   ReqResp : THTTPReqResp;
 {$ENDIF}

 Prefixo3      : String;
 Prefixo4      : String;
 FRetListaNfse : AnsiString;
 FRetNfse      : AnsiString;
 i, j, k       : Integer;
begin
 Result := inherited Executar;

 Texto := '<?xml version="1.0" encoding="utf-8"?>' +
          '<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/">' +
           '<soapenv:Body>' +
            '<ns1:ConsultarNfseV3 xmlns:ns1="' + URLNS1 + '">' +
             '<arg0>' + FCabMsg + '</arg0>' +
             '<arg1>' + FDadosMsg + '</arg1>' +
            '</ns1:ConsultarNfseV3>' +
           '</soapenv:Body>' +
          '</soapenv:Envelope>';

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
   ReqResp.SoapAction := '';
 {$ENDIF}

 try
  TACBrNFSe( FACBrNFSe ).SetStatus( stNFSeConsulta );

  if FConfiguracoes.Geral.Salvar
   then FConfiguracoes.Geral.Save(FormatDateTime('yyyymmdd', DataInicial) + FormatDateTime('yyyymmdd', DataFinal) + '-con-nfse.xml', FDadosMsg);

  {$IFDEF ACBrNFSeOpenSSL}
    HTTP.Document.LoadFromStream(Stream);
    ConfiguraHTTP(HTTP,'SOAPAction: "http://www.portalfiscal.inf.br/nfe/wsdl/NfeRecepcao/nfeRecepcaoLote"');
    HTTP.HTTPMethod('POST', FURL);

    StrStream := TStringStream.Create('');
    StrStream.CopyFrom(HTTP.Document, 0);
    FRetWS := NotaUtil.SeparaDados( NotaUtil.ParseText(StrStream.DataString, True),'ConsultarNfseV3');
    StrStream.Free;
  {$ELSE}
    ReqResp.Execute(Acao.Text, Stream);
    StrStream := TStringStream.Create('');
    StrStream.CopyFrom(Stream, 0);
    FRetornoWS := NotaUtil.ParseText(StrStream.DataString, True);
    FRetWS := TiraAcentos(NotaUtil.SeparaDados( FRetornoWS, 'return' ));
    StrStream.Free;
  {$ENDIF}

  if FConfiguracoes.Geral.Salvar
   then FConfiguracoes.Geral.Save(FormatDateTime('yyyymmdd', DataInicial) + FormatDateTime('yyyymmdd', DataFinal) + '-lista-nfse.xml', FRetWS);

  NFSeRetorno                := TretNfse.Create;
  NFSeRetorno.LayOut         := FConfiguracoes.WebServices.PadraoLayout;
  NFSeRetorno.Leitor.Arquivo := FRetWS;
  NFSeRetorno.LerXml;

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

  FRetListaNfse := NotaUtil.SeparaDados(FRetWS, Prefixo3 + 'ListaNfse');
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
       then FConfiguracoes.Geral.Save(NFSeRetorno.ListaNfse.CompNfse.Items[i].Nfse.Numero + '-nfse.xml', FRetNfse);

      FRetListaNfse := Copy(FRetListaNfse, j + 11, length(FRetListaNfse));
      inc(i);
     end
     else FRetListaNfse:='';
   end;

  TACBrNFSe( FACBrNFSe ).SetStatus( stNFSeIdle );

  // Lista de Mensagem de Retorno
  if NFSeRetorno.ListaNfse.MsgRetorno.Count>0
   then FMsg := NFSeRetorno.ListaNfse.MsgRetorno.Items[0].Mensagem
   else FMsg := '';

  if FMsg<>''
   then begin
    aMsg := 'Código Erro : ' + NFSeRetorno.ListaNfse.MsgRetorno.Items[0].Codigo + LineBreak +
            'Mensagem... : ' + FMsg + LineBreak+
            'Correção... : ' + NFSeRetorno.ListaNfse.MsgRetorno.Items[0].Correcao + LineBreak;

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
 NFSeRetorno : TretCancNfse;
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
 i, j, k       : Integer;
begin
 Result := inherited Executar;

 Texto := '<?xml version="1.0" encoding="utf-8"?>' +
          '<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/">' +
           '<soapenv:Body>' +
            '<ns1:CancelarNfseV3 xmlns:ns1="' + URLNS1 + '">' +
             '<arg0>' + FCabMsg + '</arg0>' +
             '<arg1>' + FDadosMsg + '</arg1>' +
            '</ns1:CancelarNfseV3>' +
           '</soapenv:Body>' +
          '</soapenv:Envelope>';

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
   ReqResp.SoapAction := '';
 {$ENDIF}

 try
  TACBrNFSe( FACBrNFSe ).SetStatus( stNFSeConsulta );

  if FConfiguracoes.Geral.Salvar
   then FConfiguracoes.Geral.Save(TNFSeCancelarNFse(Self).FNotasFiscais.Items[0].NFSe.Numero + '-ped-can.xml', FDadosMsg);

  {$IFDEF ACBrNFSeOpenSSL}
    HTTP.Document.LoadFromStream(Stream);
    ConfiguraHTTP(HTTP,'SOAPAction: "http://www.portalfiscal.inf.br/nfe/wsdl/NfeRecepcao/nfeRecepcaoLote"');
    HTTP.HTTPMethod('POST', FURL);

    StrStream := TStringStream.Create('');
    StrStream.CopyFrom(HTTP.Document, 0);
    FRetWS := NotaUtil.SeparaDados( NotaUtil.ParseText(StrStream.DataString, True),'CancelarNfseV3');
    StrStream.Free;
  {$ELSE}
    ReqResp.Execute(Acao.Text, Stream);
    StrStream := TStringStream.Create('');
    StrStream.CopyFrom(Stream, 0);
    FRetornoWS := NotaUtil.ParseText(StrStream.DataString, True);
    FRetWS := TiraAcentos(NotaUtil.SeparaDados( FRetornoWS, 'return' ));
    StrStream.Free;
  {$ENDIF}

  if FConfiguracoes.Geral.Salvar
   then FConfiguracoes.Geral.Save(TNFSeCancelarNFse(Self).FNotasFiscais.Items[0].NFSe.Numero + '-can.xml', FRetWS);

  NFSeRetorno                := TretCancNfse.Create;
  NFSeRetorno.LayOut         := FConfiguracoes.WebServices.PadraoLayout;
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

  FRetListaNfse := NotaUtil.SeparaDados(FRetWS, Prefixo3 + 'ListaNfse');
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
       then FConfiguracoes.Geral.Save(NFSeRetorno.ListaNfse.CompNfse.Items[i].Nfse.Numero + '-nfse.xml', FRetNfse);

      FRetListaNfse := Copy(FRetListaNfse, j + 11, length(FRetListaNfse));
      inc(i);
     end
     else FRetListaNfse:='';
   end;
  }

  TACBrNFSe( FACBrNFSe ).SetStatus( stNFSeIdle );

  FDataHora := NFSeRetorno.InfCanc.DataHora;

  // Lista de Mensagem de Retorno
  if NFSeRetorno.infCanc.MsgRetorno.Count>0
   then FMsg := NFSeRetorno.infCanc.MsgRetorno.Items[0].Mensagem
   else FMsg := '';

  if FMsg=''
   then aMsg := 'Numero da NFSe : ' + NFSeRetorno.InfCanc.Pedido.IdentificacaoNfse.Numero + LineBreak +
                'Data Hora..... : ' + NotaUtil.SeSenao(FDataHora = 0, '', DateTimeToStr(FDataHora)) + LineBreak
   else aMsg := 'Código Erro : ' + NFSeRetorno.InfCanc.MsgRetorno.Items[0].Codigo + LineBreak +
                'Mensagem... : ' + FMsg + LineBreak+
                'Correção... : ' + NFSeRetorno.InfCanc.MsgRetorno.Items[0].Correcao + LineBreak;

  if FConfiguracoes.WebServices.Visualizar
   then ShowMessage(aMsg);

  if Assigned(TACBrNFSe( FACBrNFSe ).OnGerarLog)
   then TACBrNFSe( FACBrNFSe ).OnGerarLog(aMsg);

  Result := (FMsg='');

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

end.
