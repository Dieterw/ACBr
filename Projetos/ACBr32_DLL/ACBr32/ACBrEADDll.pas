unit ACBrEADDll;

interface

uses
  SysUtils,
  Classes,
  ACBrEAD,
  ACBrUtil;

{Classe que armazena os EventHandlers para o componente ACBr}
type TEventHandlers = class
   procedure GetChavePrivada(var Chave : AnsiString);
   procedure GetChavePublica(var Chave : AnsiString);
end;

{Handle para o componente TACBrEAD }
type TEADHandle = record
  UltimoErro : String;
  EAD : TACBrEAD;
  EventHandlers : TEventHandlers;
end;

{Ponteiro para o Handle }
type PEADHandle = ^TEADHandle;


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
CRIA um novo componente TACBrEAD retornando o ponteiro para o objeto criado.
Este ponteiro deve ser armazenado pela aplicação que utiliza a DLL e informado
em todas as chamadas de função relativas ao TACBrPAF.
}
Function EAD_Create(var eadHandle: PEADHandle): Integer; {$IFDEF STDCALL} stdcall; {$ENDIF} {$IFDEF CDECL} cdecl; {$ENDIF}  export;
begin

  try

     New(eadHandle);
     eadHandle^.EAD := TACBrEAD.Create(nil);
     eadHandle^.EventHandlers := TEventHandlers.Create();
     eadHandle^.EAD.OnGetChavePrivada := eadHandle^.EventHandlers.GetChavePrivada;
     eadHandle^.EAD.OnGetChavePublica := eadHandle^.EventHandlers.GetChavePublica;
     eadHandle^.UltimoErro:= '';
     Result := 0;
  except
     on exception : Exception do
     begin
        Result := -1;
        eadHandle^.UltimoErro := exception.Message;
     end
  end;

end;

{
DESTRÓI o objeto TACBrEAD e libera a memória utilizada.
Esta função deve SEMPRE ser chamada pela aplicação que utiliza a DLL
quando o componente não mais for utilizado.
}
Function EAD_Destroy(var eadHandle: PEADHandle): Integer; {$IFDEF STDCALL} stdcall; {$ENDIF} {$IFDEF CDECL} cdecl; {$ENDIF}  export;
begin

  if (eadHandle = nil) then
  begin
     Result := -2;
     Exit;
  end;

  try

    eadHandle^.EAD.Destroy();
    eadHandle^.EAD := nil;

    Dispose(eadHandle);
    eadHandle := nil;
    Result := 0;

  except
     on exception : Exception do
     begin
        Result := -1;
        eadHandle^.UltimoErro := exception.Message;
     end
  end;

end;

Function EAD_GetUltimoErro(const eadHandle: PEADHandle; Buffer : pChar; const BufferLen : Integer) : Integer ; {$IFDEF STDCALL} stdcall; {$ENDIF} {$IFDEF CDECL} cdecl; {$ENDIF} export;
begin

  try
     StrPLCopy(Buffer, eadHandle^.UltimoErro, BufferLen);
     Result := length(eadHandle^.UltimoErro);
  except
     on exception : Exception do
     begin
        eadHandle^.UltimoErro := exception.Message;
        Result := -1;
     end
  end;
end;

{Procedures}
procedure TEventHandlers.GetChavePrivada(var Chave : AnsiString);
begin
  //
end;

procedure TEventHandlers.GetChavePublica(var Chave : AnsiString);
begin
  //
end;

{Propriedades}

{Funções}
function EAD_GerarChaves(const eadHandle: PEADHandle; ChavePUB, ChavePRI : pChar; const BufferLen : Integer): Integer; {$IFDEF STDCALL} stdcall; {$ENDIF} {$IFDEF CDECL} cdecl; {$ENDIF}  export;
var
  ChavePublica, ChavePrivada : AnsiString ;
begin
  try
     if (eadHandle = nil) then
     begin
     Result := -2;
     Exit;
     end;

     ChavePrivada := '' ;
     ChavePublica := '' ;
     eadHandle^.EAD.GerarChaves( ChavePublica, ChavePrivada );
     ChavePublica := StringReplace( ChavePublica, #10, sLineBreak, [rfReplaceAll] );
     ChavePrivada := StringReplace( ChavePrivada, #10, sLineBreak, [rfReplaceAll] );

     StrPLCopy(ChavePUB, ChavePublica, BufferLen);
     StrPLCopy(ChavePRI, ChavePrivada, BufferLen);
     Result := 1;
  except
     on exception : Exception do
     begin
        eadHandle^.UltimoErro := exception.Message;
        Result := -1;
     end
  end
end;

function EAD_CalcularModuloeExpoente(const eadHandle: PEADHandle; ModuloBuffer, ExpoenteBuffer: pChar; const BufferLen : Integer): Integer; {$IFDEF STDCALL} stdcall; {$ENDIF} {$IFDEF CDECL} cdecl; {$ENDIF}  export;
var
  Modulo, Expoente : AnsiString ;
begin
  try
     if (eadHandle = nil) then
     begin
     Result := -2;
     Exit;
     end;

     Modulo := '' ;
     Expoente := '' ;
     eadHandle^.EAD.CalcularModuloeExpoente(Modulo, Expoente);

     StrPLCopy(ModuloBuffer, Modulo, BufferLen);
     StrPLCopy(ExpoenteBuffer, Expoente, BufferLen);
     Result := 1;
  except
     on exception : Exception do
     begin
        eadHandle^.UltimoErro := exception.Message;
        Result := -1;
     end
  end
end;

function EAD_GerarXMLeECFc(const eadHandle: PEADHandle;const NomeSH, PathArquivo: pChar): Integer; {$IFDEF STDCALL} stdcall; {$ENDIF} {$IFDEF CDECL} cdecl; {$ENDIF}  export;
begin
  try
     if (eadHandle = nil) then
     begin
     Result := -2;
     Exit;
     end;

     eadHandle^.EAD.GerarXMLeECFc(NomeSH, PathArquivo);
     Result := 1;
  except
     on exception : Exception do
     begin
        eadHandle^.UltimoErro := exception.Message;
        Result := -1;
     end
  end
end;

function EAD_GerarXMLeECFc_NP(const eadHandle: PEADHandle;const NomeSH: pChar): Integer; {$IFDEF STDCALL} stdcall; {$ENDIF} {$IFDEF CDECL} cdecl; {$ENDIF}  export;
begin
  try
     if (eadHandle = nil) then
     begin
     Result := -2;
     Exit;
     end;

     eadHandle^.EAD.GerarXMLeECFc(NomeSH);
     Result := 1;
  except
     on exception : Exception do
     begin
        eadHandle^.UltimoErro := exception.Message;
        Result := -1;
     end
  end
end;

function EAD_ConverteXMLeECFcParaOpenSSL(const eadHandle: PEADHandle;const Arquivo: pChar): Integer; {$IFDEF STDCALL} stdcall; {$ENDIF} {$IFDEF CDECL} cdecl; {$ENDIF}  export;
begin
  try
     if (eadHandle = nil) then
     begin
     Result := -2;
     Exit;
     end;

     eadHandle^.EAD.ConverteXMLeECFcParaOpenSSL(Arquivo);
     Result := 1;
  except
     on exception : Exception do
     begin
        eadHandle^.UltimoErro := exception.Message;
        Result := -1;
     end
  end
end;

function EAD_CalcularHashArquivo(const eadHandle: PEADHandle;const Arquivo: pChar; const Hash: Integer): Integer; {$IFDEF STDCALL} stdcall; {$ENDIF} {$IFDEF CDECL} cdecl; {$ENDIF}  export;
begin
  try
     if (eadHandle = nil) then
     begin
     Result := -2;
     Exit;
     end;

     eadHandle^.EAD.CalcularHashArquivo(Arquivo, TACBrEADDgst(Hash));
     Result := 1;
  except
     on exception : Exception do
     begin
        eadHandle^.UltimoErro := exception.Message;
        Result := -1;
     end
  end
end;

function EAD_CalcularEADArquivo(const eadHandle: PEADHandle;const Arquivo: pChar): Integer; {$IFDEF STDCALL} stdcall; {$ENDIF} {$IFDEF CDECL} cdecl; {$ENDIF}  export;
begin
  try
     if (eadHandle = nil) then
     begin
     Result := -2;
     Exit;
     end;

     eadHandle^.EAD.CalcularEADArquivo(Arquivo);
     Result := 1;
  except
     on exception : Exception do
     begin
        eadHandle^.UltimoErro := exception.Message;
        Result := -1;
     end
  end
end;

function EAD_AssinarArquivoComEAD(const eadHandle: PEADHandle;const Arquivo: pChar; const Remove:Boolean): Integer; {$IFDEF STDCALL} stdcall; {$ENDIF} {$IFDEF CDECL} cdecl; {$ENDIF}  export;
begin
  try
     if (eadHandle = nil) then
     begin
     Result := -2;
     Exit;
     end;

     eadHandle^.EAD.AssinarArquivoComEAD(Arquivo, Remove);
     Result := 1;
  except
     on exception : Exception do
     begin
        eadHandle^.UltimoErro := exception.Message;
        Result := -1;
     end
  end
end;

function EAD_VerificarEADArquivo(const eadHandle: PEADHandle;const Arquivo: pChar): Integer; {$IFDEF STDCALL} stdcall; {$ENDIF} {$IFDEF CDECL} cdecl; {$ENDIF}  export;
begin
  try
     if (eadHandle = nil) then
     begin
     Result := -2;
     Exit;
     end;

     if (eadHandle^.EAD.VerificarEADArquivo(Arquivo))then
       Result := 1
     else
       Result := 0;

  except
     on exception : Exception do
     begin
        eadHandle^.UltimoErro := exception.Message;
        Result := -1;
     end
  end
end;

exports

{ Funções }
EAD_Create,
EAD_Destroy,
EAD_GetUltimoErro,

{Chaves}
EAD_GerarChaves, EAD_CalcularModuloeExpoente,
EAD_GerarXMLeECFc, EAD_GerarXMLeECFc_NP,
EAD_ConverteXMLeECFcParaOpenSSL,EAD_CalcularHashArquivo,
EAD_CalcularEADArquivo, EAD_AssinarArquivoComEAD,
EAD_VerificarEADArquivo;

end.
