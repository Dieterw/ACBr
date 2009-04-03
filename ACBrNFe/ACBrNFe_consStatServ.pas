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

{***********************************************************}
{                                                           }
{                     XML Data Binding                      }
{                                                           }
{         Generated on: 13/03/2009 11:25:03                 }
{       Generated from: .\PL_005c\consStatServ_v1.07.xsd   }
{                                                           }
{***********************************************************}

unit ACBrNFe_consStatServ;

interface

uses xmldom, XMLDoc, XMLIntf;

type

{ Forward Decls }

  IXMLTConsStatServ = interface;

{ IXMLTConsStatServ }

  IXMLTConsStatServ = interface(IXMLNode)
    ['{7F822030-00D9-4E0B-98E5-459A4E6D732D}']
    { Property Accessors }
    function Get_Versao: WideString;
    function Get_TpAmb: WideString;
    function Get_CUF: WideString;
    function Get_XServ: WideString;
    procedure Set_Versao(Value: WideString);
    procedure Set_TpAmb(Value: WideString);
    procedure Set_CUF(Value: WideString);
    procedure Set_XServ(Value: WideString);
    { Methods & Properties }
    property Versao: WideString read Get_Versao write Set_Versao;
    property TpAmb: WideString read Get_TpAmb write Set_TpAmb;
    property CUF: WideString read Get_CUF write Set_CUF;
    property XServ: WideString read Get_XServ write Set_XServ;
  end;

{ Forward Decls }

  TXMLTConsStatServ = class;

{ TXMLTConsStatServ }

  TXMLTConsStatServ = class(TXMLNode, IXMLTConsStatServ)
  protected
    { IXMLTConsStatServ }
    function Get_Versao: WideString;
    function Get_TpAmb: WideString;
    function Get_CUF: WideString;
    function Get_XServ: WideString;
    procedure Set_Versao(Value: WideString);
    procedure Set_TpAmb(Value: WideString);
    procedure Set_CUF(Value: WideString);
    procedure Set_XServ(Value: WideString);
  end;

{ Global Functions }

function GetconsStatServ(Doc: IXMLDocument): IXMLTConsStatServ;
function LoadconsStatServ(const FileName: WideString): IXMLTConsStatServ;
function NewconsStatServ: IXMLTConsStatServ;

const
  TargetNamespace = 'http://www.portalfiscal.inf.br/nfe';

implementation

{ Global Functions }

function GetconsStatServ(Doc: IXMLDocument): IXMLTConsStatServ;
begin
  Result := Doc.GetDocBinding('consStatServ', TXMLTConsStatServ, TargetNamespace) as IXMLTConsStatServ;
end;

function LoadconsStatServ(const FileName: WideString): IXMLTConsStatServ;
begin
  Result := LoadXMLDocument(FileName).GetDocBinding('consStatServ', TXMLTConsStatServ, TargetNamespace) as IXMLTConsStatServ;
end;

function NewconsStatServ: IXMLTConsStatServ;
begin
  Result := NewXMLDocument.GetDocBinding('consStatServ', TXMLTConsStatServ, TargetNamespace) as IXMLTConsStatServ;
end;

{ TXMLTConsStatServ }

function TXMLTConsStatServ.Get_Versao: WideString;
begin
  Result := AttributeNodes['versao'].Text;
end;

procedure TXMLTConsStatServ.Set_Versao(Value: WideString);
begin
  SetAttribute('versao', Value);
end;

function TXMLTConsStatServ.Get_TpAmb: WideString;
begin
  Result := ChildNodes['tpAmb'].Text;
end;

procedure TXMLTConsStatServ.Set_TpAmb(Value: WideString);
begin
  ChildNodes['tpAmb'].NodeValue := Value;
end;

function TXMLTConsStatServ.Get_CUF: WideString;
begin
  Result := ChildNodes['cUF'].Text;
end;

procedure TXMLTConsStatServ.Set_CUF(Value: WideString);
begin
  ChildNodes['cUF'].NodeValue := Value;
end;

function TXMLTConsStatServ.Get_XServ: WideString;
begin
  Result := ChildNodes['xServ'].Text;
end;

procedure TXMLTConsStatServ.Set_XServ(Value: WideString);
begin
  ChildNodes['xServ'].NodeValue := Value;
end;

end. 