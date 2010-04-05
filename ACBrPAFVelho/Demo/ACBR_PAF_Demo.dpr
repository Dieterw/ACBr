program ACBR_PAF_Demo;

uses
  Forms,
  uFormPrincipal in 'uFormPrincipal.pas' {Form6};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm6, Form6);
  Application.Run;
end.
