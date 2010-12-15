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

unit ACBrEPCBloco_D;

interface

uses
  SysUtils, Classes, Contnrs, DateUtils;

type
  //REGISTRO D001: ABERTURA DO BLOCO D
  TRegistroD001 = class(TOpenBlocos)
  private
  public
  end;

  //REGISTRO D010: IDENTIFICAÇÃO DO ESTABELECIMENTO
  TRegistroD010 = class
  private
    fCNPJ: Integer;        //02	CNPJ	Número de inscrição do estabelecimento no CNPJ.	N	014*	-
  public
    property CNPJ: Integer read FCNPJ write FCNPJ;
  end;

  //REGISTRO D100: AQUISIÇÃO DE SERVIÇOS DE TRANSPORTE - NOTA FISCAL DE SERVIÇO DE TRANSPORTE (CÓDIGO 07) E CONHECIMENTOS DE TRANSPORTE RODOVIÁRIO DE CARGAS (CÓDIGO 08), CONHECIMENTO DE TRANSPORTE DE CARGAS AVULSO (CÓDIGO 8B), AQUAVIÁRIO DE CARGAS (CÓDIGO 09), AÉREO (CÓDIGO 10), FERROVIÁRIO DE CARGAS (CÓDIGO 11), MULTIMODAL DE CARGAS (CÓDIGO 26), NOTA FISCAL DE TRANSPORTE FERROVIÁRIO DE CARGA (CÓDIGO 27) E CONHECIMENTO DE TRANSPORTE ELETRÔNICO – CT-e (CÓDIGO 57)
  TRegistroD100 = class
  private
    fIND_OPER: string;	         //02	IND_OPER	Indicador do tipo de operação:0- Aquisição;	C	001*	-
    fIND_EMIT: string;	         //03	IND_EMIT	Indicador do emitente do documento fiscal:0- Emissão Própria;1- Emissão por Terceiros	C	001*	-
    fCOD_PART: string;	         //04	COD_PART	Código do participante (campo 02 do Registro 0150).	C	060	-
    fCOD_MOD: string;	           //05	COD_MOD	Código do modelo do documento fiscal, conforme a Tabela 4.1.1 	C	002*	-
    fCOD_SIT: Integer;	         //06	COD_SIT	Código da situação do documento fiscal, conforme a Tabela 4.1.2	N	002*	-
    fSER: string;	               //07	SER	Série do documento fiscal	C	004	-
    fSUB: string;	               //08	SUB	Subsérie do documento fiscal	C	003	-
    fNUM_DOC: Integer;	         //09	NUM_DOC	Número do documento fiscal	N	009	-
    fCHV_CTE: Integer;	         //10	CHV_CTE	Chave do Conhecimento de Transporte Eletrônico	N	044*	-
    fDT_DOC: TDateTime;	         //11	DT_DOC	Data de referência/emissão dos documentos fiscais	N	008*	-
    fDT_A_P: TDateTime;	         //12	DT_A_P	Data da aquisição ou da prestação do serviço	N	008*	-
    fTP_CT_e: Integer;	         //13	TP_CT-e	Tipo de Conhecimento de Transporte Eletrônico conforme definido no Manual de Integração do CT-e	N	001*	-
    fCHV_CTE_REF: Integer;	     //14	CHV_CTE_REF	Chave do CT-e de referência cujos valores foram complementados (opção “1” do campo anterior) ou cujo débito foi anulado (opção “2” do campo anterior). 	N	044*	-
    fVL_DOC: Currency;	         //15	VL_DOC	Valor total do documento fiscal	N	-	02
    fVL_DESC: Currency;	         //16	VL_DESC	Valor total do desconto	N	-	02
    fIND_FRT: Integer;	         //17	IND_FRT	Indicador do tipo do frete:0- Por conta de terceiros;1- Por conta do emitente;2- Por conta do destinatário;9- Sem cobrança de frete.	C	001*	-
    fVL_SERV: Currency;	         //18	VL_SERV	Valor total da prestação de serviço	N	-	02
    fVL_BC_ICMS: Currency;	     //19	VL_BC_ICMS	Valor da base de cálculo do ICMS	N	-	02
    fVL_ICMS: Currency;	         //20	VL_ICMS	Valor do ICMS	N	-	02
    fVL_NT: Currency;	           //21	VL_NT	Valor não-tributado do ICMS	N	-	02
    fCOD_INF: string;	           //22	COD_INF	Código da informação complementar do documento fiscal (campo 02 do Registro 0450)	C	006	-
    fCOD_CTA: string;	           //23	COD_CTA	Código da conta analítica contábil debitada/creditada	C	060	-
  public
    property IND_OPER: string read FIND_OPER write FIND_OPER;
    property IND_EMIT: string read FIND_EMIT write FIND_EMIT;
    property COD_PART: string read FCOD_PART write FCOD_PART;
    property COD_MOD: string read FCOD_MOD write FCOD_MOD;
    property COD_SIT: Integer read FCOD_SIT write FCOD_SIT;
    property SER: string read FSER write FSER;
    property SUB: string read FSUB write FSUB;
    property NUM_DOC: Integer read FNUM_DOC write FNUM_DOC;
    property CHV_CTE: Integer read FCHV_CTE write FCHV_CTE;
    property DT_DOC: TDateTime read FDT_DOC write FDT_DOC;
    property DT_A_P: TDateTime read FDT_A_P write FDT_A_P;
    property TP_CT_e: Integer read FTP_CT_e write FTP_CT_e;
    property CHV_CTE_REF: Integer read FCHV_CTE_REF write FCHV_CTE_REF;
    property VL_DOC: Currency read FVL_DOC write FVL_DOC;
    property VL_DESC: Currency read FVL_DESC write FVL_DESC;
    property IND_FRT: Integer read FIND_FRT write FIND_FRT;
    property VL_SERV: Currency read FVL_SERV write FVL_SERV;
    property VL_BC_ICMS: Currency read FVL_BC_ICMS write FVL_BC_ICMS;
    property VL_ICMS: Currency read FVL_ICMS write FVL_ICMS;
    property VL_NT: Currency read FVL_NT write FVL_NT;
    property COD_INF: string read FCOD_INF write FCOD_INF;
    property COD_CTA: string read FCOD_CTA write FCOD_CTA;
  end;

  //REGISTRO D101: COMPLEMENTO DO DOCUMENTO DE TRANSPORTE (Códigos 07, 08, 8B, 09, 10, 11, 26, 27 e 57) – PIS/PASEP
  TRegistroD101 = class
  private
    fIND_NAT_FRT: Integer;	        //02	IND_NAT_FRT	Indicador da Natureza do Frete Contratado, referente a:0 – Operações de vendas, com ônus suportado pelo estabelecimento vendedor;1 – Operações de vendas, com ônus suportado pelo adquirente;2 – Operações de compras (bens para revenda, matérias-prima e outros produtos, geradores de crédito);3 – Operações de compras (bens para revenda, matérias-prima e outros produtos, não geradores de crédito);4 – Transferência de produtos acabados entre estabelecimentos da pessoa jurídica;5 – Transferência de produtos em elaboração entre estabelecimentos da pessoa jurídica;9 – Outras.	C	001*	-
    fVL_ITEM: Currency;	            //03	VL_ITEM	Valor total dos itens	N	-	02
    fCST_PIS: Integer;	            //04	CST_PIS	Código da Situação Tributária referente ao PIS/PASEP	N	002*	-
    fNAT_BC_CRED: string;	          //05	NAT_BC_CRED	Código da Base de Cálculo do Crédito, conforme a Tabela indicada no item 4.3.7.	C	002*	-
    fVL_BC_PIS: Currency;	          //06	VL_BC_PIS	Valor da base de cálculo do PIS/PASEP	N	 -	02
    fALIQ_PIS: Currency;	          //07	ALIQ_PIS	Alíquota do PIS/PASEP (em percentual)	N	008	04
    fVL_PIS: Currency;	            //08	VL_PIS	Valor do PIS/PASEP	N	-	02
    fCOD_CTA: string;	              //09	COD_CTA	Código da conta analítica contábil debitada/creditada	C	060	-
  public
    property IND_NAT_FRT: Integer read FIND_NAT_FRT write FIND_NAT_FRT;
    property VL_ITEM: Currency read FVL_ITEM write FVL_ITEM;
    property CST_PIS: Integer read FCST_PIS write FCST_PIS;
    property NAT_BC_CRED: string read FNAT_BC_CRED write FNAT_BC_CRED;
    property VL_BC_PIS: Currency read FVL_BC_PIS write FVL_BC_PIS;
    property ALIQ_PIS: Currency read FALIQ_PIS write FALIQ_PIS;
    property VL_PIS: Currency read FVL_PIS write FVL_PIS;
    property COD_CTA: string read FCOD_CTA write FCOD_CTA;
  end;

  //REGISTRO D105: COMPLEMENTO DO DOCUMENTO DE TRANSPORTE (Códigos 07, 08, 8B, 09, 10, 11, 26, 27 e 57) – COFINS
  TRegistroD105 = class
  private
    fIND_NAT_FRT: Integer;	          //02	IND_NAT_FRT	Indicador da Natureza do Frete Contratado, referente a:0 – Operações de vendas, com ônus suportado pelo estabelecimento vendedor;1 – Operações de vendas, com ônus suportado pelo adquirente;2 – Operações de compras (bens para revenda, matérias-prima e outros produtos, geradores de crédito);3 – Operações de compras (bens para revenda, matérias-prima e outros produtos, não geradores de crédito);4 – Transferência de produtos acabados entre estabelecimentos da pessoa jurídica;5 – Transferência de produtos em elaboração entre estabelecimentos da pessoa jurídica;9 – Outras.	C	001*	-
    fVL_ITEM: Currency;	              //03	VL_ITEM	Valor total dos itens	N	-	02
    fCST_COFINS: Integer;	            //04	CST_COFINS	Código da Situação Tributária referente a COFINS	N	002*	-
    fNAT_BC_CRED: string;	            //05	NAT_BC_CRED	Código da base de Cálculo do Crédito, conforme a Tabela indicada no item 4.3.7 	C	002*	-
    fVL_BC_COFINS: Currency;          //06	VL_BC_COFINS	Valor da base de cálculo da COFINS	N	 -	02
    fALIQ_COFINS: Currency;	          //07	ALIQ_COFINS	Alíquota da COFINS (em percentual)	N	008	04
    fVL_COFINS: Currency;	            //08	VL_COFINS	Valor da COFINS	N	-	02
    fCOD_CTA: string;	                //09	COD_CTA	Código da conta analítica contábil debitada/creditada	C	060	-
  public
    property IND_NAT_FRT: Integer read FIND_NAT_FRT write FIND_NAT_FRT;
    property VL_ITEM: Currency read FVL_ITEM write FVL_ITEM;
    property CST_COFINS: Integer read FCST_COFINS write FCST_COFINS;
    property NAT_BC_CRED: string read FNAT_BC_CRED write FNAT_BC_CRED;
    property VL_BC_COFINS: Currency read FVL_BC_COFINS write FVL_BC_COFINS;
    property ALIQ_COFINS: Currency read FALIQ_COFINS write FALIQ_COFINS;
    property VL_COFINS: Currency read FVL_COFINS write FVL_COFINS;
    property COD_CTA: string read FCOD_CTA write FCOD_CTA;
  end;

  //REGISTRO D111: PROCESSO REFERENCIADO
  TRegistroD111 = class
  private
    fNUM_PROC: string;        //02	NUM_PROC	Identificação do processo ou ato concessório	C	020	-
    fIND_PROC: Integer;       //03	IND_PROC	Indicador da origem do processo:1 - Justiça Federal;3 – Secretaria da Receita Federal do Brasil;9 – Outros.	C	001*	-
  public
    property NUM_PROC: string read FNUM_PROC write FNUM_PROC;
    property IND_PROC: Integer read FIND_PROC write FIND_PROC;
  end;

  //REGISTRO D200: RESUMO DA ESCRITURAÇÃO DIÁRIA – PRESTAÇÃO DE SERVIÇOS DE TRANSPORTE - NOTA FISCAL DE SERVIÇO DE TRANSPORTE (CÓDIGO 07) E CONHECIMENTOS DE TRANSPORTE RODOVIÁRIO DE CARGAS (CÓDIGO 08), CONHECIMENTO DE TRANSPORTE DE CARGAS AVULSO (CÓDIGO 8B), AQUAVIÁRIO DE CARGAS (CÓDIGO 09), AÉREO (CÓDIGO 10), FERROVIÁRIO DE CARGAS (CÓDIGO 11), MULTIMODAL DE CARGAS (CÓDIGO 26), NOTA FISCAL DE TRANSPORTE FERROVIÁRIO DE CARGA (CÓDIGO 27) E CONHECIMENTO DE TRANSPORTE ELETRÔNICO – CT-e (CÓDIGO 57)
  TRegistroD200 = class
  private
    fCOD_MOD: string;	           //02	COD_MOD	Código do modelo do documento fiscal, conforme a Tabela 4.1.1 	C	002*	-
    fCOD_SIT: Integer;	         //03	COD_SIT	Código da situação do documento fiscal, conforme a Tabela 4.1.2	N	002*	-
    fSER: string;	               //04	SER	Série do documento fiscal	C	004	-
    fSUB: string;	               //05	SUB	Subsérie do documento fiscal	C	003	-
    fNUM_DOC_INI: Integer;       //06	NUM_DOC_INI	Número do documento fiscal inicial emitido no período (mesmo modelo, série e subsérie).	N	009	-
    fNUM_DOC_FIN: Integer;       //07	NUM_DOC_FIN	Número do documento fiscal final emitido no período (mesmo modelo, série e subsérie).	N	009	-
    fCFOP: Integer;	             //08	CFOP	Código Fiscal de Operação e Prestação conforme tabela indicada no item 4.2.2	N	004*	-
    fDT_REF: TDateTime;	         //09	DT_REF	Data do dia de referência do resumo diário	N	008*	-
    fVL_DOC: Currency;	         //10	VL_DOC	Valor total dos documentos fiscais	N	-	02
    fVL_DESC: Currency;	         //11	VL_DESC	Valor total dos descontos	N	-	02
  public
    property COD_MOD: string read FCOD_MOD write FCOD_MOD;
    property COD_SIT: Integer read FCOD_SIT write FCOD_SIT;
    property SER: string read FSER write FSER;
    property SUB: string read FSUB write FSUB;
    property NUM_DOC_INI: Integer read FNUM_DOC_INI write FNUM_DOC_INI;
    property NUM_DOC_FIN: Integer read FNUM_DOC_FIN write FNUM_DOC_FIN;
    property CFOP: Integer read FCFOP write FCFOP;
    property DT_REF: TDateTime read FDT_REF write FDT_REF;
    property VL_DOC: Currency read FVL_DOC write FVL_DOC;
    property VL_DESC: Currency read FVL_DESC write FVL_DESC;
  end;

  //REGISTRO D201: TOTALIZAÇÃO DO RESUMO DIÁRIO – PIS/PASEP
  TRegistroD201 = class
  private
    fCST_PIS: Integer;	             //02	CST_PIS	Código da Situação Tributária referente ao PIS/PASEP	N	002*	-
    fVL_ITEM: Currency;	             //03	VL_ITEM	Valor total dos itens	N	-	02
    fVL_BC_PIS: Currency;            //04	VL_BC_PIS	Valor da base de cálculo do PIS/PASEP	N	-	02
    fALIQ_PIS: Currency;             //05	ALIQ_PIS	Alíquota do PIS/PASEP (em percentual)	N	008	04
    fVL_PIS: Currency;	             //06	VL_PIS	Valor do PIS/PASEP	N	-	02
    fCOD_CTA: string;	               //07	COD_CTA	Código da conta analítica contábil debitada/creditada	C	060	-
  public
    property CST_PIS: Integer read FCST_PIS write FCST_PIS;
    property VL_ITEM: Currency  read FVL_ITEM write FVL_ITEM;
    property VL_BC_PIS: Currency  read FVL_BC_PIS write FVL_BC_PIS;
    property ALIQ_PIS: Currency  read FALIQ_PIS write FALIQ_PIS;
    property VL_PIS: Currency  read FVL_PIS write FVL_PIS;
    property COD_CTA: string  read FCOD_CTA write FCOD_CTA;
  end;

  //REGISTRO D205: TOTALIZAÇÃO DO RESUMO DIÁRIO – COFINS
  TRegistroD205 = class
  private
    fCST_COFINS: string;	             //02	CST_COFINS	Código da Situação Tributária referente a COFINS.	N	002*	-
    fVL_ITEM: Currency;	               //03	VL_ITEM	Valor total dos itens	N	-	02
    fVL_BC_COFINS: Currency;           //04	VL_BC_COFINS	Valor da base de cálculo da COFINS	N	-	02
    fALIQ_COFINS: Currency;	           //05	ALIQ_COFINS	Alíquota da COFINS (em percentual)	N	008	04
    fVL_COFINS: Currency;	             //06	VL_COFINS	Valor da COFINS	N	-	02
    fCOD_CTA: string;	                 //07	COD_CTA	Código da conta analítica contábil debitada/creditada	C	060	-
  public
    property CST_COFINS: string read FCST_COFINS write FCST_COFINS;
    property VL_ITEM: Currency read FVL_ITEM write FVL_ITEM;
    property VL_BC_COFINS: Currency read FVL_BC_COFINS write FVL_BC_COFINS;
    property ALIQ_COFINS: Currency read FALIQ_COFINS write FALIQ_COFINS;
    property VL_COFINS: Currency read FVL_COFINS write FVL_COFINS;
    property COD_CTA: string read FCOD_CTA write FCOD_CTA;
  end;

  //REGISTRO D209: PROCESSO REFERENCIADO
  TRegistroD209 = class
  private
    fNUM_PROC: string;            //02	NUM_PROC	Identificação do processo ou ato concessório	C	020	-
    fIND_PROC: Integer;           //03	IND_PROC	Indicador da origem do processo:1 - Justiça Federal;3 – Secretaria da Receita Federal do Brasil;9 – Outros.	C	001*	-
  public
    property NUM_PROC: string read FNUM_PROC write FNUM_PROC;
    property IND_PROC: Integer read FIND_PROC write FIND_PROC;
  end;

  //REGISTRO D300: RESUMO DA ESCRITURAÇÃO DIÁRIA - BILHETES CONSOLIDADOS DE PASSAGEM RODOVIÁRIO (CÓDIGO 13), DE PASSAGEM AQUAVIÁRIO (CÓDIGO 14), DE PASSAGEM E NOTA DE BAGAGEM (CÓDIGO 15) E DE PASSAGEM FERROVIÁRIO (CÓDIGO 16)
  TRegistroD300 = class
  private
    fCOD_MOD: string;	            //02	COD_MOD	Código do modelo do documento fiscal, conforme a Tabela 4.1.1.	C	002*	-
    fSER: string;	                //03	SER	Série do documento fiscal	C	004	-
    fSUB: Integer;	              //04	SUB	Subsérie do documento fiscal	N	003	-
    fNUM_DOC_INI: Integer;	      //05	NUM_DOC_INI	Número do primeiro documento fiscal emitido no período (mesmo modelo, série e subsérie)	N	006	-
    fNUM_DOC_FIN: Integer;	      //06	NUM_DOC_FIN	Número do último documento fiscal emitido no período (mesmo modelo, série e subsérie)	N	006	-
    fCFOP: Integer;	              //07	CFOP	Código Fiscal de Operação e Prestação conforme tabela indicada no item 4.2.2	N	004*	-
    fDT_REF: TDateTime;	          //08	DT_REF	Data do dia de referência do resumo diário	N	008*	-
    fVL_DOC: Currency;	          //09	VL_DOC	Valor total dos documentos fiscais emitidos	N	-	02
    fVL_DESC: Currency;	          //10	VL_DESC	Valor total dos descontos	N	-	02
    fCST_PIS: Integer;	          //11	CST_PIS	Código da Situação Tributária referente ao PIS/PASEP	N	002*	-
    fVL_BC_PIS: Currency;	        //12	VL_BC_PIS	Valor da base de cálculo do PIS/PASEP	N	-	02
    fALIQ_PIS: Currency;	        //13	ALIQ_PIS	Alíquota do PIS/PASEP (em percentual)	N	008	04
    fVL_PIS: Currency;	          //14	VL_PIS	Valor do PIS/PASEP	N	-	02
    fCST_COFINS: Integer;	        //15	CST_COFINS	Código da Situação Tributária referente a COFINS	N	002*	-
    fVL_BC_COFINS: Currency;      //16	VL_BC_COFINS	Valor da base de cálculo da COFINS	N	-	02
    fALIQ_COFINS: Currency;	      //17	ALIQ_COFINS	Alíquota da COFINS (em percentual)	N	008	04
    fVL_COFINS: Currency;	        //18	VL_COFINS	Valor da COFINS	N	-	02
    fCOD_CTA: string;	            //19	COD_CTA	Código da conta analítica contábil debitada/creditada	C	060	-
  public
    property COD_MOD: string read FCOD_MOD write FCOD_MOD;
    property SER: string read FSER write FSER;
    property SUB: Integer read FSUB write FSUB;
    property NUM_DOC_INI: Integer read FNUM_DOC_INI write FNUM_DOC_INI;
    property NUM_DOC_FIN: Integer read FNUM_DOC_FIN write FNUM_DOC_FIN;
    property CFOP: Integer read FCFOP write FCFOP;
    property DT_REF: TDateTime read FDT_REF write FDT_REF;
    property VL_DOC: Currency read FVL_DOC write FVL_DOC;
    property VL_DESC: Currency read FVL_DESC write FVL_DESC;
    property CST_PIS: Integer read FCST_PIS write FCST_PIS;
    property VL_BC_PIS: Currency read FVL_BC_PIS write FVL_BC_PIS;
    property ALIQ_PIS: Currency read FALIQ_PIS write FALIQ_PIS;
    property VL_PIS: Currency read FVL_PIS write FVL_PIS;
    property CST_COFINS: Integer read FCST_COFINS write FCST_COFINS;
    property VL_BC_COFINS: Currency read FVL_BC_COFINS write FVL_BC_COFINS;
    property ALIQ_COFINS: Currency read FALIQ_COFINS write FALIQ_COFINS;
    property VL_COFINS: Currency read FVL_COFINS write FVL_COFINS;
    property COD_CTA: string read FCOD_CTA write FCOD_CTA;
  end;

  //REGISTRO D309: PROCESSO REFERENCIADO
  TRegistroD309 = class
  private
    fNUM_PROC: string;            //02	NUM_PROC	Identificação do processo ou ato concessório	C	020	-
    fIND_PROC: Integer;           //03	IND_PROC	Indicador da origem do processo:1 - Justiça Federal;3 – Secretaria da Receita Federal do Brasil ;9 – Outros.	C	001*	-
  public
    property NUM_PROC: string read FNUM_PROC write FNUM_PROC;
    property IND_PROC: Integer read FIND_PROC write FIND_PROC;
  end;

  //REGISTRO D350: RESUMO DIÁRIO DE CUPOM FISCAL EMITIDO POR ECF - (CÓDIGOS 2E, 13, 14, 15 e 16)
  TRegistroD350 = class
  private
    fCOD_MOD: string;	             //02	COD_MOD	Código do modelo do documento fiscal, conforme a Tabela 4.1.1	C	002*	-
    fECF_MOD: string;	             //03	ECF_MOD	Modelo do equipamento	C	020	-
    fECF_FAB: string;	             //04	ECF_FAB	Número de série de fabricação do ECF	C	020	-
    fDT_DOC: TDateTime;	           //05	DT_DOC	Data do movimento a que se refere a Redução Z	N	008*	-
    fCRO: Integer;	               //06	CRO	Posição do Contador de Reinício de Operação	N	003	-
    fCRZ: Integer;	               //07	CRZ	Posição do Contador de Redução Z	N	006	-
    fNUM_COO_FIN: Integer;	       //08	NUM_COO_FIN	Número do Contador de Ordem de Operação do último documento emitido no dia. (Número do COO na Redução Z)	N	006	-
    fGT_FIN: Currency;	           //09	GT_FIN	Valor do Grande Total final	N	-	02
    fVL_BRT: Currency;	           //10	VL_BRT	Valor da venda bruta	N	-	02
    fCST_PIS: Integer;	           //11	CST_PIS	Código da Situação Tributária referente ao PIS/PASEP	N	002*	-
    fVL_BC_PIS: Currency;	         //12	VL_BC_PIS	Valor da base de cálculo do PIS/PASEP	N	- 	02
    fALIQ_PIS: Currency;	         //13	ALIQ_PIS	Alíquota do PIS/PASEP (em percentual)	N	008	04
    fQUANT_BC_PIS: Currency;	     //14	QUANT_BC_PIS	Quantidade – Base de cálculo PIS/PASEP	N	- 	03
    fALIQ_PIS_QUANT: Currency;	   //15	ALIQ_PIS_QUANT	Alíquota do PIS/PASEP (em reais)	N	 -	04
    fVL_PIS: Currency;	           //16	VL_PIS	Valor do PIS/PASEP	N	-	02
    fCST_COFINS: Integer;	         //17	CST_COFINS	Código da Situação Tributária referente a COFINS	N	002*	-
    fVL_BC_COFINS: Currency;	     //18	VL_BC_COFINS	Valor da base de cálculo da COFINS	N	 -	02
    fALIQ_COFINS: Currency;	       //19	ALIQ_COFINS	Alíquota da COFINS (em percentual)	N	008	04
    fQUANT_BC_COFINS: Currency;	   //20	QUANT_BC_COFINS	Quantidade – Base de cálculo da COFINS	N	- 	03
    fALIQ_COFINS_QUANT: Currency;  //21	ALIQ_COFINS_QUANT	Alíquota da COFINS (em reais)	N	- 	04
    fVL_COFINS: Currency;	         //22	VL_COFINS	Valor da COFINS	N	-	02
    fCOD_CTA: string;	             //23	COD_CTA	Código da conta analítica contábil debitada/creditada	C	060	-
  public
    property COD_MOD: string read FCOD_MOD write FCOD_MOD;
    property ECF_MOD: string read FECF_MOD write FECF_MOD;
    property ECF_FAB: string read FECF_FAB write FECF_FAB;
    property DT_DOC: TDateTime read FDT_DOC write FDT_DOC;
    property CRO: Integer read FCRO write FCRO;
    property CRZ: Integer read FCRZ write FCRZ;
    property NUM_COO_FIN: Integer read FNUM_COO_FIN write FNUM_COO_FIN;
    property GT_FIN: Currency read FGT_FIN write FGT_FIN;
    property VL_BRT: Currency read FVL_BRT write FVL_BRT;
    property CST_PIS: Integer read FCST_PIS write FCST_PIS;
    property VL_BC_PIS: Currency read FVL_BC_PIS write FVL_BC_PIS;
    property ALIQ_PIS: Currency read FALIQ_PIS write FALIQ_PIS;
    property QUANT_BC_PIS: Currency read FQUANT_BC_PIS write FQUANT_BC_PIS;
    property ALIQ_PIS_QUANT: Currency read FALIQ_PIS_QUANT write FALIQ_PIS_QUANT;
    property VL_PIS: Currency read FVL_PIS write FVL_PIS;
    property CST_COFINS: Integer read FCST_COFINS write FCST_COFINS;
    property VL_BC_COFINS: Currency read FVL_BC_COFINS write FVL_BC_COFINS;
    property ALIQ_COFINS: Currency read FALIQ_COFINS write FALIQ_COFINS;
    property QUANT_BC_COFINS: Currency read FQUANT_BC_COFINS write FQUANT_BC_COFINS;
    property ALIQ_COFINS_QUANT: Currency read FALIQ_COFINS_QUANT write FALIQ_COFINS_QUANT;
    property VL_COFINS: Currency read FVL_COFINS write FVL_COFINS;
    property COD_CTA: string read FCOD_CTA write FCOD_CTA;
  end;

  //REGISTRO D359: PROCESSO REFERENCIADO
  TRegistroD359 = class
  private
    fNUM_PROC: string;        //02	NUM_PROC	Identificação do processo ou ato concessório	C	020	-
    fIND_PROC: Integer;       //03	IND_PROC	Indicador da origem do processo:1 - Justiça Federal;3 – Secretaria da Receita Federal do Brasil;9 – Outros.	C	001*	-
  public
    property NUM_PROC: string read FNUM_PROC write FNUM_PROC;
    property IND_PROC: Integer read FIND_PROC write FIND_PROC;
  end;

  //REGISTRO D500: NOTA FISCAL DE SERVIÇO DE COMUNICAÇÃO (CÓDIGO 21) E NOTA FISCAL DE SERVIÇO DE TELECOMUNICAÇÃO (CÓDIGO 22) – DOCUMENTOS DE AQUISIÇÃO COM DIREITO A CRÉDITO
  TRegistroD500 = class
  private
    fIND_OPER: string;	              //02	IND_OPER	Indicador do tipo de operação:0- Aquisição	C	001*	-
    fIND_EMIT: string;	              //03	IND_EMIT	Indicador do emitente do documento fiscal:0- Emissão própria;1- Terceiros	C	001*	-
    fCOD_PART: string;	              //04	COD_PART	Código do participante prestador do serviço (campo 02 do Registro 0150).	C	060	-
    fCOD_MOD: string;	                //05	COD_MOD	Código do modelo do documento fiscal, conforme a Tabela 4.1.1.	C	002*	-
    fCOD_SIT: Integer;	              //06	COD_SIT	Çódigo da situação do documento fiscal, conforme a Tabela 4.1.2.	N	002*	-
    fSER: string;	                    //07	SER	Série do documento fiscal	C	004	-
    fSUB: Integer;	                  //08	SUB	Subsérie do documento fiscal	N	003	-
    fNUM_DOC: Integer;	              //09	NUM_DOC	Número do documento fiscal	N	009	-
    fDT_DOC: TDateTime;	              //10	DT_DOC	Data da emissão do documento fiscal	N	008*	-
    fDT_A_P: TDateTime;	              //11	DT_A_P	Data da entrada (aquisição)	N	008*	-
    fVL_DOC: Currency;	              //12	VL_DOC	Valor total do documento fiscal	N	-	02
    fVL_DESC: Currency;	              //13	VL_DESC	Valor total do desconto	N	-	02
    fVL_SERV: Currency;	              //14	VL_SERV	Valor da prestação de serviços	N	-	02
    fVL_SERV_NT: Currency;            //15	VL_SERV_NT	Valor total dos serviços não-tributados pelo ICMS	N	-	02
    fVL_TERC: Currency;	              //16	VL_TERC	Valores cobrados em nome de terceiros	N	-	02
    fVL_DA: Currency;	                //17	VL_DA	Valor de outras despesas indicadas no documento fiscal	N	-	02
    fVL_BC_ICMS: Currency;            //18	VL_BC_ICMS	Valor da base de cálculo do ICMS	N	-	02
    fVL_ICMS: Currency;	              //19	VL_ICMS	Valor do ICMS	N	-	02
    fCOD_INF: string;	                //20	COD_INF	Código da informação complementar (campo 02 do Registro 0450)	C	006	-
    fVL_PIS: Currency;                //21	VL_PIS	Valor do PIS/PASEP	N	-	02
    fVL_COFINS: Currency;             //22	VL_COFINS	Valor da COFINS	N	-	02
  public
    property IND_OPER: string read FIND_OPER write FIND_OPER;
    property IND_EMIT: string read FIND_EMIT write FIND_EMIT;
    property COD_PART: string read FCOD_PART write FCOD_PART;
    property COD_MOD: string read FCOD_MOD write FCOD_MOD;
    property COD_SIT: Integer read FCOD_SIT write FCOD_SIT;
    property SER: string read FSER write FSER;
    property SUB: Integer read FSUB write FSUB;
    property NUM_DOC: Integer read FNUM_DOC write FNUM_DOC;
    property DT_DOC: TDateTime read FDT_DOC write FDT_DOC;
    property DT_A_P: TDateTime read FDT_A_P write FDT_A_P;
    property VL_DOC: Currency read FVL_DOC write FVL_DOC;
    property VL_DESC: Currency read FVL_DESC write FVL_DESC;
    property VL_SERV: Currency read FVL_SERV write FVL_SERV;
    property VL_SERV_NT: Currency read FVL_SERV_NT write FVL_SERV_NT;
    property VL_TERC: Currency read FVL_TERC write FVL_TERC;
    property VL_DA: Currency read FVL_DA write FVL_DA;
    property VL_BC_ICMS: Currency read FVL_BC_ICMS write FVL_BC_ICMS;
    property VL_ICMS: Currency read FVL_ICMS write FVL_ICMS;
    property COD_INF: string read FCOD_INF write FCOD_INF;
    property VL_PIS: Currency read FVL_PIS write FVL_PIS;
    property VL_COFINS: Currency read FVL_COFINS write FVL_COFINS;
  end;

  //REGISTRO D501: COMPLEMENTO DA OPERAÇÃO (CÓDIGOS 21 e 22) – PIS/PASEP
  TRegistroD501 = class
  private
    fCST_PIS: Integer;	         //02	CST_PIS	Código da Situação Tributária referente ao PIS/PASEP	N	002*	-
    fVL_ITEM: Currency;	         //03	VL_ITEM	Valor Total dos Itens (Serviços)	N	-	02
    fNAT_BC_CRED: string;	       //04	NAT_BC_CRED	Código da Base de Cálculo do Crédito, conforme a Tabela indicada no item 4.3.7.	C	002*	-
    fVL_BC_PIS: Currency;	       //05	VL_BC_PIS	Valor da base de cálculo do PIS/PASEP	N	 -	02
    fALIQ_PIS: Currency;	       //06	ALIQ_PIS	Alíquota do PIS/PASEP (em percentual)	N	008	04
    fVL_PIS: Currency;	         //07	VL_PIS	Valor do PIS/PASEP	N	-	02
    fCOD_CTA: string;	           //08	COD_CTA	Código da conta analítica contábil debitada/creditada	C	060	-
  public
    property CST_PIS: Integer read FCST_PIS write FCST_PIS;
    property VL_ITEM: Currency read FVL_ITEM write FVL_ITEM;
    property NAT_BC_CRED: string read FNAT_BC_CRED write FNAT_BC_CRED;
    property VL_BC_PIS: Currency read FVL_BC_PIS write FVL_BC_PIS;
    property ALIQ_PIS: Currency read FALIQ_PIS write FALIQ_PIS;
    property VL_PIS: Currency read FVL_PIS write FVL_PIS;
    property COD_CTA: string read FCOD_CTA write FCOD_CTA;
  end;

  //REGISTRO D505: COMPLEMENTO DA OPERAÇÃO (CÓDIGOS 21 e 22) – COFINS
  TRegistroD505 = class
  private
    fCST_COFINS: Integer;	          //02	CST_COFINS	Código da Situação Tributária referente a COFINS	N	002*	-
    fVL_ITEM: Currency;	            //03	VL_ITEM	Valor Total dos Itens	N	-	02
    fNAT_BC_CRED: string;	          //04	NAT_BC_CRED	Código da Base de Cálculo do Crédito, conforme a Tabela indicada no item 4.3.7.	C	002*	-
    fVL_BC_COFINS: Currency;        //05	VL_BC_COFINS	Valor da base de cálculo da COFINS	N	 -	02
    fALIQ_COFINS: Currency;	        //06	ALIQ_COFINS	Alíquota da COFINS (em percentual)	N	008	04
    fVL_COFINS: Currency;	          //07	VL_COFINS	Valor da COFINS	N	-	02
    fCOD_CTA: string;	              //08	COD_CTA	Código da conta analítica contábil debitada/creditada	C	060	-
  public
    property CST_COFINS: Integer read FCST_COFINS write FCST_COFINS;
    property VL_ITEM: Currency read FVL_ITEM write FVL_ITEM;
    property NAT_BC_CRED: string read FNAT_BC_CRED write FNAT_BC_CRED;
    property VL_BC_COFINS: Currency read FVL_BC_COFINS write FVL_BC_COFINS;
    property ALIQ_COFINS: Currency read FALIQ_COFINS write FALIQ_COFINS;
    property VL_COFINS: Currency read FVL_COFINS write FVL_COFINS;
    property COD_CTA: string read FCOD_CTA write FCOD_CTA;
  end;

  //REGISTRO D509: PROCESSO REFERENCIADO
  TRegistroD509 = class
  private
    fNUM_PROC: string;         //02	NUM_PROC	Identificação do processo ou ato concessório	C	020	-
    fIND_PROC: Integer;        //03	IND_PROC	Indicador da origem do processo:1 - Justiça Federal;3 – Secretaria da Receita Federal do Brasil;9 – Outros.	C	001*	-
  public
    property NUM_PROC: string read FNUM_PROC write FNUM_PROC;
    property IND_PROC: Integer read FIND_PROC write FIND_PROC;
  end;

  //REGISTRO D600: CONSOLIDAÇÃO DA PRESTAÇÃO DE SERVIÇOS - NOTAS DE SERVIÇO DE COMUNICAÇÃO (CÓDIGO 21) E DE SERVIÇO DE TELECOMUNICAÇÃO (CÓDIGO 22)
  TRegistroD600 = class
  private
    fCOD_MOD: string;	            //02	COD_MOD	Código do modelo do documento fiscal, conforme a Tabela 4.1.1.	C	002*	-
    fCOD_MUN: Integer;	          //03	COD_MUN	Código do município dos terminais faturados, conforme a tabela IBGE	N	007*	-
    fSER: string;	                //04	SER	Série do documento fiscal	C	004	-
    fSUB: Integer;	              //05	SUB	Subsérie do documento fiscal	N	003	-
    fIND_REC: Integer;	          //06	IND_REC	Indicador do tipo de receita:0- Receita própria - serviços prestados;1- Receita própria - cobrança de débitos;2- Receita própria - venda de serviço pré-pago – faturamento de períodos anteriores;3- Receita própria - venda de serviço pré-pago – faturamento no período;4- Outras receitas próprias de serviços de comunicação e telecomunicação;5- Receita própria - co-faturamento;6- Receita própria – serviços a faturar em período futuro;7– Outras receitas próprias de natureza não-cumulativa;8 - Outras receitas de terceiros;9 – Outras receitas	N	001*	-
    fQTD_CONS: Integer;	          //07	QTD_CONS	Quantidade de documentos consolidados neste registro	N	-	-
    fDT_DOC_INI: TDateTime;       //08	DT_DOC_INI	Data Inicial dos documentos consolidados no período	N	008*	-
    fDT_DOC_FIN: TDateTime;       //09	DT_DOC_FIN	Data Final dos documentos consolidados no período	N	008*	-
    fVL_DOC: Currency;	          //10	VL_DOC	Valor total acumulado dos documentos fiscais	N	-	02
    fVL_DESC: Currency;	          //11	VL_DESC	Valor acumulado dos descontos	N	-	02
    fVL_SERV: Currency;	          //12	VL_SERV	Valor acumulado das prestações de serviços tributados pelo ICMS	N	-	02
    fVL_SERV_NT: Currency;        //13	VL_SERV_NT	Valor acumulado dos serviços não-tributados pelo ICMS	N	-	02
    fVL_TERC: Currency;	          //14	VL_TERC	Valores cobrados em nome de terceiros	N	-	02
    fVL_DA: Currency;	            //15	VL_DA	Valor acumulado das despesas acessórias	N	-	02
    fVL_BC_ICMS: Currency;        //16	VL_BC_ICMS	Valor acumulado da base de cálculo do ICMS	N	-	02
    fVL_ICMS: Currency;	          //17	VL_ICMS	Valor acumulado do ICMS	N	-	02
    fVL_PIS: Currency;	          //18	VL_PIS	Valor do PIS/PASEP	N	-	02
    fVL_COFINS: Currency;	        //19	VL_COFINS	Valor da COFINS	N	-	02
  public
    property COD_MOD: string read FCOD_MOD write FCOD_MOD;
    property COD_MUN: Integer read FCOD_MUN write FCOD_MUN;
    property SER: string read FSER write FSER;
    property SUB: Integer read FSUB write FSUB;
    property IND_REC: Integer read FIND_REC write FIND_REC;
    property QTD_CONS: Integer read FQTD_CONS write FQTD_CONS;
    property DT_DOC_INI: TDateTime read FDT_DOC_INI write FDT_DOC_INI;
    property DT_DOC_FIN: TDateTime read FDT_DOC_FIN write FDT_DOC_FIN;
    property VL_DOC: Currency read FVL_DOC write FVL_DOC;
    property VL_DESC: Currency read FVL_DESC write FVL_DESC;
    property VL_SERV: Currency read FVL_SERV write FVL_SERV;
    property VL_SERV_NT: Currency read FVL_SERV_NT write FVL_SERV_NT;
    property VL_TERC: Currency read FVL_TERC write FVL_TERC;
    property VL_DA: Currency read FVL_DA write FVL_DA;
    property VL_BC_ICMS: Currency read FVL_BC_ICMS write FVL_BC_ICMS;
    property VL_ICMS: Currency read FVL_ICMS write FVL_ICMS;
    property VL_PIS: Currency read FVL_PIS write FVL_PIS;
    property VL_COFINS: Currency read FVL_COFINS write FVL_COFINS;
  end;

  //REGISTRO D601: COMPLEMENTO DA CONSOLIDAÇÃO DA PRESTAÇÃO DE SERVIÇOS (CÓDIGOS 21 E 22) - PIS/PASEP
  TRegistroD601 = class
  private
    fCOD_CLASS: Integer;              //02	COD_CLASS	Código de classificação do item do serviço de comunicação ou de telecomunicação, conforme a Tabela 4.4.1	N	004*	-
    fVL_ITEM: Currency;	              //03	VL_ITEM	Valor acumulado do item	N	-	02
    fVL_DESC: Currency;	              //04	VL_DESC	Valor acumulado dos descontos/exclusões da base de cálculo	N	-	02
    fCST_PIS: Integer;	              //05	CST_PIS	Código da Situação Tributária referente ao PIS/PASEP	N	002*	-
    fVL_BC_PIS: Currency;             //06	VL_BC_PIS	Valor da base de cálculo do PIS/PASEP	N	 -	02
    fALIQ_PIS: Currency;              //07	ALIQ_PIS	Alíquota do PIS/PASEP (em percentual)	N	008	04
    fVL_PIS: Currency;	              //08	VL_PIS	Valor do PIS/PASEP	N	-	02
    fCOD_CTA: string;	                //09	COD_CTA	Código da conta contábil debitada/creditada	C	060	-
  public
    property COD_CLASS: Integer read FCOD_CLASS write FCOD_CLASS;
    property VL_ITEM: Currency read FVL_ITEM write FVL_ITEM;
    property VL_DESC: Currency read FVL_DESC write FVL_DESC;
    property CST_PIS: Integer read FCST_PIS write FCST_PIS;
    property VL_BC_PIS: Currency read FVL_BC_PIS write FVL_BC_PIS;
    property ALIQ_PIS: Currency read FALIQ_PIS write FALIQ_PIS;
    property VL_PIS: Currency read FVL_PIS write FVL_PIS;
    property COD_CTA: string read FCOD_CTA write FCOD_CTA;
  end;

  //REGISTRO D605: COMPLEMENTO DA CONSOLIDAÇÃO DA PRESTAÇÃO DE SERVIÇOS (CÓDIGOS 21 E 22) - COFINS
  TRegistroD605 = class
  private
    fCOD_CLASS: Integer;	         //02	COD_CLASS	Código de classificação do item do serviço de comunicação ou de telecomunicação, conforme a Tabela 4.4.1	N	004*	-
    fVL_ITEM: Currency;	           //03	VL_ITEM	Valor acumulado do item	N	-	02
    fVL_DESC: Currency;	           //04	VL_DESC	Valor acumulado dos descontos/exclusões da base de cálculo	N	-	02
    fCST_COFINS: Integer;	         //05	CST_COFINS	Código da Situação Tributária referente a COFINS	N	002*	-
    fVL_BC_COFINS: Currency;       //06	VL_BC_COFINS	Valor da base de cálculo da COFINS	N	 -	02
    fALIQ_COFINS: Currency;	       //07	ALIQ_COFINS	Alíquota da COFINS (em percentual)	N	008-	04
    fVL_COFINS: Currency;	         //08	VL_COFINS	Valor da COFINS	N	-	02
    fCOD_CTA: string;	             //09	COD_CTA	Código da conta contábil debitada/creditada	C	060	-
  public
    property COD_CLASS: Integer read FCOD_CLASS write FCOD_CLASS;
    property VL_ITEM: Currency read FVL_ITEM write FVL_ITEM;
    property VL_DESC: Currency read FVL_DESC write FVL_DESC;
    property CST_COFINS: Integer read FCST_COFINS write FCST_COFINS;
    property VL_BC_COFINS: Currency read FVL_BC_COFINS write FVL_BC_COFINS;
    property ALIQ_COFINS: Currency read FALIQ_COFINS write FALIQ_COFINS;
    property VL_COFINS: Currency read FVL_COFINS write FVL_COFINS;
    property COD_CTA: string read FCOD_CTA write FCOD_CTA;
  end;

  //REGISTRO D609: PROCESSO REFERENCIADO
  TRegistroD609 = class
  private
    fNUM_PROC: string;        //02	NUM_PROC	Identificação do processo ou ato concessório	C	020	-
    fIND_PROC: Integer;       //03	IND_PROC	Indicador da origem do processo:1 - Justiça Federal;3 – Secretaria da Receita Federal do Brasil;9 – Outros.	C	001*	-
  public
    property NUM_PROC: string read FNUM_PROC write FNUM_PROC;
    property IND_PROC: Integer read FIND_PROC write FIND_PROC;
  end;

  //REGISTRO D990: ENCERRAMENTO DO BLOCO D
  TRegistroD990 = class
  private
    fQTD_LIN_D: Integer;         //02	QTD_LIN_D	Quantidade total de linhas do Bloco D	N	-	-
  public
    property QTD_LIN_D: Integer read FQTD_LIN_D write FQTD_LIN_D;
  end;

implementation

end.
