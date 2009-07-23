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

unit ACBrNFeNotasFiscais;

interface

uses
  Classes, Sysutils,
  ACBrNFeUtil, ACBrNFeConfiguracoes,
  {$IFDEF FPC}
     ACBrNFeDMLaz,
  {$ELSE}
     ACBrNFeDANFEClass,
  {$ENDIF}
  smtpsend, ssl_openssl, mimemess, mimepart, // units para enviar email
  pcnNFe, pcnNFeR, pcnNFeW, pcnConversao;

type

  NotaFiscal = class(TCollectionItem)
  private
    FNFe: TNFe;
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
    procedure EnviarEmail(const sSmtpHost, sSmtpPort, sSmtpUser, sSmtpPasswd, sFrom, sTo, sAssunto: String; sMensagem : TStrings; SSL : Boolean);
    property NFe: TNFe  read FNFe write FNFe;
    property XML: AnsiString  read FXML write FXML;
    property Confirmada: Boolean  read FConfirmada write FConfirmada;
    property Msg: AnsiString  read FMsg write FMsg;
    property Alertas: AnsiString read FAlertas write FAlertas;
  end;

  TNotasFiscais = class(TOwnedCollection)
  private
    FConfiguracoes : TConfiguracoes;
    FACBrNFe : TComponent ;

    function GetItem(Index: Integer): NotaFiscal;
    procedure SetItem(Index: Integer; const Value: NotaFiscal);
  public
    constructor Create(AOwner: TPersistent; ItemClass: TCollectionItemClass);

    procedure GerarNFe;
    procedure Assinar;
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

    property ACBrNFe : TComponent read FACBrNFe ;
  end;

implementation

uses ACBrNFe, ACBrUtil, pcnGerador;

{ NotaFiscal }

constructor NotaFiscal.Create(Collection2: TCollection);
begin
  inherited Create(Collection2);
  FNFe := TNFe.Create;

  FNFe.Ide.tpNF   := tnSaida;
  FNFe.Ide.modelo := 55;

  FNFe.Ide.tpNF      := tnSaida;
  FNFe.Ide.indPag    := ipVista;
  FNFe.Ide.verProc   := '1.0.0.0';
  FNFe.Ide.tpAmb     := TACBrNFe( TNotasFiscais( Collection ).ACBrNFe ).Configuracoes.WebServices.Ambiente  ;

  FNFe.Emit.EnderEmit.xPais := 'BRASIL';
  FNFe.Emit.EnderEmit.cPais := 1058;
  FNFe.Emit.EnderEmit.nro   := 'SEM NUMERO';

  FNFe.Dest.EnderDest.xPais := 'BRASIL';
  FNFe.Dest.EnderDest.cPais := 1058;
  FNFe.Dest.EnderDest.nro   := 'SEM NUMERO';

end;

destructor NotaFiscal.Destroy;
begin
  FNFe.Free;
  inherited Destroy;
end;

procedure NotaFiscal.Imprimir;
begin
  TACBrNFe( TNotasFiscais( Collection ).ACBrNFe ).DANFE.ImprimirDANFE(NFe);
end;

procedure NotaFiscal.ImprimirPDF;
begin
  TACBrNFe( TNotasFiscais( Collection ).ACBrNFe ).DANFE.ImprimirDANFEPDF(NFe);
end;

function NotaFiscal.SaveToFile(CaminhoArquivo: string = ''): boolean;
var
  LocNFeW : TNFeW;
begin
  try
     Result := True;
     LocNFeW := TNFeW.Create(NFe);
     try
        LocNFeW.schema := TsPL005c;
        LocNFeW.GerarXml;
        if NotaUtil.EstaVazio(CaminhoArquivo) then
           CaminhoArquivo := PathWithDelim(TACBrNFe( TNotasFiscais( Collection ).ACBrNFe ).Configuracoes.Geral.PathSalvar)+copy(NFe.infNFe.ID, (length(NFe.infNFe.ID)-44)+1, 44)+'-NFe.xml';
        LocNFeW.Gerador.SalvarArquivo(CaminhoArquivo);
     finally
        LocNFeW.Free;
     end;
  except
     Result := False;
  end;
end;

function NotaFiscal.SaveToStream(Stream: TStringStream): boolean;
var
  LocNFeW : TNFeW;
begin
  try
     Result := True;
     LocNFeW := TNFeW.Create(NFe);
     try
        LocNFeW.schema := TsPL005c;
        LocNFeW.GerarXml;
        Stream.WriteString(LocNFeW.Gerador.ArquivoFormatoXML);
     finally
        LocNFeW.Free;
     end;
  except
     Result := False;
  end;
end;

procedure NotaFiscal.EnviarEmail(const sSmtpHost, sSmtpPort, sSmtpUser, sSmtpPasswd, sFrom, sTo, sAssunto: String; sMensagem : TStrings; SSL : Boolean);
var
  smtp: TSMTPSend;
  msg_lines: TStringList;
  m:TMimemess;
  p: TMimepart;
  StreamNFe : TStringStream;
  NomeArq : String;
begin
  msg_lines := TStringList.Create;
  smtp := TSMTPSend.Create;
  m:=TMimemess.create;
  try
     p := m.AddPartMultipart('mixed', nil);
     if sMensagem <> nil then
        m.AddPartText(sMensagem, p);
     StreamNFe := TStringStream.Create('');
     SaveToStream(StreamNFe) ;
     m.AddPartBinary(StreamNFe,copy(NFe.infNFe.ID, (length(NFe.infNFe.ID)-44)+1, 44)+'-NFe.xml', p);
     TACBrNFe( TNotasFiscais( Collection ).ACBrNFe ).DANFE.ImprimirDANFEPDF(NFe);
     if NotaUtil.EstaVazio(TACBrNFe( TNotasFiscais( Collection ).ACBrNFe ).DANFE.PathPDF) then
        NomeArq := TACBrNFe( TNotasFiscais( Collection ).ACBrNFe ).Configuracoes.Geral.PathSalvar
     else
        NomeArq := TACBrNFe( TNotasFiscais( Collection ).ACBrNFe ).DANFE.PathPDF;
     m.AddPartBinaryFromFile(PathWithDelim(NomeArq)+NFe.infNFe.ID+'.pdf', p);
     m.header.tolist.add(sTo);
     m.header.From := sFrom;
     m.header.subject:=sAssunto;
     m.EncodeMessage;
     msg_lines.Add(m.Lines.Text);

     smtp.UserName := sSmtpUser;
     smtp.Password := sSmtpPasswd;

     smtp.TargetHost := sSmtpHost;
     smtp.TargetPort := sSmtpPort;

     smtp.FullSSL := SSL;
     smtp.AutoTLS := SSL;
     TACBrNFe( TNotasFiscais( Collection ).ACBrNFe ).SetStatus( stEmail );
     if not smtp.Login() then
       raise Exception.Create('SMTP ERROR: Login:' + smtp.EnhCodeString);

     if not smtp.MailFrom(sFrom, Length(sFrom)) then
       raise Exception.Create('SMTP ERROR: MailFrom:' + smtp.EnhCodeString);
     if not smtp.MailTo(sTo) then
       raise Exception.Create('SMTP ERROR: MailTo:' + smtp.EnhCodeString);
     if not smtp.MailData(msg_lines) then
       raise Exception.Create('SMTP ERROR: MailData:' + smtp.EnhCodeString);

     if not smtp.Logout() then
       raise Exception.Create('SMTP ERROR: Logout:' + smtp.EnhCodeString);
     TACBrNFe( TNotasFiscais( Collection ).ACBrNFe ).SetStatus( stIdle );
  finally
     msg_lines.Free;
     smtp.Free;
     m.free;
  end;
end;

{ TNotasFiscais }
constructor TNotasFiscais.Create(AOwner: TPersistent;
  ItemClass: TCollectionItemClass);
begin
  if not (AOwner is TACBrNFe ) then
     raise Exception.Create( 'AOwner deve ser do tipo TACBrNFe') ;

  inherited;

  FACBrNFe := TACBrNFe( AOwner ) ;
end;


function TNotasFiscais.Add: NotaFiscal;
begin
  Result := NotaFiscal(inherited Add);

  Result.NFe.Ide.tpAmb := Configuracoes.WebServices.Ambiente ;
end;

procedure TNotasFiscais.Assinar;
var
  i: Integer;
  vAssinada : AnsiString;
  LocNFeW : TNFeW;
  FMsg : AnsiString;
begin
  for i:= 0 to Self.Count-1 do
   begin
     LocNFeW := TNFeW.Create(Self.Items[i].NFe);
     try
        LocNFeW.schema := TsPL005c;
        LocNFeW.GerarXml;

{$IFDEF ACBrNFeOpenSSL}
        if not(NotaUtil.Assinar(LocNFeW.Gerador.ArquivoFormatoXML, FConfiguracoes.Certificados.Certificado , FConfiguracoes.Certificados.Senha, vAssinada, FMsg)) then
           raise Exception.Create('Falha ao assinar Nota Fiscal Eletrônica '+
                                   IntToStr(Self.Items[i].NFe.Ide.cNF)+FMsg);
{$ELSE}
        if not(NotaUtil.Assinar(LocNFeW.Gerador.ArquivoFormatoXML, FConfiguracoes.Certificados.GetCertificado , vAssinada, FMsg)) then
           raise Exception.Create('Falha ao assinar Nota Fiscal Eletrônica '+
                                   IntToStr(Self.Items[i].NFe.Ide.cNF)+FMsg);
{$ENDIF}
        vAssinada := StringReplace( vAssinada, '<'+ENCODING_UTF8_STD+'>', '', [rfReplaceAll] ) ;
        vAssinada := StringReplace( vAssinada, '<?xml version="1.0"?>', '', [rfReplaceAll] ) ;
        Self.Items[i].XML := vAssinada;
        if FConfiguracoes.Geral.Salvar then
           FConfiguracoes.Geral.Save(StringReplace(Self.Items[i].NFe.infNFe.ID, 'NFe', '', [rfIgnoreCase])+'-nfe.xml', vAssinada);

     finally
        LocNFeW.Free;
     end;
   end;

end;

procedure TNotasFiscais.GerarNFe;
var
 i: Integer;
 LocNFeW : TNFeW;
begin
 for i:= 0 to Self.Count-1 do
  begin
    LocNFeW := TNFeW.Create(Self.Items[i].NFe);
    try
       LocNFeW.schema := TsPL005c;
       LocNFeW.GerarXml;
       Self.Items[i].XML := LocNFeW.Gerador.ArquivoFormatoXML;
       Self.Items[i].Alertas := LocNFeW.Gerador.ListaDeAlertas.Text;
    finally
       LocNFeW.Free;
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
  TACBrNFe( FACBrNFe ).DANFE.ImprimirDANFE(nil);
end;

procedure TNotasFiscais.ImprimirPDF;
begin
  TACBrNFe( FACBrNFe ).DANFE.ImprimirDANFEPDF(nil);
end;

function TNotasFiscais.Insert(Index: Integer): NotaFiscal;
begin
  Result := NotaFiscal(inherited Insert(Index));
end;

procedure TNotasFiscais.SetItem(Index: Integer; const Value: NotaFiscal);
begin
  Items[Index].Assign(Value);
end;

procedure TNotasFiscais.Valida;
var
 i: Integer;
 FMsg : AnsiString;
begin
  for i:= 0 to Self.Count-1 do
   begin
     if pos('<Signature',Self.Items[i].XML) = 0 then
        Assinar;
     if not(NotaUtil.Valida(Self.Items[i].XML, FMsg)) then
       raise Exception.Create('Falha na validação dos dados da nota '+
                               IntToStr(Self.Items[i].NFe.Ide.cNF)+sLineBreak+Self.Items[i].Alertas+FMsg);
  end;
end;

function TNotasFiscais.LoadFromFile(CaminhoArquivo: string): boolean;
var
 LocNFeR : TNFeR;
begin
 try
    Result := True;
    LocNFeR := TNFeR.Create(Self.Add.NFe);
    try
       LocNFeR.Leitor.CarregarArquivo(CaminhoArquivo);
       LocNFeR.LerXml;
    finally
       LocNFeR.Free;
    end;
 except
    Result := False;
 end;
end;

function TNotasFiscais.LoadFromStream(Stream: TStringStream): boolean;
var
 LocNFeR : TNFeR;
begin
  try
    Result := True;
    LocNFeR := TNFeR.Create(Self.Add.NFe);
    try
       LocNFeR.Leitor.CarregarArquivo(Stream);
       LocNFeR.LerXml;
    finally
       LocNFeR.Free
    end;
  except
    Result := False;
  end;
end;

function TNotasFiscais.SaveToFile(PathArquivo: string = ''): boolean;
var
 i : integer;
 CaminhoArquivo : String;
begin
 Result := True;
 try
    for i:= 0 to TACBrNFe( FACBrNFe ).NotasFiscais.Count-1 do
     begin
        if NotaUtil.EstaVazio(PathArquivo) then
           PathArquivo := TACBrNFe( FACBrNFe ).Configuracoes.Geral.PathSalvar;
        CaminhoArquivo := PathWithDelim(PathArquivo)+copy(TACBrNFe( FACBrNFe ).NotasFiscais.Items[0].NFe.infNFe.ID, (length(TACBrNFe( FACBrNFe ).NotasFiscais.Items[0].NFe.infNFe.ID)-44)+1, 44)+'-NFe.xml';
        TACBrNFe( FACBrNFe ).NotasFiscais.Items[i].SaveToFile(CaminhoArquivo)
     end;
 except
    Result := False;
 end;
end;

end.
