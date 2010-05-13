program QTrocoTeste;

uses
  QForms,
  QTrocoTeste1 in 'QTrocoTeste1.pas' {FrmTroco};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFrmTroco, FrmTroco);
  Application.Run;
end.
