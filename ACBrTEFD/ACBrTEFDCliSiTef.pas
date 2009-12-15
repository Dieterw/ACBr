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
|* 21/11/2009: Daniel Simoes de Almeida
|*  - Primeira Versao: Criaçao e Distribuiçao da Primeira Versao
******************************************************************************}

{$I ACBr.inc}

unit ACBrTEFDCliSiTef;

interface

uses
  Classes, SysUtils, ACBrTEFDClass, contnrs
  {$IFDEF VisualCLX}
     ,QControls
  {$ELSE}
     ,Controls
  {$ENDIF}  ;


Const
{$IFDEF LINUX}
  CLIB_CliSiTefLib = 'libclisitef32.so' ;
{$ELSE}
  CLIB_CliSiTefLib = 'CliSiTef32I.dll' ;
{$ENDIF}

type
  { TACBrTEFDLinha }

  { TACBrTEFDCliSiTefLinha }

  TACBrTEFDCliSiTefLinha = class( TACBrTEFDLinha )
  private
  protected
    property Sequencia ;
  public
    property Identificacao ;
    property Informacao ;
  end ;


  { TACBrTEFDRespParcelas }
  { Lista de Objetos do tipo TACBrTEFParcela }

  { TACBrTEFDCliSiTefResp }

  TACBrTEFDCliSiTefResp = class(TObjectList)
    protected
      procedure SetObject (Index: Integer; Item: TACBrTEFDCliSiTefLinha);
      function GetObject (Index: Integer): TACBrTEFDCliSiTefLinha;

      function AchaLinha(const Identificacao : Integer) : Integer;

    public
      function Add (Obj: TACBrTEFDCliSiTefLinha): Integer;
      procedure Insert (Index: Integer; Obj: TACBrTEFDCliSiTefLinha);
      property Objects [Index: Integer]: TACBrTEFDCliSiTefLinha
         read GetObject write SetObject; default;

      procedure GravaInformacao( const Identificacao : Integer;
         const Informacao : AnsiString ) ; overload;
      procedure GravaInformacao( const Identificacao : Integer;
         const Informacao : TACBrTEFDLinhaInformacao ) ; overload;
      function LeInformacao( const Identificacao : Integer)
         : TACBrTEFDLinhaInformacao ;

      function LeLinha( const Identificacao : Integer) : TACBrTEFDCliSiTefLinha ;
      Procedure LeStrings( AStringList : TStringList ) ;
    end;


  TACBrTEFDCliSiTefExibeMenu = procedure( Titulo : String; Opcoes : TStringList;
    var ItemSlecionado : Integer ) of object ;

  TACBrTEFDCliSiTefObtemCampo = procedure( Titulo : String;
    TamanhoMinimo, TamanhoMaximo : Integer ; var Resposta : String ) of object ;

   { TACBrTEFDCliSiTef }

   TACBrTEFDCliSiTef = class( TACBrTEFDClass )
   private
      fCodigoLoja : String;
      fEnderecoIP : String;
      fNumeroTerminal : String;
      fOnExibeMenu : TACBrTEFDCliSiTefExibeMenu;
      fOnObtemCampo : TACBrTEFDCliSiTefObtemCampo;
      fOperador : String;
      fParametrosAdicionais : TStringList;
      fProximaFuncao : Integer;
      fRespCliSiTef : TACBrTEFDCliSiTefResp;
      fRestricoes : String;
     xConfiguraIntSiTefInterativoEx : function (
                pEnderecoIP: PChar;
                pCodigoLoja: PChar;
                pNumeroTerminal: PChar;
                ConfiguraResultado: smallint;
                pParametrosAdicionais: PChar): integer; stdcall;

     xIniciaFuncaoSiTefInterativo : function (
                Modalidade: integer;
                pValor: PChar;
                pNumeroCuponFiscal: PChar;
                pDataFiscal: PChar;
                pHorario: PChar;
                pOperador: PChar;
                pRestricoes: PChar ): integer; stdcall;

     xFinalizaTransacaoSiTefInterativo : procedure (
                 smallint: Word;
                 pNumeroCuponFiscal: PChar;
                 pDataFiscal: PChar;
                 pHorario: PChar ); stdcall;

     xContinuaFuncaoSiTefInterativo : function (
                var ProximoComando: Integer;
                var TipoCampo: Integer;
                var TamanhoMinimo: smallint;
                var TamanhoMaximo: smallint;
                pBuffer: PChar;
                TamMaxBuffer: Integer;
                ContinuaNavegacao: Integer ): integer; stdcall;
     procedure AvaliaErro(Sts : Integer);
     procedure LoadDLLFunctions;
   protected
     Function IniciarRequisicao( Funcao : Integer; Valor : Double = 0;
        Documento : AnsiString = '') : Integer ; overload;
     Function ContinuarRequisicao : Integer ;

   public
     property ProximaFuncao : Integer read fProximaFuncao write fProximaFuncao ;

     property RespCliSiTef : TACBrTEFDCliSiTefResp read fRespCliSiTef ;

     constructor Create( AOwner : TComponent ) ; override;
     destructor Destroy ; override;

     procedure Inicializar ; override;

     procedure AtivarGP ; override;
     procedure VerificaAtivo ; override;

     procedure ATV ; override;
     procedure ADM ; override;

   published
     property EnderecoIP     : String read fEnderecoIP     write fEnderecoIP ;
     property CodigoLoja     : String read fCodigoLoja     write fCodigoLoja ;
     property NumeroTerminal : String read fNumeroTerminal write fNumeroTerminal ;
     property Operador       : String read fOperador       write fOperador ;
     property ParametrosAdicionais : TStringList read fParametrosAdicionais ;
     property Restricoes : String read fRestricoes write fRestricoes ;

     property OnExibeMenu : TACBrTEFDCliSiTefExibeMenu read fOnExibeMenu
        write fOnExibeMenu ;
     property OnObtemCampo : TACBrTEFDCliSiTefObtemCampo read fOnObtemCampo
        write fOnObtemCampo ;
   end;

implementation

Uses ACBrUtil, dateutils, StrUtils, ACBrTEFD;


{ TACBrTEFDCliSiTefResp }

procedure TACBrTEFDCliSiTefResp.SetObject(Index : Integer;
   Item : TACBrTEFDCliSiTefLinha);
begin
  inherited SetItem (Index, Item) ;
end;

function TACBrTEFDCliSiTefResp.GetObject(Index : Integer ) : TACBrTEFDCliSiTefLinha;
begin
   Result := inherited GetItem(Index) as TACBrTEFDCliSiTefLinha ;
end;

function TACBrTEFDCliSiTefResp.AchaLinha(const Identificacao : Integer ) : Integer;
Var
  I : Integer;
begin
  Result := -1 ;
  I      := 0 ;
  while (Result < 0) and (I < self.Count) do
  begin
     if TACBrTEFDCliSiTefLinha(Items[I]).Identificacao = Identificacao then
        Result := I;
     Inc( I ) ;
  end;
end;

function TACBrTEFDCliSiTefResp.Add(Obj : TACBrTEFDCliSiTefLinha) : Integer;
begin
   Result := inherited Add(Obj) ;
end;

procedure TACBrTEFDCliSiTefResp.Insert(Index : Integer;
   Obj : TACBrTEFDCliSiTefLinha);
begin
   inherited Insert(Index, Obj);
end;

procedure TACBrTEFDCliSiTefResp.GravaInformacao(const Identificacao : Integer;
   const Informacao : AnsiString);
Var
  I : Integer ;
  ALinha : TACBrTEFDCliSiTefLinha ;
begin
  if Informacao = '' then exit ;

  I := AchaLinha( Identificacao ) ;

  if I < 0 then
   begin
     ALinha := TACBrTEFDCliSiTefLinha.Create;
     ALinha.Identificacao       := Identificacao ;
     ALinha.Informacao.AsString := Informacao ;

     self.Add( ALinha )
   end
  else
     TACBrTEFDCliSiTefLinha(Items[I]).Informacao.AsString := Informacao ;
end;

procedure TACBrTEFDCliSiTefResp.GravaInformacao(const Identificacao : Integer;
   const Informacao : TACBrTEFDLinhaInformacao);
begin
  GravaInformacao( Identificacao, Informacao.AsString );
end;

function TACBrTEFDCliSiTefResp.LeInformacao(const Identificacao : Integer
   ) : TACBrTEFDLinhaInformacao;
begin
  Result := LeLinha(Identificacao).Informacao ;
end;

function TACBrTEFDCliSiTefResp.LeLinha(const Identificacao : Integer
   ) : TACBrTEFDCliSiTefLinha;
Var
  I : Integer ;
begin
  I := AchaLinha(Identificacao) ;

  if I > -1 then
     Result := TACBrTEFDCliSiTefLinha(Items[I])
  else
   begin
     GravaInformacao( Identificacao, '' );
     Result := TACBrTEFDCliSiTefLinha( Items[Count-1] );
   end;
end;

procedure TACBrTEFDCliSiTefResp.LeStrings(AStringList : TStringList);
Var
  I : Integer ;
  AStr : String ;
begin
  AStringList.Clear;

  For I := 0 to Count-1 do
  begin
     AStr := TACBrTEFDCliSiTefLinha( Items[I] ).Linha ;
     AStr := StringReplace( AStr, '-000', '', [rfReplaceAll] );
     AStringList.Add( AStr );
  end ;

  AStringList.Sort;
end;


{ TACBrTEFDClass }

constructor TACBrTEFDCliSiTef.Create(AOwner : TComponent);
begin
  inherited Create(AOwner);

  ArqReq    := '' ;
  ArqResp   := '' ;
  ArqSTS    := '' ;
  ArqTemp   := '' ;
  GPExeName := '' ;
  fpTipo    := gpCliSiTef;
  Name      := 'CliSiTef' ;

  fEnderecoIP     := '' ;
  fCodigoLoja     := '' ;
  fNumeroTerminal := '' ;
  fOperador       := '' ;
  fRestricoes     := '' ;
  fProximaFuncao  := -1 ;

  fParametrosAdicionais := TStringList.Create;
  fRespCliSiTef         := TACBrTEFDCliSiTefResp.create(True);

  xConfiguraIntSiTefInterativoEx    := nil ;
  xIniciaFuncaoSiTefInterativo      := nil ;
  xContinuaFuncaoSiTefInterativo    := nil ;
  xFinalizaTransacaoSiTefInterativo := nil ;
end;

destructor TACBrTEFDCliSiTef.Destroy;
begin
   fParametrosAdicionais.Free ;
   fRespCliSiTef.Free;

   inherited Destroy;
end;

procedure TACBrTEFDCliSiTef.Inicializar;
Var
  Sts : Integer ;
  ParamAdic : String ;
  Erro : String;
begin
  if Inicializado then exit ;

  if not Assigned( OnExibeMenu ) then
     raise Exception.Create( ACBrStr('Evento "OnExibeMenu" não programado' ) ) ;

  if not Assigned( OnObtemCampo ) then
     raise Exception.Create( ACBrStr('Evento "OnObtemCampo" não programado' ) ) ;

  LoadDLLFunctions;

  ParamAdic := StringReplace( ParametrosAdicionais.Text, sLineBreak, ';',
                              [rfReplaceAll] ) ;

  Sts := xConfiguraIntSiTefInterativoEx( PChar(fEnderecoIP),
                                         PChar(fCodigoLoja),
                                         PChar(fNumeroTerminal),
                                         0,
                                         PChar(ParamAdic) );
  Erro := '' ;
  Case Sts of
    1 :	Erro := 'Endereço IP inválido ou não resolvido' ;
    2 : Erro := 'Código da loja inválido' ;
    3 : Erro := 'Código de terminal invalido' ;
    6 : Erro := 'Erro na inicialização do Tcp/Ip' ;
    7 : Erro := 'Falta de memória' ;
    8 : Erro := 'Não encontrou a CliSiTef ou ela está com problemas' ;
   10 : Erro := 'O PinPad não está devidamente configurado no arquivo CliSiTef.ini' ;
  end;

  if Erro <> '' then
     raise EACBrTEFDErro.Create( ACBrStr( Erro ) ) ;

  inherited Inicializar;
end;

procedure TACBrTEFDCliSiTef.AtivarGP;
begin
   raise Exception.Create( ACBrStr( 'CliSiTef não pode ser ativado localmente' )) ;
end;

procedure TACBrTEFDCliSiTef.VerificaAtivo;
begin
   {Nada a Fazer}
end;


procedure TACBrTEFDCliSiTef.AvaliaErro( Sts : Integer );
var
   Erro : String;
begin
   Erro := '' ;
   Case Sts of
         0 : Erro := 'negada pelo autorizador' ;
        -1 : Erro := 'módulo não inicializado' ;
        -2 : Erro := 'operação cancelada pelo operador' ;
        -3 : Erro := 'fornecida uma modalidade inválida' ;
        -4 : Erro := 'falta de memória para rodar a função' ;
        -5 : Erro := 'sem comunicação com o SiTef' ;
        -6 : Erro := 'operação cancelada pelo usuário' ;
   else
      if Sts < 0 then
         Erro := 'erros detectados internamente pela rotina ('+IntToStr(Sts)+')' ;
   end;

   if Erro <> '' then
      raise EACBrTEFDErro.Create( ACBrStr( Erro ) ) ;
end ;

procedure TACBrTEFDCliSiTef.ATV;
var
   Sts : Integer;
begin
   Sts := IniciarRequisicao( 111 ) ;  // 111 - Teste de comunicação com o SiTef

   if Sts <> 0 then
      AvaliaErro( Sts );
end;

procedure TACBrTEFDCliSiTef.ADM;
var
   Sts : Integer;
begin
  Sts := IniciarRequisicao( 110 ) ; // 110 - Abre o leque das transações Gerenciais

  if Sts <> 0 then
     AvaliaErro( Sts );
end;

procedure TACBrTEFDCliSiTef.LoadDLLFunctions ;
 procedure CliSiTefFunctionDetect( FuncName: String; var LibPointer: Pointer ) ;
 begin
   if not Assigned( LibPointer )  then
   begin
     if not FunctionDetect( CLIB_CliSiTefLib, FuncName, LibPointer) then
     begin
        LibPointer := NIL ;
        raise Exception.Create( ACBrStr( 'Erro ao carregar a função:'+FuncName+' de: '+CLIB_CliSiTefLib ) ) ;
     end ;
   end ;
 end ;
begin
   CliSiTefFunctionDetect('ConfiguraIntSiTefInterativoEx', @xConfiguraIntSiTefInterativoEx);
   CliSiTefFunctionDetect('IniciaFuncaoSiTefInterativo', @xIniciaFuncaoSiTefInterativo);
   CliSiTefFunctionDetect('ContinuaFuncaoSiTefInterativo', @xContinuaFuncaoSiTefInterativo);
   CliSiTefFunctionDetect('FinalizaTransacaoSiTefInterativo', @xFinalizaTransacaoSiTefInterativo);
end ;

Function TACBrTEFDCliSiTef.IniciarRequisicao( Funcao : Integer;
   Valor : Double = 0 ; Documento : AnsiString = '') : Integer ;
Var
  ValorStr, DataStr, HoraStr : String;
begin
   Result   := 0 ;
   DataStr  := FormatDateTime('YYYYMMDD',Now);
   HoraStr  := FormatDateTime('HHNNSS',Now);
   ValorStr := StringReplace( FormatFloat( '0.00', Valor ),
                              DecimalSeparator, ',', [rfReplaceAll]) ;

   GravaLog( 'IniciaFuncaoSiTefInterativo. Modalidade: '  +IntToStr(Funcao)+
                                           ' Valor: '     +ValorStr+
                                           ' Documento: ' +Documento+
                                           ' Data: '      +DataStr+
                                           ' Hora: '      +HoraStr+
                                           ' Operador: '  +fOperador+
                                           ' Restricoes: '+fRestricoes ) ;

   RespCliSiTef.Clear;

   Result := xIniciaFuncaoSiTefInterativo( Funcao,
                                           PChar( ValorStr ),
                                           PChar( Documento ),
                                           PChar( DataStr ), PChar( HoraStr ),
                                           PChar( fOperador ),
                                           PChar( fRestricoes) ) ;

   if Result = 10000 then
      Result := ContinuarRequisicao ;
end;

Function TACBrTEFDCliSiTef.ContinuarRequisicao : Integer;
var
  ProximoComando, TipoCampo, Continua, ItemSelecionado: Integer;
  TamanhoMinimo, TamanhoMaximo : SmallInt ;
  Buffer: array [0..20000] of char;
  Mensagem, MensagemOperador, MensagemCliente, Resposta, CaptionMenu : String;
  ItensMenu   : TStringList ;
  Interromper : Boolean ;
begin
   Result         := 0;
   ProximoComando := 0;
   TipoCampo      := 0;
   TamanhoMinimo  := 0;
   TamanhoMaximo  := 0;
   Continua       := 0;

   Mensagem         := '' ;
   MensagemOperador := '' ;
   MensagemCliente  := '' ;
   CaptionMenu      := '' ;

   with TACBrTEFD(Owner) do
   begin
      try
         repeat
            Result := xContinuaFuncaoSiTefInterativo( ProximoComando,
                                                      TipoCampo,
                                                      TamanhoMinimo, TamanhoMaximo,
                                                      Buffer, sizeof(Buffer),
                                                      Continua );

            Mensagem := Trim( Buffer ) ;
            Resposta := '' ;

            GravaLog( 'Sts: '+IntToStr(Result)+
                      ' ProximoComando: '+IntToStr(ProximoComando)+
                      ' TipoCampo: '+IntToStr(TipoCampo)+
                      ' Buffer: '+Mensagem ) ;

            if Result = 10000 then
            begin
              case ProximoComando of
                 0 : RespCliSiTef.GravaInformacao( TipoCampo, Mensagem) ;

                 1 :
                   begin
                     MensagemOperador := Mensagem;
                     DoExibeMsg( opmExibirMsgOperador, MensagemOperador ) ;
                   end ;

                 2 :
                   begin
                     MensagemCliente := Mensagem;
                     DoExibeMsg( opmExibirMsgCliente, MensagemCliente ) ;
                   end;

                 3 :
                   begin
                     MensagemOperador := Mensagem;
                     MensagemCliente  := Mensagem;
                     DoExibeMsg( opmExibirMsgOperador, MensagemOperador ) ;
                     DoExibeMsg( opmExibirMsgCliente, MensagemCliente ) ;
                   end ;

                 4 : CaptionMenu := Mensagem ;

                 11 :
                   begin
                     MensagemOperador := '' ;
                     DoExibeMsg( opmRemoverMsgOperador, '' ) ;
                   end;

                 12 :
                   begin
                     MensagemCliente := '' ;
                     DoExibeMsg( opmRemoverMsgCliente, '' ) ;
                   end;

                 13 :
                   begin
                     DoExibeMsg( opmRemoverMsgOperador, '' ) ;
                     DoExibeMsg( opmRemoverMsgCliente, '' ) ;
                   end ;

                 14 : CaptionMenu := '' ;
                   {Deve limpar o texto utilizado como cabeçalho na apresentação do menu}

                 20 :
                   begin
                     if Mensagem = '' then
                        Mensagem := 'CONFIRMA ?';

                     Resposta := ifThen( (DoExibeMsg( opmYesNo, Mensagem ) = mrYes), '0', '1' ) ;
                     if Resposta = '1' then
                        Continua := -1 ;
                   end ;

                 21 :
                   begin
                     ItensMenu := TStringList.Create;
                     try
                        ItemSelecionado := -1 ;
                        ItensMenu.Text  := StringReplace( Mensagem, ';',
                                                         sLineBreak, [rfReplaceAll] ) ;

                        OnExibeMenu( CaptionMenu, ItensMenu, ItemSelecionado ) ;

                        if (ItemSelecionado >= 0) and (ItemSelecionado < ItensMenu.Count) then
                           Resposta := copy( ItensMenu[ItemSelecionado], 1,
                                             pos(':',ItensMenu[ItemSelecionado])-1 )
                        else
                           Continua := -1 ;
                     finally
                        ItensMenu.Free ;
                     end ;
                   end;

                 22 :
                   begin
                     if Mensagem = '' then
                        Mensagem := 'PRESSIONE <ENTER>';

                     DoExibeMsg( opmOK, Mensagem );
                   end ;

                 23 :
                   begin
                     Interromper := False ;
                     OnAguardaResp( '', 0, Interromper ) ;
                     if Interromper then
                        Continua := -1 ;
                   end;

                 30 :
                   begin
                     OnObtemCampo( Mensagem, TamanhoMinimo, TamanhoMaximo, Resposta ) ;
                     if Resposta = '-1' then
                        Continua := -1 ;
                   end;
              end;
            end;

            if Resposta <> '' then
               StrPCopy(Buffer, Resposta);

         until Result <> 10000;
      finally
        DoExibeMsg( opmRemoverMsgOperador, MensagemOperador ) ;
        DoExibeMsg( opmRemoverMsgCliente, MensagemCliente ) ;
      end;
   end ;
end;

end.


