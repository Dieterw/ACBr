program EmulaLCB;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms
  { add your units here }, EmulaLCB1, ACBr_LCL;

begin
  Application.Initialize;
  Application.CreateForm(TfrEmulador, frEmulador);
  Application.Run;
end.

