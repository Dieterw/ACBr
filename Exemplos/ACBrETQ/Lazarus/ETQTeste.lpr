program ETQTeste;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms
  { add your units here }, UPrincipal, ACBr_LCL;

begin
  Application.Initialize;
  Application.CreateForm(TFPrincipal, FPrincipal);
  Application.Run;
end.

