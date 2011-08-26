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
    memResposta: TMemo;
    Label3: TLabel;
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
  uPrincipal, ACBrDevice, ACBrUtil;

{$R *.dfm}

procedure TfrmTesteModoPreVenda.btnExecutarClick(Sender: TObject);
var
  TickInicial, TickFinal: TDateTime;
  QtItens: Integer;
  I: Integer;
  TickItemIni, TickItemFim: TDateTime;

  procedure SetStatus(const AString: String; ALimpa: Boolean = False);
  begin
    if ALimpa then
      memResposta.Clear;
    memResposta.Lines.Add(AString);
  end;

  procedure RegistrarTempo(const ATempo: TDateTime);
  begin
    SetStatus('  >> ' + FormatDateTime('hh:mm:ss:zzz', ATempo));
  end;

begin
  try
    Self.Enabled := False;
    try
      QtItens := StrToInt(edtQuantItens.Text);
      with frmPrincipal do
      begin
        TickInicial := Now;

        SetStatus('Abrindo cupom fiscal...', True);
        TickItemIni := Now;
        ACBrECF1.AbreCupom('', '', '', rbtModoPreVenda.Checked);
        TickItemFim := Now;
        RegistrarTempo(TickItemFim - TickItemIni);

        SetStatus('Registrando itens...');
        TickItemIni := Now;
        for I := 1 to QtItens do
        begin
          ACBrECF1.VendeItem(
            Format('%10.10d', [I]), Format('Descrição do Item %d', [I]), 'II', 1.00, 1.00
          );
        end;
        TickItemFim := Now;
        RegistrarTempo(TickItemFim - TickItemIni);

        SetStatus('Subtotalizando o cupom fiscal...');
        TickItemIni := Now;
        ACBrECF1.SubtotalizaCupom;
        TickItemFim := Now;
        RegistrarTempo(TickItemFim - TickItemIni);

        SetStatus('Efetuando pagamento...');
        TickItemIni := Now;
        ACBrECF1.EfetuaPagamento('01', QtItens);
        TickItemFim := Now;
        RegistrarTempo(TickItemFim - TickItemIni);

        SetStatus('Fechando o cupom fiscal...');
        TickItemIni := Now;
        ACBrECF1.FechaCupom;
        TickItemFim := Now;
        RegistrarTempo(TickItemFim - TickItemIni);

        TickFinal := Now
      end;

      SetStatus(StringOfChar('-', 40));
      SetStatus('Tempo total gasto: ' + FormatDateTime('hh:mm:ss:zzz', TickFinal - TickInicial));
    finally
      Self.Enabled := True;
    end;
  except
    on E: Exception do
    begin
      MessageDlg(
        'Ocorreu o seguinte erro: ' + sLineBreak + E.Message,
        mtError,
        [mbOK],
        0
      );

      with frmPrincipal do
      begin
        if ACBrECF1.Estado in [estVenda, estPagamento] then
          ACBrECF1.CancelaCupom;
      end;
    end;
  end;
end;

end.
