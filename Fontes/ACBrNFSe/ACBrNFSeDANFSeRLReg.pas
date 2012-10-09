{$I ACBr.inc}

unit ACBrNFSeDANFSeRLReg;

interface

uses
  SysUtils, Classes, Dialogs, ACBrNFSeDANFSeRLClass;

procedure Register;

implementation

{$IFNDEF FPC}
   {$R ACBrNFSe.dcr}
{$ENDIF}

procedure Register;
begin
  RegisterComponents('ACBr', [TACBrNFSeDANFSeRL]);
end;
initialization
{$IFDEF FPC}
//   {$i acbrNFSepcn_lcl.lrs}
{$ENDIF}

end.
