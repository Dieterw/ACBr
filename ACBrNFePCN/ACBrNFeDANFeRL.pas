{******************************************************************************}
{ Projeto: Componente ACBrNFe                                                  }
{  Biblioteca multiplataforma de componentes Delphi para emissão de Nota Fiscal}
{ eletrônica - NFe - http://www.nfe.fazenda.gov.br                          }
{                                                                              }
{ Direitos Autorais Reservados (c) 2008 Wemerson Souto                         }
{                                       Daniel Simoes de Almeida               }
{                                       André Ferreira de Moraes               }
{                                                                              }
{ Colaboradores nesse arquivo:                                                 }
{                                                                              }
{  Você pode obter a última versão desse arquivo na pagina do Projeto ACBr     }
{ Componentes localizado em http://www.sourceforge.net/projects/acbr           }
{                                                                              }
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
|* 16/12/2008: Wemerson Souto
|*  - Doação do componente para o Projeto ACBr
|* 20/08/2009: Caique Rodrigues
|*  - Doação units para geração do Danfe via QuickReport
******************************************************************************}
{$I ACBr.inc}
unit ACBrNFeDANFeRL;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, RLReport, pcnNFe, ACBrNFe, RLFilters;
type
  TfrlDANFeRL = class(TForm)
    RLNFe: TRLReport;

  private
    { Private declarations }
  protected
    FACBrNFe: TACBrNFe;
    FNFe: TNFe;
    FUrl: String;
    FLogo: String;
    FMarcaDagua: String;
    AfterPreview : boolean ;
    ChangedPos : boolean ;
    FSemValorFiscal : boolean ;
    procedure qrlSemValorFiscalPrint(sender: TObject; var Value: String);
  public
    { Public declarations }
    class procedure Imprimir(ANFe: TNFe; ALogo: String = ''; AMarcaDagua: String = ''; AUrl: String = '' ; APreview : Boolean = True );
    class procedure SavePDF(ANFe: TNFe;  ALogo: String = ''; AMarcaDagua: String = ''; AFile: String = '');

  end;

implementation

uses MaskUtils;

{$R *.dfm}

class procedure TfrlDANFeRL.Imprimir(ANFe: TNFe;  ALogo: String = ''; AMarcaDagua: String = ''; AUrl: String = '' ; APreview : Boolean = True );
begin
  with Create ( nil ) do
     try
        FNFe  := ANFe;
        FUrl  := AUrl;
        FLogo := ALogo;
        FMarcaDagua := AMarcaDagua;
        if APreview then
          RLNFe.Preview
        else
           begin
              AfterPreview := True ;
              RLNFe.Print ;
           end ;
     finally
        Free ;
     end ;
end;

class procedure TfrlDANFeRL.SavePDF(ANFe: TNFe;  ALogo: String = ''; AMarcaDagua: String = ''; AFile: String = '');
begin
  with Create ( nil ) do
     try
        FNFe  := ANFe;
        FLogo := ALogo;
        FMarcaDagua := AMarcaDagua;
        RLNFe.SaveToFile(AFile);
     finally
        Free ;
     end ;
end;

procedure TfrlDANFeRL.qrlSemValorFiscalPrint(sender: TObject;
  var Value: String);
begin
  inherited;
  if FSemValorFiscal then
     Value := '' ;
end;

end.
