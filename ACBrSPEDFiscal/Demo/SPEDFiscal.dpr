program SPEDFiscal;

uses
  Forms,
  Frm_SPEDFiscal in 'Frm_SPEDFiscal.pas' {FrmSPEDFiscal} ;
{$R *.res}

begin
//  ReportMemoryLeaksOnShutdown := DebugHook <> 0;
  Application.Initialize;
//  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFrmSPEDFiscal, FrmSPEDFiscal);
  Application.Run;
end.
