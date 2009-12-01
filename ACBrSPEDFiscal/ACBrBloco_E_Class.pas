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

unit ACBrBloco_E_Class;

interface

uses SysUtils, Classes, DateUtils, ACBrSped, ACBrBloco_E;

type
  /// TBLOCO_E -
  TBloco_E = class(TACBrSPED)
  private
    FRegistroE001: TRegistroE001;      /// BLOCO E - RegistroE001
    FRegistroE100: TRegistroE100;      /// BLOCO E - RegistroE100
    FRegistroE110: TRegistroE110;      /// BLOCO E - RegistroE110
    FRegistroE111: TRegistroE111List;  /// BLOCO E - Lista de RegistroE111
    FRegistroE112: TRegistroE112List;  /// BLOCO E - Lista de RegistroE112
    FRegistroE113: TRegistroE113List;  /// BLOCO E - Lista de RegistroE113
    FRegistroE115: TRegistroE115List;  /// BLOCO E - Lista de RegistroE115
    FRegistroE116: TRegistroE116List;  /// BLOCO E - Lista de RegistroE116
    FRegistroE200: TRegistroE200List;  /// BLOCO E - Lista de RegistroE200
    FRegistroE210: TRegistroE210List;  /// BLOCO E - Lista de RegistroE210
    FRegistroE220: TRegistroE220List;  /// BLOCO E - Lista de RegistroE220
    FRegistroE230: TRegistroE230List;  /// BLOCO E - Lista de RegistroE230
    FRegistroE240: TRegistroE240List;  /// BLOCO E - Lista de RegistroE240
    FRegistroE250: TRegistroE250List;  /// BLOCO E - Lista de RegistroE250
    FRegistroE500: TRegistroE500List;  /// BLOCO E - Lista de RegistroE500
    FRegistroE510: TRegistroE510List;  /// BLOCO E - Lista de RegistroE510
    FRegistroE520: TRegistroE520List;  /// BLOCO E - Lista de RegistroE520
    FRegistroE530: TRegistroE530List;  /// BLOCO E - Lista de RegistroE530
    FRegistroE990: TRegistroE990;      /// BLOCO E - RegistroE990

    procedure CriaRegistros;
    procedure LiberaRegistros;
  public
    constructor Create(AOwner: TComponent); override; /// Create
    destructor Destroy; override; /// Destroy
    procedure LimpaRegistros;

    function WriteRegistroE001: AnsiString;
    function WriteRegistroE100: AnsiString;
    function WriteRegistroE110: AnsiString;
    function WriteRegistroE111: AnsiString;
    function WriteRegistroE112: AnsiString;
    function WriteRegistroE113: AnsiString;
    function WriteRegistroE115: AnsiString;
    function WriteRegistroE116: AnsiString;
    function WriteRegistroE200: AnsiString;
    function WriteRegistroE210: AnsiString;
    function WriteRegistroE220: AnsiString;
    function WriteRegistroE230: AnsiString;
    function WriteRegistroE240: AnsiString;
    function WriteRegistroE250: AnsiString;
    function WriteRegistroE500: AnsiString;
    function WriteRegistroE510: AnsiString;
    function WriteRegistroE520: AnsiString;
    function WriteRegistroE530: AnsiString;
    function WriteRegistroE990: AnsiString;

    property RegistroE001: TRegistroE001 read FRegistroE001 write FRegistroE001;
    property RegistroE100: TRegistroE100 read FRegistroE100 write FRegistroE100;
    property RegistroE110: TRegistroE110 read FRegistroE110 write FRegistroE110;
    property RegistroE111: TRegistroE111List read FRegistroE111 write FRegistroE111;
    property RegistroE112: TRegistroE112List read FRegistroE112 write FRegistroE112;
    property RegistroE113: TRegistroE113List read FRegistroE113 write FRegistroE113;
    property RegistroE115: TRegistroE115List read FRegistroE115 write FRegistroE115;
    property RegistroE116: TRegistroE116List read FRegistroE116 write FRegistroE116;
    property RegistroE200: TRegistroE200List read FRegistroE200 write FRegistroE200;
    property RegistroE210: TRegistroE210List read FRegistroE210 write FRegistroE210;
    property RegistroE220: TRegistroE220List read FRegistroE220 write FRegistroE220;
    property RegistroE230: TRegistroE230List read FRegistroE230 write FRegistroE230;
    property RegistroE240: TRegistroE240List read FRegistroE240 write FRegistroE240;
    property RegistroE250: TRegistroE250List read FRegistroE250 write FRegistroE250;
    property RegistroE500: TRegistroE500List read FRegistroE500 write FRegistroE500;
    property RegistroE510: TRegistroE510List read FRegistroE510 write FRegistroE510;
    property RegistroE520: TRegistroE520List read FRegistroE520 write FRegistroE520;
    property RegistroE530: TRegistroE530List read FRegistroE530 write FRegistroE530;
    property RegistroE990: TRegistroE990 read FRegistroE990 write FRegistroE990;
  end;

implementation

{ TBloco_E }

constructor TBloco_E.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  CriaRegistros;
end;

destructor TBloco_E.Destroy;
begin
  LiberaRegistros;
  inherited;
end;

procedure TBloco_E.CriaRegistros;
begin
  FRegistroE001 := TRegistroE001.Create;
  FRegistroE100 := TRegistroE100.Create;
  FRegistroE110 := TRegistroE110.Create;
  FRegistroE111 := TRegistroE111List.Create;
  FRegistroE112 := TRegistroE112List.Create;
  FRegistroE113 := TRegistroE113List.Create;
  FRegistroE115 := TRegistroE115List.Create;
  FRegistroE116 := TRegistroE116List.Create;
  FRegistroE200 := TRegistroE200List.Create;
  FRegistroE210 := TRegistroE210List.Create;
  FRegistroE220 := TRegistroE220List.Create;
  FRegistroE230 := TRegistroE230List.Create;
  FRegistroE240 := TRegistroE240List.Create;
  FRegistroE250 := TRegistroE250List.Create;
  FRegistroE500 := TRegistroE500List.Create;
  FRegistroE510 := TRegistroE510List.Create;
  FRegistroE520 := TRegistroE520List.Create;
  FRegistroE530 := TRegistroE530List.Create;
  FRegistroE990 := TRegistroE990.Create;

  FRegistroE990.QTD_LIN_E := 0;
end;

procedure TBloco_E.LiberaRegistros;
begin
  FRegistroE001.Free;
  FRegistroE100.Free;
  FRegistroE110.Free;
  FRegistroE111.Free;
  FRegistroE112.Free;
  FRegistroE113.Free;
  FRegistroE115.Free;
  FRegistroE116.Free;
  FRegistroE200.Free;
  FRegistroE210.Free;
  FRegistroE220.Free;
  FRegistroE230.Free;
  FRegistroE240.Free;
  FRegistroE250.Free;
  FRegistroE500.Free;
  FRegistroE510.Free;
  FRegistroE520.Free;
  FRegistroE530.Free;
  FRegistroE990.Free;
end;

procedure TBloco_E.LimpaRegistros;
begin
  /// Limpa os Registros
  LiberaRegistros;
  /// Recriar os Registros Limpos
  CriaRegistros;
end;

function TBloco_E.WriteRegistroE001: AnsiString;
begin
  Result := '';

  if Assigned(RegistroE001) then
  begin
     with RegistroE001 do
     begin
       Check(((IND_MOV = 0) or (IND_MOV = 1)), 'BLOCO E - REGISTROE001: Na abertura do bloco, deve ser informado o número 0 ou 1!');
       ///
       Result := LFill('E001') +
                 LFill(IND_MOV, 0) +
                 Delimitador +
                 #13#10;
       ///
       RegistroE990.QTD_LIN_E := RegistroE990.QTD_LIN_E + 1;
     end;
  end;
end;

function TBloco_E.WriteRegistroE100: AnsiString;
begin
  Result := '';

  if Assigned(RegistroE100) then
  begin
     with RegistroE100 do
     begin
       Result := LFill('E100') +
                 LFill(DT_INI) +
                 LFill(DT_FIN) +
                 Delimitador +
                 #13#10;
       ///
       RegistroE990.QTD_LIN_E := RegistroE990.QTD_LIN_E + 1;
     end;
  end;
end;

function TBloco_E.WriteRegistroE110: AnsiString;
begin
  Result := '';

  if Assigned(RegistroE110) then
  begin
     with RegistroE110 do
     begin
       Result := LFill('E110') +
                 LFill(VL_TOT_DEBITOS,0) +
                 LFill(VL_AJ_DEBITOS,0) +
                 LFill(VL_TOT_AJ_DEBITOS,0) +
                 LFill(VL_ESTORNOS_CRED,0) +
                 LFill(VL_TOT_CREDITOS,0) +
                 LFill(VL_AJ_CREDITOS,0) +
                 LFill(VL_TOT_AJ_CREDITOS,0) +
                 LFill(VL_ESTORNOS_DEB,0) +
                 LFill(VL_SLD_CREDOR_ANT,0) +
                 LFill(VL_SLD_APURADO,0) +
                 LFill(VL_TOT_DED,0) +
                 LFill(VL_ICMS_RECOLHER,0) +
                 LFill(VL_SLD_CREDOR_TRANSPORTAR,0) +
                 LFill(DEB_ESP,0) +
                 Delimitador +
                 #13#10;
       ///
       RegistroE990.QTD_LIN_E := RegistroE990.QTD_LIN_E + 1;
     end;
  end;
end;

function TBloco_E.WriteRegistroE111: AnsiString;
var
intFor: integer;
strRegistroE111: AnsiString;
begin
  strRegistroE111 := '';

  if Assigned( RegistroE111 ) then
  begin
     for intFor := 0 to RegistroE111.Count - 1 do
     begin
        with RegistroE111.Items[intFor] do
        begin
          strRegistroE111 := strRegistroE111 + LFill('E111') +
                                               LFill( COD_AJ_APUR ) +
                                               LFill( DESCR_COMPL_AJ ) +
                                               LFill( VL_AJ_APUR,0 ) +
                                               Delimitador +
                                               #13#10;
        end;
        RegistroE990.QTD_LIN_E := RegistroE990.QTD_LIN_E + 1;
     end;
  end;
  Result := strRegistroE111;
end;

function TBloco_E.WriteRegistroE112: AnsiString;
var
intFor: integer;
strRegistroE112: AnsiString;
begin
  strRegistroE112 := '';

  if Assigned( RegistroE112 ) then
  begin
     for intFor := 0 to RegistroE112.Count - 1 do
     begin
        with RegistroE112.Items[intFor] do
        begin
          strRegistroE112 := strRegistroE112 + LFill('E112') +
                                               LFill( NUM_DA ) +
                                               LFill( NUM_PROC ) +
                                               LFill( IND_PROC ) +
                                               LFill( PROC ) +
                                               LFill( TXT_COMPL ) +
                                               Delimitador +
                                               #13#10;
        end;
        RegistroE990.QTD_LIN_E := RegistroE990.QTD_LIN_E + 1;
     end;
  end;
  Result := strRegistroE112;
end;

function TBloco_E.WriteRegistroE113: AnsiString;
var
intFor: integer;
strRegistroE113: AnsiString;
begin
  strRegistroE113 := '';

  if Assigned( RegistroE113 ) then
  begin
     for intFor := 0 to RegistroE113.Count - 1 do
     begin
        with RegistroE113.Items[intFor] do
        begin
          strRegistroE113 := strRegistroE113 + LFill('E113') +
                                               LFill( COD_PART ) +
                                               LFill( COD_MOD ) +
                                               LFill( SER ) +
                                               LFill( SUB ) +
                                               LFill( NUM_DOC ) +
                                               LFill( DT_DOC ) +
                                               LFill( CHV_NFE ) +
                                               LFill( COD_ITEM ) +
                                               LFill( VL_AJ_ITEM,0 ) +
                                               Delimitador +
                                               #13#10;
        end;
        RegistroE990.QTD_LIN_E := RegistroE990.QTD_LIN_E + 1;
     end;
  end;
  Result := strRegistroE113;
end;

function TBloco_E.WriteRegistroE115: AnsiString;
var
intFor: integer;
strRegistroE115: AnsiString;
begin
  strRegistroE115 := '';

  if Assigned( RegistroE115 ) then
  begin
     for intFor := 0 to RegistroE115.Count - 1 do
     begin
        with RegistroE115.Items[intFor] do
        begin
          strRegistroE115 := strRegistroE115 + LFill('E115') +
                                               LFill( COD_INF_ADIC ) +
                                               LFill( VL_INF_ADIC,0 ) +
                                               LFill( DESCR_COMPL_AJ ) +
                                               Delimitador +
                                               #13#10;
        end;
        RegistroE990.QTD_LIN_E := RegistroE990.QTD_LIN_E + 1;
     end;
  end;
  Result := strRegistroE115;
end;

function TBloco_E.WriteRegistroE116: AnsiString;
var
intFor: integer;
strRegistroE116: AnsiString;
begin
  strRegistroE116 := '';

  if Assigned( RegistroE116 ) then
  begin
     for intFor := 0 to RegistroE116.Count - 1 do
     begin
        with RegistroE116.Items[intFor] do
        begin
          strRegistroE116 := strRegistroE116 + LFill('E116') +
                                               LFill( COD_OR ) +
                                               LFill( VL_OR,0 ) +
                                               LFill( DT_VCTO ) +
                                               LFill( COD_REC ) +
                                               LFill( NUM_PROC ) +
                                               LFill( IND_PROC ) +
                                               LFill( PROC ) +
                                               LFill( TXT_COMPL ) +
                                               Delimitador +
                                               #13#10;
        end;
        RegistroE990.QTD_LIN_E := RegistroE990.QTD_LIN_E + 1;
     end;
  end;
  Result := strRegistroE116;
end;

function TBloco_E.WriteRegistroE200: AnsiString;
var
intFor: integer;
strRegistroE200: AnsiString;
begin
  strRegistroE200 := '';

  if Assigned( RegistroE200 ) then
  begin
     for intFor := 0 to RegistroE200.Count - 1 do
     begin
        with RegistroE200.Items[intFor] do
        begin
          strRegistroE200 := strRegistroE200 + LFill('E200') +
                                               LFill( UF ) +
                                               LFill( DT_INI ) +
                                               LFill( DT_FIN ) +
                                               Delimitador +
                                               #13#10;
        end;
        RegistroE990.QTD_LIN_E := RegistroE990.QTD_LIN_E + 1;
     end;
  end;
  Result := strRegistroE200;
end;

function TBloco_E.WriteRegistroE210: AnsiString;
var
intFor: integer;
strRegistroE210: AnsiString;
begin
  strRegistroE210 := '';

  if Assigned( RegistroE210 ) then
  begin
     for intFor := 0 to RegistroE210.Count - 1 do
     begin
        with RegistroE210.Items[intFor] do
        begin
          strRegistroE210 := strRegistroE210 + LFill('E210') +
                                               LFill( IND_MOV_ST ) +
                                               LFill( VL_SLD_CRED_ANT_ST,0 ) +
                                               LFill( VL_DEVOL_ST, 0 ) +
                                               LFill( VL_RESSARC_ST, 0 ) +
                                               LFill( VL_OUT_CRED_ST, 0 ) +
                                               LFill( VL_AJ_CREDITOS_ST, 0 ) +
                                               LFill( VL_RETENCAO_ST, 0 ) +
                                               LFill( VL_OUT_DEB_ST, 0 ) +
                                               LFill( VL_AJ_DEBITOS_ST, 0 ) +
                                               LFill( VL_SLD_DEV_ANT_ST, 0 ) +
                                               LFill( VL_DEDUCOES_ST, 0 ) +
                                               LFill( VL_ICMS_RECOL_ST, 0 ) +
                                               LFill( VL_SLD_CRED_ST_TRANSPORTAR, 0 ) +
                                               LFill( DEB_ESP_ST, 0 ) +
                                               Delimitador +
                                               #13#10;
        end;
        RegistroE990.QTD_LIN_E := RegistroE990.QTD_LIN_E + 1;
     end;
  end;
  Result := strRegistroE210;
end;

function TBloco_E.WriteRegistroE220: AnsiString;
var
intFor: integer;
strRegistroE220: AnsiString;
begin
  strRegistroE220 := '';

  if Assigned( RegistroE220 ) then
  begin
     for intFor := 0 to RegistroE220.Count - 1 do
     begin
        with RegistroE220.Items[intFor] do
        begin
          strRegistroE220 := strRegistroE220 + LFill('E220') +
                                               LFill( COD_AJ_APUR ) +
                                               LFill( DESCR_COMPL_AJ ) +
                                               LFill( VL_AJ_APUR,0 ) +
                                               Delimitador +
                                               #13#10;
        end;
        RegistroE990.QTD_LIN_E := RegistroE990.QTD_LIN_E + 1;
     end;
  end;
  Result := strRegistroE220;
end;

function TBloco_E.WriteRegistroE230: AnsiString;
var
intFor: integer;
strRegistroE230: AnsiString;
begin
  strRegistroE230 := '';

  if Assigned( RegistroE230 ) then
  begin
     for intFor := 0 to RegistroE230.Count - 1 do
     begin
        with RegistroE230.Items[intFor] do
        begin
          strRegistroE230 := strRegistroE230 + LFill('E230') +
                                               LFill( NUM_DA ) +
                                               LFill( NUM_PROC ) +
                                               LFill( IND_PROC ) +
                                               LFill( PROC ) +
                                               LFill( TXT_COMPL ) +
                                               Delimitador +
                                               #13#10;
        end;
        RegistroE990.QTD_LIN_E := RegistroE990.QTD_LIN_E + 1;
     end;
  end;
  Result := strRegistroE230;
end;

function TBloco_E.WriteRegistroE240: AnsiString;
var
intFor: integer;
strRegistroE240: AnsiString;
begin
  strRegistroE240 := '';

  if Assigned( RegistroE240 ) then
  begin
     for intFor := 0 to RegistroE240.Count - 1 do
     begin
        with RegistroE240.Items[intFor] do
        begin
          strRegistroE240 := strRegistroE240 + LFill('E240') +
                                               LFill( COD_PART ) +
                                               LFill( COD_MOD ) +
                                               LFill( SER ) +
                                               LFill( SUB ) +
                                               LFill( NUM_DOC ) +
                                               LFill( DT_DOC ) +
                                               LFill( CHV_NFE ) +
                                               LFill( COD_ITEM ) +
                                               LFill( VL_AJ_ITEM,0 ) +
                                               Delimitador +
                                               #13#10;
        end;
        RegistroE990.QTD_LIN_E := RegistroE990.QTD_LIN_E + 1;
     end;
  end;
  Result := strRegistroE240;
end;

function TBloco_E.WriteRegistroE250: AnsiString;
var
intFor: integer;
strRegistroE250: AnsiString;
begin
  strRegistroE250 := '';

  if Assigned( RegistroE250 ) then
  begin
     for intFor := 0 to RegistroE250.Count - 1 do
     begin
        with RegistroE250.Items[intFor] do
        begin
          strRegistroE250 := strRegistroE250 + LFill('E250') +
                                               LFill( COD_OR ) +
                                               LFill( VL_OR,0 ) +
                                               LFill( DT_VCTO ) +
                                               LFill( COD_REC ) +
                                               LFill( NUM_PROC ) +
                                               LFill( IND_PROC ) +
                                               LFill( PROC ) +
                                               LFill( TXT_COMPL ) +
                                               Delimitador +
                                               #13#10;
        end;
        RegistroE990.QTD_LIN_E := RegistroE990.QTD_LIN_E + 1;
     end;
  end;
  Result := strRegistroE250;
end;

function TBloco_E.WriteRegistroE500: AnsiString;
var
intFor: integer;
strRegistroE500: AnsiString;
begin
  strRegistroE500 := '';

  if Assigned( RegistroE500 ) then
  begin
     for intFor := 0 to RegistroE500.Count - 1 do
     begin
        with RegistroE500.Items[intFor] do
        begin
          strRegistroE500 := strRegistroE500 + LFill('E500') +
                                               LFill( IND_APUR ) +
                                               LFill( DT_INI ) +
                                               LFill( DT_FIN ) +
                                               Delimitador +
                                               #13#10;
        end;
        RegistroE990.QTD_LIN_E := RegistroE990.QTD_LIN_E + 1;
     end;
  end;
  Result := strRegistroE500;
end;

function TBloco_E.WriteRegistroE510: AnsiString;
var
intFor: integer;
strRegistroE510: AnsiString;
begin
  strRegistroE510 := '';

  if Assigned( RegistroE510 ) then
  begin
     for intFor := 0 to RegistroE510.Count - 1 do
     begin
        with RegistroE510.Items[intFor] do
        begin
          strRegistroE510 := strRegistroE510 + LFill('E510') +
                                               LFill( CFOP,4 ) +
                                               LFill( CST_IPI,2 ) +
                                               LFill( VL_CONT_IPI,0 ) +
                                               LFill( VL_BC_IPI,0 ) +
                                               LFill( VL_IPI,0 ) +
                                               Delimitador +
                                               #13#10;
        end;
        RegistroE990.QTD_LIN_E := RegistroE990.QTD_LIN_E + 1;
     end;
  end;
  Result := strRegistroE510;
end;

function TBloco_E.WriteRegistroE520: AnsiString;
var
intFor: integer;
strRegistroE520: AnsiString;
begin
  strRegistroE520 := '';

  if Assigned( RegistroE520 ) then
  begin
     for intFor := 0 to RegistroE520.Count - 1 do
     begin
        with RegistroE520.Items[intFor] do
        begin
          strRegistroE520 := strRegistroE520 + LFill('E520') +
                                               LFill( VL_SD_ANT_IPI,0 ) +
                                               LFill( VL_DEB_IPI,0 ) +
                                               LFill( VL_CRED_IPI,0 ) +
                                               LFill( VL_OD_IPI,0 ) +
                                               LFill( VL_OC_IPI,0 ) +
                                               LFill( VL_SC_IPI,0 ) +
                                               LFill( VL_SD_IPI,0 ) +
                                               Delimitador +
                                               #13#10;
        end;
        RegistroE990.QTD_LIN_E := RegistroE990.QTD_LIN_E + 1;
     end;
  end;
  Result := strRegistroE520;
end;

function TBloco_E.WriteRegistroE530: AnsiString;
var
intFor: integer;
strRegistroE530: AnsiString;
begin
  strRegistroE530 := '';

  if Assigned( RegistroE530 ) then
  begin
     for intFor := 0 to RegistroE530.Count - 1 do
     begin
        with RegistroE530.Items[intFor] do
        begin
          strRegistroE530 := strRegistroE530 + LFill('E530') +
                                               LFill( IND_AJ ) +
                                               LFill( VL_AJ,0 ) +
                                               LFill( COD_AJ ) +
                                               LFill( IND_DOC ) +
                                               LFill( NUM_DOC ) +
                                               LFill( DESCR_AJ ) +
                                               Delimitador +
                                               #13#10;
        end;
        RegistroE990.QTD_LIN_E := RegistroE990.QTD_LIN_E + 1;
     end;
  end;
  Result := strRegistroE530;
end;

function TBloco_E.WriteRegistroE990: AnsiString;
begin
  Result := '';

  if Assigned(RegistroE990) then
  begin
     with RegistroE990 do
     begin
       QTD_LIN_E := QTD_LIN_E + 1;
       ///
       Result := LFill('E990') +
                 LFill(QTD_LIN_E,0) +
                 Delimitador +
                 #13#10;
     end;
  end;
end;

end.
