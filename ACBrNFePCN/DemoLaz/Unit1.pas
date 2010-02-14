unit Unit1;

{$DEFINE ACBrNFeOpenSSL}

{$mode objfpc}

interface

uses Classes, SysUtils, FileUtil, LResources, Forms, Controls, Graphics, Dialogs,
     IniFiles, StdCtrls, ExtCtrls, Buttons, ComCtrls, IpHtml,
     ACBrNFe, pcnConversao, ACBrNFeDANFEClass, ACBrUtil;

type

  { TForm1 }

  TForm1 = class(TForm)
     ckVisualizar: TCheckBox;
    Panel1: TPanel;
    GroupBox1: TGroupBox;
    PageControl1: TPageControl;
    Panel4: TPanel;
    Panel5: TPanel;
    rgFormaEmissao: TRadioGroup;
    rgTipoAmb: TRadioGroup;
    rgTipoDanfe: TRadioGroup;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    GroupBox2: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    sbtnCaminhoCert: TSpeedButton;
    edtCaminho: TEdit;
    edtSenha: TEdit;
    GroupBox3: TGroupBox;
    GroupBox4: TGroupBox;
    Label6: TLabel;
    cbUF: TComboBox;
    Label7: TLabel;
    edtLogoMarca: TEdit;
    sbtnLogoMarca: TSpeedButton;
    edtPathLogs: TEdit;
    sbtnPathSalvar: TSpeedButton;
    ckSalvar: TCheckBox;
    gbProxy: TGroupBox;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    edtProxyHost: TEdit;
    edtProxyPorta: TEdit;
    edtProxyUser: TEdit;
    edtProxySenha: TEdit;
    OpenDialog1: TOpenDialog;
    btnSalvarConfig: TBitBtn;
    TabSheet4: TTabSheet;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    edtEmitCNPJ: TEdit;
    edtEmitIE: TEdit;
    edtEmitRazao: TEdit;
    edtEmitFantasia: TEdit;
    edtEmitFone: TEdit;
    edtEmitCEP: TEdit;
    edtEmitLogradouro: TEdit;
    edtEmitNumero: TEdit;
    edtEmitComp: TEdit;
    edtEmitBairro: TEdit;
    edtEmitCodCidade: TEdit;
    edtEmitCidade: TEdit;
    edtEmitUF: TEdit;
    Panel2: TPanel;
    Panel3: TPanel;
    btnImprimir: TButton;
    btnConsultar: TButton;
    btnValidarXML: TButton;
    btnStatusServ: TButton;
    btnCancNF: TButton;
    PageControl2: TPageControl;
    TabSheet5: TTabSheet;
    btnCriarEnviar: TButton;
    btnInutilizar: TButton;
    MemoResp: TMemo;
    TabSheet6: TTabSheet;
    WBResposta: TIpHtmlPanel;
    edtNumSerie: TEdit;
    Label25: TLabel;
    ACBrNFe1: TACBrNFe;
    sbtnGetCert: TSpeedButton;
    btnGerarNFE: TButton;
    btnConsCad: TButton;
    btnGerarPDF: TButton;
    btnEnviarEmail: TButton;
    TabSheet7: TTabSheet;
    GroupBox5: TGroupBox;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label26: TLabel;
    Label27: TLabel;
    Label28: TLabel;
    edtSmtpHost: TEdit;
    edtSmtpPort: TEdit;
    edtSmtpUser: TEdit;
    edtSmtpPass: TEdit;
    edtEmailAssunto: TEdit;
    cbEmailSSL: TCheckBox;
    mmEmailMsg: TMemo;
    btnConsultarRecibo: TButton;
    btnEnvDPEC: TButton;
    btnConsultarDPEC: TButton;
    TabSheet8: TTabSheet;
    memoLog: TMemo;
    btnImportarXML: TButton;
    TabSheet9: TTabSheet;
    trvwNFe: TTreeView;
    lblColaborador: TLabel;
    lblPatrocinador: TLabel;
    lblDoar1: TLabel;
    lblDoar2: TLabel;
    procedure sbtnCaminhoCertClick(Sender: TObject);
    procedure sbtnLogoMarcaClick(Sender: TObject);
    procedure sbtnPathSalvarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnSalvarConfigClick(Sender: TObject);
    procedure btnStatusServClick(Sender: TObject);
    procedure btnConsultarClick(Sender: TObject);
    procedure btnCancNFClick(Sender: TObject);
    procedure btnValidarXMLClick(Sender: TObject);
    procedure btnImprimirClick(Sender: TObject);
    procedure btnCriarEnviarClick(Sender: TObject);
    procedure btnInutilizarClick(Sender: TObject);
    procedure ACBrNFe1StatusChange(Sender: TObject);
    procedure sbtnGetCertClick(Sender: TObject);
    procedure btnGerarNFEClick(Sender: TObject);
    procedure btnConsCadClick(Sender: TObject);
    procedure btnGerarPDFClick(Sender: TObject);
    procedure btnEnviarEmailClick(Sender: TObject);
    procedure btnConsultarReciboClick(Sender: TObject);
    procedure btnEnvDPECClick(Sender: TObject);
    procedure btnConsultarDPECClick(Sender: TObject);
    procedure ACBrNFe1GerarLog(const Mensagem: String);
    procedure btnImportarXMLClick(Sender: TObject);
    procedure lblMouseEnter(Sender: TObject);
    procedure lblMouseLeave(Sender: TObject);
    procedure lblColaboradorClick(Sender: TObject);
    procedure lblPatrocinadorClick(Sender: TObject);
    procedure lblDoar1Click(Sender: TObject);
    
  private
    { Private declarations }
    procedure GravarConfiguracao ;
    procedure LerConfiguracao ;
    procedure LoadXML(MyMemo: TMemo; MyWebBrowser: TIpHtmlPanel);

  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses FileCtrl, pcnNFe, ufrmStatus, ACBrNFeNotasFiscais, DateUtils, ACBrNFeUtil;

const
  SELDIRHELP = 1000;

procedure TForm1.GravarConfiguracao;
Var IniFile : String ;
    Ini     : TIniFile ;
    StreamMemo : TMemoryStream;
begin
  IniFile := ChangeFileExt( Application.ExeName, '.ini') ;

  Ini := TIniFile.Create( IniFile );
  try
      Ini.WriteString( 'Certificado','Caminho' ,edtCaminho.Text) ;
      Ini.WriteString( 'Certificado','Senha'   ,edtSenha.Text) ;
      Ini.WriteString( 'Certificado','NumSerie',edtNumSerie.Text) ;

      Ini.WriteInteger( 'Geral','DANFE'       ,rgTipoDanfe.ItemIndex) ;
      Ini.WriteInteger( 'Geral','FormaEmissao',rgFormaEmissao.ItemIndex) ;
      Ini.WriteString( 'Geral','LogoMarca'   ,edtLogoMarca.Text) ;
      Ini.WriteBool(   'Geral','Salvar'      ,ckSalvar.Checked) ;
      Ini.WriteString( 'Geral','PathSalvar'  ,edtPathLogs.Text) ;

      Ini.WriteString( 'WebService','UF'        ,cbUF.Text) ;
      Ini.WriteInteger( 'WebService','Ambiente'  ,rgTipoAmb.ItemIndex) ;
      Ini.WriteBool(   'WebService','Visualizar',ckVisualizar.Checked) ;

      Ini.WriteString( 'Proxy','Host'   ,edtProxyHost.Text) ;
      Ini.WriteString( 'Proxy','Porta'  ,edtProxyPorta.Text) ;
      Ini.WriteString( 'Proxy','User'   ,edtProxyUser.Text) ;
      Ini.WriteString( 'Proxy','Pass'   ,edtProxySenha.Text) ;

      Ini.WriteString( 'Emitente','CNPJ'       ,edtEmitCNPJ.Text) ;
      Ini.WriteString( 'Emitente','IE'         ,edtEmitIE.Text) ;
      Ini.WriteString( 'Emitente','RazaoSocial',edtEmitRazao.Text) ;
      Ini.WriteString( 'Emitente','Fantasia'   ,edtEmitFantasia.Text) ;
      Ini.WriteString( 'Emitente','Fone'       ,edtEmitFone.Text) ;
      Ini.WriteString( 'Emitente','CEP'        ,edtEmitCEP.Text) ;
      Ini.WriteString( 'Emitente','Logradouro' ,edtEmitLogradouro.Text) ;
      Ini.WriteString( 'Emitente','Numero'     ,edtEmitNumero.Text) ;
      Ini.WriteString( 'Emitente','Complemento',edtEmitComp.Text) ;
      Ini.WriteString( 'Emitente','Bairro'     ,edtEmitBairro.Text) ;
      Ini.WriteString( 'Emitente','CodCidade'  ,edtEmitCodCidade.Text) ;
      Ini.WriteString( 'Emitente','Cidade'     ,edtEmitCidade.Text) ;
      Ini.WriteString( 'Emitente','UF'         ,edtEmitUF.Text) ;

      Ini.WriteString( 'Email','Host'    ,edtSmtpHost.Text) ;
      Ini.WriteString( 'Email','Port'    ,edtSmtpPort.Text) ;
      Ini.WriteString( 'Email','User'    ,edtSmtpUser.Text) ;
      Ini.WriteString( 'Email','Pass'    ,edtSmtpPass.Text) ;
      Ini.WriteString( 'Email','Assunto' ,edtEmailAssunto.Text) ;
      Ini.WriteBool(   'Email','SSL'     ,cbEmailSSL.Checked ) ;
      StreamMemo := TMemoryStream.Create;
      mmEmailMsg.Lines.SaveToStream(StreamMemo);
      StreamMemo.Seek(0,soFromBeginning);
      Ini.WriteBinaryStream( 'Email','Mensagem',StreamMemo) ;
      StreamMemo.Free;
  finally
     Ini.Free ;
  end;

end;

procedure TForm1.LerConfiguracao;
Var IniFile  : String ;
    Ini     : TIniFile ;
    Ok : Boolean;
    StreamMemo : TMemoryStream;
begin
  IniFile := ChangeFileExt( Application.ExeName, '.ini') ;

  Ini := TIniFile.Create( IniFile );
  try
      {$IFDEF ACBrNFeOpenSSL}
         edtCaminho.Text  := Ini.ReadString( 'Certificado','Caminho' ,'') ;
         edtSenha.Text    := Ini.ReadString( 'Certificado','Senha'   ,'') ;
         ACBrNFe1.Configuracoes.Certificados.Certificado  := edtCaminho.Text;
         ACBrNFe1.Configuracoes.Certificados.Senha        := edtSenha.Text;
         edtNumSerie.Visible := False;
         Label25.Visible := False;
         sbtnGetCert.Visible := False;
      {$ELSE}
         edtNumSerie.Text := Ini.ReadString( 'Certificado','NumSerie','') ;
         ACBrNFe1.Configuracoes.Certificados.NumeroSerie := edtNumSerie.Text;
         edtNumSerie.Text := ACBrNFe1.Configuracoes.Certificados.NumeroSerie;
         Label1.Caption := 'Informe o número de série do certificado'#13+
                           'Disponível no Internet Explorer no menu'#13+
                           'Ferramentas - Opções da Internet - Conteúdo '#13+
                           'Certificados - Exibir - Detalhes - '#13+
                           'Número do certificado';
         Label2.Visible := False;
         edtCaminho.Visible := False;
         edtSenha.Visible   := False;
         sbtnCaminhoCert.Visible := False;
      {$ENDIF}

      rgFormaEmissao.ItemIndex := Ini.ReadInteger( 'Geral','FormaEmissao',0) ;
      ckSalvar.Checked    := Ini.ReadBool(   'Geral','Salvar'      ,True) ;
      edtPathLogs.Text    := Ini.ReadString( 'Geral','PathSalvar'  ,'') ;
      ACBrNFe1.Configuracoes.Geral.FormaEmissao := StrToTpEmis(OK,IntToStr(rgFormaEmissao.ItemIndex+1));
      ACBrNFe1.Configuracoes.Geral.Salvar       := ckSalvar.Checked;
      ACBrNFe1.Configuracoes.Geral.PathSalvar   := edtPathLogs.Text;

      cbUF.ItemIndex       := cbUF.Items.IndexOf(Ini.ReadString( 'WebService','UF','SP')) ;
      rgTipoAmb.ItemIndex  := Ini.ReadInteger( 'WebService','Ambiente'  ,0) ;
      ckVisualizar.Checked :=Ini.ReadBool(    'WebService','Visualizar',False) ;
      ACBrNFe1.Configuracoes.WebServices.UF         := cbUF.Text;
      ACBrNFe1.Configuracoes.WebServices.Ambiente   := StrToTpAmb(Ok,IntToStr(rgTipoAmb.ItemIndex+1));
      ACBrNFe1.Configuracoes.WebServices.Visualizar := ckVisualizar.Checked;

      edtProxyHost.Text  := Ini.ReadString( 'Proxy','Host'   ,'') ;
      edtProxyPorta.Text := Ini.ReadString( 'Proxy','Porta'  ,'') ;
      edtProxyUser.Text  := Ini.ReadString( 'Proxy','User'   ,'') ;
      edtProxySenha.Text := Ini.ReadString( 'Proxy','Pass'   ,'') ;
      ACBrNFe1.Configuracoes.WebServices.ProxyHost := edtProxyHost.Text;
      ACBrNFe1.Configuracoes.WebServices.ProxyPort := edtProxyPorta.Text;
      ACBrNFe1.Configuracoes.WebServices.ProxyUser := edtProxyUser.Text;
      ACBrNFe1.Configuracoes.WebServices.ProxyPass := edtProxySenha.Text;

      rgTipoDanfe.ItemIndex     := Ini.ReadInteger( 'Geral','DANFE'       ,0) ;
      edtLogoMarca.Text         := Ini.ReadString( 'Geral','LogoMarca'   ,'') ;
      if ACBrNFe1.DANFE <> nil then
       begin
         ACBrNFe1.DANFE.TipoDANFE  := StrToTpImp(OK,IntToStr(rgTipoDanfe.ItemIndex+1));
         ACBrNFe1.DANFE.Logo       := edtLogoMarca.Text;
       end;  

      edtEmitCNPJ.Text       := Ini.ReadString( 'Emitente','CNPJ'       ,'') ;
      edtEmitIE.Text         := Ini.ReadString( 'Emitente','IE'         ,'') ;
      edtEmitRazao.Text      := Ini.ReadString( 'Emitente','RazaoSocial','') ;
      edtEmitFantasia.Text   := Ini.ReadString( 'Emitente','Fantasia'   ,'') ;
      edtEmitFone.Text       := Ini.ReadString( 'Emitente','Fone'       ,'') ;
      edtEmitCEP.Text        := Ini.ReadString( 'Emitente','CEP'        ,'') ;
      edtEmitLogradouro.Text := Ini.ReadString( 'Emitente','Logradouro' ,'') ;
      edtEmitNumero.Text     := Ini.ReadString( 'Emitente','Numero'     ,'') ;
      edtEmitComp.Text       := Ini.ReadString( 'Emitente','Complemento','') ;
      edtEmitBairro.Text     := Ini.ReadString( 'Emitente','Bairro'     ,'') ;
      edtEmitCodCidade.Text  := Ini.ReadString( 'Emitente','CodCidade'  ,'') ;
      edtEmitCidade.Text     :=Ini.ReadString( 'Emitente','Cidade'     ,'') ;
      edtEmitUF.Text         := Ini.ReadString( 'Emitente','UF'         ,'') ;

      edtSmtpHost.Text      := Ini.ReadString( 'Email','Host'   ,'') ;
      edtSmtpPort.Text      := Ini.ReadString( 'Email','Port'   ,'') ;
      edtSmtpUser.Text      := Ini.ReadString( 'Email','User'   ,'') ;
      edtSmtpPass.Text      := Ini.ReadString( 'Email','Pass'   ,'') ;
      edtEmailAssunto.Text  := Ini.ReadString( 'Email','Assunto','') ;
      cbEmailSSL.Checked    := Ini.ReadBool(   'Email','SSL'    ,False) ;
      StreamMemo := TMemoryStream.Create;
      Ini.ReadBinaryStream( 'Email','Mensagem',StreamMemo) ;
      mmEmailMsg.Lines.LoadFromStream(StreamMemo);
      StreamMemo.Free;
  finally
     Ini.Free ;
  end;

end;

procedure TForm1.LoadXML(MyMemo: TMemo; MyWebBrowser: TIpHtmlPanel);
begin
//  MyMemo.Lines.SaveToFile(ExtractFileDir(application.ExeName)+'temp.xml');
//  MyWebBrowser.Navigate(ExtractFileDir(application.ExeName)+'temp.xml');
end;

procedure TForm1.sbtnCaminhoCertClick(Sender: TObject);
begin
  OpenDialog1.Title := 'Selecione o Certificado';
  OpenDialog1.DefaultExt := '*.pfx';
  OpenDialog1.Filter := 'Arquivos PFX (*.pfx)|*.pfx|Todos os Arquivos (*.*)|*.*';
  OpenDialog1.InitialDir := ExtractFileDir(application.ExeName);
  if OpenDialog1.Execute then
  begin
    edtCaminho.Text := OpenDialog1.FileName;
  end;
end;

procedure TForm1.sbtnLogoMarcaClick(Sender: TObject);
begin
  OpenDialog1.Title := 'Selecione o Logo';
  OpenDialog1.DefaultExt := '*.bmp';
  OpenDialog1.Filter := 'Arquivos BMP (*.bmp)|*.bmp|Todos os Arquivos (*.*)|*.*';
  OpenDialog1.InitialDir := ExtractFileDir(application.ExeName);
  if OpenDialog1.Execute then
  begin
    edtLogoMarca.Text := OpenDialog1.FileName;
  end;
end;

procedure TForm1.sbtnPathSalvarClick(Sender: TObject);
var
  Dir: AnsiString;
begin
  if Length(edtPathLogs.Text) <= 0 then
     Dir := ExtractFileDir(application.ExeName)
  else
     Dir := edtPathLogs.Text;

  if SelectDirectory(Dir, [sdAllowCreate, sdPerformCreate, sdPrompt],SELDIRHELP) then
    edtPathLogs.Text := Dir;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
 LerConfiguracao;
end;

procedure TForm1.btnSalvarConfigClick(Sender: TObject);
begin
 GravarConfiguracao;
 LerConfiguracao;
end;

procedure TForm1.btnStatusServClick(Sender: TObject);
begin
 ACBrNFe1.WebServices.StatusServico.Executar;
 MemoResp.Lines.Text := UTF8Encode(ACBrNFe1.WebServices.StatusServico.RetWS);
 LoadXML(MemoResp, WBResposta);
end;

procedure TForm1.btnConsultarClick(Sender: TObject);
begin
  OpenDialog1.Title := 'Selecione a NFE';
  OpenDialog1.DefaultExt := '*-nfe.XML';
  OpenDialog1.Filter := 'Arquivos NFE (*-nfe.XML)|*-nfe.XML|Arquivos XML (*.XML)|*.XML|Todos os Arquivos (*.*)|*.*';
  OpenDialog1.InitialDir := ACBrNFe1.Configuracoes.Geral.PathSalvar;
  if OpenDialog1.Execute then
  begin
    ACBrNFe1.NotasFiscais.Clear;
    ACBrNFe1.NotasFiscais.LoadFromFile(OpenDialog1.FileName);
    ACBrNFe1.Consultar;
    ShowMessage(ACBrNFe1.WebServices.Consulta.Protocolo);
    MemoResp.Lines.Text := UTF8Encode(ACBrNFe1.WebServices.Consulta.RetWS);
    LoadXML(MemoResp, WBResposta);
  end;
end;

procedure TForm1.btnCancNFClick(Sender: TObject);
var
  vAux : AnsiString;
begin
  OpenDialog1.Title := 'Selecione a NFE';
  OpenDialog1.DefaultExt := '*-nfe.XML';
  OpenDialog1.Filter := 'Arquivos NFE (*-nfe.XML)|*-nfe.XML|Arquivos XML (*.XML)|*.XML|Todos os Arquivos (*.*)|*.*';
  OpenDialog1.InitialDir := ACBrNFe1.Configuracoes.Geral.PathSalvar;
  if OpenDialog1.Execute then
  begin
    ACBrNFe1.NotasFiscais.Clear;
    ACBrNFe1.NotasFiscais.LoadFromFile(OpenDialog1.FileName);
    if not(InputQuery('WebServices Cancelamento', 'Justificativa', vAux)) then
       exit;
     ACBrNFe1.Cancelamento(vAux);
     MemoResp.Lines.Text :=  UTF8Encode(ACBrNFe1.WebServices.Cancelamento.RetWS);
     LoadXML(MemoResp, WBResposta);
     ShowMessage(IntToStr(ACBrNFe1.WebServices.Cancelamento.cStat));
     ShowMessage(ACBrNFe1.WebServices.Cancelamento.Protocolo);
  end;
end;

procedure TForm1.btnValidarXMLClick(Sender: TObject);
begin
  OpenDialog1.Title := 'Selecione a NFE';
  OpenDialog1.DefaultExt := '*-nfe.XML';
  OpenDialog1.Filter := 'Arquivos NFE (*-nfe.XML)|*-nfe.XML|Arquivos XML (*.XML)|*.XML|Todos os Arquivos (*.*)|*.*';
  OpenDialog1.InitialDir := ACBrNFe1.Configuracoes.Geral.PathSalvar;
  if OpenDialog1.Execute then
  begin
    ACBrNFe1.NotasFiscais.Clear;
    ACBrNFe1.NotasFiscais.LoadFromFile(OpenDialog1.FileName);
    ACBrNFe1.NotasFiscais.Valida;
    showmessage('Nota Fiscal Eletrônica Valida');
  end;
end;

procedure TForm1.btnImprimirClick(Sender: TObject);
begin
  OpenDialog1.Title := 'Selecione a NFE';
  OpenDialog1.DefaultExt := '*-nfe.XML';
  OpenDialog1.Filter := 'Arquivos NFE (*-nfe.XML)|*-nfe.XML|Arquivos XML (*.XML)|*.XML|Todos os Arquivos (*.*)|*.*';
  OpenDialog1.InitialDir := ACBrNFe1.Configuracoes.Geral.PathSalvar;
  if OpenDialog1.Execute then
  begin
    ACBrNFe1.NotasFiscais.Clear;
    ACBrNFe1.NotasFiscais.LoadFromFile(OpenDialog1.FileName);
    if ACBrNFe1.NotasFiscais.Items[0].NFe.Ide.tpEmis = teDPEC then
     begin
       ACBrNFe1.WebServices.ConsultaDPEC.NFeChave := ACBrNFe1.NotasFiscais.Items[0].NFe.infNFe.ID;
       ACBrNFe1.WebServices.ConsultaDPEC.Executar;
       ACBrNFe1.DANFE.ProtocoloNFe := ACBrNFe1.WebServices.ConsultaDPEC.nRegDPEC +' '+ DateTimeToStr(ACBrNFe1.WebServices.ConsultaDPEC.retDPEC.dhRegDPEC);
     end;
    ACBrNFe1.NotasFiscais.Imprimir;
  end;
end;

procedure TForm1.btnCriarEnviarClick(Sender: TObject);
var
 vAux : AnsiString;
begin
if not(InputQuery('WebServices Enviar', 'Numero da Nota', vAux)) then
    exit;

  ACBrNFe1.NotasFiscais.Clear;

  with ACBrNFe1.NotasFiscais.Add.NFe do
  begin
    infNFe.ID := vAux;

    Ide.natOp     := 'VENDA PRODUCAO DO ESTAB.';
    Ide.nNF       := StrToInt(vAux);
    Ide.cNF       := StrToInt(vAux);
    Ide.modelo    := 55;
    Ide.serie     := 1;
    Ide.dEmi      := Date;
    Ide.dSaiEnt   := Date;
    Ide.tpAmb     := taHomologacao;
    Ide.tpNF      := tnSaida;
    Ide.indPag    := ipVista;
    Ide.verProc   := '1.0.0.0';
    Ide.cUF       := 35;
    Ide.cMunFG    := 3554003;

    Emit.CNPJCPF           := edtEmitCNPJ.Text;
    Emit.IE                := edtEmitIE.Text;
    Emit.xNome             := edtEmitRazao.Text;
    Emit.xFant             := edtEmitFantasia.Text;
    Emit.EnderEmit.fone    := edtEmitFone.Text;
    Emit.EnderEmit.CEP     := StrToInt(edtEmitCEP.Text);
    Emit.EnderEmit.xLgr    := edtEmitLogradouro.Text;
    Emit.EnderEmit.nro     := edtEmitNumero.Text;
    Emit.EnderEmit.xCpl    := edtEmitComp.Text;
    Emit.EnderEmit.xBairro := edtEmitBairro.Text;
    Emit.EnderEmit.cMun    := StrToInt(edtEmitCodCidade.Text);
    Emit.EnderEmit.xMun    := edtEmitCidade.Text;
    Emit.EnderEmit.UF      := edtEmitUF.Text;
    Emit.enderEmit.cPais   := 1058;
    Emit.enderEmit.xPais   := 'BRASIL';

    Dest.CNPJCPF           := '05481336000137';
    Dest.EnderDest.CEP     := 18270410;
    Dest.EnderDest.xLgr    := 'Praça Anita Costa';
    Dest.EnderDest.nro     := '0034';
    Dest.EnderDest.xCpl    := '';
    Dest.EnderDest.xBairro := 'Centro';
    Dest.EnderDest.cMun    := 3554003;
    Dest.EnderDest.xMun    := 'Tatuí';
    Dest.EnderDest.UF      := 'SP';
    Dest.EnderDest.Fone    := '1532599600';
    Dest.IE                := '687138770110';
    Dest.xNome             := 'D.J. COM. E LOCAÇÃO DE SOFTWARES LTDA - ME';
    Dest.EnderDest.cPais   := 1058;
    Dest.EnderDest.xPais   := 'BRASIL';

    with Det.Add do
    begin
      infAdProd     := 'Teste de informacao adicional;Teste de Segunda Linha';
      Prod.nItem    := 1;
      Prod.CFOP     := '5101';
      Prod.cProd    := '67';
      Prod.xProd    := 'ALHO 400 G';
      Prod.qCom     := 100;
      Prod.uCom     := 'KG';
      Prod.vProd    := 100;
      Prod.vUnCom   := 10;
      Prod.qTrib    := 100;
      Prod.uTrib    := 'KG';
      Prod.vUnTrib  := 10;
      with Imposto do
      begin
        with ICMS do
        begin
          CST := cst00;
          ICMS.modBC  := dbiPrecoTabelado;
          ICMS.pICMS  := 18;
          ICMS.vICMS  := 180;
          ICMS.vBC    := 1000;
        end;
        IPI.CST := ipi01;
      end;
    end;

    with Det.Add do
    begin
      Prod.nItem    := 2;
      Prod.CFOP     := '5101';
      Prod.cProd    := '68';
      Prod.xProd    := 'CEBOLA 400 G';
      Prod.qCom     := 100;
      Prod.uCom     := 'KG';
      Prod.vProd    := 100;
      Prod.vUnCom   := 10;
      Prod.qTrib    := 100;
      Prod.uTrib    := 'KG';
      Prod.vUnTrib  := 10;
      with Imposto do
      begin
        with ICMS do
        begin
          CST := cst00;
          ICMS.modBC  := dbiPrecoTabelado;
          ICMS.orig   := oeNacional;
          ICMS.pICMS  := 18;
          ICMS.vICMS  := 180;
          ICMS.vBC    := 1000;
        end;
        IPI.CST := ipi01;
      end;
    end;

    Total.ICMSTot.vBC   := 1000;
    Total.ICMSTot.vICMS := 180;
    Total.ICMSTot.vNF   := 1000;
    Total.ICMSTot.vProd := 1000;
  end;

{  with ACBrNFe1.NotasFiscais.Add.NFe do
  begin
    infNFe.ID := vAux;

    Ide.natOp     := 'VENDA PRODUCAO DO ESTAB.';
    Ide.nNF       := StrToInt(vAux)+1;
    Ide.cNF       := StrToInt(vAux)+1;
    Ide.modelo    := 55;
    Ide.serie     := 1;
    Ide.dEmi      := Date;
    Ide.dSaiEnt   := Date;
    Ide.tpAmb     := taHomologacao;
    Ide.tpNF      := tnSaida;
    Ide.indPag    := ipVista;
    Ide.verProc   := '1.0.0.0';
    Ide.cUF       := 35;
    Ide.cMunFG    := 3554003;

    Emit.CNPJCPF           := edtEmitCNPJ.Text;
    Emit.IE                := edtEmitIE.Text;
    Emit.xNome             := edtEmitRazao.Text;
    Emit.xFant             := edtEmitFantasia.Text;
    Emit.EnderEmit.fone    := edtEmitFone.Text;
    Emit.EnderEmit.CEP     := StrToInt(edtEmitCEP.Text);
    Emit.EnderEmit.xLgr    := edtEmitLogradouro.Text;
    Emit.EnderEmit.nro     := edtEmitNumero.Text;
    Emit.EnderEmit.xCpl    := edtEmitComp.Text;
    Emit.EnderEmit.xBairro := edtEmitBairro.Text;
    Emit.EnderEmit.cMun    := StrToInt(edtEmitCodCidade.Text);
    Emit.EnderEmit.xMun    := edtEmitCidade.Text;
    Emit.EnderEmit.UF      := edtEmitUF.Text;
    Emit.enderEmit.cPais   := 1058;
    Emit.enderEmit.xPais   := 'BRASIL';

    Dest.CNPJCPF           := '05481336000137';
    Dest.EnderDest.CEP     := 18270410;
    Dest.EnderDest.xLgr    := 'Praça Anita Costa';
    Dest.EnderDest.nro     := '0034';
    Dest.EnderDest.xCpl    := '';
    Dest.EnderDest.xBairro := 'Centro';
    Dest.EnderDest.cMun    := 3554003;
    Dest.EnderDest.xMun    := 'Tatuí';
    Dest.EnderDest.UF      := 'SP';
    Dest.EnderDest.Fone    := '1532599600';
    Dest.IE                := '687138770110';
    Dest.xNome             := 'D.J. COM. E LOCAÇÃO DE SOFTWARES LTDA - ME';
    Dest.EnderDest.cPais   := 1058;
    Dest.EnderDest.xPais   := 'BRASIL';

    with Det.Add do
    begin
      infAdProd     := 'Teste de informacao adicional;Teste de Segunda Linha';
      Prod.nItem    := 1;
      Prod.CFOP     := '5101';
      Prod.cProd    := '67';
      Prod.xProd    := 'ALHO 400 G';
      Prod.qCom     := 100;
      Prod.uCom     := 'KG';
      Prod.vProd    := 100;
      Prod.vUnCom   := 10;
      Prod.qTrib    := 100;
      Prod.uTrib    := 'KG';
      Prod.vUnTrib  := 10;
      with Imposto do
      begin
        with ICMS do
        begin
          CST := cst00;
          ICMS.modBC  := dbiPrecoTabelado;
          ICMS.pICMS  := 18;
          ICMS.vICMS  := 180;
          ICMS.vBC    := 1000;
        end;
        IPI.CST := ipi01;
      end;
    end;

    with Det.Add do
    begin
      Prod.nItem    := 2;
      Prod.CFOP     := '5101';
      Prod.cProd    := '68';
      Prod.xProd    := 'CEBOLA 400 G';
      Prod.qCom     := 100;
      Prod.uCom     := 'KG';
      Prod.vProd    := 100;
      Prod.vUnCom   := 10;
      Prod.qTrib    := 100;
      Prod.uTrib    := 'KG';
      Prod.vUnTrib  := 10;
      with Imposto do
      begin
        with ICMS do
        begin
          CST := cst00;
          ICMS.modBC  := dbiPrecoTabelado;
          ICMS.pICMS  := 18;
          ICMS.vICMS  := 180;
          ICMS.vBC    := 1000;
        end;
        IPI.CST := ipi01;
      end;
    end;

    Total.ICMSTot.vBC   := 1000;
    Total.ICMSTot.vICMS := 180;
    Total.ICMSTot.vNF   := 1000;
    Total.ICMSTot.vProd := 1000;
  end;}

  ACBrNFe1.Enviar(0);
  ShowMessage(ACBrNFe1.WebServices.Retorno.NFeRetorno.ProtNFe.Items[0].nProt);
  ShowMessage(ACBrNFe1.WebServices.Retorno.NFeRetorno.nRec);

  MemoResp.Lines.Text := UTF8Encode(ACBrNFe1.WebServices.Retorno.RetWS);
  LoadXML(MemoResp, WBResposta);

   ACBrNFe1.NotasFiscais.Clear;
end;

procedure TForm1.btnInutilizarClick(Sender: TObject);
var
 Modelo, Serie, Ano, NumeroInicial, NumeroFinal, Justificativa : AnsiString;
begin
 if not(InputQuery('WebServices Inutilização ', 'Ano',    Ano)) then
    exit;
 if not(InputQuery('WebServices Inutilização ', 'Modelo', Modelo)) then
    exit;
 if not(InputQuery('WebServices Inutilização ', 'Serie',  Serie)) then
    exit;
 if not(InputQuery('WebServices Inutilização ', 'Número Inicial', NumeroInicial)) then
    exit;
 if not(InputQuery('WebServices Inutilização ', 'Número Inicial', NumeroFinal)) then
    exit;
 if not(InputQuery('WebServices Inutilização ', 'Justificativa', Justificativa)) then
    exit;
  ACBrNFe1.WebServices.Inutiliza(edtEmitCNPJ.Text, Justificativa, StrToInt(Ano), StrToInt(Modelo), StrToInt(Serie), StrToInt(NumeroInicial), StrToInt(NumeroFinal));
  MemoResp.Lines.Text :=  UTF8Encode(ACBrNFe1.WebServices.Inutilizacao.RetWS);
  LoadXML(MemoResp, WBResposta);
end;

procedure TForm1.ACBrNFe1StatusChange(Sender: TObject);
begin
  case ACBrNFe1.Status of
    stIdle :
    begin
      if ( frmStatus <> nil ) then
        frmStatus.Hide;
    end;
    stNFeStatusServico :
    begin
      if ( frmStatus = nil ) then
        frmStatus := TfrmStatus.Create(Application);
      frmStatus.lblStatus.Caption := 'Verificando Status do servico...';
      frmStatus.Show;
      frmStatus.BringToFront;
    end;
    stNFeRecepcao :
    begin
      if ( frmStatus = nil ) then
        frmStatus := TfrmStatus.Create(Application);
      frmStatus.lblStatus.Caption := 'Enviando dados da NFe...';
      frmStatus.Show;
      frmStatus.BringToFront;
    end;
    stNfeRetRecepcao :
    begin
      if ( frmStatus = nil ) then
        frmStatus := TfrmStatus.Create(Application);
      frmStatus.lblStatus.Caption := 'Recebendo dados da NFe...';
      frmStatus.Show;
      frmStatus.BringToFront;
    end;
    stNfeConsulta :
    begin
      if ( frmStatus = nil ) then
        frmStatus := TfrmStatus.Create(Application);
      frmStatus.lblStatus.Caption := 'Consultando NFe...';
      frmStatus.Show;
      frmStatus.BringToFront;
    end;
    stNfeCancelamento :
    begin
      if ( frmStatus = nil ) then
        frmStatus := TfrmStatus.Create(Application);
      frmStatus.lblStatus.Caption := 'Enviando cancelamento de NFe...';
      frmStatus.Show;
      frmStatus.BringToFront;
    end;
    stNfeInutilizacao :
    begin
      if ( frmStatus = nil ) then
        frmStatus := TfrmStatus.Create(Application);
      frmStatus.lblStatus.Caption := 'Enviando pedido de Inutilização...';
      frmStatus.Show;
      frmStatus.BringToFront;
    end;
    stNFeRecibo :
    begin
      if ( frmStatus = nil ) then
        frmStatus := TfrmStatus.Create(Application);
      frmStatus.lblStatus.Caption := 'Consultando Recibo de Lote...';
      frmStatus.Show;
      frmStatus.BringToFront;
    end;
    stNFeCadastro :
    begin
      if ( frmStatus = nil ) then
        frmStatus := TfrmStatus.Create(Application);
      frmStatus.lblStatus.Caption := 'Consultando Cadastro...';
      frmStatus.Show;
      frmStatus.BringToFront;
    end;
    stNFeEnvDPEC :
    begin
      if ( frmStatus = nil ) then
        frmStatus := TfrmStatus.Create(Application);
      frmStatus.lblStatus.Caption := 'Enviando DPEC...';
      frmStatus.Show;
      frmStatus.BringToFront;
    end;
    stNFeConsultaDPEC :
    begin
      if ( frmStatus = nil ) then
        frmStatus := TfrmStatus.Create(Application);
      frmStatus.lblStatus.Caption := 'Consultando DPEC...';
      frmStatus.Show;
      frmStatus.BringToFront;
    end;
    stNFeEmail :
    begin
      if ( frmStatus = nil ) then
        frmStatus := TfrmStatus.Create(Application);
      frmStatus.lblStatus.Caption := 'Enviando Email...';
      frmStatus.Show;
      frmStatus.BringToFront;
    end;
  end;
  Application.ProcessMessages;
end;

procedure TForm1.sbtnGetCertClick(Sender: TObject);
begin
   {$IFNDEF ACBrNFeOpenSSL}
   edtNumSerie.Text := ACBrNFe1.Configuracoes.Certificados.SelecionarCertificado;
   {$ENDIF}
end;

procedure TForm1.btnGerarNFEClick(Sender: TObject);
var
 vAux : AnsiString;
begin
if not(InputQuery('WebServices Enviar', 'Numero da Nota', vAux)) then
    exit;

  ACBrNFe1.NotasFiscais.Clear;

  with ACBrNFe1.NotasFiscais.Add.NFe do
  begin
    infNFe.ID := vAux;

    Ide.natOp     := 'VENDA PRODUCAO DO ESTAB.';
    Ide.nNF       := StrToInt(vAux);
    Ide.cNF       := StrToInt(vAux);
    Ide.modelo    := 55;
    Ide.serie     := 1;
    Ide.dEmi      := Date;
    Ide.dSaiEnt   := Date;
    Ide.tpNF      := tnSaida;
    Ide.indPag    := ipVista;
    Ide.verProc   := '1.0.0.0';
    Ide.cUF       := 35;
    Ide.cMunFG    := 3554003;

    Emit.CNPJCPF           := edtEmitCNPJ.Text;
    Emit.IE                := edtEmitIE.Text;
    Emit.xNome             := edtEmitRazao.Text;
    Emit.xFant             := edtEmitFantasia.Text;
    Emit.EnderEmit.fone    := edtEmitFone.Text;
    Emit.EnderEmit.CEP     := StrToInt(edtEmitCEP.Text);
    Emit.EnderEmit.xLgr    := edtEmitLogradouro.Text;
    Emit.EnderEmit.nro     := edtEmitNumero.Text;
    Emit.EnderEmit.xCpl    := edtEmitComp.Text;
    Emit.EnderEmit.xBairro := edtEmitBairro.Text;
    Emit.EnderEmit.cMun    := StrToInt(edtEmitCodCidade.Text);
    Emit.EnderEmit.xMun    := edtEmitCidade.Text;
    Emit.EnderEmit.UF      := edtEmitUF.Text;
    Emit.enderEmit.cPais   := 1058;
    Emit.enderEmit.xPais   := 'BRASIL';

    Dest.CNPJCPF           := '05481336000137';
    Dest.EnderDest.CEP     := 18270410;
    Dest.EnderDest.xLgr    := 'Praça Anita Costa';
    Dest.EnderDest.nro     := '0034';
    Dest.EnderDest.xCpl    := '';
    Dest.EnderDest.xBairro := 'Centro';
    Dest.EnderDest.cMun    := 3554003;
    Dest.EnderDest.xMun    := 'Tatuí';
    Dest.EnderDest.UF      := 'SP';
    Dest.EnderDest.Fone    := '1532599600';
    Dest.IE                := '687138770110';
    Dest.xNome             := 'D.J. COM. E LOCAÇÃO DE SOFTWARES LTDA - ME';
    Dest.EnderDest.cPais   := 1058;
    Dest.EnderDest.xPais   := 'BRASIL';

    with Det.Add do
    begin
      Prod.nItem    := 1;
      Prod.cProd    := '67';
      Prod.xProd    := 'PRODUTO VENDIDO POR QUILO';
      Prod.CFOP     := '5101';
      Prod.uCom     := 'KG';
      Prod.qCom     := 10;
      Prod.vUnCom   := 10;
      Prod.vProd    := 100;
      Prod.qTrib    := 10;
      Prod.vUnTrib  := 10;
      Prod.uTrib    := 'KG';
      infAdProd := 'Teste informacao adicional';

      with Imposto do
      begin
        with ICMS do
        begin
          CST := cst00;
          ICMS.modBC  := dbiPrecoTabelado;
          ICMS.pICMS  := 18;
          ICMS.vICMS  := 18;
          ICMS.vBC    := 100;
        end;
        IPI.CST := ipi01;
      end;
    end;

    with Det.Add do
    begin
      Prod.nItem    := 2;
      Prod.CFOP     := '5101';
      Prod.cProd    := '68';
      Prod.xProd    := 'CARRO NOVO';
      Prod.qCom     := 1;
      Prod.uCom     := 'PC';
      Prod.vProd    := 25000;
      Prod.vUnCom   := 25000;
      Prod.qTrib    := 1;
      Prod.uTrib    := 'PC';
      Prod.vUnTrib  := 1;

      with Prod.veicProd do
       begin
          tpOP   := toVendaConcessionaria;
          chassi := '';
          cCor   := '1234';
          xCor   := 'Descricao da Cor';
          pot    := '1000';
          CM3    := '1000';
          pesoL  := '1000';
          pesoB  := '1000';
          nSerie := '123456789';
          tpComb := 'Gasolina';
          nMotor := '1234567890A';
          CMKG   := '123456789';
          dist   := '1234';
          RENAVAM := '123456789';
          anoMod := 2009;
          anoFab := 2009;
          tpPint := 'A';
          tpVeic := 1;
          espVeic:= 1;
          VIN    := 'A';
          condVeic := cvAcabado;
          cMod   := '1';
       end;

      with Imposto do
      begin
        with ICMS do
        begin
          CST := cst00;
          ICMS.modBC  := dbiPrecoTabelado;
          ICMS.pICMS  := 12;
          ICMS.vICMS  := 3000;
          ICMS.vBC    := 25000;
        end;
        IPI.CST := ipi01;
      end;

    with Det.Add do
    begin
      Prod.nItem    := 3;
      Prod.cProd    := '69';
      Prod.xProd    := 'ARMAMENTO';
      Prod.CFOP     := '5101';
      Prod.uCom     := 'PC';
      Prod.qCom     := 1;
      Prod.vUnCom   := 500;
      Prod.vProd    := 500;
      Prod.qTrib    := 1;
      Prod.vUnTrib  := 500;
      Prod.uTrib    := 'PC';

      with Prod.arma.Add do
       begin
          tpArma := taUsoPermitido;
          nSerie := 1234;
          nCano  := 1234;
          descr  := 'Calibre Marca Capacidade Tipo de Funcionamento';
       end;

      with Imposto do
      begin
        with ICMS do
        begin
          CST := cst00;
          ICMS.modBC  := dbiPrecoTabelado;
          ICMS.pICMS  := 18;
          ICMS.vICMS  := 90;
          ICMS.vBC    := 500;
        end;
        IPI.CST := ipi01;
      end;
    end;
    end;

    Total.ICMSTot.vBC   := 25680;
    Total.ICMSTot.vICMS := 3108;
    Total.ICMSTot.vNF   := 25680;
    Total.ICMSTot.vProd := 25680;
    Total.retTrib.vRetPrev := 100;

    InfAdic.infCpl := 'Seu Texto Aqui. Use ; (ponto e vírgula) para quebra de Linha.'
  end;

  ACBrNFe1.NotasFiscais.Items[0].SaveToFile;
  ShowMessage('Arquivo gerado em: '+ACBrNFe1.NotasFiscais.Items[0].NomeArq);
  MemoResp.Lines.LoadFromFile(PathWithDelim(ACBrNFe1.Configuracoes.Geral.PathSalvar)+copy(ACBrNFe1.NotasFiscais.Items[0].NFe.infNFe.ID, (length(ACBrNFe1.NotasFiscais.Items[0].NFe.infNFe.ID)-44)+1, 44)+'-NFe.xml');
  LoadXML(MemoResp, WBResposta);
end;

procedure TForm1.btnConsCadClick(Sender: TObject);
var
 UF, Documento : AnsiString;
begin
 if not(InputQuery('WebServices Consulta Cadastro ', 'UF do Documento a ser Consultado:',    UF)) then
    exit;
 if not(InputQuery('WebServices Consulta Cadastro ', 'Documento(CPF/CNPJ)',    Documento)) then
    exit;
  Documento :=  Trim(NotaUtil.LimpaNumero(Documento));

  ACBrNFe1.WebServices.ConsultaCadastro.UF  := UF;
  if Length(Documento) > 11 then
     ACBrNFe1.WebServices.ConsultaCadastro.CNPJ := Documento
  else
     ACBrNFe1.WebServices.ConsultaCadastro.CPF := Documento;
  ACBrNFe1.WebServices.ConsultaCadastro.Executar;

  MemoResp.Lines.Text :=  UTF8Encode(ACBrNFe1.WebServices.ConsultaCadastro.RetWS);
  LoadXML(MemoResp, WBResposta);

  ShowMessage(ACBrNFe1.WebServices.ConsultaCadastro.xMotivo);
  ShowMessage(ACBrNFe1.WebServices.ConsultaCadastro.RetConsCad.InfCad.Items[0].xNome);
end;

procedure TForm1.btnGerarPDFClick(Sender: TObject);
begin
  OpenDialog1.Title := 'Selecione a NFE';
  OpenDialog1.DefaultExt := '*-nfe.XML';
  OpenDialog1.Filter := 'Arquivos NFE (*-nfe.XML)|*-nfe.XML|Arquivos XML (*.XML)|*.XML|Todos os Arquivos (*.*)|*.*';
  OpenDialog1.InitialDir := ACBrNFe1.Configuracoes.Geral.PathSalvar;
  if OpenDialog1.Execute then
  begin
    ACBrNFe1.NotasFiscais.Clear;
    ACBrNFe1.NotasFiscais.LoadFromFile(OpenDialog1.FileName);
    ACBrNFe1.NotasFiscais.ImprimirPDF;
  end;
end;

procedure TForm1.btnEnviarEmailClick(Sender: TObject);
var
 Para : AnsiString;
 CC: Tstrings;
begin
  if not(InputQuery('Enviar Email', 'Email de destino', Para)) then
    exit;

  OpenDialog1.Title := 'Selecione a NFE';
  OpenDialog1.DefaultExt := '*-nfe.XML';
  OpenDialog1.Filter := 'Arquivos NFE (*-nfe.XML)|*-nfe.XML|Arquivos XML (*.XML)|*.XML|Todos os Arquivos (*.*)|*.*';
  OpenDialog1.InitialDir := ACBrNFe1.Configuracoes.Geral.PathSalvar;
  if OpenDialog1.Execute then
  begin
    ACBrNFe1.NotasFiscais.Clear;
    ACBrNFe1.NotasFiscais.LoadFromFile(OpenDialog1.FileName);
    CC:=TstringList.Create;
    CC.Add('email_1@provedor.com'); //especifique um email válido
    CC.Add('email_2@provedor.com.br'); //especifique um email válido
    ACBrNFe1.NotasFiscais.Items[0].EnviarEmail(edtSmtpHost.Text
                                             , edtSmtpPort.Text
                                             , edtSmtpUser.Text
                                             , edtSmtpPass.Text
                                             , edtSmtpUser.Text
                                             , Para
                                             , edtEmailAssunto.Text
                                             , mmEmailMsg.Lines
                                             , cbEmailSSL.Checked
                                             , True //Enviar PDF junto
                                             //, CC //com copia
                                               );
    CC.Free;
  end;
end;

procedure TForm1.btnConsultarReciboClick(Sender: TObject);
var
  aux : AnsiString;
begin
  if not(InputQuery('Consultar Recibo Lote', 'Número do Recibo', aux)) then
    exit;
  ACBrNFe1.WebServices.Recibo.Recibo := aux;;
  ACBrNFe1.WebServices.Recibo.Executar;

  MemoResp.Lines.Text :=  UTF8Encode(ACBrNFe1.WebServices.Recibo.RetWS);
  LoadXML(MemoResp, WBResposta);
end;

procedure TForm1.btnEnvDPECClick(Sender: TObject);
var
 vAux : AnsiString;
begin
if not(InputQuery('WebServices DPEC', 'Numero da Nota', vAux)) then
    exit;

  ACBrNFe1.NotasFiscais.Clear;

  with ACBrNFe1.NotasFiscais.Add.NFe do
  begin
    infNFe.ID := vAux;

    Ide.natOp     := 'VENDA PRODUCAO DO ESTAB.';
    Ide.nNF       := StrToInt(vAux);
    Ide.cNF       := StrToInt(vAux);
    Ide.modelo    := 55;
    Ide.serie     := 1;
    Ide.dEmi      := Date;
    Ide.dSaiEnt   := Date;
    Ide.tpAmb     := taHomologacao;
    Ide.tpNF      := tnSaida;
    Ide.indPag    := ipVista;
    Ide.verProc   := '1.0.0.0';
    Ide.cUF       := 35;
    Ide.cMunFG    := 3554003;
    Ide.tpEmis    := teDPEC;

    Emit.CNPJCPF           := edtEmitCNPJ.Text;
    Emit.IE                := edtEmitIE.Text;
    Emit.xNome             := edtEmitRazao.Text;
    Emit.xFant             := edtEmitFantasia.Text;
    Emit.EnderEmit.fone    := edtEmitFone.Text;
    Emit.EnderEmit.CEP     := StrToInt(edtEmitCEP.Text);
    Emit.EnderEmit.xLgr    := edtEmitLogradouro.Text;
    Emit.EnderEmit.nro     := edtEmitNumero.Text;
    Emit.EnderEmit.xCpl    := edtEmitComp.Text;
    Emit.EnderEmit.xBairro := edtEmitBairro.Text;
    Emit.EnderEmit.cMun    := StrToInt(edtEmitCodCidade.Text);
    Emit.EnderEmit.xMun    := edtEmitCidade.Text;
    Emit.EnderEmit.UF      := edtEmitUF.Text;
    Emit.enderEmit.cPais   := 1058;
    Emit.enderEmit.xPais   := 'BRASIL';

    Dest.CNPJCPF           := '05481336000137';
    Dest.EnderDest.CEP     := 18270410;
    Dest.EnderDest.xLgr    := 'Praça Anita Costa';
    Dest.EnderDest.nro     := '0034';
    Dest.EnderDest.xCpl    := '';
    Dest.EnderDest.xBairro := 'Centro';
    Dest.EnderDest.cMun    := 3554003;
    Dest.EnderDest.xMun    := 'Tatuí';
    Dest.EnderDest.UF      := 'SP';
    Dest.EnderDest.Fone    := '1532599600';
    Dest.IE                := '687138770110';
    Dest.xNome             := 'D.J. COM. E LOCAÇÃO DE SOFTWARES LTDA - ME';
    Dest.EnderDest.cPais   := 1058;
    Dest.EnderDest.xPais   := 'BRASIL';

    with Det.Add do
    begin
      infAdProd     := 'Teste de informacao adicional;Teste de Segunda Linha';
      Prod.nItem    := 1;
      Prod.CFOP     := '5101';
      Prod.cProd    := '67';
      Prod.xProd    := 'ALHO 400 G';
      Prod.qCom     := 100;
      Prod.uCom     := 'KG';
      Prod.vProd    := 100;
      Prod.vUnCom   := 10;
      Prod.qTrib    := 100;
      Prod.uTrib    := 'KG';
      Prod.vUnTrib  := 10;
      with Imposto do
      begin
        with ICMS do
        begin
          CST := cst00;
          ICMS.modBC  := dbiPrecoTabelado;
          ICMS.pICMS  := 18;
          ICMS.vICMS  := 180;
          ICMS.vBC    := 1000;
        end;
        IPI.CST := ipi01;
      end;
    end;

    with Det.Add do
    begin
      Prod.nItem    := 2;
      Prod.CFOP     := '5101';
      Prod.cProd    := '68';
      Prod.xProd    := 'CEBOLA 400 G';
      Prod.qCom     := 100;
      Prod.uCom     := 'KG';
      Prod.vProd    := 100;
      Prod.vUnCom   := 10;
      Prod.qTrib    := 100;
      Prod.uTrib    := 'KG';
      Prod.vUnTrib  := 10;
      with Imposto do
      begin
        with ICMS do
        begin
          CST := cst00;
          ICMS.modBC  := dbiPrecoTabelado;
          ICMS.orig   := oeNacional;
          ICMS.pICMS  := 18;
          ICMS.vICMS  := 180;
          ICMS.vBC    := 1000;
        end;
        IPI.CST := ipi01;
      end;
    end;

    Total.ICMSTot.vBC   := 1000;
    Total.ICMSTot.vICMS := 180;
    Total.ICMSTot.vNF   := 1000;
    Total.ICMSTot.vProd := 1000;
  end;

{  with ACBrNFe1.NotasFiscais.Add.NFe do
  begin
    infNFe.ID := vAux;

    Ide.natOp     := 'VENDA PRODUCAO DO ESTAB.';
    Ide.nNF       := StrToInt(vAux)+1;
    Ide.cNF       := StrToInt(vAux)+1;
    Ide.modelo    := 55;
    Ide.serie     := 1;
    Ide.dEmi      := Date;
    Ide.dSaiEnt   := Date;
    Ide.tpAmb     := taHomologacao;
    Ide.tpNF      := tnSaida;
    Ide.indPag    := ipVista;
    Ide.verProc   := '1.0.0.0';
    Ide.cUF       := 35;
    Ide.cMunFG    := 3554003;

    Emit.CNPJCPF           := edtEmitCNPJ.Text;
    Emit.IE                := edtEmitIE.Text;
    Emit.xNome             := edtEmitRazao.Text;
    Emit.xFant             := edtEmitFantasia.Text;
    Emit.EnderEmit.fone    := edtEmitFone.Text;
    Emit.EnderEmit.CEP     := StrToInt(edtEmitCEP.Text);
    Emit.EnderEmit.xLgr    := edtEmitLogradouro.Text;
    Emit.EnderEmit.nro     := edtEmitNumero.Text;
    Emit.EnderEmit.xCpl    := edtEmitComp.Text;
    Emit.EnderEmit.xBairro := edtEmitBairro.Text;
    Emit.EnderEmit.cMun    := StrToInt(edtEmitCodCidade.Text);
    Emit.EnderEmit.xMun    := edtEmitCidade.Text;
    Emit.EnderEmit.UF      := edtEmitUF.Text;
    Emit.enderEmit.cPais   := 1058;
    Emit.enderEmit.xPais   := 'BRASIL';

    Dest.CNPJCPF           := '05481336000137';
    Dest.EnderDest.CEP     := 18270410;
    Dest.EnderDest.xLgr    := 'Praça Anita Costa';
    Dest.EnderDest.nro     := '0034';
    Dest.EnderDest.xCpl    := '';
    Dest.EnderDest.xBairro := 'Centro';
    Dest.EnderDest.cMun    := 3554003;
    Dest.EnderDest.xMun    := 'Tatuí';
    Dest.EnderDest.UF      := 'SP';
    Dest.EnderDest.Fone    := '1532599600';
    Dest.IE                := '687138770110';
    Dest.xNome             := 'D.J. COM. E LOCAÇÃO DE SOFTWARES LTDA - ME';
    Dest.EnderDest.cPais   := 1058;
    Dest.EnderDest.xPais   := 'BRASIL';

    with Det.Add do
    begin
      infAdProd     := 'Teste de informacao adicional;Teste de Segunda Linha';
      Prod.nItem    := 1;
      Prod.CFOP     := '5101';
      Prod.cProd    := '67';
      Prod.xProd    := 'ALHO 400 G';
      Prod.qCom     := 100;
      Prod.uCom     := 'KG';
      Prod.vProd    := 100;
      Prod.vUnCom   := 10;
      Prod.qTrib    := 100;
      Prod.uTrib    := 'KG';
      Prod.vUnTrib  := 10;
      with Imposto do
      begin
        with ICMS do
        begin
          CST := cst00;
          ICMS.modBC  := dbiPrecoTabelado;
          ICMS.pICMS  := 18;
          ICMS.vICMS  := 180;
          ICMS.vBC    := 1000;
        end;
        IPI.CST := ipi01;
      end;
    end;

    with Det.Add do
    begin
      Prod.nItem    := 2;
      Prod.CFOP     := '5101';
      Prod.cProd    := '68';
      Prod.xProd    := 'CEBOLA 400 G';
      Prod.qCom     := 100;
      Prod.uCom     := 'KG';
      Prod.vProd    := 100;
      Prod.vUnCom   := 10;
      Prod.qTrib    := 100;
      Prod.uTrib    := 'KG';
      Prod.vUnTrib  := 10;
      with Imposto do
      begin
        with ICMS do
        begin
          CST := cst00;
          ICMS.modBC  := dbiPrecoTabelado;
          ICMS.pICMS  := 18;
          ICMS.vICMS  := 180;
          ICMS.vBC    := 1000;
        end;
        IPI.CST := ipi01;
      end;
    end;

    Total.ICMSTot.vBC   := 1000;
    Total.ICMSTot.vICMS := 180;
    Total.ICMSTot.vNF   := 1000;
    Total.ICMSTot.vProd := 1000;
  end;}

  ACBrNFe1.WebServices.EnviarDPEC.Executar;

  //protocolo de envio ao DPEC e impressão do DANFE
  ACBrNFe1.DANFE.ProtocoloNFe:=ACBrNFe1.WebServices.EnviarDPEC.nRegDPEC+' '+
                               DateTimeToStr(ACBrNFe1.WebServices.EnviarDPEC.DhRegDPEC);
  ACBrNFe1.NotasFiscais.Imprimir;

  ShowMessage(DateTimeToStr(ACBrNFe1.WebServices.EnviarDPEC.DhRegDPEC));
  ShowMessage(ACBrNFe1.WebServices.EnviarDPEC.nRegDPEC);

  MemoResp.Lines.Text := UTF8Encode(ACBrNFe1.WebServices.EnviarDPEC.RetWS);
  LoadXML(MemoResp, WBResposta);

  ACBrNFe1.NotasFiscais.Clear;
end;

procedure TForm1.btnConsultarDPECClick(Sender: TObject);
var
 vAux : AnsiString;
begin
  if not(InputQuery('WebServices DPEC', 'Informe o Numero do Registro do DPEC ou a Chave da NFe', vAux)) then
    exit;

  if Length(Trim(vAux)) < 44 then
     ACBrNFe1.WebServices.ConsultaDPEC.nRegDPEC := vAux
  else
     ACBrNFe1.WebServices.ConsultaDPEC.NFeChave := vAux;
  ACBrNFe1.WebServices.ConsultaDPEC.Executar;

  MemoResp.Lines.Text :=  UTF8Encode(ACBrNFe1.WebServices.ConsultaDPEC.RetWS);
  LoadXML(MemoResp, WBResposta);
    
end;

procedure TForm1.ACBrNFe1GerarLog(const Mensagem: String);
begin
 memoLog.Lines.Add(Mensagem);
end;

procedure TForm1.btnImportarXMLClick(Sender: TObject);
var
  i, j, k, n  : integer;
  Nota, Node, NodePai, NodeItem: TTreeNode;
begin
  OpenDialog1.FileName  :=  '';
  OpenDialog1.Title := 'Selecione a NFE';
  OpenDialog1.DefaultExt := '*-nfe.XML';
  OpenDialog1.Filter := 'Arquivos NFE (*-nfe.XML)|*-nfe.XML|Arquivos XML (*.XML)|*.XML|Todos os Arquivos (*.*)|*.*';
  OpenDialog1.InitialDir := ACBrNFe1.Configuracoes.Geral.PathSalvar;
  if OpenDialog1.Execute then
  begin
    ACBrNFe1.NotasFiscais.Clear;
    ACBrNFe1.NotasFiscais.LoadFromFile(OpenDialog1.FileName);
    trvwNFe.Items.Clear;

    for n:=0 to ACBrNFe1.NotasFiscais.Count-1 do
    begin
    with ACBrNFe1.NotasFiscais.Items[n].NFe do
     begin
       Nota := trvwNFe.Items.Add(nil,infNFe.ID);
       trvwNFe.Items.AddChild(Nota,'ID= ' +infNFe.ID);

       Node := trvwNFe.Items.AddChild(Nota,'Ide');
       trvwNFe.Items.AddChild(Node,'cNF= '     +IntToStr(Ide.cNF));
       trvwNFe.Items.AddChild(Node,'natOp= '   +Ide.natOp );
       trvwNFe.Items.AddChild(Node,'indPag= '  +IndpagToStr(Ide.indPag));
       trvwNFe.Items.AddChild(Node,'modelo= '  +IntToStr(Ide.modelo));
       trvwNFe.Items.AddChild(Node,'serie= '   +IntToStr(Ide.serie));
       trvwNFe.Items.AddChild(Node,'nNF= '     +IntToStr(Ide.nNF));
       trvwNFe.Items.AddChild(Node,'dEmi= '    +DateToStr(Ide.dEmi));
       trvwNFe.Items.AddChild(Node,'dSaiEnt= ' +DateToStr(Ide.dSaiEnt));
       trvwNFe.Items.AddChild(Node,'tpNF= '    +tpNFToStr(Ide.tpNF));
       trvwNFe.Items.AddChild(Node,'finNFe= '  +FinNFeToStr(Ide.finNFe));
       trvwNFe.Items.AddChild(Node,'verProc= ' +Ide.verProc);
       trvwNFe.Items.AddChild(Node,'cUF= '     +IntToStr(Ide.cUF));
       trvwNFe.Items.AddChild(Node,'cMunFG= '  +IntToStr(Ide.cMunFG));
       trvwNFe.Items.AddChild(Node,'tpImp= '   +TpImpToStr(Ide.tpImp));
       trvwNFe.Items.AddChild(Node,'tpEmis= '  +TpEmisToStr(Ide.tpEmis));
       trvwNFe.Items.AddChild(Node,'cDV= '     +IntToStr(Ide.cDV));
       trvwNFe.Items.AddChild(Node,'tpAmb= '   +TpAmbToStr(Ide.tpAmb));
       trvwNFe.Items.AddChild(Node,'finNFe= '  +FinNFeToStr(Ide.finNFe));
       trvwNFe.Items.AddChild(Node,'procEmi= ' +procEmiToStr(Ide.procEmi));
       trvwNFe.Items.AddChild(Node,'verProc= ' +Ide.verProc);

       for i:=0 to Ide.NFref.Count-1 do
        begin
          Node := trvwNFe.Items.AddChild(Node,'NFRef'+IntToStrZero(i+1,3));
          trvwNFe.Items.AddChild(Node,'refNFe= ' +Ide.NFref.Items[i].refNFe);
          trvwNFe.Items.AddChild(Node,'cUF= '    +IntToStr(Ide.NFref.Items[i].RefNF.cUF));
          trvwNFe.Items.AddChild(Node,'AAMM= '   +Ide.NFref.Items[i].RefNF.AAMM);
          trvwNFe.Items.AddChild(Node,'CNPJ= '   +Ide.NFref.Items[i].RefNF.CNPJ);
          trvwNFe.Items.AddChild(Node,'modelo= ' +IntToStr(Ide.NFref.Items[i].RefNF.modelo));
          trvwNFe.Items.AddChild(Node,'serie= '  +IntToStr(Ide.NFref.Items[i].RefNF.serie));
          trvwNFe.Items.AddChild(Node,'nNF= '    +IntToStr(Ide.NFref.Items[i].RefNF.nNF));
        end;

       Node := trvwNFe.Items.AddChild(Nota,'Emit');
       trvwNFe.Items.AddChild(Node,'CNPJCPF= ' +Emit.CNPJCPF);
       trvwNFe.Items.AddChild(Node,'IE='       +Emit.IE);
       trvwNFe.Items.AddChild(Node,'xNome='    +Emit.xNome);
       trvwNFe.Items.AddChild(Node,'xFant='    +Emit.xFant );
       trvwNFe.Items.AddChild(Node,'IEST='     +Emit.IEST);
       trvwNFe.Items.AddChild(Node,'IM='       +Emit.IM);
       trvwNFe.Items.AddChild(Node,'CNAE='     +Emit.CNAE);

       Node := trvwNFe.Items.AddChild(Node,'EnderEmit');
       trvwNFe.Items.AddChild(Node,'Fone='    +Emit.EnderEmit.fone);
       trvwNFe.Items.AddChild(Node,'CEP='     +IntToStr(Emit.EnderEmit.CEP));
       trvwNFe.Items.AddChild(Node,'xLgr='    +Emit.EnderEmit.xLgr);
       trvwNFe.Items.AddChild(Node,'nro='     +Emit.EnderEmit.nro);
       trvwNFe.Items.AddChild(Node,'xCpl='    +Emit.EnderEmit.xCpl);
       trvwNFe.Items.AddChild(Node,'xBairro=' +Emit.EnderEmit.xBairro);
       trvwNFe.Items.AddChild(Node,'cMun='    +IntToStr(Emit.EnderEmit.cMun));
       trvwNFe.Items.AddChild(Node,'xMun='    +Emit.EnderEmit.xMun);
       trvwNFe.Items.AddChild(Node,'UF'       +Emit.EnderEmit.UF);
       trvwNFe.Items.AddChild(Node,'cPais='   +IntToStr(Emit.EnderEmit.cPais));
       trvwNFe.Items.AddChild(Node,'xPais='   +Emit.EnderEmit.xPais);

       if Avulsa.CNPJ  <> '' then
        begin
          Node := trvwNFe.Items.AddChild(Nota,'Avulsa');
          trvwNFe.Items.AddChild(Node,'CNPJ='    +Avulsa.CNPJ);
          trvwNFe.Items.AddChild(Node,'xOrgao='  +Avulsa.xOrgao);
          trvwNFe.Items.AddChild(Node,'matr='    +Avulsa.matr );
          trvwNFe.Items.AddChild(Node,'xAgente=' +Avulsa.xAgente);
          trvwNFe.Items.AddChild(Node,'fone='    +Avulsa.fone);
          trvwNFe.Items.AddChild(Node,'UF='      +Avulsa.UF);
          trvwNFe.Items.AddChild(Node,'nDAR='    +Avulsa.nDAR);
          trvwNFe.Items.AddChild(Node,'dEmi='    +DateToStr(Avulsa.dEmi));
          trvwNFe.Items.AddChild(Node,'vDAR='    +FloatToStr(Avulsa.vDAR));
          trvwNFe.Items.AddChild(Node,'repEmi='  +Avulsa.repEmi);
          trvwNFe.Items.AddChild(Node,'dPag='    +DateToStr(Avulsa.dPag));
        end;
       Node := trvwNFe.Items.AddChild(Nota,'Dest');
       trvwNFe.Items.AddChild(Node,'CNPJCPF= ' +Dest.CNPJCPF);
       trvwNFe.Items.AddChild(Node,'IE='       +Dest.IE);
       trvwNFe.Items.AddChild(Node,'ISUF='     +Dest.ISUF);
       trvwNFe.Items.AddChild(Node,'xNome='    +Dest.xNome);

       Node := trvwNFe.Items.AddChild(Node,'EnderDest');
       trvwNFe.Items.AddChild(Node,'Fone='    +Dest.EnderDest.Fone);
       trvwNFe.Items.AddChild(Node,'CEP='     +IntToStr(Dest.EnderDest.CEP));
       trvwNFe.Items.AddChild(Node,'xLgr='    +Dest.EnderDest.xLgr);
       trvwNFe.Items.AddChild(Node,'nro='     +Dest.EnderDest.nro);
       trvwNFe.Items.AddChild(Node,'xCpl='    +Dest.EnderDest.xCpl);
       trvwNFe.Items.AddChild(Node,'xBairro=' +Dest.EnderDest.xBairro);
       trvwNFe.Items.AddChild(Node,'cMun='    +IntToStr(Dest.EnderDest.cMun));
       trvwNFe.Items.AddChild(Node,'xMun='    +Dest.EnderDest.xMun);
       trvwNFe.Items.AddChild(Node,'UF='      +Dest.EnderDest.UF );
       trvwNFe.Items.AddChild(Node,'cPais='   +IntToStr(Dest.EnderDest.cPais));
       trvwNFe.Items.AddChild(Node,'xPais='   +Dest.EnderDest.xPais);

       if Retirada.CNPJ <> '' then
        begin
          Node := trvwNFe.Items.AddChild(Nota,'Retirada');
          trvwNFe.Items.AddChild(Node,'CNPJ='    +Retirada.CNPJ);
          trvwNFe.Items.AddChild(Node,'xLgr='    +Retirada.xLgr);
          trvwNFe.Items.AddChild(Node,'nro='     +Retirada.nro);
          trvwNFe.Items.AddChild(Node,'xCpl='    +Retirada.xCpl);
          trvwNFe.Items.AddChild(Node,'xBairro=' +Retirada.xBairro);
          trvwNFe.Items.AddChild(Node,'cMun='    +IntToStr(Retirada.cMun));
          trvwNFe.Items.AddChild(Node,'xMun='    +Retirada.xMun);
          trvwNFe.Items.AddChild(Node,'UF='      +Retirada.UF);
        end;

       if Entrega.CNPJ <> '' then
        begin
          Node := trvwNFe.Items.AddChild(Nota,'Entrega');
          trvwNFe.Items.AddChild(Node,'CNPJ='    +Entrega.CNPJ);
          trvwNFe.Items.AddChild(Node,'xLgr='    +Entrega.xLgr);
          trvwNFe.Items.AddChild(Node,'nro='     +Entrega.nro);
          trvwNFe.Items.AddChild(Node,'xCpl='    +Entrega.xCpl);
          trvwNFe.Items.AddChild(Node,'xBairro=' +Entrega.xBairro);
          trvwNFe.Items.AddChild(Node,'cMun='    +IntToStr(Entrega.cMun));
          trvwNFe.Items.AddChild(Node,'xMun='    +Entrega.xMun);
          trvwNFe.Items.AddChild(Node,'UF='      +Entrega.UF);
        end;

       for I := 0 to Det.Count-1 do
        begin
          with Det.Items[I] do
           begin
               NodeItem := trvwNFe.Items.AddChild(Nota,'Produto'+IntToStrZero(I+1,3));
               trvwNFe.Items.AddChild(NodeItem,'nItem='  +IntToStr(Prod.nItem) );
               trvwNFe.Items.AddChild(NodeItem,'cProd='  +Prod.cProd );
               trvwNFe.Items.AddChild(NodeItem,'cEAN='   +Prod.cEAN);
               trvwNFe.Items.AddChild(NodeItem,'xProd='  +Prod.xProd);
               trvwNFe.Items.AddChild(NodeItem,'NCM='    +Prod.NCM);
               trvwNFe.Items.AddChild(NodeItem,'EXTIPI=' +Prod.EXTIPI);
               trvwNFe.Items.AddChild(NodeItem,'genero=' +IntToStr(Prod.genero));
               trvwNFe.Items.AddChild(NodeItem,'CFOP='   +Prod.CFOP);
               trvwNFe.Items.AddChild(NodeItem,'uCom='   +Prod.uCom);
               trvwNFe.Items.AddChild(NodeItem,'qCom='   +FloatToStr(Prod.qCom)) ;
               trvwNFe.Items.AddChild(NodeItem,'vUnCom=' +FloatToStr(Prod.vUnCom)) ;
               trvwNFe.Items.AddChild(NodeItem,'vProd='  +FloatToStr(Prod.vProd)) ;

               trvwNFe.Items.AddChild(NodeItem,'cEANTrib=' +Prod.cEANTrib);
               trvwNFe.Items.AddChild(NodeItem,'uTrib='    +Prod.uTrib);
               trvwNFe.Items.AddChild(NodeItem,'qTrib='    +FloatToStr(Prod.qTrib));
               trvwNFe.Items.AddChild(NodeItem,'vUnTrib='  +FloatToStr(Prod.vUnTrib)) ;

               trvwNFe.Items.AddChild(NodeItem,'vFrete=' +FloatToStr(Prod.vFrete)) ;
               trvwNFe.Items.AddChild(NodeItem,'vSeg='   +FloatToStr(Prod.vSeg)) ;
               trvwNFe.Items.AddChild(NodeItem,'vDesc='  +FloatToStr(Prod.vDesc)) ;

               trvwNFe.Items.AddChild(NodeItem,'infAdProd=' +infAdProd);

               for J:=0 to Prod.DI.Count-1 do
                begin
                  if Prod.DI.Items[j].nDi <> '' then
                   begin
                     with Prod.DI.Items[j] do
                      begin
                        NodePai := trvwNFe.Items.AddChild(NodeItem,'DI'+IntToStrZero(J+1,3));
                        trvwNFe.Items.AddChild(NodePai,'nDi='         +nDi);
                        trvwNFe.Items.AddChild(NodePai,'dDi='         +DateToStr(dDi));
                        trvwNFe.Items.AddChild(NodePai,'xLocDesemb='  +xLocDesemb);
                        trvwNFe.Items.AddChild(NodePai,'UFDesemb='    +UFDesemb);
                        trvwNFe.Items.AddChild(NodePai,'dDesemb='     +DateToStr(dDesemb));
                        trvwNFe.Items.AddChild(NodePai,'cExportador=' +cExportador);;

                        for K:=0 to adi.Count-1 do
                         begin
                           with adi.Items[K] do
                            begin
                              Node := trvwNFe.Items.AddChild(NodePai,'LADI'+IntToStrZero(K+1,3));
                              trvwNFe.Items.AddChild(Node,'nAdicao='     +IntToStr(nAdicao)) ;
                              trvwNFe.Items.AddChild(Node,'nSeqAdi='     +IntToStr(nSeqAdi)) ;
                              trvwNFe.Items.AddChild(Node,'cFabricante=' +cFabricante);
                              trvwNFe.Items.AddChild(Node,'vDescDI='     +FloatToStr(vDescDI));
                            end;
                         end;
                      end;
                   end
                  else
                    Break;
                end;

              if Prod.veicProd.chassi <> '' then
               begin
                 Node := trvwNFe.Items.AddChild(NodeItem,'Veiculo');
                 with Prod.veicProd do
                  begin
                    trvwNFe.Items.AddChild(Node,'tpOP='     +tpOPToStr(tpOP));
                    trvwNFe.Items.AddChild(Node,'chassi='   +chassi) ;
                    trvwNFe.Items.AddChild(Node,'cCor='     +cCor);
                    trvwNFe.Items.AddChild(Node,'xCor='     +xCor);
                    trvwNFe.Items.AddChild(Node,'pot='      +pot);
                    trvwNFe.Items.AddChild(Node,'CM3='      +CM3);
                    trvwNFe.Items.AddChild(Node,'pesoL='    +pesoL);
                    trvwNFe.Items.AddChild(Node,'pesoB='    +pesoB);
                    trvwNFe.Items.AddChild(Node,'nSerie='   +nSerie);
                    trvwNFe.Items.AddChild(Node,'tpComb='   +tpComb);
                    trvwNFe.Items.AddChild(Node,'nMotor='   +nMotor);
                    trvwNFe.Items.AddChild(Node,'CMKG='     +CMKG);
                    trvwNFe.Items.AddChild(Node,'dist='     +dist);
                    trvwNFe.Items.AddChild(Node,'RENAVAM='  +RENAVAM);
                    trvwNFe.Items.AddChild(Node,'anoMod='   +IntToStr(anoMod));
                    trvwNFe.Items.AddChild(Node,'anoFab='   +IntToStr(anoFab));
                    trvwNFe.Items.AddChild(Node,'tpPint='   +tpPint);
                    trvwNFe.Items.AddChild(Node,'tpVeic='   +IntToStr(tpVeic));
                    trvwNFe.Items.AddChild(Node,'espVeic='  +IntToStr(espVeic));
                    trvwNFe.Items.AddChild(Node,'VIN='      +VIN);
                    trvwNFe.Items.AddChild(Node,'condVeic=' +condVeicToStr(condVeic));
                    trvwNFe.Items.AddChild(Node,'cMod='     +cMod);
                  end;
               end;

               for J:=0 to Prod.med.Count-1 do
                begin
                  Node := trvwNFe.Items.AddChild(NodeItem,'Medicamento'+IntToStrZero(J+1,3) );
                  with Prod.med.Items[J] do
                   begin
                     trvwNFe.Items.AddChild(Node,'nLote=' +nLote) ;
                     trvwNFe.Items.AddChild(Node,'qLote=' +FloatToStr(qLote)) ;
                     trvwNFe.Items.AddChild(Node,'dFab='  +DateToStr(dFab)) ;
                     trvwNFe.Items.AddChild(Node,'dVal='  +DateToStr(dVal)) ;
                     trvwNFe.Items.AddChild(Node,'vPMC='  +FloatToStr(vPMC)) ;
                    end;
                end;

               for J:=0 to Prod.arma.Count-1 do
                begin
                  Node := trvwNFe.Items.AddChild(NodeItem,'Arma'+IntToStrZero(J+1,3));
                  with Prod.arma.Items[J] do
                   begin
                     trvwNFe.Items.AddChild(Node,'nSerie=' +IntToStr(nSerie)) ;
                     trvwNFe.Items.AddChild(Node,'tpArma=' +tpArmaToStr(tpArma)) ;
                     trvwNFe.Items.AddChild(Node,'nCano='  +IntToStr(nCano)) ;
                     trvwNFe.Items.AddChild(Node,'descr='  +descr) ;
                    end;
                end;

               if (Prod.comb.cProdANP > 0) then
                begin
                 NodePai := trvwNFe.Items.AddChild(NodeItem,'Combustivel');
                 with Prod.comb do
                  begin
                    trvwNFe.Items.AddChild(NodePai,'cProdANP=' +IntToStr(cProdANP)) ;
                    trvwNFe.Items.AddChild(NodePai,'CODIF='    +CODIF) ;
                    trvwNFe.Items.AddChild(NodePai,'qTemp='    +FloatToStr(qTemp)) ;

                    Node := trvwNFe.Items.AddChild(NodePai,'CIDE'+IntToStrZero(I+1,3));
                    trvwNFe.Items.AddChild(Node,'qBCprod='   +FloatToStr(CIDE.qBCprod)) ;
                    trvwNFe.Items.AddChild(Node,'vAliqProd=' +FloatToStr(CIDE.vAliqProd)) ;
                    trvwNFe.Items.AddChild(Node,'vCIDE='     +FloatToStr(CIDE.vCIDE)) ;

                    Node := trvwNFe.Items.AddChild(NodePai,'ICMSComb'+IntToStrZero(I+1,3));
                    trvwNFe.Items.AddChild(Node,'vBCICMS='   +FloatToStr(ICMS.vBCICMS)) ;
                    trvwNFe.Items.AddChild(Node,'vICMS='     +FloatToStr(ICMS.vICMS)) ;
                    trvwNFe.Items.AddChild(Node,'vBCICMSST=' +FloatToStr(ICMS.vBCICMSST)) ;
                    trvwNFe.Items.AddChild(Node,'vICMSST='   +FloatToStr(ICMS.vICMSST)) ;

                    if (ICMSInter.vBCICMSSTDest>0) then
                     begin
                       Node := trvwNFe.Items.AddChild(NodePai,'ICMSInter'+IntToStrZero(I+1,3));
                       trvwNFe.Items.AddChild(Node,'vBCICMSSTDest=' +FloatToStr(ICMSInter.vBCICMSSTDest)) ;
                       trvwNFe.Items.AddChild(Node,'vICMSSTDest='   +FloatToStr(ICMSInter.vICMSSTDest)) ;
                     end;

                    if (ICMSCons.vBCICMSSTCons>0) then
                     begin
                       Node := trvwNFe.Items.AddChild(NodePai,'ICMSCons'+IntToStrZero(I+1,3));
                       trvwNFe.Items.AddChild(Node,'vBCICMSSTCons=' +FloatToStr(ICMSCons.vBCICMSSTCons)) ;
                       trvwNFe.Items.AddChild(Node,'vICMSSTCons='   +FloatToStr(ICMSCons.vICMSSTCons)) ;
                       trvwNFe.Items.AddChild(Node,'UFCons='        +ICMSCons.UFcons) ;
                     end;
                  end;
               end;

               with Imposto do
                begin
                   NodePai := trvwNFe.Items.AddChild(NodeItem,'Imposto');
                   Node := trvwNFe.Items.AddChild(NodePai,'ICMS');
                   with ICMS do
                    begin
                      trvwNFe.Items.AddChild(Node,'CST=' +CSTICMSToStr(CST));

                      if CST = cst00 then
                       begin
                         trvwNFe.Items.AddChild(Node,'orig='  +OrigToStr(ICMS.orig));
                         trvwNFe.Items.AddChild(Node,'modBC=' +modBCToStr(ICMS.modBC));
                         trvwNFe.Items.AddChild(Node,'vBC='   +FloatToStr(ICMS.vBC));
                         trvwNFe.Items.AddChild(Node,'pICMS=' +FloatToStr(ICMS.pICMS));
                         trvwNFe.Items.AddChild(Node,'vICMS=' +FloatToStr(ICMS.vICMS));
                       end
                      else if CST = cst10 then
                       begin
                         trvwNFe.Items.AddChild(Node,'orig='     +OrigToStr(ICMS.orig));
                         trvwNFe.Items.AddChild(Node,'modBC='    +modBCToStr(ICMS.modBC));
                         trvwNFe.Items.AddChild(Node,'vBC='      +FloatToStr(ICMS.vBC));
                         trvwNFe.Items.AddChild(Node,'pICMS='    +FloatToStr(ICMS.pICMS));
                         trvwNFe.Items.AddChild(Node,'vICMS='    +FloatToStr(ICMS.vICMS));
                         trvwNFe.Items.AddChild(Node,'modBCST='  +modBCSTToStr(ICMS.modBCST));
                         trvwNFe.Items.AddChild(Node,'pMVAST='   +FloatToStr(ICMS.pMVAST));
                         trvwNFe.Items.AddChild(Node,'pRedBCST=' +FloatToStr(ICMS.pRedBCST));
                         trvwNFe.Items.AddChild(Node,'vBCST='    +FloatToStr(ICMS.vBCST));
                         trvwNFe.Items.AddChild(Node,'pICMSST='  +FloatToStr(ICMS.pICMSST));
                         trvwNFe.Items.AddChild(Node,'vICMSST='  +FloatToStr(ICMS.vICMSST));
                       end
                      else if CST = cst20 then
                       begin
                         trvwNFe.Items.AddChild(Node,'orig='   +OrigToStr(ICMS.orig));
                         trvwNFe.Items.AddChild(Node,'modBC='  +modBCToStr(ICMS.modBC));
                         trvwNFe.Items.AddChild(Node,'pRedBC=' +FloatToStr(ICMS.pRedBC));
                         trvwNFe.Items.AddChild(Node,'vBC='    +FloatToStr(ICMS.vBC));
                         trvwNFe.Items.AddChild(Node,'pICMS='  +FloatToStr(ICMS.pICMS));
                         trvwNFe.Items.AddChild(Node,'vICMS='  +FloatToStr(ICMS.vICMS));
                       end
                      else if CST = cst30 then
                       begin
                         trvwNFe.Items.AddChild(Node,'orig='     +OrigToStr(ICMS.orig));
                         trvwNFe.Items.AddChild(Node,'modBCST='  +modBCSTToStr(ICMS.modBCST));
                         trvwNFe.Items.AddChild(Node,'pMVAST='   +FloatToStr(ICMS.pMVAST));
                         trvwNFe.Items.AddChild(Node,'pRedBCST=' +FloatToStr(ICMS.pRedBCST));
                         trvwNFe.Items.AddChild(Node,'vBCST='    +FloatToStr(ICMS.vBCST));
                         trvwNFe.Items.AddChild(Node,'pICMSST='  +FloatToStr(ICMS.pICMSST));
                         trvwNFe.Items.AddChild(Node,'vICMSST='  +FloatToStr(ICMS.vICMSST));
                       end
                      else if (CST = cst40) or (CST = cst41) or (CST = cst50) then
                       begin
                         trvwNFe.Items.AddChild(Node,'orig='    +OrigToStr(ICMS.orig));
                       end
                      else if CST = cst51 then
                         begin
                         trvwNFe.Items.AddChild(Node,'orig='    +OrigToStr(ICMS.orig));
                         trvwNFe.Items.AddChild(Node,'modBC='   +modBCToStr(ICMS.modBC));
                         trvwNFe.Items.AddChild(Node,'pRedBC='  +FloatToStr(ICMS.pRedBC));
                         trvwNFe.Items.AddChild(Node,'vBC='     +FloatToStr(ICMS.vBC));
                         trvwNFe.Items.AddChild(Node,'pICMS='   +FloatToStr(ICMS.pICMS));
                         trvwNFe.Items.AddChild(Node,'vICMS='   +FloatToStr(ICMS.vICMS));
                       end
                      else if CST = cst60 then
                       begin
                         trvwNFe.Items.AddChild(Node,'orig='    +OrigToStr(ICMS.orig));
                         trvwNFe.Items.AddChild(Node,'vBCST='   +FloatToStr(ICMS.vBCST));
                         trvwNFe.Items.AddChild(Node,'vICMSST=' +FloatToStr(ICMS.vICMSST));
                       end
                      else if CST = cst70 then
                       begin
                         trvwNFe.Items.AddChild(Node,'orig='       +OrigToStr(ICMS.orig));
                         trvwNFe.Items.AddChild(Node,'modBC='      +modBCToStr(ICMS.modBC));
                         trvwNFe.Items.AddChild(Node,'pRedBC='     +FloatToStr(ICMS.pRedBC));
                         trvwNFe.Items.AddChild(Node,'vBC='        +FloatToStr(ICMS.vBC));
                         trvwNFe.Items.AddChild(Node,'pICMS='      +FloatToStr(ICMS.pICMS));
                         trvwNFe.Items.AddChild(Node,'vICMS='      +FloatToStr(ICMS.vICMS));
                         trvwNFe.Items.AddChild(Node,'modBCST='    +modBCSTToStr(ICMS.modBCST));
                         trvwNFe.Items.AddChild(Node,'pMVAST='     +FloatToStr(ICMS.pMVAST));
                         trvwNFe.Items.AddChild(Node,'pRedBCST='   +FloatToStr(ICMS.pRedBCST));
                         trvwNFe.Items.AddChild(Node,'vBCST='      +FloatToStr(ICMS.vBCST));
                         trvwNFe.Items.AddChild(Node,'pICMSST='    +FloatToStr(ICMS.pICMSST));
                         trvwNFe.Items.AddChild(Node,'vICMSST='    +FloatToStr(ICMS.vICMSST));
                       end
                      else if CST = cst90 then
                       begin
                         trvwNFe.Items.AddChild(Node,'orig='       +OrigToStr(ICMS.orig));
                         trvwNFe.Items.AddChild(Node,'modBC='      +modBCToStr(ICMS.modBC));
                         trvwNFe.Items.AddChild(Node,'pRedBC='     +FloatToStr(ICMS.pRedBC));
                         trvwNFe.Items.AddChild(Node,'vBC='        +FloatToStr(ICMS.vBC));
                         trvwNFe.Items.AddChild(Node,'pICMS='      +FloatToStr(ICMS.pICMS));
                         trvwNFe.Items.AddChild(Node,'vICMS='      +FloatToStr(ICMS.vICMS));
                         trvwNFe.Items.AddChild(Node,'modBCST='    +modBCSTToStr(ICMS.modBCST));
                         trvwNFe.Items.AddChild(Node,'pMVAST='     +FloatToStr(ICMS.pMVAST));
                         trvwNFe.Items.AddChild(Node,'pRedBCST='   +FloatToStr(ICMS.pRedBCST));
                         trvwNFe.Items.AddChild(Node,'vBCST='      +FloatToStr(ICMS.vBCST));
                         trvwNFe.Items.AddChild(Node,'pICMSST='    +FloatToStr(ICMS.pICMSST));
                         trvwNFe.Items.AddChild(Node,'vICMSST='    +FloatToStr(ICMS.vICMSST));
                       end;
                    end;

                   if (IPI.vBC > 0) then
                    begin
                      Node := trvwNFe.Items.AddChild(NodePai,'IPI');
                      with IPI do
                       begin
                         trvwNFe.Items.AddChild(Node,'CST='       +CSTIPIToStr(CST)) ;
                         trvwNFe.Items.AddChild(Node,'clEnq='    +clEnq);
                         trvwNFe.Items.AddChild(Node,'CNPJProd=' +CNPJProd);
                         trvwNFe.Items.AddChild(Node,'cSelo='    +cSelo);
                         trvwNFe.Items.AddChild(Node,'qSelo='    +IntToStr(qSelo));
                         trvwNFe.Items.AddChild(Node,'cEnq='     +cEnq);

                         trvwNFe.Items.AddChild(Node,'vBC='    +FloatToStr(vBC));
                         trvwNFe.Items.AddChild(Node,'qUnid='  +FloatToStr(qUnid));
                         trvwNFe.Items.AddChild(Node,'vUnid='  +FloatToStr(vUnid));
                         trvwNFe.Items.AddChild(Node,'pIPI='   +FloatToStr(pIPI));
                         trvwNFe.Items.AddChild(Node,'vIPI='   +FloatToStr(vIPI));
                       end;
                    end;

                   if (II.vBc > 0) then
                    begin
                      Node := trvwNFe.Items.AddChild(NodePai,'II');
                      with II do
                       begin
                         trvwNFe.Items.AddChild(Node,'vBc='      +FloatToStr(vBc));
                         trvwNFe.Items.AddChild(Node,'vDespAdu=' +FloatToStr(vDespAdu));
                         trvwNFe.Items.AddChild(Node,'vII='      +FloatToStr(vII));
                         trvwNFe.Items.AddChild(Node,'vIOF='     +FloatToStr(vIOF));
                       end;
                    end;

                   Node := trvwNFe.Items.AddChild(NodePai,'PIS');
                   with PIS do
                    begin
                      trvwNFe.Items.AddChild(Node,'CST=' +CSTPISToStr(CST));

                      if (CST = pis01) or (CST = pis02) then
                       begin
                         trvwNFe.Items.AddChild(Node,'vBC='  +FloatToStr(PIS.vBC));
                         trvwNFe.Items.AddChild(Node,'pPIS=' +FloatToStr(PIS.pPIS));
                         trvwNFe.Items.AddChild(Node,'vPIS=' +FloatToStr(PIS.vPIS));
                       end
                      else if CST = pis03 then
                       begin
                         trvwNFe.Items.AddChild(Node,'qBCProd='   +FloatToStr(PIS.qBCProd));
                         trvwNFe.Items.AddChild(Node,'vAliqProd=' +FloatToStr(PIS.vAliqProd));
                         trvwNFe.Items.AddChild(Node,'vPIS='      +FloatToStr(PIS.vPIS));
                       end
                      else if CST = pis99 then
                       begin
                         trvwNFe.Items.AddChild(Node,'vBC='       +FloatToStr(PIS.vBC));
                         trvwNFe.Items.AddChild(Node,'pPIS='      +FloatToStr(PIS.pPIS));
                         trvwNFe.Items.AddChild(Node,'qBCProd='   +FloatToStr(PIS.qBCProd));
                         trvwNFe.Items.AddChild(Node,'vAliqProd=' +FloatToStr(PIS.vAliqProd));
                         trvwNFe.Items.AddChild(Node,'vPIS='      +FloatToStr(PIS.vPIS));
                       end;
                    end;

                   if (PISST.vBc>0) then
                    begin
                      Node := trvwNFe.Items.AddChild(NodePai,'PISST');
                      with PISST do
                       begin
                         trvwNFe.Items.AddChild(Node,'vBc='       +FloatToStr(vBc));
                         trvwNFe.Items.AddChild(Node,'pPis='      +FloatToStr(pPis));
                         trvwNFe.Items.AddChild(Node,'qBCProd='   +FloatToStr(qBCProd));
                         trvwNFe.Items.AddChild(Node,'vAliqProd=' +FloatToStr(vAliqProd));
                         trvwNFe.Items.AddChild(Node,'vPIS='      +FloatToStr(vPIS));
                       end;
                      end;

                   Node := trvwNFe.Items.AddChild(NodePai,'COFINS');
                   with COFINS do
                    begin
                      trvwNFe.Items.AddChild(Node,'CST=' +CSTCOFINSToStr(CST));

                      if (CST = cof01) or (CST = cof02)   then
                       begin
                         trvwNFe.Items.AddChild(Node,'vBC='     +FloatToStr(COFINS.vBC));
                         trvwNFe.Items.AddChild(Node,'pCOFINS=' +FloatToStr(COFINS.pCOFINS));
                         trvwNFe.Items.AddChild(Node,'vCOFINS=' +FloatToStr(COFINS.vCOFINS));
                       end
                      else if CST = cof03 then
                       begin
                         trvwNFe.Items.AddChild(Node,'qBCProd='   +FloatToStr(COFINS.qBCProd));
                         trvwNFe.Items.AddChild(Node,'vAliqProd=' +FloatToStr(COFINS.vAliqProd));
                         trvwNFe.Items.AddChild(Node,'vCOFINS='   +FloatToStr(COFINS.vCOFINS));
                       end
                      else if CST = cof99 then
                       begin
                         trvwNFe.Items.AddChild(Node,'vBC='       +FloatToStr(COFINS.vBC));
                         trvwNFe.Items.AddChild(Node,'pCOFINS='   +FloatToStr(COFINS.pCOFINS));
                         trvwNFe.Items.AddChild(Node,'qBCProd='   +FloatToStr(COFINS.qBCProd));
                         trvwNFe.Items.AddChild(Node,'vAliqProd=' +FloatToStr(COFINS.vAliqProd));
                         trvwNFe.Items.AddChild(Node,'vCOFINS='   +FloatToStr(COFINS.vCOFINS));
                       end;
                    end;

                   if (COFINSST.vBC > 0) then
                    begin
                      Node := trvwNFe.Items.AddChild(NodePai,'COFINSST');
                      with COFINSST do
                       begin
                         trvwNFe.Items.AddChild(Node,'vBC='       +FloatToStr(vBC));
                         trvwNFe.Items.AddChild(Node,'pCOFINS='   +FloatToStr(pCOFINS));
                         trvwNFe.Items.AddChild(Node,'qBCProd='   +FloatToStr(qBCProd));
                         trvwNFe.Items.AddChild(Node,'vAliqProd=' +FloatToStr(vAliqProd));
                         trvwNFe.Items.AddChild(Node,'vCOFINS='   +FloatToStr(vCOFINS));
                       end;
                    end;

                   if (ISSQN.vBC > 0) then
                    begin
                     Node := trvwNFe.Items.AddChild(NodePai,'ISSQN');
                     with ISSQN do
                      begin
                        trvwNFe.Items.AddChild(Node,'vBC='       +FloatToStr(vBC));
                        trvwNFe.Items.AddChild(Node,'vAliq='     +FloatToStr(vAliq));
                        trvwNFe.Items.AddChild(Node,'vISSQN='    +FloatToStr(vISSQN));
                        trvwNFe.Items.AddChild(Node,'cMunFG='    +IntToStr(cMunFG));
                        trvwNFe.Items.AddChild(Node,'cListServ=' +IntToStr(cListServ));
                      end;
                    end;
                end;
             end;
          end ;

       NodePai := trvwNFe.Items.AddChild(Nota,'Total');
       Node := trvwNFe.Items.AddChild(NodePai,'ICMSTot');
       trvwNFe.Items.AddChild(Node,'vBC='     +FloatToStr(Total.ICMSTot.vBC));
       trvwNFe.Items.AddChild(Node,'vICMS='   +FloatToStr(Total.ICMSTot.vICMS)) ;
       trvwNFe.Items.AddChild(Node,'vBCST='   +FloatToStr(Total.ICMSTot.vBCST)) ;
       trvwNFe.Items.AddChild(Node,'vST='     +FloatToStr(Total.ICMSTot.vST)) ;
       trvwNFe.Items.AddChild(Node,'vProd='   +FloatToStr(Total.ICMSTot.vProd)) ;
       trvwNFe.Items.AddChild(Node,'vFrete='  +FloatToStr(Total.ICMSTot.vFrete)) ;
       trvwNFe.Items.AddChild(Node,'vSeg='    +FloatToStr(Total.ICMSTot.vSeg)) ;
       trvwNFe.Items.AddChild(Node,'vDesc='   +FloatToStr(Total.ICMSTot.vDesc)) ;
       trvwNFe.Items.AddChild(Node,'vII='     +FloatToStr(Total.ICMSTot.vII)) ;
       trvwNFe.Items.AddChild(Node,'vIPI='    +FloatToStr(Total.ICMSTot.vIPI)) ;
       trvwNFe.Items.AddChild(Node,'vPIS='    +FloatToStr(Total.ICMSTot.vPIS)) ;
       trvwNFe.Items.AddChild(Node,'vCOFINS=' +FloatToStr(Total.ICMSTot.vCOFINS)) ;
       trvwNFe.Items.AddChild(Node,'vOutro='  +FloatToStr(Total.ICMSTot.vOutro)) ;
       trvwNFe.Items.AddChild(Node,'vNF='     +FloatToStr(Total.ICMSTot.vNF)) ;

       if Total.ISSQNtot.vServ > 0 then
        begin
          Node := trvwNFe.Items.AddChild(NodePai,'ISSQNtot');
          trvwNFe.Items.AddChild(Node,'vServ='   +FloatToStr(Total.ISSQNtot.vServ)) ;
          trvwNFe.Items.AddChild(Node,'vBC='     +FloatToStr(Total.ISSQNTot.vBC)) ;
          trvwNFe.Items.AddChild(Node,'vISS='    +FloatToStr(Total.ISSQNTot.vISS)) ;
          trvwNFe.Items.AddChild(Node,'vPIS='    +FloatToStr(Total.ISSQNTot.vPIS)) ;
          trvwNFe.Items.AddChild(Node,'vCOFINS=' +FloatToStr(Total.ISSQNTot.vCOFINS)) ;
        end;

       Node := trvwNFe.Items.AddChild(NodePai,'retTrib');
       trvwNFe.Items.AddChild(Node,'vRetPIS='   +FloatToStr(Total.retTrib.vRetPIS)) ;
       trvwNFe.Items.AddChild(Node,'vRetCOFINS='+FloatToStr(Total.retTrib.vRetCOFINS)) ;
       trvwNFe.Items.AddChild(Node,'vRetCSLL='  +FloatToStr(Total.retTrib.vRetCSLL)) ;
       trvwNFe.Items.AddChild(Node,'vBCIRRF='   +FloatToStr(Total.retTrib.vBCIRRF)) ;
       trvwNFe.Items.AddChild(Node,'vIRRF='     +FloatToStr(Total.retTrib.vIRRF)) ;
       trvwNFe.Items.AddChild(Node,'vBCRetPrev='+FloatToStr(Total.retTrib.vBCRetPrev)) ;
       trvwNFe.Items.AddChild(Node,'vRetPrev='  +FloatToStr(Total.retTrib.vRetPrev)) ;

       NodePai := trvwNFe.Items.AddChild(Nota,'Transp');
       Node := trvwNFe.Items.AddChild(NodePai,'Transporta');
       trvwNFe.Items.AddChild(Node,'modFrete=' +modFreteToStr(Transp.modFrete));
       trvwNFe.Items.AddChild(Node,'CNPJCPF='  +Transp.Transporta.CNPJCPF);
       trvwNFe.Items.AddChild(Node,'xNome='    +Transp.Transporta.xNome);
       trvwNFe.Items.AddChild(Node,'IE='       +Transp.Transporta.IE);
       trvwNFe.Items.AddChild(Node,'xEnder='   +Transp.Transporta.xEnder);
       trvwNFe.Items.AddChild(Node,'xMun='     +Transp.Transporta.xMun);
       trvwNFe.Items.AddChild(Node,'UF='       +Transp.Transporta.UF);

       Node := trvwNFe.Items.AddChild(NodePai,'retTransp');
       trvwNFe.Items.AddChild(Node,'vServ='    +FloatToStr(Transp.retTransp.vServ)) ;
       trvwNFe.Items.AddChild(Node,'vBCRet='   +FloatToStr(Transp.retTransp.vBCRet)) ;
       trvwNFe.Items.AddChild(Node,'pICMSRet=' +FloatToStr(Transp.retTransp.pICMSRet)) ;
       trvwNFe.Items.AddChild(Node,'vICMSRet=' +FloatToStr(Transp.retTransp.vICMSRet)) ;
       trvwNFe.Items.AddChild(Node,'CFOP='     +Transp.retTransp.CFOP);
       trvwNFe.Items.AddChild(Node,'cMunFG='   +FloatToStr(Transp.retTransp.cMunFG));

       Node := trvwNFe.Items.AddChild(NodePai,'veicTransp');
       trvwNFe.Items.AddChild(Node,'placa='  +Transp.veicTransp.placa);
       trvwNFe.Items.AddChild(Node,'UF='     +Transp.veicTransp.UF);
       trvwNFe.Items.AddChild(Node,'RNTC='   +Transp.veicTransp.RNTC);

       for I:=0 to Transp.Reboque.Count-1 do
        begin
          Node := trvwNFe.Items.AddChild(NodePai,'Reboque'+IntToStrZero(I+1,3));
          with Transp.Reboque.Items[I] do
           begin
             trvwNFe.Items.AddChild(Node,'placa=' +placa) ;
             trvwNFe.Items.AddChild(Node,'UF='    +UF) ;
             trvwNFe.Items.AddChild(Node,'RNTC='  +RNTC) ;
           end;
        end;

       for I:=0 to Transp.Vol.Count-1 do
        begin
          Node := trvwNFe.Items.AddChild(NodePai,'Volume'+IntToStrZero(I+1,3));
          with Transp.Vol.Items[I] do
           begin
             trvwNFe.Items.AddChild(Node,'qVol='  +IntToStr(qVol)) ;
             trvwNFe.Items.AddChild(Node,'esp='   +esp);
             trvwNFe.Items.AddChild(Node,'marca=' +marca);
             trvwNFe.Items.AddChild(Node,'nVol='  +nVol);
             trvwNFe.Items.AddChild(Node,'pesoL=' +FloatToStr(pesoL)) ;
             trvwNFe.Items.AddChild(Node,'pesoB'  +FloatToStr(pesoB)) ;

             for J:=0 to Lacres.Count-1 do
              begin
                Node := trvwNFe.Items.AddChild(Node,'Lacre'+IntToStrZero(I+1,3)+IntToStrZero(J+1,3) );
                trvwNFe.Items.AddChild(Node,'nLacre='+Lacres.Items[J].nLacre) ;
              end;
           end;
        end;

       NodePai := trvwNFe.Items.AddChild(Nota,'Cobr');
       Node    := trvwNFe.Items.AddChild(NodePai,'Fat');
       trvwNFe.Items.AddChild(Node,'nFat='  +Cobr.Fat.nFat);
       trvwNFe.Items.AddChild(Node,'vOrig=' +FloatToStr(Cobr.Fat.vOrig)) ;
       trvwNFe.Items.AddChild(Node,'vDesc=' +FloatToStr(Cobr.Fat.vDesc)) ;
       trvwNFe.Items.AddChild(Node,'vLiq='  +FloatToStr(Cobr.Fat.vLiq)) ;

       for I:=0 to Cobr.Dup.Count-1 do
        begin
          Node    := trvwNFe.Items.AddChild(NodePai,'Duplicata'+IntToStrZero(I+1,3));
          with Cobr.Dup.Items[I] do
           begin
             trvwNFe.Items.AddChild(Node,'nDup='  +nDup) ;
             trvwNFe.Items.AddChild(Node,'dVenc=' +DateToStr(dVenc));
             trvwNFe.Items.AddChild(Node,'vDup='  +FloatToStr(vDup)) ;
           end;
        end;

       NodePai := trvwNFe.Items.AddChild(Nota,'InfAdic');
       trvwNFe.Items.AddChild(NodePai,'infCpl='     +InfAdic.infCpl);
       trvwNFe.Items.AddChild(NodePai,'infAdFisco=' +InfAdic.infAdFisco);

       for I:=0 to InfAdic.obsCont.Count-1 do
        begin
          Node := trvwNFe.Items.AddChild(NodePai,'obsCont'+IntToStrZero(I+1,3));
          with InfAdic.obsCont.Items[I] do
           begin
             trvwNFe.Items.AddChild(Node,'xCampo=' +xCampo) ;
             trvwNFe.Items.AddChild(Node,'xTexto=' +xTexto);
           end;
        end;

         for I:=0 to InfAdic.obsFisco.Count-1 do
          begin
            Node := trvwNFe.Items.AddChild(NodePai,'obsFisco'+IntToStrZero(I+1,3));
            with InfAdic.obsFisco.Items[I] do
             begin
                trvwNFe.Items.AddChild(Node,'xCampo=' +xCampo) ;
                trvwNFe.Items.AddChild(Node,'xTexto=' +xTexto);
             end;
          end;

         for I:=0 to InfAdic.procRef.Count-1 do
          begin
            Node := trvwNFe.Items.AddChild(NodePai,'procRef'+IntToStrZero(I+1,3));
            with InfAdic.procRef.Items[I] do
             begin
               trvwNFe.Items.AddChild(Node,'nProc='   +nProc) ;
               trvwNFe.Items.AddChild(Node,'indProc=' +indProcToStr(indProc));
             end;
          end;

         if (exporta.UFembarq <> '') then
          begin
            Node := trvwNFe.Items.AddChild(Nota,'exporta');
            trvwNFe.Items.AddChild(Node,'UFembarq='   +exporta.UFembarq) ;
            trvwNFe.Items.AddChild(Node,'xLocEmbarq=' +exporta.xLocEmbarq);
          end;

         if (compra.xNEmp <> '') then
          begin
            Node := trvwNFe.Items.AddChild(Nota,'compra');
            trvwNFe.Items.AddChild(Node,'xNEmp=' +compra.xNEmp) ;
            trvwNFe.Items.AddChild(Node,'xPed='  +compra.xPed);
            trvwNFe.Items.AddChild(Node,'xCont=' +compra.xCont);
          end;
     end;
       PageControl2.ActivePageIndex := 3;
     end;

  end;
end;



procedure TForm1.lblMouseEnter(Sender: TObject);
begin
 TLabel(Sender).Font.Style := [fsBold,fsUnderline];
end;

procedure TForm1.lblMouseLeave(Sender: TObject);
begin
 TLabel(Sender).Font.Style := [fsBold];
end;

procedure TForm1.lblColaboradorClick(Sender: TObject);
begin
//  ShellExecute(0, Nil, 'http://acbr.sourceforge.net/drupal/?q=node/5', Nil, Nil, SW_NORMAL);
end;

procedure TForm1.lblPatrocinadorClick(Sender: TObject);
begin
//  ShellExecute(0, Nil, 'http://acbr.sourceforge.net/drupal/?q=node/35', Nil, Nil, SW_NORMAL);
end;

procedure TForm1.lblDoar1Click(Sender: TObject);
begin
//  ShellExecute(0, Nil, 'http://acbr.sourceforge.net/drupal/?q=node/14', Nil, Nil, SW_NORMAL);
end;

initialization
  {$I Unit1.lrs}

end.
