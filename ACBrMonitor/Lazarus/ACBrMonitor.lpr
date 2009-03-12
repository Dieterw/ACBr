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

program ACBrMonitor;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms
  { you can add units after this },
  {$IFDEF MSWINDOWS}
   Windows,
  {$ENDIF}
  ACBrMonitor1, LResources, ACBr_LCL, CmdUnit,
  UtilUnit, ConfiguraSerial, sndkey32, Sobre, DoCHQUnit, DoECFUnit, DoDISUnit,
  DoECFBemafi32, DoECFObserver, DoETQUnit, DoGAVUnit, DoLCBUnit, DoACBrUnit,
  DoBALUnit;

(*  ACBr_LCL, LResources,
  ACBrMonitor1 in 'ACBrMonitor1.pas' {FrmACBrMonitor},
  Sobre in 'Sobre.pas' {frmSobre},
  ConfiguraSerial in 'ConfiguraSerial.pas' {frConfiguraSerial},
  DoECFUnit in 'DoECFUnit.pas',
  DoGAVUnit in 'DoGAVUnit.pas',
  DoCHQUnit in 'DoCHQUnit.pas',
  DoDISUnit in 'DoDISUnit.pas',
  DoLCBUnit in 'DoLCBUnit.pas',
  CmdUnit in 'CmdUnit.pas',
  DoECFBemafi32 in 'DoECFBemafi32.pas',
  DoECFObserver in 'DoECFObserver.pas',
  DoETQUnit in 'DoETQUnit.pas';*)

{$IFNDEF MSWINDOWS}
var
    FHandle, N    : Integer ;
    ArqFlagAberto : String ;
    Buffer        : Pointer ;
    B             : Byte ;
{$ENDIF}

{$IFDEF WINDOWS}{$R ACBrMonitor.rc}{$ENDIF}

begin
  {$I ACBrMonitor.lrs}
  {$IFDEF MSWINDOWS}
   CreateMutex(nil, True, 'ACBrMonitor');
   if GetLastError = ERROR_ALREADY_EXISTS then
   begin
      Application.MessageBox('O programa ACBrMonitor já está em execução',
                             'ATENÇÃO !!',MB_ICONWARNING) ;
      Application.Terminate ;
   end;
  {$ELSE}
   FHandle := 0 ;
  {$ENDIF}
  Application.Initialize;

  {$IFNDEF MSWINDOWS}
  try
     try
       { Tenta criar arquivo em modo Exclusivo, se NAO conseguir já está rodando }
       B        := 65 ;
       Buffer   := @B ;
       ArqFlagAberto := ExtractFilePath(Application.ExeName) + 'ACBrMonitor_Aberto.tmp' ;

       if FileExists( ArqFlagAberto ) then
          FHandle := FileOpen( ArqFlagAberto, fmOpenReadWrite + fmShareExclusive )
       else
          FHandle := FileCreate( ArqFlagAberto, fmOpenReadWrite + fmShareExclusive );
       if FHandle < 0 then
          raise Exception.Create('Erro abrindo');
       N := FileSeek( FHandle, 0, 0 )  ;
       if N < 0 then
          raise Exception.Create('Erro seek');
       N := FileWrite(Fhandle, Buffer^, 1) ;
       if N < 0 then
          raise Exception.Create('Erro ao escrever');

     except
         if Application.MessageBox('O programa ACBrMonitor já está em execução'+
                                   'Deseja realmente abrir novamente o ACBrMonitor ?',
                                   'ATENÇÃO !!',MB_YESNO + MB_ICONWARNING) <> IDYES then
            raise
         else
            SysUtils.DeleteFile(ArqFlagAberto);
     end;
  {$ENDIF}
  Application.CreateForm(TFrmACBrMonitor, FrmACBrMonitor);

  Application.ShowMainForm := false ;
  Application.Run;
  {$IFNDEF MSWINDOWS}
  finally
    FileClose( FHandle );
    if FHandle > 0 then
       SysUtils.DeleteFile(ArqFlagAberto);
  end ;
  {$ENDIF}
end.

