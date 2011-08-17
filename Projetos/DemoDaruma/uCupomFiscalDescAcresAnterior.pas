unit uCupomFiscalDescAcresAnterior;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uBasicoModal, StdCtrls, ExtCtrls;

type
  TfrmCupomFiscalDescAcresAnterior = class(TfrmBasicoModal)
    Label25: TLabel;
    Label26: TLabel;
    Label27: TLabel;
    edtItemDescAcresTipo: TComboBox;
    edtItemDescAcreModo: TComboBox;
    edtItemDescAcreValor: TEdit;
    Label1: TLabel;
    edtItemNumero: TEdit;
    procedure btnExecutarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCupomFiscalDescAcresAnterior: TfrmCupomFiscalDescAcresAnterior;

implementation

uses
  uPrincipal;

{$R *.dfm}

procedure TfrmCupomFiscalDescAcresAnterior.btnExecutarClick(Sender: TObject);
var
  TipoDescAcresc: String;
  ModoDescAcresc: String;
begin
  inherited;

  // modo (desconto ou acréscimo)
  if edtItemDescAcreModo.ItemIndex = 0 then
    ModoDescAcresc := 'D'
  else
    ModoDescAcresc := 'A';

  // Tipo (percentual ou valor)
  if edtItemDescAcresTipo.ItemIndex = 0 then
    TipoDescAcresc := '%'
  else
    TipoDescAcresc := '$';

  frmPrincipal.ACBrECF1.DescontoAcrescimoItemAnterior(
    StrToFloat(edtItemDescAcreValor.Text),
    ModoDescAcresc,
    TipoDescAcresc,
    StrToInt(edtItemNumero.Text)
  );

  Close;
end;

end.
