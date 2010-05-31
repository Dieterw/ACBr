unit dmecf;

interface

uses
  SysUtils, Classes, ACBrBase, ACBrECF;

type
  Tdm = class(TDataModule)
    ACBrECF1: TACBrECF;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dm: Tdm;

implementation

{$R *.dfm}

end.
