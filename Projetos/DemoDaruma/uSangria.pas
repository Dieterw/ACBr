unit uSangria;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uBasicoModal, StdCtrls, ExtCtrls;

type
  TfrmSangria = class(TfrmBasicoModal)
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
  frmSangria: TfrmSangria;

implementation

uses
  uPrincipal;

{$R *.dfm}

procedure TfrmSangria.btnExecutarClick(Sender: TObject);
begin
  frmPrincipal.ACBrECF1.Sangria(
    StrToFloat(edtValor.Text),
    edtObservacao.Text,
    'SANGRIA',
    'DINHEIRO',
    cbxIndiceBMP.ItemIndex
  );
end;

end.
