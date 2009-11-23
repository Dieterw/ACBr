unit UPrincipal;

interface

uses QForms, SysUtils, ACBrDevice, ACBrETQ, QStdCtrls, Classes, QControls,
  ACBrBase, QGraphics, QExtCtrls, QDialogs ;


type
  TFPrincipal = class(TForm)
    ACBrETQ: TACBrETQ;
    cbModelo: TComboBox;
    Label1: TLabel;
    Label2: TLabel;
    cbPorta: TComboBox;
    eCopias: TEdit;
    Label3: TLabel;
    eAvanco: TEdit;
    Label4: TLabel;
    bEtqSimples: TButton;
    bEtqCarreiras: TButton;
    Image1: TImage;
    Button1: TButton;
    Edit1: TEdit;
    Label5: TLabel;
    Button2: TButton;
    OpenDialog1: TOpenDialog;
    ckMemoria: TCheckBox;
    procedure bEtqSimplesClick(Sender: TObject);
    procedure bEtqCarreirasClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FPrincipal: TFPrincipal;

implementation

{$R *.xfm}

procedure TFPrincipal.bEtqSimplesClick(Sender: TObject);
begin
  with ACBrETQ do
  begin
     Modelo := TACBrETQModelo(cbModelo.ItemIndex);
     Porta := cbPorta.Text;
     LimparMemoria := ckMemoria.Checked ;
     Ativar;

     ImprimirTexto(orNormal, 2, '2', '2', 190, 5, 'BISCOITO MARILAN RECH 335G');
     ImprimirTexto(orNormal, 2, '2', '1', 158, 5, 'CHOC BRANCO');
     ImprimirBarras(orNormal, 'F', '2', '2', 32, 0, '7896003701685', 90);
     ImprimirTexto(orNormal, 3, '3', '2', 15, 300, 'R$');
     ImprimirTexto(orNormal, 3, '4', '4', 15, 450, '20.59');

     Imprimir(StrToInt(eCopias.Text), StrToInt(eAvanco.Text));
     Desativar;
  end;
end;

procedure TFPrincipal.bEtqCarreirasClick(Sender: TObject);
begin
  with ACBrETQ do
  begin
     Modelo := TACBrETQModelo(cbModelo.ItemIndex);
     Porta := cbPorta.Text;
     Avanco := StrToInt(eAvanco.Text);
     LimparMemoria := ckMemoria.Checked ;
     Ativar;

     ImprimirTexto(orNormal, 2, '1', '2', 0180, 0015, 'BISCOITO REC 335G');
     ImprimirTexto(orNormal, 2, '1', '1', 0140, 0015, 'CHOC BRANCO');
     ImprimirBarras(orNormal, 'F', '2', '2', 0020, 0010, '7896003701685', 070);

     ImprimirTexto(orNormal, 2, '1', '2', 0180, 0315, 'BISCOITO RECH 335G');
     ImprimirTexto(orNormal, 2, '1', '1', 0140, 0315, 'CHOC BRANCO');
     ImprimirBarras(orNormal, 'F', '2', '2', 0020, 0315, '7896003701685', 070);

     ImprimirTexto(orNormal, 2, '1', '2', 0180, 0620, 'BISCOITO RECH 335G');
     ImprimirTexto(orNormal, 2, '1', '1', 0140, 0620, 'CHOC BRANCO');
     ImprimirBarras(orNormal, 'F', '2', '2', 0020, 0620, '7896003701685', 070);

     Imprimir(StrToInt(eCopias.Text), StrToInt(eAvanco.Text));
     Desativar;
  end;
end;

procedure TFPrincipal.Button1Click(Sender: TObject);
begin
  with ACBrETQ do
  begin
     Modelo := TACBrETQModelo(cbModelo.ItemIndex);
     Porta := cbPorta.Text;
     Avanco := StrToInt(eAvanco.Text);
     LimparMemoria := ckMemoria.Checked ;
     Ativar;

     ImprimirImagem(1,10,10,Edit1.Text);

     Imprimir(StrToInt(eCopias.Text), StrToInt(eAvanco.Text));
     Desativar;
  end ;
end;

procedure TFPrincipal.Button2Click(Sender: TObject);
begin
  if OpenDialog1.Execute then
  begin
     Image1.Picture.LoadFromFile(OpenDialog1.FileName);
  end ;

  with ACBrETQ do
  begin
     Modelo := TACBrETQModelo(cbModelo.ItemIndex);
     Porta := cbPorta.Text;
     Ativar;

     CarregarImagem(Image1.Picture.Bitmap, Edit1.Text, True);

     Desativar;
  end ;
end;

end.
