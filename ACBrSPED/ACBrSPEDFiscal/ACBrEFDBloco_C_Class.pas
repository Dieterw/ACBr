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
     ACBrEFDBloco_0_Class, ACBrEFDBlocos;

type
  /// TBLOCO_C -
  TBloco_C = class(TACBrSPED)
  private
    FBloco_0: TBloco_0;

    FRegistroC001: TRegistroC001;      /// BLOCO C - RegistroC001
    FRegistroC990: TRegistroC990;      /// BLOCO C - RegistroC990

    FRegistroC100Count: Integer;
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
    FRegistroC197Count: Integer;
    FRegistroC300Count: Integer;
    FRegistroC310Count: Integer;
    FRegistroC320Count: Integer;
    FRegistroC321Count: Integer;
    FRegistroC350Count: Integer;
    FRegistroC370Count: Integer;
    FRegistroC390Count: Integer;
    FRegistroC400Count: Integer;
    FRegistroC405Count: Integer;
    FRegistroC410Count: Integer;
    FRegistroC420Count: Integer;
    FRegistroC425Count: Integer;
    FRegistroC460Count: Integer;
    FRegistroC470Count: Integer;
    FRegistroC490Count: Integer;
    FRegistroC495Count: Integer;
    FRegistroC500Count: Integer;
    FRegistroC510Count: Integer;
    FRegistroC590Count: Integer;
    FRegistroC600Count: Integer;
    FRegistroC601Count: Integer;
    FRegistroC610Count: Integer;
    FRegistroC690Count: Integer;
    FRegistroC700Count: Integer;
    FRegistroC790Count: Integer;
    FRegistroC791Count: Integer;

    function WriteRegistroC100(RegC001: TRegistroC001): String;
    function WriteRegistroC110(RegC100: TRegistroC100): String;
    function WriteRegistroC111(RegC110: TRegistroC110): String;
    function WriteRegistroC112(RegC110: TRegistroC110): String;
    function WriteRegistroC113(RegC110: TRegistroC110): String;
    function WriteRegistroC114(RegC110: TRegistroC110): String;
    function WriteRegistroC115(RegC110: TRegistroC110): String;
    function WriteRegistroC120(RegC100: TRegistroC100): String;
    function WriteRegistroC130(RegC100: TRegistroC100): String;
    function WriteRegistroC140(RegC100: TRegistroC100): String;
    function WriteRegistroC141(RegC140: TRegistroC140): String;
    function WriteRegistroC160(RegC100: TRegistroC100): String;
    function WriteRegistroC165(RegC100: TRegistroC100): String;
    function WriteRegistroC170(RegC100: TRegistroC100): String;
    function WriteRegistroC171(RegC170: TRegistroC170): String;
    function WriteRegistroC172(RegC170: TRegistroC170): String;
    function WriteRegistroC173(RegC170: TRegistroC170): String;
    function WriteRegistroC174(RegC170: TRegistroC170): String;
    function WriteRegistroC175(RegC170: TRegistroC170): String;
    function WriteRegistroC176(RegC170: TRegistroC170): String;
    function WriteRegistroC177(RegC170: TRegistroC170): String;
    function WriteRegistroC178(RegC170: TRegistroC170): String;
    function WriteRegistroC179(RegC170: TRegistroC170): String;
    function WriteRegistroC190(RegC100: TRegistroC100): String;
    function WriteRegistroC195(RegC100: TRegistroC100): String;
    function WriteRegistroC197(RegC195: TRegistroC195): String;
    function WriteRegistroC300(RegC001: TRegistroC001): String;
    function WriteRegistroC310(RegC300: TRegistroC300): String;
    function WriteRegistroC320(RegC300: TRegistroC300): String;
    function WriteRegistroC321(RegC320: TRegistroC320): String;
    function WriteRegistroC350(RegC001: TRegistroC001): String;
    function WriteRegistroC370(RegC350: TRegistroC350): String;
    function WriteRegistroC390(RegC350: TRegistroC350): String;
    function WriteRegistroC400(RegC001: TRegistroC001): String;
    function WriteRegistroC405(RegC400: TRegistroC400): String;
    function WriteRegistroC410(RegC405: TRegistroC405): String;
    function WriteRegistroC420(RegC405: TRegistroC405): String;
    function WriteRegistroC460(RegC405: TRegistroC405): String;
    function WriteRegistroC490(RegC405: TRegistroC405): String;
    function WriteRegistroC495(RegC001: TRegistroC001): String;
    function WriteRegistroC425(RegC420: TRegistroC420): String;
    function WriteRegistroC470(RegC460: TRegistroC460): String;
    function WriteRegistroC500(RegC001: TRegistroC001): String;
    function WriteRegistroC510(RegC500: TRegistroC500): String;
    function WriteRegistroC590(RegC500: TRegistroC500): String;
    function WriteRegistroC600(RegC001: TRegistroC001): String;
    function WriteRegistroC601(RegC600: TRegistroC600): String;
    function WriteRegistroC610(RegC600: TRegistroC600): String;
    function WriteRegistroC690(RegC600: TRegistroC600): String;
    function WriteRegistroC700(RegC001: TRegistroC001): String;
    function WriteRegistroC790(RegC700: TRegistroC700): String;
    function WriteRegistroC791(RegC790: TRegistroC790): String;

    procedure CriaRegistros;
    procedure LiberaRegistros;
  public
    constructor Create;           /// Create
    destructor Destroy; override; /// Destroy
    procedure LimpaRegistros;

    function RegistroC001New: TRegistroC001;
    function RegistroC100New: TRegistroC100;
    function RegistroC110New: TRegistroC110;

    function RegistroC111New: TRegistroC111;
    function RegistroC112New: TRegistroC112;
    function RegistroC113New: TRegistroC113;
    function RegistroC114New: TRegistroC114;
    function RegistroC115New: TRegistroC115;
    function RegistroC120New: TRegistroC120;
    function RegistroC130New: TRegistroC130;
    function RegistroC140New: TRegistroC140;
    function RegistroC141New: TRegistroC141;
    function RegistroC160New: TRegistroC160;
    function RegistroC165New: TRegistroC165;
    function RegistroC170New: TRegistroC170;
    function RegistroC171New: TRegistroC171;
    function RegistroC172New: TRegistroC172;
    function RegistroC173New: TRegistroC173;
    function RegistroC174New: TRegistroC174;
    function RegistroC175New: TRegistroC175;
    function RegistroC176New: TRegistroC176;
    function RegistroC177New: TRegistroC177;
    function RegistroC178New: TRegistroC178;
    function RegistroC179New: TRegistroC179;
    function RegistroC190New: TRegistroC190;
    function RegistroC195New: TRegistroC195;
    function RegistroC197New: TRegistroC197;
    function RegistroC300New: TRegistroC300;
    function RegistroC310New: TRegistroC310;
    function RegistroC320New: TRegistroC320;
    function RegistroC321New: TRegistroC321;
    function RegistroC350New: TRegistroC350;
    function RegistroC370New: TRegistroC370;
    function RegistroC390New: TRegistroC390;
    function RegistroC400New: TRegistroC400;
    function RegistroC405New: TRegistroC405;
    function RgeistroC410New: TRegistroC410;
    function RegistroC420New: TRegistroC420;
    function RegistroC425New: TRegistroC425;
    function RegistroC460New: TRegistroC460;
    function registroC470New: TRegistroC470;
    function RegistroC490New: TRegistroC490;
    function RegistroC495New: TRegistroC495;
    function RegistroC500New: TRegistroC500;
    function RegistroC510New: TRegistroC510;
    function RegistroC590New: TRegistroC590;
    function RegistroC600New: TRegistroC600;
    function RegistroC601New: TRegistroC601;
    function RegistroC610New: TRegistroC610;
    function RegistroC690New: TRegistroC690;
    function RegistroC700New: TRegistroC700;
    function RegistroC790New: TRegistroC790;
    function registroC791New: TRegistroC791;

    function WriteRegistroC001: String;
    function WriteRegistroC990: String;

    property Bloco_0: TBloco_0 read FBloco_0 write FBloco_0;
    property RegistroC001: TRegistroC001 read FRegistroC001 write FRegistroC001;
    property RegistroC990: TRegistroC990 read FRegistroC990 write FRegistroC990;

    property RegistroC100Count: Integer read FRegistroC100Count write FRegistroC100Count;
    property RegistroC110Count: Integer read FRegistroC110Count write FRegistroC110Count;
    property RegistroC112Count: Integer read FRegistroC112Count write FRegistroC112Count;
    property RegistroC113Count: Integer read FRegistroC113Count write FRegistroC113Count;
    property RegistroC114Count: Integer read FRegistroC114Count write FRegistroC114Count;
    property RegistroC115Count: Integer read FRegistroC115Count write FRegistroC115Count;
    property RegistroC111Count: Integer read FRegistroC111Count write FRegistroC111Count;
    property RegistroC120Count: Integer read FRegistroC120Count write FRegistroC120Count;
    property RegistroC130Count: Integer read FRegistroC130Count write FRegistroC130Count;
    property RegistroC140Count: Integer read FRegistroC140Count write FRegistroC140Count;
    property RegistroC141Count: Integer read FRegistroC141Count write FRegistroC141Count;
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
    property RegistroC190Count: Integer read FRegistroC190Count write FRegistroC190Count;
    property RegistroC195Count: Integer read FRegistroC195Count write FRegistroC195Count;
    property RegistroC197Count: Integer read FRegistroC197Count write FRegistroC197Count;
    property RegistroC300Count: Integer read FRegistroC300Count write FRegistroC300Count;
    property RegistroC310Count: Integer read FRegistroC310Count write FRegistroC310Count;
    property RegistroC320Count: Integer read FRegistroC320Count write FRegistroC320Count;
    property RegistroC321Count: Integer read FRegistroC321Count write FRegistroC321Count;
    property RegistroC350Count: Integer read FRegistroC350Count write FRegistroC350Count;
    property RegistroC370Count: Integer read FRegistroC370Count write FRegistroC370Count;
    property RegistroC390Count: Integer read FRegistroC390Count write FRegistroC390Count;
    property RegistroC400Count: Integer read FRegistroC400Count write FRegistroC400Count;
    property RegistroC405Count: Integer read FRegistroC405Count write FRegistroC405Count;
    property RegistroC410Count: Integer read FRegistroC410Count write FRegistroC410Count;
    property RegistroC420Count: Integer read FRegistroC420Count write FRegistroC420Count;
    property RegistroC425Count: Integer read FRegistroC425Count write FRegistroC425Count;
    property RegistroC460Count: Integer read FRegistroC460Count write FRegistroC460Count;
    property RegistroC470Count: Integer read FRegistroC470Count write FRegistroC470Count;
    property RegistroC490Count: Integer read FRegistroC490Count write FRegistroC490Count;
    property RegistroC495Count: Integer read FRegistroC495Count write FRegistroC495Count;
    property RegistroC500Count: Integer read FRegistroC500Count write FRegistroC500Count;
    property RegistroC510Count: Integer read FRegistroC510Count write FRegistroC510Count;
    property RegistroC590Count: Integer read FRegistroC590Count write FRegistroC590Count;
    property RegistroC600Count: Integer read FRegistroC600Count write FRegistroC600Count;
    property RegistroC601Count: Integer read FRegistroC601Count write FRegistroC601Count;
    property RegistroC610Count: Integer read FRegistroC610Count write FRegistroC610Count;
    property RegistroC690Count: Integer read FRegistroC690Count write FRegistroC690Count;
    property RegistroC700Count: Integer read FRegistroC700Count write FRegistroC700Count;
    property RegistroC790Count: Integer read FRegistroC790Count write FRegistroC790Count;
    property RegistroC791Count: Integer read FRegistroC791Count write FRegistroC791Count;
  end;

implementation

uses ACBrSpedUtils;

{ TBloco_C }

constructor TBloco_C.Create;
begin
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
  FRegistroC990 := TRegistroC990.Create;

  FRegistroC100Count := 0;
  FRegistroC110Count := 0;
  FRegistroC112Count := 0;
  FRegistroC113Count := 0;
  FRegistroC114Count := 0;
  FRegistroC115Count := 0;
  FRegistroC111Count := 0;
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
  FRegistroC190Count := 0;
  FRegistroC195Count := 0;
  FRegistroC197Count := 0;
  FRegistroC300Count := 0;
  FRegistroC310Count := 0;
  FRegistroC320Count := 0;
  FRegistroC321Count := 0;
  FRegistroC350Count := 0;
  FRegistroC370Count := 0;
  FRegistroC390Count := 0;
  FRegistroC400Count := 0;
  FRegistroC405Count := 0;
  FRegistroC410Count := 0;
  FRegistroC420Count := 0;
  FRegistroC425Count := 0;
  FRegistroC460Count := 0;
  FRegistroC470Count := 0;
  FRegistroC490Count := 0;
  FRegistroC495Count := 0;
  FRegistroC500Count := 0;
  FRegistroC510Count := 0;
  FRegistroC590Count := 0;
  FRegistroC600Count := 0;
  FRegistroC601Count := 0;
  FRegistroC610Count := 0;
  FRegistroC690Count := 0;
  FRegistroC700Count := 0;
  FRegistroC790Count := 0;
  FRegistroC791Count := 0;

  FRegistroC990.QTD_LIN_C := 0;
end;

procedure TBloco_C.LiberaRegistros;
begin
  FRegistroC001.Free;
  FRegistroC990.Free;
end;

procedure TBloco_C.LimpaRegistros;
begin
  /// Limpa os Registros
  LiberaRegistros;
  /// Recriar os Registros Limpos
  CriaRegistros;
end;

function TBloco_C.RegistroC001New: TRegistroC001;
begin
   Result := FRegistroC001;
end;

function TBloco_C.RegistroC100New: TRegistroC100;
begin
   Result := FRegistroC001.RegistroC100.New;
end;

function TBloco_C.RegistroC110New: TRegistroC110;
begin
   Result := FRegistroC001.RegistroC100.Items[FRegistroC001.RegistroC100.Count -1].RegistroC110.New;
end;

function TBloco_C.RegistroC111New: TRegistroC111;
var
C100Count: integer;
C110Count: integer;
begin
   C100Count := FRegistroC001.RegistroC100.Count -1;
   C110Count := FRegistroC001.RegistroC100.Items[C100Count].RegistroC110.Count -1;
   //
   Result := FRegistroC001.RegistroC100.Items[C100Count].RegistroC110.Items[C110Count].RegistroC111.New;
end;

function TBloco_C.RegistroC112New: TRegistroC112;
var
C100Count: integer;
C110Count: integer;
begin
   C100Count := FRegistroC001.RegistroC100.Count -1;
   C110Count := FRegistroC001.RegistroC100.Items[C100Count].RegistroC110.Count -1;
   //
   Result := FRegistroC001.RegistroC100.Items[C100Count].RegistroC110.Items[C110Count].RegistroC112.New;
end;

function TBloco_C.RegistroC113New: TRegistroC113;
var
C100Count: integer;
C110Count: integer;
begin
   C100Count := FRegistroC001.RegistroC100.Count -1;
   C110Count := FRegistroC001.RegistroC100.Items[C100Count].RegistroC110.Count -1;
   //
   Result := FRegistroC001.RegistroC100.Items[C100Count].RegistroC110.Items[C110Count].RegistroC113.New;
end;

function TBloco_C.RegistroC114New: TRegistroC114;
var
C100Count: integer;
C110Count: integer;
begin
   C100Count := FRegistroC001.RegistroC100.Count -1;
   C110Count := FRegistroC001.RegistroC100.Items[C100Count].RegistroC110.Count -1;
   //
   Result := FRegistroC001.RegistroC100.Items[C100Count].RegistroC110.Items[C110Count].RegistroC114.New;
end;

function TBloco_C.RegistroC115New: TRegistroC115;
var
C100Count: integer;
C110Count: integer;
begin
   C100Count := FRegistroC001.RegistroC100.Count -1;
   C110Count := FRegistroC001.RegistroC100.Items[C100Count].RegistroC110.Count -1;
   //
   Result := FRegistroC001.RegistroC100.Items[C100Count].RegistroC110.Items[C110Count].RegistroC115.New;
end;

function TBloco_C.RegistroC120New: TRegistroC120;
begin
   Result := FRegistroC001.RegistroC100.Items[FRegistroC001.RegistroC100.Count -1].RegistroC120.New;
end;

function TBloco_C.RegistroC130New: TRegistroC130;
begin
   Result := FRegistroC001.RegistroC100.Items[FRegistroC001.RegistroC100.Count -1].RegistroC130.New;
end;

function TBloco_C.RegistroC140New: TRegistroC140;
begin
   Result := FRegistroC001.RegistroC100.Items[FRegistroC001.RegistroC100.Count -1].RegistroC140.New;
end;

function TBloco_C.RegistroC141New: TRegistroC141;
var
C100Count: integer;
C140Count: integer;
begin
   C100Count := FRegistroC001.RegistroC100.Count -1;
   C140Count := FRegistroC001.RegistroC100.Items[C100Count].RegistroC140.Count -1;
   //
   Result := FRegistroC001.RegistroC100.Items[C100Count].RegistroC140.Items[C140Count].RegistroC141.New;
end;

function TBloco_C.RegistroC160New: TRegistroC160;
begin
   Result := FRegistroC001.RegistroC100.Items[FRegistroC001.RegistroC100.Count -1].RegistroC160.New;
end;

function TBloco_C.RegistroC165New: TRegistroC165;
begin
   Result := FRegistroC001.RegistroC100.Items[FRegistroC001.RegistroC100.Count -1].RegistroC165.New;
end;

function TBloco_C.RegistroC170New: TRegistroC170;
begin
   Result := FRegistroC001.RegistroC100.Items[FRegistroC001.RegistroC100.Count -1].RegistroC170.New;
end;

function TBloco_C.RegistroC171New: TRegistroC171;
var
C100Count: integer;
C170Count: integer;
begin
   C100Count := FRegistroC001.RegistroC100.Count -1;
   C170Count := FRegistroC001.RegistroC100.Items[C100Count].RegistroC170.Count -1;
   //
   Result := FRegistroC001.RegistroC100.Items[C100Count].RegistroC170.Items[C170Count].RegistroC171.New;
end;

function TBloco_C.RegistroC172New: TRegistroC172;
var
C100Count: integer;
C170Count: integer;
begin
   C100Count := FRegistroC001.RegistroC100.Count -1;
   C170Count := FRegistroC001.RegistroC100.Items[C100Count].RegistroC170.Count -1;
   //
   Result := FRegistroC001.RegistroC100.Items[C100Count].RegistroC170.Items[C170Count].RegistroC172.New;
end;

function TBloco_C.RegistroC173New: TRegistroC173;
var
C100Count: integer;
C170Count: integer;
begin
   C100Count := FRegistroC001.RegistroC100.Count -1;
   C170Count := FRegistroC001.RegistroC100.Items[C100Count].RegistroC170.Count -1;
   //
   Result := FRegistroC001.RegistroC100.Items[C100Count].RegistroC170.Items[C170Count].RegistroC173.New;
end;

function TBloco_C.RegistroC174New: TRegistroC174;
var
C100Count: integer;
C170Count: integer;
begin
   C100Count := FRegistroC001.RegistroC100.Count -1;
   C170Count := FRegistroC001.RegistroC100.Items[C100Count].RegistroC170.Count -1;
   //
   Result := FRegistroC001.RegistroC100.Items[C100Count].RegistroC170.Items[C170Count].RegistroC174.New;
end;

function TBloco_C.RegistroC175New: TRegistroC175;
var
C100Count: integer;
C170Count: integer;
begin
   C100Count := FRegistroC001.RegistroC100.Count -1;
   C170Count := FRegistroC001.RegistroC100.Items[C100Count].RegistroC170.Count -1;
   //
   Result := FRegistroC001.RegistroC100.Items[C100Count].RegistroC170.Items[C170Count].RegistroC175.New;
end;

function TBloco_C.RegistroC176New: TRegistroC176;
var
C100Count: integer;
C170Count: integer;
begin
   C100Count := FRegistroC001.RegistroC100.Count -1;
   C170Count := FRegistroC001.RegistroC100.Items[C100Count].RegistroC170.Count -1;
   //
   Result := FRegistroC001.RegistroC100.Items[C100Count].RegistroC170.Items[C170Count].RegistroC176.New;
end;

function TBloco_C.RegistroC177New: TRegistroC177;
var
C100Count: integer;
C170Count: integer;
begin
   C100Count := FRegistroC001.RegistroC100.Count -1;
   C170Count := FRegistroC001.RegistroC100.Items[C100Count].RegistroC170.Count -1;
   //
   Result := FRegistroC001.RegistroC100.Items[C100Count].RegistroC170.Items[C170Count].RegistroC177.New;
end;

function TBloco_C.RegistroC178New: TRegistroC178;
var
C100Count: integer;
C170Count: integer;
begin
   C100Count := FRegistroC001.RegistroC100.Count -1;
   C170Count := FRegistroC001.RegistroC100.Items[C100Count].RegistroC170.Count -1;
   //
   Result := FRegistroC001.RegistroC100.Items[C100Count].RegistroC170.Items[C170Count].RegistroC178.New;
end;

function TBloco_C.RegistroC179New: TRegistroC179;
var
C100Count: integer;
C170Count: integer;
begin
   C100Count := FRegistroC001.RegistroC100.Count -1;
   C170Count := FRegistroC001.RegistroC100.Items[C100Count].RegistroC170.Count -1;
   //
   Result := FRegistroC001.RegistroC100.Items[C100Count].RegistroC170.Items[C170Count].RegistroC179.New;
end;

function TBloco_C.RegistroC190New: TRegistroC190;
begin
   Result := FRegistroC001.RegistroC100.Items[FRegistroC001.RegistroC100.Count -1].RegistroC190.New;
end;

function TBloco_C.RegistroC195New: TRegistroC195;
begin
   Result := FRegistroC001.RegistroC100.Items[FRegistroC001.RegistroC100.Count -1].RegistroC195.New;
end;

function TBloco_C.RegistroC197New: TRegistroC197;
var
C100Count: integer;
C195Count: integer;
begin
   C100Count := FRegistroC001.RegistroC100.Count -1;
   C195Count := FRegistroC001.RegistroC100.Items[C100Count].RegistroC195.Count -1;
   //
   Result := FRegistroC001.RegistroC100.Items[C100Count].RegistroC195.Items[C195Count].RegistroC197.New;
end;

function TBloco_C.RegistroC300New: TRegistroC300;
begin
   Result := FRegistroC001.RegistroC300.New;
end;

function TBloco_C.RegistroC310New: TregistroC310;
begin
   Result := FRegistroC001.RegistroC300.Items[FRegistroC001.RegistroC300.Count -1].RegistroC310.New;
end;

function TBloco_C.RegistroC320New: TRegistroC320;
begin
   Result := FRegistroC001.RegistroC300.Items[FRegistroC001.RegistroC300.Count -1].RegistroC320.New;
end;

function TBloco_C.RegistroC321New: TRegistroC321;
var
C300Count: integer;
C320Count: integer;
begin
   C300Count := FRegistroC001.RegistroC300.Count -1;
   C320Count := FRegistroC001.RegistroC300.Items[C300Count].RegistroC320.Count -1;
   //
   Result := FRegistroC001.RegistroC300.Items[C300Count].RegistroC320.Items[C320Count].RegistroC321.New;
end;

function TBloco_C.RegistroC350New: TRegistroC350;
begin
   Result := FRegistroC001.RegistroC350.New;
end;

function TBloco_C.RegistroC370New: TRegistroC370;
begin
   Result := FRegistroC001.RegistroC350.Items[FRegistroC001.RegistroC350.Count -1].RegistroC370.New;
end;

function TBloco_C.RegistroC390New: TregistroC390;
begin
   Result := FRegistroC001.RegistroC350.Items[FRegistroC001.RegistroC350.Count -1].RegistroC390.New;
end;

function TBloco_C.RegistroC400New: TRegistroC400;
begin
   Result := FRegistroC001.RegistroC400.New;
end;

function TBloco_C.RegistroC405New: TregistroC405;
begin
   Result := FRegistroC001.RegistroC400.Items[FRegistroC001.RegistroC400.Count -1].RegistroC405.New;
end;

function TBloco_C.RegistroC420New: TRegistroC420;
var
C400Count: integer;
C405Count: integer;
begin
   C400Count := FRegistroC001.RegistroC400.Count -1;
   C405Count := FRegistroC001.RegistroC400.Items[C400Count].RegistroC405.Count -1;
   //
   Result := FRegistroC001.RegistroC400.Items[C400Count].RegistroC405.Items[C405Count].RegistroC420.New;
end;

function TBloco_C.RegistroC425New: TRegistroC425;
var
C400Count: integer;
C405Count: integer;
C420Count: integer;
begin
   C400Count := FRegistroC001.RegistroC400.Count -1;
   C405Count := FRegistroC001.RegistroC400.Items[C400Count].RegistroC405.Count -1;
   C420Count := FRegistroC001.RegistroC400.Items[C400Count].RegistroC405.Items[C405Count].RegistroC420.Count -1;
   //
   Result := FRegistroC001.RegistroC400.Items[C400Count].RegistroC405.Items[C405Count].RegistroC420.Items[C420Count].RegistroC425.New;
end;

function TBloco_C.RegistroC460New: TRegistroC460;
var
C400Count: integer;
C405Count: integer;
begin
   C400Count := FRegistroC001.RegistroC400.Count -1;
   C405Count := FRegistroC001.RegistroC400.Items[C400Count].RegistroC405.Count -1;
   //
   Result := FRegistroC001.RegistroC400.Items[C400Count].RegistroC405.Items[C405Count].RegistroC460.New;
end;

function TBloco_C.registroC470New: TRegistroC470;
var
C400Count: integer;
C405Count: integer;
C460Count: integer;
begin
   C400Count := FRegistroC001.RegistroC400.Count -1;
   C405Count := FRegistroC001.RegistroC400.Items[C400Count].RegistroC405.Count -1;
   C460Count := FRegistroC001.RegistroC400.Items[C400Count].RegistroC405.Items[C405Count].RegistroC460.Count -1;
   //
   Result := FRegistroC001.RegistroC400.Items[C400Count].RegistroC405.Items[C405Count].RegistroC460.Items[C460Count].RegistroC470.New;
end;

function TBloco_C.RegistroC490New: TRegistroC490;
var
C400Count: integer;
C405Count: integer;
begin
   C400Count := FRegistroC001.RegistroC400.Count -1;
   C405Count := FRegistroC001.RegistroC400.Items[C400Count].RegistroC405.Count -1;
   //
   Result := FRegistroC001.RegistroC400.Items[C400Count].RegistroC405.Items[C405Count].RegistroC490.New;
end;

function TBloco_C.RegistroC495New: TRegistroC495;
begin
   Result := FRegistroC001.RegistroC495.New;
end;

function TBloco_C.RegistroC500New: TRegistroC500;
begin
   Result := FRegistroC001.RegistroC500.New;
end;

function TBloco_C.RegistroC510New: TregistroC510;
begin
   Result := FRegistroC001.RegistroC500.Items[FRegistroC001.RegistroC500.Count -1].RegistroC510.New;
end;

function TBloco_C.RegistroC590New: TRegistroC590;
begin
   Result := FRegistroC001.RegistroC500.Items[FRegistroC001.RegistroC500.Count -1].RegistroC590.New;
end;

function TBloco_C.RegistroC600New: TRegistroC600;
begin
   Result := FRegistroC001.RegistroC600.New;
end;

function TBloco_C.RegistroC601New: TRegistroC601;
begin
   Result := FRegistroC001.RegistroC600.Items[FRegistroC001.RegistroC600.Count -1].RegistroC601.New;
end;

function TBloco_C.RegistroC610New: TRegistroC610;
begin
   Result := FRegistroC001.RegistroC600.Items[FRegistroC001.RegistroC600.Count -1].RegistroC610.New;
end;

function TBloco_C.RegistroC690New: TRegistroC690;
begin
   Result := FRegistroC001.RegistroC600.Items[FRegistroC001.RegistroC600.Count -1].RegistroC690.New;
end;

function TBloco_C.RegistroC700New: TRegistroC700;
begin
   Result := FRegistroC001.RegistroC700.New;
end;

function TBloco_C.RegistroC790New: TRegistroC790;
begin
   Result := FRegistroC001.RegistroC700.Items[FRegistroC001.RegistroC700.Count -1].RegistroC790.New;
end;

function TBloco_C.registroC791New: TRegistroC791;
var
C700Count: integer;
C790Count: integer;
begin
   C700Count := FRegistroC001.RegistroC700.Count -1;
   C790Count := FRegistroC001.RegistroC700.Items[C700Count].RegistroC790.Count -1;
   //
   Result := FRegistroC001.RegistroC700.Items[C700Count].RegistroC790.Items[C790Count].RegistroC791.New;
end;

function TBloco_C.RgeistroC410New: TRegistroC410;
var
C400Count: integer;
C405Count: integer;
begin
   C400Count := FRegistroC001.RegistroC400.Count -1;
   C405Count := FRegistroC001.RegistroC400.Items[C400Count].RegistroC405.Count -1;
   //
   Result := FRegistroC001.RegistroC400.Items[C400Count].RegistroC405.Items[C405Count].RegistroC410.New;
end;

function TBloco_C.WriteRegistroC001: String;
var
strRegistroC001: String;
begin
  Result := '';

  if Assigned(FRegistroC001) then
  begin
     with FRegistroC001 do
     begin
       strRegistroC001 := strRegistroC001 + LFill( 'C001' ) +
                                            LFill( Integer(IND_MOV), 0 ) +
                                            Delimitador +
                                            #13#10;
     end;
     strRegistroC001 := strRegistroC001 +
                        WriteRegistroC100( FRegistroC001 ) +
                        WriteRegistroC300( FRegistroC001 ) +
                        WriteRegistroC350( FRegistroC001 ) +
                        WriteRegistroC400( FRegistroC001 ) +
                        WriteRegistroC495( FRegistroC001 ) +
                        WriteRegistroC500( FRegistroC001 ) +
                        WriteRegistroC600( FRegistroC001 ) +
                        WriteRegistroC700( FRegistroC001 );

     RegistroC990.QTD_LIN_C := RegistroC990.QTD_LIN_C + 1;
  end;
  Result := strRegistroC001;
end;

function TBloco_C.WriteRegistroC100(RegC001: TRegistroC001): String;
var
intFor: integer;
strIND_FRT: string;
strIND_PGTO: string;
strCOD_SIT: String;
strRegistroC100: String;
booNFCancelada: Boolean; /// Variavél p/ tratamento de NFs canceladas, denegadas ou inutilizada - Jean Barreiros 25Nov2009
begin
  strRegistroC100 := '';

  if Assigned( RegC001.RegistroC100 ) then
  begin
     for intFor := 0 to RegC001.RegistroC100.Count - 1 do
     begin
        with RegC001.RegistroC100.Items[intFor] do
        begin
          case COD_SIT of
           sdRegular:               strCOD_SIT := '00';
           sdExtempRegular:         strCOD_SIT := '01';
           sdCancelado:             strCOD_SIT := '02';
           sdCanceladoExtemp:       strCOD_SIT := '03';
           sdDoctoDenegado:         strCOD_SIT := '04';
           sdDoctoNumInutilizada:   strCOD_SIT := '05';
           sdFiscalCompl:           strCOD_SIT := '06';
           sdExtempCompl:           strCOD_SIT := '07';
           sdRegimeEspecNEsp:       strCOD_SIT := '08';
          end;
          /// Tratamento NFs canceladas 02/03, denegada 04 ou inutilizada 05 - Jean Barreiros 25Nov2009
          if Pos(strCOD_SIT,'02, 03, 04, 05') > 0 then
          begin
            DT_DOC   := 0;
            DT_E_S   := 0;
            IND_FRT  := tfNenhum;
            IND_PGTO := tpNenhum;
            booNFCancelada := true
          end
          else
            booNFCancelada := false;
          //
          case IND_FRT of
           tfPorContaTerceiros:    strIND_FRT := '0';
           tfPorContaEmitente:     strIND_FRT := '1';
           tfPorContaDestinatario: strIND_FRT := '2';
           tfSemCobrancaFrete:     strIND_FRT := '9';
           tfNenhum:               strIND_FRT := '';
          end;
          case IND_PGTO of
           tpVista:        strIND_PGTO := '0';
           tpPrazo:        strIND_PGTO := '1';
           tpSemPagamento: strIND_PGTO := '9';
           tpNenhum:       strIND_PGTO := '';
          end;
          strRegistroC100 := strRegistroC100 + LFill('C100') +
                                               LFill( Integer(IND_OPER), 0 ) +
                                               LFill( Integer(IND_EMIT), 0 ) +
                                               LFill( COD_PART ) +
                                               LFill( COD_MOD  ) +
                                               LFill( strCOD_SIT  ) +
                                               LFill( SER  ) +
                                               LFill( NUM_DOC  ) +
                                               LFill( CHV_NFE  ) +
                                               LFill( DT_DOC, 'ddmmyyyy' ) +
                                               LFill( DT_E_S, 'ddmmyyyy' ) +
                                               LFill( VL_DOC , 0 , 2 , booNFCancelada ) +
                                               LFill( strIND_PGTO ) +
                                               LFill( VL_DESC,0,2, booNFCancelada ) +
                                               LFill( VL_ABAT_NT,0,2, booNFCancelada ) +
                                               LFill( VL_MERC,0,2, booNFCancelada ) +
                                               LFill( strIND_FRT ) +
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
                           WriteRegistroC110( RegC001.RegistroC100.Items[intFor] ) +
                           WriteRegistroC120( RegC001.RegistroC100.Items[intFor] ) +
                           WriteRegistroC130( RegC001.RegistroC100.Items[intFor] ) +
                           WriteRegistroC140( RegC001.RegistroC100.Items[intFor] ) +
                           WriteRegistroC160( RegC001.RegistroC100.Items[intFor] ) +
                           WriteRegistroC165( RegC001.RegistroC100.Items[intFor] ) +
                           WriteRegistroC170( RegC001.RegistroC100.Items[intFor] ) +
                           WriteRegistroC190( RegC001.RegistroC100.Items[intFor] ) +
                           WriteRegistroC195( RegC001.RegistroC100.Items[intFor] );

        RegistroC990.QTD_LIN_C := RegistroC990.QTD_LIN_C + 1;
     end;
     /// Variavél para armazenar a quantidade de registro do tipo.
     FRegistroC100Count := FRegistroC100Count + RegC001.RegistroC100.Count;
  end;
  Result := strRegistroC100;
end;

function TBloco_C.WriteRegistroC110(RegC100: TRegistroC100): String;
var
intFor: integer;
strRegistroC110: String;
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

function TBloco_C.WriteRegistroC111(RegC110: TRegistroC110): String;
var
intFor: integer;
intIND_PROC: integer;
strRegistroC111: String;
begin
  strRegistroC111 := '';

  if Assigned( RegC110.RegistroC111 ) then
  begin
     for intFor := 0 to RegC110.RegistroC111.Count - 1 do
     begin
        with RegC110.RegistroC111.Items[intFor] do
        begin
          case IND_PROC of
           opSefaz:           intIND_PROC := 0;
           opJusticaFederal:  intIND_PROC := 1;
           opJusticaEstadual: intIND_PROC := 2;
           opSecexRFB:        intIND_PROC := 9;
           opOutros:          intIND_PROC := 9;
          end;
          strRegistroC111 := strRegistroC111 + LFill('C111') +
                                               LFill( NUM_PROC ) +
                                               LFill( intIND_PROC, 0 ) +
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

function TBloco_C.WriteRegistroC112(RegC110: TRegistroC110): String;
var
intFor: integer;
strRegistroC112: String;
begin
  strRegistroC112 := '';

  if Assigned( RegC110.RegistroC112 ) then
  begin
     for intFor := 0 to RegC110.RegistroC112.Count - 1 do
     begin
        with RegC110.RegistroC112.Items[intFor] do
        begin
          strRegistroC112 := strRegistroC112 + LFill('C112') +
                                               LFill( Integer(COD_DA), 0 ) +
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

function TBloco_C.WriteRegistroC113(RegC110: TRegistroC110): String;
var
intFor: integer;
strRegistroC113: String;
begin
  strRegistroC113 := '';

  if Assigned( RegC110.RegistroC113 ) then
  begin
     for intFor := 0 to RegC110.RegistroC113.Count - 1 do
     begin
        with RegC110.RegistroC113.Items[intFor] do
        begin
          strRegistroC113 := strRegistroC113 + LFill('C113') +
                                               LFill( Integer(IND_OPER), 0 ) +
                                               LFill( Integer(IND_EMIT), 0 ) +
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

function TBloco_C.WriteRegistroC114(RegC110: TRegistroC110): String;
var
intFor: integer;
strRegistroC114: String;
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

function TBloco_C.WriteRegistroC115(RegC110: TRegistroC110): String;
var
intFor: integer;
intIND_CARGA: integer;
strRegistroC115: String;
begin
  strRegistroC115 := '';

  if Assigned( RegC110.RegistroC115 ) then
  begin
     for intFor := 0 to RegC110.RegistroC115.Count - 1 do
     begin
        with RegC110.RegistroC115.Items[intFor] do
        begin
          case IND_CARGA of
           ttRodoviario:      intIND_CARGA := 0;
           ttFerroviario:     intIND_CARGA := 1;
           ttRodoFerroviario: intIND_CARGA := 2;
           ttAquaviario:      intIND_CARGA := 3;
           ttDutoviario:      intIND_CARGA := 4;
           ttAereo:           intIND_CARGA := 5;
           ttOutros:          intIND_CARGA := 9;
          end;
          strRegistroC115 := strRegistroC115 + LFill('C115') +
                                               LFill( intIND_CARGA, 0 ) +
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

function TBloco_C.WriteRegistroC120(RegC100: TRegistroC100): String;
var
intFor: integer;
strRegistroC120: String;
begin
  strRegistroC120 := '';

  if Assigned( RegC100.RegistroC120 ) then
  begin
     if RegC100.RegistroC120.Count > 0 then
     begin
        if (RegC100.IND_OPER in [tpSaidaPrestacao]) then
           raise Exception.Create('O RegistroC120, não deve ser gerado em movimentações de saída, tanto para PerfilA quanto PerfilB');
     end;
     for intFor := 0 to RegC100.RegistroC120.Count - 1 do
     begin
        with RegC100.RegistroC120.Items[intFor] do
        begin
          strRegistroC120 := strRegistroC120 + LFill('C120') +
                                               LFill( Integer(COD_DOC_IMP), 0 ) +
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

function TBloco_C.WriteRegistroC130(RegC100: TRegistroC100): String;
var
intFor: integer;
strRegistroC130: String;
begin
  strRegistroC130 := '';

  if Assigned( RegC100.RegistroC130 ) then
  begin
     if RegC100.RegistroC130.Count > 0 then
     begin
        if (RegC100.IND_OPER in [tpEntradaAquisicao]) then
           raise Exception.Create('O RegistroC130, não deve ser gerado em movimentações de entrada, tanto para PerfilA quanto PerfilB');
     end;
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

function TBloco_C.WriteRegistroC140(RegC100: TRegistroC100): String;
var
intFor: integer;
strIND_TIT: String;
strRegistroC140: String;
begin
  strRegistroC140 := '';

  if Assigned( RegC100.RegistroC140 ) then
  begin
     for intFor := 0 to RegC100.RegistroC140.Count - 1 do
     begin
        with RegC100.RegistroC140.Items[intFor] do
        begin
          case IND_TIT of
           tcDuplicata:   strIND_TIT := '00';
           tcCheque:      strIND_TIT := '01';
           tcPromissoria: strIND_TIT := '02';
           tcRecibo:      strIND_TIT := '03';
           tcOutros:      strIND_TIT := '99';
          end;
          strRegistroC140 := strRegistroC140 + LFill('C140') +
                                               LFill( Integer(IND_EMIT), 0 ) +
                                               LFill( strIND_TIT  ) +
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

function TBloco_C.WriteRegistroC141(RegC140:TRegistroC140): String;
var
intFor: integer;
strRegistroC141: String;
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

function TBloco_C.WriteRegistroC160(RegC100: TRegistroC100): String;
var
intFor: integer;
strRegistroC160: String;
begin
  strRegistroC160 := '';

  if Assigned( RegC100.RegistroC160 ) then
  begin
     if RegC100.RegistroC160.Count > 0 then
     begin
        if (RegC100.IND_OPER in [tpEntradaAquisicao]) then
           raise Exception.Create('O RegistroC160, não deve ser gerado em movimentações de entrada, tanto para PerfilA quanto PerfilB');
     end;
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

function TBloco_C.WriteRegistroC165(RegC100: TRegistroC100): String;
var
intFor: integer;
strRegistroC165: String;
begin
  strRegistroC165 := '';

  if Assigned( RegC100.RegistroC165 ) then
  begin
     if RegC100.RegistroC165.Count > 0 then
     begin
        if (RegC100.IND_OPER in [tpEntradaAquisicao]) then
           raise Exception.Create('O RegistroC165, não deve ser gerado em movimentações de entrada, tanto para PerfilA quanto PerfilB');
     end;
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

function TBloco_C.WriteRegistroC170(RegC100: TRegistroC100): String;
var
intFor: integer;
strCST_IPI: String;
strCST_PIS: String;
strCST_COFINS: String;
strRegistroC170: String;
begin
  strRegistroC170 := '';

  if Assigned( RegC100.RegistroC170 ) then
  begin
     for intFor := 0 to RegC100.RegistroC170.Count - 1 do
     begin
        with RegC100.RegistroC170.Items[intFor] do
        begin
          case CST_IPI of
           ipiEntradaRecuperacaoCredito: strCST_IPI := '00';
           ipiEntradaTributradaZero:     strCST_IPI := '01';
           ipiEntradaIsenta:             strCST_IPI := '02';
           ipiEntradaNaoTributada:       strCST_IPI := '03';
           ipiEntradaImune:              strCST_IPI := '04';
           ipiEntradaComSuspensao:       strCST_IPI := '05';
           ipiOutrasEntradas:            strCST_IPI := '49';
           ipiSaidaTributada:            strCST_IPI := '50';
           ipiSaidaTributadaZero:        strCST_IPI := '51';
           ipiSaidaIsenta:               strCST_IPI := '52';
           ipiSaidaNaoTributada:         strCST_IPI := '53';
           ipiSaidaImune:                strCST_IPI := '54';
           ipiSaidaComSuspensao:         strCST_IPI := '55';
           ipiOutrasSaidas:              strCST_IPI := '99';
          end;
          case CST_PIS of
           pisValorAliquotaNormal:       strCST_PIS := '01';
           pisValorAliquotaDiferenciada: strCST_PIS := '02';
           pisQtdeAliquotaUnidade:       strCST_PIS := '03';
           pisMonofaticaAliquotaZero:    strCST_PIS := '04';
           pisAliquotaZero:              strCST_PIS := '06';
           pisIsentaContribuicao:        strCST_PIS := '07';
           pisSemIncidenciaContribuicao: strCST_PIS := '08';
           pisSuspensaoContribuicao:     strCST_PIS := '09';
           pisOutrasOperacoes:           strCST_PIS := '99';
          end;
          case CST_COFINS of
           cofinsValorAliquotaNormal:       strCST_COFINS := '01';
           cofinsValorAliquotaDiferenciada: strCST_COFINS := '02';
           cofinsQtdeAliquotaUnidade:       strCST_COFINS := '03';
           cofinsMonofaticaAliquotaZero:    strCST_COFINS := '04';
           cofinsAliquotaZero:              strCST_COFINS := '06';
           cofinsIsentaContribuicao:        strCST_COFINS := '07';
           cofinsSemIncidenciaContribuicao: strCST_COFINS := '08';
           cofinsSuspensaoContribuicao:     strCST_COFINS := '09';
           cofinsOutrasOperacoes:           strCST_COFINS := '99';
          end;
          strRegistroC170 := strRegistroC170 + LFill('C170') +
                                               LFill( NUM_ITEM ) +
                                               LFill( COD_ITEM ) +
                                               LFill( DESCR_COMPL ) +
                                               DFill( QTD, 5 ) +
                                               LFill( UNID ) +
                                               LFill( VL_ITEM,0,2 ) +
                                               LFill( VL_DESC,0,2 ) +
                                               LFill( Integer(IND_MOV), 0 ) +
                                               LFill( CST_ICMS,3 ) +
                                               LFill( CFOP,4 ) +
                                               LFill( COD_NAT ) +
                                               LFill( VL_BC_ICMS,0,2 ) +
                                               LFill( ALIQ_ICMS,0,2 ) +
                                               LFill( VL_ICMS,0,2 ) +
                                               LFill( VL_BC_ICMS_ST,0,2 ) +
                                               LFill( ALIQ_ST,0,2 ) +
                                               LFill( VL_ICMS_ST,0,2 ) +
                                               LFill( Integer(IND_APUR), 0 ) +
                                               LFill( strCST_IPI ) +
                                               LFill( COD_ENQ ) +
                                               LFill( VL_BC_IPI,0,2 ) +
                                               LFill( ALIQ_IPI,0,2 ) +
                                               LFill( VL_IPI,0,2 ) +
                                               LFill( strCST_PIS ) +
                                               LFill( VL_BC_PIS,0,2 ) +
                                               LFill( ALIQ_PIS_PERC,0,2 ) +
                                               DFill( QUANT_BC_PIS,3 ) +
                                               DFill( ALIQ_PIS_R,4 ) +
                                               LFill( VL_PIS,0,2 ) +
                                               LFill( strCST_COFINS ) +
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

function TBloco_C.WriteRegistroC171(RegC170: TRegistroC170): String;
var
intFor: integer;
strRegistroC171: String;
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

function TBloco_C.WriteRegistroC172(RegC170: TRegistroC170): String;
var
intFor: integer;
strRegistroC172: String;
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

function TBloco_C.WriteRegistroC173(RegC170: TRegistroC170): String;
var
intFor: integer;
strRegistroC173: String;
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
                                               LFill( Integer(IND_MED), 0 ) +
                                               LFill( Integer(TP_PROD), 0 ) +
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

function TBloco_C.WriteRegistroC174(RegC170: TRegistroC170): String;
var
intFor: integer;
strRegistroC174: String;
begin
  strRegistroC174 := '';

  if Assigned( RegC170.RegistroC174 ) then
  begin
     for intFor := 0 to RegC170.RegistroC174.Count - 1 do
     begin
        with RegC170.RegistroC174.Items[intFor] do
        begin
          strRegistroC174 := strRegistroC174 + LFill('C174') +
                                               LFill( Integer(IND_ARM), 0 ) +
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

function TBloco_C.WriteRegistroC175(RegC170: TRegistroC170): String;
var
intFor: integer;
intIND_VEIC_OPER: integer;
strRegistroC175: String;
begin
  strRegistroC175 := '';

  if Assigned( RegC170.RegistroC175 ) then
  begin
     for intFor := 0 to RegC170.RegistroC175.Count - 1 do
     begin
        with RegC170.RegistroC175.Items[intFor] do
        begin
          case IND_VEIC_OPER of
           tovVendaPConcess:  intIND_VEIC_OPER := 0;
           tovFaturaDireta:   intIND_VEIC_OPER := 1;
           tovVendaDireta:    intIND_VEIC_OPER := 2;
           tovVendaDConcess:  intIND_VEIC_OPER := 3;
           tovVendaOutros:    intIND_VEIC_OPER := 9;
          end;
          strRegistroC175 := strRegistroC175 + LFill('C175') +
                                               LFill( intIND_VEIC_OPER, 0 ) +
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

function TBloco_C.WriteRegistroC176(RegC170: TRegistroC170): String;
var
intFor: integer;
strRegistroC176: String;
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

function TBloco_C.WriteRegistroC177(RegC170: TRegistroC170): String;
var
intFor: integer;
strRegistroC177: String;
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

function TBloco_C.WriteRegistroC178(RegC170: TRegistroC170): String;
var
intFor: integer;
strRegistroC178: String;
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

function TBloco_C.WriteRegistroC179(RegC170: TRegistroC170): String;
var
intFor: integer;
strRegistroC179: String;
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

function TBloco_C.WriteRegistroC190(RegC100: TRegistroC100): String;
var
intFor: integer;
strRegistroC190: String;
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

function TBloco_C.WriteRegistroC195(RegC100: TRegistroC100): String;
var
intFor: integer;
strRegistroC195: String;
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
        /// Registro FILHOS do FILHO
        strRegistroC195 := strRegistroC195 +
                           WriteRegistroC197( RegC100.RegistroC195.Items[intFor] );

        RegistroC990.QTD_LIN_C := RegistroC990.QTD_LIN_C + 1;
     end;
     /// Variavél para armazenar a quantidade de registro do tipo.
     FRegistroC195Count := FRegistroC195Count + RegC100.RegistroC195.Count;
  end;
  Result := strRegistroC195;
end;

function TBloco_C.WriteRegistroC197(RegC195: TRegistroC195): String;
var
intFor: integer;
strRegistroC197: String;
begin
  strRegistroC197 := '';

  if Assigned(RegC195.RegistroC197 ) then
  begin
     for intFor := 0 to RegC195.RegistroC197.Count - 1 do
     begin
        with RegC195.RegistroC197.Items[intFor] do
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
     /// Variavél para armazenar a quantidade de registro do tipo.
     FRegistroC197Count := FRegistroC197Count + RegC195.RegistroC197.Count;
  end;
  Result := strRegistroC197;
end;

function TBloco_C.WriteRegistroC300(RegC001: TRegistroC001): String;
var
intFor: integer;
strRegistroC300: String;
begin
  strRegistroC300 := '';

  if Assigned( RegC001.RegistroC300 ) then
  begin
     if RegC001.RegistroC300.Count > 0 then
     begin
        if FBloco_0.Registro0000.IND_PERFIL in [pfPerfilA] then
           raise Exception.Create('O RegistroC300, não deve ser gerado em movimentações de saída, no PerfilA');
     end;
     for intFor := 0 to RegC001.RegistroC300.Count - 1 do
     begin
        with RegC001.RegistroC300.Items[intFor] do
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
        /// Registro FILHOS do FILHO
        strRegistroC300 := strRegistroC300 +
                           WriteRegistroC310( RegC001.RegistroC300.Items[intFor] ) +
                           WriteRegistroC320( RegC001.RegistroC300.Items[intFor] );

        RegistroC990.QTD_LIN_C := RegistroC990.QTD_LIN_C + 1;
     end;
     /// Variavél para armazenar a quantidade de registro do tipo.
     FRegistroC300Count := FRegistroC300Count + RegC001.RegistroC300.Count;
  end;
  Result := strRegistroC300;
end;

function TBloco_C.WriteRegistroC310(RegC300: TRegistroC300): String;
var
intFor: integer;
strRegistroC310: String;
begin
  strRegistroC310 := '';

  if Assigned( RegC300.RegistroC310 ) then
  begin
     if RegC300.RegistroC310.Count > 0 then
     begin
        if FBloco_0.Registro0000.IND_PERFIL in [pfPerfilA] then
           raise Exception.Create('O RegistroC310, não deve ser gerado em movimentações de saída, no PerfilA');
     end;
     for intFor := 0 to RegC300.RegistroC310.Count - 1 do
     begin
        with RegC300.RegistroC310.Items[intFor] do
        begin
          strRegistroC310 := strRegistroC310 + LFill('C310') +
                                               LFill( NUM_DOC_CANC ) +
                                               Delimitador +
                                               #13#10;
        end;
        RegistroC990.QTD_LIN_C := RegistroC990.QTD_LIN_C + 1;
     end;
     /// Variavél para armazenar a quantidade de registro do tipo.
     FRegistroC310Count := FRegistroC310Count + RegC300.RegistroC310.Count;
  end;
  Result := strRegistroC310;
end;

function TBloco_C.WriteRegistroC320(RegC300: TRegistroC300): String;
var
intFor: integer;
strRegistroC320: String;
begin
  strRegistroC320 := '';

  if Assigned( RegC300.RegistroC320 ) then
  begin
     if RegC300.RegistroC320.Count > 0 then
     begin
        if FBloco_0.Registro0000.IND_PERFIL in [pfPerfilA] then
           raise Exception.Create('O RegistroC320, não deve ser gerado em movimentações de saída, no PerfilA');
     end;
     for intFor := 0 to RegC300.RegistroC320.Count - 1 do
     begin
        with RegC300.RegistroC320.Items[intFor] do
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
        /// Registro FILHOS do FILHO
        strRegistroC320 := strRegistroC320 +
                           WriteRegistroC321( RegC300.RegistroC320.Items[intFor] );

        RegistroC990.QTD_LIN_C := RegistroC990.QTD_LIN_C + 1;
     end;
     /// Variavél para armazenar a quantidade de registro do tipo.
     FRegistroC320Count := FRegistroC320Count + RegC300.RegistroC320.Count;
  end;
  Result := strRegistroC320;
end;

function TBloco_C.WriteRegistroC321(RegC320: TRegistroC320): String;
var
intFor: integer;
strRegistroC321: String;
begin
  strRegistroC321 := '';

  if Assigned( RegC320.RegistroC321 ) then
  begin
     if RegC320.RegistroC321.Count > 0 then
     begin
        if FBloco_0.Registro0000.IND_PERFIL in [pfPerfilA] then
           raise Exception.Create('O RegistroC321, não deve ser gerado em movimentações de saída, no PerfilA');
     end;
     for intFor := 0 to RegC320.RegistroC321.Count - 1 do
     begin
        with RegC320.RegistroC321.Items[intFor] do
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
     /// Variavél para armazenar a quantidade de registro do tipo.
     FRegistroC321Count := FRegistroC321Count + RegC320.RegistroC321.Count;
  end;
  Result := strRegistroC321;
end;

function TBloco_C.WriteRegistroC350(RegC001: TRegistroC001): String;
var
intFor: integer;
strRegistroC350: String;
begin
  strRegistroC350 := '';

  if Assigned( RegC001.RegistroC350 ) then
  begin
     if RegC001.RegistroC350.Count > 0 then
     begin
        if FBloco_0.Registro0000.IND_PERFIL in [pfPerfilB] then
           raise Exception.Create('O RegistroC350, não deve ser gerado em movimentações de saída, no PerfilB');
     end;
     for intFor := 0 to RegC001.RegistroC350.Count - 1 do
     begin
        with RegC001.RegistroC350.Items[intFor] do
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
                           WriteRegistroC370( RegC001.RegistroC350.Items[intFor] ) +
                           WriteRegistroC390( RegC001.RegistroC350.Items[intFor] );

        RegistroC990.QTD_LIN_C := RegistroC990.QTD_LIN_C + 1;
     end;
     /// Variavél para armazenar a quantidade de registro do tipo.
     FRegistroC350Count := FRegistroC350Count + RegC001.RegistroC350.Count;
  end;
  Result := strRegistroC350;
end;

function TBloco_C.WriteRegistroC370(RegC350: TRegistroC350): String;
var
intFor: integer;
strRegistroC370: String;
begin
  strRegistroC370 := '';

  if Assigned( RegC350.RegistroC370 ) then
  begin
     if RegC350.RegistroC370.Count> 0 then
     begin
        if FBloco_0.Registro0000.IND_PERFIL in [pfPerfilB] then
           raise Exception.Create('O RegistroC370, não deve ser gerado em movimentações de saída, no PerfilB');
     end;
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

function TBloco_C.WriteRegistroC390(RegC350: TRegistroC350): String;
var
  intFor: integer;
  strRegistroC390: String;
begin
  strRegistroC390 := '';

  if Assigned( RegC350.RegistroC390 ) then
  begin
     if RegC350.RegistroC390.Count > 0 then
     begin
        if FBloco_0.Registro0000.IND_PERFIL in [pfPerfilB] then
           raise Exception.Create('O RegistroC390, não deve ser gerado em movimentações de saída, no PerfilB');
     end;
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

function TBloco_C.WriteRegistroC400(RegC001: TRegistroC001): String;
var
intFor: integer;
strRegistroC400: String;
begin
  strRegistroC400 := '';

  if Assigned( RegC001.RegistroC400 ) then
  begin
     for intFor := 0 to RegC001.RegistroC400.Count - 1 do
     begin
        with RegC001.RegistroC400.Items[intFor] do
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
                           WriteRegistroC405( RegC001.RegistroC400.Items[intFor] );

        RegistroC990.QTD_LIN_C := RegistroC990.QTD_LIN_C + 1;
     end;
     /// Variavél para armazenar a quantidade de registro do tipo.
     FRegistroC400Count := FRegistroC400Count + RegC001.RegistroC400.Count;
  end;
  Result := strRegistroC400;
end;

function TBloco_C.WriteRegistroC405(RegC400: TRegistroC400): String;
var
intFor: integer;
strRegistroC405: String;
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

function TBloco_C.WriteRegistroC410(RegC405: TRegistroC405): String;
var
intFor: integer;
strRegistroC410: String;
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

function TBloco_C.WriteRegistroC420(RegC405: TRegistroC405): String;
var
intFor: integer;
strRegistroC420: String;
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

function TBloco_C.WriteRegistroC425(RegC420: TRegistroC420): String;
var
intFor: integer;
strRegistroC425: String;
begin
  strRegistroC425 := '';

  if Assigned( RegC420.RegistroC425 ) then
  begin
     if RegC420.RegistroC425.Count > 0 then
     begin
        if FBloco_0.Registro0000.IND_PERFIL in [pfPerfilA] then
           raise Exception.Create('O RegistroC425, não deve ser gerado em movimentações de saída, no PerfilA');
     end;
     for intFor := 0 to RegC420.RegistroC425.Count - 1 do
     begin
        with RegC420.RegistroC425.Items[intFor] do
        begin
          Check(FBloco_0.Registro0001.Registro0200.LocalizaRegistro(COD_ITEM), '(C-C425) ITENS: O código do item "%s" não existe no registro 0200!', [COD_ITEM]);

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

function TBloco_C.WriteRegistroC460(RegC405: TRegistroC405): String;
var
intFor: integer;
strCOD_SIT: String;
strRegistroC460: String;
begin
  strRegistroC460 := '';

  if Assigned( RegC405.RegistroC460 ) then
  begin
     if RegC405.RegistroC460.Count > 0 then
     begin
        if FBloco_0.Registro0000.IND_PERFIL in [pfPerfilB] then
           raise Exception.Create('O RegistroC60, não deve ser gerado em movimentações de saída, no PerfilB');
     end;
     for intFor := 0 to RegC405.RegistroC460.Count - 1 do
     begin
        with RegC405.RegistroC460.Items[intFor] do
        begin
          case COD_SIT of
           sdRegular:               strCOD_SIT := '00';
           sdExtempRegular:         strCOD_SIT := '01';
           sdCancelado:             strCOD_SIT := '02';
           sdCanceladoExtemp:       strCOD_SIT := '03';
           sdDoctoDenegado:         strCOD_SIT := '04';
           sdDoctoNumInutilizada:   strCOD_SIT := '05';
           sdFiscalCompl:           strCOD_SIT := '06';
           sdExtempCompl:           strCOD_SIT := '07';
           sdRegimeEspecNEsp:       strCOD_SIT := '08';
          end;
          strRegistroC460 := strRegistroC460 + LFill('C460') +
                                               LFill( COD_MOD ) +
                                               LFill( strCOD_SIT ) +
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

function TBloco_C.WriteRegistroC470(RegC460: TRegistroC460): String;
var
intFor: integer;
strRegistroC470: String;
begin
  strRegistroC470 := '';

  if Assigned( RegC460.RegistroC470 ) then
  begin
     if RegC460.RegistroC470.Count > 0 then
     begin
        if FBloco_0.Registro0000.IND_PERFIL in [pfPerfilB] then
           raise Exception.Create('O RegistroC470, não deve ser gerado em movimentações de saída, no PerfilB');
     end;
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

function TBloco_C.WriteRegistroC490(RegC405: TRegistroC405): String;
var
intFor: integer;
strRegistroC490: String;
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

function TBloco_C.WriteRegistroC495(RegC001: TRegistroC001): String;
var
intFor: integer;
strRegistroC495: String;
begin
  strRegistroC495 := '';

  if Assigned( RegC001.RegistroC495 ) then
  begin
     for intFor := 0 to RegC001.RegistroC495.Count - 1 do
     begin
        with RegC001.RegistroC495.Items[intFor] do
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
     /// Variavél para armazenar a quantidade de registro do tipo.
     FRegistroC495Count := FRegistroC495Count + RegC001.RegistroC495.Count;
  end;
  Result := strRegistroC495;
end;

function TBloco_C.WriteRegistroC500(RegC001: TRegistroC001): String;
var
intFor: integer;
intTP_LIGACAO: integer;
strCOD_SIT: String;
strCOD_GRUPO_TENSAO: String;
strCOD_CONS: String;
strRegistroC500: String;
begin
  strRegistroC500 := '';

  if Assigned( RegC001.RegistroC500 ) then
  begin
     for intFor := 0 to RegC001.RegistroC500.Count - 1 do
     begin
        with RegC001.RegistroC500.Items[intFor] do
        begin
           case COD_SIT of
            sdRegular:               strCOD_SIT := '00';
            sdExtempRegular:         strCOD_SIT := '01';
            sdCancelado:             strCOD_SIT := '02';
            sdCanceladoExtemp:       strCOD_SIT := '03';
            sdDoctoDenegado:         strCOD_SIT := '04';
            sdDoctoNumInutilizada:   strCOD_SIT := '05';
            sdFiscalCompl:           strCOD_SIT := '06';
            sdExtempCompl:           strCOD_SIT := '07';
            sdRegimeEspecNEsp:       strCOD_SIT := '08';
           end;
           case COD_GRUPO_TENSAO of
            gtA1:           strCOD_GRUPO_TENSAO := '01';
            gtA2:           strCOD_GRUPO_TENSAO := '02';
            gtA3:           strCOD_GRUPO_TENSAO := '03';
            gtA3a:          strCOD_GRUPO_TENSAO := '04';
            gtA4:           strCOD_GRUPO_TENSAO := '05';
            gtAS:           strCOD_GRUPO_TENSAO := '06';
            gtB107:         strCOD_GRUPO_TENSAO := '07';
            gtB108:         strCOD_GRUPO_TENSAO := '08';
            gtB209:         strCOD_GRUPO_TENSAO := '09';
            gtB2Rural:      strCOD_GRUPO_TENSAO := '10';
            gtB2Irrigacao:  strCOD_GRUPO_TENSAO := '11';
            gtB3:           strCOD_GRUPO_TENSAO := '12';
            gtB4a:          strCOD_GRUPO_TENSAO := '13';
            gtB4b:          strCOD_GRUPO_TENSAO := '14';
           end;
           case COD_CONS of
            ccComercial:         strCOD_CONS := '01';
            ccConsumoProprio:    strCOD_CONS := '02';
            ccIluminacaoPublica: strCOD_CONS := '03';
            ccIndustrial:        strCOD_CONS := '04';
            ccPoderPublico:      strCOD_CONS := '05';
            ccResidencial:       strCOD_CONS := '06';
            ccRural:             strCOD_CONS := '07';
            ccServicoPublico:    strCOD_CONS := '08';
           end;
           case TP_LIGACAO of
            tlMonofasico: intTP_LIGACAO := 1;
            tlBifasico:   intTP_LIGACAO := 2;
            tlTrifasico:  intTP_LIGACAO := 3;
           end;
           strRegistroC500 := strRegistroC500 + LFill('C500') +
                                                LFill( Integer(IND_OPER), 0 ) +
                                                LFill( Integer(IND_EMIT), 0 ) +
                                                LFill( COD_PART ) +
                                                LFill( COD_MOD,2 ) +
                                                LFill( strCOD_SIT ) +
                                                LFill( SER ) +
                                                LFill( SUB ) +
                                                LFill( strCOD_CONS ) +
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
                                                LFill( intTP_LIGACAO, 0 ) +
                                                LFill( strCOD_GRUPO_TENSAO ) +
                                                Delimitador +
                                                #13#10;
        end;
        /// Registro FILHOS do FILHO
        strRegistroC500 := strRegistroC500 +
                           WriteRegistroC510( RegC001.RegistroC500.Items[intFor] ) +
                           WriteRegistroC590( RegC001.RegistroC500.Items[intFor] );

        RegistroC990.QTD_LIN_C := RegistroC990.QTD_LIN_C + 1;
     end;
     /// Variavél para armazenar a quantidade de registro do tipo.
     FRegistroC500Count := FRegistroC500Count + RegC001.RegistroC500.Count;
  end;
  Result := strRegistroC500;
end;

function TBloco_C.WriteRegistroC510(RegC500:TRegistroC500) : String;
var
intFor: integer;
strRegistroC510: String;
begin
  strRegistroC510 := '';

  if Assigned( RegC500.RegistroC510 ) then
  begin
     if RegC500.RegistroC510.Count > 0 then
     begin
        if FBloco_0.Registro0000.IND_PERFIL in [pfPerfilB] then
           raise Exception.Create('O RegistroC510, não deve ser gerado em movimentações de entrada nem saída, no PerfilB');
     end;
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
                                               LFill( Integer(IND_REC), 0 ) +
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

function TBloco_C.WriteRegistroC590(RegC500:TRegistroC500): String;
var
intFor: integer;
strRegistroC590: String;
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

function TBloco_C.WriteRegistroC600(RegC001: TRegistroC001): String;
var
intFor: integer;
strRegistroC600: String;
begin
  strRegistroC600 := '';

  if Assigned( RegC001.RegistroC600 ) then
  begin
     if RegC001.RegistroC600.Count > 0 then
     begin
        if FBloco_0.Registro0000.IND_PERFIL in [pfPerfilA] then
           raise Exception.Create('O RegistroC600, não deve ser gerado em movimentações de entrada nem saída, no PerfilA');
     end;
     for intFor := 0 to RegC001.RegistroC600.Count - 1 do
     begin
        with RegC001.RegistroC600.Items[intFor] do
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
        /// Registros FILHOS
        strRegistroC600 := strRegistroC600 +
                           WriteRegistroC601( RegC001.RegistroC600.Items[intFor] ) +
                           WriteRegistroC610( RegC001.RegistroC600.Items[intFor] ) +
                           WriteRegistroC690( RegC001.RegistroC600.Items[intFor] );

        RegistroC990.QTD_LIN_C := RegistroC990.QTD_LIN_C + 1;
     end;
     /// Variavél para armazenar a quantidade de registro do tipo.
     FRegistroC600Count := FRegistroC600Count + RegC001.RegistroC600.Count;
  end;
  Result := strRegistroC600;
end;

function TBloco_C.WriteRegistroC601(RegC600: TRegistroC600): String;
var
intFor: integer;
strRegistroC601: String;
begin
  strRegistroC601 := '';

  if Assigned( RegC600.RegistroC601 ) then
  begin
     if RegC600.RegistroC601.Count > 0 then
     begin
        if FBloco_0.Registro0000.IND_PERFIL in [pfPerfilA] then
           raise Exception.Create('O RegistroC601, não deve ser gerado em movimentações de entrada nem saída, no PerfilA');
     end;
     for intFor := 0 to RegC600.RegistroC601.Count - 1 do
     begin
        with RegC600.RegistroC601.Items[intFor] do
        begin
          strRegistroC601 := strRegistroC601 + LFill('C601') +
                                               LFill( NUM_DOC_CANC ) +
                                               Delimitador +
                                               #13#10;
        end;
        RegistroC990.QTD_LIN_C := RegistroC990.QTD_LIN_C + 1;
     end;
     /// Variavél para armazenar a quantidade de registro do tipo.
     FRegistroC601Count := FRegistroC601Count + RegC600.RegistroC601.Count;
  end;
  Result := strRegistroC601;
end;

function TBloco_C.WriteRegistroC610(RegC600: TRegistroC600): String;
var
intFor: integer;
strRegistroC610: String;
begin
  strRegistroC610 := '';

  if Assigned( RegC600.RegistroC610 ) then
  begin
     if RegC600.RegistroC610.Count > 0 then
     begin
        if FBloco_0.Registro0000.IND_PERFIL in [pfPerfilA] then
           raise Exception.Create('O RegistroC610, não deve ser gerado em movimentações de entrada nem saída, no PerfilA');
     end;
     for intFor := 0 to RegC600.RegistroC610.Count - 1 do
     begin
        with RegC600.RegistroC610.Items[intFor] do
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
     /// Variavél para armazenar a quantidade de registro do tipo.
     FRegistroC610Count := FRegistroC610Count + RegC600.RegistroC610.Count;
  end;
  Result := strRegistroC610;
end;

function TBloco_C.WriteRegistroC690(RegC600: TRegistroC600): String;
var
intFor: integer;
strRegistroC690: String;
begin
  strRegistroC690 := '';

  if Assigned( RegC600.RegistroC690 ) then
  begin
     if RegC600.RegistroC690.Count > 0 then
     begin
        if FBloco_0.Registro0000.IND_PERFIL in [pfPerfilA] then
           raise Exception.Create('O RegistroC690, não deve ser gerado em movimentações de entrada nem saída, no PerfilA');
     end;
     for intFor := 0 to RegC600.RegistroC690.Count - 1 do
     begin
        with RegC600.RegistroC690.Items[intFor] do
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
     /// Variavél para armazenar a quantidade de registro do tipo.
     FRegistroC690Count := FRegistroC690Count + RegC600.RegistroC690.Count;
  end;
  Result := strRegistroC690;
end;

function TBloco_C.WriteRegistroC700(RegC001: TRegistroC001): String;
var
intFor: integer;
strRegistroC700: String;
begin
  strRegistroC700 := '';

  if Assigned( RegC001.RegistroC700 ) then
  begin
     for intFor := 0 to RegC001.RegistroC700.Count - 1 do
     begin
        with RegC001.RegistroC700.Items[intFor] do
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
        /// Registros FILHOS
        strRegistroC700 := strRegistroC700 +
                           WriteRegistroC790( RegC001.RegistroC700.Items[intFor] );

        RegistroC990.QTD_LIN_C := RegistroC990.QTD_LIN_C + 1;
     end;
     /// Variavél para armazenar a quantidade de registro do tipo.
     FRegistroC700Count := FRegistroC700Count + RegC001.RegistroC700.Count;
  end;
  Result := strRegistroC700;
end;

function TBloco_C.WriteRegistroC790(RegC700: TRegistroC700): String;
var
intFor: integer;
strRegistroC790: String;
begin
  strRegistroC790 := '';

  if Assigned( RegC700.RegistroC790 ) then
  begin
     for intFor := 0 to RegC700.RegistroC790.Count - 1 do
     begin
        with RegC700.RegistroC790.Items[intFor] do
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
        /// Registros FILHOS
        strRegistroC790 := strRegistroC790 +
                           WriteRegistroC791( RegC700.RegistroC790.Items[intFor] );

        RegistroC990.QTD_LIN_C := RegistroC990.QTD_LIN_C + 1;
     end;
     /// Variavél para armazenar a quantidade de registro do tipo.
     FRegistroC790Count := FRegistroC790Count + RegC700.RegistroC790.Count;
  end;
  Result := strRegistroC790;
end;

function TBloco_C.WriteRegistroC791(RegC790: TRegistroC790): String;
var
intFor: integer;
strRegistroC791: String;
begin
  strRegistroC791 := '';

  if Assigned( RegC790.RegistroC791 ) then
  begin
     for intFor := 0 to RegC790.RegistroC791.Count - 1 do
     begin
        with RegC790.RegistroC791.Items[intFor] do
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
     /// Variavél para armazenar a quantidade de registro do tipo.
     FRegistroC791Count := FRegistroC791Count + RegC790.RegistroC791.Count;
  end;
  Result := strRegistroC791;
end;

function TBloco_C.WriteRegistroC990: String;
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
