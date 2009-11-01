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

unit ACBrBloco_C_Class;

interface

uses SysUtils, Classes, DateUtils, ACBrSped, ACBrBloco_C;

type
  /// TBLOCO_C -
  TBloco_C = class(TACBrSPED)
  private
    FRegistroC001: TRegistroC001;      /// BLOCO C - RegistroC001
    FRegistroC100: TRegistroC100List;  /// BLOCO C - Lista de RegistroC100
    FRegistroC110: TRegistroC110List;  /// BLOCO C - Lista de RegistroC110
    FRegistroC111: TRegistroC111List;  /// BLOCO C - Lista de RegistroC111
    FRegistroC112: TRegistroC112List;  /// BLOCO C - Lista de RegistroC112
    FRegistroC113: TRegistroC113List;  /// BLOCO C - Lista de RegistroC113
    FRegistroC114: TRegistroC114List;  /// BLOCO C - Lista de RegistroC114
    FRegistroC115: TRegistroC115List;  /// BLOCO C - Lista de RegistroC115
    FRegistroC120: TRegistroC120List;  /// BLOCO C - Lista de RegistroC120
    FRegistroC130: TRegistroC130List;  /// BLOCO C - Lista de RegistroC130
    FRegistroC140: TRegistroC140List;  /// BLOCO C - Lista de RegistroC140
    FRegistroC141: TRegistroC141List;  /// BLOCO C - Lista de RegistroC141
    FRegistroC160: TRegistroC160List;  /// BLOCO C - Lista de RegistroC160
    FRegistroC165: TRegistroC165List;  /// BLOCO C - Lista de RegistroC165
    FRegistroC170: TRegistroC170List;  /// BLOCO C - Lista de RegistroC170
    FRegistroC171: TRegistroC171List;  /// BLOCO C - Lista de RegistroC171
    FRegistroC172: TRegistroC172List;  /// BLOCO C - Lista de RegistroC172
    FRegistroC173: TRegistroC173List;  /// BLOCO C - Lista de RegistroC173
    FRegistroC174: TRegistroC174List;  /// BLOCO C - Lista de RegistroC174
    FRegistroC175: TRegistroC175List;  /// BLOCO C - Lista de RegistroC175
    FRegistroC176: TRegistroC176List;  /// BLOCO C - Lista de RegistroC176
    FRegistroC177: TRegistroC177List;  /// BLOCO C - Lista de RegistroC177
    FRegistroC178: TRegistroC178List;  /// BLOCO C - Lista de RegistroC178
    FRegistroC179: TRegistroC179List;  /// BLOCO C - Lista de RegistroC179
    FRegistroC190: TRegistroC190List;  /// BLOCO C - Lista de RegistroC190
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
  public
    constructor Create(AOwner: TComponent); override; /// Create
    destructor Destroy; override; /// Destroy

    function WriteRegistroC001: string;
    function WriteRegistroC100: string;
    function WriteRegistroC110: string;
    function WriteRegistroC111: string;
    function WriteRegistroC112: string;
    function WriteRegistroC113: string;
    function WriteRegistroC114: string;
    function WriteRegistroC115: string;
    function WriteRegistroC120: string;
    function WriteRegistroC130: string;
    function WriteRegistroC140: string;
    function WriteRegistroC141: string;
    function WriteRegistroC160: string;
    function WriteRegistroC165: string;
    function WriteRegistroC170: string;
    function WriteRegistroC171: string;
    function WriteRegistroC172: string;
    function WriteRegistroC173: string;
    function WriteRegistroC174: string;
    function WriteRegistroC175: string;
    function WriteRegistroC176: string;
    function WriteRegistroC177: string;
    function WriteRegistroC178: string;
    function WriteRegistroC179: string;
    function WriteRegistroC190: string;
    function WriteRegistroC195: string;
    function WriteRegistroC197: string;
    function WriteRegistroC300: string;
    function WriteRegistroC310: string;
    function WriteRegistroC320: string;
    function WriteRegistroC321: string;
    function WriteRegistroC350: string;
    function WriteRegistroC370: string;
    function WriteRegistroC390: string;
    function WriteRegistroC400: string;
    function WriteRegistroC405: string;
    function WriteRegistroC410: string;
    function WriteRegistroC420: string;
    function WriteRegistroC425: string;
    function WriteRegistroC460: string;
    function WriteRegistroC470: string;
    function WriteRegistroC490: string;
    function WriteRegistroC495: string;
    function WriteRegistroC500: string;
    function WriteRegistroC510: string;
    function WriteRegistroC590: string;
    function WriteRegistroC600: string;
    function WriteRegistroC601: string;
    function WriteRegistroC610: string;
    function WriteRegistroC620: string;
    function WriteRegistroC690: string;
    function WriteRegistroC700: string;
    function WriteRegistroC790: string;
    function WriteRegistroC791: string;
    function WriteRegistroC990: string;

    property RegistroC001: TRegistroC001 read FRegistroC001 write FRegistroC001;
    property RegistroC100: TRegistroC100List read FRegistroC100 write FRegistroC100;
    property RegistroC110: TRegistroC110List read FRegistroC110 write FRegistroC110;
    property RegistroC111: TRegistroC111List read FRegistroC111 write FRegistroC111;
    property RegistroC112: TRegistroC112List read FRegistroC112 write FRegistroC112;
    property RegistroC113: TRegistroC113List read FRegistroC113 write FRegistroC113;
    property RegistroC114: TRegistroC114List read FRegistroC114 write FRegistroC114;
    property RegistroC115: TRegistroC115List read FRegistroC115 write FRegistroC115;
    property RegistroC120: TRegistroC120List read FRegistroC120 write FRegistroC120;
    property RegistroC130: TRegistroC130List read FRegistroC130 write FRegistroC130;
    property RegistroC140: TRegistroC140List read FRegistroC140 write FRegistroC140;
    property RegistroC141: TRegistroC141List read FRegistroC141 write FRegistroC141;
    property RegistroC160: TRegistroC160List read FRegistroC160 write FRegistroC160;
    property RegistroC165: TRegistroC165List read FRegistroC165 write FRegistroC165;
    property RegistroC170: TRegistroC170List read FRegistroC170 write FRegistroC170;
    property RegistroC171: TRegistroC171List read FRegistroC171 write FRegistroC171;
    property RegistroC172: TRegistroC172List read FRegistroC172 write FRegistroC172;
    property RegistroC173: TRegistroC173List read FRegistroC173 write FRegistroC173;
    property RegistroC174: TRegistroC174List read FRegistroC174 write FRegistroC174;
    property RegistroC175: TRegistroC175List read FRegistroC175 write FRegistroC175;
    property RegistroC176: TRegistroC176List read FRegistroC176 write FRegistroC176;
    property RegistroC177: TRegistroC177List read FRegistroC177 write FRegistroC177;
    property RegistroC178: TRegistroC178List read FRegistroC178 write FRegistroC178;
    property RegistroC179: TRegistroC179List read FRegistroC179 write FRegistroC179;
    property RegistroC190: TRegistroC190List read FRegistroC190 write FRegistroC190;
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
  end;

implementation

{ TBloco_C }

constructor TBloco_C.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FRegistroC001 := TRegistroC001.Create;
  FRegistroC100 := TRegistroC100List.Create;
  FRegistroC110 := TRegistroC110List.Create;
  FRegistroC111 := TRegistroC111List.Create;
  FRegistroC112 := TRegistroC112List.Create;
  FRegistroC113 := TRegistroC113List.Create;
  FRegistroC114 := TRegistroC114List.Create;
  FRegistroC115 := TRegistroC115List.Create;
  FRegistroC120 := TRegistroC120List.Create;
  FRegistroC130 := TRegistroC130List.Create;
  FRegistroC140 := TRegistroC140List.Create;
  FRegistroC141 := TRegistroC141List.Create;
  FRegistroC160 := TRegistroC160List.Create;
  FRegistroC165 := TRegistroC165List.Create;
  FRegistroC170 := TRegistroC170List.Create;
  FRegistroC171 := TRegistroC171List.Create;
  FRegistroC172 := TRegistroC172List.Create;
  FRegistroC173 := TRegistroC173List.Create;
  FRegistroC174 := TRegistroC174List.Create;
  FRegistroC175 := TRegistroC175List.Create;
  FRegistroC176 := TRegistroC176List.Create;
  FRegistroC177 := TRegistroC177List.Create;
  FRegistroC178 := TRegistroC178List.Create;
  FRegistroC179 := TRegistroC179List.Create;
  FRegistroC190 := TRegistroC190List.Create;
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
end;

destructor TBloco_C.Destroy;
begin
  FRegistroC001.Free;
  FRegistroC100.Free;
  FRegistroC110.Free;
  FRegistroC111.Free;
  FRegistroC112.Free;
  FRegistroC113.Free;
  FRegistroC114.Free;
  FRegistroC115.Free;
  FRegistroC120.Free;
  FRegistroC130.Free;
  FRegistroC140.Free;
  FRegistroC141.Free;
  FRegistroC160.Free;
  FRegistroC165.Free;
  FRegistroC170.Free;
  FRegistroC171.Free;
  FRegistroC172.Free;
  FRegistroC173.Free;
  FRegistroC174.Free;
  FRegistroC175.Free;
  FRegistroC176.Free;
  FRegistroC177.Free;
  FRegistroC178.Free;
  FRegistroC179.Free;
  FRegistroC190.Free;
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
  inherited;
end;

function TBloco_C.WriteRegistroC001: string;
begin
  Result := '';

  if Assigned(RegistroC001) then
  begin
     with RegistroC001 do
     begin
       Check(((IND_MOV = 0) or (IND_MOV = 1)), 'BLOCO C - REGISTROC001: Na abertura do bloco, deve ser informado o número 0 ou 1!');
       ///
       Result := LFill('C001') +
                 LFill(IND_MOV, 1) +
                 Delimitador +
                 #13#10;
       ///
       RegistroC990.QTD_LIN_C := RegistroC990.QTD_LIN_C + 1;
     end;
  end;
end;

function TBloco_C.WriteRegistroC100: string;
begin

end;

function TBloco_C.WriteRegistroC110: string;
begin

end;

function TBloco_C.WriteRegistroC111: string;
begin

end;

function TBloco_C.WriteRegistroC112: string;
begin

end;

function TBloco_C.WriteRegistroC113: string;
begin

end;

function TBloco_C.WriteRegistroC114: string;
begin

end;

function TBloco_C.WriteRegistroC115: string;
begin

end;

function TBloco_C.WriteRegistroC120: string;
begin

end;

function TBloco_C.WriteRegistroC130: string;
begin

end;

function TBloco_C.WriteRegistroC140: string;
begin

end;

function TBloco_C.WriteRegistroC141: string;
begin

end;

function TBloco_C.WriteRegistroC160: string;
begin

end;

function TBloco_C.WriteRegistroC165: string;
begin

end;

function TBloco_C.WriteRegistroC170: string;
begin

end;

function TBloco_C.WriteRegistroC171: string;
begin

end;

function TBloco_C.WriteRegistroC172: string;
begin

end;

function TBloco_C.WriteRegistroC173: string;
begin

end;

function TBloco_C.WriteRegistroC174: string;
begin

end;

function TBloco_C.WriteRegistroC175: string;
begin

end;

function TBloco_C.WriteRegistroC176: string;
begin

end;

function TBloco_C.WriteRegistroC177: string;
begin

end;

function TBloco_C.WriteRegistroC178: string;
begin

end;

function TBloco_C.WriteRegistroC179: string;
begin

end;

function TBloco_C.WriteRegistroC190: string;
begin

end;

function TBloco_C.WriteRegistroC195: string;
begin

end;

function TBloco_C.WriteRegistroC197: string;
begin

end;

function TBloco_C.WriteRegistroC300: string;
begin

end;

function TBloco_C.WriteRegistroC310: string;
begin

end;

function TBloco_C.WriteRegistroC320: string;
begin

end;

function TBloco_C.WriteRegistroC321: string;
begin

end;

function TBloco_C.WriteRegistroC350: string;
begin

end;

function TBloco_C.WriteRegistroC370: string;
begin

end;

function TBloco_C.WriteRegistroC390: string;
begin

end;

function TBloco_C.WriteRegistroC400: string;
begin

end;

function TBloco_C.WriteRegistroC405: string;
begin

end;

function TBloco_C.WriteRegistroC410: string;
begin

end;

function TBloco_C.WriteRegistroC420: string;
begin

end;

function TBloco_C.WriteRegistroC425: string;
begin

end;

function TBloco_C.WriteRegistroC460: string;
begin

end;

function TBloco_C.WriteRegistroC470: string;
begin

end;

function TBloco_C.WriteRegistroC490: string;
begin

end;

function TBloco_C.WriteRegistroC495: string;
begin

end;

function TBloco_C.WriteRegistroC500: string;
begin

end;

function TBloco_C.WriteRegistroC510: string;
begin

end;

function TBloco_C.WriteRegistroC590: string;
begin

end;

function TBloco_C.WriteRegistroC600: string;
begin

end;

function TBloco_C.WriteRegistroC601: string;
begin

end;

function TBloco_C.WriteRegistroC610: string;
begin

end;

function TBloco_C.WriteRegistroC620: string;
begin

end;

function TBloco_C.WriteRegistroC690: string;
begin

end;

function TBloco_C.WriteRegistroC700: string;
begin

end;

function TBloco_C.WriteRegistroC790: string;
begin

end;

function TBloco_C.WriteRegistroC791: string;
begin

end;

function TBloco_C.WriteRegistroC990: string;
begin
  Result := '';

  if Assigned(RegistroC990) then
  begin
     with RegistroC990 do
     begin
       QTD_LIN_C := QTD_LIN_C + 1;
       ///
       Result := LFill('C990') +
                 LFill(QTD_LIN_C,0,0) +
                 Delimitador +
                 #13#10;
     end;
  end;
end;

end.
