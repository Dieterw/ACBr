unit uPrincipal;

interface

uses
  ACBrDevice, Synaser, ACBrECFDaruma,

  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ACBrBase, ACBrECF, StdCtrls, ComCtrls, ExtCtrls, Spin, jpeg, Menus,
  ACBrECFClass;

type
  TfrmPrincipal = class(TForm)
    ACBrECF1: TACBrECF;
    StatusBar1: TStatusBar;
    Image1: TImage;
    MainMenu1: TMainMenu;
    Relatrios1: TMenuItem;
    LeituraX1: TMenuItem;
    ReduoZ1: TMenuItem;
    Geraodearquivos1: TMenuItem;
    GroupBox1: TGroupBox;
    Label3: TLabel;
    Label1: TLabel;
    cbxVelocidade: TComboBox;
    cbxPortaComunicacao: TComboBox;
    btnAtivarDesativar: TButton;
    N1: TMenuItem;
    IdentificaodoPafECF1: TMenuItem;
    Image2: TImage;
    ProgramarBitmap1: TMenuItem;
    Programao1: TMenuItem;
    Sangria1: TMenuItem;
    Suprimento1: TMenuItem;
    RelatriosGerais1: TMenuItem;
    RelatrioGerencial1: TMenuItem;
    Gerais1: TMenuItem;
    CupomFiscal1: TMenuItem;
    ComprNoFiscal1: TMenuItem;
    Completo1: TMenuItem;
    Normal1: TMenuItem;
    CupomFiscal2: TMenuItem;
    Gerencialcomformatao1: TMenuItem;
    LeituraXparaarquivo1: TMenuItem;
    Label2: TLabel;
    MenuFiscal1: TMenuItem;
    MenuFiscalPafECF1: TMenuItem;
    Cancelarcupomfiscal1: TMenuItem;
    Cancelarcomprovantenofiscal1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    edtTimeout: TSpinEdit;
    Label4: TLabel;
    TesteModoPreVenda: TMenuItem;
    ckbGravarLog: TCheckBox;
    N4: TMenuItem;
    RelatriosGerenciaisCadastrados1: TMenuItem;
    lblModeloImpressora: TLabel;
    DAV1: TMenuItem;
    DAV2: TMenuItem;
    DAVOS1: TMenuItem;
    Utilitrios1: TMenuItem;
    ImpressodeCheques1: TMenuItem;
    procedure btnAtivarDesativarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure cbxPortaComunicacaoChange(Sender: TObject);
    procedure ACBrECF1ChangeEstado(const EstadoAnterior,
      EstadoAtual: TACBrECFEstado);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cbxVelocidadeChange(Sender: TObject);
    procedure LeituraX1Click(Sender: TObject);
    procedure ReduoZ1Click(Sender: TObject);
    procedure IdentificaodoPafECF1Click(Sender: TObject);
    procedure Geraodearquivos1Click(Sender: TObject);
    procedure ProgramarBitmap1Click(Sender: TObject);
    procedure Sangria1Click(Sender: TObject);
    procedure Suprimento1Click(Sender: TObject);
    procedure RelatrioGerencial1Click(Sender: TObject);
    procedure Completo1Click(Sender: TObject);
    procedure Normal1Click(Sender: TObject);
    procedure CupomFiscal2Click(Sender: TObject);
    procedure ACBrECF1BobinaAdicionaLinhas(const Linhas, Operacao: string);
    procedure ACBrECF1AntesAbreCupom(const CPF_CNPJ, Nome, Endereco: string);
    procedure Gerencialcomformatao1Click(Sender: TObject);
    procedure LeituraXparaarquivo1Click(Sender: TObject);
    procedure MenuFiscalPafECF1Click(Sender: TObject);
    procedure Cancelarcupomfiscal1Click(Sender: TObject);
    procedure Cancelarcomprovantenofiscal1Click(Sender: TObject);
    procedure edtTimeoutChange(Sender: TObject);
    procedure TesteModoPreVendaClick(Sender: TObject);
    procedure ckbGravarLogClick(Sender: TObject);
    procedure RelatriosGerenciaisCadastrados1Click(Sender: TObject);
    procedure DAV2Click(Sender: TObject);
    procedure DAVOS1Click(Sender: TObject);
    procedure ImpressodeCheques1Click(Sender: TObject);
    procedure ACBrECF1ChequeEstado(const EstadoAtual: TACBrECFCHQEstado;
      var Continuar: Boolean);
  private
    FBobinaCupom: TStringList;
    function GetIniFileName: String;
    function LerIni(const ASessao, AIdentif, ADef: String): String;
    procedure GravarIni(const ASessao, AIdentif, AValor: String);
    procedure AtivarMenus(const ALigar: Boolean);
  public
    function GetDirApp: String;
    function GetDirArquivos: String;
    function AbrirFormularioModal(AFormulario: TFormClass): TModalResult;

    property BobinaCupom: TStringList read FBobinaCupom write FBobinaCupom;
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

{$R *.dfm}

uses
  ACBrPAFClass, ACBrUtil, Math, StrUtils,

  IniFiles, uGeracaoArquivos, uIdentificacaoPafECF, uProgramarBitmap,
  uSuprimento, uSangria, uRelatorioGerencial, uComprNaoFiscalCompleto,
  uComprNaoFiscal, uCupomFiscal, uRelatorioGerencialFormatado,
  uLeituraXArquivo, uBasicoModal, uMenuFiscal, uTesteModoPreVenda, uDAV, uDAVOS,
  uImpressaoCheque;

procedure TfrmPrincipal.AtivarMenus(const ALigar: Boolean);
var
  I: Integer;
begin
  for I := 0 to MainMenu1.Items.Count - 1 do
    MainMenu1.Items[I].Enabled := ALigar;
end;

function TfrmPrincipal.AbrirFormularioModal(AFormulario: TFormClass): TModalResult;
var
  Form: TForm;
begin
  Form := AFormulario.Create(Self);
  try
    Result := Form.ShowModal;
  finally
    FreeAndNil(Form);
  end;
end;

function TfrmPrincipal.GetDirApp: String;
begin
  Result := IncludeTrailingPathDelimiter(ExtractFilePath(ParamStr(0)));
end;

function TfrmPrincipal.GetIniFileName: String;
begin
  Result := GetDirApp + 'config.ini';
end;

function TfrmPrincipal.GetDirArquivos: String;
begin
  Result := IncludeTrailingPathDelimiter(GetDirApp + 'arquivos');
end;

function TfrmPrincipal.LerIni(const ASessao, AIdentif, ADef: String): String;
var
  IniFile: TIniFile;
begin
  IniFile := TIniFile.Create(GetIniFileName);
  try
    Result := IniFile.ReadString(ASessao, AIdentif, ADef);
  finally
    IniFile.Free;
  end;
end;

procedure TfrmPrincipal.MenuFiscalPafECF1Click(Sender: TObject);
begin
  AbrirFormularioModal(TfrmMenuFiscal);
end;

procedure TfrmPrincipal.GravarIni(const ASessao, AIdentif, AValor: String);
var
  IniFile: TIniFile;
begin
  IniFile := TIniFile.Create(GetIniFileName);
  try
    IniFile.WriteString(ASessao, AIdentif, AValor);
  finally
    IniFile.Free;
  end;
end;

//******************************************************************************

procedure TfrmPrincipal.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FBobinaCupom.Free;
  ACBrECF1.Desativar;
end;

procedure TfrmPrincipal.FormCreate(Sender: TObject);
begin
  FBobinaCupom := TStringList.Create;

  ForceDirectories(GetDirArquivos);

  // Configurações do ECF
  cbxPortaComunicacao.Text := LerIni('CONFIG', 'Porta', 'COM1');
  cbxVelocidade.Text       := LerIni('CONFIG', 'Velocidade', '115200');
  edtTimeout.Text          := LerIni('CONFIG', 'Timeout', '3');
  ckbGravarLog.Checked     := LerIni('CONFIG', 'GravarLog', 'N') = 'S';

  AtivarMenus(False);
end;

//******************************************************************************

procedure TfrmPrincipal.cbxPortaComunicacaoChange(Sender: TObject);
begin
  GravarIni('CONFIG', 'Porta', cbxPortaComunicacao.Text);
end;

procedure TfrmPrincipal.cbxVelocidadeChange(Sender: TObject);
begin
  GravarIni('CONFIG', 'Velocidade', cbxVelocidade.Text);
end;

procedure TfrmPrincipal.edtTimeoutChange(Sender: TObject);
begin
  GravarIni('CONFIG', 'Timeout', edtTimeout.Text);
end;

procedure TfrmPrincipal.ckbGravarLogClick(Sender: TObject);
begin
  if ckbGravarLog.Checked then
  begin
    ACBrECF1.ArqLOG := IncludeTrailingPathDelimiter(ExtractFilePath(ParamStr(0))) + 'log_ecf.txt';
    GravarIni('CONFIG', 'GravarLog', 'S');
  end
  else
  begin
    ACBrECF1.ArqLOG := EmptyStr;
    GravarIni('CONFIG', 'GravarLog', 'N');
  end;
end;

procedure TfrmPrincipal.btnAtivarDesativarClick(Sender: TObject);
begin
  btnAtivarDesativar.Enabled := False;
  try
    if btnAtivarDesativar.Tag = 0 then
    begin
      ACBrECF1.Device.Baud := StrToInt(cbxVelocidade.Text);
      ACBrECF1.Porta       := cbxPortaComunicacao.Text;
      ACBrECF1.TimeOut     := edtTimeout.Value;
      ACBrECF1.Operador    := 'ACBrECF Teste';
      ACBrECF1.Ativar;

      AtivarMenus(True);
      btnAtivarDesativar.Caption := 'Desativar';
      btnAtivarDesativar.Tag     := 99;

      case ACBrECF1.Estado of
        estVenda, estPagamento:
          begin
            ShowMessage('Cupom fiscal aberto, o cupom será cancelado!');
            ACBrECF1.CancelaCupom;
          end;

        estNaoFiscal:
          begin
            ShowMessage('Comprovante não fiscal aberto, o comprovante será cancelado!');
            ACBrECF1.CancelaNaoFiscal;
          end;
      end;

      ACBrECF1.CarregaAliquotas;
      ACBrECF1.CarregaFormasPagamento;
      ACBrECF1.CarregaComprovantesNaoFiscais;
      ACBrECF1.CarregaRelatoriosGerenciais;
      ACBrECF1.CarregaUnidadesMedida;

      ACBrECF1.IdentificaOperador(NOME_OPERADOR);

      lblModeloImpressora.Caption :=
        ACBrECF1.ModeloStr + sLineBreak +
        ACBrECF1.SubModeloECF + sLineBreak + sLineBreak +
        'COO: ' + ACBrECF1.NumCOO + sLineBreak +
        'NumCupom: ' + ACBrECF1.NumCupom + sLineBreak +
        'NumCCF: ' + ACBrECF1.NumCCF;

    end
    else
    begin
      ACBrECF1.Desativar;
      btnAtivarDesativar.Caption := 'Ativar';
      btnAtivarDesativar.Tag     := 0;

      AtivarMenus(False);
      StatusBar1.Panels[1].Text := '';
    end;
  finally
    btnAtivarDesativar.Enabled := True;
  end;
end;

//******************************************************************************

procedure TfrmPrincipal.ACBrECF1AntesAbreCupom(const CPF_CNPJ, Nome,
  Endereco: string);
begin
  FBobinaCupom.Clear;
end;

procedure TfrmPrincipal.ACBrECF1BobinaAdicionaLinhas(const Linhas,
  Operacao: string);
begin
  FBobinaCupom.Add(Linhas);
end;

procedure TfrmPrincipal.ACBrECF1ChangeEstado(const EstadoAnterior,
  EstadoAtual: TACBrECFEstado);
var
  Estado: String;
begin
  case EstadoAtual of
    estNaoInicializada: Estado := 'Impressora inicializada';
    estDesconhecido:    Estado := 'Estado desconhecido';
    estLivre:           Estado := 'Impressora livre';
    estVenda:           Estado := 'Venda iniciada';
    estPagamento:       Estado := 'Formas de pagamento iniciadas';
    estRelatorio:       Estado := 'Relatório aberto';
    estBloqueada:       Estado := 'Impressora bloqueada';
    estRequerZ:         Estado := 'Requer Z';
    estRequerX:         Estado := 'Requer X';
    estNaoFiscal:       Estado := 'Não fiscal aberto';
  end;

  StatusBar1.Panels[1].Text := Estado;
end;

procedure TfrmPrincipal.ACBrECF1ChequeEstado(
  const EstadoAtual: TACBrECFCHQEstado; var Continuar: Boolean);
begin
  // mensagens de estado da impressão de cheques
  case EstadoAtual of
    chqIdle:
      begin
        StatusBar1.Panels[1].Text := '...';
      end;

    chqPosicione:
      begin
        Continuar := MessageDlg('Posione o cheque e clique em continuar', mtConfirmation, mbYesNo, 0) = ID_YES;
      end;

    chqImprimindo:
      begin
        StatusBar1.Panels[1].Text := 'Imprimindo, aguarde...';
      end;

    chqFimImpressao:
      begin
        StatusBar1.Panels[1].Text := 'Fim da impressão.';
        ShowMessage(StatusBar1.Panels[1].Text);
      end;

    chqRetire:
      begin
        StatusBar1.Panels[1].Text := 'Retire o cheque.';
        ShowMessage(StatusBar1.Panels[1].Text);
      end;

    chqAutenticacao:
      begin
        Continuar := MessageDlg('Posione o cheque e clique em continuar', mtConfirmation, mbYesNo, 0) = ID_YES;
      end;
  end;
end;

//******************************************************************************

procedure TfrmPrincipal.LeituraX1Click(Sender: TObject);
begin
  ACBrECF1.LeituraX;
  ShowMessage('COO: ' + ACBrECF1.NumCOO);
end;

procedure TfrmPrincipal.LeituraXparaarquivo1Click(Sender: TObject);
begin
  AbrirFormularioModal(TfrmLeituraXArquivo)
end;

procedure TfrmPrincipal.ReduoZ1Click(Sender: TObject);
begin
  if Application.MessageBox(
    'Será emitido a redução Z, deseja continuar?',
    'Redução Z',
    MB_ICONQUESTION + MB_YESNO
  ) = ID_YES then
  begin
    ACBrECF1.ReducaoZ(Now);
  end;
end;

procedure TfrmPrincipal.Cancelarcomprovantenofiscal1Click(Sender: TObject);
begin
  ACBrECF1.CancelaNaoFiscal;
end;

procedure TfrmPrincipal.Cancelarcupomfiscal1Click(Sender: TObject);
begin
  ACBrECF1.CancelaCupom;
  ShowMessage(
    'Cupom cancelado.' + sLineBreak + sLineBreak +
    'Resposta extendida:' + sLineBreak +
    'COO do cupom cancelado: ' + ACBrECF1.RespostasComando['COO'].AsString + sLineBreak +
    'CCF do cupom cancelado: ' + ACBrECF1.RespostasComando['CCF'].AsString + sLineBreak +
    'Valor cancelado: ' + FormatFloat(',#0.00', ACBrECF1.RespostasComando['ValorCancelado'].AsFloat)
  );
end;

procedure TfrmPrincipal.RelatrioGerencial1Click(Sender: TObject);
begin
  AbrirFormularioModal(TfrmRelatorioGerencial);
end;

procedure TfrmPrincipal.RelatriosGerenciaisCadastrados1Click(Sender: TObject);
var
  I: Integer;
  Msg: String;
begin
  ACBrECF1.CarregaRelatoriosGerenciais;

  Msg := 'Relatórios gerenciais:' + sLineBreak + sLineBreak;
  for I := 0 to ACBrECF1.RelatoriosGerenciais.Count -1 do
  begin
    if ACBrECF1.RelatoriosGerenciais[I].Descricao <> '' then
    begin
      Msg := Msg + sLineBreak +
        ACBrECF1.RelatoriosGerenciais[I].Indice + ' -> ' +
        ACBrECF1.RelatoriosGerenciais[I].Descricao +
        ' CER:'+ IntToStr(ACBrECF1.RelatoriosGerenciais[I].Contador);
    end;
  end;

  ShowMessage(Msg);
end;

procedure TfrmPrincipal.Sangria1Click(Sender: TObject);
begin
  AbrirFormularioModal(TfrmSangria);
end;

procedure TfrmPrincipal.Suprimento1Click(Sender: TObject);
begin
  AbrirFormularioModal(TfrmSuprimento);
end;

procedure TfrmPrincipal.TesteModoPreVendaClick(Sender: TObject);
begin
  AbrirFormularioModal(TfrmTesteModoPreVenda);
end;

procedure TfrmPrincipal.IdentificaodoPafECF1Click(Sender: TObject);
begin
  AbrirFormularioModal(TfrmIdentificacaoPafECF);
end;

procedure TfrmPrincipal.ImpressodeCheques1Click(Sender: TObject);
begin
  AbrirFormularioModal(TfrmImpressaoCheque);
end;

procedure TfrmPrincipal.Geraodearquivos1Click(Sender: TObject);
begin
  AbrirFormularioModal(TfrmGeracaoArquivos);
end;

procedure TfrmPrincipal.Gerencialcomformatao1Click(Sender: TObject);
begin
  AbrirFormularioModal(TfrmRelatorioGerencialFormatado);
end;

procedure TfrmPrincipal.ProgramarBitmap1Click(Sender: TObject);
begin
  AbrirFormularioModal(TfrmProgramarBitmap);
end;

procedure TfrmPrincipal.Completo1Click(Sender: TObject);
begin
  AbrirFormularioModal(TfrmComprNaoFiscalCompleto);
end;

procedure TfrmPrincipal.CupomFiscal2Click(Sender: TObject);
begin
  AbrirFormularioModal(TfrmCupomFiscal);
end;

procedure TfrmPrincipal.DAV2Click(Sender: TObject);
begin
  AbrirFormularioModal(TfrmDAV);
end;

procedure TfrmPrincipal.DAVOS1Click(Sender: TObject);
begin
  AbrirFormularioModal(TfrmDAVOS);
end;

procedure TfrmPrincipal.Normal1Click(Sender: TObject);
begin
  AbrirFormularioModal(TfrmComprNaoFiscal);
end;

end.