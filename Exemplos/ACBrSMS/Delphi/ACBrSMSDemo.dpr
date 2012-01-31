program ACBrSMSDemo;

uses
  Forms,
  uPrincipal in 'uPrincipal.pas' {frmPrincipal},
  ACBrSMSZTE in 'D:\DELPHI\Componentes D2010\ACBr\Fontes\ACBrSerial\ACBrSMSZTE.pas',
  uListaMensagem in 'uListaMensagem.pas' {frmListaMensagem},
  uTrocarBandeja in 'uTrocarBandeja.pas' {frmTrocarBandeja},
  uEnviarMensagem in 'uEnviarMensagem.pas' {frmEnviarMensagem},
  ACBrSMSGenerico in 'D:\DELPHI\Componentes D2010\ACBr\Fontes\ACBrSerial\ACBrSMSGenerico.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.Run;
end.
