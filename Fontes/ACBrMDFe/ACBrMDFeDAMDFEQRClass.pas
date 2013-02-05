{******************************************************************************}
{ Projeto: Componente ACBrMDFe                                                 }
{  Biblioteca multiplataforma de componentes Delphi                            }
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
|* 01/08/2012: Italo Jurisato Junior
|*  - Doação do componente para o Projeto ACBr
******************************************************************************}

{$I ACBr.inc}

unit ACBrMDFeDAMDFEQRClass;

interface

uses
  Forms, SysUtils, Classes,
  ACBrMDFeDAMDFEClass, pmdfeMDFe;

type
  TACBrMDFeDAMDFEQR = class( TACBrMDFeDAMDFEClass )
   private
   public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure ImprimirDAMDFE(MDFe: TMDFe = nil); override;
    procedure ImprimirDAMDFEPDF(MDFe: TMDFe = nil); override;
  end;

implementation

uses
 StrUtils, Dialogs,
 ACBrUtil, ACBrMDFe, ACBrMDFeUtil, ACBrMDFeDAMDFEQRRetrato;

constructor TACBrMDFeDAMDFEQR.Create(AOwner: TComponent);
begin
  inherited create( AOwner );
end;

destructor TACBrMDFeDAMDFEQR.Destroy;
begin
  inherited Destroy;
end;

procedure TACBrMDFeDAMDFEQR.ImprimirDAMDFE(MDFe: TMDFe = nil);
var
 i: Integer;
 fqrDAMDFEQRRetrato: TfqrDAMDFEQRRetrato;
 sProt: String;
begin
  fqrDAMDFEQRRetrato := TfqrDAMDFEQRRetrato.Create(Self);

  sProt := TACBrMDFe(ACBrMDFe).DAMDFE.ProtocoloMDFe;
  fqrDAMDFEQRRetrato.ProtocoloMDFe( sProt );

  if MDFe = nil then
   begin
     for i:= 0 to TACBrMDFe(ACBrMDFe).Manifestos.Count-1 do
      begin
        fqrDAMDFEQRRetrato.Imprimir( TACBrMDFe(ACBrMDFe).Manifestos.Items[i].MDFe
                                   , Logo
                                   , Email
                                   , ExpandirLogoMarca
                                   , Fax
                                   , NumCopias
                                   , Sistema
                                   , Site
                                   , Usuario
                                   , MostrarPreview
                                   , MargemSuperior
                                   , MargemInferior
                                   , MargemEsquerda
                                   , MargemDireita
                                   , Impressora );
      end;
   end
  else
     fqrDAMDFEQRRetrato.Imprimir( MDFe
                                , Logo
                                , Email
                                , ExpandirLogoMarca
                                , Fax
                                , NumCopias
                                , Sistema
                                , Site
                                , Usuario
                                , MostrarPreview
                                , MargemSuperior
                                , MargemInferior
                                , MargemEsquerda
                                , MargemDireita
                                , Impressora );

  fqrDAMDFEQRRetrato.Free;
end;

procedure TACBrMDFeDAMDFEQR.ImprimirDAMDFEPDF(MDFe: TMDFe = nil);
var
 NomeArq: String;
 i: Integer;
 fqrDAMDFEQRRetrato: TfqrDAMDFEQRRetrato;
 sProt: String;
begin
  fqrDAMDFEQRRetrato := TfqrDAMDFEQRRetrato.Create(Self);

  sProt := TACBrMDFe(ACBrMDFe).DAMDFe.ProtocoloMDFe;
  fqrDAMDFEQRRetrato.ProtocoloMDFe( sProt );
  if MDFe = nil then
  begin
    for i:= 0 to TACBrMDFe(ACBrMDFe).Manifestos.Count-1 do
    begin
      NomeArq := StringReplace(TACBrMDFe(ACBrMDFe).Manifestos.Items[i].MDFe.infMDFe.ID,'MDFe', '', [rfIgnoreCase]);
      NomeArq := PathWithDelim(Self.PathPDF)+NomeArq+'.pdf';

      fqrDAMDFEQRRetrato.SavePDF( NomeArq
                                 ,TACBrMDFe(ACBrMDFe).Manifestos.Items[i].MDFe
                                 , Logo
                                 , Email
                                 , ExpandirLogoMarca
                                 , Fax
                                 , NumCopias
                                 , Sistema
                                 , Site
                                 , Usuario
                                 , MargemSuperior
                                 , MargemInferior
                                 , MargemEsquerda
                                 , MargemDireita );
    end;
  end
  else
  begin
    NomeArq := StringReplace(MDFe.infMDFe.ID,'MDFe', '', [rfIgnoreCase]);
    NomeArq := PathWithDelim(Self.PathPDF)+NomeArq+'.pdf';

    fqrDAMDFEQRRetrato.SavePDF( NomeArq
                              , MDFe
                              , Logo
                              , Email
                              , ExpandirLogoMarca
                              , Fax
                              , NumCopias
                              , Sistema
                              , Site
                              , Usuario
                              , MargemSuperior
                              , MargemInferior
                              , MargemEsquerda
                              , MargemDireita );
  end;

  fqrDAMDFEQRRetrato.Free;
end;

end.
