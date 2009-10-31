{ This file was automatically created by Lazarus. do not edit ! 
  This source is only used to compile and install the package.
 }

unit ACBr_SPEDFiscal; 

interface

uses
    ACBrSpedUtils, ACBrBloco_0, ACBrBloco_0_Class, ACBrBloco_1, 
  ACBrBloco_1_Class, ACBrBloco_9, ACBrBloco_9_Class, ACBrBloco_C, 
  ACBrBloco_C_Class, ACBrBloco_D, ACBrBloco_D_Class, ACBrBloco_E, 
  ACBrBloco_E_Class, ACBrBloco_H, ACBrBloco_H_Class, ACBrBlocos, ACBrSped, 
  ACBrSpedFiscal, LazarusPackageIntf;

implementation

procedure Register; 
begin
  RegisterUnit( 'ACBrSpedFiscal' , @ACBrSpedFiscal.Register); 
end; 

initialization
  RegisterPackage( 'ACBr_SPEDFiscal' , @Register); 
end.
