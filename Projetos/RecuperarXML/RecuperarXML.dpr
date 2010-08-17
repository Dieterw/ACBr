program RecuperarXML;

uses
  Forms,
  principal in 'principal.pas' {frmPrincipal},
  ACBrHTMLtoXML in 'ACBrHTMLtoXML.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.Run;
end.
