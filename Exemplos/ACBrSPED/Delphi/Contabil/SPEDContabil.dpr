program SPEDContabil;

uses
  Forms,
  Frm_SPEDContabil in 'Frm_SPEDContabil.pas' {FrmSPEDContabil},
  ACBrSpedFiscal in '..\ACBrSpedFiscal.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFrmSPEDContabil, FrmSPEDContabil);
  Application.Run;
end.
