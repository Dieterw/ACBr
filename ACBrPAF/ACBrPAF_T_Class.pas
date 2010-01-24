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

unit ACBrPAF_T_Class;

interface

uses SysUtils, Classes, DateUtils, ACBrUtilTXT, ACBrPAFRegistros, ACBrPAF_T;

type
  /// TPAF_T -
  TPAF_T = class(TACBrTXT)
  private
    FRegistroT1: TRegistroT1;       /// RegistroT1
    FRegistroT2: TRegistroT2List;   /// Lista de RegistroT2
    FRegistroT9: TRegistroT9;       /// RegistroT9
  protected
  public
    constructor Create(AOwner: TComponent); /// Create
    destructor Destroy; override; /// Destroy

    function WriteRegistroT1: string;
    function WriteRegistroT2: string;
    function WriteRegistroT9: string;

    property RegistroT1: TRegistroT1 read FRegistroT1 write FRegistroT1;
    property RegistroT2: TRegistroT2List read FRegistroT2 write FRegistroT2;
    property RegistroT9: TRegistroT9 read FRegistroT9 write FRegistroT9;
  end;

implementation

uses ACBrSPEDUtils;

{ TPAF_T }

constructor TPAF_T.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FRegistroT1 := TRegistroT1.Create;
  FRegistroT2 := TRegistroT2List.Create;
  FRegistroT9 := TRegistroT9.Create;

  FRegistroT9.TOT_REG := 0;
end;

destructor TPAF_T.Destroy;
begin
  FRegistroT1.Free;
  FRegistroT2.Free;
  FRegistroT9.Free;
  inherited;
end;

function TPAF_T.WriteRegistroT1: string;
begin
   if Assigned(RegistroT1) then
   begin
      with RegistroT1 do
      begin
        Check(funChecaCNPJ(CNPJ), '(T1) ESTABELECIMENTO: O CNPJ "%s" digitado é inválido!', [CNPJ]);
        Check(funChecaIE(IE, UF), '(T1) ESTABELECIMENTO: A Inscrição Estadual "%s" digitada é inválida!', [IE]);
        ///
        Result := LFill('T1') +
                  LFill(CNPJ, 14) +
                  RFill(IE, 14) +
                  RFill(IM, 14) +
                  RFill(RAZAOSOCIAL, 50) +
                  #13#10;
      end;
      ///
      RegistroT9.TOT_REG := RegistroT9.TOT_REG + 1;
   end;
end;

function TPAF_T.WriteRegistroT2: string;
var
intFor: integer;
strRegistroT2: string;
begin
  strRegistroT2 := '';

  if Assigned(RegistroT2) then
  begin
     for intFor := 0 to RegistroT2.Count - 1 do
     begin
        with RegistroT2.Items[intFor] do
        begin
          Check(funChecaCNPJ(RegistroT1.CNPJ), '(T2) ESTOQUE: O CNPJ "%s" digitado é inválido!', [RegistroT1.CNPJ]);
          ///
          strRegistroT2 := strRegistroT2 + LFill('T2') +
                                           LFill(RegistroT1.CNPJ, 14) +
                                           LFill(DT_MOV, 'yyyymmdd') +
                                           RFill(SERIE, 2) +
                                           LFill(NUM_BILH_I, 6) +
                                           LFill(NUM_BILH_F, 6) +
                                           RFill(NUM_ECF, 20) +
                                           LFill(CRZ, 6) +
                                           RFill(CFOP, 4) +
                                           LFill(VL_CONT, 13, 2) +
                                           LFill(VL_BASECALC, 13, 2) +
                                           LFill(ALIQ, 4) +
                                           LFill(VL_IMPOSTO, 13, 2) +
                                           LFill(VL_ISENTAS, 13, 2) +
                                           LFill(VL_OUTRAS, 13, 2) +
                                           #13#10;
        end;
        ///
        RegistroT9.TOT_REG := RegistroT9.TOT_REG + 1;
     end;
     Result := strRegistroT2;
  end;
end;

function TPAF_T.WriteRegistroT9: string;
begin
   if Assigned(RegistroT9) then
   begin
      with RegistroT9 do
      begin
        Check(funChecaCNPJ(RegistroT1.CNPJ),            '(T9) TOTALIZAÇÃO: O CNPJ "%s" digitado é inválido!', [RegistroT1.CNPJ]);
        Check(funChecaIE(RegistroT1.IE, RegistroT1.UF), '(T9) TOTALIZAÇÃO: A Inscrição Estadual "%s" digitada é inválida!', [RegistroT1.IE]);
        ///
        Result := LFill('T9') +
                  LFill(RegistroT1.CNPJ) +
                  LFill(RegistroT1.IE) +
                  LFill(TOT_REG, 6, 0) +
                  #13#10;
      end;
   end;
end;

end.
