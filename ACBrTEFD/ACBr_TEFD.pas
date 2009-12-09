{ This file was automatically created by Lazarus. do not edit ! 
  This source is only used to compile and install the package.
 }

unit ACBr_TEFD; 

interface

uses
      ACBrTEFDClass, ACBrTEFD, ACBrTEFDHiper, ACBrTEFDCliSiTef, ACBrTEFDDial, 
   ACBrTEFDDisc, LazarusPackageIntf;

implementation

procedure Register; 
begin
  RegisterUnit( 'ACBrTEFD' , @ACBrTEFD.Register); 
end; 

initialization
  RegisterPackage( 'ACBr_TEFD' , @Register); 
end.
