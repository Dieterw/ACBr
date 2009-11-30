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

unit ACBrBloco_0_Class;

interface

uses SysUtils, Classes, DateUtils, ACBrSped, ACBrBloco_0;

type
  /// TBLOCO_0 - Abertura, Identificação e Referências
  TBloco_0 = class(TACBrSPED)
  private
    FRegistro0000: TRegistro0000;      /// BLOCO 0 - Registro0000
    FRegistro0001: TRegistro0001;      /// BLOCO 0 - Registro0001
    FRegistro0007: TRegistro0007List;  /// BLOCO 0 - Lista de Registro0007
    FRegistro0020: TRegistro0020List;  /// BLOCO 0 - Lista de Registro0020
    FRegistro0150: TRegistro0150List;  /// BLOCO 0 - Lista de Registro0150
    FRegistro0180: TRegistro0180List;  /// BLOCO 0 - Lista de Registro0180
    FRegistro0990: TRegistro0990;      /// BLOCO 0 - Registro0990
  protected
  public
    constructor Create(AOwner: TComponent); override; /// Create
    destructor Destroy; override; /// Destroy
    procedure LimpaRegistros;

    function WriteRegistro0000: AnsiString;
    function WriteRegistro0001: AnsiString;
    function WriteRegistro0007: AnsiString;
    function WriteRegistro0020: AnsiString;
    function WriteRegistro0150: AnsiString;
    function WriteRegistro0180: AnsiString;
    function WriteRegistro0990: AnsiString;

    property Registro0000: TRegistro0000     read FRegistro0000 write FRegistro0000;
    property Registro0001: TRegistro0001     read FRegistro0001 write FRegistro0001;
    property Registro0007: TRegistro0007List read FRegistro0007 write FRegistro0007;
    property Registro0020: TRegistro0020List read FRegistro0020 write FRegistro0020;
    property Registro0150: TRegistro0150List read FRegistro0150 write FRegistro0150;
    property Registro0180: TRegistro0180List read FRegistro0180 write FRegistro0180;
    property Registro0990: TRegistro0990 read FRegistro0990 write FRegistro0990;
  end;

implementation

uses ACBrSpedUtils;

{ TBloco_0 }

constructor TBloco_0.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FRegistro0000 := TRegistro0000.Create;
  FRegistro0001 := TRegistro0001.Create;
  FRegistro0007 := TRegistro0007List.Create;
  FRegistro0020 := TRegistro0020List.Create;
  FRegistro0150 := TRegistro0150List.Create;
  FRegistro0180 := TRegistro0180List.Create;
  FRegistro0990 := TRegistro0990.Create;

  FRegistro0990.QTD_LIN_0 := 0;
end;

destructor TBloco_0.Destroy;
begin
  FRegistro0000.Free;
  FRegistro0001.Free;
  FRegistro0007.Free;
  FRegistro0020.Free;
  FRegistro0150.Free;
  FRegistro0180.Free;
  FRegistro0990.Free;
  inherited;
end;

procedure TBloco_0.LimpaRegistros;
begin
  FRegistro0007.Clear;
  FRegistro0020.Clear;
  FRegistro0150.Clear;
  FRegistro0180.Clear;

  FRegistro0990.QTD_LIN_0 := 0;
end;

function TBloco_0.WriteRegistro0000: AnsiString;
begin
  Result := '';

  if Assigned(Registro0000) then
  begin
     with Registro0000 do
     begin
       ///
       Result := LFill('0000') +
                 Delimitador +
                 #13#10;
       ///
       Registro0990.QTD_LIN_0 := Registro0990.QTD_LIN_0 + 1;
     end;
  end;
end;

function TBloco_0.WriteRegistro0001: AnsiString;
begin
  Result := '';

  if Assigned(Registro0001) then
  begin
     with Registro0001 do
     begin
       ///
       Result := LFill('0001') +
                 Delimitador +
                 #13#10;
       ///
       Registro0990.QTD_LIN_0 := Registro0990.QTD_LIN_0 + 1;
     end;
  end;
end;

function TBloco_0.WriteRegistro0007: AnsiString;
var
intFor: integer;
strRegistro0007: AnsiString;
begin
  strRegistro0007 := '';

  if Assigned(Registro0007) then
  begin
     for intFor := 0 to Registro0007.Count - 1 do
     begin
        with Registro0007.Items[intFor] do
        begin
           ///
           strRegistro0007 :=  strRegistro0007 + LFill('0007') +
                                                 Delimitador +
                                                 #13#10;
        end;
        Registro0990.QTD_LIN_0 := Registro0990.QTD_LIN_0 + 1;
     end;
  end;
  Result := strRegistro0007;
end;

function TBloco_0.WriteRegistro0020: AnsiString;
var
intFor: integer;
strRegistro0020: AnsiString;
begin
  strRegistro0020 := '';

  if Assigned(Registro0020) then
  begin
     for intFor := 0 to Registro0020.Count - 1 do
     begin
        with Registro0020.Items[intFor] do
        begin
           ///
           strRegistro0020 :=  strRegistro0020 + LFill('0020') +
                                                 Delimitador +
                                                 #13#10;
        end;
        Registro0990.QTD_LIN_0 := Registro0990.QTD_LIN_0 + 1;
     end;
  end;
  Result := strRegistro0020;
end;

function TBloco_0.WriteRegistro0150: AnsiString;
var
intFor: integer;
strRegistro0150: AnsiString;
begin
  strRegistro0150 := '';

  if Assigned(Registro0150) then
  begin
     for intFor := 0 to Registro0150.Count - 1 do
     begin
        with Registro0150.Items[intFor] do
        begin
           ///
           strRegistro0150 :=  strRegistro0150 + LFill('0150') +
                                                 Delimitador +
                                                 #13#10;
        end;
        Registro0990.QTD_LIN_0 := Registro0990.QTD_LIN_0 + 1;
     end;
  end;
  Result := strRegistro0150;
end;

function TBloco_0.WriteRegistro0180: AnsiString;
var
intFor: integer;
strRegistro0180: AnsiString;
begin
  strRegistro0180 := '';

  if Assigned(Registro0180) then
  begin
     for intFor := 0 to Registro0180.Count - 1 do
     begin
        with Registro0180.Items[intFor] do
        begin
           ///
           strRegistro0180 :=  strRegistro0180 + LFill('0180') +
                                                 Delimitador +
                                                 #13#10;
        end;
        Registro0990.QTD_LIN_0 := Registro0990.QTD_LIN_0 + 1;
     end;
  end;
  Result := strRegistro0180;
end;

function TBloco_0.WriteRegistro0990: AnsiString;
begin
  Result := '';

  if Assigned(Registro0990) then
  begin
     with Registro0990 do
     begin
       QTD_LIN_0 := QTD_LIN_0 + 1;
       ///
       Result := LFill('0990') +
                 LFill(QTD_LIN_0,0) +
                 Delimitador +
                 #13#10;
     end;
  end;
end;

end.
