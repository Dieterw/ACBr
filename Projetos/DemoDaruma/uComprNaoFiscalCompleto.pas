unit uComprNaoFiscalCompleto;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uBasicoModal, StdCtrls, ExtCtrls;

type
  TfrmComprNaoFiscalCompleto = class(TfrmBasicoModal)
    cbxTotalizador: TComboBox;
    cbxMeioPagto: TComboBox;
    Label1: TLabel;
    Label2: TLabel;
    edtValor: TEdit;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    cbxIndiceBMP: TComboBox;
    Label6: TLabel;
    edtFechamentoObs3: TEdit;
    edtFechamentoObs2: TEdit;
    edtFechamentoObs1: TEdit;
    ckbImprimirExemploCCD: TCheckBox;
    ckbImprimirSegViaCCD: TCheckBox;
    ckbReimprimirCCD: TCheckBox;
    procedure btnExecutarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ckbImprimirExemploCCDClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmComprNaoFiscalCompleto: TfrmComprNaoFiscalCompleto;

implementation

uses
  uPrincipal;

{$R *.dfm}

procedure TfrmComprNaoFiscalCompleto.ckbImprimirExemploCCDClick(
  Sender: TObject);
var
  Liberado: Boolean;

begin
  Liberado := ckbImprimirExemploCCD.Checked;

  ckbImprimirSegViaCCD.Enabled := Liberado;
  ckbReimprimirCCD.Enabled     := Liberado;

  if not Liberado then
  begin
    ckbImprimirSegViaCCD.Checked := False;
    ckbReimprimirCCD.Checked     := False;
  end;
end;

procedure TfrmComprNaoFiscalCompleto.FormCreate(Sender: TObject);
begin
  inherited;

  PopularTotalizadoresNaoFiscais(cbxTotalizador);
  PopularMeiosPagamento(cbxMeioPagto);
  ckbImprimirExemploCCD.OnClick(ckbImprimirExemploCCD);
end;

procedure TfrmComprNaoFiscalCompleto.btnExecutarClick(Sender: TObject);
var
  Observacao: String;
  CupomCCD: TStringList;
  ValorCupom: Double;
  CodMeioPagto: String;
begin
  Observacao :=
    edtFechamentoObs1.Text + sLineBreak +
    edtFechamentoObs2.Text + sLineBreak +
    edtFechamentoObs3.Text;

  CodMeioPagto := Copy(cbxMeioPagto.Text, 1, 2);
  ValorCupom   := StrToFloat(edtValor.Text);

  frmPrincipal.ACBrECF1.IdentificaOperador(NOME_OPERADOR);
  frmPrincipal.ACBrECF1.NaoFiscalCompleto(
    Copy(cbxTotalizador.Text, 1, 2),
    ValorCupom,
    CodMeioPagto,
    Observacao,
    cbxIndiceBMP.ItemIndex
  );

  if ckbImprimirExemploCCD.Checked then
  begin
    CupomCCD := TStringList.Create;
    try
      CupomCCD.Add('Exemplo CCD');
      CupomCCD.Add('');
      CupomCCD.Add('Texto');
      CupomCCD.Add('Texto');
      CupomCCD.Add('Texto');
      CupomCCD.Add('Texto');
      CupomCCD.Add('Texto');
      CupomCCD.Add('Texto');
      CupomCCD.Add('');

      frmPrincipal.ACBrECF1.CupomVinculado(
        frmPrincipal.ACBrECF1.NumCOO,
        CodMeioPagto,
        '',
        ValorCupom,
        CupomCCD
      );

      if ckbImprimirSegViaCCD.Checked then
        frmPrincipal.ACBrECF1.SegundaViaVinculado;

      if ckbReimprimirCCD.Checked then
        frmPrincipal.ACBrECF1.ReimpressaoVinculado;
    finally
      CupomCCD.Free;
    end;
  end;

end;

end.



