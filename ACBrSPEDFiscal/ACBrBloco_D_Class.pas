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

unit ACBrBloco_D_Class;

interface

uses SysUtils, Classes, DateUtils, ACBrSped, ACBrBloco_D;

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
  public
    constructor Create(AOwner: TComponent); override; /// Create
    destructor Destroy; override; /// Destroy

    function WriteRegistroD001: string;
    function WriteRegistroD100: string;
    function WriteRegistroD110: string;
    function WriteRegistroD120: string;
    function WriteRegistroD130: string;
    function WriteRegistroD140: string;
    function WriteRegistroD150: string;
    function WriteRegistroD160: string;
    function WriteRegistroD161: string;
    function WriteRegistroD162: string;
    function WriteRegistroD170: string;
    function WriteRegistroD180: string;
    function WriteRegistroD190: string;
    function WriteRegistroD300: string;
    function WriteRegistroD301: string;
    function WriteRegistroD310: string;
    function WriteRegistroD350: string;
    function WriteRegistroD355: string;
    function WriteRegistroD360: string;
    function WriteRegistroD365: string;
    function WriteRegistroD370: string;
    function WriteRegistroD390: string;
    function WriteRegistroD400: string;
    function WriteRegistroD410: string;
    function WriteRegistroD411: string;
    function WriteRegistroD420: string;
    function WriteRegistroD500: string;
    function WriteRegistroD990: string;

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
  end;

implementation

{ TBloco_D }

constructor TBloco_D.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
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
end;

destructor TBloco_D.Destroy;
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
  inherited;
end;

function TBloco_D.WriteRegistroD001: string;
begin
  Result := '';

  if Assigned(RegistroD001) then
  begin
     with RegistroD001 do
     begin
       Check(((IND_MOV = 0) or (IND_MOV = 1)), 'BLOCO D - REGISTROD001: Na abertura do bloco, deve ser informado o número 0 ou 1!');
       ///
       Result := LFill('D001') +
                 LFill(IND_MOV, 1) +
                 Delimitador +
                 #13#10;
       ///
       RegistroD990.QTD_LIN_D := RegistroD990.QTD_LIN_D + 1;
     end;
  end;
end;

function TBloco_D.WriteRegistroD100: string;
begin

end;

function TBloco_D.WriteRegistroD110: string;
begin

end;

function TBloco_D.WriteRegistroD120: string;
begin

end;

function TBloco_D.WriteRegistroD130: string;
begin

end;

function TBloco_D.WriteRegistroD140: string;
begin

end;

function TBloco_D.WriteRegistroD150: string;
begin

end;

function TBloco_D.WriteRegistroD160: string;
begin

end;

function TBloco_D.WriteRegistroD161: string;
begin

end;

function TBloco_D.WriteRegistroD162: string;
begin

end;

function TBloco_D.WriteRegistroD170: string;
begin

end;

function TBloco_D.WriteRegistroD180: string;
begin

end;

function TBloco_D.WriteRegistroD190: string;
begin

end;

function TBloco_D.WriteRegistroD300: string;
begin

end;

function TBloco_D.WriteRegistroD301: string;
begin

end;

function TBloco_D.WriteRegistroD310: string;
begin

end;

function TBloco_D.WriteRegistroD350: string;
begin

end;

function TBloco_D.WriteRegistroD355: string;
begin

end;

function TBloco_D.WriteRegistroD360: string;
begin

end;

function TBloco_D.WriteRegistroD365: string;
begin

end;

function TBloco_D.WriteRegistroD370: string;
begin

end;

function TBloco_D.WriteRegistroD390: string;
begin

end;

function TBloco_D.WriteRegistroD400: string;
begin

end;

function TBloco_D.WriteRegistroD410: string;
begin

end;

function TBloco_D.WriteRegistroD411: string;
begin

end;

function TBloco_D.WriteRegistroD420: string;
begin

end;

function TBloco_D.WriteRegistroD500: string;
begin

end;

function TBloco_D.WriteRegistroD990: string;
begin
  Result := '';

  if Assigned(RegistroD990) then
  begin
     with RegistroD990 do
     begin
       QTD_LIN_D := QTD_LIN_D + 1;
       ///
       Result := LFill('D990') +
                 LFill(QTD_LIN_D,0,0) +
                 Delimitador +
                 #13#10;
     end;
  end;
end;

end.
