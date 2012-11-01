unit uImpressaoCheque;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uBasicoModal, StdCtrls, ExtCtrls, Spin, ComCtrls, ACBrBase, ACBrCHQ;

type
  TfrmImpressaoCheque = class(TfrmBasicoModal)
    edtBanco: TSpinEdit;
    edtValor: TEdit;
    edtFavorecido: TEdit;
    edtCidade: TEdit;
    edtData: TDateTimePicker;
    edtObservacao: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    procedure btnExecutarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmImpressaoCheque: TfrmImpressaoCheque;

implementation

uses
  uPrincipal;

{$R *.dfm}

procedure TfrmImpressaoCheque.btnExecutarClick(Sender: TObject);
begin
  if not frmPrincipal.ACBrECF1.ChequePronto then
    raise Exception.Create('Cheque não está pronto!');

  frmPrincipal.ACBrECF1.ImprimeCheque(
    Format('%3.3d', [edtBanco.Value]),
    StrToFloat(edtValor.Text),
    edtFavorecido.Text,
    edtCidade.Text,
    edtData.Date,
    edtObservacao.Text
  );
end;

end.
