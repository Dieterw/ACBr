{******************************************************************************}
{ Projeto: Componentes ACBr                                                    }
{  Biblioteca multiplataforma de componentes Delphi para interação com equipa- }
{ mentos de Automação Comercial utilizados no Brasil                           }
{                                                                              }
{ Direitos Autorais Reservados (c) 2009   Isaque Pinheiro                      }
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
|* 10/04/2009: Isaque Pinheiro
|*  - Criação e distribuição da Primeira Versao
*******************************************************************************}

unit ACBrBloco_C;

interface

uses
  SysUtils, Classes, DateUtils, ACBrBlocos;

type
  /// Registro C001 - ABERTURA DO BLOCO C

  TRegistroC001 = class(TOpenBlocos)
  private
  public
  end;

  TRegistroC110List = class;
  TRegistroC111List = class;
  TRegistroC140List = class; {Márcio Lopes 30Nov2009}
  TRegistroC141List = class; {Márcio Lopes 30Nov2009}
  TRegistroC170List = class;
  TRegistroC190List = class;

  /// Registro C100 - NOTA FISCAL (CÓDIGO 01), NOTA FISCAL AVULSA (CÓDIGO 1B), NOTA FISCAL DE PRODUTOR (CÓDIGO 04) E NFE (CÓDIGO 55)

  TRegistroC100 = class(TPersistent)
  private
    fIND_OPER: AnsiString;     /// Indicador do tipo de operação: 0- Entrada; 1- Saída
    fIND_EMIT: AnsiString;     /// Indicador do emitente do documento fiscal: 0- Emissão própria; 1- Terceiros
    fCOD_PART: AnsiString;     /// Código do participante (campo 02 do Registro 0150):
    fCOD_MOD: AnsiString;      /// Código do modelo do documento fiscal, conforme a Tabela 4.1.1
    fCOD_SIT: AnsiString;      /// Código da situação do documento fiscal, conforme a Tabela 4.1.2
    fSER: AnsiString;          /// Série do documento fiscal
    fNUM_DOC: AnsiString;      /// Número do documento fiscal
    fCHV_NFE: AnsiString;      /// Chave da Nota Fiscal Eletrônica
    fDT_DOC: TDateTime;        /// Data da emissão do documento fiscal
    fDT_E_S: TDateTime;        /// Data da entrada ou da saída
    fVL_DOC: currency;         /// Valor total do documento fiscal
    fIND_PGTO: AnsiString;     /// Indicador do tipo de pagamento:
    fVL_DESC: currency;        /// Valor total do desconto // Prates
    fVL_ABAT_NT: currency;     /// Abatimento não tributado e não comercial Ex. desconto ICMS nas remessas para ZFM: // Prates
    fVL_MERC: currency;        /// Valor das mercadorias constantes no documento fiscal
    fIND_FRT: AnsiString;      /// Indicador do tipo do frete:
    fVL_FRT: currency;         /// Valor do frete indicado no documento fiscal
    fVL_SEG: currency;         /// Valor do seguro indicado no documento fiscal
    fVL_OUT_DA: currency;      /// Valor de outras despesas acessórias
    fVL_BC_ICMS: currency;     /// Valor da base de cálculo do ICMS
    fVL_ICMS: currency;        /// Valor do ICMS
    fVL_BC_ICMS_ST: currency;  /// Valor da base de cálculo do ICMS substituição tributária
    fVL_ICMS_ST: currency;     /// Valor do ICMS retido por substituição tributária
    fVL_IPI: currency;         /// Valor total do IPI
    fVL_PIS: currency;         /// Valor total do PIS
    fVL_COFINS: currency;      /// Valor total da COFINS
    fVL_PIS_ST: currency;      /// Valor total do PIS retido por substituição tributária
    fVL_COFINS_ST: currency;   /// Valor total da COFINS retido por substituição tributária

    FRegistroC110: TRegistroC110List;  /// BLOCO C - Lista de RegistroC110 (FILHO)
    FRegistroC140: TRegistroC140List;  /// BLOCO C - Lista de RegistroC140 (FILHO) {Márcio Lopes 30Nov2009}
    FRegistroC170: TRegistroC170List;  /// BLOCO C - Lista de RegistroC170 (FILHO)
    FRegistroC190: TRegistroC190List;  /// BLOCO C - Lista de RegistroC190 (FILHO) {Jean Barreiros 17Nov2009}
  public
    constructor Create; virtual; /// Create
    destructor Destroy; override; /// Destroy

    property IND_OPER: AnsiString read FIND_OPER write FIND_OPER;
    property IND_EMIT: AnsiString read FIND_EMIT write FIND_EMIT;
    property COD_PART: AnsiString read FCOD_PART write FCOD_PART;
    property COD_MOD: AnsiString read FCOD_MOD write FCOD_MOD;
    property COD_SIT: AnsiString read FCOD_SIT write FCOD_SIT;
    property SER: AnsiString read FSER write FSER;
    property NUM_DOC: AnsiString read FNUM_DOC write FNUM_DOC;
    property CHV_NFE: AnsiString read FCHV_NFE write FCHV_NFE;
    property DT_DOC: TDateTime read FDT_DOC write FDT_DOC;
    property DT_E_S: TDateTime read FDT_E_S write FDT_E_S;
    property VL_DOC: currency read FVL_DOC write FVL_DOC;
    property IND_PGTO: AnsiString read FIND_PGTO write FIND_PGTO;
    property VL_DESC: currency read FVL_DESC write FVL_DESC; // prates
    property VL_ABAT_NT: currency read FVL_ABAT_NT write FVL_ABAT_NT; // Prates
    property VL_MERC: currency read FVL_MERC write FVL_MERC;
    property IND_FRT: AnsiString read FIND_FRT write FIND_FRT;
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
    property RegistroC140: TRegistroC140List read FRegistroC140 write FRegistroC140; {Márcio Lopes 30Nov2009}
    property RegistroC170: TRegistroC170List read FRegistroC170 write FRegistroC170;
    property RegistroC190: TRegistroC190List read FRegistroC190 write FRegistroC190;  {Jean Barreiros 17Nov2009}
  end;

  /// Registro C100 - Lista

  TRegistroC100List = class(TList)
  private
    function GetItem(Index: Integer): TRegistroC100; /// GetItem
    procedure SetItem(Index: Integer; const Value: TRegistroC100); /// SetItem
  public
    destructor Destroy; override;
    function New: TRegistroC100;
    property Items[Index: Integer]: TRegistroC100 read GetItem write SetItem;
  end;

  /// Registro C110 - INFORMAÇÃO COMPLEMENTAR DA NOTA FISCAL (CÓDIGO 01; 1B, 04 e 55)

  TRegistroC110 = class(TPersistent)
  private
    fCOD_INF: AnsiString;       /// Código da informação complementar do documento fiscal (campo 02 do Registro 0450)
    fTXT_COMPL: AnsiString;    /// Descrição complementar do código de referência.

    FRegistroC111: TRegistroC111List;  /// BLOCO C - Lista de RegistroC111 (FILHO fo FILHO)
  public
    constructor Create; virtual; /// Create
    destructor Destroy; override; /// Destroy

    property COD_INF: AnsiString read FCOD_INF write FCOD_INF;
    property TXT_COMPL: AnsiString read FTXT_COMPL write FTXT_COMPL;
    /// Resgistro FILHO do FILHO
    property RegistroC111: TRegistroC111List read FRegistroC111 write FRegistroC111;
  end;

  /// Registro C110 - Lista

  TRegistroC110List = class(TList)
  private
    function GetItem(Index: Integer): TRegistroC110; /// GetItem
    procedure SetItem(Index: Integer; const Value: TRegistroC110); /// SetItem
  public
    destructor Destroy; override;
    function New: TRegistroC110;
    property Items[Index: Integer]: TRegistroC110 read GetItem write SetItem;
  end;

  /// Registro C111 - PROCESSO REFERENCIADO

  TRegistroC111 = class(TPersistent)
  private
    fNUM_PROC: AnsiString;       /// Identificação do processo ou ato concessório
    fIND_PROC: AnsiString;       /// Indicador da origem do processo:
  public
    property NUM_PROC: AnsiString read FNUM_PROC write FNUM_PROC;
    property IND_PROC: AnsiString read FIND_PROC write FIND_PROC;
  end;

  /// Registro C111 - Lista

  TRegistroC111List = class(TList)
  private
    function GetItem(Index: Integer): TRegistroC111; /// GetItem
    procedure SetItem(Index: Integer; const Value: TRegistroC111); /// SetItem
  public
    destructor Destroy; override;
    function New: TRegistroC111;
    property Items[Index: Integer]: TRegistroC111 read GetItem write SetItem;
  end;

  /// Registro C112 - DOCUMENTO DE ARRECADAÇÃO REFERENCIADO

  TRegistroC112 = class(TPersistent)
  private
    fCOD_DA: AnsiString;        /// Código do modelo do documento de arrecadação :
    fUF: AnsiString;            /// Unidade federada beneficiária do recolhimento
    fNUM_DA: AnsiString;        /// Número do documento de arrecadação
    fCOD_AUT: AnsiString;       /// Código completo da autenticação bancária
    fVL_DA: Currency;         /// Valor do total do documento de arrecadação (principal, atualização monetária, juros e multa) // Prates
    fDT_VCTO: TDateTime;    /// Data de vencimento do documento de arrecadação
    fDT_PGTO: TDateTime;    /// Data de pagamento do documento de arrecadação, ou data do vencimento, no caso de ICMS antecipado a recolher.
  public
    property COD_DA: AnsiString read FCOD_DA write FCOD_DA;
    property UF: AnsiString read FUF write FUF;
    property NUM_DA: AnsiString read FNUM_DA write FNUM_DA;
    property COD_AUT: AnsiString read FCOD_AUT write FCOD_AUT;
    property VL_DA: currency read FVL_DA write FVL_DA; // Prats
    property DT_VCTO: TDateTime read FDT_VCTO write FDT_VCTO;
    property DT_PGTO: TDateTime read FDT_PGTO write FDT_PGTO;
  end;

  /// Registro C112 - Lista

  TRegistroC112List = class(TList)
  private
    function GetItem(Index: Integer): TRegistroC112; /// GetItem
    procedure SetItem(Index: Integer; const Value: TRegistroC112); /// SetItem
  public
    destructor Destroy; override;
    function New: TRegistroC112;
    property Items[Index: Integer]: TRegistroC112 read GetItem write SetItem;
  end;

  /// Registro C113 - DOCUMENTO FISCAL REFERENCIADO

  TRegistroC113 = class(TPersistent)
  private
    fIND_OPER: AnsiString; /// Indicador do tipo de operação: 0 - Entrada/aquisição; 1- Saída/prestação
    fIND_EMIT: AnsiString; /// Indicador do emitente do título: 0 - Emissão própria; 1- Terceiros
    fCOD_PART: AnsiString; /// Código do participante emitente (campo 02 do Registro 0150)  do documento referenciado.
    fCOD_MOD: AnsiString; /// Código do documento fiscal, conforme a Tabela 4.1.1
    fSER: AnsiString; /// Série do documento fiscal
    fSUB: AnsiString; /// Subsérie do documento fiscal
    fNUM_DOC: AnsiString; /// Número do documento fiscal
    fDT_DOC: TDateTime; /// Data da emissão do documento fiscal.
  public
    property IND_OPER: AnsiString read fIND_OPER write fIND_OPER;
    property IND_EMIT: AnsiString read fIND_EMIT write fIND_EMIT;
    property COD_PART: AnsiString read fCOD_PART write fCOD_PART;
    property COD_MOD: AnsiString read fCOD_MOD write fCOD_MOD;
    property SER: AnsiString read fSER write fSER;
    property SUB: AnsiString read fSUB write fSUB;
    property NUM_DOC: AnsiString read fNUM_DOC write fNUM_DOC;
    property DT_DOC: TDateTime read fDT_DOC write fDT_DOC;
  end;

  /// Registro C113 - Lista

  TRegistroC113List = class(TList)
  private
    function GetItem(Index: Integer): TRegistroC113; /// GetItem
    procedure SetItem(Index: Integer; const Value: TRegistroC113); /// SetItem
  public
    destructor Destroy; override;
    function New: TRegistroC113;
    property Items[Index: Integer]: TRegistroC113 read GetItem write SetItem;
  end;

  /// Registro C114 - CUPOM FISCAL REFERENCIADO

  TRegistroC114 = class(TPersistent)
  private
    fCOD_MOD: AnsiString;        /// Código do modelo do documento fiscal, conforme a tabela indicada no item 4.1.1
    fECF_FAB: AnsiString;        /// Número de série de fabricação do ECF
    fECF_CX: AnsiString;         /// Número do caixa atribuído ao ECF
    fNUM_DOC: AnsiString;        /// Número do documento fiscal
    fDT_DOC: TDateTime;      /// Data da emissão do documento fiscal
  public
    property COD_MOD: AnsiString read FCOD_MOD write FCOD_MOD;
    property ECF_FAB: AnsiString read FECF_FAB write FECF_FAB;
    property ECF_CX: AnsiString read FECF_CX write FECF_CX;
    property NUM_DOC: AnsiString read FNUM_DOC write FNUM_DOC;
    property DT_DOC: TDateTime read FDT_DOC write FDT_DOC;
  end;

  /// Registro C114 - Lista

  TRegistroC114List = class(TList)
  private
    function GetItem(Index: Integer): TRegistroC114; /// GetItem
    procedure SetItem(Index: Integer; const Value: TRegistroC114); /// SetItem
  public
    destructor Destroy; override;
    function New: TRegistroC114;
    property Items[Index: Integer]: TRegistroC114 read GetItem write SetItem;
  end;

  /// Registro C115 - LOCAL DA COLETA E ENTREGA (CÓDIGO 01, 1B E 04)

  TRegistroC115 = class(TPersistent)
  private
    fIND_CARGA: AnsiString;     /// Indicador do tipo de transporte da carga coletada: 0 - Rodoviário; 1 - Ferroviário; 2 - Rodo-Ferroviário; 3 - Aquaviário; 4 - Dutoviário; 5 - Aéreo; 9 - Outros.
    fCNPJ_COL: AnsiString;      /// Número do CNPJ do contribuinte do local de coleta
    fIE_COL: AnsiString;        /// Inscrição Estadual do contribuinte do local de coleta
    fCPF_COL: AnsiString;       /// CPF do contribuinte do local de coleta das mercadorias.
    fCOD_MUN_COL: AnsiString;   /// Código do Município do local de coleta
    fCNPJ_ENTG: AnsiString;     /// Número do CNPJ do contribuinte do local de entrega
    fIE_ENTG: AnsiString;       /// Inscrição Estadual do contribuinte do local de entrega
    fCPF_ENTG: AnsiString;      /// Cpf do contribuinte do local de entrega
    fCOD_MUN_ENTG: AnsiString;  /// Código do Município do local de entrega
  public
    property IND_CARGA: AnsiString read FIND_CARGA write FIND_CARGA;
    property CNPJ_COL: AnsiString read FCNPJ_COL write FCNPJ_COL;
    property IE_COL: AnsiString read FIE_COL write FIE_COL;
    property CPF_COL: AnsiString read FCPF_COL write FCPF_COL;
    property COD_MUN_COL: AnsiString read FCOD_MUN_COL write FCOD_MUN_COL;
    property CNPJ_ENTG: AnsiString read FCNPJ_ENTG write FCNPJ_ENTG;
    property IE_ENTG: AnsiString read FIE_ENTG write FIE_ENTG;
    property CPF_ENTG: AnsiString read FCPF_ENTG write FCPF_ENTG;
    property COD_MUN_ENTG: AnsiString read FCOD_MUN_ENTG write FCOD_MUN_ENTG;
  end;

  /// Registro C115 - Lista

  TRegistroC115List = class(TList)
  private
    function GetItem(Index: Integer): TRegistroC115; /// GetItem
    procedure SetItem(Index: Integer; const Value: TRegistroC115); /// SetItem
  public
    destructor Destroy; override;
    function New: TRegistroC115;
    property Items[Index: Integer]: TRegistroC115 read GetItem write SetItem;
  end;

  /// Registro C120 - OPERAÇÕES DE IMPORTAÇÃO (CÓDIGO 01)

  TRegistroC120 = class(TPersistent)
  private
    fCOD_DOC_IMP: AnsiString;      /// Documento de importação:
    fNUM_DOC__IMP: AnsiString;     /// Número do documento de Importação.
    fPIS_IMP: currency;        /// Valor pago de PIS na importação
    fCOFINS_IMP: currency;     /// Valor pago de COFINS na importação
  public
    property COD_DOC_IMP: AnsiString read FCOD_DOC_IMP write FCOD_DOC_IMP;
    property NUM_DOC__IMP: AnsiString read FNUM_DOC__IMP write FNUM_DOC__IMP;
    property PIS_IMP: currency read FPIS_IMP write FPIS_IMP;
    property COFINS_IMP: currency read FCOFINS_IMP write FCOFINS_IMP;
  end;

  /// Registro C120 - Lista

  TRegistroC120List = class(TList)
  private
    function GetItem(Index: Integer): TRegistroC120; /// GetItem
    procedure SetItem(Index: Integer; const Value: TRegistroC120); /// SetItem
  public
    destructor Destroy; override;
    function New: TRegistroC120;
    property Items[Index: Integer]: TRegistroC120 read GetItem write SetItem;
  end;

  /// Registro C130 - ISSQN, IRRF E PREVIDÊNCIA SOCIAL

  TRegistroC130 = class(TPersistent)
  private
    fVL_SERV_NT: currency;     /// Valor dos serviços sob não-incidência ou não-tributados pelo ICMS
    fVL_BC_ISSQN: currency;    /// Valor da base de cálculo do ISSQN
    fVL_ISSQN: currency;       /// Valor do ISSQN
    fVL_BC_IRRF: currency;     /// Valor da base de cálculo do Imposto de Renda Retido na Fonte
    fVL_IRRF: currency;        /// Valor do Imposto de Renda - Retido na Fonte
    fVL_BC_PREV: currency;     /// Valor da base de cálculo de retenção da Previdência Social
    fVL_PREV: currency;        /// Valor destacado para retenção da Previdência Social
  public
    property VL_SERV_NT: currency read FVL_SERV_NT write FVL_SERV_NT;
    property VL_BC_ISSQN: currency read FVL_BC_ISSQN write FVL_BC_ISSQN;
    property VL_ISSQN: currency read FVL_ISSQN write FVL_ISSQN;
    property VL_BC_IRRF: currency read FVL_BC_IRRF write FVL_BC_IRRF;
    property VL_IRRF: currency read FVL_IRRF write FVL_IRRF;
    property VL_BC_PREV: currency read FVL_BC_PREV write FVL_BC_PREV;
    property VL_PREV: currency read FVL_PREV write FVL_PREV;
  end;

  /// Registro C130 - Lista

  TRegistroC130List = class(TList)
  private
    function GetItem(Index: Integer): TRegistroC130; /// GetItem
    procedure SetItem(Index: Integer; const Value: TRegistroC130); /// SetItem
  public
    destructor Destroy; override;
    function New: TRegistroC130;
    property Items[Index: Integer]: TRegistroC130 read GetItem write SetItem;
  end;

  /// Registro C140 - FATURA (CÓDIGO 01)

  TRegistroC140 = class(TPersistent)
  private
    fIND_EMIT: AnsiString;       /// Indicador do emitente do título: 0- Emissão própria; 1- Terceiros
    fIND_TIT: AnsiString;        /// Indicador do tipo de título de crédito: 00- Duplicata; 01- Cheque; 02- Promissória; 03- Recibo; 99- Outros (descrever)
    fDESC_TIT: AnsiString;       /// Descrição complementar do título de crédito
    fNUM_TIT: AnsiString;        /// Número ou código identificador do título de crédito
    fQTD_PARC: Integer;     /// Quantidade de parcelas a receber/pagar
    fVL_TIT: currency;       /// Valor original do título de crédito
    FRegistroC141: TRegistroC141List;  /// BLOCO C - Lista de RegistroC141 (FILHO fo FILHO)
  public
    constructor Create; virtual; /// Create
    destructor Destroy; override; /// Destroy

    property IND_EMIT: AnsiString read FIND_EMIT write FIND_EMIT;
    property IND_TIT: AnsiString read FIND_TIT write FIND_TIT;
    property DESC_TIT: AnsiString read FDESC_TIT write FDESC_TIT;
    property NUM_TIT: AnsiString read FNUM_TIT write FNUM_TIT;
    property QTD_PARC: Integer read FQTD_PARC write FQTD_PARC;
    property VL_TIT: currency read FVL_TIT write FVL_TIT;
    property RegistroC141: TRegistroC141List read FRegistroC141 write FRegistroC141; {Márcio Lopes 30Nov2009}
  end;

  /// Registro C140 - Lista

  TRegistroC140List = class(TList)
  private
    function GetItem(Index: Integer): TRegistroC140; /// GetItem
    procedure SetItem(Index: Integer; const Value: TRegistroC140); /// SetItem
  public
    destructor Destroy; override;
    function New: TRegistroC140;
    property Items[Index: Integer]: TRegistroC140 read GetItem write SetItem;
  end;

  /// Registro C141 - VENCIMENTO DA FATURA (CÓDIGO 01)

  TRegistroC141 = class(TPersistent)
  private
    fNUM_PARC: AnsiString;       /// Número da parcela a receber/pagar
    fDT_VCTO: TDateTime;     /// Data de vencimento da parcela
    fVL_PARC: currency;      /// Valor da parcela a receber/pagar
  public
    property NUM_PARC: AnsiString read FNUM_PARC write FNUM_PARC;
    property DT_VCTO: TDateTime read FDT_VCTO write FDT_VCTO;
    property VL_PARC: currency read FVL_PARC write FVL_PARC;
  end;

  /// Registro C141 - Lista

  TRegistroC141List = class(TList)
  private
    function GetItem(Index: Integer): TRegistroC141; /// GetItem
    procedure SetItem(Index: Integer; const Value: TRegistroC141); /// SetItem
  public
    destructor Destroy; override;
    function New: TRegistroC141;
    property Items[Index: Integer]: TRegistroC141 read GetItem write SetItem;
  end;

  /// Registro C160 - VOLUMES TRANSPORTADOS (CÓDIGO 01 E 04) - EXCETO COMBUSTÍVEIS.

  TRegistroC160 = class(TPersistent)
  private
    fCOD_PART: AnsiString;      /// Código do participante (campo 02 do Registro 0150):
    fVEIC_ID: AnsiString;       /// Placa de identificação do veículo
    fQTD_VOL: currency;     /// Quantidade de volumes transportados
    fPESO_BRT: currency;    /// Peso bruto dos volumes transportados (em Kg)
    fPESO_LIQ: currency;    /// Peso líquido dos volumes transportados (em Kg)
    fUF_ID: AnsiString;         /// Sigla da UF da placa do veículo
  public
    property COD_PART: AnsiString read FCOD_PART write FCOD_PART;
    property VEIC_ID: AnsiString read FVEIC_ID write FVEIC_ID;
    property QTD_VOL: currency read FQTD_VOL write FQTD_VOL;
    property PESO_BRT: currency read FPESO_BRT write FPESO_BRT;
    property PESO_LIQ: currency read FPESO_LIQ write FPESO_LIQ;
    property UF_ID: AnsiString read FUF_ID write FUF_ID;
  end;

  /// Registro C160 - Lista

  TRegistroC160List = class(TList)
  private
    function GetItem(Index: Integer): TRegistroC160; /// GetItem
    procedure SetItem(Index: Integer; const Value: TRegistroC160); /// SetItem
  public
    destructor Destroy; override;
    function New: TRegistroC160;
    property Items[Index: Integer]: TRegistroC160 read GetItem write SetItem;
  end;

  /// Registro C165 - OPERAÇÕES COM COMBUSTÍVEIS(CÓDIGO 01; 55)

  TRegistroC165 = class(TPersistent)
  private
    fCOD_PART: AnsiString;      /// Código do participante (campo 02 do Registro 0150):
    fVEIC_ID: AnsiString;       /// Placa de identificação do veículo
    fCOD_AUT: AnsiString;       /// Código da autorização fornecido pela SEFAZ (combustíveis)
    fNR_PASSE: AnsiString;      /// Número do Passe Fiscal
    fHORA: AnsiString;          /// Hora da saída das mercadorias
    fTEMPER: AnsiString;        /// Temperatura em graus Celsius utilizada para quantificação do volume de combustível
    fQTD_VOL: currency;     /// Quantidade de volumes transportados
    fPESO_BRT: currency;    /// Peso bruto dos volumes transportados (em Kg)
    fPESO_LIQ: currency;    /// Peso líquido dos volumes transportados (em Kg)
    fNOM_MOT: AnsiString;       /// Nome do motorista
    fCPF: AnsiString;           /// CPF do motorista
    fUF_ID: AnsiString;         /// Sigla da UF da placa do veículo
  public
    property COD_PART: AnsiString read FCOD_PART write FCOD_PART;
    property VEIC_ID: AnsiString read FVEIC_ID write FVEIC_ID;
    property COD_AUT: AnsiString read FCOD_AUT write FCOD_AUT;
    property NR_PASSE: AnsiString read FNR_PASSE write FNR_PASSE;
    property HORA: AnsiString read FHORA write FHORA;
    property TEMPER: AnsiString read FTEMPER write FTEMPER;
    property QTD_VOL: currency read FQTD_VOL write FQTD_VOL;
    property PESO_BRT: currency read FPESO_BRT write FPESO_BRT;
    property PESO_LIQ: currency read FPESO_LIQ write FPESO_LIQ;
    property NOM_MOT: AnsiString read FNOM_MOT write FNOM_MOT;
    property CPF: AnsiString read FCPF write FCPF;
    property UF_ID: AnsiString read FUF_ID write FUF_ID;
  end;

  /// Registro C165 - Lista

  TRegistroC165List = class(TList)
  private
    function GetItem(Index: Integer): TRegistroC165; /// GetItem
    procedure SetItem(Index: Integer; const Value: TRegistroC165); /// SetItem
  public
    destructor Destroy; override;
    function New: TRegistroC165;
    property Items[Index: Integer]: TRegistroC165 read GetItem write SetItem;
  end;

  /// Registro C170 - ITENS DO DOCUMENTO (CÓDIGO 01, 1B, 04 e 55)

  TRegistroC170 = class(TPersistent)
  private
    fNUM_ITEM: AnsiString;            /// Número seqüencial do item no documento fiscal
    fCOD_ITEM: AnsiString;            /// Código do item (campo 02 do Registro 0200)
    fDESCR_COMPL: AnsiString;         /// Descrição complementar do item como adotado no documento fiscal
    fQTD: currency;               /// Quantidade do item
    fUNID: AnsiString;                /// Unidade do item(Campo 02 do registro 0190)
    fVL_ITEM: currency;           /// Valor total do item
    fVL_DESC: currency;           /// Valor do desconto comercial
    fIND_MOV: AnsiString;             /// Movimentação física do ITEM/PRODUTO: 0 - SIM; 1- NÃO
    fCST_ICMS: AnsiString;            /// Código da Situação Tributária referente ao ICMS, conforme a Tabela indicada no item 4.3.1
    fCFOP: AnsiString;                /// Código Fiscal de Operação e Prestação
    fCOD_NAT: AnsiString;             /// Código da natureza da operação (campo 02 do Registro 0400)
    fVL_BC_ICMS: currency;        /// Valor da base de cálculo do ICMS
    fALIQ_ICMS: currency;         /// Alíquota do ICMS
    fVL_ICMS: currency;           /// Valor do ICMS creditado/debitado
    fVL_BC_ICMS_ST: currency;     /// Valor da base de cálculo referente à substituição tributária
    fALIQ_ST: currency;           /// Alíquota do ICMS da substituição tributária na unidade da federação de destino
    fVL_ICMS_ST: currency;        /// Valor do ICMS referente à substituição tributária
    fIND_APUR: AnsiString;            /// Indicador de período de apuração do IPI: 0 - Mensal; 1 - Decendial
    fCST_IPI: AnsiString;             /// Código da Situação Tributária referente ao IPI, conforme a Tabela indicada no item 4.3.2.
    fCOD_ENQ: AnsiString;             /// Código de enquadramento legal do IPI, conforme tabela indicada no item 4.5.3.
    fVL_BC_IPI: currency;         /// Valor da base de cálculo do IPI
    fALIQ_IPI: currency;          /// Alíquota do IPI
    fVL_IPI: currency;            /// Valor do IPI creditado/debitado
    fCST_PIS: AnsiString;             /// Código da Situação Tributária referente ao PIS.
    fVL_BC_PIS: currency;         /// Valor da base de cálculo do PIS
    fALIQ_PIS_PERC: currency;     /// Alíquota do PIS (em percentual)
    fQUANT_BC_PIS: currency;      /// Quantidade - Base de cálculo PIS
    fALIQ_PIS_R: currency;        /// Alíquota do PIS (em reais)
    fVL_PIS: currency;            /// Valor do PIS
    fCST_COFINS: AnsiString;          /// Código da Situação Tributária referente ao COFINS.
    fVL_BC_COFINS: currency;      /// Valor da base de cálculo da COFINS
    fALIQ_COFINS_PERC: currency;  /// Alíquota do COFINS (em percentual)
    fQUANT_BC_COFINS: currency;   /// Quantidade - Base de cálculo COFINS
    fALIQ_COFINS_R: currency;     /// Alíquota da COFINS (em reais)
    fVL_COFINS: currency;         /// Valor da COFINS
    fCOD_CTA: AnsiString;             /// Código da conta analítica contábil debitada/creditada
  public
    property NUM_ITEM: AnsiString read FNUM_ITEM write FNUM_ITEM;
    property COD_ITEM: AnsiString read FCOD_ITEM write FCOD_ITEM;
    property DESCR_COMPL: AnsiString read FDESCR_COMPL write FDESCR_COMPL;
    property QTD: currency read FQTD write FQTD;
    property UNID: AnsiString read FUNID write FUNID;
    property VL_ITEM: currency read FVL_ITEM write FVL_ITEM;
    property VL_DESC: currency read FVL_DESC write FVL_DESC;
    property IND_MOV: AnsiString read FIND_MOV write FIND_MOV;
    property CST_ICMS: AnsiString read FCST_ICMS write FCST_ICMS;
    property CFOP: AnsiString read FCFOP write FCFOP;
    property COD_NAT: AnsiString read FCOD_NAT write FCOD_NAT;
    property VL_BC_ICMS: currency read FVL_BC_ICMS write FVL_BC_ICMS;
    property ALIQ_ICMS: currency read FALIQ_ICMS write FALIQ_ICMS;
    property VL_ICMS: currency read FVL_ICMS write FVL_ICMS;
    property VL_BC_ICMS_ST: currency read FVL_BC_ICMS_ST write FVL_BC_ICMS_ST;
    property ALIQ_ST: currency read FALIQ_ST write FALIQ_ST;
    property VL_ICMS_ST: currency read FVL_ICMS_ST write FVL_ICMS_ST;
    property IND_APUR: AnsiString read FIND_APUR write FIND_APUR;
    property CST_IPI: AnsiString read FCST_IPI write FCST_IPI;
    property COD_ENQ: AnsiString read FCOD_ENQ write FCOD_ENQ;
    property VL_BC_IPI: currency read FVL_BC_IPI write FVL_BC_IPI;
    property ALIQ_IPI: currency read FALIQ_IPI write FALIQ_IPI;
    property VL_IPI: currency read FVL_IPI write FVL_IPI;
    property CST_PIS: AnsiString read FCST_PIS write FCST_PIS;
    property VL_BC_PIS: currency read FVL_BC_PIS write FVL_BC_PIS;
    property ALIQ_PIS_PERC: currency read FALIQ_PIS_PERC write FALIQ_PIS_PERC;
    property QUANT_BC_PIS: currency read FQUANT_BC_PIS write FQUANT_BC_PIS;
    property ALIQ_PIS_R: currency read FALIQ_PIS_R write FALIQ_PIS_R;
    property VL_PIS: currency read FVL_PIS write FVL_PIS;
    property CST_COFINS: AnsiString read FCST_COFINS write FCST_COFINS;
    property VL_BC_COFINS: currency read FVL_BC_COFINS write FVL_BC_COFINS;
    property ALIQ_COFINS_PERC: currency read FALIQ_COFINS_PERC write FALIQ_COFINS_PERC;
    property QUANT_BC_COFINS: currency read FQUANT_BC_COFINS write FQUANT_BC_COFINS;
    property ALIQ_COFINS_R: currency read FALIQ_COFINS_R write FALIQ_COFINS_R;
    property VL_COFINS: currency read FVL_COFINS write FVL_COFINS;
    property COD_CTA: AnsiString read FCOD_CTA write FCOD_CTA;
  end;

  /// Registro C170 - Lista

  TRegistroC170List = class(TList)
  private
    function GetItem(Index: Integer): TRegistroC170; /// GetItem
    procedure SetItem(Index: Integer; const Value: TRegistroC170); /// SetItem
  public
    destructor Destroy; override;
    function New: TRegistroC170;
    property Items[Index: Integer]: TRegistroC170 read GetItem write SetItem;
  end;

  /// Registro C171 - ARMAZENAMENTO DE COMBUSTIVEIS (código 01, 55)

  TRegistroC171 = class(TPersistent)
  private
    fNUM_TANQUE: AnsiString;    /// Tanque onde foi armazenado o combustível
    fQTDE: currency;        /// Quantidade ou volume armazenado
  public
    property NUM_TANQUE: AnsiString read FNUM_TANQUE write FNUM_TANQUE;
    property QTDE: currency read FQTDE write FQTDE;
  end;

  /// Registro C171 - Lista

  TRegistroC171List = class(TList)
  private
    function GetItem(Index: Integer): TRegistroC171; /// GetItem
    procedure SetItem(Index: Integer; const Value: TRegistroC171); /// SetItem
  public
    destructor Destroy; override;
    function New: TRegistroC171;
    property Items[Index: Integer]: TRegistroC171 read GetItem write SetItem;
  end;

  /// Registro C172 - OPERAÇÕES COM ISSQN (CÓDIGO 01)

  TRegistroC172 = class(TPersistent)
  private
    fVL_BC_ISSQN: currency;    /// Valor da base de cálculo do ISSQN
    fALIQ_ISSQN: currency;     /// Alíquota do ISSQN
    fVL_ISSQN: currency;       /// Valor do ISSQN
  public
    property VL_BC_ISSQN: currency read FVL_BC_ISSQN write FVL_BC_ISSQN;
    property ALIQ_ISSQN: currency read FALIQ_ISSQN write FALIQ_ISSQN;
    property VL_ISSQN: currency read FVL_ISSQN write FVL_ISSQN;
  end;

  /// Registro C172 - Lista

  TRegistroC172List = class(TList)
  private
    function GetItem(Index: Integer): TRegistroC172; /// GetItem
    procedure SetItem(Index: Integer; const Value: TRegistroC172); /// SetItem
  public
    destructor Destroy; override;
    function New: TRegistroC172;
    property Items[Index: Integer]: TRegistroC172 read GetItem write SetItem;
  end;

  /// Registro C173 - OPERAÇÕES COM MEDICAMENTOS (CÓDIGO 01, 55)

  TRegistroC173 = class(TPersistent)
  private
    fLOTE_MED: AnsiString;      /// Número do lote de fabricação do medicamento
    fQTD_ITEM: currency;    /// Quantidade de item por lote
    fDT_FAB: TDateTime;     /// Data de fabricação do medicamento
    fDT_VAL: TDateTime;     /// Data de expiração da validade do medicamento
    fIND_MED: AnsiString;       /// Indicador de tipo de referência da base de cálculo do ICMS (ST) do produto farmacêutico:
    fTP_PROD: AnsiString;       /// Tipo de produto:
    fVL_TAB_MAX: currency;  /// Valor do preço tabelado ou valor do preço máximo
  public
    property LOTE_MED: AnsiString read FLOTE_MED write FLOTE_MED;
    property QTD_ITEM: currency read FQTD_ITEM write FQTD_ITEM;
    property DT_FAB: TDateTime read FDT_FAB write FDT_FAB;
    property DT_VAL: TDateTime read FDT_VAL write FDT_VAL;
    property IND_MED: AnsiString read FIND_MED write FIND_MED;
    property TP_PROD: AnsiString read FTP_PROD write FTP_PROD;
    property VL_TAB_MAX: currency read FVL_TAB_MAX write FVL_TAB_MAX;
  end;

  /// Registro C173 - Lista

  TRegistroC173List = class(TList)
  private
    function GetItem(Index: Integer): TRegistroC173; /// GetItem
    procedure SetItem(Index: Integer; const Value: TRegistroC173); /// SetItem
  public
    destructor Destroy; override;
    function New: TRegistroC173;
    property Items[Index: Integer]: TRegistroC173 read GetItem write SetItem;
  end;

  /// Registro C174 - OPERAÇÕES COM ARMAS DE FOGO (CÓDIGO 01)

  TRegistroC174 = class(TPersistent)
  private
    fIND_ARM: AnsiString;       /// Indicador do tipo da arma de fogo: 0- Uso permitido; 1- Uso restrito
    fNUM_ARM: AnsiString;       /// Numeração de série de fabricação da arma
    fDESCR_COMPL: AnsiString;   /// Descrição da arma, compreendendo: número do cano, calibre, marca, capacidade de cartuchos, tipo de funcionamento, quantidade de canos, comprimento, tipo de alma, quantidade e sentido das raias e demais elementos que permitam sua perfeita identificação
  public
    property IND_ARM: AnsiString read FIND_ARM write FIND_ARM;
    property NUM_ARM: AnsiString read FNUM_ARM write FNUM_ARM;
    property DESCR_COMPL: AnsiString read FDESCR_COMPL write FDESCR_COMPL;
  end;

  /// Registro C174 - Lista

  TRegistroC174List = class(TList)
  private
    function GetItem(Index: Integer): TRegistroC174; /// GetItem
    procedure SetItem(Index: Integer; const Value: TRegistroC174); /// SetItem
  public
    destructor Destroy; override;
    function New: TRegistroC174;
    property Items[Index: Integer]: TRegistroC174 read GetItem write SetItem;
  end;

  /// Registro C175 - OPERAÇÕES COM VEÍCULOS NOVOS (CÓDIGO 01, 55)

  TRegistroC175 = class(TPersistent)
  private
    fIND_VEIC_OPER: AnsiString; /// Indicador do tipo de operação com veículo: 0- Venda para concessionária; 1- Faturamento direto; 2- Venda direta; 3- Venda da concessionária; 9- Outros
    fCNPJ: AnsiString;          /// CNPJ da Concessionária
    fUF: AnsiString;            /// Sigla da unidade da federação da Concessionária
    fCHASSI_VEIC: AnsiString;   /// Chassi do veículo
  public
    property IND_VEIC_OPER: AnsiString read FIND_VEIC_OPER write FIND_VEIC_OPER;
    property CNPJ: AnsiString read FCNPJ write FCNPJ;
    property UF: AnsiString read FUF write FUF;
    property CHASSI_VEIC: AnsiString read FCHASSI_VEIC write FCHASSI_VEIC;
  end;

  /// Registro C175 - Lista

  TRegistroC175List = class(TList)
  private
    function GetItem(Index: Integer): TRegistroC175; /// GetItem
    procedure SetItem(Index: Integer; const Value: TRegistroC175); /// SetItem
  public
    destructor Destroy; override;
    function New: TRegistroC175;
    property Items[Index: Integer]: TRegistroC175 read GetItem write SetItem;
  end;

  /// Registro C176 - RESSARCIMENTO DE ICMS EM OPERAÇÕES COM SUBSTITUIÇÃO TRIBUTÁRIA (CÓDIGO 01,55)

  TRegistroC176 = class(TPersistent)
  private
    fCOD_MOD_ULT_E: AnsiString;    /// Código do modelo do documento fiscal relativa a última entrada
    fNUM_DOC_ULT_E: AnsiString;    /// Número do documento fiscal relativa a última entrada
    fSER_ULT_E: AnsiString;        /// Série do documento fiscal relativa a última entrada
    fDT_ULT_E: TDateTime;      /// Data relativa a última entrada da mercadoria
    fCOD_PART_ULT_E: AnsiString;   /// Código do participante (do emitente do documento relativa a última entrada)
    fQUANT_ULT_E: currency;    /// Quantidade do item relativa a última entrada
    fVL_UNIT_ULT_E: currency;  /// Valor unitário da mercadoria constante na NF relativa a última entrada inclusive despesas acessórias.
    fVL_UNIT_BC_ST: currency;  /// Valor unitário da base de cálculo do imposto pago por substituição.
  public
    property COD_MOD_ULT_E: AnsiString read FCOD_MOD_ULT_E write FCOD_MOD_ULT_E;
    property NUM_DOC_ULT_E: AnsiString read FNUM_DOC_ULT_E write FNUM_DOC_ULT_E;
    property SER_ULT_E: AnsiString read FSER_ULT_E write FSER_ULT_E;
    property DT_ULT_E: TDateTime read FDT_ULT_E write FDT_ULT_E;
    property COD_PART_ULT_E: AnsiString read FCOD_PART_ULT_E write FCOD_PART_ULT_E;
    property QUANT_ULT_E: currency read FQUANT_ULT_E write FQUANT_ULT_E;
    property VL_UNIT_ULT_E: currency read FVL_UNIT_ULT_E write FVL_UNIT_ULT_E;
    property VL_UNIT_BC_ST: currency read FVL_UNIT_BC_ST write FVL_UNIT_BC_ST;
  end;

  /// Registro C176 - Lista

  TRegistroC176List = class(TList)
  private
    function GetItem(Index: Integer): TRegistroC176; /// GetItem
    procedure SetItem(Index: Integer; const Value: TRegistroC176); /// SetItem
  public
    destructor Destroy; override;
    function New: TRegistroC176;
    property Items[Index: Integer]: TRegistroC176 read GetItem write SetItem;
  end;

  /// Registro C177 - OPERAÇÕES COM PRODUTOS SUJEITOS A SELO DE CONTROLE IPI.

  TRegistroC177 = class(TPersistent)
  private
    fCOD_SELO_IPI: AnsiString;  /// Código do selo de controle do IPI, conforme Tabela 4.5.2
    fQT_SELO_IPI: currency; /// Quantidade de selo de controle do IPI aplicada
  public
    property COD_SELO_IPI: AnsiString read FCOD_SELO_IPI write FCOD_SELO_IPI;
    property QT_SELO_IPI: currency read FQT_SELO_IPI write FQT_SELO_IPI;
  end;

  /// Registro C177 - Lista

  TRegistroC177List = class(TList)
  private
    function GetItem(Index: Integer): TRegistroC177; /// GetItem
    procedure SetItem(Index: Integer; const Value: TRegistroC177); /// SetItem
  public
    destructor Destroy; override;
    function New: TRegistroC177;
    property Items[Index: Integer]: TRegistroC177 read GetItem write SetItem;
  end;

  /// Registro C178 - OPERAÇÕES COM PRODUTOS SUJEITOS A TRIBUTAÇÀO DE IPI POR UNIDADE OU QUANTIDADE DE PRODUTO.

  TRegistroC178 = class(TPersistent)
  private
    fCL_ENQ: AnsiString;        /// Código da classe de enquadramento do IPI, conforme Tabela 4.5.1.
    fVL_UNID: currency;     /// Valor por unidade padrão de tributação
    fQUANT_PAD: currency;   /// Quantidade total de produtos na unidade padrão de tributação
  public
    property CL_ENQ: AnsiString read FCL_ENQ write FCL_ENQ;
    property VL_UNID: currency read FVL_UNID write FVL_UNID;
    property QUANT_PAD: currency read FQUANT_PAD write FQUANT_PAD;
  end;

  /// Registro C178 - Lista

  TRegistroC178List = class(TList)
  private
    function GetItem(Index: Integer): TRegistroC178; /// GetItem
    procedure SetItem(Index: Integer; const Value: TRegistroC178); /// SetItem
  public
    destructor Destroy; override;
    function New: TRegistroC178;
    property Items[Index: Integer]: TRegistroC178 read GetItem write SetItem;
  end;

  /// Registro C179 - INFORMAÇÕES COMPLEMENTARES ST (CÓDIGO 01)

  TRegistroC179 = class(TPersistent)
  private
    fBC_ST_ORIG_DEST: currency;   /// Valor da base de cálculo ST na origem/destino em operações interestaduais.
    fICMS_ST_REP: currency;       /// Valor do ICMS-ST a repassar/deduzir em operações interestaduais
    fICMS_ST_COMPL: currency;     /// Valor do ICMS-ST a complementar à UF de destino
    fBC_RET: currency;            /// Valor da BC de retenção em remessa promovida por Substituído intermediário
    fICMS_RET: currency;          /// Valor da parcela do imposto retido em remessa promovida por substituído intermediário
  public
    property BC_ST_ORIG_DEST: currency read FBC_ST_ORIG_DEST write FBC_ST_ORIG_DEST;
    property ICMS_ST_REP: currency read FICMS_ST_REP write FICMS_ST_REP;
    property ICMS_ST_COMPL: currency read FICMS_ST_COMPL write FICMS_ST_COMPL;
    property BC_RET: currency read FBC_RET write FBC_RET;
    property ICMS_RET: currency read FICMS_RET write FICMS_RET;
  end;

  /// Registro C179 - Lista

  TRegistroC179List = class(TList)
  private
    function GetItem(Index: Integer): TRegistroC179; /// GetItem
    procedure SetItem(Index: Integer; const Value: TRegistroC179); /// SetItem
  public
    destructor Destroy; override;
    function New: TRegistroC179;
    property Items[Index: Integer]: TRegistroC179 read GetItem write SetItem;
  end;

  /// Registro C190 - REGISTRO ANALÍTICO DO DOCUMENTO (CÓDIGO 01, 1B, 04 E 55)

  TRegistroC190 = class(TPersistent)
  private
    fCST_ICMS: AnsiString;         /// Código da Situação Tributária, conforme a Tabela indicada no item 4.3.1
    fCFOP: AnsiString;             /// Código Fiscal de Operação e Prestação do agrupamento de itens
    fALIQ_ICMS: currency;      /// Alíquota do ICMS
    fVL_OPR: currency;         /// Valor da operação correspondente à combinação de CST_ICMS, CFOP, e alíquota do ICMS, incluídas as despesas acessórias (frete, seguros e outras despesas acessórias)  e IPI
    fVL_BC_ICMS: currency;     /// Parcela correspondente ao "Valor da base de cálculo do ICMS" referente à combinação de CST_ICMS, CFOP e alíquota do ICMS.
    fVL_ICMS: currency;        /// Parcela correspondente ao "Valor do ICMS" referente à combinação de CST_ICMS, CFOP e alíquota do ICMS.
    fVL_BC_ICMS_ST: currency;  /// Parcela correspondente ao "Valor da base de cálculo do ICMS" da substituição tributária referente à combinação de CST_ICMS, CFOP e alíquota do ICMS.
    fVL_ICMS_ST: currency;     /// Parcela correspondente ao valor creditado/debitado do ICMS da substituição tributária, referente à combinação de CST_ICMS, CFOP, e alíquota do ICMS.
    fVL_RED_BC: currency;      /// Valor não tributado em função da redução da base de cálculo do ICMS, referente à combinação de CST_ICMS, CFOP e alíquota do ICMS.
    fVL_IPI: currency;         /// Parcela correspondente ao "Valor do IPI" referente à combinação CST_ICMS, CFOP e alíquota do ICMS.
    fCOD_OBS: AnsiString;          /// Código da observação do lançamento fiscal (campo 02 do Registro 0460
  public
    property CST_ICMS: AnsiString read FCST_ICMS write FCST_ICMS;
    property CFOP: AnsiString read FCFOP write FCFOP;
    property ALIQ_ICMS: currency read FALIQ_ICMS write FALIQ_ICMS;
    property VL_OPR: currency read FVL_OPR write FVL_OPR;
    property VL_BC_ICMS: currency read FVL_BC_ICMS write FVL_BC_ICMS;
    property VL_ICMS: currency read FVL_ICMS write FVL_ICMS;
    property VL_BC_ICMS_ST: currency read FVL_BC_ICMS_ST write FVL_BC_ICMS_ST;
    property VL_ICMS_ST: currency read FVL_ICMS_ST write FVL_ICMS_ST;
    property VL_RED_BC: currency read FVL_RED_BC write FVL_RED_BC;
    property VL_IPI: currency read FVL_IPI write FVL_IPI;
    property COD_OBS: AnsiString read FCOD_OBS write FCOD_OBS;

  end;

  /// Registro C190 - Lista

  TRegistroC190List = class(TList)
  private
    function GetItem(Index: Integer): TRegistroC190; /// GetItem
    procedure SetItem(Index: Integer; const Value: TRegistroC190); /// SetItem
  public
    destructor Destroy; override;
    function New: TRegistroC190;
    property Items[Index: Integer]: TRegistroC190 read GetItem write SetItem;
  end;

  /// Registro C195 - OBSERVAÇOES DO LANÇAMENTO FISCAL (CÓDIGO 01, 1B E 55)

  TRegistroC195 = class(TPersistent)
  private
    fCOD_OBS: AnsiString;    /// Código da observação do lançamento fiscal (campo 02 do Registro 0460)
    fTXT_COMPL: AnsiString;  /// Descrição complementar do código de observação.
  public
    property COD_OBS: AnsiString read FCOD_OBS write FCOD_OBS;
    property TXT_COMPL: AnsiString read FTXT_COMPL write FTXT_COMPL;
  end;

  /// Registro C195 - Lista

  TRegistroC195List = class(TList)
  private
    function GetItem(Index: Integer): TRegistroC195; /// GetItem
    procedure SetItem(Index: Integer; const Value: TRegistroC195); /// SetItem
  public
    destructor Destroy; override;
    function New: TRegistroC195;
    property Items[Index: Integer]: TRegistroC195 read GetItem write SetItem;
  end;

  /// Registro C197 - OUTRAS OBRIGAÇÕES TRIBUTÁRIAS, AJUSTES E INFORMAÇÕES DE VALORES PROVENIENTES DE DOCUMENTO FISCAL.

  TRegistroC197 = class(TPersistent)
  private
    fCOD_AJ: AnsiString;           /// Código do ajustes/benefício/incentivo, conforme tabela indicada no item 5.3.
    fDESCR_COMPL_AJ: AnsiString;   /// Descrição complementar do ajuste da apuração, nos casos em que o código da tabela for “9999”
    fCOD_ITEM: AnsiString;         /// Código do item (campo 02 do Registro 0200)
    fVL_BC_ICMS: currency;     /// Base de cálculo do ICMS ou do ICMS ST
    fALIQ_ICMS: currency;      /// Alíquota do ICMS
    fVL_ICMS: currency;        /// Valor do ICMS ou do ICMS ST
    fVL_OUTROS: currency;      /// Outros valores
  public
    property COD_AJ: AnsiString read FCOD_AJ write FCOD_AJ;
    property DESCR_COMPL_AJ: AnsiString read FDESCR_COMPL_AJ write FDESCR_COMPL_AJ;
    property COD_ITEM: AnsiString read FCOD_ITEM write FCOD_ITEM;
    property VL_BC_ICMS: currency read FVL_BC_ICMS write FVL_BC_ICMS;
    property ALIQ_ICMS: currency read FALIQ_ICMS write FALIQ_ICMS;
    property VL_ICMS: currency read FVL_ICMS write FVL_ICMS;
    property VL_OUTROS: currency read FVL_OUTROS write FVL_OUTROS;
  end;

  /// Registro C197 - Lista

  TRegistroC197List = class(TList)
  private
    function GetItem(Index: Integer): TRegistroC197; /// GetItem
    procedure SetItem(Index: Integer; const Value: TRegistroC197); /// SetItem
  public
    destructor Destroy; override;
    function New: TRegistroC197;
    property Items[Index: Integer]: TRegistroC197 read GetItem write SetItem;
  end;

  /// Registro C300 - RESUMO DIÁRIO DAS NOTAS FISCAIS DE VENDA A CONSUMIDOR (CÓDIGO 02)

  TRegistroC300 = class(TPersistent)
  private
    fCOD_MOD: AnsiString; /// Código do modelo do documento fiscal, conforme a Tabela 4.1.1
    fSER: AnsiString; /// Série do documento fiscal
    fSUB: AnsiString; /// Subsérie do documento fiscal
    fNUM_DOC_INI: AnsiString; /// Número do documento fiscal inicial
    fNUM_DOC_FIN: AnsiString; /// Número do documento fiscal final
    fDT_DOC: TDateTime; /// Data da emissão dos documentos fiscais
    fVL_DOC: currency; /// Valor total dos documentos
    fVL_PIS: currency; /// Valor total do PIS
    fVL_COFINS: currency; /// Valor total da COFINS
    fCOD_CTA: AnsiString; /// Código da conta analítica contábil debitada/creditada
  public
    property COD_MOD: AnsiString read fCOD_MOD write fCOD_MOD;
    property SER: AnsiString read fSER write fSER;
    property SUB: AnsiString read fSUB write fSUB;
    property NUM_DOC_INI: AnsiString read fNUM_DOC_INI write fNUM_DOC_INI;
    property NUM_DOC_FIN: AnsiString read fNUM_DOC_FIN write fNUM_DOC_FIN;
    property DT_DOC: TDateTime read fDT_DOC write fDT_DOC;
    property VL_DOC: currency read fVL_DOC write fVL_DOC;
    property VL_PIS: currency read fVL_PIS write fVL_PIS;
    property VL_COFINS: currency read fVL_COFINS write fVL_COFINS;
    property COD_CTA: AnsiString read fCOD_CTA write fCOD_CTA;
  end;

  /// Registro C300 - Lista

  TRegistroC300List = class(TList)
  private
    function GetItem(Index: Integer): TRegistroC300; /// GetItem
    procedure SetItem(Index: Integer; const Value: TRegistroC300); /// SetItem
  public
    destructor Destroy; override;
    function New: TRegistroC300;
    property Items[Index: Integer]: TRegistroC300 read GetItem write SetItem;
  end;

  /// Registro C310 - DOCUMENTOS CANCELADOS DE NOTAS FISCAIS DE VENDA A CONSUMIDOR (CÓDIGO 02)

  TRegistroC310 = class(TPersistent)
  private
    fNUM_DOC_CANC: AnsiString; /// Número do documento fiscal cancelado
  public
    property NUM_DOC_CANC: AnsiString read fNUM_DOC_CANC write fNUM_DOC_CANC;
  end;

  /// Registro C310 - Lista

  TRegistroC310List = class(TList)
  private
    function GetItem(Index: Integer): TRegistroC310; /// GetItem
    procedure SetItem(Index: Integer; const Value: TRegistroC310); /// SetItem
  public
    destructor Destroy; override;
    function New: TRegistroC310;
    property Items[Index: Integer]: TRegistroC310 read GetItem write SetItem;
  end;

  /// Registro C320 - REGISTRO ANALÍTICO DO RESUMO DIÁRIO DAS NOTAS FISCAIS DE VENDA A CONSUMIDOR (CÓDIGO 02)

  TRegistroC320 = class(TPersistent)
  private
    fCST_ICMS: AnsiString;     /// Código da Situação Tributária, conforme a Tabela indicada no item 4.3.1
    fCFOP: AnsiString;         /// Código Fiscal de Operação e Prestação
    fALIQ_ICMS: Currency;  /// Alíquota do ICMS
    fVL_OPR: currency;     /// Valor total acumulado das operações correspondentes à combinação de CST_ICMS, CFOP e alíquota do ICMS, incluídas as despesas acessórias e acréscimos.
    fVL_BC_ICMS: currency; /// Valor acumulado da base de cálculo do ICMS, referente à combinação de CST_ICMS, CFOP, e alíquota do ICMS.
    fVL_ICMS: currency;    /// Valor acumulado do ICMS, referente à combinação de CST_ICMS, CFOP e alíquota do ICMS.
    fVL_RED_BC: currency;  /// Valor não tributado em função da redução da base de cálculo do ICMS, referente à combinação de CST_ICMS, CFOP, e alíquota do ICMS.
    fCOD_OBS: AnsiString;      /// Código da observação do lançamento fiscal (campo 02 do Registro 0460)
  public
    property CST_ICMS: AnsiString read fCST_ICMS write fCST_ICMS;
    property CFOP: AnsiString read fCFOP write fCFOP;
    property ALIQ_ICMS: Currency read fALIQ_ICMS write fALIQ_ICMS;
    property VL_OPR: currency read fVL_OPR write fVL_OPR;
    property VL_BC_ICMS: currency read fVL_BC_ICMS write fVL_BC_ICMS;
    property VL_ICMS: currency read fVL_ICMS write fVL_ICMS;
    property VL_RED_BC: currency read fVL_RED_BC write fVL_RED_BC;
    property COD_OBS: AnsiString read fCOD_OBS write fCOD_OBS;
  end;

  /// Registro C320 - Lista

  TRegistroC320List = class(TList)
  private
    function GetItem(Index: Integer): TRegistroC320; /// GetItem
    procedure SetItem(Index: Integer; const Value: TRegistroC320); /// SetItem
  public
    destructor Destroy; override;
    function New: TRegistroC320;
    property Items[Index: Integer]: TRegistroC320 read GetItem write SetItem;
  end;

  /// Registro C321 - ITENS DO RESUMO DIÁRIO DOS DOCUMENTOS (CÓDIGO 02)

  TRegistroC321 = class(TPersistent)
  private
    fCOD_ITEM: AnsiString;         /// Código do item (campo 02 do Registro 0200)
    fQTD: currency;            /// Quantidade acumulada do item
    fUNID: AnsiString;             /// Unidade do item (Campo 02 do registro 0190)
    fVL_ITEM: currency;        /// Valor acumulado do item
    fVL_DESC: currency;        /// Valor do desconto acumulado
    fVL_BC_ICMS: currency;     /// Valor acumulado da base de cálculo do ICMS
    fVL_ICMS: currency;        /// Valor acumulado do ICMS debitado
    fVL_PIS: currency;         /// Valor acumulado do PIS
    fVL_COFINS: currency;      /// Valor acumulado da COFINS
  public
    property COD_ITEM: AnsiString read FCOD_ITEM write FCOD_ITEM;
    property QTD: currency read FQTD write FQTD;
    property UNID: AnsiString read FUNID write FUNID;
    property VL_ITEM: currency read FVL_ITEM write FVL_ITEM;
    property VL_DESC: currency read FVL_DESC write FVL_DESC;
    property VL_BC_ICMS: currency read FVL_BC_ICMS write FVL_BC_ICMS;
    property VL_ICMS: currency read FVL_ICMS write FVL_ICMS;
    property VL_PIS: currency read FVL_PIS write FVL_PIS;
    property VL_COFINS: currency read FVL_COFINS write FVL_COFINS;
  end;

  /// Registro C321 - Lista

  TRegistroC321List = class(TList)
  private
    function GetItem(Index: Integer): TRegistroC321; /// GetItem
    procedure SetItem(Index: Integer; const Value: TRegistroC321); /// SetItem
  public
    destructor Destroy; override;
    function New: TRegistroC321;
    property Items[Index: Integer]: TRegistroC321 read GetItem write SetItem;
  end;

  /// Registro C350 - NOTA FISCAL DE VENDA A CONSUMIDOR (CÓDIGO 02)

  TRegistroC350 = class(TPersistent)
  private
    fSER: AnsiString;           /// Série do documento fiscal
    fSUB_SER: AnsiString;       /// Subsérie do documento fiscal
    fNUM_DOC: AnsiString;       /// Número do documento fiscal
    fDT_DOC: TDateTime;     /// Data da emissão do documento fiscal
    fCNPJ_CPF: AnsiString;      /// CNPJ ou CPF do destinatário
    fVL_MERC: currency;     /// Valor das mercadorias constantes no documento fiscal
    fVL_DOC: currency;      /// Valor total do documento fiscal
    fVL_DESC: currency;     /// Valor total do desconto
    fVL_PIS: currency;      /// Valor total do PIS
    fVL_COFINS: currency;   /// Valor total da COFINS
    fCOD_CTA: AnsiString;       /// Código da conta analítica contábil debitada/creditada
  public
    property SER: AnsiString read FSER write FSER;
    property SUB_SER: AnsiString read FSUB_SER write FSUB_SER;
    property NUM_DOC: AnsiString read FNUM_DOC write FNUM_DOC;
    property DT_DOC: TDateTime read FDT_DOC write FDT_DOC;
    property CNPJ_CPF: AnsiString read FCNPJ_CPF write FCNPJ_CPF;
    property VL_MERC: currency read FVL_MERC write FVL_MERC;
    property VL_DOC: currency read FVL_DOC write FVL_DOC;
    property VL_DESC: currency read FVL_DESC write FVL_DESC;
    property VL_PIS: currency read FVL_PIS write FVL_PIS;
    property VL_COFINS: currency read FVL_COFINS write FVL_COFINS;
    property COD_CTA: AnsiString read FCOD_CTA write FCOD_CTA;
  end;

  /// Registro C350 - Lista

  TRegistroC350List = class(TList)
  private
    function GetItem(Index: Integer): TRegistroC350; /// GetItem
    procedure SetItem(Index: Integer; const Value: TRegistroC350); /// SetItem
  public
    destructor Destroy; override;
    function New: TRegistroC350;
    property Items[Index: Integer]: TRegistroC350 read GetItem write SetItem;
  end;

  /// Registro C370 - ITENS DO DOCUMENTO (CÓDIGO 02)

  TRegistroC370 = class(TPersistent)
  private
    fNUM_ITEM: AnsiString;      /// Número seqüencial do item no documento fiscal
    fCOD_ITEM: AnsiString;      /// Código do Item (campo 02 do registro 0200)
    fQTD: currency;         /// Quantidade do item
    fUNID: AnsiString;          /// Unidade do item (campo 02 do registro 0190)
    fVL_ITEM: currency;     /// Valor total do item
    fVL_DESC: currency;     /// Valor total do desconto no item
  public
    property NUM_ITEM: AnsiString read FNUM_ITEM write FNUM_ITEM;
    property COD_ITEM: AnsiString read FCOD_ITEM write FCOD_ITEM;
    property QTD: currency read FQTD write FQTD;
    property UNID: AnsiString read FUNID write FUNID;
    property VL_ITEM: currency read FVL_ITEM write FVL_ITEM;
    property VL_DESC: currency read FVL_DESC write FVL_DESC;
  end;

  /// Registro C370 - Lista

  TRegistroC370List = class(TList)
  private
    function GetItem(Index: Integer): TRegistroC370; /// GetItem
    procedure SetItem(Index: Integer; const Value: TRegistroC370); /// SetItem
  public
    destructor Destroy; override;
    function New: TRegistroC370;
    property Items[Index: Integer]: TRegistroC370 read GetItem write SetItem;
  end;

  /// Registro C390 - REGISTRO ANALÍTICO DAS NOTAS FISCAIS DE VENDA A CONSUMIDOR (CÓDIGO 02)

  TRegistroC390 = class(TPersistent)
  private
    fCST_ICMS: AnsiString;         /// Código da Situação Tributária, conforme a Tabela indicada no item 4.3.1
    fCFOP: AnsiString;             /// Código Fiscal de Operação e Prestação
    fALIQ_ICMS: currency;      /// Alíquota do ICMS
    fVL_OPR: currency;         /// Valor total acumulado das operações correspondentes à combinação de CST_ICMS, CFOP e alíquota do ICMS, incluídas as despesas acessórias e acréscimos.
    fVL_BC_ICMS: currency;     /// Valor acumulado da base de cálculo do ICMS, referente à combinação de CST_ICMS, CFOP, e alíquota do ICMS.
    fVL_ICMS: currency;        /// Valor acumulado do ICMS, referente à combinação de CST_ICMS, CFOP e alíquota do ICMS.
    fVL_RED_BC: currency;      /// Valor não tributado em função da redução da base de cálculo do ICMS, referente à combinação de CST_ICMS, CFOP, e alíquota do ICMS.
    fCOD_OBS: AnsiString;          /// Código da observação do lançamento fiscal (campo 02 do Registro 0460)
  public
    property CST_ICMS: AnsiString read FCST_ICMS write FCST_ICMS;
    property CFOP: AnsiString read FCFOP write FCFOP;
    property ALIQ_ICMS: currency read FALIQ_ICMS write FALIQ_ICMS;
    property VL_OPR: currency read FVL_OPR write FVL_OPR;
    property VL_BC_ICMS: currency read FVL_BC_ICMS write FVL_BC_ICMS;
    property VL_ICMS: currency read FVL_ICMS write FVL_ICMS;
    property VL_RED_BC: currency read FVL_RED_BC write FVL_RED_BC;
    property COD_OBS: AnsiString read FCOD_OBS write FCOD_OBS;
  end;

  /// Registro C390 - Lista

  TRegistroC390List = class(TList)
  private
    function GetItem(Index: Integer): TRegistroC390; /// GetItem
    procedure SetItem(Index: Integer; const Value: TRegistroC390); /// SetItem
  public
    destructor Destroy; override;
    function New: TRegistroC390;
    property Items[Index: Integer]: TRegistroC390 read GetItem write SetItem;
  end;

  /// Registro C400 - EQUIPAMENTO ECF (CÓDIGO 02 E 2D)

  TRegistroC400 = class(TPersistent)
  private
    fCOD_MOD: AnsiString; /// Código do modelo do documento fiscal, conforme a Tabela 4.1.1
    fECF_MOD: AnsiString; /// Modelo do equipamento
    fECF_FAB: AnsiString; /// Número de série de fabricação do ECF
    fECF_CX: AnsiString;  /// Número do caixa atribuído ao ECF
  public
    property COD_MOD: AnsiString read fCOD_MOD write fCOD_MOD;
    property ECF_MOD: AnsiString read fECF_MOD write fECF_MOD;
    property ECF_FAB: AnsiString read fECF_FAB write fECF_FAB;
    property ECF_CX: AnsiString read fECF_CX write fECF_CX;
  end;

  /// Registro C400 - Lista

  TRegistroC400List = class(TList)
  private
    function GetItem(Index: Integer): TRegistroC400; /// GetItem
    procedure SetItem(Index: Integer; const Value: TRegistroC400); /// SetItem
  public
    destructor Destroy; override;
    function New: TRegistroC400;
    property Items[Index: Integer]: TRegistroC400 read GetItem write SetItem;
  end;

  /// Registro C405 - REDUÇÃO Z (CÓDIGO 02 E 2D)

  TRegistroC405 = class(TPersistent)
  private
    fDT_DOC: TDateTime;       /// Data do movimento a que se refere a Redução Z
    fCRO: integer;            /// Posição do Contador de Reinício de Operação
    fCRZ: integer;            /// Posição do Contador de Redução Z
    fNUM_COO_FIN: integer;    /// Número do Contador de Ordem de Operação do último documento emitido no dia. (Número do COO na Redução Z)
    fGT_FIN: currency;        /// Valor do Grande Total final
    fVL_BRT: currency;        /// Valor da venda bruta
  public
    property DT_DOC: TDateTime read fDT_DOC write fDT_DOC;
    property CRO: integer read fCRO write fCRO;
    property CRZ: integer read fCRZ write fCRZ;
    property NUM_COO_FIN: integer read fNUM_COO_FIN write fNUM_COO_FIN;
    property GT_FIN: currency read fGT_FIN write fGT_FIN;
    property VL_BRT: currency read fVL_BRT write fVL_BRT;
  end;

  /// Registro C405 - Lista

  TRegistroC405List = class(TList)
  private
    function GetItem(Index: Integer): TRegistroC405; /// GetItem
    procedure SetItem(Index: Integer; const Value: TRegistroC405); /// SetItem
  public
    destructor Destroy; override;
    function New: TRegistroC405;
    property Items[Index: Integer]: TRegistroC405 read GetItem write SetItem;
  end;

  /// Registro C410 - PIS E COFINS TOTALIZADOS NO DIA (CÓDIGO 02 E 2D)

  TRegistroC410 = class(TPersistent)
  private
    fVL_PIS: currency;      /// 'Valor total do PIS
    fVL_COFINS: currency;   /// 'Valor total da COFINS
  public
    property VL_PIS: currency read FVL_PIS write FVL_PIS;
    property VL_COFINS: currency read FVL_COFINS write FVL_COFINS;
  end;

  /// Registro C410 - Lista

  TRegistroC410List = class(TList)
  private
    function GetItem(Index: Integer): TRegistroC410; /// GetItem
    procedure SetItem(Index: Integer; const Value: TRegistroC410); /// SetItem
  public
    destructor Destroy; override;
    function New: TRegistroC410;
    property Items[Index: Integer]: TRegistroC410 read GetItem write SetItem;
  end;

  /// Registro C420 - REGISTRO DOS TOTALIZADORES PARCIAIS DA REDUÇÃO Z (COD 02 E 2D)

  TRegistroC420 = class(TPersistent)
  private
    fCOD_TOT_PAR: AnsiString;     /// Código do totalizador, conforme Tabela 4.4.6
    fVLR_ACUM_TOT: currency;  /// Valor acumulado no totalizador, relativo à respectiva Redução Z.
    fNR_TOT: integer;         /// Número do totalizador quando ocorrer mais de uma situação com a mesma carga tributária efetiva.
    fDESCR_NR_TOT: AnsiString;    /// Descrição da situação tributária relativa ao totalizador parcial, quando houver mais de um com a mesma carga tributária efetiva.
  public
    property COD_TOT_PAR: AnsiString read fCOD_TOT_PAR write fCOD_TOT_PAR;
    property VLR_ACUM_TOT: currency read fVLR_ACUM_TOT write fVLR_ACUM_TOT;
    property NR_TOT: integer read fNR_TOT write fNR_TOT;
    property DESCR_NR_TOT: AnsiString read fDESCR_NR_TOT write fDESCR_NR_TOT;
  end;

  /// Registro C420 - Lista

  TRegistroC420List = class(TList)
  private
    function GetItem(Index: Integer): TRegistroC420; /// GetItem
    procedure SetItem(Index: Integer; const Value: TRegistroC420); /// SetItem
  public
    destructor Destroy; override;
    function New: TRegistroC420;
    property Items[Index: Integer]: TRegistroC420 read GetItem write SetItem;
  end;

  /// Registro C425 - RESUMO DE ITENS DO MOVIMENTO DIÁRIO (CÓDIGO 02 E 2D)

  TRegistroC425 = class(TPersistent)
  private
    fCOD_ITEM: AnsiString;           /// Código do item (campo 02 do Registro 0200):
    fQTD: currency;              /// Quantidade acumulada do item:
    fUNID: AnsiString;               /// Unidade do item (Campo 02 do registro 0190)
    fVL_ITEM: currency;          /// Valor acumulado do item:
    fVL_PIS: currency;           /// Valor do PIS
    fVL_COFINS: currency;        /// Valor da COFINS
  public
    property COD_ITEM: AnsiString read FCOD_ITEM write FCOD_ITEM;
    property QTD: currency read FQTD write FQTD;
    property UNID: AnsiString read FUNID write FUNID;
    property VL_ITEM: currency read FVL_ITEM write FVL_ITEM;
    property VL_PIS: currency read fVL_PIS write fVL_PIS;
    property VL_COFINS: currency read fVL_COFINS write fVL_COFINS;
  end;

  /// Registro C425 - Lista

  TRegistroC425List = class(TList)
  private
    function GetItem(Index: Integer): TRegistroC425; /// GetItem
    procedure SetItem(Index: Integer; const Value: TRegistroC425); /// SetItem
  public
    destructor Destroy; override;
    function New: TRegistroC425;
    property Items[Index: Integer]: TRegistroC425 read GetItem write SetItem;
  end;

  /// Registro C460 - DOCUMENTO FISCAL EMITIDO POR ECF (CÓDIGO 02 E 2D)

  TRegistroC460 = class(TPersistent)
  private
    fCOD_MOD: AnsiString;   /// Código do modelo do documento fiscal, conforme a Tabela 4.1.1
    fCOD_SIT: AnsiString;   /// Código da situação do documento fiscal, conforme a Tabela 4.1.2
    fNUM_DOC: AnsiString;   /// Número do documento fiscal (COO)
    fDT_DOC: TDateTime;    /// Data da emissão do documento fiscal
    fVL_DOC: currency;     /// Valor total do documento fiscal
    fVL_PIS: currency;     /// Valor do PIS
    fVL_COFINS: currency;  /// Valor da COFINS
    fCPF_CNPJ: AnsiString;     /// CPF ou CNPJ do adquirente
    fNOM_ADQ: AnsiString;      /// Nome do adquirente
  public
    property COD_MOD: AnsiString read fCOD_MOD write fCOD_MOD;
    property COD_SIT: AnsiString read fCOD_SIT write fCOD_SIT;
    property NUM_DOC: AnsiString read fNUM_DOC write fNUM_DOC;
    property DT_DOC: TDateTime read fDT_DOC write fDT_DOC;
    property VL_DOC: currency read fVL_DOC write fVL_DOC;
    property VL_PIS: currency read fVL_PIS write fVL_PIS;
    property VL_COFINS: currency read fVL_COFINS write fVL_COFINS;
    property CPF_CNPJ: AnsiString read fCPF_CNPJ write fCPF_CNPJ;
    property NOM_ADQ: AnsiString read fNOM_ADQ write fNOM_ADQ;
  end;

  /// Registro C460 - Lista

  TRegistroC460List = class(TList)
  private
    function GetItem(Index: Integer): TRegistroC460; /// GetItem
    procedure SetItem(Index: Integer; const Value: TRegistroC460); /// SetItem
  public
    destructor Destroy; override;
    function New: TRegistroC460;
    property Items[Index: Integer]: TRegistroC460 read GetItem write SetItem;
  end;

  /// Registro C470 - ITENS DO DOCUMENTO FISCAL EMITIDO POR ECF (CÓDIGO 02 E 2D)

  TRegistroC470 = class(TPersistent)
  private
    fCOD_ITEM: AnsiString;           /// Código do item (campo 02 do Registro 0200):
    fQTD: currency;              /// Quantidade do item
    fQTD_CANC: currency;         /// Quantidade cancelada, no caso de cancelamento parcial de item
    fUNID: AnsiString;               /// Unidade do item (Campo 02 do registro 0190)
    fVL_ITEM: currency;          /// Valor do item:
    fCST_ICMS: AnsiString;           /// Código da Situação Tributária, conforme a Tabela indicada no item 4.3.1.
    fCFOP: AnsiString;               /// Código Fiscal de Operação e Prestação
    fALIQ_ICMS: Currency;        /// Alíquota do ICMS - Carga tributária efetiva em percentual
    fVL_PIS: currency;           /// Valor do PIS
    fVL_COFINS: currency;        /// Valor da COFINS
  public
    property COD_ITEM: AnsiString read FCOD_ITEM write FCOD_ITEM;
    property QTD: currency read FQTD write FQTD;
    property QTD_CANC: currency read FQTD_CANC write FQTD_CANC;
    property UNID: AnsiString read FUNID write FUNID;
    property VL_ITEM: currency read FVL_ITEM write FVL_ITEM;
    property CST_ICMS: AnsiString read fCST_ICMS write fCST_ICMS;
    property CFOP: AnsiString read fCFOP write fCFOP;
    property ALIQ_ICMS: Currency read fALIQ_ICMS write fALIQ_ICMS;
    property VL_PIS: currency read fVL_PIS write fVL_PIS;
    property VL_COFINS: currency read fVL_COFINS write fVL_COFINS;
  end;

  /// Registro C470 - Lista

  TRegistroC470List = class(TList)
  private
    function GetItem(Index: Integer): TRegistroC470; /// GetItem
    procedure SetItem(Index: Integer; const Value: TRegistroC470); /// SetItem
  public
    destructor Destroy; override;
    function New: TRegistroC470;
    property Items[Index: Integer]: TRegistroC470 read GetItem write SetItem;
  end;

  /// Registro C490 - REGISTRO ANALÍTICO DO MOVIMENTO DIÁRIO (CÓDIGO 02 E 2D)

  TRegistroC490 = class(TPersistent)
  private
    fCST_ICMS: AnsiString;         /// Código da Situação Tributária, conforme a Tabela indicada no item 4.3.1
    fCFOP: AnsiString;             /// Código Fiscal de Operação e Prestação
    fALIQ_ICMS: currency;      /// Alíquota do ICMS
    fVL_OPR: currency;         /// Valor da operação correspondente à combinação de CST_ICMS, CFOP, e alíquota do ICMS, incluídas as despesas acessórias e acréscimos
    fVL_BC_ICMS: currency;     /// Valor acumulado da base de cálculo do ICMS, referente à combinação de CST_ICMS, CFOP, e alíquota do ICMS.
    fVL_ICMS: currency;        /// Valor acumulado do ICMS, referente à combinação de CST_ICMS, CFOP e alíquota do ICMS.
    fCOD_OBS: AnsiString;          /// Código da observação do lançamento fiscal (campo 02 do Registro 0460)
  public
    property CST_ICMS: AnsiString read FCST_ICMS write FCST_ICMS;
    property CFOP: AnsiString read FCFOP write FCFOP;
    property ALIQ_ICMS: currency read FALIQ_ICMS write FALIQ_ICMS;
    property VL_OPR: currency read FVL_OPR write FVL_OPR;
    property VL_BC_ICMS: currency read FVL_BC_ICMS write FVL_BC_ICMS;
    property VL_ICMS: currency read FVL_ICMS write FVL_ICMS;
    property COD_OBS: AnsiString read FCOD_OBS write FCOD_OBS;
  end;

  /// Registro C490 - Lista

  TRegistroC490List = class(TList)
  private
    function GetItem(Index: Integer): TRegistroC490; /// GetItem
    procedure SetItem(Index: Integer; const Value: TRegistroC490); /// SetItem
  public
    destructor Destroy; override;
    function New: TRegistroC490;
    property Items[Index: Integer]: TRegistroC490 read GetItem write SetItem;
  end;

  /// Registro C495 - RESUMO MENSAL DE ITENS DO ECF POR ESTABELECIMENTO (CÓDIGO 02, 2D)

  TRegistroC495 = class(TPersistent)
  private
    fALIQ_ICMS: currency;      /// Alíquota do ICMS
    fCOD_ITEM: AnsiString;         /// Código do item (campo 02 do Registro 0200)
    fQTD: currency;            /// Quantidade acumulada do item
    fQTD_CANC: currency;       /// Quantidade cancelada acumulada, no caso de cancelamento parcial de item
    fUNID: AnsiString;             /// Unidade do item (Campo 02 do registro 0190)
    fVL_ITEM: currency;        /// Valor acumulado do item
    fVL_DESC: currency;        /// Valor acumulado dos descontos
    fVL_CANC: currency;        /// Valor acumulado dos cancelamentos
    fVL_ACMO: currency;        /// Valor acumulado dos acréscimos
    fVL_BC_ICMS: currency;     /// Valor acumulado da base de cálculo do ICMS
    fVL_ICMS: currency;        /// Valor acumulado do ICMS
    fVL_ISEN: currency;        /// Valor das saídas isentas do ICMS
    fVL_NT: currency;          /// Valor das saídas sob não-incidência ou não-tributadas pelo ICMS
    fVL_ICMS_ST: currency;     /// Valor das saídas de mercadorias adquiridas com substituição tributária do ICMS
  public
    property ALIQ_ICMS: currency read FALIQ_ICMS write FALIQ_ICMS;
    property COD_ITEM: AnsiString read FCOD_ITEM write FCOD_ITEM;
    property QTD: currency read FQTD write FQTD;
    property QTD_CANC: currency read FQTD_CANC write FQTD_CANC;
    property UNID: AnsiString read FUNID write FUNID;
    property VL_ITEM: currency read FVL_ITEM write FVL_ITEM;
    property VL_DESC: currency read FVL_DESC write FVL_DESC;
    property VL_CANC: currency read FVL_CANC write FVL_CANC;
    property VL_ACMO: currency read FVL_ACMO write FVL_ACMO;
    property VL_BC_ICMS: currency read FVL_BC_ICMS write FVL_BC_ICMS;
    property VL_ICMS: currency read FVL_ICMS write FVL_ICMS;
    property VL_ISEN: currency read FVL_ISEN write FVL_ISEN;
    property VL_NT: currency read FVL_NT write FVL_NT;
    property VL_ICMS_ST: currency read FVL_ICMS_ST write FVL_ICMS_ST;
  end;

  /// Registro C495 - Lista

  TRegistroC495List = class(TList)
  private
    function GetItem(Index: Integer): TRegistroC495; /// GetItem
    procedure SetItem(Index: Integer; const Value: TRegistroC495); /// SetItem
  public
    destructor Destroy; override;
    function New: TRegistroC495;
    property Items[Index: Integer]: TRegistroC495 read GetItem write SetItem;
  end;

  /// Registro C500 - NOTA FISCAL/CONTA DE ENERGIA ELÉTRICA (CÓDIGO 06) E NOTA FISCAL CONSUMO FORNECIMENTO DE GÁS (CÓDIGO 28)

  TRegistroC500 = class(TPersistent)
  private
    fIND_OPER: AnsiString;     /// Indicador do tipo de operação: 0 - Entrada; 1- Saída
    fIND_EMIT: AnsiString;     /// Indicador do emitente do documento fiscal: 0- Emissão própria; 1- Terceiros
    fCOD_PART: AnsiString;     /// Código do participante (campo 02 do Registro 0150): - do adquirente, no caso das saídas; - do fornecedor no caso de entradas
    fCOD_MOD: AnsiString;      /// Código do modelo do documento fiscal, conforme a Tabela 4.1.1
    fCOD_SIT: AnsiString;      /// Código da situação do documento fiscal, conforme a Tabela 4.1.2
    fSER: AnsiString;          /// Série do documento fiscal
    fSUB: AnsiString;          /// Subsérie do documento fiscal
    fCOD_CONS: AnsiString;     /// Código de classe de consumo de energia elétrica, conforme a Tabela 4.4.5 ou Código da classe de consumo de gás canalizado conforme Tabela 4.4.3.
    fNUM_DOC: AnsiString;      /// Número do documento fiscal
    fDT_DOC: TDateTime;    /// Data da emissão do documento fiscal
    fDT_E_S: TDateTime;    /// Data da entrada ou da saída
    fVL_DOC: currency;     /// Valor total do documento fiscal
    fVL_DESC: currency;    /// Valor total do desconto
    fVL_FORN: currency;    /// Valor total fornecido/consumido
    fVL_SERV_NT: currency;    /// Valor total dos serviços não-tributados pelo ICMS
    fVL_TERC: currency;    /// Valor total cobrado em nome de terceiros
    fVL_DA: currency;      /// Valor total de despesas acessórias indicadas no documento fiscal
    fVL_BC_ICMS: currency;    /// Valor acumulado da base de cálculo do ICMS
    fVL_ICMS: currency;    /// Valor acumulado do ICMS
    fVL_BC_ICMS_ST: currency;    /// Valor acumulado da base de cálculo do ICMS substituição tributária
    fVL_ICMS_ST: currency;    /// Valor acumulado do ICMS retido por substituição tributária
    fCOD_INF: AnsiString;         /// Código da informação complementar do documento fiscal (campo 02 do Registro 0450)
    fVL_PIS: currency;        /// Valor do PIS
    fVL_COFINS: currency;     /// Valor da COFINS
    fTP_LIGACAO      :AnsiString; /// Código de tipo de Ligação [ 1 - Monofásico 2 - Bifásico 3 - Trifásico ]
    fCOD_GRUPO_TENSAO:AnsiString; /// Código de grupo de tensão: Vide Manual Registro C500 Campo 27
  public
    property IND_OPER: AnsiString read fIND_OPER write fIND_OPER;
    property IND_EMIT: AnsiString read fIND_EMIT write fIND_EMIT;
    property COD_PART: AnsiString read fCOD_PART write fCOD_PART;
    property COD_MOD: AnsiString read fCOD_MOD write fCOD_MOD;
    property COD_SIT: AnsiString read fCOD_SIT write fCOD_SIT;
    property SER: AnsiString read fSER write fSER;
    property SUB: AnsiString read fSUB write fSUB;
    property COD_CONS: AnsiString read fCOD_CONS write fCOD_CONS;
    property NUM_DOC: AnsiString read fNUM_DOC write fNUM_DOC;
    property DT_DOC: TDateTime read fDT_DOC write fDT_DOC;
    property DT_E_S: TDateTime read fDT_E_S write fDT_E_S;
    property VL_DOC: currency read fVL_DOC write fVL_DOC;
    property VL_DESC: currency read fVL_DESC write fVL_DESC;
    property VL_FORN: currency read fVL_FORN write fVL_FORN;
    property VL_SERV_NT: currency read fVL_SERV_NT write fVL_SERV_NT;
    property VL_TERC: currency read fVL_TERC write fVL_TERC;
    property VL_DA: currency read fVL_DA write fVL_DA;
    property VL_BC_ICMS: currency read fVL_BC_ICMS write fVL_BC_ICMS;
    property VL_ICMS: currency read fVL_ICMS write fVL_ICMS;
    property VL_BC_ICMS_ST: currency read fVL_BC_ICMS_ST write fVL_BC_ICMS_ST;
    property VL_ICMS_ST: currency read fVL_ICMS_ST write fVL_ICMS_ST;
    property COD_INF: AnsiString read fCOD_INF write fCOD_INF;
    property VL_PIS: currency read fVL_PIS write fVL_PIS;
    property VL_COFINS: currency read fVL_COFINS write fVL_COFINS;
    property TP_LIGACAO:        AnsiString read fTP_LIGACAO       write fTP_LIGACAO;
    property COD_GRUPO_TENSAO:  AnsiString read fCOD_GRUPO_TENSAO write fCOD_GRUPO_TENSAO;
  end;

  /// Registro C500 - Lista

  TRegistroC500List = class(TList)
  private
    function GetItem(Index: Integer): TRegistroC500; /// GetItem
    procedure SetItem(Index: Integer; const Value: TRegistroC500); /// SetItem
  public
    destructor Destroy; override;
    function New: TRegistroC500;
    property Items[Index: Integer]: TRegistroC500 read GetItem write SetItem;
  end;

  /// Registro C510 - ITENS DO DOCUMENTO NOTA FISCAL/CONTA ENERGIA ELÉTRICA (CÓDIGO 06) E NOTA FISCAL/CONTA DE FORNECIMENTO DE GÁS (CÓDIGO 28)

  TRegistroC510 = class(TPersistent)
  private
    fNUM_ITEM: AnsiString;     /// Número seqüencial do item no documento fiscal
    fCOD_ITEM: AnsiString;     /// Código do item (campo 02 do Registro 0200)
    fCOD_CLASS: AnsiString;    /// Código de classificação do item de energia elétrica, conforme a Tabela 4.4.1
    fQTD: Currency;        /// Quantidade do item
    fUNID: AnsiString;         /// Unidade do item (Campo 02 do registro 0190)
    fVL_ITEM: currency;    /// Valor do item
    fVL_DESC: currency;    /// Valor total do desconto
    fCST_ICMS: AnsiString;     /// Código da Situação Tributária, conforme a Tabela indicada no item 4.3.1
    fCFOP: AnsiString;         /// Código Fiscal de Operação e Prestação
    fVL_BC_ICMS: currency;       /// Valor da base de cálculo do ICMS
    fALIQ_ICMS: Currency;        /// Alíquota do ICMS
    fVL_ICMS: currency;          /// Valor do ICMS creditado/debitado
    fVL_BC_ICMS_ST: currency;    /// Valor da base de cálculo referente à substituição tributária
    fALIQ_ST: Currency;          /// Alíquota do ICMS da substituição tributária na unidade da federação de destino
    fVL_ICMS_ST: currency;       /// Valor do ICMS referente à substituição tributária
    fIND_REC: AnsiString;            /// Indicador do tipo de receita: 0- Receita própria; 1- Receita de terceiros
    fCOD_PART: AnsiString;           /// Código do participante receptor da receita, terceiro da operação (campo 02 do Registro 0150)
    fVL_PIS: currency;           /// Valor do PIS
    fVL_COFINS: currency;        /// Valor da COFINS
    fCOD_CTA: AnsiString;            /// Código da conta analítica contábil debitada/creditada
  public
    property NUM_ITEM: AnsiString read fNUM_ITEM write fNUM_ITEM;
    property COD_ITEM: AnsiString read fCOD_ITEM write fCOD_ITEM;
    property COD_CLASS: AnsiString read fCOD_CLASS write fCOD_CLASS;
    property QTD: Currency read fQTD write fQTD;
    property UNID: AnsiString read fUNID write fUNID;
    property VL_ITEM: currency read fVL_ITEM write fVL_ITEM;
    property VL_DESC: currency read fVL_DESC write fVL_DESC;
    property CST_ICMS: AnsiString read fCST_ICMS write fCST_ICMS;
    property CFOP: AnsiString read fCFOP write fCFOP;
    property VL_BC_ICMS: currency read fVL_BC_ICMS write fVL_BC_ICMS;
    property ALIQ_ICMS: Currency read fALIQ_ICMS write fALIQ_ICMS;
    property VL_ICMS: currency read fVL_ICMS write fVL_ICMS;
    property VL_BC_ICMS_ST: currency read fVL_BC_ICMS_ST write fVL_BC_ICMS_ST;
    property ALIQ_ST: Currency read fALIQ_ST write fALIQ_ST;
    property VL_ICMS_ST: currency read fVL_ICMS_ST write fVL_ICMS_ST;
    property IND_REC: AnsiString read fIND_REC write fIND_REC;
    property COD_PART: AnsiString read fCOD_PART write fCOD_PART;
    property VL_PIS: currency read fVL_PIS write fVL_PIS;
    property VL_COFINS: currency read fVL_COFINS write fVL_COFINS;
    property COD_CTA: AnsiString read fCOD_CTA write fCOD_CTA;
  end;

  /// Registro C510 - Lista

  TRegistroC510List = class(TList)
  private
    function GetItem(Index: Integer): TRegistroC510; /// GetItem
    procedure SetItem(Index: Integer; const Value: TRegistroC510); /// SetItem
  public
    destructor Destroy; override;
    function New: TRegistroC510;
    property Items[Index: Integer]: TRegistroC510 read GetItem write SetItem;
  end;

  /// Registro C590 - REGISTRO ANALÍTICO DO DOCUMENTO - NOTA FISCAL/CONTA DE ENERGIA ELÉTRICA (CÓDIGO 06) E NOTA FISCAL CONSUMO FORNECIMENTO DE GÁS (CÓDIGO 28)

  TRegistroC590 = class(TPersistent)
  private
    fCST_ICMS: AnsiString;        /// Código da Situação Tributária, conforme a Tabela indicada no item 4.3.1.
    fCFOP: AnsiString;            /// Código Fiscal de Operação e Prestação do agrupamento de itens
    fALIQ_ICMS: Currency;     /// Alíquota do ICMS
    fVL_OPR: currency;        /// Valor da operação correspondente à combinação de CST_ICMS, CFOP, e alíquota do ICMS.
    fVL_BC_ICMS: currency;    /// Parcela correspondente ao "Valor da base de cálculo do ICMS" referente à combinação de CST_ICMS, CFOP e alíquota do ICMS.
    fVL_ICMS: currency;       /// Parcela correspondente ao "Valor do ICMS" referente à combinação de CST_ICMS, CFOP e alíquota do ICMS.
    fVL_BC_ICMS_ST: currency; /// Parcela correspondente ao "Valor da base de cálculo do ICMS" da substituição tributária referente à combinação de CST_ICMS, CFOP e alíquota do ICMS.
    fVL_ICMS_ST: currency;    /// Parcela correspondente ao valor creditado/debitado do ICMS da substituição tributária, referente à combinação de CST_ICMS,  CFOP, e alíquota do ICMS.
    fVL_RED_BC: currency;     /// Valor não tributado em função da redução da base de cálculo do ICMS, referente à combinação de CST_ICMS, CFOP e alíquota do ICMS.
    fCOD_OBS: AnsiString;         /// Código da observação do lançamento fiscal (campo 02 do Registro 0460)
  public
    property CST_ICMS: AnsiString read fCST_ICMS write fCST_ICMS;
    property CFOP: AnsiString read fCFOP write fCFOP;
    property ALIQ_ICMS: Currency read fALIQ_ICMS write fALIQ_ICMS;
    property VL_OPR: currency read fVL_OPR write fVL_OPR;
    property VL_BC_ICMS: currency read fVL_BC_ICMS write fVL_BC_ICMS;
    property VL_ICMS: currency read fVL_ICMS write fVL_ICMS;
    property VL_BC_ICMS_ST: currency read fVL_BC_ICMS_ST write fVL_BC_ICMS_ST;
    property VL_ICMS_ST: currency read fVL_ICMS_ST write fVL_ICMS_ST;
    property VL_RED_BC: currency read fVL_RED_BC write fVL_RED_BC;
    property COD_OBS: AnsiString read fCOD_OBS write fCOD_OBS;
  end;

  /// Registro C590 - Lista

  TRegistroC590List = class(TList)
  private
    function GetItem(Index: Integer): TRegistroC590; /// GetItem
    procedure SetItem(Index: Integer; const Value: TRegistroC590); /// SetItem
  public
    destructor Destroy; override;
    function New: TRegistroC590;
    property Items[Index: Integer]: TRegistroC590 read GetItem write SetItem;
  end;

  /// Registro C600 - CONSOLIDAÇÃO DIÁRIA DE NOTAS FISCAIS/CONTAS DE ENERGIA ELÉTRICA (CÓDIGO 06), NOTA FISCAL/CONTA DE FORNECIMENTO D'ÁGUA CANALIZADA (CÓDIGO 29) E NOTA FISCAL/CONTA DE FORNECIMENTO DE GÁS (CÓDIGO 28) (EMPRESAS NÃO OBRIGADAS AO CONVENIO ICMS 115/03)

  TRegistroC600 = class(TPersistent)
  private
    fCOD_MOD: AnsiString;      /// Código do modelo do documento fiscal, conforme a Tabela 4.1.1
    fCOD_MUN: AnsiString;      /// Código do município dos pontos de consumo, conforme a tabela IBGE
    fSER: AnsiString;          /// Série do documento fiscal
    fSUB: AnsiString;          /// Subsérie do documento fiscal
    fCOD_CONS: AnsiString;     /// Código de classe de consumo de energia elétrica, conforme a Tabela 4.4.5, ou Código de Consumo de Fornecimento D’água - Tabela 4.4.2 ou Código da classe de consumo de gás canalizado   conforme Tabela 4.4.3.
    fQTD_CONS: Currency;   /// Quantidade de documentos consolidados neste registro
    fQTD_CANC: Currency;   /// Quantidade de documentos cancelados
    fDT_DOC: TDateTime;    /// Data dos documentos consolidados
    fVL_DOC: currency;     /// Valor total dos documentos
    fVL_DESC: currency;    /// Valor acumulado dos descontos
    fCONS: Currency;       /// Consumo total acumulado, em kWh (Código 06)
    fVL_FORN: currency;    /// Valor acumulado do fornecimento
    fVL_SERV_NT: currency; /// Valor acumulado dos serviços não-tributados pelo ICMS
    fVL_TERC: currency;    /// Valores cobrados em nome de terceiros
    fVL_DA: currency;      /// Valor acumulado das despesas acessórias
    fVL_BC_ICMS: currency; /// Valor acumulado da base de cálculo do ICMS
    fVL_ICMS: currency;    /// Valor acumulado do ICMS
    fVL_BC_ICMS_ST: currency;    /// Valor acumulado da base de cálculo do ICMS substituição tributária
    fVL_ICMS_ST: currency;       /// Valor acumulado do ICMS retido por substituição tributária
    fVL_PIS: currency;           /// Valor acumulado do PIS
    fVL_COFINS: currency;        /// Valor acumulado COFINS
  public
    property COD_MOD: AnsiString read fCOD_MOD write fCOD_MOD;
    property COD_MUN: AnsiString read fCOD_MUN write fCOD_MUN;
    property SER: AnsiString read fSER write fSER;
    property SUB: AnsiString read fSUB write fSUB;
    property COD_CONS: AnsiString read fCOD_CONS write fCOD_CONS;
    property QTD_CONS: Currency read fQTD_CONS write fQTD_CONS;
    property QTD_CANC: Currency read fQTD_CANC write fQTD_CANC;
    property DT_DOC: TDateTime read fDT_DOC write fDT_DOC;
    property VL_DOC: currency read fVL_DOC write fVL_DOC;
    property VL_DESC: currency read fVL_DESC write fVL_DESC;
    property CONS: Currency read fCONS write fCONS;
    property VL_FORN: currency read fVL_FORN write fVL_FORN;
    property VL_SERV_NT: currency read fVL_SERV_NT write fVL_SERV_NT;
    property VL_TERC: currency read fVL_TERC write fVL_TERC;
    property VL_DA: currency read fVL_DA write fVL_DA;
    property VL_BC_ICMS: currency read fVL_BC_ICMS write fVL_BC_ICMS;
    property VL_ICMS: currency read fVL_ICMS write fVL_ICMS;
    property VL_BC_ICMS_ST: currency read fVL_BC_ICMS_ST write fVL_BC_ICMS_ST;
    property VL_ICMS_ST: currency read fVL_ICMS_ST write fVL_ICMS_ST;
    property VL_PIS: currency read fVL_PIS write fVL_PIS;
    property VL_COFINS: currency read fVL_COFINS write fVL_COFINS;
  end;

  /// Registro C600 - Lista

  TRegistroC600List = class(TList)
  private
    function GetItem(Index: Integer): TRegistroC600; /// GetItem
    procedure SetItem(Index: Integer; const Value: TRegistroC600); /// SetItem
  public
    destructor Destroy; override;
    function New: TRegistroC600;
    property Items[Index: Integer]: TRegistroC600 read GetItem write SetItem;
  end;

  /// Registro C601 - DOCUMENTOS CANCELADOS - CONSOLIDAÇÃO DIÁRIA DE NOTAS FISCAIS/CONTAS DE ENERGIA ELÉTRICA (CÓDIGO 06), NOTA FISCAL/CONTA DE FORNECIMENTO D'ÁGUA CANALIZADA (CÓDIGO 29) E NOTA FISCAL/CONTA DE FORNECIMENTO DE GÁS (CÓDIGO 28)

  TRegistroC601 = class(TPersistent)
  private
    fNUM_DOC_CANC: AnsiString;        /// Número do documento fiscal cancelado
  public
    property NUM_DOC_CANC: AnsiString read FNUM_DOC_CANC write FNUM_DOC_CANC;
  end;

  /// Registro C601 - Lista

  TRegistroC601List = class(TList)
  private
    function GetItem(Index: Integer): TRegistroC601; /// GetItem
    procedure SetItem(Index: Integer; const Value: TRegistroC601); /// SetItem
  public
    destructor Destroy; override;
    function New: TRegistroC601;
    property Items[Index: Integer]: TRegistroC601 read GetItem write SetItem;
  end;

  /// Registro C610 - ITENS DO DOCUMENTO CONSOLIDADO NOTAS FISCAIS/CONTAS DE ENERGIA ELÉTRICA (CÓDIGO 06), NOTA FISCAL/CONTA DE FORNECIMENTO D'ÁGUA CANALIZADA (CÓDIGO 29) E NOTA FISCAL/CONTA DE FORNECIMENTO DE GÁS (CÓDIGO 28) (EMPRESAS NÃO OBRIGADAS AO CONVENIO ICMS 115/03)

  TRegistroC610 = class(TPersistent)
  private
    fCOD_CLASS: AnsiString;           /// Código de classificação do item de energia elétrica, conforme Tabela 4.4.1
    fCOD_ITEM: AnsiString;            /// Código do item (campo 02 do Registro 0200)
    fQTD: currency;               /// Quantidade acumulada do item
    fUNID: AnsiString;                /// Unidade do item (Campo 02 do registro 0190)
    fVL_ITEM: currency;           /// Valor acumulado do item
    fVL_DESC: currency;           /// Valor acumulado dos descontos
    fCST_ICMS: AnsiString;            /// Código da Situação Tributária, conforme a Tabela indicada no item 4.3.1
    fCFOP: AnsiString;                /// Código Fiscal de Operação e Prestação conforme tabela indicada no item 4.2.2
    fALIQ_ICMS: currency;         /// Alíquota do ICMS
    fVL_BC_ICMS: currency;        /// Valor acumulado da base de cálculo do ICMS
    fVL_ICMS: currency;           /// Valor acumulado do ICMS debitado
    fVL_BC_ICMS_ST: currency;     /// Valor da base de cálculo do ICMS substituição tributária
    fVL_ICMS_ST: currency;        /// Valor do ICMS retido por substituição tributária
    fVL_PIS: currency;            /// Valor do PIS
    fVL_COFINS: currency;         /// Valor da COFINS
    fCOD_CTA: AnsiString;             /// Código da conta analítica contábil debitada/creditada
  public
    property COD_CLASS: AnsiString read FCOD_CLASS write FCOD_CLASS;
    property COD_ITEM: AnsiString read FCOD_ITEM write FCOD_ITEM;
    property QTD: currency read FQTD write FQTD;
    property UNID: AnsiString read FUNID write FUNID;
    property VL_ITEM: currency read FVL_ITEM write FVL_ITEM;
    property VL_DESC: currency read FVL_DESC write FVL_DESC;
    property CST_ICMS: AnsiString read FCST_ICMS write FCST_ICMS;
    property CFOP: AnsiString read FCFOP write FCFOP;
    property ALIQ_ICMS: currency read FALIQ_ICMS write FALIQ_ICMS;
    property VL_BC_ICMS: currency read FVL_BC_ICMS write FVL_BC_ICMS;
    property VL_ICMS: currency read FVL_ICMS write FVL_ICMS;
    property VL_BC_ICMS_ST: currency read FVL_BC_ICMS_ST write FVL_BC_ICMS_ST;
    property VL_ICMS_ST: currency read FVL_ICMS_ST write FVL_ICMS_ST;
    property VL_PIS: currency read FVL_PIS write FVL_PIS;
    property VL_COFINS: currency read FVL_COFINS write FVL_COFINS;
    property COD_CTA: AnsiString read FCOD_CTA write FCOD_CTA;
  end;

  /// Registro C610 - Lista

  TRegistroC610List = class(TList)
  private
    function GetItem(Index: Integer): TRegistroC610; /// GetItem
    procedure SetItem(Index: Integer; const Value: TRegistroC610); /// SetItem
  public
    destructor Destroy; override;
    function New: TRegistroC610;
    property Items[Index: Integer]: TRegistroC610 read GetItem write SetItem;
  end;

  /// Registro C620 - COMPLEMENTO DO DOCUMENTO - DADOS ADICIONAIS (CÓDIGO 06)

  TRegistroC620 = class(TPersistent)
  private
    fVL_FCP: currency;      /// Valor do ICMS resultante da alíquota adicional dos itens incluídos no Fundo de Combate à Pobreza
    fIND_F0: AnsiString;        /// Indicador de nota fiscal recebida/destinada de/a participante do Programa Fome Zero: 0- Não; 1- Sim
  public
    property VL_FCP: currency read FVL_FCP write FVL_FCP;
    property IND_F0: AnsiString read FIND_F0 write FIND_F0;
  end;

  /// Registro C620 - Lista

  TRegistroC620List = class(TList)
  private
    function GetItem(Index: Integer): TRegistroC620; /// GetItem
    procedure SetItem(Index: Integer; const Value: TRegistroC620); /// SetItem
  public
    destructor Destroy; override;
    function New: TRegistroC620;
    property Items[Index: Integer]: TRegistroC620 read GetItem write SetItem;
  end;

  /// Registro C690 - REGISTRO ANALÍTICO DOS DOCUMENTOS (Notas Fiscais/Contas de Energia Elétrica (Código 06), Nota Fiscal/Conta de Fornecimento d´água CANALIZADA (código 29) e Nota Fiscal/Conta de Fornecimento de Gás (Código 28)

  TRegistroC690 = class(TPersistent)
  private
    fCST_ICMS: AnsiString;            /// Código da Situação Tributária, conforme a tabela indicada no item 4.3.1
    fCFOP: AnsiString;                /// Código Fiscal de Operação e Prestação, conforme a tabela indicada no item 4.2.2
    fALIQ_ICMS: currency;         /// Alíquota do ICMS
    fVL_OPR: currency;            /// Valor da operação correspondente à combinação de CST_ICMS, CFOP, e alíquota do ICMS.
    fVL_BC_ICMS: currency;        /// Parcela correspondente ao "Valor da base de cálculo do ICMS" referente à combinação CST_ICMS, CFOP e alíquota do ICMS
    fVL_ICMS: currency;           /// Parcela correspondente ao "Valor do ICMS" referente à combinação CST_ICMS, CFOP e alíquota do ICMS
    fVL_RED_BC: currency;         /// Valor não tributado em função da redução da base de cálculo do ICMS, referente à combinação de CST_ICMS, CFOP e alíquota do ICMS.
    fVL_BC_ICMS_ST: currency;     /// Valor da base de cálculo do ICMS substituição tributária
    fVL_ICMS_ST: currency;        /// Valor do ICMS retido por substituição tributária
    fCOD_OBS: AnsiString;             /// Código da observação do lançamento fiscal (campo 02 do Registro 0460)
  public
    property CST_ICMS: AnsiString read FCST_ICMS write FCST_ICMS;
    property CFOP: AnsiString read FCFOP write FCFOP;
    property ALIQ_ICMS: currency read FALIQ_ICMS write FALIQ_ICMS;
    property VL_OPR: currency read FVL_OPR write FVL_OPR;
    property VL_BC_ICMS: currency read FVL_BC_ICMS write FVL_BC_ICMS;
    property VL_ICMS: currency read FVL_ICMS write FVL_ICMS;
    property VL_RED_BC: currency read FVL_RED_BC write FVL_RED_BC;
    property VL_BC_ICMS_ST: currency read FVL_BC_ICMS_ST write FVL_BC_ICMS_ST;
    property VL_ICMS_ST: currency read FVL_ICMS_ST write FVL_ICMS_ST;
    property COD_OBS: AnsiString read FCOD_OBS write FCOD_OBS;
  end;

  /// Registro C690 - Lista

  TRegistroC690List = class(TList)
  private
    function GetItem(Index: Integer): TRegistroC690; /// GetItem
    procedure SetItem(Index: Integer; const Value: TRegistroC690); /// SetItem
  public
    destructor Destroy; override;
    function New: TRegistroC690;
    property Items[Index: Integer]: TRegistroC690 read GetItem write SetItem;
  end;

  /// Registro C700 - CONSOLIDAÇÃO DOS DOCUMENTOS NF/CONTA ENERGIA ELÉTRICA (CÓDIGO 06), EMITIDAS EM VIA ÚNICA (EMPRESAS OBRIGADAS AO CONVENIO ICMS 115/03)

  TRegistroC700 = class(TPersistent)
  private
    fCOD_MOD: AnsiString;      /// Código do modelo d documento fiscal, conforme a Tabela 4.1.1
    fSER: AnsiString;          /// Série do documento fiscal
    fNRO_ORD_INI: integer; /// Número de ordem inicial
    fNRO_ORD_FIN: integer; /// Número de ordem final
    fDT_DOC_INI: TDateTime;   /// Data de emissão inicial dos documentos
    fDT_DOC_FIN: TDateTime;   /// Data de emissão final dos documentos
    fNOM_MEST: AnsiString;        /// Nome do arquivo Mestre de Documento Fiscal
    fCHV_COD_DIG: AnsiString;     /// Chave de codificação digital do arquivo Mestre de Documento Fiscal
  public
    property COD_MOD: AnsiString read fCOD_MOD write fCOD_MOD;
    property SER: AnsiString read fSER write fSER;
    property NRO_ORD_INI: integer read fNRO_ORD_INI write fNRO_ORD_INI;
    property NRO_ORD_FIN: integer read fNRO_ORD_FIN write fNRO_ORD_FIN;
    property DT_DOC_INI: TDateTime read fDT_DOC_INI write fDT_DOC_INI;
    property DT_DOC_FIN: TDateTime read fDT_DOC_FIN write fDT_DOC_FIN;
    property NOM_MEST: AnsiString read fNOM_MEST write fNOM_MEST;
    property CHV_COD_DIG: AnsiString read fCHV_COD_DIG write fCHV_COD_DIG;
  end;

  /// Registro C700 - Lista

  TRegistroC700List = class(TList)
  private
    function GetItem(Index: Integer): TRegistroC700; /// GetItem
    procedure SetItem(Index: Integer; const Value: TRegistroC700); /// SetItem
  public
    destructor Destroy; override;
    function New: TRegistroC700;
    property Items[Index: Integer]: TRegistroC700 read GetItem write SetItem;
  end;

  /// Registro C790 - REGISTRO ANALÍTICO DOS DOCUMENTOS (COD 06)

  TRegistroC790 = class(TPersistent)
  private
    fCST_ICMS: AnsiString;            /// Código da Situação Tributária, conforme a tabela indicada no item 4.3.1
    fCFOP: AnsiString;                /// Código Fiscal de Operação e Prestação, conforme a tabela indicada no item 4.2.2
    fALIQ_ICMS: currency;         /// Alíquota do ICMS
    fVL_OPR: currency;            /// Valor da operação correspondente à combinação de CST_ICMS, CFOP, e alíquota do ICMS.
    fVL_BC_ICMS: currency;        /// Parcela correspondente ao "Valor da base de cálculo do ICMS" referente à combinação CST_ICMS, CFOP, e alíquota do ICMS
    fVL_ICMS: currency;           /// Parcela correspondente ao "Valor do ICMS" referente à combinação CST_ICMS, CFOP e alíquota do ICMS
    fVL_BC_ICMS_ST: currency;     /// Valor da base de cálculo do ICMS substituição tributária
    fVL_ICMS_ST: currency;        /// Valor do ICMS retido por substituição tributária
    fVL_RED_BC: currency;         /// Valor não tributado em função da redução da base de cálculo do ICMS, referente à combinação de CST_ICMS, CFOP e alíquota do ICMS.
    fCOD_OBS: AnsiString;             /// Código da observação do lançamento fiscal (campo 02 do Registro 0460)
  public
    property CST_ICMS: AnsiString read FCST_ICMS write FCST_ICMS;
    property CFOP: AnsiString read FCFOP write FCFOP;
    property ALIQ_ICMS: currency read FALIQ_ICMS write FALIQ_ICMS;
    property VL_OPR: currency read FVL_OPR write FVL_OPR;
    property VL_BC_ICMS: currency read FVL_BC_ICMS write FVL_BC_ICMS;
    property VL_ICMS: currency read FVL_ICMS write FVL_ICMS;
    property VL_BC_ICMS_ST: currency read FVL_BC_ICMS_ST write FVL_BC_ICMS_ST;
    property VL_ICMS_ST: currency read FVL_ICMS_ST write FVL_ICMS_ST;
    property VL_RED_BC: currency read FVL_RED_BC write FVL_RED_BC;
    property COD_OBS: AnsiString read FCOD_OBS write FCOD_OBS;
  end;

  /// Registro C790 - Lista

  TRegistroC790List = class(TList)
  private
    function GetItem(Index: Integer): TRegistroC790; /// GetItem
    procedure SetItem(Index: Integer; const Value: TRegistroC790); /// SetItem
  public
    destructor Destroy; override;
    function New: TRegistroC790;
    property Items[Index: Integer]: TRegistroC790 read GetItem write SetItem;
  end;

  /// Registro C791 - REGISTRO DE INFORMAÇÕES DE ICMS ST POR UF (COD 06)

  TRegistroC791 = class(TPersistent)
  private
    fUF: AnsiString;                  /// Sigla da unidade da federação a que se refere a retenção ST
    fVL_BC_ICMS_ST: currency;     /// Valor da base de cálculo do ICMS substituição tributária
    fVL_ICMS_ST: currency;        /// Valor do ICMS retido por substituição tributária
  public
    property UF: AnsiString read FUF write FUF;
    property VL_BC_ICMS_ST: currency read FVL_BC_ICMS_ST write FVL_BC_ICMS_ST;
    property VL_ICMS_ST: currency read FVL_ICMS_ST write FVL_ICMS_ST;
  end;

  /// Registro C791 - Lista

  TRegistroC791List = class(TList)
  private
    function GetItem(Index: Integer): TRegistroC791; /// GetItem
    procedure SetItem(Index: Integer; const Value: TRegistroC791); /// SetItem
  public
    destructor Destroy; override;
    function New: TRegistroC791;
    property Items[Index: Integer]: TRegistroC791 read GetItem write SetItem;
  end;

  /// Registro C990 - ENCERRAMENTO DO BLOCO C

  TRegistroC990 = class(TPersistent)
  private
    fQTD_LIN_C: Integer; /// Quantidade total de linhas do Bloco C
  public
    property QTD_LIN_C: Integer read fQTD_LIN_C write fQTD_LIN_C;
  end;

implementation

{ TRegistroC100 }

{ TRegistroC100List }

destructor TRegistroC100List.Destroy;
var
intFor: integer;
begin
  for intFor := 0 to Count - 1 do Items[intFor].Free;
  inherited;
end;

function TRegistroC100List.GetItem(Index: Integer): TRegistroC100;
begin
  Result := TRegistroC100(Inherited Items[Index]);
end;

function TRegistroC100List.New: TRegistroC100;
begin
  Result := TRegistroC100.Create;
  Add(Result);
end;

procedure TRegistroC100List.SetItem(Index: Integer; const Value: TRegistroC100);
begin
  Put(Index, Value);
end;

{ TRegistroC110List }

destructor TRegistroC110List.Destroy;
var
intFor: integer;
begin
  for intFor := 0 to Count - 1 do Items[intFor].Free;
  inherited;
end;

function TRegistroC110List.GetItem(Index: Integer): TRegistroC110;
begin
  Result := TRegistroC110(Inherited Items[Index]);
end;

function TRegistroC110List.New: TRegistroC110;
begin
  Result := TRegistroC110.Create;
  Add(Result);
end;

procedure TRegistroC110List.SetItem(Index: Integer; const Value: TRegistroC110);
begin
  Put(Index, Value);
end;

{ TRegistroC111List }

destructor TRegistroC111List.Destroy;
var
intFor: integer;
begin
  for intFor := 0 to Count - 1 do Items[intFor].Free;
  inherited;
end;

function TRegistroC111List.GetItem(Index: Integer): TRegistroC111;
begin
  Result := TRegistroC111(Inherited Items[Index]);
end;

function TRegistroC111List.New: TRegistroC111;
begin
  Result := TRegistroC111.Create;
  Add(Result);
end;

procedure TRegistroC111List.SetItem(Index: Integer; const Value: TRegistroC111);
begin
  Put(Index, Value);
end;

{ TRegistroC112List }

destructor TRegistroC112List.Destroy;
var
intFor: integer;
begin
  for intFor := 0 to Count - 1 do Items[intFor].Free;
  inherited;
end;

function TRegistroC112List.GetItem(Index: Integer): TRegistroC112;
begin
  Result := TRegistroC112(Inherited Items[Index]);
end;

function TRegistroC112List.New: TRegistroC112;
begin
  Result := TRegistroC112.Create;
  Add(Result);
end;

procedure TRegistroC112List.SetItem(Index: Integer; const Value: TRegistroC112);
begin
  Put(Index, Value);
end;

{ TRegistroC113List }

destructor TRegistroC113List.Destroy;
var
intFor: integer;
begin
  for intFor := 0 to Count - 1 do Items[intFor].Free;
  inherited;
end;

function TRegistroC113List.GetItem(Index: Integer): TRegistroC113;
begin
  Result := TRegistroC113(Inherited Items[Index]);
end;

function TRegistroC113List.New: TRegistroC113;
begin
  Result := TRegistroC113.Create;
  Add(Result);
end;

procedure TRegistroC113List.SetItem(Index: Integer; const Value: TRegistroC113);
begin
  Put(Index, Value);
end;

{ TRegistroC114List }

destructor TRegistroC114List.Destroy;
var
intFor: integer;
begin
  for intFor := 0 to Count - 1 do Items[intFor].Free;
  inherited;
end;

function TRegistroC114List.GetItem(Index: Integer): TRegistroC114;
begin
  Result := TRegistroC114(Inherited Items[Index]);
end;

function TRegistroC114List.New: TRegistroC114;
begin
  Result := TRegistroC114.Create;
  Add(Result);
end;

procedure TRegistroC114List.SetItem(Index: Integer; const Value: TRegistroC114);
begin
  Put(Index, Value);
end;

{ TRegistroC115List }

destructor TRegistroC115List.Destroy;
var
intFor: integer;
begin
  for intFor := 0 to Count - 1 do Items[intFor].Free;
  inherited;
end;

function TRegistroC115List.GetItem(Index: Integer): TRegistroC115;
begin
  Result := TRegistroC115(Inherited Items[Index]);
end;

function TRegistroC115List.New: TRegistroC115;
begin
  Result := TRegistroC115.Create;
  Add(Result);
end;

procedure TRegistroC115List.SetItem(Index: Integer; const Value: TRegistroC115);
begin
  Put(Index, Value);
end;

{ TRegistroC120List }

destructor TRegistroC120List.Destroy;
var
intFor: integer;
begin
  for intFor := 0 to Count - 1 do Items[intFor].Free;
  inherited;
end;

function TRegistroC120List.GetItem(Index: Integer): TRegistroC120;
begin
  Result := TRegistroC120(Inherited Items[Index]);
end;

function TRegistroC120List.New: TRegistroC120;
begin
  Result := TRegistroC120.Create;
  Add(Result);
end;

procedure TRegistroC120List.SetItem(Index: Integer; const Value: TRegistroC120);
begin
  Put(Index, Value);
end;

{ TRegistroC130List }

destructor TRegistroC130List.Destroy;
var
intFor: integer;
begin
  for intFor := 0 to Count - 1 do Items[intFor].Free;
  inherited;
end;

function TRegistroC130List.GetItem(Index: Integer): TRegistroC130;
begin
  Result := TRegistroC130(Inherited Items[Index]);
end;

function TRegistroC130List.New: TRegistroC130;
begin
  Result := TRegistroC130.Create;
  Add(Result);
end;

procedure TRegistroC130List.SetItem(Index: Integer; const Value: TRegistroC130);
begin
  Put(Index, Value);
end;

{ TRegistroC140List }

destructor TRegistroC140List.Destroy;
var
intFor: integer;
begin
  for intFor := 0 to Count - 1 do Items[intFor].Free;
  inherited;
end;

function TRegistroC140List.GetItem(Index: Integer): TRegistroC140;
begin
  Result := TRegistroC140(Inherited Items[Index]);
end;

function TRegistroC140List.New: TRegistroC140;
begin
  Result := TRegistroC140.Create;
  Add(Result);
end;

procedure TRegistroC140List.SetItem(Index: Integer; const Value: TRegistroC140);
begin
  Put(Index, Value);
end;

{ TRegistroC141List }

destructor TRegistroC141List.Destroy;
var
intFor: integer;
begin
  for intFor := 0 to Count - 1 do Items[intFor].Free;
  inherited;
end;

function TRegistroC141List.GetItem(Index: Integer): TRegistroC141;
begin
  Result := TRegistroC141(Inherited Items[Index]);
end;

function TRegistroC141List.New: TRegistroC141;
begin
  Result := TRegistroC141.Create;
  Add(Result);
end;

procedure TRegistroC141List.SetItem(Index: Integer; const Value: TRegistroC141);
begin
  Put(Index, Value);
end;

{ TRegistroC160List }

destructor TRegistroC160List.Destroy;
var
intFor: integer;
begin
  for intFor := 0 to Count - 1 do Items[intFor].Free;
  inherited;
end;

function TRegistroC160List.GetItem(Index: Integer): TRegistroC160;
begin
  Result := TRegistroC160(Inherited Items[Index]);
end;

function TRegistroC160List.New: TRegistroC160;
begin
  Result := TRegistroC160.Create;
  Add(Result);
end;

procedure TRegistroC160List.SetItem(Index: Integer; const Value: TRegistroC160);
begin
  Put(Index, Value);
end;

{ TRegistroC165List }

destructor TRegistroC165List.Destroy;
var
intFor: integer;
begin
  for intFor := 0 to Count - 1 do Items[intFor].Free;
  inherited;
end;

function TRegistroC165List.GetItem(Index: Integer): TRegistroC165;
begin
  Result := TRegistroC165(Inherited Items[Index]);
end;

function TRegistroC165List.New: TRegistroC165;
begin
  Result := TRegistroC165.Create;
  Add(Result);
end;

procedure TRegistroC165List.SetItem(Index: Integer; const Value: TRegistroC165);
begin
  Put(Index, Value);
end;

{ TRegistroC170List }

destructor TRegistroC170List.Destroy;
var
intFor: integer;
begin
  for intFor := 0 to Count - 1 do Items[intFor].Free;
  inherited;
end;

function TRegistroC170List.GetItem(Index: Integer): TRegistroC170;
begin
  Result := TRegistroC170(Inherited Items[Index]);
end;

function TRegistroC170List.New: TRegistroC170;
begin
  Result := TRegistroC170.Create;
  Add(Result);
end;

procedure TRegistroC170List.SetItem(Index: Integer; const Value: TRegistroC170);
begin
  Put(Index, Value);
end;

{ TRegistroC171List }

destructor TRegistroC171List.Destroy;
var
intFor: integer;
begin
  for intFor := 0 to Count - 1 do Items[intFor].Free;
  inherited;
end;

function TRegistroC171List.GetItem(Index: Integer): TRegistroC171;
begin
  Result := TRegistroC171(Inherited Items[Index]);
end;

function TRegistroC171List.New: TRegistroC171;
begin
  Result := TRegistroC171.Create;
  Add(Result);
end;

procedure TRegistroC171List.SetItem(Index: Integer; const Value: TRegistroC171);
begin
  Put(Index, Value);
end;

{ TRegistroC172List }

destructor TRegistroC172List.Destroy;
var
intFor: integer;
begin
  for intFor := 0 to Count - 1 do Items[intFor].Free;
  inherited;
end;

function TRegistroC172List.GetItem(Index: Integer): TRegistroC172;
begin
  Result := TRegistroC172(Inherited Items[Index]);
end;

function TRegistroC172List.New: TRegistroC172;
begin
  Result := TRegistroC172.Create;
  Add(Result);
end;

procedure TRegistroC172List.SetItem(Index: Integer; const Value: TRegistroC172);
begin
  Put(Index, Value);
end;

{ TRegistroC173List }

destructor TRegistroC173List.Destroy;
var
intFor: integer;
begin
  for intFor := 0 to Count - 1 do Items[intFor].Free;
  inherited;
end;

function TRegistroC173List.GetItem(Index: Integer): TRegistroC173;
begin
  Result := TRegistroC173(Inherited Items[Index]);
end;

function TRegistroC173List.New: TRegistroC173;
begin
  Result := TRegistroC173.Create;
  Add(Result);
end;

procedure TRegistroC173List.SetItem(Index: Integer; const Value: TRegistroC173);
begin
  Put(Index, Value);
end;

{ TRegistroC174List }

destructor TRegistroC174List.Destroy;
var
intFor: integer;
begin
  for intFor := 0 to Count - 1 do Items[intFor].Free;
  inherited;
end;

function TRegistroC174List.GetItem(Index: Integer): TRegistroC174;
begin
  Result := TRegistroC174(Inherited Items[Index]);
end;

function TRegistroC174List.New: TRegistroC174;
begin
  Result := TRegistroC174.Create;
  Add(Result);
end;

procedure TRegistroC174List.SetItem(Index: Integer; const Value: TRegistroC174);
begin
  Put(Index, Value);
end;

{ TRegistroC175List }

destructor TRegistroC175List.Destroy;
var
intFor: integer;
begin
  for intFor := 0 to Count - 1 do Items[intFor].Free;
  inherited;
end;

function TRegistroC175List.GetItem(Index: Integer): TRegistroC175;
begin
  Result := TRegistroC175(Inherited Items[Index]);
end;

function TRegistroC175List.New: TRegistroC175;
begin
  Result := TRegistroC175.Create;
  Add(Result);
end;

procedure TRegistroC175List.SetItem(Index: Integer; const Value: TRegistroC175);
begin
  Put(Index, Value);
end;

{ TRegistroC176List }

destructor TRegistroC176List.Destroy;
var
intFor: integer;
begin
  for intFor := 0 to Count - 1 do Items[intFor].Free;
  inherited;
end;

function TRegistroC176List.GetItem(Index: Integer): TRegistroC176;
begin
  Result := TRegistroC176(Inherited Items[Index]);
end;

function TRegistroC176List.New: TRegistroC176;
begin
  Result := TRegistroC176.Create;
  Add(Result);
end;

procedure TRegistroC176List.SetItem(Index: Integer; const Value: TRegistroC176);
begin
  Put(Index, Value);
end;

{ TRegistroC177List }

destructor TRegistroC177List.Destroy;
var
intFor: integer;
begin
  for intFor := 0 to Count - 1 do Items[intFor].Free;
  inherited;
end;

function TRegistroC177List.GetItem(Index: Integer): TRegistroC177;
begin
  Result := TRegistroC177(Inherited Items[Index]);
end;

function TRegistroC177List.New: TRegistroC177;
begin
  Result := TRegistroC177.Create;
  Add(Result);
end;

procedure TRegistroC177List.SetItem(Index: Integer; const Value: TRegistroC177);
begin
  Put(Index, Value);
end;

{ TRegistroC178List }

destructor TRegistroC178List.Destroy;
var
intFor: integer;
begin
  for intFor := 0 to Count - 1 do Items[intFor].Free;
  inherited;
end;

function TRegistroC178List.GetItem(Index: Integer): TRegistroC178;
begin
  Result := TRegistroC178(Inherited Items[Index]);
end;

function TRegistroC178List.New: TRegistroC178;
begin
  Result := TRegistroC178.Create;
  Add(Result);
end;

procedure TRegistroC178List.SetItem(Index: Integer; const Value: TRegistroC178);
begin
  Put(Index, Value);
end;

{ TRegistroC179List }

destructor TRegistroC179List.Destroy;
var
intFor: integer;
begin
  for intFor := 0 to Count - 1 do Items[intFor].Free;
  inherited;
end;

function TRegistroC179List.GetItem(Index: Integer): TRegistroC179;
begin
  Result := TRegistroC179(Inherited Items[Index]);
end;

function TRegistroC179List.New: TRegistroC179;
begin
  Result := TRegistroC179.Create;
  Add(Result);
end;

procedure TRegistroC179List.SetItem(Index: Integer; const Value: TRegistroC179);
begin
  Put(Index, Value);
end;

{ TRegistroC190List }

destructor TRegistroC190List.Destroy;
var
intFor: integer;
begin
  for intFor := 0 to Count - 1 do Items[intFor].Free;
  inherited;
end;

function TRegistroC190List.GetItem(Index: Integer): TRegistroC190;
begin
  Result := TRegistroC190(Inherited Items[Index]);
end;

function TRegistroC190List.New: TRegistroC190;
begin
  Result := TRegistroC190.Create;
  Add(Result);
end;

procedure TRegistroC190List.SetItem(Index: Integer; const Value: TRegistroC190);
begin
  Put(Index, Value);
end;

{ TRegistroC195List }

destructor TRegistroC195List.Destroy;
var
intFor: integer;
begin
  for intFor := 0 to Count - 1 do Items[intFor].Free;
  inherited;
end;

function TRegistroC195List.GetItem(Index: Integer): TRegistroC195;
begin
  Result := TRegistroC195(Inherited Items[Index]);
end;

function TRegistroC195List.New: TRegistroC195;
begin
  Result := TRegistroC195.Create;
  Add(Result);
end;

procedure TRegistroC195List.SetItem(Index: Integer; const Value: TRegistroC195);
begin
  Put(Index, Value);
end;

{ TRegistroC197List }

destructor TRegistroC197List.Destroy;
var
intFor: integer;
begin
  for intFor := 0 to Count - 1 do Items[intFor].Free;
  inherited;
end;

function TRegistroC197List.GetItem(Index: Integer): TRegistroC197;
begin
  Result := TRegistroC197(Inherited Items[Index]);
end;

function TRegistroC197List.New: TRegistroC197;
begin
  Result := TRegistroC197.Create;
  Add(Result);
end;

procedure TRegistroC197List.SetItem(Index: Integer; const Value: TRegistroC197);
begin
  Put(Index, Value);
end;

{ TRegistroC300List }

destructor TRegistroC300List.Destroy;
var
intFor: integer;
begin
  for intFor := 0 to Count - 1 do Items[intFor].Free;
  inherited;
end;

function TRegistroC300List.GetItem(Index: Integer): TRegistroC300;
begin
  Result := TRegistroC300(Inherited Items[Index]);
end;

function TRegistroC300List.New: TRegistroC300;
begin
  Result := TRegistroC300.Create;
  Add(Result);
end;

procedure TRegistroC300List.SetItem(Index: Integer; const Value: TRegistroC300);
begin
  Put(Index, Value);
end;

{ TRegistroC310List }

destructor TRegistroC310List.Destroy;
var
intFor: integer;
begin
  for intFor := 0 to Count - 1 do Items[intFor].Free;
  inherited;
end;

function TRegistroC310List.GetItem(Index: Integer): TRegistroC310;
begin
  Result := TRegistroC310(Inherited Items[Index]);
end;

function TRegistroC310List.New: TRegistroC310;
begin
  Result := TRegistroC310.Create;
  Add(Result);
end;

procedure TRegistroC310List.SetItem(Index: Integer; const Value: TRegistroC310);
begin
  Put(Index, Value);
end;

{ TRegistroC320List }

destructor TRegistroC320List.Destroy;
var
intFor: integer;
begin
  for intFor := 0 to Count - 1 do Items[intFor].Free;
  inherited;
end;

function TRegistroC320List.GetItem(Index: Integer): TRegistroC320;
begin
  Result := TRegistroC320(Inherited Items[Index]);
end;

function TRegistroC320List.New: TRegistroC320;
begin
  Result := TRegistroC320.Create;
  Add(Result);
end;

procedure TRegistroC320List.SetItem(Index: Integer; const Value: TRegistroC320);
begin
  Put(Index, Value);
end;

{ TRegistroC321List }

destructor TRegistroC321List.Destroy;
var
intFor: integer;
begin
  for intFor := 0 to Count - 1 do Items[intFor].Free;
  inherited;
end;

function TRegistroC321List.GetItem(Index: Integer): TRegistroC321;
begin
  Result := TRegistroC321(Inherited Items[Index]);
end;

function TRegistroC321List.New: TRegistroC321;
begin
  Result := TRegistroC321.Create;
  Add(Result);
end;

procedure TRegistroC321List.SetItem(Index: Integer; const Value: TRegistroC321);
begin
  Put(Index, Value);
end;

{ TRegistroC350List }

destructor TRegistroC350List.Destroy;
var
intFor: integer;
begin
  for intFor := 0 to Count - 1 do Items[intFor].Free;
  inherited;
end;

function TRegistroC350List.GetItem(Index: Integer): TRegistroC350;
begin
  Result := TRegistroC350(Inherited Items[Index]);
end;

function TRegistroC350List.New: TRegistroC350;
begin
  Result := TRegistroC350.Create;
  Add(Result);
end;

procedure TRegistroC350List.SetItem(Index: Integer; const Value: TRegistroC350);
begin
  Put(Index, Value);
end;

{ TRegistroC370List }

destructor TRegistroC370List.Destroy;
var
intFor: integer;
begin
  for intFor := 0 to Count - 1 do Items[intFor].Free;
  inherited;
end;

function TRegistroC370List.GetItem(Index: Integer): TRegistroC370;
begin
  Result := TRegistroC370(Inherited Items[Index]);
end;

function TRegistroC370List.New: TRegistroC370;
begin
  Result := TRegistroC370.Create;
  Add(Result);
end;

procedure TRegistroC370List.SetItem(Index: Integer; const Value: TRegistroC370);
begin
  Put(Index, Value);
end;

{ TRegistroC390List }

destructor TRegistroC390List.Destroy;
var
intFor: integer;
begin
  for intFor := 0 to Count - 1 do Items[intFor].Free;
  inherited;
end;

function TRegistroC390List.GetItem(Index: Integer): TRegistroC390;
begin
  Result := TRegistroC390(Inherited Items[Index]);
end;

function TRegistroC390List.New: TRegistroC390;
begin
  Result := TRegistroC390.Create;
  Add(Result);
end;

procedure TRegistroC390List.SetItem(Index: Integer; const Value: TRegistroC390);
begin
  Put(Index, Value);
end;

{ TRegistroC400List }

destructor TRegistroC400List.Destroy;
var
intFor: integer;
begin
  for intFor := 0 to Count - 1 do Items[intFor].Free;
  inherited;
end;

function TRegistroC400List.GetItem(Index: Integer): TRegistroC400;
begin
  Result := TRegistroC400(Inherited Items[Index]);
end;

function TRegistroC400List.New: TRegistroC400;
begin
  Result := TRegistroC400.Create;
  Add(Result);
end;

procedure TRegistroC400List.SetItem(Index: Integer; const Value: TRegistroC400);
begin
  Put(Index, Value);
end;

{ TRegistroC405List }

destructor TRegistroC405List.Destroy;
var
intFor: integer;
begin
  for intFor := 0 to Count - 1 do Items[intFor].Free;
  inherited;
end;

function TRegistroC405List.GetItem(Index: Integer): TRegistroC405;
begin
  Result := TRegistroC405(Inherited Items[Index]);
end;

function TRegistroC405List.New: TRegistroC405;
begin
  Result := TRegistroC405.Create;
  Add(Result);
end;

procedure TRegistroC405List.SetItem(Index: Integer; const Value: TRegistroC405);
begin
  Put(Index, Value);
end;

{ TRegistroC410List }

destructor TRegistroC410List.Destroy;
var
intFor: integer;
begin
  for intFor := 0 to Count - 1 do Items[intFor].Free;
  inherited;
end;

function TRegistroC410List.GetItem(Index: Integer): TRegistroC410;
begin
  Result := TRegistroC410(Inherited Items[Index]);
end;

function TRegistroC410List.New: TRegistroC410;
begin
  Result := TRegistroC410.Create;
  Add(Result);
end;

procedure TRegistroC410List.SetItem(Index: Integer; const Value: TRegistroC410);
begin
  Put(Index, Value);
end;

{ TRegistroC420List }

destructor TRegistroC420List.Destroy;
var
intFor: integer;
begin
  for intFor := 0 to Count - 1 do Items[intFor].Free;
  inherited;
end;

function TRegistroC420List.GetItem(Index: Integer): TRegistroC420;
begin
  Result := TRegistroC420(Inherited Items[Index]);
end;

function TRegistroC420List.New: TRegistroC420;
begin
  Result := TRegistroC420.Create;
  Add(Result);
end;

procedure TRegistroC420List.SetItem(Index: Integer; const Value: TRegistroC420);
begin
  Put(Index, Value);
end;

{ TRegistroC425List }

destructor TRegistroC425List.Destroy;
var
intFor: integer;
begin
  for intFor := 0 to Count - 1 do Items[intFor].Free;
  inherited;
end;

function TRegistroC425List.GetItem(Index: Integer): TRegistroC425;
begin
  Result := TRegistroC425(Inherited Items[Index]);
end;

function TRegistroC425List.New: TRegistroC425;
begin
  Result := TRegistroC425.Create;
  Add(Result);
end;

procedure TRegistroC425List.SetItem(Index: Integer; const Value: TRegistroC425);
begin
  Put(Index, Value);
end;

{ TRegistroC460List }

destructor TRegistroC460List.Destroy;
var
intFor: integer;
begin
  for intFor := 0 to Count - 1 do Items[intFor].Free;
  inherited;
end;

function TRegistroC460List.GetItem(Index: Integer): TRegistroC460;
begin
  Result := TRegistroC460(Inherited Items[Index]);
end;

function TRegistroC460List.New: TRegistroC460;
begin
  Result := TRegistroC460.Create;
  Add(Result);
end;

procedure TRegistroC460List.SetItem(Index: Integer; const Value: TRegistroC460);
begin
  Put(Index, Value);
end;

{ TRegistroC470List }

destructor TRegistroC470List.Destroy;
var
intFor: integer;
begin
  for intFor := 0 to Count - 1 do Items[intFor].Free;
  inherited;
end;

function TRegistroC470List.GetItem(Index: Integer): TRegistroC470;
begin
  Result := TRegistroC470(Inherited Items[Index]);
end;

function TRegistroC470List.New: TRegistroC470;
begin
  Result := TRegistroC470.Create;
  Add(Result);
end;

procedure TRegistroC470List.SetItem(Index: Integer; const Value: TRegistroC470);
begin
  Put(Index, Value);
end;

{ TRegistroC490List }

destructor TRegistroC490List.Destroy;
var
intFor: integer;
begin
  for intFor := 0 to Count - 1 do Items[intFor].Free;
  inherited;
end;

function TRegistroC490List.GetItem(Index: Integer): TRegistroC490;
begin
  Result := TRegistroC490(Inherited Items[Index]);
end;

function TRegistroC490List.New: TRegistroC490;
begin
  Result := TRegistroC490.Create;
  Add(Result);
end;

procedure TRegistroC490List.SetItem(Index: Integer; const Value: TRegistroC490);
begin
  Put(Index, Value);
end;

{ TRegistroC495List }

destructor TRegistroC495List.Destroy;
var
intFor: integer;
begin
  for intFor := 0 to Count - 1 do Items[intFor].Free;
  inherited;
end;

function TRegistroC495List.GetItem(Index: Integer): TRegistroC495;
begin
  Result := TRegistroC495(Inherited Items[Index]);
end;

function TRegistroC495List.New: TRegistroC495;
begin
  Result := TRegistroC495.Create;
  Add(Result);
end;

procedure TRegistroC495List.SetItem(Index: Integer; const Value: TRegistroC495);
begin
  Put(Index, Value);
end;

{ TRegistroC500List }

destructor TRegistroC500List.Destroy;
var
intFor: integer;
begin
  for intFor := 0 to Count - 1 do Items[intFor].Free;
  inherited;
end;

function TRegistroC500List.GetItem(Index: Integer): TRegistroC500;
begin
  Result := TRegistroC500(Inherited Items[Index]);
end;

function TRegistroC500List.New: TRegistroC500;
begin
  Result := TRegistroC500.Create;
  Add(Result);
end;

procedure TRegistroC500List.SetItem(Index: Integer; const Value: TRegistroC500);
begin
  Put(Index, Value);
end;

{ TRegistroC510List }

destructor TRegistroC510List.Destroy;
var
intFor: integer;
begin
  for intFor := 0 to Count - 1 do Items[intFor].Free;
  inherited;
end;

function TRegistroC510List.GetItem(Index: Integer): TRegistroC510;
begin
  Result := TRegistroC510(Inherited Items[Index]);
end;

function TRegistroC510List.New: TRegistroC510;
begin
  Result := TRegistroC510.Create;
  Add(Result);
end;

procedure TRegistroC510List.SetItem(Index: Integer; const Value: TRegistroC510);
begin
  Put(Index, Value);
end;

{ TRegistroC590List }

destructor TRegistroC590List.Destroy;
var
intFor: integer;
begin
  for intFor := 0 to Count - 1 do Items[intFor].Free;
  inherited;
end;

function TRegistroC590List.GetItem(Index: Integer): TRegistroC590;
begin
  Result := TRegistroC590(Inherited Items[Index]);
end;

function TRegistroC590List.New: TRegistroC590;
begin
  Result := TRegistroC590.Create;
  Add(Result);
end;

procedure TRegistroC590List.SetItem(Index: Integer; const Value: TRegistroC590);
begin
  Put(Index, Value);
end;

{ TRegistroC600List }

destructor TRegistroC600List.Destroy;
var
intFor: integer;
begin
  for intFor := 0 to Count - 1 do Items[intFor].Free;
  inherited;
end;

function TRegistroC600List.GetItem(Index: Integer): TRegistroC600;
begin
  Result := TRegistroC600(Inherited Items[Index]);
end;

function TRegistroC600List.New: TRegistroC600;
begin
  Result := TRegistroC600.Create;
  Add(Result);
end;

procedure TRegistroC600List.SetItem(Index: Integer; const Value: TRegistroC600);
begin
  Put(Index, Value);
end;

{ TRegistroC601List }

destructor TRegistroC601List.Destroy;
var
intFor: integer;
begin
  for intFor := 0 to Count - 1 do Items[intFor].Free;
  inherited;
end;

function TRegistroC601List.GetItem(Index: Integer): TRegistroC601;
begin
  Result := TRegistroC601(Inherited Items[Index]);
end;

function TRegistroC601List.New: TRegistroC601;
begin
  Result := TRegistroC601.Create;
  Add(Result);
end;

procedure TRegistroC601List.SetItem(Index: Integer; const Value: TRegistroC601);
begin
  Put(Index, Value);
end;

{ TRegistroC610List }

destructor TRegistroC610List.Destroy;
var
intFor: integer;
begin
  for intFor := 0 to Count - 1 do Items[intFor].Free;
  inherited;
end;

function TRegistroC610List.GetItem(Index: Integer): TRegistroC610;
begin
  Result := TRegistroC610(Inherited Items[Index]);
end;

function TRegistroC610List.New: TRegistroC610;
begin
  Result := TRegistroC610.Create;
  Add(Result);
end;

procedure TRegistroC610List.SetItem(Index: Integer; const Value: TRegistroC610);
begin
  Put(Index, Value);
end;

{ TRegistroC620List }

destructor TRegistroC620List.Destroy;
var
intFor: integer;
begin
  for intFor := 0 to Count - 1 do Items[intFor].Free;
  inherited;
end;

function TRegistroC620List.GetItem(Index: Integer): TRegistroC620;
begin
  Result := TRegistroC620(Inherited Items[Index]);
end;

function TRegistroC620List.New: TRegistroC620;
begin
  Result := TRegistroC620.Create;
  Add(Result);
end;

procedure TRegistroC620List.SetItem(Index: Integer; const Value: TRegistroC620);
begin
  Put(Index, Value);
end;

{ TRegistroC690List }

destructor TRegistroC690List.Destroy;
var
intFor: integer;
begin
  for intFor := 0 to Count - 1 do Items[intFor].Free;
  inherited;
end;

function TRegistroC690List.GetItem(Index: Integer): TRegistroC690;
begin
  Result := TRegistroC690(Inherited Items[Index]);
end;

function TRegistroC690List.New: TRegistroC690;
begin
  Result := TRegistroC690.Create;
  Add(Result);
end;

procedure TRegistroC690List.SetItem(Index: Integer; const Value: TRegistroC690);
begin
  Put(Index, Value);
end;

{ TRegistroC700List }

destructor TRegistroC700List.Destroy;
var
intFor: integer;
begin
  for intFor := 0 to Count - 1 do Items[intFor].Free;
  inherited;
end;

function TRegistroC700List.GetItem(Index: Integer): TRegistroC700;
begin
  Result := TRegistroC700(Inherited Items[Index]);
end;

function TRegistroC700List.New: TRegistroC700;
begin
  Result := TRegistroC700.Create;
  Add(Result);
end;

procedure TRegistroC700List.SetItem(Index: Integer; const Value: TRegistroC700);
begin
  Put(Index, Value);
end;

{ TRegistroC790List }

destructor TRegistroC790List.Destroy;
var
intFor: integer;
begin
  for intFor := 0 to Count - 1 do Items[intFor].Free;
  inherited;
end;

function TRegistroC790List.GetItem(Index: Integer): TRegistroC790;
begin
  Result := TRegistroC790(Inherited Items[Index]);
end;

function TRegistroC790List.New: TRegistroC790;
begin
  Result := TRegistroC790.Create;
  Add(Result);
end;

procedure TRegistroC790List.SetItem(Index: Integer; const Value: TRegistroC790);
begin
  Put(Index, Value);
end;

{ TRegistroC791List }

destructor TRegistroC791List.Destroy;
var
intFor: integer;
begin
  for intFor := 0 to Count - 1 do Items[intFor].Free;
  inherited;
end;

function TRegistroC791List.GetItem(Index: Integer): TRegistroC791;
begin
  Result := TRegistroC791(Inherited Items[Index]);
end;

function TRegistroC791List.New: TRegistroC791;
begin
  Result := TRegistroC791.Create;
  Add(Result);
end;

procedure TRegistroC791List.SetItem(Index: Integer; const Value: TRegistroC791);
begin
  Put(Index, Value);
end;

{ TRegistroC100 }

constructor TRegistroC100.Create;
begin
  FRegistroC110 := TRegistroC110List.Create;  /// BLOCO C - Lista de RegistroC110 (FILHO)
  FRegistroC140 := TRegistroC140List.Create;  /// BLOCO C - Lista de RegistroC140 (FILHO)
  FRegistroC170 := TRegistroC170List.Create;  /// BLOCO C - Lista de RegistroC170 (FILHO)
  FRegistroC190 := TRegistroC190List.Create;  /// BLOCO C - Lista de RegistroC190 (FILHO) {Jean Barreiros 19Nov2009}
end;

destructor TRegistroC100.Destroy;
begin
  FRegistroC110.Free;
  FRegistroC140.Free;
  FRegistroC170.Free;
  FRegistroC190.Free;
  inherited;
end;

{ TRegistroC110 }

constructor TRegistroC110.Create;
begin
  FRegistroC111 := TRegistroC111List.Create;  /// BLOCO C - Lista de RegistroC111 (FILHO fo FILHO)
end;

destructor TRegistroC110.Destroy;
begin
  FRegistroC111.Free;
  inherited;
end;

{ TRegistroC140 }

constructor TRegistroC140.Create;
begin
  FRegistroC141 := TRegistroC141List.Create; // BLOCO C - Lista de Registro (FILHO do FILHO)
end;

destructor TRegistroC140.Destroy;
begin
  FRegistroC141.Free;
  inherited;
end;

end.
