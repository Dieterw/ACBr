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

unit ACBrBancoItau;

interface

uses
  Classes, SysUtils, ACBrBoleto,
  {$IFDEF COMPILER6_UP} dateutils {$ELSE} ACBrD5 {$ENDIF};

type
  { TACBrBancoItau}

  TACBrBancoItau = class(TACBrBancoClass)
   protected
   public
    Constructor create(AOwner: TACBrBanco);
    function CalcularDigitoVerificador(const ACBrTitulo: TACBrTitulo ): String; override ;
    function MontarCodigoBarras(const ACBrTitulo : TACBrTitulo): String; override;
    function MontarCampoNossoNumero ( const ACBrTitulo: TACBrTitulo) : String; override;
    function MontarCampoCodigoCedente(const ACBrTitulo: TACBrTitulo): String; override;
    function GerarRegistroHeader240(NumeroRemessa : Integer): String; override;
    function GerarRegistroTransacao240(ACBrTitulo : TACBrTitulo): String; override;
    function GerarRegistroTrailler240(ARemessa : TStringList): String;  override;
   end;

implementation

uses ACBrUtil, StrUtils, Variants,ACBrValidador;

constructor TACBrBancoItau.create(AOwner: TACBrBanco);
begin
   inherited create(AOwner);
   fpDigito := 7;
   fpNome   := 'Banco Itau';
   fpTamanhoMaximoNossoNum := 8
end;

function TACBrBancoItau.CalcularDigitoVerificador(const ACBrTitulo: TACBrTitulo ): String;
var
  Docto: String;
begin
   Result := '0';
   Docto := '';

   with ACBrTitulo do
   begin
      Docto := padR(Carteira,3,'0') + padR(NossoNumero,TamanhoMaximoNossoNum,'0');
      if not ((Carteira = '126') or (Carteira = '131') or (Carteira = '146') or
             (Carteira = '150') or (Carteira = '168')) then
         Docto := padr(ACBrBoleto.Cedente.Agencia,4,'0') + padr(ACBrBoleto.Cedente.Conta,5,'0') + docto
      else
         Docto := padR(ACBrTitulo.ACBrBoleto.Cedente.Agencia,4,'0') +
                  padR(ACBrTitulo.ACBrBoleto.Cedente.Conta,5,'0') +
                  padR(ACBrTitulo.Carteira,3,'0') +
                  padR(ACBrTitulo.NossoNumero,TamanhoMaximoNossoNum,'0')
   end;

   Modulo.MultiplicadorInicial := 1;
   Modulo.MultiplicadorFinal   := 2;
   Modulo.MultiplicadorAtual   := 2;
   Modulo.FormulaDigito := frModulo10;
   Modulo.Documento:= Docto;
   Modulo.Calcular;
   Result := IntToStr(Modulo.DigitoFinal);
 
end;

function TACBrBancoItau.MontarCodigoBarras(const ACBrTitulo : TACBrTitulo): String;
var
  CodigoBarras, FatorVencimento, DigitoCodBarras :String;
  ANossoNumero, aAgenciaCC : string;
begin
    {Codigo de Barras}
    with ACBrTitulo.ACBrBoleto do
    begin
      FatorVencimento := CalcularFatorVencimento(ACBrTitulo.Vencimento);

      ANossoNumero := padR(ACBrTitulo.Carteira,3,'0') +
                      padR(ACBrTitulo.NossoNumero,8,'0') +
                      CalcularDigitoVerificador(ACBrTitulo);

      aAgenciaCC   := padR(Cedente.Agencia, 4, '0') +
                      padR(Cedente.Conta, 5, '0') +
                      Cedente.ContaDigito;

      CodigoBarras := IntToStr( Numero ) +
                      '9' +
                      FatorVencimento +
                      IntToStrZero(Round(ACBrTitulo.ValorDocumento * 100), 10) +
                      ANossoNumero +
                      aAgenciaCC +
                      '000';

     DigitoCodBarras := CalcularDigitoCodigoBarras(CodigoBarras);
    end;
    Result:= copy( CodigoBarras, 1, 4) + DigitoCodBarras + copy( CodigoBarras, 5, 39) ;
end;

function TACBrBancoItau.MontarCampoNossoNumero ( const ACBrTitulo: TACBrTitulo
   ) : String;
var
  NossoNr: String;
begin
  with ACBrTitulo do
  begin
    NossoNr := padR(Carteira,3,'0') + padR(NossoNumero,TamanhoMaximoNossoNum,'0');
  end;
  Insert('/',NossoNr,4);  Insert('-',NossoNr,13);
  Result := NossoNr + CalcularDigitoVerificador(ACBrTitulo);
end;

function TACBrBancoItau.MontarCampoCodigoCedente (
   const ACBrTitulo: TACBrTitulo ) : String;
begin
   Result := ACBrTitulo.ACBrBoleto.Cedente.Agencia+'/'+
            ACBrTitulo.ACBrBoleto.Cedente.Conta+'-'+
            ACBrTitulo.ACBrBoleto.Cedente.ContaDigito;
end;

function TACBrBancoItau.GerarRegistroHeader240(NumeroRemessa : Integer): String;
var
  ATipoInscricao: string;
begin

   with ACBrBanco.ACBrBoleto.Cedente do
   begin
      case TipoInscricao of
         pFisica  : ATipoInscricao := '1';
         pJuridica: ATipoInscricao := '2';
         pOutras  : ATipoInscricao := '3';
      end;

          { GERAR REGISTRO-HEADER DO ARQUIVO }

      Result:= IntToStrZero(ACBrBanco.Numero, 3)        + //1 a 3 - Código do banco
               '0000'                                   + //4 a 7 - Lote de serviço
               '0'                                      + //8 - Tipo de registro - Registro header de arquivo
               space(9)                                 + //9 a 17 Uso exclusivo FEBRABAN/CNAB
               ATipoInscricao                           + //18 - Tipo de inscrição do cedente
               padR(CNPJCPF, 14, '0')                   + //19 a 32 -Número de inscrição do cedente
               space(20)                                + // 33 a 52 - Brancos
               '0'                                      + // 53 - Zeros
               padR(Agencia, 4, '0')                    + //54 a 57 - Código da agência do cedente
               ' '                                      + // 58 - Brancos
               '0000000'                                + // 59 a 65 - Zeros
               padR(Conta, 5, '0')                      + // 66 a 70 - Número da conta do cedente
               ' '                                      + // 71 - Branco
               padR(ContaDigito, 1, '0')                + // 72 - Dígito da conta do cedente
               padL(Nome, 30, ' ')                      + // 73 a 102 - Nome do cedente
               padL('BANCO ITAU SA', 30, ' ')           + // 103 a 132 - Nome do banco
               space(10)                                + // 133 A 142 - Brancos
               '1'                                      + // 143 - Código de Remessa (1) / Retorno (2)
               FormatDateTime('ddmmyyyy', Now)          + // 144 a 151 - Data do de geração do arquivo
               FormatDateTime('hhmmss', Now)            + // 152 a 157 - Hora de geração do arquivo
               '000000'                                 + // 158 a 163 - Número sequencial do arquivo retorno
               '040'                                    + // 164 a 166 - Número da versão do layout do arquivo
               '00000'                                  + // 167 a 171 - Zeros
               space(54)                                + // 172 a 225 - 54 Brancos
               '000'                                    + // 226 a 228 - zeros
               space(12);                                 // 229 a 240 - Brancos

     { GERAR REGISTRO HEADER DO LOTE }

      Result:= Result + #13#10 +
               IntToStrZero(ACBrBanco.Numero, 3)       + //1 a 3 - Código do banco
               '0001'                                  + //4 a 7 - Lote de serviço
               '1'                                     + //8 - Tipo de registro - Registro header de arquivo
               'R'                                     + //9 - Tipo de operação: R (Remessa) ou T (Retorno)
               '01'                                    + //10 a 11 - Tipo de serviço: 01 (Cobrança)
               '00'                                    + //12 a 13 - Forma de lançamento: preencher com ZEROS no caso de cobrança
               '030'                                   + //14 a 16 - Número da versão do layout do lote
               ' '                                     + //17 - Uso exclusivo FEBRABAN/CNAB
               ATipoInscricao                          + //18 - Tipo de inscrição do cedente
               padR(CNPJCPF, 15, '0')                  + //19 a 33 -Número de inscrição do cedente
               space(20)                               + //34 a 53 - Brancos
               '0'                                     + // 54 - Zeros
               padR(Agencia, 4, '0')                   + //55 a 58 - Código da agência do cedente
               ' '                                     + // 59
               '0000000'                               + // 60 a 66
               padR(Conta, 5, '0')                     + //67 a 71 - Número da conta do cedente
               ' '                                     + // 72
               ContaDigito                             + // 73 - Dígito verificador da agência / conta
               padL(Nome, 30, ' ')                     + //74 a 103 - Nome do cedente
               space(80)                               + // 104 a 183 - Brancos
               '00000000'                              + // 184 a 191 - Número sequência do arquivo retorno.
               FormatDateTime('ddmmyyyy', Now)         + //192 a 199 - Data de geração do arquivo
               padR('', 8, '0')                        + //200 a 207 - Data do crédito - Só para arquivo retorno
               space(33);                                //208 a 240 - Uso exclusivo FEBRABAN/CNAB
   end;
end;

function TACBrBancoItau.GerarRegistroTransacao240(ACBrTitulo : TACBrTitulo): String;
var ATipoInscricao, ATipoOcorrencia, ATipoBoleto, ADataMoraJuros, 
    ADataDesconto,ATipoAceite : string;
begin
   with ACBrTitulo do
   begin
         {SEGMENTO P}

         {Pegando o Tipo de Ocorrencia}
         case OcorrenciaOriginal.Tipo of
            toRemessaBaixar                    : ATipoOcorrencia := '02';
            toRemessaConcederAbatimento        : ATipoOcorrencia := '04';
            toRemessaCancelarAbatimento        : ATipoOcorrencia := '05';
            toRemessaAlterarVencimento         : ATipoOcorrencia := '06';
          //  toRemessaConcederDesconto          : ATipoOcorrencia := '07';
          //  toRemessaCancelarDesconto          : ATipoOcorrencia := '08';
            toRemessaSustarProtesto            : ATipoOcorrencia := '18';
            toRemessaCancelarInstrucaoProtesto : ATipoOcorrencia := '10';
          //  toRemessaAlterarNomeEnderecoSacado : ATipoOcorrencia := '12';

          //  toRemessaDispensarJuros            : ATipoOcorrencia := '31';
         else
            ATipoOcorrencia := '01';
         end;

         { Pegando o Aceite do Titulo }
         case Aceite of
            atSim :  ATipoAceite := 'A';
            atNao :  ATipoAceite := 'N';
         end;
         {Pegando Tipo de Boleto} //Quem emite e quem distribui o boleto?
         case ACBrBoleto.Cedente.ResponEmissao of
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
             else ADataMoraJuros := padR('', 8, '0');
         end else ADataMoraJuros := padR('', 8, '0');

         {Descontos}
         if (ValorDesconto > 0) then
         begin
            if    (DataDesconto <> Null) then
                  ADataDesconto := FormatDateTime('ddmmyyyy', DataDesconto)
            else  ADataDesconto := padR('', 8, '0');
         end else ADataDesconto := padR('', 8, '0');

      Result:= IntToStrZero(ACBrBanco.Numero, 3)                          + //1 a 3 - Código do banco
               '0001'                                                     + //4 a 7 - Lote de serviço
               '3'                                                        + //8 - Tipo do registro: Registro detalhe
               IntToStrZero(ACBrBoleto.ListadeBoletos.IndexOf(ACBrTitulo)+ 1 ,5) + //9 a 13 - Número seqüencial do registro no lote - Cada registro possui dois segmentos
               'P'                                                        + //14 - Código do segmento do registro detalhe
               ' '                                                        + //15 - Uso exclusivo FEBRABAN/CNAB: Branco
               ATipoOcorrencia                                            + //16 a 17 - Código de movimento
               '0'                                                        + // 18
               padR(ACBrBoleto.Cedente.Agencia, 4, '0')                   + //19 a 22 - Agência mantenedora da conta
               ' '                                                        + // 23
               '0000000'                                                  + //24 a 30 - Complemento de Registro
               padR(ACBrBoleto.Cedente.Conta,5,'0')                       + //31 a 35 - Número da Conta Corrente
               ' '                                                        + // 36
               ACBrBoleto.Cedente.ContaDigito                             + //37 - Dígito verificador da agência / conta
               padR(Carteira, 3, '0')                                     + // 38 a 40 - Carteira
               padR(NossoNumero, 8, '0')                                  + // 41 a 48 - Nosso número - identificação do título no banco
               CalcularDigitoVerificador(ACBrTitulo)                      + // 49 - Dígito verificador da agência / conta preencher somente em cobrança sem registro
               space(8)                                                   + // 50 a 57 - Brancos
               padL('', 5, '0')                                           + // 58 a 62 - Complemento
               padL(NumeroDocumento, 10, ' ')                             + // 63 a 72 - Número que identifica o título na empresa [ Alterado conforme instruções da CSO Brasília ] {27-07-09}

               space(5)                                                   + // 73 a 77 - Brancos
               FormatDateTime('ddmmyyyy', Vencimento)                     + // 78 a 85 - Data de vencimento do título
               IntToStrZero( round( ValorDocumento * 100), 15)            + // 86 a 100 - Valor nominal do título
               '00000'                                                    + // 101 a 105 - Agência cobradora. // Ficando com Zeros o Itaú definirá a agência cobradora pelo CEP do sacado
               ' '                                                        + // 106 - Dígito da agência cobradora
               padL(EspecieDoc,2)                                                 + // 107 a 108 - Espécie do documento
               ATipoAceite                             + // 109 - Identificação de título Aceito / Não aceito
               FormatDateTime('ddmmyyyy', DataDocumento)                  + // 110 a 117 - Data da emissão do documento
               '0'                                                        + // 118 - Zeros
               ADataMoraJuros                                             + //119 a 126 - Data a partir da qual serão cobrados juros
               IfThen(ValorMoraJuros > 0, IntToStrZero( round(ValorMoraJuros * 100), 15),
                padR('', 15, '0'))                                        + //127 a 141 - Valor de juros de mora por dia
//               ValorMoraJuros                                             + //127 a 141 - Valor de Mora por dia de atraso
               '0'                                                        + // 142 - Zeros
               ADataDesconto                                             + // 143 a 150 - Data limite para desconto
               IfThen(ValorDesconto > 0, IntToStrZero( round(ValorDesconto * 100), 15),
               padR('', 15, '0'))                                         + //151 a 165 - Valor do desconto por dia
               IntToStrZero( round(ValorIOF * 100), 15)                   + //166 a 180 - Valor do IOF a ser recolhido
               IntToStrZero( round(ValorAbatimento * 100), 15)            + //181 a 195 - Valor do abatimento
               padL(SeuNumero, 25, ' ')                                   + //196 a 220 - Identificação do título na empresa
               IfThen((DataProtesto <> null) and (DataProtesto > Vencimento), '1', '3') + //221 - Código de protesto: Protestar em XX dias corridos
               IfThen((DataProtesto <> null) and (DataProtesto > Vencimento),
                    padR(IntToStr(DaysBetween(DataProtesto, Vencimento)), 2, '0'), '00') + //222 a 223 - Prazo para protesto (em dias corridos)
               '0'                                                        + // 224 - Código de Baixa
               '00'                                                       + // 225 A 226 - Dias para baixa
               '0000000000000 ';

      {SEGMENTO Q}

         {Pegando tipo de pessoa do Sacado}
         case Sacado.Pessoa of
            pFisica  : ATipoInscricao := '1';
            pJuridica: ATipoInscricao := '2';
            pOutras  : ATipoInscricao := '9';
         end;

      Result:= Result + #13#10 +
               IntToStrZero(ACBrBanco.Numero, 3)                          + //Código do banco
               '0001'                                                     + //Número do lote
               '3'                                                        + //Tipo do registro: Registro detalhe
               IntToStrZero((ACBrBoleto.ListadeBoletos.IndexOf(ACBrTitulo))+ 1 ,5) + //Número seqüencial do registro no lote - Cada registro possui dois segmentos
               'Q'                                                        + //Código do segmento do registro detalhe
               ' '                                                        + //Uso exclusivo FEBRABAN/CNAB: Branco
               '01'                                                       + // 16 a 17
                        {Dados do sacado}
               ATipoInscricao                                             + // 18 a 18 Tipo inscricao
               padR(Sacado.CNPJCPF, 15, '0')                              + // 19 a 33
               padL(Sacado.NomeSacado, 30, ' ')                           + // 34 a 63
               space(10)                                                  + // 64 a 73
               padL(Sacado.Logradouro +' '+ Sacado.Numero +' '+ Sacado.Complemento , 40, ' ') + // 74 a 113
               padL(Sacado.Bairro, 15, ' ')                               +  // 114 a 128
               padR(Sacado.CEP, 8, '0')                                   +  // 129 a 136
               padL(Sacado.Cidade, 15, ' ')                               +  // 137 a 151
               padL(Sacado.UF, 2, ' ')                                    +  // 152 a 153
                        {Dados do sacador/avalista}
               '0'                                                        + //Tipo de inscrição: Não informado
               padR('', 15, '0')                                          + //Número de inscrição
               padL('', 30, ' ')                                          + //Nome do sacador/avalista
               space(10)                                                  + //Uso exclusivo FEBRABAN/CNAB
               padL('0',3, '0')                                           + //Uso exclusivo FEBRABAN/CNAB
               space(28);                                            //Uso exclusivo FEBRABAN/CNAB
      end;
end;

function TACBrBancoItau.GerarRegistroTrailler240( ARemessa : TStringList ): String;
begin
          {REGISTRO TRAILER DO LOTE}
      Result:= IntToStrZero(ACBrBanco.Numero, 3)                          + //Código do banco
               '0001'                                                     + //Número do lote
               '5'                                                        + //Tipo do registro: Registro trailer do lote
               Space(9)                                                   + //Uso exclusivo FEBRABAN/CNAB
               IntToStrZero(ARemessa.Count, 6)                            + //Quantidade de Registro da Remessa
               padR('', 6, '0')                                           + // Quantidade de títulos em cobrança simples
               padR('',17, '0')                                           + //Valor dos títulos em cobrança simples
               padR('', 6, '0')                                           + //Quantidade títulos em cobrança vinculada
               padR('',17, '0')                                           + //Valor dos títulos em cobrança vinculada
               padR('',46, '0')                                           + //Complemento
               padL('', 8, ' ')                                           + //Referencia do aviso bancario
               space(117);

          {GERAR REGISTRO TRAILER DO ARQUIVO}
      Result:= Result + #13#10 +
               IntToStrZero(ACBrBanco.Numero, 3)                          + //Código do banco
               '9999'                                                     + //Lote de serviço
               '9'                                                        + //Tipo do registro: Registro trailer do arquivo
               space(9)                                                   + //Uso exclusivo FEBRABAN/CNAB}
               '000001'                                                   + //Quantidade de lotes do arquivo}
               IntToStrZero(ARemessa.Count, 6)                            + //Quantidade de registros do arquivo, inclusive este registro que está sendo criado agora}
               padR('', 6, '0')                                           + //Complemento
               space(205);
//      Result := Result + #13#10;
end;


end.
