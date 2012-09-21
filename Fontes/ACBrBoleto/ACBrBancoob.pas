{******************************************************************************}
{ Projeto: Componentes ACBr                                                    }
{  Biblioteca multiplataforma de componentes Delphi para interação com equipa- }
{ mentos de Automação Comercial utilizados no Brasil                           }
{                                                                              }
{ Direitos Autorais Reservados (c) 2009 Daniel Simoes de Almeida               }
{                                                                              }
{ Colaboradores nesse arquivo:   DOUGLAS TYBEL                                 }
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
{ Desenvolvedor desta unit: DOUGLAS TYBEL -  dtybel@yahoo.com.br  -  www.facilassim.com.br  }
{                                                                              }
{******************************************************************************}

{Somente é aceito o Convênio Carteira 1 Sem Registro} 

{$I ACBr.inc}

unit ACBrBancoob;

interface

uses
  Classes, SysUtils, ACBrBoleto,
  {$IFDEF COMPILER6_UP} DateUtils {$ELSE} ACBrD5, FileCtrl {$ENDIF};

type

  { TACBrBancoob}

  TACBrBancoob = class(TACBrBancoClass)
   protected
   private
      I: Int64;
   public
    Constructor create(AOwner: TACBrBanco);
    function CalcularDigitoVerificador(const ACBrTitulo: TACBrTitulo ): String; override;
    function MontarCodigoBarras(const ACBrTitulo : TACBrTitulo): String; override;
    function MontarCampoCodigoCedente(const ACBrTitulo: TACBrTitulo): String; override;
    function MontarCampoNossoNumero(const ACBrTitulo :TACBrTitulo): String; override;
    function GerarRegistroHeader400(NumeroRemessa : Integer): String; override;
    function GerarRegistroTransacao400(ACBrTitulo :TACBrTitulo): String; override;
    function GerarRegistroTrailler400( ARemessa: TStringList  ): String; override;
    function GerarRegistroHeader240(NumeroRemessa : Integer): String; override;
    function GerarRegistroTransacao240(ACBrTitulo : TACBrTitulo): String; override;
    function GerarRegistroTrailler240(ARemessa : TStringList): String;  override;
    Procedure LerRetorno400(ARetorno:TStringList); override;
   end;

implementation

uses ACBrUtil, StrUtils, Variants,ACBrValidador;

constructor TACBrBancoob.create(AOwner: TACBrBanco);
begin
   inherited create(AOwner);
   fpDigito := 0;
   fpNome   := 'SICOOB';
   fpNumero:= 756;
   fpTamanhoMaximoNossoNum := 7;
   fpTamanhoCarteira := 1;
end;

function TACBrBancoob.CalcularDigitoVerificador(const ACBrTitulo: TACBrTitulo ): String;
var
  Num, Res :String;
  i, base, digito : Integer;
const
  indice = '319731973197319731973';
begin

   Result := '0';

   Num :=  PadR(ACBrTitulo.ACBrBoleto.Cedente.Agencia, 4, '0') +
           PadR(ACBrTitulo.ACBrBoleto.Cedente.CodigoCedente, 10, '0') +
           PadR(trim(ACBrTitulo.NossoNumero), 7, '0');


   base := 0;
   for i := 1 to Length(Num) do
   begin
     base := base + ( StrToInt(copy(Num,i,1)) * StrToInt(copy(indice,i,1)) );
   end;
   digito := 11-((  base )-( trunc(base/11) * 11));
   //(Se o Resto for igual a 0 ou 1 então o DV é igual a 0)
   if (digito > 9) then
      digito := 0;

   Res    := IntToStr(digito);
   Result := Res;

   { Para o cálculo do dígito verificador do nosso número, deverá ser utilizada
     a fórmula abaixo:
     Número da Cooperativa    9(4) – 3009
     Código do Cliente   9(10) – cedente
     Nosso Número   9(7) – Iniciado contagem em 1

     Constante para cálculo  = 3197


     a) Concatenar na seqüência completando com zero à esquerda.
        Ex.: Número da Cooperativa  = 0001
             Número do Cliente(cedente)  = 1-9
             Nosso Número  = 21
             000100000000190000021

     b) Alinhar a constante com a seqüência repetindo de traz para frente.
        Ex.: 000100000000190000021
             319731973197319731973

     c) Multiplicar cada componente da seqüência com o seu correspondente da
        constante e somar os resultados.
        Ex.: 1*7 + 1*3 + 9*1 + 2*7 + 1*3 = 36

     d) Calcular o Resto através do Módulo 11.
        Ex.: 36/11 = 3, resto = 3

     e) O resto da divisão deverá ser subtraído de 11 achando assim o DV
        (Se o Resto for igual a 0 ou 1 então o DV é igual a 0).
        Ex.: 11 – 3 = 8, então Nosso Número + DV = 21-8


     Memória de Cálculo
     Coop.(4)|Cliente(10)		    |Nosso Número(7)
     3	   0	 0	9	0	0	0	0	1	3	6	3	5	2	5	9	3	1	1	5	1
     3	   1 	 9	7	3	1	9	7	3	1	9	7	3	1	9	7	3	1	9	7	3
     9	   0	 0	63	0	0	0	0	3	3	54	21	15	2	45	63	9	1	9	35	3 = soma = 335

     digito = 11-((  soma )-( resto inteiro (trunc) da divisao da soma por 11 * 11))
     digito = 11-((  335 )-(30*11))
     digito = 6 }
end;

function TACBrBancoob.MontarCodigoBarras(const ACBrTitulo : TACBrTitulo): String;
var
  CodigoBarras, FatorVencimento, DigitoCodBarras, ANossoNumero,ACarteira :String;
  CampoLivre : String;
begin

    FatorVencimento := CalcularFatorVencimento(ACBrTitulo.Vencimento);

    ANossoNumero := ACBrTitulo.NossoNumero+CalcularDigitoVerificador(ACBrTitulo);

    if (Length(ACBrTitulo.Carteira) > 0 )then
       ACarteira := '1'
    else
       raise Exception.Create( ACBrStr('Carteira Inválida.'+sLineBreak) ) ;

    {Montando Campo Livre}
    CampoLivre    := padR(ACBrTitulo.ACBrBoleto.Cedente.Modalidade, 2, '0') +
                     padR(ACBrTitulo.ACBrBoleto.Cedente.CodigoCedente, 7, '0') +
                     padR(Copy(ANossoNumero,1,8), 8, '0') +  //7 Sequenciais + 1 do digito
                     '001';


    {Codigo de Barras}
    with ACBrTitulo.ACBrBoleto do
    begin
	  CodigoBarras := IntToStrZero(Banco.Numero, 3) +
                      '9' +
                      FatorVencimento +
                      IntToStrZero(Round(ACBrTitulo.ValorDocumento * 100), 10) +
                      padR(ACarteira, 1, '0') +
                      padR(Cedente.Agencia,4,'0') +
                      CampoLivre;
    end;

    DigitoCodBarras := CalcularDigitoCodigoBarras(CodigoBarras);
    Result:= copy( CodigoBarras, 1, 4) + DigitoCodBarras + copy( CodigoBarras, 5, 44);
end;

function TACBrBancoob.MontarCampoCodigoCedente (
   const ACBrTitulo: TACBrTitulo ) : String;
begin
  Result := ACBrTitulo.ACBrBoleto.Cedente.Agencia + '/'+
            ACBrTitulo.ACBrBoleto.Cedente.CodigoCedente;
end;

function TACBrBancoob.MontarCampoNossoNumero (const ACBrTitulo: TACBrTitulo ) : String;
begin
    Result := ACBrTitulo.NossoNumero + '-' + CalcularDigitoVerificador(ACBrTitulo);
end;

function TACBrBancoob.GerarRegistroHeader400(NumeroRemessa : Integer): String;
begin
   with ACBrBanco.ACBrBoleto.Cedente do
   begin
      Result:= '0'                                        + // ID do Registro
               '1'                                        + // ID do Arquivo( 1 - Remessa)
               'REMESSA'                                  + // Literal de Remessa
               '01'                                       + // Código do Tipo de Serviço
               padL( 'COBRANÇA', 8 )                      + // Descrição do tipo de serviço
               Space(7)                                   + // Brancos
               padR( Agencia, 4 )                         + // Prefixo da Cooperativa
               padR( AgenciaDigito, 1 )                   + // Dígito Verificador do Prefixo
               padR( trim(CodigoCedente), 9,'0' )         + // Código do Cliente/Cedente
               Space(6)                                   + // Brancos
               padR( Nome, 30 )                           + // Nome do Cedente
               padL( '756BANCOOBCED', 18 )                + // Identificação do Banco: "756BANCOOBCED"  //Enviado pelo pessoal da homologação por email
               FormatDateTime('ddmmyy',Now)               + // Data de geração do arquivo
               IntToStrZero(NumeroRemessa,7)              + // Seqüencial da Remessa: número seqüencial acrescido de 1 a cada remessa. Inicia com "0000001"
               Space(287)                                 + // Brancos
               IntToStrZero(1,6);                           // Contador de Registros

      Result:= UpperCase(Result);
   end;
end;

function TACBrBancoob.GerarRegistroTransacao400(ACBrTitulo :TACBrTitulo): String;
var
  DigitoNossoNumero,
  Ocorrencia,aEspecie,
  Protesto,
  TipoSacado: String;
  ATipoAceite:String;
  MensagemCedente: String;
  ACarteira      : String;
  I: Integer;
  TipoCedente: String;
begin

    if (Length(ACBrTitulo.Carteira) > 0 )then
       ACarteira := '1'
    else
       raise Exception.Create( ACBrStr('Carteira Inválida.'+sLineBreak) ) ;

   with ACBrTitulo do
   begin
      DigitoNossoNumero := CalcularDigitoVerificador(ACBrTitulo);

      {Pegando Código da Ocorrencia}
      case OcorrenciaOriginal.Tipo of
         toRemessaBaixar                         : Ocorrencia := '02'; {Pedido de Baixa}
         toRemessaConcederAbatimento             : Ocorrencia := '04'; {Concessão de Abatimento}
         toRemessaCancelarAbatimento             : Ocorrencia := '05'; {Cancelamento de Abatimento concedido}
         toRemessaAlterarVencimento              : Ocorrencia := '06'; {Alteração de vencimento}
         toRemessaAlterarNumeroControle          : Ocorrencia := '08'; {Alteração de seu número}
         toRemessaProtestar                      : Ocorrencia := '09'; {Pedido de protesto}
         toRemessaCancelarInstrucaoProtestoBaixa : Ocorrencia := '18'; {Sustar protesto e baixar}
         toRemessaCancelarInstrucaoProtesto      : Ocorrencia := '19'; {Sustar protesto e manter na carteira}
         toRemessaOutrasOcorrencias              : Ocorrencia := '31'; {Alteração de Outros Dados}
      else
         Ocorrencia := '01';                                          {Remessa}
      end;

      { Pegando o Aceite do Titulo }
      case Aceite of
         atSim :  ATipoAceite := '1';
         atNao :  ATipoAceite := '0';
      end;

      {Pegando Especie}
      if trim(EspecieDoc) = 'DM' then
         aEspecie:= '01'
      else if trim(EspecieDoc) = 'NP' then
         aEspecie:= '02'
      else if trim(EspecieDoc) = 'NS' then
         aEspecie:= '03'
      else if trim(EspecieDoc) = 'CS' then
         aEspecie:= '04'
      else if trim(EspecieDoc) = 'ND' then
         aEspecie:= '11'
      else if trim(EspecieDoc) = 'DS' then
         aEspecie:= '12'
      else
         aEspecie := EspecieDoc;

      {Pegando campo Intruções}
      if (DataProtesto > 0) and (DataProtesto > Vencimento) then
          Protesto := '06' + IntToStrZero(DaysBetween(DataProtesto,Vencimento),2)
      else if Ocorrencia = '31' then
         Protesto := '9999'
      else
         Protesto := Instrucao1+Instrucao2;

      {Pegando Tipo de Sacado}
      case Sacado.Pessoa of
         pFisica   : TipoSacado := '01';
         pJuridica : TipoSacado := '02';
      else
         TipoSacado := '99';
      end;

      {Pegando Tipo de Cedente}
      if ACBrBoleto.Cedente.TipoInscricao  = pFisica then
         TipoCedente := '01'
      else
         TipoCedente := '02';

      with ACBrBoleto do
      begin
         for I:= 0 to Mensagem.count-1 do
             MensagemCedente:= Mensagem[i];

         if length(MensagemCedente) > 60 then
            MensagemCedente:= copy(MensagemCedente,1,60);
          Result:= '1'                                            +  // ID Registro
          TipoCedente                                             +  // Identificação do Tipo de Inscrição do Sacado 01 - CPF 02 - CNPJ
          padR(onlyNumber(Cedente.CNPJCPF),14,'0')                +  // Número de Inscrição do Cedente
          padR(Cedente.Agencia, 4, '0')                           +  // Agência
          padR( Cedente.AgenciaDigito, 1, '0')                    +  // Agência digito
          padR( RightStr(Cedente.Conta,8)+Cedente.ContaDigito, 9, '0')        +  // Conta Corrente c/ Dígito
          padR( '0', 6, '0')                                      +  // Número do Convênio de Cobrança do Cedente fixo zeros: "000000"
          Space(25)                                               +  // Brancos
          padR( NossoNumero + DigitoNossoNumero, 12, '0')         +  // Nosso Número + //nosso numero com digito
          '01'                                                    +  // Número da Parcela: "01" se parcela única
          '00'                                                    +  // Grupo de Valor: "00"
          Space(3)                                                +  // Brancos
          Space(1)                                                +  // Indicativo de Mensagem ou Sacador/Avalista:
          Space(3)                                                +  // Brancos
          IntToStrZero( 0, 3)                                     +  // Variação da Carteira: "000"
          IntToStrZero( 0, 1)                                     +  // Conta Caução: "0"
          IntToStrZero( 0, 5)                                     +  // Código de responsabilidade: "00000"
          IntToStrZero( 0, 1)                                     +  // DV do código de responsabilidade: "0"
          IntToStrZero( 0, 6)                                     +  // Numero do borderô: “000000”
          Space(5)                                                +  // Brancos
          padR( Cedente.Modalidade, 2, '0')                       +  // Carteira/Modalidade
          Ocorrencia                                              +  // Ocorrencia (remessa)
          padL( NumeroDocumento,  10)                             +  // Número do Documento
          FormatDateTime( 'ddmmyy', Vencimento)                   +  // Data de Vencimento do Título
          IntToStrZero( Round( ValorDocumento * 100 ), 13)        +  // Valor do Título
          IntToStrZero( Banco.Numero, 3)                          +  // Número Banco: "756"
          padR( Cedente.Agencia, 4, '0')                          +  // Prefixo da Agência Cobradora: “0000”
          Space(1)                                                +  // Dígito Verificador do Prefixo da Agência Cobradora: Brancos
          padL(aEspecie,2)                                        +  // Espécie do Título
          ATipoAceite                                             +  // Identificação
          FormatDateTime( 'ddmmyy', DataDocumento )               +  // 32 Data de Emissão
          IntToStrZero( 0, 2)                                     +  // 33 Primeira instrução (SEQ 34) = 00 e segunda (SEQ 35) = 00, não imprime nada.
          IntToStrZero( 1, 2)                                     +  // 34 Primeira instrução (SEQ 34) = 00 e segunda (SEQ 35) = 00, não imprime nada.
          IntToStrZero( 0, 6)                                     +  // Taxa de mora mês
          IntToStrZero( 0, 6)                                     +  // Taxa de multa
          Space(1)                                                +  // Brancos
          IntToStrZero( 0, 6)                                     +  // Preencher com zeros quando não for concedido nenhum desconto.
          IntToStrZero( 0, 13)                                    +  // Preencher com zeros quando não for concedido nenhum desconto.
          IntToStrZero( 9 , 1)                                    +  // MOEDA 9 BRASIL
          IntToStrZero( 0, 12)                                    +  // Valor IOF / Quantidade Monetária: "0000000000000"
          IntToStrZero( 0, 13)                                    +  // Valor Abatimento
          TipoSacado                                              +  // Tipo de Inscrição do Sacado: 01 - CPF 02 - CNPJ
          padR(onlyNumber(Sacado.CNPJCPF),14,'0')                 +  // Número de Inscrição do Sacado
          padL( Sacado.NomeSacado, 40, ' ')                       +  // Nome do Sacado
          padL( Sacado.Logradouro +' '+ Sacado.Numero,37,' ')     +  // Endereço Completo
          padL( Sacado.Bairro,15,' ')                             +  // Endereço Bairro
          padL( Sacado.CEP,8,' ')                                 +  // Endereço CEP
          padL( Sacado.Cidade,15,' ')                             +  // Endereço cidade
          padL( Sacado.UF,2,' ')                                  +  // Endereço uf
          padL( trim(Mensagem.Text) ,40,' ')                      +  // Observações/Mensagem ou Sacador/Avalista:
          IntToStrZero( 0, 2)                                     +  // Número de Dias Para Protesto
          Space(1)                                                +  // Brancos
          IntToStrZero( ListadeBoletos.IndexOf(ACBrTitulo)+2, 6 );   // Contador de Registros;
          Result:= UpperCase(Result);
        end;
     end;
end;

function TACBrBancoob.GerarRegistroTrailler400(
  ARemessa: TStringList ): String;
begin
   Result:= '9'                                  + // ID Registro
            Space(193)                           + // Brancos
            Space(40)                            + // Mensagem responsabilidade Cedente
            Space(40)                            + // Mensagem responsabilidade Cedente
            Space(40)                            +
            Space(40)                            +
            Space(40)                            +
            IntToStrZero( ARemessa.Count + 1, 6);  // Contador de Registros

   Result:= UpperCase(Result);
end;


procedure TACBrBancoob.LerRetorno400(ARetorno: TStringList);
var
  ContLinha: Integer;
  Titulo   : TACBrTitulo;
  Linha, rCedente, rCNPJCPF : String;
begin
   ContLinha := 0;

   if (copy(ARetorno.Strings[0],1,9) <> '02RETORNO') then
      raise Exception.Create(ACBrStr(ACBrBanco.ACBrBoleto.NomeArqRetorno +
                             'não é um arquivo de retorno do '+ Nome));

   rCedente := trim(Copy(ARetorno[0],32,8));


   ACBrBanco.ACBrBoleto.DataArquivo   := StringToDateTimeDef(Copy(ARetorno[0],95,2)+'/'+
                                                             Copy(ARetorno[0],97,2)+'/'+
                                                             Copy(ARetorno[0],99,2),0, 'DD/MM/YY' );

   ACBrBanco.ACBrBoleto.DataCreditoLanc := StringToDateTimeDef(Copy(ARetorno[1],111,2)+'/'+
                                                               Copy(ARetorno[1],113,2)+'/'+
                                                               Copy(ARetorno[1],115,2),0, 'DD/MM/YY' );
   rCNPJCPF := trim( Copy(ARetorno[1],4,14)) ;

   with ACBrBanco.ACBrBoleto do
   begin
      Cedente.Nome    := rCedente;
      Cedente.CNPJCPF := rCNPJCPF;

      case StrToIntDef(Copy(ARetorno[1],2,2),0) of
         11: Cedente.TipoInscricao:= pFisica;
         else
            Cedente.TipoInscricao:= pJuridica;
      end;

      ACBrBanco.ACBrBoleto.ListadeBoletos.Clear;
   end;

   for ContLinha := 1 to ARetorno.Count - 2 do
   begin
      Linha := ARetorno[ContLinha] ;

      if Copy(Linha,1,1)<> '1' then
         Continue;

      Titulo := ACBrBanco.ACBrBoleto.CriarTituloNaLista;

      with Titulo do
      begin
         SeuNumero                   := copy(Linha,38,25);
         NumeroDocumento             := copy(Linha,117,10);
         OcorrenciaOriginal.Tipo     := CodOcorrenciaToTipo(StrToIntDef(
                                        copy(Linha,109,2),0));
         //05 = Liquidação Sem Registro

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
         ValorMoraJuros       := StrToFloatDef(Copy(Linha,267,13),0)/100;
         ValorOutrosCreditos  := StrToFloatDef(Copy(Linha,280,13),0)/100;
         ValorRecebido        := StrToFloatDef(Copy(Linha,254,13),0)/100;
         NossoNumero          := copy( Copy(Linha,63,11),Length( Copy(Linha,63,11) )-TamanhoMaximoNossoNum+1  ,TamanhoMaximoNossoNum);
         Carteira             := Copy(Linha,86,3);
         ValorDespesaCobranca := StrToFloatDef(Copy(Linha,182,13),0)/100;
         ValorOutrasDespesas  := StrToFloatDef(Copy(Linha,189,13),0)/100;

         if StrToIntDef(Copy(Linha,176,6),0) <> 0 then
            DataCredito:= StringToDateTimeDef( Copy(Linha,176,2)+'/'+
                                               Copy(Linha,178,2)+'/'+
                                               Copy(Linha,180,2),0, 'DD/MM/YY' );
      end;
   end;

end;

function TACBrBancoob.GerarRegistroHeader240(
  NumeroRemessa: Integer): String;
var
  ATipoInscricao: string;
begin
  I := 0;
  with ACBrBanco.ACBrBoleto.Cedente do
    begin
      case TipoInscricao of
        pFisica  : ATipoInscricao := '1';
        pJuridica: ATipoInscricao := '2';
      end;
      { GERAR REGISTRO-HEADER DO ARQUIVO }
      Result:= IntToStrZero(ACBrBanco.Numero, 3)        + //1 a 3 - Código do banco
               '0000'                                   + //4 a 7 - Lote de serviço
               '0'                                      + //8 - Tipo de registro - Registro header de arquivo
               space(9)                                 + //9 a 17 Uso exclusivo FEBRABAN/CNAB
               ATipoInscricao                           + //18 - Tipo de inscrição do cedente
               padR(OnlyNumber(CNPJCPF), 14, '0')                   + //19 a 32 -Número de inscrição do cedente
               space(20)                                + // 33 a 52 - Brancos
               '0'                                      + // 53 - Zeros
               padR(Agencia, 4, '0')                    + //54 a 57 - Código da agência do cedente
               padL(AgenciaDigito, 1, '0')              + //58 - Digito agência do cedente
               padR(Conta, 12, '0')                     + // 59 a 70 - Número da conta do cedente
               padL(ContaDigito, 1, '0')                + //71 - Digito conta do cedente
               ' '                                      + // 72 - Dígito verificador Ag/Conta (Brancos)
               padL(Nome, 30, ' ')                      + // 73 a 102 - Nome do cedente
               padL('SICOOB', 30, ' ')                  + // 103 a 132 - Nome do banco
               space(10)                                + // 133 A 142 - Brancos
               '1'                                      + // 143 - Código de Remessa (1) / Retorno (2)
               FormatDateTime('ddmmyyyy', Now)          + // 144 a 151 - Data do de geração do arquivo
               FormatDateTime('hhmmss', Now)            + // 152 a 157 - Hora de geração do arquivo
               '000001'                                 + // 158 a 163 - Número sequencial do arquivo retorno
               '081'                                    + // 164 a 166 - Número da versão do layout do arquivo
               '00000'                                  + // 167 a 171 - Zeros
               space(54)                                + // 172 a 225 - 54 Brancos
               space(3)                                 + // 226 a 228 - zeros
               space(12);                                 // 229 a 240 - Brancos
     { GERAR REGISTRO HEADER DO LOTE }
      Result:= Result + #13#10 +
               IntToStrZero(ACBrBanco.Numero, 3)       + //1 a 3 - Código do banco
               '0001'                                  + //4 a 7 - Lote de serviço
               '1'                                     + //8 - Tipo de registro - Registro header de arquivo
               'R'                                     + //9 - Tipo de operação: R (Remessa) ou T (Retorno)
               '01'                                    + //10 a 11 - Tipo de serviço: 01 (Cobrança)
               '  '                                    + //12 a 13 - Forma de lançamento: preencher com ZEROS no caso de cobrança
               '040'                                   + //14 a 16 - Número da versão do layout do lote
               ' '                                     + //17 - Uso exclusivo FEBRABAN/CNAB
               ATipoInscricao                          + //18 - Tipo de inscrição do cedente
               padR(OnlyNumber(CNPJCPF), 15, '0')      + //19 a 33 -Número de inscrição do cedente
               space(20)                               + //34 a 53 - Brancos
               '0'                                     + // 54 - Zeros
               padR(Agencia, 4, '0')                   + //55 a 58 - Código da agência do cedente
               padR(AgenciaDigito, 1, '0')             + //59 - Digito da agencia do cedente
               padR(Conta, 12, '0')                    + //60 - 71  Número da conta do cedente
               padR(ContaDigito, 1, '0')               + //72 - Digito da conta
               ' '                                     + //73
               padL(Nome, 30, ' ')                     + //74 a 103 - Nome do cedente
               space(80)                               + // 104 a 183 - Brancos
               padR(IntToStr(NumeroRemessa) , 08, '0')       + // 184 a 191 - Número sequência do arquivo retorno.
               FormatDateTime('ddmmyyyy', Now)         + //192 a 199 - Data de geração do arquivo
               padR('', 8, '0')                        + //200 a 207 - Data do crédito - Só para arquivo retorno
               space(33);                                //208 a 240 - Uso exclusivo FEBRABAN/CNAB
    end;
end;

function TACBrBancoob.GerarRegistroTransacao240(
  ACBrTitulo: TACBrTitulo): String;
var AEspecieTitulo, ATipoInscricao, ATipoOcorrencia, ATipoBoleto, ADataMoraJuros,
    ADataDesconto,ATipoAceite,NossoNum : string;
begin
  NossoNum  := RemoveString('-', MontarCampoNossoNumero(ACBrTitulo));
  with ACBrTitulo do
    begin
      {SEGMENTO P}
      {Pegando o Tipo de Ocorrencia}
      case OcorrenciaOriginal.Tipo of
        toRemessaBaixar                    : ATipoOcorrencia := '02';
        toRemessaConcederAbatimento        : ATipoOcorrencia := '04';
        toRemessaCancelarAbatimento        : ATipoOcorrencia := '05';
        toRemessaAlterarVencimento         : ATipoOcorrencia := '06';
        toRemessaConcederDesconto          : ATipoOcorrencia := '07';
        toRemessaCancelarDesconto          : ATipoOcorrencia := '08';
      //  toRemessaSustarProtesto            : ATipoOcorrencia := '18';
        toRemessaCancelarInstrucaoProtesto : ATipoOcorrencia := '10';
    //  toRemessaAlterarNomeEnderecoSacado : ATipoOcorrencia := '12';
    //  toRemessaDispensarJuros            : ATipoOcorrencia := '31';
      else
       ATipoOcorrencia := '01';
      end;
     {Pegando o Aceite do Titulo }
      case Aceite of
        atSim :  ATipoAceite := 'A';
        atNao :  ATipoAceite := 'N';
      end;
      {Pegando Tipo de Boleto} //Quem emite e quem distribui o boleto?
      case ACBrBoleto.Cedente.ResponEmissao of
        tbCliEmite        : ATipoBoleto := '2';
        tbBancoEmite      : ATipoBoleto := '1';
        tbBancoReemite    : ATipoBoleto := '3';
        tbBancoNaoReemite : ATipoBoleto := '4';
      end;
      {Pegando especie do titulo}
      if EspecieDoc = 'DM' then
        AEspecieTitulo := '02';
      {Mora Juros}
      if (ValorMoraJuros > 0) then
        begin
          if (DataMoraJuros <> Null) then
            ADataMoraJuros := FormatDateTime('ddmmyyyy', DataMoraJuros)
          else ADataMoraJuros := padR('', 8, '0');
        end
      else ADataMoraJuros := padR('', 8, '0');
     {Descontos}
     if (ValorDesconto > 0) then
       begin
         if(DataDesconto <> Null) then
           ADataDesconto := FormatDateTime('ddmmyyyy', DataDesconto)
         else  ADataDesconto := padR('', 8, '0');
       end
     else
       ADataDesconto := padR('', 8, '0');
      Result:= IntToStrZero(ACBrBanco.Numero, 3)                          + //1 a 3 - Código do banco
               '0001'                                                     + //4 a 7 - Lote de serviço
               '3'                                                         +
               IntToStrZero((i)+ 1 ,5)+ //9 a 13 - Número seqüencial do registro no lote - Cada registro possui dois segmentos

            //   IntToStrZero((ACBrBoleto.ListadeBoletos.IndexOf(ACBrTitulo))+ 1 ,5)+ //9 a 13 - Número seqüencial do registro no lote - Cada registro possui dois segmentos
               'P'                                                        + //14 - Código do segmento do registro detalhe
               ' '                                                        + //15 - Uso exclusivo FEBRABAN/CNAB: Branco
               ATipoOcorrencia                                            + //16 a 17 - Código de movimento
               '0'                                                        + // 18
               ACBrBoleto.Cedente.Agencia                                 + //19 a 22 - Agência mantenedora da conta
               padR(ACBrBoleto.Cedente.AgenciaDigito, 1, '0')             + //23 Digito agencia
               padR(ACBrBoleto.Cedente.Conta, 12, '0')                    + //24 a 35 - Número da Conta Corrente
               padR(ACBrBoleto.Cedente.ContaDigito , 1, '0')              + //36 - Dígito da Conta Corrente
               ' ';                                                        //37 - DV Agência/COnta Brancos
               if (ACBrBoleto.Cedente.ResponEmissao = tbCliEmite) then
                 begin
                   Result := Result+padR(NossoNum, 10, '0')+ // 38 a 57 - Carteira
                                    padR('01', 02, '0')+
                                    padR('02', 02, '0')+
                                    '4'+
                                    Space(5);
                 end
               else
                 begin
                   Result := Result+Space(20);
                 end;
               Result := Result+Carteira                                  +//58 a 58 carteira
                         '0'                                              +//59 Forma de cadastramento no banco
                         ' '                                              +//60 Brancos
                         ATipoBoleto                                      +// 61 Identificação da emissão do boleto
                         '2'                                              +//62  Identificação da distribuição
                         padL(NumeroDocumento, 15, ' ')                   + // 63 a 77 - Número que identifica o título na empresa [ Alterado conforme instruções da CSO Brasília ] {27-07-09}
                         FormatDateTime('ddmmyyyy', Vencimento)           + // 78 a 85 - Data de vencimento do título
                         IntToStrZero( round( ValorDocumento * 100), 15)  + // 86 a 100 - Valor nominal do título
                         '00000'                                          + // 101 a 105 - Agência cobradora. // Ficando com Zeros o Itaú definirá a agência cobradora pelo CEP do sacado
                         ' '                                              + // 106 - Dígito da agência cobradora
                         padL(AEspecieTitulo, 2)                          + // 107 a 108 - Espécie do documento
                         ATipoAceite                                      + // 109 - Identificação de título Aceito / Não aceito
                         FormatDateTime('ddmmyyyy', DataDocumento)        + // 110 a 117 - Data da emissão do documento
                         '0'                                              + // 118 - Zeros
                         ADataMoraJuros                                             + //119 a 126 - Data a partir da qual serão cobrados juros
                         IfThen(ValorMoraJuros > 0, IntToStrZero( round(ValorMoraJuros * 100), 15),
                         padR('', 15, '0'))                                        + //127 a 141 - Valor de juros de mora por dia
//                       ValorMoraJuros                                             + //127 a 141 - Valor de Mora por dia de atraso
                         '0'                                                        + // 142 - Zeros
                         ADataDesconto                                             + // 143 a 150 - Data limite para desconto
                         IfThen(ValorDesconto > 0, IntToStrZero( round(ValorDesconto * 100), 15),
                         padR('', 15, '0'))                                         + //151 a 165 - Valor do desconto por dia
                         IntToStrZero( round(ValorIOF * 100), 15)                   + //166 a 180 - Valor do IOF a ser recolhido
                         IntToStrZero( round(ValorAbatimento * 100), 15)            + //181 a 195 - Valor do abatimento
                         padL(SeuNumero, 25, ' ')                                   + //196 a 220 - Identificação do título na empresa
                         '1'                                                        + //221 - Código de protesto: Protestar em XX dias corridos
                         '00'                                                        + //222 a 223 - Prazo para protesto (em dias corridos)
                         '0'                                                        + // 224 - Código de Baixa
                         space(3)                                                   + // 225 A 227 - Dias para baixa
                         '09'                                                       +//
                         '0000000000'                                               +//Numero contrato da operação
                         ' ';
        Inc(i);
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
               IntToStrZero((i)+ 1 ,5)+ //9 a 13 - Número seqüencial do registro no lote - Cada registro possui dois segmentos
  //             IntToStrZero((ACBrBoleto.ListadeBoletos.IndexOf(ACBrTitulo)*2)+ 1 ,5)+ //Número seqüencial do registro no lote - Cada registro possui dois segmentos
               'Q'                                                        + //Código do segmento do registro detalhe
               ' '                                                        + //Uso exclusivo FEBRABAN/CNAB: Branco
               '01'                                                       + // 16 a 17
              {Dados do sacado}
               ATipoInscricao                                             + // 18 a 18 Tipo inscricao
               padR(OnlyNumber(Sacado.CNPJCPF), 15, '0')                  + // 19 a 33
               padL(Sacado.NomeSacado, 40, ' ')                           + // 34 a 73
               padL(Sacado.Logradouro +' '+ Sacado.Numero +' '+ Sacado.Complemento , 40, ' ') + // 74 a 113
               padL(Sacado.Bairro, 15, ' ')                               +  // 114 a 128
               padR(Sacado.CEP, 8, '0')                                   +  // 129 a 136
               padL(Sacado.Cidade, 15, ' ')                               +  // 137 a 151
               padL(Sacado.UF, 2, ' ')                                    +  // 152 a 153
                        {Dados do sacador/avalista}
               '0'                                                        + //Tipo de inscrição: Não informado
               space(15)                                                  + //Número de inscrição
               padL('', 30, ' ')                                          + //Nome do sacador/avalista
               space(10)                                                  + //Uso exclusivo FEBRABAN/CNAB
               padL('0',3, '0')                                           + //Uso exclusivo FEBRABAN/CNAB
               space(28);                                                   //Uso exclusivo FEBRABAN/CNAB
                Inc(i);
      //Registro detalhe R
      Result:= Result + #13#10 +
               IntToStrZero(ACBrBanco.Numero, 3)                          + //Código do banco
               '0001'                                                     + //Número do lote
               '3'                                                        + //Tipo do registro: Registro detalhe
               IntToStrZero((i)+ 1 ,5)+ //9 a 13 - Número seqüencial do registro no lote - Cada registro possui dois segmentos

       //        IntToStrZero((ACBrBoleto.ListadeBoletos.IndexOf(ACBrTitulo)*3)+ 1 ,5)+ //Número seqüencial do registro no lote - Cada registro possui dois segmentos
               'R'                                                        + //Código do segmento do registro detalhe
               ' '                                                        + //Uso exclusivo FEBRABAN/CNAB: Branco
               '01'                                                       + // 16 a 17
               '0'                                                        +//18  tipo de desconto 2
               padR('0', 8, '0')                                          +//19 - 26 Numero da linha a ser impressa
               padR('0',15, '0')                                          +//27 - 41 Valor/Percentual
               '1'                                                        +//42
               padR('0', 8, '0')                                          +//43-50 data do desconto 3
               padR('0', 15, '0')                                         +//51-65 Valor ou percentual a ser concedido
               '1'                                                        +//66 Código da multa
               padR('0', 8, '0')                                          +//67-74 Data da multa
               padR('0', 15, '0')                                         +//75-89 Valor/Percentual a ser aplicado
               space(10)                                                  +//90-99 Informações do sacado
               space(40)                                                  +//100-139 Menssagem livre
               space(40)                                                  +//140-179 Menssagem livre
               space(20)                                                  +//180-199 Uso da FEBRABAN "Brancos"
               padR('0', 08, '0')                                         +//200-207 Código oco. sacado "0000000"
               padR('0', 3, '0')                                          +//208-210 Código do banco na conta de débito "000"
               padR('0', 5, '0')                                          +//211-215 Código da ag. debito
               ' '                                                        +//216 Digito da agencia
               padR('0', 12, '0')                                         +//217-228 Conta corrente para debito
               ' '                                                        +//229 Digito conta de debito
               ' '                                                        +//230 Dv agencia e conta
               '0'                                                        +//231 Aviso debito automatico
               space(9);                                                   //232-240 Uso FEBRABAN
           Inc(i);
      //Registro detalhe S
      Result:= Result + #13#10 +
               IntToStrZero(ACBrBanco.Numero, 3)                          + //Código do banco
               '0001'                                                     + //Número do lote
               '3'                                                        + //Tipo do registro: Registro detalhe
               IntToStrZero((i)+ 1 ,5)+ //9 a 13 - Número seqüencial do registro no lote - Cada registro possui dois segmentos

      //         IntToStrZero((ACBrBoleto.ListadeBoletos.IndexOf(ACBrTitulo)*4)+ 1 ,5) + //Número seqüencial do registro no lote - Cada registro possui dois segmentos
               'S'                                                        + //Código do segmento do registro detalhe
               ' '                                                        + //Uso exclusivo FEBRABAN/CNAB: Branco
               '01'                                                       + // 16 a 17
               '3'                                                        +//18 tipo impressão
               space(222);                                                //217-228 Conta corrente para debito
               Inc(i);
  end;

end;

function TACBrBancoob.GerarRegistroTrailler240(
  ARemessa: TStringList): String;
begin
  {REGISTRO TRAILER DO LOTE}
  Result:= IntToStrZero(ACBrBanco.Numero, 3)                          + //Código do banco
           '0001'                                                     + //Número do lote
           '5'                                                        + //Tipo do registro: Registro trailer do lote
           Space(9)                                                   + //Uso exclusivo FEBRABAN/CNAB
           IntToStrZero((3 * ARemessa.Count-1), 6)                    + //Quantidade de Registro da Remessa
           IntToStrZero(ARemessa.Count-1, 6)                          + // Quantidade de títulos em cobrança simples
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
