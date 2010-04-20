program QLCBECFTeste;

uses
  QForms,
  QLCBECFTeste1 in 'QLCBECFTeste1.pas' {Form1};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
