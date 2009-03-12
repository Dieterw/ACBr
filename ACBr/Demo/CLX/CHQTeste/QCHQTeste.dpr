program QCHQTeste;

uses
  QForms,
  QCHQTeste1 in 'QCHQTeste1.pas' {frCHQ};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrCHQ, frCHQ);
  Application.Run;
end.
