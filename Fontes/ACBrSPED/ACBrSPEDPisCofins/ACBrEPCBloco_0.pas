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

unit ACBrEPCBloco_0;

interface

uses
  SysUtils, Classes, Contnrs, DateUtils;

type
  //REGISTRO 0000: ABERTURA DO ARQUIVO DIGITAL E IDENTIFICAÇÃO DA PESSOA JURÍDICA
  TRegistro0000 = class
  private
    FIND_SIT_ESP: string;
    FNOME: string;
    FSUFRAMA: string;
    FTIPO_ESCRIT: string;
    FCOD_MUN: string;
    FCOD_VER: string;
    FIND_NAT_PJ: string;
    FCNPJ: string;
    FNUM_REC_ANTERIOR: string;
    FIND_ATIV: string;
    FUF: string;
    FDT_INI: TDateTime;
    FDT_FIN: TDateTime;
  public
    property COD_VER: string read FCOD_VER write FCOD_VER;
    property TIPO_ESCRIT: string read FTIPO_ESCRIT write FTIPO_ESCRIT;
    property IND_SIT_ESP: string read FIND_SIT_ESP write FIND_SIT_ESP;
    property NUM_REC_ANTERIOR: string read FNUM_REC_ANTERIOR write FNUM_REC_ANTERIOR;
    property DT_INI: TDateTime read FDT_INI write FDT_INI;
    property DT_FIN: TDateTime read FDT_FIN write FDT_FIN;
    property NOME: string read FNOME write FNOME;
    property CNPJ: string read FCNPJ write FCNPJ;
    property UF: string read FUF write FUF;
    property COD_MUN: string read FCOD_MUN write FCOD_MUN;
    property SUFRAMA: string read FSUFRAMA write FSUFRAMA;
    property IND_NAT_PJ: string read FIND_NAT_PJ write FIND_NAT_PJ;
    property IND_ATIV: string read FIND_ATIV write FIND_ATIV;
  end;

  //REGISTRO 0001: ABERTURA DO BLOCO 0
  TRegistro0001 = class(TOpenBlocos)
  private
  public
  end;

  //REGISTRO 0100: DADOS DO CONTABILISTA
  TRegistro0100 = class
  private
    FCOMPL: string;
    FCEP: string;
    FCPF: string;
    FNOME: string;
    FCOD_MUN: string;
    FEND: string;
    FCRC: string;
    FEMAIL: string;
    FCNPJ: string;
    FFONE: string;
    FNUM: string;
    FFAX: string;
    FBAIRRO: string;
  public
    property NOME: string read FNOME write FNOME;
    property CPF: string read FCPF write FCPF;
    property CRC: string read FCRC write FCRC;
    property CNPJ: string read FCNPJ write FCNPJ;
    property CEP: string read FCEP write FCEP;
    property _END: string read FEND write FEND;
    property NUM: string read FNUM write FNUM;
    property COMPL: string read FCOMPL write FCOMPL;
    property BAIRRO: string read FBAIRRO write FBAIRRO;
    property FONE: string read FFONE write FFONE;
    property FAX: string read FFAX write FFAX;
    property EMAIL: string read FEMAIL write FEMAIL;
    property COD_MUN: string read FCOD_MUN write FCOD_MUN;
  end;

  //REGISTRO 0110: REGIMES DE APURAÇÃO DA CONTRIBUIÇÃO SOCIAL E DE APROPRIAÇÃO DE CRÉDITO
  TRegistro0110 = class
  private
    FCOD_INC_TRIB: integer;
    FCOD_TIPO_CONT: integer;
  public
    property COD_INC_TRIB: integer read FCOD_INC_TRIB write FCOD_INC_TRIB;
    property COD_TIPO_CONT: integer read FCOD_TIPO_CONT write FCOD_TIPO_CONT;
  end;

  //REGISTRO 0111: DE RECEITA BRUTA MENSAL PARA FINS DE RATEIO DE CRÉDITOS COMUNS
  TRegistro0111 = class
  private
    FREC_BRU_CUM: currency;
    FREC_BRU_TOTAL: currency;
    FREC_BRU_NCUM_NT_MI: currency;
    FREC_BRU_NCUM_EXP: currency;
    FREC_BRU_NCUM_TRIB_MI: currency;
  public
    property REC_BRU_NCUM_TRIB_MI: currency read FREC_BRU_NCUM_TRIB_MI write FREC_BRU_NCUM_TRIB_MI;
    property REC_BRU_NCUM_NT_MI: currency read FREC_BRU_NCUM_NT_MI write FREC_BRU_NCUM_NT_MI;
    property REC_BRU_NCUM_EXP: currency read FREC_BRU_NCUM_EXP write FREC_BRU_NCUM_EXP;
    property REC_BRU_CUM: currency read FREC_BRU_CUM write FREC_BRU_CUM;
    property REC_BRU_TOTAL: currency read FREC_BRU_TOTAL write FREC_BRU_TOTAL;
  end;

  //REGISTRO 0140: TABELA DE CADASTRO DE ESTABELECIMENTO
  TRegistro0140 = class
  private
    FSUFRAMA: string;
    FCOD_EST: string;
    FNOME: string;
    FCOD_MUN: string;
    FIM: string;
    FCNPJ: string;
    FIE: string;
    FUF: string;
  public
    property COD_EST: string read FCOD_EST write FCOD_EST;
    property NOME: string read FNOME write FNOME;
    property CNPJ: string read FCNPJ write FCNPJ;
    property UF: string read FUF write FUF;
    property IE: string read FIE write FIE;
    property COD_MUN: string read FCOD_MUN write FCOD_MUN;
    property IM: string read FIM write FIM;
    property SUFRAMA: string read FSUFRAMA write FSUFRAMA;
  end;

  //REGISTRO 0150: TABELA DE CADASTRO DO PARTICIPANTE
  TRegistro0150 = class
  private
    FEND: string;
    FIE: string;
    FCOMPL: string;
    FNOME: string;
    FCOD_MUN: string;
    FSUFRAMA: string;
    FBAIRRO: string;
    FCOD_PART: string;
    FCNPJ: string;
    FCPF: string;
    FCOD_PAIS: string;
    FNUM: string;
  public
    property COD_PART: string read FCOD_PART write FCOD_PART;
    property NOME: string read FNOME write FNOME;
    property COD_PAIS: string read FCOD_PAIS write FCOD_PAIS;
    property CNPJ: string read FCNPJ write FCNPJ;
    property CPF: string read FCPF write FCPF;
    property IE: string read FIE write FIE;
    property COD_MUN: string read FCOD_MUN write FCOD_MUN;
    property SUFRAMA: string read FSUFRAMA write FSUFRAMA;
    property _END: string read FEND write FEND;
    property NUM: string read FNUM write FNUM;
    property COMPL: string read FCOMPL write FCOMPL;
    property BAIRRO: string read FBAIRRO write FBAIRRO;
  end;

  //REGISTRO 0190: IDENTIFICAÇÃO DAS UNIDADES DE MEDIDA
  TRegistro0190 = class
  private
    FDESCR: string;
    FUNID: string;
  public
    property UNID: string read FUNID write FUNID;
    property DESCR: string read FDESCR write FDESCR;
  end;

  //REGISTRO 0200: TABELA DE IDENTIFICAÇÃO DO ITEM (PRODUTOS E SERVIÇOS)
  TRegistro0200 = class
  private
    FCOD_BARRA: string;
    FEX_IPI: string;
    FCOD_ANT_ITEM: string;
    FCOD_NCM: string;
    FDESCR_ITEM: string;
    FTIPO_ITEM: string;
    FCOD_ITEM: string;
    FUNID_INV: string;
    FCOD_GEN: string;
    FCOD_LST: string;
    FALIQ_ICMS: currency;
  public
    property COD_ITEM: string read FCOD_ITEM write FCOD_ITEM;
    property DESCR_ITEM: string read FDESCR_ITEM write FDESCR_ITEM;
    property COD_BARRA: string read FCOD_BARRA write FCOD_BARRA;
    property COD_ANT_ITEM: string read FCOD_ANT_ITEM write FCOD_ANT_ITEM;
    property UNID_INV: string read FUNID_INV write FUNID_INV;
    property TIPO_ITEM: string read FTIPO_ITEM write FTIPO_ITEM;
    property COD_NCM: string read FCOD_NCM write FCOD_NCM;
    property EX_IPI: string read FEX_IPI write FEX_IPI;
    property COD_GEN: string read FCOD_GEN write FCOD_GEN;
    property COD_LST: string read FCOD_LST write FCOD_LST;
    property ALIQ_ICMS: currency read FALIQ_ICMS write FALIQ_ICMS;
  end;

  //REGISTRO 0205: ALTERAÇÃO DO ITEM
  TRegistro0205 = class
  private
    FDESCR_ANT_ITEM: string;
    FCOD_ANT_ITEM: string;
    FDT_INI: TDateTime;
    FDT_FIM: TDateTime;
  public
    property DESCR_ANT_ITEM: string read FDESCR_ANT_ITEM write FDESCR_ANT_ITEM;
    property DT_INI: TDateTime read FDT_INI write FDT_INI;
    property DT_FIM: TDateTime read FDT_FIM write FDT_FIM;
    property COD_ANT_ITEM: string read FCOD_ANT_ITEM write FCOD_ANT_ITEM;
  end;

  //REGISTRO 0206: CÓDIGO DE PRODUTO CONFORME TABELA ANP (COMBUSTÍVEIS)
  TRegistro0206 = class
  private
    FCOD_COMB: string;
  public
    property COD_COMB: string read FCOD_COMB write FCOD_COMB;
  end;

  //REGISTRO 0208: CÓDIGO DE GRUPOS POR MARCA COMERCIAL - REFRI (BEBIDAS FRIAS).
  TRegistro0208 = class
  private
    FMARCA_COM: string;
    FCOD_TAB: string;
    FCOD_GRU: string;
  public
    property COD_TAB: string read FCOD_TAB write FCOD_TAB;
    property COD_GRU: string read FCOD_GRU write FCOD_GRU;
    property MARCA_COM: string read FMARCA_COM write FMARCA_COM;
  end;

  //REGISTRO 0400: TABELA DE NATUREZA DA OPERAÇÃO/PRESTAÇÃO
  TRegistro0400 = class
  private
    FCOD_NAT: string;
    FDESCR_NAT: string;
  public
    property COD_NAT: string read FCOD_NAT write FCOD_NAT;
    property DESCR_NAT: string read FDESCR_NAT write FDESCR_NAT;
  end;

  //REGISTRO 0450: TABELA DE INFORMAÇÃO COMPLEMENTAR DO DOCUMENTO FISCAL
  TRegistro0450 = class
  private
    FCOD_INF: string;
    FTXT: string;
  public
    property COD_INF: string read FCOD_INF write FCOD_INF;
    property TXT: string read FTXT write FTXT;
  end;

  //REGISTRO 0500: PLANO DE CONTAS CONTÁBEIS
  TRegistro0500 = class
  private
    FCNPJ_EST: string;
    FCOD_CTA: string;
    FNOME_CTA: string;
    FCOD_CTA_REF: string;
    FNIVEL: string;
    FIND_CTA: string;
  public
    property DT_ALT read FDT_ALT  write FDT_ALT;
    property COD_NAT_CC: string read FCOD_NAT_CC write FCOD_NAT_CC;
    property IND_CTA: string read FIND_CTA  write FIND_CTA ;
    property NIVEL: string read FNIVEL write FNIVEL;
    property COD_CTA : string read FCOD_CTA  write FCOD_CTA ;
    property NOME_CTA : string read FNOME_CTA  write FNOME_CTA ;
    property COD_CTA_REF: string read FCOD_CTA_REF write FCOD_CTA_REF;
    property CNPJ_EST: string read FCNPJ_EST write FCNPJ_EST;
  end;

  //REGISTRO 0600: CENTRO DE CUSTOS
  TRegistro0600 = class
  private
    FCOD_CCUS: string;
    FCCUS: string;
    FDT_ALT: TDateTime;
  public
    property DT_ALT : TDateTime read FDT_ALT  write FDT_ALT ;
    property COD_CCUS : string read FCOD_CCUS  write FCOD_CCUS ;
    property CCUS: string read FCCUS write FCCUS;
  end;

  //REGISTRO 0990: ENCERRAMENTO DO BLOCO 0
  TRegistro0990 = class
  private
    FQTD_LIN_0: integer;
  public
    property QTD_LIN_0: integer read FQTD_LIN_0 write FQTD_LIN_0;
  end;

implementation

end.
