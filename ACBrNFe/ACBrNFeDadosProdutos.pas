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
|*  - Inclusão IPI, II e DI 
|* 14/03/2009: Dulcemar P.Zilli
|*  - Inclusão ISSQN 
|* 14/04/2009: Dulcemar P. Zilli
|*  - Incluido informação adicional produtos
|*  - Inclusão ISSQN
|* 02/05/2009: João H. Souza
|*  - Inclusão: Frete, Seguro em DadosProduto
******************************************************************************}
unit ACBrNFeDadosProdutos;

interface

uses
  Classes, Sysutils,
   ACBrNFeConst, ACBrNFeTypes, ACBrNFeDI;

type

  TICMS00 = Class(TPersistent)
  private
    FOrigem: TNFeOrigem;
    FModalidade: TNFeModalidade;
    FValorBase: Double;
    FAliquota: Double;
    FValor: Double;
  public
    constructor Create;
    destructor Destroy; override;

  published
    property Origem: TNFeOrigem read FOrigem write FOrigem;
    property Modalidade: TNFeModalidade read FModalidade write FModalidade;
    property ValorBase: Double read FValorBase write FValorBase;
    property Aliquota: Double read FAliquota write FAliquota;
    property Valor: Double read FValor write FValor;
  end;

  TICMS10 = Class(TPersistent)
  private
    FOrigem: TNFeOrigem;
    FModalidade: TNFeModalidade;
    FValorBase: Double;
    FAliquota: Double;
    FValor: Double;
    FModalidadeST: TNFeModalidadeST;
    FPercentualMargemST: Double;
    FPercentualReducaoST: Double;
    FValorBaseST: Double;
    FAliquotaST: Double;
    FValorST: Double;
  public
    constructor Create;
    destructor Destroy; override;

  published
    property Origem: TNFeOrigem read FOrigem write FOrigem;
    property Modalidade: TNFeModalidade read FModalidade write FModalidade;
    property ValorBase: Double read FValorBase write FValorBase;
    property Aliquota: Double read FAliquota write FAliquota;
    property Valor: Double read FValor write FValor;
    property ModalidadeST: TNFeModalidadeST read FModalidadeST write FModalidadeST;
    property PercentualMargemST: Double read FPercentualMargemST write FPercentualMargemST;
    property PercentualReducaoST: Double read FPercentualReducaoST write FPercentualReducaoST;
    property ValorBaseST: Double read FValorBaseST write FValorBaseST;
    property AliquotaST: Double read FAliquotaST write FAliquotaST;
    property ValorST: Double read FValorST write FValorST;
  end;

  TICMS20 = Class(TPersistent)
  private
    FOrigem: TNFeOrigem;
    FModalidade: TNFeModalidade;
    FPercentualReducao: Double;
    FValorBase: Double;
    FAliquota: Double;
    FValor: Double;
  public
    constructor Create;
    destructor Destroy; override;

  published
    property Origem: TNFeOrigem read FOrigem write FOrigem;
    property Modalidade: TNFeModalidade read FModalidade write FModalidade;
    property PercentualReducao: Double read FPercentualReducao write FPercentualReducao;
    property ValorBase: Double read FValorBase write FValorBase;
    property Aliquota: Double read FAliquota write FAliquota;
    property Valor: Double read FValor write FValor;
  end;

  TICMS30 = Class(TPersistent)
  private
    FOrigem: TNFeOrigem;
    FModalidadeST: TNFeModalidadeST;
    FPercentualMargemST: Double;
    FPercentualReducaoST: Double;
    FValorBaseST: Double;
    FAliquotaST: Double;
    FValorST: Double;
  public
    constructor Create;
    destructor Destroy; override;

  published
    property Origem: TNFeOrigem read FOrigem write FOrigem;
    property ModalidadeST: TNFeModalidadeST read FModalidadeST write FModalidadeST;
    property PercentualMargemST: Double read FPercentualMargemST write FPercentualMargemST;
    property PercentualReducaoST: Double read FPercentualReducaoST write FPercentualReducaoST;
    property ValorBaseST: Double read FValorBaseST write FValorBaseST;
    property AliquotaST: Double read FAliquotaST write FAliquotaST;
    property ValorST: Double read FValorST write FValorST;
  end;

  TICMS40_41_50 = Class(TPersistent)
  private
    FOrigem: TNFeOrigem;
  public
    constructor Create;
    destructor Destroy; override;

  published
    property Origem: TNFeOrigem read FOrigem write FOrigem;
  end;

  TICMS51 = Class(TPersistent)
  private
    FOrigem: TNFeOrigem;
    FModalidade: TNFeModalidade;
    FPercentualReducao: Double;
    FValorBase: Double;
    FAliquota: Double;
    FValor: Double;
  public
    constructor Create;
    destructor Destroy; override;

  published
    property Origem: TNFeOrigem read FOrigem write FOrigem;
    property Modalidade: TNFeModalidade read FModalidade write FModalidade;
    property PercentualReducao: Double read FPercentualReducao write FPercentualReducao;
    property ValorBase: Double read FValorBase write FValorBase;
    property Aliquota: Double read FAliquota write FAliquota;
    property Valor: Double read FValor write FValor;
  end;

  TICMS60 = Class(TPersistent)
  private
    FOrigem: TNFeOrigem;
    FValorBaseST: Double;
    FValorST: Double;
  public
    constructor Create;
    destructor Destroy; override;

  published
    property Origem: TNFeOrigem read FOrigem write FOrigem;
    property ValorBaseST: Double read FValorBaseST write FValorBaseST;
    property ValorST: Double read FValorST write FValorST;
  end;

  TICMS70 = Class(TPersistent)
  private
    FOrigem: TNFeOrigem;
    FModalidade: TNFeModalidade;
    FPercentualReducao: Double;
    FValorBase: Double;
    FAliquota: Double;
    FValor: Double;
    FModalidadeST: TNFeModalidadeST;
    FPercentualMargemST: Double;
    FPercentualReducaoST: Double;
    FValorBaseST: Double;
    FAliquotaST: Double;
    FValorST: Double;
  public
    constructor Create;
    destructor Destroy; override;

  published
    property Origem: TNFeOrigem read FOrigem write FOrigem;
    property Modalidade: TNFeModalidade read FModalidade write FModalidade;
    property PercentualReducao: Double read FPercentualReducao write FPercentualReducao;
    property ValorBase: Double read FValorBase write FValorBase;
    property Aliquota: Double read FAliquota write FAliquota;
    property Valor: Double read FValor write FValor;
    property ModalidadeST: TNFeModalidadeST read FModalidadeST write FModalidadeST;
    property PercentualMargemST: Double read FPercentualMargemST write FPercentualMargemST;
    property PercentualReducaoST: Double read FPercentualReducaoST write FPercentualReducaoST;
    property ValorBaseST: Double read FValorBaseST write FValorBaseST;
    property AliquotaST: Double read FAliquotaST write FAliquotaST;
    property ValorST: Double read FValorST write FValorST;
  end;

  TICMS90 = Class(TPersistent)
  private
    FOrigem: TNFeOrigem;
    FModalidade: TNFeModalidade;
    FPercentualReducao: Double;
    FValorBase: Double;
    FAliquota: Double;
    FValor: Double;
    FModalidadeST: TNFeModalidadeST;
    FPercentualMargemST: Double;
    FPercentualReducaoST: Double;
    FValorBaseST: Double;
    FAliquotaST: Double;
    FValorST: Double;
  public
    constructor Create;
    destructor Destroy; override;

  published
    property Origem: TNFeOrigem read FOrigem write FOrigem;
    property Modalidade: TNFeModalidade read FModalidade write FModalidade;
    property PercentualReducao: Double read FPercentualReducao write FPercentualReducao;
    property ValorBase: Double read FValorBase write FValorBase;
    property Aliquota: Double read FAliquota write FAliquota;
    property Valor: Double read FValor write FValor;
    property ModalidadeST: TNFeModalidadeST read FModalidadeST write FModalidadeST;
    property PercentualMargemST: Double read FPercentualMargemST write FPercentualMargemST;
    property PercentualReducaoST: Double read FPercentualReducaoST write FPercentualReducaoST;
    property ValorBaseST: Double read FValorBaseST write FValorBaseST;
    property AliquotaST: Double read FAliquotaST write FAliquotaST;
    property ValorST: Double read FValorST write FValorST;
  end;

  TICMS = Class(TPersistent)
  private
    FSituacaoTributaria: String;
    FCST: String;
    FICMS00: TICMS00;
    FICMS10: TICMS10;
    FICMS20: TICMS20;
    FICMS30: TICMS30;
    FICMS40_41_50: TICMS40_41_50;
    FICMS51: TICMS51;
    FICMS60: TICMS60;
    FICMS70: TICMS70;
    FICMS90: TICMS90;
    procedure SetCST(AValue: String);
    function  GetCST: String;
  public
    constructor Create;
    destructor Destroy; override;

  published
    property SituacaoTributaria: String read FSituacaoTributaria write FSituacaoTributaria;
    property CST: String read GetCST write SetCST;
    property ICMS00: TICMS00 read FICMS00 write FICMS00;
    property ICMS10: TICMS10 read FICMS10 write FICMS10;
    property ICMS20: TICMS20 read FICMS20 write FICMS20;
    property ICMS30: TICMS30 read FICMS30 write FICMS30;
    property ICMS40_41_50: TICMS40_41_50 read FICMS40_41_50 write FICMS40_41_50;
    property ICMS51: TICMS51 read FICMS51 write FICMS51;
    property ICMS60: TICMS60 read FICMS60 write FICMS60;
    property ICMS70: TICMS70 read FICMS70 write FICMS70;
    property ICMS90: TICMS90 read FICMS90 write FICMS90;
  end;

  TPIS01_02 = Class(TPersistent)
  private
    FValorBase: Double;
    FAliquota: Double;
    FValor: Double;
  public

  published
    property ValorBase: Double read FValorBase write FValorBase;
    property Aliquota: Double read FAliquota write FAliquota;
    property Valor: Double read FValor write FValor;
  end;

  TPIS03 = Class(TPersistent)
  private
    FQuantidade: Double;
    FAliquota: Double;
    FValor: Double;
  public

  published
    property Quantidade: Double read FQuantidade write FQuantidade;
    property Aliquota: Double read FAliquota write FAliquota;
    property Valor: Double read FValor write FValor;
  end;

  TPIS99 = Class(TPersistent)
  private
    FTipoCalculo: TNFeTipoCalculo;
    FValorBase: Double;
    FAliquota: Double;
    FQuantidade: Double;
    FValor: Double;
  public
    constructor Create;
    destructor Destroy; override;

  published
    property TipoCalculo: TNFeTipoCalculo read FTipoCalculo write FTipoCalculo;
    property ValorBase: Double read FValorBase write FValorBase;
    property Aliquota: Double read FAliquota write FAliquota;
    property Quantidade: Double read FQuantidade write FQuantidade;
    property Valor: Double read FValor write FValor;
  end;

  TPIS = Class(TPersistent)
  private
    FSituacaoTributaria: String;
    FCST: String;
    FPIS01_02: TPIS01_02;
    FPIS03: TPIS03;
    FPIS99: TPIS99;
    function GetCST: String;
    procedure SetCST(AValue: String);
  public
    constructor Create;
    destructor Destroy; override;

  published
    property SituacaoTributaria: String read FSituacaoTributaria write FSituacaoTributaria;
    property CST: String read GetCST write SetCST;
    property PIS01_02: TPIS01_02 read FPIS01_02 write FPIS01_02;
    property PIS03: TPIS03 read FPIS03 write FPIS03;
    property PIS99: TPIS99 read FPIS99 write FPIS99;
  end;

  TPISST = class(Tpersistent)
  private
    FValorBase: Double;
    FAliquotaValor: Double;
    FValorPISST: Double;
    FAliquotaPerc: Double;
    FQuantidade: Double;
    procedure SetAliquotaPerc(const Value: Double);
    procedure SetAliquotaValor(const Value: Double);
    procedure SetQuantidade(const Value: Double);
    procedure SetValorPISST(const Value: Double);
    procedure SetValorBase(const Value: Double);
  public
    constructor Create;
    destructor Destroy; override;
  published
    property ValorBase:Double read FValorBase write SetValorBase;
    property AliquotaPerc:Double read FAliquotaPerc write SetAliquotaPerc;
    property Quantidade:Double read FQuantidade write SetQuantidade;
    property AliquotaValor:Double read FAliquotaValor write SetAliquotaValor;
    property ValorPISST:Double read FValorPISST write SetValorPISST;
  end;


  TCOFINS01_02 = Class(TPersistent)
  private
    FValorBase: Double;
    FAliquota: Double;
    FValor: Double;
  public

  published
    property ValorBase: Double read FValorBase write FValorBase;
    property Aliquota: Double read FAliquota write FAliquota;
    property Valor: Double read FValor write FValor;
  end;

  TCOFINS03 = Class(TPersistent)
  private
    FQuantidade: Double;
    FAliquota: Double;
    FValor: Double;
  public

  published
    property Quantidade: Double read FQuantidade write FQuantidade;
    property Aliquota: Double read FAliquota write FAliquota;
    property Valor: Double read FValor write FValor;
  end;

  TCOFINS99 = Class(TPersistent)
  private
    FTipoCalculo: TNFeTipoCalculo;
    FValorBase: Double;
    FAliquota: Double;
    FQuantidade: Double;
    FValor: Double;
  public
    constructor Create;
    destructor Destroy; override;

  published
    property TipoCalculo: TNFeTipoCalculo read FTipoCalculo write FTipoCalculo;
    property ValorBase: Double read FValorBase write FValorBase;
    property Aliquota: Double read FAliquota write FAliquota;
    property Quantidade: Double read FQuantidade write FQuantidade;
    property Valor: Double read FValor write FValor;
  end;

  TCOFINS = Class(TPersistent)
  private
    FSituacaoTributaria: String;
    FCST: String;
    FCOFINS01_02: TCOFINS01_02;
    FCOFINS03: TCOFINS03;
    FCOFINS99: TCOFINS99;
    function GetCST: String;
    procedure SetCST(AValue: String);
  public
    constructor Create;
    destructor Destroy; override;

  published
    property SituacaoTributaria: String read FSituacaoTributaria write FSituacaoTributaria;
    property CST: String read GetCST write SetCST;
    property COFINS01_02: TCOFINS01_02 read FCOFINS01_02 write FCOFINS01_02;
    property COFINS03: TCOFINS03 read FCOFINS03 write FCOFINS03;
    property COFINS99: TCOFINS99 read FCOFINS99 write FCOFINS99;
  end;


  TCOFINSST = class(TPersistent)
  private
    FAliquotaValor: Double;
    FValorBase: Double;
    FQuantidade: Double;
    FValorCOFINSST: Double;
    FAliquotaPerc: Double;
    procedure SetAliquotaPerc(const Value: Double);
    procedure SetAliquotaValor(const Value: Double);
    procedure SetQuantidade(const Value: Double);
    procedure SetValorBase(const Value: Double);
    procedure SetValorCOFINSST(const Value: Double);
  public
    constructor Create;
    destructor Destroy; override;
  published
    property ValorBase:Double read FValorBase write SetValorBase;
    property AliquotaPerc:Double read FAliquotaPerc write SetAliquotaPerc;
    property Quantidade:Double read FQuantidade write SetQuantidade;
    property AliquotaValor:Double read FAliquotaValor write SetAliquotaValor;
    property ValorCOFINSST:Double read FValorCOFINSST write SetValorCOFINSST;
  end;

  TIPI = Class(TPersistent)
  private
    FClasseEnquadramento: String;
    FCNPJProdutor: String;
    FQuantidadeSelos: Double;
    FCodigoSeloIPI: String;
    FCodigoEnquadramento: String;
    FCST: String;
    FFSituacaoTributaria: String;
    FValorBase: Double;
    FAliquota: Double;
    FQuantidade: Double;
    FValorUnidade: Double;
    FValor: Double;
    procedure SetClasseEnquadramento(const Value: String);
    procedure SetCNPJProdutor(const Value: String);
    procedure SetCodigoEnquadramento(const Value: String);
    procedure SetCodigoSeloIPI(const Value: String);
    procedure SetQuantidadeSelos(const Value: Double);
    procedure SetCST(const Value: String);
    procedure SetFSituacaoTributaria(const Value: String);
    procedure SetAliquota(const Value: Double);
    procedure SetQuantidade(const Value: Double);
    procedure SetValor(const Value: Double);
    procedure SetValorBase(const Value: Double);
    procedure SetValorUnidade(const Value: Double);
  public
    constructor Create;
    destructor Destroy; override;

  published
    property FSituacaoTributaria:String read FFSituacaoTributaria write SetFSituacaoTributaria;
    property ClasseEnquadramento: String read FClasseEnquadramento write SetClasseEnquadramento;
    property CNPJProdutor:String read FCNPJProdutor write SetCNPJProdutor;
    property CodigoSeloIPI: String read FCodigoSeloIPI write SetCodigoSeloIPI;
    property QuantidadeSelos: Double read FQuantidadeSelos write SetQuantidadeSelos;
    property CodigoEnquadramento: String read FCodigoEnquadramento write SetCodigoEnquadramento;
    property CST:String read FCST write SetCST;
    property ValorBase:Double read FValorBase write SetValorBase;
    property Quantidade:Double read FQuantidade write SetQuantidade;
    property ValorUnidade:Double read FValorUnidade write SetValorUnidade;
    property Aliquota:Double read FAliquota write SetAliquota;
    property Valor:Double read FValor write SetValor;
  end;

  TII = Class(TPersistent)
  private
    FValorDespAduaneiras: Double;
    FValorIOF: Double;
    FValorBase: Double;
    FValorII: Double;
    procedure SetValorBase(const Value: Double);
    procedure SetValorDespAduaneiras(const Value: Double);
    procedure SetValorII(const Value: Double);
    procedure SetValorIOF(const Value: Double);
  public
    constructor Create;
    destructor Destroy; override;

  published
    property ValorBase:Double read FValorBase write SetValorBase;
    property ValorDespAduaneiras:Double read FValorDespAduaneiras write SetValorDespAduaneiras;
    property ValorII: Double read FValorII write SetValorII;
    property ValorIOF: Double read FValorIOF write SetValorIOF;
  end;

  TISSQN = Class(TPersistent)
  private
    FValorISSQN: Double;
    FAliquota: Double;
    FValorBase: Double;
    FMunicipioFatoGerador: Integer;
    FCodigoServico: String;
    procedure SetAliquota(const Value: Double);
    procedure SetMunicipioFatoGerador(const Value: Integer);
    procedure SetValorBase(const Value: Double);
    procedure SetValorISSQN(const Value: Double);
    procedure SetCodigoServico(const Value: String);
  public
  published
    property ValorBase:Double read FValorBase write SetValorBase;
    property Aliquota:Double read FAliquota write SetAliquota;
    property ValorISSQN:Double read FValorISSQN write SetValorISSQN;
    property MunicipioFatoGerador: Integer read FMunicipioFatoGerador write SetMunicipioFatoGerador;
    property CodigoServico:String read FCodigoServico write SetCodigoServico;
  end;


  TTributos = Class(TPersistent)
  private
    FICMS: TICMS;
    FPIS: TPIS;
    FCOFINS: TCOFINS;
    FIPI: TIPI;
    FII: TII;
    FPISST: TPISST;
    FCOFINSST: TCOFINSST;
    FISSQN: TISSQN;
    procedure SetIPI(const Value: TIPI);
    procedure SetII(const Value: TII);
    procedure SetPISST(const Value: TPISST);
    procedure SetCOFINSST(const Value: TCOFINSST);
    procedure SetISSQN(const Value: TISSQN);
  public
    constructor Create;
    destructor Destroy; override;

  published
    property ICMS: TICMS read FICMS write FICMS;
    property PIS: TPIS read FPIS write FPIS;
    property COFINS: TCOFINS read FCOFINS write FCOFINS;
    property IPI:TIPI read FIPI write SetIPI;
    property II:TII read FII write SetII;
    property PISST : TPISST read FPISST write SetPISST;
    property COFINSST: TCOFINSST read FCOFINSST write SetCOFINSST;
    property ISSQN: TISSQN read FISSQN write SetISSQN;
  end;


  DadoProduto = class(TCollectionItem)
  private
    FCodigo : String;
    FEAN : String;
    FDescricao : String;
    FNCM : String;
    FTributos : TTributos;
    FCFOP : Integer;
    FUnidade : String;
    FQuantidade : Double;
    FValorUnitario : Double;
    FValorTotal : Double;
    FValorFrete: Double;
    FValorSeguro: Double;
    FValorDesconto: Double;
    FDI: TDI;
    FQuantidadeTributavel: Double;
    FValorUnitarioTributacao: Double;
    FUnidadeTributavel: String;
    FGTINUnidadeTributavel: String;
    FInformacaoAdicional: String;
    procedure SetCodigo(AValue: String);
    procedure SetEAN(AValue: String);
    procedure SetDescricao(AValue: String);
    procedure SetNCM(AValue: String);
    procedure SetUnidade(AValue: String);
    procedure SetDI(const Value: TDI);
    procedure SetQuantidadeTributavel(const Value: Double);
    procedure SetUnidadeTributavel(const Value: String);
    procedure SetValorUnitarioTributacao(const Value: Double);
    procedure SetGTINUnidadeTributavel(const Value: String);
    procedure SetInformacaoAdicional(const Value: String);
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;

  published
    property Codigo : String read FCodigo write SetCodigo;
    property EAN : String read FEAN write SetEAN;
    property Descricao : String read FDescricao write SetDescricao;
    property NCM : String read FNCM write SetNCM;
    property Tributos : TTributos read FTributos write FTributos;
    property CFOP : Integer read FCFOP write FCFOP;
    property Unidade : String read FUnidade write SetUnidade;
    property Quantidade : Double read FQuantidade write FQuantidade;
    property ValorUnitario : Double read FValorUnitario write FValorUnitario;

    property GTINUnidadeTributavel: String read FGTINUnidadeTributavel write SetGTINUnidadeTributavel;
    property UnidadeTributavel: String read FUnidadeTributavel write SetUnidadeTributavel;
    property QuantidadeTributavel: Double read FQuantidadeTributavel write SetQuantidadeTributavel;
    property ValorUnitarioTributacao: Double read FValorUnitarioTributacao write SetValorUnitarioTributacao;

    property ValorTotal : Double read FValorTotal write FValorTotal;
    property ValorFrete : Double read FValorFrete write FValorFrete;
    property ValorSeguro : Double read FValorSeguro write FValorSeguro;
    property ValorDesconto : Double read FValorDesconto write FValorDesconto;

    property InformacaoAdicional:String read FInformacaoAdicional write SetInformacaoAdicional;
    
    property DI : TDI read FDI write SetDI;
  end;

  TDadosProdutos = class(TCollection)
  private
    function GetItem(Index: Integer): DadoProduto;
    procedure SetItem(Index: Integer; const Value: DadoProduto);
  public
    function  Add: DadoProduto;
    function Insert(Index: Integer): DadoProduto;
    property Items[Index: Integer]: DadoProduto read GetItem  write SetItem;
  end;

implementation

uses ACBrNFeUtil, Math;

{ TICMS }

constructor TICMS.Create;
begin
  FSituacaoTributaria := NFeSituacaoTributariaICMS[0];
  FCST                := NFeCSTICMS[0];
  FICMS00 := TICMS00.Create;
  FICMS10 := TICMS10.Create;
  FICMS20 := TICMS20.Create;
  FICMS30 := TICMS30.Create;
  FICMS40_41_50 := TICMS40_41_50.Create;
  FICMS51 := TICMS51.Create;
  FICMS60 := TICMS60.Create;
  FICMS70 := TICMS70.Create;
  FICMS90 := TICMS90.Create;
end;

destructor TICMS.Destroy;
begin
  FICMS00.Free;
  FICMS10.Free;
  FICMS20.Free;
  FICMS30.Free;
  FICMS40_41_50.Free;
  FICMS51.Free;
  FICMS60.Free;
  FICMS70.Free;
  FICMS90.Free;
  inherited;
end;

function TICMS.GetCST: String;
begin
  Result := FCST;
end;

procedure TICMS.SetCST(AValue: String);
var
  i: Integer;
begin
  FCST := NotaUtil.Poem_Zeros(AValue, 2);
  for i:= 0 to High(NFeCSTICMS) do
  begin
    if NFeCSTICMS[I] = AValue then
      FSituacaoTributaria := NFeSituacaoTributariaICMS[I];
  end;
end;

{ TTributos }

constructor TTributos.Create;
begin
  FICMS     := TICMS.Create;
  FPIS      := TPIS.Create;
  FCOFINS   := TCOFINS.Create;
  FIPI      := TIPI.Create;
  FII       := TII.Create;
  FPISST    := TPISST.Create;
  FCOFINSST := TCOFINSST.Create;
  FISSQN    := TISSQN.Create;
end;

destructor TTributos.Destroy;
begin
  FICMS.Free;
  FPIS.Free;
  FCOFINS.Free;
  FIPI.Free;
  FII.Free;
  FPISST.Free;
  FCOFINSST.Free;
  FISSQN.Free;
  inherited;
end;

procedure TTributos.SetCOFINSST(const Value: TCOFINSST);
begin
  FCOFINSST := Value;
end;

procedure TTributos.SetII(const Value: TII);
begin
  FII := Value;
end;

procedure TTributos.SetIPI(const Value: TIPI);
begin
  FIPI := Value;
end;

procedure TTributos.SetISSQN(const Value: TISSQN);
begin
  FISSQN := Value;
end;

procedure TTributos.SetPISST(const Value: TPISST);
begin
  FPISST := Value;
end;

{ DadoProduto }

constructor DadoProduto.Create(Collection: TCollection);
begin
  inherited Create(Collection);
  FTributos := TTributos.Create;
  FDI       := TDI.Create;
end;

destructor DadoProduto.Destroy;
begin
  FTributos.Free;
  FDI.Free;
  inherited;
end;

procedure DadoProduto.SetCodigo(AValue: String);
begin
  FCodigo := NotaUtil.TrataString(AValue, 60);
end;

procedure DadoProduto.SetDescricao(AValue: String);
begin
  FDescricao := NotaUtil.TrataString(AValue, 120);
end;

procedure DadoProduto.SetDI(const Value: TDI);
begin
  FDI := Value;
end;

procedure DadoProduto.SetEAN(AValue: String);
begin
  if NotaUtil.NaoEstaVazio(AValue) then
  begin
    if NotaUtil.TamanhoMenor(AValue, 8) then
      FEAN := NotaUtil.Poem_Zeros(AValue, 8);
  end
end;

procedure DadoProduto.SetGTINUnidadeTributavel(const Value: String);
begin
  FGTINUnidadeTributavel := Value;
end;

procedure DadoProduto.SetInformacaoAdicional(const Value: String);
begin
  FInformacaoAdicional := Value;
end;

procedure DadoProduto.SetNCM(AValue: String);
begin
  if NotaUtil.NaoEstaVazio(AValue) then
    FNCM := NotaUtil.Poem_Zeros(NotaUtil.LimpaNumero(AValue), 8);
end;

procedure DadoProduto.SetQuantidadeTributavel(const Value: Double);
begin
  FQuantidadeTributavel := Value;
end;

procedure DadoProduto.SetUnidade(AValue: String);
begin
  FUnidade := NotaUtil.CortaD(AValue, 6);
end;

procedure DadoProduto.SetUnidadeTributavel(const Value: String);
begin
  FUnidadeTributavel := Value;
end;

procedure DadoProduto.SetValorUnitarioTributacao(const Value: Double);
begin
  FValorUnitarioTributacao := Value;
end;

{ TDadosProdutos }

function TDadosProdutos.Add: DadoProduto;
begin
  Result := DadoProduto(inherited Add);
end;

function TDadosProdutos.GetItem(Index: Integer): DadoProduto;
begin
  Result := DadoProduto(inherited Items[Index]);
end;

function TDadosProdutos.Insert(Index: Integer): DadoProduto;
begin
  Result := DadoProduto(inherited Insert(Index));
end;

procedure TDadosProdutos.SetItem(Index: Integer; const Value: DadoProduto);
begin
  Items[Index].Assign(Value);
end;

{ TPIS }

constructor TPIS.Create;
begin
  FSituacaoTributaria := NFeSituacaoTributariaPIS[0];
  FCST                := NFeCSTPIS[0];
  FPIS01_02           := TPIS01_02.Create;
  FPIS03              := TPIS03.Create;
  FPIS99              := TPIS99.Create;
end;

destructor TPIS.Destroy;
begin
  FPIS01_02.Free;
  FPIS03.Free;
  FPIS99.Free;
  inherited;
end;

function TPIS.GetCST: String;
begin
  Result := FCST;
end;

procedure TPIS.SetCST(AValue: String);
var
  i: Integer;
begin
  FCST := NotaUtil.Poem_Zeros(AValue, 2);
  for i:= 0 to High(NFeCSTPIS) do
  begin
    if NFeCSTPIS[I] = AValue then
      FSituacaoTributaria := NFeSituacaoTributariaPIS[I];
  end;
end;

{ TICMS00 }

constructor TICMS00.Create;
begin
  FOrigem       := orNacional;
  FModalidade   := modValorDaOperacao;
end;

destructor TICMS00.Destroy;
begin

  inherited;
end;

{ TICMS10 }

constructor TICMS10.Create;
begin
  FOrigem       := orNacional;
  FModalidade   := modValorDaOperacao;
  FModalidadeST := modStMargemValorAgregado;
end;

destructor TICMS10.Destroy;
begin

  inherited;
end;

{ TCOFINS }

constructor TCOFINS.Create;
begin
  FSituacaoTributaria := NFeSituacaoTributariaCOFINS[0];
  FCST                := NFeCSTCOFINS[0];
  FCOFINS01_02        := TCOFINS01_02.Create;
  FCOFINS03           := TCOFINS03.Create;
  FCOFINS99           := TCOFINS99.Create;  
end;

destructor TCOFINS.Destroy;
begin
  FCOFINS01_02.Free;
  FCOFINS03.Free;
  FCOFINS99.Free;
  inherited;
end;

function TCOFINS.GetCST: String;
begin
  Result := FCST;
end;

procedure TCOFINS.SetCST(AValue: String);
var
  i: Integer;
begin
  FCST := NotaUtil.Poem_Zeros(AValue, 2);
  for i:= 0 to High(NFeCSTCOFINS) do
  begin
    if NFeCSTCOFINS[I] = AValue then
      FSituacaoTributaria := NFeSituacaoTributariaCOFINS[I];
  end;
end;

{ TICMS20 }

constructor TICMS20.Create;
begin
  FOrigem       := orNacional;
  FModalidade   := modValorDaOperacao;
end;

destructor TICMS20.Destroy;
begin

  inherited;
end;

{ TPIS99 }

constructor TPIS99.Create;
begin
  FTipoCalculo := tipCPercentual;
end;

destructor TPIS99.Destroy;
begin

  inherited;
end;

{ TCOFINS99 }

constructor TCOFINS99.Create;
begin
  FTipoCalculo := tipCPercentual;
end;

destructor TCOFINS99.Destroy;
begin

  inherited;
end;

{ TICMS30 }

constructor TICMS30.Create;
begin
  FOrigem       := orNacional;
  FModalidadeST := modStMargemValorAgregado;
end;

destructor TICMS30.Destroy;
begin

  inherited;
end;

{ TICMS40_41_50 }

constructor TICMS40_41_50.Create;
begin
  FOrigem := orNacional;
end;

destructor TICMS40_41_50.Destroy;
begin

  inherited;
end;

{ TICMS51 }

constructor TICMS51.Create;
begin
  FOrigem       := orNacional;
  FModalidade   := modValorDaOperacao;
end;

destructor TICMS51.Destroy;
begin

  inherited;
end;

{ TICMS60 }

constructor TICMS60.Create;
begin
  FOrigem := orNacional;
end;

destructor TICMS60.Destroy;
begin

  inherited;
end;

{ TICMS70 }

constructor TICMS70.Create;
begin
  FOrigem       := orNacional;
  FModalidade   := modValorDaOperacao;
  FModalidadeST := modStMargemValorAgregado;
end;

destructor TICMS70.Destroy;
begin

  inherited;
end;

{ TICMS90 }

constructor TICMS90.Create;
begin
  FOrigem       := orNacional;
  FModalidade   := modValorDaOperacao;
  FModalidadeST := modStMargemValorAgregado;
end;

destructor TICMS90.Destroy;
begin

  inherited;
end;



{ TIPI }

constructor TIPI.Create;
begin
  {Não usar default pois a tag deverá ser Informada apenas quando o item for
   sujeito ao IPI}
end;

destructor TIPI.Destroy;
begin
  FSituacaoTributaria :='';
  inherited;
end;

procedure TIPI.SetAliquota(const Value: Double);
begin
  FAliquota := Value;
end;

procedure TIPI.SetClasseEnquadramento(const Value: String);
begin
  FClasseEnquadramento := Value;
end;

procedure TIPI.SetCNPJProdutor(const Value: String);
begin
  FCNPJProdutor := Value;
end;

procedure TIPI.SetCodigoEnquadramento(const Value: String);
begin
  FCodigoEnquadramento := Value;
end;

procedure TIPI.SetCodigoSeloIPI(const Value: String);
begin
  FCodigoSeloIPI := Value;
end;

procedure TIPI.SetCST(const Value: String);
var
  i: Integer;
begin
  FCST := NotaUtil.Poem_Zeros(Value, 2);
  for i:= 0 to High(NFeCSTIPI) do
  begin
    if NFeCSTIPI[I] = Value then
      FSituacaoTributaria := NFeSituacaoTributariaIPI[I];
  end;
  FCST := Value;

end;

procedure TIPI.SetFSituacaoTributaria(const Value: String);
begin
  FFSituacaoTributaria := Value;
end;

procedure TIPI.SetQuantidade(const Value: Double);
begin
  FQuantidade := Value;
end;

procedure TIPI.SetQuantidadeSelos(const Value: Double);
begin
  FQuantidadeSelos := Value;
end;

procedure TIPI.SetValor(const Value: Double);
begin
  FValor := Value;
end;

procedure TIPI.SetValorBase(const Value: Double);
begin
  FValorBase := Value;
end;

procedure TIPI.SetValorUnidade(const Value: Double);
begin
  FValorUnidade := Value;
end;

{ TII }

constructor TII.Create;
begin
  {Não usar default pois a tag deverá ser Informada apenas quando o item for
   sujeito ao II}
end;

destructor TII.Destroy;
begin

  inherited;
end;

procedure TII.SetValorBase(const Value: Double);
begin
  FValorBase := Value;
end;

procedure TII.SetValorDespAduaneiras(const Value: Double);
begin
  FValorDespAduaneiras := Value;
end;

procedure TII.SetValorII(const Value: Double);
begin
  FValorII := Value;
end;

procedure TII.SetValorIOF(const Value: Double);
begin
  FValorIOF := Value;
end;

// Fim Alteracao IPI e II>


{ TPISST }

constructor TPISST.Create;
begin

end;

destructor TPISST.Destroy;
begin

  inherited;
end;

procedure TPISST.SetAliquotaPerc(const Value: Double);
begin
  FAliquotaPerc := Value;
end;

procedure TPISST.SetAliquotaValor(const Value: Double);
begin
  FAliquotaValor := Value;
end;

procedure TPISST.SetQuantidade(const Value: Double);
begin
  FQuantidade := Value;
end;

procedure TPISST.SetValorBase(const Value: Double);
begin
  FValorBase := Value;
end;

procedure TPISST.SetValorPISST(const Value: Double);
begin
  FValorPISST := Value;
end;

{ TCOFINSST }

constructor TCOFINSST.Create;
begin

end;

destructor TCOFINSST.Destroy;
begin

  inherited;
end;


//Fim Alteracao IPI, II, PISST
procedure TCOFINSST.SetAliquotaPerc(const Value: Double);
begin
  FAliquotaPerc := Value;
end;

procedure TCOFINSST.SetAliquotaValor(const Value: Double);
begin
  FAliquotaValor := Value;
end;

procedure TCOFINSST.SetQuantidade(const Value: Double);
begin
  FQuantidade := Value;
end;

procedure TCOFINSST.SetValorBase(const Value: Double);
begin
  FValorBase := Value;
end;

procedure TCOFINSST.SetValorCOFINSST(const Value: Double);
begin
  FValorCOFINSST := Value;
end;

{ TISSQN }

procedure TISSQN.SetAliquota(const Value: Double);
begin
  FAliquota := Value;
end;

procedure TISSQN.SetCodigoServico(const Value: String);
begin
  FCodigoServico := Value;
end;

procedure TISSQN.SetMunicipioFatoGerador(const Value: Integer);
begin
  FMunicipioFatoGerador := Value;
end;

procedure TISSQN.SetValorBase(const Value: Double);
begin
  FValorBase := Value;
end;

procedure TISSQN.SetValorISSQN(const Value: Double);
begin
  FValorISSQN := Value;
end;

end.
