{******************************************************************************}
{ Projeto: Componentes ACBr                                                    }
{  Biblioteca multiplataforma de componentes Delphi para interação com equipa- }
{ mentos de Automação Comercial utilizados no Brasil                           }
{                                                                              }
{ Direitos Autorais Reservados (c) 2004 Daniel Simoes de Almeida               }
{                                                                              }
{ Colaboradores nesse arquivo:                                                 }
{                                                                              }
{  Você pode obter a última versão desse arquivo na pagina do  Projeto ACBr    }
{ Componentes localizado em      http://www.sourceforge.net/projects/acbr      }
{                                                                              }
{  Esta biblioteca é software livre; você pode redistribuí-la e/ou modificá-la }
{ sob os termos da Licença Pública Geral Menor do GNU conforme publicada pela  }
{ Free Software Foundation; tanto a versão 2.1 da Licença, ou (a seu critério) }
{ qualquer versão posterior.                                                   }
{                                                                              }
{  Esta biblioteca é distribuída na expectativa de que seja útil, porém, SEM   }
{ NENHUMA GARANTIA; nem mesmo a garantia implícita de COMERCIABILIDADE OU      }
{ ADEQUAÇÃO A UMA FINALIDADE ESPECÍFICA. Consulte a Licença Pública Geral Menor}
{ do GNU para mais detalhes. (Arquivo LICENÇA.TXT ou LICENSE.TXT)              }
{                                                                              }
{  Você deve ter recebido uma cópia da Licença Pública Geral Menor do GNU junto}
{ com esta biblioteca; se não, escreva para a Free Software Foundation, Inc.,  }
{ no endereço 59 Temple Street, Suite 330, Boston, MA 02111-1307 USA.          }
{ Você também pode obter uma copia da licença em:                              }
{ http://www.opensource.org/licenses/lgpl-license.php                          }
{                                                                              }
{ Daniel Simões de Almeida  -  daniel@djsystem.com.br  -  www.djsystem.com.br  }
{              Praça Anita Costa, 34 - Tatuí - SP - 18270-410                  }
{                                                                              }
{******************************************************************************}

{******************************************************************************
|* Historico
|*
|* 19/05/2004: Primeira Versao
|*    Daniel Simoes de Almeida
|*    Criaçao e Distribuiçao da Primeira Versao
|* 28/06/2004: Varias modificaçoes. Documentado em ACBrECF.pas ou
|*    ACBr-change-log.txt
|* 05/05/2006: Daniel Simoes de Almeida e Fabio Farias
|*  - Corriga a Perda de foco da aplicação quando usando ExibeMensagem ou
|*    BloqueiaMouseTeclado  (abertura da janela ShowModal )
|* 23/05/2006:  Daniel Simoes de Almeida
|*   - Métodos "ListaRelatorioGerencial" e "ListaCupomVinculado" abstraidos
|*     pela classe TACBrECFClass... eliminando várias linhas de código nas
|*     classes filhas
|* 03/10/2006:  Daniel Simoes de Almeida
|*   - Corrigido Bug no método FormMsgDoProcedure (usado p/ bloqueio do teclado)
|*     A pilha de retorno das Exceções não era executada corretamente
|* 18/12/2006:  J. Luís Schiavo
|*  - Corrigido Bug em DoOnMsgRetentar, Resposta com sinal invertido
|* 13/04/2007:  Daniel Simoes de Almeida
|*  - ArredondaPorQtd não será executado caso o ValorTotal com a Qtd acrescida
|*    fique superior ao Valor Arredondado pretendido. Isso pode ocorrer se o
|*    Preço Unitário é grande... nesses casos não há como ajustar... :-(
|* 05/03/2008:  Daniel Simoes de Almeida / Alexsander Rosa
|*  - Metodos AchaFPGDescricao e AchaCNFDescricao fazem busca por String usando
|*    o mesmo tamanho da String informada em Descricao
******************************************************************************}

{$I ACBr.inc}

Unit ACBrECFClass ;

interface
uses ACBrBase, ACBrDevice,
     SysUtils ,
     Classes,
     ACBrConsts,
     Contnrs
     {$IFNDEF CONSOLE}
       {$IFDEF VisualCLX},
         {$IFDEF QT3CLX} QtLibrary, QtSignalHooks {$ELSE} Qt {$ENDIF},
          QControls, QForms, QGraphics, QDialogs, QExtCtrls
       {$ENDIF}
       {$IFDEF VCL}
          , Controls, Forms, Graphics, Dialogs, ExtCtrls
       {$ENDIF}
     {$ENDIF} ;

type

EACBrECFErro            = class(Exception) ;
EACBrECFCMDInvalido     = class(EACBrECFErro) ;
EACBrECFSemResposta     = class(EACBrECFErro) ;
EACBrECFNaoInicializado = class(EACBrECFErro) ;
EACBrECFOcupado         = class(EACBrECFErro) ;

{ Definindo novo tipo para armazenar Aliquota de ICMS }
TACBrECFAliquota = class
 private
    fsIndice: String;
    fsAliquota: Double ;
    fsTipo: Char;
    fsTotal: Double;
    fsSequencia: Byte;
    procedure SetTipo(const Value: Char);
 public
    constructor create ;
    property Sequencia : Byte   read fsSequencia write fsSequencia ;
    property Indice    : String read fsIndice    write fsIndice ;
    property Aliquota  : Double read fsAliquota  write fsAliquota ;
    property Tipo      : Char read fsTipo write SetTipo ;
    property Total     : Double read fsTotal write fsTotal ;
end;

{ Lista de Objetos do tipo TACBrECFAliquota }
TACBrECFAliquotas = class(TObjectList)
  protected
    procedure SetObject (Index: Integer; Item: TACBrECFAliquota);
    function GetObject (Index: Integer): TACBrECFAliquota;
    procedure Insert (Index: Integer; Obj: TACBrECFAliquota);
  public
    function Add (Obj: TACBrECFAliquota): Integer;
    property Objects [Index: Integer]: TACBrECFAliquota
      read GetObject write SetObject; default;
  end;

{ Definindo novo tipo para armazenar as Formas de Pagamento }
TACBrECFFormaPagamento = class
 private
    fsIndice: String;
    fsDescricao: String;
    fsPermiteVinculado: Boolean;
    fsTotal: Double;
 public
    constructor create ;
    property Indice    : String read fsIndice    write fsIndice ;
    property Descricao : String read fsDescricao write fsDescricao ;
    property PermiteVinculado : Boolean read fsPermiteVinculado
                                       write fsPermiteVinculado ;
    property Total : Double read fsTotal write fsTotal ;
end;

{ Lista de Objetos do tipo TACBrECFFormaPagamento }
TACBrECFFormasPagamento = class(TObjectList)
  protected
    procedure SetObject (Index: Integer; Item: TACBrECFFormaPagamento);
    function GetObject (Index: Integer): TACBrECFFormaPagamento;
  public
    function Add (Obj: TACBrECFFormaPagamento): Integer;
    procedure Insert (Index: Integer; Obj: TACBrECFFormaPagamento);
    property Objects [Index: Integer]: TACBrECFFormaPagamento
      read GetObject write SetObject; default;
  end;

{ Definindo novo tipo para armazenar as unidades de Medida }
TACBrECFUnidadeMedida = class
 private
    fsIndice: String;
    fsDescricao: String;
 public
    constructor create ;
    property Indice    : String read fsIndice    write fsIndice ;
    property Descricao : String read fsDescricao write fsDescricao ;
end;

{ Lista de Objetos do tipo TACBrECFunidadeMedida }
TACBrECFUnidadesMedida = class(TObjectList)
  protected
    procedure SetObject (Index: Integer; Item: TACBrECFUnidadeMedida);
    function GetObject (Index: Integer): TACBrECFUnidadeMedida;
  public
    function Add (Obj: TACBrECFUnidadeMedida): Integer;
    procedure Insert (Index: Integer; Obj: TACBrECFUnidadeMedida);
    property Objects [Index: Integer]: TACBrECFUnidadeMedida
      read GetObject write SetObject; default;
  end;

{ Definindo novo tipo para armazenar os Reletórios Gerenciais (RG) }
TACBrECFRelatorioGerencial = class
 private
    fsIndice: String;
    fsDescricao: String;
    fsContador: Integer;
 public
    constructor create ;
    property Indice    : String read fsIndice    write fsIndice ;
    property Descricao : String read fsDescricao write fsDescricao ;
    property Contador : Integer read fsContador write fsContador;
 end;

{ Lista de Objetos do tipo TACBrECFRelatoriosGerencial }
TACBrECFRelatoriosGerenciais = class(TObjectList)
  protected
    procedure SetObject (Index: Integer; Item: TACBrECFRelatorioGerencial);
    function GetObject (Index: Integer): TACBrECFRelatorioGerencial;
  public
    function Add (Obj: TACBrECFRelatorioGerencial): Integer;
    procedure Insert (Index: Integer; Obj: TACBrECFRelatorioGerencial);
    property Objects [Index: Integer]: TACBrECFRelatorioGerencial
      read GetObject write SetObject; default;
  end;

{ Definindo novo tipo para armazenar os Comprovantes NAO Fiscais (CNF) }
TACBrECFComprovanteNaoFiscal = class
 private
    fsIndice: String;
    fsDescricao: String;
    fsPermiteVinculado: Boolean;
    fsFormaPagamento: String;
    fsTotal: Double ;
    fsContador: Integer;
 public
    constructor create ;
    property Indice    : String read fsIndice    write fsIndice ;
    property Descricao : String read fsDescricao write fsDescricao ;
    property PermiteVinculado : Boolean read fsPermiteVinculado
                                       write fsPermiteVinculado ;
    property FormaPagamento : String read fsFormaPagamento
                                    write fsFormaPagamento ;
    property Total    : Double  read fsTotal    write fsTotal ;
    property Contador : Integer read fsContador write fsContador;
 end;


{ Definindo novo tipo para armazenar o Consumidor que será impresso no CF }
TACBrECFConsumidor = class
 private
    fsNome      : String;
    fsEndereco  : String;
    fsDocumento : String;
    fsEnviado   : Boolean;
    function GetEnviado: Boolean;
    function GetAtribuido: Boolean;
 public
    constructor create ;
    property Enviado   : Boolean read GetEnviado write fsEnviado ;
    property Nome      : String  read fsNome ;
    property Endereco  : String  read fsEndereco ;
    property Documento : String  read fsDocumento  ;
    property Atribuido : Boolean read GetAtribuido ;

    procedure AtribuiConsumidor(CPF_CNPJ, Nome, Endereco: String);
    procedure Zera;
end ;

{ Definindo novo tipo para armazenar o Código de Barras que será impresso no Documento }
TACBrECFCodBarras = class
 private
    fsTipoBarra   : TACBrECFTipoCodBarra;
    fsLanguraBarra: Integer;
    fsAlturaBarra : Integer;
    fsCodigo      : String;
    fsImpCodEmbaixo: Boolean;
    fsImpVertical : Boolean;
    fsEnviado     : Boolean;
    function GetEnviado: Boolean;
    function GetAdicionado: Boolean;
 public
    constructor create ;
    property Enviado      : Boolean               read GetEnviado write fsEnviado ;
    property Tipo         : TACBrECFTipoCodBarra  read fsTipoBarra ;
    property Largura      : Integer               read fsLanguraBarra ;
    property Altura       : Integer               read fsAlturaBarra  ;
    property Codigo       : String                read fsCodigo  ;
    property ImpCodEmbaixo: Boolean               read fsImpCodEmbaixo ;
    property ImpVertical  : Boolean               read fsImpVertical ;
    property Adicionado   : Boolean               read GetAdicionado ;

    procedure AdicionarCodBarra(TipoBarra: TACBrECFTipoCodBarra; LanguraBarra,
      AlturaBarra: Integer; CodBarra: String; ImprimeCodEmbaixo : Boolean = True;
      ImprimeVertical : Boolean = False );
    procedure Zera;
end ;

{ Lista de Objetos do tipo TACBrECFComprovanteNaoFiscal }
TACBrECFComprovantesNaoFiscais = class(TObjectList)
  protected
    procedure SetObject (Index: Integer; Item: TACBrECFComprovanteNaoFiscal);
    function GetObject (Index: Integer): TACBrECFComprovanteNaoFiscal;
  public
    function Add (Obj: TACBrECFComprovanteNaoFiscal): Integer;
    procedure Insert (Index: Integer; Obj: TACBrECFComprovanteNaoFiscal);
    property Objects [Index: Integer]: TACBrECFComprovanteNaoFiscal
      read GetObject write SetObject; default;
  end;

{ Evento para o usuário exibir os erros encontrados pela classe TACBrECFClass.
  Se o evento OnMsgErro NAO for programado a Classe TACBrECFClass exibirá as
  Msg de erro através de Exceçoes. Se o evento OnMsgErro for programado a Classe
  nao exibe nenhuma msg de erro, que deverao ser tratados dentro deste evento }
TACBrECFExibeErroEvent = procedure(Erro : Exception) of object ;

{ Evento para enviar as msg de Aguarde para o Componente  }
TACBrECFMsgAguarde = procedure(const Mensagem : String) of object ;

{ Evento para enviar mensagem de Retentar para o Componente }
TACBrECFMsgRetentar = procedure(const Mensagem : String;
   const Situacao : String; var Result : Boolean) of object ;

{ Evento disparado quando o componente adicionar algo em MemoBobina  }
TACBrECFBobinaAdicionaLinhas = procedure(const Linhas : String;
   const Operacao : String) of object ;

TACBrFormMsgProcedure = procedure of object ;

TACBrFormMsgEstado = (fmsNenhum, fmsProcessando, fmsConcluido, fmsAbortado) ;

{ Classe generica de ECF, nao implementa nenhum modelo especifico, apenas
  declara a Classe. NAO DEVE SER INSTANCIADA. Usada apenas como base para
  as demais Classes de ECF como por exemplo a classe TACBrECFBematech  }

{ Nota sobre procimentos e funções VIRTUAL. Essas funçoes/procedimentos PODEM
  ou NAO ser implementados nas Classes filhas com a clausula OVERRIDE. Se não
  forem implementadas nas classes filhas, a funçao/procedimento definida aqui
  nessa classe (TACBrECFClass) e que será execuada }

TACBrECFClass = class
 private
    fsRetentar     : Boolean;

    fsBloqueiaMouseTeclado: Boolean;
    fsExibeMensagem: Boolean;
    fsTempoInicioMsg: Integer;
    fsIntervaloAposComando: Integer ;
    fsMsgAguarde: String;
    fsMsgTrabalhando: String;
    fsMsgRelatorio : String;
    fsPausaRelatorio : Integer ;
    fsLinhasEntreCupons : Integer ;
    fsMaxLinhasBuffer : Integer ;
    fsMsgPausaRelatorio : String ;
    fsMsgPoucoPapel: Integer;
    fsDescricaoGrande: Boolean;
    fsOnMsgErro    : TACBrECFExibeErroEvent ;
    fsOnMsgAguarde : TACBrECFMsgAguarde ;
    fsAguardandoResposta: Boolean;
    fsOnAguardandoRespostaChange: TNotifyEvent;
    fsOnMsgPoucoPapel: TNotifyEvent;
    fsOnMsgRetentar : TACBrECFMsgRetentar ;
    fsOperador: String;
    fsBytesRec : Integer ;
    fsAguardaImpressao: Boolean;

    {$IFNDEF CONSOLE}
      fsFormMsg: TForm ;           { Form para exibir Msgs de Aguarde... }
      fsFormMsgFont  : TFont ;
      fsFormMsgColor : TColor ;
      fsFormMsgProcedureAExecutar : TACBrFormMsgProcedure ;
      fsFormMsgTeclaParaFechar    : Word ;
      fsFormMsgEstado             : TACBrFormMsgEstado ;
      fsFormMsgControla : Boolean ;
      fsFormMsgException: String  ;
    {$ENDIF}

    fsRelatorio : TStrings ;
    fsVias      : Word ;
    fsIndiceRG  : Integer;

    procedure SetAtivo(const Value: Boolean);
    procedure SetTimeOut(const Value: Integer);
    function GetTimeOut: Integer;

    procedure ErroAbstract( NomeProcedure : String ) ;
    function GetAliquotas: TACBrECFAliquotas;
    function GetFormasPagamentos: TACBrECFFormasPagamento;
    procedure SetAguardandoResposta(const Value: Boolean);
    function GetComprovantesNaoFiscais: TACBrECFComprovantesNaoFiscais;
    function GetUnidadesMedida: TACBrECFUnidadesMedida;
    function GetRelatoriosGerenciais: TACBrECFRelatoriosGerenciais;

    {$IFNDEF CONSOLE}
      procedure FormMsgTimer(Sender: TObject);
      procedure FormMsgCloseQuery(Sender: TObject; var CanClose: Boolean);
      procedure FormMsgKeyPress(Sender: TObject; var Key: Char);

      {$IFDEF VisualCLX}
       procedure FormMsgEvent(Sender: QObjectH; Event: QEventH;
         var Handled: Boolean);
      {$ENDIF}
      {$IFDEF LINUX}
       {$IFNDEF FPC}
        procedure FormShow(Sender: TObject);
       {$ENDIF}
      {$ENDIF}
      function FormMsgExibe : Boolean;
    {$ENDIF}

    procedure DoLeResposta ;
    procedure DoRelatorioGerencial ;
    procedure DoCupomVinculado ;
 Protected
    fpDevice : TACBrDevice ;
    fpOwner  : TComponent ;   { Componente ACBrECF }
    fpAtivo  : Boolean ;
    fpColunas: Integer;
    fpRFDID  : String;
    fpModeloStr: String;
    fpComandoEnviado: AnsiString;
    fpRespostaComando: AnsiString;
    fpUltimaMsgPoucoPapel : TDateTime ;
    fpEstado: TACBrECFEstado;
    fpArredondaPorQtd: Boolean;
    fpDecimaisPreco: Integer;
    fpDecimaisQtd: Integer;
    fpArqLOG: String;
    fpComandoLOG: AnsiString;
    fpMFD: Boolean;
    fpTermica: Boolean;
    fpIdentificaConsumidorRodape: Boolean;

    { Coleçao de objetos TACBrECFAliquota }
    fpAliquotas: TACBrECFAliquotas;
    { Coleçao de objetos TACBrECFFormasPagamento }
    fpFormasPagamentos : TACBrECFFormasPagamento;
    { Coleçao de objetos TACBrECFRelatórios Gerenciais }
    fpRelatoriosGerenciais : TACBrECFRelatoriosGerenciais;
    { Coleçao de objetos TACBrECFComprovantesNaoFiscais }
    fpComprovantesNaoFiscais : TACBrECFComprovantesNaoFiscais;
    { Coleçao de objetos TACBrECFUnidadesMedida}
    fpUnidadesMedida : TACBrECFUnidadesMedida;

    fpConsumidor : TACBrECFConsumidor ;

    fpCodBarras  : TACBrECFCodBarras ;

    procedure GeraErro( E : Exception ) ;

    function GetModeloStr: String; virtual ;
    function GetDataHora: TDateTime; virtual ;
    function GetNumCupom: String; virtual ;
    function GetNumECF: String; virtual ;
    function GetNumLoja: String; virtual ;
    function GetNumSerie: String; virtual ;
    function GetNumVersao: String ; virtual ;
    function GetSubTotal: Double; virtual ;
    function GetTotalPago: Double; virtual ;

    function GetCNPJ: String; virtual ;
    function GetIE: String; virtual ;
    function GetPAF: String; virtual ;
    function GetDataMovimento: TDateTime; virtual ;
    function GetGrandeTotal: Double; virtual ;
    function GetNumCRO: String; virtual ;
    function GetNumCCF: String; virtual ;
    function GetNumGNF: String; virtual ;
    function GetNumGRG: String; virtual ;
    function GetNumCDC: String; virtual ;
    function GetNumCRZ: String; virtual ;
    function GetVendaBruta: Double; virtual ;
    function GetTotalAcrescimos: Double; virtual ;
    function GetTotalCancelamentos: Double; virtual ;
    function GetTotalDescontos: Double; virtual ;
    function GetTotalSubstituicaoTributaria: Double; virtual ;
    function GetTotalNaoTributado: Double; virtual ;
    function GetTotalIsencao: Double; virtual ;
    function GetTotalNaoFiscal: Double; virtual ;
    function GetNumCOOInicial: String; virtual ;
    function GetNumUltimoItem: Integer; virtual ;

    function GetDadosUltimaReducaoZ: AnsiString; Virtual ;

    function GetEstado: TACBrECFEstado; virtual ;
    function GetGavetaAberta: Boolean; virtual ;
    function GetPoucoPapel : Boolean; virtual ;
    function GetHorarioVerao: Boolean; virtual ;
    function GetArredonda: Boolean; virtual ;
    function GetChequePronto: Boolean; virtual ;

    Function EnviaComando_ECF( cmd : AnsiString ) : AnsiString ; virtual ;

    procedure LeResposta ; virtual ;
    function TransmiteComando( Cmd : AnsiString ) : Boolean ; virtual ;

    function VerificaFimLeitura(var Retorno: AnsiString; var TempoLimite: TDateTime) : Boolean ; virtual ;
    function VerificaFimImpressao(var TempoLimite: TDateTime) : Boolean ; virtual ;
    Procedure VerificaEmLinha( TimeOut : Integer = 3) ; virtual ;

    procedure ListaRelatorioGerencial(Relatorio : TStrings; Vias : Integer = 1; Indice: Integer = 0);
       virtual ;
    Procedure ListaCupomVinculado( Relatorio : TStrings; Vias : Integer = 1) ;
       virtual ;
    procedure PausarRelatorio( Via : Integer) ;

    procedure DoOnMsgPoucoPapel( Mensagem : String = '') ;
    Function DoOnMsgRetentar( const Mensagem : String;
       const Situacao : String = '') : Boolean ;

    procedure ImprimirLinhaALinha( Texto, Cmd : AnsiString ) ;
    procedure GravaLog(AString: AnsiString; Traduz :Boolean = False);
 public
    Constructor create( AOwner : TComponent ) ;
    Destructor Destroy  ; override ;

    Property Ativo  : Boolean read fpAtivo write SetAtivo ;
    procedure Ativar ; virtual ;
    procedure Desativar ; virtual ;

    property ArredondaPorQtd : Boolean read fpArredondaPorQtd
       write fpArredondaPorQtd ;
    property DecimaisPreco : Integer read fpDecimaisPreco
       write fpDecimaisPreco default 3 ;
    property DecimaisQtd : Integer read fpDecimaisQtd
       write fpDecimaisQtd default 3 ;
    property ArqLOG : String read fpArqLOG write fpArqLOG ;
    property ComandoLOG : AnsiString read fpComandoLOG write fpComandoLOG ;
    property AguardaImpressao : Boolean read fsAguardaImpressao
       write fsAguardaImpressao ;

    {$IFNDEF CONSOLE}
      function FormMsgDoProcedure( AProcedure : TACBrFormMsgProcedure;
         TeclaParaFechar : Word) : Boolean ;
      procedure FormMsgPinta( Texto : String ) ;
      property FormMsgEstado   : TACBrFormMsgEstado read fsFormMsgEstado ;
      property FormMsgControla : Boolean read fsFormMsgControla write fsFormMsgControla ;
    {$ENDIF}
    
    { Proriedades de uso interno, configurando o funcionamento da classe,
      atribuidas pelo Objeto TACBrECF dono dessa classe }
//    property OnMsgErro : TACBrECFExibeErroEvent read  fpOnMsgErro
//                write fpOnMsgErro ;
    property OnMsgAguarde : TACBrECFMsgAguarde
        read  fsOnMsgAguarde write fsOnMsgAguarde ;
    property OnAguardandoRespostaChange : TNotifyEvent
        read fsOnAguardandoRespostaChange write fsOnAguardandoRespostaChange ;
    property OnMsgPoucoPapel : TNotifyEvent
        read fsOnMsgPoucoPapel write fsOnMsgPoucoPapel ;
    property OnMsgRetentar : TACBrECFMsgRetentar
        read  fsOnMsgRetentar write fsOnMsgRetentar ;

    Property TimeOut  : Integer read GetTimeOut write SetTimeOut ;
    Property Retentar : Boolean read fsRetentar write fsRetentar ;

    property BloqueiaMouseTeclado : Boolean read  fsBloqueiaMouseTeclado
                                            write fsBloqueiaMouseTeclado ;
    property Operador   : String  read fsOperador   write fsOperador ;
    property MsgAguarde : String  read fsMsgAguarde write fsMsgAguarde ;
    property MsgTrabalhando : String read fsMsgTrabalhando write fsMsgTrabalhando ;
    property MsgRelatorio : String  read fsMsgRelatorio write fsMsgRelatorio ;
    property PausaRelatorio : Integer read fsPausaRelatorio
                write fsPausaRelatorio ;
    property LinhasEntreCupons : Integer read fsLinhasEntreCupons
                write fsLinhasEntreCupons ;
    property MaxLinhasBuffer : Integer read fsMaxLinhasBuffer
                write fsMaxLinhasBuffer ;
    property MsgPausaRelatorio : String  read fsMsgPausaRelatorio
                write fsMsgPausaRelatorio ;
    property ExibeMensagem : Boolean read fsExibeMensagem write fsExibeMensagem ;
    property TempoInicioMsg : Integer read  fsTempoInicioMsg
                                      write fsTempoInicioMsg ;
    Property IntervaloAposComando : Integer read  fsIntervaloAposComando
                                            write fsIntervaloAposComando ;
    property MsgPoucoPapel : Integer read  fsMsgPoucoPapel
                                     write fsMsgPoucoPapel  ;
    property DescricaoGrande : Boolean read fsDescricaoGrande
                                      write fsDescricaoGrande ;

    { Proriedades ReadOnly }
    Property Colunas  : Integer read fpColunas  ;
    Property ModeloStr: String  read GetModeloStr ;
    Property RFDID    : String  read fpRFDID ;
    Property AguardandoResposta : Boolean read fsAguardandoResposta
       write SetAguardandoResposta ;
    { String com Comando exatamente como foi enviado para impressora }
    Property ComandoEnviado : AnsiString read fpComandoEnviado
       write fpComandoEnviado ;
    { String com a Resposta Completa da Impressora (sem tratamentos) }
    Property RespostaComando : AnsiString read fpRespostaComando
       write fpRespostaComando ;
    
    { Propriedades relacionadas aos dados do ECF }
    { ECF - Variaveis }
    Property DataHora  : TDateTime read GetDataHora  ;
    Property NumCupom  : String    read GetNumCupom  ;
    Property NumLoja   : String    read GetNumLoja   ;
    Property NumECF    : String    read GetNumECF    ;
    Property NumSerie  : String    read GetNumSerie  ;
    Property NumVersao : String    read GetNumVersao ;

    { Dados da Reducao Z - Registro 60M }
    Property DataMovimento      : TDateTime  read GetDataMovimento ;
    Property CNPJ               : String     read GetCNPJ ;
    Property IE                 : String     read GetIE ;
    Property PAF                : String     read GetPAF ;
    Property NumCRZ             : String     read GetNumCRZ ;
    Property NumCRO             : String     read GetNumCRO ;
    Property NumCCF             : String     read GetNumCCF ;
    Property NumGNF             : String     read GetNumGNF ;
    Property NumGRG             : String     read GetNumGRG ;
    Property NumCDC             : String     read GetNumCDC ;
    Property NumCOOInicial      : String     read GetNumCOOInicial ;
    Property VendaBruta         : Double     read GetVendaBruta ;
    Property GrandeTotal        : Double     read GetGrandeTotal ;
    Property TotalCancelamentos : Double     read GetTotalCancelamentos ;
    Property TotalDescontos     : Double     read GetTotalDescontos ;
    Property TotalAcrescimos    : Double     read GetTotalAcrescimos ;
    Property TotalSubstituicaoTributaria : Double
       read GetTotalSubstituicaoTributaria ;
    Property TotalNaoTributado  : Double     read GetTotalNaoTributado ;
    Property TotalIsencao       : Double     read GetTotalIsencao ;
    Property NumUltItem         : Integer    read GetNumUltimoItem ;
    Property TotalNaoFiscal     : Double     read GetTotalNaoFiscal ;

    Property DadosUltimaReducaoZ : AnsiString read GetDadosUltimaReducaoZ ;

    { Aliquotas de ICMS }
    procedure CarregaAliquotas ; virtual ;
    procedure LerTotaisAliquota ; virtual ;
    Property Aliquotas : TACBrECFAliquotas read GetAliquotas ;
    function AchaICMSAliquota( Aliquota : Double; Tipo : Char = ' ' ) :
       TACBrECFAliquota ;  overload ; virtual;
    function AchaICMSAliquota( var AliquotaICMS : String ) :
       TACBrECFAliquota ;  overload ; virtual;
    function AchaICMSIndice( Indice : String ) : TACBrECFAliquota ; virtual ;
    Procedure ProgramaAliquota( Aliquota : Double; Tipo : Char = 'T';
       Posicao : String = '') ; virtual ;

    { Formas de Pagamento }
    procedure CarregaFormasPagamento ; virtual ;
    procedure LerTotaisFormaPagamento ; virtual ;
    Property FormasPagamento : TACBrECFFormasPagamento read GetFormasPagamentos;
    function AchaFPGDescricao( Descricao : String;
       BuscaExata : Boolean = False ) : TACBrECFFormaPagamento ;
       virtual ;
    function AchaFPGIndice( Indice : String ) : TACBrECFFormaPagamento ;
       virtual ;
    Procedure ProgramaFormaPagamento( var Descricao: String;
       PermiteVinculado : Boolean = true; Posicao : String = '' ) ; virtual ;

    { Relatório Gerencial (RG) }
    procedure CarregaRelatoriosGerenciais ; virtual ;
    Property RelatoriosGerenciais : TACBrECFRelatoriosGerenciais
       read GetRelatoriosGerenciais ;
    function AchaRGDescricao( Descricao : String;
       BuscaExata : Boolean = False ) : TACBrECFRelatorioGerencial ; virtual ;
    function AchaRGIndice( Indice : String ) : TACBrECFRelatorioGerencial ;
       virtual ;
    Procedure ProgramaRelatorioGerencial( var Descricao: String;
       Posicao : String = '') ; virtual ;

    { Comprovantes Nao Fiscais (CNF) }
    procedure CarregaComprovantesNaoFiscais ; virtual ;
    procedure LerTotaisComprovanteNaoFiscal ; virtual ;
    Property ComprovantesNaoFiscais : TACBrECFComprovantesNaoFiscais
       read GetComprovantesNaoFiscais ;
    function AchaCNFDescricao( Descricao : String;
       BuscaExata : Boolean = False ) : TACBrECFComprovanteNaoFiscal ; virtual ;
    function AchaCNFIndice( Indice : String ) : TACBrECFComprovanteNaoFiscal ;
       virtual ;
    function AchaCNFFormaPagamento( CodFPG : String ) :
       TACBrECFComprovanteNaoFiscal ; virtual ;
    Procedure ProgramaComprovanteNaoFiscal( var Descricao: String;
       Tipo : String = ''; Posicao : String = '') ; virtual ;

    { Unidades de Medida (UMD) }
    procedure CarregaUnidadesMedida ; virtual ;
    Property UnidadesMedida : TACBrECFUnidadesMedida read GetUnidadesMedida;
    function AchaUMDDescricao( Descricao : String ) : TACBrECFUnidadeMedida ;
       virtual ;
    function AchaUMDIndice( Indice : String ) : TACBrECFUnidadeMedida ;
       virtual ;
    Procedure ProgramaUnidadeMedida( var Descricao: String) ; virtual ;

    { ECF - Flags }
    Function EmLinha( lTimeOut : Integer = 1) : Boolean ; virtual ;
    Property PoucoPapel   : Boolean read GetPoucoPapel ;
    Property Estado       : TACBrECFEstado read GetEstado ;
    Property HorarioVerao : Boolean read GetHorarioVerao ;
    Property Arredonda    : Boolean read GetArredonda ;
    Property Termica      : Boolean read fpTermica ;
    Property MFD          : Boolean read fpMFD ;
    Property IdentificaConsumidorRodape : Boolean read fpIdentificaConsumidorRodape ;

    { Procedimentos de Cupom Fiscal }
    property Consumidor : TACBrECFConsumidor read fpConsumidor ;
    Procedure AbreCupom ; virtual ;
    procedure LegendaInmetroProximoItem ; Virtual ; 
    Procedure VendeItem( Codigo, Descricao : String; AliquotaECF : String;
       Qtd : Double ; ValorUnitario : Double; ValorDescontoAcrescimo : Double = 0;
       Unidade : String = ''; TipoDescontoAcrescimo : String = '%';
       DescontoAcrescimo : String = 'D' ) ; virtual ;
    Procedure SubtotalizaCupom( DescontoAcrescimo : Double = 0;
       MensagemRodape : AnsiString = '' ) ;
       virtual ;
    procedure CancelaDescontoAcrescimoSubTotal(TipoAcrescimoDesconto: Char) ;
       Virtual ;{ A -> Acrescimo D -> Desconto } 
    Procedure EfetuaPagamento( CodFormaPagto : String; Valor : Double;
       Observacao : AnsiString = ''; ImprimeVinculado : Boolean = false) ;
       virtual ;
    procedure EstornaPagamento(const CodFormaPagtoEstornar,
      CodFormaPagtoEfetivar : String; const Valor: Double;
      Observacao : AnsiString = '') ; Virtual ;

    { Para quebrar linhas nos parametros Observacao use #10 ou chr(10),
      Geralmente o ECF aceita no máximo 8 linhas }
    Procedure FechaCupom( Observacao : AnsiString = ''; IndiceBMP : Integer = 0) ; virtual ;
    Procedure CancelaCupom ; virtual ;
    Procedure CancelaItemVendido( NumItem : Integer ) ; virtual ;
    procedure CancelaItemVendidoParcial( NumItem : Integer;
      Quantidade : Double) ; Virtual ; 
    procedure CancelaDescontoAcrescimoItem( NumItem : Integer) ; Virtual ; 
    Property Subtotal  : Double read GetSubTotal ;
    Property TotalPago : Double read GetTotalPago ;

    { Procedimentos de Cupom Não Fiscal }
    Procedure NaoFiscalCompleto( CodCNF : String; Valor : Double;
       CodFormaPagto  : String; Obs : AnsiString = ''; IndiceBMP : Integer = 0 ) ; virtual ;
    Procedure AbreNaoFiscal( CPF_CNPJ : String = '') ; virtual ;
    Procedure RegistraItemNaoFiscal( CodCNF : String; Valor : Double;
       Obs : AnsiString = '') ; virtual ;
    Procedure SubtotalizaNaoFiscal( DescontoAcrescimo : Double = 0;
       MensagemRodape: AnsiString = '') ; virtual ;
    Procedure EfetuaPagamentoNaoFiscal( CodFormaPagto : String; Valor : Double;
       Observacao : AnsiString = ''; ImprimeVinculado : Boolean = false) ; virtual ;
    Procedure FechaNaoFiscal( Observacao : AnsiString = ''; IndiceBMP : Integer = 0) ; virtual ;
    Procedure CancelaNaoFiscal ; virtual ;

    procedure Sangria( const Valor: Double;  Obs : AnsiString;
       DescricaoCNF: String; DescricaoFPG: String ) ; virtual ;
    procedure Suprimento( const Valor: Double; Obs : AnsiString;
       DescricaoCNF: String; DescricaoFPG: String) ; virtual ;

    { Gaveta de dinheiro }
    Procedure AbreGaveta  ; virtual ;
    Property GavetaAberta : Boolean read GetGavetaAberta ;

    { Relatorios }
    Procedure LeituraX ; virtual ;
    Procedure LeituraXSerial( var Linhas : TStringList) ; virtual ;
    Procedure ReducaoZ( DataHora : TDateTime = 0 ) ; virtual ;
    Procedure RelatorioGerencial(Relatorio : TStrings; Vias : Integer = 1; Indice: Integer = 0) ;
    Procedure AbreRelatorioGerencial(Indice: Integer = 0) ; virtual ;
    Procedure LinhaRelatorioGerencial( Linha : AnsiString; IndiceBMP: Integer = 0 ) ; virtual ;

    Procedure CupomVinculado(COO, CodFormaPagto, CodComprovanteNaoFiscal :
       String; Valor : Double;  Relatorio : TStrings;
       Vias : Integer = 1) ;
    Procedure AbreCupomVinculado(COO, CodFormaPagto, CodComprovanteNaoFiscal :
       String; Valor : Double) ; virtual ; 
    Procedure LinhaCupomVinculado( Linha : AnsiString ) ; virtual ;

    Procedure FechaRelatorio ; virtual ;
    Procedure PulaLinhas( NumLinhas : Integer = 0 ) ; virtual ;
    Procedure CortaPapel( const CorteParcial : Boolean = false) ; virtual ;

    { Cheques }
    Procedure ImprimeCheque(Banco : String; Valor : Double ; Favorecido,
       Cidade : String; Data : TDateTime ;Observacao : String = '') ; virtual ;
    Procedure CancelaImpressaoCheque ; virtual ;
    Function LeituraCMC7 : AnsiString ; virtual ;
    Property ChequePronto : Boolean read GetChequePronto ;

    { Utilitarios e Diversos }
    Procedure MudaHorarioVerao ; overload ; virtual ;
    Procedure MudaHorarioVerao( EHorarioVerao : Boolean ) ; overload ; virtual ;
    Procedure MudaArredondamento( Arredondar : Boolean ) ; virtual ;
    Procedure PreparaTEF ; virtual ; { Carrega as Formas, de Pagamento e CNF,
                            verifica por Vinculos, etc Particular de cada ECF }
    Procedure CorrigeEstadoErro( Reducao: Boolean = True ) ; virtual ; { Verifica o estado da impressora e
                                              tenta deixar em estado Livre }
    Procedure ImpactoAgulhas( NivelForca : Integer = 2) ; virtual ;
    Procedure LeituraMemoriaFiscal( DataInicial, DataFinal : TDateTime;
       Simplificada : Boolean = False ) ; overload ; virtual ;
    Procedure LeituraMemoriaFiscal( ReducaoInicial, ReducaoFinal : Integer;
       Simplificada : Boolean = False ); overload ; virtual ;
    Procedure LeituraMemoriaFiscalSerial( DataInicial, DataFinal : TDateTime;
       var Linhas : TStringList; Simplificada : Boolean = False ) ;
       overload ; virtual ;
    Procedure LeituraMemoriaFiscalSerial( ReducaoInicial, ReducaoFinal: Integer;
       var Linhas : TStringList; Simplificada : Boolean = False ) ;
       overload ; virtual ;
    Procedure LeituraMFDSerial( DataInicial, DataFinal : TDateTime;
       var Linhas : TStringList; Documentos : TACBrECFTipoDocumentoSet = [docTodos] ) ; overload ; virtual ;
    Procedure LeituraMFDSerial( COOInicial, COOFinal : Integer;
       var Linhas : TStringList; Documentos : TACBrECFTipoDocumentoSet = [docTodos] ) ; overload ; virtual ;
    Procedure IdentificaOperador(Nome : String); virtual;
    Procedure IdentificaPAF( Linha1, Linha2 : String) ; virtual ;
    Function RetornaInfoECF( Registrador: String) : AnsiString; Virtual ;

    { Retorna a Resposta do ECF }
    Function EnviaComando( cmd : AnsiString = '') : AnsiString ; overload ;
    { Versao que Permite mudar o TimeOut padrao }
    Function EnviaComando( cmd : AnsiString; lTimeOut : Integer): AnsiString; overload ;
    { Versao que Permite mudar o TimeOut padrao e o TempoInicioMsg }
    Function EnviaComando( cmd : AnsiString; lTimeOut, lTempoInicioMsg : Integer):
       AnsiString; overload ;

    { Gera erro se nao puder abrir Cupom, informando o motivo }
    Function TestaPodeAbrirCupom : Boolean ; virtual ;

    { Obs: De/Codifica e Verifica Textos C-->  Codifica D--> Decodifica V--> Verifica }
    function DecodificaTexto(Operacao: Char; Texto: String; var Resposta: String): Boolean; virtual;

    { priedade que acessa as informações do codbarras }
    property CodBarras : TACBrECFCodBarras read fpCodBarras ;

end ;

function AjustaLinhas(Texto: AnsiString; Colunas: Integer ;
   NumMaxLinhas: Integer = 0; PadLinhas: Boolean = False): AnsiString;

implementation
Uses ACBrECF, ACBrUtil, Math,
     {$IFDEF COMPILER6_UP} DateUtils, StrUtils {$ELSE} ACBrD5, Windows {$ENDIF},
     TypInfo ;

function AjustaLinhas(Texto: AnsiString; Colunas: Integer ;
   NumMaxLinhas: Integer = 0; PadLinhas: Boolean = False): AnsiString;
Var Count,P,I : Integer ;
    Linha : AnsiString ;
begin
  { Trocando todos os #13+#10 por #10 }
  Texto := StringReplace(Texto,CR+LF,#10,[rfReplaceAll]) ;
  Texto := StringReplace(Texto,sLineBreak,#10,[rfReplaceAll]) ;

  { Ajustando a largura das Linhas para o máximo permitido em  "Colunas"
    e limitando em "NumMaxLinhas" o total de Linhas}
  Count  := 0 ;
  Result := '' ;
  while ((Count < NumMaxLinhas) or (NumMaxLinhas = 0)) and
        (Length(Texto) > 0) do
  begin
     P := pos(#10, Texto) ;
     if P > (Colunas + 1) then
        P := Colunas + 1 ;

     if P = 0 then
        P := min( Length( Texto ), Colunas ) + 1 ;

     I := 0 ;
     if copy(Texto,P,1) = #10 then   // Pula #10 ?
        I := 1 ;

     Linha := copy(Texto,1,P-1) ;    // Remove #10 (se hover)

     if PadLinhas then
        Result := Result + padL( Linha, Colunas) + #10
     else
        Result := Result + Linha + #10 ;

     Inc(Count) ;
     Texto := copy(Texto, P+I, Length(Texto) ) ;
  end ;

  { Permitir impressão de uma linha em branco --Acrescentado por Marciano Lizzoni }
  if Result = '' then
    Result := Result + #10;
end;

{ ---------------------------- TACBrECFAliquotas -------------------------- }

{ TACBrECFAliquota }
constructor TACBrECFAliquota.create;
begin
  fsSequencia:= 0 ;
  fsIndice   := ''  ;
  fsAliquota := 0   ;
  fsTipo     := 'T' ;
  fsTotal    := 0 ;
end;

procedure TACBrECFAliquota.SetTipo(const Value: Char);
  Var NewVar : Char ;
begin
  NewVar := UpCase(Value) ;
  if NewVar = ' ' then
     NewVar := 'T' ;
     
  if not (NewVar in ['T','S']) then
     raise Exception.create(cACBrECFAliquotaSetTipoException);
  fsTipo := Value;
end;

function TACBrECFAliquotas.Add(Obj: TACBrECFAliquota): Integer;
begin
  Result := inherited Add(Obj) ;
  Obj.Sequencia := Count ;
end;

function TACBrECFAliquotas.GetObject(Index: Integer): TACBrECFAliquota;
begin
  Result := inherited GetItem(Index) as TACBrECFAliquota ;
end;

procedure TACBrECFAliquotas.Insert(Index: Integer; Obj: TACBrECFAliquota);
begin
  inherited Insert(Index, Obj);
end;

procedure TACBrECFAliquotas.SetObject(Index: Integer; Item: TACBrECFAliquota);
begin
  inherited SetItem (Index, Item) ;
end;


{ --------------------------- TACBrECFFormasPagamento ---------------------- }

{ TACBrECFFormaPagamento }
constructor TACBrECFFormaPagamento.create;
begin
  fsIndice           := '' ;
  fsDescricao        := '' ;
  fsPermiteVinculado := true ;
  fsTotal            := 0 ;
end;

function TACBrECFFormasPagamento.Add(Obj: TACBrECFFormaPagamento): Integer;
begin
  Result := inherited Add(Obj) ;
end;

function TACBrECFFormasPagamento.GetObject( Index: Integer):
   TACBrECFFormaPagamento;
begin
  Result := inherited GetItem(Index) as TACBrECFFormaPagamento ;
end;

procedure TACBrECFFormasPagamento.Insert(Index: Integer;
  Obj: TACBrECFFormaPagamento);
begin
  inherited Insert(Index, Obj);
end;

procedure TACBrECFFormasPagamento.SetObject(Index: Integer;
  Item: TACBrECFFormaPagamento);
begin
  inherited SetItem (Index, Item) ;
end;

{ ----------------------------- TACBrECFConsumidor -------------------------- }
constructor TACBrECFConsumidor.create;
begin
   Zera ;
end;

procedure TACBrECFConsumidor.Zera ;
begin
  fsNome      := '' ;
  fsEndereco  := '' ;
  fsDocumento := '' ;
  fsEnviado   := False ;
end ;

procedure TACBrECFConsumidor.AtribuiConsumidor(CPF_CNPJ, Nome, Endereco: String);
begin
  CPF_CNPJ  := Trim( CPF_CNPJ );
  Nome      := Trim( Nome );
  Endereco  := Trim( Endereco );

  if CPF_CNPJ = '' then
     raise Exception.Create(cACBrECFConsumidorCPFCNPJException) ;

  if (Nome = '') and (Endereco <> '') then
     raise Exception.Create( cACBrECFConsumidorNomeException ) ;

  fsDocumento := CPF_CNPJ ;
  fsNome      := TiraAcentos( Nome );
  fsEndereco  := TiraAcentos( Endereco );
  fsEnviado   := False ;
end;

function TACBrECFConsumidor.GetEnviado: Boolean;
begin
  Result := fsEnviado or (not Atribuido) ;
end;

function TACBrECFConsumidor.GetAtribuido: Boolean;
begin
  Result := (fsNome <> '') or (fsEndereco <> '') or (fsDocumento <> '') ;
end;


{------------------------- TACBrECFRelatoriosGerenciais -----------------------}
{ TACBrECFRelatorioGerencial }

constructor TACBrECFRelatorioGerencial.create;
begin
  fsIndice           := '' ;
  fsDescricao        := '' ;
  fsContador         := 0 ;
end;

function TACBrECFRelatoriosGerenciais.Add(
  Obj: TACBrECFRelatorioGerencial): Integer;
begin
  Result := inherited Add(Obj) ;
end;

function TACBrECFRelatoriosGerenciais.GetObject(
  Index: Integer): TACBrECFRelatorioGerencial;
begin
  Result := inherited GetItem(Index) as TACBrECFRelatorioGerencial ;
end;

procedure TACBrECFRelatoriosGerenciais.Insert(Index: Integer;
  Obj: TACBrECFRelatorioGerencial);
begin
  inherited Insert(Index, Obj);
end;

procedure TACBrECFRelatoriosGerenciais.SetObject(Index: Integer;
  Item: TACBrECFRelatorioGerencial);
begin
  inherited SetItem (Index, Item) ;
end;
               

{ ---------------------- TACBrECFComprovantesNaoFiscais --------------------- }

{ TACBrECFComprovanteNaoFiscal }
constructor TACBrECFComprovanteNaoFiscal.create;
begin
  fsIndice           := '' ;
  fsDescricao        := '' ;
  fsPermiteVinculado := true ;
  fsFormaPagamento   := '' ;
  fsTotal            := 0 ;
  fsContador         := 0 ;
end;

function TACBrECFComprovantesNaoFiscais.Add(
  Obj: TACBrECFComprovanteNaoFiscal): Integer;
begin
  Result := inherited Add(Obj) ;
end;

function TACBrECFComprovantesNaoFiscais.GetObject(
  Index: Integer): TACBrECFComprovanteNaoFiscal;
begin
  Result := inherited GetItem(Index) as TACBrECFComprovanteNaoFiscal ;
end;

procedure TACBrECFComprovantesNaoFiscais.Insert(Index: Integer;
  Obj: TACBrECFComprovanteNaoFiscal);
begin
  inherited Insert(Index, Obj);
end;

procedure TACBrECFComprovantesNaoFiscais.SetObject(Index: Integer;
  Item: TACBrECFComprovanteNaoFiscal);
begin
  inherited SetItem (Index, Item) ;
end;

{-------------------------- TACBrECFUnidadesMedida ---------------------------}
Constructor TACBrECFUnidadeMedida.create;
begin
  fsIndice           := '' ;
  fsDescricao        := '' ;
end;

function TACBrECFUnidadesMedida.Add(Obj: TACBrECFUnidadeMedida): Integer;
begin
  Result := inherited Add(Obj) ;
end;

function TACBrECFUnidadesMedida.GetObject(
  Index: Integer): TACBrECFUnidadeMedida;
begin
  Result := inherited GetItem(Index) as TACBrECFUnidadeMedida ;
end;

procedure TACBrECFUnidadesMedida.Insert(Index: Integer;
  Obj: TACBrECFUnidadeMedida);
begin
  inherited Insert(Index, Obj);
end;

procedure TACBrECFUnidadesMedida.SetObject(Index: Integer;
  Item: TACBrECFUnidadeMedida);
begin
  inherited SetItem (Index, Item) ;
end;

{ ---------------------------- TACBrECFClass ------------------------------ }

constructor TACBrECFClass.create( AOwner : TComponent ) ;
begin
  if not (AOwner is TACBrECF) then
     raise Exception.create( cACBrECFClassCreateException );

  fpOwner := AOwner ;
  
  { Criando ponteiro interno para as Propriedade SERIAL e FORMMSG de ACBrECF,
    para permitir as Classes Filhas o acesso a essas propriedades do Componente}
  fpDevice := (AOwner as TACBrECF).Device ;
  fpDevice.SetDefaultValues ;

  { Criando ponteiro para as propriedade de FormMsg ficarem visiveis nessa Unit }
  {$IFNDEF CONSOLE}
    with (AOwner as TACBrECF) do
    begin
       fsFormMsgFont  := FormMsgFonte ;
       fsFormMsgColor := FormMsgColor ;
    end ;
  {$ENDIF}
  
  { Ajustando variaveis Internas }
  fsRetentar             := true ;
  fsOperador             := '' ;
  fsMsgAguarde           := cACBrMsgAguardando ;
  fsMsgTrabalhando       := cACBrMsgTrabalhando ;
  fsMsgRelatorio         := cACBrMsgRelatorio ;
  fsPausaRelatorio       := cACBrPausaRelatorio ;
  fsLinhasEntreCupons    := cACBrLinhasEntreCupons ;
  fsMaxLinhasBuffer      := cACBrMaxLinhasBuffer ;
  fsMsgPausaRelatorio    := cACBrMsgPausaRelatorio ;
  fsTempoInicioMsg       := cACBrTempoInicioMsg ;
  fsIntervaloAposComando := cACBrIntervaloAposComando ;
  fsExibeMensagem        := true ;
  fsBloqueiaMouseTeclado := true ;
  fsMsgPoucoPapel        := cACBrMsgPoucoPapel ;
  fsDescricaoGrande      := false ;
  fsVias                 := 0 ;
  fsRelatorio            := nil ;
  fsBytesRec             := 0 ;
  fsOnAguardandoRespostaChange := nil ;
  fsOnMsgPoucoPapel            := nil ;
  fsAguardandoResposta         := false ;
  fsOnMsgErro                  := nil ;
  fsOnMsgAguarde               := nil ;
  fsOnMsgRetentar              := nil ;

  { Variaveis Protected fp___ acessiveis pelas Classes filhas }
  fpAtivo                 := false ;
  fpEstado                := estNaoInicializada ;
  fpColunas               := 48 ;
  fpRFDID                 := '' ;
  fpModeloStr             := 'Não Definido' ;
  fpComandoEnviado        := '' ;
  fpRespostaComando       := '' ;
  fpUltimaMsgPoucoPapel   := 0 ;
  fpArredondaPorQtd       := false ;
  fpDecimaisPreco         := 3 ;
  fpDecimaisQtd           := 3 ;
  fpAliquotas             := nil ;
  fpFormasPagamentos      := nil ;
  fpRelatoriosGerenciais  := nil ;
  fpComprovantesNaoFiscais:= nil ;
  fpTermica               := False ;
  fpMFD                   := False ;
  fpIdentificaConsumidorRodape := False ;
  fpArqLOG                := '' ;
  fpComandoLOG            := '' ;

  fpConsumidor  :=  TACBrECFConsumidor.create ;

  fpCodBarras   :=  TACBrECFCodBarras.create;
  
  {$IFNDEF CONSOLE}
    fsFormMsg                   := nil ;
    fsFormMsgProcedureAExecutar := nil ;
    fsFormMsgTeclaParaFechar    := 0 ;
    fsFormMsgEstado             := fmsNenhum ;
    fsFormMsgControla           := true ;
  {$ENDIF}
end;

destructor TACBrECFClass.Destroy;
begin
  Desativar ;
  fpDevice  := nil ; { Apenas remove referencia (ponteiros internos) }

  if Assigned( fpAliquotas ) then
     fpAliquotas.Free ;

  if Assigned( fpFormasPagamentos ) then
     fpFormasPagamentos.Free ;

  if Assigned( fpRelatoriosGerenciais ) then
     fpRelatoriosGerenciais.Free ;

  if Assigned( fpComprovantesNaoFiscais ) then
     fpComprovantesNaoFiscais.Free ;

 if Assigned( fpUnidadesMedida ) then
    fpUnidadesMedida.Free; 

  fpConsumidor.Free ;

  fpCodBarras.Free ;

  {$IFNDEF CONSOLE}
    if Assigned( fsFormMsg ) then
       FreeAndNil( fsFormMsg ) ;
  {$ENDIF}

  inherited Destroy ;
end;

procedure TACBrECFClass.SetAtivo(const Value: Boolean);
begin
  if Value then
     Ativar
  else
     Desativar ;
end;

procedure TACBrECFClass.Ativar;
begin
  if fpAtivo then exit ;

  fpDevice.Ativar ;

  fpEstado := estDesconhecido ;
  fpAtivo  := true ;
end;

procedure TACBrECFClass.Desativar;
begin
  if not fpAtivo then exit ;

  fpDevice.Desativar ;

  fpEstado := estNaoInicializada ;
  fpAtivo  := false ;
end;


{------------------------------------------------------------------------------}
function TACBrECFClass.EnviaComando(cmd: AnsiString; lTimeOut: Integer): AnsiString;
Var wTimeOut : Integer ;
begin
  wTimeOut := TimeOut ;                      { Salvando os valores antigos }
  TimeOut  := max(lTimeOut,wTimeOut) ;       { Novo Valor recebido pelo metodo }

  try
     result := EnviaComando( cmd ) ;
  finally
     TimeOut := wTimeOut ;     { Restaurando valor antigo }
  end ;
end;

function TACBrECFClass.EnviaComando(cmd: AnsiString; lTimeOut,
  lTempoInicioMsg: Integer): AnsiString;
Var wTimeOut, wTempoInicioMsg : Integer ;
begin
  wTimeOut        := TimeOut ;          { Salvando os valores antigos }
  wTempoInicioMsg := TempoInicioMsg ;

  TimeOut         := max(lTimeOut,wTimeOut) ;   { Novos Valores recebidos pelo metodo }
  TempoInicioMsg  := max(lTempoInicioMsg,wTempoInicioMsg) ;

  try
     result := EnviaComando( cmd ) ;
  finally
     TimeOut        := wTimeOut ;      { Restaurando valores antigos }
     TempoInicioMsg := wTempoInicioMsg ;
  end ;
end;


function TACBrECFClass.EnviaComando(cmd: AnsiString = ''): AnsiString;
begin
  if (not fpDevice.Ativo) then
     raise EACBrECFNaoInicializado.create( cACBrECFNaoInicializadoException );

  if AguardandoResposta then
     raise EACBrECFOcupado.create( cACBrECFOcupadoException ) ;
     
  VerificaEmLinha ;

  try
     fsBytesRec         := 0 ;
     AguardandoResposta := True ;
     try
        GravaLog('-- '+FormatDateTime('hh:nn:ss',now)+' '+fpComandoLOG,True );
        Result := EnviaComando_ECF( Cmd ) ;
     finally
        AguardandoResposta := False ;
        fpComandoLOG       := '' ;
        GravaLog('            TX -> '+fpComandoEnviado, True);
        GravaLog('   '+FormatDateTime('hh:nn:ss',now)+' RX <- '+fpRespostaComando, True);
     end ;
  except
     On E: Exception do
     begin
        GravaLog('----------------- ERRO -----------------' + sLineBreak + 
                 E.Message + sLineBreak +
                 '----------------------------------------' + sLineBreak );
        raise ;
     end ;
  end ;
end;

Procedure TACBrECFClass.GravaLog(AString: AnsiString; Traduz :Boolean = False);
Var Buf, Ch : AnsiString ;
    I   : Integer ;
    ASC : Byte ;
begin
  if fpArqLOG = '' then
     exit ;

  if not Traduz then
     Buf := AString
  else
   begin
     Buf := '' ;
     For I := 1 to Length(AString) do
     begin
        ASC := Ord(AString[I]) ;

        case ASC of
           2   : Ch := '[STX]' ;
           3   : Ch := '[ETX]' ;
           6   : Ch := '[ACK]' ;
           10  : Ch := '[LF]' ;
           13  : Ch := '[CR]' ;
           27  : Ch := '[ESC]' ;
           255 : Ch := '[FF]' ;
           32..127 : Ch := AString[I] ;
        else ;
          Ch := '['+IntToStr(ASC)+']'
        end;

        Buf := Buf + Ch ;
     end ;
   end ;

  try
     WriteToTXT(fpArqLOG, Buf, True);
  except
  end ;
end ;

function TACBrECFClass.EnviaComando_ECF(cmd: AnsiString): AnsiString;
begin
  ErroAbstract( 'EnviaComando_ECF' );
end;

{- LE RESPOSTA - Rotina de Leitura da Resposta do ECF com Bloqueio de Teclado -}
procedure TACBrECFClass.LeResposta;
begin
  {$IFNDEF CONSOLE}
    if FormMsgExibe then
       FormMsgDoProcedure( DoLeResposta, 0 )
    else
  {$ENDIF}
     DoLeResposta ;

  if fpRespostaComando = 'ACBrErro' then
  begin
     fpRespostaComando := '' ;
     raise EACBrECFSemResposta.create( Format(cACBrECFSemRespostaException, [ModeloStr]) ) ;
  end ;
end;

procedure TACBrECFClass.DoLeResposta;
Var Fim : Boolean ;
    TempoInicio, TempoLimite : TDateTime ;
    TempoRestante, LenResp : Integer ;
    Texto : AnsiString ;
    ProcessaFormMsg : Boolean ;
begin
  try
     fpRespostaComando := '' ;
     {$IFNDEF CONSOLE}
       ProcessaFormMsg := (Assigned( fsFormMsg ) and fsFormMsgControla) ;
     {$ENDIF}
     
     { Calcula Tempo Limite. Espera resposta até Tempo Limite. Se a resposta
       for Lida antes, já encerra. Se nao chegar até TempoLimite, gera erro.}
     TempoLimite := IncSecond( now, TimeOut) ;
     TempoInicio := IncSecond( now, TempoInicioMsg) ;
     Fim := True ;

     { - Le até atingir a condiçao descrita na funçao VerificaFimLeitura que
         é particular de cada Classe Filha (override)
       - VerificaFimImpressao é necessário apenas nos ECFs que respondem
         antes do termino da impressao (Sweda, Bematech, Daruma) }
     repeat
        { Atualizando a Msg no Form }
        {$IFNDEF CONSOLE}
          if ProcessaFormMsg and (now >= TempoInicio) then
          begin
             TempoRestante := SecondsBetween( now, TempoLimite) ;
             
             if (TimeOut - TempoRestante) > 1 then
              begin
                try
                   Texto := Format(MsgAguarde, [ TempoRestante ]) ;
                except
                   Texto := MsgAguarde ;
                end ;
              end
             else
                Texto := MsgTrabalhando ;

             FormMsgPinta( Texto );
          end ;
        {$ENDIF}

        if now > TempoLimite then       { TimeOut }
        begin
           {$IFNDEF CONSOLE}
             if Retentar then
             begin
                if ProcessaFormMsg then
                begin
                   fsFormMsg.Width  := 0 ;  { Escondendo o Form da Msg }
                   fsFormMsg.Height := 0 ;
                end ;

                if DoOnMsgRetentar( Format(cACBrECFDoOnMsgSemRespostaRetentar,
                                          [ ModeloStr ]),
                    'LerResposta') then
                   TempoLimite := IncSecond( now, TimeOut)  ;
             end ;
           {$ENDIF}

           if now > TempoLimite then      { Respondeu Nao a Retentar }
           begin
              fpRespostaComando := 'ACBrErro' ;
              break ;
           end ;
        end ;

        Fim := True ;
        if not VerificaFimLeitura(fpRespostaComando, TempoLimite) then
         begin
           Fim := False ;
           try
              fpRespostaComando := fpRespostaComando + { Le conteudo da porta }
                                   fpDevice.Serial.RecvPacket(100) ;

              LenResp := Length( fpRespostaComando ) ;
              if LenResp > fsBytesRec then
              begin
                 // ECF está respondendo, portanto está trabalhando //
                 TempoLimite := IncSecond(now, TimeOut);
                 fsBytesRec  := LenResp ;
              end ;
           except
              sleep(10) ;
           end ;
         end
        else
           if AguardaImpressao then
           begin
              Fim := VerificaFimImpressao( TempoLimite ) ;

              if not Fim then
                 sleep(200) ;
           end ;

        {$IFNDEF CONSOLE}
          Application.ProcessMessages ;
        {$ENDIF}
     until Fim ;
  finally
     AguardaImpressao := False ;
     if Assigned( fsOnMsgAguarde ) then
        fsOnMsgAguarde( '' ) ;
  end ;
end;

{ Essa função PODE ser override por cada Classe Filha criada
 - Transmite a string do Comando.
   - Se conseguiu retorna True.
   - Se não conseguiu e a propriedade Retentar, estiver ligada retorna False,
   - Se Retentar estiver desligada ou respondeu NAO ao Retentar, dispara Excecao}
function TACBrECFClass.TransmiteComando(Cmd: AnsiString): Boolean;
begin
  Result := True ;

  try
     fpDevice.EnviaString( cmd );   { Eviando o comando }
  except
     if not DoOnMsgRetentar(Format(cACBrECFCmdSemRespostaException, [ ModeloStr ]),
       'TransmitirComando') then
       raise EACBrECFSemResposta.create(Format(cACBrECFEnviaCmdSemRespostaException, [ ModeloStr ])) 
     else
        Result := False ;
  end ;
end;


{ Essa função DEVE ser override por cada Classe Filha criada }
function TACBrECFClass.VerificaFimLeitura(var Retorno: AnsiString;
   var TempoLimite: TDateTime) : Boolean ;
begin
  raise Exception.Create(Format(cACBrECFVerificaFimLeituraException, [ ModeloStr ])) ;
end;

function TACBrECFClass.VerificaFimImpressao(var TempoLimite: TDateTime): Boolean;
begin
{ Essa função PODE ser override por cada Classe Filha criada
  - Ela é necessária apenas para ECFs que respondem antes do termino da
    Impressao como a Sweda, Bematech, Daruma, etc.
  - Substitui a antiga função "EnviaComandoEspera"
  - Para usa-la ative a Propriedade "AguardarImpressao" entes de chamar
    "EnviaComando"
  - IMPORTANTE: Não é permitido o uso de chamadas EnviaComando dentra dessa
    função, caso constrário ela entrará em chamada Recursiva Infinita }

  Result := EmLinha(1) ;  //  Result := True ;
end;

Procedure TACBrECFClass.VerificaEmLinha( TimeOut : Integer = 3) ;
begin
  while not EmLinha( TimeOut ) do  { Impressora está em-linha ? }
  begin
     {$IFNDEF CONSOLE}
       if Retentar and
          DoOnMsgRetentar(Format(cACBrECFVerificaEmLinhaMsgRetentar,
                           [ ModeloStr ]), 'VerEmLinha') then
          Continue ;
     {$ENDIF}

     raise EACBrECFSemResposta.create(Format(cACBrECFVerificaEmLinhaException,
                                     [ ModeloStr ])) ;
  end ;
end;


function TACBrECFClass.GetTimeOut: Integer;
begin
  Result := fpDevice.TimeOut ;
end;

procedure TACBrECFClass.SetTimeOut(const Value: Integer);
begin
  fpDevice.TimeOut := Value ;
end;

{ Essa função PODE ser override por cada Classe Filha criada }
Function TACBrECFClass.TestaPodeAbrirCupom : Boolean ;
Var Msg : String ;
    Est : TACBrECFEstado ;
begin
  Result := true ;
  Est    := Estado ;

  case Est of
     estRequerX :
        Msg := Format(cACBrECFPodeAbrirCupomRequerX, [ ModeloStr ]);
     estRequerZ :
        Msg := cACBrECFPodeAbrirCupomRequerZ;
     estBloqueada :
        Msg := cACBrECFPodeAbrirCupomBloqueada;
     estVenda :
        Msg := cACBrECFPodeAbrirCupomCFAberto;
     estNaoInicializada :
        Msg := cACBrECFPodeAbrirCupomNaoAtivada;
     estLivre :
        Msg := '' ;
  else ;
     Msg := Format(cACBrECFPodeAbrirCupomEstado,
                     [ ModeloStr, GetEnumName(TypeInfo(TACBrECFEstado), integer(Est)) ]);
  end;

  if Msg <> '' then
  begin
     result := false ;
     GeraErro( EACBrECFCMDInvalido.Create( Msg ) );
  end ;
end;

procedure TACBrECFClass.SetAguardandoResposta(const Value: Boolean);
begin
  if Value = fsAguardandoResposta then exit ;

  fsAguardandoResposta := Value;
  if Assigned( fsOnAguardandoRespostaChange ) then
     fsOnAguardandoRespostaChange( self ) ;
end;

procedure TACBrECFClass.GeraErro( E : Exception ) ;
begin
  if Assigned( fsOnMsgErro ) then
     fsOnMsgErro( E )
  else
     raise E ;
end;

function TACBrECFClass.EmLinha( lTimeOut: Integer): Boolean;
begin
  Result := fpDevice.EmLinha( lTimeOut ) ;
end;

function TACBrECFClass.GetDataHora: TDateTime;
begin
  Result := now ;
end;

function TACBrECFClass.GetNumECF: String;
begin
  Result := '001' ;
end;

function TACBrECFClass.GetNumCRO: String;
begin
  Result := '001' ;
end;

function TACBrECFClass.GetNumCCF: String;
begin
  Result := '' ;
end;

function TACBrECFClass.GetNumGNF: String;
begin
  Result := '' ;
end;

function TACBrECFClass.GetNumGRG: String;
begin
  Result := '' ;
end;

function TACBrECFClass.GetNumCDC: String;
begin
  Result := '' ;
end;

function TACBrECFClass.GetNumLoja: String;
begin
  Result := '001' ;
end;

function TACBrECFClass.GetNumSerie: String;
begin
  Result := '' ;
end;


{ Essa função DEVE ser override por cada Classe Filha criada }
Procedure TACBrECFClass.AbreGaveta ;
begin
  GeraErro( EACBrECFCMDInvalido.Create( Format(cACBrECFAbreGavetaException, [  ModeloStr] ))) ;
end;

{ Essa função DEVE ser override por cada Classe Filha criada }
function TACBrECFClass.GetEstado: TACBrECFEstado;
begin
  Result := fpEstado ;
end;

{ Essa função PODE ser override por cada Classe Filha criada }
function TACBrECFClass.GetGavetaAberta: Boolean;
begin
  Result := false ;
end;

{ Essa função DEVE ser override por cada Classe Filha criada }
function TACBrECFClass.GetPoucoPapel: Boolean;
begin
  Result := false ;
end;

{ Essa função DEVE ser override por cada Classe Filha criada }
function TACBrECFClass.GetArredonda: Boolean;
begin
  Result := false ;
end;

{ Essa função DEVE ser override por cada Classe Filha criada }
function TACBrECFClass.GetHorarioVerao: Boolean;
begin
  Result := false ;
end;

{ Essa função PODE ser override por cada Classe Filha criada }
procedure TACBrECFClass.ImpactoAgulhas( NivelForca : Integer = 2);
begin
  GeraErro( EACBrECFCMDInvalido.Create( Format(cACBrECFImpactoAgulhasException,
                                               [ ModeloStr ] ))) ;
end;

{ Essa função PODE ser override por cada Classe Filha criada }
procedure TACBrECFClass.LeituraMemoriaFiscal(ReducaoInicial,
   ReducaoFinal: Integer; Simplificada : Boolean);
begin
  ErroAbstract('LeituraMemoriaFiscal');
end;

procedure TACBrECFClass.LeituraMemoriaFiscal(DataInicial, DataFinal: TDateTime;
   Simplificada : Boolean);
begin
  ErroAbstract('LeituraMemoriaFiscal');
end;

procedure TACBrECFClass.LeituraMemoriaFiscalSerial(ReducaoInicial,
   ReducaoFinal: Integer; var Linhas : TStringList; Simplificada : Boolean);
begin
  ErroAbstract('LeituraMemoriaFiscalSerial');
end;

procedure TACBrECFClass.LeituraMemoriaFiscalSerial(DataInicial,
   DataFinal: TDateTime; var Linhas : TStringList; Simplificada : Boolean);
begin
  ErroAbstract('LeituraMemoriaFiscalSerial');
end;


procedure TACBrECFClass.LeituraMFDSerial(DataInicial, DataFinal: TDateTime;
  var Linhas: TStringList; Documentos : TACBrECFTipoDocumentoSet );
begin
  ErroAbstract('LeituraMFDSerial');
end;

procedure TACBrECFClass.LeituraMFDSerial(COOInicial,
  COOFinal: Integer; var Linhas: TStringList; Documentos : TACBrECFTipoDocumentoSet);
begin
  ErroAbstract('LeituraMFDSerial');
end;

{ Essa função PODE ser override por cada Classe Filha criada }
procedure TACBrECFClass.ImprimeCheque(Banco: String; Valor: Double; Favorecido,
  Cidade: String; Data: TDateTime; Observacao: String);
begin
  GeraErro( EACBrECFCMDInvalido.Create( Format(cACBrECFImprimeChequeException,
                                               [ ModeloStr ] ))) ;
end;

{ Essa função PODE ser override por cada Classe Filha criada }
Function TACBrECFClass.LeituraCMC7 : AnsiString ;
begin
  GeraErro( EACBrECFCMDInvalido.Create( Format(cACBrECFLeituraCMC7Exception,
                                               [ ModeloStr ] ))) ;
end;

{ Essa função PODE ser override por cada Classe Filha criada }
procedure TACBrECFClass.CancelaImpressaoCheque;
begin
  ErroAbstract('CancelaImpressaoCheque');
end;

{ Essa função PODE ser override por cada Classe Filha criada }
function TACBrECFClass.GetChequePronto: Boolean;
begin
  result := True ;
end;

procedure TACBrECFClass.CorrigeEstadoErro( Reducao: Boolean );
begin
  case Estado of
     estRequerX : LeituraX ;

     estRequerZ :
       if Reducao then
         try
           ReducaoZ(now);
         except
           try
             CancelaCupom;
             ReducaoZ(now);
           except
           end;
         end;

     estRelatorio : FechaRelatorio ;

     estVenda, estPagamento :  CancelaCupom ;

     estNaoFiscal : CancelaNaoFiscal ;

     estBloqueada : GeraErro( EACBrECFCMDInvalido.Create(
                               cACBrECFPodeAbrirCupomBloqueada ) );
  end;

  if Estado <> estLivre then
     try
        FechaNaoFiscal ;
     except
     end
  else
     exit ;

  if Estado <> estLivre then
     try
        CancelaNaoFiscal ;
     except
     end 
  else
     exit ;

  if Estado <> estLivre then
     try
        FechaRelatorio ;
     except
     end ;
end;

procedure TACBrECFClass.AbreCupom ;
begin
  ErroAbstract('AbreCupom');
end;

procedure TACBrECFClass.CancelaCupom;
begin
  ErroAbstract('CancelaCupom');
end;

procedure TACBrECFClass.CancelaItemVendido(NumItem: Integer);
begin
  ErroAbstract('CancelaItemVendido');
end;

procedure TACBrECFClass.EfetuaPagamento(CodFormaPagto: String;
  Valor: Double; Observacao: AnsiString; ImprimeVinculado: Boolean);
begin
  ErroAbstract('EfetuaPagamento');
end;

procedure TACBrECFClass.EstornaPagamento(const CodFormaPagtoEstornar,
  CodFormaPagtoEfetivar : String; const Valor: Double;
   Observacao : AnsiString = '') ;
begin
  ErroAbstract('EstornaPagamento');
end;

procedure TACBrECFClass.FechaCupom(Observacao: AnsiString; IndiceBMP : Integer);
begin
  ErroAbstract('FechaCupom');
end;

procedure TACBrECFClass.FechaRelatorio;
begin
  ErroAbstract('FechaRelatorio');
end;

procedure TACBrECFClass.AbreNaoFiscal(CPF_CNPJ: String);
begin
  ErroAbstract('AbreNaoFiscal');
end;

procedure TACBrECFClass.CancelaNaoFiscal;
begin
  CancelaCupom ;
end;

procedure TACBrECFClass.EfetuaPagamentoNaoFiscal(CodFormaPagto: String;
  Valor: Double; Observacao: AnsiString; ImprimeVinculado: Boolean);
begin
  EfetuaPagamento( CodFormaPagto, Valor, Observacao, ImprimeVinculado );
end;

procedure TACBrECFClass.FechaNaoFiscal(Observacao: AnsiString; IndiceBMP : Integer);
begin
  FechaCupom(Observacao, IndiceBMP);
end;

procedure TACBrECFClass.NaoFiscalCompleto(CodCNF: String; Valor: Double;
  CodFormaPagto: String; Obs: AnsiString; IndiceBMP : Integer);
begin
  { Chama rotinas da classe Pai (fpOwner) para atualizar os Memos }
  with TACBrECF(fpOwner) do
  begin
     AbreNaoFiscal ;
     try
        RegistraItemNaoFiscal(CodCNF, Valor);
        SubtotalizaNaoFiscal(0);
        EfetuaPagamentoNaoFiscal(CodFormaPagto, Valor );
        FechaNaoFiscal( Obs, IndiceBMP);
     except
        try
           CancelaNaoFiscal
        except
        end;

        raise ;
     end ;
  end ;
end;

procedure TACBrECFClass.RegistraItemNaoFiscal(CodCNF: String;
  Valor: Double; Obs: AnsiString = '');
begin
  ErroAbstract('RegistraItemNaoFiscal');
end;

procedure TACBrECFClass.SubtotalizaNaoFiscal(DescontoAcrescimo: Double;
   MensagemRodape: AnsiString);
begin
  SubtotalizaCupom(DescontoAcrescimo, MensagemRodape);
end;

procedure TACBrECFClass.Sangria( const Valor: Double; Obs: AnsiString;
   DescricaoCNF, DescricaoFPG: String ) ;
 Var CNF : TACBrECFComprovanteNaoFiscal ;
     FPG : TACBrECFFormaPagamento ;
begin
  CNF := AchaCNFDescricao(DescricaoCNF, True) ;
  if CNF = nil then
     raise Exception.Create(Format(cACBrECFAchaCNFException,
                                   [ DescricaoCNF ] )) ;

  FPG := AchaFPGDescricao(DescricaoFPG, True) ;
  if FPG = nil then
     raise Exception.Create(Format(cACBrECFAchaFPGException,
                                   [ DescricaoFPG ])) ;

  NaoFiscalCompleto( CNF.Indice, Valor, FPG.Indice, Obs);
end;

procedure TACBrECFClass.Suprimento( const Valor: Double; Obs: AnsiString;
   DescricaoCNF, DescricaoFPG: String ) ;
begin
  Sangria( Valor, Obs, DescricaoCNF, DescricaoFPG);
end;


procedure TACBrECFClass.PulaLinhas(NumLinhas: Integer);
begin
  if NumLinhas = 0 then
     NumLinhas := LinhasEntreCupons ;

  LinhaRelatorioGerencial( StringOfChar(#10, NumLinhas ) ) ;
end;

procedure TACBrECFClass.CortaPapel(const CorteParcial : Boolean ) ;
begin
  LinhaRelatorioGerencial( #10+#10+#10 ) ;
end;

function TACBrECFClass.GetNumCupom: String;
begin
  Result := '' ;
end;

function TACBrECFClass.GetNumVersao: String ;
begin
  Result := ''
end;

function TACBrECFClass.GetSubTotal: Double;
begin
  Result := 0 ;
end;

function TACBrECFClass.GetTotalPago: Double;
begin
  Result := 0 ;
end;

function TACBrECFClass.GetCNPJ: String;
begin
  Result := '' ;
end;

function TACBrECFClass.GetIE: String;
begin
  Result := '' ;
end;

function TACBrECFClass.GetPAF: String;
begin
  Result := '' ;
end;

function TACBrECFClass.GetDataMovimento: TDateTime;
begin
  Result := now ;
end;

function TACBrECFClass.GetGrandeTotal: Double;
begin
  Result := 0 ;
end;

function TACBrECFClass.GetNumCRZ: String ;
begin
  Result := '00000'
end;

function TACBrECFClass.GetTotalAcrescimos: Double;
begin
  Result := 0 ;
end;

function TACBrECFClass.GetTotalCancelamentos: Double;
begin
  Result := 0 ;
end;

function TACBrECFClass.GetTotalDescontos: Double;
begin
  Result := 0 ;
end;

function TACBrECFClass.GetTotalSubstituicaoTributaria: Double;
begin
  Result := 0 ;
end;

function TACBrECFClass.GetTotalIsencao: Double;
begin
  Result := 0 ;
end;

function TACBrECFClass.GetTotalNaoFiscal: Double;
  Var I : Integer ;
begin
  Result := 0 ;
  try
     LerTotaisComprovanteNaoFiscal ;

     For I := 0 to ComprovantesNaoFiscais.Count-1 do
        Result := Result + ComprovantesNaoFiscais[I].Total ;
  except
  end ;
end;

function TACBrECFClass.GetNumUltimoItem: Integer;
begin
  Result := 0 ;
end;

function TACBrECFClass.GetTotalNaoTributado: Double;
begin
  Result := 0 ;
end;

function TACBrECFClass.GetVendaBruta: Double;
begin
  Result := 0 ;
end;

function TACBrECFClass.GetNumCOOInicial: String;
begin
  Result := ''
end;

function TACBrECFClass.GetDadosUltimaReducaoZ: AnsiString;
begin
  ErroAbstract('DadosUltimaReducaoZ');
end;

procedure TACBrECFClass.LeituraX;
begin
  ErroAbstract('LeituraX');
end;

procedure TACBrECFClass.LeituraXSerial(var Linhas: TStringList);
begin
  ErroAbstract('LeituraXSerial');
end;

procedure TACBrECFClass.MudaHorarioVerao;
begin
  ErroAbstract('MudaHorarioVerao');
end;

procedure TACBrECFClass.MudaHorarioVerao(EHorarioVerao: Boolean);
begin
  ErroAbstract('MudaHorarioVerao(EHorarioVerao: Boolean)');
end;

procedure TACBrECFClass.MudaArredondamento(Arredondar: Boolean);
begin
  ErroAbstract('MudaArredondamento');
end;

procedure TACBrECFClass.IdentificaOperador(Nome: String);
begin
//  ErroAbstract('IdentificaOperador');
end;

procedure TACBrECFClass.IdentificaPAF(Linha1, Linha2: String);
begin
  ErroAbstract('IdentificaPAF');
end;

Function TACBrECFClass.RetornaInfoECF( Registrador : String ) : AnsiString ;
begin
   ErroAbstract('RetornaInfoECF');
end;

procedure TACBrECFClass.PreparaTEF;
begin
  try
     FechaRelatorio ;
  except
  end ;

  CarregaAliquotas ;
  CarregaFormasPagamento ;
  CarregaComprovantesNaoFiscais ;
end;

procedure TACBrECFClass.ReducaoZ(DataHora: TDateTime);
begin
  ErroAbstract('ReducaoZ');
end;

procedure TACBrECFClass.SubtotalizaCupom(DescontoAcrescimo: Double;
       MensagemRodape : AnsiString);
begin
  ErroAbstract('SubtotalizaCupom');
end;

procedure TACBrECFClass.CancelaDescontoAcrescimoSubTotal(
  TipoAcrescimoDesconto: Char);
begin
  ErroAbstract('CancelaDescontoAcrescimoSubTotal');
end;

procedure TACBrECFClass.LegendaInmetroProximoItem;
begin
  ErroAbstract('LegendaInmetroProximoItem');
end;

Procedure TACBrECFClass.VendeItem( Codigo, Descricao : String;
  AliquotaECF : String; Qtd : Double ; ValorUnitario : Double;
  ValorDescontoAcrescimo : Double; Unidade : String;
  TipoDescontoAcrescimo : String; DescontoAcrescimo : String) ;
begin
  ErroAbstract('VendeItem');
end;

procedure TACBrECFClass.CancelaDescontoAcrescimoItem(NumItem: Integer);
begin
  ErroAbstract('CancelaDescontoAcrescimoItem');
end;

procedure TACBrECFClass.CancelaItemVendidoParcial(NumItem: Integer;
  Quantidade: Double);
begin
  ErroAbstract('CancelaItemVendidoParcial');
end;

procedure TACBrECFClass.ErroAbstract(NomeProcedure: String);
begin
  raise EACBrECFCMDInvalido.create(Format(cACBrECFCMDInvalidoException,
                                          [NomeProcedure, ModeloStr] )) ;
end;

function TACBrECFClass.GetModeloStr: String;
begin
  Result := fpModeloStr ;
  if fpMFD then
     Result := Result + ' MFD' ;
end;

procedure TACBrECFClass.DoOnMsgPoucoPapel( Mensagem : String ) ;
begin
  if now > IncSecond(fpUltimaMsgPoucoPapel, MsgPoucoPapel) then { Avisa ? }
  begin
     if Assigned( fsOnMsgPoucoPapel ) then
        fsOnMsgPoucoPapel( self )
     else
      begin
        if Mensagem = '' then
           Mensagem := cACBrECFDoOnMsgPoucoPapel;

        {$IFNDEF CONSOLE}
          MessageDlg(Mensagem,mtError,[mbOk],0)  ;
        {$ELSE}
          writeln( Mensagem ) ;
        {$ENDIF}
      end ;

     fpUltimaMsgPoucoPapel := now ;
  end ;
end;

function TACBrECFClass.DoOnMsgRetentar( const Mensagem : String;
   const Situacao : String = ''): Boolean;
begin
  Result := False ;

  if Assigned( fsOnMsgRetentar ) then
     fsOnMsgRetentar( Mensagem, Situacao, Result )
  else
   begin
     {$IFNDEF CONSOLE}
      if Retentar and
        (MessageDlg( Mensagem+sLineBreak+sLineBreak + cACBrECFDoOnMsgRetentar,
                     mtConfirmation,[mbYes,mbNo],0) = mrYes) then
        Result := True ;
     {$ENDIF}
   end ;
end;

{ Esta rotina é usada por Impressoras que não permitem enviar várias
  linhas de uma só vez }
procedure TACBrECFClass.ImprimirLinhaALinha(Texto, Cmd: AnsiString );
Var Linhas : TStringList ;
    I : Integer ;
begin
  if Texto = '' then
     Texto := padL(Texto,Colunas) ;

  Texto := AjustaLinhas( Texto, Colunas );

  Linhas := TStringList.Create ;
  try
     Linhas.Text := Texto ;

     for I := 0 to Linhas.Count-1 do
     begin
        EnviaComando( Cmd + padL( Linhas[I], Colunas), 6 ) ;
        if not fpTermica then
           sleep(100) ;

        { Aguarda 1 segundo ou até o ECF ficar Em linha novamente }
        { Semelhante ao "AguardaImpressao := True", porém é mais rápido, pois no
          método "VerificaFimImpressao" alem de verificado o "EmLinha" também é
          solicitado o Status do ECF }
        try
           EmLinha( 1 ) ;
        except
        end ;
     end ;
  finally
     Linhas.Free ;
  end ;
end;

{-------------------------------- ALIQUOTAS ----------------------------------}
procedure TACBrECFClass.CarregaAliquotas;
begin
  { Apenas instancia um ObjectList de Aliquotas (TACBrECFAliquotas) vazia }
  if Assigned( fpAliquotas ) then
     fpAliquotas.Free ;

  fpAliquotas := TACBrECFAliquotas.create( true ) ;
end;

procedure TACBrECFClass.LerTotaisAliquota;
begin
  ErroAbstract('LerTotaisAliquota');
end;

procedure TACBrECFClass.ProgramaAliquota(Aliquota: Double; Tipo: Char;
   Posicao : String);
begin
  ErroAbstract('ProgramaAliquota');
end;

function TACBrECFClass.GetAliquotas: TACBrECFAliquotas;
begin
  if not Assigned( fpAliquotas ) then
     CarregaAliquotas ;

  result := fpAliquotas ;
end;

function TACBrECFClass.AchaICMSAliquota( var AliquotaICMS: String):
   TACBrECFAliquota;
{   AliquotaICMS, Formatos válidos:
  - Por Valor da aliquota, Ex: '18', '12,00' '2,56'
  - Por Valor da Aliquota especificando o Tipo como sufixo
    (T = ICMS, ou S = ISS),      Ex: '18T',  '2,5S'
  - Por Indice, adicione o prefixo 'T', Ex: 'T01', 'T03', 'TA', 'TT01'
    ( o indice deve ser no mesmo formato retornado pela propriedade
      "Aliquotas[n].Indice" (que varia para cada modelo de ECF) )
}
   procedure VerificaTipoAliquota(var AliquotaICMS: String;
     var Tipo: char);
   Var UltDigito : String ;
   begin
     UltDigito := RightStr(AliquotaICMS,1) ;
     case UltDigito[1] of
        'T','S' :
          begin
            Tipo := UltDigito[1] ;
            AliquotaICMS := copy( AliquotaICMS,1,Length(AliquotaICMS)-1 ) ;
          end ;
     else
        Tipo := ' ' ;
     end ;
   end;

   Var AliquotaStr : String ;
       Tipo        : Char ;
       ValAliquota : Double ;
begin
  if not Assigned( fpAliquotas ) then
     CarregaAliquotas ;

  Result := nil ;

  AliquotaICMS := UpperCase( TrimLeft( AliquotaICMS ) ) ;
  case AliquotaICMS[1] of
    'I' : AliquotaICMS := 'II' ;
    'N' : AliquotaICMS := 'NN' ;
    'F' : AliquotaICMS := 'FF' ;
  else 
     begin
        if AliquotaICMS[1] = 'T' then  { Informou por Indice ? }
         begin
            AliquotaICMS := copy(AliquotaICMS,2,Length(AliquotaICMS)) ; {Remove o "T"}
            Result := AchaICMSIndice( AliquotaICMS ) ;
         end
        else      { Informou por valor }
         begin
           { Verificando se informou T ou S no final da Aliquota (Tipo) }
           AliquotaStr := AliquotaICMS ;
           Tipo        := ' ' ;
           VerificaTipoAliquota( AliquotaStr, Tipo) ;

           try
              ValAliquota := StringToFloat( AliquotaStr ) ;
           except
              raise EACBrECFCMDInvalido.Create(cACBrECFAchaICMSAliquotaInvalida + AliquotaICMS);
           end ;

           Result := AchaICMSAliquota( ValAliquota, Tipo ) ;
         end ;

        if Result = nil then
           raise EACBrECFCMDInvalido.Create(cACBrECFAchaICMSCMDInvalido + AliquotaICMS)
     end ;
  end ;

  if Result <> nil then
     AliquotaICMS := Result.Indice ;
end;

function TACBrECFClass.AchaICMSAliquota( Aliquota: Double; Tipo : Char ) :
   TACBrECFAliquota;
var A : Integer ;
begin
  if not Assigned( fpAliquotas ) then
     CarregaAliquotas ;

  if not (Tipo in ['S','T']) then
     Tipo := ' ' ;

  Aliquota := SimpleRoundTo(Aliquota,-2) ; 
  Result   := nil ;
  
  with fpAliquotas do
  begin
     For A := 0 to Count -1 do
     begin
        if ( SimpleRoundTo(Objects[A].Aliquota,-2) = Aliquota) and
           ((Tipo = ' ') or (Tipo = Objects[A].Tipo) ) then
        begin
           result := Objects[A] ;
           Break ;
        end ;
     end ;
  end ;
end;

function TACBrECFClass.AchaICMSIndice(Indice: String): TACBrECFAliquota;
var A : Integer ;
begin
  if not Assigned( fpAliquotas ) then
     CarregaAliquotas ;

  Result := nil ;
  Indice := UpperCase(Indice) ;

  with fpAliquotas do
  begin
     For A := 0 to Count -1 do
     begin
        if UpperCase( Objects[A].Indice ) = Indice then
        begin
           result := Objects[A] ;
           Break ;
        end ;
     end ;
  end ;
end;

{--------------------------- FORMAS DE PAGAMENTO ------------------------------}
procedure TACBrECFClass.CarregaFormasPagamento;
begin
  if Assigned( fpFormasPagamentos ) then
     fpFormasPagamentos.Free ;

  fpFormasPagamentos := TACBrECFFormasPagamento.Create( true ) ;
end;

procedure TACBrECFClass.LerTotaisFormaPagamento;
begin
  ErroAbstract('LerTotaisFormaPagamento');
end;

procedure TACBrECFClass.ProgramaFormaPagamento(var Descricao: String;
  PermiteVinculado: Boolean; Posicao : String);
begin
  ErroAbstract('ProgramaFormaPagamento');
end;

function TACBrECFClass.GetFormasPagamentos: TACBrECFFormasPagamento;
begin
  if not Assigned( fpFormasPagamentos ) then
     CarregaFormasPagamento ;

  result := fpFormasPagamentos ;
end;

function TACBrECFClass.AchaFPGDescricao(Descricao: String;
 BuscaExata : Boolean ) : TACBrECFFormaPagamento;
 var Tamanho, A : Integer ;
     DescrECF : String ;
begin
  if not Assigned( fpFormasPagamentos ) then
     CarregaFormasPagamento ;

  result := nil ;
  with fpFormasPagamentos do
  begin
     Descricao := Trim(UpperCase( Descricao )) ;
     Tamanho   := Length( Descricao ) ;
     For A := 0 to Count -1 do
     begin
        DescrECF := TrimRight( UpperCase(Objects[A].Descricao) ) ;
        if not BuscaExata then
           DescrECF := LeftStr( DescrECF, Tamanho) ;

        if DescrECF = Descricao then
        begin
           result := Objects[A] ;
           Break ;
        end ;
     end ;
  end ;
end;

function TACBrECFClass.AchaFPGIndice( Indice: String) :
   TACBrECFFormaPagamento;
var A : Integer ;
begin
  if not Assigned( fpFormasPagamentos ) then
     CarregaFormasPagamento ;

  result := nil ;
  with fpFormasPagamentos do
  begin
     For A := 0 to Count -1 do
     begin
        if Objects[A].Indice = Indice then
        begin
           result := Objects[A] ;
           Break ;
        end ;
     end ;
  end ;
end;

{---------------------------- Relatórios Gerenciais ---------------------------}
procedure TACBrECFClass.CarregaRelatoriosGerenciais;
begin
  if Assigned( fpRelatoriosGerenciais ) then
     fpRelatoriosGerenciais.Free ;

  fpRelatoriosGerenciais := TACBrECFRelatoriosGerenciais.Create( true ) ;
end;

procedure TACBrECFClass.ProgramaRelatorioGerencial(var Descricao: String;
  Posicao: String);
begin
  ErroAbstract('ProgramaRelatóriosGerenciais');
end;

function TACBrECFClass.GetRelatoriosGerenciais: TACBrECFRelatoriosGerenciais;
begin
  if not Assigned( fpRelatoriosGerenciais ) then
     CarregaRelatoriosGerenciais ;

  result := fpRelatoriosGerenciais ;
end;

function TACBrECFClass.AchaRGDescricao(Descricao: String;
  BuscaExata: Boolean): TACBrECFRelatorioGerencial;
var Tamanho, A : Integer ;
     DescrECF : String ;
begin
  if not Assigned( fpRelatoriosGerenciais ) then
     CarregaRelatoriosGerenciais ;

  result := nil ;
  with fpRelatoriosGerenciais do
  begin
     Descricao := Trim(UpperCase( Descricao )) ;
     Tamanho   := Length( Descricao ) ;
     For A := 0 to Count -1 do
     begin
        DescrECF := TrimRight( UpperCase(Objects[A].Descricao) ) ;
        if not BuscaExata then
           DescrECF := LeftStr( DescrECF, Tamanho) ;

        if DescrECF = Descricao then
        begin
           result := Objects[A] ;
           Break ;
        end ;
     end ;
  end ;
end;

function TACBrECFClass.AchaRGIndice(
  Indice: String): TACBrECFRelatorioGerencial;
var A : Integer ;
begin
  if not Assigned( fpRelatoriosGerenciais ) then
     CarregaRelatoriosGerenciais ;

  result := nil ;
  with fpRelatoriosGerenciais do
  begin
     For A := 0 to Count -1 do
     begin
        if Objects[A].Indice = Indice then
        begin
           result := Objects[A] ;
           Break ;
        end ;
     end ;
  end ;

end;


{------------------------- COMPROVANTES NAO FISCAIS ---------------------------}
procedure TACBrECFClass.CarregaComprovantesNaoFiscais;
begin
  if Assigned( fpComprovantesNaoFiscais ) then
     fpComprovantesNaoFiscais.Free ;

  fpComprovantesNaoFiscais := TACBrECFComprovantesNaoFiscais.Create( true ) ;
end;

procedure TACBrECFClass.LerTotaisComprovanteNaoFiscal;
begin
  ErroAbstract('LerTotaisComprovanteNaoFiscal');
end;

procedure TACBrECFClass.ProgramaComprovanteNaoFiscal(var Descricao: String;
  Tipo: String; Posicao : String);
begin
  ErroAbstract('ProgramaComprovanteNaoFiscal');
end;

function TACBrECFClass.GetComprovantesNaoFiscais: TACBrECFComprovantesNaoFiscais;
begin
  if not Assigned( fpComprovantesNaoFiscais ) then
     CarregaComprovantesNaoFiscais ;

  result := fpComprovantesNaoFiscais ;
end;

function TACBrECFClass.AchaCNFDescricao( Descricao: String;
       BuscaExata : Boolean ): TACBrECFComprovanteNaoFiscal;
 var Tamanho, A : Integer ;
     DescrECF : String ;
begin
  if not Assigned( fpComprovantesNaoFiscais ) then
     CarregaComprovantesNaoFiscais ;

  result := nil ;
  with fpComprovantesNaoFiscais do
  begin
     Descricao := Trim(UpperCase( Descricao )) ;
     Tamanho   := Length( Descricao ) ;
     For A := 0 to Count -1 do
     begin
        DescrECF := TrimRight( UpperCase(Objects[A].Descricao) ) ;
        if not BuscaExata then
           DescrECF := LeftStr( DescrECF, Tamanho) ;

        if DescrECF = Descricao then
        begin
           result := Objects[A] ;
           Break ;
        end ;
     end ;
  end ;
end;

function TACBrECFClass.AchaCNFIndice(
  Indice: String): TACBrECFComprovanteNaoFiscal;
var A : Integer ;
begin
  if not Assigned( fpComprovantesNaoFiscais ) then
     CarregaComprovantesNaoFiscais ;

  result := nil ;
  with fpComprovantesNaoFiscais do
  begin
     For A := 0 to Count -1 do
     begin
        if Objects[A].Indice = Indice then
        begin
           result := Objects[A] ;
           Break ;
        end ;
     end ;
  end ;
end;

function TACBrECFClass.AchaCNFFormaPagamento(
  CodFPG: String): TACBrECFComprovanteNaoFiscal;
var A : Integer ;
begin
  if not Assigned( fpComprovantesNaoFiscais ) then
     CarregaComprovantesNaoFiscais ;

  result := nil ;
  with fpComprovantesNaoFiscais do
  begin
     For A := 0 to Count -1 do
     begin
        if Objects[A].FormaPagamento = CodFPG then
        begin
           result := Objects[A] ;
           Break ;
        end ;
     end ;
  end ;
end;

{---------------------------- UNIDADES DE MEDIDA ------------------------------}
procedure TACBrECFClass.CarregaUnidadesMedida;
begin
  if Assigned( fpUnidadesMedida ) then
     fpUnidadesMedida.Free ;

  fpUnidadesMedida := TACBrECFUnidadesMedida.Create( true ) ;
end;

procedure TACBrECFClass.ProgramaUnidadeMedida(var Descricao: String);
begin
  ErroAbstract('ProgramaUnidadeMedida');
end;

function TACBrECFClass.GetUnidadesMedida: TACBrECFUnidadesMedida;
begin
  if not Assigned( fpUnidadesMedida ) then
     CarregaUnidadesMedida ;

  result := fpUnidadesMedida ;
end;

function TACBrECFClass.AchaUMDDescricao(
  Descricao: String): TACBrECFUnidadeMedida;
var A : Integer ;
begin
  if not Assigned( fpUnidadesMedida ) then
     CarregaUnidadesMedida ;

  result := nil ;
  with fpUnidadesMedida do
  begin
     Descricao := Trim(UpperCase( Descricao )) ;
     For A := 0 to Count -1 do
     begin
        if Trim(UpperCase( Objects[A].Descricao )) = Descricao then
        begin
           result := Objects[A] ;
           Break ;
        end ;
     end ;
  end ;
end;

function TACBrECFClass.AchaUMDIndice( Indice: String): TACBrECFUnidadeMedida;
var A : Integer ;
begin
  if not Assigned( fpUnidadesMedida ) then
     CarregaUnidadesMedida ;

  result := nil ;
  with fpUnidadesMedida do
  begin
     For A := 0 to Count -1 do
     begin
        if Objects[A].Indice = Indice then
        begin
           result := Objects[A] ;
           Break ;
        end ;
     end ;
  end ;
end;

{ ------------------------------ Cupom Vinculado -----------------------------}
procedure TACBrECFClass.CupomVinculado(COO, CodFormaPagto,
  CodComprovanteNaoFiscal: String; Valor: Double; Relatorio: TStrings;
  Vias: Integer);
Var wRetentar : Boolean ;
begin
  { Chama rotinas da classe Pai (fpOwner) para atualizar os Memos }
  TACBrECF(fpOwner).AbreCupomVinculado( COO, CodFormaPagto, CodComprovanteNaoFiscal, Valor) ;

  wRetentar := Retentar ;
  try
     Retentar    := false ;
     fsVias      := Vias ;
     fsRelatorio := Relatorio ;

     {$IFNDEF CONSOLE}
       if not ExibeMensagem  then
          DoCupomVinculado
       else
        begin
          { Isso fará a procedure LeResposta nao pintar o FormMsgAguarde }
          fsFormMsgControla := false ;
          FormMsgDoProcedure( DoCupomVinculado, 0)
        end ;
     {$ELSE}
       DoCupomVinculado
     {$ENDIF}
  finally
     {$IFNDEF CONSOLE}
       fsFormMsgControla := true ;
     {$ENDIF}
     Retentar := wRetentar ;
  end ;
end;

procedure TACBrECFClass.DoCupomVinculado;
begin
  ListaCupomVinculado( fsRelatorio, fsVias );
end;

procedure TACBrECFClass.AbreCupomVinculado(COO, CodFormaPagto,
  CodComprovanteNaoFiscal: String; Valor: Double);
begin
  ErroAbstract('AbreCupomVinculado');
end;

procedure TACBrECFClass.LinhaCupomVinculado(Linha: AnsiString);
begin
  ErroAbstract('LinhaCupomVinculado');
end;

procedure TACBrECFClass.ListaCupomVinculado( Relatorio: TStrings;
  Vias: Integer);
Var Lin, Imp : Integer ;
    Texto : String ;
begin
  Imp := 0 ;

  while Imp < Vias do
  begin
     {$IFNDEF CONSOLE}
       try
          Texto := Format(MsgRelatorio,['Cupom Vinculado',Imp+1 ]) ;
       except
          Texto := MsgRelatorio ;
       end ;

       FormMsgPinta( Texto );
     {$ENDIF}

     if MaxLinhasBuffer < 1 then
        TACBrECF(fpOwner).LinhaCupomVinculado( Relatorio.Text )
     else
      begin
        Texto := '' ;
        For Lin := 0 to Relatorio.Count - 1 do
        begin
           Texto := Texto + Relatorio[Lin] + sLineBreak;
           if (Lin mod MaxLinhasBuffer) = 0 then
           begin
              TACBrECF(fpOwner).LinhaCupomVinculado( Texto ) ;
              Texto := '' ;
           end ;
        end ;

        if Texto <> '' then
           TACBrECF(fpOwner).LinhaCupomVinculado( Texto ) ;
      end ;

     Inc(Imp) ;
     if Imp < Vias then
     begin
        TACBrECF(fpOwner).PulaLinhas  ;
        TACBrECF(fpOwner).CortaPapel  ;
        PausarRelatorio( Imp ) ;
     end ;
  end ;

  {$IFNDEF CONSOLE}
    FormMsgPinta( 'Fechando Cupom Vinculado' );
  {$ENDIF}
  TACBrECF(fpOwner).FechaRelatorio ;
end;

{ ------------------------------ Relatorio Gerencial -------------------------}
procedure TACBrECFClass.RelatorioGerencial(Relatorio: TStrings; Vias: Integer; Indice: Integer);
Var wMsgAguarde : String ;
    wRetentar : Boolean ;
begin
  { Chama rotinas da classe Pai (fpOwner) para atualizar os Memos }
  try
     TACBrECF(fpOwner).FechaRelatorio ; { Fecha se ficou algum aberto }
  Except
  end ;

  wMsgAguarde := MsgAguarde ;
  MsgAguarde  := cACBrECFAbrindoRelatorioGerencial ;
  try
     TACBrECF(fpOwner).AbreRelatorioGerencial(Indice) ;
  finally
     MsgAguarde := wMsgAguarde ;
  end ;

  wRetentar := Retentar ;
  try
     Retentar    := false ;
     fsVias      := Vias ;
     fsRelatorio := Relatorio ;
     fsIndiceRG  := Indice;

     {$IFNDEF CONSOLE}
       if not ExibeMensagem  then
         DoRelatorioGerencial
       else
        begin
          { Isso fará a procedure LeResposta nao pintar o FormMsgAguarde }
          fsFormMsgControla := false ;
          FormMsgDoProcedure(DoRelatorioGerencial,0) ;
        end ;
     {$ELSE}
       DoRelatorioGerencial ;
     {$ENDIF}
  finally
     {$IFNDEF CONSOLE}
       fsFormMsgControla := true ;
     {$ENDIF}
     Retentar := wRetentar ;
  end ;
end;

procedure TACBrECFClass.DoRelatorioGerencial;
begin
   ListaRelatorioGerencial( fsRelatorio, fsVias, fsIndiceRG )
end;

procedure TACBrECFClass.AbreRelatorioGerencial;
begin
  ErroAbstract('AbreRelatorioGerencial');
end;

procedure TACBrECFClass.LinhaRelatorioGerencial(Linha: AnsiString; IndiceBMP: Integer);
begin
  ErroAbstract('LinhaRelatorioGerencial');
end;

function TACBrECFClass.DecodificaTexto(Operacao: Char; Texto: String;
  var Resposta: String): Boolean;
begin
  Result := False ;
  ErroAbstract('DecodificaTexto');
end;

{ TACBrECFCodBarras }

constructor TACBrECFCodBarras.create;
begin
  Zera;
end;

procedure TACBrECFCodBarras.AdicionarCodBarra(TipoBarra: TACBrECFTipoCodBarra;
  LanguraBarra, AlturaBarra: Integer; CodBarra: String; ImprimeCodEmbaixo: Boolean;
  ImprimeVertical : Boolean);
begin
  if TipoBarra = barEAN13 then
    if (Length(CodBarra) <> 12) or (StrToInt64Def(CodBarra, -1) = -1) then
      raise Exception.Create( 'EAN-13 suporta 12 dígitos de 0 a 9' ) ;

  if TipoBarra = barEAN8 then
    if (Length(CodBarra) <> 7) or (StrToInt64Def(CodBarra, -1) = -1) then
      raise Exception.Create( 'EAN-8 suporta 7 dígitos de 0 a 9' ) ;

  if TipoBarra = barUPCA then
    if (Length(CodBarra) <> 11) or (StrToInt64Def(CodBarra, -1) = -1) then
      raise Exception.Create( 'UPC-A suporta 11 dígitos de 0 a 9' ) ;

  if TipoBarra = barCODE11 then
    if (StrToInt64Def(CodBarra, -1) = -1) then
      raise Exception.Create( 'CODE 11 suporta Tamanho variável. 0 a 9 ' ) ;

  if TipoBarra = barInterleaved then
    if (StrToInt64Def(CodBarra, -1) = -1) then
      raise Exception.Create( 'Interleaved 2 of 5 Tamanho sempre par. 0 a 9' ) ;

  if TipoBarra = barStandard then
    if (StrToInt64Def(CodBarra, -1) = -1) then
      raise Exception.Create( 'Standard 2 of 5 Tamanho variável. 0 a 9' ) ;

  if TipoBarra = barMSI  then
    if (StrToInt64Def(CodBarra, -1) = -1) then
      raise Exception.Create( 'MSI Tamanho variável. 0 a 9' ) ;

  fsTipoBarra     :=  TipoBarra;
  fsLanguraBarra  :=  LanguraBarra;
  fsAlturaBarra   :=  AlturaBarra;
  fsCodigo        :=  CodBarra;
  fsImpCodEmbaixo :=  ImprimeCodEmbaixo;
  fsImpVertical   :=  ImprimeVertical;
end;

procedure TACBrECFCodBarras.Zera;
begin
  fsTipoBarra     :=  barEAN13;
  fsLanguraBarra  :=  0;
  fsAlturaBarra   :=  0;
  fsCodigo        :=  '';
  fsImpCodEmbaixo :=  False;
end;

function TACBrECFCodBarras.GetAdicionado: Boolean;
begin
  Result := (fsCodigo <> '') ;
end;

function TACBrECFCodBarras.GetEnviado: Boolean;
begin
  Result := fsEnviado or (not Adicionado) ;
end;


procedure TACBrECFClass.ListaRelatorioGerencial(Relatorio: TStrings;
  Vias: Integer; Indice: Integer);
Var Imp, Lin : Integer ;
    Texto : String ;
begin
  Imp := 0 ;

  while Imp < Vias do
  begin
     try
        Texto := Format(MsgRelatorio,['Relatório Gerêncial',Imp+1 ]) ;
     except
        Texto := MsgRelatorio ;
     end ;

     {$IFNDEF CONSOLE}
       FormMsgPinta( Texto );
     {$ENDIF}

     if MaxLinhasBuffer < 1 then
        TACBrECF(fpOwner).LinhaRelatorioGerencial( Relatorio.Text )
     else
      begin
        Texto := '' ;
        For Lin := 0 to Relatorio.Count - 1 do
        begin
           Texto := Texto + Relatorio[Lin] + sLineBreak;
           if (Lin mod MaxLinhasBuffer) = 0 then
           begin
              TACBrECF(fpOwner).LinhaRelatorioGerencial( Texto ) ;
              Texto := '' ;
           end ;
        end ;

        if Texto <> '' then
           TACBrECF(fpOwner).LinhaRelatorioGerencial( Texto ) ;
      end ;

     Inc(Imp) ;
     if Imp < Vias then
     begin
        TACBrECF(fpOwner).PulaLinhas ;
        TACBrECF(fpOwner).CortaPapel ;
        PausarRelatorio( Imp ) ;
     end ;
  end ;

  {$IFNDEF CONSOLE}
    FormMsgPinta( cACBrECFFechandoRelatorioGerencial );
  {$ENDIF}
  TACBrECF(fpOwner).FechaRelatorio ;
end;

{ ------------------------------ Pausar Relatorios -------------------------}
procedure TACBrECFClass.PausarRelatorio( Via : Integer );
Var Texto : String ;
    SecRest, SecAnt : Integer ;
    FimPausa : TDateTime ;
begin

  Try
     FimPausa := IncSecond( now, PausaRelatorio ) ;
     SecAnt := 0 ;
     {$IFNDEF CONSOLE}
       fsFormMsgTeclaParaFechar := 13 ;
     {$ENDIF}

     while (now < FimPausa) do
     begin
       {$IFNDEF CONSOLE}
         if not (fsFormMsgEstado = fmsProcessando) then
            Break ;

          SecRest := SecondsBetween(now,  FimPausa) ;
          if SecAnt <> SecRest then  { Verifica se mudou os segundos }
          begin
             SecAnt := SecRest ;

             try
                Texto := Format(MsgPausaRelatorio, [Via, SecRest]) ;
             except
                Texto := MsgPausaRelatorio ;
             end ;

             FormMsgPinta( Texto );
          end ;

          Application.ProcessMessages ;
       {$ELSE}
          sleep(100) ;
       {$ENDIF}
     end ;
  finally
     {$IFNDEF CONSOLE}
       fsFormMsgTeclaParaFechar := 0 ;
       fsFormMsgEstado := fmsProcessando ;
     {$ENDIF}
  end ;
end;





{$IFNDEF CONSOLE}
  function TACBrECFClass.FormMsgDoProcedure(AProcedure: TACBrFormMsgProcedure;
    TeclaParaFechar: Word): Boolean;
  Var Timer : TTimer ;
      {$IFDEF VisualCLX}
      OldOnEvent : TEventEvent;
      OldCursor  : TCursor ;
      {$ENDIF}
  begin
    Result := true ;
    {$IFDEF VisualCLX}
    OldOnEvent := Application.OnEvent ;
    OldCursor  := Screen.Cursor ;
    {$ENDIF}

    if Assigned(fsFormMsg) then
       Raise Exception.Create(cACBrECFFormMsgDoProcedureException) ;

    fsFormMsg  := TForm.create( Application ) ;

    try
       {$IFDEF VisualCLX}
       Application.OnEvent := FormMsgEvent ;
       {$ENDIF}
       fsFormMsgProcedureAExecutar := AProcedure ;
       fsFormMsgTeclaParaFechar    := TeclaParaFechar ;
       fsFormMsgEstado             := fmsProcessando ;

       fsFormMsg.KeyPreview   := true ;
       fsFormMsg.OnKeyPress   := FormMsgKeyPress ;
       fsFormMsg.OnCloseQuery := FormMsgCloseQuery ;
       fsFormMsg.Color        := fsFormMsgColor ;
       fsFormMsg.Font         := fsFormMsgFont ;
       fsFormMsg.BorderIcons  := [] ;
       fsFormMsg.BorderStyle  := {$IFDEF VisualCLX} fbsNone {$ELSE} bsNone {$ENDIF};
       fsFormMsg.Position     := poMainFormCenter ;
       fsFormMsg.FormStyle    := fsStayOnTop ;
       fsFormMsg.Width        := 0 ;   { Cria o form escondido }
       fsFormMsg.Height       := 0 ;
       fsFormMsgException     := '' ;
       {$IFDEF LINUX}
        {$IFNDEF FPC}
         fsFormMsg.OnShow     := FormShow ;
        {$ENDIF}
       {$ENDIF}

       if BloqueiaMouseTeclado then
        begin
          { Quando o Timer for ativado, a procedure em fsFormMsgProcedureAExecutar
            será executada... Ao fim da Procurede o fsFormMsg é fechado }
          { O objeto Timer será destruido no proprio evento FormMsgTimer }

          Timer := TTimer.Create(fsFormMsg);
          Timer.Enabled  := false ;
          Timer.OnTimer  := FormMsgTimer ;
          Timer.Interval := 3 ;
          Timer.Enabled  := True ;

          fsFormMsg.ShowModal ;
        end
       else
        begin
          fsFormMsg.Show ;
          FormMsgTimer(Self);
        end ;

       if fsFormMsgException <> '' then
          raise Exception.Create( fsFormMsgException ) ;
    finally
       {$IFDEF VisualCLX}
       Application.OnEvent := OldOnEvent;
       Screen.Cursor       := OldCursor ;
       {$ENDIF}
       FreeAndNil(fsFormMsg) ;
    end
  end;

  procedure TACBrECFClass.FormMsgTimer(Sender: TObject);
  begin
    if Sender is TTimer then
    begin
       TTimer(Sender).Enabled := false ;
       FreeAndNil( Sender ) ;
    end ;

    try
       try
          if Assigned( fsFormMsgProcedureAExecutar ) then
             fsFormMsgProcedureAExecutar  ;
       finally
          if Assigned( fsOnMsgAguarde ) then
             fsOnMsgAguarde( '' ) ;

          if fsFormMsgEstado = fmsProcessando then
             fsFormMsgEstado := fmsConcluido
          else
             fsFormMsgEstado := fmsAbortado ;

          fsFormMsg.Close ;
          //{$IFNDEF COMPLIB_CLX}
          Application.BringToFront ;
          //{$ENDIF}
       end ;
    except
      { Não dispra a exceção dentro do Envento do Timer para a ordem da Pilha
        de Exceções ficar correta }
      on E : Exception
      do begin
         fsFormMsgException := E.Message ;
      end ;
    end ;
  end;

  procedure TACBrECFClass.FormMsgKeyPress(Sender: TObject; var Key: Char);
  begin
    if (fsFormMsgTeclaParaFechar <> 0)  and
       (UpCase( Key ) = chr(fsFormMsgTeclaParaFechar)) and
       (fsFormMsgEstado <> fmsAbortado) then
       fsFormMsgEstado := fmsAbortado
    else
       Key := chr(0) ;
  end;

  procedure TACBrECFClass.FormMsgCloseQuery(Sender: TObject;
    var CanClose: Boolean);
  begin
    CanClose := (fsFormMsgEstado <> fmsProcessando) ;
  end;
  {$D-}
  {$IFDEF VisualCLX}
    procedure TACBrECFClass.FormMsgEvent(Sender: QObjectH; Event: QEventH;
      var Handled: Boolean);
    {$IFDEF QT3CLX}
    Var  EventType: QEventH;
    {$ELSE}
    Var  EventType: QEventType;
    {$ENDIF}
    begin
      {$IFDEF QT3CLX}
      EventType := Event;
      {$ELSE}
      EventType := QEvent_type(Event);
      {$ENDIF}

      {$IFDEF LINUX}
      { No Linux o Formulario pode ser Minimizado ou arrastado mesmo com um
        ShowModal sobrepondo a aplicação... Portanto vamos esconder o cursor e não
        permitir que ele se mova }
         if Assigned(fsFormMsg) then
         begin
            {$IFDEF QT3CLX}
            if EventType.type_ in [QEvent_Type_Close, QEvent_Type_Hide, QEvent_Type_Quit,
                             QEvent_Type_ShowMinimized, QEvent_Type_WindowDeActivate,
                             QEvent_Type_MouseMove, QEvent_Type_MouseButtonPress,
                             QEvent_Type_MouseButtonRelease,
                             QEvent_Type_MouseButtonDblClick,
                             QEvent_Type_DragMove,
                             QEvent_Type_Leave, QEvent_Type_Enter] then
            {$ELSE}
            if EventType in [QEventType_Close, QEventType_Hide, QEventType_Quit,
                             QEventType_ShowMinimized, QEventType_WindowDeActivate,
                             QEventType_MouseMove, QEventType_MouseButtonPress,
                             QEventType_MouseButtonRelease,
                             QEventType_MouseButtonDblClick,
                             QEventType_DragMove,
                             QEventType_Leave, QEventType_Enter] then
            {$ENDIF}                 
            begin
               Handled := true ;
               fsFormMsg.SetFocus ;
            end ;

            if fsFormMsg.Visible then
            begin
               Mouse.CursorPos := Point(fsFormMsg.Left,fsFormMsg.Top) ;
               Screen.Cursor   := crNone ;
            end ;
         end ;
      {$ENDIF}

      {$IFDEF QT3CLX}
      if EventType.type_ = QEvent_Type_Close then
         Handled := true

      else if ((EventType.type_ in [QEvent_Type_KeyPress]) and (fsFormMsgTeclaParaFechar = 0)) or
               ( EventType.type_ = QEvent_Type_MouseButtonPress) then
         Handled := true ;
      {$ELSE}
      if EventType = QEventType_Close then
         Handled := true

      else if ((EventType in [QEventType_KeyPress]) and (fsFormMsgTeclaParaFechar = 0)) or
               ( EventType = QEventType_MouseButtonPress) then
         Handled := true ;
      {$ENDIF}
    end;
  {$ENDIF}
  {$D+}
  procedure TACBrECFClass.FormMsgPinta( Texto : String );
  Var H, W, X, Y : Integer ;
  begin
    if Assigned( fsOnMsgAguarde ) then
       fsOnMsgAguarde( Texto ) ;

    if not Assigned( fsFormMsg ) then
       exit ;

    if fsFormMsg.Visible and ExibeMensagem then
    begin
       fsFormMsg.BringToFront ;
       fsFormMsg.SetFocus ;

       with fsFormMsg.Canvas do      { Pintando <Texto> no Canvas do fpFormMsg }
       begin
          H := TextHeight(Texto) + 10 ;    { Calcula o tamanho do Texto }
          W := TextWidth (Texto) + 20 ;

          { Ajusta o Form para caber o Texto }
          if (abs(W - fsFormMsg.Width ) > 4) or
             (abs(H - fsFormMsg.Height) > 4) then
          begin
             fsFormMsg.Width  := W ;
             fsFormMsg.Height := H ;
             {$IFDEF FPC}
             fsFormMsg.Position := poDesktopCenter ;
             {$ELSE}
             fsFormMsg.Position := poMainFormCenter ;
             {$ENDIF}
          end ;

          Brush.Color := fsFormMsg.Color ;
          Font.Color  := fsFormMsg.Font.Color ;
          Pen.Color   := fsFormMsg.Font.Color ;
          Rectangle(fsFormMsg.ClientRect);
         {$IFDEF VisualCLX}
          X := 0 ;
          Y := 0 ;
          TextRect(fsFormMsg.ClientRect,X,Y, Texto, 36 ) ; { 36 = No Centro }
         {$ELSE}
          { Na VCL nao tem como centralizar no Form nem quebra de Linhas }
          Texto := StringReplace( Texto, #10, ' ', [rfReplaceAll,rfIgnoreCase] ) ;
          X := 10 ;
          Y := 5 ;
          TextRect(fsFormMsg.ClientRect,X,Y, Texto ) ;
         {$ENDIF}
       end ;
       Application.ProcessMessages ;
    end ;
  end;

  function TACBrECFClass.FormMsgExibe : Boolean;
  begin
    Result := (ExibeMensagem or BloqueiaMouseTeclado) and
              (AguardaImpressao or ((TimeOut - TempoInicioMsg) > 1) ) and
              FormMsgControla and
              Application.ShowMainForm ;
  end;

  {$IFDEF LINUX}
   {$IFNDEF FPC}
    procedure TACBrECFClass.FormShow(Sender: TObject);
    begin
     {$IFDEF QT3CLX}
      fsFormMsg.Handle.grabKeyboard;
      fsFormMsg.Handle.releaseKeyboard;
     {$ELSE}
      QWidget_grabKeyboard(fsFormMsg.Handle);
      QWidget_releaseKeyboard(fsFormMsg.Handle);
     {$ENDIF}
    end;
   {$ENDIF}
  {$ENDIF}
{$ENDIF}

end.


