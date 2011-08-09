unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ACBrAAC, ACBrBase, ACBrECF, StdCtrls, ExtCtrls, jpeg, Buttons,ACBrPAFClass;

type
  TForm1 = class(TForm)
    botao_pesquisa: TSpeedButton;
    Image1: TImage;
    Edit1: TEdit;
    Panel3: TPanel;
    Label9: TLabel;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    SpeedButton4: TSpeedButton;
    SpeedButton5: TSpeedButton;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label15: TLabel;
    edRazaoSocial: TEdit;
    edCNPJ: TEdit;
    edInscEstadual: TEdit;
    edInscMunicipal: TEdit;
    GroupBox2: TGroupBox;
    Label14: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label5: TLabel;
    edNomePAF: TEdit;
    edVersaoPAF: TEdit;
    edMD5Paf: TEdit;
    edExecutavel: TEdit;
    GroupBox3: TGroupBox;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    edNumeroSerieECF: TEdit;
    edGTECF: TEdit;
    edCROECF: TEdit;
    GroupBox4: TGroupBox;
    SpeedButton1: TSpeedButton;
    cbPorta: TComboBox;
    GroupBox5: TGroupBox;
    Label2: TLabel;
    Label10: TLabel;
    Label13: TLabel;
    memoNumeroSerie: TMemo;
    memoGT: TMemo;
    memoCRO: TMemo;
    ECF: TACBrECF;
    ACBrAAC1: TACBrAAC;
    cbxModelo: TComboBox;



    procedure FormActivate(Sender: TObject);
    procedure buscaInformacoesArquivoAuxiliar();
    procedure recriarArquivoAuxiliar();
    function  removePonto(Text : string) : string;

    procedure ACBrAAC1GetChave(var Chave: String);
    procedure SpeedButton4Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton5Click(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    Function  getPastaSistemaWindows : String;
    procedure cbxModeloChange(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  caminhoArquivoAuxiliarPAF : string;
  ecfAux : TACBrAACECF;

implementation

{$R *.dfm}

procedure Tform1.FormActivate(Sender: TObject);
begin
  inherited;
  caminhoArquivoAuxiliarPAF := getPastaSistemaWindows+'\AX.txt'; // Altera para o local do seu arquivo

  if (FileExists(caminhoArquivoAuxiliarPAF) = false ) then
    begin
      MessageDlg('O Sistema não encontrou o arquivo auxiliar de configuração do PAF-ECF neste computador. O arquivo será recriado', mtWarning, [mbOK], 0);
      recriarArquivoAuxiliar;
    end
  else
    begin
     buscaInformacoesArquivoAuxiliar();
    end;
end;

procedure Tform1.recriarArquivoAuxiliar();
var
 F : TextFile;
 ct : integer;
begin
     if (FileExists(caminhoArquivoAuxiliarPAF) = false ) then
      begin
        DeleteFile(caminhoArquivoAuxiliarPAF);
      end;

      try
       AssignFile(F,caminhoArquivoAuxiliarPAF);
      except
        begin
          ShowMessage('Erro ao tentar gravar no arquivo texto!');
          exit;
        end;
      end;

      Rewrite(f);
      closefile(F);
      ACBrAAC1.NomeArquivoAux := caminhoArquivoAuxiliarPAF;
      ACBrAAC1.AbrirArquivo;
      ACBrAAC1.IdentPAF.Empresa.RazaoSocial   :=     edRazaoSocial.Text;
      ACBrAAC1.IdentPAF.Empresa.CNPJ          :=     edCNPJ.Text;
      ACBrAAC1.IdentPAF.Empresa.IE            :=     edInscEstadual.Text;
      ACBrAAC1.IdentPAF.Empresa.IM            :=     edInscMunicipal.Text;
      ACBrAAC1.IdentPAF.Paf.Nome              :=     edNomePAF.Text;
      ACBrAAC1.IdentPAF.Paf.Versao            :=     edVersaoPAF.Text;
      ACBrAAC1.IdentPAF.Paf.PrincipalExe.Nome :=     edNomePAF.Text;
      ACBrAAC1.IdentPAF.Paf.PrincipalExe.MD5  :=     edExecutavel.Text;


      for ct:=0 to memoNumeroSerie.Lines.Count - 1 do
       begin
        ecfAux := TACBrAACECF.Create;
        ecfAux.NumeroSerie := trim(edNumeroSerieECF.Text);
        ecfAux.CRO         := strToInt(trim(edCROECF.Text));
        ecfAux.ValorGT     := StrToFloat(removePonto(edGTECF.Text));
        ACBrAAC1.IdentPAF.ECFsAutorizados.Add(ecfAux);
       end;
      ACBrAAC1.SalvarArquivo;

      buscaInformacoesArquivoAuxiliar();
      MessageDlg('Arquivo auxiliar salvo com sucesso!', mtWarning, [mbOK], 0);

end;


procedure Tform1.buscaInformacoesArquivoAuxiliar();
var
 ct : integer;
begin
  ACBrAAC1.NomeArquivoAux := caminhoArquivoAuxiliarPAF;
  ACBrAAC1.AbrirArquivo;
  edRazaoSocial.Text   := ACBrAAC1.IdentPAF.Empresa.RazaoSocial   ;
  edCNPJ.Text          :=     ACBrAAC1.IdentPAF.Empresa.CNPJ      ;
  edInscEstadual.Text  :=     ACBrAAC1.IdentPAF.Empresa.IE        ;
  edInscMunicipal.Text :=     ACBrAAC1.IdentPAF.Empresa.IM        ;
  edNomePAF.Text       :=     ACBrAAC1.IdentPAF.Paf.Nome          ;
  edVersaoPAF.Text     :=     ACBrAAC1.IdentPAF.Paf.Versao           ;
  edExecutavel.Text    :=     ACBrAAC1.IdentPAF.Paf.PrincipalExe.Nome;
  edMD5Paf.Text        :=     ACBrAAC1.IdentPAF.Paf.PrincipalExe.MD5 ;

  memoNumeroSerie.Lines.Clear;
  memoGT.Lines.Clear;
  memoCRO.Lines.Clear;

  for ct:=0 to  ACBrAAC1.IdentPAF.ECFsAutorizados.Count-1 do
   begin
    ecfAux :=  TACBrAACECF(ACBrAAC1.IdentPAF.ECFsAutorizados.Items[ct]);
    memoNumeroSerie.Lines.Add(ecfAux.NumeroSerie);
    memoGT.Lines.Add(FormatFloat('###,###,##0.00',ecfAux.ValorGT));
    memoCRO.Lines.Add(FormatFloat('000',StrToFLoat(inttostr(ecfAux.CRO))) );
   end;
end;


procedure Tform1.ACBrAAC1GetChave(var Chave: String);
begin
  inherited;
  chave:='1234';
end;

procedure Tform1.SpeedButton4Click(Sender: TObject);
begin
  inherited;
  close;
end;

procedure Tform1.SpeedButton1Click(Sender: TObject);
begin
  inherited;
  ecf.Porta := cbPorta.Text;

  try
    ECF.Ativar;
  except
   begin
     ShowMessage('Erro ao conectar à porta do ECF');
     exit;
   end;
  end;

  edNumeroSerieECF.Text := ECF.NumSerie;
  edGTECF.Text          := FormatFloat('###,###,##0.00',ecf.GrandeTotal);
  edCROECF.Text         := ECF.NumCRO;
  ECF.Desativar;
  MessageDlg('Dados capturados com sucesso! O ECF será desconectado...', mtInformation, [mbOK], 0);

end;

procedure Tform1.SpeedButton2Click(Sender: TObject);
begin
  inherited;
  if trim(edNumeroSerieECF.Text) = '' then
   begin
     Showmessage('Número de série do ECF inválido!');
     edNumeroSerieECF.SetFocus;
     exit;
   end;

  try
    StrToFloat( trim(removePonto(edGTECF.Text)))
  except
   begin
     Showmessage('GT do ECF inválido!');
     edGTECF.SetFocus;
     exit;
   end;
  end;

  try
    StrToInt( trim(edCROECF.Text))
  except
   begin
     Showmessage('CRO do ECF inválido!');
     edCROECF.SetFocus;
     exit;
   end;
  end;

  memoNumeroSerie.Lines.Add(edNumeroSerieECF.Text);
  memoGT.Lines.Add(edGTECF.Text);
  memoCRO.Lines.Add(edCROECF.Text);  
end;

procedure Tform1.SpeedButton5Click(Sender: TObject);
begin
  inherited;
  memoNumeroSerie.Lines.Clear;
  memoGT.Lines.Clear;
  memoCRO.Lines.Clear;
end;

procedure Tform1.SpeedButton3Click(Sender: TObject);
begin
  inherited;
  recriarArquivoAuxiliar();
end;


function Tform1.removePonto(Text : string) : string;
var
n : integer;
total : integer;
contador : integer;
achou : boolean;
chars : array[1..10] of string;
begin
  total:=1;
  contador:=1;


 chars[1]:='.';
 while (contador <= total ) do
 begin


  n:=1;
  while( (n <=  length(Text)) ) do//for n := 1 to length(Text) do
  begin
    if Copy(Text,n,1) = chars[contador] then
      begin
        Delete(Text,n,1);
        achou:=true;
      end;
    n:=n+1;
   end;
  contador := contador +1;
 end;

  Result := Text;
end;


Function TForm1.getPastaSistemaWindows : String;
Var
Buffer : Array[0..144] of Char;
Begin
GetSystemDirectory(Buffer,144);
Result := StrPas(Buffer);
End;


procedure TForm1.cbxModeloChange(Sender: TObject);
begin
  try
     ECF.Modelo := TACBrECFModelo( cbxModelo.ItemIndex+2 ) ;
  except
     cbxModelo.ItemIndex := Integer( ECF.Modelo ) ;
     raise ;
  end ;

end;

end.
