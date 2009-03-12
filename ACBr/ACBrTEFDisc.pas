{******************************************************************************}
{ Projeto: Componentes ACBr                                                    }
{  Biblioteca multiplataforma de componentes Delphi para interação com equipa- }
{ mentos de Automação Comercial utilizados no Brasil                           }
{                                                                              }
{ Direitos Autorais Reservados (c) 2007   Maicon da Silva Evangeslista         }
{                                                                              }
{ Colaboradores nesse arquivo:            Daniel Simões de Almeida             }
{                                                                              }
{   Código original por Valdir Stiebe Junior-valdir@dype.com.br-outubro/2006   }
{   Componente finalizado por Maicon da Silva Evangeslista-maiconsi@hotmail.com}
{  em julho/2007...                                                            }
{                                                                              }
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
{ http://www.opensource.org/licenses/gpl-license.php                           }
{                                                                              }
{ Maicon da Silva Evangelista  -  maiconsi@hotmail.com                         }
{              Rua Marechal Rondon, 866 - Lucélia - SP - 17780-000             }
{                                                                              }
{******************************************************************************}

{******************************************************************************
|* Historico
|*
|* 20/07/2007: Maicon da Silva Evangelista
|*  - Inicio do desenvolvimento
|* 03/04/2008: Jhony Alceu Pereira (JhonyStein)
|*  - Inclusão do valor da propriedade RespTempDataFileName
|* 17/04/2008: Jhony Alceu Pereira (JhonyStein)
|*  - Correcao nas declaracoes ciclicas dos uses
*******************************************************************************}

{$I ACBr.inc}
unit ACBrTEFDisc;

interface
uses ACBrTEFClass, ACBrUtil, Classes, SysUtils
     {$IFDEF COMPILER6_UP}
       ,DateUtils, StrUtils
     {$ELSE}
       ,ACBrD5, FileCtrl
     {$ENDIF}
     {$IFDEF VisualCLX}
       ,Qt, QControls, QForms, QGraphics, QDialogs, QExtCtrls
     {$ELSE}
       ,Contnrs, Controls, Forms, Graphics, Dialogs, ExtCtrls, Windows
     {$ENDIF} ;

type TACBrTEFDisc = class( TACBrTEFClass )
   public
      constructor Create(AOwner: TComponent) ; //Override;
      procedure Ativar ; Override;
      function PAG(AValor: Double): Boolean;   
end ;

implementation

uses ACBrTEF;

{ TTefBanricompras }
constructor TACBrTEFDisc.Create(AOwner: TComponent);
begin
   inherited Create( AOwner );

   fpTipoStr             := 'TEF Banricompras ' ;
   fpBaseDir             := 'C:\TEF_DISC\';
   fpReqTempFileName     := BaseDir + 'REQ\IntPos.tmp';
   fpReqFileName         := BaseDir + 'REQ\IntPos.001';
   fpRespFileName        := BaseDir + 'RESP\IntPos.Sts';
   fpRespDataFileName    := BaseDir + 'RESP\IntPos.001';
   fpRespTempDataFileName:= 'C:\ACBrTEFResp.tmp';
end;

procedure TACBrTEFDisc.Ativar;
begin
   if not DirectoryExists(ExtractFilePath(RespTempDataFileName)) then
      ForceDirectories(ExtractFilePath(RespTempDataFileName));  

   if not GPAtivo then
      raise Exception.Create(RS_INACTIVETEF);

   VerificaTransacaoPendente;
   fpAtivo := True;
end;

function TACBrTEFDisc.PAG(AValor: Double): Boolean;
var
  oldDecimalSeparator: char;
begin
  fsIdle := False;
  try
    Comando.Clear;
    Comando.Add('000-000 = PAG');
    oldDecimalSeparator := DecimalSeparator;
    DecimalSeparator := '.';
    try
      Comando.Add('003-000 = ' + StringReplace(FormatFloat('0.00', AValor), '.', '', [rfReplaceAll]));
    finally
      DecimalSeparator := oldDecimalSeparator;
    end;
    Comando.Add('999-999 = 0');
    Result := EnviaComando;
  finally
    fsIdle := True;
  end;
end;

end.
 
