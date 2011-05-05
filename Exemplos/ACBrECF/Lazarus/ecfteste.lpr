program ECFTeste;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms, zcomponent
  { you can add units after this }, ECFTeste1, ConfiguraSerial, EfetuaPagamento,
  Relatorio, Sobre, VendeItem, TurboPowerIPro, memdslaz, ACBrSerial;

{$R *.res}

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

