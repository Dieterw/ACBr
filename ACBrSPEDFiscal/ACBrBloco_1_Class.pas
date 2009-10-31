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

unit ACBrBloco_1_Class;

interface

uses SysUtils, Classes, DateUtils, ACBrSped, ACBrBloco_1;

type
  /// TBLOCO_1 -
  TBloco_1 = class(TACBrSPED)
  private
    FRegistro1001: TRegistro1001;      /// BLOCO 1 - Registro1001
    FRegistro1100: TRegistro1100List;  /// BLOCO 1 - Lista de Registro1100
    FRegistro1105: TRegistro1105List;  /// BLOCO 1 - Lista de Registro1105
    FRegistro1110: TRegistro1110List;  /// BLOCO 1 - Lista de Registro1110
    FRegistro1200: TRegistro1200List;  /// BLOCO 1 - Lista de Registro1200
    FRegistro1210: TRegistro1210List;  /// BLOCO 1 - Lista de Registro1210
    FRegistro1300: TRegistro1300List;  /// BLOCO 1 - Lista de Registro1300
    FRegistro1310: TRegistro1310List;  /// BLOCO 1 - Lista de Registro1310
    FRegistro1320: TRegistro1320List;  /// BLOCO 1 - Lista de Registro1320
    FRegistro1400: TRegistro1400List;  /// BLOCO 1 - Lista de Registro1400
    FRegistro1500: TRegistro1500List;  /// BLOCO 1 - Lista de Registro1500
    FRegistro1510: TRegistro1510List;  /// BLOCO 1 - Lista de Registro1510
    FRegistro1990: TRegistro1990;      /// BLOCO 1 - Registro1990
  public
    constructor Create(AOwner: TComponent); override; /// Create
    destructor Destroy; override; /// Destroy

    function WriteRegistro1001: string;
    function WriteRegistro1100: string;
    function WriteRegistro1105: string;
    function WriteRegistro1110: string;
    function WriteRegistro1200: string;
    function WriteRegistro1210: string;
    function WriteRegistro1300: string;
    function WriteRegistro1310: string;
    function WriteRegistro1320: string;
    function WriteRegistro1400: string;
    function WriteRegistro1500: string;
    function WriteRegistro1510: string;
    function WriteRegistro1990: string;

    property Registro1001: TRegistro1001 read FRegistro1001 write FRegistro1001;
    property Registro1100: TRegistro1100List read FRegistro1100 write FRegistro1100;
    property Registro1105: TRegistro1105List read FRegistro1105 write FRegistro1105;
    property Registro1110: TRegistro1110List read FRegistro1110 write FRegistro1110;
    property Registro1200: TRegistro1200List read FRegistro1200 write FRegistro1200;
    property Registro1210: TRegistro1210List read FRegistro1210 write FRegistro1210;
    property Registro1300: TRegistro1300List read FRegistro1300 write FRegistro1300;
    property Registro1310: TRegistro1310List read FRegistro1310 write FRegistro1310;
    property Registro1320: TRegistro1320List read FRegistro1320 write FRegistro1320;
    property Registro1400: TRegistro1400List read FRegistro1400 write FRegistro1400;
    property Registro1500: TRegistro1500List read FRegistro1500 write FRegistro1500;
    property Registro1510: TRegistro1510List read FRegistro1510 write FRegistro1510;
    property Registro1990: TRegistro1990 read FRegistro1990 write FRegistro1990;
  end;

implementation

{ TBloco_1 }

constructor TBloco_1.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FRegistro1001 := TRegistro1001.Create;
  FRegistro1100 := TRegistro1100List.Create;
  FRegistro1105 := TRegistro1105List.Create;
  FRegistro1110 := TRegistro1110List.Create;
  FRegistro1200 := TRegistro1200List.Create;
  FRegistro1210 := TRegistro1210List.Create;
  FRegistro1300 := TRegistro1300List.Create;
  FRegistro1310 := TRegistro1310List.Create;
  FRegistro1320 := TRegistro1320List.Create;
  FRegistro1400 := TRegistro1400List.Create;
  FRegistro1500 := TRegistro1500List.Create;
  FRegistro1510 := TRegistro1510List.Create;
  FRegistro1990 := TRegistro1990.Create;
end;

destructor TBloco_1.Destroy;
begin
  FRegistro1001.Free;
  FRegistro1100.Free;
  FRegistro1105.Free;
  FRegistro1110.Free;
  FRegistro1200.Free;
  FRegistro1210.Free;
  FRegistro1300.Free;
  FRegistro1310.Free;
  FRegistro1320.Free;
  FRegistro1400.Free;
  FRegistro1500.Free;
  FRegistro1510.Free;
  FRegistro1990.Free;
  inherited;
end;

function TBloco_1.WriteRegistro1001: string;
begin
  if Assigned(Registro1001) then
  begin
     with Registro1001 do
     begin
       Check(((IND_MOV = 0) or (IND_MOV = 1)), 'BLOCO 1 - REGISTRO1001: Na abertura do bloco, deve ser informado o número 0 ou 1!');
       ///
       Result := LFill('1001') +
                 LFill(IND_MOV, 1) +
                 '|' +
                 #13#10;
       ///
       Registro1990.QTD_LIN_1 := Registro1990.QTD_LIN_1 + 1;
     end;
  end;
end;

function TBloco_1.WriteRegistro1100: string;
begin

end;

function TBloco_1.WriteRegistro1105: string;
begin

end;

function TBloco_1.WriteRegistro1110: string;
begin

end;

function TBloco_1.WriteRegistro1200: string;
begin

end;

function TBloco_1.WriteRegistro1210: string;
begin

end;

function TBloco_1.WriteRegistro1300: string;
begin

end;

function TBloco_1.WriteRegistro1310: string;
begin

end;

function TBloco_1.WriteRegistro1320: string;
begin

end;

function TBloco_1.WriteRegistro1400: string;
begin

end;

function TBloco_1.WriteRegistro1500: string;
begin

end;

function TBloco_1.WriteRegistro1510: string;
begin

end;

function TBloco_1.WriteRegistro1990: string;
begin
  if Assigned(Registro1990) then
  begin
     with Registro1990 do
     begin
       QTD_LIN_1 := QTD_LIN_1 + 1;
       ///
       Result := LFill('1990') +
                 LFill(QTD_LIN_1,0,0) +
                 '|' +
                 #13#10;
     end;
  end;
end;

end.
