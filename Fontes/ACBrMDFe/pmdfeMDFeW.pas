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

unit pmdfeMDFeW;

interface

uses
  SysUtils, Classes,
  pcnAuxiliar, pcnConversao, pcnGerador,
  pmdfeConversao, pmdfeMDFe;

type

  TGeradorOpcoes = class;

  TMDFeW = class(TPersistent)
  private
    FGerador: TGerador;
    FMDFe: TMDFe;
    FOpcoes: TGeradorOpcoes;
    procedure GerarInfMDFe;       // Nivel 0

    procedure GerarIde;           // Nivel 1
    procedure GerarinfMunCarrega; // Nivel 2
    procedure GerarinfPercurso;   // Nivel 2

    procedure GerarEmit;          // Nivel 1
    procedure GerarEnderEmit;     // Nivel 2

    procedure GerarInfModal;      // Nivel 1
    procedure GerarRodo;          // Nivel 2
    procedure GerarAereo;         // Nivel 2
    procedure GerarAquav;         // Nivel 2
    procedure GerarFerrov;        // Nivel 2

    procedure GerarInfDoc;        // Nivel 1
    procedure GerarTot;           // Nivel 1
    procedure GerarLacres;        // Nivel 1
    procedure GerarInfAdic;       // Nivel 1

    procedure AjustarMunicipioUF(var xUF: string; var xMun: string; var cMun: integer; cPais: integer; vxUF, vxMun: string; vcMun: integer);
    function ObterNomeMunicipio(const xMun, xUF: string; const cMun: integer): string;
  public
    constructor Create(AOwner: TMDFe);
    destructor Destroy; override;
    function GerarXml: boolean;
    function ObterNomeArquivo: string;
  published
    property Gerador: TGerador read FGerador write FGerador;
    property MDFe: TMDFe read FMDFe write FMDFe;
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

{ TMDFeW }

constructor TMDFeW.Create(AOwner: TMDFe);
begin
  FMDFe := AOwner;
  FGerador := TGerador.Create;
  FGerador.FIgnorarTagNivel := '|?xml version|MDFe xmlns|infMDFe versao|';
  FOpcoes := TGeradorOpcoes.Create;
  FOpcoes.FAjustarTagNro := True;
  FOpcoes.FNormatizarMunicipios := False;
  FOpcoes.FGerarTagAssinatura := taSomenteSeAssinada;
  FOpcoes.FValidarInscricoes := False;
  FOpcoes.FValidarListaServicos := False;
end;

destructor TMDFeW.Destroy;
begin
  FGerador.Free;
  FOpcoes.Free;
  inherited Destroy;
end;

////////////////////////////////////////////////////////////////////////////////

function TMDFeW.ObterNomeArquivo: string;
begin
  Result := SomenteNumeros(MDFe.infMDFe.ID) + '-mdfe.xml';
end;

function TMDFeW.GerarXml: boolean;
var
  chave: AnsiString;
  Gerar: boolean;
  xProtMDFe : String;
begin
  chave := '';

  if not GerarChave(Chave, MDFe.ide.cUF, MDFe.ide.cMDF, StrToInt(MDFe.ide.modelo), MDFe.ide.serie,
    MDFe.ide.nMDF, StrToInt(TpEmisToStr(MDFe.ide.tpEmis)), MDFe.ide.dhEmi, MDFe.emit.CNPJ) then
    Gerador.wAlerta('#001', 'infMDFe', DSC_CHAVE, ERR_MSG_GERAR_CHAVE);

  chave           := StringReplace(chave,'NFe','MDFe',[rfReplaceAll]);
  MDFe.infMDFe.ID := chave;
  MDFe.ide.cDV    := RetornarDigito(MDFe.infMDFe.ID);
  MDFe.Ide.cMDF   := RetornarCodigoNumerico(MDFe.infMDFe.ID, 2);

  // Carrega Layout que sera utilizado para gera o txt
  Gerador.LayoutArquivoTXT.Clear;
  Gerador.ArquivoFormatoXML := '';
  Gerador.ArquivoFormatoTXT := '';

  Gerador.wGrupo(ENCODING_UTF8, '', False);

  if MDFe.procMDFe.nProt <> ''
   then Gerador.wGrupo('mdfeProc versao="' + MDFeEnviMDFe + '" ' + NAME_SPACE_MDFe, '');

  Gerador.wGrupo('MDFe ' + NAME_SPACE_MDFe);
  Gerador.wGrupo('infMDFe versao="' + MDFeEnviMDFe + '" Id="' + MDFe.infMDFe.ID + '"');
  GerarInfMDFe;
  Gerador.wGrupo('/infMDFe');

  if FOpcoes.GerarTagAssinatura <> taNunca then
  begin
    Gerar := true;
    if FOpcoes.GerarTagAssinatura = taSomenteSeAssinada then
      Gerar := ((MDFe.signature.DigestValue <> '') and (MDFe.signature.SignatureValue <> '') and (MDFe.signature.X509Certificate <> ''));
    if FOpcoes.GerarTagAssinatura = taSomenteParaNaoAssinada then
      Gerar := ((MDFe.signature.DigestValue = '') and (MDFe.signature.SignatureValue = '') and (MDFe.signature.X509Certificate = ''));
    if Gerar then
    begin
      FMDFe.signature.URI := somenteNumeros(MDFe.infMDFe.ID);
      FMDFe.signature.Gerador.Opcoes.IdentarXML := Gerador.Opcoes.IdentarXML;
      FMDFe.signature.GerarXML;
      Gerador.ArquivoFormatoXML := Gerador.ArquivoFormatoXML + FMDFe.signature.Gerador.ArquivoFormatoXML;
    end;
  end;
  Gerador.wGrupo('/MDFe');

  if MDFe.procMDFe.nProt <> '' then
   begin
     xProtMDFe :=
           '<protMDFe versao="' + MDFeEnviMDFe + '">' +
             '<infProt>'+
               '<tpAmb>'+TpAmbToStr(MDFe.procMDFe.tpAmb)+'</tpAmb>'+
               '<verAplic>'+MDFe.procMDFe.verAplic+'</verAplic>'+
               '<chMDFe>'+MDFe.procMDFe.chMDFe+'</chMDFe>'+
               '<dhRecbto>'+FormatDateTime('yyyy-mm-dd"T"hh:nn:ss',MDFe.procMDFe.dhRecbto)+'</dhRecbto>'+
               '<nProt>'+MDFe.procMDFe.nProt+'</nProt>'+
               '<digVal>'+MDFe.procMDFe.digVal+'</digVal>'+
               '<cStat>'+IntToStr(MDFe.procMDFe.cStat)+'</cStat>'+
               '<xMotivo>'+MDFe.procMDFe.xMotivo+'</xMotivo>'+
             '</infProt>'+
           '</protMDFe>';

     Gerador.wTexto(xProtMDFe);
     Gerador.wGrupo('/mdfeProc');
   end;

  Gerador.gtAjustarRegistros(MDFe.infMDFe.ID);
  Result := (Gerador.ListaDeAlertas.Count = 0);
end;

procedure TMDFeW.GerarInfMDFe;
begin
  GerarIde;
  GerarEmit;
  GerarInfModal;
  GerarInfDoc;
  GerarTot;
  GerarLacres;
  GerarInfAdic;
end;

procedure TMDFeW.GerarIde;
begin
  Gerador.wGrupo('ide', '#004');
  Gerador.wCampo(tcInt, '#005', 'cUF     ', 02, 02, 1, MDFe.ide.cUF, DSC_CUF);
  if not ValidarCodigoUF(MDFe.ide.cUF) then
    Gerador.wAlerta('#005', 'cUF', DSC_CUF, ERR_MSG_INVALIDO);

  Gerador.wCampo(tcStr, '#006', 'tpAmb   ', 01, 01, 1, tpAmbToStr(MDFe.Ide.tpAmb), DSC_TPAMB);
  Gerador.wCampo(tcStr, '#007', 'tpEmit  ', 01, 01, 1, TpEmitenteToStr(MDFe.Ide.tpEmit), DSC_TPEMIT);
  Gerador.wCampo(tcInt, '#008', 'mod     ', 02, 02, 1, MDFe.ide.modelo, DSC_MOD);
  Gerador.wCampo(tcInt, '#009', 'serie   ', 01, 03, 1, MDFe.ide.serie, DSC_SERIE);
  Gerador.wCampo(tcInt, '#010', 'nMDF    ', 01, 09, 1, MDFe.ide.nMDF, DSC_NMDF);
  Gerador.wCampo(tcStr, '#011', 'cMDF    ', 08, 08, 1, IntToStrZero(RetornarCodigoNumerico(MDFe.infMDFe.ID, 2), 8), DSC_CMDF);
  Gerador.wCampo(tcInt, '#012', 'cDV     ', 01, 01, 1, MDFe.Ide.cDV, DSC_CDV);
  Gerador.wCampo(tcStr, '#013', 'modal   ', 02, 02, 1, ModalToStr(MDFe.Ide.modal), DSC_MODAL);
  Gerador.wCampo(tcDatHor, '#014', 'dhEmi', 19, 19, 1, MDFe.ide.dhEmi, DSC_DEMI);
  Gerador.wCampo(tcStr, '#015', 'tpEmis  ', 01, 01, 1, tpEmisToStr(MDFe.Ide.tpEmis), DSC_TPEMIS);
  Gerador.wCampo(tcStr, '#016', 'procEmi ', 01, 01, 1, procEmiToStr(MDFe.Ide.procEmi), DSC_PROCEMI);
  Gerador.wCampo(tcStr, '#017', 'verProc ', 01, 20, 1, MDFe.Ide.verProc, DSC_VERPROC);
  Gerador.wCampo(tcStr, '#018', 'UFIni   ', 02, 02, 1, MDFe.ide.UFIni, DSC_UF);
  if not ValidarUF(MDFe.ide.UFIni) then
    Gerador.wAlerta('#018', 'UFIni', DSC_UF, ERR_MSG_INVALIDO);
  Gerador.wCampo(tcStr, '#019', 'UFFim   ', 02, 02, 1, MDFe.ide.UFFim, DSC_UF);
  if not ValidarUF(MDFe.ide.UFFim) then
    Gerador.wAlerta('#019', 'UFFim', DSC_UF, ERR_MSG_INVALIDO);

  GerarInfMunCarrega;
  GerarInfPercurso;

  Gerador.wGrupo('/ide');
end;

procedure TMDFeW.GerarinfMunCarrega;
var
  i: integer;
begin
  for i := 0 to MDFe.Ide.infMunCarrega.Count - 1 do
  begin
    Gerador.wGrupo('infMunCarrega', '#020');
    Gerador.wCampo(tcInt, '#021', 'cMunCarrega', 07, 07, 1, MDFe.Ide.infMunCarrega[i].cMunCarrega, DSC_CMUNCARREGA);
    Gerador.wCampo(tcStr, '#022', 'xMunCarrega', 01, 60, 1, MDFe.Ide.infMunCarrega[i].xMunCarrega, DSC_XMUNCARREGA);
    Gerador.wGrupo('/infMunCarrega');
  end;
  if MDFe.Ide.infMunCarrega.Count > 50 then
   Gerador.wAlerta('#020', 'infMunCarrega', '', ERR_MSG_MAIOR_MAXIMO + '50');
end;

procedure TMDFeW.GerarinfPercurso;
var
  i: integer;
begin
  for i := 0 to MDFe.Ide.infPercurso.Count - 1 do
  begin
    Gerador.wGrupo('infPercurso', '#023');
    Gerador.wCampo(tcStr, '#024', 'UFPer', 2, 2, 1, MDFe.Ide.infPercurso[i].UFPer, DSC_UFPER);
    Gerador.wGrupo('/infPercurso');
  end;
  if MDFe.Ide.infPercurso.Count > 25 then
   Gerador.wAlerta('#023', 'infPercurso', '', ERR_MSG_MAIOR_MAXIMO + '25');
end;

procedure TMDFeW.GerarEmit;
begin
  Gerador.wGrupo('emit', '#025');
  Gerador.wCampoCNPJ('#026', MDFe.Emit.CNPJ, CODIGO_BRASIL, True);
  Gerador.wCampo(tcStr, '#027', 'IE   ', 02, 14, 1, SomenteNumeros(MDFe.Emit.IE), DSC_IE);
  if (FOpcoes.ValidarInscricoes)
   then if not ValidarIE(MDFe.Emit.IE, MDFe.Emit.enderEmit.UF) then
         Gerador.wAlerta('#027', 'IE', DSC_IE, ERR_MSG_INVALIDO);
  Gerador.wCampo(tcStr, '#028', 'xNome', 01, 60, 1, MDFe.Emit.xNome, DSC_XNOME);
  Gerador.wCampo(tcStr, '#029', 'xFant', 01, 60, 0, MDFe.Emit.xFant, DSC_XFANT);

  GerarEnderEmit;
  Gerador.wGrupo('/emit');
end;

procedure TMDFeW.GerarEnderEmit;
var
  cMun: integer;
  xMun: string;
  xUF: string;
begin
  AjustarMunicipioUF(xUF, xMun, cMun, CODIGO_BRASIL,
                                      MDFe.Emit.enderEmit.UF,
                                      MDFe.Emit.enderEmit.xMun,
                                      MDFe.Emit.EnderEmit.cMun);
  Gerador.wGrupo('enderEmit', '#030');
  Gerador.wCampo(tcStr, '#031', 'xLgr   ', 01, 60, 1, MDFe.Emit.enderEmit.xLgr, DSC_XLGR);
  Gerador.wCampo(tcStr, '#032', 'nro    ', 01, 60, 1, ExecutarAjusteTagNro(FOpcoes.FAjustarTagNro, MDFe.Emit.enderEmit.nro), DSC_NRO);
  Gerador.wCampo(tcStr, '#033', 'xCpl   ', 01, 60, 0, MDFe.Emit.enderEmit.xCpl, DSC_XCPL);
  Gerador.wCampo(tcStr, '#034', 'xBairro', 01, 60, 1, MDFe.Emit.enderEmit.xBairro, DSC_XBAIRRO);
  Gerador.wCampo(tcInt, '#035', 'cMun   ', 07, 07, 1, cMun, DSC_CMUN);
  if not ValidarMunicipio(MDFe.Emit.EnderEmit.cMun) then
    Gerador.wAlerta('#035', 'cMun', DSC_CMUN, ERR_MSG_INVALIDO);
  Gerador.wCampo(tcStr, '#036', 'xMun   ', 01, 60, 1, xMun, DSC_XMUN);
  Gerador.wCampo(tcInt, '#037', 'CEP    ', 08, 08, 0, MDFe.Emit.enderEmit.CEP, DSC_CEP);
  Gerador.wCampo(tcStr, '#038', 'UF     ', 02, 02, 1, xUF, DSC_UF);
  if not ValidarUF(xUF) then
    Gerador.wAlerta('#038', 'UF', DSC_UF, ERR_MSG_INVALIDO);
  Gerador.wCampo(tcStr, '#039', 'fone   ', 07, 12, 0, somenteNumeros(MDFe.Emit.EnderEmit.fone), DSC_FONE);
  Gerador.wCampo(tcStr, '#040', 'email  ', 01, 60, 0, MDFe.Emit.EnderEmit.email, DSC_EMAIL);
  Gerador.wGrupo('/enderEmit');
end;

procedure TMDFeW.GerarInfModal;
begin
  case StrToInt(ModalToStr(MDFe.Ide.modal)) of
   1: Gerador.wGrupo('infModal versaoModal="' + MDFeModalRodo + '"',  '#041');
   2: Gerador.wGrupo('infModal versaoModal="' + MDFeModalAereo + '"', '#041');
   3: Gerador.wGrupo('infModal versaoModal="' + MDFeModalAqua + '"',  '#041');
   4: Gerador.wGrupo('infModal versaoModal="' + MDFeModalFerro + '"', '#041');
  end;
  case StrToInt(ModalToStr(MDFe.Ide.modal)) of
   1: GerarRodo;   // Informações do Modal Rodoviário
   2: GerarAereo;  // Informações do Modal Aéreo
   3: GerarAquav;  // Informações do Modal Aquaviário
   4: GerarFerrov; // Informações do Modal Ferroviário
  end;
  Gerador.wGrupo('/infModal');
end;

procedure TMDFeW.GerarRodo;
var
  i: integer;
begin
  Gerador.wGrupo('rodo', '#01');
  Gerador.wCampo(tcStr, '#02', 'RNTRC', 08, 08, 1, SomenteNumeros(MDFe.Rodo.RNTRC), DSC_RNTRC);
  Gerador.wCampo(tcStr, '#03', 'CIOT ', 12, 12, 0, MDFe.Rodo.CIOT, DSC_CIOT);

  Gerador.wGrupo('veicPrincipal', '#04');
  Gerador.wCampo(tcStr, '#05', 'cInt ', 01, 10, 0, MDFe.Rodo.veicPrincipal.cInt, DSC_CINTV);
  Gerador.wCampo(tcStr, '#06', 'placa', 01, 07, 1, MDFe.Rodo.veicPrincipal.placa, DSC_PLACA);
  Gerador.wCampo(tcInt, '#07', 'tara ', 01, 06, 1, MDFe.Rodo.veicPrincipal.tara, DSC_TARA);
  Gerador.wCampo(tcInt, '#08', 'capKG', 01, 06, 1, MDFe.Rodo.veicPrincipal.capKG, DSC_CAPKG);
  Gerador.wCampo(tcInt, '#09', 'capM3', 01, 03, 1, MDFe.Rodo.veicPrincipal.capM3, DSC_CAPM3);

  if MDFe.rodo.veicPrincipal.RNTRC <> ''
   then begin
    Gerador.wGrupo('prop', '#10');
    Gerador.wCampo(tcStr, '#11', 'RNTRC', 8, 8, 1, SomenteNumeros(MDFe.Rodo.veicPrincipal.RNTRC), DSC_RNTRC);
    Gerador.wGrupo('/prop');
   end;

  for i := 0 to MDFe.rodo.veicPrincipal.condutor.Count - 1 do
  begin
    Gerador.wGrupo('condutor', '#12');
    Gerador.wCampo(tcStr, '#13', 'xNome', 01, 60, 1, MDFe.rodo.veicPrincipal.condutor[i].xNome, DSC_XNOME);
    Gerador.wCampo(tcStr, '#14', 'CPF  ', 11, 11, 1, MDFe.rodo.veicPrincipal.condutor[i].CPF, DSC_CPF);
    Gerador.wGrupo('/condutor');
  end;
  if MDFe.rodo.veicPrincipal.condutor.Count > 10 then
   Gerador.wAlerta('#12', 'condutor', '', ERR_MSG_MAIOR_MAXIMO + '10');

  Gerador.wGrupo('/veicPrincipal');

  for i := 0 to MDFe.rodo.veicReboque.Count - 1 do
  begin
    Gerador.wGrupo('veicReboque', '#15');
    Gerador.wCampo(tcStr, '#16', 'cInt ', 01, 10, 0, MDFe.Rodo.veicReboque[i].cInt, DSC_CINTV);
    Gerador.wCampo(tcStr, '#17', 'placa', 01, 07, 1, MDFe.Rodo.veicReboque[i].placa, DSC_PLACA);
    Gerador.wCampo(tcInt, '#18', 'tara ', 01, 06, 1, MDFe.Rodo.veicReboque[i].tara, DSC_TARA);
    Gerador.wCampo(tcInt, '#19', 'capKG', 01, 06, 1, MDFe.Rodo.veicReboque[i].capKG, DSC_CAPKG);
    Gerador.wCampo(tcInt, '#20', 'capM3', 01, 03, 1, MDFe.Rodo.veicReboque[i].capM3, DSC_CAPM3);

    if MDFe.rodo.veicReboque[i].RNTRC <> ''
     then begin
      Gerador.wGrupo('prop', '#10');
      Gerador.wCampo(tcStr, '#11', 'RNTRC', 8, 8, 1, SomenteNumeros(MDFe.Rodo.veicReboque[i].RNTRC), DSC_RNTRC);
      Gerador.wGrupo('/prop');
     end;

    Gerador.wGrupo('/veicReboque');
  end;
  if MDFe.rodo.veicReboque.Count > 3 then
   Gerador.wAlerta('#15', 'veicReboque', '', ERR_MSG_MAIOR_MAXIMO + '3');

  if MDFe.rodo.valePed.disp.Count>0
   then begin
    Gerador.wGrupo('valePed', '#23');

    for i := 0 to MDFe.rodo.valePed.disp.Count - 1 do
    begin
      Gerador.wGrupo('disp', '#24');
      Gerador.wCampo(tcStr, '#25', 'CNPJForn', 14, 14, 1, MDFe.Rodo.valePed.disp[i].CNPJForn, DSC_CNPJFORN);
      Gerador.wCampo(tcStr, '#26', 'CNPJPg  ', 14, 14, 0, MDFe.Rodo.valePed.disp[i].CNPJPg, DSC_CNPJPG);
      Gerador.wCampo(tcStr, '#27', 'nCompra ', 01, 20, 1, MDFe.Rodo.valePed.disp[i].nCompra, DSC_NCOMPRA);
      Gerador.wGrupo('/disp');
    end;
    if MDFe.rodo.valePed.disp.Count > 990 then
     Gerador.wAlerta('#24', 'disp', '', ERR_MSG_MAIOR_MAXIMO + '990');

    Gerador.wGrupo('/valePed');
   end;

  Gerador.wGrupo('/rodo');
end;

procedure TMDFeW.GerarAereo;
begin
  Gerador.wGrupo('aereo', '#01');
  Gerador.wCampo(tcInt, '#02', 'nac    ', 01, 04, 1, MDFe.Aereo.nac, DSC_NAC);
  Gerador.wCampo(tcInt, '#03', 'matr   ', 01, 06, 1, MDFe.Aereo.matr, DSC_MATR);
  Gerador.wCampo(tcStr, '#04', 'nVoo   ', 05, 09, 1, MDFe.Aereo.nVoo, DSC_NVOO);
  Gerador.wCampo(tcStr, '#05', 'cAerEmb', 03, 04, 1, MDFe.Aereo.cAerEmb, DSC_CAEREMB);
  Gerador.wCampo(tcStr, '#06', 'cAerDes', 03, 04, 1, MDFe.Aereo.cAerDes, DSC_CAERDES);
  Gerador.wCampo(tcDat, '#07', 'dVoo   ', 10, 10, 0, MDFe.Aereo.dVoo, DSC_DVOO);
  Gerador.wGrupo('/aereo');
end;

procedure TMDFeW.GerarAquav;
var
  i: integer;
begin
  Gerador.wGrupo('aquav', '#01');
  Gerador.wCampo(tcStr, '#02', 'CNPJAgeNav', 14, 14, 1, MDFe.aquav.CNPJAgeNav, '*erro*');
  Gerador.wCampo(tcStr, '#03', 'tpEmb     ', 02, 02, 1, MDFe.aquav.tpEmb, '*erro*');
  Gerador.wCampo(tcStr, '#04', 'cEmbar    ', 10, 10, 1, MDFe.aquav.cEmbar, '*erro*');
  Gerador.wCampo(tcStr, '#05', 'nViagem   ', 10, 10, 1, MDFe.aquav.nViagem, '*erro*');
  Gerador.wCampo(tcStr, '#06', 'cPrtEmb   ', 05, 05, 1, MDFe.aquav.cPrtEmb, '*erro*');
  Gerador.wCampo(tcStr, '#07', 'cPrtDest  ', 05, 05, 1, MDFe.aquav.cPrtDest, '*erro*');

  for i := 0 to MDFe.aquav.infTermCarreg.Count - 1 do
  begin
    Gerador.wGrupo('infTermCarreg', '#08');
    Gerador.wCampo(tcInt, '#09', 'cTermCarreg', 8, 8, 1, MDFe.aquav.infTermCarreg[i].cTermCarreg, '*erro*');
    Gerador.wGrupo('/infTermCarreg');
  end;
  if MDFe.aquav.infTermCarreg.Count > 5 then
   Gerador.wAlerta('#08', 'infTermCarreg', '', ERR_MSG_MAIOR_MAXIMO + '5');

  for i := 0 to MDFe.aquav.infTermDescarreg.Count - 1 do
  begin
    Gerador.wGrupo('infTermDescarreg', '#10');
    Gerador.wCampo(tcInt, '#11', 'cTermDescarreg', 8, 8, 1, MDFe.aquav.infTermDescarreg[i].cTermDescarreg, '*erro*');
    Gerador.wGrupo('/infTermDescarreg');
  end;
  if MDFe.aquav.infTermDescarreg.Count > 5 then
   Gerador.wAlerta('#10', 'infTermDescarreg', '', ERR_MSG_MAIOR_MAXIMO + '5');

  for i := 0 to MDFe.aquav.infEmbComb.Count - 1 do
  begin
    Gerador.wGrupo('infEmbComb', '#12');
    Gerador.wCampo(tcInt, '#13', 'cEmbComb', 8, 8, 1, MDFe.aquav.infEmbComb[i].cEmbComb, '*erro*');
    Gerador.wGrupo('/infEmbComb');
  end;
  if MDFe.aquav.infEmbComb.Count > 30 then
   Gerador.wAlerta('#12', 'infEmbComb', '', ERR_MSG_MAIOR_MAXIMO + '30');

  Gerador.wGrupo('/aquav');
end;

procedure TMDFeW.GerarFerrov;  // O
var
  i: integer;
begin
  Gerador.wGrupo('ferrov', '#01');

  Gerador.wGrupo('trem', '#02');
  Gerador.wCampo(tcStr, '#03', 'xPref    ', 01, 10, 1, MDFe.ferrov.xPref, DSC_XPREF);
  Gerador.wCampo(tcDatHor, '#04', 'dhTrem', 19, 19, 0, MDFe.ferrov.dhTrem, DSC_DHTREM);
  Gerador.wCampo(tcStr, '#05', 'xOri     ', 01, 03, 1, MDFe.ferrov.xOri, DSC_XORI);
  Gerador.wCampo(tcStr, '#06', 'xDest    ', 01, 03, 1, MDFe.ferrov.xDest, DSC_XDEST);
  Gerador.wCampo(tcInt, '#07', 'qVag     ', 01, 03, 1, MDFe.ferrov.qVag, DSC_QVAG);
  Gerador.wGrupo('/trem');

  for i := 0 to MDFe.ferrov.vag.Count - 1 do
  begin
    Gerador.wGrupo('vag', '#08');
    Gerador.wCampo(tcInt, '#09', 'serie', 1, 3, 1, MDFe.ferrov.vag[i].serie, DSC_NSERIE);
    Gerador.wCampo(tcInt, '#10', 'nVag ', 1, 8, 1, MDFe.ferrov.vag[i].nVag, DSC_NVAG);
    Gerador.wCampo(tcInt, '#11', 'nSeq ', 1, 3, 1, MDFe.ferrov.vag[i].nSeq, DSC_NSEQ);
    Gerador.wCampo(tcInt, '#12', 'TU   ', 2, 7, 1, MDFe.ferrov.vag[i].TU, DSC_TU);
    Gerador.wGrupo('/vag');
  end;
  if MDFe.ferrov.vag.Count > 990 then
   Gerador.wAlerta('#08', 'vag', '', ERR_MSG_MAIOR_MAXIMO + '990');

  Gerador.wGrupo('/ferrov');
end;

procedure TMDFeW.GerarInfDoc;
var
  i, j: integer;
begin
  Gerador.wGrupo('infDoc', '#040');

  for i := 0 to MDFe.infDoc.infMunDescarga.Count - 1 do
  begin
    Gerador.wGrupo('infMunDescarga', '#045');
    Gerador.wCampo(tcInt, '#046', 'cMunDescarga', 07, 07, 1, MDFe.infDoc.infMunDescarga[i].cMunDescarga, DSC_CMUN);
    if not ValidarMunicipio(MDFe.infDoc.infMunDescarga[i].cMunDescarga) then
      Gerador.wAlerta('#045', 'cMunDescarga', DSC_CMUN, ERR_MSG_INVALIDO);
    Gerador.wCampo(tcStr, '#046', 'xMunDescarga', 01, 60, 1, MDFe.infDoc.infMunDescarga[i].xMunDescarga, DSC_XMUN);

    for j := 0 to MDFe.infDoc.infMunDescarga[i].infCTe.Count - 1 do
    begin
      Gerador.wGrupo('infCTe', '#048');
      Gerador.wCampo(tcEsp, '#049', 'chCTe      ', 44, 44, 1, SomenteNumeros(MDFe.infDoc.infMunDescarga[i].infCTe[j].chCTe), DSC_REFNFE);
      if SomenteNumeros(MDFe.infDoc.infMunDescarga[i].infCTe[j].chCTe) <> '' then
       if not ValidarChave('NFe' + SomenteNumeros(MDFe.infDoc.infMunDescarga[i].infCTe[j].chCTe)) then
        Gerador.wAlerta('#049', 'chCTe', DSC_REFNFE, ERR_MSG_INVALIDO);
      Gerador.wCampo(tcStr, '#050', 'SegCodBarra', 44, 44, 0, MDFe.infDoc.infMunDescarga[i].infCTe[j].SegCodBarra, DSC_SEGCODBARRA);
      Gerador.wGrupo('/infCTe');
    end;
    if MDFe.infDoc.infMunDescarga[i].infCTe.Count > 2000 then
     Gerador.wAlerta('#048', 'infCTe', '', ERR_MSG_MAIOR_MAXIMO + '2000');

    for j := 0 to MDFe.infDoc.infMunDescarga[i].infCT.Count - 1 do
    begin
      Gerador.wGrupo('infCT', '#051');
      Gerador.wCampo(tcStr, '#052', 'nCT   ', 01, 20, 1, MDFe.infDoc.infMunDescarga[i].infCT[j].nCT, DSC_NCT);
      Gerador.wCampo(tcInt, '#053', 'serie ', 01, 03, 1, MDFe.infDoc.infMunDescarga[i].infCT[j].serie, DSC_SERIE);
      Gerador.wCampo(tcInt, '#054', 'subser', 01, 02, 1, MDFe.infDoc.infMunDescarga[i].infCT[j].subser, DSC_SUBSERIE);
      Gerador.wCampo(tcDat, '#055', 'dEmi  ', 10, 10, 1, MDFe.infDoc.infMunDescarga[i].infCT[j].dEmi, DSC_DEMI);
      Gerador.wCampo(tcDe2, '#056', 'vCarga', 01, 15, 1, MDFe.infDoc.infMunDescarga[i].infCT[j].vCarga, DSC_VDOC);
      Gerador.wGrupo('/infCT');
    end;
    if MDFe.infDoc.infMunDescarga[i].infCT.Count > 2000 then
     Gerador.wAlerta('#051', 'infCT', '', ERR_MSG_MAIOR_MAXIMO + '2000');

    for j := 0 to MDFe.infDoc.infMunDescarga[i].infNFe.Count - 1 do
    begin
      Gerador.wGrupo('infNFe', '#057');
      Gerador.wCampo(tcEsp, '#058', 'chNFe      ', 44, 44, 1, SomenteNumeros(MDFe.infDoc.infMunDescarga[i].infNFe[j].chNFe), DSC_REFNFE);
      if SomenteNumeros(MDFe.infDoc.infMunDescarga[i].infNFe[j].chNFe) <> '' then
       if not ValidarChave('NFe' + SomenteNumeros(MDFe.infDoc.infMunDescarga[i].infNFe[j].chNFe)) then
        Gerador.wAlerta('#058', 'chNFe', DSC_REFNFE, ERR_MSG_INVALIDO);
      Gerador.wCampo(tcStr, '#059', 'SegCodBarra', 44, 44, 0, MDFe.infDoc.infMunDescarga[i].infNFe[j].SegCodBarra, DSC_SEGCODBARRA);
      Gerador.wGrupo('/infNFe');
    end;
    if MDFe.infDoc.infMunDescarga[i].infNFe.Count > 2000 then
     Gerador.wAlerta('#057', 'infNFe', '', ERR_MSG_MAIOR_MAXIMO + '2000');

    for j := 0 to MDFe.infDoc.infMunDescarga[i].infNF.Count - 1 do
    begin
      Gerador.wGrupo('infNF', '#060');
      Gerador.wCampoCNPJ('#061', MDFe.infDoc.infMunDescarga[i].infNF[j].CNPJ, CODIGO_BRASIL, True);
      Gerador.wCampo(tcStr, '#062', 'UF   ', 02, 02, 1, MDFe.infDoc.infMunDescarga[i].infNF[j].UF, DSC_IE);
      Gerador.wCampo(tcStr, '#063', 'nNF  ', 01, 20, 1, MDFe.infDoc.infMunDescarga[i].infNF[j].nNF, DSC_NNF);
      Gerador.wCampo(tcInt, '#064', 'serie', 01, 03, 1, MDFe.infDoc.infMunDescarga[i].infNF[j].serie, DSC_SERIE);
      Gerador.wCampo(tcDat, '#065', 'dEmi ', 10, 10, 1, MDFe.infDoc.infMunDescarga[i].infNF[j].dEmi, DSC_DEMI);
      Gerador.wCampo(tcDe2, '#066', 'vNF  ', 01, 15, 1, MDFe.infDoc.infMunDescarga[i].infNF[j].vNF, DSC_VDOC);
      Gerador.wCampo(tcInt, '#067', 'PIN  ', 02, 09, 0, MDFe.infDoc.infMunDescarga[i].infNF[j].PIN, DSC_PIN);
      Gerador.wGrupo('/infNF');
    end;
    if MDFe.infDoc.infMunDescarga[i].infNF.Count > 2000 then
     Gerador.wAlerta('#060', 'infNF', '', ERR_MSG_MAIOR_MAXIMO + '2000');

    Gerador.wGrupo('/infMunDescarga');
  end;
  if MDFe.infDoc.infMunDescarga.Count > 100 then
   Gerador.wAlerta('#045', 'infMunDescarga', '', ERR_MSG_MAIOR_MAXIMO + '100');

  Gerador.wGrupo('/infDoc');
end;

procedure TMDFeW.GerarTot;
begin
  Gerador.wGrupo('tot', '#068');
  Gerador.wCampo(tcInt, '#069', 'qCTe  ', 01, 03, 0, MDFe.tot.qCTe, DSC_QCTE);
  Gerador.wCampo(tcInt, '#070', 'qCT   ', 01, 03, 0, MDFe.tot.qCT, DSC_QCT);
  Gerador.wCampo(tcInt, '#071', 'qNFe  ', 01, 03, 0, MDFe.tot.qNFe, DSC_QNFE);
  Gerador.wCampo(tcInt, '#072', 'qNF   ', 01, 03, 0, MDFe.tot.qNF, DSC_QNF);
  Gerador.wCampo(tcDe2, '#073', 'vCarga', 01, 15, 1, MDFe.tot.vCarga, DSC_VDOC);
  Gerador.wCampo(tcStr, '#074', 'cUnid ', 02, 02, 1, UnidMedToStr(MDFe.tot.cUnid), DSC_CUNID);
  Gerador.wCampo(tcDe4, '#075', 'qCarga', 01, 15, 1, MDFe.tot.qCarga, DSC_QCARGA);
  Gerador.wGrupo('/tot');
end;

procedure TMDFeW.GerarLacres;
var
  i: integer;
begin
  for i := 0 to MDFe.lacres.Count - 1 do
  begin
    Gerador.wGrupo('lacres', '#076');
    Gerador.wCampo(tcStr, '#077', 'nLacre', 01, 60, 1, MDFe.lacres[i].nLacre, DSC_NLACRE);
    Gerador.wGrupo('/lacres');
  end;
  if MDFe.lacres.Count > 990 then
    Gerador.wAlerta('#076', 'lacres', DSC_LACR, ERR_MSG_MAIOR_MAXIMO + '990');
end;

procedure TMDFeW.GerarInfAdic;
begin
  if (MDFe.infAdic.infAdFisco <> '') or (MDFe.infAdic.infCpl <> '')
   then begin
    Gerador.wGrupo('infAdic', '#078');
    Gerador.wCampo(tcStr, '#079', 'infAdFisco', 01, 2000, 0, MDFe.infAdic.infAdFisco, DSC_INFADFISCO);
    Gerador.wCampo(tcStr, '#080', 'infCpl    ', 01, 2000, 0, MDFe.infAdic.infCpl, DSC_INFCPL);
    Gerador.wGrupo('/infAdic');
   end;
end;

procedure TMDFeW.AjustarMunicipioUF(var xUF, xMun: string;
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

function TMDFeW.ObterNomeMunicipio(const xMun, xUF: string;
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

