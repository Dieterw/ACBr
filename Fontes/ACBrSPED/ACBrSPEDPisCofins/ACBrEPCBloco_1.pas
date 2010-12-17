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

unit ACBrEPCBloco_1;

interface

uses
  SysUtils, Classes, Contnrs, DateUtils;

type
  TRegistro1010List = class;
  TRegistro1020List = class;
  TRegistro1100List = class;
  TRegistro1101List = class;
  TRegistro1200List = class;
  TRegistro1210List = class;
  TRegistro1220List = class;
  TRegistro1300List = class;
  TRegistro1500List = class;
  TRegistro1501List = class;
  TRegistro1600List = class;
  TRegistro1610List = class;
  TRegistro1620List = class;
  TRegistro1700List = class;
  TRegistro1800List = class;
  TRegistro1809List = class;


  //REGISTRO 1001: ABERTURA DO BLOCO 1
  TRegistro1001 = class(TOpenBlocos)
  private
    FRegistro1001: TRegistro1001List;
  public
    constructor Create; virtual; /// Create
    destructor Destroy; override; /// Destroy

    property Registro1001: TRegistro1001List read FRegistro1001 write FRegistro1001;
  end;

  //REGISTRO 1010: PROCESSO REFERENCIADO – AÇÃO JUDICIAL
  TRegistro1010 = class
  private
    fNUM_PROC: string;	          //02	NUM_PROC	Identificação do Numero do Processo Judicial	C	020	-
    fID_SEC_JUD: string;	        //03	ID_SEC_JUD	Identificação da Seção Judiciária	C	-	-
    fID_VARA: string;	            //04	ID_VARA	Identificação da Vara	C	002	-
    fIND_NAT_ACAO: Integer;       //05	IND_NAT_ACAO	Indicador da Natureza da Ação Judicial, impetrada na Justiça Federal:01 – Decisão Judicial Transitada em Julgado, a favor da Pessoa Jurídica.02 – Decisão Judicial Não Transitada em Julgado, a favor da Pessoa Jurídica.03 – Decisão Judicial oriunda de Liminar em Mandado de Segurança.04 – Decisão Judicial oriunda de Liminar em Medida Cautelar.05 – Decisão Judicial oriunda de Antecipação de Tutela.06 - Decisão Judicial Vinculada a Depósito Administrativo ou Judicial em Montante Integral.07 – Medida Judicial em que a Pessoa Jurídica não é o autor.08 – Súmula Vinculante aprovada pelo STF.99 - Outros.	C	002*	-
    fDESC_DEC_JUD: string;        //06	DESC_DEC_JUD	Descrição Resumida dos Efeitos Tributários abrangidos pela Decisão Judicial proferida.	C	100	-
    fDT_SENT_JUD: TDateTime;	    //07	DT_SENT_JUD	Data da Sentença/Decisão Judicial	N	008*	-
  public
    property NUM_PROC: string read FNUM_PROC write FNUM_PROC;
    property ID_SEC_JUD: string read FID_SEC_JUD write FID_SEC_JUD;
    property ID_VARA: string read FID_VARA write FID_VARA;
    property IND_NAT_ACAO: Integer read FIND_NAT_ACAO write FIND_NAT_ACAO;
    property DESC_DEC_JUD: string read FDESC_DEC_JUD write FDESC_DEC_JUD;
    property DT_SENT_JUD: TDateTime read FDT_SENT_JUD write FDT_SENT_JUD;
  end;

  // Registro 1010 - Lista
  TRegistro1010List = class(TObjectList)
  private
    function GetItem(Index: Integer): TRegistro1010;
    procedure SetItem(Index: Integer; const Value: TRegistro1010);
  public
    function New: TRegistro1010;
    property Items[Index: Integer]: TRegistro1010 read GetItem write SetItem;
  end;


  //REGISTRO 1020: PROCESSO REFERENCIADO – PROCESSO ADMINISTRATIVO
  TRegistro1020 = class
  private
    fNUM_PROC: string;	          //02	NUM_PROC	Identificação do Processo Administrativo ou da Decisão Administrativa	C	020	-
    fIND_NAT_ACAO: Integer;       //03	IND_NAT_ACAO	Indicador da Natureza da Ação, decorrente de Processo Administrativo na Secretaria da Receita Federal do Brasil:01 – Processo Administrativo de Consulta;02 – Despacho Decisório;03 – Ato Declaratório Executivo;04 – Ato Declaratório Interpretativo;05 – Decisão Administrativa de DRJ ou do CARF;06 – Auto de Infração;99 – Outros	C	002*	-
    fDT_DEC_ADM: TDateTime;	      //04	DT_DEC_ADM	Data do Despacho/Decisão Administrativa	N	008*	-
  public
    property NUM_PROC: string read FNUM_PROC write FNUM_PROC;
    property IND_NAT_ACAO: Integer read FIND_NAT_ACAO write FIND_NAT_ACAO;
    property DT_DEC_ADM: TDateTime read FDT_DEC_ADM write FDT_DEC_ADM;
  end;

  // Registro 1020 - Lista
  TRegistro1020List = class(TObjectList)
  private
    function GetItem(Index: Integer): TRegistro1020;
    procedure SetItem(Index: Integer; const Value: TRegistro1020);
  public
    function New: TRegistro1020;
    property Items[Index: Integer]: TRegistro1020 read GetItem write SetItem;
  end;

  //REGISTRO 1100: CONTROLE DE CRÉDITOS FISCAIS – PIS/PASEP
  TRegistro1100 = class
  private
    fPER_APU_CRED: Integer;	             //02	PER_APU_CRED	Período de Apuração do Crédito (MM/AAAA)	N	006	-
    fORIG_CRED: Integer;	               //03	ORIG_CRED	Indicador da origem do crédito:01 – Crédito decorrente de operações próprias;02 – Crédito transferido por pessoa jurídica sucedida.	N	002*	-
    fCNPJ_SUC: Integer;	                 //04	CNPJ_SUC	CNPJ da pessoa jurídica cedente do crédito (se ORIG_CRED = 02).	N	014*	-
    fCOD_CRED: Integer;	                 //05	COD_CRED	Código do Tipo do Crédito, conforme Tabela 4.3.6.	N	003*	-
    fVL_CRED_APU: Currency;	             //06	VL_CRED_APU	Valor do Crédito apurado na Escrituração Fiscal Digital ou em demonstrativo DACON de períodos anteriores.  	N	-	02
    fVL_CRED_EXT_APU: Currency;	         //07	VL_CRED_EXT_APU	Valor de Crédito Extemporâneo Apurado (Registro 1101), referente a Período Anterior, Informado no Campo 02 – PER_APU_CRED	N	-	02
    fVL_TOT_CRED_APU: Currency;	         //08	VL_TOT_CRED_APU	Valor Total do Crédito Apurado (06 + 07)	N	-	02
    fVL_CRED_DESC_PA_ANT: Currency;	     //09	VL_CRED_DESC_PA_ANT	Valor do Crédito utilizado mediante Desconto, em Período(s)  Anterior(es).	N	-	02
    fVL_CRED_PER_PA_ANT: Currency;	     //10	VL_CRED_PER_PA_ANT	Valor do Crédito utilizado mediante Pedido de Ressarcimento, em Período(s) Anterior(es).	N	-	02
    fVL_CRED_DCOMP_PA_ANT: Currency;     //11	VL_CRED_DCOMP_PA_ANT	Valor do Crédito utilizado mediante Declaração de Compensação Intermediária (Crédito de Exportação), em Período(s) Anterior(es).	N	-	02
    fSD_CRED_DISP_EFD: Currency;	       //12	SD_CRED_DISP_EFD	Saldo do Crédito Disponível para Utilização neste Período de Escrituração (08 – 09 – 10 - 11).	N	-	02
    fVL_CRED_DESC_EFD: Currency;	       //13	VL_CRED_DESC_EFD	Valor do Crédito descontado neste período de escrituração.	N	-	02
    fVL_CRED_PER_EFD: Currency;	         //14	VL_CRED_PER_EFD	Valor do Crédito objeto de Pedido de Ressarcimento (PER) neste período de escrituração.	N	-	02
    fVL_CRED_DCOMP_EFD: Currency;	       //15	VL_CRED_DCOMP_EFD	Valor do Crédito utilizado mediante Declaração de Compensação Intermediária neste período de escrituração.	N	-	02
    fVL_CRED_TRANS: Currency;	           //16	VL_CRED_TRANS	Valor do crédito transferido em evento de cisão, fusão ou incorporação.	N	-	02
    fVL_CRED_OUT: Currency;	             //17	VL_CRED_OUT	Valor do crédito utilizado por outras formas.	N	-	02
    fSLD_CRED_FIM: Currency;	           //18	SLD_CRED_FIM	Saldo de créditos a utilizar em período de apuração futuro (12 – 13 – 14 – 15 – 16 - 17).	N	-	02
  public
    property PER_APU_CRED: Integer read FPER_APU_CRED write FPER_APU_CRED;
    property ORIG_CRED: Integer read FORIG_CRED write FORIG_CRED;
    property CNPJ_SUC: Integer read FCNPJ_SUC write FCNPJ_SUC;
    property COD_CRED: Integer read FCOD_CRED write FCOD_CRED;
    property VL_CRED_APU: Currency read FVL_CRED_APU write FVL_CRED_APU;
    property VL_CRED_EXT_APU: Currency read FVL_CRED_EXT_APU write FVL_CRED_EXT_APU;
    property VL_TOT_CRED_APU: Currency read FVL_TOT_CRED_APU write FVL_TOT_CRED_APU;
    property VL_CRED_DESC_PA_ANT: Currency read FVL_CRED_DESC_PA_ANT write FVL_CRED_DESC_PA_ANT;
    property VL_CRED_PER_PA_ANT: Currency read FVL_CRED_PER_PA_ANT write FVL_CRED_PER_PA_ANT;
    property VL_CRED_DCOMP_PA_ANT: Currency read FVL_CRED_DCOMP_PA_ANT write FVL_CRED_DCOMP_PA_ANT;
    property SD_CRED_DISP_EFD: Currency read FSD_CRED_DISP_EFD write FSD_CRED_DISP_EFD;
    property VL_CRED_DESC_EFD: Currency read FVL_CRED_DESC_EFD write FVL_CRED_DESC_EFD;
    property VL_CRED_PER_EFD: Currency read FVL_CRED_PER_EFD write FVL_CRED_PER_EFD;
    property VL_CRED_DCOMP_EFD: Currency read FVL_CRED_DCOMP_EFD write FVL_CRED_DCOMP_EFD;
    property VL_CRED_TRANS: Currency read FVL_CRED_TRANS write FVL_CRED_TRANS;
    property VL_CRED_OUT: Currency read FVL_CRED_OUT write FVL_CRED_OUT;
    property SLD_CRED_FIM: Currency read FSLD_CRED_FIM write FSLD_CRED_FIM;
  end;

  // Registro 1100 - Lista
  TRegistro1100List = class(TObjectList)
  private
    function GetItem(Index: Integer): TRegistro1100;
    procedure SetItem(Index: Integer; const Value: TRegistro1100);
  public
    function New: TRegistro1100;
    property Items[Index: Integer]: TRegistro1100 read GetItem write SetItem;
  end;

  //REGISTRO 1101: APURAÇÃO DE CRÉDITO EXTEMPORÂNEO - DOCUMENTOS E OPERAÇÕES DE PERÍODOS ANTERIORES – PIS/PASEP
  TRegistro1101 = class
  private
    fCOD_PART: string;	            //02	COD_PART	Código do participante (Campo 02 do Registro 0150)	C	060	-
    fCOD_ITEM: string;	            //03	COD_ITEM	Código do item (campo 02 do Registro 0200)	C	060	-
    fCOD_MOD: string;	              //04	COD_MOD	Código do modelo do documento fiscal, conforme a Tabela 4.1.1.	C	002*	-
    fSER: string;	                  //05	SER	Série do documento fiscal	C	004	-
    fSUB_SER: string;	              //06	SUB_SER	Subsérie do documento fiscal	C	003	-
    fNUM_DOC: Integer;	            //07	NUM_DOC	Número do documento fiscal	N	009	-
    fDT_OPER: TDateTime;	          //08	DT_OPER	Data da Operação (ddmmaaaa)	N	008*	-
    fCHV_NFE: Integer;	            //09	CHV_NFE	Chave da Nota Fiscal Eletrônica	N	044*	-
    fVL_OPER: Currency;	            //10	VL_OPER	Valor da Operação	N	-	02
    fCFOP: Integer;	                //11	CFOP	Código fiscal de operação e prestação	N	004*	-
    fNAT_BC_CRED: string;	          //12	NAT_BC_CRED	Código da Base de Cálculo do Crédito, conforme a Tabela indicada no item 4.3.7.	C	002*	-
    fIND_ORIG_CRED: Integer;	      //13	IND_ORIG_CRED	Indicador da origem do crédito:0 – Operação no Mercado Interno;1 – Operação de Importação	C	001*	-
    fCST_PIS: Integer;	            //14	CST_PIS	Código da Situação Tributária referente ao PIS/PASEP, conforme a Tabela indicada no item 4.3.3.	N	002*	-
    fVL_BC_PIS: Currency;	          //15	VL_BC_PIS	Base de Cálculo do Crédito de PIS/PASEP (em valor ou em quantidade).	N	-	03
    fALIQ_PIS: Currency;	          //16	ALIQ_PIS	Alíquota do PIS/PASEP (em percentual ou em reais).	N	-	04
    fVL_PIS: Currency;	            //17	VL_PIS	Valor do Crédito de PIS/PASEP.	N	-	02
    fCOD_CTA: string;	              //18	COD_CTA	Código da conta analítica contábil debitada/creditada.	C	060	-
    fCOD_CCUS: string;	            //19	COD_CCUS	Código do Centro de Custos.	C	060	-
    fDESC_COMPL: string;	          //20	DESC_COMPL	Descrição complementar do Documento/Operação.	C	-	-
    fPER_ESCRIT: Integer;	          //21	PER_ESCRIT	Mês/Ano da Escrituração em que foi registrado o documento/operação (Crédito pelo método da Apropriação Direta).	N	006*	-
    fCNPJ: Integer;	                //22	CNPJ	CNPJ do estabelecimento gerador do crédito extemporâneo (Campo 04  do Registro 0140)	N	014*	-
  public
    property COD_PART: string read FCOD_PART write FCOD_PART;
    property COD_ITEM: string read FCOD_ITEM write FCOD_ITEM;
    property COD_MOD: string read FCOD_MOD write FCOD_MOD;
    property SER: string read FSER write FSER;
    property SUB_SER: string read FSUB_SER write FSUB_SER;
    property NUM_DOC: Integer read FNUM_DOC write FNUM_DOC;
    property DT_OPER: TDateTime read FDT_OPER write FDT_OPER;
    property CHV_NFE: Integer read FCHV_NFE write FCHV_NFE;
    property VL_OPER: Currency read FVL_OPER write FVL_OPER;
    property CFOP: Integer read FCFOP write FCFOP;
    property NAT_BC_CRED: string read FNAT_BC_CRED write FNAT_BC_CRED;
    property IND_ORIG_CRED: Integer read FIND_ORIG_CRED write FIND_ORIG_CRED;
    property CST_PIS: Integer read FCST_PIS write FCST_PIS;
    property VL_BC_PIS: Currency read FVL_BC_PIS write FVL_BC_PIS;
    property ALIQ_PIS: Currency read FALIQ_PIS write FALIQ_PIS;
    property VL_PIS: Currency read FVL_PIS write FVL_PIS;
    property COD_CTA: string read FCOD_CTA write FCOD_CTA;
    property COD_CCUS: string read FCOD_CCUS write FCOD_CCUS;
    property DESC_COMPL: string read FDESC_COMPL write FDESC_COMPL;
    property PER_ESCRIT: Integer read FPER_ESCRIT write FPER_ESCRIT;
    property CNPJ: Integer read FCNPJ write FCNPJ;
  end;

  // Registro 1101 - Lista
  TRegistro1101List = class(TObjectList)
  private
    function GetItem(Index: Integer): TRegistro1101;
    procedure SetItem(Index: Integer; const Value: TRegistro1101);
  public
    function New: TRegistro1101;
    property Items[Index: Integer]: TRegistro1101 read GetItem write SetItem;
  end;

  //REGISTRO 1102: DETALHAMENTO DO CRÉDITO EXTEMPORANEO VINCULADO A MAIS DE UM TIPO DE RECEITA – PIS/PASEP
  TRegistro1102 = class
  private
    fVL_CRED_PIS_TRIB_MI: Currency;         //02	VL_CRED_PIS_TRIB_MI	Parcela do Crédito de PIS/PASEP, vinculada a Receita Tributada no Mercado Interno
    fVL_CRED_PIS_NT_MI: Currency;	          //03	VL_CRED_PIS_NT_MI	Parcela do Crédito de PIS/PASEP, vinculada a Receita Não Tributada no Mercado Interno
    fVL_CRED_PIS_EXP: Currency;	           //04	VL_CRED_PIS_ EXP	Parcela do Crédito de PIS/PASEP, vinculada a Receita de Exportação
  public
    property VL_CRED_PIS_TRIB_MI: Currency read FVL_CRED_PIS_TRIB_MI write FVL_CRED_PIS_TRIB_MI;
    property VL_CRED_PIS_NT_MI: Currency read FVL_CRED_PIS_NT_MI write FVL_CRED_PIS_NT_MI;
    property VL_CRED_PIS_EXP: Currency read FVL_CRED_PIS_EXP write FVL_CRED_PIS_EXP;
  end;

  //REGISTRO 1200: CONTRIBUIÇÃO SOCIAL EXTEMPORÂNEA – PIS/PASEP
  TRegistro1200 = class
  private
    fPER_APUR_ANT: Integer;            //02	PER_APUR_ANT	Período de Apuração da Contribuição Social Extemporânea (MMAAAA).	N	006*	-
    fNAT_CONT_REC: string;             //03	NAT_CONT_REC	Natureza da Contribuição a Recolher, conforme Tabela 4.3.5.	C	002	-
    fVL_CONT_APUR: Currency;           //04	VL_CONT_APUR	Valor da Contribuição Apurada.	N	-	02
    fVL_CRED_PIS_DESC: Currency;       //05	VL_CRED_PIS_DESC	Valor do Crédito de PIS/PASEP a Descontar, da Contribuição Social Extemporânea.	N	-	02
    fVL_CONT_DEV: Currency;	           //06	VL_CONT_DEV	Valor da Contribuição Social Extemporânea Devida.	N	-	02
    fVL_OUT_DED: Currency;	           //07	VL_OUT_DED	Valor de Outras Deduções.	N	-	02
    fVL_CONT_EXT: Currency;	           //08	VL_CONT_EXT	Valor da Contribuição Social Extemporânea a pagar.	N	-	02
    fVL_MUL: Currency;	               //09	VL_MUL	Valor da Multa.	N	-	02
    fVL_JUR: Currency;	               //10	VL_JUR	Valor dos Juros.	N	-	02
    fDT_RECOL: TDateTime;	             //11	DT_RECOL	Data do Recolhimento.	N	008*	-
  public
    property PER_APUR_ANT: Integer read FPER_APUR_ANT write FPER_APUR_ANT;
    property NAT_CONT_REC: string read FNAT_CONT_REC write FNAT_CONT_REC;
    property VL_CONT_APUR: Currency read FVL_CONT_APUR write FVL_CONT_APUR;
    property VL_CRED_PIS_DESC: Currency read FVL_CRED_PIS_DESC write FVL_CRED_PIS_DESC;
    property VL_CONT_DEV: Currency read FVL_CONT_DEV write FVL_CONT_DEV;
    property VL_OUT_DED: Currency read FVL_OUT_DED write FVL_OUT_DED;
    property VL_CONT_EXT: Currency read FVL_CONT_EXT write FVL_CONT_EXT;
    property VL_MUL: Currency read FVL_MUL write FVL_MUL;
    property VL_JUR: Currency read FVL_JUR write FVL_JUR;
    property DT_RECOL: TDateTime read FDT_RECOL write FDT_RECOL;
  end;

  // Registro 1200 - Lista
  TRegistro1200List = class(TObjectList)
  private
    function GetItem(Index: Integer): TRegistro1200;
    procedure SetItem(Index: Integer; const Value: TRegistro1200);
  public
    function New: TRegistro1200;
    property Items[Index: Integer]: TRegistro1200 read GetItem write SetItem;
  end;

  //REGISTRO 1210: DETALHAMENTO DA CONTRIBUIÇÃO SOCIAL EXTEMPORÂNEA – PIS/PASEP
  TRegistro1210 = class
  private
    fCNPJ: Integer;	              //02	CNPJ	Número de inscrição do estabelecimento no CNPJ (Campo 04 do Registro 0140).	N	014*	-
    fCST_PIS: Integer;	          //03	CST_PIS	Código da Situação Tributária referente ao PIS/PASEP, conforme a Tabela indicada no item 4.3.3.	N	002*	-
    fCOD_PART: string;	          //04	COD_PART	Código do participante (Campo 02 do Registro 0150)	C	060	-
    fDT_OPER: TDateTime;	        //05	DT_OPER	Data da Operação (ddmmaaaa)	N	008*	-
    fVL_OPER: Currency;	          //06	VL_OPER	Valor da Operação	N	-	02
    fVL_BC_PIS: Currency;	        //07	VL_BC_PIS	Base de cálculo do PIS/PASEP (em valor ou em quantidade)	N	-	03
    fALIQ_PIS: Currency;	        //08	ALIQ_PIS	Alíquota da PIS (em percentual ou em reais)	N	-	04
    fVL_PIS: Currency;	          //09	VL_PIS	Valor do PIS/PASEP	N	-	02
    fCOD_CTA: string;	            //10	COD_CTA	Código da conta analítica contábil debitada/creditada	C	060	-
    fDESC_COMPL: string;          //11	DESC_COMPL	Descrição complementar do Documento/Operação	C	-	-
  public
    property CNPJ: Integer read FCNPJ write FCNPJ;
    property CST_PIS: Integer read FCST_PIS write FCST_PIS;
    property COD_PART: string read FCOD_PART write FCOD_PART;
    property DT_OPER: TDateTime read FDT_OPER write FDT_OPER;
    property VL_OPER: Currency read FVL_OPER write FVL_OPER;
    property VL_BC_PIS: Currency read FVL_BC_PIS write FVL_BC_PIS;
    property ALIQ_PIS: Currency read FALIQ_PIS write FALIQ_PIS;
    property VL_PIS: Currency read FVL_PIS write FVL_PIS;
    property COD_CTA: string read FCOD_CTA write FCOD_CTA;
    property DESC_COMPL: string read FDESC_COMPL write FDESC_COMPL;
  end;

  // Registro 1210 - Lista
  TRegistro1210List = class(TObjectList)
  private
    function GetItem(Index: Integer): TRegistro1210;
    procedure SetItem(Index: Integer; const Value: TRegistro1210);
  public
    function New: TRegistro1210;
    property Items[Index: Integer]: TRegistro1210 read GetItem write SetItem;
  end;

  //REGISTRO 1220: DEMONSTRAÇÃO DO CRÉDITO A DESCONTAR DA CONTRIBUIÇÃO EXTEMPORÂNEA – PIS/PASEP
  TRegistro1220 = class
  private
    fPER_APU_CRED: Integer;        //02	PER_APU_CRED	Período de Apuração do Crédito (MM/AAAA)	N	006	-
    fORIG_CRED: Integer;	         //03	ORIG_CRED	Indicador da origem do crédito:01 – Crédito decorrente de operações próprias;02 – Crédito transferido por pessoa jurídica sucedida.	N	002*	-
    fCOD_CRED: Integer;	           //04	COD_CRED	Código do Tipo do Crédito, conforme Tabela 4.3.6.	N	003*	-
    fVL_CRED: Currency;	           //05	VL_CRED	Valor do Crédito a Descontar	N	-	002
  public
    property PER_APU_CRED: Integer read FPER_APU_CRED write FPER_APU_CRED;
    property ORIG_CRED: Integer read FORIG_CRED write FORIG_CRED;
    property COD_CRED: Integer read FCOD_CRED write FCOD_CRED;
    property VL_CRED: Currency read FVL_CRED write FVL_CRED;
  end;

  // Registro 1220 - Lista
  TRegistro1220List = class(TObjectList)
  private
    function GetItem(Index: Integer): TRegistro1220;
    procedure SetItem(Index: Integer; const Value: TRegistro1220);
  public
    function New: TRegistro1220;
    property Items[Index: Integer]: TRegistro1220 read GetItem write SetItem;
  end;

  //REGISTRO 1300: CONTROLE DOS VALORES RETIDOS NA FONTE – PIS/PASEP
  TRegistro1300 = class
  private
    fIND_NAT_RET: Integer;	         //02	IND_NAT_RET	Indicador de Natureza da Retenção na Fonte:01 - Retenção por Órgãos, Autarquias e Fundações Federais;02 - Retenção por outras Entidades da Administração Pública Federal;03 - Retenção por Pessoas Jurídicas de Direito Privado;04 - Recolhimento por Sociedade Cooperativa;05 - Retenção por Fabricante de Máquinas e Veículos;99 - Outras Retenções	N	002*	-
    fPR_REC_RET: Integer;	           //03	PR_REC_RET	Período do Recebimento e da Retenção (MM/AAAA)	N	006	-
    fVL_RET_APU: Currency;	         //04	VL_RET_APU	Valor Total da Retenção	N	-	02
    fVL_RET_DED: Currency;	         //05	VL_RET_DED	Valor da Retenção deduzida da Contribuição Devida	N	-	02
    fVL_RET_PER: Currency;	         //06	VL_RET_PER	Valor da Retenção utilizada mediante Pedido de Restituição.	N	-	02
    fVL_RET_DCOMP: Currency;         //07	VL_RET_DCOMP	Valor da Retenção utilizada mediante Declaração de Compensação.	N	-	02
    fSLD_RET: Currency;              //08	SLD_RET	Saldo de Retenção a utilizar em períodos de apuração futuros (04 – 05 - 06 - 07).	N	-	02
  public
    property IND_NAT_RET: Integer read FIND_NAT_RET write FIND_NAT_RET;
    property PR_REC_RET: Integer read FPR_REC_RET write FPR_REC_RET;
    property VL_RET_APU: Currency read FVL_RET_APU write FVL_RET_APU;
    property VL_RET_DED: Currency read FVL_RET_DED write FVL_RET_DED;
    property VL_RET_PER: Currency read FVL_RET_PER write FVL_RET_PER;
    property VL_RET_DCOMP: Currency read FVL_RET_DCOMP write FVL_RET_DCOMP;
    property SLD_RET: Currency read FSLD_RET write FSLD_RET;
  end;

  // Registro 1300 - Lista
  TRegistro1300List = class(TObjectList)
  private
    function GetItem(Index: Integer): TRegistro1300;
    procedure SetItem(Index: Integer; const Value: TRegistro1300);
  public
    function New: TRegistro1300;
    property Items[Index: Integer]: TRegistro1300 read GetItem write SetItem;
  end;

  //REGISTRO 1500: CONTROLE DE CRÉDITOS FISCAIS – COFINS
  TRegistro1500 = class
  private
    fPER_APU_CRED: Integer;	            //02	PER_APU_CRED	Período de Apuração do Crédito (MM/AAAA)	N	006	-
    fORIG_CRED: Integer;	              //03	ORIG_CRED	Indicador da origem do crédito:01 – Crédito decorrente de operações próprias;02 – Crédito transferido por pessoa jurídica sucedida.	N	002*	-
    fCNPJ_SUC: Integer;	                //04	CNPJ_SUC	CNPJ da pessoa jurídica cedente do crédito (se ORIG_CRED = 02).	N	014*	-
    fCOD_CRED: Integer;	                //05	COD_CRED	Código do Tipo do Crédito, conforme Tabela 4.3.6.	N	003*	-
    fVL_CRED_APU: Currency;	            //06	VL_CRED_APU	Valor do Crédito apurado na Escrituração Fiscal Digital ou em demonstrativo DACON de períodos anteriores.	N	-	02
    fVL_CRED_EXT_APU: Currency;	        //07	VL_CRED_EXT_APU	Valor de Crédito Extemporâneo Apurado (Registro 1501), referente a Período Anterior, Informado no Campo 02 – PER_APU_CRED	N	-	02
    fVL_TOT_CRED_APU: Currency;	        //08	VL_TOT_CRED_APU	Valor Total do Crédito Apurado (06 + 07)	N	-	02
    fVL_CRED_DESC_PA_ANT: Currency;	    //09	VL_CRED_DESC_PA_ANT	Valor do Crédito utilizado mediante Desconto, em Período(s)  Anterior(es) 	N	-	02
    fVL_CRED_PER_PA_ANT: Currency;	    //10	VL_CRED_PER_PA_ANT	Valor do Crédito utilizado mediante Pedido de Ressarcimento, em Período(s) Anterior(es).	N	-	02
    fVL_CRED_DCOMP_PA_ANT: Currency;    //11	VL_CRED_DCOMP_PA_ANT	Valor do Crédito utilizado mediante Declaração de Compensação Intermediária (Crédito de Exportação), em Período(s) Anterior(es)	N	-	02
    fSD_CRED_DISP_EFD: Currency;	      //12	SD_CRED_DISP_EFD	Saldo do Crédito Disponível para Utilização neste Período de Escrituração (08-09-10-11)	N	-	02
    fVL_CRED_DESC_EFD: Currency;	      //13	VL_CRED_DESC_EFD	Valor do Crédito descontado neste período de escrituração	N	-	02
    fVL_CRED_PER_EFD: Currency;	        //14	VL_CRED_PER_EFD	Valor do Crédito objeto de Pedido de Ressarcimento (PER) neste período de escrituração	N	-	02
    fVL_CRED_DCOMP_EFD: Currency;	      //15	VL_CRED_DCOMP_EFD	Valor do Crédito utilizado mediante Declaração de Compensação Intermediária neste período de escrituração	N	-	02
    fVL_CRED_TRANS: Currency;	          //16	VL_CRED_TRANS	Valor do crédito transferido em evento de cisão, fusão ou incorporação	N	-	02
    fVL_CRED_OUT: Currency;	            //17	VL_CRED_OUT	Valor do crédito utilizado por outras formas	N	-	02
    fSLD_CRED_FIM: Currency;	          //18	SLD_CRED_FIM	Saldo de créditos a utilizar em período de apuração futuro (12-13-14-15-16-17).	N	-	02
  public
    property PER_APU_CRED: Integer read FPER_APU_CRED write FPER_APU_CRED;
    property ORIG_CRED: Integer read FORIG_CRED write FORIG_CRED;
    property CNPJ_SUC: Integer read FCNPJ_SUC write FCNPJ_SUC;
    property COD_CRED: Integer read FCOD_CRED write FCOD_CRED;
    property VL_CRED_APU: Currency read FVL_CRED_APU write FVL_CRED_APU;
    property VL_CRED_EXT_APU: Currency read FVL_CRED_EXT_APU write FVL_CRED_EXT_APU;
    property VL_TOT_CRED_APU: Currency read FVL_TOT_CRED_APU write FVL_TOT_CRED_APU;
    property VL_CRED_DESC_PA_ANT: Currency read FVL_CRED_DESC_PA_ANT write FVL_CRED_DESC_PA_ANT;
    property VL_CRED_PER_PA_ANT: Currency read FVL_CRED_PER_PA_ANT write FVL_CRED_PER_PA_ANT;
    property VL_CRED_DCOMP_PA_ANT: Currency read FVL_CRED_DCOMP_PA_ANT write FVL_CRED_DCOMP_PA_ANT;
    property SD_CRED_DISP_EFD: Currency read FSD_CRED_DISP_EFD write FSD_CRED_DISP_EFD;
    property VL_CRED_DESC_EFD: Currency read FVL_CRED_DESC_EFD write FVL_CRED_DESC_EFD;
    property VL_CRED_PER_EFD: Currency read FVL_CRED_PER_EFD write FVL_CRED_PER_EFD;
    property VL_CRED_DCOMP_EFD: Currency read FVL_CRED_DCOMP_EFD write FVL_CRED_DCOMP_EFD;
    property VL_CRED_TRANS: Currency read FVL_CRED_TRANS write FVL_CRED_TRANS;
    property VL_CRED_OUT: Currency read FVL_CRED_OUT write FVL_CRED_OUT;
    property SLD_CRED_FIM: Currency read FSLD_CRED_FIM write FSLD_CRED_FIM;
  end;

  // Registro 1500 - Lista
  TRegistro1500List = class(TObjectList)
  private
    function GetItem(Index: Integer): TRegistro1500;
    procedure SetItem(Index: Integer; const Value: TRegistro1500);
  public
    function New: TRegistro1500;
    property Items[Index: Integer]: TRegistro1500 read GetItem write SetItem;
  end;

  //REGISTRO 1501: APURAÇÃO DE CRÉDITO EXTEMPORÂNEO - DOCUMENTOS E OPERAÇÕES DE PERÍODOS ANTERIORES – COFINS
  TRegistro1501 = class
  private
    fCOD_PART: string;	            //02	COD_PART	Código do participante (Campo 02 do Registro 0150)	C	060	-
    fCOD_ITEM: string;	            //03	COD_ITEM	Código do item (campo 02 do Registro 0200)	C	060	-
    fCOD_MOD: string;	              //04	COD_MOD	Código do modelo do documento fiscal, conforme a Tabela 4.1.1.	C	002*	-
    fSER:string;	                  //05	SER	Série do documento fiscal	C	004	-
    fSUB_SER: string;	              //06	SUB_SER	Subsérie do documento fiscal	C	003	-
    fNUM_DOC: Integer;	            //07	NUM_DOC	Número do documento fiscal	N	009	-
    fDT_OPER: TDateTime;	          //08	DT_OPER	Data da Operação (ddmmaaaa)	N	008*	-
    fCHV_NFE: Integer;	            //09	CHV_NFE	Chave da Nota Fiscal Eletrônica	N	044*	-
    fVL_OPER: Currency;	            //10	VL_OPER	Valor da Operação	N	-	02
    fCFOP: Integer;	                //11	CFOP	Código fiscal de operação e prestação	N	004*	-
    fNAT_BC_CRED: string;	          //12	NAT_BC_CRED	Código da Base de Cálculo do Crédito, conforme a Tabela indicada no item 4.3.7.	C	002*	-
    fIND_ORIG_CRED: Integer;        //13	IND_ORIG_CRED	Indicador da origem do crédito:0 – Operação no Mercado Interno;1 – Operação de Importação	C	001*	-
    fCST_COFINS: Integer;	          //14	CST_COFINS	Código da Situação Tributária referente ao COFINS, conforme a Tabela indicada no item 4.3.4.	N	002*	-
    fVL_BC_COFINS: Currency;        //15	VL_BC_COFINS	Base de Cálculo do Crédito de COFINS (em valor ou em quantidade)	N	-	03
    fALIQ_COFINS: Currency;	        //16	ALIQ_COFINS	Alíquota do COFINS (em percentual ou em reais)	N	-	04
    fVL_COFINS: Currency;	          //17	VL_COFINS	Valor do Crédito de COFINS	N	-	02
    fCOD_CTA: string;	              //18	COD_CTA	Código da conta analítica contábil debitada/creditada	C	060	-
    fCOD_CCUS: string;	            //19	COD_CCUS	Código do Centro de Custos	C	060	-
    fDESC_COMPL: string;	          //20	DESC_COMPL	Descrição complementar do Documento/Operação	C	-	-
    fPER_ESCRIT: Integer;	          //21	PER_ESCRIT	Mês/Ano da Escrituração em que foi registrado o documento/operação (Crédito pelo método da Apropriação Direta).	N	006*	-
    fCNPJ: Integer;	                //22	CNPJ	CNPJ do estabelecimento gerador do crédito extemporâneo (Campo 04  do Registro 0140)	N	014*	-
  public
    property COD_PART: string read FCOD_PART write FCOD_PART;
    property COD_ITEM: string read FCOD_ITEM write FCOD_ITEM;
    property COD_MOD: string read FCOD_MOD write FCOD_MOD;
    property SER:string read FSER write FSER;
    property SUB_SER: string read FSUB_SER write FSUB_SER;
    property NUM_DOC: Integer read FNUM_DOC write FNUM_DOC;
    property DT_OPER: TDateTime read FDT_OPER write FDT_OPER;
    property CHV_NFE: Integer read FCHV_NFE write FCHV_NFE;
    property VL_OPER: Currency read FVL_OPER write FVL_OPER;
    property CFOP: Integer read FCFOP write FCFOP;
    property NAT_BC_CRED: string read FNAT_BC_CRED write FNAT_BC_CRED;
    property IND_ORIG_CRED: Integer read FIND_ORIG_CRED write FIND_ORIG_CRED;
    property CST_COFINS: Integer read FCST_COFINS write FCST_COFINS;
    property VL_BC_COFINS: Currency read FVL_BC_COFINS write FVL_BC_COFINS;
    property ALIQ_COFINS: Currency read FALIQ_COFINS write FALIQ_COFINS;
    property VL_COFINS: Currency read FVL_COFINS write FVL_COFINS;
    property COD_CTA: string read FCOD_CTA write FCOD_CTA;
    property COD_CCUS: string read FCOD_CCUS write FCOD_CCUS;
    property DESC_COMPL: string read FDESC_COMPL write FDESC_COMPL;
    property PER_ESCRIT: Integer read FPER_ESCRIT write FPER_ESCRIT;
    property CNPJ: Integer read FCNPJ write FCNPJ;
  end;

  // Registro 1501 - Lista
  TRegistro1501List = class(TObjectList)
  private
    function GetItem(Index: Integer): TRegistro1501;
    procedure SetItem(Index: Integer; const Value: TRegistro1501);
  public
    function New: TRegistro1501;
    property Items[Index: Integer]: TRegistro1501 read GetItem write SetItem;
  end;

  //REGISTRO 1502: DETALHAMENTO DO CRÉDITO EXTEMPORÂNEO VINCULADO A MAIS DE UM TIPO DE RECEITA – COFINS
  TRegistro1502 = class
  private
    fVL_CRED_COFINS_TRIB_MI: Currency;      //02	VL_CRED_COFINS_TRIB_MI	Parcela do Crédito de COFINS, vinculada a Receita Tributada no Mercado Interno	N	-	02
    fVL_CRED_COFINS_NT_MI: Currency;	      //03	VL_CRED_COFINS_NT_MI	Parcela do Crédito de COFINS, vinculada a Receita Não Tributada no Mercado Interno	N	-	02
    fVL_CRED_COFINS_EXP: Currency;	        //03? repetiu o numero do campo no manual	VL_CRED_COFINS_ EXP	Parcela do Crédito de COFINS, vinculada a Receita de Exportação	N	-	02
  public
    property VL_CRED_COFINS_TRIB_MI: Currency read FVL_CRED_COFINS_TRIB_MI write FVL_CRED_COFINS_TRIB_MI;
    property VL_CRED_COFINS_NT_MI: Currency read FVL_CRED_COFINS_NT_MI write FVL_CRED_COFINS_NT_MI;
    property VL_CRED_COFINS_EXP: Currency read FVL_CRED_COFINS_EXP write FVL_CRED_COFINS_EXP;
  end;

  //REGISTRO 1600: CONTRIBUIÇÃO SOCIAL EXTEMPORÂNEA – COFINS
  TRegistro1600 = class
  private
    fPER_APUR_ANT: Integer;	                //02	PER_APUR_ANT	Período de Apuração da Contribuição Social Extemporânea (MMAAAA)	N	006*	-
    fNAT_CONT_REC: string;	                //03	NAT_CONT_REC	Natureza da Contribuição a Recolher, conforme Tabela 4.3.5.	C	002	-
    fVL_CONT_APUR: Currency;	              //04	VL_CONT_APUR	Valor da Contribuição Apurada	N	-	02
    fVL_CRED_COFINS_DESC: Currency;         //05	VL_CRED_COFINS_DESC	Valor do Crédito de COFINS a Descontar, da Contribuição Social Extemporânea.	N	-	02
    fVL_CONT_DEV: Currency;	                //06	VL_CONT_DEV	Valor da Contribuição Social Extemporânea Devida.	N	-	02
    fVL_OUT_DED: Currency;	                //07	VL_OUT_DED	Valor de Outras Deduções.	N	-	02
    fVL_CONT_EXT: Currency;	                //08	VL_CONT_EXT	Valor da Contribuição Social Extemporânea a pagar.	N	-	02
    fVL_MUL: Currency;	                    //09	VL_MUL	Valor da Multa.	N	-	02
    fVL_JUR: Currency;	                    //10	VL_JUR	Valor dos Juros.	N	-	02
    fDT_RECOL: TDateTime;	                  //11	DT_RECOL	Data do Recolhimento.	N	008*	-
  public
    property PER_APUR_ANT: Integer read FPER_APUR_ANT write FPER_APUR_ANT;
    property NAT_CONT_REC: string read FNAT_CONT_REC write FNAT_CONT_REC;
    property VL_CONT_APUR: Currency read FVL_CONT_APUR write FVL_CONT_APUR;
    property VL_CRED_COFINS_DESC: Currency read FVL_CRED_COFINS_DESC write FVL_CRED_COFINS_DESC;
    property VL_CONT_DEV: Currency read FVL_CONT_DEV write FVL_CONT_DEV;
    property VL_OUT_DED: Currency read FVL_OUT_DED write FVL_OUT_DED;
    property VL_CONT_EXT: Currency read FVL_CONT_EXT write FVL_CONT_EXT;
    property VL_MUL: Currency read FVL_MUL write FVL_MUL;
    property VL_JUR: Currency read FVL_JUR write FVL_JUR;
    property DT_RECOL: TDateTime read FDT_RECOL write FDT_RECOL;
  end;

  // Registro 1600 - Lista
  TRegistro1600List = class(TObjectList)
  private
    function GetItem(Index: Integer): TRegistro1600;
    procedure SetItem(Index: Integer; const Value: TRegistro1600);
  public
    function New: TRegistro1600;
    property Items[Index: Integer]: TRegistro1600 read GetItem write SetItem;
  end;

  //REGISTRO 1610: DETALHAMENTO DA CONTRIBUIÇÃO SOCIAL EXTEMPORÂNEA – COFINS
  TRegistro1610 = class
  private
    fCNPJ: Integer;	                //02	CNPJ	Número de inscrição do estabelecimento no CNPJ (Campo 04 do Registro 0140).	N	014*	-
    fCST_COFINS: Integer;	          //03	CST_COFINS	Código da Situação Tributária referente a COFINS, conforme a Tabela indicada no item 4.3.4.	N	002*	-
    fCOD_PART: string;	            //04	COD_PART	Código do participante (Campo 02 do Registro 0150)	C	060	-
    fDT_OPER: TDateTime;	          //05	DT_OPER	Data da Operação (ddmmaaaa)	N	008*	-
    fVL_OPER: Currency;	            //06	VL_OPER	Valor da Operação	N	-	02
    fVL_BC_COFINS: Currency;        //07	VL_BC_COFINS	Base de cálculo da COFINS (em valor ou em quantidade)	N	-	03
    fALIQ_COFINS: Currency;	        //08	ALIQ_COFINS	Alíquota da COFINS (em percentual ou em reais)	N	-	04
    fVL_COFINS: Currency;	          //09	VL_COFINS	Valor da COFINS	N	-	02
    fCOD_CTA: string;	              //10	COD_CTA	Código da conta analítica contábil debitada/creditada	C	060	-
    fDESC_COMPL: string;	          //11	DESC_COMPL	Descrição complementar do Documento/Operação	C	-	-
  public
    property CNPJ: Integer read FCNPJ write FCNPJ;
    property CST_COFINS: Integer read FCST_COFINS write FCST_COFINS;
    property COD_PART: string read FCOD_PART write FCOD_PART;
    property DT_OPER: TDateTime read FDT_OPER write FDT_OPER;
    property VL_OPER: Currency read FVL_OPER write FVL_OPER;
    property VL_BC_COFINS: Currency read FVL_BC_COFINS write FVL_BC_COFINS;
    property ALIQ_COFINS: Currency read FALIQ_COFINS write FALIQ_COFINS;
    property VL_COFINS: Currency read FVL_COFINS write FVL_COFINS;
    property COD_CTA: string read FCOD_CTA write FCOD_CTA;
    property DESC_COMPL: string read FDESC_COMPL write FDESC_COMPL;
  end;

  // Registro 1610 - Lista
  TRegistro1610List = class(TObjectList)
  private
    function GetItem(Index: Integer): TRegistro1610;
    procedure SetItem(Index: Integer; const Value: TRegistro1610);
  public
    function New: TRegistro1610;
    property Items[Index: Integer]: TRegistro1610 read GetItem write SetItem;
  end;

  //REGISTRO 1620: DEMONSTRAÇÃO DO CRÉDITO A DESCONTAR DA CONTRIBUIÇÃO EXTEMPORÂNEA – COFINS
  TRegistro1620 = class
  private
    fPER_APU_CRED: Integer;         //02	PER_APU_CRED	Período de Apuração do Crédito (MM/AAAA)	N	006	-
    fORIG_CRED: Integer;	          //03	ORIG_CRED	Indicador da origem do crédito:01 – Crédito decorrente de operações próprias;02 – Crédito transferido por pessoa jurídica sucedida.	N	002*	-
    fCOD_CRED: Integer;	            //04	COD_CRED	Código do Tipo do Crédito, conforme Tabela 4.3.6.	N	003*	-
    fVL_CRED: Currency;	            //05	VL_CRED	Valor do Crédito a Descontar	N	-	002
  public
    property PER_APU_CRED: Integer read FPER_APU_CRED write FPER_APU_CRED;
    property ORIG_CRED: Integer read FORIG_CRED write FORIG_CRED;
    property COD_CRED: Integer read FCOD_CRED write FCOD_CRED;
    property VL_CRED: Currency read FVL_CRED write FVL_CRED;
  end;

  // Registro 1620 - Lista
  TRegistro1620List = class(TObjectList)
  private
    function GetItem(Index: Integer): TRegistro1620;
    procedure SetItem(Index: Integer; const Value: TRegistro1620);
  public
    function New: TRegistro1620;
    property Items[Index: Integer]: TRegistro1620 read GetItem write SetItem;
  end;

  //REGISTRO 1700: CONTROLE DOS VALORES RETIDOS NA FONTE – COFINS
  TRegistro1700 = class
  private
    fIND_NAT_RET: Integer;	         //02	IND_NAT_RET	Indicador de Natureza da Retenção na Fonte:01 - Retenção por Órgãos, Autarquias e Fundações Federais;02 - Retenção por outras Entidades da Administração Pública Federal;03 - Retenção por Pessoas Jurídicas de Direito Privado;04 - Recolhimento por Sociedade Cooperativa;05 - Retenção por Fabricante de Máquinas e Veículos;99 - Outras Retenções	N	002*	-
    fPR_REC_RET: Integer;	           //03	PR_REC_RET	Período do Recebimento e da Retenção (MM/AAAA)	N	006*	-
    fVL_RET_APU: Currency;	         //04	VL_RET_APU	Valor Total da Retenção	N	-	02
    fVL_RET_DED: Currency;		       //05	VL_RET_DED	Valor da Retenção deduzida da Contribuição Devida	N	-	02
    fVL_RET_PER: Currency;		       //06	VL_RET_PER	Valor da Retenção utilizada mediante Pedido de Restituição.	N	-	02
    fVL_RET_DCOMP: Currency;	       //07	VL_RET_DCOMP	Valor da Retenção utilizada mediante Declaração de Compensação.	N	-	02
    fSLD_RET: Currency;		           //08	SLD_RET	Saldo de Retenção a utilizar em períodos de apuração futuros (04 - 05 - 06 - 07).	N	-	02
  public
    property IND_NAT_RET: Integer read FIND_NAT_RET write FIND_NAT_RET;
    property PR_REC_RET: Integer read FPR_REC_RET write FPR_REC_RET;
    property VL_RET_APU: Currency read FVL_RET_APU write FVL_RET_APU;
    property VL_RET_DED: Currency read FVL_RET_DED write FVL_RET_DED;
    property VL_RET_PER: Currency read FVL_RET_PER write FVL_RET_PER;
    property VL_RET_DCOMP: Currency read FVL_RET_DCOMP write FVL_RET_DCOMP;
    property SLD_RET: Currency read FSLD_RET write FSLD_RET;
  end;

  // Registro 1700 - Lista
  TRegistro1700List = class(TObjectList)
  private
    function GetItem(Index: Integer): TRegistro1700;
    procedure SetItem(Index: Integer; const Value: TRegistro1700);
  public
    function New: TRegistro1700;
    property Items[Index: Integer]: TRegistro1700 read GetItem write SetItem;
  end;

  //REGISTRO 1800: INCORPORAÇÃO IMOBILIÁRIA - RET
  TRegistro1800 = class
  private
    fINC_IMOB: string;	            //02	INC_IMOB	Empreendimento objeto de Incorporação Imobiliária, optante pelo RET.	C	090	-
    fREC_RECEB_RET: Currency;       //03	REC_RECEB_RET	Receitas recebidas pela incorporadora na venda das unidades imobiliárias que compõem a incorporação.	N	-	02
    fREC_FIN_RET: Currency;	        //04	REC_FIN_RET	Receitas Financeiras e Variações Monetárias decorrentes das vendas submetidas ao RET.	N	-	02
    fBC_RET: Currency;	            //05	BC_RET	Base de Cálculo do Recolhimento Unificado	N	-	02
    fALIQ_RET: Currency;	          //06	ALIQ_RET	Alíquota do Recolhimento Unificado.	N	006	02
    fVL_REC_UNI: Currency;	        //07	VL_REC_UNI	Valor do Recolhimento Unificado.	N	-	02
    fDT_REC_UNI: TDateTime;	        //08	DT_REC_UNI	Data do recolhimento unificado	N	008*	-
    fCOD_REC: string;	              //09	COD_REC	Código da Receita	C	004	-
  public
    property INC_IMOB: string read FINC_IMOB write FINC_IMOB;
    property REC_RECEB_RET: Currency read FREC_RECEB_RET write FREC_RECEB_RET;
    property REC_FIN_RET: Currency read FREC_FIN_RET write FREC_FIN_RET;
    property BC_RET: Currency read FBC_RET write FBC_RET;
    property ALIQ_RET: Currency read FALIQ_RET write FALIQ_RET;
    property VL_REC_UNI: Currency read FVL_REC_UNI write FVL_REC_UNI;
    property DT_REC_UNI: TDateTime read FDT_REC_UNI write FDT_REC_UNI;
    property COD_REC: string read FCOD_REC write FCOD_REC;
  end;

  // Registro 1800 - Lista
  TRegistro1800List = class(TObjectList)
  private
    function GetItem(Index: Integer): TRegistro1800;
    procedure SetItem(Index: Integer; const Value: TRegistro1800);
  public
    function New: TRegistro1800;
    property Items[Index: Integer]: TRegistro1800 read GetItem write SetItem;
  end;

  //REGISTRO 1809: PROCESSO REFERENCIADO
  TRegistro1809 = class
  private
    fNUM_PROC: string;         //02	NUM_PROC	Identificação do processo ou ato concessório	C	020	-
    fIND_PROC: Integer;        //03	IND_PROC	Indicador da origem do processo:1 - Justiça Federal;3 – Secretaria da Receita Federal do Brasil;9 – Outros.	C	001*	-
  public
    property NUM_PROC: string read FNUM_PROC write FNUM_PROC;
    property IND_PROC: Integer read FIND_PROC write FIND_PROC;
  end;

  // Registro 1809 - Lista
  TRegistro1809List = class(TObjectList)
  private
    function GetItem(Index: Integer): TRegistro1809;
    procedure SetItem(Index: Integer; const Value: TRegistro1809);
  public
    function New: TRegistro1809;
    property Items[Index: Integer]: TRegistro1809 read GetItem write SetItem;
  end;

  //REGISTRO 1990: ENCERRAMENTO DO BLOCO 1
  TRegistro1990 = class
  private
    fQTD_LIN_1: Integer;      //02	QTD_LIN_1	Quantidade total de linhas do Bloco 1	N	-	-
  public
    property QTD_LIN_1: Integer read FQTD_LIN_1 write FQTD_LIN_1;
  end;

implementation

{ TRegistroA001 }

constructor TRegistro1001.Create;
begin
  FRegistro1001 := TRegistro1001List.Create;
end;

destructor TRegistro1001.Destroy;
begin
  FRegistro1001.Free;
  inherited;
end;

end.
