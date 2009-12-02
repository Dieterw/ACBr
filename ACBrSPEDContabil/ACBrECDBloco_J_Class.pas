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

unit ACBrECDBloco_J_Class;

interface

uses SysUtils, Classes, DateUtils, ACBrSped, ACBrBloco_J;

type
  /// TBloco_J -
  TBloco_J = class(TACBrSPED)
  private
    FRegistroJ001: TRegistroJ001;      /// BLOCO J - RegistroJ001
    FRegistroJ005: TRegistroJ005List;  /// BLOCO J - Lista de RegistroJ005
    FRegistroJ100: TRegistroJ100List;  /// BLOCO J - Lista de RegistroJ100
    FRegistroJ150: TRegistroJ150List;  /// BLOCO J - Lista de RegistroJ150
    FRegistroJ800: TRegistroJ800List;  /// BLOCO J - Lista de RegistroJ800
    FRegistroJ900: TRegistroJ900;      /// BLOCO J - RegistroJ900
    FRegistroJ930: TRegistroJ930List;  /// BLOCO J - Lista de RegistroJ930
    FRegistroJ990: TRegistroJ990;      /// BLOCO J - RegistroJ990
  public
    constructor Create(AOwner: TComponent); override; /// Create
    destructor Destroy; override; /// Destroy
    procedure LimpaRegistros;

    function WriteRegistroJ001: AnsiString;
    function WriteRegistroJ005: AnsiString;
    function WriteRegistroJ100: AnsiString;
    function WriteRegistroJ150: AnsiString;
    function WriteRegistroJ800: AnsiString;
    function WriteRegistroJ900: AnsiString;
    function WriteRegistroJ930: AnsiString;
    function WriteRegistroJ990: AnsiString;

    property RegistroJ001: TRegistroJ001 read fRegistroJ001 write fRegistroJ001;
    property RegistroJ005: TRegistroJ005List read fRegistroJ005 write fRegistroJ005;
    property RegistroJ100: TRegistroJ100List read fRegistroJ100 write fRegistroJ100;
    property RegistroJ150: TRegistroJ150List read fRegistroJ150 write fRegistroJ150;
    property RegistroJ800: TRegistroJ800List read fRegistroJ800 write fRegistroJ800;
    property RegistroJ900: TRegistroJ900 read fRegistroJ900 write fRegistroJ900;
    property RegistroJ930: TRegistroJ930List read fRegistroJ930 write fRegistroJ930;
    property RegistroJ990: TRegistroJ990 read fRegistroJ990 write fRegistroJ990;
  end;

implementation

{ TBloco_J }

constructor TBloco_J.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FRegistroJ001 := TRegistroJ001.Create;
  FRegistroJ005 := TRegistroJ005List.Create;
  FRegistroJ100 := TRegistroJ100List.Create;
  FRegistroJ150 := TRegistroJ150List.Create;
  FRegistroJ800 := TRegistroJ800List.Create;
  FRegistroJ900 := TRegistroJ900.Create;
  FRegistroJ930 := TRegistroJ930List.Create;
  FRegistroJ990 := TRegistroJ990.Create;

  FRegistroJ990.QTD_LIN_J := 0;
end;

destructor TBloco_J.Destroy;
begin
  FRegistroJ001.Free;
  FRegistroJ005.Free;
  FRegistroJ100.Free;
  FRegistroJ150.Free;
  FRegistroJ800.Free;
  FRegistroJ900.Free;
  FRegistroJ930.Free;
  FRegistroJ990.Free;
  inherited;
end;

procedure TBloco_J.LimpaRegistros;
begin
  FRegistroJ005.Clear;
  FRegistroJ100.Clear;
  FRegistroJ150.Clear;
  FRegistroJ800.Clear;
  FRegistroJ930.Clear;

  FRegistroJ990.QTD_LIN_J := 0;
end;

function TBloco_J.WriteRegistroJ001: AnsiString;
begin
  Result := '';

  if Assigned(RegistroJ001) then
  begin
     with RegistroJ001 do
     begin
       ///
       Result := LFill('J001') +
                 Delimitador +
                 #13#10;
       ///
       RegistroJ990.QTD_LIN_J := RegistroJ990.QTD_LIN_J + 1;
     end;
  end;
end;

function TBloco_J.WriteRegistroJ005: AnsiString;
var
intFor: integer;
strRegistroJ005: AnsiString;
begin
  strRegistroJ005 := '';

  if Assigned(RegistroJ005) then
  begin
     for intFor := 0 to RegistroJ005.Count - 1 do
     begin
        with RegistroJ005.Items[intFor] do
        begin
           ///
           strRegistroJ005 :=  strRegistroJ005 + LFill('J005') +
                                                 Delimitador +
                                                 #13#10;
        end;
        RegistroJ990.QTD_LIN_J := RegistroJ990.QTD_LIN_J + 1;
     end;
  end;
  Result := strRegistroJ005;
end;

function TBloco_J.WriteRegistroJ100: AnsiString;
var
intFor: integer;
strRegistroJ100: AnsiString;
begin
  strRegistroJ100 := '';

  if Assigned(RegistroJ100) then
  begin
     for intFor := 0 to RegistroJ100.Count - 1 do
     begin
        with RegistroJ100.Items[intFor] do
        begin
           ///
           strRegistroJ100 :=  strRegistroJ100 + LFill('J100') +
                                                 Delimitador +
                                                 #13#10;
        end;
        RegistroJ990.QTD_LIN_J := RegistroJ990.QTD_LIN_J + 1;
     end;
  end;
  Result := strRegistroJ100;
end;

function TBloco_J.WriteRegistroJ150: AnsiString;
var
intFor: integer;
strRegistroJ150: AnsiString;
begin
  strRegistroJ150 := '';

  if Assigned(RegistroJ150) then
  begin
     for intFor := 0 to RegistroJ150.Count - 1 do
     begin
        with RegistroJ150.Items[intFor] do
        begin
           ///
           strRegistroJ150 :=  strRegistroJ150 + LFill('J150') +
                                                 Delimitador +
                                                 #13#10;
        end;
        RegistroJ990.QTD_LIN_J := RegistroJ990.QTD_LIN_J + 1;
     end;
  end;
  Result := strRegistroJ150;
end;

function TBloco_J.WriteRegistroJ800: AnsiString;
var
intFor: integer;
strRegistroJ800: AnsiString;
begin
  strRegistroJ800 := '';

  if Assigned(RegistroJ800) then
  begin
     for intFor := 0 to RegistroJ800.Count - 1 do
     begin
        with RegistroJ800.Items[intFor] do
        begin
           ///
           strRegistroJ800 :=  strRegistroJ800 + LFill('J800') +
                                                 Delimitador +
                                                 #13#10;
        end;
        RegistroJ990.QTD_LIN_J := RegistroJ990.QTD_LIN_J + 1;
     end;
  end;
  Result := strRegistroJ800;
end;

function TBloco_J.WriteRegistroJ900: AnsiString;
begin
  Result := '';

  if Assigned(RegistroJ900) then
  begin
     with RegistroJ900 do
     begin
       ///
       Result := LFill('J900') +
                 Delimitador +
                 #13#10;
       ///
       RegistroJ990.QTD_LIN_J := RegistroJ990.QTD_LIN_J + 1;
     end;
  end;
end;

function TBloco_J.WriteRegistroJ930: AnsiString;
var
intFor: integer;
strRegistroJ930: AnsiString;
begin
  strRegistroJ930 := '';

  if Assigned(RegistroJ930) then
  begin
     for intFor := 0 to RegistroJ930.Count - 1 do
     begin
        with RegistroJ930.Items[intFor] do
        begin
           ///
           strRegistroJ930 :=  strRegistroJ930 + LFill('J930') +
                                                 Delimitador +
                                                 #13#10;
        end;
        RegistroJ990.QTD_LIN_J := RegistroJ990.QTD_LIN_J + 1;
     end;
  end;
  Result := strRegistroJ930;
end;

function TBloco_J.WriteRegistroJ990: AnsiString;
begin
  Result := '';

  if Assigned(RegistroJ990) then
  begin
     with RegistroJ990 do
     begin
       QTD_LIN_J := QTD_LIN_J + 1;
       ///
       Result := LFill('J990') +
                 LFill(QTD_LIN_J,0) +
                 Delimitador +
                 #13#10;
     end;
  end;
end;

end.
