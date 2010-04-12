program QExtensoTeste;

uses
  QForms,
  QExtensoTeste1 in 'QExtensoTeste1.pas' {frExtenso};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrExtenso, frExtenso);
  Application.Run;
end.
