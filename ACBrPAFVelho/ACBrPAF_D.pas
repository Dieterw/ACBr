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

unit ACBrPAF_D;

interface

uses
  SysUtils, Classes, DateUtils, ACBrPAFRegistros;

type
  /// REGISTRO TIPO D1 - IDENTIFICAÇÃO DO ESTABELECIMENTO USUÁRIO DO PAF-ECF

  TRegistroD1 = class(TRegistroX1)
  end;

  /// REGISTRO TIPO D2 - RELAÇÃO DOS DAV EMITIDOS:

  TRegistroD2 = class(TPersistent)
  private
    fNUM_FAB: string;      /// Nº de fabricação do ECF
    fMF_ADICIONAL: string; /// Letra indicativa de MF adicional
    fTIPO_ECF: string;     /// Tipo do ECF
    fMARCA_ECF: string;    /// Marca do ECF
    fMODELO_ECF: string;   /// Modelo do ECF
    fCOO: string;          /// Contador de Ordem de Operação do documento onde o DAV foi impresso pelo ECF
    fNUM_DAV: string;      /// Número do DAV emitido
    fDT_DAV: TDateTime;    /// Data de emissão do DAV
    fTIT_DAV: string;      /// Título atribuído ao DAV de acordo com sua função. Ex: Orçamento, Pedido, etc.
    fVLT_DAV: currency;    /// Valor total do DAV emitido, com duas casas decimais
    fCCF: string;          /// Contador de Cupom Fiscal do documento fiscal vinculado
  public
    property NUM_FAB: string read FNUM_FAB write FNUM_FAB;
    property MF_ADICIONAL: string read FMF_ADICIONAL write FMF_ADICIONAL;
    property TIPO_ECF: string read FTIPO_ECF write FTIPO_ECF;
    property MARCA_ECF: string read FMARCA_ECF write FMARCA_ECF;
    property MODELO_ECF: string read FMODELO_ECF write FMODELO_ECF;
    property COO: string read FCOO write FCOO;
    property NUM_DAV: string read FNUM_DAV write FNUM_DAV;
    property DT_DAV: TDateTime read FDT_DAV write FDT_DAV;
    property TIT_DAV: string read FTIT_DAV write FTIT_DAV;
    property VLT_DAV: currency read FVLT_DAV write FVLT_DAV;
    property CCF: string read FCCF write FCCF;
  end;

  /// REGISTRO D2 - Lista

  TRegistroD2List = class(TList)
  private
    function GetItem(Index: Integer): TRegistroD2;
    procedure SetItem(Index: Integer; const Value: TRegistroD2);
  public
    destructor Destroy; override;
    function New: TRegistroD2;
    property Items[Index: Integer]: TRegistroD2 read GetItem write SetItem;
  end;

  /// REGISTRO TIPO D9 - TOTALIZAÇÃO DO ARQUIVO

  TRegistroD9 = class(TRegistroX9)
  end;

implementation

(* TRegistroD2List *)

destructor TRegistroD2List.Destroy;
var
intFor: integer;
begin
  for intFor := 0 to Count - 1 do Items[intFor].Free;
  inherited;
end;

function TRegistroD2List.GetItem(Index: Integer): TRegistroD2;
begin
  Result := TRegistroD2(inherited Items[Index]);
end;

function TRegistroD2List.New: TRegistroD2;
begin
  Result := TRegistroD2.Create;
  Add(Result);
end;

procedure TRegistroD2List.SetItem(Index: Integer; const Value: TRegistroD2);
begin
  Put(Index, Value);
end;

end.
