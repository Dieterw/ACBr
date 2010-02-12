////////////////////////////////////////////////////////////////////////////////
//                                                                            //
//              PCN - Projeto Cooperar CTe                                    //
//                                                                            //
//   Descrição: Classes para geração/leitura dos arquivos xml da NFe          //
//                                                                            //
//        site: www.projetocooperar.org/nfe                                   //
//       email: projetocooperar@zipmail.com.br                                //
//       forum: http://br.groups.yahoo.com/group/projeto_cooperar_nfe/        //
//     projeto: http://code.google.com/p/projetocooperar/                     //
//         svn: http://projetocooperar.googlecode.com/svn/trunk/              //
//                                                                            //
// Coordenação: (c) 2009 - Paulo Casagrande                                   //
//                                                                            //
//      Equipe: Vide o arquivo leiame.txt na pasta raiz do projeto            //
//                                                                            //
// Desenvolvimento                                                            //
//         de Cte: Wiliam Zacarias da Silva Rosa                              //
//                                                                            //
//      Versão: Vide o arquivo leiame.txt na pasta raiz do projeto            //
//                                                                            //
//     Licença: GNU Lesser General Public License (GNU LGPL)                  //
//                                                                            //
//              - Este programa é software livre; você pode redistribuí-lo    //
//              e/ou modificá-lo sob os termos da Licença Pública Geral GNU,  //
//              conforme publicada pela Free Software Foundation; tanto a     //
//              versão 2 da Licença como (a seu critério) qualquer versão     //
//              mais nova.                                                    //
//                                                                            //
//              - Este programa é distribuído na expectativa de ser útil,     //
//              mas SEM QUALQUER GARANTIA; sem mesmo a garantia implícita de  //
//              COMERCIALIZAÇÃO ou de ADEQUAÇÃO A QUALQUER PROPÓSITO EM       //
//              PARTICULAR. Consulte a Licença Pública Geral GNU para obter   //
//              mais detalhes. Você deve ter recebido uma cópia da Licença    //
//              Pública Geral GNU junto com este programa; se não, escreva    //
//              para a Free Software Foundation, Inc., 59 Temple Place,       //
//              Suite 330, Boston, MA - 02111-1307, USA ou consulte a         //
//              licença oficial em http://www.gnu.org/licenses/gpl.txt        //
//                                                                            //
//    Nota (1): - Esta  licença  não  concede  o  direito  de  uso  do nome   //
//              "PCN  -  Projeto  Cooperar  NFe", não  podendo o mesmo ser    //
//              utilizado sem previa autorização.                             //
//                                                                            //
//    Nota (2): - O uso integral (ou parcial) das units do projeto esta       //
//              condicionado a manutenção deste cabeçalho junto ao código     //
//                                                                            //
////////////////////////////////////////////////////////////////////////////////

unit pcteCTe;

interface uses

  SysUtils, Classes,
{$IFNDEF VER130}
  Variants,
{$ENDIF}
  pcnConversao, pcteProcCTe, pcnSignature;

type
  TCTe = class;
  TInfCTe = class;
  TIde = class;
  TToma03 = class;
  TToma4 = class;
  TEnderToma = class;
  TCompl = class;
  TEmit = class;
  TEnderEmit = class;
  TRem = class;
  TEnderReme = class;
  TInfNFCollection = class;
  TInfNFCollectionItem = class;
  TInfNFECollection = class;
  TInfNFECollectionItem = class;
  TInfOutrosCollection  = class;
  TInfOutrosCollectionItem = class;
  TExped = class;
  TEnderExped = class;
  TReceb = class;
  TEnderReceb = class;
  TDest = class;
  TEnderDest = class;
  TvPrest = class;
  TCompCollection = class;
  TImp = class;
  TICMS = class;
  TCST00 = class;
  TCST20 = class;
  TCST45 = class;
  TCST80 = class;
  TCST81 = class;
  TCST90 = class;
  TInfSegCollection = class;
  TInfSegCollectionItem = class;
  TInfCarga = class;
  TInfQCollection = class;
  TInfQCollectionItem = class;
  TRodo = class;
  TMoto = class;
  TEmiOCC = class;
  TLacresCollection = class;
  TLacresCollectionItem = class;
  Tprop = class;
  TInfCteAnuEnt = class;
  TinfCteComp = class;
  TvPresComp = class;

  TCTe = class(TPersistent)
  private
    FSchema     : TpcnSchema;
    FinfCTe     : TinfCTe;
    FIde        : TIde;
    FCompl      : TCompl;
    FEmit       : TEmit;
    FRem        : TRem;
    FExped      : TExped;
    FReceb      : TReceb;
    FDest       : TDest;
    FvPrest     : TvPrest;
    FImp        : TImp;
    FInfCarga   : TInfCarga;
    FInfSeg     : TInfSegCollection;
    FRodo       : TRodo;
    FinfCteComp : TinfCteComp;
    FInfCteAnuEnt : TInfCteAnuEnt;
    FProcCTe: TProcCTe;
    FSignature: TSignature;
    procedure SetInfSeg(Value: TInfSegCollection);
  public
    constructor Create;
    destructor Destroy; override;
  published
    property schema: TpcnSchema read Fschema write Fschema;
    property infCTe: TinfCTe read FinfCTe write FinfCTe;
    property Ide: TIde read FIde write FIde;
    property Compl: TCompl read FCompl write FCompl;
    property Emit: TEmit read FEmit write FEmit;
    property Rem: TRem read FRem write FRem;
    property Exped: TExped read FExped write FExped;
    property Receb: TReceb read FReceb write FReceb;
    property Dest: TDest read FDest write FDest;
    property vPrest: TvPrest read FvPrest write FvPrest;
    property Imp: TImp read FImp write FImp;
    property InfCarga: TInfCarga read FInfCarga write FInfCarga;
    property InfSeg: TInfSegCollection read FInfSeg write SetInfSeg;
    property Rodo: TRodo read FRodo write FRodo;
    property InfCteAnuEnt: TInfCteAnuEnt read FInfCteAnuEnt write FInfCteAnuEnt;
    property infCteComp: TinfCteComp read FinfCteComp write FinfCteComp;
    property procCTe: TProcCTe read FProcCTe write FProcCTe;
    property signature: Tsignature read Fsignature write Fsignature;
  end;

  TinfCTe = class(TPersistent)
  private
    FID: string;
  published
    property ID: string read FID write FID;
  end;

  TIde = class(TPersistent)
  private
    FcUF: integer;
    FcCT: integer;
    FCFOP: integer;
    FnatOp : String;
    FforPag : TpcteFormaPagamento;
    Fmod: String;
    Fserie: integer;
    FnCT: integer;
    FdhEmi: TDateTime;
    FtpImp: TpcnTipoImpressao;
    FtpEmis: TpcnTipoEmissao;
    FcDV: integer;
    FtpAmb: TpcnTipoAmbiente;
    FtpCTe: TpcteTipoCTe;
    FprocEmi: TpcnProcessoEmissao;
    FverProc: String;
    FrefCTE: String;
    FcMunEmi: integer;
    FxMunEmi: String;
    FUFEmi: String;
    Fmodal: TpcteModal;
    FtpServ: TpcteTipoServico;
    FcMunIni: integer;
    FxMunIni: String;
    FUFIni: String;
    FcMunFim: integer;
    FxMunFim: String;
    FUFFim: String;
    Fretira: TpcteRetira;
    Fxdetretira: String;
    FToma03: TToma03;
    FToma4: TToma4;
  public
    constructor Create(AOwner: TCTe);
    destructor Destroy; override;
  published
    property cUF: integer read FcUF write FcUF;
    property cCT: integer read FcCT write FcCT;
    property CFOP: integer read FCFOP write FCFOP;
    property natOp : String read FnatOp write FnatOp;
    property forPag : TpcteFormaPagamento read FforPag write FforPag;
    property modelo: String read Fmod write Fmod;
    property serie: integer read Fserie write Fserie;
    property nCT: integer read FnCT write FnCT;
    property dhEmi: TDateTime read FdhEmi write FdhEmi;
    property tpImp: TpcnTipoImpressao read FtpImp write FtpImp;
    property tpEmis: TpcnTipoEmissao read FtpEmis write FtpEmis;
    property cDV: integer read FcDV write FcDV;
    property tpAmb: TpcnTipoAmbiente read FtpAmb write FtpAmb;
    property tpCTe: TpcteTipoCTe read FtpCTe write FtpCTe;
    property procEmi: TpcnProcessoEmissao read FprocEmi write FprocEmi;
    property verProc: String read FverProc write FverProc;
    property refCTE: String read FrefCTE write FrefCTE;
    property cMunEmi: integer read FcMunEmi write FcMunEmi;
    property xMunEmi: String read FxMunEmi write FxMunEmi;
    property UFEmi: String read FUFEmi write FUFEmi;
    property modal: TpcteModal read Fmodal write Fmodal;
    property tpServ: TpcteTipoServico read FtpServ write FtpServ;
    property cMunIni: integer read FcMunIni write FcMunIni;
    property xMunIni: String read FxMunIni write FxMunIni;
    property UFIni: String read FUFIni write FUFIni;
    property cMunFim: integer read FcMunFim write FcMunFim;
    property xMunFim: String read FxMunFim write FxMunFim;
    property UFFim: String read FUFFim write FUFFim;
    property retira: TpcteRetira read Fretira write Fretira;
    property xdetretira: String read Fxdetretira write Fxdetretira;
    property Toma03: TToma03 read FToma03 write FToma03;
    property Toma4: TToma4 read FToma4 write FToma4;
  end;

  TToma03 = class(TPersistent)
  private
    Ftoma: TpcteTomador;
  published
    property Toma: TpcteTomador read Ftoma write Ftoma;
  end;

  TToma4 = class(TPersistent)
  private
    Ftoma: TpcteTomador;
    FCNPJCPF: String;
    FIE: String;
    FxNome: String;
    FxFant: String;
    FEnderToma: TEnderToma;
    Ffone: String;
  public
    constructor Create(AOwner: TCTe);
    destructor Destroy; override;
  published
    property toma: TpcteTomador read Ftoma write Ftoma;
    property CNPJCPF: String read FCNPJCPF write FCNPJCPF;
    property IE: String read FIE write FIE;
    property xNome: String read FxNome write FxNome;
    property xFant: String read FxFant write FxFant;
    property fone : String read Ffone write Ffone;
    property EnderToma: TEnderToma read FEnderToma write FEnderToma;
  end;

  TEnderToma = class(TPersistent)
  private
    FxLgr: string;
    FxNum: string;
    FxCpl: string;
    FxBairro: string;
    FcMun: integer;
    FxMun: string;
    FCEP: integer;
    FUF: string;
    FcPais: integer;
    FxPais: string;
  published
    property xLgr: string read FxLgr write FxLgr;
    property xNum: string read FxNum write FxNum;
    property xCpl: string read FxCpl write FxCpl;
    property xBairro: string read FxBairro write FxBairro;
    property cMun: integer read FcMun write FcMun;
    property xMun: string read FxMun write FxMun;
    property CEP: integer read FCEP write FCEP;
    property UF: string read FUF write FUF;
    property cPais: integer read FcPais write FcPais;
    property xPais: string read FxPais write FxPais;
  end;

  TCompl = class(TPersistent)
  private
    ForigCalc : String;
    FdestCalc : String;
    FxObs     : String;
  public
    constructor Create(AOwner: TCTe);
    destructor Destroy; override;
  published
    property origCalc : String read ForigCalc write ForigCalc;
    property destCalc : String read FdestCalc write FdestCalc;
    property xObs : String read FxObs write FxObs;
  end;

  TEmit = class(TPersistent)
  private
    FCNPJ  : String;
    FIE    : String;
    FxNome : String;
    FxFant : String;
    FEnderEmit : TEnderEmit;
  public
    constructor Create(AOwner: TCTe);
    destructor Destroy; override;
  published
    property CNPJ : String read FCNPJ write FCNPJ;
    property IE : String read FIE write FIE;
    property xNome : String read FxNome write FxNome;
    property xFant : String read FxFant write FxFant;
    property EnderEmit: TEnderEmit read FEnderEmit write FEnderEmit;
  end;

  TEnderEmit = class(TPersistent)
  private
    FxLgr: string;
    Fnro: string;
    FxCpl: string;
    FxBairro: string;
    FcMun: integer;
    FxMun: string;
    FCEP: integer;
    FUF: string;
    FcPais: integer;
    FxPais: string;
    Ffone : String;
  published
    property xLgr: string read FxLgr write FxLgr;
    property nro: string read Fnro write Fnro;
    property xCpl: string read FxCpl write FxCpl;
    property xBairro: string read FxBairro write FxBairro;
    property cMun: integer read FcMun write FcMun;
    property xMun: string read FxMun write FxMun;
    property CEP: integer read FCEP write FCEP;
    property UF: string read FUF write FUF;
    property cPais: integer read FcPais write FcPais;
    property xPais: string read FxPais write FxPais;
    property fone: String read Ffone write Ffone;
  end;

  TRem = class(TPersistent)
  private
    FEnderReme : TEnderReme;
    FCNPJCPF: String;
    FIE: String;
    FxNome: String;
    FxFant: String;
    Ffone : String;
    FInfNF: TInfNFCollection;
    FInfNFE: TInfNFECollection;
    FInfOutros : TInfOutrosCollection;
    procedure SetInfNF(Value: TInfNFCollection);
    procedure SetInfNFE(Value: TInfNFECollection);
    procedure SetInfOutros(Value: TInfOutrosCollection);
  public
    constructor Create(AOwner: TCTe);
    destructor Destroy; override;
  published
    property EnderReme: TEnderReme read FEnderReme write FEnderReme;
    property InfNF: TInfNFCollection read FInfNF write SetInfNF;
    property InfNFE: TInfNFECollection read FInfNFE write SetInfNFE;
    property InfOutros: TInfOutrosCollection read FInfOutros write FInfOutros;
    property CNPJCPF: String read FCNPJCPF write FCNPJCPF;
    property IE: String read FIE write FIE;
    property xNome: String read FxNome write FxNome;
    property xFant: String read FxFant write FxFant;
    property fone: String read Ffone write Ffone;
  end;

  TEnderReme = class(TPersistent)
  private
    FxLgr: string;
    Fnro: string;
    FxCpl: string;
    FxBairro: string;
    FcMun: integer;
    FxMun: string;
    FCEP: integer;
    FUF: string;
    FcPais: integer;
    FxPais: string;
  published
    property xLgr: string read FxLgr write FxLgr;
    property nro: string read Fnro write Fnro;
    property xCpl: string read FxCpl write FxCpl;
    property xBairro: string read FxBairro write FxBairro;
    property cMun: integer read FcMun write FcMun;
    property xMun: string read FxMun write FxMun;
    property CEP: integer read FCEP write FCEP;
    property UF: string read FUF write FUF;
    property cPais: integer read FcPais write FcPais;
    property xPais: string read FxPais write FxPais;
  end;

  TInfNFCollection = class(TCollection)
  private
    function GetItem(Index: Integer): TInfNFCollectionItem;
    procedure SetItem(Index: Integer; Value: TInfNFCollectionItem);
  public
    constructor Create(AOwner: TRem);
    function Add: TInfNFCollectionItem;
    property Items[Index: Integer]: TInfNFCollectionItem read GetItem write SetItem; default;
  end;

  TInfNFCollectionItem = class(TCollectionItem)
  private
    Fserie : String;
    FnDoc  : String;
    FdEmi  : TDateTime;
    FvBC   : Currency;
    FvICMS : Currency;
    FvBCST : Currency;
    FvST   : Currency;
    FvProd : Currency;
    FvNF   : Currency;
    FnCFOP : integer;
    FnPeso : Currency;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
  published
    property serie: string read Fserie write Fserie;
    property nDoc: string read FnDoc write FnDoc;
    property dEmi: TDateTime read FdEmi write FdEmi;
    property vBC: Currency read FvBC write FvBC;
    property vICMS: Currency read FvICMS write FvICMS;
    property vBCST: Currency read FvBCST write FvBCST;
    property vST: Currency read FvST write FvST;
    property vProd: Currency read FvProd write FvProd;
    property vNF: Currency read FvNF write FvNF;
    property nCFOP: integer read FnCFOP write FnCFOP;
    property nPeso: Currency read FnPeso write FnPeso;
  end;

  TInfNFECollection = class(TCollection)
  private
    function GetItem(Index: Integer): TInfNFECollectionItem;
    procedure SetItem(Index: Integer; Value: TInfNFECollectionItem);
  public
    constructor Create(AOwner: TRem);
    function Add: TInfNFECollectionItem;
    property Items[Index: Integer]: TInfNFECollectionItem read GetItem write SetItem; default;
  end;

  TInfNFECollectionItem = class(TCollectionItem)
  private
    Fchave : String;
    FPIN   : String;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
  published
    property chave: string read Fchave write Fchave;
    property PIN: string read FPIN write FPIN;
  end;

  TInfOutrosCollection = class(TCollection)
  private
    function GetItem(Index: Integer): TInfOutrosCollectionItem;
    procedure SetItem(Index: Integer; Value: TInfOutrosCollectionItem);
  public
    constructor Create(AOwner: TRem);
    function Add: TInfOutrosCollectionItem;
    property Items[Index: Integer]: TInfOutrosCollectionItem read GetItem write SetItem; default;
  end;

  TInfOutrosCollectionItem = class(TCollectionItem)
  private
    FtpDoc: string;
    FdescOutros: string;
    FnDoc: string;
    FdEmi: TdateTime;
    FvDocFisc: Currency;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
  published
    property tpDoc: string read FtpDoc write FtpDoc;
    property descOutros: string read FdescOutros write FdescOutros;
    property nDoc: string read FnDoc write FnDoc;
    property dEmi: TdateTime read FdEmi write FdEmi;
    property vDocFisc: Currency read FvDocFisc write FvDocFisc;
  end;

  TExped = class(TPersistent)
  private
    FCNPJCPF : String;
    FIE      : String;
    FxNome   : String;
    Ffone    : String;
    FEnderExped : TEnderExped;
  public
    constructor Create(AOwner: TCTe);
    destructor Destroy; override;
  published
    property CNPJCPF : String read FCNPJCPF write FCNPJCPF;
    property IE : String read FIE write FIE;
    property xNome : String read FxNome write FxNome;
    property fone : String read Ffone write Ffone;
    property EnderExped: TEnderExped read FEnderExped write FEnderExped;
  end;

  TEnderExped = class(TPersistent)
  private
    FxLgr: string;
    Fnro: string;
    FxCpl: string;
    FxBairro: string;
    FcMun: integer;
    FxMun: string;
    FCEP: integer;
    FUF: string;
    FcPais: integer;
    FxPais: string;
  published
    property xLgr: string read FxLgr write FxLgr;
    property nro: string read Fnro write Fnro;
    property xCpl: string read FxCpl write FxCpl;
    property xBairro: string read FxBairro write FxBairro;
    property cMun: integer read FcMun write FcMun;
    property xMun: string read FxMun write FxMun;
    property CEP: integer read FCEP write FCEP;
    property UF: string read FUF write FUF;
    property cPais: integer read FcPais write FcPais;
    property xPais: string read FxPais write FxPais;
  end;

  TReceb = class(TPersistent)
  private
    FCNPJCPF : String;
    FIE      : String;
    FxNome   : String;
    Ffone    : String;
    FEnderReceb : TEnderReceb;
  public
    constructor Create(AOwner: TCTe);
    destructor Destroy; override;
  published
    property CNPJCPF : String read FCNPJCPF write FCNPJCPF;
    property IE : String read FIE write FIE;
    property xNome : String read FxNome write FxNome;
    property fone : String read Ffone write Ffone;
    property EnderReceb: TEnderReceb read FEnderReceb write FEnderReceb;
  end;

  TEnderReceb = class(TPersistent)
  private
    FxLgr: string;
    Fnro: string;
    FxCpl: string;
    FxBairro: string;
    FcMun: integer;
    FxMun: string;
    FCEP: integer;
    FUF: string;
    FcPais: integer;
    FxPais: string;
  published
    property xLgr: string read FxLgr write FxLgr;
    property nro: string read Fnro write Fnro;
    property xCpl: string read FxCpl write FxCpl;
    property xBairro: string read FxBairro write FxBairro;
    property cMun: integer read FcMun write FcMun;
    property xMun: string read FxMun write FxMun;
    property CEP: integer read FCEP write FCEP;
    property UF: string read FUF write FUF;
    property cPais: integer read FcPais write FcPais;
    property xPais: string read FxPais write FxPais;
  end;

  TDest = class(TPersistent)
  private
    FCNPJCPF   : String;
    FIE        : String;
    FxNome     : String;
    Ffone      : String;
    FISUF      : String;
    FEnderDest : TEnderDest;
  public
    constructor Create(AOwner: TCTe);
    destructor Destroy; override;
  published
    property CNPJCPF : String read FCNPJCPF write FCNPJCPF;
    property IE : String read FIE write FIE;
    property xNome : String read FxNome write FxNome;
    property fone : String read Ffone write Ffone;
    property ISUF : String read FISUF write FISUF;
    property EnderDest: TEnderDest read FEnderDest write FEnderDest;
  end;

  TEnderDest = class(TPersistent)
  private
    FxLgr: string;
    Fnro: string;
    FxCpl: string;
    FxBairro: string;
    FcMun: integer;
    FxMun: string;
    FCEP: integer;
    FUF: string;
    FcPais: integer;
    FxPais: string;
  published
    property xLgr: string read FxLgr write FxLgr;
    property nro: string read Fnro write Fnro;
    property xCpl: string read FxCpl write FxCpl;
    property xBairro: string read FxBairro write FxBairro;
    property cMun: integer read FcMun write FcMun;
    property xMun: string read FxMun write FxMun;
    property CEP: integer read FCEP write FCEP;
    property UF: string read FUF write FUF;
    property cPais: integer read FcPais write FcPais;
    property xPais: string read FxPais write FxPais;
  end;

  TvPrest = class(TPersistent)
  private
    FvTPrest : Currency;
    FvRec    : Currency;
    Fcomp    : TCompCollection;
    procedure SetCompItem(const Value: TCompCollection);
  public
    constructor Create(AOwner: TCTe);
    destructor Destroy; override;
  published
    property vTPrest : Currency read FvTPrest write FvTPrest;
    property vRec : Currency read FvRec write FvRec;
    property comp: TCompCollection read Fcomp write SetCompItem;
  end;

  TCompCollectionItem = class(TCollectionItem)
  private
    FvComp: Currency;
    FxNome: string;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
  published
    property xNome: string read FxNome write FxNome;
    property vComp: Currency read FvComp write FvComp;
  end;

  TCompCollection = class(TCollection)
  private
    function GetItem(Index: Integer): TCompCollectionItem;
    procedure SetItem(Index: Integer; Value: TCompCollectionItem);
  public
    constructor Create(AOwner: TCte);
    function Add: TCompCollectionItem;
    property Items[Index: Integer]: TCompCollectionItem read GetItem write SetItem; default;
  end;

  TImp = class(TPersistent)
  private
    FICMS : TICMS;
    FInfAdFisco : String;
  public
    constructor Create(AOwner: TCTe);
    destructor Destroy; override;
  published
    property ICMS: TICMS read FICMS write FICMS;
    property InfAdFisco : String read FInfAdFisco write FInfAdFisco;
  end;

  TICMS = class(TPersistent)
  private
    FSituTrib   : TpcnCSTIcms;
    FCST00 : TCST00;
    FCST20 : TCST20;
    FCST45 : TCST45;
    FCST80 : TCST80;
    FCST81 : TCST81;
    FCST90 : TCST90;
  public
    constructor Create(AOwner: TImp);
    destructor Destroy; override;
  published
    property SituTrib: TpcnCSTIcms read FSituTrib write FSituTrib;
    property CST00 : TCST00 read FCST00 write FCST00;
    property CST20 : TCST20 read FCST20 write FCST20;
    property CST45 : TCST45 read FCST45 write FCST45;
    property CST80 : TCST80 read FCST80 write FCST80;
    property CST81 : TCST81 read FCST81 write FCST81;
    property CST90 : TCST90 read FCST90 write FCST90;
  end;

  TCST00 = class(TPersistent)
  private
    FCST   : TpcnCSTIcms;
    FvBC   : Currency;
    FpICMS : Currency;
    FvICMS : Currency;
  published
    property CST: TpcnCSTIcms read FCST write FCST default cst00;
    property vBC: Currency read FvBC write FvBC;
    property pICMS: Currency read FpICMS write FpICMS;
    property vICMS: Currency read FvICMS write FvICMS;
  end;

  TCST20 = class(TPersistent)
  private
    FCST    : TpcnCSTIcms;
    FpRedBC : Currency;
    FvBC    : Currency;
    FpICMS  : Currency;
    FvICMS  : Currency;
  published
    property CST: TpcnCSTIcms read FCST write FCST default cst20;
    property pRedBC: Currency read FpRedBC write FpRedBC;
    property vBC: Currency read FvBC write FvBC;
    property pICMS: Currency read FpICMS write FpICMS;
    property vICMS: Currency read FvICMS write FvICMS;
  end;

  TCST45 = class(TPersistent)
  private
    FCST   : TpcnCSTIcms;
  published
    property CST: TpcnCSTIcms read FCST write FCST;
  end;

  TCST80 = class(TPersistent)
  private
    FCST   : TpcnCSTIcms;
    FvBC   : Currency;
    FpICMS : Currency;
    FvICMS : Currency;
    FvCred : Currency;
  published
    property CST: TpcnCSTIcms read FCST write FCST default cst80;
    property vBC: Currency read FvBC write FvBC;
    property pICMS: Currency read FpICMS write FpICMS;
    property vICMS: Currency read FvICMS write FvICMS;
    property vCred: Currency read FvCred write FvCred;
  end;

  TCST81 = class(TPersistent)
  private
    FCST    : TpcnCSTIcms;
    FpRedBC : Currency;
    FvBC    : Currency;
    FpICMS  : Currency;
    FvICMS  : Currency;
  published
    property CST: TpcnCSTIcms read FCST write FCST default cst81;
    property pRedBC: Currency read FpRedBC write FpRedBC;
    property vBC: Currency read FvBC write FvBC;
    property pICMS: Currency read FpICMS write FpICMS;
    property vICMS: Currency read FvICMS write FvICMS;
  end;

  TCST90 = class(TPersistent)
  private
    FCST    : TpcnCSTIcms;
    FpRedBC : Currency;
    FvBC    : Currency;
    FpICMS  : Currency;
    FvICMS  : Currency;
    FvCred : Currency;
  published
    property CST: TpcnCSTIcms read FCST write FCST default cst90;
    property pRedBC: Currency read FpRedBC write FpRedBC;
    property vBC: Currency read FvBC write FvBC;
    property pICMS: Currency read FpICMS write FpICMS;
    property vICMS: Currency read FvICMS write FvICMS;
    property vCred: Currency read FvCred write FvCred;
  end;

  TInfCarga = class(TPersistent)
  private
    FvMerc    : Currency;
    FproPred  : string;
    FxOutCat  : string;
    FInfQ     : TInfQCollection;
    procedure SetInfQ(const Value: TInfQCollection);
  public
    constructor Create(AOwner: TCTe);
    destructor Destroy; override;
  published
    property vMerc : Currency read FvMerc write FvMerc;
    property proPred : String read FproPred write FproPred;
    property xOutCat : String read FxOutCat write FxOutCat;
    property InfQ: TInfQCollection read FInfQ write SetInfQ;
  end;

  TInfQCollection = class(TCollection)
  private
    function GetItem(Index: Integer): TInfQCollectionItem;
    procedure SetItem(Index: Integer; Value: TInfQCollectionItem);
  public
    constructor Create(AOwner: TInfCarga);
    function Add: TInfQCollectionItem;
    property Items[Index: Integer]: TInfQCollectionItem read GetItem write SetItem; default;
  end;

  TInfQCollectionItem = class(TCollectionItem)
  private
    FcUnid  : UnidMed;
    FtpMed  : string;
    FqCarga : currency;
  published
    property cUnid: UnidMed read FcUnid write FcUnid;
    property tpMed: string read FtpMed write FtpMed;
    property qCarga: currency read FqCarga write FqCarga;
  end;

  TInfSegCollection = class(TCollection)
  private
    function GetItem(Index: Integer): TInfSegCollectionItem;
    procedure SetItem(Index: Integer; Value: TInfSegCollectionItem);
  public
    constructor Create(AOwner: TCte);
    function Add: TInfSegCollectionItem;
    property Items[Index: Integer]: TInfSegCollectionItem read GetItem write SetItem; default;
  end;

  TInfSegCollectionItem = class(TCollectionItem)
  private
    FrespSeg : TpcteRspSeg;
    FxSeg    : String;
    FnApol   : String;
    FnAver   : String;
    FvMerc   : Currency;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
  published
    property respSeg: TpcteRspSeg read FrespSeg write FrespSeg;
    property xSeg: string read FxSeg write FxSeg;
    property nApol: string read FnApol write FnApol;
    property nAver: string read FnAver write FnAver;
    property vMerc: Currency read FvMerc write FvMerc;
  end;

  TRodo = class(TPersistent)
  private
    FRNTRC : String;
    FdPrev : tDateTime;
    FLota  : TpcteLocacao;
    FEmiOCC : TEmiOCC;
    FLacres : TLacresCollection;
    FProp   : Tprop;
    fmoto: TMoto;
    procedure SetLacres(const Value: TLacresCollection);
  public
    constructor Create(AOwner: TCTe);
    destructor Destroy; override;
  published
    property RNTRC: String read FRNTRC write FRNTRC;
    property dPrev: TDateTime read FdPrev write FdPrev;
    property Lota: TpcteLocacao read FLota write FLota;
    property EmiOCC: TEmiOCC read FEmiOCC write FEmiOCC;
    property Lacres: TLacresCollection read FLacres write SetLacres;
    property Prop: Tprop read FProp write FProp;
    property moto: TMoto read fmoto write fmoto;
  end;

  TMoto = class(TPersistent)
  private
    fxNome: string;
    fCPF: string;
  public
    property xNome: string read fxNome write fxNome;
    property CPF: string read fCPF write fCPF;
  end;


  TEmiOCC = class(TPersistent)
  private
    FCNPJ : String;
    FcInt : String;
    FIE   : String;
    FUF   : String;
    Ffone : String;
  published
    property CNPJ: String read FCNPJ write FCNPJ;
    property cInt: String read FcInt write FcInt;
    property IE: String read FIE write FIE;
    property UF: String read FUF write FUF;
    property fone: String read Ffone write Ffone;
  end;

  TLacresCollection = class(TCollection)
  private
    function GetItem(Index: Integer): TLacresCollectionItem;
    procedure SetItem(Index: Integer; Value: TLacresCollectionItem);
  public
    constructor Create(AOwner: TRodo);
    function Add: TLacresCollectionItem;
    property Items[Index: Integer]: TLacresCollectionItem read GetItem write SetItem; default;
  end;

  TLacresCollectionItem = class(TCollectionItem)
  private
    FnLacre: string;
  published
    property nLacre: string read FnLacre write FnLacre;
  end;

  Tprop = class(TPersistent)
  private
    FCNPJCPF : String;
    FRNTRC    : String;
    FxNome    : String;
    FIE       : String;
    FUF       : String;
    FtpProp   : TpcteProp;
  published
    property CNPJCPF: String read FCNPJCPF write FCNPJCPF;
    property RNTRC: String read FRNTRC write FRNTRC;
    property xNome: String read FxNome write FxNome;
    property IE: String read FIE write FIE;
    property UF: String read FUF write FUF;
    property tpProp: TpcteProp read FtpProp write FtpProp;
  end;

  TInfCteAnuEnt = class(TPersistent)
  private
    FchCTe : String;
    FdEmi : TDateTime;
  public
    constructor Create(AOwner: TCTe);
    destructor Destroy; override;
  published
    property chCTe : String read FchCTe write FchCTe;
    property dEmi : TDateTime read FdEmi write FdEmi;
  end;

  TinfCteComp = class(TPersistent)
  private
    FChave     : String;
    FvPresComp : TvPresComp;
  public
    constructor Create(AOwner: TCTe);
    destructor Destroy; override;
  published
    property Chave : String read FChave write FChave;
    property vPresComp: TvPresComp read FvPresComp write FvPresComp;
  end;

  TvPresComp = class(TPersistent)
  private
    FvTPrest: Currency;
  published
    property vTPrest: Currency read FvTPrest write FvTPrest;
  end;
const
  CMUN_EXTERIOR: integer = 9999999;
  XMUN_EXTERIOR: string = 'EXTERIOR';
  UF_EXTERIOR: string = 'EX';

implementation

{ TCTe }
constructor TCTe.Create;
begin
  FinfCTe       := TInfCTe.Create;
  FIde          := TIde.Create(Self);
  FCompl        := TCompl.Create(Self);
  FEmit         := TEmit.Create(Self);
  FRem          := TRem.Create(Self);;
  FExped        := TExped.Create(Self);
  FReceb        := TReceb.Create(Self);
  FDest         := TDest.Create(Self);
  FvPrest       := TvPrest.Create(Self);
  FImp          := TImp.Create(Self);
  FInfCarga     := TInfCarga.Create(Self);
  FInfSeg       := TInfSegCollection.Create(Self);
  FRodo         := TRodo.Create(Self);
  FInfCteAnuEnt := TInfCteAnuEnt.Create(Self);
  FinfCteComp   := TinfCteComp.Create(Self);
  Fsignature := Tsignature.create;
end;

destructor TCTe.Destroy;
begin
  FinfCTe.Free;
  FIde.Free;
  FCompl.Free;
  FEmit.Free;
  FRem.Free;
  FExped.Free;
  FReceb.Free;
  FDest.Free;
  FvPrest.Free;
  FImp.Free;
  FInfCarga.Free;
  FInfSeg.Free;
  FRodo.Free;
  FInfCteAnuEnt.Free;

  Fsignature.Free;
  inherited Destroy;
end;

{Ide}

constructor TIde.Create(AOwner: TCTe);
begin
  inherited Create;
  FToma03 := TToma03.Create;
  FToma4  := TToma4.Create( AOwner );
end;

destructor TIde.Destroy;
begin
  FToma03.Free;
  FToma4.Free;
  inherited;
end;

constructor TToma4.Create(AOwner: TCTe);
begin
  inherited Create;
  FEnderToma := TEnderToma.Create;
end;

destructor TToma4.Destroy;
begin
  FEnderToma.Free;
  inherited;
end;


procedure TCTe.SetInfSeg(Value: TInfSegCollection);
begin
  FInfSeg.Assign(Value);
end;

{ TCompl }

constructor TCompl.Create(AOwner: TCTe);
begin
  inherited Create;
end;

destructor TCompl.Destroy;
begin
  inherited;
end;

{ TEmit }

constructor TEmit.Create(AOwner: TCTe);
begin
  inherited Create;
  FEnderEmit := TEnderEmit.Create;
end;

destructor TEmit.Destroy;
begin
  FEnderEmit.Free;
  inherited;
end;

{ TRem }

constructor TRem.Create(AOwner: TCTe);
begin
  inherited Create;
  FEnderReme := TEnderReme.Create;
  FInfNF     := TInfNFCollection.Create(Self);
  FInfNFe    := TInfNFeCollection.Create(Self);
  FInfOutros := TInfOutrosCollection.Create(Self);
end;

destructor TRem.Destroy;
begin
  FEnderReme.Free;
  FInfNF.Free;
  FInfNFe.Free;
  FInfOutros.Free;

  inherited;
end;

procedure TRem.SetInfNF(Value: TInfNFCollection);
begin
  FInfNF.Assign(Value);
end;

procedure TRem.SetInfNFE(Value: TInfNFECollection);
begin
  FInfNFE.Assign(Value);
end;

procedure TRem.SetInfOutros(Value: TInfOutrosCollection);
begin
  FInfOutros.Assign(Value);
end;

{ TInfNFCollection }

function TInfNFCollection.Add: TInfNFCollectionItem;
begin
  Result := TInfNFCollectionItem(inherited Add);
  Result.create;
end;

constructor TInfNFCollection.Create(AOwner: TRem);
begin
  inherited Create(TInfNFCollectionItem);
end;

function TInfNFCollection.GetItem(Index: Integer): TInfNFCollectionItem;
begin
  Result := TInfNFCollectionItem(inherited GetItem(Index));
end;

procedure TInfNFCollection.SetItem(Index: Integer;
  Value: TInfNFCollectionItem);
begin
  inherited SetItem(Index, Value);
end;

{ TInfNFCollectionItem }

constructor TInfNFCollectionItem.Create;
begin

end;

destructor TInfNFCollectionItem.Destroy;
begin

  inherited;
end;

{ TInfNFECollectionItem }

constructor TInfNFECollectionItem.Create;
begin

end;

destructor TInfNFECollectionItem.Destroy;
begin

  inherited;
end;

{ TInfNFECollection }

function TInfNFECollection.Add: TInfNFECollectionItem;
begin
  Result := TInfNFECollectionItem(inherited Add);
  Result.create;
end;

constructor TInfNFECollection.Create(AOwner: TRem);
begin
  inherited Create(TInfNFECollectionItem);
end;

function TInfNFECollection.GetItem(Index: Integer): TInfNFECollectionItem;
begin
  Result := TInfNFECollectionItem(inherited GetItem(Index));
end;

procedure TInfNFECollection.SetItem(Index: Integer;
  Value: TInfNFECollectionItem);
begin
  inherited SetItem(Index, Value);
end;

{ TExped }

constructor TExped.Create(AOwner: TCTe);
begin
  inherited Create;
  FEnderExped := TEnderExped.Create;
end;

destructor TExped.Destroy;
begin
  FEnderExped.Free;
  inherited;
end;

{ TReceb }

constructor TReceb.Create(AOwner: TCTe);
begin
  inherited Create;
  FEnderReceb := TEnderReceb.Create;
end;

destructor TReceb.Destroy;
begin
  FEnderReceb.Free;
  inherited;
end;

{ TDest }

constructor TDest.Create(AOwner: TCTe);
begin
  inherited Create;
  FEnderDest := TEnderDest.Create;
end;

destructor TDest.Destroy;
begin
  FEnderDest.Free;          
  inherited;
end;

{ TvPrest }

constructor TvPrest.Create(AOwner: TCTe);
begin
  inherited Create;
  FComp := TCompCollection.Create(AOwner);
end;

destructor TvPrest.Destroy;
begin
  FComp.Free;
  inherited;
end;

procedure TvPrest.SetCompItem(const Value: TCompCollection);
begin
  Fcomp.Assign(Value);
end;

{ TImp }

constructor TImp.Create(AOwner: TCTe);
begin
  FICMS := TICMS.Create(Self);
end;

destructor TImp.Destroy;
begin
  FICMS.free;
  inherited;
end;

{ TICMS }

constructor TICMS.Create(AOwner: TImp);
begin
  inherited Create;
  FCST00 := TCST00.create;
  FCST20 := TCST20.create;
  FCST45 := TCST45.create;
  FCST80 := TCST80.create;
  FCST81 := TCST81.create;
  FCST90 := TCST90.create;
end;

destructor TICMS.Destroy;
begin
  FCST00.Free;
  FCST20.Free;
  FCST45.Free;
  FCST80.Free;
  FCST81.Free;
  FCST90.Free;
  inherited;
end;

{ TInfSegCollection }

function TInfSegCollection.Add: TInfSegCollectionItem;
begin
  Result := TInfSegCollectionItem(inherited Add);
  Result.create;
end;

constructor TInfSegCollection.Create(AOwner: TCte);
begin
  inherited Create(TInfSegCollectionItem);
end;

function TInfSegCollection.GetItem(Index: Integer): TInfSegCollectionItem;
begin
  Result := TInfSegCollectionItem(inherited GetItem(Index));
end;

procedure TInfSegCollection.SetItem(Index: Integer; Value: TInfSegCollectionItem);
begin
  inherited SetItem(Index, Value);
end;

{ TInfSegCollectionItem }

constructor TInfSegCollectionItem.Create;
begin

end;

destructor TInfSegCollectionItem.Destroy;
begin

  inherited;
end;

{ TRodo }

constructor TRodo.Create(AOwner: TCTe);
begin
  FEmiOCC := TEmiOCC.Create;
  FLacres := TLacresCollection.Create(self);
  FProp   := TProp.Create;
end;

destructor TRodo.Destroy;
begin
  FEmiOCC.Free;
  FLacres.Free;
  FProp.Free;
  inherited;
end;

procedure TRodo.SetLacres(const Value: TLacresCollection);
begin
  FLacres := Value;
end;

{ TLacresCollection }

function TLacresCollection.Add: TLacresCollectionItem;
begin
  Result := TLacresCollectionItem(inherited Add);
end;

constructor TLacresCollection.Create(AOwner: TRodo);
begin
  inherited Create(TLacresCollectionItem);
end;

function TLacresCollection.GetItem(Index: Integer): TLacresCollectionItem;
begin
  Result := TLacresCollectionItem(inherited GetItem(Index));
end;

procedure TLacresCollection.SetItem(Index: Integer;
  Value: TLacresCollectionItem);
begin
  inherited SetItem(Index, Value);
end;

{ TInfCteAnuEnt }

constructor TInfCteAnuEnt.Create(AOwner: TCTe);
begin
  inherited Create;
end;

destructor TInfCteAnuEnt.Destroy;
begin
  inherited;
end;

{ TinfCteComp }

constructor TinfCteComp.Create(AOwner: TCTe);
begin
  inherited Create;
  FvPresComp := TvPresComp.Create;
end;

destructor TinfCteComp.Destroy;
begin
  FvPresComp.Free;
  inherited;
end;

{ TInfOutrosCollection }

function TInfOutrosCollection.Add: TInfOutrosCollectionItem;
begin
  Result := TInfOutrosCollectionItem(inherited Add);
  Result.create;
end;

constructor TInfOutrosCollection.Create(AOwner: TRem);
begin
  inherited Create(TInfOutrosCollectionItem);
end;

function TInfOutrosCollection.GetItem(
  Index: Integer): TInfOutrosCollectionItem;
begin
  Result := TInfOutrosCollectionItem(inherited GetItem(Index));
end;

procedure TInfOutrosCollection.SetItem(Index: Integer;
  Value: TInfOutrosCollectionItem);
begin
  inherited SetItem(Index, Value);
end;

{ TInfOutrosCollectionItem }

constructor TInfOutrosCollectionItem.Create;
begin

end;

destructor TInfOutrosCollectionItem.Destroy;
begin

  inherited;
end;

{ TInfCarga }
constructor TInfCarga.Create(AOwner: TCTe);
begin
  FInfQ := TInfQCollection.Create(self);
end;

destructor TInfCarga.Destroy;
begin
  FInfQ.Free;
  inherited;
end;

procedure TInfCarga.SetInfQ(const Value: TInfQCollection);
begin
  FInfQ := Value;
end;

{ TInfQCollection }

function TInfQCollection.Add: TInfQCollectionItem;
begin
  Result := TInfQCollectionItem(inherited Add);
end;

constructor TInfQCollection.Create(AOwner: TInfCarga);
begin
  inherited Create(TInfQCollectionItem);
end;

function TInfQCollection.GetItem(Index: Integer): TInfQCollectionItem;
begin
  Result := TInfQCollectionItem(inherited GetItem(Index));
end;

procedure TInfQCollection.SetItem(Index: Integer;
  Value: TInfQCollectionItem);
begin
  inherited SetItem(Index, Value);
end;

{ TCompCollectionItem }

constructor TCompCollectionItem.Create;
begin

end;

destructor TCompCollectionItem.Destroy;
begin

  inherited;
end;

{ TCompCollection }

function TCompCollection.Add: TCompCollectionItem;
begin
  Result := TCompCollectionItem(inherited Add);
  Result.create;
end;

constructor TCompCollection.Create(AOwner: TCte);
begin
  inherited Create(TCompCollectionItem);
end;

function TCompCollection.GetItem(Index: Integer): TCompCollectionItem;
begin
  Result := TCompCollectionItem(inherited GetItem(Index));
end;

procedure TCompCollection.SetItem(Index: Integer; Value: TCompCollectionItem);
begin
  inherited SetItem(Index, Value);
end;

end.

