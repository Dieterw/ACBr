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

unit ACBrBancoBrasil;

interface

uses
  Classes, SysUtils, ACBrBoleto,
  {$IFDEF COMPILER6_UP} DateUtils {$ELSE} ACBrD5, FileCtrl {$ENDIF};

type
  { TACBrBancoBrasil}

  TACBrBancoBrasil = class(TACBrBancoClass)
   protected
   private
    function FormataNossoNumero(const ACBrTitulo :TACBrTitulo): String;
   public
    Constructor create(AOwner: TACBrBanco);
    function CalcularDigitoVerificador(const ACBrTitulo: TACBrTitulo ): String; override;
    function MontarCodigoBarras(const ACBrTitulo : TACBrTitulo): String; override;
    function MontarCampoCodigoCedente(const ACBrTitulo: TACBrTitulo): String; override;
    function MontarCampoNossoNumero(const ACBrTitulo :TACBrTitulo): String; override;
    function GerarRegistroHeader240(NumeroRemessa : Integer): String; override;
    function GerarRegistroTransacao240(ACBrTitulo : TACBrTitulo): String; override;
    function GerarRegistroTrailler240(ARemessa : TStringList): String;  override;
    procedure GerarRegistroHeader400(NumeroRemessa : Integer; aRemessa:TStringList); override;
    procedure GerarRegistroTransacao400(ACBrTitulo : TACBrTitulo; aRemessa: TStringList); override;
    procedure GerarRegistroTrailler400(ARemessa : TStringList);  override;
    function TipoOcorrenciaToDescricao(const TipoOcorrencia: TACBrTipoOcorrencia) : String; override;
    function CodOcorrenciaToTipo(const CodOcorrencia:Integer): TACBrTipoOcorrencia; override;
    function TipoOCorrenciaToCod(const TipoOcorrencia: TACBrTipoOcorrencia):String; override;
    Procedure LerRetorno240(ARetorno:TStringList); override;
    procedure LerRetorno400(ARetorno: TStringList); override;
    function CodMotivoRejeicaoToDescricao(
      const TipoOcorrencia: TACBrTipoOcorrencia; CodMotivo: Integer): String; override;

    function CalcularTamMaximoNossoNumero(const Carteira : String; NossoNumero : String = ''): Integer; override;
   end;

implementation

uses ACBrUtil, StrUtils, Variants;

constructor TACBrBancoBrasil.create(AOwner: TACBrBanco);
begin
   inherited create(AOwner);
   fpDigito := 9;
   fpNome   := 'Banco do Brasil';
   fpNumero := 001;
   fpTamanhoMaximoNossoNum := 0;
   fpTamanhoConta   := 12;
   fpTamanhoAgencia := 4;
   fpTamanhoCarteira:= 2;

end;

function TACBrBancoBrasil.CalcularDigitoVerificador(const ACBrTitulo: TACBrTitulo ): String;
begin
   Result := '0';

   Modulo.CalculoPadrao;
   Modulo.MultiplicadorFinal   := 2;
   Modulo.MultiplicadorInicial := 9;
   Modulo.Documento := FormataNossoNumero(ACBrTitulo);
   Modulo.Calcular;

   if Modulo.ModuloFinal >= 10 then
      Result:= 'X'
   else
      Result:= IntToStr(Modulo.ModuloFinal);
end;

function TACBrBancoBrasil.CalcularTamMaximoNossoNumero(
  const Carteira: String; NossoNumero : String = ''): Integer;
var
  wCarteira   : String;
  wTamConvenio: Integer;
begin
   Result := 10;

   if (ACBrBanco.ACBrBoleto.Cedente.Convenio = '') then
      raise Exception.Create(ACBrStr('Banco do Brasil requer que a Convênio do Cedente '+
                                     'seja informado.'));

   if (Carteira = '') then
      raise Exception.Create(ACBrStr('Banco do Brasil requer que a carteira seja '+
                                     'informada antes do Nosso Número.'));

   wCarteira:= Trim(Carteira);
   wTamConvenio:= Length(Trim(ACBrBanco.ACBrBoleto.Cedente.Convenio));

   if (Length(trim(NossoNumero)) > 10) and (wTamConvenio = 6) and
      ((wCarteira = '16') or (wCarteira = '18')) then
      Result:= 17
   else if (wTamConvenio <= 4) then
      Result := 7
   else if (wTamConvenio > 4) and (wTamConvenio <= 6) then
      Result := 5
   else if (wTamConvenio = 7) then
      Result := 10;
end;

function TACBrBancoBrasil.FormataNossoNumero(const ACBrTitulo :TACBrTitulo): String;
var
  ANossoNumero, AConvenio, wNossoNumero : String;
  wTamNossoNum: Integer;
begin
   with ACBrTitulo do
   begin
      AConvenio    := ACBrBoleto.Cedente.Convenio;
      ANossoNumero := IntToStr(StrToInt64(OnlyNumber(NossoNumero)));
      wNossoNumero := OnlyNumber(NossoNumero);
      wTamNossoNum := CalcularTamMaximoNossoNumero(Carteira,wNossoNumero);
      
      if ((ACBrTitulo.Carteira = '16') or (ACBrTitulo.Carteira = '18')) and
         (Length(AConvenio) = 6) and (wTamNossoNum = 17) then
         ANossoNumero := padR(ANossoNumero, 17, '0')
      else if Length(AConvenio) <= 4 then
          ANossoNumero := padR(AConvenio, 4, '0') + padR(ANossoNumero, 7, '0')
      else if (Length(AConvenio) > 4) and (Length(AConvenio) <= 6) then
          ANossoNumero := padR(AConvenio, 6, '0') + padR(ANossoNumero, 5, '0')
      else if (Length(AConvenio) = 7) and (ACBrTitulo.Carteira = '11') then
          ANossoNumero := padR('0', 7, '0') + padR(ANossoNumero, 10, '0')
      else if (Length(AConvenio) = 7) and ((ACBrTitulo.Carteira <> '11')) then
          ANossoNumero := padR(AConvenio, 7, '0') + padR(ANossoNumero, 10, '0');
   end;
   Result := ANossoNumero;
end;


function TACBrBancoBrasil.MontarCodigoBarras(const ACBrTitulo : TACBrTitulo): String;
var
  CodigoBarras, FatorVencimento, DigitoCodBarras :String;
  ANossoNumero, AConvenio: String;
  wTamNossNum: Integer;
begin
   AConvenio    := ACBrTitulo.ACBrBoleto.Cedente.Convenio;
   ANossoNumero := FormataNossoNumero(ACBrTitulo);
   wTamNossNum  := CalcularTamMaximoNossoNumero(ACBrTitulo.Carteira,
                                                OnlyNumber(ACBrTitulo.NossoNumero));

   {Codigo de Barras}
   with ACBrTitulo.ACBrBoleto do
   begin
      FatorVencimento := CalcularFatorVencimento(ACBrTitulo.Vencimento);

      if ((ACBrTitulo.Carteira = '18') or (ACBrTitulo.Carteira = '16')) and
         (Length(AConvenio) = 6) and (wTamNossNum = 17) then
       begin
         CodigoBarras := IntToStrZero(Banco.Numero, 3) +
                         '9' +
                         FatorVencimento +
                         IntToStrZero(Round(ACBrTitulo.ValorDocumento * 100), 10) +
                         AConvenio + ANossoNumero + '21';
       end
      else
       begin
         CodigoBarras := IntToStrZero(Banco.Numero, 3) +
                         '9' +
                         FatorVencimento +
                         IntToStrZero(Round(ACBrTitulo.ValorDocumento * 100), 10) +
                         IfThen((Length(AConvenio) = 7), '000000', '') +
                         ANossoNumero +
                         IfThen((Length(AConvenio) < 7), padR(OnlyNumber(Cedente.Agencia), 4, '0'), '') +
                         IfThen((Length(AConvenio) < 7), IntToStrZero(StrToIntDef(OnlyNumber(Cedente.Conta),0),8), '') +
                         ACBrTitulo.Carteira;
       end;

      DigitoCodBarras := CalcularDigitoCodigoBarras(CodigoBarras);
   end;

   Result:= copy( CodigoBarras, 1, 4) + DigitoCodBarras + copy( CodigoBarras, 5, 44) ;
end;

function TACBrBancoBrasil.MontarCampoCodigoCedente (
   const ACBrTitulo: TACBrTitulo ) : String;
begin
   Result := ACBrTitulo.ACBrBoleto.Cedente.Agencia+'-'+
             ACBrTitulo.ACBrBoleto.Cedente.AgenciaDigito+'/'+
             IntToStrZero(StrToIntDef(ACBrTitulo.ACBrBoleto.Cedente.Conta,0),8)+'-'+
             ACBrTitulo.ACBrBoleto.Cedente.ContaDigito;
end;

function TACBrBancoBrasil.MontarCampoNossoNumero (const ACBrTitulo: TACBrTitulo ) : String;
var
  ANossoNumero :string;
  wTamConvenio, wTamNossoNum :Integer;
begin
   ANossoNumero := FormataNossoNumero(ACBrTitulo);
   wTamConvenio := Length(ACBrBanco.ACBrBoleto.Cedente.Convenio);
   wTamNossoNum := CalcularTamMaximoNossoNumero(ACBrTitulo.Carteira,
                                                OnlyNumber(ACBrTitulo.NossoNumero));

   if (wTamConvenio = 7) or ((wTamConvenio = 6) and (wTamNossoNum = 17)) then
      Result:= ANossoNumero
   else
      Result := ANossoNumero + '-' + CalcularDigitoVerificador(ACBrTitulo);
end;

function TACBrBancoBrasil.GerarRegistroHeader240(NumeroRemessa : Integer): String;
var
  ATipoInscricao,CNPJCIC      :String;
  aAgencia,aConta,aModalidade :String;
begin

   with ACBrBanco.ACBrBoleto.Cedente do
   begin
      case TipoInscricao of
         pFisica  : ATipoInscricao := '1';
         pJuridica: ATipoInscricao := '2';
      else
          ATipoInscricao := '1';
      end;

      CNPJCIC := OnlyNumber(CNPJCPF);

      aAgencia    := IntToStrZero(StrToIntDef(OnlyNumber(Agencia),0),5);
      aConta      := IntToStrZero(StrToIntDef(OnlyNumber(Conta),0),12);
      aModalidade := IntToStrZero(StrToIntDef(trim(Modalidade),0),3);

      { GERAR REGISTRO-HEADER DO ARQUIVO }

      Result:= IntToStrZero(ACBrBanco.Numero, 3)               + //1 a 3 - Código do banco
               '0000'                                          + //4 a 7 - Lote de serviço
               '0'                                             + //8 - Tipo de registro - Registro header de arquivo
               padL('', 9, ' ')                                + //9 a 17 Uso exclusivo FEBRABAN/CNAB
               ATipoInscricao                                  + //18 - Tipo de inscrição do cedente
               padR(CNPJCIC, 14, '0')                          + //19 a 32 -Número de inscrição do cedente
               padR(Convenio, 9, '0') + '0014'                 + //33 a 45 - Código do convênio no banco [ Alterado conforme instruções da CSO Brasília ] 27-07-09
               ACBrBanco.ACBrBoleto.ListadeBoletos[0].Carteira + //46 a 47 - Carteira
               aModalidade+'  '                                + //48 a 52 - Variacao Carteira
               aAgencia                                        + //53 a 57 - Código da agência do cedente
               padL(AgenciaDigito, 1 , '0')                    + //58 - Dígito da agência do cedente
               aConta                                          + //59 a 70 - Número da conta do cedente
               padL(ContaDigito, 1, '0')                       + //71 - Dígito da conta do cedente
               ' '                                             + //72 - Dígito verificador da agência / conta
               TiraAcentos(UpperCase(padL(Nome, 30, ' ')))     + //73 a 102 - Nome do cedente
               padL('BANCO DO BRASIL', 30, ' ')                + //103 a 132 - Nome do banco
               padL('', 10, ' ')                               + //133 a 142 - Uso exclusivo FEBRABAN/CNAB
               '1'                                             + //143 - Código de Remessa (1) / Retorno (2)
               FormatDateTime('ddmmyyyy', Now)                 + //144 a 151 - Data do de geração do arquivo
               FormatDateTime('hhmmss', Now)                   + //152 a 157 - Hora de geração do arquivo
               padR(IntToStr(NumeroRemessa), 6, '0')           + //158 a 163 - Número seqüencial do arquivo
               '030'                                           + //164 a 166 - Número da versão do layout do arquivo
               padL('',  5, '0')                               + //167 a 171 - Densidade de gravação do arquivo (BPI)
               padL('', 20, ' ')                               + // 172 a 191 - Uso reservado do banco
               padL('', 20, '0')                               + // 192 a 211 - Uso reservado da empresa
               padL('', 11, ' ')                               + // 212 a 222 - 11 brancos
               'CSP'                                           + // 223 a 225 - 'CSP'
               padL('',  3, '0')                               + // 226 a 228 - Uso exclusivo de Vans
               padL('',  2, ' ')                               + // 229 a 230 - Tipo de servico
               padL('', 10, ' ');                                //231 a 240 - titulo em carteira de cobranca

          { GERAR REGISTRO HEADER DO LOTE }

      Result:= Result + #13#10 +
               IntToStrZero(ACBrBanco.Numero, 3)               + //1 a 3 - Código do banco
               '0001'                                          + //4 a 7 - Lote de serviço
               '1'                                             + //8 - Tipo de registro - Registro header de arquivo
               'R'                                             + //9 - Tipo de operação: R (Remessa) ou T (Retorno)
               '01'                                            + //10 a 11 - Tipo de serviço: 01 (Cobrança)
               '00'                                            + //12 a 13 - Forma de lançamento: preencher com ZEROS no caso de cobrança
               '020'                                           + //14 a 16 - Número da versão do layout do lote
               ' '                                             + //17 - Uso exclusivo FEBRABAN/CNAB
               ATipoInscricao                                  + //18 - Tipo de inscrição do cedente
               padR(CNPJCIC, 15, '0')                          + //19 a 32 -Número de inscrição do cedente
               padR(Convenio, 9, '0') + '0014'                 + //33 a 45 - Código do convênio no banco [ Alterado conforme instruções da CSO Brasília ] 27-07-09
               ACBrBanco.ACBrBoleto.ListadeBoletos[0].Carteira + //46 a 47 - Carteira
               aModalidade+'  '                                + //48 a 52 - Variacao Carteira
               aAgencia                                        + //53 a 57 - Código da agência do cedente
               padL(AgenciaDigito, 1 , '0')                    + //58 - Dígito da agência do cedente
               aConta                                          + //59 a 70 - Número da conta do cedente
               padL(ContaDigito, 1, '0')                       + //71 - Dígito da conta do cedente
               ' '                                             + //72 - Dígito verificador da agência / conta
               padL(Nome, 30, ' ')                             + //73 a 102 - Nome do cedente
               padL('', 40, ' ')                               + //104 a 143 - Mensagem 1 para todos os boletos do lote
               padL('', 40, ' ')                               + //144 a 183 - Mensagem 2 para todos os boletos do lote
               padR(IntToStr(NumeroRemessa), 8, '0')           + //184 a 191 - Número do arquivo
               FormatDateTime('ddmmyyyy', Now)                 + //192 a 199 - Data de geração do arquivo
               padL('', 8, '0')                                + //200 a 207 - Data do crédito - Só para arquivo retorno
               padL('', 33, ' ');                                //208 a 240 - Uso exclusivo FEBRABAN/CNAB
   end;
end;

function TACBrBancoBrasil.GerarRegistroTransacao240(ACBrTitulo : TACBrTitulo): String;
var
   ATipoOcorrencia, ATipoBoleto: String;
   ADataMoraJuros, ADataDesconto, ANossoNumero : String;
   ATipoAceite, aAgencia, aConta, aDV          : String;
   wTamConvenio,wTamNossoNum: Integer;
   ACaracTitulo: Char;
begin
   with ACBrTitulo do
   begin
      ANossoNumero := FormataNossoNumero(ACBrTitulo);
      wTamConvenio := Length(ACBrBanco.ACBrBoleto.Cedente.Convenio);
      wTamNossoNum := CalcularTamMaximoNossoNumero(ACBrTitulo.Carteira, ACBrTitulo.NossoNumero);

      if (wTamConvenio = 7) or ((wTamConvenio = 6) and (wTamNossoNum = 17)) then
         aDV:= ''
      else
         aDV:= CalcularDigitoVerificador(ACBrTitulo);

      aAgencia:= IntToStrZero(StrToIntDef(OnlyNumber(ACBrBoleto.Cedente.Agencia),0),5);
      aConta  := IntToStrZero(StrToIntDef(OnlyNumber(ACBrBoleto.Cedente.Conta),0),12);

      {SEGMENTO P}

      {Pegando o Tipo de Ocorrencia}
      case OcorrenciaOriginal.Tipo of
         toRemessaBaixar                    : ATipoOcorrencia := '02';
         toRemessaConcederAbatimento        : ATipoOcorrencia := '04';
         toRemessaCancelarAbatimento        : ATipoOcorrencia := '05';
         toRemessaAlterarVencimento         : ATipoOcorrencia := '06';
         toRemessaConcederDesconto          : ATipoOcorrencia := '07';
         toRemessaCancelarDesconto          : ATipoOcorrencia := '08';
         toRemessaProtestar                 : ATipoOcorrencia := '09';
         toRemessaCancelarInstrucaoProtesto : ATipoOcorrencia := '10';
         toRemessaAlterarNomeEnderecoSacado : ATipoOcorrencia := '12';
         toRemessaDispensarJuros            : ATipoOcorrencia := '31';
      else
         ATipoOcorrencia := '01';
      end;

      { Pegando o tipo de EspecieDoc }
      if EspecieDoc = 'DM' then
         EspecieDoc   := '02'
      else if EspecieDoc = 'RC' then
         EspecieDoc   := '17'
      else if EspecieDoc = 'NP' then
         EspecieDoc   := '12'
      else if EspecieDoc = 'NS' then
         EspecieDoc   := '16'
      else if EspecieDoc = 'ND' then
         EspecieDoc   := '19'
      else if EspecieDoc = 'DS' then
         EspecieDoc   := '04'
      else
         EspecieDoc := EspecieDoc;



      { Pegando o Aceite do Titulo }
      case Aceite of
         atSim :  ATipoAceite := 'A';
         atNao :  ATipoAceite := 'N';
      end;

      {Pegando Tipo de Boleto} //Quem emite e quem distribui o boleto?
      case ACBrBoleto.Cedente.ResponEmissao of
         tbCliEmite        : ATipoBoleto := '2' + '2';
         tbBancoEmite      : ATipoBoleto := '1' + '1';
         tbBancoReemite    : ATipoBoleto := '4' + '1';
         tbBancoNaoReemite : ATipoBoleto := '5' + '2';
      end;

      case ACBrBoleto.Cedente.CaracTitulo of
        tcSimples     : ACaracTitulo  := '1';
        tcVinculada   : ACaracTitulo  := '2';
        tcCaucionada  : ACaracTitulo  := '3';
        tcDescontada  : ACaracTitulo  := '4';
        tcVendor      : ACaracTitulo  := '5';
      end;
  
      {Mora Juros}
      if (ValorMoraJuros > 0) then
       begin
         if (DataMoraJuros <> Null) then
            ADataMoraJuros := FormatDateTime('ddmmyyyy', DataMoraJuros)
         else
            ADataMoraJuros := padL('', 8, '0');
       end
      else
         ADataMoraJuros := padL('', 8, '0');

      {Descontos}
      if (ValorDesconto > 0) then
       begin
         if (DataDesconto <> Null) then
            ADataDesconto := FormatDateTime('ddmmyyyy', DataDesconto)
         else
            ADataDesconto := padL('', 8, '0');
       end
      else
         ADataDesconto := padL('', 8, '0');

      {SEGMENTO P}
      Result:= IntToStrZero(ACBrBanco.Numero, 3)                                         + //1 a 3 - Código do banco
               '0001'                                                                    + //4 a 7 - Lote de serviço
               '3'                                                                       + //8 - Tipo do registro: Registro detalhe
               IntToStrZero((3 * ACBrBoleto.ListadeBoletos.IndexOf(ACBrTitulo)) + 1 , 5) + //9 a 13 - Número seqüencial do registro no lote - Cada título tem 2 registros (P e Q)
               'P'                                                                       + //14 - Código do segmento do registro detalhe
               ' '                                                                       + //15 - Uso exclusivo FEBRABAN/CNAB: Branco
               ATipoOcorrencia                                                           + //16 a 17 - Código de movimento
               aAgencia                                                                  + //18 a 22 - Agência mantenedora da conta
               padL(ACBrBoleto.Cedente.AgenciaDigito, 1 , '0')                           + //23 -Dígito verificador da agência
               aConta                                                                    + //24 a 35 - Número da conta corrente
               padL(ACBrBoleto.Cedente.ContaDigito, 1, '0')                              + //36 - Dígito verificador da conta
               ' '                                                                       + //37 - Dígito verificador da agência / conta
               padL(ANossoNumero+aDV, 20, ' ')                                           + //38 a 57 - Nosso número - identificação do título no banco
               IfThen(StrToIntDef(Carteira,0) = 17,'7','1')                              + //58 - Cobrança Simples
               '1'                                                                       + //59 - Forma de cadastramento do título no banco: com cadastramento
               ACaracTitulo                                                              + //60 - Tipo de documento: Tradicional
               ATipoBoleto                                                               + //61 a 62 - Quem emite e quem distribui o boleto?
               padL(NumeroDocumento, 15, ' ')                                            + //63 a 77 - Número que identifica o título na empresa [ Alterado conforme instruções da CSO Brasília ] {27-07-09}
               FormatDateTime('ddmmyyyy', Vencimento)                                    + //78 a 85 - Data de vencimento do título
               IntToStrZero( round( ValorDocumento * 100), 15)                           + //86 a 100 - Valor nominal do título
               '000000'                                                                  + //101 a 105 - Agência cobradora + Digito. Se ficar em branco, a caixa determina automaticamente pelo CEP do sacado
               padL(EspecieDoc,2)                                                        + //107 a 108 - Espécie do documento
               ATipoAceite                                                               + //109 - Identificação de título Aceito / Não aceito
               FormatDateTime('ddmmyyyy', DataDocumento)                                 + //110 a 117 - Data da emissão do documento
               IfThen(ValorMoraJuros > 0, '1', '3')                                      + //118 - Código de juros de mora: Valor por dia
               ADataMoraJuros                                                            + //119 a 126 - Data a partir da qual serão cobrados juros

               IfThen(ValorMoraJuros > 0, IntToStrZero( round(ValorMoraJuros * 100), 15),
                    padL('', 15, '0'))                                                   + //127 a 141 - Valor de juros de mora por dia

               IfThen(ValorDesconto > 0, IfThen(DataDesconto > 0, '1','3'), '0')         + //142 - Código de desconto: 1 - Valor fixo até a data informada 4-Desconto por dia de antecipacao 0 - Sem desconto

               IfThen(ValorDesconto > 0,
                  IfThen(DataDesconto > 0, ADataDesconto,'00000000'), '00000000')        + //143 a 150 - Data do desconto

               IfThen(ValorDesconto > 0, IntToStrZero( round(ValorDesconto * 100), 15),
               padL('', 15, '0'))                                                        + //151 a 165 - Valor do desconto por dia
               IntToStrZero( round(ValorIOF * 100), 15)                                  + //166 a 180 - Valor do IOF a ser recolhido
               IntToStrZero( round(ValorAbatimento * 100), 15)                           + //181 a 195 - Valor do abatimento
               padL(SeuNumero, 25, ' ')                                                  + //196 a 220 - Identificação do título na empresa
               IfThen((DataProtesto <> null) and (DataProtesto > Vencimento),
                      IfThen((DaySpan(Vencimento, DataProtesto) > 5), '1', '2'), '3')       + //221 - Código de protesto: Protestar em XX dias corridos
               IfThen((DataProtesto <> null) and (DataProtesto > Vencimento),
                    padR(IntToStr(DaysBetween(DataProtesto, Vencimento)), 2, '0'), '00') + //222 a 223 - Prazo para protesto (em dias corridos)
               '0'                                                                       + //224 - Campo não tratado pelo BB [ Alterado conforme instruções da CSO Brasília ] {27-07-09}
               '000'                                                                     + //225 a 227 - Campo não tratado pelo BB [ Alterado conforme instruções da CSO Brasília ] {27-07-09}
               '09'                                                                      + //228 a 229 - Código da moeda: Real
               padL('', 10 , '0')                                                        + //230 a 239 - Uso exclusivo FEBRABAN/CNAB
               ' ';                                                                        //240 - Uso exclusivo FEBRABAN/CNAB

      {SEGMENTO Q}
      Result:= Result + #13#10 +
               IntToStrZero(ACBrBanco.Numero, 3)                                        + //Código do banco
               '0001'                                                                   + //Número do lote
               '3'                                                                      + //Tipo do registro: Registro detalhe
               IntToStrZero((3 * ACBrBoleto.ListadeBoletos.IndexOf(ACBrTitulo)) + 2 ,5) + //Número seqüencial do registro no lote - Cada título tem 2 registros (P e Q)
               'Q'                                                                      + //Código do segmento do registro detalhe
               ' '                                                                      + //Uso exclusivo FEBRABAN/CNAB: Branco
               ATipoOcorrencia                                                          + //Tipo Ocorrencia
                   {Dados do sacado}
               IfThen(Sacado.Pessoa = pJuridica,'2','1')                                + //Tipo inscricao
               padR(OnlyNumber(Sacado.CNPJCPF), 15, '0')                                +
               padL(Sacado.NomeSacado, 40, ' ')                                         +
               padL(Sacado.Logradouro +' '+ Sacado.Numero +' '+ Sacado.Complemento , 40, ' ') +
               padL(Sacado.Bairro, 15, ' ')                                             +
               padR(OnlyNumber(Sacado.CEP), 8, '0')                                     +
               padL(Sacado.Cidade, 15, ' ')                                             +
               padL(Sacado.UF, 2, ' ')                                                  +
                        {Dados do sacador/avalista}
               '0'                                                                      + //Tipo de inscrição: Não informado
               padL('', 15, '0')                                                        + //Número de inscrição
               padL('', 40, ' ')                                                        + //Nome do sacador/avalista
               padL('', 3, '0')                                                         + //Uso exclusivo FEBRABAN/CNAB
               padL('',20, ' ')                                                         + //Uso exclusivo FEBRABAN/CNAB
               padL('', 8, ' ');                                                          //Uso exclusivo FEBRABAN/CNAB

      {SEGMENTO R}
      Result:= Result + #13#10 +
               IntToStrZero(ACBrBanco.Numero, 3)                                       + // 1 - 3 Código do banco
               '0001'                                                                  + // 4 - 7 Número do lote
               '3'                                                                     + // 8 - 8 Tipo do registro: Registro detalhe
               IntToStrZero((3 * ACBrBoleto.ListadeBoletos.IndexOf(ACBrTitulo))+ 3 ,5) + // 9 - 13 Número seqüencial do registro no lote - Cada título tem 2 registros (P e Q)
               'R'                                                                     + // 14 - 14 Código do segmento do registro detalhe
               ' '                                                                     + // 15 - 15 Uso exclusivo FEBRABAN/CNAB: Branco
               ATipoOcorrencia                                                         + // 16 - 17 Tipo Ocorrencia
               padR('', 48, '0')                                                       + // 18 - 65 Brancos (Não definido pelo FEBRAN)
               IfThen((PercentualMulta <> null) and (PercentualMulta > 0), '1', '0')   + // 66 - 66 1-Cobrar Multa / 0-Não cobrar multa
               IfThen((PercentualMulta <> null) and (PercentualMulta > 0),
                  FormatDateTime('ddmmyyyy', DataMoraJuros), '00000000')               + // 67 - 74 Se cobrar informe a data para iniciar a cobrança ou informe zeros se não cobrar
               IfThen(PercentualMulta > 0, IntToStrZero(round(PercentualMulta * 100), 15),
                    padL('', 15, '0'))                                                 + // 75 - 89 Percentual de multa. Informar zeros se não cobrar
                    padL('',110,' ')                                                   + // 90 - 199
                    padL('',8,'0')                                                     + // 200 - 207
               padR('', 33, ' ');                                                        // 208 - 240 Brancos (Não definido pelo FEBRAN)


      end; 
end;

function TACBrBancoBrasil.GerarRegistroTrailler240( ARemessa : TStringList ): String;
begin
   {REGISTRO TRAILER DO LOTE}
   Result:= IntToStrZero(ACBrBanco.Numero, 3)                          + //Código do banco
            '0001'                                                     + //Número do lote
            '5'                                                        + //Tipo do registro: Registro trailer do lote
            Space(9)                                                   + //Uso exclusivo FEBRABAN/CNAB
            //IntToStrZero(ARemessa.Count-1, 6)                        + //Quantidade de Registro da Remessa
            IntToStrZero((3 * ARemessa.Count-1), 6)                    + //Quantidade de Registro da Remessa
            padL('', 6, '0')                                           + //Quantidade títulos em cobrança
            padL('',17, '0')                                           + //Valor dos títulos em carteiras}
            padL('', 6, '0')                                           + //Quantidade títulos em cobrança
            padL('',17, '0')                                           + //Valor dos títulos em carteiras}
            padL('', 6, '0')                                           + //Quantidade títulos em cobrança
            padL('',17, '0')                                           + //Valor dos títulos em carteiras}
            padL('', 6, '0')                                           + //Quantidade títulos em cobrança
            padL('',17, '0')                                           + //Valor dos títulos em carteiras}
            Space(8)                                                   + //Uso exclusivo FEBRABAN/CNAB}
            padL('',117,' ')                                           ;

   {GERAR REGISTRO TRAILER DO ARQUIVO}
   Result:= Result + #13#10 +
            IntToStrZero(ACBrBanco.Numero, 3)                          + //Código do banco
            '9999'                                                     + //Lote de serviço
            '9'                                                        + //Tipo do registro: Registro trailer do arquivo
            space(9)                                                   + //Uso exclusivo FEBRABAN/CNAB}
            '000001'                                                   + //Quantidade de lotes do arquivo}
            IntToStrZero(((ARemessa.Count-1)* 3)+4, 6)                 + //Quantidade de registros do arquivo, inclusive este registro que está sendo criado agora}
            space(6)                                                   + //Uso exclusivo FEBRABAN/CNAB}
            space(205);                                                  //Uso exclusivo FEBRABAN/CNAB}
end;


procedure TACBrBancoBrasil.GerarRegistroHeader400(NumeroRemessa: Integer; aRemessa:TStringList);
var
  TamConvenioMaior6 :Boolean;
  aAgencia, aConta  :String;
  wLinha: String;
begin

   with ACBrBanco.ACBrBoleto.Cedente do
   begin
      TamConvenioMaior6:= Length(trim(Convenio)) > 6;
      aAgencia:= IntToStrZero(StrToIntDef(OnlyNumber(Agencia),0),4);
      aConta  := IntToStrZero(StrToIntDef(OnlyNumber(Conta),0),8);

      wLinha:= '0'                            + // ID do Registro
               '1'                            + // ID do Arquivo( 1 - Remessa)
               'REMESSA'                      + // Literal de Remessa
               '01'                           + // Código do Tipo de Serviço
               padL( 'COBRANCA', 15 )         + // Descrição do tipo de serviço
               aAgencia                       + // Prefixo da agência/ onde esta cadastrado o convenente lider do cedente
               padL( AgenciaDigito, 1, ' ')   + // DV-prefixo da agencia
               aConta                         + // Codigo do cedente/nr. da conta corrente que está cadastro o convenio lider do cedente
               padL( ContaDigito, 1, ' ');      // DV-código do cedente


      if TamConvenioMaior6 then
         wLinha:= wLinha + '000000'                         // Complemento
      else
         wLinha:= wLinha + padR(trim(Convenio),6,'0');      //Convenio;

      wLinha:= wLinha + padL( Nome, 30)                      + // Nome da Empresa
               IntToStrZero( Numero, 3)                      + // Código do Banco
               padL('BANCO DO BRASIL', 15)                   + // Nome do Banco(BANCO DO BRASIL)
               FormatDateTime('ddmmyy',Now)                  + // Data de geração do arquivo
               IntToStrZero(NumeroRemessa,7);                  // Numero Remessa

      if TamConvenioMaior6 then
         wLinha:= wLinha + Space(22)                                     + // Nr. Sequencial de Remessa + brancos
                  padR(trim(ACBrBanco.ACBrBoleto.Cedente.Convenio),7,'0')+ //Nr. Convenio
                  space(258)                                               //Brancos
      else
         wLinha:= wLinha + Space(287);

      wLinha:= wLinha + IntToStrZero(1,6); // Nr. Sequencial do registro-informar 000001

      aRemessa.Text:= aRemessa.Text + UpperCase(wLinha);
   end;
end;

procedure TACBrBancoBrasil.GerarRegistroTransacao400(ACBrTitulo: TACBrTitulo; aRemessa: TStringList);
var
  ANossoNumero, ADigitoNossoNumero :String;
  ATipoOcorrencia, AInstrucao      :String;
  ATipoSacado, ATipoCendente       :String;
  ATipoAceite, ATipoEspecieDoc     :String;
  AMensagem, DiasProtesto          :String;
  aDataDesconto, aAgencia, aConta  :String;
  aModalidade,wLinha, aTipoCobranca:String;
  TamConvenioMaior6                :Boolean;
  wCarteira: Integer;
begin

   with ACBrTitulo do
   begin
      wCarteira:= strtoint(Carteira);
      if ((wCarteira = 11) or (wCarteira= 31) or (wCarteira = 51)) or
         (((wCarteira = 12) or (wCarteira = 15) or (wCarteira = 17)) and
          (ACBrBoleto.Cedente.ResponEmissao <> tbCliEmite)) then
       begin
         ANossoNumero       := '00000000000000000000';
         ADigitoNossoNumero := '';
       end
      else
       begin
         ANossoNumero := FormataNossoNumero(ACBrTitulo);
         ADigitoNossoNumero := CalcularDigitoVerificador(ACBrTitulo);
       end;
      
    
      TamConvenioMaior6:= Length(trim(ACBrBoleto.Cedente.Convenio)) > 6;
      aAgencia:= IntToStrZero(StrToIntDef(OnlyNumber(ACBrBoleto.Cedente.Agencia),0),4);
      aConta  := IntToStrZero(StrToIntDef(OnlyNumber(ACBrBoleto.Cedente.Conta),0),8);
      aModalidade := IntToStrZero(StrToIntDef(trim(ACBrBoleto.Cedente.Modalidade),0),3);

      {Pegando Código da Ocorrencia}
      case OcorrenciaOriginal.Tipo of
         toRemessaBaixar                         : ATipoOcorrencia := '02'; {Pedido de Baixa}
         toRemessaConcederAbatimento             : ATipoOcorrencia := '04'; {Concessão de Abatimento}
         toRemessaCancelarAbatimento             : ATipoOcorrencia := '05'; {Cancelamento de Abatimento concedido}
         toRemessaAlterarVencimento              : ATipoOcorrencia := '06'; {Alteração de vencimento}
         toRemessaAlterarNumeroControle          : ATipoOcorrencia := '08'; {Alteração de seu número}
         toRemessaProtestar                      : ATipoOcorrencia := '09'; {Pedido de protesto}
         toRemessaCancelarInstrucaoProtestoBaixa : ATipoOcorrencia := '10'; {Sustar protesto e baixar}
         toRemessaCancelarInstrucaoProtesto      : ATipoOcorrencia := '10'; {Sustar protesto e manter na carteira}
         toRemessaOutrasOcorrencias              : ATipoOcorrencia := '31'; {Alteração de Outros Dados}
      else
         ATipoOcorrencia := '01';                                      {Remessa}
      end;

      { Pegando o Aceite do Titulo }
      case Aceite of
         atSim :  ATipoAceite := 'A';
         atNao :  ATipoAceite := 'N';
      end;

      { Pegando o tipo de EspecieDoc }
      if EspecieDoc = 'DM' then
         ATipoEspecieDoc   := '01'
      else if EspecieDoc = 'NP' then
         ATipoEspecieDoc   := '02'
      else if EspecieDoc = 'NS' then
         ATipoEspecieDoc   := '03'
      else if EspecieDoc = 'ND' then
         ATipoEspecieDoc   := '13'
      else if EspecieDoc = 'RC' then
         ATipoEspecieDoc   := '05'
      else if EspecieDoc = 'LC' then 
         ATipoEspecieDoc   := '08'
      else if EspecieDoc = 'DS' then
         ATipoEspecieDoc   := '12'
      else if EspecieDoc = 'ND' then
         ATipoEspecieDoc   := '13'; 

      { Pegando Tipo de Cobrança}
      case StrToInt(ACBrTitulo.Carteira) of
        11,17 :
          case ACBrBoleto.Cedente.CaracTitulo of
            tcSimples: aTipoCobranca:='     ';
            tcDescontada: aTipoCobranca:='04DSC';
            tcVendor: aTipoCobranca:='08VDR';
            tcVinculada: aTipoCobranca:='02VIN';
          else
            aTipoCobranca:='     ';
          end;
      else
        aTipoCobranca:='     ';
      end;

      
      if (DataProtesto > 0) and (DataProtesto > Vencimento) then
      begin
        DiasProtesto:='  ';
        case (DaysBetween(DataProtesto,Vencimento)) of
          3: // Protestar no 3º dia util após vencimento
          begin
            if (trim(Instrucao1) = '') or (trim(Instrucao1) = '03') then
              AInstrucao := '03'+ padR(trim(Instrucao2),2,'0');
          end;
          4: // Protestar no 4º dia util após vencimento
          begin
            if (trim(Instrucao1) = '') or (trim(Instrucao1) = '04') then
              AInstrucao := '04'+ padR(trim(Instrucao2),2,'0');
          end;
          5: // Protestar no 5º dia util após vencimento
          begin
            if (trim(Instrucao1) = '') or (trim(Instrucao1) = '05') then
              AInstrucao := '05'+ padR(trim(Instrucao2),2,'0');
          end;
        else
          if (trim(Instrucao1) = '') or (trim(Instrucao1) = '06') then
            AInstrucao := '06'+ padR(trim(Instrucao2),2,'0');
          DiasProtesto:=IntToStr(DaysBetween(DataProtesto,Vencimento));
        end;
       end
      else
       begin
         Instrucao1:='07'; //Não Protestar
         AInstrucao := padR(Trim(Instrucao1),2,'0') + padR(Trim(Instrucao2),2,'0');
         DiasProtesto:= '  ';
       end; 

      aDataDesconto:= '000000';

      if ValorDesconto > 0 then
      begin
         if DataDesconto > EncodeDate(2000,01,01) then
            aDataDesconto := FormatDateTime('ddmmyy',DataDesconto)
         else
            aDataDesconto := '777777';
      end;


      {Pegando Tipo de Sacado}
      case Sacado.Pessoa of
         pFisica   : ATipoSacado := '01';
         pJuridica : ATipoSacado := '02';
      else
         ATipoSacado := '00';
      end;

      {Pegando Tipo de Cedente}
      case ACBrBoleto.Cedente.TipoInscricao of
         pFisica   : ATipoCendente := '01';
         pJuridica : ATipoCendente := '02';
      end;

      AMensagem   := '';
      if Mensagem.Text <> '' then
         AMensagem   := Mensagem.Strings[0];


      with ACBrBoleto do
      begin
         if TamConvenioMaior6 then
            wLinha:= '7'
         else
            wLinha:= '1';

         wLinha:= wLinha                                                  + // ID Registro
                  ATipoCendente + padR(OnlyNumber(Cedente.CNPJCPF),14,'0')+ // Tipo de inscrição da empresa 01-CPF / 02-CNPJ  + Inscrição da empresa
                  aAgencia                                                + // Prefixo da agencia
                  padL( Cedente.AgenciaDigito, 1)                         + // DV-prefixo da agencia
                  aConta                                                  + // Código do cendete/nr. conta corrente da empresa
                  padL( Cedente.ContaDigito, 1);                            // DV-código do cedente

         if TamConvenioMaior6 then
            wLinha:= wLinha + padR( trim(Cedente.Convenio), 7)              // Número do convenio
         else
            wLinha:= wLinha + padR( trim(Cedente.Convenio), 6);             // Número do convenio

         wLinha:= wLinha + padL( SeuNumero, 25 );                           // Numero de Controle do Participante

         if TamConvenioMaior6 then
            wLinha:= wLinha + padR( ANossoNumero, 17, '0')                  // Nosso numero
         else
            wLinha:= wLinha + padR( ANossoNumero,11)+ ADigitoNossoNumero;


         wLinha:= wLinha +
                  '0000' + Space(7) + aModalidade;                          // Zeros + Brancos + Prefixo do titulo + Variação da carteira

         if TamConvenioMaior6  then
            wLinha:= wLinha + IntToStrZero(0,7)                             // Zero + Zeros + Zero + Zeros
         else
            wLinha:= wLinha + IntToStrZero(0,13);

         wLinha:= wLinha +
                  aTipoCobranca                                           + // Tipo de cobrança - 11, 17 (04DSC, 08VDR, 02VIN, BRANCOS) 12,31,51 (BRANCOS)
                  Carteira                                                + // Carteira
                  ATipoOcorrencia                                         + // Ocorrência "Comando"
                  padL( NumeroDocumento, 10, ' ')                         + // Seu Numero - Nr. titulo dado pelo cedente
                  FormatDateTime( 'ddmmyy', Vencimento )                  + // Data de vencimento
                  IntToStrZero( Round( ValorDocumento * 100 ), 13)        + // Valor do titulo
                  '001' + '0000' + ' '                                    + // Numero do Banco - 001 + Prefixo da agencia cobradora + DV-pref. agencia cobradora
                  padR(ATipoEspecieDoc, 2, '0') + ATipoAceite             + // Especie de titulo + Aceite
                  FormatDateTime( 'ddmmyy', DataDocumento )               + // Data de Emissão
                  AInstrucao                                              + // 1ª e 2ª instrução codificada
                  IntToStrZero( round(ValorMoraJuros * 100 ), 13)         + // Juros de mora por dia
                  aDataDesconto                                           + // Data limite para concessao de desconto
                  IntToStrZero( round( ValorDesconto * 100), 13)          + // Valor do desconto
                  IntToStrZero( round( ValorIOF * 100 ), 13)              + // Valor do IOF
                  IntToStrZero( round( ValorAbatimento * 100 ), 13)       + // Valor do abatimento permitido
                  ATipoSacado + padR(OnlyNumber(Sacado.CNPJCPF),14,'0')   + // Tipo de inscricao do sacado + CNPJ ou CPF do sacado
                  padL( Sacado.NomeSacado, 37) + '   '                    + // Nome do sacado + Brancos
                  padL(trim(Sacado.Logradouro) + ', ' +
                       trim(Sacado.Numero) + ' '+ trim(Sacado.Bairro),
                       52)                                                + // Endereço do sacado
                  padR( OnlyNumber(Sacado.CEP), 8 )                       + // CEP do endereço do sacado
                  padL( trim(Sacado.Cidade), 15)                          + // Cidade do sacado
                  padL( Sacado.UF, 2 )                                    + // UF da cidade do sacado
                  padL( AMensagem, 40)                                    + // Observações
                  DiasProtesto + ' '                                      + // Número de dias para protesto + Branco
                  IntToStrZero( aRemessa.Count + 1, 6 );


         wLinha:= wLinha + sLineBreak                              +
                  '5'                                              + //Tipo Registro
                  '99'                                             + //Tipo de Serviço (Cobrança de Multa)
                  IfThen(PercentualMulta > 0, '2','9')             + //Cod. Multa 2- Percentual 9-Sem Multa
                  IfThen(PercentualMulta > 0,
                         FormatDateTime('ddmmyy', DataMoraJuros),
                                        '000000')                  + //Data Multa
                  IntToStrZero( round( PercentualMulta * 100), 12) + //Perc. Multa
                  Space(372)                                       + //Brancos
                  IntToStrZero(aRemessa.Count + 2 ,6);

         aRemessa.Text := aRemessa.Text + UpperCase(wLinha);
      end;
   end;
end;

procedure TACBrBancoBrasil.GerarRegistroTrailler400(
  ARemessa: TStringList);
var
  wLinha: String;
begin
   wLinha := '9' + Space(393)                     + // ID Registro
             IntToStrZero(ARemessa.Count + 1, 6);  // Contador de Registros

   ARemessa.Text:= ARemessa.Text + UpperCase(wLinha);
end;

procedure TACBrBancoBrasil.LerRetorno240(ARetorno: TStringList);
var
  Titulo: TACBrTitulo;
  TempData, Linha, rCedente, rCNPJCPF: String;
  ContLinha : Integer;
  idxMotivo: Integer;
begin
   ContLinha := 0;

   // informação do Header
   // Verifica se o arquivo pertence ao banco
   if StrToIntDef(copy(ARetorno.Strings[0], 1, 3),-1) <> Numero then
      raise Exception.create(ACBrStr(ACBrBanco.ACBrBoleto.NomeArqRetorno +
                             'não' + 'é um arquivo de retorno do ' + Nome));

   ACBrBanco.ACBrBoleto.DataArquivo := StringToDateTimeDef(Copy(ARetorno[0],144,2)+'/'+
                                                           Copy(ARetorno[0],146,2)+'/'+
                                                           Copy(ARetorno[0],148,4),0, 'DD/MM/YYYY' );

   ACBrBanco.ACBrBoleto.NumeroArquivo := StrToIntDef(Copy(ARetorno[0],158,6),0);

   rCedente := trim(copy(ARetorno[0], 73, 30));
   rCNPJCPF := OnlyNumber( copy(ARetorno[0], 19, 14) );

   with ACBrBanco.ACBrBoleto do
   begin
      if (not LeCedenteRetorno) and (rCNPJCPF <> OnlyNumber(Cedente.CNPJCPF)) then
         raise Exception.create(ACBrStr('CNPJ\CPF do arquivo inválido'));

      Cedente.Nome := rCedente;
      Cedente.CNPJCPF := rCNPJCPF;

      case StrToIntDef(copy(ARetorno[0], 18, 1), 0) of
        01:
          Cedente.TipoInscricao := pFisica;
        else
          Cedente.TipoInscricao := pJuridica;
      end;

      ACBrBanco.ACBrBoleto.ListadeBoletos.Clear;
   end;

   ACBrBanco.TamanhoMaximoNossoNum := 20;  

   for ContLinha := 1 to ARetorno.Count - 2 do
   begin
      Linha := ARetorno[ContLinha];

      if copy(Linha, 8, 1) <> '3' then // verifica se o registro (linha) é um registro detalhe (segmento J)
         Continue;

      if copy(Linha, 14, 1) = 'T' then // se for segmento T cria um novo titulo
         Titulo := ACBrBanco.ACBrBoleto.CriarTituloNaLista;

      with Titulo do
      begin
         if copy(Linha, 14, 1) = 'T' then
          begin
            SeuNumero := copy(Linha, 106, 25);
            NumeroDocumento := copy(Linha, 59, 15);
            Carteira := copy(Linha, 58, 1);

            TempData := copy(Linha, 74, 2) + '/'+copy(Linha, 76, 2)+'/'+copy(Linha, 78, 4);
            if TempData<>'00/00/0000' then
               Vencimento := StringToDateTimeDef(TempData, 0, 'DDMMYY');

            ValorDocumento := StrToFloatDef(copy(Linha, 82, 15), 0) / 100;

            NossoNumero := copy(Linha, 38, 20);
            ValorDespesaCobranca := StrToFloatDef(copy(Linha, 199, 15), 0) / 100;

            OcorrenciaOriginal.Tipo := CodOcorrenciaToTipo(StrToIntDef(copy(Linha, 16, 2), 0));

            IdxMotivo := 214;

            while (IdxMotivo < 223) do
            begin
               if (trim(Copy(Linha, IdxMotivo, 2)) <> '') then
               begin
                  MotivoRejeicaoComando.Add(Copy(Linha, IdxMotivo, 2));
                  DescricaoMotivoRejeicaoComando.Add(CodMotivoRejeicaoToDescricao(OcorrenciaOriginal.Tipo, StrToIntDef(Copy(Linha, IdxMotivo, 2), 0)));
               end;
               Inc(IdxMotivo, 2);
            end;
          end
         else // segmento U
          begin
            ValorIOF := StrToFloatDef(copy(Linha, 63, 15), 0) / 100;
            ValorAbatimento := StrToFloatDef(copy(Linha, 48, 15), 0) / 100;
            ValorDesconto := StrToFloatDef(copy(Linha, 33, 15), 0) / 100;
            ValorMoraJuros := StrToFloatDef(copy(Linha, 18, 15), 0) / 100;
            ValorOutrosCreditos := StrToFloatDef(copy(Linha, 108, 15), 0) / 100;
            ValorRecebido := StrToFloatDef(copy(Linha, 78, 15), 0) / 100;
            TempData := copy(Linha, 138, 2)+'/'+copy(Linha, 140, 2)+'/'+copy(Linha, 142, 4);
            if TempData<>'00/00/0000' then
                DataOcorrencia := StringToDateTimeDef(TempData, 0, 'DDMMYY');
            TempData := copy(Linha, 146, 2)+'/'+copy(Linha, 148, 2)+'/'+copy(Linha, 150, 4);
            if TempData<>'00/00/0000' then            
                DataCredito := StringToDateTimeDef(TempData, 0, 'DDMMYYYY');
          end;
      end;
   end;

   ACBrBanco.TamanhoMaximoNossoNum := 10;
end;

function TACBrBancoBrasil.TipoOCorrenciaToCod (
   const TipoOcorrencia: TACBrTipoOcorrencia ) : String;
begin
   case TipoOcorrencia of
      toRetornoRegistroConfirmado                         : Result := '02';
      toRetornoRegistroRecusado                           : Result := '03';
      toRetornoLiquidado                                  : Result := '06';
      toRetornoBaixado                                    : Result := '09';
      toRetornoBaixadoInstAgencia                         : Result := '10';
      toRetornoTituloEmSer                                : Result := '11';
      toRetornoRecebimentoInstrucaoConcederAbatimento     : Result := '12';
      toRetornoRecebimentoInstrucaoCancelarAbatimento     : Result := '13';
      toRetornoRecebimentoInstrucaoAlterarVencimento      : Result := '14';
      toRetornoLiquidadoEmCartorio                        : Result := '15';
      toRetornoLiquidadoSemRegistro                       : Result := '17';
      toRetornoRecebimentoInstrucaoProtestar              : Result := '19';
      toRetornoRecebimentoInstrucaoSustarProtesto         : Result := '20';
      toRetornoAcertoControleParticipante                 : Result := '21';
      toRetornoEnderecoSacadoAlterado                     : Result := '22';
      toRetornoEncaminhadoACartorio                       : Result := '23';
      toRetornoRetiradoDeCartorio                         : Result := '24';
      toRetornoProtestado                                 : Result := '25';
      toRetornoRecebimentoInstrucaoAlterarDados           : Result := '27';
      toRetornoDebitoTarifas                              : Result := '28';
      toRetornoOcorrenciasdoSacado                        : Result := '29';
      toRetornoAlteracaoDadosRejeitados                   : Result := '30';
      toRetornoRecebimentoInstrucaoConcederDesconto       : Result := '36';
      toRetornoRecebimentoInstrucaoCancelarDesconto       : Result := '37';
      toRetornoProtestoOuSustacaoEstornado                : Result := '43';
      toRetornoBaixaOuLiquidacaoEstornada                 : Result := '44';
      toRetornoDadosAlterados                             : Result := '45';
   else
      Result:= '02';
   end;
end;

function TACBrBancoBrasil.TipoOcorrenciaToDescricao(const TipoOcorrencia: TACBrTipoOcorrencia): String;
var
 CodOcorrencia: Integer;
begin

  CodOcorrencia := StrToIntDef(TipoOCorrenciaToCod(TipoOcorrencia),0);

  Case CodOcorrencia of
   {Segundo manual técnico CNAB400 Abril/2012 BB pag.20 os comandos são os seguintes:}
   02: Result:='02-Confirmação de Entrada de Título' ;
   03: Result:='03-Comando recusado' ;
   05: Result:='05-Liquidado sem registro' ;
   06: Result:='06-Liquidação Normal' ;
   07: Result:='07-Liquidação por Conta' ;
   08: Result:='08-Liquidação por Saldo' ;
   09: Result:='09-Baixa de Título' ;
   10: Result:='10-Baixa Solicitada' ;
   11: Result:='11-Titulos em Ser' ;
   12: Result:='12-Abatimento Concedido' ;
   13: Result:='13-Abatimento Cancelado' ;
   14: Result:='14-Alteração de Vencimento do Titulo' ;
   15: Result:='15-Liquidação em Cartório' ;
   16: Result:='16-Confirmação de alteração de juros de mora' ;
   19: Result:='19-Confirmação de recebimento de instruções para protesto' ;
   20: Result:='20-Débito em Conta' ;
   21: Result:='21-Alteração do Nome do Sacado' ;
   22: Result:='22-Alteração do Endereço do Sacado' ;
   23: Result:='23-Indicação de encaminhamento a cartório' ;
   24: Result:='24-Sustar Protesto' ;
   25: Result:='25-Dispensar Juros' ;
   26: Result:='26-Alteração do número do título dado pelo Cedente (Seu número) - 10 e 15 posições' ;
   28: Result:='28-Manutenção de titulo vencido' ;
   31: Result:='31-Conceder desconto' ;
   32: Result:='32-Não conceder desconto' ;
   33: Result:='33-Retificar desconto' ;
   34: Result:='34-Alterar data para desconto' ;
   35: Result:='35-Cobrar multa' ;
   36: Result:='36-Dispensar multa' ;
   37: Result:='37-Dispensar indexador' ;
   38: Result:='38-Dispensar prazo limite para recebimento' ;
   39: Result:='39-Alterar prazo limite para recebimento' ;
   41: Result:='41-Alteração do número do controle do participante (25 posições)' ;
   42: Result:='42-Alteração do número do documento do sacado (CNPJ/CPF)' ;
   44: Result:='44-Título pago com cheque devolvido' ;
   46: Result:='46-Título pago com cheque, aguardando compensação' ;
   72: Result:='72-Alteração de tipo de cobrança' ;
   96: Result:='96-Despesas de Protesto' ;
   97: Result:='97-Despesas de Sustação de Protesto' ;
   98: Result:='98-Débito de Custas Antecipadas' ;
   //Códigos que estavam no Projeto ACBr
   {02: Result := '02-Entrada Confirmada';
    03: Result := '03-Entrada Rejeitada';
    04: Result := '04-Transferência de Carteira/Entrada';
    05: Result := '05-Transferência de Carteira/Baixa';
    06: Result := '06-Liquidação';
    07: Result := '07-Confirmação do Recebimento da Instrução de Desconto';
    08: Result := '08-Confirmação do Recebimento do Cancelamento do Desconto';
    09: Result := '09-Baixa';
    10: Result := '10-Baixa Solicitada';
    11: Result := '11-Títulos em Carteira (Em Ser)';
    12: Result := '12-Confirmação Recebimento Instrução de Abatimento';
    13: Result := '13-Confirmação Recebimento Instrução de Cancelamento Abatimento';
    14: Result := '14-Confirmação Recebimento Instrução Alteração de Vencimento';
    15: Result := '15-Franco de Pagamento';
    17: Result := '17-Liquidação Após Baixa ou Liquidação Título Não Registrado';
    19: Result := '19-Confirmação Recebimento Instrução de Protesto';
    20: Result := '20-Confirmação Recebimento Instrução de Sustação/Cancelamento de Protesto';
    21: Result := '21-Alteração do Nome do Sacado';
    22: Result := '22-Alteração do Endereço do Sacado';
    23: Result := '23-Remessa a Cartório (Aponte em Cartório)';
    24: Result := '24-Retirada de Cartório e Manutenção em Carteira';
    25: Result := '25-Protestado e Baixado (Baixa por Ter Sido Protestado)';
    26: Result := '26-Instrução Rejeitada';
    27: Result := '27-Confirmação do Pedido de Alteração de Outros Dados';
    28: Result := '28-Débito de Tarifas/Custas';
    29: Result := '29-Ocorrências do Sacado';
    30: Result := '30-Alteração de Dados Rejeitada';
    33: Result := '33-Confirmação da Alteração dos Dados do Rateio de Crédito';
    34: Result := '34-Confirmação do Cancelamento dos Dados do Rateio de Crédito';
    35: Result := '35-Confirmação do Desagendamento do Débito Automático';
    36: Result := '36-Confirmação de envio de e-mail/SMS';
    37: Result := '37-Envio de e-mail/SMS rejeitado';
    38: Result := '38-Confirmação de alteração do Prazo Limite de Recebimento (a data deve ser informada no campo 28.3.p)';
    39: Result := '39-Confirmação de Dispensa de Prazo Limite de Recebimento';
    40: Result := '40-Confirmação da alteração do número do título dado pelo cedente';
    41: Result := '41-Confirmação da alteração do número controle do Participante';
    42: Result := '42-Confirmação da alteração dos dados do Sacado';
    43: Result := '43-Confirmação da alteração dos dados do Sacador/Avalista';
    44: Result := '44-Título pago com cheque devolvido';
    45: Result := '45-Título pago com cheque compensado';
    46: Result := '46-Instrução para cancelar protesto confirmada';
    47: Result := '47-Instrução para protesto para fins falimentares confirmada';
    48: Result := '48-Confirmação de instrução de transferência de carteira/modalidade de cobrança';
    49: Result := '49-Alteração de contrato de cobrança';
    50: Result := '50-Título pago com cheque pendente de liquidação';
    51: Result := '51-Título DDA reconhecido pelo sacado';
    52: Result := '52-Título DDA não reconhecido pelo sacado';
    53: Result := '53-Título DDA recusado pela CIP';
    54: Result := '54-Confirmação da Instrução de Baixa de Título Negativado sem Protesto';}
  end;
end;

function TACBrBancoBrasil.CodOcorrenciaToTipo(const CodOcorrencia:
   Integer ) : TACBrTipoOcorrencia;
begin
  Case CodOcorrencia of
    2 : Result := toRetornoRegistroConfirmado;
    3 : Result := toRetornoRegistroRecusado;
    6 : Result := toRetornoLiquidado;
    9 : Result := toRetornoBaixado;
    10: Result := toRetornoBaixadoInstAgencia;
    11: Result := toRetornoTituloEmSer;
    12: Result := toRetornoRecebimentoInstrucaoConcederAbatimento;
    13: Result := toRetornoRecebimentoInstrucaoCancelarAbatimento;
    14: Result := toRetornoRecebimentoInstrucaoAlterarVencimento;
    15: Result := toRetornoLiquidadoEmCartorio;
    17: Result := toRetornoLiquidadoSemRegistro;
    19: Result := toRetornoRecebimentoInstrucaoProtestar;
    20: Result := toRetornoRecebimentoInstrucaoSustarProtesto;
    22: Result := toRetornoEnderecoSacadoAlterado;
    23: Result := toRetornoEncaminhadoACartorio;
    24: Result := toRetornoRetiradoDeCartorio;
    25: Result := toRetornoProtestado;
    26: Result := toRetornoInstrucaoRejeitada;
    27: Result := toRetornoRecebimentoInstrucaoAlterarDados;
    28: Result := toRetornoDebitoTarifas;
    29: Result := toRetornoOcorrenciasdoSacado;
    30: Result := toRetornoAlteracaoDadosRejeitados;
    36: Result := toRetornoRecebimentoInstrucaoConcederDesconto;
    37: Result := toRetornoRecebimentoInstrucaoCancelarDesconto;
    43: Result := toRetornoProtestoOuSustacaoEstornado;
    44: Result := toRetornoBaixaOuLiquidacaoEstornada;
    45: Result := toRetornoDadosAlterados;
  else
    Result := toRetornoOutrasOcorrencias;
  end;
end;

function TACBrBancoBrasil.CodMotivoRejeicaoToDescricao(const TipoOcorrencia: TACBrTipoOcorrencia; CodMotivo: Integer): String;
begin
   case TipoOcorrencia of
    toRetornoRegistroRecusado: //03 (Recusado)
      case CodMotivo of
        01: Result:='01-Identificação inválida' ;
        02: Result:='02-Variação da carteira inválida' ;
        03: Result:='03-Valor dos juros por um dia inválido' ;
        04: Result:='04-Valor do desconto inválido' ;
        05: Result:='05-Espécie de título inválida para carteira' ;
        06: Result:='06-Espécie de valor variável inválido' ;
        07: Result:='07-Prefixo da agência usuária inválido' ;
        08: Result:='08-Valor do título/apólice inválido' ;
        09: Result:='09-Data de vencimento inválida' ;
        10: Result:='10-Fora do prazo' ;
        11: Result:='11-Inexistência de margem para desconto' ;
        12: Result:='12-O Banco não tem agência na praça do sacado' ;
        13: Result:='13-Razões cadastrais' ;
        14: Result:='14-Sacado interligado com o sacador' ;
        15: Result:='15-Título sacado contra orgão do Poder Público' ;
        16: Result:='16-Título preenchido de forma irregular' ;
        17: Result:='17-Título rasurado' ;
        18: Result:='18-Endereço do sacado não localizado ou incompleto' ;
        19: Result:='19-Código do cedente inválido' ;
        20: Result:='20-Nome/endereco do cliente não informado /ECT/' ;
        21: Result:='21-Carteira inválida' ;
        22: Result:='22Quantidade de valor variável inválida' ;
        23: Result:='23-Faixa nosso número excedida' ;
        24: Result:='24-Valor do abatimento inválido' ;
        25: Result:='25-Novo número do título dado pelo cedente inválido' ;
        26: Result:='26-Valor do IOF de seguro inválido' ;
        27: Result:='27-Nome do sacado/cedente inválido ou não informado' ;
        28: Result:='28-Data do novo vencimento inválida' ;
        29: Result:='29-Endereco não informado' ;
        30: Result:='30-Registro de título já liquidado' ;
        31: Result:='31-Numero do bordero inválido' ;
        32: Result:='32-Nome da pessoa autorizada inválido' ;
        33: Result:='33-Nosso número já existente' ;
        34: Result:='34-Numero da prestação do contrato inválido' ;
        35: Result:='35-Percentual de desconto inválido' ;
        36: Result:='36-Dias para fichamento de protesto inválido' ;
        37: Result:='37-Data de emissão do título inválida' ;
        38: Result:='38-Data do vencimento anterior a data da emissão do título' ;
        39: Result:='39-Comando de alteração indevido para a carteira' ;
        40: Result:='40-Tipo de moeda inválido' ;
        41: Result:='41-Abatimento não permitido' ;
        42: Result:='42-CEP do sacado inválido /ECT/' ;
        43: Result:='43-Codigo de unidade variavel incompativel com a data emissão do título' ;
        44: Result:='44-Dados para debito ao sacado inválidos' ;
        45: Result:='45-Carteira' ;
        46: Result:='46-Convenio encerrado' ;
        47: Result:='47-Título tem valor diverso do informado' ;
        48: Result:='48-Motivo de baixa inválido para a carteira' ;
        49: Result:='49-Abatimento a cancelar não consta do título' ;
        50: Result:='50-Comando incompativel com a carteira' ;
        51: Result:='51-Codigo do convenente inválido' ;
        52: Result:='52-Abatimento igual ou maior que o valor do título' ;
        53: Result:='53-Título já se encontra situação pretendida' ;
        54: Result:='54-Título fora do prazo admitido para a conta 1' ;
        55: Result:='55-Novo vencimento fora dos limites da carteira' ;
        56: Result:='56-Título não pertence ao convenente' ;
        57: Result:='57-Variação incompativel com a carteira' ;
        58: Result:='58-Impossivel a transferencia para a carteira indicada' ;
        59: Result:='59-Título vencido em transferencia para a carteira 51' ;
        60: Result:='60-Título com prazo superior a 179 dias em transferencia para carteira 51' ;
        61: Result:='61-Título já foi fichado para protesto' ;
        62: Result:='62-Alteração da situação de debito inválida para o codigo de responsabilidade' ;
        63: Result:='63-DV do nosso número inválido' ;
        64: Result:='64-Título não passivel de debito/baixa - situação anormal' ;
        65: Result:='65-Título com ordem de não protestar-não pode ser encaminhado a cartorio' ;
        67: Result:='66-Título/carne rejeitado' ;
        80: Result:='80-Nosso número inválido' ;
        81: Result:='81-Data para concessão do desconto inválida' ;
        82: Result:='82-CEP do sacado inválido' ;
        83: Result:='83-Carteira/variação não localizada no cedente' ;
        84: Result:='84-Título não localizado na existencia' ;
        99: Result:='99-Outros motivos' ;
      end;
      //Apartir daqui adicionado por Anderson
    toRetornoLiquidado: //05,06,07,08,15 ou 46
      case CodMotivo of
        01: Result:='01-Liquidação normal';
        02: Result:='02-Liquidação parcial';
        03: Result:='03-Liquidação por saldo';
        04: Result:='04-Liquidação com cheque a compensar';
        05: Result:='05-Liquidação de título sem registro (carteira 7 tipo 4)';
        07: Result:='07-Liquidação na apresentação';
        09: Result:='09-Liquidação em cartório';
      end;
    toRetornoRegistroConfirmado: //02 (Entrada)
      case CodMotivo of
        00: Result:='00-Por meio magnético';
        11: Result:='11-Por via convencional';
        16: Result:='16-Por alteração do código do cedente';
        17: Result:='17-Por alteração da variação';
        18: Result:='18-Por alteração de carteira';
      end;
    toRetornoBaixado, toRetornoBaixadoInstAgencia: //09,10 ou 20 (Baixa) ver ocorrencia 20 componente esta errado
      case CodMotivo of
        00: Result:='00-Solicitada pelo cliente';
        15: Result:='15-Protestado';
        18: Result:='18-Por alteração de carteira';
        19: Result:='19-Débito automático';
        31: Result:='31-Liquidado anteriormente';
        32: Result:='32-Habilitado em processo';
        33: Result:='33-Incobrável por nosso intermédio';
        34: Result:='34-Transferido para créditos em liquidação';
        46: Result:='46-Por alteração da variação';
        47: Result:='47-Por alteração da variação';
        51: Result:='51-Acerto';
        90: Result:='90-Baixa automática';
      end;
  end; //---Fim Anderson
  //Código Projeto ACBr
  {  Case TipoOcorrencia of
    //Associados aos códigos de movimento 02, 03, 26 e 30...
    toRetornoRegistroConfirmado, toRetornoRegistroRecusado, toRetornoInstrucaoRejeitada, toRetornoAlteracaoDadosRejeitados:
      Case CodMotivo of
        01: Result :='01-Código do Banco Inválido';
        02: Result :='02-Código do Registro Detalhe Inválido';
        03: Result :='03-Código do Segmento Inválido';
        04: Result :='04-Código de Movimento Não Permitido para Carteira';
        05: Result :='05-Código de Movimento Inválido';
        06: Result :='06-Tipo/Número de Inscrição do Cedente Inválidos';
        07: Result :='07-Agência/Conta/DV Inválido';
        08: Result :='08-Nosso Número Inválido';
        09: Result :='09-Nosso Número Duplicado';
        10: Result :='10-Carteira Inválida';
        11: Result :='11-Forma de Cadastramento do Título Inválido';
        12: Result :='12-Tipo de Documento Inválido';
        13: Result :='13-Identificação da Emissão do Bloqueto Inválida';
        14: Result :='14-Identificação da Distribuição do Bloqueto Inválida';
        15: Result :='15-Características da Cobrança Incompatíveis';
        16: Result :='16-Data de Vencimento Inválida';
        17: Result :='17-Data de Vencimento Anterior a Data de Emissão';
        18: Result :='18-Vencimento Fora do Prazo de Operação';
        19: Result :='19-Título a Cargo de Bancos Correspondentes com Vencimento Inferior a XX Dias';
        20: Result :='20-Valor do Título Inválido';
        21: Result :='21-Espécie do Título Inválida';
        22: Result :='22-Espécie do Título Não Permitida para a Carteira';
        23: Result :='23-Aceite Inválido';
        24: Result :='24-Data da Emissão Inválida';
        25: Result :='25-Data da Emissão Posterior a Data de Entrada';
        26: Result :='26-Código de Juros de Mora Inválido';
        27: Result :='27-Valor/Taxa de Juros de Mora Inválido';
        28: Result :='28-Código do Desconto Inválido';
        29: Result :='29-Valor do Desconto Maior ou Igual ao Valor do Título';
        30: Result :='30-Desconto a Conceder Não Confere';
        31: Result :='31-Concessão de Desconto - Já Existe Desconto Anterior';
        32: Result :='32-Valor do IOF Inválido';
        33: Result :='33-Valor do Abatimento Inválido';
        34: Result :='34-Valor do Abatimento Maior ou Igual ao Valor do Título';
        35: Result :='35-Valor a Conceder Não Confere';
        36: Result :='36-Concessão de Abatimento - Já Existe Abatimento Anterior';
        37: Result :='37-Código para Protesto Inválido';
        38: Result :='38-Prazo para Protesto Inválido';
        39: Result :='39-Pedido de Protesto Não Permitido para o Título';
        40: Result :='40-Título com Ordem de Protesto Emitida';
        41: Result :='41-Pedido de Cancelamento/Sustação para Títulos sem Instrução de Protesto';
        42: Result :='42-Código para Baixa/Devolução Inválido';
        43: Result :='43-Prazo para Baixa/Devolução Inválido';
        44: Result :='44-Código da Moeda Inválido';
        45: Result :='45-Nome do Sacado Não Informado';
        46: Result :='46-Tipo/Número de Inscrição do Sacado Inválidos';
        47: Result :='47-Endereço do Sacado Não Informado';
        48: Result :='48-CEP Inválido';
        49: Result :='49-CEP Sem Praça de Cobrança (Não Localizado)';
        50: Result :='50-CEP Referente a um Banco Correspondente';
        51: Result :='51-CEP incompatível com a Unidade da Federação';
        52: Result :='52-Unidade da Federação Inválida';
        53: Result :='53-Tipo/Número de Inscrição do Sacador/Avalista Inválidos';
        54: Result :='54-Sacador/Avalista Não Informado';
        55: Result :='55-Nosso número no Banco Correspondente Não Informado';
        56: Result :='56-Código do Banco Correspondente Não Informado';
        57: Result :='57-Código da Multa Inválido';
        58: Result :='58-Data da Multa Inválida';
        59: Result :='59-Valor/Percentual da Multa Inválido';
        60: Result :='60-Movimento para Título Não Cadastrado';
        61: Result :='61-Alteração da Agência Cobradora/DV Inválida';
        62: Result :='62-Tipo de Impressão Inválido';
        63: Result :='63-Entrada para Título já Cadastrado';
        64: Result :='64-Número da Linha Inválido';
        65: Result :='65-Código do Banco para Débito Inválido';
        66: Result :='66-Agência/Conta/DV para Débito Inválido';
        67: Result :='67-Dados para Débito incompatível com a Identificação da Emissão do Bloqueto';
        68: Result :='68-Débito Automático Agendado';
        69: Result :='69-Débito Não Agendado - Erro nos Dados da Remessa';
        70: Result :='70-Débito Não Agendado - Sacado Não Consta do Cadastro de Autorizante';
        71: Result :='71-Débito Não Agendado - Cedente Não Autorizado pelo Sacado';
        72: Result :='72-Débito Não Agendado - Cedente Não Participa da Modalidade Débito Automático';
        73: Result :='73-Débito Não Agendado - Código de Moeda Diferente de Real (R$)';
        74: Result :='74-Débito Não Agendado - Data Vencimento Inválida';
        75: Result :='75-Débito Não Agendado, Conforme seu Pedido, Título Não Registrado';
        76: Result :='76-Débito Não Agendado, Tipo/Num. Inscrição do Debitado, Inválido';
        77: Result :='77-Transferência para Desconto Não Permitida para a Carteira do Título';
        78: Result :='78-Data Inferior ou Igual ao Vencimento para Débito Automático';
        79: Result :='79-Data Juros de Mora Inválido';
        80: Result :='80-Data do Desconto Inválida';
        81: Result :='81-Tentativas de Débito Esgotadas - Baixado';
        82: Result :='82-Tentativas de Débito Esgotadas - Pendente';
        83: Result :='83-Limite Excedido';
        84: Result :='84-Número Autorização Inexistente';
        85: Result :='85-Título com Pagamento Vinculado';
        86: Result :='86-Seu Número Inválido';
        87: Result :='87-e-mail/SMS enviado';
        88: Result :='88-e-mail Lido';
        89: Result :='89-e-mail/SMS devolvido - endereço de e-mail ou número do celular incorreto';
        90: Result :='90-e-mail devolvido - caixa postal cheia';
        91: Result :='91-e-mail/número do celular do sacado não informado';
        92: Result :='92-Sacado optante por Bloqueto Eletrônico - e-mail não enviado';
        93: Result :='93-Código para emissão de bloqueto não permite envio de e-mail';
        94: Result :='94-Código da Carteira inválido para envio e-mail';
        95: Result :='95-Contrato não permite o envio de e-mail';
        96: Result :='96-Número de contrato inválido';
        97: Result :='97-Rejeição da alteração do prazo limite de recebimento (a data deve ser informada no campo 28.3.p)';
        98: Result :='98-Rejeição de dispensa de prazo limite de recebimento';
        99: Result :='99-Rejeição da alteração do número do título dado pelo cedente';
      end;
    //Associados ao código de movimento 28...
    toRetornoDebitoTarifas:
      Case CodMotivo of
        01: Result := '01-Tarifa de Extrato de Posição';
        02: Result := '02-Tarifa de Manutenção de Título Vencido';
        03: Result := '03-Tarifa de Sustação';
        04: Result := '04-Tarifa de Protesto';
        05: Result := '05-Tarifa de Outras Instruções';
        06: Result := '06-Tarifa de Outras Ocorrências';
        07: Result := '07-Tarifa de Envio de Duplicata ao Sacado';
        08: Result := '08-Custas de Protesto';
        09: Result := '09-Custas de Sustação de Protesto';
        10: Result := '10-Custas de Cartório Distribuidor';
        11: Result := '11-Custas de Edital';
        12: Result := '12-Tarifa Sobre Devolução de Título Vencido';
        13: Result := '13-Tarifa Sobre Registro Cobrada na Baixa/Liquidação';
        14: Result := '14-Tarifa Sobre Reapresentação Automática';
        15: Result := '15-Tarifa Sobre Rateio de Crédito';
        16: Result := '16-Tarifa Sobre Informações Via Fax';
        17: Result := '17-Tarifa Sobre Prorrogação de Vencimento';
        18: Result := '18-Tarifa Sobre Alteração de Abatimento/Desconto';
        19: Result := '19-Tarifa Sobre Arquivo mensal (Em Ser)';
        20: Result := '20-Tarifa Sobre Emissão de Bloqueto Pré-Emitido pelo Banco';
      end;
    //Associados aos códigos de movimento 06, 09 e 17...
    toRetornoLiquidado, toRetornoBaixado, toRetornoLiquidadoSemRegistro:
      Case CodMotivo of
        01: Result := '01-Por Saldo';
        02: Result := '02-Por Conta';
        03: Result := '03-Liquidação no Guichê de Caixa em Dinheiro';
        04: Result := '04-Compensação Eletrônica';
        05: Result := '05-Compensação Convencional';
        06: Result := '06-Por Meio Eletrônico';
        07: Result := '07-Após Feriado Local';
        08: Result := '08-Em Cartório';
        09: Result := '09-Comandada Banco';
        10: Result := '10-Comandada Cliente Arquivo';
        11: Result := '11-Comandada Cliente On-line';
        12: Result := '12-Decurso Prazo - Cliente';
        13: Result := '13-Decurso Prazo - Banco';
        14: Result := '14-Protestado';
        15: Result := '15-Título Excluído';
        30: Result := '30-Liquidação no Guichê de Caixa em Cheque';
        31: Result := '31-Liquidação em banco correspondente';
        32: Result := '32-Liquidação Terminal de Auto-Atendimento';
        33: Result := '33-Liquidação na Internet (Home banking)';
        34: Result := '34-Liquidado Office Banking';
        35: Result := '35-Liquidado Correspondente em Dinheiro';
        36: Result := '36-Liquidado Correspondente em Cheque';
        37: Result := '37-Liquidado por meio de Central de Atendimento (Telefone)';
      end;
  end;}
end;




procedure TACBrBancoBrasil.LerRetorno400(ARetorno: TStringList);
var
  Titulo : TACBrTitulo;
  ContLinha, CodOcorrencia, CodMotivo, MotivoLinha : Integer;
  rAgencia, rDigitoAgencia, rConta :String;
  rDigitoConta, rCodigoCedente     :String;
  Linha, rCedente, rCNPJCPF        :String;
begin
   fpTamanhoMaximoNossoNum := 20;
   ContLinha := 0;

   if StrToIntDef(copy(ARetorno.Strings[0],77,3),-1) <> Numero then
      raise Exception.Create(ACBrStr(ACBrBanco.ACBrBoleto.NomeArqRetorno +
                             'não é um arquivo de retorno do '+ Nome));

   rCedente      := trim(Copy(ARetorno[0],47,30));
   rAgencia      := trim(Copy(ARetorno[0],27,4));
   rDigitoAgencia:= Copy(ARetorno[0],31,1);
   rConta        := trim(Copy(ARetorno[1],32,8));
   rDigitoConta  := Copy(ARetorno[0],40,1);
   
   rCodigoCedente:= Copy(ARetorno[0],150,7);


   ACBrBanco.ACBrBoleto.NumeroArquivo := StrToIntDef(Copy(ARetorno[0],101,7),0);

   ACBrBanco.ACBrBoleto.DataArquivo   := StringToDateTimeDef(Copy(ARetorno[0],95,2)+'/'+
                                                             Copy(ARetorno[0],97,2)+'/'+
                                                             Copy(ARetorno[0],99,2),0, 'DD/MM/YY' );

   case StrToIntDef(Copy(ARetorno[1],2,2),0) of
      11: rCNPJCPF := Copy(ARetorno[1],7,11);
      14: rCNPJCPF := Copy(ARetorno[1],4,14);
   else
     rCNPJCPF := Copy(ARetorno[1],4,14);
   end;


   with ACBrBanco.ACBrBoleto do
   begin
      if (not LeCedenteRetorno) and
         ((rAgencia <> OnlyNumber(Cedente.Agencia)) or
          (rConta <> OnlyNumber(Cedente.Conta))) then
         raise Exception.Create(ACBrStr('Agencia\Conta do arquivo inválido'));

      Cedente.Nome         := rCedente;

      if Copy(rCNPJCPF,1,10) <> '0000000000' then
         Cedente.CNPJCPF      := rCNPJCPF;
      Cedente.Agencia      := rAgencia;
      Cedente.AgenciaDigito:= rDigitoAgencia;
      Cedente.Conta        := rConta;
      Cedente.ContaDigito  := rDigitoConta;
      Cedente.CodigoCedente:= rCodigoCedente;

      case StrToIntDef(Copy(ARetorno[1],2,2),0) of
         11: Cedente.TipoInscricao:= pFisica;
      else
             Cedente.TipoInscricao:= pJuridica;
      end;
      ACBrBanco.ACBrBoleto.ListadeBoletos.Clear;
   end;

   ACBrBanco.TamanhoMaximoNossoNum := 20;

   for ContLinha := 1 to ARetorno.Count - 2 do
   begin
      Linha := ARetorno[ContLinha] ;

      if (Copy(Linha,1,1) <> '7') and (Copy(Linha,1,1) <> '1') then
         Continue;

      Titulo := ACBrBanco.ACBrBoleto.CriarTituloNaLista;

      with Titulo do
      begin
         SeuNumero                   := copy(Linha,39,25);
         NumeroDocumento             := copy(Linha,117,10);
         OcorrenciaOriginal.Tipo     := CodOcorrenciaToTipo(StrToIntDef(
                                        copy(Linha,109,2),0));

         CodOcorrencia := StrToInt(IfThen(copy(Linha,109,2) = '00','00',copy(Linha,109,2)));

         if(CodOcorrencia >= 2) and ((CodOcorrencia <= 10)) then
         begin
           MotivoLinha:= 87;
           CodMotivo:= StrToInt(IfThen(copy(Linha,MotivoLinha,2) = '00','00',copy(Linha,87,2)));
           MotivoRejeicaoComando.Add(copy(Linha,87,2));
           DescricaoMotivoRejeicaoComando.Add(CodMotivoRejeicaoToDescricao(OcorrenciaOriginal.Tipo,CodMotivo));
         end;

         DataOcorrencia := StringToDateTimeDef( Copy(Linha,111,2)+'/'+
                                                Copy(Linha,113,2)+'/'+
                                                Copy(Linha,115,2),0, 'DD/MM/YY' );

         Vencimento := StringToDateTimeDef( Copy(Linha,147,2)+'/'+
                                            Copy(Linha,149,2)+'/'+
                                            Copy(Linha,151,2),0, 'DD/MM/YY' );

         ValorDocumento       := StrToFloatDef(Copy(Linha,153,13),0)/100;
         ValorIOF             := StrToFloatDef(Copy(Linha,215,13),0)/100;
         ValorAbatimento      := StrToFloatDef(Copy(Linha,228,13),0)/100;
         ValorDesconto        := StrToFloatDef(Copy(Linha,241,13),0)/100;
         ValorRecebido        := StrToFloatDef(Copy(Linha,254,13),0)/100;
         ValorMoraJuros       := StrToFloatDef(Copy(Linha,267,13),0)/100;
         ValorOutrosCreditos  := StrToFloatDef(Copy(Linha,280,13),0)/100;
         NossoNumero          := Copy(Linha,64,17);
         Carteira             := Copy(Linha,92,3);
         ValorDespesaCobranca := StrToFloatDef(Copy(Linha,182,07),0)/100; //--Anderson: Valor tarifa
         ValorOutrasDespesas  := StrToFloatDef(Copy(Linha,189,13),0)/100;

         if StrToIntDef(Copy(Linha,296,6),0) <> 0 then
            DataCredito:= StringToDateTimeDef( Copy(Linha,176,2)+'/'+
                                               Copy(Linha,178,2)+'/'+
                                               Copy(Linha,180,2),0, 'DD/MM/YY' );
      end;
   end;

   fpTamanhoMaximoNossoNum := 10;
end;



end.
