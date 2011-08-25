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
    lblStatus: TLabel;
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
  QtItens: Integer;
  I: Integer;

  procedure SetStatus(const ATexto: String);
  begin
    lblStatus.Caption := ATexto;
    Application.ProcessMessages;
  end;

begin
  Self.Enabled := False;
  SetStatus('');
  try
    QtItens := StrToInt(edtQuantItens.Text);

    with frmPrincipal do
    begin
      TickInicial := Now;

      SetStatus('Abrindo cupom fiscal...');
      ACBrECF1.AbreCupom('', '', '', rbtModoPreVenda.Checked);

      SetStatus('Registrando itens...');
      for I := 1 to QtItens do
      begin
        ACBrECF1.VendeItem(
          Format('%10.10d', [I]), Format('Descrição do Item %d', [I]), 'II', 1.00, 1.00
        );
      end;

      SetStatus('Subtotalizando o cupom fiscal...');
      ACBrECF1.SubtotalizaCupom;

      SetStatus('Efetuando pagamento...');
      ACBrECF1.EfetuaPagamento('01', QtItens);

      SetStatus('Fechando o cupom fiscal...');
      ACBrECF1.FechaCupom;

      TickFinal := Now
    end;

    SetStatus('Tempo gasto: ' + FormatDateTime('hh:mm:ss:zzz', TickFinal - TickInicial));
  finally
    Self.Enabled := True;
  end;
end;

end.
