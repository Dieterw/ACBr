unit Principal;

interface

uses
  httpsend,

  Windows, Forms, Classes, Controls, StdCtrls, ExtCtrls, Dialogs, Buttons,
  DB, Grids, DBGrids, DBCtrls, DBClient;

type
  TfrPrincipal = class(TForm)
    btExportar: TBitBtn;
    btListar: TBitBtn;
    btProxy: TBitBtn;
    btSair: TBitBtn;
    btAbrir: TBitBtn;
    btDownload: TBitBtn;
    Datasource1: TDatasource;
    DBGrid1: TDBGrid;
    DBNavigator1: TDBNavigator;
    edArquivo: TEdit;
    edURLDownload: TEdit;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    OpenDialog1: TOpenDialog;
    Panel1: TPanel;
    SaveDialog1: TSaveDialog;
    sbArquivo: TSpeedButton;
    memECF: TClientDataSet;
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
              Result := ProxyInfo^.lpszProxy;
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
  Server := GetProxyServer;
  User   := GetOptionString(INTERNET_OPTION_PROXY_USERNAME);
  Pass   := GetOptionString(INTERNET_OPTION_PROXY_PASSWORD);

  if Server <> '' then
  begin
    i := Pos('http=', Server);
    if i > 0 then
    begin
      Delete(Server, 1, i + 5);
      j := Pos(';', Server);
      if j > 0 then
        Server := Copy(Server, 1, j - 1);
    end;

    i := Pos(':', Server);
    if i > 0 then
    begin
      Port := Copy(Server, i + 1, MaxInt);
      Server := Copy(Server, 1, i - 1);
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
  fHTTPSend.ProxyHost := Server;
  fHTTPSend.ProxyPort := Port;
  fHTTPSend.ProxyUser := User;
  fHTTPSend.ProxyPass := Pass;

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
  FS: TFileStream;
  i, FieldSize, BufferSize: Integer;
  Buffer: AnsiString;
begin
  if edArquivo.Text = '' then
    raise Exception.Create('Nome do arquivo em Disco não especificado');

  if not FileExists(edArquivo.Text) then
    raise Exception.Create('Arquivo não encontrado' + sLineBreak + edArquivo.Text);

  memECF.Close;
  memECF.CreateDataSet;
  Application.ProcessMessages;

  memECF.DisableControls;
  FS := TFileStream.Create(edArquivo.Text, fmOpenRead);
  try
    // Lendo Arquivo .BIN //
    FS.Seek(0, soFromBeginning);
    // vai para BOF

    while FS.Position < FS.Size do
    begin
      memECF.Insert;

      For i := 0 to memECF.FieldDefs.Count - 1 do
      begin
        FieldSize := memECF.FieldDefs[i].Size;
        if memECF.FieldDefs[i].DataType = ftString then
          FieldSize := FieldSize + 1;

        Buffer := '';
        SetLength(Buffer, FieldSize);
        FS.ReadBuffer(PChar(Buffer)^, FieldSize);

        BufferSize := Ord(Buffer[1]);
        case memECF.FieldDefs[i].DataType of
          ftString:  memECF.Fields[i].AsString := Copy(Buffer, 2, BufferSize);
          ftInteger: memECF.Fields[i].AsInteger := SomaAscII(Buffer);
        else
          raise Exception.Create('Campo não suportado');
        end;
      end;

      memECF.Post;
    end;

    memECF.First;
  finally
    FS.Free;
    memECF.EnableControls;
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
