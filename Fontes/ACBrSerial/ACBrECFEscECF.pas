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
{ http://www.opensource.org/licenses/gpl-license.php                           }
{                                                                              }
{ Daniel Simões de Almeida  -  daniel@djsystem.com.br  -  www.djsystem.com.br  }
{              Praça Anita Costa, 34 - Tatuí - SP - 18270-410                  }
{                                                                              }
{******************************************************************************}

{******************************************************************************
|* Historico
|*
|* 20/10/2012:  Daniel Simoes de Almeida
|*   Primeira Versao: Criaçao e Distribuiçao da Primeira Versao
******************************************************************************}

{$I ACBr.inc}

unit ACBrECFEscECF ;

interface
uses ACBrECFClass, ACBrUtil, ACBrDevice, ACBrConsts,
     Classes ;

type

{ TACBrECFEscECFRET }

TACBrECFEscECFRET = class
private
   fsECF: Byte;
   fsFabricante: Byte;
   fsFisco: Byte;
   fsRET: AnsiString;
   fsSPR: Byte;
   procedure SetRET(AValue: AnsiString);
 public
    constructor Create;
    property ECF        : Byte read fsECF ;
    property Fisco      : Byte read fsFisco ;
    property SPR        : Byte read fsSPR ;
    property Fabricante : Byte read fsFabricante ;

    property RET : AnsiString read fsRET write SetRET ;

    procedure Clear;
end;


{ TACBrECFEscECFComando }

TACBrECFEscECFComando = class
  private
    fsCMD     : Byte ;
    fsEXT     : Byte ;
    fsSEQ     : Byte ;
    fsParams  : TStringList ;
    fsTimeOut : Integer;

    function GetComando: AnsiString;
    procedure SetCMD(const Value: Byte);
 public
    constructor Create ;
    destructor Destroy ; override ;

    property CMD : Byte read fsCMD write SetCMD ;
    property EXT : Byte read fsEXT write fsEXT ;
    property SEQ : Byte read fsSEQ write fsSEQ ;
    property TimeOut : Integer read fsTimeOut write fsTimeOut ;

    property Comando : AnsiString  read GetComando ;
    property Params  : TStringList read fsParams ;

    Procedure AddParamString(AString : AnsiString) ;
    Procedure AddParamInteger(AInteger : Integer) ;
    Procedure AddParamDouble(ADouble : Double; Decimais: Byte = 2) ;
    Procedure AddParamDateTime( ADateTime: TDateTime; Tipo : Char = 'D';
                                FlagHV : String = '' ) ;
 end ;

{ TACBrECFEscECFResposta }

TACBrECFEscECFResposta = class
  private
    fsResposta : AnsiString ;
    fsParams   : TStringList ;
    fsRET      : TACBrECFEscECFRET;
    fsSEQ      : Byte ;
    fsCMD      : Byte ;
    fsEXT      : Byte ;
    fsCAT      : Byte ;
    fsTBR      : Integer ;
    fsBRS      : AnsiString ;
    fsCHK      : Byte ;

    procedure SetResposta(const Value: AnsiString);
 public
    constructor create ;
    destructor Destroy ; override ;

    property Resposta : AnsiString  read fsResposta write SetResposta ;
    property Params   : TStringList read fsParams ;
    property SEQ      : Byte        read fsSEQ ;
    property CMD      : Byte        read fsCMD ;
    property EXT      : Byte        read fsEXT ;
    property CAT      : Byte        read fsCAT ;
    property RET      : TACBrECFEscECFRET read fsRET ;
    property TBR      : Integer     read fsTBR ;
    property BRS      : AnsiString  read fsBRS ;
    property CHK      : Byte        read fsCHK ;
 end ;


 { Classe filha de TACBrECFClass com implementaçao para EscECF }
TACBrECFEscECF = class( TACBrECFClass )
 private
    fsNumVersao      : String ;
    fsVersaoEscECF   : String ;
    fsNumECF         : String ;
    fsNumCRO         : String ;
    fsEscECFComando  : TACBrECFEscECFComando;
    fsEscECFResposta : TACBrECFEscECFResposta;
    fsDecimaisPreco  : Integer;
    fsDecimaisQtd    : Integer;
    fsMarcaECF       : String ;
    fsModeloECF      : String ;
    fsEmPagamento    : Boolean ;

    function PreparaCmd(CmdExtBcd: AnsiString): AnsiString;
    Function TraduzErroMsg( CAT, Ocorrencia : Byte) : String;
 protected
    function VerificaFimLeitura(var Retorno: AnsiString;
      var TempoLimite: TDateTime): Boolean; override;

    function GetModeloStr: String; override ;
    function GetDataHora: TDateTime; override ;
    function GetNumCupom: String; override ;
    function GetNumECF: String; override ;
    //function GetNumLoja: String; override ;
    function GetNumCRO: String; override ;
    function GetNumSerie: String; override ;
    //function GetNumSerieMFD: String; override ;
    function GetNumVersao: String; override ;
    function GetSubTotal: Double; override ;
    function GetTotalPago: Double; override ;

    function GetNumReducoesZRestantes: String; override;

    function GetCNPJ: String; override ;
    function GetIE: String; override ;
    function GetIM: String; override ;
    function GetCliche: AnsiString; override ;
    //function GetUsuarioAtual: String; override ;
    //function GetDataHoraSB: TDateTime; override ;
    function GetSubModeloECF: String ; override ;

    //function GetPAF: String; override ;
    function GetDataMovimento: TDateTime; override ;
    function GetGrandeTotal: Double; override ;
    function GetNumCCF: String; override ;
    function GetNumGNF: String; override ;
    function GetNumGRG: String; override ;
    function GetNumCDC: String; override ;
    function GetNumCFC: String; override ;
    function GetNumGNFC: String; override ;
    function GetNumCRZ: String; override ;
    function GetNumCFD: String; override ;
    function GetNumNCN: String; override ;
    //function GetNumCCDC: String; override ;
    function GetVendaBruta: Double; override ;
    function GetTotalAcrescimos: Double; override ;
    function GetTotalCancelamentos: Double; override ;
    function GetTotalDescontos: Double; override ;
    function GetTotalTroco: Double; override ;
    function GetTotalSubstituicaoTributaria: Double; override ;
    function GetTotalNaoTributado: Double; override ;
    function GetTotalIsencao: Double; override ;
    //function GetTotalNaoFiscal: Double; override ;
    //function GetTotalAcrescimosISSQN: Double; override ;
    //function GetTotalCancelamentosISSQN: Double; override ;
    //function GetTotalDescontosISSQN: Double; override ;
    //function GetTotalIsencaoISSQN: Double; override ;
    //function GetTotalNaoTributadoISSQN: Double; override ;
    //function GetTotalSubstituicaoTributariaISSQN: Double; override ;
    //function GetTotalAcrescimosOPNF: Double; override ;
    //function GetTotalCancelamentosOPNF: Double; override ;
    //function GetTotalDescontosOPNF: Double; override ;
    function GetNumCOOInicial: String; override ;
    //function GetNumUltimoItem: Integer; override ;

    //function GetDadosUltimaReducaoZ: AnsiString; override ;

    function GetEstado: TACBrECFEstado; override ;
    function GetGavetaAberta: Boolean; override ;
    function GetPoucoPapel : Boolean; override ;
    function GetHorarioVerao: Boolean; override ;
    //function GetChequePronto: Boolean; override ;
    //function GetParamDescontoISSQN: Boolean; override;

    //function GetTipoUltimoDocumento : TACBrECFTipoDocumento ; override ;

 public
    Constructor create( AOwner : TComponent  )  ;
    Destructor Destroy  ; override ;

    procedure Ativar ; override ;

    property EscECFComando  : TACBrECFEscECFComando  read fsEscECFComando ;
    property EscECFResposta : TACBrECFEscECFResposta read fsEscECFResposta ;

    Property DecimaisPreco  : Integer read fsDecimaisPreco ;
    Property DecimaisQtd    : Integer read fsDecimaisQtd   ;

    Function EnviaComando_ECF( cmd : AnsiString = '' ) : AnsiString ; override ;

    { Aliquotas de ICMS }
    procedure CarregaAliquotas ; override ;
    procedure LerTotaisAliquota ; override ;
    function AchaICMSAliquota( var AliquotaICMS : String ) :
       TACBrECFAliquota ;  overload ; override;
    Procedure ProgramaAliquota( Aliquota : Double; Tipo : Char = 'T';
       Posicao : String = '') ; override ;

    { Formas de Pagamento }
    procedure CarregaFormasPagamento ; override ;
    procedure LerTotaisFormaPagamento ; override ;
    Procedure ProgramaFormaPagamento( var Descricao: String;
       PermiteVinculado : Boolean = true; Posicao : String = '' ) ; override ;

    { Relatório Gerencial (RG) }
    procedure CarregaRelatoriosGerenciais ; override ;
    procedure LerTotaisRelatoriosGerenciais ; override ;
    Procedure ProgramaRelatorioGerencial( var Descricao: String;
       Posicao : String = '') ; override ;

    { Comprovantes Nao Fiscais (CNF) }
    procedure CarregaComprovantesNaoFiscais ; override ;
    procedure LerTotaisComprovanteNaoFiscal ; override ;
    Procedure ProgramaComprovanteNaoFiscal( var Descricao: String;
       Tipo : String = ''; Posicao : String = '') ; override ;

    { Cupom Fiscal }
    Procedure AbreCupom ; override ;
    Procedure VendeItem( Codigo, Descricao : String; AliquotaECF : String;
       Qtd : Double ; ValorUnitario : Double; ValorDescontoAcrescimo : Double = 0;
       Unidade : String = ''; TipoDescontoAcrescimo : String = '%';
       DescontoAcrescimo : String = 'D'; CodDepartamento: Integer = -1) ; override ;
    Procedure DescontoAcrescimoItemAnterior( ValorDescontoAcrescimo : Double = 0;
       DescontoAcrescimo : String = 'D'; TipoDescontoAcrescimo : String = '%';
       NumItem : Integer = 0 ) ;  override ;
    Procedure SubtotalizaCupom( DescontoAcrescimo : Double = 0;
       MensagemRodape : AnsiString = '' ) ;  override ;
    procedure CancelaDescontoAcrescimoSubTotal(TipoAcrescimoDesconto: Char) ;
       override ;{ A -> Acrescimo D -> Desconto }
    Procedure EfetuaPagamento( CodFormaPagto : String; Valor : Double;
       Observacao : AnsiString = ''; ImprimeVinculado : Boolean = false) ;
       override ;
    procedure EstornaPagamento(const CodFormaPagtoEstornar,
      CodFormaPagtoEfetivar : String; const Valor: Double;
      Observacao : AnsiString = '') ; override ;

    { Para quebrar linhas nos parametros Observacao use #10 ou chr(10),
      Geralmente o ECF aceita no máximo 8 linhas }
    Procedure FechaCupom( Observacao : AnsiString = ''; IndiceBMP : Integer = 0) ; override ;
    Procedure CancelaCupom ; override ;
    Procedure CancelaItemVendido( NumItem : Integer ) ; override ;
    //procedure CancelaItemVendidoParcial( NumItem : Integer; Quantidade : Double) ; override ;
    procedure CancelaDescontoAcrescimoItem( NumItem : Integer) ; override ;

    { Procedimentos de Cupom Não Fiscal }
    Procedure NaoFiscalCompleto( CodCNF : String; Valor : Double;
       CodFormaPagto  : String; Obs : AnsiString = ''; IndiceBMP : Integer = 0 ) ; override ;
    Procedure AbreNaoFiscal( CPF_CNPJ: String = ''; Nome: String = '';
       Endereco: String = '' ) ; override ;
    Procedure RegistraItemNaoFiscal( CodCNF : String; Valor : Double;
       Obs : AnsiString = '') ; override ;
    Procedure SubtotalizaNaoFiscal( DescontoAcrescimo : Double = 0;
       MensagemRodape: AnsiString = '') ; override ;
    Procedure EfetuaPagamentoNaoFiscal( CodFormaPagto : String; Valor : Double;
       Observacao : AnsiString = ''; ImprimeVinculado : Boolean = false) ; override ;
    Procedure FechaNaoFiscal( Observacao : AnsiString = ''; IndiceBMP : Integer = 0) ; override ;
    Procedure CancelaNaoFiscal ; override ;
    Procedure CancelaItemNaoFiscal(const AItem: Integer); override;

    procedure Sangria( const Valor: Double;  Obs : AnsiString;
       DescricaoCNF: String; DescricaoFPG: String; IndiceBMP: Integer ) ; override ;
    procedure Suprimento( const Valor: Double; Obs : AnsiString;
       DescricaoCNF: String; DescricaoFPG: String; IndiceBMP: Integer ) ; override ;

    Function EstornaCCD( const Todos: Boolean = True) : Integer; override ;

    { Gaveta de dinheiro }
    Procedure AbreGaveta  ; override ;

    { Relatorios }
    Procedure LeituraX ; override ;
    Procedure LeituraXSerial( Linhas : TStringList) ; override ;
    Procedure ReducaoZ( DataHora : TDateTime = 0 ) ; override ;
    Procedure RelatorioGerencial(Relatorio : TStrings; Vias : Integer = 1; Indice: Integer = 0) ;
    Procedure AbreRelatorioGerencial(Indice: Integer = 0) ; override ;
    Procedure LinhaRelatorioGerencial( Linha : AnsiString; IndiceBMP: Integer = 0 ) ; override ;

    Procedure CupomVinculado(COO, CodFormaPagto, CodComprovanteNaoFiscal :
       String; Valor : Double;  Relatorio : TStrings;
       Vias : Integer = 1) ;
    Procedure AbreCupomVinculado(COO, CodFormaPagto, CodComprovanteNaoFiscal :
       String; Valor : Double) ; override ;
    Procedure LinhaCupomVinculado( Linha : AnsiString ) ; override ;

    Procedure SegundaViaVinculado; override;
    procedure ReimpressaoVinculado; override;

    Procedure FechaRelatorio ; override ;
    Procedure PulaLinhas( NumLinhas : Integer = 0 ) ; override ;
    Procedure CortaPapel( const CorteParcial : Boolean = false) ; override ;

    { Cheques }
    Procedure ImprimeCheque(Banco : String; Valor : Double ; Favorecido,
       Cidade : String; Data : TDateTime ;Observacao : String = '') ; override ;
    Procedure CancelaImpressaoCheque ; override ;
    Function LeituraCMC7 : AnsiString ; override ;

    { Utilitarios e Diversos }
    Procedure MudaHorarioVerao ; overload ; override ;
    Procedure MudaHorarioVerao( EHorarioVerao : Boolean ) ; overload ; override ;
    Procedure MudaArredondamento( Arredondar : Boolean ) ; override ;
    Procedure PreparaTEF ; override ; { Carrega as Formas, de Pagamento e CNF,
                            verifica por Vinculos, etc Particular de cada ECF }
    Procedure CorrigeEstadoErro( Reducao: Boolean = True ) ; override ; { Verifica o estado da impressora e
                                              tenta deixar em estado Livre }
    Procedure ImpactoAgulhas( NivelForca : Integer = 2) ; override ;
    Procedure LeituraMemoriaFiscal( DataInicial, DataFinal : TDateTime;
       Simplificada : Boolean = False ) ; overload ; override ;
    Procedure LeituraMemoriaFiscal( ReducaoInicial, ReducaoFinal : Integer;
       Simplificada : Boolean = False ); overload ; override ;
    Procedure LeituraMemoriaFiscalSerial( DataInicial, DataFinal : TDateTime;
       Linhas : TStringList; Simplificada : Boolean = False ) ;
       overload ; override ;
    Procedure LeituraMemoriaFiscalSerial( ReducaoInicial, ReducaoFinal: Integer;
       Linhas : TStringList; Simplificada : Boolean = False ) ;
       overload ; override ;

    Procedure LeituraMFDSerial( DataInicial, DataFinal : TDateTime;
       Linhas : TStringList; Documentos : TACBrECFTipoDocumentoSet = [docTodos] ) ; overload ; override ;
    Procedure LeituraMFDSerial( COOInicial, COOFinal : Integer;
       Linhas : TStringList; Documentos : TACBrECFTipoDocumentoSet = [docTodos] ) ; overload ; override ;

    Procedure EspelhoMFD_DLL( DataInicial, DataFinal : TDateTime;
       NomeArquivo : AnsiString; Documentos : TACBrECFTipoDocumentoSet = [docTodos]  ) ; overload ; override ;
    Procedure EspelhoMFD_DLL( COOInicial, COOFinal : Integer;
       NomeArquivo : AnsiString; Documentos : TACBrECFTipoDocumentoSet = [docTodos]  ) ; overload ; override ;
    Procedure ArquivoMFD_DLL( DataInicial, DataFinal : TDateTime;
       NomeArquivo : AnsiString; Documentos : TACBrECFTipoDocumentoSet = [docTodos];
       Finalidade: TACBrECFFinalizaArqMFD = finMFD  ) ; overload ; override ;
    Procedure ArquivoMFD_DLL( ContInicial, ContFinal : Integer;
       NomeArquivo : AnsiString; Documentos : TACBrECFTipoDocumentoSet = [docTodos];
       Finalidade: TACBrECFFinalizaArqMFD = finMFD;
       TipoContador: TACBrECFTipoContador = tpcCOO ) ; overload ; override ;

    procedure PafMF_GerarCAT52(const DataInicial, DataFinal: TDateTime;
      const DirArquivos: String); override;

    Procedure IdentificaOperador(Nome : String); override;
    Procedure IdentificaPAF( NomeVersao, MD5 : String) ; override ;
    Function RetornaInfoECF( Registrador: String) : AnsiString; override ;
 end ;

Function TB2Int( ATB: AnsiString ) : Integer ;
Function Int2TB( AInteger : Integer ) : AnsiString ;

implementation
Uses SysUtils, Math, ACBrECF,
    {$IFDEF COMPILER6_UP} DateUtils, StrUtils {$ELSE} ACBrD5, Windows{$ENDIF} ;

function TB2Int(ATB: AnsiString): Integer;
var
   AHexStr: String;
begin
  AHexStr := '$' + IntToHex(ord(ATB[2]),2) + IntToHex(ord(ATB[1]),2) ;
  Result := StrToInt( AHexStr );
end;

function Int2TB(AInteger: Integer): AnsiString;
var
   AHexStr: String;
begin
  AHexStr := IntToHex(AInteger,4);
  Result  := chr( StrToInt('$'+copy(AHexStr,3,2) ) ) +
             chr( StrToInt('$'+copy(AHexStr,1,2) ) ) ;
end;


{ TACBrECFEscECFRET }

constructor TACBrECFEscECFRET.Create;
begin
  inherited create ;

  Clear;
end;

procedure TACBrECFEscECFRET.SetRET(AValue: AnsiString);
begin
   if fsRET=AValue then Exit;

   if Length(AValue) < 4 then
      raise EACBrECFERRO.Create(ACBrStr('RET deve ter tamanho de 4 bytes')) ;

   fsRET        := AValue;
   fsECF        := ord( fsRET[1] );
   fsFisco      := ord( fsRET[2] );
   fsSPR        := ord( fsRET[3] );
   fsFabricante := ord( fsRET[4] );
end;

procedure TACBrECFEscECFRET.Clear;
begin
   fsECF        := 0;
   fsFabricante := 0;
   fsFisco      := 0;
   fsSPR        := 0;
   fsRET        := '';
end;

{ ------------------------------ TACBrECFEscECFComando -------------------------- }

constructor TACBrECFEscECFComando.Create;
begin
  inherited Create ;

  fsParams := TStringList.create ;
  fsSEQ    := 0 ;
end;

destructor TACBrECFEscECFComando.destroy;
begin
  fsParams.Free ;

  inherited destroy ;
end;


procedure TACBrECFEscECFComando.SetCMD(const Value: Byte);
begin
  Inc( fsSEQ ) ;

  fsCMD     := Value ;
  fsEXT     := 0;
  fsTimeOut := 0 ;
  fsParams.Clear ;
end;

function TACBrECFEscECFComando.GetComando: AnsiString;
Var
  I, LenCmd, Soma : Integer ;
  Buffer, BCD : AnsiString ;
  TBC : Integer ;
  CHK : Byte ;
begin
  if (fsCMD = 255) and (fsEXT = 0) then
     raise EACBrECFERRO.Create(ACBrStr('Para comandos 255, EXT deve ser especificado')) ;

  BCD := '' ;
  For I := 0 to fsParams.Count-1 do
    BCD := BCD + BinaryStringToString( fsParams[I] ) + '|';
  TBC := Length( BCD ) ;

  Buffer := chr(fsSEQ) + chr(fsCMD) + chr(fsEXT) + Int2TB(TBC) + BCD ;

  Soma := 0 ;
  LenCmd := Length( Buffer ) ;
  For I := 1 to LenCmd do
     Soma := Soma + ord( Buffer[I] ) ;
  CHK := Soma mod 256  ;

  Result := SOH + Buffer + AnsiChar( Chr( CHK ) ) ;
end;

procedure TACBrECFEscECFComando.AddParamString(AString: AnsiString);
var
  Buf : AnsiString ;
begin
  { EscECF usa Pipe (|) como seprador, não permite o Pipe na String }
  //AString := StringReplace(AString,'|',':',[rfReplaceAll]) ;

  { Convertendo caracteres de comando para Hexa para poder armazenar
    corretamente no TStringList }
  Buf := StringToBinaryString( AString );

  fsParams.Add( TrimRight( Buf ) ) ;
end;

procedure TACBrECFEscECFComando.AddParamDouble(ADouble: Double; Decimais: Byte);
begin
  AddParamInteger( Round( ADouble * power(10, Decimais) ) ) ;
end;

procedure TACBrECFEscECFComando.AddParamInteger(AInteger: Integer);
begin
  AddParamString( IntToStr( AInteger ) ) ;
end;

procedure TACBrECFEscECFComando.AddParamDateTime(ADateTime: TDateTime;
   Tipo : Char = 'D'; FlagHV : String = ''  ) ;
Var
  Formato : String ;
begin
  case Tipo of
    'T','H' : Formato := 'hhnnss' ;
        'D' : Formato := 'ddmmyyyy' ;
  else
     Formato := 'ddmmyyyyhhnnss' ;
  end ;

  AddParamString( FormatDateTime(Formato, ADateTime) + FlagHV ) ;
end;


{ ----------------------------- TACBrECFEscECFResposta -------------------------- }

constructor TACBrECFEscECFResposta.create;
begin
  inherited create ;

  fsParams := TStringList.create ;
  fsRET    := TACBrECFEscECFRET.Create;
  fsSEQ    := 0 ;
  fsCMD    := 0 ;
  fsEXT    := 0  ;
  fsCAT    := 0  ;
  fsTBR    := 0  ;
  fsBRS    := '' ;
  fsCHK    := 0 ;
end;

destructor TACBrECFEscECFResposta.destroy;
begin
  fsParams.Free ;
  fsRET.Free;
  inherited destroy ;
end;

procedure TACBrECFEscECFResposta.SetResposta(const Value: AnsiString);
Var
  Soma, I, F, LenCmd : Integer ;
  CHK  : Byte ;
begin
  fsParams.Clear ;
  fsRET.Clear;
  fsSEQ := 0 ;
  fsCMD := 0 ;
  fsEXT := 0  ;
  fsCAT := 0  ;
  fsTBR := 0  ;
  fsBRS := '' ;
  fsCHK := 0 ;

  if Value = '' then exit ;

  LenCmd := Length( Value ) ;

  if (LenCmd = 6) then  // Retorno de NAK ou WAK
  begin
    fsResposta := Value ;
    fsCAT      := ord( Value[2] ) ;
    fsRET.RET  := Copy( Value, 3, 4 );
    exit ;
  end;

  if LenCmd < 12 then
     raise EACBrECFSemResposta.Create('Tamanho de Resposta muito curto: '+
                                      IntToStr(LenCmd)+' bytes');

  fsResposta := Value ;
  fsSEQ      := ord( Value[2] ) ;
  fsCMD      := ord( Value[3] ) ;
  fsEXT      := ord( Value[4] ) ;
  fsCAT      := ord( Value[5] ) ;
  fsRET.RET  := Copy( Value, 6, 4 );
  fsTBR      := TB2Int( copy(Value,10,2) );
  fsBRS      := copy( Value, 12, fsTBR ) ;
  fsCHK      := ord( Value[ 12 + fsTBR ] ) ;

  Soma := 0 ;
  LenCmd := LenCmd-1 ;  { -1 por causa do CHK }
  For I := 2 to LenCmd do  
     Soma := Soma + ord( Value[I] ) ;
  CHK := Soma mod 256  ;

  if CHK <> fsCHK then
     raise EACBrECFSemResposta.Create(ACBrStr('Erro CHK Resposta. '+
        'Calculado:'+IntToStr(CHK)+' Recebido:'+IntToStr(fsCHK)));

  { Quebrando Parametros Separados por '|' e inserindo-os em fsParams }
  I := 1;
  while I < fsTBR do
  begin
     F := PosEx('|',fsBRS,I) ;
     if F < I then
        exit ;

     fsParams.Add( Copy(fsBRS, I, F-I) ) ;
     I := F+1;
  end ;
end;

{ ----------------------------- TACBrECFEscECF ------------------------------ }

constructor TACBrECFEscECF.create( AOwner : TComponent ) ;
begin
  inherited create( AOwner ) ;

  fsEscECFComando   := TACBrECFEscECFComando.create ;
  fsEscECFResposta  := TACBrECFEscECFResposta.create ;

  fpDevice.HandShake := hsDTR_DSR ;
  fpPaginaDeCodigo   := 1252;

  fpModeloStr := 'EscECF' ;
  fpColunas   := 57 ;
  fpMFD       := True ;
  fpTermica   := True ;
  fpIdentificaConsumidorRodape := True ;

  { Variaveis internas dessa classe }
  fsNumVersao     := '' ;
  fsVersaoEscECF  := '';
  fsNumECF        := '' ;
  fsNumCRO        := '' ;
  fsMarcaECF      := '';
  fsModeloECF     := '';
  fsDecimaisPreco := -1 ;
  fsDecimaisQtd   := -1;
  fsEmPagamento   := False ;

end;

destructor TACBrECFEscECF.Destroy;
begin
  fsEscECFComando.Free ;
  fsEscECFResposta.Free ;

  inherited Destroy ;
end;

procedure TACBrECFEscECF.Ativar;
var
   Params: String;
begin
  if not fpDevice.IsSerialPort  then
     raise EACBrECFERRO.Create(ACBrStr('A impressora: '+ModeloStr+' requer'+#10+
                            'Porta Serial:  (COM1, COM2, COM3, ...)'));

  inherited Ativar ; { Abre porta serial }

  fsNumVersao     := '' ;
  fsVersaoEscECF  := '' ;
  fsNumECF        := '' ;
  fsNumCRO        := '' ;
  fsMarcaECF      := '';
  fsModeloECF     := '';
  fsDecimaisPreco := -1 ;
  fsDecimaisQtd   := -1 ;
  
  fpMFD     := True ;
  fpTermica := True ;

  try
     { Testando a comunicaçao com a porta }
     Params := RetornaInfoECF( '15|0' );

     if Params = '' then
        raise EACBrECFNaoInicializado.Create( ACBrStr(
                 'Erro inicializando a impressora '+ModeloStr ));

     fsMarcaECF      := EscECFResposta.Params[0];
     fsModeloECF     := EscECFResposta.Params[1];
     fsNumECF        := EscECFResposta.Params[4];
     fpDecimaisPreco := min( StrToIntDef( EscECFResposta.Params[11], 2), 3);
     fpDecimaisQtd   := min( StrToIntDef( EscECFResposta.Params[12], 3), 3);
     fsNumVersao     := EscECFResposta.Params[13];
     fsVersaoEscECF  := EscECFResposta.Params[19];
  except
     Desativar ;
     raise ;
  end ;
end;


Function TACBrECFEscECF.EnviaComando_ECF( cmd : AnsiString = '') : AnsiString ;
Var
  ErroMsg : String ;
  OldTimeOut : Integer ;
begin
  if cmd <> '' then
     cmd := PreparaCmd(cmd) ;  // Ajusta e move para EscECFcomando

  cmd := EscECFComando.Comando ;

  Result                  := '' ;
  ErroMsg                 := '' ;
  fpComandoEnviado        := '' ;
  fpRespostaComando       := '' ;
  EscECFResposta.Resposta := '' ;
  OldTimeOut              := TimeOut ;
  TimeOut                 := max(EscECFComando.TimeOut, TimeOut) ;

  try
     fpDevice.Serial.DeadlockTimeout := 2000 ; { Timeout p/ Envio }
     fpDevice.Serial.Purge ;                   { Limpa a Porta }

     while fpComandoEnviado = '' do
     begin
        fpDevice.Serial.Purge ;                   { Limpa a Porta }

        if not TransmiteComando( cmd ) then
           continue ;

        fpComandoEnviado := cmd ;
     end ;

     { Chama Rotina da Classe mãe TACBrClass para ler Resposta. Se houver
       falha na leitura LeResposta dispara Exceçao.
       Resposta fica gravada na váriavel "fpRespostaComando" }
     LeResposta ;

     Try
        EscECFResposta.Resposta := fpRespostaComando ;

        ErroMsg := '' ;
        if EscECFResposta.CAT > 0 then
           ErroMsg := 'Erro: '+TraduzErroMsg(EscECFResposta.CAT, EscECFResposta.RET.ECF) ;
     except
        On E : Exception do
        begin
           ErroMsg := 'Resposta do ECF inválida' + sLineBreak + E.Message ;
        end ;
     end ;

     if ErroMsg <> '' then
      begin
        ErroMsg := ACBrStr('Erro retornado pela Impressora: '+ModeloStr+
                           sLineBreak+sLineBreak + ErroMsg ) ;

        if (EscECFResposta.CAT = 12) then
           DoOnErrorSemPapel
        else
           raise EACBrECFSemResposta.create(ErroMsg) ;
      end
     else
        Sleep( IntervaloAposComando ) ;  { Pequena pausa entre comandos }

  finally
     TimeOut := OldTimeOut ;
  end ;
end;

Function TACBrECFEscECF.VerificaFimLeitura(var Retorno: AnsiString;
   var TempoLimite: TDateTime) : Boolean ;
var
  LenRet, TBR : Integer;
  Byte1  : AnsiChar;

   procedure PedeStatus( SPR: Byte );
   begin
      GravaLog( '         Status TX -> '+ENQ+chr(SPR), True);
      fpDevice.Serial.SendBlock( ENQ + chr(SPR) ); // ACK ok, Pede Resposta
      Retorno := '';
      TempoLimite := IncSecond(now, TimeOut);
   end;

begin
  LenRet := Length( Retorno );
  Result := False;

  if LenRet < 1 then exit;

  Byte1 := Retorno[1];

  case Byte1 of
    SOH :
       begin
          if LenRet >= 11 then
          begin
             TBR    := TB2Int( copy(Retorno,10,2) ) ;
             Result := ( LenRet >=  (11 + TBR + 1) ) ;
          end ;
       end;

    ACK :
      begin
        GravaLog( '                RX <- '+Retorno, True);
        PedeStatus( EscECFComando.SEQ ) ;
      end;

    NAK,WAK :  Result := (LenRet >= 6) ;
  end;

  if Result then
  begin
     try
        { Esta atribuição, Já verifica o ChkSum, em caso de erro gera exception }
        EscECFResposta.Resposta := Retorno ;

        if (Byte1 = SOH) and
           (EscECFResposta.SEQ <> EscECFComando.SEQ) then  // Despreza esse Bloco
        begin
           raise EACBrECFCMDInvalido.Create(
              'Sequencia de Resposta ('+IntToStr(EscECFResposta.SEQ)+')'+
              'diferente da enviada ('+IntToStr(EscECFComando.SEQ)+
              '). Bloco Desprezado: '+Retorno ) ;
        end;
     except
        on E : EACBrECFCMDInvalido do
         begin
           GravaLog( '              Erro <- '+E.Message + ' - ' + Retorno  , True ) ;
           Result  := False ;
           Retorno := '' ;
         end
        else
           raise ;
     end ;
  end ;

  if Result and (Byte1 = WAK) then // Ocupado, aguarde e solicite novo Status
  begin
    GravaLog('                RX <- '+Retorno, True);
    Sleep( 150 );
    PedeStatus( EscECFResposta.RET.SPR );
    Result := False;
  end;
end;

function TACBrECFEscECF.GetModeloStr: String;
begin
   Result := fsMarcaECF + ' - ' + fsModeloECF;
end;


function TACBrECFEscECF.PreparaCmd(CmdExtBcd: AnsiString): AnsiString;
Var
  CMD, EXT : Byte ;
  BCD : AnsiString ;
begin
  if Length(CmdExtBcd) < 7 then
     raise EACBrECFERRO.Create(ACBrStr('Comando EscECF inválido')) ;

  CMD := ord( CmdExtBcd[1] ) ;
  EXT := ord( CmdExtBcd[2] ) ;
  BCD := copy( CmdExtBcd, 3, Length(CmdExtBcd) ) ;

  if (CMD = 255) and (EXT = 0) then
     raise EACBrECFERRO.Create(ACBrStr('Erro ! CMD = 255 e EXT = 0')) ;

  if (CMD <> 255) and (EXT <> 0) then
     raise EACBrECFERRO.Create(ACBrStr('Erro ! EXT deve ser 0 quando comando <> 255')) ;

  EscECFComando.CMD := CMD ;
  EscECFComando.EXT := EXT ;
  EscECFComando.Params.Text := BCD ;
end;

function TACBrECFEscECF.TraduzErroMsg(CAT, Ocorrencia: Byte): String;
var
   MsgCAT, MsgOcorrencia: String;
begin
   MsgCAT        := '';
   MsgOcorrencia := '';

   case CAT of
     01 :
       begin
         MsgCAT := 'Comando Inválido';

         case Ocorrencia of
           01 : MsgOcorrencia := 'O comando enviado para a impressora não existe no Software Básico' ;
         end;
       end;

     02 :
       begin
         MsgCAT := 'Erro em parâmetro do comando';

         case Ocorrencia of
           01 : MsgOcorrencia := 'Conteúdo de parâmetro inválido no comando.' ;
           02 : MsgOcorrencia := 'Falta parâmetro no comando' ;
           03 : MsgOcorrencia := 'Excesso de parâmetros no comando' ;
           04 : MsgOcorrencia := 'COO inicial maior que COO final.' ;
           05 : MsgOcorrencia := 'CRZ inicial maior que CRZ final' ;
           06 : MsgOcorrencia := 'Data inicial maior que Data final' ;
         end;
       end;

     03 :
       begin
         MsgCAT := 'Overflow de capacidade';

         case Ocorrencia of
           01 : MsgOcorrencia := 'Excedeu a capacidade máxima do totalizador.' ;
         end;
       end;

     04 :
       begin
         MsgCAT := 'Erro de contexto';

         case Ocorrencia of
           01 : MsgOcorrencia := 'Comando só pode ser executado em intervenção' ;
           02 : MsgOcorrencia := 'Comando não pode ser executado em intervenção' ;
           03 : MsgOcorrencia := 'Comando não pode ser executado localmente' ;
           04 : MsgOcorrencia := 'Comando não pode ser executado remotamente' ;
         end;
       end;

     05 :
       begin
         MsgCAT := 'Erro em Cupom Fiscal';

         case Ocorrencia of
           01 : MsgOcorrencia := 'Comando enviado não pode ser executado, pois existe um Cupom Fiscal aberto.' ;
           02 : MsgOcorrencia := 'Comando enviado não pode ser executado, pois existe um Comprovante Não Fiscal aberto.' ;
           03 : MsgOcorrencia := 'Comando enviado não pode ser executado, pois existe um Comprovante de Crédito ou Débito aberto.' ;
           04 : MsgOcorrencia := 'Comando enviado não pode ser executado, pois existe um Estorno de Comprovante de Crédito ou Débito aberto.' ;
           05 : MsgOcorrencia := 'Comando enviado não pode ser executado, pois existe um Relatório Gerencial aberto.' ;
           06 : MsgOcorrencia := 'Comando enviado não pode ser executado, pois o ECF está em repouso.' ;
           07 : MsgOcorrencia := 'A quantidade máxima de itens em um Cupom Fiscal foi ultrapassada.' ;
           08 : MsgOcorrencia := 'A quantidade de parcelas somente pode ser especificada para os pagamentos que envolvam meios que aceitem a emissão de CCD.' ;
           09 : MsgOcorrencia := 'Limite máximo de pagamentos por documento já foi atingido.' ;
           10 : MsgOcorrencia := 'Cancelamento de um Cupom Fiscal somente será permitido após o estorno de todos os CCDs emitidos.' ;
           11 : MsgOcorrencia := 'Comando não pode ser executado em documento não pago.';
           12 : MsgOcorrencia := 'Comando não pode ser executado após desconto ou acréscimo em Subtotal' ;
           13 : MsgOcorrencia := 'Comando de acréscimo/desconto já executado.' ;
           14 : MsgOcorrencia := 'Comando de consumidor já executado no clichê' ;
         end;
       end;

     06 :
       begin
         MsgCAT := 'Erro em Comprovante Não Fiscal';

         case Ocorrencia of
           01 : MsgOcorrencia := 'Comando enviado não pode ser executado, pois existe um Cupom Fiscal aberto.' ;
           02 : MsgOcorrencia := 'Comando enviado não pode ser executado, pois existe um Comprovante Não Fiscal aberto.' ;
           03 : MsgOcorrencia := 'Comando enviado não pode ser executado, pois existe um Comprovante de Crédito ou Débito aberto.' ;
           04 : MsgOcorrencia := 'Comando enviado não pode ser executado, pois existe um Estorno de Comprovante de Crédito ou Débito aberto.' ;
           05 : MsgOcorrencia := 'Comando enviado não pode ser executado, pois existe um Relatório Gerencial aberto.' ;
           06 : MsgOcorrencia := 'A quantidade máxima de itens em um Comprovante Não Fiscal foi ultrapassada.' ;
           07 : MsgOcorrencia := 'A quantidade de parcelas somente pode ser especificada para os pagamentos que envolvam meios que aceitem a emissão de CCD.' ;
           08 : MsgOcorrencia := 'Limite máximo de pagamentos por documento já foi atingido.' ;
           09 : MsgOcorrencia := 'Cancelamento de um Comprovante Não Fiscal somente será permitido após o estorno de todos os CCDs emitidos.' ;
           10 : MsgOcorrencia := 'Comando não pode ser executado em documento não pago.' ;
           11 : MsgOcorrencia := 'Comando não pode ser executado após desconto ou acréscimo em Subtotal';
           12 : MsgOcorrencia := 'Comando de acréscimo/desconto já executado.' ;
           13 : MsgOcorrencia := 'Comando de consumidor já executado no clichê' ;
         end;
       end;

     07 :
       begin
         MsgCAT := 'Erro em Relatório Gerencial ou CCD';

         case Ocorrencia of
           01 : MsgOcorrencia := 'Comando enviado não pode ser executado, pois existe um Cupom Fiscal aberto.' ;
           02 : MsgOcorrencia := 'Comando enviado não pode ser executado, pois existe um Comprovante Não Fiscal aberto.' ;
           03 : MsgOcorrencia := 'Comando enviado não pode ser executado, pois existe um Comprovante de Crédito ou Débito aberto.' ;
           04 : MsgOcorrencia := 'Comando enviado não pode ser executado, pois existe um Estorno de Comprovante de Crédito ou Débito aberto.' ;
           05 : MsgOcorrencia := 'Comando enviado não pode ser executado, pois existe um Relatório Gerencial aberto.' ;
           06 : MsgOcorrencia := 'Não existe CCD para o pagamento especificado.' ;
           07 : MsgOcorrencia := 'CCD especificado já foi impresso.' ;
           08 : MsgOcorrencia := 'CCD especificado já foi re-impresso' ;
           09 : MsgOcorrencia := 'CCD especificado já foi estornado.' ;
           10 : MsgOcorrencia := 'CDD não especificado no estorno não foi impresso' ;
           11 : MsgOcorrencia := 'limite máximo de CCD’s por cupom foi excedido.';
           12 : MsgOcorrencia := 'Comando enviado não pode ser executado dentro de CCD' ;
           13 : MsgOcorrencia := 'Documento anterior diferente de Cupom Fiscal e Comprovante Não fiscal.' ;
           14 : MsgOcorrencia := 'Envio de texto genérico para CCD ou Relatório Gerencial já fechado.' ;
         end;
       end;

     08 :
       begin
         MsgCAT := 'Erro em Redução Z';

         case Ocorrencia of
           01 : MsgOcorrencia := 'Redução Z pendente ou já realizada na data' ;
         end;
       end;

     09 :
       begin
         MsgCAT := 'Integridade';

         case Ocorrencia of
           01 : MsgOcorrencia := 'Memória Fiscal inicializada em outro ECF' ;
           02 : MsgOcorrencia := 'Memória de Fita Detalhe inicializada em outro de ECF.' ;
           03 : MsgOcorrencia := 'Marca do ECF, Tipo ou Modelo incompatível com o gravado na Memória Fiscal.' ;
           04 : MsgOcorrencia := 'Número de série da MF diferente do gravado na MFD.' ;
           05 : MsgOcorrencia := 'Não foi localizado o número de série na MF.' ;
           06 : MsgOcorrencia := 'Não foi localizado na MF o registro do BR.' ;
           07 : MsgOcorrencia := 'Não foi localizado na MF o Símbolo da moeda.' ;
           08 : MsgOcorrencia := 'Não foram localizados na MF os símbolos de criptografia do GT.' ;
           09 : MsgOcorrencia := 'Não foi localizado na MF o CNPJ/ IE ou IM do usuário' ;
           10 : MsgOcorrencia := 'Versão do Software básico inválida.' ;
           11 : MsgOcorrencia := 'Memória Fiscal foi desconectada.';
           12 : MsgOcorrencia := 'MFD foi desconectada' ;
           13 : MsgOcorrencia := 'Erro de gravação na Memória fiscal.' ;
           14 : MsgOcorrencia := 'Erro de gravação na MFD' ;
           15 : MsgOcorrencia := 'Erro na recuperação de dados da MF.' ;
           16 : MsgOcorrencia := 'Erro na recuperação de dados da MFD' ;
           17 : MsgOcorrencia := 'Checksum inválido no comando recebido pelo ECF.' ;
         end;
       end;

     10 :
       begin
         MsgCAT := 'Cheque/CMC-7';

         case Ocorrencia of
           01 : MsgOcorrencia := 'Documento não inserido' ;
         end;
       end;

     11 :
       begin
         MsgCAT := 'Autenticação';

         case Ocorrencia of
           01 : MsgOcorrencia := 'Excedida a quantidade permitida.' ;
           02 : MsgOcorrencia := 'Não permitida na condição' ;
         end;
       end;

     12 :
       begin
         MsgCAT := 'Sem Papel';
       end;

     13 :
       begin
         MsgCAT := 'Relógio';

         case Ocorrencia of
           01 : MsgOcorrencia := 'Qualquer alteração do relógio não permitida.' ;
           02 : MsgOcorrencia := 'Entrada ou saída de verão não permitida' ;
           03 : MsgOcorrencia := 'Relógio com data/hora anterior ao último documento gravado na MFD.' ;
           04 : MsgOcorrencia := 'Data/hora do relógio inválida' ;
         end;
       end;

     14 :
       begin
         MsgCAT := 'Programação';

         case Ocorrencia of
           01 : MsgOcorrencia := 'Índice de alíquota de ICMS já existente.' ;
           02 : MsgOcorrencia := 'Índice de alíquota de ISSQN já existente  ' ;
           03 : MsgOcorrencia := 'Índice de ISSQN não permitido.' ;
           04 : MsgOcorrencia := 'Índice de Meio de pagamento já existente' ;
           05 : MsgOcorrencia := 'Índice de Não Fiscal já existente.' ;
           06 : MsgOcorrencia := 'Índice de relatório gerencial já existente' ;
           07 : MsgOcorrencia := 'Excedida a quantidade máxima' ;
         end;
       end;

     15 :
       begin
         MsgCAT := 'Protocolo';

         case Ocorrencia of
           01 : MsgOcorrencia := 'Caractere de controle inválido no comando recebido pelo ECF.' ;
           02 : MsgOcorrencia := 'Checksum inválido no comando recebido pelo ECF' ;
         end;
       end;

     16 :
       begin
         MsgCAT := 'Erro específico do Fabricante';
       end;

   end;

   Result := IntToStr(CAT)+'-'+IntToStr(Ocorrencia) + ' - ' + MsgCAT ;
   if MsgOcorrencia <> '' then
      Result := Result + sLineBreak + MsgOcorrencia;
end;

function TACBrECFEscECF.RetornaInfoECF(Registrador: String): AnsiString;
begin
  if Pos('|',Registrador) = 0 then
     Registrador := Registrador + '|' ;

  EscECFComando.CMD := 26;
  EscECFComando.AddParamString(Registrador);
  EnviaComando;

  Result := EscECFResposta.BRS;
  if (RightStr(Result,1) = '|') then
     Delete( Result, Length(Result), 1 );
end;

function TACBrECFEscECF.GetDataHora: TDateTime;
Var
  RetCmd : String ;
begin
  RetCmd := RetornaInfoECF( '9' ) ;

  Result := EncodeDateTime( StrToInt(copy(RetCmd,5,4)),  // Ano
                            StrToInt(copy(RetCmd,3,2)),  // Mes
                            StrToInt(copy(RetCmd,1,2)),  // Dia
                            StrToInt(copy(RetCmd,9,2)),  // Hora
                            StrToInt(copy(RetCmd,11,2)), // Minuto
                            StrToInt(copy(RetCmd,13,2)), // Segundo
                            0 ) ;
end;

function TACBrECFEscECF.GetNumCupom: String;
begin
  RetornaInfoECF( '1|1' ) ;
  Result := EscECFResposta.Params[1] ;
end;

function TACBrECFEscECF.GetNumECF: String;
begin
  Result := fsNumECF ;
end;

function TACBrECFEscECF.GetNumCRO: String;
begin
  if Trim(fsNumCRO) = '' then
  begin
    RetornaInfoECF( '1|3' ) ;
    Result := EscECFResposta.Params[1] ;
  end ;

  Result := fsNumCRO ;
end;

function TACBrECFEscECF.GetNumSerie: String;
begin
  Result := RetornaInfoECF( '15|4' ) ;
end;

function TACBrECFEscECF.GetNumVersao: String ;
begin
  Result := fsNumVersao ;
end;

function TACBrECFEscECF.GetTotalPago: Double;
begin
  Result := 0 ;   // TODO: Como fazer para Ler o SubTotal ?
end;

function TACBrECFEscECF.GetNumReducoesZRestantes: String;
begin
  RetornaInfoECF( '1|15' ) ;
  Result := EscECFResposta.Params[1] ;
end;

function TACBrECFEscECF.GetSubTotal: Double;
begin
  Result := 0 ;  // TODO: Como fazer para Ler o SubTotal ?
end;

function TACBrECFEscECF.GetEstado: TACBrECFEstado;
Var
  FlagEst : Integer ;
begin
  Result := fpEstado;
  try
     if (not fpAtivo) then
        fpEstado := estNaoInicializada
     else
      begin
        fpEstado := estDesconhecido ;

        FlagEst := StrToInt( RetornaInfoECF( '16|4' ) );
        if FlagEst = 3 then
           fpEstado := estBloqueada
        else if fsEmPagamento then
           fpEstado := estPagamento 
        else
         begin
           FlagEst := StrToInt( RetornaInfoECF( '16|5' ) );
           Case FlagEst of
             0  :             fpEstado := estLivre;
             10 :             fpEstado := estVenda;
             11..13, 21..23 : fpEstado := estPagamento;
             20 :             fpEstado := estNaoFiscal;
             30..32 :         fpEstado := estRelatorio;
           end;
         end;

        if fpEstado in [estLivre, estBloqueada] then
        begin
           RetornaInfoECF( '8' ) ;
           FlagEst := StrToInt( EscECFResposta.Params[1] );

           if FlagEst = 2 then
              fpEstado := estRequerZ;
        end;
      end ;
  finally
     Result := fpEstado ;
  end;
end;

function TACBrECFEscECF.GetGavetaAberta: Boolean;
begin
  Result := RetornaInfoECF( '16|1' ) = '1' ;
end;

function TACBrECFEscECF.GetPoucoPapel: Boolean;
begin
  Result := RetornaInfoECF( '16|2' ) > '0' ;
end;

function TACBrECFEscECF.GetHorarioVerao: Boolean;
begin
  Result := UpperCase(RightStr( RetornaInfoECF( '9' ) ,1 )) =  'V' ;
end;

Procedure TACBrECFEscECF.LeituraX ;
begin
  EscECFComando.CMD := 20;
  EscECFComando.AddParamInteger(0); // Imprime no ECF
  EnviaComando;
end;

procedure TACBrECFEscECF.LeituraXSerial(Linhas: TStringList);
begin
   inherited LeituraXSerial(Linhas);
end;

Procedure TACBrECFEscECF.AbreGaveta ;
begin
  EscECFComando.CMD := 6;
  EnviaComando;
end;

Procedure TACBrECFEscECF.ReducaoZ(DataHora: TDateTime) ;
begin
  if DataHora = 0 then  { Aparentemente a DataHora é obrigatória na EscECF }
     DataHora := now ;

  EscECFComando.CMD := 21;
  EscECFComando.AddParamDateTime(DataHora, 'D' );
  EscECFComando.AddParamDateTime(DataHora, 'H' );
  EscECFComando.AddParamInteger(0); // Imprime no ECF

  try
     EnviaComando ;
  except
     on E : Exception do
     begin
        if (pos('999-999',E.Message) <> 0) then     // TODO: Erro de Hora fora da faixa ?  
           ReducaoZ(0)                              // Tenta sem DataHora
        else if (pos('5-1',E.Message) <> 0) then    // Comando inválido para o documento atual.
         begin                                      //  Ficou algum Cupom aberto ?
           CancelaCupom ;
           ReducaoZ(DataHora);
         end 
        else
           raise ;
     end ;
  end ;
  
end;

procedure TACBrECFEscECF.RelatorioGerencial(Relatorio: TStrings; Vias: Integer;
   Indice: Integer);
begin

end;

procedure TACBrECFEscECF.AbreRelatorioGerencial(Indice: Integer);
begin
   inherited AbreRelatorioGerencial(Indice);
end;

procedure TACBrECFEscECF.LinhaRelatorioGerencial(Linha: AnsiString;
   IndiceBMP: Integer);
begin
   inherited LinhaRelatorioGerencial(Linha, IndiceBMP);
end;

procedure TACBrECFEscECF.CupomVinculado(COO, CodFormaPagto,
   CodComprovanteNaoFiscal: String; Valor: Double; Relatorio: TStrings;
   Vias: Integer);
begin

end;

procedure TACBrECFEscECF.AbreCupomVinculado(COO, CodFormaPagto,
   CodComprovanteNaoFiscal: String; Valor: Double);
begin
   inherited AbreCupomVinculado(COO, CodFormaPagto, CodComprovanteNaoFiscal,
      Valor);
end;

Procedure TACBrECFEscECF.MudaHorarioVerao ;
begin
  MudaHorarioVerao( not HorarioVerao) ;
end;

procedure TACBrECFEscECF.MudaHorarioVerao(EHorarioVerao: Boolean);
begin
  EscECFComando.CMD := 80;
  EscECFComando.AddParamInteger( IfThen(EHorarioVerao,1,0) );
  EnviaComando;
end;

procedure TACBrECFEscECF.MudaArredondamento(Arredondar: Boolean);
begin
   inherited MudaArredondamento(Arredondar);
end;

procedure TACBrECFEscECF.PreparaTEF;
begin
   inherited PreparaTEF;
end;

procedure TACBrECFEscECF.CorrigeEstadoErro(Reducao: Boolean);
begin
   inherited CorrigeEstadoErro(Reducao);
end;

procedure TACBrECFEscECF.ImpactoAgulhas(NivelForca: Integer);
begin
   inherited ImpactoAgulhas(NivelForca);
end;

procedure TACBrECFEscECF.LeituraMemoriaFiscal(DataInicial,
   DataFinal: TDateTime; Simplificada: Boolean);
begin
   inherited LeituraMemoriaFiscal(DataInicial, DataFinal, Simplificada);
end;

procedure TACBrECFEscECF.LeituraMemoriaFiscal(ReducaoInicial,
   ReducaoFinal: Integer; Simplificada: Boolean);
begin
   inherited LeituraMemoriaFiscal(ReducaoInicial, ReducaoFinal, Simplificada);
end;

procedure TACBrECFEscECF.LeituraMemoriaFiscalSerial(DataInicial,
   DataFinal: TDateTime; Linhas: TStringList; Simplificada: Boolean);
begin
   inherited LeituraMemoriaFiscalSerial(DataInicial, DataFinal, Linhas,
      Simplificada);
end;

procedure TACBrECFEscECF.LeituraMemoriaFiscalSerial(ReducaoInicial,
   ReducaoFinal: Integer; Linhas: TStringList; Simplificada: Boolean);
begin
   inherited LeituraMemoriaFiscalSerial(ReducaoInicial, ReducaoFinal, Linhas,
      Simplificada);
end;

procedure TACBrECFEscECF.LeituraMFDSerial(DataInicial, DataFinal: TDateTime;
   Linhas: TStringList; Documentos: TACBrECFTipoDocumentoSet);
begin
   inherited LeituraMFDSerial(DataInicial, DataFinal, Linhas, Documentos);
end;

procedure TACBrECFEscECF.LeituraMFDSerial(COOInicial, COOFinal: Integer;
   Linhas: TStringList; Documentos: TACBrECFTipoDocumentoSet);
begin
   inherited LeituraMFDSerial(COOInicial, COOFinal, Linhas, Documentos);
end;

procedure TACBrECFEscECF.EspelhoMFD_DLL(DataInicial, DataFinal: TDateTime;
   NomeArquivo: AnsiString; Documentos: TACBrECFTipoDocumentoSet);
begin
   inherited EspelhoMFD_DLL(DataInicial, DataFinal, NomeArquivo, Documentos);
end;

procedure TACBrECFEscECF.EspelhoMFD_DLL(COOInicial, COOFinal: Integer;
   NomeArquivo: AnsiString; Documentos: TACBrECFTipoDocumentoSet);
begin
   inherited EspelhoMFD_DLL(COOInicial, COOFinal, NomeArquivo, Documentos);
end;

procedure TACBrECFEscECF.ArquivoMFD_DLL(DataInicial, DataFinal: TDateTime;
   NomeArquivo: AnsiString; Documentos: TACBrECFTipoDocumentoSet;
   Finalidade: TACBrECFFinalizaArqMFD);
begin
   inherited ArquivoMFD_DLL(DataInicial, DataFinal, NomeArquivo, Documentos,
      Finalidade);
end;

procedure TACBrECFEscECF.ArquivoMFD_DLL(ContInicial, ContFinal: Integer;
   NomeArquivo: AnsiString; Documentos: TACBrECFTipoDocumentoSet;
   Finalidade: TACBrECFFinalizaArqMFD; TipoContador: TACBrECFTipoContador);
begin
   inherited ArquivoMFD_DLL(ContInicial, ContFinal, NomeArquivo, Documentos,
      Finalidade, TipoContador);
end;

procedure TACBrECFEscECF.PafMF_GerarCAT52(const DataInicial,
   DataFinal: TDateTime; const DirArquivos: String);
begin
   inherited PafMF_GerarCAT52(DataInicial, DataFinal, DirArquivos);
end;

procedure TACBrECFEscECF.IdentificaOperador(Nome: String);
begin
   inherited IdentificaOperador(Nome);
end;

procedure TACBrECFEscECF.IdentificaPAF(NomeVersao, MD5: String);
begin
   inherited IdentificaPAF(NomeVersao, MD5);
end;

procedure TACBrECFEscECF.AbreCupom ;
begin
  EscECFComando.CMD := 1;
  EscECFComando.AddParamString(LeftStr(OnlyNumber(Consumidor.Documento),14)) ;
  EscECFComando.AddParamString(LeftStr(Consumidor.Nome,30)) ;
  EscECFComando.AddParamString(LeftStr(Consumidor.Endereco,79)) ;
  EnviaComando;

  RespostasComando.AddField( 'COO',        EscECFResposta.Params[0] );
  RespostasComando.AddField( 'DataHora',   EscECFResposta.Params[1] );
  RespostasComando.AddField( 'VendaBruta', EscECFResposta.Params[2] );
  RespostasComando.AddField( 'NumSerie',   EscECFResposta.Params[3] );

  Consumidor.Enviado := True ;
  fsEmPagamento := false ;
end;

procedure TACBrECFEscECF.VendeItem(Codigo, Descricao: String;
   AliquotaECF: String; Qtd: Double; ValorUnitario: Double;
   ValorDescontoAcrescimo: Double; Unidade: String;
   TipoDescontoAcrescimo: String; DescontoAcrescimo: String;
   CodDepartamento: Integer);
begin
  with EscECFComando do
  begin
     CMD := 2 ;
     AddParamString( LeftStr(Codigo,14) );
     AddParamString( LeftStr(Descricao,233) );
     AddParamString( AliquotaECF );
     AddParamString( Trim(LeftStr( OnlyAlphaNum(Unidade),3)) );
     AddParamDouble( Qtd, fpDecimaisQtd );
     AddParamInteger( fpDecimaisQtd );
     AddParamDouble( ValorUnitario, fpDecimaisPreco );
     AddParamInteger( fpDecimaisPreco );
     AddParamString( ifthen(ArredondaItemMFD,'A','T') );
  end ;

  EnviaComando ;

  RespostasComando.AddField( 'NumUltItem', EscECFResposta.Params[0] );
  RespostasComando.AddField( 'TotalItem',  EscECFResposta.Params[1] );
  RespostasComando.AddField( 'SubTotal',   EscECFResposta.Params[2] );
  fsEmPagamento := false ;

  { Se o desconto é maior que zero dá o comando de desconto de item }
  if ValorDescontoAcrescimo > 0 then
     DescontoAcrescimoItemAnterior( ValorDescontoAcrescimo, DescontoAcrescimo,
        TipoDescontoAcrescimo);
end;

procedure TACBrECFEscECF.DescontoAcrescimoItemAnterior(
   ValorDescontoAcrescimo: Double; DescontoAcrescimo: String;
   TipoDescontoAcrescimo: String; NumItem: Integer);
begin
  with EscECFComando do
  begin
     CMD := 27 ;
     AddParamInteger( ifthen(DescontoAcrescimo    ='D',0,1) );
     AddParamInteger( ifthen(TipoDescontoAcrescimo='%',0,1) );
     if NumItem > 0 then
        AddParamInteger( NumItem )
     else
        AddParamString( '' ) ;
  end ;

  EnviaComando ;

  RespostasComando.AddField( 'TotalItem',  EscECFResposta.Params[0] );
  RespostasComando.AddField( 'SubTotal',   EscECFResposta.Params[1] );
end;

procedure TACBrECFEscECF.CancelaCupom;
var
   UltimoCOO: Integer;
   Est: TACBrECFEstado;
begin
  Est := TACBrECF( fpOwner ).Estado;

  case Est of
    estRelatorio : FechaRelatorio ;

    estVenda, estPagamento :
      begin
        EscECFComando.CMD := 31;
        EnviaComando;
      end;
  else
    begin
      UltimoCOO := StrToInt( TACBrECF( fpOwner ).NumCOO );
      EscECFComando.CMD := 7;
      EscECFComando.AddParamInteger( UltimoCOO );
      EnviaComando;
    end;
  end;

  fsEmPagamento := false ;
end;

procedure TACBrECFEscECF.CancelaItemVendido(NumItem: Integer);
begin
  EscECFComando.CMD := 3;
  EscECFComando.AddParamInteger( NumItem );
  EnviaComando;

  RespostasComando.AddField( 'SubTotal',   EscECFResposta.Params[0] );
end;

procedure TACBrECFEscECF.CancelaDescontoAcrescimoItem(NumItem: Integer);
begin
  with EscECFComando do
  begin
     CMD := 28 ;
     AddParamInteger( 0 );
     AddParamInteger( NumItem )
  end ;

  EnviaComando ;

  RespostasComando.AddField( 'TotalItem',  EscECFResposta.Params[0] );
  RespostasComando.AddField( 'SubTotal',   EscECFResposta.Params[1] );
end;

procedure TACBrECFEscECF.NaoFiscalCompleto(CodCNF: String; Valor: Double;
   CodFormaPagto: String; Obs: AnsiString; IndiceBMP: Integer);
begin
   inherited NaoFiscalCompleto(CodCNF, Valor, CodFormaPagto, Obs, IndiceBMP);
end;

procedure TACBrECFEscECF.AbreNaoFiscal(CPF_CNPJ: String; Nome: String;
   Endereco: String);
begin
   inherited AbreNaoFiscal(CPF_CNPJ, Nome, Endereco);
end;

procedure TACBrECFEscECF.RegistraItemNaoFiscal(CodCNF: String; Valor: Double;
   Obs: AnsiString);
begin
   inherited RegistraItemNaoFiscal(CodCNF, Valor, Obs);
end;

procedure TACBrECFEscECF.SubtotalizaNaoFiscal(DescontoAcrescimo: Double;
   MensagemRodape: AnsiString);
begin
   inherited SubtotalizaNaoFiscal(DescontoAcrescimo, MensagemRodape);
end;

procedure TACBrECFEscECF.EfetuaPagamento(CodFormaPagto: String;
  Valor: Double; Observacao: AnsiString; ImprimeVinculado: Boolean);
begin
  with EscECFComando do
  begin
     CMD := 4 ;
     AddParamString( CodFormaPagto );
     AddParamDouble( Valor );
     AddParamInteger( 1 );  // Parcelas ??
     AddParamString( LeftStr(Observacao, 84) );
     AddParamInteger( 7 );  // Meios de pagamento ??
     { 1-Dinheiro, 2-Cheque, 3-Cartão de Crédito, 4-Cartão de Débito,
       5-Cartão Refeição/Alimentação, 6-Vale Refeição/Alimentação (em papel),
       7-Outros }
  end ;

  EnviaComando ;

  RespostasComando.AddField( 'TotalAPagar', EscECFResposta.Params[0] );
end;

procedure TACBrECFEscECF.EstornaPagamento(const CodFormaPagtoEstornar,
   CodFormaPagtoEfetivar: String; const Valor: Double; Observacao: AnsiString);
begin
  with EscECFComando do
  begin
     CMD := 19 ;
     AddParamString( CodFormaPagtoEstornar );
     AddParamString( CodFormaPagtoEfetivar );
     AddParamDouble( Valor );
     AddParamInteger( 1 );  // Parcelas ??
     AddParamString( LeftStr(Observacao, 84) );
  end ;

  EnviaComando ;

  RespostasComando.AddField( 'COO',        EscECFResposta.Params[0] );
  RespostasComando.AddField( 'DataHora',   EscECFResposta.Params[1] );
  RespostasComando.AddField( 'VendaBruta', EscECFResposta.Params[2] );
  RespostasComando.AddField( 'NumSerie',   EscECFResposta.Params[3] );
end;

procedure TACBrECFEscECF.FechaCupom(Observacao: AnsiString; IndiceBMP: Integer);
begin
  with EscECFComando do
  begin
     CMD := 5 ;
     AddParamInteger( 0 );  // Sem Cupom Adicional
     AddParamInteger( 1 );  // Aciona a Guilhotina
     AddParamString( Observacao );
  end ;

  EnviaComando ;

  RespostasComando.AddField( 'COO',        EscECFResposta.Params[0] );
  RespostasComando.AddField( 'DataHora',   EscECFResposta.Params[1] );
  RespostasComando.AddField( 'VendaBruta', EscECFResposta.Params[2] );
  fsEmPagamento := false ;
end;

procedure TACBrECFEscECF.SubtotalizaCupom(DescontoAcrescimo: Double;
       MensagemRodape : AnsiString );
begin
  fsEmPagamento := True ;
  if DescontoAcrescimo = 0 then exit ;
  
  with EscECFComando do
  begin
     CMD := 29 ;
     AddParamInteger( ifthen(DescontoAcrescimo < 0,0,1) );
     AddParamInteger( 1 );
     AddParamDouble( abs(DescontoAcrescimo) );
  end ;

  EnviaComando ;

  RespostasComando.AddField( 'SubTotal', EscECFResposta.Params[0] );
end;

procedure TACBrECFEscECF.CancelaDescontoAcrescimoSubTotal(
   TipoAcrescimoDesconto: Char);
begin
  with EscECFComando do
  begin
     CMD := 30 ;
     AddParamInteger( ifthen(TipoAcrescimoDesconto = 'D',0,1) );
  end ;

  EnviaComando ;

  RespostasComando.AddField( 'SubTotal', EscECFResposta.Params[0] );
end;


procedure TACBrECFEscECF.CarregaAliquotas;
Var
  I, N :Integer ;
  Aliquota: TACBrECFAliquota;
begin
  RetornaInfoECF( '5' );

  inherited CarregaAliquotas;

  try
     N := Trunc(EscECFResposta.Params.Count / 4) - 1;
     For I := 0 to N do
     begin
       Aliquota := TACBrECFAliquota.create;
       Aliquota.Sequencia := I;
       Aliquota.Tipo      := EscECFResposta.Params[ 4*I + 1 ][1] ;
       { Adiciona o tipo no Indice, pois no comando de Venda de Item ele será necessario }
       Aliquota.Indice    := Aliquota.Tipo + EscECFResposta.Params[ 4*I ] ;
       Aliquota.Aliquota  := StrToInt( OnlyNumber(EscECFResposta.Params[ 4*I + 2 ]) ) / 100 ;
       Aliquota.Total     := StrToInt( EscECFResposta.Params[ 4*I + 3 ] ) / 100 ;

       fpAliquotas.Add(Aliquota);
     end;
  except
     fpAliquotas.Free ;
     fpAliquotas := nil ;
     raise ;
  end;
end;

procedure TACBrECFEscECF.ProgramaAliquota(Aliquota: Double; Tipo: Char;
   Posicao : String );
var
   PosAliq: Integer;
begin
  if not Assigned( fpAliquotas ) then
     CarregaAliquotas ;

  EscECFComando.CMD := 81;
  if Posicao = '' then
     PosAliq := Aliquotas.Count + 1
  else
     PosAliq := StrToInt( Posicao );
  EscECFComando.AddParamInteger( PosAliq ) ;
  EscECFComando.AddParamString( Tipo ) ;
  EscECFComando.AddParamString( IntToStrZero( Trunc(Aliquota*100), 4 ) ) ;
  EnviaComando;

  CarregaAliquotas;
end;

procedure TACBrECFEscECF.CarregaFormasPagamento;
Var
  I, N :Integer ;
  FPG: TACBrECFFormaPagamento;
begin
  RetornaInfoECF( '14' );

  inherited CarregaFormasPagamento;

  try
     N := Trunc(EscECFResposta.Params.Count / 3) - 1;
     For I := 0 to N do
     begin
       FPG := TACBrECFFormaPagamento.create;
       FPG.Indice           := EscECFResposta.Params[ 3*I ] ;
       FPG.Descricao        := EscECFResposta.Params[ 3*I + 1 ] ;
       FPG.PermiteVinculado := (EscECFResposta.Params[ 3*I + 2 ] = '1') ;

       fpFormasPagamentos.Add(FPG);
     end;
  except
     fpFormasPagamentos.Free ;
     fpFormasPagamentos := nil ;
     raise ;
  end;
end;

procedure TACBrECFEscECF.LerTotaisFormaPagamento;
Var
  I, N :Integer ;
  FPG: TACBrECFFormaPagamento;
begin
  if not Assigned( fpFormasPagamentos ) then
     CarregaFormasPagamento ;

  RetornaInfoECF( '7' );

  N := Trunc(EscECFResposta.Params.Count / 2) - 1;
  For I := 0 to N do
  begin
    FPG := AchaFPGIndice( EscECFResposta.Params[ 2*I ] ) ;
    if Assigned( FPG ) then
       FPG.Total := StrToInt( EscECFResposta.Params[ 2*I + 1 ] ) / 100;
  end;
end;

procedure TACBrECFEscECF.ProgramaFormaPagamento(var Descricao: String;
  PermiteVinculado: Boolean; Posicao : String);
var
   PosFPG : Integer;
begin
  if not Assigned( fpFormasPagamentos ) then
     CarregaFormasPagamento ;

  Descricao := LeftStr(TiraAcentos( DecodificarPaginaDeCodigoECF(Descricao) ),15) ;

  EscECFComando.CMD := 84;
  if Posicao = '' then
     PosFPG := FormasPagamento.Count + 1
  else
     PosFPG := StrToInt( Posicao );
  EscECFComando.AddParamInteger( PosFPG ) ;
  EscECFComando.AddParamString( Descricao ) ;
  EscECFComando.AddParamInteger( ifthen(PermiteVinculado,1,0) ) ;
  EnviaComando;

  CarregaFormasPagamento;
end;

procedure TACBrECFEscECF.CarregaRelatoriosGerenciais;
Var
  I, N :Integer ;
  RelGer: TACBrECFRelatorioGerencial;
begin
  RetornaInfoECF( '13' );

  inherited CarregaRelatoriosGerenciais;

  try
     N := Trunc(EscECFResposta.Params.Count / 2) - 1;
     For I := 0 to N do
     begin
       RelGer := TACBrECFRelatorioGerencial.create;
       RelGer.Indice    := EscECFResposta.Params[ 2*I ] ;
       RelGer.Descricao := EscECFResposta.Params[ 2*I + 1 ] ;

       fpRelatoriosGerenciais.Add(RelGer);
     end;
  except
     fpRelatoriosGerenciais.Free ;
     fpRelatoriosGerenciais := nil ;
     raise ;
  end;
end;

procedure TACBrECFEscECF.LerTotaisRelatoriosGerenciais;
Var
  I, N :Integer ;
  RelGer : TACBrECFRelatorioGerencial;
begin
  if not Assigned( fpRelatoriosGerenciais ) then
     CarregaRelatoriosGerenciais ;

  RetornaInfoECF( '2' );

  N := Trunc(EscECFResposta.Params.Count / 2) - 1;
  For I := 0 to N do
  begin
    RelGer := AchaRGIndice( EscECFResposta.Params[ 2*I ] ) ;
    if Assigned( RelGer ) then
       RelGer.Contador := StrToInt( EscECFResposta.Params[ 2*I + 1 ] ) ;
  end;
end;

procedure TACBrECFEscECF.ProgramaRelatorioGerencial(var Descricao: String;
   Posicao: String);
var
   PosRel : Integer;
begin
  if not Assigned( fpRelatoriosGerenciais ) then
     CarregaRelatoriosGerenciais ;

  Descricao := LeftStr(TiraAcentos( DecodificarPaginaDeCodigoECF(Descricao) ),15) ;

  EscECFComando.CMD := 86;
  if Posicao = '' then
     PosRel := RelatoriosGerenciais.Count + 1
  else
     PosRel := StrToInt( Posicao );
  EscECFComando.AddParamInteger( PosRel ) ;
  EscECFComando.AddParamString( Descricao ) ;
  EnviaComando;

  CarregaRelatoriosGerenciais;
end;

procedure TACBrECFEscECF.CarregaComprovantesNaoFiscais;
Var
  I, N :Integer ;
  CNF : TACBrECFComprovanteNaoFiscal;
begin
  RetornaInfoECF( '12' );

  inherited CarregaComprovantesNaoFiscais;

  try
     N := Trunc(EscECFResposta.Params.Count / 2) - 1;
     For I := 0 to N do
     begin
       CNF := TACBrECFComprovanteNaoFiscal.create;
       CNF.Indice    := EscECFResposta.Params[ 2*I ] ;
       CNF.Descricao := EscECFResposta.Params[ 2*I + 1 ] ;

       fpComprovantesNaoFiscais.Add(CNF);
     end;
  except
     fpComprovantesNaoFiscais.Free ;
     fpComprovantesNaoFiscais := nil ;
     raise ;
  end;
end;

procedure TACBrECFEscECF.LerTotaisComprovanteNaoFiscal;
Var
  I, N :Integer ;
  CNF : TACBrECFComprovanteNaoFiscal;
begin
  if not Assigned( fpComprovantesNaoFiscais ) then
     CarregaComprovantesNaoFiscais ;

  RetornaInfoECF( '3' );

  N := Trunc(EscECFResposta.Params.Count / 3) - 1;
  For I := 0 to N do
  begin
    CNF := AchaCNFIndice( EscECFResposta.Params[ 3*I ] ) ;
    if Assigned( CNF ) then
    begin
       CNF.Contador := StrToInt( EscECFResposta.Params[ 3*I + 1 ] ) ;
       CNF.Total    := StrToInt( EscECFResposta.Params[ 3*I + 1 ] ) / 100 ;
    end;
  end;
end;

procedure TACBrECFEscECF.ProgramaComprovanteNaoFiscal(var Descricao: String;
  Tipo: String; Posicao : String );
var
   PosCNF : Integer;
begin
  if not Assigned( fpComprovantesNaoFiscais ) then
     CarregaComprovantesNaoFiscais ;

  Descricao := LeftStr(TiraAcentos( DecodificarPaginaDeCodigoECF(Descricao) ),15) ;
  if (Tipo = '-') then
     Tipo := 'S'
  else
     Tipo := 'E' ;

  EscECFComando.CMD := 85;
  if Posicao = '' then
     PosCNF := ComprovantesNaoFiscais.Count + 1
  else
     PosCNF := StrToInt( Posicao );
  EscECFComando.AddParamInteger( PosCNF ) ;
  EscECFComando.AddParamString( Descricao ) ;
  EscECFComando.AddParamString( Tipo ) ;
  EnviaComando;

  CarregaComprovantesNaoFiscais;
end;

procedure TACBrECFEscECF.LinhaCupomVinculado(Linha: AnsiString);
begin
end;

procedure TACBrECFEscECF.SegundaViaVinculado;
begin
   inherited SegundaViaVinculado;
end;

procedure TACBrECFEscECF.ReimpressaoVinculado;
begin
   inherited ReimpressaoVinculado;
end;

procedure TACBrECFEscECF.FechaRelatorio;
begin
end;

procedure TACBrECFEscECF.PulaLinhas(NumLinhas: Integer);
begin
   inherited PulaLinhas(NumLinhas);
end;

procedure TACBrECFEscECF.CortaPapel(const CorteParcial: Boolean);
begin
   inherited CortaPapel(CorteParcial);
end;

procedure TACBrECFEscECF.ImprimeCheque(Banco: String; Valor: Double;
   Favorecido, Cidade: String; Data: TDateTime; Observacao: String);
begin
   inherited ImprimeCheque(Banco, Valor, Favorecido, Cidade, Data, Observacao);
end;

procedure TACBrECFEscECF.CancelaImpressaoCheque;
begin
   inherited CancelaImpressaoCheque;
end;

function TACBrECFEscECF.LeituraCMC7: AnsiString;
begin
   Result:=inherited LeituraCMC7;
end;

function TACBrECFEscECF.GetNumCRZ: String;
begin
  RetornaInfoECF( '1|4' ) ;
  Result := EscECFResposta.Params[1] ;
end;

function TACBrECFEscECF.GetNumCFD: String;
begin
  RetornaInfoECF( '1|7' ) ;
  Result := EscECFResposta.Params[1] ;
end;

function TACBrECFEscECF.GetNumNCN: String;
begin
  RetornaInfoECF( '1|14' ) ;
  Result := EscECFResposta.Params[1] ;
end;

function TACBrECFEscECF.GetGrandeTotal: Double;
var
   StrValue: String;
begin
  RetornaInfoECF( '4|1' ) ;
  StrValue := EscECFResposta.Params[1] ;
  Result   := StrToInt( StrValue ) / 100;
end;

function TACBrECFEscECF.GetNumCCF: String;
begin
  RetornaInfoECF( '1|5' ) ;
  Result := EscECFResposta.Params[1] ;
end;

function TACBrECFEscECF.GetNumGNF: String;
begin
  RetornaInfoECF( '1|2' ) ;
  Result := EscECFResposta.Params[1] ;
end;

function TACBrECFEscECF.GetNumGRG: String;
begin
  RetornaInfoECF( '1|9' ) ;
  Result := EscECFResposta.Params[1] ;
end;

function TACBrECFEscECF.GetNumCDC: String;
begin
  RetornaInfoECF( '1|8' ) ;
  Result := EscECFResposta.Params[1] ;
end;

function TACBrECFEscECF.GetNumCFC: String;
begin
  RetornaInfoECF( '1|11' ) ;
  Result := EscECFResposta.Params[1] ;
end;

function TACBrECFEscECF.GetNumGNFC: String;
begin
  RetornaInfoECF( '1|10' ) ;
  Result := EscECFResposta.Params[1] ;
end;

function TACBrECFEscECF.GetNumCOOInicial: String;
begin
  RetornaInfoECF( '8' ) ;
  Result := EscECFResposta.Params[2] ;
end;

function TACBrECFEscECF.GetVendaBruta: Double;
var
   StrValue: String;
begin
  RetornaInfoECF( '4|2' ) ;
  StrValue := EscECFResposta.Params[1] ;
  Result   := StrToInt( StrValue ) / 100;
end;

procedure TACBrECFEscECF.EfetuaPagamentoNaoFiscal(CodFormaPagto: String;
  Valor: Double; Observacao: AnsiString; ImprimeVinculado: Boolean);
begin
end;

procedure TACBrECFEscECF.FechaNaoFiscal(Observacao: AnsiString;
   IndiceBMP: Integer);
begin
   inherited FechaNaoFiscal(Observacao, IndiceBMP);
end;

procedure TACBrECFEscECF.CancelaNaoFiscal;
begin
end;

procedure TACBrECFEscECF.CancelaItemNaoFiscal(const AItem: Integer);
begin
   inherited CancelaItemNaoFiscal(AItem);
end;

procedure TACBrECFEscECF.Sangria(const Valor: Double; Obs: AnsiString;
   DescricaoCNF: String; DescricaoFPG: String; IndiceBMP: Integer);
begin
   inherited Sangria(Valor, Obs, DescricaoCNF, DescricaoFPG, IndiceBMP);
end;

procedure TACBrECFEscECF.Suprimento(const Valor: Double; Obs: AnsiString;
   DescricaoCNF: String; DescricaoFPG: String; IndiceBMP: Integer);
begin
   inherited Suprimento(Valor, Obs, DescricaoCNF, DescricaoFPG, IndiceBMP);
end;

function TACBrECFEscECF.EstornaCCD(const Todos: Boolean): Integer;
begin
   Result:=inherited EstornaCCD(Todos);
end;

function TACBrECFEscECF.GetTotalAcrescimos: Double;
var
   StrValue: String;
begin
  RetornaInfoECF( '4|8' ) ;
  StrValue := EscECFResposta.Params[1] ;
  Result   := StrToInt( StrValue ) / 100;
end;

function TACBrECFEscECF.GetTotalCancelamentos: Double;
var
   StrValue: String;
begin
  RetornaInfoECF( '4|3' ) ;
  StrValue := EscECFResposta.Params[1] ;
  Result   := StrToInt( StrValue ) / 100;
end;

function TACBrECFEscECF.GetTotalDescontos: Double;
var
   StrValue: String;
begin
  RetornaInfoECF( '4|4' ) ;
  StrValue := EscECFResposta.Params[1] ;
  Result   := StrToInt( StrValue ) / 100;
end;

function TACBrECFEscECF.GetTotalTroco: Double;
var
   StrValue: String;
begin
  RetornaInfoECF( '7|21' ) ;
  StrValue := EscECFResposta.Params[1] ;
  Result   := StrToInt( StrValue ) / 100;
end;

function TACBrECFEscECF.GetTotalIsencao: Double;
  Function GetTotalIsencaoN( Indice: Integer) : Double;
  var
     StrValue: String;
  begin
    RetornaInfoECF( '6|'+IntToStr(Indice) ) ;
    StrValue := EscECFResposta.Params[4] ;
    Result   := StrToInt( StrValue ) / 100;
  end;
begin
  Result := GetTotalIsencaoN( 1 ) +
            GetTotalIsencaoN( 2 ) +
            GetTotalIsencaoN( 3 ) ;
end;

function TACBrECFEscECF.GetTotalNaoTributado: Double;
  Function GetTotalNaoTributadoN( Indice: Integer) : Double;
  var
     StrValue: String;
  begin
    RetornaInfoECF( '6|'+IntToStr(Indice) ) ;
    StrValue := EscECFResposta.Params[6] ;
    Result   := StrToInt( StrValue ) / 100;
  end;
begin
  Result := GetTotalNaoTributadoN( 1 ) +
            GetTotalNaoTributadoN( 2 ) +
            GetTotalNaoTributadoN( 3 ) ;
end;

function TACBrECFEscECF.GetTotalSubstituicaoTributaria: Double;
  Function GetTotalSubstituicaoTributariaN( Indice: Integer) : Double;
  var
     StrValue: String;
  begin
    RetornaInfoECF( '6|'+IntToStr(Indice) ) ;
    StrValue := EscECFResposta.Params[1] ;
    Result   := StrToInt( StrValue ) / 100;
  end;
begin
  Result := GetTotalSubstituicaoTributariaN( 1 ) +
            GetTotalSubstituicaoTributariaN( 2 ) +
            GetTotalSubstituicaoTributariaN( 3 ) ;
end;

function TACBrECFEscECF.GetCNPJ: String;
begin
  Result := RetornaInfoECF( '15|8' ) ;
end;

function TACBrECFEscECF.GetIE: String;
begin
  Result := RetornaInfoECF( '15|9' ) ;
end;

function TACBrECFEscECF.GetIM: String;
begin
  Result := RetornaInfoECF( '15|10' ) ;
end;

function TACBrECFEscECF.GetCliche: AnsiString;
begin
  Result := RetornaInfoECF( '15|15' ) + sLineBreak +  // Razao Social
            RetornaInfoECF( '15|16' ) + sLineBreak +  // Nome Fantasia
            RetornaInfoECF( '15|17' ) ;               // Endereço
end;

function TACBrECFEscECF.GetSubModeloECF: String;
begin
   Result := fsModeloECF;
end;

function TACBrECFEscECF.GetDataMovimento: TDateTime;
var
   DataStr: String;
begin
  RetornaInfoECF( '8' ) ;
  DataStr := EscECFComando.Params[0];

  Result := EncodeDate( StrToInt(copy(DataStr,5,4)),   // Ano
                        StrToInt(copy(DataStr,3,2)),   // Mes
                        StrToInt(copy(DataStr,1,2)) ); // Dia

end;

procedure TACBrECFEscECF.LerTotaisAliquota;
begin
  CarregaAliquotas;
end;

function TACBrECFEscECF.AchaICMSAliquota(var AliquotaICMS: String
   ): TACBrECFAliquota;
Var
  AliquotaStr : String ;
begin
  AliquotaStr := '' ;
  Result      := nil ;

  if pos(copy(AliquotaICMS,1,2), 'TT,SS') > 0 then { Corrige Duplo T ou S }
     AliquotaICMS := Trim(Copy(AliquotaICMS,2,5));

  if copy(AliquotaICMS,1,2) = 'SF' then
     AliquotaStr := 'FS1'
  else if copy(AliquotaICMS,1,2) = 'SN' then
     AliquotaStr := 'NS1'
  else if copy(AliquotaICMS,1,2) = 'SI' then
     AliquotaStr := 'IS1'
  else if pos(copy(AliquotaICMS,1,2), 'IS|FS|NS') > 0 then
     AliquotaStr := copy(AliquotaICMS,1,2) +
                    ifthen( AliquotaICMS[3] in ['1'..'3'],AliquotaICMS[3],'1' )
  else
     case AliquotaICMS[1] of
        'F','I','N' : AliquotaStr  := AliquotaICMS[1] +
                        ifthen( AliquotaICMS[2] in ['1'..'3'],AliquotaICMS[2],'1' ) ;
        'T','S'     : AliquotaStr  := AliquotaICMS[1] +
                        padR( Trim( Copy(AliquotaICMS,2,2) ), 2, '0' );
     end ;

  if AliquotaStr = '' then
     Result := inherited AchaICMSAliquota( AliquotaICMS )
  else
     AliquotaICMS := AliquotaStr ;
end;

end.


