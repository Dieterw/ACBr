{******************************************************************************}
{ Projeto: Componentes ACBr                                                    }
{  Biblioteca multiplataforma de componentes Delphi para interação com equipa- }
{ mentos de Automação Comercial utilizados no Brasil                           }
{                                                                              }
{ Direitos Autorais Reservados (c) 2009 Daniel Simoes de Almeida               }
{                                                                              }
{ Colaboradores nesse arquivo:   Juliana Rodrigues Prado                       }
{                                                                              }
{  Você pode obter a última versão desse arquivo na pagina do  Projeto ACBr    }
{ Componentes localizado em      http://www.sourceforge.net/projects/acbr      }
{                                                                              }
{  Esta biblioteca é software livre; você pode redistribuí-la e/ou modificá-la }
{ sob os termos da Licença Pública Geral Menor do GNU conforme publicada pela  }
{ Free Software Foundation; tanto a versão 2.1 da Licença, ou (a seu critério) }
{ qualquer versão posterior.                                                   }
{                                                                              }
{  Esta biblioteca é distribuída na expectativa de que seja útil, porém, SEM   }
{ NENHUMA GARANTIA; nem mesmo a garantia implícita de COMERCIABILIDADE OU      }
{ ADEQUAÇÃO A UMA FINALIDADE ESPECÍFICA. Consulte a Licença Pública Geral Menor}
{ do GNU para mais detalhes. (Arquivo LICENÇA.TXT ou LICENSE.TXT)              }
{                                                                              }
{  Você deve ter recebido uma cópia da Licença Pública Geral Menor do GNU junto}
{ com esta biblioteca; se não, escreva para a Free Software Foundation, Inc.,  }
{ no endereço 59 Temple Street, Suite 330, Boston, MA 02111-1307 USA.          }
{ Você também pode obter uma copia da licença em:                              }
{ http://www.opensource.org/licenses/lgpl-license.php                          }
{                                                                              }
{ Daniel Simões de Almeida  -  daniel@djsystem.com.br  -  www.djsystem.com.br  }
{              Praça Anita Costa, 34 - Tatuí - SP - 18270-410                  }
{                                                                              }
{******************************************************************************}

{$I ACBr.inc}

unit ACBrBancoBanrisul;

interface

uses
  Classes, SysUtils, ACBrBoleto,
{$IFDEF COMPILER6_UP}dateutils{$ELSE}ACBrD5{$ENDIF};

type

  { TACBrBancoBanrisul }

  TACBrBanrisul=class(TACBrBancoClass)
  Protected
  Public
    constructor create(AOwner: TACBrBanco);
    function MontarCodigoBarras(const ACBrTitulo: TACBrTitulo): string; Override;
    function MontarCampoNossoNumero(const ACBrTitulo: TACBrTitulo): string; Override;
    function MontarCampoCodigoCedente(const ACBrTitulo: TACBrTitulo): string; Override;
    function GerarRegistroHeader400(NumeroRemessa: Integer): string; Override;
    function GerarRegistroTransacao400(ACBrTitulo: TACBrTitulo): string; Override;
    function GerarRegistroTrailler400(ARemessa: TStringList): string; Override;
    function CalculaDigitosChaveASBACE(ChaveASBACESemDigito: string): string;
    procedure LerRetorno400(ARetorno: TStringList); override;
    function GerarRegistroHeader240(NumeroRemessa: Integer): String; override;
    function GerarRegistroTransacao240(ACBrTitulo: TACBrTitulo): String; override;
    function GerarRegistroTrailler240(ARemessa: TStringList): String; override;
    procedure LerRetorno240(ARetorno: TStringList); override;
  end;

implementation

uses ACBrUtil, StrUtils, ACBrValidador;

var
  aTotal: Extended;

{ TACBrBancoBanrisul }

constructor TACBrBanrisul.create(AOwner: TACBrBanco);
begin
  inherited create(AOwner);
  fpDigito:=8;
  fpNome:='Banrisul';
  fpTamanhoMaximoNossoNum:=8;
end;

function Modulo11(Valor: string; Base: Integer=9; Resto: boolean=false): string;
var
  Soma: integer;
  Contador, Peso, Digito: integer;
begin
  Soma:=0;
  Peso:=2;
  for Contador:=Length(Valor)downto 1 do
  begin
    Soma:=Soma+(StrToInt(Valor[Contador])*Peso);
    if Peso<Base then
      Peso:=Peso+1
    else
      Peso:=2;
  end;

  if Resto then
    Result:=IntToStr(Soma mod 11)
  else
  begin
    Digito:=11-(Soma mod 11);
    if (Digito>9) then
      Digito:=0;
    Result:=IntToStr(Digito);
  end
end;

function TACBrBanrisul.CalculaDigitosChaveASBACE(ChaveASBACESemDigito: string): string;
{Calcula os 2 dígitos usados na CHAVE ASBACE - Código usado por bancos estaduais}
var
  Digito1, Digito2: integer;

  function CalcularDigito1(ChaveASBACESemDigito: string): integer;
   {
    Calcula o primeiro dígito.
    O cálculo é parecido com o da rotina Modulo10. Porém, não faz diferença o
    número de dígitos de cada subproduto.
    Se o resultado da operação for 0 (ZERO) o dígito será 0 (ZERO). Caso contrário,
    o dígito será igual a 10 - Resultado.
   }
  var
    Auxiliar, Soma, Contador, Peso, Digito1: integer;
  begin
    Soma:=0;
    Peso:=2;
    for Contador:=Length(ChaveASBACESemDigito)downto 1 do
    begin
      Auxiliar:=(StrToInt(ChaveASBACESemDigito[Contador])*Peso);
      if Auxiliar>9 then
        Auxiliar:=Auxiliar-9;
      Soma:=Soma+Auxiliar;
      if Peso=1 then
        Peso:=2
      else
        Peso:=1;
    end;

    Digito1:=Soma mod 10;
    if (Digito1=0) then
      Result:=Digito1
    else
      Result:=10-Digito1;
  end;

  function CalcularDigito2(ChaveASBACESemDigito: string; var Digito1: integer):
      integer;
   {Calcula o segundo dígito}
  var
    Digito2: integer;
    ChaveASBACEComDigito1: string;
  begin
    ChaveASBACEComDigito1:=ChaveASBACESemDigito+IntToStr(Digito1);
    Digito2:=StrToInt(Modulo11(ChaveASBACEComDigito1, 7, true));
    {Se dígito2 = 1, deve-se incrementar o dígito1 e recalcular o dígito2}
    if Digito2=1 then
    begin
      Digito1:=Digito1+1;
         {Se, após incrementar o dígito1, ele ficar maior que 9, deve-se
          substituí-lo por 0}
      if Digito1>9 then
        Digito1:=0;
      Digito2:=CalcularDigito2(ChaveASBACESemDigito, Digito1);
    end
    else if Digito2>1 then
    begin
      Digito2:=11-Digito2;
    end;

    Result:=Digito2;
  end;

begin
  Digito1:=CalcularDigito1(ChaveASBACESemDigito);
  Digito2:=CalcularDigito2(ChaveASBACESemDigito, Digito1);

  Result:=IntToStr(Digito1)+IntToStr(Digito2);
end;

function TACBrBanrisul.MontarCodigoBarras(const ACBrTitulo: TACBrTitulo): string;
var
  CodigoBarras, FatorVencimento, DigitoCodBarras, CampoLivre, Modalidade: string;
  DigitoNum: Integer;
begin
  with ACBrTitulo do
  begin
     if StrToIntDef(Carteira, 8)= 8 then
        Modalidade:='21'
     else
        Modalidade:='11';

     FatorVencimento:=CalcularFatorVencimento(ACBrTitulo.Vencimento);

     CampoLivre:= Modalidade +
                  padR(ACBrBoleto.Cedente.Agencia, 3, '0')+{ Código agência (cooperativa) }
                  padR(ACBrBoleto.Cedente.Conta, 7, '0')+{ Código cedente = Número da conta }
                  padR(NossoNumero, 8, '0')+{ Nosso número }
                  '041';

     {Calculando Módulo 10}
     Modulo.MultiplicadorInicial:= 1;
     Modulo.MultiplicadorFinal:= 2;
     Modulo.MultiplicadorAtual:= 2;
     Modulo.FormulaDigito := frModulo10;
     Modulo.Documento := CampoLivre;
     Modulo.Calcular;
     CampoLivre := CampoLivre +  IntToStr(Modulo.DigitoFinal);

     {Calculando Módulo 11}
     Modulo.CalculoPadrao;
     Modulo.MultiplicadorFinal:= 7;
     Modulo.Documento:= CampoLivre;
     Modulo.Calcular;

     if (Modulo.ModuloFinal >= 10) or (Modulo.ModuloFinal < 1) then
        CampoLivre := CampoLivre +'1'
     else
        CampoLivre := CampoLivre + IntToStr(Modulo.DigitoFinal);

     CodigoBarras:= PadR(IntToStr(Numero), 3, '0')+'9'+
                    FatorVencimento+{ Fator de vencimento, não obrigatório }
                    IntToStrZero(Round(ACBrTitulo.ValorDocumento*100), 10)+{ valor do documento }
                    CampoLivre; { Campo Livre }

     DigitoCodBarras:=CalcularDigitoCodigoBarras(CodigoBarras);
     DigitoNum:=StrToIntDef(DigitoCodBarras, 0);

     if (DigitoNum = 0) or (DigitoNum > 9) then
        DigitoCodBarras:='1';
  end;

  Result:=PadR(IntToStr(Numero), 3, '0')+'9'+DigitoCodBarras+Copy(CodigoBarras, 5, 39);
end;

function TACBrBanrisul.MontarCampoNossoNumero(const ACBrTitulo: TACBrTitulo): string;
begin
  Result:=PadR(ACBrTitulo.NossoNumero, 8, '0');
  result:=Result+'.'+CalculaDigitosChaveASBACE(Result);
end;

function TACBrBanrisul.MontarCampoCodigoCedente(const ACBrTitulo: TACBrTitulo): string;
begin
  Result:=copy(ACBrTitulo.ACBrBoleto.Cedente.Agencia, 1, 4)+'-'+
    copy(ACBrTitulo.ACBrBoleto.Cedente.Agencia, 5, 1)+
    ACBrTitulo.ACBrBoleto.Cedente.AgenciaDigito+'/'+
    ACBrTitulo.ACBrBoleto.Cedente.CodigoCedente;
end;

function TACBrBanrisul.GerarRegistroHeader400(NumeroRemessa: Integer): string;
var
  cd: string;
begin
  with ACBrBanco.ACBrBoleto.Cedente do
  begin
    cd:=StringReplace(CodigoCedente, '-', '', [rfReplaceAll]);
    cd:=StringReplace(cd, '/', '', [rfReplaceAll]);
    cd:=StringReplace(cd, '.', '', [rfReplaceAll]);
    Result:='0'+// ID do Registro
      '1'+// ID do Arquivo( 1 - Remessa)
      'REMESSA'+// Literal de Remessa
      space(17)+// brancos 17
      padR(copy(Agencia, 1, 4)+cd, 13, '0')+// Codigo da Empresa no Banco
      space(7)+
      padR(Nome, 30, ' ')+// nome do Cedente
      '041'+// Número do banco
      padL('BANRISUL', 8)+// Código e Nome do Banco(041 - Banrisul)
      space(7)+//brancos
      FormatDateTime('ddmmyy', Now)+// Data de geração do arquivo
      Space(9)+// Filler - Brancos
      space(4)+//8808 teste carteira R S X ou 0808 producao carteira R S X
      ' '+
      space(1)+//teste X producao P para carteiras R S X
      ' '+
      space(10)+
      Space(268)+// Filler - Brancos
      IntToStrZero(1, 6); // Nr. Sequencial de Remessa + brancos + Contador

    Result:=UpperCase(Result);
  end;
end;

function TACBrBanrisul.GerarRegistroTransacao400(ACBrTitulo: TACBrTitulo): string;
var
  Ocorrencia, Protesto, cd: string;
  TipoSacado, aTipoAceite: string;
  TipoBoleto: Char;
begin
  aTotal:=0;
  Protesto := '';
  with ACBrTitulo do
  begin

      {Pegando Código da Ocorrencia}
    case OcorrenciaOriginal.Tipo of
      toRemessaBaixar: Ocorrencia:='02'; {Pedido de Baixa}
      toRemessaConcederAbatimento: Ocorrencia:='04'; {Concessão de Abatimento}
      toRemessaCancelarAbatimento: Ocorrencia:='05'; {Cancelamento de Abatimento concedido}
      toRemessaAlterarVencimento: Ocorrencia:='06'; {Alteração de vencimento}
         //toRemessaAlterarNumeroControle         : Ocorrencia := '08'; {Alteração de seu número}
      toRemessaProtestar: Ocorrencia:='09'; {Pedido de protesto}
      toRemessaCancelarIntrucaoProtestoBaixa: Ocorrencia:='18'; {Sustar protesto e baixar}
      toRemessaCancelarInstrucaoProtesto: Ocorrencia:='19'; {Sustar protesto e manter na carteira}
      toRemessaOutrasOcorrencias: Ocorrencia:='31'; {Alteração de Outros Dados}
    else
      Ocorrencia:='01'; {Remessa}
    end;

      {Pegando Tipo de Boleto}
    if ACBrBoleto.Cedente.ResponEmissao=tbCliEmite then
      TipoBoleto:='2'
    else
      TipoBoleto:='1';

    { Pegando o Aceite do Titulo }
    case Aceite of
      atSim: ATipoAceite:='A';
      atNao: ATipoAceite:='N';
    end;

    {Pegando Tipo de Sacado}
    case Sacado.Pessoa of
      pFisica: TipoSacado:='01';
      pJuridica: TipoSacado:='02';
    else
      TipoSacado:='99';
    end;

    with ACBrBoleto do
    begin
      cd:=StringReplace(Cedente.CodigoCedente, '-', '', [rfReplaceAll]);
      cd:=StringReplace(cd, '/', '', [rfReplaceAll]);
      cd:=StringReplace(cd, '.', '', [rfReplaceAll]);

      Result:='1'+// ID Registro
        space(16)+
        padL(copy(Cedente.Agencia, 1, 4)+cd, 13, '0')+// Codigo da Empresa no Banco
        space(7)+
        space(25)+
        PadL(NossoNumero, 8, '0')+CalculaDigitosChaveASBACE(NossoNumero)+
        space(32)+
        space(3)+
        '1'+
        '01'+
        padR(NumeroDocumento, 10)+
        FormatDateTime('ddmmyy', Vencimento)+
        IntToStrZero(Round(ValorDocumento*100), 13)+
        '041'+
        space(5)+
        Carteira+
        aTipoAceite+
        FormatDateTime('ddmmyy', DataDocumento)+// Data de Emissão
        PadR(Instrucao1, 2)+
        PadR(Instrucao2, 2)+
        '1'+
        FormatCurr('000000000000', ValorMoraJuros*100)+
        '000000'+
        '0000000000000'+
        '0000000000000'+
        '0000000000000'+
        TipoSacado+
        PadL(OnlyNumber(Sacado.CNPJCPF), 14, '0')+
        PadL(Sacado.NomeSacado, 35)+
        space(5)+
        PadL(Sacado.Logradouro+' '+
        Sacado.Numero+' '+
        Sacado.Complemento, 40)+
        space(7)+
        '000'+
        '00'+
        PadL(Sacado.CEP, 8, '0')+
        PadL(Sacado.Cidade, 15)+
        PadL(Sacado.UF, 2)+
        '0000'+
        space(1)+
        '0000000000000'+
        PadR(Protesto, 2, '0')+
        space(23)+
        IntToStrZero(ListadeBoletos.IndexOf(ACBrTitulo)+2, 6);

      aTotal:=aTotal+ValorDocumento;

      Result:=UpperCase(Result);
    end;
  end;
end;

function TACBrBanrisul.GerarRegistroTrailler400(ARemessa: TStringList): string;
begin
  Result:='9'+
    space(26)+
    FormatCurr('0000000000000', aTotal*100)+
    space(354)+
    IntToStrZero(ARemessa.Count+1, 6); // Contador de Registros

  Result:=UpperCase(Result);
end;

function TACBrBanrisul.GerarRegistroHeader240(
  NumeroRemessa: Integer): String;
var TipoInsc: String;
begin
  case ACBrBanco.ACBrBoleto.Cedente.TipoInscricao of
     pFisica:   TipoInsc := '1';
     pJuridica: TipoInsc := '2';
  else 
     TipoInsc := '9';
  end;

  with ACBrBanco.ACBrBoleto.Cedente do 
  begin
     Result := '041'+
               DupeString('0', 5) +
               DupeString(' ', 9) +
               TipoInsc +
               OnlyNumber(CNPJCPF) +
               padR(Agencia, 4, '0') +
               padR(OnlyNumber(CodigoCedente), 9, '0') +
               DupeString(' ', 7) +
               '00'+
               padR(Agencia, 3, '0') +
               ' 0000000000000 '+
               padL(Nome, 30) +
               padL(UpperCase(ACBrBanco.Nome), 40) +
               '1'+
               FormatDateTime('ddmmyyyyhhnnss', Now) +
               IntToStrZero(NumeroRemessa, 6) +
               '040'+
               DupeString('0', 5) +
               DupeString(' ', 69);

     Result := Result + #13#10 +
               '04100011R0100020 '+
               TipoInsc +
               '0' +
               OnlyNumber(CNPJCPF) +
               padR(Agencia, 4, '0') +
               padR(OnlyNumber(CodigoCedente), 9, '0') +
               DupeString(' ', 7) +
               padR(Agencia, 5, '0') +
               '0' +
               DupeString(' ', 12) +
               '00' +
               padR(Nome, 30) +
               DupeString(' ', 80) +
               IntToStrZero(NumeroRemessa, 8) +
               FormatDateTime('ddmmyyyy', Now) +
               DupeString('0', 8) +
               DupeString(' ', 33);
  end;
end;

function TACBrBanrisul.GerarRegistroTrailler240(
  ARemessa: TStringList): String;
var Valor: Currency;
    i, Ps: Integer;
begin
   Valor := 0.00;
   Ps := 1;
   for i := 0 to ARemessa.Count - 1 do 
   begin
      if (ARemessa.Strings[i][14] = 'P') then
         Valor := Valor + (StrToCurr(Copy(ARemessa.Strings[i], 86, 15)) / 100);

      while (Pos('*****', ARemessa.Strings[i]) > 0) do 
      begin
         ARemessa.Strings[i] := StringReplace(ARemessa.Strings[i], '*****', IntToStrZero(Ps, 5), []);
         Inc(Ps);
      end;
   end;
   Result := '04100015'+
             DupeString(' ', 9) +
             IntToStrZero(ARemessa.Count * 2, 6) +
             IntToStrZero(((ARemessa.Count * 2) - 2) div 2, 6) +
             padR(StringReplace(FormatFloat('#####0.00', Valor), ',', '', []), 17, '0') +
             DupeString('0', 77) +
             DupeString(' ', 117);

   Result := Result + #13#10 +
             '04199999' +
             DupeString(' ', 9) +
             '000001' +
             IntToStrZero((ARemessa.Count + 1) * 2, 6) +
             DupeString('0', 6) +
             DupeString(' ', 205);
end;

function TACBrBanrisul.GerarRegistroTransacao240(
  ACBrTitulo: TACBrTitulo): String;
var
    aAceite, DiasProt, Juros, TipoInscSacado, Ocorrencia: String;
begin
   with ACBrTitulo do begin
      case Aceite of
         atSim: aAceite := 'S';
         atNao: aAceite := 'N';
      end;

      DiasProt := '00';

      if (DataProtesto > 0) then
         DiasProt := padR(IntToStr(DaysBetween(Vencimento, DataProtesto)), 2, '0');
       
      if (DiasProt = '00') then
         DiasProt := '0'+ DiasProt
      else 
         DiasProt := '1'+ DiasProt;

      if (DataMoraJuros > 0) then
         Juros := '1'+ FormatDateTime('ddmmyyyy', DataMoraJuros) + padR(StringReplace(FormatFloat('#####0.00', ValorMoraJuros), ',', '', []), 15, '0')
      else
         Juros := DupeString('0', 24);

      case Sacado.Pessoa of
         pFisica:   TipoInscSacado := '1';
         pJuridica: TipoInscSacado := '2';
      end;

      case OcorrenciaOriginal.Tipo of
         toRemessaBaixar:          Ocorrencia := '02'; {Pedido de Baixa}
         toRemessaConcederAbatimento: Ocorrencia := '04'; {Concessão de Abatimento}
         toRemessaCancelarAbatimento: Ocorrencia := '05'; {Cancelamento de Abatimento concedido}
         toRemessaAlterarVencimento:  Ocorrencia := '06'; {Alteração de vencimento}
         toRemessaProtestar:          Ocorrencia := '09'; {Pedido de protesto}
         toRemessaCancelarIntrucaoProtestoBaixa: Ocorrencia := '18'; {Sustar protesto e baixar}
         toRemessaCancelarInstrucaoProtesto:     Ocorrencia := '19'; {Sustar protesto e manter na carteira}
         toRemessaOutrasOcorrencias:  Ocorrencia := '31'; {Alteração de Outros Dados}
      else
         Ocorrencia := '01'; {Remessa}
      end;

      Result := '04100013' +
                DupeString('*', 5) +
                'P ' +
                Ocorrencia +
                DupeString(' ', 20) +
                padR(OnlyNumber(MontarCampoNossoNumero(ACBrTitulo)), 10, '0') +
                DupeString(' ', 10) +
                Carteira +
                '1020' +
                padL(NumeroDocumento, 15) +
                FormatDateTime('ddmmyyyy', Vencimento) +
                padR(StringReplace(FormatFloat('#####0.00', ValorDocumento), ',', '', []), 15, '0') +
                '00000002' +
                aAceite +
                FormatDateTime('ddmmyyyy', DataProcessamento) +
                Juros +
                DupeString('0', 39) +
                DupeString(' ', 15) +
                padL(NumeroDocumento, 15) +
                DupeString(' ', 10) +
                DiasProt +
                '110009' +
                DupeString('0', 10) +' ';

      Result := Result + #13#10 +
                '04100013' +
                DupeString('*', 5) +
                'Q ' +
                Ocorrencia +
                TipoInscSacado +
                padR(OnlyNumber(Sacado.CNPJCPF), 15, '0') +
                padL(Sacado.NomeSacado, 40) +
                padL(Sacado.Logradouro, 40) +
                padL(Sacado.Bairro, 15) +
                StringReplace(Sacado.CEP, '-', '', []) +
                padL(Sacado.Cidade, 15) +
                Sacado.UF +
                DupeString('0', 16) +
                DupeString(' ', 40) +
                '000' +
                DupeString(' ', 28);

      if (PercentualMulta > 0) then
         Result := Result + #13#10 +
                   '04100013' +
                   DupeString('*', 5) +
                   'R ' +
                   Ocorrencia +
                   DupeString('0', 48) +
                   '1' +
                   FormatDateTime('ddmmyyyy', Vencimento) +
                   padR(StringReplace(FormatFloat('#####0.00', PercentualMulta * ValorDocumento / 100), ',', '', []), 15, '0') +
                   DupeString(' ', 90) +
                   DupeString('0', 28) +
                   DupeString(' ', 33);
   end;
end;

procedure TACBrBanrisul.LerRetorno240(ARetorno: TStringList);
begin
  inherited;

end;

procedure TACBrBanrisul.LerRetorno400(ARetorno: TStringList);
begin
  inherited;

end;

end.

