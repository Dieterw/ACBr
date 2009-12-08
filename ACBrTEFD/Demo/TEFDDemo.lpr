program TEFDDemo;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms, Unit1, ConfiguraSerial, LResources, ACBr_LCL, ACBr_TEFD, Unit2, Unit3
  { you can add units after this };

{$IFDEF WINDOWS}{$R TEFDDemo.rc}{$ENDIF}

begin
   {$I TEFDDemo.lrs}
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.

