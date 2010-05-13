program ACBrDANFe;

uses
  Forms,
  uACBrDanfe in 'uACBrDanfe.pas' {frm_danfe};

{$R *.res}

begin
  Application.Initialize;
  Application.ShowMainForm := False;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'ACBrDANFe';
  Application.CreateForm(Tfrm_danfe, frm_danfe);
  Application.Run;
end.
