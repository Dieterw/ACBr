{ This file was automatically created by Lazarus. Do not edit!
  This source is only used to compile and install the package.
 }

unit ACBr_SPED ; 

interface

uses
   ACBrSped, ACBrSpedUtils, ACBrEFDBloco_0, ACBrEFDBloco_0_Class, 
   ACBrEFDBloco_1, ACBrEFDBloco_1_Class, ACBrEFDBloco_9, ACBrEFDBloco_9_Class, 
   ACBrEFDBloco_C, ACBrEFDBloco_C_Class, ACBrEFDBloco_D, ACBrEFDBloco_D_Class, 
   ACBrEFDBloco_E, ACBrEFDBloco_E_Class, ACBrEFDBloco_H, ACBrEFDBloco_H_Class, 
   ACBrEFDBlocos, ACBrSpedFiscal, ACBrECDBloco_0, ACBrECDBloco_0_Class, 
   ACBrECDBloco_9, ACBrECDBloco_9_Class, ACBrECDBloco_I, ACBrECDBloco_I_Class, 
   ACBrECDBloco_J, ACBrECDBloco_J_Class, ACBrECDBlocos, ACBrSpedContabil, 
   ACBrEFDBloco_G_Class, ACBrEFDBloco_G, ACBrEPCBloco_0, ACBrEPCBloco_0_Class, 
   ACBrEPCBloco_1, ACBrEPCBloco_1_Class, ACBrEPCBloco_9, ACBrEPCBloco_9_Class, 
   ACBrEPCBloco_A, ACBrEPCBloco_A_Class, ACBrEPCBloco_C, ACBrEPCBloco_C_Class, 
   ACBrEPCBloco_D, ACBrEPCBloco_D_Class, ACBrEPCBloco_F, ACBrEPCBloco_F_Class, 
   ACBrEPCBloco_M, ACBrEPCBloco_M_Class, ACBrSpedPisCofins, LazarusPackageIntf;

implementation

procedure Register ; 
begin
  RegisterUnit('ACBrSpedFiscal', @ACBrSpedFiscal.Register) ; 
  RegisterUnit('ACBrSpedContabil', @ACBrSpedContabil.Register) ; 
  RegisterUnit('ACBrSpedPisCofins', @ACBrSpedPisCofins.Register) ; 
end ; 

initialization
  RegisterPackage('ACBr_SPED', @Register) ; 
end.
