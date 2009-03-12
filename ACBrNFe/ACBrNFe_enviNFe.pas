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

{**************************************************************************************}
{                                                                                      }
{                                   XML Data Binding                                   }
{                                                                                      }
{         Generated on: 28/07/2008 13:52:13                                            }
{       Generated from: PL_005a\enviNFe_v1.10.xsd                                      }
{                                                                                      }
{**************************************************************************************}

unit ACBrNFe_enviNFe;

interface

uses xmldom, XMLDoc, XMLIntf;

type

{ Forward Decls }

  IXMLTEnviNFe = interface;
  IXMLTNFe = interface;
  IXMLTNFeList = interface;
  IXMLInfNFe = interface;
  IXMLIde = interface;
  IXMLNFref = interface;
  IXMLNFrefList = interface;
  IXMLRefNF = interface;
  IXMLEmit = interface;
  IXMLTEndereco = interface;
  IXMLAvulsa = interface;
  IXMLDest = interface;
  IXMLTLocal = interface;
  IXMLDet = interface;
  IXMLDetList = interface;
  IXMLProd = interface;
  IXMLDI = interface;
  IXMLDIList = interface;
  IXMLAdi = interface;
  IXMLAdiList = interface;
  IXMLVeicProd = interface;
  IXMLMed = interface;
  IXMLMedList = interface;
  IXMLArma = interface;
  IXMLArmaList = interface;
  IXMLComb = interface;
  IXMLCIDE = interface;
  IXMLICMSComb = interface;
  IXMLICMSInter = interface;
  IXMLICMSCons = interface;
  IXMLImposto = interface;
  IXMLICMS = interface;
  IXMLICMS00 = interface;
  IXMLICMS10 = interface;
  IXMLICMS20 = interface;
  IXMLICMS30 = interface;
  IXMLICMS40 = interface;
  IXMLICMS51 = interface;
  IXMLICMS60 = interface;
  IXMLICMS70 = interface;
  IXMLICMS90 = interface;
  IXMLIPI = interface;
  IXMLIPITrib = interface;
  IXMLIPINT = interface;
  IXMLII = interface;
  IXMLPIS = interface;
  IXMLPISAliq = interface;
  IXMLPISQtde = interface;
  IXMLPISNT = interface;
  IXMLPISOutr = interface;
  IXMLPISST = interface;
  IXMLCOFINS = interface;
  IXMLCOFINSAliq = interface;
  IXMLCOFINSQtde = interface;
  IXMLCOFINSNT = interface;
  IXMLCOFINSOutr = interface;
  IXMLCOFINSST = interface;
  IXMLISSQN = interface;
  IXMLTotal = interface;
  IXMLICMSTot = interface;
  IXMLISSQNtot = interface;
  IXMLRetTrib = interface;
  IXMLTransp = interface;
  IXMLTransporta = interface;
  IXMLRetTransp = interface;
  IXMLTVeiculo = interface;
  IXMLTVeiculoList = interface;
  IXMLVol = interface;
  IXMLVolList = interface;
  IXMLLacres = interface;
  IXMLLacresList = interface;
  IXMLCobr = interface;
  IXMLFat = interface;
  IXMLDup = interface;
  IXMLDupList = interface;
  IXMLInfAdic = interface;
  IXMLObsCont = interface;
  IXMLObsFisco = interface;
  IXMLProcRef = interface;
  IXMLProcRefList = interface;
  IXMLExporta = interface;
  IXMLCompra = interface;
  IXMLSignatureType = interface;
  IXMLSignedInfoType = interface;
  IXMLCanonicalizationMethod = interface;
  IXMLSignatureMethod = interface;
  IXMLReferenceType = interface;
  IXMLTransformsType = interface;
  IXMLTransformType = interface;
  IXMLDigestMethod = interface;
  IXMLSignatureValueType = interface;
  IXMLKeyInfoType = interface;
  IXMLX509DataType = interface;

{ IXMLTEnviNFe }

  IXMLTEnviNFe = interface(IXMLNode)
    ['{A10EC340-74B1-42FC-B7F2-B11BD9D542FE}']
    { Property Accessors }
    function Get_Versao: WideString;
    function Get_IdLote: WideString;
    function Get_NFe: IXMLTNFeList;
    procedure Set_Versao(Value: WideString);
    procedure Set_IdLote(Value: WideString);
    { Methods & Properties }
    property Versao: WideString read Get_Versao write Set_Versao;
    property IdLote: WideString read Get_IdLote write Set_IdLote;
    property NFe: IXMLTNFeList read Get_NFe;
  end;

{ IXMLTNFe }

  IXMLTNFe = interface(IXMLNode)
    ['{E72B2ACF-098A-4F38-9F8A-2DA56D876122}']
    { Property Accessors }
    function Get_InfNFe: IXMLInfNFe;
    function Get_Signature: IXMLSignatureType;
    { Methods & Properties }
    property InfNFe: IXMLInfNFe read Get_InfNFe;
    property Signature: IXMLSignatureType read Get_Signature;
  end;

{ IXMLTNFeList }

  IXMLTNFeList = interface(IXMLNodeCollection)
    ['{5FD75B93-567D-4D6D-9798-1428090DDD6E}']
    { Methods & Properties }
    function Add: IXMLTNFe;
    function Insert(const Index: Integer): IXMLTNFe;
    function Get_Item(Index: Integer): IXMLTNFe;
    property Items[Index: Integer]: IXMLTNFe read Get_Item; default;
  end;

{ IXMLInfNFe }

  IXMLInfNFe = interface(IXMLNode)
    ['{F1773E52-5493-4601-A6BA-43341897BB2F}']
    { Property Accessors }
    function Get_Versao: WideString;
    function Get_Id: WideString;
    function Get_Ide: IXMLIde;
    function Get_Emit: IXMLEmit;
    function Get_Avulsa: IXMLAvulsa;
    function Get_Dest: IXMLDest;
    function Get_Retirada: IXMLTLocal;
    function Get_Entrega: IXMLTLocal;
    function Get_Det: IXMLDetList;
    function Get_Total: IXMLTotal;
    function Get_Transp: IXMLTransp;
    function Get_Cobr: IXMLCobr;
    function Get_InfAdic: IXMLInfAdic;
    function Get_Exporta: IXMLExporta;
    function Get_Compra: IXMLCompra;
    procedure Set_Versao(Value: WideString);
    procedure Set_Id(Value: WideString);
    { Methods & Properties }
    property Versao: WideString read Get_Versao write Set_Versao;
    property Id: WideString read Get_Id write Set_Id;
    property Ide: IXMLIde read Get_Ide;
    property Emit: IXMLEmit read Get_Emit;
    property Avulsa: IXMLAvulsa read Get_Avulsa;
    property Dest: IXMLDest read Get_Dest;
    property Retirada: IXMLTLocal read Get_Retirada;
    property Entrega: IXMLTLocal read Get_Entrega;
    property Det: IXMLDetList read Get_Det;
    property Total: IXMLTotal read Get_Total;
    property Transp: IXMLTransp read Get_Transp;
    property Cobr: IXMLCobr read Get_Cobr;
    property InfAdic: IXMLInfAdic read Get_InfAdic;
    property Exporta: IXMLExporta read Get_Exporta;
    property Compra: IXMLCompra read Get_Compra;
  end;

{ IXMLIde }

  IXMLIde = interface(IXMLNode)
    ['{7EA66055-35BF-434F-9902-8F972F4F7BDC}']
    { Property Accessors }
    function Get_CUF: WideString;
    function Get_CNF: WideString;
    function Get_NatOp: WideString;
    function Get_IndPag: WideString;
    function Get_Mod_: WideString;
    function Get_Serie: WideString;
    function Get_NNF: WideString;
    function Get_DEmi: WideString;
    function Get_DSaiEnt: WideString;
    function Get_TpNF: WideString;
    function Get_CMunFG: WideString;
    function Get_NFref: IXMLNFrefList;
    function Get_TpImp: WideString;
    function Get_TpEmis: WideString;
    function Get_CDV: WideString;
    function Get_TpAmb: WideString;
    function Get_FinNFe: WideString;
    function Get_ProcEmi: WideString;
    function Get_VerProc: WideString;
    procedure Set_CUF(Value: WideString);
    procedure Set_CNF(Value: WideString);
    procedure Set_NatOp(Value: WideString);
    procedure Set_IndPag(Value: WideString);
    procedure Set_Mod_(Value: WideString);
    procedure Set_Serie(Value: WideString);
    procedure Set_NNF(Value: WideString);
    procedure Set_DEmi(Value: WideString);
    procedure Set_DSaiEnt(Value: WideString);
    procedure Set_TpNF(Value: WideString);
    procedure Set_CMunFG(Value: WideString);
    procedure Set_TpImp(Value: WideString);
    procedure Set_TpEmis(Value: WideString);
    procedure Set_CDV(Value: WideString);
    procedure Set_TpAmb(Value: WideString);
    procedure Set_FinNFe(Value: WideString);
    procedure Set_ProcEmi(Value: WideString);
    procedure Set_VerProc(Value: WideString);
    { Methods & Properties }
    property CUF: WideString read Get_CUF write Set_CUF;
    property CNF: WideString read Get_CNF write Set_CNF;
    property NatOp: WideString read Get_NatOp write Set_NatOp;
    property IndPag: WideString read Get_IndPag write Set_IndPag;
    property Mod_: WideString read Get_Mod_ write Set_Mod_;
    property Serie: WideString read Get_Serie write Set_Serie;
    property NNF: WideString read Get_NNF write Set_NNF;
    property DEmi: WideString read Get_DEmi write Set_DEmi;
    property DSaiEnt: WideString read Get_DSaiEnt write Set_DSaiEnt;
    property TpNF: WideString read Get_TpNF write Set_TpNF;
    property CMunFG: WideString read Get_CMunFG write Set_CMunFG;
    property NFref: IXMLNFrefList read Get_NFref;
    property TpImp: WideString read Get_TpImp write Set_TpImp;
    property TpEmis: WideString read Get_TpEmis write Set_TpEmis;
    property CDV: WideString read Get_CDV write Set_CDV;
    property TpAmb: WideString read Get_TpAmb write Set_TpAmb;
    property FinNFe: WideString read Get_FinNFe write Set_FinNFe;
    property ProcEmi: WideString read Get_ProcEmi write Set_ProcEmi;
    property VerProc: WideString read Get_VerProc write Set_VerProc;
  end;

{ IXMLNFref }

  IXMLNFref = interface(IXMLNode)
    ['{33DC03C3-E4FF-4599-8746-C4DCF935FD69}']
    { Property Accessors }
    function Get_RefNFe: WideString;
    function Get_RefNF: IXMLRefNF;
    procedure Set_RefNFe(Value: WideString);
    { Methods & Properties }
    property RefNFe: WideString read Get_RefNFe write Set_RefNFe;
    property RefNF: IXMLRefNF read Get_RefNF;
  end;

{ IXMLNFrefList }

  IXMLNFrefList = interface(IXMLNodeCollection)
    ['{26696059-149E-4DFA-B46B-FD3C17B1CAD3}']
    { Methods & Properties }
    function Add: IXMLNFref;
    function Insert(const Index: Integer): IXMLNFref;
    function Get_Item(Index: Integer): IXMLNFref;
    property Items[Index: Integer]: IXMLNFref read Get_Item; default;
  end;

{ IXMLRefNF }

  IXMLRefNF = interface(IXMLNode)
    ['{AEF11B14-069B-42D7-A964-308883EBADBA}']
    { Property Accessors }
    function Get_CUF: WideString;
    function Get_AAMM: WideString;
    function Get_CNPJ: WideString;
    function Get_Mod_: WideString;
    function Get_Serie: WideString;
    function Get_NNF: WideString;
    procedure Set_CUF(Value: WideString);
    procedure Set_AAMM(Value: WideString);
    procedure Set_CNPJ(Value: WideString);
    procedure Set_Mod_(Value: WideString);
    procedure Set_Serie(Value: WideString);
    procedure Set_NNF(Value: WideString);
    { Methods & Properties }
    property CUF: WideString read Get_CUF write Set_CUF;
    property AAMM: WideString read Get_AAMM write Set_AAMM;
    property CNPJ: WideString read Get_CNPJ write Set_CNPJ;
    property Mod_: WideString read Get_Mod_ write Set_Mod_;
    property Serie: WideString read Get_Serie write Set_Serie;
    property NNF: WideString read Get_NNF write Set_NNF;
  end;

{ IXMLEmit }

  IXMLEmit = interface(IXMLNode)
    ['{EF2F3A95-B063-4A9E-81B9-71A30C90ACB4}']
    { Property Accessors }
    function Get_CNPJ: WideString;
    function Get_CPF: WideString;
    function Get_XNome: WideString;
    function Get_XFant: WideString;
    function Get_EnderEmit: IXMLTEndereco;
    function Get_IE: WideString;
    function Get_IEST: WideString;
    function Get_IM: WideString;
    function Get_CNAE: WideString;
    procedure Set_CNPJ(Value: WideString);
    procedure Set_CPF(Value: WideString);
    procedure Set_XNome(Value: WideString);
    procedure Set_XFant(Value: WideString);
    procedure Set_IE(Value: WideString);
    procedure Set_IEST(Value: WideString);
    procedure Set_IM(Value: WideString);
    procedure Set_CNAE(Value: WideString);
    { Methods & Properties }
    property CNPJ: WideString read Get_CNPJ write Set_CNPJ;
    property CPF: WideString read Get_CPF write Set_CPF;
    property XNome: WideString read Get_XNome write Set_XNome;
    property XFant: WideString read Get_XFant write Set_XFant;
    property EnderEmit: IXMLTEndereco read Get_EnderEmit;
    property IE: WideString read Get_IE write Set_IE;
    property IEST: WideString read Get_IEST write Set_IEST;
    property IM: WideString read Get_IM write Set_IM;
    property CNAE: WideString read Get_CNAE write Set_CNAE;
  end;

{ IXMLTEndereco }

  IXMLTEndereco = interface(IXMLNode)
    ['{F0CDE44D-9D45-449D-A448-FB746137E9B5}']
    { Property Accessors }
    function Get_XLgr: WideString;
    function Get_Nro: WideString;
    function Get_XCpl: WideString;
    function Get_XBairro: WideString;
    function Get_CMun: WideString;
    function Get_XMun: WideString;
    function Get_UF: WideString;
    function Get_CEP: WideString;
    function Get_CPais: WideString;
    function Get_XPais: WideString;
    function Get_Fone: WideString;
    procedure Set_XLgr(Value: WideString);
    procedure Set_Nro(Value: WideString);
    procedure Set_XCpl(Value: WideString);
    procedure Set_XBairro(Value: WideString);
    procedure Set_CMun(Value: WideString);
    procedure Set_XMun(Value: WideString);
    procedure Set_UF(Value: WideString);
    procedure Set_CEP(Value: WideString);
    procedure Set_CPais(Value: WideString);
    procedure Set_XPais(Value: WideString);
    procedure Set_Fone(Value: WideString);
    { Methods & Properties }
    property XLgr: WideString read Get_XLgr write Set_XLgr;
    property Nro: WideString read Get_Nro write Set_Nro;
    property XCpl: WideString read Get_XCpl write Set_XCpl;
    property XBairro: WideString read Get_XBairro write Set_XBairro;
    property CMun: WideString read Get_CMun write Set_CMun;
    property XMun: WideString read Get_XMun write Set_XMun;
    property UF: WideString read Get_UF write Set_UF;
    property CEP: WideString read Get_CEP write Set_CEP;
    property CPais: WideString read Get_CPais write Set_CPais;
    property XPais: WideString read Get_XPais write Set_XPais;
    property Fone: WideString read Get_Fone write Set_Fone;
  end;

{ IXMLAvulsa }

  IXMLAvulsa = interface(IXMLNode)
    ['{EDD9A1AC-2579-4828-9837-182936917A7B}']
    { Property Accessors }
    function Get_CNPJ: WideString;
    function Get_XOrgao: WideString;
    function Get_Matr: WideString;
    function Get_XAgente: WideString;
    function Get_Fone: WideString;
    function Get_UF: WideString;
    function Get_NDAR: WideString;
    function Get_DEmi: WideString;
    function Get_VDAR: WideString;
    function Get_RepEmi: WideString;
    function Get_DPag: WideString;
    procedure Set_CNPJ(Value: WideString);
    procedure Set_XOrgao(Value: WideString);
    procedure Set_Matr(Value: WideString);
    procedure Set_XAgente(Value: WideString);
    procedure Set_Fone(Value: WideString);
    procedure Set_UF(Value: WideString);
    procedure Set_NDAR(Value: WideString);
    procedure Set_DEmi(Value: WideString);
    procedure Set_VDAR(Value: WideString);
    procedure Set_RepEmi(Value: WideString);
    procedure Set_DPag(Value: WideString);
    { Methods & Properties }
    property CNPJ: WideString read Get_CNPJ write Set_CNPJ;
    property XOrgao: WideString read Get_XOrgao write Set_XOrgao;
    property Matr: WideString read Get_Matr write Set_Matr;
    property XAgente: WideString read Get_XAgente write Set_XAgente;
    property Fone: WideString read Get_Fone write Set_Fone;
    property UF: WideString read Get_UF write Set_UF;
    property NDAR: WideString read Get_NDAR write Set_NDAR;
    property DEmi: WideString read Get_DEmi write Set_DEmi;
    property VDAR: WideString read Get_VDAR write Set_VDAR;
    property RepEmi: WideString read Get_RepEmi write Set_RepEmi;
    property DPag: WideString read Get_DPag write Set_DPag;
  end;

{ IXMLDest }

  IXMLDest = interface(IXMLNode)
    ['{95CC708D-61AC-4B8E-B279-B2F2E6AE61AF}']
    { Property Accessors }
    function Get_CNPJ: WideString;
    function Get_CPF: WideString;
    function Get_XNome: WideString;
    function Get_EnderDest: IXMLTEndereco;
    function Get_IE: WideString;
    function Get_ISUF: WideString;
    procedure Set_CNPJ(Value: WideString);
    procedure Set_CPF(Value: WideString);
    procedure Set_XNome(Value: WideString);
    procedure Set_IE(Value: WideString);
    procedure Set_ISUF(Value: WideString);
    { Methods & Properties }
    property CNPJ: WideString read Get_CNPJ write Set_CNPJ;
    property CPF: WideString read Get_CPF write Set_CPF;
    property XNome: WideString read Get_XNome write Set_XNome;
    property EnderDest: IXMLTEndereco read Get_EnderDest;
    property IE: WideString read Get_IE write Set_IE;
    property ISUF: WideString read Get_ISUF write Set_ISUF;
  end;

{ IXMLTLocal }

  IXMLTLocal = interface(IXMLNode)
    ['{5A25AEF5-00AD-41BD-B40D-1CDE7F94CDB9}']
    { Property Accessors }
    function Get_CNPJ: WideString;
    function Get_XLgr: WideString;
    function Get_Nro: WideString;
    function Get_XCpl: WideString;
    function Get_XBairro: WideString;
    function Get_CMun: WideString;
    function Get_XMun: WideString;
    function Get_UF: WideString;
    procedure Set_CNPJ(Value: WideString);
    procedure Set_XLgr(Value: WideString);
    procedure Set_Nro(Value: WideString);
    procedure Set_XCpl(Value: WideString);
    procedure Set_XBairro(Value: WideString);
    procedure Set_CMun(Value: WideString);
    procedure Set_XMun(Value: WideString);
    procedure Set_UF(Value: WideString);
    { Methods & Properties }
    property CNPJ: WideString read Get_CNPJ write Set_CNPJ;
    property XLgr: WideString read Get_XLgr write Set_XLgr;
    property Nro: WideString read Get_Nro write Set_Nro;
    property XCpl: WideString read Get_XCpl write Set_XCpl;
    property XBairro: WideString read Get_XBairro write Set_XBairro;
    property CMun: WideString read Get_CMun write Set_CMun;
    property XMun: WideString read Get_XMun write Set_XMun;
    property UF: WideString read Get_UF write Set_UF;
  end;

{ IXMLDet }

  IXMLDet = interface(IXMLNode)
    ['{24ADD0C7-86E2-44E1-82E9-79D8F70FBA55}']
    { Property Accessors }
    function Get_NItem: WideString;
    function Get_Prod: IXMLProd;
    function Get_Imposto: IXMLImposto;
    function Get_InfAdProd: WideString;
    procedure Set_NItem(Value: WideString);
    procedure Set_InfAdProd(Value: WideString);
    { Methods & Properties }
    property NItem: WideString read Get_NItem write Set_NItem;
    property Prod: IXMLProd read Get_Prod;
    property Imposto: IXMLImposto read Get_Imposto;
    property InfAdProd: WideString read Get_InfAdProd write Set_InfAdProd;
  end;

{ IXMLDetList }

  IXMLDetList = interface(IXMLNodeCollection)
    ['{0C64321D-08C6-4EB8-98F3-1EA1E5BA280E}']
    { Methods & Properties }
    function Add: IXMLDet;
    function Insert(const Index: Integer): IXMLDet;
    function Get_Item(Index: Integer): IXMLDet;
    property Items[Index: Integer]: IXMLDet read Get_Item; default;
  end;

{ IXMLProd }

  IXMLProd = interface(IXMLNode)
    ['{6C975F7E-AF08-4637-920F-B13D24A79DCC}']
    { Property Accessors }
    function Get_CProd: WideString;
    function Get_CEAN: WideString;
    function Get_XProd: WideString;
    function Get_NCM: WideString;
    function Get_EXTIPI: WideString;
    function Get_Genero: WideString;
    function Get_CFOP: WideString;
    function Get_UCom: WideString;
    function Get_QCom: WideString;
    function Get_VUnCom: WideString;
    function Get_VProd: WideString;
    function Get_CEANTrib: WideString;
    function Get_UTrib: WideString;
    function Get_QTrib: WideString;
    function Get_VUnTrib: WideString;
    function Get_VFrete: WideString;
    function Get_VSeg: WideString;
    function Get_VDesc: WideString;
    function Get_DI: IXMLDIList;
    function Get_VeicProd: IXMLVeicProd;
    function Get_Med: IXMLMedList;
    function Get_Arma: IXMLArmaList;
    function Get_Comb: IXMLComb;
    procedure Set_CProd(Value: WideString);
    procedure Set_CEAN(Value: WideString);
    procedure Set_XProd(Value: WideString);
    procedure Set_NCM(Value: WideString);
    procedure Set_EXTIPI(Value: WideString);
    procedure Set_Genero(Value: WideString);
    procedure Set_CFOP(Value: WideString);
    procedure Set_UCom(Value: WideString);
    procedure Set_QCom(Value: WideString);
    procedure Set_VUnCom(Value: WideString);
    procedure Set_VProd(Value: WideString);
    procedure Set_CEANTrib(Value: WideString);
    procedure Set_UTrib(Value: WideString);
    procedure Set_QTrib(Value: WideString);
    procedure Set_VUnTrib(Value: WideString);
    procedure Set_VFrete(Value: WideString);
    procedure Set_VSeg(Value: WideString);
    procedure Set_VDesc(Value: WideString);
    { Methods & Properties }
    property CProd: WideString read Get_CProd write Set_CProd;
    property CEAN: WideString read Get_CEAN write Set_CEAN;
    property XProd: WideString read Get_XProd write Set_XProd;
    property NCM: WideString read Get_NCM write Set_NCM;
    property EXTIPI: WideString read Get_EXTIPI write Set_EXTIPI;
    property Genero: WideString read Get_Genero write Set_Genero;
    property CFOP: WideString read Get_CFOP write Set_CFOP;
    property UCom: WideString read Get_UCom write Set_UCom;
    property QCom: WideString read Get_QCom write Set_QCom;
    property VUnCom: WideString read Get_VUnCom write Set_VUnCom;
    property VProd: WideString read Get_VProd write Set_VProd;
    property CEANTrib: WideString read Get_CEANTrib write Set_CEANTrib;
    property UTrib: WideString read Get_UTrib write Set_UTrib;
    property QTrib: WideString read Get_QTrib write Set_QTrib;
    property VUnTrib: WideString read Get_VUnTrib write Set_VUnTrib;
    property VFrete: WideString read Get_VFrete write Set_VFrete;
    property VSeg: WideString read Get_VSeg write Set_VSeg;
    property VDesc: WideString read Get_VDesc write Set_VDesc;
    property DI: IXMLDIList read Get_DI;
    property VeicProd: IXMLVeicProd read Get_VeicProd;
    property Med: IXMLMedList read Get_Med;
    property Arma: IXMLArmaList read Get_Arma;
    property Comb: IXMLComb read Get_Comb;
  end;

{ IXMLDI }

  IXMLDI = interface(IXMLNode)
    ['{796C2E2D-97CA-4DF1-AA11-0439B8D338BC}']
    { Property Accessors }
    function Get_NDI: WideString;
    function Get_DDI: WideString;
    function Get_XLocDesemb: WideString;
    function Get_UFDesemb: WideString;
    function Get_DDesemb: WideString;
    function Get_CExportador: WideString;
    function Get_Adi: IXMLAdiList;
    procedure Set_NDI(Value: WideString);
    procedure Set_DDI(Value: WideString);
    procedure Set_XLocDesemb(Value: WideString);
    procedure Set_UFDesemb(Value: WideString);
    procedure Set_DDesemb(Value: WideString);
    procedure Set_CExportador(Value: WideString);
    { Methods & Properties }
    property NDI: WideString read Get_NDI write Set_NDI;
    property DDI: WideString read Get_DDI write Set_DDI;
    property XLocDesemb: WideString read Get_XLocDesemb write Set_XLocDesemb;
    property UFDesemb: WideString read Get_UFDesemb write Set_UFDesemb;
    property DDesemb: WideString read Get_DDesemb write Set_DDesemb;
    property CExportador: WideString read Get_CExportador write Set_CExportador;
    property Adi: IXMLAdiList read Get_Adi;
  end;

{ IXMLDIList }

  IXMLDIList = interface(IXMLNodeCollection)
    ['{893772E3-A9E8-40B8-A911-6F43B6A44A4C}']
    { Methods & Properties }
    function Add: IXMLDI;
    function Insert(const Index: Integer): IXMLDI;
    function Get_Item(Index: Integer): IXMLDI;
    property Items[Index: Integer]: IXMLDI read Get_Item; default;
  end;

{ IXMLAdi }

  IXMLAdi = interface(IXMLNode)
    ['{F3475D86-9CA7-4D50-9B34-F0D0DA1B9633}']
    { Property Accessors }
    function Get_NAdicao: WideString;
    function Get_NSeqAdic: WideString;
    function Get_CFabricante: WideString;
    function Get_VDescDI: WideString;
    procedure Set_NAdicao(Value: WideString);
    procedure Set_NSeqAdic(Value: WideString);
    procedure Set_CFabricante(Value: WideString);
    procedure Set_VDescDI(Value: WideString);
    { Methods & Properties }
    property NAdicao: WideString read Get_NAdicao write Set_NAdicao;
    property NSeqAdic: WideString read Get_NSeqAdic write Set_NSeqAdic;
    property CFabricante: WideString read Get_CFabricante write Set_CFabricante;
    property VDescDI: WideString read Get_VDescDI write Set_VDescDI;
  end;

{ IXMLAdiList }

  IXMLAdiList = interface(IXMLNodeCollection)
    ['{8E7BFCC5-35AC-4CE2-B95F-CDAFCA846990}']
    { Methods & Properties }
    function Add: IXMLAdi;
    function Insert(const Index: Integer): IXMLAdi;
    function Get_Item(Index: Integer): IXMLAdi;
    property Items[Index: Integer]: IXMLAdi read Get_Item; default;
  end;

{ IXMLVeicProd }

  IXMLVeicProd = interface(IXMLNode)
    ['{2FC27148-BE26-43E0-B805-A70296F5A437}']
    { Property Accessors }
    function Get_TpOp: WideString;
    function Get_Chassi: WideString;
    function Get_CCor: WideString;
    function Get_XCor: WideString;
    function Get_Pot: WideString;
    function Get_CM3: WideString;
    function Get_PesoL: WideString;
    function Get_PesoB: WideString;
    function Get_NSerie: WideString;
    function Get_TpComb: WideString;
    function Get_NMotor: WideString;
    function Get_CMKG: WideString;
    function Get_Dist: WideString;
    function Get_RENAVAM: WideString;
    function Get_AnoMod: WideString;
    function Get_AnoFab: WideString;
    function Get_TpPint: WideString;
    function Get_TpVeic: WideString;
    function Get_EspVeic: WideString;
    function Get_VIN: WideString;
    function Get_CondVeic: WideString;
    function Get_CMod: WideString;
    procedure Set_TpOp(Value: WideString);
    procedure Set_Chassi(Value: WideString);
    procedure Set_CCor(Value: WideString);
    procedure Set_XCor(Value: WideString);
    procedure Set_Pot(Value: WideString);
    procedure Set_CM3(Value: WideString);
    procedure Set_PesoL(Value: WideString);
    procedure Set_PesoB(Value: WideString);
    procedure Set_NSerie(Value: WideString);
    procedure Set_TpComb(Value: WideString);
    procedure Set_NMotor(Value: WideString);
    procedure Set_CMKG(Value: WideString);
    procedure Set_Dist(Value: WideString);
    procedure Set_RENAVAM(Value: WideString);
    procedure Set_AnoMod(Value: WideString);
    procedure Set_AnoFab(Value: WideString);
    procedure Set_TpPint(Value: WideString);
    procedure Set_TpVeic(Value: WideString);
    procedure Set_EspVeic(Value: WideString);
    procedure Set_VIN(Value: WideString);
    procedure Set_CondVeic(Value: WideString);
    procedure Set_CMod(Value: WideString);
    { Methods & Properties }
    property TpOp: WideString read Get_TpOp write Set_TpOp;
    property Chassi: WideString read Get_Chassi write Set_Chassi;
    property CCor: WideString read Get_CCor write Set_CCor;
    property XCor: WideString read Get_XCor write Set_XCor;
    property Pot: WideString read Get_Pot write Set_Pot;
    property CM3: WideString read Get_CM3 write Set_CM3;
    property PesoL: WideString read Get_PesoL write Set_PesoL;
    property PesoB: WideString read Get_PesoB write Set_PesoB;
    property NSerie: WideString read Get_NSerie write Set_NSerie;
    property TpComb: WideString read Get_TpComb write Set_TpComb;
    property NMotor: WideString read Get_NMotor write Set_NMotor;
    property CMKG: WideString read Get_CMKG write Set_CMKG;
    property Dist: WideString read Get_Dist write Set_Dist;
    property RENAVAM: WideString read Get_RENAVAM write Set_RENAVAM;
    property AnoMod: WideString read Get_AnoMod write Set_AnoMod;
    property AnoFab: WideString read Get_AnoFab write Set_AnoFab;
    property TpPint: WideString read Get_TpPint write Set_TpPint;
    property TpVeic: WideString read Get_TpVeic write Set_TpVeic;
    property EspVeic: WideString read Get_EspVeic write Set_EspVeic;
    property VIN: WideString read Get_VIN write Set_VIN;
    property CondVeic: WideString read Get_CondVeic write Set_CondVeic;
    property CMod: WideString read Get_CMod write Set_CMod;
  end;

{ IXMLMed }

  IXMLMed = interface(IXMLNode)
    ['{5995C176-A8FD-41C8-85A8-D10996A56F32}']
    { Property Accessors }
    function Get_NLote: WideString;
    function Get_QLote: WideString;
    function Get_DFab: WideString;
    function Get_DVal: WideString;
    function Get_VPMC: WideString;
    procedure Set_NLote(Value: WideString);
    procedure Set_QLote(Value: WideString);
    procedure Set_DFab(Value: WideString);
    procedure Set_DVal(Value: WideString);
    procedure Set_VPMC(Value: WideString);
    { Methods & Properties }
    property NLote: WideString read Get_NLote write Set_NLote;
    property QLote: WideString read Get_QLote write Set_QLote;
    property DFab: WideString read Get_DFab write Set_DFab;
    property DVal: WideString read Get_DVal write Set_DVal;
    property VPMC: WideString read Get_VPMC write Set_VPMC;
  end;

{ IXMLMedList }

  IXMLMedList = interface(IXMLNodeCollection)
    ['{8CC348D9-9B27-4742-9A14-65E9DCA1918C}']
    { Methods & Properties }
    function Add: IXMLMed;
    function Insert(const Index: Integer): IXMLMed;
    function Get_Item(Index: Integer): IXMLMed;
    property Items[Index: Integer]: IXMLMed read Get_Item; default;
  end;

{ IXMLArma }

  IXMLArma = interface(IXMLNode)
    ['{69D1329C-83EE-4F69-8580-722CDE22F7D1}']
    { Property Accessors }
    function Get_TpArma: WideString;
    function Get_NSerie: WideString;
    function Get_NCano: WideString;
    function Get_Descr: WideString;
    procedure Set_TpArma(Value: WideString);
    procedure Set_NSerie(Value: WideString);
    procedure Set_NCano(Value: WideString);
    procedure Set_Descr(Value: WideString);
    { Methods & Properties }
    property TpArma: WideString read Get_TpArma write Set_TpArma;
    property NSerie: WideString read Get_NSerie write Set_NSerie;
    property NCano: WideString read Get_NCano write Set_NCano;
    property Descr: WideString read Get_Descr write Set_Descr;
  end;

{ IXMLArmaList }

  IXMLArmaList = interface(IXMLNodeCollection)
    ['{7C7A1631-2AE2-4C98-A0EA-7E89FA4F9781}']
    { Methods & Properties }
    function Add: IXMLArma;
    function Insert(const Index: Integer): IXMLArma;
    function Get_Item(Index: Integer): IXMLArma;
    property Items[Index: Integer]: IXMLArma read Get_Item; default;
  end;

{ IXMLComb }

  IXMLComb = interface(IXMLNode)
    ['{EC9E690D-9E98-429C-806B-3FDE99EC00CD}']
    { Property Accessors }
    function Get_CProdANP: WideString;
    function Get_CODIF: WideString;
    function Get_QTemp: WideString;
    function Get_CIDE: IXMLCIDE;
    function Get_ICMSComb: IXMLICMSComb;
    function Get_ICMSInter: IXMLICMSInter;
    function Get_ICMSCons: IXMLICMSCons;
    procedure Set_CProdANP(Value: WideString);
    procedure Set_CODIF(Value: WideString);
    procedure Set_QTemp(Value: WideString);
    { Methods & Properties }
    property CProdANP: WideString read Get_CProdANP write Set_CProdANP;
    property CODIF: WideString read Get_CODIF write Set_CODIF;
    property QTemp: WideString read Get_QTemp write Set_QTemp;
    property CIDE: IXMLCIDE read Get_CIDE;
    property ICMSComb: IXMLICMSComb read Get_ICMSComb;
    property ICMSInter: IXMLICMSInter read Get_ICMSInter;
    property ICMSCons: IXMLICMSCons read Get_ICMSCons;
  end;

{ IXMLCIDE }

  IXMLCIDE = interface(IXMLNode)
    ['{9E26E6B6-D889-4875-9F17-3BC7006634EC}']
    { Property Accessors }
    function Get_QBCProd: WideString;
    function Get_VAliqProd: WideString;
    function Get_VCIDE: WideString;
    procedure Set_QBCProd(Value: WideString);
    procedure Set_VAliqProd(Value: WideString);
    procedure Set_VCIDE(Value: WideString);
    { Methods & Properties }
    property QBCProd: WideString read Get_QBCProd write Set_QBCProd;
    property VAliqProd: WideString read Get_VAliqProd write Set_VAliqProd;
    property VCIDE: WideString read Get_VCIDE write Set_VCIDE;
  end;

{ IXMLICMSComb }

  IXMLICMSComb = interface(IXMLNode)
    ['{78443EE0-5B1A-40E4-9E94-6C7DB2102E6A}']
    { Property Accessors }
    function Get_VBCICMS: WideString;
    function Get_VICMS: WideString;
    function Get_VBCICMSST: WideString;
    function Get_VICMSST: WideString;
    procedure Set_VBCICMS(Value: WideString);
    procedure Set_VICMS(Value: WideString);
    procedure Set_VBCICMSST(Value: WideString);
    procedure Set_VICMSST(Value: WideString);
    { Methods & Properties }
    property VBCICMS: WideString read Get_VBCICMS write Set_VBCICMS;
    property VICMS: WideString read Get_VICMS write Set_VICMS;
    property VBCICMSST: WideString read Get_VBCICMSST write Set_VBCICMSST;
    property VICMSST: WideString read Get_VICMSST write Set_VICMSST;
  end;

{ IXMLICMSInter }

  IXMLICMSInter = interface(IXMLNode)
    ['{29026A2B-5D73-41E8-86DD-98CB4750E505}']
    { Property Accessors }
    function Get_VBCICMSSTDest: WideString;
    function Get_VICMSSTDest: WideString;
    procedure Set_VBCICMSSTDest(Value: WideString);
    procedure Set_VICMSSTDest(Value: WideString);
    { Methods & Properties }
    property VBCICMSSTDest: WideString read Get_VBCICMSSTDest write Set_VBCICMSSTDest;
    property VICMSSTDest: WideString read Get_VICMSSTDest write Set_VICMSSTDest;
  end;

{ IXMLICMSCons }

  IXMLICMSCons = interface(IXMLNode)
    ['{CBDFA580-456B-465F-96AE-E2D9DF70C143}']
    { Property Accessors }
    function Get_VBCICMSSTCons: WideString;
    function Get_VICMSSTCons: WideString;
    function Get_UFCons: WideString;
    procedure Set_VBCICMSSTCons(Value: WideString);
    procedure Set_VICMSSTCons(Value: WideString);
    procedure Set_UFCons(Value: WideString);
    { Methods & Properties }
    property VBCICMSSTCons: WideString read Get_VBCICMSSTCons write Set_VBCICMSSTCons;
    property VICMSSTCons: WideString read Get_VICMSSTCons write Set_VICMSSTCons;
    property UFCons: WideString read Get_UFCons write Set_UFCons;
  end;

{ IXMLImposto }

  IXMLImposto = interface(IXMLNode)
    ['{BC452AE8-194D-46D5-9272-16A38F129810}']
    { Property Accessors }
    function Get_ICMS: IXMLICMS;
    function Get_IPI: IXMLIPI;
    function Get_II: IXMLII;
    function Get_PIS: IXMLPIS;
    function Get_PISST: IXMLPISST;
    function Get_COFINS: IXMLCOFINS;
    function Get_COFINSST: IXMLCOFINSST;
    function Get_ISSQN: IXMLISSQN;
    { Methods & Properties }
    property ICMS: IXMLICMS read Get_ICMS;
    property IPI: IXMLIPI read Get_IPI;
    property II: IXMLII read Get_II;
    property PIS: IXMLPIS read Get_PIS;
    property PISST: IXMLPISST read Get_PISST;
    property COFINS: IXMLCOFINS read Get_COFINS;
    property COFINSST: IXMLCOFINSST read Get_COFINSST;
    property ISSQN: IXMLISSQN read Get_ISSQN;
  end;

{ IXMLICMS }

  IXMLICMS = interface(IXMLNode)
    ['{32D5D549-D6E9-46EF-80FC-808C3E60E132}']
    { Property Accessors }
    function Get_ICMS00: IXMLICMS00;
    function Get_ICMS10: IXMLICMS10;
    function Get_ICMS20: IXMLICMS20;
    function Get_ICMS30: IXMLICMS30;
    function Get_ICMS40: IXMLICMS40;
    function Get_ICMS51: IXMLICMS51;
    function Get_ICMS60: IXMLICMS60;
    function Get_ICMS70: IXMLICMS70;
    function Get_ICMS90: IXMLICMS90;
    { Methods & Properties }
    property ICMS00: IXMLICMS00 read Get_ICMS00;
    property ICMS10: IXMLICMS10 read Get_ICMS10;
    property ICMS20: IXMLICMS20 read Get_ICMS20;
    property ICMS30: IXMLICMS30 read Get_ICMS30;
    property ICMS40: IXMLICMS40 read Get_ICMS40;
    property ICMS51: IXMLICMS51 read Get_ICMS51;
    property ICMS60: IXMLICMS60 read Get_ICMS60;
    property ICMS70: IXMLICMS70 read Get_ICMS70;
    property ICMS90: IXMLICMS90 read Get_ICMS90;
  end;

{ IXMLICMS00 }

  IXMLICMS00 = interface(IXMLNode)
    ['{78C69608-9544-4BC0-8AC7-467160A1F579}']
    { Property Accessors }
    function Get_Orig: WideString;
    function Get_CST: WideString;
    function Get_ModBC: WideString;
    function Get_VBC: WideString;
    function Get_PICMS: WideString;
    function Get_VICMS: WideString;
    procedure Set_Orig(Value: WideString);
    procedure Set_CST(Value: WideString);
    procedure Set_ModBC(Value: WideString);
    procedure Set_VBC(Value: WideString);
    procedure Set_PICMS(Value: WideString);
    procedure Set_VICMS(Value: WideString);
    { Methods & Properties }
    property Orig: WideString read Get_Orig write Set_Orig;
    property CST: WideString read Get_CST write Set_CST;
    property ModBC: WideString read Get_ModBC write Set_ModBC;
    property VBC: WideString read Get_VBC write Set_VBC;
    property PICMS: WideString read Get_PICMS write Set_PICMS;
    property VICMS: WideString read Get_VICMS write Set_VICMS;
  end;

{ IXMLICMS10 }

  IXMLICMS10 = interface(IXMLNode)
    ['{ADADDDCE-5370-4A21-878A-DC73BA8C80E0}']
    { Property Accessors }
    function Get_Orig: WideString;
    function Get_CST: WideString;
    function Get_ModBC: WideString;
    function Get_VBC: WideString;
    function Get_PICMS: WideString;
    function Get_VICMS: WideString;
    function Get_ModBCST: WideString;
    function Get_PMVAST: WideString;
    function Get_PRedBCST: WideString;
    function Get_VBCST: WideString;
    function Get_PICMSST: WideString;
    function Get_VICMSST: WideString;
    procedure Set_Orig(Value: WideString);
    procedure Set_CST(Value: WideString);
    procedure Set_ModBC(Value: WideString);
    procedure Set_VBC(Value: WideString);
    procedure Set_PICMS(Value: WideString);
    procedure Set_VICMS(Value: WideString);
    procedure Set_ModBCST(Value: WideString);
    procedure Set_PMVAST(Value: WideString);
    procedure Set_PRedBCST(Value: WideString);
    procedure Set_VBCST(Value: WideString);
    procedure Set_PICMSST(Value: WideString);
    procedure Set_VICMSST(Value: WideString);
    { Methods & Properties }
    property Orig: WideString read Get_Orig write Set_Orig;
    property CST: WideString read Get_CST write Set_CST;
    property ModBC: WideString read Get_ModBC write Set_ModBC;
    property VBC: WideString read Get_VBC write Set_VBC;
    property PICMS: WideString read Get_PICMS write Set_PICMS;
    property VICMS: WideString read Get_VICMS write Set_VICMS;
    property ModBCST: WideString read Get_ModBCST write Set_ModBCST;
    property PMVAST: WideString read Get_PMVAST write Set_PMVAST;
    property PRedBCST: WideString read Get_PRedBCST write Set_PRedBCST;
    property VBCST: WideString read Get_VBCST write Set_VBCST;
    property PICMSST: WideString read Get_PICMSST write Set_PICMSST;
    property VICMSST: WideString read Get_VICMSST write Set_VICMSST;
  end;

{ IXMLICMS20 }

  IXMLICMS20 = interface(IXMLNode)
    ['{DE3B4060-FE1D-4B4A-A143-4977FF59980D}']
    { Property Accessors }
    function Get_Orig: WideString;
    function Get_CST: WideString;
    function Get_ModBC: WideString;
    function Get_PRedBC: WideString;
    function Get_VBC: WideString;
    function Get_PICMS: WideString;
    function Get_VICMS: WideString;
    procedure Set_Orig(Value: WideString);
    procedure Set_CST(Value: WideString);
    procedure Set_ModBC(Value: WideString);
    procedure Set_PRedBC(Value: WideString);
    procedure Set_VBC(Value: WideString);
    procedure Set_PICMS(Value: WideString);
    procedure Set_VICMS(Value: WideString);
    { Methods & Properties }
    property Orig: WideString read Get_Orig write Set_Orig;
    property CST: WideString read Get_CST write Set_CST;
    property ModBC: WideString read Get_ModBC write Set_ModBC;
    property PRedBC: WideString read Get_PRedBC write Set_PRedBC;
    property VBC: WideString read Get_VBC write Set_VBC;
    property PICMS: WideString read Get_PICMS write Set_PICMS;
    property VICMS: WideString read Get_VICMS write Set_VICMS;
  end;

{ IXMLICMS30 }

  IXMLICMS30 = interface(IXMLNode)
    ['{C41CF46C-33E1-4A00-8900-DC423A75BD42}']
    { Property Accessors }
    function Get_Orig: WideString;
    function Get_CST: WideString;
    function Get_ModBCST: WideString;
    function Get_PMVAST: WideString;
    function Get_PRedBCST: WideString;
    function Get_VBCST: WideString;
    function Get_PICMSST: WideString;
    function Get_VICMSST: WideString;
    procedure Set_Orig(Value: WideString);
    procedure Set_CST(Value: WideString);
    procedure Set_ModBCST(Value: WideString);
    procedure Set_PMVAST(Value: WideString);
    procedure Set_PRedBCST(Value: WideString);
    procedure Set_VBCST(Value: WideString);
    procedure Set_PICMSST(Value: WideString);
    procedure Set_VICMSST(Value: WideString);
    { Methods & Properties }
    property Orig: WideString read Get_Orig write Set_Orig;
    property CST: WideString read Get_CST write Set_CST;
    property ModBCST: WideString read Get_ModBCST write Set_ModBCST;
    property PMVAST: WideString read Get_PMVAST write Set_PMVAST;
    property PRedBCST: WideString read Get_PRedBCST write Set_PRedBCST;
    property VBCST: WideString read Get_VBCST write Set_VBCST;
    property PICMSST: WideString read Get_PICMSST write Set_PICMSST;
    property VICMSST: WideString read Get_VICMSST write Set_VICMSST;
  end;

{ IXMLICMS40 }

  IXMLICMS40 = interface(IXMLNode)
    ['{F059CD1C-9FC3-4FC9-96F9-FE9680503CC3}']
    { Property Accessors }
    function Get_Orig: WideString;
    function Get_CST: WideString;
    procedure Set_Orig(Value: WideString);
    procedure Set_CST(Value: WideString);
    { Methods & Properties }
    property Orig: WideString read Get_Orig write Set_Orig;
    property CST: WideString read Get_CST write Set_CST;
  end;

{ IXMLICMS51 }

  IXMLICMS51 = interface(IXMLNode)
    ['{3E80337A-72F4-4239-8A7C-71A299EC3963}']
    { Property Accessors }
    function Get_Orig: WideString;
    function Get_CST: WideString;
    function Get_ModBC: WideString;
    function Get_PRedBC: WideString;
    function Get_VBC: WideString;
    function Get_PICMS: WideString;
    function Get_VICMS: WideString;
    procedure Set_Orig(Value: WideString);
    procedure Set_CST(Value: WideString);
    procedure Set_ModBC(Value: WideString);
    procedure Set_PRedBC(Value: WideString);
    procedure Set_VBC(Value: WideString);
    procedure Set_PICMS(Value: WideString);
    procedure Set_VICMS(Value: WideString);
    { Methods & Properties }
    property Orig: WideString read Get_Orig write Set_Orig;
    property CST: WideString read Get_CST write Set_CST;
    property ModBC: WideString read Get_ModBC write Set_ModBC;
    property PRedBC: WideString read Get_PRedBC write Set_PRedBC;
    property VBC: WideString read Get_VBC write Set_VBC;
    property PICMS: WideString read Get_PICMS write Set_PICMS;
    property VICMS: WideString read Get_VICMS write Set_VICMS;
  end;

{ IXMLICMS60 }

  IXMLICMS60 = interface(IXMLNode)
    ['{0605ED94-5A98-420A-93ED-C2F27AB484B2}']
    { Property Accessors }
    function Get_Orig: WideString;
    function Get_CST: WideString;
    function Get_VBCST: WideString;
    function Get_VICMSST: WideString;
    procedure Set_Orig(Value: WideString);
    procedure Set_CST(Value: WideString);
    procedure Set_VBCST(Value: WideString);
    procedure Set_VICMSST(Value: WideString);
    { Methods & Properties }
    property Orig: WideString read Get_Orig write Set_Orig;
    property CST: WideString read Get_CST write Set_CST;
    property VBCST: WideString read Get_VBCST write Set_VBCST;
    property VICMSST: WideString read Get_VICMSST write Set_VICMSST;
  end;

{ IXMLICMS70 }

  IXMLICMS70 = interface(IXMLNode)
    ['{57128D3C-A767-494E-8E36-604CF2564D3A}']
    { Property Accessors }
    function Get_Orig: WideString;
    function Get_CST: WideString;
    function Get_ModBC: WideString;
    function Get_PRedBC: WideString;
    function Get_VBC: WideString;
    function Get_PICMS: WideString;
    function Get_VICMS: WideString;
    function Get_ModBCST: WideString;
    function Get_PMVAST: WideString;
    function Get_PRedBCST: WideString;
    function Get_VBCST: WideString;
    function Get_PICMSST: WideString;
    function Get_VICMSST: WideString;
    procedure Set_Orig(Value: WideString);
    procedure Set_CST(Value: WideString);
    procedure Set_ModBC(Value: WideString);
    procedure Set_PRedBC(Value: WideString);
    procedure Set_VBC(Value: WideString);
    procedure Set_PICMS(Value: WideString);
    procedure Set_VICMS(Value: WideString);
    procedure Set_ModBCST(Value: WideString);
    procedure Set_PMVAST(Value: WideString);
    procedure Set_PRedBCST(Value: WideString);
    procedure Set_VBCST(Value: WideString);
    procedure Set_PICMSST(Value: WideString);
    procedure Set_VICMSST(Value: WideString);
    { Methods & Properties }
    property Orig: WideString read Get_Orig write Set_Orig;
    property CST: WideString read Get_CST write Set_CST;
    property ModBC: WideString read Get_ModBC write Set_ModBC;
    property PRedBC: WideString read Get_PRedBC write Set_PRedBC;
    property VBC: WideString read Get_VBC write Set_VBC;
    property PICMS: WideString read Get_PICMS write Set_PICMS;
    property VICMS: WideString read Get_VICMS write Set_VICMS;
    property ModBCST: WideString read Get_ModBCST write Set_ModBCST;
    property PMVAST: WideString read Get_PMVAST write Set_PMVAST;
    property PRedBCST: WideString read Get_PRedBCST write Set_PRedBCST;
    property VBCST: WideString read Get_VBCST write Set_VBCST;
    property PICMSST: WideString read Get_PICMSST write Set_PICMSST;
    property VICMSST: WideString read Get_VICMSST write Set_VICMSST;
  end;

{ IXMLICMS90 }

  IXMLICMS90 = interface(IXMLNode)
    ['{87AE98F3-AA6A-4CC2-AFB1-B115E998A599}']
    { Property Accessors }
    function Get_Orig: WideString;
    function Get_CST: WideString;
    function Get_ModBC: WideString;
    function Get_VBC: WideString;
    function Get_PRedBC: WideString;
    function Get_PICMS: WideString;
    function Get_VICMS: WideString;
    function Get_ModBCST: WideString;
    function Get_PMVAST: WideString;
    function Get_PRedBCST: WideString;
    function Get_VBCST: WideString;
    function Get_PICMSST: WideString;
    function Get_VICMSST: WideString;
    procedure Set_Orig(Value: WideString);
    procedure Set_CST(Value: WideString);
    procedure Set_ModBC(Value: WideString);
    procedure Set_VBC(Value: WideString);
    procedure Set_PRedBC(Value: WideString);
    procedure Set_PICMS(Value: WideString);
    procedure Set_VICMS(Value: WideString);
    procedure Set_ModBCST(Value: WideString);
    procedure Set_PMVAST(Value: WideString);
    procedure Set_PRedBCST(Value: WideString);
    procedure Set_VBCST(Value: WideString);
    procedure Set_PICMSST(Value: WideString);
    procedure Set_VICMSST(Value: WideString);
    { Methods & Properties }
    property Orig: WideString read Get_Orig write Set_Orig;
    property CST: WideString read Get_CST write Set_CST;
    property ModBC: WideString read Get_ModBC write Set_ModBC;
    property VBC: WideString read Get_VBC write Set_VBC;
    property PRedBC: WideString read Get_PRedBC write Set_PRedBC;
    property PICMS: WideString read Get_PICMS write Set_PICMS;
    property VICMS: WideString read Get_VICMS write Set_VICMS;
    property ModBCST: WideString read Get_ModBCST write Set_ModBCST;
    property PMVAST: WideString read Get_PMVAST write Set_PMVAST;
    property PRedBCST: WideString read Get_PRedBCST write Set_PRedBCST;
    property VBCST: WideString read Get_VBCST write Set_VBCST;
    property PICMSST: WideString read Get_PICMSST write Set_PICMSST;
    property VICMSST: WideString read Get_VICMSST write Set_VICMSST;
  end;

{ IXMLIPI }

  IXMLIPI = interface(IXMLNode)
    ['{C8C24E6B-3518-4127-BB83-4739A64931D7}']
    { Property Accessors }
    function Get_ClEnq: WideString;
    function Get_CNPJProd: WideString;
    function Get_CSelo: WideString;
    function Get_QSelo: WideString;
    function Get_CEnq: WideString;
    function Get_IPITrib: IXMLIPITrib;
    function Get_IPINT: IXMLIPINT;
    procedure Set_ClEnq(Value: WideString);
    procedure Set_CNPJProd(Value: WideString);
    procedure Set_CSelo(Value: WideString);
    procedure Set_QSelo(Value: WideString);
    procedure Set_CEnq(Value: WideString);
    { Methods & Properties }
    property ClEnq: WideString read Get_ClEnq write Set_ClEnq;
    property CNPJProd: WideString read Get_CNPJProd write Set_CNPJProd;
    property CSelo: WideString read Get_CSelo write Set_CSelo;
    property QSelo: WideString read Get_QSelo write Set_QSelo;
    property CEnq: WideString read Get_CEnq write Set_CEnq;
    property IPITrib: IXMLIPITrib read Get_IPITrib;
    property IPINT: IXMLIPINT read Get_IPINT;
  end;

{ IXMLIPITrib }

  IXMLIPITrib = interface(IXMLNode)
    ['{D8CFCB20-681D-4D8E-9141-C2D443A3EA4F}']
    { Property Accessors }
    function Get_CST: WideString;
    function Get_VBC: WideString;
    function Get_PIPI: WideString;
    function Get_QUnid: WideString;
    function Get_VUnid: WideString;
    function Get_VIPI: WideString;
    procedure Set_CST(Value: WideString);
    procedure Set_VBC(Value: WideString);
    procedure Set_PIPI(Value: WideString);
    procedure Set_QUnid(Value: WideString);
    procedure Set_VUnid(Value: WideString);
    procedure Set_VIPI(Value: WideString);
    { Methods & Properties }
    property CST: WideString read Get_CST write Set_CST;
    property VBC: WideString read Get_VBC write Set_VBC;
    property PIPI: WideString read Get_PIPI write Set_PIPI;
    property QUnid: WideString read Get_QUnid write Set_QUnid;
    property VUnid: WideString read Get_VUnid write Set_VUnid;
    property VIPI: WideString read Get_VIPI write Set_VIPI;
  end;

{ IXMLIPINT }

  IXMLIPINT = interface(IXMLNode)
    ['{3249950B-874A-4404-887E-590D7676C902}']
    { Property Accessors }
    function Get_CST: WideString;
    procedure Set_CST(Value: WideString);
    { Methods & Properties }
    property CST: WideString read Get_CST write Set_CST;
  end;

{ IXMLII }

  IXMLII = interface(IXMLNode)
    ['{35B917D4-A631-4159-87B1-925854986FCD}']
    { Property Accessors }
    function Get_VBC: WideString;
    function Get_VDespAdu: WideString;
    function Get_VII: WideString;
    function Get_VIOF: WideString;
    procedure Set_VBC(Value: WideString);
    procedure Set_VDespAdu(Value: WideString);
    procedure Set_VII(Value: WideString);
    procedure Set_VIOF(Value: WideString);
    { Methods & Properties }
    property VBC: WideString read Get_VBC write Set_VBC;
    property VDespAdu: WideString read Get_VDespAdu write Set_VDespAdu;
    property VII: WideString read Get_VII write Set_VII;
    property VIOF: WideString read Get_VIOF write Set_VIOF;
  end;

{ IXMLPIS }

  IXMLPIS = interface(IXMLNode)
    ['{AB7740D6-ED79-4B87-ABDF-112BDC6CE358}']
    { Property Accessors }
    function Get_PISAliq: IXMLPISAliq;
    function Get_PISQtde: IXMLPISQtde;
    function Get_PISNT: IXMLPISNT;
    function Get_PISOutr: IXMLPISOutr;
    { Methods & Properties }
    property PISAliq: IXMLPISAliq read Get_PISAliq;
    property PISQtde: IXMLPISQtde read Get_PISQtde;
    property PISNT: IXMLPISNT read Get_PISNT;
    property PISOutr: IXMLPISOutr read Get_PISOutr;
  end;

{ IXMLPISAliq }

  IXMLPISAliq = interface(IXMLNode)
    ['{95348C9F-D177-485E-B74C-03B04A355653}']
    { Property Accessors }
    function Get_CST: WideString;
    function Get_VBC: WideString;
    function Get_PPIS: WideString;
    function Get_VPIS: WideString;
    procedure Set_CST(Value: WideString);
    procedure Set_VBC(Value: WideString);
    procedure Set_PPIS(Value: WideString);
    procedure Set_VPIS(Value: WideString);
    { Methods & Properties }
    property CST: WideString read Get_CST write Set_CST;
    property VBC: WideString read Get_VBC write Set_VBC;
    property PPIS: WideString read Get_PPIS write Set_PPIS;
    property VPIS: WideString read Get_VPIS write Set_VPIS;
  end;

{ IXMLPISQtde }

  IXMLPISQtde = interface(IXMLNode)
    ['{D1CD7A71-67BF-4ABD-9EDC-8995BE400131}']
    { Property Accessors }
    function Get_CST: WideString;
    function Get_QBCProd: WideString;
    function Get_VAliqProd: WideString;
    function Get_VPIS: WideString;
    procedure Set_CST(Value: WideString);
    procedure Set_QBCProd(Value: WideString);
    procedure Set_VAliqProd(Value: WideString);
    procedure Set_VPIS(Value: WideString);
    { Methods & Properties }
    property CST: WideString read Get_CST write Set_CST;
    property QBCProd: WideString read Get_QBCProd write Set_QBCProd;
    property VAliqProd: WideString read Get_VAliqProd write Set_VAliqProd;
    property VPIS: WideString read Get_VPIS write Set_VPIS;
  end;

{ IXMLPISNT }

  IXMLPISNT = interface(IXMLNode)
    ['{71DE2886-0DCD-447F-AF69-5E6AF3314ADD}']
    { Property Accessors }
    function Get_CST: WideString;
    procedure Set_CST(Value: WideString);
    { Methods & Properties }
    property CST: WideString read Get_CST write Set_CST;
  end;

{ IXMLPISOutr }

  IXMLPISOutr = interface(IXMLNode)
    ['{1354493D-1A27-4C45-8BE7-0C82C5471CFD}']
    { Property Accessors }
    function Get_CST: WideString;
    function Get_VBC: WideString;
    function Get_PPIS: WideString;
    function Get_QBCProd: WideString;
    function Get_VAliqProd: WideString;
    function Get_VPIS: WideString;
    procedure Set_CST(Value: WideString);
    procedure Set_VBC(Value: WideString);
    procedure Set_PPIS(Value: WideString);
    procedure Set_QBCProd(Value: WideString);
    procedure Set_VAliqProd(Value: WideString);
    procedure Set_VPIS(Value: WideString);
    { Methods & Properties }
    property CST: WideString read Get_CST write Set_CST;
    property VBC: WideString read Get_VBC write Set_VBC;
    property PPIS: WideString read Get_PPIS write Set_PPIS;
    property QBCProd: WideString read Get_QBCProd write Set_QBCProd;
    property VAliqProd: WideString read Get_VAliqProd write Set_VAliqProd;
    property VPIS: WideString read Get_VPIS write Set_VPIS;
  end;

{ IXMLPISST }

  IXMLPISST = interface(IXMLNode)
    ['{CDA4915F-1166-4B80-96C5-08E617BD4292}']
    { Property Accessors }
    function Get_VBC: WideString;
    function Get_PPIS: WideString;
    function Get_QBCProd: WideString;
    function Get_VAliqProd: WideString;
    function Get_VPIS: WideString;
    procedure Set_VBC(Value: WideString);
    procedure Set_PPIS(Value: WideString);
    procedure Set_QBCProd(Value: WideString);
    procedure Set_VAliqProd(Value: WideString);
    procedure Set_VPIS(Value: WideString);
    { Methods & Properties }
    property VBC: WideString read Get_VBC write Set_VBC;
    property PPIS: WideString read Get_PPIS write Set_PPIS;
    property QBCProd: WideString read Get_QBCProd write Set_QBCProd;
    property VAliqProd: WideString read Get_VAliqProd write Set_VAliqProd;
    property VPIS: WideString read Get_VPIS write Set_VPIS;
  end;

{ IXMLCOFINS }

  IXMLCOFINS = interface(IXMLNode)
    ['{65662266-182C-4778-B04F-68D29023D207}']
    { Property Accessors }
    function Get_COFINSAliq: IXMLCOFINSAliq;
    function Get_COFINSQtde: IXMLCOFINSQtde;
    function Get_COFINSNT: IXMLCOFINSNT;
    function Get_COFINSOutr: IXMLCOFINSOutr;
    { Methods & Properties }
    property COFINSAliq: IXMLCOFINSAliq read Get_COFINSAliq;
    property COFINSQtde: IXMLCOFINSQtde read Get_COFINSQtde;
    property COFINSNT: IXMLCOFINSNT read Get_COFINSNT;
    property COFINSOutr: IXMLCOFINSOutr read Get_COFINSOutr;
  end;

{ IXMLCOFINSAliq }

  IXMLCOFINSAliq = interface(IXMLNode)
    ['{C5542B99-1F4C-44DB-8A6C-6A189304EB7C}']
    { Property Accessors }
    function Get_CST: WideString;
    function Get_VBC: WideString;
    function Get_PCOFINS: WideString;
    function Get_VCOFINS: WideString;
    procedure Set_CST(Value: WideString);
    procedure Set_VBC(Value: WideString);
    procedure Set_PCOFINS(Value: WideString);
    procedure Set_VCOFINS(Value: WideString);
    { Methods & Properties }
    property CST: WideString read Get_CST write Set_CST;
    property VBC: WideString read Get_VBC write Set_VBC;
    property PCOFINS: WideString read Get_PCOFINS write Set_PCOFINS;
    property VCOFINS: WideString read Get_VCOFINS write Set_VCOFINS;
  end;

{ IXMLCOFINSQtde }

  IXMLCOFINSQtde = interface(IXMLNode)
    ['{B0E33384-5D56-46A6-B760-3D4E113C63F0}']
    { Property Accessors }
    function Get_CST: WideString;
    function Get_QBCProd: WideString;
    function Get_VAliqProd: WideString;
    function Get_VCOFINS: WideString;
    procedure Set_CST(Value: WideString);
    procedure Set_QBCProd(Value: WideString);
    procedure Set_VAliqProd(Value: WideString);
    procedure Set_VCOFINS(Value: WideString);
    { Methods & Properties }
    property CST: WideString read Get_CST write Set_CST;
    property QBCProd: WideString read Get_QBCProd write Set_QBCProd;
    property VAliqProd: WideString read Get_VAliqProd write Set_VAliqProd;
    property VCOFINS: WideString read Get_VCOFINS write Set_VCOFINS;
  end;

{ IXMLCOFINSNT }

  IXMLCOFINSNT = interface(IXMLNode)
    ['{0E3B7643-B99F-497B-BA81-D93F601D28FA}']
    { Property Accessors }
    function Get_CST: WideString;
    procedure Set_CST(Value: WideString);
    { Methods & Properties }
    property CST: WideString read Get_CST write Set_CST;
  end;

{ IXMLCOFINSOutr }

  IXMLCOFINSOutr = interface(IXMLNode)
    ['{E6E97E9D-FA7E-4A2B-981C-A6BD488033B8}']
    { Property Accessors }
    function Get_CST: WideString;
    function Get_VBC: WideString;
    function Get_PCOFINS: WideString;
    function Get_QBCProd: WideString;
    function Get_VAliqProd: WideString;
    function Get_VCOFINS: WideString;
    procedure Set_CST(Value: WideString);
    procedure Set_VBC(Value: WideString);
    procedure Set_PCOFINS(Value: WideString);
    procedure Set_QBCProd(Value: WideString);
    procedure Set_VAliqProd(Value: WideString);
    procedure Set_VCOFINS(Value: WideString);
    { Methods & Properties }
    property CST: WideString read Get_CST write Set_CST;
    property VBC: WideString read Get_VBC write Set_VBC;
    property PCOFINS: WideString read Get_PCOFINS write Set_PCOFINS;
    property QBCProd: WideString read Get_QBCProd write Set_QBCProd;
    property VAliqProd: WideString read Get_VAliqProd write Set_VAliqProd;
    property VCOFINS: WideString read Get_VCOFINS write Set_VCOFINS;
  end;

{ IXMLCOFINSST }

  IXMLCOFINSST = interface(IXMLNode)
    ['{B617958B-6B67-4443-AA26-BD0F00E848A8}']
    { Property Accessors }
    function Get_VBC: WideString;
    function Get_PCOFINS: WideString;
    function Get_QBCProd: WideString;
    function Get_VAliqProd: WideString;
    function Get_VCOFINS: WideString;
    procedure Set_VBC(Value: WideString);
    procedure Set_PCOFINS(Value: WideString);
    procedure Set_QBCProd(Value: WideString);
    procedure Set_VAliqProd(Value: WideString);
    procedure Set_VCOFINS(Value: WideString);
    { Methods & Properties }
    property VBC: WideString read Get_VBC write Set_VBC;
    property PCOFINS: WideString read Get_PCOFINS write Set_PCOFINS;
    property QBCProd: WideString read Get_QBCProd write Set_QBCProd;
    property VAliqProd: WideString read Get_VAliqProd write Set_VAliqProd;
    property VCOFINS: WideString read Get_VCOFINS write Set_VCOFINS;
  end;

{ IXMLISSQN }

  IXMLISSQN = interface(IXMLNode)
    ['{6B76E0D5-37BA-4B54-9F19-B68F30BE27D4}']
    { Property Accessors }
    function Get_VBC: WideString;
    function Get_VAliq: WideString;
    function Get_VISSQN: WideString;
    function Get_CMunFG: WideString;
    function Get_CListServ: WideString;
    procedure Set_VBC(Value: WideString);
    procedure Set_VAliq(Value: WideString);
    procedure Set_VISSQN(Value: WideString);
    procedure Set_CMunFG(Value: WideString);
    procedure Set_CListServ(Value: WideString);
    { Methods & Properties }
    property VBC: WideString read Get_VBC write Set_VBC;
    property VAliq: WideString read Get_VAliq write Set_VAliq;
    property VISSQN: WideString read Get_VISSQN write Set_VISSQN;
    property CMunFG: WideString read Get_CMunFG write Set_CMunFG;
    property CListServ: WideString read Get_CListServ write Set_CListServ;
  end;

{ IXMLTotal }

  IXMLTotal = interface(IXMLNode)
    ['{3ED9874A-4987-41B7-97F1-51D6530CBBED}']
    { Property Accessors }
    function Get_ICMSTot: IXMLICMSTot;
    function Get_ISSQNtot: IXMLISSQNtot;
    function Get_RetTrib: IXMLRetTrib;
    { Methods & Properties }
    property ICMSTot: IXMLICMSTot read Get_ICMSTot;
    property ISSQNtot: IXMLISSQNtot read Get_ISSQNtot;
    property RetTrib: IXMLRetTrib read Get_RetTrib;
  end;

{ IXMLICMSTot }

  IXMLICMSTot = interface(IXMLNode)
    ['{DF8CAEC4-FA01-4C6B-B6AE-EDB7989058BC}']
    { Property Accessors }
    function Get_VBC: WideString;
    function Get_VICMS: WideString;
    function Get_VBCST: WideString;
    function Get_VST: WideString;
    function Get_VProd: WideString;
    function Get_VFrete: WideString;
    function Get_VSeg: WideString;
    function Get_VDesc: WideString;
    function Get_VII: WideString;
    function Get_VIPI: WideString;
    function Get_VPIS: WideString;
    function Get_VCOFINS: WideString;
    function Get_VOutro: WideString;
    function Get_VNF: WideString;
    procedure Set_VBC(Value: WideString);
    procedure Set_VICMS(Value: WideString);
    procedure Set_VBCST(Value: WideString);
    procedure Set_VST(Value: WideString);
    procedure Set_VProd(Value: WideString);
    procedure Set_VFrete(Value: WideString);
    procedure Set_VSeg(Value: WideString);
    procedure Set_VDesc(Value: WideString);
    procedure Set_VII(Value: WideString);
    procedure Set_VIPI(Value: WideString);
    procedure Set_VPIS(Value: WideString);
    procedure Set_VCOFINS(Value: WideString);
    procedure Set_VOutro(Value: WideString);
    procedure Set_VNF(Value: WideString);
    { Methods & Properties }
    property VBC: WideString read Get_VBC write Set_VBC;
    property VICMS: WideString read Get_VICMS write Set_VICMS;
    property VBCST: WideString read Get_VBCST write Set_VBCST;
    property VST: WideString read Get_VST write Set_VST;
    property VProd: WideString read Get_VProd write Set_VProd;
    property VFrete: WideString read Get_VFrete write Set_VFrete;
    property VSeg: WideString read Get_VSeg write Set_VSeg;
    property VDesc: WideString read Get_VDesc write Set_VDesc;
    property VII: WideString read Get_VII write Set_VII;
    property VIPI: WideString read Get_VIPI write Set_VIPI;
    property VPIS: WideString read Get_VPIS write Set_VPIS;
    property VCOFINS: WideString read Get_VCOFINS write Set_VCOFINS;
    property VOutro: WideString read Get_VOutro write Set_VOutro;
    property VNF: WideString read Get_VNF write Set_VNF;
  end;

{ IXMLISSQNtot }

  IXMLISSQNtot = interface(IXMLNode)
    ['{57DA87AE-F5A3-404B-914F-ABE2AB8D0E51}']
    { Property Accessors }
    function Get_VServ: WideString;
    function Get_VBC: WideString;
    function Get_VISS: WideString;
    function Get_VPIS: WideString;
    function Get_VCOFINS: WideString;
    procedure Set_VServ(Value: WideString);
    procedure Set_VBC(Value: WideString);
    procedure Set_VISS(Value: WideString);
    procedure Set_VPIS(Value: WideString);
    procedure Set_VCOFINS(Value: WideString);
    { Methods & Properties }
    property VServ: WideString read Get_VServ write Set_VServ;
    property VBC: WideString read Get_VBC write Set_VBC;
    property VISS: WideString read Get_VISS write Set_VISS;
    property VPIS: WideString read Get_VPIS write Set_VPIS;
    property VCOFINS: WideString read Get_VCOFINS write Set_VCOFINS;
  end;

{ IXMLRetTrib }

  IXMLRetTrib = interface(IXMLNode)
    ['{804B650D-77BF-42BF-92C8-1E00906FA201}']
    { Property Accessors }
    function Get_VRetPIS: WideString;
    function Get_VRetCOFINS: WideString;
    function Get_VRetCSLL: WideString;
    function Get_VBCIRRF: WideString;
    function Get_VIRRF: WideString;
    function Get_VBCRetPrev: WideString;
    function Get_VRetPrev: WideString;
    procedure Set_VRetPIS(Value: WideString);
    procedure Set_VRetCOFINS(Value: WideString);
    procedure Set_VRetCSLL(Value: WideString);
    procedure Set_VBCIRRF(Value: WideString);
    procedure Set_VIRRF(Value: WideString);
    procedure Set_VBCRetPrev(Value: WideString);
    procedure Set_VRetPrev(Value: WideString);
    { Methods & Properties }
    property VRetPIS: WideString read Get_VRetPIS write Set_VRetPIS;
    property VRetCOFINS: WideString read Get_VRetCOFINS write Set_VRetCOFINS;
    property VRetCSLL: WideString read Get_VRetCSLL write Set_VRetCSLL;
    property VBCIRRF: WideString read Get_VBCIRRF write Set_VBCIRRF;
    property VIRRF: WideString read Get_VIRRF write Set_VIRRF;
    property VBCRetPrev: WideString read Get_VBCRetPrev write Set_VBCRetPrev;
    property VRetPrev: WideString read Get_VRetPrev write Set_VRetPrev;
  end;

{ IXMLTransp }

  IXMLTransp = interface(IXMLNode)
    ['{BC1E0F79-6E69-41FC-8843-9CF44BF32BC3}']
    { Property Accessors }
    function Get_ModFrete: WideString;
    function Get_Transporta: IXMLTransporta;
    function Get_RetTransp: IXMLRetTransp;
    function Get_VeicTransp: IXMLTVeiculo;
    function Get_Reboque: IXMLTVeiculoList;
    function Get_Vol: IXMLVolList;
    procedure Set_ModFrete(Value: WideString);
    { Methods & Properties }
    property ModFrete: WideString read Get_ModFrete write Set_ModFrete;
    property Transporta: IXMLTransporta read Get_Transporta;
    property RetTransp: IXMLRetTransp read Get_RetTransp;
    property VeicTransp: IXMLTVeiculo read Get_VeicTransp;
    property Reboque: IXMLTVeiculoList read Get_Reboque;
    property Vol: IXMLVolList read Get_Vol;
  end;

{ IXMLTransporta }

  IXMLTransporta = interface(IXMLNode)
    ['{D4089487-9B36-4FE9-A6CE-9238353236F1}']
    { Property Accessors }
    function Get_CNPJ: WideString;
    function Get_CPF: WideString;
    function Get_XNome: WideString;
    function Get_IE: WideString;
    function Get_XEnder: WideString;
    function Get_XMun: WideString;
    function Get_UF: WideString;
    procedure Set_CNPJ(Value: WideString);
    procedure Set_CPF(Value: WideString);
    procedure Set_XNome(Value: WideString);
    procedure Set_IE(Value: WideString);
    procedure Set_XEnder(Value: WideString);
    procedure Set_XMun(Value: WideString);
    procedure Set_UF(Value: WideString);
    { Methods & Properties }
    property CNPJ: WideString read Get_CNPJ write Set_CNPJ;
    property CPF: WideString read Get_CPF write Set_CPF;
    property XNome: WideString read Get_XNome write Set_XNome;
    property IE: WideString read Get_IE write Set_IE;
    property XEnder: WideString read Get_XEnder write Set_XEnder;
    property XMun: WideString read Get_XMun write Set_XMun;
    property UF: WideString read Get_UF write Set_UF;
  end;

{ IXMLRetTransp }

  IXMLRetTransp = interface(IXMLNode)
    ['{25B1BCB6-D4C7-4E3D-A7E8-AA3AA89795EB}']
    { Property Accessors }
    function Get_VServ: WideString;
    function Get_VBCRet: WideString;
    function Get_PICMSRet: WideString;
    function Get_VICMSRet: WideString;
    function Get_CFOP: WideString;
    function Get_CMunFG: WideString;
    procedure Set_VServ(Value: WideString);
    procedure Set_VBCRet(Value: WideString);
    procedure Set_PICMSRet(Value: WideString);
    procedure Set_VICMSRet(Value: WideString);
    procedure Set_CFOP(Value: WideString);
    procedure Set_CMunFG(Value: WideString);
    { Methods & Properties }
    property VServ: WideString read Get_VServ write Set_VServ;
    property VBCRet: WideString read Get_VBCRet write Set_VBCRet;
    property PICMSRet: WideString read Get_PICMSRet write Set_PICMSRet;
    property VICMSRet: WideString read Get_VICMSRet write Set_VICMSRet;
    property CFOP: WideString read Get_CFOP write Set_CFOP;
    property CMunFG: WideString read Get_CMunFG write Set_CMunFG;
  end;

{ IXMLTVeiculo }

  IXMLTVeiculo = interface(IXMLNode)
    ['{B8ACB434-8184-4E64-9240-DFC289E9B93C}']
    { Property Accessors }
    function Get_Placa: WideString;
    function Get_UF: WideString;
    function Get_RNTC: WideString;
    procedure Set_Placa(Value: WideString);
    procedure Set_UF(Value: WideString);
    procedure Set_RNTC(Value: WideString);
    { Methods & Properties }
    property Placa: WideString read Get_Placa write Set_Placa;
    property UF: WideString read Get_UF write Set_UF;
    property RNTC: WideString read Get_RNTC write Set_RNTC;
  end;

{ IXMLTVeiculoList }

  IXMLTVeiculoList = interface(IXMLNodeCollection)
    ['{7DC25782-E1CB-4AAE-A742-7F5A601D58F0}']
    { Methods & Properties }
    function Add: IXMLTVeiculo;
    function Insert(const Index: Integer): IXMLTVeiculo;
    function Get_Item(Index: Integer): IXMLTVeiculo;
    property Items[Index: Integer]: IXMLTVeiculo read Get_Item; default;
  end;

{ IXMLVol }

  IXMLVol = interface(IXMLNode)
    ['{5AE5FA0C-023C-4155-A3A1-030D124B83AF}']
    { Property Accessors }
    function Get_QVol: WideString;
    function Get_Esp: WideString;
    function Get_Marca: WideString;
    function Get_NVol: WideString;
    function Get_PesoL: WideString;
    function Get_PesoB: WideString;
    function Get_Lacres: IXMLLacresList;
    procedure Set_QVol(Value: WideString);
    procedure Set_Esp(Value: WideString);
    procedure Set_Marca(Value: WideString);
    procedure Set_NVol(Value: WideString);
    procedure Set_PesoL(Value: WideString);
    procedure Set_PesoB(Value: WideString);
    { Methods & Properties }
    property QVol: WideString read Get_QVol write Set_QVol;
    property Esp: WideString read Get_Esp write Set_Esp;
    property Marca: WideString read Get_Marca write Set_Marca;
    property NVol: WideString read Get_NVol write Set_NVol;
    property PesoL: WideString read Get_PesoL write Set_PesoL;
    property PesoB: WideString read Get_PesoB write Set_PesoB;
    property Lacres: IXMLLacresList read Get_Lacres;
  end;

{ IXMLVolList }

  IXMLVolList = interface(IXMLNodeCollection)
    ['{034A9A98-2950-44D2-94F8-CA2FD08ED23C}']
    { Methods & Properties }
    function Add: IXMLVol;
    function Insert(const Index: Integer): IXMLVol;
    function Get_Item(Index: Integer): IXMLVol;
    property Items[Index: Integer]: IXMLVol read Get_Item; default;
  end;

{ IXMLLacres }

  IXMLLacres = interface(IXMLNode)
    ['{5AD6450C-091A-45D1-B480-FE48D361E5CB}']
    { Property Accessors }
    function Get_NLacre: WideString;
    procedure Set_NLacre(Value: WideString);
    { Methods & Properties }
    property NLacre: WideString read Get_NLacre write Set_NLacre;
  end;

{ IXMLLacresList }

  IXMLLacresList = interface(IXMLNodeCollection)
    ['{F74F4175-1256-47CF-952D-58471ADB5DC1}']
    { Methods & Properties }
    function Add: IXMLLacres;
    function Insert(const Index: Integer): IXMLLacres;
    function Get_Item(Index: Integer): IXMLLacres;
    property Items[Index: Integer]: IXMLLacres read Get_Item; default;
  end;

{ IXMLCobr }

  IXMLCobr = interface(IXMLNode)
    ['{203EC58F-7D3D-4388-9A92-F8110D6B2CB2}']
    { Property Accessors }
    function Get_Fat: IXMLFat;
    function Get_Dup: IXMLDupList;
    { Methods & Properties }
    property Fat: IXMLFat read Get_Fat;
    property Dup: IXMLDupList read Get_Dup;
  end;

{ IXMLFat }

  IXMLFat = interface(IXMLNode)
    ['{3598DA62-426B-4486-A0BD-7081C7C87806}']
    { Property Accessors }
    function Get_NFat: WideString;
    function Get_VOrig: WideString;
    function Get_VDesc: WideString;
    function Get_VLiq: WideString;
    procedure Set_NFat(Value: WideString);
    procedure Set_VOrig(Value: WideString);
    procedure Set_VDesc(Value: WideString);
    procedure Set_VLiq(Value: WideString);
    { Methods & Properties }
    property NFat: WideString read Get_NFat write Set_NFat;
    property VOrig: WideString read Get_VOrig write Set_VOrig;
    property VDesc: WideString read Get_VDesc write Set_VDesc;
    property VLiq: WideString read Get_VLiq write Set_VLiq;
  end;

{ IXMLDup }

  IXMLDup = interface(IXMLNode)
    ['{03A3AEC9-3E6D-4C95-AEB9-7986EB1686EA}']
    { Property Accessors }
    function Get_NDup: WideString;
    function Get_DVenc: WideString;
    function Get_VDup: WideString;
    procedure Set_NDup(Value: WideString);
    procedure Set_DVenc(Value: WideString);
    procedure Set_VDup(Value: WideString);
    { Methods & Properties }
    property NDup: WideString read Get_NDup write Set_NDup;
    property DVenc: WideString read Get_DVenc write Set_DVenc;
    property VDup: WideString read Get_VDup write Set_VDup;
  end;

{ IXMLDupList }

  IXMLDupList = interface(IXMLNodeCollection)
    ['{6949BD24-E8E7-4C39-9D52-514658C972E5}']
    { Methods & Properties }
    function Add: IXMLDup;
    function Insert(const Index: Integer): IXMLDup;
    function Get_Item(Index: Integer): IXMLDup;
    property Items[Index: Integer]: IXMLDup read Get_Item; default;
  end;

{ IXMLInfAdic }

  IXMLInfAdic = interface(IXMLNode)
    ['{CA35CFCB-7903-4AA6-B600-3AADE5EEA962}']
    { Property Accessors }
    function Get_InfAdFisco: WideString;
    function Get_InfCpl: WideString;
    function Get_ObsCont: IXMLObsCont;
    function Get_ObsFisco: IXMLObsFisco;
    function Get_ProcRef: IXMLProcRefList;
    procedure Set_InfAdFisco(Value: WideString);
    procedure Set_InfCpl(Value: WideString);
    { Methods & Properties }
    property InfAdFisco: WideString read Get_InfAdFisco write Set_InfAdFisco;
    property InfCpl: WideString read Get_InfCpl write Set_InfCpl;
    property ObsCont: IXMLObsCont read Get_ObsCont;
    property ObsFisco: IXMLObsFisco read Get_ObsFisco;
    property ProcRef: IXMLProcRefList read Get_ProcRef;
  end;

{ IXMLObsCont }

  IXMLObsCont = interface(IXMLNode)
    ['{596660A9-0AC5-43E9-9F3D-013AB3388F16}']
    { Property Accessors }
    function Get_XCampo: WideString;
    function Get_XTexto: WideString;
    procedure Set_XCampo(Value: WideString);
    procedure Set_XTexto(Value: WideString);
    { Methods & Properties }
    property XCampo: WideString read Get_XCampo write Set_XCampo;
    property XTexto: WideString read Get_XTexto write Set_XTexto;
  end;

{ IXMLObsFisco }

  IXMLObsFisco = interface(IXMLNode)
    ['{BD148BBB-FA0A-43AF-8DB9-3886288BF76C}']
    { Property Accessors }
    function Get_XCampo: WideString;
    function Get_XTexto: WideString;
    procedure Set_XCampo(Value: WideString);
    procedure Set_XTexto(Value: WideString);
    { Methods & Properties }
    property XCampo: WideString read Get_XCampo write Set_XCampo;
    property XTexto: WideString read Get_XTexto write Set_XTexto;
  end;

{ IXMLProcRef }

  IXMLProcRef = interface(IXMLNode)
    ['{60ADC411-DBC0-4307-9D0F-8F6623AD92DE}']
    { Property Accessors }
    function Get_NProc: WideString;
    function Get_IndProc: WideString;
    procedure Set_NProc(Value: WideString);
    procedure Set_IndProc(Value: WideString);
    { Methods & Properties }
    property NProc: WideString read Get_NProc write Set_NProc;
    property IndProc: WideString read Get_IndProc write Set_IndProc;
  end;

{ IXMLProcRefList }

  IXMLProcRefList = interface(IXMLNodeCollection)
    ['{FC3A0768-8F51-4C1D-B5F5-5A38E52F8C49}']
    { Methods & Properties }
    function Add: IXMLProcRef;
    function Insert(const Index: Integer): IXMLProcRef;
    function Get_Item(Index: Integer): IXMLProcRef;
    property Items[Index: Integer]: IXMLProcRef read Get_Item; default;
  end;

{ IXMLExporta }

  IXMLExporta = interface(IXMLNode)
    ['{0DD4B52B-8F78-4D88-BE4D-A1EF02934AC6}']
    { Property Accessors }
    function Get_UFEmbarq: WideString;
    function Get_XLocEmbarq: WideString;
    procedure Set_UFEmbarq(Value: WideString);
    procedure Set_XLocEmbarq(Value: WideString);
    { Methods & Properties }
    property UFEmbarq: WideString read Get_UFEmbarq write Set_UFEmbarq;
    property XLocEmbarq: WideString read Get_XLocEmbarq write Set_XLocEmbarq;
  end;

{ IXMLCompra }

  IXMLCompra = interface(IXMLNode)
    ['{A01CB185-C1B7-4134-803C-71B5ABE31D5A}']
    { Property Accessors }
    function Get_XNEmp: WideString;
    function Get_XPed: WideString;
    function Get_XCont: WideString;
    procedure Set_XNEmp(Value: WideString);
    procedure Set_XPed(Value: WideString);
    procedure Set_XCont(Value: WideString);
    { Methods & Properties }
    property XNEmp: WideString read Get_XNEmp write Set_XNEmp;
    property XPed: WideString read Get_XPed write Set_XPed;
    property XCont: WideString read Get_XCont write Set_XCont;
  end;

{ IXMLSignatureType }

  IXMLSignatureType = interface(IXMLNode)
    ['{DA199870-ABBA-496E-81EF-FBA5C07CB9B0}']
    { Property Accessors }
    function Get_Id: WideString;
    function Get_SignedInfo: IXMLSignedInfoType;
    function Get_SignatureValue: IXMLSignatureValueType;
    function Get_KeyInfo: IXMLKeyInfoType;
    procedure Set_Id(Value: WideString);
    { Methods & Properties }
    property Id: WideString read Get_Id write Set_Id;
    property SignedInfo: IXMLSignedInfoType read Get_SignedInfo;
    property SignatureValue: IXMLSignatureValueType read Get_SignatureValue;
    property KeyInfo: IXMLKeyInfoType read Get_KeyInfo;
  end;

{ IXMLSignedInfoType }

  IXMLSignedInfoType = interface(IXMLNode)
    ['{CBA232CE-CBDB-4DC9-9DD2-FD6672866129}']
    { Property Accessors }
    function Get_Id: WideString;
    function Get_CanonicalizationMethod: IXMLCanonicalizationMethod;
    function Get_SignatureMethod: IXMLSignatureMethod;
    function Get_Reference: IXMLReferenceType;
    procedure Set_Id(Value: WideString);
    { Methods & Properties }
    property Id: WideString read Get_Id write Set_Id;
    property CanonicalizationMethod: IXMLCanonicalizationMethod read Get_CanonicalizationMethod;
    property SignatureMethod: IXMLSignatureMethod read Get_SignatureMethod;
    property Reference: IXMLReferenceType read Get_Reference;
  end;

{ IXMLCanonicalizationMethod }

  IXMLCanonicalizationMethod = interface(IXMLNode)
    ['{0908CD92-B9CA-44F6-B9B6-0C84B6C7DD42}']
    { Property Accessors }
    function Get_Algorithm: WideString;
    procedure Set_Algorithm(Value: WideString);
    { Methods & Properties }
    property Algorithm: WideString read Get_Algorithm write Set_Algorithm;
  end;

{ IXMLSignatureMethod }

  IXMLSignatureMethod = interface(IXMLNode)
    ['{1C53019C-3BE9-4E00-95DB-07DF8E872760}']
    { Property Accessors }
    function Get_Algorithm: WideString;
    procedure Set_Algorithm(Value: WideString);
    { Methods & Properties }
    property Algorithm: WideString read Get_Algorithm write Set_Algorithm;
  end;

{ IXMLReferenceType }

  IXMLReferenceType = interface(IXMLNode)
    ['{A5251712-C84A-46A5-AB43-5F5F6C5F67A9}']
    { Property Accessors }
    function Get_Id: WideString;
    function Get_URI: WideString;
    function Get_Type_: WideString;
    function Get_Transforms: IXMLTransformsType;
    function Get_DigestMethod: IXMLDigestMethod;
    function Get_DigestValue: WideString;
    procedure Set_Id(Value: WideString);
    procedure Set_URI(Value: WideString);
    procedure Set_Type_(Value: WideString);
    procedure Set_DigestValue(Value: WideString);
    { Methods & Properties }
    property Id: WideString read Get_Id write Set_Id;
    property URI: WideString read Get_URI write Set_URI;
    property Type_: WideString read Get_Type_ write Set_Type_;
    property Transforms: IXMLTransformsType read Get_Transforms;
    property DigestMethod: IXMLDigestMethod read Get_DigestMethod;
    property DigestValue: WideString read Get_DigestValue write Set_DigestValue;
  end;

{ IXMLTransformsType }

  IXMLTransformsType = interface(IXMLNodeCollection)
    ['{2A547AD5-85FD-4FBA-AD30-BBA293BA4324}']
    { Property Accessors }
    function Get_Transform(Index: Integer): IXMLTransformType;
    { Methods & Properties }
    function Add: IXMLTransformType;
    function Insert(const Index: Integer): IXMLTransformType;
    property Transform[Index: Integer]: IXMLTransformType read Get_Transform; default;
  end;

{ IXMLTransformType }

  IXMLTransformType = interface(IXMLNodeCollection)
    ['{A927BCC2-9956-4BA3-AE5D-0A51D13E291C}']
    { Property Accessors }
    function Get_Algorithm: WideString;
    function Get_XPath(Index: Integer): WideString;
    procedure Set_Algorithm(Value: WideString);
    { Methods & Properties }
    function Add(const XPath: WideString): IXMLNode;
    function Insert(const Index: Integer; const XPath: WideString): IXMLNode;
    property Algorithm: WideString read Get_Algorithm write Set_Algorithm;
    property XPath[Index: Integer]: WideString read Get_XPath; default;
  end;

{ IXMLDigestMethod }

  IXMLDigestMethod = interface(IXMLNode)
    ['{C5BEEF61-1113-4D74-B276-D96F0D37278C}']
    { Property Accessors }
    function Get_Algorithm: WideString;
    procedure Set_Algorithm(Value: WideString);
    { Methods & Properties }
    property Algorithm: WideString read Get_Algorithm write Set_Algorithm;
  end;

{ IXMLSignatureValueType }

  IXMLSignatureValueType = interface(IXMLNode)
    ['{DEB7367F-AA10-467B-BE05-431A903DA5D3}']
    { Property Accessors }
    function Get_Id: WideString;
    procedure Set_Id(Value: WideString);
    { Methods & Properties }
    property Id: WideString read Get_Id write Set_Id;
  end;

{ IXMLKeyInfoType }

  IXMLKeyInfoType = interface(IXMLNode)
    ['{E13B3DA8-B55D-4E6C-9C17-363833577F76}']
    { Property Accessors }
    function Get_Id: WideString;
    function Get_X509Data: IXMLX509DataType;
    procedure Set_Id(Value: WideString);
    { Methods & Properties }
    property Id: WideString read Get_Id write Set_Id;
    property X509Data: IXMLX509DataType read Get_X509Data;
  end;

{ IXMLX509DataType }

  IXMLX509DataType = interface(IXMLNode)
    ['{0D78A19A-D0B4-4C52-B1C2-36EEE8A8FAC9}']
    { Property Accessors }
    function Get_X509Certificate: WideString;
    procedure Set_X509Certificate(Value: WideString);
    { Methods & Properties }
    property X509Certificate: WideString read Get_X509Certificate write Set_X509Certificate;
  end;

{ Forward Decls }

  TXMLTEnviNFe = class;
  TXMLTNFe = class;
  TXMLTNFeList = class;
  TXMLInfNFe = class;
  TXMLIde = class;
  TXMLNFref = class;
  TXMLNFrefList = class;
  TXMLRefNF = class;
  TXMLEmit = class;
  TXMLTEndereco = class;
  TXMLAvulsa = class;
  TXMLDest = class;
  TXMLTLocal = class;
  TXMLDet = class;
  TXMLDetList = class;
  TXMLProd = class;
  TXMLDI = class;
  TXMLDIList = class;
  TXMLAdi = class;
  TXMLAdiList = class;
  TXMLVeicProd = class;
  TXMLMed = class;
  TXMLMedList = class;
  TXMLArma = class;
  TXMLArmaList = class;
  TXMLComb = class;
  TXMLCIDE = class;
  TXMLICMSComb = class;
  TXMLICMSInter = class;
  TXMLICMSCons = class;
  TXMLImposto = class;
  TXMLICMS = class;
  TXMLICMS00 = class;
  TXMLICMS10 = class;
  TXMLICMS20 = class;
  TXMLICMS30 = class;
  TXMLICMS40 = class;
  TXMLICMS51 = class;
  TXMLICMS60 = class;
  TXMLICMS70 = class;
  TXMLICMS90 = class;
  TXMLIPI = class;
  TXMLIPITrib = class;
  TXMLIPINT = class;
  TXMLII = class;
  TXMLPIS = class;
  TXMLPISAliq = class;
  TXMLPISQtde = class;
  TXMLPISNT = class;
  TXMLPISOutr = class;
  TXMLPISST = class;
  TXMLCOFINS = class;
  TXMLCOFINSAliq = class;
  TXMLCOFINSQtde = class;
  TXMLCOFINSNT = class;
  TXMLCOFINSOutr = class;
  TXMLCOFINSST = class;
  TXMLISSQN = class;
  TXMLTotal = class;
  TXMLICMSTot = class;
  TXMLISSQNtot = class;
  TXMLRetTrib = class;
  TXMLTransp = class;
  TXMLTransporta = class;
  TXMLRetTransp = class;
  TXMLTVeiculo = class;
  TXMLTVeiculoList = class;
  TXMLVol = class;
  TXMLVolList = class;
  TXMLLacres = class;
  TXMLLacresList = class;
  TXMLCobr = class;
  TXMLFat = class;
  TXMLDup = class;
  TXMLDupList = class;
  TXMLInfAdic = class;
  TXMLObsCont = class;
  TXMLObsFisco = class;
  TXMLProcRef = class;
  TXMLProcRefList = class;
  TXMLExporta = class;
  TXMLCompra = class;
  TXMLSignatureType = class;
  TXMLSignedInfoType = class;
  TXMLCanonicalizationMethod = class;
  TXMLSignatureMethod = class;
  TXMLReferenceType = class;
  TXMLTransformsType = class;
  TXMLTransformType = class;
  TXMLDigestMethod = class;
  TXMLSignatureValueType = class;
  TXMLKeyInfoType = class;
  TXMLX509DataType = class;

{ TXMLTEnviNFe }

  TXMLTEnviNFe = class(TXMLNode, IXMLTEnviNFe)
  private
    FNFe: IXMLTNFeList;
  protected
    { IXMLTEnviNFe }
    function Get_Versao: WideString;
    function Get_IdLote: WideString;
    function Get_NFe: IXMLTNFeList;
    procedure Set_Versao(Value: WideString);
    procedure Set_IdLote(Value: WideString);
  public
    procedure AfterConstruction; override;
  end;

{ TXMLTNFe }

  TXMLTNFe = class(TXMLNode, IXMLTNFe)
  protected
    { IXMLTNFe }
    function Get_InfNFe: IXMLInfNFe;
    function Get_Signature: IXMLSignatureType;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLTNFeList }

  TXMLTNFeList = class(TXMLNodeCollection, IXMLTNFeList)
  protected
    { IXMLTNFeList }
    function Add: IXMLTNFe;
    function Insert(const Index: Integer): IXMLTNFe;
    function Get_Item(Index: Integer): IXMLTNFe;
  end;

{ TXMLInfNFe }

  TXMLInfNFe = class(TXMLNode, IXMLInfNFe)
  private
    FDet: IXMLDetList;
  protected
    { IXMLInfNFe }
    function Get_Versao: WideString;
    function Get_Id: WideString;
    function Get_Ide: IXMLIde;
    function Get_Emit: IXMLEmit;
    function Get_Avulsa: IXMLAvulsa;
    function Get_Dest: IXMLDest;
    function Get_Retirada: IXMLTLocal;
    function Get_Entrega: IXMLTLocal;
    function Get_Det: IXMLDetList;
    function Get_Total: IXMLTotal;
    function Get_Transp: IXMLTransp;
    function Get_Cobr: IXMLCobr;
    function Get_InfAdic: IXMLInfAdic;
    function Get_Exporta: IXMLExporta;
    function Get_Compra: IXMLCompra;
    procedure Set_Versao(Value: WideString);
    procedure Set_Id(Value: WideString);
  public
    procedure AfterConstruction; override;
  end;

{ TXMLIde }

  TXMLIde = class(TXMLNode, IXMLIde)
  private
    FNFref: IXMLNFrefList;
  protected
    { IXMLIde }
    function Get_CUF: WideString;
    function Get_CNF: WideString;
    function Get_NatOp: WideString;
    function Get_IndPag: WideString;
    function Get_Mod_: WideString;
    function Get_Serie: WideString;
    function Get_NNF: WideString;
    function Get_DEmi: WideString;
    function Get_DSaiEnt: WideString;
    function Get_TpNF: WideString;
    function Get_CMunFG: WideString;
    function Get_NFref: IXMLNFrefList;
    function Get_TpImp: WideString;
    function Get_TpEmis: WideString;
    function Get_CDV: WideString;
    function Get_TpAmb: WideString;
    function Get_FinNFe: WideString;
    function Get_ProcEmi: WideString;
    function Get_VerProc: WideString;
    procedure Set_CUF(Value: WideString);
    procedure Set_CNF(Value: WideString);
    procedure Set_NatOp(Value: WideString);
    procedure Set_IndPag(Value: WideString);
    procedure Set_Mod_(Value: WideString);
    procedure Set_Serie(Value: WideString);
    procedure Set_NNF(Value: WideString);
    procedure Set_DEmi(Value: WideString);
    procedure Set_DSaiEnt(Value: WideString);
    procedure Set_TpNF(Value: WideString);
    procedure Set_CMunFG(Value: WideString);
    procedure Set_TpImp(Value: WideString);
    procedure Set_TpEmis(Value: WideString);
    procedure Set_CDV(Value: WideString);
    procedure Set_TpAmb(Value: WideString);
    procedure Set_FinNFe(Value: WideString);
    procedure Set_ProcEmi(Value: WideString);
    procedure Set_VerProc(Value: WideString);
  public
    procedure AfterConstruction; override;
  end;

{ TXMLNFref }

  TXMLNFref = class(TXMLNode, IXMLNFref)
  protected
    { IXMLNFref }
    function Get_RefNFe: WideString;
    function Get_RefNF: IXMLRefNF;
    procedure Set_RefNFe(Value: WideString);
  public
    procedure AfterConstruction; override;
  end;

{ TXMLNFrefList }

  TXMLNFrefList = class(TXMLNodeCollection, IXMLNFrefList)
  protected
    { IXMLNFrefList }
    function Add: IXMLNFref;
    function Insert(const Index: Integer): IXMLNFref;
    function Get_Item(Index: Integer): IXMLNFref;
  end;

{ TXMLRefNF }

  TXMLRefNF = class(TXMLNode, IXMLRefNF)
  protected
    { IXMLRefNF }
    function Get_CUF: WideString;
    function Get_AAMM: WideString;
    function Get_CNPJ: WideString;
    function Get_Mod_: WideString;
    function Get_Serie: WideString;
    function Get_NNF: WideString;
    procedure Set_CUF(Value: WideString);
    procedure Set_AAMM(Value: WideString);
    procedure Set_CNPJ(Value: WideString);
    procedure Set_Mod_(Value: WideString);
    procedure Set_Serie(Value: WideString);
    procedure Set_NNF(Value: WideString);
  end;

{ TXMLEmit }

  TXMLEmit = class(TXMLNode, IXMLEmit)
  protected
    { IXMLEmit }
    function Get_CNPJ: WideString;
    function Get_CPF: WideString;
    function Get_XNome: WideString;
    function Get_XFant: WideString;
    function Get_EnderEmit: IXMLTEndereco;
    function Get_IE: WideString;
    function Get_IEST: WideString;
    function Get_IM: WideString;
    function Get_CNAE: WideString;
    procedure Set_CNPJ(Value: WideString);
    procedure Set_CPF(Value: WideString);
    procedure Set_XNome(Value: WideString);
    procedure Set_XFant(Value: WideString);
    procedure Set_IE(Value: WideString);
    procedure Set_IEST(Value: WideString);
    procedure Set_IM(Value: WideString);
    procedure Set_CNAE(Value: WideString);
  public
    procedure AfterConstruction; override;
  end;

{ TXMLTEndereco }

  TXMLTEndereco = class(TXMLNode, IXMLTEndereco)
  protected
    { IXMLTEndereco }
    function Get_XLgr: WideString;
    function Get_Nro: WideString;
    function Get_XCpl: WideString;
    function Get_XBairro: WideString;
    function Get_CMun: WideString;
    function Get_XMun: WideString;
    function Get_UF: WideString;
    function Get_CEP: WideString;
    function Get_CPais: WideString;
    function Get_XPais: WideString;
    function Get_Fone: WideString;
    procedure Set_XLgr(Value: WideString);
    procedure Set_Nro(Value: WideString);
    procedure Set_XCpl(Value: WideString);
    procedure Set_XBairro(Value: WideString);
    procedure Set_CMun(Value: WideString);
    procedure Set_XMun(Value: WideString);
    procedure Set_UF(Value: WideString);
    procedure Set_CEP(Value: WideString);
    procedure Set_CPais(Value: WideString);
    procedure Set_XPais(Value: WideString);
    procedure Set_Fone(Value: WideString);
  end;

{ TXMLAvulsa }

  TXMLAvulsa = class(TXMLNode, IXMLAvulsa)
  protected
    { IXMLAvulsa }
    function Get_CNPJ: WideString;
    function Get_XOrgao: WideString;
    function Get_Matr: WideString;
    function Get_XAgente: WideString;
    function Get_Fone: WideString;
    function Get_UF: WideString;
    function Get_NDAR: WideString;
    function Get_DEmi: WideString;
    function Get_VDAR: WideString;
    function Get_RepEmi: WideString;
    function Get_DPag: WideString;
    procedure Set_CNPJ(Value: WideString);
    procedure Set_XOrgao(Value: WideString);
    procedure Set_Matr(Value: WideString);
    procedure Set_XAgente(Value: WideString);
    procedure Set_Fone(Value: WideString);
    procedure Set_UF(Value: WideString);
    procedure Set_NDAR(Value: WideString);
    procedure Set_DEmi(Value: WideString);
    procedure Set_VDAR(Value: WideString);
    procedure Set_RepEmi(Value: WideString);
    procedure Set_DPag(Value: WideString);
  end;

{ TXMLDest }

  TXMLDest = class(TXMLNode, IXMLDest)
  protected
    { IXMLDest }
    function Get_CNPJ: WideString;
    function Get_CPF: WideString;
    function Get_XNome: WideString;
    function Get_EnderDest: IXMLTEndereco;
    function Get_IE: WideString;
    function Get_ISUF: WideString;
    procedure Set_CNPJ(Value: WideString);
    procedure Set_CPF(Value: WideString);
    procedure Set_XNome(Value: WideString);
    procedure Set_IE(Value: WideString);
    procedure Set_ISUF(Value: WideString);
  public
    procedure AfterConstruction; override;
  end;

{ TXMLTLocal }

  TXMLTLocal = class(TXMLNode, IXMLTLocal)
  protected
    { IXMLTLocal }
    function Get_CNPJ: WideString;
    function Get_XLgr: WideString;
    function Get_Nro: WideString;
    function Get_XCpl: WideString;
    function Get_XBairro: WideString;
    function Get_CMun: WideString;
    function Get_XMun: WideString;
    function Get_UF: WideString;
    procedure Set_CNPJ(Value: WideString);
    procedure Set_XLgr(Value: WideString);
    procedure Set_Nro(Value: WideString);
    procedure Set_XCpl(Value: WideString);
    procedure Set_XBairro(Value: WideString);
    procedure Set_CMun(Value: WideString);
    procedure Set_XMun(Value: WideString);
    procedure Set_UF(Value: WideString);
  end;

{ TXMLDet }

  TXMLDet = class(TXMLNode, IXMLDet)
  protected
    { IXMLDet }
    function Get_NItem: WideString;
    function Get_Prod: IXMLProd;
    function Get_Imposto: IXMLImposto;
    function Get_InfAdProd: WideString;
    procedure Set_NItem(Value: WideString);
    procedure Set_InfAdProd(Value: WideString);
  public
    procedure AfterConstruction; override;
  end;

{ TXMLDetList }

  TXMLDetList = class(TXMLNodeCollection, IXMLDetList)
  protected
    { IXMLDetList }
    function Add: IXMLDet;
    function Insert(const Index: Integer): IXMLDet;
    function Get_Item(Index: Integer): IXMLDet;
  end;

{ TXMLProd }

  TXMLProd = class(TXMLNode, IXMLProd)
  private
    FDI: IXMLDIList;
    FMed: IXMLMedList;
    FArma: IXMLArmaList;
  protected
    { IXMLProd }
    function Get_CProd: WideString;
    function Get_CEAN: WideString;
    function Get_XProd: WideString;
    function Get_NCM: WideString;
    function Get_EXTIPI: WideString;
    function Get_Genero: WideString;
    function Get_CFOP: WideString;
    function Get_UCom: WideString;
    function Get_QCom: WideString;
    function Get_VUnCom: WideString;
    function Get_VProd: WideString;
    function Get_CEANTrib: WideString;
    function Get_UTrib: WideString;
    function Get_QTrib: WideString;
    function Get_VUnTrib: WideString;
    function Get_VFrete: WideString;
    function Get_VSeg: WideString;
    function Get_VDesc: WideString;
    function Get_DI: IXMLDIList;
    function Get_VeicProd: IXMLVeicProd;
    function Get_Med: IXMLMedList;
    function Get_Arma: IXMLArmaList;
    function Get_Comb: IXMLComb;
    procedure Set_CProd(Value: WideString);
    procedure Set_CEAN(Value: WideString);
    procedure Set_XProd(Value: WideString);
    procedure Set_NCM(Value: WideString);
    procedure Set_EXTIPI(Value: WideString);
    procedure Set_Genero(Value: WideString);
    procedure Set_CFOP(Value: WideString);
    procedure Set_UCom(Value: WideString);
    procedure Set_QCom(Value: WideString);
    procedure Set_VUnCom(Value: WideString);
    procedure Set_VProd(Value: WideString);
    procedure Set_CEANTrib(Value: WideString);
    procedure Set_UTrib(Value: WideString);
    procedure Set_QTrib(Value: WideString);
    procedure Set_VUnTrib(Value: WideString);
    procedure Set_VFrete(Value: WideString);
    procedure Set_VSeg(Value: WideString);
    procedure Set_VDesc(Value: WideString);
  public
    procedure AfterConstruction; override;
  end;

{ TXMLDI }

  TXMLDI = class(TXMLNode, IXMLDI)
  private
    FAdi: IXMLAdiList;
  protected
    { IXMLDI }
    function Get_NDI: WideString;
    function Get_DDI: WideString;
    function Get_XLocDesemb: WideString;
    function Get_UFDesemb: WideString;
    function Get_DDesemb: WideString;
    function Get_CExportador: WideString;
    function Get_Adi: IXMLAdiList;
    procedure Set_NDI(Value: WideString);
    procedure Set_DDI(Value: WideString);
    procedure Set_XLocDesemb(Value: WideString);
    procedure Set_UFDesemb(Value: WideString);
    procedure Set_DDesemb(Value: WideString);
    procedure Set_CExportador(Value: WideString);
  public
    procedure AfterConstruction; override;
  end;

{ TXMLDIList }

  TXMLDIList = class(TXMLNodeCollection, IXMLDIList)
  protected
    { IXMLDIList }
    function Add: IXMLDI;
    function Insert(const Index: Integer): IXMLDI;
    function Get_Item(Index: Integer): IXMLDI;
  end;

{ TXMLAdi }

  TXMLAdi = class(TXMLNode, IXMLAdi)
  protected
    { IXMLAdi }
    function Get_NAdicao: WideString;
    function Get_NSeqAdic: WideString;
    function Get_CFabricante: WideString;
    function Get_VDescDI: WideString;
    procedure Set_NAdicao(Value: WideString);
    procedure Set_NSeqAdic(Value: WideString);
    procedure Set_CFabricante(Value: WideString);
    procedure Set_VDescDI(Value: WideString);
  end;

{ TXMLAdiList }

  TXMLAdiList = class(TXMLNodeCollection, IXMLAdiList)
  protected
    { IXMLAdiList }
    function Add: IXMLAdi;
    function Insert(const Index: Integer): IXMLAdi;
    function Get_Item(Index: Integer): IXMLAdi;
  end;

{ TXMLVeicProd }

  TXMLVeicProd = class(TXMLNode, IXMLVeicProd)
  protected
    { IXMLVeicProd }
    function Get_TpOp: WideString;
    function Get_Chassi: WideString;
    function Get_CCor: WideString;
    function Get_XCor: WideString;
    function Get_Pot: WideString;
    function Get_CM3: WideString;
    function Get_PesoL: WideString;
    function Get_PesoB: WideString;
    function Get_NSerie: WideString;
    function Get_TpComb: WideString;
    function Get_NMotor: WideString;
    function Get_CMKG: WideString;
    function Get_Dist: WideString;
    function Get_RENAVAM: WideString;
    function Get_AnoMod: WideString;
    function Get_AnoFab: WideString;
    function Get_TpPint: WideString;
    function Get_TpVeic: WideString;
    function Get_EspVeic: WideString;
    function Get_VIN: WideString;
    function Get_CondVeic: WideString;
    function Get_CMod: WideString;
    procedure Set_TpOp(Value: WideString);
    procedure Set_Chassi(Value: WideString);
    procedure Set_CCor(Value: WideString);
    procedure Set_XCor(Value: WideString);
    procedure Set_Pot(Value: WideString);
    procedure Set_CM3(Value: WideString);
    procedure Set_PesoL(Value: WideString);
    procedure Set_PesoB(Value: WideString);
    procedure Set_NSerie(Value: WideString);
    procedure Set_TpComb(Value: WideString);
    procedure Set_NMotor(Value: WideString);
    procedure Set_CMKG(Value: WideString);
    procedure Set_Dist(Value: WideString);
    procedure Set_RENAVAM(Value: WideString);
    procedure Set_AnoMod(Value: WideString);
    procedure Set_AnoFab(Value: WideString);
    procedure Set_TpPint(Value: WideString);
    procedure Set_TpVeic(Value: WideString);
    procedure Set_EspVeic(Value: WideString);
    procedure Set_VIN(Value: WideString);
    procedure Set_CondVeic(Value: WideString);
    procedure Set_CMod(Value: WideString);
  end;

{ TXMLMed }

  TXMLMed = class(TXMLNode, IXMLMed)
  protected
    { IXMLMed }
    function Get_NLote: WideString;
    function Get_QLote: WideString;
    function Get_DFab: WideString;
    function Get_DVal: WideString;
    function Get_VPMC: WideString;
    procedure Set_NLote(Value: WideString);
    procedure Set_QLote(Value: WideString);
    procedure Set_DFab(Value: WideString);
    procedure Set_DVal(Value: WideString);
    procedure Set_VPMC(Value: WideString);
  end;

{ TXMLMedList }

  TXMLMedList = class(TXMLNodeCollection, IXMLMedList)
  protected
    { IXMLMedList }
    function Add: IXMLMed;
    function Insert(const Index: Integer): IXMLMed;
    function Get_Item(Index: Integer): IXMLMed;
  end;

{ TXMLArma }

  TXMLArma = class(TXMLNode, IXMLArma)
  protected
    { IXMLArma }
    function Get_TpArma: WideString;
    function Get_NSerie: WideString;
    function Get_NCano: WideString;
    function Get_Descr: WideString;
    procedure Set_TpArma(Value: WideString);
    procedure Set_NSerie(Value: WideString);
    procedure Set_NCano(Value: WideString);
    procedure Set_Descr(Value: WideString);
  end;

{ TXMLArmaList }

  TXMLArmaList = class(TXMLNodeCollection, IXMLArmaList)
  protected
    { IXMLArmaList }
    function Add: IXMLArma;
    function Insert(const Index: Integer): IXMLArma;
    function Get_Item(Index: Integer): IXMLArma;
  end;

{ TXMLComb }

  TXMLComb = class(TXMLNode, IXMLComb)
  protected
    { IXMLComb }
    function Get_CProdANP: WideString;
    function Get_CODIF: WideString;
    function Get_QTemp: WideString;
    function Get_CIDE: IXMLCIDE;
    function Get_ICMSComb: IXMLICMSComb;
    function Get_ICMSInter: IXMLICMSInter;
    function Get_ICMSCons: IXMLICMSCons;
    procedure Set_CProdANP(Value: WideString);
    procedure Set_CODIF(Value: WideString);
    procedure Set_QTemp(Value: WideString);
  public
    procedure AfterConstruction; override;
  end;

{ TXMLCIDE }

  TXMLCIDE = class(TXMLNode, IXMLCIDE)
  protected
    { IXMLCIDE }
    function Get_QBCProd: WideString;
    function Get_VAliqProd: WideString;
    function Get_VCIDE: WideString;
    procedure Set_QBCProd(Value: WideString);
    procedure Set_VAliqProd(Value: WideString);
    procedure Set_VCIDE(Value: WideString);
  end;

{ TXMLICMSComb }

  TXMLICMSComb = class(TXMLNode, IXMLICMSComb)
  protected
    { IXMLICMSComb }
    function Get_VBCICMS: WideString;
    function Get_VICMS: WideString;
    function Get_VBCICMSST: WideString;
    function Get_VICMSST: WideString;
    procedure Set_VBCICMS(Value: WideString);
    procedure Set_VICMS(Value: WideString);
    procedure Set_VBCICMSST(Value: WideString);
    procedure Set_VICMSST(Value: WideString);
  end;

{ TXMLICMSInter }

  TXMLICMSInter = class(TXMLNode, IXMLICMSInter)
  protected
    { IXMLICMSInter }
    function Get_VBCICMSSTDest: WideString;
    function Get_VICMSSTDest: WideString;
    procedure Set_VBCICMSSTDest(Value: WideString);
    procedure Set_VICMSSTDest(Value: WideString);
  end;

{ TXMLICMSCons }

  TXMLICMSCons = class(TXMLNode, IXMLICMSCons)
  protected
    { IXMLICMSCons }
    function Get_VBCICMSSTCons: WideString;
    function Get_VICMSSTCons: WideString;
    function Get_UFCons: WideString;
    procedure Set_VBCICMSSTCons(Value: WideString);
    procedure Set_VICMSSTCons(Value: WideString);
    procedure Set_UFCons(Value: WideString);
  end;

{ TXMLImposto }

  TXMLImposto = class(TXMLNode, IXMLImposto)
  protected
    { IXMLImposto }
    function Get_ICMS: IXMLICMS;
    function Get_IPI: IXMLIPI;
    function Get_II: IXMLII;
    function Get_PIS: IXMLPIS;
    function Get_PISST: IXMLPISST;
    function Get_COFINS: IXMLCOFINS;
    function Get_COFINSST: IXMLCOFINSST;
    function Get_ISSQN: IXMLISSQN;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLICMS }

  TXMLICMS = class(TXMLNode, IXMLICMS)
  protected
    { IXMLICMS }
    function Get_ICMS00: IXMLICMS00;
    function Get_ICMS10: IXMLICMS10;
    function Get_ICMS20: IXMLICMS20;
    function Get_ICMS30: IXMLICMS30;
    function Get_ICMS40: IXMLICMS40;
    function Get_ICMS51: IXMLICMS51;
    function Get_ICMS60: IXMLICMS60;
    function Get_ICMS70: IXMLICMS70;
    function Get_ICMS90: IXMLICMS90;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLICMS00 }

  TXMLICMS00 = class(TXMLNode, IXMLICMS00)
  protected
    { IXMLICMS00 }
    function Get_Orig: WideString;
    function Get_CST: WideString;
    function Get_ModBC: WideString;
    function Get_VBC: WideString;
    function Get_PICMS: WideString;
    function Get_VICMS: WideString;
    procedure Set_Orig(Value: WideString);
    procedure Set_CST(Value: WideString);
    procedure Set_ModBC(Value: WideString);
    procedure Set_VBC(Value: WideString);
    procedure Set_PICMS(Value: WideString);
    procedure Set_VICMS(Value: WideString);
  end;

{ TXMLICMS10 }

  TXMLICMS10 = class(TXMLNode, IXMLICMS10)
  protected
    { IXMLICMS10 }
    function Get_Orig: WideString;
    function Get_CST: WideString;
    function Get_ModBC: WideString;
    function Get_VBC: WideString;
    function Get_PICMS: WideString;
    function Get_VICMS: WideString;
    function Get_ModBCST: WideString;
    function Get_PMVAST: WideString;
    function Get_PRedBCST: WideString;
    function Get_VBCST: WideString;
    function Get_PICMSST: WideString;
    function Get_VICMSST: WideString;
    procedure Set_Orig(Value: WideString);
    procedure Set_CST(Value: WideString);
    procedure Set_ModBC(Value: WideString);
    procedure Set_VBC(Value: WideString);
    procedure Set_PICMS(Value: WideString);
    procedure Set_VICMS(Value: WideString);
    procedure Set_ModBCST(Value: WideString);
    procedure Set_PMVAST(Value: WideString);
    procedure Set_PRedBCST(Value: WideString);
    procedure Set_VBCST(Value: WideString);
    procedure Set_PICMSST(Value: WideString);
    procedure Set_VICMSST(Value: WideString);
  end;

{ TXMLICMS20 }

  TXMLICMS20 = class(TXMLNode, IXMLICMS20)
  protected
    { IXMLICMS20 }
    function Get_Orig: WideString;
    function Get_CST: WideString;
    function Get_ModBC: WideString;
    function Get_PRedBC: WideString;
    function Get_VBC: WideString;
    function Get_PICMS: WideString;
    function Get_VICMS: WideString;
    procedure Set_Orig(Value: WideString);
    procedure Set_CST(Value: WideString);
    procedure Set_ModBC(Value: WideString);
    procedure Set_PRedBC(Value: WideString);
    procedure Set_VBC(Value: WideString);
    procedure Set_PICMS(Value: WideString);
    procedure Set_VICMS(Value: WideString);
  end;

{ TXMLICMS30 }

  TXMLICMS30 = class(TXMLNode, IXMLICMS30)
  protected
    { IXMLICMS30 }
    function Get_Orig: WideString;
    function Get_CST: WideString;
    function Get_ModBCST: WideString;
    function Get_PMVAST: WideString;
    function Get_PRedBCST: WideString;
    function Get_VBCST: WideString;
    function Get_PICMSST: WideString;
    function Get_VICMSST: WideString;
    procedure Set_Orig(Value: WideString);
    procedure Set_CST(Value: WideString);
    procedure Set_ModBCST(Value: WideString);
    procedure Set_PMVAST(Value: WideString);
    procedure Set_PRedBCST(Value: WideString);
    procedure Set_VBCST(Value: WideString);
    procedure Set_PICMSST(Value: WideString);
    procedure Set_VICMSST(Value: WideString);
  end;

{ TXMLICMS40 }

  TXMLICMS40 = class(TXMLNode, IXMLICMS40)
  protected
    { IXMLICMS40 }
    function Get_Orig: WideString;
    function Get_CST: WideString;
    procedure Set_Orig(Value: WideString);
    procedure Set_CST(Value: WideString);
  end;

{ TXMLICMS51 }

  TXMLICMS51 = class(TXMLNode, IXMLICMS51)
  protected
    { IXMLICMS51 }
    function Get_Orig: WideString;
    function Get_CST: WideString;
    function Get_ModBC: WideString;
    function Get_PRedBC: WideString;
    function Get_VBC: WideString;
    function Get_PICMS: WideString;
    function Get_VICMS: WideString;
    procedure Set_Orig(Value: WideString);
    procedure Set_CST(Value: WideString);
    procedure Set_ModBC(Value: WideString);
    procedure Set_PRedBC(Value: WideString);
    procedure Set_VBC(Value: WideString);
    procedure Set_PICMS(Value: WideString);
    procedure Set_VICMS(Value: WideString);
  end;

{ TXMLICMS60 }

  TXMLICMS60 = class(TXMLNode, IXMLICMS60)
  protected
    { IXMLICMS60 }
    function Get_Orig: WideString;
    function Get_CST: WideString;
    function Get_VBCST: WideString;
    function Get_VICMSST: WideString;
    procedure Set_Orig(Value: WideString);
    procedure Set_CST(Value: WideString);
    procedure Set_VBCST(Value: WideString);
    procedure Set_VICMSST(Value: WideString);
  end;

{ TXMLICMS70 }

  TXMLICMS70 = class(TXMLNode, IXMLICMS70)
  protected
    { IXMLICMS70 }
    function Get_Orig: WideString;
    function Get_CST: WideString;
    function Get_ModBC: WideString;
    function Get_PRedBC: WideString;
    function Get_VBC: WideString;
    function Get_PICMS: WideString;
    function Get_VICMS: WideString;
    function Get_ModBCST: WideString;
    function Get_PMVAST: WideString;
    function Get_PRedBCST: WideString;
    function Get_VBCST: WideString;
    function Get_PICMSST: WideString;
    function Get_VICMSST: WideString;
    procedure Set_Orig(Value: WideString);
    procedure Set_CST(Value: WideString);
    procedure Set_ModBC(Value: WideString);
    procedure Set_PRedBC(Value: WideString);
    procedure Set_VBC(Value: WideString);
    procedure Set_PICMS(Value: WideString);
    procedure Set_VICMS(Value: WideString);
    procedure Set_ModBCST(Value: WideString);
    procedure Set_PMVAST(Value: WideString);
    procedure Set_PRedBCST(Value: WideString);
    procedure Set_VBCST(Value: WideString);
    procedure Set_PICMSST(Value: WideString);
    procedure Set_VICMSST(Value: WideString);
  end;

{ TXMLICMS90 }

  TXMLICMS90 = class(TXMLNode, IXMLICMS90)
  protected
    { IXMLICMS90 }
    function Get_Orig: WideString;
    function Get_CST: WideString;
    function Get_ModBC: WideString;
    function Get_VBC: WideString;
    function Get_PRedBC: WideString;
    function Get_PICMS: WideString;
    function Get_VICMS: WideString;
    function Get_ModBCST: WideString;
    function Get_PMVAST: WideString;
    function Get_PRedBCST: WideString;
    function Get_VBCST: WideString;
    function Get_PICMSST: WideString;
    function Get_VICMSST: WideString;
    procedure Set_Orig(Value: WideString);
    procedure Set_CST(Value: WideString);
    procedure Set_ModBC(Value: WideString);
    procedure Set_VBC(Value: WideString);
    procedure Set_PRedBC(Value: WideString);
    procedure Set_PICMS(Value: WideString);
    procedure Set_VICMS(Value: WideString);
    procedure Set_ModBCST(Value: WideString);
    procedure Set_PMVAST(Value: WideString);
    procedure Set_PRedBCST(Value: WideString);
    procedure Set_VBCST(Value: WideString);
    procedure Set_PICMSST(Value: WideString);
    procedure Set_VICMSST(Value: WideString);
  end;

{ TXMLIPI }

  TXMLIPI = class(TXMLNode, IXMLIPI)
  protected
    { IXMLIPI }
    function Get_ClEnq: WideString;
    function Get_CNPJProd: WideString;
    function Get_CSelo: WideString;
    function Get_QSelo: WideString;
    function Get_CEnq: WideString;
    function Get_IPITrib: IXMLIPITrib;
    function Get_IPINT: IXMLIPINT;
    procedure Set_ClEnq(Value: WideString);
    procedure Set_CNPJProd(Value: WideString);
    procedure Set_CSelo(Value: WideString);
    procedure Set_QSelo(Value: WideString);
    procedure Set_CEnq(Value: WideString);
  public
    procedure AfterConstruction; override;
  end;

{ TXMLIPITrib }

  TXMLIPITrib = class(TXMLNode, IXMLIPITrib)
  protected
    { IXMLIPITrib }
    function Get_CST: WideString;
    function Get_VBC: WideString;
    function Get_PIPI: WideString;
    function Get_QUnid: WideString;
    function Get_VUnid: WideString;
    function Get_VIPI: WideString;
    procedure Set_CST(Value: WideString);
    procedure Set_VBC(Value: WideString);
    procedure Set_PIPI(Value: WideString);
    procedure Set_QUnid(Value: WideString);
    procedure Set_VUnid(Value: WideString);
    procedure Set_VIPI(Value: WideString);
  end;

{ TXMLIPINT }

  TXMLIPINT = class(TXMLNode, IXMLIPINT)
  protected
    { IXMLIPINT }
    function Get_CST: WideString;
    procedure Set_CST(Value: WideString);
  end;

{ TXMLII }

  TXMLII = class(TXMLNode, IXMLII)
  protected
    { IXMLII }
    function Get_VBC: WideString;
    function Get_VDespAdu: WideString;
    function Get_VII: WideString;
    function Get_VIOF: WideString;
    procedure Set_VBC(Value: WideString);
    procedure Set_VDespAdu(Value: WideString);
    procedure Set_VII(Value: WideString);
    procedure Set_VIOF(Value: WideString);
  end;

{ TXMLPIS }

  TXMLPIS = class(TXMLNode, IXMLPIS)
  protected
    { IXMLPIS }
    function Get_PISAliq: IXMLPISAliq;
    function Get_PISQtde: IXMLPISQtde;
    function Get_PISNT: IXMLPISNT;
    function Get_PISOutr: IXMLPISOutr;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLPISAliq }

  TXMLPISAliq = class(TXMLNode, IXMLPISAliq)
  protected
    { IXMLPISAliq }
    function Get_CST: WideString;
    function Get_VBC: WideString;
    function Get_PPIS: WideString;
    function Get_VPIS: WideString;
    procedure Set_CST(Value: WideString);
    procedure Set_VBC(Value: WideString);
    procedure Set_PPIS(Value: WideString);
    procedure Set_VPIS(Value: WideString);
  end;

{ TXMLPISQtde }

  TXMLPISQtde = class(TXMLNode, IXMLPISQtde)
  protected
    { IXMLPISQtde }
    function Get_CST: WideString;
    function Get_QBCProd: WideString;
    function Get_VAliqProd: WideString;
    function Get_VPIS: WideString;
    procedure Set_CST(Value: WideString);
    procedure Set_QBCProd(Value: WideString);
    procedure Set_VAliqProd(Value: WideString);
    procedure Set_VPIS(Value: WideString);
  end;

{ TXMLPISNT }

  TXMLPISNT = class(TXMLNode, IXMLPISNT)
  protected
    { IXMLPISNT }
    function Get_CST: WideString;
    procedure Set_CST(Value: WideString);
  end;

{ TXMLPISOutr }

  TXMLPISOutr = class(TXMLNode, IXMLPISOutr)
  protected
    { IXMLPISOutr }
    function Get_CST: WideString;
    function Get_VBC: WideString;
    function Get_PPIS: WideString;
    function Get_QBCProd: WideString;
    function Get_VAliqProd: WideString;
    function Get_VPIS: WideString;
    procedure Set_CST(Value: WideString);
    procedure Set_VBC(Value: WideString);
    procedure Set_PPIS(Value: WideString);
    procedure Set_QBCProd(Value: WideString);
    procedure Set_VAliqProd(Value: WideString);
    procedure Set_VPIS(Value: WideString);
  end;

{ TXMLPISST }

  TXMLPISST = class(TXMLNode, IXMLPISST)
  protected
    { IXMLPISST }
    function Get_VBC: WideString;
    function Get_PPIS: WideString;
    function Get_QBCProd: WideString;
    function Get_VAliqProd: WideString;
    function Get_VPIS: WideString;
    procedure Set_VBC(Value: WideString);
    procedure Set_PPIS(Value: WideString);
    procedure Set_QBCProd(Value: WideString);
    procedure Set_VAliqProd(Value: WideString);
    procedure Set_VPIS(Value: WideString);
  end;

{ TXMLCOFINS }

  TXMLCOFINS = class(TXMLNode, IXMLCOFINS)
  protected
    { IXMLCOFINS }
    function Get_COFINSAliq: IXMLCOFINSAliq;
    function Get_COFINSQtde: IXMLCOFINSQtde;
    function Get_COFINSNT: IXMLCOFINSNT;
    function Get_COFINSOutr: IXMLCOFINSOutr;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLCOFINSAliq }

  TXMLCOFINSAliq = class(TXMLNode, IXMLCOFINSAliq)
  protected
    { IXMLCOFINSAliq }
    function Get_CST: WideString;
    function Get_VBC: WideString;
    function Get_PCOFINS: WideString;
    function Get_VCOFINS: WideString;
    procedure Set_CST(Value: WideString);
    procedure Set_VBC(Value: WideString);
    procedure Set_PCOFINS(Value: WideString);
    procedure Set_VCOFINS(Value: WideString);
  end;

{ TXMLCOFINSQtde }

  TXMLCOFINSQtde = class(TXMLNode, IXMLCOFINSQtde)
  protected
    { IXMLCOFINSQtde }
    function Get_CST: WideString;
    function Get_QBCProd: WideString;
    function Get_VAliqProd: WideString;
    function Get_VCOFINS: WideString;
    procedure Set_CST(Value: WideString);
    procedure Set_QBCProd(Value: WideString);
    procedure Set_VAliqProd(Value: WideString);
    procedure Set_VCOFINS(Value: WideString);
  end;

{ TXMLCOFINSNT }

  TXMLCOFINSNT = class(TXMLNode, IXMLCOFINSNT)
  protected
    { IXMLCOFINSNT }
    function Get_CST: WideString;
    procedure Set_CST(Value: WideString);
  end;

{ TXMLCOFINSOutr }

  TXMLCOFINSOutr = class(TXMLNode, IXMLCOFINSOutr)
  protected
    { IXMLCOFINSOutr }
    function Get_CST: WideString;
    function Get_VBC: WideString;
    function Get_PCOFINS: WideString;
    function Get_QBCProd: WideString;
    function Get_VAliqProd: WideString;
    function Get_VCOFINS: WideString;
    procedure Set_CST(Value: WideString);
    procedure Set_VBC(Value: WideString);
    procedure Set_PCOFINS(Value: WideString);
    procedure Set_QBCProd(Value: WideString);
    procedure Set_VAliqProd(Value: WideString);
    procedure Set_VCOFINS(Value: WideString);
  end;

{ TXMLCOFINSST }

  TXMLCOFINSST = class(TXMLNode, IXMLCOFINSST)
  protected
    { IXMLCOFINSST }
    function Get_VBC: WideString;
    function Get_PCOFINS: WideString;
    function Get_QBCProd: WideString;
    function Get_VAliqProd: WideString;
    function Get_VCOFINS: WideString;
    procedure Set_VBC(Value: WideString);
    procedure Set_PCOFINS(Value: WideString);
    procedure Set_QBCProd(Value: WideString);
    procedure Set_VAliqProd(Value: WideString);
    procedure Set_VCOFINS(Value: WideString);
  end;

{ TXMLISSQN }

  TXMLISSQN = class(TXMLNode, IXMLISSQN)
  protected
    { IXMLISSQN }
    function Get_VBC: WideString;
    function Get_VAliq: WideString;
    function Get_VISSQN: WideString;
    function Get_CMunFG: WideString;
    function Get_CListServ: WideString;
    procedure Set_VBC(Value: WideString);
    procedure Set_VAliq(Value: WideString);
    procedure Set_VISSQN(Value: WideString);
    procedure Set_CMunFG(Value: WideString);
    procedure Set_CListServ(Value: WideString);
  end;

{ TXMLTotal }

  TXMLTotal = class(TXMLNode, IXMLTotal)
  protected
    { IXMLTotal }
    function Get_ICMSTot: IXMLICMSTot;
    function Get_ISSQNtot: IXMLISSQNtot;
    function Get_RetTrib: IXMLRetTrib;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLICMSTot }

  TXMLICMSTot = class(TXMLNode, IXMLICMSTot)
  protected
    { IXMLICMSTot }
    function Get_VBC: WideString;
    function Get_VICMS: WideString;
    function Get_VBCST: WideString;
    function Get_VST: WideString;
    function Get_VProd: WideString;
    function Get_VFrete: WideString;
    function Get_VSeg: WideString;
    function Get_VDesc: WideString;
    function Get_VII: WideString;
    function Get_VIPI: WideString;
    function Get_VPIS: WideString;
    function Get_VCOFINS: WideString;
    function Get_VOutro: WideString;
    function Get_VNF: WideString;
    procedure Set_VBC(Value: WideString);
    procedure Set_VICMS(Value: WideString);
    procedure Set_VBCST(Value: WideString);
    procedure Set_VST(Value: WideString);
    procedure Set_VProd(Value: WideString);
    procedure Set_VFrete(Value: WideString);
    procedure Set_VSeg(Value: WideString);
    procedure Set_VDesc(Value: WideString);
    procedure Set_VII(Value: WideString);
    procedure Set_VIPI(Value: WideString);
    procedure Set_VPIS(Value: WideString);
    procedure Set_VCOFINS(Value: WideString);
    procedure Set_VOutro(Value: WideString);
    procedure Set_VNF(Value: WideString);
  end;

{ TXMLISSQNtot }

  TXMLISSQNtot = class(TXMLNode, IXMLISSQNtot)
  protected
    { IXMLISSQNtot }
    function Get_VServ: WideString;
    function Get_VBC: WideString;
    function Get_VISS: WideString;
    function Get_VPIS: WideString;
    function Get_VCOFINS: WideString;
    procedure Set_VServ(Value: WideString);
    procedure Set_VBC(Value: WideString);
    procedure Set_VISS(Value: WideString);
    procedure Set_VPIS(Value: WideString);
    procedure Set_VCOFINS(Value: WideString);
  end;

{ TXMLRetTrib }

  TXMLRetTrib = class(TXMLNode, IXMLRetTrib)
  protected
    { IXMLRetTrib }
    function Get_VRetPIS: WideString;
    function Get_VRetCOFINS: WideString;
    function Get_VRetCSLL: WideString;
    function Get_VBCIRRF: WideString;
    function Get_VIRRF: WideString;
    function Get_VBCRetPrev: WideString;
    function Get_VRetPrev: WideString;
    procedure Set_VRetPIS(Value: WideString);
    procedure Set_VRetCOFINS(Value: WideString);
    procedure Set_VRetCSLL(Value: WideString);
    procedure Set_VBCIRRF(Value: WideString);
    procedure Set_VIRRF(Value: WideString);
    procedure Set_VBCRetPrev(Value: WideString);
    procedure Set_VRetPrev(Value: WideString);
  end;

{ TXMLTransp }

  TXMLTransp = class(TXMLNode, IXMLTransp)
  private
    FReboque: IXMLTVeiculoList;
    FVol: IXMLVolList;
  protected
    { IXMLTransp }
    function Get_ModFrete: WideString;
    function Get_Transporta: IXMLTransporta;
    function Get_RetTransp: IXMLRetTransp;
    function Get_VeicTransp: IXMLTVeiculo;
    function Get_Reboque: IXMLTVeiculoList;
    function Get_Vol: IXMLVolList;
    procedure Set_ModFrete(Value: WideString);
  public
    procedure AfterConstruction; override;
  end;

{ TXMLTransporta }

  TXMLTransporta = class(TXMLNode, IXMLTransporta)
  protected
    { IXMLTransporta }
    function Get_CNPJ: WideString;
    function Get_CPF: WideString;
    function Get_XNome: WideString;
    function Get_IE: WideString;
    function Get_XEnder: WideString;
    function Get_XMun: WideString;
    function Get_UF: WideString;
    procedure Set_CNPJ(Value: WideString);
    procedure Set_CPF(Value: WideString);
    procedure Set_XNome(Value: WideString);
    procedure Set_IE(Value: WideString);
    procedure Set_XEnder(Value: WideString);
    procedure Set_XMun(Value: WideString);
    procedure Set_UF(Value: WideString);
  end;

{ TXMLRetTransp }

  TXMLRetTransp = class(TXMLNode, IXMLRetTransp)
  protected
    { IXMLRetTransp }
    function Get_VServ: WideString;
    function Get_VBCRet: WideString;
    function Get_PICMSRet: WideString;
    function Get_VICMSRet: WideString;
    function Get_CFOP: WideString;
    function Get_CMunFG: WideString;
    procedure Set_VServ(Value: WideString);
    procedure Set_VBCRet(Value: WideString);
    procedure Set_PICMSRet(Value: WideString);
    procedure Set_VICMSRet(Value: WideString);
    procedure Set_CFOP(Value: WideString);
    procedure Set_CMunFG(Value: WideString);
  end;

{ TXMLTVeiculo }

  TXMLTVeiculo = class(TXMLNode, IXMLTVeiculo)
  protected
    { IXMLTVeiculo }
    function Get_Placa: WideString;
    function Get_UF: WideString;
    function Get_RNTC: WideString;
    procedure Set_Placa(Value: WideString);
    procedure Set_UF(Value: WideString);
    procedure Set_RNTC(Value: WideString);
  end;

{ TXMLTVeiculoList }

  TXMLTVeiculoList = class(TXMLNodeCollection, IXMLTVeiculoList)
  protected
    { IXMLTVeiculoList }
    function Add: IXMLTVeiculo;
    function Insert(const Index: Integer): IXMLTVeiculo;
    function Get_Item(Index: Integer): IXMLTVeiculo;
  end;

{ TXMLVol }

  TXMLVol = class(TXMLNode, IXMLVol)
  private
    FLacres: IXMLLacresList;
  protected
    { IXMLVol }
    function Get_QVol: WideString;
    function Get_Esp: WideString;
    function Get_Marca: WideString;
    function Get_NVol: WideString;
    function Get_PesoL: WideString;
    function Get_PesoB: WideString;
    function Get_Lacres: IXMLLacresList;
    procedure Set_QVol(Value: WideString);
    procedure Set_Esp(Value: WideString);
    procedure Set_Marca(Value: WideString);
    procedure Set_NVol(Value: WideString);
    procedure Set_PesoL(Value: WideString);
    procedure Set_PesoB(Value: WideString);
  public
    procedure AfterConstruction; override;
  end;

{ TXMLVolList }

  TXMLVolList = class(TXMLNodeCollection, IXMLVolList)
  protected
    { IXMLVolList }
    function Add: IXMLVol;
    function Insert(const Index: Integer): IXMLVol;
    function Get_Item(Index: Integer): IXMLVol;
  end;

{ TXMLLacres }

  TXMLLacres = class(TXMLNode, IXMLLacres)
  protected
    { IXMLLacres }
    function Get_NLacre: WideString;
    procedure Set_NLacre(Value: WideString);
  end;

{ TXMLLacresList }

  TXMLLacresList = class(TXMLNodeCollection, IXMLLacresList)
  protected
    { IXMLLacresList }
    function Add: IXMLLacres;
    function Insert(const Index: Integer): IXMLLacres;
    function Get_Item(Index: Integer): IXMLLacres;
  end;

{ TXMLCobr }

  TXMLCobr = class(TXMLNode, IXMLCobr)
  private
    FDup: IXMLDupList;
  protected
    { IXMLCobr }
    function Get_Fat: IXMLFat;
    function Get_Dup: IXMLDupList;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLFat }

  TXMLFat = class(TXMLNode, IXMLFat)
  protected
    { IXMLFat }
    function Get_NFat: WideString;
    function Get_VOrig: WideString;
    function Get_VDesc: WideString;
    function Get_VLiq: WideString;
    procedure Set_NFat(Value: WideString);
    procedure Set_VOrig(Value: WideString);
    procedure Set_VDesc(Value: WideString);
    procedure Set_VLiq(Value: WideString);
  end;

{ TXMLDup }

  TXMLDup = class(TXMLNode, IXMLDup)
  protected
    { IXMLDup }
    function Get_NDup: WideString;
    function Get_DVenc: WideString;
    function Get_VDup: WideString;
    procedure Set_NDup(Value: WideString);
    procedure Set_DVenc(Value: WideString);
    procedure Set_VDup(Value: WideString);
  end;

{ TXMLDupList }

  TXMLDupList = class(TXMLNodeCollection, IXMLDupList)
  protected
    { IXMLDupList }
    function Add: IXMLDup;
    function Insert(const Index: Integer): IXMLDup;
    function Get_Item(Index: Integer): IXMLDup;
  end;

{ TXMLInfAdic }

  TXMLInfAdic = class(TXMLNode, IXMLInfAdic)
  private
    FProcRef: IXMLProcRefList;
  protected
    { IXMLInfAdic }
    function Get_InfAdFisco: WideString;
    function Get_InfCpl: WideString;
    function Get_ObsCont: IXMLObsCont;
    function Get_ObsFisco: IXMLObsFisco;
    function Get_ProcRef: IXMLProcRefList;
    procedure Set_InfAdFisco(Value: WideString);
    procedure Set_InfCpl(Value: WideString);
  public
    procedure AfterConstruction; override;
  end;

{ TXMLObsCont }

  TXMLObsCont = class(TXMLNode, IXMLObsCont)
  protected
    { IXMLObsCont }
    function Get_XCampo: WideString;
    function Get_XTexto: WideString;
    procedure Set_XCampo(Value: WideString);
    procedure Set_XTexto(Value: WideString);
  end;

{ TXMLObsFisco }

  TXMLObsFisco = class(TXMLNode, IXMLObsFisco)
  protected
    { IXMLObsFisco }
    function Get_XCampo: WideString;
    function Get_XTexto: WideString;
    procedure Set_XCampo(Value: WideString);
    procedure Set_XTexto(Value: WideString);
  end;

{ TXMLProcRef }

  TXMLProcRef = class(TXMLNode, IXMLProcRef)
  protected
    { IXMLProcRef }
    function Get_NProc: WideString;
    function Get_IndProc: WideString;
    procedure Set_NProc(Value: WideString);
    procedure Set_IndProc(Value: WideString);
  end;

{ TXMLProcRefList }

  TXMLProcRefList = class(TXMLNodeCollection, IXMLProcRefList)
  protected
    { IXMLProcRefList }
    function Add: IXMLProcRef;
    function Insert(const Index: Integer): IXMLProcRef;
    function Get_Item(Index: Integer): IXMLProcRef;
  end;

{ TXMLExporta }

  TXMLExporta = class(TXMLNode, IXMLExporta)
  protected
    { IXMLExporta }
    function Get_UFEmbarq: WideString;
    function Get_XLocEmbarq: WideString;
    procedure Set_UFEmbarq(Value: WideString);
    procedure Set_XLocEmbarq(Value: WideString);
  end;

{ TXMLCompra }

  TXMLCompra = class(TXMLNode, IXMLCompra)
  protected
    { IXMLCompra }
    function Get_XNEmp: WideString;
    function Get_XPed: WideString;
    function Get_XCont: WideString;
    procedure Set_XNEmp(Value: WideString);
    procedure Set_XPed(Value: WideString);
    procedure Set_XCont(Value: WideString);
  end;

{ TXMLSignatureType }

  TXMLSignatureType = class(TXMLNode, IXMLSignatureType)
  protected
    { IXMLSignatureType }
    function Get_Id: WideString;
    function Get_SignedInfo: IXMLSignedInfoType;
    function Get_SignatureValue: IXMLSignatureValueType;
    function Get_KeyInfo: IXMLKeyInfoType;
    procedure Set_Id(Value: WideString);
  public
    procedure AfterConstruction; override;
  end;

{ TXMLSignedInfoType }

  TXMLSignedInfoType = class(TXMLNode, IXMLSignedInfoType)
  protected
    { IXMLSignedInfoType }
    function Get_Id: WideString;
    function Get_CanonicalizationMethod: IXMLCanonicalizationMethod;
    function Get_SignatureMethod: IXMLSignatureMethod;
    function Get_Reference: IXMLReferenceType;
    procedure Set_Id(Value: WideString);
  public
    procedure AfterConstruction; override;
  end;

{ TXMLCanonicalizationMethod }

  TXMLCanonicalizationMethod = class(TXMLNode, IXMLCanonicalizationMethod)
  protected
    { IXMLCanonicalizationMethod }
    function Get_Algorithm: WideString;
    procedure Set_Algorithm(Value: WideString);
  end;

{ TXMLSignatureMethod }

  TXMLSignatureMethod = class(TXMLNode, IXMLSignatureMethod)
  protected
    { IXMLSignatureMethod }
    function Get_Algorithm: WideString;
    procedure Set_Algorithm(Value: WideString);
  end;

{ TXMLReferenceType }

  TXMLReferenceType = class(TXMLNode, IXMLReferenceType)
  protected
    { IXMLReferenceType }
    function Get_Id: WideString;
    function Get_URI: WideString;
    function Get_Type_: WideString;
    function Get_Transforms: IXMLTransformsType;
    function Get_DigestMethod: IXMLDigestMethod;
    function Get_DigestValue: WideString;
    procedure Set_Id(Value: WideString);
    procedure Set_URI(Value: WideString);
    procedure Set_Type_(Value: WideString);
    procedure Set_DigestValue(Value: WideString);
  public
    procedure AfterConstruction; override;
  end;

{ TXMLTransformsType }

  TXMLTransformsType = class(TXMLNodeCollection, IXMLTransformsType)
  protected
    { IXMLTransformsType }
    function Get_Transform(Index: Integer): IXMLTransformType;
    function Add: IXMLTransformType;
    function Insert(const Index: Integer): IXMLTransformType;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLTransformType }

  TXMLTransformType = class(TXMLNodeCollection, IXMLTransformType)
  protected
    { IXMLTransformType }
    function Get_Algorithm: WideString;
    function Get_XPath(Index: Integer): WideString;
    procedure Set_Algorithm(Value: WideString);
    function Add(const XPath: WideString): IXMLNode;
    function Insert(const Index: Integer; const XPath: WideString): IXMLNode;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLDigestMethod }

  TXMLDigestMethod = class(TXMLNode, IXMLDigestMethod)
  protected
    { IXMLDigestMethod }
    function Get_Algorithm: WideString;
    procedure Set_Algorithm(Value: WideString);
  end;

{ TXMLSignatureValueType }

  TXMLSignatureValueType = class(TXMLNode, IXMLSignatureValueType)
  protected
    { IXMLSignatureValueType }
    function Get_Id: WideString;
    procedure Set_Id(Value: WideString);
  end;

{ TXMLKeyInfoType }

  TXMLKeyInfoType = class(TXMLNode, IXMLKeyInfoType)
  protected
    { IXMLKeyInfoType }
    function Get_Id: WideString;
    function Get_X509Data: IXMLX509DataType;
    procedure Set_Id(Value: WideString);
  public
    procedure AfterConstruction; override;
  end;

{ TXMLX509DataType }

  TXMLX509DataType = class(TXMLNode, IXMLX509DataType)
  protected
    { IXMLX509DataType }
    function Get_X509Certificate: WideString;
    procedure Set_X509Certificate(Value: WideString);
  end;

{ Global Functions }

function GetenviNFe(Doc: IXMLDocument): IXMLTEnviNFe;
function LoadenviNFe(const FileName: WideString): IXMLTEnviNFe;
function NewenviNFe: IXMLTEnviNFe;

const
  TargetNamespace = 'http://www.portalfiscal.inf.br/nfe';

implementation

{ Global Functions }

function GetenviNFe(Doc: IXMLDocument): IXMLTEnviNFe;
begin
  Result := Doc.GetDocBinding('enviNFe', TXMLTEnviNFe, TargetNamespace) as IXMLTEnviNFe;
end;

function LoadenviNFe(const FileName: WideString): IXMLTEnviNFe;
begin
  Result := LoadXMLDocument(FileName).GetDocBinding('enviNFe', TXMLTEnviNFe, TargetNamespace) as IXMLTEnviNFe;
end;

function NewenviNFe: IXMLTEnviNFe;
begin
  Result := NewXMLDocument.GetDocBinding('enviNFe', TXMLTEnviNFe, TargetNamespace) as IXMLTEnviNFe;
end;

{ TXMLTEnviNFe }

procedure TXMLTEnviNFe.AfterConstruction;
begin
  RegisterChildNode('NFe', TXMLTNFe);
  FNFe := CreateCollection(TXMLTNFeList, IXMLTNFe, 'NFe') as IXMLTNFeList;
  inherited;
end;

function TXMLTEnviNFe.Get_Versao: WideString;
begin
  Result := AttributeNodes['versao'].Text;
end;

procedure TXMLTEnviNFe.Set_Versao(Value: WideString);
begin
  SetAttribute('versao', Value);
end;

function TXMLTEnviNFe.Get_IdLote: WideString;
begin
  Result := ChildNodes['idLote'].Text;
end;

procedure TXMLTEnviNFe.Set_IdLote(Value: WideString);
begin
  ChildNodes['idLote'].NodeValue := Value;
end;

function TXMLTEnviNFe.Get_NFe: IXMLTNFeList;
begin
  Result := FNFe;
end;

{ TXMLTNFe }

procedure TXMLTNFe.AfterConstruction;
begin
  RegisterChildNode('infNFe', TXMLInfNFe);
  RegisterChildNode('Signature', TXMLSignatureType);
  inherited;
end;

function TXMLTNFe.Get_InfNFe: IXMLInfNFe;
begin
  Result := ChildNodes['infNFe'] as IXMLInfNFe;
end;

function TXMLTNFe.Get_Signature: IXMLSignatureType;
begin
  Result := ChildNodes['Signature'] as IXMLSignatureType;
end;

{ TXMLTNFeList }

function TXMLTNFeList.Add: IXMLTNFe;
begin
  Result := AddItem(-1) as IXMLTNFe;
end;

function TXMLTNFeList.Insert(const Index: Integer): IXMLTNFe;
begin
  Result := AddItem(Index) as IXMLTNFe;
end;
function TXMLTNFeList.Get_Item(Index: Integer): IXMLTNFe;
begin
  Result := List[Index] as IXMLTNFe;
end;

{ TXMLInfNFe }

procedure TXMLInfNFe.AfterConstruction;
begin
  RegisterChildNode('ide', TXMLIde);
  RegisterChildNode('emit', TXMLEmit);
  RegisterChildNode('avulsa', TXMLAvulsa);
  RegisterChildNode('dest', TXMLDest);
  RegisterChildNode('retirada', TXMLTLocal);
  RegisterChildNode('entrega', TXMLTLocal);
  RegisterChildNode('det', TXMLDet);
  RegisterChildNode('total', TXMLTotal);
  RegisterChildNode('transp', TXMLTransp);
  RegisterChildNode('cobr', TXMLCobr);
  RegisterChildNode('infAdic', TXMLInfAdic);
  RegisterChildNode('exporta', TXMLExporta);
  RegisterChildNode('compra', TXMLCompra);
  FDet := CreateCollection(TXMLDetList, IXMLDet, 'det') as IXMLDetList;
  inherited;
end;

function TXMLInfNFe.Get_Versao: WideString;
begin
  Result := AttributeNodes['versao'].Text;
end;

procedure TXMLInfNFe.Set_Versao(Value: WideString);
begin
  SetAttribute('versao', Value);
end;

function TXMLInfNFe.Get_Id: WideString;
begin
  Result := AttributeNodes['Id'].Text;
end;

procedure TXMLInfNFe.Set_Id(Value: WideString);
begin
  SetAttribute('Id', Value);
end;

function TXMLInfNFe.Get_Ide: IXMLIde;
begin
  Result := ChildNodes['ide'] as IXMLIde;
end;

function TXMLInfNFe.Get_Emit: IXMLEmit;
begin
  Result := ChildNodes['emit'] as IXMLEmit;
end;

function TXMLInfNFe.Get_Avulsa: IXMLAvulsa;
begin
  Result := ChildNodes['avulsa'] as IXMLAvulsa;
end;

function TXMLInfNFe.Get_Dest: IXMLDest;
begin
  Result := ChildNodes['dest'] as IXMLDest;
end;

function TXMLInfNFe.Get_Retirada: IXMLTLocal;
begin
  Result := ChildNodes['retirada'] as IXMLTLocal;
end;

function TXMLInfNFe.Get_Entrega: IXMLTLocal;
begin
  Result := ChildNodes['entrega'] as IXMLTLocal;
end;

function TXMLInfNFe.Get_Det: IXMLDetList;
begin
  Result := FDet;
end;

function TXMLInfNFe.Get_Total: IXMLTotal;
begin
  Result := ChildNodes['total'] as IXMLTotal;
end;

function TXMLInfNFe.Get_Transp: IXMLTransp;
begin
  Result := ChildNodes['transp'] as IXMLTransp;
end;

function TXMLInfNFe.Get_Cobr: IXMLCobr;
begin
  Result := ChildNodes['cobr'] as IXMLCobr;
end;

function TXMLInfNFe.Get_InfAdic: IXMLInfAdic;
begin
  Result := ChildNodes['infAdic'] as IXMLInfAdic;
end;

function TXMLInfNFe.Get_Exporta: IXMLExporta;
begin
  Result := ChildNodes['exporta'] as IXMLExporta;
end;

function TXMLInfNFe.Get_Compra: IXMLCompra;
begin
  Result := ChildNodes['compra'] as IXMLCompra;
end;

{ TXMLIde }

procedure TXMLIde.AfterConstruction;
begin
  RegisterChildNode('NFref', TXMLNFref);
  FNFref := CreateCollection(TXMLNFrefList, IXMLNFref, 'NFref') as IXMLNFrefList;
  inherited;
end;

function TXMLIde.Get_CUF: WideString;
begin
  Result := ChildNodes['cUF'].Text;
end;

procedure TXMLIde.Set_CUF(Value: WideString);
begin
  ChildNodes['cUF'].NodeValue := Value;
end;

function TXMLIde.Get_CNF: WideString;
begin
  Result := ChildNodes['cNF'].Text;
end;

procedure TXMLIde.Set_CNF(Value: WideString);
begin
  ChildNodes['cNF'].NodeValue := Value;
end;

function TXMLIde.Get_NatOp: WideString;
begin
  Result := ChildNodes['natOp'].Text;
end;

procedure TXMLIde.Set_NatOp(Value: WideString);
begin
  ChildNodes['natOp'].NodeValue := Value;
end;

function TXMLIde.Get_IndPag: WideString;
begin
  Result := ChildNodes['indPag'].Text;
end;

procedure TXMLIde.Set_IndPag(Value: WideString);
begin
  ChildNodes['indPag'].NodeValue := Value;
end;

function TXMLIde.Get_Mod_: WideString;
begin
  Result := ChildNodes['mod'].Text;
end;

procedure TXMLIde.Set_Mod_(Value: WideString);
begin
  ChildNodes['mod'].NodeValue := Value;
end;

function TXMLIde.Get_Serie: WideString;
begin
  Result := ChildNodes['serie'].Text;
end;

procedure TXMLIde.Set_Serie(Value: WideString);
begin
  ChildNodes['serie'].NodeValue := Value;
end;

function TXMLIde.Get_NNF: WideString;
begin
  Result := ChildNodes['nNF'].Text;
end;

procedure TXMLIde.Set_NNF(Value: WideString);
begin
  ChildNodes['nNF'].NodeValue := Value;
end;

function TXMLIde.Get_DEmi: WideString;
begin
  Result := ChildNodes['dEmi'].Text;
end;

procedure TXMLIde.Set_DEmi(Value: WideString);
begin
  ChildNodes['dEmi'].NodeValue := Value;
end;

function TXMLIde.Get_DSaiEnt: WideString;
begin
  Result := ChildNodes['dSaiEnt'].Text;
end;

procedure TXMLIde.Set_DSaiEnt(Value: WideString);
begin
  ChildNodes['dSaiEnt'].NodeValue := Value;
end;

function TXMLIde.Get_TpNF: WideString;
begin
  Result := ChildNodes['tpNF'].Text;
end;

procedure TXMLIde.Set_TpNF(Value: WideString);
begin
  ChildNodes['tpNF'].NodeValue := Value;
end;

function TXMLIde.Get_CMunFG: WideString;
begin
  Result := ChildNodes['cMunFG'].Text;
end;

procedure TXMLIde.Set_CMunFG(Value: WideString);
begin
  ChildNodes['cMunFG'].NodeValue := Value;
end;

function TXMLIde.Get_NFref: IXMLNFrefList;
begin
  Result := FNFref;
end;

function TXMLIde.Get_TpImp: WideString;
begin
  Result := ChildNodes['tpImp'].Text;
end;

procedure TXMLIde.Set_TpImp(Value: WideString);
begin
  ChildNodes['tpImp'].NodeValue := Value;
end;

function TXMLIde.Get_TpEmis: WideString;
begin
  Result := ChildNodes['tpEmis'].Text;
end;

procedure TXMLIde.Set_TpEmis(Value: WideString);
begin
  ChildNodes['tpEmis'].NodeValue := Value;
end;

function TXMLIde.Get_CDV: WideString;
begin
  Result := ChildNodes['cDV'].Text;
end;

procedure TXMLIde.Set_CDV(Value: WideString);
begin
  ChildNodes['cDV'].NodeValue := Value;
end;

function TXMLIde.Get_TpAmb: WideString;
begin
  Result := ChildNodes['tpAmb'].Text;
end;

procedure TXMLIde.Set_TpAmb(Value: WideString);
begin
  ChildNodes['tpAmb'].NodeValue := Value;
end;

function TXMLIde.Get_FinNFe: WideString;
begin
  Result := ChildNodes['finNFe'].Text;
end;

procedure TXMLIde.Set_FinNFe(Value: WideString);
begin
  ChildNodes['finNFe'].NodeValue := Value;
end;

function TXMLIde.Get_ProcEmi: WideString;
begin
  Result := ChildNodes['procEmi'].Text;
end;

procedure TXMLIde.Set_ProcEmi(Value: WideString);
begin
  ChildNodes['procEmi'].NodeValue := Value;
end;

function TXMLIde.Get_VerProc: WideString;
begin
  Result := ChildNodes['verProc'].Text;
end;

procedure TXMLIde.Set_VerProc(Value: WideString);
begin
  ChildNodes['verProc'].NodeValue := Value;
end;

{ TXMLNFref }

procedure TXMLNFref.AfterConstruction;
begin
  RegisterChildNode('refNF', TXMLRefNF);
  inherited;
end;

function TXMLNFref.Get_RefNFe: WideString;
begin
  Result := ChildNodes['refNFe'].Text;
end;

procedure TXMLNFref.Set_RefNFe(Value: WideString);
begin
  ChildNodes['refNFe'].NodeValue := Value;
end;

function TXMLNFref.Get_RefNF: IXMLRefNF;
begin
  Result := ChildNodes['refNF'] as IXMLRefNF;
end;

{ TXMLNFrefList }

function TXMLNFrefList.Add: IXMLNFref;
begin
  Result := AddItem(-1) as IXMLNFref;
end;

function TXMLNFrefList.Insert(const Index: Integer): IXMLNFref;
begin
  Result := AddItem(Index) as IXMLNFref;
end;
function TXMLNFrefList.Get_Item(Index: Integer): IXMLNFref;
begin
  Result := List[Index] as IXMLNFref;
end;

{ TXMLRefNF }

function TXMLRefNF.Get_CUF: WideString;
begin
  Result := ChildNodes['cUF'].Text;
end;

procedure TXMLRefNF.Set_CUF(Value: WideString);
begin
  ChildNodes['cUF'].NodeValue := Value;
end;

function TXMLRefNF.Get_AAMM: WideString;
begin
  Result := ChildNodes['AAMM'].Text;
end;

procedure TXMLRefNF.Set_AAMM(Value: WideString);
begin
  ChildNodes['AAMM'].NodeValue := Value;
end;

function TXMLRefNF.Get_CNPJ: WideString;
begin
  Result := ChildNodes['CNPJ'].Text;
end;

procedure TXMLRefNF.Set_CNPJ(Value: WideString);
begin
  ChildNodes['CNPJ'].NodeValue := Value;
end;

function TXMLRefNF.Get_Mod_: WideString;
begin
  Result := ChildNodes['mod'].Text;
end;

procedure TXMLRefNF.Set_Mod_(Value: WideString);
begin
  ChildNodes['mod'].NodeValue := Value;
end;

function TXMLRefNF.Get_Serie: WideString;
begin
  Result := ChildNodes['serie'].Text;
end;

procedure TXMLRefNF.Set_Serie(Value: WideString);
begin
  ChildNodes['serie'].NodeValue := Value;
end;

function TXMLRefNF.Get_NNF: WideString;
begin
  Result := ChildNodes['nNF'].Text;
end;

procedure TXMLRefNF.Set_NNF(Value: WideString);
begin
  ChildNodes['nNF'].NodeValue := Value;
end;

{ TXMLEmit }

procedure TXMLEmit.AfterConstruction;
begin
  RegisterChildNode('enderEmit', TXMLTEndereco);
  inherited;
end;

function TXMLEmit.Get_CNPJ: WideString;
begin
  Result := ChildNodes['CNPJ'].Text;
end;

procedure TXMLEmit.Set_CNPJ(Value: WideString);
begin
  ChildNodes['CNPJ'].NodeValue := Value;
end;

function TXMLEmit.Get_CPF: WideString;
begin
  Result := ChildNodes['CPF'].Text;
end;

procedure TXMLEmit.Set_CPF(Value: WideString);
begin
  ChildNodes['CPF'].NodeValue := Value;
end;

function TXMLEmit.Get_XNome: WideString;
begin
  Result := ChildNodes['xNome'].Text;
end;

procedure TXMLEmit.Set_XNome(Value: WideString);
begin
  ChildNodes['xNome'].NodeValue := Value;
end;

function TXMLEmit.Get_XFant: WideString;
begin
  Result := ChildNodes['xFant'].Text;
end;

procedure TXMLEmit.Set_XFant(Value: WideString);
begin
  ChildNodes['xFant'].NodeValue := Value;
end;

function TXMLEmit.Get_EnderEmit: IXMLTEndereco;
begin
  Result := ChildNodes['enderEmit'] as IXMLTEndereco;
end;

function TXMLEmit.Get_IE: WideString;
begin
  Result := ChildNodes['IE'].Text;
end;

procedure TXMLEmit.Set_IE(Value: WideString);
begin
  ChildNodes['IE'].NodeValue := Value;
end;

function TXMLEmit.Get_IEST: WideString;
begin
  Result := ChildNodes['IEST'].Text;
end;

procedure TXMLEmit.Set_IEST(Value: WideString);
begin
  ChildNodes['IEST'].NodeValue := Value;
end;

function TXMLEmit.Get_IM: WideString;
begin
  Result := ChildNodes['IM'].Text;
end;

procedure TXMLEmit.Set_IM(Value: WideString);
begin
  ChildNodes['IM'].NodeValue := Value;
end;

function TXMLEmit.Get_CNAE: WideString;
begin
  Result := ChildNodes['CNAE'].Text;
end;

procedure TXMLEmit.Set_CNAE(Value: WideString);
begin
  ChildNodes['CNAE'].NodeValue := Value;
end;

{ TXMLTEndereco }

function TXMLTEndereco.Get_XLgr: WideString;
begin
  Result := ChildNodes['xLgr'].Text;
end;

procedure TXMLTEndereco.Set_XLgr(Value: WideString);
begin
  ChildNodes['xLgr'].NodeValue := Value;
end;

function TXMLTEndereco.Get_Nro: WideString;
begin
  Result := ChildNodes['nro'].Text;
end;

procedure TXMLTEndereco.Set_Nro(Value: WideString);
begin
  ChildNodes['nro'].NodeValue := Value;
end;

function TXMLTEndereco.Get_XCpl: WideString;
begin
  Result := ChildNodes['xCpl'].Text;
end;

procedure TXMLTEndereco.Set_XCpl(Value: WideString);
begin
  ChildNodes['xCpl'].NodeValue := Value;
end;

function TXMLTEndereco.Get_XBairro: WideString;
begin
  Result := ChildNodes['xBairro'].Text;
end;

procedure TXMLTEndereco.Set_XBairro(Value: WideString);
begin
  ChildNodes['xBairro'].NodeValue := Value;
end;

function TXMLTEndereco.Get_CMun: WideString;
begin
  Result := ChildNodes['cMun'].Text;
end;

procedure TXMLTEndereco.Set_CMun(Value: WideString);
begin
  ChildNodes['cMun'].NodeValue := Value;
end;

function TXMLTEndereco.Get_XMun: WideString;
begin
  Result := ChildNodes['xMun'].Text;
end;

procedure TXMLTEndereco.Set_XMun(Value: WideString);
begin
  ChildNodes['xMun'].NodeValue := Value;
end;

function TXMLTEndereco.Get_UF: WideString;
begin
  Result := ChildNodes['UF'].Text;
end;

procedure TXMLTEndereco.Set_UF(Value: WideString);
begin
  ChildNodes['UF'].NodeValue := Value;
end;

function TXMLTEndereco.Get_CEP: WideString;
begin
  Result := ChildNodes['CEP'].Text;
end;

procedure TXMLTEndereco.Set_CEP(Value: WideString);
begin
  ChildNodes['CEP'].NodeValue := Value;
end;

function TXMLTEndereco.Get_CPais: WideString;
begin
  Result := ChildNodes['cPais'].Text;
end;

procedure TXMLTEndereco.Set_CPais(Value: WideString);
begin
  ChildNodes['cPais'].NodeValue := Value;
end;

function TXMLTEndereco.Get_XPais: WideString;
begin
  Result := ChildNodes['xPais'].Text;
end;

procedure TXMLTEndereco.Set_XPais(Value: WideString);
begin
  ChildNodes['xPais'].NodeValue := Value;
end;

function TXMLTEndereco.Get_Fone: WideString;
begin
  Result := ChildNodes['fone'].Text;
end;

procedure TXMLTEndereco.Set_Fone(Value: WideString);
begin
  ChildNodes['fone'].NodeValue := Value;
end;

{ TXMLAvulsa }

function TXMLAvulsa.Get_CNPJ: WideString;
begin
  Result := ChildNodes['CNPJ'].Text;
end;

procedure TXMLAvulsa.Set_CNPJ(Value: WideString);
begin
  ChildNodes['CNPJ'].NodeValue := Value;
end;

function TXMLAvulsa.Get_XOrgao: WideString;
begin
  Result := ChildNodes['xOrgao'].Text;
end;

procedure TXMLAvulsa.Set_XOrgao(Value: WideString);
begin
  ChildNodes['xOrgao'].NodeValue := Value;
end;

function TXMLAvulsa.Get_Matr: WideString;
begin
  Result := ChildNodes['matr'].Text;
end;

procedure TXMLAvulsa.Set_Matr(Value: WideString);
begin
  ChildNodes['matr'].NodeValue := Value;
end;

function TXMLAvulsa.Get_XAgente: WideString;
begin
  Result := ChildNodes['xAgente'].Text;
end;

procedure TXMLAvulsa.Set_XAgente(Value: WideString);
begin
  ChildNodes['xAgente'].NodeValue := Value;
end;

function TXMLAvulsa.Get_Fone: WideString;
begin
  Result := ChildNodes['fone'].Text;
end;

procedure TXMLAvulsa.Set_Fone(Value: WideString);
begin
  ChildNodes['fone'].NodeValue := Value;
end;

function TXMLAvulsa.Get_UF: WideString;
begin
  Result := ChildNodes['UF'].Text;
end;

procedure TXMLAvulsa.Set_UF(Value: WideString);
begin
  ChildNodes['UF'].NodeValue := Value;
end;

function TXMLAvulsa.Get_NDAR: WideString;
begin
  Result := ChildNodes['nDAR'].Text;
end;

procedure TXMLAvulsa.Set_NDAR(Value: WideString);
begin
  ChildNodes['nDAR'].NodeValue := Value;
end;

function TXMLAvulsa.Get_DEmi: WideString;
begin
  Result := ChildNodes['dEmi'].Text;
end;

procedure TXMLAvulsa.Set_DEmi(Value: WideString);
begin
  ChildNodes['dEmi'].NodeValue := Value;
end;

function TXMLAvulsa.Get_VDAR: WideString;
begin
  Result := ChildNodes['vDAR'].Text;
end;

procedure TXMLAvulsa.Set_VDAR(Value: WideString);
begin
  ChildNodes['vDAR'].NodeValue := Value;
end;

function TXMLAvulsa.Get_RepEmi: WideString;
begin
  Result := ChildNodes['repEmi'].Text;
end;

procedure TXMLAvulsa.Set_RepEmi(Value: WideString);
begin
  ChildNodes['repEmi'].NodeValue := Value;
end;

function TXMLAvulsa.Get_DPag: WideString;
begin
  Result := ChildNodes['dPag'].Text;
end;

procedure TXMLAvulsa.Set_DPag(Value: WideString);
begin
  ChildNodes['dPag'].NodeValue := Value;
end;

{ TXMLDest }

procedure TXMLDest.AfterConstruction;
begin
  RegisterChildNode('enderDest', TXMLTEndereco);
  inherited;
end;

function TXMLDest.Get_CNPJ: WideString;
begin
  Result := ChildNodes['CNPJ'].Text;
end;

procedure TXMLDest.Set_CNPJ(Value: WideString);
begin
  ChildNodes['CNPJ'].NodeValue := Value;
end;

function TXMLDest.Get_CPF: WideString;
begin
  Result := ChildNodes['CPF'].Text;
end;

procedure TXMLDest.Set_CPF(Value: WideString);
begin
  ChildNodes['CPF'].NodeValue := Value;
end;

function TXMLDest.Get_XNome: WideString;
begin
  Result := ChildNodes['xNome'].Text;
end;

procedure TXMLDest.Set_XNome(Value: WideString);
begin
  ChildNodes['xNome'].NodeValue := Value;
end;

function TXMLDest.Get_EnderDest: IXMLTEndereco;
begin
  Result := ChildNodes['enderDest'] as IXMLTEndereco;
end;

function TXMLDest.Get_IE: WideString;
begin
  Result := ChildNodes['IE'].Text;
end;

procedure TXMLDest.Set_IE(Value: WideString);
begin
  ChildNodes['IE'].NodeValue := Value;
end;

function TXMLDest.Get_ISUF: WideString;
begin
  Result := ChildNodes['ISUF'].Text;
end;

procedure TXMLDest.Set_ISUF(Value: WideString);
begin
  ChildNodes['ISUF'].NodeValue := Value;
end;

{ TXMLTLocal }

function TXMLTLocal.Get_CNPJ: WideString;
begin
  Result := ChildNodes['CNPJ'].Text;
end;

procedure TXMLTLocal.Set_CNPJ(Value: WideString);
begin
  ChildNodes['CNPJ'].NodeValue := Value;
end;

function TXMLTLocal.Get_XLgr: WideString;
begin
  Result := ChildNodes['xLgr'].Text;
end;

procedure TXMLTLocal.Set_XLgr(Value: WideString);
begin
  ChildNodes['xLgr'].NodeValue := Value;
end;

function TXMLTLocal.Get_Nro: WideString;
begin
  Result := ChildNodes['nro'].Text;
end;

procedure TXMLTLocal.Set_Nro(Value: WideString);
begin
  ChildNodes['nro'].NodeValue := Value;
end;

function TXMLTLocal.Get_XCpl: WideString;
begin
  Result := ChildNodes['xCpl'].Text;
end;

procedure TXMLTLocal.Set_XCpl(Value: WideString);
begin
  ChildNodes['xCpl'].NodeValue := Value;
end;

function TXMLTLocal.Get_XBairro: WideString;
begin
  Result := ChildNodes['xBairro'].Text;
end;

procedure TXMLTLocal.Set_XBairro(Value: WideString);
begin
  ChildNodes['xBairro'].NodeValue := Value;
end;

function TXMLTLocal.Get_CMun: WideString;
begin
  Result := ChildNodes['cMun'].Text;
end;

procedure TXMLTLocal.Set_CMun(Value: WideString);
begin
  ChildNodes['cMun'].NodeValue := Value;
end;

function TXMLTLocal.Get_XMun: WideString;
begin
  Result := ChildNodes['xMun'].Text;
end;

procedure TXMLTLocal.Set_XMun(Value: WideString);
begin
  ChildNodes['xMun'].NodeValue := Value;
end;

function TXMLTLocal.Get_UF: WideString;
begin
  Result := ChildNodes['UF'].Text;
end;

procedure TXMLTLocal.Set_UF(Value: WideString);
begin
  ChildNodes['UF'].NodeValue := Value;
end;

{ TXMLDet }

procedure TXMLDet.AfterConstruction;
begin
  RegisterChildNode('prod', TXMLProd);
  RegisterChildNode('imposto', TXMLImposto);
  inherited;
end;

function TXMLDet.Get_NItem: WideString;
begin
  Result := AttributeNodes['nItem'].Text;
end;

procedure TXMLDet.Set_NItem(Value: WideString);
begin
  SetAttribute('nItem', Value);
end;

function TXMLDet.Get_Prod: IXMLProd;
begin
  Result := ChildNodes['prod'] as IXMLProd;
end;

function TXMLDet.Get_Imposto: IXMLImposto;
begin
  Result := ChildNodes['imposto'] as IXMLImposto;
end;

function TXMLDet.Get_InfAdProd: WideString;
begin
  Result := ChildNodes['infAdProd'].Text;
end;

procedure TXMLDet.Set_InfAdProd(Value: WideString);
begin
  ChildNodes['infAdProd'].NodeValue := Value;
end;

{ TXMLDetList }

function TXMLDetList.Add: IXMLDet;
begin
  Result := AddItem(-1) as IXMLDet;
end;

function TXMLDetList.Insert(const Index: Integer): IXMLDet;
begin
  Result := AddItem(Index) as IXMLDet;
end;
function TXMLDetList.Get_Item(Index: Integer): IXMLDet;
begin
  Result := List[Index] as IXMLDet;
end;

{ TXMLProd }

procedure TXMLProd.AfterConstruction;
begin
  RegisterChildNode('DI', TXMLDI);
  RegisterChildNode('veicProd', TXMLVeicProd);
  RegisterChildNode('med', TXMLMed);
  RegisterChildNode('arma', TXMLArma);
  RegisterChildNode('comb', TXMLComb);
  FDI := CreateCollection(TXMLDIList, IXMLDI, 'DI') as IXMLDIList;
  FMed := CreateCollection(TXMLMedList, IXMLMed, 'med') as IXMLMedList;
  FArma := CreateCollection(TXMLArmaList, IXMLArma, 'arma') as IXMLArmaList;
  inherited;
end;

function TXMLProd.Get_CProd: WideString;
begin
  Result := ChildNodes['cProd'].Text;
end;

procedure TXMLProd.Set_CProd(Value: WideString);
begin
  ChildNodes['cProd'].NodeValue := Value;
end;

function TXMLProd.Get_CEAN: WideString;
begin
  Result := ChildNodes['cEAN'].Text;
end;

procedure TXMLProd.Set_CEAN(Value: WideString);
begin
  ChildNodes['cEAN'].NodeValue := Value;
end;

function TXMLProd.Get_XProd: WideString;
begin
  Result := ChildNodes['xProd'].Text;
end;

procedure TXMLProd.Set_XProd(Value: WideString);
begin
  ChildNodes['xProd'].NodeValue := Value;
end;

function TXMLProd.Get_NCM: WideString;
begin
  Result := ChildNodes['NCM'].Text;
end;

procedure TXMLProd.Set_NCM(Value: WideString);
begin
  ChildNodes['NCM'].NodeValue := Value;
end;

function TXMLProd.Get_EXTIPI: WideString;
begin
  Result := ChildNodes['EXTIPI'].Text;
end;

procedure TXMLProd.Set_EXTIPI(Value: WideString);
begin
  ChildNodes['EXTIPI'].NodeValue := Value;
end;

function TXMLProd.Get_Genero: WideString;
begin
  Result := ChildNodes['genero'].Text;
end;

procedure TXMLProd.Set_Genero(Value: WideString);
begin
  ChildNodes['genero'].NodeValue := Value;
end;

function TXMLProd.Get_CFOP: WideString;
begin
  Result := ChildNodes['CFOP'].Text;
end;

procedure TXMLProd.Set_CFOP(Value: WideString);
begin
  ChildNodes['CFOP'].NodeValue := Value;
end;

function TXMLProd.Get_UCom: WideString;
begin
  Result := ChildNodes['uCom'].Text;
end;

procedure TXMLProd.Set_UCom(Value: WideString);
begin
  ChildNodes['uCom'].NodeValue := Value;
end;

function TXMLProd.Get_QCom: WideString;
begin
  Result := ChildNodes['qCom'].Text;
end;

procedure TXMLProd.Set_QCom(Value: WideString);
begin
  ChildNodes['qCom'].NodeValue := Value;
end;

function TXMLProd.Get_VUnCom: WideString;
begin
  Result := ChildNodes['vUnCom'].Text;
end;

procedure TXMLProd.Set_VUnCom(Value: WideString);
begin
  ChildNodes['vUnCom'].NodeValue := Value;
end;

function TXMLProd.Get_VProd: WideString;
begin
  Result := ChildNodes['vProd'].Text;
end;

procedure TXMLProd.Set_VProd(Value: WideString);
begin
  ChildNodes['vProd'].NodeValue := Value;
end;

function TXMLProd.Get_CEANTrib: WideString;
begin
  Result := ChildNodes['cEANTrib'].Text;
end;

procedure TXMLProd.Set_CEANTrib(Value: WideString);
begin
  ChildNodes['cEANTrib'].NodeValue := Value;
end;

function TXMLProd.Get_UTrib: WideString;
begin
  Result := ChildNodes['uTrib'].Text;
end;

procedure TXMLProd.Set_UTrib(Value: WideString);
begin
  ChildNodes['uTrib'].NodeValue := Value;
end;

function TXMLProd.Get_QTrib: WideString;
begin
  Result := ChildNodes['qTrib'].Text;
end;

procedure TXMLProd.Set_QTrib(Value: WideString);
begin
  ChildNodes['qTrib'].NodeValue := Value;
end;

function TXMLProd.Get_VUnTrib: WideString;
begin
  Result := ChildNodes['vUnTrib'].Text;
end;

procedure TXMLProd.Set_VUnTrib(Value: WideString);
begin
  ChildNodes['vUnTrib'].NodeValue := Value;
end;

function TXMLProd.Get_VFrete: WideString;
begin
  Result := ChildNodes['vFrete'].Text;
end;

procedure TXMLProd.Set_VFrete(Value: WideString);
begin
  ChildNodes['vFrete'].NodeValue := Value;
end;

function TXMLProd.Get_VSeg: WideString;
begin
  Result := ChildNodes['vSeg'].Text;
end;

procedure TXMLProd.Set_VSeg(Value: WideString);
begin
  ChildNodes['vSeg'].NodeValue := Value;
end;

function TXMLProd.Get_VDesc: WideString;
begin
  Result := ChildNodes['vDesc'].Text;
end;

procedure TXMLProd.Set_VDesc(Value: WideString);
begin
  ChildNodes['vDesc'].NodeValue := Value;
end;

function TXMLProd.Get_DI: IXMLDIList;
begin
  Result := FDI;
end;

function TXMLProd.Get_VeicProd: IXMLVeicProd;
begin
  Result := ChildNodes['veicProd'] as IXMLVeicProd;
end;

function TXMLProd.Get_Med: IXMLMedList;
begin
  Result := FMed;
end;

function TXMLProd.Get_Arma: IXMLArmaList;
begin
  Result := FArma;
end;

function TXMLProd.Get_Comb: IXMLComb;
begin
  Result := ChildNodes['comb'] as IXMLComb;
end;

{ TXMLDI }

procedure TXMLDI.AfterConstruction;
begin
  RegisterChildNode('adi', TXMLAdi);
  FAdi := CreateCollection(TXMLAdiList, IXMLAdi, 'adi') as IXMLAdiList;
  inherited;
end;

function TXMLDI.Get_NDI: WideString;
begin
  Result := ChildNodes['nDI'].Text;
end;

procedure TXMLDI.Set_NDI(Value: WideString);
begin
  ChildNodes['nDI'].NodeValue := Value;
end;

function TXMLDI.Get_DDI: WideString;
begin
  Result := ChildNodes['dDI'].Text;
end;

procedure TXMLDI.Set_DDI(Value: WideString);
begin
  ChildNodes['dDI'].NodeValue := Value;
end;

function TXMLDI.Get_XLocDesemb: WideString;
begin
  Result := ChildNodes['xLocDesemb'].Text;
end;

procedure TXMLDI.Set_XLocDesemb(Value: WideString);
begin
  ChildNodes['xLocDesemb'].NodeValue := Value;
end;

function TXMLDI.Get_UFDesemb: WideString;
begin
  Result := ChildNodes['UFDesemb'].Text;
end;

procedure TXMLDI.Set_UFDesemb(Value: WideString);
begin
  ChildNodes['UFDesemb'].NodeValue := Value;
end;

function TXMLDI.Get_DDesemb: WideString;
begin
  Result := ChildNodes['dDesemb'].Text;
end;

procedure TXMLDI.Set_DDesemb(Value: WideString);
begin
  ChildNodes['dDesemb'].NodeValue := Value;
end;

function TXMLDI.Get_CExportador: WideString;
begin
  Result := ChildNodes['cExportador'].Text;
end;

procedure TXMLDI.Set_CExportador(Value: WideString);
begin
  ChildNodes['cExportador'].NodeValue := Value;
end;

function TXMLDI.Get_Adi: IXMLAdiList;
begin
  Result := FAdi;
end;

{ TXMLDIList }

function TXMLDIList.Add: IXMLDI;
begin
  Result := AddItem(-1) as IXMLDI;
end;

function TXMLDIList.Insert(const Index: Integer): IXMLDI;
begin
  Result := AddItem(Index) as IXMLDI;
end;
function TXMLDIList.Get_Item(Index: Integer): IXMLDI;
begin
  Result := List[Index] as IXMLDI;
end;

{ TXMLAdi }

function TXMLAdi.Get_NAdicao: WideString;
begin
  Result := ChildNodes['nAdicao'].Text;
end;

procedure TXMLAdi.Set_NAdicao(Value: WideString);
begin
  ChildNodes['nAdicao'].NodeValue := Value;
end;

function TXMLAdi.Get_NSeqAdic: WideString;
begin
  Result := ChildNodes['nSeqAdic'].Text;
end;

procedure TXMLAdi.Set_NSeqAdic(Value: WideString);
begin
  ChildNodes['nSeqAdic'].NodeValue := Value;
end;

function TXMLAdi.Get_CFabricante: WideString;
begin
  Result := ChildNodes['cFabricante'].Text;
end;

procedure TXMLAdi.Set_CFabricante(Value: WideString);
begin
  ChildNodes['cFabricante'].NodeValue := Value;
end;

function TXMLAdi.Get_VDescDI: WideString;
begin
  Result := ChildNodes['vDescDI'].Text;
end;

procedure TXMLAdi.Set_VDescDI(Value: WideString);
begin
  ChildNodes['vDescDI'].NodeValue := Value;
end;

{ TXMLAdiList }

function TXMLAdiList.Add: IXMLAdi;
begin
  Result := AddItem(-1) as IXMLAdi;
end;

function TXMLAdiList.Insert(const Index: Integer): IXMLAdi;
begin
  Result := AddItem(Index) as IXMLAdi;
end;
function TXMLAdiList.Get_Item(Index: Integer): IXMLAdi;
begin
  Result := List[Index] as IXMLAdi;
end;

{ TXMLVeicProd }

function TXMLVeicProd.Get_TpOp: WideString;
begin
  Result := ChildNodes['tpOp'].Text;
end;

procedure TXMLVeicProd.Set_TpOp(Value: WideString);
begin
  ChildNodes['tpOp'].NodeValue := Value;
end;

function TXMLVeicProd.Get_Chassi: WideString;
begin
  Result := ChildNodes['chassi'].Text;
end;

procedure TXMLVeicProd.Set_Chassi(Value: WideString);
begin
  ChildNodes['chassi'].NodeValue := Value;
end;

function TXMLVeicProd.Get_CCor: WideString;
begin
  Result := ChildNodes['cCor'].Text;
end;

procedure TXMLVeicProd.Set_CCor(Value: WideString);
begin
  ChildNodes['cCor'].NodeValue := Value;
end;

function TXMLVeicProd.Get_XCor: WideString;
begin
  Result := ChildNodes['xCor'].Text;
end;

procedure TXMLVeicProd.Set_XCor(Value: WideString);
begin
  ChildNodes['xCor'].NodeValue := Value;
end;

function TXMLVeicProd.Get_Pot: WideString;
begin
  Result := ChildNodes['pot'].Text;
end;

procedure TXMLVeicProd.Set_Pot(Value: WideString);
begin
  ChildNodes['pot'].NodeValue := Value;
end;

function TXMLVeicProd.Get_CM3: WideString;
begin
  Result := ChildNodes['CM3'].Text;
end;

procedure TXMLVeicProd.Set_CM3(Value: WideString);
begin
  ChildNodes['CM3'].NodeValue := Value;
end;

function TXMLVeicProd.Get_PesoL: WideString;
begin
  Result := ChildNodes['pesoL'].Text;
end;

procedure TXMLVeicProd.Set_PesoL(Value: WideString);
begin
  ChildNodes['pesoL'].NodeValue := Value;
end;

function TXMLVeicProd.Get_PesoB: WideString;
begin
  Result := ChildNodes['pesoB'].Text;
end;

procedure TXMLVeicProd.Set_PesoB(Value: WideString);
begin
  ChildNodes['pesoB'].NodeValue := Value;
end;

function TXMLVeicProd.Get_NSerie: WideString;
begin
  Result := ChildNodes['nSerie'].Text;
end;

procedure TXMLVeicProd.Set_NSerie(Value: WideString);
begin
  ChildNodes['nSerie'].NodeValue := Value;
end;

function TXMLVeicProd.Get_TpComb: WideString;
begin
  Result := ChildNodes['tpComb'].Text;
end;

procedure TXMLVeicProd.Set_TpComb(Value: WideString);
begin
  ChildNodes['tpComb'].NodeValue := Value;
end;

function TXMLVeicProd.Get_NMotor: WideString;
begin
  Result := ChildNodes['nMotor'].Text;
end;

procedure TXMLVeicProd.Set_NMotor(Value: WideString);
begin
  ChildNodes['nMotor'].NodeValue := Value;
end;

function TXMLVeicProd.Get_CMKG: WideString;
begin
  Result := ChildNodes['CMKG'].Text;
end;

procedure TXMLVeicProd.Set_CMKG(Value: WideString);
begin
  ChildNodes['CMKG'].NodeValue := Value;
end;

function TXMLVeicProd.Get_Dist: WideString;
begin
  Result := ChildNodes['dist'].Text;
end;

procedure TXMLVeicProd.Set_Dist(Value: WideString);
begin
  ChildNodes['dist'].NodeValue := Value;
end;

function TXMLVeicProd.Get_RENAVAM: WideString;
begin
  Result := ChildNodes['RENAVAM'].Text;
end;

procedure TXMLVeicProd.Set_RENAVAM(Value: WideString);
begin
  ChildNodes['RENAVAM'].NodeValue := Value;
end;

function TXMLVeicProd.Get_AnoMod: WideString;
begin
  Result := ChildNodes['anoMod'].Text;
end;

procedure TXMLVeicProd.Set_AnoMod(Value: WideString);
begin
  ChildNodes['anoMod'].NodeValue := Value;
end;

function TXMLVeicProd.Get_AnoFab: WideString;
begin
  Result := ChildNodes['anoFab'].Text;
end;

procedure TXMLVeicProd.Set_AnoFab(Value: WideString);
begin
  ChildNodes['anoFab'].NodeValue := Value;
end;

function TXMLVeicProd.Get_TpPint: WideString;
begin
  Result := ChildNodes['tpPint'].Text;
end;

procedure TXMLVeicProd.Set_TpPint(Value: WideString);
begin
  ChildNodes['tpPint'].NodeValue := Value;
end;

function TXMLVeicProd.Get_TpVeic: WideString;
begin
  Result := ChildNodes['tpVeic'].Text;
end;

procedure TXMLVeicProd.Set_TpVeic(Value: WideString);
begin
  ChildNodes['tpVeic'].NodeValue := Value;
end;

function TXMLVeicProd.Get_EspVeic: WideString;
begin
  Result := ChildNodes['espVeic'].Text;
end;

procedure TXMLVeicProd.Set_EspVeic(Value: WideString);
begin
  ChildNodes['espVeic'].NodeValue := Value;
end;

function TXMLVeicProd.Get_VIN: WideString;
begin
  Result := ChildNodes['VIN'].Text;
end;

procedure TXMLVeicProd.Set_VIN(Value: WideString);
begin
  ChildNodes['VIN'].NodeValue := Value;
end;

function TXMLVeicProd.Get_CondVeic: WideString;
begin
  Result := ChildNodes['condVeic'].Text;
end;

procedure TXMLVeicProd.Set_CondVeic(Value: WideString);
begin
  ChildNodes['condVeic'].NodeValue := Value;
end;

function TXMLVeicProd.Get_CMod: WideString;
begin
  Result := ChildNodes['cMod'].Text;
end;

procedure TXMLVeicProd.Set_CMod(Value: WideString);
begin
  ChildNodes['cMod'].NodeValue := Value;
end;

{ TXMLMed }

function TXMLMed.Get_NLote: WideString;
begin
  Result := ChildNodes['nLote'].Text;
end;

procedure TXMLMed.Set_NLote(Value: WideString);
begin
  ChildNodes['nLote'].NodeValue := Value;
end;

function TXMLMed.Get_QLote: WideString;
begin
  Result := ChildNodes['qLote'].Text;
end;

procedure TXMLMed.Set_QLote(Value: WideString);
begin
  ChildNodes['qLote'].NodeValue := Value;
end;

function TXMLMed.Get_DFab: WideString;
begin
  Result := ChildNodes['dFab'].Text;
end;

procedure TXMLMed.Set_DFab(Value: WideString);
begin
  ChildNodes['dFab'].NodeValue := Value;
end;

function TXMLMed.Get_DVal: WideString;
begin
  Result := ChildNodes['dVal'].Text;
end;

procedure TXMLMed.Set_DVal(Value: WideString);
begin
  ChildNodes['dVal'].NodeValue := Value;
end;

function TXMLMed.Get_VPMC: WideString;
begin
  Result := ChildNodes['vPMC'].Text;
end;

procedure TXMLMed.Set_VPMC(Value: WideString);
begin
  ChildNodes['vPMC'].NodeValue := Value;
end;

{ TXMLMedList }

function TXMLMedList.Add: IXMLMed;
begin
  Result := AddItem(-1) as IXMLMed;
end;

function TXMLMedList.Insert(const Index: Integer): IXMLMed;
begin
  Result := AddItem(Index) as IXMLMed;
end;
function TXMLMedList.Get_Item(Index: Integer): IXMLMed;
begin
  Result := List[Index] as IXMLMed;
end;

{ TXMLArma }

function TXMLArma.Get_TpArma: WideString;
begin
  Result := ChildNodes['tpArma'].Text;
end;

procedure TXMLArma.Set_TpArma(Value: WideString);
begin
  ChildNodes['tpArma'].NodeValue := Value;
end;

function TXMLArma.Get_NSerie: WideString;
begin
  Result := ChildNodes['nSerie'].Text;
end;

procedure TXMLArma.Set_NSerie(Value: WideString);
begin
  ChildNodes['nSerie'].NodeValue := Value;
end;

function TXMLArma.Get_NCano: WideString;
begin
  Result := ChildNodes['nCano'].Text;
end;

procedure TXMLArma.Set_NCano(Value: WideString);
begin
  ChildNodes['nCano'].NodeValue := Value;
end;

function TXMLArma.Get_Descr: WideString;
begin
  Result := ChildNodes['descr'].Text;
end;

procedure TXMLArma.Set_Descr(Value: WideString);
begin
  ChildNodes['descr'].NodeValue := Value;
end;

{ TXMLArmaList }

function TXMLArmaList.Add: IXMLArma;
begin
  Result := AddItem(-1) as IXMLArma;
end;

function TXMLArmaList.Insert(const Index: Integer): IXMLArma;
begin
  Result := AddItem(Index) as IXMLArma;
end;
function TXMLArmaList.Get_Item(Index: Integer): IXMLArma;
begin
  Result := List[Index] as IXMLArma;
end;

{ TXMLComb }

procedure TXMLComb.AfterConstruction;
begin
  RegisterChildNode('CIDE', TXMLCIDE);
  RegisterChildNode('ICMSComb', TXMLICMSComb);
  RegisterChildNode('ICMSInter', TXMLICMSInter);
  RegisterChildNode('ICMSCons', TXMLICMSCons);
  inherited;
end;

function TXMLComb.Get_CProdANP: WideString;
begin
  Result := ChildNodes['cProdANP'].Text;
end;

procedure TXMLComb.Set_CProdANP(Value: WideString);
begin
  ChildNodes['cProdANP'].NodeValue := Value;
end;

function TXMLComb.Get_CODIF: WideString;
begin
  Result := ChildNodes['CODIF'].Text;
end;

procedure TXMLComb.Set_CODIF(Value: WideString);
begin
  ChildNodes['CODIF'].NodeValue := Value;
end;

function TXMLComb.Get_QTemp: WideString;
begin
  Result := ChildNodes['qTemp'].Text;
end;

procedure TXMLComb.Set_QTemp(Value: WideString);
begin
  ChildNodes['qTemp'].NodeValue := Value;
end;

function TXMLComb.Get_CIDE: IXMLCIDE;
begin
  Result := ChildNodes['CIDE'] as IXMLCIDE;
end;

function TXMLComb.Get_ICMSComb: IXMLICMSComb;
begin
  Result := ChildNodes['ICMSComb'] as IXMLICMSComb;
end;

function TXMLComb.Get_ICMSInter: IXMLICMSInter;
begin
  Result := ChildNodes['ICMSInter'] as IXMLICMSInter;
end;

function TXMLComb.Get_ICMSCons: IXMLICMSCons;
begin
  Result := ChildNodes['ICMSCons'] as IXMLICMSCons;
end;

{ TXMLCIDE }

function TXMLCIDE.Get_QBCProd: WideString;
begin
  Result := ChildNodes['qBCProd'].Text;
end;

procedure TXMLCIDE.Set_QBCProd(Value: WideString);
begin
  ChildNodes['qBCProd'].NodeValue := Value;
end;

function TXMLCIDE.Get_VAliqProd: WideString;
begin
  Result := ChildNodes['vAliqProd'].Text;
end;

procedure TXMLCIDE.Set_VAliqProd(Value: WideString);
begin
  ChildNodes['vAliqProd'].NodeValue := Value;
end;

function TXMLCIDE.Get_VCIDE: WideString;
begin
  Result := ChildNodes['vCIDE'].Text;
end;

procedure TXMLCIDE.Set_VCIDE(Value: WideString);
begin
  ChildNodes['vCIDE'].NodeValue := Value;
end;

{ TXMLICMSComb }

function TXMLICMSComb.Get_VBCICMS: WideString;
begin
  Result := ChildNodes['vBCICMS'].Text;
end;

procedure TXMLICMSComb.Set_VBCICMS(Value: WideString);
begin
  ChildNodes['vBCICMS'].NodeValue := Value;
end;

function TXMLICMSComb.Get_VICMS: WideString;
begin
  Result := ChildNodes['vICMS'].Text;
end;

procedure TXMLICMSComb.Set_VICMS(Value: WideString);
begin
  ChildNodes['vICMS'].NodeValue := Value;
end;

function TXMLICMSComb.Get_VBCICMSST: WideString;
begin
  Result := ChildNodes['vBCICMSST'].Text;
end;

procedure TXMLICMSComb.Set_VBCICMSST(Value: WideString);
begin
  ChildNodes['vBCICMSST'].NodeValue := Value;
end;

function TXMLICMSComb.Get_VICMSST: WideString;
begin
  Result := ChildNodes['vICMSST'].Text;
end;

procedure TXMLICMSComb.Set_VICMSST(Value: WideString);
begin
  ChildNodes['vICMSST'].NodeValue := Value;
end;

{ TXMLICMSInter }

function TXMLICMSInter.Get_VBCICMSSTDest: WideString;
begin
  Result := ChildNodes['vBCICMSSTDest'].Text;
end;

procedure TXMLICMSInter.Set_VBCICMSSTDest(Value: WideString);
begin
  ChildNodes['vBCICMSSTDest'].NodeValue := Value;
end;

function TXMLICMSInter.Get_VICMSSTDest: WideString;
begin
  Result := ChildNodes['vICMSSTDest'].Text;
end;

procedure TXMLICMSInter.Set_VICMSSTDest(Value: WideString);
begin
  ChildNodes['vICMSSTDest'].NodeValue := Value;
end;

{ TXMLICMSCons }

function TXMLICMSCons.Get_VBCICMSSTCons: WideString;
begin
  Result := ChildNodes['vBCICMSSTCons'].Text;
end;

procedure TXMLICMSCons.Set_VBCICMSSTCons(Value: WideString);
begin
  ChildNodes['vBCICMSSTCons'].NodeValue := Value;
end;

function TXMLICMSCons.Get_VICMSSTCons: WideString;
begin
  Result := ChildNodes['vICMSSTCons'].Text;
end;

procedure TXMLICMSCons.Set_VICMSSTCons(Value: WideString);
begin
  ChildNodes['vICMSSTCons'].NodeValue := Value;
end;

function TXMLICMSCons.Get_UFCons: WideString;
begin
  Result := ChildNodes['UFCons'].Text;
end;

procedure TXMLICMSCons.Set_UFCons(Value: WideString);
begin
  ChildNodes['UFCons'].NodeValue := Value;
end;

{ TXMLImposto }

procedure TXMLImposto.AfterConstruction;
begin
  RegisterChildNode('ICMS', TXMLICMS);
  RegisterChildNode('IPI', TXMLIPI);
  RegisterChildNode('II', TXMLII);
  RegisterChildNode('PIS', TXMLPIS);
  RegisterChildNode('PISST', TXMLPISST);
  RegisterChildNode('COFINS', TXMLCOFINS);
  RegisterChildNode('COFINSST', TXMLCOFINSST);
  RegisterChildNode('ISSQN', TXMLISSQN);
  inherited;
end;

function TXMLImposto.Get_ICMS: IXMLICMS;
begin
  Result := ChildNodes['ICMS'] as IXMLICMS;
end;

function TXMLImposto.Get_IPI: IXMLIPI;
begin
  Result := ChildNodes['IPI'] as IXMLIPI;
end;

function TXMLImposto.Get_II: IXMLII;
begin
  Result := ChildNodes['II'] as IXMLII;
end;

function TXMLImposto.Get_PIS: IXMLPIS;
begin
  Result := ChildNodes['PIS'] as IXMLPIS;
end;

function TXMLImposto.Get_PISST: IXMLPISST;
begin
  Result := ChildNodes['PISST'] as IXMLPISST;
end;

function TXMLImposto.Get_COFINS: IXMLCOFINS;
begin
  Result := ChildNodes['COFINS'] as IXMLCOFINS;
end;

function TXMLImposto.Get_COFINSST: IXMLCOFINSST;
begin
  Result := ChildNodes['COFINSST'] as IXMLCOFINSST;
end;

function TXMLImposto.Get_ISSQN: IXMLISSQN;
begin
  Result := ChildNodes['ISSQN'] as IXMLISSQN;
end;

{ TXMLICMS }

procedure TXMLICMS.AfterConstruction;
begin
  RegisterChildNode('ICMS00', TXMLICMS00);
  RegisterChildNode('ICMS10', TXMLICMS10);
  RegisterChildNode('ICMS20', TXMLICMS20);
  RegisterChildNode('ICMS30', TXMLICMS30);
  RegisterChildNode('ICMS40', TXMLICMS40);
  RegisterChildNode('ICMS51', TXMLICMS51);
  RegisterChildNode('ICMS60', TXMLICMS60);
  RegisterChildNode('ICMS70', TXMLICMS70);
  RegisterChildNode('ICMS90', TXMLICMS90);
  inherited;
end;

function TXMLICMS.Get_ICMS00: IXMLICMS00;
begin
  Result := ChildNodes['ICMS00'] as IXMLICMS00;
end;

function TXMLICMS.Get_ICMS10: IXMLICMS10;
begin
  Result := ChildNodes['ICMS10'] as IXMLICMS10;
end;

function TXMLICMS.Get_ICMS20: IXMLICMS20;
begin
  Result := ChildNodes['ICMS20'] as IXMLICMS20;
end;

function TXMLICMS.Get_ICMS30: IXMLICMS30;
begin
  Result := ChildNodes['ICMS30'] as IXMLICMS30;
end;

function TXMLICMS.Get_ICMS40: IXMLICMS40;
begin
  Result := ChildNodes['ICMS40'] as IXMLICMS40;
end;

function TXMLICMS.Get_ICMS51: IXMLICMS51;
begin
  Result := ChildNodes['ICMS51'] as IXMLICMS51;
end;

function TXMLICMS.Get_ICMS60: IXMLICMS60;
begin
  Result := ChildNodes['ICMS60'] as IXMLICMS60;
end;

function TXMLICMS.Get_ICMS70: IXMLICMS70;
begin
  Result := ChildNodes['ICMS70'] as IXMLICMS70;
end;

function TXMLICMS.Get_ICMS90: IXMLICMS90;
begin
  Result := ChildNodes['ICMS90'] as IXMLICMS90;
end;

{ TXMLICMS00 }

function TXMLICMS00.Get_Orig: WideString;
begin
  Result := ChildNodes['orig'].Text;
end;

procedure TXMLICMS00.Set_Orig(Value: WideString);
begin
  ChildNodes['orig'].NodeValue := Value;
end;

function TXMLICMS00.Get_CST: WideString;
begin
  Result := ChildNodes['CST'].Text;
end;

procedure TXMLICMS00.Set_CST(Value: WideString);
begin
  ChildNodes['CST'].NodeValue := Value;
end;

function TXMLICMS00.Get_ModBC: WideString;
begin
  Result := ChildNodes['modBC'].Text;
end;

procedure TXMLICMS00.Set_ModBC(Value: WideString);
begin
  ChildNodes['modBC'].NodeValue := Value;
end;

function TXMLICMS00.Get_VBC: WideString;
begin
  Result := ChildNodes['vBC'].Text;
end;

procedure TXMLICMS00.Set_VBC(Value: WideString);
begin
  ChildNodes['vBC'].NodeValue := Value;
end;

function TXMLICMS00.Get_PICMS: WideString;
begin
  Result := ChildNodes['pICMS'].Text;
end;

procedure TXMLICMS00.Set_PICMS(Value: WideString);
begin
  ChildNodes['pICMS'].NodeValue := Value;
end;

function TXMLICMS00.Get_VICMS: WideString;
begin
  Result := ChildNodes['vICMS'].Text;
end;

procedure TXMLICMS00.Set_VICMS(Value: WideString);
begin
  ChildNodes['vICMS'].NodeValue := Value;
end;

{ TXMLICMS10 }

function TXMLICMS10.Get_Orig: WideString;
begin
  Result := ChildNodes['orig'].Text;
end;

procedure TXMLICMS10.Set_Orig(Value: WideString);
begin
  ChildNodes['orig'].NodeValue := Value;
end;

function TXMLICMS10.Get_CST: WideString;
begin
  Result := ChildNodes['CST'].Text;
end;

procedure TXMLICMS10.Set_CST(Value: WideString);
begin
  ChildNodes['CST'].NodeValue := Value;
end;

function TXMLICMS10.Get_ModBC: WideString;
begin
  Result := ChildNodes['modBC'].Text;
end;

procedure TXMLICMS10.Set_ModBC(Value: WideString);
begin
  ChildNodes['modBC'].NodeValue := Value;
end;

function TXMLICMS10.Get_VBC: WideString;
begin
  Result := ChildNodes['vBC'].Text;
end;

procedure TXMLICMS10.Set_VBC(Value: WideString);
begin
  ChildNodes['vBC'].NodeValue := Value;
end;

function TXMLICMS10.Get_PICMS: WideString;
begin
  Result := ChildNodes['pICMS'].Text;
end;

procedure TXMLICMS10.Set_PICMS(Value: WideString);
begin
  ChildNodes['pICMS'].NodeValue := Value;
end;

function TXMLICMS10.Get_VICMS: WideString;
begin
  Result := ChildNodes['vICMS'].Text;
end;

procedure TXMLICMS10.Set_VICMS(Value: WideString);
begin
  ChildNodes['vICMS'].NodeValue := Value;
end;

function TXMLICMS10.Get_ModBCST: WideString;
begin
  Result := ChildNodes['modBCST'].Text;
end;

procedure TXMLICMS10.Set_ModBCST(Value: WideString);
begin
  ChildNodes['modBCST'].NodeValue := Value;
end;

function TXMLICMS10.Get_PMVAST: WideString;
begin
  Result := ChildNodes['pMVAST'].Text;
end;

procedure TXMLICMS10.Set_PMVAST(Value: WideString);
begin
  ChildNodes['pMVAST'].NodeValue := Value;
end;

function TXMLICMS10.Get_PRedBCST: WideString;
begin
  Result := ChildNodes['pRedBCST'].Text;
end;

procedure TXMLICMS10.Set_PRedBCST(Value: WideString);
begin
  ChildNodes['pRedBCST'].NodeValue := Value;
end;

function TXMLICMS10.Get_VBCST: WideString;
begin
  Result := ChildNodes['vBCST'].Text;
end;

procedure TXMLICMS10.Set_VBCST(Value: WideString);
begin
  ChildNodes['vBCST'].NodeValue := Value;
end;

function TXMLICMS10.Get_PICMSST: WideString;
begin
  Result := ChildNodes['pICMSST'].Text;
end;

procedure TXMLICMS10.Set_PICMSST(Value: WideString);
begin
  ChildNodes['pICMSST'].NodeValue := Value;
end;

function TXMLICMS10.Get_VICMSST: WideString;
begin
  Result := ChildNodes['vICMSST'].Text;
end;

procedure TXMLICMS10.Set_VICMSST(Value: WideString);
begin
  ChildNodes['vICMSST'].NodeValue := Value;
end;

{ TXMLICMS20 }

function TXMLICMS20.Get_Orig: WideString;
begin
  Result := ChildNodes['orig'].Text;
end;

procedure TXMLICMS20.Set_Orig(Value: WideString);
begin
  ChildNodes['orig'].NodeValue := Value;
end;

function TXMLICMS20.Get_CST: WideString;
begin
  Result := ChildNodes['CST'].Text;
end;

procedure TXMLICMS20.Set_CST(Value: WideString);
begin
  ChildNodes['CST'].NodeValue := Value;
end;

function TXMLICMS20.Get_ModBC: WideString;
begin
  Result := ChildNodes['modBC'].Text;
end;

procedure TXMLICMS20.Set_ModBC(Value: WideString);
begin
  ChildNodes['modBC'].NodeValue := Value;
end;

function TXMLICMS20.Get_PRedBC: WideString;
begin
  Result := ChildNodes['pRedBC'].Text;
end;

procedure TXMLICMS20.Set_PRedBC(Value: WideString);
begin
  ChildNodes['pRedBC'].NodeValue := Value;
end;

function TXMLICMS20.Get_VBC: WideString;
begin
  Result := ChildNodes['vBC'].Text;
end;

procedure TXMLICMS20.Set_VBC(Value: WideString);
begin
  ChildNodes['vBC'].NodeValue := Value;
end;

function TXMLICMS20.Get_PICMS: WideString;
begin
  Result := ChildNodes['pICMS'].Text;
end;

procedure TXMLICMS20.Set_PICMS(Value: WideString);
begin
  ChildNodes['pICMS'].NodeValue := Value;
end;

function TXMLICMS20.Get_VICMS: WideString;
begin
  Result := ChildNodes['vICMS'].Text;
end;

procedure TXMLICMS20.Set_VICMS(Value: WideString);
begin
  ChildNodes['vICMS'].NodeValue := Value;
end;

{ TXMLICMS30 }

function TXMLICMS30.Get_Orig: WideString;
begin
  Result := ChildNodes['orig'].Text;
end;

procedure TXMLICMS30.Set_Orig(Value: WideString);
begin
  ChildNodes['orig'].NodeValue := Value;
end;

function TXMLICMS30.Get_CST: WideString;
begin
  Result := ChildNodes['CST'].Text;
end;

procedure TXMLICMS30.Set_CST(Value: WideString);
begin
  ChildNodes['CST'].NodeValue := Value;
end;

function TXMLICMS30.Get_ModBCST: WideString;
begin
  Result := ChildNodes['modBCST'].Text;
end;

procedure TXMLICMS30.Set_ModBCST(Value: WideString);
begin
  ChildNodes['modBCST'].NodeValue := Value;
end;

function TXMLICMS30.Get_PMVAST: WideString;
begin
  Result := ChildNodes['pMVAST'].Text;
end;

procedure TXMLICMS30.Set_PMVAST(Value: WideString);
begin
  ChildNodes['pMVAST'].NodeValue := Value;
end;

function TXMLICMS30.Get_PRedBCST: WideString;
begin
  Result := ChildNodes['pRedBCST'].Text;
end;

procedure TXMLICMS30.Set_PRedBCST(Value: WideString);
begin
  ChildNodes['pRedBCST'].NodeValue := Value;
end;

function TXMLICMS30.Get_VBCST: WideString;
begin
  Result := ChildNodes['vBCST'].Text;
end;

procedure TXMLICMS30.Set_VBCST(Value: WideString);
begin
  ChildNodes['vBCST'].NodeValue := Value;
end;

function TXMLICMS30.Get_PICMSST: WideString;
begin
  Result := ChildNodes['pICMSST'].Text;
end;

procedure TXMLICMS30.Set_PICMSST(Value: WideString);
begin
  ChildNodes['pICMSST'].NodeValue := Value;
end;

function TXMLICMS30.Get_VICMSST: WideString;
begin
  Result := ChildNodes['vICMSST'].Text;
end;

procedure TXMLICMS30.Set_VICMSST(Value: WideString);
begin
  ChildNodes['vICMSST'].NodeValue := Value;
end;

{ TXMLICMS40 }

function TXMLICMS40.Get_Orig: WideString;
begin
  Result := ChildNodes['orig'].Text;
end;

procedure TXMLICMS40.Set_Orig(Value: WideString);
begin
  ChildNodes['orig'].NodeValue := Value;
end;

function TXMLICMS40.Get_CST: WideString;
begin
  Result := ChildNodes['CST'].Text;
end;

procedure TXMLICMS40.Set_CST(Value: WideString);
begin
  ChildNodes['CST'].NodeValue := Value;
end;

{ TXMLICMS51 }

function TXMLICMS51.Get_Orig: WideString;
begin
  Result := ChildNodes['orig'].Text;
end;

procedure TXMLICMS51.Set_Orig(Value: WideString);
begin
  ChildNodes['orig'].NodeValue := Value;
end;

function TXMLICMS51.Get_CST: WideString;
begin
  Result := ChildNodes['CST'].Text;
end;

procedure TXMLICMS51.Set_CST(Value: WideString);
begin
  ChildNodes['CST'].NodeValue := Value;
end;

function TXMLICMS51.Get_ModBC: WideString;
begin
  Result := ChildNodes['modBC'].Text;
end;

procedure TXMLICMS51.Set_ModBC(Value: WideString);
begin
  ChildNodes['modBC'].NodeValue := Value;
end;

function TXMLICMS51.Get_PRedBC: WideString;
begin
  Result := ChildNodes['pRedBC'].Text;
end;

procedure TXMLICMS51.Set_PRedBC(Value: WideString);
begin
  ChildNodes['pRedBC'].NodeValue := Value;
end;

function TXMLICMS51.Get_VBC: WideString;
begin
  Result := ChildNodes['vBC'].Text;
end;

procedure TXMLICMS51.Set_VBC(Value: WideString);
begin
  ChildNodes['vBC'].NodeValue := Value;
end;

function TXMLICMS51.Get_PICMS: WideString;
begin
  Result := ChildNodes['pICMS'].Text;
end;

procedure TXMLICMS51.Set_PICMS(Value: WideString);
begin
  ChildNodes['pICMS'].NodeValue := Value;
end;

function TXMLICMS51.Get_VICMS: WideString;
begin
  Result := ChildNodes['vICMS'].Text;
end;

procedure TXMLICMS51.Set_VICMS(Value: WideString);
begin
  ChildNodes['vICMS'].NodeValue := Value;
end;

{ TXMLICMS60 }

function TXMLICMS60.Get_Orig: WideString;
begin
  Result := ChildNodes['orig'].Text;
end;

procedure TXMLICMS60.Set_Orig(Value: WideString);
begin
  ChildNodes['orig'].NodeValue := Value;
end;

function TXMLICMS60.Get_CST: WideString;
begin
  Result := ChildNodes['CST'].Text;
end;

procedure TXMLICMS60.Set_CST(Value: WideString);
begin
  ChildNodes['CST'].NodeValue := Value;
end;

function TXMLICMS60.Get_VBCST: WideString;
begin
  Result := ChildNodes['vBCST'].Text;
end;

procedure TXMLICMS60.Set_VBCST(Value: WideString);
begin
  ChildNodes['vBCST'].NodeValue := Value;
end;

function TXMLICMS60.Get_VICMSST: WideString;
begin
  Result := ChildNodes['vICMSST'].Text;
end;

procedure TXMLICMS60.Set_VICMSST(Value: WideString);
begin
  ChildNodes['vICMSST'].NodeValue := Value;
end;

{ TXMLICMS70 }

function TXMLICMS70.Get_Orig: WideString;
begin
  Result := ChildNodes['orig'].Text;
end;

procedure TXMLICMS70.Set_Orig(Value: WideString);
begin
  ChildNodes['orig'].NodeValue := Value;
end;

function TXMLICMS70.Get_CST: WideString;
begin
  Result := ChildNodes['CST'].Text;
end;

procedure TXMLICMS70.Set_CST(Value: WideString);
begin
  ChildNodes['CST'].NodeValue := Value;
end;

function TXMLICMS70.Get_ModBC: WideString;
begin
  Result := ChildNodes['modBC'].Text;
end;

procedure TXMLICMS70.Set_ModBC(Value: WideString);
begin
  ChildNodes['modBC'].NodeValue := Value;
end;

function TXMLICMS70.Get_PRedBC: WideString;
begin
  Result := ChildNodes['pRedBC'].Text;
end;

procedure TXMLICMS70.Set_PRedBC(Value: WideString);
begin
  ChildNodes['pRedBC'].NodeValue := Value;
end;

function TXMLICMS70.Get_VBC: WideString;
begin
  Result := ChildNodes['vBC'].Text;
end;

procedure TXMLICMS70.Set_VBC(Value: WideString);
begin
  ChildNodes['vBC'].NodeValue := Value;
end;

function TXMLICMS70.Get_PICMS: WideString;
begin
  Result := ChildNodes['pICMS'].Text;
end;

procedure TXMLICMS70.Set_PICMS(Value: WideString);
begin
  ChildNodes['pICMS'].NodeValue := Value;
end;

function TXMLICMS70.Get_VICMS: WideString;
begin
  Result := ChildNodes['vICMS'].Text;
end;

procedure TXMLICMS70.Set_VICMS(Value: WideString);
begin
  ChildNodes['vICMS'].NodeValue := Value;
end;

function TXMLICMS70.Get_ModBCST: WideString;
begin
  Result := ChildNodes['modBCST'].Text;
end;

procedure TXMLICMS70.Set_ModBCST(Value: WideString);
begin
  ChildNodes['modBCST'].NodeValue := Value;
end;

function TXMLICMS70.Get_PMVAST: WideString;
begin
  Result := ChildNodes['pMVAST'].Text;
end;

procedure TXMLICMS70.Set_PMVAST(Value: WideString);
begin
  ChildNodes['pMVAST'].NodeValue := Value;
end;

function TXMLICMS70.Get_PRedBCST: WideString;
begin
  Result := ChildNodes['pRedBCST'].Text;
end;

procedure TXMLICMS70.Set_PRedBCST(Value: WideString);
begin
  ChildNodes['pRedBCST'].NodeValue := Value;
end;

function TXMLICMS70.Get_VBCST: WideString;
begin
  Result := ChildNodes['vBCST'].Text;
end;

procedure TXMLICMS70.Set_VBCST(Value: WideString);
begin
  ChildNodes['vBCST'].NodeValue := Value;
end;

function TXMLICMS70.Get_PICMSST: WideString;
begin
  Result := ChildNodes['pICMSST'].Text;
end;

procedure TXMLICMS70.Set_PICMSST(Value: WideString);
begin
  ChildNodes['pICMSST'].NodeValue := Value;
end;

function TXMLICMS70.Get_VICMSST: WideString;
begin
  Result := ChildNodes['vICMSST'].Text;
end;

procedure TXMLICMS70.Set_VICMSST(Value: WideString);
begin
  ChildNodes['vICMSST'].NodeValue := Value;
end;

{ TXMLICMS90 }

function TXMLICMS90.Get_Orig: WideString;
begin
  Result := ChildNodes['orig'].Text;
end;

procedure TXMLICMS90.Set_Orig(Value: WideString);
begin
  ChildNodes['orig'].NodeValue := Value;
end;

function TXMLICMS90.Get_CST: WideString;
begin
  Result := ChildNodes['CST'].Text;
end;

procedure TXMLICMS90.Set_CST(Value: WideString);
begin
  ChildNodes['CST'].NodeValue := Value;
end;

function TXMLICMS90.Get_ModBC: WideString;
begin
  Result := ChildNodes['modBC'].Text;
end;

procedure TXMLICMS90.Set_ModBC(Value: WideString);
begin
  ChildNodes['modBC'].NodeValue := Value;
end;

function TXMLICMS90.Get_VBC: WideString;
begin
  Result := ChildNodes['vBC'].Text;
end;

procedure TXMLICMS90.Set_VBC(Value: WideString);
begin
  ChildNodes['vBC'].NodeValue := Value;
end;

function TXMLICMS90.Get_PRedBC: WideString;
begin
  Result := ChildNodes['pRedBC'].Text;
end;

procedure TXMLICMS90.Set_PRedBC(Value: WideString);
begin
  ChildNodes['pRedBC'].NodeValue := Value;
end;

function TXMLICMS90.Get_PICMS: WideString;
begin
  Result := ChildNodes['pICMS'].Text;
end;

procedure TXMLICMS90.Set_PICMS(Value: WideString);
begin
  ChildNodes['pICMS'].NodeValue := Value;
end;

function TXMLICMS90.Get_VICMS: WideString;
begin
  Result := ChildNodes['vICMS'].Text;
end;

procedure TXMLICMS90.Set_VICMS(Value: WideString);
begin
  ChildNodes['vICMS'].NodeValue := Value;
end;

function TXMLICMS90.Get_ModBCST: WideString;
begin
  Result := ChildNodes['modBCST'].Text;
end;

procedure TXMLICMS90.Set_ModBCST(Value: WideString);
begin
  ChildNodes['modBCST'].NodeValue := Value;
end;

function TXMLICMS90.Get_PMVAST: WideString;
begin
  Result := ChildNodes['pMVAST'].Text;
end;

procedure TXMLICMS90.Set_PMVAST(Value: WideString);
begin
  ChildNodes['pMVAST'].NodeValue := Value;
end;

function TXMLICMS90.Get_PRedBCST: WideString;
begin
  Result := ChildNodes['pRedBCST'].Text;
end;

procedure TXMLICMS90.Set_PRedBCST(Value: WideString);
begin
  ChildNodes['pRedBCST'].NodeValue := Value;
end;

function TXMLICMS90.Get_VBCST: WideString;
begin
  Result := ChildNodes['vBCST'].Text;
end;

procedure TXMLICMS90.Set_VBCST(Value: WideString);
begin
  ChildNodes['vBCST'].NodeValue := Value;
end;

function TXMLICMS90.Get_PICMSST: WideString;
begin
  Result := ChildNodes['pICMSST'].Text;
end;

procedure TXMLICMS90.Set_PICMSST(Value: WideString);
begin
  ChildNodes['pICMSST'].NodeValue := Value;
end;

function TXMLICMS90.Get_VICMSST: WideString;
begin
  Result := ChildNodes['vICMSST'].Text;
end;

procedure TXMLICMS90.Set_VICMSST(Value: WideString);
begin
  ChildNodes['vICMSST'].NodeValue := Value;
end;

{ TXMLIPI }

procedure TXMLIPI.AfterConstruction;
begin
  RegisterChildNode('IPITrib', TXMLIPITrib);
  RegisterChildNode('IPINT', TXMLIPINT);
  inherited;
end;

function TXMLIPI.Get_ClEnq: WideString;
begin
  Result := ChildNodes['clEnq'].Text;
end;

procedure TXMLIPI.Set_ClEnq(Value: WideString);
begin
  ChildNodes['clEnq'].NodeValue := Value;
end;

function TXMLIPI.Get_CNPJProd: WideString;
begin
  Result := ChildNodes['CNPJProd'].Text;
end;

procedure TXMLIPI.Set_CNPJProd(Value: WideString);
begin
  ChildNodes['CNPJProd'].NodeValue := Value;
end;

function TXMLIPI.Get_CSelo: WideString;
begin
  Result := ChildNodes['cSelo'].Text;
end;

procedure TXMLIPI.Set_CSelo(Value: WideString);
begin
  ChildNodes['cSelo'].NodeValue := Value;
end;

function TXMLIPI.Get_QSelo: WideString;
begin
  Result := ChildNodes['qSelo'].Text;
end;

procedure TXMLIPI.Set_QSelo(Value: WideString);
begin
  ChildNodes['qSelo'].NodeValue := Value;
end;

function TXMLIPI.Get_CEnq: WideString;
begin
  Result := ChildNodes['cEnq'].Text;
end;

procedure TXMLIPI.Set_CEnq(Value: WideString);
begin
  ChildNodes['cEnq'].NodeValue := Value;
end;

function TXMLIPI.Get_IPITrib: IXMLIPITrib;
begin
  Result := ChildNodes['IPITrib'] as IXMLIPITrib;
end;

function TXMLIPI.Get_IPINT: IXMLIPINT;
begin
  Result := ChildNodes['IPINT'] as IXMLIPINT;
end;

{ TXMLIPITrib }

function TXMLIPITrib.Get_CST: WideString;
begin
  Result := ChildNodes['CST'].Text;
end;

procedure TXMLIPITrib.Set_CST(Value: WideString);
begin
  ChildNodes['CST'].NodeValue := Value;
end;

function TXMLIPITrib.Get_VBC: WideString;
begin
  Result := ChildNodes['vBC'].Text;
end;

procedure TXMLIPITrib.Set_VBC(Value: WideString);
begin
  ChildNodes['vBC'].NodeValue := Value;
end;

function TXMLIPITrib.Get_PIPI: WideString;
begin
  Result := ChildNodes['pIPI'].Text;
end;

procedure TXMLIPITrib.Set_PIPI(Value: WideString);
begin
  ChildNodes['pIPI'].NodeValue := Value;
end;

function TXMLIPITrib.Get_QUnid: WideString;
begin
  Result := ChildNodes['qUnid'].Text;
end;

procedure TXMLIPITrib.Set_QUnid(Value: WideString);
begin
  ChildNodes['qUnid'].NodeValue := Value;
end;

function TXMLIPITrib.Get_VUnid: WideString;
begin
  Result := ChildNodes['vUnid'].Text;
end;

procedure TXMLIPITrib.Set_VUnid(Value: WideString);
begin
  ChildNodes['vUnid'].NodeValue := Value;
end;

function TXMLIPITrib.Get_VIPI: WideString;
begin
  Result := ChildNodes['vIPI'].Text;
end;

procedure TXMLIPITrib.Set_VIPI(Value: WideString);
begin
  ChildNodes['vIPI'].NodeValue := Value;
end;

{ TXMLIPINT }

function TXMLIPINT.Get_CST: WideString;
begin
  Result := ChildNodes['CST'].Text;
end;

procedure TXMLIPINT.Set_CST(Value: WideString);
begin
  ChildNodes['CST'].NodeValue := Value;
end;

{ TXMLII }

function TXMLII.Get_VBC: WideString;
begin
  Result := ChildNodes['vBC'].Text;
end;

procedure TXMLII.Set_VBC(Value: WideString);
begin
  ChildNodes['vBC'].NodeValue := Value;
end;

function TXMLII.Get_VDespAdu: WideString;
begin
  Result := ChildNodes['vDespAdu'].Text;
end;

procedure TXMLII.Set_VDespAdu(Value: WideString);
begin
  ChildNodes['vDespAdu'].NodeValue := Value;
end;

function TXMLII.Get_VII: WideString;
begin
  Result := ChildNodes['vII'].Text;
end;

procedure TXMLII.Set_VII(Value: WideString);
begin
  ChildNodes['vII'].NodeValue := Value;
end;

function TXMLII.Get_VIOF: WideString;
begin
  Result := ChildNodes['vIOF'].Text;
end;

procedure TXMLII.Set_VIOF(Value: WideString);
begin
  ChildNodes['vIOF'].NodeValue := Value;
end;

{ TXMLPIS }

procedure TXMLPIS.AfterConstruction;
begin
  RegisterChildNode('PISAliq', TXMLPISAliq);
  RegisterChildNode('PISQtde', TXMLPISQtde);
  RegisterChildNode('PISNT', TXMLPISNT);
  RegisterChildNode('PISOutr', TXMLPISOutr);
  inherited;
end;

function TXMLPIS.Get_PISAliq: IXMLPISAliq;
begin
  Result := ChildNodes['PISAliq'] as IXMLPISAliq;
end;

function TXMLPIS.Get_PISQtde: IXMLPISQtde;
begin
  Result := ChildNodes['PISQtde'] as IXMLPISQtde;
end;

function TXMLPIS.Get_PISNT: IXMLPISNT;
begin
  Result := ChildNodes['PISNT'] as IXMLPISNT;
end;

function TXMLPIS.Get_PISOutr: IXMLPISOutr;
begin
  Result := ChildNodes['PISOutr'] as IXMLPISOutr;
end;

{ TXMLPISAliq }

function TXMLPISAliq.Get_CST: WideString;
begin
  Result := ChildNodes['CST'].Text;
end;

procedure TXMLPISAliq.Set_CST(Value: WideString);
begin
  ChildNodes['CST'].NodeValue := Value;
end;

function TXMLPISAliq.Get_VBC: WideString;
begin
  Result := ChildNodes['vBC'].Text;
end;

procedure TXMLPISAliq.Set_VBC(Value: WideString);
begin
  ChildNodes['vBC'].NodeValue := Value;
end;

function TXMLPISAliq.Get_PPIS: WideString;
begin
  Result := ChildNodes['pPIS'].Text;
end;

procedure TXMLPISAliq.Set_PPIS(Value: WideString);
begin
  ChildNodes['pPIS'].NodeValue := Value;
end;

function TXMLPISAliq.Get_VPIS: WideString;
begin
  Result := ChildNodes['vPIS'].Text;
end;

procedure TXMLPISAliq.Set_VPIS(Value: WideString);
begin
  ChildNodes['vPIS'].NodeValue := Value;
end;

{ TXMLPISQtde }

function TXMLPISQtde.Get_CST: WideString;
begin
  Result := ChildNodes['CST'].Text;
end;

procedure TXMLPISQtde.Set_CST(Value: WideString);
begin
  ChildNodes['CST'].NodeValue := Value;
end;

function TXMLPISQtde.Get_QBCProd: WideString;
begin
  Result := ChildNodes['qBCProd'].Text;
end;

procedure TXMLPISQtde.Set_QBCProd(Value: WideString);
begin
  ChildNodes['qBCProd'].NodeValue := Value;
end;

function TXMLPISQtde.Get_VAliqProd: WideString;
begin
  Result := ChildNodes['vAliqProd'].Text;
end;

procedure TXMLPISQtde.Set_VAliqProd(Value: WideString);
begin
  ChildNodes['vAliqProd'].NodeValue := Value;
end;

function TXMLPISQtde.Get_VPIS: WideString;
begin
  Result := ChildNodes['vPIS'].Text;
end;

procedure TXMLPISQtde.Set_VPIS(Value: WideString);
begin
  ChildNodes['vPIS'].NodeValue := Value;
end;

{ TXMLPISNT }

function TXMLPISNT.Get_CST: WideString;
begin
  Result := ChildNodes['CST'].Text;
end;

procedure TXMLPISNT.Set_CST(Value: WideString);
begin
  ChildNodes['CST'].NodeValue := Value;
end;

{ TXMLPISOutr }

function TXMLPISOutr.Get_CST: WideString;
begin
  Result := ChildNodes['CST'].Text;
end;

procedure TXMLPISOutr.Set_CST(Value: WideString);
begin
  ChildNodes['CST'].NodeValue := Value;
end;

function TXMLPISOutr.Get_VBC: WideString;
begin
  Result := ChildNodes['vBC'].Text;
end;

procedure TXMLPISOutr.Set_VBC(Value: WideString);
begin
  ChildNodes['vBC'].NodeValue := Value;
end;

function TXMLPISOutr.Get_PPIS: WideString;
begin
  Result := ChildNodes['pPIS'].Text;
end;

procedure TXMLPISOutr.Set_PPIS(Value: WideString);
begin
  ChildNodes['pPIS'].NodeValue := Value;
end;

function TXMLPISOutr.Get_QBCProd: WideString;
begin
  Result := ChildNodes['qBCProd'].Text;
end;

procedure TXMLPISOutr.Set_QBCProd(Value: WideString);
begin
  ChildNodes['qBCProd'].NodeValue := Value;
end;

function TXMLPISOutr.Get_VAliqProd: WideString;
begin
  Result := ChildNodes['vAliqProd'].Text;
end;

procedure TXMLPISOutr.Set_VAliqProd(Value: WideString);
begin
  ChildNodes['vAliqProd'].NodeValue := Value;
end;

function TXMLPISOutr.Get_VPIS: WideString;
begin
  Result := ChildNodes['vPIS'].Text;
end;

procedure TXMLPISOutr.Set_VPIS(Value: WideString);
begin
  ChildNodes['vPIS'].NodeValue := Value;
end;

{ TXMLPISST }

function TXMLPISST.Get_VBC: WideString;
begin
  Result := ChildNodes['vBC'].Text;
end;

procedure TXMLPISST.Set_VBC(Value: WideString);
begin
  ChildNodes['vBC'].NodeValue := Value;
end;

function TXMLPISST.Get_PPIS: WideString;
begin
  Result := ChildNodes['pPIS'].Text;
end;

procedure TXMLPISST.Set_PPIS(Value: WideString);
begin
  ChildNodes['pPIS'].NodeValue := Value;
end;

function TXMLPISST.Get_QBCProd: WideString;
begin
  Result := ChildNodes['qBCProd'].Text;
end;

procedure TXMLPISST.Set_QBCProd(Value: WideString);
begin
  ChildNodes['qBCProd'].NodeValue := Value;
end;

function TXMLPISST.Get_VAliqProd: WideString;
begin
  Result := ChildNodes['vAliqProd'].Text;
end;

procedure TXMLPISST.Set_VAliqProd(Value: WideString);
begin
  ChildNodes['vAliqProd'].NodeValue := Value;
end;

function TXMLPISST.Get_VPIS: WideString;
begin
  Result := ChildNodes['vPIS'].Text;
end;

procedure TXMLPISST.Set_VPIS(Value: WideString);
begin
  ChildNodes['vPIS'].NodeValue := Value;
end;

{ TXMLCOFINS }

procedure TXMLCOFINS.AfterConstruction;
begin
  RegisterChildNode('COFINSAliq', TXMLCOFINSAliq);
  RegisterChildNode('COFINSQtde', TXMLCOFINSQtde);
  RegisterChildNode('COFINSNT', TXMLCOFINSNT);
  RegisterChildNode('COFINSOutr', TXMLCOFINSOutr);
  inherited;
end;

function TXMLCOFINS.Get_COFINSAliq: IXMLCOFINSAliq;
begin
  Result := ChildNodes['COFINSAliq'] as IXMLCOFINSAliq;
end;

function TXMLCOFINS.Get_COFINSQtde: IXMLCOFINSQtde;
begin
  Result := ChildNodes['COFINSQtde'] as IXMLCOFINSQtde;
end;

function TXMLCOFINS.Get_COFINSNT: IXMLCOFINSNT;
begin
  Result := ChildNodes['COFINSNT'] as IXMLCOFINSNT;
end;

function TXMLCOFINS.Get_COFINSOutr: IXMLCOFINSOutr;
begin
  Result := ChildNodes['COFINSOutr'] as IXMLCOFINSOutr;
end;

{ TXMLCOFINSAliq }

function TXMLCOFINSAliq.Get_CST: WideString;
begin
  Result := ChildNodes['CST'].Text;
end;

procedure TXMLCOFINSAliq.Set_CST(Value: WideString);
begin
  ChildNodes['CST'].NodeValue := Value;
end;

function TXMLCOFINSAliq.Get_VBC: WideString;
begin
  Result := ChildNodes['vBC'].Text;
end;

procedure TXMLCOFINSAliq.Set_VBC(Value: WideString);
begin
  ChildNodes['vBC'].NodeValue := Value;
end;

function TXMLCOFINSAliq.Get_PCOFINS: WideString;
begin
  Result := ChildNodes['pCOFINS'].Text;
end;

procedure TXMLCOFINSAliq.Set_PCOFINS(Value: WideString);
begin
  ChildNodes['pCOFINS'].NodeValue := Value;
end;

function TXMLCOFINSAliq.Get_VCOFINS: WideString;
begin
  Result := ChildNodes['vCOFINS'].Text;
end;

procedure TXMLCOFINSAliq.Set_VCOFINS(Value: WideString);
begin
  ChildNodes['vCOFINS'].NodeValue := Value;
end;

{ TXMLCOFINSQtde }

function TXMLCOFINSQtde.Get_CST: WideString;
begin
  Result := ChildNodes['CST'].Text;
end;

procedure TXMLCOFINSQtde.Set_CST(Value: WideString);
begin
  ChildNodes['CST'].NodeValue := Value;
end;

function TXMLCOFINSQtde.Get_QBCProd: WideString;
begin
  Result := ChildNodes['qBCProd'].Text;
end;

procedure TXMLCOFINSQtde.Set_QBCProd(Value: WideString);
begin
  ChildNodes['qBCProd'].NodeValue := Value;
end;

function TXMLCOFINSQtde.Get_VAliqProd: WideString;
begin
  Result := ChildNodes['vAliqProd'].Text;
end;

procedure TXMLCOFINSQtde.Set_VAliqProd(Value: WideString);
begin
  ChildNodes['vAliqProd'].NodeValue := Value;
end;

function TXMLCOFINSQtde.Get_VCOFINS: WideString;
begin
  Result := ChildNodes['vCOFINS'].Text;
end;

procedure TXMLCOFINSQtde.Set_VCOFINS(Value: WideString);
begin
  ChildNodes['vCOFINS'].NodeValue := Value;
end;

{ TXMLCOFINSNT }

function TXMLCOFINSNT.Get_CST: WideString;
begin
  Result := ChildNodes['CST'].Text;
end;

procedure TXMLCOFINSNT.Set_CST(Value: WideString);
begin
  ChildNodes['CST'].NodeValue := Value;
end;

{ TXMLCOFINSOutr }

function TXMLCOFINSOutr.Get_CST: WideString;
begin
  Result := ChildNodes['CST'].Text;
end;

procedure TXMLCOFINSOutr.Set_CST(Value: WideString);
begin
  ChildNodes['CST'].NodeValue := Value;
end;

function TXMLCOFINSOutr.Get_VBC: WideString;
begin
  Result := ChildNodes['vBC'].Text;
end;

procedure TXMLCOFINSOutr.Set_VBC(Value: WideString);
begin
  ChildNodes['vBC'].NodeValue := Value;
end;

function TXMLCOFINSOutr.Get_PCOFINS: WideString;
begin
  Result := ChildNodes['pCOFINS'].Text;
end;

procedure TXMLCOFINSOutr.Set_PCOFINS(Value: WideString);
begin
  ChildNodes['pCOFINS'].NodeValue := Value;
end;

function TXMLCOFINSOutr.Get_QBCProd: WideString;
begin
  Result := ChildNodes['qBCProd'].Text;
end;

procedure TXMLCOFINSOutr.Set_QBCProd(Value: WideString);
begin
  ChildNodes['qBCProd'].NodeValue := Value;
end;

function TXMLCOFINSOutr.Get_VAliqProd: WideString;
begin
  Result := ChildNodes['vAliqProd'].Text;
end;

procedure TXMLCOFINSOutr.Set_VAliqProd(Value: WideString);
begin
  ChildNodes['vAliqProd'].NodeValue := Value;
end;

function TXMLCOFINSOutr.Get_VCOFINS: WideString;
begin
  Result := ChildNodes['vCOFINS'].Text;
end;

procedure TXMLCOFINSOutr.Set_VCOFINS(Value: WideString);
begin
  ChildNodes['vCOFINS'].NodeValue := Value;
end;

{ TXMLCOFINSST }

function TXMLCOFINSST.Get_VBC: WideString;
begin
  Result := ChildNodes['vBC'].Text;
end;

procedure TXMLCOFINSST.Set_VBC(Value: WideString);
begin
  ChildNodes['vBC'].NodeValue := Value;
end;

function TXMLCOFINSST.Get_PCOFINS: WideString;
begin
  Result := ChildNodes['pCOFINS'].Text;
end;

procedure TXMLCOFINSST.Set_PCOFINS(Value: WideString);
begin
  ChildNodes['pCOFINS'].NodeValue := Value;
end;

function TXMLCOFINSST.Get_QBCProd: WideString;
begin
  Result := ChildNodes['qBCProd'].Text;
end;

procedure TXMLCOFINSST.Set_QBCProd(Value: WideString);
begin
  ChildNodes['qBCProd'].NodeValue := Value;
end;

function TXMLCOFINSST.Get_VAliqProd: WideString;
begin
  Result := ChildNodes['vAliqProd'].Text;
end;

procedure TXMLCOFINSST.Set_VAliqProd(Value: WideString);
begin
  ChildNodes['vAliqProd'].NodeValue := Value;
end;

function TXMLCOFINSST.Get_VCOFINS: WideString;
begin
  Result := ChildNodes['vCOFINS'].Text;
end;

procedure TXMLCOFINSST.Set_VCOFINS(Value: WideString);
begin
  ChildNodes['vCOFINS'].NodeValue := Value;
end;

{ TXMLISSQN }

function TXMLISSQN.Get_VBC: WideString;
begin
  Result := ChildNodes['vBC'].Text;
end;

procedure TXMLISSQN.Set_VBC(Value: WideString);
begin
  ChildNodes['vBC'].NodeValue := Value;
end;

function TXMLISSQN.Get_VAliq: WideString;
begin
  Result := ChildNodes['vAliq'].Text;
end;

procedure TXMLISSQN.Set_VAliq(Value: WideString);
begin
  ChildNodes['vAliq'].NodeValue := Value;
end;

function TXMLISSQN.Get_VISSQN: WideString;
begin
  Result := ChildNodes['vISSQN'].Text;
end;

procedure TXMLISSQN.Set_VISSQN(Value: WideString);
begin
  ChildNodes['vISSQN'].NodeValue := Value;
end;

function TXMLISSQN.Get_CMunFG: WideString;
begin
  Result := ChildNodes['cMunFG'].Text;
end;

procedure TXMLISSQN.Set_CMunFG(Value: WideString);
begin
  ChildNodes['cMunFG'].NodeValue := Value;
end;

function TXMLISSQN.Get_CListServ: WideString;
begin
  Result := ChildNodes['cListServ'].Text;
end;

procedure TXMLISSQN.Set_CListServ(Value: WideString);
begin
  ChildNodes['cListServ'].NodeValue := Value;
end;

{ TXMLTotal }

procedure TXMLTotal.AfterConstruction;
begin
  RegisterChildNode('ICMSTot', TXMLICMSTot);
  RegisterChildNode('ISSQNtot', TXMLISSQNtot);
  RegisterChildNode('retTrib', TXMLRetTrib);
  inherited;
end;

function TXMLTotal.Get_ICMSTot: IXMLICMSTot;
begin
  Result := ChildNodes['ICMSTot'] as IXMLICMSTot;
end;

function TXMLTotal.Get_ISSQNtot: IXMLISSQNtot;
begin
  Result := ChildNodes['ISSQNtot'] as IXMLISSQNtot;
end;

function TXMLTotal.Get_RetTrib: IXMLRetTrib;
begin
  Result := ChildNodes['retTrib'] as IXMLRetTrib;
end;

{ TXMLICMSTot }

function TXMLICMSTot.Get_VBC: WideString;
begin
  Result := ChildNodes['vBC'].Text;
end;

procedure TXMLICMSTot.Set_VBC(Value: WideString);
begin
  ChildNodes['vBC'].NodeValue := Value;
end;

function TXMLICMSTot.Get_VICMS: WideString;
begin
  Result := ChildNodes['vICMS'].Text;
end;

procedure TXMLICMSTot.Set_VICMS(Value: WideString);
begin
  ChildNodes['vICMS'].NodeValue := Value;
end;

function TXMLICMSTot.Get_VBCST: WideString;
begin
  Result := ChildNodes['vBCST'].Text;
end;

procedure TXMLICMSTot.Set_VBCST(Value: WideString);
begin
  ChildNodes['vBCST'].NodeValue := Value;
end;

function TXMLICMSTot.Get_VST: WideString;
begin
  Result := ChildNodes['vST'].Text;
end;

procedure TXMLICMSTot.Set_VST(Value: WideString);
begin
  ChildNodes['vST'].NodeValue := Value;
end;

function TXMLICMSTot.Get_VProd: WideString;
begin
  Result := ChildNodes['vProd'].Text;
end;

procedure TXMLICMSTot.Set_VProd(Value: WideString);
begin
  ChildNodes['vProd'].NodeValue := Value;
end;

function TXMLICMSTot.Get_VFrete: WideString;
begin
  Result := ChildNodes['vFrete'].Text;
end;

procedure TXMLICMSTot.Set_VFrete(Value: WideString);
begin
  ChildNodes['vFrete'].NodeValue := Value;
end;

function TXMLICMSTot.Get_VSeg: WideString;
begin
  Result := ChildNodes['vSeg'].Text;
end;

procedure TXMLICMSTot.Set_VSeg(Value: WideString);
begin
  ChildNodes['vSeg'].NodeValue := Value;
end;

function TXMLICMSTot.Get_VDesc: WideString;
begin
  Result := ChildNodes['vDesc'].Text;
end;

procedure TXMLICMSTot.Set_VDesc(Value: WideString);
begin
  ChildNodes['vDesc'].NodeValue := Value;
end;

function TXMLICMSTot.Get_VII: WideString;
begin
  Result := ChildNodes['vII'].Text;
end;

procedure TXMLICMSTot.Set_VII(Value: WideString);
begin
  ChildNodes['vII'].NodeValue := Value;
end;

function TXMLICMSTot.Get_VIPI: WideString;
begin
  Result := ChildNodes['vIPI'].Text;
end;

procedure TXMLICMSTot.Set_VIPI(Value: WideString);
begin
  ChildNodes['vIPI'].NodeValue := Value;
end;

function TXMLICMSTot.Get_VPIS: WideString;
begin
  Result := ChildNodes['vPIS'].Text;
end;

procedure TXMLICMSTot.Set_VPIS(Value: WideString);
begin
  ChildNodes['vPIS'].NodeValue := Value;
end;

function TXMLICMSTot.Get_VCOFINS: WideString;
begin
  Result := ChildNodes['vCOFINS'].Text;
end;

procedure TXMLICMSTot.Set_VCOFINS(Value: WideString);
begin
  ChildNodes['vCOFINS'].NodeValue := Value;
end;

function TXMLICMSTot.Get_VOutro: WideString;
begin
  Result := ChildNodes['vOutro'].Text;
end;

procedure TXMLICMSTot.Set_VOutro(Value: WideString);
begin
  ChildNodes['vOutro'].NodeValue := Value;
end;

function TXMLICMSTot.Get_VNF: WideString;
begin
  Result := ChildNodes['vNF'].Text;
end;

procedure TXMLICMSTot.Set_VNF(Value: WideString);
begin
  ChildNodes['vNF'].NodeValue := Value;
end;

{ TXMLISSQNtot }

function TXMLISSQNtot.Get_VServ: WideString;
begin
  Result := ChildNodes['vServ'].Text;
end;

procedure TXMLISSQNtot.Set_VServ(Value: WideString);
begin
  ChildNodes['vServ'].NodeValue := Value;
end;

function TXMLISSQNtot.Get_VBC: WideString;
begin
  Result := ChildNodes['vBC'].Text;
end;

procedure TXMLISSQNtot.Set_VBC(Value: WideString);
begin
  ChildNodes['vBC'].NodeValue := Value;
end;

function TXMLISSQNtot.Get_VISS: WideString;
begin
  Result := ChildNodes['vISS'].Text;
end;

procedure TXMLISSQNtot.Set_VISS(Value: WideString);
begin
  ChildNodes['vISS'].NodeValue := Value;
end;

function TXMLISSQNtot.Get_VPIS: WideString;
begin
  Result := ChildNodes['vPIS'].Text;
end;

procedure TXMLISSQNtot.Set_VPIS(Value: WideString);
begin
  ChildNodes['vPIS'].NodeValue := Value;
end;

function TXMLISSQNtot.Get_VCOFINS: WideString;
begin
  Result := ChildNodes['vCOFINS'].Text;
end;

procedure TXMLISSQNtot.Set_VCOFINS(Value: WideString);
begin
  ChildNodes['vCOFINS'].NodeValue := Value;
end;

{ TXMLRetTrib }

function TXMLRetTrib.Get_VRetPIS: WideString;
begin
  Result := ChildNodes['vRetPIS'].Text;
end;

procedure TXMLRetTrib.Set_VRetPIS(Value: WideString);
begin
  ChildNodes['vRetPIS'].NodeValue := Value;
end;

function TXMLRetTrib.Get_VRetCOFINS: WideString;
begin
  Result := ChildNodes['vRetCOFINS'].Text;
end;

procedure TXMLRetTrib.Set_VRetCOFINS(Value: WideString);
begin
  ChildNodes['vRetCOFINS'].NodeValue := Value;
end;

function TXMLRetTrib.Get_VRetCSLL: WideString;
begin
  Result := ChildNodes['vRetCSLL'].Text;
end;

procedure TXMLRetTrib.Set_VRetCSLL(Value: WideString);
begin
  ChildNodes['vRetCSLL'].NodeValue := Value;
end;

function TXMLRetTrib.Get_VBCIRRF: WideString;
begin
  Result := ChildNodes['vBCIRRF'].Text;
end;

procedure TXMLRetTrib.Set_VBCIRRF(Value: WideString);
begin
  ChildNodes['vBCIRRF'].NodeValue := Value;
end;

function TXMLRetTrib.Get_VIRRF: WideString;
begin
  Result := ChildNodes['vIRRF'].Text;
end;

procedure TXMLRetTrib.Set_VIRRF(Value: WideString);
begin
  ChildNodes['vIRRF'].NodeValue := Value;
end;

function TXMLRetTrib.Get_VBCRetPrev: WideString;
begin
  Result := ChildNodes['vBCRetPrev'].Text;
end;

procedure TXMLRetTrib.Set_VBCRetPrev(Value: WideString);
begin
  ChildNodes['vBCRetPrev'].NodeValue := Value;
end;

function TXMLRetTrib.Get_VRetPrev: WideString;
begin
  Result := ChildNodes['vRetPrev'].Text;
end;

procedure TXMLRetTrib.Set_VRetPrev(Value: WideString);
begin
  ChildNodes['vRetPrev'].NodeValue := Value;
end;

{ TXMLTransp }

procedure TXMLTransp.AfterConstruction;
begin
  RegisterChildNode('transporta', TXMLTransporta);
  RegisterChildNode('retTransp', TXMLRetTransp);
  RegisterChildNode('veicTransp', TXMLTVeiculo);
  RegisterChildNode('reboque', TXMLTVeiculo);
  RegisterChildNode('vol', TXMLVol);
  FReboque := CreateCollection(TXMLTVeiculoList, IXMLTVeiculo, 'reboque') as IXMLTVeiculoList;
  FVol := CreateCollection(TXMLVolList, IXMLVol, 'vol') as IXMLVolList;
  inherited;
end;

function TXMLTransp.Get_ModFrete: WideString;
begin
  Result := ChildNodes['modFrete'].Text;
end;

procedure TXMLTransp.Set_ModFrete(Value: WideString);
begin
  ChildNodes['modFrete'].NodeValue := Value;
end;

function TXMLTransp.Get_Transporta: IXMLTransporta;
begin
  Result := ChildNodes['transporta'] as IXMLTransporta;
end;

function TXMLTransp.Get_RetTransp: IXMLRetTransp;
begin
  Result := ChildNodes['retTransp'] as IXMLRetTransp;
end;

function TXMLTransp.Get_VeicTransp: IXMLTVeiculo;
begin
  Result := ChildNodes['veicTransp'] as IXMLTVeiculo;
end;

function TXMLTransp.Get_Reboque: IXMLTVeiculoList;
begin
  Result := FReboque;
end;

function TXMLTransp.Get_Vol: IXMLVolList;
begin
  Result := FVol;
end;

{ TXMLTransporta }

function TXMLTransporta.Get_CNPJ: WideString;
begin
  Result := ChildNodes['CNPJ'].Text;
end;

procedure TXMLTransporta.Set_CNPJ(Value: WideString);
begin
  ChildNodes['CNPJ'].NodeValue := Value;
end;

function TXMLTransporta.Get_CPF: WideString;
begin
  Result := ChildNodes['CPF'].Text;
end;

procedure TXMLTransporta.Set_CPF(Value: WideString);
begin
  ChildNodes['CPF'].NodeValue := Value;
end;

function TXMLTransporta.Get_XNome: WideString;
begin
  Result := ChildNodes['xNome'].Text;
end;

procedure TXMLTransporta.Set_XNome(Value: WideString);
begin
  ChildNodes['xNome'].NodeValue := Value;
end;

function TXMLTransporta.Get_IE: WideString;
begin
  Result := ChildNodes['IE'].Text;
end;

procedure TXMLTransporta.Set_IE(Value: WideString);
begin
  ChildNodes['IE'].NodeValue := Value;
end;

function TXMLTransporta.Get_XEnder: WideString;
begin
  Result := ChildNodes['xEnder'].Text;
end;

procedure TXMLTransporta.Set_XEnder(Value: WideString);
begin
  ChildNodes['xEnder'].NodeValue := Value;
end;

function TXMLTransporta.Get_XMun: WideString;
begin
  Result := ChildNodes['xMun'].Text;
end;

procedure TXMLTransporta.Set_XMun(Value: WideString);
begin
  ChildNodes['xMun'].NodeValue := Value;
end;

function TXMLTransporta.Get_UF: WideString;
begin
  Result := ChildNodes['UF'].Text;
end;

procedure TXMLTransporta.Set_UF(Value: WideString);
begin
  ChildNodes['UF'].NodeValue := Value;
end;

{ TXMLRetTransp }

function TXMLRetTransp.Get_VServ: WideString;
begin
  Result := ChildNodes['vServ'].Text;
end;

procedure TXMLRetTransp.Set_VServ(Value: WideString);
begin
  ChildNodes['vServ'].NodeValue := Value;
end;

function TXMLRetTransp.Get_VBCRet: WideString;
begin
  Result := ChildNodes['vBCRet'].Text;
end;

procedure TXMLRetTransp.Set_VBCRet(Value: WideString);
begin
  ChildNodes['vBCRet'].NodeValue := Value;
end;

function TXMLRetTransp.Get_PICMSRet: WideString;
begin
  Result := ChildNodes['pICMSRet'].Text;
end;

procedure TXMLRetTransp.Set_PICMSRet(Value: WideString);
begin
  ChildNodes['pICMSRet'].NodeValue := Value;
end;

function TXMLRetTransp.Get_VICMSRet: WideString;
begin
  Result := ChildNodes['vICMSRet'].Text;
end;

procedure TXMLRetTransp.Set_VICMSRet(Value: WideString);
begin
  ChildNodes['vICMSRet'].NodeValue := Value;
end;

function TXMLRetTransp.Get_CFOP: WideString;
begin
  Result := ChildNodes['CFOP'].Text;
end;

procedure TXMLRetTransp.Set_CFOP(Value: WideString);
begin
  ChildNodes['CFOP'].NodeValue := Value;
end;

function TXMLRetTransp.Get_CMunFG: WideString;
begin
  Result := ChildNodes['cMunFG'].Text;
end;

procedure TXMLRetTransp.Set_CMunFG(Value: WideString);
begin
  ChildNodes['cMunFG'].NodeValue := Value;
end;

{ TXMLTVeiculo }

function TXMLTVeiculo.Get_Placa: WideString;
begin
  Result := ChildNodes['placa'].Text;
end;

procedure TXMLTVeiculo.Set_Placa(Value: WideString);
begin
  ChildNodes['placa'].NodeValue := Value;
end;

function TXMLTVeiculo.Get_UF: WideString;
begin
  Result := ChildNodes['UF'].Text;
end;

procedure TXMLTVeiculo.Set_UF(Value: WideString);
begin
  ChildNodes['UF'].NodeValue := Value;
end;

function TXMLTVeiculo.Get_RNTC: WideString;
begin
  Result := ChildNodes['RNTC'].Text;
end;

procedure TXMLTVeiculo.Set_RNTC(Value: WideString);
begin
  ChildNodes['RNTC'].NodeValue := Value;
end;

{ TXMLTVeiculoList }

function TXMLTVeiculoList.Add: IXMLTVeiculo;
begin
  Result := AddItem(-1) as IXMLTVeiculo;
end;

function TXMLTVeiculoList.Insert(const Index: Integer): IXMLTVeiculo;
begin
  Result := AddItem(Index) as IXMLTVeiculo;
end;
function TXMLTVeiculoList.Get_Item(Index: Integer): IXMLTVeiculo;
begin
  Result := List[Index] as IXMLTVeiculo;
end;

{ TXMLVol }

procedure TXMLVol.AfterConstruction;
begin
  RegisterChildNode('lacres', TXMLLacres);
  FLacres := CreateCollection(TXMLLacresList, IXMLLacres, 'lacres') as IXMLLacresList;
  inherited;
end;

function TXMLVol.Get_QVol: WideString;
begin
  Result := ChildNodes['qVol'].Text;
end;

procedure TXMLVol.Set_QVol(Value: WideString);
begin
  ChildNodes['qVol'].NodeValue := Value;
end;

function TXMLVol.Get_Esp: WideString;
begin
  Result := ChildNodes['esp'].Text;
end;

procedure TXMLVol.Set_Esp(Value: WideString);
begin
  ChildNodes['esp'].NodeValue := Value;
end;

function TXMLVol.Get_Marca: WideString;
begin
  Result := ChildNodes['marca'].Text;
end;

procedure TXMLVol.Set_Marca(Value: WideString);
begin
  ChildNodes['marca'].NodeValue := Value;
end;

function TXMLVol.Get_NVol: WideString;
begin
  Result := ChildNodes['nVol'].Text;
end;

procedure TXMLVol.Set_NVol(Value: WideString);
begin
  ChildNodes['nVol'].NodeValue := Value;
end;

function TXMLVol.Get_PesoL: WideString;
begin
  Result := ChildNodes['pesoL'].Text;
end;

procedure TXMLVol.Set_PesoL(Value: WideString);
begin
  ChildNodes['pesoL'].NodeValue := Value;
end;

function TXMLVol.Get_PesoB: WideString;
begin
  Result := ChildNodes['pesoB'].Text;
end;

procedure TXMLVol.Set_PesoB(Value: WideString);
begin
  ChildNodes['pesoB'].NodeValue := Value;
end;

function TXMLVol.Get_Lacres: IXMLLacresList;
begin
  Result := FLacres;
end;

{ TXMLVolList }

function TXMLVolList.Add: IXMLVol;
begin
  Result := AddItem(-1) as IXMLVol;
end;

function TXMLVolList.Insert(const Index: Integer): IXMLVol;
begin
  Result := AddItem(Index) as IXMLVol;
end;
function TXMLVolList.Get_Item(Index: Integer): IXMLVol;
begin
  Result := List[Index] as IXMLVol;
end;

{ TXMLLacres }

function TXMLLacres.Get_NLacre: WideString;
begin
  Result := ChildNodes['nLacre'].Text;
end;

procedure TXMLLacres.Set_NLacre(Value: WideString);
begin
  ChildNodes['nLacre'].NodeValue := Value;
end;

{ TXMLLacresList }

function TXMLLacresList.Add: IXMLLacres;
begin
  Result := AddItem(-1) as IXMLLacres;
end;

function TXMLLacresList.Insert(const Index: Integer): IXMLLacres;
begin
  Result := AddItem(Index) as IXMLLacres;
end;
function TXMLLacresList.Get_Item(Index: Integer): IXMLLacres;
begin
  Result := List[Index] as IXMLLacres;
end;

{ TXMLCobr }

procedure TXMLCobr.AfterConstruction;
begin
  RegisterChildNode('fat', TXMLFat);
  RegisterChildNode('dup', TXMLDup);
  FDup := CreateCollection(TXMLDupList, IXMLDup, 'dup') as IXMLDupList;
  inherited;
end;

function TXMLCobr.Get_Fat: IXMLFat;
begin
  Result := ChildNodes['fat'] as IXMLFat;
end;

function TXMLCobr.Get_Dup: IXMLDupList;
begin
  Result := FDup;
end;

{ TXMLFat }

function TXMLFat.Get_NFat: WideString;
begin
  Result := ChildNodes['nFat'].Text;
end;

procedure TXMLFat.Set_NFat(Value: WideString);
begin
  ChildNodes['nFat'].NodeValue := Value;
end;

function TXMLFat.Get_VOrig: WideString;
begin
  Result := ChildNodes['vOrig'].Text;
end;

procedure TXMLFat.Set_VOrig(Value: WideString);
begin
  ChildNodes['vOrig'].NodeValue := Value;
end;

function TXMLFat.Get_VDesc: WideString;
begin
  Result := ChildNodes['vDesc'].Text;
end;

procedure TXMLFat.Set_VDesc(Value: WideString);
begin
  ChildNodes['vDesc'].NodeValue := Value;
end;

function TXMLFat.Get_VLiq: WideString;
begin
  Result := ChildNodes['vLiq'].Text;
end;

procedure TXMLFat.Set_VLiq(Value: WideString);
begin
  ChildNodes['vLiq'].NodeValue := Value;
end;

{ TXMLDup }

function TXMLDup.Get_NDup: WideString;
begin
  Result := ChildNodes['nDup'].Text;
end;

procedure TXMLDup.Set_NDup(Value: WideString);
begin
  ChildNodes['nDup'].NodeValue := Value;
end;

function TXMLDup.Get_DVenc: WideString;
begin
  Result := ChildNodes['dVenc'].Text;
end;

procedure TXMLDup.Set_DVenc(Value: WideString);
begin
  ChildNodes['dVenc'].NodeValue := Value;
end;

function TXMLDup.Get_VDup: WideString;
begin
  Result := ChildNodes['vDup'].Text;
end;

procedure TXMLDup.Set_VDup(Value: WideString);
begin
  ChildNodes['vDup'].NodeValue := Value;
end;

{ TXMLDupList }

function TXMLDupList.Add: IXMLDup;
begin
  Result := AddItem(-1) as IXMLDup;
end;

function TXMLDupList.Insert(const Index: Integer): IXMLDup;
begin
  Result := AddItem(Index) as IXMLDup;
end;
function TXMLDupList.Get_Item(Index: Integer): IXMLDup;
begin
  Result := List[Index] as IXMLDup;
end;

{ TXMLInfAdic }

procedure TXMLInfAdic.AfterConstruction;
begin
  RegisterChildNode('obsCont', TXMLObsCont);
  RegisterChildNode('obsFisco', TXMLObsFisco);
  RegisterChildNode('procRef', TXMLProcRef);
  FProcRef := CreateCollection(TXMLProcRefList, IXMLProcRef, 'procRef') as IXMLProcRefList;
  inherited;
end;

function TXMLInfAdic.Get_InfAdFisco: WideString;
begin
  Result := ChildNodes['infAdFisco'].Text;
end;

procedure TXMLInfAdic.Set_InfAdFisco(Value: WideString);
begin
  ChildNodes['infAdFisco'].NodeValue := Value;
end;

function TXMLInfAdic.Get_InfCpl: WideString;
begin
  Result := ChildNodes['infCpl'].Text;
end;

procedure TXMLInfAdic.Set_InfCpl(Value: WideString);
begin
  ChildNodes['infCpl'].NodeValue := Value;
end;

function TXMLInfAdic.Get_ObsCont: IXMLObsCont;
begin
  Result := ChildNodes['obsCont'] as IXMLObsCont;
end;

function TXMLInfAdic.Get_ObsFisco: IXMLObsFisco;
begin
  Result := ChildNodes['obsFisco'] as IXMLObsFisco;
end;

function TXMLInfAdic.Get_ProcRef: IXMLProcRefList;
begin
  Result := FProcRef;
end;

{ TXMLObsCont }

function TXMLObsCont.Get_XCampo: WideString;
begin
  Result := AttributeNodes['xCampo'].Text;
end;

procedure TXMLObsCont.Set_XCampo(Value: WideString);
begin
  SetAttribute('xCampo', Value);
end;

function TXMLObsCont.Get_XTexto: WideString;
begin
  Result := ChildNodes['xTexto'].Text;
end;

procedure TXMLObsCont.Set_XTexto(Value: WideString);
begin
  ChildNodes['xTexto'].NodeValue := Value;
end;

{ TXMLObsFisco }

function TXMLObsFisco.Get_XCampo: WideString;
begin
  Result := AttributeNodes['xCampo'].Text;
end;

procedure TXMLObsFisco.Set_XCampo(Value: WideString);
begin
  SetAttribute('xCampo', Value);
end;

function TXMLObsFisco.Get_XTexto: WideString;
begin
  Result := ChildNodes['xTexto'].Text;
end;

procedure TXMLObsFisco.Set_XTexto(Value: WideString);
begin
  ChildNodes['xTexto'].NodeValue := Value;
end;

{ TXMLProcRef }

function TXMLProcRef.Get_NProc: WideString;
begin
  Result := ChildNodes['nProc'].Text;
end;

procedure TXMLProcRef.Set_NProc(Value: WideString);
begin
  ChildNodes['nProc'].NodeValue := Value;
end;

function TXMLProcRef.Get_IndProc: WideString;
begin
  Result := ChildNodes['indProc'].Text;
end;

procedure TXMLProcRef.Set_IndProc(Value: WideString);
begin
  ChildNodes['indProc'].NodeValue := Value;
end;

{ TXMLProcRefList }

function TXMLProcRefList.Add: IXMLProcRef;
begin
  Result := AddItem(-1) as IXMLProcRef;
end;

function TXMLProcRefList.Insert(const Index: Integer): IXMLProcRef;
begin
  Result := AddItem(Index) as IXMLProcRef;
end;
function TXMLProcRefList.Get_Item(Index: Integer): IXMLProcRef;
begin
  Result := List[Index] as IXMLProcRef;
end;

{ TXMLExporta }

function TXMLExporta.Get_UFEmbarq: WideString;
begin
  Result := ChildNodes['UFEmbarq'].Text;
end;

procedure TXMLExporta.Set_UFEmbarq(Value: WideString);
begin
  ChildNodes['UFEmbarq'].NodeValue := Value;
end;

function TXMLExporta.Get_XLocEmbarq: WideString;
begin
  Result := ChildNodes['xLocEmbarq'].Text;
end;

procedure TXMLExporta.Set_XLocEmbarq(Value: WideString);
begin
  ChildNodes['xLocEmbarq'].NodeValue := Value;
end;

{ TXMLCompra }

function TXMLCompra.Get_XNEmp: WideString;
begin
  Result := ChildNodes['xNEmp'].Text;
end;

procedure TXMLCompra.Set_XNEmp(Value: WideString);
begin
  ChildNodes['xNEmp'].NodeValue := Value;
end;

function TXMLCompra.Get_XPed: WideString;
begin
  Result := ChildNodes['xPed'].Text;
end;

procedure TXMLCompra.Set_XPed(Value: WideString);
begin
  ChildNodes['xPed'].NodeValue := Value;
end;

function TXMLCompra.Get_XCont: WideString;
begin
  Result := ChildNodes['xCont'].Text;
end;

procedure TXMLCompra.Set_XCont(Value: WideString);
begin
  ChildNodes['xCont'].NodeValue := Value;
end;

{ TXMLSignatureType }

procedure TXMLSignatureType.AfterConstruction;
begin
  RegisterChildNode('SignedInfo', TXMLSignedInfoType);
  RegisterChildNode('SignatureValue', TXMLSignatureValueType);
  RegisterChildNode('KeyInfo', TXMLKeyInfoType);
  inherited;
end;

function TXMLSignatureType.Get_Id: WideString;
begin
  Result := AttributeNodes['Id'].Text;
end;

procedure TXMLSignatureType.Set_Id(Value: WideString);
begin
  SetAttribute('Id', Value);
end;

function TXMLSignatureType.Get_SignedInfo: IXMLSignedInfoType;
begin
  Result := ChildNodes['SignedInfo'] as IXMLSignedInfoType;
end;

function TXMLSignatureType.Get_SignatureValue: IXMLSignatureValueType;
begin
  Result := ChildNodes['SignatureValue'] as IXMLSignatureValueType;
end;

function TXMLSignatureType.Get_KeyInfo: IXMLKeyInfoType;
begin
  Result := ChildNodes['KeyInfo'] as IXMLKeyInfoType;
end;

{ TXMLSignedInfoType }

procedure TXMLSignedInfoType.AfterConstruction;
begin
  RegisterChildNode('CanonicalizationMethod', TXMLCanonicalizationMethod);
  RegisterChildNode('SignatureMethod', TXMLSignatureMethod);
  RegisterChildNode('Reference', TXMLReferenceType);
  inherited;
end;

function TXMLSignedInfoType.Get_Id: WideString;
begin
  Result := AttributeNodes['Id'].Text;
end;

procedure TXMLSignedInfoType.Set_Id(Value: WideString);
begin
  SetAttribute('Id', Value);
end;

function TXMLSignedInfoType.Get_CanonicalizationMethod: IXMLCanonicalizationMethod;
begin
  Result := ChildNodes['CanonicalizationMethod'] as IXMLCanonicalizationMethod;
end;

function TXMLSignedInfoType.Get_SignatureMethod: IXMLSignatureMethod;
begin
  Result := ChildNodes['SignatureMethod'] as IXMLSignatureMethod;
end;

function TXMLSignedInfoType.Get_Reference: IXMLReferenceType;
begin
  Result := ChildNodes['Reference'] as IXMLReferenceType;
end;

{ TXMLCanonicalizationMethod }

function TXMLCanonicalizationMethod.Get_Algorithm: WideString;
begin
  Result := AttributeNodes['Algorithm'].Text;
end;

procedure TXMLCanonicalizationMethod.Set_Algorithm(Value: WideString);
begin
  SetAttribute('Algorithm', Value);
end;

{ TXMLSignatureMethod }

function TXMLSignatureMethod.Get_Algorithm: WideString;
begin
  Result := AttributeNodes['Algorithm'].Text;
end;

procedure TXMLSignatureMethod.Set_Algorithm(Value: WideString);
begin
  SetAttribute('Algorithm', Value);
end;

{ TXMLReferenceType }

procedure TXMLReferenceType.AfterConstruction;
begin
  RegisterChildNode('Transforms', TXMLTransformsType);
  RegisterChildNode('DigestMethod', TXMLDigestMethod);
  inherited;
end;

function TXMLReferenceType.Get_Id: WideString;
begin
  Result := AttributeNodes['Id'].Text;
end;

procedure TXMLReferenceType.Set_Id(Value: WideString);
begin
  SetAttribute('Id', Value);
end;

function TXMLReferenceType.Get_URI: WideString;
begin
  Result := AttributeNodes['URI'].Text;
end;

procedure TXMLReferenceType.Set_URI(Value: WideString);
begin
  SetAttribute('URI', Value);
end;

function TXMLReferenceType.Get_Type_: WideString;
begin
  Result := AttributeNodes['Type'].Text;
end;

procedure TXMLReferenceType.Set_Type_(Value: WideString);
begin
  SetAttribute('Type', Value);
end;

function TXMLReferenceType.Get_Transforms: IXMLTransformsType;
begin
  Result := ChildNodes['Transforms'] as IXMLTransformsType;
end;

function TXMLReferenceType.Get_DigestMethod: IXMLDigestMethod;
begin
  Result := ChildNodes['DigestMethod'] as IXMLDigestMethod;
end;

function TXMLReferenceType.Get_DigestValue: WideString;
begin
  Result := ChildNodes['DigestValue'].Text;
end;

procedure TXMLReferenceType.Set_DigestValue(Value: WideString);
begin
  ChildNodes['DigestValue'].NodeValue := Value;
end;

{ TXMLTransformsType }

procedure TXMLTransformsType.AfterConstruction;
begin
  RegisterChildNode('Transform', TXMLTransformType);
  ItemTag := 'Transform';
  ItemInterface := IXMLTransformType;
  inherited;
end;

function TXMLTransformsType.Get_Transform(Index: Integer): IXMLTransformType;
begin
  Result := List[Index] as IXMLTransformType;
end;

function TXMLTransformsType.Add: IXMLTransformType;
begin
  Result := AddItem(-1) as IXMLTransformType;
end;

function TXMLTransformsType.Insert(const Index: Integer): IXMLTransformType;
begin
  Result := AddItem(Index) as IXMLTransformType;
end;

{ TXMLTransformType }

procedure TXMLTransformType.AfterConstruction;
begin
  ItemTag := 'XPath';
  ItemInterface := IXMLNode;
  inherited;
end;

function TXMLTransformType.Get_Algorithm: WideString;
begin
  Result := AttributeNodes['Algorithm'].Text;
end;

procedure TXMLTransformType.Set_Algorithm(Value: WideString);
begin
  SetAttribute('Algorithm', Value);
end;

function TXMLTransformType.Get_XPath(Index: Integer): WideString;
begin
  Result := List[Index].Text;
end;

function TXMLTransformType.Add(const XPath: WideString): IXMLNode;
begin
  Result := AddItem(-1);
  Result.NodeValue := XPath;
end;

function TXMLTransformType.Insert(const Index: Integer; const XPath: WideString): IXMLNode;
begin
  Result := AddItem(Index);
  Result.NodeValue := XPath;
end;

{ TXMLDigestMethod }

function TXMLDigestMethod.Get_Algorithm: WideString;
begin
  Result := AttributeNodes['Algorithm'].Text;
end;

procedure TXMLDigestMethod.Set_Algorithm(Value: WideString);
begin
  SetAttribute('Algorithm', Value);
end;

{ TXMLSignatureValueType }

function TXMLSignatureValueType.Get_Id: WideString;
begin
  Result := AttributeNodes['Id'].Text;
end;

procedure TXMLSignatureValueType.Set_Id(Value: WideString);
begin
  SetAttribute('Id', Value);
end;

{ TXMLKeyInfoType }

procedure TXMLKeyInfoType.AfterConstruction;
begin
  RegisterChildNode('X509Data', TXMLX509DataType);
  inherited;
end;

function TXMLKeyInfoType.Get_Id: WideString;
begin
  Result := AttributeNodes['Id'].Text;
end;

procedure TXMLKeyInfoType.Set_Id(Value: WideString);
begin
  SetAttribute('Id', Value);
end;

function TXMLKeyInfoType.Get_X509Data: IXMLX509DataType;
begin
  Result := ChildNodes['X509Data'] as IXMLX509DataType;
end;

{ TXMLX509DataType }

function TXMLX509DataType.Get_X509Certificate: WideString;
begin
  Result := ChildNodes['X509Certificate'].Text;
end;

procedure TXMLX509DataType.Set_X509Certificate(Value: WideString);
begin
  ChildNodes['X509Certificate'].NodeValue := Value;
end;

end.