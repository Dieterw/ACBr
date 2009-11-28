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

unit ACBrBloco_0;

interface

uses
  SysUtils, Classes, DateUtils, ACBrBlocos;

type
  /// Registro 0000 - ABERTURA DO ARQUIVO DIGITAL E IDENTIFICAÇÃO DA ENTIDADE

  TRegistro0000 = class(TPersistent)
  private
    fCOD_VER: integer;         /// Código da versão do leiaute: 100; 101
    fCOD_FIN: integer;         /// Código da finalidade do arquivo: 0 - Remessa do arquivo original / 1 - Remessa do arquivo substituto.
    fDT_INI: TDateTime;        /// Data inicial das informações contidas no arquivo
    fDT_FIN: TDateTime;        /// Data final das informações contidas no arquivo
    fNOME: AnsiString;         /// Nome empresarial do contribuinte:
    fCNPJ: AnsiString;         /// Número de inscrição do contribuinte:
    fCPF: AnsiString;          /// Número de inscrição do contribuinte:
    fUF: AnsiString;           /// Sigla da unidade da federação:
    fIE: AnsiString;           /// Inscrição Estadual do contribuinte:
    fCOD_MUN: integer;         /// Código do município do domicílio fiscal:
    fIM: AnsiString;           /// Inscrição Municipal do contribuinte:
    fSUFRAMA: AnsiString;      /// Número de inscrição do contribuinte:
    fIND_PERFIL: AnsiString;   /// Perfil de apresentação do arquivo fiscal: A - Perfil A / B - Perfil B / C - Perfil C
    fIND_ATIV: integer;        /// Indicador de tipo de atividade: 0 - Industrial ou equiparado a industrial; 1 - Outros.
  public
    property COD_VER: integer read FCOD_VER write FCOD_VER;
    property COD_FIN: integer read FCOD_FIN write FCOD_FIN;
    property DT_INI: TDateTime read FDT_INI write FDT_INI;
    property DT_FIN: TDateTime read FDT_FIN write FDT_FIN;
    property NOME: AnsiString read FNOME write FNOME;
    property CNPJ: AnsiString read FCNPJ write FCNPJ;
    property CPF: AnsiString read FCPF write FCPF;
    property UF: AnsiString read FUF write FUF;
    property IE: AnsiString read FIE write FIE;
    property COD_MUN: integer read FCOD_MUN write FCOD_MUN;
    property IM: AnsiString read FIM write FIM;
    property SUFRAMA: AnsiString read FSUFRAMA write FSUFRAMA;
    property IND_PERFIL: AnsiString read FIND_PERFIL write FIND_PERFIL;
    property IND_ATIV: integer read FIND_ATIV write FIND_ATIV;
  end;

  /// Registro 0001 - ABERTURA DO BLOCO 0

  TRegistro0001 = class(TOpenBlocos)
  private
  public
  end;

  /// Registro 0005 - DADOS COMPLEMENTARES DA ENTIDADE

  TRegistro0005 = class(TPersistent)
  private
    fFANTASIA: AnsiString;     /// Nome de fantasia associado:
    fCEP: AnsiString;          /// Código de Endereçamento Postal:
    fENDERECO: AnsiString;     /// Logradouro e endereço do imóvel:
    fNUM: AnsiString;          /// Número do imóvel:
    fCOMPL: AnsiString;        /// Dados complementares do endereço:
    fBAIRRO: AnsiString;       /// Bairro em que o imóvel está situado:
    fFONE: AnsiString;         /// Número do telefone:
    fFAX: AnsiString;          /// Número do fax:
    fEMAIL: AnsiString;        /// Endereço do correio eletrônico:
  public
    property FANTASIA: AnsiString read fFANTASIA write fFANTASIA;
    property CEP: AnsiString read FCEP write FCEP;
    property ENDERECO: AnsiString read FENDERECO write FENDERECO;
    property NUM: AnsiString read FNUM write FNUM;
    property COMPL: AnsiString read FCOMPL write FCOMPL;
    property BAIRRO: AnsiString read FBAIRRO write FBAIRRO;
    property FONE: AnsiString read FFONE write FFONE;
    property FAX: AnsiString read FFAX write FFAX;
    property EMAIL: AnsiString read FEMAIL write FEMAIL;
  end;

  /// Registro 0015 - DADOS DO CONTRIBUINTE SUBSTITUTO

  TRegistro0015 = class(TPersistent)
  private
    fUF_ST: AnsiString;   /// Sigla da unidade da federação:
    fIE_ST: AnsiString;   /// Inscrição Estadual:
  public
    property UF_ST: AnsiString read FUF_ST write FUF_ST;
    property IE_ST: AnsiString read FIE_ST write FIE_ST;
  end;

  /// Registro 0015 - Lista

  TRegistro0015List = class(TList)
  private
    function GetItem(Index: Integer): TRegistro0015;
    procedure SetItem(Index: Integer; const Value: TRegistro0015);
  public
    destructor Destroy; override;
    function New: TRegistro0015;
    property Items[Index: Integer]: TRegistro0015 read GetItem write SetItem;
  end;

  /// Registro 0100 - DADOS DO CONTABILISTA

  TRegistro0100 = class(TPersistent)
  private
    fNOME: AnsiString;        /// Nome do contabilista/escritório:
    fCPF: AnsiString;         /// Número de inscrição no CPF:
    fCRC: AnsiString;         /// Número de inscrição no Conselho Regional:
    fCNPJ: AnsiString;        /// CNPJ do escritório de contabilidade, se houver:
    fCEP: AnsiString;         /// Código de Endereçamento Postal:
    fENDERECO: AnsiString;    /// Logradouro e endereço do imóvel:
    fNUM: AnsiString;         /// Número do imóvel:
    fCOMPL: AnsiString;       /// Dados complementares do endereço:
    fBAIRRO: AnsiString;      /// Bairro em que o imóvel está situado:
    fFONE: AnsiString;        /// Número do telefone:
    fFAX: AnsiString;         /// Número do fax:
    fEMAIL: AnsiString;       /// Endereço do correio eletrônico:
    fCOD_MUN: integer;        /// Código do município, conforme tabela IBGE:
  public
    property NOME: AnsiString read FNOME write FNOME;
    property CPF: AnsiString read FCPF write FCPF;
    property CRC: AnsiString read FCRC write FCRC;
    property CNPJ: AnsiString read FCNPJ write FCNPJ;
    property CEP: AnsiString read FCEP write FCEP;
    property ENDERECO: AnsiString read FENDERECO write FENDERECO;
    property NUM: AnsiString read FNUM write FNUM;
    property COMPL: AnsiString read FCOMPL write FCOMPL;
    property BAIRRO: AnsiString read FBAIRRO write FBAIRRO;
    property FONE: AnsiString read FFONE write FFONE;
    property FAX: AnsiString read FFAX write FFAX;
    property EMAIL: AnsiString read FEMAIL write FEMAIL;
    property COD_MUN: integer read FCOD_MUN write FCOD_MUN;
  end;

  /// Registro 0150 - TABELA DE CADASTRO DO PARTICIPANTE

  TRegistro0150 = class(TPersistent)
  private
    fCOD_PART: AnsiString;    /// Código de identificação do participante:
    fNOME: AnsiString;        /// Nome pessoal ou empresarial:
    fCOD_PAIS: AnsiString;    /// Código do país do participante:
    fCNPJ: AnsiString;        /// CNPJ do participante:
    fCPF: AnsiString;         /// CPF do participante na unidade da federação do destinatário:
    fIE: AnsiString;          /// Inscrição Estadual do participante:
    fCOD_MUN: integer;        /// Código do município:
    fSUFRAMA: AnsiString;     /// Número de inscrição na Suframa:
    fENDERECO: AnsiString;    /// Logradouro e endereço do imóvel:
    fNUM: AnsiString;         /// Número do imóvel:
    fCOMPL: AnsiString;       /// Dados complementares do endereço:
    fBAIRRO: AnsiString;      /// Bairro em que o imóvel está situado:
  public
    property COD_PART: AnsiString read FCOD_PART write FCOD_PART;
    property NOME: AnsiString read FNOME write FNOME;
    property COD_PAIS: AnsiString read FCOD_PAIS write FCOD_PAIS;
    property CNPJ: AnsiString read FCNPJ write FCNPJ;
    property CPF: AnsiString read FCPF write FCPF;
    property IE: AnsiString read FIE write FIE;
    property COD_MUN: integer read FCOD_MUN write FCOD_MUN;
    property SUFRAMA: AnsiString read FSUFRAMA write FSUFRAMA;
    property ENDERECO: AnsiString read FENDERECO write FENDERECO;
    property NUM: AnsiString read FNUM write FNUM;
    property COMPL: AnsiString read FCOMPL write FCOMPL;
    property BAIRRO: AnsiString read FBAIRRO write FBAIRRO;
  end;

  /// Registro 0150 - Lista

  TRegistro0150List = class(TList)
  private
    function GetItem(Index: Integer): TRegistro0150;
    procedure SetItem(Index: Integer; const Value: TRegistro0150);
  public
    destructor Destroy; override;
    function New: TRegistro0150;
    function LocalizaRegistro(pCOD_PART: AnsiString): boolean;
    property Items[Index: Integer]: TRegistro0150 read GetItem write SetItem;
  end;

  /// Registro 0175 - ALTERAÇÃO DA TABELA DE CADASTRO DE PARTICIPANTE

  TRegistro0175 = class(TPersistent)
  private
    fDT_ALT: TDateTime;      /// Data de alteração do cadastro:
    fNR_CAMPO: AnsiString;       /// Número do campo alterado (Somente campos 03 a 13):
    fCONT_ANT: AnsiString;       /// Conteúdo anterior do campo:
  public
    property DT_ALT: TDateTime read FDT_ALT write FDT_ALT;
    property NR_CAMPO: AnsiString read FNR_CAMPO write FNR_CAMPO;
    property CONT_ANT: AnsiString read FCONT_ANT write FCONT_ANT;
  end;

  /// Registro 0175 - Lista

  TRegistro0175List = class(TList)
  private
    function GetItem(Index: Integer): TRegistro0175;
    procedure SetItem(Index: Integer; const Value: TRegistro0175);
  public
    destructor Destroy; override;
    function New: TRegistro0175;
    property Items[Index: Integer]: TRegistro0175 read GetItem write SetItem;
  end;

  /// Registro 0190 - IDENTIFICAÇÃO DAS UNIDADES DE MEDIDA

  TRegistro0190 = class(TPersistent)
  private
    fUNID: AnsiString;        /// Código da unidade de medida:
    fDESCR: AnsiString;       /// Descrição da unidade de medida:
  public
    property UNID: AnsiString read FUNID write FUNID;
    property DESCR: AnsiString read FDESCR write FDESCR;
  end;

  /// Registro 0190 - Lista

  TRegistro0190List = class(TList)
  private
    function GetItem(Index: Integer): TRegistro0190;
    procedure SetItem(Index: Integer; const Value: TRegistro0190);
  public
    destructor Destroy; override;
    function New: TRegistro0190;
    function LocalizaRegistro(pUNID: AnsiString): boolean;
    property Items[Index: Integer]: TRegistro0190 read GetItem write SetItem;
  end;

  /// Registro 0200 - TABELA DE IDENTIFICAÇÃO DO ITEM (PRODUTO E SERVIÇOS)

  TRegistro0200 = class(TPersistent)
  private
    fCOD_ITEM: AnsiString;       /// Código do item:
    fDESCR_ITEM: AnsiString;     /// Descrição do item:
    fCOD_BARRA: AnsiString;      /// Código de barra do produto, se houver:
    fCOD_ANT_ITEM: AnsiString;   /// Código anterior do item (ultima apresentado):
    fUNID_INV: AnsiString;       /// Unidade de medida do estoque:
    fTIPO_ITEM: AnsiString;      /// Tipo do item - Atividades Industriais, Comerciais e Serviços: 00 - Mercadoria para Revenda, 01 - Matéria-Prima,  02 - Embalagem, 03 - Produto em Processo, 04 - Produto Acabado, 05 - Subproduto, 06 - Produto Intermediário, 07 - Material de Uso e Consumo, 08 - Ativo Imobilizado, 09 - Serviços, 10 - Outros insumos, 99 - Outras
    fCOD_NCM: AnsiString;        /// Código da Nomenclatura Comum do Mercosul:
    fEX_IPI: AnsiString;         /// Código EX, conforme a TIPI:
    fCOD_GEN: AnsiString;        /// Código gênero item, tabela indicada item 4.2.1:
    fCOD_LST: AnsiString;        /// Código serviço Anexo I - Lei nº116/03:
    fALIQ_ICMS: Currency;      /// Alíquota ICMS aplicável (operações internas):
  public
    property COD_ITEM: AnsiString read FCOD_ITEM write FCOD_ITEM;
    property DESCR_ITEM: AnsiString read FDESCR_ITEM write FDESCR_ITEM;
    property COD_BARRA: AnsiString read FCOD_BARRA write FCOD_BARRA;
    property COD_ANT_ITEM: AnsiString read FCOD_ANT_ITEM write FCOD_ANT_ITEM;
    property UNID_INV: AnsiString read FUNID_INV write FUNID_INV;
    property TIPO_ITEM: AnsiString read FTIPO_ITEM write FTIPO_ITEM;
    property COD_NCM: AnsiString read FCOD_NCM write FCOD_NCM;
    property EX_IPI: AnsiString read FEX_IPI write FEX_IPI;
    property COD_GEN: AnsiString read FCOD_GEN write FCOD_GEN;
    property COD_LST: AnsiString read FCOD_LST write FCOD_LST;
    property ALIQ_ICMS: Currency read FALIQ_ICMS write FALIQ_ICMS;
  end;

  /// Registro 0200 - Lista

  TRegistro0200List = class(TList)
  private
    function GetItem(Index: Integer): TRegistro0200;
    procedure SetItem(Index: Integer; const Value: TRegistro0200);
  public
    destructor Destroy; override;
    function New: TRegistro0200;
    function LocalizaRegistro(pCOD_ITEM: AnsiString): boolean;
    property Items[Index: Integer]: TRegistro0200 read GetItem write SetItem;
  end;

  /// Registro 0205 - CÓDIGO ANTERIOR DO ITEM

  TRegistro0205 = class(TPersistent)
  private
    fDESCR_ANT_ITEM: AnsiString;    /// Descrição anterior do item:
    fDT_INI: TDateTime;             /// Data inicial de utilização do código:
    fDT_FIN: TDateTime;             /// Data final de utilização do código:
  public
    property DESCR_ANT_ITEM: AnsiString read FDESCR_ANT_ITEM write FDESCR_ANT_ITEM;
    property DT_INI: TDateTime read FDT_INI write FDT_INI;
    property DT_FIN: TDateTime read FDT_FIN write FDT_FIN;
  end;

  /// Registro 0205 - Lista

  TRegistro0205List = class(TList)
  private
    function GetItem(Index: Integer): TRegistro0205;
    procedure SetItem(Index: Integer; const Value: TRegistro0205);
  public
    destructor Destroy; override;
    function New: TRegistro0205;
    property Items[Index: Integer]: TRegistro0205 read GetItem write SetItem;
  end;

  /// Registro 0206 - CÓDIGO DE PRODUTO CONFORME TABELA ANP (COMBUSTÍVEIS)

  TRegistro0206 = class(TPersistent)
  private
    fCOD_COMB: AnsiString;       /// Código do combustível, conforme tabela publicada pela ANP:
  public
    property COD_COMB: AnsiString read FCOD_COMB write FCOD_COMB;
  end;

  /// Registro 0206 - Lista

  TRegistro0206List = class(TList)
  private
    function GetItem(Index: Integer): TRegistro0206;
    procedure SetItem(Index: Integer; const Value: TRegistro0206);
  public
    destructor Destroy; override;
    function New: TRegistro0206;
    property Items[Index: Integer]: TRegistro0206 read GetItem write SetItem;
  end;

  /// Registro 0220 - FATORES DE CONVERSÃO DE UNIDADES

  TRegistro0220 = class(TPersistent)
  private
    fUNID_CONV: AnsiString;      /// Unidade comercial a ser convertida na unidade de estoque, referida em 0200:
    fFAT_CONV: AnsiString;       /// Fator de conversão:
  public
    property UNID_CONV: AnsiString read FUNID_CONV write FUNID_CONV;
    property FAT_CONV: AnsiString read FFAT_CONV write FFAT_CONV;
  end;

  /// Registro 0220 - Lista

  TRegistro0220List = class(TList)
  private
    function GetItem(Index: Integer): TRegistro0220;
    procedure SetItem(Index: Integer; const Value: TRegistro0220);
  public
    destructor Destroy; override;
    function New: TRegistro0220;
    property Items[Index: Integer]: TRegistro0220 read GetItem write SetItem;
  end;

  /// Registro 0400 - TABELA DE NATUREZA DA OPERAÇÃO/PRESTAÇÃO

  TRegistro0400 = class(TPersistent)
  private
    fCOD_NAT: AnsiString;        /// Código da natureza:
    fDESCR_NAT: AnsiString;      /// Descrição da natureza:
  public
    property COD_NAT: AnsiString read FCOD_NAT write FCOD_NAT;
    property DESCR_NAT: AnsiString read FDESCR_NAT write FDESCR_NAT;
  end;

  /// Registro 0400 - Lista

  TRegistro0400List = class(TList)
  private
    function GetItem(Index: Integer): TRegistro0400;
    procedure SetItem(Index: Integer; const Value: TRegistro0400);
  public
    destructor Destroy; override;
    function New: TRegistro0400;
    function LocalizaRegistro(pCOD_NAT: AnsiString): boolean;
    property Items[Index: Integer]: TRegistro0400 read GetItem write SetItem;
  end;

  /// Registro 0450 - TABELA DE INFORMAÇÃO COMPLEMENTAR/OBSERVAÇÃO

  TRegistro0450 = class(TPersistent)
  private
    fCOD_INF: AnsiString;     /// Código da informação complementar do documento fiscal:
    fTXT: AnsiString;         /// Texto livre:
  public
    property COD_INF: AnsiString read FCOD_INF write FCOD_INF;
    property TXT: AnsiString read FTXT write FTXT;
  end;

  /// Registro 0450 - Lista

  TRegistro0450List = class(TList)
  private
    function GetItem(Index: Integer): TRegistro0450;
    procedure SetItem(Index: Integer; const Value: TRegistro0450);
  public
    destructor Destroy; override;
    function New: TRegistro0450;
    property Items[Index: Integer]: TRegistro0450 read GetItem write SetItem;
  end;

  /// Registro 0460 - TABELA DE OBSERVAÇÕES DO LANÇAMENTO FISCAL

  TRegistro0460 = class(TPersistent)
  private
    fCOD_OBS: AnsiString;     /// Código da Observação do lançamento fiscal:
    fTXT: AnsiString;         /// Descrição da observação vinculada ao lançamento fiscal:
  public
    property COD_OBS: AnsiString read FCOD_OBS write FCOD_OBS;
    property TXT: AnsiString read FTXT write FTXT;
  end;

  /// Registro 0460 - Lista

  TRegistro0460List = class(TList)
  private
    function GetItem(Index: Integer): TRegistro0460;
    procedure SetItem(Index: Integer; const Value: TRegistro0460);
  public
    destructor Destroy; override;
    function New: TRegistro0460;
    property Items[Index: Integer]: TRegistro0460 read GetItem write SetItem;
  end;

  /// Registro 0990 - ENCERRAMENTO DO BLOCO 0

  TRegistro0990 = class(TPersistent)
  private
    fQTD_LIN_0: Integer; /// Quantidade total de linhas do Bloco 0
  public
    property QTD_LIN_0: Integer read fQTD_LIN_0 write fQTD_LIN_0;
  end;

implementation

{* TRegistro0015List *}

destructor TRegistro0015List.Destroy;
var
intFor: integer;
begin
  for intFor := 0 to Count - 1 do Items[intFor].Free;
  inherited;
end;

function TRegistro0015List.GetItem(Index: Integer): TRegistro0015;
begin
  Result := TRegistro0015(Inherited Items[Index]);
end;

function TRegistro0015List.New: TRegistro0015;
begin
  Result := TRegistro0015.Create;
  Add(Result);
end;

procedure TRegistro0015List.SetItem(Index: Integer; const Value: TRegistro0015);
begin
  Put(Index, Value);
end;

{ TRegistro0150List }

destructor TRegistro0150List.Destroy;
var
intFor: integer;
begin
  for intFor := 0 to Count - 1 do Items[intFor].Free;
  inherited;
end;

function TRegistro0150List.GetItem(Index: Integer): TRegistro0150;
begin
  Result := TRegistro0150(Inherited Items[Index]);
end;

function TRegistro0150List.LocalizaRegistro(pCOD_PART: AnsiString): boolean;
var
intFor: integer;
begin
   Result := false;
   for intFor := 0 to Self.Count - 1 do
   begin
      if Self.Items[intFor].COD_PART = pCOD_PART then
      begin
         Result := true;
         Break;
      end;
   end;
end;

function TRegistro0150List.New: TRegistro0150;
begin
  Result := TRegistro0150.Create;
  Add(Result);
end;

procedure TRegistro0150List.SetItem(Index: Integer; const Value: TRegistro0150);
begin
  Put(Index, Value);
end;

{ TRegistro0175List }

destructor TRegistro0175List.Destroy;
var
intFor: integer;
begin
  for intFor := 0 to Count - 1 do Items[intFor].Free;
  inherited;
end;

function TRegistro0175List.GetItem(Index: Integer): TRegistro0175;
begin
  Result := TRegistro0175(Inherited Items[Index]);
end;

function TRegistro0175List.New: TRegistro0175;
begin
  Result := TRegistro0175.Create;
  Add(Result);
end;

procedure TRegistro0175List.SetItem(Index: Integer; const Value: TRegistro0175);
begin
  Put(Index, Value);
end;

{ TRegistro0190List }

destructor TRegistro0190List.Destroy;
var
intFor: integer;
begin
  for intFor := 0 to Count - 1 do Items[intFor].Free;
  inherited;
end;

function TRegistro0190List.GetItem(Index: Integer): TRegistro0190;
begin
  Result := TRegistro0190(Inherited Items[Index]);
end;

function TRegistro0190List.LocalizaRegistro(pUNID: AnsiString): boolean;
var
intFor: integer;
begin
   Result := false;
   for intFor := 0 to Self.Count - 1 do
   begin
      if Self.Items[intFor].UNID = pUNID then
      begin
         Result := true;
         Break;
      end;
   end;
end;

function TRegistro0190List.New: TRegistro0190;
begin
  Result := TRegistro0190.Create;
  Add(Result);
end;

procedure TRegistro0190List.SetItem(Index: Integer; const Value: TRegistro0190);
begin
  Put(Index, Value);
end;

{ TRegistro0200List }

destructor TRegistro0200List.Destroy;
var
intFor: integer;
begin
  for intFor := 0 to Count - 1 do Items[intFor].Free;
  inherited;
end;

function TRegistro0200List.GetItem(Index: Integer): TRegistro0200;
begin
  Result := TRegistro0200(Inherited Items[Index]);
end;

function TRegistro0200List.LocalizaRegistro(
  pCOD_ITEM: AnsiString): boolean;
var
intFor: integer;
begin
   Result := false;
   for intFor := 0 to Self.Count - 1 do
   begin
      if Self.Items[intFor].COD_ITEM = pCOD_ITEM then
      begin
         Result := true;
         Break;
      end;
   end;
end;

function TRegistro0200List.New: TRegistro0200;
begin
  Result := TRegistro0200.Create;
  Add(Result);
end;

procedure TRegistro0200List.SetItem(Index: Integer; const Value: TRegistro0200);
begin
  Put(Index, Value);
end;

{ TRegistro0205List }

destructor TRegistro0205List.Destroy;
var
intFor: integer;
begin
  for intFor := 0 to Count - 1 do Items[intFor].Free;
  inherited;
end;

function TRegistro0205List.GetItem(Index: Integer): TRegistro0205;
begin
  Result := TRegistro0205(Inherited Items[Index]);
end;

function TRegistro0205List.New: TRegistro0205;
begin
  Result := TRegistro0205.Create;
  Add(Result);
end;

procedure TRegistro0205List.SetItem(Index: Integer; const Value: TRegistro0205);
begin
  Put(Index, Value);
end;

{ TRegistro0206List }

destructor TRegistro0206List.Destroy;
var
intFor: integer;
begin
  for intFor := 0 to Count - 1 do Items[intFor].Free;
  inherited;
end;

function TRegistro0206List.GetItem(Index: Integer): TRegistro0206;
begin
  Result := TRegistro0206(Inherited Items[Index]);
end;

function TRegistro0206List.New: TRegistro0206;
begin
  Result := TRegistro0206.Create;
  Add(Result);
end;

procedure TRegistro0206List.SetItem(Index: Integer; const Value: TRegistro0206);
begin
  Put(Index, Value);
end;

{ TRegistro0220List }

destructor TRegistro0220List.Destroy;
var
intFor: integer;
begin
  for intFor := 0 to Count - 1 do Items[intFor].Free;
  inherited;
end;

function TRegistro0220List.GetItem(Index: Integer): TRegistro0220;
begin
  Result := TRegistro0220(Inherited Items[Index]);
end;

function TRegistro0220List.New: TRegistro0220;
begin
  Result := TRegistro0220.Create;
  Add(Result);
end;

procedure TRegistro0220List.SetItem(Index: Integer; const Value: TRegistro0220);
begin
  Put(Index, Value);
end;

{ TRegistro0400List }

destructor TRegistro0400List.Destroy;
var
intFor: integer;
begin
  for intFor := 0 to Count - 1 do Items[intFor].Free;
  inherited;
end;

function TRegistro0400List.GetItem(Index: Integer): TRegistro0400;
begin
  Result := TRegistro0400(Inherited Items[Index]);
end;

function TRegistro0400List.LocalizaRegistro(pCOD_NAT: AnsiString): boolean;
var intFor: integer;
begin
   Result := false;
   for intFor := 0 to Self.Count - 1 do
   begin
      if Self.Items[intFor].COD_NAT = pCOD_NAT then
      begin
         Result := true;
         Break;
      end;
   end;
end;

function TRegistro0400List.New: TRegistro0400;
begin
  Result := TRegistro0400.Create;
  Add(Result);
end;

procedure TRegistro0400List.SetItem(Index: Integer; const Value: TRegistro0400);
begin
  Put(Index, Value);
end;

{ TRegistro0450List }

destructor TRegistro0450List.Destroy;
var
intFor: integer;
begin
  for intFor := 0 to Count - 1 do Items[intFor].Free;
  inherited;
end;

function TRegistro0450List.GetItem(Index: Integer): TRegistro0450;
begin
  Result := TRegistro0450(Inherited Items[Index]);
end;

function TRegistro0450List.New: TRegistro0450;
begin
  Result := TRegistro0450.Create;
  Add(Result);
end;

procedure TRegistro0450List.SetItem(Index: Integer; const Value: TRegistro0450);
begin
  Put(Index, Value);
end;

{ TRegistro0460List }

destructor TRegistro0460List.Destroy;
var
intFor: integer;
begin
  for intFor := 0 to Count - 1 do Items[intFor].Free;
  inherited;
end;

function TRegistro0460List.GetItem(Index: Integer): TRegistro0460;
begin
  Result := TRegistro0460(inherited Items[Index]);
end;

function TRegistro0460List.New: TRegistro0460;
begin
  Result := TRegistro0460.Create;
  Add(Result);
end;

procedure TRegistro0460List.SetItem(Index: Integer; const Value: TRegistro0460);
begin
  Put(Index, Value);
end;

end.
