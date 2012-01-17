unit uComprNaoFiscal;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uBasicoModal, StdCtrls, ExtCtrls, Spin, ComCtrls, OleCtrls, SHDocVw;

type
  TfrmComprNaoFiscal = class(TfrmBasicoModal)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    TabSheet4: TTabSheet;
    TabSheet5: TTabSheet;
    btnAbrirComprovante: TButton;
    Label16: TLabel;
    Label17: TLabel;
    cbxIndiceBMP: TComboBox;
    btnFechamento: TButton;
    Label4: TLabel;
    cbxTotalizador: TComboBox;
    Label5: TLabel;
    edtItemVlr: TEdit;
    btnItemRegistrar: TButton;
    btnItemCancelar: TButton;
    Label9: TLabel;
    edtSubtotalDescAcrescVlr: TEdit;
    btnSubtotalizar: TButton;
    edtSubtotalObs: TEdit;
    Label10: TLabel;
    Label13: TLabel;
    cbxMeioPagto: TComboBox;
    Label14: TLabel;
    edtPagtoVlr: TEdit;
    btnRegistrarPagto: TButton;
    Label15: TLabel;
    edtPagtoObs: TEdit;
    Label20: TLabel;
    edtFechamentoObs1: TEdit;
    edtFechamentoObs2: TEdit;
    edtFechamentoObs3: TEdit;
    GroupBox2: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    edtClienteNome: TEdit;
    edtClienteCpfCnpj: TEdit;
    edtClienteEndereco: TEdit;
    btnIdentificaCliente: TButton;
    gbxBobina: TGroupBox;
    GroupBox4: TGroupBox;
    Label8: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    edtSubtotal: TEdit;
    edtValorPago: TEdit;
    edtValorTroco: TEdit;
    WebBrowser1: TWebBrowser;
    procedure btnAbrirComprovanteClick(Sender: TObject);
    procedure btnItemRegistrarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnItemCancelarClick(Sender: TObject);
    procedure btnSubtotalizarClick(Sender: TObject);
    procedure btnRegistrarPagtoClick(Sender: TObject);
    procedure btnFechamentoClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure WebBrowser1DocumentComplete(Sender: TObject;
      const pDisp: IDispatch; var URL: OleVariant);
  private
    procedure AtualizarTela;
  public

  end;

var
  frmComprNaoFiscal: TfrmComprNaoFiscal;

implementation

uses
  uPrincipal, ACBrDevice;

{$R *.dfm}

procedure TfrmComprNaoFiscal.AtualizarTela;
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

procedure TfrmComprNaoFiscal.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;

  // verificar se o comprovante se encontra aberto se sim, cancelar
  if frmPrincipal.ACBrECF1.Estado in [estNaoFiscal] then
    frmPrincipal.ACBrECF1.CancelaNaoFiscal;
end;

procedure TfrmComprNaoFiscal.FormCreate(Sender: TObject);
begin
  inherited;

  frmPrincipal.BobinaCupom.Clear;

  Self.ClearFields;
  PopularTotalizadoresNaoFiscais(cbxTotalizador);
  PopularMeiosPagamento(cbxMeioPagto);

  edtItemVlr.Text := '1,00';
  edtPagtoVlr.Text := '0,00';
  edtSubtotalDescAcrescVlr.Text := '0,00';
  edtSubtotal.Text := '0,00';
  edtValorPago.Text := '0,00';
  edtValorTroco.Text := '0,00';
  PageControl1.ActivePageIndex := 0;

  edtFechamentoObs1.Text := '<e>ACBrECF</e>';
  edtFechamentoObs2.Text := '<n>Demonstração ACBr com Daruma</n>';
  edtFechamentoObs3.Text := '<ean13>123456789012</ean13>';
end;

procedure TfrmComprNaoFiscal.btnAbrirComprovanteClick(Sender: TObject);
begin
  frmPrincipal.ACBrECF1.IdentificaOperador(NOME_OPERADOR);

  frmPrincipal.ACBrECF1.AbreNaoFiscal(
    edtClienteCpfCnpj.Text,
    edtClienteNome.Text,
    edtClienteEndereco.Text
  );

  PageControl1.ActivePageIndex := 1;
  AtualizarTela;
end;

procedure TfrmComprNaoFiscal.btnItemRegistrarClick(Sender: TObject);
var
  Valor: Double;
  Descricao: String;
begin
  Valor := StrToFloat(edtItemVlr.Text);

  frmPrincipal.ACBrECF1.RegistraItemNaoFiscal(
    Copy(cbxTotalizador.Text, 1, 2), Valor
  );

  Descricao := Copy(cbxTotalizador.Text, 6, Length(cbxTotalizador.Text));
  AtualizarTela;
end;

procedure TfrmComprNaoFiscal.btnItemCancelarClick(Sender: TObject);
var
  NumItem: Integer;
  Digitado: String;
begin
  if InputQuery(
    'Cancelar Item',
    'Informe o número do item que deseja cancelar', Digitado) then
  begin
    NumItem := StrToInt(Digitado);
    frmPrincipal.ACBrECF1.CancelaItemNaoFiscal(NumItem);
    AtualizarTela;;
  end;
end;

procedure TfrmComprNaoFiscal.btnSubtotalizarClick(Sender: TObject);
begin
  frmPrincipal.ACBrECF1.SubtotalizaNaoFiscal(
    StrToFloat(edtSubtotalDescAcrescVlr.Text),
    edtSubtotalObs.Text
  );

  AtualizarTela;
  PageControl1.ActivePageIndex := 3;
end;

procedure TfrmComprNaoFiscal.btnRegistrarPagtoClick(Sender: TObject);
var
  Valor: Double;
begin
  Valor := StrToFloat(edtPagtoVlr.Text);

  frmPrincipal.ACBrECF1.EfetuaPagamentoNaoFiscal(
    Copy(cbxMeioPagto.Text, 1, 2),
    Valor,
    edtPagtoObs.Text
  );

  AtualizarTela;

  if StrToFloat(edtValorTroco.Text) >= 0 then
    PageControl1.ActivePageIndex := 4;
end;

procedure TfrmComprNaoFiscal.btnFechamentoClick(Sender: TObject);
var
  Observacao: String;
  CupomCCD: TStringList;
begin
  Observacao :=
    edtFechamentoObs1.Text + sLineBreak +
    edtFechamentoObs2.Text + sLineBreak +
    edtFechamentoObs3.Text;

  frmPrincipal.ACBrECF1.FechaNaoFiscal(
    Observacao,
    cbxIndiceBMP.ItemIndex
  );

  AtualizarTela;
  Close;
end;

procedure TfrmComprNaoFiscal.WebBrowser1DocumentComplete(Sender: TObject;
  const pDisp: IDispatch; var URL: OleVariant);
begin
  WB_ScrollToBottom(WebBrowser1);
end;

end.

