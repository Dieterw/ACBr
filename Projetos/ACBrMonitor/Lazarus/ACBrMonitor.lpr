program ACBrMonitor;

{$mode objfpc}{$H+}

uses
  {$DEFINE UseCThreads}
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms, ACBrTCP, UtilUnit, ACBrMonitor1, CmdUnit, ConfiguraSerial, DoACBrUnit,
  DoBALUnit, DoCHQUnit, DoDISUnit, DoECFBemafi32, DoECFObserver, DoECFUnit,
  DoETQUnit, DoGAVUnit, DoLCBUnit, sndkey32, Sobre, DoBoletoUnit, ACBrSerial,
  ACBr_Boleto, ACBr_BoletoFC_Fortes, ACBrDiversos, DoCEPUnit, DoIBGEUnit;

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFrmACBrMonitor, FrmACBrMonitor) ;
  Application.Run;
end.

