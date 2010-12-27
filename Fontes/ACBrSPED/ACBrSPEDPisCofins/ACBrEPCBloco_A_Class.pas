{******************************************************************************}
{ Projeto: Componentes ACBr                                                    }
{  Biblioteca multiplataforma de componentes Delphi para interação com equipa- }
{ mentos de Automação Comercial utilizados no Brasil                           }
{                                                                              }
{ Direitos Autorais Reservados (c) 2010   Isaque Pinheiro                      }
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
|* 12/12/2010: Isaque Pinheiro e Claudio Roberto
|*  - Criação e distribuição da Primeira Versao
*******************************************************************************}

unit ACBrEFDBloco_A_Class;

interface

uses SysUtils, Classes, DateUtils, ACBrSped, ACBrEFDBloco_A, ACBrEFDBlocos,
     ACBrTXTClass;

type
  /// TBloco_A - Abertura, Identificação e Referências

  { TBloco_A }

  TBloco_A = class(TACBrSPED)
  private
    FRegistroA001: TRegistroA001;      /// BLOCO 0 - Registro0001
    FRegistroA990: TRegistroA990;      /// BLOCO 0 - Registro0990

    FRegistroA010Count: Integer;
    FRegistroA100Count: Integer;
    FRegistroA110Count: Integer;
    FRegistroA111Count: Integer;
    FRegistroA120Count: Integer;
    FRegistroA170Count: Integer;

    procedure WriteRegistroA010(RegA001: TRegistroA001);
    procedure WriteRegistroA100(RegA010: TRegistroA010);
    procedure WriteRegistroA111(RegA010: TRegistroA010);
    procedure WriteRegistroA120(RegA010: TRegistroA010);
    procedure WriteRegistroA170(RegA010: TRegistroA010);

    procedure CriaRegistros;
    procedure LiberaRegistros;
  public
    constructor Create ;          /// Create
    destructor Destroy; override; /// Destroy
    procedure LimpaRegistros;

    function RegistroA001New: TRegistroA001;
    function RegistroA010New: TRegistroA010;
    function RegistroA100New: TRegistroA100;
    function RegistroA111New: TRegistroA111;
    function RegistroA120New: TRegistroA120;
    function RegistroA170New: TRegistroA170;

    procedure WriteRegistroA001 ;
    procedure WriteRegistroA990 ;

    property RegistroA001: TRegistroA001 read FRegistroA001 write FRegistroA001;
    property RegistroA990: TRegistroA990 read FRegistroA990 write FRegistroA990;

    property RegistroA010Count: Integer read FRegistroA010Count write FRegistroA010Count;
    property RegistroA100Count: Integer read FRegistroA100Count write FRegistroA100Count;
    property RegistroA111Count: Integer read FRegistroA111Count write FRegistroA111Count;
    property RegistroA120Count: Integer read FRegistroA120Count write FRegistroA120Count;
    property RegistroA170Count: Integer read FRegistroA170Count write FRegistroA170Count;
  end;

implementation

uses ACBrSpedUtils;

{ TBloco_A }

constructor TBloco_A.Create ;
begin
  inherited ;
  CriaRegistros;
end;

destructor TBloco_A.Destroy;
begin
  LiberaRegistros;
  inherited;
end;

procedure TBloco_A.CriaRegistros;
begin
  FRegistroA001 := TRegistroA001.Create;
  FRegistroA990 := TRegistroA990.Create;

  FRegistroA010Count := 0;
  FRegistroA100Count := 0;
  FRegistroA111Count := 0;
  FRegistroA120Count := 0;
  FRegistroA170Count := 0;

  FRegistroA990.QTD_LIN_A := 0;
end;

procedure TBloco_A.LiberaRegistros;
begin
  FRegistroA001.Free;
  FRegistroA990.Free;
end;

procedure TBloco_A.LimpaRegistros;
begin
  /// Limpa os Registros
  LiberaRegistros;
  Conteudo.Clear;

  /// Recriar os Registros Limpos
  CriaRegistros;
end;

function TBloco_A.RegistroA001New: TRegistroA001;
begin
   Result := FRegistroA001;
end;

function TBloco_A.RegistroA010New: TRegistroA010;
begin
   Result := FRegistroA001.RegistroA010.New;
end;

function TBloco_A.RegistroA100New: TRegistroA100;
var
A010Count: integer;
begin
   A010Count := FRegistroA001.RegistroA010.Count -1;
   //
   Result := FRegistroA001.RegistroA010.Items[A010Count].RegistroA100.New;
end;

function TBloco_A.RegistroA110New: TRegistroA110;
var
A010Count: integer;
A100Count: integer;
begin
   A010Count := FRegistroA001.RegistroA010.Count -1;
   A100Count := FRegistroA001.RegistroA010.Items[A010Count].RegistroA100.Count -1;
   //
   Result := FRegistroA001.RegistroA010.Items[A010Count].RegistroA100.Items[A100Count].RegistroA110.New;
end;

function TBloco_A.RegistroA111New: TRegistroA111;
var
A010Count: integer;
A100Count: integer;
begin
   A010Count := FRegistroA001.RegistroA010.Count -1;
   A100Count := FRegistroA001.RegistroA010.Items[A010Count].RegistroA100.Count -1;
   //
   Result := FRegistroA001.RegistroA010.Items[A010Count].RegistroA100.Items[A100Count].RegistroA111.New;
end;

function TBloco_A.RegistroA120New: TRegistroA120;
var
A010Count: integer;
A100Count: integer;
begin
   A010Count := FRegistroA001.RegistroA010.Count -1;
   A100Count := FRegistroA001.RegistroA010.Items[A010Count].RegistroA100.Count -1;
   //
   Result := FRegistroA001.RegistroA010.Items[A010Count].RegistroA100.Items[A100Count].RegistroA120.New;
end;

function TBloco_A.RegistroA170New: TRegistroA170;
var
A010Count: integer;
A100Count: integer;
begin
   A010Count := FRegistroA001.RegistroA010.Count -1;
   A100Count := FRegistroA001.RegistroA010.Items[A010Count].RegistroA100.Count -1;
   //
   Result := FRegistroA001.RegistroA010.Items[A010Count].RegistroA100.Items[A100Count].RegistroA170.New;
end;

procedure TBloco_A.WriteRegistroA001 ;
begin
  if Assigned(FRegistroA001) then
  begin
     with FRegistroA001 do
     begin
        Add( LFill( 'A001' ) +
             LFill( Integer(IND_MOV), 0 ) ) ;

        if IND_MOV = imComDados then
        begin
          WriteRegistroA010(FRegistroA001) ;
        end;
     end;

     RegistroA990.QTD_LIN_A := RegistroA990.QTD_LIN_A + 1;
  end;
end;

procedure TBloco_A.WriteRegistroA010(RegA001: TRegistroA001) ;
var
intFor: Integer;
begin
  if Assigned(RegA001.RegistroA010) then
  begin
     for intFor := 0 to RegA001.RegistroA010.Count - 1 do
     begin
        with RegA001.RegistroA010.Items[intFor] do
        begin
          Add( LFill('A010') +
               LFill(FANTASIA) +
               LFill(CEP, 8) +
               LFill(ENDERECO) +
               LFill(NUM) +
               LFill(COMPL) +
               LFill(BAIRRO) +
               LFill(FONE, 10) +
               LFill(FAX, 10) +
               LFill(EMAIL) ) ;
        end;
        /// Registros FILHOS
        WriteRegistroA100( RegA001.RegistroA010.Items[intFor] );
        ///
        RegistroA990.QTD_LIN_A := RegistroA990.QTD_LIN_A + 1;
     end;
     /// Variavél para armazenar a quantidade de registro do tipo.
     FRegistroA010Count := FRegistroA010Count + RegA001.RegistroA010.Count;
  end;
end;

procedure TBloco_A.WriteRegistroA100(RegA010: TRegistroA010) ;
var
intFor: integer;
begin
  if Assigned(RegA010.RegistroA100) then
  begin
     for intFor := 0 to RegA010.RegistroA100.Count - 1 do
     begin
        with RegA010.RegistroA100.Items[intFor] do
        begin
           Check(funChecaUF(UF_ST),        '(0-0015) CONTRIBUINTE SUBSTITUTO: A UF "%s" digitada é inválido!', [UF_ST]);
           Check(funChecaIE(IE_ST, UF_ST), '(0-0015) CONTRIBUINTE SUBSTITUTO: A Inscrição Estadual "%s" digitada é inválida!', [IE_ST]);
           ///
           Add( LFill('A100') +
                LFill(UF_ST) +
                LFill(IE_ST) ) ;
        end;
        /// Registros FILHOS
        WriteRegistroA110( RegA010.RegistroA100.Items[intFor] );
        WriteRegistroA111( RegA010.RegistroA100.Items[intFor] );
        WriteRegistroA120( RegA010.RegistroA100.Items[intFor] );
        WriteRegistroA170( RegA010.RegistroA100.Items[intFor] );
        ///
        RegistroA990.QTD_LIN_A := RegistroA990.QTD_LIN_A + 1;
     end;
     /// Variavél para armazenar a quantidade de registro do tipo.
     FRegistroA100Count := FRegistroA100Count + RegA010.RegistroA100.Count;
  end;
end;

procedure TBloco_A.WriteRegistroA110(RegA100: TRegistroA100) ;
var
intFor: integer;
begin
  if Assigned(RegA100.RegistroA110) then
  begin
     for intFor := 0 to RegA010.RegistroA100.Count - 1 do
     begin
        with RegA100.RegistroA110.Items[intFor] do
        begin
          Check(funChecaCPF(CPF),     '(0-0100) CONTADOR: %s, o CPF "%s" digitado é inválido!', [NOME, CPF]);
          Check(funChecaCNPJ(CNPJ),   '(0-0100) CONTADOR: %s, o CNPJ "%s" digitado é inválido!', [NOME, CNPJ]);
   //       Check(funChecaCEP(CEP, Registro0000.UF), '(0-0100) CONTADOR: %s, o CEP "%s" digitada é inválido para a unidade de federação "%s"!', [NOME, CEP, Registro0000.UF]);
          Check(funChecaMUN(COD_MUN), '(0-0100) CONTADOR: %s, o código do município "%s" digitado é inválido!', [NOME, IntToStr(COD_MUN)]);
          Check(NOME <> '', '(0-0100) CONTADOR: O nome do contabilista/escritório é obrigatório!');
          ///
          Add( LFill('A110') +
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
               LFill(COD_MUN, 7) ) ;
          ///
          RegistroA990.QTD_LIN_A := RegistroA990.QTD_LIN_A + 1;
        end;
     end;
     /// Variavél para armazenar a quantidade de registro do tipo.
     FRegistroA110Count := FRegistroA110Count + RegA100.RegistroA110.Count;
  end;
end;

procedure TBloco_A.WriteRegistroA111(RegA100: TRegistroA100) ;
var
intFor: integer;
begin
  if Assigned(RegA100.RegistroA111) then
  begin
     for intFor := 0 to RegA100.RegistroA111.Count - 1 do
     begin
        with RegA100.RegistroA111.Items[intFor] do
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
          Add( LFill('A111') +
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
               LFill(BAIRRO) ) ;
        end;

        RegistroA990.QTD_LIN_A := RegistroA990.QTD_LIN_A + 1;
     end;
     /// Variavél para armazenar a quantidade de registro do tipo.
     FRegistroA111Count := FRegistroA111Count + RegA100.RegistroA111.Count;
  end;
end;

procedure TBloco_A.WriteRegistroA120(RegA100: TRegistroA100) ;
var
intFor: integer;
begin
  if Assigned(RegA100.RegistroA120) then
  begin
     for intFor := 0 to RegA100.RegistroA120.Count - 1 do
     begin
        with RegA100.RegistroA120.Items[intFor] do
        begin
          Check(((DT_ALT >= DT_INI) and (DT_ALT <= DT_FIN)),  '(0-0175) ALTERAÇÃO NO CADASTRO DE CLIENTES/FORNECEDORES: A data da alteração deve estar no intervalo de: %s a %s!', [DateToStr(DT_INI), DateToStr(DT_FIN)]);
          ///
          Add( LFill('A120') +
               LFill(DT_ALT) +
               LFill(NR_CAMPO) +
               LFill(CONT_ANT) ) ;
        end;
        RegistroA990.QTD_LIN_A := RegistroA990.QTD_LIN_A + 1;
     end;
     /// Variavél para armazenar a quantidade de registro do tipo.
     FRegistroA120Count := FRegistroA120Count + RegA100.RegistroA120.Count;
  end;
end;

procedure TBloco_A.WriteRegistroA170(RegA100: TRegistroA100) ;
var
intFor: integer;
begin
  if Assigned(RegA100.RegistroA170) then
  begin
     for intFor := 0 to RegA100.RegistroA170.Count - 1 do
     begin
        with RegA100.RegistroA170.Items[intFor] do
        begin
//          Check(Reg0001.Registro0190.LocalizaRegistro(UNID), '(0-0190) UNIDADE MEDIDA: A unidade de medida "%s" foi duplicada na lista de registros 0190!', [UNID]);

          Add( LFill('A170') +
               LFill(UNID) +
               LFill(DESCR) ) ;
        end;
        RegistroA990.QTD_LIN_A := RegistroA990.QTD_LIN_A + 1;
     end;
     /// Variavél para armazenar a quantidade de registro do tipo.
     FRegistroA170Count := FRegistroA170Count + RegA100.RegistroA170.Count;
  end;
end;

procedure TBloco_A.WriteRegistroA990 ;
begin
  if Assigned(RegistroA990) then
  begin
     with RegistroA990 do
     begin
       QTD_LIN_A := QTD_LIN_A + 1;
       ///
       Add( LFill('A990') +
            LFill(QTD_LIN_A,0) );
     end;
  end;
end;

end.
