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

unit ACBrNFeWebServices;

interface

uses Classes, SysUtils,
  {$IFDEF VCL} Dialogs, {$ELSE} QDialogs, {$ENDIF}
  {$IFNDEF ACBrNFeCAPICOM}
    HTTPSend,
  {$ELSE}
     SoapHTTPClient, SOAPHTTPTrans, JwaWinCrypt, WinInet, ACBrNFeCAPICOM_TLB,
  {$ENDIF}
  ACBrNFe_retConsReciNFe,
  ACBrNFeNotasFiscais, ACBrNFeTypes, ACBrNFeConfiguracoes ;

type

  TWebServicesBase = Class(TPersistent)
  private
    procedure DoNFeStatusServico;
    procedure DoNFeRecepcao;
    procedure DoNFeRetRecepcao;
    procedure DoNFeConsulta;
    procedure DoNFeCancelamento;
    procedure DoNFeInutilizacao;
    {$IFDEF ACBrNFeCAPICOM}
       procedure OnBeforePost(const HTTPReqResp: THTTPReqResp; Data:Pointer);    
    {$ELSE}
       procedure ConfiguraHTTP( HTTP : THTTPSend; Action : AnsiString);
    {$ENDIF}
  protected
    FCabMsg: WideString;
    FDadosMsg: WideString;
    FRetWS: WideString;
    FMsg: WideString;
    FURL: WideString;
    FConfiguracoes: TConfiguracoes;
    procedure LoadMsgEntrada;
    procedure LoadURL;
  public
    function Executar: Boolean;virtual;
    constructor Create(AConfiguracoes : TConfiguracoes);virtual;
  published
    property CabMsg: WideString read FCabMsg;
    property DadosMsg: WideString read FDadosMsg;
    property RetWS: WideString read FRetWS;
    property Msg: WideString read FMsg;
  end;

  TNFeStatusServico = Class(TWebServicesBase)
  private

  public
    function Executar: Boolean; override;
  published
  end;

  TNFeRecepcao = Class(TWebServicesBase)
  private
    FLote: Integer;
    FRecibo : String;
    FNotasFiscais : TNotasFiscais;
  public
    function Executar: Boolean; override;
    constructor Create(AConfiguracoes : TConfiguracoes; ANotasFiscais : TNotasFiscais);reintroduce;

    property Recibo: String read FRecibo;
  published
    property Lote: Integer read FLote write FLote;
  end;

  TNFeRetRecepcao = Class(TWebServicesBase)
  private
    FRecibo: String;
    FNotasFiscais : TNotasFiscais;
    FNFeRetorno: IXMLTRetConsReciNFe;
    function Confirma(AInfProt: IXMLTProtNFeList): Boolean;
  public
    function Executar: Boolean; override;
    constructor Create(AConfiguracoes : TConfiguracoes; ANotasFiscais : TNotasFiscais);reintroduce;
  published
    property Recibo: String read FRecibo write FRecibo;
  end;

  TNFeConsulta = Class(TWebServicesBase)
  private
    FNFeChave: WideString;
    FProtocolo: WideString;
  public
    function Executar: Boolean;override;
    property Protocolo: WideString read FProtocolo write FProtocolo;
  published
    property NFeChave: WideString read FNFeChave write FNFeChave;
  end;

  TNFeCancelamento = Class(TWebServicesBase)
  private
    FNFeChave: WideString;
    FProtocolo: WideString;
    FJustificativa: WideString;
    procedure SetJustificativa(AValue: WideString);
  public
    function Executar: Boolean;override;
  published
    property NFeChave: WideString read FNFeChave write FNFeChave;
    property Protocolo: WideString read FProtocolo write FProtocolo;
    property Justificativa: WideString read FJustificativa write SetJustificativa;
  end;

  TNFeInutilizacao = Class(TWebServicesBase)
  private
    FNFeChave: WideString;
    FModelo: Integer;
    FSerie: Integer;
    FCNPJ: String;
    FAno: Integer;
    FNumeroInicial: Integer;
    FNumeroFinal: Integer;
    FJustificativa: WideString;
    procedure SetJustificativa(AValue: WideString);
  public
    function Executar: Boolean;override;
  published
    property NFeChave: WideString read FNFeChave write FNFeChave;
    property Modelo: Integer read FModelo write FModelo;
    property Serie: Integer read FSerie write FSerie;
    property CNPJ: String read FCNPJ write FCNPJ;
    property Ano: Integer read FAno write FAno;
    property NumeroInicial: Integer read FNumeroInicial write FNumeroInicial;
    property NumeroFinal: Integer read FNumeroFinal write FNumeroFinal;
    property Justificativa: WideString read FJustificativa write SetJustificativa;
  end;

  TWebServices = Class(TWebServicesBase)
  private
    FStatusServico: TNFeStatusServico;
    FEnviar: TNFeRecepcao;
    FRetorno: TNFeRetRecepcao;
    FConsulta: TNFeConsulta;
    FCancelamento: TNFeCancelamento;
    FInutilizacao: TNFeInutilizacao;
  public
    constructor Create(AFNotaFiscalEletronica: TPersistent);reintroduce;
    destructor Destroy; override;
    function Envia(ALote: Integer): Boolean;
    procedure Cancela(AJustificativa: String);
    procedure Inutiliza(CNPJ, AJustificativa: String; Ano, Modelo, Serie, NumeroInicial, NumeroFinal : Integer);
  published
    property StatusServico: TNFeStatusServico read FStatusServico write FStatusServico;
    property Enviar: TNFeRecepcao read FEnviar write FEnviar;
    property Retorno: TNFeRetRecepcao read FRetorno write FRetorno;
    property Consulta: TNFeConsulta read FConsulta write FConsulta;
    property Cancelamento: TNFeCancelamento read FCancelamento write FCancelamento;
    property Inutilizacao: TNFeInutilizacao read FInutilizacao write FInutilizacao;
  end;

implementation

uses {$IFNDEF ACBrNFeCAPICOM}
        ssl_openssl,
     {$ELSE}
        ACBrNFeNfeStatusServicoU, ACBrNFeNfeRecepcaoU,
        ACBrNFeNfeRetRecepcaoU, ACBrNFeNfeConsultaU,
        ACBrNFeNfeCancelamentoU, ACBrNFeNfeInutilizacaoU,
     {$ENDIF}
     XMLIntf, XMLDoc, ACBrNFe_retConsStatServ, ACBrNFe_cabecMsg,
     ACBrNFe_consStatServ, ACBrNFe_enviNFe, ACBrNFe_retEnviNFe,
     ACBrNFe_consReciNFe, ACBrNFe_consSitNFe, ACBrNFe_retConsSitNFe,
     ACBrNFe_inutNFe, ACBrNFe_cancNFe, ACBrNFe_retCancNFe, ACBrNFe_retInutNFe,
     ACBrNFeUtil, ACBrNFeConst, ACBrNFeXML, ACBrNFe;

const
  INTERNET_OPTION_CLIENT_CERT_CONTEXT = 84;

{ TWebServicesBase }

constructor TWebServicesBase.Create(AConfiguracoes: TConfiguracoes);
begin
  FConfiguracoes := AConfiguracoes;
end;

{$IFDEF ACBrNFeCAPICOM}
procedure TWebServicesBase.OnBeforePost(const HTTPReqResp: THTTPReqResp;
  Data: Pointer);
var
  Cert         : ICertificate2;
  CertContext  : ICertContext;
  PCertContext : Pointer;
begin
  Cert := FConfiguracoes.Certificados.GetCertificado;
  CertContext :=  Cert as ICertContext;
  CertContext.Get_CertContext(Integer(PCertContext));

  if not InternetSetOption(Data, INTERNET_OPTION_CLIENT_CERT_CONTEXT, PCertContext, Sizeof(CERT_CONTEXT)) then
    ShowMessage( 'Erro OnBeforePost' );
end;

{$ELSE}
procedure TWebServicesBase.ConfiguraHTTP( HTTP : THTTPSend; Action : AnsiString);
begin
  HTTP.Sock.SSL.PFXfile     := FConfiguracoes.Certificados.Certificado;
  HTTP.Sock.SSL.KeyPassword := FConfiguracoes.Certificados.Senha;

  HTTP.Sock.RaiseExcept := True;

  HTTP.MimeType := 'text/xml; charset=utf-8';
  HTTP.UserAgent := '';
  HTTP.Protocol := '1.1' ;
  HTTP.AddPortNumberToHost := False;
  HTTP.Headers.Add(Action);
end;
{$ENDIF}

procedure TWebServicesBase.DoNFeCancelamento;
var
  vCabecalho: IXMLCabecMsg;
  vDados: IXMLTCancNFe;
  XmlDoc: IXMLDocument;
begin
  vCabecalho             := NewcabecMsg;
  vCabecalho.Versao      := NFecabMsg;
  vCabecalho.VersaoDados := NFecancNFe;
  XmlDoc := LoadXMLData(vCabecalho.XML);
  XmlDoc.Encoding   := 'UTF-8';
  XmlDoc.StandAlone := 'no';
  FCabMsg := XmlDoc.XML.Text;

  vDados := NewcancNFe;
  vDados.Versao        := NFecancNFe;
  vDados.InfCanc.Id    := 'ID'+TNFeCancelamento(Self).NFeChave;
  vDados.InfCanc.TpAmb := IntToStr(FConfiguracoes.WebServices.AmbienteCodigo);
  vDados.InfCanc.XServ := 'CANCELAR';
  vDados.InfCanc.ChNFe := TNFeCancelamento(Self).NFeChave;
  vDados.InfCanc.NProt := TNFeCancelamento(Self).Protocolo;
  vDados.InfCanc.XJust := TNFeCancelamento(Self).Justificativa;
  XmlDoc := LoadXMLData(vDados.XML);
  XmlDoc.Encoding   := 'UTF-8';
//  XmlDoc.StandAlone := 'no';

{$IFDEF ACBrNFeCAPICOM}
  if not(NotaUtil.Assinar(XmlDoc.XML.Text, TConfiguracoes(FConfiguracoes).Certificados.GetCertificado , FDadosMsg, FMsg)) then
    raise Exception.Create('Falha ao assinar Cancelamento de Nota Fiscal Eletrônica '+LineBreak+FMsg);
{$ELSE}
  if not(NotaUtil.Assinar(XmlDoc.XML.Text, TConfiguracoes(FConfiguracoes).Certificados.Certificado , TConfiguracoes(FConfiguracoes).Certificados.Senha, FDadosMsg, FMsg)) then
    raise Exception.Create('Falha ao assinar Cancelamento Nota Fiscal Eletrônica '+LineBreak+FMsg);
{$ENDIF}

  if not(NotaUtil.Valida(FDadosMsg, FMsg)) then
    raise Exception.Create('Falha na validação dos dados da nota '+LineBreak+FMsg);

end;

procedure TWebServicesBase.DoNFeConsulta;
var
  vCabecalho: IXMLCabecMsg;
  vDados: IXMLTConsSitNFe;
  XmlDoc: IXMLDocument;
begin
  vCabecalho             := NewcabecMsg;
  vCabecalho.Versao      := NFecabMsg;
  vCabecalho.VersaoDados := NFeconsSitNFe;
  XmlDoc := LoadXMLData(vCabecalho.XML);
  XmlDoc.Encoding   := 'UTF-8';
  XmlDoc.StandAlone := 'no';
  FCabMsg := XmlDoc.XML.Text;

  vDados        := NewconsSitNFe;
  vDados.Versao := NFeconsSitNFe;
  vDados.TpAmb  := IntToStr(FConfiguracoes.WebServices.AmbienteCodigo);
  vDados.XServ  := 'CONSULTAR';
  vDados.ChNFe  := TNFeConsulta(Self).NFeChave;
  XmlDoc := LoadXMLData(vDados.XML);
  XmlDoc.Encoding   := 'UTF-8';
  XmlDoc.StandAlone := 'no';
  FDadosMsg := XmlDoc.XML.Text;
end;

procedure TWebServicesBase.DoNFeInutilizacao;
var
  vCabecalho: IXMLCabecMsg;
  vDados: IXMLTInutNFe;
  XmlDoc: IXMLDocument;
begin
  vCabecalho             := NewcabecMsg;
  vCabecalho.Versao      := NFecabMsg;
  vCabecalho.VersaoDados := NFeinutNFe;
  XmlDoc := LoadXMLData(vCabecalho.XML);
  XmlDoc.Encoding   := 'UTF-8';
  XmlDoc.StandAlone := 'no';
  FCabMsg := XmlDoc.XML.Text;

  vDados := NewinutNFe;
  vDados.Versao        := NFeinutNFe;
  vDados.InfInut.Id    := TNFeInutilizacao(Self).NFeChave;
  vDados.InfInut.TpAmb := IntToStr(FConfiguracoes.WebServices.AmbienteCodigo);
  vDados.InfInut.XServ := 'INUTILIZAR';
  vDados.InfInut.CUF   := IntToStr(FConfiguracoes.WebServices.UFCodigo);
  vDados.InfInut.Ano   := NotaUtil.Poem_Zeros(TNFeInutilizacao(Self).Ano,2);
  vDados.InfInut.CNPJ  := TNFeInutilizacao(Self).CNPJ;
  vDados.InfInut.Mod_  := IntToStr(TNFeInutilizacao(Self).Modelo);
  vDados.InfInut.Serie := IntToStr(TNFeInutilizacao(Self).Serie);
  vDados.InfInut.NNFIni := IntToStr(TNFeInutilizacao(Self).NumeroInicial);
  vDados.InfInut.NNFFin := IntToStr(TNFeInutilizacao(Self).NumeroFinal);
  vDados.InfInut.XJust := TNFeInutilizacao(Self).Justificativa;
  XmlDoc := LoadXMLData(vDados.XML);
  XmlDoc.Encoding   := 'UTF-8';
  XmlDoc.StandAlone := 'no';

{$IFDEF ACBrNFeCAPICOM}
  if not(NotaUtil.Assinar(XmlDoc.XML.Text, TConfiguracoes(FConfiguracoes).Certificados.GetCertificado , FDadosMsg, FMsg)) then
    raise Exception.Create('Falha ao assinar Inutilização Nota Fiscal Eletrônica '+LineBreak+FMsg);
{$ELSE}
  if not(NotaUtil.Assinar(XmlDoc.XML.Text, TConfiguracoes(FConfiguracoes).Certificados.Certificado , TConfiguracoes(FConfiguracoes).Certificados.Senha, FDadosMsg, FMsg)) then
    raise Exception.Create('Falha ao assinar Inutilização Nota Fiscal Eletrônica '+LineBreak+FMsg);
{$ENDIF}
end;

procedure TWebServicesBase.DoNFeRecepcao;
var
  vCabecalho: IXMLCabecMsg;
  XmlDoc: IXMLDocument;
  i: Integer;
  vNotas: WideString;
begin
  vCabecalho             := NewcabecMsg;
  vCabecalho.Versao      := NFecabMsg;
  vCabecalho.VersaoDados := NFenviNFe;
  XmlDoc := LoadXMLData(vCabecalho.XML);
  XmlDoc.Encoding   := 'UTF-8';
  XmlDoc.StandAlone := 'no';
  FCabMsg := XmlDoc.XML.Text;

  vNotas := '';
  for i := 0 to TNFeRecepcao(Self).FNotasFiscais.Count-1 do
    vNotas := vNotas + TNFeRecepcao(Self).FNotasFiscais.Items[I].XML.NFe.XML;

  XmlDoc := LoadXMLData('<enviNFe xmlns="http://www.portalfiscal.inf.br/nfe" versao="'+NFenviNFe+'">'+
                        '<idLote>'+IntToStr(TNFeRecepcao(Self).Lote)+'</idLote>'+vNotas+'</enviNFe>');

  XmlDoc.Encoding   := 'UTF-8';
  XmlDoc.StandAlone := 'no';
  FDadosMsg := XmlDoc.XML.Text;
end;

procedure TWebServicesBase.DoNFeRetRecepcao;
var
  vCabecalho: IXMLCabecMsg;
  vDados: IXMLTConsReciNFe;
  XmlDoc: IXMLDocument;
begin
  vCabecalho             := NewcabecMsg;
  vCabecalho.Versao      := NFecabMsg;
  vCabecalho.VersaoDados := NFeconsReciNFe;
  XmlDoc := LoadXMLData(vCabecalho.XML);
  XmlDoc.Encoding   := 'UTF-8';
  XmlDoc.StandAlone := 'no';
  FCabMsg := XmlDoc.XML.Text;

  vDados        := NewconsReciNFe;
  vDados.Versao := NFeconsReciNFe;
  vDados.TpAmb  := IntToStr(FConfiguracoes.WebServices.AmbienteCodigo);
  vDados.NRec   := TNFeRetRecepcao(Self).Recibo;
  XmlDoc := LoadXMLData(vDados.XML);
  XmlDoc.Encoding   := 'UTF-8';
  XmlDoc.StandAlone := 'no';
  FDadosMsg := XmlDoc.XML.Text;
end;

procedure TWebServicesBase.DoNFeStatusServico;
var
  vCabecalho: IXMLCabecMsg;
  vDados: IXMLTConsStatServ;
  XmlDoc: IXMLDocument;
begin
  vCabecalho             := NewcabecMsg;
  vCabecalho.Versao      := NFecabMsg;
  vCabecalho.VersaoDados := NFeconsStatServ;
  XmlDoc := LoadXMLData(vCabecalho.XML);
  XmlDoc.Encoding   := 'UTF-8';
  XmlDoc.StandAlone := 'no';
  FCabMsg := XmlDoc.XML.Text;

  vDados        := NewconsStatServ;
  vDados.Versao := NFeconsStatServ;
  vDados.TpAmb  := IntToStr(FConfiguracoes.WebServices.AmbienteCodigo);
  vDados.CUF    := IntToStr(FConfiguracoes.WebServices.UFCodigo);
  vDados.XServ  := 'STATUS';
  XmlDoc := LoadXMLData(vDados.XML);
  XmlDoc.Encoding   := 'UTF-8';
  XmlDoc.StandAlone := 'no';
  FDadosMsg := XmlDoc.XML.Text;
end;

function TWebServicesBase.Executar: Boolean;
begin
  Result := False;
  LoadMsgEntrada;
  LoadURL;
end;

procedure TWebServicesBase.LoadMsgEntrada;
begin
  if self is TNFeStatusServico then
    DoNFeStatusServico
  else if self is TNFeRecepcao then
    DoNFeRecepcao
  else if self is TNFeRetRecepcao then
    DoNFeRetRecepcao
  else if self is TNFeConsulta then
    DONFeConsulta
  else if self is TNFeCancelamento then
    DONFeCancelamento
  else if self is TNFeInutilizacao then
    DoNFeInutilizacao
end;

procedure TWebServicesBase.LoadURL;
begin
  if self is TNFeStatusServico then
    FURL  := NotaUtil.GetURL(FConfiguracoes.WebServices.UFCodigo, FConfiguracoes.WebServices.AmbienteCodigo, LayNfeStatusServico)
  else if self is TNFeRecepcao then
    FURL  := NotaUtil.GetURL(FConfiguracoes.WebServices.UFCodigo, FConfiguracoes.WebServices.AmbienteCodigo, LayNfeRecepcao)
  else if self is TNFeRetRecepcao then
    FURL  := NotaUtil.GetURL(FConfiguracoes.WebServices.UFCodigo, FConfiguracoes.WebServices.AmbienteCodigo, LayNfeRetRecepcao)
  else if self is TNFeConsulta then
    FURL  := NotaUtil.GetURL(FConfiguracoes.WebServices.UFCodigo, FConfiguracoes.WebServices.AmbienteCodigo, LayNfeConsulta)
  else if self is TNFeCancelamento then
    FURL  := NotaUtil.GetURL(FConfiguracoes.WebServices.UFCodigo, FConfiguracoes.WebServices.AmbienteCodigo, LayNfeCancelamento)
  else if self is TNFeInutilizacao then
    FURL  := NotaUtil.GetURL(FConfiguracoes.WebServices.UFCodigo, FConfiguracoes.WebServices.AmbienteCodigo, LayNfeInutilizacao)
end;

{ TWebServices }

procedure TWebServices.Cancela(AJustificativa: String);
begin
  if not(Self.StatusServico.Executar) then
    raise Exception.Create(Self.StatusServico.Msg);

  if not(Self.Consulta.Executar) then
    raise Exception.Create(Self.Consulta.Msg);

  Self.Cancelamento.NFeChave      := Self.Consulta.FNFeChave;
  Self.Cancelamento.Protocolo     := Self.Consulta.FProtocolo;
  Self.Cancelamento.Justificativa := AJustificativa;
  if not(Self.Cancelamento.Executar) then
    raise Exception.Create(Self.Cancelamento.Msg);
end;

procedure TWebServices.Inutiliza(CNPJ, AJustificativa: String; Ano, Modelo, Serie, NumeroInicial, NumeroFinal : Integer);
begin
  if not(Self.StatusServico.Executar) then
    raise Exception.Create(Self.StatusServico.Msg);

  Self.Inutilizacao.NFeChave      := 'ID';
  Self.Inutilizacao.CNPJ   := CNPJ;
  Self.Inutilizacao.Modelo := Modelo;
  Self.Inutilizacao.Serie  := Serie;
  Self.Inutilizacao.Ano    := Ano;
  Self.Inutilizacao.NumeroInicial := NumeroInicial;
  Self.Inutilizacao.NumeroFinal   := NumeroFinal;
  Self.Inutilizacao.Justificativa := AJustificativa;

  if not(Self.Inutilizacao.Executar) then
    raise Exception.Create(Self.Inutilizacao.Msg);
end;

constructor TWebServices.Create(AFNotaFiscalEletronica: TPersistent);
begin
 inherited Create(TACBrNFe(AFNotaFiscalEletronica).Configuracoes);
  FStatusServico    := TNFeStatusServico.Create(Self.FConfiguracoes);
  FEnviar           := TNFeRecepcao.Create(Self.FConfiguracoes, TACBrNFe(AFNotaFiscalEletronica).NotasFiscais);
  FRetorno          := TNFeRetRecepcao.Create(Self.FConfiguracoes, TACBrNFe(AFNotaFiscalEletronica).NotasFiscais);
  FConsulta         := TNFeConsulta.Create(Self.FConfiguracoes);
  FCancelamento     := TNFeCancelamento.Create(Self.FConfiguracoes);
  FInutilizacao     := TNFeInutilizacao.Create(Self.FConfiguracoes);
end;

destructor TWebServices.Destroy;
begin
  FStatusServico.Free;
  FEnviar.Free;
  FRetorno.Free;
  FConsulta.Free;
  FCancelamento.Free;
  FInutilizacao.Free;
  inherited;
end;

function TWebServices.Envia(ALote: Integer): Boolean;
begin
  if not(Self.StatusServico.Executar) then
    raise Exception.Create(Self.StatusServico.Msg);

  self.Enviar.FLote := ALote;
  if not(Self.Enviar.Executar) then
    raise Exception.Create(Self.Enviar.Msg);

  Self.Retorno.Recibo := Self.Enviar.Recibo;
  if not(Self.Retorno.Executar) then
    raise Exception.Create(Self.Retorno.Msg);
  Result := true;
end;

{ TNFeStatusServico }

function TNFeStatusServico.Executar: Boolean;
var
  NFeRetorno: IXMLTRetConsStatServ;
  XmlDoc: IXMLDocument;

  {$IFDEF ACBrNFeCAPICOM}
     Nota: NfeStatusServico;
     Rio: THTTPRIO;
  {$ELSE}
     Texto : String;
     Acao  : TStringList ;
     Stream: TMemoryStream;
     StrStream: TStringStream;
     HTTP: THTTPSend;
  {$ENDIF}   
begin
  Result := inherited Executar;

  {$IFDEF ACBrNFeCAPICOM}
     Rio := THTTPRIO.Create(nil);
     Rio.HTTPWebNode.OnBeforePost := OnBeforePost;
  {$ELSE}
     Acao := TStringList.Create;
     Stream := TMemoryStream.Create;
     Texto := '<?xml version="1.0" encoding="utf-8"?>';
     Texto := Texto + '<soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">';
     Texto := Texto +   '<soap:Body>';
     Texto := Texto + '    <nfeStatusServicoNF xmlns="http://www.portalfiscal.inf.br/nfe/wsdl/NfeStatusServico">';
     Texto := Texto + '      <nfeCabecMsg>';

     Texto := Texto + NotaUtil.ParseText(FCabMsg,False);

     Texto := Texto + '      </nfeCabecMsg>';
     Texto := Texto + '      <nfeDadosMsg>';

     Texto := Texto + NotaUtil.ParseText(FDadosMsg,False);

     Texto := Texto + '      </nfeDadosMsg>';
     Texto := Texto + '    </nfeStatusServicoNF>';
     Texto := Texto + '  </soap:Body>';
     Texto := Texto + '</soap:Envelope>';
     Acao.Text := Texto;

     Acao.SaveToStream(Stream);

     HTTP := THTTPSend.Create;
  {$ENDIF}

  try
    if FConfiguracoes.Geral.Salvar then
      FConfiguracoes.Geral.Save(FormatDateTime('yyyymmddhhnnss',Now)+'-ped-sta.xml', FDadosMsg);

    try
      {$IFDEF ACBrNFeCAPICOM}
         Nota   := GetNfeStatusServico( False, FURL, Rio);
         FRetWS := Nota.nfeStatusServicoNF(FCabMsg, FDadosMsg);
      {$ELSE}
         HTTP.Document.LoadFromStream(Stream);
         ConfiguraHTTP(HTTP,'SOAPAction: "http://www.portalfiscal.inf.br/nfe/wsdl/NfeStatusServico/nfeStatusServicoNF"');
         HTTP.HTTPMethod('POST', FURL);
         StrStream := TStringStream.Create('');
         StrStream.CopyFrom(HTTP.Document, 0);

         FRetWS := NotaUtil.SeparaDados( NotaUtil.ParseText(StrStream.DataString, True),'nfeStatusServicoNFResult');
         StrStream.Free;
      {$ENDIF}
      XmlDoc     := LoadXMLData(FRetWS);
      NFeRetorno := GetretConsStatServ(XmlDoc);

      if FConfiguracoes.WebServices.Visualizar then
      begin
        ShowMessage('Versão Leiaute : '+NFeRetorno.Versao+LineBreak+
                    'Ambiente : '+NotaUtil.SeSenao(NFeRetorno.TpAmb='1', 'Produção', 'Teste')+LineBreak+
                    'Versão Aplicativo : '+NFeRetorno.VerAplic+LineBreak+
                    'Status Código : '+NFeRetorno.CStat+LineBreak+
                    'Status Descrição : '+NFeRetorno.XMotivo+LineBreak+
                    'UF : '+NotaUtil.CodigoToUF(NFeRetorno.CUF)+LineBreak+
                    'Recebimento : '+NFeRetorno.DhRecbto+LineBreak+
                    'Tempo Médio : '+NFeRetorno.TMed+LineBreak+
                    'Retorno : '+NFeRetorno.DhRetorno+LineBreak+
                    'Observação : '+NFeRetorno.XObs);
      end;

      FMsg   := NFeRetorno.XMotivo+ LineBreak+NFeRetorno.XObs;
      Result := (NFeRetorno.CStat = '107');

      if FConfiguracoes.Geral.Salvar then
        FConfiguracoes.Geral.Save(FormatDateTime('yyyymmddhhnnss',Now)+'-sta.xml', FRetWS);

    except on E: Exception do
      begin
        raise Exception.Create('WebService Consulta Status serviço:'+LineBreak+
                               '- Inativo ou Inoperante tente novamente.'+LineBreak+
                               '- '+E.Message);
      end;
    end;
  finally
    {$IFDEF ACBrNFeCAPICOM}
//       Rio.Free;
    {$ELSE}
       HTTP.Free;
       Acao.Free;
       Stream.Free;
    {$ENDIF}
    NotaUtil.ConfAmbiente;
  end;
end;

{ TNFeRecepcao }

constructor TNFeRecepcao.Create(AConfiguracoes: TConfiguracoes;
  ANotasFiscais: TNotasFiscais);
begin
  inherited Create(AConfiguracoes);
  FNotasFiscais := ANotasFiscais;
end;

function TNFeRecepcao.Executar: Boolean;
var
  NFeRetorno: IXMLTRetEnviNFe;
  XmlDoc: IXMLDocument;
  {$IFDEF ACBrNFeCAPICOM}
     Nota: NfeRecepcao;
     Rio: THTTPRIO;
  {$ELSE}
     Texto : String;
     Acao  : TStringList ;
     Stream: TMemoryStream;
     StrStream: TStringStream;
     HTTP: THTTPSend;
  {$ENDIF}
begin
  Result := inherited Executar;
  {$IFDEF ACBrNFeCAPICOM}
     Rio := THTTPRIO.Create(nil);
     Rio.HTTPWebNode.OnBeforePost := OnBeforePost;
  {$ELSE}
     Acao := TStringList.Create;
     Stream := TMemoryStream.Create;
     Texto := '<?xml version="1.0" encoding="utf-8"?>';
     Texto := Texto + '<soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">';
     Texto := Texto + '  <soap:Body>';
     Texto := Texto + '    <nfeRecepcaoLote xmlns="http://www.portalfiscal.inf.br/nfe/wsdl/NfeRecepcao">';
     Texto := Texto + '      <nfeCabecMsg>';

     Texto := Texto + NotaUtil.ParseText(FCabMsg,False);

     Texto := Texto + '      </nfeCabecMsg>';
     Texto := Texto + '      <nfeDadosMsg>';

     Texto := Texto + NotaUtil.ParseText(FDadosMsg,False);

     Texto := Texto + '      </nfeDadosMsg>';
     Texto := Texto + '    </nfeRecepcaoLote>';
     Texto := Texto + '  </soap:Body>';
     Texto := Texto + '</soap:Envelope>';
     Acao.Text := Texto;

     Acao.SaveToStream(Stream);

     HTTP := THTTPSend.Create;
  {$ENDIF}
  try
    if FConfiguracoes.Geral.Salvar then
      FConfiguracoes.Geral.Save(IntToStr(Lote)+'-env-lot.xml', FDadosMsg);
    {$IFDEF ACBrNFeCAPICOM}
       Nota   := GetNfeRecepcao( False, FURL, Rio);
       FRetWS := Nota.nfeRecepcaoLote(FCabMsg, FDadosMsg);
    {$ELSE}
       HTTP.Document.LoadFromStream(Stream);
       ConfiguraHTTP(HTTP,'SOAPAction: "http://www.portalfiscal.inf.br/nfe/wsdl/NfeRecepcao/nfeRecepcaoLote"');
       HTTP.HTTPMethod('POST', FURL);

       StrStream := TStringStream.Create('');
       StrStream.CopyFrom(HTTP.Document, 0);
       FRetWS := NotaUtil.SeparaDados( NotaUtil.ParseText(StrStream.DataString, True),'nfeRecepcaoLoteResult');
       StrStream.Free;
    {$ENDIF}
    XmlDoc     := LoadXMLData(FRetWS);
    NFeRetorno := GetretEnviNFe(XmlDoc);

    if FConfiguracoes.WebServices.Visualizar then
    begin
      ShowMessage('Versão Leiaute : '+NFeRetorno.Versao+LineBreak+
                  'Ambiente : '+NotaUtil.SeSenao(NFeRetorno.TpAmb='1', 'Produção', 'Teste')+LineBreak+
                  'Versão Aplicativo : '+NFeRetorno.VerAplic+LineBreak+
                  'Status Código : '+NFeRetorno.CStat+LineBreak+
                  'Status Descrição : '+NFeRetorno.XMotivo+LineBreak+
                  'UF : '+NFeRetorno.CUF+LineBreak+
                  'Recibo : '+NFeRetorno.InfRec.NRec+LineBreak+
                  'Recebimento : '+NFeRetorno.InfRec.DhRecbto+LineBreak+
                  'Tempo Médio : '+NFeRetorno.InfRec.TMed+LineBreak);
    end;
    FMsg    := NFeRetorno.XMotivo;
    FRecibo := NFeRetorno.InfRec.NRec;
    Result := (NFeRetorno.CStat = '103');

    if FConfiguracoes.Geral.Salvar then
      FConfiguracoes.Geral.Save(IntToStr(Lote)+'-rec.xml', FRetWS);

  finally
    {$IFDEF ACBrNFeCAPICOM}
//       Rio.Free;
    {$ELSE}
       HTTP.Free;
       Acao.Free;
       Stream.Free;
    {$ENDIF}
    NotaUtil.ConfAmbiente;
  end;
end;

{ TNFeRetRecepcao }

function TNFeRetRecepcao.Confirma(AInfProt: IXMLTProtNFeList): Boolean;
var
  i,j : Integer;
begin
  Result := False;

  //Setando os retornos das notas fiscais;
  for i:= 0 to AInfProt.Count-1 do
  begin
    for j:= 0 to FNotasFiscais.Count-1 do
    begin
      if 'NFe'+AInfProt.Items[i].InfProt.ChNFe = FNotasFiscais.Items[j].XML.NFe.InfNFe.Id then
      begin
        FNotasFiscais.Items[j].XML.Confirmada := (AInfProt.Items[i].InfProt.CStat = '100');
        FNotasFiscais.Items[j].XML.Msg        := AInfProt.Items[i].InfProt.xMotivo;
        break;
      end;
    end;
  end;

  //Verificando se existe alguma nota confirmada
  for i:= 0 to FNotasFiscais.Count-1 do
  begin
    if FNotasFiscais.Items[i].XML.Confirmada then
    begin
      Result := True;
      break;
    end;
  end;

  //Verificando se existe alguma nota nao confirmada
  for i:= 0 to FNotasFiscais.Count-1 do
  begin
    if not(FNotasFiscais.Items[i].XML.Confirmada) then
    begin
      FMsg   := 'Nota(s) não confirmadas:'+LineBreak;
      break;
    end;
  end;

  //Montando a mensagem de retorno para as notas nao confirmadas
  for i:= 0 to FNotasFiscais.Count-1 do
  begin
    if not(FNotasFiscais.Items[i].XML.Confirmada) then
      FMsg:= FMsg+IntToStr(FNotasFiscais.Items[i].Identificacao.Codigo)+'->'+FNotasFiscais.Items[i].XML.Msg+LineBreak;
  end;
end;

constructor TNFeRetRecepcao.Create(AConfiguracoes: TConfiguracoes;
  ANotasFiscais: TNotasFiscais);
begin
  inherited Create(AConfiguracoes);
  FNotasFiscais := ANotasFiscais;
end;

function TNFeRetRecepcao.Executar: Boolean;
  function Processando: Boolean;
  var
    XmlDoc: IXMLDocument;
    {$IFDEF ACBrNFeCAPICOM}
       Nota: NfeRetRecepcao;
       Rio: THTTPRIO;
    {$ELSE}
       Texto : String;
       Acao  : TStringList ;
       Stream: TMemoryStream;
       StrStream: TStringStream;
       HTTP: THTTPSend;
    {$ENDIF}
  begin
    {$IFDEF ACBrNFeCAPICOM}
       Rio := THTTPRIO.Create(nil);
       Rio.HTTPWebNode.OnBeforePost := OnBeforePost;
    {$ELSE}
       Acao := TStringList.Create;
       Stream := TMemoryStream.Create;
       Texto := '<?xml version="1.0" encoding="utf-8"?>';
       Texto := Texto + '<soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">';
       Texto := Texto + '  <soap:Body>';
       Texto := Texto + '    <nfeRetRecepcao xmlns="http://www.portalfiscal.inf.br/nfe/wsdl/NfeRetRecepcao">';
       Texto := Texto + '      <nfeCabecMsg>';

       Texto := Texto + NotaUtil.ParseText(FCabMsg,False);

       Texto := Texto + '      </nfeCabecMsg>';
       Texto := Texto + '      <nfeDadosMsg>';

       Texto := Texto + NotaUtil.ParseText(FDadosMsg,False);

       Texto := Texto + '      </nfeDadosMsg>';
       Texto := Texto + '    </nfeRetRecepcao>';
       Texto := Texto + '  </soap:Body>';
       Texto := Texto + '</soap:Envelope>';

       Acao.Text := Texto;

       Acao.SaveToStream(Stream);

       HTTP := THTTPSend.Create;
    {$ENDIF}
    try
      if FConfiguracoes.Geral.Salvar then
        FConfiguracoes.Geral.Save(Recibo+'-ped-rec.xml', FDadosMsg);

      {$IFDEF ACBrNFeCAPICOM}
         Nota   := GetNfeRetRecepcao( False, FURL, Rio);
         FRetWS := Nota.nfeRetRecepcao(FCabMsg, FDadosMsg);
      {$ELSE}
         HTTP.Document.LoadFromStream(Stream);
         ConfiguraHTTP(HTTP,'SOAPAction: "http://www.portalfiscal.inf.br/nfe/wsdl/NfeRetRecepcao/nfeRetRecepcao"');
         HTTP.HTTPMethod('POST', FURL);

         StrStream := TStringStream.Create('');
         StrStream.CopyFrom(HTTP.Document, 0);

         FRetWS := NotaUtil.SeparaDados( NotaUtil.ParseText(StrStream.DataString, True),'nfeRetRecepcaoResult');
         StrStream.Free;
      {$ENDIF}
      XmlDoc     := LoadXMLData(FRetWS);
      FNFeRetorno := GetretConsReciNFe(XmlDoc);

      if FConfiguracoes.WebServices.Visualizar then
      begin
        ShowMessage('Versão Leiaute : '+FNFeRetorno.Versao+LineBreak+
                    'Ambiente : '+NotaUtil.SeSenao(FNFeRetorno.TpAmb='1', 'Produção', 'Teste')+LineBreak+
                    'Versão Aplicativo : '+FNFeRetorno.VerAplic+LineBreak+
                    'Recibo : '+FNFeRetorno.NRec+LineBreak+
                    'Status Código : '+FNFeRetorno.CStat+LineBreak+
                    'Status Descrição : '+FNFeRetorno.XMotivo+LineBreak+
                    'UF : '+FNFeRetorno.CUF+LineBreak);
      end;

      Result := FNFeRetorno.CStat = '105';
      FMsg   := FNFeRetorno.XMotivo;

    finally
      {$IFDEF ACBrNFeCAPICOM}
//         Rio.Free;
      {$ELSE}
         HTTP.Free;
         Acao.Free;
         Stream.Free;
      {$ENDIF}
      NotaUtil.ConfAmbiente;
    end;
  end;

var
  vCont: Integer;
begin
  Result := inherited Executar;
  Result := False;
  
  vCont := 1000;
  while Processando do
  begin
    sleep(vCont);
    if vCont > 5000 then
      break;
    vCont := vCont +1000;
  end;

  if FNFeRetorno.CStat = '104' then
    Result := Confirma(FNFeRetorno.ProtNFe);

  if FConfiguracoes.Geral.Salvar then
    FConfiguracoes.Geral.Save(Recibo+'-pro-rec.xml', FRetWS);

end;

{ TNFeConsulta }

function TNFeConsulta.Executar: Boolean;
var
  NFeRetorno: IXMLTRetConsSitNFe;
  XmlDoc: IXMLDocument;
  {$IFDEF ACBrNFeCAPICOM}
     Nota: NfeConsulta;
     Rio: THTTPRIO;
  {$ELSE}
     Texto : String;
     Acao  : TStringList ;
     Stream: TMemoryStream;
     StrStream: TStringStream;
     HTTP: THTTPSend;
  {$ENDIF}
begin
  Result := inherited Executar;

  {$IFDEF ACBrNFeCAPICOM}
     Rio := THTTPRIO.Create(nil);
     Rio.HTTPWebNode.OnBeforePost := OnBeforePost;
  {$ELSE}
     Acao := TStringList.Create;
     Stream := TMemoryStream.Create;
     Texto := '<?xml version="1.0" encoding="utf-8"?>';
     Texto := Texto + '<soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">';
     Texto := Texto + '  <soap:Body>';
     Texto := Texto + '    <nfeConsultaNF xmlns="http://www.portalfiscal.inf.br/nfe/wsdl/NfeConsulta">';
     Texto := Texto + '      <nfeCabecMsg>';

     Texto := Texto + NotaUtil.ParseText(FCabMsg,False);

     Texto := Texto + '      </nfeCabecMsg>';
     Texto := Texto + '      <nfeDadosMsg>';

     Texto := Texto + NotaUtil.ParseText(FDadosMsg,False);

     Texto := Texto + '      </nfeDadosMsg>';
     Texto := Texto + '    </nfeConsultaNF>';
     Texto := Texto + '  </soap:Body>';
     Texto := Texto + '</soap:Envelope>';
     Acao.Text := Texto;

     Acao.SaveToStream(Stream);

     HTTP := THTTPSend.Create;
  {$ENDIF}
  try
    if FConfiguracoes.Geral.Salvar then
      FConfiguracoes.Geral.Save(FNFeChave+'-ped-sit.xml', FDadosMsg);

    {$IFDEF ACBrNFeCAPICOM}
       Nota   := GetNfeConsulta( False, FURL, Rio);
       FRetWS := Nota.nfeConsultaNF(FCabMsg, FDadosMsg);
    {$ELSE}
       HTTP.Document.LoadFromStream(Stream);
       ConfiguraHTTP(HTTP,'SOAPAction: "http://www.portalfiscal.inf.br/nfe/wsdl/NfeConsulta/nfeConsultaNF"');
       HTTP.HTTPMethod('POST', FURL);

       StrStream := TStringStream.Create('');
       StrStream.CopyFrom(HTTP.Document, 0);

       FRetWS := NotaUtil.SeparaDados( NotaUtil.ParseText(StrStream.DataString, True),'nfeConsultaNFResult');
       StrStream.Free;
    {$ENDIF}
    XmlDoc := LoadXMLData(FRetWS);
    NFeRetorno := GetretConsSitNFe(XmlDoc);
    FProtocolo := NFeRetorno.InfProt.NProt;

    if FConfiguracoes.WebServices.Visualizar then
    begin
      ShowMessage('Versão Leiaute : '+NFeRetorno.Versao+LineBreak+
                  'Identificador : '+NFeRetorno.InfProt.Id+LineBreak+
                  'Ambiente : '+NotaUtil.SeSenao(NFeRetorno.InfProt.TpAmb='1', 'Produção', 'Teste')+LineBreak+
                  'Versão Aplicativo : '+NFeRetorno.InfProt.VerAplic+LineBreak+
                  'Status Código : '+NFeRetorno.InfProt.CStat+LineBreak+
                  'Status Descrição : '+NFeRetorno.InfProt.XMotivo+LineBreak+
                  'UF : '+NotaUtil.CodigoToUF(NFeRetorno.InfProt.CUF)+LineBreak+
                  'Chave Acesso : '+NFeRetorno.InfProt.ChNFe+LineBreak+
                  'Recebimento : '+NFeRetorno.InfProt.DhRecbto+LineBreak+
                  'Protocolo : '+NFeRetorno.InfProt.NProt+LineBreak+
                  'Digest Value : '+NFeRetorno.InfProt.DigVal+LineBreak);
    end;

    FMsg   := NFeRetorno.InfProt.XMotivo;
    Result := (StrToIntDef(NFeRetorno.InfProt.CStat, 0) in [100,101,110]);

    if FConfiguracoes.Geral.Salvar then
      FConfiguracoes.Geral.Save(FNFeChave+'-sit.xml', FRetWS);
  finally
    {$IFDEF ACBrNFeCAPICOM}
//       Rio.Free;
    {$ELSE}
       HTTP.Free;
       Acao.Free;
       Stream.Free;
    {$ENDIF}
    NotaUtil.ConfAmbiente;
  end;
end;

{ TNFeCancelamento }

function TNFeCancelamento.Executar: Boolean;
var
  NFeRetorno: IXMLTRetCancNFe;
  XmlDoc: IXMLDocument;

  {$IFDEF ACBrNFeCAPICOM}
     Nota: NfeCancelamento;
     Rio: THTTPRIO;
  {$ELSE}
     Texto : String;
     Acao  : TStringList ;
     Stream: TMemoryStream;
     StrStream: TStringStream;
     HTTP: THTTPSend;
  {$ENDIF}
begin
  Result := inherited Executar;

  {$IFDEF ACBrNFeCAPICOM}
     Rio := THTTPRIO.Create(nil);
     Rio.HTTPWebNode.OnBeforePost := OnBeforePost;
  {$ELSE}
     Acao := TStringList.Create;
     Stream := TMemoryStream.Create;
     Texto := '<?xml version="1.0" encoding="utf-8"?>';
     Texto := Texto + '<soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">';
     Texto := Texto + '  <soap:Body>';
     Texto := Texto + '    <nfeCancelamentoNF xmlns="http://www.portalfiscal.inf.br/nfe/wsdl/NfeCancelamento">';
     Texto := Texto + '      <nfeCabecMsg>';

     Texto := Texto + NotaUtil.ParseText(FCabMsg,False);

     Texto := Texto + '      </nfeCabecMsg>';
     Texto := Texto + '      <nfeDadosMsg>';

     Texto := Texto + NotaUtil.ParseText(FDadosMsg,False);

     Texto := Texto + '      </nfeDadosMsg>';
     Texto := Texto + '    </nfeCancelamentoNF>';
     Texto := Texto + '  </soap:Body>';
     Texto := Texto + '</soap:Envelope>';
     Acao.Text := Texto;

     Acao.SaveToStream(Stream);

     HTTP := THTTPSend.Create;
  {$ENDIF}
  try
    if FConfiguracoes.Geral.Salvar then
      FConfiguracoes.Geral.Save(FNFeChave+'-ped-can.xml', FDadosMsg);

    {$IFDEF ACBrNFeCAPICOM}
       Nota   := GetNfeCancelamento(False, FURL, Rio);
       FRetWS := Nota.nfeCancelamentoNF(FCabMsg, FDadosMsg);
    {$ELSE}
       HTTP.Document.LoadFromStream(Stream);
       ConfiguraHTTP(HTTP,'SOAPAction: "http://www.portalfiscal.inf.br/nfe/wsdl/NfeCancelamento/nfeCancelamentoNF"');
       HTTP.HTTPMethod('POST', FURL);

       StrStream := TStringStream.Create('');
       StrStream.CopyFrom(HTTP.Document, 0);
       FRetWS := NotaUtil.SeparaDados( NotaUtil.ParseText(StrStream.DataString, True),'nfeCancelamentoNFResult');
       StrStream.Free;
    {$ENDIF}

    XmlDoc := LoadXMLData(FRetWS);
    NFeRetorno := GetretCancNFe(XmlDoc);

    if FConfiguracoes.WebServices.Visualizar then
    begin
      ShowMessage('Versão Leiaute : '+NFeRetorno.Versao+LineBreak+
                  'Identificador : '+NFeRetorno.InfCanc.Id+LineBreak+
                  'Ambiente : '+NotaUtil.SeSenao(NFeRetorno.InfCanc.TpAmb='1', 'Produção', 'Teste')+LineBreak+
                  'Versão Aplicativo : '+NFeRetorno.InfCanc.VerAplic+LineBreak+
                  'Status Código : '+NFeRetorno.InfCanc.CStat+LineBreak+
                  'Status Descrição : '+NFeRetorno.InfCanc.XMotivo+LineBreak+
                  'UF : '+NotaUtil.CodigoToUF(NFeRetorno.InfCanc.CUF)+LineBreak+
                  'Chave Acesso : '+NFeRetorno.InfCanc.ChNFe+LineBreak+
                  'Recebimento : '+NFeRetorno.InfCanc.DhRecbto+LineBreak+
                  'Protocolo : '+NFeRetorno.InfCanc.NProt+LineBreak);
    end;

    FMsg   := NFeRetorno.InfCanc.XMotivo;
    Result := (StrToIntDef(NFeRetorno.InfCanc.CStat, 0) = 101);

    if FConfiguracoes.Geral.Salvar then
      FConfiguracoes.Geral.Save(FNFeChave+'-can.xml', FRetWS);
  finally
    {$IFDEF ACBrNFeCAPICOM}
//       Rio.Free;
    {$ELSE}
       HTTP.Free;
       Acao.Free;
       Stream.Free;
    {$ENDIF}
    NotaUtil.ConfAmbiente;
  end;
end;

procedure TNFeCancelamento.SetJustificativa(AValue: WideString);
begin
  if NotaUtil.EstaVazio(AValue) then
    raise Exception.Create('Informar uma Justificativa para cancelar a Nota Fiscal Eletronica');

  if Length(AValue) < 15 then
    FJustificativa := NotaUtil.PadE(AValue, 15,'-')
  else
    FJustificativa := AValue;
end;

{ TNFeInutilizacao }

function TNFeInutilizacao.Executar: Boolean;
var
  NFeRetorno: IXMLTRetInutNFe;
  XmlDoc: IXMLDocument;
  {$IFDEF ACBrNFeCAPICOM}
     Nota: NfeInutilizacao;
     Rio: THTTPRIO;
  {$ELSE}
     Texto : String;
     Acao  : TStringList ;
     Stream: TMemoryStream;
     StrStream: TStringStream;
     HTTP: THTTPSend;
  {$ENDIF}
begin
  Result := inherited Executar;

  {$IFDEF ACBrNFeCAPICOM}
     Rio := THTTPRIO.Create(nil);
     Rio.HTTPWebNode.OnBeforePost := OnBeforePost;
  {$ELSE}
     Acao := TStringList.Create;
     Stream := TMemoryStream.Create;
     Texto := '<?xml version="1.0" encoding="utf-8"?>';
     Texto := Texto + '<soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">';
     Texto := Texto + '  <soap:Body>';
     Texto := Texto + '    <nfeInutilizacaoNF xmlns="http://www.portalfiscal.inf.br/nfe/wsdl/NfeInutilizacao">';
     Texto := Texto + '      <nfeCabecMsg>';

     Texto := Texto + NotaUtil.ParseText(FCabMsg,False);

     Texto := Texto + '      </nfeCabecMsg>';
     Texto := Texto + '      <nfeDadosMsg>';

     Texto := Texto + NotaUtil.ParseText(FDadosMsg,False);

     Texto := Texto + '      </nfeDadosMsg>';
     Texto := Texto + '    </nfeInutilizacaoNF>';
     Texto := Texto + '  </soap:Body>';
     Texto := Texto + '</soap:Envelope>';
     Acao.Text := Texto;

     Acao.SaveToStream(Stream);

     HTTP := THTTPSend.Create;
  {$ENDIF}
  try
    if FConfiguracoes.Geral.Salvar then
      FConfiguracoes.Geral.Save(FormatDateTime('yyyymmddhhnnss',Now)+FNFeChave+'-ped-inu.xml', FDadosMsg);

    {$IFDEF ACBrNFeCAPICOM}
       Nota   := GetNfeInutilizacao(False, FURL, Rio);
       FRetWS := Nota.nfeInutilizacaoNF(FCabMsg, FDadosMsg);
    {$ELSE}
       HTTP.Document.LoadFromStream(Stream);
       ConfiguraHTTP(HTTP,'SOAPAction: "http://www.portalfiscal.inf.br/nfe/wsdl/NfeInutilizacao/nfeInutilizacaoNF"');
       HTTP.HTTPMethod('POST', FURL);

       StrStream := TStringStream.Create('');
       StrStream.CopyFrom(HTTP.Document, 0);
       FRetWS := NotaUtil.SeparaDados( NotaUtil.ParseText(StrStream.DataString, True),'nfeInutilizacaoNFResult');
       StrStream.Free;
    {$ENDIF}   

    XmlDoc := LoadXMLData(FRetWS);
    NFeRetorno := GetretInutNFe(XmlDoc);

    if FConfiguracoes.WebServices.Visualizar then
    begin
      ShowMessage('Versão Leiaute : '+NFeRetorno.Versao+LineBreak+
                  'Identificador : '+NFeRetorno.InfInut.Id+LineBreak+
                  'Ambiente : '+NotaUtil.SeSenao(NFeRetorno.InfInut.TpAmb='1', 'Produção', 'Teste')+LineBreak+
                  'Versão Aplicativo : '+NFeRetorno.InfInut.VerAplic+LineBreak+
                  'Status Código : '+NFeRetorno.InfInut.CStat+LineBreak+
                  'Status Descrição : '+NFeRetorno.InfInut.XMotivo+LineBreak+
                  'UF : '+NotaUtil.CodigoToUF(NFeRetorno.InfInut.CUF)+LineBreak+
                  'Recebimento : '+NFeRetorno.InfInut.DhRecbto+LineBreak+
                  'Protocolo : '+NFeRetorno.InfInut.NProt+LineBreak);
    end;

    FMsg   := NFeRetorno.InfInut.XMotivo;
    Result := (StrToIntDef(NFeRetorno.InfInut.CStat, 0) = 102);

    if FConfiguracoes.Geral.Salvar then
      FConfiguracoes.Geral.Save(FormatDateTime('yyyymmddhhnnss',Now)+FNFeChave+'-inu.xml', FRetWS);
  finally
    {$IFDEF ACBrNFeCAPICOM}
//       Rio.Free;
    {$ELSE}
       HTTP.Free;
       Acao.Free;
       Stream.Free;
    {$ENDIF}
    NotaUtil.ConfAmbiente;
  end;
end;

procedure TNFeInutilizacao.SetJustificativa(AValue: WideString);
begin
  if NotaUtil.EstaVazio(AValue) then
    raise Exception.Create('Informar uma Justificativa para Inutilização de numeração da Nota Fiscal Eletronica');

  if Length(Trim(AValue)) < 15 then
   raise Exception.Create('A Justificativa para Inutilização de numeração da Nota Fiscal Eletronica deve ter no minimo 15 caracteres')
  else
    FJustificativa := Trim(AValue);
end;

end.
