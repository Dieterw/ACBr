program ECFTeste;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms
  { you can add units after this }, ECFTeste1, ACBr_LCL, ConfiguraSerial,
EfetuaPagamento, Relatorio, Sobre, VendeItem, TurboPowerIPro;

{$R manifest.res}
{$R ecfteste.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TfrConfiguraSerial, frConfiguraSerial);
  Application.CreateForm(TfrPagamento, frPagamento);
  Application.CreateForm(TfrRelatorio, frRelatorio);
  Application.CreateForm(TfrmSobre, frmSobre);
  Application.CreateForm(TfrVendeItem, frVendeItem);
  Application.Run;
end.

