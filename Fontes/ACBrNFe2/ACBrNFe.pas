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

unit ACBrNFe;

interface

uses
  Classes, Sysutils,
  pcnNFe, pcnConversao, pcnCCeNFe, pcnRetCCeNFe,
  pcnEnvEventoNFe, pcnRetEnvEventoNFe,
  pcnDownloadNFe,                      
  {$IFDEF CLX} QDialogs,{$ELSE} Dialogs,{$ENDIF}
  ACBrNFeNotasFiscais,
  ACBrNFeConfiguracoes,
  ACBrNFeWebServices, ACBrNFeUtil,
  ACBrNFeDANFEClass, ACBrUtil, Forms,
  smtpsend, ssl_openssl, mimemess, mimepart; // units para enviar email

const
  ACBRNFE_VERSAO = '0.4.0a';

type
  TACBrNFeAboutInfo = (ACBrNFeAbout);

  EACBrNFeException = class(Exception);

  // Evento para gerar log das mensagens do Componente
  TACBrNFeLog = procedure(const Mensagem : String) of object ;

  {Carta de Correção}
  TCartaCorrecao = Class(TComponent)
  private
    FCCe : TCCeNFe;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    property CCe   : TCCeNFe  read FCCe      write FCCe;
  end;

  {Download}
  TDownload = Class(TComponent)
  private
    FDownload : TDownloadNFe;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    property Download : TDownloadNFe read FDownload write FDownload;
  end;

  TACBrNFe = class(TComponent)
  private
    fsAbout: TACBrNFeAboutInfo;
    FDANFE : TACBrNFeDANFEClass;
    FNotasFiscais: TNotasFiscais;
    FCartaCorrecao: TCartaCorrecao;
    FEventoNFe: TEventoNFe;
    FDownloadNFe: TDownload;
    FWebServices: TWebServices;
    FConfiguracoes: TConfiguracoes;
    FStatus : TStatusACBrNFe;
    FOnStatusChange: TNotifyEvent;
    FOnGerarLog : TACBrNFeLog;
    procedure SetDANFE(const Value: TACBrNFeDANFEClass);
  protected
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function Enviar(ALote: Integer; Imprimir:Boolean = True): Boolean; overload;
    function Enviar(ALote: String; Imprimir:Boolean = True): Boolean; overload;
    function Cancelamento(AJustificativa:WideString): Boolean;
    function Consultar: Boolean;
    function EnviarCartaCorrecao(idLote : Integer): Boolean;
    function EnviarEventoNFe(idLote : Integer): Boolean;
    function ConsultaNFeDest(CNPJ: String;
                             IndNFe: TpcnIndicadorNFe;
                             IndEmi: TpcnIndicadorEmissor;
                             ultNSU: String): Boolean;
    function Download: Boolean;
    property WebServices: TWebServices read FWebServices write FWebServices;
    property NotasFiscais: TNotasFiscais read FNotasFiscais write FNotasFiscais;
    property CartaCorrecao: TCartaCorrecao read FCartaCorrecao write FCartaCorrecao;
    property EventoNFe: TEventoNFe read FEventoNFe write FEventoNFe;
    property DownloadNFe: TDownload read FDownloadNFe write FDownloadNFe; 
    property Status: TStatusACBrNFe read FStatus;
    procedure SetStatus( const stNewStatus : TStatusACBrNFe );

    procedure ImprimirEvento;
    procedure ImprimirEventoPDF;
    procedure EnviarEmailEvento(const sSmtpHost,
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

  procedure EnviaEmail(const sSmtpHost,
                                sSmtpPort,
                                sSmtpUser,
                                sSmtpPasswd,
                                sFrom,
                                sTo,
                                sAssunto: String;
                                sMensagem : TStrings;
                                SSL : Boolean;
                                sCC: TStrings = nil;
                                Anexos:TStrings=nil;
                                PedeConfirma: Boolean = False;
                                AguardarEnvio: Boolean = False;
                                NomeRemetente: String = '';
                                TLS : Boolean = True;
                                StreamNFe : TStringStream = nil;
                                NomeArq : String = '');

  published
    property Configuracoes: TConfiguracoes read FConfiguracoes write FConfiguracoes;
    property OnStatusChange: TNotifyEvent read FOnStatusChange write FOnStatusChange;
    property DANFE: TACBrNFeDANFEClass read FDANFE write SetDANFE ;
    property AboutACBrNFe : TACBrNFeAboutInfo read fsAbout write fsAbout
                          stored false ;
    property OnGerarLog : TACBrNFeLog read FOnGerarLog write FOnGerarLog ;
  end;

procedure ACBrAboutDialog ;

implementation

procedure ACBrAboutDialog ;
var Msg : String ;
begin
    Msg := 'Componente ACBrNFe2'+#10+
           'Versão: '+ACBRNFE_VERSAO+#10+#10+
           'Automação Comercial Brasil'+#10+#10+
           'http://acbr.sourceforge.net'+#10+#10+
           'Projeto Cooperar - PCN'+#10+#10+
           'http://www.projetocooperar.org/pcn/';
     MessageDlg(Msg ,mtInformation ,[mbOk],0) ;
end;

{ TACBrNFe }

constructor TACBrNFe.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  FConfiguracoes     := TConfiguracoes.Create( self );
  FConfiguracoes.Name:= 'Configuracoes' ;
  {$IFDEF COMPILER6_UP}
   FConfiguracoes.SetSubComponent( true );{ para gravar no DFM/XFM }
  {$ENDIF}

  FNotasFiscais      := TNotasFiscais.Create(Self,NotaFiscal);
  FNotasFiscais.Configuracoes := FConfiguracoes;
  FCartaCorrecao     := TCartaCorrecao.Create(Self);
  FEventoNFe         := TEventoNFe.Create;
  FDownloadNFe       := TDownload.Create(Self);
  FWebServices       := TWebServices.Create(Self);

  if FConfiguracoes.WebServices.Tentativas <= 0 then
     FConfiguracoes.WebServices.Tentativas := 5;
  {$IFDEF ACBrNFeOpenSSL}
    if FConfiguracoes.Geral.IniFinXMLSECAutomatico then
      NotaUtil.InitXmlSec ;
  {$ENDIF}
  FOnGerarLog := nil ;
end;

destructor TACBrNFe.Destroy;
begin
  FConfiguracoes.Free;
  FNotasFiscais.Free;
  FCartaCorrecao.Free;
  FEventoNFe.Free;
  FDownloadNFe.Free;
  FWebServices.Free;
  {$IFDEF ACBrNFeOpenSSL}
    if FConfiguracoes.Geral.IniFinXMLSECAutomatico then
      NotaUtil.ShutDownXmlSec ;
  {$ENDIF}
  inherited;
end;

procedure TACBrNFe.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);

  if (Operation = opRemove) and (FDANFE <> nil) and (AComponent is TACBrNFeDANFEClass) then
     FDANFE := nil ;
end;

procedure TACBrNFe.SetDANFE(const Value: TACBrNFeDANFEClass);
 Var OldValue: TACBrNFeDANFEClass ;
begin
  if Value <> FDANFE then
  begin
     if Assigned(FDANFE) then
        FDANFE.RemoveFreeNotification(Self);

     OldValue  := FDANFE ;   // Usa outra variavel para evitar Loop Infinito
     FDANFE    := Value;    // na remoção da associação dos componentes

     if Assigned(OldValue) then
        if Assigned(OldValue.ACBrNFe) then
           OldValue.ACBrNFe := nil ;

     if Value <> nil then
     begin
        Value.FreeNotification(self);
        Value.ACBrNFe := self ;
     end ;
  end ;
end;

procedure TACBrNFe.SetStatus( const stNewStatus : TStatusACBrNFe );
begin
  if ( stNewStatus <> FStatus ) then
  begin
    FStatus := stNewStatus;
    if Assigned(fOnStatusChange) then
      FOnStatusChange(Self);
  end;
end;

function TACBrNFe.Cancelamento(
  AJustificativa: WideString): Boolean;
var
  i : Integer;
begin
  if Self.NotasFiscais.Count = 0 then
   begin
      if Assigned(Self.OnGerarLog) then
         Self.OnGerarLog('ERRO: Nenhuma Nota Fiscal Eletrônica Informada!');
      raise EACBrNFeException.Create('Nenhuma Nota Fiscal Eletrônica Informada!');
   end;

  for i:= 0 to self.NotasFiscais.Count-1 do
  begin
    WebServices.Cancelamento.NFeChave := copy(self.NotasFiscais.Items[i].NFe.infNFe.ID, (length(self.NotasFiscais.Items[i].NFe.infNFe.ID)-44)+1, 44);
    WebServices.Consulta.NFeChave := WebServices.Cancelamento.NFeChave;
    WebServices.Cancela(AJustificativa);
  end;

  Result := true;
end;

function TACBrNFe.Consultar: Boolean;
var
  i : Integer;
begin
  if Self.NotasFiscais.Count = 0 then
   begin
     if Assigned(Self.OnGerarLog) then
        Self.OnGerarLog('ERRO: Nenhuma Nota Fiscal Eletrônica Informada!');
     raise EACBrNFeException.Create('Nenhuma Nota Fiscal Eletrônica Informada!');
   end;

  for i := 0 to Self.NotasFiscais.Count-1 do
  begin
    WebServices.Consulta.NFeChave := copy(self.NotasFiscais.Items[i].NFe.infNFe.ID, (length(self.NotasFiscais.Items[i].NFe.infNFe.ID)-44)+1, 44);
    WebServices.Consulta.Executar;
  end;
  Result := True;

end;

function TACBrNFe.Enviar(ALote: Integer; Imprimir:Boolean = True): Boolean;
begin
  Result := Enviar(IntToStr(ALote),Imprimir);
end;

function TACBrNFe.Enviar(ALote: String; Imprimir: Boolean): Boolean;
var
  i: Integer;
begin
  if NotasFiscais.Count <= 0 then
   begin
      if Assigned(Self.OnGerarLog) then
         Self.OnGerarLog('ERRO: Nenhuma NF-e adicionada ao Lote');
      raise EACBrNFeException.Create('ERRO: Nenhuma NF-e adicionada ao Lote');
     exit;
   end;

  if NotasFiscais.Count > 50 then
   begin
      if Assigned(Self.OnGerarLog) then
         Self.OnGerarLog('ERRO: Conjunto de NF-e transmitidas (máximo de 50 NF-e) excedido. Quantidade atual: '+IntToStr(NotasFiscais.Count));
      raise EACBrNFeException.Create('ERRO: Conjunto de NF-e transmitidas (máximo de 50 NF-e) excedido. Quantidade atual: '+IntToStr(NotasFiscais.Count));
     exit;
   end;
  NotasFiscais.Assinar;
  NotasFiscais.Valida;

  Result := WebServices.Envia(ALote);

  if DANFE <> nil then
  begin
     for i:= 0 to NotasFiscais.Count-1 do
     begin
       if NotasFiscais.Items[i].Confirmada and Imprimir then
       begin
          NotasFiscais.Items[i].Imprimir;
          if (DANFE.ClassName='TACBrNFeDANFERaveCB') then
            Break;
       end;
     end;
  end;
end;

function TACBrNFe.EnviarCartaCorrecao(idLote: Integer): Boolean;
begin
  if CartaCorrecao.CCe.Evento.Count <= 0 then
   begin
      if Assigned(Self.OnGerarLog) then
         Self.OnGerarLog('ERRO: Nenhuma CC-e adicionada ao Lote');
      raise EACBrNFeException.Create('ERRO: Nenhuma CC-e adicionada ao Lote');
     exit;
   end;

  if CartaCorrecao.CCe.Evento.Count > 20 then
   begin
      if Assigned(Self.OnGerarLog) then
         Self.OnGerarLog('ERRO: Conjunto de Eventos transmitidos (máximo de 20) excedido. Quantidade atual: '+IntToStr(CartaCorrecao.CCe.Evento.Count));
      raise EACBrNFeException.Create('ERRO: Conjunto de Eventos transmitidos (máximo de 20) excedido. Quantidade atual: '+IntToStr(CartaCorrecao.CCe.Evento.Count));
     exit;
   end;

  WebServices.CartaCorrecao.idLote := idLote;
  //if not(WebServices.CartaCorrecao.Executar) then
  Result := WebServices.CartaCorrecao.Executar;
  if not Result then
  begin
    if Assigned(Self.OnGerarLog) then
      Self.OnGerarLog(WebServices.CartaCorrecao.Msg);
    raise EACBrNFeException.Create(WebServices.CartaCorrecao.Msg);
  end;
end;

function TACBrNFe.EnviarEventoNFe(idLote: Integer): Boolean;
var
  i: integer;
begin
  if EventoNFe.Evento.Count <= 0 then
   begin
      if Assigned(Self.OnGerarLog) then
         Self.OnGerarLog('ERRO: Nenhum Evento adicionado ao Lote');
      raise EACBrNFeException.Create('ERRO: Nenhum Evento adicionado ao Lote');
     exit;
   end;

  if EventoNFe.Evento.Count > 20 then
   begin
      if Assigned(Self.OnGerarLog) then
         Self.OnGerarLog('ERRO: Conjunto de Eventos transmitidos (máximo de 20) excedido. Quantidade atual: '+IntToStr(EventoNFe.Evento.Count));
      raise EACBrNFeException.Create('ERRO: Conjunto de Eventos transmitidos (máximo de 20) excedido. Quantidade atual: '+IntToStr(EventoNFe.Evento.Count));
     exit;
   end;

  WebServices.EnvEvento.idLote := idLote;

  {Atribuir nSeqEvento, CNPJ, Chave e/ou Protocolo quando não especificar}
  for i:= 0 to EventoNFe.Evento.Count -1 do
  begin
    try
      if EventoNFe.Evento.Items[i].InfEvento.nSeqEvento = 0 then
        EventoNFe.Evento.Items[i].infEvento.nSeqEvento := 1;
      if trim(EventoNFe.Evento.Items[i].InfEvento.CNPJ) = '' then
        EventoNFe.Evento.Items[i].InfEvento.CNPJ := self.NotasFiscais.Items[i].NFe.Emit.CNPJCPF;
      if trim(EventoNFe.Evento.Items[i].InfEvento.chNfe) = '' then
        EventoNFe.Evento.Items[i].InfEvento.chNfe := copy(self.NotasFiscais.Items[i].NFe.infNFe.ID, (length(self.NotasFiscais.Items[i].NFe.infNFe.ID)-44)+1, 44);
      if trim(EventoNFe.Evento.Items[i].infEvento.detEvento.nProt) = '' then
      begin
        if EventoNFe.Evento.Items[i].infEvento.tpEvento = teCancelamento then
          EventoNFe.Evento.Items[i].infEvento.detEvento.nProt := self.NotasFiscais.Items[i].NFe.procNFe.nProt;
      end;
    except
    end;
  end;
  {**}

  Result := WebServices.EnvEvento.Executar;
  if not Result then
  begin
    if Assigned(Self.OnGerarLog) then
      Self.OnGerarLog(WebServices.EnvEvento.Msg);
    raise EACBrNFeException.Create(WebServices.EnvEvento.Msg);
  end;
end;

function TACBrNFe.ConsultaNFeDest(CNPJ: String; IndNFe: TpcnIndicadorNFe;
  IndEmi: TpcnIndicadorEmissor; ultNSU: String): Boolean;
begin
  WebServices.ConsNFeDest.CNPJ   := CNPJ;
  WebServices.ConsNFeDest.indNFe := IndNFe;
  WebServices.ConsNFeDest.indEmi := IndEmi;
  WebServices.ConsNFeDest.ultNSU := ultNSU;

  Result := WebServices.ConsNFeDest.Executar;
  if not Result then
  begin
    if Assigned(Self.OnGerarLog) then
      Self.OnGerarLog(WebServices.ConsNFeDest.Msg);
    raise EACBrNFeException.Create(WebServices.ConsNFeDest.Msg);
  end;
end;

function TACBrNFe.Download: Boolean;
begin
  Result := WebServices.DownloadNFe.Executar;
  if not Result then
  begin
    if Assigned(Self.OnGerarLog) then
      Self.OnGerarLog(WebServices.DownloadNFe.Msg);
    raise EACBrNFeException.Create(WebServices.DownloadNFe.Msg);
  end;
end;

procedure TACBrNFe.ImprimirEvento;
begin
  if not Assigned( DANFE ) then
     raise EACBrNFeException.Create('Componente DANFE não associado.')
  else
     DANFE.ImprimirEVENTO(nil);
end;

procedure TACBrNFe.ImprimirEventoPDF;
begin
  if not Assigned( DANFE ) then
     raise EACBrNFeException.Create('Componente DANFE não associado.')
  else
     DANFE.ImprimirEVENTOPDF(nil);
end;

procedure TACBrNFe.EnviaEmail(const sSmtpHost, sSmtpPort, sSmtpUser,
  sSmtpPasswd, sFrom, sTo, sAssunto: String; sMensagem: TStrings;
  SSL: Boolean; sCC, Anexos: TStrings; PedeConfirma,
  AguardarEnvio: Boolean; NomeRemetente: String; TLS: Boolean; StreamNFe : TStringStream; NomeArq : String);
var
 ThreadSMTP : TSendMailThread;
 m:TMimemess;
 p: TMimepart;
 i: Integer;
begin
 m:=TMimemess.create;

 ThreadSMTP := TSendMailThread.Create ;  // Não Libera, pois usa FreeOnTerminate := True ;
 try
    p := m.AddPartMultipart('mixed', nil);
    if sMensagem <> nil then
       m.AddPartText(sMensagem, p);

    if StreamNFe <> nil then
      m.AddPartBinary(StreamNFe,NomeArq, p);

    if assigned(Anexos) then
      for i := 0 to Anexos.Count - 1 do
      begin
        m.AddPartBinaryFromFile(Anexos[i], p);
      end;

    m.header.tolist.add(sTo);

    if Trim(NomeRemetente) <> '' then
      m.header.From := Format('%s<%s>', [NomeRemetente, sFrom])
    else
      m.header.From := sFrom;

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
    if not NotaUtil.EstaVazio( sSmtpPort ) then     // Usa default
       ThreadSMTP.smtp.TargetPort := sSmtpPort;

    ThreadSMTP.smtp.FullSSL := SSL;
    ThreadSMTP.smtp.AutoTLS := TLS;

    SetStatus( stNFeEmail );
    ThreadSMTP.Resume; // inicia a thread
    if AguardarEnvio then
    begin
      repeat
        Sleep(1000);
        Application.ProcessMessages;
      until ThreadSMTP.Terminado;
    end;
    SetStatus( stIdle );
 finally
    m.free;
 end;
end;

procedure TACBrNFe.EnviarEmailEvento(const sSmtpHost, sSmtpPort, sSmtpUser,
  sSmtpPasswd, sFrom, sTo, sAssunto: String; sMensagem: TStrings; SSL,
  EnviaPDF: Boolean; sCC, Anexos: TStrings; PedeConfirma,
  AguardarEnvio: Boolean; NomeRemetente: String; TLS: Boolean);
var
 NomeArq : String;
 i: Integer;
 AnexosEmail:TStrings ;
begin
 AnexosEmail := TStringList.Create;
 try
    AnexosEmail.Clear;
    if Anexos <> nil then
      AnexosEmail.Text := Anexos.Text;
   // AnexosEmail.Add('');
    if (EnviaPDF) then
    begin
       if DANFE <> nil then
       begin
          ImprimirEventoPDF;
          NomeArq := StringReplace(EventoNFe.Evento[0].InfEvento.id,'ID', '', [rfIgnoreCase]);
          NomeArq := PathWithDelim(DANFE.PathPDF)+NomeArq+'evento.pdf';
          AnexosEmail.Add(NomeArq);
       end;
    end;
    EnviaEmail(sSmtpHost,
                sSmtpPort,
                sSmtpUser,
                sSmtpPasswd,
                sFrom,
                sTo,
                sAssunto,
                sMensagem,
                SSL,
                sCC,
                AnexosEmail,
                PedeConfirma,
                AguardarEnvio,
                NomeRemetente,
                TLS);
 finally
    AnexosEmail.Free ;
 end;
end;

{ TCartaCorrecao }
constructor TCartaCorrecao.Create(AOwner: TComponent);
begin
  inherited;
  FCCe := TCCeNFe.Create;
end;

destructor TCartaCorrecao.Destroy;
begin
  FCCe.Free;
  inherited;
end;

{ TEnvEventoNFe }
{constructor TEnvEventoNFe.Create(AOwner: TComponent);
begin
  inherited;
  FEnvEventoNFe := TEventoNFe.Create;
end;

destructor TEnvEventoNFe.Destroy;
begin
  FEnvEventoNFe.Free;
  inherited;
end;  }

{procedure TEnvEventoNFe.Imprimir;
begin
  if not Assigned( TACBrNFe( Owner ).DANFE ) then
     raise EACBrNFeException.Create('Componente DANFE não associado.')
  else
     TACBrNFe( Owner ).DANFE.ImprimirEVENTO(nil);
end;

procedure TEnvEventoNFe.ImprimirPDF;
begin
  if not Assigned( TACBrNFe( Owner ).DANFE ) then
     raise EACBrNFeException.Create('Componente DANFE não associado.')
  else
     TACBrNFe( Owner ).DANFE.ImprimirEVENTOPDF(nil);
end;}

{ TDownload }
constructor TDownload.Create(AOwner: TComponent);
begin
  inherited;
  FDownload := TDownloadNFe.Create;
end;

destructor TDownload.Destroy;
begin
  FDownload.Free;
  inherited;
end;

end.
