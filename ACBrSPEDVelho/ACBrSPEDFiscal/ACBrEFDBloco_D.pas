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

unit ACBrEFDBloco_D;

interface

uses
  SysUtils, Classes, DateUtils, ACBrEFDBlocos;

type
  /// Registro D001 - ABERTURA DO BLOCO D

  TRegistroD001 = class(TOpenBlocos)
  private
  public
  end;

  TRegistroD190List = class; {Márcio Lopes 21Dez2009}
  TRegistroD590List = class; {Jean Barreiros 04Dez2009}

  /// Registro D100 - NOTA FISCAL DE SERVIÇO DE TRANSPORTE (CÓDIGO 07) E CONHECIMENTOS DE TRANSPORTE RODOVIÁRIO DE CARGAS (CÓDIGO 08), AQUAVIÁRIO DE CARGAS (CÓDIGO 09), AÉREO (CÓDIGO 10), FERROVIÁRIO DE CARGAS (CÓDIGO 11) E MULTIMODAL DE CARGAS (CÓDIGO 26) E NOTA FISCAL DE TRANSPORTE FERROVIÁRIO DE CARGA (CÓDIGO 27)

  TRegistroD100 = class(TPersistent)
  private
    fIND_OPER: AnsiString;         /// Indicador do tipo de operação: 0- Aquisição; 1- Prestação
    fIND_EMIT: AnsiString;         /// Indicador do emitente do documento fiscal: 0- Emissão própria; 1- Terceiros
    fCOD_PART: AnsiString;         /// Código do participante (campo 02 do Registro 0150):
    fCOD_MOD: AnsiString;          /// Código do modelo do documento fiscal, conforme a Tabela 4.1.1
    fCOD_SIT: AnsiString;          /// Código da situação do documento fiscal, conforme a Tabela 4.1.2
    fSER: AnsiString;              /// Série do documento fiscal
    fSUB: AnsiString;              /// Subsérie do documento fiscal
    fNUM_DOC: AnsiString;          /// Número do documento fiscal
    fCHV_CTE: AnsiString;          /// Chave da Conhecimento Eletrônico
    fDT_DOC: TDateTime;        /// Data da emissão do documento fiscal
    fDT_A_P: TDateTime;        /// Data da aquisição ou da prestaçãodo serviço
    fTP_CT_e: AnsiString;          /// Tipo de conhecimento conforme definido no manual de integração do CT-e
    fCHV_CTE_REF: AnsiString;      /// Chave do CT-e de referencia cujos valores foram complementados: 1 ou 2
    fVL_DOC: currency;         /// Valor total do documento fiscal
    fVL_DESC: currency;          /// Valor total do desconto
    fIND_FRT: AnsiString;          /// Indicador do tipo do frete:
    fVL_SERV: currency;        /// Valor do frete indicado no documento fiscal
    fVL_BC_ICMS: currency;     /// Valor da base de cálculo do ICMS
    fVL_ICMS: currency;        /// Valor do ICMS
    fVL_NT: currency;          /// Valor não tributado
    fCOD_INF: AnsiString;          /// Valor do ICMS retido por substituição tributária
    fCOD_CTA: AnsiString;          /// Código da conta analitica contabil debitada/creditada

    FRegistroD190: TRegistroD190List;  /// BLOCO D - Lista de RegistroD190 (FILHO) {Márcio Lopes 21Dez2009}
  public
    constructor Create; virtual; /// Create
    destructor Destroy; override; /// Destroy

    property IND_OPER: AnsiString read FIND_OPER write FIND_OPER;
    property IND_EMIT: AnsiString read FIND_EMIT write FIND_EMIT;
    property COD_PART: AnsiString read FCOD_PART write FCOD_PART;
    property COD_MOD: AnsiString read FCOD_MOD write FCOD_MOD;
    property COD_SIT: AnsiString read FCOD_SIT write FCOD_SIT;
    property SER: AnsiString read FSER write FSER;
    property SUB: AnsiString read FSUB write FSUB;
    property NUM_DOC: AnsiString read FNUM_DOC write FNUM_DOC;
    property CHV_CTE: AnsiString read FCHV_CTE write FCHV_CTE;
    property DT_DOC: TDateTime read FDT_DOC write FDT_DOC;
    property DT_A_P: TDateTime read FDT_A_P write FDT_A_P;
    property TP_CT_e: AnsiString read FTP_CT_e write FTP_CT_e;
    property CHV_CTE_REF: AnsiString read FCHV_CTE_REF write FCHV_CTE_REF;
    property VL_DOC: currency read FVL_DOC write FVL_DOC;
    property VL_DESC: currency read FVL_DESC write FVL_DESC;
    property IND_FRT: AnsiString read FIND_FRT write FIND_FRT;
    property VL_SERV: currency read FVL_SERV write FVL_SERV;
    property VL_BC_ICMS: currency read FVL_BC_ICMS write FVL_BC_ICMS;
    property VL_ICMS: currency read FVL_ICMS write FVL_ICMS;
    property VL_NT: currency read FVL_NT write FVL_NT;
    property COD_INF: AnsiString read FCOD_INF write FCOD_INF;
    property COD_CTA: AnsiString read FCOD_CTA write FCOD_CTA;

    property RegistroD190: TRegistroD190List read FRegistroD190 write FRegistroD190;  {Márcio Lopes 04Dez2009}
  end;

  /// Registro D100 - Lista

  TRegistroD100List = class(TList)
  private
    function GetItem(Index: Integer): TRegistroD100; /// GetItem
    procedure SetItem(Index: Integer; const Value: TRegistroD100); /// SetItem
  public
    destructor Destroy; override;
    function New: TRegistroD100;
    property Items[Index: Integer]: TRegistroD100 read GetItem write SetItem;
  end;

  /// Registro D110 - COMPLEMENTO DOS BILHETES (CÓDIGO 13, CÓDIGO 14 E CÓDIGO 16)

  TRegistroD110 = class(TPersistent)
  private
    fUF_ORIG: AnsiString;          /// Sigla da unidade da federação:
    fCOD_MUN_ORIG: AnsiString;     /// Código do município de origem do serviço:
    fUF_DEST: AnsiString;          /// Sigla da unidade da federação de destino do passageiro:
    fCOD_MUN_DEST: AnsiString;     /// Código do município de destino do passageiro:
    fCOD_LINHA: AnsiString;        /// Código do prefixo da linha de transporte:
    fLINHA: AnsiString;            /// Descrição da linha de transporte:
    fPOLT_CAB: AnsiString;         /// Número da poltrona ou cabine:
    fAGENTE: AnsiString;           /// Identificaçã o do agente:
  public
    property UF_ORIG: AnsiString read FUF_ORIG write FUF_ORIG;
    property COD_MUN_ORIG: AnsiString read FCOD_MUN_ORIG write FCOD_MUN_ORIG;
    property UF_DEST: AnsiString read FUF_DEST write FUF_DEST;
    property COD_MUN_DEST: AnsiString read FCOD_MUN_DEST write FCOD_MUN_DEST;
    property COD_LINHA: AnsiString read FCOD_LINHA write FCOD_LINHA;
    property LINHA: AnsiString read FLINHA write FLINHA;
    property POLT_CAB: AnsiString read FPOLT_CAB write FPOLT_CAB;
    property AGENTE: AnsiString read FAGENTE write FAGENTE;
  end;

  /// Registro D110 - Lista

  TRegistroD110List = class(TList)
  private
    function GetItem(Index: Integer): TRegistroD110; /// GetItem
    procedure SetItem(Index: Integer; const Value: TRegistroD110); /// SetItem
  public
    destructor Destroy; override;
    function New: TRegistroD110;
    property Items[Index: Integer]: TRegistroD110 read GetItem write SetItem;
  end;

  /// Registro D120 - COMPLEMENTO DA NOTA FISCAL DE SERVIÇOS DE TRANSPORTE (CÓDIGO 07)

  TRegistroD120 = class(TPersistent)
  private
     fCOD_MUN_ORIG:AnsiString; // Código do município de origem do serviço, conforme a tabela IBGE
     fCOD_MUN_DEST:AnsiString; // Código do município de destino, conforme a tabela IBGE
     fVEIC_ID     :AnsiString; // Placa de identificação do veículo
     fUF_ID       :AnsiString;  // Sigla da UF da placa do veículo
  public
    property COD_MUN_ORIG :AnsiString read fCOD_MUN_ORIG write fCOD_MUN_ORIG;
    property COD_MUN_DEST :AnsiString read fCOD_MUN_DEST write fCOD_MUN_DEST;
    property VEIC_ID      :AnsiString read fVEIC_ID      write fVEIC_ID     ;
    property UF_ID        :AnsiString read fUF_ID        write fUF_ID       ;
  end;

  /// Registro D120 - Lista

  TRegistroD120List = class(TList)
  private
    function GetItem(Index: Integer): TRegistroD120; /// GetItem
    procedure SetItem(Index: Integer; const Value: TRegistroD120); /// SetItem
  public
    destructor Destroy; override;
    function New: TRegistroD120;
    property Items[Index: Integer]: TRegistroD120 read GetItem write SetItem;
  end;

  /// Registro D130 - COMPLEMENTO DO CONHECIMENTO RODOVIÁRIO DE CARGAS (CÓDIGO 08)

  TRegistroD130 = class(TPersistent)
  private
    fCOD_PART_CONSG: AnsiString;      /// Código do participante (campo 02 do Registro 0150):
    fCOD_PART_RED: AnsiString;        /// Código do participante (campo 02 do Registro 0150):
    fIND_FRT_RED: AnsiString;         /// Indicador do tipo do frete da operação de redespacho:
    fCOD_MUN_ORIG: AnsiString;        /// Código do município de origem do serviço, conforme a tabela IBGE
    fCOD_MUN_DEST: AnsiString;        /// Código do município de destino, conforme a tabela IBGE
    fVEIC_ID: AnsiString;             /// Placa de identificação do veículo
    fVL_LIQ_FRT: currency;        /// Valor líquido do frete
    fVL_SEC_CAT: currency;        /// Soma de valores de Sec/Cat (serviços de coleta/custo adicional de transporte)
    fVL_DESP: currency;           /// Soma de valores de despacho
    fVL_PEDG: currency;           /// Soma dos valores de pedágio
    fVL_OUT: currency;            /// Outros valores
    fVL_FRT: currency;            /// Valor total do frete
    fUF_ID: AnsiString;               /// Sigla da UF da placa do veículo
  public
    property COD_PART_CONSG: AnsiString read FCOD_PART_CONSG write FCOD_PART_CONSG;
    property COD_PART_RED: AnsiString read FCOD_PART_RED write FCOD_PART_RED;
    property IND_FRT_RED: AnsiString read FIND_FRT_RED write FIND_FRT_RED;
    property COD_MUN_ORIG: AnsiString read FCOD_MUN_ORIG write FCOD_MUN_ORIG;
    property COD_MUN_DEST: AnsiString read FCOD_MUN_DEST write FCOD_MUN_DEST;
    property VEIC_ID: AnsiString read FVEIC_ID write FVEIC_ID;
    property VL_LIQ_FRT: currency read FVL_LIQ_FRT write FVL_LIQ_FRT;
    property VL_SEC_CAT: currency read FVL_SEC_CAT write FVL_SEC_CAT;
    property VL_DESP: currency read FVL_DESP write FVL_DESP;
    property VL_PEDG: currency read FVL_PEDG write FVL_PEDG;
    property VL_OUT: currency read FVL_OUT write FVL_OUT;
    property VL_FRT: currency read FVL_FRT write FVL_FRT;
    property UF_ID: AnsiString read FUF_ID write FUF_ID;
  end;

  /// Registro D130 - Lista

  TRegistroD130List = class(TList)
  private
    function GetItem(Index: Integer): TRegistroD130; /// GetItem
    procedure SetItem(Index: Integer; const Value: TRegistroD130); /// SetItem
  public
    destructor Destroy; override;
    function New: TRegistroD130;
    property Items[Index: Integer]: TRegistroD130 read GetItem write SetItem;
  end;

  /// Registro D140 - COMPLEMENTO DO CONHECIMENTO AQUAVIÁRIO DE CARGAS (CÓDIGO 09)

  TRegistroD140 = class(TPersistent)
  private
    fCOD_PART_CONSG: AnsiString;        /// Código do participante (campo 02 do Registro 0150):
    fCOD_MUN_ORIG: AnsiString;          /// Código do município de origem do serviço, conforme a tabela IBGE
    fCOD_MUN_DEST: AnsiString;          /// Código do município de destino, conforme a tabela IBGE
    fIND_VEIC: AnsiString;              /// Indicador do tipo do veículo transportador:
    fVEIC_ID: AnsiString;               /// Identificação da embarcação (IRIM ou Registro CPP)
    fIND_NAV: AnsiString;               /// Indicador do tipo da navegação:
    fVIAGEM: AnsiString;                /// Número da viagem
    fVL_FRT_LIQ: currency;          /// Valor líquido do frete
    fVL_DESP_PORT: currency;        /// Valor das despesas portuárias
    fVL_DESP_CAR_DESC: currency;    /// Valor das despesas com carga e descarga
    fVL_OUT: currency;              /// Outros valores
    fVL_FRT_BRT: currency;          /// Valor bruto do frete
    fVL_FRT_MM: currency;           /// Valor adicional do frete para renovação da Marinha Mercante
  public
    property COD_PART_CONSG: AnsiString read FCOD_PART_CONSG write FCOD_PART_CONSG;
    property COD_MUN_ORIG: AnsiString read FCOD_MUN_ORIG write FCOD_MUN_ORIG;
    property COD_MUN_DEST: AnsiString read FCOD_MUN_DEST write FCOD_MUN_DEST;
    property IND_VEIC: AnsiString read FIND_VEIC write FIND_VEIC;
    property VEIC_ID: AnsiString read FVEIC_ID write FVEIC_ID;
    property IND_NAV: AnsiString read FIND_NAV write FIND_NAV;
    property VIAGEM: AnsiString read FVIAGEM write FVIAGEM;
    property VL_FRT_LIQ: currency read FVL_FRT_LIQ write FVL_FRT_LIQ;
    property VL_DESP_PORT: currency read FVL_DESP_PORT write FVL_DESP_PORT;
    property VL_DESP_CAR_DESC: currency read FVL_DESP_CAR_DESC write FVL_DESP_CAR_DESC;
    property VL_OUT: currency read FVL_OUT write FVL_OUT;
    property VL_FRT_BRT: currency read FVL_FRT_BRT write FVL_FRT_BRT;
    property VL_FRT_MM: currency read FVL_FRT_MM write FVL_FRT_MM;
  end;

  /// Registro D140 - Lista

  TRegistroD140List = class(TList)
  private
    function GetItem(Index: Integer): TRegistroD140; /// GetItem
    procedure SetItem(Index: Integer; const Value: TRegistroD140); /// SetItem
  public
    destructor Destroy; override;
    function New: TRegistroD140;
    property Items[Index: Integer]: TRegistroD140 read GetItem write SetItem;
  end;

  /// Registro D150 - COMPLEMENTO DO CONHECIMENTO AÉREO (CÓDIGO 10)

  TRegistroD150 = class(TPersistent)
  private
    fCOD_MUN_ORIG: AnsiString;    /// Código do município de origem do serviço, conforme a tabela IBGE
    fCOD_MUN_DEST: AnsiString;    /// Código do município de destino, conforme a tabela IBGE
    fVEIC_ID: AnsiString;         /// Identificação da aeronave (DAC)
    fVIAGEM: AnsiString;          /// Número do vôo.
    fIND_TFA: AnsiString;         /// Indicador do tipo de tarifa aplicada: 0- Exp., 1- Enc., 2- C.I., 9- Outra
    fVL_PESO_TX: currency;    /// Peso taxado
    fVL_TX_TERR: currency;    /// Valor da taxa terrestre
    fVL_TX_RED: currency;     /// Valor da taxa de redespacho
    fVL_OUT: currency;        /// Outros valores
    fVL_TX_ADV: currency;     /// Valor da taxa "ad valorem"
  public
    property COD_MUN_ORIG: AnsiString read FCOD_MUN_ORIG write FCOD_MUN_ORIG;
    property COD_MUN_DEST: AnsiString read FCOD_MUN_DEST write FCOD_MUN_DEST;
    property VEIC_ID: AnsiString read FVEIC_ID write FVEIC_ID;
    property VIAGEM: AnsiString read FVIAGEM write FVIAGEM;
    property IND_TFA: AnsiString read FIND_TFA write FIND_TFA;
    property VL_PESO_TX: currency read FVL_PESO_TX write FVL_PESO_TX;
    property VL_TX_TERR: currency read FVL_TX_TERR write FVL_TX_TERR;
    property VL_TX_RED: currency read FVL_TX_RED write FVL_TX_RED;
    property VL_OUT: currency read FVL_OUT write FVL_OUT;
    property VL_TX_ADV: currency read FVL_TX_ADV write FVL_TX_ADV;
  end;

  /// Registro D150 - Lista

  TRegistroD150List = class(TList)
  private
    function GetItem(Index: Integer): TRegistroD150; /// GetItem
    procedure SetItem(Index: Integer; const Value: TRegistroD150); /// SetItem
  public
    destructor Destroy; override;
    function New: TRegistroD150;
    property Items[Index: Integer]: TRegistroD150 read GetItem write SetItem;
  end;

  /// Registro D160 - CARGA TRANSPORTADA (CÓDIGO 07, 08, 09, 10, 11, 26 E 27)

  TRegistroD160 = class(TPersistent)
  private
    fDESPACHO       : AnsiString; /// Identificação do número do despacho
    fCNPJ_CPF_REM   : AnsiString; /// CNPJ ou CPF do remetente das mercadorias que constam na nota fiscal.
    fIE_REM         : AnsiString; /// Inscrição Estadual do remetente das mercadorias que constam na nota fiscal.
    fCOD_MUN_ORI    : AnsiString; /// Código do Município de origem, conforme tabela IBGE
    fCNPJ_CPF_DEST  : AnsiString; /// CNPJ ou CPF do destinatário das mercadorias que constam na nota fiscal.
    fIE_DEST        : AnsiString; /// Inscrição Estadual do destinatário das mercadorias que constam na nota fiscal.
    fCOD_MUN_DEST   : AnsiString; /// Código do Município de destino, conforme tabela IBGE
  public
    property DESPACHO     : AnsiString read fDESPACHO       write fDESPACHO     ;
    property CNPJ_CPF_REM : AnsiString read fCNPJ_CPF_REM   write fCNPJ_CPF_REM ;
    property IE_REM       : AnsiString read fIE_REM         write fIE_REM       ;
    property COD_MUN_ORI  : AnsiString read fCOD_MUN_ORI    write fCOD_MUN_ORI  ;
    property CNPJ_CPF_DEST: AnsiString read fCNPJ_CPF_DEST  write fCNPJ_CPF_DEST;
    property IE_DEST      : AnsiString read fIE_DEST        write fIE_DEST      ;
    property COD_MUN_DEST : AnsiString read fCOD_MUN_DEST   write fCOD_MUN_DEST ;
  end;

  /// Registro D160 - Lista

  TRegistroD160List = class(TList)
  private
    function GetItem(Index: Integer): TRegistroD160; /// GetItem
    procedure SetItem(Index: Integer; const Value: TRegistroD160); /// SetItem
  public
    destructor Destroy; override;
    function New: TRegistroD160;
    property Items[Index: Integer]: TRegistroD160 read GetItem write SetItem;
  end;

  /// Registro D161 - LOCAL DA COLETA E ENTREGA (CÓDIGO 07, 08, 09, 10, 11, 26 E 27)

  TRegistroD161 = class(TPersistent)
  private
    fIND_CARGA: AnsiString;       /// Indicador do tipo de transporte da carga coletada:
    fCNPJ_COL: AnsiString;        /// Número do CNPJ do contribuinte do local de coleta
    fIE_COL: AnsiString;          /// Inscrição Estadual do contribuinte do local de coleta
    fCOD_MUN_COL: AnsiString;     /// Código do Município do local de coleta, conforme tabela IBGE
    fCNPJ_ENTG: AnsiString;       /// Número do CNPJ do contribuinte do local de entrega
    fIE_ENTG: AnsiString;         /// Inscrição Estadual do contribuinte do local de entrega
    fCOD_MUN_ENTG: AnsiString;    /// Código do Município do local de entrega, conforme tabela IBGE
  public
    property IND_CARGA: AnsiString read FIND_CARGA write FIND_CARGA;
    property CNPJ_COL: AnsiString read FCNPJ_COL write FCNPJ_COL;
    property IE_COL: AnsiString read FIE_COL write FIE_COL;
    property COD_MUN_COL: AnsiString read FCOD_MUN_COL write FCOD_MUN_COL;
    property CNPJ_ENTG: AnsiString read FCNPJ_ENTG write FCNPJ_ENTG;
    property IE_ENTG: AnsiString read FIE_ENTG write FIE_ENTG;
    property COD_MUN_ENTG: AnsiString read FCOD_MUN_ENTG write FCOD_MUN_ENTG;
  end;

  /// Registro D161 - Lista

  TRegistroD161List = class(TList)
  private
    function GetItem(Index: Integer): TRegistroD161; /// GetItem
    procedure SetItem(Index: Integer; const Value: TRegistroD161); /// SetItem
  public
    destructor Destroy; override;
    function New: TRegistroD161;
    property Items[Index: Integer]: TRegistroD161 read GetItem write SetItem;
  end;

  /// Registro D162 - IDENTIFICAÇÃO DOS DOCUMENTOS FISCAIS (COD. 08, 8B, 09, 10, 11, 26, 27)

  TRegistroD162 = class(TPersistent)
  private
    fCOD_MOD: AnsiString;       /// Código do documento fiscal
    FSER: AnsiString;           /// Série do documento
    FNUM_DOC: AnsiString;       /// Numero
    FDT_DOC: TDateTime;     /// Data de emissão
    FVL_DOC: currency;      /// Valor total do documento fiscal
    FVL_MERC: currency;     /// Valor das mercadorias constantes no documento fiscal
    FQTD_VOL: currency;     /// Quantidade de volumes transportados
    FPESO_BRT: currency;    /// Peso bruto
    FPESO_LIQ: currency;    /// Peso liquido
  public
    property COD_MOD: AnsiString read FCOD_MOD write FCOD_MOD;
    property SER: AnsiString read FSER write FSER;
    property NUM_DOC: AnsiString read FNUM_DOC write FNUM_DOC;
    property DT_DOC: TDateTime read FDT_DOC write FDT_DOC;
    property VL_DOC: currency read FVL_DOC write FVL_DOC;
    property VL_MERC: currency read FVL_MERC write FVL_MERC;
    property QTD_VOL: currency read FQTD_VOL write FQTD_VOL;
    property PESO_BRT: currency read FPESO_BRT write FPESO_BRT;
    property PESO_LIQ: currency read FPESO_LIQ write FPESO_LIQ;
  end;

  /// Registro D162 - Lista

  TRegistroD162List = class(TList)
  private
    function GetItem(Index: Integer): TRegistroD162; /// GetItem
    procedure SetItem(Index: Integer; const Value: TRegistroD162); /// SetItem
  public
    destructor Destroy; override;
    function New: TRegistroD162;
    property Items[Index: Integer]: TRegistroD162 read GetItem write SetItem;
  end;

  /// Registro D170 - COMPLEMENTO DO CONHECIMENTO MULTIMODAL DE CARGAS (CÓDIGO 26)

  TRegistroD170 = class(TPersistent)
  private
    fCOD_PART_CONSG: AnsiString;     /// Código do participante (campo 02 do Registro 0150):
    fCOD_PART_RED: AnsiString;       /// Código do participante (campo 02 do Registro 0150):
    fCOD_MUN_ORIG: AnsiString;       /// Código do município de origem do serviço, conforme a tabela IBGE
    fCOD_MUN_DEST: AnsiString;       /// Código do município de destino, conforme a tabela IBGE
    fOTM: AnsiString;                /// Registro do operador de transporte multimodal
    fIND_NAT_FRT: AnsiString;        /// Indicador da natureza do frete:
    fVL_LIQ_FRT: currency;       /// Valor líquido do frete
    fVL_GRIS: currency;          /// Valor do gris (gerenciamento de risco)
    fVL_PDG: currency;           /// Somatório dos valores de pedágio
    fVL_OUT: currency;           /// Outros valores
    fVL_FRT: currency;           /// Valor total do frete
    fVEIC_ID: AnsiString;            /// Placa de identificação do veículo
    fUF_ID: AnsiString;              /// Sigla da UF da placa do veículo
  public
    property COD_PART_CONSG: AnsiString read FCOD_PART_CONSG write FCOD_PART_CONSG;
    property COD_PART_RED: AnsiString read FCOD_PART_RED write FCOD_PART_RED;
    property COD_MUN_ORIG: AnsiString read FCOD_MUN_ORIG write FCOD_MUN_ORIG;
    property COD_MUN_DEST: AnsiString read FCOD_MUN_DEST write FCOD_MUN_DEST;
    property OTM: AnsiString read FOTM write FOTM;
    property IND_NAT_FRT: AnsiString read FIND_NAT_FRT write FIND_NAT_FRT;
    property VL_LIQ_FRT: currency read FVL_LIQ_FRT write FVL_LIQ_FRT;
    property VL_GRIS: currency read FVL_GRIS write FVL_GRIS;
    property VL_PDG: currency read FVL_PDG write FVL_PDG;
    property VL_OUT: currency read FVL_OUT write FVL_OUT;
    property VL_FRT: currency read FVL_FRT write FVL_FRT;
    property VEIC_ID: AnsiString read FVEIC_ID write FVEIC_ID;
    property UF_ID: AnsiString read FUF_ID write FUF_ID;
  end;

  /// Registro D170 - Lista

  TRegistroD170List = class(TList)
  private
    function GetItem(Index: Integer): TRegistroD170; /// GetItem
    procedure SetItem(Index: Integer; const Value: TRegistroD170); /// SetItem
  public
    destructor Destroy; override;
    function New: TRegistroD170;
    property Items[Index: Integer]: TRegistroD170 read GetItem write SetItem;
  end;

  /// Registro D180 - MODAIS (CÓDIGO 26)

  TRegistroD180 = class(TPersistent)
  private
    fNUM_SEQ: AnsiString;            /// Número de ordem seqüencial do modal
    fIND_EMIT: AnsiString;           /// Indicador do emitente do documento fiscal: 0- Emissão própria, 1- Terceiros
    fCNPJ_EMIT: AnsiString;          /// CNPJ do participante emitente do modal
    fUF_EMIT: AnsiString;            /// Sigla da unidade da federação do participante emitente do modal
    fIE_EMIT: AnsiString;            /// Inscrição Estadual do participante emitente do modal
    fCOD_MUN_ORIG: AnsiString;       /// Código do município de origem do serviço, conforme a tabela IBGE
    fCNPJ_CPF_TOM: AnsiString;       /// CNPJ/CPF do participante tomador do serviço
    fUF_TOM: AnsiString;             /// Sigla da unidade da federação do participante tomador do serviço
    fIE_TOM: AnsiString;             /// Inscrição Estadual do participante tomador do serviço
    fCOD_MUN_DEST: AnsiString;       /// Código do município de destino, conforme a tabela IBGE(Preencher com 9999999, se Exterior)
    fCOD_MOD: AnsiString;            /// Código do modelo do documento fiscal, conforme a Tabela 4.1.1
    fSER: AnsiString;                /// Série do documento fiscal
    fSUB: AnsiString;                /// Subsérie do documento fiscal
    fNUM_DOC: AnsiString;            /// Número do documento fiscal
    fDT_DOC: TDateTime;          /// Data da emissão do documento fiscal
    fVL_DOC: currency;           /// Valor total do documento fiscal
  public
    property NUM_SEQ: AnsiString read FNUM_SEQ write FNUM_SEQ;
    property IND_EMIT: AnsiString read FIND_EMIT write FIND_EMIT;
    property CNPJ_EMIT: AnsiString read FCNPJ_EMIT write FCNPJ_EMIT;
    property UF_EMIT: AnsiString read FUF_EMIT write FUF_EMIT;
    property IE_EMIT: AnsiString read FIE_EMIT write FIE_EMIT;
    property COD_MUN_ORIG: AnsiString read FCOD_MUN_ORIG write FCOD_MUN_ORIG;
    property CNPJ_CPF_TOM: AnsiString read FCNPJ_CPF_TOM write FCNPJ_CPF_TOM;
    property UF_TOM: AnsiString read FUF_TOM write FUF_TOM;
    property IE_TOM: AnsiString read FIE_TOM write FIE_TOM;
    property COD_MUN_DEST: AnsiString read FCOD_MUN_DEST write FCOD_MUN_DEST;
    property COD_MOD: AnsiString read FCOD_MOD write FCOD_MOD;
    property SER: AnsiString read FSER write FSER;
    property SUB: AnsiString read FSUB write FSUB;
    property NUM_DOC: AnsiString read FNUM_DOC write FNUM_DOC;
    property DT_DOC: TDateTime read FDT_DOC write FDT_DOC;
    property VL_DOC: currency read FVL_DOC write FVL_DOC;
  end;

  /// Registro D180 - Lista

  TRegistroD180List = class(TList)
  private
    function GetItem(Index: Integer): TRegistroD180; /// GetItem
    procedure SetItem(Index: Integer; const Value: TRegistroD180); /// SetItem
  public
    destructor Destroy; override;
    function New: TRegistroD180;
    property Items[Index: Integer]: TRegistroD180 read GetItem write SetItem;
  end;

  /// Registro D190 - REGISTRO ANALÍTICO DOS DOCUMENTOS (CÓDIGO 07, 08, 09, 10, 11, 26 E 27)

  TRegistroD190 = class(TPersistent)
  private
    fCST_ICMS: AnsiString;        /// Código da Situação Tributária, conforme a tabela indicada no item 4.3.1
    fCFOP: AnsiString;            /// Código Fiscal de Operação e Prestação, conforme a tabela indicada no item 4.2.2
    fALIQ_ICMS: currency;     /// Alíquota do ICMS
    fVL_OPR: currency;        /// Valor da operação correspondente à combinação de CST_ICMS, CFOP, e alíquota do ICMS.
    fVL_BC_ICMS: currency;    /// Parcela correspondente ao "Valor da base de cálculo do ICMS" referente à combinação CST_ICMS, CFOP, e alíquota do ICMS
    fVL_ICMS: currency;       /// Parcela correspondente ao "Valor do ICMS" referente à combinação CST_ICMS,  CFOP e alíquota do ICMS
    fVL_RED_BC: currency;     /// Valor não tributado em função da redução da base de cálculo do ICMS, referente à combinação de CST_ICMS, CFOP e alíquota do ICMS.
    fCOD_OBS: AnsiString;         /// Código da observação do lançamento fiscal (campo 02 do Registro 0460)
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

  /// Registro D190 - Lista

  TRegistroD190List = class(TList)
  private
    function GetItem(Index: Integer): TRegistroD190; /// GetItem
    procedure SetItem(Index: Integer; const Value: TRegistroD190); /// SetItem
  public
    destructor Destroy; override;
    function New: TRegistroD190;
    property Items[Index: Integer]: TRegistroD190 read GetItem write SetItem;
  end;

  /// Registro D300 - REGISTRO ANALÍTICO DOS BILHETES CONSOLIDADOS DE PASSAGEM RODOVIÁRIO (CÓDIGO 13), DE PASSAGEM AQUAVIÁRIO (CÓDIGO 14), DE PASSAGEM E NOTA DE BAGAGEM (CÓDIGO 15) E DE PASSAGEM FERROVIÁRIO (CÓDIGO 16)

  TRegistroD300 = class(TPersistent)
  private
    fCOD_MOD: AnsiString;         /// Código do modelo do documento fiscal, conforme a Tabela 4.1.1
    fSER: AnsiString;             /// Série do documento fiscal
    fSUB: AnsiString;             /// Subsérie do documento fiscal
    fNUM_DOC_INI: AnsiString;     /// Número do primeiro documento fiscal emitido (mesmo modelo, série e subsérie)
    fNUM_DOC_FIN: AnsiString;     /// Número do último documento fiscal emitido (mesmo modelo, série e subsérie)
    fCST_ICMS: AnsiString;        /// Código da Situação Tributária, conforme a Tabela indicada no item 4.3.1
    fCFOP: AnsiString;            /// Código Fiscal de Operação e Prestação conforme tabela indicada no item 4.2.2
    fALIQ_ICMS: currency;     /// Alíquota do ICMS
    fDT_DOC: TDateTime;       /// Data da emissão dos documentos fiscais
    fVL_OPR: currency;        /// Valor total acumulado das operações correspondentes à combinação de CST_ICMS, CFOP e alíquota do ICMS, incluídas as despesas acessórias e acréscimos.
    fVL_DESC: currency;       /// Valor total dos descontos
    fVL_SERV: currency;       /// Valor total da prestação de serviço
    fVL_SEG: currency;        /// Valor de seguro
    fVL_OUT_DESP: currency;   /// Valor de outras despesas
    fVL_BC_ICMS: currency;    /// Valor total da base de cálculo do ICMS
    fVL_ICMS: currency;       /// Valor total do ICMS
    fVL_RED_BC: currency;     /// Valor não tributado em função da redução da base de cálculo do ICMS, referente à combinação de CST_ICMS, CFOP e alíquota do ICMS.
    fCOD_OBS: AnsiString;         /// Código da observação do lançamento fiscal (campo 02 do Registro 0460)
    fCOD_CTA: AnsiString;         /// Código da conta analítica contábil debitada/creditada
  public
    property COD_MOD: AnsiString read FCOD_MOD write FCOD_MOD;
    property SER: AnsiString read FSER write FSER;
    property SUB: AnsiString read FSUB write FSUB;
    property NUM_DOC_INI: AnsiString read FNUM_DOC_INI write FNUM_DOC_INI;
    property NUM_DOC_FIN: AnsiString read FNUM_DOC_FIN write FNUM_DOC_FIN;
    property CST_ICMS: AnsiString read FCST_ICMS write FCST_ICMS;
    property CFOP: AnsiString read FCFOP write FCFOP;
    property ALIQ_ICMS: currency read FALIQ_ICMS write FALIQ_ICMS;
    property DT_DOC: TDateTime read FDT_DOC write FDT_DOC;
    property VL_OPR: currency read FVL_OPR write FVL_OPR;
    property VL_DESC: currency read FVL_DESC write FVL_DESC;
    property VL_SERV: currency read FVL_SERV write FVL_SERV;
    property VL_SEG: currency read FVL_SEG write FVL_SEG;
    property VL_OUT_DESP: currency read FVL_OUT_DESP write FVL_OUT_DESP;
    property VL_BC_ICMS: currency read FVL_BC_ICMS write FVL_BC_ICMS;
    property VL_ICMS: currency read FVL_ICMS write FVL_ICMS;
    property VL_RED_BC: currency read FVL_RED_BC write FVL_RED_BC;
    property COD_OBS: AnsiString read FCOD_OBS write FCOD_OBS;
    property COD_CTA: AnsiString read FCOD_CTA write FCOD_CTA;
  end;

  /// Registro D300 - Lista

  TRegistroD300List = class(TList)
  private
    function GetItem(Index: Integer): TRegistroD300; /// GetItem
    procedure SetItem(Index: Integer; const Value: TRegistroD300); /// SetItem
  public
    destructor Destroy; override;
    function New: TRegistroD300;
    property Items[Index: Integer]: TRegistroD300 read GetItem write SetItem;
  end;

  /// Registro D301 - DOCUMENTOS CANCELADOS DOS BILHETES DE PASSAGEM RODOVIÁRIO (CÓDIGO 13), DE PASSAGEM AQUAVIÁRIO (CÓDIGO 14), DE PASSAGEM E NOTA DE BAGAGEM (CÓDIGO 15) E DE PASSAGEM FERROVIÁRIO (CÓDIGO 16)

  TRegistroD301 = class(TPersistent)
  private
    fNUM_DOC_CANC: AnsiString;    /// Número do documento fiscal cancelado
  public
    property NUM_DOC_CANC: AnsiString read FNUM_DOC_CANC write FNUM_DOC_CANC;
  end;

  /// Registro D301 - Lista

  TRegistroD301List = class(TList)
  private
    function GetItem(Index: Integer): TRegistroD301; /// GetItem
    procedure SetItem(Index: Integer; const Value: TRegistroD301); /// SetItem
  public
    destructor Destroy; override;
    function New: TRegistroD301;
    property Items[Index: Integer]: TRegistroD301 read GetItem write SetItem;
  end;

  /// Registro D310 - COMPLEMENTO DOS BILHETES (CÓDIGO 13, 14, 15 E 16)

  TRegistroD310 = class(TPersistent)
  private
    fCOD_MUN_ORIG: AnsiString;    /// Código do município de origem do serviço, conforme a tabela IBGE
    fVL_SERV: currency;       /// Valor total da prestação de serviço
    fVL_BC_ICMS: currency;    /// Valor total da base de cálculo do ICMS
    fVL_ICMS: currency;       /// Valor total do ICMS
  public
    property COD_MUN_ORIG: AnsiString read FCOD_MUN_ORIG write FCOD_MUN_ORIG;
    property VL_SERV: currency read FVL_SERV write FVL_SERV;
    property VL_BC_ICMS: currency read FVL_BC_ICMS write FVL_BC_ICMS;
    property VL_ICMS: currency read FVL_ICMS write FVL_ICMS;
  end;

  /// Registro D310 - Lista

  TRegistroD310List = class(TList)
  private
    function GetItem(Index: Integer): TRegistroD310; /// GetItem
    procedure SetItem(Index: Integer; const Value: TRegistroD310); /// SetItem
  public
    destructor Destroy; override;
    function New: TRegistroD310;
    property Items[Index: Integer]: TRegistroD310 read GetItem write SetItem;
  end;

  /// Registro D350 - EQUIPAMENTO ECF (CÓDIGOS 2E, 13, 14, 15 e 16)

  TRegistroD350 = class(TPersistent)
  private
    fCOD_MOD: AnsiString;      /// Código do modelo do documento fiscal, conforme a Tabela 4.1.1
    fECF_MOD: AnsiString;      /// Modelo do equipamento
    fECF_FAB: AnsiString;      /// Número de série de fabricação do ECF
    fECF_CX: AnsiString;       /// Número do caixa atribuído ao ECF
  public
    property COD_MOD: AnsiString read FCOD_MOD write FCOD_MOD;
    property ECF_MOD: AnsiString read FECF_MOD write FECF_MOD;
    property ECF_FAB: AnsiString read FECF_FAB write FECF_FAB;
    property ECF_CX: AnsiString read FECF_CX write FECF_CX;
  end;

  /// Registro D350 - Lista

  TRegistroD350List = class(TList)
  private
    function GetItem(Index: Integer): TRegistroD350; /// GetItem
    procedure SetItem(Index: Integer; const Value: TRegistroD350); /// SetItem
  public
    destructor Destroy; override;
    function New: TRegistroD350;
    property Items[Index: Integer]: TRegistroD350 read GetItem write SetItem;
  end;

  /// Registro D355 - REDUÇÃO Z (CÓDIGOS 2E, 13, 14, 15 e 16)

  TRegistroD355 = class(TPersistent)
  private
    fDT_DOC: TDateTime;       /// Data do movimento a que se refere a Redução Z
    fCRO: integer;            /// Posição do Contador de Reinício de Operação
    fCRZ: integer;            /// Posição do Contador de Redução Z
    fNUM_COO_FIN: integer;    /// Número do Contador de Ordem de Operação do último documento emitido no dia. (Número do COO na Redução Z)
    fGT_FIN: currency;        /// Valor do Grande Total final
    fVL_BRT: currency;        /// Valor da venda bruta
  public
    property DT_DOC: TDateTime read FDT_DOC write FDT_DOC;
    property CRO: integer read FCRO write FCRO;
    property CRZ: integer read FCRZ write FCRZ;
    property NUM_COO_FIN: integer read FNUM_COO_FIN write FNUM_COO_FIN;
    property GT_FIN: currency read FGT_FIN write FGT_FIN;
    property VL_BRT: currency read FVL_BRT write FVL_BRT;
  end;

  /// Registro D355 - Lista

  TRegistroD355List = class(TList)
  private
    function GetItem(Index: Integer): TRegistroD355; /// GetItem
    procedure SetItem(Index: Integer; const Value: TRegistroD355); /// SetItem
  public
    destructor Destroy; override;
    function New: TRegistroD355;
    property Items[Index: Integer]: TRegistroD355 read GetItem write SetItem;
  end;

  /// Registro D360 - PIS E COFINS TOTALIZADOS NO DIA (CÓDIGOS 2E, 13, 14, 15 e 16)

  TRegistroD360 = class(TPersistent)
  private
    fVL_PIS: currency;        /// Valor total do PIS
    fVL_COFINS: currency;     /// Valor total do COFINS
  public
    property VL_PIS: currency read FVL_PIS write FVL_PIS;
    property VL_COFINS: currency read FVL_COFINS write FVL_COFINS;
  end;

  /// Registro D360 - Lista

  TRegistroD360List = class(TList)
  private
    function GetItem(Index: Integer): TRegistroD360; /// GetItem
    procedure SetItem(Index: Integer; const Value: TRegistroD360); /// SetItem
  public
    destructor Destroy; override;
    function New: TRegistroD360;
    property Items[Index: Integer]: TRegistroD360 read GetItem write SetItem;
  end;

  /// Registro D365 - REGISTRO DOS TOTALIZADORES PARCIAIS DE REDUÇÃO Z (CODIGOS 2E 13 14 15 16)

  TRegistroD365 = class(TPersistent)
  private
    fCOD_TOT_PAR: AnsiString;        /// Código do totalizador, conforme Tabela 4.4.6
    fVLR_ACUM_TOT: currency;     /// Valor acumulado no totalizador, relativo à respectiva Redução Z.
    fNR_TOT: AnsiString;             /// Número do totalizador quando ocorrer mais de uma situação com a mesma carga tributária efetiva.
    fDESCR_NR_TOT: AnsiString;       /// Descrição da situação tributária relativa ao totalizador parcial, quando houver mais de um com a mesma carga tributária efetiva.
  public
    property COD_TOT_PAR: AnsiString read FCOD_TOT_PAR write FCOD_TOT_PAR;
    property VLR_ACUM_TOT: currency read FVLR_ACUM_TOT write FVLR_ACUM_TOT;
    property NR_TOT: AnsiString read FNR_TOT write FNR_TOT;
    property DESCR_NR_TOT: AnsiString read FDESCR_NR_TOT write FDESCR_NR_TOT;
  end;

  /// Registro D365 - Lista

  TRegistroD365List = class(TList)
  private
    function GetItem(Index: Integer): TRegistroD365; /// GetItem
    procedure SetItem(Index: Integer; const Value: TRegistroD365); /// SetItem
  public
    destructor Destroy; override;
    function New: TRegistroD365;
    property Items[Index: Integer]: TRegistroD365 read GetItem write SetItem;
  end;

  /// Registro D370 - COMPLEMENTO DOS DOCUMENTOS INFORMADOS (CÓDIGO 13, 14, 15, 16 E 2E)

  TRegistroD370 = class(TPersistent)
  private
    fCOD_MUN_ORIG: AnsiString;    /// Código do município de origem do serviço, conforme a tabela IBGE
    fVL_SERV: currency;       /// Valor total da prestação de serviço
    fQTD_BILH: currency;      /// Quantidade de bilhetes emitidos
    fVL_BC_ICMS: currency;    /// Valor total da base de cálculo do ICMS
    fVL_ICMS: currency;       /// Valor total do ICMS
  public
    property COD_MUN_ORIG: AnsiString read FCOD_MUN_ORIG write FCOD_MUN_ORIG;
    property VL_SERV: currency read FVL_SERV write FVL_SERV;
    property QTD_BILH: currency read FQTD_BILH write FQTD_BILH;
    property VL_BC_ICMS: currency read FVL_BC_ICMS write FVL_BC_ICMS;
    property VL_ICMS: currency read FVL_ICMS write FVL_ICMS;
  end;

  /// Registro D370 - Lista

  TRegistroD370List = class(TList)
  private
    function GetItem(Index: Integer): TRegistroD370; /// GetItem
    procedure SetItem(Index: Integer; const Value: TRegistroD370); /// SetItem
  public
    destructor Destroy; override;
    function New: TRegistroD370;
    property Items[Index: Integer]: TRegistroD370 read GetItem write SetItem;
  end;

  /// Registro D390 - REGISTRO ANALÍTICO DO MOVIMENTO DIÁRIO (CÓDIGOS 13, 14, 15, 16 E 2E)

  TRegistroD390 = class(TPersistent)
  private
    fCST_ICMS: AnsiString;           /// Código da Situação Tributária, conforme a Tabela indicada no item 4.3.1.
    fCFOP: AnsiString;               /// Código Fiscal de Operação e Prestação
    fALIQ_ICMS: currency;        /// Alíquota do ICMS
    fVL_OPR: currency;           /// Valor da operação correspondente à combinação de CST_ICMS, CFOP, e alíquota do ICMS, incluídas as despesas acessórias e acréscimos
    fVL_BC_ISSQN: currency;      /// Valor da base de cálculo do ISSQN
    fALIQ_ISSQN: currency;       /// Alíquota do ISSQN
    fVL_ISSQN: currency;         /// Valor do ISSQN
    fVL_BC_ICMS: currency;       /// Base de cálculo do ICMS acumulada relativa à alíquota informada
    fVL_ICMS: currency;          /// Valor do ICMS acumulado relativo à alíquota informada
    fCOD_OBS: AnsiString;            /// Código da observação do lançamento fiscal (campo 02 do Registro 0460)
  public
    property CST_ICMS: AnsiString read FCST_ICMS write FCST_ICMS;
    property CFOP: AnsiString read FCFOP write FCFOP;
    property ALIQ_ICMS: currency read FALIQ_ICMS write FALIQ_ICMS;
    property VL_OPR: currency read FVL_OPR write FVL_OPR;
    property VL_BC_ISSQN: currency read FVL_BC_ISSQN write FVL_BC_ISSQN;
    property ALIQ_ISSQN: currency read FALIQ_ISSQN write FALIQ_ISSQN;
    property VL_ISSQN: currency read FVL_ISSQN write FVL_ISSQN;
    property VL_BC_ICMS: currency read FVL_BC_ICMS write FVL_BC_ICMS;
    property VL_ICMS: currency read FVL_ICMS write FVL_ICMS;
    property COD_OBS: AnsiString read FCOD_OBS write FCOD_OBS;
  end;

  /// Registro D390 - Lista

  TRegistroD390List = class(TList)
  private
    function GetItem(Index: Integer): TRegistroD390; /// GetItem
    procedure SetItem(Index: Integer; const Value: TRegistroD390); /// SetItem
  public
    destructor Destroy; override;
    function New: TRegistroD390;
    property Items[Index: Integer]: TRegistroD390 read GetItem write SetItem;
  end;

  /// Registro D400 - RESUMO DE MOVIMENTO DIÁRIO (CÓDIGO 18)

  TRegistroD400 = class(TPersistent)
  private
    fCOD_PART: AnsiString;        /// Código do participante (campo 02 do Registro 0150): - agência, filial ou posto
    fCOD_MOD: AnsiString;         /// Código do modelo do documento fiscal, conforme a Tabela 4.1.1
    fCOD_SIT: AnsiString;         /// Código da situação do documento fiscal, conforme a Tabela 4.1.2
    fSER: AnsiString;             /// Série do documento fiscal
    fSUB: AnsiString;             /// Subsérie do documento fiscal
    fNUM_DOC: AnsiString;         /// Número do documento fiscal resumo.
    fDT_DOC: TDateTime;       /// Data da emissão do documento fiscal
    fVL_DOC: currency;        /// Valor total do documento fiscal
    fVL_DESC: currency;       /// Valor acumulado dos descontos
    fVL_SERV: currency;       /// Valor acumulado da prestação de serviço
    fVL_BC_ICMS: currency;    /// Valor total da base de cálculo do ICMS
    fVL_ICMS: currency;       /// Valor total do ICMS
    fVL_PIS: currency;        /// Valor do PIS
    fVL_COFINS: currency;     /// Valor da COFINS
    fCOD_CTA: AnsiString;         /// Código da conta analítica contábil debitada/creditada
  public
    property COD_PART: AnsiString read FCOD_PART write FCOD_PART;
    property COD_MOD: AnsiString read FCOD_MOD write FCOD_MOD;
    property COD_SIT: AnsiString read FCOD_SIT write FCOD_SIT;
    property SER: AnsiString read FSER write FSER;
    property SUB: AnsiString read FSUB write FSUB;
    property NUM_DOC: AnsiString read FNUM_DOC write FNUM_DOC;
    property DT_DOC: TDateTime read FDT_DOC write FDT_DOC;
    property VL_DOC: currency read FVL_DOC write FVL_DOC;
    property VL_DESC: currency read FVL_DESC write FVL_DESC;
    property VL_SERV: currency read FVL_SERV write FVL_SERV;
    property VL_BC_ICMS: currency read FVL_BC_ICMS write FVL_BC_ICMS;
    property VL_ICMS: currency read FVL_ICMS write FVL_ICMS;
    property VL_PIS: currency read FVL_PIS write FVL_PIS;
    property VL_COFINS: currency read FVL_COFINS write FVL_COFINS;
    property COD_CTA: AnsiString read FCOD_CTA write FCOD_CTA;
  end;

  /// Registro D400 - Lista

  TRegistroD400List = class(TList)
  private
    function GetItem(Index: Integer): TRegistroD400; /// GetItem
    procedure SetItem(Index: Integer; const Value: TRegistroD400); /// SetItem
  public
    destructor Destroy; override;
    function New: TRegistroD400;
    property Items[Index: Integer]: TRegistroD400 read GetItem write SetItem;
  end;

  /// Registro D410 - DOCUMENTOS INFORMADOS (CÓDIGOS 13, 14, 15 E 16)

  TRegistroD410 = class(TPersistent)
  private
    fCOD_MOD: AnsiString;         /// Código do modelo do documento fiscal , conforme a Tabela 4.1.1
    fSER: AnsiString;             /// Série do documento fiscal
    fSUB: AnsiString;             /// Subsérie do documento fiscal
    fNUM_DOC_INI: AnsiString;     /// Número do documento fiscal inicial (mesmo modelo, série e subsérie)
    fNUM_DOC_FIN: AnsiString;     /// Número do documento fiscal final(mesmo modelo, série e subsérie)
    fDT_DOC: TDateTime;       /// Data da emissão dos documentos fiscais
    fCST_ICMS: AnsiString;        /// Código da Situação Tributária, conforme a Tabela indicada no item 4.3.1
    fCFOP: AnsiString;            /// Código Fiscal de Operação e Prestação
    fALIQ_ICMS: currency;     /// Alíquota do ICMS
    fVL_OPR: currency;        /// Valor total acumulado das operações correspondentes à combinação de CST_ICMS, CFOP e alíquota do ICMS, incluídas as despesas acessórias e acréscimos.
    fVL_DESC: currency;       /// Valor acumulado dos descontos
    fVL_SERV: currency;       /// Valor acumulado da prestação de serviço
    fVL_BC_ICMS: currency;    /// Valor acumulado da base de cálculo do ICMS
    fVL_ICMS: currency;       /// Valor acumulado do ICMS
  public
    property COD_MOD: AnsiString read FCOD_MOD write FCOD_MOD;
    property SER: AnsiString read FSER write FSER;
    property SUB: AnsiString read FSUB write FSUB;
    property NUM_DOC_INI: AnsiString read FNUM_DOC_INI write FNUM_DOC_INI;
    property NUM_DOC_FIN: AnsiString read FNUM_DOC_FIN write FNUM_DOC_FIN;
    property DT_DOC: TDateTime read FDT_DOC write FDT_DOC;
    property CST_ICMS: AnsiString read FCST_ICMS write FCST_ICMS;
    property CFOP: AnsiString read FCFOP write FCFOP;
    property ALIQ_ICMS: currency read FALIQ_ICMS write FALIQ_ICMS;
    property VL_OPR: currency read FVL_OPR write FVL_OPR;
    property VL_DESC: currency read FVL_DESC write FVL_DESC;
    property VL_SERV: currency read FVL_SERV write FVL_SERV;
    property VL_BC_ICMS: currency read FVL_BC_ICMS write FVL_BC_ICMS;
    property VL_ICMS: currency read FVL_ICMS write FVL_ICMS;
  end;

  /// Registro D410 - Lista

  TRegistroD410List = class(TList)
  private
    function GetItem(Index: Integer): TRegistroD410; /// GetItem
    procedure SetItem(Index: Integer; const Value: TRegistroD410); /// SetItem
  public
    destructor Destroy; override;
    function New: TRegistroD410;
    property Items[Index: Integer]: TRegistroD410 read GetItem write SetItem;
  end;

  /// Registro D411 - DOCUMENTOS CANCELADOS DOS DOCUMENTOS INFORMADOS (CÓDIGOS 13, 14, 15 E 16)

  TRegistroD411 = class(TPersistent)
  private
    fNUM_DOC_CANC: AnsiString;    /// Número do documento fiscal cancelado
  public
    property NUM_DOC_CANC: AnsiString read FNUM_DOC_CANC write FNUM_DOC_CANC;
  end;

  /// Registro D411 - Lista

  TRegistroD411List = class(TList)
  private
    function GetItem(Index: Integer): TRegistroD411; /// GetItem
    procedure SetItem(Index: Integer; const Value: TRegistroD411); /// SetItem
  public
    destructor Destroy; override;
    function New: TRegistroD411;
    property Items[Index: Integer]: TRegistroD411 read GetItem write SetItem;
  end;

  /// Registro D420 - COMPLEMENTO DOS DOCUMENTOS INFORMADOS(CÓDIGOS 13, 14, 15 E 16)

  TRegistroD420 = class(TPersistent)
  private
    fCOD_MUN_ORIG: AnsiString;    /// Código do município de origem do serviço, conforme a tabela IBGE
    fVL_SERV: currency;       /// Valor total da prestação de serviço
    fVL_BC_ICMS: currency;    /// Valor total da base de cálculo do ICMS
    fVL_ICMS: currency;       /// Valor total do ICMS
  public
    property COD_MUN_ORIG: AnsiString read FCOD_MUN_ORIG write FCOD_MUN_ORIG;
    property VL_SERV: currency read FVL_SERV write FVL_SERV;
    property VL_BC_ICMS: currency read FVL_BC_ICMS write FVL_BC_ICMS;
    property VL_ICMS: currency read FVL_ICMS write FVL_ICMS;
  end;

  /// Registro D420 - Lista

  TRegistroD420List = class(TList)
  private
    function GetItem(Index: Integer): TRegistroD420; /// GetItem
    procedure SetItem(Index: Integer; const Value: TRegistroD420); /// SetItem
  public
    destructor Destroy; override;
    function New: TRegistroD420;
    property Items[Index: Integer]: TRegistroD420 read GetItem write SetItem;
  end;

  /// Registro D500 - NOTA FISCAL DE SERVIÇO DE COMUNICAÇÃO (CÓDIGO 21) E NOTA FISCAL DE SERVIÇO DE TELECOMUNICAÇÃO (CÓDIGO 22)

  TRegistroD500 = class(TPersistent)
  private
    fIND_OPER: AnsiString;        /// Indicador do tipo de operação: 0- Aquisição, 1- Prestação
    fIND_EMIT: AnsiString;        /// Indicador do emitente do documento fiscal: 0- Emissão própria, 1- Terceiros
    fCOD_PART: AnsiString;        /// Código do participante (campo 02 do Registro 0150): - do prestador do serviço, no caso de aquisição, - do tomador do serviço, no caso de prestação.
    fCOD_MOD: AnsiString;         /// Código do modelo do documento fiscal, conforme a Tabela 4.1.1
    fCOD_SIT: AnsiString;         /// Çódigo da situação do documento fiscal, conforme a Tabela 4.1.2
    fSER: AnsiString;             /// Série do documento fiscal
    fSUB: AnsiString;             /// Subsérie do documento fiscal
    fNUM_DOC: AnsiString;         /// Número do documento fiscal
    fDT_DOC: TDateTime;       /// Data da emissão do documento fiscal
    fDT_A_P: TDateTime;       /// Data da entrada (aquisição) ou da saída (prestação do serviço)
    fVL_DOC: currency;        /// Valor total do documento fiscal
    fVL_DESC: currency;       /// Valor total do desconto
    fVL_SERV: currency;       /// Valor da prestação de serviços
    fVL_SERV_NT: currency;    /// Valor total dos serviços não-tributados pelo ICMS
    fVL_TERC: currency;       /// Valores cobrados em nome de terceiros
    fVL_DA: currency;         /// Valor de outras despesas indicadas no documento fiscal
    fVL_BC_ICMS: currency;    /// Valor da base de cálculo do ICMS
    fVL_ICMS: currency;       /// Valor do ICMS
    fCOD_INF: AnsiString;         /// Código da informação complementar (campo 02 do Registro 0450)
    fVL_PIS: currency;        /// Valor do PIS
    fVL_COFINS: currency;     /// Valor da COFINS
    fCOD_CTA: AnsiString;         /// Código da conta analítica contábil debitada/creditada
    fTP_ASSINANTE: AnsiString;    /// Código do Tipo de Assinante: 1 - Comercial/Industrial, 2 - Poder Público, 3 - Residencial/Pessoa física, 4 - Público, 5 - Semi-Público, 6 - Outros

    FRegistroD590: TRegistroD590List;  /// BLOCO D - Lista de RegistroD590 (FILHO) {Jean Barreiros 04Dez2009}
  public
    constructor Create; virtual; /// Create
    destructor Destroy; override; /// Destroy

    property IND_OPER: AnsiString read FIND_OPER write FIND_OPER;
    property IND_EMIT: AnsiString read FIND_EMIT write FIND_EMIT;
    property COD_PART: AnsiString read FCOD_PART write FCOD_PART;
    property COD_MOD: AnsiString read FCOD_MOD write FCOD_MOD;
    property COD_SIT: AnsiString read FCOD_SIT write FCOD_SIT;
    property SER: AnsiString read FSER write FSER;
    property SUB: AnsiString read FSUB write FSUB;
    property NUM_DOC: AnsiString read FNUM_DOC write FNUM_DOC;
    property DT_DOC: TDateTime read FDT_DOC write FDT_DOC;
    property DT_A_P: TDateTime read FDT_A_P write FDT_A_P;
    property VL_DOC: currency read FVL_DOC write FVL_DOC;
    property VL_DESC: currency read FVL_DESC write FVL_DESC;
    property VL_SERV: currency read FVL_SERV write FVL_SERV;
    property VL_SERV_NT: currency read FVL_SERV_NT write FVL_SERV_NT;
    property VL_TERC: currency read FVL_TERC write FVL_TERC;
    property VL_DA: currency read FVL_DA write FVL_DA;
    property VL_BC_ICMS: currency read FVL_BC_ICMS write FVL_BC_ICMS;
    property VL_ICMS: currency read FVL_ICMS write FVL_ICMS;
    property COD_INF: AnsiString read FCOD_INF write FCOD_INF;
    property VL_PIS: currency read FVL_PIS write FVL_PIS;
    property VL_COFINS: currency read FVL_COFINS write FVL_COFINS;
    property COD_CTA: AnsiString read FCOD_CTA write FCOD_CTA;
    property TP_ASSINANTE: AnsiString read FTP_ASSINANTE write FTP_ASSINANTE;

    property RegistroD590: TRegistroD590List read FRegistroD590 write FRegistroD590;  {Jean Barreiros 04Dez2009}
  end;

  /// Registro D500 - Lista

  TRegistroD500List = class(TList)
  private
    function GetItem(Index: Integer): TRegistroD500; /// GetItem
    procedure SetItem(Index: Integer; const Value: TRegistroD500); /// SetItem
  public
    destructor Destroy; override;
    function New: TRegistroD500;
    property Items[Index: Integer]: TRegistroD500 read GetItem write SetItem;
  end;

  /// Registro D590

  TRegistroD590 = class(TPersistent)
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

  TRegistroD590List = class(TList)
  private
    function GetItem(Index: Integer): TRegistroD590; /// GetItem
    procedure SetItem(Index: Integer; const Value: TRegistroD590); /// SetItem
  public
    destructor Destroy; override;
    function New: TRegistroD590;
    property Items[Index: Integer]: TRegistroD590 read GetItem write SetItem;
  end;

  /// Registro D990 - ENCERRAMENTO DO BLOCO D

  TRegistroD990 = class(TPersistent)
  private
    fQTD_LIN_D: Integer; /// Quantidade total de linhas do Bloco D
  public
    property QTD_LIN_D: Integer read fQTD_LIN_D write fQTD_LIN_D;
  end;

implementation

{ TRegistroD100List }

destructor TRegistroD100List.Destroy;
var
intFor: integer;
begin
  for intFor := 0 to Count - 1 do Items[intFor].Free;
  inherited;
end;

function TRegistroD100List.GetItem(Index: Integer): TRegistroD100;
begin
  Result := TRegistroD100(Inherited Items[Index]);
end;

function TRegistroD100List.New: TRegistroD100;
begin
  Result := TRegistroD100.Create;
  Add(Result);
end;

procedure TRegistroD100List.SetItem(Index: Integer; const Value: TRegistroD100);
begin
  Put(Index, Value);
end;

{ TRegistroD110List }

destructor TRegistroD110List.Destroy;
var
intFor: integer;
begin
  for intFor := 0 to Count - 1 do Items[intFor].Free;
  inherited;
end;

destructor TRegistroD590List.Destroy;
var
intFor: integer;
begin
  for intFor := 0 to Count - 1 do Items[intFor].Free;
  inherited;
end;

function TRegistroD590List.GetItem(Index: Integer): TRegistroD590;
begin
  Result := TRegistroD590(Inherited Items[Index]);
end;

function TRegistroD590List.New: TRegistroD590;
begin
  Result := TRegistroD590.Create;
  Add(Result);
end;

procedure TRegistroD590List.SetItem(Index: Integer; const Value: TRegistroD590);
begin
  Put(Index, Value);
end;



function TRegistroD110List.GetItem(Index: Integer): TRegistroD110;
begin
  Result := TRegistroD110(Inherited Items[Index]);
end;

function TRegistroD110List.New: TRegistroD110;
begin
  Result := TRegistroD110.Create;
  Add(Result);
end;

procedure TRegistroD110List.SetItem(Index: Integer; const Value: TRegistroD110);
begin
  Put(Index, Value);
end;

{ TRegistroD120List }

destructor TRegistroD120List.Destroy;
var
intFor: integer;
begin
  for intFor := 0 to Count - 1 do Items[intFor].Free;
  inherited;
end;

function TRegistroD120List.GetItem(Index: Integer): TRegistroD120;
begin
  Result := TRegistroD120(Inherited Items[Index]);
end;

function TRegistroD120List.New: TRegistroD120;
begin
  Result := TRegistroD120.Create;
  Add(Result);
end;

procedure TRegistroD120List.SetItem(Index: Integer; const Value: TRegistroD120);
begin
  Put(Index, Value);
end;

{ TRegistroD130List }

destructor TRegistroD130List.Destroy;
var
intFor: integer;
begin
  for intFor := 0 to Count - 1 do Items[intFor].Free;
  inherited;
end;

function TRegistroD130List.GetItem(Index: Integer): TRegistroD130;
begin
  Result := TRegistroD130(Inherited Items[Index]);
end;

function TRegistroD130List.New: TRegistroD130;
begin
  Result := TRegistroD130.Create;
  Add(Result);
end;

procedure TRegistroD130List.SetItem(Index: Integer; const Value: TRegistroD130);
begin
  Put(Index, Value);
end;

{ TRegistroD140List }

destructor TRegistroD140List.Destroy;
var
intFor: integer;
begin
  for intFor := 0 to Count - 1 do Items[intFor].Free;
  inherited;
end;

function TRegistroD140List.GetItem(Index: Integer): TRegistroD140;
begin
  Result := TRegistroD140(Inherited Items[Index]);
end;

function TRegistroD140List.New: TRegistroD140;
begin
  Result := TRegistroD140.Create;
  Add(Result);
end;

procedure TRegistroD140List.SetItem(Index: Integer; const Value: TRegistroD140);
begin
  Put(Index, Value);
end;

{ TRegistroD150List }

destructor TRegistroD150List.Destroy;
var
intFor: integer;
begin
  for intFor := 0 to Count - 1 do Items[intFor].Free;
  inherited;
end;

function TRegistroD150List.GetItem(Index: Integer): TRegistroD150;
begin
  Result := TRegistroD150(Inherited Items[Index]);
end;

function TRegistroD150List.New: TRegistroD150;
begin
  Result := TRegistroD150.Create;
  Add(Result);
end;

procedure TRegistroD150List.SetItem(Index: Integer; const Value: TRegistroD150);
begin
  Put(Index, Value);
end;

{ TRegistroD160List }

destructor TRegistroD160List.Destroy;
var
intFor: integer;
begin
  for intFor := 0 to Count - 1 do Items[intFor].Free;
  inherited;
end;

function TRegistroD160List.GetItem(Index: Integer): TRegistroD160;
begin
  Result := TRegistroD160(Inherited Items[Index]);
end;

function TRegistroD160List.New: TRegistroD160;
begin
  Result := TRegistroD160.Create;
  Add(Result);
end;

procedure TRegistroD160List.SetItem(Index: Integer; const Value: TRegistroD160);
begin
  Put(Index, Value);
end;

{ TRegistroD161List }

destructor TRegistroD161List.Destroy;
var
intFor: integer;
begin
  for intFor := 0 to Count - 1 do Items[intFor].Free;
  inherited;
end;

function TRegistroD161List.GetItem(Index: Integer): TRegistroD161;
begin
  Result := TRegistroD161(Inherited Items[Index]);
end;

function TRegistroD161List.New: TRegistroD161;
begin
  Result := TRegistroD161.Create;
  Add(Result);
end;

procedure TRegistroD161List.SetItem(Index: Integer; const Value: TRegistroD161);
begin
  Put(Index, Value);
end;

{ TRegistroD162List }

destructor TRegistroD162List.Destroy;
var
intFor: integer;
begin
  for intFor := 0 to Count - 1 do Items[intFor].Free;
  inherited;
end;

function TRegistroD162List.GetItem(Index: Integer): TRegistroD162;
begin
  Result := TRegistroD162(Inherited Items[Index]);
end;

function TRegistroD162List.New: TRegistroD162;
begin
  Result := TRegistroD162.Create;
  Add(Result);
end;

procedure TRegistroD162List.SetItem(Index: Integer; const Value: TRegistroD162);
begin
  Put(Index, Value);
end;

{ TRegistroD170List }

destructor TRegistroD170List.Destroy;
var
intFor: integer;
begin
  for intFor := 0 to Count - 1 do Items[intFor].Free;
  inherited;
end;

function TRegistroD170List.GetItem(Index: Integer): TRegistroD170;
begin
  Result := TRegistroD170(Inherited Items[Index]);
end;

function TRegistroD170List.New: TRegistroD170;
begin
  Result := TRegistroD170.Create;
  Add(Result);
end;

procedure TRegistroD170List.SetItem(Index: Integer; const Value: TRegistroD170);
begin
  Put(Index, Value);
end;

{ TRegistroD180List }

destructor TRegistroD180List.Destroy;
var
intFor: integer;
begin
  for intFor := 0 to Count - 1 do Items[intFor].Free;
  inherited;
end;

function TRegistroD180List.GetItem(Index: Integer): TRegistroD180;
begin
  Result := TRegistroD180(Inherited Items[Index]);
end;

function TRegistroD180List.New: TRegistroD180;
begin
  Result := TRegistroD180.Create;
  Add(Result);
end;

procedure TRegistroD180List.SetItem(Index: Integer; const Value: TRegistroD180);
begin
  Put(Index, Value);
end;

{ TRegistroD190List }

destructor TRegistroD190List.Destroy;
var
intFor: integer;
begin
  for intFor := 0 to Count - 1 do Items[intFor].Free;
  inherited;
end;

function TRegistroD190List.GetItem(Index: Integer): TRegistroD190;
begin
  Result := TRegistroD190(Inherited Items[Index]);
end;

function TRegistroD190List.New: TRegistroD190;
begin
  Result := TRegistroD190.Create;
  Add(Result);
end;

procedure TRegistroD190List.SetItem(Index: Integer; const Value: TRegistroD190);
begin
  Put(Index, Value);
end;

{ TRegistroD300List }

destructor TRegistroD300List.Destroy;
var
intFor: integer;
begin
  for intFor := 0 to Count - 1 do Items[intFor].Free;
  inherited;
end;

function TRegistroD300List.GetItem(Index: Integer): TRegistroD300;
begin
  Result := TRegistroD300(Inherited Items[Index]);
end;

function TRegistroD300List.New: TRegistroD300;
begin
  Result := TRegistroD300.Create;
  Add(Result);
end;

procedure TRegistroD300List.SetItem(Index: Integer; const Value: TRegistroD300);
begin
  Put(Index, Value);
end;

{ TRegistroD301List }

destructor TRegistroD301List.Destroy;
var
intFor: integer;
begin
  for intFor := 0 to Count - 1 do Items[intFor].Free;
  inherited;
end;

function TRegistroD301List.GetItem(Index: Integer): TRegistroD301;
begin
  Result := TRegistroD301(Inherited Items[Index]);
end;

function TRegistroD301List.New: TRegistroD301;
begin
  Result := TRegistroD301.Create;
  Add(Result);
end;

procedure TRegistroD301List.SetItem(Index: Integer; const Value: TRegistroD301);
begin
  Put(Index, Value);
end;

{ TRegistroD310List }

destructor TRegistroD310List.Destroy;
var
intFor: integer;
begin
  for intFor := 0 to Count - 1 do Items[intFor].Free;
  inherited;
end;

function TRegistroD310List.GetItem(Index: Integer): TRegistroD310;
begin
  Result := TRegistroD310(Inherited Items[Index]);
end;

function TRegistroD310List.New: TRegistroD310;
begin
  Result := TRegistroD310.Create;
  Add(Result);
end;

procedure TRegistroD310List.SetItem(Index: Integer; const Value: TRegistroD310);
begin
  Put(Index, Value);
end;

{ TRegistroD350List }

destructor TRegistroD350List.Destroy;
var
intFor: integer;
begin
  for intFor := 0 to Count - 1 do Items[intFor].Free;
  inherited;
end;

function TRegistroD350List.GetItem(Index: Integer): TRegistroD350;
begin
  Result := TRegistroD350(Inherited Items[Index]);
end;

function TRegistroD350List.New: TRegistroD350;
begin
  Result := TRegistroD350.Create;
  Add(Result);
end;

procedure TRegistroD350List.SetItem(Index: Integer; const Value: TRegistroD350);
begin
  Put(Index, Value);
end;

{ TRegistroD355List }

destructor TRegistroD355List.Destroy;
var
intFor: integer;
begin
  for intFor := 0 to Count - 1 do Items[intFor].Free;
  inherited;
end;

function TRegistroD355List.GetItem(Index: Integer): TRegistroD355;
begin
  Result := TRegistroD355(Inherited Items[Index]);
end;

function TRegistroD355List.New: TRegistroD355;
begin
  Result := TRegistroD355.Create;
  Add(Result);
end;

procedure TRegistroD355List.SetItem(Index: Integer; const Value: TRegistroD355);
begin
  Put(Index, Value);
end;

{ TRegistroD360List }

destructor TRegistroD360List.Destroy;
var
intFor: integer;
begin
  for intFor := 0 to Count - 1 do Items[intFor].Free;
  inherited;
end;

function TRegistroD360List.GetItem(Index: Integer): TRegistroD360;
begin
  Result := TRegistroD360(Inherited Items[Index]);
end;

function TRegistroD360List.New: TRegistroD360;
begin
  Result := TRegistroD360.Create;
  Add(Result);
end;

procedure TRegistroD360List.SetItem(Index: Integer; const Value: TRegistroD360);
begin
  Put(Index, Value);
end;

{ TRegistroD365List }

destructor TRegistroD365List.Destroy;
var
intFor: integer;
begin
  for intFor := 0 to Count - 1 do Items[intFor].Free;
  inherited;
end;

function TRegistroD365List.GetItem(Index: Integer): TRegistroD365;
begin
  Result := TRegistroD365(Inherited Items[Index]);
end;

function TRegistroD365List.New: TRegistroD365;
begin
  Result := TRegistroD365.Create;
  Add(Result);
end;

procedure TRegistroD365List.SetItem(Index: Integer; const Value: TRegistroD365);
begin
  Put(Index, Value);
end;

{ TRegistroD370List }

destructor TRegistroD370List.Destroy;
var
intFor: integer;
begin
  for intFor := 0 to Count - 1 do Items[intFor].Free;
  inherited;
end;

function TRegistroD370List.GetItem(Index: Integer): TRegistroD370;
begin
  Result := TRegistroD370(Inherited Items[Index]);
end;

function TRegistroD370List.New: TRegistroD370;
begin
  Result := TRegistroD370.Create;
  Add(Result);
end;

procedure TRegistroD370List.SetItem(Index: Integer; const Value: TRegistroD370);
begin
  Put(Index, Value);
end;

{ TRegistroD390List }

destructor TRegistroD390List.Destroy;
var
intFor: integer;
begin
  for intFor := 0 to Count - 1 do Items[intFor].Free;
  inherited;
end;

function TRegistroD390List.GetItem(Index: Integer): TRegistroD390;
begin
  Result := TRegistroD390(Inherited Items[Index]);
end;

function TRegistroD390List.New: TRegistroD390;
begin
  Result := TRegistroD390.Create;
  Add(Result);
end;

procedure TRegistroD390List.SetItem(Index: Integer; const Value: TRegistroD390);
begin
  Put(Index, Value);
end;

{ TRegistroD400List }

destructor TRegistroD400List.Destroy;
var
intFor: integer;
begin
  for intFor := 0 to Count - 1 do Items[intFor].Free;
  inherited;
end;

function TRegistroD400List.GetItem(Index: Integer): TRegistroD400;
begin
  Result := TRegistroD400(Inherited Items[Index]);
end;

function TRegistroD400List.New: TRegistroD400;
begin
  Result := TRegistroD400.Create;
  Add(Result);
end;

procedure TRegistroD400List.SetItem(Index: Integer; const Value: TRegistroD400);
begin
  Put(Index, Value);
end;

{ TRegistroD410List }

destructor TRegistroD410List.Destroy;
var
intFor: integer;
begin
  for intFor := 0 to Count - 1 do Items[intFor].Free;
  inherited;
end;

function TRegistroD410List.GetItem(Index: Integer): TRegistroD410;
begin
  Result := TRegistroD410(Inherited Items[Index]);
end;

function TRegistroD410List.New: TRegistroD410;
begin
  Result := TRegistroD410.Create;
  Add(Result);
end;

procedure TRegistroD410List.SetItem(Index: Integer; const Value: TRegistroD410);
begin
  Put(Index, Value);
end;

{ TRegistroD411List }

destructor TRegistroD411List.Destroy;
var
intFor: integer;
begin
  for intFor := 0 to Count - 1 do Items[intFor].Free;
  inherited;
end;

function TRegistroD411List.GetItem(Index: Integer): TRegistroD411;
begin
  Result := TRegistroD411(Inherited Items[Index]);
end;

function TRegistroD411List.New: TRegistroD411;
begin
  Result := TRegistroD411.Create;
  Add(Result);
end;

procedure TRegistroD411List.SetItem(Index: Integer; const Value: TRegistroD411);
begin
  Put(Index, Value);
end;

{ TRegistroD420List }

destructor TRegistroD420List.Destroy;
var
intFor: integer;
begin
  for intFor := 0 to Count - 1 do Items[intFor].Free;
  inherited;
end;

function TRegistroD420List.GetItem(Index: Integer): TRegistroD420;
begin
  Result := TRegistroD420(Inherited Items[Index]);
end;

function TRegistroD420List.New: TRegistroD420;
begin
  Result := TRegistroD420.Create;
  Add(Result);
end;

procedure TRegistroD420List.SetItem(Index: Integer; const Value: TRegistroD420);
begin
  Put(Index, Value);
end;

{ TRegistroD500List }

destructor TRegistroD500List.Destroy;
var
intFor: integer;
begin
  for intFor := 0 to Count - 1 do Items[intFor].Free;
  inherited;
end;

function TRegistroD500List.GetItem(Index: Integer): TRegistroD500;
begin
  Result := TRegistroD500(Inherited Items[Index]);
end;

function TRegistroD500List.New: TRegistroD500;
begin
  Result := TRegistroD500.Create;
  Add(Result);
end;

procedure TRegistroD500List.SetItem(Index: Integer; const Value: TRegistroD500);
begin
  Put(Index, Value);
end;

{ TRegistroD500 }

constructor TRegistroD500.Create;
begin
  FRegistroD590 := TRegistroD590List.Create;  /// BLOCO D - Lista de RegistroD590 (FILHO) {Jean Barreiros 04Dez2009}
end;

destructor TRegistroD500.Destroy;
begin
  FRegistroD590.Free;
  inherited;
end;

{ TRegistroD100 }

constructor TRegistroD100.Create;
begin
  FRegistroD190 := TRegistroD190List.Create;  /// BLOCO D - Lista de RegistroD190 (FILHO) {Márcio Lopes 21Dez2009}
end;

destructor TRegistroD100.Destroy;
begin
  FRegistroD190.Free;
  inherited;
end;

end.
