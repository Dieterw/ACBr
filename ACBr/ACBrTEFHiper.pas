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
|*  - Implementada ativacao do GP para Hipercard
|* 17/04/2008: Jhony Alceu Pereira (JhonyStein)
|*  - Correcao nas declaracoes ciclicas dos uses
*******************************************************************************}

{$I ACBr.inc}
unit ACBrTEFHiper;

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

type TACBrTEFHiper = class( TACBrTEFClass )
   public
      constructor Create(AOwner: TComponent) ; //Override;
      procedure Ativar ; Override;

end ;

implementation

uses ACBrTEF;

{ THiperTef }
constructor TACBrTEFHiper.Create(AOwner: TComponent);
begin
   inherited Create( AOwner );

   fpTipoStr             := 'Hiper TEF' ;
   fpBaseDir             := 'C:\HiperTEF\';
   fpReqTempFileName     := BaseDir + 'req\IntPos.tmp';
   fpReqFileName         := BaseDir + 'req\IntPos.001';
   fpRespFileName        := BaseDir + 'resp\IntPos.Sts';
   fpRespDataFileName    := BaseDir + 'resp\IntPos.001';
   fpRespTempDataFileName:= 'C:\ACBrTEFResp.tmp';
end;

procedure TACBrTEFHiper.Ativar;
begin
   if not DirectoryExists(ExtractFilePath(RespTempDataFileName)) then
      ForceDirectories(ExtractFilePath(RespTempDataFileName));  

   if not GPAtivo then
   begin
      If fpAtivarGP then
      begin
         If MessageDlg(RS_INACTIVETEF + #10#13 + 'Posso tentar ativar o GP agora ?', mtConfirmation, mbOKCancel, 0) = 1 then
         begin
            RunCommand(fpBaseDir+'HiperTEF.exe', '', False, 0);
            Ativar;
         end;
      end
      else
         raise Exception.Create(RS_INACTIVETEF);
   end;

   VerificaTransacaoPendente;
   fpAtivo := True;
end;

end.
 
