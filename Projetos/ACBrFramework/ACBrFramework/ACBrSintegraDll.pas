unit ACBrSintegraDll;


interface

uses
  Classes,
  SysUtils,
  ACBrSintegra,
  ACBrUtil;

{Classe que armazena os EventHandlers para o componente ACBr}
type TEventHandlers = class

end;

{Handle para o componente TACBrSintegra }
type TSintegraHandle = record
  UltimoErro : String;
  Sintegra : TACBrSintegra;
  EventHandlers : TEventHandlers;
end;

{ Registro }
type TRegistro10Rec = record
  CNPJ                : array[0..14] of char;
  Inscricao           : array[0..14] of char;
  RazaoSocial         : array[0..35] of char;
  Cidade              : array[0..30] of char;
  Estado              : array[0..2] of char;
  Telefone            : array[0..10] of char;
  DataInicial         : Double;
  DataFinal           : Double;
  CodigoConvenio      : Integer;
  NaturezaInformacoes : Integer;
  FinalidadeArquivo   : Integer;
end;

type TRegistro11Rec = record
  Responsavel : array[0..28] of char;
  Bairro      : array[0..15] of char;
  Cep         : array[0..8] of char;
  Numero      : array[0..5] of char;
  Complemento : array[0..22] of char;
  Endereco    : array[0..34] of char;
  Telefone    : array[0..12] of char;
end;

type TRegistro50Rec = record
  CPFCNPJ          : array[0..14] of char;
  Inscricao        : array[0..14] of char;
  UF               : array[0..2] of char;
  Situacao         : array[0..1] of char;
  Aliquota         : Double;
  Isentas          : Double;
  Icms             : Double;
  ValorContabil    : Double;
  BasedeCalculo    : Double;
  Outras           : Double;
  EmissorDocumento : array[0..1] of char;
  Cfop             : array[0..4] of char;
  Serie            : array[0..3] of char;
  Modelo           : array[0..2] of char;
  Numero           : array[0..6] of char;
  DataDocumento    : Double;
end;

type TRegistro51Rec = record
  CPFCNPJ       : array[0..14] of char;
  Inscricao     : array[0..14] of char;
  Estado        : array[0..2] of char;
  ValorIpi      : Double;
  ValorContabil : Double;
  Serie         : array[0..3] of char;
  DataDocumento : Double;
  Cfop          : array[0..4] of char;
  Numero        : array[0..6] of char;
  Situacao      : array[0..1] of char;
  ValorIsentas  : Double;
  ValorOutras   : Double;
end;

{Ponteiro para o Handle }
type PSINHandle = ^TSintegraHandle;

implementation

{
PADRONIZAÇÃO DAS FUNÇÕES:

        PARÂMETROS:
        Todas as funções recebem o parâmetro "handle" que é o ponteiro
        para o componente instanciado; Este ponteiro deve ser armazenado
        pela aplicação que utiliza a DLL;

        RETORNO:
        Todas as funções da biblioteca retornam um Integer com as possíveis Respostas:

                MAIOR OU IGUAL A ZERO: SUCESSO
                Outos retornos maior que zero indicam sucesso, com valor específico de cada função.

                MENOR QUE ZERO: ERROS

                  -1 : Erro ao executar;
                       Vide UltimoErro

                  -2 : ACBr não inicializado.

                  Outros retornos negativos indicam erro específico de cada função;

                  A função "UltimoErro" retornará a mensagem da última exception disparada pelo componente.
}

{
CRIA um novo componente TACBrSintegra retornando o ponteiro para o objeto criado.
Este ponteiro deve ser armazenado pela aplicação que utiliza a DLL e informado
em todas as chamadas de função relativas ao TACBrPAF.
}
Function SIN_Create(var sinHandle: PSINHandle): Integer; {$IFDEF STDCALL} stdcall; {$ENDIF} {$IFDEF CDECL} cdecl; {$ENDIF}  export;
begin

  try

     New(sinHandle);
     sinHandle^.Sintegra := TACBrSintegra.Create(nil);
     sinHandle^.EventHandlers := TEventHandlers.Create();
     sinHandle^.UltimoErro:= '';
     Result := 0;
  except
     on exception : Exception do
     begin
        Result := -1;
        sinHandle^.UltimoErro := exception.Message;
     end
  end;

end;

{
DESTRÓI o objeto TACBrSintegra e libera a memória utilizada.
Esta função deve SEMPRE ser chamada pela aplicação que utiliza a DLL
quando o componente não mais for utilizado.
}
Function SIN_Destroy(var sinHandle: PSINHandle): Integer; {$IFDEF STDCALL} stdcall; {$ENDIF} {$IFDEF CDECL} cdecl; {$ENDIF}  export;
begin

  if (sinHandle = nil) then
  begin
     Result := -2;
     Exit;
  end;

  try

    sinHandle^.Sintegra.Destroy();
    sinHandle^.Sintegra := nil;

    Dispose(sinHandle);
    sinHandle := nil;
    Result := 0;

  except
     on exception : Exception do
     begin
        Result := -1;
        sinHandle^.UltimoErro := exception.Message;
     end
  end;

end;

Function SIN_GetUltimoErro(const sinHandle: PSINHandle; Buffer : pChar; const BufferLen : Integer) : Integer ; {$IFDEF STDCALL} stdcall; {$ENDIF} {$IFDEF CDECL} cdecl; {$ENDIF} export;
begin

  try
     StrPLCopy(Buffer, sinHandle^.UltimoErro, BufferLen);
     Result := length(sinHandle^.UltimoErro);
  except
     on exception : Exception do
     begin
        sinHandle^.UltimoErro := exception.Message;
        Result := -1;
     end
  end;
end;

{ Funções mapeando as propriedades do componente }
Function SIN_GetFileName(const sinHandle: PSINHandle; Buffer : pChar; const BufferLen : Integer) : Integer ; {$IFDEF STDCALL} stdcall; {$ENDIF} {$IFDEF CDECL} cdecl; {$ENDIF} export;
var
  StrTmp : String;
begin

  if (sinHandle = nil) then
  begin
     Result := -2;
     Exit;
  end;

 try
     StrTmp := sinHandle^.Sintegra.FileName;
     StrPLCopy(Buffer, StrTmp, BufferLen);
     Result := length(StrTmp);
  except
     on exception : Exception do
     begin
        sinHandle^.UltimoErro := exception.Message;
        Result := -1;
     end
  end;

end;

Function SIN_SetFileName(const sinHandle: PSINHandle; const FileN : pChar) : Integer; {$IFDEF STDCALL} stdcall; {$ENDIF} {$IFDEF CDECL} cdecl; {$ENDIF}  export;
begin

  if (sinHandle = nil) then
  begin
     Result := -2;
     Exit;
  end;

  try
     sinHandle^.Sintegra.FileName := FileN;
     Result := 0;
  except
     on exception : Exception do
     begin
        sinHandle^.UltimoErro := exception.Message;
        Result := -1;
     end
  end;

end;

Function SIN_GetVersaoValidador(const sinHandle: PSINHandle) : Integer ; {$IFDEF STDCALL} stdcall; {$ENDIF} {$IFDEF CDECL} cdecl; {$ENDIF} export;
begin

  if (sinHandle = nil) then
  begin
     Result := -2;
     Exit;
  end;

 try
     Result := Integer(sinHandle^.Sintegra.VersaoValidador);
  except
     on exception : Exception do
     begin
        sinHandle^.UltimoErro := exception.Message;
        Result := -1;
     end
  end;
end;

Function SIN_SetVersaoValidador(const sinHandle: PSINHandle; const Versao : Integer) : Integer; {$IFDEF STDCALL} stdcall; {$ENDIF} {$IFDEF CDECL} cdecl; {$ENDIF}  export;
begin
  if (sinHandle = nil) then
  begin
     Result := -2;
     Exit;
  end;

  try
     sinHandle^.Sintegra.VersaoValidador  := TVersaoValidador(Versao);
     Result := 0;
  except
     on exception : Exception do
     begin
        sinHandle^.UltimoErro := exception.Message;
        Result := -1;
     end
  end;
end;

Function SIN_GetAtivo(const sinHandle: PSINHandle) : Integer; {$IFDEF STDCALL} stdcall; {$ENDIF} {$IFDEF CDECL} cdecl; {$ENDIF}  export;
begin

  if (sinHandle = nil) then
  begin
     Result := -2;
     Exit;
  end;

  try
     if (sinHandle^.Sintegra.Ativo) then
        Result := 1
     else
        Result := 0;
  except
     on exception : Exception do
     begin
        sinHandle^.UltimoErro := exception.Message;
        Result := -1;
     end
  end;

end;

{ FUnções do Componente}
function SIN_LimparRegistros(const sinHandle: PSINHandle): Integer; {$IFDEF STDCALL} stdcall; {$ENDIF} {$IFDEF CDECL} cdecl; {$ENDIF}  export;
begin
  if (sinHandle = nil) then
    begin
       Result := -2;
       Exit;
    end;
try
  sinHandle^.Sintegra.LimparRegistros;
except
   on exception : Exception do
   begin
      sinHandle^.UltimoErro := exception.Message;
      Result := -1;
   end
end;
end;

function SIN_Registro10(const sinHandle: PSINHandle; const Registro10Rec : TRegistro10Rec): Integer; {$IFDEF STDCALL} stdcall; {$ENDIF} {$IFDEF CDECL} cdecl; {$ENDIF}  export;
begin
  if (sinHandle = nil) then
    begin
       Result := -2;
       Exit;
    end;
try
  if sinHandle^.Sintegra.Ativo then
  begin
    with sinHandle^.Sintegra.Registro10 do
    begin
      CNPJ                := Registro10Rec.CNPJ;
      Inscricao           := Registro10Rec.Inscricao;
      RazaoSocial         := Registro10Rec.RazaoSocial;
      Cidade              := Registro10Rec.Cidade;
      Estado              := Registro10Rec.Estado;
      Telefone            := Registro10Rec.Telefone;
      DataInicial         := Registro10Rec.DataInicial;
      DataFinal           := Registro10Rec.DataFinal;
      CodigoConvenio      := IntToStr(Registro10Rec.CodigoConvenio);
      NaturezaInformacoes := IntToStr(Registro10Rec.NaturezaInformacoes);
      FinalidadeArquivo   := IntToStr(Registro10Rec.FinalidadeArquivo);
    end;
    Result := 0;
    end;
except
   on exception : Exception do
   begin
      sinHandle^.UltimoErro := exception.Message;
      Result := -1;
   end
end;
end;

function SIN_Registro11(const sinHandle: PSINHandle; const Registro11Rec : TRegistro11Rec): Integer; {$IFDEF STDCALL} stdcall; {$ENDIF} {$IFDEF CDECL} cdecl; {$ENDIF}  export;
begin
  if (sinHandle = nil) then
    begin
       Result := -2;
       Exit;
    end;
try
  if sinHandle^.Sintegra.Ativo then
  begin
    with sinHandle^.Sintegra.Registro11 do
    begin
      Responsavel := Registro11Rec.Responsavel;
      Bairro      := Registro11Rec.Bairro;
      Cep         := Registro11Rec.Cep;
      Numero      := Registro11Rec.Numero;
      Complemento := Registro11Rec.Complemento;
      Endereco    := Registro11Rec.Endereco;
      Telefone    := Registro11Rec.Telefone;
    end;
    Result := 0;
  end;
except
   on exception : Exception do
   begin
      sinHandle^.UltimoErro := exception.Message;
      Result := -1;
   end
end;
end;

function SIN_Registro50(const sinHandle: PSINHandle; const Registro50Rec : array of TRegistro50Rec; const Count : Integer): Integer; {$IFDEF STDCALL} stdcall; {$ENDIF} {$IFDEF CDECL} cdecl; {$ENDIF}  export;
var
  registro50: TRegistro50;
  i : Integer;
begin
  if (sinHandle = nil) then
    begin
       Result := -2;
       Exit;
    end;
try
  if sinHandle^.Sintegra.Ativo then
  begin
    for i := 0 to Count - 1 do
    begin
    with sinHandle^.Sintegra do
    begin
      registro50                  := TRegistro50.Create;
      registro50.CPFCNPJ          := Registro50Rec[i].CPFCNPJ;
      registro50.Inscricao        := Registro50Rec[i].Inscricao;
      registro50.DataDocumento    := Registro50Rec[i].DataDocumento;
      registro50.UF               := Registro50Rec[i].UF;
      registro50.Modelo           := Registro50Rec[i].Modelo;
      registro50.Serie            := Registro50Rec[i].Serie;
      registro50.Numero           := Registro50Rec[i].Numero;
      registro50.Cfop             := Registro50Rec[i].Cfop;
      registro50.EmissorDocumento := Registro50Rec[i].EmissorDocumento;
      registro50.ValorContabil    := Registro50Rec[i].ValorContabil;
      registro50.BasedeCalculo    := Registro50Rec[i].BasedeCalculo;
      registro50.Icms             := Registro50Rec[i].Icms;
      registro50.Isentas          := Registro50Rec[i].Isentas;
      registro50.Outras           := Registro50Rec[i].Outras;
      registro50.Aliquota         := Registro50Rec[i].Aliquota;
      registro50.Situacao         := Registro50Rec[i].Situacao;
      Registros50.Add(registro50);
    end;
    end;
  end;
  Result := 0;
except
   on exception : Exception do
   begin
      sinHandle^.UltimoErro := exception.Message;
      Result := -1;
   end
end;
end;

function SIN_Registro51(const sinHandle: PSINHandle; const Registro51Rec : array of TRegistro51Rec; const Count : Integer): Integer; {$IFDEF STDCALL} stdcall; {$ENDIF} {$IFDEF CDECL} cdecl; {$ENDIF}  export;
var
  registro51: TRegistro51;
  i : Integer;
begin
  if (sinHandle = nil) then
    begin
       Result := -2;
       Exit;
    end;
try
  if sinHandle^.Sintegra.Ativo then
  begin
    for i := 0 to Count - 1 do
    begin
    with sinHandle^.Sintegra do
    begin
      registro51               := TRegistro51.Create;
      registro51.CPFCNPJ       := Registro51Rec[i].CPFCNPJ;
      registro51.Inscricao     := Registro51Rec[i].Inscricao;
      registro51.DataDocumento := Registro51Rec[i].DataDocumento;
      registro51.Estado        := Registro51Rec[i].Estado;
      registro51.Serie         := Registro51Rec[i].Serie;
      registro51.Numero        := Registro51Rec[i].Numero;
      registro51.Cfop          := Registro51Rec[i].Cfop;
      registro51.ValorContabil := Registro51Rec[i].ValorContabil;
      registro51.ValorIpi      := Registro51Rec[i].ValorIpi;
      registro51.ValorOutras   := Registro51Rec[i].ValorOutras;
      registro51.ValorIsentas  := Registro51Rec[i].ValorIsentas;
      registro51.Situacao      := Registro51Rec[i].Situacao;
      Registros51.Add(registro51);
    end;
    end;
  end;
  Result := 0;
except
   on exception : Exception do
   begin
      sinHandle^.UltimoErro := exception.Message;
      Result := -1;
   end
end;
end;

exports
{ Funções }
SIN_Create,
SIN_Destroy,
SIN_GetUltimoErro,

{ Funções mapeando as propriedades do componente }
SIN_GetFileName, SIN_SetFileName,
SIN_GetVersaoValidador, SIN_SetVersaoValidador,
SIN_GetAtivo,
{ Funções do componente }
SIN_LimparRegistros,

{ Registros }
SIN_Registro10, SIN_Registro11,
SIN_Registro50, SIN_Registro51;
end.

