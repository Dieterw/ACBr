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
{$I ACBr.inc}

unit ACBrNFeNotasFiscais;

interface

uses
  Classes, Sysutils,
  ACBrNFeUtil, ACBrNFeConfiguracoes,
  {$IFDEF FPC}
     ACBrNFeDMLaz,
  {$ELSE}
     ACBrNFeDANFEClass,  
  {$ENDIF}
  pcnNFe, pcnNFeR, pcnNFeW, pcnConversao;

type

  NotaFiscal = class(TCollectionItem)
  private
    FNFe: TNFe;
    FXML: AnsiString;
    FConfirmada : Boolean;
    FMsg : AnsiString ;
  public
    constructor Create(Collection2: TCollection); override;
    destructor Destroy; override;
    procedure Imprimir;
    procedure ImprimirPDF;    
  published
    property NFe: TNFe  read FNFe write FNFe;
    property XML: AnsiString  read FXML write FXML;
    property Confirmada: Boolean  read FConfirmada write FConfirmada;
    property Msg: AnsiString  read FMsg write FMsg;
  end;

  TNotasFiscais = class(TOwnedCollection)
  private
    FConfiguracoes : TConfiguracoes;
    FACBrNFe : TComponent ;

    function GetItem(Index: Integer): NotaFiscal;
    procedure SetItem(Index: Integer; const Value: NotaFiscal);
  public
    constructor Create(AOwner: TPersistent; ItemClass: TCollectionItemClass);

    procedure GerarNFe;
    procedure Assinar;
    procedure Valida;
    procedure Imprimir;
    procedure ImprimirPDF;
    function  Add: NotaFiscal;
    function Insert(Index: Integer): NotaFiscal;
    property Items[Index: Integer]: NotaFiscal read GetItem  write SetItem;
    property Configuracoes: TConfiguracoes read FConfiguracoes  write FConfiguracoes;

    function GetNamePath: string; override ;
    function LoadFromFile(CaminhoArquivo: string): boolean;

    property ACBrNFe : TComponent read FACBrNFe ;
  end;

implementation

uses ACBrNFe, pcnGerador;

{ NotaFiscal }

constructor NotaFiscal.Create(Collection2: TCollection);
begin
  inherited Create(Collection2);
  FNFe := TNFe.Create;

  FNFe.Ide.tpNF   := tnSaida;
  FNFe.Ide.modelo := 55;

  FNFe.Ide.tpNF      := tnSaida;
  FNFe.Ide.indPag    := ipVista;
  FNFe.Ide.verProc   := '1.0.0.0';
  FNFe.Ide.tpAmb     := TACBrNFe( TNotasFiscais( Collection ).ACBrNFe ).Configuracoes.WebServices.Ambiente  ;

  FNFe.Emit.EnderEmit.xPais := 'BRASIL';
  FNFe.Emit.EnderEmit.cPais := 1058;
  FNFe.Emit.EnderEmit.nro   := 'SEM NUMERO';

  FNFe.Dest.EnderDest.xPais := 'BRASIL';
  FNFe.Dest.EnderDest.cPais := 1058;
  FNFe.Dest.EnderDest.nro   := 'SEM NUMERO';
  
end;

destructor NotaFiscal.Destroy;
begin
  FNFe.Free;
  inherited Destroy;
end;

procedure NotaFiscal.Imprimir;
begin
  TACBrNFe( TNotasFiscais( Collection ).ACBrNFe ).DANFE.ImprimirDANFE(NFe);
end;

procedure NotaFiscal.ImprimirPDF;
begin
  TACBrNFe( TNotasFiscais( Collection ).ACBrNFe ).DANFE.ImprimirDANFEPDF(NFe);
end;

{ TNotasFiscais }
constructor TNotasFiscais.Create(AOwner: TPersistent;
  ItemClass: TCollectionItemClass);
begin
  if not (AOwner is TACBrNFe ) then
     raise Exception.Create( 'AOwner deve ser do tipo TACBrNFe') ;

  inherited;

  FACBrNFe := TACBrNFe( AOwner ) ;
end;


function TNotasFiscais.Add: NotaFiscal;
begin
  Result := NotaFiscal(inherited Add);

  Result.NFe.Ide.tpAmb := Configuracoes.WebServices.Ambiente ;
end;

procedure TNotasFiscais.Assinar;
var
  i: Integer;
  vAssinada : AnsiString;
  LocNFeW : TNFeW;
  FMsg : AnsiString;
begin
  for i:= 0 to Self.Count-1 do
   begin
     LocNFeW := TNFeW.Create(Self.Items[i].NFe);
     LocNFeW.schema := TsPL005c;
     LocNFeW.GerarXml;

{$IFDEF ACBrNFeOpenSSL}
     if not(NotaUtil.Assinar(LocNFeW.Gerador.ArquivoFormatoXML, FConfiguracoes.Certificados.Certificado , FConfiguracoes.Certificados.Senha, vAssinada, FMsg)) then
       raise Exception.Create('Falha ao assinar Nota Fiscal Eletrônica '+
                               IntToStr(Self.Items[i].NFe.Ide.cNF)+FMsg);
{$ELSE}
     if not(NotaUtil.Assinar(LocNFeW.Gerador.ArquivoFormatoXML, FConfiguracoes.Certificados.GetCertificado , vAssinada, FMsg)) then
       raise Exception.Create('Falha ao assinar Nota Fiscal Eletrônica '+
                               IntToStr(Self.Items[i].NFe.Ide.cNF)+FMsg);
{$ENDIF}
     vAssinada := StringReplace( vAssinada, '<'+ENCODING_UTF8_STD+'>', '', [rfReplaceAll] ) ;
     vAssinada := StringReplace( vAssinada, '<?xml version="1.0"?>', '', [rfReplaceAll] ) ;
     Self.Items[i].XML := vAssinada;
     if FConfiguracoes.Geral.Salvar then
        FConfiguracoes.Geral.Save(StringReplace(Self.Items[i].NFe.infNFe.ID, 'NFe', '', [rfIgnoreCase])+'-nfe.xml', vAssinada);

     LocNFeW.Free;
   end;

end;

procedure TNotasFiscais.GerarNFe;
var
 i: Integer;
 LocNFeW : TNFeW;
begin
 for i:= 0 to Self.Count-1 do
  begin
    LocNFeW := TNFeW.Create(Self.Items[i].NFe);
    LocNFeW.schema := TsPL005c;
//    LocNFeW.Gerador.Opcoes.GerarTagIPIparaNaoTributado := False;
    LocNFeW.GerarXml;
  end;
end;

function TNotasFiscais.GetItem(Index: Integer): NotaFiscal;
begin
  Result := NotaFiscal(inherited Items[Index]);
end;

function TNotasFiscais.GetNamePath: string;
begin
  Result := 'NotaFiscal';
end;

procedure TNotasFiscais.Imprimir;
begin
  TACBrNFe( FACBrNFe ).DANFE.ImprimirDANFE(nil);
end;

procedure TNotasFiscais.ImprimirPDF;
begin
  TACBrNFe( FACBrNFe ).DANFE.ImprimirDANFEPDF(nil);
end;

function TNotasFiscais.Insert(Index: Integer): NotaFiscal;
begin
  Result := NotaFiscal(inherited Insert(Index));
end;

procedure TNotasFiscais.SetItem(Index: Integer; const Value: NotaFiscal);
begin
  Items[Index].Assign(Value);
end;

procedure TNotasFiscais.Valida;
var
 i: Integer;
 FMsg : AnsiString;
begin
  for i:= 0 to Self.Count-1 do
   begin
     Assinar;
     if not(NotaUtil.Valida(Self.Items[i].XML, FMsg)) then
       raise Exception.Create('Falha na validação dos dados da nota '+
                               IntToStr(Self.Items[i].NFe.Ide.cNF)+FMsg);
  end;
end;

function TNotasFiscais.LoadFromFile(CaminhoArquivo: string): boolean;
var
 LocNFeR : TNFeR;
begin
 Result := True;
 try
    LocNFeR := TNFeR.Create(Self.Add.NFe);
    LocNFeR.Leitor.CarregarArquivo(CaminhoArquivo);
    LocNFeR.LerXml;
 except
    Result := False;
 end;
end;

end.
