unit uPrincipal;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ACBrBase, ACBrSocket, ACBrSuframa;

type
  TfrmPrincipal = class(TForm)
    ACBrSuframa1: TACBrSuframa;
    edtSuframa: TEdit;
    btnConsultar: TButton;
    Label1: TLabel;
    memResposta: TMemo;
    edtCnpj: TEdit;
    Label2: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure btnConsultarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

{$R *.dfm}

procedure TfrmPrincipal.FormCreate(Sender: TObject);
begin
  edtSuframa.Clear;
  edtCnpj.Clear;
  memResposta.Clear;
end;

procedure TfrmPrincipal.btnConsultarClick(Sender: TObject);
begin
  ACBrSuframa1.Suframa := edtSuframa.Text;
  ACBrSuframa1.CNPJ    := edtCnpj.Text;

  try
    ACBrSuframa1.Validar;
    memResposta.Clear;
    memResposta.Lines.Add('Situação:');
    memResposta.Lines.Add(StringOfChar('-', 30));
    memResposta.Lines.Add(Format('%d - %s', [ACBrSuframa1.Situacao, ACBrSuframa1.SituacaoDescr]));
    memResposta.Lines.Add('');
    memResposta.Lines.Add('XML Resposta:');
    memResposta.Lines.Add(StringOfChar('-', 30));
    memResposta.Lines.Add(StringReplace(String(ACBrSuframa1.RespostaWS), #10, sLineBreak, [rfReplaceAll]));
  except
    on E: Exception do
    begin
      memResposta.Lines.Add('ERRO:');
      memResposta.Lines.Add(E.Message);
    end;
  end;
end;

end.
