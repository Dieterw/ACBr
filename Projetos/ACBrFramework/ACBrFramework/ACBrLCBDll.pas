unit ACBrLCBDll;

interface

uses
  SysUtils,
  Classes,
  ACBrLCB;

{Handle para o componente TACBrLCB }
type TLCBHandle = record
  UltimoErro : String;
  LCB : TACBrLCB;
end;

{Ponteiro para o Handle}
type PLCBHandle = ^TLCBHandle;

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
CRIA um novo componente TACBrLCB retornando o ponteiro para o objeto criado.
Este ponteiro deve ser armazenado pela aplicação que utiliza a DLL e informado
em todas as chamadas de função relativas ao TACBrLCB
}
Function LCB_Create(var lcbHandle: PLCBHandle): Integer; {$IFDEF STDCALL} stdcall; {$ENDIF} {$IFDEF CDECL} cdecl; {$ENDIF} export;
begin

  try

     New(lcbHandle);

     lcbHandle^.LCB := TACBrLCB.Create(nil);
     lcbHandle^.UltimoErro := '';

     Result := 0;

  except
     on exception : Exception do
     begin
        Result := -1;
        lcbHandle^.UltimoErro := exception.Message;
     end
  end;

end;

{
DESTRÓI o objeto TACBrLCB e libera a memória utilizada.
Esta função deve SEMPRE ser chamada pela aplicação que utiliza a DLL
quando o componente não mais for utilizado.
}
Function LCB_Destroy(var lcbHandle: PLCBHandle): Integer; {$IFDEF STDCALL} stdcall; {$ENDIF} {$IFDEF CDECL} cdecl; {$ENDIF} export;
begin

  try

     if (lcbHandle = nil) then
     begin
        Result := -2;
        Exit;
     end;

     lcbHandle^.LCB.Destroy();
     lcbHandle^.LCB := nil;

     Dispose(lcbHandle);
     lcbHandle := nil;
     Result := 0;

  except
     on exception : Exception do
     begin
        Result := -1;
        lcbHandle^.UltimoErro := exception.Message;
     end
  end;

end;

Function LCB_GetUltimoErro(const lcbHandle: PLCBHandle; Buffer : pChar; const BufferLen : Integer) : Integer ; {$IFDEF STDCALL} stdcall; {$ENDIF} {$IFDEF CDECL} cdecl; {$ENDIF} export;
begin

  if (lcbHandle = nil) then
  begin
     Result := -2;
     Exit;
  end;

  try
     StrPLCopy(Buffer, lcbHandle^.UltimoErro, BufferLen);
     Result := length(lcbHandle^.UltimoErro);
  except
     on exception : Exception do
     begin
        lcbHandle^.UltimoErro := exception.Message;
        Result  := -1;
     end
  end;
end;


Function LCB_Ativar(const lcbHandle: PLCBHandle) : Integer; {$IFDEF STDCALL} stdcall; {$ENDIF} {$IFDEF CDECL} cdecl; {$ENDIF} export;
begin

  if (lcbHandle = nil) then
  begin
     Result := -2;
     Exit;
  end;

  try
     lcbHandle^.LCB.Ativar;
     Result := 0;
  except
     on exception : Exception do
     begin
        lcbHandle^.UltimoErro := exception.Message;
        Result := -1;
     end
  end;

end;

Function LCB_Desativar(const lcbHandle: PLCBHandle) : Integer; {$IFDEF STDCALL} stdcall; {$ENDIF} {$IFDEF CDECL} cdecl; {$ENDIF} export;
begin

  if (lcbHandle = nil) then
  begin
     Result := -2;
     Exit;
  end;

  try
     lcbHandle^.LCB.Desativar;
     Result := 0;
  except
     on exception : Exception do
     begin
        lcbHandle^.UltimoErro := exception.Message;
        Result  := -1;
     end
  end;

end;

Function LCB_GetPorta(const lcbHandle: PLCBHandle; Buffer : pChar; const BufferLen : Integer) : Integer ; {$IFDEF STDCALL} stdcall; {$ENDIF} {$IFDEF CDECL} cdecl; {$ENDIF} export;
var
  StrTmp : String;
begin

  if (lcbHandle = nil) then
  begin
     Result := -2;
     Exit;
  end;

 try
     StrTmp := lcbHandle^.LCB.Porta;
     StrPLCopy(Buffer, StrTmp, BufferLen);
     Result := length(StrTmp);
  except
     on exception : Exception do
     begin
        lcbHandle^.UltimoErro := exception.Message;
        Result := -1;
     end
  end;

end;

Function LCB_SetPorta(const lcbHandle: PLCBHandle; const Porta : pChar) : Integer; {$IFDEF STDCALL} stdcall; {$ENDIF} {$IFDEF CDECL} cdecl; {$ENDIF} export;
begin

  if (lcbHandle = nil) then
  begin
     Result := -2;
     Exit;
  end;

  try
     lcbHandle^.LCB.Porta := Porta;
     Result := 0;
  except
     on exception : Exception do
     begin
        lcbHandle^.UltimoErro := exception.Message;
        Result := -1;
     end
  end;

end;

Function LCB_GetAtivo(const lcbHandle: PLCBHandle) : Integer; {$IFDEF STDCALL} stdcall; {$ENDIF} {$IFDEF CDECL} cdecl; {$ENDIF} export;
begin

  if (lcbHandle = nil) then
  begin
     Result := -2;
     Exit;
  end;

  try
     if (lcbHandle^.LCB.Ativo) then
        Result := 1
     else
        Result := 0;
  except
     on exception : Exception do
     begin
        lcbHandle^.UltimoErro := exception.Message;
        Result := -1;
     end
  end;

end;

Function LCB_SetOnLeCodigo(const lcbHandle: PLCBHandle; const method : TNotifyEvent) : Integer; {$IFDEF STDCALL} stdcall; {$ENDIF} {$IFDEF CDECL} cdecl; {$ENDIF} export;
begin

  if (lcbHandle = nil) then
  begin
     Result := -2;
     Exit;
  end;

  try
        lcbHandle^.LCB.OnLeCodigo := method;
        Result := 0;
  except
     on exception : Exception do
     begin
        lcbHandle^.UltimoErro := exception.Message;
        Result := -1;
     end
  end;

end;

exports

{ Funções }

LCB_Create, LCB_Destroy,
LCB_GetUltimoErro,
LCB_Ativar, LCB_Desativar,

{ Propriedades do Componente }

LCB_GetAtivo, LCB_SetOnLeCodigo;


end.
