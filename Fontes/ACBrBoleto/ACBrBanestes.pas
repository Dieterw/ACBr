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

unit ACBrBanestes;

interface

uses
  Classes, SysUtils,ACBrBoleto,
  {$IFDEF COMPILER6_UP} dateutils {$ELSE} ACBrD5 {$ENDIF};

type

  { TACBrBancoBradesco }

  TACBrBanestes = class(TACBrBancoClass)
  private
    fASBACE: string;
    function CalcularCampoASBACE(const ACBrTitulo: TACBrTitulo):string;
    function GetASBACE: string;
  protected
  public
    Constructor create(AOwner: TACBrBanco);

    property ASBACE: string read GetASBACE write fASBACE;
    function CalcularDigitoVerificador(const ACBrTitulo:TACBrTitulo): String; override;
    function MontarCodigoBarras(const ACBrTitulo : TACBrTitulo): String; override;
    function MontarCampoNossoNumero(const ACBrTitulo :TACBrTitulo): String; override;
    function MontarCampoCodigoCedente(const ACBrTitulo: TACBrTitulo): String; override;
    function GerarRegistroHeader400(NumeroRemessa : Integer): String; override;
    function GerarRegistroTransacao400(ACBrTitulo : TACBrTitulo): String; override;
    function GerarRegistroTrailler400(ARemessa:TStringList): String;  override;


    function TipoOCorrenciaToCod(const TipoOcorrencia: TACBrTipoOcorrencia):String; override;
  end;

implementation

uses ACBrUtil, StrUtils;

{ TACBrBancoBradesco }

constructor TACBrBanestes.create(AOwner: TACBrBanco);
begin
   inherited create(AOwner);
   fpDigito := 3;
   fpNome:= 'Banestes';
   fpNumero := 021;
   fpTamanhoMaximoNossoNum := 9;
   fpTamanhoAgencia := 3;
   fpTamanhoConta   := 11;
   fpTamanhoCarteira:= 2;
end;

function TACBrBanestes.CalcularCampoASBACE(
  const ACBrTitulo: TACBrTitulo): string;
var
  cIndice, cLivreAsbace: String;
  nContAsbace: Word;
  nResult, nResultTemp, nDigAsbace01, nDigAsbace02: Integer;
begin
   cLivreAsbace := copy(ACBrTitulo.NossoNumero,2,8)+
                   copy(ACBrTitulo.ACBrBoleto.Cedente.Conta,2,10)+
                   ACBrTitulo.ACBrBoleto.Cedente.ContaDigito+
                   '4'+
                   IntToStrZero(fpNumero,3);
  cIndice      := '21212121212121212121212';
  nResult      := 0;
  for nContAsbace := 23 downto 1 do
  begin
    nResultTemp := (StrToInt(cIndice[nContAsbace]) * StrToInt(cLivreAsbace[nContAsbace]));
    If nResultTemp > 9 then
       nResult := nResult + (nResultTemp - 9)
      else
       nResult := nResult + nResultTemp;
  end;

  nResult := nResult Mod 10;
  if nResult > 0 then 
     nResult := 10 - nResult 
  else nResult:=0;
     nDigAsbace01 := nResult; //guardo o primeiro dig da asbace

  cLivreAsbace := cLivreAsbace + IntToStr(nResult);
  cIndice      := '765432765432765432765432';
  nResult      := 0;
  for nContAsbace := 24 downto 1 do
  begin
    nResult := nResult + (StrToInt(cIndice[nContAsbace]) * StrToInt(cLivreAsbace[nContAsbace]));
  end;

  nResult := nResult Mod 11;
  If nResult = 0 then
    nResult := 0
  else
  if nResult = 1 then
  begin
     while nResult = 1 do
     begin
       nDigAsbace01 := nDigAsbace01 + 1;
       if nDigAsbace01 = 10 then
          nDigAsbace01 := 0;
       cLivreAsbace := copy(cLivreAsbace,1,23) + IntToStr(nDigAsbace01);
       cIndice      := '765432765432765432765432';
       nResult      := 0;
       for nContAsbace := 24 downto 1 do
       begin
         nResult := nResult + (StrToInt(cIndice[nContAsbace]) * StrToInt(cLivreAsbace[nContAsbace]));
       end;

       nResult := nResult Mod 11;
       If nResult = 0 then 
          nResult := 0
       else if nResult > 1 then 
          nResult := 11 - nResult;
     end;
  end
  else
  if nResult > 1 then
    nResult := 11 - nResult;

  cLivreAsbace := cLivreAsbace + IntToStr(nResult);
  result := cLivreAsbace;
end;

function TACBrBanestes.CalcularDigitoVerificador(const ACBrTitulo: TACBrTitulo ): String;
var
   ADigitoNossoNumero : string;
begin
   Modulo.CalculoPadrao;
   Modulo.MultiplicadorFinal := 13;
   Modulo.Documento := ACBrTitulo.NossoNumero;
   Modulo.Calcular;
   AdigitoNossoNumero:=IntToStr(Modulo.DigitoFinal);
   Modulo.Documento := ACBrTitulo.NossoNumero+AdigitoNossoNumero;
   Modulo.Calcular;
   Result:= AdigitoNossoNumero+inttostr(Modulo.DigitoFinal);
end;

function TACBrBanestes.MontarCodigoBarras ( const ACBrTitulo: TACBrTitulo) : String;
var
  cIndice, CodigoBarras,
  FatorVencimento, DigitoCodBarras:String;
  nConter, nMult: Word;
begin
  with ACBrTitulo.ACBrBoleto do
  begin
    fASBACE := CalcularCampoASBACE(ACBrTitulo);

    FatorVencimento := CalcularFatorVencimento(ACBrTitulo.Vencimento);


    CodigoBarras := IntToStrZero(Numero,3) + '9';
    CodigoBarras := CodigoBarras + FatorVencimento;
    CodigoBarras := CodigoBarras + IntToStrZero(Round(ACBrTitulo.ValorDocumento*100),10);
    CodigoBarras := CodigoBarras + fASBACE;

    DigitoCodBarras := CalcularDigitoCodigoBarras(CodigoBarras);
  end;

  Result:= IntToStrZero(Numero,3) + '9'+ DigitoCodBarras + Copy(CodigoBarras,5,39);
end;

function TACBrBanestes.MontarCampoNossoNumero (
   const ACBrTitulo: TACBrTitulo ) : String;
begin
  Result := ACBrTitulo.NossoNumero+'-'+CalcularDigitoVerificador(ACBrTitulo);
end;

function TACBrBanestes.MontarCampoCodigoCedente (
   const ACBrTitulo: TACBrTitulo ) : String;
begin
   Result := ACBrTitulo.ACBrBoleto.Cedente.Agencia+
             ACBrTitulo.ACBrBoleto.Cedente.AgenciaDigito+'/'+
             ACBrTitulo.ACBrBoleto.Cedente.Conta+
             ACBrTitulo.ACBrBoleto.Cedente.ContaDigito;
end;

function TACBrBanestes.GerarRegistroHeader400(NumeroRemessa: Integer): String;
begin
   with ACBrBanco.ACBrBoleto.Cedente do begin
      Result:= '0'                                        + // ID do Registro
               '1'                                        + // ID do Arquivo( 1 - Remessa)
               'REMESSA'                                  + // Literal de Remessa
               '01'                                       + // Código do Tipo de Serviço
               padL('COBRANCA', 15 )+
               padR(Conta, 10, '0')+                      // Codigo da Empresa no Banco
               padR(ContaDigito, 1, '0')+
               space(9) +                                               // COMPLEMENTO DO REGISTRO
               padL(Nome, 30)                                 + // Nome da Empresa
               IntToStrzero(Numero,3)+
               padL('BANESTES', 8)        +                  // Código e Nome do Banco(237 - Bradesco)
               space(7) +                                    // COMPLEMENTO DO REGISTRO
               FormatDateTime('ddmmyy',Now)+
               Space(294)+                                  // Data de geração do arquivo + brancos
               IntToStrZero(1,6);                           // Nr. Sequencial de Remessa + brancos + Contador

      Result:= UpperCase(Result);
   end;

end;

function TACBrBanestes.GerarRegistroTrailler400(ARemessa: TStringList): String;
begin
   Result:= '9' + Space(393)                     + // ID Registro
            IntToStrZero( ARemessa.Count + 1, 6);  // Contador de Registros
   Result:= UpperCase(Result);
end;

function TACBrBanestes.GerarRegistroTransacao400(
  ACBrTitulo: TACBrTitulo): String;
var
   ATipoInscricao,TipoBoleto,ATipoAceite,DigitoNossoNumero, Ocorrencia, aEspecie, aAgencia :String;
   PracaPostagem,acarteira,Protesto, TipoSacado, MensagemCedente, aConta     :String;
begin
   case ACBrBanco.ACBrBoleto.Cedente.TipoInscricao of
      pFisica  : ATipoInscricao := '01';
      pJuridica: ATipoInscricao := '02';
   end;

   with ACBrTitulo do BEGIN
      DigitoNossoNumero := CalcularDigitoVerificador(ACBrTitulo);
      aAgencia := IntToStrZero(StrToIntDef(trim(ACBrBoleto.Cedente.Agencia),0),5);
      aConta   := IntToStrZero(StrToIntDef(trim(ACBrBoleto.Cedente.Conta),0),7);
      aCarteira:= IntToStrZero(StrToIntDef(trim(Carteira),0), 1);
      {Pegando Código da Ocorrencia}
      case OcorrenciaOriginal.Tipo of
         toRemessaBaixar                         : Ocorrencia := '02'; {Pedido de Baixa}
         toRemessaConcederAbatimento             : Ocorrencia := '04'; {Concessão de Abatimento}
         toRemessaCancelarAbatimento             : Ocorrencia := '05'; {Cancelamento de Abatimento concedido}
         toRemessaAlterarVencimento              : Ocorrencia := '06'; {Alteração de vencimento}
         toRemessaAlterarNumeroControle          : Ocorrencia := '08'; {Alteração de seu número}
         toRemessaProtestar                      : Ocorrencia := '09'; {Pedido de protesto}
         toRemessaCancelarInstrucaoProtestoBaixa : Ocorrencia := '20'; {Sustar protesto e baixar}
         toRemessaCancelarInstrucaoProtesto      : Ocorrencia := '18'; {Sustar protesto e manter na carteira}
         toRemessaOutrasOcorrencias              : Ocorrencia := '31'; {Alteração de Outros Dados}
      else
         Ocorrencia := '01';                                          {Remessa}
      end;

      {Pegando Tipo de Boleto}
      case ACBrBoleto.Cedente.ResponEmissao of
         tbCliEmite        : TipoBoleto  := '01';
         tbBancoNaoReemite : TipoBoleto  := '01';
         tbBancoEmite      : TipoBoleto  := '21';
         tbBancoReemite    : TipoBoleto  := '21';
      end;
      case ACBrBoleto.Cedente.ResponEmissao of
         tbCliEmite        : PracaPostagem  := '00501';
         tbBancoNaoReemite : PracaPostagem  := '00501';
         tbBancoEmite      : PracaPostagem  := '00000';
         tbBancoReemite    : PracaPostagem  := '00000';
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
      else if trim(EspecieDoc) = 'DS' then
         aEspecie:= '11'
      else
         aEspecie := EspecieDoc;

      {Pegando campo Intruções}
      if (DataProtesto > 0) and (DataProtesto > Vencimento) then
          Protesto := '06' + IntToStrZero(DaysBetween(DataProtesto,Vencimento),2)
      else if Ocorrencia = '31' then
         Protesto := '9999'
      else
         Protesto := padR(trim(Instrucao1),2,'0') + padR(trim(Instrucao2),2,'0');

      {Pegando Tipo de Sacado}
      case Sacado.Pessoa of
         pFisica   : TipoSacado := '01';
         pJuridica : TipoSacado := '02';
      else
         TipoSacado := '99';
      end;
      case Aceite of
         atSim :  ATipoAceite := 'A';
         atNao :  ATipoAceite := 'N';
      end;

      with ACBrBoleto do BEGIN
         if Mensagem.Text<>'' then MensagemCedente:= Mensagem[0];


         Result:= '1'                                                     +  // ID Registro
                  atipoinscricao                                   + // TIPO INSCRICAO EMPRESA(CNPJ, CPF);
                  padL(Cedente.CNPJCPF,14,'0')+
                  padL(cedente.Conta,10,'0')+
                  cedente.ContaDigito+
                  space(9)+
                  padL( SeuNumero,25,' ')+
                  padl( nossonumero+digitonossonumero,10,'0')+
                  IfThen( PercentualMulta > 0, '1', '0')                  +  // Indica se exite Multa ou não
                  IntToStrZero( round( PercentualMulta * 100 ), 9)        +  // Percentual de Multa formatado com 2 casas decimais
                  space(06)+
                  '00'+
                  '00'+
                  copy(TipoSacado,2,1)+
                  padR(OnlyNumber(Sacado.CNPJCPF),14,'0') +
                  aCarteira+
                  Ocorrencia+
                  padL( SeuNumero,10,' ')+
                  FormatDateTime( 'ddmmyy', Vencimento)                   +
                  '000'+
                  IntToStrZero( Round( ValorDocumento * 100 ), 10)        +
                  IntToStrzero(Numero,3)+
                  PracaPostagem+
                  Tipoboleto+
                  Atipoaceite+
                  FormatDateTime( 'ddmmyy', DataDocumento )               +  // Data de Emissão
                  protesto+
                  IfThen( ValorMoraJuros > 0, '0', '9')                  +  // Indica se exite Multa ou não
                  IntToStrZero( round(ValorMoraJuros * 100 ), 12)         +
                  IfThen(DataDesconto < EncodeDate(2000,01,01),'000000',FormatDateTime( 'ddmmyy', DataDesconto)) +
                  IntToStrZero( round( ValorDesconto * 100 ), 13)         +
                  IntToStrZero( round( ValorIOF * 100 ), 13)              +
                  IntToStrZero( round( ValorAbatimento * 100 ), 13)       +
                  TipoSacado +
                  padR(OnlyNumber(Sacado.CNPJCPF),14,'0')                +
                  padL(Sacado.NomeSacado, 40, ' ')                       +
                  padL(Sacado.Logradouro + Sacado.Numero,40)+
                  padL(Sacado.Bairro,12) +
                  padL(Sacado.cep,8) +
                  padl(Sacado.Cidade,15)+
                  padl(Sacado.UF, 2) +
                  padl( MensagemCedente, 40 )+
                  '00'+
                  '0';
           Result := Result + IntToStrZero(ListadeBoletos.IndexOf(ACBrTitulo) +
                               ListadeBoletos.IndexOf(ACBrTitulo) + 2, 6);
           Result:= UpperCase(Result);
      end;
   end;

end;

function TACBrBanestes.GetASBACE: string;
begin
  Result := copy(fASBACE,1,4)+' '+ copy(fASBACE,5,4)+' '+
                          copy(fASBACE,9,4)+' '+ copy(fASBACE,13,4)+' '+
                          copy(fASBACE,17,4)+' '+ copy (fASBACE,21,4)+' '+
                          copy(fASBACE,25,1);

end;

function TACBrBanestes.TipoOCorrenciaToCod (
   const TipoOcorrencia: TACBrTipoOcorrencia ) : String;
begin
   case TipoOcorrencia of
      toRetornoRegistroConfirmado                     : Result:='02';
      toRetornoRegistroRecusado                       : Result:='03';
      toRetornoLiquidado                              : Result:='06';
      toRetornoRecebimentoInstrucaoConcederDesconto   : Result := '07';
      toRetornoRecebimentoInstrucaoCancelarDesconto   : Result := '08';
      toRetornoBaixadoViaArquivo                      : Result:='09';
      toRetornoTituloEmSer                            : Result:='11';
      toRetornoAbatimentoConcedido                    : Result:='12';
      toRetornoAbatimentoCancelado                    : Result:='13';
      toRetornoVencimentoAlterado                     : Result:='14';
      toRetornoLiquidadoAposBaixaouNaoRegistro        : Result:= '17';
      toRetornoRecebimentoInstrucaoProtestar          : Result := '19';
      toRetornoRecebimentoInstrucaoSustarProtesto     : Result := '20';
      toRetornoEncaminhadoACartorio                   : Result := '23';
      toRetornoRetiradoDeCartorio                     : Result := '24';
      toRetornoProtestado                             : Result := '25';
      toRetornoBaixaRejeitada                         : Result := '26';
      toRetornoRecebimentoInstrucaoAlterarDados       : Result := '27';
      toRetornoDebitoTarifas                          : Result := '28';
      toRetornoAlteracaoOutrosDadosRejeitada          : Result := '30';
   else
      Result:= '02';
   end;
end;

end.


