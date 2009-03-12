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
|* 09/03/2009: Dulcemar P. Zilli
|*  - Incluidas informações Referentes a DI
******************************************************************************}
unit ACBrNFeDI;

interface

uses
  Classes, ACBrNFeTypes,Controls;

type

  TADI = class(TCollectionItem)
  private
    FValorDesconto: Double;
    FNumeroAdicao: Integer;
    FCodigoFrabricante: String;
    procedure SetCodigoFrabricante(const Value: String);
    procedure SetNumeroAdicao(const Value: Integer);
    procedure SetValorDesconto(const Value: Double);
  public
    constructor Create;
    destructor Destroy; override;
  published
    property NumeroAdicao:Integer read FNumeroAdicao write SetNumeroAdicao;
    property CodigoFrabricante:String read FCodigoFrabricante write SetCodigoFrabricante;
    property ValorDesconto:Double read FValorDesconto write SetValorDesconto;
  end;

  TLADI = class(TCollection)
  protected
    function GetItem(Index: Integer): TADI;
    procedure SetItem(Index: Integer; const Value: TADI);
  public
    function  Add: TADI;
    function Insert(Index: Integer): TADI;
    property Items[Index: Integer]: TADI read GetItem  write SetItem;
    function GetNamePath: string; override;
  end;

  TDI = class(Tpersistent)
  private
    FDataRegistroDI: TDate;
    FDataDesembaraco: TDate;
    FLocalDesembaraco: String;
    FCodigoExportador: String;
    FNumeroDI: String;
    FUFDesembaraco: String;
    FLADI: TLADI;
    procedure SetCodigoExportador(const Value: String);
    procedure SetDataDesembaraco(const Value: TDate);
    procedure SetDataRegistroDI(const Value: TDate);
    procedure SetLocalDesembaraco(const Value: String);
    procedure SetNumeroDI(const Value: String);
    procedure SetUFDesembaraco(const Value: String);
    procedure SetLADI(const Value: TLADI);

  public
    constructor Create;
    destructor Destroy; override;
  published
    property NumeroDI:String read FNumeroDI write SetNumeroDI;
    property DataRegistroDI: TDate read FDataRegistroDI write SetDataRegistroDI;
    property LocalDesembaraco:String read FLocalDesembaraco write SetLocalDesembaraco;
    property UFDesembaraco:String read FUFDesembaraco write SetUFDesembaraco;
    property DataDesembaraco:TDate read FDataDesembaraco write SetDataDesembaraco;
    property CodigoExportador:String read FCodigoExportador write SetCodigoExportador;
    property LADI : TLADI read FLADI write SetLADI;
  end;


implementation

{ TDI }

constructor TDI.Create;
begin
  FLADI := TLADI.Create(TADI);

end;

destructor TDI.Destroy;
begin
  FLADI.Free;
  inherited;
end;

procedure TDI.SetLADI(const Value: TLADI);
begin
  FLADI := Value;
end;

procedure TDI.SetCodigoExportador(const Value: String);
begin
  FCodigoExportador := Value;
end;

procedure TDI.SetDataDesembaraco(const Value: TDate);
begin
  FDataDesembaraco := Value;
end;

procedure TDI.SetDataRegistroDI(const Value: TDate);
begin
  FDataRegistroDI := Value;
end;

procedure TDI.SetLocalDesembaraco(const Value: String);
begin
  FLocalDesembaraco := Value;
end;

procedure TDI.SetNumeroDI(const Value: String);
begin
  FNumeroDI := Value;
end;

procedure TDI.SetUFDesembaraco(const Value: String);
begin
  FUFDesembaraco := Value;
end;



{ TLADI }

function TLADI.Add: TADI;
begin
  Result := TADI(inherited Add);
end;

function TLADI.GetItem(Index: Integer): TADI;
begin
  Result := TADI(inherited Items[Index]);
end;

function TLADI.Insert(Index: Integer): TADI;
begin
  Result := TADI(inherited Insert(Index));
end;

procedure TLADI.SetItem(Index: Integer; const Value: TADI);
begin
  Items[Index].Assign(Value);
end;

function TLADI.GetNamePath: string;
begin
  Result := 'ADI';
end;


{ TADI }

constructor TADI.Create;
begin
  inherited Create(Collection);

end;

destructor TADI.Destroy;
begin

  inherited;
end;

procedure TADI.SetCodigoFrabricante(const Value: String);
begin
  FCodigoFrabricante := Value;
end;

procedure TADI.SetNumeroAdicao(const Value: Integer);
begin
  FNumeroAdicao := Value;
end;

procedure TADI.SetValorDesconto(const Value: Double);
begin
  FValorDesconto := Value;
end;

end.

