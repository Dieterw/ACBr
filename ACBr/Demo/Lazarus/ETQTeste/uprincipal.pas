unit UPrincipal;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, LResources, Forms, Controls, Graphics, Dialogs,
  StdCtrls, Buttons, ACBrBase, ACBrDevice, ACBrETQ;

type

  { TFPrincipal }

  TFPrincipal = class(TForm)
    ACBrETQ: TACBrETQ;
    cbModelo: TComboBox;
    Label1: TLabel;
    Label2: TLabel;
    cbPorta: TComboBox;
    eCopias: TEdit;
    Label3: TLabel;
    eAvanco: TEdit;
    Label4: TLabel;
    bEtqSimples: TButton;
    bEtqCarreiras: TButton;
    procedure bEtqSimplesClick(Sender: TObject);
    procedure bEtqCarreirasClick(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end; 

var
  FPrincipal: TFPrincipal;

implementation

procedure TFPrincipal.bEtqSimplesClick(Sender: TObject);
begin
with ACBrETQ do
   begin
   Modelo := TACBrETQModelo(cbModelo.ItemIndex);
   Porta := cbPorta.Text;
   Ativar;

   ImprimirTexto(orNormal, 2, '2', '2', 190, 5, 'BISCOITO MARILAN RECH 335G');
   ImprimirTexto(orNormal, 2, '2', '1', 158, 5, 'CHOC BRANCO');
   ImprimirBarras(orNormal, 'F', '2', '2', 32, 0, '7896003701685', 90);
   ImprimirTexto(orNormal, 3, '3', '2', 15, 300, 'R$');
   ImprimirTexto(orNormal, 3, '4', '4', 15, 450, '20.59');

   Imprimir(StrToInt(eCopias.Text), StrToInt(eAvanco.Text));
   Desativar;
   end;
end;

procedure TFPrincipal.bEtqCarreirasClick(Sender: TObject);
begin
with ACBrETQ do
   begin
   Modelo := TACBrETQModelo(cbModelo.ItemIndex);
   Porta := cbPorta.Text;
   Avanco := StrToInt(eAvanco.Text);
   Ativar;

   ImprimirTexto(orNormal, 2, '1', '2', 0180, 0015, 'BISCOITO REC 335G');
   ImprimirTexto(orNormal, 2, '1', '1', 0140, 0015, 'CHOC BRANCO');
   ImprimirBarras(orNormal, 'F', '2', '2', 0020, 0010, '7896003701685', 070);

   ImprimirTexto(orNormal, 2, '1', '2', 0180, 0315, 'BISCOITO RECH 335G');
   ImprimirTexto(orNormal, 2, '1', '1', 0140, 0315, 'CHOC BRANCO');
   ImprimirBarras(orNormal, 'F', '2', '2', 0020, 0315, '7896003701685', 070);

   ImprimirTexto(orNormal, 2, '1', '2', 0180, 0620, 'BISCOITO RECH 335G');
   ImprimirTexto(orNormal, 2, '1', '1', 0140, 0620, 'CHOC BRANCO');
   ImprimirBarras(orNormal, 'F', '2', '2', 0020, 0620, '7896003701685', 070);

   Imprimir(StrToInt(eCopias.Text));
   Desativar;
   end;
end;

initialization
  {$I uprincipal.lrs}

end.

