unit pnfsNFSeW;

interface

uses
{$IFDEF FPC}
  LResources, Controls, Graphics, Dialogs,
{$ELSE}
  StrUtils,
{$ENDIF}
  SysUtils, Classes,
  pcnAuxiliar, pcnConversao, pcnGerador,
  pnfsNFSe, pnfsConversao,
  ACBrNFSeConfiguracoes;

type

 TGeradorOpcoes   = class;

 TNFSeW = class(TPersistent)
  private
    FGerador: TGerador;
    FNFSe: TNFSe;
    FProvedor: TnfseProvedor;
    FOpcoes: TGeradorOpcoes;
    FAtributo: String;
    FPrefixo4: String;
    FIdentificador: String;
    FURL: String;
    FVersaoXML: String;
    FDefTipos: String;
    FServicoEnviar: String;

    procedure GerarIdentificacaoRPS;
    procedure GerarRPSSubstituido;
    procedure GerarServico;
    procedure GerarPrestador;
    procedure GerarTomador;
    procedure GerarIntermediarioServico;
    procedure GerarConstrucaoCivil;
    procedure GerarValoresServico;

    procedure GerarXML_Provedor_fintelISS;
    procedure GerarXML_Provedor_Saatri;

//    procedure AjustarMunicipioUF(var xUF: string; var xMun: string; var cMun: integer; cPais: integer; vxUF, vxMun: string; vcMun: integer);
//    function ObterNomeMunicipio(const xMun, xUF: string; const cMun: integer): string;
  public
    constructor Create(AOwner: TNFSe);
    destructor Destroy; override;
    function GerarXml: boolean;
    function ObterNomeArquivo: string;
  published
    property Gerador: TGerador read FGerador write FGerador;
    property NFSe: TNFSe read FNFSe write FNFSe;
    property Provedor: TnfseProvedor read FProvedor write FProvedor;
    property Opcoes: TGeradorOpcoes read FOpcoes write FOpcoes;
    property Atributo: String read FAtributo write FAtributo;
    property Prefixo4: String read FPrefixo4 write FPrefixo4;
    property Identificador: String read FIdentificador write FIdentificador;
    property URL: String read FURL write FURL;
    property VersaoXML: String read FVersaoXML write FVersaoXML;
    property DefTipos: String read FDefTipos write FDefTipos;
    property ServicoEnviar: String read FServicoEnviar write FServicoEnviar;
  end;

 TGeradorOpcoes = class(TPersistent)
  private
    FAjustarTagNro: boolean;
    FNormatizarMunicipios: boolean;
    FGerarTagAssinatura: TnfseTagAssinatura;
    FPathArquivoMunicipios: string;
    FValidarInscricoes: boolean;
    FValidarListaServicos: boolean;
  published
    property AjustarTagNro: boolean read FAjustarTagNro write FAjustarTagNro;
    property NormatizarMunicipios: boolean read FNormatizarMunicipios write FNormatizarMunicipios;
    property GerarTagAssinatura: TnfseTagAssinatura read FGerarTagAssinatura write FGerarTagAssinatura;
    property PathArquivoMunicipios: string read FPathArquivoMunicipios write FPathArquivoMunicipios;
    property ValidarInscricoes: boolean read FValidarInscricoes write FValidarInscricoes;
    property ValidarListaServicos: boolean read FValidarListaServicos write FValidarListaServicos;
  end;

  ////////////////////////////////////////////////////////////////////////////////

implementation

uses
 ACBrUtil, ACBrNFSe;

{ TNFSeW }

constructor TNFSeW.Create(AOwner: TNFSe);
begin
 FNFSe                         := AOwner;
 FGerador                      := TGerador.Create;
 FGerador.FIgnorarTagNivel     := '|?xml version|NFSe xmlns|infNFSe versao|obsCont|obsFisco|';
 FOpcoes                       := TGeradorOpcoes.Create;
 FOpcoes.FAjustarTagNro        := True;
 FOpcoes.FNormatizarMunicipios := False;
 FOpcoes.FGerarTagAssinatura   := taSomenteSeAssinada;
 FOpcoes.FValidarInscricoes    := False;
 FOpcoes.FValidarListaServicos := False;

end;

destructor TNFSeW.Destroy;
begin
 FGerador.Free;
 FOpcoes.Free;

 inherited Destroy;
end;

////////////////////////////////////////////////////////////////////////////////

function TNFSeW.ObterNomeArquivo: string;
begin
 Result := SomenteNumeros(NFSe.infID.ID) + '.xml';
end;

function TNFSeW.GerarXml: boolean;
var
 Gerar : boolean;
begin
 Gerador.ArquivoFormatoXML := '';
 Gerador.Prefixo           := FPrefixo4;

 if (FProvedor in [proProdemge, profintelISS, proGovBR, proSaatri])
  then FDefTipos := FServicoEnviar;

 if (RightStr(FURL, 1) <> '/') and (FDefTipos <> '')
  then FDefTipos := '/' + FDefTipos;

 if Trim(FPrefixo4) <> ''
  then Atributo := ' xmlns:' + stringReplace(Prefixo4, ':', '', []) + '="' + FURL + FDefTipos + '"'
  else Atributo := ' xmlns="' + FURL + FDefTipos + '"';

 Gerador.wGrupo('Rps' + Atributo);
 FNFSe.InfID.ID := SomenteNumeros(FNFSe.IdentificacaoRps.Numero) + FNFSe.IdentificacaoRps.Serie;

 case FProvedor of
  profintelISS: GerarXML_Provedor_fintelISS;
  proSaatri:    GerarXML_Provedor_Saatri;
  else begin
        if FIdentificador = ''
         then Gerador.wGrupoNFSe('InfRps')
         else Gerador.wGrupoNFSe('InfRps ' + FIdentificador + '="rps' + NFSe.InfID.ID + '"');

        GerarIdentificacaoRPS;
        Gerador.wCampoNFSe(tcDatHor, '#4', 'DataEmissao     ', 19, 19, 1, NFSe.DataEmissao, DSC_DEMI);
        Gerador.wCampoNFSe(tcStr,    '#5', 'NaturezaOperacao', 01, 01, 1, NaturezaOperacaoToStr(NFSe.NaturezaOperacao), '');

        if FProvedor <> proPublica
         then begin
          if (NFSe.RegimeEspecialTributacao <> retNenhum)
           then Gerador.wCampoNFSe(tcStr, '#6', 'RegimeEspecialTributacao', 01, 01, 0, RegimeEspecialTributacaoToStr(NFSe.RegimeEspecialTributacao), '');
         end;

        Gerador.wCampoNFSe(tcStr, '#7', 'OptanteSimplesNacional', 01, 01, 1, SimNaoToStr(NFSe.OptanteSimplesNacional), '');
        Gerador.wCampoNFSe(tcStr, '#8', 'IncentivadorCultural  ', 01, 01, 1, SimNaoToStr(NFSe.IncentivadorCultural), '');
        Gerador.wCampoNFSe(tcStr, '#9', 'Status                ', 01, 01, 1, StatusRPSToStr(NFSe.Status), '');
        GerarRPSSubstituido;
        GerarServico;
        GerarPrestador;
        GerarTomador;
        GerarIntermediarioServico;
        GerarConstrucaoCivil;
        Gerador.wGrupoNFSe('/InfRps');
       end;
 end;

 if FOpcoes.GerarTagAssinatura <> taNunca
  then begin
   Gerar := true;
   if FOpcoes.GerarTagAssinatura = taSomenteSeAssinada
    then Gerar := ((NFSe.signature.DigestValue <> '') and
                   (NFSe.signature.SignatureValue <> '') and
                   (NFSe.signature.X509Certificate <> ''));
   if FOpcoes.GerarTagAssinatura = taSomenteParaNaoAssinada
    then Gerar := ((NFSe.signature.DigestValue = '') and
                   (NFSe.signature.SignatureValue = '') and
                   (NFSe.signature.X509Certificate = ''));
   if Gerar
    then begin
     FNFSe.signature.URI := FNFSe.InfID.ID;
     FNFSe.signature.Gerador.Opcoes.IdentarXML := Gerador.Opcoes.IdentarXML;
     FNFSe.signature.GerarXMLNFSe;
     Gerador.ArquivoFormatoXML := Gerador.ArquivoFormatoXML + FNFSe.signature.Gerador.ArquivoFormatoXML;
    end;
  end;

 Gerador.wGrupo('/Rps');

 Gerador.gtAjustarRegistros(NFSe.InfID.ID);
 Result := (Gerador.ListaDeAlertas.Count = 0);
end;

procedure TNFSeW.GerarIdentificacaoRPS;
begin
 Gerador.wGrupoNFSe('IdentificacaoRps');
 Gerador.wCampoNFSe(tcStr, '#1', 'Numero', 01, 15, 1, SomenteNumeros(NFSe.IdentificacaoRps.Numero), '');
 Gerador.wCampoNFSe(tcStr, '#2', 'Serie ', 01, 05, 1, NFSe.IdentificacaoRps.Serie, '');
 Gerador.wCampoNFSe(tcStr, '#3', 'Tipo  ', 01, 01, 1, TipoRPSToStr(NFSe.IdentificacaoRps.Tipo), '');
 Gerador.wGrupoNFSe('/IdentificacaoRps');
end;

procedure TNFSeW.GerarRPSSubstituido;
begin
 if NFSe.RpsSubstituido.Numero<>''
  then begin
   Gerador.wGrupoNFSe('RpsSubstituido');
   Gerador.wCampoNFSe(tcStr, '#10', 'Numero', 01, 15, 1, SomenteNumeros(NFSe.RpsSubstituido.Numero), '');
   Gerador.wCampoNFSe(tcStr, '#11', 'Serie ', 01, 05, 1, NFSe.RpsSubstituido.Serie, '');
   Gerador.wCampoNFSe(tcStr, '#12', 'Tipo  ', 01, 01, 1, TipoRPSToStr(NFSe.RpsSubstituido.Tipo), '');
   Gerador.wGrupoNFSe('/RpsSubstituido');
  end;
end;

procedure TNFSeW.GerarServico;
var
  i: integer;
begin
 case FProvedor of
  profintelISS: begin
                 Gerador.wGrupoNFSe('ListaServicos');
                 Gerador.wGrupoNFSe('Servico');
                 Gerador.wGrupoNFSe('Valores');
                 Gerador.wCampoNFSe(tcDe2, '#13', 'ValorServicos         ', 01, 15, 1, NFSe.Servico.Valores.ValorServicos, '');
                 Gerador.wCampoNFSe(tcDe2, '#14', 'ValorDeducoes         ', 01, 15, 1, NFSe.Servico.Valores.ValorDeducoes, '');
                 Gerador.wCampoNFSe(tcDe2, '#21', 'ValorIss              ', 01, 15, 1, NFSe.Servico.Valores.ValorIss, '');
                 Gerador.wCampoNFSe(tcDe2, '#25', 'Aliquota              ', 01, 05, 1, NFSe.Servico.Valores.Aliquota, '');
                 Gerador.wCampoNFSe(tcDe2, '#24', 'BaseCalculo           ', 01, 15, 1, NFSe.Servico.Valores.BaseCalculo, '');
                 Gerador.wCampoNFSe(tcDe2, '#27', 'DescontoIncondicionado', 01, 15, 0, NFSe.Servico.Valores.DescontoIncondicionado, '');
                 Gerador.wCampoNFSe(tcDe2, '#28', 'DescontoCondicionado  ', 01, 15, 0, NFSe.Servico.Valores.DescontoCondicionado, '');
                 Gerador.wGrupoNFSe('/Valores');
                 Gerador.wCampoNFSe(tcStr, '#20', 'IssRetido                ', 01, 01,   1, SituacaoTributariaToStr(NFSe.Servico.Valores.IssRetido), '');
                 Gerador.wCampoNFSe(tcStr, '#29', 'ItemListaServico         ', 01, 0005, 1, NFSe.Servico.ItemListaServico, '');
                 Gerador.wCampoNFSe(tcStr, '#30', 'CodigoCnae               ', 01, 0007, 0, SomenteNumeros(NFSe.Servico.CodigoCnae), '');
                 Gerador.wCampoNFSe(tcStr, '#31', 'CodigoTributacaoMunicipio', 01, 0020, 0, SomenteNumeros(NFSe.Servico.CodigoTributacaoMunicipio), '');
                 Gerador.wCampoNFSe(tcStr, '#32', 'Discriminacao            ', 01, 2000, 1, NFSe.Servico.Discriminacao, '');
                 Gerador.wCampoNFSe(tcStr, '#33', 'CodigoMunicipio          ', 01, 0007, 1, SomenteNumeros(NFSe.Servico.CodigoMunicipio), '');
                 Gerador.wCampoNFSe(tcInt, '#34', 'CodigoPais               ', 04, 04,   0, NFSe.Servico.CodigoPais, '');
                 Gerador.wCampoNFSe(tcStr, '#35', 'ExigibilidadeISS         ', 01, 01,   1, ExigibilidadeISSToStr(NFSe.Servico.ExigibilidadeISS), '');
                 Gerador.wCampoNFSe(tcInt, '#36', 'MunicipioIncidencia      ', 07, 07,   0, NFSe.Servico.MunicipioIncidencia, '');
                 Gerador.wCampoNFSe(tcStr, '#37', 'NumeroProcesso           ', 01, 30,   0, NFSe.Servico.NumeroProcesso, '');
                 Gerador.wGrupoNFSe('/Servico');
                 Gerador.wGrupoNFSe('/ListaServicos');
                end;
  proSaatri:    begin
                 Gerador.wGrupoNFSe('Servico');
                 Gerador.wGrupoNFSe('Valores');
                 Gerador.wCampoNFSe(tcDe2, '#13', 'ValorServicos', 01, 15, 1, NFSe.Servico.Valores.ValorServicos, '');
                 Gerador.wCampoNFSe(tcDe2, '#14', 'ValorDeducoes', 01, 15, 0, NFSe.Servico.Valores.ValorDeducoes, '');
                 Gerador.wCampoNFSe(tcDe2, '#15', 'ValorPis     ', 01, 15, 0, NFSe.Servico.Valores.ValorPis, '');
                 Gerador.wCampoNFSe(tcDe2, '#16', 'ValorCofins  ', 01, 15, 0, NFSe.Servico.Valores.ValorCofins, '');
                 Gerador.wCampoNFSe(tcDe2, '#17', 'ValorInss    ', 01, 15, 0, NFSe.Servico.Valores.ValorInss, '');
                 Gerador.wCampoNFSe(tcDe2, '#18', 'ValorIr      ', 01, 15, 0, NFSe.Servico.Valores.ValorIr, '');
                 Gerador.wCampoNFSe(tcDe2, '#19', 'ValorCsll    ', 01, 15, 0, NFSe.Servico.Valores.ValorCsll, '');
                 Gerador.wCampoNFSe(tcDe2, '#22', 'OutrasRetencoes ', 01, 15, 0, NFSe.Servico.Valores.OutrasRetencoes, '');
                 Gerador.wCampoNFSe(tcDe2, '#21', 'ValorIss              ', 01, 15, 1, NFSe.Servico.Valores.ValorIss, '');
                 Gerador.wCampoNFSe(tcDe2, '#25', 'Aliquota              ', 01, 05, 1, NFSe.Servico.Valores.Aliquota, '');
                 Gerador.wCampoNFSe(tcDe2, '#27', 'DescontoIncondicionado', 01, 15, 0, NFSe.Servico.Valores.DescontoIncondicionado, '');
                 Gerador.wCampoNFSe(tcDe2, '#28', 'DescontoCondicionado  ', 01, 15, 0, NFSe.Servico.Valores.DescontoCondicionado, '');
                 Gerador.wGrupoNFSe('/Valores');
                 Gerador.wCampoNFSe(tcStr, '#20', 'IssRetido                ', 01, 01,   1, SituacaoTributariaToStr(NFSe.Servico.Valores.IssRetido), '');
                 Gerador.wCampoNFSe(tcStr, '#21', 'ResponsavelRetencao      ', 01, 01,   1, ResponsavelRetencaoToStr(NFSe.Servico.ResponsavelRetencao), '');
                 Gerador.wCampoNFSe(tcStr, '#29', 'ItemListaServico         ', 01, 0005, 1, NFSe.Servico.ItemListaServico, '');
                 Gerador.wCampoNFSe(tcStr, '#30', 'CodigoCnae               ', 01, 0007, 0, SomenteNumeros(NFSe.Servico.CodigoCnae), '');
                 Gerador.wCampoNFSe(tcStr, '#32', 'Discriminacao            ', 01, 2000, 1, NFSe.Servico.Discriminacao, '');
                 Gerador.wCampoNFSe(tcStr, '#33', 'CodigoMunicipio          ', 01, 0007, 1, SomenteNumeros(NFSe.Servico.CodigoMunicipio), '');
                 Gerador.wCampoNFSe(tcInt, '#34', 'CodigoPais               ', 04, 04,   0, NFSe.Servico.CodigoPais, '');
                 Gerador.wCampoNFSe(tcStr, '#35', 'ExigibilidadeISS         ', 01, 01,   1, ExigibilidadeISSToStr(NFSe.Servico.ExigibilidadeISS), '');
                 Gerador.wCampoNFSe(tcInt, '#36', 'MunicipioIncidencia      ', 07, 07,   0, NFSe.Servico.MunicipioIncidencia, '');
                 Gerador.wGrupoNFSe('/Servico');
                end;
  else begin
        Gerador.wGrupoNFSe('Servico');
        Gerador.wGrupoNFSe('Valores');
        Gerador.wCampoNFSe(tcDe2, '#13', 'ValorServicos', 01, 15, 1, NFSe.Servico.Valores.ValorServicos, '');
        Gerador.wCampoNFSe(tcDe2, '#14', 'ValorDeducoes', 01, 15, 0, NFSe.Servico.Valores.ValorDeducoes, '');
        Gerador.wCampoNFSe(tcDe2, '#15', 'ValorPis     ', 01, 15, 0, NFSe.Servico.Valores.ValorPis, '');
        Gerador.wCampoNFSe(tcDe2, '#16', 'ValorCofins  ', 01, 15, 0, NFSe.Servico.Valores.ValorCofins, '');
        Gerador.wCampoNFSe(tcDe2, '#17', 'ValorInss    ', 01, 15, 0, NFSe.Servico.Valores.ValorInss, '');
        Gerador.wCampoNFSe(tcDe2, '#18', 'ValorIr      ', 01, 15, 0, NFSe.Servico.Valores.ValorIr, '');
        Gerador.wCampoNFSe(tcDe2, '#19', 'ValorCsll    ', 01, 15, 0, NFSe.Servico.Valores.ValorCsll, '');
        Gerador.wCampoNFSe(tcStr, '#20', 'IssRetido    ', 01, 01, 1, SituacaoTributariaToStr(NFSe.Servico.Valores.IssRetido), '');

        if (FProvedor = proGinfes)
         then Gerador.wCampoNFSe(tcDe2, '#21', 'ValorIss', 01, 15, 1, NFSe.Servico.Valores.ValorIss, '')
         else Gerador.wCampoNFSe(tcDe2, '#21', 'ValorIss', 01, 15, 0, NFSe.Servico.Valores.ValorIss, '');

        // Rodrigo Cantelli - Aidicionado provedor Betha na condição abaixo
        if (FProvedor in [proGovBR, proBetha])
         then begin
          Gerador.wCampoNFSe(tcDe2, '#22', 'OutrasRetencoes ', 01, 15, 0, NFSe.Servico.Valores.OutrasRetencoes, '');
          Gerador.wCampoNFSe(tcDe2, '#23', 'BaseCalculo     ', 01, 15, 1, NFSe.Servico.Valores.BaseCalculo, '');
          Gerador.wCampoNFSe(tcDe4, '#24', 'Aliquota        ', 01, 05, 0, NFSe.Servico.Valores.Aliquota, '');
          Gerador.wCampoNFSe(tcDe2, '#25', 'ValorLiquidoNfse', 01, 15, 0, NFSe.Servico.Valores.ValorLiquidoNfse, '');
          Gerador.wCampoNFSe(tcDe2, '#26', 'ValorIssRetido  ', 01, 15, 0, NFSe.Servico.Valores.ValorIssRetido, '');
         end
         else begin
          Gerador.wCampoNFSe(tcDe2, '#22', 'ValorIssRetido ', 01, 15, 0, NFSe.Servico.Valores.ValorIssRetido, '');
          Gerador.wCampoNFSe(tcDe2, '#23', 'OutrasRetencoes', 01, 15, 0, NFSe.Servico.Valores.OutrasRetencoes, '');

          if (FProvedor = proGinfes)
           then Gerador.wCampoNFSe(tcDe2, '#24', 'BaseCalculo', 01, 15, 1, NFSe.Servico.Valores.BaseCalculo, '')
           else Gerador.wCampoNFSe(tcDe2, '#24', 'BaseCalculo', 01, 15, 0, NFSe.Servico.Valores.BaseCalculo, '');

          // Alterado por Italo em 01/10/2012 
          if (FProvedor in [proSimplISS, proGinfes])
           then Gerador.wCampoNFSe(tcDe2, '#25', 'Aliquota', 01, 05, 0, NFSe.Servico.Valores.Aliquota, '')
           else Gerador.wCampoNFSe(tcDe4, '#25', 'Aliquota', 01, 05, 0, NFSe.Servico.Valores.Aliquota, '');

          Gerador.wCampoNFSe(tcDe2, '#26', 'ValorLiquidoNfse', 01, 15, 0, NFSe.Servico.Valores.ValorLiquidoNfse, '');
         end;

        Gerador.wCampoNFSe(tcDe2, '#27', 'DescontoIncondicionado', 01, 15, 0, NFSe.Servico.Valores.DescontoIncondicionado, '');
        Gerador.wCampoNFSe(tcDe2, '#28', 'DescontoCondicionado  ', 01, 15, 0, NFSe.Servico.Valores.DescontoCondicionado, '');
        Gerador.wGrupoNFSe('/Valores');

        if FProvedor = proBetha
         then Gerador.wCampoNFSe(tcStr, '#29', 'ItemListaServico', 01, 0005, 1, SomenteNumeros(NFSe.Servico.ItemListaServico), '')
         else Gerador.wCampoNFSe(tcStr, '#29', 'ItemListaServico', 01, 0005, 1, NFSe.Servico.ItemListaServico, '');

        Gerador.wCampoNFSe(tcStr, '#30', 'CodigoCnae      ', 01, 0007, 0, SomenteNumeros(NFSe.Servico.CodigoCnae), '');

//        if FProvedor <> proPublica
//         then Gerador.wCampoNFSe(tcStr, '#31', 'CodigoTributacaoMunicipio', 01, 0020, 0, SomenteNumeros(NFSe.Servico.CodigoTributacaoMunicipio), '');

        if FProvedor <> proPublica
         then Gerador.wCampoNFSe(tcStr, '#31', 'CodigoTributacaoMunicipio', 01, 0020, 0, NFSe.Servico.CodigoTributacaoMunicipio, '');

        Gerador.wCampoNFSe(tcStr, '#32', 'Discriminacao', 01, 2000, 1, NFSe.Servico.Discriminacao, '');

        if VersaoXML = '1'
         then Gerador.wCampoNFSe(tcStr, '#33', 'MunicipioPrestacaoServico', 01, 0007, 1, SomenteNumeros(NFSe.Servico.CodigoMunicipio), '')
         else Gerador.wCampoNFSe(tcStr, '#33', 'CodigoMunicipio          ', 01, 0007, 1, SomenteNumeros(NFSe.Servico.CodigoMunicipio), '');

        if Provedor = proSimplISS
         then begin
          for i := 0 to NFSe.Servico.ItemServico.Count - 1 do
           begin
            Gerador.wGrupo('ItensServico');
            Gerador.wCampo(tcStr, '#33a', 'Descricao    ', 01, 100, 1, NFSe.Servico.ItemServico[i].Descricao, '');
            Gerador.wCampo(tcInt, '#33b', 'Quantidade   ', 01, 015, 1, NFSe.Servico.ItemServico[i].Quantidade, '');
            Gerador.wCampo(tcDe2, '#33c', 'ValorUnitario', 01, 015, 1, NFSe.Servico.ItemServico[i].ValorUnitario, '');
            Gerador.wGrupo('/ItensServico');
           end;
          if NFSe.Servico.ItemServico.Count > 10
           then Gerador.wAlerta('#33a', 'ItensServico', 'Itens de Servico', ERR_MSG_MAIOR_MAXIMO + '10');
         end;

        Gerador.wGrupoNFSe('/Servico');
       end;
 end;
end;

procedure TNFSeW.GerarPrestador;
begin
 Gerador.wGrupoNFSe('Prestador');

 if VersaoXML='1'
  then begin
   Gerador.wGrupoNFSe('CpfCnpj');

   if length(trim(NFSe.Prestador.Cnpj))=11
    then Gerador.wCampoNFSe(tcStr, '#34', 'Cpf ', 11, 11, 1, SomenteNumeros(NFSe.Prestador.Cnpj), '')
    else Gerador.wCampoNFSe(tcStr, '#34', 'Cnpj', 14, 14, 1, SomenteNumeros(NFSe.Prestador.Cnpj), '');

   Gerador.wGrupoNFSe('/CpfCnpj');
  end
  else Gerador.wCampoNFSe(tcStr, '#34', 'Cnpj', 14, 14, 1, SomenteNumeros(NFSe.Prestador.Cnpj), '');

 Gerador.wCampoNFSe(tcStr, '#35', 'InscricaoMunicipal', 01, 15, 0, NFSe.Prestador.InscricaoMunicipal, '');
 Gerador.wGrupoNFSe('/Prestador');
end;

procedure TNFSeW.GerarTomador;
begin
 if Provedor = profintelISS
  then Gerador.wGrupoNFSe('TomadorServico')
  else Gerador.wGrupoNFSe('Tomador');

 if NFSe.Tomador.Endereco.UF <> 'EX'
  then begin
   Gerador.wGrupoNFSe('IdentificacaoTomador');

   Gerador.wGrupoNFSe('CpfCnpj');

   if Length(NFSe.Tomador.IdentificacaoTomador.CpfCnpj)<=11
    then Gerador.wCampoNFSe(tcStr, '#36', 'Cpf ', 11, 11, 1, SomenteNumeros(NFSe.Tomador.IdentificacaoTomador.CpfCnpj), '')
    else Gerador.wCampoNFSe(tcStr, '#36', 'Cnpj', 14, 14, 1, SomenteNumeros(NFSe.Tomador.IdentificacaoTomador.CpfCnpj), '');

   Gerador.wGrupoNFSe('/CpfCnpj');
   Gerador.wCampoNFSe(tcStr, '#37', 'InscricaoMunicipal', 01, 15, 0, NFSe.Tomador.IdentificacaoTomador.InscricaoMunicipal, '');
   Gerador.wGrupoNFSe('/IdentificacaoTomador');
  end;

 Gerador.wCampoNFSe(tcStr, '#38', 'RazaoSocial', 001, 115, 0, NFSe.Tomador.RazaoSocial, '');
 Gerador.wGrupoNFSe('Endereco');
 Gerador.wCampoNFSe(tcStr, '#39', 'Endereco   ', 001, 125, 0, NFSe.Tomador.Endereco.Endereco, '');
 Gerador.wCampoNFSe(tcStr, '#40', 'Numero     ', 001, 010, 0, NFSe.Tomador.Endereco.Numero, '');
 Gerador.wCampoNFSe(tcStr, '#41', 'Complemento', 001, 060, 0, NFSe.Tomador.Endereco.Complemento, '');
 Gerador.wCampoNFSe(tcStr, '#42', 'Bairro     ', 001, 060, 0, NFSe.Tomador.Endereco.Bairro, '');

 case Provedor of
  profintelISS,
  proISSIntel,
  proGinfes,
  proThema,
  proProdemge,
  proBetim,
  proWebISS,
  proGovBR,
  proSaatri,
  proRJ,
  proTiplan,
  proBetha: begin
             Gerador.wCampoNFSe(tcStr, '#43', 'CodigoMunicipio', 7, 7, 0, SomenteNumeros(NFSe.Tomador.Endereco.CodigoMunicipio), '');
             Gerador.wCampoNFSe(tcStr, '#44', 'Uf             ', 2, 2, 0, NFSe.Tomador.Endereco.UF, '');
            end;
  else begin
       Gerador.wCampoNFSe(tcStr, '#43', 'Cidade', 007, 007, 0, SomenteNumeros(NFSe.Tomador.Endereco.CodigoMunicipio), '');
       Gerador.wCampoNFSe(tcStr, '#44', 'Estado', 002, 002, 0, NFSe.Tomador.Endereco.UF, '');
       end;
 end;

 Gerador.wCampoNFSe(tcStr, '#45', 'Cep', 008, 008, 0, SomenteNumeros(NFSe.Tomador.Endereco.CEP), '');
 Gerador.wGrupoNFSe('/Endereco');
 Gerador.wGrupoNFSe('Contato');
 Gerador.wCampoNFSe(tcStr, '#46', 'Telefone', 01, 11, 0, SomenteNumeros(NFSe.Tomador.Contato.Telefone), '');
 Gerador.wCampoNFSe(tcStr, '#47', 'Email   ', 01, 80, 0, NFSe.Tomador.Contato.Email, '');
 Gerador.wGrupoNFSe('/Contato');

 if Provedor = profintelISS
  then Gerador.wGrupoNFSe('/TomadorServico')
  else Gerador.wGrupoNFSe('/Tomador');
end;

procedure TNFSeW.GerarIntermediarioServico;
begin
 if NFSe.IntermediarioServico.RazaoSocial<>''
  then begin
   Gerador.wGrupoNFSe('IntermediarioServico');
   Gerador.wCampoNFSe(tcStr, '#48', 'RazaoSocial', 001, 115, 0, NFSe.IntermediarioServico.RazaoSocial, '');

   Gerador.wGrupoNFSe('CpfCnpj');

   if Length(NFSe.IntermediarioServico.CpfCnpj)<=11
    then Gerador.wCampoNFSe(tcStr, '#49', 'Cpf ', 11, 11, 1, SomenteNumeros(NFSe.IntermediarioServico.CpfCnpj), '')
    else Gerador.wCampoNFSe(tcStr, '#49', 'Cnpj', 14, 14, 1, SomenteNumeros(NFSe.IntermediarioServico.CpfCnpj), '');

   Gerador.wGrupoNFSe('/CpfCnpj');

   Gerador.wCampoNFSe(tcStr, '#50', 'InscricaoMunicipal', 01, 15, 0, NFSe.IntermediarioServico.InscricaoMunicipal, '');

   Gerador.wGrupoNFSe('/IntermediarioServico');
  end;
end;

procedure TNFSeW.GerarConstrucaoCivil;
begin
 if NFSe.ConstrucaoCivil.CodigoObra<>''
  then begin
   Gerador.wGrupoNFSe('ConstrucaoCivil');
   Gerador.wCampoNFSe(tcStr, '#51', 'CodigoObra', 01, 15, 1, NFSe.ConstrucaoCivil.CodigoObra, '');
   Gerador.wCampoNFSe(tcStr, '#52', 'Art       ', 01, 15, 1, NFSe.ConstrucaoCivil.Art, '');
   Gerador.wGrupoNFSe('/ConstrucaoCivil');
  end;
end;

procedure TNFSeW.GerarValoresServico;
begin
 Gerador.wGrupoNFSe('ValoresServico');

 Gerador.wCampoNFSe(tcDe2, '#15', 'ValorPis        ', 01, 15, 0, NFSe.Servico.Valores.ValorPis, '');
 Gerador.wCampoNFSe(tcDe2, '#16', 'ValorCofins     ', 01, 15, 0, NFSe.Servico.Valores.ValorCofins, '');
 Gerador.wCampoNFSe(tcDe2, '#17', 'ValorInss       ', 01, 15, 0, NFSe.Servico.Valores.ValorInss, '');
 Gerador.wCampoNFSe(tcDe2, '#18', 'ValorIr         ', 01, 15, 0, NFSe.Servico.Valores.ValorIr, '');
 Gerador.wCampoNFSe(tcDe2, '#19', 'ValorCsll       ', 01, 15, 0, NFSe.Servico.Valores.ValorCsll, '');
 Gerador.wCampoNFSe(tcDe2, '#21', 'ValorIss        ', 01, 15, 1, NFSe.Servico.Valores.ValorIss, '');
 Gerador.wCampoNFSe(tcDe2, '#13', 'ValorLiquidoNfse', 01, 15, 1, NFSe.Servico.Valores.ValorLiquidoNfse, '');
 Gerador.wCampoNFSe(tcDe2, '#13', 'ValorServicos   ', 01, 15, 1, NFSe.Servico.Valores.ValorServicos, '');

 Gerador.wGrupoNFSe('/ValoresServico');
end;

{
procedure TNFSeW.AjustarMunicipioUF(var xUF, xMun: string;
  var cMun: integer; cPais: integer; vxUF, vxMun: string; vcMun: integer);
var
 PaisBrasil : boolean;
begin
 PaisBrasil := cPais = CODIGO_BRASIL;
 cMun       := IIf(PaisBrasil, vcMun, CMUN_EXTERIOR);
 xMun       := IIf(PaisBrasil, vxMun, XMUN_EXTERIOR);
 xUF        := IIf(PaisBrasil, vxUF, UF_EXTERIOR);
 xMun       := ObterNomeMunicipio(xMun, xUF, cMun);
end;

function TNFSeW.ObterNomeMunicipio(const xMun, xUF: string;
  const cMun: integer): string;
var
 i            : integer;
 PathArquivo,
 Codigo       : string;
 List         : TstringList;
begin
 result := '';
 if (FOpcoes.NormatizarMunicipios) and (cMun <> CMUN_EXTERIOR)
  then begin
   PathArquivo := FOpcoes.FPathArquivoMunicipios + 'MunIBGE-UF' + InttoStr(UFparaCodigo(xUF)) + '.txt';
   if FileExists(PathArquivo)
    then begin
     List := TstringList.Create;
     List.LoadFromFile(PathArquivo);
     Codigo := IntToStr(cMun);
     i      := 0;
     while (i < list.count) and (result = '') do
      begin
       if pos(Codigo, List[i]) > 0
        then result := Trim(stringReplace(list[i], codigo, '', []));
       inc(i);
     end;
     List.free;
    end;
  end;
 if result = ''
  then result := xMun;
end;
}
procedure TNFSeW.GerarXML_Provedor_fintelISS;
begin
 Gerador.wGrupoNFSe('InfDeclaracaoPrestacaoServico');
 if FIdentificador = ''
  then Gerador.wGrupoNFSe('Rps')
  else Gerador.wGrupoNFSe('Rps ' + FIdentificador + '="rps' + NFSe.InfID.ID + '"');

 GerarIdentificacaoRPS;

 Gerador.wCampoNFSe(tcDatHor, '#4', 'DataEmissao', 19, 19, 1, NFSe.DataEmissao, DSC_DEMI);

 Gerador.wCampoNFSe(tcStr,    '#9', 'Status     ', 01, 01, 1, StatusRPSToStr(NFSe.Status), '');
 Gerador.wGrupoNFSe('/Rps');

 GerarServico;
 Gerador.wCampoNFSe(tcDatHor, '#4', 'Competencia', 19, 19, 1, NFSe.DataEmissao, DSC_DEMI);

 GerarPrestador;
 GerarTomador;
 GerarIntermediarioServico;
 GerarConstrucaoCivil;

 if (NFSe.RegimeEspecialTributacao <> retNenhum)
  then Gerador.wCampoNFSe(tcStr, '#6', 'RegimeEspecialTributacao', 01, 01, 0, RegimeEspecialTributacaoToStr(NFSe.RegimeEspecialTributacao), '');

 Gerador.wCampoNFSe(tcStr, '#7', 'OptanteSimplesNacional', 01, 01, 1, SimNaoToStr(NFSe.OptanteSimplesNacional), '');
 Gerador.wCampoNFSe(tcStr, '#8', 'IncentivoFiscal       ', 01, 01, 1, SimNaoToStr(NFSe.IncentivadorCultural), '');
 GerarValoresServico;
 Gerador.wGrupoNFSe('/InfDeclaracaoPrestacaoServico');
end;

procedure TNFSeW.GerarXML_Provedor_Saatri;
begin
 Gerador.wGrupoNFSe('InfDeclaracaoPrestacaoServico');
 if FIdentificador = ''
  then Gerador.wGrupoNFSe('Rps')
  else Gerador.wGrupoNFSe('Rps ' + FIdentificador + '="rps' + NFSe.InfID.ID + '"');

 GerarIdentificacaoRPS;

 Gerador.wCampoNFSe(tcDat,    '#4', 'DataEmissao', 19, 19, 1, NFSe.DataEmissao, DSC_DEMI);

 Gerador.wCampoNFSe(tcStr,    '#9', 'Status     ', 01, 01, 1, StatusRPSToStr(NFSe.Status), '');
 Gerador.wGrupoNFSe('/Rps');

 Gerador.wCampoNFSe(tcDat   , '#4', 'Competencia', 19, 19, 1, NFSe.DataEmissao, DSC_DEMI);
 GerarServico;

 GerarPrestador;
 GerarTomador;
 GerarIntermediarioServico;
 GerarConstrucaoCivil;

 if (NFSe.RegimeEspecialTributacao <> retNenhum)
  then Gerador.wCampoNFSe(tcStr, '#6', 'RegimeEspecialTributacao', 01, 01, 0, RegimeEspecialTributacaoToStr(NFSe.RegimeEspecialTributacao), '');

 Gerador.wCampoNFSe(tcStr, '#7', 'OptanteSimplesNacional', 01, 01, 1, SimNaoToStr(NFSe.OptanteSimplesNacional), '');
 Gerador.wCampoNFSe(tcStr, '#8', 'IncentivoFiscal       ', 01, 01, 1, SimNaoToStr(NFSe.IncentivadorCultural), '');
// GerarValoresServico;
 Gerador.wGrupoNFSe('/InfDeclaracaoPrestacaoServico');
end;

end.

