unit QRelatorio;

interface

uses
  SysUtils, QTypes, QGraphics, QControls, QForms, 
  QDialogs, QStdCtrls, QButtons, Classes, QComCtrls;

type
  TfrRelatorio = class(TForm)
    mRelat: TMemo;
    Button1: TButton;
    Button2: TButton;
    Label1: TLabel;
    edVias: TEdit;
    OpenDialog1: TOpenDialog;
    lCodFPG: TLabel;
    edFPG: TEdit;
    sbFPG: TSpeedButton;
    lValor: TLabel;
    edValor: TEdit;
    lCupom: TLabel;
    edCupom: TEdit;
    lCodCNF: TLabel;
    edCNF: TEdit;
    sbCNF: TSpeedButton;
    Button3: TButton;
    Label5: TLabel;
    seMaxLinhasBuffer: TSpinEdit;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure sbFPGClick(Sender: TObject);
    procedure edValorKeyPress(Sender: TObject; var Key: Char);
    procedure sbCNFClick(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private
    { Private declarations }
  public
    TipoRelatorio : Char ;
    { Public declarations }
  end;

var
  frRelatorio: TfrRelatorio;

implementation

uses QECFTeste1, ACBrECF;

{$R *.xfm}

procedure TfrRelatorio.FormCreate(Sender: TObject);
begin
  TipoRelatorio := 'G' ;
end;

procedure TfrRelatorio.Button1Click(Sender: TObject);
begin
if OpenDialog1.Execute then
   mRelat.Lines.LoadFromFile(OpenDialog1.FileName);
end;

procedure TfrRelatorio.Button2Click(Sender: TObject);
begin
  Form1.ACBrECF1.MaxLinhasBuffer := seMaxLinhasBuffer.Value ;
  try
     if TipoRelatorio = 'V' then
        Form1.ACBrECF1.CupomVinculado( edCupom.Text, edFPG.Text, edCNF.Text,
           StrToFloatDef( edValor.Text,0 ), mRelat.Lines,
           StrToIntDef(edVias.Text,1) )
     else
        Form1.ACBrECF1.RelatorioGerencial(mRelat.Lines,StrToIntDef(edVias.Text,1));
  except
     MessageDlg('Falha ao Imprimir o Relatorio',mtError,[mbOk],0) ;
     
     raise ;
  end ;
end;

procedure TfrRelatorio.FormShow(Sender: TObject);
begin
//  mRelat.WrapAtValue := Form1.ACBrECF1.Colunas ;
  edFPG.Visible   := (TipoRelatorio = 'V') ;
  lCupom.Visible  := edFPG.Visible ;
  edCupom.Visible := edFPG.Visible ;
  lCodFPG.Visible := edFPG.Visible ;
  sbFPG.Visible   := edFPG.Visible ;
  lValor.Visible  := edFPG.Visible ;
  edValor.Visible := edFPG.Visible ;

  if edCupom.Visible then
     edCupom.Text := Form1.ACBrECF1.NumCupom ;

  edCNF.Text      := '' ;
  edCNF.Visible   := edFPG.Visible and
                    (Form1.ACBrECF1.Modelo in [ecfDaruma, ecfSchalter]) ;
  sbCNF.Visible   := edCNF.Visible ;
  lCodCNF.Visible := edCNF.Visible ;
  if TipoRelatorio = 'V' then
     Caption := 'Cupom NAO Fiscal Vinculado'
  else
     Caption := 'Relatório Gerêncial' ;
end;

procedure TfrRelatorio.sbFPGClick(Sender: TObject);
begin
  Form1.FormasdePagamento1Click( Sender );
end;

procedure TfrRelatorio.edValorKeyPress(Sender: TObject; var Key: Char);
begin
  if Key in [',','.'] then
     Key := DecimalSeparator ;
end;

procedure TfrRelatorio.sbCNFClick(Sender: TObject);
begin
  Form1.CarregaComprovantesNAOFiscais1Click( Sender );
end;

procedure TfrRelatorio.Button3Click(Sender: TObject);
Var I : Integer ;
begin
  mRelat.Lines.Clear ;
  For I := 0 to 14 do
     mRelat.Lines.Add( StringOfChar(chr(I+65), Form1.ACBrECF1.Colunas) ) ;
end;

end.
