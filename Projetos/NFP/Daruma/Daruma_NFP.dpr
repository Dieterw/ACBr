program Daruma_NFP;

uses
  Forms,
  principal in 'principal.pas' {frPrincipal};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrPrincipal, frPrincipal);
  Application.Run;
end.
