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

unit ACBrEFDBloco_G;

interface

uses
  SysUtils, Classes, DateUtils, ACBrEFDBlocos;

type
  /// Registro G001 - ABERTURA DO BLOCO G

  TRegistroG001 = class(TOpenBlocos)
  private
  public
  end;

  TRegistroG125List = class;
  TRegistroG130List = class;
  TRegistroG140List = class;

  /// Registro G110 - ICMS - ATIVO PERMANENTE - CIAP

  TRegistroG110 = class(TPersistent)
  private
    fDT_INI: TDateTime;         /// Data Inicial da Apuracao
    fDT_FIN: TDateTime;         /// Data Final da Apuracao
    fMODO_CIAP: AnsiString;     /// Modelo de CIAP adotado C ou D
    fSALDO_IN_ICMS: Currency;   /// Saldo inicial de ICMS do CIAP Modelo C
    fSALDO_FN_ICMS: Currency;   /// Saldo Final ICMS do CIAP Modelo C
    fSOM_PARC: Currency;        /// Somatorio das Parcelas ICMS Passivel de Apropriacao Modelo D
    fVL_TRIB_EXP: Currency;     /// Valor do somatorio das saidas tributadas e saidas para exportacao
    fVL_TOTAL: Currency;        /// Valor Total das Saidas
    fPER_SAI_TRIB: Double;      /// Participacao percentual do valor do somatorio das saidas tributadas e para exportacao
    fICMS_APROP: Currency;      /// Parcela de ICMS a ser apropriada no Registro de Apuracao do ICMS

    FRegistroG125: TRegistroG125List;  /// BLOCO G - Lista de RegistroG110 (FILHO fo FILHO)
  public
    constructor Create; virtual; /// Create
    destructor Destroy; override; /// Destroy

    property DT_INI: TDateTime read fDT_INI write fDT_INI;
    property DT_FIN: TDateTime read fDT_FIN write fDT_FIN;
    property MODO_CIAP: AnsiString read fMODO_CIAP write fMODO_CIAP;
    property SALDO_IN_ICMS: Currency read fSALDO_IN_ICMS write fSALDO_IN_ICMS;
    property SALDO_FN_ICMS: Currency read fSALDO_FN_ICMS write fSALDO_FN_ICMS;
    property SOM_PARC: Currency read fSOM_PARC write fSOM_PARC;
    property VL_TRIB_EXP: Currency read fVL_TRIB_EXP write fVL_TRIB_EXP;
    property VL_TOTAL: Currency read fVL_TOTAL write fVL_TOTAL;
    property PER_SAI_TRIB: Double read fPER_SAI_TRIB write fPER_SAI_TRIB;
    property ICMS_APROP: Currency read fICMS_APROP write fICMS_APROP;

    property RegistroG125: TRegistroG125List read FRegistroG125 write FRegistroG125;
  end;

  /// Registro G110 - Lista

  TRegistroG110List = class(TList)
  private
    function GetItem(Index: Integer): TRegistroG110; /// GetItem
    procedure SetItem(Index: Integer; const Value: TRegistroG110); /// SetItem
  public
    destructor Destroy; override;
    function New: TRegistroG110;
    property Items[Index: Integer]: TRegistroG110 read GetItem write SetItem;
  end;

  /// Registro G125 - MOVIMENTACAO DE BEM OU COMPONENTE DO ATIVO IMOBILIZADO

  TRegistroG125 = class(TPersistent)
  private
    fCOD_IND_BEM: AnsiString;     /// Codigo individualizado do bem ou componente
    fDT_MOV: TDateTime;           /// Data movimentacao ou saldo inicial
    fTIPO_MOV: AnsiString;        /// Tipo de movimentacao do bem ou componente
    fVL_IMOB_ICMS_OP: Currency;   /// Valor ICMS Operacao Propria na entrada do bem ou componente
    fVL_IMOB_ICMS_ST: Currency;   /// Valor ICMS Operacao Subst.Trib. na entrada do bem ou componente
    fVL_IMOB_ICMS_FRT: Currency;  /// Valor ICMS Frete CTC na entrada do bem ou componente
    fVL_IMOB_ICMS_DIF: Currency;  /// Valor ICMS Diferencial de Aliquota cfe. Doc. arrecadacao na entrada do bem ou componente
    fNUM_PARC: Currency;          /// Numero da Parcela do ICMS
    fVL_PARC_PASS: Currency;      /// Valor parcela icms passivel de apropriacao
    fVL_PARC_APROP: Currency;     /// Valor da parcela apropriada do ICMS

    FRegistroG130: TRegistroG130List;  /// BLOCO G - Lista de RegistroG130 (FILHO fo FILHO)
  public
    constructor Create; virtual; /// Create
    destructor Destroy; override; /// Destroy

    property COD_IND_BEM: AnsiString read fCOD_IND_BEM write fCOD_IND_BEM;
    property DT_MOV: TDateTime  read fDT_MOV write fDT_MOV;
    property TIPO_MOV: AnsiString read fTIPO_MOV write fTIPO_MOV;
    property VL_IMOB_ICMS_OP: Currency   read fVL_IMOB_ICMS_OP write fVL_IMOB_ICMS_OP;
    property VL_IMOB_ICMS_ST: Currency   read fVL_IMOB_ICMS_ST write fVL_IMOB_ICMS_ST;
    property VL_IMOB_ICMS_FRT: Currency   read fVL_IMOB_ICMS_FRT write fVL_IMOB_ICMS_FRT;
    property VL_IMOB_ICMS_DIF: Currency   read fVL_IMOB_ICMS_DIF write fVL_IMOB_ICMS_DIF;
    property NUM_PARC: Currency   read fNUM_PARC write fNUM_PARC;
    property VL_PARC_PASS: Currency   read fVL_PARC_PASS write fVL_PARC_PASS;
    property VL_PARC_APROP: Currency   read fVL_PARC_APROP write fVL_PARC_APROP;

    property RegistroG130: TRegistroG130List read FRegistroG130 write FRegistroG130;
  end;

  /// Registro G125 - Lista

  TRegistroG125List = class(TList)
  private
    function GetItem(Index: Integer): TRegistroG125; /// GetItem
    procedure SetItem(Index: Integer; const Value: TRegistroG125); /// SetItem
  public
    destructor Destroy; override;
    function New: TRegistroG125;
    property Items[Index: Integer]: TRegistroG125 read GetItem write SetItem;
  end;

  /// Registro G130 - IDENTIFICACAO DO DOCUMENTO FISCAL

  TRegistroG130 = class(TPersistent)
  private
    fIND_EMIT: AnsiString;     /// Código do ajuste da apuração e dedução, conforme a Tabela indicada no item 5.1.1.
    fCOD_PART: AnsiString;  /// Descrição complementar do ajuste da apuração.
    fCOD_MOD: AnsiString;    /// Valor do ajuste da apuração
    fSERIE: AnsiString;
    fNUM_DOC: AnsiString;
    fCHV_NFE_CTE: AnsiString;
    fDT_DOC: TDateTime;

    FRegistroG140: TRegistroG140List;  /// BLOCO G - Lista de RegistroG130 (FILHO fo FILHO)
  public
    constructor Create; virtual; /// Create
    destructor Destroy; override; /// Destroy

    property IND_EMIT: AnsiString read fIND_EMIT write fIND_EMIT;
    property COD_PART: AnsiString read fCOD_PART write fCOD_PART;
    property COD_MOD: AnsiString read fCOD_MOD write fCOD_MOD;
    property SERIE: AnsiString read fSERIE write fSERIE;
    property NUM_DOC: AnsiString read fNUM_DOC write fNUM_DOC;
    property CHV_NFE_CTE: AnsiString read fCHV_NFE_CTE write fCHV_NFE_CTE;
    property DT_DOC: TDateTime read fDT_DOC write fDT_DOC;

    property RegistroG140: TRegistroG140List read FRegistroG140 write FRegistroG140;
  end;

  /// Registro G130 - Lista
  TRegistroG130List = class(TList)
  private
    function GetItem(Index: Integer): TRegistroG130; /// GetItem
    procedure SetItem(Index: Integer; const Value: TRegistroG130); /// SetItem
  public
    destructor Destroy; override;
    function New: TRegistroG130;
    property Items[Index: Integer]: TRegistroG130 read GetItem write SetItem;
  end;

  /// Registro G140 - IDENTIFICACAO DO ITEM DO DOCUMENTO FISCAL

  TRegistroG140 = class(TPersistent)
  private
    fNUM_ITEM: AnsiString;  /// Numero Sequencial do Item no documento fiscal
    fCOD_ITEM: AnsiString;  /// Codigo Correspondente do bem no documento fiscal
  public
    property NUM_ITEM: AnsiString read fNUM_ITEM write fNUM_ITEM;
    property COD_ITEM: AnsiString read fCOD_ITEM write fCOD_ITEM;
  end;

  /// Registro G140 - Lista

  TRegistroG140List = class(TList)
  private
    function GetItem(Index: Integer): TRegistroG140; /// GetItem
    procedure SetItem(Index: Integer; const Value: TRegistroG140); /// SetItem
  public
    destructor Destroy; override;
    function New: TRegistroG140;
    property Items[Index: Integer]: TRegistroG140 read GetItem write SetItem;
  end;


  /// Registro G990 - ENCERRAMENTO DO BLOCO G

  TRegistroG990 = class(TPersistent)
  private
    fQTD_LIN_G: Integer;    /// Quantidade total de linhas do Bloco H
  public
    property QTD_LIN_G: Integer read fQTD_LIN_G write fQTD_LIN_G;
  end;

implementation


{ TRegistroG110 }

constructor TRegistroG110.Create;
begin
  FRegistroG125 := TRegistroG125List.Create;  /// BLOCO G - Lista de RegistroG125 (FILHO fo FILHO)
end;

destructor TRegistroG110.Destroy;
begin
  FRegistroG125.Free;
  inherited;
end;


{ TRegistroG110List }

destructor TRegistroG110List.Destroy;
var
intFor: integer;
begin
  for intFor := 0 to Count - 1 do Items[intFor].Free;
  inherited;
end;

function TRegistroG110List.GetItem(Index: Integer): TRegistroG110;
begin
  Result := TRegistroG110(Inherited Items[Index]);
end;

function TRegistroG110List.New: TRegistroG110;
begin
  Result := TRegistroG110.Create;
  Add(Result);
end;

procedure TRegistroG110List.SetItem(Index: Integer; const Value: TRegistroG110);
begin
  Put(Index, Value);
end;

{ TRegistroG125 }

constructor TRegistroG125.Create;
begin
  FRegistroG130 := TRegistroG130List.Create;  /// BLOCO G - Lista de RegistroG130 (FILHO fo FILHO)
end;

destructor TRegistroG125.Destroy;
begin
  FRegistroG130.Free;
  inherited;
end;

{ TRegistroG125List }

destructor TRegistroG125List.Destroy;
var
intFor: integer;
begin
  for intFor := 0 to Count - 1 do Items[intFor].Free;
  inherited;
end;

function TRegistroG125List.GetItem(Index: Integer): TRegistroG125;
begin
  Result := TRegistroG125(Inherited Items[Index]);
end;

function TRegistroG125List.New: TRegistroG125;
begin
  Result := TRegistroG125.Create;
  Add(Result);
end;

procedure TRegistroG125List.SetItem(Index: Integer; const Value: TRegistroG125);
begin
  Put(Index, Value);
end;

{ TRegistroG130 }

constructor TRegistroG130.Create;
begin
  FRegistroG140 := TRegistroG140List.Create;  /// BLOCO G - Lista de RegistroG130 (FILHO fo FILHO)
end;

destructor TRegistroG130.Destroy;
begin
  FRegistroG140.Free;
  inherited;
end;

{ TRegistroG130List }

destructor TRegistroG130List.Destroy;
var
intFor: integer;
begin
  for intFor := 0 to Count - 1 do Items[intFor].Free;
  inherited;
end;

function TRegistroG130List.GetItem(Index: Integer): TRegistroG130;
begin
  Result := TRegistroG130(Inherited Items[Index]);
end;

function TRegistroG130List.New: TRegistroG130;
begin
  Result := TRegistroG130.Create;
  Add(Result);
end;

procedure TRegistroG130List.SetItem(Index: Integer; const Value: TRegistroG130);
begin
  Put(Index, Value);
end;

{ TRegistroG140List }

destructor TRegistroG140List.Destroy;
var
intFor: integer;
begin
  for intFor := 0 to Count - 1 do Items[intFor].Free;
  inherited;
end;

function TRegistroG140List.GetItem(Index: Integer): TRegistroG140;
begin
  Result := TRegistroG140(Inherited Items[Index]);
end;

function TRegistroG140List.New: TRegistroG140;
begin
  Result := TRegistroG140.Create;
  Add(Result);
end;

procedure TRegistroG140List.SetItem(Index: Integer; const Value: TRegistroG140);
begin
  Put(Index, Value);
end;

end.
