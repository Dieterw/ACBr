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
  pcnConversao, pcnSignature;

type

  TCTe = class;
  TInfCTe = class;
  TIde = class;
  TToma03 = class;
  TToma4 = class;
  TEnderToma = class;

  TCTe = class(TPersistent)
  private
    FSchema: TpcnSchema;
    FinfCTe: TinfCTe;
    FIde: TIde;

    FSignature: TSignature;
  public
    constructor Create;
    destructor Destroy; override;
  published
    property schema: TpcnSchema read Fschema write Fschema;
    //
    property infCTe: TinfCTe read FinfCTe write FinfCTe;
    property Ide: TIde read FIde write FIde;

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
  public
    constructor Create(AOwner: TCTe);
    destructor Destroy; override;
  published
    property toma: TpcteTomador read Ftoma write Ftoma;
    property CNPJCPF: String read FCNPJCPF write FCNPJCPF;
    property IE: String read FIE write FIE;
    property xNome: String read FxNome write FxNome;
    property xFant: String read FxFant write FxFant;
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

const

  CMUN_EXTERIOR: integer = 9999999;
  XMUN_EXTERIOR: string = 'EXTERIOR';
  UF_EXTERIOR: string = 'EX';

implementation

{ TCTe }
constructor TCTe.Create;
begin
  FinfCTe := TInfCTe.Create;

  Fsignature := Tsignature.create;
end;

destructor TCTe.Destroy;
begin
  FinfCTe.Free;

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


end.

