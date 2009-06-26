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
|* 06/08/2007: Maicon da Silva Evangelista
|*  - Concluida a migração do código original "Valdir Stiebe Junior" para a
|*   plataforma ACBr, foi gerada as classes ACBrTEF, ACBrTEFClass, ACBrTEFDial,
|*   ACBrTEFDisc, ACBrTEFHiper.
|* 25/09/2007: Daneial Simões
|*  - Adiciona a mensagem de aviso sobre o uso do ACBrTEF, na ativação do
|*   ACBrTEF.
|* 27/02/2008: Maicon da Silva Evangelista
|*  - Definindo Propriedades do ACBrTEF como Rede, Nº Parcelas, NSU...
|*  - Criado o array para controle das bandeiras
|*  - Criado o tipo para armazenar as parcelas
|*  - Criada a Lista de Objetos do tipo TACBrTEFParcelas
|* 03/04/2008: Jhony Alceu Pereira (JhonyStein)
|*  - Criada propriedade que grava o arquivo temporário da resposta do GP
|*   para caso de queda de energia cancelar a trasação (RespTempDataFileName)
|* 10/04/2008: Jhony Alceu Pereira (JhonyStein)
|*  - Correção da property Parcelas
|*  - Implementação da venda por Cheque
|* 17/04/2008: Jhony Alceu Pereira (JhonyStein)
|*  - Removida consistência de impressora fiscal ativa na ativação do TEF/GP
|* 03/07/2008: Maicon da Silva Evangelista
|*  - Adcionada propriedade Ignora ECF Desligado
|*  - Substituido alguns messageDlg por MessageBox para poder passar o handle
|*    da janela, pois estava tendo problema com foco
|*  - Foi alterada as funções  FechavendaTEF e FechavendaCartao, agora pode ser
|*    passado o handle da janela atual
|* 27/05/2009: Maicon da Silva Evangelista
|*  - Foram criadas as funções -VendaTEF e -VendaCheque que faram as vendas TEF
|*    sem fechar o cupom fiscal no final, possibilitando o pagamento com
|*    multiplos cartões.
|*
|*  TODO
|*  - Verificar tratamente de queda de energia para multiplos pagamento.
|*  -
*******************************************************************************}

{*Componente para realizar transações por meio do sistema TEF*}

{$I ACBr.inc}
unit ACBrTEF;

interface
uses Classes, SysUtils, ACBrBase, ACBrTEFClass, ACBrECF  { Units da ACBr}
     {$IFDEF COMPILER6_UP}
       ,DateUtils, StrUtils
     {$ELSE}
       ,ACBrD5
     {$ENDIF}
     {$IFDEF VisualCLX}
       ,Qt, QControls, QForms, QGraphics, QDialogs, QExtCtrls
     {$ELSE}
       ,Contnrs, Controls, Forms, Graphics, Dialogs, ExtCtrls, Windows
     {$ENDIF} ;

type
   TACBrTEFTipo = (tefNenhum, tefDial, tefDisc, tefHiper) ;

{ Componente ACBrTEF }
TACBrTEF = class ( TACBrComponent )
   private
      fsTipo   : TACBrTEFTipo;
      fsTEF    : TACBrTEFClass ;
      fsECF    : TACBrECF;

      fsAtivo  :  Boolean;

      {$IFDEF VisualCLX}
       fsHandle :  QWidgetH;
      {$ELSE}
       fsHandle :  THandle;
      {$ENDIF}

      procedure SetTipo(const Value: TACBrTEFTipo);
      procedure SetECF(const Value: TACBrECF);
      procedure SetQtdVias(const Value: Integer);
      procedure SetAtivo(const Value: Boolean);
      procedure SetConsultarCheques(const Value: Boolean);
      procedure SetAtivarGP(const Value: Boolean);
      procedure SetTimeOut(const Value: Integer);
      procedure SetGuilhotina(const Value: Boolean);
      procedure SetIgnoraECFDesativado(const Value: Boolean);

      procedure SetBaseDir(const Value: String);
      procedure SetReqTempFile(const Value: String);
      procedure SetReqFile(const Value: String);
      procedure SetRespDataFile(const Value: String);
      procedure SetRespFile(const Value: String);
      procedure SetRespTempDataFile(const Value: String);

      Procedure MsgAviso;

      //Metodo de Gravação do Evento
      procedure SetOnAguardandoDadosGP( const Value: TACBrAguardandoDadosGP );
      procedure SetOnPagtoNaoAutorizado( const Value: TACBrPagtoNaoAutorizado );

      function GetAtivarGP: Boolean;
      function GetConsultarCheques: Boolean;
      function GetTipoStrClass: String;
      function GetQtdVias     : Integer;
      function GetTimeOut     : Integer;
      function GetGuilhotina  : Boolean;
      function GetIgnoraECFDesativado  : Boolean;

      function GetBaseDir         : String;
      function GetReqTempFile     : String;
      function GetReqFile         : String;
      function GetRespDataFile    : String;
      function GetRespFile        : String;
      function GetRespTempDataFile: String;

      //Metodo de Leitura do Evento
      function GetOnAguardandoDadosGP  :  TACBrAguardandoDadosGP ;
      function GetOnPagtoNaoAutorizado :  TACBrPagtoNaoAutorizado;

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

      function GetParcelasClass: TACBrTEFParcelas;

   protected
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;

   public
      Constructor Create(AOwner: TComponent); override;
      Destructor Destroy  ; override ;

      procedure Ativar; //  Ativa o TEF
      procedure Desativar; // Desativa o TEF
      property Ativo : Boolean read fsAtivo write SetAtivo ;

      property TEF   : TACBrTEFClass read fsTEF;

      Function GPAtivo: Boolean; // Verifica se o Gerenciador padrão esta ativo
      Procedure ADM; // Chama o Modulo Adminstrativo do GP

      {$IFDEF VisualCLX}
       Function VendaTEF(CodFormaPagto: String;  Valor: Double; fpHandle: QWidgetH): Boolean; // Realiza uma venda TEF sem fechar o cupom fiscal
       Function VendaCheque(CodFormaPagto: String;  Valor: Double; fpHandle: QWidgetH): Boolean; // Realiza uma venda Cheque sem fechar o cupom fiscal

       Function FechaVendaTEF(CodFormaPagto: String; CodComprovanteNaoFiscal: String; Valor: Double; fpHandle: QWidgetH; Observacao: String = '') : Boolean; // Fecha a venda com TEF
       Function FechaVendaCheque(CodFormaPagto: String; CodComprovanteNaoFiscal: String; Valor: Double; fpHandle: QWidgetH; Observacao: String = '') : Boolean; // Fecha a venda com Cheque
      {$ELSE}
       Function VendaTEF(CodFormaPagto: String; Valor: Double; fpHandle: THandle = 0): Boolean; // Realiza uma venda TEF sem fechar o cupom fiscal
       Function VendaCheque(CodFormaPagto: String; Valor: Double; fpHandle: THandle = 0): Boolean; // Realiza uma venda Cheque sem fechar o cupom fiscal

       Function FechaVendaTEF(CodFormaPagto: String; CodComprovanteNaoFiscal: String; Valor: Double; fpHandle: THandle = 0; Observacao: String = '') : Boolean; // Fecha a venda com TEF
       Function FechaVendaCheque(CodFormaPagto: String; CodComprovanteNaoFiscal: String; Valor: Double; fpHandle: THandle = 0; Observacao: String = '') : Boolean; // Fecha a venda com Cheque
      {$ENDIF}
      
      procedure CancelaCupomTEF; // Cancela a ultima transação TEF e o seu Cupom
      function NCN: Boolean; // Não confirmação da venda e/ ou da impressão

      procedure VerificaTransacaoPendente; //Verifica se existe alguma transação pendente (Queda de Energia)

      Property TipoStr  : String read GetTipoStrClass;

      Property Header            :  String read GetHeader; // Indica o início do arquivo e o tipo de operação relacionada ao arquivo
      Property StatusTransacao   :  Integer read GetStatusTransacao; // 0 - Aprovada; Outro valor para não aprovada
      Property NomeRede          :  String read GetNomeRede; // AMEX - REDECARD - VISANET
      Property TipoTransacao     :  Integer read GetTipoTransacao;  // Código identificando o tipo da transação executada
      Property NroTransacaoNSU   :  Integer read GetNroTransacaoNSU;  // Indica o número de seqüência (NSU - Número Sequencial Único) da transação atribuído pelo Host (Sistema das Redes de Cartão que recebe e trata as solicitações das transações TEF).
      Property CodAutTransacao   :  Integer read GetCodAutTransacao;  // Indica o número de autorização da transação atribuída pelo Host.
      Property NroLoteTransacao  :  Integer read GetNroLoteTransacao; // Indica o número de lote da transação
      Property TipoParcelamento  :  Integer read GetTipoParcelamento; // Indica o tipo de parcelamento aplicado à operação: 0 - parcelado estabelecimento / 1 - parcelado administradora
      Property NroParcelas       :  Integer read GetNroParcelas; // Indica o número de parcelas no caso de transações Parceladas (Crédito ou Débito).
      Property ValorTotal        :  Double read GetValorTotal; // Valor total desta forma de pagamento.

      Property Parcelas : TACBrTEFParcelas read GetParcelasClass;
      procedure CarregaParcelas ;

      Function ImpressoesPendentes: Boolean;//Verifica se existe cupom pendente
      Procedure ImprimeCuponsPendentes; //Imprime os Cupom pendentes;
   published
      property ECF      :  TACBrECF read fsECF write SetECF ;
      property Tipo     :  TACBrTEFTipo read fsTipo write SetTipo default tefNenhum;

      property BaseDir             : String read GetBaseDir write SetBaseDir;
      property ReqTempFileName     : String read GetReqTempFile write SetReqTempFile;
      property ReqFileName         : String read GetReqFile write SetReqFile;
      property RespDataFileName    : String read GetRespDataFile write SetRespDataFile;
      property RespFileName        : String read GetRespFile write SetRespFile;
      property RespTempDataFileName: String read GetRespTempDataFile write SetRespTempDataFile;

      property NumVias  : Integer read GetQtdVias write SetQtdVias;
      property TimeOUT  :  Integer read GetTimeOut write SetTimeOut;

      Property ConsultarCheques: Boolean read GetConsultarCheques write SetConsultarCheques
                  default true ;

      Property AtivarGP: Boolean read GetAtivarGP write SetAtivarGP
                  default true ;

      property AcionarGuilhotina :  Boolean read GetGuilhotina write SetGuilhotina
                  default true ;

      property IgnoraECFDesativado :  Boolean read GetIgnoraECFDesativado write SetIgnoraECFDesativado
                  default true ;

      {$IFDEF VisualCLX}
       property Handle   :  QWidgetH read fsHandle write fsHandle;
      {$ELSE}
       property Handle   :  Cardinal read fsHandle write fsHandle;
      {$ENDIF}

      // Eventos do Componente
      property OnAguardandoDadosGP : TACBrAguardandoDadosGP
        read GetOnAguardandoDadosGP write SetOnAguardandoDadosGP ;
      property OnPagtoNaoAutorizado : TACBrPagtoNaoAutorizado
        read GetOnPagtoNaoAutorizado write SetOnPagtoNaoAutorizado ;
   end;

const
   RS_ERROR = 'Erro';
   RS_INACTIVETEF = 'O gerenciador padrão (TEF) não está ativo!';
   RS_MISSINGPATH = 'É necessário configurar a nomenclatura dos arquivos utilizados no TEF!';
   RS_GPGONE = 'O gerenciador padrão não respondeu com dados!';
   RS_ECFOFFLINE = 'Impressora não responde! Tentar novamente?';
   RS_ECFDESLIGADA = 'Impressora Fiscal ( ECF ) não esta ativa !';
   RS_PRINTERTYPENOTSUPPORTED = 'Tipo de impressão não suportado!';

implementation
Uses ACBrTEFDial, ACBrTEFDisc, ACBrTEFHiper;

{ ACBrTEF }
Constructor TACBrTEF.Create(AOwner: TComponent);
begin
  inherited create( AOwner );

  fsAtivo:= False ;
  fsTipo := tefNenhum ;

  { Instanciando fsTEF com modelo Generico (TEFClass) }
  fsTEF := TACBrTEFClass.create( self ) ;
end;

Destructor TACBrTEF.Destroy;
begin
   Ativo := false ;

   if Assigned( fsTEF ) then
      FreeAndNil( fsTEF ) ;

   inherited Destroy;
end;

procedure TACBrTEF.SetAtivo(const Value: Boolean);
begin
  if Value then
     Ativar
  else
     Desativar ;
end;

function TACBrTEF.GetTipoStrClass: String;
begin
   result   := fsTEF.TipoStr;
end;

procedure TACBrTEF.SetTipo(const Value: TACBrTEFTipo);
var
   wTimeOut, wNumVias:  Integer;
   wConsultarCheques :  Boolean;
   wAcionarGuilhotina:  Boolean;
   wAtivarGP         :  Boolean;
begin
   if fsTipo = Value then exit ;

   if fsAtivo then
      raise Exception.Create('Não é possível mudar o Tipo com ACBrTEF Ativo');

   wTimeOut             := TimeOUT;
   wNumVias             := NumVias;
   wConsultarCheques    := ConsultarCheques;
   wAcionarGuilhotina   := AcionarGuilhotina;
   wAtivarGP            := AtivarGP;

   FreeAndNil( fsTEF ) ;

   { Instanciando uma nova classe de acordo com fsTipo }
   case Value of
      tefDial  : fsTEF := TACBrTEFDial.create( Self ) ;
      tefDisc  : fsTEF := TACBrTEFDisc.create( Self ) ;
      tefHiper : fsTEF := TACBrTEFHiper.create( Self ) ;
   else
      fsTEF  := TACBrTEFClass.create( Self ) ;
   end;

   TimeOUT           := wTimeOut;
   NumVias           := wNumVias;
   ConsultarCheques  := wConsultarCheques;
   AcionarGuilhotina := wAcionarGuilhotina;
   AtivarGP          := wAtivarGP;
   
   fsTipo := Value;
end;

procedure TACBrTEF.SetECF(const Value: TACBrECF);
begin
   if Value <> fsECF then
   begin
      if Assigned(fsECF) then
         fsECF.RemoveFreeNotification(Self);

      fsECF     := Value;
      fsTEF.ECF := Value ;

      if Value <> nil then
         Value.FreeNotification(Self);
   end ;
end;

procedure TACBrTEF.SetQtdVias(const Value: Integer);
begin
   if Value < 2 then
    fsTEF.NumVias   := 2
  else
    fsTEF.NumVias   := Value;
end;

procedure TACBrTEF.SetTimeOut(const Value: Integer);
begin
   fsTEF.TimeOut := Value;
end;

function TACBrTEF.GetConsultarCheques: Boolean;
begin
   result   := fsTEF.ConsultarCheques;
end;

procedure TACBrTEF.SetConsultarCheques(const Value: Boolean);
begin
   fsTEF.ConsultarCheques := Value;
end;

procedure TACBrTEF.Ativar;
begin
   if fsAtivo then exit;
   if fsTipo = tefNenhum then
      raise Exception.Create('Tipo não definido !');
   if Not Assigned(fsECF) then
      raise Exception.Create('ECF não informado !');
//   Na roteiro da VISA o componente TEF deve ser habilitado, mesmo que a impressora esteja inoperante ou desligada
   If (Not fsECF.Ativo) and (Not IgnoraECFDesativado) then
      raise Exception.Create('ECF não esta ativo !');
//   MsgAviso;
   fsTEF.Ativar;
   fsAtivo := true;
   // tratamento de queda de energia
   if fsTEF.Ativo then
      fsTEF.VerificaTransacaoPendente;
end;

procedure TACBrTEF.Desativar;
begin
   if not fsAtivo then exit ;

   fsTEF.Desativar ;
   fsAtivo := false;
end;

{$IFDEF VisualCLX}
Function TACBrTEF.VendaTEF(CodFormaPagto: String;  Valor: Double; fpHandle: QWidgetH): Boolean;
{$ELSE}
Function TACBrTEF.VendaTEF(CodFormaPagto: String; Valor: Double; fpHandle: THandle = 0): Boolean;
{$ENDIF}
begin
   If Not Ativo then
      AtivarGP;

   If Not fsECF.Ativo then
      raise Exception.Create(RS_ECFDESLIGADA);

   fsTEF.Handle   := fpHandle;

   try
      result   := fsTEF.VendaTEF(CodFormaPagto, Valor);
   except
      on Exc: Exception do
      begin
         {$IFDEF VisualCLX}
          QWidget_setActiveWindow(fpHandle);
         {$ELSE}
          SetForeGroundWindow(fpHandle);
         {$ENDIF}
         Raise Exception.Create(Exc.Message);
      end;
   end;
end;

{$IFDEF VisualCLX}
Function TACBrTEF.VendaCheque(CodFormaPagto: String;  Valor: Double; fpHandle: QWidgetH): Boolean;
{$ELSE}
Function TACBrTEF.VendaCheque(CodFormaPagto: String;  Valor: Double; fpHandle: THandle = 0): Boolean;
{$ENDIF}
begin
   If Not Ativo then
      AtivarGP;

   If Not fsECF.Ativo then
      raise Exception.Create(RS_ECFDESLIGADA);

   fsTEF.Handle   := fpHandle;

   try
      result   := fsTEF.VendaCheque(CodFormaPagto, Valor);
   except
      on Exc: Exception do
      begin
         {$IFDEF VisualCLX}
          QWidget_setActiveWindow(fpHandle);
         {$ELSE}
          SetForeGroundWindow(fpHandle);
         {$ENDIF}
         Raise Exception.Create(Exc.Message);
      end;
   end;
end;

{$IFDEF VisualCLX}
function TACBrTEF.FechaVendaTEF(CodFormaPagto: String; CodComprovanteNaoFiscal: String; Valor: Double; fpHandle: QWidgetH; Observacao: String = ''): Boolean;
{$ELSE}
function TACBrTEF.FechaVendaTEF(CodFormaPagto: String; CodComprovanteNaoFiscal: String; Valor: Double; fpHandle: THandle = 0; Observacao: String = ''): Boolean;
{$ENDIF}
begin
   If Not Ativo then
      AtivarGP;
      //raise Exception.Create(RS_INACTIVETEF);


   If Not fsECF.Ativo then
      raise Exception.Create(RS_ECFDESLIGADA);

   fsTEF.Handle   := fpHandle;

//   result   := False;
   try
      result   := fsTEF.FechaVendaTEF(CodFormaPagto, CodComprovanteNaoFiscal, Valor, Observacao);
   except
      on Exc: Exception do
      begin
         {$IFDEF VisualCLX}
          QWidget_setActiveWindow(fpHandle);
         {$ELSE}
          SetForeGroundWindow(fpHandle);
         {$ENDIF}
         Raise Exception.Create(Exc.Message);
      end;
   end;
end;

{$IFDEF VisualCLX}
function TACBrTEF.FechaVendaCheque(CodFormaPagto: String; CodComprovanteNaoFiscal: String; Valor: Double; fpHandle: QWidgetH; Observacao: String = ''): Boolean;
{$ELSE}
function TACBrTEF.FechaVendaCheque(CodFormaPagto: String; CodComprovanteNaoFiscal: String; Valor: Double; fpHandle: THandle = 0; Observacao: String = ''): Boolean;
{$ENDIF}
begin
   If Not Ativo then
      raise Exception.Create(RS_INACTIVETEF);

   If Not fsECF.Ativo then
      raise Exception.Create(RS_ECFDESLIGADA);   


   fsTEF.Handle   := fpHandle;

   result   := False;
   try
      result   := fsTEF.FechaVendaCheque(CodFormaPagto, CodComprovanteNaoFiscal, Valor, Observacao);
   except
      On Exc: Exception do
      begin
         {$IFDEF VisualCLX}
          QWidget_setActiveWindow(fpHandle);
          Application.MessageBox(Exc.Message,'Erro',[smbOK],smsCritical)
         {$ELSE}
          SetForeGroundWindow(fpHandle);
          MessageBox(fpHandle, Pchar(Exc.Message), 'Erro', MB_ICONERROR+MB_OK);
         {$ENDIF}
      end;
   end;

end;

function TACBrTEF.GPAtivo: Boolean;
begin
//   result := false;
   If Not Ativo then
      raise Exception.Create(RS_INACTIVETEF);

   result   := fsTEF.GPAtivo;
end;

procedure TACBrTEF.ADM;
begin
   If Not Ativo then
      raise Exception.Create(RS_INACTIVETEF);

   If (Not fsECF.Ativo) and (Not IgnoraECFDesativado) then
      raise Exception.Create(RS_ECFDESLIGADA);

   fsTEF.Handle   := fsHandle;
   fsTEF.ADM ;
end;

procedure TACBrTEF.CancelaCupomTEF;
begin
   If Not Ativo then
      raise Exception.Create(RS_INACTIVETEF);

   fsTEF.CancelaCupomTEF;
end;

function TACBrTEF.NCN: Boolean; // Não confirmação da venda e/ ou da impressão
begin
   If Not Ativo then
      raise Exception.Create(RS_INACTIVETEF);

   fsTEF.NCN;
end;

procedure TACBrTEF.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
   inherited Notification(AComponent, Operation);

   if (Operation = opRemove) and (fsTEF <> nil) and (AComponent is TACBrECF) then
   begin
      fsECF := nil ;

      if (fsTEF.ECF <> nil) then
         fsTEF.ECF := nil ;
   end;
end;

function TACBrTEF.GetBaseDir: String;
begin
   result   := TEF.BaseDir;
end;

function TACBrTEF.GetQtdVias: Integer;
begin
   result   := fsTEF.NumVias;
end;

function TACBrTEF.GetReqFile: String;
begin
   result   := fsTEF.ReqFileName;
end;

function TACBrTEF.GetReqTempFile: String;
begin
   result   := fsTEF.ReqTempFileName;
end;

function TACBrTEF.GetRespDataFile: String;
begin
   result   := fsTEF.RespDataFileName;
end;

function TACBrTEF.GetRespFile: String;
begin
   result   := fsTEF.RespFileName;
end;

function TACBrTEF.GetRespTempDataFile: String;
begin
   result   := fsTEF.RespTempDataFileName;
end;

function TACBrTEF.GetTimeOut: Integer;
begin
   result   := fsTEF.TimeOut;
end;

function TACBrTEF.GetAtivarGP: Boolean;
begin
   result   := fsTEF.AtivarGP;
end;

procedure TACBrTEF.SetAtivarGP(const Value: Boolean);
begin
   fsTEF.AtivarGP  := Value;
end;

function TACBrTEF.GetGuilhotina: Boolean;
begin
   Result   := fsTEF.AcionarGuilhotina;
end;

procedure TACBrTEF.SetGuilhotina(const Value: Boolean);
begin
   fsTEF.AcionarGuilhotina   := Value;
end;

procedure TACBrTEF.SetBaseDir(const Value: String);
begin
   fsTEF.BaseDir  := Value;
end;

procedure TACBrTEF.SetReqFile(const Value: String);
begin
   fsTEF.ReqFileName := Value;

end;

procedure TACBrTEF.SetReqTempFile(const Value: String);
begin
   fsTEF.ReqTempFileName := Value;
end;

procedure TACBrTEF.SetRespDataFile(const Value: String);
begin
   fsTEF.RespDataFileName := Value;
end;

procedure TACBrTEF.SetRespFile(const Value: String);
begin
   fsTEF.RespFileName := Value;
end;

procedure TACBrTEF.SetRespTempDataFile(const Value: String);
begin
   fsTEF.RespTempDataFileName := Value;
end;

function TACBrTEF.GetOnAguardandoDadosGP: TACBrAguardandoDadosGP;
begin
   Result   := fsTEF.OnAguardandoDadosGP;
end;

procedure TACBrTEF.SetOnAguardandoDadosGP(const Value: TACBrAguardandoDadosGP);
begin
   fsTEF.OnAguardandoDadosGP := Value ;
end;

procedure TACBrTEF.MsgAviso;
begin
   {$IFNDEF CONSOLE}
    if MessageDlg('Obrigado por usar o ACBrTEF. Esperamos que esse componente facilite a sua jornada'+ sLineBreak +
                  'no processo de homologação TEF. Para continuar usando esse componente você precisa'+ sLineBreak +
                  'concordar com todos os termos existentes na licença LGPL. '+ sLineBreak + sLineBreak +
                  'O uso do ACBrTEF em hipótese alguma exime o programador das necessidades de: '+ sLineBreak +
                  '- Solicitar das homologadoras a documentação atual para o processo homologatório '+ sLineBreak +
                  '- Efetuar a homologação do software que usa o ACBrTEF '+ sLineBreak + sLineBreak +  
                  'Leia atentamente todo o roteiro de homologação, o Manual de programação do Gerenciador'+ sLineBreak +
                  'Padrão e principalmente os fontes do ACBrTEF.' + sLineBreak +
                  'É fundamental que o programador tenha total controle de todo processo do TEF, caso' + sLineBreak +
                  'contrário será muito difícil passar no processo de homologação ' + sLineBreak + sLineBreak +
                  'Continua com o uso do ACBrTEF ?'
                  ,mtWarning,mbYesNoCancel,0) <> mrYes then
       raise Exception.Create( 'Uso indevido do ACBrTEF');
  {$ENDIF}
end;

function TACBrTEF.ImpressoesPendentes: Boolean;
begin
   result   := False;
   If fsTEF.ImpressoesPendentes.Count > 0 then
      result   := True;
end;

procedure TACBrTEF.ImprimeCuponsPendentes;
begin
   fsTEF.ImprimeCuponsPendentes;
end;

function TACBrTEF.GetOnPagtoNaoAutorizado: TACBrPagtoNaoAutorizado;
begin
   Result   := fsTEF.OnPagtoNaoAutorizado;
end;

procedure TACBrTEF.SetOnPagtoNaoAutorizado(
  const Value: TACBrPagtoNaoAutorizado);
begin
   fsTEF.OnPagtoNaoAutorizado := Value ;
end;

function TACBrTEF.GetParcelasClass: TACBrTEFParcelas;
begin
   Result := fsTEF.Parcelas ;
end;

procedure TACBrTEF.CarregaParcelas;
begin
   (* Carrega as parcelas da transação *)

   fsTEF.CarregaParcelas ;
end;

function TACBrTEF.GetCodAutTransacao: Integer;
begin
   (* Indica o número de autorização da transação atribuída pelo Host.
   Cada transação TEF possui um número de autorização.*)

   Result:= fsTEF.CodAutTransacao;
end;

function TACBrTEF.GetNomeRede: String;
begin
   (* Nome da rede que tratou a transação - AMEX - REDECARD - VISANET "Obs: Por enquanto"*)

   Result:= fsTEF.NomeRede;
end;


{ Obs. Coloquei as informações sobre cada metodo aqui apenas para facilitar o }
{ entendimento, pois o correto seria deixar na unit ref. ao TEF utilizado }
function TACBrTEF.GetNroLoteTransacao: Integer;
begin
   (* Indica o número de lote da transação *)
   
   Result:= fsTEF.NroLoteTransacao
end;

function TACBrTEF.GetNroParcelas: Integer;
begin
   (* Indica o número de parcelas no caso de transações Parceladas (Crédito ou Débito). *)

   Result:= fsTEF.NroParcelas
end;

function TACBrTEF.GetNroTransacaoNSU: Integer;
begin
   (* Indica o número de seqüência (NSU - Número Sequencial Único) da transação
   atribuído pelo Host (Sistema das Redes de Cartão que recebe e trata as
   solicitações das transações TEF). *)
   
   Result:= fsTEF.NroTransacaoNSU
end;

function TACBrTEF.GetStatusTransacao: Integer;
begin
   (* Indica se a transação foi aprovada ou recusada e qual o motivo da recusa.
      Conteúdos Válidos:
        0           - para transação aprovada
         Outro valor - transação negada *)

   Result:= fsTEF.StatusTransacao;
end;

function TACBrTEF.GetTipoParcelamento: Integer;
begin
   (* Indica o tipo de parcelamento aplicado à operação
      Conteúdos Válidos:
         0 - parcelado estabelecimento
         1 - parcelado administradora *)

   Result:= fsTEF.TipoParcelamento;
end;

function TACBrTEF.GetTipoTransacao: Integer;
begin
   (* Código identificando o tipo da transação executada
      Conteúdos Válidos:
         00-	Administrativas - Outras (Reimpressão, Iniciação de Terminal etc.)
         01-	Administrativa - Fechamento/Transmissão de Lote
         10- Cartão de Crédito à Vista
         11- Cartão de Crédito Parcelado pelo Estabelecimento
         12- Cartão de Crédito Parcelado pela Administradora
         13- Pré-Autorização com Cartão de Crédito
         20- Cartão de Débito à Vista
         21- Cartão de Débito Pré-Datado
         22- Cartão de Débito Parcelada
         23- Cartão de Débito à Vista Forçada
         24- Cartão de Débito Pré-Datado Forçada
         25- Cartão de Débito Pré-Datado sem Garantia
         30- Outros Cartões
         40- CDC
         41- Consulta CDC
         50- Convênio
         60- Voucher
         70- Consulta Cheque
         71- Garantia de Cheque
         99-Outras *)

   Result:= fsTEF.TipoTransacao;
end;

function TACBrTEF.GetHeader: String;
begin
   (* Indica o início do arquivo e o tipo de operação relacionada ao arquivo *)

   Result:= fsTEF.Header;
end;

function TACBrTEF.GetValorTotal: Double;
begin
   (* Valor total desta forma de pagamento. *)

   Result:= fsTEF.ValorTotal;
end;

procedure TACBrTEF.VerificaTransacaoPendente;
begin
   fsTEF.VerificaTransacaoPendente;
end;

function TACBrTEF.GetIgnoraECFDesativado: Boolean;
begin
   Result:= fsTEF.IgnoraECFDesativado;
end;

procedure TACBrTEF.SetIgnoraECFDesativado(const Value: Boolean);
begin
   fsTEF.IgnoraECFDesativado  := Value;
end;

end.
