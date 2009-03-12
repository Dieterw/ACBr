
{$I ACBr.inc}

Unit ACBrBombas ;

interface

type


{ Componente ACBrECF }
TACBrBombas = class( TACBrComponent )
  private
    fsDevice  : TACBrDevice ;   { SubComponente ACBrDevice }


    procedure SetAtivo(const Value: Boolean);
    procedure SetModelo(const Value: TACBrBombasModelo);
    procedure SetTimeOut(const Value: Integer);
    function GetTimeOut: Integer;
    function GetComandoEnviadoClass: String;
    function GetRespostaComandoClass: String;
  protected
    //
  public

    property Ativo : Boolean read fsAtivo write SetAtivo ;
    property Automacao : TACBrBombasClass read fsBombas ;

    { Propriedades lidas da Classe Instanciada em fsBombas }
    Property ComandoEnviado     : String  read GetComandoEnviadoClass ;
    Property RespostaComando    : String  read GetRespostaComandoClass ;

    function EmLinha( lTimeOut : Integer = 1) : Boolean ;



    { Utilitarios e Diversos }

    Function EnviaComando( cmd : String): String; overload;
    { Permitindo mudar o TimeOut padrao }
    Function EnviaComando( cmd : String; lTimeOut : Integer): String;
       overload ;
  published

     property TimeOut : Integer read GetTimeOut write SetTimeOut
                 default cTimeout ;


     { Instancia do Componente ACBrDevice, será passada para fsBombas.create }
     property Device : TACBrDevice read fsDevice ;
end;

implementation

Uses ACBrBombasCompany;



procedure TACBrBombas.SetAtivo(const Value: Boolean);
begin
  if Value then
     Ativar
  else
     Desativar ;
end;




function TACBrBombas.GetTimeOut: Integer;
begin
  result := fsBombas.TimeOut ;
end;

procedure TACBrBombas.SetTimeOut(const Value: Integer);
begin
   fsBombas.TimeOut := Value ;
end;


function TACBrBombas.GetComandoEnviadoClass: String;
begin
  result := fsBombas.ComandoEnviado ;
end;

function TACBrBombas.GetRespostaComandoClass: String;
begin
  result := fsBombas.RespostaComando ;
end;

function TACBrBombas.EmLinha(lTimeOut: Integer): Boolean;
begin
  result := fsBombas.EmLinha(lTimeOut) ;
end;

function TACBrBombas.EnviaComando(cmd: String ): String;
begin
  result := fsBombas.EnviaComando( cmd ) ;
end;

function TACBrBombas.EnviaComando(cmd: String; lTimeOut: Integer): String;
begin
  result := fsBombas.EnviaComando( cmd, lTimeOut ) ;
end;





end.


