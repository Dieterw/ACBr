unit uRelatorioGerencialFormatado;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uBasicoModal, StdCtrls, ExtCtrls;

type
  TfrmRelatorioGerencialFormatado = class(TfrmBasicoModal)
    memRelatorio: TMemo;
    procedure btnExecutarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmRelatorioGerencialFormatado: TfrmRelatorioGerencialFormatado;

implementation

uses
  uPrincipal;

{$R *.dfm}

procedure TfrmRelatorioGerencialFormatado.btnExecutarClick(Sender: TObject);
begin
  inherited;
  frmPrincipal.ACBrECF1.RelatorioGerencial(memRelatorio.Lines);
end;

end.

