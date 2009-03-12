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
******************************************************************************}

{*****************************************************************************************}
{                                                                                         }
{                                    XML Data Binding                                     }
{                                                                                         }
{         Generated on: 22/07/2008 15:57:05                                               }
{       Generated from: PL_005a\retEnviNFe_v1.10.xsd                                      }
{                                                                                         }
{*****************************************************************************************}

unit ACBrNFe_retEnviNFe;

interface

uses xmldom, XMLDoc, XMLIntf;

type

{ Forward Decls }

  IXMLTRetEnviNFe = interface;
  IXMLInfRec = interface;

{ IXMLTRetEnviNFe }

  IXMLTRetEnviNFe = interface(IXMLNode)
    ['{2473FB7C-289C-4667-BD0D-57DDEEE4FF80}']
    { Property Accessors }
    function Get_Versao: WideString;
    function Get_TpAmb: WideString;
    function Get_VerAplic: WideString;
    function Get_CStat: WideString;
    function Get_XMotivo: WideString;
    function Get_CUF: WideString;
    function Get_InfRec: IXMLInfRec;
    procedure Set_Versao(Value: WideString);
    procedure Set_TpAmb(Value: WideString);
    procedure Set_VerAplic(Value: WideString);
    procedure Set_CStat(Value: WideString);
    procedure Set_XMotivo(Value: WideString);
    procedure Set_CUF(Value: WideString);
    { Methods & Properties }
    property Versao: WideString read Get_Versao write Set_Versao;
    property TpAmb: WideString read Get_TpAmb write Set_TpAmb;
    property VerAplic: WideString read Get_VerAplic write Set_VerAplic;
    property CStat: WideString read Get_CStat write Set_CStat;
    property XMotivo: WideString read Get_XMotivo write Set_XMotivo;
    property CUF: WideString read Get_CUF write Set_CUF;
    property InfRec: IXMLInfRec read Get_InfRec;
  end;

{ IXMLInfRec }

  IXMLInfRec = interface(IXMLNode)
    ['{517E0219-FB05-474B-BB54-64881D6370D6}']
    { Property Accessors }
    function Get_NRec: WideString;
    function Get_DhRecbto: WideString;
    function Get_TMed: WideString;
    procedure Set_NRec(Value: WideString);
    procedure Set_DhRecbto(Value: WideString);
    procedure Set_TMed(Value: WideString);
    { Methods & Properties }
    property NRec: WideString read Get_NRec write Set_NRec;
    property DhRecbto: WideString read Get_DhRecbto write Set_DhRecbto;
    property TMed: WideString read Get_TMed write Set_TMed;
  end;

{ Forward Decls }

  TXMLTRetEnviNFe = class;
  TXMLInfRec = class;

{ TXMLTRetEnviNFe }

  TXMLTRetEnviNFe = class(TXMLNode, IXMLTRetEnviNFe)
  protected
    { IXMLTRetEnviNFe }
    function Get_Versao: WideString;
    function Get_TpAmb: WideString;
    function Get_VerAplic: WideString;
    function Get_CStat: WideString;
    function Get_XMotivo: WideString;
    function Get_CUF: WideString;
    function Get_InfRec: IXMLInfRec;
    procedure Set_Versao(Value: WideString);
    procedure Set_TpAmb(Value: WideString);
    procedure Set_VerAplic(Value: WideString);
    procedure Set_CStat(Value: WideString);
    procedure Set_XMotivo(Value: WideString);
    procedure Set_CUF(Value: WideString);
  public
    procedure AfterConstruction; override;
  end;

{ TXMLInfRec }

  TXMLInfRec = class(TXMLNode, IXMLInfRec)
  protected
    { IXMLInfRec }
    function Get_NRec: WideString;
    function Get_DhRecbto: WideString;
    function Get_TMed: WideString;
    procedure Set_NRec(Value: WideString);
    procedure Set_DhRecbto(Value: WideString);
    procedure Set_TMed(Value: WideString);
  end;

{ Global Functions }

function GetretEnviNFe(Doc: IXMLDocument): IXMLTRetEnviNFe;
function LoadretEnviNFe(const FileName: WideString): IXMLTRetEnviNFe;
function NewretEnviNFe: IXMLTRetEnviNFe;

const
  TargetNamespace = 'http://www.portalfiscal.inf.br/nfe';

implementation

{ Global Functions }

function GetretEnviNFe(Doc: IXMLDocument): IXMLTRetEnviNFe;
begin
  Result := Doc.GetDocBinding('retEnviNFe', TXMLTRetEnviNFe, TargetNamespace) as IXMLTRetEnviNFe;
end;

function LoadretEnviNFe(const FileName: WideString): IXMLTRetEnviNFe;
begin
  Result := LoadXMLDocument(FileName).GetDocBinding('retEnviNFe', TXMLTRetEnviNFe, TargetNamespace) as IXMLTRetEnviNFe;
end;

function NewretEnviNFe: IXMLTRetEnviNFe;
begin
  Result := NewXMLDocument.GetDocBinding('retEnviNFe', TXMLTRetEnviNFe, TargetNamespace) as IXMLTRetEnviNFe;
end;

{ TXMLTRetEnviNFe }

procedure TXMLTRetEnviNFe.AfterConstruction;
begin
  RegisterChildNode('infRec', TXMLInfRec);
  inherited;
end;

function TXMLTRetEnviNFe.Get_Versao: WideString;
begin
  Result := AttributeNodes['versao'].Text;
end;

procedure TXMLTRetEnviNFe.Set_Versao(Value: WideString);
begin
  SetAttribute('versao', Value);
end;

function TXMLTRetEnviNFe.Get_TpAmb: WideString;
begin
  Result := ChildNodes['tpAmb'].Text;
end;

procedure TXMLTRetEnviNFe.Set_TpAmb(Value: WideString);
begin
  ChildNodes['tpAmb'].NodeValue := Value;
end;

function TXMLTRetEnviNFe.Get_VerAplic: WideString;
begin
  Result := ChildNodes['verAplic'].Text;
end;

procedure TXMLTRetEnviNFe.Set_VerAplic(Value: WideString);
begin
  ChildNodes['verAplic'].NodeValue := Value;
end;

function TXMLTRetEnviNFe.Get_CStat: WideString;
begin
  Result := ChildNodes['cStat'].Text;
end;

procedure TXMLTRetEnviNFe.Set_CStat(Value: WideString);
begin
  ChildNodes['cStat'].NodeValue := Value;
end;

function TXMLTRetEnviNFe.Get_XMotivo: WideString;
begin
  Result := ChildNodes['xMotivo'].Text;
end;

procedure TXMLTRetEnviNFe.Set_XMotivo(Value: WideString);
begin
  ChildNodes['xMotivo'].NodeValue := Value;
end;

function TXMLTRetEnviNFe.Get_CUF: WideString;
begin
  Result := ChildNodes['cUF'].Text;
end;

procedure TXMLTRetEnviNFe.Set_CUF(Value: WideString);
begin
  ChildNodes['cUF'].NodeValue := Value;
end;

function TXMLTRetEnviNFe.Get_InfRec: IXMLInfRec;
begin
  Result := ChildNodes['infRec'] as IXMLInfRec;
end;

{ TXMLInfRec }

function TXMLInfRec.Get_NRec: WideString;
begin
  Result := ChildNodes['nRec'].Text;
end;

procedure TXMLInfRec.Set_NRec(Value: WideString);
begin
  ChildNodes['nRec'].NodeValue := Value;
end;

function TXMLInfRec.Get_DhRecbto: WideString;
begin
  Result := ChildNodes['dhRecbto'].Text;
end;

procedure TXMLInfRec.Set_DhRecbto(Value: WideString);
begin
  ChildNodes['dhRecbto'].NodeValue := Value;
end;

function TXMLInfRec.Get_TMed: WideString;
begin
  Result := ChildNodes['tMed'].Text;
end;

procedure TXMLInfRec.Set_TMed(Value: WideString);
begin
  ChildNodes['tMed'].NodeValue := Value;
end;

end. 