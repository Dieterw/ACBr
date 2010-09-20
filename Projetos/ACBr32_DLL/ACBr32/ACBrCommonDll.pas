unit ACBrCommonDll;

interface

uses
  SysUtils,
  Classes;

type THandle = record
  UltimoErro : String;
end;

type PHandle = ^THandle;

implementation

Function GetUltimoErro(const handle: PHandle; Buffer : pChar; const BufferLen : Integer) : Integer ; {$IFDEF STDCALL} stdcall; {$ELSE} cdecl; {$ENDIF} export;
begin

  try
     StrPLCopy(Buffer, handle^.UltimoErro, BufferLen);
     Result := length(handle^.UltimoErro);
  except
     on exception : Exception do
     begin
        handle^.UltimoErro := exception.Message;
        Result := -1;
     end
  end;
end;

exports

GetUltimoErro;

end.


