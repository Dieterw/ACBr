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
|* 20/08/2009: João Paulo
|*  - Doação units para geração do Danfe via código usando Rave
******************************************************************************}
{$I ACBr.inc}
unit ACBrNFeDANFERaveCB;

interface

uses Forms, SysUtils, Classes,
  RpDefine, RpDevice, RVClass, RVProj, RVCsBars, RVCsStd, RVCsData,
  RvDirectDataView, RVDataField, jpeg,
  ACBrNFeDANFEClass, ACBrDANFeCBRave, pcnNFe, pcnConversao;

type
  TACBrNFeDANFERaveCB = class( TACBrNFeDANFEClass )
   private
   public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure ImprimirDANFE(NFE : TNFe = nil); override ;
    procedure ImprimirDANFEPDF(NFE : TNFe = nil); override ;
  end;

implementation

uses ACBrNFe, ACBrNFeUtil, ACBrUtil, StrUtils, Dialogs;

constructor TACBrNFeDANFERaveCB.Create(AOwner: TComponent);
begin
  inherited create( AOwner );
end;

destructor TACBrNFeDANFERaveCB.Destroy;
begin
  inherited Destroy ;
end;


procedure TACBrNFeDANFERaveCB.ImprimirDANFE(NFE : TNFe = nil);
var
 i : Integer;
 LogoMarcaEmpresa:TJPEGImage;
begin
    try
      if NotaUtil.NaoEstaVazio(Logo) then
       begin
         LogoMarcaEmpresa:=TJPEGImage.Create;
         LogoMarcaEmpresa.LoadFromFile(Logo);
       end;
      ImprimirDANFeRave(TACBrNFe(ACBrNFe),
                       Site,
                       Email,
                       Fax,
                       Sistema,
                       Usuario,
                       ProtocoloNFe,
                       LogoMarcaEmpresa,
                       NotaUtil.SeSenao((TipoDANFE=tiRetrato),poPortrait,poLandScape),
                       NotaUtil.SeSenao(MostrarPreview,tsPreview,tsPrint),
                       NumCopias,
                       Impressora,
                       '',
                       MargemInferior*10,
                       MargemSuperior*10,
                       MargemEsquerda*10,
                       MargemDireita*10);
    finally
      LogoMarcaEmpresa.Free;
    end;
end;

procedure TACBrNFeDANFERaveCB.ImprimirDANFEPDF(NFE : TNFe = nil);
var
 i : Integer;
 LogoMarcaEmpresa:TJPEGImage;
 NomeArq : String;
begin
    try
      if NotaUtil.NaoEstaVazio(Logo) then
       begin
         LogoMarcaEmpresa:=TJPEGImage.Create;
         LogoMarcaEmpresa.LoadFromFile(Logo);
       end;

      NomeArq := TACBrNFe(ACBrNFe).NotasFiscais.Items[0].NFe.infNFe.ID;
      if length(NomeArq)>44 then
         NomeArq := copy(NomeArq,(length(NomeArq)-44)+1,44);
      if NotaUtil.EstaVazio(FPathArquivos) then
         NomeArq := PathWithDelim(TACBrNFe(ACBrNFe).Configuracoes.Geral.PathSalvar)+NomeArq
      else
         NomeArq := PathWithDelim(FPathArquivos)+NomeArq;
      NomeArq := NomeArq+'.pdf';

      ImprimirDANFeRave(TACBrNFe(ACBrNFe),
                       Site,
                       Email,
                       Fax,
                       Sistema,
                       Usuario,
                       ProtocoloNFe,
                       LogoMarcaEmpresa,
                       NotaUtil.SeSenao((TipoDANFE=tiRetrato),poPortrait,poLandScape),
                       tsPDF,
                       NumCopias,
                       Impressora,
                       NomeArq,
                       MargemInferior*10,
                       MargemSuperior*10,
                       MargemEsquerda*10,
                       MargemDireita*10);
    finally
      LogoMarcaEmpresa.Free;
    end;
end;


end.
