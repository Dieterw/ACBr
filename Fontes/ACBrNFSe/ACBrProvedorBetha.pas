{$I ACBr.inc}

unit ACBrProvedorBetha;

interface

uses
  Classes, SysUtils,
  pnfsConversao, pcnAuxiliar,
  ACBrNFSeConfiguracoes, ACBrNFSeUtil, ACBrUtil, ACBrDFeUtil,
  {$IFDEF COMPILER6_UP} DateUtils {$ELSE} ACBrD5, FileCtrl {$ENDIF};

type
  { TACBrProvedorBetha }

 TProvedorBetha = class(TProvedorClass)
  protected
   { protected }
  private
   { private }
  public
   { public }
   Constructor Create;

   function GetConfigCidade(ACodCidade, AAmbiente: Integer): TConfigCidade; OverRide;
   function GetConfigSchema(ACodCidade: Integer): TConfigSchema; OverRide;
   function GetConfigURL(ACodCidade: Integer): TConfigURL; OverRide;
   function GetURI(URI: String): String; OverRide;
   function GetAssinarXML(Acao: TnfseAcao): Boolean; OverRide;
   // Sugestão de Rodrigo Cantelli
   function GetValidarLote: Boolean; OverRide;

   function Gera_TagI(Acao: TnfseAcao; Prefixo3, Prefixo4, NameSpaceDad, Identificador, URI: String): AnsiString; OverRide;
   function Gera_CabMsg(Prefixo2, VersaoLayOut, VersaoDados, NameSpaceCab: String): AnsiString; OverRide;
   function Gera_DadosSenha(CNPJ, Senha: String): AnsiString; OverRide;
   function Gera_TagF(Acao: TnfseAcao; Prefixo3: String): AnsiString; OverRide;

   function Gera_DadosMsgEnviarLote(Prefixo3, Prefixo4, Identificador,
                                    NameSpaceDad, VersaoDados, VersaoXML,
                                    NumeroLote, CNPJ, IM, QtdeNotas: String;
                                    Notas, TagI, TagF: AnsiString): AnsiString; OverRide;
   function Gera_DadosMsgConsSitLote(Prefixo3, Prefixo4, NameSpaceDad,
                                     VersaoXML, Protocolo, CNPJ, IM: String;
                                     TagI, TagF: AnsiString): AnsiString; OverRide;
   function Gera_DadosMsgConsLote(Prefixo3, Prefixo4, NameSpaceDad,
                                  VersaoXML, Protocolo, CNPJ, IM: String;
                                  TagI, TagF: AnsiString): AnsiString; OverRide;
   function Gera_DadosMsgConsNFSeRPS(Prefixo3, Prefixo4, NameSpaceDad, VersaoXML,
                                     NumeroRps, SerieRps, TipoRps, CNPJ, IM: String;
                                     TagI, TagF: AnsiString): AnsiString; OverRide;
   function Gera_DadosMsgConsNFSe(Prefixo3, Prefixo4, NameSpaceDad, VersaoXML,
                                  CNPJ, IM: String;
                                  DataInicial, DataFinal: TDateTime;
                                  TagI, TagF: AnsiString; NumeroNFSe: string = ''): AnsiString; OverRide;
   function Gera_DadosMsgCancelarNFSe(Prefixo4, NameSpaceDad, NumeroNFSe, CNPJ, IM,
                                      CodMunicipio, CodCancelamento: String;
                                      TagI, TagF: AnsiString): AnsiString; OverRide;
   function Gera_DadosMsgGerarNFSe(Prefixo3, Prefixo4, Identificador,
                                   NameSpaceDad, VersaoDados, VersaoXML,
                                   NumeroLote, CNPJ, IM, QtdeNotas: String;
                                   Notas, TagI, TagF: AnsiString): AnsiString; OverRide;

   function GeraEnvelopeRecepcionarLoteRPS(URLNS: String; CabMsg, DadosMsg, DadosSenha: AnsiString): AnsiString; OverRide;
   function GeraEnvelopeConsultarSituacaoLoteRPS(URLNS: String; CabMsg, DadosMsg, DadosSenha: AnsiString): AnsiString; OverRide;
   function GeraEnvelopeConsultarLoteRPS(URLNS: String; CabMsg, DadosMsg, DadosSenha: AnsiString): AnsiString; OverRide;
   function GeraEnvelopeConsultarNFSeporRPS(URLNS: String; CabMsg, DadosMsg, DadosSenha: AnsiString): AnsiString; OverRide;
   function GeraEnvelopeConsultarNFSe(URLNS: String; CabMsg, DadosMsg, DadosSenha: AnsiString): AnsiString; OverRide;
   function GeraEnvelopeCancelarNFSe(URLNS: String; CabMsg, DadosMsg, DadosSenha: AnsiString): AnsiString; OverRide;
   function GeraEnvelopeGerarNFSe(URLNS: String; CabMsg, DadosMsg, DadosSenha: AnsiString): AnsiString; OverRide;

   function GetSoapAction(Acao: TnfseAcao; NomeCidade: String): String; OverRide;
   function GetRetornoWS(Acao: TnfseAcao; RetornoWS: AnsiString): AnsiString; OverRide;

   function GeraRetornoNFSe(Prefixo: String; RetNFSe: AnsiString; NomeCidade: String): AnsiString; OverRide;
   function GetLinkNFSe(ACodMunicipio, ANumeroNFSe: Integer; ACodVerificacao: String; AAmbiente: Integer): String; OverRide;
  end;

implementation

{ TProvedorBetha }

constructor TProvedorBetha.Create;
begin
 {----}
end;

function TProvedorBetha.GetConfigCidade(ACodCidade,
  AAmbiente: Integer): TConfigCidade;
var
 ConfigCidade: TConfigCidade;
begin
 // Alterado por Rodrigo Cantelli

 ConfigCidade.VersaoSoap    := '1.1';
 ConfigCidade.CodigoSchemas := 12;
 ConfigCidade.CodigoURLs    := 24;
 ConfigCidade.Prefixo2      := '';
 ConfigCidade.Prefixo3      := 'ns3:';
 ConfigCidade.Prefixo4      := '';
 ConfigCidade.Identificador := 'Id';

 if AAmbiente = 1
  then ConfigCidade.NameSpaceEnvelope := 'http://www.betha.com.br/e-nota-contribuinte-ws'
  else ConfigCidade.NameSpaceEnvelope := 'http://www.betha.com.br/e-nota-contribuinte-ws';

 ConfigCidade.AssinaRPS  := True;
 ConfigCidade.AssinaLote := True;

 Result := ConfigCidade;
end;

function TProvedorBetha.GetConfigSchema(ACodCidade: Integer): TConfigSchema;
var
 ConfigSchema: TConfigSchema;
begin
 // Alterado por Rodrigo Cantelli

 ConfigSchema.VersaoCabecalho := '1.00';
 ConfigSchema.VersaoDados     := '1.00';
 ConfigSchema.VersaoXML       := '2';
 ConfigSchema.NameSpaceXML    := 'http://www.betha.com.br/e-nota-contribuinte-ws';
 ConfigSchema.Cabecalho       := 'nfse_v01.xsd';
 ConfigSchema.ServicoEnviar   := 'servico_enviar_lote_rps_envio_v01.xsd';
 ConfigSchema.ServicoConSit   := 'servico_consultar_situacao_lote_rps_envio_v01.xsd';
 ConfigSchema.ServicoConLot   := 'servico_consultar_lote_rps_envio_v01.xsd';
 ConfigSchema.ServicoConRps   := 'servico_enviar_lote_rps_resposta_v01.xsd';
 ConfigSchema.ServicoConNfse  := 'servico_consultar_nfse_envio_v01.xsd';
 ConfigSchema.ServicoCancelar := 'servico_cancelar_nfse_envio_v01.xsd';
 ConfigSchema.DefTipos        := '';

 Result := ConfigSchema;
end;

function TProvedorBetha.GetConfigURL(ACodCidade: Integer): TConfigURL;
var
 ConfigURL: TConfigURL;
begin
 ConfigURL.HomNomeCidade         := '';
 ConfigURL.HomRecepcaoLoteRPS    := 'https://e-gov.betha.com.br/e-nota-contribuinte-test-ws/recepcionarLoteRps?wsdl';
 ConfigURL.HomConsultaLoteRPS    := 'https://e-gov.betha.com.br/e-nota-contribuinte-test-ws/consultarLoteRps?wsdl';
 ConfigURL.HomConsultaNFSeRPS    := 'https://e-gov.betha.com.br/e-nota-contribuinte-test-ws/consultarNfsePorRps?wsdl';
 ConfigURL.HomConsultaSitLoteRPS := 'https://e-gov.betha.com.br/e-nota-contribuinte-test-ws/consultarSituacaoLoteRps?wsdl';
 ConfigURL.HomConsultaNFSe       := 'https://e-gov.betha.com.br/e-nota-contribuinte-test-ws/consultarNfse?wsdl';
 ConfigURL.HomCancelaNFSe        := 'https://e-gov.betha.com.br/e-nota-contribuinte-test-ws/cancelarNfse?wsdl';

 ConfigURL.ProNomeCidade         := '';
 ConfigURL.ProRecepcaoLoteRPS    := 'https://e-gov.betha.com.br/e-nota-contribuinte-ws/recepcionarLoteRps?wsdl';
 ConfigURL.ProConsultaLoteRPS    := 'https://e-gov.betha.com.br/e-nota-contribuinte-ws/consultarLoteRps?wsdl';
 ConfigURL.ProConsultaNFSeRPS    := 'https://e-gov.betha.com.br/e-nota-contribuinte-ws/consultarNfsePorRps?wsdl';
 ConfigURL.ProConsultaSitLoteRPS := 'https://e-gov.betha.com.br/e-nota-contribuinte-ws/consultarSituacaoLoteRps?wsdl';
 ConfigURL.ProConsultaNFSe       := 'https://e-gov.betha.com.br/e-nota-contribuinte-ws/consultarNfse?wsdl';
 ConfigURL.ProCancelaNFSe        := 'https://e-gov.betha.com.br/e-nota-contribuinte-ws/cancelarNfse?wsdl';

 Result := ConfigURL;
end;

function TProvedorBetha.GetURI(URI: String): String;
begin
 Result := URI;
end;

function TProvedorBetha.GetAssinarXML(Acao: TnfseAcao): Boolean;
begin
 // Alterado por Rodrigo Cantelli

 case Acao of
   acRecepcionar: Result := True;
   acConsSit:     Result := False;
   acConsLote:    Result := False;
   acConsNFSeRps: Result := False;
   acConsNFSe:    Result := False;
   acCancelar:    Result := False;
   acGerar:       Result := False;
   else           Result := False;
 end;
end;

function TProvedorBetha.GetValidarLote: Boolean;
begin
 Result := True;
end;

function TProvedorBetha.Gera_TagI(Acao: TnfseAcao; Prefixo3, Prefixo4,
  NameSpaceDad, Identificador, URI: String): AnsiString;
begin
 // Alterado por Rodrigo Cantelli

 case Acao of
   acRecepcionar: Result := '<' + Prefixo3 + 'EnviarLoteRpsEnvio' + NameSpaceDad;
   acConsSit:     Result := '<' + Prefixo3 + 'ConsultarSituacaoLoteRpsEnvio' + NameSpaceDad;
   acConsLote:    Result := '<' + Prefixo3 + 'ConsultarLoteRpsEnvio' + NameSpaceDad;
   acConsNFSeRps: Result := '<' + Prefixo3 + 'ConsultarNfsePorRpsEnvio' + NameSpaceDad;
   acConsNFSe:    Result := '<' + Prefixo3 + 'ConsultarNfseEnvio' + NameSpaceDad;
   acCancelar:    Result := '<' + Prefixo3 + 'CancelarNfseEnvio' + NameSpaceDad +
                             '<Pedido>' +
                              '<' + Prefixo4 + 'InfPedidoCancelamento' +
                                 DFeUtil.SeSenao(Identificador <> '', ' ' + Identificador + '="' + URI + '"', '') + '>';
   acGerar:       Result := '';
 end;
end;

function TProvedorBetha.Gera_CabMsg(Prefixo2, VersaoLayOut, VersaoDados,
  NameSpaceCab: String): AnsiString;
begin
 Result := '<' + Prefixo2 + 'cabecalho versao="'  + VersaoLayOut + '"' + NameSpaceCab +
            '<versaoDados>' + VersaoDados + '</versaoDados>'+
           '</' + Prefixo2 + 'cabecalho>';
end;

function TProvedorBetha.Gera_DadosSenha(CNPJ, Senha: String): AnsiString;
begin
 Result := '';
end;

function TProvedorBetha.Gera_TagF(Acao: TnfseAcao; Prefixo3: String): AnsiString;
begin
 // Alterado por Rodrigo Cantelli

 case Acao of
   acRecepcionar: Result := '</' + Prefixo3 + 'EnviarLoteRpsEnvio>';
   acConsSit:     Result := '</' + Prefixo3 + 'ConsultarSituacaoLoteRpsEnvio>';
   acConsLote:    Result := '</' + Prefixo3 + 'ConsultarLoteRpsEnvio>';
   acConsNFSeRps: Result := '</' + Prefixo3 + 'ConsultarNfsePorRpsEnvio>';
   acConsNFSe:    Result := '</' + Prefixo3 + 'ConsultarNfseEnvio>';
   acCancelar:    Result := '</Pedido>' +
                           '</' + Prefixo3 + 'CancelarNfseEnvio>';
   acGerar:       Result := '';
 end;
end;

function TProvedorBetha.Gera_DadosMsgEnviarLote(Prefixo3, Prefixo4,
  Identificador, NameSpaceDad, VersaoDados, VersaoXML, NumeroLote, CNPJ,
  IM, QtdeNotas: String; Notas, TagI, TagF: AnsiString): AnsiString;
var
 DadosMsg: AnsiString;
begin
 // Alterado por Rodrigo Cantelli

 DadosMsg := '<LoteRps' +
               DFeUtil.SeSenao(Identificador <> '', ' ' + Identificador + '="' + NumeroLote + '"', '') + '>' +

              '<' + Prefixo4 + 'NumeroLote>' +
                NumeroLote +
              '</' + Prefixo4 + 'NumeroLote>' +

               DFeUtil.SeSenao(VersaoXML = '1',

                '<' + Prefixo4 + 'CpfCnpj>' +
                '<' + Prefixo4 + 'Cnpj>' +
                  Cnpj +
                '</' + Prefixo4 + 'Cnpj>' +
                '</' + Prefixo4 + 'CpfCnpj>',

                '<' + Prefixo4 + 'Cnpj>' +
                  Cnpj +
                '</' + Prefixo4 + 'Cnpj>') +

              '<' + Prefixo4 + 'InscricaoMunicipal>' +
                IM +
              '</' + Prefixo4 + 'InscricaoMunicipal>' +
              '<' + Prefixo4 + 'QuantidadeRps>' +
                QtdeNotas +
              '</' + Prefixo4 + 'QuantidadeRps>' +
              '<' + Prefixo4 + 'ListaRps>' +
               Notas +
              '</' + Prefixo4 + 'ListaRps>' +
             '</LoteRps>';

  Result := TagI + DadosMsg + TagF;
end;

function TProvedorBetha.Gera_DadosMsgConsSitLote(Prefixo3, Prefixo4,
  NameSpaceDad, VersaoXML, Protocolo, CNPJ, IM: String; TagI,
  TagF: AnsiString): AnsiString;
var
 DadosMsg: AnsiString;
begin
 // Alterado por Rodrigo Cantelli

 DadosMsg := '<Prestador>' +

               DFeUtil.SeSenao(VersaoXML = '1',

                 '<' + Prefixo4 + 'CpfCnpj>' +
                 '<' + Prefixo4 + 'Cnpj>' +
                   Cnpj +
                 '</' + Prefixo4 + 'Cnpj>' +
                 '</' + Prefixo4 + 'CpfCnpj>',

                 '<' + Prefixo4 + 'Cnpj>' +
                   Cnpj +
                 '</' + Prefixo4 + 'Cnpj>') +

              '<' + Prefixo4 + 'InscricaoMunicipal>' +
                IM +
              '</' + Prefixo4 + 'InscricaoMunicipal>' +
             '</Prestador>' +
             '<Protocolo>' +
               Protocolo +
             '</Protocolo>';

 Result := TagI + DadosMsg + TagF;
end;

function TProvedorBetha.Gera_DadosMsgConsLote(Prefixo3, Prefixo4,
  NameSpaceDad, VersaoXML, Protocolo, CNPJ, IM: String; TagI,
  TagF: AnsiString): AnsiString;
var
 DadosMsg: AnsiString;
begin
 // Alterado por Rodrigo Cantelli

 DadosMsg := '<Prestador>' +

               DFeUtil.SeSenao(VersaoXML = '1',

                 '<' + Prefixo4 + 'CpfCnpj>' +
                 '<' + Prefixo4 + 'Cnpj>' +
                   Cnpj +
                 '</' + Prefixo4 + 'Cnpj>' +
                 '</' + Prefixo4 + 'CpfCnpj>',

                 '<' + Prefixo4 + 'Cnpj>' +
                   Cnpj +
                 '</' + Prefixo4 + 'Cnpj>') +

              '<' + Prefixo4 + 'InscricaoMunicipal>' +
                IM +
              '</' + Prefixo4 + 'InscricaoMunicipal>' +
             '</Prestador>' +
             '<Protocolo>' +
               Protocolo +
             '</Protocolo>';

 Result := TagI + DadosMsg + TagF;
end;

function TProvedorBetha.Gera_DadosMsgConsNFSe(Prefixo3, Prefixo4,
  NameSpaceDad, VersaoXML, CNPJ, IM: String; DataInicial, DataFinal: TDateTime; TagI,
  TagF: AnsiString; NumeroNFSe: string = ''): AnsiString;
var
 DadosMsg: AnsiString;
begin
 // Alterado por Rodrigo Cantelli

 DadosMsg := '<Prestador>' +

               DFeUtil.SeSenao(VersaoXML = '1',

                 '<' + Prefixo4 + 'CpfCnpj>' +
                 '<' + Prefixo4 + 'Cnpj>' +
                  Cnpj +
                 '</' + Prefixo4 + 'Cnpj>' +
                 '</' + Prefixo4 + 'CpfCnpj>',

                 '<' + Prefixo4 + 'Cnpj>' +
                  Cnpj +
                 '</' + Prefixo4 + 'Cnpj>') +

              '<' + Prefixo4 + 'InscricaoMunicipal>' +
               IM +
              '</' + Prefixo4 + 'InscricaoMunicipal>' +
             '</Prestador>';

 if NumeroNFSe <> ''
  then DadosMsg := DadosMsg + '<' + Prefixo3 + 'NumeroNfse>' +
                               NumeroNFSe +
                              '</' + Prefixo3 + 'NumeroNfse>';

 if (DataInicial>0) and (DataFinal>0)
  then DadosMsg := DadosMsg + '<PeriodoEmissao>' +
                               '<DataInicial>' +
                                 FormatDateTime('yyyy-mm-dd', DataInicial) +
                               '</DataInicial>' +
                               '<DataFinal>' +
                                 FormatDateTime('yyyy-mm-dd', DataFinal) +
                               '</DataFinal>' +
                              '</PeriodoEmissao>';

 Result := TagI + DadosMsg + TagF;
end;

function TProvedorBetha.Gera_DadosMsgConsNFSeRPS(Prefixo3, Prefixo4,
  NameSpaceDad, VersaoXML, NumeroRps, SerieRps, TipoRps, CNPJ, IM: String; TagI,
  TagF: AnsiString): AnsiString;
var
 DadosMsg: AnsiString;
begin
 // Alterado por Rodrigo Cantelli

 DadosMsg := '<IdentificacaoRps>' +
              '<' + Prefixo4 + 'Numero>' +
                NumeroRps +
              '</' + Prefixo4 + 'Numero>' +
              '<' + Prefixo4 + 'Serie>' +
                SerieRps +
              '</' + Prefixo4 + 'Serie>' +
              '<' + Prefixo4 + 'Tipo>' +
                TipoRps +
              '</' + Prefixo4 + 'Tipo>' +
             '</IdentificacaoRps>' +
             '<Prestador>' +

              DFeUtil.SeSenao(VersaoXML = '1',

                '<' + Prefixo4 + 'CpfCnpj>' +
                '<' + Prefixo4 + 'Cnpj>' +
                  Cnpj +
                '</' + Prefixo4 + 'Cnpj>' +
                '</' + Prefixo4 + 'CpfCnpj>',

                '<' + Prefixo4 + 'Cnpj>' +
                  Cnpj +
                '</' + Prefixo4 + 'Cnpj>') +

              '<' + Prefixo4 + 'InscricaoMunicipal>' +
                IM +
              '</' + Prefixo4 + 'InscricaoMunicipal>' +
             '</Prestador>';

 Result := TagI + DadosMsg + TagF;
end;

function TProvedorBetha.Gera_DadosMsgCancelarNFSe(Prefixo4, NameSpaceDad, NumeroNFSe,
  CNPJ, IM, CodMunicipio, CodCancelamento: String; TagI,
  TagF: AnsiString): AnsiString;
var
 DadosMsg: AnsiString;
begin
 DadosMsg := '<' + Prefixo4 + 'IdentificacaoNfse>' +
              '<' + Prefixo4 + 'Numero>' +
                NumeroNFse +
              '</' + Prefixo4 + 'Numero>' +
              '<' + Prefixo4 + 'Cnpj>' +
                Cnpj +
              '</' + Prefixo4 + 'Cnpj>' +
              '<' + Prefixo4 + 'InscricaoMunicipal>' +
                IM +
              '</' + Prefixo4 + 'InscricaoMunicipal>' +
              '<' + Prefixo4 + 'CodigoMunicipio>' +
                CodMunicipio +
              '</' + Prefixo4 + 'CodigoMunicipio>' +
             '</' + Prefixo4 + 'IdentificacaoNfse>' +
             '<' + Prefixo4 + 'CodigoCancelamento>' +

               // Codigo de Cancelamento
               // 1 - Erro de emissão
               // 2 - Serviço não concluido
               // 3 - RPS Cancelado na Emissão

                CodCancelamento +

             '</' + Prefixo4 + 'CodigoCancelamento>' +
            '</' + Prefixo4 + 'InfPedidoCancelamento>';

 Result := TagI + DadosMsg + TagF;
end;

function TProvedorBetha.Gera_DadosMsgGerarNFSe(Prefixo3, Prefixo4,
  Identificador, NameSpaceDad, VersaoDados, VersaoXML, NumeroLote, CNPJ,
  IM, QtdeNotas: String; Notas, TagI, TagF: AnsiString): AnsiString;
begin
 Result := '';
end;

function TProvedorBetha.GeraEnvelopeRecepcionarLoteRPS(URLNS: String;
  CabMsg, DadosMsg, DadosSenha: AnsiString): AnsiString;
begin
 // Alterado por Rodrigo Cantelli

 Result := '<?xml version="1.0" encoding="UTF-8"?>' +
           '<S:Envelope xmlns:S="http://schemas.xmlsoap.org/soap/envelope/">' +
            '<S:Body>' +
              DadosMsg +
            '</S:Body>' +
           '</S:Envelope>';
end;

function TProvedorBetha.GeraEnvelopeConsultarSituacaoLoteRPS(
  URLNS: String; CabMsg, DadosMsg, DadosSenha: AnsiString): AnsiString;
begin
 // Alterado por Rodrigo Cantelli

 Result := '<?xml version="1.0" encoding="UTF-8"?>' +
           '<S:Envelope xmlns:S="http://schemas.xmlsoap.org/soap/envelope/">' +
            '<S:Body>' +
              DadosMsg +
            '</S:Body>' +
           '</S:Envelope>';
end;

function TProvedorBetha.GeraEnvelopeConsultarLoteRPS(URLNS: String;
  CabMsg, DadosMsg, DadosSenha: AnsiString): AnsiString;
begin
 // Alterado por Rodrigo Cantelli

 Result := '<?xml version="1.0" encoding="UTF-8"?>' +
           '<S:Envelope xmlns:S="http://schemas.xmlsoap.org/soap/envelope/">' +
            '<S:Body>' +
               DadosMsg +
            '</S:Body>' +
           '</S:Envelope>';
end;

function TProvedorBetha.GeraEnvelopeConsultarNFSeporRPS(URLNS: String;
  CabMsg, DadosMsg, DadosSenha: AnsiString): AnsiString;
begin
 // Alterado por Rodrigo Cantelli

 Result := '<?xml version="1.0" encoding="UTF-8"?>' +
           '<S:Envelope xmlns:S="http://schemas.xmlsoap.org/soap/envelope/">' +
            '<S:Body>' +
              DadosMsg +
            '</S:Body>' +
           '</S:Envelope>';
end;

function TProvedorBetha.GeraEnvelopeConsultarNFSe(URLNS: String; CabMsg,
  DadosMsg, DadosSenha: AnsiString): AnsiString;
begin
 // Alterado por Rodrigo Cantelli

 Result := '<?xml version="1.0" encoding="UTF-8"?>' +
           '<S:Envelope xmlns:S="http://schemas.xmlsoap.org/soap/envelope/">' +
            '<S:Body>' +
              DadosMsg +
            '</S:Body>' +
           '</S:Envelope>';
end;

function TProvedorBetha.GeraEnvelopeCancelarNFSe(URLNS: String; CabMsg,
  DadosMsg, DadosSenha: AnsiString): AnsiString;
begin
 // Alterado por Rodrigo Cantelli

 Result := '<?xml version="1.0" encoding="UTF-8"?>' +
            '<S:Envelope xmlns:S="http://schemas.xmlsoap.org/soap/envelope/">' +
             '<S:Body>' +
              DadosMsg +
             '</S:Body>' +
            '</S:Envelope>';
end;

function TProvedorBetha.GeraEnvelopeGerarNFSe(URLNS: String; CabMsg,
  DadosMsg, DadosSenha: AnsiString): AnsiString;
begin
 Result := '';
 raise Exception.Create( 'Opção não implementada para este provedor.' );
end;

function TProvedorBetha.GetSoapAction(Acao: TnfseAcao; NomeCidade: String): String;
begin
 // Alterado por Rodrigo Cantelli

 case Acao of
   acRecepcionar: Result := 'http://www.betha.com.br/e-nota-contribuinte-ws/recepcionarLoteRps';
   acConsSit:     Result := 'http://www.betha.com.br/e-nota-contribuinte-ws/ConsultarSituacaoLoteRpsEnvio';
   acConsLote:    Result := 'http://www.betha.com.br/e-nota-contribuinte-ws/consultarLoteRps';
   acConsNFSeRps: Result := 'http://www.betha.com.br/e-nota-contribuinte-ws/consultarNfsePorRps';
   acConsNFSe:    Result := 'http://www.betha.com.br/e-nota-contribuinte-ws/consultarNfse';
   acCancelar:    Result := 'http://www.betha.com.br/e-nota-contribuinte-ws/cancelarNfse';
   acGerar:       Result := '';
 end;
end;

function TProvedorBetha.GetRetornoWS(Acao: TnfseAcao; RetornoWS: AnsiString): AnsiString;
begin
 // Alterado por Rodrigo Cantelli

 case Acao of
   acRecepcionar: Result := SeparaDados( RetornoWS, 'EnviarLoteRpsResposta', True );
   acConsSit:     Result := SeparaDados( RetornoWS, 'ConsultarSituacaoLoteRpsResposta', True );
   acConsLote:    Result := SeparaDados( RetornoWS, 'ConsultarLoteRpsResposta', True );
   acConsNFSeRps: Result := SeparaDados( RetornoWS, 'ConsultarNfseRpsResposta', True );
   acConsNFSe:    Result := SeparaDados( RetornoWS, 'ConsultarNfseResposta', True );
   acCancelar:    Result := SeparaDados( RetornoWS, 'CancelarNfseReposta', True );
   acGerar:       Result := '';
 end;
end;

function TProvedorBetha.GeraRetornoNFSe(Prefixo: String;
  RetNFSe: AnsiString; NomeCidade: String): AnsiString;
begin
 // Alterado por Rodrigo Cantelli
 
 Result := '<?xml version="1.0" encoding="UTF-8"?>' +
           '<ComplNfse xmlns="http://www.betha.com.br/e-nota-contribuinte-ws">' +
             RetNfse +
           '</ComplNfse>';
end;

function TProvedorBetha.GetLinkNFSe(ACodMunicipio, ANumeroNFSe: Integer;
  ACodVerificacao: String; AAmbiente: Integer): String;
begin
 Result := '';
end;

end.
