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

unit ACBrSMSDaruma;

interface

uses
  ACBrSMSClass, Classes, SysUtils;

type
  TACBrSMSDaruma = class(TACBrSMSClass)
  private

  public
    constructor Create(AOwner: TComponent);

    function EmLinha: Boolean; override;
    function IMEI: AnsiString; override;
    function Operadora: AnsiString; override;
    function NivelSinal: Double; override;
    function Fabricante: AnsiString; override;
    function ModeloModem: AnsiString; override;
    function Firmware: AnsiString; override;

    procedure TrocarBandeja(const ASinCard: TACBrSMSSinCard); override;
    procedure EnviarSMS(const ATelefone: AnsiString;
      const AMensagem: AnsiString; var AIndice: String); override;
    procedure ListarMensagens(const AFiltro: TACBrSMSFiltro;
      const APath: AnsiString); override;

  end;

implementation

uses
  ACBrDevice, ACBrUtil;

{ TACBrSMSDaruma }

constructor TACBrSMSDaruma.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  fpDevice.Baud := 115200;
  fpDevice.TimeOut := 10000;
  fpDevice.HandShake := hsNenhum;
  fpDevice.Serial.AtTimeout := 10000;
end;

procedure TACBrSMSDaruma.TrocarBandeja(const ASinCard: TACBrSMSSinCard);
var
  cmd: AnsiString;
begin
  case ASinCard of
    sin1: cmd := 'ATL1';
    sin2: cmd := 'ATL2';
  end;

  fpDevice.Serial.Purge;
  fpUltimaResposta := Trim(fpDevice.Serial.ATCommand(cmd));

  if not fpDevice.Serial.ATResult then
    raise EACBrSMSException.Create('Não foi possível efetuar a troca da bandeja.');
end;

function TACBrSMSDaruma.EmLinha: Boolean;
var
  Cmd: AnsiString;
begin
  Cmd := 'AT';

  fpDevice.Serial.Purge;
  fpUltimaResposta := Trim(fpDevice.Serial.ATCommand(Cmd));

  Result := fpDevice.Serial.ATResult;
end;

function TACBrSMSDaruma.IMEI: AnsiString;
var
  Cmd: AnsiString;
begin
  Cmd := 'AT+CGSN';

  fpDevice.Serial.Purge;
  fpUltimaResposta := Trim(fpDevice.Serial.ATCommand(Cmd));

  if fpDevice.Serial.ATResult then
    Result := Trim(Copy(fpUltimaResposta, 1, Pos('OK', fpUltimaResposta) - 1))
  else
    Result := EmptyStr;
end;

procedure TACBrSMSDaruma.ListarMensagens(const AFiltro: TACBrSMSFiltro;
  const APath: AnsiString);
var
  cmd: AnsiString;
  Retorno: String;
  I: Integer;
begin
  TrocarBandeja(Self.SinCard);

  case AFiltro of
    fltTudo:     cmd := 'AT+CMGL="ALL"';
    fltLidas:    cmd := 'AT+CMGL="REC READ"';
    fltNaoLidas: cmd := 'AT+CMGL="REC UNREAD"';
  end;

  fpDevice.Serial.Purge;
  fpUltimaResposta := Trim(fpDevice.Serial.ATCommand(cmd));

  Retorno := EmptyStr;
  for I := 0 to Length(fpUltimaResposta) - 1 do
  begin
    if not(fpUltimaResposta[I] in [#0, #5, #$18, #$C]) then
      Retorno := Retorno + fpUltimaResposta[I];
  end;

  fpUltimaResposta := Trim(Retorno);
  WriteToTXT(APath, fpUltimaResposta, False, True);
end;

function TACBrSMSDaruma.ModeloModem: AnsiString;
var
  Cmd: AnsiString;
begin
  Cmd := 'AT+CGMM';

  fpDevice.Serial.Purge;
  fpUltimaResposta := Trim(fpDevice.Serial.ATCommand(Cmd));

  if fpDevice.Serial.ATResult then
    Result := Trim(Copy(fpUltimaResposta, 1, Pos('OK', fpUltimaResposta) - 1))
  else
    Result := EmptyStr;
end;

function TACBrSMSDaruma.Fabricante: AnsiString;
var
  Cmd: AnsiString;
begin
  Cmd := 'AT+CGMI';

  fpDevice.Serial.Purge;
  fpUltimaResposta := Trim(fpDevice.Serial.ATCommand(Cmd));

  if fpDevice.Serial.ATResult then
    Result := Trim(Copy(fpUltimaResposta, 1, Pos('OK', fpUltimaResposta) - 1))
  else
    Result := EmptyStr;
end;

function TACBrSMSDaruma.Firmware: AnsiString;
var
  Cmd: AnsiString;
begin
  Cmd := 'AT+CGMR';

  fpDevice.Serial.Purge;
  fpUltimaResposta := Trim(fpDevice.Serial.ATCommand(Cmd));

  if fpDevice.Serial.ATResult then
    Result := Trim(Copy(fpUltimaResposta, 1, Pos('OK', fpUltimaResposta) - 1))
  else
    Result := EmptyStr;
end;

function TACBrSMSDaruma.NivelSinal: Double;
var
  Cmd: AnsiString;
  RetCmd: AnsiString;
begin
  Cmd := 'AT+CSQ';

  fpDevice.Serial.Purge;
  fpUltimaResposta := Trim(fpDevice.Serial.ATCommand(Cmd));

  if fpDevice.Serial.ATResult then
  begin
    RetCmd := AnsiUpperCase(fpUltimaResposta);
    RetCmd := Trim(Copy(RetCmd, 1, Pos('OK', RetCmd) - 1));
    RetCmd := Trim(Copy(RetCmd, pos(':', RetCmd) + 1, Length(RetCmd)));

    Result := StrToFloatDef(String(RetCmd), 0.00);
  end
  else
    Result := 0;
end;

function TACBrSMSDaruma.Operadora: AnsiString;
var
  Cmd: AnsiString;
begin
  Cmd := 'AT+COPS?';

  fpDevice.Serial.Purge;
  fpUltimaResposta := Trim(fpDevice.Serial.ATCommand(Cmd));

  if fpDevice.Serial.ATResult then
  begin
    Result := Trim(Copy(fpUltimaResposta, 1, Pos('OK', fpUltimaResposta) - 1));
    Result := Copy(Result, Pos('"', Result) + 1, Length(Result));
    Result := Copy(Result, 1, Pos('"', Result) - 1);
  end
  else
    Result := EmptyStr;
end;

procedure TACBrSMSDaruma.EnviarSMS(const ATelefone,
  AMensagem: AnsiString; var AIndice: String);
var
  Cmd: AnsiString;
  bRec: Integer;
  Ret: AnsiString;
const
  CR = #13;
  CTRL_Z = #26;
begin
  // definir a bandeja da qual será enviada a mensagem *************************
  TrocarBandeja(Self.SinCard);

  // definir o modo de envio ***************************************************
  Cmd := 'AT+CMGF=1';
  fpUltimaResposta := Trim(fpDevice.Serial.ATCommand(Cmd));
  if not fpDevice.Serial.ATResult then
    raise EACBrSMSException.Create(FALHA_INICIALIZACAO + sLineBreak + fpUltimaResposta);

  // definir o número de telefone do destinatário ******************************
  Cmd := 'AT+CMGS="' + ATelefone + '"' + CR;
  fpDevice.Serial.Purge;
  bRec := fpDevice.Serial.SendBuffer(Pointer(Cmd), Length(Cmd));
  if bRec = Length(Cmd) then
  begin
    Sleep(1000);
    fpUltimaResposta := Trim(fpDevice.Serial.RecvPacket(fpDevice.Serial.AtTimeout));
    if Pos('>', fpUltimaResposta ) <= 0 then
      raise EACBrSMSException.Create(FALHA_NUMERO_TELEFONE + sLineBreak + fpUltimaResposta);
  end
  else
    raise EACBrSMSException.Create(FALHA_NUMERO_TELEFONE);

  // Enviar a mensagem *********************************************************
  Cmd := Trim(AMensagem) + CTRL_Z + CR;
  fpUltimaResposta := fpDevice.Serial.ATCommand(Cmd);
  if not fpDevice.Serial.ATResult then
    raise EACBrSMSException.Create(FALHA_ENVIAR_MENSAGEM + sLineBreak + fpUltimaResposta);

  // verificar se foi retornado indice da mensagem
  Ret := fpUltimaResposta;
  if Pos(':', Ret) >= 0 then
  begin
    // separar o indice da mensagem
    Ret := Trim(Copy(Ret, Pos(':', Ret) + 1, Length(Ret)));
    Ret := Trim(Copy(Ret, 1, Pos('OK', Ret) - 1));

    AIndice := IntToStr(StrToIntDef(Trim(Ret), -1));
    if AIndice = '-1' then
      raise EACBrSMSException.Create(FALHA_INDICE_MENSAGEM + sLineBreak + fpUltimaResposta);
  end;
end;

end.
