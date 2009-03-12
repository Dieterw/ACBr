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
unit ACBrNFeEndereco;

interface

uses
  Classes, Sysutils, ACBrNFeTypes;

type

  TTabela = Class(TPersistent)
  private
    FDescricao: String;
    FCodigo: Integer;
    procedure SetDescricao(AValue: String);
  public

  published
    property Descricao: String read FDescricao write SetDescricao;
    property Codigo: Integer read FCodigo write FCodigo;
  end;

  TEndereco = Class(TPersistent)
  private
    FPais : TTabela;
    FCidade : TTabela;
    FUF : String;
    FLogradouro : String;
    FComplemento : String;
    FNumero : String;
    FBairro : String;
    FCEP : String;
    FFone : String;
    procedure SetLogradouro(AValue: String);
    procedure SetComplemento(AValue: String);
    procedure SetNumero(AValue: String);
    procedure SetBairro(AValue: String);
    function GetNumero: String;
    procedure SetCEP(AValue: String);
    procedure SetFone(AValue: String);
    procedure SetUF(AValue: String);
    function GetUFCodigo: Integer;
  public
    constructor Create;
    destructor Destroy; override;

  published
    property Pais : TTabela read FPais write FPais;
    property Cidade : TTabela read FCidade write FCidade;
    property UF : String read FUF write SetUF;
    property UFCodigo : Integer read GetUFCodigo;
    property Logradouro : String read FLogradouro write SetLogradouro;
    property Complemento : String read FComplemento write SetComplemento;
    property Numero : String read GetNumero write SetNumero;
    property Bairro : String read FBairro write SetBairro;
    property CEP : String read FCEP write SetCEP;
    property Fone : String read FFone write SetFone;
  end;


implementation

uses ACBrNFeUtil, ACBrNFeConst;

{ TEndereco }

constructor TEndereco.Create;
begin
  FPais   := TTabela.Create;
  FCidade := TTabela.Create;

  FPais.Descricao := 'BRASIL';
  FPais.Codigo    := 1058;
  FNumero         := 'SN';
end;

destructor TEndereco.Destroy;
begin
  FPais.Free;
  FCidade.Free;
  inherited;
end;

function TEndereco.GetNumero: String;
begin
  if NotaUtil.EstaVazio(FNumero) then
    FNumero := 'SEM NUMERO';
  Result := FNumero;
end;

procedure TEndereco.SetCEP(AValue: String);
begin
  if NotaUtil.NaoEstaVazio(AValue) then
    FCEP := NotaUtil.Poem_Zeros(NotaUtil.LimpaNumero(AValue), 8);
end;

procedure TEndereco.SetNumero(AValue: String);
begin
  FNumero := NotaUtil.TrataString(AValue, 60);
end;

procedure TEndereco.SetLogradouro(AValue: String);
begin
  FLogradouro := NotaUtil.TrataString(AValue, 60);
end;

procedure TEndereco.SetBairro(AValue: String);
begin
  FBairro := NotaUtil.TrataString(AValue, 60);
end;

procedure TEndereco.SetComplemento(AValue: String);
begin
  FComplemento := NotaUtil.TrataString(AValue, 60);
end;

procedure TEndereco.SetFone(AValue: String);
begin
  FFone := NotaUtil.CortaE(NotaUtil.LimpaNumero(AValue), 10);
end;

procedure TEndereco.SetUF(AValue: String);
begin
  FUF := NotaUtil.TrataString(UpperCase(AValue), 2);
end;

function TEndereco.GetUFCodigo: Integer;
var
  i: Integer;
begin
  Result := 0;
  for i:= 0 to High(NFeUF) do
  begin
    if NFeUF[I] = FUF then
      Result := NFeUFCodigo[I];
  end;
end;

{ TTabela }

procedure TTabela.SetDescricao(AValue: String);
begin
  FDescricao := NotaUtil.TrataString(AValue, 60);
end;

end.
