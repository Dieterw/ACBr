{******************************************************************************}
{ Projeto: Componentes ACBr                                                    }
{  Biblioteca multiplataforma de componentes Delphi para interação com equipa- }
{ mentos de Automação Comercial utilizados no Brasil                           }
{                                                                              }
{ Direitos Autorais Reservados (c) 2007   Maicon da Silva Evangeslista         }
{                                                                              }
{ Colaboradores nesse arquivo:            Daniel Simões de Almeida             }
{                                                                              }
{   Código original por Valdir Stiebe Junior-valdir@dype.com.br-outubro/2006   }
{   Componente finalizado por Maicon da Silva Evangeslista-maiconsi@hotmail.com}
{  em julho/2007...                                                            }
{                                                                              }
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
{ Maicon da Silva Evangelista  -  maiconsi@hotmail.com                         }
{              Rua Marechal Rondon, 866 - Lucélia - SP - 17780-000             }
{                                                                              }
{******************************************************************************}

{******************************************************************************
|* Historico
|*
|* 20/07/2007: Maicon da Silva Evangelista
|*  Inicio do desenvolvimento
|* 27/02/2008: Maicon da Silva Evangelista
|*  - Criado o array para controle das bandeiras
|*  - Criado o tipo para armazenar as parcelas
|* 28/02/2008: Maicon da Silva Evangelista
|*  - Criada a Lista de Objetos do tipo TACBrTEFParcelas
|* 03/04/2008: Jhony Alceu Pereira (JhonyStein)
|*  - Modificada a rotina de gravacao da resposta temporária e erro
|*   na impressao (ao cancelar cupom)
|*  - Mudanca na rotina de verificacao do GP ativo, retornar Exception
|*   e nao mais mensagem. A mensagem deve ser tratada pelo sistema
|*  - Inclusao do parametro vias no relatorio gerencial
|* 10/04/2008: Jhony Alceu Pereira (JhonyStein)
|*  - Correcao da property Parcelas
|*  - Implementacao da venda por Cheque
|*  - Implementacao das propriedades da transação e carregamento das parcelas
|* 17/04/2008: Jhony Alceu Pereira (JhonyStein)
|*  - Bloqueio de mouse e teclado com a funcao BlockImput
|*  - Finalizacao do Gerencial/Vinculado apos um NCN
|*  - Correcao do loop infino sem mensagem na espera da resposta do CNF
|* 03/07/2008: Maicon da Silva Evangelista
|*  - Adcionada propriedade Ignora ECF Desligado
|*  - Adicionada a propriedade Handle para ser usada posteriormente nos messagebox
|*    para corrigir problemas de foco
|*  - Substituido alguns messageDlg por MessageBox para poder passar o handle
|*    da janela, pois estava tendo problema com foco
|*  - Foi alterada as funções  FechavendaTEF e FechavendaCartao, agora pode ser
|*    passado o handle da janela atual
|*  - Correção do metodo "VerificaTransaçõesPendentes", estava verificando
|*    somente o arquivo de backup da resposta, e o correto é verificar primeiro
|*    o arquivo intpos.001 e depois o backup
*******************************************************************************}

{$I ACBr.inc}
unit ACBrTEFClass;

interface
uses ACBrBase, ACBrECF, ACBrUtil, SysUtils, Classes, Contnrs
     {$IFDEF COMPILER6_UP}
       ,DateUtils, StrUtils
     {$ELSE}
       ,ACBrD5
     {$ENDIF}
     {$IFDEF VisualCLX}
       ,Qt, QControls, QForms, QGraphics, QDialogs, QExtCtrls
     {$ELSE}
       ,Controls, Forms, Graphics, Dialogs, ExtCtrls, Windows
     {$ENDIF} ;


type   (* Obs verificar se e realmente nessecario *)
   TTipoImpressao = (tiFiscal, tiGerencial);

   { Evento Aguadando dados do GP }
   TACBrAguardandoDadosGP = procedure(AComando : string;
      ATempoEspera : Integer; var ContinuarAguardando : Boolean) of object ;
      
   { Evento Pagamento não Autorizado }
   TACBrPagtoNaoAutorizado = procedure(var FormaPagtoAlternativa: String;
      var ValorPagtoAlternativo: Double; var Abortar: Boolean) of object ;

(* Classe que faz o tratamento na resposta  *)
TRespostaTransacao = class
   private
      fsResposta     : TStringList;
      fsImagemCupom  : TStringList;
      fsTipoImpressao: TTipoImpressao;
   public
      constructor Create(TextoResposta, ImagemCupom: string; AtipoImpressao: TTipoImpressao);
      destructor Destroy; override;
      property ImagemCupom: TStringList read fsImagemCupom;
      property Resposta: TStringList read fsResposta;
      property TipoImpressao: TTipoImpressao read fsTipoImpressao write fsTipoImpressao;
   end;

{ Definindo novo tipo para armazenar as Parcelas }
TACBrTEFParcela = class
 private
    fsVencimentoParcela: TDateTime;
    fsValorParcela: Double;
    fsNSUParcela: Integer;
 public
    constructor create ;
    property Vencimento : TDateTime read fsVencimentoParcela write fsVencimentoParcela ;
    property Valor      : Double read fsValorParcela write fsValorParcela ;
    property NSUParcela : Integer read fsNSUParcela write fsNSUParcela ;
end;

{ Lista de Objetos do tipo TACBrTEFParcelas }
TACBrTEFParcelas = class(TObjectList)
  protected
    procedure SetObject (Index: Integer; Item: TACBrTEFParcela);
    function GetObject (Index: Integer): TACBrTEFParcela;
  public
    function Add (Obj: TACBrTEFParcela): Integer;
    procedure Insert (Index: Integer; Obj: TACBrTEFParcela);
    property Objects [Index: Integer]: TACBrTEFParcela
      read GetObject write SetObject; default;
  end;

{ Nota sobre procimentos e funções VIRTUAL. Essas funçoes/procedimentos PODEM
  ou NAO ser implementados nas Classes filhas com a clausula OVERRIDE. Se não
  forem implementadas nas classes filhas, a funçao/procedimento definida aqui
  nessa classe (TACBrTEFClass) e que será execuada }

TACBrTEFClass = class
   private
      fsLinhasEntreTentativas :  Integer;
      fsOnAguardandoDadosGP   :  TACBrAguardandoDadosGP ;
      fsOnPagtoNaoAutorizado  :  TACBrPagtoNaoAutorizado ;

      procedure SetAtivo(const Value: Boolean);

      function GetParcelas: TACBrTEFParcelas;
      function GetHeader            :  String;
      function GetStatusTransacao   :  Integer;
      function GetNomeRede          :  String;
      function GetTipoTransacao     :  Integer;
      function GetNroTransacaoNSU   :  Integer;
      function GetCodAutTransacao   :  Integer;
      function GetNroLoteTransacao  :  Integer;
      function GetTipoParcelamento  :  Integer;
      function GetNroParcelas       :  Integer;
      function GetValorTotal        :  Double;

   protected
      fsIdle      :  Boolean;
      fpECF       :  TACBrECF ;
      fpAtivo     :  Boolean ;
      fpDone      :  Boolean ;

      fpTipoStr   :  String;
      fpTimeOut   :  Integer;
      fpQtdVias   :  Integer;

      {$IFDEF VisualCLX}
       fpHandle    :  QWidgetH;
      {$ELSE}
       fpHandle    :  THandle;
      {$ENDIF}

      fpCodFormaPagto            :  String;
      fpCodComprovanteNaoFiscal  :  String;
      fpUltimoComandoEnviado     :  String;

      fpValorTEF     :  Double;
      fpAtivarGP     :  Boolean;
      fpConsultarCheque :  Boolean;
      fpGuilhotina      :  Boolean;
      fpIgnoraECFAtivo  :  Boolean;

      fpBaseDir             : String; // Base do diretorio dos Arquivos
      fpReqTempFileName     : String; // Arquivo temporário para requisições ao GP
      fpReqFileName         : String; // Arquivo de requisições ao GP
      fpRespDataFileName    : String; // Arquivo com os dados da resposta do GP
      fpRespFileName        : String; // Arquivo de resposta do GP
      fpRespTempDataFileName: string; // arquivo de backup do RespDataFileName (necessário por causa do VISANET)

      fpParcelas     :  TACBrTEFParcelas;

      Comando        :  TStringList;
      Resposta       :  TStringList;

      fsImpressoesPendentes: TStringList;
      fsRespostaTransacao  :  TRespostaTransacao;
      function EnviaComando: Boolean; // Envia o Comando para o GP
      function ProcessaResposta(): Boolean; // Processa a resposta do GP
      function ReprocessaResposta(): Boolean; // Reprocessa a resposta do GP
   public
      constructor Create(AOwner: TComponent);
      Destructor Destroy  ; override ;

      Property Ativo  : Boolean read fpAtivo write SetAtivo ;

      procedure Ativar ; virtual;
      procedure Desativar ; virtual;

      Property ECF : TACBrECF read fpECF write fpECF ;
      Property TipoStr: String  read fpTipoStr ;

      property BaseDir           :  String read  fpBaseDir write fpBaseDir;
      property ReqTempFileName   :  String read  fpReqTempFileName write fpReqTempFileName;
      property ReqFileName       :  String read  fpReqFileName write fpReqFileName;
      property RespDataFileName  :  String read  fpRespDataFileName write fpRespDataFileName;
      property RespFileName      :  String read  fpRespFileName write fpRespFileName;
      property RespTempDataFileName:String read  fpRespTempDataFileName write fpRespTempDataFileName;

      property ComandoEnviado: String read fpUltimoComandoEnviado write fpUltimoComandoEnviado;

      property NumVias  :  Integer  read fpQtdVias write fpQtdVias;
      property TimeOUT  :  Integer  read fpTimeOut write fpTimeOut;
      {$IFDEF VisualCLX}
       property Handle   :  QWidgetH read fpHandle write fpHandle;
      {$ELSE}
       property Handle   :  Cardinal read fpHandle write fpHandle;
      {$ENDIF}

      Property ConsultarCheques: Boolean read fpConsultarCheque write fpConsultarCheque default true;
      property AcionarGuilhotina :  Boolean read fpGuilhotina write fpGuilhotina default true ;
      Property AtivarGP: Boolean read fpAtivarGP write fpAtivarGP default true;
      Property IgnoraECFDesativado: Boolean read fpIgnoraECFAtivo write fpIgnoraECFAtivo default true;

      procedure MensagemCancelamento(ARede, ANSU, AValor: string);// Msg de Cancelamento
      Function GPAtivo: Boolean; // Verifica se o Gerenciador Padrão esta Ativo
      procedure VerificaTransacaoPendente; // Verifica se existe alguma transação pendente
      procedure ImprimeCuponsPendentes; // Imprime os cupons pedentes
      procedure ADM; Virtual; // Chama o GP em modo administrativo
      procedure CNC(ABandeira, ANSU: string; ADataTransacao: TDateTime; AHoraTransacao: TDateTime; AValor: Double); // Cancelamento da venda efetuada por qualquer meio de cartão
      function NCN: Boolean; // Não confirmação da venda e/ ou da impressão
      function CRT(AValor: Double): Boolean; // Inicia uma transação de venda c/ TEF
      function CHQ(AValor: Double): Boolean; // Inicia uma transacao c/ Cheque
      function CNF: Boolean; // Confirma a operação

      procedure TravaTeclado;
      procedure DestravaTeclado;
      procedure LineFeed(ALineCount: Integer);
      function ImprimeFiscalTEF(Resposta: TRespostaTransacao): Boolean;
      function ImprimeGerencialTEF(Resposta: TRespostaTransacao): Boolean;
      function VendaTEF(CodFormaPagto: String; Valor: Double): Boolean;    // Realiza as transações TEF
      function VendaCheque(CodFormaPagto: String; Valor: Double): Boolean; // REaliza as transações com Cheque (REDECARD)
      function FechaVendaTEF(CodFormaPagto: String; CodComprovanteNaoFiscal: String; Valor: Double; Observacao: String = ''): Boolean;
      function FechaVendaCheque(CodFormaPagto: String; CodComprovanteNaoFiscal: String; Valor: Double; Observacao: String = ''): Boolean;
      procedure CancelaCupomTEF;

      Property Header            :  String   read GetHeader; // Indica o início do arquivo e o tipo de operação relacionada ao arquivo
      Property StatusTransacao   :  Integer  read GetStatusTransacao; // 0 - Aprovada; Outro valor para não aprovada
      Property NomeRede          :  String   read GetNomeRede; // AMEX - REDECARD - VISANET
      Property TipoTransacao     :  Integer  read GetTipoTransacao;  // Código identificando o tipo da transação executada
      Property NroTransacaoNSU   :  Integer  read GetNroTransacaoNSU;  // Indica o número de seqüência (NSU - Número Sequencial Único) da transação atribuído pelo Host (Sistema das Redes de Cartão que recebe e trata as solicitações das transações TEF).
      Property CodAutTransacao   :  Integer  read GetCodAutTransacao;  // Indica o número de autorização da transação atribuída pelo Host.
      Property NroLoteTransacao  :  Integer  read GetNroLoteTransacao; // Indica o número de lote da transação
      Property TipoParcelamento  :  Integer  read GetTipoParcelamento; // Indica o tipo de parcelamento aplicado à operação: 0 - parcelado estabelecimento / 1 - parcelado administradora
      Property NroParcelas       :  Integer  read GetNroParcelas; // Indica o número de parcelas no caso de transações Parceladas (Crédito ou Débito).
      Property ValorTotal        :  Double   read GetValorTotal; // Valor total desta forma de pagamento.

      Property Parcelas : TACBrTEFParcelas read GetParcelas;

      property ImpressoesPendentes: TStringList read fsImpressoesPendentes;
      property LinhasEntreTentativas: Integer read fsLinhasEntreTentativas write fsLinhasEntreTentativas;

      procedure CarregaParcelas;

      //Eventos do Componente
      (* Este evento ocorre em quando o componente aguarda a resposta do GP *)
      property OnAguardandoDadosGP :  TACBrAguardandoDadosGP
        read fsOnAguardandoDadosGP write fsOnAguardandoDadosGP ;

      (* Este evento ocorre quando a venda não é autorizada *)
      property OnPagtoNaoAutorizado :  TACBrPagtoNaoAutorizado
        read fsOnPagtoNaoAutorizado write fsOnPagtoNaoAutorizado ; 
end ;  

const
  TEFPrintBufferFile = 'c:\ACBrTEFBuffer.tmp';
  ArrTipoImpressao: array[Boolean] of TTipoImpressao = (tiGerencial, tiFiscal);

implementation
   Uses ACBrTEF, frm_TimedMessage;

{ TRespostaTransacao }

constructor TRespostaTransacao.Create(TextoResposta, ImagemCupom: string;
  AtipoImpressao: TTipoImpressao);
begin
   fsTipoImpressao   := AtipoImpressao;
   fsImagemCupom     := TStringList.Create;
   fsImagemCupom.Text:= ImagemCupom;
   fsResposta        := TStringList.Create;
   fsResposta.Text   := TextoResposta;
end;

destructor TRespostaTransacao.Destroy;
begin
   fsImagemCupom.Free;
   fsResposta.Free;
  inherited;
end;

{ Classe generica para TEF, nao implementa nenhum tipo especifico, apenas
  declara a Classe. NAO DEVE SER INSTANCIADA. Usada apenas como base para
  as demais Classes de TEF como por exemplo a classe TACBrTEFDiscado }
  
{ TACBrTEFClass }
constructor TACBrTEFClass.Create(AOwner: TComponent);
begin
   if not (AOwner is TACBrTEF) then
      raise Exception.create('Essa Classe deve ser instanciada por TACBrTEF');

   fpECF    := (AOwner as TACBrTEF).ECF ;

   fsImpressoesPendentes := TStringList.Create;

   fsOnAguardandoDadosGp := nil;
   
   fsLinhasEntreTentativas := 8;

   Comando  := TStringList.Create();
   Resposta := TStringList.Create();
   
   fpAtivo  := false ;
   fpTipoStr:= 'Não Definida' ;
   fpTimeOut:= 7;
   fpQtdVias:= 2;
   fsIdle   := True;

   fpCodFormaPagto   := '';
   fpCodComprovanteNaoFiscal  := '';   
end;

destructor TACBrTEFClass.Destroy;
var
  i: Integer;
begin
   Desativar; 
   fpECF    := nil ;
   
   Resposta.Free;
   Comando.Free;
   
   for i := fsImpressoesPendentes.Count - 1 downto 0 do
      fsImpressoesPendentes.Objects[i].Free;
   fsImpressoesPendentes.Free;
   inherited;  
end;


procedure TACBrTEFClass.SetAtivo(const Value: Boolean);
begin
  if Value then
     Ativar
  else
     Desativar ;
end;

procedure TACBrTEFClass.Ativar;
begin
   if Ativo then exit ;

   Ativo := True;
end;

procedure TACBrTEFClass.Desativar;
begin
   if not Ativo then exit ;

   fpAtivo := False;
end;


procedure TACBrTEFClass.MensagemCancelamento(ARede, ANSU, AValor: string);
const
   RS_CCOPERATOR = 'Rede: ';
   RS_TEFCANCELADO = 'Última transação TEF foi cancelada.';
   RS_TRANSACTIONNUMBER = 'NSU: ';
   RS_VALUE = 'Valor: ';
var
   tmpstr: string;
begin
   Try
      tmpstr := RS_TEFCANCELADO + #13#10 + RS_CCOPERATOR + ARede;
      if ANSU <> '' then
         tmpstr := tmpstr + #13#10 + RS_TRANSACTIONNUMBER + ANSU;
      if (AValor <> '') and (AValor <> '0') then
         tmpstr := tmpstr + #13#10 + RS_VALUE + CurrencyString + ' ' + FormatFloat('0.00', StrToFloat(AValor)/100);

      TfrmTimedMessage.ShowMessage(tmpstr);
   Except
      On Exc: Exception do
         MessageDlg('Ocorreu um erro mostrar a menssagen de cancelamento ! ' + Exc.Message, mtError, mbOKCancel, 0);
   end;
end;

procedure TACBrTEFClass.CancelaCupomTEF;
begin
   If NCN then
      fpECF.CancelaCupom;
end;

function TACBrTEFClass.CHQ(AValor: Double): Boolean;
var
  oldDecimalSeparator: char;
begin
   Result := False;
   Try
      fsIdle := False;
      try
         Comando.Clear;
         Comando.Add('000-000 = CHQ');
         oldDecimalSeparator := DecimalSeparator;
         DecimalSeparator := '.';

         try
            Comando.Add('003-000 = ' + StringReplace(FormatFloat('0.00', AValor), '.', '', [rfReplaceAll]));
         finally
            DecimalSeparator := oldDecimalSeparator;
         end;

         Comando.Add('999-999 = 0');
         Result := EnviaComando;
      finally
         fsIdle := True;
      end;
   Except
      On Exc: Exception do
         MessageDlg('Ocorreu um erro ao tentar chamar o CHQ ! ' + Exc.Message, mtError, mbOKCancel, 0);
   end;
end;

procedure TACBrTEFClass.CNC(ABandeira, ANSU: string; ADataTransacao,
  AHoraTransacao: TDateTime; AValor: Double);
var
  oldDecimalSeparator: char;
begin
   Try
      fsIdle := False;
      try
         // TODO - Testar este método pois nunca foi utilizado
         ABandeira := AnsiUpperCase(ABandeira);
         Comando.Clear;
         Comando.Add('000-000 = CNC');
         oldDecimalSeparator := DecimalSeparator;
         DecimalSeparator := '.';
         
         try
            Comando.Add('003-000 = ' + StringReplace(FormatFloat('0.00', AValor), '.', '', [rfReplaceAll]));
         finally
            DecimalSeparator := oldDecimalSeparator;
         end;

         Comando.Add('010-000 = ' + ABandeira);
         Comando.Add('012-000 = ' + ANSU);
         Comando.Add('022-000 = ' + FormatDateTime('ddmmyyyy', ADataTransacao));
         Comando.Add('023-000 = ' + FormatDateTime('hhnnss', AHoraTransacao));
         Comando.Add('999-999 = 0');
         EnviaComando;
      finally
         fsIdle := True;
      end;
   Except
      On Exc: Exception do
         MessageDlg('Ocorreu um erro ao tentar chamar o CNC ! ' + Exc.Message, mtError, mbOKCancel, 0);
   end;
end;

function TACBrTEFClass.CRT(AValor: Double): Boolean;
var
  oldDecimalSeparator: char;
begin
//   Result := False;
   fsIdle := False;
   try
      Comando.Clear;
      Comando.Add('000-000 = CRT');
      oldDecimalSeparator := DecimalSeparator;
      DecimalSeparator := '.';
      try
         Comando.Add('003-000 = ' + StringReplace(FormatFloat('0.00', AValor), '.', '', [rfReplaceAll]));
      finally
         DecimalSeparator := oldDecimalSeparator;
      end;
      // Comando.Add('777-777 = TESTE REDECARD'); // Teste 11 do roteiro REDECARD/TECBAN
      // Comando.Add('777-777 = TESTE HIPERCARD'); // Teste 03 do roteiro HIPERCARD
      Comando.Add('999-999 = 0');
      Result := EnviaComando;
   finally
      fsIdle := True;
   end;
end;

function TACBrTEFClass.EnviaComando: Boolean;
var
  Answered, AnswerDataReceived: Boolean;
  Start: TDateTime;
  ID: string;
  KeepWaiting: Boolean;
  i: Integer;
begin
   Result := False;
   Try
      ID := FormatDateTime('ddhhnnss', Now); // este campo permite apenas 10 bytes e o módulo REDECARD só trabalha com 8, caso contrário eu teria utilizado yyyymmddhhnnsszzz
      Comando.Insert(1, '001-000 = ' + ID);

      // Salva num arquivo temporário para garantir que o GP não vá pegar apenas um pedaço do arquivo sendo salvo
      Comando.SaveToFile(ReqTempFileName);

      // Se o GP não pegou um comando velho, azar o dele. (aqui é para o caso onde o GP é desligado antes de receber o CNF ou CNC);)
      if FileExists(Pchar(ReqFileName)) then
         DeleteFile(Pchar(ReqFileName));

     {a linha abaixo foi adicionada para dar um tempo entre a
      exclusao e a renomeação do arquivo, para evitar o
      problema da msg de gp não ativo}
      for i := 1 to 5 do
      begin
        Sleep(100);
        Application.ProcessMessages;
      end;
      
      // Renomeia, para garantir que o GP não vá pegar apenas um pedaço do arquivo sendo salvo
      RenameFile(ReqTempFileName, ReqFileName);
      Answered := False;
      Start := Now;
      while (not Answered) and (SecondsBetween(Now, Start) < Timeout) do
      begin
         Answered := FileExists(RespFileName);
         if Answered and (Copy(Comando[0], 11, MaxInt) <> 'ATV') and (Copy(Comando[0], 11, MaxInt) <> 'CNF') and (Copy(Comando[0], 11, MaxInt) <> 'NCN') then
         begin
            AnswerDataReceived := False;
            KeepWaiting := True;
            while not FileExists(RespDataFileName) or not AnswerDataReceived do
            begin
               Application.ProcessMessages;
               if FileExists(RespDataFileName) then
               begin
                  Resposta.Clear;
                  //Gravando o arquivo de backup
                  CopyFileTo(RespDataFileName, RespTempDataFileName, False);
                  for i := 1 to 5 do
                  begin
                     Sleep(200);
                     Application.ProcessMessages;
                  end;

                  Application.ProcessMessages;
                  Resposta.LoadFromFile(RespDataFileName);
                  Resposta.Text := StringReplace(Resposta.Text, ' = ', '=', [rfReplaceAll]);
                  AnswerDataReceived := StrToInt(ID) = StrToIntDef(Resposta.Values['001-000'], 0); // faz a comparação usando números inteiros por o VISANET remove os zeros a esquerda
                  if AnswerDataReceived then
                  begin
                     // apaga o arquivo de requisição se ainda existir no diretório, para o caso do GP
                     // não o apagar (quando se clica no encerra com o mouse, por exemplo
                     if FileExists(PChar(ReqFileName)) then
                        DeleteFile(PChar(ReqFileName));

                     ComandoEnviado := Copy(Comando[0], 11, MaxInt);
                     Result         := ProcessaResposta();
                     Break;
                  end
                  else
                  begin
                     DeleteFile(PChar(RespTempDataFileName));
                     DeleteFile(PChar(RespDataFileName));
                  end;
               end;
               if Assigned(fsOnAguardandoDadosGP) then
               begin
                  fsOnAguardandoDadosGP(Copy(Comando[0], 11, MaxInt), SecondsBetween(Now, Start), KeepWaiting);
                  if not KeepWaiting then
                     raise Exception.Create(RS_GPGONE);
               end;
            end;
         end;
      end;
      if not Answered then
         raise Exception.Create(RS_INACTIVETEF)
      else
         DeleteFile(PChar(RespFileName));
   Except
      On Exc: Exception do
         raise Exception.Create(Exc.Message);
   end;
end;

function TACBrTEFClass.GPAtivo: Boolean;
begin
   Result := False;
   Try
      Comando.Clear;
      Comando.Add('000-000 = ATV');
      Comando.Add('999-999 = 0');
      try
         EnviaComando;
         Result := True;
      except
         Result := False;
      end;
   Except
      On Exc: Exception do
         MessageDlg('Ocorreu um erro ao tentar verificar se o gerenciado padrão esta ativo ! ' + Exc.Message, mtError, mbOKCancel, 0);
   end;
end;

Procedure TACBrTEFClass.ImprimeCuponsPendentes;
var
  i: Integer;
  tmpResposta: TRespostaTransacao;
  Done, Printed, GPOk: Boolean;
  RetryCount: Integer;
  Retentar : Boolean;
begin
   try
      if fsImpressoesPendentes.Count > 0 then
      begin
         fsIdle := False;
         Retentar := fpECF.ReTentar;
         fpECF.ReTentar := False;
         try
            Done := False;
            Printed := False;
            i := 0;
            RetryCount := 0;
            tmpResposta := TRespostaTransacao(fsImpressoesPendentes.Objects[i]);
            while not done do
            begin
               if fsImpressoesPendentes.Count > 1 then
                  raise Exception.Create('Logica para pagamento com mais de um cartão não implementada!'); // não coloquei em resourcestring pq tem que implementar isso

               try
                  TravaTeclado;
                  if (RetryCount > 0) and (not Printed) then
                  begin
                     try
                        fpECF.FechaRelatorio;
                     except
                     end;
                     tmpResposta.TipoImpressao := tiGerencial;
                  end;  //if

                  if not Printed then
                  begin
                     case tmpResposta.TipoImpressao of
                     tiFiscal    :  ImprimeFiscalTEF(tmpResposta);
                     tiGerencial :  ImprimeGerencialTEF(tmpResposta);
                     else
                        raise Exception.Create(RS_PRINTERTYPENOTSUPPORTED);
                     end;
                     Printed := True;
                  end; //if not printed

                  //Envio o comando CNF
                  done := CNF;
                  DestravaTeclado;
               except
               on e: Exception do
               begin
                  if not Printed then
                  begin
                     DestravaTeclado;
                     done := MessageDlg(PChar(RS_ERROR + ': ' + RS_ECFOFFLINE), mtConfirmation, [mbYes,mbNo],0) = mrNo;
                     If not done then
                     begin
                        TravaTeclado;
                        ReprocessaResposta();
                        tmpResposta := TRespostaTransacao(fsImpressoesPendentes.Objects[i]);
                        inc(RetryCount);
                        Continue;
                     end;
                  end;

                  GPOk := false;
                  if done then
                  begin
                     while not GPOk do
                     begin
                        Comando.Clear;
                        Comando.Add('000-000 = NCN');
                        Comando.Add('010-000 = ' + tmpResposta.Resposta.Values['010-000']);
                        Comando.Add('012-000 = ' + tmpResposta.Resposta.Values['012-000']);
                        Comando.Add('027-000 = ' + tmpResposta.Resposta.Values['027-000']);
                        Comando.Add('999-999 = 0');
                        try
                           EnviaComando;
                           MensagemCancelamento(Resposta.Values['010-000'], Resposta.Values['012-000'], Resposta.Values['003-000']);
                           tmpResposta.Free;
                           fsImpressoesPendentes.Clear;
                           DeleteFile(PChar(RespTempDataFileName));
                           DeleteFile(PChar(RespDataFileName));
                           try
                              gpok := True;
                            //  fpECF.FechaRelatorio;
                              fpECF.CancelaCupom;
                           except
                           end;
                        except
                           on e: Exception do
                           begin
                              DestravaTeclado;
                              {$IFDEF VisualCLX}
                               QWidget_setActiveWindow(fpHandle);
                               Application.MessageBox(E.Message,'Erro',[smbOK],smsCritical) ;
                              {$ELSE}
                               SetForeGroundWindow(fpHandle);
                               MessageBox(fpHandle, PChar(E.Message), 'Erro', MB_ICONERROR + MB_OK);
                              {$ENDIF}
                              gpok := false;
                           end;
                        end;
                     end;
                     Raise;
                  end
                  else
                     Inc(RetryCount);
                     DestravaTeclado;
                     if Not gpok then
                     begin
                        {$IFDEF VisualCLX}
                         QWidget_setActiveWindow(fpHandle);
                         Application.MessageBox(E.Message,'Erro',[smbOK],smsCritical) ;
                        {$ELSE}
                         SetForeGroundWindow(fpHandle);
                         MessageBox(fpHandle, PChar(E.Message), 'Erro', MB_ICONERROR + MB_OK);
                        {$ENDIF}
                     end;
                  end;
               end;
            end;
            tmpResposta.Free;
            fsImpressoesPendentes.Clear;
            DeleteFile(PChar(RespTempDataFileName));
            DeleteFile(PChar(RespDataFileName));
         finally
            fsIdle := True;
            fpECF.ReTentar := Retentar;
         end;
      end;
   except
      on Exc: Exception do
         Raise Exception.Create('Ocorreu um erro ao tentar Imprimir o(s) Cupom(s) Pendente(s)!'+ #13#10 + Exc.Message);
   end;
end;


function TACBrTEFClass.NCN: Boolean;
var
  tmpResposta: TRespostaTransacao;
  done: Boolean;
begin
   Result := False;
   Try
      if (ImpressoesPendentes.Count > 0) then
      begin
         fsIdle := False;
         tmpResposta := TRespostaTransacao(ImpressoesPendentes.Objects[0]);
         try
            done := False;
            while not done do
            begin
               Comando.Clear;
               Comando.Add('000-000 = NCN');
               Comando.Add('010-000 = ' + tmpResposta.Resposta.Values['010-000']);
               Comando.Add('012-000 = ' + tmpResposta.Resposta.Values['012-000']);
               //Comando.Add('025-000 = ' + tmpResposta.Resposta.Values['025-000']);
               Comando.Add('027-000 = ' + tmpResposta.Resposta.Values['027-000']);
               Comando.Add('999-999 = 0');
               try
                  Result := EnviaComando;
                  MensagemCancelamento(Resposta.Values['010-000'], Resposta.Values['012-000'], Resposta.Values['003-000']);
                  try
                     fpECF.FechaRelatorio;
                  except
                  end;
                  done := True;
               except
                  on e: Exception do
                  begin
                     MessageDlg(PChar(RS_ERROR + ': ' + E.Message), mtError, mbOKCancel, 0);
                     done := False;
                  end;
               end;
            end;
         finally
            fsIdle := True;

            tmpResposta.Free;
            fsImpressoesPendentes.Clear;
            DeleteFile(PChar(RespTempDataFileName));
            DeleteFile(PChar(RespDataFileName));
         end;
      end;
   Except
      On Exc: Exception do
         MessageDlg('Ocorreu um erro ao tentar chamar o NCN Ultima da Transacao ! ' + Exc.Message, mtError, mbOKCancel, 0);
   end;
end;

procedure TACBrTEFClass.VerificaTransacaoPendente;
begin
   Try
      if (FileExists(RespDataFileName)) or (FileExists(RespTempDataFileName)) then
      begin
         fsIdle := False;
         try
            Resposta.Clear;

            if FileExists(RespDataFileName) then
               Resposta.LoadFromFile(RespDataFileName)
            else
               Resposta.LoadFromFile(RespTempDataFileName);

            Resposta.Text := StringReplace(Resposta.Text, ' = ', '=', [rfReplaceAll]);
            Comando.Clear;
            if trim(Resposta.Values['009-000']) <> '0' then
               Exit;

            Comando.Add('000-000 = NCN');
            Comando.Add('010-000 = ' + Resposta.Values['010-000']);
            Comando.Add('012-000 = ' + Resposta.Values['012-000']);
            Comando.Add('027-000 = ' + Resposta.Values['027-000']);
            Comando.Add('999-999 = 0');
            EnviaComando;
            MensagemCancelamento(Resposta.Values['010-000'], Resposta.Values['012-000'], Resposta.Values['003-000']);

            DeleteFile(PChar(RespTempDataFileName));
            DeleteFile(PChar(RespDataFileName));

            fsImpressoesPendentes.Clear;
            try
               fpECF.FechaRelatorio;
            except
            end;
         finally
            fsIdle := True;
         end;
      end;
   Except
      On Exc: Exception do
         MessageDlg('Ocorreu um erro ao tentar Verificar Transações Pendentes ! ' + Exc.Message, mtError, mbOKCancel, 0);
   end;
end;

function TACBrTEFClass.VendaTEF(CodFormaPagto: String; Valor: Double): Boolean;
begin
   Result   := False;

   fpCodFormaPagto:= CodFormaPagto;
   fpValorTEF     := Valor;

   if CRT(fpValorTEF) then
      Result   := True; // Se tudo der certo!!!
end;

function TACBrTEFClass.VendaCheque(CodFormaPagto: String; Valor: Double): Boolean;
begin
   Result   := False;

   fpCodFormaPagto:= CodFormaPagto;
   fpValorTEF     := Valor;

   if CHQ(fpValorTEF) then
      Result   := True; // Se tudo der certo!!!
end;

function TACBrTEFClass.FechaVendaTEF(CodFormaPagto: String; CodComprovanteNaoFiscal: String; Valor: Double; Observacao: String = ''): Boolean;
begin
   Result   := False;

   fpCodFormaPagto:= CodFormaPagto;
   fpCodComprovanteNaoFiscal  := CodComprovanteNaoFiscal;
   fpValorTEF     := Valor;

   if CRT(Valor) then
   begin
      try
        // TravaTeclado;
         fpECF.EfetuaPagamento(fpCodFormaPagto, ValorTotal, '',True); // Efetua o Pagamento do Cupom Fiscal
         fpECF.FechaCupom(Observacao); // Efetua o fechamento do Cupom Fiscal
         ImprimeCuponsPendentes;  // Imprime os comprovantes retornados pelo GP
         Result   := True; // Se tudo der certo!!!
      except
         if ImpressoesPendentes.Count > 0 then
            NCN;
         Raise;
      end;
   end;
end;

function TACBrTEFClass.FechaVendaCheque(CodFormaPagto: String; CodComprovanteNaoFiscal: String; Valor: Double; Observacao: String = ''): Boolean;
begin
   Result   := False;

   fpCodFormaPagto:= CodFormaPagto;
   fpCodComprovanteNaoFiscal  := CodComprovanteNaoFiscal;
   fpValorTEF     := Valor;

   if CHQ(Valor) then
   begin
      try
         fpECF.EfetuaPagamento(fpCodFormaPagto, Valor, '',True); // Efetua o Pagamento do Cupom Fiscal
         fpECF.FechaCupom(Observacao); // Efetua o fechamento do Cupom Fiscal
         ImprimeCuponsPendentes;  // Imprime os comprovantes retornados pelo GP
         Result   := True; // Se tudo der certo!!!
      except
         if ImpressoesPendentes.Count > 0 then
            NCN;
         Raise;
      end;
   end;
end;

procedure TACBrTEFClass.ADM;
begin
   fsIdle := False;
   try
      Comando.Clear;
      Comando.Add('000-000 = ADM');
      Comando.Add('999-999 = 0');
      EnviaComando;

      if ImpressoesPendentes.Count > 0 then
         ImprimeCuponsPendentes;
   finally
      fsIdle := True;
   end;
end;

function TACBrTEFClass.ProcessaResposta(): Boolean;
var
  i: Integer;
  LinesToPrintCount: Integer;
  tmpIndex, tmpTimeToWait: Integer;
  tmpstr: TStringList;
begin
   Result := False;
   Try
      tmpIndex := Resposta.IndexOfName('009-000');
      if tmpIndex <> -1 then
         Result := Resposta.Values['009-000'] = '0' ;

      tmpIndex := Resposta.IndexOfName('030-000');
      if tmpIndex <> -1 then
      begin
         if Result and (StrToIntDef(Resposta.Values['028-000'], 0) > 0) then
            tmpTimeToWait := TimeOut
         else
            tmpTimeToWait := 0;

         TfrmTimedMessage.ShowMessage(Resposta.Values['030-000'], tmpTimeToWait);
      end
      else
         TfrmTimedMessage.ShowMessage('Aguarde a impressão do comprovante', TimeOut);

      fsImpressoesPendentes.Clear;
      LinesToPrintCount := 0;
      tmpIndex := Resposta.IndexOfName('028-000');
      if tmpIndex <> -1 then
      begin
         LinesToPrintCount := StrToInt(Resposta.Values['028-000']);
         if LinesToPrintCount > 0 then
         begin
            tmpstr := TStringList.Create;
            try
               for i := 1 to LinesToPrintCount do
                  tmpstr.Add(StringReplace(Resposta.Values['029-' + FormatFloat('000', i)], '"', '', [rfReplaceAll]));

               // Salvar uma copia da resposta para poder tratar queda de energia!!
               // não é permitido sobre ipótese nenhuma o armazenamento do cupom tef
               // tmpstr.SaveToFile(TEFPrintBufferFile);

               fsImpressoesPendentes.AddObject(Resposta.Values['001-000'],
                  TRespostaTransacao.Create(Resposta.Text, tmpstr.Text,
                  ArrTipoImpressao[(ComandoEnviado = 'CRT') or (ComandoEnviado = 'CHQ')]));
            finally
               tmpstr.Free;
            end;
         end;
      end;
      if LinesToPrintCount = 0 then
      begin
         DeleteFile(PChar(RespTempDataFileName));
         DeleteFile(PChar(RespDataFileName));
      end;
   Except
      On Exc: Exception do
         MessageDlg('Ocorreu um erro ao tentar Processar a Resposta ! ' + Exc.Message, mtError, mbOKCancel, 0);
   end;
end;

procedure TACBrTEFClass.DestravaTeclado;
var xBlockInput : function (Block: Boolean): Boolean; stdcall;
begin
  {$IFDEF MSWINDOWS}
   if FunctionDetect ('USER32.DLL', 'BlockInput', @xBlockInput) then
      xBlockInput(False)  // Disable Keyboard & mouse
   else
      fpECF.BloqueiaMouseTeclado := False;
  {$ENDIF}
end;

procedure TACBrTEFClass.TravaTeclado;
var xBlockInput : function (Block: Boolean): Boolean; stdcall;
begin
  {$IFDEF MSWINDOWS}
   if FunctionDetect ('USER32.DLL', 'BlockInput', @xBlockInput) then
      xBlockInput(True)  // Disable Keyboard & mouse
   else
      fpECF.BloqueiaMouseTeclado := True;
  {$ENDIF}
end;

procedure TACBrTEFClass.LineFeed(ALineCount: Integer);
begin
   fpECF.PulaLinhas(ALineCount);
end;

function TACBrTEFClass.ImprimeFiscalTEF(Resposta: TRespostaTransacao): boolean;
var
  tmp: TStringList;
begin
   tmp := TStringList.Create;
   try
      tmp.Text := Resposta.ImagemCupom.Text;
      fpECF.CupomVinculado(fpECF.NumCupom, fpCodFormaPagto, fpCodComprovanteNaoFiscal, fpValorTEF, tmp, fpQtdVias);
      Result := True;
   finally
      tmp.Free;
   end;
end;

function TACBrTEFClass.ImprimeGerencialTEF(Resposta: TRespostaTransacao): Boolean;
var
  tmp: TStringList;
begin
   tmp := TStringList.Create;
   try
      tmp.Text := Resposta.ImagemCupom.Text;
      fpECF.RelatorioGerencial(tmp, fpQtdVias);
      Result := True;
   finally
      tmp.Free;
   end;
end;

function TACBrTEFClass.ReprocessaResposta(): Boolean;
var
  i: Integer;
  LinesToPrintCount: Integer;
  tmpIndex: Integer;
  tmpstr: TStringList;
begin
   Result := False;
   Try
      tmpIndex := Resposta.IndexOfName('009-000');
      if tmpIndex <> -1 then
         Result := Resposta.Values['009-000'] = '0';
         
      LinesToPrintCount := 0;
      tmpIndex := Resposta.IndexOfName('028-000');
      if tmpIndex <> -1 then
      begin
         LinesToPrintCount := StrToInt(Resposta.Values['028-000']);
         if LinesToPrintCount > 0 then
         begin
            fsImpressoesPendentes.Clear;
            tmpstr := TStringList.Create;
            try
               for i := 1 to LinesToPrintCount do
                  tmpstr.Add(StringReplace(Resposta.Values['029-' + FormatFloat('000', i)], '"', '', [rfReplaceAll]));

               // Salvar uma copia da resposta para poder tratar queda de energia!!
               // tmpstr.SaveToFile(TEFPrintBufferFile);

               fsImpressoesPendentes.AddObject(Resposta.Values['001-000'],
                  TRespostaTransacao.Create(Resposta.Text, tmpstr.Text,
                  ArrTipoImpressao[(ComandoEnviado = 'CRT') or (ComandoEnviado = 'CHQ')]));
            finally
               tmpstr.Free;
            end;
         end;
      end;
      if LinesToPrintCount = 0 then
      begin
         DeleteFile(PChar(RespTempDataFileName));
         DeleteFile(PChar(RespDataFileName));
      end;
   Except
      On Exc: Exception do
         MessageDlg('Ocorreu um erro ao tentar Reprocessar a Resposto do TEF ! ' + Exc.Message, mtError, mbOKCancel, 0);
   end;
end;

function TACBrTEFClass.CNF: Boolean;
var
  tmpResposta: TRespostaTransacao;
begin
   Result   := False;
   Try
      if ImpressoesPendentes.Count > 0 then
      begin
         tmpResposta := TRespostaTransacao(ImpressoesPendentes.Objects[0]);

         Comando.Clear;
         Comando.Add('000-000 = CNF');
         Comando.Add('010-000 = ' + tmpResposta.Resposta.Values['010-000']);
         Comando.Add('012-000 = ' + tmpResposta.Resposta.Values['012-000']);
         Comando.Add('027-000 = ' + tmpResposta.Resposta.Values['027-000']);
         Comando.Add('999-999 = 0');
         EnviaComando;

         Result   := True;
      end;
   Except
      On Exc: Exception do
         Raise;
   end;
end;

{ -------------------------------- TACBrTEFParcelas -------------------------- }

procedure TACBrTEFClass.CarregaParcelas;
var tmpParcela: TACBrTEFParcela;
    iAux: Integer;
    dateAux: String;
    OldShortDateFormat: String;
begin
   OldShortDateFormat := ShortDateFormat;

   If Assigned( fpParcelas ) then
      fpParcelas.Free ;

   fpParcelas  := TACBrTEFParcelas.Create( true ) ;

   // Capturar as parcelas da resposta do TEF
   if NroParcelas > 0 then
   begin
      for iAux := 1 to NroParcelas do
      begin
         tmpParcela := TACBrTEFParcela.create ;
         dateAux := Resposta.Values['019-' + FormatFloat('000', iAux)] ;
         try
            ShortDateFormat := 'ddmmyyyy' ;
            tmpParcela.Vencimento := StringToDateTimeDef(dateAux, now) ;
         finally
            ShortDateFormat := OldShortDateFormat ;
         end ;
         tmpParcela.Valor      := StrToFloatDef(Resposta.Values['020-' + FormatFloat('000', iAux)], 0) / 100 ;
         tmpParcela.NSUParcela := StrToIntDef(Resposta.Values['021-' + FormatFloat('000', iAux)], 0) ;
         fpParcelas.Add(tmpParcela) ;
      end;
   end;
end;

function TACBrTEFClass.GetParcelas: TACBrTEFParcelas;
begin
   if not Assigned( fpParcelas ) then
     CarregaParcelas ;

  result := fpParcelas ;
end;

{ TACBrTEFParcela }

constructor TACBrTEFParcela.create;
begin
   fsValorParcela := 0 ;
   fsNSUParcela   := 0 ;
end;

function TACBrTEFParcelas.Add(Obj: TACBrTEFParcela): Integer;
begin
   Result := inherited Add(Obj) ;
end;

function TACBrTEFParcelas.GetObject(Index: Integer): TACBrTEFParcela;
begin
   Result := inherited GetItem(Index) as TACBrTEFParcela ;
end;

procedure TACBrTEFParcelas.Insert(Index: Integer; Obj: TACBrTEFParcela);
begin
   inherited Insert(Index, Obj);
end;

procedure TACBrTEFParcelas.SetObject(Index: Integer;
  Item: TACBrTEFParcela);
begin
   inherited SetItem (Index, Item) ;
end;

{ Metodos para capturar informação das transações }

{ Obs. Verificar se esses medotos devem ser realmente implementados aqui }
{ ou na classe expecifica de cada TEF}

function TACBrTEFClass.GetCodAutTransacao: Integer;
begin
   // Código de autorização da transação
   Result := StrToIntDef(Resposta.Values['013-000'], 0);
end;

function TACBrTEFClass.GetNomeRede: String;
begin
   // Nome da rede
   Result := Resposta.Values['010-000'];
end;

function TACBrTEFClass.GetNroLoteTransacao: Integer;
begin
   // Numero do lote da transação
   Result := StrToIntDef(Resposta.Values['014-000'], 0);
end;

function TACBrTEFClass.GetNroParcelas: Integer;
begin
   // Numero de parcelas da transação
   Result := StrToIntDef(Resposta.Values['018-000'], 0);
end;

function TACBrTEFClass.GetNroTransacaoNSU: Integer;
begin
   // Numero NSU da transação
   Result := StrToIntDef(Resposta.Values['012-000'], 0);
end;

function TACBrTEFClass.GetStatusTransacao: Integer;
begin
   // Status da transação
   Result := StrToIntDef(Resposta.Values['009-000'], -1);
end;

function TACBrTEFClass.GetTipoParcelamento: Integer;
begin
   // Tipo de parcelamento
   Result := StrToIntDef(Resposta.Values['017-000'], 0);
end;

function TACBrTEFClass.GetTipoTransacao: Integer;
begin
   // Tipo da transação
   Result := StrToIntDef(Resposta.Values['011-000'], 99);
end;

function TACBrTEFClass.GetHeader: String;
begin
   // Header da resposta após processamento
   Result := Resposta.Values['000-000'];
end;

function TACBrTEFClass.GetValorTotal: Double;
begin
   // Valor total da transação
   Result := StrToFloatDef(Resposta.Values['003-000'], 0) / 100;
end;

end.
