unit uSuprimento;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uBasicoModal, StdCtrls, ExtCtrls;

type
  TfrmSuprimento = class(TfrmBasicoModal)
    edtValor: TEdit;
    edtObservacao: TEdit;
    cbxIndiceBMP: TComboBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    procedure btnExecutarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmSuprimento: TfrmSuprimento;

implementation

uses
  uPrincipal;

{$R *.dfm}

procedure TfrmSuprimento.btnExecutarClick(Sender: TObject);
begin
  frmPrincipal.ACBrECF1.Suprimento(
    StrToFloat(edtValor.Text),
    edtObservacao.Text,
    'SUPRIMENTO',
    'DINHEIRO',
    cbxIndiceBMP.ItemIndex
  );
end;

end.
