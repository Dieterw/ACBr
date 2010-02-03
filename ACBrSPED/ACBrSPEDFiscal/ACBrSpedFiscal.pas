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

unit ACBrSpedFiscal;

interface

uses
  SysUtils, Classes, DateUtils, ACBrSped,
  ACBrEFDBloco_0_Class, ACBrEFDBloco_1_Class, ACBrEFDBloco_9_Class,
  ACBrEFDBloco_C_Class, ACBrEFDBloco_D_Class, ACBrEFDBloco_E_Class,
  ACBrEFDBloco_H_Class;

const
   CACBrSpedFiscal_Versao = '0.06a' ;

type
  /// ACBrSpedFiscal - Sitema Publico de Escrituração Digital Fiscal
  TACBrSPEDFiscal = class(TACBrSPED)
  private
    FArquivo:AnsiString ;      /// Nome do arquivo a ser gerado
    FPath: AnsiString;         /// Path do arquivo a ser gerado
    FBloco_0: TBloco_0;
    FBloco_1: TBloco_1;
    FBloco_9: TBloco_9;
    FBloco_C: TBloco_C;
    FBloco_D: TBloco_D;
    FBloco_E: TBloco_E;
    FBloco_H: TBloco_H;

    procedure LimpaRegistros;
    function GetAbout: String;
    procedure SetAbout(const Value: String);
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
    function WriteRegistro0005: AnsiString;
    function WriteRegistro0015: AnsiString;
    function WriteRegistro0100: AnsiString;
    function WriteRegistro0150: AnsiString;
    function WriteRegistro0190: AnsiString;
    function WriteRegistro0200: AnsiString;
    function WriteRegistro0400: AnsiString;
    function WriteRegistro0450: AnsiString;
    function WriteRegistro0460: AnsiString;
    function WriteRegistro0990: AnsiString;
    /// BLOCO 1
    function WriteRegistro1001: AnsiString;
    function WriteRegistro1100: AnsiString;
    function WriteRegistro1105: AnsiString;
    function WriteRegistro1110: AnsiString;
    function WriteRegistro1200: AnsiString;
    function WriteRegistro1210: AnsiString;
    function WriteRegistro1300: AnsiString;
    function WriteRegistro1350: AnsiString;
    function WriteRegistro1400: AnsiString;
    function WriteRegistro1500: AnsiString;
    function WriteRegistro1510: AnsiString;
    function WriteRegistro1990: AnsiString;
    /// BLOCO C
    function WriteRegistroC001: AnsiString;
    function WriteRegistroC100: AnsiString;
    function WriteRegistroC197: AnsiString;
    function WriteRegistroC300: AnsiString;
    function WriteRegistroC310: AnsiString;
    function WriteRegistroC320: AnsiString;
    function WriteRegistroC321: AnsiString;
    function WriteRegistroC350: AnsiString;
    function WriteRegistroC400: AnsiString;
    function WriteRegistroC495: AnsiString;
    function WriteRegistroC500: AnsiString;
    function WriteRegistroC600: AnsiString;
    function WriteRegistroC601: AnsiString;
    function WriteRegistroC610: AnsiString;
    function WriteRegistroC620: AnsiString;
    function WriteRegistroC690: AnsiString;
    function WriteRegistroC700: AnsiString;
    function WriteRegistroC790: AnsiString;
    function WriteRegistroC791: AnsiString;
    function WriteRegistroC990: AnsiString;
    /// BLOCO D
    function WriteRegistroD001: AnsiString;
    function WriteRegistroD100: AnsiString;
    function WriteRegistroD110: AnsiString;
    function WriteRegistroD120: AnsiString;
    function WriteRegistroD130: AnsiString;
    function WriteRegistroD140: AnsiString;
    function WriteRegistroD150: AnsiString;
    function WriteRegistroD160: AnsiString;
    function WriteRegistroD161: AnsiString;
    function WriteRegistroD162: AnsiString;
    function WriteRegistroD165: AnsiString;
    function WriteRegistroD170: AnsiString;
    function WriteRegistroD180: AnsiString;
    function WriteRegistroD300: AnsiString;
    function WriteRegistroD301: AnsiString;
    function WriteRegistroD310: AnsiString;
    function WriteRegistroD350: AnsiString;
    function WriteRegistroD355: AnsiString;
    function WriteRegistroD360: AnsiString;
    function WriteRegistroD365: AnsiString;
    function WriteRegistroD370: AnsiString;
    function WriteRegistroD390: AnsiString;
    function WriteRegistroD400: AnsiString;
    function WriteRegistroD410: AnsiString;
    function WriteRegistroD411: AnsiString;
    function WriteRegistroD420: AnsiString;
    function WriteRegistroD500: AnsiString;
    function WriteRegistroD990: AnsiString;
    /// BLOCO E
    function WriteRegistroE001: AnsiString;
    function WriteRegistroE100: AnsiString;
    function WriteRegistroE110: AnsiString;
    function WriteRegistroE111: AnsiString;
    function WriteRegistroE112: AnsiString;
    function WriteRegistroE113: AnsiString;
    function WriteRegistroE115: AnsiString;
    function WriteRegistroE116: AnsiString;
    function WriteRegistroE200: AnsiString;
    function WriteRegistroE220: AnsiString;
    function WriteRegistroE230: AnsiString;
    function WriteRegistroE240: AnsiString;
    function WriteRegistroE250: AnsiString;
    function WriteRegistroE500: AnsiString;
    function WriteRegistroE510: AnsiString;
    function WriteRegistroE520: AnsiString;
    function WriteRegistroE530: AnsiString;
    function WriteRegistroE990: AnsiString;
    /// BLOCO H
    function WriteRegistroH001: AnsiString;
    function WriteRegistroH005: AnsiString;
    function WriteRegistroH990: AnsiString;
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
    property Bloco_1: TBloco_1 read FBloco_1 write FBloco_1;
    property Bloco_9: TBloco_9 read FBloco_9 write FBloco_9;
    property Bloco_C: TBloco_C read FBloco_C write FBloco_C;
    property Bloco_D: TBloco_D read FBloco_D write FBloco_D;
    property Bloco_E: TBloco_E read FBloco_E write FBloco_E;
    property Bloco_H: TBloco_H read FBloco_H write FBloco_H;
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
 {$R ACBr_SPEDFiscal.dcr}
{$ENDIF}

procedure Register;
begin
  RegisterComponents('ACBr', [TACBrSPEDFiscal]);
end;

(* TACBrSPEDFiscal *)

constructor TACBrSPEDFiscal.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FBloco_0 := TBloco_0.Create(Self);
  FBloco_1 := TBloco_1.Create(Self);
  FBloco_C := TBloco_C.Create(Self);
  FBloco_D := TBloco_D.Create(Self);
  FBloco_E := TBloco_E.Create(Self);
  FBloco_H := TBloco_H.Create(Self);
  FBloco_9 := TBloco_9.Create(Self);

  /// Objeto passado por referência para que possamos usa-lo para fazer pesquisa
  /// em seus registros.
  /// Ex: Do Bloco_C registro C425, pesquisar o Bloco_0 registro 0200.
  FBloco_C.Bloco_0 := FBloco_0;

  FPath    := ExtractFilePath( ParamStr(0) );
end;

destructor TACBrSPEDFiscal.Destroy;
begin
  FBloco_0.Free;
  FBloco_1.Free;
  FBloco_C.Free;
  FBloco_D.Free;
  FBloco_E.Free;
  FBloco_H.Free;
  FBloco_9.Free;
  inherited;
end;

procedure TACBrSPEDFiscal.LimpaRegistros;
begin
  FBloco_0.LimpaRegistros;
  FBloco_1.LimpaRegistros;
  FBloco_C.LimpaRegistros;
  FBloco_D.LimpaRegistros;
  FBloco_E.LimpaRegistros;
  FBloco_H.LimpaRegistros;
  FBloco_9.LimpaRegistros;
end;

procedure TACBrSPEDFiscal.SetDT_INI(const Value: TDateTime);
begin
  inherited;
   if Assigned(FBloco_0) then
   begin
      FBloco_0.Registro0000.DT_INI := Value;
      FBloco_E.RegistroE100.DT_INI := Value;
   end;
end;

procedure TACBrSPEDFiscal.SetTrimString(const Value: boolean);
begin
  inherited;
  FBloco_0.TrimString := Value;
  FBloco_1.TrimString := Value;
  FBloco_C.TrimString := Value;
  FBloco_D.TrimString := Value;
  FBloco_E.TrimString := Value;
  FBloco_H.TrimString := Value;
  FBloco_9.TrimString := Value;
end;

procedure TACBrSPEDFiscal.SetCurMascara(const Value: AnsiString);
begin
  inherited;
  FBloco_0.CurMascara := Value;
  FBloco_1.CurMascara := Value;
  FBloco_C.CurMascara := Value;
  FBloco_D.CurMascara := Value;
  FBloco_E.CurMascara := Value;
  FBloco_H.CurMascara := Value;
  FBloco_9.CurMascara := Value;
end;

procedure TACBrSPEDFiscal.SetDelimitador(const Value: AnsiString);
begin
  inherited;
  FBloco_0.Delimitador := Value;
  FBloco_1.Delimitador := Value;
  FBloco_C.Delimitador := Value;
  FBloco_D.Delimitador := Value;
  FBloco_E.Delimitador := Value;
  FBloco_H.Delimitador := Value;
  FBloco_9.Delimitador := Value;
end;

procedure TACBrSPEDFiscal.SetDT_FIN(const Value: TDateTime);
begin
  inherited;
   if Assigned(FBloco_0) then
   begin
      FBloco_0.Registro0000.DT_FIN := Value;
      FBloco_E.RegistroE100.DT_FIN := Value;
   end;
end;

function TACBrSPEDFiscal.SaveFileTXT(Arquivo: AnsiString): Boolean;
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
  FBloco_1.OnError := OnError;
  FBloco_C.OnError := OnError;
  FBloco_D.OnError := OnError;
  FBloco_E.OnError := OnError;
  FBloco_H.OnError := OnError;
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
  Bloco_1.Registro1990.QTD_LIN_1 := 0;
  Bloco_C.RegistroC990.QTD_LIN_C := 0;
  Bloco_D.RegistroD990.QTD_LIN_D := 0;
  Bloco_E.RegistroE990.QTD_LIN_E := 0;
  Bloco_H.RegistroH990.QTD_LIN_H := 0;
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
    Write(txtFile, WriteRegistro0005);
    if Bloco_0.Registro0015.Count > 0 then Write(txtFile, WriteRegistro0015);
    Write(txtFile, WriteRegistro0100);
    if Bloco_0.Registro0150.Count > 0 then Write(txtFile, WriteRegistro0150);
    if Bloco_0.Registro0190.Count > 0 then Write(txtFile, WriteRegistro0190);
    if Bloco_0.Registro0200.Count > 0 then Write(txtFile, WriteRegistro0200); // Prates
    if Bloco_0.Registro0400.Count > 0 then Write(txtFile, WriteRegistro0400); // Prates
    if Bloco_0.Registro0450.Count > 0 then Write(txtFile, WriteRegistro0450);
    if Bloco_0.Registro0460.Count > 0 then Write(txtFile, WriteRegistro0460); // Prates
    Write(txtFile, WriteRegistro0990);

    /// BLOCO C
    Write(txtFile, WriteRegistroC001);
    if Bloco_C.RegistroC100.Count > 0 then Write(txtFile, WriteRegistroC100); // Prates
    if Bloco_C.RegistroC197.Count > 0 then Write(txtFile, WriteRegistroC197); // Prates
    if Bloco_C.RegistroC300.Count > 0 then Write(txtFile, WriteRegistroC300); // Prates
    if Bloco_C.RegistroC310.Count > 0 then Write(txtFile, WriteRegistroC310); // Prates
    if Bloco_C.RegistroC320.Count > 0 then Write(txtFile, WriteRegistroC320); // Prates
    if Bloco_C.RegistroC321.Count > 0 then Write(txtFile, WriteRegistroC321); // Prates
    if Bloco_C.RegistroC350.Count > 0 then Write(txtFile, WriteRegistroC350); // Prates
    if Bloco_C.RegistroC400.Count > 0 then Write(txtFile, WriteRegistroC400); // Prates
    if Bloco_C.RegistroC495.Count > 0 then Write(txtFile, WriteRegistroC495); // Prates
    if Bloco_C.RegistroC500.Count > 0 then Write(txtFile, WriteRegistroC500); // Prates
    if Bloco_C.RegistroC600.Count > 0 then Write(txtFile, WriteRegistroC600); // Prates
    if Bloco_C.RegistroC601.Count > 0 then Write(txtFile, WriteRegistroC601); // Prates
    if Bloco_C.RegistroC610.Count > 0 then Write(txtFile, WriteRegistroC610); // Prates
    if Bloco_C.RegistroC620.Count > 0 then Write(txtFile, WriteRegistroC620); // Prates
    if Bloco_C.RegistroC690.Count > 0 then Write(txtFile, WriteRegistroC690); // Prates
    if Bloco_C.RegistroC700.Count > 0 then Write(txtFile, WriteRegistroC700); // Prates
    if Bloco_C.RegistroC790.Count > 0 then Write(txtFile, WriteRegistroC790); // Prates
    if Bloco_C.RegistroC791.Count > 0 then Write(txtFile, WriteRegistroC791); // Prates
    Write(txtFile, WriteRegistroC990);

   /// BLOCO D
    Write(txtFile, WriteRegistroD001);
    if Bloco_D.RegistroD100.Count > 0 then Write(txtFile, WriteRegistroD100); // Prates
    if Bloco_D.RegistroD110.Count > 0 then Write(txtFile, WriteRegistroD110); // Prates
    if Bloco_D.RegistroD120.Count > 0 then Write(txtFile, WriteRegistroD120); // Prates
    if Bloco_D.RegistroD130.Count > 0 then Write(txtFile, WriteRegistroD130); // Prates
    if Bloco_D.RegistroD140.Count > 0 then Write(txtFile, WriteRegistroD140); // Prates
    if Bloco_D.RegistroD150.Count > 0 then Write(txtFile, WriteRegistroD150); // Prates
    if Bloco_D.RegistroD160.Count > 0 then Write(txtFile, WriteRegistroD160); // Prates
    if Bloco_D.RegistroD161.Count > 0 then Write(txtFile, WriteRegistroD161); // Prates
    if Bloco_D.RegistroD162.Count > 0 then Write(txtFile, WriteRegistroD162); // Prates
    if Bloco_D.RegistroD170.Count > 0 then Write(txtFile, WriteRegistroD170); // Prates
    if Bloco_D.RegistroD180.Count > 0 then Write(txtFile, WriteRegistroD180); // Prates
    if Bloco_D.RegistroD180.Count > 0 then Write(txtFile, WriteRegistroD180); // Prates
    if Bloco_D.RegistroD300.Count > 0 then Write(txtFile, WriteRegistroD300); // Prates
    if Bloco_D.RegistroD301.Count > 0 then Write(txtFile, WriteRegistroD301); // Prates
    if Bloco_D.RegistroD310.Count > 0 then Write(txtFile, WriteRegistroD310); // Prates
    if Bloco_D.RegistroD350.Count > 0 then Write(txtFile, WriteRegistroD350); // Prates
    if Bloco_D.RegistroD355.Count > 0 then Write(txtFile, WriteRegistroD355); // Prates
    if Bloco_D.RegistroD360.Count > 0 then Write(txtFile, WriteRegistroD360); // Prates
    if Bloco_D.RegistroD365.Count > 0 then Write(txtFile, WriteRegistroD365); // Prates
    if Bloco_D.RegistroD370.Count > 0 then Write(txtFile, WriteRegistroD370); // Prates
    if Bloco_D.RegistroD390.Count > 0 then Write(txtFile, WriteRegistroD390); // Prates
    if Bloco_D.RegistroD400.Count > 0 then Write(txtFile, WriteRegistroD400); // Prates
    if Bloco_D.RegistroD410.Count > 0 then Write(txtFile, WriteRegistroD410); // Prates
    if Bloco_D.RegistroD411.Count > 0 then Write(txtFile, WriteRegistroD411); // Prates
    if Bloco_D.RegistroD420.Count > 0 then Write(txtFile, WriteRegistroD420); // Prates
    if Bloco_D.RegistroD500.Count > 0 then Write(txtFile, WriteRegistroD500); // Prates
    Write(txtFile, WriteRegistroD990);

    /// BLOCO E
    Write(txtFile, WriteRegistroE001);
    Write(txtFile, WriteRegistroE100);
    Write(txtFile, WriteRegistroE110);
    if Bloco_E.RegistroE111.Count > 0 then Write(txtFile, WriteRegistroE111); // Prates
    if Bloco_E.RegistroE112.Count > 0 then Write(txtFile, WriteRegistroE112); // Prates
    if Bloco_E.RegistroE113.Count > 0 then Write(txtFile, WriteRegistroE113); // Prates
    if Bloco_E.RegistroE115.Count > 0 then Write(txtFile, WriteRegistroE115); // Prates
    if Bloco_E.RegistroE116.Count > 0 then Write(txtFile, WriteRegistroE116); // Prates
    if Bloco_E.RegistroE200.Count > 0 then Write(txtFile, WriteRegistroE200); // Prates
    if Bloco_E.RegistroE220.Count > 0 then Write(txtFile, WriteRegistroE220); // Prates
    if Bloco_E.RegistroE230.Count > 0 then Write(txtFile, WriteRegistroE230); // Prates
    if Bloco_E.RegistroE240.Count > 0 then Write(txtFile, WriteRegistroE240); // Prates
    if Bloco_E.RegistroE250.Count > 0 then Write(txtFile, WriteRegistroE250); // Prates
    if Bloco_E.RegistroE500.Count > 0 then Write(txtFile, WriteRegistroE500); // Dante
    if Bloco_E.RegistroE510.Count > 0 then Write(txtFile, WriteRegistroE510); // Dante
    if Bloco_E.RegistroE520.Count > 0 then Write(txtFile, WriteRegistroE520); // Dante
    if Bloco_E.RegistroE530.Count > 0 then Write(txtFile, WriteRegistroE530); // Dante
    Write(txtFile, WriteRegistroE990);

    /// BLOCO H
    Write(txtFile, WriteRegistroH001);
    if Bloco_H.RegistroH005.Count > 0 then Write(txtFile, WriteRegistroH005);
    Write(txtFile, WriteRegistroH990);

    /// BLOCO 1
    Write(txtFile, WriteRegistro1001);
    if Bloco_1.Registro1100.Count > 0 then  Write(txtFile, WriteRegistro1100);
    if Bloco_1.Registro1105.Count > 0 then  Write(txtFile, WriteRegistro1105);
    if Bloco_1.Registro1110.Count > 0 then  Write(txtFile, WriteRegistro1110);
    if Bloco_1.Registro1200.Count > 0 then  Write(txtFile, WriteRegistro1200);
    if Bloco_1.Registro1210.Count > 0 then  Write(txtFile, WriteRegistro1210);
    if Bloco_1.Registro1300.Count > 0 then  Write(txtFile, WriteRegistro1300);
    if Bloco_1.Registro1350.Count > 0 then  Write(txtFile, WriteRegistro1350);
    if Bloco_1.Registro1500.Count > 0 then  Write(txtFile, WriteRegistro1500);
    if Bloco_1.Registro1510.Count > 0 then  Write(txtFile, WriteRegistro1510);
    Write(txtFile, WriteRegistro1990);

    /// BLOCO 9
    Write(txtFile, WriteRegistro9001);
    Write(txtFile, WriteRegistro9900);
    Write(txtFile, WriteRegistro9990);
    Write(txtFile, WriteRegistro9999);
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

function TACBrSPEDFiscal.WriteRegistro0000: AnsiString;
begin
   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := '0000';
      QTD_REG_BLC := 1;
   end;
   Result := Bloco_0.WriteRegistro0000;
end;

function TACBrSPEDFiscal.WriteRegistro0001: AnsiString;
begin
   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := '0001';
      QTD_REG_BLC := 1;
   end;
   Result := Bloco_0.WriteRegistro0001;
end;

function TACBrSPEDFiscal.WriteRegistro0005: AnsiString;
begin
   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := '0005';
      QTD_REG_BLC := 1;
   end;
   Result := Bloco_0.WriteRegistro0005;
end;

function TACBrSPEDFiscal.WriteRegistro0015: AnsiString;
begin
   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := '0015';
      QTD_REG_BLC := Bloco_0.Registro0015.Count;
   end;
   Result := Bloco_0.WriteRegistro0015;
end;

function TACBrSPEDFiscal.WriteRegistro0100: AnsiString;
begin
   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := '0100';
      QTD_REG_BLC := 1;
   end;
   Result := Bloco_0.WriteRegistro0100;
end;

function TACBrSPEDFiscal.WriteRegistro0150: AnsiString;
begin
   Result := Bloco_0.WriteRegistro0150;

   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := '0150';
      QTD_REG_BLC := Bloco_0.Registro0150.Count;
   end;
   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := '0175';
      QTD_REG_BLC := Bloco_0.Registro0175Count;
   end;
end;

function TACBrSPEDFiscal.WriteRegistro0190: AnsiString;
begin
   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := '0190';
      QTD_REG_BLC := Bloco_0.Registro0190.Count;
   end;
   Result := Bloco_0.WriteRegistro0190;
end;

function TACBrSPEDFiscal.WriteRegistro0200: AnsiString;
begin
   Result := Bloco_0.WriteRegistro0200;

   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := '0200';
      QTD_REG_BLC := Bloco_0.Registro0200.Count;
   end;
   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := '0205';
      QTD_REG_BLC := Bloco_0.Registro0205Count;
   end;
   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := '0206';
      QTD_REG_BLC := Bloco_0.Registro0206Count;
   end;
   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := '0220';
      QTD_REG_BLC := Bloco_0.Registro0220Count;
   end;
end;

function TACBrSPEDFiscal.WriteRegistro0400: AnsiString;
begin
   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := '0400';
      QTD_REG_BLC := Bloco_0.Registro0400.Count;
   end;
   Result := Bloco_0.WriteRegistro0400;
end;

function TACBrSPEDFiscal.WriteRegistro0450: AnsiString;
begin
   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := '0450';
      QTD_REG_BLC := Bloco_0.Registro0450.Count;
   end;
   Result := Bloco_0.WriteRegistro0450;
end;

function TACBrSPEDFiscal.WriteRegistro0460: AnsiString;
begin
   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := '0460';
      QTD_REG_BLC := Bloco_0.Registro0460.Count;
   end;
   Result := Bloco_0.WriteRegistro0460;
end;

function TACBrSPEDFiscal.WriteRegistro0990: AnsiString;
begin
   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := '0990';
      QTD_REG_BLC := 1;
   end;
   Result := Bloco_0.WriteRegistro0990;
end;

function TACBrSPEDFiscal.WriteRegistro1001: AnsiString;
begin
   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := '1001';
      QTD_REG_BLC := 1;
   end;
   Result := Bloco_1.WriteRegistro1001;
end;

function TACBrSPEDFiscal.WriteRegistro1100: AnsiString;
begin
   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := '1100';
      QTD_REG_BLC := Bloco_1.Registro1100.Count;
   end;
   Result := Bloco_1.WriteRegistro1100;
end;

function TACBrSPEDFiscal.WriteRegistro1105: AnsiString;
begin
   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := '1105';
      QTD_REG_BLC := Bloco_1.Registro1105.Count;
   end;
   Result := Bloco_1.WriteRegistro1105;
end;

function TACBrSPEDFiscal.WriteRegistro1110: AnsiString;
begin
   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := '1110';
      QTD_REG_BLC := Bloco_1.Registro1110.Count;
   end;
   Result := Bloco_1.WriteRegistro1110;
end;

function TACBrSPEDFiscal.WriteRegistro1200: AnsiString;
begin
   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := '1200';
      QTD_REG_BLC := Bloco_1.Registro1200.Count;
   end;
   Result := Bloco_1.WriteRegistro1200;
end;

function TACBrSPEDFiscal.WriteRegistro1210: AnsiString;
begin
   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := '1210';
      QTD_REG_BLC := Bloco_1.Registro1210.Count;
   end;
   Result := Bloco_1.WriteRegistro1210;
end;

function TACBrSPEDFiscal.WriteRegistro1300: AnsiString;
begin
   Result := Bloco_1.WriteRegistro1300;

   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := '1300';
      QTD_REG_BLC := Bloco_1.Registro1300.Count;
   end;
   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := '1310';
      QTD_REG_BLC := Bloco_1.Registro1310Count;
   end;
   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := '1320';
      QTD_REG_BLC := Bloco_1.Registro1320Count;
   end;
end;

function TACBrSPEDFiscal.WriteRegistro1350: AnsiString;
begin
   Result := Bloco_1.WriteRegistro1350;

   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := '1350';
      QTD_REG_BLC  := Bloco_1.Registro1350.Count;
   end;
   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := '1360';
      QTD_REG_BLC := Bloco_1.Registro1360Count;
   end;
   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := '1370';
      QTD_REG_BLC := Bloco_1.Registro1370Count;
   end;
end;

function TACBrSPEDFiscal.WriteRegistro1400: AnsiString;
begin
   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := '1400';
      QTD_REG_BLC := Bloco_1.Registro1400.Count;
   end;
   Result := Bloco_1.WriteRegistro1400;
end;

function TACBrSPEDFiscal.WriteRegistro1500: AnsiString;
begin
   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := '1500';
      QTD_REG_BLC := Bloco_1.Registro1500.Count;
   end;
   Result := Bloco_1.WriteRegistro1500;
end;

function TACBrSPEDFiscal.WriteRegistro1510: AnsiString;
begin
   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := '1510';
      QTD_REG_BLC := Bloco_1.Registro1510.Count;
   end;
   Result := Bloco_1.WriteRegistro1510;
end;

function TACBrSPEDFiscal.WriteRegistro1990: AnsiString;
begin
   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := '1990';
      QTD_REG_BLC := 1;
   end;
   Result := Bloco_1.WriteRegistro1990;
end;

function TACBrSPEDFiscal.WriteRegistroC001: AnsiString;
begin
   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := 'C001';
      QTD_REG_BLC := 1;
   end;
   Result := Bloco_C.WriteRegistroC001;
end;

function TACBrSPEDFiscal.WriteRegistroC100: AnsiString;
begin
   Result := Bloco_C.WriteRegistroC100;

   with Bloco_9.Registro9900 do
   begin
      with New do
      begin
         REG_BLC := 'C100';
         QTD_REG_BLC := Bloco_C.RegistroC100.Count;
      end;
      with New do
      begin
         REG_BLC := 'C110';
         QTD_REG_BLC := Bloco_C.RegistroC110Count;
      end;
      with New do
      begin
         REG_BLC := 'C111';
         QTD_REG_BLC := Bloco_C.RegistroC111Count;
      end;
      with New do
      begin
         REG_BLC := 'C112';
         QTD_REG_BLC := Bloco_C.RegistroC112Count;
      end;
      with New do
      begin
         REG_BLC := 'C113';
         QTD_REG_BLC := Bloco_C.RegistroC113Count;
      end;
      with New do
      begin
         REG_BLC := 'C114';
         QTD_REG_BLC := Bloco_C.RegistroC114Count;
      end;
      with New do
      begin
         REG_BLC := 'C115';
         QTD_REG_BLC := Bloco_C.RegistroC115Count;
      end;
      with New do
      begin
         REG_BLC := 'C120';
         QTD_REG_BLC := Bloco_C.RegistroC120Count;
      end;
      with New do
      begin
         REG_BLC := 'C130';
         QTD_REG_BLC := Bloco_C.RegistroC130Count;
      end;
      with New do
      begin
         REG_BLC := 'C140';
         QTD_REG_BLC := Bloco_C.RegistroC140Count;   {Márcio Lopes 30Nov2009}
      end;
      with New do
      begin
         REG_BLC := 'C141';
         QTD_REG_BLC := Bloco_C.RegistroC141Count;  {Márcio Lopes 30Nov2009}
      end;
      with New do
      begin
         REG_BLC := 'C160';
         QTD_REG_BLC := Bloco_C.RegistroC160Count;
      end;
      with New do
      begin
         REG_BLC := 'C165';
         QTD_REG_BLC := Bloco_C.RegistroC165Count;
      end;
      with New do
      begin
         REG_BLC := 'C170';
         QTD_REG_BLC := Bloco_C.RegistroC170Count;
      end;
      with New do
      begin
         REG_BLC := 'C171';
         QTD_REG_BLC := Bloco_C.RegistroC171Count;
      end;
      with New do
      begin
         REG_BLC := 'C172';
         QTD_REG_BLC := Bloco_C.RegistroC172Count;
      end;
      with New do
      begin
         REG_BLC := 'C173';
         QTD_REG_BLC := Bloco_C.RegistroC173Count;
      end;
      with New do
      begin
         REG_BLC := 'C174';
         QTD_REG_BLC := Bloco_C.RegistroC174Count;
      end;
      with New do
      begin
         REG_BLC := 'C175';
         QTD_REG_BLC := Bloco_C.RegistroC175Count;
      end;
      with New do
      begin
         REG_BLC := 'C176';
         QTD_REG_BLC := Bloco_C.RegistroC176Count;
      end;
      with New do
      begin
         REG_BLC := 'C177';
         QTD_REG_BLC := Bloco_C.RegistroC177Count;
      end;
      with New do
      begin
         REG_BLC := 'C178';
         QTD_REG_BLC := Bloco_C.RegistroC178Count;
      end;
      with New do
      begin
         REG_BLC := 'C179';
         QTD_REG_BLC := Bloco_C.RegistroC179Count;
      end;
      with New do
      begin
         REG_BLC := 'C190';
         QTD_REG_BLC := Bloco_C.RegistroC190Count;
      end;
      with New do
      begin
         REG_BLC := 'C195';
         QTD_REG_BLC := Bloco_C.RegistroC195Count;
      end;
   end;
end;

function TACBrSPEDFiscal.WriteRegistroC197: AnsiString;
begin
   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := 'C197';
      QTD_REG_BLC := Bloco_C.RegistroC197.Count;
   end;
   Result := Bloco_C.WriteRegistroC197;
end;

function TACBrSPEDFiscal.WriteRegistroC300: AnsiString;
begin
   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := 'C300';
      QTD_REG_BLC := Bloco_C.RegistroC300.Count;
   end;
   Result := Bloco_C.WriteRegistroC300;
end;

function TACBrSPEDFiscal.WriteRegistroC310: AnsiString;
begin
   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := 'C310';
      QTD_REG_BLC := Bloco_C.RegistroC310.Count;
   end;
   Result := Bloco_C.WriteRegistroC310;
end;

function TACBrSPEDFiscal.WriteRegistroC320: AnsiString;
begin
   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := 'C320';
      QTD_REG_BLC := Bloco_C.RegistroC320.Count;
   end;
   Result := Bloco_C.WriteRegistroC320;
end;

function TACBrSPEDFiscal.WriteRegistroC321: AnsiString;
begin
   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := 'C321';
      QTD_REG_BLC := Bloco_C.RegistroC321.Count;
   end;
   Result := Bloco_C.WriteRegistroC321;
end;

function TACBrSPEDFiscal.WriteRegistroC350: AnsiString;
begin
   Result := Bloco_C.WriteRegistroC350;

   with Bloco_9.Registro9900 do
   begin
      with New do
      begin
         REG_BLC := 'C350';
         QTD_REG_BLC := Bloco_C.RegistroC350.Count;
      end;
      with New do
      begin
         REG_BLC := 'C370';
         QTD_REG_BLC := Bloco_C.RegistroC370Count;
      end;
      with New do
      begin
         REG_BLC := 'C390';
         QTD_REG_BLC := Bloco_C.RegistroC390Count;
      end;
   end;
end;

function TACBrSPEDFiscal.WriteRegistroC400: AnsiString;
begin
   Result := Bloco_C.WriteRegistroC400;

   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := 'C400';
      QTD_REG_BLC  := Bloco_C.RegistroC400.Count;
   end;
   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := 'C405';
      QTD_REG_BLC  := Bloco_C.RegistroC405Count;
   end;
   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := 'C410';
      QTD_REG_BLC  := Bloco_C.RegistroC410Count;
   end;
   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := 'C420';
      QTD_REG_BLC  := Bloco_C.RegistroC420Count;
   end;
   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := 'C425';
      QTD_REG_BLC  := Bloco_C.RegistroC425Count;
   end;
   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := 'C460';
      QTD_REG_BLC  := Bloco_C.RegistroC460Count;
   end;
   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := 'C470';
      QTD_REG_BLC  := Bloco_C.RegistroC470Count;
   end;
   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := 'C490';
      QTD_REG_BLC  := Bloco_C.RegistroC490Count;
   end;
end;

function TACBrSPEDFiscal.WriteRegistroC495: AnsiString;
begin
   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := 'C495';
      QTD_REG_BLC  := Bloco_C.RegistroC495.Count;
   end;
   Result := Bloco_C.WriteRegistroC495;
end;

function TACBrSPEDFiscal.WriteRegistroC500: AnsiString;
begin
   Result := Bloco_C.WriteRegistroC500;

   with Bloco_9.Registro9900 do
   begin
      with New do
      begin
         REG_BLC := 'C500';
         QTD_REG_BLC := Bloco_C.RegistroC500.Count;
      end;
      with New do
      begin
         REG_BLC := 'C510';
         QTD_REG_BLC := Bloco_C.RegistroC510Count;
      end;
      with New do
      begin
         REG_BLC := 'C590';
         QTD_REG_BLC := Bloco_C.RegistroC590Count;
      end;
   end;

end;

function TACBrSPEDFiscal.WriteRegistroC600: AnsiString;
begin
   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := 'C600';
      QTD_REG_BLC  := Bloco_C.RegistroC600.Count;
   end;
   Result := Bloco_C.WriteRegistroC600;
end;

function TACBrSPEDFiscal.WriteRegistroC601: AnsiString;
begin
   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := 'C601';
      QTD_REG_BLC  := Bloco_C.RegistroC601.Count;
   end;
   Result := Bloco_C.WriteRegistroC601;
end;

function TACBrSPEDFiscal.WriteRegistroC610: AnsiString;
begin
   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := 'C610';
      QTD_REG_BLC  := Bloco_C.RegistroC610.Count;
   end;
   Result := Bloco_C.WriteRegistroC610;
end;

function TACBrSPEDFiscal.WriteRegistroC620: AnsiString;
begin
   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := 'C620';
      QTD_REG_BLC  := Bloco_C.RegistroC620.Count;
   end;
   Result := Bloco_C.WriteRegistroC620;
end;

function TACBrSPEDFiscal.WriteRegistroC690: AnsiString;
begin
   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := 'C690';
      QTD_REG_BLC  := Bloco_C.RegistroC690.Count;
   end;
   Result := Bloco_C.WriteRegistroC690;
end;

function TACBrSPEDFiscal.WriteRegistroC700: AnsiString;
begin
   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := 'C700';
      QTD_REG_BLC  := Bloco_C.RegistroC700.Count;
   end;
   Result := Bloco_C.WriteRegistroC700;
end;

function TACBrSPEDFiscal.WriteRegistroC790: AnsiString;
begin
   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := 'C790';
      QTD_REG_BLC  := Bloco_C.RegistroC790.Count;
   end;
   Result := Bloco_C.WriteRegistroC790;
end;

function TACBrSPEDFiscal.WriteRegistroC791: AnsiString;
begin
   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := 'C791';
      QTD_REG_BLC  := Bloco_C.RegistroC791.Count;
   end;
   Result := Bloco_C.WriteRegistroC791;
end;

function TACBrSPEDFiscal.WriteRegistroC990: AnsiString;
begin
   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := 'C990';
      QTD_REG_BLC := 1;
   end;
   Result := Bloco_C.WriteRegistroC990;
end;

function TACBrSPEDFiscal.WriteRegistroD001: AnsiString;
begin
   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := 'D001';
      QTD_REG_BLC := 1;
   end;
   Result := Bloco_D.WriteRegistroD001;
end;

function TACBrSPEDFiscal.WriteRegistroD100: AnsiString;
begin
   Result := Bloco_D.WriteRegistroD100;

   with Bloco_9.Registro9900 do
   begin
      with New do
      begin
         REG_BLC := 'D100';
         QTD_REG_BLC := Bloco_D.RegistroD100.Count;
      end;
      with New do
      begin
         REG_BLC := 'D190';
         QTD_REG_BLC := Bloco_D.RegistroD190Count;
      end;
   end;
end;

function TACBrSPEDFiscal.WriteRegistroD110: AnsiString;
begin
   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := 'D110';
      QTD_REG_BLC  := Bloco_D.RegistroD110.Count;
   end;
   Result := Bloco_D.WriteRegistroD110;
end;

function TACBrSPEDFiscal.WriteRegistroD120: AnsiString;
begin
   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := 'D120';
      QTD_REG_BLC  := Bloco_D.RegistroD120.Count;
   end;
   Result := Bloco_D.WriteRegistroD120;
end;

function TACBrSPEDFiscal.WriteRegistroD130: AnsiString;
begin
   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := 'D130';
      QTD_REG_BLC  := Bloco_D.RegistroD130.Count;
   end;
   Result := Bloco_D.WriteRegistroD130;
end;

function TACBrSPEDFiscal.WriteRegistroD140: AnsiString;
begin
   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := 'D140';
      QTD_REG_BLC  := Bloco_D.RegistroD140.Count;
   end;
   Result := Bloco_D.WriteRegistroD140;
end;

function TACBrSPEDFiscal.WriteRegistroD150: AnsiString;
begin
   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := 'D150';
      QTD_REG_BLC  := Bloco_D.RegistroD150.Count;
   end;
   Result := Bloco_D.WriteRegistroD150;
end;

function TACBrSPEDFiscal.WriteRegistroD160: AnsiString;
begin
   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := 'D160';
      QTD_REG_BLC  := Bloco_D.RegistroD160.Count;
   end;
   Result := Bloco_D.WriteRegistroD160;
end;

function TACBrSPEDFiscal.WriteRegistroD161: AnsiString;
begin
   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := 'D161';
      QTD_REG_BLC  := Bloco_D.RegistroD161.Count;
   end;
   Result := Bloco_D.WriteRegistroD161;
end;

function TACBrSPEDFiscal.WriteRegistroD162: AnsiString;
begin
   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := 'D162';
      QTD_REG_BLC  := Bloco_D.RegistroD162.Count;
   end;
   Result := Bloco_D.WriteRegistroD162;

end;

function TACBrSPEDFiscal.WriteRegistroD165: AnsiString;
begin
   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := 'D165';
      QTD_REG_BLC  := Bloco_D.RegistroD365.Count;
   end;
   Result := Bloco_D.WriteRegistroD365;

end;

function TACBrSPEDFiscal.WriteRegistroD170: AnsiString;
begin
   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := 'D170';
      QTD_REG_BLC  := Bloco_D.RegistroD170.Count;
   end;
   Result := Bloco_D.WriteRegistroD170;
end;

function TACBrSPEDFiscal.WriteRegistroD180: AnsiString;
begin
   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := 'D180';
      QTD_REG_BLC  := Bloco_D.RegistroD180.Count;
   end;
   Result := Bloco_D.WriteRegistroD180;
end;

function TACBrSPEDFiscal.WriteRegistroD300: AnsiString;
begin
   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := 'D300';
      QTD_REG_BLC  := Bloco_D.RegistroD300.Count;
   end;
   Result := Bloco_D.WriteRegistroD300;
end;

function TACBrSPEDFiscal.WriteRegistroD301: AnsiString;
begin
   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := 'D301';
      QTD_REG_BLC  := Bloco_D.RegistroD301.Count;
   end;
   Result := Bloco_D.WriteRegistroD301;
end;

function TACBrSPEDFiscal.WriteRegistroD310: AnsiString;
begin
   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := 'D310';
      QTD_REG_BLC  := Bloco_D.RegistroD310.Count;
   end;
   Result := Bloco_D.WriteRegistroD310;
end;

function TACBrSPEDFiscal.WriteRegistroD350: AnsiString;
begin
   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := 'D350';
      QTD_REG_BLC  := Bloco_D.RegistroD350.Count;
   end;
   Result := Bloco_D.WriteRegistroD350;
end;

function TACBrSPEDFiscal.WriteRegistroD355: AnsiString;
begin
   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := 'D355';
      QTD_REG_BLC  := Bloco_D.RegistroD355.Count;
   end;
   Result := Bloco_D.WriteRegistroD355;
end;

function TACBrSPEDFiscal.WriteRegistroD360: AnsiString;
begin
   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := 'D360';
      QTD_REG_BLC  := Bloco_D.RegistroD360.Count;
   end;
   Result := Bloco_D.WriteRegistroD360;
end;

function TACBrSPEDFiscal.WriteRegistroD365: AnsiString;
begin
   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := 'D362';
      QTD_REG_BLC  := Bloco_D.RegistroD365.Count;
   end;
   Result := Bloco_D.WriteRegistroD365;

end;

function TACBrSPEDFiscal.WriteRegistroD370: AnsiString;
begin
   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := 'D370';
      QTD_REG_BLC  := Bloco_D.RegistroD370.Count;
   end;
   Result := Bloco_D.WriteRegistroD370;
end;

function TACBrSPEDFiscal.WriteRegistroD390: AnsiString;
begin
   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := 'D390';
      QTD_REG_BLC  := Bloco_D.RegistroD390.Count;
   end;
   Result := Bloco_D.WriteRegistroD390;
end;

function TACBrSPEDFiscal.WriteRegistroD400: AnsiString;
begin
   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := 'D400';
      QTD_REG_BLC  := Bloco_D.RegistroD400.Count;
   end;
   Result := Bloco_D.WriteRegistroD400;
end;

function TACBrSPEDFiscal.WriteRegistroD410: AnsiString;
begin
   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := 'D410';
      QTD_REG_BLC  := Bloco_D.RegistroD410.Count;
   end;
   Result := Bloco_D.WriteRegistroD410;
end;

function TACBrSPEDFiscal.WriteRegistroD411: AnsiString;
begin
   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := 'D411';
      QTD_REG_BLC  := Bloco_D.RegistroD411.Count;
   end;
   Result := Bloco_D.WriteRegistroD411;
end;

function TACBrSPEDFiscal.WriteRegistroD420: AnsiString;
begin
   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := 'D420';
      QTD_REG_BLC  := Bloco_D.RegistroD420.Count;
   end;
   Result := Bloco_D.WriteRegistroD420;
end;

function TACBrSPEDFiscal.WriteRegistroD500: AnsiString;
begin
   Result := Bloco_D.WriteRegistroD500;
   //
   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := 'D500';
      QTD_REG_BLC  := Bloco_D.RegistroD500.Count;
   end;
   with Bloco_9.Registro9900.New do
   begin
     REG_BLC := 'D590';
     QTD_REG_BLC := Bloco_D.RegistroD590Count;
   end;
end;

function TACBrSPEDFiscal.WriteRegistroD990: AnsiString;
begin
   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := 'D990';
      QTD_REG_BLC := 1;
   end;
   Result := Bloco_D.WriteRegistroD990;
end;

function TACBrSPEDFiscal.WriteRegistroE001: AnsiString;
begin
   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := 'E001';
      QTD_REG_BLC := 1;
   end;
   Result := Bloco_E.WriteRegistroE001;
end;

function TACBrSPEDFiscal.WriteRegistroE100: AnsiString;
begin
   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := 'E100';
      QTD_REG_BLC := 1;
   end;
   Result := Bloco_E.WriteRegistroE100;
end;

function TACBrSPEDFiscal.WriteRegistroE110: AnsiString;
begin
   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := 'E110';
      QTD_REG_BLC := 1;
   end;
   Result := Bloco_E.WriteRegistroE110;
end;

function TACBrSPEDFiscal.WriteRegistroE111: AnsiString;
begin
   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := 'E111';
      QTD_REG_BLC := Bloco_E.RegistroE111.Count;
   end;
   Result := Bloco_E.WriteRegistroE111;
end;

function TACBrSPEDFiscal.WriteRegistroE112: AnsiString;
begin
   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := 'E112';
      QTD_REG_BLC := Bloco_E.RegistroE112.Count;
   end;
   Result := Bloco_E.WriteRegistroE112;
end;

function TACBrSPEDFiscal.WriteRegistroE113: AnsiString;
begin
   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := 'E113';
      QTD_REG_BLC := Bloco_E.RegistroE113.Count;
   end;
   Result := Bloco_E.WriteRegistroE113;
end;

function TACBrSPEDFiscal.WriteRegistroE115: AnsiString;
begin
   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := 'E115';
      QTD_REG_BLC := Bloco_E.RegistroE115.Count;
   end;
   Result := Bloco_E.WriteRegistroE115;
end;

function TACBrSPEDFiscal.WriteRegistroE116: AnsiString;
begin
   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := 'E116';
      QTD_REG_BLC := Bloco_E.RegistroE116.Count;
   end;
   Result := Bloco_E.WriteRegistroE116;
end;

function TACBrSPEDFiscal.WriteRegistroE200: AnsiString;
begin
   Result := Bloco_E.WriteRegistroE200;

   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := 'E200';
      QTD_REG_BLC := Bloco_E.RegistroE200.Count;
   end;
   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := 'E210';
      QTD_REG_BLC := Bloco_E.RegistroE210Count;
   end;

end;

function TACBrSPEDFiscal.WriteRegistroE220: AnsiString;
begin
   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := 'E220';
      QTD_REG_BLC := Bloco_E.RegistroE220.Count;
   end;
   Result := Bloco_E.WriteRegistroE220;
end;

function TACBrSPEDFiscal.WriteRegistroE230: AnsiString;
begin
   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := 'E230';
      QTD_REG_BLC := Bloco_E.RegistroE230.Count;
   end;
   Result := Bloco_E.WriteRegistroE230;
end;

function TACBrSPEDFiscal.WriteRegistroE240: AnsiString;
begin
   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := 'E240';
      QTD_REG_BLC := Bloco_E.RegistroE240.Count;
   end;
   Result := Bloco_E.WriteRegistroE240;
end;

function TACBrSPEDFiscal.WriteRegistroE250: AnsiString;
begin
   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := 'E250';
      QTD_REG_BLC := Bloco_E.RegistroE250.Count;
   end;
   Result := Bloco_E.WriteRegistroE250;
end;

function TACBrSPEDFiscal.WriteRegistroE500: AnsiString;
begin
   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := 'E500';
      QTD_REG_BLC := Bloco_E.RegistroE500.Count;
   end;
   Result := Bloco_E.WriteRegistroE500;
end;

function TACBrSPEDFiscal.WriteRegistroE510: AnsiString;
begin
   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := 'E510';
      QTD_REG_BLC := Bloco_E.RegistroE510.Count;
   end;
   Result := Bloco_E.WriteRegistroE510;
end;

function TACBrSPEDFiscal.WriteRegistroE520: AnsiString;
begin
   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := 'E520';
      QTD_REG_BLC := Bloco_E.RegistroE520.Count;
   end;
   Result := Bloco_E.WriteRegistroE520;
end;

function TACBrSPEDFiscal.WriteRegistroE530: AnsiString;
begin
   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := 'E530';
      QTD_REG_BLC := Bloco_E.RegistroE530.Count;
   end;
   Result := Bloco_E.WriteRegistroE530;
end;

function TACBrSPEDFiscal.WriteRegistroE990: AnsiString;
begin
   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := 'E990';
      QTD_REG_BLC := 1;
   end;
   Result := Bloco_E.WriteRegistroE990;
end;

function TACBrSPEDFiscal.WriteRegistroH001: AnsiString;
begin
   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := 'H001';
      QTD_REG_BLC := 1;
   end;
   Result := Bloco_H.WriteRegistroH001;
end;

function TACBrSPEDFiscal.WriteRegistroH005: AnsiString;
begin
   Result := Bloco_H.WriteRegistroH005;

   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := 'H005';
      QTD_REG_BLC := Bloco_H.RegistroH005.Count;
   end;
   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := 'H010';
      QTD_REG_BLC := Bloco_H.RegistroH010Count;
   end;
end;

function TACBrSPEDFiscal.WriteRegistroH990: AnsiString;
begin
   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := 'H990';
      QTD_REG_BLC := 1;
   end;
   Result := Bloco_H.WriteRegistroH990;
end;

function TACBrSPEDFiscal.WriteRegistro9001: AnsiString;
begin
   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := '9001';
      QTD_REG_BLC := 1;
   end;
   Result := Bloco_9.WriteRegistro9001;
end;

function TACBrSPEDFiscal.WriteRegistro9900: AnsiString;
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

function TACBrSPEDFiscal.WriteRegistro9990: AnsiString;
begin
   Result := Bloco_9.WriteRegistro9990;
end;

function TACBrSPEDFiscal.WriteRegistro9999: AnsiString;
begin
   Bloco_9.Registro9999.QTD_LIN := Bloco_9.Registro9999.QTD_LIN + Bloco_0.Registro0990.QTD_LIN_0 +
                                                                  Bloco_1.Registro1990.QTD_LIN_1 +
                                                                  Bloco_C.RegistroC990.QTD_LIN_C +
                                                                  Bloco_D.RegistroD990.QTD_LIN_D +
                                                                  Bloco_E.RegistroE990.QTD_LIN_E +
                                                                  Bloco_H.RegistroH990.QTD_LIN_H +
                                                                  Bloco_9.Registro9990.QTD_LIN_9;
   Result := Bloco_9.WriteRegistro9999;
end;

function TACBrSPEDFiscal.GetAbout: String;
begin
   Result := 'ACBrSpedFiscal Ver: '+CACBrSpedFiscal_Versao;
end;

procedure TACBrSPEDFiscal.SetAbout(const Value: String);
begin
 {}
end;

end.
