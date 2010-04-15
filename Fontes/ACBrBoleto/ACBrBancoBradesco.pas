unit ACBrBancoBradesco;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils,ACBrBoleto;

type

  { TACBrBancoBradesco }

  TACBrBancoBradesco = class(TACBrBancoClass)
  protected
  public
    Constructor create(AOwner: TACBrBanco);
    function CalcularDigitoVerificador(const ACBrTitulo:TACBrTitulo): String; override;
    function MontarCodigoBarras(const ACBrTitulo : TACBrTitulo): String; override;
  end;

implementation

uses ACBrUtil;

function TACBrBancoBradesco.CalcularDigitoVerificador(const ACBrTitulo: TACBrTitulo ): String;
begin

   Modulo.CalculoPadrao;
   Modulo.MultiplicadorFinal := 7;
   Modulo.Documento := ACBrTitulo.Carteira + ACBrTitulo.NossoNumero;
   Modulo.Calcular;

   if Modulo.DigitoFinal = 0 then
      Result:= 'P'
   else
      Result:= IntToStr(Modulo.DigitoFinal);
end;

function TACBrBancoBradesco.MontarCodigoBarras ( const ACBrTitulo: TACBrTitulo) : String;
var
  CodigoBarras,FatorVencimento,DigitoCodBarras :String;
  Agencia,Conta: String;
begin
   Agencia := ACBrTitulo.ACBrBoleto.Cedente.Agencia;
   Conta   := ACBrTitulo.ACBrBoleto.Cedente.Conta;

   FatorVencimento := CalcularFatorVencimento(ACBrTitulo.Vencimento);

   CodigoBarras    := IntToStr(fpNumero)+'9'+ FatorVencimento+padR(StringReplace(FloatToStr(ACBrTitulo.ValorDocumento),',','',[]),10,'0')+
                      Agencia + ACBrTitulo.Carteira + ACBrTitulo.NossoNumero +
                      Conta + '0';

   DigitoCodBarras := CalcularDigitoCodigoBarras(CodigoBarras);


   Result:= inttostr(fpNumero)+'9'+DigitoCodBarras+ Copy(CodigoBarras,5,43);
end;

{ TACBrBancoBradesco }

constructor TACBrBancoBradesco.create(AOwner: TACBrBanco);
begin
   inherited create(AOwner);
   fpNumero := 237;
   fpDigito := 2;
   fpNome   := 'Bradesco';
   fpTamanhoMaximoNossoNum := 11;
end;

end.

