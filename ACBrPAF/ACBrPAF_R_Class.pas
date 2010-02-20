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
    FRegistroR03: TRegistroR03List;   /// Lista de RegistroR03
    FRegistroR04: TRegistroR04List;   /// Lista de RegistroR04
    FRegistroR05: TRegistroR05List;   /// Lista de RegistroR05
    FRegistroR06: TRegistroR06List;   /// Lista de RegistroR06
    FRegistroR07: TRegistroR07List;   /// Lista de RegistroR07
  protected
  public
    constructor Create(AOwner: TComponent); /// Create
    destructor Destroy; override; /// Destroy

    function WriteRegistroR01: string;
    function WriteRegistroR02: string;
    function WriteRegistroR03: string;
    function WriteRegistroR04: string;
    function WriteRegistroR05: string;
    function WriteRegistroR06: string;
    function WriteRegistroR07: string;

    property RegistroR01: TRegistroR01 read FRegistroR01 write FRegistroR01;
    property RegistroR02: TRegistroR02List read FRegistroR02 write FRegistroR02;
    property RegistroR03: TRegistroR03List read FRegistroR03 write FRegistroR03;
    property RegistroR04: TRegistroR04List read FRegistroR04 write FRegistroR04;
    property RegistroR05: TRegistroR05List read FRegistroR05 write FRegistroR05;
    property RegistroR06: TRegistroR06List read FRegistroR06 write FRegistroR06;
    property RegistroR07: TRegistroR07List read FRegistroR07 write FRegistroR07;
  end;

implementation

uses ACBrSPEDUtils;

{ TPAF_R }

constructor TPAF_R.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FRegistroR01 := TRegistroR01.Create;
  FRegistroR02 := TRegistroR02List.Create;
  FRegistroR03 := TRegistroR03List.Create;
  FRegistroR04 := TRegistroR04List.Create;
  FRegistroR05 := TRegistroR05List.Create;
  FRegistroR06 := TRegistroR06List.Create;
  FRegistroR07 := TRegistroR07List.Create;
end;

destructor TPAF_R.Destroy;
begin
  FRegistroR01.Free;
  FRegistroR02.Free;
  FRegistroR03.Free;
  FRegistroR04.Free;
  FRegistroR05.Free;
  FRegistroR06.Free;
  FRegistroR07.Free;
  inherited;
end;

function TPAF_R.WriteRegistroR01: string;
begin
   if Assigned(RegistroR01) then
   begin
      with RegistroR01 do
      begin
        Check(funChecaCNPJ(CNPJ), '(R01) ESTABELECIMENTO: O CNPJ "%s" digitado é inválido!', [CNPJ]);
        Check(funChecaCNPJ(CNPJ), '(R01) SOFTHOUSE: O CNPJ "%s" digitado é inválido!', [CNPJ]);
        ///
        Result := LFill('R01') +
                  RFill(NUM_FAB, 20) +
                  RFill(MF_ADICONAL, 1) +
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

function TPAF_R.WriteRegistroR02: string;
var
intFor: integer;
strRegistroR02: string;
begin
  strRegistroR02 := '';

  if Assigned(RegistroR02) then
  begin
     for intFor := 0 to RegistroR02.Count - 1 do
     begin
        with RegistroR02.Items[intFor] do
        begin
          strRegistroR02 := strRegistroR02 + LFill('R02') +
                                             RFill(NUM_FAB, 20) +
                                             RFill(MF_ADICIONAL, 1) +
                                             RFill(MODELO_ECF, 20) +
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
     end;
     Result := strRegistroR02;
  end;
end;

function TPAF_R.WriteRegistroR03: string;
var
intFor: integer;
strRegistroR03: string;
begin
  strRegistroR03 := '';

  if Assigned(RegistroR03) then
  begin
     for intFor := 0 to RegistroR03.Count - 1 do
     begin
        with RegistroR03.Items[intFor] do
        begin
          strRegistroR03 := strRegistroR03 + LFill('R03') +
                                             RFill(NUM_FAB, 20) +
                                             RFill(MF_ADICIONAL, 1) +
                                             RFill(MODELO_ECF, 20) +
                                             LFill(NUM_USU, 2) +
                                             LFill(CRZ, 6) +
                                             RFill(TOT_PARCIAL, 7) +
                                             LFill(VL_ACUM, 13, 2) +
                                             #13#10;
        end;
     end;
     Result := strRegistroR03;
  end;
end;

function TPAF_R.WriteRegistroR04: string;
var
intFor: integer;
strRegistroR04: string;
begin
  strRegistroR04 := '';

  if Assigned(RegistroR04) then
  begin
     for intFor := 0 to RegistroR04.Count - 1 do
     begin
        with RegistroR04.Items[intFor] do
        begin
          strRegistroR04 := strRegistroR04 + LFill('R04') +
                                             RFill(NUM_FAB, 20) +
                                             RFill(MF_ADICIONAL, 1) +
                                             RFill(MODELO_ECF, 20) +
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
     end;
     Result := strRegistroR04;
  end;
end;

function TPAF_R.WriteRegistroR05: string;
var
intFor: integer;
strRegistroR05: string;
begin
  strRegistroR05 := '';

  if Assigned(RegistroR05) then
  begin
     for intFor := 0 to RegistroR05.Count - 1 do
     begin
        with RegistroR05.Items[intFor] do
        begin
          strRegistroR05 := strRegistroR05 + LFill('R05') +
                                             RFill(NUM_FAB, 20) +
                                             RFill(MF_ADICIONAL, 1) +
                                             RFill(MODELO_ECF, 20) +
                                             LFill(NUM_USU, 2) +
                                             LFill(COO, 6) +
                                             LFill(NUM_CONT, 6) +
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
     Result := strRegistroR05;
  end;
end;

function TPAF_R.WriteRegistroR06: string;
var
intFor: integer;
strRegistroR06: string;
begin
  strRegistroR06 := '';

  if Assigned(RegistroR06) then
  begin
     for intFor := 0 to RegistroR06.Count - 1 do
     begin
        with RegistroR06.Items[intFor] do
        begin
          strRegistroR06 := strRegistroR06 + LFill('R06') +
                                             RFill(NUM_FAB, 20) +
                                             RFill(MF_ADICIONAL, 1) +
                                             RFill(MODELO_ECF, 20) +
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
     end;
     Result := strRegistroR06;
  end;
end;

function TPAF_R.WriteRegistroR07: string;
var
intFor: integer;
strRegistroR07: string;
begin
  strRegistroR07 := '';

  if Assigned(RegistroR07) then
  begin
     for intFor := 0 to RegistroR07.Count - 1 do
     begin
        with RegistroR07.Items[intFor] do
        begin
          strRegistroR07 := strRegistroR07 + LFill('R07') +
                                             RFill(NUM_FAB, 20) +
                                             RFill(MF_ADICIONAL, 1) +
                                             RFill(MODELO_ECF, 20) +
                                             LFill(NUM_USU, 2) +
                                             LFill(COO, 6) +
                                             LFill(CCF, 6) +
                                             LFill(GNF, 6) +
                                             RFill(MP, 15) +
                                             LFill(VL_PAGTO, 13, 2) +
                                             RFill(IND_EST, 1) +
                                             LFill(VL_EST, 13, 2) +
                                             #13#10;
        end;
     end;
     Result := strRegistroR07;
  end;
end;

end.
