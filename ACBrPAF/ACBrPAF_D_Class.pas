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

unit ACBrPAF_D_Class;

interface

uses SysUtils, Classes, DateUtils, ACBrUtilTXT, ACBrPAFRegistros, ACBrPAF_D;

type
  /// TACBrPAF_D -
  TPAF_D = class(TACBrTXT)
  private
    FRegistroD1: TRegistroD1;       /// RegistroD1
    FRegistroD2: TRegistroD2List;   /// Lista de RegistroD2
    FRegistroD9: TRegistroD9;       /// RegistroD9
  protected
  public
    constructor Create(AOwner: TComponent); /// Create
    destructor Destroy; override; /// Destroy

    function WriteRegistroD1: AnsiString;
    function WriteRegistroD2: AnsiString;
    function WriteRegistroD9: AnsiString;

    property RegistroD1: TRegistroD1 read FRegistroD1 write FRegistroD1;
    property RegistroD2: TRegistroD2List read FRegistroD2 write FRegistroD2;
    property RegistroD9: TRegistroD9 read FRegistroD9 write FRegistroD9;
  end;

implementation

uses ACBrSPEDUtils;

{ TPAF_D }

constructor TPAF_D.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FRegistroD1  := TRegistroD1.Create;
  FRegistroD2  := TRegistroD2List.Create;
  FRegistroD9  := TRegistroD9.Create;

  FRegistroD9.TOT_REG := 0;
end;

destructor TPAF_D.Destroy;
begin
  FRegistroD1.Free;
  FRegistroD2.Free;
  FRegistroD9.Free;
  inherited;
end;

function TPAF_D.WriteRegistroD1: AnsiString;
begin
   if Assigned(RegistroD1) then
   begin
      with RegistroD1 do
      begin
        Check(funChecaCNPJ(CNPJ), '(D1) ESTABELECIMENTO: O CNPJ "%s" digitado é inválido!', [CNPJ]);
        Check(funChecaIE(IE, UF), '(D1) ESTABELECIMENTO: A Inscrição Estadual "%s" digitada é inválida!', [IE]);
        ///
        Result := LFill('D1') +
                  LFill(CNPJ, 14) +
                  RFill(IE, 14) +
                  RFill(IM, 14) +
                  RFill(RAZAOSOCIAL, 50) +
                  #13#10;
      end;
      ///
      RegistroD9.TOT_REG := RegistroD9.TOT_REG + 1;
   end;
end;

function TPAF_D.WriteRegistroD2: AnsiString;
var
intFor: integer;
strRegistroD2: AnsiString;
begin
  strRegistroD2 := '';

  if Assigned(RegistroD2) then
  begin
     for intFor := 0 to RegistroD2.Count - 1 do
     begin
        with RegistroD2.Items[intFor] do
        begin
          Check(funChecaCNPJ(RegistroD1.CNPJ), '(D2) DAV EMITIDOS: O CNPJ "%s" digitado é inválido!', [RegistroD1.CNPJ]);
          ///
          strRegistroD2 := strRegistroD2 + LFill('D2') +
                                           LFill(RegistroD1.CNPJ, 14) +
                                           RFill(NUM_FAB, 20) +
                                           RFill(MF_ADICIONAL, 1) +
                                           RFill(TIPO_ECF, 7) +
                                           RFill(MARCA_ECF, 20) +
                                           RFill(MODELO_ECF, 20) +
                                           RFill(COO, 6) +
                                           RFill(NUM_DAV, 13) +
                                           LFill(DT_DAV, 'yyyymmdd') +
                                           RFill(TIT_DAV, 30) +
                                           LFill(VLT_DAV, 8, 0) +
                                           #13#10;
        end;
        ///
        RegistroD9.TOT_REG := RegistroD9.TOT_REG + 1;
     end;
     Result := strRegistroD2;
  end;
end;

function TPAF_D.WriteRegistroD9: AnsiString;
begin
   if Assigned(RegistroD9) then
   begin
      with RegistroD9 do
      begin
        Check(funChecaCNPJ(RegistroD1.CNPJ),            '(D9) TOTALIZAÇÃO: O CNPJ "%s" digitado é inválido!', [RegistroD1.CNPJ]);
        Check(funChecaIE(RegistroD1.IE, RegistroD1.UF), '(D9) TOTALIZAÇÃO: A Inscrição Estadual "%s" digitada é inválida!', [RegistroD1.IE]);
        ///
        Result := LFill('D9') +
                  LFill(RegistroD1.CNPJ) +
                  LFill(RegistroD1.IE) +
                  LFill(TOT_REG, 6, 0) +
                  #13#10;
      end;
   end;
end;

end.
