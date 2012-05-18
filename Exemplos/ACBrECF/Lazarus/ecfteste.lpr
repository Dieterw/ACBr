program ECFTeste;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Interfaces, sysutils, // this includes the LCL widgetset
  Forms, ECFTeste1, ConfiguraSerial, EfetuaPagamento, Relatorio, Sobre,
  VendeItem, uDAV, uDAVOS, TurboPowerIPro, memdslaz, ACBrSerial, ACBrComum;

{$R *.res}

begin
  //DeleteFile( 'c:\temp\heaptrclog.trc');
  //SetHeapTraceOutput( 'c:\temp\heaptrclog.trc');
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TfrConfiguraSerial, frConfiguraSerial);
  Application.CreateForm(TfrPagamento, frPagamento);
  Application.CreateForm(TfrRelatorio, frRelatorio);
  Application.CreateForm(TfrmSobre, frmSobre);
  Application.CreateForm(TfrVendeItem, frVendeItem);
  Application.Run;
end.

