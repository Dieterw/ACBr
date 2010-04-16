program QECFTeste;

uses
  QForms,
  QECFTeste1 in 'QECFTeste1.pas' {Form1},
  QVendeItem in 'QVendeItem.pas' {frVendeItem},
  QRelatorio in 'QRelatorio.pas' {frRelatorio},
  QEfetuaPagamento in 'QEfetuaPagamento.pas' {frPagamento},
  Sobre in 'Sobre.pas' {frmSobre},
  UtilUnit in '../../../Projetos/ACBrMonitor/CLX/UtilUnit.pas',
  ConfiguraSerial in 'ConfiguraSerial.pas' {frConfiguraSerial};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'Teste do Componente ACBrECF (CLX)';
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TfrVendeItem, frVendeItem);
  Application.CreateForm(TfrRelatorio, frRelatorio);
  Application.CreateForm(TfrPagamento, frPagamento);
  Application.Run;
end.
