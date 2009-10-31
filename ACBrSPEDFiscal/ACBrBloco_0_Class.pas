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

unit ACBrBloco_0_Class;

interface

uses SysUtils, Classes, DateUtils, ACBrSped, ACBrBloco_0;

type
  /// TBLOCO_0 -
  TBloco_0 = class(TACBrSPED)
  private
    FRegistro0000: TRegistro0000;      /// BLOCO 0 - Registro0000
    FRegistro0001: TRegistro0001;      /// BLOCO 0 - Registro0001
    FRegistro0005: TRegistro0005;      /// BLOCO 0 - Registro0005
    FRegistro0015: TRegistro0015;      /// BLOCO 0 - Registro0015
    FRegistro0100: TRegistro0100;      /// BLOCO 0 - Registro0100
    FRegistro0150: TRegistro0150List;  /// BLOCO 0 - Lista de Registro0150
    FRegistro0175: TRegistro0175List;  /// BLOCO 0 - Lista de Registro0175
    FRegistro0190: TRegistro0190List;  /// BLOCO 0 - Lista de Registro0190
    FRegistro0200: TRegistro0200List;  /// BLOCO 0 - Lista de Registro0200
    FRegistro0205: TRegistro0205List;  /// BLOCO 0 - Lista de Registro0205
    FRegistro0206: TRegistro0206List;  /// BLOCO 0 - Lista de Registro0206
    FRegistro0220: TRegistro0220List;  /// BLOCO 0 - Lista de Registro0220
    FRegistro0400: TRegistro0400List;  /// BLOCO 0 - Lista de Registro0400
    FRegistro0450: TRegistro0450List;  /// BLOCO 0 - Lista de Registro0450
    FRegistro0460: TRegistro0460List;  /// BLOCO 0 - Lista de Registro0460
    FRegistro0990: TRegistro0990;      /// BLOCO 0 - Registro0990
  protected
  public
    constructor Create(AOwner: TComponent); override; /// Create
    destructor Destroy; override; /// Destroy

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

    property Registro0000: TRegistro0000 read FRegistro0000 write FRegistro0000;
    property Registro0001: TRegistro0001 read FRegistro0001 write FRegistro0001;
    property Registro0005: TRegistro0005 read FRegistro0005 write FRegistro0005;
    property Registro0015: TRegistro0015 read FRegistro0015 write FRegistro0015;
    property Registro0100: TRegistro0100 read FRegistro0100 write FRegistro0100;
    property Registro0150: TRegistro0150List read FRegistro0150 write FRegistro0150;
    property Registro0175: TRegistro0175List read FRegistro0175 write FRegistro0175;
    property Registro0190: TRegistro0190List read FRegistro0190 write FRegistro0190;
    property Registro0200: TRegistro0200List read FRegistro0200 write FRegistro0200;
    property Registro0205: TRegistro0205List read FRegistro0205 write FRegistro0205;
    property Registro0206: TRegistro0206List read FRegistro0206 write FRegistro0206;
    property Registro0220: TRegistro0220List read FRegistro0220 write FRegistro0220;
    property Registro0400: TRegistro0400List read FRegistro0400 write FRegistro0400;
    property Registro0450: TRegistro0450List read FRegistro0450 write FRegistro0450;
    property Registro0460: TRegistro0460List read FRegistro0460 write FRegistro0460;
    property Registro0990: TRegistro0990 read FRegistro0990 write FRegistro0990;
  end;

implementation

uses ACBrSpedUtils;

{ TBloco_0 }

constructor TBloco_0.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FRegistro0000 := TRegistro0000.Create;
  FRegistro0001 := TRegistro0001.Create;
  FRegistro0005 := TRegistro0005.Create;
  FRegistro0015 := TRegistro0015.Create;
  FRegistro0100 := TRegistro0100.Create;
  FRegistro0150 := TRegistro0150List.Create;
  FRegistro0175 := TRegistro0175List.Create;
  FRegistro0190 := TRegistro0190List.Create;
  FRegistro0200 := TRegistro0200List.Create;
  FRegistro0205 := TRegistro0205List.Create;
  FRegistro0206 := TRegistro0206List.Create;
  FRegistro0220 := TRegistro0220List.Create;
  FRegistro0400 := TRegistro0400List.Create;
  FRegistro0450 := TRegistro0450List.Create;
  FRegistro0460 := TRegistro0460List.Create;
  FRegistro0990 := TRegistro0990.Create;
end;

destructor TBloco_0.Destroy;
begin
  FRegistro0000.Free;
  FRegistro0001.Free;
  FRegistro0005.Free;
  FRegistro0015.Free;
  FRegistro0100.Free;
  FRegistro0150.Free;
  FRegistro0175.Free;
  FRegistro0190.Free;
  FRegistro0200.Free;
  FRegistro0205.Free;
  FRegistro0206.Free;
  FRegistro0220.Free;
  FRegistro0400.Free;
  FRegistro0450.Free;
  FRegistro0460.Free;
  FRegistro0990.Free;
  inherited;
end;

function TBloco_0.WriteRegistro0000: string;
begin
  if Assigned(Registro0000) then
  begin
     with Registro0000 do
     begin
       Check(funChecaCNPJ(CNPJ),   '(0-0000) ENTIDADE: O CNPJ "%s" digitado é inválido!', [CNPJ]);
       Check(funChecaCPF(CPF),     '(0-0000) ENTIDADE: O CPF "%s" digitado é inválido!', [CPF]);
       Check(funChecaUF(UF),       '(0-0000) ENTIDADE: A UF "%s" digitada é inválido!', [UF]);
       Check(funChecaIE(IE, UF),   '(0-0000) ENTIDADE: A Inscrição Estadual "%s" digitada é inválida!', [IE]);
       Check(funChecaMUN(COD_MUN), '(0-0000) ENTIDADE: O código do município "%s" digitado é inválido!', [IntToStr(COD_MUN)]);
       ///
       Result := LFill('0000') +
                 LFill(COD_VER, 3) +
                 LFill(COD_FIN, 1) +
                 LFill(DT_INI) +
                 LFill(DT_FIN) +
                 LFill(NOME) +
                 LFill(CNPJ) +
                 LFill(CPF) +
                 LFill(UF) +
                 LFill(IE) +
                 LFill(COD_MUN, 7) +
                 LFill(IM) +
                 LFill(SUFRAMA, 9) +
                 LFill(IND_PERFIL) +
                 LFill(IND_ATIV, 1) +
                 Delimitador +
                 #13#10;
       ///
       Registro0990.QTD_LIN_0 := Registro0990.QTD_LIN_0 + 1;
     end;
  end;
end;

function TBloco_0.WriteRegistro0001: string;
begin
  if Assigned(Registro0001) then
  begin
     with Registro0001 do
     begin
       Check(((IND_MOV = 0) or (IND_MOV = 1)), '(0-0001) ABERTURA DO BLOCO: Na abertura do bloco, deve ser informado o número 0 ou 1!');
       ///
       Result := LFill('0001') +
                 LFill(IND_MOV, 1) +
                 Delimitador +
                 #13#10;
       ///
       Registro0990.QTD_LIN_0 := Registro0990.QTD_LIN_0 + 1;
     end;
  end;
end;

function TBloco_0.WriteRegistro0005: string;
begin
  if Assigned(Registro0005) then
  begin
     with Registro0005 do
     begin
       Check(funChecaCEP(CEP, Registro0000.UF), '(0-0005) COMPLEMENTO DA ENTIDADE: O CEP "%s" digitada é inválido para a unidade de federação "%s"!', [FANTASIA, CEP, Registro0000.UF]);
       ///
       Result := LFill('0005') +
                 LFill(FANTASIA) +
                 LFill(CEP, 8) +
                 LFill(ENDERECO) +
                 LFill(NUM) +
                 LFill(COMPL) +
                 LFill(BAIRRO) +
                 LFill(FONE, 10) +
                 LFill(FAX, 10) +
                 LFill(EMAIL) +
                 Delimitador +
                 #13#10;
       ///
       Registro0990.QTD_LIN_0 := Registro0990.QTD_LIN_0 + 1;
     end;
  end;
end;

function TBloco_0.WriteRegistro0015: string;
begin
  if Assigned(Registro0015) then
  begin
     with Registro0015 do
     begin
        Check(funChecaUF(UF_ST),        '(0-0015) CONTRIBUINTE SUBSTITUTO: A UF "%s" digitada é inválido!', [UF_ST]);
        Check(funChecaIE(IE_ST, UF_ST), '(0-0015) CONTRIBUINTE SUBSTITUTO: A Inscrição Estadual "%s" digitada é inválida!', [IE_ST]);
        ///
        Result := LFill('0015') +
                  LFill(UF_ST) +
                  LFill(IE_ST) +
                  Delimitador +
                  #13#10;
        ///
        Registro0990.QTD_LIN_0 := Registro0990.QTD_LIN_0 + 1;
     end;
  end;
end;

function TBloco_0.WriteRegistro0100: string;
begin
  if Assigned(Registro0100) then
  begin
     with Registro0100 do
     begin
       Check(funChecaCNPJ(CNPJ),   '(0-0100) CONTADOR: %s, o CNPJ "%s" digitado é inválido!', [NOME, CNPJ]);
       Check(funChecaCPF(CPF),     '(0-0100) CONTADOR: %s, o CPF "%s" digitado é inválido!', [NOME, CPF]);
       Check(funChecaMUN(COD_MUN), '(0-0100) CONTADOR: %s, o código do município "%s" digitado é inválido!', [NOME, IntToStr(COD_MUN)]);
       Check(funChecaCEP(CEP, Registro0000.UF), 'CONTADOR (0-0100): %s, o CEP "%s" digitada é inválido para a unidade de federação "%s"!', [NOME, CEP, Registro0000.UF]);
       ///
       Result := LFill('0100') +
                 LFill(NOME) +
                 LFill(CPF) +
                 LFill(CRC) +
                 LFill(CNPJ) +
                 LFill(CEP, 8) +
                 LFill(ENDERECO) +
                 LFill(NUM) +
                 LFill(COMPL) +
                 LFill(BAIRRO) +
                 LFill(FONE, 10) +
                 LFill(FAX, 10) +
                 LFill(EMAIL) +
                 LFill(COD_MUN, 7) +
                 Delimitador +
                 #13#10;
       ///
       Registro0990.QTD_LIN_0 := Registro0990.QTD_LIN_0 + 1;
     end;
  end;
end;

function TBloco_0.WriteRegistro0150: string;
var
intFor: integer;
strRegistro0150: string;
begin
  strRegistro0150 := '';

  if Assigned(Registro0150) then
  begin
     for intFor := 0 to Registro0150.Count - 1 do
     begin
        with Registro0150.Items[intFor] do
        begin
          Check(funChecaPAISIBGE(COD_PAIS), '(0-0150) %s-%s, o código do país "%s" digitado é inválido!', [COD_PART, NOME, COD_PAIS]);
          Check(funChecaCNPJ(CNPJ),         '(0-0150) %s-%s, o CNPJ "%s" digitado é inválido!', [COD_PART, NOME, CNPJ]);
          Check(funChecaCPF(CPF),           '(0-0150) %s-%s, o CPF "%s" digitado é inválido!', [COD_PART, NOME, CPF]);
//          Check(funChecaIE(IE, UF),         '(0-0150) %s-%s, a Inscrição Estadual "%s" digitada é inválida!', [COD_PART, NOME, IE]);
          Check(funChecaMUN(COD_MUN),       '(0-0150) %s-%s, o código do município "%s" digitado é inválido!', [COD_PART, NOME, IntToStr(COD_MUN)]);
          ///
          strRegistro0150 := strRegistro0150 + LFill('0150') +
                                               LFill(COD_PART) +
                                               LFill(NOME) +
                                               LFill(COD_PAIS) +
                                               LFill(CNPJ) +
                                               LFill(CPF) +
                                               LFill(IE) +
                                               LFill(COD_MUN, 7) +
                                               LFill(SUFRAMA) +
                                               LFill(ENDERECO) +
                                               LFill(NUM) +
                                               LFill(COMPL) +
                                               LFill(BAIRRO) +
                                               Delimitador +
                                               #13#10;
        end;
     end;
     Result := strRegistro0150;
     ///
     Registro0990.QTD_LIN_0 := Registro0990.QTD_LIN_0 + 1;
  end;
end;

function TBloco_0.WriteRegistro0175: string;
var
intFor: integer;
strRegistro0175: string;
begin
  strRegistro0175 := '';

  if Assigned(Registro0175) then
  begin
     for intFor := 0 to Registro0175.Count - 1 do
     begin
        with Registro0175.Items[intFor] do
        begin
          Check(((DT_ALT >= DT_INI) and (DT_ALT <= DT_FIN)),  '(0-0175) ALTERAÇÃO NO CADASTRO DE CLIENTES/FORNECEDORES: A data da alteração deve estar no intervalo de: s% a s%!', [DateToStr(DT_INI), DateToStr(DT_FIN)]);
          ///
          strRegistro0175 := strRegistro0175 + LFill('0175') +
                                               LFill(DT_ALT) +
                                               LFill(NR_CAMPO) +
                                               LFill(CONT_ANT) +
                                               Delimitador +
                                               #13#10;
        end;
     end;
     Result := strRegistro0175;
     ///
     Registro0990.QTD_LIN_0 := Registro0990.QTD_LIN_0 + 1;
  end;
end;

function TBloco_0.WriteRegistro0190: string;
var
intFor: integer;
strRegistro0190: string;
begin
  strRegistro0190 := '';

  if Assigned(Registro0190) then
  begin
     for intFor := 0 to Registro0190.Count - 1 do
     begin
        with Registro0190.Items[intFor] do
        begin
          ///
          strRegistro0190 := strRegistro0190 + LFill('0190') +
                                               LFill(UNID ) +
                                               LFill(DESCR) +
                                               Delimitador +
                                               #13#10;
        end;
        Registro0990.QTD_LIN_0 := Registro0990.QTD_LIN_0 + 1;
     end;
     Result := strRegistro0190;
  end;
end;

function TBloco_0.WriteRegistro0200: string;
begin

end;

function TBloco_0.WriteRegistro0205: string;
begin

end;

function TBloco_0.WriteRegistro0206: string;
begin

end;

function TBloco_0.WriteRegistro0220: string;
begin

end;

function TBloco_0.WriteRegistro0400: string;
begin

end;

function TBloco_0.WriteRegistro0450: string;
begin

end;

function TBloco_0.WriteRegistro0460: string;
begin

end;

function TBloco_0.WriteRegistro0990: string;
begin
  if Assigned(Registro0990) then
  begin
     with Registro0990 do
     begin
       QTD_LIN_0 := QTD_LIN_0 + 1;
       ///
       Result := LFill('0990') +
                 LFill(QTD_LIN_0,0,0) +
                 Delimitador +
                 #13#10;
     end;
  end;
end;

end.
