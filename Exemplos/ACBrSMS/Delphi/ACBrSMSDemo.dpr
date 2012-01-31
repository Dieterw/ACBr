program ACBrSMSDemo;

uses
  Forms,
  uPrincipal in 'uPrincipal.pas' {frmPrincipal},
  uListaMensagem in 'uListaMensagem.pas' {frmListaMensagem},
  uTrocarBandeja in 'uTrocarBandeja.pas' {frmTrocarBandeja},
  uEnviarMensagem in 'uEnviarMensagem.pas' {frmEnviarMensagem};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.Run;
end.
