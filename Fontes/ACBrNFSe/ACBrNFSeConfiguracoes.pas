{$I ACBr.inc}

unit ACBrNFSeConfiguracoes;

interface

uses
{$IFNDEF ACBrNFSeOpenSSL}
  ACBrCAPICOM_TLB, ACBrMSXML2_TLB,
  JwaWinCrypt, JwaWinType,
{$ENDIF}
  Classes, Sysutils, pnfsConversao, pcnConversao;

{$IFNDEF ACBrNFSeOpenSSL}
  const CAPICOM_STORE_NAME = 'My'; //My CA Root AddressBook
{$ENDIF}

type

 TCertificadosConf = class(TComponent)
  private
    FAssinarRPS: Boolean;
    FAssinarLote: Boolean;
    FSenhaCert: AnsiString;
    {$IFNDEF ACBrNFSeOpenSSL}
       FNumeroSerie: AnsiString;
       FDataVenc: TDateTime;
       procedure SetNumeroSerie(const Value: AnsiString);
       function GetNumeroSerie: AnsiString;
       function GetDataVenc: TDateTime;
    {$ELSE}
       FCertificado: AnsiString;
    {$ENDIF}
  public
    {$IFNDEF ACBrNFSeOpenSSL}
       function SelecionarCertificado:AnsiString;
       function GetCertificado: ICertificate2;
    {$ENDIF}
  published
    {$IFNDEF ACBrNFSeOpenSSL}
       property NumeroSerie: AnsiString read GetNumeroSerie write SetNumeroSerie;
       property DataVenc: TDateTime read GetDataVenc;
    {$ELSE}
       property Certificado: AnsiString read FCertificado write FCertificado;
    {$ENDIF}
    property AssinarRPS: Boolean read FAssinarRPS write FAssinarRPS default True;
    property AssinarLote: Boolean read FAssinarLote write FAssinarLote default True;
    property Senha: AnsiString read FSenhaCert write FSenhaCert;
  end;

 TWebServicesConf = Class(TComponent)
  private
    FVisualizar : Boolean;
    FAmbiente: TpcnTipoAmbiente;
    FAmbienteCodigo: Integer;
    FProxyHost: String;
    FProxyPort: String;
    FProxyUser: String;
    FProxyPass: String;
    FPadraoLayout: TnfsePadraoLayout;
    FAguardarConsultaRet : Cardinal;
    FTentativas : Integer;
    FIntervaloTentativas : Cardinal;
    FAjustaAguardaConsultaRet : Boolean;
    FCodigoMunicipio: Integer;
    FPrefixo2: String;
    FPrefixo3: String;
    FPrefixo4: String;
    FProvedor: String;
    FVersaoSoap: String;
    FConfigSchemas: String;
    FConfigURL: String;
    FIdentificador: String;
    FNameSpace: String;
    FSenhaWeb: AnsiString;
    procedure SetAmbiente(AValue: TpcnTipoAmbiente);
    procedure SetTentativas(const Value: Integer);
    procedure SetIntervaloTentativas(const Value: Cardinal);
  public
    constructor Create(AOwner: TComponent); override;
    procedure SetConfigMunicipio(aPath: String = '');
  published
    property Visualizar: Boolean read FVisualizar write FVisualizar
      default False;
    property Ambiente: TpcnTipoAmbiente read FAmbiente write SetAmbiente
      default taHomologacao;
    property AmbienteCodigo: Integer read FAmbienteCodigo;
    property ProxyHost: String read FProxyHost write FProxyHost;
    property ProxyPort: String read FProxyPort write FProxyPort;
    property ProxyUser: String read FProxyUser write FProxyUser;
    property ProxyPass: String read FProxyPass write FProxyPass;
    property PadraoLayout: TnfsePadraoLayout read FPadraoLayout write FPadraoLayout;
    property AguardarConsultaRet : Cardinal read FAguardarConsultaRet write FAguardarConsultaRet;
    property Tentativas : Integer read FTentativas write SetTentativas default 18;
    property IntervaloTentativas : Cardinal read FIntervaloTentativas write SetIntervaloTentativas;
    property AjustaAguardaConsultaRet : Boolean read FAjustaAguardaConsultaRet write FAjustaAguardaConsultaRet;
    property CodigoMunicipio: Integer read FCodigoMunicipio write FCodigoMunicipio;
    property Prefixo2: String read FPrefixo2 write FPrefixo2;
    property Prefixo3: String read FPrefixo3 write FPrefixo3;
    property Prefixo4: String read FPrefixo4 write FPrefixo4;
    property Provedor: String read FProvedor write FProvedor;
    property VersaoSoap: String read FVersaoSoap write FVersaoSoap;
    property ConfigSchemas: String read FConfigSchemas write FConfigSchemas;
    property ConfigURL: String read FConfigURL write FConfigURL;
    property Identificador: String read FIdentificador write FIdentificador;
    property NameSpace: String read FNameSpace write FNameSpace;
    property SenhaWeb: AnsiString read FSenhaWeb write FSenhaWeb;
  end;

 TGeralConf = class(TComponent)
  private
    FSalvar: Boolean;
    FPathSalvar: String;
    FPathSchemas: String;
    function GetPathSalvar: String;
  public
    constructor Create(AOwner: TComponent); override ;
    function Save(AXMLName: String; AXMLFile: WideString; aPath: String = ''): Boolean;
  published
    property Salvar: Boolean read FSalvar write FSalvar default False ;
    property PathSalvar: String read GetPathSalvar write FPathSalvar;
    property PathSchemas: String read FPathSchemas write FPathSchemas;
  end;

 TArquivosConf = class(TComponent)
  private
    FSalvar   : Boolean;
    FMensal   : Boolean;
    FLiteral  : Boolean;
    FEmissaoPathNFSe  : Boolean;
    FPathNFSe : String;
    FPathCan  : String;
    FPathRPS: String;
    FPathGer: String;
  public
    constructor Create(AOwner: TComponent); override ;
    function GetPathCan: String;
    function GetPathGer: String;
    function GetPathRPS: String;
    function GetPathNFSe(Data : TDateTime = 0): String;
  published
    property Salvar     : Boolean read FSalvar  write FSalvar  default False ;
    property PastaMensal: Boolean read FMensal  write FMensal  default False ;
    property AdicionarLiteral: Boolean read FLiteral write FLiteral default False ;
    property EmissaoPathNFSe: Boolean read FEmissaoPathNFSe write FEmissaoPathNFSe default False ;
    property PathNFSe : String read FPathNFSe  write FPathNFSe;
    property PathCan : String read FPathCan  write FPathCan;
    property PathRPS : String read FPathRPS  write FPathRPS;
    property PathGer : String read FPathGer  write FPathGer;
  end;

 TConfiguracoes = class(TComponent)
  private
    FGeral: TGeralConf;
    FWebServices: TWebServicesConf;
    FCertificados: TCertificadosConf;
    FArquivos: TArquivosConf;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property Geral: TGeralConf read FGeral ;
    property WebServices: TWebServicesConf read FWebServices ;
    property Certificados: TCertificadosConf read FCertificados ;
    property Arquivos: TArquivosConf read FArquivos ;
  end;

implementation

uses
 IniFiles, DateUtils, Math, StrUtils, ACBrUtil, ACBrNFSe, ACBrNFSeUtil;

{ TConfiguracoes }

constructor TConfiguracoes.Create(AOwner: TComponent);
begin
 inherited Create( AOwner );

 FGeral      := TGeralConf.Create(Self);
 FGeral.Name := 'GeralConf';

{$IFDEF COMPILER6_UP}
  FGeral.SetSubComponent( true ); { para gravar no DFM/XFM }
{$ENDIF}

 FCertificados      := TCertificadosConf.Create(self);
 FCertificados.Name := 'CertificadosConf';
 FCertificados.FAssinarRPS := False;
 FCertificados.FAssinarLote := True;

{$IFDEF COMPILER6_UP}
  FCertificados.SetSubComponent( true ); { para gravar no DFM/XFM }
{$ENDIF}

 FWebServices      := TWebServicesConf.Create(self);
 FWebServices.Name := 'WebServicesConf';

{$IFDEF COMPILER6_UP}
  FWebServices.SetSubComponent( true ); { para gravar no DFM/XFM }
{$ENDIF}

 FArquivos      := TArquivosConf.Create(self);
 FArquivos.Name := 'ArquivosConf';

{$IFDEF COMPILER6_UP}
  FArquivos.SetSubComponent( true ); { para gravar no DFM/XFM }
{$ENDIF}
end;

destructor TConfiguracoes.Destroy;
begin
 FGeral.Free;
 FWebServices.Free;
 FCertificados.Free;
 FArquivos.Free;

 inherited;
end;

{ TGeralConf }

constructor TGeralConf.Create(AOwner: TComponent);
begin
 Inherited Create( AOwner );

 FSalvar      := False;
 FPathSalvar  := '';
 FPathSchemas := '';
end;

function TGeralConf.GetPathSalvar: String;
begin
 if NotaUtil.EstaVazio(FPathSalvar)
  then Result := NotaUtil.PathAplication
  else Result := FPathSalvar;

 Result := NotaUtil.PathWithDelim( Trim(Result) ) ;
end;

function TGeralConf.Save(AXMLName: String; AXMLFile: WideString; aPath: String = ''): Boolean;
var
 vSalvar: TStrings;
begin
 Result := False;
 vSalvar := TStringList.Create;
 try
  try
   if NotaUtil.NaoEstaVazio(ExtractFilePath(AXMLName))
    then begin
     aPath := ExtractFilePath(AXMLName);
     AXMLName := StringReplace(AXMLName,aPath,'',[rfIgnoreCase]);
    end
    else begin
     if NotaUtil.EstaVazio(aPath)
      then aPath := PathSalvar
      else aPath := PathWithDelim(aPath);
    end;

   vSalvar.Text := AXMLFile;
   if not DirectoryExists( aPath )
    then ForceDirectories( aPath );

   vSalvar.SaveToFile( aPath + AXMLName);
   Result := True;
  except on E: Exception do
   raise Exception.Create('Erro ao salvar. '+E.Message);
  end;
 finally
  vSalvar.Free;
 end;
end;

{ TWebServicesConf }

constructor TWebServicesConf.Create(AOwner: TComponent);
begin
 Inherited Create( AOwner );

 FVisualizar := False;
 FAmbiente   := taHomologacao;
 if FAmbiente=taProducao
  then FAmbienteCodigo := 1
  else FAmbienteCodigo := 2;

 FPadraoLayout  := plABRASF;
 FPrefixo2      := 'ns2:';
 FPrefixo3      := 'ns3:';
 FPrefixo4      := 'ns4:';
 FProvedor      := '';
 FVersaoSoap    := '';
 FConfigSchemas := '';
 FConfigURL     := '';
 FIdentificador := 'Id';
 FNameSpace     := '';
end;

procedure TWebServicesConf.SetAmbiente(AValue: TpcnTipoAmbiente);
begin
 FAmbiente := AValue;
 if AValue=taProducao
  then FAmbienteCodigo := 1
  else FAmbienteCodigo := 2;
end;

{ TCertificadosConf }

{$IFNDEF ACBrNFSeOpenSSL}
function TCertificadosConf.GetCertificado: ICertificate2;
var
 Store          : IStore3;
 Certs          : ICertificates2;
 Cert           : ICertificate2;
 i              : Integer;
 xmldoc         : IXMLDOMDocument3;
 xmldsig        : IXMLDigitalSignature;
 dsigKey        : IXMLDSigKey;
 SigKey         : IXMLDSigKeyEx;
 PrivateKey     : IPrivateKey;
 hCryptProvider : HCRYPTPROV;
 XML            : String;
begin
 if NotaUtil.EstaVazio( FNumeroSerie )
  then raise Exception.Create('Número de Série do Certificado Digital não especificado !');

 Result := nil;
 Store := CoStore.Create;
 Store.Open(CAPICOM_CURRENT_USER_STORE, CAPICOM_STORE_NAME, CAPICOM_STORE_OPEN_MAXIMUM_ALLOWED);

 Certs := Store.Certificates as ICertificates2;
 for i:= 1 to Certs.Count do
  begin
   Cert := IInterface(Certs.Item[i]) as ICertificate2;
   if Cert.SerialNumber = FNumeroSerie
    then begin
     if NotaUtil.EstaVazio(NumCertCarregado)
      then NumCertCarregado := Cert.SerialNumber;

     if CertStoreMem = nil
      then begin
       CertStoreMem := CoStore.Create;
       CertStoreMem.Open(CAPICOM_MEMORY_STORE, 'Memoria', CAPICOM_STORE_OPEN_MAXIMUM_ALLOWED);
       CertStoreMem.Add(Cert);
      end;

     PrivateKey := Cert.PrivateKey;

     if (FSenhaCert <> '') and PrivateKey.IsHardwareDevice
      then begin
       PrivateKey := Cert.PrivateKey;

       XML := XML + '<Signature xmlns="http://www.w3.org/2000/09/xmldsig#">'+
                      '<SignedInfo>'+
                       '<CanonicalizationMethod Algorithm="http://www.w3.org/TR/2001/REC-xml-c14n-20010315"/>'+
                       '<SignatureMethod Algorithm="http://www.w3.org/2000/09/xmldsig#rsa-sha1" />'+
                       '<Reference URI="#">'+
                        '<Transforms>'+
                         '<Transform Algorithm="http://www.w3.org/2000/09/xmldsig#enveloped-signature" />'+
                         '<Transform Algorithm="http://www.w3.org/TR/2001/REC-xml-c14n-20010315" />'+
                        '</Transforms>'+
                        '<DigestMethod Algorithm="http://www.w3.org/2000/09/xmldsig#sha1" />'+
                        '<DigestValue>'+
                        '</DigestValue>'+
                       '</Reference>'+
                      '</SignedInfo>'+
                      '<SignatureValue>'+
                      '</SignatureValue>'+
                      '<KeyInfo>'+
                      '</KeyInfo>'+
                     '</Signature>';

       xmldoc := CoDOMDocument50.Create;
       xmldoc.async              := False;
       xmldoc.validateOnParse    := False;
       xmldoc.preserveWhiteSpace := True;
       xmldoc.loadXML(XML);
       xmldoc.setProperty('SelectionNamespaces', DSIGNS);

       xmldsig := CoMXDigitalSignature50.Create;
       xmldsig.signature := xmldoc.selectSingleNode('.//ds:Signature');
       xmldsig.store := CertStoreMem;

       dsigKey := xmldsig.createKeyFromCSP(PrivateKey.ProviderType, PrivateKey.ProviderName, PrivateKey.ContainerName, 0);
       if (dsigKey = nil)
        then raise Exception.Create('Erro ao criar a chave do CSP.');

       SigKey := dsigKey as IXMLDSigKeyEx;
       SigKey.getCSPHandle( hCryptProvider );

       try
        CryptSetProvParam( hCryptProvider , PP_SIGNATURE_PIN, LPBYTE(FSenhaCert), 0 );
       finally
        CryptReleaseContext(hCryptProvider, 0);
       end;

       SigKey  := nil;
       dsigKey := nil;
       xmldsig := nil;
       xmldoc  := nil;
      end;

     Result    := Cert;
     FDataVenc := Cert.ValidToDate;
     break;
    end;
  end;

 if not(Assigned(Result))
  then raise Exception.Create('Certificado Digital não encontrado!');
end;

function TCertificadosConf.GetNumeroSerie: AnsiString;
begin
 Result := Trim(UpperCase(StringReplace(FNumeroSerie,' ','',[rfReplaceAll] )));
end;

procedure TCertificadosConf.SetNumeroSerie(const Value: AnsiString);
begin
 FNumeroSerie := Trim(UpperCase(StringReplace(Value,' ','',[rfReplaceAll] )));
end;

function TCertificadosConf.SelecionarCertificado: AnsiString;
var
 Store  : IStore3;
 Certs  : ICertificates2;
 Certs2 : ICertificates2;
 Cert   : ICertificate2;
begin
 Store := CoStore.Create;
 Store.Open(CAPICOM_CURRENT_USER_STORE, CAPICOM_STORE_NAME, CAPICOM_STORE_OPEN_MAXIMUM_ALLOWED);

 Certs  := Store.Certificates as ICertificates2;
 Certs2 := Certs.Select('Certificado(s) Digital(is) disponível(is)', 'Selecione o Certificado Digital para uso no aplicativo', false);

 if not(Certs2.Count = 0)
  then begin
   Cert         := IInterface(Certs2.Item[1]) as ICertificate2;
   FNumeroSerie := Cert.SerialNumber;
   FDataVenc    := Cert.ValidToDate;
  end;

 Result := FNumeroSerie;
end;

function TCertificadosConf.GetDataVenc: TDateTime;
begin
 if NotaUtil.NaoEstaVazio(FNumeroSerie)
  then begin
   if FDataVenc = 0
    then GetCertificado;
   Result := FDataVenc;
  end
 else Result := 0;
end;
{$ENDIF}

procedure TWebServicesConf.SetConfigMunicipio(aPath: String = '');
var
 IniFile : String;
 Ini     : TIniFile;
begin
 if not NotaUtil.EstaVazio(aPath)
  then aPath := PathWithDelim(aPath);

 IniFile := aPath + 'Config_Municipios.ini';

 Ini := TIniFile.Create( IniFile );
 try
  if FAmbienteCodigo = 1
   then FNameSpace := ini.ReadString(IntToStr(FCodigoMunicipio), 'ProNameSpace', '')
   else FNameSpace := ini.ReadString(IntToStr(FCodigoMunicipio), 'HomNameSpace', '');
  FPrefixo2      := ini.ReadString(IntToStr(FCodigoMunicipio), 'Prefixo2',       '');
  FPrefixo3      := ini.ReadString(IntToStr(FCodigoMunicipio), 'Prefixo3',       '');
  FPrefixo4      := ini.ReadString(IntToStr(FCodigoMunicipio), 'Prefixo4',       '');
  FProvedor      := ini.ReadString(IntToStr(FCodigoMunicipio), 'Provedor',       '');
  FVersaoSoap    := ini.ReadString(IntToStr(FCodigoMunicipio), 'VersaoSoap',     '');
  FConfigSchemas := ini.ReadString(IntToStr(FCodigoMunicipio), 'Config_Schemas', '');
  FConfigURL     := ini.ReadString(IntToStr(FCodigoMunicipio), 'Config_URL',     '');
  FIdentificador := ini.ReadString(IntToStr(FCodigoMunicipio), 'Identificador',  'Id');

  TConfiguracoes( Self.Owner ).Certificados.AssinarRPS  := (ini.ReadString(IntToStr(FCodigoMunicipio), 'AssinarRPS',  'N') = 'S');
  TConfiguracoes( Self.Owner ).Certificados.AssinarLote := (ini.ReadString(IntToStr(FCodigoMunicipio), 'AssinarLote', 'N') = 'S');
 finally
  Ini.Free;
 end;

 if (FCodigoMunicipio>0) and (trim(FProvedor)='')
  then raise Exception.Create('Código do Municipio ['+ IntToStr(FCodigoMunicipio) +'] não Encontrado.');
end;

procedure TWebServicesConf.SetIntervaloTentativas(const Value: Cardinal);
begin
 if (Value > 0) and (Value < 1000)
  then FIntervaloTentativas := 1000
  else FIntervaloTentativas := Value;
end;

procedure TWebServicesConf.SetTentativas(const Value: Integer);
begin
 if Value <= 0
  then FTentativas := 18
  else FTentativas := Value;
end;

{ TArquivosConf }

constructor TArquivosConf.Create(AOwner: TComponent);
begin
 inherited;

end;

function TArquivosConf.GetPathCan: String;
var
 wDia, wMes, wAno : Word;
 Dir : String;
begin
 if NotaUtil.EstaVazio(FPathCan)
  then Dir := TConfiguracoes( Self.Owner ).Geral.PathSalvar
  else Dir := FPathCan;

 if FMensal
  then begin
   DecodeDate(Now, wAno, wMes, wDia);
   if Pos(IntToStr(wAno)+IntToStrZero(wMes,2),Dir) <= 0
    then Dir := PathWithDelim(Dir)+IntToStr(wAno)+IntToStrZero(wMes,2);
  end;

 if FLiteral
  then begin
   if copy(Dir,length(Dir)-2,3) <> 'Can'
    then Dir := PathWithDelim(Dir)+'Can';
  end;

 if not DirectoryExists(Dir)
  then ForceDirectories(Dir);

 Result := Dir;
end;

function TArquivosConf.GetPathNFSe(Data: TDateTime): String;
var
 wDia, wMes, wAno : Word;
 Dir : String;
begin
 if NotaUtil.EstaVazio(FPathNFSe)
  then Dir := TConfiguracoes( Self.Owner ).Geral.PathSalvar
  else Dir := FPathNFSe;

 if FMensal
  then begin
   if Data = 0
    then Data := Now;
   DecodeDate(Data, wAno, wMes, wDia);
   if Pos(IntToStr(wAno)+IntToStrZero(wMes,2),Dir) <= 0
    then Dir := PathWithDelim(Dir)+IntToStr(wAno)+IntToStrZero(wMes,2);
  end;

 if FLiteral
  then begin
   if copy(Dir,length(Dir)-2,3) <> 'NFSe'
    then Dir := PathWithDelim(Dir)+'NFSe';
  end;

 if not DirectoryExists(Dir)
  then ForceDirectories(Dir);

 Result := Dir;
end;

function TArquivosConf.GetPathRPS: String;
var
 wDia, wMes, wAno : Word;
 Dir : String;
begin
 if NotaUtil.EstaVazio(FPathRPS)
  then Dir := TConfiguracoes( Self.Owner ).Geral.PathSalvar
  else Dir := FPathRPS;

 if FMensal
  then begin
   DecodeDate(Now, wAno, wMes, wDia);
   if Pos(IntToStr(wAno)+IntToStrZero(wMes,2),Dir) <= 0
    then Dir := PathWithDelim(Dir)+IntToStr(wAno)+IntToStrZero(wMes,2);
  end;

 if FLiteral
  then begin
   if copy(Dir,length(Dir)-2,3) <> 'RPS'
    then Dir := PathWithDelim(Dir)+'RPS';
  end;

 if not DirectoryExists(Dir)
  then ForceDirectories(Dir);

 Result := Dir;
end;

function TArquivosConf.GetPathGer: String;
var
 wDia, wMes, wAno : Word;
 Dir : String;
begin
 if NotaUtil.EstaVazio(FPathGer)
  then Dir := TConfiguracoes( Self.Owner ).Geral.PathSalvar
  else Dir := FPathGer;

 if FMensal
  then begin
   DecodeDate(Now, wAno, wMes, wDia);
   if Pos(IntToStr(wAno)+IntToStrZero(wMes,2),Dir) <= 0
    then Dir := PathWithDelim(Dir)+IntToStr(wAno)+IntToStrZero(wMes,2);
  end;

 if FLiteral
  then begin
   if copy(Dir,length(Dir)-2,3) <> 'Ger'
    then Dir := PathWithDelim(Dir)+'Ger';
  end;

 if not DirectoryExists(Dir)
  then ForceDirectories(Dir);

 Result := Dir;
end;

end.
