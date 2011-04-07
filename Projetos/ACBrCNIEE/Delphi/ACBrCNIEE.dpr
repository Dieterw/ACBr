program ACBrCNIEE;

uses
  Forms,
  Principal in 'Principal.pas' {frPrincipal},
  ProxyConfig in 'ProxyConfig.pas' {frProxyConfig};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrPrincipal, frPrincipal);
  Application.Run;
end.
