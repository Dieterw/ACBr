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
|* 29/11/2010: Gutierres Santana da Costa
|*  - Implementado Registro Tipo C "Controle de Abastecimento e Encerrante"
*******************************************************************************}

unit ACBrPAF;

interface

uses
   SysUtils, Classes, DateUtils,
   {$IFDEF FPC}
      LResources,
   {$ENDIF}
   {$IFDEF CLX}QForms, {$ELSE} Forms, {$ENDIF}
   ACBrTXTClass, ACBrUtil, ACBrEAD,
   ACBrPAF_D, ACBrPAF_D_Class,
   ACBrPAF_E, ACBrPAF_E_Class,
   ACBrPAF_P, ACBrPAF_P_Class,
   ACBrPAF_R, ACBrPAF_R_Class,
   ACBrPAF_T, ACBrPAF_T_Class,
   ACBrPAF_C, ACBrPAF_C_Class,
   ACBrPAF_N, ACBrPAF_N_Class;

const
   CACBrPAF_Versao = '0.07' ;

type

  // DECLARANDO O COMPONENTE - PAF-ECF:

  { TACBrPAF }

  TACBrPAF = class(TComponent)
  private
    FACBrTXT: TACBrTXTClass;
    FOnError: TErrorEvent;

    FACBrEAD: TACBrEAD;       // Classe usada para AssinarArquivo com assinatura EAD.

    FPath: String;            // Path do arquivo a ser gerado
    FDelimitador: String;     // Caracter delimitador de campos
    FTrimString: boolean;     // Retorna a string sem espaços em branco iniciais e finais
    FCurMascara: String;      // Mascara para valores tipo currency
    FAssinar : Boolean;       // Define se o arquivo gerado deve ser assinado

    FPAF_D: TPAF_D;
    FPAF_E: TPAF_E;
    FPAF_P: TPAF_P;
    FPAF_R: TPAF_R;
    FPAF_T: TPAF_T;
    FPAF_C: TPAF_C;
    FPAF_N: TPAF_N;
    fsOnPAFCalcEAD: TACBrEADCalc;

    function GetAbout: String;
    function GetDelimitador: String;
    function GetTrimString: boolean;
    function GetCurMascara: String;
    procedure SetDelimitador(const Value: String);
    procedure SetTrimString(const Value: boolean);
    procedure SetCurMascara(const Value: String);

    function GetOnError: TErrorEvent; // Método do evento OnError
    procedure SetOnError(const Value: TErrorEvent); // Método SetError

    function GetOnPAFGetKeyRSA: TACBrEADGetChave;
    procedure SetOnPAFGetKeyRSA (const Value: TACBrEADGetChave);

    procedure LimpaRegistros;
    procedure ReordenarRegistroR(Arquivo: String);
  protected
    // REGISTROS D
    function WriteRegistroD1: String;
    function WriteRegistroD2: String;
    function WriteRegistroD9: String;
    // REGISTROS E
    function WriteRegistroE1: String;
    function WriteRegistroE2: String;
    function WriteRegistroE9: String;
    // REGISTROS P
    function WriteRegistroP1: String;
    function WriteRegistroP2: String;
    function WriteRegistroP9: String;
    // REGISTROS R
    function WriteRegistroR01: String;
    function WriteRegistroR02: String;
    function WriteRegistroR04: String;
    function WriteRegistroR06: String;
    // REGISTROS T
    function WriteRegistroT1: String;
    function WriteRegistroT2: String;
    function WriteRegistroT9: String;
    // REGISTROS C
    function WriteRegistroC1: String;
    function WriteRegistroC2: String;
    function WriteRegistroC9: String;
    // REGISTROS N
    function WriteRegistroN1: String;
    function WriteRegistroN2: String;
    function WriteRegistroN3: String;
    function WriteRegistroN9: String;
  public
    constructor Create(AOwner: TComponent); override; // Create
    destructor Destroy; override; // Destroy

    function SaveFileTXT_D(Arquivo: String): Boolean; // Método que escreve o arquivo texto no caminho passado como parâmetro
    function SaveFileTXT_E(Arquivo: String): Boolean; // Método que escreve o arquivo texto no caminho passado como parâmetro
    function SaveFileTXT_P(Arquivo: String): Boolean; // Método que escreve o arquivo texto no caminho passado como parâmetro
    function SaveFileTXT_R(Arquivo: String): Boolean; // Método que escreve o arquivo texto no caminho passado como parâmetro
    function SaveFileTXT_T(Arquivo: String): Boolean; // Método que escreve o arquivo texto no caminho passado como parâmetro
    function SaveFileTXT_C(Arquivo: String): Boolean; // Método que escreve o arquivo texto no caminho passado como parâmetro
    function SaveFileTXT_N(Arquivo: String): Boolean; // Método que escreve o arquivo texto no caminho passado como parâmetro

    property PAF_D: TPAF_D read FPAF_D write FPAF_D;
    property PAF_E: TPAF_E read FPAF_E write FPAF_E;
    property PAF_P: TPAF_P read FPAF_P write FPAF_P;
    property PAF_R: TPAF_R read FPAF_R write FPAF_R;
    property PAF_T: TPAF_T read FPAF_T write FPAF_T;
    property PAF_C: TPAF_C read FPAF_C write FPAF_C;
    property PAF_N: TPAF_N read FPAF_N write FPAF_N;

    function AssinaArquivoComEAD(Arquivo: String): Boolean;
  published
    property About: String read GetAbout stored False ;
    property Path: String read FPath write FPath;

    property Delimitador: String read GetDelimitador write SetDelimitador;
    property TrimString: Boolean read GetTrimString write SetTrimString
       default True ;
    property CurMascara: String read GetCurMascara write SetCurMascara;
    property AssinarArquivo : Boolean read FAssinar write FAssinar
      default True ;

    property OnError: TErrorEvent  read GetOnError write SetOnError;
    property OnPAFCalcEAD: TACBrEADCalc read fsOnPAFCalcEAD write fsOnPAFCalcEAD;
    property OnPAFGetKeyRSA: TACBrEADGetChave read GetOnPAFGetKeyRSA write SetOnPAFGetKeyRSA;
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

  FACBrTXT := TACBrTXTClass.Create;
  FACBrEAD := TACBrEAD.Create(Self);
  FPAF_D := TPAF_D.Create;
  FPAF_E := TPAF_E.Create;
  FPAF_P := TPAF_P.Create;
  FPAF_R := TPAF_R.Create;
  FPAF_T := TPAF_T.Create;
  FPAF_C := TPAF_C.Create;
  FPAF_N := TPAF_N.Create;

  FPath := ExtractFilePath( ParamStr(0) );
  FDelimitador := '';
  FCurMascara  := '';
  FTrimString  := True;
  FAssinar     := True;
end;

destructor TACBrPAF.Destroy;
begin
  FACBrTXT.Free;
  FACBrEAD.Free;
  FPAF_D.Free;
  FPAF_E.Free;
  FPAF_P.Free;
  FPAF_R.Free;
  FPAF_T.Free;
  FPAF_C.Free;
  FPAF_N.Free;

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

function TACBrPAF.GetDelimitador: String;
begin
  Result := FDelimitador;
end;

procedure TACBrPAF.SetDelimitador(const Value: String);
begin
  FDelimitador := Value;

  FPAF_D.Delimitador := Value;
  FPAF_E.Delimitador := Value;
  FPAF_P.Delimitador := Value;
  FPAF_R.Delimitador := Value;
  FPAF_T.Delimitador := Value;
  FPAF_C.Delimitador := Value;
  FPAF_N.Delimitador := Value;
end;

function TACBrPAF.GetCurMascara: String;
begin
  Result := FCurMascara;
end;

procedure TACBrPAF.SetCurMascara(const Value: String);
begin
  FCurMascara := Value;

  FPAF_D.CurMascara := Value;
  FPAF_E.CurMascara := Value;
  FPAF_P.CurMascara := Value;
  FPAF_R.CurMascara := Value;
  FPAF_T.CurMascara := Value;
  FPAF_C.CurMascara := Value;
  FPAF_N.CurMascara := Value;
end;

function TACBrPAF.GetTrimString: boolean;
begin
  Result := FTrimString;
end;

procedure TACBrPAF.SetTrimString(const Value: boolean);
begin
  FTrimString := Value;

  FPAF_D.TrimString := Value;
  FPAF_E.TrimString := Value;
  FPAF_P.TrimString := Value;
  FPAF_R.TrimString := Value;
  FPAF_T.TrimString := Value;
  FPAF_C.TrimString := Value;
  FPAF_N.TrimString := Value;
end;

function TACBrPAF.GetOnError: TErrorEvent;
begin
  Result := FOnError;
end;

function TACBrPAF.GetOnPAFGetKeyRSA: TACBrEADGetChave;
begin
  Result := FACBrEAD.OnGetChavePrivada;
end;

procedure TACBrPAF.SetOnError(const Value: TErrorEvent);
begin
  FOnError := Value;

  FPAF_D.OnError := Value;
  FPAF_E.OnError := Value;
  FPAF_P.OnError := Value;
  FPAF_R.OnError := Value;
  FPAF_T.OnError := Value;
  FPAF_C.OnError := Value;
  FPAF_N.OnError := Value;
end;

procedure TACBrPAF.SetOnPAFGetKeyRSA(const Value: TACBrEADGetChave);
begin
  FACBrEAD.OnGetChavePrivada := Value;
end;

function TACBrPAF.WriteRegistroD1: String;
begin
  Result := FPAF_D.WriteRegistroD1;
end;

function TACBrPAF.WriteRegistroD2: String;
begin
  Result := FPAF_D.WriteRegistroD2;
end;

function TACBrPAF.WriteRegistroD9: String;
begin
  Result := FPAF_D.WriteRegistroD9;
end;

function TACBrPAF.WriteRegistroE1: String;
begin
  Result := FPAF_E.WriteRegistroE1;
end;

function TACBrPAF.WriteRegistroE2: String;
begin
  Result := FPAF_E.WriteRegistroE2;
end;

function TACBrPAF.WriteRegistroE9: String;
begin
  Result := FPAF_E.WriteRegistroE9;
end;

function TACBrPAF.WriteRegistroP1: String;
begin
  Result := FPAF_P.WriteRegistroP1;
end;

function TACBrPAF.WriteRegistroP2: String;
begin
  Result := FPAF_P.WriteRegistroP2;
end;

function TACBrPAF.WriteRegistroP9: String;
begin
  Result := FPAF_P.WriteRegistroP9;
end;

function TACBrPAF.WriteRegistroR01: String;
begin
  Result := FPAF_R.WriteRegistroR01;
end;

function TACBrPAF.WriteRegistroR02: String;
begin
  Result := FPAF_R.WriteRegistroR02;
end;

function TACBrPAF.WriteRegistroR04: String;
begin
  Result := FPAF_R.WriteRegistroR04;
end;

function TACBrPAF.WriteRegistroR06: String;
begin
  Result := FPAF_R.WriteRegistroR06;
end;

function TACBrPAF.WriteRegistroT1: String;
begin
  Result := FPAF_T.WriteRegistroT1;
end;

function TACBrPAF.WriteRegistroT2: String;
begin
  Result := FPAF_T.WriteRegistroT2;
end;

function TACBrPAF.WriteRegistroT9: String;
begin
  Result := FPAF_T.WriteRegistroT9;
end;

function TACBrPAF.WriteRegistroC1: String;
begin
  Result := FPAF_C.WriteRegistroC1;
end;

function TACBrPAF.WriteRegistroC2: String;
begin
  Result := FPAF_C.WriteRegistroC2;
end;

function TACBrPAF.WriteRegistroC9: String;
begin
  Result := FPAF_C.WriteRegistroC9;
end;

function TACBrPAF.WriteRegistroN1: String;
begin
  Result := FPAF_N.WriteRegistroN1;
end;

function TACBrPAF.WriteRegistroN2: String;
begin
  Result := FPAF_N.WriteRegistroN2;
end;

function TACBrPAF.WriteRegistroN3: String;
begin
  Result := FPAF_N.WriteRegistroN3;
end;

function TACBrPAF.WriteRegistroN9: String;
begin
  Result := FPAF_N.WriteRegistroN9;
end;

function TACBrPAF.SaveFileTXT_D(Arquivo: String): Boolean;
var
  txtFile: TextFile;
begin
  Result := True;

  if (Trim(Arquivo) = '') or (Trim(fPath) = '') then
    raise Exception.Create('Caminho ou nome do arquivo não informado!');

  try
    AssignFile(txtFile, fPath + Arquivo);
    try
      Rewrite(txtFile);
      Write(txtFile, WriteRegistroD1);

      if FPAF_D.RegistroD2.Count > 0 then
         Write(txtFile, WriteRegistroD2);

      Write(txtFile, WriteRegistroD9);
    finally
      CloseFile(txtFile);
    end;

    // Assinatura EAD
    if FAssinar then
       AssinaArquivoComEAD(fPath + Arquivo);

    // Limpa de todos os Blocos as listas de todos os registros.
    LimpaRegistros;
  except
    on E: Exception do
    begin
      raise Exception.Create(E.Message);
    end;
  end;
end;

function TACBrPAF.SaveFileTXT_E(Arquivo: String): Boolean;
var
  txtFile: TextFile;
begin
  Result := True;

  if (Trim(Arquivo) = '') or (Trim(fPath) = '') then
    raise Exception.Create('Caminho ou nome do arquivo não informado!');

  try
    AssignFile(txtFile, fPath + Arquivo);
    try
      Rewrite(txtFile);
      Write(txtFile, WriteRegistroE1);

      if FPAF_E.RegistroE2.Count > 0 then
        Write(txtFile, WriteRegistroE2);

      Write(txtFile, WriteRegistroE9);
    finally
      CloseFile(txtFile);
    end;

    // Assinatura EAD
    if FAssinar then
      AssinaArquivoComEAD(fPath + Arquivo);

    // Limpa de todos os Blocos as listas de todos os registros.
    LimpaRegistros;
  except
    on E: Exception do
    begin
      raise Exception.Create(E.Message);
    end;
  end;
end;

function TACBrPAF.SaveFileTXT_P(Arquivo: String): Boolean;
var
txtFile: TextFile;
begin
  Result := True;

  if (Trim(Arquivo) = '') or (Trim(fPath) = '') then
    raise Exception.Create('Caminho ou nome do arquivo não informado!');

  try
    AssignFile(txtFile, fPath + Arquivo);
    try
      Rewrite(txtFile);

      Write(txtFile, WriteRegistroP1);
      if FPAF_P.RegistroP2.Count > 0 then
        Write(txtFile, WriteRegistroP2);

      Write(txtFile, WriteRegistroP9);
    finally
      CloseFile(txtFile);
    end;

    // Assinatura EAD
    if FAssinar then
      AssinaArquivoComEAD(fPath + Arquivo);

    // Limpa de todos os Blocos as listas de todos os registros.
    LimpaRegistros;
  except
    on E: Exception do
    begin
      raise Exception.Create(E.Message);
    end;
  end;
end;

function TACBrPAF.SaveFileTXT_R(Arquivo: String): Boolean;
var
txtFile: TextFile;
begin
  Result := True;

  if (Trim(Arquivo) = '') or (Trim(fPath) = '') then
    raise Exception.Create('Caminho ou nome do arquivo não informado!');

  try
    AssignFile(txtFile, fPath + Arquivo);
    try
      Rewrite(txtFile);

      Write(txtFile, WriteRegistroR01);
      if FPAF_R.RegistroR02.Count > 0 then
        Write(txtFile, WriteRegistroR02);

      if FPAF_R.RegistroR04.Count > 0 then
        Write(txtFile, WriteRegistroR04);

      if FPAF_R.RegistroR06.Count > 0 then
        Write(txtFile, WriteRegistroR06);
    finally
      CloseFile(txtFile);
    end;

    // Coloca os registros R em ordem crescente
    ReordenarRegistroR(Arquivo);

    // Assinatura EAD
    if FAssinar then
      AssinaArquivoComEAD(fPath + Arquivo);

    // Limpa de todos os Blocos as listas de todos os registros.
    LimpaRegistros;
  except
    on E: Exception do
    begin
      raise Exception.Create(E.Message);
    end;
  end;
end;

function TACBrPAF.SaveFileTXT_T(Arquivo: String): Boolean;
var
txtFile: TextFile;
begin
  Result := True;

  if (Trim(Arquivo) = '') or (Trim(fPath) = '') then
    raise Exception.Create('Caminho ou nome do arquivo não informado!');

  try
    AssignFile(txtFile, fPath + Arquivo);
    try
      Rewrite(txtFile);
      Write(txtFile, WriteRegistroT1);

      if FPAF_T.RegistroT2.Count > 0 then
        Write(txtFile, WriteRegistroT2);

      Write(txtFile, WriteRegistroT9);
    finally
      CloseFile(txtFile);
    end;

    // Assinatura EAD
    if FAssinar then
      AssinaArquivoComEAD(fPath + Arquivo);

    // Limpa de todos os Blocos as listas de todos os registros.
    LimpaRegistros;
  except
    on E: Exception do
    begin
      raise Exception.Create(E.Message);
    end;
  end;
end;


function TACBrPAF.SaveFileTXT_C(Arquivo: String): Boolean;
var
txtFile: TextFile;
begin
  Result := True;

  if (Trim(Arquivo) = '') or (Trim(fPath) = '') then
    raise Exception.Create('Caminho ou nome do arquivo não informado!');

  try
    AssignFile(txtFile, fPath + Arquivo);
    try
      Rewrite(txtFile);

      Write(txtFile, WriteRegistroC1);

      if FPAF_C.RegistroC2.Count > 0 then
        Write(txtFile, WriteRegistroC2);

      Write(txtFile, WriteRegistroC9);
    finally
      CloseFile(txtFile);
    end;

    // Assinatura EAD
    if FAssinar then
      AssinaArquivoComEAD(fPath + Arquivo);

    // Limpa de todos os Blocos as listas de todos os registros.
    LimpaRegistros;
  except
    on E: Exception do
    begin
      raise Exception.Create(E.Message);
    end;
  end;
end;

function TACBrPAF.SaveFileTXT_N(Arquivo: String): Boolean;
var
txtFile: TextFile;
begin
  Result := True;

  if (Trim(Arquivo) = '') or (Trim(fPath) = '') then
    raise Exception.Create('Caminho ou nome do arquivo não informado!');

  try
    AssignFile(txtFile, fPath + Arquivo);
    try
      Rewrite(txtFile);
      Write(txtFile, WriteRegistroN1);
      Write(txtFile, WriteRegistroN2);

      if FPAF_N.RegistroN3.Count > 0 then
        Write(txtFile, WriteRegistroN3);

      Write(txtFile, WriteRegistroN9);
    finally
      CloseFile(txtFile);
    end;

    // Assinatura EAD
    if FAssinar then
      AssinaArquivoComEAD(fPath + Arquivo);

    // Limpa de todos os Blocos as listas de todos os registros.
    LimpaRegistros;
  except
    on E: Exception do
    begin
      raise Exception.Create(E.Message);
    end;
  end;
end;

procedure TACBrPAF.ReordenarRegistroR(Arquivo: String);
var
objFile: TStringList;
begin
  objFile := TStringList.Create;
  try
    objFile.LoadFromFile(fPath + Arquivo);
    objFile.Sort;
    objFile.SaveToFile(fPath + Arquivo);
  finally
    objFile.Free;
  end;
end;

function TACBrPAF.AssinaArquivoComEAD(Arquivo: String): Boolean;
begin
  if Assigned( fsOnPAFCalcEAD ) then
    fsOnPAFCalcEAD( Arquivo )
  else
    FACBrEAD.AssinarArquivoComEAD( Arquivo ) ;

  Result := True;
end;

{$ifdef FPC}
initialization
   {$I ACBrPAF.lrs}
{$endif}

end.
