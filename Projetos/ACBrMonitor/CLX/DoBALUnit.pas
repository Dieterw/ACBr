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

{$DEFINE VisualCLX}
{$I ACBr.inc}

unit DoBALUnit ;

interface
Uses Classes, TypInfo, SysUtils, CmdUnit ;

Procedure DoBAL( Cmd : TACBrCmd ) ;

implementation
uses ACBrBAL, ACBrUtil, StrUtils,
  {$IFNDEF CONSOLE}ACBrMonitor1 {$ELSE}ACBrMonitorConsoleDM {$ENDIF} ;

Procedure DoBAL( Cmd : TACBrCmd ) ;
begin
  with {$IFNDEF CONSOLE}FrmACBrMonitor.ACBrBAL1 {$ELSE}dm.ACBrBAL1 {$ENDIF} do
  begin
     try
        if Cmd.Metodo = 'ativar' then begin { Ativa a Balança }
           Ativar ;

           LePeso ;
           if UltimaResposta = '' then begin
              Desativar ;
              raise Exception.Create('Balança não responde!') ;
           end ;
        end

        else if Cmd.Metodo = 'desativar' then
           Desativar

        else if Cmd.Metodo = 'ativo' then
           Cmd.Resposta := BoolToStr(Ativo, true)

        else if Cmd.Metodo = 'porta' then
           Cmd.Resposta := Porta

        else if Cmd.Metodo = 'intervalo' then
           Cmd.Resposta := IntToStr( Intervalo )

        else if Cmd.Metodo = 'setintervalo' then
           Intervalo := StrToInt( Cmd.Params(0) )

        else if Cmd.Metodo = 'lepeso' then begin
           LePeso;
           if UltimaResposta <> '' then
              Cmd.Resposta := FormatFloat('#####0.000', UltimoPesoLido)
           else
              raise Exception.Create('Timeout');
        end

        else if Cmd.Metodo = 'ultimopesolido' then
           Cmd.Resposta := FormatFloat('#####0.000', UltimoPesoLido)

        ELSE
           raise Exception.Create('Comando inválido ('+Cmd.Comando+')') ;

     finally
        { Nada a fazer aqui por enquanto... :) }
     end ;
  end ;
end ;

end.

