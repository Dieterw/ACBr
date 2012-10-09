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
             LayNfseConsultaNfse, LayNfseCancelaNfse);

  TnfseTagAssinatura = (taSempre, taNunca, taSomenteSeAssinada, taSomenteParaNaoAssinada);
  TnfsePadraoLayout = ( plABRASF, plGINFES );
  TnfseStatusRPS = ( srNormal, srCancelado );
  TnfseStatusNFSe = ( snNormal, snCancelado );
  TnfseNaturezaOperacao = ( noTributacaoNoMunicipio, noTributacaoForaMunicipio, noIsencao, noImune,
                            noSuspensaDecisaoJudicial, noSuspensaProcedimentoAdministrativo );
  TnfseRegimeEspecialTributacao = ( retMicroempresaMunicipal, retEstimativa, retSociedadeProfissionais, retCooperativa,
                                    retMicroempresarioIndividual, retMicroempresarioEmpresaPP );
  TnfseSimNao = ( snSim, snNao );
  TnfseTipoRPS = ( trRPS, trNFConjugada, trCupom );
  TnfseIndicacaoCpfCnpj = ( iccCPF, iccCNPJ, iccNaoInformado );
  TnfseSituacaoLoteRPS = ( slrNaoRecibo, slrNaoProcessado, slrProcessadoErro, slrProcessadoSucesso );

  TnfseProvedor = ( proTiplan, proISSNET, proWebISS, proGINFES, proDSF, proProdemge, proAbaco, proBetha,
                    proEquiplano, proISSIntel, proProdam, proGovBR, proRecife, proSimplISS, proThema, proRJ,
                    proPublica );

function PadraoLayoutToStr(const t: TnfsePadraoLayout):string;
function StrToPadraoLayout(var ok: boolean; const s: string):TnfsePadraoLayout;

function StatusRPSToStr(const t: TnfseStatusRPS):string;
function StrToStatusRPS(var ok: boolean; const s: string):TnfseStatusRPS;

function StatusNFSeToStr(const t: TnfseStatusNFSe):string;
function StrToStatusNFSe(var ok: boolean; const s: string):TnfseStatusNFSe;

function NaturezaOperacaoToStr(const t: TnfseNaturezaOperacao):string;
function StrToNaturezaOperacao(var ok: boolean; const s: string):TnfseNaturezaOperacao;

function RegimeEspecialTributacaoToStr(const t: TnfseRegimeEspecialTributacao):string;
function StrToRegimeEspecialTributacao(var ok: boolean; const s: string):TnfseRegimeEspecialTributacao;

function SimNaoToStr(const t: TnfseSimNao):string;
function StrToSimNao(var ok: boolean; const s: string):TnfseSimNao;

function TipoRPSToStr(const t: TnfseTipoRPS):string;
function StrToTipoRPS(var ok: boolean; const s: string):TnfseTipoRPS;

function IndicacaoCpfCnpjtoStr(const t: TnfseIndicacaoCpfCnpj):string;
function StrToIndicacaoCpfCnpj(var ok: boolean; const s: string):TnfseIndicacaoCpfCnpj;

function SituacaoLoteRPStoStr(const t: TnfseSituacaoLoteRPS):string;
function StrToSituacaoLoteRPS(var ok: boolean; const s: string):TnfseSituacaoLoteRPS;

function ProvedortoStr(const t: TnfseProvedor):string;
function StrToProvedor(var ok: boolean; const s: string):TnfseProvedor;

implementation

// Padrao Layout **************************************************************

function PadraoLayoutToStr(const t: TnfsePadraoLayout):string;
begin
  result := EnumeradoToStr(t,
                           ['1','2'],
                           [plABRASF, plGINFES]);
end;

function StrToPadraoLayout(var ok: boolean; const s: string):TnfsePadraoLayout;
begin
  result := StrToEnumerado(ok, s,
                           ['1','2'],
                           [plABRASF, plGINFES]);
end;

// Status RPS **************************************************************

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

// Status NFSe **************************************************************

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

// Natureza Operação **************************************************************

function NaturezaOperacaoToStr(const t: TnfseNaturezaOperacao):string;
begin
  result := EnumeradoToStr(t,
                           ['1','2','3','4','5','6'],
                           [noTributacaoNoMunicipio, noTributacaoForaMunicipio, noIsencao, noImune, noSuspensaDecisaoJudicial, noSuspensaProcedimentoAdministrativo]);
end;

function StrToNaturezaOperacao(var ok: boolean; const s: string):TnfseNaturezaOperacao;
begin
  result := StrToEnumerado(ok, s,
                          ['1','2','3','4','5','6'],
                          [noTributacaoNoMunicipio, noTributacaoForaMunicipio, noIsencao, noImune, noSuspensaDecisaoJudicial, noSuspensaProcedimentoAdministrativo]);
end;

// Regime Especial de Tributação **************************************************************

function RegimeEspecialTributacaoToStr(const t: TnfseRegimeEspecialTributacao):string;
begin
  result := EnumeradoToStr(t,
                           ['1','2','3','4','5','6'],
                           [retMicroempresaMunicipal, retEstimativa, retSociedadeProfissionais, retCooperativa, retMicroempresarioIndividual, retMicroempresarioEmpresaPP]);
end;

function StrToRegimeEspecialTributacao(var ok: boolean; const s: string):TnfseRegimeEspecialTributacao;
begin
  result := StrToEnumerado(ok, s,
                          ['1','2','3','4','5','6'],
                          [retMicroempresaMunicipal, retEstimativa, retSociedadeProfissionais, retCooperativa, retMicroempresarioIndividual, retMicroempresarioEmpresaPP]);
end;

// Sim/Nao **************************************************************

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

// Tipo RPS **************************************************************

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

// Indicacao CPF/CNPJ **************************************************************

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

// Situacao Lote Rps **************************************************************

function SituacaoLoteRPStoStr(const t: TnfseSituacaoLoteRPS):string;
begin
  result := EnumeradoToStr(t,
                           ['1','2','3','4'],
                           [slrNaoRecibo, slrNaoProcessado, slrProcessadoErro, slrProcessadoSucesso]);
end;

function StrToSituacaoLoteRPS(var ok: boolean; const s: string):TnfseSituacaoLoteRPS;
begin
  result := StrToEnumerado(ok, s,
                           ['1','2','3','4'],
                           [slrNaoRecibo, slrNaoProcessado, slrProcessadoErro, slrProcessadoSucesso]);
end;

// Provedor ***********************************************************************

function ProvedortoStr(const t: TnfseProvedor):string;
begin
  result := EnumeradoToStr(t,
                           ['Tipan', 'ISS.NET', 'WebISS', 'GINFES', 'DSF', 'Prodemge', 'Abaco',
                            'Betha', 'Equiplano', 'ISSIntel', 'Prodam', 'GovBR', 'Recife',
                            'SimplISS', 'Thema', 'RJ', 'Publica'],
                           [proTiplan, proISSNET, proWebISS, proGINFES, proDSF, proProdemge, proAbaco,
                            proBetha, proEquiplano, proISSIntel, proProdam, proGovBR, proRecife,
                            proSimplISS, proThema, proRJ, proPublica]);
end;

function StrToProvedor(var ok: boolean; const s: string):TnfseProvedor;
begin
  result := StrToEnumerado(ok, s,
                           ['Tipan', 'ISS.NET', 'WebISS', 'GINFES', 'DSF', 'Prodemge', 'Abaco',
                            'Betha', 'Equiplano', 'ISSIntel', 'Prodam', 'GovBR', 'Recife',
                            'SimplISS', 'Thema', 'RJ', 'Publica'],
                           [proTiplan, proISSNET, proWebISS, proGINFES, proDSF, proProdemge, proAbaco,
                            proBetha, proEquiplano, proISSIntel, proProdam, proGovBR, proRecife,
                            proSimplISS, proThema, proRJ, proPublica]);
end;

end.

