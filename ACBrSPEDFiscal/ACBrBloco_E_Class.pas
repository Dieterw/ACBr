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
    FRegistroE200: TRegistroE200;      /// BLOCO E - RegistroE200
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
  public
    constructor Create(AOwner: TComponent); override; /// Create
    destructor Destroy; override; /// Destroy

    function WriteRegistroE001: string;
    function WriteRegistroE100: string;
    function WriteRegistroE110: string;
    function WriteRegistroE111: string;
    function WriteRegistroE112: string;
    function WriteRegistroE113: string;
    function WriteRegistroE115: string;
    function WriteRegistroE116: string;
    function WriteRegistroE200: string;
    function WriteRegistroE210: string;
    function WriteRegistroE220: string;
    function WriteRegistroE230: string;
    function WriteRegistroE240: string;
    function WriteRegistroE250: string;
    function WriteRegistroE500: string;
    function WriteRegistroE510: string;
    function WriteRegistroE520: string;
    function WriteRegistroE530: string;
    function WriteRegistroE990: string;

    property RegistroE001: TRegistroE001 read FRegistroE001 write FRegistroE001;
    property RegistroE100: TRegistroE100 read FRegistroE100 write FRegistroE100;
    property RegistroE110: TRegistroE110 read FRegistroE110 write FRegistroE110;
    property RegistroE111: TRegistroE111List read FRegistroE111 write FRegistroE111;
    property RegistroE112: TRegistroE112List read FRegistroE112 write FRegistroE112;
    property RegistroE113: TRegistroE113List read FRegistroE113 write FRegistroE113;
    property RegistroE115: TRegistroE115List read FRegistroE115 write FRegistroE115;
    property RegistroE116: TRegistroE116List read FRegistroE116 write FRegistroE116;
    property RegistroE200: TRegistroE200 read FRegistroE200 write FRegistroE200;
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
  FRegistroE001 := TRegistroE001.Create;
  FRegistroE100 := TRegistroE100.Create;
  FRegistroE110 := TRegistroE110.Create;
  FRegistroE111 := TRegistroE111List.Create;
  FRegistroE112 := TRegistroE112List.Create;
  FRegistroE113 := TRegistroE113List.Create;
  FRegistroE115 := TRegistroE115List.Create;
  FRegistroE116 := TRegistroE116List.Create;
  FRegistroE200 := TRegistroE200.Create;
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
end;

destructor TBloco_E.Destroy;
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
  inherited;
end;

function TBloco_E.WriteRegistroE001: string;
begin
  if Assigned(RegistroE001) then
  begin
     with RegistroE001 do
     begin
       Check(((IND_MOV = 0) or (IND_MOV = 1)), 'BLOCO E - REGISTROE001: Na abertura do bloco, deve ser informado o número 0 ou 1!');
       ///
       Result := LFill('E001') +
                 LFill(IND_MOV, 1) +
                 Delimitador +
                 #13#10;
       ///
       RegistroE990.QTD_LIN_E := RegistroE990.QTD_LIN_E + 1;
     end;
  end;
end;

function TBloco_E.WriteRegistroE100: string;
begin
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

function TBloco_E.WriteRegistroE110: string;
begin
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

function TBloco_E.WriteRegistroE111: string;
begin

end;

function TBloco_E.WriteRegistroE112: string;
begin

end;

function TBloco_E.WriteRegistroE113: string;
begin

end;

function TBloco_E.WriteRegistroE115: string;
begin

end;

function TBloco_E.WriteRegistroE116: string;
begin

end;

function TBloco_E.WriteRegistroE200: string;
begin

end;

function TBloco_E.WriteRegistroE210: string;
begin

end;

function TBloco_E.WriteRegistroE220: string;
begin

end;

function TBloco_E.WriteRegistroE230: string;
begin

end;

function TBloco_E.WriteRegistroE240: string;
begin

end;

function TBloco_E.WriteRegistroE250: string;
begin

end;

function TBloco_E.WriteRegistroE500: string;
begin

end;

function TBloco_E.WriteRegistroE510: string;
begin

end;

function TBloco_E.WriteRegistroE520: string;
begin

end;

function TBloco_E.WriteRegistroE530: string;
begin

end;

function TBloco_E.WriteRegistroE990: string;
begin
  if Assigned(RegistroE990) then
  begin
     with RegistroE990 do
     begin
       QTD_LIN_E := QTD_LIN_E + 1;
       ///
       Result := LFill('E990') +
                 LFill(QTD_LIN_E,0,0) +
                 Delimitador +
                 #13#10;
     end;
  end;
end;

end.
