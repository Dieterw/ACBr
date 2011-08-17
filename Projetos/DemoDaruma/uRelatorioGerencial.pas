unit uRelatorioGerencial;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uBasicoModal, StdCtrls, ExtCtrls;

type
  TfrmRelatorioGerencial = class(TfrmBasicoModal)
    Label1: TLabel;
    cbxIdxRelatorio: TComboBox;
    edtTexto1: TEdit;
    cbxIdxBMP1: TComboBox;
    Label3: TLabel;
    cbxIdxBMP2: TComboBox;
    edtTexto2: TEdit;
    cbxIdxBMP3: TComboBox;
    edtTexto3: TEdit;
    cbxIdxBMP4: TComboBox;
    edtTexto4: TEdit;
    cbxIdxBMP5: TComboBox;
    edtTexto5: TEdit;
    Label4: TLabel;
    procedure btnExecutarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmRelatorioGerencial: TfrmRelatorioGerencial;

implementation

uses
  uPrincipal;

{$R *.dfm}

procedure TfrmRelatorioGerencial.FormCreate(Sender: TObject);
begin
  PopularRelGerencial(cbxIdxRelatorio);
end;

procedure TfrmRelatorioGerencial.btnExecutarClick(Sender: TObject);
begin
  with frmPrincipal do
  begin
    ACBrECF1.AbreRelatorioGerencial(cbxIdxRelatorio.ItemIndex + 1);

    ACBrECF1.LinhaRelatorioGerencial(edtTexto1.Text, cbxIdxBMP1.ItemIndex);
    ACBrECF1.LinhaRelatorioGerencial(edtTexto2.Text, cbxIdxBMP2.ItemIndex);
    ACBrECF1.LinhaRelatorioGerencial(edtTexto3.Text, cbxIdxBMP3.ItemIndex);
    ACBrECF1.LinhaRelatorioGerencial(edtTexto4.Text, cbxIdxBMP4.ItemIndex);
    ACBrECF1.LinhaRelatorioGerencial(edtTexto5.Text, cbxIdxBMP5.ItemIndex);

    ACBrECF1.FechaRelatorio;
  end;
end;

end.
