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

unit ACBrBloco_E;

interface

uses
  SysUtils, Classes, DateUtils, ACBrBlocos;

type
  /// Registro E001 - ABERTURA DO BLOCO E

  TRegistroE001 = class(TOpenBlocos)
  private
  public
  end;

  /// Registro E100 - PERÍODO DA APURAÇÃO DO ICMS

  TRegistroE100 = class(TPersistent)
  private
    fDT_INI: TDateTime;       /// Data inicial a que a apuração se refere:
    fDT_FIN: TDateTime;       /// Data final a que a apuração se refere:
  public
    property DT_INI: TDateTime read FDT_INI write FDT_INI;
    property DT_FIN: TDateTime read FDT_FIN write FDT_FIN;
  end;

  /// Registro E110 - APURAÇÃO DO ICMS - OPERAÇÕES PRÓPRIAS

  TRegistroE110 = class(TPersistent)
  private
    fVL_TOT_DEBITOS: Currency;            /// Valor total dos débitos por "Saídas e prestações com débito do imposto"
    fVL_AJ_DEBITOS: Currency;             /// Valor total dos ajustes a débito decorrentes do documento fiscal.
    fVL_TOT_AJ_DEBITOS: Currency;         /// Valor total de "Ajustes a débito"
    fVL_ESTORNOS_CRED: Currency;          /// Valor total de Ajustes “Estornos de créditos”
    fVL_TOT_CREDITOS: Currency;           /// Valor total dos créditos por "Entradas e aquisições com crédito do imposto"
    fVL_AJ_CREDITOS: Currency;            /// Valor total dos ajustes a crédito decorrentes do documento fiscal.
    fVL_TOT_AJ_CREDITOS: Currency;        /// Valor total de "Ajustes a crédito"
    fVL_ESTORNOS_DEB: Currency;           /// Valor total de Ajustes “Estornos de Débitos”
    fVL_SLD_CREDOR_ANT: Currency;         /// Valor total de "Saldo credor do período anterior"
    fVL_SLD_APURADO: Currency;            /// Valor total de "Saldo devedor (02+03+04+05-06-07-08-09-10) antes das deduções"
    fVL_TOT_DED: Currency;                /// Valor total de "Deduções"
    fVL_ICMS_RECOLHER: Currency;          /// Valor total de "ICMS a recolher (11-12)
    fVL_SLD_CREDOR_TRANSPORTAR: Currency; /// Valor total de "Saldo credor a transportar para o período seguinte”
    fDEB_ESP: Currency;                   /// Valores recolhidos ou a recolher, extra-apuração.
  public
    property VL_TOT_DEBITOS: Currency read fVL_TOT_DEBITOS write fVL_TOT_DEBITOS;
    property VL_AJ_DEBITOS: Currency read fVL_AJ_DEBITOS write fVL_AJ_DEBITOS;
    property VL_TOT_AJ_DEBITOS: Currency read fVL_TOT_AJ_DEBITOS write fVL_TOT_AJ_DEBITOS;
    property VL_ESTORNOS_CRED: Currency read fVL_ESTORNOS_CRED write fVL_ESTORNOS_CRED;
    property VL_TOT_CREDITOS: Currency read fVL_TOT_CREDITOS write fVL_TOT_CREDITOS;
    property VL_AJ_CREDITOS: Currency read fVL_AJ_CREDITOS write fVL_AJ_CREDITOS;
    property VL_TOT_AJ_CREDITOS: Currency read fVL_TOT_AJ_CREDITOS write fVL_TOT_AJ_CREDITOS;
    property VL_ESTORNOS_DEB: Currency read fVL_ESTORNOS_DEB write fVL_ESTORNOS_DEB;
    property VL_SLD_CREDOR_ANT: Currency read fVL_SLD_CREDOR_ANT write fVL_SLD_CREDOR_ANT;
    property VL_SLD_APURADO: Currency read fVL_SLD_APURADO write fVL_SLD_APURADO;
    property VL_TOT_DED: Currency read fVL_TOT_DED write fVL_TOT_DED;
    property VL_ICMS_RECOLHER: Currency read fVL_ICMS_RECOLHER write fVL_ICMS_RECOLHER;
    property VL_SLD_CREDOR_TRANSPORTAR: Currency read fVL_SLD_CREDOR_TRANSPORTAR write fVL_SLD_CREDOR_TRANSPORTAR;
    property DEB_ESP: Currency read fDEB_ESP write fDEB_ESP;
  end;

  /// Registro E111 - AJUSTE/BENEFÍCIO/INCENTIVO DA APURAÇÃO DO ICMS

  TRegistroE111 = class(TPersistent)
  private
    fCOD_AJ_APUR: AnsiString;     /// Código do ajuste da apuração e dedução, conforme a Tabela indicada no item 5.1.1.
    fDESCR_COMPL_AJ: AnsiString;  /// Descrição complementar do ajuste da apuração.
    fVL_AJ_APUR: currency;    /// Valor do ajuste da apuração
  public
    property COD_AJ_APUR: AnsiString read fCOD_AJ_APUR write fCOD_AJ_APUR;
    property DESCR_COMPL_AJ: AnsiString read fDESCR_COMPL_AJ write fDESCR_COMPL_AJ;
    property VL_AJ_APUR: currency read fVL_AJ_APUR write fVL_AJ_APUR;
  end;

  /// Registro E111 - Lista

  TRegistroE111List = class(TList)
  private
    function GetItem(Index: Integer): TRegistroE111; /// GetItem
    procedure SetItem(Index: Integer; const Value: TRegistroE111); /// SetItem
  public
    destructor Destroy; override;
    function New: TRegistroE111;
    property Items[Index: Integer]: TRegistroE111 read GetItem write SetItem;
  end;

  /// Registro E112 - INFORMAÇÕES ADICIONAIS DOS AJUSTES DA APURAÇÃO DO ICMS

  TRegistroE112 = class(TPersistent)
  private
    fNUM_DA: AnsiString;    /// Número do documento de arrecadação estadual, se houver
    fNUM_PROC: AnsiString;  /// Número do processo ao qual o ajuste está vinculado, se houver
    fIND_PROC: AnsiString;  /// Indicador da origem do processo: 0- Sefaz; 1- Justiça Federal; 2- Justiça Estadual; 9- Outros
    fPROC: AnsiString;      /// Descrição resumida do processo que embasou o lançamento
    fTXT_COMPL: AnsiString;   /// Código de referência à observação (campo 02 do Registro 0460)
  public
    property NUM_DA: AnsiString read fNUM_DA write fNUM_DA;
    property NUM_PROC: AnsiString read fNUM_PROC write fNUM_PROC;
    property IND_PROC: AnsiString read fIND_PROC write fIND_PROC;
    property PROC: AnsiString read fPROC write fPROC;
    property TXT_COMPL: AnsiString read fTXT_COMPL write fTXT_COMPL;
  end;

  /// Registro E112 - Lista

  TRegistroE112List = class(TList)
  private
    function GetItem(Index: Integer): TRegistroE112; /// GetItem
    procedure SetItem(Index: Integer; const Value: TRegistroE112); /// SetItem
  public
    destructor Destroy; override;
    function New: TRegistroE112;
    property Items[Index: Integer]: TRegistroE112 read GetItem write SetItem;
  end;

  /// Registro E113 - INFORMAÇÕES ADICIONAIS DOS AJUSTES DA APURAÇÃO DO ICMS - IDENTIFICAÇÃO DOS DOCUMENTOS FISCAIS

  TRegistroE113 = class(TPersistent)
  private
    fCOD_PART: AnsiString;        /// Código do participante (campo 02 do Registro 0150): Do emitente do documento ou do remetente das mercadorias, no caso de entradas; Do adquirente, no caso de saídas
    fCOD_MOD: AnsiString;         /// Código do modelo do documento fiscal, conforme a Tabela 4.1.1
    fSER: AnsiString;             /// Série do documento fiscal
    fSUB: AnsiString;             /// Subserie do documento fiscal
    fNUM_DOC: AnsiString;         /// Número do documento fiscal
    fDT_DOC: TDateTime;       /// Data da emissão do documento fiscal
    fCHV_NFE: AnsiString;         /// Chave da Nota Fiscal Eletrônica
    fCOD_ITEM: AnsiString;        /// Código do item (campo 02 do Registro 0200)
    fVL_AJ_ITEM: currency;    /// Valor do ajuste para a operação/item
  public
    property COD_PART: AnsiString read fCOD_PART write fCOD_PART;
    property COD_MOD: AnsiString read fCOD_MOD write fCOD_MOD;
    property SER: AnsiString read fSER write fSER;
    property SUB: AnsiString read fSUB write fSUB;
    property NUM_DOC: AnsiString read fNUM_DOC write fNUM_DOC;
    property DT_DOC: TDateTime read fDT_DOC write fDT_DOC;
    property CHV_NFE: AnsiString read fCHV_NFE write fCHV_NFE;
    property COD_ITEM: AnsiString read fCOD_ITEM write fCOD_ITEM;
    property VL_AJ_ITEM: currency read fVL_AJ_ITEM write fVL_AJ_ITEM;
  end;

  /// Registro E113 - Lista

  TRegistroE113List = class(TList)
  private
    function GetItem(Index: Integer): TRegistroE113; /// GetItem
    procedure SetItem(Index: Integer; const Value: TRegistroE113); /// SetItem
  public
    destructor Destroy; override;
    function New: TRegistroE113;
    property Items[Index: Integer]: TRegistroE113 read GetItem write SetItem;
  end;

  /// Registro E115 - INFORMAÇÕES ADICIONAIS DA APURAÇÃO - VALORES DECLARATÓRIOS.

  TRegistroE115 = class(TPersistent)
  private
    fCOD_INF_ADIC: AnsiString;    /// Código da informação adicional conforme tabela a ser definida pelas SEFAZ, conforme tabela definida no item 5.2.
    fVL_INF_ADIC: currency;   /// Valor referente à informação adicional
    fDESCR_COMPL_AJ: AnsiString;  /// Descrição complementar do ajuste
  public
    property COD_INF_ADIC: AnsiString read fCOD_INF_ADIC write fCOD_INF_ADIC;
    property VL_INF_ADIC: currency read fVL_INF_ADIC write fVL_INF_ADIC;
    property DESCR_COMPL_AJ: AnsiString read fDESCR_COMPL_AJ write fDESCR_COMPL_AJ;
  end;

  /// Registro E115 - Lista

  TRegistroE115List = class(TList)
  private
    function GetItem(Index: Integer): TRegistroE115; /// GetItem
    procedure SetItem(Index: Integer; const Value: TRegistroE115); /// SetItem
  public
    destructor Destroy; override;
    function New: TRegistroE115;
    property Items[Index: Integer]: TRegistroE115 read GetItem write SetItem;
  end;

  /// Registro E116 - OBRIGAÇÕES DO ICMS A RECOLHER - OPERAÇÕES PRÓPRIAS

  TRegistroE116 = class(TPersistent)
  private
    fCOD_OR: AnsiString;       /// Código da obrigação a recolher, conforme a Tabela 5.4
    fVL_OR: currency;      /// Valor da obrigação a recolher
    fDT_VCTO: TDateTime;   /// Data de vencimento da obrigação
    fCOD_REC: AnsiString;      /// Código de receita referente à obrigação, próprio da unidade da federação, conforme legislação estadual,
    fNUM_PROC: AnsiString;     /// Número do processo ou auto de infração ao qual a obrigação está vinculada, se houver.
    fIND_PROC: AnsiString;     /// Indicador da origem do processo: 0- Sefaz; 1- Justiça Federal; 2- Justiça Estadual; 9- Outros
    fPROC: AnsiString;         /// Descrição resumida do processo que embasou o lançamento
    fTXT_COMPL: AnsiString;    /// Descrição complementar das obrigações a recolher.
  public
    property COD_OR: AnsiString read fCOD_OR write fCOD_OR;
    property VL_OR: currency read fVL_OR write fVL_OR;
    property DT_VCTO: TDateTime read fDT_VCTO write fDT_VCTO;
    property COD_REC: AnsiString read fCOD_REC write fCOD_REC;
    property NUM_PROC: AnsiString read fNUM_PROC write fNUM_PROC;
    property IND_PROC: AnsiString read fIND_PROC write fIND_PROC;
    property PROC: AnsiString read fPROC write fPROC;
    property TXT_COMPL: AnsiString read fTXT_COMPL write fTXT_COMPL;
  end;

  /// Registro E116 - Lista

  TRegistroE116List = class(TList)
  private
    function GetItem(Index: Integer): TRegistroE116; /// GetItem
    procedure SetItem(Index: Integer; const Value: TRegistroE116); /// SetItem
  public
    destructor Destroy; override;
    function New: TRegistroE116;
    property Items[Index: Integer]: TRegistroE116 read GetItem write SetItem;
  end;

  /// Registro E200 - PERÍODO DA APURAÇÃO DO ICMS - SUBSTITUIÇÃO TRIBUTÁRIA

  TRegistroE200 = class(TPersistent)
  private
    fUF: AnsiString;        /// Sigla da unidade da federação a que se refere a apuração do ICMS ST
    fDT_INI: TDateTime; /// Data inicial a que a apuração se refere
    fDT_FIN: TDateTime; /// Data final a que a apuração se refere
  public
    property UF: AnsiString read fUF write fUF;
    property DT_INI: TDateTime read fDT_INI write fDT_INI;
    property DT_FIN: TDateTime read fDT_FIN write fDT_FIN;
  end;

  TRegistroE200List = class(TList)
  private
    function  GetItem(Index: Integer): TRegistroE200;              /// GetItem
    procedure SetItem(Index: Integer; const Value: TRegistroE200); /// SetItem
  public
    destructor Destroy; override;
    function New: TRegistroE200;
    property Items[Index: Integer]: TRegistroE200 read GetItem write SetItem;
  end;

  /// Registro E210 - APURAÇÃO DO ICMS - SUBSTITUIÇÃO TRIBUTÁRIA

  TRegistroE210 = class(TPersistent)
  private
    fIND_MOV_ST: AnsiString;                     /// Indicador de movimento: 0 - Sem operações com ST 1 - Com operações de ST
    fVL_SLD_CRED_ANT_ST: currency;           /// Valor do "Saldo credor de período anterior - Substituição Tributária"
    fVL_DEVOL_ST: currency;                  /// Valor total do ICMS ST de devolução de mercadorias
    fVL_RESSARC_ST: currency;                /// Valor total do ICMS ST de ressarcimentos
    fVL_OUT_CRED_ST: currency;               /// Valor total de Ajustes "Outros créditos ST" e “Estorno de débitos ST”
    fVL_AJ_CREDITOS_ST: currency;            /// Valor total dos ajustes a crédito de ICMS ST, provenientes de ajustes do documento fiscal.
    fVL_RETENCAO_ST: currency;               /// Valor Total do ICMS retido por Substituição Tributária
    fVL_OUT_DEB_ST: currency;                /// Valor Total dos ajustes "Outros débitos ST" " e “Estorno de créditos ST”
    fVL_AJ_DEBITOS_ST: currency;             /// Valor total dos ajustes a débito de ICMS ST, provenientes de ajustes do documento fiscal.
    fVL_SLD_DEV_ANT_ST: currency;            /// Valor total de "Saldo devedor antes das deduções" = (08+09+10)-(03+04+05+06+07)]
    fVL_DEDUCOES_ST: currency;               /// Valor total dos ajustes "Deduções ST"
    fVL_ICMS_RECOL_ST: currency;             /// Imposto a recolher ST (11-12)
    fVL_SLD_CRED_ST_TRANSPORTAR: currency;   /// Saldo credor de ST a transportar para o período seguinte [(03+04+05+06+07)- (08+09+10)].
    fDEB_ESP_ST: currency;                   /// Valores recolhidos ou a recolher, extra-apuração.
  public
    property IND_MOV_ST: AnsiString read fIND_MOV_ST write fIND_MOV_ST;
    property VL_SLD_CRED_ANT_ST: currency read fVL_SLD_CRED_ANT_ST write fVL_SLD_CRED_ANT_ST;
    property VL_DEVOL_ST: currency read fVL_DEVOL_ST write fVL_DEVOL_ST;
    property VL_RESSARC_ST: currency read fVL_RESSARC_ST write fVL_RESSARC_ST;
    property VL_OUT_CRED_ST: currency read fVL_OUT_CRED_ST write fVL_OUT_CRED_ST;
    property VL_AJ_CREDITOS_ST: currency read fVL_AJ_CREDITOS_ST write fVL_AJ_CREDITOS_ST;
    property VL_RETENCAO_ST: currency read fVL_RETENCAO_ST write fVL_RETENCAO_ST;
    property VL_OUT_DEB_ST: currency read fVL_OUT_DEB_ST write fVL_OUT_DEB_ST;
    property VL_AJ_DEBITOS_ST: currency read fVL_AJ_DEBITOS_ST write fVL_AJ_DEBITOS_ST;
    property VL_SLD_DEV_ANT_ST: currency read fVL_SLD_DEV_ANT_ST write fVL_SLD_DEV_ANT_ST;
    property VL_DEDUCOES_ST: currency read fVL_DEDUCOES_ST write fVL_DEDUCOES_ST;
    property VL_ICMS_RECOL_ST: currency read fVL_ICMS_RECOL_ST write fVL_ICMS_RECOL_ST;
    property VL_SLD_CRED_ST_TRANSPORTAR: currency read fVL_SLD_CRED_ST_TRANSPORTAR write fVL_SLD_CRED_ST_TRANSPORTAR;
    property DEB_ESP_ST: currency read fDEB_ESP_ST write fDEB_ESP_ST;
  end;

  /// Registro E210 - Lista

  TRegistroE210List = class(TList)
  private
    function GetItem(Index: Integer): TRegistroE210; /// GetItem
    procedure SetItem(Index: Integer; const Value: TRegistroE210); /// SetItem
  public
    destructor Destroy; override;
    function New: TRegistroE210;
    property Items[Index: Integer]: TRegistroE210 read GetItem write SetItem;
  end;

  /// Registro E220 - AJUSTE/BENEFÍCIO/INCENTIVO DA APURAÇÃO DO ICMS SUBSTITUIÇÃO TRIBUTÁRIA

  TRegistroE220 = class(TPersistent)
  private
    fCOD_AJ_APUR: AnsiString;     /// Código do ajuste da apuração e dedução, conforme a Tabela indicada no item 5.1.1
    fDESCR_COMPL_AJ: AnsiString;  /// Descrição complementar do ajuste da apuração
    fVL_AJ_APUR: currency;    /// Valor do ajuste da apuração
  public
    property COD_AJ_APUR: AnsiString read fCOD_AJ_APUR write fCOD_AJ_APUR;
    property DESCR_COMPL_AJ: AnsiString read fDESCR_COMPL_AJ write fDESCR_COMPL_AJ;
    property VL_AJ_APUR: currency read fVL_AJ_APUR write fVL_AJ_APUR;
  end;

  /// Registro E220 - Lista

  TRegistroE220List = class(TList)
  private
    function GetItem(Index: Integer): TRegistroE220; /// GetItem
    procedure SetItem(Index: Integer; const Value: TRegistroE220); /// SetItem
  public
    destructor Destroy; override;
    function New: TRegistroE220;
    property Items[Index: Integer]: TRegistroE220 read GetItem write SetItem;
  end;

  /// Registro E230 - INFORMAÇÕES ADICIONAIS DOS AJUSTES DA APURAÇÃO DO ICMS SUBSTITUIÇÃO TRIBUTÁRIA

  TRegistroE230 = class(TPersistent)
  private
    fNUM_DA: AnsiString;    /// Número do documento de arrecadação estadual, se houver
    fNUM_PROC: AnsiString;  /// Número do processo ao qual o ajuste está vinculado, se houver
    fIND_PROC: AnsiString;  /// Indicador da origem do processo: 0- Sefaz; 1- Justiça Federal; 2- Justiça Estadual; 9- Outros
    fPROC: AnsiString;      /// Descrição resumida do processo que embasou o lançamento
    fTXT_COMPL: AnsiString;   /// Código de referência à observação (campo 02 do Registro 0460)
  public
    property NUM_DA: AnsiString read fNUM_DA write fNUM_DA;
    property NUM_PROC: AnsiString read fNUM_PROC write fNUM_PROC;
    property IND_PROC: AnsiString read fIND_PROC write fIND_PROC;
    property PROC: AnsiString read fPROC write fPROC;
    property TXT_COMPL: AnsiString read fTXT_COMPL write fTXT_COMPL;
  end;

  /// Registro E230 - Lista

  TRegistroE230List = class(TList)
  private
    function GetItem(Index: Integer): TRegistroE230; /// GetItem
    procedure SetItem(Index: Integer; const Value: TRegistroE230); /// SetItem
  public
    destructor Destroy; override;
    function New: TRegistroE230;
    property Items[Index: Integer]: TRegistroE230 read GetItem write SetItem;
  end;

  /// Registro E240 - INFORMAÇÕES ADICIONAIS DOS AJUSTES DA APURAÇÃO DO ICMS SUBSTITUIÇÃO TRIBUTÁRIA - IDENTIFICAÇÃO DOS DOCUMENTOS FISCAIS

  TRegistroE240 = class(TPersistent)
  private
    fCOD_PART: AnsiString;     /// Código do participante (campo 02 do Registro 0150): Do emitente do documento ou do remetente das mercadorias, no caso de entradas; Do adquirente, no caso de saídas
    fCOD_MOD: AnsiString;      /// Código do modelo do documento fiscal, conforme a Tabela 4.1.1
    fSER: AnsiString;          /// Série do documento fiscal
    fSUB: AnsiString;          /// Subserie do documento fiscal
    fNUM_DOC: AnsiString;      /// Número do documento fiscal
    fDT_DOC: TDateTime;    /// Data da emissão do documento fiscal
    fCHV_NFE: AnsiString;      /// Chave da Nota Fiscal Eletrônica
    fCOD_ITEM: AnsiString;     /// Código do item (campo 02 do Registro 0200)
    fVL_AJ_ITEM: currency; /// Valor do ajuste para a operação/item
  public
    property COD_PART: AnsiString read fCOD_PART write fCOD_PART;
    property COD_MOD: AnsiString read fCOD_MOD write fCOD_MOD;
    property SER: AnsiString read fSER write fSER;
    property SUB: AnsiString read fSUB write fSUB;
    property NUM_DOC: AnsiString read fNUM_DOC write fNUM_DOC;
    property DT_DOC: TDateTime read fDT_DOC write fDT_DOC;
    property CHV_NFE: AnsiString read fCHV_NFE write fCHV_NFE;
    property COD_ITEM: AnsiString read fCOD_ITEM write fCOD_ITEM;
    property VL_AJ_ITEM: currency read fVL_AJ_ITEM write fVL_AJ_ITEM;
  end;

  /// Registro E240 - Lista

  TRegistroE240List = class(TList)
  private
    function GetItem(Index: Integer): TRegistroE240; /// GetItem
    procedure SetItem(Index: Integer; const Value: TRegistroE240); /// SetItem
  public
    destructor Destroy; override;
    function New: TRegistroE240;
    property Items[Index: Integer]: TRegistroE240 read GetItem write SetItem;
  end;

  /// Registro E250 - OBRIGAÇÕES DO ICMS A RECOLHER - SUBSTITUIÇÃO TRIBUTÁRIA

  TRegistroE250 = class(TPersistent)
  private
    fCOD_OR: AnsiString;       /// Código da obrigação a recolher, conforme a Tabela 5.4
    fVL_OR: currency;      /// Valor da obrigação ICMS ST a recolher
    fDT_VCTO: TDateTime;   /// Data de vencimento da obrigação
    fCOD_REC: AnsiString;      /// Código de receita referente à obrigação, próprio da unidade da federação
    fNUM_PROC: AnsiString;     /// Número do processo ou auto de infração ao qual a obrigação está vinculada, se houver
    fIND_PROC: AnsiString;     /// Indicador da origem do processo: 0- Sefaz; 1- Justiça Federal; 2- Justiça Estadual; 9- Outros
    fPROC: AnsiString;         /// Descrição resumida do processo que embasou o lançamento
    fTXT_COMPL: AnsiString;    /// Descrição complementar das obrigações a recolher
  public
    property COD_OR: AnsiString read fCOD_OR write fCOD_OR;
    property VL_OR: currency read fVL_OR write fVL_OR;
    property DT_VCTO: TDateTime read fDT_VCTO write fDT_VCTO;
    property COD_REC: AnsiString read fCOD_REC write fCOD_REC;
    property NUM_PROC: AnsiString read fNUM_PROC write fNUM_PROC;
    property IND_PROC: AnsiString read fIND_PROC write fIND_PROC;
    property PROC: AnsiString read fPROC write fPROC;
    property TXT_COMPL: AnsiString read fTXT_COMPL write fTXT_COMPL;
  end;

  /// Registro E250 - Lista

  TRegistroE250List = class(TList)
  private
    function GetItem(Index: Integer): TRegistroE250; /// GetItem
    procedure SetItem(Index: Integer; const Value: TRegistroE250); /// SetItem
  public
    destructor Destroy; override;
    function New: TRegistroE250;
    property Items[Index: Integer]: TRegistroE250 read GetItem write SetItem;
  end;

  /// Registro E500 - PERÍODO DE APURAÇÃO DO IPI

  TRegistroE500 = class(TPersistent)
  private
    fIND_APUR: AnsiString;  /// Indicador de período de apuração do IPI: 0 - Mensal; 1 - Decendial
    fDT_INI: TDateTime; /// Data inicial a que a apuração se refere
    fDT_FIN: TDateTime; /// Data final a que a apuração se refere
  public
    property IND_APUR: AnsiString read fIND_APUR write fIND_APUR;
    property DT_INI: TDateTime read fDT_INI write fDT_INI;
    property DT_FIN: TDateTime read fDT_FIN write fDT_FIN;
  end;

  /// Registro E500 - Lista

  TRegistroE500List = class(TList)
  private
    function GetItem(Index: Integer): TRegistroE500; /// GetItem
    procedure SetItem(Index: Integer; const Value: TRegistroE500); /// SetItem
  public
    destructor Destroy; override;
    function New: TRegistroE500;
    property Items[Index: Integer]: TRegistroE500 read GetItem write SetItem;
  end;

  /// Registro E510 - CONSOLIDAÇÃO DOS VALORES DO IPI

  TRegistroE510 = class(TPersistent)
  private
    fCFOP: AnsiString;            /// Código Fiscal de Operação e Prestação do agrupamento de itens
    fCST_IPI: AnsiString;         /// Código da Situação Tributária referente ao IPI, conforme a Tabela indicada no item 4.3.2.
    fVL_CONT_IPI: currency;   /// Parcela correspondente ao "Valor Contábil" referente ao CFOP e ao Código de Tributação do IPI
    fVL_BC_IPI: currency;     /// Parcela correspondente ao "Valor da base de cálculo do IPI" referente ao CFOP e ao Código de Tributação do IPI, para operações tributadas
    fVL_IPI: currency;        /// Parcela correspondente ao "Valor do IPI" referente ao CFOP e ao Código de Tributação do IPI, para operações tributadas
  public
    property CFOP: AnsiString read fCFOP write fCFOP;
    property CST_IPI: AnsiString read fCST_IPI write fCST_IPI;
    property VL_CONT_IPI: currency read fVL_CONT_IPI write fVL_CONT_IPI;
    property VL_BC_IPI: currency read fVL_BC_IPI write fVL_BC_IPI;
    property VL_IPI: currency read fVL_IPI write fVL_IPI;
  end;

  /// Registro E510 - Lista

  TRegistroE510List = class(TList)
  private
    function GetItem(Index: Integer): TRegistroE510; /// GetItem
    procedure SetItem(Index: Integer; const Value: TRegistroE510); /// SetItem
  public
    destructor Destroy; override;
    function New: TRegistroE510;
    property Items[Index: Integer]: TRegistroE510 read GetItem write SetItem;
  end;

  /// Registro E520 - APURAÇÃO DO IPI

  TRegistroE520 = class(TPersistent)
  private
    fVL_SD_ANT_IPI: currency; /// Saldo credor do IPI transferido do período anterior
    fVL_DEB_IPI: currency;    /// Valor total dos débitos por "Saídas com débito do imposto"
    fVL_CRED_IPI: currency;   /// Valor total dos créditos por "Entradas e aquisições com crédito do imposto"
    fVL_OD_IPI: currency;     /// Valor de "Outros débitos" do IPI (inclusive estornos de crédito)
    fVL_OC_IPI: currency;     /// Valor de "Outros créditos" do IPI (inclusive estornos de débitos)
    fVL_SC_IPI: currency;     /// Valor do saldo credor do IPI a transportar para o período seguinte
    fVL_SD_IPI: currency;     /// Valor do saldo devedor do IPI a recolher
  public
    property VL_SD_ANT_IPI: currency read fVL_SD_ANT_IPI write fVL_SD_ANT_IPI;
    property VL_DEB_IPI: currency read fVL_DEB_IPI write fVL_DEB_IPI;
    property VL_CRED_IPI: currency read fVL_CRED_IPI write fVL_CRED_IPI;
    property VL_OD_IPI: currency read fVL_OD_IPI write fVL_OD_IPI;
    property VL_OC_IPI: currency read fVL_OC_IPI write fVL_OC_IPI;
    property VL_SC_IPI: currency read fVL_SC_IPI write fVL_SC_IPI;
    property VL_SD_IPI: currency read fVL_SD_IPI write fVL_SD_IPI;
  end;

  /// Registro E520 - Lista

  TRegistroE520List = class(TList)
  private
    function GetItem(Index: Integer): TRegistroE520; /// GetItem
    procedure SetItem(Index: Integer; const Value: TRegistroE520); /// SetItem
  public
    destructor Destroy; override;
    function New: TRegistroE520;
    property Items[Index: Integer]: TRegistroE520 read GetItem write SetItem;
  end;

  /// Registro E530 - AJUSTES DA APURAÇÃO DO IPI

  TRegistroE530 = class(TPersistent)
  private
    fIND_AJ: AnsiString;    /// Indicador do tipo de ajuste: 0- Ajuste a débito; 1- Ajuste a crédito
    fVL_AJ: currency;   /// Valor do ajuste
    fCOD_AJ: AnsiString;    /// Código do ajuste da apuração, conforme a Tabela indicada no item 4.5.4.
    fIND_DOC: AnsiString;   /// Indicador da origem do documento vinculado ao ajuste: 0 - Processo Judicial; 1 - Processo Administrativo; 2 - PER/DCOMP; 9 - Outros.
    fNUM_DOC: AnsiString;   /// Número do documento / processo / declaração ao qual o ajuste está vinculado, se houver
    fDESCR_AJ: AnsiString;  /// Descrição resumida do ajuste.
  public
    property IND_AJ: AnsiString read fIND_AJ write fIND_AJ;
    property VL_AJ: currency read fVL_AJ write fVL_AJ;
    property COD_AJ: AnsiString read fCOD_AJ write fCOD_AJ;
    property IND_DOC: AnsiString read fIND_DOC write fIND_DOC;
    property NUM_DOC: AnsiString read fNUM_DOC write fNUM_DOC;
    property DESCR_AJ: AnsiString read fDESCR_AJ write fDESCR_AJ;
  end;

  /// Registro E530 - Lista

  TRegistroE530List = class(TList)
  private
    function GetItem(Index: Integer): TRegistroE530; /// GetItem
    procedure SetItem(Index: Integer; const Value: TRegistroE530); /// SetItem
  public
    destructor Destroy; override;
    function New: TRegistroE530;
    property Items[Index: Integer]: TRegistroE530 read GetItem write SetItem;
  end;

  /// Registro E990 - ENCERRAMENTO DO BLOCO E

  TRegistroE990 = class(TPersistent)
  private
    fQTD_LIN_E: Integer; /// Quantidade total de linhas do Bloco E
  public
    property QTD_LIN_E: Integer read fQTD_LIN_E write fQTD_LIN_E;
  end;


implementation

{ TRegistroE001 }

{ TRegistroE111List }

destructor TRegistroE111List.Destroy;
var
intFor: integer;
begin
  for intFor := 0 to Count - 1 do Items[intFor].Free;
  inherited;
end;

function TRegistroE111List.GetItem(Index: Integer): TRegistroE111;
begin
  Result := TRegistroE111(Inherited Items[Index]);
end;

function TRegistroE111List.New: TRegistroE111;
begin
  Result := TRegistroE111.Create;
  Add(Result);
end;

procedure TRegistroE111List.SetItem(Index: Integer; const Value: TRegistroE111);
begin
  Put(Index, Value);
end;

{ TRegistroE112List }

destructor TRegistroE112List.Destroy;
var
intFor: integer;
begin
  for intFor := 0 to Count - 1 do Items[intFor].Free;
  inherited;
end;

function TRegistroE112List.GetItem(Index: Integer): TRegistroE112;
begin
  Result := TRegistroE112(Inherited Items[Index]);
end;

function TRegistroE112List.New: TRegistroE112;
begin
  Result := TRegistroE112.Create;
  Add(Result);
end;

procedure TRegistroE112List.SetItem(Index: Integer; const Value: TRegistroE112);
begin
  Put(Index, Value);
end;

{ TRegistroE113List }

destructor TRegistroE113List.Destroy;
var
intFor: integer;
begin
  for intFor := 0 to Count - 1 do Items[intFor].Free;
  inherited;
end;

function TRegistroE113List.GetItem(Index: Integer): TRegistroE113;
begin
  Result := TRegistroE113(Inherited Items[Index]);
end;

function TRegistroE113List.New: TRegistroE113;
begin
  Result := TRegistroE113.Create;
  Add(Result);
end;

procedure TRegistroE113List.SetItem(Index: Integer; const Value: TRegistroE113);
begin
  Put(Index, Value);
end;

{ TRegistroE115List }

destructor TRegistroE115List.Destroy;
var
intFor: integer;
begin
  for intFor := 0 to Count - 1 do Items[intFor].Free;
  inherited;
end;

function TRegistroE115List.GetItem(Index: Integer): TRegistroE115;
begin
  Result := TRegistroE115(Inherited Items[Index]);
end;

function TRegistroE115List.New: TRegistroE115;
begin
  Result := TRegistroE115.Create;
  Add(Result);
end;

procedure TRegistroE115List.SetItem(Index: Integer; const Value: TRegistroE115);
begin
  Put(Index, Value);
end;

{ TRegistroE116List }

destructor TRegistroE116List.Destroy;
var
intFor: integer;
begin
  for intFor := 0 to Count - 1 do Items[intFor].Free;
  inherited;
end;

function TRegistroE116List.GetItem(Index: Integer): TRegistroE116;
begin
  Result := TRegistroE116(Inherited Items[Index]);
end;

function TRegistroE116List.New: TRegistroE116;
begin
  Result := TRegistroE116.Create;
  Add(Result);
end;

procedure TRegistroE116List.SetItem(Index: Integer; const Value: TRegistroE116);
begin
  Put(Index, Value);
end;

{ TRegistroE210List }

destructor TRegistroE210List.Destroy;
var
intFor: integer;
begin
  for intFor := 0 to Count - 1 do Items[intFor].Free;
  inherited;
end;

function TRegistroE210List.GetItem(Index: Integer): TRegistroE210;
begin
  Result := TRegistroE210(Inherited Items[Index]);
end;

function TRegistroE210List.New: TRegistroE210;
begin
  Result := TRegistroE210.Create;
  Add(Result);
end;

procedure TRegistroE210List.SetItem(Index: Integer; const Value: TRegistroE210);
begin
  Put(Index, Value);
end;

{ TRegistroE220List }

destructor TRegistroE220List.Destroy;
var
intFor: integer;
begin
  for intFor := 0 to Count - 1 do Items[intFor].Free;
  inherited;
end;

function TRegistroE220List.GetItem(Index: Integer): TRegistroE220;
begin
  Result := TRegistroE220(Inherited Items[Index]);
end;

function TRegistroE220List.New: TRegistroE220;
begin
  Result := TRegistroE220.Create;
  Add(Result);
end;

procedure TRegistroE220List.SetItem(Index: Integer; const Value: TRegistroE220);
begin
  Put(Index, Value);
end;

{ TRegistroE230List }

destructor TRegistroE230List.Destroy;
var
intFor: integer;
begin
  for intFor := 0 to Count - 1 do Items[intFor].Free;
  inherited;
end;

function TRegistroE230List.GetItem(Index: Integer): TRegistroE230;
begin
  Result := TRegistroE230(Inherited Items[Index]);
end;

function TRegistroE230List.New: TRegistroE230;
begin
  Result := TRegistroE230.Create;
  Add(Result);
end;

procedure TRegistroE230List.SetItem(Index: Integer; const Value: TRegistroE230);
begin
  Put(Index, Value);
end;

{ TRegistroE240List }

destructor TRegistroE240List.Destroy;
var
intFor: integer;
begin
  for intFor := 0 to Count - 1 do Items[intFor].Free;
  inherited;
end;

function TRegistroE240List.GetItem(Index: Integer): TRegistroE240;
begin
  Result := TRegistroE240(Inherited Items[Index]);
end;

function TRegistroE240List.New: TRegistroE240;
begin
  Result := TRegistroE240.Create;
  Add(Result);
end;

procedure TRegistroE240List.SetItem(Index: Integer; const Value: TRegistroE240);
begin
  Put(Index, Value);
end;

{ TRegistroE250List }

destructor TRegistroE250List.Destroy;
var
intFor: integer;
begin
  for intFor := 0 to Count - 1 do Items[intFor].Free;
  inherited;
end;

function TRegistroE250List.GetItem(Index: Integer): TRegistroE250;
begin
  Result := TRegistroE250(Inherited Items[Index]);
end;

function TRegistroE250List.New: TRegistroE250;
begin
  Result := TRegistroE250.Create;
  Add(Result);
end;

procedure TRegistroE250List.SetItem(Index: Integer; const Value: TRegistroE250);
begin
  Put(Index, Value);
end;

{ TRegistroE500List }

destructor TRegistroE500List.Destroy;
var
intFor: integer;
begin
  for intFor := 0 to Count - 1 do Items[intFor].Free;
  inherited;
end;

function TRegistroE500List.GetItem(Index: Integer): TRegistroE500;
begin
  Result := TRegistroE500(Inherited Items[Index]);
end;

function TRegistroE500List.New: TRegistroE500;
begin
  Result := TRegistroE500.Create;
  Add(Result);
end;

procedure TRegistroE500List.SetItem(Index: Integer; const Value: TRegistroE500);
begin
  Put(Index, Value);
end;

{ TRegistroE510List }

destructor TRegistroE510List.Destroy;
var
intFor: integer;
begin
  for intFor := 0 to Count - 1 do Items[intFor].Free;
  inherited;
end;

function TRegistroE510List.GetItem(Index: Integer): TRegistroE510;
begin
  Result := TRegistroE510(Inherited Items[Index]);
end;

function TRegistroE510List.New: TRegistroE510;
begin
  Result := TRegistroE510.Create;
  Add(Result);
end;

procedure TRegistroE510List.SetItem(Index: Integer; const Value: TRegistroE510);
begin
  Put(Index, Value);
end;

{ TRegistroE520List }

destructor TRegistroE520List.Destroy;
var
intFor: integer;
begin
  for intFor := 0 to Count - 1 do Items[intFor].Free;
  inherited;
end;

function TRegistroE520List.GetItem(Index: Integer): TRegistroE520;
begin
  Result := TRegistroE520(Inherited Items[Index]);
end;

function TRegistroE520List.New: TRegistroE520;
begin
  Result := TRegistroE520.Create;
  Add(Result);
end;

procedure TRegistroE520List.SetItem(Index: Integer; const Value: TRegistroE520);
begin
  Put(Index, Value);
end;

{ TRegistroE530List }

destructor TRegistroE530List.Destroy;
var
intFor: integer;
begin
  for intFor := 0 to Count - 1 do Items[intFor].Free;
  inherited;
end;

function TRegistroE530List.GetItem(Index: Integer): TRegistroE530;
begin
  Result := TRegistroE530(Inherited Items[Index]);
end;

function TRegistroE530List.New: TRegistroE530;
begin
  Result := TRegistroE530.Create;
  Add(Result);
end;

procedure TRegistroE530List.SetItem(Index: Integer; const Value: TRegistroE530);
begin
  Put(Index, Value);
end;

{ TRegistroE200List }

destructor TRegistroE200List.Destroy;
var
intFor: integer;
begin
  for intFor := 0 to Count - 1 do Items[intFor].Free;
  inherited;
end;

function TRegistroE200List.GetItem(Index: Integer): TRegistroE200;
begin
  Result := TRegistroE200(Inherited Items[Index]);
end;

function TRegistroE200List.New: TRegistroE200;
begin
  Result := TRegistroE200.Create;
  Add(Result);
end;

procedure TRegistroE200List.SetItem(Index: Integer; const Value: TRegistroE200 );
begin
  Put(Index, Value);
end;

end.
