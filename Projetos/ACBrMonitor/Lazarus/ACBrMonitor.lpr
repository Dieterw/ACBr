program ACBrMonitor;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}
  cthreads,
  {$ENDIF}
  Interfaces, sysutils,// this includes the LCL widgetset
  {$IFDEF MSWINDOWS}
   Windows, Dialogs,
  {$ENDIF}
  Forms, ACBrTCP, UtilUnit, ACBrMonitor1, CmdUnit, ConfiguraSerial, DoACBrUnit,
  DoBALUnit, DoCHQUnit, DoDISUnit, DoECFBemafi32, DoECFObserver, DoECFUnit,
  DoETQUnit, DoGAVUnit, DoLCBUnit, Sobre, DoBoletoUnit, ACBrSerial, ACBr_Boleto,
  ACBrDiversos, ACBr_BoletoFC_LazReport, DoCEPUnit, DoIBGEUnit;

{$R *.res}

begin
  SetHeapTraceOutput(ExtractFilePath(ParamStr(0)) + 'heaptrclog.trc');
  Application.Initialize;

  {$IFDEF MSWINDOWS}
   CreateMutex(nil, True, 'ACBrMonitor');
   if GetLastError = ERROR_ALREADY_EXISTS then
   begin
      MessageDlg('ACBrMonitor','O programa ACBrMonitor já está em execução',
          mtError, [mbOK], 0);
      Application.Terminate;
      exit ;
   end;
  {$ENDIF}

  Application.CreateForm(TFrmACBrMonitor, FrmACBrMonitor) ;
  Application.Run;
end.

