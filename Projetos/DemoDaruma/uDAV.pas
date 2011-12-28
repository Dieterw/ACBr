unit uDAV;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uBasicoModal, StdCtrls, ExtCtrls, ComCtrls;

type
  TfrmDAV = class(TfrmBasicoModal)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    btnAbrirDAV: TButton;
    edtTipoDocumento: TComboBox;
    Label1: TLabel;
    edtNumero: TEdit;
    Label2: TLabel;
    edtData: TDateTimePicker;
    Label3: TLabel;
    edtSituacao: TEdit;
    Label4: TLabel;
    edtVendedor: TEdit;
    Label5: TLabel;
    edtNomeCliente: TEdit;
    Label6: TLabel;
    edtEndereco: TEdit;
    Label7: TLabel;
    edtCNPJCPF: TEdit;
    Label11: TLabel;
    btnRegistrarItem: TButton;
    btnFecharRelatorio: TButton;
    memObervacao: TMemo;
    Label14: TLabel;
    Label15: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    edtProdCodigo: TEdit;
    edtProdQuantidade: TEdit;
    edtProdUnidade: TEdit;
    edtProdDescricao: TEdit;
    Label22: TLabel;
    edtProdVlUnitario: TEdit;
    Label23: TLabel;
    edtProdVlDesconto: TEdit;
    Label24: TLabel;
    edtProdVlAcrescimo: TEdit;
    ckbProdCancelado: TCheckBox;
    procedure edtProdQuantidadeKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure btnAbrirDAVClick(Sender: TObject);
    procedure btnRegistrarItemClick(Sender: TObject);
    procedure btnFecharRelatorioClick(Sender: TObject);
  private

  public

  end;

var
  frmDAV: TfrmDAV;

implementation

uses
  uPrincipal;

{$R *.dfm}

procedure TfrmDAV.FormCreate(Sender: TObject);
begin
  inherited;

  PageControl1.ActivePageIndex := 0;
end;

procedure TfrmDAV.edtProdQuantidadeKeyPress(Sender: TObject; var Key: Char);
begin
  if not(Key in ['0'..'9', ',', #8]) then
    Key := #0;
end;

procedure TfrmDAV.btnAbrirDAVClick(Sender: TObject);
begin
  frmPrincipal.ACBrECF1.DAV_Abrir(
    edtData.DateTime,
    edtTipoDocumento.Text,
    edtNumero.Text,
    edtSituacao.Text,
    edtVendedor.Text,
    '',
    edtCNPJCPF.Text,
    edtNomeCliente.Text,
    edtEndereco.Text
  );

  PageControl1.ActivePageIndex := 1;
end;

procedure TfrmDAV.btnRegistrarItemClick(Sender: TObject);
begin
  frmPrincipal.ACBrECF1.DAV_RegistrarItem(
    edtProdCodigo.Text,
    edtProdDescricao.Text,
    edtProdUnidade.Text,
    StrToFloat(edtProdQuantidade.Text),
    StrToFloat(edtProdVlUnitario.Text),
    StrToFloat(edtProdVlDesconto.Text),
    StrToFloat(edtProdVlAcrescimo.Text),
    ckbProdCancelado.Checked
  );
end;

procedure TfrmDAV.btnFecharRelatorioClick(Sender: TObject);
begin
  frmPrincipal.ACBrECF1.DAV_Fechar(memObervacao.Text);
end;

end.

