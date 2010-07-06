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

unit ACBrBancoBradesco;

interface

uses
  Classes, SysUtils,ACBrBoleto,
  {$IFDEF COMPILER6_UP} dateutils {$ELSE} ACBrD5 {$ENDIF};

type

  { TACBrBancoBradesco }

  TACBrBancoBradesco = class(TACBrBancoClass)
  private
  protected
  public
    Constructor create(AOwner: TACBrBanco);
    function CalcularDigitoVerificador(const ACBrTitulo:TACBrTitulo): String; override;
    function MontarCodigoBarras(const ACBrTitulo : TACBrTitulo): String; override;
    function MontarCampoNossoNumero(const ACBrTitulo :TACBrTitulo): String; override;
    function MontarCampoCodigoCedente(const ACBrTitulo: TACBrTitulo): String; override;
    function GerarRegistroHeader400(NumeroRemessa : Integer): String; override;
    function GerarRegistroTransacao400(ACBrTitulo : TACBrTitulo): String; override;
    function GerarRegistroTrailler400(ARemessa:TStringList): String;  override;
    Procedure LerRetorno400(ARetorno:TStringList); override;

    function TipoOcorrenciaToDescricao(const TipoOcorrencia: TACBrTipoOcorrencia) : String; override;
    function CodOcorrenciaToTipo(const CodOcorrencia:Integer): TACBrTipoOcorrencia; override;
    function TipoOCorrenciaToCod(const TipoOcorrencia: TACBrTipoOcorrencia):String; override;
    function CodMotivoRejeicaoToDescricao(const TipoOcorrencia:TACBrTipoOcorrencia; CodMotivo:Integer): String; override;
  end;

implementation

uses ACBrUtil, StrUtils;

{ TACBrBancoBradesco }

constructor TACBrBancoBradesco.create(AOwner: TACBrBanco);
begin
   inherited create(AOwner);
   fpDigito := 2;
   fpNome   := 'Bradesco';
   fpTamanhoMaximoNossoNum := 11;
end;

function TACBrBancoBradesco.CalcularDigitoVerificador(const ACBrTitulo: TACBrTitulo ): String;
begin
   Modulo.CalculoPadrao;
   Modulo.MultiplicadorFinal := 7;
   Modulo.Documento := ACBrTitulo.Carteira + ACBrTitulo.NossoNumero;
   Modulo.Calcular;

   if Modulo.ModuloFinal = 1 then
      Result:= 'P'
   else
      Result:= IntToStr(Modulo.DigitoFinal);
end;

function TACBrBancoBradesco.MontarCodigoBarras ( const ACBrTitulo: TACBrTitulo) : String;
var
  CodigoBarras, FatorVencimento, DigitoCodBarras:String;
  DigitoNum: Integer;
begin
   with ACBrTitulo.ACBrBoleto do
   begin
      FatorVencimento := CalcularFatorVencimento(ACBrTitulo.Vencimento);

      CodigoBarras := IntToStr( Numero )+'9'+ FatorVencimento +
                      IntToStrZero(Round(ACBrTitulo.ValorDocumento*100),10) +
                      padR(Cedente.Agencia,4,'0') +
                      ACBrTitulo.Carteira +
                      ACBrTitulo.NossoNumero +
                      padR(Cedente.Conta,7,'0') + '0';

      DigitoCodBarras := CalcularDigitoCodigoBarras(CodigoBarras);
   end;

   Result:= IntToStr(Numero) + '9'+ DigitoCodBarras + Copy(CodigoBarras,5,39);
end;

function TACBrBancoBradesco.MontarCampoNossoNumero (
   const ACBrTitulo: TACBrTitulo ) : String;
begin
   Result:= ACBrTitulo.Carteira+'/'+ACBrTitulo.NossoNumero+'-'+CalcularDigitoVerificador(ACBrTitulo);
end;

function TACBrBancoBradesco.MontarCampoCodigoCedente (
   const ACBrTitulo: TACBrTitulo ) : String;
begin
   Result := ACBrTitulo.ACBrBoleto.Cedente.Agencia+'-'+
             ACBrTitulo.ACBrBoleto.Cedente.AgenciaDigito+'/'+
             ACBrTitulo.ACBrBoleto.Cedente.Conta+'-'+
             ACBrTitulo.ACBrBoleto.Cedente.ContaDigito;
end;

function TACBrBancoBradesco.GerarRegistroHeader400(NumeroRemessa : Integer): String;
begin
   with ACBrBanco.ACBrBoleto.Cedente do
   begin
      Result:= '0'                                        + // ID do Registro
               '1'                                        + // ID do Arquivo( 1 - Remessa)
               'REMESSA'                                  + // Literal de Remessa
               '01'                                       + // Código do Tipo de Serviço
               padL( 'COBRANCA', 15 )                     + // Descrição do tipo de serviço
               padR( CodigoCedente, 20, '0')              + // Codigo da Empresa no Banco
               padL( Nome, 30)                                 + // Nome da Empresa
               IntToStr( Numero )+ padL('BRADESCO', 15)        + // Código e Nome do Banco(237 - Bradesco)
               FormatDateTime('ddmmyy',Now)  + Space(08)+'MX'  + // Data de geração do arquivo + brancos
               IntToStrZero(NumeroRemessa,7) + Space(277) + // Nr. Sequencial de Remessa + brancos
               IntToStrZero(1,6);                           // Nr. Sequencial de Remessa + brancos + Contador

      Result:= UpperCase(Result);
   end;
end;

function TACBrBancoBradesco.GerarRegistroTransacao400(ACBrTitulo :TACBrTitulo): String;
var
  DigitoNossoNumero,
  Ocorrencia,aEspecie,
  Protesto,
  TipoSacado: String;
  TipoBoleto: Char;
begin

   with ACBrTitulo do
   begin
      DigitoNossoNumero := CalcularDigitoVerificador(ACBrTitulo);

      {Pegando Código da Ocorrencia}
      case OcorrenciaOriginal.Tipo of
         toRemessaBaixar                        : Ocorrencia := '02'; {Pedido de Baixa}
         toRemessaConcederAbatimento            : Ocorrencia := '04'; {Concessão de Abatimento}
         toRemessaCancelarAbatimento            : Ocorrencia := '05'; {Cancelamento de Abatimento concedido}
         toRemessaAlterarVencimento             : Ocorrencia := '06'; {Alteração de vencimento}
         toRemessaAlterarNumeroControle         : Ocorrencia := '08'; {Alteração de seu número}
         toRemessaProtestar                     : Ocorrencia := '09'; {Pedido de protesto}
         toRemessaCancelarIntrucaoProtestoBaixa : Ocorrencia := '18'; {Sustar protesto e baixar}
         toRemessaCancelarInstrucaoProtesto     : Ocorrencia := '19'; {Sustar protesto e manter na carteira}
         toRemessaOutrasOcorrencias             : Ocorrencia := '31'; {Alteração de Outros Dados}
      else
         Ocorrencia := '01';                                          {Remessa}
      end;

      {Pegando Tipo de Boleto}
      case ACBrBoleto.Cedente.ResponEmissao of
         tbCliEmite : TipoBoleto := '2';
      else
         TipoBoleto := '1';
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

      with ACBrBoleto do
      begin
         Result:= '1'                                                     +  // ID Registro
                  StringOfChar( '0', 19)                                  +  // Dados p/ Débito Automático
                  '0'+ padR( Carteira, 3, '0')                            +
                  padR( Cedente.Agencia, 5, '0')                          +
                  padR( Cedente.Conta, 7, '0')                            +
                  Cedente.ContaDigito                                     +
                  padL( SeuNumero,25,' ') +'000'                          +  // Numero de Controle do Participante
                  IfThen( PercentualMulta > 0, '2', '0')                  +  // Indica se exite Multa ou não
                  IntToStrZero( round( PercentualMulta * 100 ), 4)        +  // Percentual de Multa formatado com 2 casas decimais
                  NossoNumero + DigitoNossoNumero                         +
                  IntToStrZero( round( ValorDesconto * 100), 10)          +
                  TipoBoleto + 'N' + Space(10)                            +  // Tipo Boleto(Quem emite) + 'N'= Nao registrar p/ Débito automático
                  ' ' + '0' + '  ' + Ocorrencia                           +  // Ind. Rateio de Credito + Aviso de Debito Aut. + Ocorrência
                  padL( NumeroDocumento,  10)                             +
                  FormatDateTime( 'ddmmyy', Vencimento)                   +
                  IntToStrZero( Round( ValorDocumento * 100 ), 13)        +
                  StringOfChar('0',8) + padl(aEspecie,2) + 'N'                  +  // Zeros + Especie do documento + Idntificação(valor fixo N)
                  FormatDateTime( 'ddmmyy', DataDocumento )               +  // Data de Emissão
                  Protesto                                                +
                  IntToStrZero( round(ValorMoraJuros * 100 ), 13)         +
                  IfThen(DataDesconto < EncodeDate(2000,01,01),'000000',FormatDateTime( 'ddmmyy', DataDesconto)) +
                  IntToStrZero( round( ValorDesconto * 100 ), 13)         +
                  IntToStrZero( round( ValorIOF * 100 ), 13)              +
                  IntToStrZero( round( ValorAbatimento * 100 ), 13)       +
                  TipoSacado + padR(Sacado.CNPJCPF,14,'0')                +
                  padL( Sacado.NomeSacado, 40, ' ')                       +
                  padL( Sacado.Logradouro + Sacado.Numero              +
                           Sacado.Bairro + Sacado.Cidade + Sacado.UF, 40) +
                  space(12) + padL( Sacado.CEP, 8 )                       +
                  padl( Mensagem.Text, 60 )                               +
                  IntToStrZero( ListadeBoletos.IndexOf(ACBrTitulo)+2, 6 );

         Result:= UpperCase(Result);
      end;
   end;
end;

function TACBrBancoBradesco.GerarRegistroTrailler400( ARemessa:TStringList ): String;
begin
   Result:= '9' + Space(393)                     + // ID Registro
            IntToStrZero( ARemessa.Count + 1, 6);  // Contador de Registros
   Result:= UpperCase(Result);
end;

Procedure TACBrBancoBradesco.LerRetorno400 ( ARetorno: TStringList );
var
  ContLinha: Integer;
  Titulo   : TACBrTitulo;

  Linha,rCedente: String ;
  rCNPJCPF: String;

  CodOCorrencia: Integer;
begin
   ContLinha := 0;

   if StrToInt(copy(ARetorno.Strings[0],77,3)) <> Numero then
      raise Exception.Create(ACBrStr(ACBrBanco.ACBrBoleto.NomeArqRetorno + 'nao' +
                             'é um arquivo de retorno do '+ Nome));

   rCedente := trim(Copy(ARetorno[0],47,30));
   rCNPJCPF := trim(IntToStr(StrToIntDef(Copy(ARetorno[1],04,14),0)));

   with ACBrBanco.ACBrBoleto do
   begin
      if (not LeCedenteRetorno) and (rCNPJCPF <> Cedente.CNPJCPF) then
         raise Exception.Create(ACBrStr('CNPJ\CPF do arquivo inválido'));

      Cedente.Nome    := rCedente;
      Cedente.CNPJCPF := rCNPJCPF;

      case StrToIntDef(Copy(ARetorno[1],2,2),0) of
         11: Cedente.TipoInscricao:= pFisica;
         14: Cedente.TipoInscricao:= pJuridica;
         else
            Cedente.TipoInscricao := pOutras;
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
         //DescricaoOcorrenciaOriginal := CodOcorrenciatoDescricaoOcorrenciaOriginal(OcorrenciaOriginal);
         //TipoOcorrencia              := CodOcorrenciatoTipoOcorrenciaOriginal(StrToIntDef(OcorrenciaOriginal,0));
         MotivoRejeicaoComando       := copy(Linha,319,2);
         MotivoRejeicaoComando       := IfThen(MotivoRejeicaoComando = '00',
                                           '00',MotivoRejeicaoComando );

         if MotivoRejeicaoComando <> '00' then
         begin
            CodOCorrencia:= StrToIntDef(MotivoRejeicaoComando,0) ;
            DescricaoMotivoRejeicaoComando := CodMotivoRejeicaoToDescricao(
                                              OcorrenciaOriginal.Tipo,CodOCorrencia);
         end
         else
            DescricaoMotivoRejeicaoComando := '';

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
         NossoNumero          := Copy(Linha,71,11);
         Carteira             := Copy(Linha,22,3);
         ValorDespesaCobranca := StrToFloatDef(Copy(Linha,176,13),0)/100;
         ValorOutrasDespesas  := StrToFloatDef(Copy(Linha,189,13),0)/100;

         if StrToIntDef(Copy(Linha,296,6),0) <> 0 then
            DataCredito:= StringToDateTimeDef( Copy(Linha,296,2)+'/'+
                                               Copy(Linha,298,2)+'/'+
                                               Copy(Linha,300,2),0, 'DD/MM/YY' );
      end;
   end;
end;

function TACBrBancoBradesco.TipoOcorrenciaToDescricao(const TipoOcorrencia: TACBrTipoOcorrencia): String;
var
 CodOcorrencia: Integer;
begin

  CodOcorrencia := StrToIntDef(TipoOCorrenciaToCod(TipoOcorrencia),0);

  case CodOcorrencia of
    02: Result:='02-Entrada Confirmada' ;
    03: Result:='03-Entrada Rejeitada' ;
    06: Result:='06-Liquidação normal' ;
    09: Result:='09-Baixado Automaticamente via Arquivo' ;
    10: Result:='10-Baixado conforme instruções da Agência' ;
    11: Result:='11-Em Ser - Arquivo de Títulos pendentes' ;
    12: Result:='12-Abatimento Concedido' ;
    13: Result:='13-Abatimento Cancelado' ;
    14: Result:='14-Vencimento Alterado' ;
    15: Result:='15-Liquidação em Cartório' ;
    16: Result:= '16-Titulo Pago em Cheque - Vinculado';
    17: Result:='17-Liquidação após baixa ou Título não registrado' ;
    18: Result:='18-Acerto de Depositária' ;
    19: Result:='19-Confirmação Recebimento Instrução de Protesto' ;
    20: Result:='20-Confirmação Recebimento Instrução Sustação de Protesto' ;
    21: Result:='21-Acerto do Controle do Participante' ;
    22: Result:='22-Titulo com Pagamento Cancelado';
    23: Result:='23-Entrada do Título em Cartório' ;
    24: Result:='24-Entrada rejeitada por CEP Irregular' ;
    27: Result:='27-Baixa Rejeitada' ;
    28: Result:='28-Débito de tarifas/custas' ;
    29: Result:= '29-Ocorrências do Sacado';
    30: Result:='30-Alteração de Outros Dados Rejeitados' ;
    32: Result:='32-Instrução Rejeitada' ;
    33: Result:='33-Confirmação Pedido Alteração Outros Dados' ;
    34: Result:='34-Retirado de Cartório e Manutenção Carteira' ;
    35: Result:='35-Desagendamento do débito automático' ;
    40: Result:='40-Estorno de Pagamento';
    55: Result:='55-Sustado Judicial';
    68: Result:='68-Acerto dos dados do rateio de Crédito' ;
    69: Result:='69-Cancelamento dos dados do rateio' ;
  end;
end;

function TACBrBancoBradesco.CodOcorrenciaToTipo(const CodOcorrencia:
   Integer ) : TACBrTipoOcorrencia;
begin
   case CodOcorrencia of
      02: Result := toRetornoRegistroConfirmado;
      03: Result := toRetornoRegistroRecusado;
      06: Result := toRetornoLiquidado;
      09: Result := toRetornoBaixado;
      10: Result := toRetornoBaixado;
      11: Result := toRetornoTituloEmSer;
      12: Result := toRetornoAbatimentoConcedido;
      13: Result := toRetornoAbatimentoCancelado;
      14: Result := toRetornoVencimentoAlterado;
      15: Result := toRetornoLiquidadoEmCartorio;
      16: Result := toRetornoLiquidado;
      17: Result := toRetornoLiquidadoSemRegistro;
      18: Result := toRetornoAcertoDepositaria;
      19: Result := toRetornoRecebimentoInstrucaoProtestar;
      20: Result := toRetornoRecebimentoInstrucaoSustarProtesto;
      21: Result := toRetornoDadosAlterados;
      22: Result := toRetornoRecebimentoInstrucaoAlterarDados;
      23: Result := toRetornoEncaminhadoACartorio;
      24: Result := toRetornoRegistroRecusado;
      27: Result := toRetornoComandoRecusado;
      28: Result := toRetornoDebitoTarifas;
      29: Result := toRetornoOcorrenciasdoSacado;
      30: Result := toRetornoComandoRecusado;
      32: Result := toRetornoComandoRecusado;
      33: Result := toRetornoRecebimentoInstrucaoAlterarDados;
      34: Result := toRetornoRetiradoDeCartorio;
      99: Result := toRetornoRegistroRecusado;
   else
      Result := toRetornoOutrasOcorrencias;
   end;
end;

function TACBrBancoBradesco.TipoOCorrenciaToCod (
   const TipoOcorrencia: TACBrTipoOcorrencia ) : String;
begin
   case TipoOcorrencia of
      toRetornoRegistroConfirmado : Result:='02';
      toRetornoRegistroRecusado   : Result:='03';
      toRetornoLiquidado          : Result:='06';
      toRetornoBaixadoViaArquivo  : Result:='09';
      toRetornoBaixadoInstAgencia : Result:='10';
      toRetornoTituloEmSer        : Result:='11';
      toRetornoAbatimentoConcedido: Result:='12';
      toRetornoAbatimentoCancelado: Result:='13';
      toRetornoVencimentoAlterado : Result:='14';
      toRetornoLiquidadoEmCartorio: Result:='15';
      toRetornoTituloPagoemCheque : Result:='16';
      toRetornoLiquidadoAposBaixaouNaoRegistro : Result:= '17';
      toRetornoAcertoDepositaria  : Result:='18';
      toRetornoDebitoTarifas      : Result:='28';
   else
      Result:= '02';
   end;
end;

function TACBrBancoBradesco.COdMotivoRejeicaoToDescricao( const TipoOcorrencia:
   TACBrTipoOcorrencia ;CodMotivo: Integer) : String;
begin
   case CodMotivo of
      00 : Result := '00-Ocorrencia aceita';
      04 : Result := '04-Tarifa de protesto';
      08 : Result := '08-Tarifa de protesto';
      14 : Result := '14-Título protestado';
      15 : Result := '15-Título pago com cheque';
      16 : Result := '16-Título baixado pelo Banco por decurso Prazo';
      17 : Result := '17-Data de vencimento anterior a data de emissão';
      20 : Result := '20-Título baixado e transferido para desconto';
      21 : Result := '21-Espécie do Título inválido';
      24 : Result := '24-Data da emissão inválida';
      38 : Result := '38-Prazo para protesto inválido';
      39 : Result := '39-Pedido para protesto não permitido para título';
      43 : Result := '43-Prazo para baixa e devolução inválido';
      45 : Result := '45-Nome do Sacado inválido';
      46 : Result := '46-Tipo/num. de inscrição do Sacado inválidos';
      47 : Result := '47-Endereço do Sacado não informado';
      48 : Result := '48-CEP irregular';
      50 : Result := '50-CEP referente a Banco correspondente';
      53 : Result := '53-Nº de inscrição do Sacador/avalista inválidos (CPF/CNPJ)';
      54 : Result := '54-Sacador/avalista não informado';
      63 : Result := '63-Titulo já cadastrado';
      67 : Result := '67-Débito automático agendado';
      68 : Result := '68-Débito não agendado - erro nos dados de remessa';
      69 : Result := '69-Débito não agendado - Sacado não consta no cadastro de autorizante';
      70 : Result := '70-Débito não agendado - Cedente não autorizado pelo Sacado';
      71 : Result := '71-Débito não agendado - Cedente não participa da modalidade de débito automático';
      72 : Result := '72-Débito não agendado - Código de moeda diferente de R$';
      73 : Result := '73-Débito não agendado - Data de vencimento inválida';
      75 : Result := '75-Débito não agendado - Tipo do número de inscrição do sacado debitado inválido';
      86 : Result := '86-Seu número do documento inválido'
   else
      Result:= IntToStr(CodMotivo)+'-Outros motivos';
   end;
end;

end.

