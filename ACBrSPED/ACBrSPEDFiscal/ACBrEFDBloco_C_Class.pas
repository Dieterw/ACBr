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

unit ACBrEFDBloco_C_Class;

interface

uses SysUtils, Classes, DateUtils, ACBrSped, ACBrEFDBloco_C;

type
  /// TBLOCO_C -
  TBloco_C = class(TACBrSPED)
  private
    FRegistroC001: TRegistroC001;      /// BLOCO C - RegistroC001
    FRegistroC100: TRegistroC100List;  /// BLOCO C - Lista de RegistroC100
    FRegistroC112: TRegistroC112List;  /// BLOCO C - Lista de RegistroC112
    FRegistroC113: TRegistroC113List;  /// BLOCO C - Lista de RegistroC113
    FRegistroC114: TRegistroC114List;  /// BLOCO C - Lista de RegistroC114
    FRegistroC115: TRegistroC115List;  /// BLOCO C - Lista de RegistroC115
    FRegistroC120: TRegistroC120List;  /// BLOCO C - Lista de RegistroC120
    FRegistroC130: TRegistroC130List;  /// BLOCO C - Lista de RegistroC130
    FRegistroC160: TRegistroC160List;  /// BLOCO C - Lista de RegistroC160
    FRegistroC165: TRegistroC165List;  /// BLOCO C - Lista de RegistroC165
    FRegistroC171: TRegistroC171List;  /// BLOCO C - Lista de RegistroC171
    FRegistroC172: TRegistroC172List;  /// BLOCO C - Lista de RegistroC172
    FRegistroC173: TRegistroC173List;  /// BLOCO C - Lista de RegistroC173
    FRegistroC174: TRegistroC174List;  /// BLOCO C - Lista de RegistroC174
    FRegistroC175: TRegistroC175List;  /// BLOCO C - Lista de RegistroC175
    FRegistroC176: TRegistroC176List;  /// BLOCO C - Lista de RegistroC176
    FRegistroC177: TRegistroC177List;  /// BLOCO C - Lista de RegistroC177
    FRegistroC178: TRegistroC178List;  /// BLOCO C - Lista de RegistroC178
    FRegistroC179: TRegistroC179List;  /// BLOCO C - Lista de RegistroC179
    FRegistroC195: TRegistroC195List;  /// BLOCO C - Lista de RegistroC195
    FRegistroC197: TRegistroC197List;  /// BLOCO C - Lista de RegistroC197
    FRegistroC300: TRegistroC300List;  /// BLOCO C - Lista de RegistroC300
    FRegistroC310: TRegistroC310List;  /// BLOCO C - Lista de RegistroC310
    FRegistroC320: TRegistroC320List;  /// BLOCO C - Lista de RegistroC320
    FRegistroC321: TRegistroC321List;  /// BLOCO C - Lista de RegistroC321
    FRegistroC350: TRegistroC350List;  /// BLOCO C - Lista de RegistroC350
    FRegistroC370: TRegistroC370List;  /// BLOCO C - Lista de RegistroC370
    FRegistroC390: TRegistroC390List;  /// BLOCO C - Lista de RegistroC390
    FRegistroC400: TRegistroC400List;  /// BLOCO C - Lista de RegistroC400
    FRegistroC405: TRegistroC405List;  /// BLOCO C - Lista de RegistroC405
    FRegistroC410: TRegistroC410List;  /// BLOCO C - Lista de RegistroC410
    FRegistroC420: TRegistroC420List;  /// BLOCO C - Lista de RegistroC420
    FRegistroC425: TRegistroC425List;  /// BLOCO C - Lista de RegistroC425
    FRegistroC460: TRegistroC460List;  /// BLOCO C - Lista de RegistroC460
    FRegistroC470: TRegistroC470List;  /// BLOCO C - Lista de RegistroC470
    FRegistroC490: TRegistroC490List;  /// BLOCO C - Lista de RegistroC490
    FRegistroC495: TRegistroC495List;  /// BLOCO C - Lista de RegistroC495
    FRegistroC500: TRegistroC500List;  /// BLOCO C - Lista de RegistroC500
    FRegistroC510: TRegistroC510List;  /// BLOCO C - Lista de RegistroC510
    FRegistroC590: TRegistroC590List;  /// BLOCO C - Lista de RegistroC590
    FRegistroC600: TRegistroC600List;  /// BLOCO C - Lista de RegistroC600
    FRegistroC601: TRegistroC601List;  /// BLOCO C - Lista de RegistroC601
    FRegistroC610: TRegistroC610List;  /// BLOCO C - Lista de RegistroC610
    FRegistroC620: TRegistroC620List;  /// BLOCO C - Lista de RegistroC620
    FRegistroC690: TRegistroC690List;  /// BLOCO C - Lista de RegistroC690
    FRegistroC700: TRegistroC700List;  /// BLOCO C - Lista de RegistroC700
    FRegistroC790: TRegistroC790List;  /// BLOCO C - Lista de RegistroC790
    FRegistroC791: TRegistroC791List;  /// BLOCO C - Lista de RegistroC791
    FRegistroC990: TRegistroC990;      /// BLOCO C - RegistroC990

    FRegistroC110Count: Integer;
    FRegistroC111Count: Integer;
    FRegistroC140Count: Integer;
    FRegistroC141Count: Integer;
    FRegistroC170Count: Integer;
    FRegistroC190Count: Integer;

    function WriteRegistroC110(RegC100: TRegistroC100): AnsiString;
    function WriteRegistroC111(RegC110: TRegistroC110): AnsiString;
    function WriteRegistroC140(RegC100: TRegistroC100): AnsiString;
    function WriteRegistroC141(RegC140: TRegistroC140): AnsiString;
    function WriteRegistroC170(RegC100: TRegistroC100): AnsiString;
    function WriteRegistroC190(RegC100: TRegistroC100): AnsiString;  {Jean Barreiros 17Nov2009}

    procedure CriaRegistros;
    procedure LiberaRegistros;
  public
    constructor Create(AOwner: TComponent); override; /// Create
    destructor Destroy; override; /// Destroy
    procedure LimpaRegistros;

    function WriteRegistroC001: AnsiString;
    function WriteRegistroC100: AnsiString;
    function WriteRegistroC112: AnsiString;
    function WriteRegistroC113: AnsiString;
    function WriteRegistroC114: AnsiString;
    function WriteRegistroC115: AnsiString;
    function WriteRegistroC120: AnsiString;
    function WriteRegistroC130: AnsiString;
    function WriteRegistroC160: AnsiString;
    function WriteRegistroC165: AnsiString;
    function WriteRegistroC171: AnsiString;
    function WriteRegistroC172: AnsiString;
    function WriteRegistroC173: AnsiString;
    function WriteRegistroC174: AnsiString;
    function WriteRegistroC175: AnsiString;
    function WriteRegistroC176: AnsiString;
    function WriteRegistroC177: AnsiString;
    function WriteRegistroC178: AnsiString;
    function WriteRegistroC179: AnsiString;
    function WriteRegistroC195: AnsiString;
    function WriteRegistroC197: AnsiString;
    function WriteRegistroC300: AnsiString;
    function WriteRegistroC310: AnsiString;
    function WriteRegistroC320: AnsiString;
    function WriteRegistroC321: AnsiString;
    function WriteRegistroC350: AnsiString;
    function WriteRegistroC370: AnsiString;
    function WriteRegistroC390: AnsiString;
    function WriteRegistroC400: AnsiString;
    function WriteRegistroC405: AnsiString;
    function WriteRegistroC410: AnsiString;
    function WriteRegistroC420: AnsiString;
    function WriteRegistroC425: AnsiString;
    function WriteRegistroC460: AnsiString;
    function WriteRegistroC470: AnsiString;
    function WriteRegistroC490: AnsiString;
    function WriteRegistroC495: AnsiString;
    function WriteRegistroC500: AnsiString;
    function WriteRegistroC510: AnsiString;
    function WriteRegistroC590: AnsiString;
    function WriteRegistroC600: AnsiString;
    function WriteRegistroC601: AnsiString;
    function WriteRegistroC610: AnsiString;
    function WriteRegistroC620: AnsiString;
    function WriteRegistroC690: AnsiString;
    function WriteRegistroC700: AnsiString;
    function WriteRegistroC790: AnsiString;
    function WriteRegistroC791: AnsiString;
    function WriteRegistroC990: AnsiString;

    property RegistroC001: TRegistroC001 read FRegistroC001 write FRegistroC001;
    property RegistroC100: TRegistroC100List read FRegistroC100 write FRegistroC100;
    property RegistroC112: TRegistroC112List read FRegistroC112 write FRegistroC112;
    property RegistroC113: TRegistroC113List read FRegistroC113 write FRegistroC113;
    property RegistroC114: TRegistroC114List read FRegistroC114 write FRegistroC114;
    property RegistroC115: TRegistroC115List read FRegistroC115 write FRegistroC115;
    property RegistroC120: TRegistroC120List read FRegistroC120 write FRegistroC120;
    property RegistroC130: TRegistroC130List read FRegistroC130 write FRegistroC130;
    property RegistroC160: TRegistroC160List read FRegistroC160 write FRegistroC160;
    property RegistroC165: TRegistroC165List read FRegistroC165 write FRegistroC165;
    property RegistroC171: TRegistroC171List read FRegistroC171 write FRegistroC171;
    property RegistroC172: TRegistroC172List read FRegistroC172 write FRegistroC172;
    property RegistroC173: TRegistroC173List read FRegistroC173 write FRegistroC173;
    property RegistroC174: TRegistroC174List read FRegistroC174 write FRegistroC174;
    property RegistroC175: TRegistroC175List read FRegistroC175 write FRegistroC175;
    property RegistroC176: TRegistroC176List read FRegistroC176 write FRegistroC176;
    property RegistroC177: TRegistroC177List read FRegistroC177 write FRegistroC177;
    property RegistroC178: TRegistroC178List read FRegistroC178 write FRegistroC178;
    property RegistroC179: TRegistroC179List read FRegistroC179 write FRegistroC179;
    property RegistroC195: TRegistroC195List read FRegistroC195 write FRegistroC195;
    property RegistroC197: TRegistroC197List read FRegistroC197 write FRegistroC197;
    property RegistroC300: TRegistroC300List read FRegistroC300 write FRegistroC300;
    property RegistroC310: TRegistroC310List read FRegistroC310 write FRegistroC310;
    property RegistroC320: TRegistroC320List read FRegistroC320 write FRegistroC320;
    property RegistroC321: TRegistroC321List read FRegistroC321 write FRegistroC321;
    property RegistroC350: TRegistroC350List read FRegistroC350 write FRegistroC350;
    property RegistroC370: TRegistroC370List read FRegistroC370 write FRegistroC370;
    property RegistroC390: TRegistroC390List read FRegistroC390 write FRegistroC390;
    property RegistroC400: TRegistroC400List read FRegistroC400 write FRegistroC400;
    property RegistroC405: TRegistroC405List read FRegistroC405 write FRegistroC405;
    property RegistroC410: TRegistroC410List read FRegistroC410 write FRegistroC410;
    property RegistroC420: TRegistroC420List read FRegistroC420 write FRegistroC420;
    property RegistroC425: TRegistroC425List read FRegistroC425 write FRegistroC425;
    property RegistroC460: TRegistroC460List read FRegistroC460 write FRegistroC460;
    property RegistroC470: TRegistroC470List read FRegistroC470 write FRegistroC470;
    property RegistroC490: TRegistroC490List read FRegistroC490 write FRegistroC490;
    property RegistroC495: TRegistroC495List read FRegistroC495 write FRegistroC495;
    property RegistroC500: TRegistroC500List read FRegistroC500 write FRegistroC500;
    property RegistroC510: TRegistroC510List read FRegistroC510 write FRegistroC510;
    property RegistroC590: TRegistroC590List read FRegistroC590 write FRegistroC590;
    property RegistroC600: TRegistroC600List read FRegistroC600 write FRegistroC600;
    property RegistroC601: TRegistroC601List read FRegistroC601 write FRegistroC601;
    property RegistroC610: TRegistroC610List read FRegistroC610 write FRegistroC610;
    property RegistroC620: TRegistroC620List read FRegistroC620 write FRegistroC620;
    property RegistroC690: TRegistroC690List read FRegistroC690 write FRegistroC690;
    property RegistroC700: TRegistroC700List read FRegistroC700 write FRegistroC700;
    property RegistroC790: TRegistroC790List read FRegistroC790 write FRegistroC790;
    property RegistroC791: TRegistroC791List read FRegistroC791 write FRegistroC791;
    property RegistroC990: TRegistroC990 read FRegistroC990 write FRegistroC990;

    property RegistroC110Count: Integer read FRegistroC110Count write FRegistroC110Count;
    property RegistroC111Count: Integer read FRegistroC111Count write FRegistroC111Count;
    property RegistroC140Count: Integer read FRegistroC140Count write FRegistroC140Count; {Márcio Lopes 30Nov2009}
    property RegistroC141Count: Integer read FRegistroC141Count write FRegistroC141Count; {Márcio Lopes 30Nov2009}
    property RegistroC170Count: Integer read FRegistroC170Count write FRegistroC170Count;
    property RegistroC190Count: Integer read FRegistroC190Count write FRegistroC190Count; {Jean Barreiros 17Nov2009}

  end;

implementation

{ TBloco_C }

constructor TBloco_C.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  CriaRegistros;
end;

destructor TBloco_C.Destroy;
begin
  LiberaRegistros;
  inherited;
end;

procedure TBloco_C.CriaRegistros;
begin
  FRegistroC001 := TRegistroC001.Create;
  FRegistroC100 := TRegistroC100List.Create;
  FRegistroC112 := TRegistroC112List.Create;
  FRegistroC113 := TRegistroC113List.Create;
  FRegistroC114 := TRegistroC114List.Create;
  FRegistroC115 := TRegistroC115List.Create;
  FRegistroC120 := TRegistroC120List.Create;
  FRegistroC130 := TRegistroC130List.Create;
  FRegistroC160 := TRegistroC160List.Create;
  FRegistroC165 := TRegistroC165List.Create;
  FRegistroC171 := TRegistroC171List.Create;
  FRegistroC172 := TRegistroC172List.Create;
  FRegistroC173 := TRegistroC173List.Create;
  FRegistroC174 := TRegistroC174List.Create;
  FRegistroC175 := TRegistroC175List.Create;
  FRegistroC176 := TRegistroC176List.Create;
  FRegistroC177 := TRegistroC177List.Create;
  FRegistroC178 := TRegistroC178List.Create;
  FRegistroC179 := TRegistroC179List.Create;
  FRegistroC195 := TRegistroC195List.Create;
  FRegistroC197 := TRegistroC197List.Create;
  FRegistroC300 := TRegistroC300List.Create;
  FRegistroC310 := TRegistroC310List.Create;
  FRegistroC320 := TRegistroC320List.Create;
  FRegistroC321 := TRegistroC321List.Create;
  FRegistroC350 := TRegistroC350List.Create;
  FRegistroC370 := TRegistroC370List.Create;
  FRegistroC390 := TRegistroC390List.Create;
  FRegistroC400 := TRegistroC400List.Create;
  FRegistroC405 := TRegistroC405List.Create;
  FRegistroC410 := TRegistroC410List.Create;
  FRegistroC420 := TRegistroC420List.Create;
  FRegistroC425 := TRegistroC425List.Create;
  FRegistroC460 := TRegistroC460List.Create;
  FRegistroC470 := TRegistroC470List.Create;
  FRegistroC490 := TRegistroC490List.Create;
  FRegistroC495 := TRegistroC495List.Create;
  FRegistroC500 := TRegistroC500List.Create;
  FRegistroC510 := TRegistroC510List.Create;
  FRegistroC590 := TRegistroC590List.Create;
  FRegistroC600 := TRegistroC600List.Create;
  FRegistroC601 := TRegistroC601List.Create;
  FRegistroC610 := TRegistroC610List.Create;
  FRegistroC620 := TRegistroC620List.Create;
  FRegistroC690 := TRegistroC690List.Create;
  FRegistroC700 := TRegistroC700List.Create;
  FRegistroC790 := TRegistroC790List.Create;
  FRegistroC791 := TRegistroC791List.Create;
  FRegistroC990 := TRegistroC990.Create;

  FRegistroC110Count := 0;
  FRegistroC111Count := 0;
  FRegistroC140Count := 0;
  FRegistroC141Count := 0;
  FRegistroC170Count := 0;
  FRegistroC190Count := 0;  {Jean Barreiros 18Nov2009}

  FRegistroC990.QTD_LIN_C := 0;
end;

procedure TBloco_C.LiberaRegistros;
begin
  FRegistroC001.Free;
  FRegistroC100.Free;
  FRegistroC112.Free;
  FRegistroC113.Free;
  FRegistroC114.Free;
  FRegistroC115.Free;
  FRegistroC120.Free;
  FRegistroC130.Free;
  FRegistroC160.Free;
  FRegistroC165.Free;
  FRegistroC171.Free;
  FRegistroC172.Free;
  FRegistroC173.Free;
  FRegistroC174.Free;
  FRegistroC175.Free;
  FRegistroC176.Free;
  FRegistroC177.Free;
  FRegistroC178.Free;
  FRegistroC179.Free;
  FRegistroC195.Free;
  FRegistroC197.Free;
  FRegistroC300.Free;
  FRegistroC310.Free;
  FRegistroC320.Free;
  FRegistroC321.Free;
  FRegistroC350.Free;
  FRegistroC370.Free;
  FRegistroC390.Free;
  FRegistroC400.Free;
  FRegistroC405.Free;
  FRegistroC410.Free;
  FRegistroC420.Free;
  FRegistroC425.Free;
  FRegistroC460.Free;
  FRegistroC470.Free;
  FRegistroC490.Free;
  FRegistroC495.Free;
  FRegistroC500.Free;
  FRegistroC510.Free;
  FRegistroC590.Free;
  FRegistroC600.Free;
  FRegistroC601.Free;
  FRegistroC610.Free;
  FRegistroC620.Free;
  FRegistroC690.Free;
  FRegistroC700.Free;
  FRegistroC790.Free;
  FRegistroC791.Free;
  FRegistroC990.Free;
end;

procedure TBloco_C.LimpaRegistros;
begin
  /// Limpa os Registros
  LiberaRegistros;
  /// Recriar os Registros Limpos
  CriaRegistros;
end;

function TBloco_C.WriteRegistroC001: AnsiString;
begin
  Result := '';

  if Assigned(RegistroC001) then
  begin
     with RegistroC001 do
     begin
       Check(((IND_MOV = 0) or (IND_MOV = 1)), 'BLOCO C - REGISTROC001: Na abertura do bloco, deve ser informado o número 0 ou 1!');
       ///
       Result := LFill('C001') +
                 LFill(IND_MOV, 0) +
                 Delimitador +
                 #13#10;
       ///
       RegistroC990.QTD_LIN_C := RegistroC990.QTD_LIN_C + 1;
     end;
  end;
end;

function TBloco_C.WriteRegistroC100: AnsiString;
var
intFor: integer;
strRegistroC100: AnsiString;
booNFCancelada: Boolean; /// Variavél p/ tratamento de NFs canceladas, denegadas ou inutilizada - Jean Barreiros 25Nov2009
begin
  strRegistroC100 := '';

  if Assigned( RegistroC100 ) then
  begin
     for intFor := 0 to RegistroC100.Count - 1 do
     begin
        with RegistroC100.Items[intFor] do
        begin
          /// Tratamento NFs canceladas 02/03, denegada 04 ou inutilizada 05 - Jean Barreiros 25Nov2009
          if (COD_SIT = '02') or (COD_SIT = '03') or (COD_SIT = '04') or (COD_SIT = '05') then
            booNFCancelada := true
          else
            booNFCancelada := false;

          strRegistroC100 := strRegistroC100 + LFill('C100') +
                                               LFill( IND_OPER ) +
                                               LFill( IND_EMIT ) +
                                               LFill( COD_PART ) +
                                               LFill( COD_MOD  ) +
                                               LFill( COD_SIT  ) +
                                               LFill( SER  ) +
                                               LFill( NUM_DOC  ) +
                                               LFill( CHV_NFE  ) +
                                               LFill( DT_DOC, 'ddmmyyyy', booNFCancelada ) +
                                               LFill( DT_E_S, 'ddmmyyyy', booNFCancelada ) +
                                               LFill( VL_DOC , 0 , 2 , booNFCancelada ) +
                                               LFill( IND_PGTO  ) +
                                               LFill( VL_DESC,0,2, booNFCancelada ) +
                                               LFill( VL_ABAT_NT,0,2, booNFCancelada ) +
                                               LFill( VL_MERC,0,2, booNFCancelada ) +
                                               LFill( IND_FRT ) +
                                               LFill( VL_FRT,0,2, booNFCancelada ) +
                                               LFill( VL_SEG,0,2, booNFCancelada ) +
                                               LFill( VL_OUT_DA,0,2, booNFCancelada ) +
                                               LFill( VL_BC_ICMS,0,2, booNFCancelada ) +
                                               LFill( VL_ICMS,0,2, booNFCancelada ) +
                                               LFill( VL_BC_ICMS_ST,0,2, booNFCancelada ) +
                                               LFill( VL_ICMS_ST,0,2, booNFCancelada ) +
                                               LFill( VL_IPI,0,2, booNFCancelada ) +
                                               LFill( VL_PIS,0,2, booNFCancelada ) +
                                               LFill( VL_COFINS,0,2, booNFCancelada ) +
                                               LFill( VL_PIS_ST,0,2, booNFCancelada ) +
                                               LFill( VL_COFINS_ST,0,2, booNFCancelada ) +
                                               Delimitador +
                                               #13#10;
        end;
        /// Registros FILHOS
        strRegistroC100 := strRegistroC100 +
                           WriteRegistroC110( RegistroC100.Items[intFor] ) +
                           WriteRegistroC140( RegistroC100.Items[intFor] ) +
                           WriteRegistroC170( RegistroC100.Items[intFor] ) +
                           WriteRegistroC190( RegistroC100.Items[intFor] );

        RegistroC990.QTD_LIN_C := RegistroC990.QTD_LIN_C + 1;
     end;
  end;
  Result := strRegistroC100;
end;

function TBloco_C.WriteRegistroC110(RegC100: TRegistroC100): AnsiString;
var
intFor: integer;
strRegistroC110: AnsiString;
begin
  strRegistroC110 := '';

  if Assigned( RegC100.RegistroC110 ) then
  begin
     for intFor := 0 to RegC100.RegistroC110.Count - 1 do
     begin
        with RegC100.RegistroC110.Items[intFor] do
        begin
          strRegistroC110 := strRegistroC110 + LFill('C110') +
                                               LFill( COD_INF ) +
                                               LFill( TXT_COMPL) +
                                               Delimitador +
                                               #13#10;
        end;
        /// Registro FILHOS do FILHO
        strRegistroC110 := strRegistroC110 +
                           WriteRegistroC111( RegC100.RegistroC110.Items[intFor] );

        RegistroC990.QTD_LIN_C := RegistroC990.QTD_LIN_C + 1;
     end;
     /// Variavél para armazenar a quantidade de registro do tipo.
     FRegistroC110Count := FRegistroC110Count + RegC100.RegistroC110.Count;
  end;
  Result := strRegistroC110;
end;

function TBloco_C.WriteRegistroC111(RegC110: TRegistroC110): AnsiString;
var
intFor: integer;
strRegistroC111: AnsiString;
begin
  strRegistroC111 := '';

  if Assigned( RegC110.RegistroC111 ) then
  begin
     for intFor := 0 to RegC110.RegistroC111.Count - 1 do
     begin
        with RegC110.RegistroC111.Items[intFor] do
        begin
          strRegistroC111 := strRegistroC111 + LFill('C111') +
                                               LFill( NUM_PROC ) +
                                               LFill( IND_PROC ) +
                                               Delimitador +
                                               #13#10;
        end;
        RegistroC990.QTD_LIN_C := RegistroC990.QTD_LIN_C + 1;
     end;
     /// Variavél para armazenar a quantidade de registro do tipo.
     FRegistroC111Count := FRegistroC111Count + RegC110.RegistroC111.Count;
  end;
  Result := strRegistroC111;
end;

function TBloco_C.WriteRegistroC112: AnsiString;
var
intFor: integer;
strRegistroC112: AnsiString;
begin
  strRegistroC112 := '';

  if Assigned( RegistroC112 ) then
  begin
     for intFor := 0 to RegistroC112.Count - 1 do
     begin
        with RegistroC112.Items[intFor] do
        begin
          strRegistroC112 := strRegistroC112 + LFill('C112') +
                                               LFill( COD_DA ) +
                                               LFill( UF ) +
                                               LFill( NUM_DA ) +
                                               LFill( COD_AUT ) +
                                               LFill( VL_DA,0,2 ) +
                                               Delimitador +
                                               #13#10;
        end;
        RegistroC990.QTD_LIN_C := RegistroC990.QTD_LIN_C + 1;
     end;
  end;
  Result := strRegistroC112;
end;

function TBloco_C.WriteRegistroC113: AnsiString;
var
intFor: integer;
strRegistroC113: AnsiString;
begin
  strRegistroC113 := '';

  if Assigned( RegistroC113 ) then
  begin
     for intFor := 0 to RegistroC113.Count - 1 do
     begin
        with RegistroC113.Items[intFor] do
        begin
          strRegistroC113 := strRegistroC113 + LFill('C113') +
                                               LFill( IND_OPER ) +
                                               LFill( IND_EMIT ) +
                                               LFill( COD_PART ) +
                                               LFill( COD_MOD ) +
                                               LFill( SER ) +
                                               LFill( SUB ) +
                                               LFill( NUM_DOC ) +
                                               LFill( DT_DOC ) +
                                               Delimitador +
                                               #13#10;
        end;
        RegistroC990.QTD_LIN_C := RegistroC990.QTD_LIN_C + 1;
     end;
  end;
  Result := strRegistroC113;
end;

function TBloco_C.WriteRegistroC114: AnsiString;
var
intFor: integer;
strRegistroC114: AnsiString;
begin
  strRegistroC114 := '';

  if Assigned( RegistroC114 ) then
  begin
     for intFor := 0 to RegistroC114.Count - 1 do
     begin
        with RegistroC114.Items[intFor] do
        begin
          strRegistroC114 := strRegistroC114 + LFill('C114') +
                                               LFill( COD_MOD ) +
                                               LFill( ECF_FAB ) +
                                               LFill( ECF_CX ) +
                                               LFill( NUM_DOC ) +
                                               LFill( DT_DOC ) +
                                               Delimitador +
                                               #13#10;
        end;
        RegistroC990.QTD_LIN_C := RegistroC990.QTD_LIN_C + 1;
     end;
  end;
  Result := strRegistroC114;
end;

function TBloco_C.WriteRegistroC115: AnsiString;
var
intFor: integer;
strRegistroC115: AnsiString;
begin
  strRegistroC115 := '';

  if Assigned( RegistroC115 ) then
  begin
     for intFor := 0 to RegistroC115.Count - 1 do
     begin
        with RegistroC115.Items[intFor] do
        begin
          strRegistroC115 := strRegistroC115 + LFill('C115') +
                                               LFill( IND_CARGA ) +
                                               LFill( CNPJ_COL ) +
                                               LFill( IE_COL ) +
                                               LFill( CPF_COL ) +
                                               LFill( COD_MUN_COL ) +
                                               LFill( CNPJ_ENTG ) +
                                               LFill( IE_ENTG ) +
                                               LFill( CPF_ENTG ) +
                                               LFill( COD_MUN_ENTG ) +
                                               Delimitador +
                                               #13#10;
        end;
        RegistroC990.QTD_LIN_C := RegistroC990.QTD_LIN_C + 1;
     end;
  end;
  Result := strRegistroC115;
end;

function TBloco_C.WriteRegistroC120: AnsiString;
var
intFor: integer;
strRegistroC120: AnsiString;
begin
  strRegistroC120 := '';

  if Assigned( RegistroC120 ) then
  begin
     for intFor := 0 to RegistroC120.Count - 1 do
     begin
        with RegistroC120.Items[intFor] do
        begin
          strRegistroC120 := strRegistroC120 + LFill('C120') +
                                               LFill( COD_DOC_IMP ) +
                                               LFill( NUM_DOC__IMP ) +
                                               LFill( PIS_IMP,0,2 ) +
                                               LFill( COFINS_IMP,0,2 ) +
                                               Delimitador +
                                               #13#10;
        end;
        RegistroC990.QTD_LIN_C := RegistroC990.QTD_LIN_C + 1;
     end;
  end;
  Result := strRegistroC120;
end;

function TBloco_C.WriteRegistroC130: AnsiString;
var
intFor: integer;
strRegistroC130: AnsiString;
begin
  strRegistroC130 := '';

  if Assigned( RegistroC130 ) then
  begin
     for intFor := 0 to RegistroC130.Count - 1 do
     begin
        with RegistroC130.Items[intFor] do
        begin
          strRegistroC130 := strRegistroC130 + LFill('C130') +
                                               LFill( VL_SERV_NT,2,0 ) +
                                               LFill( VL_BC_ISSQN,2,0 ) +
                                               LFill( VL_ISSQN,2,0 ) +
                                               LFill( VL_BC_IRRF,2,0 ) +
                                               LFill( VL_IRRF,2,0 ) +
                                               LFill( VL_BC_PREV,2,0 ) +
                                               LFill( VL_PREV,2,0 ) +
                                               Delimitador +
                                               #13#10;
        end;
        RegistroC990.QTD_LIN_C := RegistroC990.QTD_LIN_C + 1;
     end;
  end;
  Result := strRegistroC130;
end;

function TBloco_C.WriteRegistroC140(RegC100: TRegistroC100): AnsiString;
var
intFor: integer;
strRegistroC140: AnsiString;
begin
  strRegistroC140 := '';

  if Assigned( RegC100.RegistroC140 ) then
  begin
     for intFor := 0 to RegC100.RegistroC140.Count - 1 do
     begin
        with RegC100.RegistroC140.Items[intFor] do
        begin
          strRegistroC140 := strRegistroC140 + LFill('C140') +
                                               LFill( IND_EMIT ) +
                                               LFill( IND_TIT ) +
                                               LFill( DESC_TIT ) +
                                               LFill( NUM_TIT ) +
                                               LFill( QTD_PARC,2 ) +
                                               LFill( VL_TIT,0,2 ) +
                                               Delimitador +
                                               #13#10;
        end;
        /// Registro FILHOS do FILHO
        strRegistroC140 := strRegistroC140 +
                           WriteRegistroC141( RegC100.RegistroC140.Items[intFor] );

        RegistroC990.QTD_LIN_C := RegistroC990.QTD_LIN_C + 1;
     end;
     /// Variavél para armazenar a quantidade de registro do tipo.
     FRegistroC140Count := FRegistroC140Count + RegC100.RegistroC140.Count;
  end;
  Result := strRegistroC140;
end;

function TBloco_C.WriteRegistroC141(RegC140:TRegistroC140): AnsiString;
var
intFor: integer;
strRegistroC141: AnsiString;
begin
  strRegistroC141 := '';

  if Assigned( RegC140.RegistroC141 ) then
  begin
     for intFor := 0 to RegC140.RegistroC141.Count - 1 do
     begin
        with RegC140.RegistroC141.Items[intFor] do
        begin
          strRegistroC141 := strRegistroC141 + LFill('C141') +
                                               LFill( NUM_PARC ) +
                                               LFill( DT_VCTO ) +
                                               LFill( VL_PARC,0,2 ) +
                                               Delimitador +
                                               #13#10;
        end;
        RegistroC990.QTD_LIN_C := RegistroC990.QTD_LIN_C + 1;
     end;
     /// Variavél para armazenar a quantidade de registro do tipo.
     FRegistroC141Count := FRegistroC141Count + RegC140.RegistroC141.Count;
  end;
  Result := strRegistroC141;
end;

function TBloco_C.WriteRegistroC160: AnsiString;
var
intFor: integer;
strRegistroC160: AnsiString;
begin
  strRegistroC160 := '';

  if Assigned( RegistroC160 ) then
  begin
     for intFor := 0 to RegistroC160.Count - 1 do
     begin
        with RegistroC160.Items[intFor] do
        begin
          strRegistroC160 := strRegistroC160 + LFill('C160') +
                                               LFill( COD_PART ) +
                                               LFill( VEIC_ID ) +
                                               LFill( QTD_VOL,0,0 ) +
                                               LFill( PESO_BRT,0,2 ) +
                                               LFill( PESO_LIQ,0,2 ) +
                                               LFill( UF_ID ) +
                                               Delimitador +
                                               #13#10;
        end;
        RegistroC990.QTD_LIN_C := RegistroC990.QTD_LIN_C + 1;
     end;
  end;
  Result := strRegistroC160;
end;

function TBloco_C.WriteRegistroC165: AnsiString;
var
intFor: integer;
strRegistroC165: AnsiString;
begin
  strRegistroC165 := '';

  if Assigned( RegistroC165 ) then
  begin
     for intFor := 0 to RegistroC165.Count - 1 do
     begin
        with RegistroC165.Items[intFor] do
        begin
          strRegistroC165 := strRegistroC165 + LFill('C165') +
                                               LFill( COD_PART ) +
                                               LFill( VEIC_ID ) +
                                               LFill( COD_AUT ) +
                                               LFill( NR_PASSE ) +
                                               LFill( HORA ) +
                                               LFill( TEMPER ) +
                                               LFill( QTD_VOL,0,0 ) +
                                               LFill( PESO_BRT,0,2 ) +
                                               LFill( PESO_LIQ,0,2 ) +
                                               LFill( NOM_MOT ) +
                                               LFill( CPF ) +
                                               LFill( UF_ID ) +
                                               Delimitador +
                                               #13#10;
        end;
        RegistroC990.QTD_LIN_C := RegistroC990.QTD_LIN_C + 1;
     end;
  end;
  Result := strRegistroC165;
end;

function TBloco_C.WriteRegistroC170(RegC100: TRegistroC100): AnsiString;
var
intFor: integer;
strRegistroC170: AnsiString;
begin
  strRegistroC170 := '';

  if Assigned( RegC100.RegistroC170 ) then
  begin
     for intFor := 0 to RegC100.RegistroC170.Count - 1 do
     begin
        with RegC100.RegistroC170.Items[intFor] do
        begin
          strRegistroC170 := strRegistroC170 + LFill('C170') +
                                               LFill( NUM_ITEM ) +
                                               LFill( COD_ITEM ) +
                                               LFill( DESCR_COMPL ) +
                                               LFill( QTD,6,0 ) +
                                               LFill( UNID ) +
                                               LFill( VL_ITEM,0,2 ) +
                                               LFill( VL_DESC,0,2 ) +
                                               LFill( IND_MOV,1 ) +
                                               LFill( CST_ICMS,3 ) +
                                               LFill( CFOP,4 ) +
                                               LFill( COD_NAT ) +
                                               LFill( VL_BC_ICMS,0,2 ) +
                                               LFill( ALIQ_ICMS,0,2 ) +
                                               LFill( VL_ICMS,0,2 ) +
                                               LFill( VL_BC_ICMS_ST,0,2 ) +
                                               LFill( ALIQ_ST,0,2 ) +
                                               LFill( VL_ICMS_ST,0,2 ) +
                                               LFill( IND_APUR ) +
                                               LFill( CST_IPI ) +
                                               LFill( COD_ENQ ) +
                                               LFill( VL_BC_IPI,0,2 ) +
                                               LFill( ALIQ_IPI,0,2 ) +
                                               LFill( VL_IPI,0,2 ) +
                                               LFill( CST_PIS ) +
                                               LFill( VL_BC_PIS,0,2 ) +
                                               LFill( ALIQ_PIS_PERC,0,2 ) +
                                               LFill( QUANT_BC_PIS,0,2 ) +
                                               LFill( ALIQ_PIS_R,0,2 ) +
                                               LFill( VL_PIS,0,2 ) +
                                               LFill( CST_COFINS ) +
                                               LFill( VL_BC_COFINS,0,2 ) +
                                               LFill( ALIQ_COFINS_PERC,0,2 ) +
                                               LFill( QUANT_BC_COFINS,0,2 ) +
                                               LFill( ALIQ_COFINS_R,0,2 ) +
                                               LFill( VL_COFINS,0,2 ) +
                                               LFill( COD_CTA ) +
                                               Delimitador +
                                               #13#10;
        end;
        RegistroC990.QTD_LIN_C := RegistroC990.QTD_LIN_C + 1;
     end;
     /// Variavél para armazenar a quantidade de registro do tipo.
     FRegistroC170Count := FRegistroC170Count + RegC100.RegistroC170.Count;
  end;
  Result := strRegistroC170;
end;

function TBloco_C.WriteRegistroC171: AnsiString;
var
intFor: integer;
strRegistroC171: AnsiString;
begin
  strRegistroC171 := '';

  if Assigned( RegistroC171 ) then
  begin
     for intFor := 0 to RegistroC171.Count - 1 do
     begin
        with RegistroC171.Items[intFor] do
        begin
          strRegistroC171 := strRegistroC171 + LFill('C171') +
                                               LFill( NUM_TANQUE,3 ) +
                                               LFill( QTDE,0,3 ) +
                                               Delimitador +
                                               #13#10;
        end;
        RegistroC990.QTD_LIN_C := RegistroC990.QTD_LIN_C + 1;
     end;
  end;
  Result := strRegistroC171;
end;

function TBloco_C.WriteRegistroC172: AnsiString;
var
intFor: integer;
strRegistroC172: AnsiString;
begin
  strRegistroC172 := '';

  if Assigned( RegistroC172 ) then
  begin
     for intFor := 0 to RegistroC172.Count - 1 do
     begin
        with RegistroC172.Items[intFor] do
        begin
          strRegistroC172 := strRegistroC172 + LFill('C172') +
                                               LFill( VL_BC_ISSQN,0,2 ) +
                                               LFill( ALIQ_ISSQN,0,2 ) +
                                               LFill( VL_ISSQN,0,2 ) +
                                               Delimitador +
                                               #13#10;
        end;
        RegistroC990.QTD_LIN_C := RegistroC990.QTD_LIN_C + 1;
     end;
  end;
  Result := strRegistroC172;
end;

function TBloco_C.WriteRegistroC173: AnsiString;
var
intFor: integer;
strRegistroC173: AnsiString;
begin
  strRegistroC173 := '';

  if Assigned( RegistroC173 ) then
  begin
     for intFor := 0 to RegistroC173.Count - 1 do
     begin
        with RegistroC173.Items[intFor] do
        begin
          strRegistroC173 := strRegistroC173 + LFill('C173') +
                                               LFill( LOTE_MED ) +
                                               LFill( QTD_ITEM,0,3 ) +
                                               LFill( DT_FAB ) +
                                               LFill( DT_VAL ) +
                                               LFill( IND_MED ) +
                                               LFill( TP_PROD ) +
                                               LFill( VL_TAB_MAX,0,2 ) +
                                               Delimitador +
                                               #13#10;
        end;
        RegistroC990.QTD_LIN_C := RegistroC990.QTD_LIN_C + 1;
     end;
  end;
  Result := strRegistroC173;
end;

function TBloco_C.WriteRegistroC174: AnsiString;
var
intFor: integer;
strRegistroC174: AnsiString;
begin
  strRegistroC174 := '';

  if Assigned( RegistroC174 ) then
  begin
     for intFor := 0 to RegistroC174.Count - 1 do
     begin
        with RegistroC174.Items[intFor] do
        begin
          strRegistroC174 := strRegistroC174 + LFill('C174') +
                                               LFill( IND_ARM ) +
                                               LFill( NUM_ARM ) +
                                               LFill( DESCR_COMPL ) +
                                               Delimitador +
                                               #13#10;
        end;
        RegistroC990.QTD_LIN_C := RegistroC990.QTD_LIN_C + 1;
     end;
  end;
  Result := strRegistroC174;
end;

function TBloco_C.WriteRegistroC175: AnsiString;
var
intFor: integer;
strRegistroC175: AnsiString;
begin
  strRegistroC175 := '';

  if Assigned( RegistroC175 ) then
  begin
     for intFor := 0 to RegistroC175.Count - 1 do
     begin
        with RegistroC175.Items[intFor] do
        begin
          strRegistroC175 := strRegistroC175 + LFill('C175') +
                                               LFill( IND_VEIC_OPER ) +
                                               LFill( CNPJ ) +
                                               LFill( UF ) +
                                               LFill( CHASSI_VEIC ) +
                                               Delimitador +
                                               #13#10;
        end;
        RegistroC990.QTD_LIN_C := RegistroC990.QTD_LIN_C + 1;
     end;
  end;
  Result := strRegistroC175;
end;

function TBloco_C.WriteRegistroC176: AnsiString;
var
intFor: integer;
strRegistroC176: AnsiString;
begin
  strRegistroC176 := '';

  if Assigned( RegistroC176 ) then
  begin
     for intFor := 0 to RegistroC176.Count - 1 do
     begin
        with RegistroC176.Items[intFor] do
        begin
          strRegistroC176 := strRegistroC176 + LFill('C176') +
                                               LFill( COD_MOD_ULT_E ) +
                                               LFill( NUM_DOC_ULT_E ) +
                                               LFill( SER_ULT_E ) +
                                               LFill( DT_ULT_E ) +
                                               LFill( COD_PART_ULT_E ) +
                                               LFill( QUANT_ULT_E,0,3 ) +
                                               LFill( VL_UNIT_ULT_E,0,3 ) +
                                               LFill( VL_UNIT_BC_ST,0,3 ) +
                                               Delimitador +
                                               #13#10;
        end;
        RegistroC990.QTD_LIN_C := RegistroC990.QTD_LIN_C + 1;
     end;
  end;
  Result := strRegistroC176;
end;

function TBloco_C.WriteRegistroC177: AnsiString;
var
intFor: integer;
strRegistroC177: AnsiString;
begin
  strRegistroC177 := '';

  if Assigned( RegistroC177 ) then
  begin
     for intFor := 0 to RegistroC177.Count - 1 do
     begin
        with RegistroC177.Items[intFor] do
        begin
          strRegistroC177 := strRegistroC177 + LFill('C177') +
                                               LFill( COD_SELO_IPI ) +
                                               LFill( QT_SELO_IPI,0,0 ) +
                                               Delimitador +
                                               #13#10;
        end;
        RegistroC990.QTD_LIN_C := RegistroC990.QTD_LIN_C + 1;
     end;
  end;
  Result := strRegistroC177;
end;

function TBloco_C.WriteRegistroC178: AnsiString;
var
intFor: integer;
strRegistroC178: AnsiString;
begin
  strRegistroC178 := '';

  if Assigned( RegistroC178 ) then
  begin
     for intFor := 0 to RegistroC178.Count - 1 do
     begin
        with RegistroC178.Items[intFor] do
        begin
          strRegistroC178 := strRegistroC178 + LFill('C178') +
                                               LFill( CL_ENQ ) +
                                               LFill( VL_UNID,0,2 ) +
                                               LFill( QUANT_PAD,0,3 ) +
                                               Delimitador +
                                               #13#10;
        end;
        RegistroC990.QTD_LIN_C := RegistroC990.QTD_LIN_C + 1;
     end;
  end;
  Result := strRegistroC178;
end;

function TBloco_C.WriteRegistroC179: AnsiString;
var
intFor: integer;
strRegistroC179: AnsiString;
begin
  strRegistroC179 := '';

  if Assigned( RegistroC179 ) then
  begin
     for intFor := 0 to RegistroC179.Count - 1 do
     begin
        with RegistroC179.Items[intFor] do
        begin
          strRegistroC179 := strRegistroC179 + LFill('C179') +
                                               LFill( BC_ST_ORIG_DEST,0,2 ) +
                                               LFill( ICMS_ST_REP,0,2 ) +
                                               LFill( ICMS_ST_COMPL,0,2 ) +
                                               LFill( BC_RET,0,2 ) +
                                               LFill( ICMS_RET,0,2 ) +
                                               Delimitador +
                                               #13#10;
        end;
        RegistroC990.QTD_LIN_C := RegistroC990.QTD_LIN_C + 1;
     end;
  end;
  Result := strRegistroC179;
end;

function TBloco_C.WriteRegistroC190(RegC100: TRegistroC100): AnsiString;
var
intFor: integer;
strRegistroC190: AnsiString;
begin
  strRegistroC190 := '';

  if Assigned( RegC100.RegistroC190 ) then
  begin
     for intFor := 0 to RegC100.RegistroC190.Count - 1 do
     begin
        with RegC100.RegistroC190.Items[intFor] do
        begin
          strRegistroC190 := strRegistroC190 + LFill('C190') +
                                               LFill( CST_ICMS ) +
                                               LFill( CFOP,4 ) +
                                               LFill( ALIQ_ICMS,6,2 ) +
                                               LFill( VL_OPR,0,2 ) +
                                               LFill( VL_BC_ICMS,0,2 ) +
                                               LFill( VL_ICMS,0,2 ) +
                                               LFill( VL_BC_ICMS_ST,0,2 ) +
                                               LFill( VL_ICMS_ST,0,2 ) +
                                               LFill( VL_RED_BC,0,2 ) +
                                               LFill( VL_IPI,0,2 ) +
//                                               LFill( COD_OBS,6 ) +
                                               Delimitador +
                                               #13#10;
        end;
        RegistroC990.QTD_LIN_C := RegistroC990.QTD_LIN_C + 1;
     end;
     /// Variavél para armazenar a quantidade de registro do tipo.
     FRegistroC190Count := FRegistroC190Count + RegC100.RegistroC190.Count;
  end;
  Result := strRegistroC190;
end;

function TBloco_C.WriteRegistroC195: AnsiString;
var
intFor: integer;
strRegistroC195: AnsiString;
begin
  strRegistroC195 := '';

  if Assigned( RegistroC195 ) then
  begin
     for intFor := 0 to RegistroC195.Count - 1 do
     begin
        with RegistroC195.Items[intFor] do
        begin
          strRegistroC195 := strRegistroC195 + LFill('C195') +
                                               LFill( COD_OBS,6 ) +
                                               LFill( TXT_COMPL ) +
                                               Delimitador +
                                               #13#10;
        end;
        RegistroC990.QTD_LIN_C := RegistroC990.QTD_LIN_C + 1;
     end;
  end;
  Result := strRegistroC195;
end;

function TBloco_C.WriteRegistroC197: AnsiString;
var
intFor: integer;
strRegistroC197: AnsiString;
begin
  strRegistroC197 := '';

  if Assigned( RegistroC197 ) then
  begin
     for intFor := 0 to RegistroC197.Count - 1 do
     begin
        with RegistroC197.Items[intFor] do
        begin
          strRegistroC197 := strRegistroC197 + LFill('C197') +
                                               LFill( COD_AJ ) +
                                               LFill( DESCR_COMPL_AJ ) +
                                               LFill( COD_ITEM ) +
                                               LFill( VL_BC_ICMS,0,2 ) +
                                               LFill( ALIQ_ICMS,6,2 ) +
                                               LFill( VL_ICMS,0,2 ) +
                                               LFill( VL_OUTROS,0,2 ) +
                                               Delimitador +
                                               #13#10;
        end;
        RegistroC990.QTD_LIN_C := RegistroC990.QTD_LIN_C + 1;
     end;
  end;
  Result := strRegistroC197;
end;

function TBloco_C.WriteRegistroC300: AnsiString;
var
intFor: integer;
strRegistroC300: AnsiString;
begin
  strRegistroC300 := '';

  if Assigned( RegistroC300 ) then
  begin
     for intFor := 0 to RegistroC300.Count - 1 do
     begin
        with RegistroC300.Items[intFor] do
        begin
          strRegistroC300 := strRegistroC300 + LFill('C300') +
                                               LFill( COD_MOD,2 ) +
                                               LFill( SER ) +
                                               LFill( SUB ) +
                                               LFill( NUM_DOC_INI ) +
                                               LFill( NUM_DOC_FIN ) +
                                               LFill( DT_DOC ) +
                                               LFill( VL_DOC,0,2 ) +
                                               LFill( VL_PIS,0,2 ) +
                                               LFill( VL_COFINS,0,2 ) +
                                               LFill( COD_CTA ) +
                                               Delimitador +
                                               #13#10;
        end;
        RegistroC990.QTD_LIN_C := RegistroC990.QTD_LIN_C + 1;
     end;
  end;
  Result := strRegistroC300;
end;

function TBloco_C.WriteRegistroC310: AnsiString;
var
intFor: integer;
strRegistroC310: AnsiString;
begin
  strRegistroC310 := '';

  if Assigned( RegistroC310 ) then
  begin
     for intFor := 0 to RegistroC310.Count - 1 do
     begin
        with RegistroC310.Items[intFor] do
        begin
          strRegistroC310 := strRegistroC310 + LFill('C310') +
                                               LFill( NUM_DOC_CANC ) +
                                               Delimitador +
                                               #13#10;
        end;
        RegistroC990.QTD_LIN_C := RegistroC990.QTD_LIN_C + 1;
     end;
  end;
  Result := strRegistroC310;
end;

function TBloco_C.WriteRegistroC320: AnsiString;
var
intFor: integer;
strRegistroC320: AnsiString;
begin
  strRegistroC320 := '';

  if Assigned( RegistroC320 ) then
  begin
     for intFor := 0 to RegistroC320.Count - 1 do
     begin
        with RegistroC320.Items[intFor] do
        begin
          strRegistroC320 := strRegistroC320 + LFill('C320') +
                                               LFill( CST_ICMS,3 ) +
                                               LFill( CFOP,4 ) +
                                               LFill( ALIQ_ICMS,6,2 ) +
                                               LFill( VL_OPR,0,2 ) +
                                               LFill( VL_BC_ICMS,0,2 ) +
                                               LFill( VL_ICMS,0,2 ) +
                                               LFill( VL_RED_BC,0,2 ) +
                                               LFill( COD_OBS,6 ) +
                                               Delimitador +
                                               #13#10;
        end;
        RegistroC990.QTD_LIN_C := RegistroC990.QTD_LIN_C + 1;
     end;
  end;
  Result := strRegistroC320;
end;

function TBloco_C.WriteRegistroC321: AnsiString;
var
intFor: integer;
strRegistroC321: AnsiString;
begin
  strRegistroC321 := '';

  if Assigned( RegistroC321 ) then
  begin
     for intFor := 0 to RegistroC321.Count - 1 do
     begin
        with RegistroC321.Items[intFor] do
        begin
          strRegistroC321 := strRegistroC321 + LFill('C321') +
                                               LFill( COD_ITEM ) +
                                               LFill( QTD,0,3 ) +
                                               LFill( VL_ITEM,0,2 ) +
                                               LFill( VL_DESC,0,2 ) +
                                               LFill( VL_BC_ICMS,0,2 ) +
                                               LFill( VL_BC_ICMS,0,2 ) +
                                               LFill( VL_ICMS,0,2 ) +
                                               LFill( VL_PIS,0,2 ) +
                                               LFill( VL_COFINS,0,2 ) +
                                               Delimitador +
                                               #13#10;
        end;
        RegistroC990.QTD_LIN_C := RegistroC990.QTD_LIN_C + 1;
     end;
  end;
  Result := strRegistroC321;
end;

function TBloco_C.WriteRegistroC350: AnsiString;
var
intFor: integer;
strRegistroC350: AnsiString;
begin
  strRegistroC350 := '';

  if Assigned( RegistroC350 ) then
  begin
     for intFor := 0 to RegistroC350.Count - 1 do
     begin
        with RegistroC350.Items[intFor] do
        begin
          strRegistroC350 := strRegistroC350 + LFill('C350') +
                                               LFill( SER,3 ) +
                                               LFill( SUB_SER,3 ) +
                                               LFill( NUM_DOC ) +
                                               LFill( DT_DOC ) +
                                               LFill( CNPJ_CPF ) +
                                               LFill( VL_MERC,0,2 ) +
                                               LFill( VL_DOC,0,2 ) +
                                               LFill( VL_DESC,0,2 ) +
                                               LFill( VL_PIS,0,2 ) +
                                               LFill( VL_COFINS,0,2 ) +
                                               LFill( COD_CTA ) +
                                               Delimitador +
                                               #13#10;
        end;
        RegistroC990.QTD_LIN_C := RegistroC990.QTD_LIN_C + 1;
     end;
  end;
  Result := strRegistroC350;
end;

function TBloco_C.WriteRegistroC370: AnsiString;
var
intFor: integer;
strRegistroC370: AnsiString;
begin
  strRegistroC370 := '';

  if Assigned( RegistroC370 ) then
  begin
     for intFor := 0 to RegistroC370.Count - 1 do
     begin
        with RegistroC370.Items[intFor] do
        begin
          strRegistroC370 := strRegistroC370 + LFill('C370') +
                                               LFill( NUM_ITEM,3 ) +
                                               LFill( COD_ITEM ) +
                                               LFill( QTD,0,3 ) +
                                               LFill( UNID ) +
                                               LFill( VL_ITEM,0,3 ) +
                                               LFill( VL_DESC,0,3 ) +
                                               Delimitador +
                                               #13#10;
        end;
        RegistroC990.QTD_LIN_C := RegistroC990.QTD_LIN_C + 1;
     end;
  end;
  Result := strRegistroC370;
end;

function TBloco_C.WriteRegistroC390: AnsiString;
var
intFor: integer;
strRegistroC390: AnsiString;
begin
  strRegistroC390 := '';

  if Assigned( RegistroC390 ) then
  begin
     for intFor := 0 to RegistroC390.Count - 1 do
     begin
        with RegistroC390.Items[intFor] do
        begin
          strRegistroC390 := strRegistroC390 + LFill('C390') +
                                               LFill( CST_ICMS,3 ) +
                                               LFill( CFOP,4 ) +
                                               LFill( ALIQ_ICMS,0,2 ) +
                                               LFill( VL_OPR,0,2 ) +
                                               LFill( VL_BC_ICMS,0,2 ) +
                                               LFill( VL_ICMS,0,2 ) +
                                               LFill( VL_RED_BC,0,2 ) +
                                               LFill( COD_OBS,6 ) +
                                               Delimitador +
                                               #13#10;
        end;
        RegistroC990.QTD_LIN_C := RegistroC990.QTD_LIN_C + 1;
     end;
  end;
  Result := strRegistroC390;
end;

function TBloco_C.WriteRegistroC400: AnsiString;
var
intFor: integer;
strRegistroC400: AnsiString;
begin
  strRegistroC400 := '';

  if Assigned( RegistroC400 ) then
  begin
     for intFor := 0 to RegistroC400.Count - 1 do
     begin
        with RegistroC400.Items[intFor] do
        begin
          strRegistroC400 := strRegistroC400 + LFill('C400') +
                                               LFill(COD_MOD ) +
                                               LFill(ECF_MOD) +
                                               LFill(ECF_FAB) +
                                               LFill(ECF_CX ) +
                                               Delimitador +
                                               #13#10;
        end;
        RegistroC990.QTD_LIN_C := RegistroC990.QTD_LIN_C + 1;
     end;
  end;
  Result := strRegistroC400;
end;

function TBloco_C.WriteRegistroC405: AnsiString;
var
intFor: integer;
strRegistroC405: AnsiString;
begin
  strRegistroC405 := '';

  if Assigned( RegistroC405 ) then
  begin
     for intFor := 0 to RegistroC405.Count - 1 do
     begin
        with RegistroC405.Items[intFor] do
        begin
          strRegistroC405 := strRegistroC405 + LFill('C405') +
                                               LFill( DT_DOC ) +
                                               LFill( CRO,3 ) +
                                               LFill( CRZ,6 ) +
                                               LFill( NUM_COO_FIN,6  ) +
                                               LFill( GT_FIN,0,2  ) +
                                               LFill( VL_BRT,0,2  ) +
                                               Delimitador +
                                               #13#10;
        end;
        RegistroC990.QTD_LIN_C := RegistroC990.QTD_LIN_C + 1;
     end;
  end;
  Result := strRegistroC405;
end;

function TBloco_C.WriteRegistroC410: AnsiString;
var
intFor: integer;
strRegistroC410: AnsiString;
begin
  strRegistroC410 := '';

  if Assigned( RegistroC410 ) then
  begin
     for intFor := 0 to RegistroC410.Count - 1 do
     begin
        with RegistroC410.Items[intFor] do
        begin
          strRegistroC410 := strRegistroC410 + LFill('C410') +
                                               LFill( VL_PIS,0,2 ) +
                                               LFill( VL_COFINS,0,2) +
                                               Delimitador +
                                               #13#10;
        end;
        RegistroC990.QTD_LIN_C := RegistroC990.QTD_LIN_C + 1;
     end;
  end;
  Result := strRegistroC410;
end;

function TBloco_C.WriteRegistroC420: AnsiString;
var
intFor: integer;
strRegistroC420: AnsiString;
begin
  strRegistroC420 := '';

  if Assigned( RegistroC420 ) then
  begin
     for intFor := 0 to RegistroC420.Count - 1 do
     begin
        with RegistroC420.Items[intFor] do
        begin
          strRegistroC420 := strRegistroC420 + LFill('C420') +
                                               LFill( COD_TOT_PAR,7 ) +
                                               LFill( VLR_ACUM_TOT,0,2) +
                                               LFill( NR_TOT,2) +
                                               LFill( DESCR_NR_TOT ) +
                                               Delimitador +
                                               #13#10;
        end;
        RegistroC990.QTD_LIN_C := RegistroC990.QTD_LIN_C + 1;
     end;
  end;
  Result := strRegistroC420;
end;

function TBloco_C.WriteRegistroC425: AnsiString;
var
intFor: integer;
strRegistroC425: AnsiString;
begin
  strRegistroC425 := '';

  if Assigned( RegistroC425 ) then
  begin
     for intFor := 0 to RegistroC425.Count - 1 do
     begin
        with RegistroC425.Items[intFor] do
        begin
          strRegistroC425 := strRegistroC425 + LFill('C425') +
                                               LFill( COD_ITEM,6 ) +
                                               LFill( QTD,0,3 ) +
                                               LFill( UNID ) +
                                               LFill( VL_ITEM,0,2 ) +
                                               LFill( VL_PIS ,0,2 ) +
                                               LFill( VL_COFINS ,0,2 ) +
                                               Delimitador +
                                               #13#10;
        end;
        RegistroC990.QTD_LIN_C := RegistroC990.QTD_LIN_C + 1;
     end;
  end;
  Result := strRegistroC425;
end;

function TBloco_C.WriteRegistroC460: AnsiString;
var
intFor: integer;
strRegistroC460: AnsiString;
begin
  strRegistroC460 := '';

  if Assigned( RegistroC460 ) then
  begin
     for intFor := 0 to RegistroC460.Count - 1 do
     begin
        with RegistroC460.Items[intFor] do
        begin
          strRegistroC460 := strRegistroC460 + LFill('C460') +
                                               LFill( COD_MOD ) +
                                               LFill( COD_SIT ) +
                                               LFill( NUM_DOC,8 ) +
                                               LFill( DT_DOC ) +
                                               LFill( VL_DOC,0,2 ) +
                                               LFill( VL_PIS,0,2 ) +
                                               LFill( VL_COFINS,0,2 ) +
                                               LFill( CPF_CNPJ ) +
                                               LFill( NOM_ADQ ) +
                                               Delimitador +
                                               #13#10;
        end;
        RegistroC990.QTD_LIN_C := RegistroC990.QTD_LIN_C + 1;
     end;
  end;
  Result := strRegistroC460;
end;

function TBloco_C.WriteRegistroC470: AnsiString;
var
intFor: integer;
strRegistroC470: AnsiString;
begin
  strRegistroC470 := '';

  if Assigned( RegistroC470 ) then
  begin
     for intFor := 0 to RegistroC470.Count - 1 do
     begin
        with RegistroC470.Items[intFor] do
        begin
          strRegistroC470 := strRegistroC470 + LFill('C470') +
                                               LFill( COD_ITEM,6 ) +
                                               LFill( QTD,0,3 ) +
                                               LFill( QTD_CANC,0,3 ) +
                                               LFill( UNID,6 ) +
                                               LFill( VL_ITEM,0,2 ) +
                                               LFill( CST_ICMS,3 ) +
                                               LFill( CFOP,4 ) +
                                               LFill( ALIQ_ICMS,6,2 ) +
                                               LFill( VL_PIS,0,2 ) +
                                               LFill( VL_COFINS,0,2 ) +
                                               Delimitador +
                                               #13#10;
        end;
        RegistroC990.QTD_LIN_C := RegistroC990.QTD_LIN_C + 1;
     end;
  end;
  Result := strRegistroC470;
end;

function TBloco_C.WriteRegistroC490: AnsiString;
var
intFor: integer;
strRegistroC490: AnsiString;
begin
  strRegistroC490 := '';

  if Assigned( RegistroC490 ) then
  begin
     for intFor := 0 to RegistroC490.Count - 1 do
     begin
        with RegistroC490.Items[intFor] do
        begin
          strRegistroC490 := strRegistroC490 + LFill('C490') +
                                               LFill( CST_ICMS,3 ) +
                                               LFill( CFOP,4 ) +
                                               LFill( ALIQ_ICMS,6,2 ) +
                                               LFill( VL_OPR,0,2 ) +
                                               LFill( VL_BC_ICMS,0,2 ) +
                                               LFill( VL_ICMS,0,2 ) +
                                               LFill( COD_OBS ) +
                                               Delimitador +
                                               #13#10;
        end;
        RegistroC990.QTD_LIN_C := RegistroC990.QTD_LIN_C + 1;
     end;
  end;
  Result := strRegistroC490;
end;

function TBloco_C.WriteRegistroC495: AnsiString;
var
intFor: integer;
strRegistroC495: AnsiString;
begin
  strRegistroC495 := '';

  if Assigned( RegistroC495 ) then
  begin
     for intFor := 0 to RegistroC495.Count - 1 do
     begin
        with RegistroC495.Items[intFor] do
        begin
          strRegistroC495 := strRegistroC495 + LFill('C495') +
                                               LFill( ALIQ_ICMS,6,2 ) +
                                               LFill( COD_ITEM,13 ) +
                                               LFill( QTD,0,3 ) +
                                               LFill( QTD_CANC,0,3 ) +
                                               LFill( UNID ) +
                                               LFill( VL_ITEM,0,2 ) +
                                               LFill( VL_DESC,0,2 ) +
                                               LFill( VL_CANC,0,2 ) +
                                               LFill( VL_ACMO,0,2 ) +
                                               LFill( VL_BC_ICMS,0,2 ) +
                                               LFill( VL_ICMS,0,2 ) +
                                               LFill( VL_ISEN,0,2 ) +
                                               LFill( VL_NT,0,2 ) +
                                               LFill( VL_ICMS_ST,0,2 ) +
                                               Delimitador +
                                               #13#10;
        end;
        RegistroC990.QTD_LIN_C := RegistroC990.QTD_LIN_C + 1;
     end;
  end;
  Result := strRegistroC495;
end;

function TBloco_C.WriteRegistroC500: AnsiString;
var
intFor: integer;
strRegistroC500: AnsiString;
begin
  strRegistroC500 := '';

  if Assigned( RegistroC500 ) then
  begin
     for intFor := 0 to RegistroC500.Count - 1 do
     begin
        with RegistroC500.Items[intFor] do
        begin
          strRegistroC500 := strRegistroC500 + LFill('C500') +
                                               LFill( IND_OPER,1 ) +
                                               LFill( IND_EMIT,1 ) +
                                               LFill( COD_PART ) +
                                               LFill( COD_MOD,2 ) +
                                               LFill( COD_SIT,2 ) +
                                               LFill( SER,4 ) +
                                               LFill( SUB,3 ) +
                                               LFill( COD_CONS,2 ) +
                                               LFill( NUM_DOC,9 ) +
                                               LFill( DT_DOC ) +
                                               LFill( DT_E_S ) +
                                               LFill( VL_DOC,0,2 ) +
                                               LFill( VL_DESC,0,2 ) +
                                               LFill( VL_FORN,0,2 ) +
                                               LFill( VL_SERV_NT,0,2 ) +
                                               LFill( VL_TERC,0,2 ) +
                                               LFill( VL_DA,0,2 ) +
                                               LFill( VL_BC_ICMS,0,2 ) +
                                               LFill( VL_ICMS,0,2 ) +
                                               LFill( VL_BC_ICMS_ST,0,2 ) +
                                               LFill( VL_ICMS_ST,0,2 ) +
                                               LFill( COD_INF,6 ) +
                                               LFill( VL_PIS,0,2 ) +
                                               LFill( VL_COFINS,0,2 ) +
                                               LFill( TP_LIGACAO ) +
                                               LFill( COD_GRUPO_TENSAO ) +
                                               Delimitador +
                                               #13#10;
        end;
        RegistroC990.QTD_LIN_C := RegistroC990.QTD_LIN_C + 1;
     end;
  end;
  Result := strRegistroC500;
end;

function TBloco_C.WriteRegistroC510: AnsiString;
var
intFor: integer;
strRegistroC510: AnsiString;
begin
  strRegistroC510 := '';

  if Assigned( RegistroC510 ) then
  begin
     for intFor := 0 to RegistroC510.Count - 1 do
     begin
        with RegistroC510.Items[intFor] do
        begin
          strRegistroC510 := strRegistroC510 + LFill('C510') +
                                               LFill( NUM_ITEM,3 ) +
                                               LFill( COD_ITEM ) +
                                               LFill( COD_CLASS,4 ) +
                                               LFill( QTD,0,3 ) +
                                               LFill( UNID ) +
                                               LFill( VL_ITEM,0,2 ) +
                                               LFill( VL_DESC,0,2 ) +
                                               LFill( CST_ICMS,3 ) +
                                               LFill( CFOP,4 ) +
                                               LFill( VL_BC_ICMS,0,2 ) +
                                               LFill( ALIQ_ICMS,0,2 ) +
                                               LFill( VL_ICMS,0,2 ) +
                                               LFill( VL_BC_ICMS_ST,0,2 ) +
                                               LFill( ALIQ_ST,0,2 ) +
                                               LFill( VL_ICMS_ST,0,2 ) +
                                               LFill( IND_REC,1 ) +
                                               LFill( COD_PART  ) +
                                               LFill( VL_PIS,0,2 ) +
                                               LFill( VL_COFINS,0,2 ) +
                                               LFill( COD_CTA ) +
                                               Delimitador +
                                               #13#10;
        end;
        RegistroC990.QTD_LIN_C := RegistroC990.QTD_LIN_C + 1;
     end;
  end;
  Result := strRegistroC510;
end;

function TBloco_C.WriteRegistroC590: AnsiString;
var
intFor: integer;
strRegistroC590: AnsiString;
begin
  strRegistroC590 := '';

  if Assigned( RegistroC590 ) then
  begin
     for intFor := 0 to RegistroC590.Count - 1 do
     begin
        with RegistroC590.Items[intFor] do
        begin
          strRegistroC590 := strRegistroC590 + LFill('C590') +
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
        RegistroC990.QTD_LIN_C := RegistroC990.QTD_LIN_C + 1;
     end;
  end;
  Result := strRegistroC590;
end;

function TBloco_C.WriteRegistroC600: AnsiString;
var
intFor: integer;
strRegistroC600: AnsiString;
begin
  strRegistroC600 := '';

  if Assigned( RegistroC600 ) then
  begin
     for intFor := 0 to RegistroC600.Count - 1 do
     begin
        with RegistroC600.Items[intFor] do
        begin
          strRegistroC600 := strRegistroC600 + LFill('C600') +
                                               LFill( COD_MOD,2 ) +
                                               LFill( COD_MUN ,7 ) +
                                               LFill( SER,4 ) +
                                               LFill( SUB,3 ) +
                                               LFill( COD_CONS,2 ) +
                                               LFill( QTD_CONS,0,2 ) +
                                               LFill( QTD_CANC,0,2 ) +
                                               LFill( DT_DOC ) +
                                               LFill( VL_DOC,0,2 ) +
                                               LFill( VL_DESC,0,2 ) +
                                               LFill( CONS,0,2 ) +
                                               LFill( VL_FORN,0,2 ) +
                                               LFill( VL_SERV_NT,0,2 ) +
                                               LFill( VL_TERC,0,2 ) +
                                               LFill( VL_DA,0,2 ) +
                                               LFill( VL_BC_ICMS,0,2 ) +
                                               LFill( VL_ICMS,0,2 ) +
                                               LFill( VL_BC_ICMS_ST,0,2 ) +
                                               LFill( VL_ICMS_ST,0,2 ) +
                                               LFill( VL_PIS,0,2 ) +
                                               LFill( VL_COFINS,0,2 ) +
                                               Delimitador +
                                               #13#10;
        end;
        RegistroC990.QTD_LIN_C := RegistroC990.QTD_LIN_C + 1;
     end;
  end;
  Result := strRegistroC600;
end;

function TBloco_C.WriteRegistroC601: AnsiString;
var
intFor: integer;
strRegistroC601: AnsiString;
begin
  strRegistroC601 := '';

  if Assigned( RegistroC601 ) then
  begin
     for intFor := 0 to RegistroC601.Count - 1 do
     begin
        with RegistroC601.Items[intFor] do
        begin
          strRegistroC601 := strRegistroC601 + LFill('C601') +
                                               LFill( NUM_DOC_CANC ) +
                                               Delimitador +
                                               #13#10;
        end;
        RegistroC990.QTD_LIN_C := RegistroC990.QTD_LIN_C + 1;
     end;
  end;
  Result := strRegistroC601;
end;

function TBloco_C.WriteRegistroC610: AnsiString;
var
intFor: integer;
strRegistroC610: AnsiString;
begin
  strRegistroC610 := '';

  if Assigned( RegistroC610 ) then
  begin
     for intFor := 0 to RegistroC610.Count - 1 do
     begin
        with RegistroC610.Items[intFor] do
        begin
          strRegistroC610 := strRegistroC610 + LFill('C610') +
                                               LFill( COD_CLASS,4 ) +
                                               LFill( COD_ITEM ) +
                                               LFill( QTD,0,3 ) +
                                               LFill( UNID ) +
                                               LFill( VL_ITEM,0,2 ) +
                                               LFill( VL_DESC,0,2 ) +
                                               LFill( CST_ICMS,3 ) +
                                               LFill( CFOP,4 ) +
                                               LFill( ALIQ_ICMS,0,3 ) +
                                               LFill( VL_BC_ICMS,0,2 ) +
                                               LFill( VL_ICMS,0,2 ) +
                                               LFill( VL_BC_ICMS_ST,0,2 ) +
                                               LFill( VL_ICMS_ST,0,2 ) +
                                               LFill( VL_PIS,0,2 ) +
                                               LFill( VL_COFINS,0,2 ) +
                                               LFill( COD_CTA ) +
                                               Delimitador +
                                               #13#10;
        end;
        RegistroC990.QTD_LIN_C := RegistroC990.QTD_LIN_C + 1;
     end;
  end;
  Result := strRegistroC610;
end;

function TBloco_C.WriteRegistroC620: AnsiString;
var
intFor: integer;
strRegistroC620: AnsiString;
begin
  strRegistroC620 := '';

  if Assigned( RegistroC620 ) then
  begin
     for intFor := 0 to RegistroC620.Count - 1 do
     begin
        with RegistroC620.Items[intFor] do
        begin
          strRegistroC620 := strRegistroC620 + LFill('C620') +
                                               LFill( VL_FCP,0,00 ) +
                                               LFill( IND_F0 ) +
                                               Delimitador +
                                               #13#10;
        end;
        RegistroC990.QTD_LIN_C := RegistroC990.QTD_LIN_C + 1;
     end;
  end;
  Result := strRegistroC620;
end;

function TBloco_C.WriteRegistroC690: AnsiString;
var
intFor: integer;
strRegistroC690: AnsiString;
begin
  strRegistroC690 := '';

  if Assigned( RegistroC690 ) then
  begin
     for intFor := 0 to RegistroC690.Count - 1 do
     begin
        with RegistroC690.Items[intFor] do
        begin
          strRegistroC690 := strRegistroC690 + LFill('C690') +
                                               LFill( CST_ICMS,3 ) +
                                               LFill( CFOP,4 ) +
                                               LFill( ALIQ_ICMS,6,2 ) +
                                               LFill( VL_OPR,0,2 ) +
                                               LFill( VL_BC_ICMS,0,2 ) +
                                               LFill( VL_ICMS,0,2 ) +
                                               LFill( VL_RED_BC,0,2 ) +
                                               LFill( VL_RED_BC,0,2 ) +
                                               LFill( VL_BC_ICMS_ST,0,2 ) +
                                               LFill( VL_ICMS_ST,0,2 ) +
                                               Delimitador +
                                               #13#10;
        end;
        RegistroC990.QTD_LIN_C := RegistroC990.QTD_LIN_C + 1;
     end;
  end;
  Result := strRegistroC690;
end;

function TBloco_C.WriteRegistroC700: AnsiString;
var
intFor: integer;
strRegistroC700: AnsiString;
begin
  strRegistroC700 := '';

  if Assigned( RegistroC700 ) then
  begin
     for intFor := 0 to RegistroC700.Count - 1 do
     begin
        with RegistroC700.Items[intFor] do
        begin
          strRegistroC700 := strRegistroC700 + LFill('C700') +
                                               LFill( COD_MOD,2 ) +
                                               LFill( SER,4 ) +
                                               LFill( NRO_ORD_INI,9 ) +
                                               LFill( NRO_ORD_FIN,9 ) +
                                               LFill( DT_DOC_INI ) +
                                               LFill( DT_DOC_FIN ) +
                                               LFill( NOM_MEST ) +
                                               LFill( CHV_COD_DIG ) +
                                               Delimitador +
                                               #13#10;
        end;
        RegistroC990.QTD_LIN_C := RegistroC990.QTD_LIN_C + 1;
     end;
  end;
  Result := strRegistroC700;
end;

function TBloco_C.WriteRegistroC790: AnsiString;
var
intFor: integer;
strRegistroC790: AnsiString;
begin
  strRegistroC790 := '';

  if Assigned( RegistroC790 ) then
  begin
     for intFor := 0 to RegistroC790.Count - 1 do
     begin
        with RegistroC790.Items[intFor] do
        begin
          strRegistroC790 := strRegistroC790 + LFill('C790') +
                                               LFill( CST_ICMS,3 ) +
                                               LFill( CFOP,4 ) +
                                               LFill( ALIQ_ICMS,6,2 ) +
                                               LFill( VL_OPR,0,2 ) +
                                               LFill( VL_BC_ICMS,0,2 ) +
                                               LFill( VL_ICMS,0,2 ) +
                                               LFill( VL_BC_ICMS_ST,0,2 ) +
                                               LFill( VL_ICMS_ST,0,2 ) +
                                               LFill( VL_RED_BC,0,2 ) +
                                               LFill( COD_OBS ) +
                                               Delimitador +
                                               #13#10;
        end;
        RegistroC990.QTD_LIN_C := RegistroC990.QTD_LIN_C + 1;
     end;
  end;
  Result := strRegistroC790;
end;

function TBloco_C.WriteRegistroC791: AnsiString;
var
intFor: integer;
strRegistroC791: AnsiString;
begin
  strRegistroC791 := '';

  if Assigned( RegistroC791 ) then
  begin
     for intFor := 0 to RegistroC791.Count - 1 do
     begin
        with RegistroC791.Items[intFor] do
        begin
          strRegistroC791 := strRegistroC791 + LFill('C791') +
                                               LFill( UF ) +
                                               LFill( VL_BC_ICMS_ST,0,2 ) +
                                               LFill( VL_ICMS_ST,0,2 ) +
                                               Delimitador +
                                               #13#10;
        end;
        RegistroC990.QTD_LIN_C := RegistroC990.QTD_LIN_C + 1;
     end;
  end;
  Result := strRegistroC791;
end;

function TBloco_C.WriteRegistroC990: AnsiString;
begin
  Result := '';

  if Assigned(RegistroC990) then
  begin
     with RegistroC990 do
     begin
       QTD_LIN_C := QTD_LIN_C + 1;
       ///
       Result := LFill('C990') +
                 LFill(QTD_LIN_C,0) +
                 Delimitador +
                 #13#10;
     end;
  end;
end;

end.
