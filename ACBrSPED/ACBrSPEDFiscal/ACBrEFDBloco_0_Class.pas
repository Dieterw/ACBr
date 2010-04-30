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

uses SysUtils, Classes, DateUtils, ACBrSped, ACBrEFDBloco_0, ACBrEFDBlocos;

type
  /// TBLOCO_0 - Abertura, Identificação e Referências
  TBloco_0 = class(TACBrSPED)
  private
    FRegistro0000: TRegistro0000;      /// BLOCO 0 - Registro0000
    FRegistro0001: TRegistro0001;      /// BLOCO 0 - Registro0001
    FRegistro0990: TRegistro0990;      /// BLOCO 0 - Registro0990

    FRegistro0005Count: Integer;
    FRegistro0015Count: Integer;
    FRegistro0150Count: Integer;
    FRegistro0175Count: Integer;
    FRegistro0200Count: Integer;
    FRegistro0190Count: Integer;
    FRegistro0205Count: Integer;
    FRegistro0206Count: Integer;
    FRegistro0220Count: Integer;
    FRegistro0400Count: Integer;
    FRegistro0300Count: Integer;
    FRegistro0305Count: Integer;
    FRegistro0450Count: Integer;
    FRegistro0460Count: Integer;
    FRegistro0500Count: Integer;
    FRegistro0600Count: Integer;

    function WriteRegistro0005(Reg0001: TRegistro0001): String;
    function WriteRegistro0015(Reg0001: TRegistro0001): String;
    function WriteRegistro0100(Reg0001: TRegistro0001): String;
    function WriteRegistro0150(Reg0001: TRegistro0001): String;
    function WriteRegistro0175(Reg0150: TRegistro0150): String;
    function WriteRegistro0190(Reg0001: TRegistro0001): String;
    function WriteRegistro0200(Reg0001: TRegistro0001): String;
    function WriteRegistro0205(Reg0200: TRegistro0200): String;
    function WriteRegistro0206(Reg0200: TRegistro0200): String;
    function WriteRegistro0220(Reg0200: TRegistro0200): String;
    function WriteRegistro0300(Reg0001: TRegistro0001): String;
    function WriteRegistro0305(Reg0300: TRegistro0300): String;
    function WriteRegistro0400(Reg0001: TRegistro0001): String;
    function WriteRegistro0450(Reg0001: TRegistro0001): String;
    function WriteRegistro0460(Reg0001: TRegistro0001): String;
    function WriteRegistro0500(Reg0001: TRegistro0001): String;
    function WriteRegistro0600(Reg0001: TRegistro0001): String;

    procedure CriaRegistros;
    procedure LiberaRegistros;
  public
    constructor Create;           /// Create
    destructor Destroy; override; /// Destroy
    procedure LimpaRegistros;

    function Registro0000New: TRegistro0000;
    function Registro0001New: TRegistro0001;
    function Registro0005New: TRegistro0005;
    function Registro0015New: TRegistro0015;
    function Registro0100New: TRegistro0100;
    function Registro0150New: TRegistro0150;
    function Registro0175New: TRegistro0175;
    function Registro0190New: TRegistro0190;
    function Registro0200New: TRegistro0200;
    function Registro0205New: TRegistro0205;
    function Registro0206New: TRegistro0206;
    function Registro0220New: TRegistro0220;
    function Registro0300New: TRegistro0300;
    function Registro0305New: TRegistro0305;
    function Registro0400New: TRegistro0400;
    function Registro0450New: TRegistro0450;
    function Registro0460New: TRegistro0460;
    function Registro0500New: TRegistro0500;
    function Registro0600New: TRegistro0600;

    function WriteRegistro0000: String;
    function WriteRegistro0001: String;
    function WriteRegistro0990: String;

    property Registro0000: TRegistro0000 read FRegistro0000 write FRegistro0000;
    property Registro0001: TRegistro0001 read FRegistro0001 write FRegistro0001;
    property Registro0990: TRegistro0990 read FRegistro0990 write FRegistro0990;

    property Registro0005Count: Integer read FRegistro0005Count write FRegistro0005Count;
    property Registro0015Count: Integer read FRegistro0015Count write FRegistro0015Count;
    property Registro0150Count: Integer read FRegistro0150Count write FRegistro0150Count;
    property Registro0175Count: Integer read FRegistro0175Count write FRegistro0175Count;
    property Registro0200Count: Integer read FRegistro0200Count write FRegistro0200Count;
    property Registro0190Count: Integer read FRegistro0190Count write FRegistro0190Count;
    property Registro0205Count: Integer read FRegistro0205Count write FRegistro0205Count;
    property Registro0206Count: Integer read FRegistro0206Count write FRegistro0206Count;
    property Registro0220Count: Integer read FRegistro0220Count write FRegistro0220Count;
    property Registro0300Count: Integer read FRegistro0300Count write FRegistro0300Count;
    property Registro0305Count: Integer read FRegistro0305Count write FRegistro0305Count;
    property Registro0400Count: Integer read FRegistro0400Count write FRegistro0400Count;
    property Registro0450Count: Integer read FRegistro0450Count write FRegistro0450Count;
    property Registro0460Count: Integer read FRegistro0460Count write FRegistro0460Count;
    property Registro0500Count: Integer read FRegistro0500Count write FRegistro0500Count;
    property Registro0600Count: Integer read FRegistro0600Count write FRegistro0600Count;
  end;

implementation

uses ACBrSpedUtils;

{ TBloco_0 }

constructor TBloco_0.Create;
begin
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
  FRegistro0990 := TRegistro0990.Create;

  FRegistro0005Count := 0;
  FRegistro0015Count := 0;
  FRegistro0150Count := 0;
  FRegistro0175Count := 0;
  FRegistro0200Count := 0;
  FRegistro0190Count := 0;
  FRegistro0205Count := 0;
  FRegistro0206Count := 0;
  FRegistro0220Count := 0;
  FRegistro0300Count := 0;
  FRegistro0305Count := 0;
  FRegistro0400Count := 0;
  FRegistro0450Count := 0;
  FRegistro0460Count := 0;
  FRegistro0500Count := 0;
  FRegistro0600Count := 0;

  FRegistro0990.QTD_LIN_0 := 0;
end;

procedure TBloco_0.LiberaRegistros;
begin
  FRegistro0000.Free;
  FRegistro0001.Free;
  FRegistro0990.Free;
end;

procedure TBloco_0.LimpaRegistros;
begin
  /// Limpa os Registros
  LiberaRegistros;
  /// Recriar os Registros Limpos
  CriaRegistros;
end;

function TBloco_0.Registro0000New: TRegistro0000;
begin
   Result := FRegistro0000;
end;

function TBloco_0.Registro0001New: TRegistro0001;
begin
   Result := FRegistro0001;
end;

function TBloco_0.Registro0005New: TRegistro0005;
begin
   Result := FRegistro0001.Registro0005;
end;

function TBloco_0.Registro0015New: TRegistro0015;
begin
   Result := FRegistro0001.Registro0015.New;
end;

function TBloco_0.Registro0100New: TRegistro0100;
begin
   Result := FRegistro0001.Registro0100;
end;

function TBloco_0.Registro0150New: TRegistro0150;
begin
   Result := FRegistro0001.Registro0150.New;
end;

function TBloco_0.Registro0175New: TRegistro0175;
begin
   Result := FRegistro0001.Registro0150.Items[FRegistro0001.Registro0150.Count -1].Registro0175.New;
end;

function TBloco_0.Registro0190New: TRegistro0190;
begin
   Result := FRegistro0001.Registro0190.New;
end;

function TBloco_0.Registro0200New: TRegistro0200;
begin
   Result := FRegistro0001.Registro0200.New;
end;

function TBloco_0.Registro0205New: TRegistro0205;
begin
   Result := FRegistro0001.Registro0200.Items[FRegistro0001.Registro0200.Count -1].Registro0205.New;
end;

function TBloco_0.Registro0206New: TRegistro0206;
begin
   Result := FRegistro0001.Registro0200.Items[FRegistro0001.Registro0200.Count -1].Registro0206.New;
end;

function TBloco_0.Registro0220New: TRegistro0220;
begin
   Result := FRegistro0001.Registro0200.Items[FRegistro0001.Registro0200.Count -1].Registro0220.New;
end;

function TBloco_0.Registro0300New: TRegistro0300;
begin
   Result := FRegistro0001.Registro0300.New;
end;

function TBloco_0.Registro0305New: TRegistro0305;
begin
   Result := FRegistro0001.Registro0300.Items[FRegistro0001.Registro0300.Count -1].Registro0305;
end;

function TBloco_0.Registro0400New: TRegistro0400;
begin
   Result := FRegistro0001.Registro0400.New;
end;

function TBloco_0.Registro0450New: TRegistro0450;
begin
   Result := FRegistro0001.Registro0450.New;
end;

function TBloco_0.Registro0460New: TRegistro0460;
begin
   Result := FRegistro0001.Registro0460.New;
end;

function TBloco_0.Registro0500New: TRegistro0500;
begin
   Result := FRegistro0001.Registro0500.New;
end;

function TBloco_0.Registro0600New: TRegistro0600;
begin
   Result := FRegistro0001.Registro0600.New;
end;

function TBloco_0.WriteRegistro0000: String;
var
strIND_PERFIL: String;
strCOD_VER: String;
begin
  Result := '';

  if Assigned(Registro0000) then
  begin
     with Registro0000 do
     begin
       case IND_PERFIL of
        pfPerfilA: strIND_PERFIL := 'A';
        pfPerfilB: strIND_PERFIL := 'B';
        pfPerfilC: strIND_PERFIL := 'C';
       end;
       case COD_VER of
         vlVersao100: strCOD_VER := '001';
         vlVersao101: strCOD_VER := '002';
         vlVersao102: strCOD_VER := '003';
       end;
       Check(funChecaCNPJ(CNPJ), '(0-0000) ENTIDADE: O CNPJ "%s" digitado é inválido!', [CNPJ]);
       Check(funChecaCPF(CPF), '(0-0000) ENTIDADE: O CPF "%s" digitado é inválido!', [CPF]);
       Check(funChecaUF(UF), '(0-0000) ENTIDADE: A UF "%s" digitada é inválido!', [UF]);
       Check(funChecaIE(IE, UF), '(0-0000) ENTIDADE: A inscrição estadual "%s" digitada é inválida!', [IE]);
       Check(funChecaMUN(COD_MUN), '(0-0000) ENTIDADE: O código do município "%s" digitado é inválido!', [IntToStr(COD_MUN)]);
       ///
       Result := LFill( '0000' ) +
                 LFill( strCOD_VER ) +
                 LFill( Integer(COD_FIN), 1 ) +
                 LFill( DT_INI ) +
                 LFill( DT_FIN ) +
                 LFill( NOME ) +
                 LFill( CNPJ ) +
                 LFill( CPF ) +
                 LFill( UF ) +
                 LFill( IE ) +
                 LFill( COD_MUN, 7 ) +
                 LFill( IM ) +
                 LFill( SUFRAMA, 9 ) +
                 LFill( strIND_PERFIL ) +
                 LFill( Integer(IND_ATIV), 1 ) +
                 Delimitador +
                 #13#10;
       ///
       Registro0990.QTD_LIN_0 := Registro0990.QTD_LIN_0 + 1;
     end;
  end;
end;

function TBloco_0.WriteRegistro0001: String;
var
strRegistro0001: String;
begin
  Result := '';

  if Assigned(FRegistro0001) then
  begin
     with FRegistro0001 do
     begin
        strRegistro0001 := LFill( '0001' ) +
                           LFill( Integer(IND_MOV), 0 ) +
                           Delimitador +
                           #13#10;
        ///
        if IND_MOV = imComDados then
        begin
           strRegistro0001 := strRegistro0001 +
                              WriteRegistro0005(FRegistro0001) +
                              WriteRegistro0015(FRegistro0001) +
                              WriteRegistro0100(FRegistro0001) +
                              WriteRegistro0150(FRegistro0001) +
                              WriteRegistro0190(FRegistro0001) +
                              WriteRegistro0200(FRegistro0001) +
                              WriteRegistro0300(FRegistro0001) +
                              WriteRegistro0400(FRegistro0001) +
                              WriteRegistro0450(FRegistro0001) +
                              WriteRegistro0460(FRegistro0001) +
                              WriteRegistro0500(FRegistro0001) +
                              WriteRegistro0600(FRegistro0001);
        end;
     end;
     Registro0990.QTD_LIN_0 := Registro0990.QTD_LIN_0 + 1;
  end;
  Result := strRegistro0001;
end;

function TBloco_0.WriteRegistro0005(Reg0001: TRegistro0001): String;
begin
  Result := '';

  if Assigned(Reg0001.Registro0005) then
  begin
     with Reg0001.Registro0005 do
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
     /// Variavél para armazenar a quantidade de registro do tipo.
     FRegistro0005Count := FRegistro0005Count + 1;
  end;
end;

function TBloco_0.WriteRegistro0015(Reg0001: TRegistro0001): String;
var
intFor: integer;
strRegistro0015: String;
begin
  strRegistro0015 := '';

  if Assigned(Reg0001.Registro0015) then
  begin
     for intFor := 0 to Reg0001.Registro0015.Count - 1 do
     begin
        with Reg0001.Registro0015.Items[intFor] do
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
     /// Variavél para armazenar a quantidade de registro do tipo.
     FRegistro0015Count := FRegistro0015Count + Reg0001.Registro0015.Count;
  end;
  Result := strRegistro0015;
end;

function TBloco_0.WriteRegistro0100(Reg0001: TRegistro0001): String;
begin
  Result := '';

  if Assigned(Reg0001.Registro0100) then
  begin
     with Reg0001.Registro0100 do
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

function TBloco_0.WriteRegistro0150(Reg0001: TRegistro0001): String;
var
intFor: integer;
strRegistro0150: String;
begin
  strRegistro0150 := '';

  if Assigned(Reg0001.Registro0150) then
  begin
     for intFor := 0 to Reg0001.Registro0150.Count - 1 do
     begin
        with Reg0001.Registro0150.Items[intFor] do
        begin
//          Check(funChecaPAISIBGE(COD_PAIS), '(0-0150) %s-%s, o código do país "%s" digitado é inválido!', [COD_PART, NOME, COD_PAIS]);
          if Length(CNPJ) > 0 then
             Check(funChecaCNPJ(CNPJ), '(0-0150) %s-%s, o CNPJ "%s" digitado é inválido!', [COD_PART, NOME, CNPJ]);
          if Length(CPF)  > 0 then
             Check(funChecaCPF(CPF), '(0-0150) %s-%s, o CPF "%s" digitado é inválido!', [COD_PART, NOME, CPF]);
//          Check(funChecaIE(IE, UF),         '(0-0150) %s-%s, a Inscrição Estadual "%s" digitada é inválida!', [COD_PART, NOME, IE]);
//          Check(funChecaMUN(COD_MUN),       '(0-0150) %s-%s, o código do município "%s" digitado é inválido!', [COD_PART, NOME, IntToStr(COD_MUN)]);
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
                           WriteRegistro0175( Reg0001.Registro0150.Items[intFor] );

        Registro0990.QTD_LIN_0 := Registro0990.QTD_LIN_0 + 1;
     end;
     /// Variavél para armazenar a quantidade de registro do tipo.
     FRegistro0150Count := FRegistro0150Count + Reg0001.Registro0150.Count;
  end;
  Result := strRegistro0150;
end;

function TBloco_0.WriteRegistro0175(Reg0150: TRegistro0150): String;
var
intFor: integer;
strRegistro0175: String;
begin
  strRegistro0175 := '';

  if Assigned(Reg0150.Registro0175) then
  begin
     for intFor := 0 to Reg0150.Registro0175.Count - 1 do
     begin
        with Reg0150.Registro0175.Items[intFor] do
        begin
          Check(((DT_ALT >= DT_INI) and (DT_ALT <= DT_FIN)),  '(0-0175) ALTERAÇÃO NO CADASTRO DE CLIENTES/FORNECEDORES: A data da alteração deve estar no intervalo de: %s a %s!', [DateToStr(DT_INI), DateToStr(DT_FIN)]);
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

function TBloco_0.WriteRegistro0190(Reg0001: TRegistro0001): String;
var
intFor: integer;
strRegistro0190: String;
begin
  strRegistro0190 := '';

  if Assigned(Reg0001.Registro0190) then
  begin
     for intFor := 0 to Reg0001.Registro0190.Count - 1 do
     begin
        with Reg0001.Registro0190.Items[intFor] do
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
     /// Variavél para armazenar a quantidade de registro do tipo.
     FRegistro0190Count := FRegistro0190Count + Reg0001.Registro0190.Count;
  end;
  Result := strRegistro0190;
end;

function TBloco_0.WriteRegistro0200(Reg0001: TRegistro0001): String;
var
intFor: integer;
strRegistro0200: String;
strTIPO_ITEM: String;
begin
  strRegistro0200 := '';

  if Assigned( Reg0001.Registro0200 ) then
  begin
     for intFor := 0 to Reg0001.Registro0200.Count - 1 do
     begin
        with Reg0001.Registro0200.Items[intFor] do
        begin
          case TIPO_ITEM of
            tiMercadoriaRevenda    : strTIPO_ITEM := '00';
            tiMateriaPrima         : strTIPO_ITEM := '01';
            tiEmbalagem            : strTIPO_ITEM := '02';
            tiProdutoProcesso      : strTIPO_ITEM := '03';
            tiProdutoAcabado       : strTIPO_ITEM := '04';
            tiSubproduto           : strTIPO_ITEM := '05';
            tiProdutoIntermediario : strTIPO_ITEM := '06';
            tiMaterialConsumo      : strTIPO_ITEM := '07';
            tiAtivoImobilizado     : strTIPO_ITEM := '08';
            tiServicos             : strTIPO_ITEM := '09';
            tiOutrosInsumos        : strTIPO_ITEM := '10';
            tiOutras               : strTIPO_ITEM := '99';
          end;
          if Length(COD_GEN) > 0 then
             Check(funChecaGENERO(COD_GEN), '(0-0200) O código do gênero "%s" digitado é inválido!', [COD_GEN]);
          ///
          strRegistro0200 := strRegistro0200 + LFill('0200') +
                                               LFill( COD_ITEM ) +
                                               LFill( DESCR_ITEM ) +
                                               LFill( COD_BARRA ) +
                                               LFill( COD_ANT_ITEM ) +
                                               LFill( UNID_INV ) +
                                               LFill( strTIPO_ITEM ) +
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
                           WriteRegistro0205( Reg0001.Registro0200.Items[intFor] ) +
                           WriteRegistro0206( Reg0001.Registro0200.Items[intFor] ) +
                           WriteRegistro0220( Reg0001.Registro0200.Items[intFor] );

        Registro0990.QTD_LIN_0 := Registro0990.QTD_LIN_0 + 1;
     end;
     /// Variavél para armazenar a quantidade de registro do tipo.
     FRegistro0200Count := FRegistro0200Count + Reg0001.Registro0200.Count;
  end;
  Result := strRegistro0200;
end;

function TBloco_0.WriteRegistro0205(Reg0200: TRegistro0200): String;
var
intFor: integer;
strRegistro0205: String;
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
                                               LFill( COD_ANT_ITEM ) +
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

function TBloco_0.WriteRegistro0206(Reg0200: TRegistro0200): String;
var
intFor: integer;
strRegistro0206: String;
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

function TBloco_0.WriteRegistro0220(Reg0200: TRegistro0200): String;
var
intFor: integer;
strRegistro0220: String;
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
                                               DFill( FAT_CONV, 6 ) +
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

function TBloco_0.WriteRegistro0300(Reg0001: TRegistro0001): String;
var
intFor: integer;
strRegistro0300: String;
begin
  strRegistro0300 := '';
  /// Exigência do Art. 3º do AC 09/08
  if DT_INI >= StrToDate('01/07/2010') then
  begin
     if Assigned(Reg0001.Registro0300) then
     begin
        for intFor := 0 to Reg0001.Registro0300.Count - 1 do
        begin
           with Reg0001.Registro0300.Items[intFor] do
           begin
             ///
             strRegistro0300 := strRegistro0300 + LFill('0300') +
                                                  LFill( COD_IND_BEM ) +
                                                  LFill( IDENT_MERC ) +
                                                  LFill( DESCR_ITEM ) +
                                                  LFill( COD_PRNC ) +
                                                  LFill( COD_CTA ) +
                                                  DFill( NR_PARC, 0 ) +
                                                  Delimitador +
                                                  #13#10;
           end;
           /// Registros FILHOS
           strRegistro0300 := strRegistro0300 +
                              WriteRegistro0305( Reg0001.Registro0300.Items[intFor] );

           Registro0990.QTD_LIN_0 := Registro0990.QTD_LIN_0 + 1;
        end;
        /// Variavél para armazenar a quantidade de registro do tipo.
        FRegistro0300Count := FRegistro0300Count  + Reg0001.Registro0300.Count;
     end;
  end;
  Result := strRegistro0300;
end;

function TBloco_0.WriteRegistro0305(Reg0300: TRegistro0300): String;
begin
  Result := '';
  /// Exigência do Art. 3º do AC 09/08
  if DT_INI >= StrToDate('01/07/2010') then
  begin
     if Assigned(Reg0300.Registro0305) then
     begin
        with Reg0300.Registro0305 do
        begin
          Result := LFill('0305') +
                    LFill(COD_CTA_DEPR) +
                    LFill(DT_DEPR_INI, 'ddmmyyyy') +
                    LFill(COD_CCUS) +
                    DFill(VIDA_UTIL, 0) +
                    Delimitador +
                    #13#10;
          ///
          Registro0990.QTD_LIN_0 := Registro0990.QTD_LIN_0 + 1;
        end;
        /// Variavél para armazenar a quantidade de registro do tipo.
        FRegistro0305Count := FRegistro0305Count + 1;
     end;
  end;
end;

function TBloco_0.WriteRegistro0400(Reg0001: TRegistro0001): String;
var
intFor: integer;
strRegistro0400: String;
begin
  strRegistro0400 := '';

  if Assigned(Reg0001.Registro0400) then
  begin
     for intFor := 0 to Reg0001.Registro0400.Count - 1 do
     begin
        with Reg0001.Registro0400.Items[intFor] do
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
     /// Variavél para armazenar a quantidade de registro do tipo.
     FRegistro0400Count := FRegistro0400Count + Reg0001.Registro0400.Count;
  end;
  Result := strRegistro0400;
end;

function TBloco_0.WriteRegistro0450(Reg0001: TRegistro0001): String;
var
intFor: integer;
strRegistro0450: String;
begin
  strRegistro0450 := '';

  if Assigned( Reg0001.Registro0450 ) then
  begin
     for intFor := 0 to Reg0001.Registro0450.Count - 1 do
     begin
        with Reg0001.Registro0450.Items[intFor] do
        begin
          strRegistro0450 := strRegistro0450 + LFill('0450') +
                                               LFill( COD_INF ) +
                                               LFill( TXT ) +
                                               Delimitador +
                                               #13#10;
        end;
        Registro0990.QTD_LIN_0 := Registro0990.QTD_LIN_0 + 1;
     end;
     /// Variavél para armazenar a quantidade de registro do tipo.
     FRegistro0450Count := FRegistro0450Count + Reg0001.Registro0450.Count;
  end;
  Result := strRegistro0450;
end;

function TBloco_0.WriteRegistro0460(Reg0001: TRegistro0001): String;
var
intFor: integer;
strRegistro0460: String;
begin
  strRegistro0460 := '';

  if Assigned( Reg0001.Registro0460 ) then
  begin
     for intFor := 0 to Reg0001.Registro0460.Count - 1 do
     begin
        with Reg0001.Registro0460.Items[intFor] do
        begin
          strRegistro0460 := strRegistro0460 + LFill('0460') +
                                               LFill( COD_OBS ) +
                                               LFill( TXT ) +
                                               Delimitador +
                                               #13#10;
        end;
        Registro0990.QTD_LIN_0 := Registro0990.QTD_LIN_0 + 1;
     end;
     /// Variavél para armazenar a quantidade de registro do tipo.
     FRegistro0460Count := FRegistro0460Count + Reg0001.Registro0460.Count;
  end;
  Result := strRegistro0460;
end;

function TBloco_0.WriteRegistro0500(Reg0001: TRegistro0001): String;
var
intFor: integer;
strRegistro0500: String;
begin
  strRegistro0500 := '';
  /// Exigência do Art. 3º do AC 09/08
  if DT_INI >= StrToDate('01/07/2010') then
  begin
     if Assigned( Reg0001.Registro0500 ) then
     begin
        for intFor := 0 to Reg0001.Registro0500.Count - 1 do
        begin
           with Reg0001.Registro0500.Items[intFor] do
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
        /// Variavél para armazenar a quantidade de registro do tipo.
        FRegistro0500Count := FRegistro0500Count + Reg0001.Registro0500.Count;
     end;
  end;
  Result := strRegistro0500;
end;

function TBloco_0.WriteRegistro0600(Reg0001: TRegistro0001): String;
var
intFor: integer;
strRegistro0600: String;
begin
  strRegistro0600 := '';

  if Assigned( Reg0001.Registro0600 ) then
  begin
     for intFor := 0 to Reg0001.Registro0600.Count - 1 do
     begin
        with Reg0001.Registro0600.Items[intFor] do
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
     /// Variavél para armazenar a quantidade de registro do tipo.
     FRegistro0600Count := FRegistro0600Count + Reg0001.Registro0600.Count;
  end;
  Result := strRegistro0600;
end;

function TBloco_0.WriteRegistro0990: String;
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
