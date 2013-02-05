{******************************************************************************}
{ Projeto: Componente ACBrMDFe                                                 }
{  Biblioteca multiplataforma de componentes Delphi                            }
{                                                                              }
{  Você pode obter a última versão desse arquivo na pagina do Projeto ACBr     }
{ Componentes localizado em http://www.sourceforge.net/projects/acbr           }
{                                                                              }
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
|* 01/08/2012: Italo Jurisato Junior
|*  - Doação do componente para o Projeto ACBr
******************************************************************************}

{$I ACBr.inc}

unit ACBrMDFe;

interface

uses
  Classes, Sysutils,
{$IFDEF VisualCLX}
  QDialogs,
{$ELSE}
  Dialogs,
{$ENDIF}
  pcnConversao, pmdfeMDFe,
  pmdfeEnvEventoMDFe, pmdfeRetEnvEventoMDFe,
  ACBrMDFeManifestos, ACBrMDFeConfiguracoes,
  ACBrMDFeWebServices, ACBrMDFeUtil, ACBrMDFeDAMDFeClass;

const
  ACBRMDFe_VERSAO = '0.0.2';

type
  TACBrMDFeAboutInfo = (ACBrMDFeAbout);

  EACBrMDFeException = class(Exception);

  { Evento para gerar log das mensagens do Componente }
  TACBrMDFeLog = procedure(const Mensagem : String) of object;

  TACBrMDFe = class(TComponent)
  private
    fsAbout: TACBrMDFeAboutInfo;
    FDAMDFe : TACBrMDFeDAMDFeClass;
    FManifestos: TManifestos;
    FEventoMDFe: TEventoMDFe;
    FWebServices: TWebServices;
    FConfiguracoes: TConfiguracoes;
    FStatus : TStatusACBrMDFe;
    FOnStatusChange: TNotifyEvent;
    FOnGerarLog : TACBrMDFeLog;
  	procedure SetDAMDFe(const Value: TACBrMDFeDAMDFeClass);
  protected
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function Enviar(ALote: Integer; Imprimir:Boolean = True): Boolean;
    function Consultar: Boolean;
    function EnviarEventoMDFe(idLote : Integer): Boolean;
    property WebServices: TWebServices read FWebServices write FWebServices;
    property Manifestos: TManifestos read FManifestos write FManifestos;
    property EventoMDFe: TEventoMDFe read FEventoMDFe write FEventoMDFe;
    property Status: TStatusACBrMDFe read FStatus;
    procedure SetStatus( const stNewStatus : TStatusACBrMDFe );
  published
    property Configuracoes: TConfiguracoes read FConfiguracoes write FConfiguracoes;
    property OnStatusChange: TNotifyEvent read FOnStatusChange write FOnStatusChange;
  	property DAMDFe: TACBrMDFeDAMDFeClass read FDAMDFe write SetDAMDFe;
    property AboutACBrMDFe : TACBrMDFeAboutInfo read fsAbout write fsAbout stored false;
    property OnGerarLog : TACBrMDFeLog read FOnGerarLog write FOnGerarLog;
  end;

procedure ACBrAboutDialog;

implementation

procedure ACBrAboutDialog;
var
 Msg : String;
begin
  Msg := 'Componente ACBrMDFe'+#10+
         'Versão: '+ACBRMDFe_VERSAO+#10+#10+
         'Automação Comercial Brasil'+#10+#10+
         'http://acbr.sourceforge.net'+#10+#10+
         'Projeto Cooperar - PCN'+#10+#10+
         'http://www.projetocooperar.org/pcn/';

  MessageDlg(Msg ,mtInformation ,[mbOk],0);
end;

{ TACBrMDFe }

constructor TACBrMDFe.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  FConfiguracoes      := TConfiguracoes.Create( self );
  FConfiguracoes.Name := 'Configuracoes';

  {$IFDEF COMPILER6_UP}
     FConfiguracoes.SetSubComponent( true ); { para gravar no DFM/XFM }
  {$ENDIF}

  FManifestos               := TManifestos.Create(Self, Manifesto);
  FManifestos.Configuracoes := FConfiguracoes;
  FEventoMDFe               := TEventoMDFe.Create;
  FWebServices              := TWebServices.Create(Self);

  if FConfiguracoes.WebServices.Tentativas <= 0
   then FConfiguracoes.WebServices.Tentativas := 5;

  {$IFDEF ACBrMDFeOpenSSL}
     MDFeUtil.InitXmlSec;
  {$ENDIF}

  FOnGerarLog := nil;
end;

destructor TACBrMDFe.Destroy;
begin
  FConfiguracoes.Free;
  FManifestos.Free;
  FEventoMDFe.Free;
  FWebServices.Free;

  {$IFDEF ACBrMDFeOpenSSL}
     MDFeUtil.ShutDownXmlSec;
  {$ENDIF}

  inherited;
end;

procedure TACBrMDFe.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);

  if (Operation = opRemove) and (FDAMDFe <> nil) and (AComponent is TACBrMDFeDAMDFeClass) then
   FDAMDFe := nil;
end;

procedure TACBrMDFe.SetDAMDFe(const Value: TACBrMDFeDAMDFeClass);
var
 OldValue: TACBrMDFeDAMDFeClass;
begin
  if Value <> FDAMDFe then
  begin
    if Assigned(FDAMDFe) then
     FDAMDFe.RemoveFreeNotification(Self);

    OldValue  := FDAMDFe;   // Usa outra variavel para evitar Loop Infinito
    FDAMDFe   := Value;    // na remoção da associação dos componentes

    if Assigned(OldValue) then
     if Assigned(OldValue.ACBrMDFe) then
      OldValue.ACBrMDFe := nil;

    if Value <> nil then
     begin
       Value.FreeNotification(self);
       Value.ACBrMDFe := self;
     end;
  end;
end;

procedure TACBrMDFe.SetStatus( const stNewStatus : TStatusACBrMDFe );
begin
  if ( stNewStatus <> FStatus ) then
  begin
    FStatus := stNewStatus;
    if Assigned(fOnStatusChange) then
     FOnStatusChange(Self);
  end;
end;

function TACBrMDFe.Consultar: Boolean;
var
 i : Integer;
begin
  if Self.Manifestos.Count = 0 then
  begin
    if Assigned(Self.OnGerarLog)
     then Self.OnGerarLog('ERRO: Nenhum Manifesto Eletrônico de Documentos Fiscais Informado!');
     raise Exception.Create('Nenhum Manifesto Eletrônico de Documentos Fiscais Informado!');
  end;

  for i := 0 to Self.Manifestos.Count-1 do
  begin
    WebServices.Consulta.MDFeChave := copy(self.Manifestos.Items[i].MDFe.infMDFe.ID,
     (length(self.Manifestos.Items[i].MDFe.infMDFe.ID)-44)+1, 44);
    WebServices.Consulta.Executar;
  end;

  Result := True;
end;

function TACBrMDFe.Enviar(ALote: Integer; Imprimir:Boolean = True): Boolean;
var
 i: Integer;
begin
  if Manifestos.Count <= 0 then
  begin
    if Assigned(Self.OnGerarLog)
     then Self.OnGerarLog('ERRO: Nenhum MDF-e adicionado ao Lote');
     raise Exception.Create('ERRO: Nenhum MDF-e adicionado ao Lote');
    exit;
  end;

  if Manifestos.Count > 1 then
  begin
    if Assigned(Self.OnGerarLog)
     then Self.OnGerarLog('ERRO: Conjunto de MDF-e transmitidos (máximo de 1 MDF-e) excedido. Quantidade atual: '+IntToStr(Manifestos.Count));
     raise Exception.Create('ERRO: Conjunto de MDF-e transmitidos (máximo de 1 MDF-e) excedido. Quantidade atual: '+IntToStr(Manifestos.Count));
    exit;
  end;

  Manifestos.Assinar;
  Manifestos.Valida;

  Result := WebServices.Envia(ALote);

  if DAMDFe <> nil then
  begin
    for i:= 0 to Manifestos.Count-1 do
    begin
      if Manifestos.Items[i].Confirmada and Imprimir then
      begin
        Manifestos.Items[i].Imprimir;
      end;
    end;
  end;

end;

function TACBrMDFe.EnviarEventoMDFe(idLote: Integer): Boolean;
var
  i: integer;
begin
  if EventoMDFe.Evento.Count <= 0 then
   begin
      if Assigned(Self.OnGerarLog) then
         Self.OnGerarLog('ERRO: Nenhum Evento adicionado ao Lote');
      raise EACBrMDFeException.Create('ERRO: Nenhum Evento adicionado ao Lote');
     exit;
   end;

  if EventoMDFe.Evento.Count > 1 then
   begin
      if Assigned(Self.OnGerarLog) then
         Self.OnGerarLog('ERRO: Conjunto de Eventos transmitidos (máximo de 1) excedido. Quantidade atual: '+IntToStr(EventoMDFe.Evento.Count));
      raise EACBrMDFeException.Create('ERRO: Conjunto de Eventos transmitidos (máximo de 1) excedido. Quantidade atual: '+IntToStr(EventoMDFe.Evento.Count));
     exit;
   end;

  WebServices.EnvEvento.idLote := idLote;

  {Atribuir nSeqEvento, CNPJ, Chave e/ou Protocolo quando não especificar}
  for i:= 0 to EventoMDFe.Evento.Count -1 do
  begin
    try
      if EventoMDFe.Evento.Items[i].InfEvento.nSeqEvento = 0 then
        EventoMDFe.Evento.Items[i].infEvento.nSeqEvento := 1;
      if trim(EventoMDFe.Evento.Items[i].InfEvento.CNPJ) = '' then
        EventoMDFe.Evento.Items[i].InfEvento.CNPJ := self.Manifestos.Items[i].MDFe.Emit.CNPJ;
      if trim(EventoMDFe.Evento.Items[i].InfEvento.chMDFe) = '' then
        EventoMDFe.Evento.Items[i].InfEvento.chMDFe := copy(self.Manifestos.Items[i].MDFe.infMDFe.ID, (length(self.Manifestos.Items[i].MDFe.infMDFe.ID)-44)+1, 44);
      if trim(EventoMDFe.Evento.Items[i].infEvento.detEvento.nProt) = '' then
      begin
        if EventoMDFe.Evento.Items[i].infEvento.tpEvento = teCancelamento then
          EventoMDFe.Evento.Items[i].infEvento.detEvento.nProt := self.Manifestos.Items[i].MDFe.procMDFe.nProt;
      end;
    except
    end;
  end;
  {**}

  Result := WebServices.EnvEvento.Executar;
  if not Result then
  begin
    if Assigned(Self.OnGerarLog) then
      Self.OnGerarLog(WebServices.EnvEvento.Msg);
    raise EACBrMDFeException.Create(WebServices.EnvEvento.Msg);
  end;
end;

end.
