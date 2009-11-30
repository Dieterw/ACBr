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

unit ACBrBloco_I;

interface

uses
  SysUtils, Classes, DateUtils, ACBrBlocos;

type
  /// Registro I001 - ABERTURA DO BLOCO I

  TRegistroI001 = class(TOpenBlocos)
  private
  public
  end;

  /// Registro I010 - IDENTIFICAÇÃO DA ESCRITURAÇÃO CONTÁBIL

  TRegistroI010 = class(TPersistent)
  private
    fIND_ESC: AnsiString;    /// Indicador da forma de escrituração contábil:G - Livro Diário (Completo sem escrituração auxiliar);R - Livro Diário com Escrituração Resumida (com escrituração auxiliar);A - Livro Diário Auxiliar ao Diário com Escrituração Resumida;B - Livro Balancetes Diários e Balanços;Z - Razão Auxiliar (Livro Contábil Auxiliar conforme leiaute definido nos registros I500 a I555).
    fCOD_VER_LC: AnsiString; /// Código da Versão do Leiaute Contábil (preencher com 1.00).
  public
    property IND_ESC: AnsiString read fIND_ESC write fIND_ESC;
    property COD_VER_LC: AnsiString read fCOD_VER_LC write fCOD_VER_LC;
  end;

  /// Registro I012 - LIVROS AUXILIARES AO DIÁRIO

  TRegistroI012 = class(TPersistent)
  private
    fNUM_ORD: AnsiString;        /// Número de ordem do instrumento associado.
    fNAT_LIVR: AnsiString;       /// Natureza do livro associado; finalidade a que se destina o instrumento.
    fTIPO: AnsiString;           /// Tipo de escrituração do livro associado: 0 – digital (incluídos no Sped) 1 – outros.
    fCOD_HASH_AUX: AnsiString;   /// Código Hash do arquivo correspondente ao livro auxiliar utilizado na assinatura digital.
  public
    property NUM_ORD: AnsiString read fNUM_ORD write fNUM_ORD;
    property NAT_LIVR: AnsiString read fNAT_LIVR write fNAT_LIVR;
    property TIPO: AnsiString read fTIPO write fTIPO;
    property COD_HASH_AUX: AnsiString read fCOD_HASH_AUX write fCOD_HASH_AUX;
  end;

  /// Registro I012 - Lista

  TRegistroI012List = class(TList)
  private
    function GetItem(Index: Integer): TRegistroI012;
    procedure SetItem(Index: Integer; const Value: TRegistroI012);
  public
    destructor Destroy; override;
    function New: TRegistroI012;
    property Items[Index: Integer]: TRegistroI012 read GetItem write SetItem;
  end;

  /// Registro I015 - IDENTIFICAÇÃO  DAS  CONTAS  DA  ESCRITURAÇÃO  RESUMIDA  A
  ///                 QUE SE REFERE A ESCRITURAÇÃO AUXILIAR

  TRegistroI015 = class(TPersistent)
  private
    fCOD_CTA_RES: AnsiString;    /// Código da(s) conta(s) analítica(s) do Livro Diário com Escrituração Resumida (R) que recebe os lançamentos globais.   public
  public
    property COD_CTA_RES: AnsiString read fCOD_CTA_RES write fCOD_CTA_RES;
  end;

  /// Registro I015 - Lista

  TRegistroI015List = class(TList)
  private
    function GetItem(Index: Integer): TRegistroI015;
    procedure SetItem(Index: Integer; const Value: TRegistroI015);
  public
    destructor Destroy; override;
    function New: TRegistroI015;
    property Items[Index: Integer]: TRegistroI015 read GetItem write SetItem;
  end;

  /// Registro I020 - CAMPOS ADICIONAIS

  TRegistroI020 = class(TPersistent)
  private
    fREG_COD: AnsiString;     /// Código do registro que recepciona o campo adicional.
    fNUM_AD: AnsiString;      /// Número seqüencial do campo adicional.
    fCAMPO: AnsiString;       /// Nome do campo adicional.
    fDESCRICAO: AnsiString;   /// Descrição do campo adicional.
    fTIPO_DADO: AnsiString;   /// Indicação do tipo de dado (N: numérico; C: caractere).
  public
    property REG_COD: AnsiString read fREG_COD write fREG_COD;
    property NUM_AD: AnsiString read fNUM_AD write fNUM_AD;
    property CAMPO: AnsiString read fCAMPO write fCAMPO;
    property DESCRICAO: AnsiString read fDESCRICAO write fDESCRICAO;
    property TIPO_DADO: AnsiString read fTIPO_DADO write fTIPO_DADO;
  end;

  /// Registro I020 - Lista

  TRegistroI020List = class(TList)
  private
    function GetItem(Index: Integer): TRegistroI020;
    procedure SetItem(Index: Integer; const Value: TRegistroI020);
  public
    destructor Destroy; override;
    function New: TRegistroI020;
    property Items[Index: Integer]: TRegistroI020 read GetItem write SetItem;
  end;

  /// Registro I030 - TERMO DE ABERTURA DO LIVRO

  TRegistroI030 = class(TPersistent)
  private
    fNUM_ORD: AnsiString;     /// Número de ordem do instrumento de escrituração.
    fNAT_LIVR: AnsiString;    /// Natureza do livro; finalidade a que se destina o instrumento.
    fQTD_LIN: Currency;       /// Quantidade total de linhas do arquivo digital.
    fNOME: AnsiString;        /// Nome empresarial.
    fNIRE: AnsiString;        /// Número de Identificação do Registro de Empresas da Junta Comercial.
    fCNPJ: AnsiString;        /// Número de inscrição no CNPJ .
    fDT_ARQ: TDateTime;       /// Data do arquivamento dos atos constitutivos.
    fDT_ARQ_CONV: TDateTime;  /// Data de arquivamento do ato de conversão de sociedade simples em sociedade empresária.
    fDESC_MUN: AnsiString;    /// Município.
  public
    property NUM_ORD: AnsiString read fNUM_ORD write fNUM_ORD;
    property NAT_LIVR: AnsiString read fNAT_LIVR write fNAT_LIVR;
    property QTD_LIN: Currency read fQTD_LIN write fQTD_LIN;
    property NOME: AnsiString read fNOME write fNOME;
    property NIRE: AnsiString read fNIRE write fNIRE;
    property CNPJ: AnsiString read fCNPJ write fCNPJ;
    property DT_ARQ: TDateTime read fDT_ARQ write fDT_ARQ;
    property DT_ARQ_CONV: TDateTime read fDT_ARQ_CONV write fDT_ARQ_CONV;
    property DESC_MUN: AnsiString read fDESC_MUN write fDESC_MUN;
  end;

  /// Registro I050 - PLANO DE CONTAS

  TRegistroI050 = class(TPersistent)
  private
    fDT_ALT: TDateTime;       /// Data da inclusão/alteração.
    fCOD_NAT: AnsiString;     /// Código da natureza da conta/grupo de contas, conforme tabela publicada pelo Sped.
    fIND_CTA: AnsiString;     /// Indicador do tipo de conta: S - Sintética (grupo de contas);A - Analítica (conta).
    fNIVEL: AnsiString;       /// Nível da conta analítica/grupo de contas.
    fCOD_CTA: AnsiString;     /// Código da conta analítica/grupo de contas.
    fCOD_CTA_SUP: AnsiString; /// Código da conta sintética /grupo de contas de nível imediatamente superior.
    fCTA: AnsiString;         /// Nome da conta analítica/grupo de contas.
  public
    property DT_ALT: TDateTime read fDT_ALT write fDT_ALT;
    property COD_NAT: AnsiString read fCOD_NAT write fCOD_NAT;
    property IND_CTA: AnsiString read fIND_CTA write fIND_CTA;
    property NIVEL: AnsiString read fNIVEL write fNIVEL;
    property COD_CTA: AnsiString read fCOD_CTA write fCOD_CTA;
    property COD_CTA_SUP: AnsiString read fCOD_CTA_SUP write fCOD_CTA_SUP;
    property CTA: AnsiString read fCTA write fCTA;
  end;

  /// Registro I050 - Lista

  TRegistroI050List = class(TList)
  private
    function GetItem(Index: Integer): TRegistroI050;
    procedure SetItem(Index: Integer; const Value: TRegistroI050);
  public
    destructor Destroy; override;
    function New: TRegistroI050;
    property Items[Index: Integer]: TRegistroI050 read GetItem write SetItem;
  end;

  /// Registro I051 - PLANO DE CONTAS REFERENCIAL

  TRegistroI051 = class(TPersistent)
  private
    fCOD_ENT_REF: AnsiString;    /// Código da instituição responsável pela manutenção do plano de contas referencial.
    fCOD_CCUS: AnsiString;       /// Código do centro de custo.
    fCOD_CTA_REF: AnsiString;    /// Código da conta de acordo com o plano de contas referencial, conforme tabela publicada pelos órgãos indicados no campo 02- COD_ENT_REF.
  public
    property COD_ENT_REF: AnsiString read fCOD_ENT_REF write fCOD_ENT_REF;
    property COD_CCUS: AnsiString read fCOD_CCUS write fCOD_CCUS;
    property COD_CTA_REF: AnsiString read fCOD_CTA_REF write fCOD_CTA_REF;
  end;

  /// Registro I051 - Lista

  TRegistroI051List = class(TList)
  private
    function GetItem(Index: Integer): TRegistroI051;
    procedure SetItem(Index: Integer; const Value: TRegistroI051);
  public
    destructor Destroy; override;
    function New: TRegistroI051;
    property Items[Index: Integer]: TRegistroI051 read GetItem write SetItem;
  end;

  /// Registro I052 - INDICAÇÃO DOS CÓDIGOS DE AGLUTINAÇÃO

  TRegistroI052 = class(TPersistent)
  private
    fCOD_CCUS: AnsiString; /// Código do centro de custo.
    fCOD_AGL: AnsiString;  /// Código de aglutinação utilizado no Balanço Patrimonial e na Demonstração de Resultado do Exercício no Bloco J (somente para as contas analíticas).
  public
    property COD_CCUS: AnsiString read fCOD_CCUS write fCOD_CCUS;
    property COD_AGL: AnsiString read fCOD_AGL write fCOD_AGL;
  end;

  /// Registro I052 - Lista

  TRegistroI052List = class(TList)
  private
    function GetItem(Index: Integer): TRegistroI052;
    procedure SetItem(Index: Integer; const Value: TRegistroI052);
  public
    destructor Destroy; override;
    function New: TRegistroI052;
    property Items[Index: Integer]: TRegistroI052 read GetItem write SetItem;
  end;

  /// Registro I075 - TABELA DE HISTÓRICO PADRONIZADO

  TRegistroI075 = class(TPersistent)
  private
    fCOD_HIST: AnsiString;    /// Código do histórico padronizado.
    fDESCR_HIST: AnsiString;  /// Descrição do histórico padronizado.
  public
    property COD_HIST: AnsiString read fCOD_HIST write fCOD_HIST;
    property DESCR_HIST: AnsiString read fDESCR_HIST write fDESCR_HIST;
  end;

  /// Registro I075 - Lista

  TRegistroI075List = class(TList)
  private
    function GetItem(Index: Integer): TRegistroI075;
    procedure SetItem(Index: Integer; const Value: TRegistroI075);
  public
    destructor Destroy; override;
    function New: TRegistroI075;
    property Items[Index: Integer]: TRegistroI075 read GetItem write SetItem;
  end;

  /// Registro I100 - CENTRO DE CUSTOS

  TRegistroI100 = class(TPersistent)
  private
    fDT_ALT: TdateTime;       /// Data da inclusão/alteração.
    fCOD_CCUS: AnsiString;    /// Código do centro de custos.
    fCCUS: AnsiString;        /// Nome do centro de custos.
  public
    property DT_ALT: TdateTime read fDT_ALT write fDT_ALT;
    property COD_CCUS: AnsiString read fCOD_CCUS write fCOD_CCUS;
    property CCUS: AnsiString read fCCUS write fCCUS;
  end;

  /// Registro I100 - Lista

  TRegistroI100List = class(TList)
  private
    function GetItem(Index: Integer): TRegistroI100;
    procedure SetItem(Index: Integer; const Value: TRegistroI100);
  public
    destructor Destroy; override;
    function New: TRegistroI100;
    property Items[Index: Integer]: TRegistroI100 read GetItem write SetItem;
  end;

  /// Registro I150 - SALDOS PERIÓDICOS – IDENTIFICAÇÃO DO PERÍODO

  TRegistroI150 = class(TPersistent)
  private
    fDT_INI: TDateTime; /// Data de início do período.
    fDT_FIN: TDateTime; /// Data de fim do período.
  public
    property DT_INI: TDateTime read fDT_INI write fDT_INI;
    property DT_FIN: TDateTime read fDT_FIN write fDT_FIN;
  end;

  /// Registro I150 - Lista

  TRegistroI150List = class(TList)
  private
    function GetItem(Index: Integer): TRegistroI150;
    procedure SetItem(Index: Integer; const Value: TRegistroI150);
  public
    destructor Destroy; override;
    function New: TRegistroI150;
    property Items[Index: Integer]: TRegistroI150 read GetItem write SetItem;
  end;

  /// Registro I151 - ASSINATURA  DIGITAL  DOS  ARQUIVOS  QUE  CONTÊM  AS
  ///                 FICHAS DE LANÇAMENTO UTILIZADOS NO PERÍODO (IN RFB 926/09)

  TRegistroI151 = class(TPersistent)
  private
    fASSIM_DIG: AnsiString; /// Transcrição da assinatura digital utilizada no arquivo contendo o conjunto de fichas de lançamento   public
  public
    property ASSIM_DIG: AnsiString read fASSIM_DIG write fASSIM_DIG;
  end;

  /// Registro I151 - Lista

  TRegistroI151List = class(TList)
  private
    function GetItem(Index: Integer): TRegistroI151;
    procedure SetItem(Index: Integer; const Value: TRegistroI151);
  public
    destructor Destroy; override;
    function New: TRegistroI151;
    property Items[Index: Integer]: TRegistroI151 read GetItem write SetItem;
  end;

  /// Registro I155 - DETALHE DOS SALDOS PERIÓDICOS

  TRegistroI155 = class(TPersistent)
  private
    fCOD_CTA: AnsiString;     /// Código da conta analítica.
    fCOD_CCUS: AnsiString;    /// Código do centro de custos.
    fVL_SLD_INI: Currency;    /// Valor do saldo inicial do período.
    fIND_DC_INI: AnsiString;  /// Indicador da situação do saldo inicial:D - Devedor;C - Credor.
    fVL_DEB: Currency;        /// Valor total dos débitos no período.
    fVL_CRED: Currency;       /// Valor total dos créditos no período.
    fVL_SLD_FIN: Currency;    /// Valor do saldo final do período.
    fIND_DC_FIN: AnsiString;  /// Indicador da situação do saldo final: D - Devedor; C - Credor.
  public
    property COD_CTA: AnsiString read fCOD_CTA write fCOD_CTA;
    property COD_CCUS: AnsiString read fCOD_CCUS write fCOD_CCUS;
    property VL_SLD_INI: Currency read fVL_SLD_INI write fVL_SLD_INI;
    property IND_DC_INI: AnsiString read fIND_DC_INI write fIND_DC_INI;
    property VL_DEB: Currency read fVL_DEB write fVL_DEB;
    property VL_CRED: Currency read fVL_CRED write fVL_CRED;
    property VL_SLD_FIN: Currency read fVL_SLD_FIN write fVL_SLD_FIN;
    property IND_DC_FIN: AnsiString read fIND_DC_FIN write fIND_DC_FIN;
  end;

  /// Registro I155 - Lista

  TRegistroI155List = class(TList)
  private
    function GetItem(Index: Integer): TRegistroI155;
    procedure SetItem(Index: Integer; const Value: TRegistroI155);
  public
    destructor Destroy; override;
    function New: TRegistroI155;
    property Items[Index: Integer]: TRegistroI155 read GetItem write SetItem;
  end;

  /// Registro I990 - ENCERRAMENTO DO BLOCO I

  TRegistroI990 = class(TPersistent)
  private
    fQTD_LIN_I: Integer;    /// Quantidade total de linhas do Bloco I
  public
    property QTD_LIN_I: Integer read FQTD_LIN_I write FQTD_LIN_I;
  end;

implementation

{ TRegistroI012List }

destructor TRegistroI012List.Destroy;
var
intFor: integer;
begin
  for intFor := 0 to Count - 1 do Items[intFor].Free;
end;

function TRegistroI012List.GetItem(Index: Integer): TRegistroI012;
begin
  Result := TRegistroI012(Inherited Items[Index]);
end;

function TRegistroI012List.New: TRegistroI012;
begin
  Result := TRegistroI012.Create;
  Add(Result);
end;

procedure TRegistroI012List.SetItem(Index: Integer; const Value: TRegistroI012);
begin
  Put(Index, Value);
end;

{ TRegistroI015List }

destructor TRegistroI015List.Destroy;
var
intFor: integer;
begin
  for intFor := 0 to Count - 1 do Items[intFor].Free;
end;

function TRegistroI015List.GetItem(Index: Integer): TRegistroI015;
begin
  Result := TRegistroI015(Inherited Items[Index]);
end;

function TRegistroI015List.New: TRegistroI015;
begin
  Result := TRegistroI015.Create;
  Add(Result);
end;

procedure TRegistroI015List.SetItem(Index: Integer; const Value: TRegistroI015);
begin
  Put(Index, Value);
end;

{ TRegistroI020List }

destructor TRegistroI020List.Destroy;
var
intFor: integer;
begin
  for intFor := 0 to Count - 1 do Items[intFor].Free;
end;

function TRegistroI020List.GetItem(Index: Integer): TRegistroI020;
begin
  Result := TRegistroI020(Inherited Items[Index]);
end;

function TRegistroI020List.New: TRegistroI020;
begin
  Result := TRegistroI020.Create;
  Add(Result);
end;

procedure TRegistroI020List.SetItem(Index: Integer; const Value: TRegistroI020);
begin
  Put(Index, Value);
end;

{ TRegistroI050List }

destructor TRegistroI050List.Destroy;
var
intFor: integer;
begin
  for intFor := 0 to Count - 1 do Items[intFor].Free;
end;

function TRegistroI050List.GetItem(Index: Integer): TRegistroI050;
begin
  Result := TRegistroI050(Inherited Items[Index]);
end;

function TRegistroI050List.New: TRegistroI050;
begin
  Result := TRegistroI050.Create;
  Add(Result);
end;

procedure TRegistroI050List.SetItem(Index: Integer; const Value: TRegistroI050);
begin
  Put(Index, Value);
end;

{ TRegistroI051List }

destructor TRegistroI051List.Destroy;
var
intFor: integer;
begin
  for intFor := 0 to Count - 1 do Items[intFor].Free;
end;

function TRegistroI051List.GetItem(Index: Integer): TRegistroI051;
begin
  Result := TRegistroI051(Inherited Items[Index]);
end;

function TRegistroI051List.New: TRegistroI051;
begin
  Result := TRegistroI051.Create;
  Add(Result);
end;

procedure TRegistroI051List.SetItem(Index: Integer; const Value: TRegistroI051);
begin
  Put(Index, Value);
end;

{ TRegistroI052List }

destructor TRegistroI052List.Destroy;
var
intFor: integer;
begin
  for intFor := 0 to Count - 1 do Items[intFor].Free;
end;

function TRegistroI052List.GetItem(Index: Integer): TRegistroI052;
begin
  Result := TRegistroI052(Inherited Items[Index]);
end;

function TRegistroI052List.New: TRegistroI052;
begin
  Result := TRegistroI052.Create;
  Add(Result);
end;

procedure TRegistroI052List.SetItem(Index: Integer; const Value: TRegistroI052);
begin
  Put(Index, Value);
end;

{ TRegistroI075List }

destructor TRegistroI075List.Destroy;
var
intFor: integer;
begin
  for intFor := 0 to Count - 1 do Items[intFor].Free;
end;

function TRegistroI075List.GetItem(Index: Integer): TRegistroI075;
begin
  Result := TRegistroI075(Inherited Items[Index]);
end;

function TRegistroI075List.New: TRegistroI075;
begin
  Result := TRegistroI075.Create;
  Add(Result);
end;

procedure TRegistroI075List.SetItem(Index: Integer; const Value: TRegistroI075);
begin
  Put(Index, Value);
end;

{ TRegistroI100List }

destructor TRegistroI100List.Destroy;
var
intFor: integer;
begin
  for intFor := 0 to Count - 1 do Items[intFor].Free;
end;

function TRegistroI100List.GetItem(Index: Integer): TRegistroI100;
begin
  Result := TRegistroI100(Inherited Items[Index]);
end;

function TRegistroI100List.New: TRegistroI100;
begin
  Result := TRegistroI100.Create;
  Add(Result);
end;

procedure TRegistroI100List.SetItem(Index: Integer; const Value: TRegistroI100);
begin
  Put(Index, Value);
end;

{ TRegistroI150List }

destructor TRegistroI150List.Destroy;
var
intFor: integer;
begin
  for intFor := 0 to Count - 1 do Items[intFor].Free;
end;

function TRegistroI150List.GetItem(Index: Integer): TRegistroI150;
begin
  Result := TRegistroI150(Inherited Items[Index]);
end;

function TRegistroI150List.New: TRegistroI150;
begin
  Result := TRegistroI150.Create;
  Add(Result);
end;

procedure TRegistroI150List.SetItem(Index: Integer; const Value: TRegistroI150);
begin
  Put(Index, Value);
end;

{ TRegistroI151List }

destructor TRegistroI151List.Destroy;
var
intFor: integer;
begin
  for intFor := 0 to Count - 1 do Items[intFor].Free;
end;

function TRegistroI151List.GetItem(Index: Integer): TRegistroI151;
begin
  Result := TRegistroI151(Inherited Items[Index]);
end;

function TRegistroI151List.New: TRegistroI151;
begin
  Result := TRegistroI151.Create;
  Add(Result);
end;

procedure TRegistroI151List.SetItem(Index: Integer; const Value: TRegistroI151);
begin
  Put(Index, Value);
end;

{ TRegistroI155List }

destructor TRegistroI155List.Destroy;
var
intFor: integer;
begin
  for intFor := 0 to Count - 1 do Items[intFor].Free;
end;

function TRegistroI155List.GetItem(Index: Integer): TRegistroI155;
begin
  Result := TRegistroI155(Inherited Items[Index]);
end;

function TRegistroI155List.New: TRegistroI155;
begin
  Result := TRegistroI155.Create;
  Add(Result);
end;

procedure TRegistroI155List.SetItem(Index: Integer; const Value: TRegistroI155);
begin
  Put(Index, Value);
end;

end.
