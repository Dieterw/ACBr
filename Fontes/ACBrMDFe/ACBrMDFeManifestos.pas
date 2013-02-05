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

unit ACBrMDFeManifestos;

interface

uses
  Classes, Sysutils, Dialogs, Forms,
  ACBrMDFeUtil, ACBrMDFeConfiguracoes,
  {$IFDEF FPC}
     ACBrMDFeDMLaz,
  {$ELSE}
     ACBrMDFeDAMDFeClass,
  {$ENDIF}
  smtpsend, ssl_openssl, mimemess, mimepart, // units para enviar email
  pcnConversao, pcnAuxiliar, pcnLeitor,
  pmdfeMDFe, pmdfeMDFeR, pmdfeMDFeW;

type

  Manifesto = class(TCollectionItem)
  private
    FMDFe: TMDFe;
    FXML: AnsiString;
    FConfirmada : Boolean;
    FMsg : AnsiString ;
    FAlertas: AnsiString;
    FNomeArq: String;
    function GetMDFeXML: AnsiString;
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
    property MDFe: TMDFe  read FMDFe write FMDFe;
    property XML: AnsiString  read GetMDFeXML write FXML;
    property Confirmada: Boolean  read FConfirmada write FConfirmada;
    property Msg: AnsiString  read FMsg write FMsg;
    property Alertas: AnsiString read FAlertas write FAlertas;
    property NomeArq: String read FNomeArq write FNomeArq;
  end;

  TManifestos = class(TOwnedCollection)
  private
    FConfiguracoes : TConfiguracoes;
    FACBrMDFe : TComponent ;

    function GetItem(Index: Integer): Manifesto;
    procedure SetItem(Index: Integer; const Value: Manifesto);
  public
    constructor Create(AOwner: TPersistent; ItemClass: TCollectionItemClass);

    procedure GerarMDFe;
    procedure Assinar;
    procedure Valida;
    function ValidaAssinatura(out Msg : String) : Boolean;
    procedure Imprimir;
    procedure ImprimirPDF;
    function  Add: Manifesto;
    function Insert(Index: Integer): Manifesto;
    property Items[Index: Integer]: Manifesto read GetItem  write SetItem;
    property Configuracoes: TConfiguracoes read FConfiguracoes  write FConfiguracoes;

    function GetNamePath: string; override ;
    function LoadFromFile(CaminhoArquivo: string): boolean;
    function LoadFromStream(Stream: TStringStream): boolean;
    function SaveToFile(PathArquivo: string = ''): boolean;

    property ACBrMDFe : TComponent read FACBrMDFe ;
  end;

  TSendMailThread = class(TThread)
  private
    FException : Exception;
    // FOwner: Manifesto;
    procedure DoHandleException;
  public
    OcorreramErros: Boolean;
    Terminado: Boolean;
    smtp : TSMTPSend;
    sFrom : String;
    sTo : String;
    sCC : TStrings;
    slmsg_Lines : TStrings;
    constructor Create(AOwner: Manifesto);
    destructor Destroy ; override ;
  protected
    procedure Execute; override;
    procedure HandleException;
  end;


implementation

uses
  ACBrMDFe, ACBrUtil, ACBrDFeUtil, pcnGerador;

{ Manifesto }

constructor Manifesto.Create(Collection2: TCollection);
begin
  inherited Create(Collection2);

  FMDFe := TMDFe.Create;

  FMDFe.Ide.modelo  := '58';
  FMDFe.Ide.verProc := 'ACBrMDFe';
  FMDFe.Ide.tpAmb   := TACBrMDFe( TManifestos( Collection ).ACBrMDFe ).Configuracoes.WebServices.Ambiente;
  FMDFe.Ide.tpEmis  := TACBrMDFe( TManifestos( Collection ).ACBrMDFe ).Configuracoes.Geral.FormaEmissao;
end;

destructor Manifesto.Destroy;
begin
  FMDFe.Free;
  inherited Destroy;
end;

procedure Manifesto.Imprimir;
begin
  if not Assigned( TACBrMDFe( TManifestos( Collection ).ACBrMDFe ).DAMDFe ) then
     raise Exception.Create('Componente DAMDFe não associado.')
  else
     TACBrMDFe( TManifestos( Collection ).ACBrMDFe ).DAMDFe.ImprimirDAMDFe(MDFe);
end;

procedure Manifesto.ImprimirPDF;
begin
  if not Assigned( TACBrMDFe( TManifestos( Collection ).ACBrMDFe ).DAMDFe ) then
     raise Exception.Create('Componente DAMDFe não associado.')
  else
     TACBrMDFe( TManifestos( Collection ).ACBrMDFe ).DAMDFe.ImprimirDAMDFePDF(MDFe);
end;

function Manifesto.SaveToFile(CaminhoArquivo: string = ''): boolean;
var
  LocMDFeW : TMDFeW;
begin
  try
     Result  := True;
     LocMDFeW := TMDFeW.Create(MDFe);
     try
        LocMDFeW.GerarXml;
        if DFeUtil.EstaVazio(CaminhoArquivo) then
           CaminhoArquivo := PathWithDelim(TACBrMDFe( TManifestos( Collection ).ACBrMDFe ).Configuracoes.Geral.PathSalvar)+copy(MDFe.inFMDFe.ID, (length(MDFe.inFMDFe.ID)-44)+1, 44)+'-mdfe.xml';
        if DFeUtil.EstaVazio(CaminhoArquivo) or not DirectoryExists(ExtractFilePath(CaminhoArquivo)) then
           raise Exception.Create('Caminho Inválido: ' + CaminhoArquivo);
        LocMDFeW.Gerador.SalvarArquivo(CaminhoArquivo);
        NomeArq := CaminhoArquivo;
     finally
        LocMDFeW.Free;
     end;
  except
     raise;
     Result := False;
  end;
end;

function Manifesto.SaveToStream(Stream: TStringStream): boolean;
var
  LocMDFeW : TMDFeW;
begin
  try
     Result  := True;
     LocMDFeW := TMDFeW.Create(MDFe);
     try
        LocMDFeW.GerarXml;
        Stream.WriteString(LocMDFeW.Gerador.ArquivoFormatoXML);
     finally
        LocMDFeW.Free;
     end;
  except
     Result := False;
  end;
end;

procedure Manifesto.EnviarEmail(const sSmtpHost,
                                      sSmtpPort,
                                      sSmtpUser,
                                      sSmtpPasswd,
                                      sFrom,
                                      sTo,
                                      sAssunto: String;
                                      sMensagem : TStrings;
                                      SSL : Boolean;
                                      EnviaPDF: Boolean = true;
                                      sCC: TStrings=nil;
                                      Anexos:TStrings=nil;
                                      PedeConfirma: Boolean = False;
                                      AguardarEnvio: Boolean = False;
                                      NomeRemetente: String = '';
                                      TLS : Boolean = True);
var
 ThreadSMTP : TSendMailThread;
 m          : TMimemess;
 p          : TMimepart;
 StreamMDFe  : TStringStream;
 NomeArq    : String;
 i          : Integer;
begin
 m:=TMimemess.create;
 ThreadSMTP := TSendMailThread.Create(Self);  // Não Libera, pois usa FreeOnTerminate := True ;
 StreamMDFe  := TStringStream.Create('');
 try
    p := m.AddPartMultipart('mixed', nil);
    if sMensagem <> nil then
       m.AddPartText(sMensagem, p);
    SaveToStream(StreamMDFe) ;
    m.AddPartBinary(StreamMDFe,copy(MDFe.infMDFe.ID, (length(MDFe.infMDFe.ID)-44)+1, 44)+'-mdfe.xml', p);
    if (EnviaPDF) then
    begin
       if TACBrMDFe( TManifestos( Collection ).ACBrMDFe ).DAMDFe <> nil then
       begin
          TACBrMDFe( TManifestos( Collection ).ACBrMDFe ).DAMDFe.ImprimirDAMDFePDF(MDFe);
          NomeArq :=  StringReplace(MDFe.infMDFe.ID,'MDFe', '', [rfIgnoreCase]);
          NomeArq := PathWithDelim(TACBrMDFe( TManifestos( Collection ).ACBrMDFe ).DAMDFe.PathPDF)+NomeArq+'.pdf';
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

    m.header.subject:= sAssunto;
    m.Header.ReplyTo := sFrom;
    if PedeConfirma then
       m.Header.CustomHeaders.Add('Disposition-Notification-To: '+sFrom);
    m.EncodeMessage;

    ThreadSMTP.sFrom := sFrom;
    ThreadSMTP.sTo   := sTo;
    if sCC <> nil then
       ThreadSMTP.sCC.AddStrings(sCC);
    ThreadSMTP.slmsg_Lines.AddStrings(m.Lines);

    ThreadSMTP.smtp.UserName := sSmtpUser;
    ThreadSMTP.smtp.Password := sSmtpPasswd;

    ThreadSMTP.smtp.TargetHost := sSmtpHost;
    if not DFeUtil.EstaVazio( sSmtpPort ) then     // Usa default
       ThreadSMTP.smtp.TargetPort := sSmtpPort;

    ThreadSMTP.smtp.FullSSL := SSL;
    ThreadSMTP.smtp.AutoTLS := TLS;
//    TACBrMDFe( TManifestos( Collection ).ACBrMDFe ).SetStatus( stMDFeEmail );

    ThreadSMTP.Resume; // inicia a thread
    if AguardarEnvio then
     begin
      repeat
       Sleep(1000);
       Application.ProcessMessages;
      until ThreadSMTP.Terminado;
     end;
    TACBrMDFe( TManifestos( Collection ).ACBrMDFe ).SetStatus( stMDFeIdle );

 finally
    m.free;
    StreamMDFe.Free ;
 end;
end;

function Manifesto.GetMDFeXML: AnsiString;
var
 LocMDFeW : TMDFeW;
begin
 LocMDFeW := TMDFeW.Create(Self.MDFe);
 try
    LocMDFeW.GerarXml;
    Result := LocMDFeW.Gerador.ArquivoFormatoXML;
 finally
    LocMDFeW.Free;
 end;
end;

{ TManifestos }
constructor TManifestos.Create(AOwner: TPersistent;
  ItemClass: TCollectionItemClass);
begin
  if not (AOwner is TACBrMDFe ) then
     raise Exception.Create( 'AOwner deve ser do tipo TACBrMDFe') ;

  inherited;

  FACBrMDFe := TACBrMDFe( AOwner ) ;
end;


function TManifestos.Add: Manifesto;
begin
  Result := Manifesto(inherited Add);

  Result.MDFe.Ide.tpAmb := Configuracoes.WebServices.Ambiente ;
end;

procedure TManifestos.Assinar;
var
  i: Integer;
  vAssinada : AnsiString;
  LocMDFeW : TMDFeW;
  Leitor: TLeitor;
  FMsg : AnsiString;
begin
  for i:= 0 to Self.Count-1 do
   begin
     LocMDFeW := TMDFeW.Create(Self.Items[i].MDFe);
     try
        LocMDFeW.GerarXml;
        Self.Items[i].Alertas := LocMDFeW.Gerador.ListaDeAlertas.Text;
{$IFDEF ACBrMDFeOpenSSL}
        if not(MDFeUtil.Assinar(LocMDFeW.Gerador.ArquivoFormatoXML, FConfiguracoes.Certificados.Certificado , FConfiguracoes.Certificados.Senha, vAssinada, FMsg)) then
           raise Exception.Create('Falha ao assinar Manifesto Eletrônico de Documentos Fiscais '+
                                   IntToStr(Self.Items[i].MDFe.Ide.cCT)+FMsg);
{$ELSE}
        if not(MDFeUtil.Assinar(LocMDFeW.Gerador.ArquivoFormatoXML, FConfiguracoes.Certificados.GetCertificado , vAssinada, FMsg)) then
           raise Exception.Create('Falha ao assinar Manifesto Eletrônico de Documentos Fiscais '+
                                   IntToStr(Self.Items[i].MDFe.Ide.cMDF)+FMsg);
{$ENDIF}
        vAssinada := StringReplace( vAssinada, '<'+ENCODING_UTF8_STD+'>', '', [rfReplaceAll] ) ;
        vAssinada := StringReplace( vAssinada, '<?xml version="1.0"?>', '', [rfReplaceAll] ) ;
        Self.Items[i].XML := vAssinada;

        Leitor := TLeitor.Create;
        leitor.Grupo := vAssinada;
        Self.Items[i].MDFe.signature.URI := Leitor.rAtributo('Reference URI=');
        Self.Items[i].MDFe.signature.DigestValue := Leitor.rCampo(tcStr, 'DigestValue');
        Self.Items[i].MDFe.signature.SignatureValue := Leitor.rCampo(tcStr, 'SignatureValue');
        Self.Items[i].MDFe.signature.X509Certificate := Leitor.rCampo(tcStr, 'X509Certificate');
        Leitor.Free;

        if FConfiguracoes.Geral.Salvar then
           FConfiguracoes.Geral.Save(StringReplace(Self.Items[i].MDFe.infMDFe.ID, 'MDFe', '', [rfIgnoreCase])+'-mdfe.xml', vAssinada);

        if DFeUtil.NaoEstaVazio(Self.Items[i].NomeArq) then
           FConfiguracoes.Geral.Save(ExtractFileName(Self.Items[i].NomeArq), vAssinada, ExtractFilePath(Self.Items[i].NomeArq));
     finally
        LocMDFeW.Free;
     end;
   end;

end;

procedure TManifestos.GerarMDFe;
var
 i: Integer;
 LocMDFeW : TMDFeW;
begin
 for i:= 0 to Self.Count-1 do
  begin
    LocMDFeW := TMDFeW.Create(Self.Items[i].MDFe);
    try
       LocMDFeW.GerarXml;
       Self.Items[i].XML     := LocMDFeW.Gerador.ArquivoFormatoXML;
       Self.Items[i].Alertas := LocMDFeW.Gerador.ListaDeAlertas.Text;
    finally
       LocMDFeW.Free;
    end;
  end;
end;

function TManifestos.GetItem(Index: Integer): Manifesto;
begin
  Result := Manifesto(inherited Items[Index]);
end;

function TManifestos.GetNamePath: string;
begin
  Result := 'Manifesto';
end;

procedure TManifestos.Imprimir;
begin
  if not Assigned( TACBrMDFe( FACBrMDFe ).DAMDFe ) then
     raise Exception.Create('Componente DAMDFe não associado.')
  else
     TACBrMDFe( FACBrMDFe ).DAMDFe.ImprimirDAMDFe(nil);
end;

procedure TManifestos.ImprimirPDF;
begin
  if not Assigned( TACBrMDFe( FACBrMDFe ).DAMDFe ) then
     raise Exception.Create('Componente DAMDFe não associado.')
  else
     TACBrMDFe( FACBrMDFe ).DAMDFe.ImprimirDAMDFePDF(nil);
end;

function TManifestos.Insert(Index: Integer): Manifesto;
begin
  Result := Manifesto(inherited Insert(Index));
end;

procedure TManifestos.SetItem(Index: Integer; const Value: Manifesto);
begin
  Items[Index].Assign(Value);
end;

procedure TManifestos.Valida;
var
 i: Integer;
 FMsg : AnsiString;
begin
  for i:= 0 to Self.Count-1 do
   begin
     if pos('<Signature',Self.Items[i].XML) = 0 then
        Assinar;
     if not(MDFeUtil.Valida(('<MDFe xmlns' +
        RetornarConteudoEntre(Self.Items[i].XML, '<MDFe xmlns', '</MDFe>')+ '</MDFe>'),
         FMsg, Self.FConfiguracoes.Geral.PathSchemas)) then
       raise Exception.Create('Falha na validação dos dados do Manifesto '+
                    IntToStr(Self.Items[i].MDFe.Ide.nMDF) +
                    sLineBreak + Self.Items[i].Alertas + FMsg);
  end;
end;

function TManifestos.ValidaAssinatura(out Msg : String) : Boolean;
var
 i: Integer;
 FMsg : AnsiString;
begin
  Result := True;
  for i:= 0 to Self.Count-1 do
   begin
     if not(MDFeUtil.ValidaAssinatura(('<MDFe xmlns' + RetornarConteudoEntre(Self.Items[i].XML, '<MDFe xmlns', '</MDFe>')+ '</MDFe>'), FMsg)) then
      begin
        Result := False;
        Msg := 'Falha na validação da assinatura do Manifesto '+
                               IntToStr(Self.Items[i].MDFe.Ide.nMDF)+sLineBreak+FMsg
      end
     else
       Result := True;
  end;
end;

function TManifestos.LoadFromFile(CaminhoArquivo: string): boolean;
var
 LocMDFeR : TMDFeR;
 ArquivoXML: TStringList;
 XML : AnsiString;
begin
 try
    ArquivoXML := TStringList.Create;
    ArquivoXML.LoadFromFile(CaminhoArquivo);
    Result := True;
    while pos('</MDFe>',ArquivoXML.Text) > 0 do
     begin
       if pos('</mdfeProc>',ArquivoXML.Text) > 0  then
        begin
          XML := copy(ArquivoXML.Text,1,pos('</mdfeProc>',ArquivoXML.Text)+5);
          ArquivoXML.Text := Trim(copy(ArquivoXML.Text,pos('</mdfeProc>',ArquivoXML.Text)+10,length(ArquivoXML.Text)));
        end
       else
        begin
          XML := copy(ArquivoXML.Text,1,pos('</MDFe>',ArquivoXML.Text)+5);
          ArquivoXML.Text := Trim(copy(ArquivoXML.Text,pos('</MDFe>',ArquivoXML.Text)+6,length(ArquivoXML.Text)));
        end;
       LocMDFeR := TMDFeR.Create(Self.Add.MDFe);
       try
          LocMDFeR.Leitor.Arquivo := XML;
          LocMDFeR.LerXml;
          Items[Self.Count-1].XML := LocMDFeR.Leitor.Arquivo;
          Items[Self.Count-1].NomeArq := CaminhoArquivo;
          GerarMDFe;
       finally
          LocMDFeR.Free;
       end;
     end;
    ArquivoXML.Free;
 except
    raise;
    Result := False;
 end;
end;

function TManifestos.LoadFromStream(Stream: TStringStream): boolean;
var
 LocMDFeR : TMDFeR;
begin
  try
    Result  := True;
    LocMDFeR := TMDFeR.Create(Self.Add.MDFe);
    try
       LocMDFeR.Leitor.CarregarArquivo(Stream);
       LocMDFeR.LerXml;
       Items[Self.Count-1].XML := LocMDFeR.Leitor.Arquivo;
       GerarMDFe;
    finally
       LocMDFeR.Free
    end;
  except
    Result := False;
  end;
end;

function TManifestos.SaveToFile(PathArquivo: string = ''): boolean;
var
 i : integer;
 CaminhoArquivo : String;
begin
 Result := True;
 try
    for i:= 0 to TACBrMDFe( FACBrMDFe ).Manifestos.Count-1 do
     begin
        if DFeUtil.EstaVazio(PathArquivo) then
           PathArquivo := TACBrMDFe( FACBrMDFe ).Configuracoes.Geral.PathSalvar
        else
           PathArquivo := ExtractFilePath(PathArquivo);
        CaminhoArquivo := PathWithDelim(PathArquivo)+copy(TACBrMDFe( FACBrMDFe ).Manifestos.Items[i].MDFe.inFMDFe.ID, (length(TACBrMDFe( FACBrMDFe ).Manifestos.Items[i].MDFe.inFMDFe.ID)-44)+1, 44)+'-mdfe.xml';
        TACBrMDFe( FACBrMDFe ).Manifestos.Items[i].SaveToFile(CaminhoArquivo)
     end;
 except
    Result := False;
 end;
end;

{ TSendMailThread }

procedure TSendMailThread.DoHandleException;
begin
  // TACBrMDFe(TManifestos(FOwner.GetOwner).ACBrMDFe).SetStatus( stMDFeIdle );

  // FOwner.Alertas := FException.Message;

  if FException is Exception then
    Application.ShowException(FException)
  else
    SysUtils.ShowException(FException, nil);
end;

constructor TSendMailThread.Create(AOwner: Manifesto);
begin
  // FOwner      := AOwner;
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

procedure TSendMailThread.Execute;
var
 i: integer;
begin
  inherited;

  try
    Terminado := False;
    try
      if not smtp.Login() then
        raise Exception.Create('SMTP ERROR: Login:' + smtp.EnhCodeString+sLineBreak+smtp.FullResult.Text);

      if not smtp.MailFrom( sFrom, Length(sFrom)) then
        raise Exception.Create('SMTP ERROR: MailFrom:' + smtp.EnhCodeString+sLineBreak+smtp.FullResult.Text);

      if not smtp.MailTo(sTo) then
        raise Exception.Create('SMTP ERROR: MailTo:' + smtp.EnhCodeString+sLineBreak+smtp.FullResult.Text);

      if (sCC <> nil) then
      begin
        for I := 0 to sCC.Count - 1 do
        begin
          if not smtp.MailTo(sCC.Strings[i]) then
            raise Exception.Create('SMTP ERROR: MailTo:' + smtp.EnhCodeString+sLineBreak+smtp.FullResult.Text);
        end;
      end;

      if not smtp.MailData(slmsg_Lines) then
        raise Exception.Create('SMTP ERROR: MailData:' + smtp.EnhCodeString+sLineBreak+smtp.FullResult.Text);

      if not smtp.Logout() then
        raise Exception.Create('SMTP ERROR: Logout:' + smtp.EnhCodeString+sLineBreak+smtp.FullResult.Text);
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
    if not (FException is EAbort) then
      Synchronize(DoHandleException);
  finally
    FException := nil;
  end;
end;

end.
