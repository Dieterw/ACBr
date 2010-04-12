unit Unit4; 

{$IFDEF FPC}
 {$mode objfpc}{$H+}
{$ENDIF}

interface

uses
  Classes, SysUtils,
  Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls, Buttons;

type

{$IFNDEF FPC}
 {$R *.dfm}
{$ELSE}
 {$R *.lfm}
{$ENDIF}

  { TForm4 }

  TForm4 = class(TForm)
     BitBtn1 : TBitBtn;
     BitBtn2 : TBitBtn;
     BitBtn3: TBitBtn;
     ListBox1 : TListBox;
     Panel1 : TPanel;
     Panel2 : TPanel;
     procedure FormShow(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end; 

var
  Form4 : TForm4; 

implementation

{ TForm4 }

procedure TForm4.FormShow(Sender: TObject);
begin
   ListBox1.SetFocus;
   if ListBox1.Items.Count > 0 then
      ListBox1.ItemIndex := 0 ;
end;

end.

