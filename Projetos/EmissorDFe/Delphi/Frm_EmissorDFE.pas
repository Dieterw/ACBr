unit Frm_EmissorDFE;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, XPMan, ACBrCTeDACTEClass,
  ACBrCTeDACTeQRClass, ACBrCTe, ACBrNFeDANFEClass, ACBrNFeDANFeQRClass,
  ACBrNFe, jpeg, EditNumber, FileCtrl, ComCtrls, ShellCtrls;

type
  TfrmEmissorDFE = class(TForm)
    OpenDialog1: TOpenDialog;
    XPManifest1: TXPManifest;
    Panel1: TPanel;
    btnImprimir: TBitBtn;
    NFe: TACBrNFe;
    NFeDANFe: TACBrNFeDANFEQR;
    CTe: TACBrCTe;
    CTeDACTe: TACBrCTeDACTeQR;
    btnLimpar: TBitBtn;
    btnSite: TBitBtn;
    gbSelecioneDFE: TGroupBox;
    Label1: TLabel;
    sbDFE: TSpeedButton;
    edtArquivo: TEdit;
    gbDFE: TGroupBox;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    edtDFE: TEdit;
    edtEmitente: TEdit;
    edtData: TEdit;
    edtProtocolo: TEdit;
    edtNumDoc: TEditNumber;
    edtChave: TEdit;
    Image4: TImage;
    Image3: TImage;
    Image1: TImage;
    Memo1: TMemo;
    Label7: TLabel;
    edtCaminho: TEdit;
    flbArquivos2: TShellListView;
    procedure LimpaCampos;
    procedure FormShow(Sender: TObject);
    procedure sbDFEClick(Sender: TObject);
    procedure btnImprimirClick(Sender: TObject);
    procedure btnLimparClick(Sender: TObject);
    function GetBuildInfo: string;
    procedure PastaVisitada;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnSiteClick(Sender: TObject);
    procedure ListarArquivos;
    procedure CarregaArquivo;
    procedure flbArquivos2AddFolder(Sender: TObject; AFolder: TShellFolder;
      var CanAdd: Boolean);
    procedure flbArquivos2Click(Sender: TObject);
  private
    { Private declarations }
    Caminho: String;
    TipoDFE: Integer;
  public
    { Public declarations }
  end;

var
  frmEmissorDFE: TfrmEmissorDFE;

implementation

uses
 ShellAPI, StrUtils, IniFiles;

{$R *.dfm}

{ TfrmEmissorDFE }

procedure TfrmEmissorDFE.LimpaCampos;
begin
 edtCaminho.Text:='';
 edtArquivo.Text:='';
 PastaVisitada;

 TipoDFE:=0;
 edtDFE.Text:='';
 edtEmitente.Text:='';
 edtNumDoc.Text:='';
 edtData.Text:='';
 edtChave.Text:='';
 edtProtocolo.Text:='';
 Caption:='Emissor de Documentos Fiscais Eletrônicos (DANFe / DACTe) - Versão: ' +
            GetBuildInfo;
 ListarArquivos;
 btnImprimir.Enabled:=False;
end;

procedure TfrmEmissorDFE.FormShow(Sender: TObject);
begin
 LimpaCampos;
end;

procedure TfrmEmissorDFE.sbDFEClick(Sender: TObject);
var
  Dir: string;
begin
 if Length(Caminho) <= 0
  then Dir := ExtractFileDir(application.ExeName)
  else begin
   Dir := Trim(Caminho);
   if not DirectoryExists(Dir)
    then Dir := ExtractFileDir(application.ExeName);
  end;
 if SelectDirectory(Dir, [sdAllowCreate, sdPerformCreate, sdPrompt], 1000)
  then Caminho := Dir;

 edtCaminho.Text := Caminho;
 ListarArquivos;

 {
 OpenDialog1.Title := 'Selecione o Documento Fiscal Eletrônico';
 OpenDialog1.DefaultExt := '*.xml';
 OpenDialog1.Filter := 'Arquivos XML (*.xml)|*.xml|Todos os Arquivos (*.*)|*.*';
 OpenDialog1.InitialDir := Caminho;
 if OpenDialog1.Execute
  then edtArquivo.Text := OpenDialog1.FileName;
 if edtArquivo.Text<>''
  then begin
   Caminho := ExtractFileDir(edtArquivo.Text);
   CarregaArquivo;
  end;
}
end;

procedure TfrmEmissorDFE.btnImprimirClick(Sender: TObject);
var
 i: Integer;
begin
 case TipoDFE of
  1: begin // NF-e
      // Somente imprime o NFe
      for i:=0 to NFe.NotasFiscais.Items[0].NFe.Cobr.Dup.Count-1 do
       begin
        if length(NFe.NotasFiscais.Items[0].NFe.Cobr.Dup.Items[i].nDup)>2
         then NFe.NotasFiscais.Items[0].NFe.Cobr.Dup.Items[i].nDup:=FormatFloat('00', i+1);
       end;
      NFe.NotasFiscais.Imprimir;
     end;
  2: begin // CT-e
      // Somente imprime o CTe
      CTe.Conhecimentos.Imprimir;
     end;
 end;
end;

procedure TfrmEmissorDFE.btnLimparClick(Sender: TObject);
begin
 LimpaCampos;
end;

function TfrmEmissorDFE.GetBuildInfo: string;
var
 VerInfoSize: DWORD;
 VerInfo: Pointer;
 VerValueSize: DWORD;
 VerValue: PVSFixedFileInfo;
 Dummy: DWORD;
 V1, V2, V3, V4: Word;
 Prog : string;
begin
 Prog := Application.Exename;
 VerInfoSize := GetFileVersionInfoSize(PChar(prog), Dummy);
 GetMem(VerInfo, VerInfoSize);
 GetFileVersionInfo(PChar(prog), 0, VerInfoSize, VerInfo);
 VerQueryValue(VerInfo, '\', Pointer(VerValue), VerValueSize);
 with VerValue^ do
  begin
   V1 := dwFileVersionMS shr 16;
   V2 := dwFileVersionMS and $FFFF;
   V3 := dwFileVersionLS shr 16;
   V4 := dwFileVersionLS and $FFFF;
  end;
 FreeMem(VerInfo, VerInfoSize);
 result := IntToStr(v1)+'.'+IntToStr(v2)+'.'+IntToStr(v3)+'.'+IntToStr(v4);
end;

procedure TfrmEmissorDFE.PastaVisitada;
var
 ArqIni: TIniFile;
 Caminho2: String;
begin
 Caminho2 := ExtractFileDir(application.ExeName);
 Caminho  := ExtractFileDir(application.ExeName);

 if FileExists(Caminho2 + '\EmissorDFE.INI')
  then begin
   ArqIni:=TIniFile.Create(Caminho2 + '\EmissorDFE.INI');
   Caminho := ArqIni.ReadString('Configuracao', 'Caminho', '');
   ArqIni.Free;
  end
  else begin
   ArqIni:=TIniFile.Create(Caminho2 + '\EmissorDFE.INI');
   ArqIni.WriteString('Configuracao', 'Caminho', Caminho);
   ArqIni.Free;
  end;
 edtCaminho.Text := Caminho; 
end;

procedure TfrmEmissorDFE.FormClose(Sender: TObject;
  var Action: TCloseAction);
var
 ArqIni: TIniFile;
 Caminho2: String;
begin
 Caminho2 := ExtractFileDir(application.ExeName);
 ArqIni:=TIniFile.Create(Caminho2 + '\EmissorDFE.INI');
 ArqIni.WriteString('Configuracao', 'Caminho', Caminho);
 ArqIni.Free;
end;

procedure TfrmEmissorDFE.btnSiteClick(Sender: TObject);
var
 LinkSite, Chave, LinkChave: String;
begin
 case TipoDFE of
  1: begin // NF-e
      // http://www.nfe.fazenda.gov.br/portal
      //
//      LinkSite:='https://www.nfe.fazenda.gov.br/portal/consultaAutorizacaoUso.aspx?ChaveAcesso=';
      LinkSite:='https://www.nfe.fazenda.gov.br/portal/consulta.aspx?tipoConsulta=resumo&tipoConteudo=d09fwabTnLk=';
      Chave:='&ChaveAcesso='+edtChave.Text;
      LinkChave:=LinkSite+Chave;
      ShellExecute(0, Nil, PChar(LinkChave), nil, Nil, SW_NORMAL);
//      ShellExecute(0, Nil, PChar(LinkSite), PChar(Chave), Nil, SW_NORMAL);
     end;
  2: begin // CT-e
      // http://www.cte.fazenda.gov.br
//      LinkSite:='https://www.cte.fazenda.gov.br/visualizacaoCTe/resumo/Default.aspx';
//      LinkSite:='https://www.cte.fazenda.gov.br/FormularioDePesquisa.aspx?tipoconsulta=completa';
//      LinkSite:='https://www.cte.fazenda.gov.br/visualizacaoCTe/autorizacao/AutorizacaoUso.aspx?ChaveAcesso=';
      LinkSite:='https://www.nfe.fazenda.gov.br/portal/consultaAutorizacaoUso.aspx?ChaveAcesso=';
      Chave:=edtChave.Text;
      LinkChave:=LinkSite+Chave;
      ShellExecute(0, Nil, PChar(LinkChave), Nil, Nil, SW_NORMAL);
     end;
 end;

end;

procedure TfrmEmissorDFE.ListarArquivos;
var
 Tamanho: Integer;
begin
// edtArquivo.Text := Caminho;
 Caminho :=Trim(Caminho);
 Tamanho := Length(Caminho);

// flbArquivos.Drive     := Caminho[1];
// flbArquivos.Directory := Copy(Caminho, 3, Tamanho - 2);
// flbArquivos.Mask      := '*.xml';
// flbArquivos.Update;

 flbArquivos2.Root := Caminho;
end;

procedure TfrmEmissorDFE.CarregaArquivo;
var
 ArquivoXML: TStringList;
begin
 ArquivoXML := TStringList.Create;
 ArquivoXML.LoadFromFile(edtArquivo.Text);

 if pos('<infNFe', ArquivoXML.Text) > 0
  then TipoDFE := 1;
 if pos('<infCte', ArquivoXML.Text) > 0
  then TipoDFE := 2;

 ArquivoXML.Free;

 if TipoDFE = 1 // UpperCase(RightStr(edtArquivo.Text, 8))='-NFE.XML'
  then begin
   edtDFE.Text:='NOTA FISCAL ELETRÔNICA';

   // Carrega no Componente o NFe salvo em Arquivo XML
   NFe.NotasFiscais.Clear;
   NFe.NotasFiscais.LoadFromFile(edtArquivo.Text);
   //NFe.NotasFiscais.Valida;
   //ShowMessage('Nota Fiscal Eletrônica Valida');

   edtEmitente.Text:=NFe.NotasFiscais.Items[0].NFe.Emit.xNome;
   edtNumDoc.StoreValue(NFe.NotasFiscais.Items[0].NFe.Ide.nNF);
   edtData.Text:=DateToStr(NFe.NotasFiscais.Items[0].NFe.Ide.dEmi);
   edtChave.Text:=Copy(NFe.NotasFiscais.Items[0].NFe.infNFe.ID, 4, 44);
   // edtChave.Text:=trim(NFe.NotasFiscais.Items[0].NFe.procNFe.chNFe);
   edtProtocolo.Text:=NFe.NotasFiscais.Items[0].NFe.procNFe.nProt;
   {
   if (edtChave.Text='') or
      (Copy(NFe.NotasFiscais.Items[0].NFe.procNFe.verAplic, 8, 7)='PL_005e')
    then begin
     edtChave.Text:=Copy(ExtractFileName(edtArquivo.Text), 1, 44);
     NFe.NotasFiscais.Items[0].NFe.infNFe.ID:='NFe'+edtChave.Text;
    end;
   }
  end;
 if TipoDFE = 2 // UpperCase(RightStr(edtArquivo.Text, 8))='-CTE.XML'
  then begin
   edtDFE.Text:='CONHECIMENTO DE TRANSPORTE ELETRÔNICO';

   // Carrega no Componente o CTe salvo em Arquivo XML
   CTe.Conhecimentos.Clear;
   CTe.Conhecimentos.LoadFromFile(edtArquivo.Text);
   //CTe.Conhecimentos.Valida;
   //ShowMessage('Conhecimento de Transporte Eletrônico Valido');

   edtEmitente.Text:=CTe.Conhecimentos.Items[0].CTe.Emit.xNome;
   edtNumDoc.StoreValue(CTe.Conhecimentos.Items[0].CTe.Ide.nCT);
   edtData.Text:=DateToStr(CTe.Conhecimentos.Items[0].CTe.Ide.dhEmi);
   edtChave.Text:=Copy(CTe.Conhecimentos.Items[0].CTe.inFCTe.ID,4,44);
   // edtChave.Text:=trim(CTe.Conhecimentos.Items[0].CTe.procCTe.chCTe);
   edtProtocolo.Text:=CTe.Conhecimentos.Items[0].CTe.procCTe.nProt;
   {
   if edtChave.Text=''
    then edtChave.Text:=Copy(CTe.Conhecimentos.Items[0].CTe.inFCTe.ID,4,44);
   }
  end;
 btnImprimir.Enabled:=(edtArquivo.Text<>'');
end;

procedure TfrmEmissorDFE.flbArquivos2AddFolder(Sender: TObject;
  AFolder: TShellFolder; var CanAdd: Boolean);
var
 XFilterExt, XExt: string;
begin
 XFilterExt := '.XML';
 XExt := UpperCase(ExtractFileExt(AFolder.PathName));

 if (XExt = XFilterExt)// or AFolder.IsFolder
  then CanAdd := True
  else CanAdd := False;
end;

procedure TfrmEmissorDFE.flbArquivos2Click(Sender: TObject);
begin
 edtArquivo.Text:=flbArquivos2.Folders[flbArquivos2.itemindex].PathName;
// ShellListView1.Folders[ShellListView1.itemindex].PathName;

 CarregaArquivo;
end;

end.
