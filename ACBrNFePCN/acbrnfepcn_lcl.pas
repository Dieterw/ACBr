{ This file was automatically created by Lazarus. do not edit ! 
  This source is only used to compile and install the package.
 }

unit ACBrNFePCN_LCL; 

interface

uses
      ACBrNFe, ACBrNFeConfiguracoes, pcnAuxiliar, pcnCabecalho, pcnConversao, 
   pcnGerador, pcnLeitor, pcnSignature, ACBrNFeUtil, ACBrNFeWebServices, 
   ACBrNFeReg, ACBrNFeNotasFiscais, libxslt, libxml2, libxmlsec, ACBrNFeDMLaz, 
   LazarusPackageIntf;

implementation

procedure Register; 
begin
  RegisterUnit( 'ACBrNFeReg' , @ACBrNFeReg.Register); 
end; 

initialization
  RegisterPackage( 'ACBrNFePCN_LCL' , @Register); 
end.
