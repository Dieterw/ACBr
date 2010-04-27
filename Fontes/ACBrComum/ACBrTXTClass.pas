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

unit ACBrTXTClass;

interface

uses SysUtils, Classes, DateUtils, Math;

type
  TErrorEvent = procedure(const MsnError: AnsiString) of object;

  { TACBrTXTClass }

  TACBrTXTClass = class
  private
    FOnError: TErrorEvent;
    FDelimitador: String;     /// Caracter delimitador de campos
    FTrimString: boolean;     /// Retorna a string sem espaços em branco iniciais e finais
    FCurMascara: String;      /// Mascara para valores tipo currency

    FConteudo : TStringList;

    procedure AssignError(MsnError: String);
  public
    constructor create ;
    destructor destroy ; override ;

    procedure SaveToFile( const AFileName : AnsiString ) ;
    procedure LoadFromFile( const AFileName : AnsiString ) ;
    Function Add( const AString : AnsiString; AddDelimiter : Boolean = True ) : Integer;

    function RFill(Value: String; Size: Integer = 0; Caracter: Char = ' '): String; overload;
    function LFill(Value: String; Size: Integer = 0; Caracter: Char = '0'): String; overload;
    function DFill(Value: Double;
                   Decimal: Integer = 2;
                   Nulo: Boolean = false): String;
    function LFill(Value: Currency;
                   Size: Integer;
                   Decimal: Integer = 2;
                   Nulo: Boolean = false;
                   Caracter: Char = '0'): String; overload;
    function LFill(Value: Integer; Size: Integer; Nulo: Boolean = false; Caracter: Char = '0'): String; overload;
    function LFill(Value: TDateTime; Mask: String = 'ddmmyyyy'): String; overload;
    ///
    procedure Check(Condicao: Boolean; const Msg: String); overload;
    procedure Check(Condicao: Boolean; Msg: String; Fmt: array of const); overload;
    ///
    property Delimitador: String read FDelimitador write FDelimitador;
    property TrimString: boolean read FTrimString write FTrimString;
    property CurMascara: String read FCurMascara write FCurMascara;
    property OnError: TErrorEvent read FOnError write FOnError;

    property Conteudo : TStringList read FConteudo ;
  end;

implementation

Uses ACBrUtil ;

(* TACBrTXTClass *)

constructor TACBrTXTClass.create;
begin
   FConteudo := TStringList.Create ;
end;

destructor TACBrTXTClass.destroy;
begin
  FConteudo.Free;

  inherited destroy;
end;

procedure TACBrTXTClass.SaveToFile(const AFileName: AnsiString);
begin
   FConteudo.SaveToFile(AFileName);
end;

procedure TACBrTXTClass.LoadFromFile(const AFileName: AnsiString);
begin
   FConteudo.LoadFromFile( AFileName );
end;

function TACBrTXTClass.Add(const AString: AnsiString; AddDelimiter: Boolean
   ): Integer;
Var
  S : AnsiString ;
begin
   S      := Trim( AString ) ;
   Result := -1 ;
   if S = '' then exit ;

   if AddDelimiter then
      S := S + Delimitador;

   Result := FConteudo.Add( S );
end;

procedure TACBrTXTClass.Check(Condicao: Boolean; const Msg: String);
begin
  if not Condicao then AssignError(Msg);
end;

procedure TACBrTXTClass.Check(Condicao: Boolean; Msg: String; Fmt: array of const);
begin
  Check(Condicao, Format(Msg, Fmt));
end;

function TACBrTXTClass.RFill(Value: String; Size: Integer = 0; Caracter: Char = ' '): String;
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

function TACBrTXTClass.LFill(Value: String; Size: Integer = 0; Caracter: Char = '0'): String;
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

function TACBrTXTClass.LFill(Value: Currency;
                        Size: Integer;
                        Decimal: Integer = 2;
                        Nulo: Boolean = false;
                        Caracter: Char = '0'): String;
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
  if FCurMascara <> '' then
     Result := FDelimitador + FormatCurr(FCurMascara, Value)
  else
     Result := LFill(Trunc(Value * intP), Size, Nulo, Caracter);
end;

function TACBrTXTClass.DFill(Value: Double;
                        Decimal: Integer = 2;
                        Nulo: Boolean = false): String;
begin
  /// Se o parametro Nulo = true e Value = 0, será retornado '|'
  if (Nulo) and (Value = 0) then
  begin
     Result := FDelimitador;
     Exit;
  end;
  Result := FDelimitador + CurrToStr(RoundTo(Value, -1 * Decimal));
end;

function TACBrTXTClass.LFill(Value: Integer; Size: Integer; Nulo: Boolean = false; Caracter: Char = '0'): String;
begin
  /// Se o parametro Nulo = true e Value = 0, será retornado '|'
  if (Nulo) and (Value = 0) then
  begin
     Result := FDelimitador;
     Exit;
  end;
  Result := LFill(IntToStr(Value), Size, Caracter);
end;

function TACBrTXTClass.LFill(Value: TDateTime; Mask: String = 'ddmmyyyy'): String;
begin
  /// Se o parametro Value = 0, será retornado '|'
  if (Value = 0) then
  begin
     Result := FDelimitador;
     Exit;
  end;
  Result := FDelimitador + FormatDateTime(Mask, Value);
end;

procedure TACBrTXTClass.AssignError(MsnError: String);
begin
  if Assigned(FOnError) then FOnError( ACBrStr(MsnError) );
end;

end.
