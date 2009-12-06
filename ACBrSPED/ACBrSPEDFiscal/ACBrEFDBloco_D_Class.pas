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

unit ACBrEFDBloco_D_Class;

interface

uses SysUtils, Classes, DateUtils, ACBrSped, ACBrEFDBloco_D;

type
  /// TBLOCO_D -
  TBloco_D = class(TACBrSPED)
  private
    FRegistroD001: TRegistroD001;      /// BLOCO D - RegistroD001
    FRegistroD100: TRegistroD100List;  /// BLOCO D - Lista de RegistroD100
    FRegistroD110: TRegistroD110List;  /// BLOCO D - Lista de RegistroD110
    FRegistroD120: TRegistroD120List;  /// BLOCO D - Lista de RegistroD120
    FRegistroD130: TRegistroD130List;  /// BLOCO D - Lista de RegistroD130
    FRegistroD140: TRegistroD140List;  /// BLOCO D - Lista de RegistroD140
    FRegistroD150: TRegistroD150List;  /// BLOCO D - Lista de RegistroD150
    FRegistroD160: TRegistroD160List;  /// BLOCO D - Lista de RegistroD160
    FRegistroD161: TRegistroD161List;  /// BLOCO D - Lista de RegistroD161
    FRegistroD162: TRegistroD162List;  /// BLOCO D - Lista de RegistroD162
    FRegistroD170: TRegistroD170List;  /// BLOCO D - Lista de RegistroD170
    FRegistroD180: TRegistroD180List;  /// BLOCO D - Lista de RegistroD180
    FRegistroD190: TRegistroD190List;  /// BLOCO D - Lista de RegistroD190
    FRegistroD300: TRegistroD300List;  /// BLOCO D - Lista de RegistroD300
    FRegistroD301: TRegistroD301List;  /// BLOCO D - Lista de RegistroD301
    FRegistroD310: TRegistroD310List;  /// BLOCO D - Lista de RegistroD310
    FRegistroD350: TRegistroD350List;  /// BLOCO D - Lista de RegistroD350
    FRegistroD355: TRegistroD355List;  /// BLOCO D - Lista de RegistroD355
    FRegistroD360: TRegistroD360List;  /// BLOCO D - Lista de RegistroD360
    FRegistroD365: TRegistroD365List;  /// BLOCO D - Lista de RegistroD360
    FRegistroD370: TRegistroD370List;  /// BLOCO D - Lista de RegistroD370
    FRegistroD390: TRegistroD390List;  /// BLOCO D - Lista de RegistroD390
    FRegistroD400: TRegistroD400List;  /// BLOCO D - Lista de RegistroD400
    FRegistroD410: TRegistroD410List;  /// BLOCO D - Lista de RegistroD410
    FRegistroD411: TRegistroD411List;  /// BLOCO D - Lista de RegistroD411
    FRegistroD420: TRegistroD420List;  /// BLOCO D - Lista de RegistroD420
    FRegistroD500: TRegistroD500List;  /// BLOCO D - Lista de RegistroD500
    FRegistroD990: TRegistroD990;      /// BLOCO D - RegistroD990

    FRegistroD590Count: Integer;

    function WriteRegistroD590(RegD500: TRegistroD500): AnsiString; {Jean Barreiros 04Dez2009}

    procedure CriaRegistros;
    procedure LiberaRegistros;
  public
    constructor Create(AOwner: TComponent); override; /// Create
    destructor Destroy; override; /// Destroy
    procedure LimpaRegistros;

    function WriteRegistroD001: AnsiString;
    function WriteRegistroD100: AnsiString;
    function WriteRegistroD110: AnsiString;
    function WriteRegistroD120: AnsiString;
    function WriteRegistroD130: AnsiString;
    function WriteRegistroD140: AnsiString;
    function WriteRegistroD150: AnsiString;
    function WriteRegistroD160: AnsiString;
    function WriteRegistroD161: AnsiString;
    function WriteRegistroD162: AnsiString;
    function WriteRegistroD170: AnsiString;
    function WriteRegistroD180: AnsiString;
    function WriteRegistroD190: AnsiString;
    function WriteRegistroD300: AnsiString;
    function WriteRegistroD301: AnsiString;
    function WriteRegistroD310: AnsiString;
    function WriteRegistroD350: AnsiString;
    function WriteRegistroD355: AnsiString;
    function WriteRegistroD360: AnsiString;
    function WriteRegistroD365: AnsiString;
    function WriteRegistroD370: AnsiString;
    function WriteRegistroD390: AnsiString;
    function WriteRegistroD400: AnsiString;
    function WriteRegistroD410: AnsiString;
    function WriteRegistroD411: AnsiString;
    function WriteRegistroD420: AnsiString;
    function WriteRegistroD500: AnsiString;
    function WriteRegistroD990: AnsiString;

    property RegistroD001: TRegistroD001 read FRegistroD001 write FRegistroD001;
    property RegistroD100: TRegistroD100List read FRegistroD100 write FRegistroD100;
    property RegistroD110: TRegistroD110List read FRegistroD110 write FRegistroD110;
    property RegistroD120: TRegistroD120List read FRegistroD120 write FRegistroD120;
    property RegistroD130: TRegistroD130List read FRegistroD130 write FRegistroD130;
    property RegistroD140: TRegistroD140List read FRegistroD140 write FRegistroD140;
    property RegistroD150: TRegistroD150List read FRegistroD150 write FRegistroD150;
    property RegistroD160: TRegistroD160List read FRegistroD160 write FRegistroD160;
    property RegistroD161: TRegistroD161List read FRegistroD161 write FRegistroD161;
    property RegistroD162: TRegistroD162List read FRegistroD162 write FRegistroD162;
    property RegistroD170: TRegistroD170List read FRegistroD170 write FRegistroD170;
    property RegistroD180: TRegistroD180List read FRegistroD180 write FRegistroD180;
    property RegistroD190: TRegistroD190List read FRegistroD190 write FRegistroD190;
    property RegistroD300: TRegistroD300List read FRegistroD300 write FRegistroD300;
    property RegistroD301: TRegistroD301List read FRegistroD301 write FRegistroD301;
    property RegistroD310: TRegistroD310List read FRegistroD310 write FRegistroD310;
    property RegistroD350: TRegistroD350List read FRegistroD350 write FRegistroD350;
    property RegistroD355: TRegistroD355List read FRegistroD355 write FRegistroD355;
    property RegistroD360: TRegistroD360List read FRegistroD360 write FRegistroD360;
    property RegistroD365: TRegistroD365List read FRegistroD365 write FRegistroD365;
    property RegistroD370: TRegistroD370List read FRegistroD370 write FRegistroD370;
    property RegistroD390: TRegistroD390List read FRegistroD390 write FRegistroD390;
    property RegistroD400: TRegistroD400List read FRegistroD400 write FRegistroD400;
    property RegistroD410: TRegistroD410List read FRegistroD410 write FRegistroD410;
    property RegistroD411: TRegistroD411List read FRegistroD411 write FRegistroD411;
    property RegistroD420: TRegistroD420List read FRegistroD420 write FRegistroD420;
    property RegistroD500: TRegistroD500List read FRegistroD500 write FRegistroD500;
    property RegistroD990: TRegistroD990 read FRegistroD990 write FRegistroD990;

    property RegistroD590Count: Integer read FRegistroD590Count write FRegistroD590Count; {Jean Barreiros 17Nov2009}
  end;

implementation

{ TBloco_D }

constructor TBloco_D.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  CriaRegistros;
end;

destructor TBloco_D.Destroy;
begin
  LiberaRegistros;
  inherited;
end;

procedure TBloco_D.CriaRegistros;
begin
  FRegistroD001 := TRegistroD001.Create;
  FRegistroD100 := TRegistroD100List.Create;
  FRegistroD110 := TRegistroD110List.Create;
  FRegistroD120 := TRegistroD120List.Create;
  FRegistroD130 := TRegistroD130List.Create;
  FRegistroD140 := TRegistroD140List.Create;
  FRegistroD150 := TRegistroD150List.Create;
  FRegistroD160 := TRegistroD160List.Create;
  FRegistroD161 := TRegistroD161List.Create;
  FRegistroD162 := TRegistroD162List.Create;
  FRegistroD170 := TRegistroD170List.Create;
  FRegistroD180 := TRegistroD180List.Create;
  FRegistroD190 := TRegistroD190List.Create;
  FRegistroD300 := TRegistroD300List.Create;
  FRegistroD301 := TRegistroD301List.Create;
  FRegistroD310 := TRegistroD310List.Create;
  FRegistroD350 := TRegistroD350List.Create;
  FRegistroD355 := TRegistroD355List.Create;
  FRegistroD360 := TRegistroD360List.Create;
  FRegistroD365 := TRegistroD365List.Create;
  FRegistroD370 := TRegistroD370List.Create;
  FRegistroD390 := TRegistroD390List.Create;
  FRegistroD400 := TRegistroD400List.Create;
  FRegistroD410 := TRegistroD410List.Create;
  FRegistroD411 := TRegistroD411List.Create;
  FRegistroD420 := TRegistroD420List.Create;
  FRegistroD500 := TRegistroD500List.Create;
  FRegistroD990 := TRegistroD990.Create;

  FRegistroD590Count := 0; {Jean Barreiros 04Dez2009}

  FRegistroD990.QTD_LIN_D := 0;
end;

procedure TBloco_D.LiberaRegistros;
begin
  FRegistroD001.Free;
  FRegistroD100.Free;
  FRegistroD110.Free;
  FRegistroD120.Free;
  FRegistroD130.Free;
  FRegistroD140.Free;
  FRegistroD150.Free;
  FRegistroD160.Free;
  FRegistroD161.Free;
  FRegistroD162.Free;
  FRegistroD170.Free;
  FRegistroD180.Free;
  FRegistroD190.Free;
  FRegistroD300.Free;
  FRegistroD301.Free;
  FRegistroD310.Free;
  FRegistroD350.Free;
  FRegistroD355.Free;
  FRegistroD360.Free;
  FRegistroD365.Free;
  FRegistroD370.Free;
  FRegistroD390.Free;
  FRegistroD400.Free;
  FRegistroD410.Free;
  FRegistroD411.Free;
  FRegistroD420.Free;
  FRegistroD500.Free;
  FRegistroD990.Free;
end;

procedure TBloco_D.LimpaRegistros;
begin
  /// Limpa os Registros
  LiberaRegistros;
  /// Recriar os Registros Limpos
  CriaRegistros;
end;

function TBloco_D.WriteRegistroD001: AnsiString;
begin
  Result := '';

  if Assigned(RegistroD001) then
  begin
     with RegistroD001 do
     begin
       Check(((IND_MOV = 0) or (IND_MOV = 1)), 'BLOCO D - REGISTROD001: Na abertura do bloco, deve ser informado o número 0 ou 1!');
       ///
       Result := LFill('D001') +
                 LFill(IND_MOV, 0) +
                 Delimitador +
                 #13#10;
       ///
       RegistroD990.QTD_LIN_D := RegistroD990.QTD_LIN_D + 1;
     end;
  end;
end;

function TBloco_D.WriteRegistroD100: AnsiString;
var
intFor: integer;
strRegistroD100: AnsiString;
begin
  strRegistroD100 := '';

  if Assigned( RegistroD100 ) then
  begin
     for intFor := 0 to RegistroD100.Count - 1 do
     begin
        with RegistroD100.Items[intFor] do
        begin
          strRegistroD100 := strRegistroD100 + LFill('D100') +
                                               LFill( IND_OPER ) +
                                               LFill( IND_EMIT ) +
                                               LFill( COD_PART ) +
                                               LFill( COD_MOD ) +
                                               LFill( COD_SIT ) +
                                               LFill( SER ) +
                                               LFill( SUB ) +
                                               LFill( NUM_DOC ) +
                                               LFill( CHV_CTE ) +
                                               LFill( DT_DOC ) +
                                               LFill( DT_A_P ) +
                                               LFill( TP_CT_e ) +
                                               LFill( CHV_CTE_REF ) +
                                               LFill( VL_DOC,0,2 ) +
                                               LFill( IND_FRT ) +
                                               LFill( VL_DESC,0,2 ) +
                                               LFill( IND_FRT ) +
                                               LFill( VL_SERV,0,2 ) +
                                               LFill( VL_BC_ICMS,0,2 ) +
                                               LFill( VL_NT,0,2 ) +
                                               LFill( COD_INF ) +
                                               LFill( COD_CTA ) +
                                               Delimitador +
                                               #13#10;
        end;
       RegistroD990.QTD_LIN_D := RegistroD990.QTD_LIN_D + 1;
     end;
  end;
  Result := strRegistroD100;
end;

function TBloco_D.WriteRegistroD110: AnsiString;
var
intFor: integer;
strRegistroD110: AnsiString;
begin
  strRegistroD110 := '';

  if Assigned( RegistroD110 ) then
  begin
     for intFor := 0 to RegistroD110.Count - 1 do
     begin
        with RegistroD110.Items[intFor] do
        begin
          strRegistroD110 := strRegistroD110 + LFill('D110') +
                                               LFill( UF_ORIG ) +
                                               LFill( COD_MUN_ORIG ) +
                                               LFill( UF_DEST ) +
                                               LFill( COD_MUN_DEST ) +
                                               LFill( COD_LINHA ) +
                                               LFill( LINHA ) +
                                               LFill( POLT_CAB ) +
                                               LFill( AGENTE ) +
                                               Delimitador +
                                               #13#10;
        end;
       RegistroD990.QTD_LIN_D := RegistroD990.QTD_LIN_D + 1;
     end;
  end;
  Result := strRegistroD110;
end;

function TBloco_D.WriteRegistroD120: AnsiString;
var
intFor: integer;
strRegistroD120: AnsiString;
begin
  strRegistroD120 := '';

  if Assigned( RegistroD120 ) then
  begin
     for intFor := 0 to RegistroD120.Count - 1 do
     begin
        with RegistroD120.Items[intFor] do
        begin
          strRegistroD120 := strRegistroD120 + LFill('D120') +
                                               LFill( COD_MUN_ORIG ) +
                                               LFill( COD_MUN_DEST ) +
                                               LFill( VEIC_ID ) +
                                               LFill( UF_ID ) +
                                               Delimitador +
                                               #13#10;
        end;
       RegistroD990.QTD_LIN_D := RegistroD990.QTD_LIN_D + 1;
     end;
  end;
  Result := strRegistroD120;
end;

function TBloco_D.WriteRegistroD130: AnsiString;
var
intFor: integer;
strRegistroD130: AnsiString;
begin
  strRegistroD130 := '';

  if Assigned( RegistroD130 ) then
  begin
     for intFor := 0 to RegistroD130.Count - 1 do
     begin
        with RegistroD130.Items[intFor] do
        begin
          strRegistroD130 := strRegistroD130 + LFill('D130') +
                                               LFill( COD_PART_CONSG ) +
                                               LFill( COD_PART_RED ) +
                                               LFill( IND_FRT_RED ) +
                                               LFill( COD_MUN_ORIG ) +
                                               LFill( COD_MUN_DEST ) +
                                               LFill( VEIC_ID ) +
                                               LFill( VL_LIQ_FRT,0,2 ) +
                                               LFill( VL_SEC_CAT,0,2 ) +
                                               LFill( VL_DESP,0,2 ) +
                                               LFill( VL_DESP,0,2 ) +
                                               LFill( VL_PEDG,0,2 ) +
                                               LFill( VL_OUT,0,2 ) +
                                               LFill( VL_FRT,0,2 ) +
                                               LFill( UF_ID ) +
                                               Delimitador +
                                               #13#10;
        end;
       RegistroD990.QTD_LIN_D := RegistroD990.QTD_LIN_D + 1;
     end;
  end;
  Result := strRegistroD130;
end;

function TBloco_D.WriteRegistroD140: AnsiString;
var
intFor: integer;
strRegistroD140: AnsiString;
begin
  strRegistroD140 := '';

  if Assigned( RegistroD140 ) then
  begin
     for intFor := 0 to RegistroD140.Count - 1 do
     begin
        with RegistroD140.Items[intFor] do
        begin
          strRegistroD140 := strRegistroD140 + LFill('D140') +
                                               LFill( COD_PART_CONSG ) +
                                               LFill( COD_MUN_ORIG ) +
                                               LFill( COD_MUN_DEST ) +
                                               LFill( IND_VEIC ) +
                                               LFill( VEIC_ID ) +
                                               LFill( IND_NAV ) +
                                               LFill( VIAGEM ) +
                                               LFill( VL_FRT_LIQ,0,2 ) +
                                               LFill( VL_DESP_PORT,0,2 ) +
                                               LFill( VL_DESP_CAR_DESC,0,2 ) +
                                               LFill( VL_OUT,0,2 ) +
                                               LFill( VL_FRT_BRT,0,2 ) +
                                               LFill( VL_FRT_MM,0,2 ) +
                                               Delimitador +
                                               #13#10;
        end;
        RegistroD990.QTD_LIN_D := RegistroD990.QTD_LIN_D + 1;
     end;
  end;
  Result := strRegistroD140;
end;

function TBloco_D.WriteRegistroD150: AnsiString;
var
intFor: integer;
strRegistroD150: AnsiString;
begin
  strRegistroD150 := '';

  if Assigned( RegistroD150 ) then
  begin
     for intFor := 0 to RegistroD150.Count - 1 do
     begin
        with RegistroD150.Items[intFor] do
        begin
          strRegistroD150 := strRegistroD150 + LFill('D150') +
                                               LFill( COD_MUN_ORIG ) +
                                               LFill( COD_MUN_DEST ) +
                                               LFill( VEIC_ID ) +
                                               LFill( VIAGEM ) +
                                               LFill( IND_TFA ) +
                                               LFill( VL_PESO_TX,0,2 ) +
                                               LFill( VL_TX_TERR,0,2 ) +
                                               LFill( VL_TX_RED,0,2 ) +
                                               LFill( VL_OUT,0,2 ) +
                                               LFill( VL_TX_ADV,0,2 ) +
                                               Delimitador +
                                               #13#10;
        end;
        RegistroD990.QTD_LIN_D := RegistroD990.QTD_LIN_D + 1;
     end;
  end;
  Result := strRegistroD150;
end;

function TBloco_D.WriteRegistroD160: AnsiString;
var
intFor: integer;
strRegistroD160: AnsiString;
begin
  strRegistroD160 := '';

  if Assigned( RegistroD160 ) then
  begin
     for intFor := 0 to RegistroD160.Count - 1 do
     begin
        with RegistroD160.Items[intFor] do
        begin
          strRegistroD160 := strRegistroD160 + LFill('D160') +
                                               LFill( DESPACHO ) +
                                               LFill( CNPJ_CPF_REM ) +
                                               LFill( IE_REM ) +
                                               LFill( COD_MUN_ORI ) +
                                               LFill( CNPJ_CPF_DEST ) +
                                               LFill( IE_DEST ) +
                                               LFill( COD_MUN_DEST ) +
                                               Delimitador +
                                               #13#10;
        end;
        RegistroD990.QTD_LIN_D := RegistroD990.QTD_LIN_D + 1;
     end;
  end;
  Result := strRegistroD160;
end;

function TBloco_D.WriteRegistroD161: AnsiString;
var
intFor: integer;
strRegistroD161: AnsiString;
begin
  strRegistroD161 := '';

  if Assigned( RegistroD161 ) then
  begin
     for intFor := 0 to RegistroD161.Count - 1 do
     begin
        with RegistroD161.Items[intFor] do
        begin
          strRegistroD161 := strRegistroD161 + LFill('D161') +
                                               LFill( IND_CARGA ) +
                                               LFill( CNPJ_COL ) +
                                               LFill( IE_COL ) +
                                               LFill( COD_MUN_COL ) +
                                               LFill( CNPJ_ENTG ) +
                                               LFill( IE_ENTG ) +
                                               LFill( COD_MUN_ENTG ) +
                                               Delimitador +
                                               #13#10;
        end;
        RegistroD990.QTD_LIN_D := RegistroD990.QTD_LIN_D + 1;
     end;
  end;
  Result := strRegistroD161;
end;

function TBloco_D.WriteRegistroD162: AnsiString;
var
intFor: integer;
strRegistroD162: AnsiString;
begin
  strRegistroD162 := '';

  if Assigned( RegistroD162 ) then
  begin
     for intFor := 0 to RegistroD162.Count - 1 do
     begin
        with RegistroD162.Items[intFor] do
        begin
          strRegistroD162 := strRegistroD162 + LFill('D162') +
                                               LFill( COD_MOD ) +
                                               LFill( SER ) +
                                               LFill( NUM_DOC ) +
                                               LFill( VL_DOC,0,2 ) +
                                               LFill( VL_MERC,0,2 ) +
                                               LFill( QTD_VOL,0 ) +
                                               LFill( PESO_BRT,0,2 ) +
                                               LFill( PESO_LIQ,0,2 ) +
                                               Delimitador +
                                               #13#10;
        end;
        RegistroD990.QTD_LIN_D := RegistroD990.QTD_LIN_D + 1;
     end;
  end;
  Result := strRegistroD162;
end;

function TBloco_D.WriteRegistroD170: AnsiString;
var
intFor: integer;
strRegistroD170: AnsiString;
begin
  strRegistroD170 := '';

  if Assigned( RegistroD170 ) then
  begin
     for intFor := 0 to RegistroD170.Count - 1 do
     begin
        with RegistroD170.Items[intFor] do
        begin
          strRegistroD170 := strRegistroD170 + LFill('D170') +
                                               LFill( COD_PART_CONSG ) +
                                               LFill( COD_PART_RED ) +
                                               LFill( COD_MUN_ORIG ) +
                                               LFill( COD_MUN_DEST ) +
                                               LFill( OTM ) +
                                               LFill( IND_NAT_FRT ) +
                                               LFill( VL_LIQ_FRT,0,2 ) +
                                               LFill( VL_GRIS,0,2 ) +
                                               LFill( VL_PDG,0,2 ) +
                                               LFill( VL_OUT,0,2 ) +
                                               LFill( VL_FRT,0,2 ) +
                                               LFill( VL_FRT,0,2 ) +
                                               LFill( UF_ID ) +
                                               Delimitador +
                                               #13#10;
        end;
        RegistroD990.QTD_LIN_D := RegistroD990.QTD_LIN_D + 1;
     end;
  end;
  Result := strRegistroD170;
end;

function TBloco_D.WriteRegistroD180: AnsiString;
var
intFor: integer;
strRegistroD180: AnsiString;
begin
  strRegistroD180 := '';

  if Assigned( RegistroD180 ) then
  begin
     for intFor := 0 to RegistroD180.Count - 1 do
     begin
        with RegistroD180.Items[intFor] do
        begin
          strRegistroD180 := strRegistroD180 + LFill('D180') +
                                               LFill( NUM_SEQ ) +
                                               LFill( IND_EMIT ) +
                                               LFill( CNPJ_EMIT ) +
                                               LFill( UF_EMIT ) +
                                               LFill( IE_EMIT ) +
                                               LFill( COD_MUN_ORIG ) +
                                               LFill( CNPJ_CPF_TOM ) +
                                               LFill( UF_TOM ) +
                                               LFill( IE_TOM ) +
                                               LFill( COD_MUN_DEST ) +
                                               LFill( COD_MOD ) +
                                               LFill( SER ) +
                                               LFill( SUB ) +
                                               LFill( NUM_DOC ) +
                                               LFill( DT_DOC ) +
                                               LFill( VL_DOC,0,2 ) +
                                               Delimitador +
                                               #13#10;
        end;
        RegistroD990.QTD_LIN_D := RegistroD990.QTD_LIN_D + 1;
     end;
  end;
  Result := strRegistroD180;
end;

function TBloco_D.WriteRegistroD190: AnsiString;
var
intFor: integer;
strRegistroD190: AnsiString;
begin
  strRegistroD190 := '';

  if Assigned( RegistroD190 ) then
  begin
     for intFor := 0 to RegistroD190.Count - 1 do
     begin
        with RegistroD190.Items[intFor] do
        begin
          strRegistroD190 := strRegistroD190 + LFill('D190') +
                                               LFill( CST_ICMS ) +
                                               LFill( CFOP ) +
                                               LFill( ALIQ_ICMS,0,2 ) +
                                               LFill( VL_OPR,0,2 ) +
                                               LFill( VL_BC_ICMS,0,2 ) +
                                               LFill( VL_ICMS,0,2 ) +
                                               LFill( VL_RED_BC,0,2 ) +
                                               LFill( COD_OBS ) +
                                               Delimitador +
                                               #13#10;
        end;
        RegistroD990.QTD_LIN_D := RegistroD990.QTD_LIN_D + 1;
     end;
  end;
  Result := strRegistroD190;
end;

function TBloco_D.WriteRegistroD300: AnsiString;
var
intFor: integer;
strRegistroD300: AnsiString;
begin
  strRegistroD300 := '';

  if Assigned( RegistroD300 ) then
  begin
     for intFor := 0 to RegistroD300.Count - 1 do
     begin
        with RegistroD300.Items[intFor] do
        begin
          strRegistroD300 := strRegistroD300 + LFill('D300') +
                                               LFill( COD_MOD ) +
                                               LFill( SER ) +
                                               LFill( SUB ) +
                                               LFill( NUM_DOC_INI ) +
                                               LFill( NUM_DOC_FIN ) +
                                               LFill( CST_ICMS ) +
                                               LFill( CFOP ) +
                                               LFill( ALIQ_ICMS,0,2 ) +
                                               LFill( DT_DOC ) +
                                               LFill( VL_OPR,0,2 ) +
                                               LFill( VL_DESC,0,2 ) +
                                               LFill( VL_SERV,0,2 ) +
                                               LFill( VL_SEG,0,2 ) +
                                               LFill( VL_OUT_DESP,0,2 ) +
                                               LFill( VL_BC_ICMS,0,2 ) +
                                               LFill( VL_RED_BC,0,2 ) +
                                               LFill( COD_OBS ) +
                                               LFill( COD_CTA ) +
                                               Delimitador +
                                               #13#10;
        end;
        RegistroD990.QTD_LIN_D := RegistroD990.QTD_LIN_D + 1;
     end;
  end;
  Result := strRegistroD300;
end;

function TBloco_D.WriteRegistroD301: AnsiString;
var
intFor: integer;
strRegistroD301: AnsiString;
begin
  strRegistroD301 := '';

  if Assigned( RegistroD301 ) then
  begin
     for intFor := 0 to RegistroD301.Count - 1 do
     begin
        with RegistroD301.Items[intFor] do
        begin
          strRegistroD301 := strRegistroD301 + LFill('D301') +
                                               LFill( NUM_DOC_CANC ) +
                                               Delimitador +
                                               #13#10;
        end;
        RegistroD990.QTD_LIN_D := RegistroD990.QTD_LIN_D + 1;
     end;
  end;
  Result := strRegistroD301;
end;

function TBloco_D.WriteRegistroD310: AnsiString;
var
intFor: integer;
strRegistroD310: AnsiString;
begin
  strRegistroD310 := '';

  if Assigned( RegistroD310 ) then
  begin
     for intFor := 0 to RegistroD310.Count - 1 do
     begin
        with RegistroD310.Items[intFor] do
        begin
          strRegistroD310 := strRegistroD310 + LFill('D310') +
                                               LFill( COD_MUN_ORIG ) +
                                               LFill( VL_SERV,0,2 ) +
                                               LFill( VL_BC_ICMS,0,2 ) +
                                               LFill( VL_ICMS,0,2 ) +
                                               Delimitador +
                                               #13#10;
        end;
        RegistroD990.QTD_LIN_D := RegistroD990.QTD_LIN_D + 1;
     end;
  end;
  Result := strRegistroD310;
end;

function TBloco_D.WriteRegistroD350: AnsiString;
var
intFor: integer;
strRegistroD350: AnsiString;
begin
  strRegistroD350 := '';

  if Assigned( RegistroD350 ) then
  begin
     for intFor := 0 to RegistroD350.Count - 1 do
     begin
        with RegistroD350.Items[intFor] do
        begin
          strRegistroD350 := strRegistroD350 + LFill('D350') +
                                               LFill( COD_MOD ) +
                                               LFill( ECF_MOD ) +
                                               LFill( ECF_FAB ) +
                                               LFill( ECF_CX ) +
                                               Delimitador +
                                               #13#10;
        end;
        RegistroD990.QTD_LIN_D := RegistroD990.QTD_LIN_D + 1;
     end;
  end;
  Result := strRegistroD350;
end;

function TBloco_D.WriteRegistroD355: AnsiString;
var
intFor: integer;
strRegistroD355: AnsiString;
begin
  strRegistroD355 := '';

  if Assigned( RegistroD355 ) then
  begin
     for intFor := 0 to RegistroD355.Count - 1 do
     begin
        with RegistroD355.Items[intFor] do
        begin
          strRegistroD355 := strRegistroD355 + LFill('D355') +
                                               LFill( DT_DOC ) +
                                               LFill( CRO ) +
                                               LFill( CRZ ) +
                                               LFill( NUM_COO_FIN ) +
                                               LFill( GT_FIN,0,2 ) +
                                               LFill( VL_BRT,0,2 ) +
                                               Delimitador +
                                               #13#10;
        end;
        RegistroD990.QTD_LIN_D := RegistroD990.QTD_LIN_D + 1;
     end;
  end;
  Result := strRegistroD355;
end;

function TBloco_D.WriteRegistroD360: AnsiString;
var
intFor: integer;
strRegistroD360: AnsiString;
begin
  strRegistroD360 := '';

  if Assigned( RegistroD360 ) then
  begin
     for intFor := 0 to RegistroD360.Count - 1 do
     begin
        with RegistroD360.Items[intFor] do
        begin
          strRegistroD360 := strRegistroD360 + LFill('D360') +
                                               LFill( VL_PIS,0,2 ) +
                                               LFill( VL_COFINS,0,2 ) +
                                               Delimitador +
                                               #13#10;
        end;
        RegistroD990.QTD_LIN_D := RegistroD990.QTD_LIN_D + 1;
     end;
  end;
  Result := strRegistroD360;
end;

function TBloco_D.WriteRegistroD365: AnsiString;
var
intFor: integer;
strRegistroD365: AnsiString;
begin
  strRegistroD365 := '';

  if Assigned( RegistroD365 ) then
  begin
     for intFor := 0 to RegistroD365.Count - 1 do
     begin
        with RegistroD365.Items[intFor] do
        begin
          strRegistroD365 := strRegistroD365 + LFill('D365') +
                                               LFill( COD_TOT_PAR ) +
                                               LFill( VLR_ACUM_TOT,0,2 ) +
                                               LFill( NR_TOT ) +
                                               LFill( DESCR_NR_TOT ) +
                                               Delimitador +
                                               #13#10;
        end;
        RegistroD990.QTD_LIN_D := RegistroD990.QTD_LIN_D + 1;
     end;
  end;
  Result := strRegistroD365;
end;

function TBloco_D.WriteRegistroD370: AnsiString;
var
intFor: integer;
strRegistroD370: AnsiString;
begin
  strRegistroD370 := '';

  if Assigned( RegistroD370 ) then
  begin
     for intFor := 0 to RegistroD370.Count - 1 do
     begin
        with RegistroD370.Items[intFor] do
        begin
          strRegistroD370 := strRegistroD370 + LFill('D370') +
                                               LFill( COD_MUN_ORIG ) +
                                               LFill( VL_SERV,0,2 ) +
                                               LFill( QTD_BILH,0 ) +
                                               LFill( VL_BC_ICMS,0,2 ) +
                                               LFill( VL_ICMS,0,2 ) +
                                               Delimitador +
                                               #13#10;
        end;
        RegistroD990.QTD_LIN_D := RegistroD990.QTD_LIN_D + 1;
     end;
  end;
  Result := strRegistroD370;
end;

function TBloco_D.WriteRegistroD390: AnsiString;
var
intFor: integer;
strRegistroD390: AnsiString;
begin
  strRegistroD390 := '';

  if Assigned( RegistroD390 ) then
  begin
     for intFor := 0 to RegistroD390.Count - 1 do
     begin
        with RegistroD390.Items[intFor] do
        begin
          strRegistroD390 := strRegistroD390 + LFill('D390') +
                                               LFill( CST_ICMS ) +
                                               LFill( CFOP ) +
                                               LFill( ALIQ_ICMS,0,2 ) +
                                               LFill( VL_OPR,0,2 ) +
                                               LFill( VL_BC_ISSQN,0,2 ) +
                                               LFill( ALIQ_ISSQN,0,2 ) +
                                               LFill( VL_ISSQN,0,2 ) +
                                               LFill( VL_BC_ICMS,0,2 ) +
                                               LFill( VL_ICMS,0,2 ) +
                                               LFill( COD_OBS ) +
                                               Delimitador +
                                               #13#10;
        end;
        RegistroD990.QTD_LIN_D := RegistroD990.QTD_LIN_D + 1;
     end;
  end;
  Result := strRegistroD390;
end;

function TBloco_D.WriteRegistroD400: AnsiString;
var
intFor: integer;
strRegistroD400: AnsiString;
begin
  strRegistroD400 := '';

  if Assigned( RegistroD400 ) then
  begin
     for intFor := 0 to RegistroD400.Count - 1 do
     begin
        with RegistroD400.Items[intFor] do
        begin
          strRegistroD400 := strRegistroD400 + LFill('D400') +
                                               LFill( COD_PART ) +
                                               LFill( COD_MOD ) +
                                               LFill( COD_SIT ) +
                                               LFill( SER ) +
                                               LFill( SUB ) +
                                               LFill( NUM_DOC ) +
                                               LFill( DT_DOC ) +
                                               LFill( VL_DOC,0,2 ) +
                                               LFill( VL_DESC,0,2 ) +
                                               LFill( VL_SERV,0,2 ) +
                                               LFill( VL_BC_ICMS,0,2 ) +
                                               LFill( VL_ICMS,0,2 ) +
                                               LFill( VL_PIS,0,2 ) +
                                               LFill( VL_COFINS,0,2 ) +
                                               LFill( COD_CTA ) +
                                               Delimitador +
                                               #13#10;
        end;
        RegistroD990.QTD_LIN_D := RegistroD990.QTD_LIN_D + 1;
     end;
  end;
  Result := strRegistroD400;
end;

function TBloco_D.WriteRegistroD410: AnsiString;
var
intFor: integer;
strRegistroD410: AnsiString;
begin
  strRegistroD410 := '';

  if Assigned( RegistroD410 ) then
  begin
     for intFor := 0 to RegistroD410.Count - 1 do
     begin
        with RegistroD410.Items[intFor] do
        begin
          strRegistroD410 := strRegistroD410 + LFill('D410') +
                                               LFill( COD_MOD ) +
                                               LFill( SER ) +
                                               LFill( SUB ) +
                                               LFill( NUM_DOC_INI ) +
                                               LFill( NUM_DOC_FIN ) +
                                               LFill( DT_DOC ) +
                                               LFill( CST_ICMS ) +
                                               LFill( CFOP ) +
                                               LFill( ALIQ_ICMS,0,2 ) +
                                               LFill( VL_OPR,0,2 ) +
                                               LFill( VL_DESC,0,2 ) +
                                               LFill( VL_SERV,0,2 ) +
                                               LFill( VL_BC_ICMS,0,2 ) +
                                               LFill( VL_ICMS,0,2 ) +
                                               Delimitador +
                                               #13#10;
        end;
        RegistroD990.QTD_LIN_D := RegistroD990.QTD_LIN_D + 1;
     end;
  end;
  Result := strRegistroD410;
end;

function TBloco_D.WriteRegistroD411: AnsiString;
var
intFor: integer;
strRegistroD411: AnsiString;
begin
  strRegistroD411 := '';

  if Assigned( RegistroD411 ) then
  begin
     for intFor := 0 to RegistroD411.Count - 1 do
     begin
        with RegistroD411.Items[intFor] do
        begin
          strRegistroD411 := strRegistroD411 + LFill('D411') +
                                               LFill( NUM_DOC_CANC ) +
                                               Delimitador +
                                               #13#10;
        end;
        RegistroD990.QTD_LIN_D := RegistroD990.QTD_LIN_D + 1;
     end;
  end;
  Result := strRegistroD411;
end;

function TBloco_D.WriteRegistroD420: AnsiString;
var
intFor: integer;
strRegistroD420: AnsiString;
begin
  strRegistroD420 := '';

  if Assigned( RegistroD420 ) then
  begin
     for intFor := 0 to RegistroD420.Count - 1 do
     begin
        with RegistroD420.Items[intFor] do
        begin
          strRegistroD420 := strRegistroD420 + LFill('D420') +
                                               LFill( COD_MUN_ORIG ) +
                                               LFill( VL_SERV,0,2 ) +
                                               LFill( VL_BC_ICMS,0,2 ) +
                                               LFill( VL_ICMS,0,2 ) +
                                               Delimitador +
                                               #13#10;
        end;
        RegistroD990.QTD_LIN_D := RegistroD990.QTD_LIN_D + 1;
     end;
  end;
  Result := strRegistroD420;
end;

function TBloco_D.WriteRegistroD500: AnsiString;
var
intFor: integer;
strRegistroD500: AnsiString;
begin
  strRegistroD500 := '';

  if Assigned( RegistroD500 ) then
  begin
     for intFor := 0 to RegistroD500.Count - 1 do
     begin
        with RegistroD500.Items[intFor] do
        begin
          strRegistroD500 := strRegistroD500 + LFill('D500') +
                                               LFill( IND_OPER ) +
                                               LFill( IND_EMIT ) +
                                               LFill( COD_PART ) +
                                               LFill( COD_MOD ) +
                                               LFill( COD_SIT ) +
                                               LFill( SER ) +
                                               LFill( SUB ) +
                                               LFill( NUM_DOC ) +
                                               LFill( DT_DOC ) +
                                               LFill( DT_A_P ) +
                                               LFill( VL_DOC,0,2 ) +
                                               LFill( VL_DESC,0,2 ) +
                                               LFill( VL_SERV,0,2 ) +
                                               LFill( VL_SERV_NT,0,2 ) +
                                               LFill( VL_TERC,0,2 ) +
                                               LFill( VL_DA,0,2 ) +
                                               LFill( VL_BC_ICMS,0,2 ) +
                                               LFill( VL_ICMS,0,2 ) +
                                               LFill( COD_INF ) +
                                               LFill( VL_PIS,0,2 ) +
                                               LFill( VL_COFINS,0,2 ) +
                                               LFill( COD_CTA ) +
                                               Delimitador +
                                               #13#10;
        end;
        /// Registros FILHOS
        strRegistroD500 := strRegistroD500 +
                           WriteRegistroD590( RegistroD500.Items[intFor] );

        RegistroD990.QTD_LIN_D := RegistroD990.QTD_LIN_D + 1;
     end;
  end;
  Result := strRegistroD500;
end;

function TBloco_D.WriteRegistroD590(RegD500: TRegistroD500): AnsiString;
var
intFor: integer;
strRegistroD590: AnsiString;
begin
  strRegistroD590 := '';

  if Assigned( RegD500.RegistroD590 ) then
  begin
     for intFor := 0 to RegD500.RegistroD590.Count - 1 do
     begin
        with RegD500.RegistroD590.Items[intFor] do
        begin
          strRegistroD590 := strRegistroD590 + LFill('D590') +
                                               LFill( CST_ICMS,3 ) +
                                               LFill( CFOP,4 ) +
                                               LFill( ALIQ_ICMS,6,2 ) +
                                               LFill( VL_OPR,0,2 ) +
                                               LFill( VL_BC_ICMS,0,2 ) +
                                               LFill( VL_ICMS,0,2 ) +
                                               LFill( VL_BC_ICMS_ST,0,2 ) +
                                               LFill( VL_ICMS_ST,0,2 ) +
                                               LFill( VL_RED_BC,0,2 ) +
                                               LFill( COD_OBS  ) +
                                               Delimitador +
                                               #13#10;
        end;
        RegistroD990.QTD_LIN_D := RegistroD990.QTD_LIN_D + 1;
     end;
     /// Variavél para armazenar a quantidade de registro do tipo.
     FRegistroD590Count := FRegistroD590Count + RegD500.RegistroD590.Count;
  end;
  Result := strRegistroD590;
end;

function TBloco_D.WriteRegistroD990: AnsiString;
begin
  Result := '';

  if Assigned(RegistroD990) then
  begin
     with RegistroD990 do
     begin
       QTD_LIN_D := QTD_LIN_D + 1;
       ///
       Result := LFill('D990') +
                 LFill(QTD_LIN_D,0) +
                 Delimitador +
                 #13#10;
     end;
  end;
end;

end.
