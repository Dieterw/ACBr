{$I ACBr.inc}

unit ACBrProvedorWebISS;

interface

uses
  Classes, SysUtils,
  pnfsConversao, pcnAuxiliar,
  ACBrNFSeConfiguracoes, ACBrNFSeUtil, ACBrUtil,
  {$IFDEF COMPILER6_UP} DateUtils {$ELSE} ACBrD5, FileCtrl {$ENDIF};

type
  { TACBrProvedorGinfes }

 TProvedorWebISS = class(TProvedorClass)
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

constructor TProvedorWebISS.Create;
begin
 {----}
end;

function TProvedorWebISS.GetConfigCidade(ACodigo,
  AAmbiente: Integer): TConfigCidade;
var
 ConfigCidade: TConfigCidade;
begin
 ConfigCidade.VersaoSoap    := '1.1';
 ConfigCidade.CodigoSchemas := 3;
 case ACodigo of
  2910800: ConfigCidade.CodigoURLs := 01; // Feira de Santana/BA
  3104205: ConfigCidade.CodigoURLs := 02; // Arcos/MG
  3126109: ConfigCidade.CodigoURLs := 03; // Formiga/MG
  3170107: ConfigCidade.CodigoURLs := 04; // Uberaba/MG
  3303302: ConfigCidade.CodigoURLs := 05; // Niteroi/RJ
  5107909: ConfigCidade.CodigoURLs := 06; // Sinop/MT
  3105608: ConfigCidade.CodigoURLs := 07; // Barbacena/MG
  3105905: ConfigCidade.CodigoURLs := 08; // Barroso/MG
 end;
 ConfigCidade.Prefixo2      := '';
 ConfigCidade.Prefixo3      := '';
 ConfigCidade.Prefixo4      := '';
 ConfigCidade.Identificador := 'Id';

 if AAmbiente = 1
  then ConfigCidade.NameSpaceEnvelope := 'http://tempuri.org'
  else ConfigCidade.NameSpaceEnvelope := 'http://tempuri.org';

 ConfigCidade.AssinaRPS  := False;
 ConfigCidade.AssinaLote := True;

 Result := ConfigCidade;
end;

function TProvedorWebISS.GetConfigSchema(ACodigo: Integer): TConfigSchema;
var
 ConfigSchema: TConfigSchema;
begin
 ConfigSchema.VersaoCabecalho := '1.00';
 ConfigSchema.VersaoDados     := '1.00';
 ConfigSchema.VersaoXML       := '2';
 ConfigSchema.NameSpaceXML    := 'http://www.abrasf.org.br/';
 ConfigSchema.Cabecalho       := 'nfse.xsd';
 ConfigSchema.ServicoEnviar   := 'nfse.xsd';
 ConfigSchema.ServicoConSit   := 'nfse.xsd';
 ConfigSchema.ServicoConLot   := 'nfse.xsd';
 ConfigSchema.ServicoConRps   := 'nfse.xsd';
 ConfigSchema.ServicoConNfse  := 'nfse.xsd';
 ConfigSchema.ServicoCancelar := 'nfse.xsd';
 ConfigSchema.DefTipos        := '';

 Result := ConfigSchema;
end;

function TProvedorWebISS.GetConfigURL(ACodigo: Integer): TConfigURL;
var
 ConfigURL: TConfigURL;
begin
 case ACodigo of
  01: begin
       ConfigURL.HomNomeCidade         := 'feiradesantanaba';
       ConfigURL.ProNomeCidade         := 'feiradesantanaba';
      end;
  02: begin
       ConfigURL.HomNomeCidade         := 'arcosmg';
       ConfigURL.ProNomeCidade         := 'arcosmg';
      end;
  03: begin
       ConfigURL.HomNomeCidade         := 'formigamg';
       ConfigURL.ProNomeCidade         := 'formigamg';
      end;
  04: begin
       ConfigURL.HomNomeCidade         := 'Uberaba';
       ConfigURL.ProNomeCidade         := 'Uberaba';
      end;
  05: begin
       ConfigURL.HomNomeCidade         := 'rjniteroi';
       ConfigURL.ProNomeCidade         := 'rjniteroi';
      end;
  06: begin
       ConfigURL.HomNomeCidade         := 'sinop';
       ConfigURL.ProNomeCidade         := 'sinop';
      end;
  07:	begin
       ConfigURL.HomNomeCidade         := 'mgbarbacena';
       ConfigURL.ProNomeCidade         := 'mgbarbacena';
      end;
  08: begin
       ConfigURL.HomNomeCidade         := 'barrosomg';
       ConfigURL.ProNomeCidade         := 'barrosomg';
      end;
 end;

 case ACodigo of
  02,
  03,
  04,
  08: begin
       ConfigURL.HomRecepcaoLoteRPS    := 'https://www1.webiss.com.br/' + ConfigURL.HomNomeCidade + '_wsnfse_homolog/NfseServices.svc';
       ConfigURL.HomConsultaLoteRPS    := 'https://www1.webiss.com.br/' + ConfigURL.HomNomeCidade + '_wsnfse_homolog/NfseServices.svc';
       ConfigURL.HomConsultaNFSeRPS    := 'https://www1.webiss.com.br/' + ConfigURL.HomNomeCidade + '_wsnfse_homolog/NfseServices.svc';
       ConfigURL.HomConsultaSitLoteRPS := 'https://www1.webiss.com.br/' + ConfigURL.HomNomeCidade + '_wsnfse_homolog/NfseServices.svc';
       ConfigURL.HomConsultaNFSe       := 'https://www1.webiss.com.br/' + ConfigURL.HomNomeCidade + '_wsnfse_homolog/NfseServices.svc';
       ConfigURL.HomCancelaNFSe        := 'https://www1.webiss.com.br/' + ConfigURL.HomNomeCidade + '_wsnfse_homolog/NfseServices.svc';

       ConfigURL.ProRecepcaoLoteRPS    := 'https://www1.webiss.com.br/' + ConfigURL.ProNomeCidade + '_wsnfse/NfseServices.svc';
       ConfigURL.ProConsultaLoteRPS    := 'https://www1.webiss.com.br/' + ConfigURL.ProNomeCidade + '_wsnfse/NfseServices.svc';
       ConfigURL.ProConsultaNFSeRPS    := 'https://www1.webiss.com.br/' + ConfigURL.ProNomeCidade + '_wsnfse/NfseServices.svc';
       ConfigURL.ProConsultaSitLoteRPS := 'https://www1.webiss.com.br/' + ConfigURL.ProNomeCidade + '_wsnfse/NfseServices.svc';
       ConfigURL.ProConsultaNFSe       := 'https://www1.webiss.com.br/' + ConfigURL.ProNomeCidade + '_wsnfse/NfseServices.svc';
       ConfigURL.ProCancelaNFSe        := 'https://www1.webiss.com.br/' + ConfigURL.ProNomeCidade + '_wsnfse/NfseServices.svc';
      end;
  01,
  05: begin
       ConfigURL.HomRecepcaoLoteRPS    := 'https://www3.webiss.com.br/' + ConfigURL.HomNomeCidade + '_wsnfse_homolog/NfseServices.svc';
       ConfigURL.HomConsultaLoteRPS    := 'https://www3.webiss.com.br/' + ConfigURL.HomNomeCidade + '_wsnfse_homolog/NfseServices.svc';
       ConfigURL.HomConsultaNFSeRPS    := 'https://www3.webiss.com.br/' + ConfigURL.HomNomeCidade + '_wsnfse_homolog/NfseServices.svc';
       ConfigURL.HomConsultaSitLoteRPS := 'https://www3.webiss.com.br/' + ConfigURL.HomNomeCidade + '_wsnfse_homolog/NfseServices.svc';
       ConfigURL.HomConsultaNFSe       := 'https://www3.webiss.com.br/' + ConfigURL.HomNomeCidade + '_wsnfse_homolog/NfseServices.svc';
       ConfigURL.HomCancelaNFSe        := 'https://www3.webiss.com.br/' + ConfigURL.HomNomeCidade + '_wsnfse_homolog/NfseServices.svc';

       ConfigURL.ProRecepcaoLoteRPS    := 'https://www3.webiss.com.br/' + ConfigURL.ProNomeCidade + '_wsnfse/NfseServices.svc';
       ConfigURL.ProConsultaLoteRPS    := 'https://www3.webiss.com.br/' + ConfigURL.ProNomeCidade + '_wsnfse/NfseServices.svc';
       ConfigURL.ProConsultaNFSeRPS    := 'https://www3.webiss.com.br/' + ConfigURL.ProNomeCidade + '_wsnfse/NfseServices.svc';
       ConfigURL.ProConsultaSitLoteRPS := 'https://www3.webiss.com.br/' + ConfigURL.ProNomeCidade + '_wsnfse/NfseServices.svc';
       ConfigURL.ProConsultaNFSe       := 'https://www3.webiss.com.br/' + ConfigURL.ProNomeCidade + '_wsnfse/NfseServices.svc';
       ConfigURL.ProCancelaNFSe        := 'https://www3.webiss.com.br/' + ConfigURL.ProNomeCidade + '_wsnfse/NfseServices.svc';
      end;
  06,
  07: begin
       ConfigURL.HomRecepcaoLoteRPS    := 'https://www.webiss.com.br/' + ConfigURL.HomNomeCidade + '_wsnfse_homolog/NfseServices.svc';
       ConfigURL.HomConsultaLoteRPS    := 'https://www.webiss.com.br/' + ConfigURL.HomNomeCidade + '_wsnfse_homolog/NfseServices.svc';
       ConfigURL.HomConsultaNFSeRPS    := 'https://www.webiss.com.br/' + ConfigURL.HomNomeCidade + '_wsnfse_homolog/NfseServices.svc';
       ConfigURL.HomConsultaSitLoteRPS := 'https://www.webiss.com.br/' + ConfigURL.HomNomeCidade + '_wsnfse_homolog/NfseServices.svc';
       ConfigURL.HomConsultaNFSe       := 'https://www.webiss.com.br/' + ConfigURL.HomNomeCidade + '_wsnfse_homolog/NfseServices.svc';
       ConfigURL.HomCancelaNFSe        := 'https://www.webiss.com.br/' + ConfigURL.HomNomeCidade + '_wsnfse_homolog/NfseServices.svc';

       ConfigURL.ProRecepcaoLoteRPS    := 'https://www.webiss.com.br/' + ConfigURL.ProNomeCidade + '_wsnfse/NfseServices.svc';
       ConfigURL.ProConsultaLoteRPS    := 'https://www.webiss.com.br/' + ConfigURL.ProNomeCidade + '_wsnfse/NfseServices.svc';
       ConfigURL.ProConsultaNFSeRPS    := 'https://www.webiss.com.br/' + ConfigURL.ProNomeCidade + '_wsnfse/NfseServices.svc';
       ConfigURL.ProConsultaSitLoteRPS := 'https://www.webiss.com.br/' + ConfigURL.ProNomeCidade + '_wsnfse/NfseServices.svc';
       ConfigURL.ProConsultaNFSe       := 'https://www.webiss.com.br/' + ConfigURL.ProNomeCidade + '_wsnfse/NfseServices.svc';
       ConfigURL.ProCancelaNFSe        := 'https://www.webiss.com.br/' + ConfigURL.ProNomeCidade + '_wsnfse/NfseServices.svc';
      end;
 end;

 Result := ConfigURL;
end;

function TProvedorWebISS.GetURI(URI: String): String;
begin
 Result := URI;
end;

function TProvedorWebISS.GetAssinarXML(Acao: TnfseAcao): Boolean;
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

function TProvedorWebISS.GetValidarLote: Boolean;
begin
 Result := True;
end;

function TProvedorWebISS.Gera_TagI(Acao: TnfseAcao; Prefixo3, Prefixo4,
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

function TProvedorWebISS.Gera_CabMsg(Prefixo2, VersaoLayOut, VersaoDados,
  NameSpaceCab: String): AnsiString;
begin
 Result := '<' + Prefixo2 + 'cabecalho versao="'  + VersaoLayOut + '"' + NameSpaceCab +
            '<versaoDados>' + VersaoDados + '</versaoDados>'+
           '</' + Prefixo2 + 'cabecalho>';
end;

function TProvedorWebISS.Gera_DadosSenha(CNPJ, Senha: String): AnsiString;
begin
 Result := '';
end;

function TProvedorWebISS.Gera_TagF(Acao: TnfseAcao; Prefixo3: String): AnsiString;
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

function TProvedorWebISS.Gera_DadosMsgEnviarLote(Prefixo3, Prefixo4,
  Identificador, NameSpaceDad, VersaoDados, VersaoXML, NumeroLote, CNPJ,
  IM, QtdeNotas: String; Notas, TagI, TagF: AnsiString): AnsiString;
var
 DadosMsg: AnsiString;
begin
 DadosMsg := '<' + Prefixo3 + 'LoteRps'+
               NotaUtil.SeSenao(Identificador <> '', ' ' + Identificador + '="' + NumeroLote + '"', '') +
               ' versao="' + VersaoDados + '">' +
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

function TProvedorWebISS.Gera_DadosMsgConsSitLote(Prefixo3, Prefixo4,
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

function TProvedorWebISS.Gera_DadosMsgConsLote(Prefixo3, Prefixo4,
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

function TProvedorWebISS.Gera_DadosMsgConsNFSeRPS(Prefixo3, Prefixo4,
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

function TProvedorWebISS.Gera_DadosMsgConsNFSe(Prefixo3, Prefixo4,
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

function TProvedorWebISS.Gera_DadosMsgCancelarNFSe(Prefixo4, NumeroNFSe,
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

function TProvedorWebISS.Gera_DadosMsgGerarNFSe(Prefixo3, Prefixo4,
  Identificador, NameSpaceDad, VersaoDados, VersaoXML, NumeroLote, CNPJ,
  IM, QtdeNotas: String; Notas, TagI, TagF: AnsiString): AnsiString;
begin
 Result := '';
end;

function TProvedorWebISS.GeraEnvelopeRecepcionarLoteRPS(URLNS: String;
  CabMsg, DadosMsg, DadosSenha: AnsiString): AnsiString;
begin
 result := '<?xml version="1.0" encoding="utf-8"?>' +
           '<S:Envelope xmlns:S="http://schemas.xmlsoap.org/soap/envelope/" ' +
                       'xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" ' +
                       'xmlns:xsd="http://www.w3.org/2001/XMLSchema">' +
            '<S:Body>' +
             '<RecepcionarLoteRps xmlns="' + URLNS + '/">' +
              '<cabec>' +
                '&lt;?xml version="1.0" encoding="utf-8"?&gt;' +
                StringReplace(StringReplace(CabMsg, '<', '&lt;', [rfReplaceAll]), '>', '&gt;', [rfReplaceAll]) +
              '</cabec>' +
              '<msg>' +
                '&lt;?xml version="1.0" encoding="utf-8"?&gt;' +
                StringReplace(StringReplace(DadosMsg, '<', '&lt;', [rfReplaceAll]), '>', '&gt;', [rfReplaceAll]) +
              '</msg>' +
             '</RecepcionarLoteRps>' +
            '</S:Body>' +
           '</S:Envelope>';
end;

function TProvedorWebISS.GeraEnvelopeConsultarSituacaoLoteRPS(
  URLNS: String; CabMsg, DadosMsg, DadosSenha: AnsiString): AnsiString;
begin
 result := '<?xml version="1.0" encoding="utf-8"?>' +
           '<s:Envelope xmlns:s="http://schemas.xmlsoap.org/soap/envelope/" ' +
                       'xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" ' +
                       'xmlns:xsd="http://www.w3.org/2001/XMLSchema">' +
            '<s:Body>' +
             '<ConsultarSituacaoLoteRps xmlns="' + URLNS + '/">' +
              '<cabec>' +
                '&lt;?xml version="1.0" encoding="utf-8"?&gt;' +
                StringReplace(StringReplace(CabMsg, '<', '&lt;', [rfReplaceAll]), '>', '&gt;', [rfReplaceAll]) +
              '</cabec>' +
              '<msg>' +
                '&lt;?xml version="1.0" encoding="utf-8"?&gt;' +
                StringReplace(StringReplace(DadosMsg, '<', '&lt;', [rfReplaceAll]), '>', '&gt;', [rfReplaceAll]) +
              '</msg>' +
             '</ConsultarSituacaoLoteRps>' +
             '</s:Body>' +
           '</s:Envelope>';
end;

function TProvedorWebISS.GeraEnvelopeConsultarLoteRPS(URLNS: String;
  CabMsg, DadosMsg, DadosSenha: AnsiString): AnsiString;
begin
 result := '<?xml version="1.0" encoding="utf-8"?>' +
           '<s:Envelope xmlns:s="http://schemas.xmlsoap.org/soap/envelope/" ' +
                       'xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" ' +
                       'xmlns:xsd="http://www.w3.org/2001/XMLSchema">' +
            '<s:Body>' +
             '<ConsultarLoteRps xmlns="' + URLNS + '/">' +
              '<cabec>' +
                '&lt;?xml version="1.0" encoding="utf-8"?&gt;' +
                StringReplace(StringReplace(CabMsg, '<', '&lt;', [rfReplaceAll]), '>', '&gt;', [rfReplaceAll]) +
              '</cabec>' +
              '<msg>' +
                '&lt;?xml version="1.0" encoding="utf-8"?&gt;' +
                StringReplace(StringReplace(DadosMsg, '<', '&lt;', [rfReplaceAll]), '>', '&gt;', [rfReplaceAll]) +
              '</msg>' +
             '</ConsultarLoteRps>' +
            '</s:Body>' +
           '</s:Envelope>';
end;

function TProvedorWebISS.GeraEnvelopeConsultarNFSeporRPS(URLNS: String;
  CabMsg, DadosMsg, DadosSenha: AnsiString): AnsiString;
begin
 result := '<?xml version="1.0" encoding="utf-8"?>' +
           '<s:Envelope xmlns:s="http://schemas.xmlsoap.org/soap/envelope/" ' +
                       'xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" ' +
                       'xmlns:xsd="http://www.w3.org/2001/XMLSchema">' +
            '<s:Body>' +
             '<ConsultarNfsePorRps xmlns="' + URLNS + '/">' +
              '<cabec>' +
                '&lt;?xml version="1.0" encoding="utf-8"?&gt;' +
                StringReplace(StringReplace(CabMsg, '<', '&lt;', [rfReplaceAll]), '>', '&gt;', [rfReplaceAll]) +
              '</cabec>' +
              '<msg>' +
                '&lt;?xml version="1.0" encoding="utf-8"?&gt;' +
                StringReplace(StringReplace(DadosMsg, '<', '&lt;', [rfReplaceAll]), '>', '&gt;', [rfReplaceAll]) +
              '</msg>' +
             '</ConsultarNfsePorRps>' +
            '</s:Body>' +
           '</s:Envelope>';
end;

function TProvedorWebISS.GeraEnvelopeConsultarNFSe(URLNS: String; CabMsg,
  DadosMsg, DadosSenha: AnsiString): AnsiString;
begin
 result := '<?xml version="1.0" encoding="utf-8"?>' +
           '<s:Envelope xmlns:s="http://schemas.xmlsoap.org/soap/envelope/" ' +
                       'xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" ' +
                       'xmlns:xsd="http://www.w3.org/2001/XMLSchema">' +
            '<s:Body>' +
             '<ConsultarNfse xmlns="' + URLNS + '/">' +
              '<cabec>' +
                '&lt;?xml version="1.0" encoding="utf-8"?&gt;' +
                StringReplace(StringReplace(CabMsg, '<', '&lt;', [rfReplaceAll]), '>', '&gt;', [rfReplaceAll]) +
              '</cabec>' +
              '<msg>' +
                '&lt;?xml version="1.0" encoding="utf-8"?&gt;' +
                StringReplace(StringReplace(DadosMsg, '<', '&lt;', [rfReplaceAll]), '>', '&gt;', [rfReplaceAll]) +
              '</msg>' +
             '</ConsultarNfse>' +
            '</s:Body>' +
           '</s:Envelope>';
end;

function TProvedorWebISS.GeraEnvelopeCancelarNFSe(URLNS: String; CabMsg,
  DadosMsg, DadosSenha: AnsiString): AnsiString;
begin
 result := '<?xml version="1.0" encoding="utf-8"?>' +
           '<s:Envelope xmlns:s="http://schemas.xmlsoap.org/soap/envelope/" ' +
                       'xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" ' +
                       'xmlns:xsd="http://www.w3.org/2001/XMLSchema">' +
            '<s:Body>' +
             '<CancelarNfse xmlns="' + URLNS + '/">' +
              '<cabec>' +
                '&lt;?xml version="1.0" encoding="utf-8"?&gt;' +
                StringReplace(StringReplace(CabMsg, '<', '&lt;', [rfReplaceAll]), '>', '&gt;', [rfReplaceAll]) +
              '</cabec>' +
              '<msg>' +
                '&lt;?xml version="1.0" encoding="utf-8"?&gt;' +
                StringReplace(StringReplace(DadosMsg, '<', '&lt;', [rfReplaceAll]), '>', '&gt;', [rfReplaceAll]) +
              '</msg>' +
             '</CancelarNfse>' +
            '</s:Body>' +
           '</s:Envelope>';
end;

function TProvedorWebISS.GeraEnvelopeGerarNFSe(URLNS: String; CabMsg,
  DadosMsg, DadosSenha: AnsiString): AnsiString;
begin
 Result := '';
 raise Exception.Create( 'Opção não implementada para este provedor.' );
end;

function TProvedorWebISS.GetSoapAction(Acao: TnfseAcao; NomeCidade: String): String;
begin
 case Acao of
   acRecepcionar: Result := 'http://tempuri.org/INfseServices/RecepcionarLoteRps';
   acConsSit:     Result := 'http://tempuri.org/INfseServices/ConsultarSituacaoLoteRps';
   acConsLote:    Result := 'http://tempuri.org/INfseServices/ConsultarLoteRps';
   acConsNFSeRps: Result := 'http://tempuri.org/INfseServices/ConsultarNfsePorRps';
   acConsNFSe:    Result := 'http://tempuri.org/INfseServices/ConsultarNfse';
   acCancelar:    Result := 'http://tempuri.org/INfseServices/CancelarNfse';
   acGerar:       Result := '';
 end;
end;

function TProvedorWebISS.GetRetornoWS(Acao: TnfseAcao; RetornoWS: AnsiString): AnsiString;
begin
 case Acao of
   acRecepcionar: Result := SeparaDados( RetornoWS, 'RecepcionarLoteRpsResult' );
   acConsSit:     Result := SeparaDados( RetornoWS, 'ConsultarSituacaoLoteRpsResult' );
   acConsLote:    Result := SeparaDados( RetornoWS, 'ConsultarLoteRpsResult' );
   acConsNFSeRps: Result := SeparaDados( RetornoWS, 'ConsultarNfsePorRpsResult' );
   acConsNFSe:    Result := SeparaDados( RetornoWS, 'ConsultarNfseResult' );
   acCancelar:    Result := SeparaDados( RetornoWS, 'CancelarNfseResult' );
   acGerar:       Result := '';
 end;
end;

function TProvedorWebISS.GeraRetornoNFSe(Prefixo: String;
  RetNFSe: AnsiString; NomeCidade: String): AnsiString;
begin
 Result := '<?xml version="1.0" encoding="utf-8"?>' +
           '<' + Prefixo + 'CompNfse xmlns="http://www.abrasf.org.br/nfse">' +
             RetNfse +
           '</' + Prefixo + 'CompNfse>';
end;

end.
