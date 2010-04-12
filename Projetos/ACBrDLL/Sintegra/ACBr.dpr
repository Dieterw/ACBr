library ACBr;

{ Important note about DLL memory management: ShareMem must be the
  first unit in your library's USES clause AND your project's (select
  Project-View Source) USES clause if your DLL exports any procedures or
  functions that pass strings as parameters or function results. This
  applies to all strings passed to and from your DLL--even those that
  are nested in records and classes. ShareMem is the interface unit to
  the BORLNDMM.DLL shared memory manager, which must be deployed along
  with your DLL. To avoid using BORLNDMM.DLL, pass string information
  using PChar or ShortString parameters. }


uses
  SysUtils,
  Classes,
  ACBrSintegra,
  ACBrConsts,
  DllACBrSintegra in 'DllACBrSintegra.pas';

{$R *.res}

function ACBr_VersaoDll(var Versao: ShortString): Integer; stdcall; export;
begin
//Versao da Dll obedece a versao do ACBr
//usei ACBr_VersaoDll ao invés de ACBr_SintegraVersaoDll
//pois num futuro possa ser integrado totalmente com o ACBr
{
Result=0 Erro ao retornar versão Dll
Result=1 OK
}
Result:=0;
try
  Versao:=ACBR_VERSAO;
  Result:=1;
except
end;
end;

exports
  //sintegra
  ACBr_SintegraAtivar,
  ACBr_SintegraDesativar,
  ACBr_SintegraLimparRegistros,
  ACBr_SintegraRegistro10,
  ACBr_SintegraRegistro11,
  ACBr_SintegraRegistro50,
  ACBr_SintegraRegistro51,
  ACBr_SintegraRegistro53,
  ACBr_SintegraRegistro54,
  ACBr_SintegraRegistro60M,
  ACBr_SintegraRegistro60A,
  ACBr_SintegraRegistro60D,
  ACBr_SintegraRegistro70,
  ACBr_SintegraRegistro75,
  ACBr_SintegraGeraArquivo,

  //ACBr
  ACBr_VersaoDll;

end.
