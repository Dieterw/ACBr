unit uIdentificacaoPafECF;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uBasicoModal, StdCtrls, ExtCtrls;

type
  TfrmIdentificacaoPafECF = class(TfrmBasicoModal)
    edtLinha1: TEdit;
    edtLinha2: TEdit;
    procedure btnExecutarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmIdentificacaoPafECF: TfrmIdentificacaoPafECF;

implementation

uses
  uPrincipal;

{$R *.dfm}

procedure TfrmIdentificacaoPafECF.btnExecutarClick(Sender: TObject);
begin
  inherited;

  frmPrincipal.ACBrECF1.IdentificaPAF(edtLinha1.Text, edtLinha2.Text);
  ShowMessage('Aplicativo Paf-ECf identificado com sucesso!');
end;

end.
