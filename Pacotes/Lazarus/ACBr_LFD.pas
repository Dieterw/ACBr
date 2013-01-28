{ This file was automatically created by Lazarus. Do not edit!
  This source is only used to compile and install the package.
 }

unit ACBr_LFD;

interface

uses
  ACBrLFD3505, ACBrLFDUtils, ACBrLFDBloco_0, ACBrLFDBloco_0_Class, 
  ACBrLFDBlocos, ACBrLFD, LazarusPackageIntf;

implementation

procedure Register;
begin
  RegisterUnit('ACBrLFD', @ACBrLFD.Register);
end;

initialization
  RegisterPackage('ACBr_LFD', @Register);
end.
