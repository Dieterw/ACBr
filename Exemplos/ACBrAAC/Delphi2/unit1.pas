unit Unit1;

interface

uses
  ACBrPAFClass, ACBrECFClass, ACBrUtil,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ACBrAAC, ACBrBase, ACBrECF, StdCtrls, ExtCtrls, jpeg, Buttons,
  ComCtrls, Spin;

type
  TForm1 = class(TForm)
    botao_pesquisa: TSpeedButton;
    Image1: TImage;
    Edit1: TEdit;
    ACBrECF: TACBrECF;
    ACBrAAC1: TACBrAAC;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label15: TLabel;
    edRazaoSocial: TEdit;
    edCNPJ: TEdit;
    edInscEstadual: TEdit;
    edInscMunicipal: TEdit;
    GroupBox2: TGroupBox;
    Label14: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label5: TLabel;
    edNomePAF: TEdit;
    edVersaoPAF: TEdit;
    edMD5Paf: TEdit;
    edExecutavel: TEdit;
    pnlBotton: TPanel;
    btnSairAplicativo: TSpeedButton;
    btnSalvarArquivo: TSpeedButton;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    GroupBox4: TGroupBox;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    btnAdicionarECF: TSpeedButton;
    btnExcluirECFs: TSpeedButton;
    edNumeroSerieECF: TEdit;
    edGTECF: TEdit;
    gbxECFCaptura: TGroupBox;
    btnECFCapturarDados: TSpeedButton;
    Label2: TLabel;
    Label9: TLabel;
    cbxECFPorta: TComboBox;
    cbxECFModelo: TComboBox;
    edCROECF: TSpinEdit;
    lstECFsAutorizados: TListView;
    cbxTipoFuncionamento: TComboBox;
    cbxTipoDesenvolvimento: TComboBox;
    cbxTipoIntegracao: TComboBox;
    Label10: TLabel;
    Label13: TLabel;
    Label16: TLabel;

    procedure ACBrAAC1GetChave(var Chave: AnsiString);
    procedure btnSairAplicativoClick(Sender: TObject);
    procedure btnECFCapturarDadosClick(Sender: TObject);
    procedure btnAdicionarECFClick(Sender: TObject);
    procedure btnExcluirECFsClick(Sender: TObject);
    procedure btnSalvarArquivoClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure edGTECFKeyPress(Sender: TObject; var Key: Char);
  private
    function GetPathArquivoAuxiliar: String;
    procedure buscaInformacoesArquivoAuxiliar;
    procedure recriarArquivoAuxiliar;
    procedure AdicionarItemGrid(const ANumeroSerie: String;
      const AValorGT: Double; const ACRO: Integer);
    function StrToNumero(const AString: String): Double;
  public

  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.AdicionarItemGrid(const ANumeroSerie: String;
  const AValorGT: Double; const ACRO: Integer);
begin
  with lstECFsAutorizados.Items.Add do
  begin
    Caption := ANumeroSerie;
    SubItems.Add(FormatFloat(',#0.00', AValorGT));
    SubItems.Add(Format('%3.3d', [ACRO]));
  end;
end;

function TForm1.StrToNumero(const AString: String): Double;
var
  StrTmp: String;
begin
  StrTmp := StringReplace(AString, '.', '', [rfReplaceAll]);
  Result := StrToFloat(StrTmp);
end;

function TForm1.GetPathArquivoAuxiliar: String;
begin
  Result := IncludeTrailingPathDelimiter(ExtractFilePath(ParamStr(0))) + 'AX.TXT';
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  PageControl1.ActivePageIndex     := 0;
  cbxTipoFuncionamento.ItemIndex   := 0;
  cbxTipoDesenvolvimento.ItemIndex := 0;
  cbxTipoIntegracao.ItemIndex      := 0;

  if not FileExists(GetPathArquivoAuxiliar) then
  begin
    MessageDlg('O Sistema não encontrou o arquivo auxiliar de configuração do PAF-ECF neste computador. O arquivo será recriado', mtWarning, [mbOK], 0);
    recriarArquivoAuxiliar;
  end
  else
    buscaInformacoesArquivoAuxiliar;
end;

procedure TForm1.ACBrAAC1GetChave(var Chave: AnsiString);
begin
  Chave := '1234';
end;

procedure TForm1.edGTECFKeyPress(Sender: TObject; var Key: Char);
begin
  if not( Key in ['0'..'9', ',', #8] ) then
    Key := #0
end;

procedure Tform1.recriarArquivoAuxiliar;
var
  F: TextFile;
  ct: integer;
begin
  try
    if not FileExists(GetPathArquivoAuxiliar) then
      DeleteFile(GetPathArquivoAuxiliar);

    AssignFile(F, GetPathArquivoAuxiliar);
    Rewrite(F);
    closefile(F);

    ACBrAAC1.NomeArquivoAux := GetPathArquivoAuxiliar;
    ACBrAAC1.AbrirArquivo;
    ACBrAAC1.IdentPAF.Empresa.RazaoSocial   := edRazaoSocial.Text;
    ACBrAAC1.IdentPAF.Empresa.CNPJ          := edCNPJ.Text;
    ACBrAAC1.IdentPAF.Empresa.IE            := edInscEstadual.Text;
    ACBrAAC1.IdentPAF.Empresa.IM            := edInscMunicipal.Text;
    ACBrAAC1.IdentPAF.Paf.Nome              := edNomePAF.Text;
    ACBrAAC1.IdentPAF.Paf.Versao            := edVersaoPAF.Text;
    ACBrAAC1.IdentPAF.Paf.PrincipalExe.Nome := edNomePAF.Text;
    ACBrAAC1.IdentPAF.Paf.PrincipalExe.MD5  := edExecutavel.Text;

    ACBrAAC1.IdentPAF.Paf.TipoFuncionamento   := TACBrPAFTipoFuncionamento(cbxTipoFuncionamento.ItemIndex);
    ACBrAAC1.IdentPAF.Paf.TipoDesenvolvimento := TACBrPAFTipoDesenvolvimento(cbxTipoDesenvolvimento.ItemIndex);
    ACBrAAC1.IdentPAF.Paf.IntegracaoPAFECF    := TACBrPAFTipoIntegracao(cbxTipoIntegracao.ItemIndex);

    ACBrAAC1.IdentPAF.ECFsAutorizados.Clear;
    for ct := 0 to lstECFsAutorizados.Items.Count - 1 do
    begin
      with ACBrAAC1.IdentPAF.ECFsAutorizados.New do
      begin
        NumeroSerie := lstECFsAutorizados.Items[ct].Caption;
        ValorGT     := StrToNumero(lstECFsAutorizados.Items[ct].SubItems[0]);
        CRO         := StrToInt(lstECFsAutorizados.Items[ct].SubItems[1]);
      end;
    end;

    ACBrAAC1.SalvarArquivo;
    MessageDlg('Arquivo auxiliar salvo com sucesso!', mtWarning, [mbOK], 0);

    buscaInformacoesArquivoAuxiliar;
  except
    on E: Exception do
    begin
      ShowMessage('Ocorreu o seguinte erro:' + sLineBreak + E.Message);
    end;
  end;
end;

procedure Tform1.buscaInformacoesArquivoAuxiliar;
var
  ct : integer;
begin
  ACBrAAC1.NomeArquivoAux := GetPathArquivoAuxiliar;
  ACBrAAC1.AbrirArquivo;
  edRazaoSocial.Text   := ACBrAAC1.IdentPAF.Empresa.RazaoSocial;
  edCNPJ.Text          := ACBrAAC1.IdentPAF.Empresa.CNPJ;
  edInscEstadual.Text  := ACBrAAC1.IdentPAF.Empresa.IE;
  edInscMunicipal.Text := ACBrAAC1.IdentPAF.Empresa.IM;
  edNomePAF.Text       := ACBrAAC1.IdentPAF.Paf.Nome;
  edVersaoPAF.Text     := ACBrAAC1.IdentPAF.Paf.Versao;
  edExecutavel.Text    := ACBrAAC1.IdentPAF.Paf.PrincipalExe.Nome;
  edMD5Paf.Text        := ACBrAAC1.IdentPAF.Paf.PrincipalExe.MD5;

  cbxTipoFuncionamento.ItemIndex   := Integer(ACBrAAC1.IdentPAF.Paf.TipoFuncionamento);
  cbxTipoDesenvolvimento.ItemIndex := Integer(ACBrAAC1.IdentPAF.Paf.TipoDesenvolvimento);
  cbxTipoIntegracao.ItemIndex      := Integer(ACBrAAC1.IdentPAF.Paf.IntegracaoPAFECF);


  {
      ACBrAAC1.IdentPAF.Paf.RealizaPreVenda;
      ACBrAAC1.IdentPAF.Paf.RealizaDAVECF;
      ACBrAAC1.IdentPAF.Paf.RealizaDAVNaoFiscal;
      ACBrAAC1.IdentPAF.Paf.RealizaDAVOS;
      ACBrAAC1.IdentPAF.Paf.DAVConfAnexoII;
      ACBrAAC1.IdentPAF.Paf.RealizaLancamentoMesa;
      ACBrAAC1.IdentPAF.Paf.IndiceTecnicoProd;
      ACBrAAC1.IdentPAF.Paf.BarSimilarECFRestaurante;
      ACBrAAC1.IdentPAF.Paf.BarSimilarECFComum;
      ACBrAAC1.IdentPAF.Paf.BarSimilarBalanca;
      ACBrAAC1.IdentPAF.Paf.UsaImpressoraNaoFiscal;
      ACBrAAC1.IdentPAF.Paf.DAVDiscrFormula;
      ACBrAAC1.IdentPAF.Paf.ImpedeVendaVlrZero;
      ACBrAAC1.IdentPAF.Paf.AcumulaVolumeDiario;
      ACBrAAC1.IdentPAF.Paf.ArmazenaEncerranteIniFinal;
      ACBrAAC1.IdentPAF.Paf.EmiteContrEncerrAposREDZLEIX;
      ACBrAAC1.IdentPAF.Paf.IntegradoComBombas;
      ACBrAAC1.IdentPAF.Paf.CriaAbastDivergEncerrante;
      ACBrAAC1.IdentPAF.Paf.CadastroPlacaBomba;
      ACBrAAC1.IdentPAF.Paf.TransportePassageiro;
      ACBrAAC1.IdentPAF.Paf.TotalizaValoresLista;
      ACBrAAC1.IdentPAF.Paf.TransfPreVenda;
      ACBrAAC1.IdentPAF.Paf.TransfDAV;
      ACBrAAC1.IdentPAF.Paf.NaoCoincGT;
      ACBrAAC1.IdentPAF.Paf.RecompoeGT;
      ACBrAAC1.IdentPAF.Paf.EmitePED;
      ACBrAAC1.IdentPAF.Paf.CupomMania;
      ACBrAAC1.IdentPAF.Paf.MinasLegal;
  }

  lstECFsAutorizados.Clear;
  lstECFsAutorizados.Items.BeginUpdate;
  try
    for ct:=0 to  ACBrAAC1.IdentPAF.ECFsAutorizados.Count-1 do
    begin
      with TACBrAACECF(ACBrAAC1.IdentPAF.ECFsAutorizados.Items[ct]) do
        AdicionarItemGrid(NumeroSerie, ValorGT, CRO);
    end;
  finally
    lstECFsAutorizados.Items.EndUpdate;
  end;
end;

procedure Tform1.btnECFCapturarDadosClick(Sender: TObject);
begin
  gbxECFCaptura.Enabled := False;
  try
    try
      ACBrECF.Porta  := cbxECFPorta.Text;
      ACBrECF.Modelo := TACBrECFModelo(cbxECFModelo.ItemIndex + 2);
      ACBrECF.Ativar;
    except
      on E: Exception do
      begin
        ShowMessage(
          'Erro ao conectar à porta do ECF' + sLineBreak +
          E.Message
        );
        exit;
      end;
    end;

    edNumeroSerieECF.Text := ACBrECF.NumSerie;
    edCROECF.Text         := ACBrECF.NumCRO;
    edGTECF.Text          := FormatFloat(',#0.00', ACBrECF.GrandeTotal);

    MessageDlg('Dados capturados com sucesso! O ECF será desconectado...', mtInformation, [mbOK], 0);
  finally
    ACBrECF.Desativar;
    gbxECFCaptura.Enabled := True;
  end;
end;

procedure Tform1.btnAdicionarECFClick(Sender: TObject);
begin
  try
    if Trim(edNumeroSerieECF.Text) = '' then
    begin
      edNumeroSerieECF.SetFocus;
      raise Exception.Create('Número de série do ECF inválido!');
    end;

    if Trim(edGTECF.Text) = '' then
    begin
      edNumeroSerieECF.SetFocus;
      raise Exception.Create('Valor do GT não informado!');
    end;

    AdicionarItemGrid(edNumeroSerieECF.Text, StrToNumero(edGTECF.Text), edCROECF.Value);
  except
    on E: Exception do
    begin
      edNumeroSerieECF.SetFocus;
      ShowMessage('Ocorreu o seguinte erro:' + sLineBreak + E.Message);
    end;
  end;
end;

procedure Tform1.btnExcluirECFsClick(Sender: TObject);
begin
  lstECFsAutorizados.Clear;
end;

procedure Tform1.btnSalvarArquivoClick(Sender: TObject);
begin
  recriarArquivoAuxiliar;
end;

procedure Tform1.btnSairAplicativoClick(Sender: TObject);
begin
  close;
end;

end.
