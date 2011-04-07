unit Principal;

interface

uses
  httpsend,

  Windows, Forms, Classes, Controls, StdCtrls, ExtCtrls, Dialogs, Buttons,
  DB, Grids, DBGrids, DBCtrls, DBClient;

type
  TRegistro = packed record
    Marca        : string[2];
    Modelo       : string[2];
    Versao       : string[2];
    Tipo         : string[10];
    MarcaDescr   : string[30];
    ModeloDescr  : string[30];
    VersaoSB     : string[20];
    QtLacreSL    : Integer;//string[3];
    QTLacreFab   : Integer;//string[3];
    MFD          : string[3];
    LacreMFD     : string[3];
    AtoAprovacao : string[25];
    AtoRegistroMG: string[25];
    FormatoNumero: string[20];
  end;

  TfrPrincipal = class(TForm)
    btExportar: TBitBtn;
    btListar: TBitBtn;
    btProxy: TBitBtn;
    btSair: TBitBtn;
    Datasource1: TDatasource;
    DBGrid1: TDBGrid;
    DBNavigator1: TDBNavigator;
    GroupBox1: TGroupBox;
    OpenDialog1: TOpenDialog;
    Panel1: TPanel;
    SaveDialog1: TSaveDialog;
    memECF: TClientDataSet;
    memECFCodMarca: TStringField;
    memECFCodCodModelo: TStringField;
    memECFCodCodVersao: TStringField;
    memECFCodTipoECF: TStringField;
    memECFCodDescMarca: TStringField;
    memECFCodDescModelo: TStringField;
    memECFCodVersao: TStringField;
    memECFCodLacresSL: TIntegerField;
    memECFCodLacresFab: TIntegerField;
    memECFCodTemMFD: TStringField;
    memECFCodLacreMFD: TStringField;
    memECFCodAtoAprovacao: TStringField;
    memECFCodAtoRegistro: TStringField;
    memECFCodFormatoNumFabricacao: TStringField;
    Label1: TLabel;
    sbArquivo: TSpeedButton;
    Label2: TLabel;
    edArquivo: TEdit;
    edURLDownload: TEdit;
    btAbrir: TBitBtn;
    btDownload: TBitBtn;
    procedure btAbrirClick(Sender: TObject);
    procedure btDownloadClick(Sender: TObject);
    procedure btExportarClick(Sender: TObject);
    procedure btListarClick(Sender: TObject);
    procedure btProxyClick(Sender: TObject);
    procedure btSairClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure sbArquivoClick(Sender: TObject);
  private
    { private declarations }
    fHTTPSend: THTTPSend;
  public
    { public declarations }
  end;

var
    frPrincipal: TfrPrincipal;

implementation

uses
  ProxyConfig, WinInet, SysUtils, ACBrUtil;

{$R *.dfm}

{ TfrPrincipal }

procedure GetProxySettings(var Server, Port, User, Pass: AnsiString);
var
  Len: DWORD;
  i, j: Integer;

  function GetProxyServer: String;
  var
    ProxyInfo: PInternetProxyInfo;
  begin
    Result := '';
    Len := 0;
    if not InternetQueryOption(nil, INTERNET_OPTION_PROXY, nil, Len) then
    begin
      if GetLastError = ERROR_INSUFFICIENT_BUFFER then
      begin
        GetMem(ProxyInfo, Len);
        try
          if InternetQueryOption(nil, INTERNET_OPTION_PROXY, ProxyInfo, Len) then
          begin
            if ProxyInfo^.dwAccessType = INTERNET_OPEN_TYPE_PROXY then
              Result := String(ProxyInfo^.lpszProxy);
          end;
        finally
          FreeMem(ProxyInfo);
        end;
      end;
    end;
  end;

  function GetOptionString(Option: DWORD): String;
  begin
    Len := 0;

    if not InternetQueryOption(nil, Option, nil, Len) then
    begin
      if GetLastError = ERROR_INSUFFICIENT_BUFFER then
      begin
        SetLength(Result, Len);
        if InternetQueryOption(nil, Option, Pointer(Result), Len) then
          Exit;
      end;
    end;

    Result := '';
  end;

begin
  Port   := '';
  Server := AnsiString(GetProxyServer);
  User   := AnsiString(GetOptionString(INTERNET_OPTION_PROXY_USERNAME));
  Pass   := AnsiString(GetOptionString(INTERNET_OPTION_PROXY_PASSWORD));

  if Server <> '' then
  begin
    i := Pos('http=', String(Server));
    if i > 0 then
    begin
      Delete(Server, 1, i + 5);
      j := Pos(';', String(Server));
      if j > 0 then
        Server := AnsiString(Copy(String(Server), 1, j - 1));
    end;

    i := Pos(':', String(Server));
    if i > 0 then
    begin
      Port   := AnsiString(Copy(String(Server), i + 1, MaxInt));
      Server := AnsiString(Copy(String(Server), 1, i - 1));
    end;
  end;
end;

procedure TfrPrincipal.FormCreate(Sender: TObject);
var
  Server, Port, User, Pass: AnsiString;
begin
  Server := '';
  Port   := '';
  User   := '';
  Pass   := '';

  GetProxySettings(Server, Port, User, Pass);

  fHTTPSend := THTTPSend.Create;
  fHTTPSend.ProxyHost := String(Server);
  fHTTPSend.ProxyPort := String(Port);
  fHTTPSend.ProxyUser := String(User);
  fHTTPSend.ProxyPass := String(Pass);

  edArquivo.Text := ExtractFilePath(Application.ExeName) + 'Tabela_CNIEE.bin';
end;

procedure TfrPrincipal.FormDestroy(Sender: TObject);
begin
  fHTTPSend.Free;
end;

procedure TfrPrincipal.FormShow(Sender: TObject);
begin
  if FilesExists(edArquivo.Text) then
    btAbrir.Click;
end;

procedure TfrPrincipal.sbArquivoClick(Sender: TObject);
begin
  if OpenDialog1.Execute then
  begin
    edArquivo.Text := OpenDialog1.FileName;
    btAbrir.Click;
  end;
end;

procedure TfrPrincipal.btDownloadClick(Sender: TObject);
var
  OK: Boolean;
begin
  if edURLDownload.Text = '' then
    raise Exception.Create('URL de Download não especificada');

  if edArquivo.Text = '' then
    raise Exception.Create('Nome do arquivo em Disco não especificado');

  memECF.Close;
  Application.ProcessMessages;

  with fHTTPSend do
  begin
    Clear;
    OK := HTTPMethod('GET', edURLDownload.Text);
    if OK and (ResultCode = 200) then
    begin
      Document.Seek(0, soFromBeginning);
      Document.SaveToFile(edArquivo.Text);

      MessageDlg('Tabela de ECFs baixada com sucesso.', mtInformation, [mbOK], 0);
      btAbrir.Click;
    end
    else
      MessageDlg('Erro ao efetuar Download da Tabela de ECFs' + sLineBreak + 'URL: ' + edURLDownload.Text + sLineBreak + 'HTTP ResultCode: ' + IntToStr(ResultCode) + ' - ' + ResultString, mtError, [mbOK], 0);
  end;
end;

procedure TfrPrincipal.btExportarClick(Sender: TObject);
begin
  MessageDlg('Função ainda não Implementada', mtError, [mbOK], 0);
end;

procedure TfrPrincipal.btListarClick(Sender: TObject);
begin
  MessageDlg('Função ainda não Implementada', mtError, [mbOK], 0);
end;

procedure TfrPrincipal.btAbrirClick(Sender: TObject);
var
  F: file of TRegistro;
  Registro: TRegistro;
  strVersaoSB: string;
  FileName: String;

  function ReplaceString(const AString: string;
    const ANovo: string; const AAntigo: array of string;
    const AOpcoes: TReplaceFlags): string;
  var
    I: Integer;
  begin
    Result := AString;
    for I := 0 to High(AAntigo) do
      Result := StringReplace(Result, AAntigo[I], ANovo, AOpcoes);
  end;

begin
  FileName := Trim(edArquivo.Text);

  if FileName = '' then
    raise Exception.Create('Nome do arquivo em Disco não especificado.');

  if not FileExists(FileName) then
    raise Exception.Create('Arquivo não encontrado:' + sLineBreak + FileName);

  memECF.Close;
  memECF.CreateDataSet;
  memECF.DisableControls;

  AssignFile(F, Filename);
  try
    Reset(F);
    while not Eof(F) do
    begin
      Read(F, Registro);

      strVersaoSB := Trim(string(Registro.VersaoSB));
      strVersaoSB := ReplaceString(
        strVersaoSB,
        EmptyStr,
        ['VER: ', 'V: ', 'VER:', 'V:', 'V.', 'VER.', 'VER', 'V'],
        [rfIgnoreCase, rfReplaceAll]
      );

      memECF.Append;
      memECFCodMarca.AsString                := Trim(string(Registro.Marca));
      memECFCodCodModelo.AsString            := Trim(string(Registro.Modelo));
      memECFCodCodVersao.AsString            := Trim(string(Registro.Versao));
      memECFCodTipoECF.AsString              := string(Registro.Tipo);
      memECFCodDescMarca.AsString            := string(Registro.MarcaDescr);
      memECFCodDescModelo.AsString           := string(Registro.ModeloDescr);
      memECFCodVersao.AsString               := strVersaoSB;
      memECFCodLacresSL.AsInteger            := Registro.QtLacreSL;
      memECFCodLacresFab.AsInteger           := Registro.QTLacreFab;
      memECFCodTemMFD.AsString               := string(Registro.MFD);
      memECFCodLacreMFD.AsString             := string(Registro.LacreMFD);
      memECFCodAtoAprovacao.AsString         := string(Registro.AtoAprovacao);
      memECFCodAtoRegistro.AsString          := string(Registro.AtoRegistroMG);
      memECFCodFormatoNumFabricacao.AsString := string(Registro.FormatoNumero);
      memECF.Post;
    end;
  finally
    memECF.First;
    memECF.EnableControls;
    CloseFile(F);
  end;
end;

procedure TfrPrincipal.btProxyClick(Sender: TObject);
Var
  frProxyConfig: TfrProxyConfig;
begin
  frProxyConfig := TfrProxyConfig.Create(self);
  try
    frProxyConfig.edServidor.Text := fHTTPSend.ProxyHost;
    frProxyConfig.edPorta.Text := fHTTPSend.ProxyPort;
    frProxyConfig.edUser.Text := fHTTPSend.ProxyUser;
    frProxyConfig.edSenha.Text := fHTTPSend.ProxyPass;

    if frProxyConfig.ShowModal = mrOK then
    begin
      fHTTPSend.ProxyHost := frProxyConfig.edServidor.Text;
      fHTTPSend.ProxyPort := frProxyConfig.edPorta.Text;
      fHTTPSend.ProxyUser := frProxyConfig.edUser.Text;
      fHTTPSend.ProxyPass := frProxyConfig.edSenha.Text;
    end;
  finally
    frProxyConfig.Free;
  end;
end;

procedure TfrPrincipal.btSairClick(Sender: TObject);
begin
  Close;
end;

end.
