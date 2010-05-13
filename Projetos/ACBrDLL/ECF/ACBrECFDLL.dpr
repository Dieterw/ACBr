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
  ACBrECFClass,
  ACBrUtil,
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

{ DataHora - Retorna Data e Hora do ECF
 Possíveis Respostas:
 0 - Tudo OK ;
 1 - Parametro necessário não foi Informado
 8 - Erro Indefinido
 9 - Componente não foi inicializado ; }
Function DataHora( var DataHora : pchar ) : Integer ; StdCall ; export;
begin
  if not Ativo then
   begin
     Result := 9 ;
     Exit ;
   end;

  try
     DataHora := pchar(FormatDateTime('dd/mm/yy hh:nn:ss', ACBrECF1.DataHora )) ;
     Result := 0 ;
  except
     Result := 8 ;
  end;
end;

{ Numcupom - Retorna Número do Cupom Atual
 Possíveis Respostas:
 0 - Tudo OK ;
 1 - Parametro necessário não foi Informado
 8 - Erro Indefinido
 9 - Componente não foi inicializado ; }
Function Numcupom( var NumCupom : pchar ) : Integer ; StdCall ; export;
begin
  if not Ativo then
   begin
     Result := 9 ;
     Exit ;
   end;

  try
     Numcupom := pchar( ACBrECF1.Numcupom ) ;
     Result := 0 ;
  except
     Result := 8 ;
  end;
end;

{ NumLoja - Retorna Número da Loja
 Possíveis Respostas:
 0 - Tudo OK ;
 1 - Parametro necessário não foi Informado
 8 - Erro Indefinido
 9 - Componente não foi inicializado ; }
Function NumLoja( var NumLoja : pchar ) : Integer ; StdCall ; export;
begin
  if not Ativo then
   begin
     Result := 9 ;
     Exit ;
   end;

  try
     NumLoja := pchar( ACBrECF1.NumLoja ) ;
     Result := 0 ;
  except
     Result := 8 ;
  end;
end;

{ NumCRO - Retorna Número do CRO
 Possíveis Respostas:
 0 - Tudo OK ;
 1 - Parametro necessário não foi Informado
 8 - Erro Indefinido
 9 - Componente não foi inicializado ; }
Function NumCRO( var NumCRO : pchar ) : Integer ; StdCall ; export;
begin
  if not Ativo then
   begin
     Result := 9 ;
     Exit ;
   end;

  try
     NumCRO := pchar( ACBrECF1.NumCRO ) ;
     Result := 0 ;
  except
     Result := 8 ;
  end;
end;

{ NumCRZ - Retorna Número do CRZ
 Possíveis Respostas:
 0 - Tudo OK ;
 1 - Parametro necessário não foi Informado
 8 - Erro Indefinido
 9 - Componente não foi inicializado ; }
Function NumCRZ( var NumCRZ : pchar ) : Integer ; StdCall ; export;
begin
  if not Ativo then
   begin
     Result := 9 ;
     Exit ;
   end;

  try
     NumCRZ := pchar( ACBrECF1.NumCRZ ) ;
     Result := 0 ;
  except
     Result := 8 ;
  end;
end;

{ NumECF - Retorna Número do ECF
 Possíveis Respostas:
 0 - Tudo OK ;
 1 - Parametro necessário não foi Informado
 8 - Erro Indefinido
 9 - Componente não foi inicializado ; }
Function NumECF( var NumECF : pchar ) : Integer ; StdCall ; export;
begin
  if not Ativo then
   begin
     Result := 9 ;
     Exit ;
   end;

  try
     NumECF := pchar( ACBrECF1.NumECF ) ;
     Result := 0 ;
  except
     Result := 8 ;
  end;
end;

{ NumSerie - Retorna Número do CRO
 Possíveis Respostas:
 0 - Tudo OK ;
 1 - Parametro necessário não foi Informado
 8 - Erro Indefinido
 9 - Componente não foi inicializado ; }
Function NumSerie( var NumSerie : pchar ) : Integer ; StdCall ; export;
begin
  if not Ativo then
   begin
     Result := 9 ;
     Exit ;
   end;

  try
     NumSerie := pchar( ACBrECF1.NumSerie ) ;
     Result := 0 ;
  except
     Result := 8 ;
  end;
end;

{ NumVersao - Retorna Número da Versão do Firmware
 Possíveis Respostas:
 0 - Tudo OK ;
 1 - Parametro necessário não foi Informado
 8 - Erro Indefinido
 9 - Componente não foi inicializado ; }
Function NumVersao( var NumVersao : pchar ) : Integer ; StdCall ; export;
begin
  if not Ativo then
   begin
     Result := 9 ;
     Exit ;
   end;

  try
     NumVersao := pchar( ACBrECF1.NumVersao ) ;
     Result := 0 ;
  except
     Result := 8 ;
  end;
end;

{ DataMovimento - Retorna Data do movimento do ECF
 Possíveis Respostas:
 0 - Tudo OK ;
 1 - Parametro necessário não foi Informado
 8 - Erro Indefinido
 9 - Componente não foi inicializado ; }
Function DataMovimento( var DataMovimento : pchar ) : Integer ; StdCall ; export;
begin
  if not Ativo then
   begin
     Result := 9 ;
     Exit ;
   end;

  try
     DataMovimento := pchar(FormatDateTime('dd/mm/yy', ACBrECF1.DataMovimento )) ;
     Result := 0 ;
  except
     Result := 8 ;
  end;
end;

{ CNPJ - Retorna Número do CNPJ
 Possíveis Respostas:
 0 - Tudo OK ;
 1 - Parametro necessário não foi Informado
 8 - Erro Indefinido
 9 - Componente não foi inicializado ; }
Function CNPJ( var CNPJ : pchar ) : Integer ; StdCall ; export;
begin
  if not Ativo then
   begin
     Result := 9 ;
     Exit ;
   end;

  try
     CNPJ := pchar( ACBrECF1.CNPJ ) ;
     Result := 0 ;
  except
     Result := 8 ;
  end;
end;

{ IE - Retorna Número da IE
 Possíveis Respostas:
 0 - Tudo OK ;
 1 - Parametro necessário não foi Informado
 8 - Erro Indefinido
 9 - Componente não foi inicializado ; }
Function IE( var IE : pchar ) : Integer ; StdCall ; export;
begin
  if not Ativo then
   begin
     Result := 9 ;
     Exit ;
   end;

  try
     IE := pchar( ACBrECF1.IE ) ;
     Result := 0 ;
  except
     Result := 8 ;
  end;
end;


{ NumCOOInicial - Retorna Número COO Inicial
 Possíveis Respostas:
 0 - Tudo OK ;
 1 - Parametro necessário não foi Informado
 8 - Erro Indefinido
 9 - Componente não foi inicializado ; }
Function NumCOOInicial( var NumCOOInicial : pchar ) : Integer ; StdCall ; export;
begin
  if not Ativo then
   begin
     Result := 9 ;
     Exit ;
   end;

  try
     NumCOOInicial := pchar( ACBrECF1.NumCOOInicial ) ;
     Result := 0 ;
  except
     Result := 8 ;
  end;
end;

{ VendaBruta - Retorna VendaBruta
 Possíveis Respostas:
 0 - Tudo OK ;
 1 - Parametro necessário não foi Informado
 8 - Erro Indefinido
 9 - Componente não foi inicializado ; }
Function VendaBruta( var VendaBruta : pchar ) : Integer ; StdCall ; export;
begin
  if not Ativo then
   begin
     Result := 9 ;
     Exit ;
   end;

  try
     VendaBruta := pchar( floattostr(ACBrECF1.VendaBruta) ) ;
     Result := 0 ;
  except
     Result := 8 ;
  end;
end;

{ GrandeTotal - Retorna VendaBruta
 Possíveis Respostas:
 0 - Tudo OK ;
 1 - Parametro necessário não foi Informado
 8 - Erro Indefinido
 9 - Componente não foi inicializado ; }
Function GrandeTotal( var GrandeTotal : pchar ) : Integer ; StdCall ; export;
begin
  if not Ativo then
   begin
     Result := 9 ;
     Exit ;
   end;

  try
     GrandeTotal := pchar( floattostr(ACBrECF1.GrandeTotal) ) ;
     Result := 0 ;
  except
     Result := 8 ;
  end;
end;

{ TotalCancelamentos - Retorna TotalCancelamentos
 Possíveis Respostas:
 0 - Tudo OK ;
 1 - Parametro necessário não foi Informado
 8 - Erro Indefinido
 9 - Componente não foi inicializado ; }
Function TotalCancelamentos( var TotalCancelamentos : pchar ) : Integer ; StdCall ; export;
begin
  if not Ativo then
   begin
     Result := 9 ;
     Exit ;
   end;

  try
     TotalCancelamentos := pchar( floattostr(ACBrECF1.TotalCancelamentos) ) ;
     Result := 0 ;
  except
     Result := 8 ;
  end;
end;


{ TotalDescontos - Retorna TotalDescontos
 Possíveis Respostas:
 0 - Tudo OK ;
 1 - Parametro necessário não foi Informado
 8 - Erro Indefinido
 9 - Componente não foi inicializado ; }
Function TotalDescontos( var TotalDescontos : pchar ) : Integer ; StdCall ; export;
begin
  if not Ativo then
   begin
     Result := 9 ;
     Exit ;
   end;

  try
     TotalDescontos := pchar( floattostr(ACBrECF1.TotalDescontos) ) ;
     Result := 0 ;
  except
     Result := 8 ;
  end;
end;

{ TotalAcrescimos - Retorna TotalAcrescimos
 Possíveis Respostas:
 0 - Tudo OK ;
 1 - Parametro necessário não foi Informado
 8 - Erro Indefinido
 9 - Componente não foi inicializado ; }
Function TotalAcrescimos( var TotalAcrescimos : pchar ) : Integer ; StdCall ; export;
begin
  if not Ativo then
   begin
     Result := 9 ;
     Exit ;
   end;

  try
     TotalAcrescimos := pchar( floattostr(ACBrECF1.TotalAcrescimos) ) ;
     Result := 0 ;
  except
     Result := 8 ;
  end;
end;

{ TotalSubstituicaoTributaria - Retorna TotalSubstituicaoTributaria
 Possíveis Respostas:
 0 - Tudo OK ;
 1 - Parametro necessário não foi Informado
 8 - Erro Indefinido
 9 - Componente não foi inicializado ; }
Function TotalSubstituicaoTributaria( var TotalSubstituicaoTributaria : pchar ) : Integer ; StdCall ; export;
begin
  if not Ativo then
   begin
     Result := 9 ;
     Exit ;
   end;

  try
     TotalSubstituicaoTributaria := pchar( floattostr(ACBrECF1.TotalSubstituicaoTributaria) ) ;
     Result := 0 ;
  except
     Result := 8 ;
  end;
end;

{ TotalNaoTributado - Retorna TotalNaoTributado
 Possíveis Respostas:
 0 - Tudo OK ;
 1 - Parametro necessário não foi Informado
 8 - Erro Indefinido
 9 - Componente não foi inicializado ; }
Function TotalNaoTributado( var TotalNaoTributado : pchar ) : Integer ; StdCall ; export;
begin
  if not Ativo then
   begin
     Result := 9 ;
     Exit ;
   end;

  try
     TotalNaoTributado := pchar( floattostr(ACBrECF1.TotalNaoTributado) ) ;
     Result := 0 ;
  except
     Result := 8 ;
  end;
end;

{ TotalIsencao - Retorna TotalIsencao
 Possíveis Respostas:
 0 - Tudo OK ;
 1 - Parametro necessário não foi Informado
 8 - Erro Indefinido
 9 - Componente não foi inicializado ; }
Function TotalIsencao( var TotalIsencao : pchar ) : Integer ; StdCall ; export;
begin
  if not Ativo then
   begin
     Result := 9 ;
     Exit ;
   end;

  try
     TotalIsencao := pchar( floattostr(ACBrECF1.TotalIsencao) ) ;
     Result := 0 ;
  except
     Result := 8 ;
  end;
end;

{ NumUltItem - Retorna Número do Cupom Atual
  Possíveis Respostas:
  0 - Tudo OK ;
  1 - Parametro necessário não foi Informado
  8 - Erro Indefinido
  9 - Componente não foi inicializado ; }
Function NumUltItem( var NumUltItem : pchar ) : Integer ; StdCall ; export; begin
   if not Ativo then
    begin
      Result := 9 ;
      Exit ;
    end;

   try
      NumUltItem := pchar( ACBrECF1.NumUltItem ) ;
      Result := 0 ;
   except
      Result := 8 ;
   end;
end;

{ DadosReducaoz - Retorna DadosReducaoz
  Possíveis Respostas:
  0 - Tudo OK ;
  1 - Parametro necessário não foi Informado
  8 - Erro Indefinido
  9 - Componente não foi inicializado ; }
  Function DadosReducaoz( var DadosReducaoz : pchar ) : Integer ; StdCall ; export; begin
   if not Ativo then
    begin
      Result := 9 ;
      Exit ;
    end;

   try
      DadosReducaoz := pchar( ACBrECF1.DadosReducaoz ) ;
      Result := 0 ;
   except
      Result := 8 ;
   end;
end;

{ DadosUltimaReducaoZ - Retorna DadosUltimaReducaoZ
  Possíveis Respostas:
  0 - Tudo OK ;
  1 - Parametro necessário não foi Informado
  8 - Erro Indefinido
  9 - Componente não foi inicializado ; }
  Function DadosUltimaReducaoZ( var DadosUltimaReducaoZ : pchar ) : Integer ; StdCall ; export; begin
   if not Ativo then
    begin
      Result := 9 ;
      Exit ;
    end;

   try
      DadosUltimaReducaoZ := pchar( ACBrECF1.DadosUltimaReducaoZ ) ;
      Result := 0 ;
   except
      Result := 8 ;
   end;
end;

{ Aliquotas - Retorna Aliquotas
  Possíveis Respostas:
  0 - Tudo OK ;
  1 - Parametro necessário não foi Informado
  8 - Erro Indefinido
  9 - Componente não foi inicializado ; }
Function Aliquotas( var v_Aliquotas : pchar ) : Integer ; StdCall ; export;
    Var I : Integer;
      resp : string ;
begin
   if not Ativo then
    begin
      Result := 9 ;
      Exit ;
    end;

   try
      resp := '' ;
      if ACBrECF1.Aliquotas.Count < 1 then
        ACBrECF1.CarregaAliquotas ;

      for I := 0 to ACBrECF1.Aliquotas.Count -1 do
         resp := resp + padL(ACBrECF1.Aliquotas[I].Indice,4)
                      + ' '
                      + ACBrECF1.Aliquotas[I].Tipo
                      + FormatFloat('#0.00', ACBrECF1.Aliquotas[I].Aliquota) + '|' ;

      if resp <> '' then
      begin
         v_Aliquotas := pchar(copy(resp,1,Length(resp)-1)) ;
      End;
      Result := 0;
   except
      Result := 8 ;
   end;
end;

{ LerTotaisAliquota - Retorna LerTotaisAliquota
  Possíveis Respostas:
  0 - Tudo OK ;
  1 - Parametro necessário não foi Informado
  8 - Erro Indefinido
  9 - Componente não foi inicializado ;
Aliquotas : TACBrECFAliquota; }
Function LerTotaisAliquota( var v_TotaisAliquota : pchar ) : Integer ; StdCall ; export;
   Var I : Integer;
      resp : string ;
begin
   if not Ativo then
    begin
      Result := 9 ;
      Exit ;
    end;

   try
      resp := '' ;
      ACBrECF1.LerTotaisAliquota ;

      for I := 0 to ACBrECF1.Aliquotas.Count -1 do
         resp := resp + padL(ACBrECF1.Aliquotas[I].Indice,4) +
                            FormatFloat('########0.00', ACBrECF1.Aliquotas[I].Total ) + '|' ;


      if resp <> '' then
      begin
         v_TotaisAliquota := pchar(copy(resp,1,Length(resp)-1)) ;
      End;
      Result := 0 ;
   except
      Result := 8 ;
   end;
end;

{ ProgramaAliquota - Programa Aliquota de ICMS/ISS
  Possíveis Respostas:
  0 - Tudo OK ;
  1 - Parametro necessário não foi Informado
  8 - Erro Indefinido
  9 - Componente não foi inicializado ; }
Function ProgramaAliquota( Aliq : Double ; Tipo : Char ; var ret_pos : pchar ) : Integer ; StdCall ; export;
   var Posicao :string ;
begin
   if not Ativo then
    begin
      Result := 9 ;
      Exit ;
    end;

   try
      ACBrECF1.ProgramaAliquota(Aliq,Tipo,Posicao)  ;
      ret_pos := pchar(Posicao);
      Result := 0 ;
   except
      Result := 8 ;
   end;
end;

{ AchaIcmsAliquota - Encontra posição da Aliquota de ICMS/ISSS
  Possíveis Respostas:
  0 - Tudo OK ;
  1 - Parametro necessário não foi Informado
  8 - Erro Indefinido
  9 - Componente não foi inicializado ; }
Function AchaIcmsAliquota( Aliq : Double ; Tipo : Char ; var ret_pos : pchar ) : Integer ; StdCall ; export;
   var ICMS    : TACBrECFAliquota  ;
begin
   if not Ativo then
    begin
      Result := 9 ;
      Exit ;
    end;

   try
      ICMS := ACBrECF1.AchaICMSAliquota( Aliq, Tipo  ) ;
      if ICMS <> nil then
              ret_pos := pchar(padL(ICMS.Indice,4))
      else
         ret_pos := pchar(padL('-1',4));
      Result := 0 ;
   except
      Result := 8 ;
   end;
end;

{ FormasPagamento - Retorna Formas de Pagamento
  Possíveis Respostas:
  0 - Tudo OK ;
  1 - Parametro necessário não foi Informado
  8 - Erro Indefinido
  9 - Componente não foi inicializado ; }
Function FormasPagamento( var v_FormasPagamento : pchar ) : Integer ; StdCall ; export;
    Var I : Integer;
      resp : string;
      Vinc : Char ;
begin
   if not Ativo then
    begin
      Result := 9 ;
      Exit ;
    end;

   try
      resp := '' ;
      if ACBrECF1.FormasPagamento.Count < 1 then
         ACBrECF1.CarregaFormasPagamento ;


      for I := 0 to ACBrECF1.FormasPagamento.Count -1 do
      begin
         Vinc := ' ' ;
         if ACBrECF1.FormasPagamento[I].PermiteVinculado then
            Vinc := 'V' ;

         resp := resp + padL(ACBrECF1.FormasPagamento[I].Indice,4)
                      + ' '
                      + Vinc
                      + ACBrECF1.FormasPagamento[I].Descricao
                      + '|' ;
      end;
      if resp <> '' then
      begin
         v_FormasPagamento := pchar(copy(resp,1,Length(resp)-1)) ;
      End;
      Result := 0;
   except
      Result := 8 ;
   end;
end;

{ LerTotaisFormaPagamento - Retorna TotaisFormaPagamento
  Possíveis Respostas:
  0 - Tudo OK ;
  1 - Parametro necessário não foi Informado
  8 - Erro Indefinido
  9 - Componente não foi inicializado ;
  ACBrECF1.FormasPagamento[I]. : TACBrECFAliquota; }
Function LerTotaisFormaPagamento( var v_TotaisFormaPagamento : pchar ) : Integer ; StdCall ; export;
   Var I : Integer;
      resp : string ;
begin
   if not Ativo then
    begin
      Result := 9 ;
      Exit ;
    end;

   try
      resp := '' ;
      ACBrECF1.LerTotaisFormaPagamento ;

      for I := 0 to ACBrECF1.FormasPagamento.Count -1 do
         resp := resp + padL(ACBrECF1.FormasPagamento[I].Indice,4)
                      + FormatFloat('########0.00', ACBrECF1.FormasPagamento[I].Total ) + '|' ;


      if resp <> '' then
      begin
         v_TotaisFormaPagamento := pchar(copy(resp,1,Length(resp)-1)) ;
      End;
      Result := 0 ;
   except
      Result := 8 ;
   end;
end;

{ ProgramaFormaPagamento - Programa Forma de Pagamento
  Possíveis Respostas:
  0 - Tudo OK ;
  1 - Parametro necessário não foi Informado
  8 - Erro Indefinido
  9 - Componente não foi inicializado ; }
Function ProgramaFormaPagamento( Descricao : String ; Vinc : Boolean ; var ret_pos : pchar ) : Integer ; StdCall ; export;
   var Posicao :string ;
begin
   if not Ativo then
    begin
      Result := 9 ;
      Exit ;
    end;

   try
      ACBrECF1.ProgramaFormaPagamento(Descricao,Vinc,Posicao)  ;
      ret_pos := pchar(Posicao);
      Result := 0 ;
   except
      Result := 8 ;
   end;
end;

{ AchaFPGDescricao - Encontra posição da Forma de Pagamento
  Possíveis Respostas:
  0 - Tudo OK ;
  1 - Parametro necessário não foi Informado
  8 - Erro Indefinido
  9 - Componente não foi inicializado ; }
Function AchaFPGDescricao( Descricao : String ;  var retorno : pchar  ) : Integer ; StdCall ; export;
   var FPG    : TACBrECFFormaPagamento  ;
       vinc   : string;

begin
   if not Ativo then
    begin
      Result := 9 ;
      Exit ;
    end;

   try
      FPG := ACBrECF1.AchaFPGDescricao( Descricao, False  ) ;

      if FPG <> nil then
      begin
         Vinc := ' ';
         If FPG.PermiteVinculado then
           Vinc := 'V';

         retorno := pchar(padL(FPG.Indice,4) +
                          Vinc+
                          padL( FPG.Descricao, 30));
      end
      else
         retorno := pchar(padL('-1',4));

      Result := 0 ;

   except
      Result := 8 ;
   end;
end;

{ ComprovantesNaoFiscais - Retorna Comprovantes não Fiscais
  Possíveis Respostas:
  0 - Tudo OK ;
  1 - Parametro necessário não foi Informado
  8 - Erro Indefinido
  9 - Componente não foi inicializado ; }
Function ComprovantesNaoFiscais( var v_ComprovantesNaoFiscais : pchar ) : Integer ; StdCall ; export;
    Var I : Integer;
      resp : string;
       Vinc : Char ;
begin
   if not Ativo then
    begin
      Result := 9 ;
      Exit ;
    end;

   try
      resp := '' ;
      if ACBrECF1.ComprovantesNaoFiscais.Count < 1 then
         ACBrECF1.CarregaComprovantesNaoFiscais ;


      for I := 0 to ACBrECF1.ComprovantesNaoFiscais.Count -1 do
      begin
         Vinc := ' ' ;
         if ACBrECF1.ComprovantesNaoFiscais[I].PermiteVinculado then
            Vinc := 'V' ;

         resp := resp + padL(ACBrECF1.ComprovantesNaoFiscais[I].Indice,4)
                      + ' '
                      + Vinc
                      + ACBrECF1.ComprovantesNaoFiscais[I].Descricao
                      + '|' ;
      end;
      if resp <> '' then
      begin
         v_ComprovantesNaoFiscais := pchar(copy(resp,1,Length(resp)-1)) ;
      End;
      Result := 0;
   except
      Result := 8 ;
   end;
end;

{ LerTotaisComprovante - Retorna TotaisComprovante Não Fiscais
  Possíveis Respostas:
  0 - Tudo OK ;
  1 - Parametro necessário não foi Informado
  8 - Erro Indefinido
  9 - Componente não foi inicializado ;     }

Function LerTotaisComprovante( var v_LerTotaisComprovante : pchar ) : Integer ; StdCall ; export;
   Var I : Integer;
      resp : string ;
begin
   if not Ativo then
    begin
      Result := 9 ;
      Exit ;
    end;

   try
      resp := '' ;
      ACBrECF1.LerTotaisComprovanteNaoFiscal;

      for I := 0 to ACBrECF1.ComprovantesNaoFiscais.Count -1 do
         resp := resp + padL(ACBrECF1.ComprovantesNaoFiscais[I].Indice,4)
                      + FormatFloat('########0.00', ACBrECF1.ComprovantesNaoFiscais[I].Total ) + '|' ;


      if resp <> '' then
      begin
         v_LerTotaisComprovante := pchar(copy(resp,1,Length(resp)-1)) ;
      End;
      Result := 0 ;
   except
      Result := 8 ;
   end;
end;

{ ProgramaComprovante - Programa Comprovantes Não fiscais
  Possíveis Respostas:
  0 - Tudo OK ;
  1 - Parametro necessário não foi Informado
  8 - Erro Indefinido
  9 - Componente não foi inicializado ; }
Function ProgramaComprovante( Descricao , Tipo : String ; var ret_pos : pchar ) : Integer ; StdCall ; export;
   var Posicao :string ;
begin
   if not Ativo then
    begin
      Result := 9 ;
      Exit ;
    end;

   try
      ACBrECF1.ProgramaComprovanteNaoFiscal(Descricao,Tipo,Posicao)  ;
      ret_pos := pchar(Posicao);
      Result := 0 ;
   except
      Result := 8 ;
   end;
end;

{ AchaCNFDescricao - Encontra posição do Comprovante Não Fiscal
  Possíveis Respostas:
  0 - Tudo OK ;
  1 - Parametro necessário não foi Informado
  8 - Erro Indefinido
  9 - Componente não foi inicializado ; }
Function AchaCNFDescricao( Descricao : String ;  var retorno : pchar  ) : Integer ; StdCall ; export;
   var CNF    : TACBrECFComprovanteNaoFiscal  ;
       vinc   : string;

begin
   if not Ativo then
    begin
      Result := 9 ;
      Exit ;
    end;

   try
      CNF := ACBrECF1.AchaCNFDescricao( Descricao, False  ) ;

      if CNF <> nil then
      begin
         Vinc := ' ';
         If CNF.PermiteVinculado then
           Vinc := 'V';

         retorno := pchar(padL(CNF.Indice,4) +
                          Vinc+
                          padL( CNF.Descricao, 30));
      end
      else
         retorno := pchar(padL('-1',4));

      Result := 0 ;

   except
      Result := 8 ;
   end;
end;


{ TestaPodeAbrirCupom - Retorna Ok se pode abrir Cupom ou Motivo por nao poder
  Possíveis Respostas:
  0 - Tudo OK ;
  1 - Parametro necessário não foi Informado
  8 - Erro Indefinido
  9 - Componente não foi inicializado ; }
Function TestaPodeAbrirCupom( var v_TestaPodeAbrirCupom : pchar ) : Integer ; StdCall ; export; begin
   if not Ativo then
    begin
      Result := 9 ;
      Exit ;
    end;
   result := 8;
   try
      ACBrECF1.TestaPodeAbrirCupom;
      v_TestaPodeAbrirCupom := pchar( 'OK' ) ;
      Result := 0 ;
   except
      on E : Exception do begin
        v_TestaPodeAbrirCupom := pchar( E.Message );
      end;
   end;
end;

{ SubTotal - Retorna SubTotal do Cupom
 Possíveis Respostas:
 0 - Tudo OK ;
 1 - Parametro necessário não foi Informado
 8 - Erro Indefinido
 9 - Componente não foi inicializado ; }
Function SubTotal( var SubTotal : pchar ) : Integer ; StdCall ; export;
begin
  if not Ativo then
   begin
     Result := 9 ;
     Exit ;
   end;

  try
     SubTotal := pchar( floattostr(ACBrECF1.Subtotal) ) ;
     Result := 0 ;
  except
     Result := 8 ;
  end;
end;

{ TotalPago - Retorna TotalPago no Cupom
 Possíveis Respostas:
 0 - Tudo OK ;
 1 - Parametro necessário não foi Informado
 8 - Erro Indefinido
 9 - Componente não foi inicializado ; }
Function TotalPago( var TotalPago : pchar ) : Integer ; StdCall ; export;
begin
  if not Ativo then
   begin
     Result := 9 ;
     Exit ;
   end;

  try
     TotalPago := pchar( floattostr(ACBrECF1.TotalPago) ) ;
     Result := 0 ;
  except
     Result := 8 ;
  end;
end;

{ Sangria - Efetua Sangria
 Possíveis Respostas:
 0 - Tudo OK ;
 1 - Parametro necessário não foi Informado
 8 - Erro Indefinido
 9 - Componente não foi inicializado ; }
Function Sangria( const Valor: Double; Obs: AnsiString) : Integer ; StdCall ; export;
begin
  if not Ativo then
   begin
     Result := 9 ;
     Exit ;
   end;

  try
     ACBrECF1.Sangria(Valor, Obs);
     Result := 0 ;
  except
     Result := 8 ;
  end;
end;

{ Suprimento - Efetua Suprimento
 Possíveis Respostas:
 0 - Tudo OK ;
 1 - Parametro necessário não foi Informado
 8 - Erro Indefinido
 9 - Componente não foi inicializado ; }
Function Suprimento( const Valor: Double; Obs: AnsiString) : Integer ; StdCall ; export;
begin
  if not Ativo then
   begin
     Result := 9 ;
     Exit ;
   end;

  try
     ACBrECF1.Suprimento(Valor, Obs);
     Result := 0 ;
  except
     Result := 8 ;
  end;
end;

{ CortaPapel - Efetua Corte do Papel
 Possíveis Respostas:
 0 - Tudo OK ;
 1 - Parametro necessário não foi Informado
 8 - Erro Indefinido
 9 - Componente não foi inicializado ; }
Function CortaPapel( const CorteParcial : Boolean) : Integer ; StdCall ; export;
begin
  if not Ativo then
   begin
     Result := 9 ;
     Exit ;
   end;

  try
     ACBrECF1.CortaPapel(CorteParcial);
     Result := 0 ;
  except
     Result := 8 ;
  end;
end;

{ AbreNaoFiscal - Abre Cupom Nao Fiscal
 Possíveis Respostas:
 0 - Tudo OK ;
 1 - Parametro necessário não foi Informado
 8 - Erro Indefinido
 9 - Componente não foi inicializado ; }
Function AbreNaoFiscal( CPF_CNPJ: String) : Integer ; StdCall ; export;
begin
  if not Ativo then
   begin
     Result := 9 ;
     Exit ;
   end;

  try
     ACBrECF1.AbreNaoFiscal(CPF_CNPJ);
     Result := 0 ;
  except
     Result := 8 ;
  end;
end;

{ RegistraItemNaoFiscal - Registra Item em Cupom Nao Fiscal
 Possíveis Respostas:
 0 - Tudo OK ;
 1 - Parametro necessário não foi Informado
 8 - Erro Indefinido
 9 - Componente não foi inicializado ; }
Function RegistraItemNaoFiscal(CodCNF: String; Valor: Double;
  Obs: AnsiString = '') : Integer ; StdCall ; export;
begin
  if not Ativo then
   begin
     Result := 9 ;
     Exit ;
   end;

  try
     ACBrECF1.RegistraItemNaoFiscal(CodCNF,Valor,Obs);
     Result := 0 ;
  except
     Result := 8 ;
  end;
end;

{ SubtotalizaNaoFiscal - Subtotaliza Cupom Não Fiscal
 Possíveis Respostas:
 0 - Tudo OK ;
 1 - Parametro necessário não foi Informado
 8 - Erro Indefinido
 9 - Componente não foi inicializado ; }
Function SubtotalizaNaoFiscal(DescontoAcrescimo: Double;
   MensagemRodape: AnsiString) : Integer ; StdCall ; export;
begin
  if not Ativo then
   begin
     Result := 9 ;
     Exit ;
   end;

  try
     ACBrECF1.SubtotalizaNaoFiscal(DescontoAcrescimo,MensagemRodape);
     Result := 0 ;
  except
     Result := 8 ;
  end;
end;

{ EfetuaPagamentoNaoFiscal - Efetua Pagamento em Cupom Não Fiscal
 Possíveis Respostas:
 0 - Tudo OK ;
 1 - Parametro necessário não foi Informado
 8 - Erro Indefinido
 9 - Componente não foi inicializado ; }
Function EfetuaPagamentoNaoFiscal(CodFormaPagto: String;
  Valor: Double; Observacao: AnsiString; ImprimeVinculado: Boolean) : Integer ; StdCall ; export;
begin
  if not Ativo then
   begin
     Result := 9 ;
     Exit ;
   end;

  try
     ACBrECF1.EfetuaPagamentoNaoFiscal(CodFormaPagto,Valor,Observacao,ImprimeVinculado);
     Result := 0 ;
  except
     Result := 8 ;
  end;
end;

{ FechaNaoFiscal - Fecha  Cupom Não Fiscal
 Possíveis Respostas:
 0 - Tudo OK ;
 1 - Parametro necessário não foi Informado
 8 - Erro Indefinido
 9 - Componente não foi inicializado ; }
Function FechaNaoFiscal(Observacao: AnsiString) : Integer ; StdCall ; export;
begin
  if not Ativo then
   begin
     Result := 9 ;
     Exit ;
   end;

  try
     ACBrECF1.FechaNaoFiscal(Observacao);
     Result := 0 ;
  except
     Result := 8 ;
  end;
end;

{ CancelaNaoFiscal - Cancela Cupom Não Fiscal
 Possíveis Respostas:
 0 - Tudo OK ;
 1 - Parametro necessário não foi Informado
 8 - Erro Indefinido
 9 - Componente não foi inicializado ; }
Function CancelaNaoFiscal : Integer ; StdCall ; export;
begin
  if not Ativo then
   begin
     Result := 9 ;
     Exit ;
   end;

  try
     ACBrECF1.CancelaNaoFiscal;
     Result := 0 ;
  except
     Result := 8 ;
  end;
end;

{ PoucoPapel - Retorna Status do Papel
 Possíveis Respostas:
 0 - Tudo OK ;
 1 - Parametro necessário não foi Informado
 8 - Erro Indefinido
 9 - Componente não foi inicializado ; }
Function PoucoPapel(var PoucoPapel: pchar) : Integer ; StdCall ; export;
begin
  if not Ativo then
   begin
     Result := 9 ;
     Exit ;
   end;

  try
     If ACBrECF1.PoucoPapel then begin
        PoucoPapel := pchar('True');
     end Else begin
        PoucoPapel := pchar('False');
     end;
     Result := 0 ;
  except
     Result := 8 ;
  end;
end;

{ HorarioVerao - Retorna Status do Horário de Verão
 Possíveis Respostas:
 0 - Tudo OK ;
 1 - Parametro necessário não foi Informado
 8 - Erro Indefinido
 9 - Componente não foi inicializado ; }
Function HorarioVerao(var HorarioVerao: pchar) : Integer ; StdCall ; export;
begin
  if not Ativo then
   begin
     Result := 9 ;
     Exit ;
   end;

  try
     If ACBrECF1.HorarioVerao then begin
        HorarioVerao := pchar('True');
     end Else begin
        HorarioVerao := pchar('False');
     end;
     Result := 0 ;
  except
     Result := 8 ;
  end;
end;

{ Arredonda - Retorna Status do Arredondamento
 Possíveis Respostas:
 0 - Tudo OK ;
 1 - Parametro necessário não foi Informado
 8 - Erro Indefinido
 9 - Componente não foi inicializado ; }
Function Arredonda(var Arredonda: pchar) : Integer ; StdCall ; export;
begin
  if not Ativo then
   begin
     Result := 9 ;
     Exit ;
   end;

  try
     If ACBrECF1.Arredonda then begin
        Arredonda := pchar('True');
     end Else begin
        Arredonda := pchar('False');
     end;
     Result := 0 ;
  except
     Result := 8 ;
  end;
end;

{ MFD - Retorna Se ECF tem MFD - memória Fita Detalhe
 Possíveis Respostas:
 0 - Tudo OK ;
 1 - Parametro necessário não foi Informado
 8 - Erro Indefinido
 9 - Componente não foi inicializado ; }
Function MFD(var MFD: pchar) : Integer ; StdCall ; export;
begin
  if not Ativo then
   begin
     Result := 9 ;
     Exit ;
   end;

  try
     If ACBrECF1.MFD then begin
        MFD := pchar('True');
     end Else begin
        MFD := pchar('False');
     end;
     Result := 0 ;
  except
     Result := 8 ;
  end;
end;


{ Termica - Retorna Se a ECF é térmica
 Possíveis Respostas:
 0 - Tudo OK ;
 1 - Parametro necessário não foi Informado
 8 - Erro Indefinido
 9 - Componente não foi inicializado ; }
Function Termica(var Termica: pchar) : Integer ; StdCall ; export;
begin
  if not Ativo then
   begin
     Result := 9 ;
     Exit ;
   end;

  try
     If ACBrECF1.Termica then begin
        Termica := pchar('True');
     end Else begin
        Termica := pchar('False');
     end;
     Result := 0 ;
  except
     Result := 8 ;
  end;
end;

{ Estado - Retorna Estado da ECF
 Possíveis Respostas:
 0 - Tudo OK ;
 1 - Parametro necessário não foi Informado
 8 - Erro Indefinido
 9 - Componente não foi inicializado ; }
Function Estado(var Estado: pchar) : Integer ; StdCall ; export;
begin
  if not Ativo then
   begin
     Result := 9 ;
     Exit ;
   end;

  try
     Estado := pchar( ACBrECF1.Estado);
     Result := 0 ;
  except
     Result := 8 ;
  end;
end;

{ AbreGaveta - Abre a Gaveta do ECF
 Possíveis Respostas:
 0 - Tudo OK ;
 1 - Parametro necessário não foi Informado
 8 - Erro Indefinido
 9 - Componente não foi inicializado ; }
Function AbreGaveta : Integer ; StdCall ; export;
begin
  if not Ativo then
   begin
     Result := 9 ;
     Exit ;
   end;

  try
     ACBrECF1.AbreGaveta;
     Result := 0 ;
  except
     Result := 8 ;
  end;
end;

{ GavetaAberta - Retorna Se a gaveta de dinheito está aberta
 Possíveis Respostas:
 0 - Tudo OK ;
 1 - Parametro necessário não foi Informado
 8 - Erro Indefinido
 9 - Componente não foi inicializado ; }
Function GavetaAberta(var GavetaAberta: pchar) : Integer ; StdCall ; export;
begin
  if not Ativo then
   begin
     Result := 9 ;
     Exit ;
   end;

  try
     If ACBrECF1.GavetaAberta then begin
        GavetaAberta := pchar('True');
     end Else begin
        GavetaAberta := pchar('False');
     end;
     Result := 0 ;
  except
     Result := 8 ;
  end;
end;

{ ImprimeCheque - Imprime Cheque
 Possíveis Respostas:
 0 - Tudo OK ;
 1 - Parametro necessário não foi Informado
 8 - Erro Indefinido
 9 - Componente não foi inicializado ; }
Function ImprimeCheque(Banco: String; Valor: Double; Favorecido,
  Cidade: String; Data: TDateTime; Observacao: String) : Integer ; StdCall ; export;
begin
  if not Ativo then
   begin
     Result := 9 ;
     Exit ;
   end;

  try
     ACBrECF1.ImprimeCheque(Banco,Valor,Favorecido,Cidade,Data,Observacao);
     Result := 0 ;
  except
     Result := 8 ;
  end;
end;

{ CancelaImpressaoCheque - Cancela a Impressão do Cheque
 Possíveis Respostas:
 0 - Tudo OK ;
 1 - Parametro necessário não foi Informado
 8 - Erro Indefinido
 9 - Componente não foi inicializado ; }
Function CancelaImpressaoCheque : Integer ; StdCall ; export;
begin
  if not Ativo then
   begin
     Result := 9 ;
     Exit ;
   end;

  try
     ACBrECF1.CancelaImpressaoCheque;
     Result := 0 ;
  except
     Result := 8 ;
  end;
end;

{ ChequePronto - Retorna Se o Cheque está pronto
 Possíveis Respostas:
 0 - Tudo OK ;
 1 - Parametro necessário não foi Informado
 8 - Erro Indefinido
 9 - Componente não foi inicializado ; }
Function ChequePronto(var ChequePronto: pchar) : Integer ; StdCall ; export;
begin
  if not Ativo then
   begin
     Result := 9 ;
     Exit ;
   end;

  try
     If ACBrECF1.ChequePronto then begin
        ChequePronto := pchar('True');
     end Else begin
        ChequePronto := pchar('False');
     end;
     Result := 0 ;
  except
     Result := 8 ;
  end;
end;

{ MudaHorarioVerao - Altera status de Horário de Verão
 Possíveis Respostas:
 0 - Tudo OK ;
 1 - Parametro necessário não foi Informado
 8 - Erro Indefinido
 9 - Componente não foi inicializado ; }
Function MudaHorarioVerao : Integer ; StdCall ; export;
begin
  if not Ativo then
   begin
     Result := 9 ;
     Exit ;
   end;

  try
     ACBrECF1.MudaHorarioVerao;
     Result := 0 ;
  except
     Result := 8 ;
  end;
end;

{ MudaArredondamento - Altera Arredondamento
 Possíveis Respostas:
 0 - Tudo OK ;
 1 - Parametro necessário não foi Informado
 8 - Erro Indefinido
 9 - Componente não foi inicializado ; }
Function MudaArredondamento(Arredondar: Boolean) : Integer ; StdCall ; export;
begin
  if not Ativo then
   begin
     Result := 9 ;
     Exit ;
   end;

  try
     ACBrECF1.MudaArredondamento(Arredondar);
     Result := 0 ;
  except
     Result := 8 ;
  end;
end;

{ PreparaTEF - Prepara ECF para o TEF
 Possíveis Respostas:
 0 - Tudo OK ;
 1 - Parametro necessário não foi Informado
 8 - Erro Indefinido
 9 - Componente não foi inicializado ; }
Function PreparaTEF : Integer ; StdCall ; export;
begin
  if not Ativo then
   begin
     Result := 9 ;
     Exit ;
   end;

  try
     ACBrECF1.PreparaTEF;
     Result := 0 ;
  except
     Result := 8 ;
  end;
end;

{ CorrigeEstadoErro - Corrige estado de erro do ECF 
 Possíveis Respostas:
 0 - Tudo OK ;
 1 - Parametro necessário não foi Informado
 8 - Erro Indefinido
 9 - Componente não foi inicializado ; }
Function CorrigeEstadoErro(ReducaoZ: Boolean) : Integer ; StdCall ; export;
begin
  if not Ativo then
   begin
     Result := 9 ;
     Exit ;
   end;

  try
     ACBrECF1.CorrigeEstadoErro(ReducaoZ);
     Result := 0 ;
  except
     Result := 8 ;
  end;
end;

{ AbreRelatorioGerencial - Abre Relatorio Gerencial 
 Possíveis Respostas:
 0 - Tudo OK ;
 1 - Parametro necessário não foi Informado
 8 - Erro Indefinido
 9 - Componente não foi inicializado ; }
Function AbreRelatorioGerencial : Integer ; StdCall ; export;
begin
  if not Ativo then
   begin
     Result := 9 ;
     Exit ;
   end;

  try
     ACBrECF1.AbreRelatorioGerencial;
     Result := 0 ;
  except
     Result := 8 ;
  end;
end;

{ RelatorioGerencial - Imprime Relatorio Gerencial
 Possíveis Respostas:
 0 - Tudo OK ;
 1 - Parametro necessário não foi Informado
 8 - Erro Indefinido
 9 - Componente não foi inicializado ; }
Function RelatorioGerencial(Relatorio: TStrings; Vias: Integer) : Integer ; StdCall ; export;
begin
  if not Ativo then
   begin
     Result := 9 ;
     Exit ;
   end;

  try
     ACBrECF1.RelatorioGerencial(Relatorio, Vias);
     Result := 0 ;
  except
     Result := 8 ;
  end;
end;

{ LinhaRelatorioGerencial - Imprime Linha do Relatorio Gerencial
 Possíveis Respostas:
 0 - Tudo OK ;
 1 - Parametro necessário não foi Informado
 8 - Erro Indefinido
 9 - Componente não foi inicializado ; }
Function LinhaRelatorioGerencial(Linha: AnsiString) : Integer ; StdCall ; export;
begin
  if not Ativo then
   begin
     Result := 9 ;
     Exit ;
   end;

  try
     ACBrECF1.LinhaRelatorioGerencial(Linha);
     Result := 0 ;
  except
     Result := 8 ;
  end;
end;

{ PulaLinhas - Pula Linhas no ECF
 Possíveis Respostas:
 0 - Tudo OK ;
 1 - Parametro necessário não foi Informado
 8 - Erro Indefinido
 9 - Componente não foi inicializado ; }
Function PulaLinhas(const NumLinhas: Integer) : Integer ; StdCall ; export;
begin
  if not Ativo then
   begin
     Result := 9 ;
     Exit ;
   end;

  try
     ACBrECF1.PulaLinhas(NumLinhas);
     Result := 0 ;
  except
     Result := 8 ;
  end;
end;

{ AbreCupomVinculado - Abre Cupom Vinculado
 Possíveis Respostas:
 0 - Tudo OK ;
 1 - Parametro necessário não foi Informado
 8 - Erro Indefinido
 9 - Componente não foi inicializado ; }
Function AbreCupomVinculado(COO, CodFormaPagto: String;
   Valor: Double) : Integer ; StdCall ; export;
begin
  if not Ativo then
   begin
     Result := 9 ;
     Exit ;
   end;

  try
     ACBrECF1.AbreCupomVinculado(COO, CodFormaPagto, Valor);
     Result := 0 ;
  except
     Result := 8 ;
  end;
end;

{ LinhaCupomVinculado - Imprime Linhas no Cupom Vinculado
 Possíveis Respostas:
 0 - Tudo OK ;
 1 - Parametro necessário não foi Informado
 8 - Erro Indefinido
 9 - Componente não foi inicializado ; }
Function LinhaCupomVinculado(Linha: AnsiString) : Integer ; StdCall ; export;
begin
  if not Ativo then
   begin
     Result := 9 ;
     Exit ;
   end;

  try
     ACBrECF1.LinhaCupomVinculado(Linha);
     Result := 0 ;
  except
     Result := 8 ;
  end;
end;

{ CupomVinculado - Imprime Cupom Vinculado
 Possíveis Respostas:
 0 - Tudo OK ;
 1 - Parametro necessário não foi Informado
 8 - Erro Indefinido
 9 - Componente não foi inicializado ; }
Function CupomVinculado(COO, CodFormaPagto: String;
  Valor: Double; Relatorio: TStrings; Vias: Integer) : Integer ; StdCall ; export;
begin
  if not Ativo then
   begin
     Result := 9 ;
     Exit ;
   end;

  try
     ACBrECF1.CupomVinculado(COO, CodFormaPagto, Valor, Relatorio, Vias);
     Result := 0 ;
  except
     Result := 8 ;
  end;
end;

{ FechaRelatorio - Fecha Cupom Vinculado
 Possíveis Respostas:
 0 - Tudo OK ;
 1 - Parametro necessário não foi Informado
 8 - Erro Indefinido
 9 - Componente não foi inicializado ; }
Function FechaRelatorio : Integer ; StdCall ; export;
begin
  if not Ativo then
   begin
     Result := 9 ;
     Exit ;
   end;

  try
     ACBrECF1.FechaRelatorio;
     Result := 0 ;
  except
     Result := 8 ;
  end;
end;

{ Ativar - Ativa Componente
 Possíveis Respostas:
 0 - Tudo OK ;
 1 - Parametro necessário não foi Informado
 8 - Erro Indefinido
 9 - Componente não foi inicializado ; }
Function Ativar : Integer ; StdCall ; export;
begin
  if not Ativo then
   begin
     Result := 9 ;
     Exit ;
   end;

  try
     ACBrECF1.Ativar;
     Result := 0 ;
  except
     Result := 8 ;
  end;
end;

{ Ativo - Retorna Status do Componente
 Possíveis Respostas:
 0 - Tudo OK ;
 1 - Parametro necessário não foi Informado
 8 - Erro Indefinido
 9 - Componente não foi inicializado ; }
Function isAtivo : Integer ; StdCall ; export;
begin
  if not Ativo then
   begin
     Result := 9 ;
     Exit ;
   end;

  try
     Result := 0 ;
  except
     Result := 8 ;
  end;
end;

{ Colunas - Retorna número de Colunas do ECF
 Possíveis Respostas:
 0 - Tudo OK ;
 1 - Parametro necessário não foi Informado
 8 - Erro Indefinido
 9 - Componente não foi inicializado ; }
Function Colunas(var cols : integer) : Integer ; StdCall ; export;
begin
  if not Ativo then
   begin
     Result := 9 ;
     Exit ;
   end;

  try
     cols := ACBrECF1.Colunas;
     Result := 0 ;
  except
     Result := 8 ;
  end;
end;

{ ComandoEnviado - Retorna o Ultimo Comando Enviado
 Possíveis Respostas:
 0 - Tudo OK ;
 1 - Parametro necessário não foi Informado
 8 - Erro Indefinido
 9 - Componente não foi inicializado ; }
Function ComandoEnviado(var cmd : pchar) : Integer ; StdCall ; export;
begin
  if not Ativo then
   begin
     Result := 9 ;
     Exit ;
   end;

  try
     cmd := pchar(ACBrECF1.ComandoEnviado);
     Result := 0 ;
  except
     Result := 8 ;
  end;
end;

{ RespostaComando - Retorna a resposta do ultimo comando
 Possíveis Respostas:
 0 - Tudo OK ;
 1 - Parametro necessário não foi Informado
 8 - Erro Indefinido
 9 - Componente não foi inicializado ; }
Function RespostaComando(var resp : pchar) : Integer ; StdCall ; export;
begin
  if not Ativo then
   begin
     Result := 9 ;
     Exit ;
   end;

  try
     resp := pchar(ACBrECF1.RespostaComando);
     Result := 0 ;
  except
     Result := 8 ;
  end;
end;

{ ModeloStr - Retorna o Modelo em String
 Possíveis Respostas:
 0 - Tudo OK ;
 1 - Parametro necessário não foi Informado
 8 - Erro Indefinido
 9 - Componente não foi inicializado ; }
Function ModeloStr(var ModeloStr : pchar) : Integer ; StdCall ; export;
begin
  if not Ativo then
   begin
     Result := 9 ;
     Exit ;
   end;

  try
     ModeloStr := pchar(ACBrECF1.ModeloStr);
     Result := 0 ;
  except
     Result := 8 ;
  end;
end;

{ Modelo - Retorna o Modelo
 Possíveis Respostas:
 0 - Tudo OK ;
 1 - Parametro necessário não foi Informado
 8 - Erro Indefinido
 9 - Componente não foi inicializado ; }
Function Modelo(var Modelo : pchar) : Integer ; StdCall ; export;
begin
  if not Ativo then
   begin
     Result := 9 ;
     Exit ;
   end;

  try
     Modelo := pchar(ACBrECF1.Modelo);
     Result := 0 ;
  except
     Result := 8 ;
  end;
end;

{ Porta - Retorna a Porta
 Possíveis Respostas:
 0 - Tudo OK ;
 1 - Parametro necessário não foi Informado
 8 - Erro Indefinido
 9 - Componente não foi inicializado ; }
Function Porta(var Porta : pchar) : Integer ; StdCall ; export;
begin
  if not Ativo then
   begin
     Result := 9 ;
     Exit ;
   end;

  try
     Porta := pchar(ACBrECF1.Porta);
     Result := 0 ;
  except
     Result := 8 ;
  end;
end;

{ TimeOut - Retorna o Timeout
 Possíveis Respostas:
 0 - Tudo OK ;
 1 - Parametro necessário não foi Informado
 8 - Erro Indefinido
 9 - Componente não foi inicializado ; }
Function TimeOut(var TimeOut : pchar) : Integer ; StdCall ; export;
begin
  if not Ativo then
   begin
     Result := 9 ;
     Exit ;
   end;

  try
     TimeOut := pchar(ACBrECF1.TimeOut);
     Result := 0 ;
  except
     Result := 8 ;
  end;
end;

{ EnviaComando - Envia Comando ao ECF no formato de cada ECF
 Possíveis Respostas:
 0 - Tudo OK ;
 1 - Parametro necessário não foi Informado
 8 - Erro Indefinido
 9 - Componente não foi inicializado ; }
Function EnviaComando(cmd: AnsiString; var resp : pchar ) : Integer ; StdCall ; export; overload;
begin
  if not Ativo then
   begin
     Result := 9 ;
     Exit ;
   end;

  try
     resp := pchar(ACBrECF1.EnviaComando(cmd));
     Result := 0 ;
  except
     Result := 8 ;
  end;
end;

{ EnviaComando - Envia Comando ao ECF no formato de cada ECF
 Possíveis Respostas:
 0 - Tudo OK ;
 1 - Parametro necessário não foi Informado
 8 - Erro Indefinido
 9 - Componente não foi inicializado ; }
Function EnviaComando(cmd: AnsiString; lTimeOut: Integer; var resp : pchar ) : Integer ; StdCall ; export; overload;
begin
  if not Ativo then
   begin
     Result := 9 ;
     Exit ;
   end;

  try
     resp := pchar(ACBrECF1.EnviaComando(cmd,lTimeOut));
     Result := 0 ;
  except
     Result := 8 ;
  end;
end;

{ LeituraMemoriaFiscal - Efetua Leitura da Memoria Fiscal
 Possíveis Respostas:
 0 - Tudo OK ;
 1 - Parametro necessário não foi Informado
 8 - Erro Indefinido
 9 - Componente não foi inicializado ; }
Function LeituraMemoriaFiscal(ReducaoInicial, ReducaoFinal: Integer;
   Simplificada : Boolean = False) : Integer ; StdCall ; export; overload;
begin
  if not Ativo then
   begin
     Result := 9 ;
     Exit ;
   end;

  try
     ACBrECF1.LeituraMemoriaFiscal(ReducaoInicial, ReducaoFinal,
                                   Simplificada);
     Result := 0 ;
  except
     Result := 8 ;
  end;
end;

{ LeituraMemoriaFiscal - Efetua Leitura da Memoria Fiscal
 Possíveis Respostas:
 0 - Tudo OK ;
 1 - Parametro necessário não foi Informado
 8 - Erro Indefinido
 9 - Componente não foi inicializado ; }
Function LeituraMemoriaFiscal(DataInicial, DataFinal: TDateTime;
   Simplificada : Boolean) : Integer ; StdCall ; export ; overload;
begin
  if not Ativo then
   begin
     Result := 9 ;
     Exit ;
   end;

  try
     ACBrECF1.LeituraMemoriaFiscal(DataInicial, DataFinal,
                                   Simplificada);
     Result := 0 ;
  except
     Result := 8 ;
  end;
end;

{ LeituraMemoriaFiscalSerial - Efetua Leitura da Memoria Fiscal
 Possíveis Respostas:
 0 - Tudo OK ;
 1 - Parametro necessário não foi Informado
 8 - Erro Indefinido
 9 - Componente não foi inicializado ; }
Function LeituraMemoriaFiscalSerial(ReducaoInicial,ReducaoFinal: Integer;
                                    Simplificada : Boolean; var Linhas : pchar ) : Integer ; StdCall ; export; overload;
   var v_linha : TStringList;
begin
  if not Ativo then
   begin
     Result := 9 ;
     Exit ;
   end;
  try
     v_linha := TStringList.Create;
     ACBrECF1.LeituraMemoriaFiscalSerial(ReducaoInicial, ReducaoFinal, v_linha,
                                   Simplificada);
     Linhas := pchar(v_linha);
     v_linha.Free;
     Result := 0 ;
  except
     Result := 8 ;
  end;
end;

{ LeituraMemoriaFiscalSerial - Efetua Leitura da Memoria Fiscal
 Possíveis Respostas:
 0 - Tudo OK ;
 1 - Parametro necessário não foi Informado
 8 - Erro Indefinido
 9 - Componente não foi inicializado ; }
Function LeituraMemoriaFiscalSerial(DataInicial,DataFinal: TDateTime; Simplificada : Boolean ;
                                    var Linhas : pchar ) : Integer ; StdCall ; export ; overload;
  var v_linha : TStringList;

begin
  if not Ativo then
   begin
     Result := 9 ;
     Exit ;
   end;

  try
     v_linha := TStringList.Create;
     ACBrECF1.LeituraMemoriaFiscalSerial(DataInicial, DataFinal, v_linha,
                                   Simplificada);
     Linhas := pchar(v_linha);
     v_linha.Free;
     Result := 0 ;
  except
     Result := 8 ;
  end;
end;


exports

DefineModelo, IdentificaConsumidor, AbreCupom, VendeItem, SubtotalizaCupom,
EfetuaPagamento, FechaCupom,
LeituraX, ReducaoZ,
CancelaCupom, CancelaItemVendido,
DataHora, Numcupom, Numloja, NumCRO, NumCRZ, NumECF, NumSerie, NumVersao,
DataMovimento, CNPJ, IE, NumCOOInicial, VendaBruta, GrandeTotal,
TotalCancelamentos, TotalDescontos, TotalAcrescimos,
TotalSubstituicaoTributaria, TotalNaoTributado,  TotalIsencao,
NumUltItem, DadosReducaoz, DadosUltimaReducaoZ, Aliquotas, LerTotaisAliquota,
ProgramaAliquota, AchaIcmsAliquota, FormasPagamento, LerTotaisFormaPagamento,
ProgramaFormaPagamento, AchaFPGDescricao, ComprovantesNaoFiscais,
LerTotaisComprovante, ProgramaComprovante, AchaCNFDescricao,
TestaPodeAbrirCupom,
SubTotal, TotalPago, Sangria, Suprimento, CortaPapel, AbreNaoFiscal,
RegistraItemNaoFiscal, SubtotalizaNaoFiscal, EfetuaPagamentoNaoFiscal,
FechaNaoFiscal, CancelaNaoFiscal, PoucoPapel, HorarioVerao, Arredonda,
MFD, Termica, Estado, AbreGaveta, GavetaAberta, ImprimeCheque,
CancelaImpressaoCheque, ChequePronto, MudaHorarioVerao, MudaArredondamento,
PreparaTEF, CorrigeEstadoErro, AbreRelatorioGerencial, RelatorioGerencial,
LinhaRelatorioGerencial, PulaLinhas, AbreCupomVinculado, LinhaCupomVinculado,
CupomVinculado, FechaRelatorio, Ativar, isAtivo, Colunas, ComandoEnviado,
RespostaComando, ModeloStr, Modelo, Porta, TimeOut;

exports EnviaComando(cmd: AnsiString; var resp : pchar ) overload;
exports EnviaComando(cmd: AnsiString; lTimeOut: Integer; var resp : pchar ) overload;

exports LeituraMemoriaFiscal(DataInicial, DataFinal: TDateTime;
   Simplificada : Boolean) overload;
exports LeituraMemoriaFiscal(ReducaoInicial, ReducaoFinal: Integer;
   Simplificada : Boolean = False)  overload ;

exports LeituraMemoriaFiscalSerial(DataInicial, DataFinal: TDateTime;
   Simplificada : Boolean; const Linhas : pchar = nil) overload;
exports LeituraMemoriaFiscalSerial(ReducaoInicial, ReducaoFinal: Integer;
   Simplificada : Boolean = False; const Linhas : pchar = nil)  overload ;

end.
