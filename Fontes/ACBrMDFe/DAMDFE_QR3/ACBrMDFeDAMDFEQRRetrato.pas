{******************************************************************************}
{ Projeto: Componente ACBrMDFe                                                 }
{  Biblioteca multiplataforma de componentes Delphi                            }
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
|* 01/08/2012: Italo Jurisato Junior
|*  - Doação do componente para o Projeto ACBr
******************************************************************************}

{$I ACBr.inc}

unit ACBrMDFeDAMDFEQRRetrato;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, QuickRpt, QRCtrls,  XMLIntf, XMLDoc, JPEG,
  pcnConversao, pmdfeConversao, DB, DBClient,
  ACBrMDFeDAMDFEQR, ACBrMDFeDAMDFEQRCodeBar, ACBrMDFeDAMDFEClass,
  ACBrMDFeDAMDFEQRClass;

type

  TfqrDAMDFEQRRetrato = class(TfqrDAMDFEQR)
    qrb_1_DadosManifesto: TQRBand;
    qrsQuadro4: TQRShape;
    qrsQuadro3: TQRShape;
    qrsQuadro2: TQRShape;
    qrsQuadro1: TQRShape;
    qrsHorizontal1: TQRShape;
    QRLabel8: TQRLabel;
    QRLabel17: TQRLabel;
    qriLogo: TQRImage;
    qrmEmitente: TQRMemo;
    qrmDadosEmitente: TQRMemo;
    qriBarCode: TQRImage;
    QRShape1: TQRShape;
    QRLabel74: TQRLabel;
    QRShape2: TQRShape;
    QRLabel1: TQRLabel;
    qrlChave: TQRLabel;
    QRLabel2: TQRLabel;
    qrlModelo: TQRLabel;
    QRLabel3: TQRLabel;
    qrlSerie: TQRLabel;
    QRLabel4: TQRLabel;
    qrlNumMDFe: TQRLabel;
    QRLabel25: TQRLabel;
    qrlPageNumber: TQRLabel;
    QRLabel33: TQRLabel;
    qrlEmissao: TQRLabel;
    QRLabel77: TQRLabel;
    qrlUFCarrega: TQRLabel;
    qrsLinhaV09: TQRShape;
    qrsLinhaV08: TQRShape;
    qrsLinhaV07: TQRShape;
    qrsLinhaV06: TQRShape;
    qrsLinhaV05: TQRShape;
    qrsLinhaV10: TQRShape;
    qrlDescricao: TQRLabel;
    qrlProtocolo: TQRLabel;
    qrlModal: TQRLabel;
    QRLabel6: TQRLabel;
    QRLabel5: TQRLabel;
    QRLabel7: TQRLabel;
    QRLabel10: TQRLabel;
    QRLabel11: TQRLabel;
    QRLabel12: TQRLabel;
    QRShape3: TQRShape;
    QRShape4: TQRShape;
    QRShape5: TQRShape;
    QRShape6: TQRShape;
    QRShape7: TQRShape;
    qrlCIOT: TQRLabel;
    qrlqCTe: TQRLabel;
    qrlqCT: TQRLabel;
    qrlqNFe: TQRLabel;
    qrlqNF: TQRLabel;
    qrlPesoTotal: TQRLabel;
    qrb_2_Rodo: TQRChildBand;
    QRShape8: TQRShape;
    QRLabel35: TQRLabel;
    QRLabel9: TQRLabel;
    QRShape9: TQRShape;
    QRLabel13: TQRLabel;
    QRLabel14: TQRLabel;
    QRLabel15: TQRLabel;
    QRLabel16: TQRLabel;
    QRShape10: TQRShape;
    QRShape11: TQRShape;
    QRShape12: TQRShape;
    qrmPlaca: TQRMemo;
    qrmRNTRC: TQRMemo;
    qrmCPF: TQRMemo;
    QRShape13: TQRShape;
    qrmCondutor: TQRMemo;
    QRShape14: TQRShape;
    QRLabel18: TQRLabel;
    QRShape15: TQRShape;
    QRLabel19: TQRLabel;
    QRLabel20: TQRLabel;
    QRLabel21: TQRLabel;
    QRShape16: TQRShape;
    QRShape17: TQRShape;
    qrmRespCNPJ: TQRMemo;
    qrmFornCNPJ: TQRMemo;
    qrmNumComprovante: TQRMemo;
    qrb_3_Aereo: TQRChildBand;
    qrb_4_Aquav: TQRChildBand;
    qrb_5_Ferrov: TQRChildBand;
    qrb_6_Observacao: TQRChildBand;
    QRShape18: TQRShape;
    QRLabel22: TQRLabel;
    qrmObservacao: TQRMemo;
    qrlMsgTeste: TQRLabel;
    QRBand1: TQRBand;
    cdsItens: TClientDataSet;
    cdsItensChave_1: TStringField;
    cdsItensChave_2: TStringField;
    procedure QRMDFeBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
    procedure qrb_1_DadosManifestoBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure qrb_2_RodoBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure qrb_3_AereoBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure qrb_4_AquavBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure qrb_5_FerrovBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure qrb_6_ObservacaoBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
  private
    { Private declarations }
    FTotalPages : integer;
  public
    { Public declarations }
    procedure ProtocoloMDFe( const sProtocolo : String );
  end;


implementation

uses
  StrUtils, DateUtils, 
  pmdfeMDFe, ACBrUtil, ACBrDFeUtil, ACBrMDFeUtil;

{$R *.dfm}

const
   _NUM_ITEMS_PAGE1      = 18;
   _NUM_ITEMS_OTHERPAGES = 50;

var
   FProtocoloMDFe : String;
   nItemControle : Integer;

procedure TfqrDAMDFEQRRetrato.ProtocoloMDFe( const sProtocolo : String );
begin
   FProtocoloMDFe := sProtocolo;
end;

procedure TfqrDAMDFEQRRetrato.QRMDFeBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
var
  nRestItens : Integer;
begin
  inherited;

   nItemControle := 0;
   FTotalPages   := 1;

   QRMDFe.ReportTitle:='Manifesto Eletrônico de Documentos Fiscais - MDF-e';

   QRMDFe.Page.TopMargin    := FMargemSuperior * 100;
   QRMDFe.Page.BottomMargin := FMargemInferior * 100;
   QRMDFe.Page.LeftMargin   := FMargemEsquerda * 100;
   QRMDFe.Page.RightMargin  := FMargemDireita  * 100;
end;

procedure TfqrDAMDFEQRRetrato.qrb_1_DadosManifestoBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  inherited;

  if Trim(FLogo) <> '' then
   begin
    qriLogo.Picture.LoadFromFile(FLogo);
   end;

  if FExpandirLogoMarca then
   begin
    qriLogo.top:=2;
    qriLogo.Left:=2;
    qriLogo.Height:=142;
    qriLogo.Width:=330;
    qriLogo.Stretch:=true;
    qrmEmitente.Enabled:=False;
    qrmDadosEmitente.Enabled:=False;
   end;

  if not FExpandirLogoMarca then
   begin
    qrmEmitente.Enabled:=True;
    qrmDadosEmitente.Enabled:=True;
    // Emitente
    with FMDFe.Emit do
    begin
      qrmEmitente.Lines.Text := XNome;

      qrmDadosEmitente.Lines.Clear;
      with EnderEmit do
      begin
        qrmDadosEmitente.Lines.Add(XLgr + IfThen(Nro = '0', '', ', ' + Nro));
        if XCpl<>'' then qrmDadosEmitente.Lines.Add(XCpl);
        if XBairro<>'' then qrmDadosEmitente.Lines.Add(XBairro);
        qrmDadosEmitente.Lines.Add('CEP: ' + DFeUtil.FormatarCEP(FormatFloat( '00000000', CEP )) + ' - ' + XMun + ' - ' + UF);
      end;
      qrmDadosEmitente.Lines.Add('CNPJ: ' + DFeUtil.FormatarCNPJ(CNPJ));
      qrmDadosEmitente.Lines.Add('INSCRIÇÃO ESTADUAL: ' + IE);
      qrmDadosEmitente.Lines.Add('TELEFONE: ' + DFeUtil.FormatarFone(EnderEmit.Fone));

//      if Trim(FUrl) <> '' then
//        qrmDadosEmitente.Lines.Add(FUrl);
    end;
   end;

  SetBarCodeImage( Copy ( FMDFe.InfMDFe.Id, 5, 44 ), qriBarCode );
  qrlChave.Caption      := MDFeUtil.FormatarChaveAcesso(Copy(FMDFe.InfMDFe.Id, 5, 44));

  if FMDFe.ide.tpEmis = teNormal
   then begin
    qrlProtocolo.Font.Size  := 8;
    qrlProtocolo.Font.Style := [fsBold];
    if FProtocoloMDFE <> ''
     then qrlProtocolo.Caption := FProtocoloMDFE
     else qrlProtocolo.Caption := FMDFe.procMDFe.nProt + '   ' +
                                  DFeUtil.SeSenao(FMDFe.procMDFe.dhRecbto <> 0,
                                      DateTimeToStr(FMDFe.procMDFe.dhRecbto), '');
   end
   else begin
    qrlProtocolo.Font.Size  := 5;
    qrlProtocolo.Font.Style := [];
    qrlProtocolo.Caption := 'Impressão em contingência. Obrigatória a autorização em 24 horas' +
     ' após esta impressão (' + DFeUtil.FormatDateTime(DateTimeToStr(Now)) + ')';
   end;

  qrlModelo.Caption     := FMDFe.Ide.modelo;
  qrlSerie.Caption      := FormatFloat( '000', FMDFe.Ide.serie);
  qrlNumMDFe.Caption    := FormatFloat( '000,000,000', FMDFe.Ide.nMDF );
  qrlPageNumber.Caption := format('%2.2d', [QRMDFe.PageNumber]) + '/' + format('%2.2d', [FTotalPages]);
  qrlEmissao.Caption    := DFeUtil.FormatDateTime(DateTimeToStr(FMDFe.Ide.dhEmi));
  qrlUFCarrega.Caption  := FMDFe.Ide.UFIni;

  // TMDFeModal      = ( moRodoviario, moAereo, moAquaviario, moFerroviario );
  case FMDFe.Ide.modal of
   moRodoviario:  begin
                   qrlModal.Caption := 'MODAL RODOVIÁRIO DE CARGA';
                   qrlCIOT.Caption := FMDFe.rodo.CIOT;
                  end;
   moAereo:       begin
                   qrlModal.Caption := 'MODAL AÉREO DE CARGA';
                  end;
   moAquaviario:  begin
                   qrlModal.Caption := 'MODAL AQUAVIÁRIO DE CARGA';
                  end;
   moFerroviario: begin
                   qrlModal.Caption := 'MODAL FERROVIÁRIO DE CARGA';
                  end;
  end;

  qrlqCTe.Caption      := FormatFloat( '##0', FMDFe.tot.qCTe);
  qrlqCT.Caption       := FormatFloat( '##0', FMDFe.tot.qCT);
  qrlqNFe.Caption      := FormatFloat( '##0', FMDFe.tot.qNFe);
  qrlqNF.Caption       := FormatFloat( '##0', FMDFe.tot.qNF);
  
  // UnidMed = (uM3,uKG, uTON, uUNIDADE, uLITROS, uMMBTU);
  if FMDFe.tot.cUnid = uKG
   then qrlPesoTotal.Caption := FormatFloat( '#,##0.###', FMDFe.tot.qCarga)
   else qrlPesoTotal.Caption := FormatFloat( '#,##0.###', FMDFe.tot.qCarga * 1000);
end;

procedure TfqrDAMDFEQRRetrato.qrb_2_RodoBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
var
 i: Integer;
begin
  inherited;

//  PrintBand := QRMDFe.PageNumber = 1;
  qrb_2_Rodo.Enabled := (FMDFe.Ide.modal = moRodoviario);

  qrmPlaca.Lines.Clear;
  qrmPlaca.Lines.Add(MDFeUtil.FormatarPlaca(FMDFe.rodo.veicPrincipal.placa));

  qrmRNTRC.Lines.Clear;
  qrmRNTRC.Lines.Add(FMDFe.rodo.veicPrincipal.RNTRC);

  for i := 0 to FMDFe.rodo.veicReboque.Count -1 do
   begin
    qrmPlaca.Lines.Add(MDFeUtil.FormatarPlaca(FMDFe.rodo.veicReboque.Items[i].placa));
    qrmRNTRC.Lines.Add(FMDFe.rodo.veicReboque.Items[i].RNTRC);
   end;

  qrmCPF.Lines.Clear;
  qrmCondutor.Lines.Clear;

  for i := 0 to FMDFe.rodo.veicPrincipal.condutor.Count -1 do
   begin
    qrmCPF.Lines.Add(DFeUtil.FormatarCPF(FMDFe.rodo.veicPrincipal.condutor.Items[i].CPF));
    qrmCondutor.Lines.Add(FMDFe.rodo.veicPrincipal.condutor.Items[i].xNome);
   end;

  qrmRespCNPJ.Lines.Clear;
  qrmFornCNPJ.Lines.Clear;
  qrmNumComprovante.Lines.Clear;

  for i := 0 to FMDFe.rodo.valePed.disp.Count -1 do
   begin
    qrmRespCNPJ.Lines.Add(DFeUtil.FormatarCNPJ(FMDFe.rodo.valePed.disp.Items[i].CNPJPg));
    qrmFornCNPJ.Lines.Add(DFeUtil.FormatarCNPJ(FMDFe.rodo.valePed.disp.Items[i].CNPJForn));
    qrmNumComprovante.Lines.Add(FMDFe.rodo.valePed.disp.Items[i].nCompra);
   end;
end;

procedure TfqrDAMDFEQRRetrato.qrb_3_AereoBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  inherited;

//  PrintBand := QRMDFe.PageNumber = 1;
  qrb_3_Aereo.Enabled := (FMDFe.Ide.modal = moAereo);
end;

procedure TfqrDAMDFEQRRetrato.qrb_4_AquavBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  inherited;

//  PrintBand := QRMDFe.PageNumber = 1;
  qrb_4_Aquav.Enabled := (FMDFe.Ide.modal = moAquaviario);
end;

procedure TfqrDAMDFEQRRetrato.qrb_5_FerrovBeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  inherited;

//  PrintBand := QRMDFe.PageNumber = 1;
  qrb_5_Ferrov.Enabled := (FMDFe.Ide.modal = moFerroviario);
end;

procedure TfqrDAMDFEQRRetrato.qrb_6_ObservacaoBeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  inherited;

  qrmObservacao.Lines.BeginUpdate;
  qrmObservacao.Lines.Clear;
  qrmObservacao.Lines.Add(StringReplace( FMDFe.infAdic.infCpl, '&lt;BR&gt;', #13#10, [rfReplaceAll,rfIgnoreCase] ) );
  qrmObservacao.Lines.Text:=StringReplace(qrmObservacao.Lines.Text,';',#13,[rfReplaceAll]);
  qrmObservacao.Lines.EndUpdate;

  // Mensagem para modo Homologacao.

  if FMDFe.Ide.tpAmb = taHomologacao then
   begin
    qrlMsgTeste.Caption := 'AMBIENTE DE HOMOLOGAÇÃO - SEM VALOR FISCAL';
    qrlMsgTeste.Enabled := True;
    qrlMsgTeste.Visible := True;
   end
   else begin
    qrlMsgTeste.Enabled := False;
    qrlMsgTeste.Visible := False;
   end;

  qrlMsgTeste.Repaint;
end;

end.
