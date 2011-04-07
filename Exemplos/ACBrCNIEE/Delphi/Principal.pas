unit Principal;

interface

uses
  httpsend,

  Windows, Forms, Classes, Controls, StdCtrls, ExtCtrls, Dialogs, Buttons,
  DB, Grids, DBGrids, DBCtrls, DBClient, ACBrTabelaCNIEE;

type
  TfrPrincipal = class(TForm)
    btExportar: TBitBtn;
    btListar: TBitBtn;
    btProxy: TBitBtn;
    btSair: TBitBtn;
    dtsCadastro: TDataSource;
    DBGrid1: TDBGrid;
    DBNavigator1: TDBNavigator;
    GroupBox1: TGroupBox;
    OpenDialog1: TOpenDialog;
    Panel1: TPanel;
    SaveDialog1: TSaveDialog;
    Label1: TLabel;
    sbArquivo: TSpeedButton;
    Label2: TLabel;
    edArquivo: TEdit;
    edURLDownload: TEdit;
    btAbrir: TBitBtn;
    btDownload: TBitBtn;
    ACBrTabelaCNIEE: TACBrTabelaCNIEE;
    tmpCadastro: TClientDataSet;
    tmpCadastroMarca: TStringField;
    tmpCadastroModelo: TStringField;
    tmpCadastroVersao: TStringField;
    tmpCadastroTipo: TStringField;
    tmpCadastroMarcaDescr: TStringField;
    tmpCadastroModeloDescr: TStringField;
    tmpCadastroVersaoSB: TStringField;
    tmpCadastroQtLacreSL: TIntegerField;
    tmpCadastroQTLacreFab: TIntegerField;
    tmpCadastroMFD: TStringField;
    tmpCadastroLacreMFD: TStringField;
    tmpCadastroAtoAprovacao: TStringField;
    tmpCadastroAtoRegistroMG: TStringField;
    tmpCadastroFormatoNumero: TStringField;
    procedure btAbrirClick(Sender: TObject);
    procedure btDownloadClick(Sender: TObject);
    procedure btExportarClick(Sender: TObject);
    procedure btListarClick(Sender: TObject);
    procedure btProxyClick(Sender: TObject);
    procedure btSairClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure sbArquivoClick(Sender: TObject);
  private
    { private declarations }
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

procedure TfrPrincipal.FormCreate(Sender: TObject);
begin
  edArquivo.Text := ExtractFilePath(Application.ExeName) + 'Tabela_CNIEE.bin';
  ACBrTabelaCNIEE.Arquivo := edArquivo.Text;
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
begin
  tmpCadastro.Close;

  ACBrTabelaCNIEE.URLDownload := edURLDownload.Text;
  if ACBrTabelaCNIEE.DownloadTabela then
  begin
    MessageDlg('Download da tabela efetuado com sucesso.', mtInformation, [mbOK], 0);

    if MessageDlg('Deseja abrir a tabela e mostrar os dados?', mtInformation, mbYesNo, 0) = mrYes then
      btAbrir.Click;
  end
  else
    MessageDlg('Não foi possível efetuar o download da tabela.', mtError, [mbOK], 0);
end;

procedure TfrPrincipal.btAbrirClick(Sender: TObject);
var
  I: Integer;
begin
  ACBrTabelaCNIEE.Arquivo := edArquivo.Text;
  if ACBrTabelaCNIEE.AbrirTabela then
  begin
    tmpCadastro.Close;
    tmpCadastro.CreateDataSet;
    tmpCadastro.DisableControls;
    try
      for I := 0 to ACBrTabelaCNIEE.Cadastros.Count - 1 do
      begin
        tmpCadastro.Append;
        tmpCadastroMarca.AsString         := ACBrTabelaCNIEE.Cadastros[I].CodMarca;
        tmpCadastroModelo.AsString        := ACBrTabelaCNIEE.Cadastros[I].CodCodModelo;
        tmpCadastroVersao.AsString        := ACBrTabelaCNIEE.Cadastros[I].CodCodVersao;
        tmpCadastroTipo.AsString          := ACBrTabelaCNIEE.Cadastros[I].TipoECF;
        tmpCadastroMarcaDescr.AsString    := ACBrTabelaCNIEE.Cadastros[I].DescrMarca;
        tmpCadastroModeloDescr.AsString   := ACBrTabelaCNIEE.Cadastros[I].DescrModelo;
        tmpCadastroVersaoSB.AsString      := ACBrTabelaCNIEE.Cadastros[I].Versao;
        tmpCadastroQtLacreSL.AsInteger    := ACBrTabelaCNIEE.Cadastros[I].QtLacresSL;
        tmpCadastroQtLacreFab.AsInteger   := ACBrTabelaCNIEE.Cadastros[I].QtLacresFab;
        tmpCadastroMFD.AsString           := ACBrTabelaCNIEE.Cadastros[I].TemMFD;
        tmpCadastroLacreMFD.AsString      := ACBrTabelaCNIEE.Cadastros[I].TemLacreMFD;
        tmpCadastroAtoAprovacao.AsString  := ACBrTabelaCNIEE.Cadastros[I].AtoAprovacao;
        tmpCadastroAtoRegistroMG.AsString := ACBrTabelaCNIEE.Cadastros[I].AtoRegistro;
        tmpCadastroFormatoNumero.AsString := ACBrTabelaCNIEE.Cadastros[I].FormatoNumFabricacao;
        tmpCadastro.Post;
      end;
    finally
      tmpCadastro.First;
      tmpCadastro.EnableControls;
    end;
  end;
end;

procedure TfrPrincipal.btProxyClick(Sender: TObject);
Var
  frProxyConfig: TfrProxyConfig;
begin
  frProxyConfig := TfrProxyConfig.Create(self);
  try
    frProxyConfig.edServidor.Text := ACBrTabelaCNIEE.Proxy.Servidor;
    frProxyConfig.edPorta.Text    := ACBrTabelaCNIEE.Proxy.Porta;
    frProxyConfig.edUser.Text     := ACBrTabelaCNIEE.Proxy.Usuario;
    frProxyConfig.edSenha.Text    := ACBrTabelaCNIEE.Proxy.Senha;

    if frProxyConfig.ShowModal = mrOK then
    begin
      ACBrTabelaCNIEE.Proxy.Servidor := frProxyConfig.edServidor.Text;
      ACBrTabelaCNIEE.Proxy.Porta    := frProxyConfig.edPorta.Text;
      ACBrTabelaCNIEE.Proxy.Usuario  := frProxyConfig.edUser.Text;
      ACBrTabelaCNIEE.Proxy.Senha    := frProxyConfig.edSenha.Text;
    end;
  finally
    frProxyConfig.Free;
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

procedure TfrPrincipal.btSairClick(Sender: TObject);
begin
  Close;
end;

end.
