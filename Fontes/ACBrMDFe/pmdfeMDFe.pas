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

unit pmdfeMDFe;

interface

uses
  SysUtils, Classes,
{$IFNDEF VER130}
  Variants,
{$ENDIF}
  pmdfeConversao, pmdfeSignature, pmdfeProcMDFe, pcnConversao;

type

  // Relação dos Tipos
  TinfMDFe                      = class;
  TinfMunCarregaCollection      = class;
  TinfMunCarregaCollectionItem  = class;
  TinfPercursoCollection        = class;
  TinfPercursoCollectionItem    = class;
  Tide                          = class;
  Temit                         = class;
  TenderEmit                    = class;

  Trodo                         = class; // Informações do modal Rodoviário
  TveicPrincipal                = class;
  TcondutorCollection           = class;
  TcondutorCollectionItem       = class;
  TveicReboqueCollection        = class;
  TveicReboqueCollectionItem    = class;
  TvalePed                      = class;
  TdispCollection               = class;
  TdispCollectionItem           = class;

  Taereo                        = class; // Informações do modal Aéreo

  Taquav                          = class; // Informações do modal Aquaviário
  TinfTermCarregCollection        = class;
  TinfTermCarregCollectionItem    = class;
  TinfTermDescarregCollection     = class;
  TinfTermDescarregCollectionItem = class;
  TinfEmbCombCollection           = class;
  TinfEmbCombCollectionItem       = class;

  Tferrov                       = class; // Informações do modal Ferroviário
  TvagCollection                = class;
  TvagCollectionItem            = class;

  TinfDoc                       = class;
  TinfMunDescargaCollection     = class;
  TinfMunDescargaCollectionItem = class;
  TinfCTeCollection             = class;
  TinfCTeCollectionItem         = class;
  TinfCTCollection              = class;
  TinfCTCollectionItem          = class;
  TinfNFeCollection             = class;
  TinfNFeCollectionItem         = class;
  TinfNFCollection              = class;
  TinfNFCollectionItem          = class;

  Ttot                          = class;
  TlacresCollection             = class;
  TlacresCollectionItem         = class;
  TinfAdic                      = class;

  TMDFe                         = class;

  // Definição dos Tipos
  TinfMDFe = class(TPersistent)
  private
    FID: string;
  published
    property ID: string read FID write FID;
  end;

  TinfMunCarregaCollection = class(TCollection)
  private
    function GetItem(Index: Integer): TinfMunCarregaCollectionItem;
    procedure SetItem(Index: Integer; Value: TinfMunCarregaCollectionItem);
  public
    constructor Create(AOwner: Tide);
    function Add: TinfMunCarregaCollectionItem;
    property Items[Index: Integer]: TinfMunCarregaCollectionItem read GetItem write SetItem; default;
  end;

  TinfMunCarregaCollectionItem = class(TCollectionItem)
  private
    FcMunCarrega: integer;
    FxMunCarrega: String;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
  published
    property cMunCarrega: integer read FcMunCarrega write FcMunCarrega;
    property xMunCarrega: String read FxMunCarrega write FxMunCarrega;
  end;

  TinfPercursoCollection = class(TCollection)
  private
    function GetItem(Index: Integer): TinfPercursoCollectionItem;
    procedure SetItem(Index: Integer; Value: TinfPercursoCollectionItem);
  public
    constructor Create(AOwner: Tide);
    function Add: TinfPercursoCollectionItem;
    property Items[Index: Integer]: TinfPercursoCollectionItem read GetItem write SetItem; default;
  end;

  TinfPercursoCollectionItem = class(TCollectionItem)
  private
    FUFPer: String;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
  published
    property UFPer: String read FUFPer write FUFPer;
  end;

  TIde = class(TPersistent)
  private
    FcUF: integer;
    FtpAmb: TpcnTipoAmbiente;
    FtpEmit: TMDFeTpEmitente;
    Fmod: String;
    Fserie: integer;
    FnMDF: integer;
    FcMDF: integer;
    FcDV: integer;
    Fmodal: TMDFeModal;
    FdhEmi: TDateTime;
    FtpEmis: TpcnTipoEmissao;
    FprocEmi: TpcnProcessoEmissao;
    FverProc: String;
    FUFIni: String;
    FUFFim: String;
    FinfMunCarrega: TinfMunCarregaCollection;
    FinfPercurso: TinfPercursoCollection;

    procedure SetinfMunCarrega(Value: TinfMunCarregaCollection);
    procedure SetinfPercurso(Value: TinfPercursoCollection);
  public
    constructor Create(AOwner: TMDFe);
    destructor Destroy; override;
  published
    property cUF: integer read FcUF write FcUF;
    property tpAmb: TpcnTipoAmbiente read FtpAmb write FtpAmb;
    property tpEmit: TMDFeTpEmitente read FtpEmit write FtpEmit;
    property modelo: String read Fmod write Fmod;
    property serie: integer read Fserie write Fserie;
    property nMDF: integer read FnMDF write FnMDF;
    property cMDF: integer read FcMDF write FcMDF;
    property cDV: integer read FcDV write FcDV;
    property modal: TMDFeModal read Fmodal write Fmodal;
    property dhEmi: TDateTime read FdhEmi write FdhEmi;
    property tpEmis: TpcnTipoEmissao read FtpEmis write FtpEmis;
    property procEmi: TpcnProcessoEmissao read FprocEmi write FprocEmi;
    property verProc: String read FverProc write FverProc;
    property UFIni: String read FUFIni write FUFIni;
    property UFFim: String read FUFFim write FUFFim;
    property infMunCarrega: TinfMunCarregaCollection read FinfMunCarrega write SetinfMunCarrega;
    property infPercurso: TinfPercursoCollection read FinfPercurso write SetinfPercurso;
  end;

  Temit = class(TPersistent)
  private
    FCNPJ  : String;
    FIE    : String;
    FxNome : String;
    FxFant : String;
    FenderEmit : TenderEmit;
  public
    constructor Create(AOwner: TMDFe);
    destructor Destroy; override;
  published
    property CNPJ : String read FCNPJ write FCNPJ;
    property IE : String read FIE write FIE;
    property xNome : String read FxNome write FxNome;
    property xFant : String read FxFant write FxFant;
    property enderEmit: TenderEmit read FenderEmit write FenderEmit;
  end;

  TenderEmit = class(TPersistent)
  private
    FxLgr    : string;
    Fnro     : string;
    FxCpl    : string;
    FxBairro : string;
    FcMun    : integer;
    FxMun    : string;
    FCEP     : integer;
    FUF      : string;
    Ffone    : String;
    Femail   : String;
  published
    property xLgr: string read FxLgr write FxLgr;
    property nro: string read Fnro write Fnro;
    property xCpl: string read FxCpl write FxCpl;
    property xBairro: string read FxBairro write FxBairro;
    property cMun: integer read FcMun write FcMun;
    property xMun: string read FxMun write FxMun;
    property CEP: integer read FCEP write FCEP;
    property UF: string read FUF write FUF;
    property fone: String read Ffone write Ffone;
    property email: String read Femail write Femail;
  end;

  TRodo = class(TPersistent)
  private
    FRNTRC   : String;
    FCIOT    : String;
    FveicPrincipal: TveicPrincipal;
    FveicReboque : TveicReboqueCollection;
    FvalePed : TvalePed;

    procedure SetveicReboque(const Value: TveicReboqueCollection);
  public
    constructor Create(AOwner: TMDFe);
    destructor Destroy; override;
  published
    property RNTRC: String read FRNTRC write FRNTRC;
    property CIOT: String read FCIOT write FCIOT;
    property veicPrincipal: TveicPrincipal read FveicPrincipal write FveicPrincipal;
    property veicReboque: TveicReboqueCollection read FveicReboque write SetveicReboque;
    property valePed: TvalePed read FvalePed write FvalePed;
  end;

 TveicPrincipal = class(TPersistent)
  private
    FcInt: String;
    Fplaca: String;
    Ftara: Integer;
    FcapKG: Integer;
    FcapM3: Integer;
    FRNTRC: String;
    Fcondutor: TcondutorCollection;

    procedure Setcondutor(const Value: TcondutorCollection);
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
  published
    property cInt: String read FcInt write FcInt;
    property placa: String read Fplaca write Fplaca;
    property tara: Integer read Ftara write Ftara;
    property capKG: Integer read FcapKG write FcapKG;
    property capM3: Integer read FcapM3 write FcapM3;
    property RNTRC: String read FRNTRC write FRNTRC;
    property condutor: TcondutorCollection read Fcondutor write Setcondutor;
  end;

  TcondutorCollection = class(TCollection)
  private
    function GetItem(Index: Integer): TcondutorCollectionItem;
    procedure SetItem(Index: Integer; Value: TcondutorCollectionItem);
  public
    constructor Create(AOwner: TveicPrincipal);
    function Add: TcondutorCollectionItem;
    property Items[Index: Integer]: TcondutorCollectionItem read GetItem write SetItem; default;
  end;

  TcondutorCollectionItem = class(TCollectionItem)
  private
    FxNome : string;
    FCPF   : string;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
  published
    property xNome: string read FxNome write FxNome;
    property CPF: string read FCPF write FCPF;
  end;

  TveicReboqueCollection = class(TCollection)
  private
    function GetItem(Index: Integer): TveicReboqueCollectionItem;
    procedure SetItem(Index: Integer; Value: TveicReboqueCollectionItem);
  public
    constructor Create(AOwner: TRodo);
    function Add: TveicReboqueCollectionItem;
    property Items[Index: Integer]: TveicReboqueCollectionItem read GetItem write SetItem; default;
  end;

  TveicReboqueCollectionItem = class(TCollectionItem)
  private
    FcInt: String;
    Fplaca: String;
    Ftara: Integer;
    FcapKG: Integer;
    FcapM3: Integer;
    FRNTRC: String;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
  published
    property cInt: String read FcInt write FcInt;
    property placa: String read Fplaca write Fplaca;
    property tara: Integer read Ftara write Ftara;
    property capKG: Integer read FcapKG write FcapKG;
    property capM3: Integer read FcapM3 write FcapM3;
    property RNTRC: String read FRNTRC write FRNTRC;
  end;

  TvalePed = class(TPersistent)
  private
    Fdisp : TdispCollection;
    procedure Setdisp(const Value: TdispCollection);
  public
    constructor Create(AOwner: TRodo);
    destructor Destroy; override;
  published
    property disp: TdispCollection read Fdisp write Setdisp;
  end;

  TdispCollection = class(TCollection)
  private
    function GetItem(Index: Integer): TdispCollectionItem;
    procedure SetItem(Index: Integer; Value: TdispCollectionItem);
  public
    constructor Create(AOwner: TvalePed);
    function Add: TdispCollectionItem;
    property Items[Index: Integer]: TdispCollectionItem read GetItem write SetItem; default;
  end;

  TdispCollectionItem = class(TCollectionItem)
  private
    FCNPJForn : String;
    FCNPJPg   : String;
    FnCompra  : String;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
  published
    property CNPJForn: String read FCNPJForn write FCNPJForn;
    property CNPJPg: String read FCNPJPg write FCNPJPg;
    property nCompra: String read FnCompra write FnCompra;
  end;

  Taereo = class(TPersistent)
  private
    Fnac     : Integer;
    Fmatr    : Integer;
    FnVoo    : String;
    FcAerEmb : String;
    FcAerDes : String;
    FdVoo    : tDateTime;
  published
    property nac: Integer read Fnac write Fnac;
    property matr: Integer read Fmatr write Fmatr;
    property nVoo: String read FnVoo write FnVoo;
    property cAerEmb: String read FcAerEmb write FcAerEmb;
    property cAerDes: String read FcAerDes write FcAerDes;
    property dVoo: TDateTime read FdVoo write FdVoo;
  end;

  Taquav = class(TPersistent)
  private
    FCNPJAgeNav: String;
    FtpEmb: String;
    FcEmbar: String;
    FnViagem: String;
    FcPrtEmb: String;
    FcPrtDest: String;
    FinfTermCarreg: TinfTermCarregCollection;
    FinfTermDescarreg: TinfTermDescarregCollection;
    FinfEmbComb: TinfEmbCombCollection;
    
    procedure SetinfTermCarreg(const Value: TinfTermCarregCollection);
    procedure SetinfTermDescarreg(const Value: TinfTermDescarregCollection);
    procedure SetinfEmbComb(const Value: TinfEmbCombCollection);
  public
    constructor Create(AOwner: TMDFe);
    destructor Destroy; override;
  published
    property CNPJAgeNav: String read FCNPJAgeNav write FCNPJAgeNav;
    property tpEmb: String read FtpEmb write FtpEmb;
    property cEmbar: String read FcEmbar write FcEmbar;
    property nViagem: String read FnViagem write FnViagem;
    property cPrtEmb: String read FcPrtEmb write FcPrtEmb;
    property cPrtDest: String read FcPrtDest write FcPrtDest;
    property infTermCarreg: TinfTermCarregCollection read FinfTermCarreg write SetinfTermCarreg;
    property infTermDescarreg: TinfTermDescarregCollection read FinfTermDescarreg write SetinfTermDescarreg;
    property infEmbComb: TinfEmbCombCollection read FinfEmbComb write SetinfEmbComb;
  end;

  TinfTermCarregCollection = class(TCollection)
  private
    function GetItem(Index: Integer): TinfTermCarregCollectionItem;
    procedure SetItem(Index: Integer; Value: TinfTermCarregCollectionItem);
  public
    constructor Create(AOwner: Taquav);
    function Add: TinfTermCarregCollectionItem;
    property Items[Index: Integer]: TinfTermCarregCollectionItem read GetItem write SetItem; default;
  end;

  TinfTermCarregCollectionItem = class(TCollectionItem)
  private
    FcTermCarreg: String;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
  published
    property cTermCarreg: String read FcTermCarreg write FcTermCarreg;
  end;

  TinfTermDescarregCollection = class(TCollection)
  private
    function GetItem(Index: Integer): TinfTermDescarregCollectionItem;
    procedure SetItem(Index: Integer; Value: TinfTermDescarregCollectionItem);
  public
    constructor Create(AOwner: Taquav);
    function Add: TinfTermDescarregCollectionItem;
    property Items[Index: Integer]: TinfTermDescarregCollectionItem read GetItem write SetItem; default;
  end;

  TinfTermDescarregCollectionItem = class(TCollectionItem)
  private
    FcTermDescarreg: String;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
  published
    property cTermDescarreg: String read FcTermDescarreg write FcTermDescarreg;
  end;

  TinfEmbCombCollection = class(TCollection)
  private
    function GetItem(Index: Integer): TinfEmbCombCollectionItem;
    procedure SetItem(Index: Integer; Value: TinfEmbCombCollectionItem);
  public
    constructor Create(AOwner: Taquav);
    function Add: TinfEmbCombCollectionItem;
    property Items[Index: Integer]: TinfEmbCombCollectionItem read GetItem write SetItem; default;
  end;

  TinfEmbCombCollectionItem = class(TCollectionItem)
  private
    FcEmbComb: String;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
  published
    property cEmbComb: String read FcEmbComb write FcEmbComb;
  end;

  Tferrov = class(TPersistent)
  private
    FxPref: String;
    FdhTrem: TDateTime;
    FxOri: String;
    FxDest: String;
    FqVag: Integer;
    Fvag: TvagCollection;

    procedure Setvag(const Value: TvagCollection);
  public
    constructor Create(AOwner: TMDFe);
    destructor Destroy; override;
  published
    property xPref: String read FxPref write FxPref;
    property dhTrem: TDateTime read FdhTrem write FdhTrem;
    property xOri: String read FxOri write FxOri;
    property xDest: String read FxDest write FxDest;
    property qVag: Integer read FqVag write FqVag;
    property vag: TvagCollection read Fvag write Setvag;
  end;

  TvagCollection = class(TCollection)
  private
    function GetItem(Index: Integer): TvagCollectionItem;
    procedure SetItem(Index: Integer; Value: TvagCollectionItem);
  public
    constructor Create(AOwner: Tferrov);
    function Add: TvagCollectionItem;
    property Items[Index: Integer]: TvagCollectionItem read GetItem write SetItem; default;
  end;

  TvagCollectionItem = class(TCollectionItem)
  private
    Fserie: integer;
    FnVag: integer;
    FnSeq: integer;
    FTU: integer;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
  published
    property serie: integer read Fserie write Fserie;
    property nVag: integer read FnVag write FnVag;
    property nSeq: integer read FnSeq write FnSeq;
    property TU: integer read FTU write FTU;
  end;

  TinfDoc = class(TPersistent)
  private
    FinfMunDescarga : TinfMunDescargaCollection;

    procedure SetinfMunDescarga(const Value: TinfMunDescargaCollection);
  public
    constructor Create(AOwner: TMDFe);
    destructor Destroy; override;
  published
    property infMunDescarga: TinfMunDescargaCollection read FinfMunDescarga write SetinfMunDescarga;
  end;

  TinfMunDescargaCollection = class(TCollection)
  private
    function GetItem(Index: Integer): TinfMunDescargaCollectionItem;
    procedure SetItem(Index: Integer; Value: TinfMunDescargaCollectionItem);
  public
    constructor Create(AOwner: TinfDoc);
    function Add: TinfMunDescargaCollectionItem;
    property Items[Index: Integer]: TinfMunDescargaCollectionItem read GetItem write SetItem; default;
  end;

  TinfMunDescargaCollectionItem = class(TCollectionItem)
  private
    FcMunDescarga: integer;
    FxMunDescarga: String;
    FinfCTe: TinfCTeCollection;
    FinfCT: TinfCTCollection;
    FinfNFe: TinfNFeCollection;
    FinfNF: TinfNFCollection;

    procedure SetinfCTe(const Value: TinfCTeCollection);
    procedure SetinfCT(const Value: TinfCTCollection);
    procedure SetinfNFe(const Value: TinfNFeCollection);
    procedure SetinfNF(const Value: TinfNFCollection);
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
  published
    property cMunDescarga: integer read FcMunDescarga write FcMunDescarga;
    property xMunDescarga: String read FxMunDescarga write FxMunDescarga;
    property infCTe: TinfCTeCollection read FinfCTe write SetinfCTe;
    property infCT: TinfCTCollection read FinfCT write SetinfCT;
    property infNFe: TinfNFeCollection read FinfNFe write SetinfNFe;
    property infNF: TinfNFCollection read FinfNF write SetinfNF;
  end;

  TinfCTeCollection = class(TCollection)
  private
    function GetItem(Index: Integer): TinfCTeCollectionItem;
    procedure SetItem(Index: Integer; Value: TinfCTeCollectionItem);
  public
    constructor Create(AOwner: TinfMunDescargaCollectionItem);
    function Add: TinfCTeCollectionItem;
    property Items[Index: Integer]: TinfCTeCollectionItem read GetItem write SetItem; default;
  end;

  TinfCTeCollectionItem = class(TCollectionItem)
  private
    FchCTe: String;
    FSegCodBarra: String;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
  published
    property chCTe: String read FchCTe write FchCTe;
    property SegCodBarra: String read FSegCodBarra write FSegCodBarra;
  end;

  TinfCTCollection = class(TCollection)
  private
    function GetItem(Index: Integer): TinfCTCollectionItem;
    procedure SetItem(Index: Integer; Value: TinfCTCollectionItem);
  public
    constructor Create(AOwner: TinfMunDescargaCollectionItem);
    function Add: TinfCTCollectionItem;
    property Items[Index: Integer]: TinfCTCollectionItem read GetItem write SetItem; default;
  end;

  TinfCTCollectionItem = class(TCollectionItem)
  private
    FnCT: String;
    Fserie: integer;
    Fsubser: integer;
    FdEmi: TDateTime;
    FvCarga: Double;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
  published
    property nCT: String read FnCT write FnCT;
    property serie: integer read Fserie write Fserie;
    property subser: integer read Fsubser write Fsubser;
    property dEmi: TDateTime read FdEmi write FdEmi;
    property vCarga: Double read FvCarga write FvCarga;
  end;

  TinfNFeCollection = class(TCollection)
  private
    function GetItem(Index: Integer): TinfNFeCollectionItem;
    procedure SetItem(Index: Integer; Value: TinfNFeCollectionItem);
  public
    constructor Create(AOwner: TinfMunDescargaCollectionItem);
    function Add: TinfNFeCollectionItem;
    property Items[Index: Integer]: TinfNFeCollectionItem read GetItem write SetItem; default;
  end;

  TinfNFeCollectionItem = class(TCollectionItem)
  private
    FchNFe: String;
    FSegCodBarra: String;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
  published
    property chNFe: String read FchNFe write FchNFe;
    property SegCodBarra: String read FSegCodBarra write FSegCodBarra;
  end;

  TinfNFCollection = class(TCollection)
  private
    function GetItem(Index: Integer): TinfNFCollectionItem;
    procedure SetItem(Index: Integer; Value: TinfNFCollectionItem);
  public
    constructor Create(AOwner: TinfMunDescargaCollectionItem);
    function Add: TinfNFCollectionItem;
    property Items[Index: Integer]: TinfNFCollectionItem read GetItem write SetItem; default;
  end;

  TinfNFCollectionItem = class(TCollectionItem)
  private
    FCNPJ: String;
    FUF: String;
    FnNF: integer;
    Fserie: integer;
    FdEmi: TDateTime;
    FvNF: Double;
    FPIN: integer;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
  published
    property CNPJ: String read FCNPJ write FCNPJ;
    property UF: String read FUF write FUF;
    property nNF: integer read FnNF write FnNF;
    property serie: integer read Fserie write Fserie;
    property dEmi: TDateTime read FdEmi write FdEmi;
    property vNF: Double read FvNF write FvNF;
    property PIN: integer read FPIN write FPIN;
  end;

  Ttot = class(TPersistent)
  private
    FqCTe: Integer;
    FqCT: Integer;
    FqNFe: Integer;
    FqNF: Integer;
    FvCarga: Double;
    FcUnid: UnidMed;
    FqCarga: Double;
  published
    property qCTe: Integer read FqCTe write FqCTe;
    property qCT: Integer read FqCT write FqCT;
    property qNFe: Integer read FqNFe write FqNFe;
    property qNF: Integer read FqNF write FqNF;
    property vCarga: Double read FvCarga write FvCarga;
    property cUnid: UnidMed read FcUnid write FcUnid;
    property qCarga: Double read FqCarga write FqCarga;
  end;

  TlacresCollection = class(TCollection)
  private
    function GetItem(Index: Integer): TlacresCollectionItem;
    procedure SetItem(Index: Integer; Value: TlacresCollectionItem);
  public
    constructor Create(AOwner: TMDFe);
    function Add: TlacresCollectionItem;
    property Items[Index: Integer]: TlacresCollectionItem read GetItem write SetItem; default;
  end;

  TlacresCollectionItem = class(TCollectionItem)
  private
    FnLacre: String;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
  published
    property nLacre: String read FnLacre write FnLacre;
  end;

  TinfAdic = class(TPersistent)
  private
    FinfAdFisco: String;
    FinfCpl: String;
  published
    property infAdFisco: String read FinfAdFisco write FinfAdFisco;
    property infCpl: String read FinfCpl write FinfCpl;
  end;

  TMDFe = class(TPersistent)
  private
    Fschema: TpcnSchema;
    FinfMDFe: TinfMDFe;
    FIde: TIde;
    Femit: Temit;

    Frodo: Trodo;
    Faereo: Taereo;
    Faquav: Taquav;
    Fferrov: Tferrov;

    FinfDoc: TinfDoc;
    Ftot: Ttot;
    Flacres: TlacresCollection;
    FinfAdic: TinfAdic;

    FProcMDFe: TProcMDFe;
    FSignature: TSignature;

    procedure Setlacres(const Value: TlacresCollection);
  public
    constructor Create;
    destructor Destroy; override;
  published
    property schema: TpcnSchema read Fschema write Fschema;
    property infMDFe: TinfMDFe read FinfMDFe write FinfMDFe;
    property Ide: TIde read FIde write FIde;
    property emit: Temit read Femit write Femit;

    property rodo: Trodo read Frodo write Frodo;
    property aereo: Taereo read Faereo write Faereo;
    property aquav: Taquav read Faquav write Faquav;
    property ferrov: Tferrov read Fferrov write Fferrov;

    property infDoc: TinfDoc read FinfDoc write FinfDoc;
    property tot: Ttot read Ftot write Ftot;
    property lacres: TlacresCollection read Flacres write Setlacres;
    property infAdic: TinfAdic read FinfAdic write FinfAdic;

    property procMDFe: TProcMDFe read FProcMDFe write FProcMDFe;
    property signature: Tsignature read Fsignature write Fsignature;
  end;

const
  CMUN_EXTERIOR: integer = 9999999;
  XMUN_EXTERIOR: string = 'EXTERIOR';
  UF_EXTERIOR: string = 'EX';

implementation

{ TMDFe }

constructor TMDFe.Create;
begin
  FinfMDFe   := TInfMDFe.Create;
  Fide       := Tide.Create(Self);
  Femit      := Temit.Create(Self);

  Frodo      := Trodo.Create(Self);
  Faereo     := Taereo.Create;
  Faquav     := Taquav.Create(Self);
  Fferrov    := Tferrov.Create(Self);

  FinfDoc    := TinfDoc.Create(Self);
  Ftot       := Ttot.Create;
  Flacres    := TlacresCollection.Create(Self);
  FinfAdic   := TinfAdic.Create;

  FProcMDFe  := TProcMDFe.create;
  Fsignature := Tsignature.create;
end;

destructor TMDFe.Destroy;
begin
  FinfMDFe.Free;
  Fide.Free;
  Femit.Free;
  Frodo.Free;
  Faereo.Free;
  Faquav.Free;
  Fferrov.Free;
  FinfDoc.Free;
  Ftot.Free;
  Flacres.Free;
  FinfAdic.Free;

  FProcMDFe.Free;
  Fsignature.Free;
  inherited;
end;

procedure TMDFe.Setlacres(const Value: TlacresCollection);
begin
  Flacres.Assign(Value);
end;

{ TinfMunCarregaCollection }

function TinfMunCarregaCollection.Add: TinfMunCarregaCollectionItem;
begin
  Result := TinfMunCarregaCollectionItem(inherited Add);
  Result.create;
end;

constructor TinfMunCarregaCollection.Create(AOwner: Tide);
begin
  inherited Create(TinfMunCarregaCollectionItem);
end;

function TinfMunCarregaCollection.GetItem(Index: Integer): TinfMunCarregaCollectionItem;
begin
  Result := TinfMunCarregaCollectionItem(inherited GetItem(Index));
end;

procedure TinfMunCarregaCollection.SetItem(Index: Integer; Value: TinfMunCarregaCollectionItem);
begin
  inherited SetItem(Index, Value);
end;

{ TinfMunCarregaCollectionItem }

constructor TinfMunCarregaCollectionItem.Create;
begin

end;

destructor TinfMunCarregaCollectionItem.Destroy;
begin

  inherited;
end;

{ TIde }

constructor TIde.Create(AOwner: TMDFe);
begin
  inherited Create;
  FinfMunCarrega := TinfMunCarregaCollection.Create(Self);
  FinfPercurso   := TinfPercursoCollection.Create(Self);
end;

destructor TIde.Destroy;
begin
  FinfMunCarrega.Free;
  FinfPercurso.Free;
  inherited;
end;

procedure TIde.SetinfMunCarrega(Value: TinfMunCarregaCollection);
begin
  FinfMunCarrega.Assign(Value);
end;

procedure TIde.SetinfPercurso(Value: TinfPercursoCollection);
begin
  FinfPercurso.Assign(Value);
end;

{ TinfPercursoCollection }

function TinfPercursoCollection.Add: TinfPercursoCollectionItem;
begin
  Result := TinfPercursoCollectionItem(inherited Add);
  Result.create;
end;

constructor TinfPercursoCollection.Create(AOwner: Tide);
begin
  inherited Create(TinfPercursoCollectionItem);
end;

function TinfPercursoCollection.GetItem(
  Index: Integer): TinfPercursoCollectionItem;
begin
  Result := TinfPercursoCollectionItem(inherited GetItem(Index));
end;

procedure TinfPercursoCollection.SetItem(Index: Integer;
  Value: TinfPercursoCollectionItem);
begin
  inherited SetItem(Index, Value);
end;

{ TinfPercursoCollectionItem }

constructor TinfPercursoCollectionItem.Create;
begin

end;

destructor TinfPercursoCollectionItem.Destroy;
begin

  inherited;
end;

{ Temit }

constructor Temit.Create(AOwner: TMDFe);
begin
  inherited Create;
  FenderEmit := TenderEmit.Create;
end;

destructor Temit.Destroy;
begin
  FenderEmit.Free;
  inherited;
end;

{ TRodo }

constructor TRodo.Create(AOwner: TMDFe);
begin
  inherited Create;
  FveicPrincipal := TveicPrincipal.Create;
  FveicReboque   := TveicReboqueCollection.Create(Self);
  FvalePed       := TvalePed.Create(Self);
end;

destructor TRodo.Destroy;
begin
  FveicPrincipal.Free;
  FveicReboque.Free;
  FvalePed.Free;
  inherited;
end;

procedure TRodo.SetveicReboque(const Value: TveicReboqueCollection);
begin
  FveicReboque.Assign(Value);
end;

{ TveicPrincipal }

constructor TveicPrincipal.Create;
begin
  inherited Create;
  Fcondutor := TcondutorCollection.Create(Self);
end;

destructor TveicPrincipal.Destroy;
begin
  Fcondutor.Free;
  inherited;
end;

procedure TveicPrincipal.Setcondutor(const Value: TcondutorCollection);
begin
  Fcondutor.Assign(Value);
end;

{ TcondutorCollection }

function TcondutorCollection.Add: TcondutorCollectionItem;
begin
  Result := TcondutorCollectionItem(inherited Add);
  Result.create;
end;

constructor TcondutorCollection.Create(AOwner: TveicPrincipal);
begin
  inherited Create(TcondutorCollectionItem);
end;

function TcondutorCollection.GetItem(
  Index: Integer): TcondutorCollectionItem;
begin
  Result := TcondutorCollectionItem(inherited GetItem(Index));
end;

procedure TcondutorCollection.SetItem(Index: Integer;
  Value: TcondutorCollectionItem);
begin
  inherited SetItem(Index, Value);
end;

{ TcondutorCollectionItem }

constructor TcondutorCollectionItem.Create;
begin

end;

destructor TcondutorCollectionItem.Destroy;
begin

  inherited;
end;

{ TveicReboqueCollection }

function TveicReboqueCollection.Add: TveicReboqueCollectionItem;
begin
  Result := TveicReboqueCollectionItem(inherited Add);
  Result.create;
end;

constructor TveicReboqueCollection.Create(AOwner: TRodo);
begin
  inherited Create(TveicReboqueCollectionItem);
end;

function TveicReboqueCollection.GetItem(
  Index: Integer): TveicReboqueCollectionItem;
begin
  Result := TveicReboqueCollectionItem(inherited GetItem(Index));
end;

procedure TveicReboqueCollection.SetItem(Index: Integer;
  Value: TveicReboqueCollectionItem);
begin
  inherited SetItem(Index, Value);
end;

{ TveicReboqueCollectionItem }

constructor TveicReboqueCollectionItem.Create;
begin

end;

destructor TveicReboqueCollectionItem.Destroy;
begin

  inherited;
end;

{ TvalePed }

constructor TvalePed.Create(AOwner: TRodo);
begin
  inherited Create;
  Fdisp := TdispCollection.Create(Self);
end;

destructor TvalePed.Destroy;
begin
  Fdisp.Free;
  inherited;
end;

procedure TvalePed.Setdisp(const Value: TdispCollection);
begin
  Fdisp.Assign(Value);
end;

{ TdispCollection }

function TdispCollection.Add: TdispCollectionItem;
begin
  Result := TdispCollectionItem(inherited Add);
  Result.create;
end;

constructor TdispCollection.Create(AOwner: TvalePed);
begin
  inherited Create(TdispCollectionItem);
end;

function TdispCollection.GetItem(Index: Integer): TdispCollectionItem;
begin
  Result := TdispCollectionItem(inherited GetItem(Index));
end;

procedure TdispCollection.SetItem(Index: Integer;
  Value: TdispCollectionItem);
begin
  inherited SetItem(Index, Value);
end;

{ TdispCollectionItem }

constructor TdispCollectionItem.Create;
begin

end;

destructor TdispCollectionItem.Destroy;
begin

  inherited;
end;

{ Tferrov }

constructor Tferrov.Create(AOwner: TMDFe);
begin
  inherited Create;
  Fvag := TvagCollection.Create(Self);
end;

destructor Tferrov.Destroy;
begin
  Fvag.Free;
  inherited;
end;

procedure Tferrov.Setvag(const Value: TvagCollection);
begin
  Fvag.Assign(Value);
end;

{ TvagCollection }

function TvagCollection.Add: TvagCollectionItem;
begin
  Result := TvagCollectionItem(inherited Add);
  Result.create;
end;

constructor TvagCollection.Create(AOwner: Tferrov);
begin
  inherited Create(TvagCollectionItem);
end;

function TvagCollection.GetItem(Index: Integer): TvagCollectionItem;
begin
  Result := TvagCollectionItem(inherited GetItem(Index));
end;

procedure TvagCollection.SetItem(Index: Integer;
  Value: TvagCollectionItem);
begin
  inherited SetItem(Index, Value);
end;

{ TvagCollectionItem }

constructor TvagCollectionItem.Create;
begin

end;

destructor TvagCollectionItem.Destroy;
begin

  inherited;
end;

{ TinfDoc }

constructor TinfDoc.Create(AOwner: TMDFe);
begin
  inherited Create;
  FinfMunDescarga := TinfMunDescargaCollection.Create(Self);
end;

destructor TinfDoc.Destroy;
begin
  FinfMunDescarga.Free;
  inherited;
end;

procedure TinfDoc.SetinfMunDescarga(
  const Value: TinfMunDescargaCollection);
begin
  FinfMunDescarga.Assign(Value);
end;

{ TinfMunDescargaCollection }

function TinfMunDescargaCollection.Add: TinfMunDescargaCollectionItem;
begin
  Result := TinfMunDescargaCollectionItem(inherited Add);
  Result.create;
end;

constructor TinfMunDescargaCollection.Create(AOwner: TinfDoc);
begin
  inherited Create(TinfMunDescargaCollectionItem);
end;

function TinfMunDescargaCollection.GetItem(
  Index: Integer): TinfMunDescargaCollectionItem;
begin
  Result := TinfMunDescargaCollectionItem(inherited GetItem(Index));
end;

procedure TinfMunDescargaCollection.SetItem(Index: Integer;
  Value: TinfMunDescargaCollectionItem);
begin
  inherited SetItem(Index, Value);
end;

{ TinfMunDescargaCollectionItem }

constructor TinfMunDescargaCollectionItem.Create;
begin
//  inherited Create;
  FinfCTe := TinfCTeCollection.Create(Self);
  FinfCT := TinfCTCollection.Create(Self);
  FinfNFe := TinfNFeCollection.Create(Self);
  FinfNF := TinfNFCollection.Create(Self);
end;

destructor TinfMunDescargaCollectionItem.Destroy;
begin
  FinfCTe.Free;
  FinfCT.Free;
  FinfNFe.Free;
  FinfNF.Free;
  inherited;
end;

procedure TinfMunDescargaCollectionItem.SetinfCTe(
  const Value: TinfCTeCollection);
begin
  FinfCTe.Assign(Value);
end;

procedure TinfMunDescargaCollectionItem.SetinfCT(
  const Value: TinfCTCollection);
begin
  FinfCT.Assign(Value);
end;

procedure TinfMunDescargaCollectionItem.SetinfNFe(
  const Value: TinfNFeCollection);
begin
  FinfNFe.Assign(Value);
end;

procedure TinfMunDescargaCollectionItem.SetinfNF(
  const Value: TinfNFCollection);
begin
  FinfNF.Assign(Value);
end;

{ TinfCTeCollection }

function TinfCTeCollection.Add: TinfCTeCollectionItem;
begin
  Result := TinfCTeCollectionItem(inherited Add);
  Result.create;
end;

constructor TinfCTeCollection.Create(
  AOwner: TinfMunDescargaCollectionItem);
begin
  inherited Create(TinfCTeCollectionItem);
end;

function TinfCTeCollection.GetItem(Index: Integer): TinfCTeCollectionItem;
begin
  Result := TinfCTeCollectionItem(inherited GetItem(Index));
end;

procedure TinfCTeCollection.SetItem(Index: Integer;
  Value: TinfCTeCollectionItem);
begin
  inherited SetItem(Index, Value);
end;

{ TinfCTeCollectionItem }

constructor TinfCTeCollectionItem.Create;
begin

end;

destructor TinfCTeCollectionItem.Destroy;
begin

  inherited;
end;

{ TinfCTCollection }

function TinfCTCollection.Add: TinfCTCollectionItem;
begin
  Result := TinfCTCollectionItem(inherited Add);
  Result.create;
end;

constructor TinfCTCollection.Create(AOwner: TinfMunDescargaCollectionItem);
begin
  inherited Create(TinfCTCollectionItem);
end;

function TinfCTCollection.GetItem(Index: Integer): TinfCTCollectionItem;
begin
  Result := TinfCTCollectionItem(inherited GetItem(Index));
end;

procedure TinfCTCollection.SetItem(Index: Integer;
  Value: TinfCTCollectionItem);
begin
  inherited SetItem(Index, Value);
end;

{ TinfCTCollectionItem }

constructor TinfCTCollectionItem.Create;
begin

end;

destructor TinfCTCollectionItem.Destroy;
begin

  inherited;
end;

{ TinfNFeCollection }

function TinfNFeCollection.Add: TinfNFeCollectionItem;
begin
  Result := TinfNFeCollectionItem(inherited Add);
  Result.create;
end;

constructor TinfNFeCollection.Create(
  AOwner: TinfMunDescargaCollectionItem);
begin
  inherited Create(TinfNFeCollectionItem);
end;

function TinfNFeCollection.GetItem(Index: Integer): TinfNFeCollectionItem;
begin
  Result := TinfNFeCollectionItem(inherited GetItem(Index));
end;

procedure TinfNFeCollection.SetItem(Index: Integer;
  Value: TinfNFeCollectionItem);
begin
  inherited SetItem(Index, Value);
end;

{ TinfNFeCollectionItem }

constructor TinfNFeCollectionItem.Create;
begin

end;

destructor TinfNFeCollectionItem.Destroy;
begin

  inherited;
end;

{ TinfNFCollection }

function TinfNFCollection.Add: TinfNFCollectionItem;
begin
  Result := TinfNFCollectionItem(inherited Add);
  Result.create;
end;

constructor TinfNFCollection.Create(AOwner: TinfMunDescargaCollectionItem);
begin
  inherited Create(TinfNFCollectionItem);
end;

function TinfNFCollection.GetItem(Index: Integer): TinfNFCollectionItem;
begin
  Result := TinfNFCollectionItem(inherited GetItem(Index));
end;

procedure TinfNFCollection.SetItem(Index: Integer;
  Value: TinfNFCollectionItem);
begin
  inherited SetItem(Index, Value);
end;

{ TinfNFCollectionItem }

constructor TinfNFCollectionItem.Create;
begin

end;

destructor TinfNFCollectionItem.Destroy;
begin

  inherited;
end;

{ TlacresCollection }

function TlacresCollection.Add: TlacresCollectionItem;
begin
  Result := TlacresCollectionItem(inherited Add);
  Result.create;
end;

constructor TlacresCollection.Create(AOwner: TMDFe);
begin
  inherited Create(TlacresCollectionItem);
end;

function TlacresCollection.GetItem(Index: Integer): TlacresCollectionItem;
begin
  Result := TlacresCollectionItem(inherited GetItem(Index));
end;

procedure TlacresCollection.SetItem(Index: Integer;
  Value: TlacresCollectionItem);
begin
  inherited SetItem(Index, Value);
end;

{ TlacresCollectionItem }

constructor TlacresCollectionItem.Create;
begin

end;

destructor TlacresCollectionItem.Destroy;
begin

  inherited;
end;

{ TinfTermCarregCollection }

function TinfTermCarregCollection.Add: TinfTermCarregCollectionItem;
begin
  Result := TinfTermCarregCollectionItem(inherited Add);
  Result.create;
end;

constructor TinfTermCarregCollection.Create(AOwner: Taquav);
begin
  inherited Create(TinfTermCarregCollectionItem);
end;

function TinfTermCarregCollection.GetItem(
  Index: Integer): TinfTermCarregCollectionItem;
begin
  Result := TinfTermCarregCollectionItem(inherited GetItem(Index));
end;

procedure TinfTermCarregCollection.SetItem(Index: Integer;
  Value: TinfTermCarregCollectionItem);
begin
  inherited SetItem(Index, Value);
end;

{ TinfTermCarregCollectionItem }

constructor TinfTermCarregCollectionItem.Create;
begin

end;

destructor TinfTermCarregCollectionItem.Destroy;
begin

  inherited;
end;

{ Taquav }

constructor Taquav.Create(AOwner: TMDFe);
begin
  inherited Create;
  FinfTermCarreg := TinfTermCarregCollection.Create(Self);
  FinfTermDescarreg := TinfTermDescarregCollection.Create(Self);
  FinfEmbComb := TinfEmbCombCollection.Create(Self);
end;

destructor Taquav.Destroy;
begin
  FinfTermCarreg.Free;
  FinfTermDescarreg.Free;
  FinfEmbComb.Free;
  inherited;
end;

procedure Taquav.SetinfEmbComb(const Value: TinfEmbCombCollection);
begin
  FinfEmbComb := Value;
end;

procedure Taquav.SetinfTermCarreg(const Value: TinfTermCarregCollection);
begin
  FinfTermCarreg := Value;
end;

procedure Taquav.SetinfTermDescarreg(const Value: TinfTermDescarregCollection);
begin
  FinfTermDescarreg := Value;
end;

{ TinfTermDescarregCollection }

function TinfTermDescarregCollection.Add: TinfTermDescarregCollectionItem;
begin
  Result := TinfTermDescarregCollectionItem(inherited Add);
  Result.create;
end;

constructor TinfTermDescarregCollection.Create(AOwner: Taquav);
begin
  inherited Create(TinfTermDescarregCollectionItem);
end;

function TinfTermDescarregCollection.GetItem(
  Index: Integer): TinfTermDescarregCollectionItem;
begin
  Result := TinfTermDescarregCollectionItem(inherited GetItem(Index));
end;

procedure TinfTermDescarregCollection.SetItem(Index: Integer;
  Value: TinfTermDescarregCollectionItem);
begin
  inherited SetItem(Index, Value);
end;

{ TinfTermDescarregCollectionItem }

constructor TinfTermDescarregCollectionItem.Create;
begin

end;

destructor TinfTermDescarregCollectionItem.Destroy;
begin

  inherited;
end;

{ TinfEmbCombCollection }

function TinfEmbCombCollection.Add: TinfEmbCombCollectionItem;
begin
  Result := TinfEmbCombCollectionItem(inherited Add);
  Result.create;
end;

constructor TinfEmbCombCollection.Create(AOwner: Taquav);
begin
  inherited Create(TinfEmbCombCollectionItem);
end;

function TinfEmbCombCollection.GetItem(
  Index: Integer): TinfEmbCombCollectionItem;
begin
  Result := TinfEmbCombCollectionItem(inherited GetItem(Index));
end;

procedure TinfEmbCombCollection.SetItem(Index: Integer;
  Value: TinfEmbCombCollectionItem);
begin
  inherited SetItem(Index, Value);
end;

{ TinfEmbCombCollectionItem }

constructor TinfEmbCombCollectionItem.Create;
begin

end;

destructor TinfEmbCombCollectionItem.Destroy;
begin

  inherited;
end;

end.

