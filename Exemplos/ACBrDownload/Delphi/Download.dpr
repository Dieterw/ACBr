program Download;

uses
  Forms,
  Frm_Download in 'Frm_Download.pas' {Form1},
  ACBrHTTPDownload in 'ACBrHTTPDownload.pas',
  ACBrFTPDownload in 'ACBrFTPDownload.pas',
  ACBrDownload in 'ACBrDownload.pas',
  ACBrDownloadClass in 'ACBrDownloadClass.pas';

{$R *.res}

begin
  //ReportMemoryLeaksOnShutdown := DebugHook <> 0;

  Application.Initialize;
  //Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
