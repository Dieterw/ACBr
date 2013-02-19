{$I ACBr.inc}

unit ACBrProvedorSimplISS;

interface

uses
  Classes, SysUtils,
  pnfsConversao, pcnAuxiliar,
  ACBrNFSeConfiguracoes, ACBrNFSeUtil, ACBrUtil, ACBrDFeUtil,
  {$IFDEF COMPILER6_UP} DateUtils {$ELSE} ACBrD5, FileCtrl {$ENDIF};

type
  { TACBrProvedorSimplISS }

 TProvedorSimplISS = class(TProvedorClass)
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

{ TProvedorSimplISS }

constructor TProvedorSimplISS.Create;
begin
 {----}
end;

function TProvedorSimplISS.GetConfigCidade(ACodCidade,
  AAmbiente: Integer): TConfigCidade;
var
 ConfigCidade: TConfigCidade;
begin
 ConfigCidade.VersaoSoap    := '1.1';
 ConfigCidade.CodigoSchemas := 6;
 case ACodCidade of
  3148103: ConfigCidade.CodigoURLs := 1; // Patrocinio/MG
  3503307: ConfigCidade.CodigoURLs := 2; // Araras/SP
  3541406: ConfigCidade.CodigoURLs := 3; // Presidente Prudente/SP
 end;
 ConfigCidade.Prefixo2      := '';
 ConfigCidade.Prefixo3      := '';
 ConfigCidade.Prefixo4      := '';
 ConfigCidade.Identificador := 'id';

 if AAmbiente = 1
  then ConfigCidade.NameSpaceEnvelope := 'http://www.sistema.com.br/Sistema.Ws.Nfse'
  else ConfigCidade.NameSpaceEnvelope := 'http://www.sistema.com.br/Sistema.Ws.Nfse';

 ConfigCidade.AssinaRPS  := False;
 ConfigCidade.AssinaLote := False;

 Result := ConfigCidade;
end;

function TProvedorSimplISS.GetConfigSchema(ACodCidade: Integer): TConfigSchema;
var
 ConfigSchema: TConfigSchema;
begin
 ConfigSchema.VersaoCabecalho := '1.00';
 ConfigSchema.VersaoDados     := '1.00';
 ConfigSchema.VersaoXML       := '2';
 ConfigSchema.NameSpaceXML    := 'http://www.sistema.com.br/Nfse/arquivos/';
 ConfigSchema.Cabecalho       := 'nfse_3.xsd';
 ConfigSchema.ServicoEnviar   := 'nfse_3.xsd';
 ConfigSchema.ServicoConSit   := 'nfse_3.xsd';
 ConfigSchema.ServicoConLot   := 'nfse_3.xsd';
 ConfigSchema.ServicoConRps   := 'nfse_3.xsd';
 ConfigSchema.ServicoConNfse  := 'nfse_3.xsd';
 ConfigSchema.ServicoCancelar := 'nfse_3.xsd';
 ConfigSchema.DefTipos        := '';

 Result := ConfigSchema;
end;

function TProvedorSimplISS.GetConfigURL(ACodCidade: Integer): TConfigURL;
var
 ConfigURL: TConfigURL;
begin
 if ACodCidade = 3503307
  then begin
   ConfigURL.HomNomeCidade         := '';
   ConfigURL.HomRecepcaoLoteRPS    := 'http://200.144.16.82:8080/ws_homologacao/nfseservice.svc';
   ConfigURL.HomConsultaLoteRPS    := 'http://200.144.16.82:8080/ws_homologacao/nfseservice.svc';
   ConfigURL.HomConsultaNFSeRPS    := 'http://200.144.16.82:8080/ws_homologacao/nfseservice.svc';
   ConfigURL.HomConsultaSitLoteRPS := 'http://200.144.16.82:8080/ws_homologacao/nfseservice.svc';
   ConfigURL.HomConsultaNFSe       := 'http://200.144.16.82:8080/ws_homologacao/nfseservice.svc';
   ConfigURL.HomCancelaNFSe        := 'http://200.144.16.82:8080/ws_homologacao/nfseservice.svc';
  end
  else begin
   ConfigURL.HomNomeCidade         := '';
   ConfigURL.HomRecepcaoLoteRPS    := 'http://187.45.245.217/ws_nfse/nfseservice.svc';
   ConfigURL.HomConsultaLoteRPS    := 'http://187.45.245.217/ws_nfse/nfseservice.svc';
   ConfigURL.HomConsultaNFSeRPS    := 'http://187.45.245.217/ws_nfse/nfseservice.svc';
   ConfigURL.HomConsultaSitLoteRPS := 'http://187.45.245.217/ws_nfse/nfseservice.svc';
   ConfigURL.HomConsultaNFSe       := 'http://187.45.245.217/ws_nfse/nfseservice.svc';
   ConfigURL.HomCancelaNFSe        := 'http://187.45.245.217/ws_nfse/nfseservice.svc';
  end;

 case ACodCidade of
  3148103: begin
            ConfigURL.ProNomeCidade := 'patrocinio';
            ConfigURL.ProRecepcaoLoteRPS    := 'http://187.45.245.217/ws_' + ConfigURL.ProNomeCidade + '/nfseservice.svc';
            ConfigURL.ProConsultaLoteRPS    := 'http://187.45.245.217/ws_' + ConfigURL.ProNomeCidade + '/nfseservice.svc';
            ConfigURL.ProConsultaNFSeRPS    := 'http://187.45.245.217/ws_' + ConfigURL.ProNomeCidade + '/nfseservice.svc';
            ConfigURL.ProConsultaSitLoteRPS := 'http://187.45.245.217/ws_' + ConfigURL.ProNomeCidade + '/nfseservice.svc';
            ConfigURL.ProConsultaNFSe       := 'http://187.45.245.217/ws_' + ConfigURL.ProNomeCidade + '/nfseservice.svc';
            ConfigURL.ProCancelaNFSe        := 'http://187.45.245.217/ws_' + ConfigURL.ProNomeCidade + '/nfseservice.svc';
           end;
  3503307: begin
            ConfigURL.ProNomeCidade := 'araras';
            ConfigURL.ProRecepcaoLoteRPS    := 'http://200.144.16.82:8080/ws_' + ConfigURL.ProNomeCidade + '/nfseservice.svc';
            ConfigURL.ProConsultaLoteRPS    := 'http://200.144.16.82:8080/ws_' + ConfigURL.ProNomeCidade + '/nfseservice.svc';
            ConfigURL.ProConsultaNFSeRPS    := 'http://200.144.16.82:8080/ws_' + ConfigURL.ProNomeCidade + '/nfseservice.svc';
            ConfigURL.ProConsultaSitLoteRPS := 'http://200.144.16.82:8080/ws_' + ConfigURL.ProNomeCidade + '/nfseservice.svc';
            ConfigURL.ProConsultaNFSe       := 'http://200.144.16.82:8080/ws_' + ConfigURL.ProNomeCidade + '/nfseservice.svc';
            ConfigURL.ProCancelaNFSe        := 'http://200.144.16.82:8080/ws_' + ConfigURL.ProNomeCidade + '/nfseservice.svc';
           end;
  3541406: begin
            ConfigURL.ProNomeCidade := 'presidente_prudente';
            ConfigURL.ProRecepcaoLoteRPS    := 'http://187.45.245.217/ws_nfse_' + ConfigURL.ProNomeCidade + '/nfseservice.svc';
            ConfigURL.ProConsultaLoteRPS    := 'http://187.45.245.217/ws_nfse_' + ConfigURL.ProNomeCidade + '/nfseservice.svc';
            ConfigURL.ProConsultaNFSeRPS    := 'http://187.45.245.217/ws_nfse_' + ConfigURL.ProNomeCidade + '/nfseservice.svc';
            ConfigURL.ProConsultaSitLoteRPS := 'http://187.45.245.217/ws_nfse_' + ConfigURL.ProNomeCidade + '/nfseservice.svc';
            ConfigURL.ProConsultaNFSe       := 'http://187.45.245.217/ws_nfse_' + ConfigURL.ProNomeCidade + '/nfseservice.svc';
            ConfigURL.ProCancelaNFSe        := 'http://187.45.245.217/ws_nfse_' + ConfigURL.ProNomeCidade + '/nfseservice.svc';
           end;
  3549102: begin
            ConfigURL.ProNomeCidade := 'sao_joao_boa_vista';
            ConfigURL.ProRecepcaoLoteRPS    := 'http://187.45.245.217/ws_nfse_' + ConfigURL.ProNomeCidade + '/nfseservice.svc';
            ConfigURL.ProConsultaLoteRPS    := 'http://187.45.245.217/ws_nfse_' + ConfigURL.ProNomeCidade + '/nfseservice.svc';
            ConfigURL.ProConsultaNFSeRPS    := 'http://187.45.245.217/ws_nfse_' + ConfigURL.ProNomeCidade + '/nfseservice.svc';
            ConfigURL.ProConsultaSitLoteRPS := 'http://187.45.245.217/ws_nfse_' + ConfigURL.ProNomeCidade + '/nfseservice.svc';
            ConfigURL.ProConsultaNFSe       := 'http://187.45.245.217/ws_nfse_' + ConfigURL.ProNomeCidade + '/nfseservice.svc';
            ConfigURL.ProCancelaNFSe        := 'http://187.45.245.217/ws_nfse_' + ConfigURL.ProNomeCidade + '/nfseservice.svc';
           end;
  3549706: begin
            ConfigURL.ProNomeCidade := 'sao_jose_rio_pardo';
            ConfigURL.ProRecepcaoLoteRPS    := 'http://187.45.245.217/ws_' + ConfigURL.ProNomeCidade + '/nfseservice.svc';
            ConfigURL.ProConsultaLoteRPS    := 'http://187.45.245.217/ws_' + ConfigURL.ProNomeCidade + '/nfseservice.svc';
            ConfigURL.ProConsultaNFSeRPS    := 'http://187.45.245.217/ws_' + ConfigURL.ProNomeCidade + '/nfseservice.svc';
            ConfigURL.ProConsultaSitLoteRPS := 'http://187.45.245.217/ws_' + ConfigURL.ProNomeCidade + '/nfseservice.svc';
            ConfigURL.ProConsultaNFSe       := 'http://187.45.245.217/ws_' + ConfigURL.ProNomeCidade + '/nfseservice.svc';
            ConfigURL.ProCancelaNFSe        := 'http://187.45.245.217/ws_' + ConfigURL.ProNomeCidade + '/nfseservice.svc';
           end;
  3556404: begin
            ConfigURL.ProNomeCidade := 'vargem_grande_sul';
            ConfigURL.ProRecepcaoLoteRPS    := 'http://187.45.245.217/ws_nfse_' + ConfigURL.ProNomeCidade + '/nfseservice.svc';
            ConfigURL.ProConsultaLoteRPS    := 'http://187.45.245.217/ws_nfse_' + ConfigURL.ProNomeCidade + '/nfseservice.svc';
            ConfigURL.ProConsultaNFSeRPS    := 'http://187.45.245.217/ws_nfse_' + ConfigURL.ProNomeCidade + '/nfseservice.svc';
            ConfigURL.ProConsultaSitLoteRPS := 'http://187.45.245.217/ws_nfse_' + ConfigURL.ProNomeCidade + '/nfseservice.svc';
            ConfigURL.ProConsultaNFSe       := 'http://187.45.245.217/ws_nfse_' + ConfigURL.ProNomeCidade + '/nfseservice.svc';
            ConfigURL.ProCancelaNFSe        := 'http://187.45.245.217/ws_nfse_' + ConfigURL.ProNomeCidade + '/nfseservice.svc';
           end;
 end;

 Result := ConfigURL;
end;

function TProvedorSimplISS.GetURI(URI: String): String;
begin
 // No provedor SimplISS a URI não é informada.
 Result := '';
end;

function TProvedorSimplISS.GetAssinarXML(Acao: TnfseAcao): Boolean;
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

function TProvedorSimplISS.GetValidarLote: Boolean;
begin
 Result :=False;
end;

function TProvedorSimplISS.Gera_TagI(Acao: TnfseAcao; Prefixo3, Prefixo4,
  NameSpaceDad, Identificador, URI: String): AnsiString;
begin
 case Acao of
   acRecepcionar: Result := '<' + Prefixo3 + 'EnviarLoteRpsEnvio>';
   acConsSit:     Result := '<' + Prefixo3 + 'ConsultarSituacaoLoteRpsEnvio>';
   acConsLote:    Result := '<' + Prefixo3 + 'ConsultarLoteRpsEnvio>';
   acConsNFSeRps: Result := '<' + Prefixo3 + 'ConsultarNfseRpsEnvio>';
   acConsNFSe:    Result := '<' + Prefixo3 + 'ConsultarNfseEnvio>';
   acCancelar:    Result := '<' + Prefixo3 + 'CancelarNfseEnvio>' +
                             '<' + Prefixo3 + 'Pedido ' + NameSpaceDad +
                              '<' + Prefixo4 + 'InfPedidoCancelamento' +
                                 DFeUtil.SeSenao(Identificador <> '', ' ' + Identificador + '="' + URI + '"', '') + '>';
   acGerar:       Result := '';
 end;
end;

function TProvedorSimplISS.Gera_CabMsg(Prefixo2, VersaoLayOut, VersaoDados,
  NameSpaceCab: String): AnsiString;
begin
 Result := '<' + Prefixo2 + 'cabecalho versao="'  + VersaoLayOut + '"' + NameSpaceCab +
            '<versaoDados>' + VersaoDados + '</versaoDados>'+
           '</' + Prefixo2 + 'cabecalho>';
end;

function TProvedorSimplISS.Gera_DadosSenha(CNPJ, Senha: String): AnsiString;
begin
 Result := '<P1 xmlns="http://www.sistema.com.br/Sistema.Ws.Nfse.Cn">' +
             SomenteNumeros(CNPJ) +
           '</P1>' +
           '<P2 xmlns="http://www.sistema.com.br/Sistema.Ws.Nfse.Cn">' +
             Senha +
           '</P2>';
end;

function TProvedorSimplISS.Gera_TagF(Acao: TnfseAcao; Prefixo3: String): AnsiString;
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

function TProvedorSimplISS.Gera_DadosMsgEnviarLote(Prefixo3, Prefixo4,
  Identificador, NameSpaceDad, VersaoDados, VersaoXML, NumeroLote, CNPJ,
  IM, QtdeNotas: String; Notas, TagI, TagF: AnsiString): AnsiString;
var
 DadosMsg: AnsiString;
begin
 DadosMsg := '<' + Prefixo3 + 'LoteRps'+
               DFeUtil.SeSenao(Identificador <> '', ' ' + Identificador + '="' +
                                 NumeroLote + '"', '') + NameSpaceDad +
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
             '</' + Prefixo3 + 'LoteRps>';

  Result := TagI + DadosMsg + TagF;
end;

function TProvedorSimplISS.Gera_DadosMsgConsSitLote(Prefixo3, Prefixo4,
  NameSpaceDad, VersaoXML, Protocolo, CNPJ, IM: String; TagI,
  TagF: AnsiString): AnsiString;
var
 DadosMsg: AnsiString;
begin
 DadosMsg := '<' + Prefixo3 + 'Prestador ' + NameSpaceDad +

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
              '</' + Prefixo3 + 'Prestador>' +
              '<' + Prefixo3 + 'Protocolo ' + NameSpaceDad +
                Protocolo +
              '</' + Prefixo3 + 'Protocolo>';

 Result := TagI + DadosMsg + TagF;
end;

function TProvedorSimplISS.Gera_DadosMsgConsLote(Prefixo3, Prefixo4,
  NameSpaceDad, VersaoXML, Protocolo, CNPJ, IM: String; TagI,
  TagF: AnsiString): AnsiString;
var
 DadosMsg: AnsiString;
begin
 DadosMsg := '<' + Prefixo3 + 'Prestador ' + NameSpaceDad +

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
              '</' + Prefixo3 + 'Prestador>' +
              '<' + Prefixo3 + 'Protocolo ' + NameSpaceDad +
                Protocolo +
              '</' + Prefixo3 + 'Protocolo>';

 Result := TagI + DadosMsg + TagF;
end;

function TProvedorSimplISS.Gera_DadosMsgConsNFSeRPS(Prefixo3, Prefixo4,
  NameSpaceDad, VersaoXML, NumeroRps, SerieRps, TipoRps, CNPJ, IM: String; TagI,
  TagF: AnsiString): AnsiString;
var
 DadosMsg: AnsiString;
begin
 DadosMsg := '<' + Prefixo3 + 'IdentificacaoRps ' + NameSpaceDad +
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
             '<' + Prefixo3 + 'Prestador ' + NameSpaceDad +

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
             '</' + Prefixo3 + 'Prestador>';

 Result := TagI + DadosMsg + TagF;
end;

function TProvedorSimplISS.Gera_DadosMsgConsNFSe(Prefixo3, Prefixo4,
  NameSpaceDad, VersaoXML, CNPJ, IM: String; DataInicial, DataFinal: TDateTime; TagI,
  TagF: AnsiString; NumeroNFSe: string = ''): AnsiString;
var
 DadosMsg: AnsiString;
begin
 DadosMsg := '<' + Prefixo3 + 'Prestador>' +

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
              '</' + Prefixo3 + 'Prestador>';

 if NumeroNFSe <> ''
  then DadosMsg := DadosMsg + '<' + Prefixo3 + 'NumeroNfse>' +
                               NumeroNFSe +
                              '</' + Prefixo3 + 'NumeroNfse>';

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

function TProvedorSimplISS.Gera_DadosMsgCancelarNFSe(Prefixo4, NameSpaceDad, NumeroNFSe,
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

function TProvedorSimplISS.Gera_DadosMsgGerarNFSe(Prefixo3, Prefixo4,
  Identificador, NameSpaceDad, VersaoDados, VersaoXML, NumeroLote, CNPJ,
  IM, QtdeNotas: String; Notas, TagI, TagF: AnsiString): AnsiString;
begin
 Result := '';
end;

function TProvedorSimplISS.GeraEnvelopeRecepcionarLoteRPS(URLNS: String;
  CabMsg, DadosMsg, DadosSenha: AnsiString): AnsiString;
begin
 result := '<?xml version="1.0" encoding="UTF-8"?>' +
           '<s:Envelope xmlns:s="http://schemas.xmlsoap.org/soap/envelope/" ' +
                       'xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" ' +
                       'xmlns:xsd="http://www.w3.org/2001/XMLSchema">' +
            '<s:Body>' +
             '<RecepcionarLoteRps xmlns="' + URLNS + '">' +
                DadosMsg +
              '<pParam>' +
                DadosSenha +
              '</pParam>' +
             '</RecepcionarLoteRps>' +
            '</s:Body>' +
           '</s:Envelope>';
end;

function TProvedorSimplISS.GeraEnvelopeConsultarSituacaoLoteRPS(
  URLNS: String; CabMsg, DadosMsg, DadosSenha: AnsiString): AnsiString;
begin
 result := '<?xml version="1.0" encoding="UTF-8"?>' +
           '<s:Envelope xmlns:s="http://schemas.xmlsoap.org/soap/envelope/" ' +
                       'xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" ' +
                       'xmlns:xsd="http://www.w3.org/2001/XMLSchema">' +
            '<s:Body>' +
             '<ConsultarSituacaoLoteRps xmlns="' + URLNS + '">' +
               DadosMsg +
             '<pParam>' +
               DadosSenha +
             '</pParam>' +
            '</ConsultarSituacaoLoteRps>' +
            '</s:Body>' +
           '</s:Envelope>';
end;

function TProvedorSimplISS.GeraEnvelopeConsultarLoteRPS(URLNS: String;
  CabMsg, DadosMsg, DadosSenha: AnsiString): AnsiString;
begin
 result := '<?xml version="1.0" encoding="UTF-8"?>' +
           '<s:Envelope xmlns:s="http://schemas.xmlsoap.org/soap/envelope/" ' +
                       'xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" ' +
                       'xmlns:xsd="http://www.w3.org/2001/XMLSchema">' +
            '<s:Body>' +
             '<ConsultarLoteRps xmlns="' + URLNS + '">' +
               DadosMsg +
             '<pParam>' +
               DadosSenha +
             '</pParam>' +
            '</ConsultarLoteRps>' +
            '</s:Body>' +
           '</s:Envelope>';
end;

function TProvedorSimplISS.GeraEnvelopeConsultarNFSeporRPS(URLNS: String;
  CabMsg, DadosMsg, DadosSenha: AnsiString): AnsiString;
begin
 result := '<?xml version="1.0" encoding="UTF-8"?>' +
           '<s:Envelope xmlns:s="http://schemas.xmlsoap.org/soap/envelope/" ' +
                       'xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" ' +
                       'xmlns:xsd="http://www.w3.org/2001/XMLSchema">' +
            '<s:Body>' +
             '<ConsultarNfsePorRps xmlns="' + URLNS + '">' +
               DadosMsg +
             '<pParam>' +
               DadosSenha +
             '</pParam>' +
            '</ConsultarNfsePorRps>' +
            '</s:Body>' +
           '</s:Envelope>';
end;

function TProvedorSimplISS.GeraEnvelopeConsultarNFSe(URLNS: String; CabMsg,
  DadosMsg, DadosSenha: AnsiString): AnsiString;
begin
 result := '<?xml version="1.0" encoding="UTF-8"?>' +
           '<s:Envelope xmlns:s="http://schemas.xmlsoap.org/soap/envelope/" ' +
                       'xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" ' +
                       'xmlns:xsd="http://www.w3.org/2001/XMLSchema">' +
            '<s:Body>' +
             '<ConsultarNfse xmlns="' + URLNS + '">' +
               DadosMsg +
             '<pParam>' +
               DadosSenha +
             '</pParam>' +
            '</ConsultarNfse>' +
            '</s:Body>' +
           '</s:Envelope>';
end;

function TProvedorSimplISS.GeraEnvelopeCancelarNFSe(URLNS: String; CabMsg,
  DadosMsg, DadosSenha: AnsiString): AnsiString;
begin
 result := '<?xml version="1.0" encoding="UTF-8"?>' +
           '<s:Envelope xmlns:s="http://schemas.xmlsoap.org/soap/envelope/" ' +
                       'xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" ' +
                       'xmlns:xsd="http://www.w3.org/2001/XMLSchema">' +
            '<s:Body>' +
             '<CancelarNfse xmlns="' + URLNS + '">' +
               DadosMsg +
             '<pParam>' +
               DadosSenha +
             '</pParam>' +
            '</CancelarNfse>' +
            '</s:Body>' +
           '</s:Envelope>';
end;

function TProvedorSimplISS.GeraEnvelopeGerarNFSe(URLNS: String; CabMsg,
  DadosMsg, DadosSenha: AnsiString): AnsiString;
begin
 Result := '';
 raise Exception.Create( 'Opção não implementada para este provedor.' );
end;

function TProvedorSimplISS.GetSoapAction(Acao: TnfseAcao;
  NomeCidade: String): String;
begin
 case Acao of
   acRecepcionar: Result := 'http://www.sistema.com.br/Sistema.Ws.Nfse/INfseService/RecepcionarLoteRps';
   acConsSit:     Result := 'http://www.sistema.com.br/Sistema.Ws.Nfse/INfseService/ConsultarSituacaoLoteRps';
   acConsLote:    Result := 'http://www.sistema.com.br/Sistema.Ws.Nfse/INfseService/ConsultarLoteRps';
   acConsNFSeRps: Result := 'http://www.sistema.com.br/Sistema.Ws.Nfse/INfseService/ConsultarNfsePorRps';
   acConsNFSe:    Result := 'http://www.sistema.com.br/Sistema.Ws.Nfse/INfseService/ConsultarNfse';
   acCancelar:    Result := 'http://www.sistema.com.br/Sistema.Ws.Nfse/INfseService/CancelarNfse';
   acGerar:       Result := '';
 end;
end;

function TProvedorSimplISS.GetRetornoWS(Acao: TnfseAcao; RetornoWS: AnsiString): AnsiString;
var
 RetWS: AnsiString;
begin
 case Acao of
   acRecepcionar: begin
                   RetWS := SeparaDados( RetornoWS, 'RecepcionarLoteRpsResult' );
                   RetWS := StringReplace(RetWS, ' xmlns="http://www.sistema.com.br/Nfse/arquivos/nfse_3.xsd"', '', [rfReplaceAll]);
                   RetWS := '<EnviarLoteRpsResposta xmlns="http://www.sistema.com.br/Nfse/arquivos/nfse_3.xsd">' +
                              RetWS +
                            '</EnviarLoteRpsResposta>';
                   Result := RetWS;
                  end;
   acConsSit:     begin
                   RetWS := SeparaDados( RetornoWS, 'ConsultarSituacaoLoteRpsResult' );
                   RetWS := StringReplace(RetWS, ' xmlns="http://www.sistema.com.br/Nfse/arquivos/nfse_3.xsd"', '', [rfReplaceAll]);
                   RetWS := '<ConsultarSituacaoLoteRpsResposta xmlns="http://www.sistema.com.br/Nfse/arquivos/nfse_3.xsd">' +
                              RetWS +
                            '</ConsultarSituacaoLoteRpsResposta>';
                   Result := RetWS;
                  end;
   acConsLote:    begin
                   RetWS := SeparaDados( RetornoWS, 'ConsultarLoteRpsResult' );
                   RetWS := StringReplace(RetWS, ' xmlns="http://www.sistema.com.br/Nfse/arquivos/nfse_3.xsd"', '', [rfReplaceAll]);
                   RetWS := '<ConsultarLoteRpsResposta xmlns="http://www.sistema.com.br/Nfse/arquivos/nfse_3.xsd">' +
                              RetWS +
                            '</ConsultarLoteRpsResposta>';
                   Result := RetWS;
                  end;
   acConsNFSeRps: begin
                   RetWS := SeparaDados( RetornoWS, 'ConsultarNfsePorRpsResult' );
                   RetWS := StringReplace(RetWS, ' xmlns="http://www.sistema.com.br/Nfse/arquivos/nfse_3.xsd"', '', [rfReplaceAll]);
                   RetWS := '<ConsultarNfseRpsResposta xmlns="http://www.sistema.com.br/Nfse/arquivos/nfse_3.xsd">' +
                              RetWS +
                            '</ConsultarNfseRpsResposta>';
                   Result := RetWS;
                  end;
   acConsNFSe:    begin
                   RetWS := SeparaDados( RetornoWS, 'ConsultarNfseResult' );
                   RetWS := StringReplace(RetWS, ' xmlns="http://www.sistema.com.br/Nfse/arquivos/nfse_3.xsd"', '', [rfReplaceAll]);
                   RetWS := '<ConsultarNfseResposta xmlns="http://www.sistema.com.br/Nfse/arquivos/nfse_3.xsd">' +
                              RetWS +
                            '</ConsultarNfseResposta>';
                   Result := RetWS;
                  end;
   acCancelar:    begin
                   RetWS := SeparaDados( RetornoWS, 'CancelarNfseResult' );
                   RetWS := StringReplace(RetWS, ' xmlns="http://www.sistema.com.br/Nfse/arquivos/nfse_3.xsd"', '', [rfReplaceAll]);
                   RetWS := '<CancelarNfseResposta xmlns="http://www.sistema.com.br/Nfse/arquivos/nfse_3.xsd">' +
                              RetWS +
                            '</CancelarNfseResposta>';
                   Result := RetWS;
                  end;
   acGerar:       Result := '';
 end;
end;

function TProvedorSimplISS.GeraRetornoNFSe(Prefixo: String;
  RetNFSe: AnsiString; NomeCidade: String): AnsiString;
begin
 Result := '<?xml version="1.0" encoding="UTF-8"?>' +
           '<' + Prefixo + 'CompNfse xmlns="http://www.sistema.com.br/Nfse/arquivos/nfse_3.xsd">' +
             RetNfse +
           '</' + Prefixo + 'CompNfse>';
end;

function TProvedorSimplISS.GetLinkNFSe(ACodMunicipio, ANumeroNFSe: Integer;
  ACodVerificacao: String; AAmbiente: Integer): String;
begin
 Result := '';
end;

end.
