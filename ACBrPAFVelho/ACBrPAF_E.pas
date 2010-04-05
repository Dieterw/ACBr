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

unit ACBrPAF_E;

interface

uses
  SysUtils, Classes, DateUtils, ACBrPAFRegistros;

type
  /// REGISTRO TIPO E1 - IDENTIFICAÇÃO DO ESTABELECIMENTO USUÁRIO DO PAF-ECF

  TRegistroE1 = class(TRegistroX1)
  end;

  /// REGISTRO TIPO E2 - RELAÇÃO DAS MERCADORIAS EM ESTOQUE

  TRegistroE2 = class(TPersistent)
  private
    fCOD_MERC: string;     /// Código da mercadoria ou produto cadastrado na tabela a que se refere o requisito XI
    fDESC_MERC: string;    /// Descrição da mercadoria ou produto cadastrada na tabela a que se refere o requisito XI
    fUN_MED: string;       /// Unidade de medida cadastrada na tabela a que se refere o requisito XI
    fQTDE_EST: currency;   /// Quantidade da mercadoria ou produto constante no estoque, com duas casas decimais.
    fDT_EST: TDateTime;    /// Data de emissão do DAV
  public
    property COD_MERC: string read FCOD_MERC write FCOD_MERC;
    property DESC_MERC: string read FDESC_MERC write FDESC_MERC;
    property UN_MED: string read FUN_MED write FUN_MED;
    property QTDE_EST: currency read FQTDE_EST write FQTDE_EST;
    property DT_EST: TDateTime read FDT_EST write FDT_EST;
  end;

  /// REGISTRO E2 - Lista

  TRegistroE2List = class(TList)
  private
    function GetItem(Index: Integer): TRegistroE2;
    procedure SetItem(Index: Integer; const Value: TRegistroE2);
  public
    destructor Destroy; override;
    function New: TRegistroE2;
    property Items[Index: Integer]: TRegistroE2 read GetItem write SetItem;
  end;

  /// REGISTRO TIPO E9 - TOTALIZAÇÃO DO ARQUIVO

  TRegistroE9 = class(TRegistroX9)
  end;

implementation

(* TRegistroE2List *)

destructor TRegistroE2List.Destroy;
var
intFor: integer;
begin
  for intFor := 0 to Count - 1 do Items[intFor].Free;
  inherited;
end;

function TRegistroE2List.GetItem(Index: Integer): TRegistroE2;
begin
  Result := TRegistroE2(inherited Items[Index]);
end;

function TRegistroE2List.New: TRegistroE2;
begin
  Result := TRegistroE2.Create;
  Add(Result);
end;

procedure TRegistroE2List.SetItem(Index: Integer; const Value: TRegistroE2);
begin
  Put(Index, Value);
end;

end.
