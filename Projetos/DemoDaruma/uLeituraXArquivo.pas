unit uLeituraXArquivo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uBasicoModal, StdCtrls, ExtCtrls;

type
  TfrmLeituraXArquivo = class(TfrmBasicoModal)
    edtPathArquivo: TEdit;
    Button1: TButton;
    Label1: TLabel;
    SaveDialog1: TSaveDialog;
    procedure btnExecutarClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmLeituraXArquivo: TfrmLeituraXArquivo;

implementation

uses
  uPrincipal;

{$R *.dfm}

procedure TfrmLeituraXArquivo.Button1Click(Sender: TObject);
begin
  if SaveDialog1.Execute then
    edtPathArquivo.Text := SaveDialog1.FileName;
end;

procedure TfrmLeituraXArquivo.btnExecutarClick(Sender: TObject);
var
  F: TStringList;
begin
  if edtPathArquivo.Text = EmptyStr then
    raise EFilerError.Create('Nome do arquivo não informado.');

  F := TStringList.Create;
  try
    frmPrincipal.ACBrECF1.LeituraXSerial(F);
    F.SaveToFile(edtPathArquivo.Text);

    ShowMessage('arquivo gravado com sucesso.');
  finally
    F.Free
  end;

  inherited;
end;

end.
