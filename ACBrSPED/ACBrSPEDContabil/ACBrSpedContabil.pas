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
  SysUtils, Classes, DateUtils, ACBrSped,
  ACBrECDBloco_0_Class, ACBrECDBloco_9_Class, ACBrECDBloco_I_Class,
  ACBrECDBloco_J_Class;

const
   CACBrSpedContabil_Versao = '0.04a' ;

type
  /// ACBrSpedContabil - Sitema Publico de Escrituração Digital Contabil
  TACBrSPEDContabil = class(TACBrSPED)
  private
    FArquivo:AnsiString ;      /// Nome do arquivo a ser gerado
    FPath: AnsiString;         /// Path do arquivo a ser gerado
    FBloco_0: TBloco_0;
    FBloco_9: TBloco_9;
    FBloco_I: TBloco_I;
    FBloco_J: TBloco_J;

    procedure LimpaRegistros;
    function GetAbout: String;
    procedure SetAbout(const Value: String);
    procedure TotalizaTermos(Arquivo: AnsiString);
  protected
    // Periodo
    procedure SetDT_FIN(const Value: TDateTime); override;
    procedure SetDT_INI(const Value: TDateTime); override;
    procedure SetDelimitador(const Value: AnsiString); override;
    procedure SetTrimString(const Value: boolean); override;
    procedure SetCurMascara(const Value: AnsiString); override;
    /// BLOCO 0
    function WriteRegistro0000: AnsiString;
    function WriteRegistro0001: AnsiString;
    function WriteRegistro0007: AnsiString;
    function WriteRegistro0020: AnsiString;
    function WriteRegistro0150: AnsiString;
    function WriteRegistro0180: AnsiString;
    function WriteRegistro0990: AnsiString;
    /// BLOCO I
    function WriteRegistroI001: AnsiString;
    function WriteRegistroI010: AnsiString;
    function WriteRegistroI012: AnsiString;
    function WriteRegistroI015: AnsiString;
    function WriteRegistroI020: AnsiString;
    function WriteRegistroI030: AnsiString;
    function WriteRegistroI050: AnsiString;
    function WriteRegistroI075: AnsiString;
    function WriteRegistroI100: AnsiString;
    function WriteRegistroI150: AnsiString;
    function WriteRegistroI200: AnsiString;
    function WriteRegistroI300: AnsiString;
    function WriteRegistroI350: AnsiString;
    function WriteRegistroI500: AnsiString;
    function WriteRegistroI510: AnsiString;
    function WriteRegistroI550: AnsiString;

    function WriteRegistroI990: AnsiString;
    /// BLOCO J
    function WriteRegistroJ001: AnsiString;
    function WriteRegistroJ005: AnsiString;
    function WriteRegistroJ100: AnsiString;
    function WriteRegistroJ150: AnsiString;
    function WriteRegistroJ800: AnsiString;
    function WriteRegistroJ900: AnsiString;
    function WriteRegistroJ930: AnsiString;
    function WriteRegistroJ990: AnsiString;
    /// BLOCO 9
    function WriteRegistro9001: AnsiString;
    function WriteRegistro9900: AnsiString;
    function WriteRegistro9990: AnsiString;
    function WriteRegistro9999: AnsiString;
  public
    constructor Create(AOwner: TComponent); override; /// Create
    destructor Destroy; override; /// Destroy

    function SaveFileTXT(Arquivo: AnsiString): Boolean; /// Método que escreve o arquivo texto no caminho passado como parâmetro

    property Bloco_0: TBloco_0 read FBloco_0 write FBloco_0;
    property Bloco_9: TBloco_9 read FBloco_9 write FBloco_9;
    property Bloco_I: TBloco_I read FBloco_I write FBloco_I;
    property Bloco_J: TBloco_J read FBloco_J write FBloco_J;
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
 {$R ACBr_SPEDContabil.dcr}
{$ENDIF}

procedure Register;
begin
  RegisterComponents('ACBr', [TACBrSPEDContabil]);
end;

(* TACBrSPEDContabil *)

constructor TACBrSPEDContabil.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FBloco_0 := TBloco_0.Create(Self);
  FBloco_I := TBloco_I.Create(Self);
  FBloco_J := TBloco_J.Create(Self);
  FBloco_9 := TBloco_9.Create(Self);

  FPath    := ExtractFilePath( ParamStr(0) );
end;

destructor TACBrSPEDContabil.Destroy;
begin
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

procedure TACBrSPEDContabil.SetDT_INI(const Value: TDateTime);
begin
  inherited;
   if Assigned(FBloco_0) then
   begin
      FBloco_0.Registro0000.DT_INI := Value;
   end;
end;

procedure TACBrSPEDContabil.SetTrimString(const Value: boolean);
begin
  inherited;
  FBloco_0.TrimString := Value;
  FBloco_I.TrimString := Value;
  FBloco_J.TrimString := Value;
  FBloco_9.TrimString := Value;
end;

procedure TACBrSPEDContabil.SetCurMascara(const Value: AnsiString);
begin
  inherited;
  FBloco_0.CurMascara := Value;
  FBloco_I.CurMascara := Value;
  FBloco_J.CurMascara := Value;
  FBloco_9.CurMascara := Value;
end;

procedure TACBrSPEDContabil.SetDelimitador(const Value: AnsiString);
begin
  inherited;
  FBloco_0.Delimitador := Value;
  FBloco_I.Delimitador := Value;
  FBloco_J.Delimitador := Value;
  FBloco_9.Delimitador := Value;
end;

procedure TACBrSPEDContabil.SetDT_FIN(const Value: TDateTime);
begin
  inherited;
   if Assigned(FBloco_0) then
   begin
      FBloco_0.Registro0000.DT_FIN := Value;
   end;
end;

function TACBrSPEDContabil.SaveFileTXT(Arquivo: AnsiString): Boolean;
var
txtFile: TextFile;
intFor: integer;
begin
  Result := True;
  ///
  if (Trim(Arquivo) = '') or (Trim(fPath) = '') then
     raise Exception.Create('Caminho ou nome do arquivo não informado!');

  /// Atribuir o evento do componente aos eventos dos Blocos, para que sejam
  /// disparados.
  FBloco_0.OnError := OnError;
  FBloco_I.OnError := OnError;
  FBloco_J.OnError := OnError;
  FBloco_9.OnError := OnError;
  ///
  Check(DT_INI > 0,        'CHECAGEM INICIAL: Informe a data inicial das informações contidas no arquivo!');
  Check(DT_FIN > 0,        'CHECAGEM INICIAL: Informe a data final das informações contidas no arquivo!');
  Check(DayOf(DT_INI) = 1, 'CHECAGEM INICIAL: A data inicial deve corresponder ao primeiro dia do mês informado!');
  Check(DT_FIN >= DT_INI,  'CHECAGEM INICIAL: A data final deve se maior que a data inicial!');
  Check(DT_FIN <= Date,    'CHECAGEM INICIAL: A data final "%s" não pode ser superior a data atual "%s"!', [DateToStr(DT_FIN), DateToStr(Date)]);
  Check(DateOf(EndOfTheMonth(DT_FIN)) = DateOf(DT_FIN), 'CHECAGEM INICIAL: A data final deve corresponder ao último dia do mês informado!');

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

function TACBrSPEDContabil.WriteRegistro0000: AnsiString;
begin
   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := '0000';
      QTD_REG_BLC := 1;
   end;
   Result := Bloco_0.WriteRegistro0000;
end;

function TACBrSPEDContabil.WriteRegistro0001: AnsiString;
begin
   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := '0001';
      QTD_REG_BLC := 1;
   end;
   Result := Bloco_0.WriteRegistro0001;
end;

function TACBrSPEDContabil.WriteRegistro0007: AnsiString;
begin
   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := '0007';
      QTD_REG_BLC := Bloco_0.Registro0007.Count;
   end;
   Result := Bloco_0.WriteRegistro0007;
end;

function TACBrSPEDContabil.WriteRegistro0020: AnsiString;
begin
   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := '0020';
      QTD_REG_BLC := Bloco_0.Registro0020.Count;
   end;
   Result := Bloco_0.WriteRegistro0020;
end;

function TACBrSPEDContabil.WriteRegistro0150: AnsiString;
begin
   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := '0150';
      QTD_REG_BLC := Bloco_0.Registro0150.Count;
   end;
   Result := Bloco_0.WriteRegistro0150;
end;

function TACBrSPEDContabil.WriteRegistro0180: AnsiString;
begin
   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := '0175';
      QTD_REG_BLC := Bloco_0.Registro0180.Count;
   end;
   Result := Bloco_0.WriteRegistro0180;
end;

function TACBrSPEDContabil.WriteRegistro0990: AnsiString;
begin
   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := '0990';
      QTD_REG_BLC := 1;
   end;
   Result := Bloco_0.WriteRegistro0990;
end;

function TACBrSPEDContabil.WriteRegistroI001: AnsiString;
begin
   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := 'I001';
      QTD_REG_BLC := 1;
   end;
   Result := Bloco_I.WriteRegistroI001;
end;

function TACBrSPEDContabil.WriteRegistroI010: AnsiString;
begin
   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := 'I010';
      QTD_REG_BLC := 1;
   end;
   Result := Bloco_I.WriteRegistroI010;
end;

function TACBrSPEDContabil.WriteRegistroI012: AnsiString;
begin
   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := 'I012';
      QTD_REG_BLC := Bloco_I.RegistroI012.Count;
   end;
   Result := Bloco_I.WriteRegistroI012;
end;

function TACBrSPEDContabil.WriteRegistroI015: AnsiString;
begin
   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := 'I015';
      QTD_REG_BLC := Bloco_I.RegistroI015.Count;
   end;
   Result := Bloco_I.WriteRegistroI015;
end;

function TACBrSPEDContabil.WriteRegistroI020: AnsiString;
begin
   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := 'I020';
      QTD_REG_BLC := Bloco_I.RegistroI020.Count;
   end;
   Result := Bloco_I.WriteRegistroI020;
end;

function TACBrSPEDContabil.WriteRegistroI030: AnsiString;
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

function TACBrSPEDContabil.WriteRegistroI050: AnsiString;
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

function TACBrSPEDContabil.WriteRegistroI075: AnsiString;
begin
   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := 'I075';
      QTD_REG_BLC := Bloco_I.RegistroI075.Count;
   end;
   Result := Bloco_I.WriteRegistroI075;
end;

function TACBrSPEDContabil.WriteRegistroI100: AnsiString;
begin
   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := 'I100';
      QTD_REG_BLC := Bloco_I.RegistroI100.Count;
   end;
   Result := Bloco_I.WriteRegistroI100;
end;

function TACBrSPEDContabil.WriteRegistroI150: AnsiString;
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

function TACBrSPEDContabil.WriteRegistroI200: AnsiString;
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

function TACBrSPEDContabil.WriteRegistroI300: AnsiString;
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

function TACBrSPEDContabil.WriteRegistroI350: AnsiString;
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

function TACBrSPEDContabil.WriteRegistroI500: AnsiString;
begin
   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := 'I500';
      QTD_REG_BLC := Bloco_I.RegistroI500.Count;
   end;
   Result := Bloco_I.WriteRegistroI500;
end;


function TACBrSPEDContabil.WriteRegistroI510: AnsiString;
begin
   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := 'I510';
      QTD_REG_BLC := Bloco_I.RegistroI510.Count;
   end;
   Result := Bloco_I.WriteRegistroI510;
end;

function TACBrSPEDContabil.WriteRegistroI550: AnsiString;
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

function TACBrSPEDContabil.WriteRegistroI990: AnsiString;
begin
   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := 'I990';
      QTD_REG_BLC := 1;
   end;
   Result := Bloco_I.WriteRegistroI990;
end;

function TACBrSPEDContabil.WriteRegistroJ001: AnsiString;
begin
   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := 'J001';
      QTD_REG_BLC := 1;
   end;
   Result := Bloco_J.WriteRegistroJ001;
end;

function TACBrSPEDContabil.WriteRegistroJ005: AnsiString;
begin
   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := 'J005';
      QTD_REG_BLC := Bloco_J.RegistroJ005.Count;
   end;
   Result := Bloco_J.WriteRegistroJ005;
end;

function TACBrSPEDContabil.WriteRegistroJ100: AnsiString;
begin
   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := 'J100';
      QTD_REG_BLC := Bloco_J.RegistroJ100.Count;
   end;
   Result := Bloco_J.WriteRegistroJ100;
end;

function TACBrSPEDContabil.WriteRegistroJ150: AnsiString;
begin
   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := 'J150';
      QTD_REG_BLC := Bloco_J.RegistroJ150.Count;
   end;
   Result := Bloco_J.WriteRegistroJ150;
end;

function TACBrSPEDContabil.WriteRegistroJ800: AnsiString;
begin
   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := 'J800';
      QTD_REG_BLC := Bloco_J.RegistroJ800.Count;
   end;
   Result := Bloco_J.WriteRegistroJ800;
end;

function TACBrSPEDContabil.WriteRegistroJ900: AnsiString;
begin
   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := 'J900';
      QTD_REG_BLC := 1;
   end;
   Result := Bloco_J.WriteRegistroJ900;
end;

function TACBrSPEDContabil.WriteRegistroJ930: AnsiString;
begin
   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := 'J930';
      QTD_REG_BLC := Bloco_J.RegistroJ930.Count;
   end;
   Result := Bloco_J.WriteRegistroJ930;
end;

function TACBrSPEDContabil.WriteRegistroJ990: AnsiString;
begin
   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := 'J990';
      QTD_REG_BLC := 1;
   end;
   Result := Bloco_J.WriteRegistroJ990;
end;

function TACBrSPEDContabil.WriteRegistro9001: AnsiString;
begin
   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := '9001';
      QTD_REG_BLC := 1;
   end;
   Result := Bloco_9.WriteRegistro9001;
end;

function TACBrSPEDContabil.WriteRegistro9900: AnsiString;
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

function TACBrSPEDContabil.WriteRegistro9990: AnsiString;
begin
   Result := Bloco_9.WriteRegistro9990;
end;

function TACBrSPEDContabil.WriteRegistro9999: AnsiString;
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

procedure TACBrSPEDContabil.TotalizaTermos(Arquivo: AnsiString);
var
objFile: TStringList;
intLine: Integer;
begin
   try
     objFile := TStringList.Create;
     with objFile do
     begin
        LoadFromFile(fPath + Arquivo);
        for intLine := 0 to Count -1 do
        begin
           if Copy(Strings[intLine], 2, 4) = 'I030' then
           begin
              Strings[intLine] := StringReplace(Strings[intLine], '[*******]',  LFill(Bloco_9.Registro9999.QTD_LIN, 9, false), []);
           end
           else
           if Copy(Strings[intLine], 2, 4) = 'J900' then
           begin
              Strings[intLine] := StringReplace(Strings[intLine], '[*******]',  LFill(Bloco_9.Registro9999.QTD_LIN, 9, false), []);
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
