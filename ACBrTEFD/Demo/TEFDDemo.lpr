program TEFDDemo;

{$mode objfpc}{$H+}

uses
  {$DEFINE UseCThreads}
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms, Unit1, ConfiguraSerial, LResources, ACBr_LCL, ACBr_TEFD, Unit2, Unit3, Unit4, Unit5;

begin
   {$I TEFDDemo.lrs}
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.

