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
|* 09/03/2009: Dulcemar P. Zilli
|*  - Incluido IPI e II
|* 23/04/2009: Dulcemar P. Zilli
|*  - Alterada Tabela Unidades da Federação, incluida EX p/ oper. com exterior
******************************************************************************}
unit ACBrNFeConst;

interface

uses
  Classes;

const
  NfVersao        = '1.0.0.0';
  NFecabMsg       = '1.02';
  NFeconsStatServ = '1.07';
  NFenviNFe       = '1.10';
  NFeconsReciNFe  = '1.10';
  NFeconsSitNFe   = '1.07';
  NFecancNFe      = '1.07';
  NFeinutNFe      = '1.07';

  ColTitulo      = 0;
  ColImprimir    = 1;
  ColLinha       = 2;
  ColColuna      = 3;
  ColTamanho     = 4;
  ColAlinhamento = 5;
  ColName        = 6;

  ColDadoProdutoTitulo      = 0;
  ColDadoProdutoImprimir    = 1;
  ColDadoProdutoColuna      = 2;
  ColDadoProdutoTamanho     = 3;
  ColDadoProdutoAlinhamento = 4;
  ColDadoProdutoName        = 5;

  LineBreak = #13#10;

  NFeCSTICMS: array[0..10] of String = ('00','10','20','30','40','41','50','51','60','70','90');
  NFeSituacaoTributariaICMS: array[0..10] of String =
  ('ICMS 00 - Tributada integramente',
   'ICMS 10 - Tributada com cobrança do ICMS por substituição tributária',
   'ICMS 20 - Com redução na Base de cálculo',
   'ICMS 30 - Isenta ou não tributada e com cobrança do ICMS por substituição tributária',
   'ICMS 40 - Isenta',
   'ICMS 41 - Não tributada',
   'ICMS 50 - Suspensão',
   'ICMS 51 - Deferimento',
   'ICMS 60 - Cobrado anteriormente por substituição tributária',
   'ICMS 70 - Com redução da base de cálculo e cobrança do ICMS por substituição tributária',
   'ICMS 90 - Outras');

  NFeCSTPIS: array[0..8] of String = ('01','02','03','04','06','07','08','09','99');
  NFeSituacaoTributariaPIS: array[0..8] of String =
  ('01 - Operação Tributável - Base de Cáculo  = Valor da Operação Alíquota Normal(Cumulativo/Não Cumulativo)',
   '02 - Operação Tributável - Base de Cáculo  = Valor da Operação (Alíquota Diferenciada)',
   '03 - Operação Tributável - Base de Cáculo  = Quantidade Vendida x Alíquota por Unidade de Produto',
   '04 - Operação Tributável - Tributação Monofásica - (Alíquota Zero)',
   '06 - Operação Tributável - Alíquota Zero',
   '07 - Operação Isenta da Contribuição',
   '08 - Operação sem Incidência da Contribuição',
   '09 - Operação com Suspensão da Contribuição',
   '99 - Outras Operações');

  NFeCSTCOFINS: array[0..8] of String = ('01','02','03','04','06','07','08','09','99');
  NFeSituacaoTributariaCOFINS: array[0..8] of String =
  ('01 - Operação Tributável - Base de Cáculo  = Valor da Operação Alíquota Normal(Cumulativo/Não Cumulativo)',
   '02 - Operação Tributável - Base de Cáculo  = Valor da Operação (Alíquota Diferenciada)',
   '03 - Operação Tributável - Base de Cáculo  = Quantidade Vendida x Alíquota por Unidade de Produto',
   '04 - Operação Tributável - Tributação Monofásica - (Alíquota Zero)',
   '06 - Operação Tributável - Alíquota Zero',
   '07 - Operação Isenta da Contribuição',
   '08 - Operação sem Incidência da Contribuição',
   '09 - Operação com Suspensão da Contribuição',
   '99 - Outras Operações');

  NFeUF: array[0..27] of String =
  ('AC','AL','AP','AM','BA','CE','DF','ES','GO','MA','MT','MS','MG','PA',
   'PB','PR','PE','PI','RJ','RN','RS','RO','RR','SC','SP','SE','TO','EX');
  NFeUFCodigo: array[0..27] of Integer =
  (12,27,16,13,29,23,53,32,52,21,51,50,31,15,25,41,26,22,33,24,43,11,14,42,35,28,17,99);

  NFeAmbiente: array[0..1] of String =
  ('Producao','Teste');
  NFeAmbienteCodigo: array[0..1] of Integer =
  (1,2);

  NFeFormaEmissao: array[0..2] of String =
  ('Normal on-line','Contingencia off-line','Contingencia SCAN');
  NFeFormaEmissaoCodigo: array[0..2] of Integer =
  (1,2,3);

  NFeOrigemMercadoria: array[0..2] of String =
  ('0 - Nacional','1 - Estrangeira - Importação direta','2 - Estrangeira - Adquirida no mercado interno');
  NFeOrigemMercadoriaCodigo: array[0..2] of Integer =
  (0,1,2);

  NFeModalidadeICMS: array[0..3] of String =
  ('0 - Margem Valor Agregado(%)','1 - Pauta(Valor)','2 - Preço Tabelado Máx.(Valor)','3 - Valor da Operação');
  NFeModalidadeICMSCodigo: array[0..3] of Integer =
  (0,1,2,3);

  NFeModalidadeICMSST: array[0..5] of String =
  ('0 - Preço tabelado ou máximo sugerido','1 - Lista Negativa(Valor)','2 - Lista Positiva(Valor)',
   '3 - Lista Neutra(Valor)','4 - Margem Valor Agregado(%)','5 - Pauta(Valor)');
  NFeModalidadeICMSSTCodigo: array[0..5] of Integer =
  (0,1,2,3,4,5);

  NFeDANFE: array[0..1] of String =
  ('Retrato','Paisagem');
  NFeDANFECodigo: array[0..1] of Integer =
  (1,2);

  NFeXSDPath = '\Schemas\nfe_v1.10.xsd';
  NFePathReport = '\Report\NotaFiscalEletronica.rav';

  NFeCSTIPI: array[0..13] of String = ('00','01','02','03','04','05','49','50','51','52','53','54','55','99');
  NFeSituacaoTributariaIPI: array[0..13] of String =
  ('00 - Entrada com recuperação de crédito',
   '01-Entrada tributada com alíquota zero',
   '02-Entrada isenta',
   '03-Entrada não-tributada',
   '04-Entrada imune',
   '05-Entrada com suspensão',
   '49-Outras entradas',
   '50-Saída tributada',
   '51-Saída tributada com alíquota zero',
   '52-Saída isenta',
   '53-Saída não-tributada',
   '54-Saída imune',
   '55-Saída com suspensão',
   '99-Outras saídas');
   
implementation

end.
