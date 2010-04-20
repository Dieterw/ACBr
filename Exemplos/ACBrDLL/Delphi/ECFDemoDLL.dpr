program ECFDemoDLL;

uses
  QForms,
  Principal in 'Principal.pas' {frPrincipal},
  UnitDeclaracao in 'UnitDeclaracao.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrPrincipal, frPrincipal);
  Application.Run;
end.
