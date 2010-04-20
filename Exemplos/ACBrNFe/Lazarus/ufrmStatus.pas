unit ufrmStatus;

{$mode objfpc}

interface

uses
  Classes, SysUtils, FileUtil, LResources, Forms, Controls, Graphics, Dialogs,
  StdCtrls, ExtCtrls;

type
  TfrmStatus = class(TForm)
    Panel1: TPanel;
    lbl1: TLabel;
    lblStatus: TLabel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmStatus: TfrmStatus;

implementation

initialization
  {$I ufrmStatus.lrs}

end.
