{******************************************************************************}
{ Projeto: Componentes ACBr                                                    }
{  Biblioteca multiplataforma de componentes Delphi para interação com equipa- }
{ mentos de Automação Comercial utilizados no Brasil                           }
{                                                                              }
{ Direitos Autorais Reservados (c) 2004 Daniel Simoes de Almeida               }
{                                                                              }
{ Colaboradores nesse arquivo:                                                 }
{                                                                              }
{  Você pode obter a última versão desse arquivo na pagina do  Projeto ACBr    }
{ Componentes localizado em      http://www.sourceforge.net/projects/acbr      }
{                                                                              }
{ Esse arquivo usa a classe  SynaSer   Copyright (c)2001-2003, Lukas Gebauer   }
{  Project : Ararat Synapse     (Found at URL: http://www.ararat.cz/synapse/)  }
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
|* 12/08/2010: Primeira Versao
|*    Régys Borges da Silveira
******************************************************************************}
unit ACBrSuframa;

{$I ACBr.inc}

interface

uses
  Classes, SysUtils, contnrs, ACBrUtil, ACBrSocket, ACBrValidador, ACBrNFeUtil
  {$IFDEF ACBrNFeOpenSSL}
    , HTTPSend
  {$ELSE}
    , SoapHTTPClient, SOAPHTTPTrans, SOAPConst, JwaWinCrypt, WinInet
  {$ENDIF}
  ;

type
  TACBrSuframa = class( TACBrHTTP )
  private
    fOnBuscaEfetuada: TNotifyEvent ;
    FCNPJ: AnsiString;
    FSuframa: AnsiString;
    FRespostaWS: AnsiString;
    FSituacao: Integer;
    FSituacaoDescr: string;

    {$IFDEF ACBrNFeOpenSSL}
       procedure ConfiguraHTTP( HTTP : THTTPSend; Action : AnsiString);
    {$ELSE}
       procedure ConfiguraReqResp( ReqResp : THTTPReqResp);
       procedure OnBeforePost(const HTTPReqResp: THTTPReqResp; Data: Pointer);
    {$ENDIF}

    function SituacaoToStr(const ASituacao: Integer): String;
    function GetParametrosConsulta: String;
    function LerTagXML(Texto, NomeCampo: string): string;
    function Executar: Boolean;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy ; override;
    procedure Validar;
  published
    property CNPJ: AnsiString read FCNPJ write FCNPJ;
    property Suframa: AnsiString read FSuframa write FSuframa;
    property RespostaWS: AnsiString read FRespostaWS;
    property Situacao: Integer read FSituacao;
    property SituacaoDescr: string read FSituacaoDescr;

    property OnBuscaEfetuada: TNotifyEvent read fOnBuscaEfetuada write fOnBuscaEfetuada;
  end;

implementation

{ TACBrSuframa }

constructor TACBrSuframa.Create(AOwner: TComponent);
begin
  inherited;

  FCNPJ       := '';
  FSuframa    := '';
  FRespostaWS := '';
  FSituacao   := 0;
  FSituacaoDescr := '';

  fOnBuscaEfetuada := nil;
end;

destructor TACBrSuframa.Destroy;
begin

  inherited;
end;

function TACBrSuframa.LerTagXML(Texto, NomeCampo: string): string;
var
  ConteudoTag: string;
  inicio, fim: integer;
begin
  NomeCampo := '<' + UpperCase(Trim(NomeCampo)) + '>';
  inicio    := pos(NomeCampo, UpperCase(Texto));

  if inicio = 0 then
    ConteudoTag := EmptyStr
  else
  begin
    inicio := inicio + Length(NomeCampo);
    Texto  := copy(Texto, inicio, length(Texto));
    inicio := 0;
    fim    := pos('</',Texto) - 1;

    ConteudoTag := Trim(copy(Texto, inicio, fim));
  end;

  try
    result := ConteudoTag;
  except
    raise Exception.Create('Conteúdo inválido. ' + ConteudoTag);
  end;
end;

function TACBrSuframa.SituacaoToStr(const ASituacao: Integer): String;
begin
  case ASituacao of
    0: Result := 'Ocorreu erro na conexão com o servidor';
    1: Result := 'Bloqueada';
    2: Result := 'Habilitada';
    3: Result := 'Dados não encontrados  (CNPJ ou a Inscrição Suframa estão incorretos ou não existem no sistema)';
  else
    Result := 'Descrição da situação ainda não implementada';
  end;
end;

{$IFDEF ACBrNFeOpenSSL}
procedure TACBrSuframa.ConfiguraHTTP( HTTP : THTTPSend; Action : AnsiString);
begin
  HTTP.ProxyHost := Self.ProxyHost;
  HTTP.ProxyPort := Self.ProxyPort;
  HTTP.ProxyUser := Self.ProxyUser;
  HTTP.ProxyPass := Self.ProxyPass;
  HTTP.MimeType  := 'application/soap+xml; charset=utf-8'
  HTTP.UserAgent := EmptyStr;
  HTTP.Protocol  := '1.1' ;
  HTTP.AddPortNumberToHost := False;
  HTTP.Headers.Add(Action);
end;
{$ELSE}
procedure TACBrSuframa.ConfiguraReqResp( ReqResp : THTTPReqResp);
begin
  if Trim(Self.ProxyHost) <> EmptyStr then
  begin
    ReqResp.Proxy    := Self.ProxyHost + ':' + Self.ProxyPort;
    ReqResp.UserName := Self.ProxyUser;
    ReqResp.Password := Self.ProxyPass;
  end;

  ReqResp.OnBeforePost := OnBeforePost;
end;

procedure TACBrSuframa.OnBeforePost(const HTTPReqResp: THTTPReqResp; Data: Pointer);
var
  ContentHeader: string;
begin
  if Trim(Self.ProxyUser) <> EmptyStr then
  begin
    if not InternetSetOption(Data, INTERNET_OPTION_PROXY_USERNAME, PChar(Self.ProxyUser), Length(Self.ProxyUser)) then
      raise Exception.Create( 'Erro OnBeforePost: ' + IntToStr(GetLastError) );
  end;

  if Trim(Self.ProxyPass) <> EmptyStr then
  begin
    if not InternetSetOption(Data, INTERNET_OPTION_PROXY_PASSWORD, PChar(Self.ProxyPass),Length (Self.ProxyPass)) then
      raise Exception.Create( 'Erro OnBeforePost: ' + IntToStr(GetLastError) );
  end;

  ContentHeader := Format(ContentTypeTemplate, ['application/soap+xml; charset=utf-8']);
  HttpAddRequestHeaders(Data, PChar(ContentHeader), Length(ContentHeader), HTTP_ADDREQ_FLAG_REPLACE);
  HTTPReqResp.CheckContentType;
end;
{$ENDIF}

function TACBrSuframa.GetParametrosConsulta: String;
begin
  if FCNPJ = '' then
  begin
    Result :=
      '<con:consultarSituacaoInscsuf soapenv:encodingStyle="http://schemas.xmlsoap.org/soap/encoding/">' +
        '<inscsuf>' + ACBrUtil.OnlyNumber( FSuframa ) + '</inscsuf>' +
      '</con:consultarSituacaoInscsuf>';
  end
  else
  begin
    Result :=
      '<con:consultarSituacaoInscCnpj soapenv:encodingStyle="http://schemas.xmlsoap.org/soap/encoding/">' +
        '<cnpj>' + ACBrUtil.OnlyNumber( FCNPJ ) + '</cnpj>' +
        '<inscsuf>' + ACBrUtil.OnlyNumber( FSuframa ) + '</inscsuf>' +
      '</con:consultarSituacaoInscCnpj>';
  end;
end;

function TACBrSuframa.Executar: Boolean;
var
  Acao: TStringList;
  Stream: TMemoryStream;
  StrStream: TStringStream;
  ErroCodigo, ErroMsg: String;
  Resposta: String;

  {$IFDEF ACBrNFeOpenSSL}
    HTTP: THTTPSend;
  {$ELSE}
    ReqResp: THTTPReqResp;
  {$ENDIF}
begin
  Result := False;
  FRespostaWS := '';
  FSituacao := 0;
  FSituacaoDescr := '';

  Acao := TStringList.Create;
  Stream := TMemoryStream.Create;
  StrStream := TStringStream.Create(EmptyStr);
  try
    Acao.Text :=
      '<?xml version="1.0" encoding="utf-8"?>' +
      '<soapenv:Envelope ' +
        'xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" ' +
        'xmlns:xsd="http://www.w3.org/2001/XMLSchema" ' +
        'xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" ' +
        'xmlns:con="http://consultas.ws.cadastro.fucapi.br">' +
        '<soapenv:Header/>' +
        '<soapenv:Body>' +
          GetParametrosConsulta +
        '</soapenv:Body>' +
      '</soapenv:Envelope>';

    try
      {$IFDEF ACBrNFeOpenSSL}
        HTTP := THTTPSend.Create;
      {$ELSE}
        ReqResp := THTTPReqResp.Create(nil);
      {$ENDIF}
      try
        {$IFDEF ACBrNFeOpenSSL}
          Acao.SaveToStream(Stream);
          HTTP.Document.LoadFromStream(Stream);
          ConfiguraHTTP(HTTP,'SOAPAction: "https://servicos.suframa.gov.br/cadastroWS/services/CadastroWebService"');

          HTTP.HTTPMethod('POST', 'https://servicos.suframa.gov.br/cadastroWS/services/CadastroWebService');
          StrStream.CopyFrom(HTTP.Document, 0);
          FRespostaWS := NotaUtil.ParseText( StrStream.DataString );
        {$ELSE}
          ConfiguraReqResp(ReqResp);
          ReqResp.UseUTF8InHeader := True;
          ReqResp.URL := 'https://servicos.suframa.gov.br/cadastroWS/services/CadastroWebService';
          ReqResp.SoapAction := 'consultarSituacaoInscsuf';

          ReqResp.Execute(Acao.Text, Stream);
          StrStream.CopyFrom(Stream, 0);
          FRespostaWS := NotaUtil.ParseText( AnsiString( StrStream.DataString ) );
        {$ENDIF}

        // verificar a resposta do webservice
        if FCNPJ <> '' then
          Resposta := String(NotaUtil.SeparaDados(FRespostaWS, 'ns1:consultarSituacaoInscCnpjReturn'))
        else
          Resposta := String(NotaUtil.SeparaDados(FRespostaWS, 'ns1:consultarSituacaoInscsufReturn'));

        if Resposta <> '' then
        begin
          FSituacao      := StrToInt(Resposta);
          FSituacaoDescr := SituacaoToStr(FSituacao);
        end
        else
        begin
          ErroCodigo := LerTagXML(String(FRespostaWS), 'faultcode');
          if ErroCodigo <> EmptyStr then
          begin
            ErroMsg := LerTagXML(String(FRespostaWS), 'faultstring');
            raise Exception.Create(ErroCodigo + sLineBreak + '  - ' + ErroMsg);
          end;
        end;

        Result := True;

        if Assigned(fOnBuscaEfetuada) then
          OnBuscaEfetuada( Self );
      finally
        {$IFDEF ACBrNFeOpenSSL}
          HTTP.Free;
        {$ELSE}
          ReqResp.Free;
        {$ENDIF}
      end;
    except
      on E: Exception do
      begin
        raise Exception.Create(
          'Ocorreu o seguinte erro ao consumir o webService Suframa:' + sLineBreak +
          '  - ' + E.Message
        );
      end;
    end;
  finally
    StrStream.Free;
    Stream.Free;
    Acao.Free;
  end;
end;

procedure TACBrSuframa.Validar;
var
  MsgErro: String;
begin
  MsgErro := ACBrValidadorValidarSuframa( AnsiString( ACBrUtil.OnlyNumber( FSuframa ) ) );
  if MsgErro <> '' then
    raise Exception.Create( 'Erro de validação: ' + sLineBreak + String( MsgErro ) );

  if FCNPJ <> '' then
  begin
    MsgErro := ACBrValidadorValidarCNPJ( FCNPJ );
    if MsgErro <> '' then
      raise Exception.Create( 'Erro de validação: ' + sLineBreak + String( MsgErro ) );
  end;

  Self.Executar;
end;

end.

