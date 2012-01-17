unit uBasicoModal;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, OleCtrls, SHDocVw;

type
  TfrmBasicoModal = class(TForm)
    pnlCliente: TPanel;
    pnlRodape: TPanel;
    btnExecutar: TButton;
    btnCancelar: TButton;
    procedure btnCancelarClick(Sender: TObject);
    procedure btnExecutarClick(Sender: TObject);
  private

  public
    procedure ClearFields;

    procedure WB_LoadHTML(WebBrowser: TWebBrowser; HTMLCode: string);
    procedure WB_ScrollToTop(WebBrowser1: TWebBrowser);
    procedure WB_ScrollToBottom(WebBrowser1: TWebBrowser);

    procedure PopularTotalizadoresNaoFiscais(const ACombo: TComboBox);
    procedure PopularMeiosPagamento(const ACombo: TComboBox);
    procedure PopularRelGerencial(const ACombo: TComboBox);
  end;

var
  frmBasicoModal: TfrmBasicoModal;

const
  NOME_OPERADOR = 'DemoACBrDaruma';

implementation

uses
  uPrincipal, ActiveX, MSHTML;

{$R *.dfm}

procedure TfrmBasicoModal.WB_LoadHTML(WebBrowser: TWebBrowser; HTMLCode: string);
var
  sl: TStringList;
  ms: TMemoryStream;
begin
  WebBrowser.Navigate('about:blank');
  while WebBrowser.ReadyState < READYSTATE_INTERACTIVE do
    Application.ProcessMessages;

  if Assigned(WebBrowser.Document) then
  begin
    sl := TStringList.Create;
    try
      ms := TMemoryStream.Create;
      try
        sl.Text := HTMLCode;
        sl.SaveToStream(ms);
        ms.Seek(0, 0);
        (WebBrowser.Document as IPersistStreamInit).Load(TStreamAdapter.Create(ms));
      finally
        ms.Free;
      end;
    finally
      sl.Free;
    end;
  end;
end;

procedure TfrmBasicoModal.WB_ScrollToTop(WebBrowser1: TWebBrowser);
var
  scrollpos: Integer;
  pw : IHTMLWindow2;
  Doc: IHTMLDocument2;
begin
  Doc := WebBrowser1.Document as IHTMLDocument2;
  pw  := IHTMLWindow2(Doc.parentWindow);

  LockWindowUpdate(WebBrowser1.Handle);
  try
    scrollPos := pw.screen.height;
    pw.scrollBy(0, -scrollpos);
  finally
    LockWindowUpdate(0);
  end;
end;

procedure TfrmBasicoModal.WB_ScrollToBottom(WebBrowser1: TWebBrowser);
var
  scrollpos: Integer;
  pw : IHTMLWindow2;
  Doc: IHTMLDocument2;
begin
  Doc := WebBrowser1.Document as IHTMLDocument2;
  pw  := IHTMLWindow2(Doc.parentWindow);

  LockWindowUpdate(WebBrowser1.Handle);
  try
    scrollPos := pw.screen.height;
    pw.scrollBy(0, scrollpos);
  finally
    LockWindowUpdate(0);
  end;
end;

procedure TfrmBasicoModal.ClearFields;
var
  I: Integer;
  Comp: TComponent;
begin
  for I := 0 to Self.ComponentCount - 1 do
  begin
    Comp := Self.Components[I];

    if (Comp is TEdit) then
      TEdit(Comp).Clear;

    if (Comp is TListBox) then
      TListBox(Comp).Clear;
  end;
end;

procedure TfrmBasicoModal.btnExecutarClick(Sender: TObject);
begin
  // Implementar nos filhos
end;

procedure TfrmBasicoModal.PopularMeiosPagamento(const ACombo: TComboBox);
var
  I: Integer;
begin
  with frmPrincipal.ACBrECF1 do
  begin
    ACombo.Clear;
    ACombo.Items.BeginUpdate;
    try
      for I := 0 to FormasPagamento.Count - 1 do
        ACombo.Items.Add(Format('%s - %s', [FormasPagamento[I].Indice, FormasPagamento[I].Descricao]))
    finally
      ACombo.ItemIndex := 0;
      ACombo.Items.EndUpdate;
    end;
  end;
end;

procedure TfrmBasicoModal.PopularRelGerencial(const ACombo: TComboBox);
var
  I: Integer;
begin
  with frmPrincipal.ACBrECF1 do
  begin
    ACombo.Items.BeginUpdate;
    try
      ACombo.Items.Clear;
      for I := 0 to RelatoriosGerenciais.Count - 1 do
        ACombo.Items.Add(Format('%s - %s', [RelatoriosGerenciais[I].Indice, RelatoriosGerenciais[I].Descricao]));
    finally
      ACombo.ItemIndex := 0;
      ACombo.Items.EndUpdate;
    end;
  end;
end;

procedure TfrmBasicoModal.PopularTotalizadoresNaoFiscais(
  const ACombo: TComboBox);
var
  I: Integer;
  Indice: Integer;
  Descricao: String;
begin
  with frmPrincipal.ACBrECF1 do
  begin
    ACombo.Clear;
    ACombo.Items.BeginUpdate;
    try
      for I := 0 to ComprovantesNaoFiscais.Count - 1 do
      begin
        Indice    := StrToInt(ComprovantesNaoFiscais[I].Indice);
        Descricao := UpperCase(ComprovantesNaoFiscais[I].Descricao);

        if Indice >= 3 then // tirar fora suprimento e sangria
          ACombo.Items.Add(Format('%2.2d - %s', [Indice, Descricao]))
      end;
    finally
      ACombo.ItemIndex := 0;
      ACombo.Items.EndUpdate;
    end;
  end;
end;

procedure TfrmBasicoModal.btnCancelarClick(Sender: TObject);
begin
  Close;
end;

end.
