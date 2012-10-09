{$I ACBr.inc}

unit ACBrNFSe;

interface

uses
  Classes, Sysutils,
  pnfsNFSe, pnfsConversao,
{$IFDEF CLX}
  QDialogs,
{$ELSE}
  Dialogs,
{$ENDIF}
  ACBrNFSeNotasFiscais, ACBrNFSeConfiguracoes, ACBrNFSeWebServices,
  ACBrUtil, ACBrNFSeUtil, ACBrNFSeDANFSeClass;

const
  ACBrNFSe_VERSAO = '0.2.0';

type
  TACBrNFSeAboutInfo = (ACBrNFSeAbout);

  // Evento para gerar log das mensagens do Componente
  TACBrNFSeLog = procedure(const Mensagem : String) of object ;

  TACBrNFSe = class(TComponent)
  private
    fsAbout: TACBrNFSeAboutInfo;
    FDANFSe : TACBrNFSeDANFSeClass;
    FNotasFiscais: TNotasFiscais;
    FWebServices: TWebServices;
    FConfiguracoes: TConfiguracoes;
    FStatus : TStatusACBrNFSe;
    FOnStatusChange: TNotifyEvent;
    FOnGerarLog : TACBrNFSeLog;
    procedure SetDANFSe(const Value: TACBrNFSeDANFSeClass);
  protected
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function Enviar(ALote: Integer; Imprimir:Boolean = True): Boolean;
    function ConsutarSituacao(ACnpj, AInscricaoMunicipal, AProtocolo: String): Boolean;
    function ConsutarLoteRps(ANumLote, AProtocolo: String): Boolean;
    function ConsutarNFSeporRps(ANumero, ASerie, ATipo, ACnpj, AInscricaoMunicipal: String): Boolean;
    function ConsutarNFSe(ACnpj, AInscricaoMunicipal: String; ADataInicial, ADataFinal: TDateTime): Boolean;
    function CancelarNFSe(ACodigoCancelamento: String): Boolean;
    function Gerar(ARps: Integer): Boolean;

    property WebServices: TWebServices   read FWebServices  write FWebServices;
    property NotasFiscais: TNotasFiscais read FNotasFiscais write FNotasFiscais;
    property Status: TStatusACBrNFSe     read FStatus;
    procedure SetStatus( const stNewStatus : TStatusACBrNFSe );
  published
    property Configuracoes: TConfiguracoes     read FConfiguracoes  write FConfiguracoes;
    property OnStatusChange: TNotifyEvent      read FOnStatusChange write FOnStatusChange;
    property DANFSe: TACBrNFSeDANFSeClass      read FDANFSe         write SetDANFSe;
    property AboutACBrNFSe: TACBrNFSeAboutInfo read fsAbout         write fsAbout stored false;
    property OnGerarLog: TACBrNFSeLog          read FOnGerarLog     write FOnGerarLog;
  end;

procedure ACBrAboutDialog;

implementation

procedure ACBrAboutDialog;
var
 Msg: String;
begin
 Msg := 'Componente ACBrNFSe'+#10+
        'Versão: '+ACBRNFSe_VERSAO+#10+#10+
        'Automação Comercial Brasil'+#10+#10+
        'http://acbr.sourceforge.net'+#10+#10+
        'Projeto Cooperar - PCN'+#10+#10+
        'http://www.projetocooperar.org/pcn/';

 MessageDlg(Msg ,mtInformation ,[mbOk],0);
end;

{ TACBrNFSe }

procedure TACBrNFSe.SetDANFSe(const Value: TACBrNFSeDANFSeClass);
var
 OldValue: TACBrNFSeDANFSeClass;
begin
 if Value <> FDANFSe
  then begin
   if Assigned(FDANFSe)
    then FDANFSe.RemoveFreeNotification(Self);

   OldValue := FDANFSe;  // Usa outra variavel para evitar Loop Infinito
   FDANFSe  := Value;    // na remoção da associação dos componentes

   if Assigned(OldValue)
    then if Assigned(OldValue.ACBrNFSe)
          then OldValue.ACBrNFSe := nil;

   if Value <> nil
    then begin
     Value.FreeNotification(self);
     Value.ACBrNFSe := self;
    end;
  end;
end;

procedure TACBrNFSe.Notification(AComponent: TComponent; Operation: TOperation);
begin
 inherited Notification(AComponent, Operation);

 if (Operation = opRemove) and (FDANFSe <> nil) and
    (AComponent is TACBrNFSeDANFSeClass)
  then FDANFSe := nil;
end;

constructor TACBrNFSe.Create(AOwner: TComponent);
begin
 inherited Create(AOwner);

 FConfiguracoes      := TConfiguracoes.Create( self );
 FConfiguracoes.Name := 'Configuracoes';

 {$IFDEF COMPILER6_UP}
   FConfiguracoes.SetSubComponent( true ); { para gravar no DFM/XFM }
 {$ENDIF}

 FNotasFiscais               := TNotasFiscais.Create(Self, NotaFiscal);
 FNotasFiscais.Configuracoes := FConfiguracoes;
 FWebServices                := TWebServices.Create(Self);

 if FConfiguracoes.WebServices.Tentativas <= 0
  then FConfiguracoes.WebServices.Tentativas := 18;

 {$IFDEF ACBrNFSeOpenSSL}
   NotaUtil.InitXmlSec;
 {$ENDIF}

 FOnGerarLog := nil;
end;

destructor TACBrNFSe.Destroy;
begin
 FConfiguracoes.Free;
 FNotasFiscais.Free;
 FWebServices.Free;

 {$IFDEF ACBrNFSeOpenSSL}
   NotaUtil.ShutDownXmlSec;
 {$ENDIF}

 inherited destroy;
end;

function TACBrNFSe.Enviar(ALote: Integer; Imprimir: Boolean): Boolean;
var
 i: Integer;
begin
 if NotasFiscais.Count <= 0
  then begin
   if Assigned(Self.OnGerarLog)
    then Self.OnGerarLog('ERRO: Nenhum RPS adicionado ao Lote');
   raise Exception.Create('ERRO: Nenhum RPS adicionado ao Lote');
   exit;
  end;

 if NotasFiscais.Count > 50
  then begin
   if Assigned(Self.OnGerarLog)
    then Self.OnGerarLog('ERRO: Conjunto de RPS transmitidos (máximo de 50) excedido. Quantidade atual: '+IntToStr(NotasFiscais.Count));
   raise Exception.Create('ERRO: Conjunto de RPS transmitidos (máximo de 50) excedido. Quantidade atual: '+IntToStr(NotasFiscais.Count));
   exit;
  end;

 NotasFiscais.Assinar; // Assina os Rps

 Result := WebServices.Envia(ALote);

 if DANFSe <> nil
  then begin
   for i:= 0 to NotasFiscais.Count-1 do
    begin
     if {NotasFiscais.Items[i].Confirmada and} Imprimir
      then begin
       NotasFiscais.Items[i].Imprimir;
      end;
    end;
  end;
end;

function TACBrNFSe.ConsutarSituacao(ACnpj, AInscricaoMunicipal,
  AProtocolo: String): Boolean;
begin
 Result := WebServices.ConsultaSituacao(ACnpj, AInscricaoMunicipal, AProtocolo);
end;

function TACBrNFSe.ConsutarLoteRps(ANumLote, AProtocolo: String): Boolean;
var
 aPath: String;
 wAno, wMes, wDia: Word;
begin
 aPath := FConfiguracoes.Geral.PathSalvar;

 // Acrescentado por Endrigo Rodrigues
 if FConfiguracoes.Arquivos.PastaMensal
  then begin
   DecodeDate(Now, wAno, wMes, wDia);
   if Pos(IntToStr(wAno)+IntToStrZero(wMes,2),aPath) <= 0
    then aPath := PathWithDelim(aPath)+IntToStr(wAno)+IntToStrZero(wMes,2) + '\';
  end;

 // Alterado por Rodrigo Cantelli
 if FConfiguracoes.Arquivos.AdicionarLiteral
  then NotasFiscais.LoadFromFile(aPath+'Ger\'+ANumLote+'-env-lot.xml')
  else NotasFiscais.LoadFromFile(aPath+ANumLote+'-env-lot.xml');

 if NotasFiscais.Count <= 0
  then begin
   if Assigned(Self.OnGerarLog)
    then Self.OnGerarLog('ERRO: Nenhum RPS adicionado');
   raise Exception.Create('ERRO: Nenhum RPS adicionado');
   exit;
  end;

 Result := WebServices.ConsultaLoteRps(AProtocolo);
end;

function TACBrNFSe.ConsutarNFSeporRps(ANumero, ASerie, ATipo, ACnpj,
  AInscricaoMunicipal: String): Boolean;
begin
 if NotasFiscais.Count <= 0
  then begin
   if Assigned(Self.OnGerarLog)
    then Self.OnGerarLog('ERRO: Nenhum RPS adicionado');
   raise Exception.Create('ERRO: Nenhum RPS adicionado');
   exit;
  end;

 Result := WebServices.ConsutaNFSeporRps(ANumero, ASerie, ATipo, ACnpj, AInscricaoMunicipal);
end;

function TACBrNFSe.ConsutarNFSe(ACnpj, AInscricaoMunicipal: String;
  ADataInicial, ADataFinal: TDateTime): Boolean;
begin
 Result := WebServices.ConsutaNFSe(ACnpj, AInscricaoMunicipal, ADataInicial, ADataFinal);
end;

function TACBrNFSe.CancelarNFSe(ACodigoCancelamento: String): Boolean;
begin
  if Self.NotasFiscais.Count = 0 then
   begin
      if Assigned(Self.OnGerarLog) then
         Self.OnGerarLog('ERRO: Nenhuma Nota Fiscal de Serviço Eletrônica Informada!');
      raise Exception.Create('Nenhuma Nota Fiscal de Serviço Eletrônica Informada!');
   end;

 Result := WebServices.CancelaNFSe(ACodigoCancelamento);
end;

procedure TACBrNFSe.SetStatus( const stNewStatus : TStatusACBrNFSe );
begin
 if ( stNewStatus <> FStatus )
  then begin
   FStatus := stNewStatus;
   if Assigned(fOnStatusChange)
    then FOnStatusChange(Self);
  end;
end;

function TACBrNFSe.Gerar(ARps: Integer): Boolean;
var
 i: Integer;
begin
 if NotasFiscais.Count <= 0
  then begin
   if Assigned(Self.OnGerarLog)
    then Self.OnGerarLog('ERRO: Nenhum RPS adicionado');
   raise Exception.Create('ERRO: Nenhum RPS adicionado');
   exit;
  end;

 if NotasFiscais.Count > 1
  then begin
   if Assigned(Self.OnGerarLog)
    then Self.OnGerarLog('ERRO: Conjunto de RPS transmitidos (máximo de 1) excedido. Quantidade atual: '+IntToStr(NotasFiscais.Count));
   raise Exception.Create('ERRO: Conjunto de RPS transmitidos (máximo de 1) excedido. Quantidade atual: '+IntToStr(NotasFiscais.Count));
   exit;
  end;

 NotasFiscais.Assinar; // Assina os Rps

 Result := WebServices.Gera(ARps);
end;

end.
