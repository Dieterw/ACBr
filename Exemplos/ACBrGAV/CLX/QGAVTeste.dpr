program QGAVTeste;

uses
  QForms,
  QGAVTeste1 in 'QGAVTeste1.pas' {Form1};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
