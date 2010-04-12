{******************************************************************************}
{ Projeto: Componentes ACBr                                                    }
{  Biblioteca multiplataforma de componentes Delphi para interação com equipa- }
{ mentos de Automação Comercial utilizados no Brasil                           }
{                                                                              }
{ Direitos Autorais Reservados (c) 2007   Maicon da Silva Evangeslista         }
{                                                                              }
{ Colaboradores nesse arquivo:            Daniel Simões de Almeida             }
{                                                                              }
{   Código original por Valdir Stiebe Junior-valdir@dype.com.br-outubro/2006   }
{   Componente finalizado por Maicon da Silva Evangeslista-maiconsi@hotmail.com}
{  em julho/2007...                                                            }
{                                                                              }
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
{ http://www.opensource.org/licenses/gpl-license.php                           }
{                                                                              }
{ Maicon da Silva Evangelista  -  maiconsi@hotmail.com                         }
{              Rua Marechal Rondon, 866 - Lucélia - SP - 17780-000             }
{                                                                              }
{******************************************************************************}

{******************************************************************************
|* Historico
|*
|* Código original por Valdir Stiebe Junior - valdir@dype.com.br - outubro/2007
|*
|* 03/04/2008: Jhony Alceu Pereira (JhonyStein)
|*  - Ao fechar a janela as vezes ela continuava na memória
*******************************************************************************}
{$I ACBr.inc}
unit frm_TimedMessage;

interface

uses
  {$IFDEF MSWINDOWS}
  Windows,
  {$ENDIF}
  {$IFDEF FPC}
  LResources,
  {$ENDIF}
  Messages, SysUtils,
  Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls ;

type
  TfrmTimedMessage = class(TForm)
    Timer: TTimer;
    btnOK: TButton;
    lblMessage: TLabel;
    procedure TimerTimer(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
  private
    Freeing: Boolean;
    FTimeout: Integer;
    FStartTime: TDateTime;
    procedure DoFree;
  public
    constructor Create(AOwner: TComponent); override;
    class procedure ShowMessage(AMessage: string; ATimeInSeconds: Integer = 0; ACaption: string = '');
    property StartTime: TDateTime read FStartTime write FStartTime;
    property Timeout: Integer read FTimeout write FTimeout;
  end;

implementation

Uses {$IFDEF COMPILER6_UP}
       DateUtils 
     {$ELSE}
       ACBrD5
     {$ENDIF} ;

{$IFNDEF FPC}
{$R *.dfm}
{$ENDIF}

{ TfrmTimedMessage }

constructor TfrmTimedMessage.Create(AOwner: TComponent);
begin
  //PopupParent := Application.MainForm;
  inherited;
  Freeing := False;
  Timer.Enabled := False;
  Timer.Interval := 500; // meio segundo, hardcoded mesmo, está mais do que bom
end;

class procedure TfrmTimedMessage.ShowMessage(AMessage: string;
  ATimeInSeconds: Integer; ACaption: string);
begin
   with Self.Create(nil) do
   begin
      FTimeout := ATimeInSeconds;
      
      if Trim(ACaption) = '' then
         Caption := Application.Title
      else
         Caption := ACaption;

      lblMessage.Caption := AMessage;
      StartTime := Now;

      if ATimeInSeconds = 0 then
         ShowModal
      else
      begin
         btnOK.Visible := False;
         Show;
      end;

      if not Freeing then
      begin
         Application.ProcessMessages;
         BringToFront;
         if FTimeout > 0 then
            Timer.Enabled := True;
      end;
   end;
end;

procedure TfrmTimedMessage.TimerTimer(Sender: TObject);
begin
  Application.ProcessMessages;
  Caption := Format('Atenção - %d s', [Timeout - SecondsBetween(StartTime, Now)]);
  if SecondsBetween(StartTime, Now) >= Timeout then
    DoFree;
end;

procedure TfrmTimedMessage.btnOKClick(Sender: TObject);
begin
  Timer.Enabled := False;
  DoFree;
end;

procedure TfrmTimedMessage.DoFree;
begin
  if not Freeing then
  begin
    Freeing := True;
    ModalResult := mrOk;
    Timer.Enabled := False;
    btnOK.Enabled := False;
    Self.Hide;
    Self.Close;
  end;
end;

procedure TfrmTimedMessage.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   Action := caFree;
end;

procedure TfrmTimedMessage.FormShow(Sender: TObject);
begin
   Application.BringToFront;
end;

{$IFDEF FPC}
initialization
  {$I frm_timedmessage.lrs}
{$ENDIF}

end.

