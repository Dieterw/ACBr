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
unit ACBrNFeDadosAdicionais;

interface

uses
  Classes, SysUtils;

type

  Informacao = class(TCollectionItem)
  private
    FCampo: String;
    FTexto: String;
    procedure SetCampo(AValue: String);
    procedure SetTexto(AValue: String);
  published
    property Campo: String read FCampo write SetCampo;
    property Texto: String read FTexto write SetTexto;
  end;

  TInformacoes = class(TOwnedCollection)
  private
    function GetItem(Index: Integer): Informacao;
    procedure SetItem(Index: Integer; const Value: Informacao);
  public
    function  Add: Informacao;
    function Insert(Index: Integer): Informacao;
    property Items[Index: Integer]: Informacao read GetItem  write SetItem;
    function GetNamePath: string; override;
  end;

  TDadosAdicionais = class(TComponent)
  private
    FComplemento: String;
    FInformacoes: TInformacoes;
    procedure SetComplemento(AValue: String);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property Complemento: String read FComplemento write SetComplemento;
    property Informacoes: TInformacoes read FInformacoes write FInformacoes;
  end;

implementation

uses ACBrNFeUtil;

{ TInformacoes }

function TInformacoes.Add: Informacao;
begin
  if Self.Count > 10 then
    raise Exception.Create('Numero máximo de Informações atingido(10)!');
  Result := Informacao(inherited Add);
end;

function TInformacoes.GetItem(Index: Integer): Informacao;
begin
  Result := Informacao(inherited Items[Index]);
end;

function TInformacoes.GetNamePath: string;
begin
  Result := 'Informacao';
end;

function TInformacoes.Insert(Index: Integer): Informacao;
begin
  Result := Informacao(inherited Insert(Index));
end;

procedure TInformacoes.SetItem(Index: Integer; const Value: Informacao);
begin
  Items[Index].Assign(Value);
end;

{ TDadosAdicionais }

constructor TDadosAdicionais.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FInformacoes := TInformacoes.Create(self , Informacao);
end;

destructor TDadosAdicionais.Destroy;
begin
  FInformacoes.Free;
  inherited;
end;

procedure TDadosAdicionais.SetComplemento(AValue: String);
begin
  FComplemento := NotaUtil.TrataString(AValue);
end;

{ Informacao }

procedure Informacao.SetCampo(AValue: String);
begin
  FCampo := NotaUtil.TrataString(AValue, 20);
end;

procedure Informacao.SetTexto(AValue: String);
begin
  FTexto := NotaUtil.TrataString(AValue, 60);
end;

end.
