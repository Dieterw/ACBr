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
  {$IFDEF COMPILER6_UP} dateutils {$ELSE} ACBrD5 {$ENDIF};

type
  { TACBrBancoBrasil}

  TACBrBancoBrasil = class(TACBrBancoClass)
   protected
   public
    Constructor create(AOwner: TACBrBanco);
    function CalcularDigitoVerificador(const ACBrTitulo: TACBrTitulo ): String; override ;
    function MontarCodigoBarras(const ACBrTitulo : TACBrTitulo): String; override;
    function GerarRegistroHeader(NumeroRemessa : Integer): String; override;
    function GerarRegistroTransacao(ACBrTitulo : TACBrTitulo): String; override;
    function GerarRegistroTrailler(ARemessa : TStringList): String;  override;
   end;

implementation

uses ACBrUtil, StrUtils, Variants;

constructor TACBrBancoBrasil.create(AOwner: TACBrBanco);
begin
   inherited create(AOwner);
   fpDigito := 9;
   fpNome   := 'Banco Brasil';
   fpTamanhoMaximoNossoNum := 11;
end;

function TACBrBancoBrasil.CalcularDigitoVerificador(const ACBrTitulo: TACBrTitulo ): String;
begin
   Result := '0';

   Modulo.CalculoPadrao;
   Modulo.MultiplicadorFinal := 7;
   Modulo.Documento := ACBrTitulo.Carteira + ACBrTitulo.NossoNumero;
   Modulo.Calcular;

   if Modulo.DigitoFinal = 0 then
      Result:= 'P'
   else
      Result:= IntToStr(Modulo.DigitoFinal);
end;

function TACBrBancoBrasil.MontarCodigoBarras(const ACBrTitulo : TACBrTitulo): String;
var
  CodigoBarras, FatorVencimento, DigitoCodBarras :String;
  ANossoNumero, AConvenio : string;
begin
    AConvenio := ACBrTitulo.ACBrBoleto.Cedente.Convenio;
    with ACBrTitulo do
    begin

        if (ACBrTitulo.Carteira = '16') or (ACBrTitulo.Carteira = '17') or (ACBrTitulo.Carteira = '18') then
        begin
          if     Length(AConvenio) <= 4 then
                 ANossoNumero := padL(AConvenio, 4, '0') + padL(NossoNumero, 7, '0')

          else if (Length(AConvenio) > 4) and (Length(AConvenio) <= 6) then
                 ANossoNumero := padL(AConvenio, 6, '0') + padL(NossoNumero, 5, '0')

          else if Length(AConvenio) = 7 then
                 ANossoNumero := padL(AConvenio, 7, '0') + padL(NossoNumero, 10, '0');
        end else ANossoNumero := padL(NossoNumero, 11, '0');
    end;

    {Codigo de Barras}
    with ACBrTitulo.ACBrBoleto do
    begin
      FatorVencimento := CalcularFatorVencimento(ACBrTitulo.Vencimento);

      CodigoBarras := IntToStr( Numero ) +
                      '9' +
                      FatorVencimento +
                      IntToStrZero(Round(ACBrTitulo.ValorDocumento * 100), 10) +
                      ANossoNumero +
                      padL(Cedente.Agencia, 4, '0') +
                      padL(Cedente.Conta, 8, '0') +
                      copy(ACBrTitulo.Carteira, 1, 2);

      DigitoCodBarras := CalcularDigitoCodigoBarras(CodigoBarras);
    end;


    Result:= copy( CodigoBarras, 1, 4) + DigitoCodBarras + copy( CodigoBarras, 6, 44) ;
end;

function TACBrBancoBrasil.GerarRegistroHeader(NumeroRemessa : Integer): String;
var
  ATipoInscricao: string;
begin

   with ACBrBanco.ACBrBoleto.Cedente do
   begin
      case TipoInscricao of
         tiPessoaFisica  : ATipoInscricao := '1';
         tiPessoaJuridica: ATipoInscricao := '2';
         tiOutro         : ATipoInscricao := '3';
      end;

          { GERAR REGISTRO-HEADER DO ARQUIVO }

      Result:= IntToStrZero(ACBrBanco.Numero, 3)       + //1 a 3 - Código do banco
               '0000'                                  + //4 a 7 - Lote de serviço
               '0'                                     + //8 - Tipo de registro - Registro header de arquivo
               padL('', 9, ' ')                        + //9 a 17 Uso exclusivo FEBRABAN/CNAB
               ATipoInscricao                           + //18 - Tipo de inscrição do cedente
               padL(CNPJCPF, 14, '0')                  + //19 a 32 -Número de inscrição do cedente
               padL(CodigoCedente, 18, '0') + '  '     + //33 a 52 - Código do convênio no banco [ Alterado conforme instruções da CSO Brasília ] 27-07-09
               padL(Agencia, 5, '0')                   + //53 a 57 - Código da agência do cedente
               padL(AgenciaDigito, 1 , '0')            + //58 - Dígito da agência do cedente
               padL(Conta, 12, '0')                    + //59 a 70 - Número da conta do cedente
               padL(ContaDigito, 1, '0')               + //71 - Dígito da conta do cedente
               ' '                                     + //72 - Dígito verificador da agência / conta
               padR(Nome, 30, ' ')                     + //73 a 102 - Nome do cedente
               padR('BANCO DO BRASIL', 30, ' ')        + //103 a 132 - Nome do banco
               padL('', 10, ' ')                       + //133 a 142 - Uso exclusivo FEBRABAN/CNAB
               '1'                                     + //143 - Código de Remessa (1) / Retorno (2)
               FormatDateTime('ddmmyyyy', Now)         + //144 a 151 - Data do de geração do arquivo
               FormatDateTime('hhmmss', Now)           + //152 a 157 - Hora de geração do arquivo
               padL(IntToStr(NumeroRemessa), 6, '0')   + //158 a 163 - Número seqüencial do arquivo
               '030'                                   + //164 a 166 - Número da versão do layout do arquivo
               padL('',  5, '0')                       + //167 a 171 - Densidade de gravação do arquivo (BPI)
               padL('', 20, '0')                       + // 172 a 191 - Uso reservado do banco
               padL('', 20, '0')                       + // 192 a 211 - Uso reservado da empresa
               padL('', 11, '0')                       + // 212 a 222 - 11 brancos
               'CSP'                                   + // 223 a 225 - 'CSP'
               padL('',  3, '0')                       + // 226 a 228 - Uso exclusivo de Vans
               padL('',  2, '0')                       + // 229 a 230 - Tipo de servico
               padL('', 10, '0');                        //231 a 240 - titulo em carteira de cobranca

          { GERAR REGISTRO HEADER DO LOTE }

      Result:= Result + #13#10 +
               IntToStrZero(ACBrBanco.Numero, 3)       + //1 a 3 - Código do banco
               '0001'                                  + //4 a 7 - Lote de serviço
               '1'                                     + //8 - Tipo de registro - Registro header de arquivo
               'R'                                     + //9 - Tipo de operação: R (Remessa) ou T (Retorno)
               '01'                                    + //10 a 11 - Tipo de serviço: 01 (Cobrança)
               '00'                                    + //12 a 13 - Forma de lançamento: preencher com ZEROS no caso de cobrança
               '020'                                   + //14 a 16 - Número da versão do layout do lote
               ' '                                     + //17 - Uso exclusivo FEBRABAN/CNAB
               ATipoInscricao                          + //18 - Tipo de inscrição do cedente
               padL(CNPJCPF, 14, '0')                  + //19 a 32 -Número de inscrição do cedente
               padL(CodigoCedente, 18, '0') + '  '     + //33 a 52 - Código do convênio no banco [ Alterado conforme instruções da CSO Brasília ] 27-07-09
               padL(Agencia, 5, '0')                   + //53 a 57 - Código da agência do cedente
               padL(AgenciaDigito, 1 , '0')            + //58 - Dígito da agência do cedente
               padL(Conta, 12, '0')                    + //59 a 70 - Número da conta do cedente
               padL(ContaDigito, 1, '0')               + //71 - Dígito da conta do cedente
               ' '                                     + //72 - Dígito verificador da agência / conta
               padR(Nome, 30, ' ')                     + //73 a 102 - Nome do cedente
               padL('', 40, ' ')                       + //104 a 143 - Mensagem 1 para todos os boletos do lote
               padL('', 40, ' ')                       + //144 a 183 - Mensagem 2 para todos os boletos do lote
               padL(IntToStr(NumeroRemessa), 8, '0')   + //184 a 191 - Número do arquivo
               FormatDateTime('ddmmyyyy', Now)         + //192 a 199 - Data de geração do arquivo
               padL('', 8, '0')                        + //200 a 207 - Data do crédito - Só para arquivo retorno
               padL('', 33, ' ');                        //208 a 240 - Uso exclusivo FEBRABAN/CNAB
   end;
end;

function TACBrBancoBrasil.GerarRegistroTransacao(ACBrTitulo : TACBrTitulo): String;
var ATipoInscricao, ATipoOcorrencia, ATipoBoleto, ADataMoraJuros,
    ADataDesconto  : string;
begin
   with ACBrTitulo do
   begin
         {SEGMENTO P}

         {Pegando tipo de pessoa do Cendente}
         case ACBrBoleto.Cedente.TipoInscricao of
            tiPessoaFisica  : ATipoInscricao := '1';
            tiPessoaJuridica: ATipoInscricao := '2';
            tiOutro         : ATipoInscricao := '9';
         end;

         {Pegando o Tipo de Ocorrencia}
         case TipoOcorrencia of
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

         {Pegando Tipo de Boleto} //Quem emite e quem distribui o boleto?
         case ACBrBoleto.Cedente.TipoBoleto of
              tbCliEmite        : ATipoBoleto := '1' + '1';
              tbBancoEmite      : ATipoBoleto := '2' + '2';
              tbBancoReemite    : ATipoBoleto := '4' + '1';
              tbBancoNaoReemite : ATipoBoleto := '5' + '2';
         end;

         {Mora Juros}
         if (ValorMoraJuros > 0) then
         begin
             if   (DataMoraJuros <> Null) then
                  ADataMoraJuros := FormatDateTime('ddmmyyyy', DataMoraJuros)
             else ADataMoraJuros := padL('', 8, '0');
         end else ADataMoraJuros := padL('', 8, '0');

         {Descontos}
         if (ValorDesconto > 0) then
         begin
            if    (DataDesconto <> Null) then
                  ADataDesconto := FormatDateTime('ddmmyyyy', DataDesconto)
            else  ADataDesconto := padL('', 8, '0');
         end else ADataDesconto := padL('', 8, '0');

      Result:= IntToStrZero(ACBrBanco.Numero, 3)                          + //1 a 3 - Código do banco
               '0001'                                                     + //4 a 7 - Lote de serviço
               '3'                                                        + //8 - Tipo do registro: Registro detalhe
               IntToStrZero(ACBrBoleto.ListadeBoletos.IndexOf(ACBrTitulo)+ 2 ,5) + //9 a 13 - Número seqüencial do registro no lote - Cada título tem 2 registros (P e Q)
               'P'                                                        + //14 - Código do segmento do registro detalhe
               ' '                                                        + //15 - Uso exclusivo FEBRABAN/CNAB: Branco
               ATipoOcorrencia                                            + //16 a 17 - Código de movimento
               padL(ACBrBoleto.Cedente.Agencia, 5, '0')                   + //18 a 22 - Agência mantenedora da conta
               padL(ACBrBoleto.Cedente.AgenciaDigito, 1 , '0')            + //23 -Dígito verificador da agência
               padL(ACBrBoleto.Cedente.Conta, 12, '0')                    + //24 a 35 - Número da conta corrente
               padL(ACBrBoleto.Cedente.ContaDigito, 1, '0')               + //36 - Dígito verificador da conta
               ' '                                                        + //37 - Dígito verificador da agência / conta
               padR(NossoNumero, 20, '0')                                 + //38 a 57 - Nosso número - identificação do título no banco
               '1'                                                        + //58 - Cobrança Simples
               '1'                                                        + //59 - Forma de cadastramento do título no banco: com cadastramento
               '1'                                                        + //60 - Tipo de documento: Tradicional
               ATipoBoleto                                                + //61 a 62 - Quem emite e quem distribui o boleto?
               padL(NumeroDocumento, 10, '0') + '00000'                   + //63 a 72 - Número que identifica o título na empresa [ Alterado conforme instruções da CSO Brasília ] {27-07-09}
               FormatDateTime('ddmmyyyy', Vencimento)                     + //78 a 85 - Data de vencimento do título
               IntToStrZero( round( ValorDocumento * 100), 13)            + //86 a 100 - Valor nominal do título
               padL('', 5, '0')                                           + //101 a 105 - Agência cobradora. Se ficar em branco, a caixa determina automaticamente pelo CEP do sacado
               ' '                                                        + //106 - Dígito da agência cobradora
               EspecieDoc                                                 + //107 a 108 - Espécie do documento
               IfThen(Aceite = 'S', 'A', 'N')                             + //109 - Identificação de título Aceito / Não aceito
               FormatDateTime('ddmmyyyy', DataDocumento)                  + //110 a 117 - Data da emissão do documento
               IfThen(ValorMoraJuros > 0, '1', '0')                       + //118 - Código de juros de mora: Valor por dia
               ADataMoraJuros                                             + //119 a 126 - Data a partir da qual serão cobrados juros

               IfThen(ValorMoraJuros > 0, IntToStrZero( round(ValorMoraJuros * 100), 15),
                    padL('', 15, '0'))                                    + //127 a 141 - Valor de juros de mora por dia

               IfThen(ValorDesconto > 0, '1', '0')                        + //142 - Código de desconto: Valor fixo até a data informada
               ADataDesconto                                              + //143 a 150 - Data do desconto

               IfThen(ValorDesconto > 0, IntToStrZero( round(ValorDesconto * 100), 15),
               padL('', 15, '0'))                                         + //151 a 165 - Valor do desconto por dia
               IntToStrZero( round(ValorIOF * 100), 15)                   + //166 a 180 - Valor do IOF a ser recolhido
               IntToStrZero( round(ValorAbatimento * 100), 13)            + //181 a 195 - Valor do abatimento
               padL(SeuNumero, 25, ' ')                                   + //196 a 220 - Identificação do título na empresa
               IfThen((DataProtesto <> null) and (DataProtesto > Vencimento), '1', '3') + //221 - Código de protesto: Protestar em XX dias corridos
               IfThen((DataProtesto <> null) and (DataProtesto > Vencimento),
                    padL(IntToStr(DaysBetween(DataProtesto, Vencimento)), 2, '0'), '00') + //222 a 223 - Prazo para protesto (em dias corridos)
               ' '                                                        + //224 - Campo não tratado pelo BB [ Alterado conforme instruções da CSO Brasília ] {27-07-09}
               '   '                                                      + //225 a 227 - Campo não tratado pelo BB [ Alterado conforme instruções da CSO Brasília ] {27-07-09}
               '09'                                                       + //228 a 229 - Código da moeda: Real 
               padL('', 10 , ' ')                                         + //230 a 239 - Uso exclusivo FEBRABAN/CNAB
               ' ';                                                         //240 - Uso exclusivo FEBRABAN/CNAB

         {SEGMENTO Q}
      Result:= Result + #13#10 +
               IntToStrZero(ACBrBanco.Numero, 3)                          + //Código do banco
               '0001'                                                     + //Número do lote
               '3'                                                        + //Tipo do registro: Registro detalhe
               IntToStrZero((2 * ACBrBoleto.ListadeBoletos.IndexOf(ACBrTitulo))+ 2 ,5) + //Número seqüencial do registro no lote - Cada título tem 2 registros (P e Q)
               'Q'                                                        + //Código do segmento do registro detalhe
               ' '                                                        + //Uso exclusivo FEBRABAN/CNAB: Branco
                        {Dados do sacado}
               ATipoInscricao                                             + //Tipo inscricao
               padL(Sacado.CNPJCPF, 15, '0')                              +
               padL(Sacado.NomeSacado, 40, ' ')                                 +
               padL(Sacado.Logradouro +' '+ Sacado.Numero +' '+ Sacado.Complemento , 40, ' ') +
               padL(Sacado.Bairro, 15, ' ')                               +
               padR(Sacado.CEP, 8, '0')                                   +
               padR(Sacado.Cidade, 15, ' ')                               +
               padL(Sacado.UF, 2, ' ')                                    +
                        {Dados do sacador/avalista}
               '0'                                                        + //Tipo de inscrição: Não informado
               padL('', 15, '0')                                          + //Número de inscrição
               padL('', 40, ' ')                                          + //Nome do sacador/avalista
               padL('', 3, ' ')                                           + //Uso exclusivo FEBRABAN/CNAB
               padL('',20, ' ')                                           + //Uso exclusivo FEBRABAN/CNAB
               padL('', 8, ' ');                                            //Uso exclusivo FEBRABAN/CNAB
      end; 
end;

function TACBrBancoBrasil.GerarRegistroTrailler( ARemessa : TStringList ): String;
begin
          {REGISTRO TRAILER DO LOTE}
      Result:= IntToStrZero(ACBrBanco.Numero, 3)                          + //Código do banco
               '0001'                                                     + //Número do lote
               '5'                                                        + //Tipo do registro: Registro trailer do lote
               Space(9)                                                   + //Uso exclusivo FEBRABAN/CNAB
               IntToStrZero(ARemessa.Count, 6)                            + //Quantidade de Registro da Remessa
               padL('', 6, '0')                                           + //Quantidade títulos em cobrança
               padL('',17, '0')                                           + //Valor dos títulos em carteiras}
               Space(23)                                                  + //Uso exclusivo FEBRABAN/CNAB}
               padL('', 6, '0')                                           + //Quantidade títulos em cobrança
               padL('',17, '0')                                           + //Valor dos títulos em carteiras}
               padL('',31, '0')                                           + //Quantidade títulos em cobrança
               padL('',117,'0')                                           ;

          {GERAR REGISTRO TRAILER DO ARQUIVO}
      Result:= Result + #13#10 +
               IntToStrZero(ACBrBanco.Numero, 3)                          + //Código do banco
               '9999'                                                     + //Lote de serviço
               '9'                                                        + //Tipo do registro: Registro trailer do arquivo
               space(9)                                                   + //Uso exclusivo FEBRABAN/CNAB}
               '000001'                                                   + //Quantidade de lotes do arquivo}
               IntToStrZero(ARemessa.Count, 6)                            + //Quantidade de registros do arquivo, inclusive este registro que está sendo criado agora}
               space(6)                                                   + //Uso exclusivo FEBRABAN/CNAB}
               space(205);                                                  //Uso exclusivo FEBRABAN/CNAB}

end;

end.
