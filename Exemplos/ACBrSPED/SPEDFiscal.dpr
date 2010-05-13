program SPEDFiscal;

uses
  Forms,
  Frm_SPEDFiscal in 'Frm_SPEDFiscal.pas' {FrmSPEDFiscal},
  ACBrSpedFiscal in '..\ACBrSpedFiscal.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFrmSPEDFiscal, FrmSPEDFiscal);
  Application.Run;
end.
