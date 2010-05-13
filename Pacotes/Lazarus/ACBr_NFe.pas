{ This file was automatically created by Lazarus. Do not edit!
  This source is only used to compile and install the package.
 }

unit ACBr_NFe; 

interface

uses
      libxml2, libxmlsec, libxslt, ACBrNFe, ACBrNFeConfiguracoes, 
   ACBrNFeNotasFiscais, ACBrNFeReg, ACBrNFeUtil, ACBrNFeWebServices, 
   ACBrNFeDANFEClass, LazarusPackageIntf;

implementation

procedure Register; 
begin
  RegisterUnit('ACBrNFeReg', @ACBrNFeReg.Register); 
end; 

initialization
  RegisterPackage('ACBr_NFe', @Register); 
end.
