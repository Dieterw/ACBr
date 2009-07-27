{******************************************************************************}
{ Projeto: Componentes ACBr                                                    }
{  Biblioteca multiplataforma de componentes Delphi para interação com equipa- }
{ mentos de Automação Comercial utilizados no Brasil                           }
{                                                                              }
{ Direitos Autorais Reservados (c) 2004 Daniel Simoes de Almeida               }
{                                                                              }
{ Colaboradores nesse arquivo:                                                 }
{                                                                              }
{  Você pode obter a última versão desse arquivo na pagina do  Projeto ACBr    }
{ Componentes localizado em      http://www.sourceforge.net/projects/acbr      }
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
|* 28/07/2008: Ederson Selvati
|*  - Primeira Versao: Criaçao e Distribuiçao da Primeira Versao
|*  - Modificação do TACBrSintegra passando de apenas classe para TComponent
|* 12/08/2008: Ederson Selvati
|*  - Adicao dos registros 60M e 60A (Movimento de ECF)
|* 20/08/2008: Ederson Selvati
|*  - Adicao do registro 60D (Movimento de ECF por produto)
|* 23/08/2008: Ederson Selvati
|*  - Adicao do registro 74 (Registro de inventário)
|* 13/11/2008: Ederson Selvati
|*  - Adicao do registro 61 (Nota fiscal de venda a consumidor)
|*  - Adicao do registro 61R (Itens das notas constantes do registro 61
|* 12/03/2009: Ederson Selvati
|*  - Adicao do registro 60I
|*  - Adicao do registro 60R
|* 20/05/2009: Walter Donizete Faria
|*  - Adicao do registro 70
|*  - Adicao do registro 71
|* 27/07/2009: Jose Aparecido da Silva
|   - Adicao do registro 85
|   - Adicao do registro 86
******************************************************************************}

{$I ACBr.inc}

unit ACBrSintegra;

interface

uses Classes, SysUtils, Contnrs, ACBrConsts;

type
  TVersaoValidador = (vv523,vv524);

  TRegistro10 = class
  private
    FCNPJ: string;
    FCodigoConvenio: string;
    FFinalidadeArquivo: string;
    FNaturezaInformacoes: string;
    FRazaoSocial: string;
    FInscricao: string;
    FCidade: string;
    FDataFinal: TDateTime;
    FDataInicial: TDateTime;
    FTelefone: string;
    FEstado: string;
  public
    property CNPJ: string read FCNPJ write FCNPJ;
    property Inscricao: string read FInscricao write FInscricao;
    property RazaoSocial: string read FRazaoSocial write FRazaoSocial;
    property Cidade: string read FCidade write FCidade;
    property Estado: string read FEstado write FEstado;
    property Telefone: string read FTelefone write FTelefone;
    property DataInicial: TDateTime read FDataInicial write FDataInicial;
    property DataFinal: TDateTime read FDataFinal write FDataFinal;
    property CodigoConvenio: string read FCodigoConvenio write FCodigoConvenio;
    property NaturezaInformacoes: string read FNaturezaInformacoes
      write FNaturezaInformacoes;
    property FinalidadeArquivo: string read FFinalidadeArquivo write FFinalidadeArquivo;
  end;

  TRegistro11 = class
  private
    FResponsavel: string;
    FBairro: string;
    FCep: string;
    FNumero: string;
    FComplemento : String;
    FEndereco: string;
    FTelefone: string;
  public
    property Endereco: string read FEndereco write FEndereco;
    property Numero: string read FNumero write FNumero;
    property Complemento: string read FComplemento write FComplemento;
    property Bairro: string read FBairro write FBairro;
    property Cep: string read FCep write FCep;
    property Responsavel: string read FResponsavel write FResponsavel;
    property Telefone: string read FTelefone write FTelefone;
  end;

  TRegistro54 = class
  private
    FAliquota: Double;
    FBaseST: Double;
    FBasedeCalculo: Double;
    FQuantidade: Double;
    FValorDescontoDespesa: Double;
    FValorIpi: Double;
    FValor: Double;
    FNumeroItem: Integer;
    FCST: string;
    FCodigo: string;
    FCFOP: string;
    FDescricao: string;
    FCPFCNPJ: string;
    FNumero: string;
    FModelo: string;
    FSerie: string;
  public
    property CPFCNPJ: string read FCPFCNPJ write FCPFCNPJ;
    property Modelo: string read FModelo write FModelo;
    property Serie: string read FSerie write FSerie;
    property Numero: string read FNumero write FNumero;
    property CFOP: string read FCFOP write FCFOP;
    property CST: string read FCST write FCST;
    property NumeroItem: Integer read FNumeroItem write FNumeroItem;
    property Codigo: string read FCodigo write FCodigo;
    property Descricao: string read FDescricao write FDescricao;
    property Quantidade: Double read FQuantidade write FQuantidade;
    property Valor: Double read FValor write FValor;
    property ValorDescontoDespesa: Double read FValorDescontoDespesa
      write FValorDescontoDespesa;
    property BasedeCalculo: Double read FBasedeCalculo write FBasedeCalculo;
    property BaseST: Double read FBaseST write FBaseST;
    property ValorIpi: Double read FValorIpi write FValorIpi;
    property Aliquota: Double read FAliquota write FAliquota;
  end;

  {Lista de objetos do tipo Registro54}
  TRegistros54 = class(TObjectList)
  protected
    procedure SetObject (Index: Integer; Item: TRegistro54);
    function GetObject (Index: Integer): TRegistro54;
    procedure Insert (Index: Integer; Obj: TRegistro54);
  public
    function Add (Obj: TRegistro54): Integer;
    property Objects [Index: Integer]: TRegistro54
      read GetObject write SetObject; default;
  end;

  TRegistro74 = class
  private
    FValorProduto: Double;
    FCodigoPosse: string;
    FInscricaoPossuidor: string;
    FCodigo: string;
    FCNPJPossuidor: string;
    FUFPossuidor: string;
    FData: TDateTime;
    FQuantidade: Double;
  public
    property Data: TDateTime read FData write FData;
    property Codigo: string read FCodigo write FCodigo;
    property Quantidade: Double read FQuantidade write FQuantidade;
    property ValorProduto: Double read FValorProduto write FValorProduto;
    property CodigoPosse: string read FCodigoPosse write FCodigoPosse;
    property CNPJPossuidor: string read FCNPJPossuidor write FCNPJPossuidor;
    property InscricaoPossuidor: string read FInscricaoPossuidor
      write FInscricaoPossuidor;
    property UFPossuidor: string read FUFPossuidor write FUFPossuidor;
  end;

  {Lista de objetos do tipo Registro74}
  TRegistros74 = class(TObjectList)
  protected
    procedure SetObject (Index: Integer; Item: TRegistro74);
    function GetObject (Index: Integer): TRegistro74;
    procedure Insert (Index: Integer; Obj: TRegistro74);
  public
    function Add (Obj: TRegistro74): Integer;
    property Objects [Index: Integer]: TRegistro74
      read GetObject write SetObject; default;
  end;

  TRegistro75 = class
  private
    FCodigo: string;
    FDescricao: string;
    FReducao: Double;
    FBaseST: Double;
    FAliquotaIpi: Double;
    FNCM: string;
    FUnidade: string;
    FAliquotaICMS: Double;
    FDataFinal: TDateTime;
    FDataInicial: TDateTime;
  public
    property DataInicial: TDateTime read FDataInicial write FDataInicial;
    property DataFinal: TDateTime read FDataFinal write FDataFinal;
    property Codigo: string read FCodigo write FCodigo;
    property NCM: string read FNCM write FNCM;
    property Descricao: string read FDescricao write FDescricao;
    property Unidade: string read FUnidade write FUnidade;
    property AliquotaIpi: Double read FAliquotaIpi write FAliquotaIpi;
    property AliquotaICMS: Double read FAliquotaICMS write FAliquotaICMS;
    property Reducao: Double read FReducao write FReducao;
    property BaseST: Double read FBaseST write FBaseST;
  end;

  {Lista de objetos do tipo Registro54}
  TRegistros75 = class(TObjectList)
  protected
    procedure SetObject (Index: Integer; Item: TRegistro75);
    function GetObject (Index: Integer): TRegistro75;
    procedure Insert (Index: Integer; Obj: TRegistro75);
    function GetRegistroExiste(FCodigo: string): Boolean;
  public
    function Add (Obj: TRegistro75): Integer;
    property Objects [Index: Integer]: TRegistro75
      read GetObject write SetObject; default;
  end;

  TRegistro50 = class
  private
    FOutras: Double;
    FSituacao: string;
    FAliquota: Double;
    FIsentas: Double;
    FIcms: Double;
    FValorContabil: Double;
    FBasedeCalculo: Double;
    FEmissorDocumento: string;
    FCfop: string;
    FInscricao: string;
    FUF: string;
    FSerie: string;
    FCPFCNPJ: string;
    FModelo: string;
    FNumero: string;
    FDataDocumento: TDateTime;
    FRegistros54: TRegistros54;
  public
    property CPFCNPJ: string read FCPFCNPJ write FCPFCNPJ;
    property Inscricao: string read FInscricao write FInscricao;
    property DataDocumento: TDateTime read FDataDocumento write FDataDocumento;
    property UF: string read FUF write FUF;
    property Modelo: string read FModelo write FModelo;
    property Serie: string read FSerie write FSerie;
    property Numero: string read FNumero write FNumero;
    property Cfop: string read FCfop write FCfop;
    property EmissorDocumento: string read FEmissorDocumento
      write FEmissorDocumento;
    property ValorContabil: Double read FValorContabil write FValorContabil;
    property BasedeCalculo: Double read FBasedeCalculo write FBasedeCalculo;
    property Icms: Double read FIcms write FIcms;
    property Isentas: Double read FIsentas write FIsentas;
    property Outras: Double read FOutras write FOutras;
    property Aliquota: Double read FAliquota write FAliquota;
    property Situacao: string read FSituacao write FSituacao;
    property Registros54: TRegistros54 read FRegistros54 write FRegistros54;
    constructor Create;
    destructor Destroy; override;
  end;

  {Lista de objetos do tipo Registro50}
  TRegistros50 = class(TObjectList)
  protected
    procedure SetObject (Index: Integer; Item: TRegistro50);
    function GetObject (Index: Integer): TRegistro50;
    procedure Insert (Index: Integer; Obj: TRegistro50);
  public
    function Add (Obj: TRegistro50): Integer;
    property Objects [Index: Integer]: TRegistro50
      read GetObject write SetObject; default;
  end;

  TRegistro51 = class
  private
    FValorIpi: Double;
    FValorContabil: Double;
    FSerie: string;
    FDataDocumento: TDateTime;
    FCPFCNPJ: string;
    FCfop: string;
    FString: string;
    FInscricao: string;
    FSituacao: string;
    FValorIsentas: Double;
    FValorOutras: Double;
    FEstado: string;

  public
    property CPFCNPJ: string read FCPFCNPJ write FCPFCNPJ;
    property Inscricao: string read FInscricao write FInscricao;
    property DataDocumento: TDateTime read FDataDocumento write FDataDocumento;
    property Estado: string read FEstado write FEstado;
    property Serie: string read FSerie write FSerie;
    property Numero: string read FString write FString;
    property CFOP: string read FCfop write FCfop;
    property ValorContabil: Double read FValorContabil write FValorContabil;
    property ValorIpi: Double read FValorIpi write FValorIpi;
    property ValorOutras: Double read FValorOutras write FValorOutras;
    property ValorIsentas: Double read FValorIsentas write FValorIsentas;
    property Situacao: string read FSituacao write FSituacao;
  end;

  {Lista de objetos do tipo Registro51}
  TRegistros51 = class(TObjectList)
  protected
    procedure SetObject (Index: Integer; Item: TRegistro51);
    function GetObject (Index: Integer): TRegistro51;
    procedure Insert (Index: Integer; Obj: TRegistro51);
  public
    function Add (Obj: TRegistro51): Integer;
    property Objects [Index: Integer]: TRegistro51
      read GetObject write SetObject; default;
  end;

  TRegistro53 = class
  private
    FSerie: string;
    FDataDocumento: TDateTime;
    FCPFCNPJ: string;
    FCfop: string;
    FString: string;
    FInscricao: string;
    FSituacao: string;
    FEstado: string;
    FCodigoAntecipacao: string;
    FBaseST: Double;
    FModelo: string;
    FEmitente: string;
    FDespesas: Double;
    FIcmsRetido: Double;
  public
    property CPFCNPJ: string read FCPFCNPJ write FCPFCNPJ;
    property Inscricao: string read FInscricao write FInscricao;
    property DataDocumento: TDateTime read FDataDocumento write FDataDocumento;
    property Estado: string read FEstado write FEstado;
    property Modelo: string read FModelo write FModelo;
    property Serie: string read FSerie write FSerie;
    property Numero: string read FString write FString;
    property CFOP: string read FCfop write FCfop;
    property Emitente: string read FEmitente write FEmitente;
    property BaseST: Double read FBaseST write FBaseST;
    property IcmsRetido: Double read FIcmsRetido write FIcmsRetido;
    property Despesas: Double read FDespesas write FDespesas;
    property Situacao: string read FSituacao write FSituacao;
    property CodigoAntecipacao: string read FCodigoAntecipacao write FCodigoAntecipacao;
  end;

  {Lista de objetos do tipo Registro53}
  TRegistros53 = class(TObjectList)
  protected
    procedure SetObject (Index: Integer; Item: TRegistro53);
    function GetObject (Index: Integer): TRegistro53;
    procedure Insert (Index: Integer; Obj: TRegistro53);
  public
    function Add (Obj: TRegistro53): Integer;
    property Objects [Index: Integer]: TRegistro53
      read GetObject write SetObject; default;
  end;

  TRegistro70 = class
  private
    FIcms: Double;
    FValorContabil: Double;
    FUF: string;
    FIsentas: Double;
    FSubSerie: string;
    FSerie: string;
    FDataDocumento: TDateTime;
    FModelo: string;
    FCPFCNPJ: string;
    FCfop: string;
    FNumero: string;
    FInscricao: string;
    FSituacao: string;
    FOutras: Double;
    FBasedeCalculo: Double;
    FCifFobOutros: string;
  public
    property CPFCNPJ: string read FCPFCNPJ write FCPFCNPJ;
    property Inscricao: string read FInscricao write FInscricao;
    property DataDocumento: TDateTime read FDataDocumento write FDataDocumento;
    property UF: string read FUF write FUF;
    property Modelo: string read FModelo write FModelo;
    property Serie: string read FSerie write FSerie;
    property SubSerie: string read FSubSerie write FSubSerie;
    property Numero: string read FNumero write FNumero;
    property Cfop: string read FCfop write FCfop;
    property ValorContabil: Double read FValorContabil write FValorContabil;
    property BasedeCalculo: Double read FBasedeCalculo write FBasedeCalculo;
    property Icms: Double read FIcms write FIcms;
    property Isentas: Double read FIsentas write FIsentas;
    property Outras: Double read FOutras write FOutras;
    property CifFobOutros: string read FCifFobOutros write FCifFobOutros;
    property Situacao: string read FSituacao write FSituacao;
  end;

  {Lista de objetos do tipo Registro70}
  TRegistros70 = class(TObjectList)
  protected
    procedure SetObject (Index: Integer; Item: TRegistro70);
    function GetObject (Index: Integer): TRegistro70;
    procedure Insert (Index: Integer; Obj: TRegistro70);
  public
    function Add (Obj: TRegistro70): Integer;
    property Objects [Index: Integer]: TRegistro70
      read GetObject write SetObject; default;
  end;


  TRegistro71 = class
  private
    FCPFCNPJ: string;
    FInscricao: string;
    FDataDocumento: TDateTime;
    FModelo: string;
    FSerie: string;
    FSubSerie: string;
    FNumero: string;
    FUF: string;

    FUFNF: string;
    FCPFCNPJNF: string;
    FInscricaoNF: string;
    FDataNF: TDateTime;
    FModeloNF: string;
    FSerieNF: string;
    FNumeroNF: string;
    FValorNF: Double;

  public
    property CPFCNPJ: string read FCPFCNPJ write FCPFCNPJ;
    property Inscricao: string read FInscricao write FInscricao;
    property DataDocumento: TDateTime read FDataDocumento write FDataDocumento;
    property Modelo: string read FModelo write FModelo;
    property Serie: string read FSerie write FSerie;
    property SubSerie: string read FSubSerie write FSubSerie;
    property Numero: string read FNumero write FNumero;
    property UF: string read FUF write FUF;

    property CPFCNPJNF: string read FCPFCNPJNF write FCPFCNPJNF;
    property InscricaoNF: string read FInscricaoNF write FInscricaoNF;
    property DataNF: TDateTime read FDataNF write FDataNF;
    property ModeloNF: string read FModeloNF write FModeloNF;
    property SerieNF: string read FSerieNF write FSerieNF;
    property NumeroNF: string read FNumeroNF write FNumeroNF;
    property UFNF: string read FUFNF write FUFNF;
    property ValorNF: Double read FValorNF write FValorNF;
  end;

  {Lista de objetos do tipo Registro71}
  TRegistros71 = class(TObjectList)
  protected
    procedure SetObject (Index: Integer; Item: TRegistro71);
    function GetObject (Index: Integer): TRegistro71;
    procedure Insert (Index: Integer; Obj: TRegistro71);
  public
    function Add (Obj: TRegistro71): Integer;
    property Objects [Index: Integer]: TRegistro71
      read GetObject write SetObject; default;
  end;


  TRegistro60A = class
  private
    FNumSerie: string;
    FStAliquota: string;
    FEmissao: TDateTime;
    FValor: Double;
  public
    property Emissao: TDateTime read FEmissao write FEmissao;
    property NumSerie: string read FNumSerie write FNumSerie;
    property StAliquota: string read FStAliquota write FStAliquota;
    property Valor: Double read FValor write FValor;
  end;

  {Lista de objetos do tipo Registro60A}
  TRegistros60A = class(TObjectList)
  protected
    procedure SetObject (Index: Integer; Item: TRegistro60A);
    function GetObject (Index: Integer): TRegistro60A;
    procedure Insert (Index: Integer; Obj: TRegistro60A);
  public
    function Add (Obj: TRegistro60A): Integer;
    property Objects [Index: Integer]: TRegistro60A
      read GetObject write SetObject; default;
  end;

  TRegistro60I = class
  private
    FNumSerie: string;
    FStAliquota: string;
    FEmissao: TDateTime;
    FValor: Double;
    FCodigo: string;
    FValorIcms: Double;
    FQuantidade: Double;
    FBaseDeCalculo: Double;
    FItem: Integer;
    FCupom: string;
    FModeloDoc: string;
  public
    property Emissao: TDateTime read FEmissao write FEmissao;
    property NumSerie: string read FNumSerie write FNumSerie;
    property ModeloDoc: string read FModeloDoc write FModeloDoc;
    property Cupom: string read FCupom write FCupom;
    property Item: Integer read FItem write FItem;
    property Codigo: string read FCodigo write FCodigo;
    property Quantidade: Double read FQuantidade write FQuantidade;
    property Valor: Double read FValor write FValor;
    property BaseDeCalculo: Double read FBaseDeCalculo write FBaseDeCalculo;
    property StAliquota: string read FStAliquota write FStAliquota;
    property ValorIcms: Double read FValorIcms write FValorIcms;
  end;

  {Lista de objetos do tipo Registro60I}
  TRegistros60I = class(TObjectList)
  protected
    procedure SetObject (Index: Integer; Item: TRegistro60I);
    function GetObject (Index: Integer): TRegistro60I;
    procedure Insert (Index: Integer; Obj: TRegistro60I);
  public
    function Add (Obj: TRegistro60I): Integer;
    property Objects [Index: Integer]: TRegistro60I
      read GetObject write SetObject; default;
  end;

  TRegistro60D = class
  private
    FNumSerie: string;
    FStAliquota: string;
    FEmissao: TDateTime;
    FValor: Double;
    FCodigo: string;
    FValorIcms: Double;
    FQuantidade: Double;
    FBaseDeCalculo: Double;
  public
    property Emissao: TDateTime read FEmissao write FEmissao;
    property NumSerie: string read FNumSerie write FNumSerie;
    property Codigo: string read FCodigo write FCodigo;
    property Quantidade: Double read FQuantidade write FQuantidade;
    property Valor: Double read FValor write FValor;
    property BaseDeCalculo: Double read FBaseDeCalculo write FBaseDeCalculo;
    property StAliquota: string read FStAliquota write FStAliquota;
    property ValorIcms: Double read FValorIcms write FValorIcms;
  end;

  {Lista de objetos do tipo Registro60D}
  TRegistros60D = class(TObjectList)
  protected
    procedure SetObject (Index: Integer; Item: TRegistro60D);
    function GetObject (Index: Integer): TRegistro60D;
    procedure Insert (Index: Integer; Obj: TRegistro60D);
  public
    function Add (Obj: TRegistro60D): Integer;
    property Objects [Index: Integer]: TRegistro60D
      read GetObject write SetObject; default;
  end;

  TRegistro60R = class
  private
    FBaseDeCalculo: double;
    FValor: Double;
    FQtd: Double;
    FMesAno: string;
    FCodigo: string;
    FAliquota: string;

  public
    property MesAno: string read FMesAno write FMesAno;
    property Codigo: string read FCodigo write FCodigo;
    property Qtd: Double read FQtd write FQtd;
    property Valor: Double read FValor write FValor;
    property BaseDeCalculo: double read FBaseDeCalculo write FBaseDeCalculo;
    property Aliquota: string read FAliquota write FAliquota;
  end;

  {Lista de objetos do tipo Registro60D}
  TRegistros60R = class(TObjectList)
  protected
    procedure SetObject (Index: Integer; Item: TRegistro60R);
    function GetObject (Index: Integer): TRegistro60R;
    procedure Insert (Index: Integer; Obj: TRegistro60R);
  public
    function Add (Obj: TRegistro60R): Integer;
    property Objects [Index: Integer]: TRegistro60R
      read GetObject write SetObject; default;
  end;

  TRegistro60M = class
  private
    FCRO: Integer;
    FNumOrdem: Integer;
    FVendaBruta: Double;
    FModeloDoc: string;
    FValorGT: Double;
    FCRZ: Integer;
    FCooFinal: Integer;
    FCooInicial: Integer;
    FNumSerie: string;
    FEmissao: TDateTime;
    FRegs60A: TRegistros60A;
    FRegs60D: TRegistros60D;
    FRegs60I: TRegistros60I;
  public
    property Regs60A: TRegistros60A read FRegs60A write FRegs60A;
    property Regs60D: TRegistros60D read FRegs60D write FRegs60D;
    property Regs60I: TRegistros60I read FRegs60I write FRegs60I;
    
    property Emissao: TDateTime read FEmissao write FEmissao;
    property NumSerie: string read FNumSerie write FNumSerie;
    property NumOrdem: Integer read FNumOrdem write FNumOrdem;
    property ModeloDoc: string read FModeloDoc write FModeloDoc;
    property CooInicial: Integer read FCooInicial write FCooInicial;
    property CooFinal: Integer read FCooFinal write FCooFinal;
    property CRZ: Integer read FCRZ write FCRZ;
    property CRO: Integer read FCRO write FCRO;
    property VendaBruta: Double read FVendaBruta write FVendaBruta;
    property ValorGT: Double read FValorGT write FValorGT;
    constructor Create;
    destructor Destroy; override;
  end;

  {Lista de objetos do tipo Registro60M}
  TRegistros60M = class(TObjectList)
  protected
    procedure SetObject (Index: Integer; Item: TRegistro60M);
    function GetObject (Index: Integer): TRegistro60M;
    procedure Insert (Index: Integer; Obj: TRegistro60M);
  public
    function Add (Obj: TRegistro60M): Integer;
    property Objects [Index: Integer]: TRegistro60M
      read GetObject write SetObject; default;
  end;

  TRegistro61 = class
  private
    FEmissao: TDateTime;
    FValor: Double;
    FValorIcms: Double;
    FOutras: Double;
    FBaseDeCalculo: Double;
    FIsentas: Double;
    FNumOrdemInicial: integer;
    FNumOrdemFinal: integer;
    FModelo: string;
    FSubSerie: string;
    FSerie: string;
    FAliquota: Double;
  public
    property Emissao: TDateTime read FEmissao write FEmissao;
    property Modelo: string read FModelo write FModelo;
    property Serie: string read FSerie write FSerie;
    property SubSerie: string read FSubSerie write FSubSerie;
    property NumOrdemInicial: integer read FNumOrdemInicial
      write FNumOrdemInicial;
    property NumOrdemFinal: integer read FNumOrdemFinal
      write FNumOrdemFinal;
    property Valor: Double read FValor write FValor;
    property BaseDeCalculo: Double read FBaseDeCalculo write FBaseDeCalculo;
    property ValorIcms: Double read FValorIcms write FValorIcms;
    property Isentas: Double read FIsentas write FIsentas;
    property Outras: Double read FOutras write FOutras;
    property Aliquota: Double read FAliquota write FAliquota;
  end;

  {Lista de objetos do tipo Registro61}
  TRegistros61 = class(TObjectList)
  protected
    procedure SetObject (Index: Integer; Item: TRegistro61);
    function GetObject (Index: Integer): TRegistro61;
    procedure Insert (Index: Integer; Obj: TRegistro61);
  public
    function Add (Obj: TRegistro61): Integer;
    property Objects [Index: Integer]: TRegistro61
      read GetObject write SetObject; default;
  end;

  TRegistro61R = class
  private
    FAliquota: Double;
    FValor: Double;
    FQtd: Double;
    FMesAno: string;
    FCodigo: string;
    FBaseDeCalculo: Double;
  public
    property MesAno: string read FMesAno write FMesAno;
    property Codigo: string read FCodigo write FCodigo;
    property Qtd: Double read FQtd write FQtd;
    property Valor: Double read FValor write FValor;
    property BaseDeCalculo: Double read FBaseDeCalculo write FBaseDeCalculo;
    property Aliquota: Double read FAliquota write FAliquota;
  end;

  {Lista de objetos do tipo Registro61}
  TRegistros61R = class(TObjectList)
  protected
    procedure SetObject (Index: Integer; Item: TRegistro61R);
    function GetObject (Index: Integer): TRegistro61R;
    procedure Insert (Index: Integer; Obj: TRegistro61R);
  public
    function Add (Obj: TRegistro61R): Integer;
    property Objects [Index: Integer]: TRegistro61R
      read GetObject write SetObject; default;
  end;
  TRegistro85 = class
  private
    FDeclaracao: string;
    FDataDeclaracao: TDateTime;
    FNaturezaExportacao: string;
    FRegistroExportacao: String;
    FDataRegistro: TDateTime;
    FConhecimento:string;
    FDataConhecimento:TDateTime;
    FTipoConhecimento: String;
    FPais:string;
    FDataAverbacao:TDateTime;
    FNumeroNotaFiscal:String;
    FDataNotaFiscal:TDateTime;
    FModelo: string;
    FSerie: string;
  public
    property Declaracao: String read FDeclaracao write FDeclaracao;
    property DataDeclaracao: TDateTime read FDataDeclaracao write FDataDeclaracao;
    property NaturezaExportacao: string read FNaturezaExportacao write FNaturezaExportacao;
    property RegistroExportacao: String read FRegistroExportacao write FRegistroExportacao;
    property DataRegistro: TDateTime read FDataRegistro write FDataRegistro;
    property Conhecimento: string read FConhecimento write FConhecimento;
    property DataConhecimento: TDateTime read FDataConhecimento write FDataConhecimento;
    property TipoConhecimento: String read FTipoConhecimento write FTipoConhecimento;
    property Pais: string read FPais write FPais;
    property DataAverbacao: TDateTime read FDataAverbacao write FDataAverbacao;
    property NumeroNotaFiscal: string read FNumeroNotaFiscal write FNumeroNotaFiscal;
    property DataNotaFiscal: TDateTime read FDataNotaFiscal write FDataNotaFiscal;
    property Modelo: string read FModelo write FModelo;
    property Serie: string read FSerie write FSerie;
  end;

  {Lista de objetos do tipo Registro85}
  TRegistros85 = class(TObjectList)
  protected
    procedure SetObject (Index: Integer; Item: TRegistro85);
    function GetObject (Index: Integer): TRegistro85;
    procedure Insert (Index: Integer; Obj: TRegistro85);
  public
    function Add (Obj: TRegistro85): Integer;
    property Objects [Index: Integer]: TRegistro85
      read GetObject write SetObject; default;
  end;

  TRegistro86 = class
  private
    FRegistroExportacao:string;
    FDataRegistro:TDateTime;
    FCPFCNPJ: string;
    FInscricao: string;
    FUF: string;
    FNumeroNotaFiscal: string;
    FDataDocumento: TDateTime;
    FModelo: string;
    FSerie: string;
    FCodigo: string;
    FQuantidade: Double;
    FValorUnitario :Double;
    FValorTotalProduto: Double;
    FRelacionamento: string;
  public
    property RegistroExportacao: string read FRegistroExportacao write FRegistroExportacao;
    property DataRegistro: TDateTime read FDataRegistro write FDataRegistro;
    property CPFCNPJ: string read FCPFCNPJ write FCPFCNPJ;
    property Inscricao: string read FInscricao write FInscricao;
    property UF: string read FUF write FUF;
    property NumeroNotaFiscal: string read FNumeroNotaFiscal write FNumeroNotaFiscal;
    property DataDocumento: TDateTime read FDataDocumento write FDataDocumento;
    property Modelo: string read FModelo write FModelo;
    property Serie: string read FSerie write FSerie;
    property Codigo: string read FCodigo write FCodigo;
    property Quantidade: Double read FQuantidade write FQuantidade;
    property ValorUnitario: Double read FValorUnitario write FValorUnitario;
    property ValorTotalProduto: Double read FValorTotalProduto write FValorTotalProduto;
    property Relacionamento: string read FRelacionamento write FRelacionamento;
  end;

  {Lista de objetos do tipo Registro86}
  TRegistros86 = class(TObjectList)
  protected
    procedure SetObject (Index: Integer; Item: TRegistro86);
    function GetObject (Index: Integer): TRegistro86;
    procedure Insert (Index: Integer; Obj: TRegistro86);
  public
    function Add (Obj: TRegistro86): Integer;
    property Objects [Index: Integer]: TRegistro86
      read GetObject write SetObject; default;
  end;

  TACBrSintegra = class(TComponent)
  private
    FFileName: string;
    FRegistro10: TRegistro10;
    FRegistro11: TRegistro11;
    Arquivo: TextFile;
    FRegistros50: TRegistros50;
    FRegistros54: TRegistros54;
    FRegistros75: TRegistros75;
    FRegistros70: TRegistros70;
    FRegistros71: TRegistros71;

    FRegistros51: TRegistros51;
    FRegistros53: TRegistros53;
    FAtivo: Boolean;
    FRegistros60M: TRegistros60M;
    FRegistros60A: TRegistros60A;
    FVersaoValidador: TVersaoValidador;
    FRegistros60D: TRegistros60D;
    FRegistros74: TRegistros74;
    FRegistros61: TRegistros61;
    FRegistros61R: TRegistros61R;
    FRegistros60I: TRegistros60I;
    FRegistros60R: TRegistros60R;
    FRegistros85: TRegistros85;
    FRegistros86: TRegistros86;

    procedure GeraRegistro10;
    procedure GeraRegistro11;
    procedure GerarRegistros50;
    procedure GerarRegistros51;
    procedure GerarRegistros53;
    procedure GerarRegistros54;

    procedure GerarRegistros60M(Registro60M: TRegistro60M);
    procedure GerarRegistros60A(Registros60A: TRegistros60A);
    procedure GerarRegistros60D(Registros60D: TRegistros60D);
    procedure GerarRegistros60I(Registros60I: TRegistros60I);
    procedure GerarRegistros60R;

    procedure GerarRegistros61;
    procedure GerarRegistros61R;

    procedure GerarRegistros70;
    procedure GerarRegistros71;
    procedure GerarRegistros74;
    procedure GerarRegistros75;
    procedure GerarRegistros85;
    procedure GerarRegistros86;
    procedure GerarRegistros90;
    procedure WriteRecord(Rec: string);
    function GetRegistro60M(Emissao: TDateTime;NumSerie: string): TRegistro60M;
    procedure GerarConjuntoRegistros60;
    function GetVersao: string;
  public
    property Registro10: TRegistro10 read FRegistro10 write FRegistro10;
    property Registro11: TRegistro11 read FRegistro11 write FRegistro11;
    property Registros50: TRegistros50 read FRegistros50 write FRegistros50;
    property Registros51: TRegistros51 read FRegistros51 write FRegistros51;
    property Registros53: TRegistros53 read FRegistros53 write FRegistros53;
    property Registros54: TRegistros54 read FRegistros54 write FRegistros54;
    property Registros60M: TRegistros60M read FRegistros60M write FRegistros60M;
    property Registros60A: TRegistros60A read FRegistros60A write FRegistros60A;
    property Registros60D: TRegistros60D read FRegistros60D write FRegistros60D;
    property Registros60I: TRegistros60I read FRegistros60I write FRegistros60I;
    property Registros60R: TRegistros60R read FRegistros60R write FRegistros60R;
    property Registros61: TRegistros61 read FRegistros61 write FRegistros61;
    property Registros61R: TRegistros61R read FRegistros61R write FRegistros61R;
    property Registros70: TRegistros70 read FRegistros70 write FRegistros70;
    property Registros71: TRegistros71 read FRegistros71 write FRegistros71;
    property Registros74: TRegistros74 read FRegistros74 write FRegistros74;
    property Registros75: TRegistros75 read FRegistros75 write FRegistros75;
    property Registros85: TRegistros85 read FRegistros85 write FRegistros85;
    property Registros86: TRegistros86 read FRegistros86 write FRegistros86;
    property Ativo: Boolean read FAtivo write FAtivo;
    procedure LimparRegistros;
    procedure GeraArquivo;

    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property FileName: string read FFileName write FFileName;
    property VersaoValidador: TVersaoValidador read FVersaoValidador write
      FVersaoValidador;
    property Versao: string read GetVersao;
  end;

  function Sort50(Item1: Pointer;Item2: Pointer): Integer;
  function Sort51(Item1: Pointer;Item2: Pointer): Integer;
  function Sort53(Item1: Pointer;Item2: Pointer): Integer;
  function Sort60M(Item1: Pointer;Item2: Pointer): Integer;
  function Sort60A(Item1: Pointer;Item2: Pointer): Integer;
  function Sort60D(Item1: Pointer;Item2: Pointer): Integer;
  function Sort60I(Item1: Pointer;Item2: Pointer): Integer;
  function Sort70(Item1: Pointer;Item2: Pointer): Integer;
  function Sort71(Item1: Pointer;Item2: Pointer): Integer;
  function Sort74(Item1: Pointer;Item2: Pointer): Integer;
  function Sort75(Item1: Pointer;Item2: Pointer): Integer;
  function Sort85(Item1: Pointer;Item2: Pointer): Integer;
  function Sort86(Item1: Pointer;Item2: Pointer): Integer;

implementation

uses ACBrUtil;

{ TACBrSintegra }

constructor TACBrSintegra.Create(AOwner: TComponent);
begin
  inherited;
FRegistro10:=TRegistro10.Create;
FRegistro11:=TRegistro11.Create;
FRegistros50:=TRegistros50.Create(True);
FRegistros51:=TRegistros51.Create(True);
FRegistros53:=TRegistros53.Create(True);
FRegistros54:=TRegistros54.Create(True);
FRegistros60M:=TRegistros60M.Create(True);
FRegistros60A:=TRegistros60A.Create(True);
FRegistros60D:=TRegistros60D.Create(True);
FRegistros60I:=TRegistros60I.Create(True);
FRegistros60R:=TRegistros60R.Create(True);
FRegistros61:=TRegistros61.Create(True);
FRegistros61R:=TRegistros61R.Create(True);
FRegistros70:=TRegistros70.Create(True);
FRegistros71:=TRegistros71.Create(True);
FRegistros74:=TRegistros74.Create(True);
FRegistros75:=TRegistros75.Create(True);
    FRegistros85:=TRegistros85.Create(True);
    FRegistros86:=TRegistros86.Create(True);
FVersaoValidador:=vv524;
Ativo:=True;
end;

destructor TACBrSintegra.Destroy;
begin
LimparRegistros;
FRegistro10.Free;
FRegistro11.Free;
FRegistros50.Free;
FRegistros51.Free;
FRegistros53.Free;
FRegistros54.Free;
FRegistros60M.Free;
FRegistros60A.Free;
FRegistros60D.Free;
FRegistros60I.Free;
FRegistros60R.Free;
FRegistros61.Free;
FRegistros61R.Free;
FRegistros70.Free;
FRegistros71.Free;
FRegistros74.Free;
FRegistros75.Free;
    FRegistros85.Free;
    FRegistros86.Free;
Ativo:=False;
  inherited;
end;

procedure TACBrSintegra.WriteRecord(Rec: string);
begin
if Length(Rec)<>126 then
  raise Exception.Create('Registro inválido!'+#13+
    'Deve conter 126 posições. '+#13+
    'Registro: '+Rec+#13+
    'possui '+IntToStr(Length(Rec))+' posições.');
writeln(Arquivo, Rec);
end;

procedure TACBrSintegra.GeraArquivo;
begin
if Trim(FileName)='' then
  raise Exception.Create('Informe um nome de arquivo!');
AssignFile(Arquivo,FileName);
Rewrite(Arquivo);
try
  GeraRegistro10;
  GeraRegistro11;

  GerarRegistros50;
  GerarRegistros51;
  GerarRegistros53;
  GerarRegistros54;
  GerarConjuntoRegistros60;
  GerarRegistros60R;
  GerarRegistros61;
  GerarRegistros61R;
  GerarRegistros70;
  GerarRegistros71;
  GerarRegistros74;
  GerarRegistros75;
  GerarRegistros85;
  GerarRegistros86;

  GerarRegistros90;
finally
  CloseFile(Arquivo);
  LimparRegistros;
end;
end;

procedure TACBrSintegra.GerarConjuntoRegistros60;
var
  i: Integer;
  wregistro60M: TRegistro60M;
begin
//associo todos os registros 60A/D/I criados a um registro 60M existente
//com esta abordagem permite-se que o usuario adicione registros fora
//de ordem na aplicacao cliente, ex: adiciona analitico primeiramente ao master.
//Com isto não há obrigacao de amarrar analitico ao master..deixando por conta do componente
//nao sei dizer se este processo de ordenacao efetuado pode tornar-se lento

if FVersaoValidador=vv524 then
begin
  //60A
  for i:=0 to Registros60A.Count - 1 do
  begin
    wregistro60M:=GetRegistro60M(Registros60A[i].Emissao,Registros60A[i].NumSerie);
    if not Assigned(wregistro60M) then
      raise Exception.Create('Registro 60A sem registro 60M correspondente!'+#13+
        DateToStr(Registros60A[i].Emissao)+' - '+Registros60A[i].NumSerie);
    wregistro60M.Regs60A.Add(Registros60A[i]);
  end;

  //60D
  for i:=0 to Registros60D.Count - 1 do
  begin
    wregistro60M:=GetRegistro60M(Registros60D[i].Emissao,Registros60D[i].NumSerie);
    if not Assigned(wregistro60M) then
      raise Exception.Create('Registro 60D sem registro 60M correspondente!'+#13+
        DateToStr(Registros60D[i].Emissao)+' - '+Registros60D[i].NumSerie);
    wregistro60M.Regs60D.Add(Registros60D[i]);
  end;

  //60I
  for i:=0 to Registros60I.Count - 1 do
  begin
    wregistro60M:=GetRegistro60M(Registros60I[i].Emissao,Registros60I[i].NumSerie);
    if not Assigned(wregistro60M) then
      raise Exception.Create('Registro 60I sem registro 60M correspondente!'+#13+
        DateToStr(Registros60I[i].Emissao)+' - '+Registros60I[i].NumSerie);
    wregistro60M.Regs60I.Add(Registros60I[i]);
  end;

  //ordenando e gerando de acordo com o manual...
  Registros60M.Sort(Sort60M);
  for i:=0 to Registros60M.Count-1 do
  begin
    Registros60M[i].Regs60A.Sort(Sort60A);
    Registros60M[i].Regs60D.Sort(Sort60D);
    Registros60M[i].Regs60I.Sort(Sort60I);
    GerarRegistros60M(Registros60M[i]);
    GerarRegistros60A(Registros60M[i].Regs60A);
    GerarRegistros60D(Registros60M[i].Regs60D);
    GerarRegistros60I(Registros60M[i].Regs60I);
  end;
end
else if FVersaoValidador=vv523 then
begin
  //ordenando e gerando de acordo com o manual...
  Registros60M.Sort(Sort60M);
  for i:=0 to Registros60M.Count-1 do
    GerarRegistros60M(Registros60M[i]);
  Registros60A.Sort(Sort60A);
  GerarRegistros60A(Registros60A);
  Registros60D.Sort(Sort60D);
  GerarRegistros60D(Registros60D);
  Registros60I.Sort(Sort60I);
  GerarRegistros60I(Registros60I);
end;
end;

procedure TACBrSintegra.GeraRegistro10;
var
  wregistro: string;
begin
wregistro:='10'+TBStrZero(TiraPontos(Registro10.CNPJ),14);
wregistro:=wregistro+Padl(Trim(TiraPontos(Registro10.Inscricao)),14);
wregistro:=wregistro+Padl(Copy(Registro10.RazaoSocial,1,35),35);
wregistro:=wregistro+Padl(Copy(Registro10.Cidade,1,30),30);
wregistro:=wregistro+Padl(Registro10.Estado,2);
wregistro:=wregistro+TBStrZero(TiraPontos(Registro10.Telefone),10);
wregistro:=wregistro+FormatDateTime('yyyymmdd',Registro10.DataInicial);
wregistro:=wregistro+FormatDateTime('yyyymmdd',Registro10.DataFinal);
wregistro:=wregistro+Padl(Registro10.CodigoConvenio,1);
wregistro:=wregistro+Padl(Registro10.NaturezaInformacoes,1);
wregistro:=wregistro+Padl(Registro10.FinalidadeArquivo,1);
WriteRecord(wregistro);
end;

procedure TACBrSintegra.GeraRegistro11;
var
  wregistro: string;
begin
wregistro:='11';
wregistro:=wregistro+Padl(Copy(Registro11.Endereco,1,34),34);
wregistro:=wregistro+TBStrZero(TiraPontos(Registro11.Numero),5);
wregistro:=wregistro+Padl(Copy(Registro11.Complemento,1,22),22);
wregistro:=wregistro+Padl(Copy(Registro11.Bairro,1,15),15);
wregistro:=wregistro+TBStrZero(TiraPontos(Registro11.Cep),8);
wregistro:=wregistro+Padl(Copy(Registro11.Responsavel,1,28),28);
wregistro:=wregistro+TBStrZero(TiraPontos(Registro11.Telefone),12);
WriteRecord(wregistro);
end;

procedure TACBrSintegra.GerarRegistros50;
var
  wregistro: string;
  i: Integer;
begin
//Registro 50 requer ordenacao por data do documento
Registros50.Sort(Sort50);
for i:=0 to Registros50.Count-1 do
begin
  with Registros50[i] do
  begin
    wregistro:='50';
    wregistro:=wregistro+TBStrZero(TiraPontos(CPFCNPJ),14)+Padl(TiraPontos(Inscricao),14);
    wregistro:=wregistro+FormatDateTime('yyyymmdd',DataDocumento);
    wregistro:=wregistro+Padl(UF,2);
    wregistro:=wregistro+TBStrZero(Modelo,2);
    wregistro:=wregistro+Padl(Serie,3);
    wregistro:=wregistro+TBStrZero(Numero,6);
    wregistro:=wregistro+Padl(TiraPontos(Cfop),4);
    wregistro:=wregistro+Padl(EmissorDocumento,1);
    wregistro:=wregistro+TBStrZero(TiraPontos(FormatFloat('#,##0.00',ValorContabil)),13);
    wregistro:=wregistro+TBStrZero(TiraPontos(FormatFloat('#,##0.00',BasedeCalculo)),13);
    wregistro:=wregistro+TBStrZero(TiraPontos(FormatFloat('#,##0.00',Icms)),13);
    wregistro:=wregistro+TBStrZero(TiraPontos(FormatFloat('#,##0.00',Isentas)),13);
    wregistro:=wregistro+TBStrZero(TiraPontos(FormatFloat('#,##0.00',Outras)),13);
    wregistro:=wregistro+TBStrZero(TiraPontos(FormatFloat('#,##0.00',Aliquota)),4);
    wregistro:=wregistro+Padl(Situacao,1);
    WriteRecord(wregistro);
  end;
end;
end;

procedure TACBrSintegra.GerarRegistros51;
var
  wregistro: string;
  i: Integer;
begin
Registros51.Sort(Sort51);
for i := 0 to Registros51.Count-1 do
begin
  with Registros51[i] do
  begin
    wregistro:='51';
    wregistro:=wregistro+TBStrZero(TiraPontos(CPFCNPJ),14)+
      Padl(TiraPontos(Inscricao),14);
    wregistro:=wregistro+FormatDateTime('yyyymmdd',DataDocumento);
    wregistro:=wregistro+Padl(Estado,2);
    wregistro:=wregistro+Padl(Serie,3);
    wregistro:=wregistro+TBStrZero(Numero,6);
    wregistro:=wregistro+Padl(TiraPontos(Cfop),4);
    wregistro:=wregistro+TBStrZero(TiraPontos(FormatFloat('#,##0.00',ValorContabil)),13);
    wregistro:=wregistro+TBStrZero(TiraPontos(FormatFloat('#,##0.00',ValorIpi)),13);
    wregistro:=wregistro+TBStrZero(TiraPontos(FormatFloat('#,##0.00',ValorIsentas)),13);
    wregistro:=wregistro+TBStrZero(TiraPontos(FormatFloat('#,##0.00',ValorOutras)),13);
    wregistro:=wregistro+Space(20);
    wregistro:=wregistro+Padl(Situacao,1);
    WriteRecord(wregistro);
  end;
end;
end;

procedure TACBrSintegra.GerarRegistros53;
var
  wregistro: string;
  i: Integer;
begin
Registros53.Sort(Sort53);
for i:=0 to Registros53.Count-1 do
begin
  with Registros53[i] do
  begin
    wregistro:='53';
    wregistro:=wregistro+TBStrZero(TiraPontos(CPFCNPJ),14)+
      padl(TiraPontos(Inscricao),14);
    wregistro:=wregistro+FormatDateTime('yyyymmdd',DataDocumento);
    wregistro:=wregistro+Padl(Estado,2);
    wregistro:=wregistro+TBStrZero(Modelo,2);
    wregistro:=wregistro+Padl(Trim(Serie),3);
    wregistro:=wregistro+TBStrZero(Numero,6);
    wregistro:=wregistro+Padl(TiraPontos(CFOP),4);
    wregistro:=wregistro+Padl(Emitente,1);
    wregistro:=wregistro+TBStrZero(TiraPontos(FormatFloat('#,##0.00',BaseST)),13);
    wregistro:=wregistro+TBStrZero(TiraPontos(FormatFloat('#,##0.00',IcmsRetido)),13);
    wregistro:=wregistro+TBStrZero(TiraPontos(FormatFloat('#,##0.00',Despesas)),13);
    wregistro:=wregistro+Padl(Situacao,1);
    wregistro:=wregistro+Padl(CodigoAntecipacao,1);
    wregistro:=wregistro+Space(29);
    WriteRecord(wregistro);
  end;
end;
end;

procedure TACBrSintegra.GerarRegistros54;
var
  wregistro: string;
  i: Integer;
begin
for i:=0 to Registros54.Count-1 do
begin
    wregistro:='54';
    wregistro:=wregistro+TBStrZero(TiraPontos(Registros54[i].CPFCNPJ),14);
    wregistro:=wregistro+TBStrZero(Registros54[i].Modelo,2);
    wregistro:=wregistro+Padl(Registros54[i].Serie,3);
    wregistro:=wregistro+TBStrZero(Registros54[i].Numero,6);

    wregistro:=wregistro+Padl(TiraPontos(Registros54[i].CFOP),4);
    wregistro:=wregistro+Padl(Registros54[i].CST,3);
    wregistro:=wregistro+IntToStrZero(Registros54[i].NumeroItem,3);
    wregistro:=wregistro+Padl(Registros54[i].Codigo,14); //codigo do produto
    wregistro:=wregistro+TBStrZero(TiraPontos(FormatFloat('#,###0.000',
      Registros54[i].Quantidade)),11); //quantidade do produto
    wregistro:=wregistro+TBStrZero(TiraPontos(FormatFloat('#,##0.00',
      Registros54[i].Valor)),12); //total do produto
    wregistro:=wregistro+TBStrZero(TiraPontos(FormatFloat('#,##0.00',
      Registros54[i].ValorDescontoDespesa)),12); //desconto/despesa
    wregistro:=wregistro+TBStrZero(TiraPontos(FormatFloat('#,##0.00',
      Registros54[i].BasedeCalculo)),12);
    wregistro:=wregistro+TBStrZero(TiraPontos(FormatFloat('#,##0.00',
      Registros54[i].BaseST)),12); //base de calculo substituicao tributária
    wregistro:=wregistro+TBStrZero(TiraPontos(FormatFloat('#,##0.00',
      Registros54[i].ValorIpi)),12); //valor do ipi.
    wregistro:=wregistro+TBStrZero(TiraPontos(FormatFloat('#,##0.00',
      Registros54[i].Aliquota)),4);
    WriteRecord(wregistro);
end;
end;

procedure TACBrSintegra.GerarRegistros60A(Registros60A: TRegistros60A);
var
  wregistro: string;
  i: Integer;
begin
for i:=0 to Registros60A.Count -1 do
begin
  wregistro:='60A';
  wregistro:=wregistro+FormatDateTime('yyyymmdd',Registros60A[i].Emissao);
  wregistro:=wregistro+Padl(Trim(Registros60A[i].NumSerie),20);
  wregistro:=wregistro+Padl(TiraPontos(Registros60A[i].StAliquota),4);
  wregistro:=wregistro+TbStrZero(TiraPontos(
    FormatFloat('#,##0.00',Registros60A[i].Valor)),12);
  wregistro:=wregistro+space(79);
  WriteRecord(wregistro);
end;
end;

procedure TACBrSintegra.GerarRegistros60D(Registros60D: TRegistros60D);
var
  wregistro: string;
  i: Integer;
begin
for I := 0 to Registros60D.Count - 1 do
begin
  wregistro:='60D';
  wregistro:=wregistro+FormatDateTime('yyyymmdd',Registros60D[i].Emissao);
  wregistro:=wregistro+Padl(Trim(Registros60D[i].NumSerie),20);
  wregistro:=wregistro+Padl(Registros60D[i].Codigo,14);
  wregistro:=wregistro+TBStrZero(TiraPontos(
    FormatFloat('#,###0.000',Registros60D[i].Quantidade)),13);
  wregistro:=wregistro+TBStrZero(TiraPontos(
    FormatFloat('#,##0.00',Registros60D[i].Valor)),16);
  wregistro:=wregistro+TBStrZero(TiraPontos(
    FormatFloat('#,##0.00',Registros60D[i].BaseDeCalculo)),16);
  wregistro:=wregistro+Padl(TiraPontos(Registros60D[i].StAliquota),4);
  wregistro:=wregistro+TBStrZero(TiraPontos(
    FormatFloat('#,##0.00',Registros60D[i].ValorIcms)),13);
  wregistro:=wregistro+Space(19);
  WriteRecord(wregistro);
end;
end;

procedure TACBrSintegra.GerarRegistros60M(Registro60M: TRegistro60M);
var
  wregistro: string;
begin
with Registro60M do
begin
  wregistro:='60M';
  wregistro:=wregistro+FormatDateTime('yyyymmdd',Emissao);
  wregistro:=wregistro+Padl(Trim(NumSerie),20);
  wregistro:=wregistro+TBStrZero(IntToStr(NumOrdem),3);
  wregistro:=wregistro+ModeloDoc;
  wregistro:=wregistro+tbstrzero(IntToStr(CooInicial),6);
  wregistro:=wregistro+TBStrZero(IntToStr(CooFinal),6);
  wregistro:=wregistro+TBStrZero(IntToStr(CRZ),6);
  wregistro:=wregistro+TBStrZero(IntToStr(CRO),3);
  wregistro:=wregistro+TBStrZero(TiraPontos(FormatFloat('#,##0.00',VendaBruta)),16);
  wregistro:=wregistro+TBStrZero(tirapontos(FormatFloat('#,##0.00',ValorGT)),16);
  wregistro:=wregistro+space(37);
  WriteRecord(wregistro);
end;
end;

procedure TACBrSintegra.GerarRegistros70;
var
  i: Integer;
  wregistro: string;
begin
Registros70.Sort(Sort70);
for i:=0 to Registros70.Count - 1 do
begin
  wregistro:='70';
  wregistro:=wregistro+TBStrZero(TiraPontos(Registros70[i].CPFCNPJ),14)+
    Padl(TiraPontos(Registros70[i].Inscricao),14);
  wregistro:=wregistro+FormatDateTime('yyyymmdd',Registros70[i].DataDocumento);
  wregistro:=wregistro+Padl(Registros70[i].UF,2);
  wregistro:=wregistro+TBStrZero(Registros70[i].Modelo,2);
  wregistro:=wregistro+Padl(Copy(Registros70[i].Serie,1,1),1);
  wregistro:=wregistro+Padl(Copy(Registros70[i].SubSerie,1,2),2);
  wregistro:=wregistro+TBStrZero(Registros70[i].Numero,6);
  wregistro:=wregistro+Padl(TiraPontos(Registros70[i].Cfop),4);

  wregistro:=wregistro+TBStrZero(TiraPontos(FormatFloat('#,##0.00',Registros70[i].ValorContabil)),13);
  wregistro:=wregistro+TBStrZero(TiraPontos(FormatFloat('#,##0.00',Registros70[i].BasedeCalculo)),14);
  wregistro:=wregistro+TBStrZero(TiraPontos(FormatFloat('#,##0.00',Registros70[i].Icms)),14);
  wregistro:=wregistro+TBStrZero(TiraPontos(FormatFloat('#,##0.00',Registros70[i].Isentas)),14);
  wregistro:=wregistro+TBStrZero(TiraPontos(FormatFloat('#,##0.00',Registros70[i].Outras)),14);
  wregistro:=wregistro+TBStrZero(Registros70[i].CifFobOutros,1);
  wregistro:=wregistro+Padl(Registros70[i].Situacao,1);
  WriteRecord(wregistro);
end;
end;

procedure TACBrSintegra.GerarRegistros71;
var
  i: Integer;
  wregistro: string;
begin
Registros71.Sort(Sort71);
for i:=0 to Registros71.Count - 1 do
begin
  wregistro:='71';
  wregistro:=wregistro+TBStrZero(TiraPontos(Registros71[i].CPFCNPJ),14)+
                            Padl(TiraPontos(Registros71[i].Inscricao),14);

  wregistro:=wregistro+FormatDateTime('yyyymmdd',Registros71[i].DataDocumento);
  wregistro:=wregistro+Padl(Registros71[i].UF,2);
  wregistro:=wregistro+TBStrZero(Registros71[i].Modelo,2);
  wregistro:=wregistro+Padl(Copy(Registros71[i].Serie,1,1),1);
  wregistro:=wregistro+Padl(Copy(Registros71[i].SubSerie,1,2),2);
  wregistro:=wregistro+TBStrZero(Registros71[i].Numero,6);

  wregistro:=wregistro+Padl(Registros71[i].UFNF,2);
  wregistro:=wregistro+TBStrZero(TiraPontos(Registros71[i].CPFCNPJNF),14)+
                            Padl(TiraPontos(Registros71[i].InscricaoNF),14);
  wregistro:=wregistro+FormatDateTime('yyyymmdd',Registros71[i].DataNF);
  wregistro:=wregistro+TBStrZero(Registros71[i].ModeloNF,2);
  wregistro:=wregistro+Padl(Copy(Registros71[i].SerieNF,1,3),3);
  wregistro:=wregistro+TBStrZero(Registros71[i].NumeroNF,6);
  wregistro:=wregistro+TBStrZero(TiraPontos(FormatFloat('#,##0.00',Registros71[i].ValorNF)),14);
  wregistro:=wregistro+Padl(' ',12);

  WriteRecord(wregistro);
end;
end;

procedure TACBrSintegra.GerarRegistros74;
var
  i: Integer;
  wregistro: string;
begin
Registros74.Sort(Sort74);
for i:=0 to Registros74.Count - 1 do
begin
  with Registros74[i] do
  begin
    wregistro:='74';
    wregistro:=wregistro+FormatDateTime('yyyymmdd',Data);
    wregistro:=wregistro+Padl(Codigo,14);
    wregistro:=wregistro+TBStrZero(TiraPontos(
      FormatFloat('#,###0.000',Quantidade)),13);
    wregistro:=wregistro+TBStrZero(TiraPontos(
      FormatFloat('#,##0.00',ValorProduto)),13);
    wregistro:=wregistro+CodigoPosse;
    wregistro:=wregistro+TBStrZero(CNPJPossuidor,14);
    wregistro:=wregistro+Padl(InscricaoPossuidor,14);
    wregistro:=wregistro+Padl(UFPossuidor,2);
    wregistro:=wregistro+Space(45); //brancos
    WriteRecord(wregistro);
  end;
end;
end;

procedure TACBrSintegra.GerarRegistros75;
var
  i: Integer;
  wregistro: string;
begin
Registros75.Sort(Sort75);
for i := 0 to Registros75.Count - 1 do
begin
  wregistro:='75'+FormatDateTime('yyyymmdd',Registros75[i].DataInicial)+
    FormatDateTime('yyyymmdd',Registros75[i].DataFinal);
  wregistro:=wregistro+Padl(Registros75[i].Codigo,14);
  wregistro:=wregistro+Padl(Registros75[i].NCM,8);
  wregistro:=wregistro+Padl(Copy(Trim(Registros75[i].Descricao),1,53),53);
  wregistro:=wregistro+Padl(Registros75[i].Unidade,6);
  wregistro:=wregistro+TBStrZero(TiraPontos(FormatFloat('#,##0.00',
    Registros75[i].AliquotaIpi)),5);
  wregistro:=wregistro+TBStrZero(TiraPontos(FormatFloat('#,##0.00',
    Registros75[i].AliquotaIcms)),4);
  wregistro:=wregistro+TBStrZero(TiraPontos(FormatFloat('#,##0.00',
    Registros75[i].Reducao)),5);
  wregistro:=wregistro+TBStrZero(TiraPontos(FormatFloat('#,##0.00',
    Registros75[i].BaseST)),13);
  WriteRecord(wregistro);
end;
end;

procedure TACBrSintegra.GerarRegistros85;
var
  wregistro: string;
  i: Integer;
begin
    for i:=0 to Registros85.Count-1 do
    begin
        wregistro:='85';
        wregistro:=wregistro+TBStrZero(TiraPontos(Registros85[i].Declaracao),11);
        wregistro:= wregistro + FormatDateTime('yyyymmdd',Registros85[i].DataDeclaracao);
        wregistro:=wregistro+Padl(Registros85[i].NaturezaExportacao,1);
        wregistro:=wregistro+Padl(Registros85[i].RegistroExportacao,12);
        wregistro:= wregistro + FormatDateTime('yyyymmdd',Registros85[i].DataRegistro);
        wregistro:=wregistro+TBStrZero(TiraPontos(Registros85[i].Conhecimento),16);
        wregistro:= wregistro + FormatDateTime('yyyymmdd',Registros85[i].DataConhecimento);
        wregistro:=wregistro+TBStrZero(TiraPontos(Registros85[i].TipoConhecimento),2);
        wregistro:=wregistro+TBStrZero(TiraPontos(Registros85[i].Pais),4);
        wregistro:= wregistro + padL('',8);
        wregistro:= wregistro + FormatDateTime('yyyymmdd',Registros85[i].DataAverbacao);
        wregistro:=wregistro+TBStrZero(Registros85[i].NumeroNotaFiscal,6);
        wregistro:= wregistro + FormatDateTime('yyyymmdd',Registros85[i].DataNotaFiscal);
        wregistro:=wregistro+TBStrZero(Registros85[i].Modelo,2);
        wregistro:=wregistro+Padl(Copy(Registros85[i].Serie,1,3),3);
        wregistro:=wregistro+Padl('',19);
        WriteRecord(wregistro);
    end;
end;

procedure TACBrSintegra.GerarRegistros86;
var
  wregistro: string;
  i: Integer;
begin
    //Registro 86 requer ordenacao por Declaracao
    Registros86.Sort(Sort86);
    for i:=0 to Registros86.Count-1 do
    begin
        with Registros86[i] do
        begin
            wregistro:='86';
            wregistro:=wregistro+Padl(Registros86[i].RegistroExportacao,12);
            wregistro:=wregistro+FormatDateTime('yyyymmdd',DataRegistro);
            wregistro:=wregistro+TBStrZero(TiraPontos(CPFCNPJ),14)+Padl(TiraPontos(Inscricao),14);
            wregistro:=wregistro+Padl(UF,2);
            wregistro:=wregistro+TBStrZero(NumeroNotaFiscal,6);
            wregistro:=wregistro+FormatDateTime('yyyymmdd',DataDocumento);
            wregistro:=wregistro+TBStrZero(Modelo,2);
            wregistro:=wregistro+Padl(Serie,3);
            wregistro:=wregistro+Padl(Codigo,14);
            wregistro:=wregistro+TBStrZero(TiraPontos(FormatFloat('#,###0.000',Quantidade)),11);
            wregistro:=wregistro+TBStrZero(TiraPontos(FormatFloat('#,##0.00',ValorUnitario)),12);
            wregistro:=wregistro+TBStrZero(TiraPontos(FormatFloat('#,##0.00',ValorTotalProduto)),12);
            wregistro:=wregistro+Padl(Relacionamento,1);
            wregistro:= wregistro + padL('',5);
            WriteRecord(wregistro);
        end;
    end;
end;

procedure TACBrSintegra.GerarRegistros90;
var
  wregistro: string;
begin
wregistro:='90'+TBStrZero(TiraPontos(Registro10.CNPJ),14);
wregistro:=wregistro+Padl(TiraPontos(Registro10.Inscricao),14);
if Registros50.Count>0 then
  wregistro:=wregistro+'50'+TBStrZero(IntToStr(Registros50.Count),8);
if Registros51.Count>0 then
  wregistro:=wregistro+'51'+TBStrZero(IntToStr(Registros51.Count),8);
if Registros53.Count>0 then
  wregistro:=wregistro+'53'+TBStrZero(IntToStr(Registros53.Count),8);
if Registros54.Count>0 then
  wregistro:=wregistro+'54'+TBStrZero(IntToStr(Registros54.Count),8);
if Registros60M.Count>0 then
  wregistro:=wregistro+'60'+TBStrZero(IntToStr(Registros60M.Count+Registros60A.Count+
    Registros60D.Count+Registros60I.Count+Registros60R.Count),8);
if Registros61.Count>0 then
  wregistro:=wregistro+'61'+TBStrZero(IntToStr(Registros61.Count+Registros61R.Count),8);
if Registros70.Count>0 then
  wregistro:=wregistro+'70'+TBStrZero(IntToStr(Registros70.Count),8);
if Registros71.Count>0 then
  wregistro:=wregistro+'71'+TBStrZero(IntToStr(Registros71.Count),8);
if Registros74.Count>0 then
  wregistro:=wregistro+'74'+TBStrZero(IntToStr(Registros74.Count),8);
if Registros75.Count>0 then
  wregistro:=wregistro+'75'+TBStrZero(IntToStr(Registros75.Count),8);
if Registros85.Count>0 then
  wregistro:=wregistro+'85'+TBStrZero(IntToStr(Registros85.Count),8);
if Registros86.Count>0 then
  wregistro:=wregistro+'86'+TBStrZero(IntToStr(Registros86.Count),8);

wregistro:=wregistro+Space(125-length(wregistro))+'2';
WriteRecord(wregistro);

wregistro:='90'+TBStrZero(TiraPontos(Registro10.CNPJ),14);
wregistro:=wregistro+Padl(TiraPontos(Registro10.Inscricao),14);
wregistro:=wregistro+'99'+TBStrZero(IntToStr(Registros50.Count+Registros51.Count+
  Registros53.Count+Registros54.Count+
  (Registros60M.Count+Registros60A.Count+Registros60D.Count+Registros60I.Count+Registros60R.Count)+
  (Registros61.Count+Registros61R.Count)+
   Registros70.Count+Registros71.Count+Registros74.Count+Registros75.Count+Registros85.Count+Registros86.Count+4),8);

wregistro:=wregistro+Space(125-length(wregistro))+'2';
WriteRecord(wregistro);
end;

function TACBrSintegra.GetRegistro60M(Emissao: TDateTime;
  NumSerie: string): TRegistro60M;
var
  i: Integer;
begin
Result:=nil;
for i := 0 to Registros60M.Count - 1 do
begin
  if (Registros60M[i].Emissao=Emissao)
     and (Registros60M[i].NumSerie=NumSerie) then
  begin
    Result:=Registros60M[i];
    Break;
  end;
end;
end;

procedure TACBrSintegra.LimparRegistros;
begin
FRegistros50.Clear;
FRegistros51.Clear;
FRegistros53.Clear;
FRegistros54.Clear;
FRegistros60M.Clear;
FRegistros60A.Clear;
FRegistros60D.Clear;
FRegistros60I.Clear;
FRegistros60R.Clear;
FRegistros61.Clear;
FRegistros61R.Clear;
FRegistros70.Clear;
FRegistros71.Clear;
FRegistros74.Clear;
FRegistros75.Clear;
    FRegistros85.Clear;
    FRegistros86.Clear;
end;

function TACBrSintegra.GetVersao: string;
begin
Result:=ACBR_VERSAO;
end;

procedure TACBrSintegra.GerarRegistros61;
var
  wregistro: string;
  i: Integer;
begin
for i:=0 to Registros61.Count-1 do
begin
  with Registros61[i] do
  begin
    wregistro:='61';
    wregistro:=wregistro+Space(28);
    wregistro:=wregistro+FormatDateTime('yyyymmdd',Emissao);
    wregistro:=wregistro+TBStrZero(Modelo,2);
    wregistro:=wregistro+Padl(Serie,3);
    wregistro:=wregistro+Padl(SubSerie,2);
    wregistro:=wregistro+TBStrZero(IntToStr(NumOrdemInicial),6);
    wregistro:=wregistro+TBStrZero(IntToStr(NumOrdemFinal),6);
    wregistro:=wregistro+TBStrZero(TiraPontos(FormatFloat('#,##0.00',Valor)),13);
    wregistro:=wregistro+TBStrZero(TiraPontos(FormatFloat('#,##0.00',BaseDeCalculo)),13);
    wregistro:=wregistro+TBStrZero(TiraPontos(FormatFloat('#,##0.00',ValorIcms)),12);
    wregistro:=wregistro+TBStrZero(TiraPontos(FormatFloat('#,##0.00',Isentas)),13);
    wregistro:=wregistro+TBStrZero(TiraPontos(FormatFloat('#,##0.00',Outras)),13);
    wregistro:=wregistro+TBStrZero(TiraPontos(FormatFloat('#,##0.00',Aliquota)),4);
    wregistro:=wregistro+Space(1);
    WriteRecord(wregistro);
  end;
end;
end;

procedure TACBrSintegra.GerarRegistros61R;
var
  i: Integer;
  wregistro: string;
begin
for i:=0 to Registros61R.Count-1 do
begin
  with Registros61R[i] do
  begin
    wregistro:='61R';
    wregistro:=wregistro+MesAno;
    wregistro:=wregistro+Padl(Codigo,14);
    wregistro:=wregistro+TBStrZero(TiraPontos(FormatFloat('#,###0.000',Qtd)),13);
    wregistro:=wregistro+TBStrZero(TiraPontos(FormatFloat('#,##0.00',Valor)),16);
    wregistro:=wregistro+TBStrZero(TiraPontos(FormatFloat('#,##0.00',BaseDeCalculo)),16);
    wregistro:=wregistro+TBStrZero(TiraPontos(FormatFloat('#,##0.00',Aliquota)),4);
    wregistro:=wregistro+space(54);
    WriteRecord(wregistro);
  end;
end;
end;

procedure TACBrSintegra.GerarRegistros60I(Registros60I: TRegistros60I);
var
  wregistro: string;
  i: Integer;
begin
for I := 0 to Registros60I.Count - 1 do
begin
  wregistro:='60I';
  wregistro:=wregistro+FormatDateTime('yyyymmdd',Registros60I[i].Emissao);
  wregistro:=wregistro+Padl(Trim(Registros60I[i].NumSerie),20);
  wregistro:=wregistro+Padl(Trim(Registros60I[i].ModeloDoc),2);
  wregistro:=wregistro+TBStrzero(Registros60I[i].Cupom,6);
  wregistro:=wregistro+TBStrzero(IntToStr(Registros60I[i].Item),3);
  wregistro:=wregistro+Padl(Registros60I[i].Codigo,14);
  wregistro:=wregistro+TBStrZero(TiraPontos(
    FormatFloat('#,###0.000',Registros60I[i].Quantidade)),13);
  wregistro:=wregistro+TBStrZero(TiraPontos(
    FormatFloat('#,##0.00',Registros60I[i].Valor)),13);
  wregistro:=wregistro+TBStrZero(TiraPontos(
    FormatFloat('#,##0.00',Registros60I[i].BaseDeCalculo)),12);
  wregistro:=wregistro+Padl(TiraPontos(Registros60I[i].StAliquota),4);
  wregistro:=wregistro+TBStrZero(TiraPontos(
    FormatFloat('#,##0.00',Registros60I[i].ValorIcms)),12);
  wregistro:=wregistro+Space(16);
  WriteRecord(wregistro);
end;
end;

procedure TACBrSintegra.GerarRegistros60R;
var
  i: Integer;
  wregistro: string;
begin
  for i:=0 to Registros60R.Count-1 do
  begin
    with Registros60R[i] do
    begin
      wregistro:='60R';
      wregistro:=wregistro+MesAno;
      wregistro:=wregistro+Padl(Codigo,14);
      wregistro:=wregistro+TBStrZero(TiraPontos(FormatFloat('#,###0.000',Qtd)),13);
      wregistro:=wregistro+TBStrZero(TiraPontos(FormatFloat('#,##0.00',Valor)),16);
      wregistro:=wregistro+TBStrZero(TiraPontos(FormatFloat('#,##0.00',BaseDeCalculo)),16);
      wregistro:=wregistro+Padl(TiraPontos(Aliquota),4);
      wregistro:=wregistro+space(54);
      WriteRecord(wregistro);
    end;
  end;
end;

{ TRegistros50 }

constructor TRegistro50.Create;
begin
FRegistros54:=TRegistros54.Create(True);
end;

destructor TRegistro50.Destroy;
begin
FRegistros54.Free;
  inherited;
end;

function TRegistros50.Add(Obj: TRegistro50): Integer;
begin
  Result := inherited Add(Obj) ;
end;

function TRegistros50.GetObject(Index: Integer): TRegistro50;
begin
  Result := inherited GetItem(Index) as TRegistro50 ;
end;

procedure TRegistros50.Insert(Index: Integer; Obj: TRegistro50);
begin
  inherited Insert(Index, Obj);
end;

procedure TRegistros50.SetObject(Index: Integer; Item: TRegistro50);
begin
  inherited SetItem (Index, Item) ;
end;

function Sort50(Item1, Item2: Pointer): Integer;
var
  witem1, witem2 : TRegistro50;
begin
  witem1 := TRegistro50(Item1);
  witem2 := TRegistro50(Item2);
  if witem1.DataDocumento>witem2.DataDocumento then
    Result := 1
  else if witem1.DataDocumento = witem2.DataDocumento then
    Result := 0
  else
    Result := -1;
end;

{ TRegistros54 }

function TRegistros54.Add(Obj: TRegistro54): Integer;
begin
  Result := inherited Add(Obj) ;
end;

function TRegistros54.GetObject(Index: Integer): TRegistro54;
begin
  Result := inherited GetItem(Index) as TRegistro54 ;
end;

procedure TRegistros54.Insert(Index: Integer; Obj: TRegistro54);
begin
  inherited Insert(Index, Obj);
end;

procedure TRegistros54.SetObject(Index: Integer; Item: TRegistro54);
begin
  inherited SetItem (Index, Item) ;
end;

{ TRegistros75 }

function TRegistros75.Add(Obj: TRegistro75): Integer;
begin
Result:=-1;
if not GetRegistroExiste(Obj.Codigo) then
  Result := inherited Add(Obj) ;
end;

function TRegistros75.GetObject(Index: Integer): TRegistro75;
begin
  Result := inherited GetItem(Index) as TRegistro75 ;
end;

function TRegistros75.GetRegistroExiste(FCodigo: string): Boolean;
var
  i: Integer;
begin
Result:=False;
for i:=0 to Self.Count-1 do
begin
  Result:=(Self[i].Codigo=FCodigo);
  if Result then
    Break;
end;
end;

procedure TRegistros75.Insert(Index: Integer; Obj: TRegistro75);
begin
if not GetRegistroExiste(Obj.Codigo) then
  inherited Insert(Index, Obj);
end;

procedure TRegistros75.SetObject(Index: Integer; Item: TRegistro75);
begin
  inherited SetItem (Index, Item) ;
end;

function Sort75(Item1, Item2: Pointer): Integer;
var
  witem1, witem2 : TRegistro75;
begin
  witem1 := TRegistro75(Item1);
  witem2 := TRegistro75(Item2);
  if witem1.Codigo>witem2.Codigo then
    Result := 1
  else if witem1.Codigo = witem2.Codigo then
    Result := 0
  else
    Result := -1;
end;

function Sort85(Item1, Item2: Pointer): Integer;
var
  witem1, witem2 : TRegistro85;
begin
  witem1 := TRegistro85(Item1);
  witem2 := TRegistro85(Item2);
  if witem1.DataDeclaracao>witem2.DataDeclaracao then
    Result := 1
  else if witem1.DataDeclaracao = witem2.DataDeclaracao then
    Result := 0
  else
    Result := -1;
end;

function Sort86(Item1, Item2: Pointer): Integer;
var
  witem1, witem2 : TRegistro86;
begin
  witem1 := TRegistro86(Item1);
  witem2 := TRegistro86(Item2);
  if witem1.DataRegistro > witem2.DataRegistro then
    Result := 1
  else if witem1.DataRegistro = witem2.DataRegistro then
    Result := 0
  else
    Result := -1;
end;

{ TRegistros70 }

function TRegistros70.Add(Obj: TRegistro70): Integer;
begin
  Result := inherited Add(Obj) ;
end;

function TRegistros70.GetObject(Index: Integer): TRegistro70;
begin
  Result := inherited GetItem(Index) as TRegistro70 ;
end;

procedure TRegistros70.Insert(Index: Integer; Obj: TRegistro70);
begin
  inherited Insert(Index, Obj);
end;

procedure TRegistros70.SetObject(Index: Integer; Item: TRegistro70);
begin
  inherited SetItem (Index, Item) ;
end;

function Sort70(Item1, Item2: Pointer): Integer;
var
  witem1, witem2 : TRegistro70;
begin
  witem1 := TRegistro70(Item1);
  witem2 := TRegistro70(Item2);
  if witem1.DataDocumento>witem2.DataDocumento then
    Result := 1
  else if witem1.DataDocumento = witem2.DataDocumento then
    Result := 0
  else
    Result := -1;
end;

{ TRegistros71 }

function TRegistros71.Add(Obj: TRegistro71): Integer;
begin
  Result := inherited Add(Obj) ;
end;

function TRegistros71.GetObject(Index: Integer): TRegistro71;
begin
  Result := inherited GetItem(Index) as TRegistro71 ;
end;

procedure TRegistros71.Insert(Index: Integer; Obj: TRegistro71);
begin
  inherited Insert(Index, Obj);
end;

procedure TRegistros71.SetObject(Index: Integer; Item: TRegistro71);
begin
  inherited SetItem (Index, Item) ;
end;

function Sort71(Item1, Item2: Pointer): Integer;
var
  witem1, witem2 : TRegistro71;
begin
  witem1 := TRegistro71(Item1);
  witem2 := TRegistro71(Item2);
  if witem1.DataDocumento>witem2.DataDocumento then
    Result := 1
  else if witem1.DataDocumento = witem2.DataDocumento then
    Result := 0
  else
    Result := -1;
end; 


{ TRegistros51 }

function TRegistros51.Add(Obj: TRegistro51): Integer;
begin
  Result := inherited Add(Obj) ;
end;

function TRegistros51.GetObject(Index: Integer): TRegistro51;
begin
  Result := inherited GetItem(Index) as TRegistro51 ;
end;

procedure TRegistros51.Insert(Index: Integer; Obj: TRegistro51);
begin
  inherited Insert(Index, Obj);
end;

procedure TRegistros51.SetObject(Index: Integer; Item: TRegistro51);
begin
  inherited SetItem (Index, Item) ;
end;

function Sort51(Item1, Item2: Pointer): Integer;
var
  witem1, witem2 : TRegistro51;
begin
  witem1 := TRegistro51(Item1);
  witem2 := TRegistro51(Item2);
  if witem1.DataDocumento>witem2.DataDocumento then
    Result := 1
  else if witem1.DataDocumento = witem2.DataDocumento then
    Result := 0
  else
    Result := -1;
end;

{ TRegistros53 }

function TRegistros53.Add(Obj: TRegistro53): Integer;
begin
  Result := inherited Add(Obj) ;
end;

function TRegistros53.GetObject(Index: Integer): TRegistro53;
begin
  Result := inherited GetItem(Index) as TRegistro53 ;
end;

procedure TRegistros53.Insert(Index: Integer; Obj: TRegistro53);
begin
  inherited Insert(Index, Obj);
end;

procedure TRegistros53.SetObject(Index: Integer; Item: TRegistro53);
begin
  inherited SetItem (Index, Item) ;
end;

function Sort53(Item1, Item2: Pointer): Integer;
var
  witem1, witem2 : TRegistro53;
begin
  witem1 := TRegistro53(Item1);
  witem2 := TRegistro53(Item2);
  if witem1.DataDocumento>witem2.DataDocumento then
    Result := 1
  else if witem1.DataDocumento = witem2.DataDocumento then
    Result := 0
  else
    Result := -1;
end;

{ TRegistros60M }

function TRegistros60M.Add(Obj: TRegistro60M): Integer;
begin
  Result := inherited Add(Obj) ;
end;

function TRegistros60M.GetObject(Index: Integer): TRegistro60M;
begin
  Result := inherited GetItem(Index) as TRegistro60M;
end;

procedure TRegistros60M.Insert(Index: Integer; Obj: TRegistro60M);
begin
  inherited Insert(Index, Obj);
end;

procedure TRegistros60M.SetObject(Index: Integer; Item: TRegistro60M);
begin
  inherited SetItem (Index, Item) ;
end;

function Sort60M(Item1, Item2: Pointer): Integer;
var
  witem1, witem2 : TRegistro60M;
begin
  witem1 := TRegistro60M(Item1);
  witem2 := TRegistro60M(Item2);
  if witem1.Emissao>witem2.Emissao then
  begin
    Result:=1
  end
  else if witem1.Emissao = witem2.Emissao then
  begin
    Result:=0;
  end
  else
  begin
    Result:=-1;
  end;
end;

{ TRegistros60A }

function TRegistros60A.Add(Obj: TRegistro60A): Integer;
begin
  Result := inherited Add(Obj) ;
end;

function TRegistros60A.GetObject(Index: Integer): TRegistro60A;
begin
  Result := inherited GetItem(Index) as TRegistro60A ;
end;

procedure TRegistros60A.Insert(Index: Integer; Obj: TRegistro60A);
begin
  inherited Insert(Index, Obj);
end;

procedure TRegistros60A.SetObject(Index: Integer; Item: TRegistro60A);
begin
  inherited SetItem (Index, Item) ;
end;

function Sort60A(Item1, Item2: Pointer): Integer;
var
  witem1, witem2 : TRegistro60A;
begin
  witem1 := TRegistro60A(Item1);
  witem2 := TRegistro60A(Item2);
  if witem1.Emissao>witem2.Emissao then
  begin
    if witem1.NumSerie>witem2.NumSerie then
      Result:=1
    else if witem1.NumSerie=witem2.NumSerie then
      Result:=0
    else
      Result:=-1;
  end
  else if witem1.Emissao = witem2.Emissao then
  begin
    if witem1.NumSerie>witem2.NumSerie then
      Result:=1
    else if witem1.NumSerie=witem2.NumSerie then
      Result:=0
    else
      Result:=-1;
  end
  else
  begin
    if witem1.NumSerie>witem2.NumSerie then
      Result:=1
    else if witem1.NumSerie=witem2.NumSerie then
      Result:=0
    else
      Result:=-1;
  end;
end;

{ TRegistro60M }

constructor TRegistro60M.Create;
begin
  inherited Create;
FRegs60A:=TRegistros60A.Create(True);
FRegs60D:=TRegistros60D.Create(True);
FRegs60I:=TRegistros60I.Create(True);
end;

destructor TRegistro60M.Destroy;
begin
//  FreeAndNil(FRegs60A);
//  FreeAndNil(FRegs60D);
  inherited;
end;

{ TRegistros60D }

function TRegistros60D.Add(Obj: TRegistro60D): Integer;
begin
  Result := inherited Add(Obj) ;
end;

function TRegistros60D.GetObject(Index: Integer): TRegistro60D;
begin
  Result := inherited GetItem(Index) as TRegistro60D ;
end;

procedure TRegistros60D.Insert(Index: Integer; Obj: TRegistro60D);
begin
  inherited Insert(Index, Obj);
end;

procedure TRegistros60D.SetObject(Index: Integer; Item: TRegistro60D);
begin
  inherited SetItem (Index, Item) ;
end;

function Sort60D(Item1, Item2: Pointer): Integer;
var
  witem1, witem2 : TRegistro60D;
begin
  witem1 := TRegistro60D(Item1);
  witem2 := TRegistro60D(Item2);
  if witem1.Emissao>witem2.Emissao then
  begin
    if witem1.NumSerie>witem2.NumSerie then
      Result:=1
    else if witem1.NumSerie=witem2.NumSerie then
      Result:=0
    else
      Result:=-1;
  end
  else if witem1.Emissao = witem2.Emissao then
  begin
    if witem1.NumSerie>witem2.NumSerie then
      Result:=1
    else if witem1.NumSerie=witem2.NumSerie then
      Result:=0
    else
      Result:=-1;
  end
  else
  begin
    if witem1.NumSerie>witem2.NumSerie then
      Result:=1
    else if witem1.NumSerie=witem2.NumSerie then
      Result:=0
    else
      Result:=-1;
  end;
end;

{ TRegistros74 }

function Sort74(Item1, Item2: Pointer): Integer;
var
  witem1, witem2 : TRegistro74;
begin
  witem1 := TRegistro74(Item1);
  witem2 := TRegistro74(Item2);
  if witem1.Data>witem2.Data then
  begin
    if witem1.Codigo>witem2.Codigo then
      Result:=1
    else if witem1.Codigo=witem2.Codigo then
      Result:=0
    else
      Result:=-1;
  end
  else if witem1.Data = witem2.Data then
  begin
    if witem1.Codigo>witem2.Codigo then
      Result:=1
    else if witem1.Codigo=witem2.Codigo then
      Result:=0
    else
      Result:=-1;
  end
  else
  begin
    if witem1.Codigo>witem2.Codigo then
      Result:=1
    else if witem1.Codigo=witem2.Codigo then
      Result:=0
    else
      Result:=-1;
  end;
end;

function TRegistros74.Add(Obj: TRegistro74): Integer;
begin
  Result := inherited Add(Obj) ;
end;

function TRegistros74.GetObject(Index: Integer): TRegistro74;
begin
  Result := inherited GetItem(Index) as TRegistro74 ;
end;

procedure TRegistros74.Insert(Index: Integer; Obj: TRegistro74);
begin
  inherited Insert(Index, Obj);
end;

procedure TRegistros74.SetObject(Index: Integer; Item: TRegistro74);
begin
  inherited SetItem (Index, Item) ;
end;

{ TRegistros61 }

function TRegistros61.Add(Obj: TRegistro61): Integer;
begin
  Result := inherited Add(Obj) ;
end;

function TRegistros61.GetObject(Index: Integer): TRegistro61;
begin
  Result := inherited GetItem(Index) as TRegistro61 ;
end;

procedure TRegistros61.Insert(Index: Integer; Obj: TRegistro61);
begin
  inherited Insert(Index, Obj);
end;

procedure TRegistros61.SetObject(Index: Integer; Item: TRegistro61);
begin
  inherited SetItem (Index, Item);
end;

{ TRegistros61R }

function TRegistros61R.Add(Obj: TRegistro61R): Integer;
begin
  Result := inherited Add(Obj);
end;

function TRegistros61R.GetObject(Index: Integer): TRegistro61R;
begin
  Result := inherited GetItem(Index) as TRegistro61R;
end;

procedure TRegistros61R.Insert(Index: Integer; Obj: TRegistro61R);
begin
  inherited Insert(Index, Obj);
end;

procedure TRegistros61R.SetObject(Index: Integer; Item: TRegistro61R);
begin
  inherited SetItem (Index, Item);
end;

{ TRegistros60I }

function TRegistros60I.Add(Obj: TRegistro60I): Integer;
begin
  Result:=inherited Add(Obj);
end;

function TRegistros60I.GetObject(Index: Integer): TRegistro60I;
begin
  Result:=inherited GetItem(Index) as TRegistro60I;
end;

procedure TRegistros60I.Insert(Index: Integer; Obj: TRegistro60I);
begin
  inherited Insert(Index,Obj);
end;

procedure TRegistros60I.SetObject(Index: Integer; Item: TRegistro60I);
begin
  inherited SetItem(Index, Item);
end;

function Sort60I(Item1, Item2: Pointer): Integer;
var
  witem1, witem2 : TRegistro60I;
begin
  witem1 := TRegistro60I(Item1);
  witem2 := TRegistro60I(Item2);
  if witem1.Emissao>witem2.Emissao then
  begin
    if witem1.NumSerie>witem2.NumSerie then
      Result:=1
    else if witem1.NumSerie=witem2.NumSerie then
      Result:=0
    else
      Result:=-1;
  end
  else if witem1.Emissao = witem2.Emissao then
  begin
    if witem1.NumSerie>witem2.NumSerie then
      Result:=1
    else if witem1.NumSerie=witem2.NumSerie then
      Result:=0
    else
      Result:=-1;
  end
  else
  begin
    if witem1.NumSerie>witem2.NumSerie then
      Result:=1
    else if witem1.NumSerie=witem2.NumSerie then
      Result:=0
    else
      Result:=-1;
  end;
end;

{ TRegistros60R }

function TRegistros60R.Add(Obj: TRegistro60R): Integer;
begin
  Result:=inherited Add(Obj);
end;

function TRegistros60R.GetObject(Index: Integer): TRegistro60R;
begin
Result:= inherited GetItem(Index) as TRegistro60R;
end;

procedure TRegistros60R.Insert(Index: Integer; Obj: TRegistro60R);
begin
inherited Insert(Index, Obj);
end;

procedure TRegistros60R.SetObject(Index: Integer; Item: TRegistro60R);
begin
inherited SetItem(Index, Item);
end;

procedure TRegistros85.SetObject(Index: Integer; Item: TRegistro85);
begin
  inherited SetItem (Index, Item) ;
end;

function TRegistros85.GetObject(Index: Integer): TRegistro85;
begin
  Result := inherited GetItem(Index) as TRegistro85 ;
end;

procedure TRegistros85.Insert(Index: Integer; Obj: TRegistro85);
begin
  inherited Insert(Index, Obj);
end;

function TRegistros85.Add(Obj: TRegistro85): Integer;
begin
  Result := inherited Add(Obj) ;
end;

procedure TRegistros86.SetObject(Index: Integer; Item: TRegistro86);
begin
  inherited SetItem (Index, Item) ;
end;

function TRegistros86.GetObject(Index: Integer): TRegistro86;
begin
  Result := inherited GetItem(Index) as TRegistro86 ;
end;

procedure TRegistros86.Insert(Index: Integer; Obj: TRegistro86);
begin
  inherited Insert(Index, Obj);
end;

function TRegistros86.Add(Obj: TRegistro86): Integer;
begin
  Result := inherited Add(Obj) ;
end;

end.
