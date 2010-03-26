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

uses SysUtils, Classes, DateUtils, ACBrSped, ACBrEFDBloco_C,
     ACBrEFDBloco_0_Class;

type
  /// TBLOCO_C -
  TBloco_C = class(TACBrSPED)
  private
    FBloco_0: TBloco_0;
    FRegistroC001: TRegistroC001;      /// BLOCO C - RegistroC001
    FRegistroC100: TRegistroC100List;  /// BLOCO C - Lista de RegistroC100
    FRegistroC197: TRegistroC197List;  /// BLOCO C - Lista de RegistroC197
    FRegistroC300: TRegistroC300List;  /// BLOCO C - Lista de RegistroC300
    FRegistroC310: TRegistroC310List;  /// BLOCO C - Lista de RegistroC310
    FRegistroC320: TRegistroC320List;  /// BLOCO C - Lista de RegistroC320
    FRegistroC321: TRegistroC321List;  /// BLOCO C - Lista de RegistroC321
    FRegistroC350: TRegistroC350List;  /// BLOCO C - Lista de RegistroC350
    FRegistroC400: TRegistroC400List;  /// BLOCO C - Lista de RegistroC400
    FRegistroC495: TRegistroC495List;  /// BLOCO C - Lista de RegistroC495
    FRegistroC500: TRegistroC500List;  /// BLOCO C - Lista de RegistroC500
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
    FRegistroC112Count: Integer;
    FRegistroC113Count: Integer;
    FRegistroC114Count: Integer;
    FRegistroC115Count: Integer;
    FRegistroC111Count: Integer;
    FRegistroC120Count: Integer;
    FRegistroC130Count: Integer;
    FRegistroC140Count: Integer;
    FRegistroC141Count: Integer;
    FRegistroC160Count: Integer;
    FRegistroC165Count: Integer;
    FRegistroC170Count: Integer;
    FRegistroC171Count: Integer;
    FRegistroC172Count: Integer;
    FRegistroC173Count: Integer;
    FRegistroC174Count: Integer;
    FRegistroC175Count: Integer;
    FRegistroC176Count: Integer;
    FRegistroC177Count: Integer;
    FRegistroC178Count: Integer;
    FRegistroC179Count: Integer;
    FRegistroC190Count: Integer;
    FRegistroC195Count: Integer;
    FRegistroC370Count: Integer;
    FRegistroC390Count: Integer;
    FRegistroC405Count: Integer;
    FRegistroC410Count: Integer;
    FRegistroC420Count: Integer;
    FRegistroC425Count: Integer;
    FRegistroC460Count: Integer;
    FRegistroC470Count: Integer;
    FRegistroC490Count: Integer;
    FRegistroC510Count: Integer;
    FRegistroC590Count: Integer;

    function WriteRegistroC110(RegC100: TRegistroC100): AnsiString;
    function WriteRegistroC111(RegC110: TRegistroC110): AnsiString;
    function WriteRegistroC112(RegC110: TRegistroC110): AnsiString;
    function WriteRegistroC113(RegC110: TRegistroC110): AnsiString;
    function WriteRegistroC114(RegC110: TRegistroC110): AnsiString;
    function WriteRegistroC115(RegC110: TRegistroC110): AnsiString;
    function WriteRegistroC120(RegC100: TRegistroC100): AnsiString;
    function WriteRegistroC130(RegC100: TRegistroC100): AnsiString;
    function WriteRegistroC140(RegC100: TRegistroC100): AnsiString;
    function WriteRegistroC141(RegC140: TRegistroC140): AnsiString;
    function WriteRegistroC160(RegC100: TRegistroC100): AnsiString;
    function WriteRegistroC165(RegC100: TRegistroC100): AnsiString;
    function WriteRegistroC170(RegC100: TRegistroC100): AnsiString;
    function WriteRegistroC171(RegC170: TRegistroC170): AnsiString;
    function WriteRegistroC172(RegC170: TRegistroC170): AnsiString;
    function WriteRegistroC173(RegC170: TRegistroC170): AnsiString;
    function WriteRegistroC174(RegC170: TRegistroC170): AnsiString;
    function WriteRegistroC175(RegC170: TRegistroC170): AnsiString;
    function WriteRegistroC176(RegC170: TRegistroC170): AnsiString;
    function WriteRegistroC177(RegC170: TRegistroC170): AnsiString;
    function WriteRegistroC178(RegC170: TRegistroC170): AnsiString;
    function WriteRegistroC179(RegC170: TRegistroC170): AnsiString;
    function WriteRegistroC190(RegC100: TRegistroC100): AnsiString;  {Jean Barreiros 17Nov2009}
    function WriteRegistroC195(RegC100: TRegistroC100): AnsiString;
    function WriteRegistroC370(RegC350: TRegistroC350): AnsiString;
    function WriteRegistroC390(RegC350: TRegistroC350): AnsiString;
    function WriteRegistroC405(RegC400: TRegistroC400): AnsiString;
    function WriteRegistroC410(RegC405: TRegistroC405): AnsiString;
    function WriteRegistroC420(RegC405: TRegistroC405): AnsiString;
    function WriteRegistroC460(RegC405: TRegistroC405): AnsiString;
    function WriteRegistroC490(RegC405: TRegistroC405): AnsiString;
    function WriteRegistroC425(RegC420: TRegistroC420): AnsiString;
    function WriteRegistroC470(RegC460: TRegistroC460): AnsiString;
    function WriteRegistroC510(RegC500: TRegistroC500): AnsiString;
    function WriteRegistroC590(RegC500: TRegistroC500): AnsiString;

    procedure CriaRegistros;
    procedure LiberaRegistros;
  public
    constructor Create(AOwner: TComponent); override; /// Create
    destructor Destroy; override; /// Destroy
    procedure LimpaRegistros;

    function WriteRegistroC001: AnsiString;
    function WriteRegistroC100: AnsiString;
    function WriteRegistroC197: AnsiString;
    function WriteRegistroC300: AnsiString;
    function WriteRegistroC310: AnsiString;
    function WriteRegistroC320: AnsiString;
    function WriteRegistroC321: AnsiString;
    function WriteRegistroC350: AnsiString;
    function WriteRegistroC400: AnsiString;
    function WriteRegistroC495: AnsiString;
    function WriteRegistroC500: AnsiString;
    function WriteRegistroC600: AnsiString;
    function WriteRegistroC601: AnsiString;
    function WriteRegistroC610: AnsiString;
    function WriteRegistroC620: AnsiString;
    function WriteRegistroC690: AnsiString;
    function WriteRegistroC700: AnsiString;
    function WriteRegistroC790: AnsiString;
    function WriteRegistroC791: AnsiString;
    function WriteRegistroC990: AnsiString;

    property Bloco_0: TBloco_0 read FBloco_0 write FBloco_0;
    property RegistroC001: TRegistroC001 read FRegistroC001 write FRegistroC001;
    property RegistroC100: TRegistroC100List read FRegistroC100 write FRegistroC100;
    property RegistroC197: TRegistroC197List read FRegistroC197 write FRegistroC197;
    property RegistroC300: TRegistroC300List read FRegistroC300 write FRegistroC300;
    property RegistroC310: TRegistroC310List read FRegistroC310 write FRegistroC310;
    property RegistroC320: TRegistroC320List read FRegistroC320 write FRegistroC320;
    property RegistroC321: TRegistroC321List read FRegistroC321 write FRegistroC321;
    property RegistroC350: TRegistroC350List read FRegistroC350 write FRegistroC350;
    property RegistroC400: TRegistroC400List read FRegistroC400 write FRegistroC400;
    property RegistroC495: TRegistroC495List read FRegistroC495 write FRegistroC495;
    property RegistroC500: TRegistroC500List read FRegistroC500 write FRegistroC500;
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
    property RegistroC112Count: Integer read FRegistroC112Count write FRegistroC112Count;
    property RegistroC113Count: Integer read FRegistroC113Count write FRegistroC113Count;
    property RegistroC114Count: Integer read FRegistroC114Count write FRegistroC114Count;
    property RegistroC115Count: Integer read FRegistroC115Count write FRegistroC115Count;
    property RegistroC120Count: Integer read FRegistroC120Count write FRegistroC120Count;
    property RegistroC130Count: Integer read FRegistroC130Count write FRegistroC130Count;
    property RegistroC140Count: Integer read FRegistroC140Count write FRegistroC140Count; {Márcio Lopes 30Nov2009}
    property RegistroC141Count: Integer read FRegistroC141Count write FRegistroC141Count; {Márcio Lopes 30Nov2009}
    property RegistroC160Count: Integer read FRegistroC160Count write FRegistroC160Count;
    property RegistroC165Count: Integer read FRegistroC165Count write FRegistroC165Count;
    property RegistroC170Count: Integer read FRegistroC170Count write FRegistroC170Count;
    property RegistroC171Count: Integer read FRegistroC171Count write FRegistroC171Count;
    property RegistroC172Count: Integer read FRegistroC172Count write FRegistroC172Count;
    property RegistroC173Count: Integer read FRegistroC173Count write FRegistroC173Count;
    property RegistroC174Count: Integer read FRegistroC174Count write FRegistroC174Count;
    property RegistroC175Count: Integer read FRegistroC175Count write FRegistroC175Count;
    property RegistroC176Count: Integer read FRegistroC176Count write FRegistroC176Count;
    property RegistroC177Count: Integer read FRegistroC177Count write FRegistroC177Count;
    property RegistroC178Count: Integer read FRegistroC178Count write FRegistroC178Count;
    property RegistroC179Count: Integer read FRegistroC179Count write FRegistroC179Count;
    property RegistroC190Count: Integer read FRegistroC190Count write FRegistroC190Count; {Jean Barreiros 17Nov2009}
    property RegistroC195Count: Integer read FRegistroC195Count write FRegistroC195Count;
    property RegistroC370Count: Integer read FRegistroC370Count write FRegistroC370Count;
    property RegistroC390Count: Integer read FRegistroC390Count write FRegistroC390Count;
    property RegistroC405Count: Integer read FRegistroC405Count write FRegistroC405Count;
    property RegistroC410Count: Integer read FRegistroC410Count write FRegistroC410Count;
    property RegistroC420Count: Integer read FRegistroC420Count write FRegistroC420Count;
    property RegistroC425Count: Integer read FRegistroC425Count write FRegistroC425Count;
    property RegistroC460Count: Integer read FRegistroC460Count write FRegistroC460Count;
    property RegistroC470Count: Integer read FRegistroC470Count write FRegistroC470Count;
    property RegistroC490Count: Integer read FRegistroC490Count write FRegistroC490Count;
    property RegistroC510Count: Integer read FRegistroC510Count write FRegistroC510Count; { Márcio Lopes 20Dez2009 }
    property RegistroC590Count: Integer read FRegistroC590Count write FRegistroC590Count; { Márcio Lopes 20Dez2009 }
  end;

implementation

uses ACBrSpedUtils;

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
  FRegistroC197 := TRegistroC197List.Create;
  FRegistroC300 := TRegistroC300List.Create;
  FRegistroC310 := TRegistroC310List.Create;
  FRegistroC320 := TRegistroC320List.Create;
  FRegistroC321 := TRegistroC321List.Create;
  FRegistroC350 := TRegistroC350List.Create;
  FRegistroC400 := TRegistroC400List.Create;
  FRegistroC495 := TRegistroC495List.Create;
  FRegistroC500 := TRegistroC500List.Create;
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
  FRegistroC112Count := 0;
  FRegistroC113Count := 0;
  FRegistroC114Count := 0;
  FRegistroC115Count := 0;
  FRegistroC120Count := 0;
  FRegistroC130Count := 0;
  FRegistroC140Count := 0;
  FRegistroC141Count := 0;
  FRegistroC160Count := 0;
  FRegistroC165Count := 0;
  FRegistroC170Count := 0;
  FRegistroC171Count := 0;
  FRegistroC172Count := 0;
  FRegistroC173Count := 0;
  FRegistroC174Count := 0;
  FRegistroC175Count := 0;
  FRegistroC176Count := 0;
  FRegistroC177Count := 0;
  FRegistroC178Count := 0;
  FRegistroC179Count := 0;
  FRegistroC190Count := 0;  {Jean Barreiros 18Nov2009}
  FRegistroC195Count := 0;
  FRegistroC370Count := 0;
  FRegistroC390Count := 0;
  FRegistroC405Count := 0;
  FRegistroC410Count := 0;
  FRegistroC420Count := 0;
  FRegistroC425Count := 0;
  FRegistroC460Count := 0;
  FRegistroC470Count := 0;
  FRegistroC490Count := 0;  {Fernando Krause 18Jan2010}
  FRegistroC510Count := 0;
  FRegistroC590Count := 0;

  FRegistroC990.QTD_LIN_C := 0;
end;

procedure TBloco_C.LiberaRegistros;
begin
  FRegistroC001.Free;
  FRegistroC100.Free;
  FRegistroC197.Free;
  FRegistroC300.Free;
  FRegistroC310.Free;
  FRegistroC320.Free;
  FRegistroC321.Free;
  FRegistroC350.Free;
  FRegistroC400.Free;
  FRegistroC495.Free;
  FRegistroC500.Free;
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
          begin
            DT_DOC := 0;
            DT_E_S := 0;
            booNFCancelada := true
          end
          else
            booNFCancelada := false;
          //
          strRegistroC100 := strRegistroC100 + LFill('C100') +
                                               LFill( IND_OPER ) +
                                               LFill( IND_EMIT ) +
                                               LFill( COD_PART ) +
                                               LFill( COD_MOD  ) +
                                               LFill( COD_SIT  ) +
                                               LFill( SER  ) +
                                               LFill( NUM_DOC  ) +
                                               LFill( CHV_NFE  ) +
                                               LFill( DT_DOC, 'ddmmyyyy' ) +
                                               LFill( DT_E_S, 'ddmmyyyy' ) +
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
                           WriteRegistroC120( RegistroC100.Items[intFor] ) +
                           WriteRegistroC130( RegistroC100.Items[intFor] ) +
                           WriteRegistroC140( RegistroC100.Items[intFor] ) +
                           WriteRegistroC160( RegistroC100.Items[intFor] ) +
                           WriteRegistroC165( RegistroC100.Items[intFor] ) +
                           WriteRegistroC170( RegistroC100.Items[intFor] ) +
                           WriteRegistroC190( RegistroC100.Items[intFor] ) +
                           WriteRegistroC195( RegistroC100.Items[intFor] );

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
                           WriteRegistroC111( RegC100.RegistroC110.Items[intFor] ) +
                           WriteRegistroC112( RegC100.RegistroC110.Items[intFor] ) +
                           WriteRegistroC113( RegC100.RegistroC110.Items[intFor] ) +
                           WriteRegistroC114( RegC100.RegistroC110.Items[intFor] ) +
                           WriteRegistroC115( RegC100.RegistroC110.Items[intFor] );

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

function TBloco_C.WriteRegistroC112(RegC110: TRegistroC110): AnsiString;
var
intFor: integer;
strRegistroC112: AnsiString;
begin
  strRegistroC112 := '';

  if Assigned( RegC110.RegistroC112 ) then
  begin
     for intFor := 0 to RegC110.RegistroC112.Count - 1 do
     begin
        with RegC110.RegistroC112.Items[intFor] do
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
     /// Variavél para armazenar a quantidade de registro do tipo.
     FRegistroC112Count := FRegistroC112Count + RegC110.RegistroC112.Count;
  end;
  Result := strRegistroC112;
end;

function TBloco_C.WriteRegistroC113(RegC110: TRegistroC110): AnsiString;
var
intFor: integer;
strRegistroC113: AnsiString;
begin
  strRegistroC113 := '';

  if Assigned( RegC110.RegistroC113 ) then
  begin
     for intFor := 0 to RegC110.RegistroC113.Count - 1 do
     begin
        with RegC110.RegistroC113.Items[intFor] do
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
     /// Variavél para armazenar a quantidade de registro do tipo.
     FRegistroC113Count := FRegistroC113Count + RegC110.RegistroC113.Count;
  end;
  Result := strRegistroC113;
end;

function TBloco_C.WriteRegistroC114(RegC110: TRegistroC110): AnsiString;
var
intFor: integer;
strRegistroC114: AnsiString;
begin
  strRegistroC114 := '';

  if Assigned( RegC110.RegistroC114 ) then
  begin
     for intFor := 0 to RegC110.RegistroC114.Count - 1 do
     begin
        with RegC110.RegistroC114.Items[intFor] do
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
     /// Variavél para armazenar a quantidade de registro do tipo.
     FRegistroC114Count := FRegistroC114Count + RegC110.RegistroC114.Count;
  end;
  Result := strRegistroC114;
end;

function TBloco_C.WriteRegistroC115(RegC110: TRegistroC110): AnsiString;
var
intFor: integer;
strRegistroC115: AnsiString;
begin
  strRegistroC115 := '';

  if Assigned( RegC110.RegistroC115 ) then
  begin
     for intFor := 0 to RegC110.RegistroC115.Count - 1 do
     begin
        with RegC110.RegistroC115.Items[intFor] do
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
     /// Variavél para armazenar a quantidade de registro do tipo.
     FRegistroC115Count := FRegistroC115Count + RegC110.RegistroC115.Count;
  end;
  Result := strRegistroC115;
end;

function TBloco_C.WriteRegistroC120(RegC100: TRegistroC100): AnsiString;
var
intFor: integer;
strRegistroC120: AnsiString;
begin
  strRegistroC120 := '';

  if Assigned( RegC100.RegistroC120 ) then
  begin
     for intFor := 0 to RegC100.RegistroC120.Count - 1 do
     begin
        with RegC100.RegistroC120.Items[intFor] do
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
     /// Variavél para armazenar a quantidade de registro do tipo.
     FRegistroC120Count := FRegistroC120Count + RegC100.RegistroC120.Count;
  end;
  Result := strRegistroC120;
end;

function TBloco_C.WriteRegistroC130(RegC100: TRegistroC100): AnsiString;
var
intFor: integer;
strRegistroC130: AnsiString;
begin
  strRegistroC130 := '';

  if Assigned( RegC100.RegistroC130 ) then
  begin
     for intFor := 0 to RegC100.RegistroC130.Count - 1 do
     begin
        with RegC100.RegistroC130.Items[intFor] do
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
     /// Variavél para armazenar a quantidade de registro do tipo.
     FRegistroC130Count := FRegistroC130Count + RegC100.RegistroC130.Count;
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

function TBloco_C.WriteRegistroC160(RegC100: TRegistroC100): AnsiString;
var
intFor: integer;
strRegistroC160: AnsiString;
begin
  strRegistroC160 := '';

  if Assigned( RegC100.RegistroC160 ) then
  begin
     for intFor := 0 to RegC100.RegistroC160.Count - 1 do
     begin
        with RegC100.RegistroC160.Items[intFor] do
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
     /// Variavél para armazenar a quantidade de registro do tipo.
     FRegistroC160Count := FRegistroC160Count + RegC100.RegistroC160.Count;
  end;
  Result := strRegistroC160;
end;

function TBloco_C.WriteRegistroC165(RegC100: TRegistroC100): AnsiString;
var
intFor: integer;
strRegistroC165: AnsiString;
begin
  strRegistroC165 := '';

  if Assigned( RegC100.RegistroC165 ) then
  begin
     for intFor := 0 to RegC100.RegistroC165.Count - 1 do
     begin
        with RegC100.RegistroC165.Items[intFor] do
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
     /// Variavél para armazenar a quantidade de registro do tipo.
     FRegistroC165Count := FRegistroC165Count + RegC100.RegistroC165.Count;
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
                                               DFill( QTD, 5 ) +
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
                                               DFill( QUANT_BC_PIS,3 ) +
                                               DFill( ALIQ_PIS_R,4 ) +
                                               LFill( VL_PIS,0,2 ) +
                                               LFill( CST_COFINS ) +
                                               LFill( VL_BC_COFINS,0,2 ) +
                                               LFill( ALIQ_COFINS_PERC,0,2 ) +
                                               DFill( QUANT_BC_COFINS,3 ) +
                                               DFill( ALIQ_COFINS_R,4 ) +
                                               LFill( VL_COFINS,0,2 ) +
                                               LFill( COD_CTA ) +
                                               Delimitador +
                                               #13#10;
        end;
        /// Registro FILHOS do FILHO
        strRegistroC170 := strRegistroC170 +
                           WriteRegistroC171( RegC100.RegistroC170.Items[intFor] ) +
                           WriteRegistroC172( RegC100.RegistroC170.Items[intFor] ) +
                           WriteRegistroC173( RegC100.RegistroC170.Items[intFor] ) +
                           WriteRegistroC174( RegC100.RegistroC170.Items[intFor] ) +
                           WriteRegistroC175( RegC100.RegistroC170.Items[intFor] ) +
                           WriteRegistroC176( RegC100.RegistroC170.Items[intFor] ) +
                           WriteRegistroC177( RegC100.RegistroC170.Items[intFor] ) +
                           WriteRegistroC178( RegC100.RegistroC170.Items[intFor] ) +
                           WriteRegistroC179( RegC100.RegistroC170.Items[intFor] );

        RegistroC990.QTD_LIN_C := RegistroC990.QTD_LIN_C + 1;
     end;
     /// Variavél para armazenar a quantidade de registro do tipo.
     FRegistroC170Count := FRegistroC170Count + RegC100.RegistroC170.Count;
  end;
  Result := strRegistroC170;
end;

function TBloco_C.WriteRegistroC171(RegC170: TRegistroC170): AnsiString;
var
intFor: integer;
strRegistroC171: AnsiString;
begin
  strRegistroC171 := '';

  if Assigned( RegC170.RegistroC171 ) then
  begin
     for intFor := 0 to RegC170.RegistroC171.Count - 1 do
     begin
        with RegC170.RegistroC171.Items[intFor] do
        begin
          strRegistroC171 := strRegistroC171 + LFill('C171') +
                                               LFill( NUM_TANQUE,3 ) +
                                               DFill( QTDE, 3 ) +
                                               Delimitador +
                                               #13#10;
        end;
        RegistroC990.QTD_LIN_C := RegistroC990.QTD_LIN_C + 1;
     end;
     /// Variavél para armazenar a quantidade de registro do tipo.
     FRegistroC171Count := FRegistroC171Count + RegC170.RegistroC171.Count;
  end;
  Result := strRegistroC171;
end;

function TBloco_C.WriteRegistroC172(RegC170: TRegistroC170): AnsiString;
var
intFor: integer;
strRegistroC172: AnsiString;
begin
  strRegistroC172 := '';

  if Assigned( RegC170.RegistroC172 ) then
  begin
     for intFor := 0 to RegC170.RegistroC172.Count - 1 do
     begin
        with RegC170.RegistroC172.Items[intFor] do
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
     /// Variavél para armazenar a quantidade de registro do tipo.
     FRegistroC172Count := FRegistroC172Count + RegC170.RegistroC172.Count;
  end;
  Result := strRegistroC172;
end;

function TBloco_C.WriteRegistroC173(RegC170: TRegistroC170): AnsiString;
var
intFor: integer;
strRegistroC173: AnsiString;
begin
  strRegistroC173 := '';

  if Assigned( RegC170.RegistroC173 ) then
  begin
     for intFor := 0 to RegC170.RegistroC173.Count - 1 do
     begin
        with RegC170.RegistroC173.Items[intFor] do
        begin
          strRegistroC173 := strRegistroC173 + LFill('C173') +
                                               LFill( LOTE_MED ) +
                                               DFill( QTD_ITEM, 3 ) +
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
     /// Variavél para armazenar a quantidade de registro do tipo.
     FRegistroC173Count := FRegistroC173Count + RegC170.RegistroC173.Count;
  end;
  Result := strRegistroC173;
end;

function TBloco_C.WriteRegistroC174(RegC170: TRegistroC170): AnsiString;
var
intFor: integer;
strRegistroC174: AnsiString;
begin
  strRegistroC174 := '';

  if Assigned( RegC170.RegistroC174 ) then
  begin
     for intFor := 0 to RegC170.RegistroC174.Count - 1 do
     begin
        with RegC170.RegistroC174.Items[intFor] do
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
     /// Variavél para armazenar a quantidade de registro do tipo.
     FRegistroC174Count := FRegistroC174Count + RegC170.RegistroC174.Count;
  end;
  Result := strRegistroC174;
end;

function TBloco_C.WriteRegistroC175(RegC170: TRegistroC170): AnsiString;
var
intFor: integer;
strRegistroC175: AnsiString;
begin
  strRegistroC175 := '';

  if Assigned( RegC170.RegistroC175 ) then
  begin
     for intFor := 0 to RegC170.RegistroC175.Count - 1 do
     begin
        with RegC170.RegistroC175.Items[intFor] do
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
     /// Variavél para armazenar a quantidade de registro do tipo.
     FRegistroC175Count := FRegistroC175Count + RegC170.RegistroC175.Count;
  end;
  Result := strRegistroC175;
end;

function TBloco_C.WriteRegistroC176(RegC170: TRegistroC170): AnsiString;
var
intFor: integer;
strRegistroC176: AnsiString;
begin
  strRegistroC176 := '';

  if Assigned( RegC170.RegistroC176 ) then
  begin
     for intFor := 0 to RegC170.RegistroC176.Count - 1 do
     begin
        with RegC170.RegistroC176.Items[intFor] do
        begin
          strRegistroC176 := strRegistroC176 + LFill('C176') +
                                               LFill( COD_MOD_ULT_E ) +
                                               LFill( NUM_DOC_ULT_E ) +
                                               LFill( SER_ULT_E ) +
                                               LFill( DT_ULT_E ) +
                                               LFill( COD_PART_ULT_E ) +
                                               DFill( QUANT_ULT_E,3 ) +
                                               DFill( VL_UNIT_ULT_E,3 ) +
                                               DFill( VL_UNIT_BC_ST,3 ) +
                                               Delimitador +
                                               #13#10;
        end;
        RegistroC990.QTD_LIN_C := RegistroC990.QTD_LIN_C + 1;
     end;
     /// Variavél para armazenar a quantidade de registro do tipo.
     FRegistroC176Count := FRegistroC176Count + RegC170.RegistroC176.Count;
  end;
  Result := strRegistroC176;
end;

function TBloco_C.WriteRegistroC177(RegC170: TRegistroC170): AnsiString;
var
intFor: integer;
strRegistroC177: AnsiString;
begin
  strRegistroC177 := '';

  if Assigned( RegC170.RegistroC177 ) then
  begin
     for intFor := 0 to RegC170.RegistroC177.Count - 1 do
     begin
        with RegC170.RegistroC177.Items[intFor] do
        begin
          strRegistroC177 := strRegistroC177 + LFill('C177') +
                                               LFill( COD_SELO_IPI ) +
                                               LFill( QT_SELO_IPI,0,0 ) +
                                               Delimitador +
                                               #13#10;
        end;
        RegistroC990.QTD_LIN_C := RegistroC990.QTD_LIN_C + 1;
     end;
     /// Variavél para armazenar a quantidade de registro do tipo.
     FRegistroC177Count := FRegistroC177Count + RegC170.RegistroC177.Count;
  end;
  Result := strRegistroC177;
end;

function TBloco_C.WriteRegistroC178(RegC170: TRegistroC170): AnsiString;
var
intFor: integer;
strRegistroC178: AnsiString;
begin
  strRegistroC178 := '';

  if Assigned( RegC170.RegistroC178 ) then
  begin
     for intFor := 0 to RegC170.RegistroC178.Count - 1 do
     begin
        with RegC170.RegistroC178.Items[intFor] do
        begin
          strRegistroC178 := strRegistroC178 + LFill('C178') +
                                               LFill( CL_ENQ ) +
                                               LFill( VL_UNID,0,2 ) +
                                               DFill( QUANT_PAD, 3 ) +
                                               Delimitador +
                                               #13#10;
        end;
        RegistroC990.QTD_LIN_C := RegistroC990.QTD_LIN_C + 1;
     end;
     /// Variavél para armazenar a quantidade de registro do tipo.
     FRegistroC178Count := FRegistroC178Count + RegC170.RegistroC178.Count;
  end;
  Result := strRegistroC178;
end;

function TBloco_C.WriteRegistroC179(RegC170: TRegistroC170): AnsiString;
var
intFor: integer;
strRegistroC179: AnsiString;
begin
  strRegistroC179 := '';

  if Assigned( RegC170.RegistroC179 ) then
  begin
     for intFor := 0 to RegC170.RegistroC179.Count - 1 do
     begin
        with RegC170.RegistroC179.Items[intFor] do
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
     /// Variavél para armazenar a quantidade de registro do tipo.
     FRegistroC179Count := FRegistroC179Count + RegC170.RegistroC179.Count;
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
                                               LFill( COD_OBS ) +
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

function TBloco_C.WriteRegistroC195(RegC100: TRegistroC100): AnsiString;
var
intFor: integer;
strRegistroC195: AnsiString;
begin
  strRegistroC195 := '';

  if Assigned( RegC100.RegistroC195 ) then
  begin
     for intFor := 0 to RegC100.RegistroC195.Count - 1 do
     begin
        with RegC100.RegistroC195.Items[intFor] do
        begin
          strRegistroC195 := strRegistroC195 + LFill('C195') +
                                               LFill( COD_OBS ) +
                                               LFill( TXT_COMPL ) +
                                               Delimitador +
                                               #13#10;
        end;
        RegistroC990.QTD_LIN_C := RegistroC990.QTD_LIN_C + 1;
     end;
     /// Variavél para armazenar a quantidade de registro do tipo.
     FRegistroC195Count := FRegistroC195Count + RegC100.RegistroC195.Count;
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
                                               LFill( COD_OBS ) +
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
                                               DFill( QTD, 3 ) +
                                               LFill( UNID ) +
                                               LFill( VL_ITEM,0,2 ) +
                                               LFill( VL_DESC,0,2 ) +
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
                                               LFill( SER ) +
                                               LFill( SUB_SER ) +
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

        /// Registros FILHOS
        strRegistroC350 := strRegistroC350 +
                           WriteRegistroC370( RegistroC350.Items[intFor] ) +
                           WriteRegistroC390( RegistroC350.Items[intFor] );

        RegistroC990.QTD_LIN_C := RegistroC990.QTD_LIN_C + 1;
     end;
  end;
  Result := strRegistroC350;
end;

function TBloco_C.WriteRegistroC370(RegC350: TRegistroC350): AnsiString;
var
intFor: integer;
strRegistroC370: AnsiString;
begin
  strRegistroC370 := '';

  if Assigned( RegC350.RegistroC370 ) then
  begin
     for intFor := 0 to RegC350.RegistroC370.Count - 1 do
     begin
        with RegC350.RegistroC370.Items[intFor] do
        begin
          strRegistroC370 := strRegistroC370 + LFill('C370') +
                                               LFill( NUM_ITEM,3 ) +
                                               LFill( COD_ITEM ) +
                                               DFill( QTD, 3 ) +
                                               LFill( UNID ) +
                                               LFill( VL_ITEM,0,3 ) +
                                               LFill( VL_DESC,0,3 ) +
                                               Delimitador +
                                               #13#10;
        end;
        RegistroC990.QTD_LIN_C := RegistroC990.QTD_LIN_C + 1;
     end;
     /// Variavél para armazenar a quantidade de registro do tipo.
     FRegistroC370Count := FRegistroC370Count + RegC350.RegistroC370.Count;
  end;
  Result := strRegistroC370;
end;

function TBloco_C.WriteRegistroC390(RegC350: TRegistroC350): AnsiString;
var
  intFor: integer;
  strRegistroC390: AnsiString;
begin
  strRegistroC390 := '';

  if Assigned( RegC350.RegistroC390 ) then
  begin
     for intFor := 0 to RegC350.RegistroC390.Count - 1 do
     begin
        with RegC350.RegistroC390.Items[intFor] do
        begin
          strRegistroC390 := strRegistroC390 + LFill('C390') +
                                               LFill( CST_ICMS,3 ) +
                                               LFill( CFOP,4 ) +
                                               LFill( ALIQ_ICMS,0,2 ) +
                                               LFill( VL_OPR,0,2 ) +
                                               LFill( VL_BC_ICMS,0,2 ) +
                                               LFill( VL_ICMS,0,2 ) +
                                               LFill( VL_RED_BC,0,2 ) +
                                               LFill( COD_OBS ) +
                                               Delimitador +
                                               #13#10;
        end;
        RegistroC990.QTD_LIN_C := RegistroC990.QTD_LIN_C + 1;
     end;
     /// Variavél para armazenar a quantidade de registro do tipo.
     FRegistroC390Count := FRegistroC390Count + RegC350.RegistroC390.Count;
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
        /// Registros FILHOS
        strRegistroC400 := strRegistroC400 +
                           WriteRegistroC405( RegistroC400.Items[intFor] );

        RegistroC990.QTD_LIN_C := RegistroC990.QTD_LIN_C + 1;
     end;
  end;
  Result := strRegistroC400;
end;

function TBloco_C.WriteRegistroC405(RegC400: TRegistroC400): AnsiString;
var
intFor: integer;
strRegistroC405: AnsiString;
begin
  strRegistroC405 := '';

  if Assigned( RegC400.RegistroC405 ) then
  begin
     for intFor := 0 to RegC400.RegistroC405.Count - 1 do
     begin
        with RegC400.RegistroC405.Items[intFor] do
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
        strRegistroC405 := strRegistroC405 +
                           WriteRegistroC410( RegC400.RegistroC405.Items[intFor] ) +
                           WriteRegistroC420( RegC400.RegistroC405.Items[intFor] ) +
                           WriteRegistroC460( RegC400.RegistroC405.Items[intFor] ) +
                           WriteRegistroC490( RegC400.RegistroC405.Items[intFor] );

        RegistroC990.QTD_LIN_C := RegistroC990.QTD_LIN_C + 1;
     end;
     /// Variavél para armazenar a quantidade de registro do tipo.
     FRegistroC405Count := FRegistroC405Count + RegC400.RegistroC405.Count;
  end;
  Result := strRegistroC405;
end;

function TBloco_C.WriteRegistroC410(RegC405: TRegistroC405): AnsiString;
var
intFor: integer;
strRegistroC410: AnsiString;
begin
  strRegistroC410 := '';

  if Assigned( RegC405.RegistroC410 ) then
  begin
     for intFor := 0 to RegC405.RegistroC410.Count - 1 do
     begin
        with RegC405.RegistroC410.Items[intFor] do
        begin
          strRegistroC410 := strRegistroC410 + LFill('C410') +
                                               LFill( VL_PIS,0,2 ) +
                                               LFill( VL_COFINS,0,2) +
                                               Delimitador +
                                               #13#10;
        end;
        RegistroC990.QTD_LIN_C := RegistroC990.QTD_LIN_C + 1;
     end;
     /// Variavél para armazenar a quantidade de registro do tipo.
     FRegistroC410Count := FRegistroC410Count + RegC405.RegistroC410.Count;
  end;
  Result := strRegistroC410;
end;

function TBloco_C.WriteRegistroC420(RegC405: TRegistroC405): AnsiString;
var
intFor: integer;
strRegistroC420: AnsiString;
begin
  strRegistroC420 := '';

  if Assigned( RegC405.RegistroC420 ) then
  begin
     for intFor := 0 to RegC405.RegistroC420.Count - 1 do
     begin
        with RegC405.RegistroC420.Items[intFor] do
        begin
          strRegistroC420 := strRegistroC420 + LFill('C420') +
                                               LFill( COD_TOT_PAR ) +
                                               LFill( VLR_ACUM_TOT,0,2) +
                                               LFill( NR_TOT, 2, true) +
                                               LFill( DESCR_NR_TOT ) +
                                               Delimitador +
                                               #13#10;
        end;
        /// Registros FILHOS
        strRegistroC420 := strRegistroC420 +
                           WriteRegistroC425( RegC405.RegistroC420.Items[intFor] );

        RegistroC990.QTD_LIN_C := RegistroC990.QTD_LIN_C + 1;
     end;
     /// Variavél para armazenar a quantidade de registro do tipo.
     FRegistroC420Count := FRegistroC420Count + RegC405.RegistroC420.Count;
  end;
  Result := strRegistroC420;
end;

function TBloco_C.WriteRegistroC425(RegC420: TRegistroC420): AnsiString;
var
intFor: integer;
strRegistroC425: AnsiString;
begin
  strRegistroC425 := '';

  if Assigned( RegC420.RegistroC425 ) then
  begin
     for intFor := 0 to RegC420.RegistroC425.Count - 1 do
     begin
        with RegC420.RegistroC425.Items[intFor] do
        begin
          Check(FBloco_0.Registro0200.LocalizaRegistro(COD_ITEM), '(C-C425) ITENS: O código do item "%s" não existe no registro 0200!', [COD_ITEM]);

          strRegistroC425 := strRegistroC425 + LFill('C425') +
                                               LFill( COD_ITEM ) +
                                               DFill( QTD,3 ) +
                                               LFill( UNID ) +
                                               LFill( VL_ITEM,0,2 ) +
                                               LFill( VL_PIS ,0,2 ) +
                                               LFill( VL_COFINS ,0,2 ) +
                                               Delimitador +
                                               #13#10;
        end;
        RegistroC990.QTD_LIN_C := RegistroC990.QTD_LIN_C + 1;
     end;
     /// Variavél para armazenar a quantidade de registro do tipo.
     FRegistroC425Count := FRegistroC425Count + RegC420.RegistroC425.Count;
  end;
  Result := strRegistroC425;
end;

function TBloco_C.WriteRegistroC460(RegC405: TRegistroC405): AnsiString;
var
intFor: integer;
strRegistroC460: AnsiString;
begin
  strRegistroC460 := '';

  if Assigned( RegC405.RegistroC460 ) then
  begin
     for intFor := 0 to RegC405.RegistroC460.Count - 1 do
     begin
        with RegC405.RegistroC460.Items[intFor] do
        begin
          strRegistroC460 := strRegistroC460 + LFill('C460') +
                                               LFill( COD_MOD ) +
                                               LFill( COD_SIT ) +
                                               LFill( NUM_DOC,6 ) +
                                               LFill( DT_DOC, 'ddmmyyyy' ) +
                                               LFill( VL_DOC,0,2, true ) +
                                               LFill( VL_PIS,0,2, true ) +
                                               LFill( VL_COFINS,0,2, true ) +
                                               LFill( CPF_CNPJ ) +
                                               LFill( NOM_ADQ ) +
                                               Delimitador +
                                               #13#10;
        end;
        /// Registros FILHOS
        strRegistroC460 := strRegistroC460 +
                           WriteRegistroC470( RegC405.RegistroC460.Items[intFor] );

        RegistroC990.QTD_LIN_C := RegistroC990.QTD_LIN_C + 1;
     end;
     /// Variavél para armazenar a quantidade de registro do tipo.
     FRegistroC460Count := FRegistroC460Count + RegC405.RegistroC460.Count;
  end;
  Result := strRegistroC460;
end;

function TBloco_C.WriteRegistroC470(RegC460: TRegistroC460): AnsiString;
var
intFor: integer;
strRegistroC470: AnsiString;
begin
  strRegistroC470 := '';

  if Assigned( RegC460.RegistroC470 ) then
  begin
     for intFor := 0 to RegC460.RegistroC470.Count - 1 do
     begin
        with RegC460.RegistroC470.Items[intFor] do
        begin
          strRegistroC470 := strRegistroC470 + LFill('C470') +
                                               LFill( COD_ITEM ) +
                                               DFill( QTD,3 ) +
                                               DFill( QTD_CANC,3 ) +
                                               LFill( UNID ) +
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
     /// Variavél para armazenar a quantidade de registro do tipo.
     FRegistroC470Count := FRegistroC470Count + RegC460.RegistroC470.Count;
  end;
  Result := strRegistroC470;
end;

function TBloco_C.WriteRegistroC490(RegC405: TRegistroC405): AnsiString;
var
intFor: integer;
strRegistroC490: AnsiString;
begin
  strRegistroC490 := '';

  if Assigned( RegC405.RegistroC490 ) then
  begin
     for intFor := 0 to RegC405.RegistroC490.Count - 1 do
     begin
        with RegC405.RegistroC490.Items[intFor] do
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
     /// Variavél para armazenar a quantidade de registro do tipo.
     FRegistroC490Count := FRegistroC490Count + RegC405.RegistroC490.Count;
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
                                               LFill( COD_ITEM ) +
                                               DFill( QTD,3 ) +
                                               DFill( QTD_CANC,3 ) +
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
                                                LFill( SER ) +
                                                LFill( SUB ) +
                                                LFill( COD_CONS ) +
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
                                                LFill( COD_INF ) +
                                                LFill( VL_PIS,0,2 ) +
                                                LFill( VL_COFINS,0,2 ) +
                                                LFill( TP_LIGACAO ) +
                                                LFill( COD_GRUPO_TENSAO ) +
                                                Delimitador +
                                                #13#10;
        end;
        /// Registro FILHOS do FILHO
        strRegistroC500 := strRegistroC500 +
                           WriteRegistroC510( RegistroC500.Items[intFor] ) +
                           WriteRegistroC590( RegistroC500.Items[intFor] );

        RegistroC990.QTD_LIN_C := RegistroC990.QTD_LIN_C + 1;
     end;
  end;
  Result := strRegistroC500;
end;

function TBloco_C.WriteRegistroC510(RegC500:TRegistroC500) : AnsiString;
var
intFor: integer;
strRegistroC510: AnsiString;
begin
  strRegistroC510 := '';

  if Assigned( RegC500.RegistroC510 ) then
  begin
     for intFor := 0 to RegC500.RegistroC510.Count - 1 do
     begin
        with RegC500.RegistroC510.Items[intFor] do
        begin
          strRegistroC510 := strRegistroC510 + LFill('C510') +
                                               LFill( NUM_ITEM,3 ) +
                                               LFill( COD_ITEM ) +
                                               LFill( COD_CLASS,4 ) +
                                               DFill( QTD,3 ) +
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
     /// Variavél para armazenar a quantidade de registro do tipo.
     FRegistroC510Count := FRegistroC510Count + RegC500.RegistroC510.Count;
  end;
  Result := strRegistroC510;
end;

function TBloco_C.WriteRegistroC590(RegC500:TRegistroC500): AnsiString;
var
intFor: integer;
strRegistroC590: AnsiString;
begin
  strRegistroC590 := '';

  if Assigned( RegC500.RegistroC590 ) then
  begin
     for intFor := 0 to RegC500.RegistroC590.Count - 1 do
     begin
        with RegC500.RegistroC590.Items[intFor] do
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
     /// Variavél para armazenar a quantidade de registro do tipo.
     FRegistroC590Count := FRegistroC590Count + RegC500.RegistroC590.Count;
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
                                               LFill( QTD,3 ) +
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
