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
|* 14/12/2010: Isaque Pinheiro e Paulo Junqueira
|*  - Criação e distribuição da Primeira Versao
*******************************************************************************}

unit ACBrEPCBloco_M;

interface

uses
  SysUtils, Classes, Contnrs, DateUtils;

type
  //REGISTRO M001: ABERTURA DO BLOCO M
  TRegistroM001 = class(TOpenBlocos)
  private
  public
  end;

  //REGISTRO M100: ABERTURA DO BLOCO M
  TRegistroM100 = class
  private
    FALIQ_PIS: currency;
    FVL_CRED_DESC: currency;
    FVL_AJUS_ACRES: currency;
    FVL_CRED_DIF: currency;
    FSLD_CRED: currency;
    FVL_CRED: currency;
    FALIQ_PIS_QUANT: currency;
    FVL_AJUS_REDUC: currency;
    FVL_CRED_DISP: currency;
    FQUANT_BC_PIS: currency;
    FVL_BC_PIS: currency;
    FIND_CRED_ORI: integer;
    FCOD_CRED: string;
    FIND_DESC_CRED: string;
  public
    property COD_CRED: string read FCOD_CRED write FCOD_CRED;
    property IND_CRED_ORI: integer read FIND_CRED_ORI write FIND_CRED_ORI;
    property VL_BC_PIS: currency read FVL_BC_PIS write FVL_BC_PIS;
    property ALIQ_PIS: currency read FALIQ_PIS write FALIQ_PIS;
    property QUANT_BC_PIS: currency read FQUANT_BC_PIS write FQUANT_BC_PIS;
    property ALIQ_PIS_QUANT: currency read FALIQ_PIS_QUANT write FALIQ_PIS_QUANT;
    property VL_CRED: currency read FVL_CRED write FVL_CRED;
    property VL_AJUS_ACRES: currency read FVL_AJUS_ACRES write FVL_AJUS_ACRES;
    property VL_AJUS_REDUC: currency read FVL_AJUS_REDUC write FVL_AJUS_REDUC;
    property VL_CRED_DIF: currency read FVL_CRED_DIF write FVL_CRED_DIF;
    property VL_CRED_DISP: currency read FVL_CRED_DISP write FVL_CRED_DISP;
    property IND_DESC_CRED: string read FIND_DESC_CRED write FIND_DESC_CRED;
    property VL_CRED_DESC: currency read FVL_CRED_DESC write FVL_CRED_DESC;
    property SLD_CRED: currency read FSLD_CRED write FSLD_CRED;
  end;

  //REGISTRO M105: DETALHAMENTO DA BASE DE CALCULO DO CRÉDITO APURADO NO PERÍODO - PIS/PASEP
  TRegistroM105 = class
  private
    FQUANT_BC_PIS: currency;
    FVL_BC_PIS_CUM: currency;
    FQUANT_BC_PIS_TOT: currency;
    FVL_BC_PIS_TOT: currency;
    FVL_BC_PIS_NC: currency;
    FVL_BC_PIS: currency;
    FCST_PIS: string;
    FDESC_CRED: string;
    FNAT_BC_CRED: string;
  public
    property NAT_BC_CRED: string read FNAT_BC_CRED write FNAT_BC_CRED;
    property CST_PIS: string read FCST_PIS write FCST_PIS;
    property VL_BC_PIS_TOT: currency read FVL_BC_PIS_TOT write FVL_BC_PIS_TOT;
    property VL_BC_PIS_CUM: currency read FVL_BC_PIS_CUM write FVL_BC_PIS_CUM;
    property VL_BC_PIS_NC: currency read FVL_BC_PIS_NC write FVL_BC_PIS_NC;
    property VL_BC_PIS: currency read FVL_BC_PIS write FVL_BC_PIS;
    property QUANT_BC_PIS_TOT: currency read FQUANT_BC_PIS_TOT write FQUANT_BC_PIS_TOT;
    property QUANT_BC_PIS: currency read FQUANT_BC_PIS write FQUANT_BC_PIS;
    property DESC_CRED: string read FDESC_CRED write FDESC_CRED;
  end;

  //REGISTRO M110: AJUSTES DO CRÉDITO DE PIS/PASEP APURADO
  TRegistroM110 = class
  private
    FVL_AJ: currency;
    FNUM_DOC: string;
    FCOD_AJ: string;
    FDESCR_AJ: string;
    FIND_AJ: string;
    FDT_REF: TDateTime;
  public
    property IND_AJ: string read FIND_AJ write FIND_AJ;
    property VL_AJ: currency read FVL_AJ write FVL_AJ;
    property COD_AJ: string read FCOD_AJ write FCOD_AJ;
    property NUM_DOC: string read FNUM_DOC write FNUM_DOC;
    property DESCR_AJ: string read FDESCR_AJ write FDESCR_AJ;
    property DT_REF: TDateTime read FDT_REF write FDT_REF;
  end;

  //REGISTRO M200: CONSOLIDAÇÃO DA CONTRIBUIÇÃO PARA O PIS/PASEP DO PERÍODO
  TRegistroM200 = class
  private
    FVL_TOT_CONT_REC: currency;
    FVL_TOT_CRED_DESC: currency;
    FVL_OUT_DED_CUM: currency;
    FVL_TOT_CONT_NC_DEV: currency;
    FVL_RET_CUM: currency;
    FVL_RET_NC: currency;
    FVL_TOT_CONT_NC_PER: currency;
    FVL_CONT_CUM_REC: currency;
    FVL_CONT_NC_REC: currency;
    FVL_OUT_DED_NC: currency;
    FVL_TOT_CRED_DESC_ANT: currency;
    FVL_TOT_CONT_CUM_PER: currency;
  public
    property VL_TOT_CONT_NC_PER: currency read FVL_TOT_CONT_NC_PER write FVL_TOT_CONT_NC_PER;
    property VL_TOT_CRED_DESC: currency read FVL_TOT_CRED_DESC write FVL_TOT_CRED_DESC;
    property VL_TOT_CRED_DESC_ANT: currency read FVL_TOT_CRED_DESC_ANT write FVL_TOT_CRED_DESC_ANT;
    property VL_TOT_CONT_NC_DEV: currency read FVL_TOT_CONT_NC_DEV write FVL_TOT_CONT_NC_DEV;
    property VL_RET_NC: currency read FVL_RET_NC write FVL_RET_NC;
    property VL_OUT_DED_NC: currency read FVL_OUT_DED_NC write FVL_OUT_DED_NC;
    property VL_CONT_NC_REC: currency read FVL_CONT_NC_REC write FVL_CONT_NC_REC;
    property VL_TOT_CONT_CUM_PER: currency read FVL_TOT_CONT_CUM_PER write FVL_TOT_CONT_CUM_PER;
    property VL_RET_CUM: currency read FVL_RET_CUM write FVL_RET_CUM;
    property VL_OUT_DED_CUM: currency read FVL_OUT_DED_CUM write FVL_OUT_DED_CUM;
    property VL_CONT_CUM_REC: currency read FVL_CONT_CUM_REC write FVL_CONT_CUM_REC;
    property VL_TOT_CONT_REC: currency read FVL_TOT_CONT_REC write FVL_TOT_CONT_REC;
  end;

  //REGISTRO M210: DETALHAMENTO DA CONTRIBUIÇÃO PARA O PIS/PASEP DO PERÍODO
  TRegistroM210 = class
  private
    FALIQ_PIS: currency;
    FVL_CONT_PER: currency;
    FVL_CONT_DIFER: currency;
    FVL_AJUS_REDUC: currency;
    FVL_AJUS_ACRES: currency;
    FVL_CONT_DIFER_ANT: currency;
    FALIQ_PIS_QUANT: currency;
    FVL_BC_CONT: currency;
    FVL_CONT_APUR: currency;
    FVL_REC_BRT: currency;
    FQUANT_BC_PIS: currency;
    FCOD_CONT: string;
  public
    property COD_CONT: string read FCOD_CONT write FCOD_CONT;
    property VL_REC_BRT: currency read FVL_REC_BRT write FVL_REC_BRT;
    property VL_BC_CONT: currency read FVL_BC_CONT write FVL_BC_CONT;
    property ALIQ_PIS: currency read FALIQ_PIS write FALIQ_PIS;
    property QUANT_BC_PIS: currency read FQUANT_BC_PIS write FQUANT_BC_PIS;
    property ALIQ_PIS_QUANT: currency read FALIQ_PIS_QUANT write FALIQ_PIS_QUANT;
    property VL_CONT_APUR: currency read FVL_CONT_APUR write FVL_CONT_APUR;
    property VL_AJUS_ACRES: currency read FVL_AJUS_ACRES write FVL_AJUS_ACRES;
    property VL_AJUS_REDUC: currency read FVL_AJUS_REDUC write FVL_AJUS_REDUC;
    property VL_CONT_DIFER: currency read FVL_CONT_DIFER write FVL_CONT_DIFER;
    property VL_CONT_DIFER_ANT: currency read FVL_CONT_DIFER_ANT write FVL_CONT_DIFER_ANT;
    property VL_CONT_PER: currency read FVL_CONT_PER write FVL_CONT_PER;
  end;

  //REGISTRO M211: SOCIEDADES COOPERATIVAS - COMPOSIÇÃO DA BASE DE CALCULO - PIS/PASEP
  TRegistroM211 = class
  private
    FVL_BC_CONT_ANT_EXC_COOP: currency;
    FVL_EXC_COOP_GER: currency;
    FVL_BC_CONT: currency;
    FVL_EXC_ESP_COOP: currency;
    FIND_TIP_COOP: string;
  public
    property IND_TIP_COOP: string read FIND_TIP_COOP write FIND_TIP_COOP;
    property VL_BC_CONT_ANT_EXC_COOP: currency read FVL_BC_CONT_ANT_EXC_COOP write FVL_BC_CONT_ANT_EXC_COOP;
    property VL_EXC_COOP_GER: currency read FVL_EXC_COOP_GER write FVL_EXC_COOP_GER;
    property VL_EXC_ESP_COOP: currency read FVL_EXC_ESP_COOP write FVL_EXC_ESP_COOP;
    property VL_BC_CONT: currency read FVL_BC_CONT write FVL_BC_CONT;
  end;

  //REGISTRO M220: AJUSTES DA CONTRIBUIÇÃO PARA O PIS/PASEP APURADA
  TRegistroM220 = class
  private
    FVL_AJ: currency;
    FNUM_DOC: string;
    FCOD_AJ: string;
    FDESCR_AJ: string;
    FIND_AJ: string;
    FDT_REF: TDateTime;
  public
    property IND_AJ: string read FIND_AJ write FIND_AJ;
    property VL_AJ: currency read FVL_AJ write FVL_AJ;
    property COD_AJ: string read FCOD_AJ write FCOD_AJ;
    property NUM_DOC: string read FNUM_DOC write FNUM_DOC;
    property DESCR_AJ: string read FDESCR_AJ write FDESCR_AJ;
    property DT_REF: TDateTime read FDT_REF write FDT_REF;
  end;

  //REGISTRO M230: INFORMAÇÕES ADICIONAIS DE DIFERIMENTO
  TRegistroM230 = class
  private
    FVL_CONT_DIF: currency;
    FVL_NAO_RECEB: currency;
    FVL_CRED_DIF: currency;
    FVL_VEND: currency;
    FCNPJ: string;
    FCOD_CRED: string;
  public
    property CNPJ: string read FCNPJ write FCNPJ;
    property VL_VEND: currency read FVL_VEND write FVL_VEND;
    property VL_NAO_RECEB: currency read FVL_NAO_RECEB write FVL_NAO_RECEB;
    property VL_CONT_DIF: currency read FVL_CONT_DIF write FVL_CONT_DIF;
    property VL_CRED_DIF: currency read FVL_CRED_DIF write FVL_CRED_DIF;
    property COD_CRED: string read FCOD_CRED write FCOD_CRED;
  end;

  //REGISTRO M300: CONTRIBUIÇÃO DE PIS/PASEP DIFERIDA EM PERÍODOS ANTERIORES - VALORES A PAGAR NO PERÍODO
  TRegistroM300 = class
  private
    FCOD_CONT: string;
    FVL_CONT_REC: currency;
    FNAT_CRED_DESC: string;
    FVL_CRED_DESC: currency;
    FPER_APUR: string;
    FDT_RECEB: TDateTime;
  public
    property COD_CONT: string read FCOD_CONT write FCOD_CONT;
    property VL_CONT_REC: currency read FVL_CONT_REC write FVL_CONT_REC;
    property NAT_CRED_DESC: string read FNAT_CRED_DESC write FNAT_CRED_DESC;
    property VL_CRED_DESC: currency read FVL_CRED_DESC write FVL_CRED_DESC;
    property PER_APUR: string read FPER_APUR write FPER_APUR;
    property DT_RECEB: TDateTime read FDT_RECEB write FDT_RECEB;
  end;

  //REGISTRO M350: CONTRIBUIÇÃO DE PIS/PASEP DIFERIDA EM PERÍODOS ANTERIORES - VALORES A PAGAR NO PERÍODO
  TRegistroM350 = class
  private
    FVL_TOT_FOL: currency;
    FVL_EXC_BC: currency;
    FALIQ_PIS_FOL: currency;
    FVL_TOT_BC: currency;
    FVL_TOT_CONT_FOL: currency;
  public
    property VL_TOT_FOL: currency read FVL_TOT_FOL write FVL_TOT_FOL;
    property VL_EXC_BC: currency read FVL_EXC_BC write FVL_EXC_BC;
    property VL_TOT_BC: currency read FVL_TOT_BC write FVL_TOT_BC;
    property ALIQ_PIS_FOL: currency read FALIQ_PIS_FOL write FALIQ_PIS_FOL;
    property VL_TOT_CONT_FOL: currency read FVL_TOT_CONT_FOL write FVL_TOT_CONT_FOL;
  end;

  //REGISTRO M400: RECEITAS ISENTAS, NÃO ALCANÇADAS PELA INCIDÊNCIA DA CONTRIBUIÇÃO, SUJEITAS A ALÍQUOTA ZERO OU DE VENDAS COM SUSPENSÃO - PIS/PASEP
  TRegistroM400 = class
  private
    FVL_TOT_REC: currency;
    FDESC_COMPL: string;
    FCOD_CTA: string;
    FCST_PIS: string;
  public
    property CST_PIS: string read FCST_PIS write FCST_PIS;
    property VL_TOT_REC: currency read FVL_TOT_REC write FVL_TOT_REC;
    property COD_CTA: string read FCOD_CTA write FCOD_CTA;
    property DESC_COMPL: string read FDESC_COMPL write FDESC_COMPL;
  end;

  //REGISTRO M410: DETALHAMENTO DAS RECEITAS ISENTAS, NÃO ALCANÇADAS PELA INCIDÊNCIA DA CONTRIBUIÇÃO, SUJEITAS A ALÍQUOTA ZERO OU DE VENDAS COM SUSPENSÃO - PIS/PASEP
  TRegistroM410 = class
  private
    FVL_REC: currency;
    FDESC_COMPL: string;
    FCOD_CTA: string;
    FNAT_REC: string;
  public
    property NAT_REC: string read FNAT_REC write FNAT_REC;
    property VL_REC: currency read FVL_REC write FVL_REC;
    property COD_CTA: string read FCOD_CTA write FCOD_CTA;
    property DESC_COMPL: string read FDESC_COMPL write FDESC_COMPL;
  end;

  //REGISTRO M500: CRÉDITO DE COFINS RELATIVO AO PERÍODO
  TRegistroM500 = class
  private
    FVL_AJUS_ACRES: currency;
    FALIQ_COFINS: currency;
    FVL_CRED: currency;
    FVL_AJUS_REDUC: currency;
    FVL_CRED_DESC: currency;
    FSLD_CRED: currency;
    FALIQ_COFINS_QUANT: currency;
    FVL_CRED_DISP: currency;
    FVL_CRED_DIFER: currency;
    FVL_BC_COFINS: currency;
    FQUANT_BC_COFINS: currency;
    FIND_DESC_CRED: integer;
    FIND_CRED_ORI: integer;
    FCOD_CRED: string;
  public
    property COD_CRED: string read FCOD_CRED write FCOD_CRED;
    property IND_CRED_ORI: integer read FIND_CRED_ORI write FIND_CRED_ORI;
    property VL_BC_COFINS: currency read FVL_BC_COFINS write FVL_BC_COFINS;
    property ALIQ_COFINS: currency read FALIQ_COFINS write FALIQ_COFINS;
    property QUANT_BC_COFINS: currency read FQUANT_BC_COFINS write FQUANT_BC_COFINS;
    property ALIQ_COFINS_QUANT: currency read FALIQ_COFINS_QUANT write FALIQ_COFINS_QUANT;
    property VL_CRED: currency read FVL_CRED write FVL_CRED;
    property VL_AJUS_ACRES: currency read FVL_AJUS_ACRES write FVL_AJUS_ACRES;
    property VL_AJUS_REDUC: currency read FVL_AJUS_REDUC write FVL_AJUS_REDUC;
    property VL_CRED_DIFER: currency read FVL_CRED_DIFER write FVL_CRED_DIFER;
    property VL_CRED_DISP: currency read FVL_CRED_DISP write FVL_CRED_DISP;
    property IND_DESC_CRED: integer read FIND_DESC_CRED write FIND_DESC_CRED;
    property VL_CRED_DESC: currency read FVL_CRED_DESC write FVL_CRED_DESC;
    property SLD_CRED: currency read FSLD_CRED write FSLD_CRED;
  end;

  //REGISTRO M505: DETALHAMENTO DA BASE DE CALCULO DO CRÉDITO APURADO NO PERÍODO - COFINS
  TRegistroM505 = class
  private
    FQUANT_BC_COFINS: currency;
    FVL_BC_COFINS_CUM: currency;
    FQUANT_BC_COFINS_TOT: currency;
    FVL_BC_COFINS_TOT: currency;
    FVL_BC_COFINS_NC: currency;
    FVL_BC_COFINS: currency;
    FCST_COFINS: string;
    FDESC_CRED: string;
    FNAT_BC_CRED: string;
  public
    property NAT_BC_CRED: string read FNAT_BC_CRED write FNAT_BC_CRED;
    property CST_COFINS: string read FCST_COFINS write FCST_COFINS;
    property VL_BC_COFINS_TOT: currency read FVL_BC_COFINS_TOT write FVL_BC_COFINS_TOT;
    property VL_BC_COFINS_CUM: currency read FVL_BC_COFINS_CUM write FVL_BC_COFINS_CUM;
    property VL_BC_COFINS_NC: currency read FVL_BC_COFINS_NC write FVL_BC_COFINS_NC;
    property VL_BC_COFINS: currency read FVL_BC_COFINS write FVL_BC_COFINS;
    property QUANT_BC_COFINS_TOT: currency read FQUANT_BC_COFINS_TOT write FQUANT_BC_COFINS_TOT;
    property QUANT_BC_COFINS: currency read FQUANT_BC_COFINS write FQUANT_BC_COFINS;
    property DESC_CRED: string read FDESC_CRED write FDESC_CRED;
  end;

  //REGISTRO M510: AJUSTES DO CRÉDITO DE COFINS APURADO
  TRegistroM510 = class
  private
    FVL_AJ: currency;
    FNUM_DOC: string;
    FCOD_AJ: string;
    FDESCR_AJ: string;
    FIND_AJ: string;
    FDT_REF: TDateTime;
  public
    property IND_AJ: string read FIND_AJ write FIND_AJ;
    property VL_AJ: currency read FVL_AJ write FVL_AJ;
    property COD_AJ: string read FCOD_AJ write FCOD_AJ;
    property NUM_DOC: string read FNUM_DOC write FNUM_DOC;
    property DESCR_AJ: string read FDESCR_AJ write FDESCR_AJ;
    property DT_REF: TDateTime read FDT_REF write FDT_REF;
  end;

  //REGISTRO M600: CONSOLIDAÇÃO DA CONTRIBUIÇÃO PARA A SEGURIDADE SOCIAL - COFINS DO PERÍODO
  TRegistroM600 = class
  private
    FVL_TOT_CONT_REC: currency;
    FVL_TOT_CRED_DESC: currency;
    FVL_OUT_DED_CUM: currency;
    FVL_TOT_CONT_NC_DEV: currency;
    FVL_RET_CUM: currency;
    FVL_RET_NC: currency;
    FVL_TOT_CONT_NC_PER: currency;
    FVL_CONT_CUM_REC: currency;
    FVL_CONT_NC_REC: currency;
    FVL_OUT_DED_NC: currency;
    FVL_TOT_CRED_DESC_ANT: currency;
    FVL_TOT_CONT_CUM_PER: currency;
  public
    property VL_TOT_CONT_NC_PER: currency read FVL_TOT_CONT_NC_PER write FVL_TOT_CONT_NC_PER;
    property VL_TOT_CRED_DESC: currency read FVL_TOT_CRED_DESC write FVL_TOT_CRED_DESC;
    property VL_TOT_CRED_DESC_ANT: currency read FVL_TOT_CRED_DESC_ANT write FVL_TOT_CRED_DESC_ANT;
    property VL_TOT_CONT_NC_DEV: currency read FVL_TOT_CONT_NC_DEV write FVL_TOT_CONT_NC_DEV;
    property VL_RET_NC: currency read FVL_RET_NC write FVL_RET_NC;
    property VL_OUT_DED_NC: currency read FVL_OUT_DED_NC write FVL_OUT_DED_NC;
    property VL_CONT_NC_REC: currency read FVL_CONT_NC_REC write FVL_CONT_NC_REC;
    property VL_TOT_CONT_CUM_PER: currency read FVL_TOT_CONT_CUM_PER write FVL_TOT_CONT_CUM_PER;
    property VL_RET_CUM: currency read FVL_RET_CUM write FVL_RET_CUM;
    property VL_OUT_DED_CUM: currency read FVL_OUT_DED_CUM write FVL_OUT_DED_CUM;
    property VL_CONT_CUM_REC: currency read FVL_CONT_CUM_REC write FVL_CONT_CUM_REC;
    property VL_TOT_CONT_REC: currency read FVL_TOT_CONT_REC write FVL_TOT_CONT_REC;
  end;

  //REGISTRO M610: DETALHAMENTO DA CONTRIBUIÇÃO PARA A SEGURIDADE SOCIAL - COFINS DO PERÍODO
  TRegistroM610 = class
  private
    FVL_CONT_DIFER: currency;
    FVL_CONT_PER: currency;
    FALIQ_COFINS: currency;
    FVL_AJUS_REDUC: currency;
    FVL_AJUS_ACRES: currency;
    FVL_CONT_DIFER_ANT: currency;
    FALIQ_COFINS_QUANT: currency;
    FVL_BC_CONT: currency;
    FVL_CONT_APUR: currency;
    FVL_REC_BRT: currency;
    FQUANT_BC_COFINS: currency;
    FCOD_CONT: string;
  public
    property COD_CONT: string read FCOD_CONT write FCOD_CONT;
    property VL_REC_BRT: currency read FVL_REC_BRT write FVL_REC_BRT;
    property VL_BC_CONT: currency read FVL_BC_CONT write FVL_BC_CONT;
    property ALIQ_COFINS: currency read FALIQ_COFINS write FALIQ_COFINS;
    property QUANT_BC_COFINS: currency read FQUANT_BC_COFINS write FQUANT_BC_COFINS;
    property ALIQ_COFINS_QUANT: currency read FALIQ_COFINS_QUANT write FALIQ_COFINS_QUANT;
    property VL_CONT_APUR: currency read FVL_CONT_APUR write FVL_CONT_APUR;
    property VL_AJUS_ACRES: currency read FVL_AJUS_ACRES write FVL_AJUS_ACRES;
    property VL_AJUS_REDUC: currency read FVL_AJUS_REDUC write FVL_AJUS_REDUC;
    property VL_CONT_DIFER: currency read FVL_CONT_DIFER write FVL_CONT_DIFER;
    property VL_CONT_DIFER_ANT: currency read FVL_CONT_DIFER_ANT write FVL_CONT_DIFER_ANT;
    property VL_CONT_PER: currency read FVL_CONT_PER write FVL_CONT_PER;
  end;

  //REGISTRO M611: SOCIEDADES COOPERATIVAS - COMPOSIÇÃO DA BASE DE CALCULO - COFINS
  TRegistroM611 = class
  private
    FVL_BC_CONT_ANT_EXC_COOP: currency;
    FVL_EXC_COOP_GER: currency;
    FVL_BC_CONT: currency;
    FVL_EXC_ESP_COOP: currency;
    FIND_TIP_COOP: string;
  public
    property IND_TIP_COOP: string read FIND_TIP_COOP write FIND_TIP_COOP;
    property VL_BC_CONT_ANT_EXC_COOP: currency read FVL_BC_CONT_ANT_EXC_COOP write FVL_BC_CONT_ANT_EXC_COOP;
    property VL_EXC_COOP_GER: currency read FVL_EXC_COOP_GER write FVL_EXC_COOP_GER;
    property VL_EXC_ESP_COOP: currency read FVL_EXC_ESP_COOP write FVL_EXC_ESP_COOP;
    property VL_BC_CONT: currency read FVL_BC_CONT write FVL_BC_CONT;
  end;

  //REGISTRO M620: AJUSTES DA COFINS APURADA
  TRegistroM620 = class
  private
    FVL_AJ: currency;
    FNUM_DOC: string;
    FCOD_AJ: string;
    FDESCR_AJ: string;
    FIND_AJ: string;
    FDT_REF: TDateTime;
  public
    property IND_AJ: string read FIND_AJ write FIND_AJ;
    property VL_AJ: currency read FVL_AJ write FVL_AJ;
    property COD_AJ: string read FCOD_AJ write FCOD_AJ;
    property NUM_DOC: string read FNUM_DOC write FNUM_DOC;
    property DESCR_AJ: string read FDESCR_AJ write FDESCR_AJ;
    property DT_REF: TDateTime read FDT_REF write FDT_REF;
  end;

  //REGISTRO M630: INFORMAÇÕES ADICIONAIS DE DIFERIMENTO
  TRegistroM630 = class
  private
    FVL_CONT_DIF: currency;
    FVL_NAO_RECEB: currency;
    FVL_CRED_DIF: currency;
    FVL_VEND: currency;
    FCNPJ: string;
    FCOD_CRED: string;
  public
    property CNPJ: string read FCNPJ write FCNPJ;
    property VL_VEND: currency read FVL_VEND write FVL_VEND;
    property VL_NAO_RECEB: currency read FVL_NAO_RECEB write FVL_NAO_RECEB;
    property VL_CONT_DIF: currency read FVL_CONT_DIF write FVL_CONT_DIF;
    property VL_CRED_DIF: currency read FVL_CRED_DIF write FVL_CRED_DIF;
    property COD_CRED: string read FCOD_CRED write FCOD_CRED;
  end;

  //REGISTRO M700: COFINS DIFERIDA EM PERÍODOS ANTERIORES - VALORES A PAGAR NO PERÍODO
  TRegistroM700 = class
  private
    FPER_APUR: currency;
    FVL_CONT_REC: currency;
    FVL_CRED_DESC: currency;
    FCOD_CONT: string;
    FNAT_CRED_DESC: string;
    FDT_RECEB: TDateTime;
  public
    property COD_CONT: string read FCOD_CONT write FCOD_CONT;
    property VL_CONT_REC: currency read FVL_CONT_REC write FVL_CONT_REC;
    property NAT_CRED_DESC: string read FNAT_CRED_DESC write FNAT_CRED_DESC;
    property VL_CRED_DESC: currency read FVL_CRED_DESC write FVL_CRED_DESC;
    property PER_APUR: currency read FPER_APUR write FPER_APUR;
    property DT_RECEB: TDateTime read FDT_RECEB write FDT_RECEB;
  end;

  //REGISTRO M800: RECEITAS ISENTAS, NÃO ALCANÇADAS PELA INCIDÊNCIA DA CONTRIBUIÇÃO, SUJEITAS A ALÍQUOTA ZERO OU DE VENDAS COM SUSPENSÃO - COFINS
  TRegistroM800 = class
  private
    FVL_TOT_REC: currency;
    FDESC_COMPL: string;
    FCOD_CTA: string;
    FCST_COFINS: string;
  public
    property CST_COFINS: string read FCST_COFINS write FCST_COFINS;
    property VL_TOT_REC: currency read FVL_TOT_REC write FVL_TOT_REC;
    property COD_CTA: string read FCOD_CTA write FCOD_CTA;
    property DESC_COMPL: string read FDESC_COMPL write FDESC_COMPL;
  end;

  //REGISTRO M810: DETALHAMENTO DAS RECEITAS ISENTAS, NÃO ALCANÇADAS PELA INCIDÊNCIA DA CONTRIBUIÇÃO, SUJEITAS A ALÍQUOTA ZERO OU DE VENDAS COM SUSPENSÃO - COFINS
  TRegistroM810 = class
  private
    FVL_REC: currency;
    FDESC_COMPL: string;
    FCOD_CTA: string;
    FNAT_REC: string;
  public
    property NAT_REC: string read FNAT_REC write FNAT_REC;
    property VL_REC: currency read FVL_REC write FVL_REC;
    property COD_CTA: string read FCOD_CTA write FCOD_CTA;
    property DESC_COMPL: string read FDESC_COMPL write FDESC_COMPL;
  end;

  //REGISTRO M900: ENCERRAMENTO DO BLOCO M
  TRegistroM900 = class
  private
    FQTD_LIN_E: integer;
  public
    property QTD_LIN_E: integer read FQTD_LIN_E write FQTD_LIN_E;
  end;

implementation

end.
