{$I ACBr.inc}

unit ACBrNFeMonitor1;

interface

uses IniFiles, CmdUnitNFe, FileCtrl, Printers,
  IdBaseComponent, IdComponent, IdTCPServer,
  ShellAPI,                                { Unit para criar icone no Systray }
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, ExtCtrls, Buttons, Spin, Menus, ImgList,
  ACBrNFe, ACBrNFeDANFEClass, ACBrNFeDANFERave, pcnConversao, OleCtrls,
  SHDocVw;

const
   BufferMemoResposta = 1000 ;              { Maximo de Linhas no MemoResposta }
   _C = 'tYk*5W@' ;
   wm_IconMessage = wm_User;

{$I versao.txt}
type
  TfrmAcbrNfeMonitor = class(TForm)
    pPrincipal: TPanel;
    pBotoes: TPanel;
    pCmd: TPanel;
    pResp: TPanel;
    Splitter1: TSplitter;
    pTopCmd: TPanel;
    pTodResp: TPanel;
    sbProcessando: TStatusBar;
    mCmd: TMemo;
    mResp: TMemo;
    StatusBar1: TStatusBar;
    pmTray: TPopupMenu;
    Restaurar1: TMenuItem;
    Ocultar1: TMenuItem;
    N1: TMenuItem;
    EncerrarMonitor1: TMenuItem;
    Timer1: TTimer;
    TCPServer: TIdTCPServer;
    pConfig: TPanel;
    PageControl1: TPageControl;
    Monitor: TTabSheet;
    gbTCP: TGroupBox;
    Label12: TLabel;
    Label13: TLabel;
    edPortaTCP: TEdit;
    sedConexoesTCP: TSpinEdit;
    gbTXT: TGroupBox;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    edEntTXT: TEdit;
    edSaiTXT: TEdit;
    sedIntervalo: TSpinEdit;
    gbSenha: TGroupBox;
    Label17: TLabel;
    edSenha: TEdit;
    gbLog: TGroupBox;
    Label18: TLabel;
    Label19: TLabel;
    sbLog: TSpeedButton;
    edLogArq: TEdit;
    sedLogLinhas: TSpinEdit;
    rbTCP: TRadioButton;
    cbSenha: TCheckBox;
    rbTXT: TRadioButton;
    cbLog: TCheckBox;
    Certificado: TTabSheet;
    gbxCertificado: TGroupBox;
    lblCaminho: TLabel;
    lblSenha: TLabel;
    sbArquivoCert: TSpeedButton;
    edtCaminho: TEdit;
    edtSenha: TEdit;
    WebService: TTabSheet;
    GroupBox4: TGroupBox;
    Label6: TLabel;
    sbPathSalvar: TSpeedButton;
    cbUF: TComboBox;
    ckSalvar: TCheckBox;
    edtPathLogs: TEdit;
    gbxProxy: TGroupBox;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    edtProxyHost: TEdit;
    edtProxyPorta: TEdit;
    edtProxyUser: TEdit;
    edtProxySenha: TEdit;
    ACBrNFe1: TACBrNFe;
    btMinimizar: TBitBtn;
    btConfig: TBitBtn;
    btCancelar: TBitBtn;
    Image1: TImage;
    Email: TTabSheet;
    GroupBox1: TGroupBox;
    edtSmtpHost: TEdit;
    edtSmtpPort: TEdit;
    edtSmtpUser: TEdit;
    edtSmtpPass: TEdit;
    edtEmailAssunto: TEdit;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    cbEmailSSL: TCheckBox;
    mmEmailMsg: TMemo;
    Label25: TLabel;
    OpenDialog1: TOpenDialog;
    ImageList1: TImageList;
    rgTipoAmb: TRadioGroup;
    DANFE: TTabSheet;
    rgTipoDanfe: TRadioGroup;
    edtLogoMarca: TEdit;
    Label7: TLabel;
    sbLogoMarca: TSpeedButton;
    GroupBox3: TGroupBox;
    Label3: TLabel;
    edtSiteEmpresa: TEdit;
    Label4: TLabel;
    edtEmailEmpresa: TEdit;
    cbxImpressora: TComboBox;
    Label5: TLabel;
    edtFaxEmpresa: TEdit;
    Label26: TLabel;
    Label27: TLabel;
    edtSoftwareHouse: TEdit;
    rgFormaEmissao: TRadioGroup;
    cbxImpDescPorc: TCheckBox;
    cbxMostrarPreview: TCheckBox;
    Testes: TTabSheet;
    Panel1: TPanel;
    btnStatusServ: TButton;
    btnValidarXML: TButton;
    btnImprimir: TButton;
    btnInutilizar: TButton;
    btnConsultar: TButton;
    btnCancNF: TButton;
    btnEnviar: TButton;
    Panel2: TPanel;
    WBResposta: TWebBrowser;
    Panel3: TPanel;
    Label1: TLabel;
    edtNumCopia: TEdit;
    ACBrNFeDANFERave1: TACBrNFeDANFERave;
    Label2: TLabel;
    edtMargemInf: TEdit;
    edtPathPDF: TEdit;
    sbPathPDF: TSpeedButton;
    Label28: TLabel;
    procedure DoACBrTimer(Sender: TObject);
    procedure edOnlyNumbers(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure Restaurar1Click(Sender: TObject);
    procedure Ocultar1Click(Sender: TObject);
    procedure EncerrarMonitor1Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure btConfigClick(Sender: TObject);
    procedure btMinimizarClick(Sender: TObject);
    procedure btCancelarClick(Sender: TObject);
    procedure rbTCPClick(Sender: TObject);
    procedure cbSenhaClick(Sender: TObject);
    procedure cbLogClick(Sender: TObject);
    procedure TCPServerConnect(AThread: TIdPeerThread);
    procedure TCPServerDisconnect(AThread: TIdPeerThread);
    procedure TCPServerExecute(AThread: TIdPeerThread);
    procedure sbArquivoCertClick(Sender: TObject);
    procedure sbLogoMarcaClick(Sender: TObject);
    procedure sbPathSalvarClick(Sender: TObject);
    procedure btnStatusServClick(Sender: TObject);
    procedure btnConsultarClick(Sender: TObject);
    procedure btnCancNFClick(Sender: TObject);
    procedure btnValidarXMLClick(Sender: TObject);
    procedure btnImprimirClick(Sender: TObject);
    procedure btnInutilizarClick(Sender: TObject);
    procedure btnEnviarClick(Sender: TObject);
    procedure edtNumCopiaKeyPress(Sender: TObject; var Key: Char);
    procedure edtMargemInfKeyPress(Sender: TObject; var Key: Char);
    procedure sbPathPDFClick(Sender: TObject);
  private
    { Private declarations }
    ACBrNFeMonitorINI : string;
    Inicio  : Boolean ;
    ArqSaiTXT, ArqSaiTMP, ArqEntTXT, ArqLogTXT, ArqEntOrig, ArqSaiOrig : String ;
    NewLines : String ;
    fsHashSenha:Integer;
    fsLinesLog : AnsiString ;
    Cmd : TACBrNFeCmd ;

    procedure ExibeResp( Resposta : AnsiString );
    procedure Inicializar ;
    procedure EscondeConfig ;
    procedure ExibeConfig ;
    procedure LerIni ;
    procedure SalvarIni ;
    procedure AjustaLinhasLog ;

    procedure Resposta(Comando, Resposta : string);

    procedure AddLinesLog ;

    procedure TrataErros(Sender: TObject; E: Exception);

    procedure IconTray (var Msg: TMessage);
    message wm_IconMessage;
  public
    { Public declarations }
    nid: TNotifyIconData;
    Conexao : TIdPeerThread ;

    procedure Processar ;
  end;

var
  frmAcbrNfeMonitor: TfrmAcbrNfeMonitor;

implementation

uses ACBrUtil, IdStack, UtilUnit, DoACBrNFeUnit;

const
  SELDIRHELP = 1000;

{$R *.dfm}
procedure TfrmAcbrNfeMonitor.ExibeResp( Resposta : AnsiString );
var
 StrLstResposta : TStringList;
begin
 StrLstResposta := TStringList.Create;
 StrLstResposta.Text := UTF8Encode(Resposta);
 StrLstResposta.SaveToFile(PathWithDelim(ExtractFileDir(application.ExeName))+'temp.xml');
 WBResposta.Navigate(PathWithDelim(ExtractFileDir(application.ExeName))+'temp.xml');
 StrLstResposta.Free;
end;

procedure TfrmAcbrNfeMonitor.Inicializar;
Var
  Txt    : String ;
  Erro   : String ;
  A : Integer ;
begin
  cbxImpressora.Items.Assign(Printer.Printers);
  Timer1.Enabled := false ;
  Inicio         := false ;
  Erro           := '' ;
  ACBrNFeMonitorINI := ExtractFilePath(Application.ExeName)+ 'ACBrNFeMonitor.ini';

  if not FileExists( ACBrNFeMonitorINI ) then //verifica se o arq. de config existe
  begin                                    //se nao existir vai para as configs
    MessageDlg('Bem vindo ao ACBrNFeMonitor,'+#13#10#13#10+
               'Por favor configure o ACBrNFeMonitor, '+
               'informando o Método de Monitoramento, e a configuração '+
               'do certificado utilizado para assinar e efetuar a conexão segura com os WebServices.'+#13#10#13#10+
               'IMPORTANTE: Após configurar o '+
               'Método de Monitoramento o ACBrMonitor'+
               ' deve ser reiniciado.',mtInformation,[mbok],0) ;
    {$IFDEF ACBrNFeOpenSSL}
       gbxCertificado.Height := 109;
       rgFormaEmissao.Top := 105;
       lblCaminho.Caption := 'Arquivo PFX';
       edtSenha.Visible := True;
       lblSenha.Visible := True;
    {$ELSE}
       edtSenha.Visible := False;
       lblSenha.Visible := False;
       gbxCertificado.Height := 69;
       lblCaminho.Caption := 'Número de Série';
    {$ENDIF}
    btConfig.Click ;
    exit ;
  end;

  while not Visible do
  begin
     Application.ProcessMessages ;
     sleep(200) ;
  end ;

  try
     LerIni;

     Application.Minimize ;
  except
     on E : Exception do
        Erro := Erro + sLineBreak + E.Message ;
  end ;

  EscondeConfig ;

  try
     AjustaLinhasLog ;  { Diminui / Ajusta o numero de linhas do Log }
  except
     on E : Exception do
        Erro := Erro + sLineBreak +E.Message ;
  end ;

  try
     btConfig.Enabled  := true ;
     Timer1.Interval  := sedIntervalo.Value ;
     Timer1.Enabled   := rbTXT.Checked ;
     TcpServer.Active := rbTCP.Checked ;

     mResp.Lines.Add('ACBrNFeMonitor Ver.'+Versao);
     mResp.Lines.Add('Aguardando comandos');
  except
     on E : Exception do
        Erro := Erro + sLineBreak + E.Message ;
  end ;

  try
     if rbTCP.Checked then
      begin
        if TcpServer.Active then
        begin
           try
              Txt := 'Endereço: '+TcpServer.LocalName ;
              For A := 0 to IdStack.GStack.LocalAddresses.Count-1 do
                 Txt := Txt + '   ' + IdStack.GStack.LocalAddresses[A] ;
           except
           end ;
           mResp.Lines.Add(Txt) ;
           mResp.Lines.Add( 'Porta: ['+IntToStr(TcpServer.DefaultPort)+']') ;
        end ;
      end
     else
      begin
        mResp.Lines.Add('Monitorando Comandos TXT em: '+ArqEntTXT);
        mResp.Lines.Add('Respostas gravadas em: '+ArqSaiTXT);
      end ;

     if cbLog.Checked then
        mResp.Lines.Add('Log de comandos será gravado em: '+ArqLogTXT) ;

  except
     on E : Exception do
        Erro := Erro + sLineBreak + E.Message ;
  end ;

  if Erro <> '' then
     Raise Exception.Create( Erro );
end;

{------------------------------------------------------------------------------}
procedure TfrmAcbrNfeMonitor.AjustaLinhasLog;
  Procedure AjustaLogFile( AFile : String; LinhasMax : Integer ) ;
    Var LogNew, LogOld : TStringList ;
     I : Integer ;
  begin
     if not FileExists( AFile ) then
        exit ;

     LogOld := TStringList.Create ;
     try
        LogOld.LoadFromFile( AFile );
        if LogOld.Count > LinhasMax then
        begin
           mResp.Lines.Add('Ajustando o tamanho do arquivo: '+AFile) ;
           mResp.Lines.Add('Numero de Linhas atual: '+IntToStr(LogOld.Count) ) ;
           mResp.Lines.Add('Reduzindo para: '+IntToStr(LinhasMax)+ ' linhas' );

           { Se for muito grande é mais rápido copiar para outra lista do que Deletar }
           if (LogOld.Count - LinhasMax) > LinhasMax then
            begin
              LogNew := TStringList.Create ;
              try
                 LogNew.Clear ;

                 For I := LinhasMax downto 1 do
                    LogNew.Add(LogOld[ LogOld.Count - I ] ) ;

                 LogNew.SaveToFile( AFile );
              finally
                 LogNew.Free ;
              end ;
            end
           else
            begin
              { Existe alguma maneira mais rápida de fazer isso ??? }
              LogOld.BeginUpdate ;
              while LogOld.Count > LinhasMax do
                 LogOld.Delete(0) ;
              LogOld.EndUpdate ;
              LogOld.SaveToFile( AFile );
            end ;
        end ;
     finally
        LogOld.Free ;
     end ;
  end ;
begin
  if (sedLogLinhas.Value <= 0) then
     exit ;

  // Ajustado LOG do ACBrNFeMonitor //
  if (cbLog.Checked) then
     AjustaLogFile( ArqLogTXT, sedLogLinhas.Value );

end;

procedure TfrmAcbrNfeMonitor.EscondeConfig;
begin
  pConfig.Visible := False ;

  btConfig.Caption     := '&Configurar' ;
  btConfig.Glyph       := nil ;
  ImageList1.GetBitmap(5,btConfig.Glyph);
  btCancelar.Visible   := false ;
  btMinimizar.Visible := true ;
  Application.ProcessMessages ;
end;

procedure TfrmAcbrNfeMonitor.ExibeConfig;
Var Senha     : String ;
    SenhaOk   : Boolean ;
    HashSenha : Integer ;
begin
  SenhaOk := (fsHashSenha < 1)  ;
  if not SenhaOk then
  begin
     Senha := '' ;
     if InputQuery('Configuração','Digite a Senha de Configuração',Senha) then
     begin
        Senha     := Trim(Senha) ;
        HashSenha := StringCrc16( Senha ) ;
        SenhaOk   := (HashSenha = fsHashSenha) ;
     end ;
  end ;

  if not SenhaOk then
     raise Exception.Create('Senha ['+Senha+'] inválida');

  pConfig.Visible := true ;

  btConfig.Caption     := '&Salvar' ;
  btConfig.Glyph       := nil ;
  ImageList1.GetBitmap(6,btConfig.Glyph);
  btCancelar.Visible   := true ;
  btMinimizar.Visible := false ;
  Application.ProcessMessages ;
end;

procedure TfrmAcbrNfeMonitor.LerIni ;
var
  Ini : TIniFile;
  Senha :String ;
  StreamMemo : TMemoryStream;
  OK : Boolean;
begin
  Ini := TIniFile.Create( ACBrNFeMonitorINI ) ;

  try
     { Lendo Senha }
     fsHashSenha := StrToIntDef( LeINICrypt(INI,'ACBrNFeMonitor','HashSenha', _C), -1) ;

     if fsHashSenha < 1 then  { INI antigo não tinha essa chave }
     begin
        Senha := Ini.ReadString('ACBrNFeMonitor','Senha','');
        if Senha <> '' then
           fsHashSenha := StringCrc16(Senha) ;
     end ;

     if fsHashSenha > 0 then
     begin
        cbSenha.Checked := True ;
        edSenha.Text    := 'NADAAQUI' ;
     end ;

     { Parametros do Monitor }
     rbTCP.Checked        := Ini.ReadBool('ACBrNFeMonitor','Modo_TCP',false);
     rbTXT.Checked        := Ini.ReadBool('ACBrNFeMonitor','Modo_TXT',false);
     edPortaTCP.Text      := IntToStr(Ini.ReadInteger('ACBrNFeMonitor','TCP_Porta',3434));
     sedConexoesTCP.Value := Ini.ReadInteger('ACBrNFeMonitor','Conexoes_Simultaneas',1);
     edEntTXT.Text        := Ini.ReadString('ACBrNFeMonitor','TXT_Entrada','ENT.TXT');
     edSaiTXT.Text        := Ini.ReadString('ACBrNFeMonitor','TXT_Saida','SAI.TXT');
     sedIntervalo.Value   := Ini.ReadInteger('ACBrNFeMonitor','Intervalo',50);
     edLogArq.Text        := Ini.ReadString('ACBrNFeMonitor','Arquivo_Log','LOG.TXT');
     cbLog.Checked        := Ini.ReadBool('ACBrNFeMonitor','Gravar_Log',false) and
                           ( edLogArq.Text <> '' ) ;
     sedLogLinhas.Value   := Ini.ReadInteger('ACBrNFeMonitor','Linhas_Log',0);

     ArqEntTXT := AcertaPath( edEntTXT.Text ) ;
     ArqEntOrig := ArqEntTXT;
     ArqSaiTXT := AcertaPath( edSaiTXT.Text ) ;
     ArqSaiOrig := ArqSaiTXT;     
     ArqSaiTMP := ChangeFileExt( ArqSaiTXT, '.tmp' ) ;
     ArqLogTXT := AcertaPath( edLogArq.Text ) ;

     TcpServer.DefaultPort    := StrToInt( edPortaTCP.Text ) ;
     TcpServer.MaxConnections := sedConexoesTCP.Value ;
     TcpServer.MaxConnectionReply.Text.Add( 'Pedido de conexão negado.') ;
     TcpServer.MaxConnectionReply.Text.Add(
        'Número máximo de conexões ('+sedConexoesTCP.Text+') já atingido' ) ;

     rgFormaEmissao.ItemIndex := Ini.ReadInteger( 'Geral','FormaEmissao',0) ;
     ckSalvar.Checked    := Ini.ReadBool(   'Geral','Salvar'      ,True) ;
     edtPathLogs.Text    := Ini.ReadString( 'Geral','PathSalvar'  ,'') ;
     cbxImpressora.ItemIndex   := cbxImpressora.Items.IndexOf(Ini.ReadString( 'Geral','Impressora','0')) ;

     ACBrNFe1.Configuracoes.Geral.FormaEmissao := StrToTpEmis(OK,IntToStr(rgFormaEmissao.ItemIndex+1));
     ACBrNFe1.Configuracoes.Geral.Salvar       := ckSalvar.Checked;
     ACBrNFe1.Configuracoes.Geral.PathSalvar   := edtPathLogs.Text;

     cbUF.ItemIndex       := cbUF.Items.IndexOf(Ini.ReadString( 'WebService','UF','SP')) ;
     rgTipoAmb.ItemIndex  := Ini.ReadInteger( 'WebService','Ambiente'  ,0) ;
     ACBrNFe1.Configuracoes.WebServices.UF         := cbUF.Text;
     ACBrNFe1.Configuracoes.WebServices.Ambiente   := StrToTpAmb(Ok,IntToStr(rgTipoAmb.ItemIndex+1));

     {$IFDEF ACBrNFeOpenSSL}
     gbxCertificado.Height := 109;
     rgFormaEmissao.Top := 105;
     lblCaminho.Caption := 'Arquivo PFX';
     edtSenha.Visible := True;
     lblSenha.Visible := True;
     edtCaminho.Text  := Ini.ReadString( 'Certificado','Caminho' ,'') ;
     edtSenha.Text    := Ini.ReadString( 'Certificado','Senha'   ,'') ;
     ACBrNFe1.Configuracoes.Certificados.Certificado  := edtCaminho.Text;
     ACBrNFe1.Configuracoes.Certificados.Senha        := edtSenha.Text;
     {$ELSE}
     edtSenha.Visible := False;
     lblSenha.Visible := False;
     gbxCertificado.Height := 69;
     lblCaminho.Caption := 'Número de Série';
     edtCaminho.Text  := Ini.ReadString( 'Certificado','Caminho' ,'') ;
     ACBrNFe1.Configuracoes.Certificados.NumeroSerie := edtCaminho.Text;
     edtCaminho.Text := ACBrNFe1.Configuracoes.Certificados.NumeroSerie;
     {$ENDIF}

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
     edtSoftwareHouse.Text     := Ini.ReadString( 'DANFE','SoftwareHouse'   ,'') ;
     edtSiteEmpresa.Text       := Ini.ReadString( 'DANFE','Site'  ,'') ;
     edtEmailEmpresa.Text      := Ini.ReadString( 'DANFE','Email' ,'') ;
     edtFaxEmpresa.Text        := Ini.ReadString( 'DANFE','Fax'   ,'') ;
     cbxImpDescPorc.Checked    := Ini.ReadBool(   'DANFE','ImpDescPorc',False) ;
     cbxMostrarPreview.Checked := Ini.ReadBool(   'DANFE','MostrarPreview',False) ;
     edtNumCopia.Text          := Ini.ReadString( 'DANFE','Copias','1') ;
     edtMargemInf.Text         := Ini.ReadString( 'DANFE','Margem','0,8') ;
     edtPathPDF.Text           := Ini.ReadString( 'DANFE','PathPDF',PathWithDelim(ExtractFilePath(Application.ExeName))) ;

     if ACBrNFe1.DANFE <> nil then
      begin
        ACBrNFe1.DANFE.TipoDANFE  := StrToTpImp(OK,IntToStr(rgTipoDanfe.ItemIndex+1));
        ACBrNFe1.DANFE.Logo       := edtLogoMarca.Text;
        ACBrNFeDANFERave1.RavFile := PathWithDelim(ExtractFilePath(Application.ExeName))+'Report\DANFE_Rave513.rav';
        ACBrNFeDANFERave1.Sistema := edtSoftwareHouse.Text;
        ACBrNFeDANFERave1.Site    := edtSiteEmpresa.Text;
        ACBrNFeDANFERave1.Email   := edtEmailEmpresa.Text;
        ACBrNFeDANFERave1.Fax     := edtFaxEmpresa.Text;
        ACBrNFeDANFERave1.ImprimirDescPorc := cbxImpDescPorc.Checked;
        ACBrNFeDANFERave1.MostrarPreview   := cbxMostrarPreview.Checked;
        ACBrNFeDANFERave1.Impressora := cbxImpressora.Text;
        ACBrNFeDANFERave1.NumCopias  := StrToInt(edtNumCopia.Text);
        ACBrNFeDANFERave1.MargemInferior  := StrToFloat(edtMargemInf.Text);
        ACBrNFeDANFERave1.PathPDF    := edtPathPDF.Text;
      end;

     edtSmtpHost.Text      := Ini.ReadString( 'Email','Host'   ,'') ;
     edtSmtpPort.Text      := Ini.ReadString( 'Email','Port'   ,'') ;
     edtSmtpUser.Text      := Ini.ReadString( 'Email','User'   ,'') ;
     edtSmtpPass.Text      := StrCrypt(Ini.ReadString( 'Email','Pass'   ,''),IntToStr(fsHashSenha)) ;
     edtEmailAssunto.Text  := Ini.ReadString( 'Email','Assunto','') ;
     cbEmailSSL.Checked    := Ini.ReadBool(   'Email','SSL'    ,False) ;
     StreamMemo := TMemoryStream.Create;
     Ini.ReadBinaryStream( 'Email','Mensagem',StreamMemo) ;
     mmEmailMsg.Lines.LoadFromStream(StreamMemo);
     StreamMemo.Free;
  finally
     Ini.Free ;
  end ;

end;

procedure TfrmAcbrNfeMonitor.SalvarIni;
var
  Ini : TIniFile;
  StreamMemo : TMemoryStream;
  OldMonitoraTXT, OldMonitoraTCP : Boolean ;
begin
  if cbSenha.Checked and (edSenha.Text <> 'NADAAQUI') and (edSenha.Text <> '') then
     fsHashSenha := StringCrc16(edSenha.Text) ;

  Ini := TIniFile.Create( ACBrNFeMonitorINI ) ;
  try
     // Verificando se modificou o Modo de Monitoramento //
     OldMonitoraTCP := Ini.ReadBool('ACBrNFeMonitor','Modo_TCP',false) ;
     OldMonitoraTXT := Ini.ReadBool('ACBrNFeMonitor','Modo_TXT',false) ;

     // Parametros do Monitor //
     Ini.WriteBool('ACBrNFeMonitor','Modo_TCP',rbTCP.Checked);
     Ini.WriteBool('ACBrNFeMonitor','Modo_TXT',rbTXT.Checked);
     Ini.WriteInteger('ACBrNFeMonitor','TCP_Porta',StrToIntDef(edPortaTCP.Text,3434));
     Ini.WriteInteger('ACBrNFeMonitor','Conexoes_Simultaneas',sedConexoesTCP.Value);
     Ini.WriteString('ACBrNFeMonitor','TXT_Entrada',edEntTXT.Text);
     Ini.WriteString('ACBrNFeMonitor','TXT_Saida',edSaiTXT.Text);
     Ini.WriteInteger('ACBrNFeMonitor','Intervalo',sedIntervalo.Value);
     GravaINICrypt(INI,'ACBrNFeMonitor','HashSenha', IntToStrZero(fsHashSenha,8), _C) ;

     Ini.WriteBool('ACBrNFeMonitor','Gravar_Log',cbLog.Checked);
     Ini.WriteString('ACBrNFeMonitor','Arquivo_Log',edLogArq.Text);
     Ini.WriteInteger('ACBrNFeMonitor','Linhas_Log',sedLogLinhas.Value);

     Ini.WriteString( 'Certificado','Caminho' ,edtCaminho.Text) ;
     {$IFDEF ACBrNFeOpenSSL}
     Ini.WriteString( 'Certificado','Senha'   ,edtSenha.Text) ;
     {$ENDIF}

     Ini.WriteInteger( 'Geral','DANFE'       ,rgTipoDanfe.ItemIndex) ;
     Ini.WriteInteger( 'Geral','FormaEmissao',rgFormaEmissao.ItemIndex) ;
     Ini.WriteString( 'Geral','LogoMarca'   ,edtLogoMarca.Text) ;
     Ini.WriteBool(   'Geral','Salvar'      ,ckSalvar.Checked) ;
     Ini.WriteString( 'Geral','PathSalvar'  ,edtPathLogs.Text) ;
     Ini.WriteString('Geral','Impressora'  ,cbxImpressora.Text) ;

     Ini.WriteString( 'WebService','UF'        ,cbUF.Text) ;
     Ini.WriteInteger( 'WebService','Ambiente'  ,rgTipoAmb.ItemIndex) ;

     Ini.WriteString( 'Proxy','Host'   ,edtProxyHost.Text) ;
     Ini.WriteString( 'Proxy','Porta'  ,edtProxyPorta.Text) ;
     Ini.WriteString( 'Proxy','User'   ,edtProxyUser.Text) ;
     Ini.WriteString( 'Proxy','Pass'   ,edtProxySenha.Text) ;

     Ini.WriteString( 'Email','Host'    ,edtSmtpHost.Text) ;
     Ini.WriteString( 'Email','Port'    ,edtSmtpPort.Text) ;
     Ini.WriteString( 'Email','User'    ,edtSmtpUser.Text) ;
     Ini.WriteString( 'Email','Pass'    ,StrCrypt(edtSmtpPass.Text,IntToStr(fsHashSenha))) ;
     Ini.WriteString( 'Email','Assunto' ,edtEmailAssunto.Text) ;
     Ini.WriteBool(   'Email','SSL'     ,cbEmailSSL.Checked ) ;
     StreamMemo := TMemoryStream.Create;
     mmEmailMsg.Lines.SaveToStream(StreamMemo);
     StreamMemo.Seek(0,soFromBeginning);
     Ini.WriteBinaryStream( 'Email','Mensagem',StreamMemo) ;
     StreamMemo.Free;

     Ini.WriteString( 'DANFE','SoftwareHouse',edtSoftwareHouse.Text) ;
     Ini.WriteString( 'DANFE','Site' ,edtSiteEmpresa.Text) ;
     Ini.WriteString( 'DANFE','Email',edtEmailEmpresa.Text) ;
     Ini.WriteString( 'DANFE','Fax'  ,edtFaxEmpresa.Text) ;
     Ini.WriteBool(   'DANFE','ImpDescPorc',cbxImpDescPorc.Checked);
     Ini.WriteBool(   'DANFE','MostrarPreview',cbxMostrarPreview.Checked);
     Ini.WriteString( 'DANFE','Copias'  ,edtNumCopia.Text) ;
     Ini.WriteString( 'DANFE','Margem'  ,edtMargemInf.Text) ;
     Ini.WriteString( 'DANFE','PathPDF'  ,edtPathPDF.Text) ;
  finally
     Ini.Free ;
  end ;

  if (OldMonitoraTXT <> rbTXT.Checked) or (OldMonitoraTCP <> rbTCP.Checked) then
  begin
     MessageDlg('O Método de Monitoramento do ACBrNFeMonitor foi modificado'+
                'Será necessário reinicar o ACBrNFeMonitor.',
                mtInformation, [mbOk],0) ;
     Application.Terminate ;
  end ;
end;

procedure TfrmAcbrNfeMonitor.Resposta(Comando, Resposta : string );
begin
  if rbTCP.Checked then
  begin
     if Assigned( Conexao ) then
     begin
        if Assigned( Conexao.Connection ) then
        begin
           Conexao.Connection.WriteLn(Resposta) ;
           Conexao.Connection.Write(#3) ;
        end;
     end ;
  end ;

  if rbTXT.Checked then
  begin
     { Primeiro salva em Temporário para que a gravação de todos os Bytes ocorra
       antes que a aplicação controladora do ACBrMonitor tente ler o arquivo de
       Resposta incompleto }
       TryDeleteFile( ArqSaiTMP, 1000 ) ; // Tenta apagar por até 1 segundo

     if FileExists(ArqSaiTXT) then
        RenameFile(ArqSaiTXT, ArqSaiTMP) ; { GravaArqResp faz append se arq. existir }
        WriteToTXT(ArqSaiTMP, Resposta);
        RenameFile(ArqSaiTMP, ArqSaiTXT) ;

  end ;

  mResp.Lines.BeginUpdate ;
  mResp.Lines.Add( Comando + sLineBreak + Resposta ) ;
  while mResp.Lines.Count > BufferMemoResposta do
     mResp.Lines.Delete(0) ;
  mResp.Lines.EndUpdate ;

  if cbLog.Checked then
     WriteToTXT(ArqLogTXT, Comando + sLineBreak + Resposta);
end;

procedure TfrmAcbrNfeMonitor.Processar;
var
  Linha : WideString;
begin
  if NewLines <> '' then
     mCmd.Lines.Add( NewLines ) ;

  NewLines := '' ;

  while mCmd.Lines.Count > 0 do
  begin
     Application.ProcessMessages ;

//     Linha := Trim( mCmd.Lines[0] );
//     mCmd.Lines.Delete(0);

     Linha := Trim( mCmd.Lines.Text );
     mCmd.Lines.Text := '';

     if Linha <> '' then
     begin
        sbProcessando.Panels[1].Text := Linha ;

        try
           if pos('.',Linha) = 0 then              { Comandos do ACBrMonitor }
              Linha := 'NFE.'+Linha ;

           Cmd.Comando := Linha ;

           if Cmd.Objeto = 'NFE' then
              DoACBrNFe( Cmd );

           Resposta(Linha, 'OK: '+Cmd.Resposta );
           
        except
           on E : Exception do
              Resposta(Linha, 'ERRO: '+E.Message );
        end ;

        sbProcessando.Panels[1].Text := '' ;
     end ;
  end ;
end;

procedure TfrmAcbrNfeMonitor.AddLinesLog ;
begin
  if fsLinesLog <> '' then
  begin
     mResp.Lines.Add( fsLinesLog );
     if cbLog.Checked then
        WriteToTXT(ArqLogTXT, fsLinesLog );
     fsLinesLog := '' ;
  end ;
end ;


procedure TfrmAcbrNfeMonitor.TrataErros(Sender: TObject; E: Exception);
begin
  mResp.Lines.Add( E.Message );
  if cbLog.Checked then
     WriteToTXT(ArqLogTXT, 'Exception: ' + E.Message);

  StatusBar1.Panels[0].Text := 'Exception' ;
end ;

procedure TfrmAcbrNfeMonitor.IconTray (var Msg: TMessage);
var
  Pt: TPoint;
begin
 if Msg.lParam = WM_RBUTTONDOWN then
  begin
     GetCursorPos (Pt);
     pmTray.Popup (Pt.x, Pt.y);
  end
 else if Msg.lParam = WM_LBUTTONDBLCLK then
  if Visible then
    Ocultar1.Click
  else
   Restaurar1.Click;

end;

procedure TfrmAcbrNfeMonitor.DoACBrTimer(Sender: TObject);
var
   SL    : TStringList ;
   RetFind   : Integer ;
   SearchRec : TSearchRec ;
   NomeArqEnt, NomeArqSai : String;
begin
  Timer1.Enabled := false;

  if Inicio then
  begin
     Inicializar ;
     exit;
  end ;

  try
     try
        NomeArqEnt := PathWithDelim(ExtractFileDir(ArqEntOrig)) + StringReplace(ExtractFileName(ArqEntOrig),ExtractFileExt(ArqEntOrig),'',[rfReplaceAll]) +'*'+ExtractFileExt(ArqEntOrig);
        RetFind := SysUtils.FindFirst( NomeArqEnt, faAnyFile, SearchRec) ;
        if (RetFind = 0) then
         begin
           NomeArqEnt := StringReplace(ExtractFileName(ArqEntOrig),ExtractFileExt(ArqEntOrig),'',[rfReplaceAll]);
           NomeArqSai := StringReplace(ExtractFileName(ArqSaiOrig),ExtractFileExt(ArqSaiOrig),'',[rfReplaceAll]);
           ArqEntTXT  := PathWithDelim(ExtractFileDir(ArqEntOrig)) + SearchRec.Name ;  { Arquivo de Requisicao }
           ArqSaiTXT  := PathWithDelim(ExtractFilePath(ArqSaiOrig))+StringReplace( ExtractFileName(LowerCase(ArqEntTXT)),LowerCase(NomeArqEnt),LowerCase(NomeArqSai),[rfReplaceAll]) ;
           ArqSaiTMP  := ChangeFileExt(ArqSaiTXT,'.tmp');
         end;  
     finally
        SysUtils.FindClose(SearchRec) ;
     end ;

     if FileExists( ArqEntTXT ) then  { Existe arquivo para ler ? }
     begin
       { Lendo em StringList temporário para nao apagar comandos nao processados }
       SL := TStringList.Create ;
       try
          SL.LoadFromFile( ArqEntTXT );
          TryDeleteFile( ArqEntTXT, 1000 ) ; // Tenta apagar por até 1 segundo

          mCmd.Lines.AddStrings( SL );
       finally
          SL.Free ;
       end ;
     end;

     Processar ;
  finally
     Timer1.Enabled := True;
  end ;
end;

procedure TfrmAcbrNfeMonitor.edOnlyNumbers(Sender: TObject;
  var Key: Char);
begin
  if not ( Key in ['0'..'9',#13,#8] ) then
     Key := #0 ;
end;

procedure TfrmAcbrNfeMonitor.FormCreate(Sender: TObject);
begin
  mResp.Clear ;
  mCmd.Clear ;
  Cmd       := TACBrNFeCmd.Create ;

  Inicio    := true ;
  ArqSaiTXT := '' ;
  ArqSaiTMP := '' ;
  ArqEntTXT := '' ;
  ArqLogTXT := '' ;
  Conexao   := nil ;
  NewLines  := '' ;

  { Criando TrayIcon, e copiando Icone do Form }
  Icon.Handle := LoadIcon (HInstance, 'MAINICON');
  nid.cbSize := sizeof (nid);
  nid.wnd := Handle;
  nid.uID := 1; // Identificador do ícone
  nid.uCallBAckMessage := wm_IconMessage;
  nid.hIcon := Icon.Handle;
  nid.szTip := 'ACBrNFeMonitor';
  nid.uFlags := nif_Message or
  nif_Icon or nif_Tip;
  Shell_NotifyIcon (NIM_ADD, @nid);

  Caption := 'ACBrMonitorNFe '+ Versao;
  PageControl1.ActivePageIndex := 0 ;

  Application.OnException        := TrataErros ;
  Application.OnMinimize         := Ocultar1Click ;
  Application.OnRestore          := Restaurar1Click ;
  Application.Title              := Caption ;
  Application.HintHidePause      := 5000 ;

  Timer1.Enabled := True ;
end;

procedure TfrmAcbrNfeMonitor.Restaurar1Click(Sender: TObject);
begin
  Application.ShowMainForm := true ;
  Visible := true ;
  Application.Restore ;
  Application.BringToFront ;
  Application.ProcessMessages ;
end;

procedure TfrmAcbrNfeMonitor.Ocultar1Click(Sender: TObject);
begin
  Visible := false ;
  Application.ShowMainForm := false ;

  Application.ProcessMessages ;
end;

procedure TfrmAcbrNfeMonitor.EncerrarMonitor1Click(Sender: TObject);
begin
  close ;
end;

procedure TfrmAcbrNfeMonitor.FormDestroy(Sender: TObject);
begin
  Cmd.Free ;
  nid.uFlags := 0;
  Shell_NotifyIcon (NIM_DELETE, @nid);
  Timer1.Enabled := false ;
end;

procedure TfrmAcbrNfeMonitor.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Timer1.Enabled := False ;

  TCPServer.OnDisconnect := nil ;
  TCPServer.Active       := False ;    { Desliga TCP }
end;

procedure TfrmAcbrNfeMonitor.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  CanClose := True ;

  if pConfig.Visible then
  begin
     MessageDlg('Por favor Salve ou Cancele as configurações '+#13+#10+
                'efetuadas antes de fechar o programa',
                 mtWarning,[mbOk],0 ) ;
     CanClose := false ;
  end ;

  if CanClose then
     CanClose := ( MessageDlg('Deseja realmente encerrar o '+#13+#10+
                              'ACBrNfeMonitor?',
                    mtConfirmation,[mbNo,mbYes] ,0 ) = mrYes );
end;

procedure TfrmAcbrNfeMonitor.btConfigClick(Sender: TObject);
begin
  if pConfig.Visible then
   begin
     SalvarIni ;
     EscondeConfig ;
     LerIni ; { Para as alteraçoes fazerem efeito }
   end
  else
     ExibeConfig ;
end;

procedure TfrmAcbrNfeMonitor.btMinimizarClick(Sender: TObject);
begin
  Ocultar1Click( Sender );
end;

procedure TfrmAcbrNfeMonitor.btCancelarClick(Sender: TObject);
begin
  EscondeConfig ;
  LerIni ;
end;

procedure TfrmAcbrNfeMonitor.rbTCPClick(Sender: TObject);
begin
  gbTCP.Enabled := rbTCP.Checked ;
  gbTXT.Enabled := rbTXT.Checked ;

  if rbTXT.Checked then
   begin
     if edENTTXT.Text = '' then
        edENTTXT.Text := 'ENTNFE.TXT' ;

     if edSAITXT.Text = '' then
        edSAITXT.Text := 'SAINFE.TXT' ;
   end
  else
   begin
     if edPortaTCP.Text = '' then
        edPortaTCP.Text := '3434' ;

     if sedConexoesTCP.Value <= 0 then
        sedConexoesTCP.Value := 1 ;
   end ;
end;

procedure TfrmAcbrNfeMonitor.cbSenhaClick(Sender: TObject);
begin
  gbSenha.Enabled := cbSenha.Checked ;
  if not cbSenha.Checked then
  begin
     fsHashSenha  := -1 ;
     edSenha.Text :=  '' ;
  end ;
end;

procedure TfrmAcbrNfeMonitor.cbLogClick(Sender: TObject);
begin
  gbLog.Enabled := cbLog.Checked ;

  if cbLog.Checked and (edLogArq.Text = '') then
     edLogArq.Text := 'LOG.TXT' ;
end;

procedure TfrmAcbrNfeMonitor.TCPServerConnect(AThread: TIdPeerThread);
begin
  sleep(100);
  Conexao := AThread;
  mCmd.Lines.Clear ;
  Resposta('','ACBrNFeMonitor Ver. '+ Versao +sLineBreak +
              'Conectado em: '+FormatDateTime('dd/mm/yy hh:nn:ss', now )+sLineBreak+
              'Máquina: '+AThread.Connection.Socket.Binding.PeerIP+sLineBreak+
              'Esperando por comandos.');
end;

procedure TfrmAcbrNfeMonitor.TCPServerDisconnect(AThread: TIdPeerThread);
begin
  mResp.Lines.Add('ALERTA: Fim da Conexão com: '+
                   AThread.Connection.Socket.Binding.PeerIP+
                  ' em: '+FormatDateTime('dd/mm/yy hh:nn:ss', now ) )
end;

procedure TfrmAcbrNfeMonitor.TCPServerExecute(AThread: TIdPeerThread);
Var
  SL : TStringList;
begin
  { Le o que foi enviado atravez da conexao TCP }
  SL := TStringList.Create ;
  try
     AThread.Connection.Capture( SL );
     NewLines:= SL.Text;
     AThread.Synchronize( Processar );
  finally
     SL.Free ;
  end ;
end;

procedure TfrmAcbrNfeMonitor.sbArquivoCertClick(Sender: TObject);
begin
 {$IFDEF ACBrNFeOpenSSL}
  OpenDialog1.Title := 'Selecione o Certificado';
  OpenDialog1.DefaultExt := '*.pfx';
  OpenDialog1.Filter := 'Arquivos PFX (*.pfx)|*.pfx|Todos os Arquivos (*.*)|*.*';
  OpenDialog1.InitialDir := ExtractFileDir(application.ExeName);
  if OpenDialog1.Execute then
   begin
    edtCaminho.Text := OpenDialog1.FileName;
   end;
  {$ELSE}
   edtCaminho.Text := ACBrNFe1.Configuracoes.Certificados.SelecionarCertificado;
  {$ENDIF}
end;

procedure TfrmAcbrNfeMonitor.sbLogoMarcaClick(Sender: TObject);
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

procedure TfrmAcbrNfeMonitor.sbPathSalvarClick(Sender: TObject);
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

procedure TfrmAcbrNfeMonitor.btnStatusServClick(Sender: TObject);
begin
 ACBrNFe1.WebServices.StatusServico.Executar;
 ExibeResp(ACBrNFe1.WebServices.StatusServico.RetWS);
end;

procedure TfrmAcbrNfeMonitor.btnConsultarClick(Sender: TObject);
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
    ExibeResp(ACBrNFe1.WebServices.Consulta.RetWS);
  end;
end;

procedure TfrmAcbrNfeMonitor.btnCancNFClick(Sender: TObject);
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
     ExibeResp(ACBrNFe1.WebServices.Cancelamento.RetWS);
  end;
end;

procedure TfrmAcbrNfeMonitor.btnValidarXMLClick(Sender: TObject);
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

procedure TfrmAcbrNfeMonitor.btnImprimirClick(Sender: TObject);
begin
  OpenDialog1.Title := 'Selecione a NFE';
  OpenDialog1.DefaultExt := '*-nfe.XML';
  OpenDialog1.Filter := 'Arquivos NFE (*-nfe.XML)|*-nfe.XML|Arquivos XML (*.XML)|*.XML|Todos os Arquivos (*.*)|*.*';
  OpenDialog1.InitialDir := ACBrNFe1.Configuracoes.Geral.PathSalvar;
  if OpenDialog1.Execute then
  begin
    ACBrNFe1.NotasFiscais.Clear;
    ACBrNFe1.NotasFiscais.LoadFromFile(OpenDialog1.FileName);
    ACBrNFe1.NotasFiscais.Imprimir;
  end;
end;

procedure TfrmAcbrNfeMonitor.btnInutilizarClick(Sender: TObject);
var
 CNPJ, Modelo, Serie, Ano, NumeroInicial, NumeroFinal, Justificativa : String;
begin
 if not(InputQuery('WebServices Inutilização ', 'CNPJ',   CNPJ)) then
    exit;
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
  ACBrNFe1.WebServices.Inutiliza(CNPJ, Justificativa, StrToInt(Ano), StrToInt(Modelo), StrToInt(Serie), StrToInt(NumeroInicial), StrToInt(NumeroFinal));
  ExibeResp(ACBrNFe1.WebServices.Inutilizacao.RetWS);
end;

procedure TfrmAcbrNfeMonitor.btnEnviarClick(Sender: TObject);
var
 vAux : String;
begin
  if not(InputQuery('WebServices Enviar', 'Numero do Lote', vAux)) then
    exit;
  OpenDialog1.Title := 'Selecione a NFE';
  OpenDialog1.DefaultExt := '*-nfe.XML';
  OpenDialog1.Filter := 'Arquivos NFE (*-nfe.XML)|*-nfe.XML|Arquivos XML (*.XML)|*.XML|Todos os Arquivos (*.*)|*.*';
  OpenDialog1.InitialDir := ACBrNFe1.Configuracoes.Geral.PathSalvar;
  if OpenDialog1.Execute then
  begin
    ACBrNFe1.NotasFiscais.Clear;
    ACBrNFe1.NotasFiscais.LoadFromFile(OpenDialog1.FileName);
    ACBrNFe1.Enviar(StrToInt(vAux));
    ExibeResp(ACBrNFe1.WebServices.Retorno.RetWS);
  end;
end;

procedure TfrmAcbrNfeMonitor.edtNumCopiaKeyPress(Sender: TObject;
  var Key: Char);
begin
  if ((Key in ['0'..'9'] = False) and (Word(Key) <> VK_BACK)) then
    Key := #0;
end;

procedure TfrmAcbrNfeMonitor.edtMargemInfKeyPress(Sender: TObject;
  var Key: Char);
begin
  if (((Key in ['0'..'9'] = False) and (Key in ['.',','] = false)) and (Word(Key) <> VK_BACK)) then
    Key := #0
  else
    if Key = '.' then
       Key := ',';  
end;

procedure TfrmAcbrNfeMonitor.sbPathPDFClick(Sender: TObject);
var
  Dir: string;
begin
  if Length(edtPathPDF.Text) <= 0 then
     Dir := ExtractFileDir(application.ExeName)
  else
     Dir := edtPathPDF.Text;

  if SelectDirectory(Dir, [sdAllowCreate, sdPerformCreate, sdPrompt],SELDIRHELP) then
    edtPathPDF.Text := Dir;
end;

end.
