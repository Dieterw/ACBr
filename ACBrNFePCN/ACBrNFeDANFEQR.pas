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
|* 09/03/2009: Dulcemar P.Zilli
|*  - Correcao impressão informações IPI
|* 11/03/2008: Dulcemar P.Zilli
|*  - Inclusão Observações Fisco
|* 11/03/2008: Dulcemar P.Zilli
|*  - Inclusão totais ISSQN
|* 23/06/2009: João H. Souza
|*  - Alterações diversas
******************************************************************************}
{$I ACBr.inc}

unit ACBrNFeDANFEQR;

interface

uses Forms, SysUtils, Classes, RpDefine,
  ACBrNFeDANFEClass, ACBrNFeDANFEQRDM, pcnNFe;

type
  TACBrNFeDANFEQR = class( TACBrNFeDANFEClass )
   private
     formDanfe : TformACBrNFeQR;
   public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure ImprimirDANFE(NFE : TNFe = nil; NumCopias : Integer = 1); override ;
    procedure ImprimirDANFEPDF(NFE : TNFe = nil; NumCopias : Integer = 1); override ;
  end;

implementation

uses ACBrNFe, ACBrNFeUtil, ACBrUtil, StrUtils;

constructor TACBrNFeDANFEQR.Create(AOwner: TComponent);
begin
  inherited create( AOwner );
end;

destructor TACBrNFeDANFEQR.Destroy;
begin
  inherited Destroy ;
end;

procedure TACBrNFeDANFEQR.ImprimirDANFE(NFE : TNFe = nil; NumCopias : Integer = 1);
var
 i : Integer;
 formDanfe : TformACBrNFeQR;
begin
  if NFE = nil then
   begin
     for i:= 0 to TACBrNFe(ACBrNFe).NotasFiscais.Count-1 do
      begin
        formDanfe := TformACBrNFeQR.Create(Self);
        formDanfe.NFe := TACBrNFe(ACBrNFe).NotasFiscais.Items[i].NFe;
        formDanfe.QuickRepDanfe.Visible := False;
        formDanfe.QuickRepDanfe.Preview;
        formDanfe.Free;
      end;
   end
  else
   begin
        formDanfe.NFe := NFE;
        formDanfe.QuickRepDanfe.Visible := False;
        formDanfe.QuickRepDanfe.Preview;

   end;

end;

procedure TACBrNFeDANFEQR.ImprimirDANFEPDF(NFE : TNFe = nil; NumCopias : Integer = 1);
var
 i : Integer;
begin
  if NFE = nil then
   begin
     for i:= 0 to TACBrNFe(ACBrNFe).NotasFiscais.Count-1 do
      begin
//        dmDanfe.NFe := TACBrNFe(ACBrNFe).NotasFiscais.Items[i].NFe;
//        dmDanfe.RvSystem1.OutputFileName := PathWithDelim(FPathArquivos)+dmDanfe.NFe.infNFe.ID+'.pdf';
//        dmDanfe.RvProject.Execute;
      end;
   end
  else
   begin
//     dmDanfe.NFe := NFE;
//     dmDanfe.RvSystem1.OutputFileName := PathWithDelim(FPathArquivos)+dmDanfe.NFe.infNFe.ID+'.pdf';
//     dmDanfe.RvProject.Execute;
   end;
end;


end.
