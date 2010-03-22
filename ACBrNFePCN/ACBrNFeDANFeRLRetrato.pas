{******************************************************************************}
{ Projeto: Componente ACBrNFe                                                  }
{  Biblioteca multiplataforma de componentes Delphi para emissão de Nota Fiscal}
{ eletrônica - NFe - http://www.nfe.fazenda.gov.br                             }
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
|* 20/08/2009: Caique Rodrigues
|*  - Doação units para geração do Danfe via QuickReport
|* 20/11/2009: Peterson de Cerqueira Matos
|*             E-mail: peterson161@yahoo.com - Tel: (11) 7197-1474 / 8059-4055
|*  - Componente e Units do QuickReport clonados
|*    e transformados em FORTES REPORT
|* 27/01/2010: Peterson de Cerqueira Matos
|*  - Inclusão de comandos na procedure "InitDados" para ajuste da largura da
|*    coluna "Código do Produto" que foi definida no componente "ACBrNFeDANFeRL"
|*  - Em casos de DANFE's com mais de uma página, a partir da segunda o canhoto
|*    nao é mais exibido
|* 05/02/2010: Peterson de Cerqueira Matos
|*  - Alteração da quantidade de casas decimais dos campos 'QUANTIDADE' e
|*    'VALOR UNITÁRIO' para 4 casas, conforme consta no 'MANUAL DE INTEGRAÇÃO
|*    DO CONTRIBUINTE'
|*  - Correção na distribuição dos caracteres entre os 'DADOS ADICIONAIS' e a
|*    'CONTINUAÇÃO DOS DADOS ADICIONAIS'
|*  - Inclusão dos campos 'USUÁRIO' e 'SISTEMA' no rodapé do DANFE (só folha 1)
|*  - Inclusão dos campos 'SITE', 'EMAIL' e 'FAX' no quadro do emitente
|*  - Inclusão do 'RESUMO' da NF-e no canhoto
|* 10/02/2010: Peterson de Cerqueira Matos
|*  - Inserção da função 'BuscaDireita', que auxiliará a correção da
|*    exibição dos 'DADOS ADICIONAIS' para evitar que a última palavra do
|*    quadro fique pela metade devido à limitação da quantidade de caracteres
|*  - Correção da formatação de CPF, no caso de NF-e emitida para pessoa física
|* 13/02/2010: Peterson de Cerqueira Matos
|*  - Alteração da fonte do memo 'rlmObsItem' de ARIAL para COURIER NEW
|* 15/03/2010: Felipe Feltes
|*  - Adequação na seção 'USES' para ser utilizado em CLX
|* 19/03/2010: Peterson de Cerqueira Matos
|*  - Tratamento das propriedades "FormularioContinuo", "ExpandirLogoMarca" e
|*    "MostrarPreview" de "ACBrNFeDANFeClass"
|*  - Tratamento da propriedade "PosCanhoto" de "ACBrNFeDANFeRLClass"
******************************************************************************}
{$I ACBr.inc}
unit ACBrNFeDANFeRLRetrato;

interface

uses
  SysUtils, Variants, Classes, 
  {$IFDEF CLX}
  QGraphics, QControls, QForms, QDialogs, QExtCtrls, Qt, QStdCtrls,
  {$ELSE}
  Windows, Messages, Graphics, Controls, Forms, Dialogs, ExtCtrls, MaskUtils, StdCtrls,
  {$ENDIF}
  RLReport, RLFilters, RLPDFFilter, XMLIntf, XMLDoc,
  ACBrNFeDANFeRL, pcnConversao, RLBarcode, jpeg, DB, DBClient, StrUtils;

type
  TfrlDANFeRLRetrato = class(TfrlDANFeRL)
    rlbEmitente: TRLBand;
    rliEmitente: TRLDraw;
    RLDraw6: TRLDraw;
    rliChave: TRLDraw;
    RLDraw8: TRLDraw;
    RLDraw9: TRLDraw;
    RLDraw10: TRLDraw;
    RLDraw11: TRLDraw;
    rllDANFE: TRLLabel;
    rllDocumento1: TRLLabel;
    rllDocumento2: TRLLabel;
    rllTipoEntrada: TRLLabel;
    rllTipoSaida: TRLLabel;
    rliTipoEntrada: TRLDraw;
    rllEntradaSaida: TRLLabel;
    RLLabel12: TRLLabel;
    rllNumNF1: TRLLabel;
    RLLabel14: TRLLabel;
    rllSERIE1: TRLLabel;
    rliChave2: TRLDraw;
    rliChave3: TRLDraw;
    rlbCodigoBarras: TRLBarcode;
    rlbCabecalhoItens: TRLBand;
    rlbDadosAdicionais: TRLBand;
    rlsRectProdutos: TRLDraw;
    lblDadosDoProduto: TRLLabel;
    RLDraw50: TRLDraw;
    RLLabel23: TRLLabel;
    RLDraw51: TRLDraw;
    rlsDivProd1: TRLDraw;
    rlsDivProd2: TRLDraw;
    rlsDivProd3: TRLDraw;
    rlsDivProd4: TRLDraw;
    rlsDivProd5: TRLDraw;
    rlsDivProd6: TRLDraw;
    rlsDivProd7: TRLDraw;
    rlsDivProd8: TRLDraw;
    rlsDivProd9: TRLDraw;
    rlsDivProd10: TRLDraw;
    rlsDivProd11: TRLDraw;
    rlsDivProd12: TRLDraw;
    rlsDivProd13: TRLDraw;
    RLDraw54: TRLDraw;
    rllChaveAcesso: TRLLabel;
    rllDadosVariaveis1a: TRLLabel;
    rllDadosVariaveis1b: TRLLabel;
    rllDadosVariaveis3_Descricao: TRLLabel;
    RLLabel28: TRLLabel;
    RLLabel29: TRLLabel;
    RLLabel30: TRLLabel;
    RLLabel31: TRLLabel;
    RLLabel77: TRLLabel;
    RLLabel78: TRLLabel;
    RLLabel82: TRLLabel;
    RLLabel83: TRLLabel;
    RLLabel84: TRLLabel;
    RLLabel85: TRLLabel;
    RLLabel86: TRLLabel;
    RLLabel87: TRLLabel;
    RLLabel88: TRLLabel;
    RLLabel89: TRLLabel;
    RLLabel90: TRLLabel;
    RLLabel91: TRLLabel;
    RLLabel92: TRLLabel;
    RLLabel93: TRLLabel;
    RLLabel94: TRLLabel;
    RLLabel95: TRLLabel;
    RLLabel96: TRLLabel;
    RLLabel97: TRLLabel;
    RLLabel98: TRLLabel;
    rlmEmitente: TRLMemo;
    rlmEndereco: TRLMemo;
    rllFone: TRLLabel;
    rliLogo: TRLImage;
    rllNatOperacao: TRLLabel;
    rllDadosVariaveis3: TRLLabel;
    rllInscricaoEstadual: TRLLabel;
    rllInscrEstSubst: TRLLabel;
    rllCNPJ: TRLLabel;
    rlmDadosAdicionais: TRLMemo;
    rllChave: TRLLabel;
    rllEmitente: TRLLabel;
    rlbCodigoBarrasFS: TRLBarcode;
    rllXmotivo: TRLLabel;
    rllDadosVariaveis1c: TRLLabel;
    RLPDFFilter1: TRLPDFFilter;
    rlbDestinatario: TRLBand;
    RLLabel18: TRLLabel;
    RLLabel32: TRLLabel;
    rllDestNome: TRLLabel;
    RLLabel35: TRLLabel;
    rllDestEndereco: TRLLabel;
    RLLabel39: TRLLabel;
    rllDestCidade: TRLLabel;
    RLLabel40: TRLLabel;
    rllDestFone: TRLLabel;
    RLLabel36: TRLLabel;
    rllDestBairro: TRLLabel;
    RLLabel41: TRLLabel;
    rllDestUF: TRLLabel;
    RLLabel33: TRLLabel;
    rllDestCNPJ: TRLLabel;
    RLLabel37: TRLLabel;
    rllDestCEP: TRLLabel;
    RLLabel42: TRLLabel;
    rllDestIE: TRLLabel;
    RLLabel34: TRLLabel;
    rllEmissao: TRLLabel;
    RLLabel38: TRLLabel;
    rllSaida: TRLLabel;
    RLLabel43: TRLLabel;
    rllHoraSaida: TRLLabel;
    RLDraw16: TRLDraw;
    RLDraw17: TRLDraw;
    RLDraw22: TRLDraw;
    RLDraw23: TRLDraw;
    RLDraw20: TRLDraw;
    RLDraw19: TRLDraw;
    RLDraw24: TRLDraw;
    RLDraw21: TRLDraw;
    RLDraw18: TRLDraw;
    RLDraw15: TRLDraw;
    rlbFatura: TRLBand;
    RLLabel19: TRLLabel;
    rllFatNum1: TRLLabel;
    rllFatNum2: TRLLabel;
    rllFatNum3: TRLLabel;
    rllFatData1: TRLLabel;
    rllFatData2: TRLLabel;
    rllFatData3: TRLLabel;
    rllFatValor1: TRLLabel;
    rllFatValor2: TRLLabel;
    rllFatValor3: TRLLabel;
    rllFatNum4: TRLLabel;
    rllFatNum5: TRLLabel;
    rllFatNum6: TRLLabel;
    rllFatData4: TRLLabel;
    rllFatData5: TRLLabel;
    rllFatData6: TRLLabel;
    rllFatValor4: TRLLabel;
    rllFatValor5: TRLLabel;
    rllFatValor6: TRLLabel;
    rllFatNum7: TRLLabel;
    rllFatNum8: TRLLabel;
    rllFatNum9: TRLLabel;
    rllFatData7: TRLLabel;
    rllFatData8: TRLLabel;
    rllFatData9: TRLLabel;
    rllFatValor7: TRLLabel;
    rllFatValor8: TRLLabel;
    rllFatValor9: TRLLabel;
    rllFatNum10: TRLLabel;
    rllFatNum11: TRLLabel;
    rllFatNum12: TRLLabel;
    rllFatData10: TRLLabel;
    rllFatData11: TRLLabel;
    rllFatData12: TRLLabel;
    rllFatValor10: TRLLabel;
    rllFatValor11: TRLLabel;
    rllFatValor12: TRLLabel;
    RLDraw26: TRLDraw;
    RLDraw27: TRLDraw;
    RLDraw28: TRLDraw;
    RLDraw25: TRLDraw;
    rlbImposto: TRLBand;
    RLLabel20: TRLLabel;
    RLLabel44: TRLLabel;
    rllBaseICMS: TRLLabel;
    RLLabel49: TRLLabel;
    rllValorFrete: TRLLabel;
    RLLabel45: TRLLabel;
    rllValorICMS: TRLLabel;
    RLLabel50: TRLLabel;
    rllValorSeguro: TRLLabel;
    RLLabel51: TRLLabel;
    rllDescontos: TRLLabel;
    RLLabel46: TRLLabel;
    rllBaseICMST: TRLLabel;
    RLLabel52: TRLLabel;
    rllAcessorias: TRLLabel;
    RLLabel47: TRLLabel;
    rllValorICMST: TRLLabel;
    RLLabel53: TRLLabel;
    rllValorIPI: TRLLabel;
    RLLabel48: TRLLabel;
    rllTotalProdutos: TRLLabel;
    RLLabel54: TRLLabel;
    rllTotalNF: TRLLabel;
    RLDraw30: TRLDraw;
    RLDraw32: TRLDraw;
    RLDraw33: TRLDraw;
    RLDraw34: TRLDraw;
    RLDraw35: TRLDraw;
    RLDraw36: TRLDraw;
    RLDraw31: TRLDraw;
    RLDraw29: TRLDraw;
    RLDraw37: TRLDraw;
    rlbTransportadora: TRLBand;
    RLLabel21: TRLLabel;
    RLLabel55: TRLLabel;
    rllTransNome: TRLLabel;
    RLLabel63: TRLLabel;
    rllTransEndereco: TRLLabel;
    RLLabel67: TRLLabel;
    rllTransQTDE: TRLLabel;
    RLLabel68: TRLLabel;
    rllTransEspecie: TRLLabel;
    RLLabel69: TRLLabel;
    rllTransMarca: TRLLabel;
    RLLabel56: TRLLabel;
    RLLabel57: TRLLabel;
    RLLabel58: TRLLabel;
    RLLabel64: TRLLabel;
    rllTransCidade: TRLLabel;
    RLLabel70: TRLLabel;
    rllTransNumeracao: TRLLabel;
    rllTransModFrete: TRLLabel;
    RLDraw55: TRLDraw;
    RLLabel59: TRLLabel;
    rllTransCodigoANTT: TRLLabel;
    RLLabel60: TRLLabel;
    rllTransPlaca: TRLLabel;
    RLLabel71: TRLLabel;
    rllTransPesoBruto: TRLLabel;
    RLLabel61: TRLLabel;
    rllTransUFPlaca: TRLLabel;
    RLLabel65: TRLLabel;
    rllTransUF: TRLLabel;
    RLLabel62: TRLLabel;
    rllTransCNPJ: TRLLabel;
    RLLabel66: TRLLabel;
    rllTransIE: TRLLabel;
    RLLabel72: TRLLabel;
    rllTransPesoLiq: TRLLabel;
    RLDraw38: TRLDraw;
    RLDraw39: TRLDraw;
    RLDraw46: TRLDraw;
    RLDraw45: TRLDraw;
    RLDraw41: TRLDraw;
    RLDraw44: TRLDraw;
    RLDraw47: TRLDraw;
    RLDraw48: TRLDraw;
    RLDraw49: TRLDraw;
    RLDraw42: TRLDraw;
    RLDraw40: TRLDraw;
    rlbEnderecoEntrega: TRLBand;
    RLLabel15: TRLLabel;
    RLDraw53: TRLDraw;
    RLLabel17: TRLLabel;
    rllEntregaEndereco: TRLLabel;
    RLLabel99: TRLLabel;
    rllEntregaMunicipio: TRLLabel;
    RLLabel103: TRLLabel;
    rllEntregaBairro: TRLLabel;
    RLLabel105: TRLLabel;
    rllEntregaUF: TRLLabel;
    rllEntregaCEP: TRLLabel;
    RLLabel111: TRLLabel;
    rllEntregaCNPJ: TRLLabel;
    RLDraw60: TRLDraw;
    RLDraw61: TRLDraw;
    RLDraw63: TRLDraw;
    RLDraw65: TRLDraw;
    RLDraw43: TRLDraw;
    RLLabel109: TRLLabel;
    rllTipoVenda: TRLLabel;
    RLLabel25: TRLLabel;
    RLLabel26: TRLLabel;
    rlbEnderecoRetirada: TRLBand;
    RLDraw59: TRLDraw;
    RLLabel27: TRLLabel;
    RLDraw62: TRLDraw;
    RLLabel100: TRLLabel;
    rllRetiradaEndereco: TRLLabel;
    RLLabel102: TRLLabel;
    rllRetiradaMunicipio: TRLLabel;
    RLLabel106: TRLLabel;
    rllRetiradaBairro: TRLLabel;
    RLLabel108: TRLLabel;
    rllRetiradaUF: TRLLabel;
    rllRetiradaCEP: TRLLabel;
    RLLabel113: TRLLabel;
    rllRetiradaCNPJ: TRLLabel;
    RLDraw64: TRLDraw;
    RLDraw66: TRLDraw;
    RLDraw67: TRLDraw;
    RLDraw68: TRLDraw;
    RLLabel115: TRLLabel;
    cdsItens: TClientDataSet;
    cdsItensCODIGO: TStringField;
    cdsItensDESCRICAO: TStringField;
    cdsItensNCM: TStringField;
    cdsItensCFOP: TStringField;
    cdsItensUNIDADE: TStringField;
    cdsItensQTDE: TStringField;
    cdsItensVALOR: TStringField;
    cdsItensTOTAL: TStringField;
    cdsItensCST: TStringField;
    cdsItensBICMS: TStringField;
    cdsItensALIQICMS: TStringField;
    cdsItensVALORICMS: TStringField;
    cdsItensALIQIPI: TStringField;
    cdsItensVALORIPI: TStringField;
    rlbItens: TRLBand;
    rlbISSQN: TRLBand;
    RLLabel24: TRLLabel;
    RLLabel73: TRLLabel;
    RLLabel74: TRLLabel;
    RLLabel75: TRLLabel;
    RLLabel76: TRLLabel;
    RLDraw56: TRLDraw;
    RLDraw57: TRLDraw;
    RLDraw58: TRLDraw;
    RLDraw52: TRLDraw;
    DataSource1: TDataSource;
    LinhaDescricao: TRLDraw;
    LinhaNCM: TRLDraw;
    LinhaCST: TRLDraw;
    LinhaCFOP: TRLDraw;
    LinhaUnidade: TRLDraw;
    LinhaQuantidade: TRLDraw;
    LinhaValorUnitario: TRLDraw;
    LinhaValorTotal: TRLDraw;
    LinhaBaseICMS: TRLDraw;
    LinhaValorICMS: TRLDraw;
    LinhaValorIPI: TRLDraw;
    LinhaAliqICMS: TRLDraw;
    LinhaAliqIPI: TRLDraw;
    LinhaCodigo: TRLDraw;
    LinhaFinal: TRLDraw;
    rliMarcaDagua1: TRLImage;
    txtCodigo: TRLDBText;
    txtNCM: TRLDBText;
    txtCST: TRLDBText;
    txtCFOP: TRLDBText;
    txtUnidade: TRLDBText;
    txtQuantidade: TRLDBText;
    txtValorUnitario: TRLDBText;
    txtValorTotal: TRLDBText;
    txtBaseICMS: TRLDBText;
    txtValorICMS: TRLDBText;
    txtValorIPI: TRLDBText;
    txtAliqICMS: TRLDBText;
    txtAliqIPI: TRLDBText;
    rllPageNumber: TRLSystemInfo;
    rllLastPage: TRLSystemInfo;
    rlbAvisoContingencia: TRLBand;
    rllAvisoContingencia: TRLLabel;
    rlbContinuacaoInformacoesComplementares: TRLBand;
    RLLabel16: TRLLabel;
    rlmContinuacaoDadosAdicionais: TRLMemo;
    rllHomologacao: TRLLabel;
    rlmDadosAdicionaisAuxiliar: TRLMemo;
    rlmDescricao: TRLDBMemo;
    LinhaDCSuperior: TRLDraw;
    LinhaDCInferior: TRLDraw;
    LinhaDCEsquerda: TRLDraw;
    LinhaDCDireita: TRLDraw;
    rllCabFatura1: TRLLabel;
    rllCabFatura2: TRLLabel;
    rllCabFatura3: TRLLabel;
    rllCabFatura4: TRLLabel;
    rllCabFatura5: TRLLabel;
    rllCabFatura6: TRLLabel;
    rllCabFatura7: TRLLabel;
    rllCabFatura8: TRLLabel;
    rllCabFatura9: TRLLabel;
    rllCabFatura10: TRLLabel;
    rllCabFatura11: TRLLabel;
    rllCabFatura12: TRLLabel;
    RLDraw69: TRLDraw;
    RLLabel101: TRLLabel;
    rllISSQNValorServicos: TRLLabel;
    rllISSQNBaseCalculo: TRLLabel;
    rllISSQNValorISSQN: TRLLabel;
    rllISSQNInscricao: TRLLabel;
    rlbObsItem: TRLBand;
    LinhaFimItens: TRLDraw;
    LinhaFimObsItem: TRLDraw;
    LinhaInicioItem: TRLDraw;
    rlmObsItem: TRLMemo;
    LinhaObsItemEsquerda: TRLDraw;
    LinhaObsItemDireita: TRLDraw;
    RLDraw70: TRLDraw;
    RLDraw71: TRLDraw;
    rlmDescricaoProduto: TRLMemo;
    rlmCodProd: TRLMemo;
    rlmSiteEmail: TRLMemo;
    rlbReciboHeader: TRLBand;
    rlCanhoto: TRLDraw;
    rliCanhoto1: TRLDraw;
    rliCanhoto2: TRLDraw;
    rllRecebemosDe: TRLLabel;
    rllDataRecebimento: TRLLabel;
    rllIdentificacao: TRLLabel;
    rliCanhoto3: TRLDraw;
    rllNFe: TRLLabel;
    RLLabel4: TRLLabel;
    rllNumNF0: TRLLabel;
    RLLabel6: TRLLabel;
    rllSERIE0: TRLLabel;
    rllResumo: TRLLabel;
    rlbDivisaoRecibo: TRLBand;
    rliDivisao: TRLDraw;
    rllUsuario: TRLLabel;
    rllSistema: TRLLabel;
    procedure RLNFeBeforePrint(Sender: TObject; var PrintIt: Boolean);
    procedure rlbEmitenteBeforePrint(Sender: TObject;
      var PrintIt: Boolean);
    procedure rlbItensAfterPrint(Sender: TObject);
    procedure rlbDadosAdicionaisBeforePrint(Sender: TObject;
      var PrintIt: Boolean);
  private
    FRecebemoDe : string;
    procedure InitDados;
    procedure Header;
    procedure Emitente;
    procedure Destinatario;
    procedure EnderecoRetirada;
    procedure EnderecoEntrega;
    procedure Imposto;
    procedure Transporte;
    procedure DadosAdicionais;
    procedure Observacoes;
    procedure Itens;
    procedure ISSQN;
    procedure AddFatura;
    function BuscaDireita(Busca, Text: String): Integer;
  public

  end;

implementation

uses ACBrNFeUtil, pcnNFe;

var iLimiteLinhas: Integer = 10;
iLinhasUtilizadas: Integer = 0;
iLimiteCaracteresLinha: Integer = 79;
iLimiteCaracteres: Integer = 790;
q, iQuantItens, iCaracteres: Integer;
sTexto: WideString;

{$R *.dfm}

function TfrlDANFeRLRetrato.BuscaDireita(Busca, Text: String): Integer;
{Pesquisa um caractere à direita da string, retornando sua posição}
var n, retorno: integer;
begin
  retorno := 0;
    for n := length(Text) downto 1 do
      begin
        if Copy(Text, n, 1) = Busca then
          begin
            retorno := n;
            break;
         end;
      end;
  Result := retorno;
end;

procedure TfrlDANFeRLRetrato.RLNFeBeforePrint(Sender: TObject;
  var PrintIt: Boolean);
begin
  case FPosCanhoto of
    pcCabecalho:
      begin
        rlbReciboHeader.BandType := btHeader;
        rlbDivisaoRecibo.BandType := btHeader;
        rlbReciboHeader.Top := 19;
        rlbDivisaoRecibo.Top := 76;
        rlbReciboHeader.Height := 57;
        rlbDadosAdicionais.Height := 184;
      end;
    pcRodape:
      begin
        rlbReciboHeader.Height := 80;
        rlbReciboHeader.BandType := btFooter;
        rlbDivisaoRecibo.BandType := btFooter;
        rlbReciboHeader.Top := 1042;
        rlbDivisaoRecibo.Top := 1025;
        rlbDadosAdicionais.Height := 166;
      end;
  end;

  if FFormularioContinuo = True then
    begin
      rllRecebemosDe.Visible := False;
      rllResumo.Visible := False;
      rllDataRecebimento.Visible := False;
      rllIdentificacao.Visible := False;
      rllNFe.Visible := False;
      rlCanhoto.Visible := False;
      rliCanhoto1.Visible := False;
      rliCanhoto2.Visible := False;
      rliCanhoto3.Visible := False;
      rliDivisao.Visible := False;
      rliTipoEntrada.Visible := False;
      rllDANFE.Visible := False;
      rllDocumento1.Visible := False;
      rllDocumento2.Visible := False;
      rllTipoEntrada.Visible := False;
      rllTipoSaida.Visible := False;
      rllEmitente.Visible := False;
      rliLogo.Visible := False;
      rlmEmitente.Visible := False;
      rlmEndereco.Visible := False;
      rllFone.Visible := False;
      rlmSiteEmail.Visible := False;
      rliEmitente.Visible := False;
      rllChaveAcesso.Visible := False;
      rliChave.Visible := False;
      rliChave2.Visible := False;
      rliChave3.Visible := False;
    end;

  if FExpandirLogoMarca = True then
    begin
      rlmEmitente.Visible := False;
      rlmEndereco.Visible := False;
      rllFone.Visible := False;
      rlmSiteEmail.Visible := False;
      with rliLogo do
        begin
          Height := 101;
          Width := 286;
          Top := 14;
          Left := 2;
          Scaled := False;
          Stretch := True;
        end;
    end;

  q := 0;
  InitDados;
  RLNFe.Title := Copy (FNFe.InfNFe.Id, 4, 44);
end;

procedure TfrlDANFeRLRetrato.rlbEmitenteBeforePrint(Sender: TObject;
  var PrintIt: Boolean);
begin
  rlbCodigoBarras.BringToFront;
  if RLNFe.PageNumber > 1 then
    begin
      rlbISSQN.Visible := False;
      rlbDadosAdicionais.Visible := False;
      rlbReciboHeader.Visible := False;
      rlbDivisaoRecibo.Visible := False;
      if iQuantItens > q then
        begin
          rlbCabecalhoItens.Visible := True;
          lblDadosDoProduto.Caption := 'CONTINUAÇÃO DOS ' + lblDadosDoProduto.Caption;
          rliMarcaDagua1.Top := 300;
        end
      else
        rlbCabecalhoItens.Visible := False;

    end;
end;

procedure TfrlDANFeRLRetrato.InitDados;
var h, iAlturaCanhoto: Integer;
begin
  if (FLogo <> '') and FileExists (FLogo) then
     rliLogo.Picture.LoadFromFile(FLogo);

  if (FMarcaDagua <> '') and FileExists (FMarcaDagua) then
    begin
      rliMarcaDagua1.Picture.LoadFromFile(FMarcaDagua);
    end;

  if FResumoCanhoto = True then
    begin
      rllResumo.Caption := 'EMISSÃO: ' + FormatDateTime('DD/MM/YYYY', FNFe.Ide.dEmi) + '  -  ' +
                           'DEST. / REM.: ' + FNFe.Dest.xNome + '  -  ' +
                           'VALOR TOTAL: R$ ' + NotaUtil.FormatFloat(FNFe.Total.ICMSTot.vNF, '###,###,###,##0.00');
      rllResumo.Visible := True;
      iAlturaCanhoto := 25;
    end
  else
    begin
      rllResumo.Visible := False;
      iAlturaCanhoto := 17;
    end;
  rliCanhoto1.Top := iAlturaCanhoto;
  rliCanhoto2.Top := iAlturaCanhoto;
  rliCanhoto2.Height := 57 - iAlturaCanhoto;
  rllDataRecebimento.Top := iAlturaCanhoto + 3;
  rllIdentificacao.Top := iAlturaCanhoto + 3;

  if FSsitema <> '' then
    begin
      rllSistema.Caption := 'DESENVOLVIDO POR ' + FSsitema;
      rllSistema.Visible := True;
    end
  else
    rllSistema.Visible := False;

  if FUsuario <> '' then
    begin
      rllUsuario.Caption := 'DATA / HORA DA IMPRESSÃO: ' + DateTimeToStr(Now) + ' - ' + FUsuario;
      rllUsuario.Visible := True;
    end
  else
    rllUsuario.Visible := False;

  if FNFe.Ide.tpAmb = taHomologacao then
    begin
      rllHomologacao.Caption := 'AMBIENTE DE HOMOLOGAÇÃO - NF-E SEM VALOR FISCAL';
      rllHomologacao.Visible := True;
    end
  else
    begin
      rllHomologacao.Caption := '';
      rllHomologacao.Visible := False;
    end;

  if FNFe.procNFe.cStat > 0 then
    begin
      if FNFe.procNFe.cStat = 100 then
        begin
          rlbCodigoBarras.Visible := True;
          rllXMotivo.Visible := False;
          rllDadosVariaveis3_Descricao.Caption := 'PROTOCOLO DE AUTORIZAÇÃO DE USO';
          rllDadosVariaveis3_Descricao.Visible := True;
        end;
      if FNFe.procNFe.cStat = 101 then
        begin
          rlbCodigoBarras.Visible := False;
          rllXmotivo.Caption := 'NF-e CANCELADA';
          rllXmotivo.Visible := True;
          rllDadosVariaveis3_Descricao.Caption := 'PROTOCOLO DE HOMOLOGAÇÃO DE CANCELAMENTO';
          rllDadosVariaveis3_Descricao.Visible := True;
        end;
      if FNFe.procNFe.cStat = 102 then
        begin
          rlbCodigoBarras.Visible := False;
          rllXmotivo.Caption := 'NF-e DENEGADA';
          rllXmotivo.Visible := True;
          rllDadosVariaveis3_Descricao.Caption := 'PROTOCOLO DE DENEGAÇÃO DE USO';
          rllDadosVariaveis3_Descricao.Visible := True;
        end;
      if not FNFe.procNFe.cStat in [100, 101, 103] then
        begin
          rlbCodigoBarras.Visible := False;
          rllXmotivo.Caption := FNFe.procNFe.xMotivo;
          rllXmotivo.Visible := True;
          rllDadosVariaveis3_Descricao.Visible := False;
          rllDadosVariaveis3.Visible := False;
        end;
    end
  else
    begin
      if FNFe.Ide.tpEmis in [teNormal, teSCAN] then
        begin
          rlbCodigoBarras.Visible := False;
          rllXmotivo.Caption := 'NF-E NÃO ENVIADA PARA SEFAZ';
          rllXMotivo.Visible := True;
          rllDadosVariaveis3_Descricao.Visible := False;
          rllDadosVariaveis3.Visible := False;
        end;
    end;

  // Ajusta a largura da coluna "Código do Produto"
  txtCodigo.Width := FLarguraCodProd;
  rlmCodProd.Width := FLarguraCodProd;
  rlsDivProd1.Left := FLarguraCodProd + 2;
  LinhaDescricao.Left :=  FLarguraCodProd + 2;
  rlmDescricaoProduto.Left := rlsDivProd1.Left + 2;
  rlmDescricaoProduto.Width := (rlsDivProd2.Left - rlsDivProd1.Left) - 3;
  rlmDescricao.Left := LinhaDescricao.Left + 2;
  rlmDescricao.Width := (LinhaNCM.Left - LinhaDescricao.Left) - 24;
  rlmDescricaoProduto.Lines.BeginUpdate;
  rlmDescricaoProduto.Lines.Clear;
  rlmCodProd.Lines.BeginUpdate;
  rlmCodProd.Lines.Clear;

  if rlmCodProd.Width > 90 then
    begin
      rlmCodProd.Top := 18;
      rlmCodProd.Height := 7;
    end
  else
    begin
      rlmCodProd.Top := 14;
      rlmCodProd.Height := 14;
    end;

  if rlmCodProd.Width > 113 then
    rlmCodProd.Lines.Add('CÓDIGO DO PRODUTO / SERVIÇO')
  else
    rlmCodProd.Lines.Add('CÓDIGO DO PROD. / SERV.');

  if rlmDescricaoProduto.Width > 128 then
    begin
      rlmDescricaoProduto.Top := 18;
      rlmDescricaoProduto.Height := 7;
    end
  else
    begin
      rlmDescricaoProduto.Top := 14;
      rlmDescricaoProduto.Height := 14;
    end;

  if rlmDescricaoProduto.Width > 72 then
    rlmDescricaoProduto.Lines.Add('DESCRIÇÃO DO PRODUTO / SERVIÇO')
  else
    rlmDescricaoProduto.Lines.Add('DESCR. PROD. / SERV.');

  rlmCodProd.Lines.EndUpdate;
  rlmDescricaoProduto.Lines.EndUpdate;

  EnderecoRetirada;
  EnderecoEntrega;
  DadosAdicionais;
  Header;
  Emitente;
  Destinatario;
  Imposto;
  Itens;
  ISSQN;
  Transporte;
  AddFatura;
  Observacoes;
  if iCaracteres > iLimiteCaracteres then
    begin
      rlbContinuacaoInformacoesComplementares.Visible := True;
      h := (rlmContinuacaoDadosAdicionais.Top - LinhaDCSuperior.Top) +
            rlmContinuacaoDadosAdicionais.Height;
      LinhaDCInferior.Top := h;
      h := (h - LinhaDCSuperior.Top) + 1;
      LinhaDCEsquerda.Height := h;
      LinhaDCDireita.Height := h;
    end
  else
    begin
      rlbContinuacaoInformacoesComplementares.Visible := False;
    end;

    iQuantItens := FNFe.Det.Count;
end;

procedure TfrlDANFeRLRetrato.Header;
var sChaveContingencia: String;
begin
  with FNFe.InfNFe, FNFe.Ide do
  begin
     rllChave.Caption := NotaUtil.FormatarChaveAcesso (Copy (FNFe.InfNFe.Id, 4, 44));
     rlbCodigoBarras.Caption := Copy (FNFe.InfNFe.Id, 4, 44);
     rllNumNF0.Caption := FormatFloat ('000,000,000', nNF);
     rllNumNF1.Caption := FormatFloat ('000,000,000', nNF);
     rllSERIE0.Caption := IntToStr(Serie);
     rllSERIE1.Caption := IntToStr(Serie);
     rllNatOperacao.Caption :=  NatOp;
     if tpNF = tnEntrada  then // = entrada
        rllEntradaSaida.Caption := '0'
     else
        rllEntradaSaida.Caption := '1';

    rllEmissao.Caption   := NotaUtil.FormatDate(DateToStr(dEmi));
    rllSaida.Caption     := IfThen(DSaiEnt <> 0, NotaUtil.FormatDate(DateToStr(dSaiEnt)));
    rllHoraSaida.Caption := ''; // nao tem campo ;

    if FNFe.Ide.tpEmis in [teNormal, teSCAN] then
      begin
        rllDadosVariaveis1a.Visible := True;
        rllDadosVariaveis1b.Visible := True;
        rllDadosVariaveis1c.Visible := True;
        rlbCodigoBarrasFS.Visible := False;
        rllDadosVariaveis3.Caption := FNFe.procNFe.nProt + ' ' +
                                          DateTimeToStr(FNFe.procNFe.dhRecbto);
        rllAvisoContingencia.Visible := False;
        rlbAvisoContingencia.Visible := False;
      end
    else if FNFe.Ide.tpEmis in [teContingencia, teFSDA] then
      begin
        sChaveContingencia := NotaUtil.GerarChaveContingencia(FNFe);
        rllDadosVariaveis1a.Visible := False;
        rllDadosVariaveis1b.Visible := False;
        rllDadosVariaveis1c.Visible := False;
        rlbCodigoBarrasFS.Caption := sChaveContingencia;
        rlbCodigoBarrasFS.Visible := True;
        rllDadosVariaveis3_Descricao.Caption := 'DADOS DA NF-E';
        rllDadosVariaveis3.Caption :=
                          NotaUtil.FormatarChaveContigencia(sChaveContingencia);
        rllAvisoContingencia.Caption := 'DANFE em Contingência - ' +
                                'Impresso em decorrência de problemas técnicos';
        rllAvisoContingencia.Visible := True;
        rlbAvisoContingencia.Visible := True;
      end
    else if FNFe.Ide.tpEmis = teDPEC then
      begin
        rllDadosVariaveis1a.Visible := True;
        rllDadosVariaveis1b.Visible := True;
        rllDadosVariaveis1c.Visible := False;
        rlbCodigoBarrasFS.Visible := False;
        rllDadosVariaveis3_Descricao.Caption := 'NÚMERO DE REGISTRO DPEC';
        rllDadosVariaveis3.Caption := FNFe.procNFe.nProt + ' ' +
                                          DateTimeToStr(FNFe.procNFe.dhRecbto);
        rllAvisoContingencia.Caption := 'DANFE em Contingência - DPEC ' +
                        'regularmente recebida pela Receita Federal do Brasil';
        rllAvisoContingencia.Visible := True;
        rlbAvisoContingencia.Visible := True;
      end;
  end;
end;

procedure TfrlDANFeRLRetrato.Emitente;
begin
  //emit
  with FNFe.Emit do
    begin
      if FRecebemoDe = '' then
        FRecebemoDe := rllRecebemosDe.Caption;

      rllRecebemosDe.Caption := Format (FRecebemoDe, [ XNome ]);
      rllCNPJ.Caption := NotaUtil.FormatarCNPJ(CNPJCPF );
      rllInscrEstSubst.caption := IEST;
      rllInscricaoEstadual.Caption := IE;
      rlmEmitente.Lines.Text   := XNome;
      with EnderEmit do
        begin
          rlmEndereco.Lines.Clear;
          if xCpl > '' then
            rlmEndereco.Lines.add (XLgr + IfThen (Nro = '0', '', ', ' + Nro) +
                                                ' - ' + XCpl + ' - ' + XBairro)
          else
            rlmEndereco.Lines.add (XLgr + IfThen (Nro = '0', '', ', ' + Nro) +
                                                              ' - ' + XBairro);

          rlmEndereco.Lines.add ('CEP: ' + NotaUtil.FormatarCEP(IntToStr(CEP)) +
                                                    ' - ' + XMun + ' - ' + UF);

        if FFax <> '' then
          begin
            rllFone.Caption := 'TEL: ' + NotaUtil.FormatarFone(Fone) +
                                      ' - FAX: ' + NotaUtil.FormatarFone(FFax);
            rllFone.Font.Size := 7;
          end
        else
          begin
            rllFone.Caption := 'TEL: ' + NotaUtil.FormatarFone(Fone);
            rllFone.Font.Size := 8;
          end;
      end;
    end;

    if (FSite <> '') or (FEmail <> '') then
      begin
        rlmSiteEmail.Lines.BeginUpdate;
        rlmSiteEmail.Lines.Clear;
        if FSite <> '' then
          rlmSiteEmail.Lines.Add(FSite);
        if FEmail <> '' then
          rlmSiteEmail.Lines.Add(FEmail);
        rlmSiteEmail.Lines.EndUpdate;
        rlmSiteEmail.Visible := True;
        rlmEndereco.Top := 48;
        rllFone.Top := 80;
        rlmSiteEmail.Top := 92;
      end
    else
      begin
        rlmSiteEmail.Visible := False;
        rlmEndereco.Top := 58;
        rllFone.Top := 96;
      end;
end;

procedure TfrlDANFeRLRetrato.Destinatario;
begin
  // destinatario
  with FNFe.Dest do
    begin
      if Length(CNPJCPF) = 14 then
        rllDestCNPJ.Caption := NotaUtil.FormatarCNPJ(CNPJCPF)
      else
        if Length(CNPJCPF) = 11 then
          rllDestCNPJ.Caption := NotaUtil.FormatarCPF(CNPJCPF)
        else
          rllDestCNPJ.Caption := CNPJCPF;

      rllDestIE.Caption   := IE;
      rllDestNome.Caption := XNome;
      with EnderDest do
        begin
          if xCpl > '' then
            rllDestEndereco.Caption := XLgr + IfThen (Nro = '0', '', ', ' + Nro)
                                                                  + ' - ' + xCpl
          else
            rllDestEndereco.Caption := XLgr + IfThen (Nro = '0', '', ', ' + Nro);
          rllDestBairro.Caption := XBairro;
          rllDestCidade.Caption := XMun;
          rllDestUF.Caption := UF;
          rllDestCEP.Caption := NotaUtil.FormatarCEP(IntToStr(CEP));
          rllDestFONE.Caption := NotaUtil.FormatarFone(Fone);
        end;
    end;
end;

procedure TfrlDANFeRLRetrato.EnderecoEntrega;
begin
  if FNFe.Entrega.xLgr > '' then
    begin
      // rlbEnderecoEntrega.Visible := True;
      with FNFe.Entrega do
        begin
          if Trim (CNPJ) <>  '' then
            rllEntregaCNPJ.Caption  := NotaUtil.FormatarCNPJ(CNPJ)
          else
            rllEntregaCNPJ.Caption  := NotaUtil.FormatarCPF(CNPJ);
          if xCpl > '' then
            rllEntregaEndereco.Caption := XLgr + IfThen (Nro = '0', '', ', ' + Nro) + ' - ' + xCpl
          else
            rllEntregaEndereco.Caption := XLgr + IfThen (Nro = '0', '', ', ' + Nro);
          rllEntregaBairro.Caption := xBairro;
          rllEntregaMunicipio.Caption := xMun;
          rllEntregaUF.Caption := UF;
          rllEntregaCEP.Caption := '';
        end;
    end;
  // else
    rlbEnderecoEntrega.Visible := False;
end;

procedure TfrlDANFeRLRetrato.EnderecoRetirada;
begin
  if FNFe.Retirada.xLgr > '' then
    begin
      // rlbEnderecoRetirada.Visible := True;
      with FNFe.Retirada do
        begin
          if Trim (CNPJ) <>  '' then
            rllRetiradaCNPJ.Caption  := NotaUtil.FormatarCNPJ(CNPJ)
          else
            rllRetiradaCNPJ.Caption  := NotaUtil.FormatarCPF(CNPJ);
          if xCpl > '' then
            rllRetiradaEndereco.Caption := XLgr + IfThen (Nro = '0', '', ', ' + Nro) + ' - ' + xCpl
          else
            rllRetiradaEndereco.Caption := XLgr + IfThen (Nro = '0', '', ', ' + Nro);
          rllRetiradaBairro.Caption := xBairro;
          rllRetiradaMunicipio.Caption := xMun;
          rllRetiradaUF.Caption := UF;
          rllRetiradaCEP.Caption := '';
        end;
    end;
  // else
    rlbEnderecoRetirada.Visible := False;
end;

procedure TfrlDANFeRLRetrato.Imposto;
begin
  with FNFe.Total.ICMSTot do
  begin
    rllBaseICMS.Caption      := NotaUtil.FormatFloat(VBC, '###,###,###,##0.00');
    rllValorICMS.Caption     := NotaUtil.FormatFloat(VICMS, '###,###,###,##0.00');
    rllBaseICMST.Caption     := NotaUtil.FormatFloat(VBCST, '###,###,###,##0.00');
    rllValorICMST.Caption    := NotaUtil.FormatFloat(VST, '###,###,###,##0.00');
    rllTotalProdutos.Caption := NotaUtil.FormatFloat(VProd, '###,###,###,##0.00');
    rllValorFrete.Caption    := NotaUtil.FormatFloat(VFrete, '###,###,###,##0.00');
    rllValorSeguro.Caption   := NotaUtil.FormatFloat(VSeg, '###,###,###,##0.00');
    rllDescontos.Caption     := NotaUtil.FormatFloat(VDesc, '###,###,###,##0.00');
    rllAcessorias.Caption    := NotaUtil.FormatFloat(VOutro, '###,###,###,##0.00');
    rllValorIPI.Caption      := NotaUtil.FormatFloat(VIPI, '###,###,###,##0.00');
    rllTotalNF.Caption       := NotaUtil.FormatFloat(VNF, '###,###,###,##0.00');
  end;
end;

procedure TfrlDANFeRLRetrato.Transporte;
begin
  with FNFe.Transp do
  begin
    rllTransModFrete.Caption := modFreteToStr(ModFrete);

    rllTransCodigoANTT.Caption := '';
    rllTransPlaca.Caption := '';
    rllTransUFPlaca.Caption := '';

    with Transporta do
    begin
      if Trim (CNPJCPF) <> '' then
        rllTransCNPJ.Caption := NotaUtil.FormatarCNPJ(CNPJCPF)
      else
        rllTransCNPJ.Caption := '';

    rllTransNome.Caption     := XNome;
    rllTransIE.Caption       := IE;
    rllTransEndereco.Caption := XEnder;
    rllTransCidade.Caption   := XMun;
    rllTransUF.Caption       := UF;
    end;
  end;

  with FNFe.Transp.VeicTransp do
  begin
    rllTransPlaca.Caption   :=  Placa;
    rllTransUFPlaca.Caption :=  UF;
  end;

  if FNFe.Transp.Vol.Count > 0 then
   begin
     with FNFe.Transp.Vol[0] do
      begin
        rllTransQTDE.Caption       :=  IntToStr(QVol);
        rllTransEspecie.Caption    :=  Esp  ;
        rllTransMarca.Caption      :=  Marca;
        rllTransNumeracao.Caption  :=  NVol ;
        rllTransPesoLiq.Caption    :=  NotaUtil.FormatFloat(PesoL, '###,###,###,##0.000');
        rllTransPesoBruto.Caption  :=  NotaUtil.FormatFloat(PesoB, '###,###,###,##0.000');
      end;
   end
  else
   begin
     rllTransQTDE.Caption       :=  '';
     rllTransEspecie.Caption    :=  '';
     rllTransMarca.Caption      :=  '';
     rllTransNumeracao.Caption  :=  '';
     rllTransPesoLiq.Caption    :=  '';
     rllTransPesoBruto.Caption  :=  '';
   end;
end;

procedure TfrlDANFeRLRetrato.DadosAdicionais;
var sInfCompl, sInfAdFisco, sRetirada, sEntrega, sProtocolo : WideString;
begin
  iLinhasUtilizadas := 0;

  rlmDadosAdicionaisAuxiliar.Lines.BeginUpdate;
  rlmDadosAdicionaisAuxiliar.Lines.Clear;

  rlmDadosAdicionais.Lines.BeginUpdate;
  rlmDadosAdicionais.Lines.Clear;

  if (FNFe.Ide.tpEmis in [teContingencia, teFSDA, teDPEC]) and
                                              (FNFe.procNFe.cStat = 100) then
    begin
      sProtocolo := 'PROTOCOLO DE AUTORIZAÇÃO DE USO: ' +
              FNFe.procNFe.nProt + ' ' + DateTimeToStr(FNFe.procNFe.dhRecbto);
      rlmDadosAdicionais.Lines.Add(sProtocolo);
      iLinhasUtilizadas := iLinhasUtilizadas + 1;
    end;

  if FNFe.Dest.ISUF > '' then
    begin
      rlmDadosAdicionais.Lines.Add('INSCRIÇÃO SUFRAMA: ' +
                                           FNFe.Dest.ISUF);
      iLinhasUtilizadas := iLinhasUtilizadas + 1;
    end;

  if FNFe.Retirada.xLgr > '' then
    begin
      sRetirada := 'LOCAL DE RETIRADA: ' +
      rllRetiradaEndereco.Caption + ' - ' + rllRetiradaBairro.Caption + ' - ' +
      rllRetiradaMunicipio.Caption + '-' + rllRetiradaUF.Caption + ' CNPJ: ' +
      rllRetiradaCNPJ.Caption;
      rlmDadosAdicionais.Lines.Add(sRetirada);
      iLinhasUtilizadas := iLinhasUtilizadas + 2;
    end;

  if FNFe.Entrega.xLgr > '' then
    begin
      sEntrega := 'LOCAL DE ENTREGA: ' +
        rllEntregaEndereco.Caption + ' - ' + rllEntregaBairro.Caption + ' - ' +
        rllEntregaMunicipio.Caption + '-' + rllEntregaUF.Caption + ' CNPJ: ' +
        rllEntregaCNPJ.Caption;
      rlmDadosAdicionais.Lines.Add(sEntrega);
      iLinhasUtilizadas := iLinhasUtilizadas + 2;
    end;

  if FNFe.InfAdic.infAdFisco > '' then
    begin
      if FNFe.InfAdic.infCpl > '' then
        sInfAdFisco := FNFe.InfAdic.infAdFisco + ' - '
      else
        sInfAdFisco := FNFe.InfAdic.infAdFisco;
    end
  else
    sInfAdFisco := '';

  if FNFe.InfAdic.infCpl > '' then
    sInfCompl := FNFe.InfAdic.infCpl
  else
    sInfCompl := '';

  rlmDadosAdicionaisAuxiliar.Lines.Add(sInfAdFisco + sInfCompl);
  rlmDadosAdicionaisAuxiliar.Lines.EndUpdate;
end;

procedure TfrlDANFeRLRetrato.Observacoes;
var sTextoProvisorio: String;
iUltimoEspaco: Integer;
begin
  iLimiteCaracteres := 775;
  sTexto := rlmDadosAdicionaisAuxiliar.Lines.Text;
  iCaracteres := Length(sTexto) - 2;  // O '-2' refere-se aos caracteres de quebra de linha
  iLimiteCaracteres := iLimiteCaracteres - (iLinhasUtilizadas * iLimiteCaracteresLinha);
  sTextoProvisorio := Copy(sTexto, 1, iLimiteCaracteres);
  iUltimoEspaco := BuscaDireita(' ', sTextoProvisorio);

  if iCaracteres > iLimiteCaracteres then
    iLimiteCaracteres := (iUltimoEspaco - 1);

  rlmDadosAdicionais.Lines.Add(Copy(sTexto, 1, iLimiteCaracteres));

  if iCaracteres > iLimiteCaracteres then
    begin
      rlmContinuacaoDadosAdicionais.Lines.BeginUpdate;
      rlmContinuacaoDadosAdicionais.Lines.Add(Copy(sTexto,
                  (iUltimoEspaco + 1), (iCaracteres - iLimiteCaracteres)));
      rlmContinuacaoDadosAdicionais.Lines.EndUpdate;
    end;
  rlmDadosAdicionais.Lines.EndUpdate;
end;

procedure TfrlDANFeRLRetrato.Itens;
var nItem : Integer ;
sCST, sBCICMS, sALIQICMS, sVALORICMS, sALIQIPI, sVALORIPI : String ;
begin
  cdsItens.Close;
  cdsItens.CreateDataSet ;
  cdsItens.Open ;

  for nItem := 0 to (FNFe.Det.Count - 1) do
    begin
      with FNFe.Det.Items[nItem] do
        begin
          with Prod do
            begin
              with Imposto.ICMS do
                begin
                  sCST       := OrigToStr( orig ) + CSTICMSToStr( CST ) ;
                  sBCICMS    := '0.00' ;
                  sALIQICMS  := '0.00' ;
                  sVALORICMS := '0.00' ;
                  sALIQIPI   := '0.00' ;
                  sVALORIPI  := '0.00' ;

                  if (CST = cst00) then
                    begin
                      sBCICMS    := NotaUtil.FormatFloat( VBC   ) ;
                      sALIQICMS  := NotaUtil.FormatFloat( PICMS ) ;
                      sVALORICMS := NotaUtil.FormatFloat( VICMS ) ;
                    end
                  else if (CST = cst10) then
                    begin
                      sBCICMS    := NotaUtil.FormatFloat( VBC   ) ;
                      sALIQICMS  := NotaUtil.FormatFloat( PICMS ) ;
                      sVALORICMS := NotaUtil.FormatFloat( VICMS ) ;
                    end
                  else if (CST = cst20) then
                    begin
                      sBCICMS    := NotaUtil.FormatFloat( VBC   ) ;
                      sALIQICMS  := NotaUtil.FormatFloat( PICMS ) ;
                      sVALORICMS := NotaUtil.FormatFloat( VICMS ) ;
                    end
                  else if (CST = cst30) then
                    begin
                      sBCICMS    := NotaUtil.FormatFloat( VBCST   ) ;
                      sALIQICMS  := NotaUtil.FormatFloat( PICMSST ) ;
                      sVALORICMS := NotaUtil.FormatFloat( VICMSST ) ;
                    end
                  else if (CST = cst40) or (CST = cst41) or (CST = cst50) then
                    begin
                      // Campos vazios
                    end
                  else if (CST = cst51) then
                    begin
                      sBCICMS    := NotaUtil.FormatFloat( VBC   ) ;
                      sALIQICMS  := NotaUtil.FormatFloat( PICMS ) ;
                      sVALORICMS := NotaUtil.FormatFloat( VICMS ) ;
                    end
                  else if (CST = cst60) then
                    begin
                      sBCICMS    := NotaUtil.FormatFloat( VBCST ) ;
                      sVALORICMS := NotaUtil.FormatFloat( VICMSST ) ;
                    end
                  else if (CST = cst70) then
                    begin
                      sBCICMS    := NotaUtil.FormatFloat( VBC   ) ;
                      sALIQICMS  := NotaUtil.FormatFloat( PICMS ) ;
                      sVALORICMS := NotaUtil.FormatFloat( VICMS ) ;
                    end
                  else if (CST = cst90) then
                    begin
                      sBCICMS    := NotaUtil.FormatFloat( VBC   ) ;
                      sALIQICMS  := NotaUtil.FormatFloat( PICMS ) ;
                      sVALORICMS := NotaUtil.FormatFloat( VICMS ) ;
                   end;
                end; // with Imposto.ICMS do

              with Imposto.IPI do
                begin
                  if (CST = ipi00) or (CST = ipi49) or
                     (CST = ipi50) or (CST = ipi99) then
                    begin
                      sALIQIPI  := NotaUtil.FormatFloat( PIPI ) ;
                      sVALORIPI := NotaUtil.FormatFloat( VIPI ) ;
                    end
                end;

              cdsItens.Append ;
              cdsItens.FieldByName('CODIGO').AsString := CProd ;
              cdsItens.FieldByName('DESCRICAO').AsString := XProd ;
              cdsItens.FieldByName('NCM').AsString := NCM ;
              cdsItens.FieldByName('CFOP').AsString := CFOP ;
              cdsItens.FieldByName('UNIDADE').AsString := UCom ;
              cdsItens.FieldByName('QTDE').AsString := FormatFloat('###,###,###,##0.0000', QCom);
              cdsItens.FieldByName('VALOR').AsString := FormatFloat('###,###,###,##0.0000', VUnCom);
              cdsItens.FieldByName('TOTAL').AsString := FormatFloat('###,###,###,##0.00', VProd) ;
              cdsItens.FieldByName('CST').AsString := sCST ;
              cdsItens.FieldByName('BICMS').AsString := sBCICMS ;
              cdsItens.FieldByName('ALIQICMS').AsString := sALIQICMS ;
              cdsItens.FieldByName('VALORICMS').AsString := sVALORICMS ;
              cdsItens.FieldByName('ALIQIPI').AsString := sALIQIPI ;
              cdsItens.FieldByName('VALORIPI').AsString := sVALORIPI ;
              cdsItens.Post ;
            end; // with Prod do
        end; //  with FNFe.Det.Items[nItem] do
    end; //  for nItem := 0 to ( FNFe.Det.Count - 1 ) do

   cdsItens.First ;
end;

procedure TfrlDANFeRLRetrato.ISSQN;
begin
  if FNFe.Det.Items[0].Imposto.ISSQN.vISSQN = 0 then
    rlbISSQN.Visible := False
  else
    begin
      rlbISSQN.Visible := True;
      rllISSQNInscricao.Caption := '';
      rllISSQNValorServicos.Caption := NotaUtil.FormatFloat(FNFe.Total.ISSQNtot.vServ, '###,###,##0.00');
      rllISSQNBaseCalculo.Caption := NotaUtil.FormatFloat(FNFe.Total.ISSQNtot.vBC, '###,###,##0.00');
      rllISSQNValorISSQN.Caption := NotaUtil.FormatFloat(FNFe.Total.ISSQNtot.vISS, '###,###,##0.00');
    end;
end;

procedure TfrlDANFeRLRetrato.AddFatura;
var x : integer;
sTipoVenda: String;
begin

  //zera
  for x := 1 to 12 do
    begin
      TRLLabel (FindComponent ('rllFatNum'   + intToStr (x))).Caption := '';
      TRLLabel (FindComponent ('rllFatData'  + intToStr (x))).Caption := '';
      TRLLabel (FindComponent ('rllFatValor' + intToStr (x))).Caption := '';
    end;

  if FNFe.Cobr.Dup.Count > 0 then
    begin
      rllTipoVenda.Visible := False;
     //adiciona
     for x := 0 to FNFe.Cobr.Dup.Count - 1 do
        with FNFe.Cobr.Dup[ x ] do
         begin
           TRLLabel (FindComponent ('rllFatNum'   + intToStr (x + 1))).Caption := NDup;
           TRLLabel (FindComponent ('rllFatData'  + intToStr (x + 1))).Caption := NotaUtil.FormatDate(DateToStr(DVenc));
           TRLLabel (FindComponent ('rllFatValor' + intToStr (x + 1))).Caption := NotaUtil.FormatFloat(VDup);
         end;
    end
  else
    begin
      case FNFe.Ide.indPag of
        ipVista: sTipoVenda := 'VENDA A VISTA';
        ipPrazo: sTipoVenda := 'VENDA A PRAZO';
        ipOutras: sTipoVenda := '';
      end;
      rllTipoVenda.Caption := sTipoVenda;
      rllTipoVenda.Visible := True;
    end;
end;

procedure TfrlDANFeRLRetrato.rlbItensAfterPrint(Sender: TObject);
var h: Integer;
begin
  q := q + 1;
  if FNFe.Det.Items[q - 1].infAdProd > '' then
    begin
      rlmObsItem.Lines.BeginUpdate;
      rlmObsItem.Lines.Clear;
      rlmObsItem.Lines.Add(FNFe.Det.Items[q - 1].infAdProd);
      rlmObsItem.Lines.EndUpdate;
      rlbObsItem.Visible := True;

      h := (rlmObsItem.Top + rlmObsItem.Height) + 2;
      LinhaFimObsItem.Top := h;
      h := h + 1;
      LinhaObsItemEsquerda.Height := h;
      LinhaObsItemDireita.Height := h;
      if iQuantItens > q then
        LinhaInicioItem.Visible := True
      else
        LinhaInicioItem.Visible := False;
    end
  else
    rlbObsItem.Visible := False;
end;

procedure TfrlDANFeRLRetrato.rlbDadosAdicionaisBeforePrint(Sender: TObject;
  var PrintIt: Boolean);
begin
  if FPosCanhoto = pcCabecalho then
    begin
      rlbReciboHeader.Visible := False;
      rlbDivisaoRecibo.Visible := False;
    end;
end;

end.
