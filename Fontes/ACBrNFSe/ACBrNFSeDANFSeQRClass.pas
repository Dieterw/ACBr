{$I ACBr.inc}

unit ACBrNFSeDANFSeQRClass;

interface

uses
 Forms, SysUtils, Classes, pnfsNFSe, ACBrNFSeDANFSeClass;

type
  TACBrNFSeDANFSeQR = class( TACBrNFSeDANFSeClass )
   private
   public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure ImprimirDANFSe(NFSe : TNFSe = nil); override ;
    procedure ImprimirDANFSePDF(NFSe : TNFSe = nil); override ;
  end;

implementation

uses
 StrUtils, Dialogs, ACBrUtil, ACBrNFSe, ACBrNFSeUtil, ACBrNFSeDANFSeQRRetrato;

constructor TACBrNFSeDANFSeQR.Create(AOwner: TComponent);
begin
  inherited create( AOwner );
end;

destructor TACBrNFSeDANFSeQR.Destroy;
begin
  inherited Destroy ;
end;


procedure TACBrNFSeDANFSeQR.ImprimirDANFSe(NFSe : TNFSe = nil);
var
 i : Integer;
 fqrDANFSeQRRetrato : TfqrDANFSeQRRetrato;
begin
 fqrDANFSeQRRetrato := TfqrDANFSeQRRetrato.Create(Self);

 if NFSe = nil
  then begin
   for i:= 0 to TACBrNFSe(ACBrNFSe).NotasFiscais.Count-1 do
    begin
     fqrDANFSeQRRetrato.Imprimir(  TACBrNFSe(ACBrNFSe).NotasFiscais.Items[i].NFSe
                                 , Logo
                                 , Email
                                 , Fax
                                 , NumCopias
                                 , Sistema
                                 , Site
                                 , Usuario
                                 , MostrarPreview
                                 , MargemSuperior
                                 , MargemInferior
                                 , MargemEsquerda
                                 , MargemDireita
                                 , Impressora
                                 , PrestLogo
                                 , Prefeitura);
    end;
  end
  else fqrDANFSeQRRetrato.Imprimir(  NFSe
                                   , Logo
                                   , Email
                                   , Fax
                                   , NumCopias
                                   , Sistema
                                   , Site
                                   , Usuario
                                   , MostrarPreview
                                   , MargemSuperior
                                   , MargemInferior
                                   , MargemEsquerda
                                   , MargemDireita
                                   , Impressora
                                   , PrestLogo
                                   , Prefeitura);

 fqrDANFSeQRRetrato.Free;
end;

procedure TACBrNFSeDANFSeQR.ImprimirDANFSePDF(NFSe : TNFSe = nil);
var
 NomeArq : String;
 i : Integer;
 fqrDANFSeQRRetrato : TfqrDANFSeQRRetrato;
begin
 fqrDANFSeQRRetrato := TfqrDANFSeQRRetrato.Create(Self);

 if NFSe = nil
  then begin
   for i:= 0 to TACBrNFSe(ACBrNFSe).NotasFiscais.Count-1 do
    begin
//     NomeArq :=  trim(TACBrNFSe(ACBrNFSe).NotasFiscais.Items[i].NomeArq);
//     if NomeArq=''
//      then begin
       NomeArq := StringReplace(TACBrNFSe(ACBrNFSe).NotasFiscais.Items[i].NFSe.Numero,'NFSe', '', [rfIgnoreCase]);
       NomeArq := PathWithDelim(Self.PathPDF)+NomeArq+'.pdf';
//      end
//      else NomeArq := StringReplace(NomeArq,'-nfse.xml', '.pdf', [rfIgnoreCase]);

     fqrDANFSeQRRetrato.SavePDF( NomeArq
                               , TACBrNFSe(ACBrNFSe).NotasFiscais.Items[i].NFSe
                               , Logo
                               , Email
                               , Fax
                               , NumCopias
                               , Sistema
                               , Site
                               , Usuario
                               , MargemSuperior
                               , MargemInferior
                               , MargemEsquerda
                               , MargemDireita
                               , PrestLogo
                               , Prefeitura);
    end;
  end
  else begin
   NomeArq := StringReplace(NFSe.Numero,'NFSe', '', [rfIgnoreCase]);
   NomeArq := PathWithDelim(Self.PathPDF)+NomeArq+'.pdf';

   fqrDANFSeQRRetrato.SavePDF( NomeArq
                             , NFSe
                             , Logo
                             , Email
                             , Fax
                             , NumCopias
                             , Sistema
                             , Site
                             , Usuario
                             , MargemSuperior
                             , MargemInferior
                             , MargemEsquerda
                             , MargemDireita
                             , PrestLogo
                             , Prefeitura);
  end;

 fqrDANFSeQRRetrato.Free;
end;

end.
