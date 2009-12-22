unit Unit5; 

{$IFDEF FPC}
 {$mode objfpc}{$H+}
{$ENDIF}

interface

uses
  Classes, SysUtils, 
  {$IFDEF FPC}
    LResources, FileUtil, 
  {$ENDIF}
   Forms, Controls, Graphics, Dialogs, StdCtrls, Buttons, ExtCtrls,
  ACBrTEFDCliSiTef;

type

{$IFNDEF FPC}
 {$R *.dfm}
{$ENDIF}

{ TForm5 }

  TForm5 = class(TForm)
     BitBtn1 : TBitBtn;
     BitBtn2 : TBitBtn;
     Edit1 : TEdit;
     Panel1 : TPanel;
  private
    { private declarations }
  public
    { public declarations }
    TipoCampo : Integer;
    Operacao  : TACBrTEFDCliSiTefOperacaoCampo;
  end; 

var
  Form5 : TForm5; 

implementation

initialization
{$IFDEF FPC}
 {$I unit5.lrs}
{$ENDIF}
  
end.

