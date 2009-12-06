{******************************************************************************}
{ Projeto: Componentes ACBr                                                    }
{  Biblioteca multiplataforma de componentes Delphi para intera��o com equipa- }
{ mentos de Automa��o Comercial utilizados no Brasil                           }
{                                                                              }
{ Direitos Autorais Reservados (c) 2009   Isaque Pinheiro                      }
{                                                                              }
{ Colaboradores nesse arquivo:                                                 }
{                                                                              }
{  Voc� pode obter a �ltima vers�o desse arquivo na pagina do  Projeto ACBr    }
{ Componentes localizado em      http://www.sourceforge.net/projects/acbr      }
{                                                                              }
{  Esta biblioteca � software livre; voc� pode redistribu�-la e/ou modific�-la }
{ sob os termos da Licen�a P�blica Geral Menor do GNU conforme publicada pela  }
{ Free Software Foundation; tanto a vers�o 2.1 da Licen�a, ou (a seu crit�rio) }
{ qualquer vers�o posterior.                                                   }
{                                                                              }
{  Esta biblioteca � distribu�da na expectativa de que seja �til, por�m, SEM   }
{ NENHUMA GARANTIA; nem mesmo a garantia impl�cita de COMERCIABILIDADE OU      }
{ ADEQUA��O A UMA FINALIDADE ESPEC�FICA. Consulte a Licen�a P�blica Geral Menor}
{ do GNU para mais detalhes. (Arquivo LICEN�A.TXT ou LICENSE.TXT)              }
{                                                                              }
{  Voc� deve ter recebido uma c�pia da Licen�a P�blica Geral Menor do GNU junto}
{ com esta biblioteca; se n�o, escreva para a Free Software Foundation, Inc.,  }
{ no endere�o 59 Temple Street, Suite 330, Boston, MA 02111-1307 USA.          }
{ Voc� tamb�m pode obter uma copia da licen�a em:                              }
{ http://www.opensource.org/licenses/lgpl-license.php                          }
{                                                                              }
{ Daniel Sim�es de Almeida  -  daniel@djsystem.com.br  -  www.djsystem.com.br  }
{              Pra�a Anita Costa, 34 - Tatu� - SP - 18270-410                  }
{                                                                              }
{******************************************************************************}

{******************************************************************************
|* Historico
|*
|* 10/04/2009: Isaque Pinheiro
|*  - Cria��o e distribui��o da Primeira Versao
*******************************************************************************}

unit ACBrEFDBloco_1;

interface

uses
  SysUtils, Classes, DateUtils, ACBrEFDBlocos;

type
  /// Registro 1001 - ABERTURA DO BLOCO 1

  TRegistro1001 = class(TOpenBlocos)
  private
  public
  end;

  /// Registro 1100 - REGISTRO DE INFORMA��ES SOBRE EXPORTA��O

  TRegistro1100 = class(TPersistent)
  private
    fIND_DOC: AnsiString;       /// Informe o tipo de documento: 0 - Declara��o de Exporta��o, 1 - Declara��o Simplificada de Exporta��o.
    fNRO_DE: AnsiString;        /// N�mero da declara��o
    fDT_DE: TDateTime;      /// Data da declara��o (DDMMAAAA)
    fNAT_EXP: AnsiString;       /// Preencher com: 0 - Exporta��o Direta, 1 - Exporta��o Indireta
    fNRO_RE: AnsiString;        /// N� do registro de Exporta��o
    fDT_RE: TDateTime;      /// Data do Registro de Exporta��o (DDMMAAAA)
    fCHC_EMB: AnsiString;       /// N� do conhecimento de embarque
    fDT_CHC: TDateTime;     /// Data do conhecimento de embarque (DDMMAAAA)
    fDT_AVB: TDateTime;     /// Data da averba��o da Declara��o de exporta��o (ddmmaaaa)
    fTP_CHC: AnsiString;        /// Informa��o do tipo de conhecimento de transporte : 01 - AWB; 02 - MAWB; 03 - HAWB;04 - COMAT; 06 - R. EXPRESSAS; 07 - ETIQ. REXPRESSAS; 08 - HR. EXPRESSAS; 09 - AV7; 10 - BL; 11 - MBL; 12 - HBL; 13 - CRT; 14 - DSIC; 16 - COMAT BL; 17 - RWB; 18 - HRWB; 19 - TIF/DTA; 20 - CP2; 91 - N�O IATA; 92 - MNAO IATA; 93 - HNAO IATA; 99 - OUTROS.
    fPAIS: AnsiString;          /// C�digo do pa�s de destino da mercadoria (Preencher conforme tabela do SISCOMEX)
  public
    property IND_DOC: AnsiString read FIND_DOC write FIND_DOC;
    property NRO_DE: AnsiString read FNRO_DE write FNRO_DE;
    property DT_DE: TDateTime read FDT_DE write FDT_DE;
    property NAT_EXP: AnsiString read FNAT_EXP write FNAT_EXP;
    property NRO_RE: AnsiString read FNRO_RE write FNRO_RE;
    property DT_RE: TDateTime read FDT_RE write FDT_RE;
    property CHC_EMB: AnsiString read FCHC_EMB write FCHC_EMB;
    property DT_CHC: TDateTime read FDT_CHC write FDT_CHC;
    property DT_AVB: TDateTime read FDT_AVB write FDT_AVB;
    property TP_CHC: AnsiString read FTP_CHC write FTP_CHC;
    property PAIS: AnsiString read FPAIS write FPAIS;
  end;

  /// Registro 1100 - Lista

  TRegistro1100List = class(TList)
  private
    function GetItem(Index: Integer): TRegistro1100;
    procedure SetItem(Index: Integer; const Value: TRegistro1100);
  public
    destructor Destroy; override;
    function New: TRegistro1100;
    property Items[Index: Integer]: TRegistro1100 read GetItem write SetItem;
  end;

  /// Registro 1105 - DOCUMENTOS FISCAIS DE EXPORTA��O

  TRegistro1105 = class(TPersistent)
  private
    fCOD_MOD: AnsiString;       /// C�digo do modelo da NF, conforme tabela 4.1.1
    fSERIE: AnsiString;         /// S�rie da Nota Fiscal
    fNUM_DOC: AnsiString;       /// N�mero de Nota Fiscal de Exporta��o emitida pelo Exportador
    fCHV_NFE: AnsiString;       /// Chave da Nota Fiscal Eletr�nica
    fDT_DOC: TDateTime;        /// Data da emiss�o da NF de exporta��o
    fCOD_ITEM: AnsiString;      /// C�digo do item (campo 02 do Registro 0200)
  public
    property COD_MOD: AnsiString read FCOD_MOD write FCOD_MOD;
    property SERIE: AnsiString read FSERIE write FSERIE;
    property NUM_DOC: AnsiString read FNUM_DOC write FNUM_DOC;
    property CHV_NFE: AnsiString read FCHV_NFE write FCHV_NFE;
    property DT_DOC: TDateTime read FDT_DOC write FDT_DOC;
    property COD_ITEM: AnsiString read FCOD_ITEM write FCOD_ITEM;
  end;

  /// Registro 1105 - Lista

  TRegistro1105List = class(TList)
  private
    function GetItem(Index: Integer): TRegistro1105;
    procedure SetItem(Index: Integer; const Value: TRegistro1105);
  public
    destructor Destroy; override;
    function New: TRegistro1105;
    property Items[Index: Integer]: TRegistro1105 read GetItem write SetItem;
  end;

  /// Registro 1110 - OPERA��ES DE EXPORTA��O INDIRETA DE PRODUTOS N�O INDUSTRIALIZADOS PELO ESTABELECIMENTO EMITENTE.

  TRegistro1110 = class(TPersistent)
  private
    fCOD_PART: AnsiString;      /// C�digo do participante-Fornecedor da Mercadoria destinada � exporta��o (campo 02 do Registro 0150)
    fCOD_MOD: AnsiString;       /// C�digo do documento fiscal, conforme a Tabela 4.1.1
    fSER: AnsiString;           /// S�rie do documento fiscal recebido com fins espec�ficos de exporta��o.
    fNUM_DOC: AnsiString;       /// N�mero do documento fiscal recebido com fins espec�ficos de exporta��o.
    fDT_DOC: TDateTime;        /// Data da emiss�o do documento fiscal recebido com fins espec�ficos de exporta��o
    fCHV_NFE: AnsiString;       /// Chave da Nota Fiscal Eletr�nica
    fNR_MEMO: AnsiString;           /// N�mero do Memorando de Exporta��o
    fQTD: Currency;           /// Quantidade do item efetivamente exportado.
    fUNID: AnsiString;          /// Unidade do item (Campo 02 do registro 0190)
  public
    property COD_PART: AnsiString read FCOD_PART write FCOD_PART;
    property COD_MOD: AnsiString read FCOD_MOD write FCOD_MOD;
    property SER: AnsiString read FSER write FSER;
    property NUM_DOC: AnsiString read FNUM_DOC write FNUM_DOC;
    property DT_DOC: TDateTime read FDT_DOC write FDT_DOC;
    property CHV_NFE: AnsiString read FCHV_NFE write FCHV_NFE;
    property NR_MEMO: AnsiString read FNR_MEMO write FNR_MEMO;
    property QTD: Currency read FQTD write FQTD;
    property UNID: AnsiString read FUNID write FUNID;
  end;

  /// Registro 1110 - Lista

  TRegistro1110List = class(TList)
  private
    function GetItem(Index: Integer): TRegistro1110;
    procedure SetItem(Index: Integer; const Value: TRegistro1110);
  public
    destructor Destroy; override;
    function New: TRegistro1110;
    property Items[Index: Integer]: TRegistro1110 read GetItem write SetItem;
  end;

  /// Registro 1200 - OPERA��ES DE EXPORTA��O INDIRETA DE PRODUTOS N�O INDUSTRIALIZADOS PELO ESTABELECIMENTO EMITENTE.

  TRegistro1200 = class(TPersistent)
  private
    fCOD_AJ_APUR : AnsiString;      /// C�digo de ajuste, conforme informado na Tabela indicada no item 5.1.1.
    fSLD_CRED    : Currency;        /// Saldo de cr�ditos fiscais de per�odos anteriores
    fCRED_APR    : Currency;        /// Total de cr�dito apropriado no m�s
    fCRED_RECEB  : Currency;        /// Total de cr�ditos recebidos por transfer�ncia
    fCRED_UTIL   : Currency;        /// Total de cr�ditos utilizados no per�odo
    fSLD_CRED_FIM: Currency;        /// Saldo de cr�dito fiscal acumulado a transportar para o per�odo seguinte
  public
    property COD_AJ_APUR : AnsiString read FCOD_AJ_APUR  write FCOD_AJ_APUR;
    property SLD_CRED    : Currency   read FSLD_CRED     write FSLD_CRED;
    property CRED_APR    : Currency   read FCRED_APR     write FCRED_APR;
    property CRED_RECEB  : Currency   read FCRED_RECEB   write FCRED_RECEB;
    property CRED_UTIL   : Currency   read FCRED_UTIL    write FCRED_UTIL;
    property SLD_CRED_FIM: Currency   read FSLD_CRED_FIM write FSLD_CRED_FIM;
  end;

  /// Registro 1200 - Lista

  TRegistro1200List = class(TList)
  private
    function GetItem(Index: Integer): TRegistro1200;
    procedure SetItem(Index: Integer; const Value: TRegistro1200);
  public
    destructor Destroy; override;
    function New: TRegistro1200;
    property Items[Index: Integer]: TRegistro1200 read GetItem write SetItem;
  end;

  /// Registro 1210 - UTILIZA��O DE CR�DITOS FISCAIS - ICMS.

  TRegistro1210 = class(TPersistent)
  private
    fTIPO_UTIL: AnsiString;        /// Tipo de utiliza��o do cr�dito:
    fNR_DOC: AnsiString;           /// N�mero do documento utilizado na baixa de cr�ditos
    fVL_CRED_UTIL: Currency;     /// Total de cr�dito utilizado
  public
    property TIPO_UTIL: AnsiString read FTIPO_UTIL write FTIPO_UTIL;
    property NR_DOC: AnsiString read FNR_DOC write FNR_DOC;
    property VL_CRED_UTIL: Currency read FVL_CRED_UTIL write FVL_CRED_UTIL;
  end;

  /// Registro 1210 - Lista

  TRegistro1210List = class(TList)
  private
    function GetItem(Index: Integer): TRegistro1210;
    procedure SetItem(Index: Integer; const Value: TRegistro1210);
  public
    destructor Destroy; override;
    function New: TRegistro1210;
    property Items[Index: Integer]: TRegistro1210 read GetItem write SetItem;
  end;

  /// Registro 1300 - MOVIMENTA��O DE COMBUST�VEIS.

  TRegistro1300 = class(TPersistent)
  private
    fCOD_ITEM: AnsiString;              /// C�digo do Produto constante do registro 0200
    fDT_FECH: TDateTime;            /// Data do fechamento da movimenta��o
    fNR_INTERV: AnsiString;             /// N�mero da interven��o
    fESTQ_ABERT: Currency;          /// Estoque no inicio do dia
    fVOL_ENTR: Currency;            /// Volume Total das Entradas
    fVOL_DISP: Currency;            /// Volume Dispon�vel (05 + 06)
    fVOL_SAIDAS: Currency;          /// Volume Total das Sa�das (Somat�rio dos registros de Volume de Vendas)
    fVAL_SAIDAS: Currency;          /// Valor das Vendas (08 x Pre�o na Bomba)
    fESTQ_ESCR: Currency;           /// Estoque Escritural (07 - 08)
    fVAL_AJ_PERDA: Currency;        /// Valor da Perda
    fVAL_AJ_GANHO: Currency;        /// Valor do ganho
    fESTQ_FECHA: Currency;          /// Estoque de Fechamento (Somat�rio dos registros da concilia��o de estoques )
  public
    property COD_ITEM: AnsiString       read FCOD_ITEM write FCOD_ITEM;
    property DT_FECH: TDateTime     read FDT_FECH write FDT_FECH;
    property NR_INTERV: AnsiString      read FNR_INTERV write FNR_INTERV;
    property ESTQ_ABERT: Currency   read FESTQ_ABERT write FESTQ_ABERT;
    property VOL_ENTR: Currency     read FVOL_ENTR write FVOL_ENTR;
    property VOL_DISP: Currency     read FVOL_DISP write FVOL_DISP;
    property VOL_SAIDAS: Currency   read FVOL_SAIDAS write FVOL_SAIDAS;
    property VAL_SAIDAS: Currency   read FVAL_SAIDAS write FVAL_SAIDAS;
    property ESTQ_ESCR: Currency    read FESTQ_ESCR write FESTQ_ESCR;
    property VAL_AJ_PERDA: Currency read FVAL_AJ_PERDA write FVAL_AJ_PERDA;
    property VAL_AJ_GANHO: Currency read FVAL_AJ_GANHO write FVAL_AJ_GANHO;
    property ESTQ_FECHA: Currency   read FESTQ_FECHA write FESTQ_FECHA;
  end;

  /// Registro 1300 - Lista

  TRegistro1300List = class(TList)
  private
    function GetItem(Index: Integer): TRegistro1300;
    procedure SetItem(Index: Integer; const Value: TRegistro1300);
  public
    destructor Destroy; override;
    function New: TRegistro1300;
    property Items[Index: Integer]: TRegistro1300 read GetItem write SetItem;
  end;

  /// Registro 1310 - VOLUME DE VENDAS.

  TRegistro1310 = class(TPersistent)
  private
    fNUM_TANQUE:   AnsiString;    /// Tanque onde foi armazenado o combust�vel
    fESTQ_ABERT:   Currency;  /// Estoque no inicio do dia, em litros
    fVOL_ENTR:     Currency;  /// Volume Recebido no dia (em litros)
    fVOL_DISP:     Currency;  /// Volume Dispon�vel (03 + 04), em litros
    fVOL_SAIDAS:   Currency;  ///  Volume Total das Sa�das, em litros
    fESTQ_ESCR :   Currency;  /// Estoque Escritural(05 � 06), litros
    fVAL_AJ_PERDA: Currency;  ///  Valor da Perda, em litros
    fVAL_AJ_GANHO: Currency;  ///  Valor do ganho, em litros
  public
    property NUM_TANQUE  : AnsiString   read fNUM_TANQUE   write fNUM_TANQUE   ;
    property ESTQ_ABERT  : Currency read fESTQ_ABERT   write fESTQ_ABERT   ;
    property VOL_ENTR    : Currency read fVOL_ENTR     write fVOL_ENTR     ;
    property VOL_DISP    : Currency read fVOL_DISP     write fVOL_DISP     ;
    property VOL_SAIDAS  : Currency read fVOL_SAIDAS   write fVOL_SAIDAS    ;
    property ESTQ_ESCR   : Currency read fESTQ_ESCR    write fESTQ_ESCR     ;
    property VAL_AJ_PERDA: Currency read fVAL_AJ_PERDA write fVAL_AJ_PERDA  ;
    property VAL_AJ_GANHO: Currency read fVAL_AJ_GANHO write fVAL_AJ_GANHO  ;
  end;

  /// Registro 1310 - Lista

  TRegistro1310List = class(TList)
  private
    function GetItem(Index: Integer): TRegistro1310;
    procedure SetItem(Index: Integer; const Value: TRegistro1310);
  public
    destructor Destroy; override;
    function New: TRegistro1310;
    property Items[Index: Integer]: TRegistro1310 read GetItem write SetItem;
  end;

  /// Registro 1320 - VOLUME DE VENDAS

  TRegistro1320 = class(TPersistent)
  private
     fNUM_BICO:AnsiString;       /// Bico Ligado � Bomba
     fNR_INTERV:AnsiString;      /// N�mero da interven��o
     fMOT_INTERV:AnsiString;     /// Motivo da Interven��o
     fNOM_INTERV:AnsiString;     /// Nome do Interventor
     fCNPJ_INTERV:AnsiString;    /// CNPJ da empresa respons�vel pela interven��o
     fCPF_INTERV:AnsiString;     /// CPF do t�cnico respons�vel pela interven��o
     fVAL_FECHA:Currency;        /// Valor da leitura final do contador, no fechamento do bico
     fVAL_ABERT:Currency;        /// Valor da leitura inicial do contador, na abertura do bico
     fVOL_AFERI:Currency;        /// Aferi��es da Bomba, em litros
     fVOL_VENDAS:Currency;       /// Vendas (08 � 09 - 10 ) do bico, em litros
  public
    property NUM_BICO:AnsiString       read fNUM_BICO    write fNUM_BICO    ;
    property NR_INTERV:AnsiString      read fNR_INTERV   write fNR_INTERV   ;
    property MOT_INTERV:AnsiString     read fMOT_INTERV  write fMOT_INTERV  ;
    property NOM_INTERV:AnsiString     read fNOM_INTERV  write fNOM_INTERV  ;
    property CNPJ_INTERV:AnsiString    read fCNPJ_INTERV write fCNPJ_INTERV ;
    property CPF_INTERV:AnsiString     read fCPF_INTERV  write fCPF_INTERV  ;
    property VAL_FECHA:Currency    read fVAL_FECHA   write fVAL_FECHA   ;
    property VAL_ABERT:Currency    read fVAL_ABERT   write fVAL_ABERT   ;
    property VOL_AFERI:Currency    read fVOL_AFERI   write fVOL_AFERI   ;
    property VOL_VENDAS:Currency   read fVOL_VENDAS  write fVOL_VENDAS  ;
  end;

  /// Registro 1320 - Lista

  TRegistro1320List = class(TList)
  private
    function GetItem(Index: Integer): TRegistro1320;
    procedure SetItem(Index: Integer; const Value: TRegistro1320);
  public
    destructor Destroy; override;
    function New: TRegistro1320;
    property Items[Index: Integer]: TRegistro1320 read GetItem write SetItem;
  end;


  /// Registro 1350 - BOMBAS

  TRegistro1350 = class(TPersistent)
  private
    fSERIE: AnsiString;        /// N�mero de S�rie da Bomba
    fFABRICANTE: AnsiString;   /// Nome do Fabricante da Bomba
    fMODELO: AnsiString;       /// Modelo da Bomba
    fTIPO_MEDICAO:AnsiString;  /// Identificador de medi��o: [ 0 - anal�gico -  1 � digital ]
  public
    property SERIE:        AnsiString read fSERIE        write fSERIE       ;
    property FABRICANTE:   AnsiString read fFABRICANTE   write fFABRICANTE  ;
    property MODELO:       AnsiString read fMODELO       write fMODELO      ;
    property TIPO_MEDICAO: AnsiString read fTIPO_MEDICAO write fTIPO_MEDICAO;
  end;

  /// Registro 1350 - Lista

  TRegistro1350List = class(TList)
  private
    function  GetItem(Index: Integer): TRegistro1350;
    procedure SetItem(Index: Integer; const Value: TRegistro1350);
  public
    destructor Destroy; override;
    function New: TRegistro1350;
    property Items[Index: Integer]: TRegistro1350 read GetItem write SetItem;
  end;

  /// Registro 1360: LACRES DA BOMBA
  TRegistro1360 = class(TPersistent)
  private
    fNUM_LACRE: AnsiString;         /// N�mero de S�rie da Bomba
    fDT_APLICACAO: TDateTime;   /// Nome do Fabricante da Bomba
  public
    property NUM_LACRE:    AnsiString    read fNUM_LACRE     write fNUM_LACRE    ;
    property DT_APLICACAO: TDateTime read fDT_APLICACAO  write fDT_APLICACAO ;
  end;

  /// Registro 1360 - Lista

  TRegistro1360List = class(TList)
  private
    function  GetItem(Index: Integer): TRegistro1360;
    procedure SetItem(Index: Integer; const Value: TRegistro1360);
  public
    destructor Destroy; override;
    function New: TRegistro1360;
    property Items[Index: Integer]: TRegistro1360 read GetItem write SetItem;
  end;

  /// Registro 1370 - BICOS DA BOMBA

  TRegistro1370 = class(TPersistent)
  private
      fNUM_BICO:AnsiString;    /// N�mero seq�encial do bico ligado a bomba N 003 - O
      fCOD_ITEM:AnsiString;    /// C�digo do Produto, constante do registro 0200 C 060 - O
      fNUM_TANQUE:AnsiString;  /// Tanque que armazena o combust�vel.
  public
    property   NUM_BICO  :AnsiString read fNUM_BICO   write fNUM_BICO  ;    /// N�mero seq�encial do bico ligado a bomba
    property   COD_ITEM  :AnsiString read fCOD_ITEM   write fCOD_ITEM  ;    /// C�digo do Produto, constante do registro
    property   NUM_TANQUE:AnsiString read fNUM_TANQUE write fNUM_TANQUE;  /// Tanque que armazena o combust�vel.
  end;

  /// Registro 1370  - Lista

  TRegistro1370List = class(TList)
  private
    function  GetItem(Index: Integer): TRegistro1370 ;
    procedure SetItem(Index: Integer; const Value: TRegistro1370 );
  public
    destructor Destroy; override;
    function New: TRegistro1370 ;
    property Items[Index: Integer]: TRegistro1370  read GetItem write SetItem;
  end;


  /// Registro 1400 - CINFORMA��O SOBRE VALORES AGREGADOS.

  TRegistro1400 = class(TPersistent)
  private
    fCOD_ITEM: AnsiString;      /// C�digo do item (campo 02 do Registro 0200)
    fMUN: AnsiString;           /// C�digo do Munic�pio de origem
    fVALOR: Currency;      /// Valor mensal correspondente ao munic�pio
  public
    property COD_ITEM: AnsiString read FCOD_ITEM write FCOD_ITEM;
    property MUN: AnsiString read FMUN write FMUN;
    property VALOR: Currency read FVALOR write FVALOR;
  end;

  /// Registro 1400 - Lista

  TRegistro1400List = class(TList)
  private
    function GetItem(Index: Integer): TRegistro1400;
    procedure SetItem(Index: Integer; const Value: TRegistro1400);
  public
    destructor Destroy; override;
    function New: TRegistro1400;
    property Items[Index: Integer]: TRegistro1400 read GetItem write SetItem;
  end;

  /// Registro 1500 - NOTA FISCAL/CONTA DE ENERGIA EL�TRICA (C�DIGO 06) - OPERA��ES INTERESTADUAIS.

  TRegistro1500 = class(TPersistent)
  private
    fIND_OPER: AnsiString;         /// Indicador do tipo de opera��o:
    fIND_EMIT: AnsiString;         /// Indicador do emitente do documento fiscal:
    fCOD_PART: AnsiString;         /// C�digo do participante (campo 02 do Registro 0150):
    fCOD_MOD: AnsiString;          /// C�digo do modelo do documento fiscal conforme a Tabela 4.1.1
    fCOD_SIT: AnsiString;          /// C�digo da situa��o do documento fiscal conforme a Tabela 4.1.2
    fSER: AnsiString;              /// S�rie do documento fiscal
    fSUB: AnsiString;              /// Subs�rie do documento fiscal
    fCOD_CONS: AnsiString;         /// C�digo de classe de consumo de energia el�trica conforme a Tabela 4.4.5 ou C�digo da classe de consumo de g�s canalizado conforme Tabela 4.4.3.
    fNUM_DOC: AnsiString;          /// N�mero do documento fiscal
    fDT_DOC: TDateTime;        /// Data da emiss�o do documento fiscal
    fDT_E_S: TDateTime;        /// Data da entrada ou da sa�da
    fVL_DOC: currency;         /// Valor total do documento fiscal
    fVL_DESC: currency;        /// Valor total do desconto
    fVL_FORN: currency;        /// Valor total fornecido/consumido
    fVL_SERV_NT: currency;     /// Valor total dos servi�os n�o-tributados pelo ICMS
    fVL_TERC: currency;        /// Valor total cobrado em nome de terceiros
    fVL_DA: currency;          /// Valor total de despesas acess�rias indicadas no documento fiscal
    fVL_BC_ICMS: currency;     /// Valor acumulado da base de c�lculo do ICMS
    fVL_ICMS: currency;        /// Valor acumulado do ICMS
    fVL_BC_ICMS_ST: currency;  /// Valor acumulado da base de c�lculo do ICMS substitui��o tribut�ria
    fVL_ICMS_ST: currency;     /// Valor acumulado do ICMS retido por substitui��o tribut�ria
    fCOD_INF: AnsiString;          /// C�digo da informa��o complementar do documento fiscal (campo 02 do Registro 0450)
    fVL_PIS: currency;         /// Valor do PIS
    fVL_COFINS: currency;      /// Valor da COFINS
  public
    property IND_OPER: AnsiString read FIND_OPER write FIND_OPER;
    property IND_EMIT: AnsiString read FIND_EMIT write FIND_EMIT;
    property COD_PART: AnsiString read FCOD_PART write FCOD_PART;
    property COD_MOD: AnsiString read FCOD_MOD write FCOD_MOD;
    property COD_SIT: AnsiString read FCOD_SIT write FCOD_SIT;
    property SER: AnsiString read FSER write FSER;
    property SUB: AnsiString read FSUB write FSUB;
    property COD_CONS: AnsiString read FCOD_CONS write FCOD_CONS;
    property NUM_DOC: AnsiString read FNUM_DOC write FNUM_DOC;
    property DT_DOC: TDateTime read FDT_DOC write FDT_DOC;
    property DT_E_S: TDateTime read FDT_E_S write FDT_E_S;
    property VL_DOC: currency read FVL_DOC write FVL_DOC;
    property VL_DESC: currency read FVL_DESC write FVL_DESC;
    property VL_FORN: currency read FVL_FORN write FVL_FORN;
    property VL_SERV_NT: currency read FVL_SERV_NT write FVL_SERV_NT;
    property VL_TERC: currency read FVL_TERC write FVL_TERC;
    property VL_DA: currency read FVL_DA write FVL_DA;
    property VL_BC_ICMS: currency read FVL_BC_ICMS write FVL_BC_ICMS;
    property VL_ICMS: currency read FVL_ICMS write FVL_ICMS;
    property VL_BC_ICMS_ST: currency read FVL_BC_ICMS_ST write FVL_BC_ICMS_ST;
    property VL_ICMS_ST: currency read FVL_ICMS_ST write FVL_ICMS_ST;
    property COD_INF: AnsiString read FCOD_INF write FCOD_INF;
    property VL_PIS: currency read FVL_PIS write FVL_PIS;
    property VL_COFINS: currency read FVL_COFINS write FVL_COFINS;
  end;

  /// Registro 1500 - Lista

  TRegistro1500List = class(TList)
  private
    function GetItem(Index: Integer): TRegistro1500;
    procedure SetItem(Index: Integer; const Value: TRegistro1500);
  public
    destructor Destroy; override;
    function New: TRegistro1500;
    property Items[Index: Integer]: TRegistro1500 read GetItem write SetItem;
  end;

  /// Registro 1510 - ITENS DO DOCUMENTO NOTA FISCAL/CONTA ENERGIA EL�TRICA (C�DIGO 06).

  TRegistro1510 = class(TPersistent)
  private
    fNUM_ITEM: AnsiString;         /// N�mero seq�encial do item no documento fiscal
    fCOD_ITEM: AnsiString;         /// C�digo do item (campo 02 do Registro 0200)
    fCOD_CLASS: AnsiString;        /// C�digo de classifica��o do item de energia el�trica, conforme a Tabela 4.4.1
    fQTD: currency;            /// Quantidade do item
    fUNID: AnsiString;             /// Unidade do item (Campo 02 do registro 0190)
    fVL_ITEM: currency;        /// Valor do item
    fVL_DESC: currency;        /// Valor total do desconto
    fCST_ICMS: AnsiString;         /// C�digo da Situa��o Tribut�ria, conforme a Tabela indicada no item 4.3.1
    fCFOP: AnsiString;             /// C�digo Fiscal de Opera��o e Presta��o
    fVL_BC_ICMS: currency;     /// Valor da base de c�lculo do ICMS
    fALIQ_ICMS: currency;      /// Al�quota do ICMS
    fVL_ICMS: currency;        /// Valor do ICMS creditado/debitado
    fVL_BC_ICMS_ST: currency;  /// Valor da base de c�lculo referente � substitui��o tribut�ria
    fALIQ_ST: currency;        /// Al�quota do ICMS da substitui��o tribut�ria na unidade da federa��o de destino
    fVL_ICMS_ST: currency;     /// Valor do ICMS referente � substitui��o tribut�ria
    fIND_REC: AnsiString;          /// Indicador do tipo de receita:
    fCOD_PART: AnsiString;         /// C�digo do participante receptor da receita, terceiro da opera��o (campo 02 do Registro 0150)
    fVL_PIS: currency;         /// Valor do PIS
    fVL_COFINS: currency;      /// Valor da COFINS
    fCOD_CTA: AnsiString;          /// C�digo da conta anal�tica cont�bil debitada/creditada
  public
    property NUM_ITEM: AnsiString read FNUM_ITEM write FNUM_ITEM;
    property COD_ITEM: AnsiString read FCOD_ITEM write FCOD_ITEM;
    property COD_CLASS: AnsiString read FCOD_CLASS write FCOD_CLASS;
    property QTD: currency read FQTD write FQTD;
    property UNID: AnsiString read FUNID write FUNID;
    property VL_ITEM: currency read FVL_ITEM write FVL_ITEM;
    property VL_DESC: currency read FVL_DESC write FVL_DESC;
    property CST_ICMS: AnsiString read FCST_ICMS write FCST_ICMS;
    property CFOP: AnsiString read FCFOP write FCFOP;
    property VL_BC_ICMS: currency read FVL_BC_ICMS write FVL_BC_ICMS;
    property ALIQ_ICMS: currency read FALIQ_ICMS write FALIQ_ICMS;
    property VL_ICMS: currency read FVL_ICMS write FVL_ICMS;
    property VL_BC_ICMS_ST: currency read FVL_BC_ICMS_ST write FVL_BC_ICMS_ST;
    property ALIQ_ST: currency read FALIQ_ST write FALIQ_ST;
    property VL_ICMS_ST: currency read FVL_ICMS_ST write FVL_ICMS_ST;
    property IND_REC: AnsiString read FIND_REC write FIND_REC;
    property COD_PART: AnsiString read FCOD_PART write FCOD_PART;
    property VL_PIS: currency read FVL_PIS write FVL_PIS;
    property VL_COFINS: currency read FVL_COFINS write FVL_COFINS;
    property COD_CTA: AnsiString read FCOD_CTA write FCOD_CTA;
  end;

  /// Registro 1510 - Lista

  TRegistro1510List = class(TList)
  private
    function GetItem(Index: Integer): TRegistro1510;
    procedure SetItem(Index: Integer; const Value: TRegistro1510);
  public
    destructor Destroy; override;
    function New: TRegistro1510;
    property Items[Index: Integer]: TRegistro1510 read GetItem write SetItem;
  end;

  /// Registro 1600 - TOTAL DAS OPERA��ES COM CART�O DE CR�DITO E/OU D�BITO

  TRegistro1600 = class(TPersistent)
  private
    fCOD_PART: AnsiString;         /// N�mero seq�encial do item no documento fiscal
    fTOT_CREDITO: currency;    /// Valor do item
    fTOT_DEBITO: currency;     /// Valor total do desconto
  public
    property COD_PART: AnsiString read FCOD_PART write FCOD_PART;
    property TOT_CREDITO: currency read FTOT_CREDITO write FTOT_CREDITO;
    property TOT_DEBITO: currency read FTOT_DEBITO write FTOT_DEBITO;
  end;

  /// Registro 1600 - Lista

  TRegistro1600List = class(TList)
  private
    function GetItem(Index: Integer): TRegistro1600;
    procedure SetItem(Index: Integer; const Value: TRegistro1600);
  public
    destructor Destroy; override;
    function New: TRegistro1600;
    property Items[Index: Integer]: TRegistro1600 read GetItem write SetItem;
  end;

  /// Registro 1990 - ENCERRAMENTO DO BLOCO 1

  TRegistro1990 = class(TPersistent)
  private
    fQTD_LIN_1: Integer; /// Quantidade total de linhas do Bloco 1
  public
    property QTD_LIN_1: Integer read fQTD_LIN_1 write fQTD_LIN_1;
  end;

implementation

{ TRegistro1100List }

destructor TRegistro1100List.Destroy;
var
intFor: integer;
begin
  for intFor := 0 to Count - 1 do Items[intFor].Free;
  inherited;
end;

function TRegistro1100List.GetItem(Index: Integer): TRegistro1100;
begin
  Result := TRegistro1100(Inherited Items[Index]);
end;

function TRegistro1100List.New: TRegistro1100;
begin
  Result := TRegistro1100.Create;
  Add(Result);
end;

procedure TRegistro1100List.SetItem(Index: Integer; const Value: TRegistro1100);
begin
  Put(Index, Value);
end;

{ TRegistro1105List }

destructor TRegistro1105List.Destroy;
var
intFor: integer;
begin
  for intFor := 0 to Count - 1 do Items[intFor].Free;
  inherited;
end;

function TRegistro1105List.GetItem(Index: Integer): TRegistro1105;
begin
  Result := TRegistro1105(Inherited Items[Index]);
end;

function TRegistro1105List.New: TRegistro1105;
begin
  Result := TRegistro1105.Create;
  Add(Result);
end;

procedure TRegistro1105List.SetItem(Index: Integer; const Value: TRegistro1105);
begin
  Put(Index, Value);
end;

{ TRegistro1110List }

destructor TRegistro1110List.Destroy;
var
intFor: integer;
begin
  for intFor := 0 to Count - 1 do Items[intFor].Free;
  inherited;
end;

function TRegistro1110List.GetItem(Index: Integer): TRegistro1110;
begin
  Result := TRegistro1110(Inherited Items[Index]);
end;

function TRegistro1110List.New: TRegistro1110;
begin
  Result := TRegistro1110.Create;
  Add(Result);
end;

procedure TRegistro1110List.SetItem(Index: Integer; const Value: TRegistro1110);
begin
  Put(Index, Value);
end;

{ TRegistro1200List }

destructor TRegistro1200List.Destroy;
var
intFor: integer;
begin
  for intFor := 0 to Count - 1 do Items[intFor].Free;
  inherited;
end;

function TRegistro1200List.GetItem(Index: Integer): TRegistro1200;
begin
  Result := TRegistro1200(Inherited Items[Index]);
end;

function TRegistro1200List.New: TRegistro1200;
begin
  Result := TRegistro1200.Create;
  Add(Result);
end;

procedure TRegistro1200List.SetItem(Index: Integer; const Value: TRegistro1200);
begin
  Put(Index, Value);
end;

{ TRegistro1210List }

destructor TRegistro1210List.Destroy;
var
intFor: integer;
begin
  for intFor := 0 to Count - 1 do Items[intFor].Free;
  inherited;
end;

function TRegistro1210List.GetItem(Index: Integer): TRegistro1210;
begin
  Result := TRegistro1210(Inherited Items[Index]);
end;

function TRegistro1210List.New: TRegistro1210;
begin
  Result := TRegistro1210.Create;
  Add(Result);
end;

procedure TRegistro1210List.SetItem(Index: Integer; const Value: TRegistro1210);
begin
  Put(Index, Value);
end;

{ TRegistro1300List }

destructor TRegistro1300List.Destroy;
var
intFor: integer;
begin
  for intFor := 0 to Count - 1 do Items[intFor].Free;
  inherited;
end;

function TRegistro1300List.GetItem(Index: Integer): TRegistro1300;
begin
  Result := TRegistro1300(Inherited Items[Index]);
end;

function TRegistro1300List.New: TRegistro1300;
begin
  Result := TRegistro1300.Create;
  Add(Result);
end;

procedure TRegistro1300List.SetItem(Index: Integer; const Value: TRegistro1300);
begin
  Put(Index, Value);
end;

{ TRegistro1310List }

destructor TRegistro1310List.Destroy;
var
intFor: integer;
begin
  for intFor := 0 to Count - 1 do Items[intFor].Free;
  inherited;
end;

function TRegistro1310List.GetItem(Index: Integer): TRegistro1310;
begin
  Result := TRegistro1310(Inherited Items[Index]);
end;

function TRegistro1310List.New: TRegistro1310;
begin
  Result := TRegistro1310.Create;
  Add(Result);
end;

procedure TRegistro1310List.SetItem(Index: Integer; const Value: TRegistro1310);
begin
  Put(Index, Value);
end;

{ TRegistro1320List }

destructor TRegistro1320List.Destroy;
var
intFor: integer;
begin
  for intFor := 0 to Count - 1 do Items[intFor].Free;
  inherited;
end;

function TRegistro1320List.GetItem(Index: Integer): TRegistro1320;
begin
  Result := TRegistro1320(Inherited Items[Index]);
end;

function TRegistro1320List.New: TRegistro1320;
begin
  Result := TRegistro1320.Create;
  Add(Result);
end;

procedure TRegistro1320List.SetItem(Index: Integer; const Value: TRegistro1320);
begin
  Put(Index, Value);
end;

{ TRegistro1400List }

destructor TRegistro1400List.Destroy;
var
intFor: integer;
begin
  for intFor := 0 to Count - 1 do Items[intFor].Free;
  inherited;
end;

function TRegistro1400List.GetItem(Index: Integer): TRegistro1400;
begin
  Result := TRegistro1400(Inherited Items[Index]);
end;

function TRegistro1400List.New: TRegistro1400;
begin
  Result := TRegistro1400.Create;
  Add(Result);
end;

procedure TRegistro1400List.SetItem(Index: Integer; const Value: TRegistro1400);
begin
  Put(Index, Value);
end;

{ TRegistro1500List }

destructor TRegistro1500List.Destroy;
var
intFor: integer;
begin
  for intFor := 0 to Count - 1 do Items[intFor].Free;
  inherited;
end;

function TRegistro1500List.GetItem(Index: Integer): TRegistro1500;
begin
  Result := TRegistro1500(Inherited Items[Index]);
end;

function TRegistro1500List.New: TRegistro1500;
begin
  Result := TRegistro1500.Create;
  Add(Result);
end;

procedure TRegistro1500List.SetItem(Index: Integer; const Value: TRegistro1500);
begin
  Put(Index, Value);
end;

{ TRegistro1510List }

destructor TRegistro1510List.Destroy;
var
intFor: integer;
begin
  for intFor := 0 to Count - 1 do Items[intFor].Free;
  inherited;
end;

function TRegistro1510List.GetItem(Index: Integer): TRegistro1510;
begin
  Result := TRegistro1510(Inherited Items[Index]);
end;

function TRegistro1510List.New: TRegistro1510;
begin
  Result := TRegistro1510.Create;
  Add(Result);
end;

procedure TRegistro1510List.SetItem(Index: Integer; const Value: TRegistro1510);
begin
  Put(Index, Value);
end;

{ TRegistro1350List }

destructor TRegistro1350List.Destroy;
var
intFor: integer;
begin
  for intFor := 0 to Count - 1 do Items[intFor].Free;
  inherited;
end;

function TRegistro1350List.GetItem(Index: Integer): TRegistro1350;
begin
    Result := TRegistro1350(Inherited Items[Index]);
end;

function TRegistro1350List.New: TRegistro1350;
begin
  Result := TRegistro1350.Create;
  Add(Result);
end;

procedure TRegistro1350List.SetItem(Index: Integer; const Value: TRegistro1350);
begin
  Put(Index, Value);
end;

{ TRegistro1360List }

destructor TRegistro1360List.Destroy;
var
intFor: integer;
begin
  for intFor := 0 to Count - 1 do Items[intFor].Free;
  inherited;
end;

function TRegistro1360List.GetItem(Index: Integer): TRegistro1360;
begin
    Result := TRegistro1360(Inherited Items[Index]);
end;

function TRegistro1360List.New: TRegistro1360;
begin
  Result := TRegistro1360.Create;
  Add(Result);
end;

procedure TRegistro1360List.SetItem(Index: Integer; const Value: TRegistro1360);
begin
  Put(Index, Value);
end;


{ TRegistro1370List }

destructor TRegistro1370List.Destroy;
var
intFor: integer;
begin
  for intFor := 0 to Count - 1 do Items[intFor].Free;
  inherited;
end;

function TRegistro1370List.GetItem(Index: Integer): TRegistro1370;
begin
    Result := TRegistro1370(Inherited Items[Index]);
end;

function TRegistro1370List.New: TRegistro1370;
begin
  Result := TRegistro1370.Create;
  Add(Result);
end;

procedure TRegistro1370List.SetItem(Index: Integer; const Value: TRegistro1370);
begin
  Put(Index, Value);
end;

{ TRegistro1600List }

destructor TRegistro1600List.Destroy;
var
intFor: integer;
begin
  for intFor := 0 to Count - 1 do Items[intFor].Free;
  inherited;
end;

function TRegistro1600List.GetItem(Index: Integer): TRegistro1600;
begin
  Result := TRegistro1600(Inherited Items[Index]);
end;

function TRegistro1600List.New: TRegistro1600;
begin
  Result := TRegistro1600.Create;
  Add(Result);
end;

procedure TRegistro1600List.SetItem(Index: Integer; const Value: TRegistro1600);
begin
  Put(Index, Value);
end;

end.
