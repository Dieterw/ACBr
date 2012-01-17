unit uCupomFiscal;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uBasicoModal, StdCtrls, ExtCtrls, ComCtrls, OleCtrls, SHDocVw;

type
  TfrmCupomFiscal = class(TfrmBasicoModal)
    pgcInfo: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    TabSheet4: TTabSheet;
    TabSheet5: TTabSheet;
    Label16: TLabel;
    Label17: TLabel;
    edtFechamentoObs1: TEdit;
    cbxIndiceBMP: TComboBox;
    btnFechamento: TButton;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    cbxMeioPagto: TComboBox;
    edtPagtoVlr: TEdit;
    btnRegistrarPagto: TButton;
    edtPagtoObs: TEdit;
    Label9: TLabel;
    Label10: TLabel;
    Label20: TLabel;
    edtSubtotalDescAcrescVlr: TEdit;
    btnSubtotalizar: TButton;
    edtSubtotalObs: TEdit;
    btnAbrirCupom: TButton;
    btnItemRegistrar: TButton;
    GroupBox3: TGroupBox;
    Label25: TLabel;
    Label26: TLabel;
    Label27: TLabel;
    edtItemDescAcresTipo: TComboBox;
    edtItemDescAcreModo: TComboBox;
    edtItemDescAcreValor: TEdit;
    btnItemCancelarParcial: TButton;
    btnItemCancelarTotal: TButton;
    Bevel1: TBevel;
    GroupBox2: TGroupBox;
    Label6: TLabel;
    Label7: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    ckbLegendaInmetro: TCheckBox;
    edtItemCodigo: TEdit;
    edtItemDescricao: TEdit;
    edtItemQuantidade: TEdit;
    edtItemVlUnitario: TEdit;
    edtItemUnidade: TEdit;
    edtItemAliquota: TComboBox;
    gbxBobina: TGroupBox;
    WebBrowser1: TWebBrowser;
    GroupBox4: TGroupBox;
    Label8: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    edtSubtotal: TEdit;
    edtValorPago: TEdit;
    edtValorTroco: TEdit;
    btnItemDescAcrescAnterior: TButton;
    edtFechamentoObs2: TEdit;
    edtFechamentoObs3: TEdit;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    edtClienteNome: TEdit;
    edtClienteCpfCnpj: TEdit;
    edtClienteEndereco: TEdit;
    btnIdentificaCliente: TButton;
    edtMD5App: TEdit;
    edtIdDAV: TEdit;
    edtIdDAVOS: TEdit;
    Label4: TLabel;
    edtIdPrevenda: TEdit;
    Label5: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label28: TLabel;
    ckbMinasLegal: TCheckBox;
    StatusBar1: TStatusBar;
    ckbCupomMania: TCheckBox;
    procedure btnAbrirCupomClick(Sender: TObject);
    procedure btnSubtotalizarClick(Sender: TObject);
    procedure btnRegistrarPagtoClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnFechamentoClick(Sender: TObject);
    procedure btnIdentificaClienteClick(Sender: TObject);
    procedure btnItemRegistrarClick(Sender: TObject);
    procedure btnItemCancelarTotalClick(Sender: TObject);
    procedure btnItemCancelarParcialClick(Sender: TObject);
    procedure btnItemDescAcrescAnteriorClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure WebBrowser1DocumentComplete(Sender: TObject;
      const pDisp: IDispatch; var URL: OleVariant);
  private
    procedure AtualizarTela;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCupomFiscal: TfrmCupomFiscal;

implementation

uses
  uPrincipal, ACBrDevice, uCupomFiscalCancelParcial,
  uCupomFiscalDescAcresAnterior;

{$R *.dfm}

procedure TfrmCupomFiscal.AtualizarTela;
var
  VlSubTotal, VlPago, VlTroco: Double;
begin
  // Obter valores
  VlSubTotal := frmPrincipal.ACBrECF1.Subtotal;
  VlPago     := frmPrincipal.ACBrECF1.TotalPago;
  VlTroco    := VlPago - VlSubTotal;

  // atualizar os valores totais na tela
  edtSubtotal.Text   := FormatFloat(',#0.00', VlSubTotal);
  edtValorPago.Text  := FormatFloat(',#0.00', VlPago);
  edtValorTroco.Text := FormatFloat(',#0.00', VlTroco);

  // Atualizar a bobina do cupom fiscal
  WB_LoadHTML(WebBrowser1, frmPrincipal.BobinaCupom.Text);
end;

procedure TfrmCupomFiscal.WebBrowser1DocumentComplete(Sender: TObject;
  const pDisp: IDispatch; var URL: OleVariant);
begin
  WB_ScrollToBottom(WebBrowser1);
end;

procedure TfrmCupomFiscal.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;

  if frmPrincipal.ACBrECF1.Estado in [estVenda, estPagamento] then
    frmPrincipal.ACBrECF1.CancelaCupom;
end;

procedure TfrmCupomFiscal.FormCreate(Sender: TObject);
begin
  inherited;

  frmPrincipal.BobinaCupom.Clear;

  Self.ClearFields;
  PopularMeiosPagamento(cbxMeioPagto);

  edtItemCodigo.Text := 'A1234569789';
  edtItemDescricao.Text := 'DESCRICAO DO PRODUTO';
  edtItemQuantidade.Text := '1';
  edtItemVlUnitario.Text := '1,00';
  edtItemUnidade.Text := 'UN';
  edtItemAliquota.ItemIndex := 0;
  edtItemDescAcreValor.Text := '0,00';

  edtPagtoVlr.Text := '0,00';
  edtSubtotalDescAcrescVlr.Text := '0,00';
  edtSubtotal.Text := '0,00';
  edtValorPago.Text := '0,00';
  edtValorTroco.Text := '0,00';
  pgcInfo.ActivePageIndex := 0;

  edtFechamentoObs1.Text := '<e>ACBrECF</e>';
  edtFechamentoObs2.Text := '<n>Demonstração ACBr com Daruma</n>';
  edtFechamentoObs3.Text := '<ean13>123456789012</ean13>';
end;

procedure TfrmCupomFiscal.btnAbrirCupomClick(Sender: TObject);
begin
  frmPrincipal.ACBrECF1.IdentificaOperador(NOME_OPERADOR);

  frmPrincipal.ACBrECF1.AbreCupom(
    edtClienteCpfCnpj.Text,
    edtClienteNome.Text,
    edtClienteEndereco.Text
  );

  StatusBar1.Panels.Clear;
  with StatusBar1.Panels.Add do
  begin
    Text  := 'COO: ' + frmPrincipal.ACBrECF1.RespostasComando['COO'].AsString;
    // pode utilizar também
    // Text := 'COO: ' + frmPrincipal.ACBrECF1.NumCupom;
    Width := 100;
  end;

  with StatusBar1.Panels.Add do
  begin
    Text  := 'CCF: ' + frmPrincipal.ACBrECF1.RespostasComando['CCF'].AsString;
    // Pode utilizar também
    // Text := 'CCF: ' + frmPrincipal.ACBrECF1.NumCCF;
    Width := 100;
  end;

  with StatusBar1.Panels.Add do
  begin
    Text  := 'NumItem: ' + IntToStr(frmPrincipal.ACBrECF1.NumUltItem);
    Width := 100;
  end;

  pgcInfo.ActivePageIndex := 1;
  AtualizarTela;
end;

procedure TfrmCupomFiscal.btnIdentificaClienteClick(Sender: TObject);
begin
  if Application.MessageBox(
    'Deseja realmente identificar o cupom fiscal com os dados de cliente informados?',
    'Identificar Cliente',
    MB_ICONQUESTION + MB_YESNO
  ) = ID_YES then
  begin
    frmPrincipal.ACBrECF1.IdentificaConsumidor(
      edtClienteCpfCnpj.Text,
      edtClienteNome.Text,
      edtClienteEndereco.Text
    );
  end;
end;

procedure TfrmCupomFiscal.btnItemRegistrarClick(Sender: TObject);
var
  TipoDescAcresc: String;
  ModoDescAcresc: String;
begin
  btnItemRegistrar.Enabled := False;
  try
    // modo (desconto ou acréscimo)
    if edtItemDescAcreModo.ItemIndex = 0 then
      ModoDescAcresc := 'D'
    else
      ModoDescAcresc := 'A';

    // Tipo (percentual ou valor)
    if edtItemDescAcresTipo.ItemIndex = 0 then
      TipoDescAcresc := '%'
    else
      TipoDescAcresc := '$';

    // utilizar ou não legenda do inmetro
    if ckbLegendaInmetro.Checked then
      frmPrincipal.ACBrECF1.LegendaInmetroProximoItem;

    // venda do item
    frmPrincipal.ACBrECF1.VendeItem(
      edtItemCodigo.Text,
      edtItemDescricao.Text,
      edtItemAliquota.Text,
      StrToFloat(edtItemQuantidade.Text),
      StrToFloat(edtItemVlUnitario.Text),
      StrToFloat(edtItemDescAcreValor.Text),
      edtItemUnidade.Text,
      TipoDescAcresc,
      ModoDescAcresc
    );

    StatusBar1.Panels.Clear;
    with StatusBar1.Panels.Add do
    begin
      Text  := 'Item: ' + frmPrincipal.ACBrECF1.RespostasComando['NumeroItem'].AsString;;
      Width := 100;
    end;

    with StatusBar1.Panels.Add do
    begin
      Text  := 'Valor Líquido: ' + FormatFloat(',#0.00', frmPrincipal.ACBrECF1.RespostasComando['ValorLiquido'].AsFloat);
      Width := 250;
    end;

    AtualizarTela;
  finally
    btnItemRegistrar.Enabled := True;
  end;
end;

procedure TfrmCupomFiscal.btnItemCancelarParcialClick(Sender: TObject);
begin
  frmPrincipal.AbrirFormularioModal(TfrmCupomFiscalCancelParcial);
  AtualizarTela;
end;

procedure TfrmCupomFiscal.btnItemCancelarTotalClick(Sender: TObject);
var
  NumItem: Integer;
  Digitado: String;
begin
  if InputQuery(
    'Cancelar Item',
    'Informe o número do item que deseja cancelar', Digitado) then
  begin
    NumItem := StrToInt(Digitado);
    frmPrincipal.ACBrECF1.CancelaItemVendido(NumItem);
    AtualizarTela;

    ShowMessage(
      'Valor cancelado: ' + FormatFloat(',#0.00', frmPrincipal.ACBrECF1.RespostasComando['ValorCancelado'].AsFloat)
    );
  end;
end;

procedure TfrmCupomFiscal.btnItemDescAcrescAnteriorClick(Sender: TObject);
begin
  frmPrincipal.AbrirFormularioModal(TfrmCupomFiscalDescAcresAnterior);
  AtualizarTela;
end;

procedure TfrmCupomFiscal.btnSubtotalizarClick(Sender: TObject);
begin
  frmPrincipal.ACBrECF1.SubtotalizaCupom(
    StrToFloat(edtSubtotalDescAcrescVlr.Text),
    edtSubtotalObs.Text
  );

  StatusBar1.Panels.Clear;
  with StatusBar1.Panels.Add do
  begin
    Text  := 'Sub-Total: ' + FormatFloat(',#0.00', frmPrincipal.ACBrECF1.RespostasComando['SubTotal'].AsFloat);
    Width := 250;
  end;

  pgcInfo.ActivePageIndex := 3;
  AtualizarTela;
end;

procedure TfrmCupomFiscal.btnRegistrarPagtoClick(Sender: TObject);
var
  Valor: Double;
begin
  Valor := StrToFloat(edtPagtoVlr.Text);

  frmPrincipal.ACBrECF1.EfetuaPagamento(
    Copy(cbxMeioPagto.Text, 1, 2),
    Valor,
    edtPagtoObs.Text
  );

  AtualizarTela;

  StatusBar1.Panels.Clear;
  with StatusBar1.Panels.Add do
  begin
    Valor := frmPrincipal.ACBrECF1.RespostasComando['Saldo'].AsFloat;
    if Valor > 0 then
      Text := 'A Pagar: ' + FormatFloat(',#0.00', Valor)
    else
      Text := 'Troco: ' + FormatFloat(',#0.00', Valor);

    Width := 300;
  end;

  if StrToFloat(edtValorTroco.Text) >= 0 then
    pgcInfo.ActivePageIndex := 4;
end;

procedure TfrmCupomFiscal.btnFechamentoClick(Sender: TObject);
var
  Observacao: String;
begin
  frmPrincipal.ACBrECF1.InfoRodapeCupom.MD5        := edtMD5App.Text;
  frmPrincipal.ACBrECF1.InfoRodapeCupom.Dav        := edtIdDAV.Text;
  frmPrincipal.ACBrECF1.InfoRodapeCupom.DavOs      := edtIdDAVOS.Text;
  frmPrincipal.ACBrECF1.InfoRodapeCupom.PreVenda   := edtIdPrevenda.Text;
  frmPrincipal.ACBrECF1.InfoRodapeCupom.CupomMania := ckbCupomMania.Checked;
  frmPrincipal.ACBrECF1.InfoRodapeCupom.MinasLegal := ckbMinasLegal.Checked;


  Observacao :=
    edtFechamentoObs1.Text + sLineBreak +
    edtFechamentoObs2.Text + sLineBreak +
    edtFechamentoObs3.Text;

  frmPrincipal.ACBrECF1.FechaCupom(Observacao, cbxIndiceBMP.ItemIndex);

  ShowMessage(
    'Cupom fechado.' + sLineBreak + sLineBreak +
    'Resposta extendida:' + sLineBreak +
    'COO: ' + frmPrincipal.ACBrECF1.RespostasComando['COO'].AsString + sLineBreak +
    'Total Líquido: ' + FormatFloat(',#0.00', frmPrincipal.ACBrECF1.RespostasComando['TotalLiquido'].AsFloat)
  );

  {
    Pode-se utilizar as propriedades:
      frmPrincipal.ACBrECF1.NumCupom
      frmPrincipal.ACBrECF1.SubTotal

    Agora elas são atualizadas pelo retorno extendido.
  }

  AtualizarTela;
  Close;
end;

end.



