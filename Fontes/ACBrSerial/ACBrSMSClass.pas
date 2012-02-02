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
  ACBrDevice, Classes, SysUtils, Contnrs;

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

  TACBrSMSMensagem = class
  private
    FMensagem: String;
    FTelefone: String;
  public
    property Telefone: String read FTelefone write FTelefone;
    property Mensagem: String read FMensagem write FMensagem;
  end;

  TACBrSMSMensagens = class(TObjectList)
  protected
    procedure SetObject (Index: Integer; Item: TACBrSMSMensagem);
    function GetObject (Index: Integer): TACBrSMSMensagem;
    procedure Insert (Index: Integer; Obj: TACBrSMSMensagem);
  public
    procedure LoadFromFrile(const APath: String);
    function Add: TACBrSMSMensagem; overload;
    function Add (Obj: TACBrSMSMensagem): Integer; overload;
    property Objects [Index: Integer]: TACBrSMSMensagem read GetObject write SetObject; default;
  end;

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
    fpUltimoComando: AnsiString;
    fpAtResult: Boolean;
    fpBandejasSimCard: Integer;
  public
    constructor Create(AOwner: TComponent);
    Destructor Destroy; override;

    procedure Ativar; virtual;
    procedure Desativar; virtual;

    procedure EnviarComando(Cmd: AnsiString);
    
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
    property UltimoComando: AnsiString read fpUltimoComando write fpUltimoComando;
  end;

implementation

uses
  ACBrSMS, ACBrUtil;

{ TACBrSMSMensagens }

function TACBrSMSMensagens.Add: TACBrSMSMensagem;
begin
  Result := TACBrSMSMensagem.create;
  Add(Result);
end;

function TACBrSMSMensagens.Add(Obj: TACBrSMSMensagem): Integer;
begin
  Result := inherited Add(Obj);
end;

function TACBrSMSMensagens.GetObject(Index: Integer): TACBrSMSMensagem;
begin
  Result := inherited GetItem(Index) as TACBrSMSMensagem ;
end;

procedure TACBrSMSMensagens.Insert(Index: Integer; Obj: TACBrSMSMensagem);
begin
  inherited Insert(Index, Obj);
end;

procedure TACBrSMSMensagens.LoadFromFrile(const APath: String);
var
  F: TStringList;
  R: TStringList;
  I: Integer;
begin
  if not FileExists(APath) then
    raise EACBrSMSException.CreateFmt('Arquivo "%s" não encontrado.', [APath]);

  F := TStringList.Create;
  R := TStringList.Create;
  try
    F.LoadFromFile(APath);

    Self.Clear;
    for I := 0 to F.Count - 1 do
    begin
      R.Text := StringReplace(F.Strings[I], '|', sLineBreak, [rfReplaceAll]);
      if R.Count = 2 then
      begin
        with Self.Add do
        begin
          Telefone := R.Strings[0];
          Mensagem := R.Strings[1];
        end;
      end;
    end;
  finally
    R.Free;
    F.Free;
  end;
end;

procedure TACBrSMSMensagens.SetObject(Index: Integer; Item: TACBrSMSMensagem);
begin
  inherited SetItem (Index, Item) ;
end;

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
  fpUltimoComando := AnsiString(EmptyStr);
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
  fpUltimoComando := Cmd;
  fpAtResult := False;

  fpDevice.Serial.Purge;
  fpDevice.Serial.SendString(Cmd + sLineBreak);

  repeat
    sRet := fpDevice.Serial.RecvPacket(fpATTimeOut);

    if sRet <> Cmd then
      fpUltimaResposta := fpUltimaResposta + sRet;

    if (Pos('ERROR', sRet) > 0) or
       (Pos('NO CARRIER', sRet) > 0) or
       (Pos('BUSY', sRet) > 0) or
       (Pos('NO DIALTONE', sRet) > 0) then
    begin
      break;
    end;

    if (Pos('OK', sRet) > 0) or
       (Pos('>', sRet) > 0) or
       (Pos('CONNECT', String(sRet)) = 1) then
    begin
      fpAtResult := True;
      break;
    end;
  until fpDevice.Serial.LastError <> 0;

  fpUltimaResposta := Trim(fpUltimaResposta);
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
var
  Cmd: AnsiString;
  Ret: AnsiString;
begin
  // definir o modo de envio ***************************************************
  Cmd := 'AT+CMGF=1';
  Self.EnviarComando(Cmd);
  if not Self.ATResult then
    raise EACBrSMSException.Create(FALHA_INICIALIZACAO + sLineBreak + fpUltimaResposta);


  // definir o número de telefone do destinatário ******************************
  Cmd := 'AT+CMGS="' + ATelefone + '"';
  Self.EnviarComando(Cmd);
  if not Self.ATResult then
    raise EACBrSMSException.Create(FALHA_NUMERO_TELEFONE + sLineBreak + fpUltimaResposta);


  // Enviar a mensagem *********************************************************
  Cmd := Trim(AMensagem) + CTRL_Z;
  Self.EnviarComando(Cmd);
  if not Self.ATResult then
    raise EACBrSMSException.Create(FALHA_ENVIAR_MENSAGEM + sLineBreak + fpUltimaResposta);


  // verificar se foi retornado indice da mensagem *****************************
  Ret := fpUltimaResposta;
  if Pos(':', Ret) >= 0 then
  begin
    // separar o indice da mensagem
    Ret := Trim(Copy(Ret, Pos(':', Ret) + 1, Length(Ret)));
    Ret := Trim(Copy(Ret, 1, Pos('OK', Ret) - 1));

    AIndice := IntToStr(StrToIntDef(Trim(Ret), -1));
    if AIndice = '-1' then
      raise EACBrSMSException.Create(FALHA_INDICE_MENSAGEM + sLineBreak + fpUltimaResposta);
  end
  else
    AIndice := '-1';
end;

procedure TACBrSMSClass.TrocarBandeja(const ASinCard: TACBrSMSSinCard);
begin
  raise EACBrSMSException.Create('Dispositivo não possui suporte para a troca de bandejas SimCard.');
end;

end.
