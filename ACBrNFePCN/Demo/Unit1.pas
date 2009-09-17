{$I ACBr.inc}

unit Unit1;

interface

uses IniFiles, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Buttons, ComCtrls, OleCtrls, SHDocVw,
  ACBrNFe, pcnConversao, ACBrNFeDANFEClass, ACBrNFeDANFERave;

type
  TForm1 = class(TForm)
    Panel1: TPanel;
    GroupBox1: TGroupBox;
    PageControl1: TPageControl;
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
    ckVisualizar: TCheckBox;
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
    WBResposta: TWebBrowser;
    edtNumSerie: TEdit;
    Label25: TLabel;
    rgTipoAmb: TRadioGroup;
    rgTipoDanfe: TRadioGroup;
    rgFormaEmissao: TRadioGroup;
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
    ACBrNFeDANFERave1: TACBrNFeDANFERave;
    btnConsultarRecibo: TButton;
    btnEnvDPEC: TButton;
    btnConsultarDPEC: TButton;
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
  private
    { Private declarations }
    procedure GravarConfiguracao ;
    procedure LerConfiguracao ;
    procedure LoadXML(MyMemo: TMemo; MyWebBrowser: TWebBrowser);
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses FileCtrl, pcnNFe, ufrmStatus, ACBrNFeNotasFiscais, DateUtils, ACBrNFeUtil;

const
  SELDIRHELP = 1000;

{$R *.dfm}

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

procedure TForm1.LoadXML(MyMemo: TMemo; MyWebBrowser: TWebBrowser);
begin
  MyMemo.Lines.SaveToFile(ExtractFileDir(application.ExeName)+'temp.xml');
  MyWebBrowser.Navigate(ExtractFileDir(application.ExeName)+'temp.xml');
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
  Dir: string;
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
    MemoResp.Lines.Text := UTF8Encode(ACBrNFe1.WebServices.Consulta.RetWS);
    LoadXML(MemoResp, WBResposta);
  end;
end;

procedure TForm1.btnCancNFClick(Sender: TObject);
var
  vAux : String;
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
 vAux : String;
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
  ShowMessage(ACBrNFe1.WebServices.Retorno.Protocolo);
  ShowMessage(ACBrNFe1.WebServices.Retorno.Recibo);

  MemoResp.Lines.Text := UTF8Encode(ACBrNFe1.WebServices.Retorno.RetWS);
  LoadXML(MemoResp, WBResposta);

   ACBrNFe1.NotasFiscais.Clear;
end;

procedure TForm1.btnInutilizarClick(Sender: TObject);
var
 Modelo, Serie, Ano, NumeroInicial, NumeroFinal, Justificativa : String;
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
 vAux : String;
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
  end;

  ACBrNFe1.NotasFiscais.Items[0].SaveToFile;
  MemoResp.Lines.LoadFromFile(ACBrNFe1.Configuracoes.Geral.PathSalvar+'\'+copy(ACBrNFe1.NotasFiscais.Items[0].NFe.infNFe.ID, (length(ACBrNFe1.NotasFiscais.Items[0].NFe.infNFe.ID)-44)+1, 44)+'-NFe.xml');
  LoadXML(MemoResp, WBResposta);
end;

procedure TForm1.btnConsCadClick(Sender: TObject);
var
 UF, Documento : String;
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
 Para : String;
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
  aux : String;
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
 vAux : String;
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
 vAux : String;
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

end.
