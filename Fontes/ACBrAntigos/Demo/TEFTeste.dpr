program TEFTeste;

uses
  Forms,
  UTEFTeste in 'UTEFTeste.pas' {Form1};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
