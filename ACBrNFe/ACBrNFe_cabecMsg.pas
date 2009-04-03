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

{*******************************************************}
{                                                       }
{                   XML Data Binding                    }
{                                                       }
{         Generated on: 13/03/2009 11:07:47             }
{       Generated from: .\PL_005c\cabecMsg_v1.02.xsd   }
{                                                       }
{*******************************************************}

unit ACBrNFe_cabecMsg;

interface

uses xmldom, XMLDoc, XMLIntf;

type

{ Forward Decls }

  IXMLCabecMsg = interface;

{ IXMLCabecMsg }

  IXMLCabecMsg = interface(IXMLNode)
    ['{00BBE9D2-757D-443D-B7C3-67A4AF851EC4}']
    { Property Accessors }
    function Get_Versao: WideString;
    function Get_VersaoDados: WideString;
    procedure Set_Versao(Value: WideString);
    procedure Set_VersaoDados(Value: WideString);
    { Methods & Properties }
    property Versao: WideString read Get_Versao write Set_Versao;
    property VersaoDados: WideString read Get_VersaoDados write Set_VersaoDados;
  end;

{ Forward Decls }

  TXMLCabecMsg = class;

{ TXMLCabecMsg }

  TXMLCabecMsg = class(TXMLNode, IXMLCabecMsg)
  protected
    { IXMLCabecMsg }
    function Get_Versao: WideString;
    function Get_VersaoDados: WideString;
    procedure Set_Versao(Value: WideString);
    procedure Set_VersaoDados(Value: WideString);
  end;

{ Global Functions }

function GetcabecMsg(Doc: IXMLDocument): IXMLCabecMsg;
function LoadcabecMsg(const FileName: WideString): IXMLCabecMsg;
function NewcabecMsg: IXMLCabecMsg;

const
  TargetNamespace = 'http://www.portalfiscal.inf.br/nfe';

implementation

{ Global Functions }

function GetcabecMsg(Doc: IXMLDocument): IXMLCabecMsg;
begin
  Result := Doc.GetDocBinding('cabecMsg', TXMLCabecMsg, TargetNamespace) as IXMLCabecMsg;
end;

function LoadcabecMsg(const FileName: WideString): IXMLCabecMsg;
begin
  Result := LoadXMLDocument(FileName).GetDocBinding('cabecMsg', TXMLCabecMsg, TargetNamespace) as IXMLCabecMsg;
end;

function NewcabecMsg: IXMLCabecMsg;
begin
  Result := NewXMLDocument.GetDocBinding('cabecMsg', TXMLCabecMsg, TargetNamespace) as IXMLCabecMsg;
end;

{ TXMLCabecMsg }

function TXMLCabecMsg.Get_Versao: WideString;
begin
  Result := AttributeNodes['versao'].Text;
end;

procedure TXMLCabecMsg.Set_Versao(Value: WideString);
begin
  SetAttribute('versao', Value);
end;

function TXMLCabecMsg.Get_VersaoDados: WideString;
begin
  Result := ChildNodes['versaoDados'].Text;
end;

procedure TXMLCabecMsg.Set_VersaoDados(Value: WideString);
begin
  ChildNodes['versaoDados'].NodeValue := Value;
end;

end.
