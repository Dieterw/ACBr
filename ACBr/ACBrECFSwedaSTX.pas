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
|* 25/08/2009:  Daniel Simoes de Almeida
|*   Primeira Versao: Criaçao e Distribuiçao da Primeira Versao
******************************************************************************}

{$I ACBr.inc}

unit ACBrECFSwedaSTX ;

interface
uses ACBrECFClass, ACBrDevice, ACBrUtil, Classes, Contnrs ;

const
   STX  = #02 ;
   ETX  = #03 ;
   ACK  = 06 ;
   NACK = 21 ;
   ESC  = #27 ;
   CFALHAS = 3 ;

type

{ Classe para armazenar Cache de Informações do 34 }
TACBrECFSwedaInfo34 = class
  private
    FSecao: String;
    FDados: AnsiString;
  public
     property Secao : String     read FSecao write FSecao;
     property Dados : AnsiString read FDados write FDados;
end ;

{ Lista de Objetos do tipo TACBrECFSwedaCache }
TACBrECFSwedaCache = class(TObjectList)
  protected
    procedure SetObject (Index: Integer; Item: TACBrECFSwedaInfo34);
    function GetObject (Index: Integer): TACBrECFSwedaInfo34;
    procedure Insert (Index: Integer; Obj: TACBrECFSwedaInfo34);
  public
    function AchaSecao( Secao : String ) : Integer ;
    function Add (Obj: TACBrECFSwedaInfo34): Integer;
    property Objects [Index: Integer]: TACBrECFSwedaInfo34
      read GetObject write SetObject; default;
  end;


{ Classe filha de TACBrECFClass com implementaçao para SwedaSTX }
TACBrECFSwedaSTX = class( TACBrECFClass )
 private
    fsSEQ       : Byte ;
    fsTarefa    : String ;
    fsTipo      : Char ;
    fsMensagem  : String ;
    fsVerProtocolo : String ;
    fsCache34   : TACBrECFSwedaCache ;
    fsRespostasComando : String ;
    fsFalhasRX : Byte ;

    Function PreparaCmd( cmd : AnsiString ) : AnsiString ;
    function CalcCheckSum(cmd: AnsiString): AnsiChar;
    procedure ChangeHandShake(Value: Boolean);
    function DescompactaRetorno(const Dados: AnsiString): AnsiString;
    function DescreveErro(Erro: Integer): String;
    function AjustaRetorno(Retorno: AnsiString): AnsiString;
 protected
    function GetDataHora: TDateTime; override ;
    function GetNumCupom: String; override ;
    function GetNumECF: String; override ;
    function GetNumLoja: String; override ;
    function GetNumSerie: String; override ;
    function GetNumVersao: String; override ;
    function GetSubTotal: Double; override ;
    function GetTotalPago: Double; override ;

    function GetEstado: TACBrECFEstado; override ;
    function GetGavetaAberta: Boolean; override ;
    function GetPoucoPapel : Boolean; override ;
    function GetHorarioVerao: Boolean; override ;
    function GetArredonda: Boolean; override ;
    function GetChequePronto: Boolean; override ;

    function GetCNPJ: String; override ;
    function GetIE: String; override ;
    function GetPAF: String; override ;
    function GetDataMovimento: TDateTime; override ;
    function GetGrandeTotal: Double; override ;
    function GetNumCRO: String; override ;
    function GetNumCCF: String; override ;
    function GetNumGNF: String; override ;
    function GetNumGRG: String; override ;
    function GetNumCDC: String; override ;
    function GetNumCRZ: String; override ;
    function GetVendaBruta: Double; override ;
    function GetTotalAcrescimos: Double; override ;
    function GetTotalCancelamentos: Double; override ;
    function GetTotalDescontos: Double; override ;
    function GetTotalSubstituicaoTributaria: Double; override ;
    function GetTotalNaoTributado: Double; override ;
    function GetTotalIsencao: Double; override ;
    function GetNumCOOInicial: String; override ;
    function GetNumUltimoItem: Integer; override ;

    function GetDadosUltimaReducaoZ: AnsiString; override ;

    Function VerificaFimLeitura(var Retorno: AnsiString;
       var TempoLimite: TDateTime) : Boolean ; override ;
    function VerificaFimImpressao(var TempoLimite: TDateTime) : Boolean ; override ;

 public
    Constructor create( AOwner : TComponent  )  ;
    Destructor Destroy  ; override ;

    procedure Ativar ; override ;

    Function EnviaComando_ECF( cmd : AnsiString ) : AnsiString ; override ;

    Procedure AbreCupom ; override ;
    Procedure VendeItem( Codigo, Descricao : String; AliquotaECF : String;
       Qtd : Double ; ValorUnitario : Double; ValorDescontoAcrescimo : Double = 0;
       Unidade : String = ''; TipoDescontoAcrescimo : String = '%';
       DescontoAcrescimo : String = 'D' ) ; override ;
    Procedure SubtotalizaCupom( DescontoAcrescimo : Double = 0;
       MensagemRodape : AnsiString  = '') ; override ;
    Procedure EfetuaPagamento( CodFormaPagto : String; Valor : Double;
       Observacao : AnsiString = ''; ImprimeVinculado : Boolean = false) ;
       override ;
    Procedure FechaCupom( Observacao : AnsiString = ''; IndiceBMP : Integer = 0) ; override ;
    Procedure CancelaCupom ; override ;
    Procedure CancelaItemVendido( NumItem : Integer ) ; override ;

    { Procedimentos de Cupom Não Fiscal }
    Procedure NaoFiscalCompleto( CodCNF : String; Valor : Double;
       CodFormaPagto  : String; Obs : AnsiString; IndiceBMP : Integer = 0) ; override ;
    Procedure AbreNaoFiscal( CPF_CNPJ : String = '') ; override ;
    Procedure RegistraItemNaoFiscal( CodCNF : String; Valor : Double;
       Obs : AnsiString = '') ; override ;
    Procedure SubtotalizaNaoFiscal( DescontoAcrescimo : Double = 0;
       MensagemRodape: AnsiString = '') ; override ;
    Procedure EfetuaPagamentoNaoFiscal( CodFormaPagto : String; Valor : Double;
       Observacao : AnsiString = ''; ImprimeVinculado : Boolean = false) ; override ;
    Procedure FechaNaoFiscal( Observacao : AnsiString = ''; IndiceBMP : Integer = 0) ; override ;
    Procedure CancelaNaoFiscal ; override ;

    Procedure LeituraX ; override ;
    Procedure LeituraXSerial( var Linhas : TStringList) ; override ;
    Procedure ReducaoZ(DataHora : TDateTime = 0 ) ; override ;
    Procedure AbreRelatorioGerencial(Indice: Integer = 0) ; override ;
    Procedure LinhaRelatorioGerencial( Linha : AnsiString; IndiceBMP: Integer = 0 ) ; override ;
    Procedure AbreCupomVinculado(COO, CodFormaPagto, CodComprovanteNaoFiscal :
       String; Valor : Double) ; override ;
    Procedure LinhaCupomVinculado( Linha : AnsiString ) ; override ;
    Procedure FechaRelatorio ; override ;

    Procedure ImprimeCheque(Banco : String; Valor : Double ; Favorecido,
       Cidade : String; Data : TDateTime ;Observacao : String = '') ; override ;
    Procedure CancelaImpressaoCheque ; override ;

    Procedure MudaHorarioVerao  ; overload ; override ;
    Procedure MudaHorarioVerao( EHorarioVerao : Boolean ) ; overload ; override ;
    Procedure CorrigeEstadoErro(Reducao: Boolean = True) ; override ;
    Procedure ImpactoAgulhas( NivelForca : Integer = 2) ; override ;
    Procedure LeituraMemoriaFiscal( DataInicial, DataFinal : TDateTime;
       Simplificada : Boolean = False ) ; override ;
    Procedure LeituraMemoriaFiscal( ReducaoInicial, ReducaoFinal : Integer;
       Simplificada : Boolean = False ); override ;
    Procedure LeituraMemoriaFiscalSerial( DataInicial, DataFinal : TDateTime;
       var Linhas : TStringList; Simplificada : Boolean = False ) ; override ;
    Procedure LeituraMemoriaFiscalSerial( ReducaoInicial, ReducaoFinal : Integer;
       var Linhas : TStringList; Simplificada : Boolean = False ) ; override ;
    Procedure IdentificaPAF( Linha1, Linha2 : String) ; override ;
    Function RetornaInfoECF( Registrador: String) : AnsiString; override ;

    Procedure AbreGaveta ; override ;

    procedure CarregaAliquotas ; override ;
    procedure LerTotaisAliquota ; override ;
    Procedure ProgramaAliquota( Aliquota : Double; Tipo : Char = 'T';
       Posicao : String = '') ; override ;
    function AchaICMSAliquota( var AliquotaICMS: String ):
       TACBrECFAliquota; override ;

    procedure CarregaFormasPagamento ; override ;
    procedure LerTotaisFormaPagamento ; override ;
    Procedure ProgramaFormaPagamento( var Descricao: String;
       PermiteVinculado : Boolean = true; Posicao : String = '' ) ; override ;
    procedure CarregaRelatoriosGerenciais ; override ;
    Procedure ProgramaRelatorioGerencial( var Descricao: String;
       Posicao : String = '') ; override ;

    procedure CarregaComprovantesNaoFiscais ; override ;
    procedure LerTotaisComprovanteNaoFiscal ; override ;
    Procedure ProgramaComprovanteNaoFiscal( var Descricao: String;
       Tipo : String = ''; Posicao : String = '') ; override ;

    Procedure CortaPapel( const CorteParcial : Boolean = false) ; override ;
 end ;

implementation
Uses ACBrECF,
     SysUtils,
   {$IFDEF COMPILER6_UP} DateUtils, StrUtils, {$ELSE} ACBrD5, Windows,{$ENDIF}
     Math , synaser;

{ --------------------------- TACBrECFSwedaCache ---------------------------- } 
function TACBrECFSwedaCache.AchaSecao(Secao: String): Integer;
Var I : Integer ;
begin
  I := 0 ;
  Result := -1 ;
  while (Result < 0) and (I < Count) do
  begin
    if Secao = Objects[I].Secao then
       Result := I ;

    Inc( I ) ;
  end ;
end;

function TACBrECFSwedaCache.Add(Obj: TACBrECFSwedaInfo34): Integer;
begin
  Result := inherited Add(Obj) ;
end;

function TACBrECFSwedaCache.GetObject(Index: Integer): TACBrECFSwedaInfo34;
begin
  Result := inherited GetItem(Index) as TACBrECFSwedaInfo34 ;
end;

procedure TACBrECFSwedaCache.Insert(Index: Integer;
  Obj: TACBrECFSwedaInfo34);
begin
  inherited Insert(Index, Obj);
end;

procedure TACBrECFSwedaCache.SetObject(Index: Integer;
  Item: TACBrECFSwedaInfo34);
begin
  inherited SetItem (Index, Item) ;
end;


{ ----------------------------- TACBrECFSwedaSTX ------------------------------ }

constructor TACBrECFSwedaSTX.create( AOwner : TComponent ) ;
begin
  inherited create( AOwner ) ;

  fpDevice.HandShake := hsDTR_DSR ;
  { Variaveis internas dessa classe }
  fsVerProtocolo := '' ;
  fsCache34   := TACBrECFSwedaCache.create( True );
  fsSEQ       := 42 ;
  fsRespostasComando := '' ;
  fsFalhasRX         := 0 ;
  
  fpModeloStr := 'SwedaSTX' ;
  fpRFDID     := 'SW' ;
end;

destructor TACBrECFSwedaSTX.Destroy;
begin
  fsCache34.Free ;
   
  inherited Destroy ;
end;

procedure TACBrECFSwedaSTX.Ativar;
begin
  if not fpDevice.IsSerialPort  then
     raise Exception.Create('A impressora: '+ModeloStr+' requer'+sLineBreak+
                            'Porta Serial:  (COM1, COM2, COM3, ...)');

  fpDevice.HandShake := hsDTR_DSR ;
  inherited Ativar ; { Abre porta serial }

  fsVerProtocolo := '' ;
  fpMFD       := True ;
  fpTermica   := True ;
  fsCache34.Clear ;
  fsRespostasComando := '' ;
  fsFalhasRX         := 0 ;

  try
     { Testando a comunicaçao com a porta }
     fsVerProtocolo := Trim(copy( RetornaInfoECF( 'I1' ), 82, 1)) ;

     if fsVerProtocolo = '' then
        raise EACBrECFNaoInicializado.Create(
                 'Erro inicializando a impressora '+ModeloStr );
  except
     Desativar ;
     raise ;
  end ;
end;

Procedure TACBrECFSwedaSTX.ChangeHandShake( Value : Boolean )  ;
begin
  if fpDevice.HandShake = hsDTR_DSR then
     fpDevice.Serial.DTR := Value ;

  if fpDevice.HandShake = hsRTS_CTS then
     fpDevice.Serial.RTS := Value ;
end ;


Function TACBrECFSwedaSTX.EnviaComando_ECF( cmd : AnsiString ) : AnsiString ;
Var ErroMsg  : String ;
    FalhasTX : Integer;
    ACK_ECF  : Byte ;
begin
   Result             := '' ;
   fpComandoEnviado   := '' ;
   fpRespostaComando  := '' ;
   fsRespostasComando := '' ;
   fsFalhasRX         := 0 ;
   fsTarefa           := '' ;
   fsTipo             := #0 ;
   fsMensagem         := '' ;

   { Codificando CMD de acordo com o protocolo da SwedaSTX }
   cmd := PreparaCmd( cmd ) ;

   ACK_ECF  := 0 ;
   FalhasTX := 0 ;

   while (ACK_ECF <> ACK) do
   begin
      fpDevice.Serial.DeadlockTimeout := 2000 ; { Timeout p/ Envio }
      fpDevice.Serial.Purge ;                   { Limpa a Porta }
      ChangeHandShake(False);            { Desliga o DTR ou RTS para enviar }

      if not TransmiteComando( cmd ) then
         continue ;

      try
         { espera ACK chegar na Porta por 7s }
         try
            ACK_ECF := fpDevice.Serial.RecvByte( 7000 ) ;
         except
         end ;

         if ACK_ECF = 0 then
            raise EACBrECFSemResposta.create(
                     'Impressora '+ModeloStr+' não responde (ACK = 0)')
         else if ACK_ECF = 21 then    { retorno em caracter 21d=15h=NAK }
            raise EACBrECFSemResposta.create(
                  'Impressora '+ModeloStr+' não reconheceu o Comando'+
                  sLineBreak+' (ACK = 21). Falha: '+IntToStr(FalhasTX))
         else if ACK_ECF <> 6 then
            raise EACBrECFSemResposta.create(
                  'Erro. Resposta da Impressora '+ModeloStr+' inválida'+
                  sLineBreak+' (ACK = '+IntToStr(ACK)+')') ;
      except
         on E : EACBrECFSemResposta do
          begin
            fpDevice.Serial.Purge ;

            Inc( FalhasTX ) ;
            if FalhasTX < CFALHAS then
               Sleep(100)
            else
               if not DoOnMsgRetentar( E.Message +sLineBreak+sLineBreak+
                  'Se o problema persistir, verifique os cabos, ou'+sLineBreak+
                  'experimente desligar a impressora durante 5 seg,'+sLineBreak+
                  'liga-la novamente, e repetir a operação...'
                  , 'LerACK') then
                  raise ;
          end ;
         else
            raise ;
      end ;
   end ;

   fpComandoEnviado := cmd ;

   ChangeHandShake(True);     { Liga o DTR ou RTS para ler a Resposta }

   { Chama Rotina da Classe mãe TACBrClass para ler Resposta. Se houver
     falha na leitura LeResposta dispara Exceçao.
     Resposta fica gravada na váriavel "fpRespostaComando" }
   LeResposta ;

   fpRespostaComando := fsRespostasComando ;   // Respostas Acumuladas
   
   { Limpando de "fpRespostaComando" os Status não solicitados }
   fpRespostaComando := AjustaRetorno( fpRespostaComando  );

   if (fsTarefa <> '34') then
      fsCache34.Clear ;         // Limpa o Cache do 34

   ErroMsg := DescreveErro( StrToIntDef(fsMensagem,-1) ) ;

   if ErroMsg <> '' then
    begin
      ErroMsg := 'Erro retornado pela Impressora: '+ModeloStr+
                 sLineBreak+sLineBreak+
                 'Erro ('+fsMensagem+') '+ErroMsg ;
      raise EACBrECFSemResposta.create(ErroMsg) ;
    end
   else
      Sleep( IntervaloAposComando ) ;  { Pequena pausa entre comandos }

   { Descompactando Strings dentro do Retorno }
   Result := DescompactaRetorno( fpRespostaComando ) ;
end;

function TACBrECFSwedaSTX.DescreveErro( Erro : Integer ) : String ;
begin
  Result := '' ;

  case Erro of
     -1 : Result := 'Erro na Interpretação da Resposta do ECF' ;
      0 : Result := '' ;

    002 : Result := 'Documento já Cancelado' ;
    003 : Result := 'Documento já foi Totalmente Pago' ;
    004 : Result := 'Documento ainda não foi Totalmente Pago' ;
    005 : Result := 'Documento já foi Totalizado' ;
    006 : Result := 'Item Inválido' ;
    007 : Result := 'Item Cancelado' ;
    008 : Result := 'Total apurado igual a Zero' ;
    009 : Result := 'Acréscimo já aplicado sobre este Item' ;
    010 : Result := 'Não há Acréscimo sobre este Item' ;
    011 : Result := 'Desconto já aplicado sobre este Item' ;
    012 : Result := 'Não há Desconto sobre este Item' ;
    013 : Result := 'Valor de Desconto superior ao Total do Item' ;
    014 : Result := 'Acréscimo já aplicado em Subtotal' ;
    015 : Result := 'Não há Acréscimo aplicado no Subtotal' ;
    016 : Result := 'Desconto já aplicado em Subtotal' ;
    017 : Result := 'Não há Desconto aplicado no Subtotal' ;
    018 : Result := 'Valor de Desconto superior ao Total do Documento' ;
    019 : Result := 'Meio de Pagamento não programado' ;
    020 : Result := 'Atingido Limite de Itens por Cupom' ;
    021 : Result := 'Alíquota de Imposto não programada' ;
    022 : Result := 'Alteração de Estilo de Fonte não permitida nesse comando' ;
    023 : Result := 'Erro na Sintaxe do Comando Enviado' ;
    025 : Result := 'Informado Valor Nulo' ;
    027 : Result := 'Data com formato inválido' ;
    028 : Result := 'Hora com formato inválido' ;
    029 : Result := 'Comando não reconhecido' ;
    030 : Result := 'Tabela Cheia' ;
    031 : Result := 'Faixa Informada é Inválida' ;
    032 : Result := 'Tentativa de registro em um mesmo comprovante de '+
                     'operações não fiscais cadastradas com sinais distintos' ;
    033 : Result := 'Informado Sinal Inválido' ;
    034 : Result := 'Excedida capacidade de pagamento por meio de CCD' ;
    035 : Result := 'Operação de TEF informada pelo comando de abertura do comprovante não encontrada' ;
    036 : Result := 'Classificação do meio de pagamento inválida' ;
    037 : Result := 'Título informado na abertura de Relatório Gerencial não encontrado' ;
    040 : Result := 'Mensagem: Abertura do Movimento' ;
    041 : Result := 'Denominação informada no Registro de Operação não fiscal não encontrada ' ;
    042 : Result := 'Valor total do Item excedido' ;
    043 : Result := 'Valor do estorno excede a soma dos pagamentos registrados no meio indicado' ;
    044 : Result := 'Valor efetivado é insuficiente para o pagamento!' ;
    050 : Result := 'Campo de Descrição não informado' ;

// TODO: completar DEscrição dos Erros

    124 : Result := 'Tampa Aberta' ;
    125 : Result := 'Sem Papel' ;
    126 : Result := 'Avançando Papel' ;
    127 : Result := 'Substituir Bobina' ;
    193 : Result := 'Falha de comunicação na transmissão das informações' ;
    24,38,39,45..47,65,66,69..73,75..79,81..86,88..91,97,100..102,106,118,119,
    129,137,138,145..147,150,152..155,158,173..183,185,186,188..191,199,210,
    219,221,225,230,235..237,241,242,244..248
        : Result := 'Chamar Assistência Técnica' ;
  else
    Result := 'Consulte o manual' ;
  end ;
end ;

function TACBrECFSwedaSTX.VerificaFimLeitura(var Retorno: AnsiString;
   var TempoLimite: TDateTime) : Boolean ;
Var
  LenRet, PosETX, PosSTX : Integer ;
  Bloco : AnsiString ;
  Sequencia, ACK_PC : Byte ;
begin
  LenRet := Length(Retorno) ;
  Result := False ;

  if LenRet < 5 then
     exit ;

  PosSTX := Pos(STX,Retorno);
  if PosSTX < 1 then     // Não recebeu o STX
     exit
  else if PosSTX > 1 then
     Retorno := copy(Retorno, PosSTX, Length(Retorno) ) ;  // STX deve estar no inicio.

  PosETX := Pos(ETX, Retorno) ;
  if PosETX < 1 then    // Não recebeu ETX
     exit ;

  if (LenRet = PosETX) then  // Sem CHK
     exit ;

  { Ok, temos um bloco completo... Vamos trata-lo}
  Bloco := copy(Retorno, 1, PosETX+1) ;

  Sequencia  := Ord( Bloco[2] ) ;
  fsTarefa   := copy(Bloco,3,2) ;
  fsTipo     := Bloco[5] ;
  fsMensagem := copy(Bloco,6,4) ;

  if fsTipo = '!' then  // Bloco de Satus não solicitado, Descartando
     Retorno := '' 
  else
   begin
     { Verificando a Sequencia }
     if Sequencia <> fsSEQ then
        raise Exception.Create('Sequencia de Resposta diferente da enviada') ;

     { Verificando o CheckSum }
     ACK_PC := ACK ;

     if CalcCheckSum(LeftStr(Bloco,Length(Bloco)-1)) <> RightStr(Bloco,1) then
     begin
       ACK_PC := NACK ;  // Erro no CheckSum, retornar NACK
       if fsFalhasRX > CFALHAS then
          raise Exception( 'Erro no digito Verificador da Resposta.'+sLineBreak+
                           'Falha: '+IntToStr(fsFalhasRX) ) ;
       Inc( fsFalhasRX ) ;  // Incrementa numero de Falhas
       Retorno := '' ;      // Descarta o Bloco
     end ;

     ChangeHandShake(False);            { Desliga o DTR ou RTS para enviar }
     fpDevice.Serial.SendByte(ACK_PC);

     fsRespostasComando := fsRespostasComando + Retorno ;  // Salva este Bloco

     if (ACK_PC = ACK) and ( not (fsTipo in ['+','-'])) then   // Não é o Ultimo Bloco ?
        Retorno := '' ;             // Zera para Ler proximo Bloco
   end ;

  Result := (Retorno <> '')
end;

function TACBrECFSwedaSTX.VerificaFimImpressao(var TempoLimite: TDateTime): Boolean;
Var Cmd, Ret, RetCmd : AnsiString ;
    wACK : Byte ;
    I : Integer ;
begin
  { Essa função só é chamada se AguardaImpressao = True,
    Como essa função é executada dentro da "LeResposta", que por sua vez foi
    chamada por "EnviaComando", não podemos usar o método "EnviaComando" (ou
    teriamos uma chamada recursiva infinita), por isso o Loop abaixo envia o
    comando '34' diretamente para a Serial, e aguarda por 5 segundos a resposta...
    Se a SwedaSTX conseguir responder, significa que a Impressão Terminou }
  Result := false ;
  
  if not EmLinha() then
   begin
     Sleep(100) ;
     GravaLog('SwedaSTX VerificaFimImpressao: ECF fora de linha') ;
   end
  else
   begin
     RetCmd := '' ;
     Cmd    := PreparaCmd( '34' ) ;           // Pede Status //

     try
        GravaLog('SwedaSTX VerificaFimImpressao: Pedindo o Status') ;

        fpDevice.Serial.Purge ;          // Limpa buffer de Entrada e Saida //
        ChangeHandShake(False);          // DesLiga o DTR para enviar //
        fpDevice.EnviaString( Cmd );     // Envia comando //

        ChangeHandShake(True);           // Liga o DTR para receber //
        wACK := fpDevice.Serial.RecvByte( 2000 ) ; // espera ACK chegar na Porta por 2s //

        if wACK = 6 then   // ECF Respondeu corretamente, portanto está trabalhando //
        begin
           GravaLog('SwedaSTX VerificaFimImpressao: ACK = 6, OK... Aguardando ETX') ;

           // Aguarda por ETX  até 5 seg //
           I := 0 ;
           repeat
              TempoLimite := IncSecond(now, TimeOut);
              Ret := fpDevice.Serial.RecvPacket(100) ;

              RetCmd := RetCmd + Ret ;
              Inc( I ) ;
           until (I > 50) or ( VerificaFimLeitura( RetCmd, TempoLimite) )  ;

           Result := VerificaFimLeitura( RetCmd, TempoLimite) and
                     (copy(RetCmd,11,1) = 'A') ;
        end ;
     except
     end ;
   end ;
end;

Function TACBrECFSwedaSTX.PreparaCmd( cmd : AnsiString ) : AnsiString ;
begin
  Result := '' ;

  if cmd = '' then exit ;

  Inc(fsSEQ) ;
  if fsSEQ = 255 then
     fsSEQ := 43 ;

  cmd := STX + AnsiChar(chr( fsSEQ )) + cmd + ETX ;   { Prefixo ESC }

  Result := cmd + CalcCheckSum( cmd ) ;
end ;

Function TACBrECFSwedaSTX.CalcCheckSum( cmd : AnsiString ) : AnsiChar ;
Var A, iSoma, LenCmd, CheckSum : Integer ;
begin
  { Calculando a Soma dos caracteres ASC }
  LenCmd := Length( cmd ) ;
  iSoma := 0 ;
  For A := 1 to LenCmd do
     iSoma := iSoma + ord( cmd[A] ) ;

  { Calculando o digito verificado }
  CheckSum := iSoma mod 256 ;

  Result := AnsiChar( Chr( CheckSum ) ) ;
end ;

{ Remove Blocos de Resposta de Status não solicitados  (envio automático pelo ECF)}
Function TACBrECFSwedaSTX.AjustaRetorno(Retorno: AnsiString) : AnsiString ;
Var
  LenRet, PosETX, PosSTX : Integer ;
  Bloco, Tipo : AnsiString ;
begin
  LenRet := Length(Retorno) ;
  Result := Retorno ;

  if LenRet < 5 then
     exit ;

  PosSTX := Pos(STX,Result);
  if PosSTX < 1 then
     Result := ''               // Não recebeu o STX, invalida Retorno
  else if PosSTX > 1 then
     Result := copy(Result, PosSTX, Length(Result) ) ;  // Deve iniciar em STX

  while PosSTX > 0 do
  begin
     PosETX := PosEx(ETX, Result, PosSTX ) ;
     if PosETX < 1 then          // Ainda não recebeu o ETX final
        break ;

     Bloco := copy(Result, PosSTX, PosETX-PosSTX + 2  ) ;  // Pega um Bloco; +2 para pegar CHK
     Tipo  := copy(Bloco,5,1) ;

     if Tipo = '!' then  // Bloco de Status nao solicitado, excluindo
     begin
        Delete(Result, PosSTX, PosETX-PosSTX + 2 ) ;
        PosETX := max(PosSTX - 2,0) ; 
     end ;

     PosSTX := PosEx( STX , Result, PosETX);
  end ;
end ;

function TACBrECFSwedaSTX.DescompactaRetorno( const Dados : AnsiString ) : AnsiString ;
Var P      : Integer ;
    AChar  : Char ;
    NTimes : Byte ;
begin
   Result := Dados ;

   P := pos(ESC, Result) ;
   while P > 0 do
   begin
      AChar  := copy( Result, P-1, 1)[1] ;
      NTimes := ord( copy( Result, P+1, 1)[1] ) - 31 ;

      Result := StuffString(Result, P, 2, StringOfChar(AChar,NTimes) ) ;

      P := pos( ESC, Result) ;
   end ;
end ;




function TACBrECFSwedaSTX.GetDataHora: TDateTime;
Var RetCmd : AnsiString ;
    OldShortDateFormat : String ;
begin
  RetCmd := Trim(RetornaInfoECF( 'I8' )) ;
  OldShortDateFormat := ShortDateFormat ;
  try
     ShortDateFormat := 'dd/mm/yyyy' ;
     result := StrToDate(copy(RetCmd, 1,10)) ;
  finally
     ShortDateFormat := OldShortDateFormat ;
  end ;
  result := RecodeHour(  result,StrToInt(copy(RetCmd,12,2))) ;
  result := RecodeMinute(result,StrToInt(copy(RetCmd,15,2))) ;
  result := RecodeSecond(result,StrToInt(copy(RetCmd,18,2))) ;
end;

function TACBrECFSwedaSTX.GetNumCupom: String;
begin
  Result := Trim(copy( RetornaInfoECF( 'A4' ), 33, 6)) ;
end;

function TACBrECFSwedaSTX.GetNumCRO: String;
begin
  Result := Trim(copy( RetornaInfoECF( 'A4' ), 1, 4)) ;
end;

function TACBrECFSwedaSTX.GetNumCCF: String;
begin
  Result := Trim(copy( RetornaInfoECF( 'A4' ), 21, 6)) ;
end;

function TACBrECFSwedaSTX.GetNumLoja: String;
begin
  Result := Trim(copy( RetornaInfoECF( 'H2' ), 1, 5)) ;
end;

function TACBrECFSwedaSTX.GetNumECF: String;
begin
  Result := Trim(copy( RetornaInfoECF( 'H2' ), 6, 4)) ;
end;

function TACBrECFSwedaSTX.GetNumSerie: String;
begin
  Result := Trim(copy( RetornaInfoECF( 'I1' ), 51, 22)) ;
end;

function TACBrECFSwedaSTX.GetNumVersao: String ;
begin
  Result := Trim(copy( RetornaInfoECF( 'I1' ), 73, 9)) ;
end;

function TACBrECFSwedaSTX.GetTotalPago: Double;
begin
  Result := StrToFloatDef( Trim(copy( RetornaInfoECF( 'L1' ), 52, 13)),0)/100 ;
end;

function TACBrECFSwedaSTX.GetSubTotal: Double;
begin
  Result := StrToFloatDef( Trim(copy( RetornaInfoECF( 'L1' ), 26, 13)),0)/100 ;
end;

{  Ordem de Retorno do Estado da Impressora
   estNaoInicializada - Não Inicializada (Nova)
   estDesconhecido    - Desconhecido
   estPagamento       - Cupom Venda Aberto em Pagamento
   estVenda           - Cupom Venda Aberto em Itens
   estNaoFiscal       - Cupom Não Fiscal Aberto
   estRelatorio       - Cupom Vinculado Aberto | Relatório Gerencial Aberto
   estBloqueada       - Impressora Bloqueada para venda
   estRequerZ         - Requer Emissão da Redução da Z
   estRequerX         - Requer Leitura X
   estLivre           - Livre para vender
}
function TACBrECFSwedaSTX.GetEstado: TACBrECFEstado;
Var RetCmd : AnsiString ;
    Estado, Docto : Char ;
    Sinalizadores, BinStr, FaseEmissao : String ;
begin
  Result := fpEstado ;  // Suprimir Warning
  try
    fpEstado := estNaoInicializada ;
    if (not fpAtivo) then
      exit ;

    fpEstado := estDesconhecido ;

    RetCmd := EnviaComando( '34' ) ;
    if (copy(RetCmd,3,2) <> '34') or (Length(RetCmd) < 18) then
       exit ;         // Retorno inválido

    Estado := RetCmd[10] ;
    Docto  := RetCmd[11] ;
    Sinalizadores := copy(RetCmd,12,5) ;

    case Estado of
      'A' :
        begin
          case Docto of
             'A' :
               begin
                 if TestBit( Ord(Sinalizadores[1]), 1 ) then
                    fpEstado := estRequerX
                 else
                   fpEstado := estLivre ;
               end ;
             
             'C' :
               begin
                 BinStr      := IntToBin( Ord(Sinalizadores[2]), 8 ) ;
                 FaseEmissao := copy(BinStr,4,3) ;

                 if FaseEmissao = '010' then
                   fpEstado := estPagamento
                 else if FaseEmissao = '001' then
                   fpEstado := estVenda ;
               end ;

             'D' : fpEstado := estNaoFiscal ;

             'E','G','I' : fpEstado := estRelatorio ;
          end ;
        end ;

      'B' : fpEstado := estBloqueada ;
        
      'C' : fpEstado := estRequerZ ;
    end ;
  finally
    Result := fpEstado ;
  end ;
end;

function TACBrECFSwedaSTX.GetGavetaAberta: Boolean;
Var RetCmd : AnsiString ;
begin
  Result := False ;
  RetCmd := EnviaComando( '34' ) ;
  if (copy(RetCmd,3,2) <> '34') or (Length(RetCmd) < 18) then
     Result := TestBit( Ord(RetCmd[12]), 2 ) ;
end;

function TACBrECFSwedaSTX.GetPoucoPapel: Boolean;
Var RetCmd : AnsiString ;
begin
  Result := False ;
  RetCmd := EnviaComando( '34' ) ;
  if (copy(RetCmd,3,2) <> '34') or (Length(RetCmd) < 18) then
     Result := TestBit( Ord(RetCmd[12]), 5 ) ;
end;

function TACBrECFSwedaSTX.GetHorarioVerao: Boolean;
Var RetCmd : AnsiString ;
begin
  RetCmd := Trim(RetornaInfoECF( 'I8' )) ;
  Result := (UpperCase( copy(RetCmd,20,1) ) = 'V') ;
end;

function TACBrECFSwedaSTX.GetArredonda: Boolean;
begin
  Result := (fsVerProtocolo > 'D') ;
end;

Procedure TACBrECFSwedaSTX.LeituraX ;
begin
  AguardaImpressao := True ;
  EnviaComando( '15' ) ;
end;

procedure TACBrECFSwedaSTX.LeituraXSerial(var Linhas: TStringList);
begin
end;

Procedure TACBrECFSwedaSTX.AbreGaveta ;
begin
  EnviaComando( '11' ) ;
end;

Procedure TACBrECFSwedaSTX.ReducaoZ(DataHora: TDateTime) ;
Var Cmd : String ;
begin
  Cmd := '16' ;
  if DataHora <> 0 then
     Cmd := Cmd + '|' + FormatDateTime('dd"/"mm"/"yyyy',DataHora) +
                  '|' + FormatDateTime('hh":"nn":"ss',DataHora) ;

  EnviaComando( Cmd ) ;
end;

Procedure TACBrECFSwedaSTX.MudaHorarioVerao ;
begin
end;

procedure TACBrECFSwedaSTX.MudaHorarioVerao(EHorarioVerao: Boolean);
begin
  if EHorarioVerao <> HorarioVerao then
     MudaHorarioVerao ;
end;


procedure TACBrECFSwedaSTX.AbreCupom  ;
Var StrConsumidor : String ;
begin
  StrConsumidor := '' ;
  if Trim(Consumidor.Documento) <> '' then    { Tem Docto ? }
  begin
     StrConsumidor := padL(Consumidor.Documento ,29) ;

        if Trim(Consumidor.Nome) <> '' then      { Tem Nome ? }
        begin
           StrConsumidor := StrConsumidor + padL(Consumidor.Nome ,30) ;

           if Trim(Consumidor.Endereco) <> '' then  { Tem endereço ? }
              StrConsumidor := StrConsumidor + padL(Consumidor.Endereco ,80) ;
        end ;
  end ;


  fpUltimaMsgPoucoPapel := 0 ;  { Zera tempo pra msg de pouco papel }
  AguardaImpressao := True ;
  EnviaComando( #00 + StrConsumidor, 10) ;

  Consumidor.Enviado := ( StrConsumidor <> '' ) ;
end;

procedure TACBrECFSwedaSTX.CancelaCupom;
 Var RetCmd : AnsiString ;
     B      : Byte ;
     TemRel : Boolean ;
begin
  RetCmd := EnviaComando( #35+#17 ) ;
  try B := ord( RetCmd[1] ) except B := 0 end ;

  if not TestBit(B, 5) then         { Não Permite cancelar cupom fiscal ?? }
  begin
        { Vamos verificar se o último documento é Vinculado (CDC) }
        try
           RetCmd := EnviaComando( #35+#65 ) ;
           B := ord( RetCmd[1] )
        except
           B := 0
        end ;

        if TestBit(B, 6) then             // Pode cancelar CDC ?
        begin
           try
              AguardaImpressao := True ;
              EnviaComando( #102 , 5) ;   // Cancelando o CDC
           except
           end ;
        end ;
  end ;

  AguardaImpressao := True ;
  EnviaComando( #14 , 15) ;

  if fpMFD then
     TemRel := (Estado = estRelatorio)  // MFD sinaliza estado Relatorio //
  else
     TemRel := True ;                   // Nao MFD não há flag para sinalizar Relatorio Aberto

  if TemRel then
  begin
     try
       FechaRelatorio ;   { Fecha relatorio se ficou algum aberto (só por garantia)}
     except   // Exceçao silenciosa, pois a Impressora pode nao estar em Estado
     end ;    // de Relatorio.
  end ;
end;

procedure TACBrECFSwedaSTX.CancelaItemVendido(NumItem: Integer);
begin
  EnviaComando( #31 + IntToStrZero(NumItem ,4) ) ;
end;

procedure TACBrECFSwedaSTX.EfetuaPagamento(CodFormaPagto: String;
  Valor: Double; Observacao: AnsiString; ImprimeVinculado: Boolean);
begin
  Observacao := copy(Observacao,1,80) ;
  EnviaComando( #72 + CodFormaPagto +
                IntToStrZero( Round(Valor * 100) ,14) +
                Observacao ) ;
end;

procedure TACBrECFSwedaSTX.FechaCupom(Observacao: AnsiString; IndiceBMP : Integer);
begin
  Observacao := TrimRight( Observacao ) ;
  if Copy( Observacao, length( Observacao ), 1) <> #10 then
     Observacao := Observacao + #10 ;

  Observacao := copy(Observacao,1, 492) ; 
  AguardaImpressao := True ;
  EnviaComando( #34 + Observacao, 15 ) ;
end;

procedure TACBrECFSwedaSTX.SubtotalizaCupom(DescontoAcrescimo: Double;
       MensagemRodape : AnsiString);
Var A_D : Char ;
begin
  if DescontoAcrescimo < 0 then
     A_D := 'd'
  else
     A_D := 'a' ;

  DescontoAcrescimo := abs(DescontoAcrescimo) ;

  { Inicia fechamento com formas de Pagamento }
  EnviaComando( #32 + A_D +
                IntToStrZero( Round( DescontoAcrescimo * 100),14) );
end;

Procedure TACBrECFSwedaSTX.VendeItem( Codigo, Descricao : String;
  AliquotaECF : String; Qtd : Double ; ValorUnitario : Double;
  ValorDescontoAcrescimo : Double; Unidade : String;
  TipoDescontoAcrescimo : String; DescontoAcrescimo : String) ;
Var QtdStr, ValorStr, AcrescimoStr, DescontoStr : String ;
    CMD : Byte ;
begin
  if Qtd > 9999 then
     raise EACBrECFCMDInvalido.Create(
           'Quantidade deve ser inferior a 9999.');

  Descricao := trim(Descricao) ;
  Unidade   := padL(Unidade,2) ;

  if (DescontoAcrescimo <> 'D') and (ValorDescontoAcrescimo > 0) then   // Tem acrescimo ?
   begin
     Codigo      := Trim(Codigo) + #0 ;
     Descricao   := Descricao + #0 ;
     ValorStr    := IntToStrZero( Round( ValorUnitario * 1000), 9) ;
     QtdStr      := IntToStrZero( Round( Qtd * 1000), 7) ;
     AcrescimoStr:= StringOfChar('0',10) ;

     if TipoDescontoAcrescimo='%' then
        DescontoStr := IntToStrZero( Round( RoundTo(ValorUnitario*Qtd,-2) *
                                     ValorDescontoAcrescimo), 10 )
     else
        DescontoStr := IntToStrZero(Round(ValorDescontoAcrescimo*100),10);

     if DescontoAcrescimo <> 'D' then // É acrescimo ?
     begin
        AcrescimoStr := DescontoStr ;
        DescontoStr  := StringOfChar('0',10) ;
     end ;

     EnviaComando(#63 + AliquotaECF + ValorStr + QtdStr + DescontoStr +
                        AcrescimoStr + StringofChar('0',22) + Unidade + Codigo +
                        Descricao ) ;
   end
  else
   begin
     Codigo := padL(Codigo,13) ;  
     if Round( Qtd ) = Qtd then
        QtdStr := IntToStrZero( Round( Qtd ), 4)
     else
        QtdStr := IntToStrZero( Round(Qtd * 1000), 7) ;

     if RoundTo( ValorUnitario, -2 ) = ValorUnitario then
      begin
        ValorStr := IntToStrZero( Round(ValorUnitario * 100), 8) ;
        CMD := 09 ;
      end
     else
      begin
        ValorStr := IntToStrZero( Round(ValorUnitario * 1000), 8) ;
        CMD := 56 ;
      end ;

     if TipoDescontoAcrescimo='%' then
        DescontoStr := IntToStrZero( Round(ValorDescontoAcrescimo * 100), 4)
      else
        DescontoStr := IntToStrZero( Round(ValorDescontoAcrescimo * 100), 8) ;

     if ( StrToIntDef( NumVersao,0 ) >= 300) and (Trim(Unidade) <> '') then
     begin
        EnviaComando( #62+#51 + Unidade ) ;            { Programando a UN }
     end ;

     if DescricaoGrande then
        if Length( Descricao ) > 29 then       { Programando aumento de Descricao }
           if (StrToIntDef( NumVersao,0 ) >= 300) then
              EnviaComando( #62+#52 + copy(Descricao,1,200) ) ;

     Descricao := padL(Descricao,29) ;
     EnviaComando(chr(CMD) + Codigo + Descricao + AliquotaECF + QtdStr +
               ValorStr + DescontoStr ) ;
   end ;

end;

procedure TACBrECFSwedaSTX.CarregaAliquotas;
Var StrRet : AnsiString ;
    Cont : Integer ;
    Aliquota : TACBrECFAliquota ;
    ValAliq : Double ;
    ByteISS1,ByteISS2 : Byte ;
begin
  StrRet    := EnviaComando( #35 + #29 ) ;
  try ByteISS1 := Ord(StrRet[1]) ; except ByteISS1 := 0 ; end ;
  try ByteISS2 := Ord(StrRet[2]) ; except ByteISS2 := 0 ; end ;

  StrRet := EnviaComando( #26 ) ;
  StrRet := BcdToAsc( copy( StrRet,2, Length(StrRet)) ) ;  { 1o Byte nao é BCD }

  inherited CarregaAliquotas ;   { Cria fpAliquotas }

  for Cont := 1 to 16 do
  begin
    ValAliq  := RoundTo( StrToIntDef(copy(StrRet,((Cont-1)*4)+1,4),0)/100,-2);

    if ValAliq > 0 then
    begin
       Aliquota := TACBrECFAliquota.create ;

       Aliquota.Indice   := IntToStrZero(Cont,2) ;
       Aliquota.Aliquota := ValAliq ;

       if Cont < 9 then
        begin
          if TestBit( ByteISS1, 8 -Cont) then
             Aliquota.Tipo := 'S' ;
        end
       else
          if TestBit( ByteISS2, 16-Cont) then
             Aliquota.Tipo := 'S' ;

       fpAliquotas.Add( Aliquota ) ;
    end ;
  end ;
end;

procedure TACBrECFSwedaSTX.LerTotaisAliquota;
begin
  if not Assigned( fpAliquotas ) then
     CarregaAliquotas ;
end;


procedure TACBrECFSwedaSTX.ProgramaAliquota(Aliquota: Double; Tipo: Char;
   Posicao : String);
Var ValStr : String ;
begin
  ValStr := IntToStrZero( Round(Aliquota * 100) ,4) ;
  Tipo   := UpCase(Tipo) ;
  if Tipo = 'S' then
     Tipo := '1'
  else
     Tipo := '0' ;

  EnviaComando( #07 + ValStr + Tipo ) ;
  CarregaAliquotas ;
end;

function TACBrECFSwedaSTX.AchaICMSAliquota( var AliquotaICMS: String):
   TACBrECFAliquota;
  Var AliquotaStr : String ;
begin
  Result      := nil ;
  AliquotaStr := ''  ;

  AliquotaICMS := UpperCase( Trim( AliquotaICMS ) ) ;
  case AliquotaICMS[1] of
    'I' : AliquotaStr := 'II' ;
    'N' : AliquotaStr := 'NN' ;
    'F' : AliquotaStr := 'FF' ;
    'T' : AliquotaICMS := 'T'+padR(copy(AliquotaICMS,2,2),2,'0') ; {Indice}
  end;

  if AliquotaStr = '' then
     Result := inherited AchaICMSAliquota( AliquotaICMS )
  else
     AliquotaICMS := AliquotaStr ;
end;


procedure TACBrECFSwedaSTX.CarregaFormasPagamento;  { funçao Lenta +- 3 sec. }
Var StrRet : AnsiString ;
    Cont : Integer ;
    FPagto : TACBrECFFormaPagamento ;
    Descr : String ;
begin
  StrRet := EnviaComando( #35+#32, 8 ) ;
  //  1 + (52 * 16) + (52 * 10) + (52 * 10) + (52 * 1)
  //  1 + 832 + 520 + 520 + 52 = 1925

  inherited CarregaFormasPagamento ;   { Cria fpFormasPagamentos }

  For Cont := 1 to 50 do
  begin
    Descr := trim( copy( StrRet, (Cont * 16) - 15 + 1, 16) ) ;
    if Descr <> '' then
    begin
       FPagto := TACBrECFFormaPagamento.create ;

       FPagto.Indice    := IntToStrZero(Cont,2) ;
       FPagto.Descricao := Descr ;
       FPagto.PermiteVinculado := (Cont > 1); {Apenas 1-Dinheiro nao permite}
       FPagto.Total := RoundTo( StrToFloatDef( BcdToAsc(
                           copy(StrRet,(Cont*10) - 9 + 833,10) ),0) / 10000, -4) ;

       fpFormasPagamentos.Add( FPagto ) ;
    end ;
  end ;
end;

procedure TACBrECFSwedaSTX.CarregaRelatoriosGerenciais;
Var
  RetCmd, Token1, Token2, Descricao : AnsiString ;
  Cont, CER : Integer ;
  RG  : TACBrECFRelatorioGerencial ;
begin
  inherited CarregaRelatoriosGerenciais ;   {Inicializa fpRelatoriosGerenciais}

  try
    if fpMFD then
    begin
      RetCmd  := EnviaComando( #35 + #51 );

      for Cont := 1 to 30 do
      begin
        { Adicionando os Relatorios Gerenciais }
        Token1    := copy(RetCmd, ((Cont-1) * 19) +3, 17) ;
        Descricao := Trim(Token1) ;

        Token2:= BcdToAsc(  copy(RetCmd, ((Cont-1) * 19) + 1, 2) ) ;
        CER   := StrToIntDef(Token2, 0) ;

        if (Descricao <> '') and (Descricao[2] <> #255) then
        begin
          RG := TACBrECFRelatorioGerencial.create ;
          RG.Indice     := IntToStrZero(Cont,2);
          RG.Descricao  := Descricao ;
          RG.Contador   := CER;

          fpRelatoriosGerenciais.Add( RG ) ;
        end ;
      end ;
    end ;
  except
    { Se falhou ao carregar, deve "nilzar" as variaveis para que as rotinas
      "Acha*" tentem carregar novamente }
    fpRelatoriosGerenciais.Free ;
    fpRelatoriosGerenciais := nil ;

    raise ;
  end ;

end;

procedure TACBrECFSwedaSTX.LerTotaisFormaPagamento;
begin
  CarregaFormasPagamento ;
end;


procedure TACBrECFSwedaSTX.ProgramaFormaPagamento( var Descricao: String;
  PermiteVinculado : Boolean; Posicao : String) ;
Var StrRet : AnsiString ;
    FPagto : TACBrECFFormaPagamento ;
    VincStr: String ;
begin
  Descricao := padL(Descricao,16) ;         { Ajustando tamanho final }
  VincStr   := '' ;
     if PermiteVinculado then
        VincStr := '1'
     else
        VincStr := '2' ;

  StrRet := BcdToAsc( EnviaComando( #71 + Descricao + VincStr ) ) ;
  StrRet := copy(StrRet,2,1)+copy(StrRet,4,1) ;

  { Adicionando nova Forma no ObjectList }
  if (StrToIntDef( StrRet, 0 ) > 0) then
  begin
     if Assigned( fpFormasPagamentos ) then
     begin
        FPagto := AchaFPGIndice(StrRet) ;
        if FPagto = nil then
        begin
           FPagto := TACBrECFFormaPagamento.create ;
           FPagto.Indice    := StrRet ;
           FPagto.Descricao := Trim(Descricao) ;
           FPagto.PermiteVinculado := PermiteVinculado ;
           fpFormasPagamentos.Add( FPagto ) ;
        end ;
        Descricao := FPagto.Descricao ;
     end ;
  end ;
end;

procedure TACBrECFSwedaSTX.ProgramaRelatorioGerencial( var Descricao: String; Posicao: String);
Var
  ProxIndice : Integer ;
begin
  CarregaRelatoriosGerenciais ;

  Descricao := Trim(Descricao) ;
  ProxIndice := StrToIntDef(Posicao, -1) ;

  if fpMFD then
   begin
     if AchaRGDescricao(Descricao, True) <> nil then
        raise Exception.Create('Relatório Gerencial ('+Descricao+') já existe.') ;

     if (ProxIndice < 2) or (ProxIndice > 30) then { Indice passado é válido ? }
     begin
        For ProxIndice := 2 to 30 do  { Procurando Lacuna }
        begin
           if AchaRGIndice(IntToStrZero(ProxIndice,2)) = nil then
              break ;
        end ;
     end ;

     if ProxIndice > 30 then
        raise Exception.create('Não há espaço para programar novos RGs');

     EnviaComando( #82 + IntToStrZero(ProxIndice,2) + PadL(Descricao,17) ) ;
   end
  else
     raise Exception.Create('Impressoras sem MFD não suportam Programação de Relatórios Gerenciais');

  CarregaRelatoriosGerenciais ;
end;

procedure TACBrECFSwedaSTX.CarregaComprovantesNaoFiscais;
Var RetCmd, S: AnsiString ;
    Cont  : Integer ;
    CNF   : TACBrECFComprovanteNaoFiscal ;
    Descr : String ;
begin
  Cont      := 1 ;
  RetCmd    := EnviaComando( #35 + #33, 8 ) ;
  // ( 2 * 50 ) + (10 * 50) + (19 * 50)
  //     100    +    500    +   950    = 1550

  inherited CarregaComprovantesNaoFiscais ;

  S := RetCmd ;
  while Length(S) > 0 do
  begin
    Descr  := trim( copy(S, 13,19) ) ;

    if Descr <> '' then
    begin
       CNF := TACBrECFComprovanteNaoFiscal.create ;

       CNF.Indice    := IntToStrZero(Cont,2) ;
       CNF.Descricao := Descr ;
       CNF.Total     := RoundTo( StrToFloatDef(
                                 BcdToAsc(copy(S,3,10)),0) / 10000, -4) ;
       CNF.Contador  := StrToIntDef( BcdToAsc(copy(S,1,2)),0) ;

       fpComprovantesNaoFiscais.Add( CNF ) ;
    end ;

    S    := copy(S, 32, Length(S) ) ;
    Cont := Cont + 1 ;
  end ;

end;

procedure TACBrECFSwedaSTX.LerTotaisComprovanteNaoFiscal;
begin
  CarregaComprovantesNaoFiscais ;
end;

procedure TACBrECFSwedaSTX.ProgramaComprovanteNaoFiscal(var Descricao : String;
   Tipo: String; Posicao : String);
Var ProxIndice : Integer ;
    CNF    : TACBrECFComprovanteNaoFiscal ;
begin
  Descricao := padL(Descricao,19) ;

  CarregaComprovantesNaoFiscais ;

  ProxIndice := StrToIntDef(Posicao,0) ;
  if (ProxIndice < 1) or (ProxIndice > 50) then { Indice passado é válido ? }
     ProxIndice := ComprovantesNaoFiscais.Count + 1 ;

  if ProxIndice > 50 then
     raise Exception.create('Não há espaço para programar novos Comprovantes'+
                            ' não Fiscais');

  EnviaComando( #40 + IntToStrZero(ProxIndice,2) + Descricao ) ;

  { Adcionanodo novo CNF no ObjectList }
  CNF := TACBrECFComprovanteNaoFiscal.create ;
  CNF.Indice    := IntToStrZero(ProxIndice,2) ;
  CNF.Descricao := Descricao ;
  fpComprovantesNaoFiscais.Add( CNF ) ;
end;


procedure TACBrECFSwedaSTX.ImprimeCheque(Banco: String; Valor: Double;
  Favorecido, Cidade: String; Data: TDateTime; Observacao: String);
begin
end;

procedure TACBrECFSwedaSTX.CancelaImpressaoCheque;
begin
  EnviaComando( #62 + #49 ) ;
end;

function TACBrECFSwedaSTX.GetChequePronto: Boolean;
Var B : Byte ;
    Resp : AnsiString ;
begin
  Resp := EnviaComando( #62 + #48 ) ;
  B := ord( Resp[1] ) ;
  Result := not TestBit(B,5) ;
end;

procedure TACBrECFSwedaSTX.ImpactoAgulhas( NivelForca : Integer = 2);
Var Value : Integer ;
begin
  if ( StrToIntDef( NumVersao,0 ) < 310) then
     raise Exception.Create('Comando para aumentar o impacto das agulhas '+
                            'não disponível neste modelo de ECF.') ;

  Value := min(max(NivelForca,3),1) ;
  EnviaComando( #124 + IntToStr( Value ) ) ;
end;

procedure TACBrECFSwedaSTX.AbreRelatorioGerencial(Indice: Integer = 0);
 Var Espera : Integer ;
  IndiceStr : String;
  RG  : TACBrECFRelatorioGerencial;
begin
  Espera := 30 ;
  IndiceStr :=  IntToStrZero(Indice, 2);
  AguardaImpressao := True ;

  if fpMFD and (Indice > 0) then
   begin
     Espera := 10 ;
     RG  := AchaRGIndice( IndiceStr ) ;
     if RG = nil then
        raise Exception.create( 'Relatório Gerencial: '+IndiceStr+
                                ' não foi cadastrado.' );

     EnviaComando( #83 + IndiceStr, Espera);
   end
  else
     EnviaComando(#20, Espera);

end;

procedure TACBrECFSwedaSTX.LinhaRelatorioGerencial(Linha: AnsiString; IndiceBMP: Integer);
Var P, Espera : Integer ;
    Buffer : AnsiString ;
    MaxChars : Integer ;
begin
  Linha := AjustaLinhas( Linha, Colunas );  { Formata as Linhas de acordo com "Coluna" }
  MaxChars := 620 ; 

  if not fpTermica then   { Se não é Termica, Imprime Linha a Linha }
     ImprimirLinhaALinha( Linha, #20 )
  else
     while Length( Linha ) > 0 do
     begin
        P := Length( Linha ) ;
        if P > MaxChars then    { Acha o fim de Linha mais próximo do limite máximo }
           P := PosLast(#10, LeftStr(Linha,MaxChars) ) ;

        if P = 0 then
           P := Colunas ;

        Buffer := copy( Linha, 1, P)  ;
        Espera := Trunc( CountStr( Buffer, #10 ) / 4) ;

        AguardaImpressao := (Espera > 3) ;
        EnviaComando( #20 + Buffer, Espera ) ;

        { ficou apenas um LF sozinho ? }
        if (P = Colunas) and (RightStr( Buffer, 1) <> #10) and
           (copy( Linha, P+1, 1) = #10) then
           P := P + 1 ;

        Linha  := copy( Linha, P+1, Length(Linha) ) ;   // O Restante
     end ;
end;

procedure TACBrECFSwedaSTX.AbreCupomVinculado(COO, CodFormaPagto,
   CodComprovanteNaoFiscal :  String; Valor : Double ) ;
Var FPG : TACBrECFFormaPagamento ;
    StrValor, FPGDesc : String ;
    ComandoCompleto : Boolean ;
begin
  FPG := AchaFPGIndice( CodFormaPagto ) ;

  if FPG = nil then
     raise Exception.create( 'Forma de Pagamento: '+CodFormaPagto+
                             ' não foi cadastrada.' ) ;

  COO       := Poem_Zeros( trim(COO) ,6) ;
  FPGDesc   := padL( FPG.Descricao, 16 ) ;
//FPGDesc   := UpperCase(copy(FPGDesc,1,1))+LowerCase(copy(FPGDesc,2,16)) ;
  ComandoCompleto  := ((Valor > 0) and ((StrToIntDef( NumVersao,0 ) >= 310) )) ;
  StrValor := IntToStrZero( Round(Valor * 100) ,14) ;

  if ComandoCompleto then
    try
       AguardaImpressao := True ;
       EnviaComando( #66 + FPGDesc + StrValor + COO, 10) ;
    except
       ComandoCompleto := False ;
    end ;

  if not ComandoCompleto then
  begin
     AguardaImpressao := True ;
     EnviaComando( #66 + FPGDesc, 10) ;
  end ;
end;

procedure TACBrECFSwedaSTX.LinhaCupomVinculado(Linha: AnsiString);
Var P, Espera : Integer ;
    Buffer : AnsiString ;
    MaxChars : Integer ;
begin
  Linha := AjustaLinhas( Linha, Colunas );  { Formata as Linhas de acordo com "Coluna" }
  MaxChars := 620 ;  

  if not fpTermica then   { Se não é Termica, Imprime Linha a Linha }
     ImprimirLinhaALinha( Linha, #67 )
  else
     while Length( Linha ) > 0 do
     begin
        P := Length( Linha ) ;
        if P > MaxChars then    { Acha o fim de Linha mais próximo do limite máximo }
           P := PosLast(#10, LeftStr(Linha,MaxChars) ) ;

        Buffer := copy( Linha, 1, P)  ;
        Espera := Trunc( CountStr( Buffer, #10 ) / 4) ;

        AguardaImpressao := (Espera > 3) ;
        EnviaComando( #67 + Buffer, Espera ) ;

        Linha  := copy( Linha, P+1, Length(Linha) ) ;   // O Restante
     end ;
end;

procedure TACBrECFSwedaSTX.FechaRelatorio;
begin
  AguardaImpressao := True ;
  EnviaComando( #21, 10 ) ;  { Fecha o relatorio Gerencial ou Vinculado }
end;

procedure TACBrECFSwedaSTX.CorrigeEstadoErro(Reducao: Boolean) ;
begin
  try
     EnviaComando( #70 ) ;
     sleep(200) ;
  except
  end ;

  inherited CorrigeEstadoErro(Reducao) ;

  if Estado in [estVenda, estPagamento] then
  begin
     try AbreCupom except end ;
     try CancelaCupom except end ;
  end;
end;

procedure TACBrECFSwedaSTX.LeituraMemoriaFiscal(ReducaoInicial,
   ReducaoFinal : Integer; Simplificada : Boolean);
 Var Espera : Integer ;
     Flag   : Char ;
begin
  Espera := 80 + (ReducaoFinal - ReducaoInicial) ;
  AguardaImpressao := True ;
  Flag := 'I' ;
  if Simplificada then
     Flag := 'i' ;
  EnviaComando( #8 + IntToStrZero(ReducaoInicial,6) +
                     IntToStrZero(ReducaoFinal  ,6) + Flag , Espera ) ;

end;

procedure TACBrECFSwedaSTX.LeituraMemoriaFiscal(DataInicial,
   DataFinal: TDateTime; Simplificada : Boolean);
 Var Espera : Integer ;
     Flag   : Char ;
begin
  Espera := 80 + DaysBetween(DataInicial,DataFinal) ;
  AguardaImpressao := True ;
  Flag := 'I' ;
  if Simplificada then
     Flag := 'i' ;
  EnviaComando( #8 + FormatDateTime('ddmmyy',DataInicial) +
                     FormatDateTime('ddmmyy',DataFinal)   + Flag , Espera ) ;

end;

procedure TACBrECFSwedaSTX.LeituraMemoriaFiscalSerial(ReducaoInicial,
   ReducaoFinal: Integer; var Linhas : TStringList; Simplificada : Boolean);
 Var Espera : Integer ;
     Flag   : Char ;
begin
  Espera := Trunc(30 + ((ReducaoFinal - ReducaoInicial)/2) ) ;
  Flag := 'R' ;
  if Simplificada then
     Flag := 'r' ;

  Linhas.Clear ;
  Linhas.Text := EnviaComando( #8 + IntToStrZero(ReducaoInicial,6) +
                                    IntToStrZero(ReducaoFinal  ,6) + Flag, Espera ) ;
end;

procedure TACBrECFSwedaSTX.LeituraMemoriaFiscalSerial(DataInicial,
   DataFinal: TDateTime; var Linhas : TStringList; Simplificada : Boolean);
 Var Espera : Integer ;
     Flag   : Char ;
begin
  Espera := Trunc(30 + (DaysBetween(DataInicial,DataFinal)/2) ) ;
  Flag := 'R' ;
  if Simplificada then
     Flag := 'r' ;

  Linhas.Clear ;
  Linhas.Text := EnviaComando( #8 + FormatDateTime('ddmmyy',DataInicial)+
                                    FormatDateTime('ddmmyy',DataFinal)  +Flag ,Espera);
end;

function TACBrECFSwedaSTX.GetCNPJ: String;
begin
  Result := RetornaInfoECF( '42' )
end;

function TACBrECFSwedaSTX.GetIE: String;
begin
  Result  := RetornaInfoECF( '43' )
end;

function TACBrECFSwedaSTX.GetDataMovimento: TDateTime;
Var RetCmd : AnsiString ;
    OldShortDateFormat : String ;
begin
   RetCmd    := RetornaInfoECF( '27' ) ;

   if RetCmd = '000000' then
      Result := DataHora
   else
    begin
      OldShortDateFormat := ShortDateFormat ;
      try
         ShortDateFormat := 'dd/mm/yy' ;
         result := StrToDate(copy(RetCmd, 1,2) + DateSeparator +
                             copy(RetCmd, 3,2) + DateSeparator +
                             copy(RetCmd, 5,2)) ;
      finally
         ShortDateFormat := OldShortDateFormat ;
      end ;
    end ;
end;

function TACBrECFSwedaSTX.GetGrandeTotal: Double;
begin
  Result := StrToFloatDef(  RetornaInfoECF( '03' )  ,0) / 100 ;
  Result := RoundTo( Result, -2) ;
end;

function TACBrECFSwedaSTX.GetNumCRZ: String;
begin
  Result := RetornaInfoECF( '09' ) ;
end;

function TACBrECFSwedaSTX.GetTotalAcrescimos: Double;
begin
  Result := StrToFloatDef( RetornaInfoECF( '30' ) ,0) / 100 ;
  Result := RoundTo( Result, -2) ;
end;

function TACBrECFSwedaSTX.GetTotalCancelamentos: Double;
begin
  Result := StrToFloatDef( RetornaInfoECF( '04' ) ,0) / 100 ;
  Result := RoundTo( Result, -2) ;
end;

function TACBrECFSwedaSTX.GetTotalDescontos: Double;
begin
  Result := StrToFloatDef( RetornaInfoECF( '05' ) ,0 ) / 100 ;
  Result := RoundTo( Result, -2) ;
end;

function TACBrECFSwedaSTX.GetTotalIsencao: Double;
begin
end;

function TACBrECFSwedaSTX.GetTotalNaoTributado: Double;
begin
end;

function TACBrECFSwedaSTX.GetTotalSubstituicaoTributaria: Double;
begin
end;

function TACBrECFSwedaSTX.GetNumUltimoItem: Integer;
begin
  Result := StrToIntDef( RetornaInfoECF( '12' ), 0)  ;
end;

function TACBrECFSwedaSTX.GetVendaBruta: Double;
Var RetCmd : AnsiString ;
begin
  try
     RetCmd    := BcdToAsc(EnviaComando( #62 + #55, 5 )) ;
     Result    := StrToFloatDef(copy(RetCmd,3,18),0) / 100;

  except
     Result := 0 ;
  end ;

  Result :=  RoundTo( GrandeTotal - Result, -2) ;
end;

function TACBrECFSwedaSTX.GetNumCOOInicial: String;
begin
end ;

procedure TACBrECFSwedaSTX.NaoFiscalCompleto(CodCNF: String; Valor: Double;
  CodFormaPagto: String; Obs: AnsiString; IndiceBMP : Integer);
  Var FPG : TACBrECFFormaPagamento ;
begin
  inherited NaoFiscalCompleto(CodCNF, Valor, CodFormaPagto, Obs)
end;

procedure TACBrECFSwedaSTX.AbreNaoFiscal(CPF_CNPJ: String);
begin
     AguardaImpressao := True ;
     CPF_CNPJ := TrimRight(CPF_CNPJ) ;
     if CPF_CNPJ <> '' then
        padL(CPF_CNPJ,28) ;

     EnviaComando( #77 + CPF_CNPJ , 5 ) ;
end;

procedure TACBrECFSwedaSTX.RegistraItemNaoFiscal(CodCNF: String;
  Valor: Double; Obs: AnsiString = '');
begin
     if CodCNF = 'SA' then
        CodCNF := '29'
     else if CodCNF = 'SU' then
        CodCNF := '30' ;

     EnviaComando( #78 + CodCNF + IntToStrZero(Round(Valor * 100) ,14)) ;
end;

procedure TACBrECFSwedaSTX.EfetuaPagamentoNaoFiscal(CodFormaPagto: String;
  Valor: Double; Observacao: AnsiString; ImprimeVinculado: Boolean);
begin
   EfetuaPagamento(CodFormaPagto, Valor, Observacao, ImprimeVinculado)
end;

procedure TACBrECFSwedaSTX.SubtotalizaNaoFiscal(DescontoAcrescimo: Double;
   MensagemRodape: AnsiString);
  Var A_D : Char ;
begin
  if DescontoAcrescimo < 0 then
     A_D := 'd'
  else
     A_D := 'a' ;

  DescontoAcrescimo := abs(DescontoAcrescimo) ;

  { Inicia fechamento com formas de Pagamento }
  EnviaComando( #79 + A_D +
                IntToStrZero( Round( DescontoAcrescimo * 100),14) );
end;

procedure TACBrECFSwedaSTX.FechaNaoFiscal(Observacao: AnsiString; IndiceBMP : Integer);
begin
  FechaCupom(Observacao)
end;

procedure TACBrECFSwedaSTX.CancelaNaoFiscal;
begin
end;

function TACBrECFSwedaSTX.GetDadosUltimaReducaoZ: AnsiString;
 Var RetCmd, S : AnsiString ;
     I : Integer ;
     VBruta, TOPNF, V : Double ;
begin
  try
     RetCmd    := BcdToAsc(EnviaComando( #62 + #55, 5 )) ;
  except
     Result := '' ;
     exit ;
  end ;

{ ESC 62 55 - Tamanho de Retorno 616 dígitos BCD (308 bytes),
              com a seguinte estrutura.
  2 RZAUT Se 00 redução por comando, caso contrário automática.
 18 GTDA GT no momento da última redução.
 14 CANCEL Cancelamentos
 14 DESCON Descontos
 64 TR Tributos
266 TP Totalizadores Parciais Tributados
 14 SANGRIA Sangria
 14 SUPRIMENTOS Suprimentos
126 NSI Totalizadores não Sujeitos ao ICMS
 36 CNSI Contadores dos TP’s não Sujeitos ao ICMS
  6 COO Contador de Ordem de Operação
  6 CNS Contador de Operações não Sujeitas ao ICMS
  2 AL Número de Alíquotas Cadastradas
  6 DATA_PC Data do Movimento
 14 ACRESC Acréscimo
 14 ACRFIN Acréscimo Financeiro

RRGGGGGGGGGGGGGGGGGGCCCCCCCCCCCCCCDDDDDDDDDDDDDDT001T002T003T004T005T006T007T008T009T010T011T012T013T014T015T016TPT00000000001TPT00000000002TPT00000000003TPT00000000004TPT00000000005TPT00000000006TPT00000000007TPT00000000008TPT00000000009TPT00000000010TPT00000000011TPT00000000012TPT00000000013TPT00000000014TPT00000000015TPT00000000016IIIIIIIIIIIIIINNNNNNNNNNNNNNFFFFFFFFFFFFFFAAAAAAAAAAAAAAUUUUUUUUUUUUUUTNS00000000001TNS00000000002TNS00000000003TNS00000000004TNS00000000005TNS00000000006TNS00000000007TNS00000000008TNS00000000009CN01CN02CN03CN04CN05CN06CN07CN08CN09COOCOOCNSCNSALDTMOVTAAAAAAAAAAAAAAFFFFFFFFFFFFFF
0000000000000014231000000000000000000000000000001800021605001200050025000250180013001600170002110200100006000100000000000001000000000000020000000000000300000000000004010000000000050100000000000601000000000007010000000000080100000000000901000000000010010000000000110200000000001202000000000013020000000000140200000000001502000000000016020000000001001400000000010114000000000408640000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000162000019161708070000000000011100000000000000
....+....1....+....2....+....3....+....4....+....5....+....6....+....7....+....8....+....9....+....0....+....1....+....2....+....3....+....4....+....5....+....6....+....7....+....8....+....9....+....0....+....1....+....2....+....3....+....4....+....5....+....6....+....7....+....8....+....9....+....0....+....1....+....2....+....3....+....4....+....5....+....6....+....7....+....8....+....9....+....0....+....1....+....2....+....3....+....4....+....5....+....6....+....7....+....8....+....9....+....0....+....1....+....2....+....3....+....4....+....5....+....6....+....7....+....8....+....9....+....0....+....1....+.
}

  Result := '[ECF]'+sLineBreak ;
  try
     Result := Result + 'DataMovimento = ' +
               copy(RetCmd,583,2)+DateSeparator+
               copy(RetCmd,585,2)+DateSeparator+
               copy(RetCmd,587,2)+sLineBreak ;
  except
  end ;

  try
     Result := Result + 'NumSerie = ' + NumSerie + sLineBreak ;
  except
  end ;

  try
     Result := Result + 'NumLoja = ' + NumLoja + sLineBreak ;
     Result := Result + 'NumECF = ' + NumECF + sLineBreak ;
  except
  end ;

  try
     Result := Result + 'NumCOO = ' + copy(RetCmd,569,6) + sLineBreak ;
  except
  end ;

  try
     Result := Result + 'NumCRZ = ' + NumCRZ + sLineBreak ;
  except
  end ;

  try
     Result := Result + 'NumCRO = ' + NumCRO + sLineBreak ;
  except
  end ;

  VBruta := 0 ;
  TOPNF  := 0 ;

  try
     Result := Result + sLineBreak + '[Aliquotas]'+sLineBreak ;
     
     if not Assigned( fpAliquotas ) then
        CarregaAliquotas ;

     S := copy(RetCmd,113,224) ;
     For I := 0 to Aliquotas.Count-1 do
     begin
        V := RoundTo( StrToFloatDef( copy(S,(I*14)+1,14),0) / 100, -2) ;
        Result := Result + padL(Aliquotas[I].Indice,2) +
                           Aliquotas[I].Tipo +
                           IntToStrZero(Trunc(Aliquotas[I].Aliquota*100),4) + ' = '+
                           FloatToStr( V ) + sLineBreak ;
        VBruta := VBruta + V ;
     end ;
  except
  end ;

  try
     Result := Result + sLineBreak + '[OutrasICMS]'+sLineBreak ;
     V := RoundTo( StrToFloatDef( copy(RetCmd,365,14),0) / 100, -2) ;
     Result := Result + 'TotalSubstituicaoTributaria = ' + FloatToStr(V) + sLineBreak ;
     VBruta := VBruta + V ;

     V := RoundTo( StrToFloatDef( copy(RetCmd,351,14),0) / 100, -2) ;
     Result := Result + 'TotalNaoTributado = ' + FloatToStr(V) + sLineBreak ;
     VBruta := VBruta + V ;

     V := RoundTo( StrToFloatDef( copy(RetCmd,337,14),0) / 100, -2) ;
     Result := Result + 'TotalIsencao = ' + FloatToStr(V) + sLineBreak ;
     VBruta := VBruta + V ;
  except
  end ;

  try
     Result := Result + sLineBreak + '[NaoFiscais]'+sLineBreak ;

     if not Assigned( fpComprovantesNaoFiscais ) then
        CarregaComprovantesNaoFiscais ;

     S := copy(RetCmd,379,126) ;

     For I := 0 to min(ComprovantesNaoFiscais.Count-1,11) do
     begin
        V := RoundTo( StrToFloatDef( copy(S,(I*14)+1,14),0) / 100, -2) ;
        Result := Result + padL(ComprovantesNaoFiscais[I].Indice,2) + '_' +
                           ComprovantesNaoFiscais[I].Descricao +' = '+
                           FloatToStr(V) + sLineBreak ;
        TOPNF := TOPNF + V ;
     end ;
  except
  end ;

  Result := Result + sLineBreak + '[Totalizadores]'+sLineBreak;

  try
     V := RoundTo( StrToFloatDef( copy(RetCmd,35,14),0) / 100, -2)  ;
     Result := Result + 'TotalDescontos = ' + FloatToStr( V ) + sLineBreak ;
     VBruta := VBruta + V ;
  except
  end ;

  try
     V := RoundTo( StrToFloatDef( copy(RetCmd,21,14),0) / 100, -2)  ;
     Result := Result + 'TotalCancelamentos = ' + FloatToStr( V ) + sLineBreak ;
     VBruta := VBruta + V ;
  except
  end ;

  try
     Result := Result + 'TotalAcrescimos = ' + FloatToStr(
         RoundTo( StrToFloatDef( copy(RetCmd,589,14),0) / 100, -2) )  + sLineBreak ;
  except
  end ;

  try
     Result := Result + 'TotalNaoFiscal = ' + FloatToStr(TOPNF) + sLineBreak ;
  except
  end ;

  try
     Result := Result + 'VendaBruta = ' + FloatToStr(VBruta) + sLineBreak ;
  except
  end ;

  try
     Result := Result + 'GrandeTotal = ' + FloatToStr(
         RoundTo( StrToFloatDef( copy(RetCmd,3,18),0) / 100, -2) )  + sLineBreak ;
  except
  end ;

end;

procedure TACBrECFSwedaSTX.CortaPapel(const CorteParcial: Boolean);
begin
end;

procedure TACBrECFSwedaSTX.IdentificaPAF(Linha1, Linha2: String);
begin
end;

function TACBrECFSwedaSTX.GetPAF: String;
begin
end;

function TACBrECFSwedaSTX.GetNumCDC: String;
begin
end;

function TACBrECFSwedaSTX.GetNumGNF: String;
begin
end;

function TACBrECFSwedaSTX.GetNumGRG: String;
begin
end;

function TACBrECFSwedaSTX.RetornaInfoECF(Registrador: String): AnsiString;
Var RetCmd : AnsiString ;
    I : Integer ;
    Info : TACBrECFSwedaInfo34 ;
begin
  I  := fsCache34.AchaSecao( Registrador ) ;
  if I >= 0 then
  begin
     Result := fsCache34[I].Dados ;
     exit ;
  end ;

  RetCmd := EnviaComando( '34|' + Registrador ) ;

  { Extraindo "DADOS" do bloco abaixo :
    STX[1]+Seq[1]+Tarefa[1]+Tipo[1]+Secao[4]+Dados[N]+ETX[1]+CHK[1] }
  if Copy(RetCmd,3,2) = '34' then
     Result := copy( RetCmd, 10, Length(RetCmd)-11 ) ;

  if pos('I8',Registrador) > 0 then  // Sem cache para Data/Hora
     exit ;
     
  { Adicionando resposta no Cache }
  Info := TACBrECFSwedaInfo34.create ;
  Info.Secao := Registrador ;
  Info.Dados := Result ;
  fsCache34.Add( Info ) ;
end;

end.

  Buffer := Retorno ;
  while (Buffer <> '') do
  begin
     PosSTX := Pos(STX,Buffer);
     if PosSTX < 1 then   // Não recebeu o STX
        break
     else if PosSTX > 1 then
        Buffer := copy(Buffer, PosSTX, Length(Buffer) ) ;  // Deve iniciar em STX

     PosETX := Pos(ETX, Buffer) ;
     if PosETX < 1 then          // Ainda não recebeu o ETX
        break ;

     Bloco  := copy(Buffer, 1, PosETX + 1  ) ;  // Pega um Bloco; +1 para pegar CHK
     Tipo   := copy(Bloco,5,1) ;

     Result := (Pos(Tipo,'+-') > 0) and     // É o Envio de Status
               (Length(Buffer) > PosETX) ;  // Tem o CHK

     if Result then
        break
     else
        Buffer := copy(Buffer, PosETX+2, Length( Buffer) )  // Buffer restante




*******
   ACK_PC   := 0 ;
   FalhasRX := 0 ;
   fpRespostaComando := '' ;

   while (ACK_PC <> ACK) and (FalhasRX < CFALHAS) do
   begin
      ChangeHandShake(True);     { Liga o DTR ou RTS para ler a Resposta }

      { Chama Rotina da Classe mãe TACBrClass para ler Resposta. Se houver
        falha na leitura LeResposta dispara Exceçao.
        Resposta fica gravada na váriavel "fpRespostaComando" }
      LeResposta ;

      fsTarefa    := '' ;
      fsTipo      := '' ;
      fsMensagem  := ''  ;

      PosSTX := PosLast(STX, fpRespostaComando);
      PosETX := PosEx(ETX, fpRespostaComando, PosSTX) ;
      Bloco  := copy(fpRespostaComando, PosStX, PosETX-PosSTX+2 ) ;

      fsTarefa   := copy(Bloco,3,2) ;
      fsTipo     := copy(Bloco,5,1) ;
      fsMensagem := copy(Bloco,6,4) ;
      CheckSum   := Bloco[ Length(Bloco) ] ;

      ACK_PC := ACK ;  // retornar ACK, OK
      { Verificando o CheckSum }
      if CalcCheckSum(LeftStr(Bloco,Length(Bloco)-1)) <> CheckSum then
         ACK_PC := NACK   // Erro no CheckSum, retornar NACK
      else
         if Ord( Bloco[2] ) <> Seq then
            raise Exception.Create('Sequencia de Resposta diferente da enviada') ;

