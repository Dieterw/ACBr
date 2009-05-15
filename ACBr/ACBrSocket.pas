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
{ Esse arquivo usa a classe  SynaSer   Copyright (c)2001-2003, Lukas Gebauer   }
{  Project : Ararat Synapse     (Found at URL: http://www.ararat.cz/synapse/)  }
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
|* 24/10/2008: Primeira Versao
|*    Daniel Simoes de Almeida
******************************************************************************}

{$I ACBr.inc}

unit ACBrSocket;

interface
uses SysUtils, Classes, Contnrs,
     blcksock, synsock, synamisc,  {Units da Synapse}
     ACBrBase ;

type

TACBrTCPServer = class ;

{ Evento disparada quando Conecta }
TACBrTCPServerConecta = procedure( const TCPBlockSocket : TTCPBlockSocket;
   var Enviar : AnsiString ) of object ;

{ Evento disparada quando DesConecta }
TACBrTCPServerDesConecta = procedure( const TCPBlockSocket : TTCPBlockSocket;
   Erro: Integer; ErroDesc : String ) of object ;

{ Evento disparado quando recebe dados }
TACBrTCPServerRecive = procedure( const TCPBlockSocket : TTCPBlockSocket;
   const Recebido : AnsiString; var Enviar : AnsiString) of object ;

TACBrTCPServerDaemon = class(TThread)
  private
    fsSock : TTCPBlockSocket;
    fsACBrTCPServer : TACBrTCPServer ;

  protected
    property ACBrTCPServer : TACBrTCPServer read fsACBrTCPServer ;

  public
    Constructor Create( const ACBrTCPServer : TACBrTCPServer );
    Destructor Destroy; override;
    procedure Execute; override;

    property TCPBlockSocket : TTCPBlockSocket read fsSock ;
  end;

TACBrTCPServerThread = class(TThread)
  private
    fsACBrTCPServerDaemon : TACBrTCPServerDaemon ;
    fsSock   : TTCPBlockSocket;
    fsStrRcv, fsStrToSend : AnsiString ;
    fsCSock  : TSocket;
    fsErro   : Integer ;
    function GetActive: Boolean;
  protected
    procedure CallOnRecebeDados ;
    procedure CallOnConecta ;
    procedure CallOnDesConecta ;
  public
    Constructor Create(ClientSocket: TSocket; ACBrTCPServerDaemon : TACBrTCPServerDaemon);
    procedure Execute; override;

    property Active : Boolean read GetActive ;
    property TCPBlockSocket : TTCPBlockSocket read fsSock ;
  end;

{ Lista de Threads (conexões) do TACBrTCPServer }
TACBrTCPServerThreadList = class(TObjectList)
  protected
    procedure SetObject (Index: Integer; Item: TACBrTCPServerThread);
    function GetObject (Index: Integer): TACBrTCPServerThread;
    procedure Insert (Index: Integer; Obj: TACBrTCPServerThread);
  public
    function Add (Obj: TACBrTCPServerThread): Integer;
    property Objects [Index: Integer]: TACBrTCPServerThread
      read GetObject write SetObject; default;
  end;

{ Componente ACBrTCPServer - Servidor TCP muito simples }

{ TACBrTCPServer }

TACBrTCPServer = class( TACBrComponent )
  private
    { Propriedades do Componente ACBrTCPServer }
    fsACBrTCPServerDaemon : TACBrTCPServerDaemon ;
    fsTimeOut: Integer;
    fsIP: String;
    fsPort: String;
    fsThreadList : TACBrTCPServerThreadList ;
    fsOnConecta: TACBrTCPServerConecta;
    fsOnRecebeDados: TACBrTCPServerRecive;
    fsOnDesConecta: TACBrTCPServerDesConecta;
    fsTerminador : String;
    fs_Terminador: AnsiString;
    function GetTCPBlockSocket: TTCPBlockSocket ;
    procedure SetAtivo(const Value: Boolean);
    procedure SetIP(const Value: String);
    procedure SetPort(const Value: String);
    procedure SetTerminador( const AValue: String) ;
    procedure SetTimeOut(const Value: Integer);

    procedure VerificaAtivo ;
    function GetAtivo: Boolean;
  public
    constructor Create(AOwner: TComponent); override;
    Destructor Destroy  ; override;

    procedure Ativar ;
    procedure Desativar ;
    procedure EnviarString(const AString : AnsiString; NumConexao : Integer ) ;

    property Ativo : Boolean read GetAtivo write SetAtivo ;
    property ThreadList : TACBrTCPServerThreadList read fsThreadList ;
    property StrTerminador : AnsiString  read fs_Terminador  ;

     { Instancia do Componente TACBrTCPServerDaemon }
    property ACBrTCPServerDaemon : TACBrTCPServerDaemon read fsACBrTCPServerDaemon ;
    property TCPBlockSocket : TTCPBlockSocket read GetTCPBlockSocket ;
  published
    property IP         : String  read fsIP         write SetIP;
    property Port       : String  read fsPort       write SetPort ;
    property TimeOut    : Integer read fsTimeOut    write SetTimeOut
       default 5000 ;
    property Terminador : String  read fsTerminador write SetTerminador ;

    property OnConecta     : TACBrTCPServerConecta    read  fsOnConecta
                                                      write fsOnConecta ;
    property OnDesConecta  : TACBrTCPServerDesConecta read  fsOnDesConecta
                                                      write fsOnDesConecta ;
    property OnRecebeDados : TACBrTCPServerRecive     read  fsOnRecebeDados
                                                      write fsOnRecebeDados ;
end ;

implementation

Uses ACBrUtil ;

{ TACBrTCPServerDaemon }

constructor TACBrTCPServerDaemon.Create( const ACBrTCPServer : TACBrTCPServer );
begin
  inherited create(False) ;

  fsACBrTCPServer := ACBrTCPServer ;
  fsSock := TTCPBlockSocket.create ;
  FreeOnTerminate := False ;
end;

destructor TACBrTCPServerDaemon.Destroy;
begin
  fsSock.Free ;
end;

procedure TACBrTCPServerDaemon.Execute;
var
  ClientSock : TSocket;
begin
  with fsSock do
  begin
//   CreateSocket ;
     SetLinger(True,10) ;
     Bind( fsACBrTCPServer.IP , fsACBrTCPServer.Port ) ;
     Listen ;

     repeat
        if Terminated then
           break ;

        if CanRead( 1000 ) then
        begin
           ClientSock := Accept;
           if lastError = 0 then
              TACBrTCPServerThread.create(ClientSock, Self);
        end;
     until false;
  end;
end;

{ TACBrTCPServerThread }

Constructor TACBrTCPServerThread.Create(ClientSocket: TSocket;
   ACBrTCPServerDaemon : TACBrTCPServerDaemon);
begin
  inherited create(false);

  fsACBrTCPServerDaemon := ACBrTCPServerDaemon ;
  fsCSock  := ClientSocket ;
  FreeOnTerminate := True ;
end;

procedure TACBrTCPServerThread.Execute;
begin
  fsSock := TTCPBlockSocket.create;
  try
     fsSock.Socket := fsCSock ;
     fsSock.GetSins;
     with fsSock do
     begin
        fsStrToSend := '' ;
        fsErro      := 0 ;

        Synchronize( CallOnConecta );

        if fsStrToSend <> '' then
        begin
           SendString( fsStrToSend );
           fsErro := LastError ;
        end ;

        while fsErro = 0 do
        begin
           if terminated then
           begin
              fsErro := -1 ;
              break;
           end ;

           if not Assigned( fsACBrTCPServerDaemon ) then  // O Daemon ainda existe ?
           begin
              fsErro := -1 ;
              break ;
           end ;

           if fsACBrTCPServerDaemon.Terminated then   // O Daemon está rodando ?
           begin
              fsErro := -1 ;
              break ;
           end ;

           // Se não tem nada para ler, re-inicia o loop //
           if not fsSock.CanRead( 1000 ) then
              Continue ;

           // Se tem Terminador, lê até chagar o Terminador //
           if fsACBrTCPServerDaemon.ACBrTCPServer.StrTerminador <> '' then
              fsStrRcv := RecvTerminated(  fsACBrTCPServerDaemon.ACBrTCPServer.TimeOut,
                                           fsACBrTCPServerDaemon.ACBrTCPServer.StrTerminador )
           else
              fsStrRcv := RecvPacket( fsACBrTCPServerDaemon.ACBrTCPServer.TimeOut ) ;

           fsErro := LastError ;
           if fsErro <> 0 then
              break;

           if Assigned( fsACBrTCPServerDaemon.ACBrTCPServer.OnRecebeDados ) then
              Synchronize( CallOnRecebeDados );

           if fsStrToSend <> '' then
           begin
              SendString( fsStrToSend );
              fsErro := LastError ;
           end ;
        end;

        // Chama o evento de Desconexão...
        Synchronize( CallOnDesConecta );
     end;
  finally
     fsSock.CloseSocket ;
     fsSock.Free;
  end;
end;

procedure TACBrTCPServerThread.CallOnRecebeDados;
begin
  fsStrToSend := '' ;
  fsACBrTCPServerDaemon.ACBrTCPServer.OnRecebeDados( fsSock, fsStrRcv, fsStrToSend ) ;
end;

procedure TACBrTCPServerThread.CallOnConecta;
begin
  // Adiciona essa Thread na Lista de Threads
  fsACBrTCPServerDaemon.ACBrTCPServer.ThreadList.Add( Self ) ;

  // Chama o Evento, se estiver atribuido
  if Assigned( fsACBrTCPServerDaemon.ACBrTCPServer.OnConecta ) then
  begin
     fsStrToSend := '' ;
     fsACBrTCPServerDaemon.ACBrTCPServer.OnConecta( fsSock, fsStrToSend ) ;
  end ;
end;

procedure TACBrTCPServerThread.CallOnDesConecta;
 Var ErroDesc : String ;
begin
  // Remove essa Thread da Lista de Threads
  fsACBrTCPServerDaemon.ACBrTCPServer.ThreadList.Remove( Self ) ;

  // Chama o Evento, se estiver atribuido
  if Assigned( fsACBrTCPServerDaemon.ACBrTCPServer.OnDesConecta ) then
  begin
     ErroDesc := fsSock.GetErrorDesc( fsErro ) ;
     fsACBrTCPServerDaemon.ACBrTCPServer.OnDesConecta( fsSock, fsErro, ErroDesc ) ;
  end ;
end;

function TACBrTCPServerThread.GetActive: Boolean;
begin
  Result := (not self.Terminated) and (fsSock.LastError = 0) ;
end;

{ TACBrTCPServerThreadList }

function TACBrTCPServerThreadList.Add(Obj: TACBrTCPServerThread): Integer;
begin
  Result := inherited Add(Obj) ;
end;

function TACBrTCPServerThreadList.GetObject(
  Index: Integer): TACBrTCPServerThread;
  Var AObject : TObject ;
begin
  AObject := inherited GetItem(Index) ;
  Result := nil ;
  if Assigned( AObject ) then
     if AObject is TACBrTCPServerThread then
        Result := AObject as TACBrTCPServerThread ;
end;

procedure TACBrTCPServerThreadList.Insert(Index: Integer;
  Obj: TACBrTCPServerThread);
begin
  inherited Insert(Index, Obj);
end;

procedure TACBrTCPServerThreadList.SetObject(Index: Integer;
  Item: TACBrTCPServerThread);
begin
  inherited SetItem (Index, Item) ;
end;

{ TACBrTCPServer }

constructor TACBrTCPServer.Create(AOwner: TComponent);
begin
  inherited create( AOwner );

  fsIP   := '0.0.0.0' ;
  fsPort := '0' ;
  fsTimeOut := 5000 ;
  fsTerminador  := '#13,#10' ;
  fs_Terminador := #13+#10 ;

  fsACBrTCPServerDaemon := nil ;
  fsThreadList := TACBrTCPServerThreadList.Create( False ) ;
end;

destructor TACBrTCPServer.Destroy;
begin
  fsThreadList.Free ;

  inherited Destroy;
end;

function TACBrTCPServer.GetAtivo: Boolean;
begin
  Result := Assigned( fsACBrTCPServerDaemon ) ;
end;

procedure TACBrTCPServer.SetAtivo(const Value: Boolean);
begin
  if Value then
     Ativar
  else
     Desativar ;
end;

function TACBrTCPServer.GetTCPBlockSocket: TTCPBlockSocket ;
begin
   Result := nil ;
   if Assigned( fsACBrTCPServerDaemon ) then
      Result := fsACBrTCPServerDaemon.TCPBlockSocket ;
end;

procedure TACBrTCPServer.Ativar;
begin
  if Assigned( fsACBrTCPServerDaemon ) then
     exit ;

  fsACBrTCPServerDaemon := TACBrTCPServerDaemon.Create( Self );
end;

procedure TACBrTCPServer.Desativar;
 Var I : Integer ;
begin
  if not Assigned( fsACBrTCPServerDaemon )then
     exit ;

  fsACBrTCPServerDaemon.Terminate ;
  fsACBrTCPServerDaemon.WaitFor ;

  For I := 0 to fsThreadList.Count - 1 do
  begin
    if Assigned( fsThreadList[I] ) then
    begin
       fsThreadList[I].Terminate ;
//       fsThreadList[I].WaitFor ;
    end ;
  end ;
  fsThreadList.Clear ;

  FreeAndNil( fsACBrTCPServerDaemon ) ;
end;

procedure TACBrTCPServer.SetIP(const Value: String);
begin
  VerificaAtivo ;
  fsIP := Value;
end;

procedure TACBrTCPServer.SetPort(const Value: String);
begin
  VerificaAtivo ;
  fsPort := Value;
end;

procedure TACBrTCPServer.SetTerminador( const AValue: String) ;
begin
  VerificaAtivo ;
  fsTerminador  := AValue;
  fs_Terminador := Trim(TraduzComando( AValue )) ;
end;

procedure TACBrTCPServer.SetTimeOut(const Value: Integer);
begin
  VerificaAtivo ;
  fsTimeOut := Value;
end;


procedure TACBrTCPServer.VerificaAtivo;
begin
  if Ativo then
     raise Exception.Create( 'Não é possível modificar as propriedades com '+
                             'o componente Ativo');
end;

procedure TACBrTCPServer.EnviarString(const AString : AnsiString;
   NumConexao : Integer ) ;
 Var I : Integer ;
begin
  if not Ativo then
     raise Exception.Create('Componente ACBrTCPServer não está ATIVO');

  if NumConexao >= ThreadList.Count then
     raise Exception.Create('Numero de conexão inexistente: '+IntToStr(NumConexao));

  if NumConexao < 0 then
   begin
     For I := 0 to ThreadList.Count-1 do
        ThreadList[I].TCPBlockSocket.SendString( AString );
   end
  else
     ThreadList[NumConexao].TCPBlockSocket.SendString( AString );
end;

end.
