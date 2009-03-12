{$I ACBr.inc}

unit ACBrBombasCompany ;

interface

type

{ Classe filha de TACBrBombasClass com implementaçao para Company }
TACBrBombasCompany = class( TACBrBombasClass )
  private
    fsBytesResp : Integer ;
  protected
    //
  public
    procedure Ativar; override;
    property BytesResp : Integer read fsBytesResp write fsBytesResp;
    function RecebeResposta : String;
    function EnviaComando( cmd : String ) : String; override;


  end;

implementation

Uses ACBrBase, SysUtils, DateUtils, StrUtils, Math ;

{ --------------------------- TACBrBombasCompany ----------------------------- }


procedure TACBrBombasCompany.Ativar;
begin
  if not fpDevice.IsSerialPort  then
    raise Exception.Create( 'Esse Concentrador requer Porta Serial:  '+#13+
                            '(COM1, COM2, COM3, ...)');

  if not (fsVersao in [vrsIMS01, vrsCBC01, vrsCBC02, vrsCBC03, vrsCBC04]) then
    raise Exception.Create( 'Versão do Concentrador não Existente.');

  fpDevice.HandShake := hsRTS_CTS ;
  inherited Ativar ; { Abre porta serial }
end;

function TACBrBombasCompany.RecebeResposta : String;
begin
  fpRespostaComando := '';

  { Chama Rotina da Classe mãe TACBrClass para ler Resposta. Se houver
    falha na leitura LeResposta dispara Exceçao }
  LeResposta ;

  result := fpRespostaComando;
end;

function TACBrBombasCompany.EnviaComando( cmd : String ) : String ;
begin
  result  := '' ;
  fpComandoEnviado   := '' ;

  if (not fpDevice.Ativo) then
    raise Exception.create('Componente ACBrBombas não está Ativo');

  { Concentrador está em-linha? }
  while not EmLinha( 3 ) do begin
    if (MessageDlg('O Concentrador não está pronto.'+#10+#10+
                   'Deseja tentar novamente ?',mtConfirmation,
                   [mbYes,mbNo],0) = mrYes) then
      Continue ;

    raise EACBrBombasSemResposta.create('Concentrador não está Pronto') ;
  end; { while }

  fpDevice.Serial.DeadlockTimeout := 1000; { Timeout p/ Envio }
  fpDevice.Serial.Purge;                   { Limpa a Porta }

  while (True) do begin
    try
      fpDevice.Serial.SendString( cmd );   { Eviando o comando }
      break;
    except
      if (MessageDlg(
            'Camandos não estão sendo enviados para o Concentrador.'+#10+
            'Deseja tentar novamente ?',
            mtConfirmation,[mbYes,mbNo],0) <> mrYes) then
        raise EACBrBombasSemResposta.create('Erro ao enviar comandos para o Concentrador.')
      else
        continue ;
    end; { except }
  end; { while }
end;










end.
