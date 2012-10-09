{$I ACBr.inc}

unit ACBrNFSeUtil;

interface

uses
  {$IFNDEF ACBrNFSeOpenSSL}
    ACBrCAPICOM_TLB, ACBrMSXML2_TLB,
  {$ENDIF}
  Classes, Forms,
  {$IFDEF FPC}
    LResources, Controls, Graphics, Dialogs,
  {$ELSE}
    StrUtils,
  {$ENDIF}
  ACBrNFSeConfiguracoes, pnfsConversao, pnfsNFSe;

  {$IFDEF ACBrNFSeOpenSSL}
    const
     cDTDLote = '<!DOCTYPE test [<!ATTLIST LoteRps Id ID #IMPLIED>]>';
     cDTDRps  = '<!DOCTYPE test [<!ATTLIST InfRps Id ID #IMPLIED>]>';
  {$ELSE}
    const
     DSIGNS = 'xmlns:ds="http://www.w3.org/2000/09/xmldsig#"';
  {$ENDIF}

 {$IFNDEF ACBrNFSeOpenSSL}
   var
    CertStore     : IStore3;
    CertStoreMem  : IStore3;
    PrivateKey    : IPrivateKey;
    Certs         : ICertificates2;
    Cert          : ICertificate2;
    NumCertCarregado : String;
 {$ENDIF}

type

 NotaUtil = class
  private
  protected

  public
    {$IFDEF ACBrNFSeOpenSSL}
      class function sign_file(const Axml: PAnsiChar; const key_file: PChar; const senha: PChar): AnsiString;
      class function sign_memory(const Axml: PChar; const key_file: Pchar; const senha: PChar; Size: Cardinal; Ponteiro: Pointer): AnsiString;
      class Procedure InitXmlSec;
      class Procedure ShutDownXmlSec;
    {$ENDIF}
    class function PosEx(const SubStr, S: AnsiString; Offset: Cardinal = 1): Integer;
    class function PosLast(const SubStr, S: AnsiString ): Integer;
    class function PadE(const AString : string; const nLen : Integer; const Caracter : Char = ' ') : String;
    class function PadD(const AString : string; const nLen : Integer; const Caracter : Char = ' ') : String;
    class function padC(const AString : string; const nLen : Integer; const Caracter : Char = ' ') : String;
    class function SeSenao(ACondicao: Boolean; ATrue, AFalse: Variant) : Variant;
    class function FormatFloat(AValue: Extended; const AFormat: string = ',0.00'): String;
    class function Poem_Zeros(const Texto : String; const Tamanho : Integer) : String;overload;
    class function Poem_Zeros(const Valor : Integer; const Tamanho : Integer) : String;overload;
    class function LasString(AString: String): String;
    class function EstaVazio(const AValue: String): Boolean;overload;
    class procedure EstaVazio(const AValue, AMensagem: String);overload;
    class function NaoEstaVazio(AValue: String): Boolean;
    class function EstaZerado(AValue: Double): Boolean;overload;
    class function EstaZerado(AValue: Integer): Boolean;overload;
    class procedure EstaZerado(AValue: Integer; AMensagem: String);overload;
    class function NaoEstaZerado(AValue: Double): Boolean;overload;
    class function NaoEstaZerado(AValue: Integer): Boolean;overload;
    class function LimpaNumero(AValue: String): String;
    class function TrataString(const AValue: String): String;overload;
    class function TrataString(const AValue: String; const ATamanho: Integer): String;overload;
    class function CortaD(const AString: string; const ATamanho: Integer): String;
    class function CortaE(const AString: string; const ATamanho: Integer): String;
    class function FormatDate(const AString: string): String;
    class function FormatDateTime(const AString: string): string;
    class function StringToDate(const AString: string): TDateTime;
    class function TamanhoIgual(const AValue: String; const ATamanho: Integer): Boolean;overload;
    class procedure TamanhoIgual(const AValue: String; const ATamanho: Integer; AMensagem: String);overload;
    class function TamanhoIgual(const AValue: Integer; const ATamanho: Integer): Boolean;overload;
    class procedure TamanhoIgual(const AValue: Integer; const ATamanho: Integer; AMensagem: String);overload;
    class function TamanhoMenor(const AValue: String; const ATamanho: Integer): Boolean;
    class function FormatarCPF(AValue : String ): String;
    class function FormatarCNPJ(AValue : String ): String;
    class function FormatarCEP(AValue : String ): String;
    class function FormatarFone(AValue : String ): String;
    class function FormatarNumeroDocumentoFiscal(AValue : String ): String;
    class function Valida(const AXML: AnsiString;
                          var AMsg: AnsiString;
                          const APathSchemas: string = '';
                          AURL: string = '';
                          AServico: string = '';
                          APrefixo: string = ''): Boolean;
    {$IFDEF ACBrNFSeOpenSSL}
      class function Assinar(const AXML, ArqPFX, PFXSenha: AnsiString;
                             out AXMLAssinado, FMensagem: AnsiString;
                             ALote: Boolean = False): Boolean;
    {$ELSE}
      // Alterado por Italo em 12/07/2012
      class function Assinar(const AXML: AnsiString;
                             Certificado : ICertificate2;
                             out AXMLAssinado, FMensagem: AnsiString;
                             ALote: Boolean = False;
                             APrefixo3: string = '';
                             APrefixo4: string = '';
                             AProvedor: TnfseProvedor = proNenhum): Boolean;
    {$ENDIF}
    class function StringToFloat(AValue : String ) : Double;
    class function StringToFloatDef(const AValue: String; const DefaultValue: Double): Double;
    class procedure ConfAmbiente;
    class function PathAplication: String;
    class function CollateBr(Str: String): String;
    class function UpperCase2(Str: String): String;
    class function PathWithDelim( const APath : String ) : String;
    class function RetornarConteudoEntre(const Frase, Inicio, Fim: string): string;

    class function AssinarXML(AXML, FURI, FTagI, FTagF: AnsiString; Certificado : ICertificate2; out AXMLAssinado, FMensagem: AnsiString): Boolean;
    class function RetirarPrefixos(AXML: String): String;
    class function VersaoXML(AXML: String): String;

  published

  end;

implementation

uses
 {$IFDEF ACBrNFSeOpenSSL}
   libxml2, libxmlsec, libxslt,
 {$ELSE}
   ComObj,
 {$ENDIF}
 IniFiles, Sysutils, Variants, ACBrUtil, ACBrNFSe;

{ NotaUtil }

{$IFDEF ACBrNFSeOpenSSL}
class function NotaUtil.sign_file(const Axml: PAnsiChar; const key_file: PChar; const senha: PChar): AnsiString;
var
  doc: xmlDocPtr;
  node: xmlNodePtr;
  dsigCtx: xmlSecDSigCtxPtr;
  buffer: PChar;
  bufSize: integer;
label done;
begin
    doc     := nil;
    node    := nil;
    dsigCtx := nil;
    result  := '';

    if (Axml = nil) or (key_file = nil) then Exit;

    try
       // load template
       doc := xmlParseDoc(Axml);
       if ((doc = nil) or (xmlDocGetRootElement(doc) = nil)) then
         raise Exception.Create('Error: unable to parse');

       // find start node
       node := xmlSecFindNode(xmlDocGetRootElement(doc), PAnsiChar(xmlSecNodeSignature), PAnsiChar(xmlSecDSigNs));
       if (node = nil) then
         raise Exception.Create('Error: start node not found');

       // create signature context, we don't need keys manager in this example
       dsigCtx := xmlSecDSigCtxCreate(nil);
       if (dsigCtx = nil) then
         raise Exception.Create('Error :failed to create signature context');

       //  load private key
       dsigCtx^.signKey := xmlSecCryptoAppKeyLoad(key_file, xmlSecKeyDataFormatPkcs12, senha, nil, nil);
       if (dsigCtx^.signKey = nil) then
          raise Exception.Create('Error: failed to load private pem key from "' + key_file + '"');

       // set key name to the file name, this is just an example!
       if (xmlSecKeySetName(dsigCtx^.signKey, PAnsiChar(key_file)) < 0) then
         raise Exception.Create('Error: failed to set key name for key from "' + key_file + '"');

       // sign the template
       if (xmlSecDSigCtxSign(dsigCtx, node) < 0) then
         raise Exception.Create('Error: signature failed');

       // print signed document to stdout
       // xmlDocDump(stdout, doc);
       // Can't use "stdout" from Delphi, so we'll use xmlDocDumpMemory instead...
       buffer := nil;
       xmlDocDumpMemory(doc, @buffer, @bufSize);
       if (buffer <> nil) then
          // success
          result := buffer;
   finally
       // cleanup
       if (dsigCtx <> nil) then
         xmlSecDSigCtxDestroy(dsigCtx);

       if (doc <> nil) then
         xmlFreeDoc(doc);
   end;
end;

class function NotaUtil.sign_memory(const Axml: PChar; const key_file: Pchar; const senha: PChar; Size: Cardinal; Ponteiro: Pointer): AnsiString;
var
  doc: xmlDocPtr;
  node: xmlNodePtr;
  dsigCtx: xmlSecDSigCtxPtr;
  buffer: PChar;
  bufSize: integer;
label done;
begin
    doc     := nil;
    node    := nil;
    dsigCtx := nil;
    result  := '';

    if (Axml = nil) or (key_file = nil) then Exit;
    try
       // load template
       doc := xmlParseDoc(Axml);
       if ((doc = nil) or (xmlDocGetRootElement(doc) = nil)) then
         raise Exception.Create('Error: unable to parse');

       // find start node
       node := xmlSecFindNode(xmlDocGetRootElement(doc), PChar(xmlSecNodeSignature), PChar(xmlSecDSigNs));
       if (node = nil) then
         raise Exception.Create('Error: start node not found');

       // create signature context, we don't need keys manager in this example
       dsigCtx := xmlSecDSigCtxCreate(nil);
       if (dsigCtx = nil) then
         raise Exception.Create('Error :failed to create signature context');

       //  load private key, assuming that there is not password
       dsigCtx^.signKey := xmlSecCryptoAppKeyLoadMemory(Ponteiro, size, xmlSecKeyDataFormatPkcs12, senha, nil, nil);

       if (dsigCtx^.signKey = nil) then
          raise Exception.Create('Error: failed to load private pem key from "' + key_file + '"');

       // set key name to the file name, this is just an example!
       if (xmlSecKeySetName(dsigCtx^.signKey, key_file) < 0) then
         raise Exception.Create('Error: failed to set key name for key from "' + key_file + '"');

       // sign the template
       if (xmlSecDSigCtxSign(dsigCtx, node) < 0) then
         raise Exception.Create('Error: signature failed');

       // print signed document to stdout
       // xmlDocDump(stdout, doc);
       // Can't use "stdout" from Delphi, so we'll use xmlDocDumpMemory instead...
       buffer := nil;
       xmlDocDumpMemory(doc, @buffer, @bufSize);
       if (buffer <> nil) then
          // success
          result := buffer;
   finally
       // cleanup
       if (dsigCtx <> nil) then
         xmlSecDSigCtxDestroy(dsigCtx);

       if (doc <> nil) then
         xmlFreeDoc(doc);
   end;
end;

class Procedure NotaUtil.InitXmlSec;
begin
    // Init libxml and libxslt libraries
    xmlInitParser();
    __xmlLoadExtDtdDefaultValue^ := XML_DETECT_IDS or XML_COMPLETE_ATTRS;
    xmlSubstituteEntitiesDefault(1);
    __xmlIndentTreeOutput^ := 1;


    // Init xmlsec library
    if (xmlSecInit() < 0) then
       raise Exception.Create('Error: xmlsec initialization failed.');

    // Check loaded library version
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

    // Init crypto library
    if (xmlSecCryptoAppInit(nil) < 0) then
       raise Exception.Create('Error: crypto initialization failed.');

    // Init xmlsec-crypto library
    if (xmlSecCryptoInit() < 0) then
       raise Exception.Create('Error: xmlsec-crypto initialization failed.');
end;

class Procedure NotaUtil.ShutDownXmlSec;
begin
    // Shutdown xmlsec-crypto library
    xmlSecCryptoShutdown();

    // Shutdown crypto library
    xmlSecCryptoAppShutdown();

    // Shutdown xmlsec library
    xmlSecShutdown();

    // Shutdown libxslt/libxml
    xsltCleanupGlobals();
    xmlCleanupParser();
end;
{$ENDIF}

class function NotaUtil.PosEx(const SubStr, S: AnsiString; Offset: Cardinal = 1): Integer;
var
  I,X: Integer;
  Len, LenSubStr: Integer;
begin
  if Offset = 1 then
    Result := Pos(SubStr, S)
  else
  begin
    I         := Offset;
    LenSubStr := Length(SubStr);
    Len       := Length(S) - LenSubStr + 1;
    while I <= Len do
    begin
      if S[I] = SubStr[1] then
      begin
        X := 1;
        while (X < LenSubStr) and (S[I + X] = SubStr[X + 1]) do
          Inc(X);
        if (X = LenSubStr) then
        begin
          Result := I;
          exit;
        end;
      end;
      Inc(I);
    end;
    Result := 0;
  end;
end;

class function NotaUtil.PosLast(const SubStr, S: AnsiString ): Integer;
Var P : Integer;
begin
  Result := 0;
  P      := Pos( SubStr, S);
  while P <> 0 do
  begin
     Result := P;
     P      := PosEx( SubStr, S, P+1);
  end;
end;

class function NotaUtil.CortaD(const AString: string;
  const ATamanho: Integer): String;
begin
  Result := copy(AString,1,ATamanho);
end;

class function NotaUtil.CortaE(const AString: string;
  const ATamanho: Integer): String;
begin
  Result := AString;
  if Length(AString) > ATamanho then
    Result := copy(AString, Length(AString) - ATamanho + 1, length(AString));
end;

class function NotaUtil.EstaVazio(const AValue: String): Boolean;
begin
  Result := (Trim(AValue) = '');
end;

class function NotaUtil.EstaZerado(AValue: Double): Boolean;
begin
  Result := (AValue = 0);
end;

class procedure NotaUtil.EstaVazio(const AValue, AMensagem: String);
begin
  if NotaUtil.EstaVazio(AValue) then
    raise Exception.Create(AMensagem);
end;

class function NotaUtil.EstaZerado(AValue: Integer): Boolean;
begin
  Result := (AValue = 0);
end;

class function NotaUtil.FormatDate(const AString: string): String;
var
  vTemp: TDateTime;
{$IFDEF VER140} //delphi6
{$ELSE}
  FFormato : TFormatSettings;
{$ENDIF}
begin
  try
{$IFDEF VER140} //delphi6
    DateSeparator   := '/';
    ShortDateFormat := 'dd/mm/yyyy';
{$ELSE}
    FFormato.DateSeparator   := '-';
    FFormato.ShortDateFormat := 'yyyy-mm-dd';
//    vTemp := StrToDate(AString, FFormato);
{$ENDIF}
    vTemp := StrToDate(AString);
    if vTemp = 0 then
      Result := ''
    else
      Result := DateToStr(vTemp);
  except
    Result := '';
  end;
end;

class function NotaUtil.FormatDateTime(const AString: string): string;
var
  vTemp : TDateTime;
{$IFDEF VER140} //delphi6
{$ELSE}
  FFormato : TFormatSettings;
{$ENDIF}
begin
  try
{$IFDEF VER140} //delphi6
    DateSeparator   := '/';
    ShortDateFormat := 'dd/mm/yyyy';
    ShortTimeFormat := 'hh:nn:ss';
{$ELSE}
    FFormato.DateSeparator   := '-';
    FFormato.ShortDateFormat := 'yyyy-mm-dd';
    //    vTemp := StrToDate(AString, FFormato);
{$ENDIF}
    vTemp := StrToDateTime(AString);
    if vTemp = 0 then
      Result := ''
    else
      Result := DateTimeToStr(vTemp);
  except
    Result := '';
  end;
end;

class function NotaUtil.StringToDate(const AString: string): TDateTime;
begin
  if (AString = '0') or (AString = '') then
     Result := 0
  else
     Result := StrToDate(AString);
end;

class function NotaUtil.FormatFloat(AValue: Extended;
  const AFormat: string): string;
{$IFDEF VER140} //delphi6
{$ELSE}
var
  vFormato: TFormatSettings;
{$ENDIF}
begin
{$IFDEF VER140} //delphi6
  DecimalSeparator  := ',';
  ThousandSeparator := '.';
  Result            := SysUtils.FormatFloat(AFormat, AValue);
{$ELSE}
  vFormato.DecimalSeparator  := ',';
  vFormato.ThousandSeparator := '.';
  Result                     := SysUtils.FormatFloat(AFormat, AValue, vFormato);
{$ENDIF}
end;

class function NotaUtil.LasString(AString: String): String;
begin
  Result := Copy(AString, Length(AString), Length(AString));
end;

class function NotaUtil.LimpaNumero(AValue: String): String;
var
  A : Integer;
begin
  Result := '';
  For A := 1 to length(AValue) do
  begin
     if (AValue[A] in ['0'..'9']) then
       Result := Result + AValue[A];
  end;
end;

class function NotaUtil.NaoEstaVazio(AValue: String): Boolean;
begin
  Result := not(EstaVazio(AValue));
end;

class function NotaUtil.NaoEstaZerado(AValue: Double): Boolean;
begin
  Result := not(EstaZerado(AValue));
end;

class function NotaUtil.NaoEstaZerado(AValue: Integer): Boolean;
begin
  Result := not(EstaZerado(AValue));
end;

class function NotaUtil.padC(const AString: string; const nLen: Integer;
  const Caracter: Char): String;
Var nCharLeft : Integer;
    D : Double;
begin
  Result    := copy(AString,1,nLen);
  D         := (nLen - Length( Result )) / 2;
  nCharLeft := Trunc( D );
  Result    := PadE( StringOfChar(Caracter, nCharLeft)+Result, nLen, Caracter);
end;

class function NotaUtil.PadD(const AString: string; const nLen: Integer;
  const Caracter: Char): String;
begin
  Result := copy(AString,1,nLen);
  Result := StringOfChar(Caracter, (nLen - Length(Result))) + Result;
end;

class function NotaUtil.PadE(const AString: string; const nLen: Integer;
  const Caracter: Char): String;
begin
  Result := copy(AString,1,nLen);
  Result := Result + StringOfChar(Caracter, (nLen - Length(Result)));
end;

class function NotaUtil.Poem_Zeros(const Texto: String;
  const Tamanho: Integer): String;
begin
  Result := PadD(Trim(Texto),Tamanho,'0');
end;

class function NotaUtil.Poem_Zeros(const Valor, Tamanho: Integer): String;
begin
  Result := PadD(IntToStr(Valor), Tamanho, '0');
end;

class function NotaUtil.SeSenao(ACondicao: Boolean; ATrue,
  AFalse: Variant): Variant;
begin
  Result := AFalse;
  if ACondicao then
    Result := ATrue;
end;

class function NotaUtil.TrataString(const AValue: String): String;
var
  A : Integer;
begin
  Result := '';
  For A := 1 to length(AValue) do
  begin
    case Ord(AValue[A]) of
      60  : Result := Result + '&lt;';  //<
      62  : Result := Result + '&gt;';  //>
      38  : Result := Result + '&amp;'; //&
      34  : Result := Result + '&quot;';//"
      39  : Result := Result + '&#39;'; //'
      32  : begin          // Retira espaços duplos
              if ( Ord(AValue[Pred(A)]) <> 32 ) then
                 Result := Result + ' ';
            end;
      193 : Result := Result + 'A';//Á
      224 : Result := Result + 'a';//à
      226 : Result := Result + 'a';//â
      234 : Result := Result + 'e';//ê
      244 : Result := Result + 'o';//ô
      251 : Result := Result + 'u';//û
      227 : Result := Result + 'a';//ã
      245 : Result := Result + 'o';//õ
      225 : Result := Result + 'a';//á
      233 : Result := Result + 'e';//é
      237 : Result := Result + 'i';//í
      243 : Result := Result + 'o';//ó
      250 : Result := Result + 'u';//ú
      231 : Result := Result + 'c';//ç
      252 : Result := Result + 'u';//ü
      192 : Result := Result + 'A';//À
      194 : Result := Result + 'A';//Â
      202 : Result := Result + 'E';//Ê
      212 : Result := Result + 'O';//Ô
      219 : Result := Result + 'U';//Û
      195 : Result := Result + 'A';//Ã
      213 : Result := Result + 'O';//Õ
      201 : Result := Result + 'E';//É
      205 : Result := Result + 'I';//Í
      211 : Result := Result + 'O';//Ó
      218 : Result := Result + 'U';//Ú
      199 : Result := Result + 'C';//Ç
      220 : Result := Result + 'U';//Ü
    else
      Result := Result + AValue[A];
    end;
  end;
  Result := Trim(Result);
end;

class function NotaUtil.TrataString(const AValue: String;
  const ATamanho: Integer): String;
begin
  Result := NotaUtil.TrataString(NotaUtil.CortaD(AValue, ATamanho));
end;

class function NotaUtil.TamanhoIgual(const AValue: String;
  const ATamanho: Integer): Boolean;
begin
  Result := (Length(AValue)= ATamanho);
end;

class procedure NotaUtil.TamanhoIgual(const AValue: String;
  const ATamanho: Integer; AMensagem: String);
begin
  if not(NotaUtil.TamanhoIgual(AValue, ATamanho)) then
    raise Exception.Create(AMensagem);
end;

class function NotaUtil.TamanhoIgual(const AValue,
  ATamanho: Integer): Boolean;
begin
  Result := (Length(IntToStr(AValue))= ATamanho);
end;

class procedure NotaUtil.TamanhoIgual(const AValue,
  ATamanho: Integer; AMensagem: String);
begin
  if not(NotaUtil.TamanhoIgual(AValue, ATamanho)) then
    raise Exception.Create(AMensagem);
end;

class procedure NotaUtil.EstaZerado(AValue: Integer;
  AMensagem: String);
begin
  if NotaUtil.EstaZerado(AValue) then
    raise Exception.Create(AMensagem);
end;

class function NotaUtil.FormatarCPF(AValue: String): String;
begin
  if Length(AValue) = 0 then
     Result := AValue
  else
   begin
     AValue := NotaUtil.LimpaNumero(AValue);
     Result := copy(AValue,1,3) + '.' + copy(AValue,4 ,3) + '.' +
               copy(AValue,7,3) + '-' + copy(AValue,10,2);
   end;
end;

class function NotaUtil.FormatarCNPJ(AValue: String): String;
begin
  if Length(AValue) = 0 then
     Result := AValue
  else
   begin
     AValue := NotaUtil.LimpaNumero(AValue);
     Result := copy(AValue,1,2) + '.' + copy(AValue,3,3) + '.' +
               copy(AValue,6,3) + '/' + copy(AValue,9,4) + '-' + copy(AValue,13,2);
   end;
end;

class function NotaUtil.FormatarCEP(AValue: String): String;
begin
  Result := copy(AValue,1,5) + '-' + copy(AValue,6,3);
end;

class function NotaUtil.TamanhoMenor(const AValue: String;
  const ATamanho: Integer): Boolean;
begin
  Result := (Length(AValue) < ATamanho);
end;

class function NotaUtil.FormatarFone(AValue: String): String;
begin
  Result := AValue;
  if NotaUtil.NaoEstaVazio(AValue) then
  begin
    AValue := NotaUtil.Poem_Zeros(NotaUtil.LimpaNumero(AValue), 10);
    Result := '('+copy(AValue,1,2) + ')' + copy(AValue,3,8);
  end;
end;

class function NotaUtil.FormatarNumeroDocumentoFiscal(
  AValue: String): String;
begin
  AValue := NotaUtil.Poem_Zeros(AValue, 9);
  Result := copy(AValue,1,3) + '.' + copy(AValue,4,3)+ '.'+
            copy(AValue,7,3);
end;

{$IFDEF ACBrNFSeOpenSSL}
function ValidaLibXML(const AXML: AnsiString;
  var AMsg: AnsiString; const APathSchemas: string = ''): Boolean;
var
 doc, schema_doc : xmlDocPtr;
 parser_ctxt : xmlSchemaParserCtxtPtr;
 schema : xmlSchemaPtr;
 valid_ctxt : xmlSchemaValidCtxtPtr;
 schemError : xmlErrorPtr;
 schema_filename : PChar;

 Tipo, I : Integer;
begin
  I    := pos('<infNFe',AXML);
  Tipo := 1;
  if I = 0  then
   begin
     I := pos('<infCanc',AXML);
     if I > 0 then
        Tipo := 2
     else
      begin
        I := pos('<infInut',AXML);
        if I > 0 then
           Tipo := 3
        else
           Tipo := 4;
      end;
   end;

 if not DirectoryExists(NotaUtil.SeSenao(NotaUtil.EstaVazio(APathSchemas),NotaUtil.PathWithDelim(ExtractFileDir(application.ExeName))+'Schemas',NotaUtil.PathWithDelim(APathSchemas))) then
    raise Exception.Create('Diretório de Schemas não encontrado'+sLineBreak+
                           NotaUtil.SeSenao(NotaUtil.EstaVazio(APathSchemas),NotaUtil.PathWithDelim(ExtractFileDir(application.ExeName))+'Schemas',NotaUtil.PathWithDelim(APathSchemas)));

 if Tipo = 1 then
 begin
    if NotaUtil.EstaVazio(APathSchemas) then
       schema_filename := pchar(NotaUtil.PathWithDelim(ExtractFileDir(application.ExeName))+'Schemas\nfe_v2.00.xsd')
    else
       schema_filename := pchar(NotaUtil.PathWithDelim(APathSchemas)+'nfe_v2.00.xsd');
 end
 else if Tipo = 2 then
 begin
    if NotaUtil.EstaVazio(APathSchemas) then
       schema_filename := pchar(NotaUtil.PathWithDelim(ExtractFileDir(application.ExeName))+'Schemas\cancNFe_v2.00.xsd')
    else
       schema_filename := pchar(NotaUtil.PathWithDelim(APathSchemas)+'cancNFe_v2.00.xsd');
 end
 else if Tipo = 3 then
 begin
    if NotaUtil.EstaVazio(APathSchemas) then
       schema_filename := pchar(NotaUtil.PathWithDelim(ExtractFileDir(application.ExeName))+'Schemas\inutNFe_v2.00.xsd')
    else
       schema_filename := pchar(NotaUtil.PathWithDelim(APathSchemas)+'inutNFe_v2.00.xsd');
 end
 else if Tipo = 4 then
 begin
    if NotaUtil.EstaVazio(APathSchemas) then
       schema_filename := pchar(NotaUtil.PathWithDelim(ExtractFileDir(application.ExeName))+'Schemas\envDPEC_v1.01.xsd')
    else
       schema_filename := pchar(NotaUtil.PathWithDelim(APathSchemas)+'envDPEC_v1.01.xsd');
 end;

 doc         := nil;
 schema_doc  := nil;
 parser_ctxt := nil;
 schema      := nil;
 valid_ctxt  := nil;

 doc := xmlParseDoc(PAnsiChar(Axml));
 if ((doc = nil) or (xmlDocGetRootElement(doc) = nil)) then
  begin
    AMsg   := 'Erro: unable to parse';
    Result := False;
    exit;
  end;

 schema_doc := xmlReadFile(schema_filename, nil, XML_DETECT_IDS);
//  the schema cannot be loaded or is not well-formed
 if (schema_doc = nil) then
  begin
    AMsg   := 'Erro: Schema não pode ser carregado ou está corrompido';
    Result := False;
    exit;
  end;

  parser_ctxt := xmlSchemaNewDocParserCtxt(schema_doc);
// unable to create a parser context for the schema */
    if (parser_ctxt = nil) then
     begin
        xmlFreeDoc(schema_doc);
        AMsg   := 'Erro: unable to create a parser context for the schema';
        Result := False;
        exit;
     end;

   schema := xmlSchemaParse(parser_ctxt);
// the schema itself is not valid
    if (schema = nil) then
     begin
        xmlSchemaFreeParserCtxt(parser_ctxt);
        xmlFreeDoc(schema_doc);
        AMsg   := 'Error: the schema itself is not valid';
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
        AMsg   := 'Error: unable to create a validation context for the schema';
        Result := False;
        exit;
     end;

    if (xmlSchemaValidateDoc(valid_ctxt, doc) <> 0) then
     begin
       schemError := xmlGetLastError();
       AMsg       := IntToStr(schemError^.code)+' - '+schemError^.message;
       Result     := False;
       exit;
     end;

    xmlSchemaFreeValidCtxt(valid_ctxt);
    xmlSchemaFree(schema);
    xmlSchemaFreeParserCtxt(parser_ctxt);
    xmlFreeDoc(schema_doc);
    Result := True;
end;

{$ELSE}

function ValidaMSXML(XML: AnsiString;
                     out Msg: AnsiString;
                     const APathSchemas: string = '';
                     URL: string = '';
                     Servico: string = '';
                     APrefixo: string = ''): Boolean;
var
 DOMDocument     : IXMLDOMDocument3;
 ParseError      : IXMLDOMParseError;
 Schema          : XMLSchemaCache;
 schema_filename : String;
begin
 DOMDocument                  := CoDOMDocument50.Create;
 DOMDocument.async            := False;
 DOMDocument.resolveExternals := False;
 DOMDocument.validateOnParse  := True;
 DOMDocument.loadXML(XML);

 Schema := CoXMLSchemaCache50.Create;

 if not DirectoryExists(NotaUtil.SeSenao(NotaUtil.EstaVazio(APathSchemas),
                        PathWithDelim(ExtractFileDir(application.ExeName)) + 'Schemas',
                        PathWithDelim(APathSchemas)))
  then raise Exception.Create('Diretório de Schemas não encontrado' + sLineBreak +
                              NotaUtil.SeSenao(NotaUtil.EstaVazio(APathSchemas),
                              PathWithDelim(ExtractFileDir(application.ExeName)) + 'Schemas',
                              PathWithDelim(APathSchemas)));

 schema_filename := NotaUtil.SeSenao(NotaUtil.EstaVazio(APathSchemas),
                    PathWithDelim(ExtractFileDir(application.ExeName)) + 'Schemas\',
                    PathWithDelim(APathSchemas)) + Servico;

 if not FilesExists(schema_filename)
  then raise Exception.Create('Arquivo ' + schema_filename + ' não encontrado.');

 if RightStr(URL, 1) = '/'
  then Schema.add( URL + Servico, schema_filename )
  else Schema.add( URL, schema_filename );

 DOMDocument.schemas := Schema;

 ParseError := DOMDocument.validate;
 Result     := (ParseError.errorCode = 0);
 Msg        := ParseError.reason;

 DOMDocument := nil;
 ParseError  := nil;
 Schema      := nil;
end;
{$ENDIF}

class function NotaUtil.Valida(const AXML: AnsiString;
                               var AMsg: AnsiString;
                               const APathSchemas: string = '';
                               AURL: string = '';
                               AServico: string = '';
                               APrefixo: string = ''): Boolean;
begin
{$IFDEF ACBrNFSeOpenSSL}
  Result := ValidaLibXML(AXML,AMsg, APathSchemas);
{$ELSE}
  Result := ValidaMSXML(AXML,AMsg, APathSchemas, AURL, AServico, APrefixo);
{$ENDIF}
end;

{$IFDEF ACBrNFSeOpenSSL}
function AssinarLibXML(const AXML, ArqPFX, PFXSenha : AnsiString;
  out AXMLAssinado, FMensagem: AnsiString; ALote: Boolean = False): Boolean;
 Var I, J, PosIni, PosFim : Integer;
     URI, AStr, XmlAss : AnsiString;
     Tipo : Integer; // 1 - NFE 2 - Cancelamento 3 - Inutilizacao
     Cert: TMemoryStream;
     Cert2: TStringStream;
begin
  AStr := AXML;

  //// Encontrando o URI ////
  I    := pos('<EnviarLoteRpsEnvio',AStr);
  Tipo := 1;

  if I = 0  then
   begin
     I := pos('<Rps',AStr);
     if I > 0 then
        Tipo := 2;
   end;

  I := NotaUtil.PosEx('Id=',AStr,I+6);
  if I = 0 then
     raise Exception.Create('Não encontrei inicio do URI: Id=');
  I := NotaUtil.PosEx('"',AStr,I+2);
  if I = 0 then
     raise Exception.Create('Não encontrei inicio do URI: aspas inicial');
  J := NotaUtil.PosEx('"',AStr,I+1);
  if J = 0 then
     raise Exception.Create('Não encontrei inicio do URI: aspas final');

  URI := copy(AStr,I+1,J-I-1);

  //// Adicionando Cabeçalho DTD, necessário para xmlsec encontrar o ID ////
  I := pos('?>',AStr);

  if Tipo = 1 then
     AStr := copy(AStr,1,StrToInt(VarToStr(NotaUtil.SeSenao(I>0,I+1,I)))) + cDTDLote + Copy(AStr,StrToInt(VarToStr(NotaUtil.SeSenao(I>0,I+2,I))),Length(AStr))
  else if Tipo = 2 then
     AStr := copy(AStr,1,StrToInt(VarToStr(NotaUtil.SeSenao(I>0,I+1,I)))) + cDTDRps + Copy(AStr,StrToInt(VarToStr(NotaUtil.SeSenao(I>0,I+2,I))),Length(AStr));

  //// Inserindo Template da Assinatura digital ////
  if Tipo = 1 then
   begin
     I := pos('</EnviarLoteRpsEnvio>',AStr);
     if I = 0 then
        raise Exception.Create('Não encontrei final do XML: </EnviarLoteRpsEnvio>');
   end
  else if Tipo = 2 then
   begin
     I := pos('</Rps>',AStr);
     if I = 0 then
        raise Exception.Create('Não encontrei final do XML: </Rps>');
   end;

  if pos('<Signature',AStr) > 0 then
     I    := pos('<Signature',AStr);
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
     AStr := AStr + '</EnviarLoteRpsEnvio>'
  else if Tipo = 2 then
     AStr := AStr + '</Rps>';

  if FileExists(ArqPFX) then
    XmlAss := NotaUtil.sign_file(PChar(AStr), PChar(ArqPFX), PChar(PFXSenha))
  else
   begin
    Cert  := TMemoryStream.Create;
    Cert2 := TStringStream.Create(ArqPFX);

    Cert.LoadFromStream(Cert2);

    XmlAss := NotaUtil.sign_memory(PChar(AStr), PChar(ArqPFX), PChar(PFXSenha), Cert.Size, Cert.Memory);
  end;

  // Removendo quebras de linha //
  XmlAss := StringReplace( XmlAss, #10, '', [rfReplaceAll] );
  XmlAss := StringReplace( XmlAss, #13, '', [rfReplaceAll] );

  // Removendo DTD //
  if Tipo = 1 then
     XmlAss := StringReplace( XmlAss, cDTDLote, '', [] )
  else if Tipo = 2 then
     XmlAss := StringReplace( XmlAss, cDTDRps , '', [] );

  PosIni := Pos('<X509Certificate>',XmlAss)-1;
  PosFim := NotaUtil.PosLast('<X509Certificate>',XmlAss);

  XmlAss := copy(XmlAss,1,PosIni)+copy(XmlAss,PosFim,length(XmlAss));

  AXMLAssinado := XmlAss;

  Result := True;
end;

{$ELSE}

// Alterado por Italo em 12/07/2012
function AssinarMSXML(XML : AnsiString;
                      Certificado : ICertificate2;
                      out XMLAssinado : AnsiString;
                      ALote: Boolean = False;
                      APrefixo3: string = '';
                      APrefixo4: string = '';
                      AProvedor: TnfseProvedor = proNenhum): Boolean;
var
 I,
 J,
 PosIni,
 PosFim,
 PosIniAssLote : Integer;

 URI, AID,
 Identificador : String;

 AXML,
 Assinatura,
 xmlHeaderAntes,
 xmlHeaderDepois : AnsiString;

 xmldoc    : IXMLDOMDocument3;
 xmldsig   : IXMLDigitalSignature;
 dsigKey   : IXMLDSigKey;
 signedKey : IXMLDSigKey;
begin
 AXML := XML;

 if ALote
  then begin
   Identificador := 'Id';
   I             := pos('LoteRps Id=', AXML);
   if I = 0
    then begin
     Identificador := 'id';
     I             := pos('LoteRps id=', AXML);
    end;
   if I = 0
    then begin
     Identificador := '';
     URI           := '';
    end
    else begin
     I := NotaUtil.PosEx('"', AXML, I + 2);
     if I = 0
      then raise Exception.Create('Não encontrei inicio do URI: aspas inicial');
     J := NotaUtil.PosEx('"', AXML, I + 1);
     if J = 0
      then raise Exception.Create('Não encontrei inicio do URI: aspas final');

     URI := copy(AXML, I + 1, J - I - 1);
    end;

//   if Identificador = 'id' then URI := '';

   AXML := copy(AXML, 1, pos('</'+ APrefixo3 + 'EnviarLoteRpsEnvio>', AXML) - 1);

   if (URI = '') {or (AProvedor = profintelISS)}
    then AID := '>'
    else AID := ' '+Identificador+'="AssLote_'+ URI +'">';

   AXML := AXML + '<Signature xmlns="http://www.w3.org/2000/09/xmldsig#"'+ AID +
//                  NotaUtil.SeSenao(URI = '', '>', ' '+Identificador+'="AssLote_'+ URI +'">') +
                 '<SignedInfo>'+
                  '<CanonicalizationMethod Algorithm="http://www.w3.org/TR/2001/REC-xml-c14n-20010315"/>'+
                  '<SignatureMethod Algorithm="http://www.w3.org/2000/09/xmldsig#rsa-sha1" />'+
                  '<Reference URI="' + NotaUtil.SeSenao(URI = '', '">', '#' + URI + '">') +
                   '<Transforms>'+
                    '<Transform Algorithm="http://www.w3.org/2000/09/xmldsig#enveloped-signature" />'+
                   NotaUtil.SeSenao(AProvedor = profintelISS, '',
                    '<Transform Algorithm="http://www.w3.org/TR/2001/REC-xml-c14n-20010315" />') +
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

   AXML := AXML + '</'+ APrefixo3 + 'EnviarLoteRpsEnvio>';

  end
  else begin

   // Ao assinar um RPS a tag não possui prefixo
   APrefixo3 := '';

   if Pos('<Signature', AXML) <= 0
    then begin
     Identificador := 'Id';
     I             := pos('Id=', AXML);
     if I = 0
      then begin
       Identificador := 'id';
       I             := pos('id=', AXML);
       if I = 0
        then Identificador := '';
  //      raise Exception.Create('Não encontrei inicio do URI: Id=');
      end;
     if I <> 0
      then begin
       I := NotaUtil.PosEx('"', AXML, I + 2);
       if I = 0
        then raise Exception.Create('Não encontrei inicio do URI: aspas inicial');
       J := NotaUtil.PosEx('"', AXML, I + 1);
       if J = 0
        then raise Exception.Create('Não encontrei inicio do URI: aspas final');

       URI := copy(AXML, I + 1, J - I - 1);
      end
      else URI := '';

     if (URI = '') or (AProvedor = profintelISS)
      then AID := '>'
      else AID := ' '+Identificador+'="Ass_'+ URI +'">';

     Assinatura := '<Signature xmlns="http://www.w3.org/2000/09/xmldsig#"' + AID +
//                        NotaUtil.SeSenao(URI = '', '>', ' ' + Identificador + '="Ass_' + URI + '">') +
                    '<SignedInfo>' +
                    '<CanonicalizationMethod Algorithm="http://www.w3.org/TR/2001/REC-xml-c14n-20010315"/>' +
                     '<SignatureMethod Algorithm="http://www.w3.org/2000/09/xmldsig#rsa-sha1" />' +
                     '<Reference URI="' + NotaUtil.SeSenao(URI = '', '">', '#' + URI + '">') +
                      '<Transforms>' +
                       '<Transform Algorithm="http://www.w3.org/2000/09/xmldsig#enveloped-signature" />' +
                       NotaUtil.SeSenao(AProvedor = profintelISS, '',
                       '<Transform Algorithm="http://www.w3.org/TR/2001/REC-xml-c14n-20010315" />') +
                      '</Transforms>' +
                      '<DigestMethod Algorithm="http://www.w3.org/2000/09/xmldsig#sha1" />' +
                      '<DigestValue></DigestValue>' +
                     '</Reference>' +
                    '</SignedInfo>' +
                    '<SignatureValue></SignatureValue>' +
                    '<KeyInfo>' +
                     '<X509Data>' +
                       '<X509Certificate></X509Certificate>' +
                     '</X509Data>' +
                    '</KeyInfo>' +
                   '</Signature>';

     case AProvedor of
      profintelISS,
      proSaatri:    begin
                     AXML := copy(AXML, 1, pos('</InfDeclaracaoPrestacaoServico>', AXML) - 1);
                     AXML := AXML + '</InfDeclaracaoPrestacaoServico>';
                     AXML := AXML + Assinatura;
                     AXML := AXML + '</Rps>';
                    end;
      else begin
            AXML := copy(AXML, 1, pos('</Rps>', AXML) - 1);
            AXML := AXML + Assinatura;
            AXML := AXML + '</Rps>';
           end;
     end;

    end;

  end;

 // Lendo Header antes de assinar //
 xmlHeaderAntes := '';
 I              := pos('?>', AXML);
 if I > 0
  then xmlHeaderAntes := copy(AXML, 1, I + 1);

 xmldoc := CoDOMDocument50.Create;

 xmldoc.async              := False;
 xmldoc.validateOnParse    := False;
 xmldoc.preserveWhiteSpace := True;

 xmldsig := CoMXDigitalSignature50.Create;

 if (not xmldoc.loadXML(AXML))
  then raise Exception.Create('Não foi possível carregar o arquivo: ' + AXML);

 xmldoc.setProperty('SelectionNamespaces', DSIGNS);

 if ALote
  then begin
   if (URI <> '') {and (AProvedor <> profintelISS) }
    then xmldsig.signature := xmldoc.selectSingleNode('.//ds:Signature[@'+Identificador+'="AssLote_'+ URI +'"]')
    else xmldsig.signature := xmldoc.selectSingleNode('.//ds:Signature');
//    else xmldsig.signature := xmldoc.selectSingleNode('.//EnviarLoteRpsEnvio//ds:Signature');
  end
  else xmldsig.signature := xmldoc.selectSingleNode('.//ds:Signature');

 if (xmldsig.signature = nil)
  then raise Exception.Create('É preciso carregar o template antes de assinar.');

 if NumCertCarregado <> Certificado.SerialNumber
  then CertStoreMem := nil;

 if  CertStoreMem = nil
  then begin
   CertStore := CoStore.Create;
   CertStore.Open(CAPICOM_CURRENT_USER_STORE, 'My', CAPICOM_STORE_OPEN_MAXIMUM_ALLOWED);

   CertStoreMem := CoStore.Create;
   CertStoreMem.Open(CAPICOM_MEMORY_STORE, 'Memoria', CAPICOM_STORE_OPEN_MAXIMUM_ALLOWED);

   Certs := CertStore.Certificates as ICertificates2;
   for i := 1 to Certs.Count do
    begin
     Cert := IInterface(Certs.Item[i]) as ICertificate2;
     if Cert.SerialNumber = Certificado.SerialNumber
      then begin
       CertStoreMem.Add(Cert);
        NumCertCarregado := Certificado.SerialNumber;
      end;
    end;
 end;

 OleCheck(IDispatch(Certificado.PrivateKey).QueryInterface(IPrivateKey,PrivateKey));
 xmldsig.store := CertStoreMem;

 dsigKey := xmldsig.createKeyFromCSP(PrivateKey.ProviderType, PrivateKey.ProviderName, PrivateKey.ContainerName, 0);
 if (dsigKey = nil)
  then raise Exception.Create('Erro ao criar a chave do CSP.');

 signedKey := xmldsig.sign(dsigKey, $00000002);
 if (signedKey <> nil)
  then begin
   XMLAssinado := xmldoc.xml;
   XMLAssinado := StringReplace( XMLAssinado, #10, '', [rfReplaceAll] );
   XMLAssinado := StringReplace( XMLAssinado, #13, '', [rfReplaceAll] );

 case AProvedor of
  profintelISS,
  proSaatri:    begin
                 //By Akai - L. Massao Aihara ==================================
                 //MUDA A ASSINATURA...
                 //para não criar uma variavel usei a XMLAssinado mesmo...
                 //como o acbr estava gerando algumas coisas que não tinha no exemplo da Prefeitura de PG
                 //so fiz um processo para remover o "excesso"!!!
                 if not ALote then
                  begin
                   AXML := copy(XML, 1, pos('</'+ APrefixo3 + 'InfDeclaracaoPrestacaoServico>', XML) - 1);
                   AXML := AXML + '</'+ APrefixo3 + 'InfDeclaracaoPrestacaoServico>';
                   I    := pos('<Signature', XMLAssinado);

                   XMLAssinado := copy(XMLAssinado, I, pos('</Signature>', XMLAssinado) - I);
                   I           := pos('>', XMLAssinado);
                   XMLAssinado := StringReplace(XMLAssinado, Copy(XMLAssinado, 54, I - 54), '', []);

//                   I           := pos('<KeyInfo>', XMLAssinado);
//                   XMLAssinado := StringReplace(XMLAssinado, copy(XMLAssinado, I, pos('</KeyInfo>', XMLAssinado) - I), '', []);
//                   XMLAssinado := StringReplace(XMLAssinado, '</KeyInfo>', '', []);

                   AXML := AXML + XMLAssinado;
                   AXML := AXML + '</Signature>';
                   AXML := AXML + '</Rps>';

                   XMLAssinado := AXML;
                  end
                  else
                  //Se for o LOTE...
                  //essa parte não precisava, ja a prefeitura ja estava retornando a msg "correta"...
                  //mas como no exemplo da prefeitura estava diferente, alterei tbm...
                  begin
                   AXML := copy(XML, 1, pos('</LoteRps>', XML) - 1);
                   AXML := AXML + '</LoteRps>';
                   I    := pos('</LoteRps>', XMLAssinado);

                   XMLAssinado := copy(XMLAssinado, I, pos('</EnviarLoteRpsEnvio>', XMLAssinado) - I);
                   XMLAssinado := StringReplace(XMLAssinado, '</LoteRps>', '', []);
                   I           := pos('>', XMLAssinado);
                   XMLAssinado := StringReplace(XMLAssinado, Copy(XMLAssinado, 54, I - 54), '', []);

//                   I           := pos('<KeyInfo>', XMLAssinado);
//                   XMLAssinado := StringReplace(XMLAssinado, copy(XMLAssinado, I, pos('</KeyInfo>', XMLAssinado) - I), '', []);
//                   XMLAssinado := StringReplace(XMLAssinado, '</KeyInfo>', '', []);

                   AXML := AXML + XMLAssinado;
                   AXML := AXML + '</EnviarLoteRpsEnvio>';

                   XMLAssinado := AXML;
                  end;
                 //Fim alteração Akai ==========================================

                 (*
                 // Variavel XML contem o XML original de entrada na função
                 // sem assinatura.
                 AXML := copy(XML, 1, pos('</'+ APrefixo3 + 'InfDeclaracaoPrestacaoServico>', XML) - 1);
                 AXML := AXML + '</'+ APrefixo3 + 'InfDeclaracaoPrestacaoServico>';
                 I    := pos('<Signature', XMLAssinado);
                 AXML := AXML + copy(XMLAssinado, I, pos('</Signature>', XMLAssinado) - I);
                 AXML := AXML + '</Signature>';
                 AXML := AXML + '</Rps>';

                 XMLAssinado := AXML;
                 *)
                end;
 end;



   if ALote
    then begin
     // Sugestão de Rodrigo Cantelli
     PosIniAssLote := Pos('</'+ APrefixo3 + 'LoteRps>', XMLAssinado);

     if PosIniAssLote = 0
      then PosIniAssLote := Pos('</LoteRps>', XMLAssinado) + length('</LoteRps>')
      else PosIniAssLote := PosIniAssLote + length('</'+ APrefixo3 + 'LoteRps>');

     PosIni      := NotaUtil.PosEx('<SignatureValue>', XMLAssinado, PosIniAssLote) + length('<SignatureValue>');
     XMLAssinado := copy(XMLAssinado, 1, PosIni - 1) +
                    StringReplace( copy(XMLAssinado, PosIni, length(XMLAssinado)), ' ', '', [rfReplaceAll] );

     // Sugestão de Rodrigo Cantelli
     PosIniAssLote := Pos('</'+ APrefixo3 + 'LoteRps>', XMLAssinado);

     if PosIniAssLote = 0
      then PosIniAssLote := Pos('</LoteRps>', XMLAssinado) + length('</LoteRps>')
      else PosIniAssLote := PosIniAssLote + length('</'+ APrefixo3 + 'LoteRps>');

     PosIni      := NotaUtil.PosEx('<X509Certificate>', XMLAssinado, PosIniAssLote) - 1;
     PosFim      := NotaUtil.PosLast('<X509Certificate>', XMLAssinado);
     XMLAssinado := copy(XMLAssinado, 1, PosIni) +
                    copy(XMLAssinado, PosFim, length(XMLAssinado));
    end
    else begin
     PosIni      := Pos('<SignatureValue>', XMLAssinado) + length('<SignatureValue>');
     XMLAssinado := copy(XMLAssinado, 1, PosIni - 1) +
                    StringReplace( copy(XMLAssinado, PosIni, length(XMLAssinado)), ' ', '', [rfReplaceAll] );
     PosIni      := Pos('<X509Certificate>', XMLAssinado) - 1;
     PosFim      := NotaUtil.PosLast('<X509Certificate>', XMLAssinado);
     XMLAssinado := copy(XMLAssinado, 1, PosIni) +
                    copy(XMLAssinado, PosFim, length(XMLAssinado));
    end;
  end
  else raise Exception.Create('Assinatura Falhou.');

 if xmlHeaderAntes <> ''
  then begin
   I := pos('?>',XMLAssinado);
   if I > 0
    then begin
     xmlHeaderDepois := copy(XMLAssinado,1,I+1);
     if xmlHeaderAntes <> xmlHeaderDepois
      then XMLAssinado := StuffString(XMLAssinado,1,length(xmlHeaderDepois),xmlHeaderAntes);
    end
    else XMLAssinado := xmlHeaderAntes + XMLAssinado;
  end;

 dsigKey   := nil;
 signedKey := nil;
 xmldoc    := nil;
 xmldsig   := nil;

 Result := True;
end;
{$ENDIF}

{$IFDEF ACBrNFSeOpenSSL}
class function NotaUtil.Assinar(const AXML, ArqPFX, PFXSenha: AnsiString;
                                out AXMLAssinado, FMensagem: AnsiString;
                                ALote: Boolean = False): Boolean;
{$ELSE}
// Alterado por Italo em 12/07/2012
class function NotaUtil.Assinar(const AXML: AnsiString;
                                Certificado : ICertificate2;
                                out AXMLAssinado, FMensagem: AnsiString;
                                ALote: Boolean = False;
                                APrefixo3: string = '';
                                APrefixo4: string = '';
                                AProvedor: TnfseProvedor = proNenhum): Boolean;
{$ENDIF}
begin
{$IFDEF ACBrNFSeOpenSSL}
  Result := AssinarLibXML(AXML, ArqPFX, PFXSenha, AXMLAssinado, FMensagem, ALote);
{$ELSE}
  // Alterado por Italo em 12/07/2012
  Result := AssinarMSXML(AXML, Certificado, AXMLAssinado, ALote, APrefixo3, APrefixo4, AProvedor);
{$ENDIF}
end;

class function NotaUtil.StringToFloat(AValue: String): Double;
begin
  AValue := Trim( AValue );

  if DecimalSeparator <> '.' then
     AValue := StringReplace(AValue,'.',DecimalSeparator,[rfReplaceAll]);

  if DecimalSeparator <> ',' then
     AValue := StringReplace(AValue,',',DecimalSeparator,[rfReplaceAll]);

  Result := StrToFloat(AValue);
end;

class function NotaUtil.StringToFloatDef(const AValue: String;
  const DefaultValue: Double): Double;
begin
  try
     Result := StringToFloat( AValue );
  except
     Result := DefaultValue;
  end;
end;

class procedure NotaUtil.ConfAmbiente;
begin
  DecimalSeparator := ',';
end;

class function NotaUtil.PathAplication: String;
begin
  Result := ExtractFilePath(Application.ExeName);
end;

class function NotaUtil.CollateBr(Str: String): String;
var
   i, wTamanho: integer;
   wChar, wResultado: Char;
begin
   result   := '';
   wtamanho := Length(Str);
   i        := 1;
   while (i <= wtamanho) do
   begin
      wChar := Str[i];
      case wChar of
         'á', 'â', 'ã', 'à', 'ä', 'å',
         'Á', 'Â', 'Ã', 'À', 'Ä', 'Å': wResultado := 'A';
         'é', 'ê', 'è', 'ë',
         'É', 'Ê', 'È', 'Ë': wResultado := 'E';
         'í', 'î', 'ì', 'ï',
         'Í', 'Î', 'Ì', 'Ï': wResultado := 'I';
         'ó', 'ô', 'õ', 'ò', 'ö',
         'Ó', 'Ô', 'Õ', 'Ò', 'Ö': wResultado := 'O';
         'ú', 'û', 'ù', 'ü',
         'Ú', 'Û', 'Ù', 'Ü': wResultado := 'U';
         'ç', 'Ç': wResultado := 'C';
         'ñ', 'Ñ': wResultado := 'N';
         'ý', 'ÿ', 'Ý', 'Y': wResultado := 'Y';
      else
         wResultado := wChar;
      end;
      i      := i + 1;
      Result := Result + wResultado;
   end;
   Result := UpperCase(Result);
end;

class function NotaUtil.UpperCase2(Str: String): String;
var
   i, wTamanho: integer;
   wChar, wResultado: Char;
begin
   result   := '';
   wtamanho := Length(Str);
   i        := 1;
   while (i <= wtamanho) do
   begin
      wChar := Str[i];
      case wChar of
         'á','Á': wResultado := 'Á';
         'ã','Ã': wResultado := 'Ã';
         'à','À': wResultado := 'À';
         'â','Â': wResultado := 'Â';
         'ä','Ä': wResultado := 'Ä';
         'å','Å': wResultado := 'Å';
         'é','É': wResultado := 'É';
         'è','È': wResultado := 'È';
         'ê','Ê': wResultado := 'Ê';
         'ë','Ë': wResultado := 'Ë';
         'í','Í': wResultado := 'Í';
         'ì','Ì': wResultado := 'Ì';
         'î','Î': wResultado := 'Î';
         'ï','Ï': wResultado := 'Ï';
         'ó','Ó': wResultado := 'Ó';
         'õ','Õ': wResultado := 'Õ';
         'ò','Ò': wResultado := 'Ò';
         'ô','Ô': wResultado := 'Ô';
         'ö','Ö': wResultado := 'Ö';
         'ú','Ú': wResultado := 'Ú';
         'ù','Ù': wResultado := 'Ù';
         'û','Û': wResultado := 'Û';
         'ü','Ü': wResultado := 'Ü';
         'ç', 'Ç': wResultado := 'Ç';
         'ñ', 'Ñ': wResultado := 'Ñ';
         'ý', 'ÿ', 'Ý', 'Y': wResultado := 'Y';
      else
         wResultado := wChar;
      end;
      i      := i + 1;
      Result := Result + wResultado;
   end;
   Result := UpperCase(Result);
end;

class function NotaUtil.PathWithDelim( const APath : String ) : String;
begin
  Result := Trim(APath);
  if Result <> '' then
     if RightStr(Result,1) <> PathDelim then   { Tem delimitador no final ? }
        Result := Result + PathDelim;
end;

class function NotaUtil.RetornarConteudoEntre(const Frase, Inicio, Fim: string): string;
var
  i: integer;
  s: string;
begin
  result := '';
  i      := pos(Inicio, Frase);
  if i = 0 then
    exit;
  s      := Copy(Frase, i + length(Inicio), maxInt);
  result := Copy(s, 1, pos(Fim, s) - 1);
end;

class function NotaUtil.AssinarXML(AXML, FURI, FTagI, FTagF: AnsiString; Certificado : ICertificate2; out AXMLAssinado, FMensagem: AnsiString): Boolean;
var
 I, PosIni, PosFim : Integer;

 xmlHeaderAntes, xmlHeaderDepois : AnsiString;

 xmldoc    : IXMLDOMDocument3;
 xmldsig   : IXMLDigitalSignature;
 dsigKey   : IXMLDSigKey;
 signedKey : IXMLDSigKey;
begin
   AXML := AXML+'<Signature xmlns="http://www.w3.org/2000/09/xmldsig#"'+
                     NotaUtil.SeSenao(FURI = '', '',' Id="Ass_'+ FURI +'"')+'>'+
                 '<SignedInfo>'+
                  '<CanonicalizationMethod Algorithm="http://www.w3.org/TR/2001/REC-xml-c14n-20010315" />'+
                  '<SignatureMethod Algorithm="http://www.w3.org/2000/09/xmldsig#rsa-sha1" />'+
                  '<Reference URI="'+NotaUtil.SeSenao(FURI = '', '','#'+FURI)+'">'+
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

 AXML := FTagI + AXML + FTagF;

 // Lendo Header antes de assinar //
 xmlHeaderAntes := '';
 I              := pos('?>',AXML);
 if I > 0
  then xmlHeaderAntes := copy(AXML,1,I+1);

 xmldoc := CoDOMDocument50.Create;

 xmldoc.async              := False;
 xmldoc.validateOnParse    := False;
 xmldoc.preserveWhiteSpace := True;

 xmldsig := CoMXDigitalSignature50.Create;

 if (not xmldoc.loadXML(AXML) )
  then raise Exception.Create('Não foi possível carregar o arquivo: '+AXML);

 xmldoc.setProperty('SelectionNamespaces', DSIGNS);

 xmldsig.signature := xmldoc.selectSingleNode('.//ds:Signature');

 if (xmldsig.signature = nil)
  then raise Exception.Create('É preciso carregar o template antes de assinar.');

 if NumCertCarregado <> Certificado.SerialNumber
  then CertStoreMem := nil;

 if  CertStoreMem = nil
  then begin
   CertStore := CoStore.Create;
   CertStore.Open(CAPICOM_CURRENT_USER_STORE, 'My', CAPICOM_STORE_OPEN_MAXIMUM_ALLOWED);

   CertStoreMem := CoStore.Create;
   CertStoreMem.Open(CAPICOM_MEMORY_STORE, 'Memoria', CAPICOM_STORE_OPEN_MAXIMUM_ALLOWED);

   Certs := CertStore.Certificates as ICertificates2;
   for i := 1 to Certs.Count do
    begin
     Cert := IInterface(Certs.Item[i]) as ICertificate2;
     if Cert.SerialNumber = Certificado.SerialNumber
      then begin
       CertStoreMem.Add(Cert);
        NumCertCarregado := Certificado.SerialNumber;
      end;
    end;
 end;

 OleCheck(IDispatch(Certificado.PrivateKey).QueryInterface(IPrivateKey,PrivateKey));
 xmldsig.store := CertStoreMem;

 dsigKey := xmldsig.createKeyFromCSP(PrivateKey.ProviderType, PrivateKey.ProviderName, PrivateKey.ContainerName, 0);
 if (dsigKey = nil)
  then raise Exception.Create('Erro ao criar a chave do CSP.');

 signedKey := xmldsig.sign(dsigKey, $00000002);
 if (signedKey <> nil)
  then begin
   AXMLAssinado := xmldoc.xml;
   AXMLAssinado := StringReplace( AXMLAssinado, #10, '', [rfReplaceAll] );
   AXMLAssinado := StringReplace( AXMLAssinado, #13, '', [rfReplaceAll] );

   PosIni       := Pos('<SignatureValue>',AXMLAssinado)+length('<SignatureValue>');
   AXMLAssinado := copy(AXMLAssinado,1,PosIni-1)+StringReplace( copy(AXMLAssinado,PosIni,length(AXMLAssinado)), ' ', '', [rfReplaceAll] );
   PosIni       := Pos('<X509Certificate>',AXMLAssinado)-1;
   PosFim       := NotaUtil.PosLast('<X509Certificate>',AXMLAssinado);
   AXMLAssinado := copy(AXMLAssinado, 1, PosIni) +
                   copy(AXMLAssinado, PosFim, length(AXMLAssinado));
  end
  else raise Exception.Create('Assinatura Falhou.');

 if xmlHeaderAntes <> ''
  then begin
   I := pos('?>',AXMLAssinado);
   if I > 0
    then begin
     xmlHeaderDepois := copy(AXMLAssinado,1,I+1);
     if xmlHeaderAntes <> xmlHeaderDepois
      then AXMLAssinado := StuffString(AXMLAssinado,1,length(xmlHeaderDepois),xmlHeaderAntes);
    end
    else AXMLAssinado := xmlHeaderAntes + AXMLAssinado;
  end;

 dsigKey   := nil;
 signedKey := nil;
 xmldoc    := nil;
 xmldsig   := nil;

 Result := True;
end;

class function NotaUtil.RetirarPrefixos(AXML: String): String;
begin
 AXML := StringReplace( AXML, 'ns2:', '', [rfReplaceAll] );
 AXML := StringReplace( AXML, 'ns3:', '', [rfReplaceAll] );
 AXML := StringReplace( AXML, 'ns4:', '', [rfReplaceAll] );
 AXML := StringReplace( AXML, 'tc:', '', [rfReplaceAll] );

 result := AXML;
end;

class function NotaUtil.VersaoXML(AXML: String): String;
var
 i: Integer;
begin
 i := Pos( '<Cidade>', AXML );
 if i > 0
  then result := '1'
  else result := '2';
end;

end.
