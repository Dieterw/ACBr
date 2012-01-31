unit uTrocarBandeja;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls;

type
  TfrmTrocarBandeja = class(TForm)
    rdgBandeja: TRadioGroup;
    btnTrocarChip: TButton;
    btnCancelar: TButton;
    procedure btnTrocarChipClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmTrocarBandeja: TfrmTrocarBandeja;

implementation

uses
  uPrincipal, ACBrSMSClass;

{$R *.dfm}

procedure TfrmTrocarBandeja.btnCancelarClick(Sender: TObject);
begin
  Self.Close;
end;

procedure TfrmTrocarBandeja.btnTrocarChipClick(Sender: TObject);
begin
  if rdgBandeja.ItemIndex = 0 then
    frmPrincipal.ACBrSMS1.TrocarBandeja(sin1)
  else
    frmPrincipal.ACBrSMS1.TrocarBandeja(sin2);

  ShowMessage(
    'Pronto.' +
    sLineBreak +
    sLineBreak +
    'Última resposta:' + sLineBreak +
    String(frmPrincipal.ACBrSMS1.UltimaResposta)
  );
end;

end.
