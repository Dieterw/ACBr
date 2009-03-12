library ACBrECFDLL;

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
  ACBrECF,
  dmecf in 'dmecf.pas' {dm: TDataModule};
var
  ACBrECF1 :  TACBrECF;
  Ativo    : Boolean ;

{$R *.res}

Function DefineModelo(ModeloStr, Porta : PChar ; Timeout : Integer ): Boolean; StdCall; export;
Var
    Modelo : TACBrECFModelo ;
begin
  Modelo := ecfNenhum ;
  if ModeloStr ='Nenhum' then
     Modelo := ecfNenhum
  else if ModeloStr ='NaoFiscal' then
     Modelo := ecfNaoFiscal
  else if ModeloStr ='Bematech' then
     Modelo := ecfBematech
  else if ModeloStr ='Sweda' then
     Modelo := ecfSweda
  else if ModeloStr ='Daruma' then
     Modelo := ecfDaruma
  else if ModeloStr ='Schalter' then
     Modelo := ecfSchalter
  else if ModeloStr ='Mecaf' then
     Modelo := ecfMecaf
  else if ModeloStr ='Yanco' then
     Modelo := ecfYanco
  else if ModeloStr ='DataRegis' then
     Modelo := ecfDataRegis
  else if ModeloStr ='Urano' then
     Modelo := ecfUrano
  else if ModeloStr ='ICash' then
     Modelo := ecfICash
  else if ModeloStr ='Quattro' then
     Modelo := ecfQuattro
  else if ModeloStr ='FiscNET' then
     Modelo := ecfFiscNET ;

  Ativo    := False ;   
  ACBrECF1 :=  TACBrECF.Create(dm);

  ACBrECF1.Modelo  := Modelo ;
  ACBrECF1.Porta   := Porta ;
  ACBrECF1.TimeOut := Timeout ;

  try
     ACBrECF1.Ativar ;
     Ativo  := True ;
     Result := True ;
  except
     Ativo  := False ;
     Result := False ;
  end ;

end;
{ Abre Cupom - Possíveis Respostas:
 0 - Tudo OK ;
 8 - Erro Indefinido
 9 - Componente não foi inicializado ; }
Function IdentificaConsumidor( CPF_CNPJ, Nome, Endereco : PChar ) : Integer ; StdCall; export;
begin
  if not Ativo then
   begin
     Result := 9 ;
     Exit ;
   end;

  try
     ACBrECF1.IdentificaConsumidor( CPF_CNPJ, Nome, Endereco );
     Result := 0 ;
  except
     Result := 8 ;
  end;

end;

{ Abre Cupom - Possíveis Respostas:
 0 - Tudo OK ;
 1 - Parametro necessário não foi Informado
 8 - Erro Indefinido
 9 - Componente não foi inicializado ; }
Function AbreCupom( CPF_CNPJ, Nome, Endereco :PChar ) : Integer; StdCall; export;
begin
  if not Ativo then
   begin
     Result := 9 ;
     Exit ;
   end;

  try
     ACBrECF1.AbreCupom( CPF_CNPJ, Nome, Endereco );
     Result := 0 ;
  except
     Result := 8 ;
  end;

end;

{ Vende Item - Possíveis Respostas:
 0 - Tudo OK ;
 1 - Parametro necessário não foi Informado
 8 - Erro Indefinido
 9 - Componente não foi inicializado ; }
Function VendeItem( Codigo, Descricao, AliquotaICMS : PChar ;
                    Qtd, ValorUnitario, DescontoPorc : Double ;
                    Unidade, TipoDescontoAcrescimo : PChar ) : Integer ; StdCall; export;
begin
  if not Ativo then
   begin
     Result := 9 ;
     Exit ;
   end;

  try
     ACBrECF1.VendeItem( Codigo, Descricao, AliquotaICMS, Qtd, ValorUnitario, DescontoPorc, Unidade, TipoDescontoAcrescimo );
     Result := 0 ;
  except
     Result := 8 ;
  end;

end;

{ SubtotalizaCupom - Possíveis Respostas:
 0 - Tudo OK ;
 1 - Parametro necessário não foi Informado
 8 - Erro Indefinido
 9 - Componente não foi inicializado ; }
Function SubtotalizaCupom( DescontoAcrescimo : Double ;
                             MensagemRodape : Pchar ) : Integer; StdCall ; export;
begin
  if not Ativo then
   begin
     Result := 9 ;
     Exit ;
   end;

  try
     ACBrECF1.SubtotalizaCupom( DescontoAcrescimo, MensagemRodape );
     Result := 0 ;
  except
     Result := 8 ;
  end;
end;

{ EfetuaPagamento - Possíveis Respostas:
 0 - Tudo OK ;
 1 - Parametro necessário não foi Informado
 8 - Erro Indefinido
 9 - Componente não foi inicializado ; }
Function EfetuaPagamento( CodFormaPagto : PChar; Valor : Double;
                           Observacao : PChar ; ImprimeVinculado : Boolean = false) : Integer ; StdCall ; export;
begin
  if not Ativo then
   begin
     Result := 9 ;
     Exit ;
   end;

  try
     ACBrECF1.EfetuaPagamento( CodFormaPagto, Valor, Observacao, ImprimeVinculado );
     Result := 0 ;
  except
     Result := 8 ;
  end;
end;

{ FechaCupom - Possíveis Respostas:
 0 - Tudo OK ;
 1 - Parametro necessário não foi Informado
 8 - Erro Indefinido
 9 - Componente não foi inicializado ; }
Function FechaCupom( Observacao : PChar ) : Integer ; StdCall ; export;
begin
  if not Ativo then
   begin
     Result := 9 ;
     Exit ;
   end;

  try
     ACBrECF1.FechaCupom( Observacao );
     Result := 0 ;
  except
     Result := 8 ;
  end;
end;

{ LeituraX - Possíveis Respostas:
 0 - Tudo OK ;
 8 - Erro Indefinido
 9 - Componente não foi inicializado ; }
Function LeituraX : Integer ; StdCall ; export;
begin
  if not Ativo then
   begin
     Result := 9 ;
     Exit ;
   end;

  try
     ACBrECF1.LeituraX;
     Result := 0 ;
  except
     Result := 8 ;
  end;
end;

{ ReducaoZ - Possíveis Respostas:
 0 - Tudo OK ;
 8 - Erro Indefinido
 9 - Componente não foi inicializado ; }
Function ReducaoZ( DataHora : TDateTime = 0 ) : Integer ; StdCall ; export;
begin
  if not Ativo then
   begin
     Result := 9 ;
     Exit ;
   end;

  try
     ACBrECF1.ReducaoZ( DataHora );
     Result := 0 ;
  except
     Result := 8 ;
  end;
end;

{ CancelaCupom - Possíveis Respostas:
 0 - Tudo OK ;
 8 - Erro Indefinido
 9 - Componente não foi inicializado ; }
Function CancelaCupom : Integer ; StdCall ; export;
begin
  if not Ativo then
   begin
     Result := 9 ;
     Exit ;
   end;

  try
     ACBrECF1.CancelaCupom;
     Result := 0 ;
  except
     Result := 8 ;
  end;
end;

{ CancelaItemVendido - Possíveis Respostas:
 0 - Tudo OK ;
 1 - Parametro necessário não foi Informado
 8 - Erro Indefinido
 9 - Componente não foi inicializado ; }
Function CancelaItemVendido( NumItem : Integer ) : Integer ; StdCall ; export;
begin
  if not Ativo then
   begin
     Result := 9 ;
     Exit ;
   end;

  try
     ACBrECF1.CancelaItemVendido( NumItem );
     Result := 0 ;
  except
     Result := 8 ;
  end;
end;


exports

DefineModelo, IdentificaConsumidor, AbreCupom, VendeItem, SubtotalizaCupom,
EfetuaPagamento, FechaCupom,
LeituraX, ReducaoZ,
CancelaCupom, CancelaItemVendido ;

end.
