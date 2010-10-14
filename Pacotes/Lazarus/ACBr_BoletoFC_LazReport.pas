{ This file was automatically created by Lazarus. Do not edit!
  This source is only used to compile and install the package.
 }

unit ACBr_BoletoFC_LazReport ; 

interface

uses
  ACBrBoletoFCLazReport, LazarusPackageIntf;

implementation

procedure Register ; 
begin
  RegisterUnit('ACBrBoletoFCLazReport', @ACBrBoletoFCLazReport.Register) ; 
end ; 

initialization
  RegisterPackage('ACBr_BoletoFC_LazReport', @Register) ; 
end.
