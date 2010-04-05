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

unit ACBrSpedContabil;

interface

uses
  SysUtils, Classes, DateUtils, ACBrSped, ACBrTXTClass,
  ACBrECDBloco_0_Class, ACBrECDBloco_9_Class, ACBrECDBloco_I_Class,
  ACBrECDBloco_J_Class;

const
   CACBrSpedContabil_Versao = '0.04a' ;

type
  /// ACBrSpedContabil - Sitema Publico de Escrituração Digital Contabil
  TACBrSPEDContabil = class(TComponent)
  private
    FACBrTXT: TACBrTXTClass;
    FOnError: TErrorEvent;

    FDT_INI: TDateTime;           /// Data inicial das informações contidas no arquivo
    FDT_FIN: TDateTime;           /// Data final das informações contidas no arquivo

    FPath: String;            /// Path do arquivo a ser gerado
    FDelimitador: String;     /// Caracter delimitador de campos
    FTrimString: boolean;         /// Retorna a string sem espaços em branco iniciais e finais
    FCurMascara: String;      /// Mascara para valores tipo currency

    FBloco_0: TBloco_0;
    FBloco_9: TBloco_9;
    FBloco_I: TBloco_I;
    FBloco_J: TBloco_J;

    function GetAbout: String;
    function GetDelimitador: String;
    function GetTrimString: boolean;
    function GetCurMascara: String;
    function GetDT_FIN: TDateTime;
    function GetDT_INI: TDateTime;
    procedure SetAbout(const Value: String);
    procedure SetDelimitador(const Value: String);
    procedure SetTrimString(const Value: boolean);
    procedure SetCurMascara(const Value: String);
    procedure SetDT_FIN(const Value: TDateTime);
    procedure SetDT_INI(const Value: TDateTime);

    function GetOnError: TErrorEvent; /// Método do evento OnError
    procedure SetOnError(const Value: TErrorEvent); /// Método SetError

    procedure LimpaRegistros;
    procedure TotalizaTermos(Arquivo: String);
  protected
    /// BLOCO 0
    function WriteRegistro0000: String;
    function WriteRegistro0001: String;
    function WriteRegistro0007: String;
    function WriteRegistro0020: String;
    function WriteRegistro0150: String;
    function WriteRegistro0180: String;
    function WriteRegistro0990: String;
    /// BLOCO I
    function WriteRegistroI001: String;
    function WriteRegistroI010: String;
    function WriteRegistroI012: String;
    function WriteRegistroI015: String;
    function WriteRegistroI020: String;
    function WriteRegistroI030: String;
    function WriteRegistroI050: String;
    function WriteRegistroI075: String;
    function WriteRegistroI100: String;
    function WriteRegistroI150: String;
    function WriteRegistroI200: String;
    function WriteRegistroI300: String;
    function WriteRegistroI350: String;
    function WriteRegistroI500: String;
    function WriteRegistroI510: String;
    function WriteRegistroI550: String;

    function WriteRegistroI990: String;
    /// BLOCO J
    function WriteRegistroJ001: String;
    function WriteRegistroJ005: String;
    function WriteRegistroJ100: String;
    function WriteRegistroJ150: String;
    function WriteRegistroJ800: String;
    function WriteRegistroJ900: String;
    function WriteRegistroJ930: String;
    function WriteRegistroJ990: String;
    /// BLOCO 9
    function WriteRegistro9001: String;
    function WriteRegistro9900: String;
    function WriteRegistro9990: String;
    function WriteRegistro9999: String;
  public
    constructor Create(AOwner: TComponent); override; /// Create
    destructor Destroy; override; /// Destroy

    function SaveFileTXT(Arquivo: String): Boolean; /// Método que escreve o arquivo texto no caminho passado como parâmetro

    property DT_INI: TDateTime read GetDT_INI write SetDT_INI;
    property DT_FIN: TDateTime read GetDT_FIN write SetDT_FIN;
    //
    property Bloco_0: TBloco_0 read FBloco_0 write FBloco_0;
    property Bloco_9: TBloco_9 read FBloco_9 write FBloco_9;
    property Bloco_I: TBloco_I read FBloco_I write FBloco_I;
    property Bloco_J: TBloco_J read FBloco_J write FBloco_J;
  published
    property About: String read GetAbout write SetAbout stored False ;
    property Path: String read FPath write FPath;
    ///
    property Delimitador: String read GetDelimitador write SetDelimitador;
    property TrimString: boolean read GetTrimString write SetTrimString;
    property CurMascara: String read GetCurMascara write SetCurMascara;

    property OnError: TErrorEvent  read GetOnError write SetOnError;
  end;

procedure Register;

implementation

{$IFNDEF FPC}
 {$R ACBr_SPEDContabil.dcr}
{$ENDIF}

procedure Register;
begin
  RegisterComponents('ACBr', [TACBrSPEDContabil]);
end;

(* TACBrSPEDContabil *)

constructor TACBrSPEDContabil.Create(AOwner: TComponent);
begin
  FACBrTXT := TACBrTXTClass.Create;

  FBloco_0 := TBloco_0.Create;
  FBloco_I := TBloco_I.Create;
  FBloco_J := TBloco_J.Create;
  FBloco_9 := TBloco_9.Create;

  FPath := ExtractFilePath( ParamStr(0) );
  FDelimitador := '|';
  FCurMascara  := '#0.00';
  FTrimString  := True;
end;

destructor TACBrSPEDContabil.Destroy;
begin
  FACBrTXT.Free;

  FBloco_0.Free;
  FBloco_I.Free;
  FBloco_J.Free;
  FBloco_9.Free;
  inherited;
end;

procedure TACBrSPEDContabil.LimpaRegistros;
begin
  FBloco_0.LimpaRegistros;
  FBloco_I.LimpaRegistros;
  FBloco_J.LimpaRegistros;
  FBloco_9.LimpaRegistros;
end;

function TACBrSPEDContabil.GetDelimitador: String;
begin
   Result := FDelimitador;
end;

procedure TACBrSPEDContabil.SetDelimitador(const Value: String);
begin
  FDelimitador := Value;
  //
  FBloco_0.Delimitador := Value;
  FBloco_I.Delimitador := Value;
  FBloco_J.Delimitador := Value;
  FBloco_9.Delimitador := Value;
end;

function TACBrSPEDContabil.GetCurMascara: String;
begin
   Result := FCurMascara;
end;

procedure TACBrSPEDContabil.SetCurMascara(const Value: String);
begin
  FCurMascara := Value;
  //
  FBloco_0.CurMascara := Value;
  FBloco_I.CurMascara := Value;
  FBloco_J.CurMascara := Value;
  FBloco_9.CurMascara := Value;
end;

function TACBrSPEDContabil.GetTrimString: boolean;
begin
   Result := FTrimString;
end;

procedure TACBrSPEDContabil.SetTrimString(const Value: boolean);
begin
  FTrimString := Value;
  //
  FBloco_0.TrimString := Value;
  FBloco_I.TrimString := Value;
  FBloco_J.TrimString := Value;
  FBloco_9.TrimString := Value;
end;

function TACBrSPEDContabil.GetDT_INI: TDateTime;
begin
   Result := FDT_FIN;
end;

procedure TACBrSPEDContabil.SetDT_INI(const Value: TDateTime);
begin
  FDT_INI := Value;
  //
  FBloco_0.DT_INI := Value;
  FBloco_I.DT_INI := Value;
  FBloco_J.DT_INI := Value;
  FBloco_9.DT_INI := Value;
  //
  if Assigned(FBloco_0) then
  begin
     FBloco_0.Registro0000.DT_INI := Value;
  end;
end;

function TACBrSPEDContabil.GetDT_FIN: TDateTime;
begin
   Result := FDT_INI;
end;

procedure TACBrSPEDContabil.SetDT_FIN(const Value: TDateTime);
begin
  FDT_FIN := Value;
  //
  FBloco_0.DT_FIN := Value;
  FBloco_I.DT_FIN := Value;
  FBloco_J.DT_FIN := Value;
  FBloco_9.DT_FIN := Value;
  //
  if Assigned(FBloco_0) then
  begin
     FBloco_0.Registro0000.DT_FIN := Value;
  end;
end;

function TACBrSPEDContabil.GetOnError: TErrorEvent;
begin
   Result := FOnError;
end;

procedure TACBrSPEDContabil.SetOnError(const Value: TErrorEvent);
begin
  FOnError := Value;

  FBloco_0.OnError := Value;
  FBloco_I.OnError := Value;
  FBloco_J.OnError := Value;
  FBloco_9.OnError := Value;
end;

function TACBrSPEDContabil.SaveFileTXT(Arquivo: String): Boolean;
var
txtFile: TextFile;
intFor: integer;
begin
  Result := True;
  ///
  if (Trim(Arquivo) = '') or (Trim(fPath) = '') then
     raise Exception.Create('Caminho ou nome do arquivo não informado!');

  ///
//  Check(DT_INI > 0,        'CHECAGEM INICIAL: Informe a data inicial das informações contidas no arquivo!');
//  Check(DT_FIN > 0,        'CHECAGEM INICIAL: Informe a data final das informações contidas no arquivo!');
//  Check(DayOf(DT_INI) = 1, 'CHECAGEM INICIAL: A data inicial deve corresponder ao primeiro dia do mês informado!');
//  Check(DT_FIN >= DT_INI,  'CHECAGEM INICIAL: A data final deve se maior que a data inicial!');
//  Check(DT_FIN <= Date,    'CHECAGEM INICIAL: A data final "%s" não pode ser superior a data atual "%s"!', [DateToStr(DT_FIN), DateToStr(Date)]);
//  Check(DateOf(EndOfTheMonth(DT_FIN)) = DateOf(DT_FIN), 'CHECAGEM INICIAL: A data final deve corresponder ao último dia do mês informado!');

  /// Preparação para totalizações de registros.
  Bloco_0.Registro0990.QTD_LIN_0 := 0;
  Bloco_I.RegistroI990.QTD_LIN_I := 0;
  Bloco_J.RegistroJ990.QTD_LIN_J := 0;
  Bloco_9.Registro9990.QTD_LIN_9 := 0;
  Bloco_9.Registro9999.QTD_LIN   := 0;
  ///
  for intFor := 0 to Bloco_9.Registro9900.Count - 1 do
  begin
     Bloco_9.Registro9900.Items[intFor].Free;
  end;
  Bloco_9.Registro9900.Clear;

  try
    AssignFile(txtFile, fPath + Arquivo);
    Rewrite(txtFile);

    /// BLOCO 0
    Write(txtFile, WriteRegistro0000);
    Write(txtFile, WriteRegistro0001);
    if Bloco_0.Registro0007.Count > 0 then Write(txtFile, WriteRegistro0007);
    if Bloco_0.Registro0020.Count > 0 then Write(txtFile, WriteRegistro0020);
    if Bloco_0.Registro0150.Count > 0 then Write(txtFile, WriteRegistro0150);
    if Bloco_0.Registro0180.Count > 0 then Write(txtFile, WriteRegistro0180);
    Write(txtFile, WriteRegistro0990);

    /// BLOCO I
    Write(txtFile, WriteRegistroI001);
    Write(txtFile, WriteRegistroI010);
    if Bloco_I.RegistroI012.Count > 0 then Write(txtFile, WriteRegistroI012);
    if Bloco_I.RegistroI015.Count > 0 then Write(txtFile, WriteRegistroI015);
    if Bloco_I.RegistroI020.Count > 0 then Write(txtFile, WriteRegistroI020);
    Write(txtFile, WriteRegistroI030);
    if Bloco_I.RegistroI050.Count > 0 then Write(txtFile, WriteRegistroI050);
    if Bloco_I.RegistroI075.Count > 0 then Write(txtFile, WriteRegistroI075);
    if Bloco_I.RegistroI100.Count > 0 then Write(txtFile, WriteRegistroI100);
    if Bloco_I.RegistroI150.Count > 0 then Write(txtFile, WriteRegistroI150);
    if Bloco_I.RegistroI200.Count > 0 then Write(txtFile, WriteRegistroI200);
    if Bloco_I.RegistroI300.Count > 0 then Write(txtFile, WriteRegistroI300);
    if Bloco_I.RegistroI350.Count > 0 then Write(txtFile, WriteRegistroI350);
    if Bloco_I.RegistroI500.Count > 0 then Write(txtFile, WriteRegistroI500);
    if Bloco_I.RegistroI510.Count > 0 then Write(txtFile, WriteRegistroI510);
    if Bloco_I.RegistroI550.Count > 0 then Write(txtFile, WriteRegistroI550);

    Write(txtFile, WriteRegistroI990);

   /// BLOCO J
    Write(txtFile, WriteRegistroJ001);
    if Bloco_J.RegistroJ005.Count > 0 then Write(txtFile, WriteRegistroJ005);
    if Bloco_J.RegistroJ100.Count > 0 then Write(txtFile, WriteRegistroJ100);
    if Bloco_J.RegistroJ150.Count > 0 then Write(txtFile, WriteRegistroJ150);
    if Bloco_J.RegistroJ800.Count > 0 then Write(txtFile, WriteRegistroJ800);
    Write(txtFile, WriteRegistroJ900);
    if Bloco_J.RegistroJ930.Count > 0 then Write(txtFile, WriteRegistroJ930);
    Write(txtFile, WriteRegistroJ990);

    /// BLOCO 9
    Write(txtFile, WriteRegistro9001);
    Write(txtFile, WriteRegistro9900);
    Write(txtFile, WriteRegistro9990);
    Write(txtFile, WriteRegistro9999);
    ///
    CloseFile(txtFile);
    /// Atualiza os totais de registros nos termos de abertura e fechamento
    /// I030 e J900
    TotalizaTermos(Arquivo);
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

function TACBrSPEDContabil.WriteRegistro0000: String;
begin
   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := '0000';
      QTD_REG_BLC := 1;
   end;
   Result := Bloco_0.WriteRegistro0000;
end;

function TACBrSPEDContabil.WriteRegistro0001: String;
begin
   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := '0001';
      QTD_REG_BLC := 1;
   end;
   Result := Bloco_0.WriteRegistro0001;
end;

function TACBrSPEDContabil.WriteRegistro0007: String;
begin
   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := '0007';
      QTD_REG_BLC := Bloco_0.Registro0007.Count;
   end;
   Result := Bloco_0.WriteRegistro0007;
end;

function TACBrSPEDContabil.WriteRegistro0020: String;
begin
   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := '0020';
      QTD_REG_BLC := Bloco_0.Registro0020.Count;
   end;
   Result := Bloco_0.WriteRegistro0020;
end;

function TACBrSPEDContabil.WriteRegistro0150: String;
begin
   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := '0150';
      QTD_REG_BLC := Bloco_0.Registro0150.Count;
   end;
   Result := Bloco_0.WriteRegistro0150;
end;

function TACBrSPEDContabil.WriteRegistro0180: String;
begin
   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := '0175';
      QTD_REG_BLC := Bloco_0.Registro0180.Count;
   end;
   Result := Bloco_0.WriteRegistro0180;
end;

function TACBrSPEDContabil.WriteRegistro0990: String;
begin
   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := '0990';
      QTD_REG_BLC := 1;
   end;
   Result := Bloco_0.WriteRegistro0990;
end;

function TACBrSPEDContabil.WriteRegistroI001: String;
begin
   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := 'I001';
      QTD_REG_BLC := 1;
   end;
   Result := Bloco_I.WriteRegistroI001;
end;

function TACBrSPEDContabil.WriteRegistroI010: String;
begin
   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := 'I010';
      QTD_REG_BLC := 1;
   end;
   Result := Bloco_I.WriteRegistroI010;
end;

function TACBrSPEDContabil.WriteRegistroI012: String;
begin
   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := 'I012';
      QTD_REG_BLC := Bloco_I.RegistroI012.Count;
   end;
   Result := Bloco_I.WriteRegistroI012;
end;

function TACBrSPEDContabil.WriteRegistroI015: String;
begin
   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := 'I015';
      QTD_REG_BLC := Bloco_I.RegistroI015.Count;
   end;
   Result := Bloco_I.WriteRegistroI015;
end;

function TACBrSPEDContabil.WriteRegistroI020: String;
begin
   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := 'I020';
      QTD_REG_BLC := Bloco_I.RegistroI020.Count;
   end;
   Result := Bloco_I.WriteRegistroI020;
end;

function TACBrSPEDContabil.WriteRegistroI030: String;
begin
   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := 'I030';
      QTD_REG_BLC := 1;
   end;
   // Total de linhas do arquivo
   Bloco_I.RegistroI030.QTD_LIN := Bloco_0.Registro0990.QTD_LIN_0 +
                                   Bloco_I.RegistroI990.QTD_LIN_I +
                                   Bloco_J.RegistroJ990.QTD_LIN_J +
                                   Bloco_9.Registro9990.QTD_LIN_9;
   Result := Bloco_I.WriteRegistroI030;
end;

function TACBrSPEDContabil.WriteRegistroI050: String;
begin
   Result := Bloco_I.WriteRegistroI050;

   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := 'I050';
      QTD_REG_BLC := Bloco_I.RegistroI050.Count;
   end;
   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := 'I051';
      QTD_REG_BLC := Bloco_I.RegistroI051Count;
   end;
   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := 'I052';
      QTD_REG_BLC := Bloco_I.RegistroI052Count;
   end;
end;

function TACBrSPEDContabil.WriteRegistroI075: String;
begin
   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := 'I075';
      QTD_REG_BLC := Bloco_I.RegistroI075.Count;
   end;
   Result := Bloco_I.WriteRegistroI075;
end;

function TACBrSPEDContabil.WriteRegistroI100: String;
begin
   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := 'I100';
      QTD_REG_BLC := Bloco_I.RegistroI100.Count;
   end;
   Result := Bloco_I.WriteRegistroI100;
end;

function TACBrSPEDContabil.WriteRegistroI150: String;
begin
   Result := Bloco_I.WriteRegistroI150;

   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := 'I150';
      QTD_REG_BLC := Bloco_I.RegistroI150.Count;
   end;
   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := 'I151';
      QTD_REG_BLC := Bloco_I.RegistroI151Count;
   end;
   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := 'I155';
      QTD_REG_BLC := Bloco_I.RegistroI155Count;
   end;
end;

function TACBrSPEDContabil.WriteRegistroI200: String;
begin
   Result := Bloco_I.WriteRegistroI200;

   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := 'I200';
      QTD_REG_BLC := Bloco_I.RegistroI200.Count;
   end;
   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := 'I250';
      QTD_REG_BLC := Bloco_I.RegistroI250Count;
   end;
end;

function TACBrSPEDContabil.WriteRegistroI300: String;
begin
   Result := Bloco_I.WriteRegistroI300;

   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := 'I300';
      QTD_REG_BLC := Bloco_I.RegistroI300.Count;
   end;
   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := 'I310';
      QTD_REG_BLC := Bloco_I.RegistroI310Count;
   end;
end;

function TACBrSPEDContabil.WriteRegistroI350: String;
begin
   Result := Bloco_I.WriteRegistroI350;

   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := 'I350';
      QTD_REG_BLC := Bloco_I.RegistroI350.Count;
   end;
   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := 'I355';
      QTD_REG_BLC := Bloco_I.RegistroI355Count;
   end;
end;

function TACBrSPEDContabil.WriteRegistroI500: String;
begin
   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := 'I500';
      QTD_REG_BLC := Bloco_I.RegistroI500.Count;
   end;
   Result := Bloco_I.WriteRegistroI500;
end;


function TACBrSPEDContabil.WriteRegistroI510: String;
begin
   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := 'I510';
      QTD_REG_BLC := Bloco_I.RegistroI510.Count;
   end;
   Result := Bloco_I.WriteRegistroI510;
end;

function TACBrSPEDContabil.WriteRegistroI550: String;
begin
   Result := Bloco_I.WriteRegistroI550;

   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := 'I550';
      QTD_REG_BLC := Bloco_I.RegistroI550.Count;
   end;
   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := 'I555';
      QTD_REG_BLC := Bloco_I.RegistroI555Count;
   end;
end;

function TACBrSPEDContabil.WriteRegistroI990: String;
begin
   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := 'I990';
      QTD_REG_BLC := 1;
   end;
   Result := Bloco_I.WriteRegistroI990;
end;

function TACBrSPEDContabil.WriteRegistroJ001: String;
begin
   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := 'J001';
      QTD_REG_BLC := 1;
   end;
   Result := Bloco_J.WriteRegistroJ001;
end;

function TACBrSPEDContabil.WriteRegistroJ005: String;
begin
   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := 'J005';
      QTD_REG_BLC := Bloco_J.RegistroJ005.Count;
   end;
   Result := Bloco_J.WriteRegistroJ005;
end;

function TACBrSPEDContabil.WriteRegistroJ100: String;
begin
   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := 'J100';
      QTD_REG_BLC := Bloco_J.RegistroJ100.Count;
   end;
   Result := Bloco_J.WriteRegistroJ100;
end;

function TACBrSPEDContabil.WriteRegistroJ150: String;
begin
   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := 'J150';
      QTD_REG_BLC := Bloco_J.RegistroJ150.Count;
   end;
   Result := Bloco_J.WriteRegistroJ150;
end;

function TACBrSPEDContabil.WriteRegistroJ800: String;
begin
   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := 'J800';
      QTD_REG_BLC := Bloco_J.RegistroJ800.Count;
   end;
   Result := Bloco_J.WriteRegistroJ800;
end;

function TACBrSPEDContabil.WriteRegistroJ900: String;
begin
   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := 'J900';
      QTD_REG_BLC := 1;
   end;
   Result := Bloco_J.WriteRegistroJ900;
end;

function TACBrSPEDContabil.WriteRegistroJ930: String;
begin
   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := 'J930';
      QTD_REG_BLC := Bloco_J.RegistroJ930.Count;
   end;
   Result := Bloco_J.WriteRegistroJ930;
end;

function TACBrSPEDContabil.WriteRegistroJ990: String;
begin
   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := 'J990';
      QTD_REG_BLC := 1;
   end;
   Result := Bloco_J.WriteRegistroJ990;
end;

function TACBrSPEDContabil.WriteRegistro9001: String;
begin
   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := '9001';
      QTD_REG_BLC := 1;
   end;
   Result := Bloco_9.WriteRegistro9001;
end;

function TACBrSPEDContabil.WriteRegistro9900: String;
begin
   with Bloco_9.Registro9900 do
   begin
      with New do
      begin
         REG_BLC := '9900';
         QTD_REG_BLC := Bloco_9.Registro9900.Count + 2;
      end;
      with New do
      begin
         REG_BLC := '9990';
         QTD_REG_BLC := 1;
      end;
      with New do
      begin
         REG_BLC := '9999';
         QTD_REG_BLC := 1;
      end;
   end;
   Result := Bloco_9.WriteRegistro9900;
end;

function TACBrSPEDContabil.WriteRegistro9990: String;
begin
   Result := Bloco_9.WriteRegistro9990;
end;

function TACBrSPEDContabil.WriteRegistro9999: String;
begin
   Bloco_9.Registro9999.QTD_LIN := Bloco_9.Registro9999.QTD_LIN + Bloco_0.Registro0990.QTD_LIN_0 +
                                                                  Bloco_I.RegistroI990.QTD_LIN_I +
                                                                  Bloco_J.RegistroJ990.QTD_LIN_J +
                                                                  Bloco_9.Registro9990.QTD_LIN_9;
   Result := Bloco_9.WriteRegistro9999;
end;

function TACBrSPEDContabil.GetAbout: String;
begin
   Result := 'ACBrSpedContabil Ver: '+CACBrSpedContabil_Versao;
end;

procedure TACBrSPEDContabil.SetAbout(const Value: String);
begin
 {}
end;

procedure TACBrSPEDContabil.TotalizaTermos(Arquivo: String);
var
objFile: TStringList;
intLine: Integer;
begin
   objFile := TStringList.Create;
   try
     with objFile do
     begin
        LoadFromFile(fPath + Arquivo);
        for intLine := 0 to Count -1 do
        begin
           if Copy(Strings[intLine], 2, 4) = 'I030' then
           begin
              Strings[intLine] := StringReplace(Strings[intLine], '|[*******]',  FACBrTXT.LFill(Bloco_9.Registro9999.QTD_LIN, 9, false), []);
           end
           else
           if Copy(Strings[intLine], 2, 4) = 'J900' then
           begin
              Strings[intLine] := StringReplace(Strings[intLine], '|[*******]',  FACBrTXT.LFill(Bloco_9.Registro9999.QTD_LIN, 9, false), []);
              Break;
           end;
        end;
     end;
   finally
     objFile.SaveToFile(fPath + Arquivo);
     objFile.Free;
   end;
end;

end.
