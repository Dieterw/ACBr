program QValidadorTeste;

uses
  QForms,
  QValidadorTeste1 in 'QValidadorTeste1.pas' {frValidador};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrValidador, frValidador);
  Application.Run;
end.
