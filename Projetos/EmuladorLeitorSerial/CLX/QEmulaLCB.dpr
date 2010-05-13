program QEmulaLCB;

uses
  QForms,
  QEmulaLCB1 in 'QEmulaLCB1.pas' {frEmulador};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrEmulador, frEmulador);
  Application.Run;
end.
