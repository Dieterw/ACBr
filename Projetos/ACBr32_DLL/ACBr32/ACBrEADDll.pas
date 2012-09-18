unit ACBrEADDll;

interface

uses
  SysUtils,
  Classes,
  ACBrEAD,
  ACBrUtil;

{Classe que armazena os EventHandlers para o componente ACBr}
type TEventHandlers = class

end;

{Handle para o componente TACBrECF }
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
CRIA um novo componente TACBrPAF retornando o ponteiro para o objeto criado.
Este ponteiro deve ser armazenado pela aplicação que utiliza a DLL e informado
em todas as chamadas de função relativas ao TACBrPAF.
}
Function EAD_Create(var eadHandle: PEADHandle): Integer; {$IFDEF STDCALL} stdcall; {$ENDIF} {$IFDEF CDECL} cdecl; {$ENDIF}  export;
begin

  try

     New(eadHandle);
     eadHandle^.EAD := TACBrEAD.Create(nil);
     eadHandle^.EventHandlers := TEventHandlers.Create();
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
DESTRÓI o objeto TACBrPAF e libera a memória utilizada.
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

exports

{ Funções }
EAD_Create,
EAD_Destroy,
EAD_GetUltimoErro,

{Chaves}
EAD_GerarChaves;

end.
