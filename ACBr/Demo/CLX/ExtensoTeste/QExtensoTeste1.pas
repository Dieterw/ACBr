unit QExtensoTeste1;

interface

uses
  SysUtils, Types, Classes, Variants, QTypes, QGraphics, QControls, QForms, 
  QDialogs, QStdCtrls, ACBrBase, ACBrExtenso;

type
  TfrExtenso = class(TForm)
    edValor: TEdit;
    Label1: TLabel;
    bExtenso: TButton;
    mExtenso: TMemo;
    ACBrExtenso1: TACBrExtenso;
    cbZeroAEsquerda: TCheckBox;
    Label2: TLabel;
    ComboBox1: TComboBox;
    procedure bExtensoClick(Sender: TObject);
    procedure edValorKeyPress(Sender: TObject; var Key: Char);
    procedure cbZeroAEsquerdaClick(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frExtenso: TfrExtenso;

implementation

{$R *.xfm}

procedure TfrExtenso.bExtensoClick(Sender: TObject);
begin
  ACBrExtenso1.Valor := StrToFloat( edValor.Text ) ;
  mExtenso.Text := ACBrExtenso1.Texto ; 
end;

procedure TfrExtenso.edValorKeyPress(Sender: TObject; var Key: Char);
begin
  if Key in [',','.'] then
     Key := DecimalSeparator ;
end;

procedure TfrExtenso.cbZeroAEsquerdaClick(Sender: TObject);
begin
  ACBrExtenso1.ZeroAEsquerda := cbZeroAEsquerda.Checked ;
end;

procedure TfrExtenso.ComboBox1Change(Sender: TObject);
begin
  ACBrExtenso1.Formato := TACBrExtensoFormato( ComboBox1.ItemIndex ) ;

  if ACBrExtenso1.Formato = extDolar then
   begin
     ACBrExtenso1.StrMoeda  := 'Dolar Americano' ;
     ACBrExtenso1.StrMoedas := 'Dolares Americanos' ;
   end
  else
   begin
     ACBrExtenso1.StrMoeda  := 'Real' ;
     ACBrExtenso1.StrMoedas := 'Reais' ;
   end ;
end;

end.
