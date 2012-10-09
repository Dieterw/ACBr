unit pnfsConversao;

interface

uses
  SysUtils,
  {$IFNDEF VER130}
    Variants,
  {$ENDIF}
  Classes, pcnConversao;

type
  TStatusACBrNFSe = ( stNFSeIdle, stNFSeRecepcao, stNFSeConsulta, stNFSeCancelamento, stNFSeEmail );
  TLayOut = (LayNfseRecepcaoLote, LayNfseConsultaLote, LayNfseConsultaNfseRps, LayNfseConsultaSitLoteRps,
             LayNfseConsultaNfse, LayNfseCancelaNfse, LayNfseGerar );

  TnfseTagAssinatura = ( taSempre, taNunca, taSomenteSeAssinada, taSomenteParaNaoAssinada );
  TnfsePadraoLayout = ( plABRASF );
  TnfseStatusRPS = ( srNormal, srCancelado );
  TnfseStatusNFSe = ( snNormal, snCancelado );

  TnfseNaturezaOperacao = ( noTributacaoNoMunicipio, noTributacaoForaMunicipio, noIsencao, noImune,
                            noSuspensaDecisaoJudicial, noSuspensaProcedimentoAdministrativo,
                            noNaoIncidencia,
                            noTributacaoNoMunicipio51, noTributacaoNoMunicipioSemISS52, noNaoTributa58,
                            noSimplesNacional59, noTributacaoNoMunicipio61, noTributacaoNoMunicipioSemISS62,
                            noTributacaoForaMunicipio63, noTributacaoForaMunicipioSemISS64,
                            noNaoTributa68, noSimplesNacional69, noNaoTributa78 );

  TnfseExigibilidadeISS = ( exiExigivel, exiNaoIncidencia, exiIsencao, exiExportacao, exiImunidade,
                            exiSuspensaDecisaoJudicial, exiSuspensaProcessoAdministrativo );

  TnfseRegimeEspecialTributacao = ( retNenhum, retMicroempresaMunicipal, retEstimativa, retSociedadeProfissionais, retCooperativa,
                                    retMicroempresarioIndividual, retMicroempresarioEmpresaPP );
  TnfseSimNao = ( snSim, snNao );
  TnfseTipoRPS = ( trRPS, trNFConjugada, trCupom );
  TnfseIndicacaoCpfCnpj = ( iccCPF, iccCNPJ, iccNaoInformado );
  TnfseSituacaoLoteRPS = ( slrNaoRecibo, slrNaoProcessado, slrProcessadoErro, slrProcessadoSucesso );

  TnfseProvedor = ( proNenhum, proTiplan, proISSNET, proWebISS, proGINFES, proDSF, proProdemge, proAbaco, proBetha,
                    proEquiplano, proISSIntel, proProdam, proGovBR, proRecife, proSimplISS, proThema, proRJ,
                    proPublica, profintelISS, proDigifred, proBetim, proSaatri, proFISSLEX );

  TnfseAcao = ( acRecepcionar, acConsSit, acConsLote, acConsNFSeRps, acConsNFSe, acCancelar, acGerar );

  TnfseSituacaoTributaria = ( stRetencao, stNormal, stSubstituicao );

  TnfseResponsavelRetencao = ( rtPrestador, ptTomador );

function PadraoLayoutToStr(const t: TnfsePadraoLayout):string;
function StrToPadraoLayout(var ok: boolean; const s: string):TnfsePadraoLayout;

function StatusRPSToStr(const t: TnfseStatusRPS):string;
function StrToStatusRPS(var ok: boolean; const s: string):TnfseStatusRPS;

function StatusNFSeToStr(const t: TnfseStatusNFSe):string;
function StrToStatusNFSe(var ok: boolean; const s: string):TnfseStatusNFSe;

function NaturezaOperacaoToStr(const t: TnfseNaturezaOperacao):string;
function StrToNaturezaOperacao(var ok: boolean; const s: string):TnfseNaturezaOperacao;

function ExigibilidadeISSToStr(const t: TnfseExigibilidadeISS):string;
function StrToExigibilidadeISS(var ok: boolean; const s: string):TnfseExigibilidadeISS;

function RegimeEspecialTributacaoToStr(const t: TnfseRegimeEspecialTributacao):string;
function StrToRegimeEspecialTributacao(var ok: boolean; const s: string):TnfseRegimeEspecialTributacao;

function SimNaoToStr(const t: TnfseSimNao):string;
function StrToSimNao(var ok: boolean; const s: string):TnfseSimNao;

function TipoRPSToStr(const t: TnfseTipoRPS):string;
function StrToTipoRPS(var ok: boolean; const s: string):TnfseTipoRPS;

function IndicacaoCpfCnpjToStr(const t: TnfseIndicacaoCpfCnpj):string;
function StrToIndicacaoCpfCnpj(var ok: boolean; const s: string):TnfseIndicacaoCpfCnpj;

function SituacaoLoteRPSToStr(const t: TnfseSituacaoLoteRPS):string;
function StrToSituacaoLoteRPS(var ok: boolean; const s: string):TnfseSituacaoLoteRPS;

function ProvedorToStr(const t: TnfseProvedor):string;
function StrToProvedor(var ok: boolean; const s: string):TnfseProvedor;

function CodigoToDesc(const s: string): ansistring;
function CodCidadeToProvedor(const ACodigo: Integer): string;
function CodCidadeToCidade(const ACodigo: Integer): string;

function SituacaoTributariaToStr(const t: TnfseSituacaoTributaria):string;
function StrToSituacaoTributaria(var ok: boolean; const s: string):TnfseSituacaoTributaria;

function ResponsavelRetencaoToStr(const t: TnfseResponsavelRetencao):string;
function StrToResponsavelRetencao(var ok: boolean; const s: string):TnfseResponsavelRetencao;

implementation

// Padrao Layout ***************************************************************

function PadraoLayoutToStr(const t: TnfsePadraoLayout):string;
begin
  result := EnumeradoToStr(t,
                           ['1'],
                           [plABRASF]);
end;

function StrToPadraoLayout(var ok: boolean; const s: string):TnfsePadraoLayout;
begin
  result := StrToEnumerado(ok, s,
                           ['1'],
                           [plABRASF]);
end;

// Status RPS ******************************************************************

function StatusRPSToStr(const t: TnfseStatusRPS):string;
begin
  result := EnumeradoToStr(t,
                           ['1','2'],
                           [srNormal, srCancelado]);
end;

function StrToStatusRPS(var ok: boolean; const s: string):TnfseStatusRPS;
begin
  result := StrToEnumerado(ok, s,
                           ['1','2'],
                           [srNormal, srCancelado]);
end;

// Status NFSe *****************************************************************

function StatusNFSeToStr(const t: TnfseStatusNFSe):string;
begin
  result := EnumeradoToStr(t,
                           ['1','2'],
                           [srNormal, srCancelado]);
end;

function StrToStatusNFSe(var ok: boolean; const s: string):TnfseStatusNFSe;
begin
  result := StrToEnumerado(ok, s,
                           ['1','2'],
                           [snNormal, snCancelado]);
end;

// Natureza Operação ***********************************************************

function NaturezaOperacaoToStr(const t: TnfseNaturezaOperacao):string;
begin
  result := EnumeradoToStr(t,
                           ['1','2','3','4','5','6','7',
                            '51','52','58','59','61','62','63','64','68','69','78'],
                           [noTributacaoNoMunicipio, noTributacaoForaMunicipio,
                            noIsencao, noImune, noSuspensaDecisaoJudicial,
                            noSuspensaProcedimentoAdministrativo,
                            noNaoIncidencia,
                            noTributacaoNoMunicipio51, noTributacaoNoMunicipioSemISS52,
                            noNaoTributa58, noSimplesNacional59, noTributacaoNoMunicipio61,
                            noTributacaoNoMunicipioSemISS62, noTributacaoForaMunicipio63,
                            noTributacaoForaMunicipioSemISS64,
                            noNaoTributa68, noSimplesNacional69, noNaoTributa78]);
end;

function StrToNaturezaOperacao(var ok: boolean; const s: string):TnfseNaturezaOperacao;
begin
  result := StrToEnumerado(ok, s,
                          ['1','2','3','4','5','6','7',
                           '51','52','58','59','61','62','63','64','68','69','78'],
                          [noTributacaoNoMunicipio, noTributacaoForaMunicipio,
                           noIsencao, noImune, noSuspensaDecisaoJudicial,
                           noSuspensaProcedimentoAdministrativo,
                           noNaoIncidencia,
                           noTributacaoNoMunicipio51, noTributacaoNoMunicipioSemISS52,
                           noNaoTributa58, noSimplesNacional59, noTributacaoNoMunicipio61,
                           noTributacaoNoMunicipioSemISS62, noTributacaoForaMunicipio63,
                           noTributacaoForaMunicipioSemISS64,
                           noNaoTributa68, noSimplesNacional69, noNaoTributa78]);
end;

// Exigibilidade ISS ***********************************************************

function ExigibilidadeISSToStr(const t: TnfseExigibilidadeISS):string;
begin
  result := EnumeradoToStr(t,
                           ['1','2','3','4','5','6','7'],
                           [exiExigivel, exiNaoIncidencia, exiIsencao, exiExportacao, exiImunidade,
                            exiSuspensaDecisaoJudicial, exiSuspensaProcessoAdministrativo]);
end;

function StrToExigibilidadeISS(var ok: boolean; const s: string):TnfseExigibilidadeISS;
begin
  result := StrToEnumerado(ok, s,
                          ['1','2','3','4','5','6','7'],
                           [exiExigivel, exiNaoIncidencia, exiIsencao, exiExportacao, exiImunidade,
                            exiSuspensaDecisaoJudicial, exiSuspensaProcessoAdministrativo]);
end;

// Regime Especial de Tributação ***********************************************

function RegimeEspecialTributacaoToStr(const t: TnfseRegimeEspecialTributacao):string;
begin
  result := EnumeradoToStr(t,
                           ['0','1','2','3','4','5','6'],
                           [retNenhum, retMicroempresaMunicipal, retEstimativa,
                            retSociedadeProfissionais, retCooperativa,
                            retMicroempresarioIndividual, retMicroempresarioEmpresaPP]);
end;

function StrToRegimeEspecialTributacao(var ok: boolean; const s: string):TnfseRegimeEspecialTributacao;
begin
  result := StrToEnumerado(ok, s,
                          ['0','1','2','3','4','5','6'],
                          [retNenhum, retMicroempresaMunicipal, retEstimativa,
                           retSociedadeProfissionais, retCooperativa,
                           retMicroempresarioIndividual, retMicroempresarioEmpresaPP]);
end;

// Sim/Nao *********************************************************************

function SimNaoToStr(const t: TnfseSimNao):string;
begin
  result := EnumeradoToStr(t,
                           ['1','2'],
                           [snSim, snNao]);
end;

function StrToSimNao(var ok: boolean; const s: string):TnfseSimNao;
begin
  result := StrToEnumerado(ok, s,
                           ['1','2'],
                           [snSim, snNao]);
end;

// Tipo RPS ********************************************************************

function TipoRPSToStr(const t: TnfseTipoRPS):string;
begin
  result := EnumeradoToStr(t,
                           ['1','2','3'],
                           [trRPS, trNFConjugada, trCupom]);
end;

function StrToTipoRPS(var ok: boolean; const s: string):TnfseTipoRPS;
begin
  result := StrToEnumerado(ok, s,
                           ['1','2','3'],
                           [trRPS, trNFConjugada, trCupom]);
end;

// Indicacao CPF/CNPJ **********************************************************

function IndicacaoCpfCnpjtoStr(const t: TnfseIndicacaoCpfCnpj):string;
begin
  result := EnumeradoToStr(t,
                           ['1','2','3'],
                           [iccCPF, iccCNPJ, iccNaoInformado]);
end;

function StrToIndicacaoCpfCnpj(var ok: boolean; const s: string):TnfseIndicacaoCpfCnpj;
begin
  result := StrToEnumerado(ok, s,
                           ['1','2','3'],
                           [iccCPF, iccCNPJ, iccNaoInformado]);
end;

// Situacao Lote Rps ***********************************************************

function SituacaoLoteRPSToStr(const t: TnfseSituacaoLoteRPS):string;
begin
  result := EnumeradoToStr(t,
                           ['1','2','3','4'],
                           [slrNaoRecibo, slrNaoProcessado, slrProcessadoErro,
                            slrProcessadoSucesso]);
end;

function StrToSituacaoLoteRPS(var ok: boolean; const s: string):TnfseSituacaoLoteRPS;
begin
  result := StrToEnumerado(ok, s,
                           ['1','2','3','4'],
                           [slrNaoRecibo, slrNaoProcessado, slrProcessadoErro,
                            slrProcessadoSucesso]);
end;

// Provedor ********************************************************************

function ProvedorToStr(const t: TnfseProvedor):string;
begin
  result := EnumeradoToStr(t,
                           ['Nenhum', 'Tiplan', 'ISS.NET', 'WebISS', 'GINFES', 'DSF', 'Prodemge', 'Abaco',
                            'Betha', 'Equiplano', 'ISSIntel', 'Prodam', 'GovBR', 'Recife',
                            'SimplISS', 'Thema', 'RJ', 'Publica', 'fintelISS', 'Digifred', 'Betim', 'Saatri',
                            'FISSLEX'],
                           [proNenhum, proTiplan, proISSNET, proWebISS, proGINFES, proDSF, proProdemge, proAbaco,
                            proBetha, proEquiplano, proISSIntel, proProdam, proGovBR, proRecife,
                            proSimplISS, proThema, proRJ, proPublica, profintelISS, proDigifred, proBetim,
                            proSaatri, proFISSLEX]);
end;

function StrToProvedor(var ok: boolean; const s: string):TnfseProvedor;
begin
  result := StrToEnumerado(ok, s,
                           ['Nenhum', 'Tiplan', 'ISS.NET', 'WebISS', 'GINFES', 'DSF', 'Prodemge', 'Abaco',
                            'Betha', 'Equiplano', 'ISSIntel', 'Prodam', 'GovBR', 'Recife',
                            'SimplISS', 'Thema', 'RJ', 'Publica', 'fintelISS', 'Digifred', 'Betim', 'Saatri',
                            'FISSLEX'],
                           [proNenhum, proTiplan, proISSNET, proWebISS, proGINFES, proDSF, proProdemge, proAbaco,
                            proBetha, proEquiplano, proISSIntel, proProdam, proGovBR, proRecife,
                            proSimplISS, proThema, proRJ, proPublica, profintelISS, proDigifred, proBetim,
                            proSaatri, proFISSLEX]);
end;

// Descrição do Serviço ********************************************************

function CodigotoDesc(const s: string): ansistring;
var
 i: Integer;
 r: ansistring;
begin
  i := StrToInt(copy(s, 1, 2) + copy(s, 4, 2));
  r := '';
  case i of
  0101: r := 'Analise e desenvolvimento de sistemas.';
  0102: r := 'Programacao.';
  0103: r := 'Processamento de dados e congeneres.';
  0104: r := 'Elaboracao de programas de computadores, inclusive de jogos eletronicos.';
  0105: r := 'Licenciamento ou cessao de direito de uso de programas de computacao.';
  0106: r := 'Assessoria e consultoria em informatica.';
  0107: r := 'Suporte tecnico em informatica, inclusive instalacao, configuracao e manutencao de programas de computacao e bancos de dados.';
  0108: r := 'Planejamento, confeccao, manutencao e atualizacao de paginas eletronicas.';
  0201: r := 'Servicos de pesquisas e desenvolvimento de qualquer natureza.';
  0301: r := '(VETADO)';
  0302: r := 'Cessao de direito de uso de marcas e de sinais de propaganda.';
  0303: r := 'Exploracao de saloes de festas, centro de convencoes, escritorios virtuais, stands,quadras esportivas, estadios, ' +
             'ginasios, auditorios, casas de espetaculos, parques de diversoes, canchas e congeneres, para realizacao de eventos ou negocios de qualquer natureza.';
  0304: r := 'Locacao, sublocacao, arrendamento, direito de passagem ou permissao de uso, compartilhado ou nao, de ferrovia, rodovia, postes, cabos, dutos e condutos de qualquer natureza.';
  0305: r := 'Cessao de andaimes, palcos, coberturas e outras estruturas de uso temporario.';
  0401: r := 'Medicina e biomedicina.';
  0402: r := 'Analises clinicas, patologia, eletricidade medica, radioterapia, quimioterapia, ultra-sonografia, ressonancia magnetica, radiologia, tomografia e congeneres.';
  0403: r := 'Hospitais, clinicas, laboratorios, sanatorios, manicomios, casas de saude, prontos-socorros, ambulatorios e congeneres.';
  0404: r := 'Instrumentacao cirurgica.';
  0405: r := 'Acupuntura.';
  0406: r := 'Enfermagem, inclusive servicos auxiliares.';
  0407: r := 'Servicos farmaceuticos.';
  0408: r := 'Terapia ocupacional, fisioterapia e fonoaudiologia.';
  0409: r := 'Terapias de qualquer especie destinadas ao tratamento fisico, organico e mental.';
  0410: r := 'Nutricao.';
  0411: r := 'Obstetricia.';
  0412: r := 'Odontologia.';
  0413: r := 'Ortoptica.';
  0414: r := 'Proteses sob encomenda.';
  0415: r := 'Psicanalise.';
  0416: r := 'Psicologia.';
  0417: r := 'Casas de repouso e de recuperacao, creches, asilos e congeneres.';
  0418: r := 'Inseminacao artificial, fertilizacao in vitro e congeneres.';
  0419: r := 'Bancos de sangue, leite, pele, olhos, ovulos, semen e congeneres.';
  0420: r := 'Coleta de sangue, leite, tecidos, semen, orgaos e materiais biologicos de qualquer especie.';
  0421: r := 'Unidade de atendimento, assistencia ou tratamento movel, e congeneres.';
  0422: r := 'Planos de medicina de grupo ou individual e convenios para prestacao de assistencia medica, hospitalar, odontologica e congeneres.';
  0423: r := 'Outros planos de saude que se cumpram atraves de servicos de terceiros contratados, credenciados, cooperados ou apenas pagos pelo operador do plano mediante indicacao do beneficiario.';
  0501: r := 'Medicina veterinaria e zootecnia.';
  0502: r := 'Hospitais, clinicas, ambulatorios, prontos-socorros e congeneres, na area veterinaria.';
  0503: r := 'Laboratorios de analise na area veterinaria.';
  0504: r := 'Inseminacao artificial, fertilizacao in vitro e congeneres.';
  0505: r := 'Bancos de sangue e de orgaos e congeneres.';
  0506: r := 'Coleta de sangue, leite, tecidos, semen, orgaos e materiais biologicos de qualquer especie.';
  0507: r := 'Unidade de atendimento, assistencia ou tratamento movel e congeneres.';
  0508: r := 'Guarda, tratamento, amestramento, embelezamento, alojamento e congeneres.';
  0509: r := 'Planos de atendimento e assistencia medico-veterinaria.';
  0601: r := 'Barbearia, cabeleireiros, manicuros, pedicuros e congeneres.';
  0602: r := 'Esteticistas, tratamento de pele, depilacao e congeneres.';
  0603: r := 'Banhos, duchas, sauna, massagens e congeneres.';
  0604: r := 'Ginastica, danca, esportes, natacao, artes marciais e demais atividades fisicas.';
  0605: r := 'Centros de emagrecimento, spa e congeneres.';
  0701: r := 'Engenharia, agronomia, agrimensura, arquitetura, geologia, urbanismo, paisagismo e congeneres.';
  0702: r := 'Execucao, por administracao, empreitada ou subempreitada, de obras de construcao civil, hidraulica ou eletrica e de ' +
             'outras obras semelhantes, inclusive sondagem, perfuracao de pocos, escavacao, drenagem e irrigacao, terraplanagem, ' +
             'pavimentacao, concretagem e a instalacao e montagem de produtos, pecas e equipamentos (exceto o fornecimento de mercadorias produzidas pelo prestador de servicos fora do local da prestacao dos servicos, que fica sujeito ao ICMS).';
  0703: r := 'Elaboracao de planos diretores, estudos de viabilidade, estudos organizacionais e outros, relacionados com obras e servicos de engenharia; elaboracao de anteprojetos, projetos basicos e projetos executivos para trabalhos de engenharia.';
  0704: r := 'Demolicao.';
  0705: r := 'Reparacao, conservacao e reforma de edificios, estradas, pontes, portos e congeneres (exceto o fornecimento de mercadorias produzidas pelo prestador dos servicos, fora do local da prestacao dos servicos, que fica sujeito ao ICMS).';
  0706: r := 'Colocacao e instalacao de tapetes, carpetes, assoalhos, cortinas, revestimentos de parede, vidros, divisorias, placas de gesso e congeneres, com material fornecido pelo tomador do servico.';
  0707: r := 'Recuperacao, raspagem, polimento e lustracao de pisos e congeneres.';
  0708: r := 'Calafetacao.';
  0709: r := 'Varricao, coleta, remocao, incineracao, tratamento, reciclagem, separacao e destinacao final de lixo, rejeitos e outros residuos Quaisquer. a) reciclagem b) demais casos.';
  0710: r := 'Limpeza, manutencao e conservacao de vias e logradouros publicos, imoveis, chamines, piscinas, parques, jardins e congeneres.';
  0711: r := 'Decoracao e jardinagem, inclusive corte e poda de arvores.';
  0712: r := 'Controle e tratamento de efluentes de qualquer natureza e de agentes fisicos, quimicos e biologicos.';
  0713: r := 'Dedetizacao, desinfeccao, desinsetizacao, imunizacao, higienizacao, desratizacao, pulverizacao e congeneres.';
  0714: r := '(VETADO)';
  0715: r := '(VETADO)';
  0716: r := 'Florestamento, reflorestamento, semeadura, adubacao e congeneres.';
  0717: r := 'Escoramento, contencao de encostas e servicos congeneres.';
  0718: r := 'Limpeza e dragagem de rios, portos, canais, baias, lagos, lagoas, represas, acudes e congeneres.';
  0719: r := 'Acompanhamento e fiscalizacao da execucao de obras de engenharia, arquitetura e urbanismo.';
  0720: r := 'Aerofotogrametria (inclusive interpretacao), cartografia, mapeamento, levantamentos topograficos, batimetricos, geograficos, geodesicos, geologicos, geofisicos e congeneres.';
  0721: r := 'Pesquisa, perfuracao, cimentacao, mergulho, perfilagem, concretacao, testemunhagem, pescaria, estimulacao e outros servicos relacionados com a exploracao e explotacao de petroleo, gas natural e de outros recursos minerais.';
  0722: r := 'Nucleacao e bombardeamento de nuvens e congeneres.';
  0801: r := 'Ensino regular pre-escolar, fundamental, medio e superior.';
  0802: r := 'Instrucao, treinamento, orientacao pedagogica e educacional, avaliacao de conhecimentos de qualquer natureza.';
  0901: r := 'Hospedagem de qualquer natureza em hoteis, apartservice condominiais, flat , apart-hoteis, hoteis residencia, ' +
             'residence-service , suite service , hotelaria maritima, moteis, pensoes e congeneres; ocupacao por temporada com fornecimento de servico (o valor da alimentacao e gorjeta, quando incluido no preco da diaria, fica sujeito ao Imposto Sobre Servicos).';
  0902: r := 'Agenciamento, organizacao, promocao, intermediacao e execucao de programas de turismo, passeios, viagens, excursoes, hospedagens e congeneres.';
  0903: r := 'Guias de turismo.';
  1001: r := 'Agenciamento, corretagem ou intermediacao de cambio, de seguros, de cartoes de credito, de planos de saude e de planos de previdencia privada.';
  1002: r := 'Agenciamento, corretagem ou intermediacao de titulos em geral e valores mobiliarios e contratos quaisquer.';
  1003: r := 'Agenciamento, corretagem ou intermediacao de direitos de propriedade industrial, artistica ou literaria.';
  1004: r := 'Agenciamento, corretagem ou intermediacao de contratos de arrendamento mercantil (leasing), de franquia (franchising) e de faturizacao (factoring).';
  1005: r := 'Agenciamento, corretagem ou intermediacao de bens moveis ou imoveis, nao abrangidos em outros itens ou subitens, inclusive aqueles realizados no ambito de Bolsas de Mercadorias e Futuros, por quaisquer meios.';
  1006: r := 'Agenciamento maritimo.';
  1007: r := 'Agenciamento de noticias.';
  1008: r := 'Agenciamento de publicidade e propaganda, inclusive o agenciamento de veiculacao por quaisquer meios.';
  1009: r := 'Representacao de qualquer natureza, inclusive comercial.';
  1010: r := 'Distribuicao de bens de terceiros.';
  1101: r := 'Guarda e estacionamento de veiculos terrestres automotores, de aeronaves e de embarcacoes.';
  1102: r := 'Vigilancia, seguranca ou monitoramento de bens e pessoas.';
  1103: r := 'Escolta, inclusive de veiculos e cargas.';
  1104: r := 'Armazenamento, deposito, carga, descarga, arrumacao e guarda de bens de qualquer especie.';
  1201: r := 'Espetaculos teatrais.';
  1202: r := 'Exibicoes cinematograficas.';
  1203: r := 'Espetaculos circenses.';
  1204: r := 'Programas de auditorio.';
  1205: r := 'Parques de diversoes, centros de lazer e congeneres.';
  1206: r := 'Boates, taxi-dancing e congeneres.';
  1207: r := 'Shows, ballet, dancas, desfiles, bailes, operas, concertos, recitais, festivais e congeneres.';
  1208: r := 'Feiras, exposicoes, congressos e congeneres.';
  1209: r := 'Bilhares, boliches e diversoes eletronicas ou nao.';
  1210: r := 'Corridas e competicoes de animais.';
  1211: r := 'Competicoes esportivas ou de destreza fisica ou intelectual, com ou sem a participacao do espectador.';
  1212: r := 'Execucao de musica.';
  1213: r := 'Producao, mediante ou sem encomenda previa, de eventos, espetaculos, entrevistas, shows, ballet, dancas, desfiles, bailes, teatros, operas, concertos, recitais, festivais e congeneres.';
  1214: r := 'Fornecimento de musica para ambientes fechados ou nao, mediante transmissao por qualquer processo.';
  1215: r := 'Desfiles de blocos carnavalescos ou folcloricos, trios eletricos e congeneres.';
  1216: r := 'Exibicao de filmes, entrevistas, musicais, espetaculos, shows, concertos, desfiles, operas, competicoes esportivas, de destreza intelectual ou congeneres.';
  1217: r := 'Recreacao e animacao, inclusive em festas e eventos de qualquer natureza.';
  1301: r := '(VETADO)';
  1302: r := 'Fonografia ou gravacao de sons, inclusive trucagem, dublagem, mixagem e congeneres.';
  1303: r := 'Fotografia e cinematografia, inclusive revelacao, ampliacao, copia, reproducao, trucagem e congeneres.';
  1304: r := 'Reprografia, Microfilmagem e digitalizacao.';
  1305: r := 'Composicao grafica, fotocomposicao, clicheria, zincografia, litografia, fotolitografia.';
  1401: r := 'Lubrificacao, limpeza, lustracao, revisao, carga e recarga, conserto, restauracao, blindagem, manutencao e conservacao ' +
             'de maquinas, veiculos, aparelhos, equipamentos, motores, elevadores ou de qualquer objeto (exceto pecas e partes empregadas, que ficam sujeitas ao ICMS).';
  1402: r := 'Assistencia tecnica.';
  1403: r := 'Recondicionamento de motores (exceto pecas e partes empregadas, que ficam sujeitas ao ICMS).';
  1404: r := 'Recauchutagem ou regeneracao de pneus.';
  1405: r := 'Restauracao, recondicionamento, acondicionamento, pintura, beneficiamento, lavagem, secagem, tingimento, galvanoplastia, anodizacao, corte, recorte, polimento, plastificacao e congeneres, de objetos quaisquer.';
  1406: r := 'Instalacao e montagem de aparelhos, maquinas e equipamentos, inclusive montagem industrial, prestados ao usuario final, exclusivamente com material por ele fornecido.';
  1407: r := 'Colocacao de molduras e congeneres.';
  1408: r := 'Encadernacao, gravacao e douracao de livros, revistas e congeneres.';
  1409: r := 'Alfaiataria e costura, quando o material for fornecido pelo usuario final, exceto aviamento.';
  1410: r := 'Tinturaria e lavanderia.';
  1411: r := 'Tapecaria e reforma de estofamentos em geral.';
  1412: r := 'Funilaria e lanternagem.';
  1413: r := 'Carpintaria e serralheria.';
  1501: r := 'Administracao de fundos quaisquer, de consorcio, de cartao de credito ou debito e congeneres, de carteira de clientes, de cheques pre-datados e congeneres.';
  1502: r := 'Abertura de contas em geral, inclusive conta-corrente, conta de investimentos e aplicacao e caderneta de poupanca, no Pais e no exterior, bem como a manutencao das referidas contas ativas e inativas.';
  1503: r := 'Locacao e manutencao de cofres particulares, de terminais eletronicos, de terminais de atendimento e de bens e equipamentos em geral.';
  1504: r := 'Fornecimento ou emissao de atestados em geral, inclusive atestado de idoneidade, atestado de capacidade financeira e congeneres.';
  1505: r := 'Cadastro, elaboracao de ficha cadastral, renovacao cadastral e congeneres, inclusao ou exclusao no Cadastro de Emitentes de Cheques sem Fundos CCF ou em quaisquer outros bancos cadastrais.';
  1506: r := 'Emissao, reemissao e fornecimento de avisos, comprovantes e documentos em geral; abono de firmas; coleta e entrega de ' +
             'documentos, bens e valores; comunicacao com outra agencia ou com a administracao central; licenciamento eletronico de veiculos; transferencia de veiculos; agenciamento fiduciario ou depositario; devolucao de bens em custodia.';
  1507: r := 'Acesso, movimentacao, atendimento e consulta a contas em geral, por qualquer meio ou processo, inclusive por telefone, ' +
             'fac-simile, Internet e telex, acesso a terminais de atendimento, inclusive vinte e quatro horas; acesso a outro banco e a rede compartilhada; fornecimento de saldo, extrato e demais informacoes relativas a contas em geral, por qualquer meio ou processo.';
  1508: r := 'Emissao, reemissao, alteracao, cessao, substituicao, cancelamento e registro de contrato de credito; estudo, analise e ' +
             'avaliacao de operacoes de credito; emissao, concessao, alteracao ou contratacao de aval, fianca, anuencia e congeneres; servicos relativos a abertura de credito, para quaisquer fins.';
  1509: r := 'Arrendamento mercantil (leasing) de quaisquer bens, inclusive cessao de direitos e obrigacoes, substituicao de garantia, alteracao, cancelamento e registro de contrato, e demais servicos relacionados ao arrendamento mercantil (leasing).';
  1510: r := 'Servicos relacionados a cobrancas, recebimentos ou pagamentos em geral, de titulos quaisquer, de contas ou carnes, de ' +
             'cambio, de tributos e por conta de terceiros, inclusive os efetuados por meio eletronico, automatico ou por maquinas de ' +
             'atendimento; fornecimento de posicao de cobranca, recebimento ou pagamento; emissao de carnes, fichas de compensacao, impressos e documentos em geral.';
  1511: r := 'Devolucao de titulos, protesto de titulos, sustacao de protesto, manutencao de titulos, reapresentacao de titulos, e demais servicos a eles relacionados.';
  1512: r := 'Custodia em geral, inclusive de titulos e valores mobiliarios.';
  1513: r := 'Servicos relacionados a operacoes de cambio em geral, edicao, alteracao, prorrogacao, cancelamento e baixa de contrato ' +
             'de cambio; emissao de registro de exportacao ou de credito; cobranca ou deposito no exterior; emissao, fornecimento e ' +
             'cancelamento de cheques de viagem; fornecimento, transferencia, cancelamento e demais servicos relativos a carta de credito de importacao, exportacao e garantias recebidas; envio e recebimento de mensagens em geral relacionadas a operacoes de cambio.';
  1514: r := 'Fornecimento, emissao, reemissao, renovacao e manutencao de cartao magnetico, cartao de credito, cartao de debito, cartao salario e congeneres.';
  1515: r := 'Compensacao de cheques e titulos quaisquer; servicos relacionados a deposito, inclusive deposito identificado, a saque de contas quaisquer, por qualquer meio ou processo, inclusive em terminais eletronicos e de atendimento.';
  1516: r := 'Emissao, reemissao, liquidacao, alteracao, cancelamento e baixa de ordens de pagamento, ordens de credito e similares, ' +
             'por qualquer meio ou processo; servicos relacionados a transferencia de valores, dados, fundos, pagamentos e similares, inclusive entre contas em geral.';
  1517: r := 'Emissao, fornecimento, devolucao, sustacao, cancelamento e oposicao de cheques quaisquer, avulso ou por talao.';
  1518: r := 'Servicos relacionados a credito imobiliario, avaliacao e vistoria de imovel ou obra, analise tecnica e juridica, emissao, ' +
             'reemissao, alteracao, transferencia e renegociacao de contrato, emissao e reemissao do termo de quitacao e demais servicos relacionados a credito imobiliario.';
  1601: r := 'Servicos de transporte de natureza municipal.';
  1701: r := 'Assessoria ou consultoria de qualquer natureza, nao contida em outros itens desta lista; analise, exame, pesquisa, coleta, compilacao e fornecimento de dados e informacoes de qualquer natureza, inclusive cadastro e similares.';
  1702: r := 'Datilografia, digitacao, estenografia, expediente, secretaria em geral, resposta audivel, redacao, edicao, interpretacao, revisao, traducao, apoio e infra-estrutura administrativa e congeneres.';
  1703: r := 'Planejamento, coordenacao, programacao ou organizacao tecnica, financeira ou administrativa.';
  1704: r := 'Recrutamento, agenciamento, selecao e colocacao de mao-de-obra.';
  1705: r := 'Fornecimento de mao-de-obra, mesmo em carater temporario, inclusive de empregados ou trabalhadores, avulsos ou temporarios, contratados pelo prestador de servico.';
  1706: r := 'Propaganda e publicidade, inclusive promocao de vendas, planejamento de campanhas ou sistemas de publicidade, elaboracao de desenhos, textos e demais materiais publicitarios.';
  1707: r := '(VETADO)';
  1708: r := 'Franquia (franchising).';
  1709: r := 'Pericias, laudos, exames tecnicos e analises tecnicas.';
  1710: r := 'Planejamento, organizacao e administracao de feiras, exposicoes, congressos e congeneres.';
  1711: r := 'Organizacao de festas e recepcoes; bufe (exceto o fornecimento de alimentacao e bebidas, que fica sujeito ao ICMS).';
  1712: r := 'Administracao em geral, inclusive de bens e negocios de terceiros.';
  1713: r := 'Leilao e congeneres.';
  1714: r := 'Advocacia.';
  1715: r := 'Arbitragem de qualquer especie, inclusive juridica.';
  1716: r := 'Auditoria.';
  1717: r := 'Analise de Organizacao e Metodos.';
  1718: r := 'Atuaria e calculos tecnicos de qualquer natureza.';
  1719: r := 'Contabilidade, inclusive servicos tecnicos e auxiliares.';
  1720: r := 'Consultoria e assessoria economica ou financeira.';
  1721: r := 'Estatistica.';
  1722: r := 'Cobranca em geral.';
  1723: r := 'Assessoria, analise, avaliacao, atendimento, consulta, cadastro, selecao, gerenciamento de informacoes, administracao de contas a receber ou a pagar e em geral, relacionados a operacoes de faturizacao (factoring).';
  1724: r := 'Apresentacao de palestras, conferencias, seminarios e congeneres.';
  1801: r := 'Servicos de regulacao de sinistros vinculados a contratos de seguros; inspecao e avaliacao de riscos para cobertura de contratos de seguros; prevencao e gerencia de riscos seguraveis e congeneres.';
  1901: r := 'Servicos de distribuicao e venda de bilhetes e demais produtos de loteria, bingos, cartoes, pules ou cupons de apostas, sorteios, premios, inclusive os decorrentes de titulos de capitalizacao e congeneres. a) Bingo; b) Demais casos.';
  2001: r := 'Servicos portuarios, ferroportuarios, utilizacao de porto, movimentacao de passageiros, reboque de embarcacoes, rebocador ' +
             'escoteiro, atracacao, desatracacao, servicos de praticagem, capatazia, armazenagem de qualquer natureza, servicos ' +
             'acessorios, movimentacao de mercadorias, servicos de apoio maritimo, de movimentacao ao largo, servicos de armadores, estiva, conferencia, logistica e congeneres.';
  2002: r := 'Servicos aeroportuarios, utilizacao de aeroporto, movimentacao de passageiros, armazenagem de qualquer natureza, capatazia, ' +
             'movimentacao de aeronaves, servicos de apoio aeroportuarios, servicos acessorios, movimentacao de mercadorias, logistica e congeneres.';
  2003: r := 'Servicos de terminais rodoviarios, ferroviarios, metroviarios, movimentacao de passageiros, mercadorias, inclusive suas operacoes, logistica e congeneres.';
  2101: r := 'Servicos de registros publicos, cartorarios e notariais.';
  2201: r := 'Servicos de exploracao de rodovia mediante cobranca de preco ou pedagio dos usuarios, envolvendo execucao de servicos de ' +
             'conservacao, manutencao, melhoramentos para adequacao de capacidade e seguranca de transito, operacao, monitoracao, assistencia aos usuarios e outros servicos definidos em contratos, atos de concessao ou de permissao ou em normas oficiais.';
  2301: r := 'Servicos de programacao e comunicacao visual, desenho industrial e congeneres.';
  2401: r := 'Servicos de chaveiros, confeccao de carimbos, placas, sinalizacao visual, banners, adesivos e congeneres.';
  2501: r := 'Funerais, inclusive fornecimento de caixao, urna ou esquifes; aluguel de capela; transporte do corpo cadaverico; fornecimento de ' +
             'flores, coroas e outros paramentos; desembaraco de certidao de obito; fornecimento de veu, essa e outros adornos; embalsamento, embelezamento, conservacao ou restauracao de cadaveres.';
  2502: r := 'Cremacao de corpos e partes de corpos cadavericos.';
  2503: r := 'Planos ou convenio funerarios.';
  2504: r := 'Manutencao e conservacao de jazigos e cemiterios.';
  2601: r := 'Servicos de coleta remessa ou entrega de correspondencias, documentos, objetos, bens ou valores, inclusive pelos correios e suas agencias franqueadas; courrier e congeneres.';
  2701: r := 'Servicos de assistencia social.';
  2801: r := 'Servicos de avaliacao de bens e servicos de qualquer natureza.';
  2901: r := 'Servicos de biblioteconomia.';
  3001: r := 'Servicos de biologia, biotecnologia e quimica.';
  3101: r := 'Servicos tecnicos em edificacoes, eletronica, eletrotecnica, mecanica, telecomunicacoes e congeneres.';
  3201: r := 'Servicos de desenhos tecnicos.';
  3301: r := 'Servicos de desembaraco aduaneiro, comissarios, despachantes e congeneres.';
  3401: r := 'Servicos de investigacoes particulares, detetives e congeneres.';
  3501: r := 'Servicos de reportagem, assessoria de imprensa, jornalismo e relacoes publicas.';
  3601: r := 'Servicos de meteorologia.';
  3701: r := 'Servicos de artistas, atletas, modelos e manequins.';
  3801: r := 'Servicos de museologia.';
  3901: r := 'Servicos de ourivesaria e lapidacao (quando o material for fornecido pelo tomador do servico).';
  4001: r := 'Obras de arte sob encomenda.';
  end;

  result := r;
end;

// Provedor com base ao código da cidade ***************************************

function CodCidadeToProvedor(const ACodigo: Integer): string;
var
 Provedor: String;
begin
 Provedor := 'Nenhum';
 case ACodigo of
  1302603, // Manaus/AM
  1500800, // Ananindeua/PA
  1505536, // Parauapebas/PA
  2304400, // Fortaleza/CE
  2504106, // Caruaru/CE
  2507507, // Joao Pessoa/PB
  2704302, // Maceio/AL
  2910727, // Eunapolis/BA
  3115300, // Cataguases/MG
  3137601, // Lagoa Santa/MG
  3147105, // Para de Minas/MG
  3154606, // Ribeirao das Neves/MG
  3169901, // Uba/MG
  3170701, // Varginha/MG
  3300456, // Belford Roxo/RJ
  3301009, // Campos dos Goytacazes/RJ
  3302700, // Marica/RJ
  3503208, // Araraquara/SP
  3506359, // Bertioga/SP
  3511300, // Cedral/SP
  3513009, // Cotia/SP
  3513801, // Diadema/SP
  3516200, // Franca/SP
  3518800, // Guarulhos/SP
  3519071, // Hortolandia/SP
  3523909, // Itu/SP
  3524709, // Jaguariuna/SP
  3525300, // Jau/SP
  3525904, // Jundiai/SP
  3529401, // Maua/SP
  3530508, // Mococa/SP
  3533908, // Olimpia/SP
  3536505, // Paulinia/SP
  3538006, // Pindamonhangaba/SP
  3542602, // Registro/SP
  3543402, // Ribeirao Preto/SP
  3543907, // Rio Claro/SP
  3547809, // Santo Andre/SP
  3548500, // Santos/SP
  3548708, // Sao Bernardo do Campos/SP
  3548807, // Sao Caetano do Sul/SP
  3548909, // Sao Carlos/SP
  3549805, // Sao Jose do Rio Preto/SP
  3549904, // Sao Jose dos Campos/SP
  3554003, // Tatui/SP
  3557105, // Votuporanga/SP
  3704708, // Marechal Deodoro/AL
  4118204, // Paranagua/PR
  4125506, // Sao Jose dos Pinhais/PR
  4128104, // Umuarama/PR
  4309308, // Guaiba/RS
  4314407  // Pelotas/RS
         : Provedor := 'GINFES';

  3530607, // Mogi das Cruzes/SP
  5103403, // Cuiaba/MT
  5201108, // Anapolis/GO
  5201405  // Aparecida de Goiania/GO
         : Provedor := 'ISS.NET';

  2910800, // Feira de Santana/BA
  3104205, // Arcos/MG
  3105608, // Barbacena/MG
  3105905, // Barroso/MG
  3126109, // Formiga/MG
  3170107, // Uberaba/MG
  3303302, // Niteroi/RJ
  5107909  // Sinop/MT
         : Provedor := 'WebISS';

  3118601, // Contagem/MG
  3143302, // Montes Claros/MG
  3202405, // Guarapari/ES
  3305505, // Saquarema/RJ
  4205902, // Gaspar/SC
  4309407  // Guapore/RS
         : Provedor := 'GovBR';

  2611606  // Recife/PE
         : Provedor := 'Recife';

  3106200  // Belo Horizonte/MG
         : Provedor := 'Prodemge';

  3106705  // Betim/MG
         : Provedor := 'Betim';

  3304557  // Rio de Janeiro/RJ
         : Provedor := 'RJ';

  3501608  // Americana/SP
         : Provedor := 'Tiplan';

  3148103, // Patrocinio/MG
  3503307  // Araras/SP
         : Provedor := 'SimplISS';

  4108403  // Francisco Beltrao/PR
         : Provedor := 'Equiplano';

  4119905  // Ponta Grossa/PR
         : Provedor := 'fintelISS';

  3302254, // Itatiaia/RJ
  3303955, // Pinheiral/RJ
  3304508, // Rio das Flores/RJ
  3510104, // Candido Rodrigues/SP
  4100301, // Agudos do Sul/PR
  4100400, // Almirante Tamandaré/PR
  4101002, // Ampére/PR
  4104253, // Campo Magro/PR
  4106407, // Cornélio Procópio/PR
  4107652, // Fazenda Rio Grande/PR
  4108601, // Goioerê/PR
  4114302, // Mandirituba/PR
  4118402, // Paranavaí/PR
  4120853, // Quatro Pontes/PR
  4125605, // São Mateus do Sul/PR
  4128203, // União da Vitória/PR
  4202131, // Bela Vista do Toldo/SC
  4202305, // Biguaçu/SC
  4202453, // Bombinhas/SC
  4203600, // Campos Novos/SC
  4204202, // Chapecó/SC
  4204350, // Cordilheira Alta/SC
  4204509, // Corupá/SC
  4204608, // Criciúma/SC
  4205555, // Frei Rogério/SC
  4205704, // Garopaba/SC
  4206405, // Guaraciaba/SC
  4206900, // Ibirama/SC
  4207304, // Imbituba/SC
  4208302, // Itapema/SC
  4208401, // Itapiranga/SC
  4208500, // Ituporanga/SC
  4209003, // Joaçaba/SC
  4209300, // Lages/SC
  4210001, // Luiz Alves/SC
  4211306, // Navegantes/SC
  4211900, // Palhoça/SC
  4212106, // Palmitos/SC
  4212502, // Penha/SC
  4212908, // Pinhalzinho/SC
  4213104, // Piratuba/SC
  4213153, // Planalto Alegre/SC
  4213708, // Pouso Redondo/SC
  4214805, // Rio do Sul/SC
  4215000, // Rio Negrinho/SC
  4215505, // Santa Cecília/SC
  4215802, // São Bento do Sul/SC
  4216008, // São Carlos/SC
  4216305, // São João Batista/SC
  4216602, // São José/SC
  4216909, // São Lourenço do Oeste/SC
  4217204, // São Miguel do Oeste/SC
  4217402, // Schroeder/SC
  4217600, // Siderópolis/SC
  4217808, // Taió/SC
  4217907, // Tangará/SC
  4219606, // Xavantina/SC
  4219705, // Xaxim/SC
  4302105, // Bento Gonçalves/RS
  4305801, // Constantina/RS
  4318002, // São Borja/RS
  5006200, // Nova Andradina/MS
  5100201, // Água Boa/MT
  5102686, // Campos de Júlio/MT
  5103502  // Diamantino/MT
         : Provedor := 'Betha';

  4208203  // Itajai/SC
         : Provedor := 'Publica';

  4308508  // Frederico Westphalen/RS
         : Provedor := 'Digifred';

  4318705  // Sao Leopoldo/RS
         : Provedor := 'Thema';

  3131307, // Ipatinga/MG
  5107602  // Rondonopolis/MT
         : Provedor := 'ISSIntel';

  1400100  // Boa Vista/RR
         : Provedor := 'Saatri';

  5107958  // Tangara da Serra/MT
         : Provedor := 'FISSLEX';
 end;
 Result := Provedor;
end;

// Nome da cidade com base ao código da cidade *********************************

function CodCidadeToCidade(const ACodigo: Integer): string;
var
 Cidade: String;
begin
 Cidade := '';
 case ACodigo of
  1302603: Cidade := 'Manaus/AM';

  1400100: Cidade := 'Boa Vista/RR';

  1500800: Cidade := 'Ananindeua/PA';
  1505536: Cidade := 'Parauapebas/PA';

  2304400: Cidade := 'Fortaleza/CE';

  2504106: Cidade := 'Caruaru/CE';
  2507507: Cidade := 'João Pessoa/PB';

  2611606: Cidade := 'Recife/PE';

  2704302: Cidade := 'Maceio/AL';

  2910727: Cidade := 'Eunapolis/BA';
  2910800: Cidade := 'Feira de Santana/BA';

  3104205: Cidade := 'Arcos/MG';
  3105608: cidade := 'Barbacena/MG';
  3105905: cidade := 'Barroso/MG';
  3106200: Cidade := 'Belo Horizonte/MG';
  3106705: Cidade := 'Betim/MG';
  3115300: Cidade := 'Cataguases/MG';
  3118601: Cidade := 'Contagem/MG';
  3126109: Cidade := 'Formiga/MG';
  3131307: Cidade := 'Ipatinga/MG';
  3137601: Cidade := 'Lagoa Santa/MG';
  3143302: Cidade := 'Montes Claros/MG';
  3147105: Cidade := 'Para de Minas/MG';
  3148103: Cidade := 'Patrocinio/MG';
  3154606: Cidade := 'Ribeirão das Neves/MG';
  3169901: Cidade := 'Uba/MG';
  3170107: Cidade := 'Uberaba/MG';
  3170701: Cidade := 'Varginha/MG';

  3202405: Cidade := 'Guarapari/ES';

  3300456: Cidade := 'Belford Roxo/RJ';
  3301009: Cidade := 'Campos dos Goytacazes/RJ';
  3302254: Cidade := 'Itatiaia/RJ';
  3302700: Cidade := 'Marica/RJ';
  3303302: Cidade := 'Niteroi/RJ';
  3303955: Cidade := 'Pinheiral/RJ';
  3304508: Cidade := 'Rio das Flores/RJ';
  3304557: Cidade := 'Rio de Janeiro/RJ';
  3305505: Cidade := 'Saquarema/RJ';

  3501608: Cidade := 'Americana/SP';
  3503208: Cidade := 'Araraquara/SP';
  3503307: Cidade := 'Araras/SP';
  3506359: Cidade := 'Bertioga/SP';
  3510104: Cidade := 'Candido Rodrigues/SP';
  3511300: Cidade := 'Cedral/SP';
  3513009: Cidade := 'Cotia/SP';
  3513801: Cidade := 'Diadema/SP';
  3516200: Cidade := 'Franca/SP';
  3518800: Cidade := 'Guarulhos/SP';
  3519071: Cidade := 'Hortolandia/SP';
  3523909: Cidade := 'Itu/SP';
  3524709: Cidade := 'Jaguariuna/SP';
  3525300: Cidade := 'Jau/SP';
  3525904: Cidade := 'Jundiai/SP';
  3529401: Cidade := 'Maua/SP';
  3530508: Cidade := 'Mococa/SP';
  3530607: Cidade := 'Mogi das Cruzes/SP';
  3533908: Cidade := 'Olimpia/SP';
  3536505: Cidade := 'Paulinia/SP';
  3538006: Cidade := 'Pindamonhangaba/SP';
  3542602: Cidade := 'Registro/SP';
  3543402: Cidade := 'Ribeirão Preto/SP';
  3543907: Cidade := 'Rio Claro/SP';
  3547809: Cidade := 'Santo Andre/SP';
  3548500: Cidade := 'Santos/SP';
  3548708: Cidade := 'São Bernardo do Campos/SP';
  3548807: Cidade := 'São Caetano do Sul/SP';
  3548909: Cidade := 'São Carlos/SP';
  3549805: Cidade := 'São José do Rio Preto/SP';
  3549904: Cidade := 'São José dos Campos/SP';
  3554003: Cidade := 'Tatui/SP';
  3557105: Cidade := 'Votuporanga/SP';

  3704708: Cidade := 'Marechal Deodoro/AL';

  4100301: Cidade := 'Agudos do Sul/PR';
  4100400: Cidade := 'Almirante Tamandaré/PR';
  4101002: Cidade := 'Ampére/PR';
  4104253: Cidade := 'Campo Magro/PR';
  4106407: Cidade := 'Cornélio Procópio/PR';
  4107652: Cidade := 'Fazenda Rio Grande/PR';
  4108403: Cidade := 'Francisco Beltrao/PR';
  4108601: Cidade := 'Goioerê/PR';
  4114302: Cidade := 'Mandirituba/PR';
  4118204: Cidade := 'Paranagua/PR';
  4118402: Cidade := 'Paranavaí/PR';
  4119905: Cidade := 'Ponta Grossa/PR';
  4120853: Cidade := 'Quatro Pontes/PR';
  4125506: Cidade := 'Sao José dos Pinhais/PR';
  4125605: Cidade := 'São Mateus do Sul/PR';
  4128104: Cidade := 'Umuarama/PR';
  4128203: Cidade := 'União da Vitória/PR';

  4202131: Cidade := 'Bela Vista do Toldo/SC';
  4202305: Cidade := 'Biguaçu/SC';
  4202453: Cidade := 'Bombinhas/SC';
  4202909: Cidade := 'Brusque/SC';
  4203600: Cidade := 'Campos Novos/SC';
  4204202: Cidade := 'Chapeco/SC';
  4204350: Cidade := 'Cordilheira Alta/SC';
  4204509: Cidade := 'Corupá/SC';
  4204608: Cidade := 'Criciuma/SC';
  4205555: Cidade := 'Frei Rogério/SC';
  4205704: Cidade := 'Garopaba/SC';
  4205902: Cidade := 'Gaspar/SC';
  4206405: Cidade := 'Guaraciaba/SC';
  4206900: Cidade := 'Ibirama/SC';
  4207304: Cidade := 'Imbituba/SC';
  4207502: Cidade := 'Indaial/SC';
  4208203: Cidade := 'Itajai/SC';
  4208302: Cidade := 'Itapema/SC';
  4208401: Cidade := 'Itapiranga/SC';
  4208500: Cidade := 'Ituporanga/SC';
  4209003: Cidade := 'Joaçaba/SC';
  4209300: Cidade := 'Lages/SC';
  4210001: Cidade := 'Luiz Alves/SC';
  4211306: Cidade := 'Navegantes/SC';
  4211900: Cidade := 'Palhoça/SC';
  4212106: Cidade := 'Palmitos/SC';
  4212502: Cidade := 'Penha/SC';
  4212908: Cidade := 'Pinhalzinho/SC';
  4213104: Cidade := 'Piratuba/SC';
  4213153: Cidade := 'Planalto Alegre/SC';
  4213708: Cidade := 'Pouso Redondo/SC';
  4214805: Cidade := 'Rio do Sul/SC';
  4215000: Cidade := 'Rio Negrinho/SC';
  4215505: Cidade := 'Santa Cecília/SC';
  4215802: Cidade := 'São Bento do Sul/SC';
  4216008: Cidade := 'São Carlos/SC';
  4216305: Cidade := 'São João Batista/SC';
  4216602: Cidade := 'Sao José/SC';
  4216909: Cidade := 'São Lourenço do Oeste/SC';
  4217204: Cidade := 'São Miguel do Oeste/SC';
  4217402: Cidade := 'Schroeder/SC';
  4217600: Cidade := 'Siderópolis/SC';
  4217808: Cidade := 'Taió/SC';
  4217907: Cidade := 'Tangará/SC';
  4219606: Cidade := 'Xavantina/SC';
  4219705: Cidade := 'Xaxim/SC';

  4302105: Cidade := 'Bento Gonçalves/RS';
  4305801: Cidade := 'Constantina/RS';
  4308508: Cidade := 'Frederico Westphalen/RS';
  4309308: Cidade := 'Guaiba/RS';
  4309407: Cidade := 'Guapore/RS';
  4314407: Cidade := 'Pelotas/RS';
  4318002: Cidade := 'São Borja/RS';
  4318705: Cidade := 'Sao Leopoldo/RS';

  5006200: Cidade := 'Nova Andradina/MS';

  5100201: Cidade := 'Água Boa/MT';
  5102686: Cidade := 'Campos de Júlio/MT';
  5103403: Cidade := 'Cuiaba/MT';
  5103502: Cidade := 'Diamantino/MT';
  5107602: Cidade := 'Rondonopolis/MT';
  5107909: Cidade := 'Sinop/MT';
  5107958: Cidade := 'Tangara da Serra/MT';

  5201108: Cidade := 'Anapolis/GO';
  5201405: Cidade := 'Aparecida de Goiania/GO';
 end;
 Result := Cidade;
end;

// Situacao Tributária *********************************************************

function SituacaoTributariaToStr(const t: TnfseSituacaoTributaria):string;
begin
  result := EnumeradoToStr(t,
                           ['1','2','3'],
                           [stRetencao, stNormal, stSubstituicao]);
end;

function StrToSituacaoTributaria(var ok: boolean; const s: string):TnfseSituacaoTributaria;
begin
  result := StrToEnumerado(ok, s,
                           ['1','2','3'],
                           [stRetencao, stNormal, stSubstituicao]);
end;

function ResponsavelRetencaoToStr(const t: TnfseResponsavelRetencao):string;
begin
  result := EnumeradoToStr(t,
                           ['1', '2'],
                           [rtPrestador, ptTomador]);
end;

function StrToResponsavelRetencao(var ok: boolean; const s: string):TnfseResponsavelRetencao;
begin
  result := StrToEnumerado(ok, s,
                           ['1', '2'],
                           [rtPrestador, ptTomador]);
end;

end.

