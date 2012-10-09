program ACBrNFe_demo;

uses
  Forms,
  Unit1 in 'Unit1.pas' {Form1},
  ufrmStatus in 'ufrmStatus.pas' {frmStatus},
  ACBrDANFeEventoRaveRetrato in '..\..\..\Fontes\ACBrNFe2\ACBrDANFeEventoRaveRetrato.pas',
  pcnEventoNFe in '..\..\..\Fontes\PCN2\pcnEventoNFe.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TfrmStatus, frmStatus);
  Application.Run;
end.
