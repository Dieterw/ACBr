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

unit ACBrBloco_H_Class;

interface

uses SysUtils, Classes, DateUtils, ACBrSped, ACBrBloco_H;

type
  /// TBLOCO_H -
  TBloco_H = class(TACBrSPED)
  private
    FRegistroH001: TRegistroH001;      /// BLOCO H - RegistroH001
    FRegistroH005: TRegistroH005;      /// BLOCO H - RegistroH005
    FRegistroH010: TRegistroH010List;  /// BLOCO H - Lista de RegistroH010
    FRegistroH990: TRegistroH990;      /// BLOCO H - RegistroH990

    procedure CriaRegistros;
    procedure LiberaRegistros;
  public
    constructor Create(AOwner: TComponent); override; /// Create
    destructor Destroy; override; /// Destroy
    procedure LimpaRegistros;

    function WriteRegistroH001: AnsiString;
    function WriteRegistroH005: AnsiString;
    function WriteRegistroH010: AnsiString;
    function WriteRegistroH990: AnsiString;

    property RegistroH001: TRegistroH001 read FRegistroH001 write FRegistroH001;
    property RegistroH005: TRegistroH005 read FRegistroH005 write FRegistroH005;
    property RegistroH010: TRegistroH010List read FRegistroH010 write FRegistroH010;
    property RegistroH990: TRegistroH990 read FRegistroH990 write FRegistroH990;
  end;

implementation

{ TBloco_H }

constructor TBloco_H.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  CriaRegistros;
end;

destructor TBloco_H.Destroy;
begin
  LiberaRegistros;
  inherited;
end;

procedure TBloco_H.CriaRegistros;
begin
  FRegistroH001 := TRegistroH001.Create;
  FRegistroH005 := TRegistroH005.Create;
  FRegistroH010 := TRegistroH010List.Create;
  FRegistroH990 := TRegistroH990.Create;

  FRegistroH990.QTD_LIN_H := 0;
end;

procedure TBloco_H.LiberaRegistros;
begin
  FRegistroH001.Free;
  FRegistroH005.Free;
  FRegistroH010.Free;
  FRegistroH990.Free;
end;

procedure TBloco_H.LimpaRegistros;
begin
  /// Limpa os Registros
  LiberaRegistros;
  /// Recriar os Registros Limpos
  CriaRegistros;
end;

function TBloco_H.WriteRegistroH001: AnsiString;
begin
  Result := '';

  if Assigned(RegistroH001) then
  begin
     with RegistroH001 do
     begin
       Check(((IND_MOV = 0) or (IND_MOV = 1)), 'BLOCO H - REGISTROH001: Na abertura do bloco, deve ser informado o número 0 ou 1!');
       ///
       Result := LFill('H001') +
                 LFill(IND_MOV, 0) +
                 Delimitador +
                 #13#10;
       ///
       RegistroH990.QTD_LIN_H := RegistroH990.QTD_LIN_H + 1;
     end;
  end;
end;

function TBloco_H.WriteRegistroH005: AnsiString;
begin
  Result := '';

  if Assigned(RegistroH005) then
  begin
     with RegistroH005 do
     begin
       Result := LFill('H005') +
                 LFill( DT_INV ) +
                 LFill( VL_INV, 0) +
                 Delimitador +
                 #13#10;
       RegistroH990.QTD_LIN_H := RegistroH990.QTD_LIN_H + 1;
     end;
  end;

end;

function TBloco_H.WriteRegistroH010: AnsiString;
var
intFor: integer;
strRegistroH010: string;
begin
  strRegistroH010 := '';

  if Assigned( RegistroH010 ) then
  begin
     for intFor := 0 to RegistroH010.Count - 1 do
     begin
        with RegistroH010.Items[intFor] do
        begin
          strRegistroH010 := strRegistroH010 + LFill('H010') +
                                               LFill( COD_ITEM ) +
                                               LFill( UNID ) +
                                               LFill( QTD,0 ) +
                                               LFill( VL_UNIT,0 ) +
                                               LFill( IND_PROP ) +
                                               LFill( COD_PART ) +
                                               LFill( TXT_COMPL ) +
                                               LFill( COD_OBS ) +
                                               LFill( COD_CTA ) +
                                               Delimitador +
                                               #13#10;
        end;
        RegistroH990.QTD_LIN_H := RegistroH990.QTD_LIN_H + 1;
     end;
  end;
  Result := strRegistroH010;
end;

function TBloco_H.WriteRegistroH990: AnsiString;
begin
  Result := '';

  if Assigned(RegistroH990) then
  begin
     with RegistroH990 do
     begin
       QTD_LIN_H := QTD_LIN_H + 1;
       ///
       Result := LFill('H990') +
                 LFill(QTD_LIN_H,0) +
                 Delimitador +
                 #13#10;
     end;
  end;
end;

end.
