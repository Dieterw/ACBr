{******************************************************************************}
{ Projeto: Componente ACBrCTe                                                  }
{  Biblioteca multiplataforma de componentes Delphi para emissão de Nota Fiscal}
{ eletrônica - CTe - http://www.CTe.fazenda.gov.br                          }
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
|* 10/02/2009: André Ferreira de Moraes
|*  - Adicionado URL de todos os estados
|* 18/02/2009: André Ferreira de Moraes
|*  - Criado Assinatura baseado em código passado por Daniel Simões
|*  - Criado Validação do XML da CTe baseado em código passado por Daniel Simões
******************************************************************************}
{$I ACBr.inc}

unit ACBrCTeUtil;

interface

uses {$IFNDEF ACBrCTeOpenSSL}ACBrNFeCAPICOM_TLB, ACBrNFeMSXML2_TLB, {$ENDIF}
  Classes, Forms,
  {$IFDEF FPC}
     LResources, Controls, Graphics, Dialogs,
  {$ELSE}
     StrUtils,
  {$ENDIF}
  ACBrCTeConfiguracoes, pcnConversao, ACBrNFeUtil;


{$IFDEF ACBrCTeOpenSSL}
const
 cDTD     = '<!DOCTYPE test [<!ATTLIST infCTe Id ID #IMPLIED>]>' ;
 cDTDCanc = '<!DOCTYPE test [<!ATTLIST infCanc Id ID #IMPLIED>]>' ;
 cDTDInut = '<!DOCTYPE test [<!ATTLIST infInut Id ID #IMPLIED>]>' ;
{$ELSE}
const
  DSIGNS = 'xmlns:ds="http://www.w3.org/2000/09/xmldsig#"';
{$ENDIF}
{$IFNDEF ACBrCTeOpenSSL}
var
  CertStore     : IStore3;
  CertStoreMem  : IStore3;
  PrivateKey    : IPrivateKey;
  Certs         : ICertificates2;
  Cert          : ICertificate2;
{$ENDIF}

type
  CTeUtil = class
  private
    class function GetURLRS(AAmbiente: Integer; ALayOut: TLayOut): WideString;
    class function GetURLSP(AAmbiente: Integer; ALayOut: TLayOut): WideString;
  protected

  public
    {$IFDEF ACBrCTeOpenSSL}
       class Procedure InitXmlSec ;
       class Procedure ShutDownXmlSec ;
    {$ENDIF}
    class function GetURL(Const AUF, AAmbiente, FormaEmissao: Integer; ALayOut: TLayOut): WideString;
    class function SeparaDados( Texto : AnsiString; Chave : String ) : AnsiString;
    class function Valida(Const AXML: AnsiString; var AMsg: AnsiString): Boolean;
{$IFDEF ACBrNFeOpenSSL}
    class function Assinar(const AXML, ArqPFX, PFXSenha: AnsiString; out AXMLAssinado, FMensagem: AnsiString): Boolean;
{$ELSE}
    class function Assinar(const AXML: AnsiString; Certificado : ICertificate2; out AXMLAssinado, FMensagem: AnsiString): Boolean;
{$ENDIF}
  end;

implementation


uses {$IFDEF ACBrNFeOpenSSL}libxml2, libxmlsec, libxslt, {$ELSE} ComObj, {$ENDIF} Sysutils,
  Variants;

{ CTeUtil }
{$IFDEF ACBrCTeOpenSSL}
class Procedure CTeUtil.InitXmlSec ;
begin
    { Init libxml and libxslt libraries }
    xmlInitParser();
    __xmlLoadExtDtdDefaultValue^ := XML_DETECT_IDS or XML_COMPLETE_ATTRS;
    xmlSubstituteEntitiesDefault(1);
    __xmlIndentTreeOutput^ := 1;


    { Init xmlsec library }
    if (xmlSecInit() < 0) then
       raise Exception.Create('Error: xmlsec initialization failed.');

    { Check loaded library version }
    if (xmlSecCheckVersionExt(1, 2, 8, xmlSecCheckVersionABICompatible) <> 1) then
       raise Exception.Create('Error: loaded xmlsec library version is not compatible.');

    (* Load default crypto engine if we are supporting dynamic
     * loading for xmlsec-crypto libraries. Use the crypto library
     * name ("openssl", "nss", etc.) to load corresponding
     * xmlsec-crypto library.
     *)
    if (xmlSecCryptoDLLoadLibrary('openssl') < 0) then
       raise Exception.Create( 'Error: unable to load default xmlsec-crypto library. Make sure'#10 +
                          			'that you have it installed and check shared libraries path'#10 +
                          			'(LD_LIBRARY_PATH) environment variable.');

    { Init crypto library }
    if (xmlSecCryptoAppInit(nil) < 0) then
       raise Exception.Create('Error: crypto initialization failed.');

    { Init xmlsec-crypto library }
    if (xmlSecCryptoInit() < 0) then
       raise Exception.Create('Error: xmlsec-crypto initialization failed.');
end ;

class Procedure CTeUtil.ShutDownXmlSec ;
begin
    { Shutdown xmlsec-crypto library }
    xmlSecCryptoShutdown();

    { Shutdown crypto library }
    xmlSecCryptoAppShutdown();

    { Shutdown xmlsec library }
    xmlSecShutdown();

    { Shutdown libxslt/libxml }
    xsltCleanupGlobals();
    xmlCleanupParser();
end ;
{$ENDIF}

class function CTeUtil.GetURL(const AUF, AAmbiente, FormaEmissao : Integer;
  ALayOut: TLayOut): WideString;
begin
//  (AC,AL,AP,AM,BA,CE,DF,ES,GO,MA,MT,MS,MG,PA,PB,PR,PE,PI,RJ,RN,RS,RO,RR,SC,SP,SE,TO);
//  (12,27,16,13,29,23,53,32,52,21,51,50,31,15,25,41,26,22,33,24,43,11,14,42,35,28,17);

case FormaEmissao of
  1 : begin
      case AUF of
         43: Result := CTeUtil.GetURLRS(AAmbiente,ALayOut); //RS
         35: Result := CTeUtil.GetURLSP(AAmbiente,ALayOut); //SP
      end;
     end;
  end;
end;

class function CTeUtil.GetURLRS(AAmbiente: Integer;
  ALayOut: TLayOut): WideString;
begin
  case ALayOut of
    LayCTeStatusServico : Result := NotaUtil.SeSenao(AAmbiente=1, 'https://cte.sefaz.rs.gov.br/ws/cteStatusServico/cteStatusServico.asmx', 'https://homologacao.cte.sefaz.rs.gov.br/ws/cteStatusServico/cteStatusServico.asmx');
    LayCTeCadastro      : Result := NotaUtil.SeSenao(AAmbiente=1, 'https://sef.sefaz.rs.gov.br/ws/CadConsultaCadastro/CadConsultaCadastro.asmx', 'https://sef.sefaz.rs.gov.br/ws/CadConsultaCadastro/CadConsultaCadastro.asmx');
    LayCTeConsultaCT    : Result := NotaUtil.SeSenao(AAmbiente=1, 'https://cte.sefaz.rs.gov.br/ws/cteconsulta/cteconsulta.asmx', 'https://homologacao.cte.sefaz.rs.gov.br/ws/cteconsulta/cteconsulta.asmx');
    LayCTeCancelamento  : Result := NotaUtil.SeSenao(AAmbiente=1, 'https://cte.sefaz.rs.gov.br/ws/ctecancelamento/ctecancelamento.asmx', 'https://homologacao.cte.sefaz.rs.gov.br/ws/ctecancelamento/ctecancelamento.asmx');
    LayCTeInutilizacao  : Result := NotaUtil.SeSenao(AAmbiente=1, 'https://cte.sefaz.rs.gov.br/ws/cteinutilizacao/cteinutilizacao.asmx','https://homologacao.cte.sefaz.rs.gov.br/ws/cteinutilizacao/cteinutilizacao.asmx');
    LayCTeRecepcao      : Result := NotaUtil.SeSenao(AAmbiente=1, 'https://cte.sefaz.rs.gov.br/ws/cterecepcao/cterecepcao.asmx','https://homologacao.cte.sefaz.rs.gov.br/ws/cterecepcao/cterecepcao.asmx');
    LayCTeRetRecepcao   : Result := NotaUtil.SeSenao(AAmbiente=1, 'https://cte.sefaz.rs.gov.br/ws/cteretrecepcao/cteretrecepcao.asmx','https://homologacao.cte.sefaz.rs.gov.br/ws/cteretrecepcao/cteretrecepcao.asmx');
  end;
end;

class function CTeUtil.GetURLSP(AAmbiente: Integer;
  ALayOut: TLayOut): WideString;
begin
  case ALayOut of
    LayCTeStatusServico : Result := NotaUtil.SeSenao(AAmbiente=1, 'https://nfe.fazenda.sp.gov.br/cteWEB/services/cteStatusServico.asmx', 'https://homologacao.nfe.fazenda.sp.gov.br/cteWEB/services/cteStatusServico.asmx');
    LayCTeCadastro      : Result := NotaUtil.SeSenao(AAmbiente=1, 'https://nfe.fazenda.sp.gov.br/nfeWEB/services/cadConsultaCadastro.asmx', 'https://homologacao.nfe.fazenda.sp.gov.br/nfeWEB/services/cadConsultaCadastro.asmx');
    LayCTeConsultaCT    : Result := NotaUtil.SeSenao(AAmbiente=1, 'https://nfe.fazenda.sp.gov.br/cteWEB/services/cteConsulta.asmx', 'https://homologacao.nfe.fazenda.sp.gov.br/cteWEB/services/cteConsulta.asmx');
    LayCTeCancelamento  : Result := NotaUtil.SeSenao(AAmbiente=1, 'https://nfe.fazenda.sp.gov.br/cteWEB/services/ctecancelamento.asmx', 'https://homologacao.nfe.fazenda.sp.gov.br/cteWEB/services/ctecancelamento.asmx');
    LayCTeInutilizacao  : Result := NotaUtil.SeSenao(AAmbiente=1, 'https://nfe.fazenda.sp.gov.br/cteWEB/services/cteinutilizacao.asmx','https://homologacao.nfe.fazenda.sp.gov.br/cteWEB/services/cteinutilizacao.asmx');
    LayCTeRecepcao      : Result := NotaUtil.SeSenao(AAmbiente=1, 'https://nfe.fazenda.sp.gov.br/cteWEB/services/cteRecepcao.asmx','https://homologacao.nfe.fazenda.sp.gov.br/cteWEB/services/cteRecepcao.asmx');
    LayCTeRetRecepcao   : Result := NotaUtil.SeSenao(AAmbiente=1, 'https://nfe.fazenda.sp.gov.br/cteWEB/services/cteRetRecepcao.asmx','https://homologacao.nfe.fazenda.sp.gov.br/cteWEB/services/cteRetRecepcao.asmx');
  end;
end;

class function CTeUtil.SeparaDados( Texto : AnsiString; Chave : String ) : AnsiString;
var
  PosIni, PosFim : Integer;
begin
  PosIni := Pos(Chave,Texto)-1;
  PosFim := Pos('/'+Chave,Texto)+length(Chave)+3;

  if (PosIni = 0) or (PosFim = 0) then
   begin
     PosIni := Pos('ns1:'+Chave,Texto)-1;
     PosFim := Pos('/ns1:'+Chave,Texto)+length(Chave)+3;
   end;

  Result := copy(Texto,PosIni,PosFim-(PosIni+1));
end;

{$IFDEF ACBrNFeOpenSSL}
function ValidaLibXML(const AXML: AnsiString;
  var AMsg: AnsiString): Boolean;
var
 doc, schema_doc : xmlDocPtr;
 parser_ctxt : xmlSchemaParserCtxtPtr;
 schema : xmlSchemaPtr;
 valid_ctxt : xmlSchemaValidCtxtPtr;
 schemError : xmlErrorPtr;
 schema_filename : PChar;

 Tipo, I : Integer;
begin
  I := pos('<infCTe',AXML) ;
  Tipo := 1;
  if I = 0  then
   begin
     I := pos('<infCanc',AXML) ;
     Tipo := 2;
     if I = 0 then
       Tipo := 3;
   end;

 if Tipo = 1 then
    schema_filename := pchar(ExtractFileDir(application.ExeName)+'\Schemas\nfe_v1.10.xsd')
 else if Tipo = 2 then
    schema_filename := pchar(ExtractFileDir(application.ExeName)+'\Schemas\cancNFe_v1.07.xsd')
 else if Tipo = 3 then
    schema_filename := pchar(ExtractFileDir(application.ExeName)+'\Schemas\inutNFe_v1.07.xsd');

 doc         := nil;
 schema_doc  := nil;
 parser_ctxt := nil;
 schema      := nil;
 valid_ctxt  := nil;

 doc := xmlParseDoc(PAnsiChar(Axml));
 if ((doc = nil) or (xmlDocGetRootElement(doc) = nil)) then
  begin
    AMsg := 'Erro: unable to parse';
    Result := False;
    exit;
  end;

 schema_doc  := xmlReadFile(schema_filename, nil, XML_DETECT_IDS);
//  the schema cannot be loaded or is not well-formed
 if (schema_doc = nil) then
  begin
    AMsg := 'Erro: Schema não pode ser carregado ou está corrompido';
    Result := False;
    exit;
  end;

  parser_ctxt  := xmlSchemaNewDocParserCtxt(schema_doc);
// unable to create a parser context for the schema */
    if (parser_ctxt = nil) then
     begin
        xmlFreeDoc(schema_doc);
        AMsg := 'Erro: unable to create a parser context for the schema';
        Result := False;
        exit;
     end;

   schema := xmlSchemaParse(parser_ctxt);
// the schema itself is not valid
    if (schema = nil) then
     begin
        xmlSchemaFreeParserCtxt(parser_ctxt);
        xmlFreeDoc(schema_doc);
        AMsg := 'Error: the schema itself is not valid';
        Result := False;
        exit;
     end;

    valid_ctxt := xmlSchemaNewValidCtxt(schema);
//   unable to create a validation context for the schema */
    if (valid_ctxt = nil) then
     begin
        xmlSchemaFree(schema);
        xmlSchemaFreeParserCtxt(parser_ctxt);
        xmlFreeDoc(schema_doc);
        AMsg := 'Error: unable to create a validation context for the schema';
        Result := False;
        exit;
     end;

    if (xmlSchemaValidateDoc(valid_ctxt, doc) <> 0) then
     begin
       schemError := xmlGetLastError();
       AMsg := IntToStr(schemError^.code)+' - '+schemError^.message;
       Result := False;
       exit;
     end;

    xmlSchemaFreeValidCtxt(valid_ctxt);
    xmlSchemaFree(schema);
    xmlSchemaFreeParserCtxt(parser_ctxt);
    xmlFreeDoc(schema_doc);
    Result := True;
end;
{$ELSE}
function ValidaMSXML(XML: AnsiString; out Msg: AnsiString): Boolean;
var
  DOMDocument: IXMLDOMDocument2;
  ParseError: IXMLDOMParseError;
  Schema: XMLSchemaCache;
  Tipo, I : Integer;
begin
  I := pos('<infNFe',XML) ;
  Tipo := 1;
  if I = 0  then
   begin
     I := pos('<infCanc',XML) ;
     Tipo := 2;
     if I = 0 then
       Tipo := 3;
   end;

  DOMDocument := CoDOMDocument50.Create;
  DOMDocument.async := False;
  DOMDocument.resolveExternals := False;
  DOMDocument.validateOnParse := True;
  DOMDocument.loadXML(XML);

  Schema := CoXMLSchemaCache50.Create;
  if Tipo = 1 then
     Schema.add( 'http://www.portalfiscal.inf.br/cte', ExtractFileDir(application.ExeName)+'\Schemas\cte_v1.02.xsd')
  else if Tipo = 2 then
     Schema.add( 'http://www.portalfiscal.inf.br/cte', ExtractFileDir(application.ExeName)+'\Schemas\cancCte_v1.01.xsd')
  else if Tipo = 3 then
     Schema.add( 'http://www.portalfiscal.inf.br/cte', ExtractFileDir(application.ExeName)+'\Schemas\inutCte_v1.01.xsd');
  DOMDocument.schemas := Schema;
  ParseError := DOMDocument.validate;
  Result := (ParseError.errorCode = 0);
  Msg   := ParseError.reason;

  DOMDocument := nil;
  ParseError := nil;
  Schema := nil;
end;
{$ENDIF}

class function CTeUtil.Valida(const AXML: AnsiString;
  var AMsg: AnsiString): Boolean;
begin
{$IFDEF ACBrNFeOpenSSL}
  Result := ValidaLibXML(AXML,AMsg);
{$ELSE}
  Result := ValidaMSXML(AXML,AMsg);
{$ENDIF}
end;

{$IFDEF ACBrNFeOpenSSL}
function AssinarLibXML(const AXML, ArqPFX, PFXSenha : AnsiString;
  out AXMLAssinado, FMensagem: AnsiString): Boolean;
 Var I, J, PosIni, PosFim : Integer ;
     URI, AStr, XmlAss : AnsiString ;
     Tipo : Integer; // 1 - NFE 2 - Cancelamento 3 - Inutilizacao
begin
  AStr := AXML ;

  //// Encontrando o URI ////
  I := pos('<infCTe',AStr) ;
  Tipo := 1;

  if I = 0  then
   begin
     I := pos('<infCanc',AStr) ;
     Tipo := 2;
     if I = 0 then
      begin
        I := pos('<infInut',AStr) ;
        Tipo := 3;
      end;
   end;

  if I = 0 then
     raise Exception.Create('Não encontrei inicio do URI: <infNFe') ;
  I := NotaUtil.PosEx('Id=',AStr,I+6) ;
  if I = 0 then
     raise Exception.Create('Não encontrei inicio do URI: Id=') ;
  I := NotaUtil.PosEx('"',AStr,I+2) ;
  if I = 0 then
     raise Exception.Create('Não encontrei inicio do URI: aspas inicial') ;
  J := NotaUtil.PosEx('"',AStr,I+1) ;
  if J = 0 then
     raise Exception.Create('Não encontrei inicio do URI: aspas final') ;

  URI := copy(AStr,I+1,J-I-1) ;

  //// Adicionando Cabeçalho DTD, necessário para xmlsec encontrar o ID ////
  I := pos('?>',AStr) ;
//if I = 0 then
//   raise Exception.Create('Não encontrei inicio do XML: <?xml version="1.0" encoding="UTF-8"?>') ;

//  AStr := copy(AStr,1,I+1) + cDTD + Copy(AStr,I+2,Length(AStr)) ;
{  if Tipo = 1 then
     AStr := cDTD + Copy(AStr,I,Length(AStr))
  else if Tipo = 2 then
     AStr := cDTDCanc + Copy(AStr,I+2,Length(AStr))
  else if Tipo = 3 then
     AStr := cDTDInut + Copy(AStr,I+2,Length(AStr));}

  if Tipo = 1 then
     AStr := copy(AStr,1,StrToInt(VarToStr(NotaUtil.SeSenao(I>0,I+1,I)))) + cDTD     + Copy(AStr,StrToInt(VarToStr(NotaUtil.SeSenao(I>0,I+2,I))),Length(AStr))
  else if Tipo = 2 then
     AStr := copy(AStr,1,StrToInt(VarToStr(NotaUtil.SeSenao(I>0,I+1,I)))) + cDTDCanc + Copy(AStr,StrToInt(VarToStr(NotaUtil.SeSenao(I>0,I+2,I))),Length(AStr))
  else if Tipo = 3 then
     AStr := copy(AStr,1,StrToInt(VarToStr(NotaUtil.SeSenao(I>0,I+1,I)))) + cDTDInut + Copy(AStr,StrToInt(VarToStr(NotaUtil.SeSenao(I>0,I+2,I))),Length(AStr));

  //// Inserindo Template da Assinatura digital ////
  if Tipo = 1 then
   begin
     I := pos('</CTe>',AStr) ;
     if I = 0 then
        raise Exception.Create('Não encontrei final do XML: </CTe>') ;
   end
  else if Tipo = 2 then
   begin
     I := pos('</cancCTe>',AStr) ;
     if I = 0 then
        raise Exception.Create('Não encontrei final do XML: </cancCTe>') ;
   end
  else if Tipo = 3 then
   begin
     I := pos('</inutCTe>',AStr) ;
     if I = 0 then
        raise Exception.Create('Não encontrei final do XML: </inutCTe>') ;
   end;


  if pos('<Signature',AStr) > 0 then
     I := pos('<Signature',AStr);
     AStr := copy(AStr,1,I-1) +
            '<Signature xmlns="http://www.w3.org/2000/09/xmldsig#">'+
              '<SignedInfo>'+
                '<CanonicalizationMethod Algorithm="http://www.w3.org/TR/2001/REC-xml-c14n-20010315"/>'+
                '<SignatureMethod Algorithm="http://www.w3.org/2000/09/xmldsig#rsa-sha1" />'+
                '<Reference URI="#'+URI+'">'+
                  '<Transforms>'+
                    '<Transform Algorithm="http://www.w3.org/2000/09/xmldsig#enveloped-signature" />'+
                    '<Transform Algorithm="http://www.w3.org/TR/2001/REC-xml-c14n-20010315" />'+
                  '</Transforms>'+
                  '<DigestMethod Algorithm="http://www.w3.org/2000/09/xmldsig#sha1" />'+
                  '<DigestValue></DigestValue>'+
                '</Reference>'+
              '</SignedInfo>'+
              '<SignatureValue></SignatureValue>'+
              '<KeyInfo>'+
                '<X509Data>'+
                  '<X509Certificate></X509Certificate>'+
                '</X509Data>'+
              '</KeyInfo>'+
            '</Signature>';

  if Tipo = 1 then
     AStr := AStr + '</CTe>'
  else if Tipo = 2 then
     AStr := AStr + '</cancCTe>'
  else if Tipo = 3 then
     AStr := AStr + '</inutCTe>';

  XmlAss := sign_file(PChar(AStr), PChar(ArqPFX), PChar(PFXSenha)) ;

  // Removendo quebras de linha //
  XmlAss := StringReplace( XmlAss, #10, '', [rfReplaceAll] ) ;
  XmlAss := StringReplace( XmlAss, #13, '', [rfReplaceAll] ) ;

  // Removendo DTD //
  if Tipo = 1 then
     XmlAss := StringReplace( XmlAss, cDTD, '', [] )
  else if Tipo = 2 then
     XmlAss := StringReplace( XmlAss, cDTDCanc, '', [] )
  else if Tipo = 3 then
     XmlAss := StringReplace( XmlAss, cDTDInut, '', [] );

  PosIni := Pos('<X509Certificate>',XmlAss)-1;
  PosFim := NotaUtil.PosLast('<X509Certificate>',XmlAss);

  XmlAss := copy(XmlAss,1,PosIni)+copy(XmlAss,PosFim,length(XmlAss));

  AXMLAssinado := XmlAss ;

  Result := True;
end;
{$ELSE}
function AssinarMSXML(XML : AnsiString; Certificado : ICertificate2; out XMLAssinado : AnsiString): Boolean;
var
 I, J, PosIni, PosFim : Integer;
 URI           : String ;
 Tipo : Integer;

 xmlHeaderAntes, xmlHeaderDepois : AnsiString ;
 xmldoc  : IXMLDOMDocument3;
 xmldsig : IXMLDigitalSignature;
 dsigKey   : IXMLDSigKey;
 signedKey : IXMLDSigKey;
begin
   if Pos('<Signature',XML) <= 0 then
   begin
      I := pos('<infCTe',XML) ;
      Tipo := 1;

      if I = 0  then
       begin
         I := pos('<infCanc',XML) ;
         Tipo := 2;
         if I = 0 then
            Tipo := 3;
       end;

      I := NotaUtil.PosEx('Id=',XML,6) ;
      if I = 0 then
         raise Exception.Create('Não encontrei inicio do URI: Id=') ;
      I := NotaUtil.PosEx('"',XML,I+2) ;
      if I = 0 then
         raise Exception.Create('Não encontrei inicio do URI: aspas inicial') ;
      J := NotaUtil.PosEx('"',XML,I+1) ;
      if J = 0 then
         raise Exception.Create('Não encontrei inicio do URI: aspas final') ;

      URI := copy(XML,I+1,J-I-1) ;

      if Tipo = 1 then
         XML := copy(XML,1,pos('</CTe>',XML)-1)
      else if Tipo = 2 then
         XML := copy(XML,1,pos('</cancCTe>',XML)-1)
      else if Tipo = 3 then
         XML := copy(XML,1,pos('</inutCTe>',XML)-1);

      XML := XML + '<Signature xmlns="http://www.w3.org/2000/09/xmldsig#"><SignedInfo><CanonicalizationMethod Algorithm="http://www.w3.org/TR/2001/REC-xml-c14n-20010315"/><SignatureMethod Algorithm="http://www.w3.org/2000/09/xmldsig#rsa-sha1" />';
      XML := XML + '<Reference URI="#'+URI+'">';
      XML := XML + '<Transforms><Transform Algorithm="http://www.w3.org/2000/09/xmldsig#enveloped-signature" /><Transform Algorithm="http://www.w3.org/TR/2001/REC-xml-c14n-20010315" /></Transforms><DigestMethod Algorithm="http://www.w3.org/2000/09/xmldsig#sha1" />';
      XML := XML + '<DigestValue></DigestValue></Reference></SignedInfo><SignatureValue></SignatureValue><KeyInfo></KeyInfo></Signature>';

      if Tipo = 1 then
         XML := XML + '</CTe>'
      else if Tipo = 2 then
         XML := XML + '</cancCTe>'
      else if Tipo = 3 then
         XML := XML + '</inutCTe>';
   end;

   // Lendo Header antes de assinar //
   xmlHeaderAntes := '' ;
   I := pos('?>',XML) ;
   if I > 0 then
      xmlHeaderAntes := copy(XML,1,I+1) ;

   xmldoc := CoDOMDocument50.Create;

   xmldoc.async              := False;
   xmldoc.validateOnParse    := False;
   xmldoc.preserveWhiteSpace := True;

   xmldsig := CoMXDigitalSignature50.Create;

   if (not xmldoc.loadXML(XML) ) then
      raise Exception.Create('Não foi possível carregar o arquivo: '+XML);

   xmldoc.setProperty('SelectionNamespaces', DSIGNS);

   xmldsig.signature := xmldoc.selectSingleNode('.//ds:Signature');

   if (xmldsig.signature = nil) then
      raise Exception.Create('Falha ao setar assinatura.');

   if (xmldsig.signature = nil) then
      raise Exception.Create('É preciso carregar o template antes de assinar.');

   if  CertStoreMem = nil then
    begin
      CertStore := CoStore.Create;
      CertStore.Open(CAPICOM_CURRENT_USER_STORE, 'My', CAPICOM_STORE_OPEN_MAXIMUM_ALLOWED);

      CertStoreMem := CoStore.Create;
      CertStoreMem.Open(CAPICOM_MEMORY_STORE, 'Memoria', CAPICOM_STORE_OPEN_MAXIMUM_ALLOWED);

      Certs := CertStore.Certificates as ICertificates2;
      for i:= 1 to Certs.Count do
      begin
        Cert := IInterface(Certs.Item[i]) as ICertificate2;
        if Cert.SerialNumber = Certificado.SerialNumber then
           CertStoreMem.Add(Cert);
      end;
   end;

   OleCheck(IDispatch(Certificado.PrivateKey).QueryInterface(IPrivateKey,PrivateKey));
   xmldsig.store := CertStoreMem;

   dsigKey := xmldsig.createKeyFromCSP(PrivateKey.ProviderType, PrivateKey.ProviderName, PrivateKey.ContainerName, 0);
   if (dsigKey = nil) then
      raise Exception.Create('Erro ao criar a chave do CSP.');

   signedKey := xmldsig.sign(dsigKey, $00000002);
   if (signedKey <> nil) then
    begin
      XMLAssinado := xmldoc.xml;
      XMLAssinado := StringReplace( XMLAssinado, #10, '', [rfReplaceAll] ) ;
      XMLAssinado := StringReplace( XMLAssinado, #13, '', [rfReplaceAll] ) ;
      PosIni := Pos('<SignatureValue>',XMLAssinado)+length('<SignatureValue>');
      XMLAssinado := copy(XMLAssinado,1,PosIni-1)+StringReplace( copy(XMLAssinado,PosIni,length(XMLAssinado)), ' ', '', [rfReplaceAll] ) ;
      PosIni := Pos('<X509Certificate>',XMLAssinado)-1;
      PosFim := NotaUtil.PosLast('<X509Certificate>',XMLAssinado);

      XMLAssinado := copy(XMLAssinado,1,PosIni)+copy(XMLAssinado,PosFim,length(XMLAssinado));
    end
   else
      raise Exception.Create('Assinatura Falhou.');

   if xmlHeaderAntes <> '' then
   begin
      I := pos('?>',XMLAssinado) ;
      if I > 0 then
       begin
         xmlHeaderDepois := copy(XMLAssinado,1,I+1) ;
         if xmlHeaderAntes <> xmlHeaderDepois then
            XMLAssinado := StuffString(XMLAssinado,1,length(xmlHeaderDepois),xmlHeaderAntes) ;
       end
      else
         XMLAssinado := xmlHeaderAntes + XMLAssinado ;
   end ;

   dsigKey   := nil;
   signedKey := nil;
   xmldoc    := nil;
   xmldsig   := nil;

   Result := True;
end;
{$ENDIF}

{$IFDEF ACBrNFeOpenSSL}
class function CTeUtil.Assinar(const AXML, ArqPFX, PFXSenha: AnsiString; out AXMLAssinado, FMensagem: AnsiString): Boolean;
{$ELSE}
class function CTeUtil.Assinar(const AXML: AnsiString; Certificado : ICertificate2; out AXMLAssinado, FMensagem: AnsiString): Boolean;
{$ENDIF}
begin
{$IFDEF ACBrNFeOpenSSL}
  Result := AssinarLibXML(AXML, ArqPFX, PFXSenha, AXMLAssinado, FMensagem);
{$ELSE}
  Result := AssinarMSXML(AXML,Certificado,AXMLAssinado);
{$ENDIF}
end;


end.
