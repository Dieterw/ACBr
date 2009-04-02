program ACBrNFeMonitor;

uses
  Forms, RPDefine, SysUtils,
  ACBrNFeMonitor1 in 'ACBrNFeMonitor1.pas' {frmAcbrNfeMonitor},
  DoACBrNFeUnit in 'DoACBrNFeUnit.pas';

{$R *.res}

begin
  RPDefine.DataID := IntToStr(Application.Handle);
  Application.Initialize;
  Application.CreateForm(TfrmAcbrNfeMonitor, frmAcbrNfeMonitor);
  Application.Run;
end.
