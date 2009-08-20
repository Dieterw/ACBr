{******************************************************************************}
{ Projeto: ACBr Monitor                                                        }
{  Executavel multiplataforma que faz usocdo conjunto de componentes ACBr para }
{ criar uma interface de comunicação com equipamentos de automacao comercial.  }
{                                                                              }
{ Direitos Autorais Reservados (c) 2006 Daniel Simoes de Almeida               }
{                                                                              }
{ Colaboradores nesse arquivo:     2005 Fábio Rogério Baía                     }
{                                                                              }
{  Você pode obter a última versão desse arquivo na página do Projeto ACBr     }
{ Componentes localizado em      http://www.sourceforge.net/projects/acbr      }
{                                                                              }
{  Este programa é software livre; você pode redistribuí-lo e/ou modificá-lo   }
{ sob os termos da Licença Pública Geral GNU, conforme publicada pela Free     }
{ Software Foundation; tanto a versão 2 da Licença como (a seu critério)       }
{ qualquer versão mais nova.                                                   }
{                                                                              }
{  Este programa é distribuído na expectativa de ser útil, mas SEM NENHUMA     }
{ GARANTIA; nem mesmo a garantia implícita de COMERCIALIZAÇÃO OU DE ADEQUAÇÃO A}
{ QUALQUER PROPÓSITO EM PARTICULAR. Consulte a Licença Pública Geral GNU para  }
{ obter mais detalhes. (Arquivo LICENCA.TXT ou LICENSE.TXT)                    }
{                                                                              }
{  Você deve ter recebido uma cópia da Licença Pública Geral GNU junto com este}
{ programa; se não, escreva para a Free Software Foundation, Inc., 59 Temple   }
{ Place, Suite 330, Boston, MA 02111-1307, USA. Você também pode obter uma     }
{ copia da licença em:  http://www.opensource.org/licenses/gpl-license.php     }
{                                                                              }
{ Daniel Simões de Almeida  -  daniel@djsystem.com.br  -  www.djsystem.com.br  }
{              Praça Anita Costa, 34 - Tatuí - SP - 18270-410                  }
{                                                                              }
{******************************************************************************}

{******************************************************************************
|* Historico ACBr Monitor
|*
|* 07/03/2005: Fabio Rogerio Baia
|*    Primeiros Esboços
|* 24/03/2005: Daniel Simoes de Almeida
|*    Migraçao para CLX
|* 06/02/2006: Daniel Simoes de Almeida
|*    Rotina GravaResposta otimizada para gravação em arquivos TXT
|* 10/07/2006: Daniel Simoes de Almeida
|*   - Corrigido Bug no interpretador de Comandos (na separação de parâmetros ,)
|*   - Melhorias na Interface.
|*   - Adicionada configuração para numero máximo de linhas no LOG. O Arquivo é
|*     ajustado sempre que o ACBrMonitor é iniciado
|*   - Adicionada configuração para Inverter o sinal da Gaveta de Dinheiro
|* 07/07/2009: Marcelo Correia Pinheiro
|*   - Adicionado suporte para leitura de parâmetros de configuração para
|*     impressoras de cheque
|* 21/07/2009: Marcelo Correia Pinheiro
|*   - Inclusão do componente ETQ na constante Objetos (linha 38),
|*     para prover suporte a etiquetas.
|* 06/08/2009: Marcelo Correia Pinheiro
|*   - DoECFUnit.pas: Correção na linha 401, onde o código atual envia o quarto
|*     parâmetro e não o terceiro, na chamada do método "RegistraItemNaoFiscal".
|*   - DoECFUnit.pas: Correção nas chamadas dos métodos ImprimirTexto e
|*     ImprimirBarras, onde a conversão para o tipo TACBrETQOrientacao gerava
|*     um erro no ACBrMonitor.
******************************************************************************}
{$DEFINE VisualCLX}
{$I ACBr.inc}

unit ACBrMonitor1;
interface

uses
  SysUtils, Classes, QForms, QStyle, Qt,
  QTrayIcon,                                { Unit para criar icone no Systray }
  CmdUnit,
  ACBrECF, ACBrECFClass, ACBrDIS, ACBrGAV, ACBrGAVClass, ACBrBase, ACBrDevice, 
  ACBrCHQ, ACBrLCB, ACBrRFD,                                    { Unit do ACBr }
  QDialogs, IdBaseComponent, IdComponent, IdTCPServer, QExtCtrls,
  QMenus, QTypes, QImgList, QButtons, QStdCtrls, QComCtrls, QControls,
  QGraphics, QMask, ACBrBAL, ACBrETQ;

const
   Estados : array[TACBrECFEstado] of string =
             ('Não Inicializada', 'Desconhecido', 'Livre', 'Venda',
              'Pagamento', 'Relatório', 'Bloqueada', 'Requer Z', 'Requer X',
              'Não Fiscal' );
   BufferMemoResposta = 1000 ;              { Maximo de Linhas no MemoResposta }
{$I versao.txt}
   _C = 'tYk*5W@' ;

type
  TFrmACBrMonitor = class(TForm)
    ACBrECF1: TACBrECF;
    StatusBar1: TStatusBar;
    ImageList1: TImageList;
    ACBrCHQ1: TACBrCHQ;
    ACBrGAV1: TACBrGAV;
    ACBrDIS1: TACBrDIS;
    pmTray: TPopupMenu;
    Restaurar1: TMenuItem;
    Encerrar1: TMenuItem;
    Ocultar1: TMenuItem;
    N1: TMenuItem;
    pBotoes: TPanel;
    btMinimizar: TBitBtn;
    bConfig: TBitBtn;
    ACBrLCB1: TACBrLCB;
    pPrincipal: TPanel;
    pCmd: TPanel;
    mCmd: TMemo;
    pTopCmd: TPanel;
    pRespostas: TPanel;
    mResp: TMemo;
    pTopRespostas: TPanel;
    Splitter1: TSplitter;
    pConfig: TPanel;
    PageControl1: TPageControl;
    tsMonitor: TTabSheet;
    cbLog: TCheckBox;
    gbTCP: TGroupBox;
    Label5: TLabel;
    edPortaTCP: TEdit;
    gbTXT: TGroupBox;
    Label6: TLabel;
    Label7: TLabel;
    edEntTXT: TEdit;
    edSaiTXT: TEdit;
    rbTCP: TRadioButton;
    rbTXT: TRadioButton;
    tsECF: TTabSheet;
    Label8: TLabel;
    cbECFModelo: TComboBox;
    Label9: TLabel;
    cbECFPorta: TComboBox;
    Label10: TLabel;
    chECFArredondaPorQtd: TCheckBox;
    bECFTestar: TBitBtn;
    bECFLeituraX: TBitBtn;
    bECFAtivar: TBitBtn;
    tsCHQ: TTabSheet;
    Label12: TLabel;
    cbCHQModelo: TComboBox;
    Label13: TLabel;
    cbCHQPorta: TComboBox;
    bCHQTestar: TBitBtn;
    chCHQVerForm: TCheckBox;
    tsGAV: TTabSheet;
    Label15: TLabel;
    cbGAVModelo: TComboBox;
    Label16: TLabel;
    cbGAVPorta: TComboBox;
    bGAVAbrir: TBitBtn;
    bGAVEstado: TBitBtn;
    lGAVEstado: TLabel;
    Label21: TLabel;
    tsDIS: TTabSheet;
    Label17: TLabel;
    cbDISPorta: TComboBox;
    Label18: TLabel;
    cbDISModelo: TComboBox;
    bDISTestar: TBitBtn;
    bDISLimpar: TBitBtn;
    tsLCB: TTabSheet;
    cbLCBPorta: TComboBox;
    chLCBExcluirSufixo: TCheckBox;
    Label1: TLabel;
    Label2: TLabel;
    Label22: TLabel;
    bLCBAtivar: TBitBtn;
    Label23: TLabel;
    edLCBPreExcluir: TEdit;
    lLCBCodigoLido: TLabel;
    bCancelar: TBitBtn;
    Timer1: TTimer;
    TcpServer: TIdTCPServer;
    chECFDescrGrande: TCheckBox;
    Label24: TLabel;
    cbLCBSufixoLeitor: TComboBox;
    cbGAVStrAbre: TComboBox;
    bExecECFTeste: TBitBtn;
    Bevel1: TBevel;
    Label11: TLabel;
    cbComandos: TCheckBox;
    sbProcessando: TStatusBar;
    chECFSinalGavetaInvertido: TCheckBox;
    gbSenha: TGroupBox;
    edSenha: TEdit;
    gbLog: TGroupBox;
    edLogArq: TEdit;
    Label4: TLabel;
    Label26: TLabel;
    sedIntervalo: TSpinEdit;
    sedLogLinhas: TSpinEdit;
    sedECFTimeout: TSpinEdit;
    sedLCBIntervalo: TSpinEdit;
    sedConexoesTCP: TSpinEdit;
    Label27: TLabel;
    sedGAVIntervaloAbertura: TSpinEdit;
    bGAVAtivar: TBitBtn;
    Label28: TLabel;
    cbGAVAcaoAberturaAntecipada: TComboBox;
    gbCHQDados: TGroupBox;
    Label14: TLabel;
    edCHQFavorecido: TEdit;
    Label29: TLabel;
    edCHQCidade: TEdit;
    edCHQBemafiINI: TEdit;
    Label30: TLabel;
    sbCHQBemafiINI: TSpeedButton;
    OpenDialog1: TOpenDialog;
    bLCBSerial: TBitBtn;
    Bevel2: TBevel;
    lAdSufixo: TLabel;
    cbLCBSufixo: TComboBox;
    Bevel3: TBevel;
    rbLCBTeclado: TRadioButton;
    rbLCBFila: TRadioButton;
    shpLCB: TShape;
    Label25: TLabel;
    sedECFIntervalo: TSpinEdit;
    cbLCBDispositivo: TComboBox;
    Label31: TLabel;
    seDISIntByte: TSpinEdit;
    GroupBox1: TGroupBox;
    Label19: TLabel;
    seDISIntervalo: TSpinEdit;
    Label20: TLabel;
    seDISPassos: TSpinEdit;
    bDISAnimar: TBitBtn;
    tsRFD: TTabSheet;
    pgConRFD: TPageControl;
    tsRFDSwH: TTabSheet;
    Label33: TLabel;
    Label34: TLabel;
    edSH_RazaoSocial: TEdit;
    edSH_COO: TEdit;
    Label35: TLabel;
    Label36: TLabel;
    Label37: TLabel;
    edSH_CNPJ: TEdit;
    edSH_IE: TEdit;
    edSH_IM: TEdit;
    Label38: TLabel;
    edSH_Aplicativo: TEdit;
    Label39: TLabel;
    edSH_NumeroAP: TEdit;
    Label40: TLabel;
    edSH_VersaoAP: TEdit;
    Label41: TLabel;
    edSH_Linha1: TEdit;
    Label42: TLabel;
    edSH_Linha2: TEdit;
    tsRFDINI: TTabSheet;
    Panel4: TPanel;
    bRFDINISalvar: TButton;
    mRFDINI: TMemo;
    tsRFDConfig: TTabSheet;
    chRFD: TCheckBox;
    Label32: TLabel;
    edRFDDir: TEdit;
    sbDirRFD: TSpeedButton;
    bRFDMF: TBitBtn;
    gbRFDECF: TGroupBox;
    Label43: TLabel;
    Label44: TLabel;
    cbRFDModelo: TComboBox;
    ACBrRFD1: TACBrRFD;
    Label45: TLabel;
    tsRFDRSA: TTabSheet;
    mRFDKey: TMemo;
    Panel1: TPanel;
    bRFDKeyImportar: TButton;
    lRFDID: TLabel;
    lRFDMarca: TLabel;
    tsRFDUsuario: TTabSheet;
    Label46: TLabel;
    edRFDRazaoSocial: TEdit;
    Label47: TLabel;
    edRFDCNPJ: TEdit;
    Label48: TLabel;
    edRFDIE: TEdit;
    Label49: TLabel;
    edRFDEndereco: TEdit;
    GroupBox2: TGroupBox;
    Label50: TLabel;
    seRFDNumeroCadastro: TSpinEdit;
    Label51: TLabel;
    Label52: TLabel;
    Label53: TLabel;
    seRFDCROCadastro: TSpinEdit;
    Label54: TLabel;
    bRFDINI: TButton;
    bRFDID: TButton;
    meRFDDataCadastro: TMaskEdit;
    meRFDHoraCadastro: TMaskEdit;
    edRFDGTCadastro: TEdit;
    cbSenha: TCheckBox;
    Label3: TLabel;
    bRFDRSAPrivada: TButton;
    bRFDRSAPublica: TButton;
    chRFDIgnoraMFD: TCheckBox;
    Label55: TLabel;
    edECFLog: TEdit;
    sbLog: TSpeedButton;
    sbECFLog: TSpeedButton;
    tsBAL: TTabSheet;
    Label56: TLabel;
    cbBALModelo: TComboBox;
    Label57: TLabel;
    cbBALPorta: TComboBox;
    Label58: TLabel;
    sedBALIntervalo: TSpinEdit;
    bBALAtivar: TBitBtn;
    bBALTestar: TBitBtn;
    ACBrBAL1: TACBrBAL;
    sbECFSerial: TSpeedButton;
    Label59: TLabel;
    meRFDDataSwBasico: TMaskEdit;
    meRFDHoraSwBasico: TMaskEdit;
    tsETQ: TTabSheet;
    Label60: TLabel;
    cbETQModelo: TComboBox;
    cbETQPorta: TComboBox;
    Label61: TLabel;
    ACBrETQ1: TACBrETQ;
    tsTC: TTabSheet;
    TCPServerTC: TIdTCPServer;
    Label63: TLabel;
    cbxTCModelo: TComboBox;
    Label62: TLabel;
    edTCPort: TEdit;
    Label64: TLabel;
    mTCConexoes: TMemo;
    Label65: TLabel;
    edTCArqPrecos: TEdit;
    sbTCArqPrecosEdit: TSpeedButton;
    bTCAtivar: TBitBtn;
    shpTC: TShape;
    sbTCArqPrecosFind: TSpeedButton;
    Label66: TLabel;
    edTCNaoEncontrado: TEdit;
    TimerTC: TTimer;
    sbCHQSerial: TSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure ACBrECF1MsgAguarde(Mensagem: String);
    procedure ACBrECF1MsgPoucoPapel(Sender: TObject);
    procedure bConfigClick(Sender: TObject);
    procedure cbLogClick(Sender: TObject);
    procedure edOnlyNumbers(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure bECFTestarClick(Sender: TObject);
    procedure bECFLeituraXClick(Sender: TObject);
    procedure bECFAtivarClick(Sender: TObject);
    procedure tsECFShow(Sender: TObject);
    procedure Ocultar1Click(Sender: TObject);
    procedure Restaurar1Click(Sender: TObject);
    procedure Encerrar1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cbGAVModeloChange(Sender: TObject);
    procedure cbGAVPortaChange(Sender: TObject);
    procedure bGAVEstadoClick(Sender: TObject);
    procedure bGAVAbrirClick(Sender: TObject);
    procedure cbDISModeloChange(Sender: TObject);
    procedure cbDISPortaChange(Sender: TObject);
    procedure bDISLimparClick(Sender: TObject);
    procedure bDISTestarClick(Sender: TObject);
    procedure btMinimizarClick(Sender: TObject);
    procedure rbTCPTXTClick(Sender: TObject);
    procedure cbCHQModeloChange(Sender: TObject);
    procedure cbCHQPortaChange(Sender: TObject);
    procedure cbECFModeloChange(Sender: TObject);
    procedure cbECFPortaChange(Sender: TObject);
    procedure chECFArredondaPorQtdClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure bCancelarClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure DoACBrTimer(Sender: TObject);
    procedure TcpServerExecute(AThread: TIdPeerThread);
    procedure TcpServerConnect(AThread: TIdPeerThread);
    procedure TcpServerDisconnect(AThread: TIdPeerThread);
    procedure chECFDescrGrandeClick(Sender: TObject);
    procedure bCHQTestarClick(Sender: TObject);
    procedure cbLCBPortaChange(Sender: TObject);
    procedure bLCBAtivarClick(Sender: TObject);
    procedure edLCBSufLeituraKeyPress(Sender: TObject; var Key: Char);
    procedure chLCBExcluirSufixoClick(Sender: TObject);
    procedure edLCBPreExcluirChange(Sender: TObject);
    procedure ACBrLCB1LeCodigo(Sender: TObject);
    procedure AumentaTempoHint(Sender: TObject);
    procedure DiminuiTempoHint(Sender: TObject);
    procedure cbLCBSufixoLeitorChange(Sender: TObject);
    procedure pBotoesClick(Sender: TObject);
    procedure FormShortCut(Key: Integer; Shift: TShiftState;
      var Handled: Boolean);
    procedure cbGAVStrAbreChange(Sender: TObject);
    procedure bExecECFTesteClick(Sender: TObject);
    procedure chECFSinalGavetaInvertidoClick(Sender: TObject);
    procedure sedLCBIntervaloChanged(Sender: TObject; NewValue: Integer);
    procedure sedECFTimeoutChanged(Sender: TObject; NewValue: Integer);
    procedure sedGAVIntervaloAberturaChanged(Sender: TObject;
      NewValue: Integer);
    procedure bGAVAtivarClick(Sender: TObject);
    procedure tsGAVShow(Sender: TObject);
    procedure cbGAVAcaoAberturaAntecipadaChange(Sender: TObject);
    procedure edCHQFavorecidoChange(Sender: TObject);
    procedure edCHQCidadeChange(Sender: TObject);
    procedure sbCHQBemafiINIClick(Sender: TObject);
    procedure edCHQBemafiINIExit(Sender: TObject);
    procedure ACBrECF1AguardandoRespostaChange(Sender: TObject);
    procedure bLCBSerialClick(Sender: TObject);
    procedure rbLCBTecladoClick(Sender: TObject);
    procedure tsLCBShow(Sender: TObject);
    procedure sedECFIntervaloChanged(Sender: TObject; NewValue: Integer);
    procedure seDISPassosChanged(Sender: TObject; NewValue: Integer);
    procedure seDISIntervaloChanged(Sender: TObject; NewValue: Integer);
    procedure seDISIntByteChanged(Sender: TObject; NewValue: Integer);
    procedure bDISAnimarClick(Sender: TObject);
    procedure bRFDINILerClick(Sender: TObject);
    procedure bRFDINISalvarClick(Sender: TObject);
    procedure bRFDMFClick(Sender: TObject);
    procedure chRFDClick(Sender: TObject);
    procedure edRFDDirChange(Sender: TObject);
    procedure sbDirRFDClick(Sender: TObject);
    procedure edSH_RazaoSocialChange(Sender: TObject);
    procedure edSH_COOChange(Sender: TObject);
    procedure edSH_CNPJChange(Sender: TObject);
    procedure edSH_IEChange(Sender: TObject);
    procedure edSH_IMChange(Sender: TObject);
    procedure edSH_AplicativoChange(Sender: TObject);
    procedure edSH_NumeroAPChange(Sender: TObject);
    procedure edSH_VersaoAPChange(Sender: TObject);
    procedure edSH_Linha1Change(Sender: TObject);
    procedure edSH_Linha2Change(Sender: TObject);
    procedure tsRFDShow(Sender: TObject);
    procedure bRFDKeyImportarClick(Sender: TObject);
    procedure ACBrRFD1GetKeyRSA(var PrivateKey_RSA: String);
    procedure cbRFDModeloChange(Sender: TObject);
    procedure bRFDIDClick(Sender: TObject);
    procedure tsRFDINIShow(Sender: TObject);
    procedure edRFDRazaoSocialChange(Sender: TObject);
    procedure edRFDCNPJChange(Sender: TObject);
    procedure edRFDEnderecoChange(Sender: TObject);
    procedure edRFDIEChange(Sender: TObject);
    procedure seRFDNumeroCadastroChanged(Sender: TObject;
      NewValue: Integer);
    procedure meRFDDataCadastroExit(Sender: TObject);
    procedure seRFDCROCadastroChanged(Sender: TObject; NewValue: Integer);
    procedure edRFDGTCadastroKeyPress(Sender: TObject; var Key: Char);
    procedure edRFDGTCadastroExit(Sender: TObject);
    procedure tsRFDUsuarioShow(Sender: TObject);
    procedure tsRFDRSAShow(Sender: TObject);
    procedure cbSenhaClick(Sender: TObject);
    procedure bRFDRSAPrivadaClick(Sender: TObject);
    procedure bRFDRSAPublicaClick(Sender: TObject);
    procedure pgConRFDPageChanging(Sender: TObject; NewPage: TTabSheet;
      var AllowChange: Boolean);
    procedure chRFDIgnoraMFDClick(Sender: TObject);
    procedure edECFLogChange(Sender: TObject);
    procedure sbLogClick(Sender: TObject);
    procedure sbECFLogClick(Sender: TObject);
    procedure cbBALModeloChange(Sender: TObject);
    procedure cbBALPortaChange(Sender: TObject);
    procedure sedBALIntervaloChanged(Sender: TObject; NewValue: Integer);
    procedure bBALAtivarClick(Sender: TObject);
    procedure bBALTestarClick(Sender: TObject);
    procedure sbECFSerialClick(Sender: TObject);
    procedure meRFDDataSwBasicoExit(Sender: TObject);
    procedure tsRFDConfigShow(Sender: TObject);
    procedure cbETQModeloChange(Sender: TObject);
    procedure cbETQPortaChange(Sender: TObject);
    procedure bTCAtivarClick(Sender: TObject);
    procedure TCPServerTCDisconnect(AThread: TIdPeerThread);
    procedure TCPServerTCExecute(AThread: TIdPeerThread);
    procedure tsTCShow(Sender: TObject);
    procedure cbxTCModeloChange(Sender: TObject);
    procedure sbTCArqPrecosEditClick(Sender: TObject);
    procedure sbTCArqPrecosFindClick(Sender: TObject);
    procedure TimerTCTimer(Sender: TObject);
    procedure TCPServerTCConnect(AThread: TIdPeerThread);
    procedure sbCHQSerialClick(Sender: TObject);
(*    procedure TCPServerTCConecta(const TCPBlockSocket: TTCPBlockSocket;
      var Enviar: String);
    procedure TCPServerTCDesConecta(
      const TCPBlockSocket: TTCPBlockSocket; Erro: Integer;
      ErroDesc: String);
    procedure TCPServerTCRecebeDados(
      const TCPBlockSocket: TTCPBlockSocket; const Recebido: String;
      var Enviar: String);*)
  private
    TrayIcon  : TTrayIcon ;
    ACBrMonitorINI : string;
    Inicio  : Boolean ;
    ArqSaiTXT, ArqSaiTMP, ArqEntTXT, ArqLogTXT : String ;
    Cmd : TACBrCmd ;
    NewLines : String ;
    fsDisWorking: Boolean;
    fsRFDIni: String ;
    fsRFDLeuParams: Boolean ;
    fsHashSenha:Integer;
    fsCNPJSWOK: Boolean ;
    TipoCMD : String ;
    pCanClose : Boolean ;

    fsSLPrecos : TStringList ;
    fsDTPrecos : Integer ;
    
    fsLinesLog : AnsiString ;


    procedure Inicializar ;
    procedure EscondeConfig ;
    procedure ExibeConfig ;
    procedure LerIni ;
    procedure SalvarIni ;
    procedure AjustaLinhasLog ;

    procedure LerSW ;
    function LerChaveSWH: String;
    procedure SalvarSW ;

    Procedure Processar ;
    Procedure Resposta(Comando, Resposta : string);

    Procedure AddLinesLog ;

    procedure TrataErros(Sender: TObject; E: Exception);

    procedure SetDisWorking(const Value: Boolean);
  public
    Conexao : TIdPeerThread ;

    property DISWorking : Boolean read fsDisWorking write SetDisWorking ;

    procedure AvaliaEstadoTsECF;
    procedure AvaliaEstadoTsGAV;
    procedure AvaliaEstadoTsLCB;
    procedure AvaliaEstadoTsRFD;
    procedure AvaliaEstadoTsBAL;
    procedure AvaliaEstadoTsTC;
  end;

var
  FrmACBrMonitor: TFrmACBrMonitor;

implementation

uses IniFiles, StrUtils, TypInfo, IdStack,
     UtilUnit,
     DoECFUnit, DoGAVUnit, DoCHQUnit, DoDISUnit, DoLCBUnit, DoACBrUnit, DoBALUnit,
     {$IFDEF MSWINDOWS} sndkey32, {$ENDIF}
     {$IFDEF LINUX} Libc, KernelIoctl, {$ENDIF}
     ACBrECFNaoFiscal, ACBrUtil, ACBrConsts, Math, Sobre, DateUtils,
     ConfiguraSerial,
     DoECFBemafi32, DoECFObserver , DoETQUnit;
{$R *.xfm}

{-------------------------------- TFrmACBrMonitor -----------------------------}
procedure TFrmACBrMonitor.FormCreate(Sender: TObject);
Var MemStream : TMemoryStream ;
    iECF : TACBrECFModelo ;
    iCHQ : TACBrCHQModelo ;
    iDIS : TACBrDISModelo ;
    iBAL : TACBrBALModelo ;
begin
  {$IFDEF LINUX}
   umask( 0 ) ;
  {$ENDIF}
  
  mResp.Clear ;
  mCmd.Clear ;
  Cmd       := TACBrCmd.Create ;
  Inicio    := true ;
  ArqSaiTXT := '' ;
  ArqSaiTMP := '' ;
  ArqEntTXT := '' ;
  ArqLogTXT := '' ;
  Conexao   := nil ;
  NewLines  := '' ;
  DISWorking:= false ;

  pCanClose      := False ;
  fsRFDIni       := '' ;
  fsRFDLeuParams := False ;
  fsCNPJSWOK     := False ;

  TipoCMD   := 'A' ; {Tipo de Comando A - ACBr, B - Bematech, D - Daruma}

  { Definindo constantes de Verdadeiro para TrueBoolsStrs }
  SetLength( TrueBoolStrs, 5 ) ;
  TrueBoolStrs[0] := DefaultTrueBoolStr;
  TrueBoolStrs[1] := 'T' ;
  TrueBoolStrs[2] := 'Verdadeiro' ;
  TrueBoolStrs[3] := 'V' ;
  TrueBoolStrs[4] := 'Ok' ;

  { Definindo constantes de Falso para FalseBoolStrs }
  SetLength(FalseBoolStrs, 3);
  FalseBoolStrs[0] := DefaultFalseBoolStr;
  FalseBoolStrs[1] := 'F' ;
  FalseBoolStrs[2] := 'Falso' ;

  { Criando lista modelos de ECFs disponiveis }
  cbECFModelo.Items.Clear ;
  cbECFModelo.Items.Add('Procurar') ;
  iECF := Low( TACBrECFModelo ) ;
  while iECF <= High( TACBrECFModelo ) do
  begin
     cbECFModelo.Items.Add(GetEnumName(TypeInfo(TACBrECFModelo),Integer(iECF))) ;
     Inc(iECF) ;
  end ;
  AvaliaEstadoTsECF ;

  AvaliaEstadoTsGAV ;

  AvaliaEstadoTsLCB ;

  AvaliaEstadoTsTC ;
  fsSLPrecos := TStringList.Create ;
  fsSLPrecos.NameValueSeparator := '|' ;
  fsDTPrecos := 0 ;

  { Criando lista modelos de Impres.Cheque disponiveis }
  cbCHQModelo.Items.Clear ;
  iCHQ := Low( TACBrCHQModelo ) ;
  while iCHQ <= High( TACBrCHQModelo ) do
  begin
     cbCHQModelo.Items.Add(GetEnumName(TypeInfo(TACBrCHQModelo),Integer(iCHQ))) ;
     Inc(iCHQ) ;
  end ;

  { Criando lista Displays disponiveis }
  cbDISModelo.Items.Clear ;
  iDIS := Low( TACBrDISModelo ) ;
  while iDIS <= High( TACBrDISModelo ) do
  begin
     cbDISModelo.Items.Add(GetEnumName(TypeInfo(TACBrDISModelo),Integer(iDIS))) ;
     Inc(iDIS) ;
  end ;

  { Criando lista Balanças disponiveis }
  cbBALModelo.Items.Clear ;
  iBAL := Low( TACBrBALModelo ) ;
  while iBAL <= High( TACBrBALModelo ) do
  begin
     cbBALModelo.Items.Add(GetEnumName(TypeInfo(TACBrBALModelo),Integer(iBAL))) ;
     Inc(iBAL) ;
  end ;

  { Criando TrayIcon, e copiando Icone do Form }
  MemStream := TMemoryStream.Create;
  try
     Icon.SaveToStream(MemStream);
     TrayIcon := TTrayIcon.Create(self);
     with TrayIcon do
     begin
        Icon.LoadFromStream(MemStream);
        PopupMenu   := pmTray ;
        ToolTip     := 'ACBrMonitor '+ Versao +
                        {$IFDEF LINUX}#10{$ELSE}#13{$ENDIF}+
                       'ACBr: '+ACBR_VERSAO ;
        OnDblClick  := Restaurar1Click ;
        OnClick     := Restaurar1Click ;
        ShowToolTip := true ;
        Masked      := true ;
        AutoShow    := true ;
        Visible     := true ;
     end ;
  finally
     MemStream.Free ;
  end ;

  Caption := 'ACBrMonitor '+ Versao + ' - ACBr: '+ACBR_VERSAO ;
  PageControl1.ActivePageIndex := 0 ;

  {$IFDEF LINUX}
   rbLCBTeclado.Caption := 'Dispositivo' ;
   cbLCBSufixo.Hint := 'Use a Sinaxe:  #NNN'+sLineBreak+
                       'Onde: NNN = Numero do caracter ASC em Decimal'+sLineBreak+
                       '      a adicionar no final do código lido.'+sLineBreak+sLineBreak+
                       'Para vários caracteres use a , (virgula) como separador'  ;
   cbLCBSufixo.Items.Clear ;
   cbLCBSufixo.Items.Add('#13 | Enter') ;
   cbLCBSufixo.Items.Add('#10 | LF') ;
   cbLCBSufixo.Items.Add('#13,#13 | 2 x Enter') ;
   cbLCBSufixo.Items.Add('#18 | PgUp') ;
   cbLCBSufixo.Items.Add('#09 | Tab') ;
   cbLCBSufixo.Items.Add('#24 | Down') ;
  {$ELSE}
   lAdSufixo.Caption := 'Adicionar Sufixo <b>SndKey32</b>' ;
  {$ENDIF}
  lAdSufixo.Hint := cbLCBSufixo.Hint ;

  chRFD.Font.Style := chRFD.Font.Style + [fsBold] ;
  chRFD.Font.Color := clRed ;
   
  Application.Style.DefaultStyle := dsPlatinum ;
  Application.OnException        := TrataErros ;
  Application.OnMinimize         := Ocultar1Click ;
  Application.OnRestore          := Restaurar1Click ;
  Application.Title              := Caption ;
  Application.HintHidePause      := 5000 ;

  Timer1.Enabled := True ;
end;

{------------------------------------------------------------------------------}
procedure TFrmACBrMonitor.FormDestroy(Sender: TObject);
begin
  Timer1.Enabled := false ;
  Cmd.Free ;
  fsSLPrecos.Free ;
end;

{------------------------------------------------------------------------------}
procedure TFrmACBrMonitor.FormShow(Sender: TObject);
begin
  TrayIcon.Show ;
end;

{------------------------------------------------------------------------------}
procedure TFrmACBrMonitor.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  CanClose := True ;

  if pConfig.Visible then
  begin
     MessageDlg('Por favor <b>Salve</b> ou <b>Cancele</b> as configurações '+
                'efetuadas antes de fechar o programa',
                 mtWarning,[mbOk],0 ) ;
     CanClose := false ;
  end ;

  CanClose := pCanClose ;

  if not CanClose then
     Application.Minimize ;
end;

{------------------------------------------------------------------------------}
procedure TFrmACBrMonitor.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  ACBrECF1.Desativar ;
  ACBrCHQ1.Desativar ;
  ACBrGAV1.Desativar ;
  ACBrDIS1.Desativar ;
  ACBrLCB1.Desativar ;
  ACBrBAL1.Desativar ;
  ACBrETQ1.Desativar ;

  Timer1.Enabled := False ;

  TcpServer.OnDisconnect := nil ;
  TCPServer.Active       := False ;    { Desliga TCP }

  TCPServerTC.OnDisconnect := nil ;
  TimerTC.Enabled          := False ;
  TCPServerTC.Active       := False ;    { Desliga TCP }
end;

{-----------------------------------------------------------------------------}
Procedure TFrmACBrMonitor.TrataErros(Sender: TObject; E: Exception);
begin
  mResp.Lines.Add( E.Message );
  if cbLog.Checked then
     WriteToTXT(ArqLogTXT, 'Exception: ' + E.Message);

  StatusBar1.Panels[0].Text := 'Exception' ;
//  MessageDlg( E.Message,mtError,[mbOk],0) ;
end ;

{------------------------------------------------------------------------------}
procedure TFrmACBrMonitor.TcpServerConnect(AThread: TIdPeerThread);
begin
  sleep(100);
  Conexao := AThread;
  mCmd.Lines.Clear ;
  Resposta('','ACBrMonitor Ver. '+ Versao + ' - ACBr: '+ACBR_VERSAO +sLineBreak +
              'Conectado em: '+FormatDateTime('dd/mm/yy hh:nn:ss', now )+sLineBreak+
              'Máquina: '+AThread.Connection.Socket.Binding.PeerIP+sLineBreak+
              'Esperando por comandos.');
end;

{------------------------------------------------------------------------------}
procedure TFrmACBrMonitor.TcpServerExecute(AThread: TIdPeerThread);
Var Cmd : String ;
begin
  { Le o que foi enviado atravez da conexao TCP }
  Cmd := trim(AThread.Connection.ReadLn()) ;
  if Cmd <> '' then
  begin
     Conexao := AThread ;
     NewLines:= Cmd  ;
     { precisa do Synchronize, pois "Processar" atualiza controles visuais }
     AThread.Synchronize( Processar );
//     Processar ;
  end ;
end;

{------------------------------------------------------------------------------}
procedure TFrmACBrMonitor.TcpServerDisconnect(AThread: TIdPeerThread);
begin
  mResp.Lines.Add('ALERTA: Fim da Conexão com: '+
                   AThread.Connection.Socket.Binding.PeerIP+
                  ' em: '+FormatDateTime('dd/mm/yy hh:nn:ss', now ) )
end;

{------------------------------------------------------------------------------}
procedure TFrmACBrMonitor.Restaurar1Click(Sender: TObject);
begin
  Application.ShowMainForm := true ;
  Visible := true ;
  {$IFDEF LINUX}
  WindowState := wsNormal ;
  {$ENDIF}
  Application.Restore ;
  Application.BringToFront ;
  Application.ProcessMessages ;
end;

{------------------------------------------------------------------------------}
procedure TFrmACBrMonitor.Ocultar1Click(Sender: TObject);
begin
  TrayIcon.Visible := false ;

//  if WindowState <> wsMinimized then
//     WindowState := wsMinimized ;
  Visible := false ;
  Application.ShowMainForm := false ;

  TrayIcon.Visible := true ;
  Application.ProcessMessages ;
end;

{------------------------------------------------------------------------------}
procedure TFrmACBrMonitor.Encerrar1Click(Sender: TObject);
begin
  pCanClose := True ;
  close ;
end;

{------------------------- Procedures de Uso Interno --------------------------}
procedure TFrmACBrMonitor.Inicializar;
Var Ini    : TIniFile ;
    ArqIni : String ;
    Txt    : String ;
    Erro   : String ;
    A : Integer ;
begin
  Timer1.Enabled := false ;
  Inicio         := false ;
  Erro           := '' ;
  ACBrMonitorINI := ExtractFilePath(Application.ExeName)+ 'ACBrMonitor.ini';

  if not FileExists( ACBrMonitorINI ) then //verifica se o arq. de config existe
  begin                                    //se nao existir vai para as configs
    MessageDlg('Bem vindo ao ACBrMonitor',
               'Bem vindo ao <font color=blue><b>ACBrMonitor</b></font>,<br><br>'+
               'Por favor configure o <font color=blue><b>ACBrMonitor</b></font>, '+
               'informando o <b>Método de Monitoramento</b>, e a configuração '+
               'dos <b>Equipamentos de Automação</b> ligados a essa máquina.'+
               '<br><br><font color=red><b>IMPORTANTE:</b></font> Após configurar o '+
               'Método de Monitoramento o <font color=blue><b>ACBrMonitor</b></font>'+
               ' deve ser <b>reiniciado</b>',mtInformation,[mbok],0) ;
    bConfig.Click ;
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
     bConfig.Enabled  := true ;
     Timer1.Interval  := sedIntervalo.Value ;
     Timer1.Enabled   := rbTXT.Checked ;
     TcpServer.Active := rbTCP.Checked ;

     mResp.Lines.Add('ACBr Monitor Ver.'+Versao);
     mResp.Lines.Add('Aguardando comandos ACBr');
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

     { Se for NAO fiscal, desliga o AVISO antes de ativar }
     if ACBrECF1.Modelo = ecfNaoFiscal then
     begin
        ArqIni := (ACBrECF1.ECF as TACBrECFNaoFiscal).NomeArqINI ;
        if FileExists( ArqIni ) then
        begin
           Ini := TIniFile.Create( ArqIni ) ;
           try
             Ini.WriteString('Variaveis','Aviso_Legal','NAO');
          finally
             Ini.Free ;
          end ;
        end ;
     end ;
  except
     on E : Exception do
        Erro := Erro + sLineBreak + E.Message ;
  end ;

  if Erro <> '' then
     Raise Exception.Create( Erro );
end;

{------------------------------------------------------------------------------}
procedure TFrmACBrMonitor.AjustaLinhasLog;
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

  // Ajustado LOG do ACBrMonitor //
  if (cbLog.Checked) then
     AjustaLogFile( ArqLogTXT, sedLogLinhas.Value );

  // Ajustado LOG do ECF //
  if (edECFLog.Text <> '')  then
     AjustaLogFile( edECFLog.Text, sedLogLinhas.Value );
end;

{------------------------------------------------------------------------------}
procedure TFrmACBrMonitor.LerIni ;
var Ini : TIniFile;
    ECFAtivado, CHQAtivado, GAVAtivado, DISAtivado, BALAtivado, ETQAtivado  : Boolean ;
    Senha, ECFDeviceParams, CHQDeviceParams :String ;
begin
  Ini := TIniFile.Create( ACBrMonitorINI ) ;

  ECFAtivado := ACBrECF1.Ativo ;
  CHQAtivado := ACBrCHQ1.Ativo ;
  GAVAtivado := ACBrGAV1.Ativo ;
  DISAtivado := ACBrDIS1.Ativo ;
  BALAtivado := ACBrBAL1.Ativo ;
  ETQAtivado := ACBrETQ1.Ativo ;

  try
     { Lendo Senha }
//     Ini.ReadString('ACBrMonitor','TXT_Saida','SAI.TXT');
     fsHashSenha := StrToIntDef( LeINICrypt(INI,'ACBrMonitor','HashSenha', _C), -1) ;

     if fsHashSenha < 1 then  { INI antigo não tinha essa chave }
     begin
        Senha := Ini.ReadString('ACBrMonitor','Senha','');
        if Senha <> '' then
           fsHashSenha := StringCrc16(Senha) ;
     end ;

     if fsHashSenha > 0 then
     begin
        cbSenha.Checked := True ;
        edSenha.Text    := 'NADAAQUI' ;
     end ;

     { Parametros do Monitor }
     rbTCP.Checked        := Ini.ReadBool('ACBrMonitor','Modo_TCP',false);
     rbTXT.Checked        := Ini.ReadBool('ACBrMonitor','Modo_TXT',false);
     edPortaTCP.Text      := IntToStr(Ini.ReadInteger('ACBrMonitor','TCP_Porta',3434));
     sedConexoesTCP.Value := Ini.ReadInteger('ACBrMonitor','Conexoes_Simultaneas',1);
     edEntTXT.Text        := Ini.ReadString('ACBrMonitor','TXT_Entrada','ENT.TXT');
     edSaiTXT.Text        := Ini.ReadString('ACBrMonitor','TXT_Saida','SAI.TXT');
     sedIntervalo.Value   := Ini.ReadInteger('ACBrMonitor','Intervalo',50);
     edLogArq.Text        := Ini.ReadString('ACBrMonitor','Arquivo_Log','LOG.TXT');
     cbLog.Checked        := Ini.ReadBool('ACBrMonitor','Gravar_Log',false) and
                           ( edLogArq.Text <> '' ) ;
     sedLogLinhas.Value   := Ini.ReadInteger('ACBrMonitor','Linhas_Log',0);
     cbComandos.Checked   := Ini.ReadBool('ACBrMonitor','Comandos_Remotos',false);

     ArqEntTXT := AcertaPath( edEntTXT.Text ) ;
     ArqSaiTXT := AcertaPath( edSaiTXT.Text ) ;
     ArqSaiTMP := ChangeFileExt( ArqSaiTXT, '.tmp' ) ;
     ArqLogTXT := AcertaPath( edLogArq.Text ) ;

     TcpServer.DefaultPort    := StrToInt( edPortaTCP.Text ) ;
     TcpServer.MaxConnections := sedConexoesTCP.Value ;
     TcpServer.MaxConnectionReply.Text.Add( 'Pedido de conexão negado.') ;
     TcpServer.MaxConnectionReply.Text.Add(
        'Número máximo de conexões ('+sedConexoesTCP.Text+') já atingido' ) ;

     { Parametros do ECF }
     cbECFPorta.Text       := Ini.ReadString('ECF','Porta','Procurar');
     ECFDeviceParams       := Ini.ReadString('ECF','SerialParams','');
     cbECFModelo.ItemIndex := Ini.ReadInteger('ECF','Modelo',0)+1;
     cbECFModeloChange(Self);
     sedECFTimeout.Value   := Ini.ReadInteger('ECF','Timeout',3);
     sedECFIntervalo.Value := Ini.ReadInteger('ECF','IntervaloAposComando',100);
     chECFArredondaPorQtd.Checked := Ini.ReadBool('ECF','ArredondamentoPorQtd',false);
     chECFDescrGrande.Checked     := Ini.ReadBool('ECF','DescricaoGrande',True);
     chECFSinalGavetaInvertido.Checked := Ini.ReadBool('ECF','GavetaSinalInvertido',false);
     edECFLog.Text         := Ini.ReadString('ECF','ArqLog','');

     { Parametros do CHQ }
     cbCHQPorta.Text       := Ini.ReadString('CHQ','Porta','');
     cbCHQModelo.ItemIndex := Ini.ReadInteger('CHQ','Modelo',0);
     cbCHQModeloChange(Self);
     chCHQVerForm.Checked  := Ini.ReadBool('CHQ','VerificaFormulario',false);
     edCHQFavorecido.Text  := Ini.ReadString('CHQ','Favorecido','');
     edCHQCidade.Text      := Ini.ReadString('CHQ','Cidade','');
     edCHQBemafiINI.Text   := Ini.ReadString('CHQ','PathBemafiINI','');
     CHQDeviceParams       := Ini.ReadString('CHQ', 'SerialParams', '');

     { Parametros do GAV }
     cbGAVPorta.Text       := Ini.ReadString('GAV','Porta','');
     cbGAVModelo.ItemIndex := Ini.ReadInteger('GAV','Modelo',0);
     cbGAVModeloChange(Self);
     cbGAVStrAbre.Text     := Ini.ReadString('GAV','StringAbertura','');
     sedGAVIntervaloAbertura.Value := Ini.ReadInteger('GAV','AberturaIntervalo',
        ACBrGAV1.AberturaIntervalo);
     cbGAVAcaoAberturaAntecipada.ItemIndex :=
        Ini.ReadInteger('GAV','AcaoAberturaAntecipada',1);

     { Parametros do DIS }
     cbDISPorta.Text       := Ini.ReadString('DIS','Porta','');
     cbDISModelo.ItemIndex := Ini.ReadInteger('DIS','Modelo',0);
     cbDISModeloChange(Self);
     seDISIntervalo.Value  := Ini.ReadInteger('DIS','Intervalo',300);
     seDISPassos.Value     := Ini.ReadInteger('DIS','Passos',1);
     seDISIntByte.Value    := Ini.ReadInteger('DIS','IntervaloEnvioBytes',3);

     { Parametros do LCB }
     cbLCBPorta.Text             := Ini.ReadString('LCB','Porta','Sem Leitor');
     cbLCBPortaChange(Self);
     sedLCBIntervalo.Value       := Ini.ReadInteger('LCB','Intervalo',100);
     cbLCBSufixoLeitor.Text      := Ini.ReadString('LCB','SufixoLeitor','#13');
     chLCBExcluirSufixo.Checked  := Ini.ReadBool('LCB','ExcluirSufixo',false) ;
     edLCBPreExcluir.Text        := Ini.ReadString('LCB','PrefixoAExcluir','');
     cbLCBSufixo.Text            := Ini.ReadString('LCB','SufixoIncluir','') ;
     cbLCBDispositivo.Text       := Ini.ReadString('LCB','Dispositivo','') ;
     rbLCBTeclado.Checked        := Ini.ReadBool('LCB','Teclado',True) ;
     rbLCBFila.Checked           := not rbLCBTeclado.Checked ;
     ACBrLCB1.Device.ParamsString:= Ini.ReadString('LCB','Device','') ;

     { Parametros do RFD }
     chRFD.Checked          := INI.ReadBool('RFD','GerarRFD',False);
     chRFDIgnoraMFD.Checked := INI.ReadBool('RFD','IgnoraECF_MFD',True);
     edRFDDir.Text          := INI.ReadString('RFD','DirRFD',edRFDDir.Text);

     { Parametros do BAL }
     cbBALPorta.Text       := Ini.ReadString('BAL','Porta','');
     cbBALModelo.ItemIndex := Ini.ReadInteger('BAL','Modelo',0);
     cbBALModeloChange(Self);
     sedBALIntervalo.Value  := Ini.ReadInteger('BAL','Intervalo',200);

     { Parametros do ETQ }
     cbETQPorta.Text       := Ini.ReadString('ETQ','Porta','');
     cbETQModelo.ItemIndex := Ini.ReadInteger('ETQ','Modelo',0);
     cbETQModeloChange(Self);

     { Parametros do TC }
     cbxTCModelo.ItemIndex := Ini.ReadInteger('TC','Modelo',0);
     cbxTCModeloChange(Self) ;
     edTCArqPrecos.Text    := IntToStr(Ini.ReadInteger('TC','TCP_Porta',6500));
     edTCArqPrecos.Text    := Ini.ReadString('TC','Arq_Precos','PRICETAB.TXT');
     edTCNaoEncontrado.Text:= Ini.ReadString('TC','Nao_Econtrado','PRODUTO|NAO ENCONTRADO');

  finally
     Ini.Free ;
  end ;

  with ACBrECF1 do
  begin
     Desativar ;
     Modelo               := TACBrECFModelo( Max(cbECFModelo.ItemIndex-1,0) ) ;
     Porta                := cbECFPorta.Text ;
     if ECFDeviceParams <> '' then
        Device.ParamsString  := ECFDeviceParams ;
     TimeOut              := sedECFTimeout.Value ;
     IntervaloAposComando := sedECFIntervalo.Value ;
     ArredondaPorQtd      := chECFArredondaPorQtd.Checked ;
     DescricaoGrande      := chECFDescrGrande.Checked ;
     GavetaSinalInvertido := chECFSinalGavetaInvertido.Checked ;
     BloqueiaMouseTeclado := False ;
     ExibeMensagem        := False ;
     ArqLOG               := edECFLog.Text ;
     Ativo                := ECFAtivado ;
  end ;

  with ACBrCHQ1 do
  begin
     Desativar ;
     Modelo  := TACBrCHQModelo( cbCHQModelo.ItemIndex ) ;
     Porta   := cbCHQPorta.Text ;
     if CHQDeviceParams <> '' then
        Device.ParamsString  := CHQDeviceParams ;
     Favorecido := edCHQFavorecido.Text ;
     Cidade     := edCHQCidade.Text ;

     if edCHQBemafiINI.Text <> '' then
     begin
        try
           ArquivoBemaFiINI := edCHQBemafiINI.Text ;
           mResp.Lines.Add('Arquivo de Cheques: '+ArquivoBemaFiINI + sLineBreak +
                           ' lido com sucesso.') ;
        except
           on E : Exception do
              mResp.Lines.Add( E.Message );
        end ;
     end ;
     Ativo := CHQAtivado ;
  end ;

  with ACBrGAV1 do
  begin
     Desativar ;
     StrComando := cbGAVStrAbre.Text ;
     AberturaIntervalo  := sedGAVIntervaloAbertura.Value ;
     AberturaAntecipada := TACBrGAVAberturaAntecipada(
                                       cbGAVAcaoAberturaAntecipada.ItemIndex ) ;
     Modelo     := TACBrGAVModelo( cbGAVModelo.ItemIndex ) ;
     Porta      := cbGAVPorta.Text ;
     Ativo      := (GAVAtivado or (pos('serial',LowerCase(ModeloStr)) > 0) );
  end ;

  with ACBrDIS1 do
  begin
     Desativar ;
     Intervalo := seDISIntervalo.Value ;
     Passos    := seDISPassos.Value ;
     IntervaloEnvioBytes := seDISIntByte.Value ;
     Modelo    := TACBrDISModelo( cbDISModelo.ItemIndex ) ;
     Porta     := cbDISPorta.Text ;
     Ativo     := DISAtivado ;
  end ;

  with ACBrLCB1 do
  begin
     Desativar ;
     Porta           := cbLCBPorta.Text ;
     Intervalo       := sedLCBIntervalo.Value ;
     Sufixo          := cbLCBSufixoLeitor.Text ;
     ExcluirSufixo   := chLCBExcluirSufixo.Checked ;
     PrefixoAExcluir := edLCBPreExcluir.Text ;
     UsarFila        := rbLCBFila.Checked ;

     { SndKey32.pas só funciona no Windows pois usa a API  "keybd_event" }
     if (ACBrLCB1.Porta <> 'Sem Leitor') and (ACBrLCB1.Porta <> '') then
        ACBrLCB1.Ativar ;
  end ;

  with ACBrRFD1 do
  begin
     DirRFD := edRFDDir.Text ;

     if chRFD.Checked then
        LerSW ;
  end ;

  with ACBrBAL1 do
  begin
     Desativar ;
     Intervalo := sedBALIntervalo.Value ;
     Modelo    := TACBrBALModelo( cbBALModelo.ItemIndex ) ;
     Porta     := cbBALPorta.Text ;
     Ativo     := BALAtivado ;
  end ;

  with ACBrETQ1 do
  begin
     Desativar ;
     Modelo    := TACBrETQModelo( cbETQModelo.ItemIndex ) ;
     Porta     := cbETQPorta.Text ;
     Ativo     := ETQAtivado ;
  end ;

  if cbxTCModelo.ItemIndex > 0 then
     bTCAtivar.Click ;

end;

{------------------------------------------------------------------------------}
procedure TFrmACBrMonitor.LerSW;
  Var INI : TIniFile ;
      ArqSWH, Pass: String ;
      JaExiste : Boolean ;
begin
  ArqSWH   := ExtractFilePath(Application.ExeName)+'swh.ini' ;
  JaExiste := FileExists( ArqSWH ) ;

  Ini := TIniFile.Create( ArqSWH ) ;
  try
     edSH_CNPJ.Text := LeINICrypt(INI,'SWH','CNPJ', IntToStrZero(fsHashSenha,8));
     Pass := IntToStrZero( StringCrc16(edSH_CNPJ.Text + IntToStrZero(fsHashSenha,8)),8) ;

     if LeINICrypt(INI,'SWH','Verifica', Pass) <> 'ARQUIVO SWH.INI ESTA OK' then
        if JaExiste then
           raise Exception.Create('Arquivo "swh.ini" inválido.')
        else
           raise Exception.Create('Arquivo "swh.ini" não encontrado.') ;

     edSH_RazaoSocial.Text := LeINICrypt(INI,'SWH','RazaoSocial', Pass);
     edSH_COO.Text         := LeINICrypt(INI,'SWH','COO', Pass);
     edSH_IE.Text          := LeINICrypt(INI,'SWH','IE', Pass);
     edSH_IM.Text          := LeINICrypt(INI,'SWH','IM', Pass);
     edSH_Aplicativo.Text  := LeINICrypt(INI,'SWH','Aplicativo', Pass);
     edSH_NumeroAP.Text    := LeINICrypt(INI,'SWH','NumeroAplicativo', Pass);
     edSH_VersaoAP.Text    := LeINICrypt(INI,'SWH','VersaoAplicativo', Pass);
     edSH_Linha1.Text      := LeINICrypt(INI,'SWH','Linha1', Pass);
     edSH_Linha2.Text      := LeINICrypt(INI,'SWH','Linha2', Pass);

     ACBrRFD1.SH_RazaoSocial     := edSH_RazaoSocial.Text ;
     ACBrRFD1.SH_COO             := edSH_COO.Text ;
     ACBrRFD1.SH_CNPJ            := edSH_CNPJ.Text ;
     ACBrRFD1.SH_IE              := edSH_IE.Text ;
     ACBrRFD1.SH_IM              := edSH_IM.Text ;
     ACBrRFD1.SH_NomeAplicativo  := edSH_Aplicativo.Text ;
     ACBrRFD1.SH_NumeroAplicativo:= edSH_NumeroAP.Text ;
     ACBrRFD1.SH_VersaoAplicativo:= edSH_VersaoAP.Text ;
     ACBrRFD1.SH_Linha1          := edSH_Linha1.Text ;
     ACBrRFD1.SH_Linha2          := edSH_Linha2.Text ;
  finally
     Ini.Free ;
  end ;
end;

{------------------------------------------------------------------------------}
Function TFrmACBrMonitor.LerChaveSWH : String;
  Var INI : TIniFile ;
      Pass: String ;
begin
  Result := '' ;
  Ini := TIniFile.Create( ExtractFilePath(Application.ExeName)+'swh.ini' ) ;
  try
     Pass := LeINICrypt(INI,'SWH','CNPJ', IntToStrZero(fsHashSenha,8));
     Pass := IntToStrZero( StringCrc16(Pass + IntToStrZero(fsHashSenha,8)),8) ;

     if LeINICrypt(INI,'SWH','Verifica', Pass) = 'ARQUIVO SWH.INI ESTA OK' then
        Result := Trim( LeINICrypt(INI,'SWH','RSA', Pass) );
  finally
     Ini.Free ;
  end ;
end ;


{------------------------------------------------------------------------------}
procedure TFrmACBrMonitor.SalvarIni;
var Ini : TIniFile;
    OldMonitoraTXT, OldMonitoraTCP : Boolean ;
begin
  if cbSenha.Checked and (edSenha.Text <> 'NADAAQUI') and (edSenha.Text <> '') then
     fsHashSenha := StringCrc16(edSenha.Text) ;

  if pConfig.Visible and chRFD.Checked and (fsHashSenha < 1)  then
  begin
     PageControl1.ActivePageIndex := 0 ;
     cbSenha.Checked := True ;
     edSenha.SetFocus ;
     raise Exception.Create('Para trabalhar com RFD é necessário definir uma Senha '+
                            'para proteger sua Chave Privada') ;
  end ;

  Ini := TIniFile.Create( ACBrMonitorINI ) ;
  try
     // Verificando se modificou o Modo de Monitoramento //
     OldMonitoraTCP := Ini.ReadBool('ACBrMonitor','Modo_TCP',false) ;
     OldMonitoraTXT := Ini.ReadBool('ACBrMonitor','Modo_TXT',false) ;

     // Parametros do Monitor //
     Ini.WriteBool('ACBrMonitor','Modo_TCP',rbTCP.Checked);
     Ini.WriteBool('ACBrMonitor','Modo_TXT',rbTXT.Checked);
     Ini.WriteInteger('ACBrMonitor','TCP_Porta',StrToIntDef(edPortaTCP.Text,3434));
     Ini.WriteInteger('ACBrMonitor','Conexoes_Simultaneas',sedConexoesTCP.Value);
     Ini.WriteString('ACBrMonitor','TXT_Entrada',edEntTXT.Text);
     Ini.WriteString('ACBrMonitor','TXT_Saida',edSaiTXT.Text);
     Ini.WriteInteger('ACBrMonitor','Intervalo',sedIntervalo.Value);
     GravaINICrypt(INI,'ACBrMonitor','HashSenha', IntToStrZero(fsHashSenha,8), _C) ;

     Ini.WriteBool('ACBrMonitor','Gravar_Log',cbLog.Checked);
     Ini.WriteString('ACBrMonitor','Arquivo_Log',edLogArq.Text);
     Ini.WriteInteger('ACBrMonitor','Linhas_Log',sedLogLinhas.Value);
     Ini.WriteBool('ACBrMonitor','Comandos_Remotos',cbComandos.Checked);

     { Parametros do ECF }
     Ini.WriteInteger('ECF','Modelo',max(cbECFModelo.ItemIndex-1,0));
     Ini.WriteString('ECF','Porta',cbECFPorta.Text);
     Ini.WriteString('ECF','SerialParams',ACBrECF1.Device.ParamsString);
     Ini.WriteInteger('ECF','Timeout',sedECFTimeout.Value);
     Ini.WriteInteger('ECF','IntervaloAposComando',sedECFIntervalo.Value);
     Ini.WriteBool('ECF','ArredondamentoPorQtd',chECFArredondaPorQtd.Checked);
     Ini.WriteBool('ECF','DescricaoGrande',chECFDescrGrande.Checked);
     Ini.WriteBool('ECF','GavetaSinalInvertido',chECFSinalGavetaInvertido.Checked);
     Ini.WriteString('ECF','ArqLog',edECFLog.Text);

     { Parametros do CHQ }
     Ini.WriteInteger('CHQ','Modelo',cbCHQModelo.ItemIndex);
     Ini.WriteString('CHQ','Porta',cbCHQPorta.Text);
     Ini.WriteString('CHQ','SerialParams',ACBrCHQ1.Device.ParamsString);
     Ini.WriteBool('CHQ','VerificaFormulario',chCHQVerForm.Checked);
     Ini.WriteString('CHQ','Favorecido',edCHQFavorecido.Text);
     Ini.WriteString('CHQ','Cidade',edCHQCidade.Text);
     Ini.WriteString('CHQ','PathBemafiINI',edCHQBemafiINI.Text);

     { Parametros do GAV }
     Ini.WriteInteger('GAV','Modelo',cbGAVModelo.ItemIndex);
     Ini.WriteString('GAV','Porta',cbGAVPorta.Text);
     Ini.WriteString('GAV','StringAbertura',cbGAVStrAbre.Text);
     Ini.WriteInteger('GAV','AberturaIntervalo',sedGAVIntervaloAbertura.Value);
     Ini.WriteInteger('GAV','AcaoAberturaAntecipada',
        cbGAVAcaoAberturaAntecipada.ItemIndex);

     { Parametros do DIS }
     Ini.WriteInteger('DIS','Modelo',cbDISModelo.ItemIndex);
     Ini.WriteString('DIS','Porta',cbDISPorta.Text);
     Ini.WriteInteger('DIS','Intervalo',seDISIntervalo.Value);
     Ini.WriteInteger('DIS','Passos',seDISPassos.Value);
     Ini.WriteInteger('DIS','IntervaloEnvioBytes',seDISIntByte.Value);

     { Parametros do LCB }
     Ini.WriteString('LCB','Porta',cbLCBPorta.Text);
     Ini.WriteInteger('LCB','Intervalo',sedLCBIntervalo.Value);
     Ini.WriteString('LCB','SufixoLeitor',cbLCBSufixoLeitor.Text);
     Ini.WriteBool('LCB','ExcluirSufixo',chLCBExcluirSufixo.Checked ) ;
     Ini.WriteString('LCB','PrefixoAExcluir',edLCBPreExcluir.Text);
     Ini.WriteString('LCB','SufixoIncluir',cbLCBSufixo.Text) ;
     Ini.WriteString('LCB','Dispositivo',cbLCBDispositivo.Text) ;
     Ini.WriteBool('LCB','Teclado',rbLCBTeclado.Checked) ;
     Ini.WriteString('LCB','Device',ACBrLCB1.Device.ParamsString) ;

     { Parametros do RFD }
     INI.WriteBool('RFD','GerarRFD',chRFD.Checked);
     INI.WriteString('RFD','DirRFD',edRFDDir.Text);
     INI.WriteBool('RFD','IgnoraECF_MFD',chRFDIgnoraMFD.Checked);

     { Parametros do BAL }
     Ini.WriteInteger('BAL','Modelo',cbBALModelo.ItemIndex);
     Ini.WriteString('BAL','Porta',cbBALPorta.Text);
     Ini.WriteInteger('BAL','Intervalo',sedBALIntervalo.Value);

     { Parametros do ETQ }
     Ini.WriteInteger('ETQ','Modelo',cbETQModelo.ItemIndex);
     Ini.WriteString('ETQ','Porta',cbETQPorta.Text);

     { Parametros do TC }
     Ini.WriteInteger('TC','Modelo',cbxTCModelo.ItemIndex);
     Ini.WriteInteger('TC','TCP_Porta',StrToIntDef(edTCArqPrecos.Text, 6500) );
     Ini.WriteString('TC','Arq_Precos',edTCArqPrecos.Text);
     Ini.WriteString('TC','Nao_Econtrado',edTCNaoEncontrado.Text);

  finally
     Ini.Free ;
  end ;

  if chRFD.Checked then
  begin
     SalvarSW ;

     if ACBrRFD1.Ativo then
        ACBrRFD1.GravarINI ;
  end ;
  
  if (OldMonitoraTXT <> rbTXT.Checked) or (OldMonitoraTCP <> rbTCP.Checked) then
  begin
     MessageDlg('ACBrMonitor',
                'O Método de Monitoramento do <b>ACBrMonitor</b> foi modificado'+
                '<br><br>Será necessário reinicar o <b>ACBrMonitor</b>',
                mtInformation, [mbOk],0) ;
     Application.Terminate ;
  end ;
end;

{------------------------------------------------------------------------------}
procedure TFrmACBrMonitor.SalvarSW;
  Var INI : TIniFile ;
      Pass:String ;
begin
  Ini := TIniFile.Create( ExtractFilePath(Application.ExeName)+'swh.ini' ) ;
  try
     INI.WriteString('SWH','CNPJ',ACBrRFD1.SH_CNPJ);
     GravaINICrypt(INI,'SWH','CNPJ',ACBrRFD1.SH_CNPJ, IntToStrZero(fsHashSenha,8)) ;
     Pass := IntToStrZero( StringCrc16(ACBrRFD1.SH_CNPJ + IntToStrZero(fsHashSenha,8)),8) ;

     GravaINICrypt(INI,'SWH','Verifica','ARQUIVO SWH.INI ESTA OK', Pass) ;
     GravaINICrypt(INI,'SWH','RazaoSocial',ACBrRFD1.SH_RazaoSocial, Pass);
     GravaINICrypt(INI,'SWH','COO',ACBrRFD1.SH_COO, Pass);
     GravaINICrypt(INI,'SWH','IE',ACBrRFD1.SH_IE, Pass);
     GravaINICrypt(INI,'SWH','IM',ACBrRFD1.SH_IM, Pass);
     GravaINICrypt(INI,'SWH','Aplicativo',ACBrRFD1.SH_NomeAplicativo, Pass);
     GravaINICrypt(INI,'SWH','NumeroAplicativo',ACBrRFD1.SH_NumeroAplicativo, Pass);
     GravaINICrypt(INI,'SWH','VersaoAplicativo',ACBrRFD1.SH_VersaoAplicativo, Pass);
     GravaINICrypt(INI,'SWH','Linha1',ACBrRFD1.SH_Linha1, Pass);
     GravaINICrypt(INI,'SWH','Linha2',ACBrRFD1.SH_Linha2, Pass);

     if mRFDKey.Text <> '' then
        GravaINICrypt(INI,'SWH','RSA',Trim(mRFDKey.Text), Pass)
     else
        if LerChaveSWH = '' then
        begin
           PageControl1.ActivePage := tsRFD ;
           pgConRFD.ActivePage     := tsRFDRSA ;

           raise Exception.Create('Para trabalhar com RFD é necessário '+
                                  'definir uma Chave Privada');
        end ;

  finally
     Ini.Free ;
  end ;
end ;

{------------------------------------------------------------------------------}
procedure TFrmACBrMonitor.EscondeConfig;
begin
  pConfig.Visible := False ;

  bConfig.Caption     := '&Configurar' ;
  bConfig.Glyph       := nil ;
  ImageList1.GetBitmap(11,bConfig.Glyph);
  bCancelar.Visible   := false ;
  btMinimizar.Visible := true ;
  Application.ProcessMessages ;
end;

{------------------------------------------------------------------------------}
procedure TFrmACBrMonitor.ExibeConfig;
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

  fsCNPJSWOK      := False ;
  pConfig.Visible := true ;

  bConfig.Caption     := '&Salvar' ;
  bConfig.Glyph       := nil ;
  ImageList1.GetBitmap(12,bConfig.Glyph);
  bCancelar.Visible   := true ;
  btMinimizar.Visible := false ;
  Application.ProcessMessages ;
end;

{------------------------------------------------------------------------------}
procedure TFrmACBrMonitor.Processar;
var
  Linha : string;
begin
  if NewLines <> '' then
     mCmd.Lines.Add( NewLines ) ;

  NewLines := '' ;

  while mCmd.Lines.Count > 0 do
  begin
     Application.ProcessMessages ;

     Linha := Trim( mCmd.Lines[0] );
     mCmd.Lines.Delete(0);

     if Linha <> '' then
     begin
        sbProcessando.Panels[1].Text := Linha ;

        try
           if pos('.',Linha) = 0 then              { Comandos do ACBrMonitor }
              Linha := 'ACBR.'+Linha ;

           Cmd.Comando := Linha ;

           if Cmd.Objeto = 'ACBR' then
              DoACBr( Cmd )
           else if Cmd.Objeto = 'ECF' then
              DoECF( Cmd )
           else if Cmd.Objeto = 'GAV' then
              DoGAV( Cmd )
           else if Cmd.Objeto = 'CHQ' then
              DoCHQ( Cmd )
           else if Cmd.Objeto = 'DIS' then
              DoDIS( Cmd )
           else if Cmd.Objeto = 'LCB' then
              DoLCB( Cmd )
           else if Cmd.Objeto = 'BAL' then
              DoBAL( Cmd )
           else if Cmd.Objeto = 'ETQ' then
              DoETQ( Cmd );

           Resposta(Linha, 'OK: '+Cmd.Resposta );
           
        except
           on E : Exception do
              Resposta(Linha, 'ERRO: '+E.Message );
        end ;

        sbProcessando.Panels[1].Text := '' ;
     end ;
  end ;
end;

{------------------------------------------------------------------------------}
Procedure TFrmACBrMonitor.Resposta(Comando, Resposta : string );
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
     if TipoCMD = 'A' then
     begin
        WriteToTXT(ArqSaiTMP, Resposta);
        RenameFile(ArqSaiTMP, ArqSaiTXT) ;
     end
     else if TipoCMD = 'B' then
     begin
        if copy(Resposta,1,3) <> 'OK:' then
        begin
           WriteToTXT(ExtractFilePath(ArqSaiTMP)+'STATUS.TXT','0,0,0') ;
        end
        else
        begin
           WriteToTXT(ExtractFilePath(ArqSaiTMP)+'STATUS.TXT','6,0,0') ;
           Resposta := StringReplace( Resposta, 'OK: ', '',[rfReplaceAll]) ;
           Resposta := StringReplace( Resposta, '/', '',[rfReplaceAll]) ;
           Resposta := StringReplace( Resposta, ':', '',[rfReplaceAll]) ;
           WriteToTXT(ArqSaiTMP,Resposta) ;
           RenameFile(ArqSaiTMP, ArqSaiTXT) ;
        end
     end
     else if TipoCMD = 'D' then
     begin
        if copy(Resposta,1,3) <> 'OK:' then
        begin
           WriteToTXT(ExtractFilePath(ArqSaiTMP)+'DARUMA.RET','-27;006;000;000') ;
        end
        else
        begin
           Resposta := StringReplace( Resposta, 'OK: ', '',[rfReplaceAll]) ;
           Resposta := StringReplace( Resposta, '/', '',[rfReplaceAll]) ;
           Resposta := StringReplace( Resposta, ':', '',[rfReplaceAll]) ;
           Resposta := '001;006;000;000;'+Resposta ;
           WriteToTXT(ArqSaiTMP,Resposta) ;
           RenameFile(ArqSaiTMP, ExtractFilePath(ArqSaiTMP)+'DARUMA.RET') ;
        end
     end

  end ;

  mResp.Lines.BeginUpdate ;
  mResp.Lines.Add( Comando + sLineBreak + Resposta ) ;
  while mResp.Lines.Count > BufferMemoResposta do
     mResp.Lines.Delete(0) ;
  mResp.Lines.EndUpdate ;

  if cbLog.Checked then
     WriteToTXT(ArqLogTXT, Comando + sLineBreak + Resposta);
end;

{------------------------------------------------------------------------------}
procedure TFrmACBrMonitor.btMinimizarClick(Sender: TObject);
begin
  Ocultar1Click( Sender );
end;

{------------------------------------------------------------------------------}
procedure TFrmACBrMonitor.bCancelarClick(Sender: TObject);
begin
  EscondeConfig ;
  LerIni ;
end;

{------------------------------------------------------------------------------}
procedure TFrmACBrMonitor.bConfigClick(Sender: TObject);
begin
  if pConfig.Visible then
   begin
     SalvarIni ;
     EscondeConfig ;
     LerIni ; { Para as alteraçoes fazerem efeito }
   end
  else
     ExibeConfig ;

  fsRFDLeuParams := False ;
end;

{------------------------------------------------------------------------------}
procedure TFrmACBrMonitor.rbTCPTXTClick(Sender: TObject);
begin
  gbTCP.Enabled := rbTCP.Checked ;
  gbTXT.Enabled := rbTXT.Checked ;

  if rbTXT.Checked then
   begin
     if edENTTXT.Text = '' then
        edENTTXT.Text := 'ENT.TXT' ;

     if edSAITXT.Text = '' then
        edSAITXT.Text := 'SAI.TXT' ;
   end
  else
   begin
     if edPortaTCP.Text = '' then
        edPortaTCP.Text := '3434' ;

     if sedConexoesTCP.Value <= 0 then
        sedConexoesTCP.Value := 1 ;
   end ;
end;

{------------------------------------------------------------------------------}
procedure TFrmACBrMonitor.cbSenhaClick(Sender: TObject);
begin
  gbSenha.Enabled := cbSenha.Checked ;
  if not cbSenha.Checked then
  begin
     fsHashSenha  := -1 ;
     edSenha.Text :=  '' ;
  end ;
end;

{------------------------------------------------------------------------------}
procedure TFrmACBrMonitor.cbLogClick(Sender: TObject);
begin
  gbLog.Enabled := cbLog.Checked ;

  if cbLog.Checked and (edLogArq.Text = '') then
     edLogArq.Text := 'LOG.TXT' ;
end;

{------------------------------------------------------------------------------}
procedure TFrmACBrMonitor.sbLogClick(Sender: TObject);
begin
  OpenURL( ExtractFilePath( Application.ExeName ) + edLogArq.Text);
end;

{------------------------------------------------------------------------------}
procedure TFrmACBrMonitor.edOnlyNumbers(Sender: TObject;
  var Key: Char);
begin
  if not ( Key in ['0'..'9',#13,#8] ) then
     Key := #0 ;
end;

{------------------------------------------------------------------------------}
procedure TFrmACBrMonitor.ACBrECF1MsgAguarde(Mensagem: String);
begin
  StatusBar1.Panels[1].Text :=
     StringReplace( Mensagem, sLineBreak, ' ',[rfReplaceAll]) ;
end;

{------------------------------------------------------------------------------}
procedure TFrmACBrMonitor.ACBrECF1MsgPoucoPapel(Sender: TObject);
begin
  StatusBar1.Panels[1].Text := 'ATENÇAO. Pouco papel'
end;

{------------------------------------------------------------------------------}
procedure TFrmACBrMonitor.DoACBrTimer(Sender: TObject);
var SL    : TStringList ;
begin
  Timer1.Enabled := false;

  if Inicio then
  begin
     Inicializar ;
     exit;
  end ;

  try
     if FileExists( ArqEntTXT ) then  { Existe arquivo para ler ? }
     begin
       { Lendo em StringList temporário para nao apagar comandos nao processados }
       SL := TStringList.Create ;
       try
          TipoCMD := 'A' ;
          if ( UpperCase(ExtractFileName( ArqEntTXT )) = 'BEMAFI32.CMD' ) then
             TipoCMD := 'B'
          else if ( UpperCase(ExtractFileName( ArqEntTXT )) = 'DARUMA.CMD' ) then
             TipoCMD := 'D' ;

          SL.LoadFromFile( ArqEntTXT );
          TryDeleteFile( ArqEntTXT, 1000 ) ; // Tenta apagar por até 1 segundo

          if TipoCMD = 'B' then
             SL.Text := TraduzBemafi( SL.Text )
          else if TipoCMD = 'D' then
             SL.Text := TraduzObserver( SL.Text ) ;
             
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

{---------------------------------- ACBrECF -----------------------------------}
{------------------------------------------------------------------------------}
procedure TFrmACBrMonitor.tsECFShow(Sender: TObject);
begin
   AvaliaEstadoTsECF ;
end;

{------------------------------------------------------------------------------}
procedure TFrmACBrMonitor.cbECFModeloChange(Sender: TObject);
begin
  try
     if ACBrECF1.Ativo then
        bECFAtivar.Click ;

      ACBrECF1.Modelo := TACBrECFModelo( Max(cbECFModelo.ItemIndex -1,0) )
  finally
     if cbECFModelo.Text <> 'Procurar' then
        cbECFModelo.ItemIndex := Integer( ACBrECF1.Modelo )+1 ;
     cbECFPorta.Text := ACBrECF1.Porta ;
  end ;

  AvaliaEstadoTsECF ;
end;

procedure TFrmACBrMonitor.AvaliaEstadoTsECF ;
begin
  bECFAtivar.Enabled           := ((ACBrECF1.Modelo <> ecfNenhum) or
                                   (cbECFModelo.Text = 'Procurar')   );
  chECFArredondaPorQtd.Enabled := bECFAtivar.Enabled ;
  chECFDescrGrande.Enabled     := bECFAtivar.Enabled ;
  cbECFPorta.Enabled           := bECFAtivar.Enabled ;
  sedECFTimeout.Enabled        := bECFAtivar.Enabled ;
  sedECFIntervalo.Enabled      := bECFAtivar.Enabled ;
  chECFSinalGavetaInvertido.Enabled := bECFAtivar.Enabled ;

  bECFTestar.Enabled   := ACBrECF1.Ativo ;
  bECFLeituraX.Enabled := ACBrECF1.Ativo ;

  bECFAtivar.Glyph := nil ;
  if ACBrECF1.Ativo then
   begin
     bECFAtivar.Caption := '&Desativar' ;
     ImageList1.GetBitmap(6,bECFAtivar.Glyph);
   end
  else
   begin
     bECFAtivar.Caption := '&Ativar' ;
     ImageList1.GetBitmap(5,bECFAtivar.Glyph);
   end ;
end ;

{------------------------------------------------------------------------------}
procedure TFrmACBrMonitor.cbECFPortaChange(Sender: TObject);
begin
  try
     if ACBrECF1.Ativo then
        bECFAtivar.Click ;

    ACBrECF1.Porta := cbECFPorta.Text ;
  finally
     cbECFPorta.Text := ACBrECF1.Porta ;
  end ;
end;


{------------------------------------------------------------------------------}
procedure TFrmACBrMonitor.sbECFSerialClick(Sender: TObject);
begin
  frConfiguraSerial := TfrConfiguraSerial.Create(self);

  try
     if ACBrECF1.Ativo then
        bECFAtivar.Click ;

    frConfiguraSerial.Device.Porta        := ACBrECF1.Device.Porta ;
    frConfiguraSerial.cmbPortaSerial.Text := cbECFPorta.Text ;
    frConfiguraSerial.Device.ParamsString := ACBrECF1.Device.ParamsString ;

    if frConfiguraSerial.ShowModal = mrOk then
    begin
       cbECFPorta.Text              := frConfiguraSerial.Device.Porta ;
       ACBrECF1.Device.ParamsString := frConfiguraSerial.Device.ParamsString ;
    end ;
  finally
     FreeAndNil( frConfiguraSerial ) ;
     AvaliaEstadoTsECF ;
  end ;
end;

{------------------------------------------------------------------------------}
procedure TFrmACBrMonitor.sedECFTimeoutChanged(Sender: TObject;
  NewValue: Integer);
begin
  ACBrECF1.TimeOut := sedECFTimeout.Value ;
end;

{------------------------------------------------------------------------------}
procedure TFrmACBrMonitor.sedECFIntervaloChanged(Sender: TObject;
  NewValue: Integer);
begin
  ACBrECF1.IntervaloAposComando := sedECFIntervalo.Value ;
end;

{------------------------------------------------------------------------------}
procedure TFrmACBrMonitor.chECFArredondaPorQtdClick(Sender: TObject);
begin
  ACBrECF1.ArredondaPorQtd := chECFArredondaPorQtd.Checked ;
end;

{------------------------------------------------------------------------------}
procedure TFrmACBrMonitor.chECFDescrGrandeClick(Sender: TObject);
begin
  ACBrECF1.DescricaoGrande := chECFDescrGrande.Checked ;
end;

{------------------------------------------------------------------------------}
procedure TFrmACBrMonitor.chECFSinalGavetaInvertidoClick(Sender: TObject);
begin
  ACBrECF1.GavetaSinalInvertido := chECFSinalGavetaInvertido.Checked ;
end;

{------------------------------------------------------------------------------}
procedure TFrmACBrMonitor.edECFLogChange(Sender: TObject);
begin
  ACBrECF1.ArqLOG := edECFLog.Text ;
end;

{------------------------------------------------------------------------------}
procedure TFrmACBrMonitor.sbECFLogClick(Sender: TObject);
begin
  OpenURL( ExtractFilePath( Application.ExeName ) + edECFLog.Text);
end;

{------------------------------------------------------------------------------}
procedure TFrmACBrMonitor.bECFAtivarClick(Sender: TObject);
begin
  if bECFAtivar.Caption = '&Ativar' then
   begin
     try
        if cbECFModelo.ItemIndex = 0 then
           if not ACBrECF1.AcharECF(true,False) then
           begin
              MessageDlg('Nenhum ECF encontrado.',mtInformation,[mbOk],0) ;
              exit ;
           end ;

        ACBrECF1.Ativar ;
     finally
        cbECFModelo.ItemIndex := Integer(ACBrECF1.Modelo)+1 ;
        cbECFPorta.Text       := ACBrECF1.Porta ;
     end ;
   end
  else
     ACBrECF1.Desativar ;

  AvaliaEstadoTsECF ;
end;

{------------------------------------------------------------------------------}
procedure TFrmACBrMonitor.bECFTestarClick(Sender: TObject);
begin
  ACBrECF1.TestarDialog ;
end;

{------------------------------------------------------------------------------}
procedure TFrmACBrMonitor.bECFLeituraXClick(Sender: TObject);
var wAtivo : Boolean ;
begin
  wAtivo := ACBrECF1.Ativo ;

  try
     ACBrECF1.Ativar ;
     ACBrECF1.LeituraX ;
  finally
     ACBrECF1.Ativo := wAtivo ;
  end ;
end;

{------------------------------------ ACBrCHQ ---------------------------------}
procedure TFrmACBrMonitor.cbCHQPortaChange(Sender: TObject);
begin
  if ACBrCHQ1.Modelo <> chqImpressoraECF then
  begin
     Try
        ACBrCHQ1.Desativar ;
        ACBrCHQ1.Porta := cbCHQPorta.Text ;
     finally
        cbCHQPorta.Text := ACBrCHQ1.Porta ;
     end ;
  end ;
end;

{------------------------------------------------------------------------------}
procedure TFrmACBrMonitor.edCHQFavorecidoChange(Sender: TObject);
begin
  ACBrCHQ1.Favorecido := edCHQFavorecido.Text ;
end;

{------------------------------------------------------------------------------}
procedure TFrmACBrMonitor.edCHQCidadeChange(Sender: TObject);
begin
  ACBrCHQ1.Cidade := edCHQCidade.Text ;
end;

{------------------------------------------------------------------------------}
procedure TFrmACBrMonitor.bCHQTestarClick(Sender: TObject);
var wAtivo : Boolean ;
begin
  wAtivo := ACBrCHQ1.Ativo ;

  try
     ACBrCHQ1.Ativar ;
     ACBrCHQ1.Banco     := '001' ;
     ACBrCHQ1.Cidade    := IfThen(edCHQCidade.Text='',
                                    'Nome da sua Cidade',edCHQCidade.Text) ;
     ACBrCHQ1.Favorecido:= IfThen(edCHQFavorecido.Text='',
                                     'Nome do Favorecido', edCHQFavorecido.Text) ;
     ACBrCHQ1.Observacao:= 'Texto de Observacao' ;
     ACBrCHQ1.Valor     := 123456.12 ;
     ACBrCHQ1.ImprimirCheque ;
  finally
     ACBrCHQ1.Ativo := wAtivo ;
  end ;
end;

{------------------------------------ ACBrGAV ---------------------------------}
{------------------------------------------------------------------------------}
procedure TFrmACBrMonitor.tsGAVShow(Sender: TObject);
begin
  AvaliaEstadoTsGAV ;
end;

procedure TFrmACBrMonitor.bGAVAtivarClick(Sender: TObject);
begin
  if bGAVAtivar.Caption = '&Ativar' then
     ACBrGAV1.Ativar
  else
     ACBrGAV1.Desativar ;

  AvaliaEstadoTsGAV ;
end;

procedure TFrmACBrMonitor.cbGAVPortaChange(Sender: TObject);
begin
  if ACBrGAV1.Modelo <> gavImpressoraECF then
  begin
     Try
        ACBrGAV1.Desativar ;
        ACBrGAV1.Porta := cbGAVPorta.Text ;
     finally
        cbGAVPorta.Text := ACBrGAV1.Porta ;
     end ;
  end ;

  AvaliaEstadoTsGAV ;
end;

{------------------------------------------------------------------------------}
procedure TFrmACBrMonitor.cbGAVStrAbreChange(Sender: TObject);
begin
  ACBrGAV1.StrComando := cbGAVStrAbre.Text ;
end;

{------------------------------------------------------------------------------}
procedure TFrmACBrMonitor.sedGAVIntervaloAberturaChanged(Sender: TObject;
  NewValue: Integer);
begin
  ACBrGAV1.AberturaIntervalo := sedGAVIntervaloAbertura.Value ;
end;

{------------------------------------------------------------------------------}
procedure TFrmACBrMonitor.cbGAVAcaoAberturaAntecipadaChange(
  Sender: TObject);
begin
  ACBrGAV1.AberturaAntecipada := TACBrGAVAberturaAntecipada(
                                       cbGAVAcaoAberturaAntecipada.ItemIndex ) ;
end;

{------------------------------------------------------------------------------}
procedure TFrmACBrMonitor.bGAVEstadoClick(Sender: TObject);
begin
  if not ACBrGAV1.Ativo then
     ACBrGAV1.Ativar ;

  if ACBrGAV1.GavetaAberta then
     lGAVEstado.Caption := 'Aberta'
  else
     lGAVEstado.Caption := 'Fechada' ;
end;

{------------------------------------------------------------------------------}
procedure TFrmACBrMonitor.bGAVAbrirClick(Sender: TObject);
begin
  try
     tsGAV.Enabled := False ;
     lGAVEstado.Caption := 'AGUARDE' ;

     ACBrGAV1.AbreGaveta ;
  finally
     tsGAV.Enabled := True ;
     bGAVEstado.Click ;
  end ;
end;

{------------------------------------ ACBrDIS ---------------------------------}
procedure TFrmACBrMonitor.cbDISPortaChange(Sender: TObject);
begin
  Try
     ACBrDIS1.Desativar ;
     ACBrDIS1.Porta := cbDISPorta.Text ;
  finally
     cbDISPorta.Text := ACBrDIS1.Porta ;
  end ;
end;

{------------------------------------------------------------------------------}
procedure TFrmACBrMonitor.seDISIntervaloChanged(Sender: TObject;
  NewValue: Integer);
begin
  ACBrDIS1.Intervalo := seDISIntervalo.Value ;
end;

{------------------------------------------------------------------------------}
procedure TFrmACBrMonitor.seDISPassosChanged(Sender: TObject;
  NewValue: Integer);
begin
  ACBrDIS1.Passos := seDISPassos.Value ;
end;

{------------------------------------------------------------------------------}
procedure TFrmACBrMonitor.seDISIntByteChanged(Sender: TObject;
  NewValue: Integer);
begin
  ACBrDIS1.IntervaloEnvioBytes := seDISIntByte.Value ;
end;

{------------------------------------------------------------------------------}
procedure TFrmACBrMonitor.bDISLimparClick(Sender: TObject);
begin
  ACBrDIS1.LimparDisplay ;
end;

{------------------------------------------------------------------------------}
procedure TFrmACBrMonitor.bDISTestarClick(Sender: TObject);
begin
  ACBrDIS1.Ativar ;
  ACBrDIS1.ExibirLinha(1,'Projeto ACBr') ;
  ACBrDIS1.ExibirLinha(2,'http://acbr.sf.net') ;
end;

procedure TFrmACBrMonitor.bDISAnimarClick(Sender: TObject);
begin
  ACBrDIS1.Ativar ;
  ACBrDIS1.LimparDisplay ;
  ACBrDIS1.ExibirLinha( 1, padC('Projeto ACBr',ACBrDIS1.Colunas)
                         , efeDireita_Esquerda) ;
  ACBrDIS1.ExibirLinha( 2, padC('http://acbr.sf.net',ACBrDIS1.Colunas)
                         , efeEsquerda_Direita) ;
end;

{------------------------------------ ACBrLCB ---------------------------------}
{------------------------------------------------------------------------------}
procedure TFrmACBrMonitor.tsLCBShow(Sender: TObject);
begin
  AvaliaEstadoTsLCB ;
end;

procedure TFrmACBrMonitor.cbLCBPortaChange(Sender: TObject);
begin
  Try
     ACBrLCB1.Desativar ;
     ACBrLCB1.Porta := cbLCBPorta.Text ;
  finally
     cbLCBPorta.Text := ACBrLCB1.Porta ;
  end ;

  AvaliaEstadoTsLCB ;
end;

{------------------------------------------------------------------------------}
procedure TFrmACBrMonitor.bLCBSerialClick(Sender: TObject);
begin
  ACBrLCB1.Desativar ;
  frConfiguraSerial := TfrConfiguraSerial.Create(self);

  try
    frConfiguraSerial.Device.Porta        := ACBrLCB1.Device.Porta ;
    frConfiguraSerial.cmbPortaSerial.Text := cbLCBPorta.Text ;
    frConfiguraSerial.Device.ParamsString := ACBrLCB1.Device.ParamsString ;

    if frConfiguraSerial.ShowModal = mrOk then
    begin
       cbLCBPorta.Text              := frConfiguraSerial.Device.Porta ;
       ACBrLCB1.Device.ParamsString := frConfiguraSerial.Device.ParamsString ;
    end ;
  finally
     FreeAndNil( frConfiguraSerial ) ;
     AvaliaEstadoTsLCB ;
  end ;
end;

{------------------------------------------------------------------------------}
procedure TFrmACBrMonitor.sedLCBIntervaloChanged(Sender: TObject;
  NewValue: Integer);
begin
  ACBrLCB1.Intervalo := sedLCBIntervalo.Value ;
end;

{------------------------------------------------------------------------------}
procedure TFrmACBrMonitor.rbLCBTecladoClick(Sender: TObject);
begin
  cbLCBSufixo.Enabled := rbLCBTeclado.Checked ;
  cbLCBDispositivo.Enabled := rbLCBTeclado.Checked ;
end;

{------------------------------------------------------------------------------}
procedure TFrmACBrMonitor.bLCBAtivarClick(Sender: TObject);
begin
  sedLCBIntervalo.Value := ACBrLCB1.Intervalo ;
  if bLCBAtivar.Caption = '&Ativar' then
     ACBrLCB1.Ativar
  else
     ACBrLCB1.Desativar ;

  AvaliaEstadoTsLCB ;
end;

procedure TFrmACBrMonitor.AvaliaEstadoTsLCB;
begin
  bLCBAtivar.Enabled := ((cbLCBPorta.Text <> 'Sem Leitor') and
                         (cbLCBPorta.ItemIndex > 0)            ) ;
  cbLCBSufixo.Enabled         := bLCBAtivar.Enabled ;
  cbLCBSufixoLeitor.Enabled   := bLCBAtivar.Enabled ;
  cbLCBDispositivo.Enabled    := bLCBAtivar.Enabled ;
  edLCBPreExcluir.Enabled     := bLCBAtivar.Enabled ;
  chLCBExcluirSufixo.Enabled  := bLCBAtivar.Enabled ;
  sedLCBIntervalo.Enabled     := bLCBAtivar.Enabled ;
  bLCBSerial.Enabled          := bLCBAtivar.Enabled ;
  rbLCBTeclado.Enabled        := bLCBAtivar.Enabled ;
  rbLCBFila.Enabled           := bLCBAtivar.Enabled ;

  rbLCBTecladoClick(Self);

  bLCBAtivar.Glyph := nil ;
  if ACBrLCB1.Ativo then
   begin
     bLCBAtivar.Caption := '&Desativar' ;
     shpLCB.Color       := clLime ;
     ImageList1.GetBitmap(6,bLCBAtivar.Glyph);
   end
  else
   begin
     bLCBAtivar.Caption := '&Ativar' ;
     shpLCB.Color       := clRed ;
     ImageList1.GetBitmap(5,bLCBAtivar.Glyph);
   end ;
end;

{------------------------------------------------------------------------------}
procedure TFrmACBrMonitor.cbLCBSufixoLeitorChange(Sender: TObject);
begin
  ACBrLCB1.Sufixo := cbLCBSufixoLeitor.Text ;
end;

{------------------------------------------------------------------------------}
procedure TFrmACBrMonitor.edLCBSufLeituraKeyPress(Sender: TObject;
  var Key: Char);
begin
  if not ( Key in ['0'..'9','#',',',#13,#8] ) then
     Key := #0 ;
end;

{------------------------------------------------------------------------------}
procedure TFrmACBrMonitor.chLCBExcluirSufixoClick(Sender: TObject);
begin
  ACBrLCB1.ExcluirSufixo := chLCBExcluirSufixo.Checked ;
end;

{------------------------------------------------------------------------------}
procedure TFrmACBrMonitor.edLCBPreExcluirChange(Sender: TObject);
begin
  ACBrLCB1.PrefixoAExcluir := edLCBPreExcluir.Text ;
end;

{------------------------------------------------------------------------------}
procedure TFrmACBrMonitor.AumentaTempoHint(Sender: TObject);
begin
  Application.HintHidePause := 15000 ;
end;

procedure TFrmACBrMonitor.DiminuiTempoHint(Sender: TObject);
begin
  Application.HintHidePause := 5000 ;
end;

{------------------------------------------------------------------------------}
procedure TFrmACBrMonitor.ACBrLCB1LeCodigo(Sender: TObject);
Var Codigo : String ;
    {$IFDEF LINUX}
    fd, I : Integer ;
    C : Char ;
    {$ENDIF}
begin
  lLCBCodigoLido.Caption := Converte( ACBrLCB1.UltimaLeitura ) ;

  mResp.Lines.Add('LCB -> '+ACBrLCB1.UltimoCodigo) ;

  if rbLCBTeclado.Checked then
  begin
     Codigo := ACBrLCB1.UltimoCodigo ;
     if Codigo = '' then
        exit ;

     {$IFDEF MSWINDOWS}
     Codigo := Codigo + Trim(cbLCBSufixo.Text) ;
     SendKeys( pchar(Codigo) , True ) ;
     {$ENDIF}

     { Alguem sabe como enviar as teclas para o Buffer do KDE ??? }
     {$IFDEF LINUX}
     Codigo := Codigo + TraduzComando( cbLCBSufixo.Text ) ;
     fd := FileOpen(Trim(cbLCBDispositivo.Text),O_WRONLY + O_NONBLOCK) ;
     if fd < 0 then
        Writeln('Erro ao abrir o dispositivo: '+Trim(cbLCBDispositivo.Text))
     else
        try
           for I := 1 to length(Codigo) do
           begin
              C := Codigo[I] ;
              Libc.ioctl(fd, TIOCSTI, @C );
           end ;
        finally
           FileClose(fd);
        end;

//   WriteToTXT('/dev/stdin',Codigo,False);
//   RunCommand('echo','"TESTE'+Codigo+'" > /dev/tty1',true) ;
     {$ENDIF}
  end ;
end;


{---------------------------------- ACBrRFD -----------------------------------}
{------------------------------------------------------------------------------}
procedure TFrmACBrMonitor.tsRFDShow(Sender: TObject);
begin
  pgConRFD.ActivePageIndex := 0 ;

  AvaliaEstadoTsRFD ;

  mRFDINI.Lines.Clear ;
  fsRFDIni := '' ;
end;

procedure TFrmACBrMonitor.AvaliaEstadoTsRFD;
 Var MM : String ;
     I  : Integer ;
     SL : TStringList ;
     Ini: TIniFile ;
begin
  bRFDMF.Enabled   := ACBrECF1.Ativo ;
  edRFDDir.Enabled := not bRFDMF.Enabled ;
  cbRFDModelo.Enabled  := bRFDMF.Enabled ;

  tsRFDUsuario.Enabled := ACBrECF1.Ativo and ACBrRFD1.Ativo ;
  tsRFDSwH.Enabled     := tsRFDUsuario.Enabled ;
  tsRFDRSA.Enabled     := tsRFDUsuario.Enabled ;
  tsRFDINI.Enabled     := tsRFDUsuario.Enabled ;

  lRFDID.Caption := ACBrRFD1.ECF_RFDID ;
  
  if ACBrECF1.Ativo then
     gbRFDECF.Hint := 'Selecione o Modelo do ECF'
  else
     pgConRFD.Hint := 'Para Configurar o RFD é necessário ativar o ECF e'+sLineBreak+
                      'Selecionar a opção para Geração de RFD' ;

  if ACBrECF1.Ativo and ACBrRFD1.Ativo then
  begin
     if (copy(lRFDID.Caption,1,Length(ACBrECF1.RFDID)) <> ACBrECF1.RFDID) or
        (cbRFDModelo.Items.Count = 0) then
     begin
        if copy(lRFDID.Caption,1,Length(ACBrECF1.RFDID)) <> ACBrECF1.RFDID then
           lRFDID.Caption := ACBrECF1.RFDID ;

        MM := ACBrRFD1.AchaRFDID( lRFDID.Caption ) ;
        lRFDMarca.Caption := Trim( copy(MM,1, pos('|',MM+'|')-1 ) ) ;

        SL  := TStringList.Create ;
        Ini := TIniFile.Create( ACBrRFD1.ArqRFDID );
        try
            Ini.ReadSectionValues('Modelos',SL);

            cbRFDModelo.Items.Clear ;
            For I := 0 to SL.Count-1 do
            begin
               if copy(SL[I],1,2) = copy(lRFDID.Caption,1,2) then
                  cbRFDModelo.Items.Add( SL[I] );

               if copy(SL[I],1,3) = lRFDID.Caption then
                  cbRFDModelo.Text := SL[I] ;
            end ;
        finally
           SL.Free ;
           Ini.Free ;
        end ;

        ACBrRFD1.ECF_RFDID := lRFDID.Caption ;
     end ;
  end ;
end;

{------------------------------------------------------------------------------}
procedure TFrmACBrMonitor.pgConRFDPageChanging(Sender: TObject;
  NewPage: TTabSheet; var AllowChange: Boolean);
 Var CNPJ : String ;
begin
  if NewPage.PageIndex > 1 then
  begin
     if not fsCNPJSWOK then
        fsCNPJSWOK := (LerChaveSWH = '') or (edSH_CNPJ.Text = '')  ;

     if not fsCNPJSWOK then
     begin
        CNPJ := '' ;
        if InputQuery('Configuração','Digite o CNPJ da Sw.House',CNPJ) then
           fsCNPJSWOK := (CNPJ = edSH_CNPJ.Text) ;
     end ;

     AllowChange := fsCNPJSWOK ;
     pgConRFD.ActivePageIndex := 0 ;
  end ;
end;

{-------------------------------- Aba Config ----------------------------------}
procedure TFrmACBrMonitor.tsRFDConfigShow(Sender: TObject);
begin
  meRFDDataSwBasico.Text := FormatDateTime('dd/mm/yy',ACBrRFD1.ECF_DataHoraSwBasico) ;
  meRFDHoraSwBasico.Text := FormatDateTime('hh:nn',ACBrRFD1.ECF_DataHoraSwBasico) ;
end;

procedure TFrmACBrMonitor.chRFDClick(Sender: TObject);
 Var OldAtivo : Boolean ;
begin
  OldAtivo := ACBrECF1.Ativo ;
  try
     try
        ACBrECF1.Desativar ;

        if chRFD.Checked then
           ACBrECF1.RFD := ACBrRFD1
        else
           ACBrECF1.RFD := nil ;
     except
        chRFD.OnClick := nil ;
        chRFD.Checked := Assigned( ACBrECF1.RFD )  ;
        chRFD.OnClick := chRFDClick ;

        raise ;
     end ;
  finally
     ACBrECF1.Ativo := OldAtivo ;
  end ;

  AvaliaEstadoTsRFD ;
end;

procedure TFrmACBrMonitor.chRFDIgnoraMFDClick(Sender: TObject);
begin
  ACBrRFD1.IgnoraEcfMfd := chRFDIgnoraMFD.Checked ;
end;

procedure TFrmACBrMonitor.edRFDDirChange(Sender: TObject);
begin
  ACBrRFD1.DirRFD := edRFDDir.Text ;
end;

procedure TFrmACBrMonitor.sbDirRFDClick(Sender: TObject);
begin
  OpenURL( ACBrRFD1.DirRFD );
end;

procedure TFrmACBrMonitor.bRFDMFClick(Sender: TObject);
  Var SL : TStringList ;
begin
  if not ACBrECF1.Ativo then
     raise Exception.Create('ECF não está ativo');

  SL := TStringList.Create ;
  try
     SL.Clear ;
     ACBrECF1.LeituraMemoriaFiscalSerial(now,now,SL);

     mResp.Lines.AddStrings( SL );
  finally
     SL.Free ;
  end ;
end;

procedure TFrmACBrMonitor.cbRFDModeloChange(Sender: TObject);
begin
  lRFDID.Caption     := copy(cbRFDModelo.Text,1,3) ;
  ACBrRFD1.ECF_RFDID := lRFDID.Caption ; 
end;


procedure TFrmACBrMonitor.meRFDDataSwBasicoExit(Sender: TObject);
  Var OldShortDateFormat : String ;
      DT : TDateTime ;
begin
  DT := ACBrRFD1.ECF_DataHoraSwBasico ;
  OldShortDateFormat := ShortDateFormat ;
  try
     ShortDateFormat := 'dd/mm/yyyy hh:nn:ss' ;
     DT := StrToDateTimeDef( meRFDDataSwBasico.Text+' '+meRFDHoraSwBasico.Text, DT ) ;
  finally
     ShortDateFormat := OldShortDateFormat ;
  end ;

  ACBrRFD1.ECF_DataHoraSwBasico := DT ;
end;


{-------------------------------- Aba Usuario ---------------------------------}
procedure TFrmACBrMonitor.tsRFDUsuarioShow(Sender: TObject);
begin
  if not tsRFDUsuario.Enabled then exit ;
  
  if not fsRFDLeuParams then
  begin
     edRFDRazaoSocial.Text     := ACBrRFD1.CONT_RazaoSocial ;
     edRFDEndereco.Text        := ACBrRFD1.CONT_Endereco ;
     edRFDCNPJ.Text            := ACBrRFD1.CONT_CNPJ ;
     edRFDIE.Text              := ACBrRFD1.CONT_IE ;
     seRFDNumeroCadastro.Value := ACBrRFD1.CONT_NumUsuario ;
     meRFDDataCadastro.Text    := FormatDateTime('dd/mm/yy',ACBrRFD1.CONT_DataHoraCadastro) ;
     meRFDHoraCadastro.Text    := FormatDateTime('hh:nn',ACBrRFD1.CONT_DataHoraCadastro) ;
     seRFDCROCadastro.Value    := ACBrRFD1.CONT_CROCadastro ;
     edRFDGTCadastro.Text      := FormatFloat('0.00',ACBrRFD1.CONT_GTCadastro) ;

     fsRFDLeuParams := True ;
  end ;
end;

procedure TFrmACBrMonitor.edRFDRazaoSocialChange(Sender: TObject);
begin
  ACBrRFD1.CONT_RazaoSocial := edRFDRazaoSocial.Text ;
end;

procedure TFrmACBrMonitor.edRFDCNPJChange(Sender: TObject);
begin
  ACBrRFD1.CONT_CNPJ := edRFDCNPJ.Text ;
end;

procedure TFrmACBrMonitor.edRFDEnderecoChange(Sender: TObject);
begin
  ACBrRFD1.CONT_Endereco := edRFDEndereco.Text ;
end;

procedure TFrmACBrMonitor.edRFDIEChange(Sender: TObject);
begin
  ACBrRFD1.CONT_IE := edRFDIE.Text ;
end;

procedure TFrmACBrMonitor.seRFDNumeroCadastroChanged(Sender: TObject;
  NewValue: Integer);
begin
  ACBrRFD1.CONT_NumUsuario := seRFDNumeroCadastro.Value ;
end;

procedure TFrmACBrMonitor.meRFDDataCadastroExit(Sender: TObject);
  Var OldShortDateFormat : String ;
      DT : TDateTime ;
begin
  DT := ACBrRFD1.CONT_DataHoraCadastro ;
  OldShortDateFormat := ShortDateFormat ;
  try
     ShortDateFormat := 'dd/mm/yyyy hh:nn:ss' ;
     DT := StrToDateTimeDef( meRFDDataCadastro.Text+' '+meRFDHoraCadastro.Text, DT ) ;
  finally
     ShortDateFormat := OldShortDateFormat ;
  end ;

  ACBrRFD1.CONT_DataHoraCadastro := DT ;
end;

procedure TFrmACBrMonitor.seRFDCROCadastroChanged(Sender: TObject;
  NewValue: Integer);
begin
  ACBrRFD1.CONT_CROCadastro := seRFDCROCadastro.Value ;
end;

procedure TFrmACBrMonitor.edRFDGTCadastroKeyPress(Sender: TObject;
  var Key: Char);
begin
  if Key in [',','.'] then
     Key := DecimalSeparator ;

  if not ( Key in ['0'..'9',#13,#8, DecimalSeparator] ) then
     Key := #0 ;
end;

procedure TFrmACBrMonitor.edRFDGTCadastroExit(Sender: TObject);
begin
  ACBrRFD1.CONT_GTCadastro := StrToFloatDef(edRFDGTCadastro.Text,ACBrRFD1.CONT_GTCadastro) ;
  edRFDGTCadastro.Text := FormatFloat('0.00',ACBrRFD1.CONT_GTCadastro) ;
end;

{------------------------------ Aba Chave RSA --------------------------------}
procedure TFrmACBrMonitor.tsRFDRSAShow(Sender: TObject);
begin
  if mRFDKey.Text = '' then
     mRFDKey.Text := LerChaveSWH ;
end;

procedure TFrmACBrMonitor.bRFDKeyImportarClick(Sender: TObject);
begin
  OpenDialog1.Filter   := 'Arquivos KEY|*.key|Todos Arquivos|*.*' ;

  if OpenDialog1.Execute then
     mRFDKey.Lines.LoadFromFile( OpenDialog1.FileName );
end;

procedure TFrmACBrMonitor.ACBrRFD1GetKeyRSA(var PrivateKey_RSA: String);
begin
  PrivateKey_RSA := LerChaveSWH ;
end;

procedure TFrmACBrMonitor.bRFDRSAPrivadaClick(Sender: TObject);
begin
  if mRFDKey.Text <> '' then
     raise Exception.Create('Você já possui uma chave RSA.') ;

  try
     { Executando o "openssl.exe"
       Sintaxe de comandos extraidas de:  http://www.madboa.com/geek/openssl/ }

     RunCommand('openssl', 'genrsa -out id.rsa 1024', True, 0);

     { Lendo a resposta }
     try
        mRFDKey.Clear ;
        mRFDKey.Lines.LoadFromFile('id.rsa');
     except
        raise Exception.Create( 'Erro ao gerar Chave Privada, usando o "openssl"' ) ;
     end ;
  finally
     DeleteFile( 'id.rsa' ) ;  // Removendo a chave privada do disco ;
  end;
end;

procedure TFrmACBrMonitor.bRFDRSAPublicaClick(Sender: TObject);
  Var SL : TStringList ;
begin
  if mRFDKey.Text = '' then
     raise Exception.Create('Chave RSA não definida.') ;

  ChDir( ExtractFilePath(Application.ExeName) ) ;
  SL := TStringList.Create ;
  try
     { Gravando a chave RSA temporariamente no DirLog }
     mRFDKey.Lines.SaveToFile( 'id.rsa' );

     { Executando o "openssl.exe"
       Sintaxe de comandos extraidas de:  http://www.madboa.com/geek/openssl/ }

     RunCommand('openssl', 'rsa -in id.rsa -pubout -out rsakey.pub', True, 0);

     { Lendo a resposta }
     try
        SL.Clear ;
        SL.LoadFromFile('rsakey.pub');

        mResp.Lines.AddStrings( SL ) ;
        mResp.Lines.Add('') ;
        mResp.Lines.Add('Chave pública gravada no arquivo: "rsakey.pub"') ;
     except
        raise Exception.Create( 'Erro ao gerar Chave Publica, usando o "openssl"' ) ;
     end ;
  finally
     DeleteFile( 'id.rsa' ) ;  // Removendo a chave privada do disco ;
  end;
end;

{-------------------------------- Aba Sw.House -------------------------------}
procedure TFrmACBrMonitor.edSH_RazaoSocialChange(Sender: TObject);
begin
  ACBrRFD1.SH_RazaoSocial := edSH_RazaoSocial.Text ;
end;

procedure TFrmACBrMonitor.edSH_COOChange(Sender: TObject);
begin
  ACBrRFD1.SH_COO := edSH_COO.Text ;
end;

procedure TFrmACBrMonitor.edSH_CNPJChange(Sender: TObject);
begin
  ACBrRFD1.SH_CNPJ := edSH_CNPJ.Text ;
end;

procedure TFrmACBrMonitor.edSH_IEChange(Sender: TObject);
begin
  ACBrRFD1.SH_IE := edSH_IE.Text ;
end;

procedure TFrmACBrMonitor.edSH_IMChange(Sender: TObject);
begin
  ACBrRFD1.SH_IM := edSH_IM.Text ;
end;

procedure TFrmACBrMonitor.edSH_AplicativoChange(Sender: TObject);
begin
  ACBrRFD1.SH_NomeAplicativo := edSH_Aplicativo.Text ;
end;

procedure TFrmACBrMonitor.edSH_NumeroAPChange(Sender: TObject);
begin
  ACBrRFD1.SH_NumeroAplicativo := edSH_NumeroAP.Text ;
end;

procedure TFrmACBrMonitor.edSH_VersaoAPChange(Sender: TObject);
begin
  ACBrRFD1.SH_VersaoAplicativo := edSH_VersaoAP.Text ;
end;

procedure TFrmACBrMonitor.edSH_Linha1Change(Sender: TObject);
begin
  ACBrRFD1.SH_Linha1 := edSH_Linha1.Text ;
end;

procedure TFrmACBrMonitor.edSH_Linha2Change(Sender: TObject);
begin
  ACBrRFD1.SH_Linha2 := edSH_Linha2.Text ;
end;

{------------------------------ Aba Arquivos  --------------------------------}
procedure TFrmACBrMonitor.tsRFDINIShow(Sender: TObject);
begin
  if fsRFDIni = '' then
     mRFDINI.Clear ;
end;

procedure TFrmACBrMonitor.bRFDINILerClick(Sender: TObject);
begin
  if fsRFDLeuParams then   { Pode ter modificações pendentes da Aba Usuário }
     ACBrRFD1.GravarINI ;
     
  mRFDINI.Lines.LoadFromFile(ACBrRFD1.ArqINI);
  fsRFDIni := 'acbrrfd' ;
end;

procedure TFrmACBrMonitor.bRFDIDClick(Sender: TObject);
begin
  mRFDINI.Lines.LoadFromFile(ACBrRFD1.ArqRFDID);
  fsRFDIni := 'rfdid' ;
end;

procedure TFrmACBrMonitor.bRFDINISalvarClick(Sender: TObject);
begin
  if fsRFDIni = '' then
     exit ;

  if fsRFDIni = 'acbrrfd' then
   begin
     try
        mRFDINI.Lines.SaveToFile(ACBrRFD1.ArqINI);
        ACBrRFD1.Desativar ;        { Desativa e Ativa para re-ler ACBrRFD.ini }
     finally
        ACBrRFD1.Ativar ;
     end ;
   end
  else
     mRFDINI.Lines.SaveToFile(ACBrRFD1.ArqRFDID);
end;



{------------------------------------------------------------------------------}
procedure TFrmACBrMonitor.cbCHQModeloChange(Sender: TObject);
begin
  try
     ACBrCHQ1.Desativar ;
     ACBrCHQ1.Modelo := TACBrCHQModelo( cbCHQModelo.ItemIndex ) ;

     if ACBrCHQ1.Modelo = chqImpressoraECF then
        ACBrCHQ1.ECF       := ACBrECF1 ;
  finally
     cbCHQModelo.ItemIndex := Integer( ACBrCHQ1.Modelo ) ;
     cbCHQPorta.Text       := ACBrCHQ1.Porta ;
  end ;

  bCHQTestar.Enabled     := (ACBrCHQ1.Modelo <> chqNenhuma) ;
  cbCHQPorta.Enabled     := bCHQTestar.Enabled and (ACBrCHQ1.Modelo <> chqImpressoraECF) ;
  chCHQVerForm.Enabled   := bCHQTestar.Enabled ;
  gbCHQDados.Enabled     := bCHQTestar.Enabled ;
  edCHQBemafiINI.Enabled := bCHQTestar.Enabled ;
  sbCHQBemafiINI.Enabled := bCHQTestar.Enabled ;
end ;

{------------------------------------------------------------------------------}
procedure TFrmACBrMonitor.cbGAVModeloChange(Sender: TObject);
begin
  try
     ACBrGAV1.Desativar ;
     ACBrGAV1.Modelo := TACBrGAVModelo( cbGAVModelo.ItemIndex ) ;

     if ACBrGAV1.Modelo = gavImpressoraECF then
        ACBrGAV1.ECF := ACBrECF1 ;
  finally
     cbGAVModelo.ItemIndex := Integer( ACBrGAV1.Modelo ) ;
     cbGAVPorta.Text       := ACBrGAV1.Porta ;
     sedGAVIntervaloAbertura.Value := ACBrGAV1.AberturaIntervalo ;
  end ;

  AvaliaEstadoTsGAV ;
end;

procedure TFrmACBrMonitor.AvaliaEstadoTsGAV;
begin
  bGAVAtivar.Enabled   := (ACBrGAV1.Modelo <> gavNenhuma) ;
  bGAVEstado.Enabled   := ACBrGAV1.Ativo ;
  bGAVAbrir.Enabled    := bGAVEstado.Enabled ;
  cbGAVPorta.Enabled   := not (ACBrGAV1.Modelo in [gavImpressoraECF, gavNenhuma] ) ;
  cbGAVStrAbre.Enabled := (ACBrGAV1.Modelo = gavImpressoraComum) ;
  sedGAVIntervaloAbertura.Enabled     := bGAVAtivar.Enabled ;
  cbGAVAcaoAberturaAntecipada.Enabled := bGAVAtivar.Enabled ;

  bGAVAtivar.Glyph := nil ;
  if ACBrGAV1.Ativo then
   begin
     bGAVAtivar.Caption := '&Desativar' ;
     ImageList1.GetBitmap(6,bGAVAtivar.Glyph);
   end
  else
   begin
     bGAVAtivar.Caption := '&Ativar' ;
     ImageList1.GetBitmap(5,bGAVAtivar.Glyph);
   end ;
end;


{------------------------------------------------------------------------------}
procedure TFrmACBrMonitor.cbDISModeloChange(Sender: TObject);
begin
  try
     ACBrDIS1.Desativar ;
     ACBrDIS1.Modelo := TACBrDISModelo( cbDISModelo.ItemIndex ) ;
  finally
     cbDISModelo.ItemIndex := Integer( ACBrDIS1.Modelo ) ;
     cbDISPorta.Text       := ACBrDIS1.Porta ;
  end ;

  bDISTestar.Enabled     := (ACBrDIS1.Modelo <> disNenhum) ;
  bDISLimpar.Enabled     := bDISTestar.Enabled ;
  bDISAnimar.Enabled     := bDISTestar.Enabled ;
  seDISPassos.Enabled    := bDISTestar.Enabled ;
  seDISIntervalo.Enabled := bDISTestar.Enabled ;
  cbDISPorta.Enabled     := bDISTestar.Enabled and
                 (not (ACBrDIS1.Modelo in [disGertecTeclado, disKeytecTeclado])) ;
  seDISIntByte.Enabled   := bDISTestar.Enabled and (not cbDISPorta.Enabled) ;
end;

{------------------------------------------------------------------------------}
procedure TFrmACBrMonitor.FormShortCut(Key: Integer; Shift: TShiftState;
  var Handled: Boolean);
begin
  if (Key = Key_Help) or (Key = Key_F1) then
     pBotoesClick(self) ;
end;

{------------------------------------------------------------------------------}
procedure TFrmACBrMonitor.pBotoesClick(Sender: TObject);
begin
  frmSobre := TfrmSobre.Create( self );
  try
     frmSobre.lVersao.Caption := 'Ver: '+Versao ;
     frmSobre.ShowModal ;
  finally
     FreeAndNil(frmSobre) ;
  end ;
end;

{------------------------------------------------------------------------------}
procedure TFrmACBrMonitor.bExecECFTesteClick(Sender: TObject);
Var Arquivo : String ;
    OldAtivo: Boolean ;
begin
  OldAtivo := ACBrECF1.Ativo ;
  try
     ACBrECF1.Desativar ;
    {$IFDEF LINUX}
       Arquivo := 'QECFTeste' ;
    {$ELSE}
       Arquivo := 'QECFTeste.exe' ;
    {$ENDIF}

    Arquivo := ExtractFilePath( Application.ExeName ) + Arquivo ;

    if not FileExists( Arquivo ) then
       MessageDlg('Programa: <b>'+Arquivo+ '</b> não encontrado.',mtError,[mbOk],0)
    else
       RunCommand(Arquivo,'',true) ;
  finally
     ACBrECF1.Ativo := OldAtivo ;
  end ;

  AvaliaEstadoTsECF ;
end;

{------------------------------------------------------------------------------}
procedure TFrmACBrMonitor.sbCHQBemafiINIClick(Sender: TObject);
begin
  OpenDialog1.Filter   := 'Arquivos ini|*.ini|Arquivos INI|*.INI' ;
  OpenDialog1.FileName := edCHQBemafiINI.Text ;

  if OpenDialog1.Execute then
  begin
     edCHQBemafiINI.Text := OpenDialog1.FileName ;
     ACBrCHQ1.ArquivoBemaFiINI := edCHQBemafiINI.Text ;
  end ;
end;

{------------------------------------------------------------------------------}
procedure TFrmACBrMonitor.edCHQBemafiINIExit(Sender: TObject);
begin
  ACBrCHQ1.ArquivoBemaFiINI := edCHQBemafiINI.Text ;
end;

{------------------------------------------------------------------------------}
procedure TFrmACBrMonitor.ACBrECF1AguardandoRespostaChange(
  Sender: TObject);
begin
  { ECF sendo usado junto LCB, deve desabilitar o LCB enquando o ECF estiver
    ocupado imprimindo, para evitar de enviar códigos na hora indevida, como
    por exemplo, quando o EDIT / GET do Campos código não está com o FOCO }
  if ACBrLCB1.Ativo then
     if ACBrECF1.AguardandoResposta then
        ACBrLCB1.Intervalo := 0
     else
        ACBrLCB1.Intervalo := sedLCBIntervalo.Value ;
end;

{------------------------------------------------------------------------------}
procedure TFrmACBrMonitor.SetDisWorking(const Value: Boolean);
begin
  if ACBrLCB1.Ativo then
     if Value then
        ACBrLCB1.Intervalo := 0
     else
        ACBrLCB1.Intervalo := sedLCBIntervalo.Value ;

  fsDisWorking := Value;
end;

{---------------------------------- ACBrBAL -----------------------------------}
procedure TFrmACBrMonitor.cbBALModeloChange(Sender: TObject);
begin
  try
     ACBrBAL1.Desativar ;
     if cbBALModelo.ItemIndex >= 0 then
       ACBrBAL1.Modelo := TACBrBALModelo( cbBALModelo.ItemIndex )
     else
     ACBrBAL1.Modelo := balNenhum;
  finally
     cbBALModelo.ItemIndex := Integer( ACBrBAL1.Modelo ) ;
     cbBALPorta.Text       := ACBrBAL1.Porta ;
  end ;

  AvaliaEstadoTsBAL ;
end;

{------------------------------------------------------------------------------}
procedure TFrmACBrMonitor.AvaliaEstadoTsBAL;
begin
  bBALAtivar.Enabled   := (ACBrBAL1.Modelo <> balNenhum) ;
  bBALTestar.Enabled   := ACBrBAL1.Ativo ;
  cbBALPorta.Enabled   := bBALAtivar.Enabled ;
  sedBALIntervalo.Enabled    := bBALAtivar.Enabled ;

  bBALAtivar.Glyph := nil ;
  if ACBrBAL1.Ativo then
   begin
     bBALAtivar.Caption := '&Desativar' ;
     ImageList1.GetBitmap(6,bBALAtivar.Glyph);
   end
  else
   begin
     bBALAtivar.Caption := '&Ativar' ;
     ImageList1.GetBitmap(5,bBALAtivar.Glyph);
   end ;
end;

{------------------------------------------------------------------------------}
procedure TFrmACBrMonitor.cbBALPortaChange(Sender: TObject);
begin
  try
     if ACBrBAL1.Ativo then
        bBALAtivar.Click ;

    ACBrBAL1.Porta := cbBALPorta.Text ;
  finally
     cbBALPorta.Text := ACBrBAL1.Porta ;
  end ;
end;

{------------------------------------------------------------------------------}
procedure TFrmACBrMonitor.sedBALIntervaloChanged(Sender: TObject;
  NewValue: Integer);
begin
  ACBrBal1.Intervalo := sedIntervalo.Value ;
end;

{------------------------------------------------------------------------------}
procedure TFrmACBrMonitor.bBALAtivarClick(Sender: TObject);
begin
  if bBALAtivar.Caption = '&Ativar' then begin
     ACBrBAL1.Ativar ;

     ACBrBAL1.LePeso ;
     if ACBrBAL1.UltimaResposta = '' then begin
        ACBrBAL1.Desativar ;
        mResp.Lines.Add('BAL -> Balança não responde!');
     end;
  end
  else
     ACBrBAL1.Desativar ;

  AvaliaEstadoTsBAL ;
end;

{------------------------------------------------------------------------------}
procedure TFrmACBrMonitor.bBALTestarClick(Sender: TObject);
begin
  ACBrBAL1.LePeso ;
  if ACBrBAL1.UltimaResposta <> '' then
    mResp.Lines.Add(Format('BAL -> Peso Lido: %f', [ACBrBAL1.UltimoPesoLido]))
  else
    mResp.Lines.Add('BAL -> Timeout');
end;

procedure TFrmACBrMonitor.cbETQModeloChange(Sender: TObject);
begin
  try
     ACBrETQ1.Desativar ;
     if cbETQModelo.ItemIndex >= 0 then
       ACBrETQ1.Modelo := TACBrETQModelo( cbETQModelo.ItemIndex )
     else
     ACBrETQ1.Modelo := etqNenhum;
  finally
     cbETQModelo.ItemIndex := Integer( ACBrETQ1.Modelo ) ;
     cbETQPorta.Text       := ACBrETQ1.Porta ;
  end ;
end;

{------------------------------------------------------------------------------}
procedure TFrmACBrMonitor.cbETQPortaChange(Sender: TObject);
begin
  try
    ACBrETQ1.Porta := cbETQPorta.Text ;
  finally
     cbETQPorta.Text := ACBrETQ1.Porta ;
  end ;
end;


{-------------------------- Terminal de Consulta ------------------------------}
procedure TFrmACBrMonitor.tsTCShow(Sender: TObject);
begin
  AvaliaEstadoTsTC ;
end;

{------------------------------------------------------------------------------}
procedure TFrmACBrMonitor.cbxTCModeloChange(Sender: TObject);
begin
  TCPServerTC.Active  := False ;
  TimerTC.Enabled    := False ;
  AvaliaEstadoTsTC ;
end;

{------------------------------------------------------------------------------}
procedure TFrmACBrMonitor.bTCAtivarClick(Sender: TObject);
begin
  TCPServerTC.DefaultPort := StrToIntDef( edTCPort.Text, 6500) ;

  if not FileExists(edTCArqPrecos.Text) then
     raise Exception.Create('Arquivo de Preços não encontrado em: ['+edTCArqPrecos.Text+']');
     
  TCPServerTC.Active := (bTCAtivar.Caption = '&Ativar') ;
  TimerTC.Enabled   := TCPServerTC.Active ;

  AvaliaEstadoTsTC ;

  mResp.Lines.Add( 'Servidor de Terminal de Consulta: '+
          IfThen( TCPServerTC.Active, 'ATIVADO', 'DESATIVADO' ) );
end;

{------------------------------------------------------------------------------}
procedure TFrmACBrMonitor.sbTCArqPrecosEditClick(Sender: TObject);
begin
  OpenURL( edTCArqPrecos.Text );
end;

{------------------------------------------------------------------------------}
procedure TFrmACBrMonitor.AvaliaEstadoTsTC;
begin
  edTCPort.Enabled         := (cbxTCModelo.ItemIndex > 0) ;
  edTCArqPrecos.Enabled    := edTCPort.Enabled ;
  sbTCArqPrecosEdit.Enabled:= edTCPort.Enabled ;
  sbTCArqPrecosFind.Enabled:= edTCPort.Enabled ;

  bTCAtivar.Enabled := edTCPort.Enabled and (StrToIntDef(edTCPort.Text,0) > 0) ;

  bTCAtivar.Glyph := nil ;
  if TCPServerTC.Active then
   begin
     bTCAtivar.Caption := '&Desativar' ;
     shpTC.Color       := clLime ;
     ImageList1.GetBitmap(6,bTCAtivar.Glyph);
   end
  else
   begin
     bTCAtivar.Caption := '&Ativar' ;
     shpTC.Color       := clRed ;
     ImageList1.GetBitmap(5,bTCAtivar.Glyph);
     mTCConexoes.Lines.Clear ;
   end ;
end;

{------------------------------------------------------------------------------}

procedure TFrmACBrMonitor.TCPServerTCConnect(AThread: TIdPeerThread);
 Var IP, Resp, Id : String ;
     Indice : Integer ;
begin
  AThread.Connection.Write('#ok') ;
  Id := trim(AThread.Connection.ReadLn(#0,1000)) ;
{
  AThread.Connection.Write('#alwayslive');
  Resp := trim(AThread.Connection.ReadLn(#0,1000)) ;
  if Resp <> '#alwayslive_ok' then
  begin
     fsLinesLog := 'Resposta Inválida do T.C.' ;
     AThread.Synchronize( AddLinesLog );
     AThread.Connection.Disconnect ;
  end ;
}

  IP := AThread.Connection.Socket.Binding.PeerIP ;

  Indice := mTCConexoes.Lines.IndexOf( IP ) ;
  if Indice < 0 then
  begin
     mTCConexoes.Lines.Add( IP ) ;
     fsLinesLog := 'T.C. Inicio Conexão IP: ['+ IP + '] ID: ['+Id+']'+
                   ' em: '+FormatDateTime('dd/mm/yy hh:nn:ss', now ) ;
     AThread.Synchronize( AddLinesLog );
  end ;
end;

{------------------------------------------------------------------------------}
procedure TFrmACBrMonitor.TCPServerTCDisconnect(AThread: TIdPeerThread);
 Var IP : String ;
     Indice : Integer ;
begin
  IP  := AThread.Connection.Socket.Binding.PeerIP ;
  fsLinesLog := 'T.C. Fim Conexão IP: ['+ IP + '] em: '+
                FormatDateTime('dd/mm/yy hh:nn:ss', now ) ;
  AThread.Synchronize( AddLinesLog );

  Indice := mTCConexoes.Lines.IndexOf( IP ) ;
  if Indice >= 0 then
     mTCConexoes.Lines.Delete( Indice );
end;

{------------------------------------------------------------------------------}
procedure TFrmACBrMonitor.TCPServerTCExecute(AThread: TIdPeerThread);
 Var Comando, Resposta, Linha : AnsiString ;
     Indice, P1, P2 : Integer ;
begin
  { Le o que foi enviado atravez da conexao TCP }
  Comando := Trim(AThread.Connection.ReadLn(#0)) ;
  Comando := StringReplace(Comando,#0,'',[rfReplaceAll]) ;  // Remove nulos
  
  if pos( '#live', Comando ) > 0 then
  begin
     Comando := StringReplace(Comando,'#live','',[rfReplaceAll]) ; // Remove #live
     AThread.Connection.Tag := 0 ;                      // Zera falhas de #live?
  end ;

  if Comando = '' then
     exit ;

  fsLinesLog := 'TC: ['+AThread.Connection.Socket.Binding.PeerIP+
                '] RX: <- ['+Comando+']' ;
  AThread.Synchronize( AddLinesLog );

  if copy(Comando,1,1) = '#' then
  begin
     Comando  := copy( Comando, 2, Length(Comando)) ;
     P1       := 0 ;
     P2       := 0 ;
     Indice   := fsSLPrecos.IndexOfName( Comando ) ;
     if Indice > 0 then
      begin
        Linha := fsSLPrecos[ Indice ] ;
        P1    := Pos('|',Linha) ;
        P2    := PosAt('|',Linha,3) ;
      end
     else
        Linha := edTCNaoEncontrado.Text ;

     if P2 = 0 then
        P2 := Length( Linha )+1 ;

     Resposta := '#' + copy( Linha, P1+1, P2-P1-1 ) ;
     Resposta := LeftStr(Resposta,45) ;  

     AThread.Connection.Write( Resposta ) ;
     AThread.Connection.Tag := 0 ;  // Zera falhas de #live?
     fsLinesLog := '     TX: -> ['+Resposta+']' ;
     AThread.Synchronize( AddLinesLog );
  end ;
end;


{------------------------------------------------------------------------------}
procedure TFrmACBrMonitor.AddLinesLog ;
begin
  if fsLinesLog <> '' then
  begin
     mResp.Lines.Add( fsLinesLog );
     if cbLog.Checked then
        WriteToTXT(ArqLogTXT, fsLinesLog );
     fsLinesLog := '' ;
  end ;
end ;


{------------------------------------------------------------------------------}
procedure TFrmACBrMonitor.TimerTCTimer(Sender: TObject);
 Var I : Integer ;
     AConnection : TIdTCPServerConnection ;
     Resp : String ;
     ATime : TDateTime ;
begin
  // Verificando se o arquivo de Preços foi atualizado //
  if FileAge(edTCArqPrecos.Text) > fsDTPrecos then
  begin
     fsSLPrecos.Clear ;
     fsSLPrecos.LoadFromFile(edTCArqPrecos.Text);
     fsDTPrecos := FileAge(edTCArqPrecos.Text) ;
  end ;

  with TCPServerTC.Threads.LockList do
  try
     for I := 0 to Count-1 do
     begin
        AConnection := TIdPeerThread(Items[I]).Connection ;
        Try
           AConnection.Tag := AConnection.Tag + 1 ;
           AConnection.Write('#live?');
           if AConnection.Tag > 10 then   // 10 Falhas no #live?... desconecte
              AConnection.Disconnect ;
        except
           AConnection.Disconnect ;
        end ;
     end ;
  finally
     TCPServerTC.Threads.UnlockList;
  end;

(*  TCPServerTC.OnRecebeDados := nil ;
  try
     For I := 0 to TCPServerTC.ThreadList.Count-1 do
     begin
        try
           TCPServerTC.ThreadList[I].TCPBlockSocket.SendString('#live?');
           Resp := Trim(TCPServerTC.ThreadList[I].TCPBlockSocket.RecvPacket(2000)) ;
           if Resp <> '#live' then
            begin
              fsLinesLog := 'T.C. não respondeu #live?' ;
              TCPServerTC.ThreadList[I].TCPBlockSocket.CloseSocket ;
            end
           else
              fsLinesLog := 'T.C. #live ok' ;
           AddLinesLog ;
        except
           TCPServerTC.ThreadList[I].TCPBlockSocket.CloseSocket ;
        end ;
     end ;
  finally
     TCPServerTC.OnRecebeDados := TCPServerTCRecebeDados ;
  end ; *)
end;

{------------------------------------------------------------------------------}
procedure TFrmACBrMonitor.sbTCArqPrecosFindClick(Sender: TObject);
begin
  OpenDialog1.Filter   := 'Arquivos txt|*.txt|Arquivos TXT|*.TXT' ;

  if OpenDialog1.Execute then
  begin
     edTCArqPrecos.Text := OpenDialog1.FileName ;
     fsDTPrecos         := 0 ; // Força re-leitura
  end ;
end;

(*
procedure TFrmACBrMonitor.TCPServerTCConecta(
  const TCPBlockSocket: TTCPBlockSocket; var Enviar: String);
 Var IP, Resp, Id : String ;
     Indice : Integer ;
begin
  TCPServerTC.OnRecebeDados := nil ;
  try
     TCPBlockSocket.SendString('#ok') ;
     Id := Trim(TCPBlockSocket.RecvPacket(2000)) ;
     TCPBlockSocket.SendString('#alwayslive');
     Resp := Trim(TCPBlockSocket.RecvPacket(2000)) ;
     if Resp <> '#alwayslive_ok' then
     begin
        fsLinesLog := 'Resposta Inválida do T.C.' ;
        AddLinesLog ;
        TCPBlockSocket.CloseSocket ;
     end ;

     IP := TCPBlockSocket.GetRemoteSinIP ;

     Indice := mTCConexoes.Lines.IndexOf( IP ) ;
     if Indice < 0 then
     begin
        mTCConexoes.Lines.Add( IP ) ;
        fsLinesLog := 'Inicio Conexão TC: ['+Id+'] IP: ['+ IP +
                      '] em: ['+FormatDateTime('dd/mm/yy hh:nn:ss', now )+']' ;
        AddLinesLog ;
     end ;
  finally
     TCPServerTC.OnRecebeDados := TCPServerTCRecebeDados ;
  end ;
end;

procedure TFrmACBrMonitor.TCPServerTCDesConecta(
  const TCPBlockSocket: TTCPBlockSocket; Erro: Integer; ErroDesc: String);
 Var IP : String ;
     Indice : Integer ;
begin
  IP  := TCPBlockSocket.GetRemoteSinIP ;
  fsLinesLog := 'Fim Conexão TC IP: ['+ IP + '] em: '+
                FormatDateTime('dd/mm/yy hh:nn:ss', now ) ;
  AddLinesLog ;

  Indice := mTCConexoes.Lines.IndexOf( IP ) ;
  if Indice >= 0 then
     mTCConexoes.Lines.Delete( Indice );
end;

procedure TFrmACBrMonitor.TCPServerTCRecebeDados(
  const TCPBlockSocket: TTCPBlockSocket; const Recebido: String;
  var Enviar: String);
begin
  { Le o que foi enviado atravez da conexao TCP }
  fsTCComando := Trim(Recebido) ;
  if fsTCComando = '' then
     exit ;

  if fsTCComando = '#live' then
     exit ;

  fsLinesLog := 'TC: ['+TCPBlockSocket.GetRemoteSinIP+
                '] RX: <- ['+fsTCComando+']' ;
  AddLinesLog ;

  if copy(fsTCComando,1,1) = '#' then
  begin
     fsTCResposta := '' ;
     BuscaPreco ;

     if fsTCResposta <> '' then
     begin
        TCPBlockSocket.SendString( fsTCResposta ) ;
        fsLinesLog := '     TX: -> ['+fsTCResposta+']' ;
        AddLinesLog ;
     end ;
  end ;
end;
*)
procedure TFrmACBrMonitor.sbCHQSerialClick(Sender: TObject);
begin
  frConfiguraSerial := TfrConfiguraSerial.Create(self);

  try
     if ACBrCHQ1.Ativo then
        ACBrCHQ1.Desativar ;

    frConfiguraSerial.Device.Porta        := ACBrCHQ1.Device.Porta ;
    frConfiguraSerial.cmbPortaSerial.Text := cbCHQPorta.Text ;
    frConfiguraSerial.Device.ParamsString := ACBrCHQ1.Device.ParamsString ;

    if frConfiguraSerial.ShowModal = mrOk then
    begin
       cbCHQPorta.Text              := frConfiguraSerial.Device.Porta ;
       ACBrCHQ1.Device.ParamsString := frConfiguraSerial.Device.ParamsString ;
    end ;
  finally
     FreeAndNil( frConfiguraSerial ) ;
  end ;

end;

end.

