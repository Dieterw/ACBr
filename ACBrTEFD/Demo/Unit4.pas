unit Unit4; 

{$IFDEF FPC}
 {$mode objfpc}{$H+}
{$ENDIF}

interface

uses
  Classes, SysUtils,
  {$IFDEF FPC}
    LResources, FileUtil, 
  {$ENDIF}
  Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls, Buttons;

type

{$IFNDEF FPC}
 {$R *.dfm}
{$ENDIF}

  { TForm4 }

  TForm4 = class(TForm)
     BitBtn1 : TBitBtn;
     BitBtn2 : TBitBtn;
     ListBox1 : TListBox;
     Panel1 : TPanel;
     Panel2 : TPanel;
  private
    { private declarations }
  public
    { public declarations }
  end; 

var
  Form4 : TForm4; 

implementation

initialization
{$IFDEF FPC}
 {$I unit4.lrs}
{$ENDIF}

end.

