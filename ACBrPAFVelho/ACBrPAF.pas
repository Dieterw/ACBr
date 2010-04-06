{******************************************************************************}
{ Projeto: Componentes ACBr                                                    }
{  Biblioteca multiplataforma de componentes Delphi para interação com equipa- }
{ mentos de Automação Comercial utilizados no Brasil                           }
{                                                                              }
{ Direitos Autorais Reservados (c) 2009   Isaque Pinheiro                      }
{                                                                              }
{ Colaboradores nesse arquivo:                                                 }
{                                                                              }
{  Você pode obter a última versão desse arquivo na pagina do  Projeto ACBr    }
{ Componentes localizado em      http://www.sourceforge.net/projects/acbr      }
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
|* 10/04/2009: Isaque Pinheiro
|*  - Criação e distribuição da Primeira Versao
*******************************************************************************}

unit ACBrPAF;

interface

uses
   SysUtils, Classes, DateUtils,
   ACBrUtilTXT, ACBrUtil, Forms,
   ACBrPAF_D, ACBrPAF_D_Class,
   ACBrPAF_E, ACBrPAF_E_Class,
   ACBrPAF_P, ACBrPAF_P_Class,
   ACBrPAF_R, ACBrPAF_R_Class,
   ACBrPAF_T, ACBrPAF_T_Class;

const
   CACBrPAF_Versao = '0.03b' ;

   { Usa utilitário de linha de comando, "openssl.exe", para calcular a
       assinatura digital...       http://www.openssl.org/
       Binários para windows:      http://www.openssl.org/related/binaries.html
     NOTA: openssl.exe e suas DLLs (libssl32.dll, ssleay32.dll) precisam
           estar no PATH da máquina ou no mesmo diretório do programa
     Como usar o openssl.exe   ->   http://www.madboa.com/geek/openssl/

     - Para gerar a sua chave Privada usando o "openssl.exe" digite:
          openssl genrsa -out mykey.pem 1024
       ( o arquivo "mykey.pem" conterá a sua chave )

     - Para gerar Publica baseado em uma chave Privada, digite:
          openssl rsa -in mykey.pem -pubout -out pubkey.pem
       ( assume que a sua chave privada está em "mykey.pem", gera chave pública
         no arquivo "pubkey.pem" )                                             }

   { Chave padrão... por motivos de segurança, GERE A SUA PROPRIA CHAVE e
     informe-a em: "OnGetKeyRSA" }
   cRFDRSAKey = '-----BEGIN RSA PRIVATE KEY-----' + sLineBreak +
                'MIICXQIBAAKBgQCtpPqcoOX4rwgdoKi6zJwPX9PA2iX2KxgvyxjE+daI5ZmYxcg0'+ sLineBreak +
                'NScjX59nXRaLmtltVRfsRc1n4+mLSXiWMh3jIbw+TWn+GXKQhS2GitpLVhO3A6Ns'+ sLineBreak +
                'vO1+RuP77s+uGYhqVvbD0Pziq+I2r4oktsjTbpnC7Mof3BjJdIUFsTHKYwIDAQAB'+ sLineBreak +
                'AoGAXXqwU7umsi8ADnsb+pwF85zh8TM/NnvSpIAQkJHzNXVtL7ph4gEvVbK3rLyH'+ sLineBreak +
                'U5aEMICbxV16i9A9PPfLjAfk4CuPpZlTibgfBRIG3MXirum0tjcyzbPyiDrk0qwM'+ sLineBreak +
                'e83MyRkrnGlss6cRT3mZk67txEamqTVmDwz/Sfo1fVlCQAkCQQDW3N/EKyT+8tPW'+ sLineBreak +
                '1EuPXafRONMel4xB1RiBmHYJP1bo/sDebLpocL6oiVlUX/k/zPRo1wMvlXJxPyiz'+ sLineBreak +
                'mnf37cZ9AkEAzuPcDvGxwawr7EPGmPQ0f7aWv87tS/rt9L3nKiz8HfrT6WT0R1Bh'+ sLineBreak +
                'I7lLGq4VFWE29I6hQ2lPNGX9IGFjiflKXwJBALgsO+J62QtwOgU7lEkfjmnYu57N'+ sLineBreak +
                'aHxFnOv5M7RZhrXRKKF/sYk0mzj8AoZAffYiSJ5VL3XqNF6+NLU/AvaR6kECQQCV'+ sLineBreak +
                'nY6sd/kWmA4DhFgAkMnOehq2h0xwH/0pepPLmlCQ1a2eIVXOpMA692rq1m2E0pLN'+ sLineBreak +
                'dMAGYgfXWtIdMpCrXM59AkB5npcELeGBv1K8B41fmrlA6rEq4aqmfwAFRKcQTj8a'+ sLineBreak +
                'n09FVtccLVPJ42AM1/QXK6a8DGCtB9R+j5j3UO/iL0+3'+ sLineBreak +
                '-----END RSA PRIVATE KEY-----' ;

type
  TACBrPAFCalcEAD = procedure(Arquivo: AnsiString) of object ;
  TACBrPAFGetKeyRSA = procedure(var PrivateKey_RSA: String) of object ;

  /// DECLARANDO O COMPONENTE - PAF-ECF:
  TACBrPAF = class(TACBrTXT)
  private
    FPath: AnsiString;         /// Path do arquivo a ser gerado
    ///
    FPAF_D: TPAF_D;
    FPAF_E: TPAF_E;
    FPAF_P: TPAF_P;
    FPAF_R: TPAF_R;
    FPAF_T: TPAF_T;

    FOnPAFCalcEAD: TACBrPAFCalcEAD;
    FOnPAFGetKeyRSA: TACBrPAFGetKeyRSA;

    procedure LimpaRegistros;
    function GetAbout: String;
    procedure SetAbout(const Value: String);
    procedure ReordenarRegistroR(Arquivo: AnsiString);
  protected
    procedure SetDelimitador(const Value: AnsiString); override;
    procedure SetTrimString(const Value: boolean); override;
    procedure SetCurMascara(const Value: AnsiString); override;
    /// REGISTROS D
    function WriteRegistroD1: AnsiString;
    function WriteRegistroD2: AnsiString;
    function WriteRegistroD9: AnsiString;
    /// REGISTROS E
    function WriteRegistroE1: AnsiString;
    function WriteRegistroE2: AnsiString;
    function WriteRegistroE9: AnsiString;
    /// REGISTROS P
    function WriteRegistroP1: AnsiString;
    function WriteRegistroP2: AnsiString;
    function WriteRegistroP9: AnsiString;
    /// REGISTROS R
    function WriteRegistroR01: AnsiString;
    function WriteRegistroR02: AnsiString;
    function WriteRegistroR04: AnsiString;
    function WriteRegistroR06: AnsiString;
    /// REGISTROS T
    function WriteRegistroT1: AnsiString;
    function WriteRegistroT2: AnsiString;
    function WriteRegistroT9: AnsiString;
    /// EAD
    procedure WriteRegistroEAD(Arquivo: AnsiString);
  public
    constructor Create(AOwner: TComponent); override; /// Create
    destructor Destroy; override; /// Destroy

    function SaveFileTXT_D(Arquivo: AnsiString): Boolean; /// Método que escreve o arquivo texto no caminho passado como parâmetro
    function SaveFileTXT_E(Arquivo: AnsiString): Boolean; /// Método que escreve o arquivo texto no caminho passado como parâmetro
    function SaveFileTXT_P(Arquivo: AnsiString): Boolean; /// Método que escreve o arquivo texto no caminho passado como parâmetro
    function SaveFileTXT_R(Arquivo: AnsiString): Boolean; /// Método que escreve o arquivo texto no caminho passado como parâmetro
    function SaveFileTXT_T(Arquivo: AnsiString): Boolean; /// Método que escreve o arquivo texto no caminho passado como parâmetro

    property PAF_D: TPAF_D read FPAF_D write FPAF_D;
    property PAF_E: TPAF_E read FPAF_E write FPAF_E;
    property PAF_P: TPAF_P read FPAF_P write FPAF_P;
    property PAF_R: TPAF_R read FPAF_R write FPAF_R;
    property PAF_T: TPAF_T read FPAF_T write FPAF_T;
  published
    property About : String read GetAbout write SetAbout stored False ;
    property Path: AnsiString read FPath write FPath;
    property Delimitador;
    property TrimString;
    property CurMascara;
    property OnError;
    property OnPAFCalcEAD: TACBrPAFCalcEAD read FOnPAFCalcEAD write FOnPAFCalcEAD;
    property OnPAFGetKeyRSA: TACBrPAFGetKeyRSA read FOnPAFGetKeyRSA write FOnPAFGetKeyRSA;
  end;

  procedure Register;

implementation

{$IFNDEF FPC}
 {$R ACBrPAF.dcr}
{$ENDIF}

procedure Register;
begin
  RegisterComponents('ACBr', [TACBrPAF]);
end;

constructor TACBrPAF.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FPAF_D := TPAF_D.Create(Self);
  FPAF_E := TPAF_E.Create(Self);
  FPAF_P := TPAF_P.Create(Self);
  FPAF_R := TPAF_R.Create(Self);
  FPAF_T := TPAF_T.Create(Self);
  FPath  := ExtractFilePath( ParamStr(0) );
end;

destructor TACBrPAF.Destroy;
begin
  FPAF_D.Free;
  FPAF_E.Free;
  FPAF_P.Free;
  FPAF_R.Free;
  FPAF_T.Free;
  inherited;
end;

function TACBrPAF.GetAbout: String;
begin
   Result := 'ACBrPAF Ver: ' + CACBrPAF_Versao;
end;

procedure TACBrPAF.LimpaRegistros;
begin
  FPAF_R.LimpaRegistros;
end;

procedure TACBrPAF.SetAbout(const Value: String);
begin
 {}
end;

procedure TACBrPAF.SetCurMascara(const Value: AnsiString);
begin
  inherited;
  FPAF_D.CurMascara := Value;
  FPAF_E.CurMascara := Value;
  FPAF_P.CurMascara := Value;
  FPAF_R.CurMascara := Value;
  FPAF_T.CurMascara := Value;
end;

procedure TACBrPAF.SetDelimitador(const Value: AnsiString);
begin
  inherited;
  FPAF_D.Delimitador := Value;
  FPAF_E.Delimitador := Value;
  FPAF_P.Delimitador := Value;
  FPAF_R.Delimitador := Value;
  FPAF_T.Delimitador := Value;
end;

procedure TACBrPAF.SetTrimString(const Value: boolean);
begin
  inherited;
  FPAF_D.TrimString := Value;
  FPAF_E.TrimString := Value;
  FPAF_P.TrimString := Value;
  FPAF_R.TrimString := Value;
  FPAF_T.TrimString := Value;
end;

function TACBrPAF.WriteRegistroD1: AnsiString;
begin
   Result := FPAF_D.WriteRegistroD1;
end;

function TACBrPAF.WriteRegistroD2: AnsiString;
begin
   Result := FPAF_D.WriteRegistroD2;
end;

function TACBrPAF.WriteRegistroD9: AnsiString;
begin
   Result := FPAF_D.WriteRegistroD9;
end;

function TACBrPAF.WriteRegistroE1: AnsiString;
begin
   Result := FPAF_E.WriteRegistroE1;
end;

function TACBrPAF.WriteRegistroE2: AnsiString;
begin
   Result := FPAF_E.WriteRegistroE2;
end;

function TACBrPAF.WriteRegistroE9: AnsiString;
begin
   Result := FPAF_E.WriteRegistroE9;
end;

function TACBrPAF.WriteRegistroP1: AnsiString;
begin
   Result := FPAF_P.WriteRegistroP1;
end;

function TACBrPAF.WriteRegistroP2: AnsiString;
begin
   Result := FPAF_P.WriteRegistroP2;
end;

function TACBrPAF.WriteRegistroP9: AnsiString;
begin
   Result := FPAF_P.WriteRegistroP9;
end;

function TACBrPAF.WriteRegistroR01: AnsiString;
begin
   Result := FPAF_R.WriteRegistroR01;
end;

function TACBrPAF.WriteRegistroR02: AnsiString;
begin
   Result := FPAF_R.WriteRegistroR02;
end;

function TACBrPAF.WriteRegistroR04: AnsiString;
begin
   Result := FPAF_R.WriteRegistroR04;
end;

function TACBrPAF.WriteRegistroR06: AnsiString;
begin
   Result := FPAF_R.WriteRegistroR06;
end;

function TACBrPAF.WriteRegistroT1: AnsiString;
begin
   Result := FPAF_T.WriteRegistroT1;
end;

function TACBrPAF.WriteRegistroT2: AnsiString;
begin
   Result := FPAF_T.WriteRegistroT2;
end;

function TACBrPAF.WriteRegistroT9: AnsiString;
begin
   Result := FPAF_T.WriteRegistroT9;
end;

function TACBrPAF.SaveFileTXT_D(Arquivo: AnsiString): Boolean;
var
txtFile: TextFile;
begin
  Result := True;
  ///
  if (Trim(Arquivo) = '') or (Trim(fPath) = '') then
     raise Exception.Create('Caminho ou nome do arquivo não informado!');

  /// Atribuir o evento do componente aos eventos dos Blocos, para que sejam
  /// disparados.
  FPAF_D.OnError := OnError;

  try
    AssignFile(txtFile, fPath + Arquivo);
    Rewrite(txtFile);
    ///
    Write(txtFile, WriteRegistroD1);
    if FPAF_D.RegistroD2.Count > 0 then Write(txtFile, WriteRegistroD2);
    Write(txtFile, WriteRegistroD9);
    ///
    CloseFile(txtFile);
    /// Assinatura EAD
    if Assigned( FOnPAFCalcEAD ) then
       FOnPAFCalcEAD(fPath + Arquivo) /// Se usuário usa outro método para assinar o arquivo
    else
       WriteRegistroEAD(fPath + Arquivo);

    /// Limpa de todos os Blocos as listas de todos os registros.
    LimpaRegistros;
  except
    on E: Exception do
    begin
      raise Exception.Create(E.Message);
    end;
  end;
end;

function TACBrPAF.SaveFileTXT_E(Arquivo: AnsiString): Boolean;
var
txtFile: TextFile;
begin
  Result := True;
  ///
  if (Trim(Arquivo) = '') or (Trim(fPath) = '') then
     raise Exception.Create('Caminho ou nome do arquivo não informado!');

  /// Atribuir o evento do componente aos eventos dos Blocos, para que sejam
  /// disparados.
  FPAF_E.OnError := OnError;

  try
    AssignFile(txtFile, fPath + Arquivo);
    Rewrite(txtFile);
    ///
    Write(txtFile, WriteRegistroE1);
    if FPAF_E.RegistroE2.Count > 0 then Write(txtFile, WriteRegistroE2);
    Write(txtFile, WriteRegistroE9);
    ///
    CloseFile(txtFile);
    /// Assinatura EAD
    if Assigned( FOnPAFCalcEAD ) then
       FOnPAFCalcEAD(fPath + Arquivo) /// Se usuário usa outro método para assinar o arquivo
    else
       WriteRegistroEAD(fPath + Arquivo);

    /// Limpa de todos os Blocos as listas de todos os registros.
    LimpaRegistros;
  except
    on E: Exception do
    begin
      raise Exception.Create(E.Message);
    end;
  end;
end;

function TACBrPAF.SaveFileTXT_P(Arquivo: AnsiString): Boolean;
var
txtFile: TextFile;
begin
  Result := True;
  ///
  if (Trim(Arquivo) = '') or (Trim(fPath) = '') then
     raise Exception.Create('Caminho ou nome do arquivo não informado!');

  /// Atribuir o evento do componente aos eventos dos Blocos, para que sejam
  /// disparados.
  FPAF_P.OnError := OnError;

  try
    AssignFile(txtFile, fPath + Arquivo);
    Rewrite(txtFile);
    ///
    Write(txtFile, WriteRegistroP1);
    if FPAF_P.RegistroP2.Count > 0 then Write(txtFile, WriteRegistroP2);
    Write(txtFile, WriteRegistroP9);
    ///
    CloseFile(txtFile);
    /// Assinatura EAD
    if Assigned( FOnPAFCalcEAD ) then
       FOnPAFCalcEAD(fPath + Arquivo) /// Se usuário usa outro método para assinar o arquivo
    else
       WriteRegistroEAD(fPath + Arquivo);

    /// Limpa de todos os Blocos as listas de todos os registros.
    LimpaRegistros;
  except
    on E: Exception do
    begin
      raise Exception.Create(E.Message);
    end;
  end;
end;

function TACBrPAF.SaveFileTXT_R(Arquivo: AnsiString): Boolean;
var
txtFile: TextFile;
begin
  Result := True;
  ///
  if (Trim(Arquivo) = '') or (Trim(fPath) = '') then
     raise Exception.Create('Caminho ou nome do arquivo não informado!');

  /// Atribuir o evento do componente aos eventos dos Blocos, para que sejam
  /// disparados.
  FPAF_R.OnError := OnError;

  try
    AssignFile(txtFile, fPath + Arquivo);
    Rewrite(txtFile);
    ///
    Write(txtFile, WriteRegistroR01);
    if FPAF_R.RegistroR02.Count > 0 then Write(txtFile, WriteRegistroR02);
    if FPAF_R.RegistroR04.Count > 0 then Write(txtFile, WriteRegistroR04);
    if FPAF_R.RegistroR06.Count > 0 then Write(txtFile, WriteRegistroR06);
    ///
    CloseFile(txtFile);
    /// Coloca os registros R em ordem crescente
    ReordenarRegistroR(Arquivo);
    /// Assinatura EAD
    if Assigned( FOnPAFCalcEAD ) then
       FOnPAFCalcEAD(fPath + Arquivo) /// Se usuário usa outro método para assinar o arquivo
    else
       WriteRegistroEAD(fPath + Arquivo);

    /// Limpa de todos os Blocos as listas de todos os registros.
    LimpaRegistros;
  except
    on E: Exception do
    begin
      raise Exception.Create(E.Message);
    end;
  end;
end;

function TACBrPAF.SaveFileTXT_T(Arquivo: AnsiString): Boolean;
var
txtFile: TextFile;
begin
  Result := True;
  ///
  if (Trim(Arquivo) = '') or (Trim(fPath) = '') then
     raise Exception.Create('Caminho ou nome do arquivo não informado!');

  /// Atribuir o evento do componente aos eventos dos Blocos, para que sejam
  /// disparados.
  FPAF_T.OnError := OnError;

  try
    AssignFile(txtFile, fPath + Arquivo);
    Rewrite(txtFile);
    ///
    Write(txtFile, WriteRegistroT1);
    if FPAF_T.RegistroT2.Count > 0 then Write(txtFile, WriteRegistroT2);
    Write(txtFile, WriteRegistroT9);
    ///
    CloseFile(txtFile);
    /// Assinatura EAD
    if Assigned( FOnPAFCalcEAD ) then
       FOnPAFCalcEAD(fPath + Arquivo) /// Se usuário usa outro método para assinar o arquivo
    else
       WriteRegistroEAD(fPath + Arquivo);

    /// Limpa de todos os Blocos as listas de todos os registros.
    LimpaRegistros;
  except
    on E: Exception do
    begin
      raise Exception.Create(E.Message);
    end;
  end;
end;

procedure TACBrPAF.WriteRegistroEAD(Arquivo: AnsiString);
var
  Arq : textfile;
  EAD, cmd, ChaveRSA: String ;
  SL, SEC : TStringList;
  F:TextFile;
  I:Integer;
  S,Dir,Linha:String;
begin
  { Gerando registro EAD }
  EAD := '' ;
  SL  := TStringList.Create ;
  Dir := GetCurrentDir ;
  try
     { Gravando a chave no arquivo id_rsa para usa-la com o "openssl" }
     ChaveRSA := '' ;
     if Assigned( FOnPAFGetKeyRSA ) then
        FOnPAFGetKeyRSA( ChaveRSA ) ;   { Se usuário tem Chave própria, use-a }

     if ChaveRSA = '' then
        ChaveRSA := cRFDRSAKey;

     { Gravando a chave RSA temporariamente no DirLog }
     SL.Clear ;
     SL.Text := ChaveRSA;
     SL.SaveToFile( 'id.rsa' );

     { Executando o "openssl.exe" }
     cmd := 'dgst -md5 -sign id.rsa -out ead.txt -hex "'+ Arquivo+'"' ;
     {$IFDEF CONSOLE}
       WriteLn('Executando: openssl '+cmd) ;
     {$ENDIF}
     RunCommand('openssl', cmd, True, 0);

     {$IFDEF CONSOLE}
       WriteLn('Aguardando ead.txt') ;
     {$ENDIF}
     I := 0 ;
     while (not FileExists('ead.txt')) and (I < 30) do
     begin
        sleep(100) ;
        {$IFNDEF CONSOLE}
          Application.ProcessMessages ;
        {$ELSE}
          Write('.') ;
        {$ENDIF}
        Inc( I ) ;
     end ;

     { Lendo a resposta }
     try
        SL.Clear ;
        SL.LoadFromFile('ead.txt');
        EAD := SL.Text ;
        EAD := UpperCase( Trim( copy(EAD, pos('=',EAD)+1, Length(EAD) ))) ;
     except
        raise Exception.Create( ACBrStr('Erro ao calcular registro EAD usando o "openssl"' )) ;
     end ;
  finally
     SL.Free ;

     SysUtils.DeleteFile( 'id.rsa' ) ;  // Removendo a chave privada do disco ;
     SysUtils.DeleteFile( 'ead.txt' ) ;

     ChDir( Dir );  { Voltando para o diretório anterior }
     {$IFDEF CONSOLE}
       writeln( 'Diretorio atual: ',GetCurrentDir ) ;
     {$ENDIF}
  end;
  Linha := 'EAD' + EAD ;
  WriteToTXT( Arquivo, Linha, True );
end;

procedure TACBrPAF.ReordenarRegistroR(Arquivo: AnsiString);
var
objFile: TStringList;
intLine: Integer;
begin
   try
     objFile := TStringList.Create;
     with objFile do
     begin
        LoadFromFile(fPath + Arquivo);
        // Ordenar.
        Sort;
     end;
   finally
     objFile.SaveToFile(fPath + Arquivo);
     objFile.Free;
   end;
end;

end.
