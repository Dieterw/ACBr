{******************************************************************************}
{ Projeto: Componentes ACBr                                                    }
{  Biblioteca multiplataforma de componentes Delphi para interação com equipa- }
{ mentos de Automação Comercial utilizados no Brasil                           }
{                                                                              }
{ Direitos Autorais Reservados (c) 2009   http://acbr.sf.net                   }
{                                                                              }
{ Colaboradores nesse arquivo: Juliana Rodrigues Prado,                        }
{                              Paulo Henrique M. Gurgel, Daniel Simoes Almeida }
{                                                                              }
{  Você pode obter a última versão desse arquivo na pagina do  Projeto ACBr    }
{ Componentes localizado em      http://www.sourceforge.net/projects/acbr      }
{                                                                              }
{  Esta biblioteca é software livre; você pode redistribuí-la e/ou modificá-la }
{ sob os termos da Licença Pública Geral Menor do GNU conforme publicada pela  }
{ Free Software Foundation; tanto a versão 2.1 da Licença, ou (a seu critério) }
{ qualquer versão posterior.                                                   }
{                                                                              }
{  Esta biblioteca é distribuída na expectativa de que seja útil, porém, SEM   }
{ NENHUMA GARANTIA; nem mesmo a garantia implícita de COMERCIABILIDADE OU      }
{ ADEQUAÇÃO A UMA FINALIDADE ESPECÍFICA. Consulte a Licença Pública Geral Menor}
{ do GNU para mais detalhes. (Arquivo LICENÇA.TXT ou LICENSE.TXT)              }
{                                                                              }
{  Você deve ter recebido uma cópia da Licença Pública Geral Menor do GNU junto}
{ com esta biblioteca; se não, escreva para a Free Software Foundation, Inc.,  }
{ no endereço 59 Temple Street, Suite 330, Boston, MA 02111-1307 USA.          }
{ Você também pode obter uma copia da licença em:                              }
{ http://www.opensource.org/licenses/lgpl-license.php                          }
{                                                                              }
{ Daniel Simões de Almeida  -  daniel@djsystem.com.br  -  www.djsystem.com.br  }
{              Praça Anita Costa, 34 - Tatuí - SP - 18270-410                  }
{                                                                              }
{******************************************************************************}

{******************************************************************************
|* Historico
|*
|* 05/07/2010: Paulo Henrique Moreira Gurgel
|*  - Criação da unit para quickReport
******************************************************************************}
{$I ACBr.inc}

unit ACBrBoletoFCQuickFr;

interface

uses
  SysUtils, StdCtrls, Classes, Graphics, Controls, Forms, Dialogs, ACBrBoleto,
  QRMultiExport, QRCtrls, QuickRpt, ExtCtrls, QRExport, ACBrBarCode ;

const
  CACBrBoletoFCQuick_Versao = '0.0.8a' ;

type

  { TACBrBoletoFCQuickFr }
  TACBrBoletoFCQuick = class(TACBrBoletoFCClass)
  private
    { Private declarations }
  public
    { Public declarations }
    Constructor Create(AOwner: TComponent); override;

    procedure Imprimir; override;
  end;

  TACBrBoletoFCQuickFr = class(TForm)
    LayoutBoleto: TQuickRep;
    RLBandDatail: TQRBand;
    RLDraw38: TQRShape;
    RLDraw37: TQRShape;
    RLDraw34: TQRShape;
    RLDraw28: TQRShape;
    RLDraw27: TQRShape;
    RLDraw25: TQRShape;
    RLDraw24: TQRShape;
    RLDraw23: TQRShape;
    RLDraw22: TQRShape;
    RLDraw20: TQRShape;
    RLDraw19: TQRShape;
    RLDraw18: TQRShape;
    RLDraw16: TQRShape;
    imgBanco2: TQrImage;
    txtNumeroBanco2: TQrLabel;
    RLLabel67: TQrLabel;
    RLLabel68: TQrLabel;
    lblLocalPagto: TQrLabel;
    RLLabel69: TQrLabel;
    txtNomeCedente2: TQrLabel;
    RLLabel70: TQrLabel;
    txtDataDocumento2: TQrLabel;
    RLLabel71: TQrLabel;
    txtNumeroDocumento2: TQrLabel;
    RLLabel72: TQrLabel;
    txtEspecieDoc2: TQrLabel;
    RLLabel73: TQrLabel;
    txtAceite2: TQrLabel;
    RLLabel74: TQrLabel;
    txtDataProcessamento2: TQrLabel;
    txtUsoBanco2: TQrLabel;
    RLLabel75: TQrLabel;
    txtCarteira2: TQrLabel;
    RLLabel76: TQrLabel;
    RLLabel77: TQrLabel;
    txtEspecie2: TQrLabel;
    RLLabel78: TQrLabel;
    RLLabel79: TQrLabel;
    RLLabel80: TQrLabel;
    txtInstrucoes2: TQrMemo;
    RLLabel81: TQrLabel;
    txtDataVencimento2: TQrLabel;
    RLLabel82: TQrLabel;
    txtCodigoCedente2: TQrLabel;
    RLLabel83: TQrLabel;
    txtNossoNumero2: TQrLabel;
    RLLabel84: TQrLabel;
    txtValorDocumento2: TQrLabel;
    RLLabel85: TQrLabel;
    RLLabel86: TQrLabel;
    RLLabel87: TQrLabel;
    RLLabel88: TQrLabel;
    txtNomeSacado2: TQrLabel;
    txtEnderecoSacado2: TQrLabel;
    txtCidadeSacado2: TQrLabel;
    RLLabel89: TQrLabel;
    txtCpfCnpjSacado2: TQrLabel;
    RLLabel90: TQrLabel;
    RLMemo2: TQrMemo;
    RLLabel91: TQrLabel;
    RLLabel93: TQrLabel;
    RLLabel98: TQrLabel;
    RLLabel102: TQrLabel;
    txtSacadorAvalista2: TQrLabel;
    QRShape1: TQRShape;
    QRShape2: TQRShape;
    ACBrBarCode1: TACBrBarCode;
    txtValorDocumento3: TQRLabel;
    txtUsoBanco3: TQRLabel;
    txtSwHouse: TQRLabel;
    txtSacadorAvalista3: TQRLabel;
    txtNumeroDocumento3: TQRLabel;
    txtNumeroBanco3: TQRLabel;
    txtNossoNumero3: TQRLabel;
    txtNomeSacado3: TQRLabel;
    txtNomeCedente3: TQRLabel;
    txtLocalPagamento3: TQRLabel;
    txtLinhaDigitavel: TQRLabel;
    txtInstrucoes3: TQRMemo;
    txtEspecieDoc3: TQRLabel;
    txtEspecie3: TQRLabel;
    txtEnderecoSacado3: TQRLabel;
    txtDataVencimento3: TQRLabel;
    txtDataProcessamento3: TQRLabel;
    txtDataDocumento3: TQRLabel;
    txtCpfCnpjSacado3: TQRLabel;
    txtCodigoCedente3: TQRLabel;
    txtCidadeSacado3: TQRLabel;
    txtCarteira3: TQRLabel;
    txtAceite3: TQRLabel;
    RLLabel175: TQRLabel;
    RLLabel170: TQRLabel;
    RLLabel168: TQRLabel;
    RLLabel167: TQRLabel;
    RLLabel166: TQRLabel;
    RLLabel165: TQRLabel;
    RLLabel164: TQRLabel;
    RLLabel163: TQRLabel;
    RLLabel162: TQRLabel;
    RLLabel161: TQRLabel;
    RLLabel160: TQRLabel;
    RLLabel159: TQRLabel;
    RLLabel158: TQRLabel;
    RLLabel157: TQRLabel;
    RLLabel156: TQRLabel;
    RLLabel155: TQRLabel;
    RLLabel154: TQRLabel;
    RLLabel153: TQRLabel;
    RLLabel152: TQRLabel;
    RLLabel151: TQRLabel;
    RLLabel150: TQRLabel;
    RLLabel149: TQRLabel;
    RLLabel148: TQRLabel;
    RLLabel147: TQRLabel;
    RLLabel146: TQRLabel;
    RLLabel145: TQRLabel;
    QRShape9: TQRShape;
    QRShape8: TQRShape;
    QRShape7: TQRShape;
    QRShape6: TQRShape;
    QRShape5: TQRShape;
    QRShape4: TQRShape;
    QRShape3: TQRShape;
    QRShape17: TQRShape;
    QRShape16: TQRShape;
    QRShape15: TQRShape;
    QRShape14: TQRShape;
    QRShape13: TQRShape;
    QRShape12: TQRShape;
    QRShape11: TQRShape;
    QRShape10: TQRShape;
    QRLabel1: TQRLabel;
    imgBarra: TQRImage;
    imgBanco3: TQRImage;
    QRHTMLFilter1: TQRHTMLFilter;
    procedure FormCreate(Sender: TObject);
    procedure LayoutBoletoNeedData(Sender: TObject; var MoreData: Boolean);
    procedure RLBandDatailBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure LayoutBoletoStartPage(Sender: TCustomQuickRep);
  private
     fBoletoFC: TACBrBoletoFCQuick;
     fIndice: Integer;
     function GetACBrTitulo: TACBrTitulo;
    { Private declarations }
  public
    { Public declarations }
    property Indice   : Integer read fIndice ;
    property BoletoFC : TACBrBoletoFCQuick read fBoletoFC ;
    property Titulo   : TACBrTitulo read GetACBrTitulo ;
  end;

procedure Register;

implementation

Uses ACBrUtil, strutils, AJBarcode;

{$R *.dfm}
{$R ACBrBoletoFCQuick.dcr}

procedure Register;
begin
  RegisterComponents('ACBr',[TACBrBoletoFCQuick]);
end;

{ TACBrBoletoFCQuick }

constructor TACBrBoletoFCQuick.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  fpAbout := 'ACBRBoletoFCQuick ver: '+CACBrBoletoFCQuick_Versao;
end;

procedure TACBrBoletoFCQuick.Imprimir;

var
  frACBrBoletoQuick : TACBRBoletoFCQuickFr;
  RLLayout: TQuickRep;
  MultiExport : TQRMultiExport ;
  //HTMLFilter  : TQRHTMLDocumentFilter ;
begin
  inherited Imprimir;    // Executa verificações padroes

  frACBrBoletoQuick := TACBrBoletoFCQuickFr.Create(Self);
  try
     with frACBrBoletoQuick do
     begin
        case LayOut of
           lPadrao : RLLayout:= LayoutBoleto;
//         lCarne  : RLLayout:= BoletoCarne;
        else
           RLLayout := LayoutBoleto;
        end;

        RLLayout.PrinterSettings.Copies := NumCopias ;

        case Filtro of
          fiPDF  :
            begin
               MultiExport := TQRMultiExport.Create(self);
               try
                  MultiExport.Report       := RLLayout ;
                  MultiExport.ExportFormat := qrxPDF ;
                  MultiExport.FileName     := NomeArquivo ;
                  MultiExport.ShowDialog   := MostrarSetup ;
                  MultiExport.DPI          := 300 ;
                  MultiExport.DoExport ;
               finally
                  MultiExport.Free ;
               end ;
            end ;

          fiHTML :
            begin
               (*  Codigo abaixo comentado pois  não funciona...
               HTMLFilter := TQRHTMLDocumentFilter.Create( NomeArquivo );
               try
                  RLLayout.ExportToFilter( HTMLFilter );
               finally
                  HTMLFilter.Free ;
               end ;
               *)
               raise Exception.Create( 'Exportação para HTML não implementada no QuickReport') ;
            end ;
        else
          begin
            if MostrarPreview then
               RLLayout.PreviewModal
            else
             begin
               if MostrarSetup then
                  RLLayout.PrinterSetup ;

               RLLayout.Print;
             end ;
          end
        end ;
     end ;
  finally
     frACBrBoletoQuick.Free ;
  end;
end;


{ TACBrBoletoFCQuickFr }

procedure TACBrBoletoFCQuickFr.FormCreate(Sender: TObject);
begin
   fIndice   := 0 ;
   fBoletoFC := TACBrBoletoFCQuick(Owner) ;  // Link para o Pai
   txtSwHouse.Caption := BoletoFC.SoftwareHouse ;
   ACBrBarCode1.Width := imgBarra.Width ;
   ACBrBarCode1.Height:= imgBarra.Height ;
end;

function TACBrBoletoFCQuickFr.GetACBrTitulo: TACBrTitulo;
begin
   Result := fBoletoFC.ACBrBoleto.ListadeBoletos[ fIndice ] ;
end;

procedure TACBrBoletoFCQuickFr.LayoutBoletoNeedData(Sender: TObject;
  var MoreData: Boolean);
begin
   MoreData := (fIndice < fBoletoFC.ACBrBoleto.ListadeBoletos.Count) ;
end;

procedure TACBrBoletoFCQuickFr.RLBandDatailBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
Var
   NossoNum, CodCedente : String;
   CodBarras, LinhaDigitavel : String;
   BMP : TBitmap ;
begin
   with fBoletoFC.ACBrBoleto do
   begin
      NossoNum    := Banco.MontarCampoNossoNumero( Titulo );
      CodCedente  := Banco.MontarCampoCodigoCedente(titulo);

      fBoletoFC.CarregaLogo( imgBanco2.Picture, Banco.Numero );
      txtNumeroBanco2.Caption         := IntToStrZero(Banco.Numero, 3)+ '-' +
                                         IfThen(Banco.Digito >= 10,'X',IntToStrZero(Banco.Digito, 1));
      lblLocalPagto.Caption           := Titulo.LocalPagamento;
      txtDataVencimento2.Caption      := FormatDateTime('dd/mm/yyyy', Titulo.Vencimento);
      txtNomeCedente2.Caption         := Cedente.Nome;
      txtCodigoCedente2.Caption       := CodCedente;
      txtDataDocumento2.Caption       := FormatDateTime('dd/mm/yyyy', Titulo.DataDocumento);
      txtNumeroDocumento2.Caption     := Titulo.NumeroDocumento;
      txtEspecieDoc2.Caption          := Titulo.EspecieDoc;
      txtAceite2.Caption              := ifThen(Titulo.Aceite = atSim,'S','N');
      txtDataProcessamento2.Caption   := FormatDateTime('dd/mm/yyyy',Now);
      txtNossoNumero2.Caption         := NossoNum;
      txtUsoBanco2.Caption            := Titulo.UsoBanco;
      txtCarteira2.Caption            := Titulo.Carteira;
      txtEspecie2.Caption             := 'R$';
      txtValorDocumento2.Caption      := FormatFloat('###,###,##0.00',Titulo.ValorDocumento);
      txtNomeSacado2.Caption          := Titulo.Sacado.NomeSacado;
      txtEnderecoSacado2.Caption      := Titulo.Sacado.Logradouro + ' '+
                                         Titulo.Sacado.Numero + Titulo.Sacado.Complemento;
      txtCidadeSacado2.Caption        := Titulo.Sacado.CEP + ' '+Titulo.Sacado.Cidade +
                                         ' '+Titulo.Sacado.UF;
      txtCpfCnpjSacado2.Caption       := Titulo.Sacado.CNPJCPF;
      txtInstrucoes2.Lines.Text       := Titulo.Mensagem.Text;


     CodBarras      := Banco.MontarCodigoBarras( Titulo );
     LinhaDigitavel := Banco.MontarLinhaDigitavel( CodBarras );

     imgBanco3.Picture.Assign(imgBanco2.Picture);
     txtNumeroBanco3.Caption         := txtNumeroBanco2.Caption;
     txtLocalPagamento3.Caption      := lblLocalPagto.Caption;
     txtDataVencimento3.Caption      := txtDataVencimento2.Caption;
     txtNomeCedente3.Caption         := txtNomeCedente2.Caption;
     txtCodigoCedente3.Caption       := txtCodigoCedente2.Caption;
     txtDataDocumento3.Caption       := txtDataDocumento2.Caption;
     txtNumeroDocumento3.Caption     := txtNumeroDocumento2.Caption;
     txtEspecie3.Caption             := txtEspecie2.Caption;
     txtAceite3.Caption              := txtAceite2.Caption;
     txtDataProcessamento3.Caption   := txtDataProcessamento2.Caption;
     txtNossoNumero3.Caption         := txtNossoNumero2.Caption;
     txtUsoBanco3.Caption            := txtUsoBanco2.Caption;
     txtCarteira3.Caption            := txtCarteira2.Caption;
     txtEspecieDoc3.Caption          := txtEspecieDoc2.Caption;
     txtValorDocumento3.Caption      := txtValorDocumento2.Caption;
     txtNomeSacado3.Caption          := txtNomeSacado2.Caption;
     txtEnderecoSacado3.Caption      := txtEnderecoSacado2.Caption;
     txtCidadeSacado3.Caption        := txtCidadeSacado2.Caption;
     txtCpfCnpjSacado3.Caption       := txtCpfCnpjSacado2.Caption;
     txtLinhaDigitavel.Caption       := LinhaDigitavel;
     txtInstrucoes3.Lines.Text       := txtInstrucoes2.Lines.Text;

     ACBrBarCode1.Typ  := bcCode_2_5_interleaved ;   
     ACBrBarCode1.Text := CodBarras;
     BMP := TBitmap.Create ;
     try
        BMP.Width  := imgBarra.Width ;
        BMP.Height := imgBarra.Height ;
        ACBrBarCode1.DrawBarcode(BMP.Canvas);

        imgBarra.Picture.Bitmap := BMP ;
     finally
        BMP.Free ;
     end ;
   end;
end;

procedure TACBrBoletoFCQuickFr.LayoutBoletoStartPage(
  Sender: TCustomQuickRep);
begin
  Inc( fIndice ) ;
end;

end.


(*
procedure TACBRBoletoFCQuickFr.RLBand3BeforePrint ( Sender: TObject;
   var PrintIt: boolean ) ;
Var
   NossoNum,LinhaDigitavel,CodBarras,CodCedente: String;
begin
   with fBoletoFC.ACBrBoleto do
   begin
      NossoNum       := Banco.MontarCampoNossoNumero( Titulo );
      CodBarras      := Banco.MontarCodigoBarras( Titulo );
      LinhaDigitavel := Banco.MontarLinhaDigitavel( CodBarras );
      CodCedente     := Banco.MontarCampoCodigoCedente(Titulo);

      fBoletoFC.CarregaLogo( imgBanco2.Picture, Banco.Numero );
      txtNumeroBanco2.Caption         := IntToStrZero(Banco.Numero, 3)+ '-' +
                                        ifthen(Banco.Digito >= 10,'X',IntToStrZero(Banco.Digito, 1));
      txtVencCanhoto.Caption          := FormatDateTime('dd/mm/yyyy',Titulo.Vencimento);
      txtVencCarne2.Caption           := txtVencCanhoto.Caption;
      txtCodCedenteCarne.Caption      := CodCedente;
      txtCodCedenteCarne2.Caption     := txtCodCedenteCarne.Caption;
      txtValorCarne.Caption           := FormatFloat('###,###,##0.00',Titulo.ValorDocumento);
      txtValorCar.Caption             := txtValorCarne.Caption;
      txtNossoNumeroCarne.Caption     := NossoNum;
      txtNossoNumCan.Caption          := NossoNum;
      txtNomeSacado.Caption           := Titulo.Sacado.NomeSacado;
      txtNomeSacadoCarne.Caption      := txtNomeSacado.Caption;
      txtLocal.Caption                := Titulo.LocalPagamento;
      txtNomeCedente.Caption          := Cedente.Nome;
      txtDataDocto.Caption            := FormatDateTime('dd/mm/yyyy', Titulo.DataDocumento);
      txtNumeroDocto.Caption          := Titulo.NumeroDocumento;
      txtEspecieDoc.Caption           := Titulo.EspecieDoc;
      txtAceite.Caption               := IfThen((atSim = Titulo.Aceite), 'S', 'N');
      txtDataProces.Caption           := FormatDateTime('dd/mm/yyyy',Now);
      txtUsoBanco2.Caption            := Titulo.UsoBanco;
      txtCarteira.Caption             := Titulo.Carteira;
      txtEspecie2.Caption             := 'R$';
      txtParcela.Caption              := IntToStrZero(Titulo.Parcela,2)+' /';
      txtTotPar.Caption               := IntToStrZero(Titulo.TotalParcelas,2);
      txtEndSacado.Caption            := Titulo.Sacado.Logradouro + ' '+
                                         Titulo.Sacado.Numero + Titulo.Sacado.Complemento;
      txtCidadeSacado.Caption         := Titulo.Sacado.CEP + ' '+Titulo.Sacado.Cidade +
                                         ' '+Titulo.Sacado.UF;
      txtCPF.Caption                  := Titulo.Sacado.CNPJCPF;
      txtCPFCarne2.Caption            := txtCPF.Caption;
      mIntrucoes.Lines.Text           := Titulo.Mensagem.Text;
      txtLinhaDigitavelCarne.Caption := LinhaDigitavel;
      imgBarrasCarne.Caption := CodBarras;
   end;
end;

*)


