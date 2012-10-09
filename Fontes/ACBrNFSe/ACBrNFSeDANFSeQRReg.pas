{$I ACBr.inc}

unit ACBrNFSeDANFSeQRReg;

interface

uses
  SysUtils, Classes, ACBrNFSeDANFSeQRClass, 
  {$IFDEF VisualCLX} QDialogs {$ELSE} Dialogs{$ENDIF},
  {$IFDEF FPC}
     LResources, LazarusPackageIntf, PropEdits, componenteditors
  {$ELSE}
    {$IFNDEF COMPILER6_UP}
       DsgnIntf
    {$ELSE}
       DesignIntf,
       DesignEditors
    {$ENDIF}
  {$ENDIF} ;

procedure Register;

implementation

{$IFNDEF FPC}
   {$R ACBrNFSe.dcr}
{$ENDIF}

procedure Register;
begin
  RegisterComponents('ACBr', [TACBrNFSeDANFSeQR]);
end;
initialization
{$IFDEF FPC}
//   {$i acbrNFSepcn_lcl.lrs}
{$ENDIF}

end.
