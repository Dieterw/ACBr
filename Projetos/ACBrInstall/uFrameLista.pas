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
|* 29/03/2012: Isaque Pinheiro / Régys Borges da Silveira
|*  - Criação e distribuição da Primeira Versao
*******************************************************************************}
unit uFrameLista;

interface

uses
  Generics.Collections,
  
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, 
  Dialogs, Buttons, ExtCtrls, StdCtrls;

type
  TPacotes = TList<TCheckBox>;

  TframePacotes = class(TFrame)
    pnlBotoesPacotes: TPanel;
    btnPacotesDesmarcarTodos: TSpeedButton;
    btnPacotesMarcarTodos: TSpeedButton;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    synapse_dpk: TCheckBox;
    ACBrComum_dpk: TCheckBox;
    ACBrDiversos_dpk: TCheckBox;
    ACBrSerial_dpk: TCheckBox;
    ACBrTCP_dpk: TCheckBox;
    ACBr_TEFD_dpk: TCheckBox;
    ACBr_Boleto_dpk: TCheckBox;
    ACBr_Sintegra_dpk: TCheckBox;
    ACBr_SPED_dpk: TCheckBox;
    ACBr_PAF_dpk: TCheckBox;
    ACBrOpenSSL_dpk: TCheckBox;
    ACBrCapicom_dpk: TCheckBox;
    PCN2_dpk: TCheckBox;
    ACBr_NFe2_dpk: TCheckBox;
    ACBr_CTe_dpk: TCheckBox;
    Label5: TLabel;
    ACBrNFeDanfeFR_dpk: TCheckBox;
    ACBr_BoletoFC_FR_dpk: TCheckBox;
    Label6: TLabel;
    ACBrCTeDacteFR_dpk: TCheckBox;
    Label7: TLabel;
    ACBrNFeDanfeQR_dpk: TCheckBox;
    ACBrNFeDanfeRL_dpk: TCheckBox;
    ACBrNFeDanfeRV_dpk: TCheckBox;
    ACBrCTeDacteQR_dpk: TCheckBox;
    ACBr_BoletoFC_Fortes_dpk: TCheckBox;
    ACBr_BoletoFC_Quick_dpk: TCheckBox;
    procedure btnPacotesMarcarTodosClick(Sender: TObject);
    procedure btnPacotesDesmarcarTodosClick(Sender: TObject);
    procedure VerificarCheckboxes(Sender: TObject);
  private
    FPacotes: TPacotes;
    FUtilizarBotoesMarcar: Boolean;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    function IsPacoteNF2(const ANomePacote: String): Boolean;

    property Pacotes: TPacotes read FPacotes write FPacotes;
  end;

implementation

uses
  StrUtils;

{$R *.dfm}

constructor TframePacotes.Create(AOwner: TComponent);
var
  I: Integer;
begin
  inherited;

  // variavel para controle do verificar checkboxes
  // utilizada para evitar estouro de pilha por conta da redundância
  // e também para que pacotes dependentes não atrapalhem a rotina
  FUtilizarBotoesMarcar := False;

  // lista de pacotes (checkboxes) disponiveis
  FPacotes := TPacotes.Create;

  // popular a lista de pacotes com os pacotes disponíveis
  // colocar todos os checkboxes disponíveis na lista
  FPacotes.Clear;
  for I := 0 to Self.ComponentCount - 1 do
  begin
    if Self.Components[I] is TCheckBox then
    begin
      if TCheckBox(Self.Components[I]).Tag = 0 then
        FPacotes.Add(TCheckBox(Self.Components[I]));
    end;
  end;
end;

destructor TframePacotes.Destroy;
begin
  FreeAndNil(FPacotes);

  inherited;
end;

function TframePacotes.IsPacoteNF2(const ANomePacote: String): Boolean;
const
  PACOTES_NF2: array [0..4] of String =
    ('PCN2.dpk', 'ACBr_NFe2.dpk', 'ACBr_CTe.dpk', 'ACBrNFeDanfeFRpkg.dpk', 'ACBrCTeDacteFRpkg.dpk');
begin
  Result := MatchText(ANomePacote, PACOTES_NF2);
end;

// botão para marcar todos os checkboxes
procedure TframePacotes.btnPacotesMarcarTodosClick(Sender: TObject);
var
  I: Integer;
begin
  FUtilizarBotoesMarcar := True;
  try
    for I := 0 to Self.ComponentCount -1 do
    begin
      if Self.Components[I] is TCheckBox then
      begin
        if TCheckBox(Self.Components[I]).Enabled then
          TCheckBox(Self.Components[I]).Checked := True;
      end;
    end;
  finally
    FUtilizarBotoesMarcar := False;
  end;
end;

// botão para desmarcar todos os checkboxes
procedure TframePacotes.btnPacotesDesmarcarTodosClick(Sender: TObject);
var
  I: Integer;
begin
  FUtilizarBotoesMarcar := True;
  try
    for I := 0 to Self.ComponentCount -1 do
    begin
      if Self.Components[I] is TCheckBox then
      begin
        if TCheckBox(Self.Components[I]).Enabled then
          TCheckBox(Self.Components[I]).Checked := False;
      end;
    end;
  finally
    FUtilizarBotoesMarcar := False;
  end;
end;

// rotina de verificação de dependência e marcação dos pacotes base
procedure TframePacotes.VerificarCheckboxes(Sender: TObject);
begin
  // pacotes base não podem ser desmarcados
  // instalação mínima do ACBr
  synapse_dpk.Checked      := True;
  ACBrComum_dpk.Checked    := True;
  ACBrDiversos_dpk.Checked := True;

  if not FUtilizarBotoesMarcar then
  begin
    // dependencias da NFe e CTe
    if (ACBr_NFe2_dpk.Checked) or (ACBr_CTe_dpk.Checked) then
    begin
      PCN2_dpk.Checked        := True;
      ACBrCapicom_dpk.Checked := True;
      ACBrOpenSSL_dpk.Checked := True;
    end;

    // dependencias do ACBrTEFD
    if not(ACBrTCP_dpk.Checked) and ACBr_TEFD_dpk.Checked  then
      ACBrTCP_dpk.Checked := True;

    // Dependencias do ACBrPaf
    if not(ACBr_SPED_dpk.Checked) and ACBr_PAF_dpk.Checked then
      ACBr_SPED_dpk.Checked := True;
  end;
end;

end.

{
  --------------------------------------
  -- LEMBRETE NÃO APAGAR POR ENQUANTO --
  --------------------------------------
  synapse.dpk
  ACBrComum.dpk
  ACBrDiversos.dpk

  ACBrSerial.dpk
  ACBrTCP.dpk
  ACBr_TEFD.dpk

  ACBr_Boleto.dpk
  ACBr_PAF.dpk
  ACBr_Sintegra.dpk
  ACBr_SPED.dpk

  ACBrCapicom.dpk
  ACBrOpenSSL.dpk
  ACBrNFe2\PCN2.dpk
  ACBrNFe2\ACBr_NFe2.dpk
  ACBrNFe2\ACBr_CTe.dpk

}
