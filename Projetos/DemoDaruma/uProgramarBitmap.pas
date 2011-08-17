unit uProgramarBitmap;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uBasicoModal, StdCtrls, ExtCtrls;

type
  TfrmProgramarBitmap = class(TfrmBasicoModal)
    Label1: TLabel;
    Label2: TLabel;
    edtPathArquivo: TEdit;
    btnProcurarArquivo: TButton;
    cbxIndice: TComboBox;
    OpenDialog1: TOpenDialog;
    Label3: TLabel;
    cbxPosicao: TComboBox;
    procedure btnProcurarArquivoClick(Sender: TObject);
    procedure btnExecutarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmProgramarBitmap: TfrmProgramarBitmap;

implementation

uses
  uPrincipal, ACBrDevice;

{$R *.dfm}

procedure TfrmProgramarBitmap.FormCreate(Sender: TObject);
begin
  inherited;

  cbxIndice.ItemIndex  := 0;
  cbxPosicao.ItemIndex := 0;
  edtPathArquivo.Clear;
end;

procedure TfrmProgramarBitmap.btnProcurarArquivoClick(Sender: TObject);
begin
  if OpenDialog1.Execute then
    edtPathArquivo.Text := OpenDialog1.FileName;
end;

procedure TfrmProgramarBitmap.btnExecutarClick(Sender: TObject);
var
  Alinhamento: TACBrAlinhamento;
begin
  if Trim(edtPathArquivo.Text) = EmptyStr then
    raise Exception.Create('Informe o caminho do arquivo Bitmap');

  if cbxPosicao.ItemIndex = 0 then
    Alinhamento := alEsquerda
  else
    Alinhamento := alCentro;

  frmPrincipal.ACBrECF1.ProgramarBitmapPromocional(
    StrToInt(cbxIndice.Text), AnsiString(edtPathArquivo.Text), Alinhamento
  );

  ShowMessage('Bitmap programado com sucesso!')
end;

end.

