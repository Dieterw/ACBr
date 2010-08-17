unit principal;

interface

uses UrlMon, JvGIF, MSHtml, ACBrUtil, pcnAuxiliar,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, OleCtrls, SHDocVw, ExtCtrls, ComCtrls;

type
  TfrmPrincipal = class(TForm)
    WebBrowser1: TWebBrowser;
    btnPegarHTML: TButton;
    edtCaptcha: TEdit;
    Image1: TImage;
    edtChaveNFe: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    ProgressBar1: TProgressBar;
    Memo2: TMemo;
    btnNovaConsulta: TButton;
    lblStatus: TLabel;
    btnGerarXML: TButton;
    Panel1: TPanel;
    WBXML: TWebBrowser;
    procedure btnPegarHTMLClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure WebBrowser1DocumentComplete(Sender: TObject;
      const pDisp: IDispatch; var URL: OleVariant);
    procedure WebBrowser1ProgressChange(Sender: TObject; Progress,
      ProgressMax: Integer);
    procedure btnNovaConsultaClick(Sender: TObject);
    procedure btnGerarXMLClick(Sender: TObject);
  private
    { Private declarations }
    function DownloadFile(SourceFile, DestFile: string): Boolean;
    function StripHTML(S: string): string;
  public
    { Public declarations }
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

uses ACBrNFeUtil, ACBrHTMLtoXML;

{$R *.dfm}
function TfrmPrincipal.DownloadFile(SourceFile, DestFile: string): Boolean;
begin
  try
    Result := UrlDownloadToFile(nil, PChar(SourceFile), PChar(DestFile), 0,
      nil) = 0;
  except
    Result := False;
  end;
end;

function TfrmPrincipal.StripHTML(S: string): string;
var
  TagBegin, TagEnd, TagLength: integer;
begin
  TagBegin := Pos( '<', S);      // search position of first <

  while (TagBegin > 0) do begin  // while there is a < in S
    TagEnd := Pos('>', S);              // find the matching >
    TagLength := TagEnd - TagBegin + 1;
    Delete(S, TagBegin, TagLength);     // delete the tag
    TagBegin:= Pos( '<', S);            // search for next <
  end;

  Result := S;                   // give the result
end;

procedure TfrmPrincipal.btnPegarHTMLClick(Sender: TObject);
begin
  edtChaveNFe.Text := OnlyNumber(edtChaveNFe.Text);

  if not ValidarChave('NFe'+edtChaveNFe.Text) then
   begin
     MessageDlg('Chave Inválida.',mtError,[mbok],0);
     edtChaveNFe.SetFocus;
     exit;
   end;

  if trim(edtCaptcha.Text) = '' then
   begin
     MessageDlg('Digite o valor da imagem.',mtError,[mbok],0);
     edtCaptcha.SetFocus;
     exit;
   end;

  Memo2.Lines.Clear;

  btnPegarHTML.Enabled    := False;
  btnNovaConsulta.Enabled := False;
  btnGerarXML.Enabled     := False;
  try
     WebBrowser1.OleObject.Document.all.Item('ctl00$ContentPlaceHolder3$chaveAcesso', 0).value := edtChaveNFe.Text;
     WebBrowser1.OleObject.Document.all.Item('ctl00$ContentPlaceHolder3$intercepta', 0).value := edtCaptcha.Text;
     WebBrowser1.OleObject.Document.all.Item('ctl00$ContentPlaceHolder3$btcontinuar', 0).click;
  except
     btnNovaConsulta.Enabled := True;
     raise;
  end;
end;

procedure TfrmPrincipal.FormCreate(Sender: TObject);
begin
  WebBrowser1.Navigate('https://www.nfe.fazenda.gov.br/portal/FormularioDePesquisa.aspx?tipoconsulta=completa');
end;

procedure TfrmPrincipal.WebBrowser1DocumentComplete(Sender: TObject;
  const pDisp: IDispatch; var URL: OleVariant);
var
  k, i: Integer;
  Source, dest: string;
  textoNFe : IHTMLDocument2;
begin
  Application.ProcessMessages;
  if WebBrowser1.LocationURL = 'https://www.nfe.fazenda.gov.br/portal/FormularioDePesquisa.aspx?tipoconsulta=completa' then
   begin
     for k := 0 to WebBrowser1.OleObject.Document.Images.Length - 1 do
      begin
        Source := WebBrowser1.OleObject.Document.Images.Item(k).Src;
        if (Source = 'https://www.nfe.fazenda.gov.br/scripts/srf/intercepta/captcha.aspx?opt=image') then
         begin
           dest := ExtractFilePath(ParamStr(0)) + 'captcha.gif';
           DownloadFile(Source, dest);
         end;
      end;
     Image1.Picture.LoadFromFile(dest);
     btnPegarHTML.Enabled := True;
   end
  else if WebBrowser1.LocationURL = 'https://www.nfe.fazenda.gov.br/portal/visualizacaoNFe/completa/Default.aspx' then
   begin
      WebBrowser1.Navigate('https://www.nfe.fazenda.gov.br/PORTAL/visualizacaoNFe/completa/impressao.aspx');
   end
  else if WebBrowser1.LocationURL = 'https://www.nfe.fazenda.gov.br/PORTAL/visualizacaoNFe/completa/impressao.aspx' then
   begin
      textoNFe := WebBrowser1.Document as IHTMLDocument2;
      repeat
         Application.ProcessMessages;
      until Assigned(textoNFe.body);
      Memo2.Lines.Text := StripHTML(textoNFe.body.innerHTML);
      Memo2.Lines.Text := StringReplace(Memo2.Lines.Text,'&nbsp;','',[rfReplaceAll, rfIgnoreCase]);

      i:= 0;
      while i < memo2.Lines.Count-1 do
       begin
         if trim(Memo2.Lines[i]) = '' then
          begin
            Memo2.Lines.Delete(i);
            i := i - 1;
          end;
         i := i + 1;
       end;
     Image1.Picture := nil;
     btnGerarXML.Enabled := True;
     btnNovaConsulta.Enabled := True;
   end
  else if WebBrowser1.LocationURL = 'https://www.nfe.fazenda.gov.br/portal/inexistente_completa.aspx' then
   begin
     MessageDlg('NF-e INEXISTENTE na base nacional, favor consultar esta NF-e no site da SEFAZ de origem.',mtError,[mbok],0);
     Image1.Picture := nil;
     btnGerarXML.Enabled := True;
     btnNovaConsulta.Enabled := True;
   end
  else
   begin
   begin
     MessageDlg('Erro carregando URL: '+WebBrowser1.LocationURL,mtError,[mbok],0);
     Image1.Picture := nil;
     btnGerarXML.Enabled := True;
     btnNovaConsulta.Enabled := True;
   end
   end;
end;

procedure TfrmPrincipal.WebBrowser1ProgressChange(Sender: TObject; Progress,
  ProgressMax: Integer);
begin
 if ProgressMax = 0 then
  begin
    ProgressBar1.Visible := False;
    lblStatus.Visible := False;
    exit;
  end
 else
  begin
    ProgressBar1.Visible := True;
    lblStatus.Visible := True;
    try
       ProgressBar1.Max := ProgressMax;
       if (Progress <> -1) and (Progress <= ProgressMax) then
          ProgressBar1.Position := Progress
       else
        begin
          ProgressBar1.Visible := False;
          lblStatus.Visible := False;
        end;
    except
       on EDivByZero do
         exit;
    end;
  end;
end;

procedure TfrmPrincipal.btnNovaConsultaClick(Sender: TObject);
begin
  btnNovaConsulta.Enabled := False;
  btnGerarXML.Enabled := False;
  Memo2.Lines.Clear;

  WebBrowser1.Navigate('https://www.nfe.fazenda.gov.br/portal/FormularioDePesquisa.aspx?tipoconsulta=completa');
end;

procedure TfrmPrincipal.btnGerarXMLClick(Sender: TObject);
begin
  WBXML.Navigate(GerarXML(Memo2.Lines.Text));
end;

end.


