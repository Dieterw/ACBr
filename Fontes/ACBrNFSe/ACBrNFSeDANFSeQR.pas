{$I ACBr.inc}

unit ACBrNFSeDANFSeQR;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, QuickRpt, QRCtrls,
  {$IFDEF QReport_PDF}
     QRPDFFilt,
     QRPrntr,
  {$ENDIF}
  pnfsNFSe, ACBrNFSe, ACBrNFSeUtil, Printers;

type
  TfqrDANFSeQR = class(TForm)
    QRNFSe: TQuickRep;
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

    procedure qrlSemValorFiscalPrint(sender: TObject; var Value: String);
    procedure SetBarCodeImage ( ACode : String ; QRImage : TQRImage ) ;
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

implementation

uses
 MaskUtils;

var
 Printer: TPrinter;

{$R *.dfm}

class procedure TfqrDANFSeQR.Imprimir(ANFSe           : TNFSe;
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

   if FImpressora > ''
    then QRNFSe.PrinterSettings.PrinterIndex := Printer.Printers.IndexOf(FImpressora);

   if APreview
    then begin
     QRNFSe.PrinterSettings.Copies := FNumCopias;

     {$IFDEF QReport_PDF}
       QRNFSe.PrevShowSearch      := False;
       QRNFSe.PrevShowThumbs      := False;
       QRNFSe.PreviewInitialState := wsMaximized;
       QRNFSe.PrevInitialZoom     := qrZoomToWidth;
     {$ENDIF}

     QRNFSe.Prepare;
     QRNFSe.Preview;
    end
    else begin
     AfterPreview := True ;
     QRNFSe.PrinterSettings.Copies := FNumCopias;
     QRNFSe.Prepare;
     QRNFSe.Print;
    end;

  finally
   Free ;
  end ;
end;

class procedure TfqrDANFSeQR.SavePDF(AFile           : String;
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
{$IFDEF QReport_PDF}
var
 qf : TQRPDFDocumentFilter;
 i  : integer;
{$ENDIF}
begin
{$IFDEF QReport_PDF}
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

    for i := 0 to ComponentCount -1 do
     begin
      if (Components[i] is TQRShape) and (TQRShape(Components[i]).Shape = qrsRoundRect)
       then begin
        TQRShape(Components[i]).Shape := qrsRectangle;
        TQRShape(Components[i]).Pen.Width := 1;
       end;
      end;

    AfterPreview := True;
    QRNFSe.Prepare;
    qf := TQRPDFDocumentFilter.Create(AFile);
    qf.CompressionOn := False;
    QRNFSe.QRPrinter.ExportToFilter( qf );
    qf.Free;
   finally
    Free;
   end;
{$ENDIF}
end;

procedure TfqrDANFSeQR.qrlSemValorFiscalPrint(sender: TObject;
  var Value: String);
begin
  inherited;
 if FSemValorFiscal
  then Value := '';
end;

procedure TfqrDANFSeQR.SetBarCodeImage(ACode: String; QRImage: TQRImage);
//var
// b : TBarCode128c ;
begin
//   b := TBarCode128c.Create;
//      Width  := QRImage.Width ;
//   b.Code := ACode ;
//   b.PaintCodeToCanvas( ACode, QRImage.Canvas, QRImage.ClientRect );
//   b.free ;
end;

end.
