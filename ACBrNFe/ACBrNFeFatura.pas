{******************************************************************************}
{ Projeto: Componente ACBrNFe                                                  }
{  Biblioteca multiplataforma de componentes Delphi para emissão de Nota Fiscal}
{ eletrônica - NFe - http://www.nfe.fazenda.gov.br                          }
{                                                                              }
{ Direitos Autorais Reservados (c) 2008 Wemerson Souto                         }
{                                       Daniel Simoes de Almeida               }
{                                       André Ferreira de Moraes               }
{                                                                              }
{ Colaboradores nesse arquivo:                                                 }
{                                                                              }
{  Você pode obter a última versão desse arquivo na pagina do Projeto ACBr     }
{ Componentes localizado em http://www.sourceforge.net/projects/acbr           }
{                                                                              }
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
|* 16/12/2008: Wemerson Souto
|*  - Doação do componente para o Projeto ACBr
******************************************************************************}
unit ACBrNFeFatura;

interface

uses
  Classes, ACBrNFeTypes;

type

  Duplicata = class(TCollectionItem)
  private
    FNumero: String;
    FDataVencimento: TDateTime;
    FValor: Double;
  published
    property Numero: String read FNumero write FNumero;
    property DataVencimento: TDateTime read FDataVencimento write FDataVencimento;
    property Valor: Double read FValor write FValor;
  end;

  TDuplicatas = class(TOwnedCollection)
  private
    function GetItem(Index: Integer): Duplicata;
    procedure SetItem(Index: Integer; const Value: Duplicata);
  public
    function  Add: Duplicata;
    function Insert(Index: Integer): Duplicata;
    property Items[Index: Integer]: Duplicata read GetItem  write SetItem;
    function GetNamePath: string; override;
  end;

  TFatura = class(TComponent)
  private
    FNumero: String;
    FValorOriginal: Double;
    FValorDesconto: Double;
    FValorLiquido: Double;
    FDuplicatas: TDuplicatas;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

  published
    property Numero: String read FNumero write FNumero;
    property ValorOriginal: Double read FValorOriginal write FValorOriginal;
    property ValorDesconto: Double read FValorDesconto write FValorDesconto;
    property ValorLiquido: Double read FValorLiquido write FValorLiquido;
    property Duplicatas: TDuplicatas read FDuplicatas write FDuplicatas;
  end;

implementation

{ TDuplicatas }

function TDuplicatas.Add: Duplicata;
begin
  Result := Duplicata(inherited Add);
end;

function TDuplicatas.GetItem(Index: Integer): Duplicata;
begin
  Result := Duplicata(inherited Items[Index]);
end;

function TDuplicatas.GetNamePath: string;
begin
  Result := 'Duplicata';
end;

function TDuplicatas.Insert(Index: Integer): Duplicata;
begin
  Result := Duplicata(inherited Insert(Index));
end;

procedure TDuplicatas.SetItem(Index: Integer; const Value: Duplicata);
begin
  Items[Index].Assign(Value);
end;

{ TFatura }

constructor TFatura.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FDuplicatas := TDuplicatas.Create(self , Duplicata);
end;

destructor TFatura.Destroy;
begin
  FDuplicatas.Free;
  inherited;
end;

end.
