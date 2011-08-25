unit uTesteModoPreVenda;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uBasicoModal, StdCtrls, ExtCtrls;

type
  TfrmTesteModoPreVenda = class(TfrmBasicoModal)
    rbtNormal: TRadioButton;
    rbtModoPreVenda: TRadioButton;
    edtQuantItens: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    procedure btnExecutarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmTesteModoPreVenda: TfrmTesteModoPreVenda;

implementation

uses
  uPrincipal;

{$R *.dfm}

procedure TfrmTesteModoPreVenda.btnExecutarClick(Sender: TObject);
var
  TickInicial, TickFinal: TDateTime;
  Tipo: String;
  QtItens: Integer;
  I: Integer;
begin
  Self.Enabled := False;
  try
    QtItens := StrToInt(edtQuantItens.Text);

    with frmPrincipal do
    begin
      TickInicial := Now;
      ACBrECF1.AbreCupom('', '', '', rbtModoPreVenda.Checked);
      for I := 1 to QtItens do
      begin
        ACBrECF1.VendeItem(
          Format('%10.10d', [I]), Format('Descrição do Item %d', [I]), 'II', 1.00, 1.00
        );
      end;
      ACBrECF1.SubtotalizaCupom;
      ACBrECF1.EfetuaPagamento('01', QtItens);
      ACBrECF1.FechaCupom;
      TickFinal := Now
    end;

    if rbtModoPreVenda.Checked then
      Tipo := 'Modo PRÉ_VENDA - '
    else
      Tipo := 'Modo NORMAL - ';

    ShowMessage(
      Tipo + 'Tempo gasto: ' + FormatDateTime('hh:mm:ss:zzz', TickFinal - TickInicial)
    );
  finally
    Self.Enabled := True;
  end;
end;

end.
