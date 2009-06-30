{ This file was automatically created by Lazarus. do not edit!
  This source is only used to compile and install the package.
 }

unit ACBrNFePCN_LCL; 

interface

uses
    ACBrNFe, ACBrNFeConfiguracoes, pcnAuxiliar, pcnCabecalho, pcnCadEmiDFe, 
  pcnCancNFe, pcnConsCad, pcnConsReciNFe, pcnConsSitNFe, pcnConsStatServ, 
  pcnConversao, pcnEnvNFe, pcnGerador, pcnInutNFe, pcnLayoutTXT, pcnLeitor, 
  pcnModeloNFe, pcnNFe, pcnNFeR, pcnNFeW, pcnProcNFe, pcnRetAtuCadEmiDFe, 
  pcnRetCancNFe, pcnRetConsCad, pcnRetConsReciNFe, pcnRetConsSitNFe, 
  pcnRetConsStatServ, pcnRetEnvNFe, pcnRetInutNFe, pcnSignature, ACBrNFeUtil, 
  ACBrNFeWebServices, pcnAtuCadEmiDFe, ACBrNFeReg, ACBrNFeNotasFiscais, 
  libxslt, libxml2, libxmlsec, ACBrNFeDMLaz, LazarusPackageIntf;

implementation

procedure Register; 
begin
  RegisterUnit('ACBrNFeReg', @ACBrNFeReg.Register); 
end; 

initialization
  RegisterPackage('ACBrNFePCN_LCL', @Register); 
end.
