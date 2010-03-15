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
|* 15/03/2010: Alessandro Yamasaki
|*  - Adicionado o REGISTRO 0500: PLANO DE CONTAS CONTÁBEIS
*******************************************************************************}

unit ACBrEFDBloco_0_Class;

interface

uses SysUtils, Classes, DateUtils, ACBrSped, ACBrEFDBloco_0;

type
  /// TBLOCO_0 - Abertura, Identificação e Referências
  TBloco_0 = class(TACBrSPED)
  private
    FRegistro0000: TRegistro0000;      /// BLOCO 0 - Registro0000
    FRegistro0001: TRegistro0001;      /// BLOCO 0 - Registro0001
    FRegistro0005: TRegistro0005;      /// BLOCO 0 - Registro0005
    FRegistro0015: TRegistro0015List;  /// BLOCO 0 - Lista de Registro0015
    FRegistro0100: TRegistro0100;      /// BLOCO 0 - Registro0100
    FRegistro0150: TRegistro0150List;  /// BLOCO 0 - Lista de Registro0150
    FRegistro0190: TRegistro0190List;  /// BLOCO 0 - Lista de Registro0190
    FRegistro0200: TRegistro0200List;  /// BLOCO 0 - Lista de Registro0200
    FRegistro0400: TRegistro0400List;  /// BLOCO 0 - Lista de Registro0400
    FRegistro0450: TRegistro0450List;  /// BLOCO 0 - Lista de Registro0450
    FRegistro0460: TRegistro0460List;  /// BLOCO 0 - Lista de Registro0460
    FRegistro0500: TRegistro0500List;  /// BLOCO 0 - Lista de Registro0500
    FRegistro0600: TRegistro0600List;  /// BLOCO 0 - Lista de Registro0600
    FRegistro0990: TRegistro0990;      /// BLOCO 0 - Registro0990

    FRegistro0175Count: Integer;
    FRegistro0205Count: Integer;
    FRegistro0206Count: Integer;
    FRegistro0220Count: Integer;

    function WriteRegistro0175(Reg0150: TRegistro0150): AnsiString;
    function WriteRegistro0205(Reg0200: TRegistro0200): AnsiString;
    function WriteRegistro0206(Reg0200: TRegistro0200): AnsiString;
    function WriteRegistro0220(Reg0200: TRegistro0200): AnsiString;

    procedure CriaRegistros;
    procedure LiberaRegistros;
  public
    constructor Create(AOwner: TComponent); override; /// Create
    destructor Destroy; override; /// Destroy
    procedure LimpaRegistros;

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
    function WriteRegistro0500: AnsiString;
    function WriteRegistro0600: AnsiString;
    function WriteRegistro0990: AnsiString;

    property Registro0000: TRegistro0000     read FRegistro0000 write FRegistro0000;
    property Registro0001: TRegistro0001     read FRegistro0001 write FRegistro0001;
    property Registro0005: TRegistro0005     read FRegistro0005 write FRegistro0005;
    property Registro0015: TRegistro0015List read FRegistro0015 write FRegistro0015;
    property Registro0100: TRegistro0100     read FRegistro0100 write FRegistro0100;
    property Registro0150: TRegistro0150List read FRegistro0150 write FRegistro0150;
    property Registro0190: TRegistro0190List read FRegistro0190 write FRegistro0190;
    property Registro0200: TRegistro0200List read FRegistro0200 write FRegistro0200;
    property Registro0400: TRegistro0400List read FRegistro0400 write FRegistro0400;
    property Registro0450: TRegistro0450List read FRegistro0450 write FRegistro0450;
    property Registro0460: TRegistro0460List read FRegistro0460 write FRegistro0460;
    property Registro0500: TRegistro0500List read FRegistro0500 write FRegistro0500;
    property Registro0600: TRegistro0600List read FRegistro0600 write FRegistro0600;
    property Registro0990: TRegistro0990 read FRegistro0990 write FRegistro0990;

    property Registro0175Count: Integer read FRegistro0175Count write FRegistro0175Count;
    property Registro0205Count: Integer read FRegistro0205Count write FRegistro0205Count;
    property Registro0206Count: Integer read FRegistro0206Count write FRegistro0206Count;
    property Registro0220Count: Integer read FRegistro0220Count write FRegistro0220Count;
  end;

implementation

uses ACBrSpedUtils;

{ TBloco_0 }

constructor TBloco_0.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  CriaRegistros;
end;

destructor TBloco_0.Destroy;
begin
  LiberaRegistros;
  inherited;
end;

procedure TBloco_0.CriaRegistros;
begin
  FRegistro0000 := TRegistro0000.Create;
  FRegistro0001 := TRegistro0001.Create;
  FRegistro0005 := TRegistro0005.Create;
  FRegistro0015 := TRegistro0015List.Create;
  FRegistro0100 := TRegistro0100.Create;
  FRegistro0150 := TRegistro0150List.Create;
  FRegistro0190 := TRegistro0190List.Create;
  FRegistro0200 := TRegistro0200List.Create;
  FRegistro0400 := TRegistro0400List.Create;
  FRegistro0450 := TRegistro0450List.Create;
  FRegistro0460 := TRegistro0460List.Create;
  FRegistro0500 := TRegistro0500List.Create;
  FRegistro0600 := TRegistro0600List.Create;
  FRegistro0990 := TRegistro0990.Create;

  FRegistro0175Count := 0;
  FRegistro0205Count := 0;
  FRegistro0206Count := 0;
  FRegistro0220Count := 0;

  FRegistro0990.QTD_LIN_0 := 0;
end;

procedure TBloco_0.LiberaRegistros;
begin
  FRegistro0000.Free;
  FRegistro0001.Free;
  FRegistro0005.Free;
  FRegistro0015.Free;
  FRegistro0100.Free;
  FRegistro0150.Free;
  FRegistro0190.Free;
  FRegistro0200.Free;
  FRegistro0400.Free;
  FRegistro0450.Free;
  FRegistro0460.Free;
  FRegistro0500.Free;
  FRegistro0600.Free;
  FRegistro0990.Free;
end;

procedure TBloco_0.LimpaRegistros;
begin
  /// Limpa os Registros
  LiberaRegistros;
  /// Recriar os Registros Limpos
  CriaRegistros;
end;

function TBloco_0.WriteRegistro0000: AnsiString;
begin
  Result := '';

  if Assigned(Registro0000) then
  begin
     with Registro0000 do
     begin
       Check(funChecaVersaoEFD(COD_VER), '(0-0000) ENTIDADE: O código da versão "%s" do leiaute é inválido', [IntToStr(COD_VER)]);
       Check(((COD_FIN = 0) or (COD_FIN = 1)), '(0-0000) ENTIDADE: O código da finalidade do arquivo, deve ser informado o número 0 ou 1!');
       Check(funChecaCNPJ(CNPJ), '(0-0000) ENTIDADE: O CNPJ "%s" digitado é inválido!', [CNPJ]);
       Check(funChecaCPF(CPF), '(0-0000) ENTIDADE: O CPF "%s" digitado é inválido!', [CPF]);
       Check(funChecaUF(UF), '(0-0000) ENTIDADE: A UF "%s" digitada é inválido!', [UF]);
       Check(funChecaIE(IE, UF), '(0-0000) ENTIDADE: A inscrição estadual "%s" digitada é inválida!', [IE]);
       Check(funChecaMUN(COD_MUN), '(0-0000) ENTIDADE: O código do município "%s" digitado é inválido!', [IntToStr(COD_MUN)]);
       Check(((IND_PERFIL = 'A') or (IND_PERFIL = 'B') or (IND_PERFIL = 'C')), '(0-0000) ENTIDADE: O  perfil "%s" de apresentação do arquivo fiscal, deve ser informado a letra A, B ou C!', [IND_PERFIL]);
       Check(((IND_ATIV = 0) or (IND_ATIV = 1)), '(0-0000) ENTIDADE: O indicador "%s" de tipo de atividade, deve ser informado o número 0 ou 1!', [IntToStr(IND_ATIV)]);
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

function TBloco_0.WriteRegistro0001: AnsiString;
begin
  Result := '';

  if Assigned(Registro0001) then
  begin
     with Registro0001 do
     begin
       Check(((IND_MOV = 0) or (IND_MOV = 1)), '(0-0001) ABERTURA DO BLOCO: Na abertura do bloco, deve ser informado o número 0 ou 1!');
       ///
       Result := LFill('0001') +
                 LFill(IND_MOV, 0) +
                 Delimitador +
                 #13#10;
       ///
       Registro0990.QTD_LIN_0 := Registro0990.QTD_LIN_0 + 1;
     end;
  end;
end;

function TBloco_0.WriteRegistro0005: AnsiString;
begin
  Result := '';

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

function TBloco_0.WriteRegistro0015: AnsiString;
var
intFor: integer;
strRegistro0015: AnsiString;
begin
  strRegistro0015 := '';

  if Assigned(Registro0015) then
  begin
     for intFor := 0 to Registro0015.Count - 1 do
     begin
        with Registro0015.Items[intFor] do
        begin
           Check(funChecaUF(UF_ST),        '(0-0015) CONTRIBUINTE SUBSTITUTO: A UF "%s" digitada é inválido!', [UF_ST]);
           Check(funChecaIE(IE_ST, UF_ST), '(0-0015) CONTRIBUINTE SUBSTITUTO: A Inscrição Estadual "%s" digitada é inválida!', [IE_ST]);
           ///
           strRegistro0015 :=  strRegistro0015 + LFill('0015') +
                                                 LFill(UF_ST) +
                                                 LFill(IE_ST) +
                                                 Delimitador +
                                                 #13#10;
        end;
        Registro0990.QTD_LIN_0 := Registro0990.QTD_LIN_0 + 1;
     end;
  end;
  Result := strRegistro0015;
end;

function TBloco_0.WriteRegistro0100: AnsiString;
begin
  Result := '';

  if Assigned(Registro0100) then
  begin
     with Registro0100 do
     begin
       Check(funChecaCPF(CPF),     '(0-0100) CONTADOR: %s, o CPF "%s" digitado é inválido!', [NOME, CPF]);
       Check(funChecaCNPJ(CNPJ),   '(0-0100) CONTADOR: %s, o CNPJ "%s" digitado é inválido!', [NOME, CNPJ]);
//       Check(funChecaCEP(CEP, Registro0000.UF), '(0-0100) CONTADOR: %s, o CEP "%s" digitada é inválido para a unidade de federação "%s"!', [NOME, CEP, Registro0000.UF]);
       Check(funChecaMUN(COD_MUN), '(0-0100) CONTADOR: %s, o código do município "%s" digitado é inválido!', [NOME, IntToStr(COD_MUN)]);
       Check(NOME <> '', '(0-0100) CONTADOR: O nome do contabilista/escritório é obrigatório!');
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

function TBloco_0.WriteRegistro0150: AnsiString;
var
intFor: integer;
strRegistro0150: AnsiString;
begin
  strRegistro0150 := '';

  if Assigned(Registro0150) then
  begin
     for intFor := 0 to Registro0150.Count - 1 do
     begin
        with Registro0150.Items[intFor] do
        begin
          Check(funChecaPAISIBGE(COD_PAIS), '(0-0150) %s-%s, o código do país "%s" digitado é inválido!', [COD_PART, NOME, COD_PAIS]);
          if Length(CNPJ) > 0 then
             Check(funChecaCNPJ(CNPJ), '(0-0150) %s-%s, o CNPJ "%s" digitado é inválido!', [COD_PART, NOME, CNPJ]);
          if Length(CPF)  > 0 then
             Check(funChecaCPF(CPF), '(0-0150) %s-%s, o CPF "%s" digitado é inválido!', [COD_PART, NOME, CPF]);
//          Check(funChecaIE(IE, UF),         '(0-0150) %s-%s, a Inscrição Estadual "%s" digitada é inválida!', [COD_PART, NOME, IE]);
          Check(funChecaMUN(COD_MUN),       '(0-0150) %s-%s, o código do município "%s" digitado é inválido!', [COD_PART, NOME, IntToStr(COD_MUN)]);
          Check(NOME <> '',                 '(0-0150) O nome do participante é obrigatório!');
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
        /// Registros FILHOS
        strRegistro0150 := strRegistro0150 +
                           WriteRegistro0175( Registro0150.Items[intFor] );

        Registro0990.QTD_LIN_0 := Registro0990.QTD_LIN_0 + 1;
     end;
  end;
  Result := strRegistro0150;
end;

function TBloco_0.WriteRegistro0175(Reg0150: TRegistro0150): AnsiString;
var
intFor: integer;
strRegistro0175: AnsiString;
begin
  strRegistro0175 := '';

  if Assigned(Reg0150.Registro0175) then
  begin
     for intFor := 0 to Reg0150.Registro0175.Count - 1 do
     begin
        with Reg0150.Registro0175.Items[intFor] do
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
        Registro0990.QTD_LIN_0 := Registro0990.QTD_LIN_0 + 1;
     end;
     /// Variavél para armazenar a quantidade de registro do tipo.
     FRegistro0175Count := FRegistro0175Count + Reg0150.Registro0175.Count;
  end;
  Result := strRegistro0175;
end;

function TBloco_0.WriteRegistro0190: AnsiString;
var
intFor: integer;
strRegistro0190: AnsiString;
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
  end;
  Result := strRegistro0190;
end;

function TBloco_0.WriteRegistro0200: AnsiString;
var
intFor: integer;
strRegistro0200: AnsiString;
begin
  strRegistro0200 := '';

  if Assigned( Registro0200 ) then
  begin
     for intFor := 0 to Registro0200.Count - 1 do
     begin
        with Registro0200.Items[intFor] do
        begin
          Check(funChecaGENERO(COD_GEN), '(0-0200) O código do gênero "%s" digitado é inválido!', [COD_GEN]);
          Check(Pos(TIPO_ITEM, '00,01,02,03,04,05,06,07,08,09,10,99') > 0, '(0-0200) O código do tipo do item – Atividades Industriais, Comerciais e Serviços "%s" digitado é inválido!', [TIPO_ITEM]);
          ///
          strRegistro0200 := strRegistro0200 + LFill('0200') +
                                               LFill( COD_ITEM ) +
                                               LFill( DESCR_ITEM ) +
                                               LFill( COD_BARRA ) +
                                               LFill( COD_ANT_ITEM ) +
                                               LFill( UNID_INV ) +
                                               LFill( TIPO_ITEM ) +
                                               LFill( COD_NCM ) +
                                               LFill( EX_IPI ) +
                                               LFill( COD_GEN ) +
                                               LFill( COD_LST ) +
                                               LFill( ALIQ_ICMS,0,2 ) +
                                               Delimitador +
                                               #13#10;
        end;
        /// Registros FILHOS
        strRegistro0200 := strRegistro0200 +
                           WriteRegistro0205( Registro0200.Items[intFor] ) +
                           WriteRegistro0206( Registro0200.Items[intFor] ) +
                           WriteRegistro0220( Registro0200.Items[intFor] );

        Registro0990.QTD_LIN_0 := Registro0990.QTD_LIN_0 + 1;
     end;
  end;
  Result := strRegistro0200;
end;

function TBloco_0.WriteRegistro0205(Reg0200: TRegistro0200): AnsiString;
var
intFor: integer;
strRegistro0205: AnsiString;
begin
  strRegistro0205 := '';

  if Assigned( Reg0200.Registro0205 ) then
  begin
     for intFor := 0 to Reg0200.Registro0205.Count - 1 do
     begin
        with Reg0200.Registro0205.Items[intFor] do
        begin
          strRegistro0205 := strRegistro0205 + LFill('0205') +
                                               LFill( DESCR_ANT_ITEM ) +
                                               LFill( DT_INI ) +
                                               LFill( DT_FIN ) +
                                               Delimitador +
                                               #13#10;
        end;
        Registro0990.QTD_LIN_0 := Registro0990.QTD_LIN_0 + 1;
     end;
     /// Variavél para armazenar a quantidade de registro do tipo.
     FRegistro0205Count := FRegistro0205Count + Reg0200.Registro0205.Count;
  end;
  Result := strRegistro0205;
end;

function TBloco_0.WriteRegistro0206(Reg0200: TRegistro0200): AnsiString;
var
intFor: integer;
strRegistro0206: AnsiString;
begin
  strRegistro0206 := '';

  if Assigned( Reg0200.Registro0206 ) then
  begin
     for intFor := 0 to Reg0200.Registro0206.Count - 1 do
     begin
        with Reg0200.Registro0206.Items[intFor] do
        begin
          strRegistro0206 := strRegistro0206 + LFill('0206') +
                                               LFill( COD_COMB ) +
                                               Delimitador +
                                               #13#10;
        end;
        Registro0990.QTD_LIN_0 := Registro0990.QTD_LIN_0 + 1;
     end;
     /// Variavél para armazenar a quantidade de registro do tipo.
     FRegistro0206Count := FRegistro0206Count + Reg0200.Registro0206.Count;
  end;
  Result := strRegistro0206;
end;

function TBloco_0.WriteRegistro0220(Reg0200: TRegistro0200): AnsiString;
var
intFor: integer;
strRegistro0220: AnsiString;
begin
  strRegistro0220 := '';

  if Assigned( Reg0200.Registro0220 ) then
  begin
     for intFor := 0 to Reg0200.Registro0220.Count - 1 do
     begin
        with Reg0200.Registro0220.Items[intFor] do
        begin
          strRegistro0220 := strRegistro0220 + LFill('0220') +
                                               LFill( UNID_CONV ) +
                                               LFill( FAT_CONV ) +
                                               Delimitador +
                                               #13#10;
        end;
        Registro0990.QTD_LIN_0 := Registro0990.QTD_LIN_0 + 1;
     end;
     /// Variavél para armazenar a quantidade de registro do tipo.
     FRegistro0220Count := FRegistro0220Count + Reg0200.Registro0220.Count;
  end;
  Result := strRegistro0220;
end;

function TBloco_0.WriteRegistro0400: AnsiString;
var
intFor: integer;
strRegistro0400: AnsiString;
begin
  strRegistro0400 := '';

  if Assigned(Registro0400) then
  begin
     for intFor := 0 to Registro0400.Count - 1 do
     begin
        with Registro0400.Items[intFor] do
        begin
          ///
          strRegistro0400 := strRegistro0400 + LFill('0400') +
                                               LFill( COD_NAT ) +
                                               LFill( DESCR_NAT ) +
                                               Delimitador +
                                               #13#10;
        end;
        Registro0990.QTD_LIN_0 := Registro0990.QTD_LIN_0 + 1;
     end;
  end;
  Result := strRegistro0400;
end;

function TBloco_0.WriteRegistro0450: AnsiString;
var
intFor: integer;
strRegistro0450: AnsiString;
begin
  strRegistro0450 := '';

  if Assigned( Registro0450 ) then
  begin
     for intFor := 0 to Registro0450.Count - 1 do
     begin
        with Registro0450.Items[intFor] do
        begin
          strRegistro0450 := strRegistro0450 + LFill('0450') +
                                               LFill( COD_INF ) +
                                               LFill( TXT ) +
                                               Delimitador +
                                               #13#10;
        end;
        Registro0990.QTD_LIN_0 := Registro0990.QTD_LIN_0 + 1;
     end;
  end;
  Result := strRegistro0450;
end;

function TBloco_0.WriteRegistro0460: AnsiString;
var
intFor: integer;
strRegistro0460: AnsiString;
begin
  strRegistro0460 := '';

  if Assigned( Registro0460 ) then
  begin
     for intFor := 0 to Registro0460.Count - 1 do
     begin
        with Registro0460.Items[intFor] do
        begin
          strRegistro0460 := strRegistro0460 + LFill('0460') +
                                               LFill( COD_OBS ) +
                                               LFill( TXT ) +
                                               Delimitador +
                                               #13#10;
        end;
        Registro0990.QTD_LIN_0 := Registro0990.QTD_LIN_0 + 1;
     end;
  end;
  Result := strRegistro0460;
end;

function TBloco_0.WriteRegistro0500: AnsiString;
var
intFor: integer;
strRegistro0500: AnsiString;
begin
  strRegistro0500 := '';

  if Assigned( Registro0500 ) then
  begin
     for intFor := 0 to Registro0500.Count - 1 do
     begin
        with Registro0500.Items[intFor] do
        begin
           Check(Pos(COD_NAT_CC, '01,02,03,04,05,09,10,99') > 0, '(0-0500) O código da natureza da conta/grupo de contas "%s" digitado é inválido!', [COD_NAT_CC]);
           Check(((IND_CTA = 'S') or (IND_CTA = 'A')), '(0-0500) O indicador "%s" do tipo de conta, deve ser informado  S ou A!', [IND_CTA]);

           strRegistro0500 := strRegistro0500 + LFill('0500') +
                                                LFill( DT_ALT ) +
                                                LFill( COD_NAT_CC, 2) +
                                                LFill( IND_CTA, 1) +
                                                LFill( NIVEL ) +
                                                LFill( COD_CTA ) +
                                                LFill( NOME_CTA ) +
                                                Delimitador +
                                                #13#10;
        end;
        Registro0990.QTD_LIN_0 := Registro0990.QTD_LIN_0 + 1;
     end;
  end;
  Result := strRegistro0500;
end;

function TBloco_0.WriteRegistro0600: AnsiString;
var
intFor: integer;
strRegistro0600: AnsiString;
begin
  strRegistro0600 := '';

  if Assigned( Registro0600 ) then
  begin
     for intFor := 0 to Registro0600.Count - 1 do
     begin
        with Registro0600.Items[intFor] do
        begin
           strRegistro0600 := strRegistro0600 + LFill('0600') +
                                                LFill( DT_ALT ) +
                                                LFill( COD_CCUS ) +
                                                LFill( CCUS ) +
                                                Delimitador +
                                                #13#10;
        end;
        Registro0990.QTD_LIN_0 := Registro0990.QTD_LIN_0 + 1;
     end;
  end;
  Result := strRegistro0600;
end;

function TBloco_0.WriteRegistro0990: AnsiString;
begin
  Result := '';

  if Assigned(Registro0990) then
  begin
     with Registro0990 do
     begin
       QTD_LIN_0 := QTD_LIN_0 + 1;
       ///
       Result := LFill('0990') +
                 LFill(QTD_LIN_0,0) +
                 Delimitador +
                 #13#10;
     end;
  end;
end;

end.
