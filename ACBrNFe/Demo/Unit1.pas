unit Unit1;

interface

uses IniFiles,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Buttons, ComCtrls, OleCtrls, SHDocVw,
  ACBrNFe, ACBrNFeTypes;

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
    Label3: TLabel;
    Label4: TLabel;
    cbDanfe: TComboBox;
    cbFormaEmissao: TComboBox;
    GroupBox4: TGroupBox;
    Label5: TLabel;
    Label6: TLabel;
    ckVisualizar: TCheckBox;
    cbAmbiente: TComboBox;
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
    ACBrNFe1: TACBrNFe;
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
    btnGerarXMLNFe: TButton;
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
    procedure btnGerarXMLNFeClick(Sender: TObject);
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

uses FileCtrl, ACBrNFeDadosProdutos;

const
  SELDIRHELP = 1000;

{$R *.dfm}

procedure TForm1.GravarConfiguracao;
Var IniFile : String ;
    Ini     : TIniFile ;
begin
  IniFile := ChangeFileExt( Application.ExeName, '.ini') ;

  Ini := TIniFile.Create( IniFile );
  try
      Ini.WriteString( 'Certificado','Caminho' ,edtCaminho.Text) ;
      Ini.WriteString( 'Certificado','Senha'   ,edtSenha.Text) ;
      Ini.WriteString( 'Certificado','NumSerie',edtNumSerie.Text) ;

      Ini.WriteString( 'Geral','DANFE'       ,cbDanfe.Text) ;
      Ini.WriteString( 'Geral','FormaEmissao',cbFormaEmissao.Text) ;
      Ini.WriteString( 'Geral','LogoMarca'   ,edtLogoMarca.Text) ;
      Ini.WriteBool(   'Geral','Salvar'      ,ckSalvar.Checked) ;
      Ini.WriteString( 'Geral','PathSalvar'  ,edtPathLogs.Text) ;

      Ini.WriteString( 'WebService','UF'        ,cbUF.Text) ;
      Ini.WriteString( 'WebService','Ambiente'  ,cbAmbiente.Text) ;
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
  finally
     Ini.Free ;
  end;

end;

procedure TForm1.LerConfiguracao;
Var IniFile  : String ;
    Ini     : TIniFile ;
begin
  IniFile := ChangeFileExt( Application.ExeName, '.ini') ;

  Ini := TIniFile.Create( IniFile );
  try
{$IFNDEF ACBrNFeCAPICOM}
      edtCaminho.Text  := Ini.ReadString( 'Certificado','Caminho' ,'') ;
      edtSenha.Text    := Ini.ReadString( 'Certificado','Senha'   ,'') ;
      ACBrNFe1.Configuracoes.Certificados.Certificado  := edtCaminho.Text;
      ACBrNFe1.Configuracoes.Certificados.Senha        := edtSenha.Text;
      edtNumSerie.Visible := False;
      Label25.Visible := False;
{$ELSE}
      edtNumSerie.Text := Ini.ReadString( 'Certificado','NumSerie','') ;
      ACBrNFe1.Configuracoes.Certificados.NumeroSerie := edtNumSerie.Text;
      Label1.Caption := 'Informe o número de série do certificado'#13+
                        'Disponível no Internet Explorer no menu'#13+
                        'Ferramentas - Opções da Internet - Conteúdo '#13+
                        'Certificados - Exibir - Detalhes - Número do certificado'#13+
                        'É necessario retirar os espaços em branco '#13+
                        'e as letras para maiúsculo';
      Label2.Visible := False;
      edtCaminho.Visible := False;
      edtSenha.Visible   := False;
      sbtnCaminhoCert.Visible := False;
{$ENDIF}

      cbDanfe.Text        := Ini.ReadString( 'Geral','DANFE'       ,'Retrato') ;
      cbFormaEmissao.Text :=Ini.ReadString( 'Geral','FormaEmissao','Normal on-line') ;
      edtLogoMarca.Text   := Ini.ReadString( 'Geral','LogoMarca'   ,'') ;
      ckSalvar.Checked    := Ini.ReadBool(   'Geral','Salvar'      ,True) ;
      edtPathLogs.Text    := Ini.ReadString( 'Geral','PathSalvar'  ,'') ;
      ACBrNFe1.Configuracoes.Geral.DANFE        := cbDanfe.Text;
      ACBrNFe1.Configuracoes.Geral.FormaEmissao := cbFormaEmissao.Text;
      ACBrNFe1.Configuracoes.Geral.LogoMarca    := edtLogoMarca.Text;
      ACBrNFe1.Configuracoes.Geral.Salvar       := ckSalvar.Checked;
      ACBrNFe1.Configuracoes.Geral.PathSalvar   := edtPathLogs.Text;

      cbUF.ItemIndex       := cbUF.Items.IndexOf(Ini.ReadString( 'WebService','UF','SP')) ;
      cbAmbiente.Text      := Ini.ReadString( 'WebService','Ambiente'  ,'Teste') ;
      ckVisualizar.Checked :=Ini.ReadBool(    'WebService','Visualizar',False) ;
      ACBrNFe1.Configuracoes.WebServices.UF         := cbUF.Text;
      ACBrNFe1.Configuracoes.WebServices.Ambiente   := cbAmbiente.Text;
      ACBrNFe1.Configuracoes.WebServices.Visualizar := ckVisualizar.Checked;

{$IFNDEF ACBrNFeCAPICOM}
      edtProxyHost.Text  := Ini.ReadString( 'Proxy','Host'   ,'') ;
      edtProxyPorta.Text := Ini.ReadString( 'Proxy','Porta'  ,'') ;
      edtProxyUser.Text  := Ini.ReadString( 'Proxy','User'   ,'') ;
      edtProxySenha.Text := Ini.ReadString( 'Proxy','Pass'   ,'') ;
      ACBrNFe1.Configuracoes.WebServices.ProxyHost := edtProxyHost.Text;
      ACBrNFe1.Configuracoes.WebServices.ProxyPort := edtProxyPorta.Text;
      ACBrNFe1.Configuracoes.WebServices.ProxyUser := edtProxyUser.Text;
      ACBrNFe1.Configuracoes.WebServices.ProxyPass := edtProxySenha.Text;
{$ELSE}
      gbProxy.Visible := False;      
{$ENDIF}

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
  OpenDialog1.DefaultExt := '*.jpg';
  OpenDialog1.Filter := 'Arquivos JPG (*.jpg)|*.pfx|Todos os Arquivos (*.*)|*.*';
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
 ShowMessage(ACBrNFe1.WebServices.StatusServico.Msg);
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
    ACBrNFe1.NotasFiscais.Add.XML.LoadFromFile(OpenDialog1.FileName);
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
    ACBrNFe1.NotasFiscais.Add.XML.LoadFromFile(OpenDialog1.FileName);
    if not(InputQuery('WebServices Cancelamento', 'Justificativa', vAux)) then
       exit;
     ACBrNFe1.Cancelamento(vAux);
     MemoResp.Lines.Text :=  UTF8Encode(ACBrNFe1.WebServices.Cancelamento.RetWS);
     LoadXML(MemoResp, WBResposta);
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
    ACBrNFe1.NotasFiscais.Add.XML.LoadFromFile(OpenDialog1.FileName);
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
    ACBrNFe1.NotasFiscais.Add.XML.LoadFromFile(OpenDialog1.FileName);
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

  with ACBrNFe1.NotasFiscais.Add do
  begin
    Identificacao.NaturezaOperacao  := 'VENDA PRODUCAO DO ESTAB.';
    Identificacao.Codigo            := StrToInt(vAux);
    Identificacao.Numero            := StrToInt(vAux);
    Identificacao.Serie             := 1;
    Identificacao.DataEmissao       := Date;
    Identificacao.DataSaida         := Date;
    Identificacao.Tipo              := tSaida;
    Identificacao.FormaPagamento    := pgAVista;

    Emitente.CNPJ                      := edtEmitCNPJ.Text;
    Emitente.IE                        := edtEmitIE.Text;
    Emitente.Nome.RazaoSocial          := edtEmitRazao.Text;
    Emitente.Nome.Fantasia             := edtEmitFantasia.Text;
    Emitente.Endereco.Fone             := edtEmitFone.Text;
    Emitente.Endereco.CEP              := edtEmitCEP.Text;
    Emitente.Endereco.Logradouro       := edtEmitLogradouro.Text;
    Emitente.Endereco.Numero           := edtEmitNumero.Text;
    Emitente.Endereco.Complemento      := edtEmitComp.Text;
    Emitente.Endereco.Bairro           := edtEmitBairro.Text;
    Emitente.Endereco.Cidade.Codigo    := StrToInt(edtEmitCodCidade.Text);
    Emitente.Endereco.Cidade.Descricao := edtEmitCidade.Text;
    Emitente.Endereco.UF               := edtEmitUF.Text;

    Destinatario.CNPJCPF                   := '05481336000137';
    Destinatario.Endereco.CEP              := '18270410';
    Destinatario.Endereco.Logradouro       := 'Praça Anita Costa';
    Destinatario.Endereco.Numero           := '0034';
    Destinatario.Endereco.Complemento      := '';
    Destinatario.Endereco.Bairro           := 'Centro';
    Destinatario.Endereco.Cidade.Codigo    := 3554003;
    Destinatario.Endereco.Cidade.Descricao := 'Tatuí';
    Destinatario.Endereco.UF               := 'SP';
    Destinatario.Endereco.Fone             := '1532599600';
    Destinatario.IE                        := '687138770110';
    Destinatario.NomeRazao                 := 'D.J. COM. E LOCAÇÃO DE SOFTWARES LTDA - ME';

    with DadosProdutos.Add do
    begin
      CFOP          := 5101;
      Codigo        := '67';
      Descricao     := 'ALHO 400 G';
      Quantidade    := 100;
      Unidade       := 'KG';
      ValorTotal    := 100;
      ValorUnitario := 10;
      with Tributos do
      begin
        with ICMS do
        begin
          CST := '00';
          ICMS00.Aliquota  := 18;
          ICMS00.Valor     := 180;
          ICMS00.ValorBase := 1000;
        end;

      end;
    end;

    with DadosProdutos.Add do
    begin
      CFOP          := 5101;
      Codigo        := '68';
      Descricao     := 'CEBOLA';
      Quantidade    := 100;
      Unidade       := 'KG';
      ValorTotal    := 100;
      ValorUnitario := 10;
      with Tributos do
      begin
        with ICMS do
        begin
          CST := '00';
          ICMS00.Aliquota  := 18;
          ICMS00.Valor     := 180;
          ICMS00.ValorBase := 1000;
        end;
      end;
    end;

    with DadosProdutos.Add do
    begin
      CFOP          := 5101;
      Codigo        := '69';
      Descricao     := 'SAL';
      Quantidade    := 100;
      Unidade       := 'KG';
      ValorTotal    := 100;
      ValorUnitario := 10;
      with Tributos do
      begin
        with ICMS do
        begin
          CST := '00';
          ICMS00.Aliquota  := 18;
          ICMS00.Valor     := 180;
          ICMS00.ValorBase := 1000;
        end;
      end;
    end;

    ValoresTotais.BaseICMS     := 3000;
    ValoresTotais.ValorICMS    := 540;
    ValoresTotais.ValorNota    := 3000;
    ValoresTotais.ValorProduto := 3000;
  end;

  ACBrNFe1.Enviar(0);
  MemoResp.Lines.Text := UTF8Encode(ACBrNFe1.WebServices.Retorno.RetWS);
  LoadXML(MemoResp, WBResposta);    
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

procedure TForm1.btnGerarXMLNFeClick(Sender: TObject);
var
 vAux : String;
begin
 if not(InputQuery('WebServices Enviar', 'Numero da Nota', vAux)) then
    exit;

  ACBrNFe1.NotasFiscais.Clear;

  with ACBrNFe1.NotasFiscais.Add do
  begin
    Identificacao.NaturezaOperacao  := 'VENDA PRODUCAO DO ESTAB.';
    Identificacao.Codigo            := StrToInt(vAux);
    Identificacao.Numero            := StrToInt(vAux);
    Identificacao.Serie             := 1;
    Identificacao.DataEmissao       := Date;
    Identificacao.DataSaida         := Date;
    Identificacao.Tipo              := tSaida;
    Identificacao.FormaPagamento    := pgAVista;

    Emitente.CNPJ                      := edtEmitCNPJ.Text;
    Emitente.IE                        := edtEmitIE.Text;
    Emitente.Nome.RazaoSocial          := edtEmitRazao.Text;
    Emitente.Nome.Fantasia             := edtEmitFantasia.Text;
    Emitente.Endereco.Fone             := edtEmitFone.Text;
    Emitente.Endereco.CEP              := edtEmitCEP.Text;
    Emitente.Endereco.Logradouro       := edtEmitLogradouro.Text;
    Emitente.Endereco.Numero           := edtEmitNumero.Text;
    Emitente.Endereco.Complemento      := edtEmitComp.Text;
    Emitente.Endereco.Bairro           := edtEmitBairro.Text;
    Emitente.Endereco.Cidade.Codigo    := StrToInt(edtEmitCodCidade.Text);
    Emitente.Endereco.Cidade.Descricao := edtEmitCidade.Text;
    Emitente.Endereco.UF               := edtEmitUF.Text;

    Destinatario.CNPJCPF                   := '05481336000137';
    Destinatario.Endereco.CEP              := '18270410';
    Destinatario.Endereco.Logradouro       := 'Praça Anita Costa';
    Destinatario.Endereco.Numero           := '0034';
    Destinatario.Endereco.Complemento      := '';
    Destinatario.Endereco.Bairro           := 'Centro';
    Destinatario.Endereco.Cidade.Codigo    := 3554003;
    Destinatario.Endereco.Cidade.Descricao := 'Tatuí';
    Destinatario.Endereco.UF               := 'SP';
    Destinatario.Endereco.Fone             := '1532599600';
    Destinatario.IE                        := '687138770110';
    Destinatario.NomeRazao                 := 'D.J. COM. E LOCAÇÃO DE SOFTWARES LTDA - ME';

    with DadosProdutos.Add do
    begin
      CFOP          := 5101;
      Codigo        := '67';
      Descricao     := 'ALHO 400 G';
      Quantidade    := 100;
      Unidade       := 'KG';
      ValorTotal    := 100;
      ValorUnitario := 10;
      with Tributos do
      begin
        with ICMS do
        begin
          CST := '00';
          ICMS00.Aliquota  := 18;
          ICMS00.Valor     := 180;
          ICMS00.ValorBase := 1000;
        end;

      end;
    end;

    with DadosProdutos.Add do
    begin
      CFOP          := 5101;
      Codigo        := '68';
      Descricao     := 'CEBOLA';
      Quantidade    := 100;
      Unidade       := 'KG';
      ValorTotal    := 100;
      ValorUnitario := 10;
      with Tributos do
      begin
        with ICMS do
        begin
          CST := '00';
          ICMS00.Aliquota  := 18;
          ICMS00.Valor     := 180;
          ICMS00.ValorBase := 1000;
        end;
      end;
    end;

    with DadosProdutos.Add do
    begin
      CFOP          := 5101;
      Codigo        := '69';
      Descricao     := 'SAL';
      Quantidade    := 100;
      Unidade       := 'KG';
      ValorTotal    := 100;
      ValorUnitario := 10;
      with Tributos do
      begin
        with ICMS do
        begin
          CST := '00';
          ICMS00.Aliquota  := 18;
          ICMS00.Valor     := 180;
          ICMS00.ValorBase := 1000;
        end;
      end;
    end;

    ValoresTotais.BaseICMS     := 3000;
    ValoresTotais.ValorICMS    := 540;
    ValoresTotais.ValorNota    := 3000;
    ValoresTotais.ValorProduto := 3000;
  end;

  ACBrNFe1.NotasFiscais.GerarNFe;
  ACBrNFe1.NotasFiscais.Items[0].XML.SaveToFile(ExtractFileDir(application.ExeName)+ACBrNFe1.NotasFiscais.Items[0].XML.NFeChave+'-NFe.xml');
  MemoResp.Lines.LoadFromFile(ExtractFileDir(application.ExeName)+ACBrNFe1.NotasFiscais.Items[0].XML.NFeChave+'-NFe.xml');
  LoadXML(MemoResp, WBResposta);
end;

end.
