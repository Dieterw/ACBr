unit uEnviarMensagem;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls;

type
  TfrmEnviarMensagem = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    lblContador: TLabel;
    edtTelefone: TEdit;
    btnEnviar: TButton;
    memMensagem: TMemo;
    btnCancelar: TButton;
    rdgBandeja: TRadioGroup;
    ckbQuebrarMensagem: TCheckBox;
    procedure btnCancelarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnEnviarClick(Sender: TObject);
    procedure memMensagemChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmEnviarMensagem: TfrmEnviarMensagem;

implementation

uses
  uPrincipal, ACBrSMSClass;

{$R *.dfm}

procedure TfrmEnviarMensagem.FormCreate(Sender: TObject);
begin
  edtTelefone.Clear;
  memMensagem.Clear;
  rdgBandeja.ItemIndex := Integer(frmPrincipal.ACBrSMS1.SinCard);
end;

procedure TfrmEnviarMensagem.memMensagemChange(Sender: TObject);
begin
  lblContador.Caption := Format('%d caracter(es)', [Length(memMensagem.Text)]);
end;

procedure TfrmEnviarMensagem.btnCancelarClick(Sender: TObject);
begin
  Self.Close;
end;

procedure TfrmEnviarMensagem.btnEnviarClick(Sender: TObject);
var
  IndiceMsgEnviada: String;
begin
  if Trim(edtTelefone.Text) = EmptyStr then
    raise Exception.Create('Informe o número do telefone.');

  if Trim(memMensagem.Text) = EmptyStr then
    raise Exception.Create('Informe a mensagem a ser enviada.');

  if rdgBandeja.ItemIndex = 0 then
    frmPrincipal.ACBrSMS1.TrocarBandeja(sin1)
  else
    frmPrincipal.ACBrSMS1.TrocarBandeja(sin2);

  frmPrincipal.ACBrSMS1.QuebraMensagens := ckbQuebrarMensagem.Checked;

  frmPrincipal.ACBrSMS1.EnviarSMS(
    AnsiString(edtTelefone.Text),
    AnsiString(memMensagem.Text),
    IndiceMsgEnviada
  );

  ShowMessage(
    'Mensagem envida com sucesso. Indice: ' + IndiceMsgEnviada +
    sLineBreak +
    sLineBreak +
    'Ultima resposta: ' +
    sLineBreak +
    String(frmPrincipal.ACBrSMS1.UltimaResposta)
  );
end;

end.
