program QFalaTeste;

uses
  QForms,
  QFalaTeste1 in 'QFalaTeste1.pas' {Form1};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
