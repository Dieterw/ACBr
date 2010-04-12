unit ACBrBancoBradesco;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils,ACBrBoleto;

type

  { TBancoBradesco }

  TACBrBancoBradesco = class(TACBrBancoClass)
  protected
  public
    Constructor create;
    function CalcularDigitoVerificador(const ACBrTitulo:TACBrTitulo): String; override;
  end;

implementation

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

{ TACBrBancoBradesco }

constructor TACBrBancoBradesco.create;
begin
   inherited create;
   fpNumero := 237;
   fpNome   := 'Bradesco';
end;

end.

