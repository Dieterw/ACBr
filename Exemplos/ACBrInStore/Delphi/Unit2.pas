unit Unit2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ACBrBase, ACBrInStore;

type
  TForm2 = class(TForm)
    edtCodigoEtiqueta: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Button1: TButton;
    edtPrefixo: TEdit;
    edtCodigo: TEdit;
    edtPeso: TEdit;
    edtTotal: TEdit;
    edtCodificacao: TEdit;
    Label6: TLabel;
    Label7: TLabel;
    edtDV: TEdit;
    ACBrInStore1: TACBrInStore;
    procedure Button1Click(Sender: TObject);
    procedure ACBrInStore1GetPrecoUnitario(const Codigo: string;
      var PrecoUnitario: Double);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

{$R *.dfm}

procedure TForm2.ACBrInStore1GetPrecoUnitario(const Codigo: string;
  var PrecoUnitario: Double);
begin
  // Faça a pesquisa do código no seu DB, e pegue o preço unitário.
  PrecoUnitario := 10.00;
end;

procedure TForm2.Button1Click(Sender: TObject);
begin
  ACBrInStore1.Codificacao := edtCodificacao.Text;
  
  ACBrInStore1.Desmembrar(edtCodigoEtiqueta.Text);

  edtPrefixo.Text := ACBrInStore1.Prefixo;
  edtCodigo.Text  := ACBrInStore1.Codigo;
  edtPeso.Text    := FloatToStr( ACBrInStore1.Peso );
  edtTotal.Text   := FloatToStr( ACBrInStore1.Total );
  edtDV.Text      := ACBrInStore1.DV;
end;

end.
