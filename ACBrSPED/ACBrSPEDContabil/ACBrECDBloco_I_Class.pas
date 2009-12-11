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

unit ACBrECDBloco_I_Class;

interface

uses SysUtils, Classes, DateUtils, ACBrSped, ACBrECDBloco_I;

type
  /// TBLOCO_I -
  TBLOCO_I = class(TACBrSPED)
  private
    FRegistroI001: TRegistroI001;      /// BLOCO I - RegistroI001
    FRegistroI010: TRegistroI010;      /// BLOCO I - RegistroI010
    FRegistroI012: TRegistroI012List;  /// BLOCO I - Lista de RegistroI012
    FRegistroI015: TRegistroI015List;  /// BLOCO I - Lista de RegistroI015
    FRegistroI020: TRegistroI020List;  /// BLOCO I - Lista de RegistroI020
    FRegistroI030: TRegistroI030;      /// BLOCO I - RegistroI030
    FRegistroI050: TRegistroI050List;  /// BLOCO I - Lista de RegistroI050
    FRegistroI051: TRegistroI051List;  /// BLOCO I - Lista de RegistroI051
    FRegistroI052: TRegistroI052List;  /// BLOCO I - Lista de RegistroI052
    FRegistroI075: TRegistroI075List;  /// BLOCO I - Lista de RegistroI075
    FRegistroI100: TRegistroI100List;  /// BLOCO I - Lista de RegistroI100
    FRegistroI150: TRegistroI150List;  /// BLOCO I - Lista de RegistroI150
    FRegistroI151: TRegistroI151List;  /// BLOCO I - Lista de RegistroI151
    FRegistroI155: TRegistroI155List;  /// BLOCO I - Lista de RegistroI155

    FRegistroI990: TRegistroI990;      /// BLOCO I - RegistroI990
  public
    constructor Create(AOwner: TComponent); override; /// Create
    destructor Destroy; override; /// Destroy
    procedure LimpaRegistros;

    function WriteRegistroI001: AnsiString;
    function WriteRegistroI010: AnsiString;
    function WriteRegistroI012: AnsiString;
    function WriteRegistroI015: AnsiString;
    function WriteRegistroI020: AnsiString;
    function WriteRegistroI030: AnsiString;
    function WriteRegistroI050: AnsiString;
    function WriteRegistroI051: AnsiString;
    function WriteRegistroI052: AnsiString;
    function WriteRegistroI075: AnsiString;
    function WriteRegistroI100: AnsiString;
    function WriteRegistroI150: AnsiString;
    function WriteRegistroI151: AnsiString;
    function WriteRegistroI155: AnsiString;

    function WriteRegistroI990: AnsiString;

    property RegistroI001: TRegistroI001 read FRegistroI001 write FRegistroI001;
    property RegistroI010: TRegistroI010 read FRegistroI010 write FRegistroI010;
    property RegistroI012: TRegistroI012List read fRegistroI012 write fRegistroI012;
    property RegistroI015: TRegistroI015List read fRegistroI015 write fRegistroI015;
    property RegistroI020: TRegistroI020List read fRegistroI020 write fRegistroI020;
    property RegistroI030: TRegistroI030 read fRegistroI030 write fRegistroI030;
    property RegistroI050: TRegistroI050List read fRegistroI050 write fRegistroI050;
    property RegistroI051: TRegistroI051List read fRegistroI051 write fRegistroI051;
    property RegistroI052: TRegistroI052List read fRegistroI052 write fRegistroI052;
    property RegistroI075: TRegistroI075List read fRegistroI075 write fRegistroI075;
    property RegistroI100: TRegistroI100List read fRegistroI100 write fRegistroI100;
    property RegistroI150: TRegistroI150List read fRegistroI150 write fRegistroI150;
    property RegistroI151: TRegistroI151List read fRegistroI151 write fRegistroI151;
    property RegistroI155: TRegistroI155List read fRegistroI155 write fRegistroI155;

    property RegistroI990: TRegistroI990 read FRegistroI990 write FRegistroI990;
  end;

implementation

{ TBLOCO_I }

constructor TBLOCO_I.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FRegistroI001 := TRegistroI001.Create;
  FRegistroI010 := TRegistroI010.Create;
  FRegistroI012 := TRegistroI012List.Create;
  FRegistroI015 := TRegistroI015List.Create;
  FRegistroI020 := TRegistroI020List.Create;
  FRegistroI030 := TRegistroI030.Create;
  FRegistroI050 := TRegistroI050List.Create;
  FRegistroI051 := TRegistroI051List.Create;
  FRegistroI052 := TRegistroI052List.Create;
  FRegistroI075 := TRegistroI075List.Create;
  FRegistroI100 := TRegistroI100List.Create;
  FRegistroI150 := TRegistroI150List.Create;
  FRegistroI151 := TRegistroI151List.Create;
  FRegistroI155 := TRegistroI155List.Create;

  FRegistroI990 := TRegistroI990.Create;

  FRegistroI990.QTD_LIN_I := 0;
end;

destructor TBLOCO_I.Destroy;
begin
  FRegistroI001.Free;
  FRegistroI010.Free;
  FRegistroI012.Free;
  FRegistroI015.Free;
  FRegistroI020.Free;
  FRegistroI030.Free;
  FRegistroI050.Free;
  FRegistroI051.Free;
  FRegistroI052.Free;
  FRegistroI075.Free;
  FRegistroI100.Free;
  FRegistroI150.Free;
  FRegistroI151.Free;
  FRegistroI155.Free;

  FRegistroI990.Free;
  inherited;
end;

procedure TBLOCO_I.LimpaRegistros;
begin
  FRegistroI012.Clear;
  FRegistroI015.Clear;
  FRegistroI020.Clear;
  FRegistroI050.Clear;
  FRegistroI051.Clear;
  FRegistroI052.Clear;
  FRegistroI075.Clear;
  FRegistroI100.Clear;
  FRegistroI150.Clear;
  FRegistroI151.Clear;
  FRegistroI155.Clear;

  FRegistroI990.QTD_LIN_I := 0;
end;

function TBLOCO_I.WriteRegistroI001: AnsiString;
begin
  Result := '';

  if Assigned(RegistroI001) then
  begin
     with RegistroI001 do
     begin
       Check(((IND_DAD = 0) or (IND_DAD = 1)), '(I-I001) Na abertura do bloco, deve ser informado o número 0 ou 1!');
       ///
       Result := LFill('I001') +
                 LFill(IND_DAD, 1) +
                 Delimitador +
                 #13#10;
       ///
       RegistroI990.QTD_LIN_I := RegistroI990.QTD_LIN_I + 1;
     end;
  end;
end;

function TBLOCO_I.WriteRegistroI010: AnsiString;
begin
  Result := '';

  if Assigned(RegistroI010) then
  begin
     with RegistroI010 do
     begin
       Check(((IND_ESC = 'G') or (IND_ESC = 'R') or (IND_ESC = 'A') or (IND_ESC = 'B') or (IND_ESC = 'Z')), '(I-I010) No Indicador da forma de escrituração contábil, deve ser informado: G ou R ou A ou B ou Z!');
       ///
       Result := LFill('I010') +
                 LFill(IND_ESC, 1) +
                 LFill(COD_VER_LC) +
                 Delimitador +
                 #13#10;
       ///
       RegistroI990.QTD_LIN_I := RegistroI990.QTD_LIN_I + 1;
     end;
  end;
end;

function TBloco_I.WriteRegistroI012: AnsiString;
var
intFor: integer;
strRegistroI012: AnsiString;
begin
  strRegistroI012 := '';

  if Assigned(RegistroI012) then
  begin
     for intFor := 0 to RegistroI012.Count - 1 do
     begin
        with RegistroI012.Items[intFor] do
        begin
           Check(((TIPO = '0') or (TIPO = '1')), '(I-I012) No Tipo de Escrituração do livro, deve ser informado: 0 ou 1!');
           ///
           strRegistroI012 :=  strRegistroI012 + LFill('I012') +
                                                 LFill(NUM_ORD) +
                                                 RFill(NAT_LIVR, 80) +
                                                 LFill(TIPO, 1) +
                                                 LFill(COD_HASH_AUX) +
                                                 Delimitador +
                                                 #13#10;
        end;
       RegistroI990.QTD_LIN_I := RegistroI990.QTD_LIN_I + 1;
     end;
  end;
  Result := strRegistroI012;
end;

function TBloco_I.WriteRegistroI015: AnsiString;
var
intFor: integer;
strRegistroI015: AnsiString;
begin
  strRegistroI015 := '';

  if Assigned(RegistroI015) then
  begin
     for intFor := 0 to RegistroI015.Count - 1 do
     begin
        with RegistroI015.Items[intFor] do
        begin
           ///
           strRegistroI015 :=  strRegistroI015 + LFill('I015') +
                                                 LFill(COD_CTA_RES) +
                                                 Delimitador +
                                                 #13#10;
        end;
       RegistroI990.QTD_LIN_I := RegistroI990.QTD_LIN_I + 1;
     end;
  end;
  Result := strRegistroI015;
end;

function TBloco_I.WriteRegistroI020: AnsiString;
var
intFor: integer;
strRegistroI020: AnsiString;
begin
  strRegistroI020 := '';

  if Assigned(RegistroI020) then
  begin
     for intFor := 0 to RegistroI020.Count - 1 do
     begin
        with RegistroI020.Items[intFor] do
        begin
           Check(CAMPO <> '', '(I-I020) O nome do campo adicional é obrigatório!');
           Check(((TIPO_DADO = 'N') or (TIPO_DADO = 'C')), '(I-I020) Na Indicação do tipo de dado, deve ser informado: N ou C!');
           ///
           strRegistroI020 :=  strRegistroI020 + LFill('I020') +
                                                 LFill(REG_COD, 4) +
                                                 LFill(NUM_AD) +
                                                 LFill(CAMPO) +
                                                 LFill(DESCRICAO) +
                                                 LFill(TIPO_DADO, 1) +
                                                 Delimitador +
                                                 #13#10;
        end;
       RegistroI990.QTD_LIN_I := RegistroI990.QTD_LIN_I + 1;
     end;
  end;
  Result := strRegistroI020;
end;

function TBLOCO_I.WriteRegistroI030: AnsiString;
begin
  Result := '';

  if Assigned(RegistroI030) then
  begin
     with RegistroI030 do
     begin
       ///
       Result := LFill('I030') +
                 LFill('TERMO DE ABERTURA') +
                 LFill(NUM_ORD) +
                 RFill(NAT_LIVR, 80) +
                 LFill(QTD_LIN) +
                 LFill(NOME) +
                 LFill(NIRE, 11) +
                 LFill(CNPJ) +
                 LFill(DT_ARQ) +
                 LFill(DT_ARQ_CONV, 'ddmmyyyy', True) +
                 LFill(DESC_MUN) +
                 Delimitador +
                 #13#10;
       ///
       RegistroI990.QTD_LIN_I := RegistroI990.QTD_LIN_I + 1;
     end;
  end;
end;

function TBloco_I.WriteRegistroI050: AnsiString;
var
intFor: integer;
strRegistroI050: AnsiString;
begin
  strRegistroI050 := '';

  if Assigned(RegistroI050) then
  begin
     for intFor := 0 to RegistroI050.Count - 1 do
     begin
        with RegistroI050.Items[intFor] do
        begin
           ///
           strRegistroI050 :=  strRegistroI050 + LFill('I050') +
                                                 LFill(DT_ALT) +
                                                 LFill(COD_NAT, 2) +
                                                 LFill(IND_CTA, 1) +
                                                 LFill(NIVEL) +
                                                 LFill(COD_CTA) +
                                                 LFill(COD_CTA_SUP) +
                                                 LFill(CTA) +
                                                 Delimitador +
                                                 #13#10;
        end;
       RegistroI990.QTD_LIN_I := RegistroI990.QTD_LIN_I + 1;
     end;
  end;
  Result := strRegistroI050;
end;

function TBloco_I.WriteRegistroI051: AnsiString;
var
intFor: integer;
strRegistroI051: AnsiString;
begin
  strRegistroI051 := '';

  if Assigned(RegistroI051) then
  begin
     for intFor := 0 to RegistroI051.Count - 1 do
     begin
        with RegistroI051.Items[intFor] do
        begin
           ///
           strRegistroI051 :=  strRegistroI051 + LFill('I051') +
                                                 LFill(COD_ENT_REF, 2) +
                                                 LFill(COD_CCUS) +
                                                 LFill(COD_CTA_REF) +
                                                 Delimitador +
                                                 #13#10;
        end;
       RegistroI990.QTD_LIN_I := RegistroI990.QTD_LIN_I + 1;
     end;
  end;
  Result := strRegistroI051;
end;

function TBloco_I.WriteRegistroI052: AnsiString;
var
intFor: integer;
strRegistroI052: AnsiString;
begin
  strRegistroI052 := '';

  if Assigned(RegistroI052) then
  begin
     for intFor := 0 to RegistroI052.Count - 1 do
     begin
        with RegistroI052.Items[intFor] do
        begin
           ///
           strRegistroI052 :=  strRegistroI052 + LFill('I052') +
                                                 LFill(COD_CCUS) +
                                                 LFill(COD_AGL) +
                                                 Delimitador +
                                                 #13#10;
        end;
       RegistroI990.QTD_LIN_I := RegistroI990.QTD_LIN_I + 1;
     end;
  end;
  Result := strRegistroI052;
end;

function TBloco_I.WriteRegistroI075: AnsiString;
var
intFor: integer;
strRegistroI075: AnsiString;
begin
  strRegistroI075 := '';

  if Assigned(RegistroI075) then
  begin
     for intFor := 0 to RegistroI075.Count - 1 do
     begin
        with RegistroI075.Items[intFor] do
        begin
           ///
           strRegistroI075 :=  strRegistroI075 + LFill('I075') +
                                                 LFill(COD_HIST) +
                                                 LFill(DESCR_HIST) +
                                                 Delimitador +
                                                 #13#10;
        end;
       RegistroI990.QTD_LIN_I := RegistroI990.QTD_LIN_I + 1;
     end;
  end;
  Result := strRegistroI075;
end;

function TBloco_I.WriteRegistroI100: AnsiString;
var
intFor: integer;
strRegistroI100: AnsiString;
begin
  strRegistroI100 := '';

  if Assigned(RegistroI100) then
  begin
     for intFor := 0 to RegistroI100.Count - 1 do
     begin
        with RegistroI100.Items[intFor] do
        begin
           ///
           strRegistroI100 :=  strRegistroI100 + LFill('I100') +
                                                 LFill(DT_ALT) +
                                                 LFill(COD_CCUS) +
                                                 LFill(CCUS) +
                                                 Delimitador +
                                                 #13#10;
        end;
       RegistroI990.QTD_LIN_I := RegistroI990.QTD_LIN_I + 1;
     end;
  end;
  Result := strRegistroI100;
end;

function TBloco_I.WriteRegistroI150: AnsiString;
var
intFor: integer;
strRegistroI150: AnsiString;
begin
  strRegistroI150 := '';

  if Assigned(RegistroI150) then
  begin
     for intFor := 0 to RegistroI150.Count - 1 do
     begin
        with RegistroI150.Items[intFor] do
        begin
           ///
           strRegistroI150 :=  strRegistroI150 + LFill('I150') +
                                                 LFill(DT_INI) +
                                                 LFill(DT_FIN) +
                                                 Delimitador +
                                                 #13#10;
        end;
       RegistroI990.QTD_LIN_I := RegistroI990.QTD_LIN_I + 1;
     end;
  end;
  Result := strRegistroI150;
end;

function TBloco_I.WriteRegistroI151: AnsiString;
var
intFor: integer;
strRegistroI151: AnsiString;
begin
  strRegistroI151 := '';

  if Assigned(RegistroI151) then
  begin
     for intFor := 0 to RegistroI151.Count - 1 do
     begin
        with RegistroI151.Items[intFor] do
        begin
           ///
           strRegistroI151 :=  strRegistroI151 + LFill('I151') +
                                                 LFill(ASSIM_DIG) +
                                                 Delimitador +
                                                 #13#10;
        end;
       RegistroI990.QTD_LIN_I := RegistroI990.QTD_LIN_I + 1;
     end;
  end;
  Result := strRegistroI151;
end;

function TBloco_I.WriteRegistroI155: AnsiString;
var
intFor: integer;
strRegistroI155: AnsiString;
begin
  strRegistroI155 := '';

  if Assigned(RegistroI155) then
  begin
     for intFor := 0 to RegistroI155.Count - 1 do
     begin
        with RegistroI155.Items[intFor] do
        begin
           Check(((IND_DC_INI = 'D') or (IND_DC_INI = 'C') or (IND_DC_INI = '')), '(I-I155) No Indicador da situação do saldo inicial, deve ser informado: D ou C ou nulo!');
           Check(((IND_DC_FIN = 'D') or (IND_DC_FIN = 'C') or (IND_DC_FIN = '')), '(I-I155) No Indicador da situação do saldo inicial, deve ser informado: D ou C ou nulo!');
           ///
           strRegistroI155 :=  strRegistroI155 + LFill('I155') +
                                                 LFill(COD_CTA) +
                                                 LFill(COD_CCUS) +
                                                 LFill(VL_SLD_INI, 19, 2) +
                                                 LFill(IND_DC_INI, 0) +
                                                 LFill(VL_DEB, 19, 2) +
                                                 LFill(VL_CRED, 19, 2) +
                                                 LFill(VL_SLD_FIN, 19, 2) +
                                                 LFill(IND_DC_FIN, 0) +
                                                 Delimitador +
                                                 #13#10;
        end;
       RegistroI990.QTD_LIN_I := RegistroI990.QTD_LIN_I + 1;
     end;
  end;
  Result := strRegistroI155;
end;

function TBLOCO_I.WriteRegistroI990: AnsiString;
begin
  Result := '';

  if Assigned(RegistroI990) then
  begin
     with RegistroI990 do
     begin
       QTD_LIN_I := QTD_LIN_I + 1;
       ///
       Result := LFill('I990') +
                 LFill(QTD_LIN_I, 0) +
                 Delimitador +
                 #13#10;
     end;
  end;
end;

end.
