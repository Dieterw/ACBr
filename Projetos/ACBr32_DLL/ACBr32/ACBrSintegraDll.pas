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


exports
{ Funções }
SIN_Create,
SIN_Destroy,
SIN_GetUltimoErro;

end.

