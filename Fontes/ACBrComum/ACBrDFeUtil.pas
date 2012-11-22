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
|* 22/11/2012: Italo Junior e Isaque Pinheiro
|*  - Unificação de funções de mesma funcionalidade das units:
|* ACBrNFeUtil
|* ACBrNFEsUtil
|* ACBrCTeUtil
******************************************************************************}

{$I ACBr.inc}

unit ACBrDFeUtil;

interface

uses
  Classes, Forms,
  {$IFDEF FPC}
    LResources, Controls, Graphics, Dialogs
  {$ELSE}
    StrUtils,
    SysUtils
  {$ENDIF};

type
  EACBrDFeException = class(Exception);

  DFeUtil = class
   private
   protected

   public
     {$IFDEF ACBrNFSeOpenSSL}
 //      class function sign_file(const Axml: PAnsiChar; const key_file: PChar; const senha: PChar): AnsiString;
 //      class function sign_memory(const Axml: PChar; const key_file: Pchar; const senha: PChar; Size: Cardinal; Ponteiro: Pointer): AnsiString;
 //      class Procedure InitXmlSec;
 //      class Procedure ShutDownXmlSec;
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
     class function StringToTime(const AString: string): TDateTime;
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
 //    class function Valida(const AXML: AnsiString;
 //                          var AMsg: AnsiString;
 //                          const APathSchemas: string = '';
 //                          AURL: string = '';
 //                          AServico: string = '';
 //                          APrefixo: string = ''): Boolean;
 //    {$IFDEF ACBrNFSeOpenSSL}
 //      class function Assinar(const AXML, ArqPFX, PFXSenha: AnsiString;
 //                             out AXMLAssinado, FMensagem: AnsiString;
 //                             ALote: Boolean = False;
 //                             APrefixo3: string = '';
 //                             APrefixo4: string = '';
 //                             AProvedor: TnfseProvedor = proNenhum): Boolean;
 //    {$ELSE}
 //       Alterado por Italo em 12/07/2012
 //      class function Assinar(const AXML: AnsiString;
 //                             Certificado : ICertificate2;
 //                             out AXMLAssinado, FMensagem: AnsiString;
 //                             ALote: Boolean = False;
 //                             APrefixo3: string = '';
 //                             APrefixo4: string = '';
 //                             AProvedor: TnfseProvedor = proNenhum): Boolean;
 //    {$ENDIF}
     class function StringToFloat(AValue : String ) : Double;
     class function StringToFloatDef(const AValue: String; const DefaultValue: Double): Double;
 //    class procedure ConfAmbiente;
 //    class function PathAplication: String;
 //    class function CollateBr(Str: String): String;
 //    class function UpperCase2(Str: String): String;
 //    class function PathWithDelim( const APath : String ) : String;
 //    class function RetornarConteudoEntre(const Frase, Inicio, Fim: string): string;

     // Alterado por Italo em 29/10/2012
 //    {$IFDEF ACBrNFSeOpenSSL}
 //     class function AssinarXML(AXML, FURI, FTagI, FTagF, ArqPFX, PFXSenha: AnsiString;
 //                               out AXMLAssinado, FMensagem: AnsiString): Boolean;
 //    {$ELSE}
 //     class function AssinarXML(AXML, FURI, FTagI, FTagF: AnsiString; Certificado : ICertificate2;
 //                               out AXMLAssinado, FMensagem: AnsiString): Boolean;
 //    {$ENDIF}
 //    class function RetirarPrefixos(AXML: String): String;
 //    class function VersaoXML(AXML: String): String;

   published

   end;

implementation

uses
 {$IFDEF ACBrNFSeOpenSSL}
   libxml2, libxmlsec, libxslt,
 {$ELSE}
   ComObj,
 {$ENDIF}
 IniFiles, Variants, ACBrUtil;

class function DFeUtil.EstaVazio(const AValue: String): Boolean;
begin
  Result := (Trim(AValue) = '');
end;

class function DFeUtil.CortaD(const AString: string;
  const ATamanho: Integer): String;
begin
  Result := copy(AString,1,ATamanho);
end;

class function DFeUtil.CortaE(const AString: string;
  const ATamanho: Integer): String;
begin
  Result := AString;
  if Length(AString) > ATamanho then
    Result := copy(AString, Length(AString)-ATamanho+1, length(AString));
end;

class procedure DFeUtil.EstaVazio(const AValue, AMensagem: String);
begin
  if EstaVazio(AValue) then
    raise Exception.Create(AMensagem);
end;

class function DFeUtil.EstaZerado(AValue: Double): Boolean;
begin
  Result := (AValue = 0);
end;

class function DFeUtil.EstaZerado(AValue: Integer): Boolean;
begin
  Result := (AValue = 0);
end;

class procedure DFeUtil.EstaZerado(AValue: Integer; AMensagem: String);
begin
  if EstaZerado(AValue) then
    raise Exception.Create(AMensagem);
end;

class function DFeUtil.FormatarCEP(AValue: String): String;
begin
   //-- tem diferença entre as três
end;

class function DFeUtil.FormatarCNPJ(AValue: String): String;
begin
  if Length(AValue) = 0 then
     Result := AValue
  else
   begin
     AValue := LimpaNumero(AValue);
     Result := copy(AValue,1,2) + '.' + copy(AValue,3,3) + '.' +
               copy(AValue,6,3) + '/' + copy(AValue,9,4) + '-' + copy(AValue,13,2) ;
   end;
end;

class function DFeUtil.FormatarCPF(AValue: String): String;
begin
  if Length(AValue) = 0 then
     Result := AValue
  else
   begin
      AValue := LimpaNumero(AValue);
     Result := copy(AValue,1,3) + '.' + copy(AValue,4 ,3) + '.' +
               copy(AValue,7,3) + '-' + copy(AValue,10,2) ;
   end;
end;

class function DFeUtil.FormatarFone(AValue: String): String;
begin
   //-- tem diferença entre as três
end;

class function DFeUtil.FormatarNumeroDocumentoFiscal(AValue: String): String;
begin
  AValue := Poem_Zeros(AValue, 9);
  Result := copy(AValue,1,3) + '.' + copy(AValue,4,3)+ '.'+
            copy(AValue,7,3);
end;

class function DFeUtil.FormatDate(const AString: string): String;
var
  vTemp: TDateTime;
{$IFDEF VER140} //D6
{$ELSE}
  vFormatSettings : TFormatSettings;
{$ENDIF}
begin
  try
{$IFDEF VER140} //D6
    DateSeparator := '/';
    ShortDateFormat := 'dd/mm/yyyy';
{$ELSE}
    vFormatSettings.DateSeparator   := '-';
    vFormatSettings.ShortDateFormat := 'yyyy-mm-dd';
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

class function DFeUtil.FormatDateTime(const AString: string): string;
var
  vTemp : TDateTime;
{$IFDEF VER140} //delphi6
{$ELSE}
vFormatSettings: TFormatSettings;
{$ENDIF}
begin
  try
{$IFDEF VER140} //delphi6
    DateSeparator   := '/';
    ShortDateFormat := 'dd/mm/yyyy';
    ShortTimeFormat := 'hh:nn:ss';
{$ELSE}
    vFormatSettings.DateSeparator   := '-';
    vFormatSettings.ShortDateFormat := 'yyyy-mm-dd';
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

class function DFeUtil.FormatFloat(AValue: Extended;
  const AFormat: string): String;
{$IFDEF VER140} //D6
{$ELSE}
var
vFormatSettings: TFormatSettings;
{$ENDIF}
begin
{$IFDEF VER140} //D6
  DecimalSeparator  := ',';
  ThousandSeparator := '.';
  Result := SysUtils.FormatFloat(AFormat, AValue);
{$ELSE}
  vFormatSettings.DecimalSeparator  := ',';
  vFormatSettings.ThousandSeparator := '.';
  Result := SysUtils.FormatFloat(AFormat, AValue, vFormatSettings);
{$ENDIF}
end;

class function DFeUtil.LasString(AString: String): String;
begin
  Result := Copy(AString, Length(AString), Length(AString));
end;

class function DFeUtil.LimpaNumero(AValue: String): String;
var
  A : Integer ;
begin
  Result := '' ;
  For A := 1 to length(AValue) do
  begin
    {$IFDEF DELPHI12_UP}
    if CharInSet(AValue[A], ['0'..'9']) then
    {$ELSE}
    if (AValue[A] in ['0'..'9']) then
    {$ENDIF}
       Result := Result + AValue[A];
  end ;
end;

class function DFeUtil.NaoEstaVazio(AValue: String): Boolean;
begin
  Result := not(EstaVazio(AValue));
end;

class function DFeUtil.NaoEstaZerado(AValue: Double): Boolean;
begin
  Result := not(EstaZerado(AValue));
end;

class function DFeUtil.NaoEstaZerado(AValue: Integer): Boolean;
begin
  Result := not(EstaZerado(AValue));
end;

class function DFeUtil.padC(const AString: string; const nLen: Integer;
  const Caracter: Char): String;
Var nCharLeft : Integer;
    D : Double;
begin
  Result    := copy(AString,1,nLen);
  D         := (nLen - Length( Result )) / 2;
  nCharLeft := Trunc( D );
  Result    := PadE( StringOfChar(Caracter, nCharLeft)+Result, nLen, Caracter);
end;

class function DFeUtil.PadD(const AString: string; const nLen: Integer;
  const Caracter: Char): String;
begin
  Result := copy(AString,1,nLen);
  Result := StringOfChar(Caracter, (nLen - Length(Result))) + Result;
end;

class function DFeUtil.PadE(const AString: string; const nLen: Integer;
  const Caracter: Char): String;
begin
  Result := copy(AString, 1, nLen);
  Result := Result + StringOfChar(Caracter, (nLen - Length(Result)));
end;

class function DFeUtil.Poem_Zeros(const Texto: String;
  const Tamanho: Integer): String;
begin
  Result := PadD(Trim(Texto),Tamanho,'0');
end;

class function DFeUtil.Poem_Zeros(const Valor, Tamanho: Integer): String;
begin
  Result := PadD(IntToStr(Valor), Tamanho, '0');
end;

class function DFeUtil.PosEx(const SubStr, S: AnsiString; Offset: Cardinal = 1): Integer;
var
  I, X           : Integer;
  Len, LenSubStr : Integer;
begin
  if Offset = 1 then
    Result := Pos(SubStr, S)
  else
  begin
    I := Offset;
    LenSubStr := Length(SubStr);
    Len := Length(S) - LenSubStr + 1;
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

class function DFeUtil.PosLast(const SubStr, S: AnsiString): Integer;
var
  P : Integer;
begin
  Result := 0;
  P := Pos(SubStr, S);

  while P <> 0 do
  begin
    Result := P;
    P := PosEx(SubStr, S, P + 1);
  end;
end;

class function DFeUtil.SeSenao(ACondicao: Boolean; ATrue,
  AFalse: Variant): Variant;
begin
  Result := AFalse;
  if ACondicao then
    Result := ATrue;
end;

class function DFeUtil.StringToDate(const AString: string): TDateTime;
begin
  if (AString = '0') or (AString = '') then
     Result := 0
  else
     Result := StrToDate(AString);
end;

class function DFeUtil.StringToFloat(AValue: String): Double;
var
sDecimalSeparator: string;
{$IFDEF VER140} //D6
{$ELSE}
vFormatSettings: TFormatSettings;
{$ENDIF}
begin
{$IFDEF VER140} //D6
  sDecimalSeparator := DecimalSeparator;
{$ELSE}
  sDecimalSeparator := vFormatSettings.DecimalSeparator;
{$ENDIF}

  AValue := Trim( AValue );

  if sDecimalSeparator <> '.' then
     AValue := StringReplace(AValue,'.',sDecimalSeparator,[rfReplaceAll]);

  if sDecimalSeparator <> ',' then
     AValue := StringReplace(AValue,',',sDecimalSeparator,[rfReplaceAll]);

  Result := StrToFloat(AValue);
end;

class function DFeUtil.StringToFloatDef(const AValue: String;
  const DefaultValue: Double): Double;
begin
  try
     Result := StringToFloat( AValue ) ;
  except
     Result := DefaultValue ;
  end ;
end;

class function DFeUtil.StringToTime(const AString: string): TDateTime;
begin
  if (AString = '0') or (AString = '') then
     Result := 0
  else
     Result := StrToTime(AString);
end;

class function DFeUtil.TrataString(const AValue: String): String;
var
  A : Integer ;
begin
  Result := '' ;
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

class function DFeUtil.TamanhoIgual(const AValue: String;
  const ATamanho: Integer): Boolean;
begin
  Result := (Length(AValue)= ATamanho);
end;

class procedure DFeUtil.TamanhoIgual(const AValue: String;
  const ATamanho: Integer; AMensagem: String);
begin
  if not(TamanhoIgual(AValue, ATamanho)) then
    raise EACBrDFeException.Create(AMensagem);
end;

class function DFeUtil.TamanhoIgual(const AValue, ATamanho: Integer): Boolean;
begin
  Result := (Length(IntToStr(AValue))= ATamanho);
end;

class procedure DFeUtil.TamanhoIgual(const AValue, ATamanho: Integer;
  AMensagem: String);
begin
  if not(TamanhoIgual(AValue, ATamanho)) then
    raise EACBrDFeException.Create(AMensagem);
end;

class function DFeUtil.TamanhoMenor(const AValue: String;
  const ATamanho: Integer): Boolean;
begin
  Result := (Length(AValue) < ATamanho);
end;

class function DFeUtil.TrataString(const AValue: String;
  const ATamanho: Integer): String;
begin
  Result := TrataString(CortaD(AValue, ATamanho));
end;

end.
