unit uCupomFiscalCancelParcial;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uBasicoModal, StdCtrls, ExtCtrls;

type
  TfrmCupomFiscalCancelParcial = class(TfrmBasicoModal)
    Label27: TLabel;
    edtItemNumero: TEdit;
    Label1: TLabel;
    edtItemQuantidade: TEdit;
    procedure btnExecutarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCupomFiscalCancelParcial: TfrmCupomFiscalCancelParcial;

implementation

uses
  uPrincipal;

{$R *.dfm}

procedure TfrmCupomFiscalCancelParcial.btnExecutarClick(Sender: TObject);
begin
  inherited;

  frmPrincipal.ACBrECF1.CancelaItemVendidoParcial(
    StrToInt(edtItemNumero.Text),
    StrToFloat(edtItemQuantidade.Text)
  );

  Close;

  ShowMessage(
    'Resposta extendida: ' + sLineBreak +
    'Valor cancelado: ' + FormatFloat(',#0.00', frmPrincipal.ACBrECF1.RespostasComando['ValorCancelado'].AsFloat)
  );
end;

end.
