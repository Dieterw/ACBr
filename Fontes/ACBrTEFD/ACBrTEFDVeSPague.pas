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
|* 26/06/2010: Daniel Simoes de Almeida
|*  - Primeira Versao: Criaçao e Distribuiçao da Primeira Versao
******************************************************************************}

{$I ACBr.inc}

unit ACBrTEFDVeSPague;

interface

uses
  Classes, SysUtils, ACBrTEFDClass,
  {$IFDEF VisualCLX}
     QControls, QForms
  {$ELSE}
     Controls, Forms
  {$ENDIF},
  blcksock ;


Const
   CACBrTEFD_VeSPague_Backup = 'ACBr_VeSPague_Backup.tef' ;
   CACBrTEFD_VeSPague_Terminador = #13+#10+#09+#09+#13+#10+#09+#09+#09+#13+#10+#09+#09+#13+#10+#09 ;

type

  { TACBrTEFDVeSPagueCmd }

  TACBrTEFDVeSPagueCmd = class
  private
    fsIsColeta : Boolean ;
    fsParams : TStringList ;
    fsSequencial : Integer ;
    function GetFrameEnvio : AnsiString ;
    function GetRetorno : Integer ;
    function GetSequencial : Integer ;
    function GetServico : AnsiString ;
    function DecodificaString(const AString : AnsiString) : AnsiString ;
    procedure SetFrameEnvio(const AValue : AnsiString) ;
    procedure SetIsColeta(const AValue : Boolean) ;
    procedure SetRetorno(const AValue : Integer) ;
    procedure SetSequencial(const AValue : Integer) ;
    procedure SetServico(const AValue : AnsiString) ;
  public
    constructor Create ;
    destructor Destroy ; override ;

    property IsColeta    : Boolean     read fsIsColeta write SetIsColeta ;
    property Sequencial  : Integer     read GetSequencial write SetSequencial ;
    property Servico     : AnsiString  read GetServico write SetServico ;
    property Retorno     : Integer     read GetRetorno write SetRetorno ;

    property FrameEnvio  : AnsiString  read GetFrameEnvio write SetFrameEnvio ;
    property Params      : TStringList read fsParams ;

    procedure Clear ;

    Function GetParamString(const ParamName : String) : AnsiString ;
    Function GetParamInteger(const ParamName : String) : Integer ;
    Function GetParamDouble(const ParamName : String) : Double ;
    Function GetParamDateTime(const ParamName : String) : TDateTime ;
    Procedure GetParamStrings(const ParamName : String; const AStringList : TStrings) ;

    Procedure AddParamString(const ParamName : String; const AString  : AnsiString) ;
    Procedure AddParamInteger(const ParamName : String; const AInteger : Integer) ;
    Procedure AddParamDouble(const ParamName : String; const ADouble  : Double) ;
    Procedure AddParamDateTime(const ParamName : String;
       const ADateTime: TDateTime; const Tipo : Char = 'D'  ) ;
    Procedure AddParamStrings(const ParamName : String; const AStringList : TStrings) ;
  end ;

  { TACBrTEFDRespVeSPague }

  TACBrTEFDRespVeSPague = class( TACBrTEFDResp )
  protected
    function GetTransacaoAprovada : Boolean; override;
  public
    procedure ConteudoToProperty; override;
    procedure GravaInformacao( const PalavraChave, Informacao : AnsiString ) ;
  end;

  TACBrTEFDVeSPagueExibeMenu = procedure( Titulo : String; Opcoes : TStringList;
    var ItemSelecionado : Integer) of object ;

  TACBrTEFDVeSPagueObtemCampo = procedure( Titulo : String;
    Mascara : String; Tipo : Char; var Resposta : AnsiString;
    var Digitado : Boolean ) of object ;

  { TACBrTEFDVeSPague }

   TACBrTEFDVeSPague = class( TACBrTEFDClass )
   private
      fAplicacao       : String;
      fAplicacaoVersao : String;

      fTerminador : AnsiString ;
      fEnderecoIP : AnsiString;
      fPorta      : AnsiString;
      fTimeOut    : Integer ;

      fSocket : TTCPBlockSocket ;
      fReqVS  : TACBrTEFDVeSPagueCmd ;
      fRespVS : TACBrTEFDVeSPagueCmd ;

      fOnExibeMenu : TACBrTEFDVeSPagueExibeMenu;
      fOnObtemCampo : TACBrTEFDVeSPagueObtemCampo;
      fTransacaoADM : String;
      fTransacaoCHQ : String;
      fTransacaoCNC : String;
      fTransacaoCRT : String;
      fTransacaoReImpressao: String;

     Function ExecutarTransacao( Transacao : String ) : Boolean ;
     procedure TransmiteCmd ;
     procedure AvaliaErro ;
     procedure ServicoIniciar ;
     procedure ServicoFinalizar ;
     procedure ProcessarColeta ;
   protected
     procedure SetNumVias(const AValue : Integer); override;

     procedure ProcessarResposta ; override;
   public
     constructor Create( AOwner : TComponent ) ; override;
     destructor Destroy ; override;

     property Socket : TTCPBlockSocket read fSocket ;
     property ReqVS  : TACBrTEFDVeSPagueCmd read fReqVS  ;
     property RespVS : TACBrTEFDVeSPagueCmd read fRespVS ;
     property Terminador : AnsiString read fTerminador write fTerminador ;

     procedure Inicializar ; override;

     procedure AtivarGP ; override;
     procedure VerificaAtivo ; override;

     Procedure ATV ; override;
     Function ADM : Boolean ; override;
     Function CRT( Valor : Double; IndiceFPG_ECF : String;
        DocumentoVinculado : String = ''; Moeda : Integer = 0 ) : Boolean; override;
     Function CHQ( Valor : Double; IndiceFPG_ECF : String;
        DocumentoVinculado : String = ''; CMC7 : String = '';
        TipoPessoa : AnsiChar = 'F'; DocumentoPessoa : String = '';
        DataCheque : TDateTime = 0; Banco   : String = '';
        Agencia    : String = ''; AgenciaDC : String = '';
        Conta      : String = ''; ContaDC   : String = '';
        Cheque     : String = ''; ChequeDC  : String = '';
        Compensacao: String = '' ) : Boolean ; override;
     Procedure NCN(Rede, NSU, Finalizacao : String;
        Valor : Double = 0; DocumentoVinculado : String = ''); override;
     Procedure CNF(Rede, NSU, Finalizacao : String;
        DocumentoVinculado : String = ''); override;
     Function CNC(Rede, NSU : String; DataHoraTransacao : TDateTime;
        Valor : Double) : Boolean; overload; override;
   published
     property Aplicacao       : String read fAplicacao       write fAplicacao ;
     property AplicacaoVersao : String read fAplicacaoVersao write fAplicacaoVersao ;

     property EnderecoIP : AnsiString read fEnderecoIP  write fEnderecoIP ;
     property Porta      : AnsiString read fPorta       write fPorta ;
     property TimeOut    : Integer    read fTimeOut     write fTimeOut default 3000 ;

     property TransacaoADM : String read fTransacaoADM write fTransacaoADM ;
     property TransacaoCRT : String read fTransacaoCRT write fTransacaoCRT ;
     property TransacaoCHQ : String read fTransacaoCHQ write fTransacaoCHQ ;
     property TransacaoCNC : String read fTransacaoCNC write fTransacaoCNC ;
     property TransacaoReImpressao : String read fTransacaoReImpressao
        write fTransacaoReImpressao ;

     property OnExibeMenu : TACBrTEFDVeSPagueExibeMenu read fOnExibeMenu
        write fOnExibeMenu ;
     property OnObtemCampo : TACBrTEFDVeSPagueObtemCampo read fOnObtemCampo
        write fOnObtemCampo ;
   end;

implementation

Uses ACBrUtil, dateutils, StrUtils, ACBrTEFD, Dialogs, Math;

{ TACBrTEFDVeSPagueCmd }

constructor TACBrTEFDVeSPagueCmd.Create ;
begin
  inherited ;
  fsParams := TStringList.Create;
  Clear;
end ;

destructor TACBrTEFDVeSPagueCmd.Destroy ;
begin
  fsParams.Free ;

  inherited ;
end ;

procedure TACBrTEFDVeSPagueCmd.Clear ;
begin
  fsParams.Clear;
  fsSequencial := 0 ;
  fsIsColeta   := False ;
end ;

procedure TACBrTEFDVeSPagueCmd.GetParamStrings(const ParamName : String ;
  const AStringList : TStrings) ;
Var
  Buffer : AnsiString ;
  I      : Integer ;
begin
  Buffer := fsParams.Values[ParamName] ;
  Buffer := StringReplace( Buffer, '";"', '"'+sLineBreak+'"', [rfReplaceAll]);

  AStringList.Clear;
  AStringList.Text := Buffer ;

  For I := 0 to AStringList.Count-1 do
     AStringList[I] := ACBrStr( DecodificaString(AStringList[I]) );
end ;

function TACBrTEFDVeSPagueCmd.GetFrameEnvio : AnsiString ;
begin
  Result := fsParams.Text;
  Result := StringToBinaryString(Result);
end;

procedure TACBrTEFDVeSPagueCmd.SetFrameEnvio(const AValue : AnsiString) ;
Var
  Buffer : AnsiString;
begin
  fsParams.Clear;
  fsSequencial := 0 ;

  Buffer := StringReplace(AValue,'"'+#10,'[LineBreak]',[rfReplaceAll]);
  Buffer := BinaryStringToString(Buffer);
  Buffer := StringReplace(Buffer,'[LineBreak]','"'+sLineBreak,[rfReplaceAll]);

  fsParams.Text := Buffer;
  fsIsColeta    := (GetParamInteger('automacao_coleta_sequencial') > 0);
end;

procedure TACBrTEFDVeSPagueCmd.SetIsColeta(const AValue : Boolean) ;
begin
  if AValue = fsIsColeta then exit ;

  fsIsColeta := AValue;
end;

function TACBrTEFDVeSPagueCmd.GetRetorno : Integer ;
begin
  Result := GetParamInteger( ifthen(IsColeta,'automacao_coleta_retorno', 'retorno') );
end;

function TACBrTEFDVeSPagueCmd.GetSequencial : Integer ;
begin
  if fsSequencial = 0 then
     fsSequencial := GetParamInteger( ifthen(IsColeta,'automacao_coleta_sequencial',
                                                      'sequencial') );

  Result := fsSequencial;
end;

function TACBrTEFDVeSPagueCmd.GetServico : AnsiString ;
begin
  Result := GetParamString('servico')
end;

function TACBrTEFDVeSPagueCmd.DecodificaString(const AString : AnsiString) : AnsiString ;
var
  Inicio, Tamanho : Integer ;
begin
  Result  := Trim(AString) ;
  Inicio  := 1 ;
  Tamanho := Length(Result) ;
  if LeftStr(Result,1) = '"' then
  begin
     Inicio := 2;
     Dec( Tamanho ) ;
  end ;

  if RightStr(Result,1) = '"' then
     Dec( Tamanho )  ;

  Result := Copy(Result, Inicio, Tamanho);
  Result := StringToBinaryString(Result);
end ;

function TACBrTEFDVeSPagueCmd.GetParamString(const ParamName : String) : AnsiString ;
begin
   Result := DecodificaString( fsParams.Values[ParamName] );
end ;

function TACBrTEFDVeSPagueCmd.GetParamInteger(const ParamName : String) : Integer ;
begin
  Result := StrToInt64Def(GetParamString(ParamName),0);
end ;

function TACBrTEFDVeSPagueCmd.GetParamDouble(const ParamName : String) : Double ;
begin
  Result := StringToFloatDef(GetParamString(ParamName),0);
end ;

function TACBrTEFDVeSPagueCmd.GetParamDateTime(const ParamName : String) : TDateTime ;
Var
  ValStr : AnsiString ;
  P, Ano, Mes, Dia, Hora, Min, Seg, Mili : Integer ;
begin
  ValStr := GetParamString(ParamName) ;
  Ano    := 0 ;
  Mes    := 0 ;
  Dia    := 0 ;
  Hora   := 0 ;
  Min    := 0 ;
  Seg    := 0 ;
  Mili   := 0 ;

  try
     P := pos('-',ValStr) ;
     if (P > 0) then   // Tem Data ?
     begin
        Ano := StrToInt(Copy(ValStr,1,4));
        Mes := StrToInt(Copy(ValStr,6,2));
        Dia := StrToInt(Copy(ValStr,9,2));
     end ;

     P := pos(':',ValStr) ;
     if (P > 0) then   // Tem Hora ?
     begin
        Hora := StrToInt(Copy(ValStr,P-2,2));
        Min  := StrToInt(Copy(ValStr,P+1,2));
        Seg  := StrToInt(Copy(ValStr,P+4,2));
        Mili := StrToInt(Copy(ValStr,P+7,3));
     end ;

     Result := EncodeDateTime(Ano,Mes,Dia,Hora,Min,Seg,Mili);
  except
     Result := 0 ;
  end ;
end ;

procedure TACBrTEFDVeSPagueCmd.SetRetorno(const AValue : Integer) ;
begin
   AddParamInteger(ifthen(IsColeta,'automacao_coleta_retorno','retorno'),AValue);
end;

procedure TACBrTEFDVeSPagueCmd.SetSequencial(const AValue : Integer) ;
begin
  fsSequencial := AValue;
  AddParamInteger(ifthen(IsColeta,'automacao_coleta_sequencial','sequencial'),AValue);
end;

procedure TACBrTEFDVeSPagueCmd.SetServico(const AValue : AnsiString) ;
begin
  fsParams.Clear;
  fsIsColeta := False ;
  Sequencial := fsSequencial + 1;
  Retorno    := 1 ;

  AddParamString('servico',AValue);
end;

procedure TACBrTEFDVeSPagueCmd.AddParamString(const ParamName : String ;
  const AString : AnsiString) ;
begin
   fsParams.Values[ParamName] := '"'+AString+'"';
end ;

procedure TACBrTEFDVeSPagueCmd.AddParamInteger(const ParamName : String ;
  const AInteger : Integer) ;
begin
   AddParamString(ParamName, IntToStr(AInteger)  );
end ;

procedure TACBrTEFDVeSPagueCmd.AddParamDouble(const ParamName : String ;
  const ADouble : Double) ;
Var
  StrValue : String ;
begin
   StrValue := FloatToStr(ADouble);
   StrValue := StringReplace( StrValue, DecimalSeparator, '.', [] );

   AddParamString(ParamName,StrValue);
end ;

procedure TACBrTEFDVeSPagueCmd.AddParamDateTime(const ParamName : String ;
  const ADateTime : TDateTime ; const Tipo : Char) ;
var
  Formato,ValStr : String ;
begin
   Formato := '' ;

   case upcase(Tipo) of
     'T','H' : Formato := 'hh:nn:ss.zzz';
     'D'     : Formato := 'yyyy-mm-dd';
   else
     Formato := 'yyyy-mm-dd hh:nn:ss.zzz' ;
   end ;

   ValStr := FormatDateTime( Formato, ADateTime ) ;

   AddParamString(ParamName, ValStr);
end ;

procedure TACBrTEFDVeSPagueCmd.AddParamStrings(const ParamName : String ;
  const AStringList : TStrings) ;
Var
  Buffer : AnsiString ;
  I      : Integer ;
begin
  Buffer := '' ;

  For I := 0 to AStringList.Count-1 do
     Buffer := Buffer + '"'+ AStringList[I] +'";' ;

  Buffer := copy(Buffer,1,Length(Buffer)-1);  // Remove o ultimo ";"

  AddParamString( ParamName, Buffer );
end ;

{ TACBrTEFDRespVeSPague }

function TACBrTEFDRespVeSPague.GetTransacaoAprovada : Boolean;
begin
   Result := True ;
end;

procedure TACBrTEFDRespVeSPague.ConteudoToProperty;
begin
// Conteudo.Conteudo.SaveToFile('c:\temp\conteudo.txt') ;
(*
   fpValorTotal := 0 ;
   fpImagemComprovante1aVia.Clear;
   fpImagemComprovante2aVia.Clear;

   for I := 0 to Conteudo.Count - 1 do
   begin
     Linha := Conteudo.Linha[I];

     LinStr := StringToBinaryString( Linha.Informacao.AsString );

     case Linha.Identificacao of
       // TODO: Mapear mais propriedades do VeSPague //
       100 :fpModalidadePagto              := LinStr;
       101 :fpModalidadePagtoExtenso       := LinStr;
       102 :fpModalidadePagtoDescrita      := LinStr;
       105 :
         begin
           fpDataHoraTransacaoComprovante  := Linha.Informacao.AsTimeStampSQL;
           fpDataHoraTransacaoHost         := fpDataHoraTransacaoComprovante ;
         end;
       121 : fpImagemComprovante1aVia.Text := StringReplace( StringToBinaryString( Linha.Informacao.AsAnsiString ), #10, sLineBreak, [rfReplaceAll] );
       122 : fpImagemComprovante2aVia.Text := StringReplace( StringToBinaryString( Linha.Informacao.AsAnsiString ), #10, sLineBreak, [rfReplaceAll] );
       130 :
         begin
           fpSaque      := Linha.Informacao.AsFloat ;
           fpValorTotal := fpValorTotal + fpSaque ;
         end;
       131 : fpInstituicao                 := LinStr;
       133 : fpCodigoAutorizacaoTransacao  := Linha.Informacao.AsInteger;
       134 : fpNSU                         := LinStr;
       156 : fpRede                        := LinStr;
       501 : fpTipoPessoa                  := AnsiChar(IfThen(Linha.Informacao.AsInteger = 0,'J','F')[1]);
       502 : fpDocumentoPessoa             := LinStr ;
       505 : fpQtdParcelas                 := Linha.Informacao.AsInteger ;
       506 : fpDataPreDatado               := Linha.Informacao.AsDate;
       
       //incluido por Evandro
       627 : fpAgencia                     := LinStr;
       628 : fpAgenciaDC                   := LinStr;
       120 : fpAutenticacao                := LinStr;
       626 : fpBanco                       := LinStr;
       613 :
        begin
          fpCheque                         := copy(LinStr, 21, 6);
          fpCMC7                           := LinStr;
        end;
       629 : fpConta                       := LinStr;
       630 : fpContaDC                     := LinStr;
       527 : fpDataVencimento              := Linha.Informacao.AsDate ; {Data Vencimento}
       //

       899 :  // Tipos de Uso Interno do ACBrTEFD
        begin
          case Linha.Sequencia of
              1 : fpCNFEnviado         := (UpperCase( Linha.Informacao.AsString ) = 'S' );
              2 : fpIndiceFPG_ECF      := Linha.Informacao.AsString ;
              3 : fpOrdemPagamento     := Linha.Informacao.AsInteger ;
            100 : fpHeader             := LinStr;
            101 : fpID                 := Linha.Informacao.AsInteger;
            102 : fpDocumentoVinculado := LinStr;
            103 : fpValorTotal         := fpValorTotal + Linha.Informacao.AsFloat;
          end;
        end;
     end;
   end ;

   fpParcelas.Clear;
   for I := 1 to fpQtdParcelas do
   begin
      Parc := TACBrTEFDRespParcela.create;
      Parc.Vencimento := LeInformacao( 141, I).AsDate ;
      Parc.Valor      := LeInformacao( 142, I).AsFloat ;

      fpParcelas.Add(Parc);
   end;   *)
end;

procedure TACBrTEFDRespVeSPague.GravaInformacao( const PalavraChave,
   Informacao : AnsiString );
begin
//  fpConteudo.GravaInformacao( Identificacao, Sequencia,
//                               BinaryStringToString(Informacao) ); // Converte #10 para "\x0A"
end;


{ TACBrTEFDClass }

constructor TACBrTEFDVeSPague.Create(AOwner : TComponent);
begin
  inherited Create(AOwner);

  ArqReq    := '' ;
  ArqResp   := '' ;
  ArqSTS    := '' ;
  ArqTemp   := '' ;
  GPExeName := '' ;
  fpTipo    := gpVeSPague;
  Name      := 'VeSPague' ;

  fEnderecoIP := 'localhost' ;
  fPorta      := '60906' ;
  fTimeOut    := 3000 ;
  fTerminador := CACBrTEFD_VeSPague_Terminador ;

  fAplicacao       := '' ;
  fAplicacaoVersao := '' ;

  fSocket := nil ;
  fReqVS  := TACBrTEFDVeSPagueCmd.Create;
  fRespVS := TACBrTEFDVeSPagueCmd.Create;

  fTransacaoCRT         := 'Cartao Vender' ;
  fTransacaoReImpressao := 'Administracao Reimprimir' ;
  fTransacaoADM         := 'Administracao Consultar' ;
  fTransacaoCHQ         := 'Cheque Consultar' ;
  fTransacaoCNC         := 'Administracao Cancelar' ;

  fOnExibeMenu  := nil ;
  fOnObtemCampo := nil ;

  if Assigned( fpResp ) then
     fpResp.Free ;

  fpResp := TACBrTEFDRespVeSPague.Create;
  fpResp.TipoGP := Tipo;
end;

destructor TACBrTEFDVeSPague.Destroy;
begin
  if Assigned(fSocket) then
  begin
    fSocket.CloseSocket;
    fSocket.Free;
  end ;

  fReqVS.Free ;
  fRespVS.Free ;

  inherited Destroy;
end;

procedure TACBrTEFDVeSPague.SetNumVias(const AValue : Integer);
begin
   fpNumVias := 2;
end;

procedure TACBrTEFDVeSPague.Inicializar;
begin
  if Inicializado then exit ;

  if not Assigned( OnExibeMenu ) then
     raise Exception.Create( ACBrStr('Evento "OnExibeMenu" não programado' ) ) ;

  if not Assigned( OnObtemCampo ) then
     raise Exception.Create( ACBrStr('Evento "OnObtemCampo" não programado' ) ) ;

  if not Assigned(fSocket) then
  begin
     fSocket := TTCPBlockSocket.Create;
     fSocket.Connect( fEnderecoIP, fPorta );
     if fSocket.LastError <> 0 then
        raise EACBrTEFDErro.Create( ACBrStr('Erro ao conectar no V&SPague'+sLineBreak+
                                'Endereço: '+fEnderecoIP+sLineBreak+
                                'Porta: '+fPorta+sLineBreak+
                                'Erro: '+IntToStr(fSocket.LastError)+'-'+fSocket.LastErrorDesc ) ) ;
  end ;

  fpInicializado := True ;
  GravaLog( Name +' Inicializado VeSPague' );

  CancelarTransacoesPendentesClass           // Cancele tudo... //
end;

procedure TACBrTEFDVeSPague.AtivarGP;
begin
   raise Exception.Create( ACBrStr( 'VeSPague não pode ser ativado localmente' )) ;
end;

procedure TACBrTEFDVeSPague.VerificaAtivo;
begin
   {Nada a Fazer}
end;

Procedure TACBrTEFDVeSPague.ATV ;
begin
  ServicoIniciar;
  ServicoFinalizar;
end;

Function TACBrTEFDVeSPague.ADM : Boolean;
begin
  Result := ExecutarTransacao( fTransacaoADM ) ;
end;

Function TACBrTEFDVeSPague.CRT( Valor : Double; IndiceFPG_ECF : String;
   DocumentoVinculado : String = ''; Moeda : Integer = 0 ) : Boolean;
begin
  VerificarTransacaoPagamento( Valor );
  Result := ExecutarTransacao( fTransacaoCRT );
end;

Function TACBrTEFDVeSPague.CHQ(Valor : Double; IndiceFPG_ECF : String;
   DocumentoVinculado : String; CMC7 : String; TipoPessoa : AnsiChar;
   DocumentoPessoa : String; DataCheque : TDateTime; Banco : String;
   Agencia : String; AgenciaDC : String; Conta : String; ContaDC : String;
   Cheque : String; ChequeDC : String; Compensacao: String) : Boolean ;
begin
  VerificarTransacaoPagamento( Valor );
  Result := ExecutarTransacao( fTransacaoCHQ );
end;

Procedure TACBrTEFDVeSPague.CNF(Rede, NSU, Finalizacao : String;
   DocumentoVinculado : String) ;
begin
end;

Function TACBrTEFDVeSPague.CNC(Rede, NSU : String;
   DataHoraTransacao : TDateTime; Valor : Double) : Boolean;
begin
  Result := ExecutarTransacao( fTransacaoCNC );
end;

Procedure TACBrTEFDVeSPague.NCN(Rede, NSU, Finalizacao : String;
   Valor : Double; DocumentoVinculado : String) ;
begin
end;

procedure TACBrTEFDVeSPague.ServicoIniciar ;
begin
  ReqVS.Servico := 'iniciar' ;
  ReqVS.AddParamString('aplicacao',fAplicacao);
  ReqVS.AddParamString('versao',fAplicacaoVersao);

  TransmiteCmd;
  ProcessarResposta;
end ;

procedure TACBrTEFDVeSPague.ServicoFinalizar ;
begin
  ReqVS.Servico := 'finalizar' ;

  TransmiteCmd;
  ProcessarResposta ;
end ;

Function TACBrTEFDVeSPague.ExecutarTransacao( Transacao : String ) : Boolean ;
begin
  with TACBrTEFD(Owner) do
  begin
    BloquearMouseTeclado(True);
    try
      ServicoIniciar ;

      ReqVS.Servico := 'executar' ;
      ReqVS.AddParamString( 'transacao', Transacao ) ;
      TransmiteCmd ;
      ProcessarResposta ;

      Result := ( RespVS.Retorno = 1 ) ;

      if (RespVS.Retorno in [0,1,9]) then
         ServicoFinalizar ;
    finally
      BloquearMouseTeclado(False);
    end ;
  end ;
end ;

procedure TACBrTEFDVeSPague.ProcessarResposta ;
var
  Retorno : LongInt ;
  Mensagem : AnsiString ;
begin
  repeat
     Retorno := RespVS.Retorno ;

     if Retorno = 2 then                        // Erro := 'Sequencial Inválido' ;
     begin
        ReqVS.Sequencial := RespVS.Sequencial;  // Ajusta o Sequencial correto
        TransmiteCmd;                           // Tenta novamente
        Continue;
     end ;

     AvaliaErro ;       // Dispara Exception se houver erro

     if RespVS.IsColeta then
     begin
        ProcessarColeta ;
        Retorno := RespVS.Retorno;
     end ;

  until Retorno in [1,9] ;

  if Retorno = 9 then
  begin
     if RespVS.IsColeta then
        Mensagem := RespVS.GetParamString('automacao_coleta_mensagem')
     else
        Mensagem := RespVS.GetParamString('mensagem');

     if Mensagem <> '' then
        TACBrTEFD(Owner).DoExibeMsg( opmOK, Mensagem ) ;
  end ;
end ;

procedure TACBrTEFDVeSPague.ProcessarColeta ;
var
  Mensagem, Mascara, Resposta : AnsiString ;
  Tipo : Char ;
  OpcoesMenu : TStringList ;
  ItemSelecionado : Integer ;
  Cancelar, Digitado : Boolean ;
  MR : TModalResult ;
begin
  with TACBrTEFD(Owner) do
  begin
     OpcoesMenu := TStringList.Create;
     try
        while RespVS.IsColeta and (RespVS.Retorno = 0) do
        begin
           Cancelar := False ;
           Resposta := '' ;
           Mensagem := RespVS.GetParamString('automacao_coleta_mensagem');
           Mascara  := RespVS.GetParamString('automacao_coleta_mascara');
           Tipo     := padL(RespVS.GetParamString('automacao_coleta_tipo'),1)[1] ;
           RespVS.GetParamStrings('automacao_coleta_opcao', OpcoesMenu);

           if OpcoesMenu.Count > 0 then            // Tem Menu ?
            begin
              if (OpcoesMenu.Count = 2) and
                 (OpcoesMenu[0] = 'Sim') and (OpcoesMenu[1] = ACBrStr('Não') ) then
               begin
                 MR := DoExibeMsg( opmYesNo, Mensagem ) ;

                 if MR = mrYes then
                    Resposta := OpcoesMenu[0]
                 else if MR = mrNo then
                    Resposta := OpcoesMenu[1]
                 else
                    Cancelar := True ;
               end
              else
               begin
                 ItemSelecionado := -1 ;
                 BloquearMouseTeclado(False);
                 OnExibeMenu( ACBrStr(Mensagem), OpcoesMenu, ItemSelecionado ) ;
                 BloquearMouseTeclado(True);

                 if (ItemSelecionado >= 0) and
                    (ItemSelecionado < OpcoesMenu.Count) then
                    Resposta := OpcoesMenu[ ItemSelecionado ]
                 else
                    Cancelar := True ;
               end ;
            end

           else if Tipo <> ' ' then                // Tem Pergunta ?
            begin
              BloquearMouseTeclado(False);
              Digitado := False ;
              OnObtemCampo( ACBrStr(Mensagem), Mascara, Tipo, Resposta, Digitado) ;
              BloquearMouseTeclado(True);

              Cancelar := not Digitado;
            end

           else if Mensagem <> '' then             // Tem Mensagem ?
            begin
              DoExibeMsg( opmExibirMsgOperador, Mensagem ) ;
            end ;

           // Respondendo a Coleta //
           ReqVS.Clear;
           ReqVS.IsColeta   := True ;
           ReqVS.Sequencial := RespVS.Sequencial;

           if Resposta <> '' then
              ReqVS.AddParamString( 'automacao_coleta_informacao', Resposta ) ;

           ReqVS.Retorno := ifthen( Cancelar, 9, 0) ;

           TransmiteCmd;
           AvaliaErro;
        end ;
     finally
        OpcoesMenu.Free;
     end ;
  end ;
end ;

Procedure TACBrTEFDVeSPague.TransmiteCmd ;
Var
  TX, RX : AnsiString ;
begin
  if not Assigned(fSocket) then
     raise EACBrTEFDErro.Create( ACBrStr('TEF '+Name+' não inicializado') );

  RespVS.Clear;    // Limpa a resposta

  // Enviado comando //
  TX := ReqVS.FrameEnvio;
  GravaLog( 'TRANSMITINDO ->'+sLineBreak+TX );
  fSocket.SendString(TX);
  GravaLog( '  TRANSMITIDO, ('+IntToStr(fSocket.LastError)+')'+sLineBreak );
  if fSocket.LastError <> 0 then
     raise EACBrTEFDErro.Create( ACBrStr('Erro ao Transmitir Comando para V&SPague'+sLineBreak+
                             'Endereço: '+fEnderecoIP+sLineBreak+
                             'Porta: '+fPorta+sLineBreak+
                             'Erro: '+IntToStr(fSocket.LastError)+'-'+fSocket.LastErrorDesc ) ) ;

  // Aguardando a Resposta //
  RX := fSocket.RecvTerminated(fTimeOut,fTerminador);
  GravaLog( '<- RECEBIDO, ('+IntToStr(fSocket.LastError)+')'+sLineBreak+RX );
  if fSocket.LastError <> 0 then
     raise EACBrTEFDErro.Create( ACBrStr('Erro ao Receber resposta do V&SPague'+sLineBreak+
                             'Endereço: '+fEnderecoIP+sLineBreak+
                             'Porta: '+fPorta+sLineBreak+
                             'Erro: '+IntToStr(fSocket.LastError)+'-'+fSocket.LastErrorDesc ) ) ;

  // Trata a Resposta //
  RespVS.FrameEnvio := RX ;
end ;

procedure TACBrTEFDVeSPague.AvaliaErro;
var
   Erro    : String;
   Retorno : Integer ;
begin
  Erro    := '' ;
  Retorno := RespVS.Retorno ;
  Case Retorno of
    0,1,9 : Erro := '' ;
    2 : Erro := 'Sequencial Inválido' ;
    3 : Erro := 'Transação cancelada pelo operador' ;
    4 : Erro := 'Transação cancelada pelo cliente' ;
    5 : Erro := 'Parâmetros insuficientes ou inválidos' ;
    6 : Erro := 'Problemas entre o V&SPagueClient e V&SPagueServer' ;
    7 : Erro := 'Problemas entre o V&SPagueServer e a Rede' ;
    8 : Erro := 'Tempo limite de espera excedido' ;
  end ;

  if Erro <> '' then
     raise EACBrTEFDSTSInvalido.Create( ACBrStr(Erro) );

{  if RespVS.Sequencial <> ReqVS.Sequencial then
     raise EACBrTEFDSTSInvalido.Create( ACBrStr('Sequencia da Resposta inválida') );}
end ;

end.

