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

unit ACBrTEFD;

interface

uses
  Classes, SysUtils, ACBrTEFDClass,
  ACBrTEFDDial, ACBrTEFDDisc, ACBrTEFDHiper {, ACBrTEFDGoodCard, ACBrTEFDFoxWin}
  {$IFNDEF CONSOLE}
    {$IFDEF MSWINDOWS},
      Windows, Messages
    {$ENDIF}
    {$IFDEF VisualCLX}
      ,QForms, QControls
    {$ELSE}
      ,Forms, Controls
    {$ENDIF}
 {$ENDIF} ;

type

   { TACBrTEFDClass }

   TACBrTEFD = class( TComponent )
   private
     fAutoAtivarGP : Boolean;
     fAutoFinalizarCupom : Boolean;
     fAutoEfetuarPagamento : Boolean;
     fEsperaSleep : Integer;
     fEstadoReq : TACBrTEFDReqEstado;
     fEstadoResp : TACBrTEFDRespEstado;
     fMultiplosCartoes : Boolean;
     fNumVias : Integer;
     fOnAguardaResp : TACBrTEFDAguardaRespEvent;
     fOnAntesFinalizarRequisicao : TACBrTEFDAntesFinalizarReq;
     fOnComandaECF : TACBrTEFDComandaECF;
     fOnComandaECFPagamento : TACBrTEFDComandaECFPagamento;
     fOnExibeMsg : TACBrTEFDExibeMsg;
     fOnInfoECF : TACBrTEFDObterInfoECF;
     fOnMudaEstadoReq : TACBrTEFDMudaEstadoReq;
     fOnMudaEstadoResp : TACBrTEFDMudaEstadoResp;
     fPathBackup   : String;
     fGPAtual      : TACBrTEFDTipo;
     fTefClass     : TACBrTEFDClass ;
     fTefDial      : TACBrTEFDDial ;
     fTefDisc      : TACBrTEFDDisc ;
     fTefHiper     : TACBrTEFDHiper ;
//   fTefGood      : TACBrTEFDGoodCard ;
//   fTefFW        : TACBrTEFDFoxWin ;
     fEsperaSTS    : Integer;
     fTEFList      : TACBrTEFDClassList ;
     fpRespostasPendentes : TACBrTEFDRespostasPendentes;
     function GetArqReq : String;
     function getArqResp : String;
     function GetArqSTS : String;
     function GetArqTmp : String;
     function GetGPExeName : String;
     function GetPathBackup : String;
     function GetReq : TACBrTEFDReq;
     function GetResp : TACBrTEFDResp;
     procedure SetAutoAtivarGP(const AValue : Boolean);
     procedure SetAutoEfetuarPagamento(const AValue : Boolean);
     procedure SetAutoFinalizarCupom(const AValue : Boolean);
     procedure SetEsperaSleep(const AValue : Integer);
     procedure SetEsperaSTS(const AValue : Integer);
     procedure SetEstadoReq(const AValue : TACBrTEFDReqEstado);
     procedure SetEstadoResp(const AValue : TACBrTEFDRespEstado);
     procedure SetMultiplosCartoes(const AValue : Boolean);
     procedure SetNumVias(const AValue : Integer);
     procedure SetPathBackup(const AValue : String);
     procedure SetGPAtual(const AValue : TACBrTEFDTipo);
   public
     Function EstadoECF : AnsiChar ;
     function DoExibeMsg( Operacao : TACBrTEFDOperacaoMensagem;
        Mensagem : String ) : TModalResult;
     function ComandaECF(Operacao : TACBrTEFDOperacaoECF) : Integer;
     function ComandaECFPagamento(Indice : String; Valor : Double) : Integer;
     procedure FechaGerencial( ShowException : Boolean = False );
     procedure FinalizaCupom;

   public
     constructor Create( AOwner : TComponent ) ; override;
     destructor Destroy ; override;

     Procedure Inicializar( GP : TACBrTEFDTipo = gpNenhum ) ;
     function Inicializado( GP : TACBrTEFDTipo = gpNenhum ) : Boolean ;

     property GPAtual : TACBrTEFDTipo read fGPAtual write SetGPAtual ;

     property TEF  : TACBrTEFDClass read fTefClass ;
     property Req  : TACBrTEFDReq   read GetReq  ;
     property Resp : TACBrTEFDResp  read GetResp ;
     property RespostasPendentes : TACBrTEFDRespostasPendentes
        read fpRespostasPendentes ;

     property ArqTemp  : String read GetArqTmp ;
     property ArqReq   : String read GetArqReq ;
     property ArqSTS   : String read GetArqSTS ;
     property ArqResp  : String read getArqResp ;
     property GPExeName: String read GetGPExeName ;

     property EstadoReq  : TACBrTEFDReqEstado  read fEstadoReq  write SetEstadoReq ;
     property EstadoResp : TACBrTEFDRespEstado read fEstadoResp write SetEstadoResp ;

     procedure AtivarGP(GP : TACBrTEFDTipo);

     procedure ATV( GP : TACBrTEFDTipo = gpNenhum ) ;
     procedure ADM( GP : TACBrTEFDTipo = gpNenhum ) ;
     procedure CRT( const Valor : Double; const IndiceFPG_ECF : String;
        const DocumentoVinculado : String = ''; const Moeda : Integer = 0 );
     procedure CHQ( const Valor : Double; const IndiceFPG_ECF : String;
        const DocumentoVinculado : String = ''; const CMC7 : String = '';
        const TipoPessoa : AnsiChar = 'F'; const DocumentoPessoa : String = '';
        const DataCheque : TDateTime = 0; const Banco   : String = '';
        const Agencia    : String = ''; const AgenciaDC : String = '';
        const Conta      : String = ''; const ContaDC   : String = '';
        const Cheque     : String = ''; const ChequeDC  : String = '');
     procedure CNC(const Rede, NSU : String; const DataHoraTransacao :
        TDateTime; const Valor : Double);
     procedure CNF(const Rede, NSU, Finalizacao : String;
        const DocumentoVinculado : String = '');
     procedure NCN(const Rede, NSU, Finalizacao : String;
        const Valor : Double = 0; const DocumentoVinculado : String = '');

     procedure CancelaTransacoesPendentes;
     procedure ConfirmaTransacoesPendentes;
     procedure ImprimirTransacoesPendentes;

     procedure AgruparRespostasPendentes(
        var Grupo : TACBrTEFDArrayGrupoRespostasPendentes) ;

   published

     property MultiplosCartoes : Boolean read fMultiplosCartoes
       write SetMultiplosCartoes default False ;
     property AutoAtivarGP : Boolean read fAutoAtivarGP write fAutoAtivarGP
       default True ;
     property AutoEfetuarPagamento : Boolean read fAutoEfetuarPagamento
       write SetAutoEfetuarPagamento default False ;
     property AutoFinalizarCupom : Boolean read fAutoFinalizarCupom
       write SetAutoFinalizarCupom default True ;
     property NumVias   : Integer read fNumVias   write SetNumVias
       default CACBrTEFD_NumVias ;
     property EsperaSTS : Integer read fEsperaSTS write SetEsperaSTS
        default CACBrTEFD_EsperaSleep ;
     property EsperaSleep : Integer read fEsperaSleep write SetEsperaSleep
        default CACBrTEFD_EsperaSleep ;
     property PathBackup : String read GetPathBackup write SetPathBackup ;

     property TEFDial   : TACBrTEFDDial     read fTefDial ;
     property TEFDisc   : TACBrTEFDDisc     read fTefDisc ;
     property TEFHiper  : TACBrTEFDHiper    read fTefHiper ;
//   property TEFGood   : TACBrTEFDGoodCard read fTefGood ;
//   property TEFFoxWin : TACBrTEFDFoxWin   read fTefFW ;

     property OnAguardaResp : TACBrTEFDAguardaRespEvent read fOnAguardaResp
        write fOnAguardaResp ;
     property OnExibeMsg    : TACBrTEFDExibeMsg read fOnExibeMsg
        write fOnExibeMsg ;
     property OnComandaECF  : TACBrTEFDComandaECF read fOnComandaECF
        write fOnComandaECF ;
     property OnComandaECFPagamento  : TACBrTEFDComandaECFPagamento
        read fOnComandaECFPagamento write fOnComandaECFPagamento ;
     property OnInfoECF : TACBrTEFDObterInfoECF read fOnInfoECF write fOnInfoECF ;
     property OnAntesFinalizarRequisicao : TACBrTEFDAntesFinalizarReq
        read fOnAntesFinalizarRequisicao write fOnAntesFinalizarRequisicao ;
     property OnMudaEstadoReq  : TACBrTEFDMudaEstadoReq read fOnMudaEstadoReq
        write fOnMudaEstadoReq ;
     property OnMudaEstadoResp : TACBrTEFDMudaEstadoResp read fOnMudaEstadoResp
        write fOnMudaEstadoResp ;
   end;

procedure Register;

procedure ApagaEVerifica( const Arquivo : String ) ;
function FlushToDisk(sDriveLetter: string): boolean;
procedure FocoJanela( NomeJanela : String = '' ) ;
procedure BloqueiaMouseTeclado( Bloqueia : Boolean ) ;
procedure LimpaBufferTeclado ;

implementation

Uses ACBrUtil, dateutils, TypInfo, StrUtils;

procedure Register;
begin
  RegisterComponents('ACBr', [TACBrTEFD]);
end;


procedure ApagaEVerifica( const Arquivo : String ) ;
begin
  SysUtils.DeleteFile( Arquivo );
  if FileExists( Arquivo ) then
     raise EACBrTEFDArquivo.Create( ACBrStr( 'Erro ao apagar o arquivo:' + sLineBreak + Arquivo ) );
end;

{$IFDEF MSWINDOWS}
 { Fonte: http://stackoverflow.com/questions/1635947/how-to-make-sure-that-a-file-was-permanently-saved-on-usb-when-user-doesnt-use }
 function FlushToDisk(sDriveLetter: string): boolean;
 var
   hDrive: THandle;
   S:      string;
   OSFlushed: boolean;
   bResult: boolean;
 begin
   bResult := False;
   S := PAnsiChar('\\.\' + sDriveLetter[1] + ':');

   //NOTE: this may only work for the SYSTEM user
   hDrive    := CreateFile(PChar(S), GENERIC_READ or
     GENERIC_WRITE, FILE_SHARE_READ or FILE_SHARE_WRITE, nil,
     OPEN_EXISTING, 0, 0);
   OSFlushed := FlushFileBuffers(hDrive);

   CloseHandle(hDrive);

   if OSFlushed then
   begin
     bResult := True;
   end;

   Result := bResult;
 end;
{$ELSE}
 function FlushToDisk(sDriveLetter: string): boolean;
 begin
   Result := False ;
 end ;
{$ENDIF}

procedure FocoJanela(NomeJanela : String);
begin
  Application.BringToFront ;

(*
  {$IFDEF VisualCLX}
   QWidget_setActiveWindow( Screen.ActiveForm.Handle );
  {$ELSE}
   SetForeGroundWindow( Screen.ActiveForm.Handle );
  {$ENDIF}
*)
end;

procedure BloqueiaMouseTeclado(Bloqueia : Boolean );
begin
  if Assigned( xBlockInput ) then
     xBlockInput( Bloqueia ) ;
end;

procedure LimpaBufferTeclado;
Var
   Msg: TMsg;
begin
  try
     // Remove todas as Teclas do Buffer do Teclado //
     while PeekMessage(Msg, 0, WM_KEYFIRST, WM_KEYLAST, PM_REMOVE or PM_NOYIELD) do;
  except
  end ;
end;



{ TACBrTEFDClass }

constructor TACBrTEFD.Create(AOwner : TComponent);
begin
  inherited Create(AOWner);

  fPathBackup           := '' ;
  fAutoAtivarGP         := True ;
  fAutoEfetuarPagamento := False ;
  fAutoFinalizarCupom   := True ;
  fMultiplosCartoes     := False ;
  fGPAtual              := gpNenhum ;
  fNumVias              := CACBrTEFD_NumVias ;
  fEsperaSTS            := CACBrTEFD_EsperaSTS ;
  fEsperaSleep          := CACBrTEFD_EsperaSleep ;

  fOnAguardaResp              := nil ;
  fOnAntesFinalizarRequisicao := nil ;
  fOnAguardaResp              := nil ;
  fOnComandaECF               := nil ;
  fOnComandaECFPagamento      := nil ;
  fOnInfoECF                  := nil ;
  fOnExibeMsg                 := nil ;
  fOnMudaEstadoReq            := nil ;
  fOnMudaEstadoResp           := nil ;

  { Lista de Objetos com todas as Classes de TEF }
  fTEFList := TACBrTEFDClassList.create(True);
  { Lista de Objetos TACBrTEFDresp com todas as Respostas Pendentes para Impressao }
  fpRespostasPendentes := TACBrTEFDRespostasPendentes.create(True);

  { Criando Classe TEF_DIAL }
  fTefDial := TACBrTEFDDial.Create(self);
  fTEFList.Add(fTefDial);     // Adicionando "fTefDial" na Lista Objetos de Classes de TEF
  {$IFDEF COMPILER6_UP}
   fTefDial.SetSubComponent(True);   // Ajustando como SubComponente para aparecer no ObjectInspector
  {$ENDIF}

  { Criando Classe TEF_DISC }
  fTefDisc := TACBrTEFDDisc.Create(self);
  fTEFList.Add(fTefDisc);     // Adicionando "fTefDisc" na Lista Objetos de Classes de TEF
  {$IFDEF COMPILER6_UP}
   fTefDisc.SetSubComponent(True);   // Ajustando como SubComponente para aparecer no ObjectInspector
  {$ENDIF}

  { Criando Classe HIPER TEF }
  fTefHiper := TACBrTEFDHiper.Create(self);
  fTEFList.Add(fTefHiper);     // Adicionando "fTefHiper" na Lista Objetos de Classes de TEF
  {$IFDEF COMPILER6_UP}
   fTefHiper.SetSubComponent(True);   // Ajustando como SubComponente para aparecer no ObjectInspector
  {$ENDIF}

(*
{ Criando Classe GOOD CARD }
  fTefGood := TACBrTEFDGoodCard.Create(self);
  fTEFList.Add(fTefGood);     // Adicionando "fTefGood" na Lista Objetos de Classes de TEF
  {$IFDEF COMPILER6_UP}
   fTefGood.SetSubComponent(True);   // Ajustando como SubComponente para aparecer no ObjectInspector
  {$ENDIF}

  { Criando Classe Fox Win }
  fTefFW := TACBrTEFDFoxWin.Create(self);
  fTEFList.Add(fTefFW);     // Adicionando "fTefFW" na Lista Objetos de Classes de TEF
  {$IFDEF COMPILER6_UP}
   fTefFW.SetSubComponent(True);   // Ajustando como SubComponente para aparecer no ObjectInspector
  {$ENDIF}
*)

  GPAtual := gpTefDial;
end;

destructor TACBrTEFD.Destroy;
begin
  fTEFList.Free;  // Destroi Lista de Classes TEF e Objetos internos
  fpRespostasPendentes.Free ;  // Destroi Lista de Respostas pendentes e Objetos internos

  inherited Destroy;
end;

procedure TACBrTEFD.Inicializar(GP : TACBrTEFDTipo);
Var
  I : Integer;
begin
  if not Assigned( OnExibeMsg ) then
     raise Exception.Create( ACBrStr('Evento "OnExibeMsg" não programado' ) ) ;

  if not Assigned( OnComandaECF )  then
     raise Exception.Create( ACBrStr('Evento "OnComandaECF" não programado' ) ) ;

  if not Assigned( OnComandaECFPagamento )  then
     raise Exception.Create( ACBrStr('Evento "OnComandaECFPagamento" não programado' ) ) ;

  if not Assigned( OnInfoECF )  then
     raise Exception.Create( ACBrStr('Evento "OnInfoECF" não programado' ) ) ;

  if not DirectoryExists( PathBackup ) then
     ForceDirectories( PathBackup );

  if not DirectoryExists( PathBackup ) then
     raise Exception.Create( ACBrStr('Diretório de Backup não existente:'+sLineBreak+PathBackup) ) ;

  if GP = gpNenhum then
   begin
     For I := 0 to fTEFList.Count-1 do
     begin
       if fTEFList[I].Habilitado then
          fTEFList[I].Inicializar;
     end;
   end
  else
   begin
     GPAtual := GP ;
     fTefClass.Inicializar;
   end;
end;

procedure TACBrTEFD.SetGPAtual(const AValue : TACBrTEFDTipo);
begin
  if AValue = fGPAtual then exit ;

  case AValue of
    gpTefDial  : fTefClass := fTefDial ;
    gpTefDisc  : fTefClass := fTefDisc ;
    gpHiperTef : fTefClass := fTefHiper ;
//  gpGoodCard : fTefClass := fTefGood ;
//  gpFoxWin   : fTefClass := fTefFW ;
  end;

  fGPAtual := AValue;
end;

function TACBrTEFD.EstadoECF : AnsiChar;
Var
  Retorno : String ;
begin
  Retorno := ' ' ;
  try
     OnInfoEcf( ineEstadoECF, Retorno ) ;
  except
     On E : Exception do
        raise EACBrTEFDECF.Create(E.Message);
  end;
  Result := upcase( padL(Retorno,1)[1] );

  if not (Result in ['L','V','P','O']) then
     raise EACBrTEFDECF.Create( ACBrStr( 'Retorno de "OnInfoEcf( ineEstadoECF, Retorno )" deve ser:'+sLineBreak+
                                     '"L" = Livre, "V" = Em Venda de Itens, "P" - Em Pagamento, "O" - Outro' ) );
end;

procedure TACBrTEFD.AtivarGP(GP : TACBrTEFDTipo);
Var
  I : Integer;
begin
  if GP = gpNenhum then
   begin
     For I := 0 to fTEFList.Count-1 do
     begin
       if fTEFList[I].Habilitado then
          fTEFList[I].AtivarGP;
     end;
   end
  else
   begin
     GPAtual := GP ;
     fTefClass.AtivarGP;
   end;
end;

procedure TACBrTEFD.ATV( GP : TACBrTEFDTipo = gpNenhum );
begin
  if GP <> gpNenhum then
     GPAtual := GP ;

  fTefClass.ATV;
end;

procedure TACBrTEFD.ADM( GP : TACBrTEFDTipo = gpNenhum );
begin
  if GP <> gpNenhum then
     GPAtual := GP ;

  fTefClass.ADM;
end;

procedure TACBrTEFD.CRT(const Valor : Double; const IndiceFPG_ECF : String;
   const DocumentoVinculado : String; const Moeda : Integer);
begin
   fTefClass.CRT( Valor, IndiceFPG_ECF, DocumentoVinculado, Moeda );
end;

procedure TACBrTEFD.CHQ(const Valor : Double; const IndiceFPG_ECF : String;
   const DocumentoVinculado : String; const CMC7 : String;
   const TipoPessoa : AnsiChar; const DocumentoPessoa : String;
   const DataCheque : TDateTime; const Banco : String; const Agencia : String;
   const AgenciaDC : String; const Conta : String; const ContaDC : String;
   const Cheque : String; const ChequeDC : String);
begin
   fTefClass.CHQ( Valor, IndiceFPG_ECF, DocumentoVinculado, CMC7, TipoPessoa,
                  DocumentoPessoa, DataCheque, Banco, Agencia, AgenciaDC,
                  Conta, ContaDC, Cheque, ChequeDC);
end;

procedure TACBrTEFD.CNC(const Rede, NSU : String;
   const DataHoraTransacao : TDateTime; const Valor : Double);
begin
  fTefClass.CNC( Rede, NSU, DataHoraTransacao, Valor);
end;

procedure TACBrTEFD.CNF(const Rede, NSU, Finalizacao : String;
  const DocumentoVinculado : String = '');
begin
  fTefClass.CNF( Rede, NSU, Finalizacao, DocumentoVinculado);
end;

procedure TACBrTEFD.NCN(const Rede, NSU, Finalizacao : String;
  const Valor : Double = 0; const DocumentoVinculado : String = '');
begin
  fTefClass.NCN( Rede, NSU, Finalizacao, Valor, DocumentoVinculado);
end;

procedure TACBrTEFD.CancelaTransacoesPendentes;
Var
  I : Integer;
begin
  { Ajustando o mesmo valor nas Classes de TEF, caso elas usem o valor default }
  For I := 0 to fTEFList.Count-1 do
  begin
    if fTEFList[I].Habilitado then
       fTEFList[I].CancelaTransacoesPendentesClass;
  end;

  RespostasPendentes.Clear;
  MultiplosCartoes := False ;
end;

procedure TACBrTEFD.ConfirmaTransacoesPendentes;
var
   I : Integer;
begin
  I := 0 ;
  while I < RespostasPendentes.Count do
  begin
    try
       GPAtual := RespostasPendentes[I].TipoGP;

       if not RespostasPendentes[I].CNFEnviado then
       begin
          fTefClass.Resp.Assign( RespostasPendentes[I] );
          fTefClass.CNF;
          RespostasPendentes[I].CNFEnviado := True ;
       end;

       if FileExists( ArqResp ) then
          ApagaEVerifica( ArqResp );

       ApagaEVerifica( RespostasPendentes[I].ArqBackup );

       Inc( I ) ;
    except
      { Exceção Muda... Fica em Loop até conseguir confirmar e apagar Backup }
    end;
  end ;

  RespostasPendentes.Clear;
  MultiplosCartoes := False ;
end;

procedure TACBrTEFD.ImprimirTransacoesPendentes;
var
   I, J, K, Ordem : Integer;
   GrupoVinc : TACBrTEFDArrayGrupoRespostasPendentes ;
   ImpressaoOk, Gerencial, RemoverMsg : Boolean ;
   TempoInicio : Double;
begin
  if RespostasPendentes.Count <= 0 then
     exit ;

  if EstadoECF <> 'L' then
     FinalizaCupom;

  if EstadoECF <> 'L' then
     raise EACBrTEFDECF.Create( ACBrStr('ECF não está LIVRE') ) ;

  ImpressaoOk := False ;
  Gerencial   := False ;

  AgruparRespostasPendentes( GrupoVinc );

  try
     while not ImpressaoOk do
     begin
        BloqueiaMouseTeclado( True );

        try
           try
              if Gerencial then    //// Impressão em Gerencial ////
               begin
                 { Fecha, se ficou algum aberto por Desligamento }
                 FechaGerencial( False );  // Não Gera Exception se não conseguir

                 For J := 0 to RespostasPendentes.Count-1 do
                 begin
                    GPAtual := RespostasPendentes[J].TipoGP;
                    fTefClass.Resp.Assign( RespostasPendentes[J] );

                    TempoInicio := now ;
                    if Resp.TextoEspecialOperador <> '' then
                    begin
                       RemoverMsg := True ;
                       DoExibeMsg( opmExibirMsg, Resp.TextoEspecialOperador ) ;
                    end;

                    ComandaECF( opeAbreGerencial ) ;

                    I := 1 ;
                    while I <= NumVias do
                    begin
                       Resp.ViaAtual := I ;

                       ComandaECF( opeImprimeGerencial ) ;

                       if Resp.ViaAtual < NumVias  then
                       begin
                          ComandaECF( opePulaLinhas ) ;
                          DoExibeMsg( opmDestaqueVia, 'Destaque a '+IntToStr(Resp.ViaAtual)+'ª Via') ;
                       end;

                       Inc( I ) ;
                    end;

                    FechaGerencial( True );  // Gera Exception se não conseguir

                    { Removendo a mensagem do Operador }
                    if RemoverMsg then
                    begin
                       { Verifica se Mensagem Ficou pelo menos por 5 segundos }
                       while SecondsBetween(now,TempoInicio) < 5 do
                       begin
                          Sleep(EsperaSTS) ;
                          Application.ProcessMessages;
                       end;

                       DoExibeMsg( opmRemoverMsg, '' ) ;
                       RemoverMsg := False ;
                    end;
                 end ;
               end
              else                 //// Impressão em Vinculado ////
               begin
                 Ordem := 0 ;

                 For K := 0 to Length( GrupoVinc )-1 do
                 begin
                    For J := 0 to RespostasPendentes.Count-1 do
                    begin
                       if GrupoVinc[K].OrdemPagamento <> RespostasPendentes[J].OrdemPagamento then
                          continue ;

                       GPAtual := RespostasPendentes[J].TipoGP;
                       fTefClass.Resp.Assign( RespostasPendentes[J] );

                       TempoInicio := now ;
                       if Resp.TextoEspecialOperador <> '' then
                       begin
                          RemoverMsg := True ;
                          DoExibeMsg( opmExibirMsg, Resp.TextoEspecialOperador ) ;
                       end;

                       if Ordem <> RespostasPendentes[J].OrdemPagamento then
                        begin
                          Ordem := RespostasPendentes[J].OrdemPagamento ;
                          ComandaECF( opeAbreVinculado ) ;
                        end
                       else
                          ComandaECF( opePulaLinhas ) ;

                       I := 1 ;
                       while I <= NumVias do
                       begin
                          Resp.ViaAtual := I ;

                          ComandaECF( opeImprimeVinculado ) ;

                          if Resp.ViaAtual < NumVias  then
                          begin

                             ComandaECF( opePulaLinhas ) ;
                             DoExibeMsg( opmDestaqueVia, 'Destaque a '+IntToStr(Resp.ViaAtual)+'ª Via') ;
                          end;

                          Inc( I ) ;
                       end;

                       { Removendo a mensagem do Operador }
                       if RemoverMsg then
                       begin
                          { Verifica se Mensagem Ficou pelo menos por 5 segundos }
                          while SecondsBetween(now,TempoInicio) < 5 do
                          begin
                             Sleep(EsperaSTS) ;
                             Application.ProcessMessages;
                          end;

                          DoExibeMsg( opmRemoverMsg, '' ) ;
                          RemoverMsg := False ;
                       end;
                    end ;

                    ComandaECF( opeFechaVinculado ) ;

                 end;
               end;

              ImpressaoOk := True ;
           finally
              { Removendo a mensagem do Operador }
              if RemoverMsg then
                 DoExibeMsg( opmRemoverMsg, '' ) ;


              BloqueiaMouseTeclado( False );
              LimpaBufferTeclado;
           end;
        except
           on EACBrTEFDECF do ImpressaoOk := False ;
           else
              raise ;
        end;

        if not ImpressaoOk then
        begin
          if DoExibeMsg( opmYesNo, 'Impressora não responde'+sLineBreak+
                                   'Tentar novamente ?') <> mrYes then
          begin
             FechaGerencial( False );  // Não Gera Exception se não conseguir
             break ;
          end;
        end;

        Gerencial := True ;
     end;
  finally
     if not ImpressaoOk then
        CancelaTransacoesPendentes
     else
        ConfirmaTransacoesPendentes ;
  end;

  RespostasPendentes.Clear;
  MultiplosCartoes := False ;
end;

Function TACBrTEFD.DoExibeMsg( Operacao : TACBrTEFDOperacaoMensagem;
   Mensagem : String) : TModalResult ;
begin
  FocoJanela ;

  Result := mrNone ;
  OnExibeMsg( Operacao, ACBrStr( Mensagem ), Result );
end;

Function TACBrTEFD.ComandaECF( Operacao : TACBrTEFDOperacaoECF ) : Integer ;
var
   OpName : String;
begin
  Result := -1 ;  // -1 = Não tratado
  OnComandaECF( Operacao, fTefClass.Resp, Result ) ;

  if Result < 1 then
  begin
     OpName := GetEnumName( TypeInfo(TACBrTEFDOperacaoECF), Integer(Operacao) ) ;

     if Result = 0 then
        raise EACBrTEFDECF.Create( ACBrStr( 'Erro ao executar Operação: ['+OpName+']' ) )
     else
        raise EACBrTEFDECF.Create( ACBrStr( 'Operação ['+OpName+'] não tratada em "OnComandaECF"' ) ) ;
  end;
end;

Function TACBrTEFD.ComandaECFPagamento( Indice: String; Valor: Double ) : Integer ;
begin
  Result := -1 ;  // -1 = Não tratado
  OnComandaECFPagamento( Indice, Valor, Result ) ;

  if Result < 1 then
  begin
     if Result = 0 then
        raise EACBrTEFDECF.Create( ACBrStr( 'Erro ao executar "OnComandaECFPagamento"' ) )
     else
        raise EACBrTEFDECF.Create( ACBrStr( '"OnComandaECFPagamento" não tratada' ) ) ;
  end;
end;


procedure TACBrTEFD.FechaGerencial( ShowException : Boolean = False );
begin
  try
     ComandaECF( opeFechaGerencial ) ;
  except
     if ShowException then
        raise ;
  end;
end;


procedure TACBrTEFD.FinalizaCupom;
Var
  I, J, Ordem : Integer;
  Est  : AnsiChar;
  ImpressaoOk : Boolean ;
  GrupoFPG    : TACBrTEFDArrayGrupoRespostasPendentes ;
begin
  ImpressaoOk := False ;

  try
     while not ImpressaoOk do
     begin
        BloqueiaMouseTeclado( True );

        try
           try
              Est := EstadoECF;
              while Est <> 'L' do
              begin
                 Case Est of
                   'V' : ComandaECF( opeSubTotalizaCupom );

                   'P' :
                     begin
                       if not AutoEfetuarPagamento then
                       begin
                          AgruparRespostasPendentes( GrupoFPG );
                          Ordem := 0 ;

                          For I := 0 to Length( GrupoFPG )-1 do
                          begin
                             if GrupoFPG[I].OrdemPagamento = 0 then
                              begin
                                Inc( Ordem ) ;
                                ComandaECFPagamento( GrupoFPG[I].IndiceFPG_ECF, GrupoFPG[I].Total );

                                For J := 0 to RespostasPendentes.Count-1 do
                                   if RespostasPendentes[J].IndiceFPG_ECF = GrupoFPG[I].IndiceFPG_ECF then
                                      RespostasPendentes[J].OrdemPagamento := Ordem;
                              end
                             else
                                Ordem := GrupoFPG[I].OrdemPagamento ;
                          end;
                       end;

                       ComandaECF( opeFechaCupom );
                     end ;
                 end;

                 Est := EstadoECF;
              end;

              ImpressaoOk := True ;

           finally
              BloqueiaMouseTeclado( False );
              LimpaBufferTeclado;
           end;

        except
           on EACBrTEFDECF do ImpressaoOk := False ;
           else
              raise ;
        end;

        if not ImpressaoOk then
        begin
          if DoExibeMsg( opmYesNo, 'Impressora não responde'+sLineBreak+
                                   'Tentar novamente ?') <> mrYes then
          begin
             try ComandaECF(opeCancelaCupom); except {Exceção Muda} end ;
             break ;
          end;
        end;
     end;
  finally
    if not ImpressaoOk then
       CancelaTransacoesPendentes;
  end;
end;


procedure TACBrTEFD.AgruparRespostasPendentes(
   var Grupo : TACBrTEFDArrayGrupoRespostasPendentes);
var
   I, J      : Integer;
   LenArr    : Integer;
   IndiceFPG : String;
   Ordem     : Integer;
begin
  SetLength( Grupo, 0) ;

  For I := 0 to RespostasPendentes.Count-1 do
  begin
     IndiceFPG := RespostasPendentes[I].IndiceFPG_ECF ;
     Ordem     := RespostasPendentes[I].OrdemPagamento ;

     J := 0 ;
     LenArr := Length( Grupo ) ;
     while J < LenArr do
     begin
       if (Grupo[J].IndiceFPG_ECF  = IndiceFPG) and
          (Grupo[J].OrdemPagamento = Ordem) then
          break ;
       Inc( J ) ;
     end;

     if J >= LenArr then
     begin
        SetLength( Grupo, J+1 ) ;
        Grupo[J].IndiceFPG_ECF  := IndiceFPG ;
        Grupo[J].OrdemPagamento := Ordem ;
        Grupo[J].Total  := 0 ;
     end;

     Grupo[J].Total := Grupo[J].Total + RespostasPendentes[I].ValorTotal ;
  end;
end;


function TACBrTEFD.Inicializado( GP : TACBrTEFDTipo = gpNenhum ) : Boolean;
begin
  if GP <> gpNenhum then
     GPAtual := GP ;

  Result := fTefClass.Inicializado ;
end;

procedure TACBrTEFD.SetEsperaSTS(const AValue : Integer);
Var
  I : Integer;
begin
  { Ajustando o mesmo valor nas Classes de TEF, caso elas usem o valor default }
  For I := 0 to fTEFList.Count-1 do
  begin
    if fTEFList[I].EsperaSTS = fEsperaSTS then
       fTEFList[I].EsperaSTS := AValue;
  end;

  fEsperaSTS := AValue;
end;

procedure TACBrTEFD.SetEstadoReq(const AValue : TACBrTEFDReqEstado);
begin
   if fEstadoReq = AValue then exit;
   fEstadoReq := AValue;

   if Assigned( OnMudaEstadoReq ) then
      OnMudaEstadoReq( EstadoReq );
end;

procedure TACBrTEFD.SetEstadoResp(const AValue : TACBrTEFDRespEstado);
begin
   if fEstadoResp = AValue then exit;
   fEstadoResp := AValue;

   if Assigned( OnMudaEstadoResp ) then
      OnMudaEstadoResp( EstadoResp );
end;

procedure TACBrTEFD.SetEsperaSleep(const AValue : Integer);
begin
   if fEsperaSleep = AValue then exit;

   if AValue < 10 then
      raise Exception.Create( ACBrStr('Valor mínimo de EsperaSleep deve ser: 10' )) ;
   if AValue > 500 then
      raise Exception.Create( ACBrStr('Valor máximo de EsperaSleep deve ser: 500' )) ;

   fEsperaSleep := AValue;
end;

procedure TACBrTEFD.SetAutoAtivarGP(const AValue : Boolean);
var
   I : Integer;
begin
  { Ajustando o mesmo valor nas Classes de TEF }
  For I := 0 to fTEFList.Count-1 do
    fTEFList[I].AutoAtivarGP := AValue;

  fAutoAtivarGP := AValue;
end;

procedure TACBrTEFD.SetMultiplosCartoes(const AValue : Boolean);
begin
   if RespostasPendentes.Count > 0 then
      raise Exception.Create( ACBrStr( 'Existem Respostas Pendentes. '+
                              'Não é possível alterar "MultiplosCartoes"') ) ;
   fMultiplosCartoes := AValue;
end;

procedure TACBrTEFD.SetAutoEfetuarPagamento(const AValue : Boolean);
begin
  if RespostasPendentes.Count > 0 then
     raise Exception.Create( ACBrStr( 'Existem Respostas Pendentes. '+
                             'Não é possível alterar "AutoEfetuarPagamento"') ) ;
  fAutoEfetuarPagamento := AValue;
end;

procedure TACBrTEFD.SetAutoFinalizarCupom(const AValue : Boolean);
begin
  if RespostasPendentes.Count > 0 then
     raise Exception.Create( ACBrStr( 'Existem Respostas Pendentes. '+
                             'Não é possível alterar "AutoFinalizarCupom"') ) ;
  fAutoFinalizarCupom := AValue;
end;

procedure TACBrTEFD.SetNumVias(const AValue : Integer);
var
   I : Integer;
begin
  For I := 0 to fTEFList.Count-1 do
  begin
    if fTEFList[I].NumVias = fNumVias then
       fTEFList[I].NumVias := AValue;
  end;

  fNumVias := AValue;
end;

function TACBrTEFD.GetPathBackup : String;
begin
  if fPathBackup = '' then
     if not (csDesigning in Self.ComponentState) then
        fPathBackup := ExtractFilePath(
        {$IFNDEF CONSOLE} Application.ExeName {$ELSE} ParamStr(0) {$ENDIF}
                                      ) + 'TEF' ;

  Result := fPathBackup ;
end;

function TACBrTEFD.GetArqReq : String;
begin
   Result := fTefClass.ArqReq ;
end;

function TACBrTEFD.getArqResp : String;
begin
   Result := fTefClass.ArqResp ;
end;

function TACBrTEFD.GetArqSTS : String;
begin
   Result := fTefClass.ArqSTS ;
end;

function TACBrTEFD.GetArqTmp : String;
begin
   Result := fTefClass.ArqTemp ;
end;

function TACBrTEFD.GetGPExeName : String;
begin
   Result := fTefClass.GPExeName ;
end;

function TACBrTEFD.GetReq : TACBrTEFDReq;
begin
   Result := fTefClass.Req;
end;

function TACBrTEFD.GetResp : TACBrTEFDResp;
begin
   Result := fTefClass.Resp;
end;

procedure TACBrTEFD.SetPathBackup(const AValue : String);
begin
  if fPathBackup = AValue then exit ;

  if Inicializado then
     raise Exception.Create(ACBrStr('PathBackup não pode ser modificado com o ACBrTEFD Inicializado'));

  fPathBackup := Trim(AValue) ;

  if RightStr(fPathBackup,1) = PathDelim then   { Remove ultimo PathDelim }
     fPathBackup := copy( fPathBackup,1,Length(fPathBackup)-1 ) ;
end;

end.

