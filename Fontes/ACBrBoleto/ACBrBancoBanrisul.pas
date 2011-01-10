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
    function Modulo11BRB(Valor: string; Base: Integer=9): string;
  end;

implementation

uses ACBrUtil, StrUtils;

var
  aTotal: Extended;

{ TACBrBancoSicredi }

constructor TACBrBanrisul.create(AOwner: TACBrBanco);
begin
  inherited create(AOwner);
  fpDigito:=8;
  fpNome:='Banrisul';
  fpTamanhoMaximoNossoNum:=8;
end;

function Modulo10(Valor: string): string;
var
  Auxiliar: string;
  Contador, Peso: integer;
  Digito: integer;
begin
  Auxiliar:='';
  Peso:=2;
  for Contador:=Length(Valor)downto 1 do
  begin
    Auxiliar:=IntToStr(StrToInt(Valor[Contador])*Peso)+Auxiliar;
    if Peso=1 then
      Peso:=2
    else
      Peso:=1;
  end;

  Digito:=0;
  for Contador:=1 to Length(Auxiliar) do
  begin
    Digito:=Digito+StrToInt(Auxiliar[Contador]);
  end;
  Digito:=10-(Digito mod 10);
  if (Digito>9) then
    Digito:=0;
  Result:=IntToStr(Digito);
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

function TACBrBanrisul.Modulo11BRB(Valor: string; Base: Integer=9): string;
var
  Soma: integer;
  Contador, Peso: integer;
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

  Soma:=Soma mod 11;
  case Soma of
    0, 1, 10: Result:='1';
  else
    Result:=IntToStr(11-Soma);
  end;
end;

function TACBrBanrisul.MontarCodigoBarras(const ACBrTitulo: TACBrTitulo): string;
var
  CodigoBarras, FatorVencimento, DigitoCodBarras, CampoLivre, Modalidade: string;
  DigitoNum: Integer;
begin
  with ACBrTitulo do
  begin
    if StrToIntDef(Carteira, 8)=8 then
      Modalidade:='21'
    else
      Modalidade:='11';

    FatorVencimento:=CalcularFatorVencimento(ACBrTitulo.Vencimento);
    CampoLivre:=Modalidade+
      padR(ACBrBoleto.Cedente.Agencia, 4, '0')+{ Código agência (cooperativa) }
      padR(ACBrBoleto.Cedente.Conta, 7, '0')+{ Código cedente = Número da conta }
      padR(NossoNumero, 8, '0')+{ Nosso número }
      '40';
    CampoLivre:=CampoLivre+Modulo10(CampoLivre);
    CampoLivre:=CampoLivre+Modulo11BRB(CampoLivre, 7);

    CodigoBarras:=PadR(IntToStr(Numero), 3, '0')+'9'+
      FatorVencimento+{ Fator de vencimento, não obrigatório }
      IntToStrZero(Round(ACBrTitulo.ValorDocumento*100), 10)+{ valor do documento }
      CampoLivre; { Campo Livre }

    DigitoCodBarras:=CalcularDigitoCodigoBarras(CodigoBarras);
    DigitoNum:=StrToIntDef(DigitoCodBarras, 0);

    if (DigitoNum=0)or(DigitoNum>9) then
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
        PadR(Carteira, 2, '0')+
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
        PadL(Sacado.CNPJCPF, 14, '0')+
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

end.

