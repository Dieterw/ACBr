{$I ACBr.inc}

unit ACBrNFSeNotasFiscais;

interface

uses
  Classes, Sysutils, Dialogs, Forms,
  ACBrNFSeUtil, ACBrNFSeConfiguracoes,
//  {$IFDEF FPC}
//     ACBrNFSeDMLaz,
//  {$ELSE}
     ACBrNFSeDANFSeClass,
//  {$ENDIF}
  smtpsend, ssl_openssl, mimemess, mimepart, // units para enviar email
  pnfsNFSe, pnfsNFSeR, pnfsNFSeW, pnfsConversao,
  pcnConversao, pcnAuxiliar, pcnLeitor;

type

 NotaFiscal = class(TCollectionItem)
  private
    FNFSe: TNFSe;
    FXML_Rps: AnsiString;
    FXML_Rps_Ass: AnsiString;
    FXML_LoteRps: AnsiString;
    FXML_LoteRps_Ass: AnsiString;
    FXML_NFSe: AnsiString;
    FConfirmada : Boolean;
    FMsg : AnsiString ;
    FAlertas: AnsiString;
    FNomeArq: String;
    FXML: AnsiString;
    function GetNFSeXML: AnsiString;
  public
    constructor Create(Collection2: TCollection); override;
    destructor Destroy; override;
    procedure Imprimir;
    procedure ImprimirPDF;
    function SaveToFile(CaminhoArquivo: string = ''): boolean;
    function SaveToStream(Stream: TStringStream): boolean;
    procedure EnviarEmail(const sSmtpHost,
                                sSmtpPort,
                                sSmtpUser,
                                sSmtpPasswd,
                                sFrom,
                                sTo,
                                sAssunto: String;
                                sMensagem : TStrings;
                                SSL : Boolean;
                                EnviaPDF: Boolean = true;
                                sCC: TStrings = nil;
                                Anexos:TStrings=nil;
                                PedeConfirma: Boolean = False;
                                AguardarEnvio: Boolean = False;
                                NomeRemetente: String = '';
                                TLS : Boolean = True);
    property NFSe: TNFSe  read FNFSe write FNFSe;
    property XML_Rps: AnsiString read FXML_Rps write FXML_Rps;
    property XML_Rps_Ass: AnsiString read FXML_Rps_Ass write FXML_Rps_Ass;
    property XML_LoteRps: AnsiString read FXML_LoteRps write FXML_LoteRps;
    property XML_LoteRps_Ass: AnsiString read FXML_LoteRps_Ass write FXML_LoteRps_Ass;
    property XML_NFSe: AnsiString read FXML_NFSe write FXML_NFSe;
    property Confirmada: Boolean  read FConfirmada write FConfirmada;
    property Msg: AnsiString  read FMsg write FMsg;
    property Alertas: AnsiString read FAlertas write FAlertas;
    property NomeArq: String read FNomeArq write FNomeArq;
    property XML: AnsiString  read GetNFSeXML write FXML;
  end;

 TNotasFiscais = class(TOwnedCollection)
  private
    FConfiguracoes : TConfiguracoes;
    FACBrNFSe : TComponent;

    FNumeroLote: string;
    FXML_Lote: AnsiString;
    FXML_Lote_Ass: AnsiString;

    function GetItem(Index: Integer): NotaFiscal;
    procedure SetItem(Index: Integer; const Value: NotaFiscal);
  public
    constructor Create(AOwner: TPersistent; ItemClass: TCollectionItemClass);

    procedure GerarRPS;
    procedure Assinar;
    function AssinarLoteRps(nLote:Integer; vLote: WideString): WideString;
    procedure Valida;
    procedure Imprimir;
    procedure ImprimirPDF;
    function  Add: NotaFiscal;
    function Insert(Index: Integer): NotaFiscal;
    property Items[Index: Integer]: NotaFiscal read GetItem  write SetItem;
    property Configuracoes: TConfiguracoes read FConfiguracoes  write FConfiguracoes;

    function GetNamePath: string; override ;
    function LoadFromFile(CaminhoArquivo: string): boolean;
    function LoadFromStream(Stream: TStringStream): boolean;
    function SaveToFile(PathArquivo: string = ''): boolean;

    property NumeroLote: String read FNumeroLote write FNumeroLote;
    property XML_Lote: AnsiString  read FXML_Lote write FXML_Lote;
    property XML_Lote_Ass: AnsiString  read FXML_Lote_Ass write FXML_Lote_Ass;

    property ACBrNFSe : TComponent read FACBrNFSe ;
  end;

  TSendMailThread = class(TThread)
  private
    FException : Exception;
    FOwner: NotaFiscal;
    procedure DoHandleException;
  public
    OcorreramErros: Boolean;
    Terminado: Boolean;
    smtp : TSMTPSend;
    sFrom : String;
    sTo : String;
    sCC : TStrings;
    slmsg_Lines : TStrings;
    constructor Create(AOwner: NotaFiscal);
    destructor Destroy; override;
  protected
    procedure Execute; override;
    procedure HandleException;
  end;

implementation

uses
 ACBrNFSe, ACBrUtil, pcnGerador;

{ NotaFiscal }

constructor NotaFiscal.Create(Collection2: TCollection);
begin
 inherited Create(Collection2);

 FNFSe        := TNFSe.Create;
 FXML_RPS     := '';
 FXML_RPS_Ass := '';
end;

destructor NotaFiscal.Destroy;
begin
 FNFSe.Free;

 inherited Destroy;
end;

procedure NotaFiscal.EnviarEmail(const sSmtpHost, sSmtpPort, sSmtpUser,
  sSmtpPasswd, sFrom, sTo, sAssunto: String; sMensagem: TStrings; SSL,
  EnviaPDF: Boolean; sCC, Anexos: TStrings; PedeConfirma,
  AguardarEnvio: Boolean; NomeRemetente: String; TLS: Boolean);
var
 ThreadSMTP : TSendMailThread;
 m          : TMimemess;
 p          : TMimepart;
 StreamNFSe : TStringStream;
 NomeArq    : String;
 i          : Integer;
begin
 m := TMimemess.create;

 ThreadSMTP := TSendMailThread.Create(Self);  // Não Libera, pois usa FreeOnTerminate := True ;
 StreamNFSe := TStringStream.Create('');
 try
  p := m.AddPartMultipart('mixed', nil);
  if sMensagem <> nil
   then m.AddPartText(sMensagem, p);
  SaveToStream(StreamNFSe);
  m.AddPartBinary(StreamNFSe, copy(NFSe.Numero, (length(NFSe.Numero) - 44) + 1, 44) + '-NFSe.xml', p);

  if (EnviaPDF)
   then begin
    if TACBrNFSe( TNotasFiscais( Collection ).ACBrNFSe ).DANFSE <> nil
     then begin
      TACBrNFSe( TNotasFiscais( Collection ).ACBrNFSe ).DANFSE.ImprimirDANFSEPDF(NFSe);
      NomeArq := StringReplace(NFSe.Numero, 'NFSe', '', [rfIgnoreCase]);
      NomeArq := PathWithDelim(TACBrNFSe( TNotasFiscais( Collection ).ACBrNFSe ).DANFSE.PathPDF) + NomeArq + '.pdf';
      m.AddPartBinaryFromFile(NomeArq, p);
     end;
   end;

  if assigned(Anexos) then
   for i := 0 to Anexos.Count - 1 do
    begin
     m.AddPartBinaryFromFile(Anexos[i], p);
    end;

  m.header.tolist.add(sTo);

  if Trim(NomeRemetente) <> ''
   then m.header.From := Format('%s<%s>', [NomeRemetente, sFrom])
   else m.header.From := sFrom;

  m.header.subject := sAssunto;
  m.Header.ReplyTo := sFrom;
  if PedeConfirma
   then m.Header.CustomHeaders.Add('Disposition-Notification-To: '+sFrom);
  m.EncodeMessage;

  ThreadSMTP.sFrom := sFrom;
  ThreadSMTP.sTo   := sTo;
  if sCC <> nil
   then ThreadSMTP.sCC.AddStrings(sCC);
  ThreadSMTP.slmsg_Lines.AddStrings(m.Lines);

  ThreadSMTP.smtp.UserName   := sSmtpUser;
  ThreadSMTP.smtp.Password   := sSmtpPasswd;
  ThreadSMTP.smtp.TargetHost := sSmtpHost;

  if not NotaUtil.EstaVazio( sSmtpPort )
   then ThreadSMTP.smtp.TargetPort := sSmtpPort; // Usa default

  ThreadSMTP.smtp.FullSSL := SSL;
  ThreadSMTP.smtp.AutoTLS := TLS;

  TACBrNFSe( TNotasFiscais( Collection ).ACBrNFSe ).SetStatus( stNFSeEmail );
  ThreadSMTP.Resume; // inicia a thread

  if AguardarEnvio
   then begin
    repeat
     Sleep(1000);
     Application.ProcessMessages;
    until ThreadSMTP.Terminado;
   end;

  TACBrNFSe( TNotasFiscais( Collection ).ACBrNFSe ).SetStatus( stNFSeIdle );
 finally
  m.free;
  StreamNFSe.Free;
 end;
end;

function NotaFiscal.GetNFSeXML: AnsiString;
var
 LocNFSeW : TNFSeW;
begin
 LocNFSeW := TNFSeW.Create(Self.NFSe);
 try
  LocNFSeW.Provedor      := TACBrNFSe( TNotasFiscais( Collection ).ACBrNFSe ).Configuracoes.WebServices.Provedor;
  LocNFSeW.Prefixo4      := TACBrNFSe( TNotasFiscais( Collection ).ACBrNFSe ).Configuracoes.WebServices.Prefixo4;
  LocNFSeW.Identificador := TACBrNFSe( TNotasFiscais( Collection ).ACBrNFSe ).Configuracoes.WebServices.Identificador;
  LocNFSeW.URL           := TACBrNFSe( TNotasFiscais( Collection ).ACBrNFSe ).Configuracoes.WebServices.URL;
  LocNFSeW.VersaoXML     := TACBrNFSe( TNotasFiscais( Collection ).ACBrNFSe ).Configuracoes.WebServices.VersaoXML;
  LocNFSeW.DefTipos      := TACBrNFSe( TNotasFiscais( Collection ).ACBrNFSe ).Configuracoes.WebServices.DefTipos;
  LocNFSeW.ServicoEnviar := TACBrNFSe( TNotasFiscais( Collection ).ACBrNFSe ).Configuracoes.WebServices.ServicoEnviar;

  LocNFSeW.GerarXml;
  Result := LocNFSeW.Gerador.ArquivoFormatoXML;
 finally
  LocNFSeW.Free;
 end;
end;

procedure NotaFiscal.Imprimir;
begin
 if not Assigned( TACBrNFSe( TNotasFiscais( Collection ).ACBrNFSe ).DANFSE )
  then raise Exception.Create('Componente DANFSE não associado.')
  else TACBrNFSe( TNotasFiscais( Collection ).ACBrNFSe ).DANFSE.ImprimirDANFSE(NFSe);
end;

procedure NotaFiscal.ImprimirPDF;
begin
 if not Assigned( TACBrNFSe( TNotasFiscais( Collection ).ACBrNFSe ).DANFSE )
  then raise Exception.Create('Componente DANFSE não associado.')
  else TACBrNFSe( TNotasFiscais( Collection ).ACBrNFSe ).DANFSE.ImprimirDANFSEPDF(NFSe);
end;

function NotaFiscal.SaveToFile(CaminhoArquivo: string): boolean;
var
 LocNFSeW : TNFSeW;
begin
 try
  Result   := True;
  LocNFSeW := TNFSeW.Create(NFSe);
  try
   LocNFSeW.Provedor      := TACBrNFSe( TNotasFiscais( Collection ).ACBrNFSe ).Configuracoes.WebServices.Provedor;
   LocNFSeW.Prefixo4      := TACBrNFSe( TNotasFiscais( Collection ).ACBrNFSe ).Configuracoes.WebServices.Prefixo4;
   LocNFSeW.Identificador := TACBrNFSe( TNotasFiscais( Collection ).ACBrNFSe ).Configuracoes.WebServices.Identificador;
   LocNFSeW.URL           := TACBrNFSe( TNotasFiscais( Collection ).ACBrNFSe ).Configuracoes.WebServices.URL;
   LocNFSeW.VersaoXML     := TACBrNFSe( TNotasFiscais( Collection ).ACBrNFSe ).Configuracoes.WebServices.VersaoXML;
   LocNFSeW.DefTipos      := TACBrNFSe( TNotasFiscais( Collection ).ACBrNFSe ).Configuracoes.WebServices.DefTipos;
   LocNFSeW.ServicoEnviar := TACBrNFSe( TNotasFiscais( Collection ).ACBrNFSe ).Configuracoes.WebServices.ServicoEnviar;
   LocNFSeW.GerarXml;

   if NotaUtil.EstaVazio(CaminhoArquivo)
    then CaminhoArquivo := NotaUtil.PathWithDelim(TACBrNFSe( TNotasFiscais( Collection ).ACBrNFSe ).Configuracoes.Arquivos.GetPathRPS) +
                            Self.NFSe.InfID.ID + '-Rps.xml';

   if NotaUtil.EstaVazio(CaminhoArquivo) or not DirectoryExists(ExtractFilePath(CaminhoArquivo))
    then raise Exception.Create('Caminho Inválido: ' + CaminhoArquivo);

   LocNFSeW.Gerador.SalvarArquivo(CaminhoArquivo);
   NomeArq := CaminhoArquivo;
  finally
   LocNFSeW.Free;
  end;
 except
  raise;
  Result := False;
 end;
end;

function NotaFiscal.SaveToStream(Stream: TStringStream): boolean;
var
 LocNFSeW : TNFSeW;
begin
 try
  Result   := True;
  LocNFSeW := TNFSeW.Create(NFSe);
  try
  (*
   LocNFSeW.Provedor      := TACBrNFSe( TNotasFiscais( Collection ).ACBrNFSe ).Configuracoes.WebServices.Provedor;
   LocNFSeW.Prefixo4      := TACBrNFSe( TNotasFiscais( Collection ).ACBrNFSe ).Configuracoes.WebServices.Prefixo4;
   LocNFSeW.Identificador := TACBrNFSe( TNotasFiscais( Collection ).ACBrNFSe ).Configuracoes.WebServices.Identificador;
   LocNFSeW.URL           := TACBrNFSe( TNotasFiscais( Collection ).ACBrNFSe ).Configuracoes.WebServices.URL;
   LocNFSeW.VersaoXML     := TACBrNFSe( TNotasFiscais( Collection ).ACBrNFSe ).Configuracoes.WebServices.VersaoXML;
   LocNFSeW.DefTipos      := TACBrNFSe( TNotasFiscais( Collection ).ACBrNFSe ).Configuracoes.WebServices.DefTipos;
   LocNFSeW.ServicoEnviar := TACBrNFSe( TNotasFiscais( Collection ).ACBrNFSe ).Configuracoes.WebServices.ServicoEnviar;
   LocNFSeW.GerarXml;
   Stream.WriteString(LocNFSeW.Gerador.ArquivoFormatoXML);
   *)
   if XML_NFSe <> ''
    then Stream.WriteString(XML_NFSe)
    else if XML_RPS <> ''
          then Stream.WriteString(XML_RPS)
          else Stream.WriteString('');
  finally
   LocNFSeW.Free;
  end;
 except
//  raise;
  Result := False;
 end;
end;

{ TNotasFiscais }

function TNotasFiscais.Add: NotaFiscal;
begin
 Result := NotaFiscal(inherited Add);
end;

procedure TNotasFiscais.Assinar;
var
 i         : Integer;
 vAssinada : AnsiString;
 LocNFSeW  : TNFSeW;
 Leitor    : TLeitor;
 FMsg      : AnsiString;
begin
 for i := 0 to Self.Count-1 do
  begin
   LocNFSeW := TNFSeW.Create(Self.Items[i].NFSe);
   try
    LocNFSeW.Provedor      := self.Configuracoes.WebServices.Provedor;
    LocNFSeW.Prefixo4      := self.Configuracoes.WebServices.Prefixo4;
    LocNFSeW.Identificador := self.Configuracoes.WebServices.Identificador;
    LocNFSeW.URL           := self.Configuracoes.WebServices.URL;
    LocNFSeW.VersaoXML     := self.Configuracoes.WebServices.VersaoXML;
    LocNFSeW.DefTipos      := self.Configuracoes.WebServices.DefTipos;
    LocNFSeW.ServicoEnviar := self.Configuracoes.WebServices.ServicoEnviar;
    LocNFSeW.GerarXml;
    Self.Items[i].Alertas := LocNFSeW.Gerador.ListaDeAlertas.Text;
    Self.Items[i].XML_Rps := LocNFSeW.Gerador.ArquivoFormatoXML;

    if FConfiguracoes.Geral.Salvar
     then FConfiguracoes.Geral.Save(NotaUtil.PathWithDelim(FConfiguracoes.Arquivos.GetPathRPS) + Self.Items[i].NFSe.InfID.ID+'-Rps2.xml', LocNFSeW.Gerador.ArquivoFormatoXML);

    if self.Configuracoes.Certificados.AssinaRPS
     then begin
      {$IFDEF ACBrNFSeOpenSSL}
        if not(NotaUtil.Assinar(LocNFSeW.Gerador.ArquivoFormatoXML,
                                FConfiguracoes.Certificados.Certificado,
                                FConfiguracoes.Certificados.Senha,
                                vAssinada, FMsg))
         then raise Exception.Create('Falha ao assinar Nota Fiscal de Serviço Eletrônica '+
                                     Self.Items[i].NFSe.IdentificacaoRps.Numero + FMsg);
      {$ELSE}
        // Alterado por Italo em 12/07/2012
        if not(NotaUtil.Assinar(LocNFSeW.Gerador.ArquivoFormatoXML,
                                FConfiguracoes.Certificados.GetCertificado,
                                vAssinada, FMsg, False,
                                FConfiguracoes.WebServices.Prefixo3,
                                FConfiguracoes.WebServices.Prefixo4,
                                FConfiguracoes.WebServices.Provedor))
         then raise Exception.Create('Falha ao assinar Nota Fiscal de Serviço Eletrônica '+
                                     Self.Items[i].NFSe.IdentificacaoRps.Numero + FMsg);
      {$ENDIF}

      vAssinada := StringReplace( vAssinada, '<'+ENCODING_UTF8_STD+'>', '', [rfReplaceAll] ) ;
      vAssinada := StringReplace( vAssinada, '<?xml version="1.0"?>', '', [rfReplaceAll] ) ;
     end
     else vAssinada := LocNFSeW.Gerador.ArquivoFormatoXML;

    Leitor       := TLeitor.Create;
    Leitor.Grupo := vAssinada;

    Self.Items[i].XML_Rps_Ass                    := vAssinada;
    Self.Items[i].NFSe.signature.URI             := Leitor.rAtributo('Reference URI=');
    Self.Items[i].NFSe.signature.DigestValue     := Leitor.rCampo(tcStr, 'DigestValue');
    Self.Items[i].NFSe.signature.SignatureValue  := Leitor.rCampo(tcStr, 'SignatureValue');
    Self.Items[i].NFSe.signature.X509Certificate := Leitor.rCampo(tcStr, 'X509Certificate');

    Leitor.Free;

    if FConfiguracoes.Geral.Salvar
     then FConfiguracoes.Geral.Save(NotaUtil.PathWithDelim(FConfiguracoes.Arquivos.GetPathRPS) + Self.Items[i].NFSe.InfID.ID+'-Rps.xml', vAssinada);

    if NotaUtil.NaoEstaVazio(Self.Items[i].NomeArq)
     then FConfiguracoes.Geral.Save(ExtractFileName(Self.Items[i].NomeArq), vAssinada, ExtractFilePath(Self.Items[i].NomeArq));

   finally
    LocNFSeW.Free;
   end;
  end;
end;

function TNotasFiscais.AssinarLoteRps(nLote:Integer; vLote: WideString): WideString;
var
 vAssinada : AnsiString;
// Leitor    : TLeitor;
 FMsg      : AnsiString;
begin
 try
  if FConfiguracoes.Certificados.AssinaLote
   then begin
    {$IFDEF ACBrNFSeOpenSSL}
      if not(NotaUtil.Assinar(vLote,
                              FConfiguracoes.Certificados.Certificado,
                              FConfiguracoes.Certificados.Senha,
                              vAssinada, FMsg, True))
       then raise Exception.Create('Falha ao assinar o Lote de RPS, '+ IntToStr(nLote) + FMsg);
    {$ELSE}
      // Alterado por Italo em 24/07/2012
      if not(NotaUtil.Assinar(vLote,
                              FConfiguracoes.Certificados.GetCertificado,
                              vAssinada, FMsg, True,
                              FConfiguracoes.WebServices.Prefixo3,
                              FConfiguracoes.WebServices.Prefixo4,
                              FConfiguracoes.WebServices.Provedor))
       then raise Exception.Create('Falha ao assinar o Lote de RPS, '+
                                     IntToStr(nLote) + FMsg);
    {$ENDIF}

    vAssinada := StringReplace( vAssinada, '<'+ENCODING_UTF8_STD+'>', '', [rfReplaceAll] ) ;
    vAssinada := StringReplace( vAssinada, '<?xml version="1.0"?>', '', [rfReplaceAll] ) ;
   end
   else vAssinada := vLote;

//  Leitor       := TLeitor.Create;
//  Leitor.Grupo := vAssinada;

  Self.Items[0].XML_LoteRps     := vLote;
  Self.Items[0].XML_LoteRps_Ass := vAssinada;

//  Self.Items[i].NFSe.signature.URI             := Leitor.rAtributo('Reference URI=');
//  Self.Items[i].NFSe.signature.DigestValue     := Leitor.rCampo(tcStr, 'DigestValue');
//  Self.Items[i].NFSe.signature.SignatureValue  := Leitor.rCampo(tcStr, 'SignatureValue');
//  Self.Items[i].NFSe.signature.X509Certificate := Leitor.rCampo(tcStr, 'X509Certificate');

//  Leitor.Free;

//  if FConfiguracoes.Geral.Salvar
//   then FConfiguracoes.Geral.Save(FConfiguracoes.Geral.PathSalvar+IntToStr(nLote)+'-Lote.xml', vAssinada);

//  if NotaUtil.NaoEstaVazio(Self.Items[i].NomeArq)
//   then FConfiguracoes.Geral.Save(ExtractFileName(Self.Items[i].NomeArq), vAssinada, ExtractFilePath(Self.Items[i].NomeArq));

 finally
  Result := vAssinada;
 end;
end;

constructor TNotasFiscais.Create(AOwner: TPersistent;
  ItemClass: TCollectionItemClass);
begin
 if not (AOwner is TACBrNFSe )
  then raise Exception.Create( 'AOwner deve ser do tipo TNFSe.') ;

 inherited;

 FNumeroLote   := '';
 FXML_Lote     := '';
 FXML_Lote_Ass := '';
 FACBrNFSe     := TACBrNFSe( AOwner ) ;
end;

procedure TNotasFiscais.GerarRPS;
var
 i        : Integer;
 LocNFSeW : TNFSeW;
begin
 for i := 0 to Self.Count-1 do
  begin
   LocNFSeW := TNFSeW.Create(Self.Items[i].NFSe);
   try
    LocNFSeW.Provedor      := self.Configuracoes.WebServices.Provedor;
    LocNFSeW.Prefixo4      := self.Configuracoes.WebServices.Prefixo4;
    LocNFSeW.Identificador := self.Configuracoes.WebServices.Identificador;
    LocNFSeW.URL           := Self.Configuracoes.WebServices.URL;
    LocNFSeW.VersaoXML     := self.Configuracoes.WebServices.VersaoXML;
    LocNFSeW.DefTipos      := self.Configuracoes.WebServices.DefTipos;
    LocNFSeW.ServicoEnviar := Self.Configuracoes.WebServices.ServicoEnviar;
    LocNFSeW.GerarXml;
    Self.Items[i].XML_RPS := LocNFSeW.Gerador.ArquivoFormatoXML;
    Self.Items[i].Alertas := LocNFSeW.Gerador.ListaDeAlertas.Text;
   finally
    LocNFSeW.Free;
   end;
  end;
end;

function TNotasFiscais.GetItem(Index: Integer): NotaFiscal;
begin
 Result := NotaFiscal(inherited Items[Index]);
end;

function TNotasFiscais.GetNamePath: string;
begin
 Result := 'NotaFiscal';
end;

procedure TNotasFiscais.Imprimir;
begin
 if not Assigned( TACBrNFSe( FACBrNFSe ).DANFSE )
  then raise Exception.Create('Componente DANFSE não associado.')
  else TACBrNFSe( FACBrNFSe ).DANFSE.ImprimirDANFSE(nil);
end;

procedure TNotasFiscais.ImprimirPDF;
begin
 if not Assigned( TACBrNFSe( FACBrNFSe ).DANFSE )
  then raise Exception.Create('Componente DANFSE não associado.')
  else TACBrNFSe( FACBrNFSe ).DANFSE.ImprimirDANFSEPDF(nil);
end;

function TNotasFiscais.Insert(Index: Integer): NotaFiscal;
begin
 Result := NotaFiscal(inherited Insert(Index));
end;

function TNotasFiscais.LoadFromFile(CaminhoArquivo: string): boolean;
var
 LocNFSeR : TNFSeR;
 ArquivoXML: TStringList;
 XML : AnsiString;
begin
 try
  ArquivoXML := TStringList.Create;
  ArquivoXML.LoadFromFile(CaminhoArquivo);
  Result := True;

  ArquivoXML.Text := StringReplace(StringReplace( ArquivoXML.Text, '&lt;', '<', [rfReplaceAll]), '&gt;', '>', [rfReplaceAll]);
  ArquivoXML.Text := NotaUtil.RetirarPrefixos(ArquivoXML.Text);

  if pos('</CompNfse>', ArquivoXML.Text) > 0
   then begin
    while pos('</CompNfse>', ArquivoXML.Text) > 0 do
     begin
      XML             := copy(ArquivoXML.Text, 1, pos('</CompNfse>', ArquivoXML.Text) + 10);
      ArquivoXML.Text := Trim(copy(ArquivoXML.Text, pos('</CompNfse>', ArquivoXML.Text) + 11, length(ArquivoXML.Text)));
      LocNFSeR        := TNFSeR.Create(Self.Add.NFSe);
      try
       LocNFSeR.Leitor.Arquivo := XML;
       LocNFSeR.VersaoXML      := NotaUtil.VersaoXML(XML);
//       LocNFSeR.Provedor       := FConfiguracoes.WebServices.Provedor;
       LocNFSeR.LerXml;
       Items[Self.Count-1].XML_NFSe := LocNFSeR.Leitor.Arquivo;
//       Items[Self.Count-1].XML_Rps := LocNFSeR.Leitor.Arquivo;
       Items[Self.Count-1].NomeArq := CaminhoArquivo;
      finally
       LocNFSeR.Free;
      end;
     end;
   end
   else begin
    if pos('</ComplNfse>', ArquivoXML.Text) > 0
     then begin
      while pos('</ComplNfse>', ArquivoXML.Text) > 0 do
       begin
        XML             := copy(ArquivoXML.Text, 1, pos('</ComplNfse>', ArquivoXML.Text) + 11);
        ArquivoXML.Text := Trim(copy(ArquivoXML.Text, pos('</ComplNfse>', ArquivoXML.Text) + 12, length(ArquivoXML.Text)));
        LocNFSeR        := TNFSeR.Create(Self.Add.NFSe);
        try
         LocNFSeR.Leitor.Arquivo := XML;
         LocNFSeR.VersaoXML      := NotaUtil.VersaoXML(XML);
//         LocNFSeR.Provedor       := FConfiguracoes.WebServices.Provedor;
         LocNFSeR.LerXml;
         Items[Self.Count-1].XML_NFSe := LocNFSeR.Leitor.Arquivo;
//         Items[Self.Count-1].XML_Rps := LocNFSeR.Leitor.Arquivo;
         Items[Self.Count-1].NomeArq := CaminhoArquivo;
        finally
         LocNFSeR.Free;
        end;
       end;
     end
     else begin
      if pos('</ListaRps>', ArquivoXML.Text) > 0
       then begin
        while pos('</Rps>',ArquivoXML.Text) > 0 do
         begin
          XML             := copy(ArquivoXML.Text, 1, pos('</Rps>', ArquivoXML.Text) + 5);
          ArquivoXML.Text := Trim(copy(ArquivoXML.Text, pos('</Rps>', ArquivoXML.Text) + 6, length(ArquivoXML.Text)));
          LocNFSeR        := TNFSeR.Create(Self.Add.NFSe);
          try
           LocNFSeR.Leitor.Arquivo := XML;
           LocNFSeR.VersaoXML      := NotaUtil.VersaoXML(XML);
//           LocNFSeR.Provedor       := FConfiguracoes.WebServices.Provedor;
           LocNFSeR.LerXml;
           Items[Self.Count-1].XML_Rps := LocNFSeR.Leitor.Arquivo;
           Items[Self.Count-1].NomeArq := CaminhoArquivo;
          finally
           LocNFSeR.Free;
          end;
         end;
       end
       else begin
        if pos('</Rps>', ArquivoXML.Text) > 0
         then begin
          while pos('</Rps>', ArquivoXML.Text) > 0 do
           begin
            XML             := copy(ArquivoXML.Text, 1, pos('</Rps>', ArquivoXML.Text) + 5);
            ArquivoXML.Text := Trim(copy(ArquivoXML.Text, pos('</Rps>',ArquivoXML.Text) + 6, length(ArquivoXML.Text)));
            LocNFSeR        := TNFSeR.Create(Self.Add.NFSe);
            try
             LocNFSeR.Leitor.Arquivo := XML;
             LocNFSeR.VersaoXML      := NotaUtil.VersaoXML(XML);
//             LocNFSeR.Provedor       := FConfiguracoes.WebServices.Provedor;
             LocNFSeR.LerXml;
             Items[Self.Count-1].XML_Rps := LocNFSeR.Leitor.Arquivo;
             Items[Self.Count-1].NomeArq := CaminhoArquivo;
            finally
             LocNFSeR.Free;
            end;
           end;
         end;
       end;
     end;
   end;

  ArquivoXML.Free;
 except
  raise;
  Result := False;
 end;
end;

function TNotasFiscais.LoadFromStream(Stream: TStringStream): boolean;
var
 LocNFSeR : TNFSeR;
 ArquivoXML: TStringList;
begin
 try
  Result     := True;
  LocNFSeR   := TNFSeR.Create(Self.Add.NFSe);
  ArquivoXML := TStringList.Create;
  try
   LocNFSeR.Leitor.CarregarArquivo(Stream);
   ArquivoXML.Text := LocNFSeR.Leitor.Arquivo;
   ArquivoXML.Text := StringReplace(StringReplace( ArquivoXML.Text, '&lt;', '<', [rfReplaceAll]), '&gt;', '>', [rfReplaceAll]);
   ArquivoXML.Text := NotaUtil.RetirarPrefixos(ArquivoXML.Text);

   LocNFSeR.VersaoXML := NotaUtil.VersaoXML(ArquivoXML.Text);
   LocNFSeR.Leitor.CarregarArquivo(TStringStream.Create(ArquivoXML.Text));
   LocNFSeR.LerXml;
   Items[Self.Count-1].XML_Rps := LocNFSeR.Leitor.Arquivo;
   GerarRPS;
  finally
   LocNFSeR.Free
  end;
  ArquivoXML.Free;
 except
  Result := False;
 end;
end;

function TNotasFiscais.SaveToFile(PathArquivo: string): boolean;
var
 i              : integer;
 CaminhoArquivo : String;
begin
 Result := True;
 try
  for i := 0 to TACBrNFSe( FACBrNFSe ).NotasFiscais.Count-1 do
   begin
    if NotaUtil.EstaVazio(PathArquivo)
     then PathArquivo := TACBrNFSe( FACBrNFSe ).Configuracoes.Geral.PathSalvar
     else PathArquivo := ExtractFilePath(PathArquivo);

    CaminhoArquivo := NotaUtil.PathWithDelim(PathArquivo) + (TACBrNFSe( FACBrNFSe ).NotasFiscais.NumeroLote)+'-LoteNFSe.xml';
    TACBrNFSe( FACBrNFSe ).NotasFiscais.Items[i].SaveToFile(CaminhoArquivo);
   end;
 except
  Result := False;
 end;
end;

procedure TNotasFiscais.SetItem(Index: Integer; const Value: NotaFiscal);
begin
 Items[Index].Assign(Value);
end;

procedure TNotasFiscais.Valida;
var
 i    : Integer;
 XML,
 FMsg : AnsiString;
begin
 for i := 0 to Self.Count-1 do
  begin

//   if pos('<Signature', Self.Items[i].XML_Rps_Ass {.XML_Rps}) = 0
//    then Assinar;

//   XML := '<Rps>' + RetornarConteudoEntre(Self.Items[i].XML_Rps_Ass, '<Rps', '</Rps>')+ '</Rps>';
   XML := Self.Items[i].XML_Rps;

   if not(NotaUtil.Valida(XML, FMsg,
                          Self.FConfiguracoes.Geral.PathSchemas,
                          Self.FConfiguracoes.WebServices.URL,
                          Self.FConfiguracoes.WebServices.ServicoEnviar))
    then raise Exception.Create('Falha na validação dos dados da nota ' +
                 Self.Items[i].NFSe.IdentificacaoRps.Numero + sLineBreak+Self.Items[i].Alertas+FMsg);
 end;
end;

{ TSendMailThread }

constructor TSendMailThread.Create(AOwner: NotaFiscal);
begin
 FOwner      := AOwner;
 smtp        := TSMTPSend.Create;
 slmsg_Lines := TStringList.Create;
 sCC         := TStringList.Create;
 sFrom       := '';
 sTo         := '';

 FreeOnTerminate := True;

  inherited Create(True);
end;

destructor TSendMailThread.Destroy;
begin
 slmsg_Lines.Free;
 sCC.Free;
 smtp.Free;

  inherited;
end;

procedure TSendMailThread.DoHandleException;
begin
 TACBrNFSe(TNotasFiscais(FOwner.GetOwner).ACBrNFSe).SetStatus( stNFSeIdle );

 FOwner.Alertas := FException.Message;

 if FException is Exception
  then Application.ShowException(FException)
  else SysUtils.ShowException(FException, nil);
end;

procedure TSendMailThread.Execute;
var
 I: integer;
begin
  inherited;

 try
  Terminado := False;
  try
   if not smtp.Login()
    then raise Exception.Create('SMTP ERROR: Login:' + smtp.EnhCodeString+sLineBreak+smtp.FullResult.Text);

   if not smtp.MailFrom( sFrom, Length(sFrom))
    then raise Exception.Create('SMTP ERROR: MailFrom:' + smtp.EnhCodeString+sLineBreak+smtp.FullResult.Text);

   if not smtp.MailTo(sTo)
    then raise Exception.Create('SMTP ERROR: MailTo:' + smtp.EnhCodeString+sLineBreak+smtp.FullResult.Text);

   if (sCC <> nil)
    then begin
     for I := 0 to sCC.Count - 1 do
      begin
       if not smtp.MailTo(sCC.Strings[i])
        then raise Exception.Create('SMTP ERROR: MailTo:' + smtp.EnhCodeString+sLineBreak+smtp.FullResult.Text);
      end;
    end;

   if not smtp.MailData(slmsg_Lines)
    then raise Exception.Create('SMTP ERROR: MailData:' + smtp.EnhCodeString+sLineBreak+smtp.FullResult.Text);

   if not smtp.Logout()
    then raise Exception.Create('SMTP ERROR: Logout:' + smtp.EnhCodeString+sLineBreak+smtp.FullResult.Text);
  finally
   try
    smtp.Sock.CloseSocket;
   except
   end ;
   Terminado := True;
  end;
 except
  Terminado := True;
  HandleException;
 end;
end;

procedure TSendMailThread.HandleException;
begin
 FException := Exception(ExceptObject);
 try
  // Não mostra mensagens de EAbort
  if not (FException is EAbort)
   then Synchronize(DoHandleException);
 finally
  FException := nil;
 end;
end;

end.
