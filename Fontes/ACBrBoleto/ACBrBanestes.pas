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
   fpTamanhoConta   := 6;
   fpTamanhoCarteira:= 2;
end;

function TACBrBanestes.CalcularCampoASBACE(
  const ACBrTitulo: TACBrTitulo): string;
var
  cIndice, cLivreAsbace: String;
  nContAsbace: Word;
  nResult, nResultTemp, nDigAsbace01, nDigAsbace02: Integer;
begin

  cLivreAsbace := LeftStr(ACBrTitulo.NossoNumero,8); //nosso numero
  cLivreAsbace := cLivreAsbace + '0000';
  cLivreAsbace := cLivreAsbace + ACBrTitulo.ACBrBoleto.Cedente.Conta + ACBrTitulo.ACBrBoleto.Cedente.ContaDigito; //Conta Corrente
  cLivreAsbace := cLivreAsbace + '4'; //tipo de cobrança
  cLivreAsbace := cLivreAsbace + IntToStrZero(Numero,3);//'0' +IntToStr(fpNumero); //Banco
  cIndice      := '21212121212121212121212';
  nResult      := 0;
  for nContAsbace := 23 downto 1 do
  begin
    nResultTemp := (StrToInt(cIndice[nContAsbace]) * StrToInt(cLivreAsbace[nContAsbace]));
    If nResultTemp > 9 then
       nResult := nResult + (nResultTemp - 9)
    else if nResultTemp < 10 then
       nResult := nResult + nResultTemp;
  end;

  nResult := nResult Mod 10;
  If nResult = 0 then
    nResult := 0
  else
  if nResult > 0 then
    nResult := 10 - nResult;

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
       If nResult = 0 then nResult := 0
       else if nResult > 1 then nResult := 11 - nResult;
     end;
  end
  else
  if nResult > 1 then
    nResult := 11 - nResult;

  cLivreAsbace := cLivreAsbace + IntToStr(nResult);
  result := cLivreAsbace;
end;

function TACBrBanestes.CalcularDigitoVerificador(const ACBrTitulo: TACBrTitulo ): String;
begin
   Modulo.CalculoPadrao;
   Modulo.MultiplicadorFinal := 13;
   Modulo.Documento := ACBrTitulo.NossoNumero;
   Modulo.Calcular;

   if Modulo.ModuloFinal > 9 then
      Result:= 'P'
   else
      Result:= IntToStr(Modulo.DigitoFinal);
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


