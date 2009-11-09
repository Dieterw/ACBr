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
  ACBrBloco_0_Class, ACBrBloco_1_Class, ACBrBloco_9_Class, ACBrBloco_C_Class,
  ACBrBloco_D_Class, ACBrBloco_E_Class, ACBrBloco_H_Class;

type
  /// ACBrSpedFiscal - Sitema Publico de Escrituração Digital Fiscal
  TACBrSPEDFiscal = class(TACBrSPED)
  private
    FPath: string;       /// Path do arquivo a ser gerado
    FBloco_0: TBloco_0;
    FBloco_1: TBloco_1;
    FBloco_9: TBloco_9;
    FBloco_C: TBloco_C;
    FBloco_D: TBloco_D;
    FBloco_E: TBloco_E;
    FBloco_H: TBloco_H;
  protected
    procedure SetDT_FIN(const Value: TDateTime); override;
    procedure SetDT_INI(const Value: TDateTime); override;
    /// BLOCO 0
    function WriteRegistro0000: string;
    function WriteRegistro0001: string;
    function WriteRegistro0005: string;
    function WriteRegistro0015: string;
    function WriteRegistro0100: string;
    function WriteRegistro0150: string;
    function WriteRegistro0175: string;
    function WriteRegistro0190: string;
    function WriteRegistro0200: string;
    function WriteRegistro0205: string;
    function WriteRegistro0206: string;
    function WriteRegistro0220: string;
    function WriteRegistro0400: string;
    function WriteRegistro0450: string;
    function WriteRegistro0460: string;
    function WriteRegistro0990: string;
    /// BLOCO 1
    function WriteRegistro1001: string;
    function WriteRegistro1100: string;
    function WriteRegistro1105: string;
    function WriteRegistro1110: string;
    function WriteRegistro1200: string;
    function WriteRegistro1210: string;
    function WriteRegistro1300: string;
    function WriteRegistro1310: string;
    function WriteRegistro1320: string;
    function WriteRegistro1400: string;
    function WriteRegistro1500: string;
    function WriteRegistro1510: string;
    function WriteRegistro1990: string;
    /// BLOCO C
    function WriteRegistroC001: string;
    function WriteRegistroC100: string;
    function WriteRegistroC110: string;
    function WriteRegistroC111: string;
    function WriteRegistroC112: string;
    function WriteRegistroC113: string;
    function WriteRegistroC114: string;
    function WriteRegistroC115: string;
    function WriteRegistroC120: string;
    function WriteRegistroC130: string;
    function WriteRegistroC140: string;
    function WriteRegistroC141: string;
    function WriteRegistroC160: string;
    function WriteRegistroC165: string;
    function WriteRegistroC170: string;
    function WriteRegistroC171: string;
    function WriteRegistroC172: string;
    function WriteRegistroC173: string;
    function WriteRegistroC174: string;
    function WriteRegistroC175: string;
    function WriteRegistroC176: string;
    function WriteRegistroC177: string;
    function WriteRegistroC178: string;
    function WriteRegistroC179: string;
    function WriteRegistroC190: string;
    function WriteRegistroC195: string;
    function WriteRegistroC197: string;
    function WriteRegistroC300: string;
    function WriteRegistroC310: string;
    function WriteRegistroC320: string;
    function WriteRegistroC321: string;
    function WriteRegistroC350: string;
    function WriteRegistroC370: string;
    function WriteRegistroC390: string;
    function WriteRegistroC400: string;
    function WriteRegistroC405: string;
    function WriteRegistroC410: string;
    function WriteRegistroC420: string;
    function WriteRegistroC425: string;
    function WriteRegistroC460: string;
    function WriteRegistroC470: string;
    function WriteRegistroC490: string;
    function WriteRegistroC495: string;
    function WriteRegistroC500: string;
    function WriteRegistroC510: string;
    function WriteRegistroC590: string;
    function WriteRegistroC600: string;
    function WriteRegistroC601: string;
    function WriteRegistroC610: string;
    function WriteRegistroC620: string;
    function WriteRegistroC690: string;
    function WriteRegistroC700: string;
    function WriteRegistroC790: string;
    function WriteRegistroC791: string;
    function WriteRegistroC990: string;
    /// BLOCO D
    function WriteRegistroD001: string;
    function WriteRegistroD100: string;
    function WriteRegistroD110: string;
    function WriteRegistroD120: string;
    function WriteRegistroD130: string;
    function WriteRegistroD140: string;
    function WriteRegistroD150: string;
    function WriteRegistroD160: string;
    function WriteRegistroD161: string;
    function WriteRegistroD170: string;
    function WriteRegistroD180: string;
    function WriteRegistroD190: string;
    function WriteRegistroD300: string;
    function WriteRegistroD301: string;
    function WriteRegistroD310: string;
    function WriteRegistroD350: string;
    function WriteRegistroD355: string;
    function WriteRegistroD360: string;
    function WriteRegistroD370: string;
    function WriteRegistroD390: string;
    function WriteRegistroD400: string;
    function WriteRegistroD410: string;
    function WriteRegistroD411: string;
    function WriteRegistroD420: string;
    function WriteRegistroD500: string;
    function WriteRegistroD990: string;
    /// BLOCO E
    function WriteRegistroE001: string;
    function WriteRegistroE100: string;
    function WriteRegistroE110: string;
    function WriteRegistroE111: string;
    function WriteRegistroE112: string;
    function WriteRegistroE113: string;
    function WriteRegistroE115: string;
    function WriteRegistroE116: string;
    function WriteRegistroE200: string;
    function WriteRegistroE210: string;
    function WriteRegistroE220: string;
    function WriteRegistroE230: string;
    function WriteRegistroE240: string;
    function WriteRegistroE250: string;
    function WriteRegistroE500: string;
    function WriteRegistroE510: string;
    function WriteRegistroE520: string;
    function WriteRegistroE530: string;
    function WriteRegistroE990: string;
    /// BLOCO H
    function WriteRegistroH001: string;
    function WriteRegistroH005: string;
    function WriteRegistroH010: string;
    function WriteRegistroH990: string;
    /// BLOCO 9
    function WriteRegistro9001: string;
    function WriteRegistro9900: string;
    function WriteRegistro9990: string;
    function WriteRegistro9999: string;
  public
    constructor Create(AOwner: TComponent); override; /// Create
    destructor Destroy; override; /// Destroy
    function SaveFileTXT(Arquivo: string): Boolean; /// Método que escreve o arquivo texto no caminho passado como parâmetro

    property Bloco_0: TBloco_0 read FBloco_0 write FBloco_0;
    property Bloco_1: TBloco_1 read FBloco_1 write FBloco_1;
    property Bloco_9: TBloco_9 read FBloco_9 write FBloco_9;
    property Bloco_C: TBloco_C read FBloco_C write FBloco_C;
    property Bloco_D: TBloco_D read FBloco_D write FBloco_D;
    property Bloco_E: TBloco_E read FBloco_E write FBloco_E;
    property Bloco_H: TBloco_H read FBloco_H write FBloco_H;
  published
    property Path: string read FPath write FPath;
    property Delimitador;
    property OnError;
  end;

  procedure Register;

implementation

{$R ACBr_SPEDFiscal.dcr}

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

procedure TACBrSPEDFiscal.SetDT_INI(const Value: TDateTime);
begin
  inherited;
   if Assigned(FBloco_0) then
   begin
      FBloco_0.Registro0000.DT_INI := Value;
      FBloco_E.RegistroE100.DT_INI := Value;
   end;
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

function TACBrSPEDFiscal.SaveFileTXT(Arquivo: string): Boolean;
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
    Write(txtFile, WriteRegistro0150);
    Write(txtFile, WriteRegistro0175);
    if Bloco_0.Registro0190.Count > 0 then Write(txtFile, WriteRegistro0190);
    Write(txtFile, WriteRegistro0990);
    /// BLOCO C
    Write(txtFile, WriteRegistroC001);
    Write(txtFile, WriteRegistroC990);
    /// BLOCO D
    Write(txtFile, WriteRegistroD001);
    Write(txtFile, WriteRegistroD990);
    /// BLOCO E
    Write(txtFile, WriteRegistroE001);
    Write(txtFile, WriteRegistroE100);
    Write(txtFile, WriteRegistroE110);
    Write(txtFile, WriteRegistroE990);
    /// BLOCO H
    Write(txtFile, WriteRegistroH001);
    Write(txtFile, WriteRegistroH990);
    /// BLOCO 1
    Write(txtFile, WriteRegistro1001);
    Write(txtFile, WriteRegistro1990);
    /// BLOCO 9
    Write(txtFile, WriteRegistro9001);
    Write(txtFile, WriteRegistro9900);
    Write(txtFile, WriteRegistro9990);
    Write(txtFile, WriteRegistro9999);
    ///
    CloseFile(txtFile);
  except
    on E: Exception do
    begin
      CloseFile(txtFile);
      raise Exception.Create(E.Message);
    end;
  end;
end;

function TACBrSPEDFiscal.WriteRegistro0000: string;
begin
   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := '0000';
      QTD_REG_BLC := 1;
   end;
   Result := Bloco_0.WriteRegistro0000;
end;

function TACBrSPEDFiscal.WriteRegistro0001: string;
begin
   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := '0001';
      QTD_REG_BLC := 1;
   end;
   Result := Bloco_0.WriteRegistro0001;
end;

function TACBrSPEDFiscal.WriteRegistro0005: string;
begin
   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := '0005';
      QTD_REG_BLC := 1;
   end;
   Result := Bloco_0.WriteRegistro0005;
end;

function TACBrSPEDFiscal.WriteRegistro0015: string;
begin
   /// Verifica se tem informação no registro.
   if Bloco_0.Registro0015.Count > 0 then
   begin
      with Bloco_9.Registro9900.New do
      begin
         REG_BLC := '0015';
         QTD_REG_BLC := Bloco_0.Registro0015.Count;
      end;
      Result := Bloco_0.WriteRegistro0015;
   end;
end;

function TACBrSPEDFiscal.WriteRegistro0100: string;
begin
   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := '0100';
      QTD_REG_BLC := 1;
   end;
   Result := Bloco_0.WriteRegistro0100;
end;

function TACBrSPEDFiscal.WriteRegistro0150: string;
begin
   /// Verifica se tem informação no registro.
   if Bloco_0.Registro0150.Count > 0 then
   begin
      with Bloco_9.Registro9900.New do
      begin
         REG_BLC := '0150';
         QTD_REG_BLC := Bloco_0.Registro0150.Count;
      end;
      Result := Bloco_0.WriteRegistro0150;
   end;
end;

function TACBrSPEDFiscal.WriteRegistro0175: string;
begin
   /// Verifica se tem informação no registro.
   if Bloco_0.Registro0175.Count > 0 then
   begin
      with Bloco_9.Registro9900.New do
      begin
         REG_BLC := '0175';
         QTD_REG_BLC := Bloco_0.Registro0175.Count;
      end;
      Result := Bloco_0.WriteRegistro0175;
   end;
end;

function TACBrSPEDFiscal.WriteRegistro0190: string;
begin
   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := '0190';
      QTD_REG_BLC := 1;
   end;
   Result := Bloco_0.WriteRegistro0190;
end;

function TACBrSPEDFiscal.WriteRegistro0200: string;
begin
   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := '0200';
      QTD_REG_BLC := Bloco_0.Registro0200.Count;
   end;
   Result := Bloco_0.WriteRegistro0200;
end;

function TACBrSPEDFiscal.WriteRegistro0205: string;
begin
   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := '0205';
      QTD_REG_BLC := Bloco_0.Registro0205.Count;
   end;
   Result := Bloco_0.WriteRegistro0205;
end;

function TACBrSPEDFiscal.WriteRegistro0206: string;
begin
   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := '0206';
      QTD_REG_BLC := Bloco_0.Registro0206.Count;
   end;
   Result := Bloco_0.WriteRegistro0206;
end;

function TACBrSPEDFiscal.WriteRegistro0220: string;
begin
   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := '0220';
      QTD_REG_BLC := Bloco_0.Registro0220.Count;
   end;
   Result := Bloco_0.WriteRegistro0220;
end;

function TACBrSPEDFiscal.WriteRegistro0400: string;
begin
   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := '0400';
      QTD_REG_BLC := Bloco_0.Registro0400.Count;
   end;
   Result := Bloco_0.WriteRegistro0400;
end;

function TACBrSPEDFiscal.WriteRegistro0450: string;
begin
   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := '0450';
      QTD_REG_BLC := Bloco_0.Registro0450.Count;
   end;
   Result := Bloco_0.WriteRegistro0450;
end;

function TACBrSPEDFiscal.WriteRegistro0460: string;
begin
   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := '0460';
      QTD_REG_BLC := Bloco_0.Registro0460.Count;
   end;
   Result := Bloco_0.WriteRegistro0460;
end;

function TACBrSPEDFiscal.WriteRegistro0990: string;
begin
   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := '0990';
      QTD_REG_BLC := 1;
   end;
   Result := Bloco_0.WriteRegistro0990;
end;

function TACBrSPEDFiscal.WriteRegistro1001: string;
begin
   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := '1001';
      QTD_REG_BLC := 1;
   end;
   Result := Bloco_1.WriteRegistro1001;
end;

function TACBrSPEDFiscal.WriteRegistro1100: string;
begin
   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := '1100';
      QTD_REG_BLC := Bloco_1.Registro1100.Count;
   end;
   Result := Bloco_1.WriteRegistro1100;
end;

function TACBrSPEDFiscal.WriteRegistro1105: string;
begin
   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := '1105';
      QTD_REG_BLC := Bloco_1.Registro1105.Count;
   end;
   Result := Bloco_1.WriteRegistro1105;
end;

function TACBrSPEDFiscal.WriteRegistro1110: string;
begin
   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := '1110';
      QTD_REG_BLC := Bloco_1.Registro1110.Count;
   end;
   Result := Bloco_1.WriteRegistro1110;
end;

function TACBrSPEDFiscal.WriteRegistro1200: string;
begin
   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := '1200';
      QTD_REG_BLC := Bloco_1.Registro1200.Count;
   end;
   Result := Bloco_1.WriteRegistro1200;
end;

function TACBrSPEDFiscal.WriteRegistro1210: string;
begin
   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := '1210';
      QTD_REG_BLC := Bloco_1.Registro1210.Count;
   end;
   Result := Bloco_1.WriteRegistro1210;
end;

function TACBrSPEDFiscal.WriteRegistro1300: string;
begin
   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := '1300';
      QTD_REG_BLC := Bloco_1.Registro1300.Count;
   end;
   Result := Bloco_1.WriteRegistro1300;
end;

function TACBrSPEDFiscal.WriteRegistro1310: string;
begin
   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := '1310';
      QTD_REG_BLC := Bloco_1.Registro1310.Count;
   end;
   Result := Bloco_1.WriteRegistro1310;
end;

function TACBrSPEDFiscal.WriteRegistro1320: string;
begin
   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := '1320';
      QTD_REG_BLC := Bloco_1.Registro1320.Count;
   end;
   Result := Bloco_1.WriteRegistro1320;
end;

function TACBrSPEDFiscal.WriteRegistro1400: string;
begin
   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := '1400';
      QTD_REG_BLC := Bloco_1.Registro1400.Count;
   end;
   Result := Bloco_1.WriteRegistro1400;
end;

function TACBrSPEDFiscal.WriteRegistro1500: string;
begin
   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := '1500';
      QTD_REG_BLC := Bloco_1.Registro1500.Count;
   end;
   Result := Bloco_1.WriteRegistro1500;
end;

function TACBrSPEDFiscal.WriteRegistro1510: string;
begin
   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := '1510';
      QTD_REG_BLC := Bloco_1.Registro1510.Count;
   end;
   Result := Bloco_1.WriteRegistro1510;
end;

function TACBrSPEDFiscal.WriteRegistro1990: string;
begin
   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := '1990';
      QTD_REG_BLC := 1;
   end;
   Result := Bloco_1.WriteRegistro1990;
end;

function TACBrSPEDFiscal.WriteRegistroC001: string;
begin
   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := 'C001';
      QTD_REG_BLC := 1;
   end;
   Result := Bloco_C.WriteRegistroC001;
end;

function TACBrSPEDFiscal.WriteRegistroC100: string;
begin
   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := 'C100';
      QTD_REG_BLC := 1;
   end;
   Result := Bloco_C.WriteRegistroC100;
end;

function TACBrSPEDFiscal.WriteRegistroC110: string;
begin
   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := 'C110';
      QTD_REG_BLC := 1;
   end;
   Result := Bloco_C.WriteRegistroC110;
end;

function TACBrSPEDFiscal.WriteRegistroC111: string;
begin
   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := 'C111';
      QTD_REG_BLC := 1;
   end;
   Result := Bloco_C.WriteRegistroC111;
end;

function TACBrSPEDFiscal.WriteRegistroC112: string;
begin
   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := 'C112';
      QTD_REG_BLC := 1;
   end;
   Result := Bloco_C.WriteRegistroC112;
end;

function TACBrSPEDFiscal.WriteRegistroC113: string;
begin
   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := 'C113';
      QTD_REG_BLC := 1;
   end;
   Result := Bloco_C.WriteRegistroC113;
end;

function TACBrSPEDFiscal.WriteRegistroC114: string;
begin
   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := 'C114';
      QTD_REG_BLC := 1;
   end;
   Result := Bloco_C.WriteRegistroC114;
end;

function TACBrSPEDFiscal.WriteRegistroC115: string;
begin
   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := 'C115';
      QTD_REG_BLC := 1;
   end;
   Result := Bloco_C.WriteRegistroC115;
end;

function TACBrSPEDFiscal.WriteRegistroC120: string;
begin
   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := 'C120';
      QTD_REG_BLC := 1;
   end;
   Result := Bloco_C.WriteRegistroC120;
end;

function TACBrSPEDFiscal.WriteRegistroC130: string;
begin
   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := 'C130';
      QTD_REG_BLC := 1;
   end;
   Result := Bloco_C.WriteRegistroC130;
end;

function TACBrSPEDFiscal.WriteRegistroC140: string;
begin
   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := 'C140';
      QTD_REG_BLC := 1;
   end;
   Result := Bloco_C.WriteRegistroC140;
end;

function TACBrSPEDFiscal.WriteRegistroC141: string;
begin
   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := 'C141';
      QTD_REG_BLC := 1;
   end;
   Result := Bloco_C.WriteRegistroC141;
end;

function TACBrSPEDFiscal.WriteRegistroC160: string;
begin
   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := 'C160';
      QTD_REG_BLC := 1;
   end;
   Result := Bloco_C.WriteRegistroC160;
end;

function TACBrSPEDFiscal.WriteRegistroC165: string;
begin
   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := 'C165';
      QTD_REG_BLC := 1;
   end;
   Result := Bloco_C.WriteRegistroC165;
end;

function TACBrSPEDFiscal.WriteRegistroC170: string;
begin
   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := 'C170';
      QTD_REG_BLC := 1;
   end;
   Result := Bloco_C.WriteRegistroC170;
end;

function TACBrSPEDFiscal.WriteRegistroC171: string;
begin
   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := 'C171';
      QTD_REG_BLC := 1;
   end;
   Result := Bloco_C.WriteRegistroC171;
end;

function TACBrSPEDFiscal.WriteRegistroC172: string;
begin
   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := 'C172';
      QTD_REG_BLC := 1;
   end;
   Result := Bloco_C.WriteRegistroC172;
end;

function TACBrSPEDFiscal.WriteRegistroC173: string;
begin
   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := 'C173';
      QTD_REG_BLC := 1;
   end;
   Result := Bloco_C.WriteRegistroC173;
end;

function TACBrSPEDFiscal.WriteRegistroC174: string;
begin
   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := 'C174';
      QTD_REG_BLC := 1;
   end;
   Result := Bloco_C.WriteRegistroC174;
end;

function TACBrSPEDFiscal.WriteRegistroC175: string;
begin
   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := 'C175';
      QTD_REG_BLC := 1;
   end;
   Result := Bloco_C.WriteRegistroC175;
end;

function TACBrSPEDFiscal.WriteRegistroC176: string;
begin
   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := 'C176';
      QTD_REG_BLC := 1;
   end;
   Result := Bloco_C.WriteRegistroC176;
end;

function TACBrSPEDFiscal.WriteRegistroC177: string;
begin
   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := 'C177';
      QTD_REG_BLC := 1;
   end;
   Result := Bloco_C.WriteRegistroC177;
end;

function TACBrSPEDFiscal.WriteRegistroC178: string;
begin
   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := 'C178';
      QTD_REG_BLC := 1;
   end;
   Result := Bloco_C.WriteRegistroC178;
end;

function TACBrSPEDFiscal.WriteRegistroC179: string;
begin
   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := 'C179';
      QTD_REG_BLC := 1;
   end;
   Result := Bloco_C.WriteRegistroC179;
end;

function TACBrSPEDFiscal.WriteRegistroC190: string;
begin
   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := 'C190';
      QTD_REG_BLC := 1;
   end;
   Result := Bloco_C.WriteRegistroC190;
end;

function TACBrSPEDFiscal.WriteRegistroC195: string;
begin
   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := 'C195';
      QTD_REG_BLC := 1;
   end;
   Result := Bloco_C.WriteRegistroC195;
end;

function TACBrSPEDFiscal.WriteRegistroC197: string;
begin
   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := 'C197';
      QTD_REG_BLC := 1;
   end;
   Result := Bloco_C.WriteRegistroC197;
end;

function TACBrSPEDFiscal.WriteRegistroC300: string;
begin
   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := 'C300';
      QTD_REG_BLC := 1;
   end;
   Result := Bloco_C.WriteRegistroC300;
end;

function TACBrSPEDFiscal.WriteRegistroC310: string;
begin
   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := 'C310';
      QTD_REG_BLC := 1;
   end;
   Result := Bloco_C.WriteRegistroC310;
end;

function TACBrSPEDFiscal.WriteRegistroC320: string;
begin
   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := 'C320';
      QTD_REG_BLC := 1;
   end;
   Result := Bloco_C.WriteRegistroC320;
end;

function TACBrSPEDFiscal.WriteRegistroC321: string;
begin
   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := 'C321';
      QTD_REG_BLC := 1;
   end;
   Result := Bloco_C.WriteRegistroC321;
end;

function TACBrSPEDFiscal.WriteRegistroC350: string;
begin
   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := 'C350';
      QTD_REG_BLC := 1;
   end;
   Result := Bloco_C.WriteRegistroC350;
end;

function TACBrSPEDFiscal.WriteRegistroC370: string;
begin
   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := 'C370';
      QTD_REG_BLC := 1;
   end;
   Result := Bloco_C.WriteRegistroC370;
end;

function TACBrSPEDFiscal.WriteRegistroC390: string;
begin
   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := 'C390';
      QTD_REG_BLC := 1;
   end;
   Result := Bloco_C.WriteRegistroC390;
end;

function TACBrSPEDFiscal.WriteRegistroC400: string;
begin
   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := 'C400';
      QTD_REG_BLC := 1;
   end;
   Result := Bloco_C.WriteRegistroC400;
end;

function TACBrSPEDFiscal.WriteRegistroC405: string;
begin
   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := 'C405';
      QTD_REG_BLC := 1;
   end;
   Result := Bloco_C.WriteRegistroC405;
end;

function TACBrSPEDFiscal.WriteRegistroC410: string;
begin
   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := 'C410';
      QTD_REG_BLC := 1;
   end;
   Result := Bloco_C.WriteRegistroC410;
end;

function TACBrSPEDFiscal.WriteRegistroC420: string;
begin
   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := 'C420';
      QTD_REG_BLC := 1;
   end;
   Result := Bloco_C.WriteRegistroC420;
end;

function TACBrSPEDFiscal.WriteRegistroC425: string;
begin
   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := 'C425';
      QTD_REG_BLC := 1;
   end;
   Result := Bloco_C.WriteRegistroC425;
end;

function TACBrSPEDFiscal.WriteRegistroC460: string;
begin
   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := 'C460';
      QTD_REG_BLC := 1;
   end;
   Result := Bloco_C.WriteRegistroC460;
end;

function TACBrSPEDFiscal.WriteRegistroC470: string;
begin
   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := 'C470';
      QTD_REG_BLC := 1;
   end;
   Result := Bloco_C.WriteRegistroC470;
end;

function TACBrSPEDFiscal.WriteRegistroC490: string;
begin
   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := 'C490';
      QTD_REG_BLC := 1;
   end;
   Result := Bloco_C.WriteRegistroC490;
end;

function TACBrSPEDFiscal.WriteRegistroC495: string;
begin
   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := 'C495';
      QTD_REG_BLC := 1;
   end;
   Result := Bloco_C.WriteRegistroC495;
end;

function TACBrSPEDFiscal.WriteRegistroC500: string;
begin
   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := 'C500';
      QTD_REG_BLC := 1;
   end;
   Result := Bloco_C.WriteRegistroC500;
end;

function TACBrSPEDFiscal.WriteRegistroC510: string;
begin
   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := 'C510';
      QTD_REG_BLC := 1;
   end;
   Result := Bloco_C.WriteRegistroC510;
end;

function TACBrSPEDFiscal.WriteRegistroC590: string;
begin
   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := 'C590';
      QTD_REG_BLC := 1;
   end;
   Result := Bloco_C.WriteRegistroC590;
end;

function TACBrSPEDFiscal.WriteRegistroC600: string;
begin
   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := 'C600';
      QTD_REG_BLC := 1;
   end;
   Result := Bloco_C.WriteRegistroC600;
end;

function TACBrSPEDFiscal.WriteRegistroC601: string;
begin
   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := 'C601';
      QTD_REG_BLC := 1;
   end;
   Result := Bloco_C.WriteRegistroC601;
end;

function TACBrSPEDFiscal.WriteRegistroC610: string;
begin
   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := 'C610';
      QTD_REG_BLC := 1;
   end;
   Result := Bloco_C.WriteRegistroC610;
end;

function TACBrSPEDFiscal.WriteRegistroC620: string;
begin
   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := 'C620';
      QTD_REG_BLC := 1;
   end;
   Result := Bloco_C.WriteRegistroC620;
end;

function TACBrSPEDFiscal.WriteRegistroC690: string;
begin
   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := 'C690';
      QTD_REG_BLC := 1;
   end;
   Result := Bloco_C.WriteRegistroC690;
end;

function TACBrSPEDFiscal.WriteRegistroC700: string;
begin
   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := 'C700';
      QTD_REG_BLC := 1;
   end;
   Result := Bloco_C.WriteRegistroC700;
end;

function TACBrSPEDFiscal.WriteRegistroC790: string;
begin
   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := 'C790';
      QTD_REG_BLC := 1;
   end;
   Result := Bloco_C.WriteRegistroC790;
end;

function TACBrSPEDFiscal.WriteRegistroC791: string;
begin
   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := 'C791';
      QTD_REG_BLC := 1;
   end;
   Result := Bloco_C.WriteRegistroC791;
end;

function TACBrSPEDFiscal.WriteRegistroC990: string;
begin
   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := 'C990';
      QTD_REG_BLC := 1;
   end;
   Result := Bloco_C.WriteRegistroC990;
end;

function TACBrSPEDFiscal.WriteRegistroD001: string;
begin
   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := 'D001';
      QTD_REG_BLC := 1;
   end;
   Result := Bloco_D.WriteRegistroD001;
end;

function TACBrSPEDFiscal.WriteRegistroD100: string;
begin
   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := 'D100';
      QTD_REG_BLC := 1;
   end;
   Result := Bloco_D.WriteRegistroD100;
end;

function TACBrSPEDFiscal.WriteRegistroD110: string;
begin
   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := 'D110';
      QTD_REG_BLC := 1;
   end;
   Result := Bloco_D.WriteRegistroD110;
end;

function TACBrSPEDFiscal.WriteRegistroD120: string;
begin
   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := 'D120';
      QTD_REG_BLC := 1;
   end;
   Result := Bloco_D.WriteRegistroD120;
end;

function TACBrSPEDFiscal.WriteRegistroD130: string;
begin
   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := 'D130';
      QTD_REG_BLC := 1;
   end;
   Result := Bloco_D.WriteRegistroD130;
end;

function TACBrSPEDFiscal.WriteRegistroD140: string;
begin
   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := 'D140';
      QTD_REG_BLC := 1;
   end;
   Result := Bloco_D.WriteRegistroD140;
end;

function TACBrSPEDFiscal.WriteRegistroD150: string;
begin
   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := 'D150';
      QTD_REG_BLC := 1;
   end;
   Result := Bloco_D.WriteRegistroD150;
end;

function TACBrSPEDFiscal.WriteRegistroD160: string;
begin
   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := 'D160';
      QTD_REG_BLC := 1;
   end;
   Result := Bloco_D.WriteRegistroD160;
end;

function TACBrSPEDFiscal.WriteRegistroD161: string;
begin
   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := 'D161';
      QTD_REG_BLC := 1;
   end;
   Result := Bloco_D.WriteRegistroD161;
end;

function TACBrSPEDFiscal.WriteRegistroD170: string;
begin
   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := 'D170';
      QTD_REG_BLC := 1;
   end;
   Result := Bloco_D.WriteRegistroD170;
end;

function TACBrSPEDFiscal.WriteRegistroD180: string;
begin
   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := 'D180';
      QTD_REG_BLC := 1;
   end;
   Result := Bloco_D.WriteRegistroD180;
end;

function TACBrSPEDFiscal.WriteRegistroD190: string;
begin
   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := 'D190';
      QTD_REG_BLC := 1;
   end;
   Result := Bloco_D.WriteRegistroD190;
end;

function TACBrSPEDFiscal.WriteRegistroD300: string;
begin
   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := 'D300';
      QTD_REG_BLC := 1;
   end;
   Result := Bloco_D.WriteRegistroD300;
end;

function TACBrSPEDFiscal.WriteRegistroD301: string;
begin
   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := 'D301';
      QTD_REG_BLC := 1;
   end;
   Result := Bloco_D.WriteRegistroD301;
end;

function TACBrSPEDFiscal.WriteRegistroD310: string;
begin
   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := 'D310';
      QTD_REG_BLC := 1;
   end;
   Result := Bloco_D.WriteRegistroD310;
end;

function TACBrSPEDFiscal.WriteRegistroD350: string;
begin
   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := 'D350';
      QTD_REG_BLC := 1;
   end;
   Result := Bloco_D.WriteRegistroD350;
end;

function TACBrSPEDFiscal.WriteRegistroD355: string;
begin
   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := 'D355';
      QTD_REG_BLC := 1;
   end;
   Result := Bloco_D.WriteRegistroD355;
end;

function TACBrSPEDFiscal.WriteRegistroD360: string;
begin
   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := 'D360';
      QTD_REG_BLC := 1;
   end;
   Result := Bloco_D.WriteRegistroD360;
end;

function TACBrSPEDFiscal.WriteRegistroD370: string;
begin
   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := 'D370';
      QTD_REG_BLC := 1;
   end;
   Result := Bloco_D.WriteRegistroD370;
end;

function TACBrSPEDFiscal.WriteRegistroD390: string;
begin
   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := 'D390';
      QTD_REG_BLC := 1;
   end;
   Result := Bloco_D.WriteRegistroD390;
end;

function TACBrSPEDFiscal.WriteRegistroD400: string;
begin
   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := 'D400';
      QTD_REG_BLC := 1;
   end;
   Result := Bloco_D.WriteRegistroD400;
end;

function TACBrSPEDFiscal.WriteRegistroD410: string;
begin
   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := 'D410';
      QTD_REG_BLC := 1;
   end;
   Result := Bloco_D.WriteRegistroD410;
end;

function TACBrSPEDFiscal.WriteRegistroD411: string;
begin
   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := 'D411';
      QTD_REG_BLC := 1;
   end;
   Result := Bloco_D.WriteRegistroD411;
end;

function TACBrSPEDFiscal.WriteRegistroD420: string;
begin
   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := 'D420';
      QTD_REG_BLC := 1;
   end;
   Result := Bloco_D.WriteRegistroD420;
end;

function TACBrSPEDFiscal.WriteRegistroD500: string;
begin
   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := 'D500';
      QTD_REG_BLC := 1;
   end;
   Result := Bloco_D.WriteRegistroD500;
end;

function TACBrSPEDFiscal.WriteRegistroD990: string;
begin
   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := 'D990';
      QTD_REG_BLC := 1;
   end;
   Result := Bloco_D.WriteRegistroD990;
end;

function TACBrSPEDFiscal.WriteRegistroE001: string;
begin
   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := 'E001';
      QTD_REG_BLC := 1;
   end;
   Result := Bloco_E.WriteRegistroE001;
end;

function TACBrSPEDFiscal.WriteRegistroE100: string;
begin
   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := 'E100';
      QTD_REG_BLC := 1;
   end;
   Result := Bloco_E.WriteRegistroE100;
end;

function TACBrSPEDFiscal.WriteRegistroE110: string;
begin
   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := 'E110';
      QTD_REG_BLC := 1;
   end;
   Result := Bloco_E.WriteRegistroE110;
end;

function TACBrSPEDFiscal.WriteRegistroE111: string;
begin
   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := 'E111';
      QTD_REG_BLC := 1;
   end;
   Result := Bloco_E.WriteRegistroE111;
end;

function TACBrSPEDFiscal.WriteRegistroE112: string;
begin
   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := 'E112';
      QTD_REG_BLC := 1;
   end;
   Result := Bloco_E.WriteRegistroE112;
end;

function TACBrSPEDFiscal.WriteRegistroE113: string;
begin
   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := 'E113';
      QTD_REG_BLC := 1;
   end;
   Result := Bloco_E.WriteRegistroE113;
end;

function TACBrSPEDFiscal.WriteRegistroE115: string;
begin
   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := 'E115';
      QTD_REG_BLC := 1;
   end;
   Result := Bloco_E.WriteRegistroE115;
end;

function TACBrSPEDFiscal.WriteRegistroE116: string;
begin
   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := 'E116';
      QTD_REG_BLC := 1;
   end;
   Result := Bloco_E.WriteRegistroE116;
end;

function TACBrSPEDFiscal.WriteRegistroE200: string;
begin
   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := 'E200';
      QTD_REG_BLC := 1;
   end;
   Result := Bloco_E.WriteRegistroE200;
end;

function TACBrSPEDFiscal.WriteRegistroE210: string;
begin
   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := 'E210';
      QTD_REG_BLC := 1;
   end;
   Result := Bloco_E.WriteRegistroE210;
end;

function TACBrSPEDFiscal.WriteRegistroE220: string;
begin
   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := 'E220';
      QTD_REG_BLC := 1;
   end;
   Result := Bloco_E.WriteRegistroE220;
end;

function TACBrSPEDFiscal.WriteRegistroE230: string;
begin
   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := 'E230';
      QTD_REG_BLC := 1;
   end;
   Result := Bloco_E.WriteRegistroE230;
end;

function TACBrSPEDFiscal.WriteRegistroE240: string;
begin
   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := 'E240';
      QTD_REG_BLC := 1;
   end;
   Result := Bloco_E.WriteRegistroE240;
end;

function TACBrSPEDFiscal.WriteRegistroE250: string;
begin
   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := 'E250';
      QTD_REG_BLC := 1;
   end;
   Result := Bloco_E.WriteRegistroE250;
end;

function TACBrSPEDFiscal.WriteRegistroE500: string;
begin
   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := 'E500';
      QTD_REG_BLC := 1;
   end;
   Result := Bloco_E.WriteRegistroE500;
end;

function TACBrSPEDFiscal.WriteRegistroE510: string;
begin
   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := 'E510';
      QTD_REG_BLC := 1;
   end;
   Result := Bloco_E.WriteRegistroE510;
end;

function TACBrSPEDFiscal.WriteRegistroE520: string;
begin
   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := 'E520';
      QTD_REG_BLC := 1;
   end;
   Result := Bloco_E.WriteRegistroE520;
end;

function TACBrSPEDFiscal.WriteRegistroE530: string;
begin
   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := 'E530';
      QTD_REG_BLC := 1;
   end;
   Result := Bloco_E.WriteRegistroE530;
end;

function TACBrSPEDFiscal.WriteRegistroE990: string;
begin
   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := 'E990';
      QTD_REG_BLC := 1;
   end;
   Result := Bloco_E.WriteRegistroE990;
end;

function TACBrSPEDFiscal.WriteRegistroH001: string;
begin
   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := 'H001';
      QTD_REG_BLC := 1;
   end;
   Result := Bloco_H.WriteRegistroH001;
end;

function TACBrSPEDFiscal.WriteRegistroH005: string;
begin
   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := 'H005';
      QTD_REG_BLC := 1;
   end;
   Result := Bloco_H.WriteRegistroH005;
end;

function TACBrSPEDFiscal.WriteRegistroH010: string;
begin
   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := 'H010';
      QTD_REG_BLC := 1;
   end;
   Result := Bloco_H.WriteRegistroH010;
end;

function TACBrSPEDFiscal.WriteRegistroH990: string;
begin
   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := 'H990';
      QTD_REG_BLC := 1;
   end;
   Result := Bloco_H.WriteRegistroH990;
end;

function TACBrSPEDFiscal.WriteRegistro9001: string;
begin
   with Bloco_9.Registro9900.New do
   begin
      REG_BLC := '9001';
      QTD_REG_BLC := 1;
   end;
   Result := Bloco_9.WriteRegistro9001;
end;

function TACBrSPEDFiscal.WriteRegistro9900: string;
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

function TACBrSPEDFiscal.WriteRegistro9990: string;
begin
   Result := Bloco_9.WriteRegistro9990;
end;

function TACBrSPEDFiscal.WriteRegistro9999: string;
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

end.
