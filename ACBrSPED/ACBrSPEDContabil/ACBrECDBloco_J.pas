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

unit ACBrECDBloco_J;

interface

uses
  SysUtils, Classes, DateUtils, ACBrECDBlocos;

type
  /// Registro J001 - ABERTURA DO BLOCO J

  TRegistroJ001 = class(TOpenBlocos)
  private
  public
  end;

  /// Rregistro J005 – DEMONSTRAÇÕES CONTÁBEIS

  TRegistroJ005 = class(TPersistent)
  private
    fDT_INI: TDateTime;    /// Data inicial das demonstrações contábeis.
    fDT_FIN: TDateTime;    /// Data final das demonstrações contábeis.
    fID_DEM: Integer;      /// Identificação das demonstrações: 1 - demonstrações contábeis do empresário ou sociedade empresária a que se refere a escrituração; 2 - demonstrações consolidadas ou de outros empresários ou sociedades empresárias.
    fCAB_DEM: AnsiString;  /// Cabeçalho das demonstrações.
  public
    property DT_INI: TDateTime read fDT_INI write fDT_INI;
    property DT_FIN: TDateTime read fDT_FIN write fDT_FIN;
    property ID_DEM: Integer read fID_DEM write fID_DEM;
    property CAB_DEM: AnsiString read fCAB_DEM write fCAB_DEM;
  end;

  /// Registro J005 - Lista

  TRegistroJ005List = class(TList)
  private
    function GetItem(Index: Integer): TRegistroJ005;
    procedure SetItem(Index: Integer; const Value: TRegistroJ005);
  public
    destructor Destroy; override;
    function New: TRegistroJ005;
    property Items[Index: Integer]: TRegistroJ005 read GetItem write SetItem;
  end;

  /// Rregistro J100 – BALANÇO PATRIMONIAL

  TRegistroJ100 = class(TPersistent)
  private
    fCOD_AGL: AnsiString;        /// Código de aglutinação das contas, atribuído pelo empresário ou sociedade empresária.
    fNIVEL_AGL: AnsiString;      /// Nível do Código de aglutinação (mesmo conceito do plano de contas - Registro I050).
    fIND_GRP_BAL: AnsiString;    /// Indicador de grupo do balanço: 1 - Ativo; 2 - Passivo e Patrimônio Líquido;
    fDESCR_COD_AGL: AnsiString;  /// Descrição do Código de aglutinação.
    fVL_CTA: Currency;           /// Valor total do Código de aglutinação no Balanço Patrimonial no exercício informado, ou de período definido em norma específica.
    fIND_DC_BAL: AnsiString;     /// Indicador da situação do saldo informado no campo anterior: D - Devedor; C - Credor.
  public
    property COD_AGL: AnsiString read fCOD_AGL write fCOD_AGL;
    property NIVEL_AGL: AnsiString read fNIVEL_AGL write fNIVEL_AGL;
    property IND_GRP_BAL: AnsiString read fIND_GRP_BAL write fIND_GRP_BAL;
    property DESCR_COD_AGL: AnsiString read fDESCR_COD_AGL write fDESCR_COD_AGL;
    property VL_CTA: Currency read fVL_CTA write fVL_CTA;
    property IND_DC_BAL: AnsiString read fIND_DC_BAL write fIND_DC_BAL;
  end;

  /// Registro J100 - Lista

  TRegistroJ100List = class(TList)
  private
    function GetItem(Index: Integer): TRegistroJ100;
    procedure SetItem(Index: Integer; const Value: TRegistroJ100);
  public
    destructor Destroy; override;
    function New: TRegistroJ100;
    function LocalizaRegistro(pCOD_AGL: AnsiString): boolean;
    property Items[Index: Integer]: TRegistroJ100 read GetItem write SetItem;
  end;

  /// Rregistro J150 – DEMONSTRAÇÃO DO RESULTADO DO EXERCÍCIO

  TRegistroJ150 = class(TPersistent)
  private
    fCOD_AGL: AnsiString;        /// Código de aglutinação das contas, atribuído pelo empresário ou sociedade empresária.
    fNIVEL_AGL: AnsiString;      /// Nível do Código de aglutinação (mesmo conceito do plano de contas - Registro I050).
    fDESCR_COD_AGL: AnsiString;  /// Descrição do Código de aglutinação.
    fVL_CTA: Currency;           /// Valor total do Código de aglutinação na Demonstração do Resultado do Exercício no período informado.
    fIND_VL: AnsiString;         /// Indicador da situação do valor informado no campo anterior: D - Despesa ou valor que represente parcela redutora do lucro;R - Receita ou valor que represente incremento do lucro;P - Subtotal ou total positivo;N - Subtotal ou total negativo.
  public
    property COD_AGL: AnsiString read fCOD_AGL write fCOD_AGL;
    property NIVEL_AGL: AnsiString read fNIVEL_AGL write fNIVEL_AGL;
    property DESCR_COD_AGL: AnsiString read fDESCR_COD_AGL write fDESCR_COD_AGL;
    property VL_CTA: Currency read fVL_CTA write fVL_CTA;
    property IND_VL: AnsiString read fIND_VL write fIND_VL;
  end;

  /// Registro J150 - Lista

  TRegistroJ150List = class(TList)
  private
    function GetItem(Index: Integer): TRegistroJ150;
    procedure SetItem(Index: Integer; const Value: TRegistroJ150);
  public
    destructor Destroy; override;
    function New: TRegistroJ150;
    function LocalizaRegistro(pCOD_AGL: AnsiString): boolean;
    property Items[Index: Integer]: TRegistroJ150 read GetItem write SetItem;
  end;

  /// Rregistro J800 – OUTRAS INFORMAÇÕES

  TRegistroJ800 = class(TPersistent)
  private
    fARQ_RTF: AnsiString;  /// Seqüência de bytes que representem um único arquivo no formato RTF (Rich Text Format).
  public
    property ARQ_RTF: AnsiString read fARQ_RTF write fARQ_RTF;
  end;

  /// Registro J800 - Lista

  TRegistroJ800List = class(TList)
  private
    function GetItem(Index: Integer): TRegistroJ800;
    procedure SetItem(Index: Integer; const Value: TRegistroJ800);
  public
    destructor Destroy; override;
    function New: TRegistroJ800;
    property Items[Index: Integer]: TRegistroJ800 read GetItem write SetItem;
  end;

  /// Rregistro J900 – TERMO DE ENCERRAMENTO

  TRegistroJ900 = class(TPersistent)
  private
    fNUM_ORD: AnsiString;        /// Número de ordem do instrumento de escrituração.
    fNAT_LIVRO: AnsiString;      /// Natureza do livro; finalidade a que se destinou o instrumento.
    fNOME: AnsiString;           /// Nome empresarial.
    fQTD_LIN: Currency;          /// Quantidade total de linhas do arquivo digital.
    fDT_INI_ESCR: TDateTime;     /// Data de inicio da escrituração.
    fDT_FIN_ESCR: TDateTime;     /// Data de término da escrituração.
  public
    property NUM_ORD: AnsiString read fNUM_ORD write fNUM_ORD;
    property NAT_LIVRO: AnsiString read fNAT_LIVRO write fNAT_LIVRO;
    property NOME: AnsiString read fNOME write fNOME;
    property QTD_LIN: Currency read fQTD_LIN write fQTD_LIN;
    property DT_INI_ESCR: TDateTime read fDT_INI_ESCR write fDT_INI_ESCR;
    property DT_FIN_ESCR: TDateTime read fDT_FIN_ESCR write fDT_FIN_ESCR;
  end;

  /// Rregistro J930 – IDENTIFICAÇÃO DOS SIGNATÁRIOS DA ESCRITURAÇÃO

  TRegistroJ930 = class(TPersistent)
  private
    fIDENT_NOM: AnsiString;      /// Nome do signatário.
    fIDENT_CPF: AnsiString;      /// CPF.
    fIDENT_QUALIF: AnsiString;   /// Qualificação do assinante, conforme tabela do Departamento Nacional de Registro do Comércio - DNRC.
    fCOD_ASSIN: AnsiString;      /// Código de qualificação do assinante, conforme tabela do Departamento Nacional de Registro do Comércio - DNRC.
    fIND_CRC: AnsiString;        /// Número de inscrição do contabilista no Conselho Regional de Contabilidade.
  public
    property IDENT_NOM: AnsiString read fIDENT_NOM write fIDENT_NOM;
    property IDENT_CPF: AnsiString read fIDENT_CPF write fIDENT_CPF;
    property IDENT_QUALIF: AnsiString read fIDENT_QUALIF write fIDENT_QUALIF;
    property COD_ASSIN: AnsiString read fCOD_ASSIN write fCOD_ASSIN;
    property IND_CRC: AnsiString read fIND_CRC write fIND_CRC;
  end;

  /// Registro J930 - Lista

  TRegistroJ930List = class(TList)
  private
    function GetItem(Index: Integer): TRegistroJ930;
    procedure SetItem(Index: Integer; const Value: TRegistroJ930);
  public
    destructor Destroy; override;
    function New: TRegistroJ930;
    property Items[Index: Integer]: TRegistroJ930 read GetItem write SetItem;
  end;

  /// Registro J990 - ENCERRAMENTO DO BLOCO J

  TRegistroJ990 = class(TPersistent)
  private
    fQTD_LIN_J: Integer;    /// Quantidade total de linhas do Bloco J
  public
    property QTD_LIN_J: Integer read FQTD_LIN_J write FQTD_LIN_J;
  end;

implementation

{ TRegistroJ005List }

destructor TRegistroJ005List.Destroy;
var
intFor: integer;
begin
  for intFor := 0 to Count - 1 do Items[intFor].Free;
end;

function TRegistroJ005List.GetItem(Index: Integer): TRegistroJ005;
begin
  Result := TRegistroJ005(Inherited Items[Index]);
end;

function TRegistroJ005List.New: TRegistroJ005;
begin
  Result := TRegistroJ005.Create;
  Add(Result);
end;

procedure TRegistroJ005List.SetItem(Index: Integer; const Value: TRegistroJ005);
begin
  Put(Index, Value);
end;

{ TRegistroJ100List }

destructor TRegistroJ100List.Destroy;
var
intFor: integer;
begin
  for intFor := 0 to Count - 1 do Items[intFor].Free;
end;

function TRegistroJ100List.GetItem(Index: Integer): TRegistroJ100;
begin
  Result := TRegistroJ100(Inherited Items[Index]);
end;

function TRegistroJ100List.LocalizaRegistro(pCOD_AGL: AnsiString): boolean;
var
intFor: integer;
begin
   Result := false;
   for intFor := 0 to Self.Count - 1 do
   begin
      if Self.Items[intFor].COD_AGL = pCOD_AGL then
      begin
         Result := true;
         Break;
      end;
   end;
end;

function TRegistroJ100List.New: TRegistroJ100;
begin
  Result := TRegistroJ100.Create;
  Add(Result);
end;

procedure TRegistroJ100List.SetItem(Index: Integer; const Value: TRegistroJ100);
begin
  Put(Index, Value);
end;

{ TRegistroJ150List }

destructor TRegistroJ150List.Destroy;
var
intFor: integer;
begin
  for intFor := 0 to Count - 1 do Items[intFor].Free;
end;

function TRegistroJ150List.GetItem(Index: Integer): TRegistroJ150;
begin
  Result := TRegistroJ150(Inherited Items[Index]);
end;

function TRegistroJ150List.LocalizaRegistro(pCOD_AGL: AnsiString): boolean;
var
intFor: integer;
begin
   Result := false;
   for intFor := 0 to Self.Count - 1 do
   begin
      if Self.Items[intFor].COD_AGL = pCOD_AGL then
      begin
         Result := true;
         Break;
      end;
   end;
end;

function TRegistroJ150List.New: TRegistroJ150;
begin
  Result := TRegistroJ150.Create;
  Add(Result);
end;

procedure TRegistroJ150List.SetItem(Index: Integer; const Value: TRegistroJ150);
begin
  Put(Index, Value);
end;

{ TRegistroJ800List }

destructor TRegistroJ800List.Destroy;
var
intFor: integer;
begin
  for intFor := 0 to Count - 1 do Items[intFor].Free;
end;

function TRegistroJ800List.GetItem(Index: Integer): TRegistroJ800;
begin
  Result := TRegistroJ800(Inherited Items[Index]);
end;

function TRegistroJ800List.New: TRegistroJ800;
begin
  Result := TRegistroJ800.Create;
  Add(Result);
end;

procedure TRegistroJ800List.SetItem(Index: Integer; const Value: TRegistroJ800);
begin
  Put(Index, Value);
end;

{ TRegistroJ930List }

destructor TRegistroJ930List.Destroy;
var
intFor: integer;
begin
  for intFor := 0 to Count - 1 do Items[intFor].Free;
end;

function TRegistroJ930List.GetItem(Index: Integer): TRegistroJ930;
begin
  Result := TRegistroJ930(Inherited Items[Index]);
end;

function TRegistroJ930List.New: TRegistroJ930;
begin
  Result := TRegistroJ930.Create;
  Add(Result);
end;

procedure TRegistroJ930List.SetItem(Index: Integer; const Value: TRegistroJ930);
begin
  Put(Index, Value);
end;

end.
