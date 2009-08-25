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
unit ACBrNFeDANFeQR;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, QuickRpt, 
  QRCtrls, ACBrNFeQRCodeBar, pcnNFe ;

type
  TfqrDANFeQR = class(TForm)
    QRNFe: TQuickRep;
  private
    { Private declarations }
  protected
    //BarCode : TBarCode128c ;
    FNFe: TNFe;
    FLogo: String;
    FUrl: String;
    AfterPreview : boolean ;
    ChangedPos : boolean ;
    FSemValorFiscal : boolean ;
    procedure qrlSemValorFiscalPrint(sender: TObject; var Value: String);
    procedure SetBarCodeImage ( ACode : String ; QRImage : TQRImage ) ;
  public
    { Public declarations }
    class procedure Imprimir(ANFe: TNFe; ALogo: String = ''; AUrl: String = '' ; APreview : Boolean = True );
    class procedure SavePDF(AFile: String; ANFe: TNFe; ALogo, AUrl: String);

  end;


implementation

uses MaskUtils;

{$R *.dfm}

class procedure TfqrDANFeQR.Imprimir(ANFe: TNFe; ALogo: String = ''; AUrl: String = '' ; APreview : Boolean = True );
begin
  with Create ( nil ) do
     try
        FNFe  := ANFe;
        FLogo := ALogo;
        FUrl  := AUrl;

        if APreview then
           QRNFe.Preview
        else
           begin
              AfterPreview := True ;
              QRNFe.Print ;
           end ;
     finally
        Free ;
     end ;
end;

class procedure TfqrDANFeQR.SavePDF(AFile: String; ANFe: TNFe; ALogo, AUrl: String);
Var
  i: Integer;
//  qf : TQRPDFDocumentFilter ;
begin
{  with Create ( nil ) do
     try
        FNFe  := ANFe;
        FLogo := ALogo;
        FUrl  := AUrl;

        For i := 0 to ComponentCount -1 do
          begin
            if (Components[i] is TQRShape) and (TQRShape(Components[i]).Shape = qrsRoundRect) then
              begin
                TQRShape(Components[i]).Shape := qrsRectangle;
                TQRShape(Components[i]).Pen.Width := 1;
              end;
          end;

        AfterPreview := True ;
        QRNFe.Prepare;

        qf := TQRPDFDocumentFilter.Create(AFile) ;
        qf.CompressionOn := False;
        qf.SetDocumentInfo( 'TurboCode NFe/CTe Integrator', 'www.turbocode.com.br', 'NFe', 'DANFe'  );
        QRNFe.QRPrinter.ExportToFilter( qf );
        qf.Free ;
     finally
        Free ;
     end ;}
end;

procedure TfqrDANFeQR.qrlSemValorFiscalPrint(sender: TObject;
  var Value: String);
begin
  inherited;
  if FSemValorFiscal then
     Value := '' ;
end;

procedure TfqrDANFeQR.SetBarCodeImage(ACode: String; QRImage: TQRImage);
var
 b : TBarCode128c ;
begin
   b := TBarCode128c.Create;
//      Width  := QRImage.Width ;
   b.Code := ACode ;
   b.PaintCodeToCanvas( ACode, QRImage.Canvas, QRImage.ClientRect );
   b.free ;

end;

end.
