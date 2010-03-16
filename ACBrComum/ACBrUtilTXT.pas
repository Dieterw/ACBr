{******************************************************************************}
{ Projeto: Componentes ACBr                                                    }
{  Biblioteca multiplataforma de componentes Delphi para interação com equipa- }
{ mentos de Automação Comercial utilizados no Brasil                           }
{                                                                              }
{ Direitos Autorais Reservados (c) 2009   Isaque Pinheiro                      }
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
|* 10/04/2009: Isaque Pinheiro
|*  - Criação e distribuição da Primeira Versao
*******************************************************************************}

unit ACBrUtilTXT;

interface

uses SysUtils, Classes, DateUtils;

type
  TErrorEvent = procedure(const MsnError: AnsiString) of object;

  TACBrTXT = class(TComponent)
  private
    FOnError: TErrorEvent;
    FDelimitador: AnsiString;     /// Caracter delimitador de campos
    FTrimString: boolean;         /// Retorna a string sem espaços em branco iniciais e finais
    FCurMascara: AnsiString;      /// Mascara para valores tipo currency

    function GetOnError: TErrorEvent; /// Método do evento OnError
    procedure SetOnError(const Value: TErrorEvent); /// Método SetError
    procedure AssignError(MsnError: AnsiString);
  protected
    function GetDelimitador: AnsiString; virtual;
    function GetTrimString: boolean; virtual;
    function GetCurMascara: AnsiString; virtual;
    procedure SetDelimitador(const Value: AnsiString); virtual;
    procedure SetTrimString(const Value: boolean); virtual;
    procedure SetCurMascara(const Value: AnsiString); virtual;
  public
    constructor Create(AOwner: TComponent); override; /// Create
    destructor Destroy; override; /// Destroy

    function RFill(Value: AnsiString; Size: Integer = 0; Caracter: Char = ' '): AnsiString; overload;
    function LFill(Value: AnsiString; Size: Integer = 0; Caracter: Char = '0'): AnsiString; overload;
    function LFill(Value: Currency; Size: Integer; Decimal: Integer = 2; Nulo: Boolean = false; Caracter: Char = '0'): AnsiString; overload;
    function LFill(Value: Integer; Size: Integer; Nulo: Boolean = false; Caracter: Char = '0'): AnsiString; overload;
    function LFill(Value: TDateTime; Mask: AnsiString = 'ddmmyyyy'; Nulo: Boolean = false): AnsiString; overload;
    ///
    procedure Check(Condicao: Boolean; const Msg: AnsiString); overload;
    procedure Check(Condicao: Boolean; Msg: AnsiString; Fmt: array of const); overload;
    ///
    property Delimitador: AnsiString read GetDelimitador write SetDelimitador;
    property TrimString: boolean read GetTrimString write SetTrimString;
    property CurMascara: AnsiString read GetCurMascara write SetCurMascara;

    property OnError: TErrorEvent read GetOnError write SetOnError;
  end;

implementation

(* TACBrTXT *)

procedure TACBrTXT.Check(Condicao: Boolean; const Msg: AnsiString);
begin
  if not Condicao then AssignError(Msg);
end;

procedure TACBrTXT.Check(Condicao: Boolean; Msg: AnsiString; Fmt: array of const);
begin
  Check(Condicao, Format(Msg, Fmt));
end;

constructor TACBrTXT.Create(AOwner: TComponent);
begin
  inherited;
  FDelimitador := '|';
  FTrimString  := true;
  FCurMascara  := '#0.00';
end;

destructor TACBrTXT.Destroy;
begin

  inherited;
end;

function TACBrTXT.RFill(Value: AnsiString; Size: Integer = 0; Caracter: Char = ' '): AnsiString;
begin
  /// Se a propriedade TrimString = true, Result retorna sem espaços em branco
  /// iniciais e finais.
  if FTrimString then
     Result := Trim(Result);

  if (Size > 0) and (Length(Value) > Size) then
     Result := Copy(Value, 1, Size)
  else
     Result := Value + StringOfChar(Caracter, Size - Length(Value));

  Result := FDelimitador + Result;
end;

function TACBrTXT.LFill(Value: AnsiString; Size: Integer = 0; Caracter: Char = '0'): AnsiString;
begin
  /// Se a propriedade TrimString = true, Result retorna sem espaços em branco
  /// iniciais e finais.
  if FTrimString then
     Result := Trim(Result);

  if (Size > 0) and (Length(Value) > Size) then
     Result := Copy(Value, 1, Size)
  else
     Result := StringOfChar(Caracter, Size - length(Value)) + Value;

  Result := FDelimitador + Result;
end;

function TACBrTXT.LFill(Value: Currency; Size: Integer; Decimal: Integer = 2; Nulo: Boolean = false; Caracter: Char = '0'): AnsiString;
var
intFor, intP: Integer;
begin
  /// Se o parametro Nulo = true e Value = 0, será retornado '|'
  if (Nulo) and (Value = 0) then
  begin
     Result := FDelimitador;
     Exit;
  end;
  intP := 1;
  for intFor := 1 to Decimal do
  begin
     intP := intP * 10;
  end;
  /// Se a propriedade CurMascara <> '' Value será formatado com a mascara
  /// existente nessa propriedade.
  if FCurMascara <> '' then
     Result := FDelimitador + FormatCurr(FCurMascara, Value)
  else
     Result := LFill(Trunc(Value * intP), Size, Nulo, Caracter);
end;

function TACBrTXT.LFill(Value: Integer; Size: Integer; Nulo: Boolean = false; Caracter: Char = '0'): AnsiString;
begin
  /// Se o parametro Nulo = true e Value = 0, será retornado '|'
  if (Nulo) and (Value = 0) then
  begin
     Result := FDelimitador;
     Exit;
  end;
  Result := LFill(IntToStr(Value), Size, Caracter);
end;

function TACBrTXT.LFill(Value: TDateTime; Mask: AnsiString = 'ddmmyyyy'; Nulo: Boolean = false): AnsiString;
begin
  /// Se o parametro Nulo = true e Value = 0, será retornado '|'
  if (Nulo) and (Value = 0) then
  begin
     Result := FDelimitador;
     Exit;
  end;
  Result := FDelimitador + FormatDateTime(Mask, Value);
end;

function TACBrTXT.GetCurMascara: AnsiString;
begin
   Result := FCurMascara;
end;

function TACBrTXT.GetDelimitador: AnsiString;
begin
   Result := FDelimitador;
end;

function TACBrTXT.GetOnError: TErrorEvent;
begin
  Result := FOnError;
end;

function TACBrTXT.GetTrimString: boolean;
begin
  Result := FTrimString;
end;

procedure TACBrTXT.SetCurMascara(const Value: AnsiString);
begin
   FCurMascara := Value;
end;

procedure TACBrTXT.SetDelimitador(const Value: AnsiString);
begin
   FDelimitador := Value;
end;

procedure TACBrTXT.SetOnError(const Value: TErrorEvent);
begin
  FOnError := Value;
end;

procedure TACBrTXT.SetTrimString(const Value: boolean);
begin
  FTrimString := Value;
end;

procedure TACBrTXT.AssignError(MsnError: AnsiString);
begin
  if Assigned(FOnError) then FOnError(MsnError);
end;

end.
