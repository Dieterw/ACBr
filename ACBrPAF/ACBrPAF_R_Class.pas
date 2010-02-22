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

unit ACBrPAF_R_Class;

interface

uses SysUtils, Classes, DateUtils, ACBrUtilTXT, ACBrPAFRegistros, ACBrPAF_R;

type
  /// TPAF_R -
  TPAF_R = class(TACBrTXT)
  private
    FRegistroR01: TRegistroR01;       /// RegistroR01
    FRegistroR02: TRegistroR02List;   /// Lista de RegistroR02
    FRegistroR04: TRegistroR04List;   /// Lista de RegistroR04
    FRegistroR06: TRegistroR06List;   /// Lista de RegistroR06

    FRegistroR03Count: Integer;
    FRegistroR05Count: Integer;
    FRegistroR07Count: Integer;

    function WriteRegistroR03(RegR02: TRegistroR02): AnsiString;
    function WriteRegistroR05(RegR04: TRegistroR04): AnsiString;
    function WriteRegistroR07(RegR06: TRegistroR06): AnsiString;

    procedure CriaRegistros;
    procedure LiberaRegistros;
  public
    constructor Create(AOwner: TComponent); /// Create
    destructor Destroy; override; /// Destroy
    procedure LimpaRegistros;

    function WriteRegistroR01: AnsiString;
    function WriteRegistroR02: AnsiString;
    function WriteRegistroR04: AnsiString;
    function WriteRegistroR06: AnsiString;

    property RegistroR01: TRegistroR01 read FRegistroR01 write FRegistroR01;
    property RegistroR02: TRegistroR02List read FRegistroR02 write FRegistroR02;
    property RegistroR04: TRegistroR04List read FRegistroR04 write FRegistroR04;
    property RegistroR06: TRegistroR06List read FRegistroR06 write FRegistroR06;

    property RegistroR03Count: Integer read FRegistroR03Count write FRegistroR03Count;
    property RegistroR05Count: Integer read FRegistroR05Count write FRegistroR05Count;
    property RegistroR07Count: Integer read FRegistroR07Count write FRegistroR07Count;
  end;

implementation

uses ACBrSPEDUtils;

{ TPAF_R }

constructor TPAF_R.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  CriaRegistros;
end;

destructor TPAF_R.Destroy;
begin
  LiberaRegistros;
  inherited;
end;

procedure TPAF_R.CriaRegistros;
begin
  FRegistroR01 := TRegistroR01.Create;
  FRegistroR02 := TRegistroR02List.Create;
  FRegistroR04 := TRegistroR04List.Create;
  FRegistroR06 := TRegistroR06List.Create;

  FRegistroR03Count := 0;
  FRegistroR05Count := 0;
  FRegistroR07Count := 0;
end;

procedure TPAF_R.LiberaRegistros;
begin
  FRegistroR01.Free;
  FRegistroR02.Free;
  FRegistroR04.Free;
  FRegistroR06.Free;
end;

procedure TPAF_R.LimpaRegistros;
begin
  /// Limpa os Registros
  LiberaRegistros;
  /// Recriar os Registros Limpos
  CriaRegistros;
end;

function TPAF_R.WriteRegistroR01: AnsiString;
begin
   Result := '';

   if Assigned(FRegistroR01) then
   begin
      with FRegistroR01 do
      begin
        Check(funChecaCNPJ(CNPJ), '(R01) ESTABELECIMENTO: O CNPJ "%s" digitado é inválido!', [CNPJ]);
        Check(funChecaCNPJ(CNPJ), '(R01) SOFTHOUSE: O CNPJ "%s" digitado é inválido!', [CNPJ]);
        ///
        Result := LFill('R01') +
                  RFill(NUM_FAB, 20) +
                  RFill(MF_ADICIONAL, 1) +
                  RFill(TIPO_ECF, 7) +
                  RFill(MARCA_ECF, 20) +
                  RFill(MODELO_ECF, 20) +
                  RFill(VERSAO_SB, 10) +
                  LFill(DT_INST_SB, 'yyyymmdd') +
                  LFill(HR_INST_SB, 'hhmmss') +
                  LFill(NUM_SEQ_ECF, 3) +
                  LFill(CNPJ, 14) +
                  RFill(IE, 14) +
                  LFill(CNPJ_SH, 14) +
                  LFill(IE_SH, 14) +
                  LFill(IM_SH, 14) +
                  RFill(NOME_SH, 40) +
                  RFill(VER_PAF, 10) +
                  RFill(NOME_PAF, 40) +  // emsoft
                  RFill(COD_MD5, 32) +
                  LFill(DT_INI, 'yyyymmdd') +
                  LFill(DT_FIN, 'yyyymmdd') +
                  RFill(ER_PAF_ECF, 4) +
                  #13#10;
      end;
   end;
end;

function TPAF_R.WriteRegistroR02: AnsiString;
var
intFor: integer;
strRegistroR02: string;
begin
  strRegistroR02 := '';

  if Assigned(FRegistroR02) then
  begin
     for intFor := 0 to FRegistroR02.Count - 1 do
     begin
        with FRegistroR02.Items[intFor] do
        begin
          strRegistroR02 := strRegistroR02 + LFill('R02') +
                                             RFill(FRegistroR01.NUM_FAB, 20) +
                                             RFill(FRegistroR01.MF_ADICIONAL, 1) +
                                             RFill(FRegistroR01.MODELO_ECF, 20) +
                                             LFill(NUM_USU, 2) +
                                             LFill(CRZ, 6) +
                                             LFill(COO, 6) +
                                             LFill(CRO, 6) +
                                             LFill(DT_MOV, 'yyyymmdd') +
                                             LFill(DT_EMI, 'yyyymmdd') +
                                             LFill(HR_EMI, 'hhmmss') +
                                             LFill(VL_VBD, 14, 2) +
                                             RFill(PAR_ECF, 1) +
                                             #13#10;
        end;
        /// Registro FILHOS
        strRegistroR02 := strRegistroR02 +
                          WriteRegistroR03( FRegistroR02.Items[intFor] );
     end;
  end;
  Result := strRegistroR02;
end;

function TPAF_R.WriteRegistroR03(RegR02: TRegistroR02): AnsiString;
var
intFor: integer;
strRegistroR03: string;
begin
  strRegistroR03 := '';

  if Assigned(RegR02.RegistroR03) then
  begin
     for intFor := 0 to RegR02.RegistroR03.Count - 1 do
     begin
        with RegR02.RegistroR03.Items[intFor] do
        begin
          strRegistroR03 := strRegistroR03 + LFill('R03') +
                                             RFill(FRegistroR01.NUM_FAB, 20) +
                                             RFill(FRegistroR01.MF_ADICIONAL, 1) +
                                             RFill(FRegistroR01.MODELO_ECF, 20) +
                                             LFill(RegR02.NUM_USU, 2) +
                                             LFill(RegR02.CRZ, 6) +
                                             RFill(TOT_PARCIAL, 7) +
                                             LFill(VL_ACUM, 13, 2) +
                                             #13#10;
        end;
     end;
     /// Variavél para armazenar a quantidade de registro do tipo.
     FRegistroR03Count := FRegistroR03Count + RegR02.RegistroR03.Count;
  end;
  Result := strRegistroR03;
end;

function TPAF_R.WriteRegistroR04: AnsiString;
var
intFor: integer;
strRegistroR04: string;
begin
  strRegistroR04 := '';

  if Assigned(FRegistroR04) then
  begin
     for intFor := 0 to FRegistroR04.Count - 1 do
     begin
        with FRegistroR04.Items[intFor] do
        begin
          strRegistroR04 := strRegistroR04 + LFill('R04') +
                                             RFill(FRegistroR01.NUM_FAB, 20) +
                                             RFill(FRegistroR01.MF_ADICIONAL, 1) +
                                             RFill(FRegistroR01.MODELO_ECF, 20) +
                                             LFill(NUM_USU, 2) +
                                             LFill(NUM_CONT, 6) +
                                             LFill(COO, 6) +
                                             LFill(DT_INI, 'yyyymmdd') +
                                             LFill(SUB_DOCTO, 14, 2) +
                                             LFill(SUB_DESCTO, 13, 2) +
                                             RFill(TP_DESCTO, 1) +
                                             LFill(SUB_ACRES, 13, 2) +
                                             RFill(TP_ACRES, 1) +
                                             LFill(VL_TOT, 14, 2) +
                                             RFill(CANC, 1) +
                                             LFill(VL_CA, 13, 2) +
                                             RFill(ORDEM_DA, 1) +
                                             RFill(NOME_CLI, 40) +
                                             LFill(CNPJ_CPF, 14) +
                                             #13#10;
        end;
        /// Registro FILHOS
        strRegistroR04 := strRegistroR04 +
                          WriteRegistroR05( FRegistroR04.Items[intFor] );
     end;
  end;
  Result := strRegistroR04;
end;

function TPAF_R.WriteRegistroR05(RegR04: TRegistroR04): AnsiString;
var
intFor: integer;
strRegistroR05: string;
begin
  strRegistroR05 := '';

  if Assigned(RegR04.RegistroR05) then
  begin
     for intFor := 0 to RegR04.RegistroR05.Count - 1 do
     begin
        with RegR04.RegistroR05.Items[intFor] do
        begin
          strRegistroR05 := strRegistroR05 + LFill('R05') +
                                             RFill(FRegistroR01.NUM_FAB, 20) +
                                             RFill(FRegistroR01.MF_ADICIONAL, 1) +
                                             RFill(FRegistroR01.MODELO_ECF, 20) +
                                             LFill(RegR04.NUM_USU, 2) +
                                             LFill(RegR04.COO, 6) +
                                             LFill(RegR04.NUM_CONT, 6) +
                                             LFill(NUM_ITEM, 3) +
                                             RFill(COD_ITEM, 14) +
                                             RFill(DESC_ITEM, 100) +
                                             LFill(QTDE_ITEM, 7, 2) +
                                             RFill(UN_MED, 3) +
                                             LFill(VL_UNIT, 8, 2) +
                                             LFill(DESCTO_ITEM, 8, 2) +
                                             LFill(ACRES_ITEM, 8, 2) +
                                             LFill(VL_TOT_ITEM, 14, 2) +
                                             RFill(COD_TOT_PARC, 7) +
                                             RFill(IND_CANC, 1) +
                                             LFill(QTDE_CANC, 7, 2) +
                                             LFill(VL_CANC, 13, 2) +
                                             LFill(VL_CANC_ACRES, 13, 2) +
                                             RFill(IAT, 1) +
                                             RFill(IPPT, 1) +
                                             LFill(QTDE_DECIMAL, 1) +
                                             LFill(VL_DECIMAL, 1) +
                                             #13#10;
        end;
     end;
     /// Variavél para armazenar a quantidade de registro do tipo.
     FRegistroR05Count := FRegistroR05Count + RegR04.RegistroR05.Count;
  end;
  Result := strRegistroR05;
end;

function TPAF_R.WriteRegistroR06: AnsiString;
var
intFor: integer;
strRegistroR06: string;
begin
  strRegistroR06 := '';

  if Assigned(FRegistroR06) then
  begin
     for intFor := 0 to FRegistroR06.Count - 1 do
     begin
        with FRegistroR06.Items[intFor] do
        begin
          strRegistroR06 := strRegistroR06 + LFill('R06') +
                                             RFill(FRegistroR01.NUM_FAB, 20) +
                                             RFill(FRegistroR01.MF_ADICIONAL, 1) +
                                             RFill(FRegistroR01.MODELO_ECF, 20) +
                                             LFill(NUM_USU, 2) +
                                             LFill(COO, 6) +
                                             LFill(GNF, 6) +
                                             LFill(GRG, 6) +
                                             LFill(CDC, 4) +
                                             RFill(DENOM, 2) +
                                             LFill(DT_FIN, 'yyyymmdd') +
                                             LFill(HR_FIN, 'hhmmss') +
                                             #13#10;
        end;
        /// Registro FILHOS
        strRegistroR06 := strRegistroR06 +
                          WriteRegistroR07( FRegistroR06.Items[intFor] );
     end;
  end;
  Result := strRegistroR06;
end;

function TPAF_R.WriteRegistroR07(RegR06: TRegistroR06): AnsiString;
var
intFor: integer;
strRegistroR07: string;
begin
  strRegistroR07 := '';

  if Assigned(RegR06.RegistroR07) then
  begin
     for intFor := 0 to RegR06.RegistroR07.Count - 1 do
     begin
        with RegR06.RegistroR07.Items[intFor] do
        begin
          strRegistroR07 := strRegistroR07 + LFill('R07') +
                                             RFill(FRegistroR01.NUM_FAB, 20) +
                                             RFill(FRegistroR01.MF_ADICIONAL, 1) +
                                             RFill(FRegistroR01.MODELO_ECF, 20) +
                                             LFill(RegR06.NUM_USU, 2) +
                                             LFill(RegR06.COO, 6) +
                                             LFill(CCF, 6) +
                                             LFill(RegR06.GNF, 6) +
                                             RFill(MP, 15) +
                                             LFill(VL_PAGTO, 13, 2) +
                                             RFill(IND_EST, 1) +
                                             LFill(VL_EST, 13, 2) +
                                             #13#10;
        end;
     end;
     /// Variavél para armazenar a quantidade de registro do tipo.
     FRegistroR07Count := FRegistroR07Count + RegR06.RegistroR07.Count;
  end;
  Result := strRegistroR07;
end;

end.
