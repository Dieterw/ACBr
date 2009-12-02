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

unit ACBrECDBloco_I_Class;

interface

uses SysUtils, Classes, DateUtils, ACBrSped, ACBrBloco_I;

type
  /// TBLOCO_I -
  TBLOCO_I = class(TACBrSPED)
  private
    FRegistroI001: TRegistroI001;      /// BLOCO I - RegistroI001
    FRegistroI010: TRegistroI010;      /// BLOCO I - RegistroI010
    FRegistroI990: TRegistroI990;      /// BLOCO I - RegistroI990
  public
    constructor Create(AOwner: TComponent); override; /// Create
    destructor Destroy; override; /// Destroy
    procedure LimpaRegistros;

    function WriteRegistroI001: AnsiString;
    function WriteRegistroI010: AnsiString;
    function WriteRegistroI990: AnsiString;

    property RegistroI001: TRegistroI001 read FRegistroI001 write FRegistroI001;
    property RegistroI010: TRegistroI010 read FRegistroI010 write FRegistroI010;
    property RegistroI990: TRegistroI990 read FRegistroI990 write FRegistroI990;
  end;

implementation

{ TBLOCO_I }

constructor TBLOCO_I.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FRegistroI001 := TRegistroI001.Create;
  FRegistroI010 := TRegistroI010.Create;
  FRegistroI990 := TRegistroI990.Create;

  FRegistroI990.QTD_LIN_I := 0;
end;

destructor TBLOCO_I.Destroy;
begin
  FRegistroI001.Free;
  FRegistroI010.Free;
  FRegistroI990.Free;
  inherited;
end;

procedure TBLOCO_I.LimpaRegistros;
begin

  FRegistroI990.QTD_LIN_I := 0;
end;

function TBLOCO_I.WriteRegistroI001: AnsiString;
begin
  Result := '';

  if Assigned(RegistroI001) then
  begin
     with RegistroI001 do
     begin
       ///
       Result := LFill('I001') +
                 Delimitador +
                 #13#10;
       ///
       RegistroI990.QTD_LIN_I := RegistroI990.QTD_LIN_I + 1;
     end;
  end;
end;

function TBLOCO_I.WriteRegistroI010: AnsiString;
begin
  Result := '';

  if Assigned(RegistroI010) then
  begin
     with RegistroI010 do
     begin
       ///
       Result := LFill('I010') +
                 Delimitador +
                 #13#10;
       ///
       RegistroI990.QTD_LIN_I := RegistroI990.QTD_LIN_I + 1;
     end;
  end;
end;

function TBLOCO_I.WriteRegistroI990: AnsiString;
begin
  Result := '';

  if Assigned(RegistroI990) then
  begin
     with RegistroI990 do
     begin
       QTD_LIN_I := QTD_LIN_I + 1;
       ///
       Result := LFill('I990') +
                 LFill(QTD_LIN_I,0) +
                 Delimitador +
                 #13#10;
     end;
  end;
end;

end.
