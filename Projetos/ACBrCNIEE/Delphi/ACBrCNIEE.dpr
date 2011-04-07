program ACBrCNIEE;

uses
  Forms,
  ProxyConfig in 'ProxyConfig.pas' {frProxyConfig},
  Principal in 'Principal.pas' {frPrincipal};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrPrincipal, frPrincipal);
  Application.Run;
end.
