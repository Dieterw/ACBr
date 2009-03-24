program ACBrNFeMonitor;

uses
  Forms,
  ACBrNFeMonitor1 in 'ACBrNFeMonitor1.pas' {frmAcbrNfeMonitor},
  DoACBrNFeUnit in 'DoACBrNFeUnit.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmAcbrNfeMonitor, frmAcbrNfeMonitor);
  Application.Run;
end.
