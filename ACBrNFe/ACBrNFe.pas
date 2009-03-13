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
unit ACBrNFe;

interface

uses
  Classes, Sysutils, 
  ACBrNFeConfiguracoes, ACBrNFeNotasFiscais,
  ACBrNFeWebServices, ACBrNFeUtil;

type

  TACBrNFe = class(TComponent)
  private
    FNotasFiscais: TNotasFiscais;
    FWebServices: TWebServices;
    FConfiguracoes: TConfiguracoes;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function Enviar(ALote: Integer): Boolean;
    function Cancelamento(AJustificativa:WideString): Boolean;
    function Consultar: Boolean;
    property WebServices: TWebServices read FWebServices write FWebServices;
    property NotasFiscais: TNotasFiscais read FNotasFiscais write FNotasFiscais;

  published
    property Configuracoes: TConfiguracoes read FConfiguracoes write FConfiguracoes;
  end;

var
  MyNFe : TACBrNFe;

implementation

{ TACBrNFe }

function TACBrNFe.Cancelamento(
  AJustificativa: WideString): Boolean;
var
  i : Integer;
begin
  if Self.NotasFiscais.Count = 0 then
    raise Exception.Create('Nenhuma Nota Fiscal Eletrônica Informada!');

  for i:= 0 to self.NotasFiscais.Count-1 do
    self.NotasFiscais.Items[i].XML.NFeChave := self.NotasFiscais.Items[i].XML.GetNFeChave;

  for i:= 0 to self.NotasFiscais.Count-1 do
  begin
    Self.WebServices.Consulta.NFeChave := self.NotasFiscais.Items[0].XML.NFeChave;
    WebServices.Cancela(AJustificativa);
  end;

  Result := true;
end;

function TACBrNFe.Consultar: Boolean;
var
  i : Integer;
begin
  if Self.NotasFiscais.Count = 0 then
    raise Exception.Create('Nenhuma Nota Fiscal Eletrônica Informada!');

  for i:= 0 to self.NotasFiscais.Count-1 do
    self.NotasFiscais.Items[i].XML.NFeChave := self.NotasFiscais.Items[i].XML.GetNFeChave;

  for i := 0 to Self.NotasFiscais.Count-1 do
  begin
    WebServices.Consulta.NFeChave := self.NotasFiscais.Items[0].XML.NFeChave;
    WebServices.Consulta.Executar;
  end;
  Result := True;

end;

constructor TACBrNFe.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  MyNFe              := Self;
  FConfiguracoes     := TConfiguracoes.Create;
  FNotasFiscais      := TNotasFiscais.Create(Self, NotaFiscal);
  FWebServices       := TWebServices.Create(Self);
  {$IFNDEF ACBrNFeCAPICOM}
     NotaUtil.InitXmlSec ;
  {$ENDIF}
end;

destructor TACBrNFe.Destroy;
begin
  FConfiguracoes.Free;
  FNotasFiscais.Free;
  FWebServices.Free;
  {$IFNDEF ACBrNFeCAPICOM}
     NotaUtil.ShutDownXmlSec ;
  {$ENDIF}   
  inherited;
end;

function TACBrNFe.Enviar(ALote: Integer): Boolean;
var
  i: Integer;
begin
  NotasFiscais.GerarNFe;
  NotasFiscais.Assinar;
  NotasFiscais.Valida;

  Result := WebServices.Envia(ALote);

  for i:= 0 to NotasFiscais.Count-1 do
  begin
    if NotasFiscais.Items[i].XML.Confirmada then
      NotasFiscais.Items[i].XML.Imprimir;
  end;
end;

end.
