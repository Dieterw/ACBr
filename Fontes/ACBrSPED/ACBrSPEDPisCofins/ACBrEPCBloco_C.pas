{******************************************************************************}
{ Projeto: Componentes ACBr                                                    }
{  Biblioteca multiplataforma de componentes Delphi para interação com equipa- }
{ mentos de Automação Comercial utilizados no Brasil                           }
{                                                                              }
{ Direitos Autorais Reservados (c) 2010   Isaque Pinheiro                      }
{                                                                              }
{ Colaboradores nesse arquivo:                                                 }
{                                                                              }
{  Você pode obter a última versão desse arquivo na pagina do  Projeto ACBr    }
{ Componentes localizado em      http://www.sourceforge.net/projects/acbr      }
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
|* 14/12/2010: Isaque Pinheiro e Claudio Roberto de Souza
|*  - Criação e distribuição da Primeira Versao
*******************************************************************************}

unit ACBrEPCBloco_C;

interface

uses
  SysUtils, Classes, Contnrs, DateUtils;

type
  TRegistroC010List = class;
  TRegistroC100List = class;
  TRegistroC110List = class;
  TRegistroC111List = class;
  TRegistroC120List = class;
  TRegistroC170List = class;
  TRegistroC180List = class;
  TRegistroC181List = class;
  TRegistroC185List = class;
  TRegistroC188List = class;
  TRegistroC190List = class;
  TRegistroC191List = class;
  TRegistroC195List = class;
  TRegistroC198List = class;
  TRegistroC199List = class;
  TRegistroC380List = class;
  TRegistroC381List = class;
  TRegistroC385List = class;
  TRegistroC395List = class;
  TRegistroC396List = class;
  TRegistroC400List = class;
  TRegistroC405List = class;
  TRegistroC481List = class;
  TRegistroC485List = class;
  TRegistroC489List = class;
  TRegistroC490List = class;
  TRegistroC491List = class;
  TRegistroC495List = class;
  TRegistroC499List = class;
  TRegistroC500List = class;
  TRegistroC501List = class;
  TRegistroC505List = class;
  TRegistroC509List = class;
  TRegistroC600List = class;
  TRegistroC601List = class;
  TRegistroC605List = class;
  TRegistroC609List = class;


  //REGISTRO C001: ABERTURA DO BLOCO C
  TRegistroC001 = class(TOpenBlocos)
  private
  public
  end;

  //REGISTRO C010: IDENTIFICAÇÃO DO ESTABELECIMENTO
  TRegistroC010 = class
  private
    fCNPJ: Integer;           //02	CNPJ	Número de inscrição do estabelecimento no CNPJ.	N	014*	-
    fIND_ESCRI: Integer;      //03	IND_ESCRI	Indicador da apuração das contribuições e créditos, na escrituração das operações por NF-e e ECF, no período:1 – Apuração com base nos registros de consolidação das operações por NF-e (C180 e C190) e por ECF (C490);2 – Apuração com base no registro individualizado de NF-e (C100 e C170) e de ECF (C400)	C	001*	-
  public
    property CNPJ: Integer read FCNPJ write FCNPJ;
    property IND_ESCRI: Integer read FIND_ESCRI write FIND_ESCRI;
  end;

  // Registro C010 - Lista
  TRegistroC010List = class(TObjectList)
  private
    function GetItem(Index: Integer): TRegistroC010;
    procedure SetItem(Index: Integer; const Value: TRegistroC010);
  public
    function New: TRegistroC010;
    property Items[Index: Integer]: TRegistroC010 read GetItem write SetItem;
  end;

  //REGISTRO C100: DOCUMENTO - NOTA FISCAL (CÓDIGO 01), NOTA FISCAL AVULSA (CÓDIGO 1B), NOTA FISCAL DE PRODUTOR (CÓDIGO 04) e NF-e (CÓDIGO 55)
  TRegistroC100 = class
  private
    fIND_OPER: TACBrTipoOperacao;       /// Indicador do tipo de operação: 0- Entrada; 1- Saída
    fIND_EMIT: TACBrEmitente;           /// Indicador do emitente do documento fiscal: 0- Emissão própria; 1- Terceiros
    fCOD_PART: String;                  /// Código do participante (campo 02 do Registro 0150):
    fCOD_MOD: String;                   /// Código do modelo do documento fiscal, conforme a Tabela 4.1.1
    fCOD_SIT: TACBrSituacaoDocto;       /// Código da situação do documento fiscal, conforme a Tabela 4.1.2
    fSER: String;                       /// Série do documento fiscal
    fNUM_DOC: String;                   /// Número do documento fiscal
    fCHV_NFE: String;                   /// Chave da Nota Fiscal Eletrônica
    fDT_DOC: TDateTime;                 /// Data da emissão do documento fiscal
    fDT_E_S: TDateTime;                 /// Data da entrada ou da saída
    fVL_DOC: currency;                  /// Valor total do documento fiscal
    fIND_PGTO: TACBrTipoPagamento;      /// Indicador do tipo de pagamento:
    fVL_DESC: currency;                 /// Valor total do desconto // Prates
    fVL_ABAT_NT: currency;              /// Abatimento não tributado e não comercial Ex. desconto ICMS nas remessas para ZFM: // Prates
    fVL_MERC: currency;                 /// Valor das mercadorias constantes no documento fiscal
    fIND_FRT: TACBrTipoFrete;           /// Indicador do tipo do frete:
    fVL_FRT: currency;                  /// Valor do frete indicado no documento fiscal
    fVL_SEG: currency;                  /// Valor do seguro indicado no documento fiscal
    fVL_OUT_DA: currency;               /// Valor de outras despesas acessórias
    fVL_BC_ICMS: currency;              /// Valor da base de cálculo do ICMS
    fVL_ICMS: currency;                 /// Valor do ICMS
    fVL_BC_ICMS_ST: currency;           /// Valor da base de cálculo do ICMS substituição tributária
    fVL_ICMS_ST: currency;              /// Valor do ICMS retido por substituição tributária
    fVL_IPI: currency;                  /// Valor total do IPI
    fVL_PIS: currency;                  /// Valor total do PIS
    fVL_COFINS: currency;               /// Valor total da COFINS
    fVL_PIS_ST: currency;               /// Valor total do PIS retido por substituição tributária
    fVL_COFINS_ST: currency;            /// Valor total da COFINS retido por substituição tributária

    FRegistroC110: TRegistroC110List;  /// BLOCO C - Lista de RegistroC110 (FILHO)
    FRegistroC120: TRegistroC120List;  /// BLOCO C - Lista de RegistroC120 (FILHO)
    FRegistroC130: TRegistroC130List;  /// BLOCO C - Lista de RegistroC130 (FILHO)
    FRegistroC140: TRegistroC140List;  /// BLOCO C - Lista de RegistroC140 (FILHO) {Márcio Lopes 30Nov2009}
    FRegistroC160: TRegistroC160List;  /// BLOCO C - Lista de RegistroC160 (FILHO)
    FRegistroC165: TRegistroC165List;  /// BLOCO C - Lista de RegistroC165 (FILHO)
    FRegistroC170: TRegistroC170List;  /// BLOCO C - Lista de RegistroC170 (FILHO)
    FRegistroC190: TRegistroC190List;  /// BLOCO C - Lista de RegistroC190 (FILHO) {Jean Barreiros 17Nov2009}
    FRegistroC195: TRegistroC195List;  /// BLOCO C - Lista de RegistroC195 (FILHO)
  public
    constructor Create; virtual; /// Create
    destructor Destroy; override; /// Destroy

    property IND_OPER: TACBrTipoOperacao read FIND_OPER write FIND_OPER;
    property IND_EMIT: TACBrEmitente read FIND_EMIT write FIND_EMIT;
    property COD_PART: String read FCOD_PART write FCOD_PART;
    property COD_MOD: String read FCOD_MOD write FCOD_MOD;
    property COD_SIT: TACBrSituacaoDocto read FCOD_SIT write FCOD_SIT;
    property SER: String read FSER write FSER;
    property NUM_DOC: String read FNUM_DOC write FNUM_DOC;
    property CHV_NFE: String read FCHV_NFE write FCHV_NFE;
    property DT_DOC: TDateTime read FDT_DOC write FDT_DOC;
    property DT_E_S: TDateTime read FDT_E_S write FDT_E_S;
    property VL_DOC: currency read FVL_DOC write FVL_DOC;
    property IND_PGTO: TACBrTipoPagamento read FIND_PGTO write FIND_PGTO;
    property VL_DESC: currency read FVL_DESC write FVL_DESC; // prates
    property VL_ABAT_NT: currency read FVL_ABAT_NT write FVL_ABAT_NT; // Prates
    property VL_MERC: currency read FVL_MERC write FVL_MERC;
    property IND_FRT: TACBrTipoFrete read FIND_FRT write FIND_FRT;
    property VL_FRT: currency read FVL_FRT write FVL_FRT;
    property VL_SEG: currency read FVL_SEG write FVL_SEG;
    property VL_OUT_DA: currency read FVL_OUT_DA write FVL_OUT_DA;
    property VL_BC_ICMS: currency read FVL_BC_ICMS write FVL_BC_ICMS;
    property VL_ICMS: currency read FVL_ICMS write FVL_ICMS;
    property VL_BC_ICMS_ST: currency read FVL_BC_ICMS_ST write FVL_BC_ICMS_ST;
    property VL_ICMS_ST: currency read FVL_ICMS_ST write FVL_ICMS_ST;
    property VL_IPI: currency read FVL_IPI write FVL_IPI;
    property VL_PIS: currency read FVL_PIS write FVL_PIS;
    property VL_COFINS: currency read FVL_COFINS write FVL_COFINS;
    property VL_PIS_ST: currency read FVL_PIS_ST write FVL_PIS_ST;
    property VL_COFINS_ST: currency read FVL_COFINS_ST write FVL_COFINS_ST;
    /// Registros FILHOS
    property RegistroC110: TRegistroC110List read FRegistroC110 write FRegistroC110;
    property RegistroC120: TRegistroC120List read FRegistroC120 write FRegistroC120;
    property RegistroC130: TRegistroC130List read FRegistroC130 write FRegistroC130;
    property RegistroC140: TRegistroC140List read FRegistroC140 write FRegistroC140; {Márcio Lopes 30Nov2009}
    property RegistroC160: TRegistroC160List read FRegistroC160 write FRegistroC160;
    property RegistroC165: TRegistroC165List read FRegistroC165 write FRegistroC165;
    property RegistroC170: TRegistroC170List read FRegistroC170 write FRegistroC170;
    property RegistroC190: TRegistroC190List read FRegistroC190 write FRegistroC190;  {Jean Barreiros 17Nov2009}
    property RegistroC195: TRegistroC195List read FRegistroC195 write FRegistroC195;
  end;

  /// Registro C100 - Lista

  TRegistroC100List = class(TObjectList)
  private
    function GetItem(Index: Integer): TRegistroC100; /// GetItem
    procedure SetItem(Index: Integer; const Value: TRegistroC100); /// SetItem
  public
    function New: TRegistroC100;
    property Items[Index: Integer]: TRegistroC100 read GetItem write SetItem;
  end;

  //REGISTRO C110: COMPLEMENTO DO DOCUMENTO - INFORMAÇÃO COMPLEMENTAR DA NOTA FISCAL
  TRegistroC110 = class
  private
    fCOD_INF: String;       /// Código da informação complementar do documento fiscal (campo 02 do Registro 0450)
    fTXT_COMPL: String;    /// Descrição complementar do código de referência.

    FRegistroC111: TRegistroC111List;  /// BLOCO C - Lista de RegistroC111 (FILHO fo FILHO)
    FRegistroC112: TRegistroC112List;  /// BLOCO C - Lista de RegistroC111 (FILHO fo FILHO)
    FRegistroC113: TRegistroC113List;  /// BLOCO C - Lista de RegistroC111 (FILHO fo FILHO)
    FRegistroC114: TRegistroC114List;  /// BLOCO C - Lista de RegistroC111 (FILHO fo FILHO)
    FRegistroC115: TRegistroC115List;  /// BLOCO C - Lista de RegistroC111 (FILHO fo FILHO)
  public
    constructor Create; virtual; /// Create
    destructor Destroy; override; /// Destroy

    property COD_INF: String read FCOD_INF write FCOD_INF;
    property TXT_COMPL: String read FTXT_COMPL write FTXT_COMPL;
    /// Resgistro FILHO do FILHO
    property RegistroC111: TRegistroC111List read FRegistroC111 write FRegistroC111;
    property RegistroC112: TRegistroC112List read FRegistroC112 write FRegistroC112;
    property RegistroC113: TRegistroC113List read FRegistroC113 write FRegistroC113;
    property RegistroC114: TRegistroC114List read FRegistroC114 write FRegistroC114;
    property RegistroC115: TRegistroC115List read FRegistroC115 write FRegistroC115;
  end;

  /// Registro C110 - Lista

  TRegistroC110List = class(TObjectList)
  private
    function GetItem(Index: Integer): TRegistroC110; /// GetItem
    procedure SetItem(Index: Integer; const Value: TRegistroC110); /// SetItem
  public
    function New: TRegistroC110;
    property Items[Index: Integer]: TRegistroC110 read GetItem write SetItem;
  end;

  //REGISTRO C111: PROCESSO REFERENCIADO
  TRegistroC111 = class
  private
    fNUM_PROC: string;           //02	NUM_PROC	Identificação do processo ou ato concessório	C	020	-
    fIND_PROC: Integer;          //03	IND_PROC	Indicador da origem do processo:1 - Justiça Federal;3 – Secretaria da Receita Federal do Brasil;9 – Outros.	C	001*	-
  public
    property NUM_PROC: string read FNUM_PROC write FNUM_PROC;
    property IND_PROC: Integer read FIND_PROC write FIND_PROC;
  end;

  // Registro C111 - Lista
  TRegistroC111List = class(TObjectList)
  private
    function GetItem(Index: Integer): TRegistroC111;
    procedure SetItem(Index: Integer; const Value: TRegistroC111);
  public
    function New: TRegistroC111;
    property Items[Index: Integer]: TRegistroC111 read GetItem write SetItem;
  end;

  //REGISTRO C120: COMPLEMENTO DO DOCUMENTO - OPERAÇÕES DE IMPORTAÇÃO (CÓDIGO 01)
  TRegistroC120 = class
  private
    fCOD_DOC_IMP: TACBrDoctoImporta;  /// Documento de importação:
    fNUM_DOC__IMP: String;            /// Número do documento de Importação.
    fPIS_IMP: currency;               /// Valor pago de PIS na importação
    fCOFINS_IMP: currency;            /// Valor pago de COFINS na importação
  public
    property COD_DOC_IMP: TACBrDoctoImporta read FCOD_DOC_IMP write FCOD_DOC_IMP;
    property NUM_DOC__IMP: String read FNUM_DOC__IMP write FNUM_DOC__IMP;
    property PIS_IMP: currency read FPIS_IMP write FPIS_IMP;
    property COFINS_IMP: currency read FCOFINS_IMP write FCOFINS_IMP;
  end;

  /// Registro C120 - Lista

  TRegistroC120List = class(TObjectList)
  private
    function GetItem(Index: Integer): TRegistroC120; /// GetItem
    procedure SetItem(Index: Integer; const Value: TRegistroC120); /// SetItem
  public
    function New: TRegistroC120;
    property Items[Index: Integer]: TRegistroC120 read GetItem write SetItem;
  end;

  //REGISTRO C170: COMPLEMENTO DO DOCUMENTO - ITENS DO DOCUMENTO (CÓDIGOS 01, 1B, 04 e 55)
  TRegistroC170 = class
  private
    fNUM_ITEM: String;                    /// Número seqüencial do item no documento fiscal
    fCOD_ITEM: String;                    /// Código do item (campo 02 do Registro 0200)
    fDESCR_COMPL: String;                 /// Descrição complementar do item como adotado no documento fiscal
    fQTD: Double;                         /// Quantidade do item
    fUNID: String;                        /// Unidade do item(Campo 02 do registro 0190)
    fVL_ITEM: currency;                   /// Valor total do item
    fVL_DESC: currency;                   /// Valor do desconto comercial
    fIND_MOV: TACBrMovimentacaoFisica;    /// Movimentação física do ITEM/PRODUTO: 0 - SIM; 1- NÃO
    fCST_ICMS: String;                    /// Código da Situação Tributária referente ao ICMS, conforme a Tabela indicada no item 4.3.1
    fCFOP: String;                        /// Código Fiscal de Operação e Prestação
    fCOD_NAT: String;                     /// Código da natureza da operação (campo 02 do Registro 0400)
    fVL_BC_ICMS: currency;                /// Valor da base de cálculo do ICMS
    fALIQ_ICMS: currency;                 /// Alíquota do ICMS
    fVL_ICMS: currency;                   /// Valor do ICMS creditado/debitado
    fVL_BC_ICMS_ST: currency;             /// Valor da base de cálculo referente à substituição tributária
    fALIQ_ST: currency;                   /// Alíquota do ICMS da substituição tributária na unidade da federação de destino
    fVL_ICMS_ST: currency;                /// Valor do ICMS referente à substituição tributária
    fIND_APUR: TACBrApuracaoIPI;          /// Indicador de período de apuração do IPI: 0 - Mensal; 1 - Decendial
//    fCST_IPI: TACBrSituacaoTribIPI;       /// Código da Situação Tributária referente ao IPI, conforme a Tabela indicada no item 4.3.2.
    fCST_IPI: string;                     /// Código da Situação Tributária referente ao IPI, conforme a Tabela indicada no item 4.3.2.
    fCOD_ENQ: String;                     /// Código de enquadramento legal do IPI, conforme tabela indicada no item 4.5.3.
    fVL_BC_IPI: currency;                 /// Valor da base de cálculo do IPI
    fALIQ_IPI: currency;                  /// Alíquota do IPI
    fVL_IPI: currency;                    /// Valor do IPI creditado/debitado
//    fCST_PIS: TACBrSituacaoTribPIS;       /// Código da Situação Tributária referente ao PIS.
    fCST_PIS: string;                     /// Código da Situação Tributária referente ao PIS.
    fVL_BC_PIS: currency;                 /// Valor da base de cálculo do PIS
    fALIQ_PIS_PERC: currency;             /// Alíquota do PIS (em percentual)
    fQUANT_BC_PIS: Double;                /// Quantidade - Base de cálculo PIS
    fALIQ_PIS_R: Double;                  /// Alíquota do PIS (em reais)
    fVL_PIS: currency;                    /// Valor do PIS
//    fCST_COFINS: TACBrSituacaoTribCOFINS; /// Código da Situação Tributária referente ao COFINS.
    fCST_COFINS: string;                  /// Código da Situação Tributária referente ao COFINS.
    fVL_BC_COFINS: currency;              /// Valor da base de cálculo da COFINS
    fALIQ_COFINS_PERC: currency;          /// Alíquota do COFINS (em percentual)
    fQUANT_BC_COFINS: Double;             /// Quantidade - Base de cálculo COFINS
    fALIQ_COFINS_R: Double;               /// Alíquota da COFINS (em reais)
    fVL_COFINS: currency;                 /// Valor da COFINS
    fCOD_CTA: String;                     /// Código da conta analítica contábil debitada/creditada

    FRegistroC171: TRegistroC171List;  /// BLOCO C - Lista de RegistroC141 (FILHO fo FILHO)
    FRegistroC172: TRegistroC172List;  /// BLOCO C - Lista de RegistroC141 (FILHO fo FILHO)
    FRegistroC173: TRegistroC173List;  /// BLOCO C - Lista de RegistroC141 (FILHO fo FILHO)
    FRegistroC174: TRegistroC174List;  /// BLOCO C - Lista de RegistroC141 (FILHO fo FILHO)
    FRegistroC175: TRegistroC175List;  /// BLOCO C - Lista de RegistroC141 (FILHO fo FILHO)
    FRegistroC176: TRegistroC176List;  /// BLOCO C - Lista de RegistroC141 (FILHO fo FILHO)
    FRegistroC177: TRegistroC177List;  /// BLOCO C - Lista de RegistroC141 (FILHO fo FILHO)
    FRegistroC178: TRegistroC178List;  /// BLOCO C - Lista de RegistroC141 (FILHO fo FILHO)
    FRegistroC179: TRegistroC179List;  /// BLOCO C - Lista de RegistroC141 (FILHO fo FILHO)
  public
    constructor Create; virtual; /// Create
    destructor Destroy; override; /// Destroy

    property NUM_ITEM: String                    read FNUM_ITEM         write FNUM_ITEM;
    property COD_ITEM: String                    read FCOD_ITEM         write FCOD_ITEM;
    property DESCR_COMPL: String                 read FDESCR_COMPL      write FDESCR_COMPL;
    property QTD: Double                         read FQTD              write FQTD;
    property UNID: String                        read FUNID             write FUNID;
    property VL_ITEM: currency                   read FVL_ITEM          write FVL_ITEM;
    property VL_DESC: currency                   read FVL_DESC          write FVL_DESC;
    property IND_MOV: TACBrMovimentacaoFisica    read FIND_MOV          write FIND_MOV;
    property CST_ICMS: String                    read FCST_ICMS         write FCST_ICMS;
    property CFOP: String                        read FCFOP             write FCFOP;
    property COD_NAT: String                     read FCOD_NAT          write FCOD_NAT;
    property VL_BC_ICMS: currency                read FVL_BC_ICMS       write FVL_BC_ICMS;
    property ALIQ_ICMS: currency                 read FALIQ_ICMS        write FALIQ_ICMS;
    property VL_ICMS: currency                   read FVL_ICMS          write FVL_ICMS;
    property VL_BC_ICMS_ST: currency             read FVL_BC_ICMS_ST    write FVL_BC_ICMS_ST;
    property ALIQ_ST: currency                   read FALIQ_ST          write FALIQ_ST;
    property VL_ICMS_ST: currency                read FVL_ICMS_ST       write FVL_ICMS_ST;
    property IND_APUR: TACBrApuracaoIPI          read FIND_APUR         write FIND_APUR;
//    property CST_IPI: TACBrSituacaoTribIPI       read FCST_IPI          write FCST_IPI;
    property CST_IPI: string                     read FCST_IPI          write FCST_IPI;
    property COD_ENQ: String                     read FCOD_ENQ          write FCOD_ENQ;
    property VL_BC_IPI: currency                 read FVL_BC_IPI        write FVL_BC_IPI;
    property ALIQ_IPI: currency                  read FALIQ_IPI         write FALIQ_IPI;
    property VL_IPI: currency                    read FVL_IPI           write FVL_IPI;
//    property CST_PIS: TACBrSituacaoTribPIS       read FCST_PIS          write FCST_PIS;
    property CST_PIS: string                     read FCST_PIS          write FCST_PIS;
    property VL_BC_PIS: currency                 read FVL_BC_PIS        write FVL_BC_PIS;
    property ALIQ_PIS_PERC: currency             read FALIQ_PIS_PERC    write FALIQ_PIS_PERC;
    property QUANT_BC_PIS: Double                read FQUANT_BC_PIS     write FQUANT_BC_PIS;
    property ALIQ_PIS_R: Double                  read FALIQ_PIS_R       write FALIQ_PIS_R;
    property VL_PIS: currency                    read FVL_PIS           write FVL_PIS;
//    property CST_COFINS: TACBrSituacaoTribCOFINS read FCST_COFINS       write FCST_COFINS;
    property CST_COFINS: string                  read FCST_COFINS       write FCST_COFINS;
    property VL_BC_COFINS: currency              read FVL_BC_COFINS     write FVL_BC_COFINS;
    property ALIQ_COFINS_PERC: currency          read FALIQ_COFINS_PERC write FALIQ_COFINS_PERC;
    property QUANT_BC_COFINS: Double             read FQUANT_BC_COFINS  write FQUANT_BC_COFINS;
    property ALIQ_COFINS_R: Double               read FALIQ_COFINS_R    write FALIQ_COFINS_R;
    property VL_COFINS: currency                 read FVL_COFINS        write FVL_COFINS;
    property COD_CTA: String                     read FCOD_CTA          write FCOD_CTA;
    /// Registros FILHOS
    property RegistroC171: TRegistroC171List read FRegistroC171 write FRegistroC171;
    property RegistroC172: TRegistroC172List read FRegistroC172 write FRegistroC172;
    property RegistroC173: TRegistroC173List read FRegistroC173 write FRegistroC173;
    property RegistroC174: TRegistroC174List read FRegistroC174 write FRegistroC174;
    property RegistroC175: TRegistroC175List read FRegistroC175 write FRegistroC175;
    property RegistroC176: TRegistroC176List read FRegistroC176 write FRegistroC176;
    property RegistroC177: TRegistroC177List read FRegistroC177 write FRegistroC177;
    property RegistroC178: TRegistroC178List read FRegistroC178 write FRegistroC178;
    property RegistroC179: TRegistroC179List read FRegistroC179 write FRegistroC179;
  end;

  /// Registro C170 - Lista

  TRegistroC170List = class(TObjectList)
  private
    function GetItem(Index: Integer): TRegistroC170; /// GetItem
    procedure SetItem(Index: Integer; const Value: TRegistroC170); /// SetItem
  public
    function New: TRegistroC170;
    property Items[Index: Integer]: TRegistroC170 read GetItem write SetItem;
  end;

  //REGISTRO C180: CONSOLIDAÇÃO DE NOTAS FISCAIS ELETRÕNICAS EMITIDAS PELA PESSOA JURÍDICA (CÓDIGO 55) – OPERAÇÕES DE VENDAS
  TRegistroC180 = class
  private
    fCOD_MOD: string;	             //02	COD_MOD	Texto fixo contendo "55" Código da Nota Fiscal Eletrônica, modelo 55, conforme a Tabela 4.1.1.	C	002*	-
    fDT_DOC_INI: TDateTime;	       //03	DT_DOC_INI	Data de Emissão Inicial dos Documentos	N	008*	-
    fDT_DOC_FIN: TDateTime;	       //04	DT_DOC_FIN	Data de Emissão Final dos Documentos	N	008*	-
    fCOD_ITEM: string;	             //05	COD_ITEM	Código do Item (campo 02 do Registro 0200)	C	060	-
    fCOD_NCM: string;	             //06	COD_NCM	Código da Nomenclatura Comum do Mercosul	C	008*	-
    fEX_IPI: string;	               //07	EX_IPI	Código EX, conforme a TIPI	C	003	-
    fVL_TOT_ITEM: Currency;	       //08	VL_TOT_ITEM	Valor Total do Item	N	-	02
  public
    property COD_MOD: string read FCOD_MOD write FCOD_MOD;
    property DT_DOC_INI: TDateTime read FDT_DOC_INI write FDT_DOC_INI;
    property DT_DOC_FIN: TDateTime read FDT_DOC_FIN write FDT_DOC_FIN;
    property COD_ITEM: string read FCOD_ITEM write FCOD_ITEM;
    property COD_NCM: string read FCOD_NCM write FCOD_NCM;
    property EX_IPI: string read FEX_IPI write FEX_IPI;
    property VL_TOT_ITEM: Currency read FVL_TOT_ITEM write FVL_TOT_ITEM;
  end;

  // Registro C180 - Lista
  TRegistroC180List = class(TObjectList)
  private
    function GetItem(Index: Integer): TRegistroC180;
    procedure SetItem(Index: Integer; const Value: TRegistroC180);
  public
    function New: TRegistroC180;
    property Items[Index: Integer]: TRegistroC180 read GetItem write SetItem;
  end;

  //REGISTRO C181: DETALHAMENTO DA CONSOLIDAÇÃO – OPERAÇÕES DE VENDAS – PIS/PASEP
  TRegistroC181 = class
  private
    fCST_PIS: string;	              //02	CST_PIS	Código da Situação Tributária referente ao PIS/PASEP, conforme a Tabela indicada no item 4.3.3.	N	002*	-
    fCFOP: Integer;	                //03	CFOP	Código fiscal de operação e prestação	N	004*	-
    fVL_ITEM: Currency;	            //04	VL_ITEM	Valor do item	N	-	02
    fVL_DESC: Currency;	            //05	VL_DESC	Valor do desconto comercial	N	-	02
    fVL_BC_PIS: Currency;	          //06	VL_BC_PIS	Valor da base de cálculo do PIS/PASEP	N	 -	02
    fALIQ_PIS: Currency;	            //07	ALIQ_PIS	Alíquota do PIS/PASEP (em percentual)	N	008	04
    fQUANT_BC_PIS: Currency;	        //08	QUANT_BC_PIS	Quantidade – Base de cálculo PIS/PASEP	N	 -	03
    fALIQ_PIS_QUANT: Currency;	      //09	ALIQ_PIS_QUANT	Alíquota do PIS/PASEP (em reais)	N	 -	04
    fVL_PIS: Currency;	              //10	VL_PIS	Valor do PIS/PASEP	N	-	02
    fCOD_CTA: string;	              //11	COD_CTA	Código da conta analítica contábil debitada/creditada	C	060	-
  public
    property CST_PIS: string read FCST_PIS write FCST_PIS;
    property CFOP: Integer read FCFOP write FCFOP;
    property VL_ITEM: Currency read FVL_ITEM write FVL_ITEM;
    property VL_DESC: Currency read FVL_DESC write FVL_DESC;
    property VL_BC_PIS: Currency read FVL_BC_PIS write FVL_BC_PIS;
    property ALIQ_PIS: Currency read FALIQ_PIS write FALIQ_PIS;
    property QUANT_BC_PIS: Currency read FQUANT_BC_PIS write FQUANT_BC_PIS;
    property ALIQ_PIS_QUANT: Currency read FALIQ_PIS_QUANT write FALIQ_PIS_QUANT;
    property VL_PIS: Currency read FVL_PIS write FVL_PIS;
    property COD_CTA: string read FCOD_CTA write FCOD_CTA;
  end;

  // Registro C181 - Lista
  TRegistroC181List = class(TObjectList)
  private
    function GetItem(Index: Integer): TRegistroC181;
    procedure SetItem(Index: Integer; const Value: TRegistroC181);
  public
    function New: TRegistroC181;
    property Items[Index: Integer]: TRegistroC181 read GetItem write SetItem;
  end;

  //REGISTRO C185: DETALHAMENTO DA CONSOLIDAÇÃO – OPERAÇÕES DE VENDAS – COFINS
  TRegistroC185 = class
  private
    fCST_COFINS: string;	            //02	CST_COFINS	Código da Situação Tributária referente a COFINS, conforme a Tabela indicada no item 4.3.4.	N	002*	-
    fCFOP: Integer;	                  //03	CFOP	Código fiscal de operação e prestação	N	004*	-
    fVL_ITEM: Currency;	              //04	VL_ITEM	Valor do item	N	-	02
    fVL_DESC: Currency;	              //05	VL_DESC	Valor do desconto comercial	N	-	02
    fVL_BC_COFINS: Currency;	        //06	VL_BC_COFINS	Valor da base de cálculo da COFINS	N	 -	02
    fALIQ_COFINS: Currency;	          //07	ALIQ_COFINS	Alíquota da COFINS (em percentual)	N	008	04
    fQUANT_BC_COFINS: Currency;	      //08	QUANT_BC_COFINS	Quantidade – Base de cálculo da COFINS	N	 -	03
    fALIQ_COFINS_QUANT: Currency;     //09	ALIQ_COFINS_QUANT	Alíquota da COFINS (em reais)	N	 -	04
    fVL_COFINS: Currency;	            //10	VL_COFINS	Valor da COFINS	N	-	02
    fCOD_CTA: string;	                //11	COD_CTA	Código da conta analítica contábil debitada/creditada	C	060	-
  public
    property CST_COFINS: string read FCST_COFINS write FCST_COFINS;
    property CFOP: Integer read FCFOP write FCFOP;
    property VL_ITEM: Currency read FVL_ITEM write FVL_ITEM;
    property VL_DESC: Currency read FVL_DESC write FVL_DESC;
    property VL_BC_COFINS: Currency read FVL_BC_COFINS write FVL_BC_COFINS;
    property ALIQ_COFINS: Currency read FALIQ_COFINS write FALIQ_COFINS;
    property QUANT_BC_COFINS: Currency read FQUANT_BC_COFINS write FQUANT_BC_COFINS;
    property ALIQ_COFINS_QUANT: Currency read FALIQ_COFINS_QUANT write FALIQ_COFINS_QUANT;
    property VL_COFINS: Currency read FVL_COFINS write FVL_COFINS;
    property COD_CTA: string read FCOD_CTA write FCOD_CTA;
  end;

  // Registro C185 - Lista
  TRegistroC185List = class(TObjectList)
  private
    function GetItem(Index: Integer): TRegistroC185;
    procedure SetItem(Index: Integer; const Value: TRegistroC185);
  public
    function New: TRegistroC185;
    property Items[Index: Integer]: TRegistroC185 read GetItem write SetItem;
  end;

  //REGISTRO C188: PROCESSO REFERENCIADO
  TRegistroC188 = class
  private
    fNUM_PROC: string;        //02	NUM_PROC	Identificação do processo ou ato concessório	C	020	-
    fIND_PROC: Integer;       //03	IND_PROC	Indicador da origem do processo:1 - Justiça Federal;3 - Secretaria da Receita Federal do Brasil;9 – Outros.	C	001*	-
  public
    property NUM_PROC: string read FNUM_PROC write FNUM_PROC;
    property IND_PROC: Integer read FIND_PROC write FIND_PROC;
  end;

  // Registro C188 - Lista
  TRegistroC188List = class(TObjectList)
  private
    function GetItem(Index: Integer): TRegistroC188;
    procedure SetItem(Index: Integer; const Value: TRegistroC188);
  public
    function New: TRegistroC188;
    property Items[Index: Integer]: TRegistroC188 read GetItem write SetItem;
  end;

  //REGISTRO C190: CONSOLIDAÇÃO DE NOTAS FISCAIS ELETRÔNICAS (CÓDIGO 55) – OPERAÇÕES DE AQUISIÇÃO COM DIREITO A CRÉDITO, E OPERAÇÕES DE DEVOLUÇÃO DE COMPRAS E VENDAS
  TRegistroC190 = class
  private
    fCOD_MOD: string;	               //02	COD_MOD	Texto fixo contendo "55" Código da Nota Fiscal Eletrônica, modelo 55, conforme a Tabela 4.1.1.	C	002*	-
    fDT_REF_INI: TDateTime;          //03	DT_REF_INI	Data Inicial de Referencia da Consolidação	N	008*	-
    fDT_REF_FIN: TDateTime;          //04	DT_REF_FIN	Data Final de Referencia da Consolidação	N	008*	-
    fCOD_ITEM: string;	             //05	COD_ITEM	Código do item (campo 02 do Registro 0200)	C	060	-
    fCOD_NCM: string;	               //06	COD_NCM	Código da Nomenclatura Comum do Mercosul	C	008*	-
    fEX_IPI: string;	               //07	EX_IPI	Código EX, conforme a TIPI	C	003	-
    fVL_TOT_ITEM: Currency;          //08	VL_TOT_ITEM	Valor Total do Item	N	-	02
  public
    property COD_MOD: string read FCOD_MOD write FCOD_MOD;
    property DT_REF_INI: TDateTime read FDT_REF_INI write FDT_REF_INI;
    property DT_REF_FIN: TDateTime read FDT_REF_FIN write FDT_REF_FIN;
    property COD_ITEM: string read FCOD_ITEM write FCOD_ITEM;
    property COD_NCM: string read FCOD_NCM write FCOD_NCM;
    property EX_IPI: string read FEX_IPI write FEX_IPI;
    property VL_TOT_ITEM: Currency read FVL_TOT_ITEM write FVL_TOT_ITEM;
  end;

  // Registro C190 - Lista
  TRegistroC190List = class(TObjectList)
  private
    function GetItem(Index: Integer): TRegistroC190;
    procedure SetItem(Index: Integer; const Value: TRegistroC190);
  public
    function New: TRegistroC190;
    property Items[Index: Integer]: TRegistroC190 read GetItem write SetItem;
  end;

  //REGISTRO C191: DETALHAMENTO DA CONSOLIDAÇÃO – OPERAÇÕES DE AQUISIÇÃO COM DIREITO A CRÉDITO, E OPERAÇÕES DE DEVOLUÇÃO DE COMPRAS E VENDAS – PIS/PASEP
  TRegistroC191 = class
  private
    fCOD_PART: string;	             //02	COD_PART	Código do Participante (campo 02 do Registro 0150) do emitente dos documentos ou do remetente das mercadorias.	C	060	-
    fCST_PIS: string;	               //03	CST_PIS	Código da Situação Tributária referente ao PIS/PASEP	N	002*	-
    fCFOP: Integer;	                 //04	CFOP	Código fiscal de operação e prestação	N	004*	-
    fVL_ITEM: Currency;	             //05	VL_ITEM	Valor do item	N	-	02
    fVL_DESC: Currency;	             //06	VL_DESC	Valor do desconto comercial	N	-	02
    fVL_BC_PIS: Currency;	           //07	VL_BC_PIS	Valor da base de cálculo do PIS/PASEP	N	-	02
    fALIQ_PIS: Currency;	           //08	ALIQ_PIS	Alíquota do PIS/PASEP (em percentual)	N	008	04
    fQUANT_BC_PIS: Currency;	       //09	QUANT_BC_PIS	Quantidade – Base de cálculo PIS/PASEP	N	-	03
    fALIQ_PIS_QUANT: Currency;       //10	ALIQ_PIS_QUANT	Alíquota do PIS/PASEP (em reais)	N	-	04
    fVL_PIS: Currency;	             //11	VL_PIS	Valor do PIS/PASEP	N	-	02
    fCOD_CTA: string;	               //12	COD_CTA	Código da conta analítica contábil debitada/creditada	C	060	-
  public
    property COD_PART: string read FCOD_PART write FCOD_PART;
    property CST_PIS: string  read FCST_PIS write FCST_PIS;
    property CFOP: Integer read FCFOP write FCFOP;
    property VL_ITEM: Currency read FVL_ITEM write FVL_ITEM;
    property VL_DESC: Currency read FVL_DESC write FVL_DESC;
    property VL_BC_PIS: Currency read FVL_BC_PIS write FVL_BC_PIS;
    property ALIQ_PIS: Currency read FALIQ_PIS write FALIQ_PIS;
    property QUANT_BC_PIS: Currency read FQUANT_BC_PIS write FQUANT_BC_PIS;
    property ALIQ_PIS_QUANT: Currency read FALIQ_PIS_QUANT write FALIQ_PIS_QUANT;
    property VL_PIS: Currency read FVL_PIS write FVL_PIS;
    property COD_CTA: string read FCOD_CTA write FCOD_CTA;
  end;

  // Registro C191 - Lista
  TRegistroC191List = class(TObjectList)
  private
    function GetItem(Index: Integer): TRegistroC191;
    procedure SetItem(Index: Integer; const Value: TRegistroC191);
  public
    function New: TRegistroC191;
    property Items[Index: Integer]: TRegistroC191 read GetItem write SetItem;
  end;

  //REGISTRO C195: DETALHAMENTO DA CONSOLIDAÇÃO - OPERAÇÕES DE AQUISIÇÃO COM DIREITO A CRÉDITO, E OPERAÇÕES DE DEVOLUÇÃO DE COMPRAS E VENDAS – COFINS
  TRegistroC195 = class
  private
    fCOD_PART: string;	                //02	COD_PART	Código do Participante (campo 02 do Registro 0150) do emitente dos documentos ou do remetente das mercadorias.	C	060	-
    fCST_COFINS: Integer;	              //03	CST_COFINS	Código da Situação Tributária referente a COFINS.	N	002*	-
    fCFOP: Integer;	                    //04	CFOP	Código fiscal de operação e prestação	N	004*	-
    fVL_ITEM: Currency;	                //05	VL_ITEM	Valor do item	N	-	02
    fVL_DESC: Currency;	                //06	VL_DESC	Valor do desconto comercial	N	-	02
    fVL_BC_COFINS: Currency;	          //07	VL_BC_COFINS	Valor da base de cálculo da COFINS	N	-	02
    fALIQ_COFINS: Currency;	            //08	ALIQ_COFINS	Alíquota da COFINS (em percentual)	N	008	04
    fQUANT_BC_COFINS: Currency;	        //09	QUANT_BC_COFINS	Quantidade – Base de cálculo da COFINS	N	-	03
    fALIQ_COFINS_QUANT: Currency;       //10	ALIQ_COFINS_QUANT	Alíquota da COFINS (em reais)	N	-	04
    fVL_COFINS: Currency;	              //11	VL_COFINS	Valor da COFINS	N	-	02
    fCOD_CTA: string;	                  //12	COD_CTA	Código da conta analítica contábil debitada/creditada	C	060	-
  public
    property COD_PART: string read FCOD_PART write FCOD_PART;
    property CST_COFINS: Integer read FCST_COFINS write FCST_COFINS;
    property CFOP: Integer read FCFOP write FCFOP;
    property VL_ITEM: Currency read FVL_ITEM write FVL_ITEM;
    property VL_DESC: Currency read FVL_DESC write FVL_DESC;
    property VL_BC_COFINS: Currency read FVL_BC_COFINS write FVL_BC_COFINS;
    property ALIQ_COFINS: Currency read FALIQ_COFINS write FALIQ_COFINS;
    property QUANT_BC_COFINS: Currency read FQUANT_BC_COFINS write FQUANT_BC_COFINS;
    property ALIQ_COFINS_QUANT: Currency read FALIQ_COFINS_QUANT write FALIQ_COFINS_QUANT;
    property VL_COFINS: Currency read FVL_COFINS write FVL_COFINS;
    property COD_CTA: string read FCOD_CTA write FCOD_CTA;
  end;

  // Registro C195 - Lista
  TRegistroC195List = class(TObjectList)
  private
    function GetItem(Index: Integer): TRegistroC195;
    procedure SetItem(Index: Integer; const Value: TRegistroC195);
  public
    function New: TRegistroC195;
    property Items[Index: Integer]: TRegistroC195 read GetItem write SetItem;
  end;

  //REGISTRO C198: PROCESSO REFERENCIADO
  TRegistroC198 = class
  private
    fNUM_PROC: string;              //02	NUM_PROC	Identificação do processo ou ato concessório	C	020	-
    fIND_PROC: Integer;             //03	IND_PROC	Indicador da origem do processo:1 - Justiça Federal;3 – Secretaria da Receita Federal do Brasil;9 – Outros.	C	001*	-
  public
    property NUM_PROC: string read FNUM_PROC write FNUM_PROC;
    property IND_PROC: Integer read FIND_PROC write FIND_PROC;
  end;

  // Registro C198 - Lista
  TRegistroC198List = class(TObjectList)
  private
    function GetItem(Index: Integer): TRegistroC198;
    procedure SetItem(Index: Integer; const Value: TRegistroC198);
  public
    function New: TRegistroC198;
    property Items[Index: Integer]: TRegistroC198 read GetItem write SetItem;
  end;

  //REGISTRO C199: COMPLEMENTO DO DOCUMENTO - OPERAÇÕES DE IMPORTAÇÃO (CÓDIGO 55)
  TRegistroC199 = class
  private
    fCOD_DOC_IMP: Integer;	           //02	COD_DOC_IMP	Documento de importação:0 – Declaração de Importação;1 – Declaração Simplificada de Importação.	C	001*	-
    fNUM_DOC__IMP: string;             //03	NUM_DOC__IMP	Número do documento de Importação.	C	010	-
    fVL_PIS_IMP: Currency;	           //04	VL_PIS_IMP	Valor pago de PIS na importação	N	-	02
    fVL_COFINS_IMP: Currency;          //05	VL_COFINS_IMP	Valor pago de COFINS na importação	N	-	02
    fNUM_ACDRAW: string;	             //06	NUM_ACDRAW	Número do Ato Concessório do regime Drawback 	C	011	-
  public
    property COD_DOC_IMP: Integer read FCOD_DOC_IMP write FCOD_DOC_IMP;
    property NUM_DOC__IMP: string read FNUM_DOC__IMP write FNUM_DOC__IMP;
    property VL_PIS_IMP: Currency read FVL_PIS_IMP write FVL_PIS_IMP;
    property VL_COFINS_IMP: Currency read FVL_COFINS_IMP write FVL_COFINS_IMP;
    property NUM_ACDRAW: string read FNUM_ACDRAW write FNUM_ACDRAW;
  end;

  // Registro C199 - Lista
  TRegistroC199List = class(TObjectList)
  private
    function GetItem(Index: Integer): TRegistroC199;
    procedure SetItem(Index: Integer; const Value: TRegistroC199);
  public
    function New: TRegistroC199;
    property Items[Index: Integer]: TRegistroC199 read GetItem write SetItem;
  end;

  //REGISTRO C381: DETALHAMENTO DA CONSOLIDAÇÃO – PIS/PASEP
  TRegistroC381 = class
  private
    fCST_PIS: string;	               //02	CST_PIS	Código da Situação Tributária referente ao PIS/PASEP	N	002*	-
    fCOD_ITEM: string;	             //03	COD_ITEM	Código do item (campo 02 do Registro 0200)	C	060	-
    fVL_ITEM: Currency;	             //04	VL_ITEM	Valor total dos itens	N	-	02
    fVL_BC_PIS: Currency;	           //05	VL_BC_PIS	Valor da base de cálculo do PIS/PASEP	N	 -	02
    fALIQ_PIS: Currency;	           //06	ALIQ_PIS	Alíquota do PIS/PASEP (em percentual)	N	008	04
    fQUANT_BC_PIS: Currency;	       //07	QUANT_BC_PIS	Quantidade – Base de cálculo do PIS/PASEP	N	 	03
    fALIQ_PIS_QUANT: Currency;       //08	ALIQ_PIS_QUANT	Alíquota do PIS/PASEP (em reais)	N	 -	04
    fVL_PIS: Currency;	             //09	VL_PIS	Valor do PIS/PASEP	N	-	02
    fCOD_CTA: string;	               //10	COD_CTA	Código da conta analítica contábil debitada/creditada	C	060	-
  public
    property CST_PIS: string read FCST_PIS write FCST_PIS;
    property COD_ITEM: string read FCOD_ITEM write FCOD_ITEM;
    property VL_ITEM: Currency read FVL_ITEM write FVL_ITEM;
    property VL_BC_PIS: Currency read FVL_BC_PIS write FVL_BC_PIS;
    property ALIQ_PIS: Currency read FALIQ_PIS write FALIQ_PIS;
    property QUANT_BC_PIS: Currency read FQUANT_BC_PIS write FQUANT_BC_PIS;
    property ALIQ_PIS_QUANT: Currency read FALIQ_PIS_QUANT write FALIQ_PIS_QUANT;
    property VL_PIS: Currency read FVL_PIS write FVL_PIS;
    property COD_CTA: string read FCOD_CTA write FCOD_CTA;
  end;

  // Registro C381 - Lista
  TRegistroC381List = class(TObjectList)
  private
    function GetItem(Index: Integer): TRegistroC381;
    procedure SetItem(Index: Integer; const Value: TRegistroC381);
  public
    function New: TRegistroC381;
    property Items[Index: Integer]: TRegistroC381 read GetItem write SetItem;
  end;

  //REGISTRO C385: DETALHAMENTO DA CONSOLIDAÇÃO – COFINS
  TRegistroC385 = class
  private
    fCST_COFINS: string;	                //02	CST_COFINS	Código da Situação Tributária referente a COFINS.	N	002*	-
    fCOD_ITEM: string;	                  //03	COD_ITEM	Código do item (campo 02 do Registro 0200)	C	060	-
    fVL_ITEM: Currency;	                  //04	VL_ITEM	Valor total dos itens	N	-	02
    fVL_BC_COFINS: Currency;	            //05	VL_BC_COFINS	Valor da base de cálculo da COFINS	N	 	02
    fALIQ_COFINS: Currency;	              //06	ALIQ_COFINS	Alíquota da COFINS (em percentual)	N	008	04
    fQUANT_BC_COFINS: Currency;	          //07	QUANT_BC_COFINS	Quantidade – Base de cálculo da COFINS	N	 	03
    fALIQ_COFINS_QUANT: Currency;	        //08	ALIQ_COFINS_QUANT	Alíquota da COFINS (em reais)	N	 	04
    fVL_COFINS: Currency;	                //09	VL_COFINS	Valor da COFINS	N	-	02
    fCOD_CTA: string;	                    //10	COD_CTA	Código da conta analítica contábil debitada/creditada	C	060	-
  public
    property CST_COFINS: string read FCST_COFINS write FCST_COFINS;
    property COD_ITEM: string read FCOD_ITEM write FCOD_ITEM;
    property VL_ITEM: Currency read FVL_ITEM write FVL_ITEM;
    property VL_BC_COFINS: Currency read FVL_BC_COFINS write FVL_BC_COFINS;
    property ALIQ_COFINS: Currency read FALIQ_COFINS write FALIQ_COFINS;
    property QUANT_BC_COFINS: Currency read FQUANT_BC_COFINS write FQUANT_BC_COFINS;
    property ALIQ_COFINS_QUANT: Currency read FALIQ_COFINS_QUANT write FALIQ_COFINS_QUANT;
    property VL_COFINS: Currency read FVL_COFINS write FVL_COFINS;
    property COD_CTA: string read FCOD_CTA write FCOD_CTA;
  end;

  // Registro C385 - Lista
  TRegistroC385List = class(TObjectList)
  private
    function GetItem(Index: Integer): TRegistroC385;
    procedure SetItem(Index: Integer; const Value: TRegistroC385);
  public
    function New: TRegistroC385;
    property Items[Index: Integer]: TRegistroC385 read GetItem write SetItem;
  end;

  //REGISTRO C395: NOTAS FISCAIS DE VENDA A CONSUMIDOR (CÓDIGOS 02, 2D, 2E e 59) – AQUISIÇÕES/ENTRADAS COM CRÉDITO
  TRegistroC395 = class
  private
    fCOD_MOD: string;	             //02	COD_MOD	Código do modelo do documento fiscal, conforme a Tabela 4.1.1 	C	002*	-
    fCOD_PART: string;             //03	COD_PART	Código do participante emitente do documento (campo 02 do Registro 0150).	C	060	-
    fSER: string;	                 //04	SER	Série do documento fiscal	C	003	-
    fSUB_SER: string;	             //05	SUB_SER	Subsérie do documento fiscal	C	003	-
    fNUM_DOC: string;	             //06	NUM_DOC	Número do documento fiscal	C	006	-
    fDT_DOC: TDateTime;	           //07	DT_DOC	Data da emissão do documento fiscal	N	008*	-
    fVL_DOC: Currency;	           //08	VL_DOC	Valor total do documento fiscal	N	-	02
  public
    property COD_MOD: string read FCOD_MOD write FCOD_MOD;
    property COD_PART: string read FCOD_PART write FCOD_PART;
    property SER: string read FSER write FSER;
    property SUB_SER: string read FSUB_SER write FSUB_SER;
    property NUM_DOC: string read FNUM_DOC write FNUM_DOC;
    property DT_DOC: TDateTime read FDT_DOC write FDT_DOC;
    property VL_DOC: Currency read FVL_DOC write FVL_DOC;
  end;

  // Registro C395 - Lista
  TRegistroC395List = class(TObjectList)
  private
    function GetItem(Index: Integer): TRegistroC395;
    procedure SetItem(Index: Integer; const Value: TRegistroC395);
  public
    function New: TRegistroC395;
    property Items[Index: Integer]: TRegistroC395 read GetItem write SetItem;
  end;

  //REGISTRO C396: ITENS DO DOCUMENTO (CÓDIGOS 02, 2D, 2E e 59) – AQUISIÇÕES/ENTRADAS COM CRÉDITO
  TRegistroC396 = class
  private
    fCOD_ITEM: string;	          //02	COD_ITEM	Código do item (campo 02 do Registro 0200)	C	060	-
    fVL_ITEM: Currency;	          //03	VL_ITEM	Valor total do item (mercadorias ou serviços)	N	-	02
    fVL_DESC: Currency;	          //04	VL_DESC	Valor do desconto comercial do item	N	-	02
    fNAT_BC_CRED: string;	        //05	NAT_BC_CRED	Código da Base de Cálculo do Crédito, conforme a Tabela indicada no item 4.3.7.	C	002*	-
    fCST_PIS: string;	            //06	CST_PIS	Código da Situação Tributária referente ao PIS/PASEP	N	002*	-
    fVL_BC_PIS: Currency;	        //07	VL_BC_PIS	Valor da base de cálculo do crédito de PIS/PASEP	N	 	02
    fALIQ_PIS: Currency;	        //08	ALIQ_PIS	Alíquota do PIS/PASEP (em percentual)	N	008	04
    fVL_PIS: Currency;	          //09	VL_PIS	Valor do crédito de PIS/PASEP	N	-	02
    fCST_COFINS: Integer;	        //10	CST_COFINS	Código da Situação Tributária referente a COFINS	N	002*	-
    fVL_BC_COFINS: Currency;      //11	VL_BC_COFINS	Valor da base de cálculo do crédito de COFINS	N	 	02
    fALIQ_COFINS: Currency;	      //12	ALIQ_COFINS	Alíquota da COFINS (em percentual)	N	008	04
    fVL_COFINS: Currency;	        //13	VL_COFINS	Valor do crédito de COFINS	N	-	02
    fCOD_CTA: string;	            //14	COD_CTA	Código da conta analítica contábil debitada/creditada	C	060	-
  public
    property COD_ITEM: string read FCOD_ITEM write FCOD_ITEM;
    property VL_ITEM: Currency read FVL_ITEM write FVL_ITEM;
    property VL_DESC: Currency read FVL_DESC write FVL_DESC;
    property NAT_BC_CRED: string read FNAT_BC_CRED write FNAT_BC_CRED;
    property CST_PIS: string read FCST_PIS write FCST_PIS;
    property VL_BC_PIS: Currency read FVL_BC_PIS write FVL_BC_PIS;
    property ALIQ_PIS: Currency read FALIQ_PIS write FALIQ_PIS;
    property VL_PIS: Currency read FVL_PIS write FVL_PIS;
    property CST_COFINS: Integer read FCST_COFINS write FCST_COFINS;
    property VL_BC_COFINS: Currency read FVL_BC_COFINS write FVL_BC_COFINS;
    property ALIQ_COFINS: Currency read FALIQ_COFINS write FALIQ_COFINS;
    property VL_COFINS: Currency read FVL_COFINS write FVL_COFINS;
    property COD_CTA: string read FCOD_CTA write FCOD_CTA;
  end;

  // Registro C396 - Lista
  TRegistroC396List = class(TObjectList)
  private
    function GetItem(Index: Integer): TRegistroC396;
    procedure SetItem(Index: Integer; const Value: TRegistroC396);
  public
    function New: TRegistroC396;
    property Items[Index: Integer]: TRegistroC396 read GetItem write SetItem;
  end;

  //REGISTRO C400: EQUIPAMENTO ECF (CÓDIGOS 02 e 2D)
  TRegistroC400 = class
  private
    fCOD_MOD: string;          //02	COD_MOD	Código do modelo do documento fiscal, conforme a Tabela 4.1.1	C	002*	-
    fECF_MOD: string;          //03	ECF_MOD	Modelo do equipamento	C	020	-
    fECF_FAB: string;          //04	ECF_FAB	Número de série de fabricação do ECF	C	020	-
    fECF_CX: Integer;          //05	ECF_CX	Número do caixa atribuído ao ECF	N	003	-
  public
    property COD_MOD: string read FCOD_MOD write FCOD_MOD;
    property ECF_MOD: string read FECF_MOD write FECF_MOD;
    property ECF_FAB: string read FECF_FAB write FECF_FAB;
    property ECF_CX: Integer read FECF_CX write FECF_CX;
  end;

  // Registro C400 - Lista
  TRegistroC400List = class(TObjectList)
  private
    function GetItem(Index: Integer): TRegistroC400;
    procedure SetItem(Index: Integer; const Value: TRegistroC400);
  public
    function New: TRegistroC400;
    property Items[Index: Integer]: TRegistroC400 read GetItem write SetItem;
  end;

  //REGISTRO C405: REDUÇÃO Z (CÓDIGOS 02 e 2D)
  TRegistroC405 = class
  private
    fDT_DOC: TDateTime;	           //02	DT_DOC	Data do movimento a que se refere a Redução Z	N	008*	-
    fCRO: Integer;	               //03	CRO	Posição do Contador de Reinício de Operação	N	003	-
    fCRZ: Integer;	               //04	CRZ	Posição do Contador de Redução Z	N	006	-
    fNUM_COO_FIN: Integer;         //05	NUM_COO_FIN	Número do Contador de Ordem de Operação do último documento emitido no dia (Número do COO na Redução Z)	N	006	-
    fGT_FIN: Currency;	           //06	GT_FIN	Valor do Grande Total final	N	-	02
    fVL_BRT: Currency;	           //07	VL_BRT	Valor da venda bruta	N	-	02
  public
    property DT_DOC: TDateTime read FDT_DOC write FDT_DOC;
    property CRO: Integer read FCRO write FCRO;
    property CRZ: Integer read FCRZ write FCRZ;
    property NUM_COO_FIN: Integer read FNUM_COO_FIN write FNUM_COO_FIN;
    property GT_FIN: Currency read FGT_FIN write FGT_FIN;
    property VL_BRT: Currency read FVL_BRT write FVL_BRT;
  end;

  // Registro C405 - Lista
  TRegistroC405List = class(TObjectList)
  private
    function GetItem(Index: Integer): TRegistroC405;
    procedure SetItem(Index: Integer; const Value: TRegistroC405);
  public
    function New: TRegistroC405;
    property Items[Index: Integer]: TRegistroC405 read GetItem write SetItem;
  end;

  //REGISTRO C481: RESUMO DIÁRIO DE DOCUMENTOS EMITIDOS POR ECF – PIS/PASEP (CÓDIGOS 02 e 2D)
  TRegistroC481 = class
  private
    fCST_PIS: Integer;	             //02	CST_PIS	Código da Situação Tributária referente ao PIS/PASEP	N	002*	-
    fVL_ITEM: Currency;	             //03	VL_ITEM	Valor total dos itens	N	-	02
    fVL_BC_PIS: Currency;	           //04	VL_BC_PIS	Valor da base de cálculo do PIS/PASEP	N	 -	02
    fALIQ_PIS: Currency;	           //05	ALIQ_PIS	Alíquota do PIS/PASEP (em percentual)	N	008	04
    fQUANT_BC_PIS: Currency;	       //06	QUANT_BC_PIS	Quantidade – Base de cálculo PIS/PASEP	N	 -	03
    fALIQ_PIS_QUANT: Currency;       //07	ALIQ_PIS_QUANT	Alíquota do PIS/PASEP (em reais)	N	 -	04
    fVL_PIS: Currency;	             //08	VL_PIS	Valor do PIS/PASEP	N	-	02
    fCOD_ITEM: string;	             //09	COD_ITEM	Código do item (campo 02 do Registro 0200)	C	060	-
    fCOD_CTA: string;	               //10	COD_CTA	Código da conta analítica contábil debitada/creditada	C	060	-
  public
    property CST_PIS: Integer read FCST_PIS write FCST_PIS;
    property VL_ITEM: Currency read FVL_ITEM write FVL_ITEM;
    property VL_BC_PIS: Currency read FVL_BC_PIS write FVL_BC_PIS;
    property ALIQ_PIS: Currency read FALIQ_PIS write FALIQ_PIS;
    property QUANT_BC_PIS: Currency read FQUANT_BC_PIS write FQUANT_BC_PIS;
    property ALIQ_PIS_QUANT: Currency read FALIQ_PIS_QUANT write FALIQ_PIS_QUANT;
    property VL_PIS: Currency read FVL_PIS write FVL_PIS;
    property COD_ITEM: string read FCOD_ITEM write FCOD_ITEM;
    property COD_CTA: string read FCOD_CTA write FCOD_CTA;
  end;

  // Registro C481 - Lista
  TRegistroC481List = class(TObjectList)
  private
    function GetItem(Index: Integer): TRegistroC481;
    procedure SetItem(Index: Integer; const Value: TRegistroC481);
  public
    function New: TRegistroC481;
    property Items[Index: Integer]: TRegistroC481 read GetItem write SetItem;
  end;

  //REGISTRO C485: RESUMO DIÁRIO DE DOCUMENTOS EMITIDOS POR ECF – COFINS (CÓDIGOS 02 e 2D)
  TRegistroC485 = class
  private
    fCST_COFINS: Integer;	              //02	CST_COFINS	Código da Situação Tributária referente a COFINS.	N	002*	-
    fVL_ITEM: Currency;	                //03	VL_ITEM	Valor total dos itens	N	-	02
    fVL_BC_COFINS: Currency;	          //04	VL_BC_COFINS	Valor da base de cálculo da COFINS	N	 -	02
    fALIQ_COFINS: Currency;	            //05	ALIQ_COFINS	Alíquota da COFINS (em percentual)	N	008	04
    fQUANT_BC_COFINS: Currency;	        //06	QUANT_BC_COFINS	Quantidade – Base de cálculo da COFINS	N	 -	03
    fALIQ_COFINS_QUANT: Currency;       //07	ALIQ_COFINS_QUANT	Alíquota da COFINS (em reais)	N	 -	04
    fVL_COFINS: Currency;	              //08	VL_COFINS	Valor da COFINS	N	-	02
    fCOD_ITEM: string;	                //09	COD_ITEM	Código do item (campo 02 do Registro 0200)	C	060	-
    fCOD_CTA: string;	                  //10	COD_CTA	Código da conta analítica contábil debitada/creditada	C	060	-
  public
    property CST_COFINS: Integer read FCST_COFINS write FCST_COFINS;
    property VL_ITEM: Currency read FVL_ITEM write FVL_ITEM;
    property VL_BC_COFINS: Currency read FVL_BC_COFINS write FVL_BC_COFINS;
    property ALIQ_COFINS: Currency read FALIQ_COFINS write FALIQ_COFINS;
    property QUANT_BC_COFINS: Currency read FQUANT_BC_COFINS write FQUANT_BC_COFINS;
    property ALIQ_COFINS_QUANT: Currency read FALIQ_COFINS_QUANT write FALIQ_COFINS_QUANT;
    property VL_COFINS: Currency read FVL_COFINS write FVL_COFINS;
    property COD_ITEM: string read FCOD_ITEM write FCOD_ITEM;
    property COD_CTA: string read FCOD_CTA write FCOD_CTA;
  end;

  // Registro C485 - Lista
  TRegistroC485List = class(TObjectList)
  private
    function GetItem(Index: Integer): TRegistroC485;
    procedure SetItem(Index: Integer; const Value: TRegistroC485);
  public
    function New: TRegistroC485;
    property Items[Index: Integer]: TRegistroC485 read GetItem write SetItem;
  end;

  //REGISTRO C489: PROCESSO REFERENCIADO
  TRegistroC489 = class
  private
    fNUM_PROC: string;           //02	NUM_PROC	Identificação do processo ou ato concessório	C	020	-
    fIND_PROC: Integer;          //03	IND_PROC	Indicador da origem do processo:1 - Justiça Federal;3 – Secretaria da Receita Federal do Brasil;9 - Outros.	C	001*	-
  public
    property NUM_PROC: string read FNUM_PROC write FNUM_PROC;
    property IND_PROC: Integer read FIND_PROC write FIND_PROC;
  end;

  // Registro C489 - Lista
  TRegistroC489List = class(TObjectList)
  private
    function GetItem(Index: Integer): TRegistroC489;
    procedure SetItem(Index: Integer; const Value: TRegistroC489);
  public
    function New: TRegistroC489;
    property Items[Index: Integer]: TRegistroC489 read GetItem write SetItem;
  end;

  //REGISTRO C490: CONSOLIDAÇÃO DE DOCUMENTOS EMITIDOS POR ECF (CÓDIGOS 02, 2D e 59)
  TRegistroC490 = class
  private
    fDT_DOC_INI: TDateTime;     //02	DT_DOC_INI	Data de Emissão Inicial dos Documentos	N	008*	-
    fDT_DOC_FIN: TDateTime;     //03	DT_DOC_FIN	Data de Emissão Final dos Documentos	N	008*	-
    fCOD_MOD: string;	          //04	COD_MOD	Código do modelo do documento fiscal, conforme a Tabela 4.1.1	C	002*	-
  public
    property DT_DOC_INI: TDateTime read FDT_DOC_INI write FDT_DOC_INI;
    property DT_DOC_FIN: TDateTime read FDT_DOC_FIN write FDT_DOC_FIN;
    property COD_MOD: string read FCOD_MOD write FCOD_MOD;
  end;

  // Registro C490 - Lista
  TRegistroC490List = class(TObjectList)
  private
    function GetItem(Index: Integer): TRegistroC490;
    procedure SetItem(Index: Integer; const Value: TRegistroC490);
  public
    function New: TRegistroC490;
    property Items[Index: Integer]: TRegistroC490 read GetItem write SetItem;
  end;

  //REGISTRO C491: DETALHAMENTO DA CONSOLIDAÇÃO DE DOCUMENTOS EMITIDOS POR ECF (CÓDIGOS 02, 2D e 59) – PIS/PASEP
  TRegistroC491 = class
  private
    fCOD_ITEM: string;	             //02	COD_ITEM	Código do item (campo 02 do Registro 0200)	C	060	-
    fCST_PIS: Integer;	             //03	CST_PIS	Código da Situação Tributária referente ao PIS/PASEP	N	002*	-
    fCFOP: Integer;	                 //04	CFOP	Código fiscal de operação e prestação	N	004*	-
    fVL_ITEM: Currency;	             //05	VL_ITEM	Valor total dos itens	N	-	02
    fVL_BC_PIS: Currency;	           //06	VL_BC_PIS	Valor da base de cálculo do PIS/PASEP	N	 -	02
    fALIQ_PIS: Currency;	           //07	ALIQ_PIS	Alíquota do PIS/PASEP (em percentual)	N	008	04
    fQUANT_BC_PIS: Currency;	       //08	QUANT_BC_PIS	Quantidade – Base de cálculo PIS/PASEP	N	 -	03
    fALIQ_PIS_QUANT: Currency;       //09	ALIQ_PIS_QUANT	Alíquota do PIS/PASEP (em reais)	N	 -	04
    fVL_PIS: Currency;	             //10	VL_PIS	Valor do PIS/PASEP	N	-	02
    fCOD_CTA: string;	               //11	COD_CTA	Código da conta analítica contábil debitada/creditada	C	060	-
  public
    property COD_ITEM: string read FCOD_ITEM write FCOD_ITEM;
    property CST_PIS: Integer read FCST_PIS write FCST_PIS;
    property CFOP: Integer read FCFOP write FCFOP;
    property VL_ITEM: Currency read FVL_ITEM write FVL_ITEM;
    property VL_BC_PIS: Currency read FVL_BC_PIS write FVL_BC_PIS;
    property ALIQ_PIS: Currency read FALIQ_PIS write FALIQ_PIS;
    property QUANT_BC_PIS: Currency read FQUANT_BC_PIS write FQUANT_BC_PIS;
    property ALIQ_PIS_QUANT: Currency read FALIQ_PIS_QUANT write FALIQ_PIS_QUANT;
    property VL_PIS: Currency read FVL_PIS write FVL_PIS;
    property COD_CTA: string read FCOD_CTA write FCOD_CTA;
  end;

  // Registro C491 - Lista
  TRegistroC491List = class(TObjectList)
  private
    function GetItem(Index: Integer): TRegistroC491;
    procedure SetItem(Index: Integer; const Value: TRegistroC491);
  public
    function New: TRegistroC491;
    property Items[Index: Integer]: TRegistroC491 read GetItem write SetItem;
  end;

  //REGISTRO C495: DETALHAMENTO DA CONSOLIDAÇÃO DE DOCUMENTOS EMITIDOS POR ECF (CÓDIGOS 02, 2D e 59) – COFINS
  TRegistroC495 = class
  private
    fCOD_ITEM: string;	              //02	COD_ITEM	Código do item (campo 02 do Registro 0200)	C	060	-
    fCST_COFINS: Integer;	            //03	CST_COFINS	Código da Situação Tributária referente a COFINS.	N	002*	-
    fCFOP: Integer;	                  //04	CFOP	Código fiscal de operação e prestação	N	004*	-
    fVL_ITEM: Currency;	              //05	VL_ITEM	Valor total dos itens	N	-	02
    fVL_BC_COFINS: Currency;	        //06	VL_BC_COFINS	Valor da base de cálculo da COFINS	N	 -	02
    fALIQ_COFINS: Currency;	          //07	ALIQ_COFINS	Alíquota da COFINS (em percentual)	N	008	04
    fQUANT_BC_COFINS: Currency;	      //08	QUANT_BC_COFINS	Quantidade – Base de cálculo da COFINS	N	 -	03
    fALIQ_COFINS_QUANT: Currency;     //09	ALIQ_COFINS_QUANT	Alíquota da COFINS (em reais)	N	 -	04
    fVL_COFINS:  Currency;	          //10	VL_COFINS	Valor da COFINS	N	-	02
    fCOD_CTA: string;	                //11	COD_CTA	Código da conta analítica contábil debitada/creditada	C	060	-
  public
    property COD_ITEM: string read FCOD_ITEM write FCOD_ITEM;
    property CST_COFINS: Integer read FCST_COFINS write FCST_COFINS;
    property CFOP: Integer read FCFOP write FCFOP;
    property VL_ITEM: Currency read FVL_ITEM write FVL_ITEM;
    property VL_BC_COFINS: Currency read FVL_BC_COFINS write FVL_BC_COFINS;
    property ALIQ_COFINS: Currency read FALIQ_COFINS write FALIQ_COFINS;
    property QUANT_BC_COFINS: Currency read FQUANT_BC_COFINS write FQUANT_BC_COFINS;
    property ALIQ_COFINS_QUANT: Currency read FALIQ_COFINS_QUANT write FALIQ_COFINS_QUANT;
    property VL_COFINS:  Currency read FVL_COFINS write FVL_COFINS;
    property COD_CTA: string read FCOD_CTA write FCOD_CTA;
  end;

  // Registro C495 - Lista
  TRegistroC495List = class(TObjectList)
  private
    function GetItem(Index: Integer): TRegistroC495;
    procedure SetItem(Index: Integer; const Value: TRegistroC495);
  public
    function New: TRegistroC495;
    property Items[Index: Integer]: TRegistroC495 read GetItem write SetItem;
  end;

  //REGISTRO C499: PROCESSO REFERENCIADO
  TRegistroC499 = class
  private
    fNUM_PROC: string;            //02	NUM_PROC	Identificação do processo ou ato concessório	C	020	-
    fIND_PROC: Integer;           //03	IND_PROC	Indicador da origem do processo:1 - Justiça Federal;3 – Secretaria da Receita Federal do Brasil;9 - Outros.	C	001*	-
  public
    property NUM_PROC: string read FNUM_PROC write FNUM_PROC;
    property IND_PROC: Integer read FIND_PROC write FIND_PROC;
  end;

  // Registro C499 - Lista
  TRegistroC499List = class(TObjectList)
  private
    function GetItem(Index: Integer): TRegistroC499;
    procedure SetItem(Index: Integer; const Value: TRegistroC499);
  public
    function New: TRegistroC499;
    property Items[Index: Integer]: TRegistroC499 read GetItem write SetItem;
  end;

  //REGISTRO C500: NOTA FISCAL/CONTA DE ENERGIA ELÉTRICA (CÓDIGO 06), NOTA FISCAL/CONTA DE FORNECIMENTO D'ÁGUA CANALIZADA (CÓDIGO 29) E NOTA FISCAL CONSUMO FORNECIMENTO DE GÁS (CÓDIGO 28) – DOCUMENTOS DE ENTRADA/AQUISIÇÃO COM CRÉDITO
  TRegistroC500 = class
  private
    fCOD_PART: string;	              //02	COD_PART	Código do participante do fornecedor (campo 02 do Registro 0150). 	C	060	-
    fCOD_MOD: string;	                //03	COD_MOD	Código do modelo do documento fiscal, conforme a Tabela 4.1.1 	C	002*	-
    fCOD_SIT: Integer;	              //04	COD_SIT	Código da situação do documento fiscal, conforme a Tabela 4.1.2 	N	002*	-
    fSER: string;	                    //05	SER	Série do documento fiscal	C	004	-
    fSUB: Integer;	                  //06	SUB	Subsérie do documento fiscal	N	003	-
    fNUM_DOC: Integer;	              //07	NUM_DOC	Número do documento fiscal	N	009	-
    fDT_DOC: TDateTime;	              //08	DT_DOC	Data da emissão do documento fiscal	N	008*	-
    fDT_ENT: TDateTime;	              //09	DT_ENT	Data da entrada	N	008*	-
    fVL_DOC: Currency;	              //10	VL_DOC	Valor total do documento fiscal	N	-	02
    fVL_ICMS: Currency;	              //11	VL_ICMS	Valor acumulado do ICMS	N	-	02
    fCOD_INF: string;	                //12	COD_INF	Código da informação complementar do documento fiscal (campo 02 do Registro 0450)	C	006	-
    fVL_PIS: Currency;	              //13	VL_PIS	Valor do PIS/PASEP	N	-	02
    fVL_COFINS: Currency;	            //14	VL_COFINS	Valor da COFINS	N	-	02
  public
    property COD_PART: string read FCOD_PART write FCOD_PART;
    property COD_MOD: string read FCOD_MOD write FCOD_MOD;
    property COD_SIT: Integer read FCOD_SIT write FCOD_SIT;
    property SER: string read FSER write FSER;
    property SUB: Integer read FSUB write FSUB;
    property NUM_DOC: Integer read FNUM_DOC write FNUM_DOC;
    property DT_DOC: TDateTime read FDT_DOC write FDT_DOC;
    property DT_ENT: TDateTime read FDT_ENT write FDT_ENT;
    property VL_DOC: Currency read FVL_DOC write FVL_DOC;
    property VL_ICMS: Currency read FVL_ICMS write FVL_ICMS;
    property COD_INF: string read FCOD_INF write FCOD_INF;
    property VL_PIS: Currency read FVL_PIS write FVL_PIS;
    property VL_COFINS: Currency read FVL_COFINS write FVL_COFINS;
  end;

  // Registro C500 - Lista
  TRegistroC500List = class(TObjectList)
  private
    function GetItem(Index: Integer): TRegistroC500;
    procedure SetItem(Index: Integer; const Value: TRegistroC500);
  public
    function New: TRegistroC500;
    property Items[Index: Integer]: TRegistroC500 read GetItem write SetItem;
  end;

  //REGISTRO C501: COMPLEMENTO DA OPERAÇÃO (CÓDIGOS 06, 28 e 29) – PIS/PASEP
  TRegistroC501 = class
  private
    fCST_PIS: Integer;	        //02	CST_PIS	Código da Situação Tributária referente ao PIS/PASEP	N	002*	-
    fVL_ITEM: Currency;	        //03	VL_ITEM	Valor total dos itens	N	-	02
    fNAT_BC_CRED: string;	      //04	NAT_BC_CRED	Código da Base de Cálculo do Crédito, conforme a Tabela indicada no item 4.3.7.	C	002*	-
    fVL_BC_PIS: Currency;	      //05	VL_BC_PIS	Valor da base de cálculo do PIS/PASEP	N	- 	02
    fALIQ_PIS: Currency;	      //06	ALIQ_PIS	Alíquota do PIS/PASEP (em percentual)	N	008	04
    fVL_PIS: Currency;	        //07	VL_PIS	Valor do PIS/PASEP	N	-	02
    fCOD_CTA: string;	          //08	COD_CTA	Código da conta analítica contábil debitada/creditada	C	060	-
  public
    property CST_PIS: Integer read FCST_PIS write FCST_PIS;
    property VL_ITEM: Currency read FVL_ITEM write FVL_ITEM;
    property NAT_BC_CRED: string read FNAT_BC_CRED write FNAT_BC_CRED;
    property VL_BC_PIS: Currency read FVL_BC_PIS write FVL_BC_PIS;
    property ALIQ_PIS: Currency read FALIQ_PIS write FALIQ_PIS;
    property VL_PIS: Currency read FVL_PIS write FVL_PIS;
    property COD_CTA: string read FCOD_CTA write FCOD_CTA;
  end;

  // Registro C501 - Lista
  TRegistroC501List = class(TObjectList)
  private
    function GetItem(Index: Integer): TRegistroC501;
    procedure SetItem(Index: Integer; const Value: TRegistroC501);
  public
    function New: TRegistroC501;
    property Items[Index: Integer]: TRegistroC501 read GetItem write SetItem;
  end;

  //REGISTRO C505: COMPLEMENTO DA OPERAÇÃO (CÓDIGOS 06, 28 e 29) – COFINS
  TRegistroC505 = class
  private
    fCST_COFINS: Integer;	         //02	CST_COFINS	Código da Situação Tributária referente a COFINS	N	002*	-
    fVL_ITEM: Currency;	           //03	VL_ITEM	Valor total dos itens	N	-	02
    fNAT_BC_CRED: string;	         //04	NAT_BC_CRED	Código da Base de Cálculo do Crédito, conforme a Tabela indicada no item 4.3.7 	C	002*	-
    fVL_BC_COFINS: Currency;       //05	VL_BC_COFINS	Valor da base de cálculo da COFINS	N	 -	02
    fALIQ_COFINS: Currency;	       //06	ALIQ_COFINS	Alíquota da COFINS  (em percentual)	N	008	04
    fVL_COFINS: Currency;	         //07	VL_COFINS	Valor da COFINS	N	-	02
    fCOD_CTA: string;	             //08	COD_CTA	Código da conta analítica contábil debitada/creditada	C	060	-
  public
    property CST_COFINS: Integer read FCST_COFINS write FCST_COFINS;
    property VL_ITEM: Currency read FVL_ITEM write FVL_ITEM;
    property NAT_BC_CRED: string read FNAT_BC_CRED write FNAT_BC_CRED;
    property VL_BC_COFINS: Currency read FVL_BC_COFINS write FVL_BC_COFINS;
    property ALIQ_COFINS: Currency read FALIQ_COFINS write FALIQ_COFINS;
    property VL_COFINS: Currency read FVL_COFINS write FVL_COFINS;
    property COD_CTA: string read FCOD_CTA write FCOD_CTA;
  end;

  // Registro C505 - Lista
  TRegistroC505List = class(TObjectList)
  private
    function GetItem(Index: Integer): TRegistroC505;
    procedure SetItem(Index: Integer; const Value: TRegistroC505);
  public
    function New: TRegistroC505;
    property Items[Index: Integer]: TRegistroC505 read GetItem write SetItem;
  end;

  //REGISTRO C509: PROCESSO REFERENCIADO
  TRegistroC509 = class
  private
    fNUM_PROC: string;         //02	NUM_PROC	Identificação do processo ou ato concessório	C	020	-
    fIND_PROC: string;         //03	IND_PROC	Indicador da origem do processo:1 - Justiça Federal;3 – Secretaria da Receita Federal do Brasil;9 – Outros.	C	001*	-
  public
    property NUM_PROC: string read FNUM_PROC write FNUM_PROC;
    property IND_PROC: string read FIND_PROC write FIND_PROC;
  end;

  // Registro C509 - Lista
  TRegistroC509List = class(TObjectList)
  private
    function GetItem(Index: Integer): TRegistroC509;
    procedure SetItem(Index: Integer; const Value: TRegistroC509);
  public
    function New: TRegistroC509;
    property Items[Index: Integer]: TRegistroC509 read GetItem write SetItem;
  end;

  //REGISTRO C600: CONSOLIDAÇÃO DIÁRIA DE NOTAS FISCAIS/CONTAS EMITIDAS DE ENERGIA ELÉTRICA (CÓDIGO 06), NOTA FISCAL/CONTA DE FORNECIMENTO D'ÁGUA CANALIZADA (CÓDIGO 29) E NOTA FISCAL/CONTA DE FORNECIMENTO DE GÁS (CÓDIGO 28) (EMPRESAS OBRIGADAS OU NÃO OBRIGADAS AO CONVENIO ICMS 115/03) – DOCUMENTOS DE SAÍDA
  TRegistroC600 = class
  private
    fCOD_MOD: string;	                   //02	COD_MOD	Código do modelo do documento fiscal, conforme a Tabela 4.1.1 	C	002*	-
    fCOD_MUN: Integer;	                 //03	COD_MUN	Código do município dos pontos de consumo, conforme a tabela IBGE	N	007*	-
    fSER: string;	                       //04	SER	Série do documento fiscal	C	004	-
    fSUB: Integer;	                     //05	SUB	Subsérie do documento fiscal	N	003	-
    fCOD_CONS: Integer;	                 //06	COD_CONS	Código de classe de consumo de energia elétrica, conforme a Tabela 4.4.5, ou Código de Consumo de Fornecimento D´água – Tabela 4.4.2 ou Código da classe de consumo de gás canalizado   conforme Tabela 4.4.3.	N	002*	-
    fQTD_CONS: Integer;	                 //07	QTD_CONS	Quantidade de documentos consolidados neste registro	N	-	-
    fQTD_CANC: Integer;	                 //08	QTD_CANC	Quantidade de documentos cancelados	N	-	-
    fDT_DOC: TDateTime;	                 //09	DT_DOC	Data dos documentos consolidados	N	008*	-
    fVL_DOC: Currency;	                 //10	VL_DOC	Valor total dos documentos	N	-	02
    fVL_DESC: Currency;	                 //11	VL_DESC	Valor acumulado dos descontos	N	-	02
    fCONS: Integer;	                     //12	CONS	Consumo total acumulado, em kWh (Código 06)	N	-	-
    fVL_FORN: Currency;	                 //13	VL_FORN	Valor acumulado do fornecimento	N	-	02
    fVL_SERV_NT: Currency;	             //14	VL_SERV_NT	Valor acumulado dos serviços não-tributados pelo ICMS	N	-	02
    fVL_TERC: Currency;	                 //15	VL_TERC	Valores cobrados em nome de terceiros	N	-	02
    fVL_DA: Currency;	                   //16	VL_DA	Valor acumulado das despesas acessórias	N	-	02
    fVL_BC_ICMS: Currency;	             //17	VL_BC_ICMS	Valor acumulado da base de cálculo do ICMS	N	-	02
    fVL_ICMS: Currency;	                 //18	VL_ICMS	Valor acumulado do ICMS	N	-	02
    fVL_BC_ICMS_ST: Currency;            //19	VL_BC_ICMS_ST	Valor acumulado da base de cálculo do ICMS substituição tributária	N	-	02
    fVL_ICMS_ST: Currency;	             //20	VL_ICMS_ST	Valor acumulado do ICMS retido por substituição tributária	N	-	02
    fVL_PIS: Currency;	                 //21	VL_PIS	Valor acumulado do PIS/PASEP	N	-	02
    fVL_COFINS: Currency;	               //22	VL_COFINS	Valor acumulado da COFINS	N	-	02
  public
    property COD_MOD: string read FCOD_MOD write FCOD_MOD;
    property COD_MUN: Integer read FCOD_MUN write FCOD_MUN;
    property SER: string read FSER write FSER;
    property SUB: Integer read FSUB write FSUB;
    property COD_CONS: Integer read FCOD_CONS write FCOD_CONS;
    property QTD_CONS: Integer read FQTD_CONS write FQTD_CONS;
    property QTD_CANC: Integer read FQTD_CANC write FQTD_CANC;
    property DT_DOC: TDateTime read FDT_DOC write FDT_DOC;
    property VL_DOC: Currency read FVL_DOC write FVL_DOC;
    property VL_DESC: Currency read FVL_DESC write FVL_DESC;
    property CONS: Integer read FCONS write FCONS;
    property VL_FORN: Currency read FVL_FORN write FVL_FORN;
    property VL_SERV_NT: Currency read FVL_SERV_NT write FVL_SERV_NT;
    property VL_TERC: Currency read FVL_TERC write FVL_TERC;
    property VL_DA: Currency read FVL_DA write FVL_DA;
    property VL_BC_ICMS: Currency read FVL_BC_ICMS write FVL_BC_ICMS;
    property VL_ICMS: Currency read FVL_ICMS write FVL_ICMS;
    property VL_BC_ICMS_ST: Currency read FVL_BC_ICMS_ST write FVL_BC_ICMS_ST;
    property VL_ICMS_ST: Currency read FVL_ICMS_ST write FVL_ICMS_ST;
    property VL_PIS: Currency read FVL_PIS write FVL_PIS;
    property VL_COFINS: Currency read FVL_COFINS write FVL_COFINS;
  end;

  // Registro C600 - Lista
  TRegistroC600List = class(TObjectList)
  private
    function GetItem(Index: Integer): TRegistroC600;
    procedure SetItem(Index: Integer; const Value: TRegistroC600);
  public
    function New: TRegistroC600;
    property Items[Index: Integer]: TRegistroC600 read GetItem write SetItem;
  end;

  //REGISTRO C601: COMPLEMENTO DA CONSOLIDAÇÃO DIÁRIA (CÓDIGOS 06, 28 e 29) – DOCUMENTOS DE SAÍDAS - PIS/PASEP
  TRegistroC601 = class
  private
    fCST_PIS: Integer;	        //02	CST_PIS	Código da Situação Tributária referente ao PIS/PASEP	N	002*	-
    fVL_ITEM: Currency;	        //03	VL_ITEM	Valor total dos itens	N	-	02
    fVL_BC_PIS: Currency;       //04	VL_BC_PIS	Valor da base de cálculo do PIS/PASEP	N	 -	02
    fALIQ_PIS: Currency;        //05	ALIQ_PIS	Alíquota do PIS/PASEP (em percentual)	N	008	04
    fVL_PIS: Currency;	        //06	VL_PIS	Valor do PIS/PASEP	N	-	02
    fCOD_CTA: string;	          //07	COD_CTA	Código da conta analítica contábil debitada/creditada	C	060	-
  public
    property CST_PIS: Integer read FCST_PIS write FCST_PIS;
    property VL_ITEM: Currency read FVL_ITEM write FVL_ITEM;
    property VL_BC_PIS: Currency read FVL_BC_PIS write FVL_BC_PIS;
    property ALIQ_PIS: Currency read FALIQ_PIS write FALIQ_PIS;
    property VL_PIS: Currency read FVL_PIS write FVL_PIS;
    property COD_CTA: string read FCOD_CTA write FCOD_CTA;
  end;

  // Registro C601 - Lista
  TRegistroC601List = class(TObjectList)
  private
    function GetItem(Index: Integer): TRegistroC601;
    procedure SetItem(Index: Integer; const Value: TRegistroC601);
  public
    function New: TRegistroC601;
    property Items[Index: Integer]: TRegistroC601 read GetItem write SetItem;
  end;

  //REGISTRO C605: COMPLEMENTO DA CONSOLIDAÇÃO DIÁRIA (CÓDIGOS 06, 28 e 29) – DOCUMENTOS DE SAÍDAS - COFINS
  TRegistroC605 = class
  private
    fCST_COFINS: Integer;	        //02	CST_COFINS	Código da Situação Tributária referente a COFINS	N	002*	-
    fVL_ITEM: Currency;	          //03	VL_ITEM	Valor total dos itens	N	-	02
    fVL_BC_COFINS: Currency;      //04	VL_BC_COFINS	Valor da base de cálculo da COFINS	N	 	02
    fALIQ_COFINS: Currency;	      //05	ALIQ_COFINS	Alíquota da COFINS (em percentual)	N	008	04
    fVL_COFINS: Currency;	        //06	VL_COFINS	Valor da COFINS	N	-	02
    fCOD_CTA: string;	            //07	COD_CTA	Código da conta analítica contábil debitada/creditada	C	060	-
  public
    property CST_COFINS: Integer read FCST_COFINS write FCST_COFINS;
    property VL_ITEM: Currency read FVL_ITEM write FVL_ITEM;
    property VL_BC_COFINS: Currency read FVL_BC_COFINS write FVL_BC_COFINS;
    property ALIQ_COFINS: Currency read FALIQ_COFINS write FALIQ_COFINS;
    property VL_COFINS: Currency read FVL_COFINS write FVL_COFINS;
    property COD_CTA: string read FCOD_CTA write FCOD_CTA;
  end;

  // Registro C605 - Lista
  TRegistroC605List = class(TObjectList)
  private
    function GetItem(Index: Integer): TRegistroC605;
    procedure SetItem(Index: Integer; const Value: TRegistroC605);
  public
    function New: TRegistroC605;
    property Items[Index: Integer]: TRegistroC605 read GetItem write SetItem;
  end;

  //REGISTRO C609: PROCESSO REFERENCIADO
  TRegistroC609 = class
  private
    fNUM_PROC: string;          //02	NUM_PROC	Identificação do processo ou ato concessório	C	020	-
    fIND_PROC: Integer;         //03	IND_PROC	Indicador da origem do processo:1 - Justiça Federal;3 – Secretaria da Receita Federal do Brasil;9 – Outros.	C	001*	-
  public
    property NUM_PROC: string read FNUM_PROC write FNUM_PROC;
    property IND_PROC: Integer read FIND_PROC write FIND_PROC;
  end;

  // Registro C609 - Lista
  TRegistroC609List = class(TObjectList)
  private
    function GetItem(Index: Integer): TRegistroC609;
    procedure SetItem(Index: Integer; const Value: TRegistroC609);
  public
    function New: TRegistroC609;
    property Items[Index: Integer]: TRegistroC609 read GetItem write SetItem;
  end;

  //REGISTRO C990: ENCERRAMENTO DO BLOCO C
  TRegistroC990 = class
  private
    fQTD_LIN_C: Integer;      //02	QTD_LIN_C	Quantidade total de linhas do Bloco C	N	-	-
  public
    property QTD_LIN_C: Integer read FQTD_LIN_C write FQTD_LIN_C;
  end;

implementation


end.
