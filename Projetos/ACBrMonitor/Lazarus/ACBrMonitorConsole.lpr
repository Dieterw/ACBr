{******************************************************************************}
{ Projeto: ACBr Monitor                                                        }
{  Executavel multiplataforma que faz uso do conjunto de componentes ACBr para }
{ criar uma interface de comunicação com equipamentos de automacao comercial.  }
{                                                                              }
{ Direitos Autorais Reservados (c) 2006 Daniel Simoes de Almeida               }
{                                                                              }
{ Colaboradores nesse arquivo:                                                 }
{                                                                              }
{  Você pode obter a última versão desse arquivo na página do Projeto ACBr     }
{ Componentes localizado em      http://www.sourceforge.net/projects/acbr      }
{                                                                              }
{  Este programa é software livre; você pode redistribuí-lo e/ou modificá-lo   }
{ sob os termos da Licença Pública Geral GNU, conforme publicada pela Free     }
{ Software Foundation; tanto a versão 2 da Licença como (a seu critério)       }
{ qualquer versão mais nova.                                                   }
{                                                                              }
{  Este programa é distribuído na expectativa de ser útil, mas SEM NENHUMA     }
{ GARANTIA; nem mesmo a garantia implícita de COMERCIALIZAÇÃO OU DE ADEQUAÇÃO A}
{ QUALQUER PROPÓSITO EM PARTICULAR. Consulte a Licença Pública Geral GNU para  }
{ obter mais detalhes. (Arquivo LICENCA.TXT ou LICENSE.TXT)                    }
{                                                                              }
{  Você deve ter recebido uma cópia da Licença Pública Geral GNU junto com este}
{ programa; se não, escreva para a Free Software Foundation, Inc., 59 Temple   }
{ Place, Suite 330, Boston, MA 02111-1307, USA. Você também pode obter uma     }
{ copia da licença em:  http://www.opensource.org/licenses/gpl-license.php     }
{                                                                              }
{ Daniel Simões de Almeida  -  daniel@djsystem.com.br  -  www.djsystem.com.br  }
{              Praça Anita Costa, 34 - Tatuí - SP - 18270-410                  }
{                                                                              }
{******************************************************************************}

program ACBrMonitorConsole;

{$APPTYPE CONSOLE}
{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}
   Libc,
   {$IFDEF UseCThreads}cthreads,{$ENDIF}
  {$ENDIF}
  Classes, SysUtils, IniFiles,
  CustApp, ACBrBase, ACBrUtil, ACBrConsts, ACBrECF, ACBrECFNaoFiscal,
  UtilUnit,
  ACBrMonitorConsoleDM in 'ACBrMonitorConsoleDM.pas',
  DoACBrUnit, DoETQUnit, DoLCBUnit, DoBALUnit, DoCEPUnit, DoCHQUnit,
  DoDISUnit, DoECFUnit, DoGAVUnit, DoIBGEUnit,
  DoECFBemafi32, DoECFObserver ; // Units de tradução dos comandos

type

  { TACBrMonitorConsole }

  TACBrMonitorConsole = class(TCustomApplication)
  protected
    procedure DoRun; override;
  public
    constructor Create(TheOwner: TComponent); override;
    destructor Destroy; override;
    procedure WriteHelp; virtual;
  end;

{ TACBrMonitorConsole }

Var I : Integer;
    ArqINI : String ;
    Ini    : TIniFile ;

{$IFDEF LINUX}
procedure SignalProc(SigNum: Integer); cdecl;
 Var LogMsg : String ;
begin
  LogMsg := 'Sinal: ' ;

  case SigNum of
     SIGINT  :
        LogMsg := LogMsg + 'SIGINT' ;
     SIGSTOP :
        LogMsg := LogMsg + 'SIGSTOP' ;
     SIGTSTP :
        LogMsg := LogMsg + 'SIGTSTP' ;
     SIGQUIT :
        LogMsg := LogMsg + 'SIGQUIT' ;
  else
     LogMsg := LogMsg + IntToStr(SigNum) ;
  end;

  WriteLn( LogMsg );
  if dm.GravarLog then
      WriteToTXT(dm.ArqLogTXT, LogMsg );
end;
{$ENDIF}

procedure TACBrMonitorConsole.DoRun;
var
  ErrorMsg: String;
begin
  // quick check parameters
  ErrorMsg:=CheckOptions('h','help');
  if ErrorMsg<>'' then begin
    ShowException(Exception.Create(ErrorMsg));
    Terminate;
    Exit;
  end;

  // parse parameters
  if HasOption('h','help') then begin
    WriteHelp;
    Terminate;
    Exit;
  end;

  { add your program here }

  // stop program loop
  Terminate;
end;

constructor TACBrMonitorConsole.Create(TheOwner: TComponent);
begin
  inherited Create(TheOwner);
end;

destructor TACBrMonitorConsole.Destroy;
begin
  inherited Destroy;
end;

procedure TACBrMonitorConsole.WriteHelp;
begin
  { add your help code here }
  writeln('Usage: ',ExeName,' -h');
end;

var
  Application: TACBrMonitorConsole;

{$R *.res}

begin
  Application:=TACBrMonitorConsole.Create(nil);
  Application.Run;
  Application.Free;
end.

