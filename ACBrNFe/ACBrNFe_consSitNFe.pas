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
|* 13/03/2009: Dulcemar P. Zilli
|*  - Atualização para Pacote Pl_005c
******************************************************************************}

{*********************************************************}
{                                                         }
{                    XML Data Binding                     }
{                                                         }
{         Generated on: 13/03/2009 11:21:57               }
{       Generated from: .\PL_005c\consSitNFe_v1.07.xsd   }
{                                                         }
{*********************************************************}

unit ACBrNFe_consSitNFe;

interface

uses xmldom, XMLDoc, XMLIntf;

type

{ Forward Decls }

  IXMLTConsSitNFe = interface;

{ IXMLTConsSitNFe }

  IXMLTConsSitNFe = interface(IXMLNode)
    ['{AAE56C63-6E50-4794-AFC4-170008885BF9}']
    { Property Accessors }
    function Get_Versao: WideString;
    function Get_TpAmb: WideString;
    function Get_XServ: WideString;
    function Get_ChNFe: WideString;
    procedure Set_Versao(Value: WideString);
    procedure Set_TpAmb(Value: WideString);
    procedure Set_XServ(Value: WideString);
    procedure Set_ChNFe(Value: WideString);
    { Methods & Properties }
    property Versao: WideString read Get_Versao write Set_Versao;
    property TpAmb: WideString read Get_TpAmb write Set_TpAmb;
    property XServ: WideString read Get_XServ write Set_XServ;
    property ChNFe: WideString read Get_ChNFe write Set_ChNFe;
  end;

{ Forward Decls }

  TXMLTConsSitNFe = class;

{ TXMLTConsSitNFe }

  TXMLTConsSitNFe = class(TXMLNode, IXMLTConsSitNFe)
  protected
    { IXMLTConsSitNFe }
    function Get_Versao: WideString;
    function Get_TpAmb: WideString;
    function Get_XServ: WideString;
    function Get_ChNFe: WideString;
    procedure Set_Versao(Value: WideString);
    procedure Set_TpAmb(Value: WideString);
    procedure Set_XServ(Value: WideString);
    procedure Set_ChNFe(Value: WideString);
  end;

{ Global Functions }

function GetconsSitNFe(Doc: IXMLDocument): IXMLTConsSitNFe;
function LoadconsSitNFe(const FileName: WideString): IXMLTConsSitNFe;
function NewconsSitNFe: IXMLTConsSitNFe;

const
  TargetNamespace = 'http://www.portalfiscal.inf.br/nfe';

implementation

{ Global Functions }

function GetconsSitNFe(Doc: IXMLDocument): IXMLTConsSitNFe;
begin
  Result := Doc.GetDocBinding('consSitNFe', TXMLTConsSitNFe, TargetNamespace) as IXMLTConsSitNFe;
end;

function LoadconsSitNFe(const FileName: WideString): IXMLTConsSitNFe;
begin
  Result := LoadXMLDocument(FileName).GetDocBinding('consSitNFe', TXMLTConsSitNFe, TargetNamespace) as IXMLTConsSitNFe;
end;

function NewconsSitNFe: IXMLTConsSitNFe;
begin
  Result := NewXMLDocument.GetDocBinding('consSitNFe', TXMLTConsSitNFe, TargetNamespace) as IXMLTConsSitNFe;
end;

{ TXMLTConsSitNFe }

function TXMLTConsSitNFe.Get_Versao: WideString;
begin
  Result := AttributeNodes['versao'].Text;
end;

procedure TXMLTConsSitNFe.Set_Versao(Value: WideString);
begin
  SetAttribute('versao', Value);
end;

function TXMLTConsSitNFe.Get_TpAmb: WideString;
begin
  Result := ChildNodes['tpAmb'].Text;
end;

procedure TXMLTConsSitNFe.Set_TpAmb(Value: WideString);
begin
  ChildNodes['tpAmb'].NodeValue := Value;
end;

function TXMLTConsSitNFe.Get_XServ: WideString;
begin
  Result := ChildNodes['xServ'].Text;
end;

procedure TXMLTConsSitNFe.Set_XServ(Value: WideString);
begin
  ChildNodes['xServ'].NodeValue := Value;
end;

function TXMLTConsSitNFe.Get_ChNFe: WideString;
begin
  Result := ChildNodes['chNFe'].Text;
end;

procedure TXMLTConsSitNFe.Set_ChNFe(Value: WideString);
begin
  ChildNodes['chNFe'].NodeValue := Value;
end;

end. 