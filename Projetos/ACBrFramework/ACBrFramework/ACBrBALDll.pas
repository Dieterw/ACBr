unit ACBrBALDll;

interface

uses
  SysUtils,
  Classes,
  ACBrBal;

{Handle para o componente TACBrBAL }
type TBALHandle = record
  UltimoErro : String;
  BAL : TACBrBAL;
end;

{Ponteiro para o Handle}
type PBALHandle = ^TBALHandle;

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
CRIA um novo componente TACBrBAL retornando o ponteiro para o objeto criado.
Este ponteiro deve ser armazenado pela aplicação que utiliza a DLL e informado
em todas as chamadas de função relativas ao TACBrBAL
}
Function BAL_Create(var balHandle: PBALHandle): Integer; {$IFDEF STDCALL} stdcall; {$ENDIF} {$IFDEF CDECL} cdecl; {$ENDIF} export;
begin

  try

     New(balHandle);

     balHandle^.BAL := TACBrBAL.Create(nil);
     balHandle^.BAL.MonitorarBalanca := False;
     balHandle^.UltimoErro := '';

     Result := 0;

  except
     on exception : Exception do
     begin
        Result := -1;
        balHandle^.UltimoErro := exception.Message;
     end
  end;

end;

{
DESTRÓI o objeto TACBrBAL e libera a memória utilizada.
Esta função deve SEMPRE ser chamada pela aplicação que utiliza a DLL
quando o componente não mais for utilizado.
}
Function BAL_Destroy(var balHandle: PBALHandle): Integer; {$IFDEF STDCALL} stdcall; {$ENDIF} {$IFDEF CDECL} cdecl; {$ENDIF} export;
begin

  try

     if (balHandle = nil) then
     begin
        Result := -2;
        Exit;
     end;

     balHandle^.BAL.Destroy();
     balHandle^.BAL := nil;

     Dispose(balHandle);
     balHandle := nil;
     Result := 0;

  except
     on exception : Exception do
     begin
        Result := -1;
        balHandle^.UltimoErro := exception.Message;
     end
  end;

end;

Function BAL_GetUltimoErro(const balHandle: PBALHandle; Buffer : pChar; const BufferLen : Integer) : Integer ; {$IFDEF STDCALL} stdcall; {$ENDIF} {$IFDEF CDECL} cdecl; {$ENDIF} export;
begin

  if (balHandle = nil) then
  begin
     Result := -2;
     Exit;
  end;

  try
     StrPLCopy(Buffer, balHandle^.UltimoErro, BufferLen);
     Result := length(balHandle^.UltimoErro);
  except
     on exception : Exception do
     begin
        balHandle^.UltimoErro := exception.Message;
        Result  := -1;
     end
  end;
end;


Function BAL_Ativar(const balHandle: PBALHandle) : Integer; {$IFDEF STDCALL} stdcall; {$ENDIF} {$IFDEF CDECL} cdecl; {$ENDIF} export;
begin

  if (balHandle = nil) then
  begin
     Result := -2;
     Exit;
  end;

  try
     balHandle^.BAL.Ativar;
     Result := 0;
  except
     on exception : Exception do
     begin
        balHandle^.UltimoErro := exception.Message;
        Result := -1;
     end
  end;

end;

Function BAL_Desativar(const balHandle: PBALHandle) : Integer; {$IFDEF STDCALL} stdcall; {$ENDIF} {$IFDEF CDECL} cdecl; {$ENDIF} export;
begin

  if (balHandle = nil) then
  begin
     Result := -2;
     Exit;
  end;

  try
     balHandle^.BAL.Desativar;
     Result := 0;
  except
     on exception : Exception do
     begin
        balHandle^.UltimoErro := exception.Message;
        Result  := -1;
     end
  end;

end;

Function BAL_GetModelo(const balHandle: PBALHandle) : Integer; {$IFDEF STDCALL} stdcall; {$ENDIF} {$IFDEF CDECL} cdecl; {$ENDIF} export;
begin

  if (balHandle = nil) then
  begin
     Result := -2;
     Exit;
  end;

  try
     Result := Integer(balHandle^.BAL.Modelo);
  except
     on exception : Exception do
     begin
        balHandle^.UltimoErro := exception.Message;
        Result := -1;
     end
  end;

end;

Function BAL_SetModelo(const balHandle: PBALHandle; const Modelo : Integer) : Integer; {$IFDEF STDCALL} stdcall; {$ENDIF} {$IFDEF CDECL} cdecl; {$ENDIF} export;
begin

  if (balHandle = nil) then
  begin
     Result := -2;
     Exit;
  end;

  try
     balHandle^.BAL.Modelo := TACBrBALModelo(Modelo);
     Result := 0;
  except
     on exception : Exception do
     begin
        balHandle^.UltimoErro := exception.Message;
        Result := -1;
     end
  end;

end;

Function BAL_GetModeloStr(const balHandle: PBALHandle; Buffer : pChar; const BufferLen : Integer) : Integer ; {$IFDEF STDCALL} stdcall; {$ENDIF} {$IFDEF CDECL} cdecl; {$ENDIF} export;
var
  StrTmp : String;
begin

  if (balHandle = nil) then
  begin
     Result := -2;
     Exit;
  end;

 try
     StrTmp := balHandle^.BAL.ModeloStr;
     StrPLCopy(Buffer, StrTmp, BufferLen);
     Result := length(StrTmp);
  except
     on exception : Exception do
     begin
        balHandle^.UltimoErro := exception.Message;
        Result := -1;
     end
  end;

end;

Function BAL_GetPorta(const balHandle: PBALHandle; Buffer : pChar; const BufferLen : Integer) : Integer ; {$IFDEF STDCALL} stdcall; {$ENDIF} {$IFDEF CDECL} cdecl; {$ENDIF} export;
var
  StrTmp : String;
begin

  if (balHandle = nil) then
  begin
     Result := -2;
     Exit;
  end;

 try
     StrTmp := balHandle^.BAL.Porta;
     StrPLCopy(Buffer, StrTmp, BufferLen);
     Result := length(StrTmp);
  except
     on exception : Exception do
     begin
        balHandle^.UltimoErro := exception.Message;
        Result := -1;
     end
  end;

end;

Function BAL_SetPorta(const balHandle: PBALHandle; const Porta : pChar) : Integer; {$IFDEF STDCALL} stdcall; {$ENDIF} {$IFDEF CDECL} cdecl; {$ENDIF} export;
begin

  if (balHandle = nil) then
  begin
     Result := -2;
     Exit;
  end;

  try
     balHandle^.BAL.Porta := Porta;
     Result := 0;
  except
     on exception : Exception do
     begin
        balHandle^.UltimoErro := exception.Message;
        Result := -1;
     end
  end;

end;

Function BAL_GetAtivo(const balHandle: PBALHandle) : Integer; {$IFDEF STDCALL} stdcall; {$ENDIF} {$IFDEF CDECL} cdecl; {$ENDIF} export;
begin

  if (balHandle = nil) then
  begin
     Result := -2;
     Exit;
  end;

  try
     if (balHandle^.BAL.Ativo) then
        Result := 1
     else
        Result := 0;
  except
     on exception : Exception do
     begin
        balHandle^.UltimoErro := exception.Message;
        Result := -1;
     end
  end;

end;

Function BAL_GetUltimoPesoLido(const balHandle: PBALHandle; var peso : Double) : Integer; {$IFDEF STDCALL} stdcall; {$ENDIF} {$IFDEF CDECL} cdecl; {$ENDIF} export;
begin

  if (balHandle = nil) then
  begin
     Result := -2;
     Exit;
  end;

  try
     peso := balHandle^.BAL.UltimoPesoLido;
     Result := 0;
  except
     on exception : Exception do
     begin
        balHandle^.UltimoErro := exception.Message;
        Result := -1;
     end
  end;

end;


Function BAL_GetUltimaResposta(const balHandle: PBALHandle; Buffer : pChar; const BufferLen : Integer) : Integer ; {$IFDEF STDCALL} stdcall; {$ENDIF} {$IFDEF CDECL} cdecl; {$ENDIF} export;
var
  StrTmp : String;
begin

  if (balHandle = nil) then
  begin
     Result := -2;
     Exit;
  end;

 try
     StrTmp := balHandle^.BAL.UltimaResposta;
     StrPLCopy(Buffer, StrTmp, BufferLen);
     Result := length(StrTmp);
  except
     on exception : Exception do
     begin
        balHandle^.UltimoErro := exception.Message;
        Result := -1;
     end
  end;

end;

Function BAL_LePeso(const balHandle: PBALHandle; const timeout : Integer; var peso : Double) : Integer; {$IFDEF STDCALL} stdcall; {$ENDIF} {$IFDEF CDECL} cdecl; {$ENDIF} export;
begin

  if (balHandle = nil) then
  begin
     Result := -2;
     Exit;
  end;

  try
     peso := balHandle^.BAL.LePeso(timeout);
     Result := 0;
  except
     on exception : Exception do
     begin
        balHandle^.UltimoErro := exception.Message;
        Result := -1;
     end
  end;

end;

exports

{ Funções }

BAL_Create, BAL_Destroy,
BAL_GetUltimoErro,
BAL_Ativar, BAL_Desativar,

{ Propriedades do Componente }

BAL_GetModelo, BAL_SetModelo, BAL_GetModeloStr,
BAL_GetPorta, BAL_SetPorta,
BAL_GetAtivo,
BAL_GetUltimoPesoLido, BAL_GetUltimaResposta,
BAL_LePeso;


end.
