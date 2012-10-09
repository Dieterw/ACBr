{$I ACBr.inc}

unit ACBrProvedorISSNet;

interface

uses
  Classes, SysUtils,
  pnfsConversao, pcnAuxiliar,
  ACBrNFSeConfiguracoes, ACBrNFSeUtil, ACBrUtil,
  {$IFDEF COMPILER6_UP} DateUtils {$ELSE} ACBrD5, FileCtrl {$ENDIF};

type
  { TACBrProvedorGinfes }

 TProvedorISSNet = class(TProvedorClass)
  protected
   { protected }
  private
   { private }
  public
   { public }
   Constructor Create;

   function GetConfigCidade(ACodigo, AAmbiente: Integer): TConfigCidade; OverRide;
   function GetConfigSchema(ACodigo: Integer): TConfigSchema; OverRide;
   function GetConfigURL(ACodigo: Integer): TConfigURL; OverRide;
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
   function Gera_DadosMsgConsNFSeRPS(Prefixo3, Prefixo4, VersaoXML,
                                     NumeroRps, SerieRps, TipoRps, CNPJ, IM: String;
                                     TagI, TagF: AnsiString): AnsiString; OverRide;
   function Gera_DadosMsgConsNFSe(Prefixo3, Prefixo4, VersaoXML,
                                  CNPJ, IM: String;
                                  DataInicial, DataFinal: TDateTime;
                                  TagI, TagF: AnsiString): AnsiString; OverRide;
   function Gera_DadosMsgCancelarNFSe(Prefixo4, NumeroNFSe, CNPJ, IM,
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
  end;

implementation

{ TProvedorGinfes }

constructor TProvedorISSNet.Create;
begin
 {----}
end;

function TProvedorISSNet.GetConfigCidade(ACodigo,
  AAmbiente: Integer): TConfigCidade;
var
 ConfigCidade: TConfigCidade;
begin
 ConfigCidade.VersaoSoap    := '1.1';
 ConfigCidade.CodigoSchemas := 2;
 case ACodigo of
  3530607: ConfigCidade.CodigoURLs := 15; // Mogi das Cruzes/SP
  5103403: ConfigCidade.CodigoURLs := 09; // Cuiaba/MT
  5201108: ConfigCidade.CodigoURLs := 02; // Anapolis/GO
  5201405: ConfigCidade.CodigoURLs := 04; // Aparecida de Goiania/GO
 end;
 ConfigCidade.Prefixo2      := '';
 ConfigCidade.Prefixo3      := '';
 ConfigCidade.Prefixo4      := 'tc:';
 ConfigCidade.Identificador := '';

 if AAmbiente = 1
  then ConfigCidade.NameSpaceEnvelope := 'http://www.issnetonline.com.br/webservice/nfd'
  else ConfigCidade.NameSpaceEnvelope := 'http://www.issnetonline.com.br/webservice/nfd';

 ConfigCidade.AssinaRPS  := False;
 ConfigCidade.AssinaLote := True;

 Result := ConfigCidade;
end;

function TProvedorISSNet.GetConfigSchema(ACodigo: Integer): TConfigSchema;
var
 ConfigSchema: TConfigSchema;
begin
 ConfigSchema.VersaoCabecalho := '1.00';
 ConfigSchema.VersaoDados     := '1.00';
 ConfigSchema.VersaoXML       := '1';
 ConfigSchema.NameSpaceXML    := 'http://www.issnetonline.com.br/webserviceabrasf/vsd/';
 ConfigSchema.Cabecalho       := '';
 ConfigSchema.ServicoEnviar   := 'servico_enviar_lote_rps_envio.xsd';
 ConfigSchema.ServicoConSit   := 'servico_consultar_situacao_lote_rps_envio.xsd';
 ConfigSchema.ServicoConLot   := 'servico_consultar_lote_rps_envio.xsd';
 ConfigSchema.ServicoConRps   := 'servico_consultar_nfse_rps_envio.xsd';
 ConfigSchema.ServicoConNfse  := 'servico_consultar_nfse_envio.xsd';
 ConfigSchema.ServicoCancelar := 'servico_cancelar_nfse_envio.xsd';
 ConfigSchema.DefTipos        := 'tipos_complexos.xsd';

 Result := ConfigSchema;
end;

function TProvedorISSNet.GetConfigURL(ACodigo: Integer): TConfigURL;
var
 ConfigURL: TConfigURL;
begin
 case ACodigo of
  02: begin
       ConfigURL.HomNomeCidade         := 'anapolis';
       ConfigURL.ProNomeCidade         := 'anapolis';
      end;
  04: begin
       ConfigURL.HomNomeCidade         := 'aparecidadegoiania';
       ConfigURL.ProNomeCidade         := 'aparecidadegoiania';
      end;
  09: begin
       ConfigURL.HomNomeCidade         := 'cuiaba';
       ConfigURL.ProNomeCidade         := 'cuiaba';
      end;
  15: begin
       ConfigURL.HomNomeCidade         := 'mogidascruzes';
       ConfigURL.ProNomeCidade         := 'mogidascruzes';
      end;
 end;

 ConfigURL.HomRecepcaoLoteRPS    := 'http://www.issnetonline.com.br/webserviceabrasf/homologacao/servicos.asmx';
 ConfigURL.HomConsultaLoteRPS    := 'http://www.issnetonline.com.br/webserviceabrasf/homologacao/servicos.asmx';
 ConfigURL.HomConsultaNFSeRPS    := 'http://www.issnetonline.com.br/webserviceabrasf/homologacao/servicos.asmx';
 ConfigURL.HomConsultaSitLoteRPS := 'http://www.issnetonline.com.br/webserviceabrasf/homologacao/servicos.asmx';
 ConfigURL.HomConsultaNFSe       := 'http://www.issnetonline.com.br/webserviceabrasf/homologacao/servicos.asmx';
 ConfigURL.HomCancelaNFSe        := 'http://www.issnetonline.com.br/webserviceabrasf/homologacao/servicos.asmx';

 ConfigURL.ProRecepcaoLoteRPS    := 'http://www.issnetonline.com.br/webserviceabrasf/' + ConfigURL.ProNomeCidade + '/servicos.asmx';
 ConfigURL.ProConsultaLoteRPS    := 'http://www.issnetonline.com.br/webserviceabrasf/' + ConfigURL.ProNomeCidade + '/servicos.asmx';
 ConfigURL.ProConsultaNFSeRPS    := 'http://www.issnetonline.com.br/webserviceabrasf/' + ConfigURL.ProNomeCidade + '/servicos.asmx';
 ConfigURL.ProConsultaSitLoteRPS := 'http://www.issnetonline.com.br/webserviceabrasf/' + ConfigURL.ProNomeCidade + '/servicos.asmx';
 ConfigURL.ProConsultaNFSe       := 'http://www.issnetonline.com.br/webserviceabrasf/' + ConfigURL.ProNomeCidade + '/servicos.asmx';
 ConfigURL.ProCancelaNFSe        := 'http://www.issnetonline.com.br/webserviceabrasf/' + ConfigURL.ProNomeCidade + '/servicos.asmx';

 Result := ConfigURL;
end;

function TProvedorISSNet.GetURI(URI: String): String;
begin
 Result := URI;
end;

function TProvedorISSNet.GetAssinarXML(Acao: TnfseAcao): Boolean;
begin
 case Acao of
   acRecepcionar: Result := False;
   acConsSit:     Result := False;
   acConsLote:    Result := False;
   acConsNFSeRps: Result := False;
   acConsNFSe:    Result := False;
   acCancelar:    Result := False;
   acGerar:       Result := False;
   else           Result := False;
 end;
end;

function TProvedorISSNet.GetValidarLote: Boolean;
begin
 Result := True;
end;

function TProvedorISSNet.Gera_TagI(Acao: TnfseAcao; Prefixo3, Prefixo4,
  NameSpaceDad, Identificador, URI: String): AnsiString;
begin
 case Acao of
   acRecepcionar: Result := '<' + Prefixo3 + 'EnviarLoteRpsEnvio' + NameSpaceDad;
   acConsSit:     Result := '<' + Prefixo3 + 'ConsultarSituacaoLoteRpsEnvio' + NameSpaceDad;
   acConsLote:    Result := '<' + Prefixo3 + 'ConsultarLoteRpsEnvio' + NameSpaceDad;
   acConsNFSeRps: Result := '<' + Prefixo3 + 'ConsultarNfseRpsEnvio' + NameSpaceDad;
   acConsNFSe:    Result := '<' + Prefixo3 + 'ConsultarNfseEnvio' + NameSpaceDad;
   acCancelar:    Result := '<' + Prefixo3 + 'CancelarNfseEnvio' + NameSpaceDad +
                             '<' + Prefixo3 + 'Pedido>' +
                              '<' + Prefixo4 + 'InfPedidoCancelamento' +
                                 NotaUtil.SeSenao(Identificador <> '', ' ' + Identificador + '="' + URI + '"', '') + '>';
   acGerar:       Result := '';
 end;
end;

function TProvedorISSNet.Gera_CabMsg(Prefixo2, VersaoLayOut, VersaoDados,
  NameSpaceCab: String): AnsiString;
begin
 Result := '<' + Prefixo2 + 'cabecalho versao="'  + VersaoLayOut + '"' + NameSpaceCab +
            '<versaoDados>' + VersaoDados + '</versaoDados>'+
           '</' + Prefixo2 + 'cabecalho>';
end;

function TProvedorISSNet.Gera_DadosSenha(CNPJ, Senha: String): AnsiString;
begin
 Result := '';
end;

function TProvedorISSNet.Gera_TagF(Acao: TnfseAcao; Prefixo3: String): AnsiString;
begin
 case Acao of
   acRecepcionar: Result := '</' + Prefixo3 + 'EnviarLoteRpsEnvio>';
   acConsSit:     Result := '</' + Prefixo3 + 'ConsultarSituacaoLoteRpsEnvio>';
   acConsLote:    Result := '</' + Prefixo3 + 'ConsultarLoteRpsEnvio>';
   acConsNFSeRps: Result := '</' + Prefixo3 + 'ConsultarNfseRpsEnvio>';
   acConsNFSe:    Result := '</' + Prefixo3 + 'ConsultarNfseEnvio>';
   acCancelar:    Result := '</' + Prefixo3 + 'Pedido>' +
                            '</' + Prefixo3 + 'CancelarNfseEnvio>';
   acGerar:       Result := '';
 end;
end;

function TProvedorISSNet.Gera_DadosMsgEnviarLote(Prefixo3, Prefixo4,
  Identificador, NameSpaceDad, VersaoDados, VersaoXML, NumeroLote, CNPJ,
  IM, QtdeNotas: String; Notas, TagI, TagF: AnsiString): AnsiString;
var
 DadosMsg: AnsiString;
begin
 DadosMsg := '<' + Prefixo3 + 'LoteRps'+
               NotaUtil.SeSenao(Identificador <> '', ' ' + Identificador + '="' + NumeroLote + '"', '') + '>' +
              '<' + Prefixo4 + 'NumeroLote>' +
                NumeroLote +
              '</' + Prefixo4 + 'NumeroLote>' +

              NotaUtil.SeSenao(VersaoXML = '1',

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
             '</' + Prefixo3 + 'LoteRps>';

  Result := TagI + DadosMsg + TagF;
end;

function TProvedorISSNet.Gera_DadosMsgConsSitLote(Prefixo3, Prefixo4,
  NameSpaceDad, VersaoXML, Protocolo, CNPJ, IM: String; TagI,
  TagF: AnsiString): AnsiString;
var
 DadosMsg: AnsiString;
begin
 DadosMsg := '<' + Prefixo3 + 'Prestador>' +

               NotaUtil.SeSenao(VersaoXML = '1',

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
              '</' + Prefixo3 + 'Prestador>' +
              '<' + Prefixo3 + 'Protocolo>' +
                Protocolo +
              '</' + Prefixo3 + 'Protocolo>';

 Result := TagI + DadosMsg + TagF;
end;

function TProvedorISSNet.Gera_DadosMsgConsLote(Prefixo3, Prefixo4,
  NameSpaceDad, VersaoXML, Protocolo, CNPJ, IM: String; TagI,
  TagF: AnsiString): AnsiString;
var
 DadosMsg: AnsiString;
begin
 DadosMsg := '<' + Prefixo3 + 'Prestador>' +

               NotaUtil.SeSenao(VersaoXML = '1',

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
              '</' + Prefixo3 + 'Prestador>' +
              '<' + Prefixo3 + 'Protocolo>' +
                Protocolo +
              '</' + Prefixo3 + 'Protocolo>';

 Result := TagI + DadosMsg + TagF;
end;

function TProvedorISSNet.Gera_DadosMsgConsNFSeRPS(Prefixo3, Prefixo4,
  VersaoXML, NumeroRps, SerieRps, TipoRps, CNPJ, IM: String; TagI,
  TagF: AnsiString): AnsiString;
var
 DadosMsg: AnsiString;
begin
 DadosMsg := '<' + Prefixo3 + 'IdentificacaoRps>' +
              '<' + Prefixo4 + 'Numero>' +
                NumeroRps +
              '</' + Prefixo4 + 'Numero>' +
              '<' + Prefixo4 + 'Serie>' +
                SerieRps +
              '</' + Prefixo4 + 'Serie>' +
              '<' + Prefixo4 + 'Tipo>' +
                TipoRps +
              '</' + Prefixo4 + 'Tipo>' +
             '</' + Prefixo3 + 'IdentificacaoRps>' +
             '<' + Prefixo3 + 'Prestador>' +

              NotaUtil.SeSenao(VersaoXML = '1',

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
             '</' + Prefixo3 + 'Prestador>';

 Result := TagI + DadosMsg + TagF;
end;

function TProvedorISSNet.Gera_DadosMsgConsNFSe(Prefixo3, Prefixo4,
  VersaoXML, CNPJ, IM: String; DataInicial, DataFinal: TDateTime; TagI,
  TagF: AnsiString): AnsiString;
var
 DadosMsg: AnsiString;
begin
 DadosMsg := '<' + Prefixo3 + 'Prestador>' +

               NotaUtil.SeSenao(VersaoXML = '1',

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
              '</' + Prefixo3 + 'Prestador>';

 if (DataInicial>0) and (DataFinal>0)
  then DadosMsg := DadosMsg + '<' + Prefixo3 + 'PeriodoEmissao>' +
                               '<' + Prefixo3 + 'DataInicial>' +
                                 FormatDateTime('yyyy-mm-dd', DataInicial) +
                               '</' + Prefixo3 + 'DataInicial>' +
                               '<' + Prefixo3 + 'DataFinal>' +
                                 FormatDateTime('yyyy-mm-dd', DataFinal) +
                               '</' + Prefixo3 + 'DataFinal>' +
                              '</' + Prefixo3 + 'PeriodoEmissao>';

 Result := TagI + DadosMsg + TagF;
end;

function TProvedorISSNet.Gera_DadosMsgCancelarNFSe(Prefixo4, NumeroNFSe,
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

function TProvedorISSNet.Gera_DadosMsgGerarNFSe(Prefixo3, Prefixo4,
  Identificador, NameSpaceDad, VersaoDados, VersaoXML, NumeroLote, CNPJ,
  IM, QtdeNotas: String; Notas, TagI, TagF: AnsiString): AnsiString;
begin
 Result := '';
end;

function TProvedorISSNet.GeraEnvelopeRecepcionarLoteRPS(URLNS: String;
  CabMsg, DadosMsg, DadosSenha: AnsiString): AnsiString;
begin
 result := '<?xml version="1.0" encoding="utf-8"?>' +
           '<S:Envelope xmlns:S="http://schemas.xmlsoap.org/soap/envelope/" ' +
                       'xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" ' +
                       'xmlns:xsd="http://www.w3.org/2001/XMLSchema">' +
            '<S:Body>' +
             '<RecepcionarLoteRps xmlns="' + URLNS + '">' +
              '<xml>' +
                '&lt;?xml version="1.0" encoding="utf-8"?&gt;' +
                StringReplace(StringReplace(DadosMsg, '<', '&lt;', [rfReplaceAll]), '>', '&gt;', [rfReplaceAll]) +
              '</xml>' +
             '</RecepcionarLoteRps>' +
            '</S:Body>' +
           '</S:Envelope>';
end;

function TProvedorISSNet.GeraEnvelopeConsultarSituacaoLoteRPS(
  URLNS: String; CabMsg, DadosMsg, DadosSenha: AnsiString): AnsiString;
begin
 result := '<?xml version="1.0" encoding="utf-8"?>' +
           '<s:Envelope xmlns:s="http://schemas.xmlsoap.org/soap/envelope/" ' +
                       'xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" ' +
                       'xmlns:xsd="http://www.w3.org/2001/XMLSchema">' +
            '<s:Body>' +
             '<ConsultaSituacaoLoteRPS xmlns="' + URLNS + '">' +
              '<xml>' +
                '&lt;?xml version="1.0" encoding="utf-8"?&gt;' +
                StringReplace(StringReplace(DadosMsg, '<', '&lt;', [rfReplaceAll]), '>', '&gt;', [rfReplaceAll]) +
              '</xml>' +
             '</ConsultaSituacaoLoteRPS>' +
            '</s:Body>' +
           '</s:Envelope>';
end;

function TProvedorISSNet.GeraEnvelopeConsultarLoteRPS(URLNS: String;
  CabMsg, DadosMsg, DadosSenha: AnsiString): AnsiString;
begin
 result := '<?xml version="1.0" encoding="utf-8"?>' +
           '<s:Envelope xmlns:s="http://schemas.xmlsoap.org/soap/envelope/" ' +
                       'xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" ' +
                       'xmlns:xsd="http://www.w3.org/2001/XMLSchema">' +
            '<s:Body>' +
             '<ConsultarLoteRps xmlns="' + URLNS + '">' +
              '<xml>' +
                '&lt;?xml version="1.0" encoding="utf-8"?&gt;' +
                StringReplace(StringReplace(DadosMsg, '<', '&lt;', [rfReplaceAll]), '>', '&gt;', [rfReplaceAll]) +
              '</xml>' +
             '</ConsultarLoteRps>' +
            '</s:Body>' +
           '</s:Envelope>';
end;

function TProvedorISSNet.GeraEnvelopeConsultarNFSeporRPS(URLNS: String;
  CabMsg, DadosMsg, DadosSenha: AnsiString): AnsiString;
begin
 result := '<?xml version="1.0" encoding="utf-8"?>' +
           '<s:Envelope xmlns:s="http://schemas.xmlsoap.org/soap/envelope/" ' +
                       'xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" ' +
                       'xmlns:xsd="http://www.w3.org/2001/XMLSchema">' +
            '<s:Body>' +
             '<ConsultarNFSePorRPS xmlns="' + URLNS + '">' +
              '<xml>' +
                '&lt;?xml version="1.0" encoding="utf-8"?&gt;' +
                StringReplace(StringReplace(DadosMsg, '<', '&lt;', [rfReplaceAll]), '>', '&gt;', [rfReplaceAll]) +
              '</xml>' +
             '</ConsultarNFSePorRPS>' +
            '</s:Body>' +
           '</s:Envelope>';
end;

function TProvedorISSNet.GeraEnvelopeConsultarNFSe(URLNS: String; CabMsg,
  DadosMsg, DadosSenha: AnsiString): AnsiString;
begin
 result := '<?xml version="1.0" encoding="utf-8"?>' +
           '<s:Envelope xmlns:s="http://schemas.xmlsoap.org/soap/envelope/" ' +
                       'xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" ' +
                       'xmlns:xsd="http://www.w3.org/2001/XMLSchema">' +
            '<s:Body>' +
             '<ConsultarNfse xmlns="' + URLNS + '">' +
              '<xml>' +
                '&lt;?xml version="1.0" encoding="utf-8"?&gt;' +
                StringReplace(StringReplace(DadosMsg, '<', '&lt;', [rfReplaceAll]), '>', '&gt;', [rfReplaceAll]) +
              '</xml>' +
             '</ConsultarNfse>' +
            '</s:Body>' +
           '</s:Envelope>';
end;

function TProvedorISSNet.GeraEnvelopeCancelarNFSe(URLNS: String; CabMsg,
  DadosMsg, DadosSenha: AnsiString): AnsiString;
begin
 result := '<?xml version="1.0" encoding="utf-8"?>' +
           '<s:Envelope xmlns:s="http://schemas.xmlsoap.org/soap/envelope/" ' +
                       'xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" ' +
                       'xmlns:xsd="http://www.w3.org/2001/XMLSchema">' +
            '<s:Body>' +
             '<CancelarNfse xmlns="' + URLNS + '">' +
              '<xml>' +
                '&lt;?xml version="1.0" encoding="utf-8"?&gt;' +
                StringReplace(StringReplace(DadosMsg, '<', '&lt;', [rfReplaceAll]), '>', '&gt;', [rfReplaceAll]) +
              '</xml>' +
             '</CancelarNfse>' +
            '</s:Body>' +
           '</s:Envelope>';
end;

function TProvedorISSNet.GeraEnvelopeGerarNFSe(URLNS: String; CabMsg,
  DadosMsg, DadosSenha: AnsiString): AnsiString;
begin
 Result := '';
 raise Exception.Create( 'Opção não implementada para este provedor.' );
end;

function TProvedorISSNet.GetSoapAction(Acao: TnfseAcao; NomeCidade: String): String;
begin
 case Acao of
   acRecepcionar: Result := 'http://www.issnetonline.com.br/webservice/nfd/RecepcionarLoteRps';
   acConsSit:     Result := 'http://www.issnetonline.com.br/webservice/nfd/ConsultaSituacaoLoteRPS';
   acConsLote:    Result := 'http://www.issnetonline.com.br/webservice/nfd/ConsultarLoteRps';
   acConsNFSeRps: Result := 'http://www.issnetonline.com.br/webservice/nfd/ConsultarNFSePorRPS';
   acConsNFSe:    Result := 'http://www.issnetonline.com.br/webservice/nfd/ConsultarNfse';
   acCancelar:    Result := 'http://www.issnetonline.com.br/webservice/nfd/CancelarNfse';
   acGerar:       Result := '';
 end;
end;

function TProvedorISSNet.GetRetornoWS(Acao: TnfseAcao; RetornoWS: AnsiString): AnsiString;
var
 RetWS: AnsiString;
begin
 case Acao of
   acRecepcionar: begin
                   RetWS  := SeparaDados( RetornoWS, 'RecepcionarLoteRpsResult' );
                   RetWS  := StringReplace( RetWS, ' xmlns="http://www.issnetonline.com.br/webserviceabrasf/vsd/servico_enviar_lote_rps_resposta.xsd"', '', [rfReplaceAll] );
                   RetWS  := StringReplace( RetWS, ' xmlns="http://www.issnetonline.com.br/webserviceabrasf/vsd/tipos_complexos.xsd"', '', [rfReplaceAll] );
                   Result := RetWS;
                  end;
   acConsSit:     begin
                   RetWS  := SeparaDados( RetornoWS, 'ConsultaSituacaoLoteRPSResult' );
                   RetWS  := StringReplace( RetWS, ' xmlns="http://www.issnetonline.com.br/webserviceabrasf/vsd/servico_consultar_situacao_lote_rps_resposta.xsd"', '', [rfReplaceAll] );
                   RetWS  := StringReplace( RetWS, ' xmlns="http://www.issnetonline.com.br/webserviceabrasf/vsd/tipos_complexos.xsd"', '', [rfReplaceAll] );
                   Result := RetWS;
                  end;
   acConsLote:    begin
                   RetWS  := SeparaDados( RetornoWS, 'ConsultarLoteRpsResult' );
                   RetWS  := StringReplace( RetWS, ' xmlns="http://www.issnetonline.com.br/webserviceabrasf/vsd/servico_consultar_lote_rps_resposta.xsd"', '', [rfReplaceAll] );
                   RetWS  := StringReplace( RetWS, ' xmlns="http://www.issnetonline.com.br/webserviceabrasf/vsd/tipos_complexos.xsd"', '', [rfReplaceAll] );
                   Result := RetWS;
                  end;
   acConsNFSeRps: begin
                   RetWS  := SeparaDados( RetornoWS, 'ConsultarNFSePorRPSResult' );
                   RetWS  := StringReplace( RetWS, ' xmlns="http://www.issnetonline.com.br/webserviceabrasf/vsd/servico_consultar_nfse_rps_resposta.xsd"', '', [rfReplaceAll] );
                   RetWS  := StringReplace( RetWS, ' xmlns="http://www.issnetonline.com.br/webserviceabrasf/vsd/tipos_complexos.xsd"', '', [rfReplaceAll] );
                   Result := RetWS;
                  end;
   acConsNFSe:    begin
                   RetWS  := SeparaDados( RetornoWS, 'ConsultarNfseResult' );
                   RetWS  := StringReplace( RetWS, ' xmlns="http://www.issnetonline.com.br/webserviceabrasf/vsd/servico_consultar_nfse_resposta.xsd"', '', [rfReplaceAll] );
                   RetWS  := StringReplace( RetWS, ' xmlns="http://www.issnetonline.com.br/webserviceabrasf/vsd/tipos_complexos.xsd"', '', [rfReplaceAll] );
                   Result := RetWS;
                  end;
   acCancelar:    begin
                   RetWS  := SeparaDados( RetornoWS, 'CancelarNfseResult' );
                   RetWS  := StringReplace( RetWS, ' xmlns="http://www.issnetonline.com.br/webserviceabrasf/vsd/servico_cancelar_nfse_resposta.xsd"', '', [rfReplaceAll] );
                   RetWS  := StringReplace( RetWS, ' xmlns="http://www.issnetonline.com.br/webserviceabrasf/vsd/tipos_complexos.xsd"', '', [rfReplaceAll] );
                   Result :=RetWS;
                  end;
   acGerar:       Result := '';
 end;
end;

function TProvedorISSNet.GeraRetornoNFSe(Prefixo: String;
  RetNFSe: AnsiString; NomeCidade: String): AnsiString;
begin
 Result := '<?xml version="1.0" encoding="utf-8"?>' +
           '<CompNfse xmlns:tc="http://www.issnetonline.com.br/webserviceabrasf/vsd/tipos_complexos.xsd">' +
             RetNfse +
           '</CompNfse>';
end;

end.
