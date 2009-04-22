{******************************************************************************}
{ Projeto: Componentes ACBr                                                    }
{  Biblioteca multiplataforma de componentes Delphi para interação com equipa- }
{ mentos de Automação Comercial utilizados no Brasil                           }
{                                                                              }
{ Direitos Autorais Reservados (c) 2007 Andrews Ricardo Bejatto                }
{                                       Anderson Rogerio Bejatto               }
{                                                                              }
{ Colaboradores nesse arquivo:          Daniel Simooes de Almeida              }
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
|* 27/03/2007: Andrews R Bejatto/ Anderson R Bejatto/ Daniel Simões de Almeida
|*  - Primeira Versao ACBrETQClass
|* 17/04/2009: Alexsander da Rosa
|*  - Parametro "SubFonte" na procedure ImprimirTexto
******************************************************************************}

{$I ACBr.inc}

unit ACBrETQClass;

interface
uses ACBrDevice,
     Classes,
     {$IFDEF COMPILER6_UP} Types {$ELSE} Windows {$ENDIF} ;

const
   CRLF = #13 + #10;

type

{ Classe generica de ETIQUETA, nao implementa nenhum modelo especifico, apenas
  declara a Classe. NAO DEVE SER INSTANCIADA. Usada apenas como base para
  as demais Classes de BALANCA como por exemplo a classe TACBrETQPpla }

TACBrETQClass = class
  private
    FTemperatura: Integer;
    FAvanco: Integer;
    procedure SetAtivo(const Value: Boolean);
    procedure SetTemperatura(const Value: Integer);
    procedure SetAvanco(const Value: Integer);
  protected
    fpDevice  : TACBrDevice ;
    fpAtivo   : Boolean ;
    fpModeloStr: String;
    fpListaCmd: TStringList;
    fpCmd: String;
  public
    property Ativo  : Boolean read fpAtivo write SetAtivo;
    property ModeloStr: String read fpModeloStr;
    property ListaCmd: TStringList read fpListaCmd write fpListaCmd;
    property Cmd: String read fpCmd write fpCmd;
    property Temperatura: Integer read FTemperatura write SetTemperatura;
    property Avanco: Integer read FAvanco write SetAvanco;

    constructor Create(AOwner: TComponent);
    destructor Destroy  ; override ;

    procedure Ativar ; virtual ;
    procedure Desativar ; virtual ;

    procedure ImprimirTexto(Orientacao: TACBrETQOrientacao; Fonte: Integer;
      MultiplicadorH, MultiplicadorV: Char; Vertical, Horizontal: Integer;
      Texto: String; SubFonte: Integer = 0); virtual;
    procedure ImprimirBarras(Orientacao: TACBrETQOrientacao; TipoBarras,
      LarguraBarraLarga, LarguraBarraFina: Char; Vertical, Horizontal: Integer;
      Texto: String; AlturaCodBarras: Integer); virtual;
    procedure ImprimirLinha(Vertical, Horizontal, Largura, Altura: Integer); virtual;
    procedure ImprimirCaixa(Vertical, Horizontal, Largura, Altura,
      EspessuraVertical, EspessuraHorizontal: Integer); virtual;
    procedure Imprimir(Copias: Integer = 1; AvancoEtq: Integer = 0); virtual;
end;

implementation

Uses
  ACBrETQ,
  SysUtils;

{ TACBrBAETQClass }

constructor TACBrETQClass.Create(AOwner: TComponent);
begin
  if not (AOwner is TACBrETQ) then
     raise Exception.create('Essa Classe deve ser instanciada por TACBrETQ');

  { Criando ponteiro interno para as Propriedade SERIAL de ACBrETQ,
    para permitir as Classes Filhas o acesso a essas propriedades do Componente}

  fpDevice    := (AOwner as TACBrETQ).Device ;
  fpDevice.SetDefaultValues ;

  fpAtivo     := false ;
  fpModeloStr := 'Não Definida' ;
  fpListaCmd:= TStringList.Create;
  
  FAvanco      := 0;
  FTemperatura := 10 ;
end;

destructor TACBrETQClass.Destroy;
begin
  fpDevice := nil; { Apenas remove referencia (ponteiros internos) }
  FreeAndNil(fpListaCmd);

  inherited Destroy;
end;

procedure TACBrETQClass.SetAtivo(const Value: Boolean);
begin
  if Value then
     Ativar
  else
     Desativar ;
end;

procedure TACBrETQClass.Ativar;
begin
  if fpAtivo then exit ;

  if fpDevice.Porta <> '' then
     fpDevice.Ativar ;

  fpAtivo := true ;
end;

procedure TACBrETQClass.Desativar;
begin
  if not fpAtivo then exit ;

  if fpDevice.Porta <> '' then
     fpDevice.Desativar ;

  fpAtivo := false ;
end;

procedure TACBrETQClass.ImprimirBarras(Orientacao: TACBrETQOrientacao; TipoBarras,
  LarguraBarraLarga, LarguraBarraFina: Char; Vertical, Horizontal: Integer;
  Texto: String; AlturaCodBarras: Integer);
begin
  raise Exception.Create('Função ImprimirBarras não implementada em: ' + ModeloStr);
end;

procedure TACBrETQClass.ImprimirCaixa(Vertical, Horizontal, Largura,
  Altura, EspessuraVertical, EspessuraHorizontal: Integer);
begin
  raise Exception.Create('Função ImprimirCaixa não implementada em: ' + ModeloStr);
end;

procedure TACBrETQClass.ImprimirLinha(Vertical, Horizontal, Largura,
  Altura: Integer);
begin
  raise Exception.Create('Função ImprimirLinha não implementada em: ' + ModeloStr);
end;

procedure TACBrETQClass.ImprimirTexto(Orientacao: TACBrETQOrientacao; Fonte: Integer;
  MultiplicadorH, MultiplicadorV: Char; Vertical, Horizontal: Integer;
  Texto: String; SubFonte: Integer);
begin
  raise Exception.Create('Função ImprimirTexto não implementada em: ' + ModeloStr);
end;

procedure TACBrETQClass.SetTemperatura(const Value: Integer);
begin
  FTemperatura := Value;
end;

procedure TACBrETQClass.SetAvanco(const Value: Integer);
begin
  FAvanco := Value;
end;

procedure TACBrETQClass.Imprimir(Copias, AvancoEtq: Integer);
begin
  raise Exception.Create('Função Imprimir não implementada em: ' + ModeloStr);
end;

end.
