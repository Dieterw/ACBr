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
|* 20/11/2009: Peterson de Cerqueira Matos
|*             E-mail: peterson161@yahoo.com - Tel: (11) 7197-1474 / 8059-4055
|*  - Componente e Units do QuickReport clonados
|*    e transformados em FORTES REPORT
|* 27/01/2010: Peterson de Cerqueira Matos
|*  - Acréscimo da propriedade "LarguraCodProd", que definirá a largura da
|*    "Código do Produto" no DANFE
|* 15/03/2010: Felipe Feltes
|*  - Adequação na seção 'USES' para ser utilizado em CLX
******************************************************************************}
{$I ACBr.inc}
unit ACBrNFeDANFeRLClass;

interface

uses SysUtils, Classes,  
  {$IFDEF CLX}
  QForms, QDialogs, 
  {$ELSE}
  Forms, Dialogs, 
  {$ENDIF}
  ACBrNFeDANFEClass, ACBrNFeDANFeRLRetrato, pcnNFe, pcnConversao, StrUtils;

type
  TACBrNFeDANFeRL = class( TACBrNFeDANFEClass )
   private
     FMarcadagua: string;
     FLarguraCodProd: Integer;
   public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure ImprimirDANFE(NFE : TNFe = nil); override ;
    procedure ImprimirDANFEPDF(NFE : TNFe = nil); override ;
  published
    property MarcadAgua : String read FMarcadagua write FMarcadagua ;
    property LarguraCodProd: Integer read FLarguraCodProd write FLarguraCodProd;
  end;

implementation

uses ACBrNFe, ACBrNFeUtil, ACBrUtil; 

constructor TACBrNFeDANFeRL.Create(AOwner: TComponent);
begin
  inherited create( AOwner );
  FLarguraCodProd := 52;
end;

destructor TACBrNFeDANFeRL.Destroy;
begin
  inherited Destroy ;
end;


procedure TACBrNFeDANFeRL.ImprimirDANFE(NFE : TNFe = nil);
var
  i : Integer;
  frlDANFeRLRetrato : TfrlDANFeRLRetrato;
  sLogo, sMarcaDagua: String;
  iLarguraCodProd: Integer;
  sEmail: String;
  bResumoCanhoto: Boolean;
  sFax: String;
  iNumCopias: Integer;
  sSsitema: String;
  sSite: String;
  sUsuario: String;

begin
  frlDANFeRLRetrato := TfrlDANFeRLRetrato.Create(Self);
  sLogo := TACBrNFe(ACBrNFe).DANFE.Logo;
  sMarcaDagua := MarcaDagua;
  iLarguraCodProd := LarguraCodProd;
  sEmail := Email;
  bResumoCanhoto := ExibirResumoCanhoto;
  sFax := Fax;
  iNumCopias := NumCopias;
  sSsitema := Sistema;
  sSite := Site;
  sUsuario := Usuario;

  if NFE = nil then
   begin
     for i:= 0 to TACBrNFe(ACBrNFe).NotasFiscais.Count-1 do
      begin
        frlDANFeRLRetrato.Imprimir(TACBrNFe(ACBrNFe).NotasFiscais.Items[i].NFe,
        sLogo, sMarcaDagua, iLarguraCodProd, sEmail, bResumoCanhoto, sFax,
        iNumCopias, sSsitema, sSite, sUsuario);
      end;
   end
  else
    frlDANFeRLRetrato.Imprimir(NFE, sLogo, sMarcaDagua, iLarguraCodProd,
    sEmail, bResumoCanhoto, sFax, iNumCopias, sSsitema, sSite, sUsuario);

  frlDANFeRLRetrato.Free;
end;

procedure TACBrNFeDANFeRL.ImprimirDANFEPDF(NFE : TNFe = nil);
var
  i : Integer;
  frlDANFeRLRetrato : TfrlDANFeRLRetrato;
  sLogo, sMarcaDagua, sFile: String;
  iLarguraCodProd: Integer;
  sEmail: String;
  bResumoCanhoto: Boolean;
  sFax: String;
  iNumCopias: Integer;
  sSsitema: String;
  sSite: String;
  sUsuario: String;
begin
  frlDANFeRLRetrato := TfrlDANFeRLRetrato.Create(Self);
  sLogo := TACBrNFe(ACBrNFe).DANFE.Logo;
  sMarcaDagua := MarcaDagua;
  iLarguraCodProd := LarguraCodProd;
  sEmail := Email;
  bResumoCanhoto := ExibirResumoCanhoto;
  sFax := Fax;
  iNumCopias := NumCopias;
  sSsitema := Sistema;
  sSite := Site;
  sUsuario := Usuario;

  if NFE = nil then
   begin
     for i:= 0 to TACBrNFe(ACBrNFe).NotasFiscais.Count-1 do
      begin
        sFile := TACBrNFe(ACBrNFe).DANFE.PathPDF + Copy(TACBrNFe(ACBrNFe).NotasFiscais.Items[i].NFe.infNFe.ID, 4, 44) + '-nfe.pdf';
        frlDANFeRLRetrato.SavePDF(TACBrNFe(ACBrNFe).NotasFiscais.Items[i].NFe,
        sLogo, sMarcaDagua, iLarguraCodProd, sEmail, bResumoCanhoto, sFax,
        iNumCopias, sSsitema, sSite, sUsuario, sFile);
      end;
   end;

  frlDANFeRLRetrato.Free;
end;

end.
