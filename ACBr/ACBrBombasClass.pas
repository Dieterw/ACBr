{$I ACBr.inc}

Unit ACBrBombasClass ;

interface

const
cTimeout = 3 ;   { Tempo PADRAO para msg de falha de comunicacao }

type

EACBrBombasCMDInvalido     = class(Exception) ;
EACBrBombasSemResposta     = class(Exception) ;
EACBrBombasNaoInicializado = class(Exception) ;



{ Nota sobre procimentos e funções VIRTUAL. Essas funçoes/procedimentos PODEM
  ou NAO ser implementados nas Classes filhas com a clausula OVERRIDE. Se não
  forem implementadas nas classes filhas, a funçao/procedimento definida aqui
  nessa classe (TACBrBombasClass) e que será execuada }

TACBrBombasClass = class
 private
    fsTimeOut      : Integer ;
    procedure SetAtivo(const Value: Boolean);
    procedure SetTimeOut(const Value: Integer);
 Protected
    fpDevice  : TACBrDevice ;
    fpComandoEnviado: String;
    fpRespostaComando: String;


    procedure LeResposta ; virtual ;
 public


    Property Ativo  : Boolean read fpAtivo write SetAtivo ;


    Property TimeOut  : Integer read fsTimeOut write SetTimeOut ;

    { String com Comando exatamente como foi enviado para impressora }
    Property ComandoEnviado : String read fpComandoEnviado ;
    { String com a Resposta Completa da Impressora (sem tratamentos) }
    Property RespostaComando : String read fpRespostaComando ;

    function EmLinha( lTimeOut : Integer = 1) : Boolean ; virtual ;



    { Retorna a Resposta do ECF }
    function EnviaComando( cmd : String ) : String ; overload ; virtual ;
    { Versao que Permite mudar o TimeOut padrao }
    function EnviaComando( cmd : String; lTimeOut : Integer): String; overload ;
       virtual ;
end ;

implementation

Uses ACBrBombas ;

{ ---------------------------- TACBrBombasClass ------------------------------ }


procedure TACBrBombasClass.SetAtivo(const Value: Boolean);
begin
  if Value then
     Ativar
  else
     Desativar ;
end;


procedure TACBrBombasClass.SetTimeOut(const Value: Integer);
begin
  if Value < 1 then
     fsTimeOut := 1
  else
     fsTimeOut := Value ;
end;

function TACBrBombasClass.EmLinha( lTimeOut: Integer): Boolean;
begin
  result := fpDevice.EmLinha( lTimeOut ) ;
end;

function TACBrBombasClass.EnviaComando(cmd: String; lTimeOut: Integer): String;
Var wTimeOut : Integer ;
begin
  wTimeOut := TimeOut ;
  TimeOut  := lTimeOut ;

  try
     result := EnviaComando( cmd ) ;
  finally
     TimeOut := wTimeOut ;
  end ;
end;

function TACBrBombasClass.EnviaComando(cmd: String): String;
begin
  result := '';
end;

procedure TACBrBombasClass.LeResposta;
begin
  fpDevice.Serial.DeadlockTimeout := TimeOut * 10000 ; { Define Timeout }
  fpDevice.Serial.Purge;                   { Limpa a Porta }

  fpRespostaComando := '' ;  { de fsOwner -> TACBrBombasClass }

  try
    while (Pos(')',fpRespostaComando) = 0) do begin
      fpRespostaComando := fpRespostaComando +
                           fpDevice.Serial.RecvPacket( 500 );
    end; { while }
  except
    { Exceçao silenciosa }
  end ;
end;






end.

