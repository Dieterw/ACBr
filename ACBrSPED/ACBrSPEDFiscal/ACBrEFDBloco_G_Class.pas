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

unit ACBrEFDBloco_G_Class;

interface

uses SysUtils, Classes, DateUtils, ACBrSped, ACBrEFDBloco_G,
     ACBrEFDBloco_0_Class;

type
  /// TBLOCO_H -
  TBloco_G = class(TACBrSPED)
  private
    FBloco_0: TBloco_0;
    FRegistroG001: TRegistroG001;      /// BLOCO G - RegistroG001
    FRegistroG110: TRegistroG110List;  /// BLOCO G - RegistroG110
    FRegistroG125: TRegistroG125List;  /// BLOCO G - RegistroG125
    FRegistroG130: TRegistroG130List;  /// BLOCO G - RegistroG130
    FRegistroG140: TRegistroG140List;  /// BLOCO G - RegistroG140
    FRegistroG990: TRegistroG990;      /// BLOCO G - RegistroG990

    FRegistroG125Count: Integer;
    FRegistroG130Count: Integer;
    FRegistroG140Count: Integer;

    function WriteRegistroG125(RegG110: TRegistroG110): AnsiString;
    function WriteRegistroG130(RegG125: TRegistroG125): AnsiString;
    function WriteRegistroG140(RegG130: TRegistroG130): AnsiString;

    procedure CriaRegistros;
    procedure LiberaRegistros;
  public
    constructor Create(AOwner: TComponent); override; /// Create
    destructor Destroy; override; /// Destroy
    procedure LimpaRegistros;

    function WriteRegistroG001: AnsiString;
    function WriteRegistroG110: AnsiString;
    function WriteRegistroG990: AnsiString;

    property Bloco_0: TBloco_0 read FBloco_0 write FBloco_0;
    property RegistroG001: TRegistroG001 read FRegistroG001 write FRegistroG001;
    property RegistroG110: TRegistroG110List read FRegistroG110 write FRegistroG110;
    property RegistroG990: TRegistroG990 read FRegistroG990 write FRegistroG990;

    property RegistroG125Count: Integer read FRegistroG125Count write FRegistroG125Count;
    property RegistroG130Count: Integer read FRegistroG130Count write FRegistroG130Count;
    property RegistroG140Count: Integer read FRegistroG140Count write FRegistroG140Count;

  end;

implementation

{ TBloco_G }

constructor TBloco_G.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  CriaRegistros;
end;

destructor TBloco_G.Destroy;
begin
  LiberaRegistros;
  inherited;
end;

procedure TBloco_G.CriaRegistros;
begin
  FRegistroG001 := TRegistroG001.Create;
  FRegistroG110 := TRegistroG110List.Create;
  FRegistroG125 := TRegistroG125List.Create;
  FRegistroG130 := TRegistroG130List.Create;
  FRegistroG140 := TRegistroG140List.Create;
  FRegistroG990 := TRegistroG990.Create;


  FRegistroG125Count := 0;
  FRegistroG130Count := 0;
  FRegistroG140Count := 0;

  FRegistroG990.QTD_LIN_G := 0;
end;

procedure TBloco_G.LiberaRegistros;
begin
  FRegistroG001.Free;
  FRegistroG110.Free;
  FRegistroG125.Free;
  FRegistroG130.Free;
  FRegistroG140.Free;
  FRegistroG990.Free;
end;

procedure TBloco_G.LimpaRegistros;
begin
  FRegistroG990.QTD_LIN_G := 0;
end;

function TBloco_G.WriteRegistroG001: AnsiString;
begin
  Result := '';

  if Assigned(RegistroG001) then
  begin
     with RegistroG001 do
     begin
       Check(((IND_MOV = 0) or (IND_MOV = 1)), 'BLOCO G - REGISTROG001: Na abertura do bloco, deve ser informado o número 0 ou 1!');
       ///
       Result := LFill('G001') +
                 LFill(IND_MOV, 0) +
                 Delimitador +
                 #13#10;
       ///
       RegistroG990.QTD_LIN_G := RegistroG990.QTD_LIN_G + 1;
     end;
  end;
end;

function TBloco_G.WriteRegistroG110: AnsiString;
var
intFor: integer;
strRegistroG110: AnsiString;
begin
  Result := '';

  if Assigned(RegistroG110) then
  begin
     for intFor := 0 to RegistroG110.Count - 1 do
     begin
        with RegistroG110.Items[intFor] do
        begin
           strRegistroG110 := strRegistroG110 +  LFill('G110') +
                                                 LFill( DT_INI) +
                                                 LFill( DT_FIN) +
                                                 LFill( MODO_CIAP ) +
                                                 LFill( SALDO_IN_ICMS, 0, 2 ) +
                                                 LFill( SALDO_FN_ICMS, 0, 2 ) +
                                                 LFill( SOM_PARC, 0, 2 ) +
                                                 LFill( VL_TRIB_EXP, 0, 2 ) +
                                                 LFill( VL_TOTAL, 0, 2 ) +
                                                 LFill( PER_SAI_TRIB, 0, 2 ) +
                                                 LFill( ICMS_APROP, 0, 2 ) +
                                                 Delimitador +
                                                 #13#10;
           ///
           strRegistroG110 := strRegistroG110 +
                              WriteRegistroG125( RegistroG110.Items[intFor] );
         end;
        RegistroG990.QTD_LIN_G := RegistroG990.QTD_LIN_G + 1;
     end;
  end;
  Result := strRegistroG110;
end;

function TBloco_G.WriteRegistroG125(RegG110: TRegistroG110): AnsiString;
var
intFor: integer;
strRegistroG125: AnsiString;
begin
  strRegistroG125 := '';

  if Assigned( RegG110.RegistroG125 ) then
  begin
     for intFor := 0 to RegG110.RegistroG125.Count - 1 do
     begin
        with RegG110.RegistroG125.Items[intFor] do
        begin
          strRegistroG125 := strRegistroG125 + LFill('E111') +
                                               LFill( COD_IND_BEM ) +
                                               LFill( DT_MOV ) +
                                               LFill( TIPO_MOV ) +
                                               LFill( VL_IMOB_ICMS_OP, 0, 2 ) +
                                               LFill( VL_IMOB_ICMS_ST, 0, 2 ) +
                                               LFill( VL_IMOB_ICMS_FRT, 0, 2 ) +
                                               LFill( VL_IMOB_ICMS_DIF, 0, 2 ) +
                                               LFill( NUM_PARC ,0 ) +
                                               LFill( VL_PARC_PASS, 0, 2 ) +
                                               LFill( VL_PARC_APROP, 0, 2 ) +
                                               Delimitador +
                                               #13#10;
        end;
        strRegistroG125 := strRegistroG125 +
                           WriteRegistroG130( RegG110.RegistroG125.Items[intFor]);
        RegistroG990.QTD_LIN_G := RegistroG990.QTD_LIN_G + 1;
     end;
     FRegistroG125Count := FRegistroG125Count + RegG110.RegistroG125.Count;
  end;
  Result := strRegistroG125;
end;

function TBloco_G.WriteRegistroG130(RegG125: TRegistroG125): AnsiString;
var
intFor: integer;
strRegistroG130: AnsiString;
begin
  strRegistroG130 := '';

  if Assigned( RegG125.RegistroG130 ) then
  begin
     for intFor := 0 to RegG125.RegistroG130.Count - 1 do
     begin
        with RegG125.RegistroG130.Items[intFor] do
        begin
          strRegistroG130 := strRegistroG130 + LFill('E111') +
                                               LFill( IND_EMIT ) +
                                               LFill( COD_PART ) +
                                               LFill( COD_MOD ) +
                                               LFill( SERIE ) +
                                               LFill( NUM_DOC ) +
                                               LFill( CHV_NFE_CTE ) +
                                               LFill( DT_DOC ) +
                                               Delimitador +
                                               #13#10;
        end;
        strRegistroG130 := strRegistroG130 +
                           WriteRegistroG140( RegG125.RegistroG130.Items[intFor]);
        RegistroG990.QTD_LIN_G := RegistroG990.QTD_LIN_G + 1;
     end;
     /// Variavél para armazenar a quantidade de registro do tipo.
     FRegistroG130Count := FRegistroG130Count + RegG125.RegistroG130.Count;
  end;
  Result := strRegistroG130;

end;

function TBloco_G.WriteRegistroG140(RegG130: TRegistroG130): AnsiString;
var
intFor: integer;
strRegistroG140: AnsiString;
begin
  strRegistroG140 := '';

  if Assigned( RegG130.RegistroG140 ) then
  begin
     for intFor := 0 to RegG130.RegistroG140.Count - 1 do
     begin
        with RegG130.RegistroG140.Items[intFor] do
        begin
          Check(FBloco_0.Registro0200.LocalizaRegistro(COD_ITEM), '(G-G140) ITENS: O código do item "%s" não existe no registro 0200!', [COD_ITEM]);

          strRegistroG140 := strRegistroG140 + LFill('E111') +
                                               LFill( NUM_ITEM, 3) +
                                               LFill( COD_ITEM ) +
                                               Delimitador +
                                               #13#10;
        end;
        RegistroG990.QTD_LIN_G := RegistroG990.QTD_LIN_G + 1;
     end;
     FRegistroG140Count := FRegistroG140Count + RegG130.RegistroG140.Count;
  end;
  Result := strRegistroG140;
end;

function TBloco_G.WriteRegistroG990: AnsiString;
begin
  Result := '';

  if Assigned(RegistroG990) then
  begin
     with RegistroG990 do
     begin
       QTD_LIN_G := QTD_LIN_G + 1;
       ///
       Result := LFill('G990') +
                 LFill(QTD_LIN_G,0) +
                 Delimitador +
                 #13#10;
     end;
  end;
end;

end.
