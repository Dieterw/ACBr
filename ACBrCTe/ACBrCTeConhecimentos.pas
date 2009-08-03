{******************************************************************************}
{ Projeto: Componente ACBrCTe                                                  }
{  Biblioteca multiplataforma de componentes Delphi para emissão de Nota Fiscal}
{ eletrônica - CTe - http://www.CTe.fazenda.gov.br                          }
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
|* 28/07/2009: Andre F. Moraes
|*  - Inicio do componente ACBrCTe baseado no componente ACBrCTePCN
******************************************************************************}
{$I ACBr.inc}

unit ACBrCTeConhecimentos;

interface

uses
  Classes, Sysutils, Dialogs,
  ACBrNFeUtil, ACBrCTeUtil, ACBrCTeConfiguracoes,
  {$IFDEF FPC}
     ACBrCTeDMLaz,
  {$ELSE}
//     ACBrCTeDACTEClass,
  {$ENDIF}
  smtpsend, ssl_openssl, mimemess, mimepart, // units para enviar email
  pcteCTe, pcteCTeR, pcteCTeW,
  pcnConversao;

type

  Conhecimento = class(TCollectionItem)
  private
    FCTe: TCTe;
    FXML: AnsiString;
    FConfirmada : Boolean;
    FMsg : AnsiString ;
    FAlertas: AnsiString;
  public
    constructor Create(Collection2: TCollection); override;
    destructor Destroy; override;
    procedure Imprimir;
    procedure ImprimirPDF;
    function SaveToFile(CaminhoArquivo: string = ''): boolean;
    function SaveToStream(Stream: TStringStream): boolean;
    procedure EnviarEmail(const sSmtpHost, sSmtpPort, sSmtpUser, sSmtpPasswd, sFrom, sTo, sAssunto: String; sMensagem : TStrings; SSL : Boolean; EnviaPDF: Boolean = true);
    property CTe: TCTe  read FCTe write FCTe;
    property XML: AnsiString  read FXML write FXML;
    property Confirmada: Boolean  read FConfirmada write FConfirmada;
    property Msg: AnsiString  read FMsg write FMsg;
    property Alertas: AnsiString read FAlertas write FAlertas;
  end;

  TConhecimentos = class(TOwnedCollection)
  private
    FConfiguracoes : TConfiguracoes;
    FACBrCTe : TComponent ;

    function GetItem(Index: Integer): Conhecimento;
    procedure SetItem(Index: Integer; const Value: Conhecimento);
  public
    constructor Create(AOwner: TPersistent; ItemClass: TCollectionItemClass);

    procedure GerarCTe;
    procedure Assinar;
    procedure Valida;
    procedure Imprimir;
    procedure ImprimirPDF;
    function  Add: Conhecimento;
    function Insert(Index: Integer): Conhecimento;
    property Items[Index: Integer]: Conhecimento read GetItem  write SetItem;
    property Configuracoes: TConfiguracoes read FConfiguracoes  write FConfiguracoes;

    function GetNamePath: string; override ;
    function LoadFromFile(CaminhoArquivo: string): boolean;
    function LoadFromStream(Stream: TStringStream): boolean;
    function SaveToFile(PathArquivo: string = ''): boolean;

    property ACBrCTe : TComponent read FACBrCTe ;
  end;

  TSendMailThread = class(TThread)
  private
    FException : Exception;
    procedure DoHandleException;
  public
    smtp : TSMTPSend;
    sFrom : String;
    sTo : String;
    slmsg_Lines : TStrings;
    constructor Enviar;
  protected
    procedure Execute; override;
    procedure HandleException;
  end;


implementation

uses ACBrCTe, ACBrUtil, pcnGerador;

{ Conhecimento }

constructor Conhecimento.Create(Collection2: TCollection);
begin
  inherited Create(Collection2);
  FCTe := TCTe.Create;

  FCTe.Ide.tpCTe  := tcNormal;
  FCTe.Ide.modelo := '57';

  FCTe.Ide.verProc   := '1.0.0.0';
  FCTe.Ide.tpAmb     := TACBrCTe( TConhecimentos( Collection ).ACBrCTe ).Configuracoes.WebServices.Ambiente  ;
  FCTe.Ide.tpEmis    := TACBrCTe( TConhecimentos( Collection ).ACBrCTe ).Configuracoes.Geral.FormaEmissao ;
end;

destructor Conhecimento.Destroy;
begin
  FCTe.Free;
  inherited Destroy;
end;

procedure Conhecimento.Imprimir;
begin
//  TACBrCTe( TConhecimentos( Collection ).ACBrCTe ).DACTE.ImprimirDACTE(CTe);
end;

procedure Conhecimento.ImprimirPDF;
begin
//  TACBrCTe( TConhecimentos( Collection ).ACBrCTe ).DACTE.ImprimirDACTEPDF(CTe);
end;

function Conhecimento.SaveToFile(CaminhoArquivo: string = ''): boolean;
var
  LocCTeW : TCTeW;
begin
  try
     Result := True;
     LocCTeW := TCTeW.Create(CTe);
     try
        LocCTeW.schema := TsPL005c;
        LocCTeW.GerarXml;
        if NotaUtil.EstaVazio(CaminhoArquivo) then
           CaminhoArquivo := PathWithDelim(TACBrCTe( TConhecimentos( Collection ).ACBrCTe ).Configuracoes.Geral.PathSalvar)+copy(CTe.inFCTe.ID, (length(CTe.inFCTe.ID)-44)+1, 44)+'-CTe.xml';
        LocCTeW.Gerador.SalvarArquivo(CaminhoArquivo);
     finally
        LocCTeW.Free;
     end;
  except
     Result := False;
  end;
end;

function Conhecimento.SaveToStream(Stream: TStringStream): boolean;
var
  LocCTeW : TCTeW;
begin
  try
     Result := True;
     LocCTeW := TCTeW.Create(CTe);
     try
        LocCTeW.schema := TsPL005c;
        LocCTeW.GerarXml;
        Stream.WriteString(LocCTeW.Gerador.ArquivoFormatoXML);
     finally
        LocCTeW.Free;
     end;
  except
     Result := False;
  end;
end;

procedure Conhecimento.EnviarEmail(const sSmtpHost, sSmtpPort, sSmtpUser, sSmtpPasswd, sFrom, sTo, sAssunto: String; sMensagem : TStrings; SSL : Boolean; EnviaPDF: Boolean = true);
var
  ThreadSMTP : TSendMailThread;
  m:TMimemess;
  p: TMimepart;
  StreamCTe : TStringStream;
  NomeArq : String;
begin
  m:=TMimemess.create;
  ThreadSMTP := TSendMailThread.Enviar;
  try
     p := m.AddPartMultipart('mixed', nil);
     if sMensagem <> nil then
        m.AddPartText(sMensagem, p);
     StreamCTe := TStringStream.Create('');
     SaveToStream(StreamCTe) ;
     m.AddPartBinary(StreamCTe,copy(CTe.inFCTe.ID, (length(CTe.inFCTe.ID)-44)+1, 44)+'-CTe.xml', p);
     if (EnviaPDF) then
     begin
{        TACBrCTe( TConhecimentos( Collection ).ACBrCTe ).DACTe.ImprimirDACTePDF(CTe);
        if NotaUtil.EstaVazio(TACBrCTe( TConhecimentos( Collection ).ACBrCTe ).DACTe.PathPDF) then
           NomeArq := TACBrCTe( TConhecimentos( Collection ).ACBrCTe ).Configuracoes.Geral.PathSalvar
        else
           NomeArq := TACBrCTe( TConhecimentos( Collection ).ACBrCTe ).DACTe.PathPDF;}
        m.AddPartBinaryFromFile(PathWithDelim(NomeArq)+CTe.inFCTe.ID+'.pdf', p);
     end;
     m.header.tolist.add(sTo);
     m.header.From := sFrom;
     m.header.subject:=sAssunto;
     m.EncodeMessage;

     ThreadSMTP.sFrom := sFrom;
     ThreadSMTP.sTo := sTo;
     ThreadSMTP.slmsg_Lines.Add(m.Lines.Text);

     ThreadSMTP.smtp.UserName := sSmtpUser;
     ThreadSMTP.smtp.Password := sSmtpPasswd;

     ThreadSMTP.smtp.TargetHost := sSmtpHost;
     ThreadSMTP.smtp.TargetPort := sSmtpPort;

     ThreadSMTP.smtp.FullSSL := SSL;
     ThreadSMTP.smtp.AutoTLS := SSL;
     TACBrCTe( TConhecimentos( Collection ).ACBrCTe ).SetStatus( stCTeEmail );

     ThreadSMTP.Resume; // inicia a thread

     TACBrCTe( TConhecimentos( Collection ).ACBrCTe ).SetStatus( stCTeIdle );
  finally
     m.free;
  end;
end;

{ TConhecimentos }
constructor TConhecimentos.Create(AOwner: TPersistent;
  ItemClass: TCollectionItemClass);
begin
  if not (AOwner is TACBrCTe ) then
     raise Exception.Create( 'AOwner deve ser do tipo TACBrCTe') ;

  inherited;

  FACBrCTe := TACBrCTe( AOwner ) ;
end;


function TConhecimentos.Add: Conhecimento;
begin
  Result := Conhecimento(inherited Add);

  Result.CTe.Ide.tpAmb := Configuracoes.WebServices.Ambiente ;
end;

procedure TConhecimentos.Assinar;
var
  i: Integer;
  vAssinada : AnsiString;
  LocCTeW : TCTeW;
  FMsg : AnsiString;
begin
  for i:= 0 to Self.Count-1 do
   begin
     LocCTeW := TCTeW.Create(Self.Items[i].CTe);
     try
        LocCTeW.schema := TsPL005c;
        LocCTeW.GerarXml;
        Self.Items[i].Alertas := LocCTeW.Gerador.ListaDeAlertas.Text;
{$IFDEF ACBrCTeOpenSSL}
        if not(CTeUtil.Assinar(LocCTeW.Gerador.ArquivoFormatoXML, FConfiguracoes.Certificados.Certificado , FConfiguracoes.Certificados.Senha, vAssinada, FMsg)) then
           raise Exception.Create('Falha ao assinar Nota Fiscal Eletrônica '+
                                   IntToStr(Self.Items[i].CTe.Ide.cNF)+FMsg);
{$ELSE}
        if not(CTeUtil.Assinar(LocCTeW.Gerador.ArquivoFormatoXML, FConfiguracoes.Certificados.GetCertificado , vAssinada, FMsg)) then
           raise Exception.Create('Falha ao assinar Nota Fiscal Eletrônica '+
                                   IntToStr(Self.Items[i].CTe.Ide.cCT)+FMsg);
{$ENDIF}
        vAssinada := StringReplace( vAssinada, '<'+ENCODING_UTF8_STD+'>', '', [rfReplaceAll] ) ;
        vAssinada := StringReplace( vAssinada, '<?xml version="1.0"?>', '', [rfReplaceAll] ) ;
        Self.Items[i].XML := vAssinada;
        if FConfiguracoes.Geral.Salvar then
           FConfiguracoes.Geral.Save(StringReplace(Self.Items[i].CTe.inFCTe.ID, 'CTe', '', [rfIgnoreCase])+'-cte.xml', vAssinada);

     finally
        LocCTeW.Free;
     end;
   end;

end;

procedure TConhecimentos.GerarCTe;
var
 i: Integer;
// LocCTeW : TCTeW;
begin
 for i:= 0 to Self.Count-1 do
  begin
{    LocCTeW := TCTeW.Create(Self.Items[i].CTe);
    try
       LocCTeW.schema := TsPL005c;
       LocCTeW.GerarXml;
       Self.Items[i].XML := LocCTeW.Gerador.ArquivoFormatoXML;
       Self.Items[i].Alertas := LocCTeW.Gerador.ListaDeAlertas.Text;
    finally
       LocCTeW.Free;
    end;}
  end;
end;

function TConhecimentos.GetItem(Index: Integer): Conhecimento;
begin
  Result := Conhecimento(inherited Items[Index]);
end;

function TConhecimentos.GetNamePath: string;
begin
  Result := 'Conhecimento';
end;

procedure TConhecimentos.Imprimir;
begin
//  TACBrCTe( FACBrCTe ).DACTe.ImprimirDACTe(nil);
end;

procedure TConhecimentos.ImprimirPDF;
begin
//  TACBrCTe( FACBrCTe ).DACTe.ImprimirDACTePDF(nil);
end;

function TConhecimentos.Insert(Index: Integer): Conhecimento;
begin
  Result := Conhecimento(inherited Insert(Index));
end;

procedure TConhecimentos.SetItem(Index: Integer; const Value: Conhecimento);
begin
  Items[Index].Assign(Value);
end;

procedure TConhecimentos.Valida;
var
 i: Integer;
 FMsg : AnsiString;
begin
  for i:= 0 to Self.Count-1 do
   begin
     if pos('<Signature',Self.Items[i].XML) = 0 then
        Assinar;
     if not(CTeUtil.Valida(Self.Items[i].XML, FMsg)) then
       raise Exception.Create('Falha na validação dos dados da nota '+
                               IntToStr(Self.Items[i].CTe.Ide.cCT)+sLineBreak+Self.Items[i].Alertas+FMsg);
  end;
end;

function TConhecimentos.LoadFromFile(CaminhoArquivo: string): boolean;
var
 LocCTeR : TCTeR;
begin
 try
    Result := True;
    LocCTeR := TCTeR.Create(Self.Add.CTe);
    try
       LocCTeR.Leitor.CarregarArquivo(CaminhoArquivo);
       LocCTeR.LerXml;   
    finally
       LocCTeR.Free;
    end;
 except
    Result := False;
 end;
end;

function TConhecimentos.LoadFromStream(Stream: TStringStream): boolean;
var
 LocCTeR : TCTeR;
begin
  try
    Result := True;
    LocCTeR := TCTeR.Create(Self.Add.CTe);
    try
       LocCTeR.Leitor.CarregarArquivo(Stream);
       LocCTeR.LerXml;
    finally
       LocCTeR.Free
    end;
  except
    Result := False;
  end;
end;

function TConhecimentos.SaveToFile(PathArquivo: string = ''): boolean;
var
 i : integer;
 CaminhoArquivo : String;
begin
 Result := True;
 try
    for i:= 0 to TACBrCTe( FACBrCTe ).Conhecimentos.Count-1 do
     begin
        if NotaUtil.EstaVazio(PathArquivo) then
           PathArquivo := TACBrCTe( FACBrCTe ).Configuracoes.Geral.PathSalvar;
        CaminhoArquivo := PathWithDelim(PathArquivo)+copy(TACBrCTe( FACBrCTe ).Conhecimentos.Items[0].CTe.inFCTe.ID, (length(TACBrCTe( FACBrCTe ).Conhecimentos.Items[0].CTe.inFCTe.ID)-44)+1, 44)+'-CTe.xml';
        TACBrCTe( FACBrCTe ).Conhecimentos.Items[i].SaveToFile(CaminhoArquivo)
     end;
 except
    Result := False;
 end;
end;

{ TSendMailThread }

procedure TSendMailThread.DoHandleException;
begin
  Sysutils.ShowException(FException, nil );
end;

constructor TSendMailThread.Enviar;
begin
  Create(True);
  FreeOnTerminate := True;
  smtp := TSMTPSend.Create;
  slmsg_Lines := TStringList.Create;
  sFrom := '';
  sTo := '';
end;

procedure TSendMailThread.Execute;
begin
   inherited;
   try
      try
         if not smtp.Login() then
            raise Exception.Create('SMTP ERROR: Login:' + smtp.EnhCodeString);
         if not smtp.MailFrom( sFrom, Length(sFrom)) then
            raise Exception.Create('SMTP ERROR: MailFrom:' + smtp.EnhCodeString);
         if not smtp.MailTo(sTo) then
            raise Exception.Create('SMTP ERROR: MailTo:' + smtp.EnhCodeString);
         if not smtp.MailData(slmsg_Lines) then
            raise Exception.Create('SMTP ERROR: MailData:' + smtp.EnhCodeString);
         if not smtp.Logout() then
            raise Exception.Create('SMTP ERROR: Logout:' + smtp.EnhCodeString);
      except
         HandleException;
      end;
   finally
      if Assigned(slmsg_lines) then
         slmsg_lines.free;
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
