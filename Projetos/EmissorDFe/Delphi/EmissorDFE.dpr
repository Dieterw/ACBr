program EmissorDFE;

uses
  Forms,
  Frm_EmissorDFE in 'Frm_EmissorDFE.pas' {frmEmissorDFE};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'Emissor de Documento Fiscal Eletrônico';
  Application.CreateForm(TfrmEmissorDFE, frmEmissorDFE);
  Application.Run;
end.
