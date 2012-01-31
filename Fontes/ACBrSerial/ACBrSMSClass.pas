{******************************************************************************}
{ Projeto: Componentes ACBr                                                    }
{  Biblioteca multiplataforma de componentes Delphi para interação com equipa- }
{ mentos de Automação Comercial utilizados no Brasil                           }
{                                                                              }
{ Direitos Autorais Reservados (c) 2004 Daniel Simoes de Almeida               }
{                                                                              }
{ Colaboradores nesse arquivo: Alexandre Rocha Lima e Marcondes                }
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

{$I ACBr.inc}

unit ACBrSMSClass;

interface

uses
  ACBrDevice, ACBrECF, Classes, SysUtils;

const
  CTRL_Z = #26;
  FALHA_INICIALIZACAO = 'Não foi possível inicializar o envio da mensagem.';
  FALHA_SINCARD_SINCRONIZADO = 'Sincard não sincronizado com a rede celular.';
  FALHA_NUMERO_TELEFONE = 'Falha ao definir o número de telefone do destinatário.';
  FALHA_ENVIAR_MENSAGEM = 'Não foi possível enviar a mensagem de texto.';
  FALHA_INDICE_MENSAGEM = 'Indice retornado inválido, mensagem não foi enviada.';

type
  EACBrSMSException = class(Exception);

  TACBrSMSModelo = (modNenhum, modDaruma, modZTE, modGenerico);
  TACBrSMSSincronismo = (sinErro, sinSincronizado, sinNaoSincronizado, sinBucandoRede);
  TACBrSMSSinCard = (sin1, sin2);
  TACBrSMSFiltro = (fltTudo, fltLidas, fltNaoLidas);

  TACBrSMSClass = class
  private
    fpRecebeConfirmacao: Boolean;
    fpSinCard: TACBrSMSSinCard;
    fpQuebraMensagens: Boolean;
    fpATTimeOut: Integer;
    procedure SetAtivo(const Value: Boolean);
  protected
    fpDevice: TACBrDevice;
    fpAtivo: Boolean;
    fpUltimaResposta: AnsiString;
    fpAtResult: Boolean;
    fpBandejasSimCard: Integer;
  public
    constructor Create(AOwner: TComponent);
    Destructor Destroy; override;

    procedure Ativar; virtual;
    procedure Desativar; virtual;

    procedure EnviarComando(Cmd: AnsiString);
    procedure EnviarBuffer(Cmd: AnsiString);

    function EmLinha: Boolean; virtual;
    function IMEI: AnsiString; virtual;
    function NivelSinal: Double; virtual;
    function Operadora: AnsiString; virtual;
    function Fabricante: AnsiString; virtual;
    function ModeloModem: AnsiString; virtual;
    function Firmware: AnsiString; virtual;
    function EstadoSincronismo: TACBrSMSSincronismo; virtual;

    procedure TrocarBandeja(const ASinCard: TACBrSMSSinCard); virtual;
    procedure EnviarSMS(const ATelefone, AMensagem: AnsiString;
      var AIndice: String); virtual;
    procedure ListarMensagens(const AFiltro: TACBrSMSFiltro;
      const APath: AnsiString); virtual;

    property Ativo: Boolean read fpAtivo write SetAtivo;
    property SinCard: TACBrSMSSinCard read fpSinCard write fpSinCard;
    property ATTimeOut: Integer read fpATTimeOut write fpATTimeOut;
    property ATResult: Boolean read fpATResult write fpATResult;
    property RecebeConfirmacao: Boolean read fpRecebeConfirmacao write fpRecebeConfirmacao;
    property QuebraMensagens: Boolean read fpQuebraMensagens write fpQuebraMensagens;
    property BandejasSimCard: Integer read fpBandejasSimCard;
    property UltimaResposta: AnsiString read fpUltimaResposta write fpUltimaResposta;
  end;

implementation

uses
  ACBrSMS, ACBrUtil;

{ TACBrSMSClass }

constructor TACBrSMSClass.Create(AOwner: TComponent);
begin
  fpDevice := (AOwner as TACBrSMS).Device;
  fpDevice.SetDefaultValues;
  fpDevice.TimeOut := 10000;
  fpDevice.Serial.AtTimeout := 10000;

  fpAtivo := False;
  fpSinCard := sin1;
  fpRecebeConfirmacao := False;
  fpQuebraMensagens := False;
  fpATResult := False;
  fpATTimeout := 10000;
  fpBandejasSimCard := 1;
  fpUltimaResposta := AnsiString(EmptyStr);
end;

destructor TACBrSMSClass.Destroy;
begin
  if Assigned(fpDevice) then
    fpDevice := nil;

  inherited Destroy;
end;

function TACBrSMSClass.EmLinha: Boolean;
begin
  Self.EnviarComando('AT');
  Result := fpATResult;
end;

function TACBrSMSClass.EstadoSincronismo: TACBrSMSSincronismo;
var
  RetCmd: AnsiString;
  Retorno: Integer;
begin
  Self.EnviarComando('AT+CREG?');

  if Self.ATResult then
  begin
    RetCmd := fpUltimaResposta;
    RetCmd := Trim(Copy(RetCmd, 1, Pos('OK', RetCmd) - 1));
    RetCmd := Trim(Copy(RetCmd, pos(':', RetCmd) + 1, Length(RetCmd)));

    if RetCmd = '0,1' then
      Result := sinSincronizado
    else if RetCmd = '0,2' then
      Result := sinBucandoRede
    else
      Result := sinNaoSincronizado;
  end
  else
    Result := sinErro;
end;

function TACBrSMSClass.Fabricante: AnsiString;
begin
  Self.EnviarComando('AT+CGMI');

  if Self.ATResult then
    Result := Trim(Copy(fpUltimaResposta, 1, Pos('OK', fpUltimaResposta) - 1))
  else
    Result := EmptyStr;
end;

function TACBrSMSClass.IMEI: AnsiString;
begin
  Self.EnviarComando('AT+CGSN');

  if Self.ATResult then
    Result := Trim(Copy(fpUltimaResposta, 1, Pos('OK', fpUltimaResposta) - 1))
  else
    Result := EmptyStr;
end;

procedure TACBrSMSClass.ListarMensagens(const AFiltro: TACBrSMSFiltro;
  const APath: AnsiString);
var
  cmd: AnsiString;
  Retorno: String;
  I: Integer;
begin
  case AFiltro of
    fltTudo:     cmd := 'AT+CMGL="ALL"';
    fltLidas:    cmd := 'AT+CMGL="REC READ"';
    fltNaoLidas: cmd := 'AT+CMGL="REC UNREAD"';
  end;

  Self.EnviarComando(cmd);
  if Self.ATResult then
  begin
    Retorno := EmptyStr;
    for I := 0 to Length(fpUltimaResposta) - 1 do
    begin
      if not(fpUltimaResposta[I] in [#0, #5, #$18, #$C]) then
        Retorno := Retorno + fpUltimaResposta[I];
    end;

    fpUltimaResposta := Trim(Retorno);
    WriteToTXT(APath, fpUltimaResposta, False, True);
  end;
end;

function TACBrSMSClass.ModeloModem: AnsiString;
begin
  Self.EnviarComando('AT+CGMM');

  if Self.ATResult then
    Result := Trim(Copy(fpUltimaResposta, 1, Pos('OK', fpUltimaResposta) - 1))
  else
    Result := EmptyStr;
end;

function TACBrSMSClass.NivelSinal: Double;
var
  RetCmd: AnsiString;
begin
  Self.EnviarComando('AT+CSQ');

  if Self.ATResult then
  begin
    RetCmd := AnsiUpperCase(fpUltimaResposta);
    RetCmd := Trim(Copy(RetCmd, 1, Pos('OK', RetCmd) - 1));
    RetCmd := Trim(Copy(RetCmd, pos(':', RetCmd) + 1, Length(RetCmd)));

    Result := StrToFloatDef(String(RetCmd), 0.00);
  end
  else
    Result := 0;
end;

function TACBrSMSClass.Operadora: AnsiString;
begin
  Self.EnviarComando('AT+COPS?');

  if Self.ATResult then
  begin
    Result := Trim(Copy(fpUltimaResposta, 1, Pos('OK', fpUltimaResposta) - 1));
    Result := Copy(Result, Pos('"', Result) + 1, Length(Result));
    Result := Copy(Result, 1, Pos('"', Result) - 1);
  end
  else
    Result := EmptyStr;
end;

function TACBrSMSClass.Firmware: AnsiString;
begin
  Self.EnviarComando('AT+CGMR');

  if Self.ATResult then
    Result := Trim(Copy(fpUltimaResposta, 1, Pos('OK', fpUltimaResposta) - 1))
  else
    Result := EmptyStr;
end;

procedure TACBrSMSClass.SetAtivo(const Value: Boolean);
begin
  if Value then
    Ativar
  else
    Desativar;
end;

procedure TACBrSMSClass.EnviarComando(Cmd: AnsiString);
var
  sRet: AnsiString;
begin
  fpUltimaResposta := '';
  fpAtResult := False;

  fpDevice.Serial.Purge;
  fpDevice.Serial.SendString(Cmd + sLineBreak);

  repeat
    sRet := fpDevice.Serial.Recvstring(fpATTimeOut);

    if sRet <> Cmd then
      fpUltimaResposta := fpUltimaResposta + sRet + sLineBreak;

    if sRet = 'ERROR' then
      break;
    if sRet = 'NO CARRIER' then
      break;
    if sRet = 'BUSY' then
      break;
    if sRet = 'NO DIALTONE' then
      break;

    if (sRet = 'OK') or
       (sRet = '>') or
       (Pos('CONNECT', String(sRet)) = 1) then
    begin
      fpAtResult := True;
      break;
    end;
  until fpDevice.Serial.LastError <> 0;

  fpUltimaResposta := Trim(fpUltimaResposta);
end;

procedure TACBrSMSClass.EnviarBuffer(Cmd: AnsiString);
var
  bRec: Integer;
begin
  fpDevice.Serial.Purge;
  ATResult := False;

  Cmd := Cmd + sLineBreak;
  bRec := fpDevice.Serial.SendBuffer(Pointer(Cmd), Length(Cmd));

  if bRec = Length(Cmd) then
  begin
    Sleep(500);
    fpUltimaResposta := Trim(fpDevice.Serial.RecvPacket(fpDevice.Serial.AtTimeout));
    AtResult := True;
  end
  else
    raise EACBrSMSException.Create('Falha ao enviar buffer de comando para o modem.');
end;

procedure TACBrSMSClass.Ativar;
begin
  if fpAtivo then
    exit;

  if fpDevice.Porta <> '' then
    fpDevice.Ativar;

  fpAtivo := True;
end;

procedure TACBrSMSClass.Desativar;
begin
  if not fpAtivo then
    exit;

  if fpDevice.Porta <> '' then
     fpDevice.Desativar;

  fpAtivo := False;
end;

procedure TACBrSMSClass.EnviarSMS(const ATelefone, AMensagem: AnsiString;
  var AIndice: String);
begin
  raise EACBrSMSException.Create('ENVIAR SMS não implementado.');
end;

procedure TACBrSMSClass.TrocarBandeja(const ASinCard: TACBrSMSSinCard);
begin
  raise EACBrSMSException.Create('Trocar Bandeja não implementado.');
end;

end.
