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
    function AjustaValor( ADouble : Double; Decimais : Integer = 2 ) : String ;
    function ExtraiRetornoLeituras(Retorno: AnsiString): AnsiString;
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
//IMS
    function GetIM: String; override ;
    function GetCliche: String; override ;    
//IMS    
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
Var RetCmd : AnsiString ;
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

     fpDecimaisPreco := 0 ;
     RetCmd := RetornaInfoECF( 'H2' ) ;
     if copy(RetCmd,10,1) = 'S' then
        fpDecimaisPreco := 2 ;
     if copy(RetCmd,11,1) = 'S' then
        fpDecimaisPreco := fpDecimaisPreco + 1 ;

     fpDecimaisQtd   := StrToIntDef(copy( RetornaInfoECF( 'U2' ),  1, 1), 2 ) ;
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
Var ErroMsg, Mensagem : String ;
    FalhasTX : Integer;
    ACK_ECF  : Byte ;
begin
   Result             := '' ;
   fpComandoEnviado   := '' ;
   fpRespostaComando  := '' ;
   fsRespostasComando := '' ;
   fsFalhasRX         := 0 ;

   if (LeftStr(cmd,2) <> '34') then
      fsCache34.Clear ;         // Limpa o Cache do 34

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
            ACK_ECF := fpDevice.Serial.RecvByte( TimeOut * 1000 ) ;
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

   { Captura informações do Ultimo Bloco Enviado }
   Mensagem := copy(fpRespostaComando,6,4) ;

   fpRespostaComando := fsRespostasComando ;   // Respostas Acumuladas

   { Limpando de "fpRespostaComando" os Status não solicitados }
   fpRespostaComando := AjustaRetorno( fpRespostaComando  );

   ErroMsg := DescreveErro( StrToIntDef(Mensagem,-1) ) ;

   if ErroMsg <> '' then
    begin
      ErroMsg := 'Erro retornado pela Impressora: '+ModeloStr+
                 sLineBreak+sLineBreak+
                 'Erro ('+Mensagem+') '+ErroMsg ;
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
    058 : Result := 'Comando ou operação inválida!' ;
    060 : Result := 'É necessária a emissão do documento de Redução Z!' ;

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
  Bloco, Tarefa : AnsiString ;
  Sequencia, ACK_PC : Byte ;
  Tipo : AnsiChar ;
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
  Bloco     := copy(Retorno, 1, PosETX+1) ;
  Result    := True ;
  Sequencia := Ord( Bloco[2] ) ;
  Tarefa    := copy(Bloco,3,2) ;
  Tipo      := Bloco[5] ;

  GravaLog( 'SwedaSTX VerificaFimLeitura: Verificando Bloco: '+Bloco) ;

  if Tipo = '!' then  // Bloco de Satus não solicitado, Descartando
   begin
     GravaLog( 'SwedaSTX VerificaFimLeitura: Bloco (!) Descartado: '+Bloco) ;
     Result := False ;
   end
  else
   begin
     { Verificando a Sequencia }
     if Sequencia <> fsSEQ then
     begin
        Result := False ;  // Ignore o Bloco, pois não é a resposta do CMD solicitado
        GravaLog( 'Sequencia de Resposta ('+IntToStr(Sequencia)+')'+
                  'diferente da enviada ('+IntToStr(fsSEQ)+')' ) ;
     end ;

     { Verificando o CheckSum }
     ACK_PC := ACK ;

     if Result and
       ( CalcCheckSum(LeftStr(Bloco,Length(Bloco)-1)) <> RightStr(Bloco,1) ) then
     begin
       ACK_PC := NACK ;  // Erro no CheckSum, retornar NACK
       if fsFalhasRX > CFALHAS then
          raise Exception( 'Erro no digito Verificador da Resposta.'+sLineBreak+
                           'Falha: '+IntToStr(fsFalhasRX) ) ;
       Inc( fsFalhasRX ) ;  // Incrementa numero de Falhas
       Result := False ;
     end ;

     ChangeHandShake(False);            { Desliga o DTR ou RTS para enviar }
     fpDevice.Serial.SendByte(ACK_PC);

     if Result then
        fsRespostasComando := fsRespostasComando + Retorno ;  // Salva este Bloco

     if (ACK_PC = ACK) then           // ACK OK ?
     begin
        if Tipo = '-' then            // Erro ocorrido,
           AguardaImpressao := False  //   portanto, Desliga AguardaImpressao (caso estivesse ligado)
        else if Tipo <> '+' then      // Tipo não é '-' nem '+', portanto não é o Ultimo Bloco
           Result := False ;          //   portanto Zera para Ler proximo Bloco
     end ;

     GravaLog( 'SwedaSTX VerificaFimLeitura: Seq:'+IntToStr(Sequencia)+' Tarefa:'+
               Tarefa+' Tipo: '+Tipo+' ACK:'+IntToStr(ACK_PC)+' Result: '+IfThen(Result,'True','False') ) ;
   end ;

  if not Result then
  begin
     GravaLog('Retorno Antes do ajuste: '+Retorno);
     Retorno := copy(Retorno, PosETX+2, Length(Retorno) ) ;
     GravaLog('Retorno APOS o ajuste: '+Retorno);
  end ;
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
        GravaLog('SwedaSTX VerificaFimImpressao: Pedindo o Status. Seq:'+IntToStr(fsSEQ)) ;

        fpDevice.Serial.Purge ;          // Limpa buffer de Entrada e Saida //
        ChangeHandShake(False);          // DesLiga o DTR para enviar //
        fpDevice.EnviaString( Cmd );     // Envia comando //

        ChangeHandShake(True);           // Liga o DTR para receber //
        wACK := fpDevice.Serial.RecvByte( TimeOut * 1000 ) ; // espera ACK chegar na Porta  //

        if wACK = 6 then   // ECF Respondeu corretamente, portanto está trabalhando //
        begin
           GravaLog('SwedaSTX VerificaFimImpressao: ACK = 6, OK... Aguardando Bloco') ;

           // Aguarda por Bloco até 2 seg //
           I := 0 ;
           while (I < 20) and (not Result) do
           begin
              TempoLimite := IncSecond(now, TimeOut);
              try
                 Ret := fpDevice.Serial.RecvPacket(100) ;
              except
              end ;

              RetCmd := RetCmd + Ret ;
              Inc( I ) ;

              GravaLog('SwedaSTX VerificaFimImpressao: I: '+IntToStr(I)+' Bloco Lido: '+RetCmd ) ;
              Result :=  VerificaFimLeitura( RetCmd, TempoLimite)   ;
           end ;

           Result := Result and (pos(copy(RetCmd,11,1), 'ACDGI') > 0) ;
        end ;
     except
       On E : Exception  do
       begin
         GravaLog('SwedaSTX VerificaFimImpressao: Exception:'+E.Message ) ;
       end ;
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

{ Remove Blocos de Resposta de Status não solicitados  (envio automático pelo ECF)}
Function TACBrECFSwedaSTX.ExtraiRetornoLeituras(Retorno: AnsiString) : AnsiString ;
Var
  PosETX, PosSTX : Integer ;
  Bloco, Tipo : AnsiString ;
begin
  Result := '' ;

  PosSTX := Pos(STX,Retorno);
  while PosSTX > 0 do
  begin
     PosETX := PosEx(ETX, Retorno, PosSTX ) ;
     if PosETX < 1 then          // Ainda não recebeu o ETX final
        break ;

     Bloco := copy(Retorno, PosSTX, PosETX-PosSTX + 2  ) ;  // Pega um Bloco; +2 para pegar CHK
     Tipo  := copy(Bloco,5,1) ;

     if Tipo = '>' then  // Bloco de Resposta
        Result := Result + copy(Bloco,7, Length(Bloco) - 8 ) ;

     PosSTX := PosEx( STX , Retorno, PosETX);
  end ;
end ;

function TACBrECFSwedaSTX.DescompactaRetorno( const Dados : AnsiString ) : AnsiString ;
Var P      : Integer ;
    AChar  : AnsiChar ;
    NTimes : Byte ;
begin
   Result   := Dados ;

   P := pos(ESC, Result) ;
   while (P > 0) do
   begin
      AChar  := Result[P-1] ;

      if AChar <> ETX then  // Não usa caso ESC esteja no CHK
      begin
         NTimes := ord( copy( Result, P+1, 1)[1] ) - 31 ;
         Result := StuffString(Result, P, 2, StringOfChar(AChar,NTimes) ) ;
      end ;

      P := PosEx( ESC, Result, P+1) ;
   end ;
end ;

function TACBrECFSwedaSTX.AjustaValor( ADouble : Double;
  Decimais : Integer = 2 ) : String ;
begin
  Result := FormatFloat('0.'+StringOfChar('0',Decimais) ,ADouble) ;
  Result := Trim(StringReplace(Result,DecimalSeparator,',',[])) ;
end;




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
    Estado, Docto : AnsiChar ;
    Sinalizadores : AnsiString ;
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
//               if TestBit( Ord(Sinalizadores[1]), 1 ) then
//                  fpEstado := estRequerX
//               else
                   fpEstado := estLivre ;
               end ;
             
             'C' :
               begin
                 if TestBit( Ord(Sinalizadores[2]), 5 )  then
                   fpEstado := estPagamento
                 else if TestBit( Ord(Sinalizadores[2]), 4 )  then
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
 Var RetCmd : AnsiString ;
begin
  RetCmd := EnviaComando('15|TXT|CPWIN') ;
  Linhas.Text := ExtraiRetornoLeituras( RetCmd ) ;
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

  AguardaImpressao := True ;
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
begin
  if Trim(Consumidor.Documento) <> '' then    { Tem Docto ? }
  begin
     EnviaComando('12|'+LeftStr(Consumidor.Documento ,20)+'|'+
                        LeftStr(Consumidor.Nome      ,30)+'|'+
                        LeftStr(Consumidor.Endereco  ,79)+'|0') ;
     Consumidor.Enviado := True ;
  end ;

  fpUltimaMsgPoucoPapel := 0 ;  { Zera tempo pra msg de pouco papel }
  AguardaImpressao := True ;
  EnviaComando( '01' ) ;
end;

procedure TACBrECFSwedaSTX.CancelaCupom;
begin
  // TODO: Procurar por CCDs em aberto e Estorna-los

  EnviaComando('08') ;

  try
    FechaRelatorio ;   { Fecha relatorio se ficou algum aberto (só por garantia)}
  except   // Exceçao silenciosa, pois a Impressora pode nao estar em Estado
  end ;    // de Relatorio.
end;

procedure TACBrECFSwedaSTX.CancelaItemVendido(NumItem: Integer);
begin
  EnviaComando( '05|' + IntToStr(NumItem) ) ;
end;

procedure TACBrECFSwedaSTX.EfetuaPagamento(CodFormaPagto: String;
  Valor: Double; Observacao: AnsiString; ImprimeVinculado: Boolean);
begin
  EnviaComando( '06|' + CodFormaPagto +'|'+AjustaValor(Valor)+'|'+
                LeftStr(Observacao,84) ) ;
end;

procedure TACBrECFSwedaSTX.FechaCupom(Observacao: AnsiString; IndiceBMP : Integer);
begin
  AguardaImpressao := True ;
  EnviaComando( '07|' + LeftStr( Observacao,800) ) ;
end;

procedure TACBrECFSwedaSTX.SubtotalizaCupom(DescontoAcrescimo: Double;
       MensagemRodape : AnsiString);
 Var Cmd : String ;
begin
  Cmd := '' ;
  if DescontoAcrescimo < 0 then
     Cmd := '55'
  else if DescontoAcrescimo > 0 then
     Cmd := '54' ;

  if Cmd <> '' then
     EnviaComando( Cmd+'|'+AjustaValor( Abs(DescontoAcrescimo) )) ;

  EnviaComando('64') ;  // Totalização
end;

Procedure TACBrECFSwedaSTX.VendeItem( Codigo, Descricao : String;
  AliquotaECF : String; Qtd : Double ; ValorUnitario : Double;
  ValorDescontoAcrescimo : Double; Unidade : String;
  TipoDescontoAcrescimo : String; DescontoAcrescimo : String) ;
Var
  FlagArr, Cmd : String ;
begin
  if Qtd > 9999 then
     raise EACBrECFCMDInvalido.Create(
           'Quantidade deve ser inferior a 9999.');

  if fsVerProtocolo > 'D' then
     FlagArr := '|A'
  else
     FlagArr := '' ;

  EnviaComando('02|' + AjustaValor(Qtd,fpDecimaisQtd)              +'|'+
                       Trim(LeftStr(Codigo,14))                    +'|'+
                       AjustaValor(ValorUnitario, fpDecimaisPreco) +'|'+
                       Trim(LeftStr(Unidade,2))                    +'|'+
                       AliquotaECF                                 +'|'+
                       Trim(LeftStr(Descricao,33))                 +
                       FlagArr  ) ;

  if ValorDescontoAcrescimo > 0 then
  begin
     if DescontoAcrescimo = 'A' then
        Cmd := '03'
     else
        Cmd := '04' ;

     Cmd := Cmd + '|' + AjustaValor(ValorDescontoAcrescimo) ;
     
     if TipoDescontoAcrescimo = '%' then
        Cmd := Cmd + '%' ;

     EnviaComando( Cmd )
  end ;
end;

procedure TACBrECFSwedaSTX.CarregaAliquotas;
begin
end;

procedure TACBrECFSwedaSTX.LerTotaisAliquota;
begin
end;


procedure TACBrECFSwedaSTX.ProgramaAliquota(Aliquota: Double; Tipo: Char;
   Posicao : String);
begin
end;

function TACBrECFSwedaSTX.AchaICMSAliquota( var AliquotaICMS: String):
   TACBrECFAliquota;
begin
end;


procedure TACBrECFSwedaSTX.CarregaFormasPagamento;  { funçao Lenta +- 3 sec. }
begin
end;

procedure TACBrECFSwedaSTX.CarregaRelatoriosGerenciais;
begin
end;

procedure TACBrECFSwedaSTX.LerTotaisFormaPagamento;
begin
end;


procedure TACBrECFSwedaSTX.ProgramaFormaPagamento( var Descricao: String;
  PermiteVinculado : Boolean; Posicao : String) ;
begin
end;

procedure TACBrECFSwedaSTX.ProgramaRelatorioGerencial( var Descricao: String; Posicao: String);
begin
end;

procedure TACBrECFSwedaSTX.CarregaComprovantesNaoFiscais;
begin
end;

procedure TACBrECFSwedaSTX.LerTotaisComprovanteNaoFiscal;
begin
end;

procedure TACBrECFSwedaSTX.ProgramaComprovanteNaoFiscal(var Descricao : String;
   Tipo: String; Posicao : String);
begin
end;


procedure TACBrECFSwedaSTX.ImprimeCheque(Banco: String; Valor: Double;
  Favorecido, Cidade: String; Data: TDateTime; Observacao: String);
begin
end;

procedure TACBrECFSwedaSTX.CancelaImpressaoCheque;
begin
end;

function TACBrECFSwedaSTX.GetChequePronto: Boolean;
begin
end;

procedure TACBrECFSwedaSTX.AbreRelatorioGerencial(Indice: Integer = 0);
begin
end;

procedure TACBrECFSwedaSTX.LinhaRelatorioGerencial(Linha: AnsiString; IndiceBMP: Integer);
begin
end;

procedure TACBrECFSwedaSTX.AbreCupomVinculado(COO, CodFormaPagto,
   CodComprovanteNaoFiscal :  String; Valor : Double ) ;
begin
end;

procedure TACBrECFSwedaSTX.LinhaCupomVinculado(Linha: AnsiString);
begin
end;

procedure TACBrECFSwedaSTX.FechaRelatorio;
begin
end;

procedure TACBrECFSwedaSTX.LeituraMemoriaFiscal(ReducaoInicial,
   ReducaoFinal : Integer; Simplificada : Boolean);
begin
end;

procedure TACBrECFSwedaSTX.LeituraMemoriaFiscal(DataInicial,
   DataFinal: TDateTime; Simplificada : Boolean);
begin
end;

procedure TACBrECFSwedaSTX.LeituraMemoriaFiscalSerial(ReducaoInicial,
   ReducaoFinal: Integer; var Linhas : TStringList; Simplificada : Boolean);
begin
end;

procedure TACBrECFSwedaSTX.LeituraMemoriaFiscalSerial(DataInicial,
   DataFinal: TDateTime; var Linhas : TStringList; Simplificada : Boolean);
begin
end;

function TACBrECFSwedaSTX.GetCNPJ: String;
begin
end;

function TACBrECFSwedaSTX.GetIE: String;
begin
end;

//IMS
function TACBrECFSwedaSTX.GetIM: String;
begin
end;
function TACBrECFSwedaSTX.GetCliche: String;
begin
end;
//IMS

function TACBrECFSwedaSTX.GetDataMovimento: TDateTime;
begin
end;

function TACBrECFSwedaSTX.GetGrandeTotal: Double;
begin
end;

function TACBrECFSwedaSTX.GetNumCRZ: String;
begin
end;

function TACBrECFSwedaSTX.GetTotalAcrescimos: Double;
begin
end;

function TACBrECFSwedaSTX.GetTotalCancelamentos: Double;
begin
end;

function TACBrECFSwedaSTX.GetTotalDescontos: Double;
begin
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
end;

function TACBrECFSwedaSTX.GetVendaBruta: Double;
begin
end;

function TACBrECFSwedaSTX.GetNumCOOInicial: String;
begin
end ;

procedure TACBrECFSwedaSTX.AbreNaoFiscal(CPF_CNPJ: String);
begin
end;

procedure TACBrECFSwedaSTX.RegistraItemNaoFiscal(CodCNF: String;
  Valor: Double; Obs: AnsiString = '');
begin
end;

procedure TACBrECFSwedaSTX.EfetuaPagamentoNaoFiscal(CodFormaPagto: String;
  Valor: Double; Observacao: AnsiString; ImprimeVinculado: Boolean);
begin
end;

procedure TACBrECFSwedaSTX.SubtotalizaNaoFiscal(DescontoAcrescimo: Double;
   MensagemRodape: AnsiString);
begin
end;

procedure TACBrECFSwedaSTX.FechaNaoFiscal(Observacao: AnsiString; IndiceBMP : Integer);
begin
end;

procedure TACBrECFSwedaSTX.CancelaNaoFiscal;
begin
end;

function TACBrECFSwedaSTX.GetDadosUltimaReducaoZ: AnsiString;
begin
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

