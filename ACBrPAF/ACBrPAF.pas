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
   ACBrUtilTXT,
   ACBrPAF_D, ACBrPAF_D_Class,
   ACBrPAF_E, ACBrPAF_E_Class,
   ACBrPAF_P, ACBrPAF_P_Class,
   ACBrPAF_R, ACBrPAF_R_Class,
   ACBrPAF_T, ACBrPAF_T_Class;

const
   CACBrPAF_Versao = '0.02a' ;

type
  /// DECLARANDO O COMPONENTE - PAF-ECF:
  TACBrPAF = class(TACBrTXT)
  private
    FArquivo:AnsiString ;      /// Nome do arquivo a ser gerado
    FPath: AnsiString;         /// Path do arquivo a ser gerado
    FAssDigital: AnsiString;  /// Assinatura do Hash

    FPAF_D: TPAF_D;
    FPAF_E: TPAF_E;
    FPAF_P: TPAF_P;
    FPAF_R: TPAF_R;
    FPAF_T: TPAF_T;

    procedure LimpaRegistros;
    function GetAbout: String;
    procedure SetAbout(const Value: String);
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
    function WriteRegistroEAD: AnsiString;
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
    property AssDigital: AnsiString read FAssDigital write FAssDigital;
  published
    property About : String read GetAbout write SetAbout stored False ;
    property Path: AnsiString read FPath write FPath;
    property Delimitador;
    property TrimString;
    property CurMascara;
    property OnError;
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

function TACBrPAF.WriteRegistroEAD: AnsiString;
begin
   Result := LFill('EAD') +
             LFill(FAssDigital);
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
    /// Assinatura EAD
    Write(txtFile, WriteRegistroEAD);
    ///
    CloseFile(txtFile);
    /// Limpa de todos os Blocos as listas de todos os registros.
    LimpaRegistros;
  except
    on E: Exception do
    begin
      CloseFile(txtFile);
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
    /// Assinatura EAD
    Write(txtFile, WriteRegistroEAD);
    ///
    CloseFile(txtFile);
    /// Limpa de todos os Blocos as listas de todos os registros.
    LimpaRegistros;
  except
    on E: Exception do
    begin
      CloseFile(txtFile);
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
    /// Assinatura EAD
    Write(txtFile, WriteRegistroEAD);
    ///
    CloseFile(txtFile);
    /// Limpa de todos os Blocos as listas de todos os registros.
    LimpaRegistros;
  except
    on E: Exception do
    begin
      CloseFile(txtFile);
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
    /// Assinatura EAD
    Write(txtFile, WriteRegistroEAD);
    ///
    CloseFile(txtFile);
    /// Limpa de todos os Blocos as listas de todos os registros.
    LimpaRegistros;
  except
    on E: Exception do
    begin
      CloseFile(txtFile);
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
    /// Assinatura EAD
    Write(txtFile, WriteRegistroEAD);
    ///
    CloseFile(txtFile);
    /// Limpa de todos os Blocos as listas de todos os registros.
    LimpaRegistros;
  except
    on E: Exception do
    begin
      CloseFile(txtFile);
      raise Exception.Create(E.Message);
    end;
  end;
end;

end.
