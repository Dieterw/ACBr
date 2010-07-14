////////////////////////////////////////////////////////////////////////////////
//                                                                            //
//              PCN - Projeto Cooperar NFe                                    //
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
// Desenvolvimento                                                            //
//         de CTe: Wiliam Zacarias da Silva Rosa                              //
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

unit pcteCTeW;

interface uses

  SysUtils, Classes, pcnAuxiliar, pcnConversao, pcnGerador, pcteCTe;

type

  TGeradorOpcoes = class;

  TCTeW = class(TPersistent)
  private
    FGerador: TGerador;
    FCTe: TCTe;
    FSchema: TpcnSchema;
    FOpcoes: TGeradorOpcoes;
    procedure GerarInfCTe;     // Nivel 0

    procedure GerarIde;        // Nivel 1
    procedure GerarToma03;     // Nivel 2
    procedure GerarToma4;      // Nivel 2
    procedure GerarEnderToma;  // Nivel 3

    procedure GerarCompl;      // Nivel 1
    procedure GerarFluxo;      // Nivel 2
    procedure GerarEntrega;    // Nivel 2
    procedure GerarObsCont;    // Nivel 2
    procedure GerarObsFisco;   // Nivel 2

    procedure GerarEmit;       // Nivel 1
    procedure GerarEnderEmit;  // Nivel 2

    procedure GerarRem;        // Nivel 1
    procedure GerarEnderReme;  // Nivel 2
    procedure GerarInfNF;      // Nivel 2
    procedure GerarInfNFE;     // Nivel 2
    procedure GerarInfOutros;  // Nivel 2

    procedure GerarExped;      // Nivel 1
    procedure GerarEnderExped; // Nivel 2

    procedure GerarReceb;      // Nivel 1
    procedure GerarEnderReceb; // Nivel 2

    procedure GerarDest;       // Nivel 1
    procedure GerarEnderDest;  // Nivel 2
    procedure GerarLocEnt;     // Nivel 2

    procedure GerarVPrest;     // Nivel 1
    procedure GerarComp;       // Nivel 2

    procedure GerarImp;        // Nivel 1
    procedure GerarICMS;       // Nivel 2
    procedure GerarCST00;      // Nivel 3
    procedure GerarCST20;      // Nivel 3
    procedure GerarCST45;      // Nivel 3
    procedure GerarCST80;      // Nivel 3
    procedure GerarCST81;      // Nivel 3
    procedure GerarCST90;      // Nivel 3

    procedure GerarInfCTeNorm; // Nivel 1
    procedure GerarinfCarga;   // Nivel 2
    procedure GerarInfQ;       // Nivel 3
    procedure GerarContQt;     // Nivel 2
    procedure GerarDocAnt;     // Nivel 2
    procedure GerarInfSeg;     // Nivel 2
    procedure GerarRodo;       // Nivel 2
    procedure GerarCTRB;       // Nivel 3
    procedure GerarOCC;        // Nivel 3
    procedure GerarValePed;    // Nivel 3
    procedure GerarVeic;       // Nivel 3
    procedure GerarLacre;      // Nivel 3
    procedure GerarMoto;       // Nivel 3
    procedure GerarAereo;      // Nivel 2
    procedure GerarAquav;      // Nivel 2
    procedure GerarFerrov;     // Nivel 2
    procedure GerarDuto;       // Nivel 2
    procedure GerarPeri;       // Nivel 2
    procedure GerarVeicNovos;  // Nivel 2
    procedure GerarInfCTeSub;  // Nivel 2

    procedure GerarInfCTeComp; // Nivel 1
    procedure GerarImpComp(i: Integer);    // Nivel 2
    procedure GerarICMSComp(i: Integer);   // Nivel 3
    procedure GerarCST00Comp(i: Integer);  // Nivel 4
    procedure GerarCST20Comp(i: Integer);  // Nivel 4
    procedure GerarCST45Comp(i: Integer);  // Nivel 4
    procedure GerarCST80Comp(i: Integer);  // Nivel 4
    procedure GerarCST81Comp(i: Integer);  // Nivel 4
    procedure GerarCST90Comp(i: Integer);  // Nivel 4

    procedure GerarInfCTeAnu;  // Nivel 1

    procedure AjustarMunicipioUF(var xUF: string; var xMun: string; var cMun: integer; cPais: integer; vxUF, vxMun: string; vcMun: integer);
    function ObterNomeMunicipio(const xMun, xUF: string; const cMun: integer): string;

  public
    constructor Create(AOwner: TCTe);
    destructor Destroy; override;
    function GerarXml: boolean;
    function ObterNomeArquivo: string;
  published
    property Gerador: TGerador read FGerador write FGerador;
    property CTe: TCTe read FCTe write FCTe;
    property schema: TpcnSchema read Fschema write Fschema;
    property Opcoes: TGeradorOpcoes read FOpcoes write FOpcoes;
  end;

  TGeradorOpcoes = class(TPersistent)
  private
    FAjustarTagNro: boolean;
    FNormatizarMunicipios: boolean;
    FGerarTagAssinatura: TpcnTagAssinatura;
    FPathArquivoMunicipios: string;
    FValidarInscricoes: boolean;
    FValidarListaServicos: boolean;
  published
    property AjustarTagNro: boolean read FAjustarTagNro write FAjustarTagNro;
    property NormatizarMunicipios: boolean read FNormatizarMunicipios write FNormatizarMunicipios;
    property GerarTagAssinatura: TpcnTagAssinatura read FGerarTagAssinatura write FGerarTagAssinatura;
    property PathArquivoMunicipios: string read FPathArquivoMunicipios write FPathArquivoMunicipios;
    property ValidarInscricoes: boolean read FValidarInscricoes write FValidarInscricoes;
    property ValidarListaServicos: boolean read FValidarListaServicos write FValidarListaServicos;
  end;

  ////////////////////////////////////////////////////////////////////////////////

implementation

{ TCTeW }

constructor TCTeW.Create(AOwner: TCTe);
begin
  FCTe := AOwner;
  FGerador := TGerador.Create;
  FGerador.FIgnorarTagNivel := '|?xml version|CTe xmlns|infCTe versao|obsCont|obsFisco|';
  FOpcoes := TGeradorOpcoes.Create;
  FOpcoes.FAjustarTagNro := True;
  FOpcoes.FNormatizarMunicipios := False;
  FOpcoes.FGerarTagAssinatura := taSomenteSeAssinada;
  FOpcoes.FValidarInscricoes := False;
  FOpcoes.FValidarListaServicos := False;
end;

destructor TCTeW.Destroy;
begin
  FGerador.Free;
  FOpcoes.Free;
  inherited Destroy;
end;

////////////////////////////////////////////////////////////////////////////////

function TCTeW.ObterNomeArquivo: string;
begin
  Result := SomenteNumeros(CTe.infCTe.ID) + '-cte.xml';
end;

function TCTeW.GerarXml: boolean;
var
  chave: AnsiString;
  Gerar: boolean;
  xProtCTe : String;
begin
  chave := '';
  //Verificar Chave do CTe quando tiver instalado NFe 2.0
  if not GerarChaveCTe(Chave, CTe.ide.cUF, CTe.ide.cCT, StrToInt(CTe.ide.modelo), CTe.ide.serie,
    CTe.ide.nCT, CTe.ide.dhEmi, CTe.Emit.CNPJ) then
    Gerador.wAlerta('A01', 'infCte', DSC_CHAVE, ERR_MSG_GERAR_CHAVE);
{
  if (Trim(CTe.infCTe.ID) = '') or (not ValidarChave(CTe.infCTe.ID))
   then CTe.infCTe.ID := StringReplace( UpperCase(chave), 'NFE', '', [rfReplaceAll] )
   else CTe.infCTe.ID := StringReplace( UpperCase(CTe.infCTe.ID), 'NFE', '', [rfReplaceAll] );

  CTe.infCTe.ID := 'CTe'+CTe.infCTe.ID;
  CTe.ide.cDV := RetornarDigito(CTe.infCTe.ID);
  CTe.Ide.cCT := RetornarCodigoNumerico(CTe.infCTe.ID);
}

  chave := StringReplace(chave,'NFe','CTe',[rfReplaceAll]);
  CTe.infCTe.ID := chave;
  CTe.ide.cDV := RetornarDigito(CTe.infCTe.ID);

  // Carrega Layout que sera utilizado para gera o txt
  Gerador.LayoutArquivoTXT.Clear;
  Gerador.ArquivoFormatoXML := '';
  Gerador.ArquivoFormatoTXT := '';

  Gerador.wGrupo(ENCODING_UTF8, '', False);
  Gerador.wGrupo('CTe ' + NAME_SPACE_CTE);
  Gerador.wGrupo('infCte ' + V1_03 + ' Id="' + CTe.infCTe.ID + '"');
  (**)GerarInfCTe;
  Gerador.wGrupo('/infCte');
  //
  if FOpcoes.GerarTagAssinatura <> taNunca then
  begin
    Gerar := true;
    if FOpcoes.GerarTagAssinatura = taSomenteSeAssinada then
      Gerar := ((CTe.signature.DigestValue <> '') and (CTe.signature.SignatureValue <> '') and (CTe.signature.X509Certificate <> ''));
    if FOpcoes.GerarTagAssinatura = taSomenteParaNaoAssinada then
      Gerar := ((CTe.signature.DigestValue = '') and (CTe.signature.SignatureValue = '') and (CTe.signature.X509Certificate = ''));
    if Gerar then
    begin
      FCTe.signature.URI := somenteNumeros(CTe.infCTe.ID);
      FCTe.signature.Gerador.Opcoes.IdentarXML := Gerador.Opcoes.IdentarXML;
      FCTe.signature.GerarXMLCTe;
      Gerador.ArquivoFormatoXML := Gerador.ArquivoFormatoXML + FCTe.signature.Gerador.ArquivoFormatoXML;
    end;
  end;
  Gerador.wGrupo('/CTe');

  if CTe.procCTe.nProt <> '' then
   begin
     xProtCTe :=
       (**)'<protCTe versao="1.03">' +
     (******)'<infProt>'+
     (*********)'<tpAmb>'+TpAmbToStr(CTe.procCTe.tpAmb)+'</tpAmb>'+
     (*********)'<verAplic>'+CTe.procCTe.verAplic+'</verAplic>'+
     (*********)'<chCTe>'+CTe.procCTe.chCTe+'</chCTe>'+
     (*********)'<dhRecbto>'+FormatDateTime('yyyy-mm-dd"T"hh:nn:ss',CTe.procCTe.dhRecbto)+'</dhRecbto>'+
     (*********)'<nProt>'+CTe.procCTe.nProt+'</nProt>'+
     (*********)'<digVal>'+CTe.procCTe.digVal+'</digVal>'+
     (*********)'<cStat>'+IntToStr(CTe.procCTe.cStat)+'</cStat>'+
     (*********)'<xMotivo>'+CTe.procCTe.xMotivo+'</xMotivo>'+
     (******)'</infProt>'+
     {****}'</protCTe>';

     (**)Gerador.wTexto(xProtCTe);
     Gerador.wGrupo('/cteProc');
   end;

  Gerador.gtAjustarRegistros(CTe.infCTe.ID);
  Result := (Gerador.ListaDeAlertas.Count = 0);
end;

procedure TCTeW.GerarInfCTe;
begin
  GerarIde;
  GerarCompl;
  GerarEmit;
  GerarRem;
  GerarExped;
  GerarReceb;
  GerarDest;
  GerarvPrest;
  GerarImp;
  GerarInfCTeNorm;
  GerarinfCTeComp;
  GerarInfCTeAnu;
end;

procedure TCTeW.GerarIde;
begin
  Gerador.wGrupo('ide', 'B01');
  Gerador.wCampo(tcInt, 'B02', 'cUF     ', 02, 02, 1, CTe.ide.cUF, DSC_CUF);
  if not ValidarCodigoUF(CTe.ide.cUF) then
    Gerador.wAlerta('B02', 'cUF', DSC_CUF, ERR_MSG_INVALIDO);
  Gerador.wCampo(tcStr, 'B03', 'cCT     ', 09, 09, 1, IntToStrZero(RetornarCodigoNumericoCTe(CTe.infCTe.ID), 9), DSC_CNF);
  Gerador.wCampo(tcInt, 'B04', 'CFOP    ', 04, 04, 1, CTe.ide.CFOP, DSC_CFOP);
  Gerador.wCampo(tcStr, 'B05', 'natOp   ', 01, 60, 1, CTe.ide.natOp, DSC_NATOP);
  Gerador.wCampo(tcStr, 'B06', 'forPag  ', 01, 01, 1, tpforPagToStr(CTe.ide.forPag), DSC_INDPAG);
  Gerador.wCampo(tcInt, 'B07', 'mod     ', 02, 02, 1, CTe.ide.modelo, DSC_MOD);
  Gerador.wCampo(tcInt, 'B08', 'serie   ', 01, 03, 1, CTe.ide.serie, DSC_SERIE);
  Gerador.wCampo(tcInt, 'B09', 'nCT     ', 01, 09, 1, CTe.ide.nCT, DSC_NNF);
  Gerador.wCampo(tcDatHor, 'B10', 'dhEmi', 19, 19, 1, CTe.ide.dhEmi, DSC_DEMI);
  Gerador.wCampo(tcStr, 'B11', 'tpImp   ', 01, 01, 1, tpImpToStr(CTe.Ide.tpImp), DSC_TPIMP);
  Gerador.wCampo(tcStr, 'B12', 'tpEmis  ', 01, 01, 1, tpEmisToStr(CTe.Ide.tpEmis), DSC_TPEMIS);
  Gerador.wCampo(tcInt, 'B13', 'cDV     ', 01, 01, 1, CTe.Ide.cDV, DSC_CDV);
  Gerador.wCampo(tcStr, 'B14', 'tpAmb   ', 01, 01, 1, tpAmbToStr(CTe.Ide.tpAmb), DSC_TPAMB);
  Gerador.wCampo(tcStr, 'B15', 'tpCTe   ', 01, 01, 1, tpCTePagToStr(CTe.Ide.tpCTe), DSC_TPCTE);
  Gerador.wCampo(tcStr, 'B15a', 'procEmi', 01, 01, 1, procEmiToStr(CTe.Ide.procEmi), DSC_PROCEMI);
  Gerador.wCampo(tcStr, 'B15b', 'verProc', 01, 20, 1, CTe.Ide.verProc, DSC_VERPROC);
  Gerador.wCampo(tcStr, 'B15c', 'refCTE ', 44, 44, 0, CTe.Ide.refCTE, DSC_REFCTE);
  Gerador.wCampo(tcInt, 'B16', 'cMunEmi ', 07, 07, 1, CTe.ide.cMunEmi, DSC_CMUNEMI);
  if not ValidarMunicipio(CTe.ide.cMunEmi) then
    Gerador.wAlerta('B16', 'cMunEmi', DSC_CMUNEMI, ERR_MSG_INVALIDO);
  Gerador.wCampo(tcStr, 'B17', 'xMunEmi ', 01, 60, 1, CTe.ide.xMunEmi, DSC_XMUN);
  Gerador.wCampo(tcStr, 'B18', 'UFEmi   ', 02, 02, 1, CTe.ide.UFEmi, DSC_UF);
  Gerador.wCampo(tcStr, 'B19', 'modal   ', 02, 02, 1, TpModalToStr(CTe.Ide.modal), DSC_MODAL);
  Gerador.wCampo(tcStr, 'B20', 'tpServ  ', 01, 01, 1, TpServPagToStr(CTe.Ide.tpServ), DSC_TPSERV);
  Gerador.wCampo(tcInt, 'B21', 'cMunIni ', 07, 07, 1, CTe.ide.cMunIni, DSC_CMUNEMI);
  if not ValidarMunicipio(CTe.ide.cMunIni) then
    Gerador.wAlerta('B21', 'cMunIni', DSC_CMUNEMI, ERR_MSG_INVALIDO);
  Gerador.wCampo(tcStr, 'B22', 'xMunIni ', 01, 60, 1, CTe.ide.xMunIni, DSC_XMUN);
  Gerador.wCampo(tcStr, 'B23', 'UFIni   ', 02, 02, 1, CTe.ide.UFIni, DSC_UF);
  Gerador.wCampo(tcInt, 'B24', 'cMunFim ', 07, 07, 1, CTe.ide.cMunFim, DSC_CMUNEMI);
  if not ValidarMunicipio(CTe.ide.cMunFim) then
    Gerador.wAlerta('B24', 'cMunFim', DSC_CMUNEMI, ERR_MSG_INVALIDO);
  Gerador.wCampo(tcStr, 'B25', 'xMunFim    ', 01, 60, 1, CTe.ide.xMunFim, DSC_XMUN);
  Gerador.wCampo(tcStr, 'B26', 'UFFim      ', 02, 02, 1, CTe.ide.UFFim, DSC_UF);
  Gerador.wCampo(tcStr, 'B27', 'retira     ', 01, 01, 1, TpRetiraPagToStr(CTe.Ide.retira), DSC_RETIRA);
  Gerador.wCampo(tcStr, 'B27a', 'xDetRetira', 01, 160, 0, CTe.Ide.xdetretira, DSC_DRET);

  (**)GerarToma03;
  (**)GerarToma4;

  Gerador.wGrupo('/ide');
end;

procedure TCTeW.GerarToma03;
begin
  Gerador.wGrupo('toma03', 'B28');
  Gerador.wCampo(tcStr, 'B29', 'toma   ', 01, 01, 1, TpTomadorToStr(CTe.ide.Toma03.Toma), DSC_TOMA);
  Gerador.wGrupo('/toma03');
end;

procedure TCTeW.GerarToma4;
begin
  if (CTe.Ide.Toma4.IE <> '') or
     (CTe.Ide.Toma4.xNome <> '') then
  Begin
    Gerador.wGrupo('toma4', 'B30');
    Gerador.wCampo(tcStr, 'B29', 'toma   ', 01, 01, 1, TpTomadorToStr(CTe.ide.Toma4.Toma), DSC_TOMA);
    Gerador.wCampoCNPJCPF('B31', 'B32', CTe.ide.Toma4.CNPJCPF, CTe.Ide.Toma4.EnderToma.cPais);
    Gerador.wCampo(tcStr, 'B33', 'IE     ', 00, 14, 0, SomenteNumeros(CTe.Ide.Toma4.IE), DSC_IE);
    Gerador.wCampo(tcStr, 'B34', 'xNome  ', 01, 60, 1, CTe.Ide.Toma4.xNome, DSC_XNOME);
    Gerador.wCampo(tcStr, 'B35', 'xFant  ', 01, 60, 0, CTe.Ide.Toma4.xFant, DSC_XFANT);
    Gerador.wCampo(tcStr, 'B35a', 'fone  ', 07, 12, 0, CTe.Ide.Toma4.fone, DSC_FONE);

    (***)GerarEnderToma;

    Gerador.wGrupo('/toma4');
  end;
end;

procedure TCTeW.GerarEnderToma;
var
  cMun: integer;
  xMun: string;
  xUF: string;
begin
  AjustarMunicipioUF(xUF, xMun, cMun, CTe.Ide.Toma4.EnderToma.cPais, CTe.Ide.Toma4.EnderToma.UF, CTe.Ide.Toma4.EnderToma.xMun, CTe.Ide.Toma4.EnderToma.cMun);
  Gerador.wGrupo('enderToma', 'B36');
  Gerador.wCampo(tcStr, 'B37', 'xLgr   ', 01, 255, 1, CTe.Ide.Toma4.EnderToma.xLgr, DSC_XLGR);
  Gerador.wCampo(tcStr, 'B38', 'nro    ', 01, 60, 1, ExecutarAjusteTagNro(FOpcoes.FAjustarTagNro, CTe.Ide.Toma4.EnderToma.xNum), DSC_NRO);
  Gerador.wCampo(tcStr, 'B39', 'xCpl   ', 01, 60, 0, CTe.Ide.Toma4.EnderToma.xCpl, DSC_XCPL);
  Gerador.wCampo(tcStr, 'B40', 'xBairro', 01, 60, 1, CTe.Ide.Toma4.EnderToma.xBairro, DSC_XBAIRRO);
  Gerador.wCampo(tcInt, 'B41', 'cMun   ', 07, 07, 1, cMun, DSC_CMUN);
  if not ValidarMunicipio(CTe.Ide.Toma4.EnderToma.cMun) then
    Gerador.wAlerta('B41', 'cMun', DSC_CMUN, ERR_MSG_INVALIDO);
  Gerador.wCampo(tcStr, 'B42', 'xMun   ', 01, 60, 1, xMun, DSC_XMUN);
  Gerador.wCampo(tcInt, 'B43', 'CEP    ', 08, 08, 0, CTe.Ide.Toma4.EnderToma.CEP, DSC_CEP);
  Gerador.wCampo(tcStr, 'B44', 'UF     ', 02, 02, 1, xUF, DSC_UF);
  if not ValidarUF(xUF) then
    Gerador.wAlerta('B44', 'UF', DSC_UF, ERR_MSG_INVALIDO);
  Gerador.wCampo(tcInt, 'B45', 'cPais  ', 04, 04, 0, CODIGO_BRASIL, DSC_CPAIS); // Conforme NT-2009/01
  Gerador.wCampo(tcStr, 'B46', 'xPais  ', 01, 60, 0, CTe.Ide.Toma4.EnderToma.xPais, DSC_XPAIS);
  Gerador.wGrupo('/enderToma');
end;

procedure TCTeW.GerarCompl;
begin
  Gerador.wGrupo('compl', 'C01');//compl
  Gerador.wCampo(tcStr, 'C02', 'xCaracAd    ', 01, 15, 0, CTe.Compl.xCaracAd, '');
  Gerador.wCampo(tcStr, 'C03', 'xCaracSer   ', 01, 30, 0, CTe.Compl.xCaracSer, '');
  Gerador.wCampo(tcStr, 'C04', 'xEmi        ', 01, 20, 0, CTe.Compl.xEmi, '');

  (**)GerarFluxo;

  if (CTe.Compl.Entrega.TipoData>=0) and (CTe.Compl.Entrega.TipoHora>=0)
   then (**)GerarEntrega;

  Gerador.wCampo(tcStr, 'C26', 'origCalc    ', 01, 40, 0, CTe.Compl.origCalc, DSC_ORIGCALC);
  Gerador.wCampo(tcStr, 'C27', 'destCalc    ', 01, 40, 0, CTe.Compl.destCalc, DSC_DESTCALC);
  Gerador.wCampo(tcStr, 'C28', 'xObs        ', 01, 2000, 0, CTe.Compl.xObs, DSC_XOBS);

  (**)GerarObsCont;
  (**)GerarObsFisco;

  Gerador.wGrupo('/compl');
end;

procedure TCTeW.GerarFluxo;
var
  i: integer;
begin
 if (CTe.Compl.fluxo.xOrig<>'') or (CTe.Compl.fluxo.pass.Count>0) or
    (CTe.Compl.fluxo.xDest<>'') or (CTe.Compl.fluxo.xRota<>'')
  then begin
   Gerador.wGrupo('fluxo', 'C05');//fluxo
   Gerador.wCampo(tcStr, 'C06', 'xOrig    ', 01, 15, 0, CTe.Compl.fluxo.xOrig, '');

   for i := 0 to CTe.Compl.fluxo.pass.Count - 1 do
   begin
    Gerador.wGrupo('pass', 'C07');
    Gerador.wCampo(tcStr, 'C08', 'xPass ', 01, 15, 1, CTe.Compl.fluxo.pass[i].xPass, '');
    Gerador.wGrupo('/pass');
   end;
   if CTe.Compl.fluxo.pass.Count > 990 then
    Gerador.wAlerta('C07', 'pass', '', ERR_MSG_MAIOR_MAXIMO + '990');

   Gerador.wCampo(tcStr, 'C09', 'xDest    ', 01, 15, 0, CTe.Compl.fluxo.xDest, '');
   Gerador.wCampo(tcStr, 'C10', 'xRota    ', 01, 10, 0, CTe.Compl.fluxo.xRota, '');
   Gerador.wGrupo('/fluxo');
  end;
end;

procedure TCTeW.GerarEntrega;
begin
  Gerador.wGrupo('Entrega', 'C11');//Entrega

  case CTe.Compl.Entrega.TipoData of
   0: begin
       Gerador.wGrupo('semData', 'C12');
       Gerador.wCampo(tcInt, 'C13', 'tpPer  ', 01, 01, 1, CTe.Compl.Entrega.semData.tpPer, '');
       Gerador.wGrupo('/semData');
      end;
  1,2,3: begin
          Gerador.wGrupo('comData', 'C14');
          Gerador.wCampo(tcInt, 'C15', 'tpPer  ', 01, 01, 1, CTe.Compl.Entrega.comData.tpPer, '');
          Gerador.wCampo(tcDat, 'C16', 'dProg  ', 10, 10, 1, CTe.Compl.Entrega.comData.dProg, '');
          Gerador.wGrupo('/comData');
         end;
   4: begin
       Gerador.wGrupo('noPeriodo', 'C17');
       Gerador.wCampo(tcInt, 'C18', 'tpPer ', 01, 01, 1, CTe.Compl.Entrega.noPeriodo.tpPer, '');
       Gerador.wCampo(tcDat, 'C19', 'dIni  ', 10, 10, 1, CTe.Compl.Entrega.noPeriodo.dIni, '');
       Gerador.wCampo(tcDat, 'C20', 'dFim  ', 10, 10, 1, CTe.Compl.Entrega.noPeriodo.dFim, '');
       Gerador.wGrupo('/noPeriodo');
      end;
  end;

  case CTe.Compl.Entrega.TipoHora of
   0: begin
       Gerador.wGrupo('semHora', 'C21');
       Gerador.wCampo(tcInt, 'C22', 'tpHor    ', 01, 01, 1, CTe.Compl.Entrega.semHora.tpHor, '');
       Gerador.wGrupo('/semHora');
      end;
  1,2,3: begin
          Gerador.wGrupo('comHora', 'C23');
          Gerador.wCampo(tcInt, 'C24', 'tpHor    ', 01, 01, 1, CTe.Compl.Entrega.comHora.tpHor, '');
          Gerador.wCampo(tcStr, 'C25', 'hProg    ', 08, 08, 1, TimeToStr(CTe.Compl.Entrega.comHora.hProg), '');
          Gerador.wGrupo('/comHora');
         end;
   4: begin
       Gerador.wGrupo('noInter', 'C25a');
       Gerador.wCampo(tcInt, 'C25b', 'tphor    ', 01, 01, 1, CTe.Compl.Entrega.noInter.tpHor, '');
       Gerador.wCampo(tcStr, 'C25c', 'hIni     ', 08, 08, 1, TimeToStr(CTe.Compl.Entrega.noInter.hIni), '');
       Gerador.wCampo(tcStr, 'C25d', 'hFim     ', 08, 08, 1, TimeToStr(CTe.Compl.Entrega.noInter.hFim), '');
       Gerador.wGrupo('/noInter');
      end;
  end;

  Gerador.wGrupo('/Entrega');
end;

procedure TCTeW.GerarObsCont;
var
  i: integer;
begin
  for i := 0 to CTe.Compl.ObsCont.Count - 1 do
  begin
   Gerador.wGrupo('ObsCont xCampo="' + CTe.Compl.ObsCont[i].xCampo + '"', 'C29');
   Gerador.wCampo(tcStr, 'C30', 'xTexto ', 01, 160, 1, CTe.Compl.ObsCont[i].xTexto, 'xTexto do ObsCont');
   Gerador.wGrupo('/ObsCont');
  end;
  if CTe.Compl.ObsCont.Count > 10 then
    Gerador.wAlerta('C29', 'ObsCont', 'Obs do Contribuinte', ERR_MSG_MAIOR_MAXIMO + '10');
end;

procedure TCTeW.GerarObsFisco;
var
  i: integer;
begin
  for i := 0 to CTe.Compl.ObsFisco.Count - 1 do
  begin
   Gerador.wGrupo('ObsFisco xCampo="' + CTe.Compl.ObsFisco[i].xCampo + '"', 'C32');
   Gerador.wCampo(tcStr, 'C33', 'xTexto ', 01, 60, 1, CTe.Compl.ObsFisco[i].xTexto, 'xTexto do ObsFisco');
   Gerador.wGrupo('/ObsFisco');
  end;
  if CTe.Compl.ObsFisco.Count > 10 then
    Gerador.wAlerta('C32', 'ObsFisco', 'Obs ao Fisco', ERR_MSG_MAIOR_MAXIMO + '10');
end;

procedure TCTeW.GerarEmit;
begin
  Gerador.wGrupo('emit', 'D01');
  Gerador.wCampoCNPJ('D02', CTe.Emit.CNPJ, CTe.Emit.enderEmit.cPais, True);
  Gerador.wCampo(tcStr, 'D03', 'IE     ', 02, 14, 1, SomenteNumeros(CTe.Emit.IE), DSC_IE);
  Gerador.wCampo(tcStr, 'D04', 'xNome  ', 01, 60, 1, CTe.Emit.xNome, DSC_XNOME);
  Gerador.wCampo(tcStr, 'D05', 'xFant  ', 01, 60, 0, CTe.Emit.xFant, DSC_XFANT);

  (**)GerarEnderEmit;
  Gerador.wGrupo('/emit');
end;

procedure TCTeW.GerarEnderEmit;
var
  cMun: integer;
  xMun: string;
  xUF: string;
begin
  AjustarMunicipioUF(xUF, xMun, cMun, CTe.Emit.enderEmit.cPais, CTe.Emit.enderEmit.UF, CTe.Emit.enderEmit.xMun, CTe.Emit.EnderEmit.cMun);
  Gerador.wGrupo('enderEmit', 'D06');
  Gerador.wCampo(tcStr, 'D07', 'xLgr   ', 01, 60, 1, CTe.Emit.enderEmit.xLgr, DSC_XLGR);
  Gerador.wCampo(tcStr, 'D08', 'nro    ', 01, 60, 1, ExecutarAjusteTagNro(FOpcoes.FAjustarTagNro, CTe.Emit.enderEmit.nro), DSC_NRO);
  Gerador.wCampo(tcStr, 'D09', 'xCpl   ', 01, 60, 0, CTe.Emit.enderEmit.xCpl, DSC_XCPL);
  Gerador.wCampo(tcStr, 'D10', 'xBairro', 01, 60, 1, CTe.Emit.enderEmit.xBairro, DSC_XBAIRRO);
  Gerador.wCampo(tcInt, 'D11', 'cMun   ', 07, 07, 1, cMun, DSC_CMUN);
  if not ValidarMunicipio(CTe.Emit.EnderEmit.cMun) then
    Gerador.wAlerta('D11', 'cMun', DSC_CMUN, ERR_MSG_INVALIDO);
  Gerador.wCampo(tcStr, 'D12', 'xMun   ', 01, 60, 1, xMun, DSC_XMUN);
  Gerador.wCampo(tcInt, 'D13', 'CEP    ', 08, 08, 0, CTe.Emit.enderEmit.CEP, DSC_CEP);
  Gerador.wCampo(tcStr, 'D14', 'UF     ', 02, 02, 1, xUF, DSC_UF);
  if not ValidarUF(xUF) then
    Gerador.wAlerta('D14', 'UF', DSC_UF, ERR_MSG_INVALIDO);
  Gerador.wCampo(tcInt, 'D15', 'cPais  ', 04, 04, 0, CODIGO_BRASIL, DSC_CPAIS); // Conforme NT-2009/01
  Gerador.wCampo(tcStr, 'D16', 'xPais  ', 01, 60, 0, CTe.Emit.enderEmit.xPais, DSC_XPAIS);
  Gerador.wCampo(tcStr, 'D17', 'fone   ', 07, 12, 0, somenteNumeros(CTe.Emit.EnderEmit.fone), DSC_FONE);
  Gerador.wGrupo('/enderEmit');
end;

procedure TCTeW.GerarRem;
begin
  Gerador.wGrupo('rem', 'E01');
  Gerador.wCampoCNPJCPF('E02', 'E03', CTe.Rem.CNPJCPF, CODIGO_BRASIL);
  Gerador.wCampo(tcStr, 'E04', 'IE     ', 00, 14, 1, SomenteNumeros(CTe.Rem.IE), DSC_IE);
  Gerador.wCampo(tcStr, 'E05', 'xNome  ', 01, 60, 1, CTe.Rem.xNome, DSC_XNOME);
  Gerador.wCampo(tcStr, 'E06', 'xFant  ', 01, 60, 0, CTe.Rem.xFant, DSC_XFANT);
  Gerador.wCampo(tcStr, 'E06', 'fone   ', 07, 12, 0, somenteNumeros(CTe.Rem.fone), DSC_FONE);

  (**)GerarEnderReme;
  (**)GerarInfNF;
  (**)GerarInfNFE;
  (**)GerarInfOutros;
  Gerador.wGrupo('/rem');
end;

procedure TCTeW.GerarEnderReme;
var
  cMun: integer;
  xMun: string;
  xUF: string;
begin
  AjustarMunicipioUF(xUF, xMun, cMun, CTe.Rem.EnderReme.cPais, CTe.Rem.EnderReme.UF, CTe.Rem.EnderReme.xMun, CTe.Rem.EnderReme.cMun);
  Gerador.wGrupo('enderReme', 'E07');
  Gerador.wCampo(tcStr, 'E08', 'xLgr   ', 01, 255, 1, CTe.Rem.EnderReme.xLgr, DSC_XLGR);
  Gerador.wCampo(tcStr, 'E09', 'nro    ', 01, 60, 1, ExecutarAjusteTagNro(FOpcoes.FAjustarTagNro, CTe.Rem.EnderReme.nro), DSC_NRO);
  Gerador.wCampo(tcStr, 'E10', 'xCpl   ', 01, 60, 0, CTe.Rem.EnderReme.xCpl, DSC_XCPL);
  Gerador.wCampo(tcStr, 'E11', 'xBairro', 01, 60, 1, CTe.Rem.EnderReme.xBairro, DSC_XBAIRRO);
  Gerador.wCampo(tcInt, 'E12', 'cMun   ', 07, 07, 1, cMun, DSC_CMUN);
  if not ValidarMunicipio(CTe.Rem.EnderReme.cMun) then
    Gerador.wAlerta('E12', 'cMun', DSC_CMUN, ERR_MSG_INVALIDO);
  Gerador.wCampo(tcStr, 'E13', 'xMun   ', 01, 60, 1, xMun, DSC_XMUN);
  Gerador.wCampo(tcInt, 'E14', 'CEP    ', 08, 08, 0, CTe.Rem.EnderReme.CEP, DSC_CEP);
  Gerador.wCampo(tcStr, 'E15', 'UF     ', 02, 02, 1, xUF, DSC_UF);
  if not ValidarUF(xUF) then
    Gerador.wAlerta('E15', 'UF', DSC_UF, ERR_MSG_INVALIDO);
  Gerador.wCampo(tcInt, 'E16', 'cPais  ', 04, 04, 0, CODIGO_BRASIL, DSC_CPAIS); // Conforme NT-2009/01
  Gerador.wCampo(tcStr, 'E17', 'xPais  ', 01, 60, 0, CTe.Rem.EnderReme.xPais, DSC_XPAIS);
  Gerador.wGrupo('/enderReme');
end;

procedure TCTeW.GerarInfNF;
var
  i: integer;
begin
  for i := 0 to CTe.Rem.InfNF.Count - 1 do
  begin
    Gerador.wGrupo('infNF', 'E19');
    Gerador.wCampo(tcStr, 'E20', 'nRoma ', 01, 20, 0, CTe.Rem.InfNF[i].nRoma, '');
    Gerador.wCampo(tcStr, 'E21', 'nPed  ', 01, 20, 0, CTe.Rem.InfNF[i].nPed, '');
    Gerador.wCampo(tcStr, 'E22', 'serie ', 01, 03, 1, CTe.Rem.InfNF[i].serie, DSC_SERIE);
    Gerador.wCampo(tcEsp, 'E23', 'nDoc  ', 01, 20, 1, SomenteNumeros(CTe.Rem.InfNF[i].nDoc), DSC_NDOC);
    Gerador.wCampo(tcDat, 'E24', 'dEmi  ', 10, 10, 1, CTe.Rem.InfNF[i].dEmi, DSC_DEMI);
    Gerador.wCampo(tcDe2, 'E25', 'vBC   ', 01, 15, 1, CTe.Rem.InfNF[i].vBC, DSC_VBCICMS);
    Gerador.wCampo(tcDe2, 'E26', 'vICMS ', 01, 15, 1, CTe.Rem.InfNF[i].vICMS, DSC_VICMS);
    Gerador.wCampo(tcDe2, 'E27', 'vBCST ', 01, 15, 1, CTe.Rem.InfNF[i].vBCST, DSC_VBCST);
    Gerador.wCampo(tcDe2, 'E28', 'vST   ', 01, 15, 1, CTe.Rem.InfNF[i].vST, DSC_VST);
    Gerador.wCampo(tcDe2, 'E29', 'vProd ', 01, 15, 1, CTe.Rem.InfNF[i].vProd, DSC_VPROD);
    Gerador.wCampo(tcDe2, 'E30', 'vNF   ', 01, 15, 1, CTe.Rem.InfNF[i].vNF, DSC_VNF);
    Gerador.wCampo(tcInt, 'E31', 'nCFOP ', 04, 04, 1, CTe.Rem.InfNF[i].nCFOP, DSC_CFOP);
    Gerador.wCampo(tcDe3, 'E32', 'nPeso ', 01, 15, 0, CTe.Rem.InfNF[i].nPeso, DSC_PESO);
    Gerador.wCampo(tcStr, 'E33', 'PIN   ', 02, 09, 0, CTe.Rem.InfNF[i].PIN, DSC_ISUF);
    if (FOpcoes.ValidarInscricoes) and (CTe.Rem.InfNF[i].PIN <> '') then
      if not ValidarISUF(CTe.Rem.InfNF[i].PIN) then
        Gerador.wAlerta('E33', 'PIN', DSC_ISUF, ERR_MSG_INVALIDO);

    if (CTe.Rem.InfNF[i].locRet.CNPJCPF <> '') or
       (CTe.Rem.InfNF[i].locRet.xNome <> '') then
    begin
      Gerador.wGrupo('locRet', 'E34');
      Gerador.wCampoCNPJCPF('E35', 'E36', CTe.Rem.InfNF[i].locRet.CNPJCPF, CODIGO_BRASIL);
      Gerador.wCampo(tcStr, 'E37', 'xNome  ', 01, 60, 1, CTe.Rem.InfNF[i].locRet.xNome, DSC_XNOME);
      Gerador.wCampo(tcStr, 'E38', 'xLgr   ', 01, 255, 1, CTe.Rem.InfNF[i].locRet.xLgr, DSC_XLGR);
      Gerador.wCampo(tcStr, 'E39', 'nro    ', 01, 60, 1, ExecutarAjusteTagNro(FOpcoes.FAjustarTagNro, CTe.Rem.InfNF[i].locRet.nro), DSC_NRO);
      Gerador.wCampo(tcStr, 'E40', 'xCpl   ', 01, 60, 0, CTe.Rem.InfNF[i].locRet.xCpl, DSC_XCPL);
      Gerador.wCampo(tcStr, 'E41', 'xBairro', 01, 60, 1, CTe.Rem.InfNF[i].locRet.xBairro, DSC_XBAIRRO);
      Gerador.wCampo(tcInt, 'E42', 'cMun   ', 07, 07, 1, CTe.Rem.InfNF[i].locRet.cMun, DSC_CMUN);
      if not ValidarMunicipio(CTe.Rem.InfNF[i].locRet.cMun) then
        Gerador.wAlerta('E42', 'cMun', DSC_CMUN, ERR_MSG_INVALIDO);
      Gerador.wCampo(tcStr, 'E43', 'xMun   ', 01, 60, 1, CTe.Rem.InfNF[i].locRet.xMun, DSC_XMUN);
      Gerador.wCampo(tcStr, 'E44', 'UF     ', 02, 02, 1, CTe.Rem.InfNF[i].locRet.UF, DSC_UF);
      if not ValidarUF(CTe.Rem.InfNF[i].locRet.UF) then
        Gerador.wAlerta('E44', 'UF', DSC_UF, ERR_MSG_INVALIDO);
      Gerador.wGrupo('/locRet');
    end;

    Gerador.wGrupo('/infNF');
  end;
  if CTe.Rem.InfNF.Count > 990 then
    Gerador.wAlerta('E19', 'nItem', DSC_INFNF, ERR_MSG_MAIOR_MAXIMO + '990');
end;

procedure TCTeW.GerarInfNFE;
var
  i: integer;
begin
  for i := 0 to CTe.Rem.InfNFE.Count - 1 do
  begin
    Gerador.wGrupo('infNFe', 'E45');
    Gerador.wCampo(tcEsp, 'E46', 'chave', 44, 44, 1, SomenteNumeros(CTe.Rem.InfNFE[i].chave), DSC_REFNFE);
    if not ValidarChave('NFe' + SomenteNumeros(CTe.Rem.InfNFE[i].chave)) then
      Gerador.wAlerta('E46', 'chave', DSC_REFNFE, ERR_MSG_INVALIDO);

    Gerador.wCampo(tcStr, 'E47', 'PIN   ', 02, 09, 0, CTe.Rem.InfNFE[i].PIN, DSC_ISUF);
    if (FOpcoes.ValidarInscricoes) and (CTe.Rem.InfNFE[i].PIN <> '') then
      if not ValidarISUF(CTe.Rem.InfNFE[i].PIN) then
        Gerador.wAlerta('E47', 'PIN', DSC_ISUF, ERR_MSG_INVALIDO);

    Gerador.wGrupo('/infNFe');
  end;
  if CTe.Rem.InfNFE.Count > 990 then
    Gerador.wAlerta('E45', 'nItem', DSC_INFNFE, ERR_MSG_MAIOR_MAXIMO + '990');
end;

procedure TCTeW.GerarInfOutros;
var
  i: integer;
begin
  for i := 0 to CTe.Rem.InfOutros.Count - 1 do
  begin
    Gerador.wGrupo('infOutros', 'E48');
    Gerador.wCampo(tcStr, 'E49', 'tpDoc       ', 02, 02, 1, SomenteNumeros(CTe.Rem.InfOutros[i].tpDoc), DSC_TPDOC);
    Gerador.wCampo(tcStr, 'E50', 'descOutros  ', 01, 60, 0, CTe.Rem.InfOutros[i].descOutros, DSC_OUTROS);
    Gerador.wCampo(tcStr, 'E51', 'nDoc        ', 01, 20, 0, CTe.Rem.InfOutros[i].nDoc, DSC_NRO);
    Gerador.wCampo(tcDat, 'E52', 'dEmi        ', 10, 10, 1, CTe.Rem.InfOutros[i].dEmi, DSC_DEMI);
    Gerador.wCampo(tcDe2, 'E53', 'vDocFisc    ', 01, 15, 0, CTe.Rem.InfOutros[i].vDocFisc, DSC_VDOC);
    Gerador.wGrupo('/infOutros');
  end;
  if CTe.Rem.InfOutros.Count > 990 then
    Gerador.wAlerta('E48', 'infOutros', DSC_INFOUTRO, ERR_MSG_MAIOR_MAXIMO + '990');
end;

procedure TCTeW.GerarExped;
begin
  if (CTe.Exped.CNPJCPF <> '') or
     (CTe.Exped.xNome <> '') then
  begin
    Gerador.wGrupo('exped', 'F01');
    Gerador.wCampoCNPJCPF('F02', 'F03', CTe.Exped.CNPJCPF, CODIGO_BRASIL);
    Gerador.wCampo(tcStr, 'F04', 'IE     ', 00, 14, 1, SomenteNumeros(CTe.Exped.IE), DSC_IE);
    Gerador.wCampo(tcStr, 'F05', 'xNome  ', 01, 60, 1, CTe.Exped.xNome, DSC_XNOME);
    Gerador.wCampo(tcStr, 'F06', 'fone   ', 07, 12, 0, somenteNumeros(CTe.Exped.fone), DSC_FONE);

    (**)GerarEnderExped;
    Gerador.wGrupo('/exped');
  end;
end;

procedure TCTeW.GerarEnderExped;
var
  cMun: integer;
  xMun: string;
  xUF: string;
begin
  AjustarMunicipioUF(xUF, xMun, cMun, CTe.Exped.EnderExped.cPais, CTe.Emit.enderEmit.UF, CTe.Exped.EnderExped.xMun, CTe.Exped.EnderExped.cMun);
  Gerador.wGrupo('enderExped', 'F07');
  Gerador.wCampo(tcStr, 'F08', 'xLgr   ', 01, 255, 1, CTe.Exped.EnderExped.xLgr, DSC_XLGR);
  Gerador.wCampo(tcStr, 'F09', 'nro    ', 01, 60, 1, ExecutarAjusteTagNro(FOpcoes.FAjustarTagNro, CTe.Exped.EnderExped.nro), DSC_NRO);
  Gerador.wCampo(tcStr, 'F10', 'xCpl   ', 01, 60, 0, CTe.Exped.EnderExped.xCpl, DSC_XCPL);
  Gerador.wCampo(tcStr, 'F11', 'xBairro', 01, 60, 1, CTe.Exped.EnderExped.xBairro, DSC_XBAIRRO);
  Gerador.wCampo(tcInt, 'F12', 'cMun   ', 07, 07, 1, cMun, DSC_CMUN);
  if not ValidarMunicipio(CTe.Exped.EnderExped.cMun) then
    Gerador.wAlerta('F12', 'cMun', DSC_CMUN, ERR_MSG_INVALIDO);
  Gerador.wCampo(tcStr, 'F13', 'xMun   ', 01, 60, 1, xMun, DSC_XMUN);
  Gerador.wCampo(tcInt, 'F14', 'CEP    ', 08, 08, 0, CTe.Exped.EnderExped.CEP, DSC_CEP);
  Gerador.wCampo(tcStr, 'F15', 'UF     ', 02, 02, 1, xUF, DSC_UF);
  if not ValidarUF(xUF) then
    Gerador.wAlerta('F15', 'UF', DSC_UF, ERR_MSG_INVALIDO);
  Gerador.wCampo(tcInt, 'F16', 'cPais  ', 04, 04, 0, CODIGO_BRASIL, DSC_CPAIS); // Conforme NT-2009/01
  Gerador.wCampo(tcStr, 'F17', 'xPais  ', 01, 60, 0, CTe.Exped.EnderExped.xPais, DSC_XPAIS);
  Gerador.wGrupo('/enderExped');
end;

procedure TCTeW.GerarReceb;
begin
  if (CTe.Receb.CNPJCPF <> '') or
     (CTe.Receb.xNome <> '') then
  Begin
    Gerador.wGrupo('receb', 'G01');
    Gerador.wCampoCNPJCPF('G02', 'G03', CTe.Receb.CNPJCPF, CODIGO_BRASIL);
    Gerador.wCampo(tcStr, 'G04', 'IE     ', 00, 14, 1, SomenteNumeros(CTe.Receb.IE), DSC_IE);
    Gerador.wCampo(tcStr, 'G05', 'xNome  ', 01, 60, 1, CTe.Receb.xNome, DSC_XNOME);
    Gerador.wCampo(tcStr, 'G06', 'fone   ', 07, 12, 0, somenteNumeros(CTe.Receb.fone), DSC_FONE);

    (**)GerarEnderReceb;
    Gerador.wGrupo('/receb');
  end;
end;

procedure TCTeW.GerarEnderReceb;
var
  cMun: integer;
  xMun: string;
  xUF: string;
begin
  AjustarMunicipioUF(xUF, xMun, cMun, CTe.Receb.EnderReceb.cPais, CTe.Receb.EnderReceb.UF, CTe.Receb.EnderReceb.xMun, CTe.Receb.EnderReceb.cMun);
  Gerador.wGrupo('enderReceb', 'G07');
  Gerador.wCampo(tcStr, 'G08', 'xLgr   ', 01, 255, 1, CTe.Receb.EnderReceb.xLgr, DSC_XLGR);
  Gerador.wCampo(tcStr, 'G09', 'nro    ', 01, 60, 1, ExecutarAjusteTagNro(FOpcoes.FAjustarTagNro, CTe.Receb.EnderReceb.nro), DSC_NRO);
  Gerador.wCampo(tcStr, 'G10', 'xCpl   ', 01, 60, 0, CTe.Receb.EnderReceb.xCpl, DSC_XCPL);
  Gerador.wCampo(tcStr, 'G11', 'xBairro', 01, 60, 1, CTe.Receb.EnderReceb.xBairro, DSC_XBAIRRO);
  Gerador.wCampo(tcInt, 'G12', 'cMun   ', 07, 07, 1, cMun, DSC_CMUN);
  if not ValidarMunicipio(CTe.Receb.EnderReceb.cMun) then
    Gerador.wAlerta('G12', 'cMun', DSC_CMUN, ERR_MSG_INVALIDO);
  Gerador.wCampo(tcStr, 'G13', 'xMun   ', 01, 60, 1, xMun, DSC_XMUN);
  Gerador.wCampo(tcInt, 'G14', 'CEP    ', 08, 08, 0, CTe.Receb.EnderReceb.CEP, DSC_CEP);
  Gerador.wCampo(tcStr, 'G15', 'UF     ', 02, 02, 1, xUF, DSC_UF);
  if not ValidarUF(xUF) then
    Gerador.wAlerta('G15', 'UF', DSC_UF, ERR_MSG_INVALIDO);
  Gerador.wCampo(tcInt, 'G16', 'cPais  ', 04, 04, 0, CODIGO_BRASIL, DSC_CPAIS); // Conforme NT-2009/01
  Gerador.wCampo(tcStr, 'G17', 'xPais  ', 01, 60, 0, CTe.Receb.EnderReceb.xPais, DSC_XPAIS);
  Gerador.wGrupo('/enderReceb');
end;

procedure TCTeW.GerarDest;
begin
  Gerador.wGrupo('dest', 'H01');
  Gerador.wCampoCNPJCPF('H02', 'H03', CTe.Dest.CNPJCPF, CODIGO_BRASIL);
  Gerador.wCampo(tcStr, 'H04', 'IE     ', 00, 14, 0, SomenteNumeros(CTe.Dest.IE), DSC_IE);
  Gerador.wCampo(tcStr, 'H05', 'xNome  ', 01, 60, 1, CTe.Dest.xNome, DSC_XNOME);
  Gerador.wCampo(tcStr, 'H06', 'fone   ', 07, 12, 0, somenteNumeros(CTe.Dest.fone), DSC_FONE);
  Gerador.wCampo(tcStr, 'H07', 'ISUF   ', 08, 09, 0, CTe.Dest.ISUF, DSC_ISUF);
  if (FOpcoes.ValidarInscricoes) and (CTe.Dest.ISUF <> '') then
    if not ValidarISUF(CTe.Dest.ISUF) then
      Gerador.wAlerta('H07', 'ISUF', DSC_ISUF, ERR_MSG_INVALIDO);

  (**)GerarEnderDest;
  (**)GerarLocEnt;
  Gerador.wGrupo('/dest');
end;

procedure TCTeW.GerarEnderDest;
var
  cMun: integer;
  xMun: string;
  xUF: string;
begin
  AjustarMunicipioUF(xUF, xMun, cMun, CTe.Dest.EnderDest.cPais, CTe.Dest.EnderDest.UF, CTe.Dest.EnderDest.xMun, CTe.Dest.EnderDest.cMun);
  Gerador.wGrupo('enderDest', 'H08');
  Gerador.wCampo(tcStr, 'H09', 'xLgr   ', 01, 255, 1, CTe.Dest.EnderDest.xLgr, DSC_XLGR);
  Gerador.wCampo(tcStr, 'H10', 'nro    ', 01, 60, 1, ExecutarAjusteTagNro(FOpcoes.FAjustarTagNro, CTe.Dest.EnderDest.nro), DSC_NRO);
  Gerador.wCampo(tcStr, 'H11', 'xCpl   ', 01, 60, 0, CTe.Dest.EnderDest.xCpl, DSC_XCPL);
  Gerador.wCampo(tcStr, 'H12', 'xBairro', 01, 60, 1, CTe.Dest.EnderDest.xBairro, DSC_XBAIRRO);
  Gerador.wCampo(tcInt, 'H13', 'cMun   ', 07, 07, 1, cMun, DSC_CMUN);
  if not ValidarMunicipio(CTe.Dest.EnderDest.cMun) then
    Gerador.wAlerta('H13', 'cMun', DSC_CMUN, ERR_MSG_INVALIDO);
  Gerador.wCampo(tcStr, 'H14', 'xMun   ', 01, 60, 1, xMun, DSC_XMUN);
  Gerador.wCampo(tcInt, 'H15', 'CEP    ', 08, 08, 0, CTe.Dest.EnderDest.CEP, DSC_CEP);
  Gerador.wCampo(tcStr, 'H16', 'UF     ', 02, 02, 1, xUF, DSC_UF);
  if not ValidarUF(xUF) then
    Gerador.wAlerta('G16', 'UF', DSC_UF, ERR_MSG_INVALIDO);
  Gerador.wCampo(tcInt, 'H17', 'cPais  ', 04, 04, 0, CODIGO_BRASIL, DSC_CPAIS); // Conforme NT-2009/01
  Gerador.wCampo(tcStr, 'H18', 'xPais  ', 01, 60, 0, CTe.Dest.EnderDest.xPais, DSC_XPAIS);
  Gerador.wGrupo('/enderDest');
end;

procedure TCTeW.GerarLocEnt;
begin
  if (CTe.Dest.locEnt.CNPJCPF <> '') or
     (CTe.Dest.locEnt.xNome <> '') then
  begin
    Gerador.wGrupo('locEnt', 'H19');
    Gerador.wCampoCNPJCPF('H20', 'H21', CTe.Dest.locEnt.CNPJCPF, CODIGO_BRASIL);
    Gerador.wCampo(tcStr, 'H22', 'xNome  ', 01, 60, 1, CTe.Dest.locEnt.xNome, DSC_XNOME);
    Gerador.wCampo(tcStr, 'H23', 'xLgr   ', 01, 255, 1, CTe.Dest.locEnt.xLgr, DSC_XLGR);
    Gerador.wCampo(tcStr, 'H24', 'nro    ', 01, 60, 1, ExecutarAjusteTagNro(FOpcoes.FAjustarTagNro, CTe.Dest.locEnt.nro), DSC_NRO);
    Gerador.wCampo(tcStr, 'H25', 'xCpl   ', 01, 60, 0, CTe.Dest.locEnt.xCpl, DSC_XCPL);
    Gerador.wCampo(tcStr, 'H26', 'xBairro', 01, 60, 1, CTe.Dest.locEnt.xBairro, DSC_XBAIRRO);
    Gerador.wCampo(tcInt, 'H27', 'cMun   ', 07, 07, 1, CTe.Dest.locEnt.cMun, DSC_CMUN);
    if not ValidarMunicipio(CTe.Dest.locEnt.cMun) then
      Gerador.wAlerta('H27', 'cMun', DSC_CMUN, ERR_MSG_INVALIDO);
    Gerador.wCampo(tcStr, 'H28', 'xMun   ', 01, 60, 1, CTe.Dest.locEnt.xMun, DSC_XMUN);
    Gerador.wCampo(tcStr, 'H29', 'UF     ', 02, 02, 1, CTe.Dest.locEnt.UF, DSC_UF);
    if not ValidarUF(CTe.Dest.locEnt.UF) then
      Gerador.wAlerta('H29', 'UF', DSC_UF, ERR_MSG_INVALIDO);
    Gerador.wGrupo('/locEnt');
  end;
end;

procedure TCTeW.GerarVPrest;
begin
  Gerador.wGrupo('vPrest', 'I01');
  Gerador.wCampo(tcDe2, 'I02', 'vTPrest ', 01, 15, 1, CTe.vPrest.vTPrest, DSC_VTPREST);
  Gerador.wCampo(tcDe2, 'I03', 'vRec    ', 01, 15, 1, CTe.vPrest.vRec, DSC_VREC);

  (**)GerarComp;
  Gerador.wGrupo('/vPrest');
end;

procedure TCTeW.GerarComp;
var
  i: integer;
begin
  for i := 0 to CTe.vPrest.comp.Count - 1 do
  begin
    if (CTe.vPrest.comp[i].xNome <> '') and
      (CTe.vPrest.comp[i].vComp <> 0) then
      begin
        Gerador.wGrupo('Comp', 'I03');
        Gerador.wCampo(tcStr, 'I04', 'xNome ', 01, 15, 1, CTe.vPrest.comp[i].xNome, DSC_XNOMEC);
        Gerador.wCampo(tcDe2, 'I05', 'vComp ', 01, 15, 1, CTe.vPrest.comp[i].vComp, DSC_VCOMP);
        Gerador.wGrupo('/Comp');
      end;
  end;
end;

procedure TCTeW.GerarImp;
begin
  Gerador.wGrupo('imp', 'J01');
  (**)GerarICMS;
  Gerador.wCampo(tcStr, 'J80', 'infAdFisco ', 01, 255, 0, CTe.Imp.InfAdFisco, DSC_INFADFISCO);
  Gerador.wGrupo('/imp');
end;

procedure TCTeW.GerarICMS;
begin
  Gerador.wGrupo('ICMS', 'J10');

  if CTe.Imp.ICMS.SituTrib = cst00 then
    (**)GerarCST00
  else if CTe.Imp.ICMS.SituTrib = cst20 then
    (**)GerarCST20
  else if ((CTe.Imp.ICMS.SituTrib = cst40) or
           (CTe.Imp.ICMS.SituTrib = cst41) or
           (CTe.Imp.ICMS.SituTrib = cst51)) then
    (**)GerarCST45
  else if CTe.Imp.ICMS.SituTrib = cst80 then
    (**)GerarCST80
  else if CTe.Imp.ICMS.SituTrib = cst81 then
    (**)GerarCST81
  else if CTe.Imp.ICMS.SituTrib = cst90 then
    (**)GerarCST90;

  Gerador.wGrupo('/ICMS');
end;

procedure TCTeW.GerarCST00;
begin
  Gerador.wGrupo('CST00', 'J11');
  Gerador.wCampo(tcStr, 'J30', 'CST     ', 02, 02, 1, CSTICMSTOStr(CTe.Imp.ICMS.CST00.CST), DSC_CST);
  Gerador.wCampo(tcDe2, 'J32', 'vBC     ', 01, 15, 1, CTe.Imp.ICMS.CST00.vBC, DSC_VBC);
  Gerador.wCampo(tcDe2, 'J33', 'pICMS   ', 01, 05, 1, CTe.Imp.ICMS.CST00.pICMS, DSC_PICMS);
  Gerador.wCampo(tcDe2, 'J34', 'vICMS   ', 01, 15, 1, CTe.Imp.ICMS.CST00.vICMS, DSC_VICMS);
  Gerador.wGrupo('/CST00');
end;

procedure TCTeW.GerarCST20;
begin
  Gerador.wGrupo('CST20', 'J12');
  Gerador.wCampo(tcStr, 'J30', 'CST     ', 02, 02, 1, CSTICMSTOStr(CTe.Imp.ICMS.CST20.CST), DSC_CST);
  Gerador.wCampo(tcDe2, 'J31', 'pRedBC   ', 01, 05, 1, CTe.Imp.ICMS.CST20.pRedBC, DSC_PREDBC);
  Gerador.wCampo(tcDe2, 'J32', 'vBC     ', 01, 15, 1, CTe.Imp.ICMS.CST20.vBC, DSC_VBC);
  Gerador.wCampo(tcDe2, 'J33', 'pICMS   ', 01, 05, 1, CTe.Imp.ICMS.CST20.pICMS, DSC_PICMS);
  Gerador.wCampo(tcDe2, 'J34', 'vICMS   ', 01, 15, 1, CTe.Imp.ICMS.CST20.vICMS, DSC_VICMS);
  Gerador.wGrupo('/CST20');
end;

procedure TCTeW.GerarCST45;
begin
  Gerador.wGrupo('CST45', 'J13');
  Gerador.wCampo(tcStr, 'J30', 'CST     ', 02, 02, 1, CSTICMSTOStr(CTe.Imp.ICMS.CST45.CST), DSC_CST);
  Gerador.wGrupo('/CST45');
end;

procedure TCTeW.GerarCST80;
begin
  Gerador.wGrupo('CST80', 'J14');
  Gerador.wCampo(tcStr, 'J30', 'CST     ', 02, 02, 1, CSTICMSTOStr(CTe.Imp.ICMS.CST80.CST), DSC_CST);
  Gerador.wCampo(tcDe2, 'J41', 'vBC     ', 01, 15, 1, CTe.Imp.ICMS.CST80.vBC, DSC_VBC);
  Gerador.wCampo(tcDe2, 'J42', 'pICMS   ', 01, 05, 1, CTe.Imp.ICMS.CST80.pICMS, DSC_PICMS);
  Gerador.wCampo(tcDe2, 'J43', 'vICMS   ', 01, 15, 1, CTe.Imp.ICMS.CST80.vICMS, DSC_VICMS);
  if CTe.Imp.ICMS.CST80.vCred > 0 then
   Gerador.wCampo(tcDe2, 'J44', 'vCred   ', 01, 15, 1, CTe.Imp.ICMS.CST80.vCred, DSC_VCRED);
  Gerador.wGrupo('/CST80');
end;

procedure TCTeW.GerarCST81;
begin
  Gerador.wGrupo('CST81', 'J15');
  Gerador.wCampo(tcStr, 'J30', 'CST     ', 02, 02, 1, CSTICMSTOStr(CTe.Imp.ICMS.CST81.CST), DSC_CST);
  if CTe.Imp.ICMS.CST81.pRedBC > 0 then
   Gerador.wCampo(tcDe2, 'J51', 'pRedBC   ', 01, 05, 1, CTe.Imp.ICMS.CST81.pRedBC, DSC_PREDBC);
  Gerador.wCampo(tcDe2, 'J52', 'vBC     ', 01, 15, 1, CTe.Imp.ICMS.CST81.vBC, DSC_VBC);
  Gerador.wCampo(tcDe2, 'J53', 'pICMS   ', 01, 05, 1, CTe.Imp.ICMS.CST81.pICMS, DSC_PICMS);
  Gerador.wCampo(tcDe2, 'J54', 'vICMS   ', 01, 15, 1, CTe.Imp.ICMS.CST81.vICMS, DSC_VICMS);
  Gerador.wGrupo('/CST81');
end;

procedure TCTeW.GerarCST90;
begin
  Gerador.wGrupo('CST90', 'J16');
  Gerador.wCampo(tcStr, 'J30', 'CST     ', 02, 02, 1, CSTICMSTOStr(CTe.Imp.ICMS.CST90.CST), DSC_CST);
  if CTe.Imp.ICMS.CST90.pRedBC > 0 then
    Gerador.wCampo(tcDe2, 'J31', 'pRedBC   ', 01, 05, 1, CTe.Imp.ICMS.CST90.pRedBC, DSC_PREDBC);
  Gerador.wCampo(tcDe2, 'J32', 'vBC     ', 01, 15, 1, CTe.Imp.ICMS.CST90.vBC, DSC_VBC);
  Gerador.wCampo(tcDe2, 'J33', 'pICMS   ', 01, 05, 1, CTe.Imp.ICMS.CST90.pICMS, DSC_PICMS);
  Gerador.wCampo(tcDe2, 'J34', 'vICMS   ', 01, 15, 1, CTe.Imp.ICMS.CST90.vICMS, DSC_VICMS);
  if CTe.Imp.ICMS.CST90.vCred > 0 then
    Gerador.wCampo(tcDe2, 'J35', 'vCred   ', 01, 15, 1, CTe.Imp.ICMS.CST90.vCred, DSC_VCRED);
  Gerador.wGrupo('/CST90');
end;

procedure TCTeW.GerarInfCTeNorm;
begin
  Gerador.wGrupo('infCTeNorm', 'K01');
  (**)GerarinfCarga;
  (**)GerarContQt;
  if CTe.infCTeNorm.emiDocAnt.Count>0
   then (**)GerarDocAnt;
  (**)GerarInfSeg;

  case StrToInt(TpModalToStr(CTe.Ide.modal)) of
   01: (**)GerarRodo; // Informações do Modal Rodoviário
   02: (**)GerarAereo;
   03: (**)GerarAquav;
   04: (**)GerarFerrov;
   05: (**)GerarDuto;
  end;

  (**)GerarPeri; // Informações de produtos classificados pela ONU como Perigosos
  (**)GerarVeicNovos;
  (**)GerarInfCTeSub;

  Gerador.wGrupo('/infCTeNorm');
end;

procedure TCTeW.GerarinfCarga;
begin
  Gerador.wGrupo('infCarga', 'K02');

  Gerador.wCampo(tcDe2, 'K03', 'vMerc   ', 01, 15, 1, CTe.InfCarga.vMerc, DSC_VTMERC);
  Gerador.wCampo(tcStr, 'K04', 'proPred ', 01, 60, 1, CTe.InfCarga.proPred, DSC_PRED);
  Gerador.wCampo(tcStr, 'K05', 'xOutCat ', 01, 30, 0, CTe.InfCarga.xOutCat, DSC_OUTCAT);

  (**)GerarInfQ;

  Gerador.wGrupo('/infCarga');
end;

procedure TCTeW.GerarInfQ;
var
  i: integer;
begin
  for i := 0 to CTe.InfCarga.InfQ.Count - 1 do
  begin
    Gerador.wGrupo('infQ', 'K06');
    Gerador.wCampo(tcStr, 'K07', 'cUnid  ', 02, 02, 1, UnidMedToStr(CTe.InfCarga.InfQ[i].cUnid), DSC_CUNID);
    Gerador.wCampo(tcStr, 'K08', 'tpMed  ', 01, 20, 1, CTe.InfCarga.InfQ[i].tpMed, DSC_TPMED);
    Gerador.wCampo(tcDe4, 'K09', 'qCarga ', 01, 15, 1, CTe.InfCarga.InfQ[i].qCarga, DSC_QTD);

    Gerador.wGrupo('/infQ');
  end;

  if CTe.InfCarga.InfQ.Count > 990 then
    Gerador.wAlerta('K06', 'infQ', DSC_INFQ, ERR_MSG_MAIOR_MAXIMO + '990');
end;

procedure TCTeW.GerarContQt;
var
  i, i01: integer;
begin
  for i := 0 to CTe.infCTeNorm.contQt.Count - 1 do
  begin
    Gerador.wGrupo('contQt', 'K10');
    Gerador.wCampo(tcInt, 'K11', 'nCont  ', 01, 20, 1, CTe.infCTeNorm.contQt[i].nCont, '');

    for i01 := 0 to CTe.infCTeNorm.contQt[i].lacContQt.Count - 1 do
    begin
      Gerador.wGrupo('lacContQt', 'K12');
      Gerador.wCampo(tcStr, 'K13', 'nLacre  ', 01, 20, 1, CTe.infCTeNorm.contQt[i].lacContQt[i01].nLacre, '');
      Gerador.wGrupo('/lacContQt');
    end;
    if CTe.infCTeNorm.contQt[i].lacContQt.Count > 990 then
      Gerador.wAlerta('K12', 'lacContQt', '', ERR_MSG_MAIOR_MAXIMO + '990');

    Gerador.wCampo(tcDat, 'K14', 'dPrev  ', 10, 10, 0, CTe.infCTeNorm.contQt[i].dPrev, '');
    Gerador.wGrupo('/contQt');
  end;
  if CTe.infCTeNorm.contQt.Count > 990 then
    Gerador.wAlerta('K10', 'contQt', '', ERR_MSG_MAIOR_MAXIMO + '990');
end;

procedure TCTeW.GerarDocAnt;
var
  i, i01, i02: integer;
begin
  Gerador.wGrupo('docAnt', 'K15');

  for i := 0 to CTe.infCTeNorm.emiDocAnt.Count - 1 do
  begin
    Gerador.wGrupo('emiDocAnt', 'K16');
    Gerador.wCampoCNPJCPF('K17', 'K18', CTe.infCTeNorm.emiDocAnt[i].CNPJCPF, CODIGO_BRASIL);
    Gerador.wCampo(tcStr, 'K19', 'IE     ', 02, 14, 1, CTe.infCTeNorm.emiDocAnt[i].IE, DSC_IE);
    Gerador.wCampo(tcStr, 'K20', 'UF     ', 02, 02, 1, CTe.infCTeNorm.emiDocAnt[i].UF, '');
    Gerador.wCampo(tcStr, 'K21', 'xNome  ', 01, 60, 1, CTe.infCTeNorm.emiDocAnt[i].xNome, '');

    for i01 := 0 to CTe.infCTeNorm.emiDocAnt[i].idDocAnt.Count - 1 do
    begin
      Gerador.wGrupo('idDocAnt', 'K22');

      for i02 := 0 to CTe.infCTeNorm.emiDocAnt[i].idDocAnt[i01].idDocAntPap.Count - 1 do
      begin
        Gerador.wGrupo('idDocAntPap', 'K23');
        Gerador.wCampo(tcInt, 'K24', 'tpDoc  ', 02, 02, 1, CTe.infCTeNorm.emiDocAnt[i].idDocAnt[i01].idDocAntPap[i02].tpDoc, '');
        Gerador.wCampo(tcStr, 'K25', 'serie  ', 01, 03, 1, CTe.infCTeNorm.emiDocAnt[i].idDocAnt[i01].idDocAntPap[i02].serie, '');
        Gerador.wCampo(tcStr, 'K26', 'subser ', 01, 02, 0, CTe.infCTeNorm.emiDocAnt[i].idDocAnt[i01].idDocAntPap[i02].subser, '');
        Gerador.wCampo(tcInt, 'K27', 'nDoc   ', 01, 20, 1, CTe.infCTeNorm.emiDocAnt[i].idDocAnt[i01].idDocAntPap[i02].nDoc, '');
        Gerador.wCampo(tcDat, 'K28', 'dEmi   ', 10, 10, 1, CTe.infCTeNorm.emiDocAnt[i].idDocAnt[i01].idDocAntPap[i02].dEmi, '');
        Gerador.wGrupo('/idDocAntPap');
      end;
      if CTe.infCTeNorm.emiDocAnt[i].idDocAnt[i01].idDocAntPap.Count > 990 then
        Gerador.wAlerta('K23', 'idDocAntPap', '', ERR_MSG_MAIOR_MAXIMO + '990');

      for i02 := 0 to CTe.infCTeNorm.emiDocAnt[i].idDocAnt[i01].idDocAntEle.Count - 1 do
      begin
        Gerador.wGrupo('idDocAntEle', 'K29');
        Gerador.wCampo(tcStr, 'K30', 'chave  ', 44, 44, 1, CTe.infCTeNorm.emiDocAnt[i].idDocAnt[i01].idDocAntEle[i02].chave, '');
        Gerador.wGrupo('/idDocAntEle');
      end;
      if CTe.infCTeNorm.emiDocAnt[i].idDocAnt[i01].idDocAntEle.Count > 990 then
        Gerador.wAlerta('K29', 'idDocAntEle', '', ERR_MSG_MAIOR_MAXIMO + '990');

      Gerador.wGrupo('/idDocAnt');
    end;
    if CTe.infCTeNorm.emiDocAnt[i].idDocAnt.Count > 2 then
      Gerador.wAlerta('K22', 'idDocAnt', '', ERR_MSG_MAIOR_MAXIMO + '02');

//    Gerador.wCampo(tcDat, 'K31', 'dPrev  ', 10, 10, 0, CTe.infCTeNorm.contQt[i].dPrev, '');
//    Gerador.wGrupo('/contQt');
  end;
  if CTe.infCTeNorm.emiDocAnt.Count > 990 then
    Gerador.wAlerta('K16', 'emiDocAnt', '', ERR_MSG_MAIOR_MAXIMO + '990');

  Gerador.wGrupo('/docAnt');
end;

procedure TCTeW.GerarInfSeg;
var
  i: integer;
begin
  for i := 0 to CTe.InfSeg.Count - 1 do
  begin
    Gerador.wGrupo('seg', 'K32');
    Gerador.wCampo(tcStr, 'K33', 'respSeg ', 01, 01, 1, TpRspSeguroToStr(CTe.InfSeg[i].respSeg), DSC_RESPSEG);
    Gerador.wCampo(tcStr, 'K34', 'xSeg    ', 01, 30, 0, CTe.InfSeg[i].xSeg, DSC_XSEG);
    Gerador.wCampo(tcStr, 'K35', 'nApol   ', 01, 20, 0, SomenteNumeros(CTe.InfSeg[i].nApol), DSC_NAPOL);
    Gerador.wCampo(tcStr, 'K36', 'nAver   ', 20, 20, 0, SomenteNumeros(CTe.InfSeg[i].nAver), DSC_NAVER);
    Gerador.wCampo(tcDe3, 'K37', 'vMerc   ', 01, 15, 0, CTe.InfSeg[i].vMerc, DSC_VMERC);
    Gerador.wGrupo('/seg');
  end;
  if CTe.InfSeg.Count > 990 then
    Gerador.wAlerta('K32', 'seg', DSC_INFSEG, ERR_MSG_MAIOR_MAXIMO + '990');
end;

procedure TCTeW.GerarRodo;
begin
  Gerador.wGrupo('rodo', 'L01');
  Gerador.wCampo(tcStr, 'L04', 'RNTRC  ', 14, 14, 1, SomenteNumeros(CTe.Rodo.RNTRC), DSC_RNTRC);
  Gerador.wCampo(tcDat, 'L05', 'dPrev  ', 10, 10, 1, CTe.Rodo.dPrev, DSC_DPREV);
  Gerador.wCampo(tcStr, 'L06', 'lota   ', 01, 01, 1, TpLotacaoToStr(CTe.Rodo.Lota), DSC_LOTA);

  (**)GerarCTRB;
  (**)GerarOCC;
  (**)GerarValePed;
  (**)GerarVeic;
  (**)GerarLacre;
  (**)GerarMoto;

  Gerador.wGrupo('/rodo');
end;

procedure TCTeW.GerarCTRB;
begin
  if (CTe.Rodo.CTRB.serie<>0) or (CTe.Rodo.CTRB.nCTRB<>0)
   then begin
    Gerador.wGrupo('CTRB', 'L07');
    Gerador.wCampo(tcInt, 'L08', 'serie   ', 01, 03, 1, CTe.Rodo.CTRB.serie, '');
    Gerador.wCampo(tcInt, 'L09', 'nCTRB   ', 01, 06, 1, CTe.Rodo.CTRB.nCTRB, '');
    Gerador.wGrupo('/CTRB');
   end;
end;

procedure TCTeW.GerarOCC;
var
 i: Integer;
begin
  for i := 0 to CTe.Rodo.Occ.Count - 1 do
  begin
    Gerador.wGrupo('occ', 'L10');
    Gerador.wCampo(tcStr, 'L11', 'serie ', 01, 03, 0, CTe.Rodo.Occ[i].serie, '');
    Gerador.wCampo(tcInt, 'L12', 'nOcc  ', 01, 06, 1, CTe.Rodo.Occ[i].nOcc, '');
    Gerador.wCampo(tcDat, 'L13', 'dEmi  ', 10, 10, 1, CTe.Rodo.Occ[i].dEmi, '');

    Gerador.wGrupo('emiOcc', 'L14');
    Gerador.wCampoCNPJ('L15', CTe.Rodo.Occ[i].EmiOCC.CNPJ, CODIGO_BRASIL, True);
    Gerador.wCampo(tcStr, 'L16', 'cInt   ', 01, 10, 0, CTe.Rodo.Occ[i].EmiOCC.cInt, DSC_CINT);
    Gerador.wCampo(tcStr, 'L20', 'IE     ', 02, 14, 1, SomenteNumeros(CTe.Rodo.Occ[i].EmiOCC.IE), DSC_IE);
    Gerador.wCampo(tcStr, 'L21', 'UF    ', 02, 02, 1, CTe.Rodo.Occ[i].EmiOCC.UF, DSC_CUF);
    Gerador.wCampo(tcStr, 'L22', 'fone   ', 07, 12, 0, somenteNumeros(CTe.Rodo.Occ[i].EmiOCC.fone), DSC_FONE);
    Gerador.wGrupo('/emiOcc');

    Gerador.wGrupo('/occ');
  end;
  if CTe.Rodo.Occ.Count > 10 then
    Gerador.wAlerta('L10', 'occ', '', ERR_MSG_MAIOR_MAXIMO + '10');
end;

procedure TCTeW.GerarValePed;
var
 i: Integer;
begin
  if (CTe.Rodo.valePed.nroRE<>'')
   then begin
    Gerador.wGrupo('valePed', 'L23');
    Gerador.wCampo(tcStr, 'L24', 'nroRE     ', 05, 09, 0, CTe.Rodo.valePed.nroRE, '');
    Gerador.wCampo(tcDe2, 'L25', 'vTValePed ', 01, 15, 0, CTe.Rodo.valePed.vTValePed, '');
    Gerador.wCampo(tcInt, 'L26', 'respPg    ', 01, 01, 1, CTe.Rodo.valePed.respPg, '');

    for i := 0 to CTe.Rodo.valePed.disp.Count - 1 do
    begin
      Gerador.wGrupo('disp', 'L27');
      Gerador.wCampo(tcInt, 'L28', 'tpDisp  ', 01, 01, 1, CTe.Rodo.valePed.disp[i].tpDisp, '');
      Gerador.wCampo(tcStr, 'L29', 'xEmp    ', 01, 30, 1, CTe.Rodo.valePed.disp[i].xEmp, '');
      Gerador.wCampo(tcDat, 'L30', 'dVig    ', 10, 10, 1, CTe.Rodo.valePed.disp[i].dVig, '');
      Gerador.wCampo(tcStr, 'L31', 'nDisp   ', 01, 20, 0, CTe.Rodo.valePed.disp[i].nDisp, '');
      Gerador.wCampo(tcStr, 'L32', 'nCompC  ', 01, 14, 0, CTe.Rodo.valePed.disp[i].nCompC, '');
      Gerador.wGrupo('/disp');
    end;
    if CTe.Rodo.valePed.disp.Count > 990 then
      Gerador.wAlerta('L27', 'disp', '', ERR_MSG_MAIOR_MAXIMO + '990');
    Gerador.wGrupo('/valePed');
   end;
end;

procedure TCTeW.GerarVeic;
var
  i: integer;
begin
  for i := 0 to CTe.Rodo.veic.Count - 1 do
  begin
    Gerador.wGrupo('veic', 'L33');
    Gerador.wCampo(tcStr, 'L34', 'cInt   ', 01, 10, 0, CTe.Rodo.veic[i].cInt, '');
    Gerador.wCampo(tcStr, 'L35', 'RENAVAM', 09, 09, 1, CTe.Rodo.veic[i].RENAVAM, '');
    Gerador.wCampo(tcStr, 'L36', 'placa  ', 01, 07, 1, CTe.Rodo.veic[i].placa, '');
    Gerador.wCampo(tcInt, 'L37', 'tara   ', 01, 06, 1, CTe.Rodo.veic[i].tara, '');
    Gerador.wCampo(tcInt, 'L38', 'capKG  ', 01, 06, 1, CTe.Rodo.veic[i].capKG, '');
    Gerador.wCampo(tcInt, 'L39', 'capM3  ', 01, 03, 1, CTe.Rodo.veic[i].capM3, '');
    Gerador.wCampo(tcStr, 'L40', 'tpProp ', 01, 01, 1, CTe.Rodo.veic[i].tpProp, '');
    Gerador.wCampo(tcInt, 'L41', 'tpVeic ', 01, 01, 1, CTe.Rodo.veic[i].tpVeic, '');
    Gerador.wCampo(tcInt, 'L42', 'tpRod  ', 02, 02, 1, CTe.Rodo.veic[i].tpRod, '');
    Gerador.wCampo(tcInt, 'L43', 'tpCar  ', 02, 02, 1, CTe.Rodo.veic[i].tpCar, '');
    Gerador.wCampo(tcStr, 'L44', 'UF     ', 02, 02, 1, CTe.Rodo.veic[i].UF, DSC_CUF);

    if (CTe.Rodo.veic[i].Prop.CNPJCPF <> '') or
       (CTe.Rodo.veic[i].Prop.RNTRC <> '') or
       (CTe.Rodo.veic[i].Prop.xNome <> '') then
    begin
      Gerador.wGrupo('prop', 'L45');
      Gerador.wCampoCNPJCPF('L46', 'L47', CTe.Rodo.veic[i].Prop.CNPJCPF, CODIGO_BRASIL);
      Gerador.wCampo(tcStr, 'L48', 'RNTRC  ', 14, 14, 1, SomenteNumeros(CTe.Rodo.veic[i].Prop.RNTRC), DSC_RNTRC);
      Gerador.wCampo(tcStr, 'L49', 'xNome  ', 01, 60, 1, CTe.Rodo.veic[i].Prop.xNome, DSC_XNOME);
      Gerador.wCampo(tcStr, 'L50', 'IE     ', 02, 14, 1, SomenteNumeros(CTe.Rodo.veic[i].Prop.IE), DSC_IE);
      Gerador.wCampo(tcStr, 'L51', 'UF     ', 02, 02, 1, CTe.Rodo.veic[i].Prop.UF, DSC_CUF);
      Gerador.wCampo(tcStr, 'L52', 'tpProp ', 01, 01, 1, TpPropToStr(CTe.Rodo.veic[i].Prop.tpProp), DSC_TPPROP);
      Gerador.wGrupo('/prop');
    end;

    Gerador.wGrupo('/veic');
  end;
  if CTe.Rodo.veic.Count > 4 then
    Gerador.wAlerta('L33', 'veic', '', ERR_MSG_MAIOR_MAXIMO + '4');
end;

procedure TCTeW.GerarLacre;
var
  i: integer;
begin
  for i := 0 to CTe.Rodo.Lacres.Count - 1 do
  begin
    Gerador.wGrupo('lacRodo', 'L53');
    Gerador.wCampo(tcStr, 'L54', 'nLacre', 01, 20, 1, CTe.Rodo.Lacres[i].nLacre, DSC_NLACRE);
    Gerador.wGrupo('/lacRodo');
  end;
  if CTe.Rodo.Lacres.Count > 990 then
    Gerador.wAlerta('L53', 'lacRodo', DSC_LACR, ERR_MSG_MAIOR_MAXIMO + '990');
end;

procedure TCTeW.GerarMoto;
var
  i: integer;
begin
  for i := 0 to CTe.Rodo.moto.Count - 1 do
  begin
    Gerador.wGrupo('moto', 'L55');
    Gerador.wCampo(tcStr, 'L56', 'xNome', 01, 60, 1, CTe.Rodo.moto[i].xNome, '');
    Gerador.wCampo(tcStr, 'L57', 'CPF', 11, 11, 1, CTe.Rodo.moto[i].CPF, '');
    Gerador.wGrupo('/moto');
  end;
  if CTe.Rodo.moto.Count > 990 then
    Gerador.wAlerta('L55', 'moto', DSC_LACR, ERR_MSG_MAIOR_MAXIMO + '990');
end;

procedure TCTeW.GerarAereo;  // M
begin
 {a}
end;

procedure TCTeW.GerarAquav;  // N
begin
 {a}
end;

procedure TCTeW.GerarFerrov;  // O
begin
 {a}
end;

procedure TCTeW.GerarDuto;  // P
begin
 {a}
end;

procedure TCTeW.GerarPeri;  // Q
begin
 {a}
end;

procedure TCTeW.GerarVeicNovos;  // R
begin
 {a}
end;

procedure TCTeW.GerarInfCTeSub;  // S
begin
 {a}
end;

procedure TCTeW.GerarInfCTeComp;
var
  i, i01: integer;
begin
  if (CTe.Ide.tpCTe = tcComplemento) then
  begin
    for i := 0 to CTe.InfCTeComp.Count - 1 do
    begin
      Gerador.wGrupo('infCteComp', 'U01');
      Gerador.wCampo(tcEsp, 'U02', 'chave', 44, 44, 1, SomenteNumeros(CTe.infCTeComp[i].Chave), DSC_CHCTE);
      Gerador.wGrupo('vPresComp', 'U03');
      Gerador.wCampo(tcDe2, 'U04', 'vTPrest   ', 01, 15, 1, CTe.infCTeComp[i].vPresComp.vTPrest, DSC_VTPREST);

      for i01 := 0 to CTe.InfCTeComp[i].vPresComp.compComp.Count - 1 do
      begin
        if (CTe.InfCTeComp[i].vPresComp.compComp[i01].xNome <> '') and
          (CTe.InfCTeComp[i].vPresComp.compComp[i01].vComp <> 0) then
          begin
            Gerador.wGrupo('compComp', 'U05');
            Gerador.wCampo(tcStr, 'U06', 'xNome ', 01, 15, 1, CTe.InfCTeComp[i].vPresComp.compComp[i01].xNome, DSC_XNOMEC);
            Gerador.wCampo(tcDe2, 'U07', 'vComp ', 01, 15, 1, CTe.InfCTeComp[i].vPresComp.compComp[i01].vComp, DSC_VCOMP);
            Gerador.wGrupo('/compComp');
          end;
      end;

      Gerador.wGrupo('/vPresComp');

      (**)GerarImpComp(i);

      Gerador.wGrupo('/infCteComp');
    end;
    if CTe.InfCTeComp.Count > 10 then
      Gerador.wAlerta('U01', 'infCteComp', '', ERR_MSG_MAIOR_MAXIMO + '10');

  end;
end;

procedure TCTeW.GerarImpComp(i: Integer);
begin
  Gerador.wGrupo('impComp', 'U08');
  (**)GerarICMSComp(i);
  Gerador.wCampo(tcStr, 'U80', 'infAdFisco ', 01, 255, 0, CTe.InfCTeComp[i].impComp.InfAdFisco, DSC_INFADFISCO);
  Gerador.wGrupo('/impComp');
end;

procedure TCTeW.GerarICMSComp(i: Integer);
begin
  Gerador.wGrupo('ICMSComp', 'U09');

  if CTe.InfCTeComp[i].impComp.ICMSComp.SituTrib = cst00 then
    (**)GerarCST00Comp(i)
  else if CTe.InfCTeComp[i].impComp.ICMSComp.SituTrib = cst20 then
    (**)GerarCST20Comp(i)
  else if ((CTe.InfCTeComp[i].impComp.ICMSComp.SituTrib = cst40) or
           (CTe.InfCTeComp[i].impComp.ICMSComp.SituTrib = cst41) or
           (CTe.InfCTeComp[i].impComp.ICMSComp.SituTrib = cst51)) then
    (**)GerarCST45Comp(i)
  else if CTe.InfCTeComp[i].impComp.ICMSComp.SituTrib = cst80 then
    (**)GerarCST80Comp(i)
  else if CTe.InfCTeComp[i].impComp.ICMSComp.SituTrib = cst81 then
    (**)GerarCST81Comp(i)
  else if CTe.InfCTeComp[i].impComp.ICMSComp.SituTrib = cst90 then
    (**)GerarCST90Comp(i);

  Gerador.wGrupo('/ICMSComp');
end;

procedure TCTeW.GerarCST00Comp(i: Integer);
begin
  Gerador.wGrupo('CST00', 'U10');
  Gerador.wCampo(tcStr, 'U11', 'CST     ', 02, 02, 1, CSTICMSTOStr(CTe.InfCTeComp[i].impComp.ICMSComp.CST00.CST), DSC_CST);
  Gerador.wCampo(tcDe2, 'U12', 'vBC     ', 01, 15, 1, CTe.InfCTeComp[i].impComp.ICMSComp.CST00.vBC, DSC_VBC);
  Gerador.wCampo(tcDe2, 'U13', 'pICMS   ', 01, 05, 1, CTe.InfCTeComp[i].impComp.ICMSComp.CST00.pICMS, DSC_PICMS);
  Gerador.wCampo(tcDe2, 'U14', 'vICMS   ', 01, 15, 1, CTe.InfCTeComp[i].impComp.ICMSComp.CST00.vICMS, DSC_VICMS);
  Gerador.wGrupo('/CST00');
end;

procedure TCTeW.GerarCST20Comp(i: Integer);
begin
  Gerador.wGrupo('CST20', 'U15');
  Gerador.wCampo(tcStr, 'U16', 'CST     ', 02, 02, 1, CSTICMSTOStr(CTe.InfCTeComp[i].impComp.ICMSComp.CST20.CST), DSC_CST);
  Gerador.wCampo(tcDe2, 'U17', 'pRedBC   ', 01, 05, 1, CTe.InfCTeComp[i].impComp.ICMSComp.CST20.pRedBC, DSC_PREDBC);
  Gerador.wCampo(tcDe2, 'U18', 'vBC     ', 01, 15, 1, CTe.InfCTeComp[i].impComp.ICMSComp.CST20.vBC, DSC_VBC);
  Gerador.wCampo(tcDe2, 'U19', 'pICMS   ', 01, 05, 1, CTe.InfCTeComp[i].impComp.ICMSComp.CST20.pICMS, DSC_PICMS);
  Gerador.wCampo(tcDe2, 'U20', 'vICMS   ', 01, 15, 1, CTe.InfCTeComp[i].impComp.ICMSComp.CST20.vICMS, DSC_VICMS);
  Gerador.wGrupo('/CST20');
end;

procedure TCTeW.GerarCST45Comp(i: Integer);
begin
  Gerador.wGrupo('CST45', 'U21');
  Gerador.wCampo(tcStr, 'U22', 'CST     ', 02, 02, 1, CSTICMSTOStr(CTe.InfCTeComp[i].impComp.ICMSComp.CST45.CST), DSC_CST);
  Gerador.wGrupo('/CST45');
end;

procedure TCTeW.GerarCST80Comp(i: Integer);
begin
  Gerador.wGrupo('CST80', 'U23');
  Gerador.wCampo(tcStr, 'U24', 'CST     ', 02, 02, 1, CSTICMSTOStr(CTe.InfCTeComp[i].impComp.ICMSComp.CST80.CST), DSC_CST);
  Gerador.wCampo(tcDe2, 'U25', 'vBC     ', 01, 15, 1, CTe.InfCTeComp[i].impComp.ICMSComp.CST80.vBC, DSC_VBC);
  Gerador.wCampo(tcDe2, 'U26', 'pICMS   ', 01, 05, 1, CTe.InfCTeComp[i].impComp.ICMSComp.CST80.pICMS, DSC_PICMS);
  Gerador.wCampo(tcDe2, 'U27', 'vICMS   ', 01, 15, 1, CTe.InfCTeComp[i].impComp.ICMSComp.CST80.vICMS, DSC_VICMS);
  if CTe.InfCTeComp[i].impComp.ICMSComp.CST80.vCred > 0 then
   Gerador.wCampo(tcDe2, 'U28', 'vCred   ', 01, 15, 1, CTe.InfCTeComp[i].impComp.ICMSComp.CST80.vCred, DSC_VCRED);
  Gerador.wGrupo('/CST80');
end;

procedure TCTeW.GerarCST81Comp(i: Integer);
begin
  Gerador.wGrupo('CST81', 'U29');
  Gerador.wCampo(tcStr, 'U30', 'CST     ', 02, 02, 1, CSTICMSTOStr(CTe.InfCTeComp[i].impComp.ICMSComp.CST81.CST), DSC_CST);
  if CTe.InfCTeComp[i].impComp.ICMSComp.CST81.pRedBC > 0 then
   Gerador.wCampo(tcDe2, 'U31', 'pRedBC   ', 01, 05, 1, CTe.InfCTeComp[i].impComp.ICMSComp.CST81.pRedBC, DSC_PREDBC);
  Gerador.wCampo(tcDe2, 'U32', 'vBC     ', 01, 15, 1, CTe.InfCTeComp[i].impComp.ICMSComp.CST81.vBC, DSC_VBC);
  Gerador.wCampo(tcDe2, 'U33', 'pICMS   ', 01, 05, 1, CTe.InfCTeComp[i].impComp.ICMSComp.CST81.pICMS, DSC_PICMS);
  Gerador.wCampo(tcDe2, 'U34', 'vICMS   ', 01, 15, 1, CTe.InfCTeComp[i].impComp.ICMSComp.CST81.vICMS, DSC_VICMS);
  Gerador.wGrupo('/CST81');
end;

procedure TCTeW.GerarCST90Comp(i: Integer);
begin
  Gerador.wGrupo('CST90', 'U35');
  Gerador.wCampo(tcStr, 'U36', 'CST     ', 02, 02, 1, CSTICMSTOStr(CTe.InfCTeComp[i].impComp.ICMSComp.CST90.CST), DSC_CST);
  if CTe.InfCTeComp[i].impComp.ICMSComp.CST90.pRedBC > 0 then
    Gerador.wCampo(tcDe2, 'U37', 'pRedBC   ', 01, 05, 1, CTe.InfCTeComp[i].impComp.ICMSComp.CST90.pRedBC, DSC_PREDBC);
  Gerador.wCampo(tcDe2, 'U38', 'vBC     ', 01, 15, 1, CTe.InfCTeComp[i].impComp.ICMSComp.CST90.vBC, DSC_VBC);
  Gerador.wCampo(tcDe2, 'U39', 'pICMS   ', 01, 05, 1, CTe.InfCTeComp[i].impComp.ICMSComp.CST90.pICMS, DSC_PICMS);
  Gerador.wCampo(tcDe2, 'U40', 'vICMS   ', 01, 15, 1, CTe.InfCTeComp[i].impComp.ICMSComp.CST90.vICMS, DSC_VICMS);
  if CTe.InfCTeComp[i].impComp.ICMSComp.CST90.vCred > 0 then
    Gerador.wCampo(tcDe2, 'U41', 'vCred   ', 01, 15, 1, CTe.InfCTeComp[i].impComp.ICMSComp.CST90.vCred, DSC_VCRED);
  Gerador.wGrupo('/CST90');
end;

procedure TCTeW.GerarInfCTeAnu;
begin
  if (CTe.Ide.tpCTe = tcAnulacao) then
  begin
    Gerador.wGrupo('infCteAnu', 'V01');
    Gerador.wCampo(tcEsp, 'V02', 'chCTe', 44, 44, 1, SomenteNumeros(CTe.InfCTeAnuEnt.chCTe), DSC_CHCTE);
    Gerador.wCampo(tcDat, 'V03', 'dEmi  ', 10, 10, 1, CTe.InfCTeAnuEnt.dEmi, DSC_DEMI);
    Gerador.wGrupo('/infCteAnu');
  end;
end;

procedure TCTeW.AjustarMunicipioUF(var xUF, xMun: string;
  var cMun: integer; cPais: integer; vxUF, vxMun: string; vcMun: integer);
var
  PaisBrasil: boolean;
begin
  PaisBrasil := cPais = CODIGO_BRASIL;
  cMun := IIf(PaisBrasil, vcMun, CMUN_EXTERIOR);
  xMun := IIf(PaisBrasil, vxMun, XMUN_EXTERIOR);
  xUF := IIf(PaisBrasil, vxUF, UF_EXTERIOR);
  xMun := ObterNomeMunicipio(xMun, xUF, cMun);
end;

function TCTeW.ObterNomeMunicipio(const xMun, xUF: string;
  const cMun: integer): string;
var
  i: integer;
  PathArquivo, Codigo: string;
  List: TstringList;
begin
  result := '';
  if (FOpcoes.NormatizarMunicipios) and (cMun <> CMUN_EXTERIOR) then
  begin
    PathArquivo := FOpcoes.FPathArquivoMunicipios + 'MunIBGE-UF' + InttoStr(UFparaCodigo(xUF)) + '.txt';
    if FileExists(PathArquivo) then
    begin
      List := TstringList.Create;
      List.LoadFromFile(PathArquivo);
      Codigo := IntToStr(cMun);
      i := 0;
      while (i < list.count) and (result = '') do
      begin
        if pos(Codigo, List[i]) > 0 then
          result := Trim(stringReplace(list[i], codigo, '', []));
        inc(i);
      end;
      List.free;
    end;
  end;
  if result = '' then
    result := xMun;
end;

end.

