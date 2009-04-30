{******************************************************************************}
{ Projeto: Componentes ACBr                                                    }
{  Biblioteca multiplataforma de componentes Delphi para interação com equipa- }
{ mentos de Automação Comercial utilizados no Brasil                           }
{                                                                              }
{ Direitos Autorais Reservados (c) 2004 Daniel Simoes de Almeida               }
{                                                                              }
{ Colaboradores nesse arquivo:    Alexandre Rocha Lima e Marcondes             }
{                                                                              }
{  Você pode obter a última versão desse arquivo na pagina do  Projeto ACBr    }
{ Componentes localizado em      http://www.sourceforge.net/projects/acbr      }
{                                                                              }
{ Esse arquivo usa a classe  SynaSer   Copyright (c)2001-2003, Lukas Gebauer   }
{  Project : Ararat Synapse     (Found at URL: http://www.ararat.cz/synapse/)  }
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

{******************************************************************************
|* Historico
|*
|* 26/05/2004: Primeira Versao
|*    Daniel Simoes de Almeida
|*    Criaçao do componente ACBrDevice, que implementa comunicaçao com portas
|*    Seriais e Paralela e deverá ser usado por outros componentes ACBr*
|* 26/09/2004: Criaçao da classe: TACBrThreadTimer
|*    Daniel e Alexandre
|*    Essa classe emula um TTimer, porem em uma Thread, evitando sobrecarregar
|*    o Application. Usada por ACBrLCB e ACBrDIS
|* 01/02/2005: Criaçao da classe: TACBrThreadEnviaLPT
|*    Daniel Simoes de Almeida
|*    Essa classe é usada pela funçao EnviaStrThread para detectar se os Dados
|*    estao sendo "gravados" com sucesso na porta paralela ou arquivo.
|* 07/10/2005: Removido o TACBrThreadTimer,  Daniel Simões de Almeida
|*    Não apresenta vantagens em relação ao TTimer (Delphi), problemas quando
|*    o componente está dentro de DLLs
|* 27/10/2005: Daniel Simoes de Almeida
|*    Desativada a TACBrThreadEnviaLPT, comentando o  $DEFINE ThreadEnviaLPT
|*    devido a Problemas como "Erro gravando em LPTx"....  TODO: Corrigir...
|* 22/11/2005: Daniel Simoes de Almeida
|*    modificado gravação em Arquivos Texto para verificar se o arquivo já
|*    existe e adcionar dados no final, ao inves de sempre sobrescreve-lo
|* 13/03/2006: Daniel Simoes de Almeida
|* - Permite modificar alguns parametros da porta serial mesmo com ela aberta.
|* - Modificaçoes em run-time nos parametros da serial não eram efetivadas na
|*   Synaser
******************************************************************************}

{$I ACBr.inc}

//{$DEFINE ThreadEnviaLPT}  { Use // no inicio dessa linha para desabilitar a Thread}

{$IFDEF LINUX}
   { Thread TACBrThreadEnviaLPT não funciona muito bem no Linux }
   { infelizmente, Strings grandes nao funcionam bem no LINUX usando a Thread}
  {$UNDEF ThreadEnviaLPT}
{$ENDIF}

Unit ACBrBase ;

interface
uses SysUtils,
     ACBrConsts,
     {$IFDEF COMPILER6_UP}
        Types, 
     {$ELSE}
        Windows, ACBrD5,
     {$ENDIF}
     {$IFNDEF CONSOLE}
       {$IFDEF VisualCLX}
          QDialogs, 
       {$ELSE}
          Dialogs,
       {$ENDIF}
     {$ENDIF}
     Classes ;

type

TACBrAboutInfo = (ACBrAbout);

{ ACBrComponente contém apenas a propriedade ACBrAbout }
TACBrComponent = class( TComponent )
  private
    fsAbout: TACBrAboutInfo;
  published
     property AboutACBr : TACBrAboutInfo read fsAbout write fsAbout
                           stored false ;
  end ;

{ Essa classe emula um TTimer, porem em uma Thread, evitando sobrecarregar
  o Application. Usada por ACBrLCB e ACBrDIS }
TACBrThreadTimer = class(TThread)
  private
    fsOnTimer : TNotifyEvent;
    fsEnabled: Boolean;
    fsInterval: Integer;
    procedure SetEnabled(const Value: Boolean);
    procedure SetInterval(const Value: Integer);
  protected
    procedure ChamarEvento;
    procedure Execute; override;
  public
    constructor Create ;
  published
    property OnTimer  : TNotifyEvent read fsOnTimer write fsOnTimer ;
    property Interval : Integer read fsInterval write SetInterval ;
    property Enabled : Boolean read fsEnabled write SetEnabled ;
  end;


procedure ACBrAboutDialog ;

implementation
Uses ACBrUtil ;

procedure ACBrAboutDialog ;
var Msg : String ;
begin
  {$IFDEF CONSOLE}
      Msg := 'Componentes ACBr CONSOLE'+sLineBreak+
             'Automação Comercial Brasil'+sLineBreak+
             'http://acbr.sourceforge.net'+sLineBreak+
             'Versão: '+ACBR_VERSAO ;
      writeln( Msg )
  {$ELSE}
    {$IFDEF VisualCLX}
      Msg := 'Componentes <b>ACBr CLX</b><BR>'+
              'Automação Comercial Brasil<BR><BR>'+
              '<A HREF="http://acbr.sourceforge.net">'+
              'http://acbr.sourceforge.net</A><BR><BR>'+
              'Versão: <b>'+ACBR_VERSAO+'</b>' ;
    {$ELSE}
      Msg := 'Componentes ACBr VCL'+#10+
             'Automação Comercial Brasil'+#10+#10+
             'http://acbr.sourceforge.net'+#10+#10+
             'Versão: '+ACBR_VERSAO ;
    {$ENDIF}

     MessageDlg(Msg ,mtInformation ,[mbOk],0) ;
 {$ENDIF}
end;



{------------------------------ TACBrThreadTimer ------------------------------}
constructor TACBrThreadTimer.Create ;
begin
  inherited Create( true );   { CreateSuspended }

  fsInterval := 0 ;
  fsEnabled  := false ;
  fsOnTimer  := nil ;
end;

procedure TACBrThreadTimer.Execute;
begin                              
  while not Terminated do
  begin
     Sleep( fsInterval );

     if fsEnabled and Assigned( fsOntimer ) then
      {$IFNDEF CONSOLE}
        Synchronize( ChamarEvento ) 
      {$ELSE}
        fsOnTimer( self )
      {$ENDIF}
     else
        Sleep( 100 );
  end ;
end;

procedure TACBrThreadTimer.ChamarEvento;
begin
  fsOnTimer( self ) ;
end;

procedure TACBrThreadTimer.SetEnabled(const Value: Boolean);
begin
  if fsEnabled = Value then exit ;

  fsEnabled := Value;

  if Value then
   begin
     if Suspended then Resume ;
   end
  else
    {$IFNDEF CONSOLE}
     if not Suspended then Suspend ;
    {$ENDIF}
end;

procedure TACBrThreadTimer.SetInterval(const Value: Integer);
begin
  fsInterval := Value;
  if Value = 0 then
     Enabled := false ;
end;

end.

