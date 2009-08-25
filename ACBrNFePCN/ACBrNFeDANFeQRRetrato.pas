{******************************************************************************}
{ Projeto: Componente ACBrNFe                                                  }
{  Biblioteca multiplataforma de componentes Delphi para emissão de Nota Fiscal}
{ eletrônica - NFe - http://www.nfe.fazenda.gov.br                          }
{                                                                              }
{ Direitos Autorais Reservados (c) 2008 Wemerson Souto                         }
{                                       Daniel Simoes de Almeida               }
{                                       André Ferreira de Moraes               }
{                                                                              }
{ Colaboradores nesse arquivo:                                                 }
{                                                                              }
{  Você pode obter a última versão desse arquivo na pagina do Projeto ACBr     }
{ Componentes localizado em http://www.sourceforge.net/projects/acbr           }
{                                                                              }
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
|* 16/12/2008: Wemerson Souto
|*  - Doação do componente para o Projeto ACBr
|* 20/08/2009: Caique Rodrigues
|*  - Doação units para geração do Danfe via QuickReport
******************************************************************************}
{$I ACBr.inc}
unit ACBrNFeDANFeQRRetrato;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, QuickRpt, QRCtrls,  XMLIntf, XMLDoc,
  JPEG, ACBrNFeDANFeQR, ACBrNFeQRCodeBar, pcnConversao;

type

  TfqrDANFeQRRetrato = class(TfqrDANFeQR)
    rbDadosAdicionais: TQRBand;
    QRShape1: TQRShape;
    QRShape2: TQRShape;
    QRShape3: TQRShape;
    qrsPicoteHeader: TQRShape;
    QRShape5: TQRShape;
    QRShape6: TQRShape;
    QRShape7: TQRShape;
    QRShape8: TQRShape;
    QRShape9: TQRShape;
    QRShape10: TQRShape;
    QRShape11: TQRShape;
    QRLabel1: TQRLabel;
    QRShape15: TQRShape;
    QRShape16: TQRShape;
    QRShape17: TQRShape;
    QRShape18: TQRShape;
    QRShape19: TQRShape;
    QRShape20: TQRShape;
    QRShape12: TQRShape;
    QRShape13: TQRShape;
    QRShape14: TQRShape;
    QRShape21: TQRShape;
    QRShape22: TQRShape;
    QRShape23: TQRShape;
    qrshpFatura: TQRShape;
    qrlblFatura: TQRLabel;
    QRLabel4: TQRLabel;
    QRShape25: TQRShape;
    QRShape26: TQRShape;
    QRShape27: TQRShape;
    QRShape28: TQRShape;
    QRShape29: TQRShape;
    QRShape30: TQRShape;
    QRShape31: TQRShape;
    QRShape32: TQRShape;
    QRShape33: TQRShape;
    QRShape34: TQRShape;
    QRShape35: TQRShape;
    QRShape36: TQRShape;
    QRLabel5: TQRLabel;
    QRShape37: TQRShape;
    QRShape38: TQRShape;
    QRShape39: TQRShape;
    QRShape42: TQRShape;
    QRShape43: TQRShape;
    QRShape44: TQRShape;
    QRShape45: TQRShape;
    QRShape46: TQRShape;
    QRShape47: TQRShape;
    QRShape48: TQRShape;
    QRShape49: TQRShape;
    QRShape50: TQRShape;
    QRShape51: TQRShape;
    QRShape52: TQRShape;
    QRLabel3: TQRLabel;
    QRLabel6: TQRLabel;
    QRShape53: TQRShape;
    QRShape54: TQRShape;
    QRShape55: TQRShape;
    QRShape56: TQRShape;
    QRLabel7: TQRLabel;
    QRShape57: TQRShape;
    qrlRecebemosDe1: TQRLabel;
    QRShape101: TQRShape;
    QRLabel10: TQRLabel;
    QRLabel11: TQRLabel;
    QRLabel12: TQRLabel;
    QRLabel13: TQRLabel;
    QRLabel14: TQRLabel;
    qrlSERIE0: TQRLabel;
    qrlNumNF0: TQRLabel;
    QRLabel17: TQRLabel;
    QRLabel18: TQRLabel;
    QRLabel19: TQRLabel;
    QRLabel20: TQRLabel;
    qrlNumNF1: TQRLabel;
    QRLabel22: TQRLabel;
    qrlSERIE1: TQRLabel;
    QRLabel24: TQRLabel;
    qrlPageNumber: TQRLabel;
    QRLabel26: TQRLabel;
    QRLabel27: TQRLabel;
    QRShape102: TQRShape;
    QRLabel28: TQRLabel;
    QRLabel29: TQRLabel;
    QRLabel30: TQRLabel;
    QRLabel31: TQRLabel;
    QRLabel32: TQRLabel;
    QRLabel33: TQRLabel;
    QRLabel34: TQRLabel;
    QRLabel35: TQRLabel;
    QRLabel36: TQRLabel;
    QRLabel37: TQRLabel;
    QRLabel38: TQRLabel;
    QRLabel39: TQRLabel;
    QRLabel40: TQRLabel;
    QRLabel41: TQRLabel;
    QRLabel42: TQRLabel;
    QRLabel43: TQRLabel;
    QRLabel44: TQRLabel;
    QRLabel45: TQRLabel;
    QRLabel46: TQRLabel;
    QRLabel47: TQRLabel;
    QRLabel48: TQRLabel;
    QRLabel49: TQRLabel;
    QRLabel50: TQRLabel;
    QRLabel51: TQRLabel;
    QRLabel52: TQRLabel;
    QRLabel53: TQRLabel;
    QRLabel54: TQRLabel;
    QRLabel55: TQRLabel;
    QRLabel56: TQRLabel;
    QRLabel57: TQRLabel;
    QRLabel58: TQRLabel;
    QRLabel59: TQRLabel;
    QRLabel60: TQRLabel;
    QRLabel61: TQRLabel;
    QRLabel62: TQRLabel;
    QRLabel63: TQRLabel;
    QRLabel64: TQRLabel;
    QRLabel65: TQRLabel;
    QRLabel66: TQRLabel;
    QRLabel67: TQRLabel;
    QRLabel68: TQRLabel;
    QRLabel69: TQRLabel;
    QRLabel70: TQRLabel;
    QRLabel71: TQRLabel;
    QRLabel72: TQRLabel;
    QRShape110: TQRShape;
    QRLabel91: TQRLabel;
    QRLabel92: TQRLabel;
    qrlFatData1: TQRLabel;
    qrlFatData2: TQRLabel;
    qrlFatData3: TQRLabel;
    qrlFatValor3: TQRLabel;
    qrlFatValor2: TQRLabel;
    qrlFatValor1: TQRLabel;
    qrlFatNum2: TQRLabel;
    qrlFatNum1: TQRLabel;
    qrlFatNum3: TQRLabel;
    QRLabel100: TQRLabel;
    QRShape106: TQRShape;
    QRLabel137: TQRLabel;
    QRLabel138: TQRLabel;
    QRLabel139: TQRLabel;
    QRLabel140: TQRLabel;
    QRShape107: TQRShape;
    QRShape108: TQRShape;
    QRShape109: TQRShape;
    qrlFatNum6: TQRLabel;
    qrlFatNum5: TQRLabel;
    qrlFatNum4: TQRLabel;
    qrlFatData4: TQRLabel;
    qrlFatData5: TQRLabel;
    qrlFatData6: TQRLabel;
    qrlFatValor6: TQRLabel;
    qrlFatValor5: TQRLabel;
    qrlFatValor4: TQRLabel;
    qrlFatNum9: TQRLabel;
    qrlFatNum8: TQRLabel;
    qrlFatNum7: TQRLabel;
    qrlFatData7: TQRLabel;
    qrlFatData8: TQRLabel;
    qrlFatData9: TQRLabel;
    qrlFatValor9: TQRLabel;
    qrlFatValor8: TQRLabel;
    qrlFatValor7: TQRLabel;
    qrlFatNum12: TQRLabel;
    qrlFatNum11: TQRLabel;
    qrlFatNum10: TQRLabel;
    qrlFatData10: TQRLabel;
    qrlFatData11: TQRLabel;
    qrlFatData12: TQRLabel;
    qrlFatValor12: TQRLabel;
    qrlFatValor11: TQRLabel;
    qrlFatValor10: TQRLabel;
    qrlFatNum15: TQRLabel;
    qrlFatNum14: TQRLabel;
    qrlFatNum13: TQRLabel;
    qrlFatData13: TQRLabel;
    qrlFatData14: TQRLabel;
    qrlFatData15: TQRLabel;
    qrlFatValor15: TQRLabel;
    qrlFatValor14: TQRLabel;
    qrlFatValor13: TQRLabel;
    qrmDadosAdicionais: TQRMemo;
    QRLabel141: TQRLabel;
    qrsRectProdutos: TQRShape;
    qrsDivProd1: TQRShape;
    qrsDivProd2: TQRShape;
    qrsDivProd3: TQRShape;
    qrsDivProd4: TQRShape;
    qrsDivProd5: TQRShape;
    qrsDivProd6: TQRShape;
    qrsDivProd7: TQRShape;
    qrsDivProd8: TQRShape;
    qrsDivProd9: TQRShape;
    qrsDivProd10: TQRShape;
    qrsDivProd11: TQRShape;
    qrsDivProd12: TQRShape;
    qrsDivProd13: TQRShape;
    QRLabel142: TQRLabel;
    QRLabel143: TQRLabel;
    QRLabel144: TQRLabel;
    QRLabel145: TQRLabel;
    QRLabel146: TQRLabel;
    QRLabel147: TQRLabel;
    QRLabel148: TQRLabel;
    QRLabel149: TQRLabel;
    QRLabel150: TQRLabel;
    QRLabel152: TQRLabel;
    QRLabel153: TQRLabel;
    QRLabel154: TQRLabel;
    QRLabel155: TQRLabel;
    QRLabel156: TQRLabel;
    QRLabel157: TQRLabel;
    qrsLineHeaderProdutos: TQRShape;
    qrmProdutoCodigo: TQRMemo;
    qrmProdutoDescricao: TQRMemo;
    qrmProdutoNCM: TQRMemo;
    qrmProdutoCST: TQRMemo;
    qrmProdutoCFOP: TQRMemo;
    qrmProdutoUnidade: TQRMemo;
    qrmProdutoQTDE: TQRMemo;
    qrmProdutoValor: TQRMemo;
    qrmProdutoTotal: TQRMemo;
    qrmProdutoBCICMS: TQRMemo;
    qrmProdutoVALORICMS: TQRMemo;
    qrmProdutoVALORIPI: TQRMemo;
    qrmProdutoALIQICMS: TQRMemo;
    qrmProdutoALIQIPI: TQRMemo;
    QRLabel151: TQRLabel;
    qrbReciboHeader: TQRBand;
    ChildBand2: TQRChildBand;
    qrbDadosNFe: TQRChildBand;
    qrbManchaPicote: TQRChildBand;
    QRLabel8: TQRLabel;
    qrsPicoteManchaHeader: TQRShape;
    rbDetail: TQRBand;
    rbDadosXXXXX: TQRChildBand;
    qrbReciboHeader2: TQRChildBand;
    QRShape4: TQRShape;
    QRLabel74: TQRLabel;
    qrsPicoteHeader2: TQRShape;
    QRShape59: TQRShape;
    QRShape60: TQRShape;
    QRShape61: TQRShape;
    qrlRecebemosDe2: TQRLabel;
    qrlNumNF2: TQRLabel;
    qrlSerie2: TQRLabel;
    QRLabel78: TQRLabel;
    QRLabel79: TQRLabel;
    QRLabel80: TQRLabel;
    QRLabel81: TQRLabel;
    qrbManchaPicote2: TQRChildBand;
    qrsPicoteManchaHeader2: TQRShape;
    QRLabel82: TQRLabel;
    qrlNatOperacao: TQRLabel;
    qrlInscricaoEstadual: TQRLabel;
    qrlInscrEstSubst: TQRLabel;
    qrlCNPJ: TQRLabel;
    qrlChave: TQRLabel;
    qrlDestNome: TQRLabel;
    qrlDestCNPJ: TQRLabel;
    qrlDestEndereco: TQRLabel;
    qrlDestBairro: TQRLabel;
    qrlDestCEP: TQRLabel;
    qrlDestCidade: TQRLabel;
    qrlDestFone: TQRLabel;
    qrlDestUF: TQRLabel;
    qrlDestIE: TQRLabel;
    qrlEmissao: TQRLabel;
    qrlSaida: TQRLabel;
    qrlBaseICMS: TQRLabel;
    qrlValorICMS: TQRLabel;
    qrlBaseICMST: TQRLabel;
    qrlValorICMST: TQRLabel;
    qrlTotalProdutos: TQRLabel;
    qrlValorFrete: TQRLabel;
    qrlValorSeguro: TQRLabel;
    qrlDescontos: TQRLabel;
    qrlAcessorias: TQRLabel;
    qrlValorIPI: TQRLabel;
    qrlTotalNF: TQRLabel;
    qrlTransNome: TQRLabel;
    qrlTransModFrete: TQRLabel;
    qrlTransCodigoANTT: TQRLabel;
    qrlTransPlaca: TQRLabel;
    qrlTransUFPlaca: TQRLabel;
    qrlTransCNPJ: TQRLabel;
    qrlTransEndereco: TQRLabel;
    qrlTransCidade: TQRLabel;
    qrlTransUF: TQRLabel;
    qrlTransIE: TQRLabel;
    qrlTransQTDE: TQRLabel;
    qrlTransEspecie: TQRLabel;
    qrlTransMarca: TQRLabel;
    qrlTransNumeracao: TQRLabel;
    qrlTransPesoBruto: TQRLabel;
    qrlTransPesoLiq: TQRLabel;
    QRLabel194: TQRLabel;
    QRLabel195: TQRLabel;
    QRLabel196: TQRLabel;
    QRLabel197: TQRLabel;
    qrlFone: TQRLabel;
    qrmEmitente: TQRMemo;
    qrmEndereco: TQRMemo;
    qrsISSQN: TQRSubDetail;
    qrlEntradaSaida: TQRLabel;
    qrlHoraSaida: TQRLabel;
    QRLabel15: TQRLabel;
    qriLogo: TQRImage;
    qrlblSistema: TQRLabel;
    qriBarCode: TQRImage;
    procedure QRNFeNeedData(Sender: TObject; var MoreData: Boolean);
    procedure QRNFeBeforePrint(Sender: TCustomQuickRep; var PrintReport: Boolean);
    procedure qrbDadosNFeBeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
    procedure qrbReciboHeaderBeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
    procedure qrbManchaPicoteBeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
    procedure rbDetailBeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
    procedure rbDadosAdicionaisBeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
    procedure qrbManchaPicote2BeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
    procedure qrbReciboHeader2BeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
    procedure qrsISSQNBeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
    procedure QRNFeAfterPreview(Sender: TObject);
    procedure ChildBand2BeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
  private
    { Private declarations }
    FRecebemoDe : string ;
    DetItem : integer ;
    FTotalPages : integer ;
    procedure InitDados ;
    procedure Header ;
    procedure Emitente ;
    procedure Destinatario ;
    procedure Imposto ;
    procedure Transporte ;
    procedure Observacoes ;
    procedure Detalhes ;
    procedure BeginUpdateProdutos ;
    procedure EndupdateProdutos ;
    procedure AddFatura ;
    procedure ValorFiscal ;
  public
    { Public declarations }
  end;


implementation

uses StrUtils, ACBrNFeUtil  ;

{$R *.dfm}

const
   _NUM_ITEMS_PAGE1 = 28 ;
   _NUM_ITEMS_OTHERPAGES = 150 ;

procedure TfqrDANFeQRRetrato.InitDados ;
begin
  qriBarCode.BringToFront ;

  FTotalPages := 1 ;

  if ( FNFe.Det.Count > _NUM_ITEMS_PAGE1 ) then
    begin
       FTotalPages := ( FNFe.Det.Count - _NUM_ITEMS_PAGE1 ) div _NUM_ITEMS_OTHERPAGES ;
       if ( ( FNFe.Det.Count - _NUM_ITEMS_PAGE1 ) mod _NUM_ITEMS_OTHERPAGES ) <> 0 then
          inc ( FTotalPages )
    end ;

  if ( FLogo <> '' ) and FileExists ( FLogo ) then
     qriLogo.Picture.LoadFromFile( FLogo );

  Header ;
  Emitente ;
  Destinatario ;
  Imposto ;
  Transporte ;
  AddFatura ;
  Observacoes;

  ValorFiscal;

end;

procedure TfqrDANFeQRRetrato.QRNFeNeedData(Sender: TObject;
  var MoreData: Boolean);
begin
  MoreData := ( QRNFe.PageNumber = 0 ) or ( DetItem < (FNFe.Det.Count - 1) ) ;
  if ( MoreData ) then
     Detalhes ;
end;

procedure TfqrDANFeQRRetrato.QRNFeBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
begin
  DetItem := 0 ;
  InitDados ;
end;

procedure TfqrDANFeQRRetrato.qrbReciboHeaderBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  PrintBand := QRNFe.PageNumber = 1 ;
  PrintBand := False;
end;

procedure TfqrDANFeQRRetrato.qrbManchaPicoteBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  qrbManchaPicote.Height := qrbReciboHeader.Height ;
  qrsPicoteManchaHeader.Top := qrsPicoteHeader.Top ;
  PrintBand := QRNFe.PageNumber <> 1 ;
  PrintBand := False ;
end;

procedure TfqrDANFeQRRetrato.qrbDadosNFeBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  PrintBand := QRNFe.PageNumber = 1 ;
end;

procedure TfqrDANFeQRRetrato.rbDetailBeforePrint(Sender: TQRCustomBand;  var PrintBand: Boolean);
var
   h : integer ;
begin

   if QRNFe.PageNumber = 0 then
      h := Canvas.TextHeight( 'XÇÚ' ) * ( _NUM_ITEMS_PAGE1 -1 )
//      h := QRNFe.Printer.Canvas.TextHeight( 'XÇÚ' ) * ( _NUM_ITEMS_PAGE1 -1 )
   else
      h := Canvas.TextHeight( 'XÇÚ' ) * ( _NUM_ITEMS_OTHERPAGES -1 ) ;
//      h := QRNFe.Printer.Canvas.TextHeight( 'XÇÚ' ) * ( _NUM_ITEMS_OTHERPAGES -1 ) ;

//   h := h + (qrsLineHeaderProdutos.Top + 5) ;
   h := h + qrsLineHeaderProdutos.Top ;
//   rbDetail.Height := h ;


   qrsRectProdutos.Height := h - 1 ;
   qrsDivProd1.Height := h - 1 ;
   qrsDivProd2.Height := h - 1 ;
   qrsDivProd3.Height := h - 1 ;
   qrsDivProd4.Height := h - 1 ;
   qrsDivProd5.Height := h - 1 ;
   qrsDivProd6.Height := h - 1 ;
   qrsDivProd7.Height := h - 1 ;
   qrsDivProd8.Height := h - 1 ;
   qrsDivProd9.Height := h - 1 ;
   qrsDivProd10.Height := h - 1 ;
   qrsDivProd11.Height := h - 1 ;
   qrsDivProd12.Height := h - 1 ;
   qrsDivProd13.Height := h - 1 ;

    h := h - qrmProdutoCodigo.Top ;
    qrmProdutoCodigo.Height    :=  h;
    qrmProdutoDescricao.Height :=  h;
    qrmProdutoNCM.Height :=        h;
    qrmProdutoCST.Height :=        h;
    qrmProdutoCFOP.Height :=       h;
    qrmProdutoUnidade.Height :=    h;
    qrmProdutoQTDE.Height :=       h;
    qrmProdutoValor.Height :=      h;
    qrmProdutoTotal.Height :=      h;
    qrmProdutoBCICMS.Height :=     h;
    qrmProdutoVALORICMS.Height :=  h;
    qrmProdutoVALORIPI.Height :=   h;
    qrmProdutoALIQICMS.Height :=   h;
    qrmProdutoALIQIPI.Height :=    h;

end;

procedure TfqrDANFeQRRetrato.rbDadosAdicionaisBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
//  PrintBand := False ;
//  QRBand2.Top := rbDetail.Top + rbDetail.Height ;
//  PrintBand := QRNFe.PageNumber = 1 ;
  PrintBand := QRNFe.PageNumber = 1 ;
//  rbDadosAdicionais.Top := QRBand2.Top + QRBand2.Height ;
//  rbDadosAdicionais.Top := 841 ;
end;

procedure TfqrDANFeQRRetrato.qrbManchaPicote2BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  qrbManchaPicote2.Height    := qrbReciboHeader2.Height ;
  qrsPicoteManchaHeader2.Top := qrsPicoteHeader2.Top ;
  PrintBand := QRNFe.PageNumber <> 1 ;
end;

procedure TfqrDANFeQRRetrato.qrbReciboHeader2BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  PrintBand := QRNFe.PageNumber = 1 ;
end;

procedure TfqrDANFeQRRetrato.BeginUpdateProdutos;
begin

    qrmProdutoCodigo.Height := 0;
    qrmProdutoDescricao.Height := 0;
    qrmProdutoNCM.Height := 0;
    qrmProdutoCST.Height := 0;
    qrmProdutoCFOP.Height := 0;
    qrmProdutoUnidade.Height := 0;
    qrmProdutoQTDE.Height := 0;
    qrmProdutoValor.Height := 0;
    qrmProdutoTotal.Height := 0;
    qrmProdutoBCICMS.Height := 0;
    qrmProdutoVALORICMS.Height := 0;
    qrmProdutoVALORIPI.Height := 0;
    qrmProdutoALIQICMS.Height := 0;
    qrmProdutoALIQIPI.Height := 0;

    qrmProdutoCodigo.Lines.BeginUpdate ;
    qrmProdutoDescricao.Lines.BeginUpdate ;
    qrmProdutoNCM.Lines.BeginUpdate ;
    qrmProdutoCST.Lines.BeginUpdate ;
    qrmProdutoCFOP.Lines.BeginUpdate ;
    qrmProdutoUnidade.Lines.BeginUpdate ;
    qrmProdutoQTDE.Lines.BeginUpdate ;
    qrmProdutoValor.Lines.BeginUpdate ;
    qrmProdutoTotal.Lines.BeginUpdate ;
    qrmProdutoBCICMS.Lines.BeginUpdate ;
    qrmProdutoVALORICMS.Lines.BeginUpdate ;
    qrmProdutoVALORIPI.Lines.BeginUpdate ;
    qrmProdutoALIQICMS.Lines.BeginUpdate ;
    qrmProdutoALIQIPI.Lines.BeginUpdate ;

    qrmProdutoCodigo.Lines.Clear ;
    qrmProdutoDescricao.Lines.Clear ;
    qrmProdutoNCM.Lines.Clear ;
    qrmProdutoCST.Lines.Clear ;
    qrmProdutoCFOP.Lines.Clear ;
    qrmProdutoUnidade.Lines.Clear ;
    qrmProdutoQTDE.Lines.Clear ;
    qrmProdutoValor.Lines.Clear ;
    qrmProdutoTotal.Lines.Clear ;
    qrmProdutoBCICMS.Lines.Clear ;
    qrmProdutoVALORICMS.Lines.Clear ;
    qrmProdutoVALORIPI.Lines.Clear ;
    qrmProdutoALIQICMS.Lines.Clear ;
    qrmProdutoALIQIPI.Lines.Clear ;

end;

procedure TfqrDANFeQRRetrato.EndupdateProdutos;
begin
    qrmProdutoCodigo.Lines.EndUpdate ;
    qrmProdutoDescricao.Lines.EndUpdate ;
    qrmProdutoNCM.Lines.EndUpdate ;
    qrmProdutoCST.Lines.EndUpdate ;
    qrmProdutoCFOP.Lines.EndUpdate ;
    qrmProdutoUnidade.Lines.EndUpdate ;
    qrmProdutoQTDE.Lines.EndUpdate ;
    qrmProdutoValor.Lines.EndUpdate ;
    qrmProdutoTotal.Lines.EndUpdate ;
    qrmProdutoBCICMS.Lines.EndUpdate ;
    qrmProdutoVALORICMS.Lines.EndUpdate ;
    qrmProdutoVALORIPI.Lines.EndUpdate ;
    qrmProdutoALIQICMS.Lines.EndUpdate ;
    qrmProdutoALIQIPI.Lines.EndUpdate ;
end;

procedure TfqrDANFeQRRetrato.Observacoes;
var
  i: Integer;
begin
  with FNFe.InfAdic do
  begin
      qrmDadosAdicionais.Lines.BeginUpdate ;
      qrmDadosAdicionais.Lines.Clear ;
      for i:=0  to ObsCont.Count-1 do
        with ObsCont.Items[i] do
           qrmDadosAdicionais.Lines.Add(
                StringReplace  ( XCampo, '&lt;BR&gt;', #13#10, [rfReplaceAll,rfIgnoreCase] )+': '+
                StringReplace  ( XTexto, '&lt;BR&gt;', #13#10, [rfReplaceAll,rfIgnoreCase] ) );

      qrmDadosAdicionais.Lines.Add(StringReplace  ( InfCpl, '&lt;BR&gt;', #13#10, [rfReplaceAll,rfIgnoreCase] ) ) ;
      qrmDadosAdicionais.Lines.EndUpdate ;
  end;
end;


procedure TfqrDANFeQRRetrato.AddFatura;
var
  x : integer ;
begin
     //zera
     for x := 1 to 15 do
      begin
        TQRLabel ( FindComponent ( 'qrlFatNum'   + intToStr ( x ) ) ).Caption := '' ;
        TQRLabel ( FindComponent ( 'qrlFatData'  + intToStr ( x ) ) ).Caption := '' ;
        TQRLabel ( FindComponent ( 'qrlFatValor' + intToStr ( x ) ) ).Caption := '' ;
      end ;
     //adiciona
     for x := 0 to FNFe.Cobr.Dup.Count - 1 do
        with FNFe.Cobr.Dup[ x ] do
         begin
           TQRLabel ( FindComponent ( 'qrlFatNum'   + intToStr ( x + 1 ) ) ).Caption := NDup ;
           TQRLabel ( FindComponent ( 'qrlFatData'  + intToStr ( x + 1 ) ) ).Caption := NotaUtil.FormatDate( DateToStr(DVenc) ) ;
           TQRLabel ( FindComponent ( 'qrlFatValor' + intToStr ( x + 1 ) ) ).Caption := NotaUtil.FormatFloat(VDup) ;
         end;
end;

procedure TfqrDANFeQRRetrato.Header;
begin
  with FNFe.InfNFe, FNFe.Ide do
  begin

     qrlChave.Caption := NotaUtil.FormatarChaveAcesso ( Copy ( FNFe.InfNFe.Id, 4, 44 ) ) ;

     SetBarCodeImage ( Copy ( FNFe.InfNFe.Id, 4, 44 ), qriBarCode ) ;

     qrlNumNF0.Caption := FormatFloat ( '000,000,000', nNF ) ;
     qrlNumNF1.Caption := FormatFloat ( '000,000,000', nNF ) ;
     qrlNumNF2.Caption := FormatFloat ( '000,000,000', nNF ) ;


     qrlSERIE0.Caption :=  IntToStr(Serie) ;
     qrlSERIE1.Caption :=  IntToStr(Serie) ;
     qrlSERIE2.Caption :=  IntToStr(Serie) ;

     qrlNatOperacao.Caption :=  NatOp;
     if tpNF = tnEntrada  then // = entrada
        qrlEntradaSaida.Caption := '2'
     else
        qrlEntradaSaida.Caption := '1' ;

    qrlEmissao.Caption   := NotaUtil.FormatDate(DateToStr(dEmi)) ;
    qrlSaida.Caption     := IfThen( DSaiEnt <> 0, NotaUtil.FormatDate(DateToStr(dSaiEnt))) ;
    qrlHoraSaida.Caption := '' ; // nao tem campo  ;

  end;

end;

procedure TfqrDANFeQRRetrato.Emitente;
begin
  //emit

  with FNFe.Emit do
  begin
    if FRecebemoDe = '' then
       FRecebemoDe := qrlRecebemosDe1.Caption ;

    qrlRecebemosDe1.Caption := Format ( FRecebemoDe, [ XNome ] ) ;
    qrlRecebemosDe2.Caption := qrlRecebemosDe1.Caption ;

    qrlCNPJ.Caption := NotaUtil.FormatarCNPJ( CNPJCPF  ) ;
    qrlInscrEstSubst.caption := IEST ;
    qrlInscricaoEstadual.Caption := IE ;
    qrmEmitente.Lines.Text   := XNome ;
    //.Caption := XFant ;
    with EnderEmit do
    begin
      qrmEndereco.Lines.Clear ;
      qrmEndereco.Lines.add ( XLgr + IfThen ( Nro = '0', '', ', ' + Nro ) + ' ' + XCpl + ' ' + XBairro ) ;
     // .Caption := CMun ;
     qrmEndereco.Lines.add ( NotaUtil.FormatarCEP( IntToStr(CEP) ) + ' - ' + XMun + ' - ' + UF ) ;
     if Trim(FUrl) <> '' then
       qrmEndereco.Lines.add ( FUrl ) ;
     // .Caption := CPais ;
     // .Caption := XPais ;
     qrlFone.Caption := NotaUtil.FormatarFone( Fone ) ;
    end;

  end;
end;

procedure TfqrDANFeQRRetrato.Destinatario;
begin
  // destinatario
  with FNFe.Dest do
  begin
    if Trim ( CNPJCPF ) <>  '' then
      qrlDestCNPJ.Caption  := NotaUtil.FormatarCNPJ( CNPJCPF )
    else
      qrlDestCNPJ.Caption  := NotaUtil.FormatarCPF( CNPJCPF ) ;

    qrlDestIE.Caption   := IE ;
    qrlDestNome.Caption := XNome ;
    with EnderDest do
    begin
      qrlDestEndereco.Caption := XLgr + IfThen ( Nro = '0', '', ', ' + Nro ) ;
      //.Caption := XCpl ;
      qrlDestBairro.Caption := XBairro ;
      //.Caption := CMun ;
      qrlDestCidade.Caption := XMun ;
      qrlDestUF.Caption := UF ;
      qrlDestCEP.Caption := NotaUtil.FormatarCEP( IntToStr(CEP) ) ;
      //.Caption := CPais ;
      //.Caption := XPais ;
      qrlDestFONE.Caption := NotaUtil.FormatarFone( Fone ) ;
    end;
  end;
end;

procedure TfqrDANFeQRRetrato.Imposto;
begin
  with FNFe.Total.ICMSTot do
  begin
    qrlBaseICMS.Caption      := NotaUtil.FormatFloat( VBC ) ;
    qrlValorICMS.Caption     := NotaUtil.FormatFloat( VICMS ) ;
    qrlBaseICMST.Caption     := NotaUtil.FormatFloat( VBCST ) ;
    qrlValorICMST.Caption    := NotaUtil.FormatFloat( VST ) ;
    qrlTotalProdutos.Caption := NotaUtil.FormatFloat( VProd ) ;
    qrlValorFrete.Caption    := NotaUtil.FormatFloat( VFrete ) ;
    qrlValorSeguro.Caption   := NotaUtil.FormatFloat( VSeg ) ;
    qrlDescontos.Caption     := NotaUtil.FormatFloat( VDesc ) ;
    qrlAcessorias.Caption    := NotaUtil.FormatFloat( VOutro ) ;
//    .Caption               := NotaUtil.FormatFloat( VII ) ;
    qrlValorIPI.Caption      := NotaUtil.FormatFloat( VIPI ) ;
//    .Caption               := NotaUtil.FormatFloat( VPIS ) ;
//    .Caption               := NotaUtil.FormatFloat( VCOFINS ) ;
    qrlTotalNF.Caption       := NotaUtil.FormatFloat( VNF ) ;
  end;
end;

procedure TfqrDANFeQRRetrato.Transporte;
begin
  with FNFe.Transp do
  begin
    qrlTransModFrete.Caption := modFreteToStr( ModFrete ) ;

    qrlTransCodigoANTT.Caption := '' ;
    qrlTransPlaca.Caption := '' ;
    qrlTransUFPlaca.Caption := '' ;

    with Transporta do
    begin
      if Trim ( CNPJCPF ) <> '' then
        qrlTransCNPJ.Caption := CNPJCPF 
      else
        qrlTransCNPJ.Caption := '' ;

    qrlTransNome.Caption     := XNome ;
    qrlTransIE.Caption       := IE ;
    qrlTransEndereco.Caption := XEnder ;
    qrlTransCidade.Caption   := XMun ;
    qrlTransUF.Caption       := UF ;
    end;
  end;

  with FNFe.Transp.VeicTransp do
  begin
    qrlTransPlaca.Caption   :=  Placa ;
    qrlTransUFPlaca.Caption :=  UF;
    //.Caption :=  RNTC;
  end;

  if FNFe.Transp.Vol.Count > 0 then
   begin
     with FNFe.Transp.Vol[0] do
      begin
        qrlTransQTDE.Caption       :=  IntToStr(QVol) ;
        qrlTransEspecie.Caption    :=  Esp   ;
        qrlTransMarca.Caption      :=  Marca ;
        qrlTransNumeracao.Caption  :=  NVol  ;
        qrlTransPesoLiq.Caption    :=  NotaUtil.FormatFloat( PesoL, '#,0.00##' ) ;
        qrlTransPesoBruto.Caption  :=  NotaUtil.FormatFloat( PesoB, '#,0.00##' ) ;
      end;
   end
  else
   begin
     qrlTransQTDE.Caption       :=  '' ;
     qrlTransEspecie.Caption    :=  '' ;
     qrlTransMarca.Caption      :=  '' ;
     qrlTransNumeracao.Caption  :=  '' ;
     qrlTransPesoLiq.Caption    :=  '' ;
     qrlTransPesoBruto.Caption  :=  '' ;
   end;
end;

procedure TfqrDANFeQRRetrato.qrsISSQNBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  PrintBand := False ;
end;

procedure TfqrDANFeQRRetrato.ValorFiscal;
begin
 FSemValorFiscal  := FNFe.Ide.TpAmb = taHomologacao ;

{ qrlSemValorFiscal0.Enabled :=  FSemValorFiscal ; //qrlSemValorFiscalPrint ;
 qrlSemValorFiscal1.Enabled :=  FSemValorFiscal ; //qrlSemValorFiscalPrint ;
 qrlSemValorFiscal2.Enabled :=  FSemValorFiscal ; //qrlSemValorFiscalPrint ;
 qrlSemValorFiscal3.Enabled :=  FSemValorFiscal ; //qrlSemValorFiscalPrint ;
 qrlSemValorFiscal4.Enabled :=  FSemValorFiscal ; //qrlSemValorFiscalPrint ;
 qrlSemValorFiscal5.Enabled :=  FSemValorFiscal ; //qrlSemValorFiscalPrint ;
 qrlSemValorFiscal6.Enabled :=  FSemValorFiscal ; //qrlSemValorFiscalPrint ;

 qrlSemValorFiscal0.OnPrint :=  qrlSemValorFiscalPrint ; //qrlSemValorFiscalPrint ;
 qrlSemValorFiscal1.OnPrint :=  qrlSemValorFiscalPrint ; //qrlSemValorFiscalPrint ;
 qrlSemValorFiscal2.OnPrint :=  qrlSemValorFiscalPrint ; //qrlSemValorFiscalPrint ;
 qrlSemValorFiscal3.OnPrint :=  qrlSemValorFiscalPrint ; //qrlSemValorFiscalPrint ;
 qrlSemValorFiscal4.OnPrint :=  qrlSemValorFiscalPrint ; //qrlSemValorFiscalPrint ;
 qrlSemValorFiscal5.OnPrint :=  qrlSemValorFiscalPrint ; //qrlSemValorFiscalPrint ;
 qrlSemValorFiscal6.OnPrint :=  qrlSemValorFiscalPrint ; //qrlSemValorFiscalPrint ;
 }
end;

procedure TfqrDANFeQRRetrato.QRNFeAfterPreview(Sender: TObject);
begin
   AfterPreview := True ;
end;

procedure TfqrDANFeQRRetrato.ChildBand2BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin

  qrlPageNumber.Caption := format ( '%2.2d', [ QRNFe.PageNumber ] )
                   + '/' + format ( '%2.2d', [ FTotalPages ] ) ;
  qriBarCode.BringToFront ;

//  if AfterPreview and not ChangedPos then
//     begin
//        qrBarCode.Left := qrBarCode.Left - 175 ;
//        ChangedPos := True ;
//     end ;
end;

procedure TfqrDANFeQRRetrato.Detalhes;
var
  x : integer ;
begin

  BeginUpdateProdutos ;

  for x := DetItem to FNFe.Det.Count - 1 do
    with FNFe.Det.Items[ x ] do
      begin

        with Prod do
        begin
          qrmProdutoCodigo.Lines.add    (  CProd  ) ;
          qrmProdutoDescricao.Lines.add (  XProd  ) ;
          qrmProdutoNCM.Lines.add       (  NCM    ) ;
          qrmProdutoCFOP.Lines.add      (  CFOP   ) ;
          qrmProdutoUnidade.Lines.add   (  UCom   ) ;
          qrmProdutoQTDE.Lines.add      (  NotaUtil.FormatFloat( QCom   ) ) ;
          qrmProdutoValor.Lines.add     (  NotaUtil.FormatFloat( VUnCom ) ) ;
          qrmProdutoTotal.Lines.add     (  NotaUtil.FormatFloat( VProd  ) ) ;


          with Imposto.ICMS do
          begin
            if CST = cst00 then
              begin
                qrmProdutoCST.lines.Add       ( OrigToStr(orig) + CSTICMSToStr(CST) ) ;
                qrmProdutoBCICMS.Lines.add    ( NotaUtil.FormatFloat( VBC ) ) ;
                qrmProdutoALIQICMS.Lines.add  ( NotaUtil.FormatFloat( PICMS ) ) ;
                qrmProdutoVALORICMS.Lines.add ( NotaUtil.FormatFloat( VICMS ) ) ;
              end
            else if CST = cst10 then
              begin
                qrmProdutoCST.lines.Add ( OrigToStr(orig) + CSTICMSToStr(CST) );
                qrmProdutoBCICMS.Lines.add    ( NotaUtil.FormatFloat( VBC ) ) ;
                qrmProdutoALIQICMS.Lines.add  ( NotaUtil.FormatFloat( PICMS ) ) ;
                qrmProdutoVALORICMS.Lines.add ( NotaUtil.FormatFloat( VICMS ) ) ;
              end
            else if CST = cst20 then
              begin
                qrmProdutoCST.lines.Add ( OrigToStr(orig) + CSTICMSToStr(CST) );
                qrmProdutoBCICMS.Lines.add    ( NotaUtil.FormatFloat( VBC ) ) ;
                qrmProdutoALIQICMS.Lines.add  ( NotaUtil.FormatFloat( PICMS ) ) ;
                qrmProdutoVALORICMS.Lines.add ( NotaUtil.FormatFloat( VICMS ) ) ;
              end
            else if CST = cst30 then
              begin
                qrmProdutoCST.lines.Add ( OrigToStr(orig) + CSTICMSToStr(CST) );
                qrmProdutoBCICMS.Lines.add    ( NotaUtil.FormatFloat( VBCST ) ) ;
                qrmProdutoALIQICMS.Lines.add  ( NotaUtil.FormatFloat( PICMSST ) ) ;
                qrmProdutoVALORICMS.Lines.add ( NotaUtil.FormatFloat( VICMSST ) ) ;
              end
            else if (CST = cst40) or (CST = cst41) or (CST = cst50) then
              begin
                qrmProdutoCST.lines.Add ( OrigToStr(orig) + CSTICMSToStr(CST) );
                qrmProdutoBCICMS.Lines.add    ( '0.00' );
                qrmProdutoALIQICMS.Lines.add  ( '0.00' );
                qrmProdutoVALORICMS.Lines.add ( '0.00' );
              end
            else if (CST = cst51) then
              begin
                qrmProdutoCST.lines.Add ( OrigToStr(orig) + CSTICMSToStr(CST) );
                qrmProdutoBCICMS.Lines.add    ( NotaUtil.FormatFloat( VBC ) ) ;
                qrmProdutoALIQICMS.Lines.add  ( NotaUtil.FormatFloat( PICMS ) ) ;
                qrmProdutoVALORICMS.Lines.add ( NotaUtil.FormatFloat( VICMS ) ) ;
              end
            else if (CST = cst60) then
              begin
                qrmProdutoCST.lines.Add ( OrigToStr(orig) + CSTICMSToStr(CST) );
                qrmProdutoBCICMS.Lines.add    ( NotaUtil.FormatFloat( VBCST ) ) ;
                qrmProdutoALIQICMS.Lines.add  ( '0.00' );
                qrmProdutoVALORICMS.Lines.add ( NotaUtil.FormatFloat( VICMSST ) ) ;
              end
            else if (CST = cst70) then
              begin
                qrmProdutoCST.lines.Add ( OrigToStr(orig) + CSTICMSToStr(CST) );
                qrmProdutoBCICMS.Lines.add    ( NotaUtil.FormatFloat( VBC ) ) ;
                qrmProdutoALIQICMS.Lines.add  ( NotaUtil.FormatFloat( PICMS ) ) ;
                qrmProdutoVALORICMS.Lines.add ( NotaUtil.FormatFloat( VICMS ) ) ;
              end
            else if (CST = cst90) then
              begin
                qrmProdutoCST.lines.Add ( OrigToStr(orig) + CSTICMSToStr(CST) );
                qrmProdutoBCICMS.Lines.add    ( NotaUtil.FormatFloat( VBC ) ) ;
                qrmProdutoALIQICMS.Lines.add  ( NotaUtil.FormatFloat( PICMS ) ) ;
                qrmProdutoVALORICMS.Lines.add ( NotaUtil.FormatFloat( VICMS ) ) ;
              end;
          end;

          with Imposto.IPI do
          begin
            if (CST = ipi00) or (CST = ipi49) or
               (CST = ipi50) or (CST = ipi99) then
              begin
                  qrmProdutoALIQIPI.Lines.add  ( NotaUtil.FormatFloat( PIPI ) ) ;
                  qrmProdutoVALORIPI.Lines.add  ( NotaUtil.FormatFloat( VIPI ) ) ;
              end
            else if (CST = ipi01) or (CST = ipi02) or (CST = ipi03) or
                    (CST = ipi04) or (CST = ipi51) or (CST = ipi52) or
                    (CST = ipi53) or (CST = ipi54) or (CST = ipi55) then
              begin
                  qrmProdutoALIQIPI.Lines.add  ( '0.00' ) ;
                  qrmProdutoVALORIPI.Lines.add  ( '0.00' ) ;
              end
          end;
        end;

//        DetItem := x ;
        Inc( DetItem );

        if QRNFe.PageNumber = 0 then
           begin
             if DetItem = ( _NUM_ITEMS_PAGE1 -1 )  then // Tirar o -15 é só teste
                break ;
           end
        else if DetItem = ( _NUM_ITEMS_OTHERPAGES -1 ) then
              break ;
      end;

  EndUpdateProdutos ;
end;


end.




