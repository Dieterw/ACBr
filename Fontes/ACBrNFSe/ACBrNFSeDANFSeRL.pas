{$I ACBr.inc}

unit ACBrNFSeDANFSeRL;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls,
  pnfsNFSe, ACBrNFSe, ACBrNFSeUtil, Printers, RLPrinters, RLFilters, RLPDFFilter, RLReport;

type
  TfrlDANFSeRL = class(TForm)
    RLNFSe: TRLReport;
    RLPDFFilter1: TRLPDFFilter;
  private
    { Private declarations }
  protected
    //BarCode : TBarCode128c ;
    FACBrNFSe       : TACBrNFSe;
    FNFSe           : TNFSe;
    FLogo           : String;
    FEmail          : String;
    FFax            : String;
    FNumCopias      : Integer;
    FSistema        : String;
    FSite           : String;
    FUsuario        : String;
    AfterPreview    : Boolean;
    ChangedPos      : Boolean;
    FSemValorFiscal : Boolean;
    FMargemSuperior : double;
    FMargemInferior : double;
    FMargemEsquerda : double;
    FMargemDireita  : double;
    FImpressora     : String;
    FPrestLogo      : String;
    FPrefeitura     : String;

    procedure frlSemValorFiscalPrint(sender: TObject; var Value: String);
    procedure SetBarCodeImage ( ACode : String ; RLImage : TRLImage ) ;
  public
    { Public declarations }
    class procedure Imprimir(ANFSe           : TNFSe;
                             ALogo           : String  = '';
                             AEmail          : String  = '';
                             AFax            : String  = '';
                             ANumCopias      : Integer = 1;
                             ASistema        : String  = '';
                             ASite           : String  = '';
                             AUsuario        : String  = '' ;
                             APreview        : Boolean = True;
                             AMargemSuperior : Double  = 0.8;
                             AMargemInferior : Double  = 0.8;
                             AMargemEsquerda : Double  = 0.6;
                             AMargemDireita  : Double  = 0.51;
                             AImpressora     : String  = '';
                             APrestLogo      : String  = '';
                             APrefeitura     : String  = '');

    class procedure SavePDF(AFile           : String;
                            ANFSe           : TNFSe;
                            ALogo           : String  = '';
                            AEmail          : String  = '';
                            AFax            : String  = '';
                            ANumCopias      : Integer = 1;
                            ASistema        : String  = '';
                            ASite           : String  = '';
                            AUsuario        : String  = '';
                            AMargemSuperior : Double  = 0.8;
                            AMargemInferior : Double  = 0.8;
                            AMargemEsquerda : Double  = 0.6;
                            AMargemDireita  : Double  = 0.51;
                            APrestLogo      : String  = '';
                            APrefeitura     : String  = '');
  end;

var
  frlDANFSeRL: TfrlDANFSeRL;

implementation

uses
 MaskUtils;

var
 Printer: TPrinter;

{$R *.dfm}

{ TfrlDANFSeRL }

procedure TfrlDANFSeRL.frlSemValorFiscalPrint(sender: TObject;
  var Value: String);
begin
 if FSemValorFiscal
  then Value := '';
end;

class procedure TfrlDANFSeRL.Imprimir(ANFSe: TNFSe; ALogo, AEmail, AFax: String;
  ANumCopias: Integer; ASistema, ASite, AUsuario: String; APreview: Boolean;
  AMargemSuperior, AMargemInferior, AMargemEsquerda, AMargemDireita: Double;
  AImpressora, APrestLogo, APrefeitura: String);
begin
 with Create ( nil ) do
  try
   FNFSe           := ANFSe;
   FLogo           := ALogo;
   FEmail          := AEmail;
   FFax            := AFax;
   FNumCopias      := ANumCopias;
   FSistema        := ASistema;
   FSite           := ASite;
   FUsuario        := AUsuario;
   FMargemSuperior := AMargemSuperior;
   FMargemInferior := AMargemInferior;
   FMargemEsquerda := AMargemEsquerda;
   FMargemDireita  := AMargemDireita;
   FImpressora     := AImpressora;
   FPrestLogo      := APrestLogo;
   FPrefeitura     := APrefeitura;

   Printer := TPrinter.Create;

   if FImpressora > '' then
     RLPrinter.PrinterName := FImpressora;

   if FNumCopias > 0 then
     RLPrinter.Copies := FNumCopias
   else
     RLPrinter.Copies := 1;

   if APreview = True then
     RLNFSe.PreviewModal
   else
     RLNFSe.Print;

  finally
   Free ;
  end ;
end;

class procedure TfrlDANFSeRL.SavePDF(AFile: String; ANFSe: TNFSe; ALogo, AEmail,
  AFax: String; ANumCopias: Integer; ASistema, ASite, AUsuario: String;
  AMargemSuperior, AMargemInferior, AMargemEsquerda, AMargemDireita: Double;
  APrestLogo, APrefeitura: String);
begin
  with Create ( nil ) do
   try
    FNFSe           := ANFSe;
    FLogo           := ALogo;
    FEmail          := AEmail;
    FFax            := AFax;
    FNumCopias      := ANumCopias;
    FSistema        := ASistema;
    FSite           := ASite;
    FUsuario        := AUsuario;
    FMargemSuperior := AMargemSuperior;
    FMargemInferior := AMargemInferior;
    FMargemEsquerda := AMargemEsquerda;
    FMargemDireita  := AMargemDireita;
    FPrestLogo      := APrestLogo;
    FPrefeitura     := APrefeitura;

    with RLPDFFilter1.DocumentInfo do
      begin
        Title := 'NFSe - ' + FNFSe.Numero;
        KeyWords := 'Número:' + FNFSe.Numero +
                    '; Data de emissão: ' + FormatDateTime('dd/mm/yyyy', FNFSe.DataEmissao) +
                    '; Tomador: ' + FNFSe.Tomador.RazaoSocial +
                    '; CNPJ: ' + FNFSe.Tomador.IdentificacaoTomador.CpfCnpj +
                    '; Valor total: ' + FormatFloat('###,###,###,###,##0.00', FNFse.Servico.Valores.ValorServicos);
      end;

      RLNFSe.SaveToFile(AFile);
   finally
    Free;
   end;
end;

procedure TfrlDANFSeRL.SetBarCodeImage(ACode: String; RLImage : TRLImage);
begin

end;

end.
