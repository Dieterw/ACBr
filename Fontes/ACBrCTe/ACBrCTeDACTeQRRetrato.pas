{******************************************************************************}
{ Projeto: Componente ACBrNFe                                                  }
{  Biblioteca multiplataforma de componentes Delphi para emissão de Nota Fiscal}
{ eletrônica - NFe - http://www.nfe.fazenda.gov.br                             }
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


{$I ACBr.inc}

unit ACBrCTeDACTeQRRetrato;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, QuickRpt, QRCtrls, XMLIntf, XMLDoc, 
  JPEG, ACBrCTeQRCodeBar, pcnConversao, DB,
  DBClient, ACBrCTeDACTeQR, qrRRect;

type
  TfrmDACTeQRRetrato = class(TfrmDACTeQR)
    qrbItens: TQRBand;
    qrbSistema: TQRChildBand;
    qrdbtTpDoc1: TQRDBText;
    cdsDocumentos: TClientDataSet;
    qrdbtCnpjEmitente1: TQRDBText;
    qrdbtDocumento1: TQRDBText;
    qrdbtDocumento2: TQRDBText;
    qrdbtCnpjEmitente2: TQRDBText;
    qrdbtTpDoc2: TQRDBText;
    cdsDocumentosTIPO_1: TStringField;
    cdsDocumentosCNPJCPF_1: TStringField;
    cdsDocumentosDOCUMENTO_1: TStringField;
    cdsDocumentosTIPO_2: TStringField;
    cdsDocumentosCNPJCPF_2: TStringField;
    cdsDocumentosDOCUMENTO_2: TStringField;
    QRShape29: TQRShape;
    qrbCabecalho: TQRBand;
    QRShape11: TQRShape;
    qrmEmitente: TQRMemo;
    qrmDadosEmitente: TQRMemo;
    qriLogo: TQRImage;
    qriBarCode: TQRImage;
    qrlNumCte: TQRLabel;
    QRLabel17: TQRLabel;
    QRLabel18: TQRLabel;
    QRLabel6: TQRLabel;
    QRLabel8: TQRLabel;
    QRLabel21: TQRLabel;
    QRLabel23: TQRLabel;
    QRLabel25: TQRLabel;
    QRLabel33: TQRLabel;
    QRLabel73: TQRLabel;
    QRLabel74: TQRLabel;
    QRLabel75: TQRLabel;
    qrlChave: TQRLabel;
    qrlPageNumber: TQRLabel;
    qrlSerie: TQRLabel;
    qrlModelo: TQRLabel;
    qrlEmissao: TQRLabel;
    qrlModal: TQRLabel;
    qrlProtocolo: TQRLabel;
    qrlTipoCte: TQRLabel;
    qrlDescricao: TQRLabel;
    QRLabel77: TQRLabel;
    QRLabel2: TQRLabel;
    QRLabel9: TQRLabel;
    qrlTipoServico: TQRLabel;
    QRLabel28: TQRLabel;
    qrlTomaServico: TQRLabel;
    QRLabel78: TQRLabel;
    qrlFormaPagamento: TQRLabel;
    qrlInscSuframa: TQRLabel;
    qrbHeaderItens: TQRBand;
    QRLabel20: TQRLabel;
    QRShape32: TQRShape;
    QRLabel91: TQRLabel;
    QRLabel92: TQRLabel;
    QRLabel96: TQRLabel;
    QRLabel100: TQRLabel;
    QRLabel106: TQRLabel;
    QRLabel109: TQRLabel;
    QRShape34: TQRShape;
    QRShape28: TQRShape;
    QRShape35: TQRShape;
    qrsFimItens: TQRShape;
    qrbDadosExcEmitente: TQRBand;
    qrbDadosDACTe: TQRChildBand;
    QRLabel29: TQRLabel;
    qrlNatOperacao: TQRLabel;
    QRLabel12: TQRLabel;
    qrlOrigPrestacao: TQRLabel;
    QRLabel14: TQRLabel;
    qrlDestPrestacao: TQRLabel;
    QRLabel13: TQRLabel;
    QRLabel16: TQRLabel;
    QRLabel22: TQRLabel;
    QRLabel24: TQRLabel;
    QRLabel26: TQRLabel;
    qrlRazaoRemet: TQRLabel;
    qrlEnderecoRemet1: TQRLabel;
    qrlEnderecoRemet2: TQRLabel;
    qrlMunRemet: TQRLabel;
    qrlCnpjRemet: TQRLabel;
    qrlPaisRemet: TQRLabel;
    QRLabel27: TQRLabel;
    QRLabel30: TQRLabel;
    QRLabel31: TQRLabel;
    QRLabel32: TQRLabel;
    QRLabel79: TQRLabel;
    qrlRazaoDest: TQRLabel;
    qrlEnderecoDest1: TQRLabel;
    qrlEnderecoDest2: TQRLabel;
    QRLabel93: TQRLabel;
    qrlInscEstRemet: TQRLabel;
    QRLabel95: TQRLabel;
    qrlFoneRemet: TQRLabel;
    qrlCEPRemet: TQRLabel;
    QRLabel98: TQRLabel;
    qrlMunDest: TQRLabel;
    qrlPaisDest: TQRLabel;
    qrlCnpjDest: TQRLabel;
    QRLabel114: TQRLabel;
    qrlInscEstDest: TQRLabel;
    QRLabel116: TQRLabel;
    qrlFoneDest: TQRLabel;
    qrlCEPDest: TQRLabel;
    QRLabel119: TQRLabel;
    QRLabel86: TQRLabel;
    QRLabel87: TQRLabel;
    QRLabel88: TQRLabel;
    QRLabel89: TQRLabel;
    QRLabel90: TQRLabel;
    qrlRazaoExped: TQRLabel;
    qrlEnderecoExped1: TQRLabel;
    qrlEnderecoExped2: TQRLabel;
    QRLabel99: TQRLabel;
    QRLabel101: TQRLabel;
    QRLabel102: TQRLabel;
    QRLabel103: TQRLabel;
    QRLabel104: TQRLabel;
    qrlRazaoReceb: TQRLabel;
    qrlEnderecoReceb1: TQRLabel;
    qrlEnderecoReceb2: TQRLabel;
    qrlMunExped: TQRLabel;
    qrlPaisExped: TQRLabel;
    qrlCnpjExped: TQRLabel;
    QRLabel105: TQRLabel;
    qrlInscEstExped: TQRLabel;
    QRLabel107: TQRLabel;
    qrlFoneExped: TQRLabel;
    qrlCEPExped: TQRLabel;
    QRLabel110: TQRLabel;
    qrlMunReceb: TQRLabel;
    qrlPaisReceb: TQRLabel;
    qrlCnpjReceb: TQRLabel;
    QRLabel123: TQRLabel;
    qrlInscEstReceb: TQRLabel;
    QRLabel125: TQRLabel;
    qrlFoneReceb: TQRLabel;
    qrlCEPReceb: TQRLabel;
    QRLabel128: TQRLabel;
    QRLabel80: TQRLabel;
    QRLabel81: TQRLabel;
    QRLabel94: TQRLabel;
    qrlCEPToma: TQRLabel;
    QRLabel97: TQRLabel;
    qrlEnderecoToma: TQRLabel;
    QRLabel82: TQRLabel;
    qrlCnpjToma: TQRLabel;
    QRLabel108: TQRLabel;
    qrlInscEstToma: TQRLabel;
    QRLabel111: TQRLabel;
    qrlFoneToma: TQRLabel;
    qrlRazaoToma: TQRLabel;
    QRLabel113: TQRLabel;
    qrlPaisToma: TQRLabel;
    qrlMunToma: TQRLabel;
    QRLabel1: TQRLabel;
    qrlProdPredominante: TQRLabel;
    QRShape7: TQRShape;
    QRShape8: TQRShape;
    QRLabel5: TQRLabel;
    QRShape9: TQRShape;
    qrlNomeSeguradora: TQRLabel;
    QRLabel4: TQRLabel;
    qrlOutrasCaracCarga: TQRLabel;
    QRLabel34: TQRLabel;
    qrlVlrTotalMerc: TQRLabel;
    QRLabel37: TQRLabel;
    qrlRespSeguroMerc: TQRLabel;
    qrlNroApolice: TQRLabel;
    QRLabel39: TQRLabel;
    QRLabel40: TQRLabel;
    qrlNroAverbacao: TQRLabel;
    qrlQtdUndMedida1: TQRLabel;
    qrlQtdUndMedida2: TQRLabel;
    qrlQtdUndMedida3: TQRLabel;
    qrlQtdUndMedida4: TQRLabel;
    QRLabel35: TQRLabel;
    QRLabel36: TQRLabel;
    QRLabel41: TQRLabel;
    QRLabel43: TQRLabel;
    QRShape15: TQRShape;
    QRLabel38: TQRLabel;
    QRShape17: TQRShape;
    QRLabel44: TQRLabel;
    QRShape18: TQRShape;
    QRShape19: TQRShape;
    QRLabel46: TQRLabel;
    qrmCompNome1: TQRMemo;
    qrmCompValor1: TQRMemo;
    QRLabel42: TQRLabel;
    QRLabel45: TQRLabel;
    qrmCompNome2: TQRMemo;
    qrmCompValor2: TQRMemo;
    QRLabel47: TQRLabel;
    QRLabel48: TQRLabel;
    qrmCompNome3: TQRMemo;
    qrmCompValor3: TQRMemo;
    QRShape16: TQRShape;
    QRLabel49: TQRLabel;
    QRLabel50: TQRLabel;
    qrlVlrTotServico: TQRLabel;
    qrlVlrTotReceber: TQRLabel;
    QRShape20: TQRShape;
    QRLabel51: TQRLabel;
    QRShape21: TQRShape;
    QRShape22: TQRShape;
    QRShape23: TQRShape;
    QRLabel58: TQRLabel;
    QRLabel52: TQRLabel;
    QRShape25: TQRShape;
    QRShape26: TQRShape;
    QRLabel53: TQRLabel;
    QRLabel54: TQRLabel;
    QRLabel55: TQRLabel;
    QRLabel56: TQRLabel;
    qrlSitTrib: TQRLabel;
    qrlBaseCalc: TQRLabel;
    qrlVlrICMS: TQRLabel;
    qrlICMS_ST: TQRLabel;
    qrlRedBaseCalc: TQRLabel;
    qrlAliqICMS: TQRLabel;
    qrbObs: TQRChildBand;
    qrbModRodFracionado: TQRChildBand;
    QRLabel10: TQRLabel;
    QRShape1: TQRShape;
    qrmObs: TQRMemo;
    QRLabel3: TQRLabel;
    QRShape24: TQRShape;
    QRLabel11: TQRLabel;
    QRShape36: TQRShape;
    QRShape37: TQRShape;
    QRShape38: TQRShape;
    QRLabel83: TQRLabel;
    QRLabel84: TQRLabel;
    QRLabel85: TQRLabel;
    qrlRntrcEmpresa: TQRLabel;
    qrlLotacao: TQRLabel;
    qrlDtPrevEntrega: TQRLabel;
    QRLabel65: TQRLabel;
    QRShape2: TQRShape;
    QRLabel66: TQRLabel;
    QRShape3: TQRShape;
    QRShape53: TQRShape;
    QRLabel67: TQRLabel;
    QRShape30: TQRShape;
    QRLabel70: TQRLabel;
    QRLabel69: TQRLabel;
    QRLabel68: TQRLabel;
    qrlDHChegada: TQRLabel;
    QRLabel72: TQRLabel;
    qrlblSistema: TQRLabel;
    QRSysData1: TQRSysData;
    QRLabel15: TQRLabel;
    qrmObsExcEmitente: TQRMemo;
    qrlMsgTeste: TQRLabel;
    QRLabel7: TQRLabel;
    QRShape27: TQRShape;
    QRRoundRect1: TQRRoundRect;
    QRRoundRect2: TQRRoundRect;
    QRRoundRect3: TQRRoundRect;
    QRRoundRect4: TQRRoundRect;
    QRRoundRect5: TQRRoundRect;
    QRRoundRect6: TQRRoundRect;
    QRRoundRect7: TQRRoundRect;
    QRRoundRect8: TQRRoundRect;
    QRRoundRect9: TQRRoundRect;
    QRRoundRect10: TQRRoundRect;
    QRRoundRect11: TQRRoundRect;
    QRRoundRect12: TQRRoundRect;
    QRRoundRect13: TQRRoundRect;
    QRRoundRect14: TQRRoundRect;
    QRRoundRect15: TQRRoundRect;
    QRRoundRect16: TQRRoundRect;
    QRRoundRect17: TQRRoundRect;
    QRRoundRect18: TQRRoundRect;
    QRRoundRect19: TQRRoundRect;
    QRRoundRect20: TQRRoundRect;
    QRRoundRect21: TQRRoundRect;
    QRRoundRect22: TQRRoundRect;
    QRRoundRect23: TQRRoundRect;
    QRRoundRect24: TQRRoundRect;
    QRRoundRect25: TQRRoundRect;
    QRRoundRect26: TQRRoundRect;
    QRRoundRect27: TQRRoundRect;
    QRRoundRect28: TQRRoundRect;
    QRRoundRect29: TQRRoundRect;
    QRRoundRect30: TQRRoundRect;
    QRRoundRect31: TQRRoundRect;
    QRRoundRect32: TQRRoundRect;
    QRRoundRect33: TQRRoundRect;
    QRShape4: TQRShape;
    QRRoundRect34: TQRRoundRect;
    QRLabel19: TQRLabel;
    QRLabel57: TQRLabel;
    qrlNumCte1: TQRLabel;
    QRLabel60: TQRLabel;
    qrlSerie1: TQRLabel;
    QRRoundRect35: TQRRoundRect;
    QRRoundRect36: TQRRoundRect;
    QRRoundRect37: TQRRoundRect;
    procedure qrbDadosExcEmitenteBeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
    procedure qrbModRodFracionadoBeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
    procedure qrbObsBeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
    procedure qrbDadosDACTeBeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
    procedure qrbCabecalhoBeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
    procedure QRCTeBeforePrint(Sender: TCustomQuickRep; var PrintReport: Boolean);
    procedure qrbItensBeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
    procedure qrbSistemaBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
  private
    FTotalPages: integer;
    procedure Itens;
  public
    procedure ProtocoloCTe(const sProtocolo: string);
  end;

implementation

uses StrUtils, ACBrCTeUtil, DateUtils;

{$R *.dfm}

const
  _NUM_ITEMS_PAGE1  = 26; //esse valor eh dobrado por ter 2 NF por linha
  _NUM_ITEMS_OTHERPAGES = 50;

var
  FProtocoloCTe : string;
  nItemControle : Integer;

procedure TfrmDACTeQRRetrato.Itens;
var
  I : Integer;
begin
  if QRCTe.PageNumber > 0 then
    exit;

  cdsDocumentos.CreateDataSet;
  cdsDocumentos.Open;
  //Varrendo NF comum
  for I := 0 to (FCTe.Rem.InfNF.Count - 1) do
  begin
    with FCTe.Rem.InfNF.Items[I] do
    begin
      if (I mod 2) = 0 then
      begin
        cdsDocumentos.Append;

        cdsDocumentosTIPO_1.AsString := 'NF';
        cdsDocumentosCNPJCPF_1.AsString := CTeUtil.FormatarCNPJ(FCTe.Rem.CNPJCPF);
        cdsDocumentosDOCUMENTO_1.AsString := serie + '-' + nDoc;
      end
      else
      begin
        cdsDocumentosTIPO_2.AsString := 'NF';
        cdsDocumentosCNPJCPF_2.AsString := CTeUtil.FormatarCNPJ(FCTe.Rem.CNPJCPF);
        cdsDocumentosDOCUMENTO_2.AsString := serie + '-' + nDoc;

        cdsDocumentos.Post;
      end;
    end;
  end;
  //Varrendo NFe
  for I := 0 to (FCTe.Rem.InfNFE.Count - 1) do
  begin
    with FCTe.Rem.InfNFE.Items[I] do
    begin
      if (I mod 2) = 0 then
      begin
        cdsDocumentos.Append;
        cdsDocumentosTIPO_1.AsString := 'NF-E';
        cdsDocumentosCNPJCPF_1.AsString := chave;
      end
      else
      begin
        cdsDocumentosTIPO_2.AsString := 'NF-E';
        cdsDocumentosCNPJCPF_2.AsString := chave;
        cdsDocumentos.Post;
      end;
    end;
  end;
  //Varrendo Outros
  for I := 0 to (FCTe.Rem.InfOutros.Count - 1) do
  begin
    with FCTe.Rem.InfOutros.Items[I] do
    begin
      if (I mod 2) = 0 then
      begin
        cdsDocumentos.Append;
        cdsDocumentosTIPO_1.AsString := descOutros;
        cdsDocumentosCNPJCPF_1.AsString := CTeUtil.FormatarCNPJ(FCTe.Rem.CNPJCPF);
        cdsDocumentosDOCUMENTO_1.AsString := nDoc;
      end
      else
      begin
        cdsDocumentosTIPO_2.AsString := descOutros;
        cdsDocumentosCNPJCPF_2.AsString := CTeUtil.FormatarCNPJ(FCTe.Rem.CNPJCPF);
        cdsDocumentosDOCUMENTO_2.AsString := nDoc;
        cdsDocumentos.Post;
      end;
    end;
  end;

  cdsDocumentos.First;
end;

procedure TfrmDACTeQRRetrato.ProtocoloCTe(const sProtocolo: string);
begin
  FProtocoloCTe := sProtocolo;
end;

procedure TfrmDACTeQRRetrato.qrbModRodFracionadoBeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  inherited;
  with FCTe.Rodo do
  begin
    qrlRntrcEmpresa.Caption := RNTRC;

    case Lota of
      ltNao: qrlLotacao.Caption := 'NÃO';
      ltsim: qrlLotacao.Caption := 'SIM';
    end;

    qrlDtPrevEntrega.Caption := FormatDateTime('DD/MM/YYYY', dPrev);
  end;
end;

procedure TfrmDACTeQRRetrato.qrbObsBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
var
 i: integer;
begin
  inherited;
  qrmObs.Lines.BeginUpdate; // Linha inserida por Italo em 31/08/2010
  qrmObs.Lines.Clear;
  //qrmObs.Lines.Text := FCTe.Compl.xObs;
  //qrmObs.Lines.Add(FCTe.Compl.xObs);

  // Linha abaixo alterada por Italo em 27/08/2010
  // para substituir os ponto e virgula por quebra de linha no quadro Observações
  qrmObs.Lines.Add(StringReplace( FCTe.Compl.xObs, '&lt;BR&gt;', #13#10, [rfReplaceAll,rfIgnoreCase] ) ) ;
  for i := 0 to FCTe.Compl.ObsCont.Count-1 do
   with FCTe.Compl.ObsCont.Items[i] do
    begin
     qrmObs.Lines.Add( StringReplace( xCampo, '&lt;BR&gt;', #13#10, [rfReplaceAll,rfIgnoreCase] )+': '+
                       StringReplace( xTexto, '&lt;BR&gt;', #13#10, [rfReplaceAll,rfIgnoreCase] ) );
    end;
  if FCTe.Compl.ObsFisco.Count>0
   then qrmObs.Lines.Add('INFORMAÇÕES ADICIONAIS DE INTERESSE DO FISCO:');
  for i := 0 to FCTe.Compl.ObsFisco.Count-1 do
   with FCTe.Compl.ObsFisco.Items[i] do
    begin
     qrmObs.Lines.Add( StringReplace( xCampo, '&lt;BR&gt;', #13#10, [rfReplaceAll,rfIgnoreCase] )+': '+
                       StringReplace( xTexto, '&lt;BR&gt;', #13#10, [rfReplaceAll,rfIgnoreCase] ) );
    end;

  // Linhas inseridas por Italo em 31/08/2010
  qrmObs.Lines.Text:=StringReplace(qrmObs.Lines.Text,';',#13,[rfReplaceAll]);
  qrmObs.Lines.EndUpdate;
end;

procedure TfrmDACTeQRRetrato.QRCTeBeforePrint(Sender: TCustomQuickRep; var PrintReport: Boolean);
var
  nRestItens : Integer;
begin
  inherited;
  Itens;
  nItemControle := 0;
  FTotalPages := 1;

  if (FCTe.Rem.InfNF.Count > _NUM_ITEMS_PAGE1) then
  begin
    nRestItens := FCTe.Rem.InfNF.Count - _NUM_ITEMS_PAGE1;
    if nRestItens <= _NUM_ITEMS_OTHERPAGES then
      Inc(FTotalPages)
    else
    begin
      Inc(FTotalPages, nRestItens div _NUM_ITEMS_OTHERPAGES);
      if (nRestItens mod _NUM_ITEMS_OTHERPAGES) > 0 then
        Inc(FTotalPages)
    end;
  end;
end;

procedure TfrmDACTeQRRetrato.qrbCabecalhoBeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  inherited;
  PrintBand := QRCTe.PageNumber = 1 ;

  if Trim(FLogo) <> '' then
   qriLogo.Picture.LoadFromFile(FLogo);

  qrlModal.Caption := TpModalToStrText(FCTe.Ide.modal);
  qrlModelo.Caption := FCTe.Ide.modelo;
  qrlSerie.Caption := IntToStr(FCTe.Ide.serie);
  qrlSerie1.Caption := IntToStr(FCTe.Ide.serie);
  qrlNumCte.Caption := CTeUtil.FormatarNumCTe(FCTe.Ide.nCT);
  qrlNumCte1.Caption := CTeUtil.FormatarNumCTe(FCTe.Ide.nCT);
  qrlPageNumber.Caption := format('%2.2d', [QRCTe.PageNumber]) + '/' + format('%2.2d', [FTotalPages]);
  qrlEmissao.Caption := CTeUtil.FormatDateTime(DateTimeToStr(FCTe.Ide.dhEmi));
  SetBarCodeImage(Copy(FCTe.InfCTe.Id, 4, 44), qriBarCode);
  qrlChave.Caption := CTeUtil.FormatarChaveAcesso(Copy(FCTe.InfCTe.Id, 4, 44));

  QRCTe.ReportTitle:='CT-e: '+qrlNumCte.Caption;
  
  // Emitente
  with FCTe.Emit do
  begin
    qrmEmitente.Lines.Text := XNome;

    qrmDadosEmitente.Lines.Clear;
    with EnderEmit do
    begin
      qrmDadosEmitente.Lines.Add(XLgr + IfThen(Nro = '0', '', ', ' + Nro) + ' ' + XCpl + ' ' + XBairro);
      qrmDadosEmitente.Lines.Add('CEP: ' + CTeUtil.FormatarCEP(FormatFloat( '00000000', CEP )) + ' - ' + XMun + ' - ' + UF);
    end;
    qrmDadosEmitente.Lines.Add('CNPJ: ' + CTeUtil.FormatarCNPJ(CNPJ) + ' INSCRIÇÃO ESTADUAL: ' + IE);
    qrmDadosEmitente.Lines.Add('TELEFONE: ' + CTeUtil.FormatarFone(EnderEmit.Fone));

    if Trim(FUrl) <> '' then
      qrmDadosEmitente.Lines.Add(FUrl);
  end;

  qrlTipoCte.Caption := tpCTToStrText(FCTe.Ide.tpCTe);
  qrlTipoServico.Caption := TpServToStrText(FCTe.Ide.tpServ);
  qrlTomaServico.Caption := TpTomadorToStrText(FCTe.Ide.Toma03.Toma);
  qrlFormaPagamento.Caption := tpforPagToStrText(FCTe.Ide.forPag);

  // As Linhas abaixo foram inseridas por Italo em 31/08/2010
  // Normal **************************************************************
  if FCTe.Ide.tpEmis in [teNormal, teSCAN] then
   begin
    if FCTe.procCTe.cStat = 100 then
     begin
      qrlDescricao.Caption:= 'PROTOCOLO DE AUTORIZAÇÃO DE USO';
     end;

    if FCTe.procCTe.cStat = 101 then
     begin
      qrlDescricao.Caption:= 'PROTOCOLO DE HOMOLOGAÇÃO DE CANCELAMENTO';
     end;

    if FCTe.procCTe.cStat = 102 then
     begin
      qrlDescricao.Caption:= 'PROTOCOLO DE DENEGAÇÃO DE USO';
     end;

    if FProtocoloCTE <> ''
     then qrlProtocolo.Caption := FProtocoloCTE
     else qrlProtocolo.Caption :=  FCTe.procCTe.nProt + ' ' +
                                 CTeUtil.SeSenao(FCTe.procCTe.dhRecbto <> 0,
                                      DateTimeToStr(FCTe.procCTe.dhRecbto), '');
   end;

  qrlInscSuframa.Caption := FCTe.Dest.ISUF;
end;

procedure TfrmDACTeQRRetrato.qrbItensBeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
var
  i : integer;
begin
  inherited;

  for i := 1 to 2 do
    if Trim(cdsDocumentos.FieldByName('DOCUMENTO_' + IntToStr(i)).AsString) = '' then
      TQRDBText(FindComponent('qrdbtCnpjEmitente' + intToStr(i))).Width := 325
    else
      TQRDBText(FindComponent('qrdbtCnpjEmitente' + intToStr(i))).Width := 128;

  Inc(nItemControle);
  if QRCTe.PageNumber = 1 then
    if QRCTe.RecordCount < _NUM_ITEMS_PAGE1 then
      qrsFimItens.Enabled := (nItemControle = QRCTe.RecordCount)
    else
      qrsFimItens.Enabled := (nItemControle = _NUM_ITEMS_PAGE1)
  else
  begin
    qrsFimItens.Enabled := (nItemControle = _NUM_ITEMS_OTHERPAGES) or
      (QRCTe.RecordNumber = QRCTe.RecordCount) or
      (cdsDocumentos.Eof);
  end;

  if qrsFimItens.Enabled then
    nItemControle := 0;
end;

procedure TfrmDACTeQRRetrato.qrbDadosDACTeBeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
var
  i : integer;
begin
  inherited;
  qrlNatOperacao.Caption := FormatFloat('0000', FCTe.Ide.CFOP) + ' - ' + FCTe.Ide.natOp;
  qrlOrigPrestacao.Caption := FCTe.Ide.xMunIni + ' - ' + FCTe.Ide.UFIni + ' - ' + FormatFloat('000', FCTe.Ide.cMunIni);
  qrlDestPrestacao.Caption := FCTe.Ide.xMunFim + ' - ' + FCTe.Ide.UFFim + ' - ' + FormatFloat('000', FCTe.Ide.cMunFim);

  //DADOS REMETENTE
  qrlRazaoRemet.Caption := FCTe.Rem.xNome;
  qrlEnderecoRemet1.Caption := FCTe.Rem.EnderReme.xLgr + ', ' + FCTe.Rem.EnderReme.nro;
  qrlEnderecoRemet2.Caption := FCTe.Rem.EnderReme.xCpl + ' - ' + FCTe.Rem.EnderReme.xBairro;
  qrlCEPRemet.Caption := CTeUtil.FormatarCEP(FormatFloat( '00000000', FCTe.Rem.EnderReme.CEP ));
  qrlMunRemet.Caption := FCTe.Rem.EnderReme.xMun+' - '+FCTe.Rem.EnderReme.UF;
  qrlCnpjRemet.Caption := CTeUtil.FormatarCNPJ(FCTe.Rem.CNPJCPF);
  qrlPaisRemet.Caption := FCTe.Rem.EnderReme.xPais;
  qrlInscEstRemet.Caption := FCTe.Rem.IE;
  qrlFoneRemet.Caption := CTeUtil.FormatarFone(FCTe.Rem.fone);

  //DADOS DESTINATARIO
  qrlRazaoDest.Caption := FCTe.Dest.xNome;
  qrlEnderecoDest1.Caption := FCTe.Dest.EnderDest.xLgr + ', ' + FCTe.Dest.EnderDest.nro;
  qrlEnderecoDest2.Caption := FCTe.Dest.EnderDest.xCpl + ' - ' + FCTe.Dest.EnderDest.xBairro;
  qrlCEPDest.Caption := CTeUtil.FormatarCEP(FormatFloat( '00000000', FCTe.Dest.EnderDest.CEP));
  qrlMunDest.Caption := FCTe.Dest.EnderDest.xMun+' - '+FCTe.Dest.EnderDest.UF;
  qrlCnpjDest.Caption := CTeUtil.FormatarCNPJ(FCTe.Dest.CNPJCPF);
  qrlPaisDest.Caption := FCTe.Dest.EnderDest.xPais;
  qrlInscEstDest.Caption := FCTe.Dest.IE;
  qrlFoneDest.Caption := CTeUtil.FormatarFone(FCTe.Dest.fone);

  //DADOS EXPEDIDOR
  qrlRazaoExped.Caption := FCTe.Exped.xNome;
  qrlEnderecoExped1.Caption := FCTe.Exped.EnderExped.xLgr + ', ' + FCTe.Exped.EnderExped.nro;
  qrlEnderecoExped2.Caption := FCTe.Exped.EnderExped.xCpl + ' - ' + FCTe.Exped.EnderExped.xBairro;
  qrlCEPExped.Caption := CTeUtil.FormatarCEP(FormatFloat( '00000000', FCTe.Exped.EnderExped.CEP));
  qrlMunExped.Caption := FCTe.Exped.EnderExped.xMun+' - '+FCTe.Exped.EnderExped.UF;
  qrlCnpjExped.Caption := CTeUtil.FormatarCNPJ(FCTe.Exped.CNPJCPF);
  qrlPaisExped.Caption := FCTe.Exped.EnderExped.xPais;
  qrlInscEstExped.Caption := FCTe.Exped.IE;
  qrlFoneExped.Caption := CTeUtil.FormatarFone(FCTe.Exped.fone);

  //DADOS RECEBEDOR
  qrlRazaoReceb.Caption := FCTe.Receb.xNome;
  qrlEnderecoReceb1.Caption := FCTe.Receb.EnderReceb.xLgr + ', ' + FCTe.Receb.EnderReceb.nro;
  qrlEnderecoReceb2.Caption := FCTe.Receb.EnderReceb.xCpl + ' - ' + FCTe.Receb.EnderReceb.xBairro;
  qrlCEPReceb.Caption := CTeUtil.FormatarCEP(FormatFloat( '00000000', FCTe.Receb.EnderReceb.CEP));
  qrlMunReceb.Caption := FCTe.Receb.EnderReceb.xMun+' - '+FCTe.Receb.EnderReceb.UF;
  qrlCnpjReceb.Caption := CTeUtil.FormatarCNPJ(FCTe.Receb.CNPJCPF);
  qrlPaisReceb.Caption := FCTe.Receb.EnderReceb.xPais;
  qrlInscEstReceb.Caption := FCTe.Receb.IE;
  qrlFoneReceb.Caption := CTeUtil.FormatarFone(FCTe.Receb.fone);

  if FCTe.Ide.Toma4.xNome = ''
   then begin
    case FCTe.Ide.Toma03.Toma of
    tmRemetente:
      begin
        qrlRazaoToma.Caption := FCTe.Rem.xNome;
        qrlEnderecoToma.Caption := FCTe.Rem.EnderReme.xLgr + ', ' + FCTe.Rem.EnderReme.nro + ' - ' + FCTe.Rem.EnderReme.xCpl;
        qrlCEPToma.Caption := CTeUtil.FormatarCEP(FormatFloat( '00000000', FCTe.Rem.EnderReme.CEP));
        qrlMunToma.Caption := FCTe.Rem.EnderReme.xMun+' - '+FCTe.Rem.EnderReme.UF;
        qrlCnpjToma.Caption := CTeUtil.FormatarCNPJ(FCTe.Rem.CNPJCPF);
        qrlPaisToma.Caption := FCTe.Rem.EnderReme.xPais;
        qrlInscEstToma.Caption := FCTe.Rem.IE;
        qrlFoneToma.Caption := CTeUtil.FormatarFone(FCTe.Rem.fone);
      end;
    tmExpedidor:
      begin
        qrlRazaoToma.Caption := FCTe.Exped.xNome;
        qrlEnderecoToma.Caption := FCTe.Exped.EnderExped.xLgr + ', ' + FCTe.Exped.EnderExped.nro + ' - ' + FCTe.Exped.EnderExped.xCpl;
        qrlCEPToma.Caption := CTeUtil.FormatarCEP(FormatFloat( '00000000', FCTe.Exped.EnderExped.CEP));
        qrlMunToma.Caption := FCTe.Exped.EnderExped.xMun+' - '+FCTe.Exped.EnderExped.UF;
        qrlCnpjToma.Caption := CTeUtil.FormatarCNPJ(FCTe.Exped.CNPJCPF);
        qrlPaisToma.Caption := FCTe.Exped.EnderExped.xPais;
        qrlInscEstToma.Caption := FCTe.Exped.IE;
        qrlFoneToma.Caption := CTeUtil.FormatarFone(FCTe.Exped.fone);
      end;
    tmRecebedor:
      begin
        qrlRazaoToma.Caption := FCTe.Receb.xNome;
        qrlEnderecoToma.Caption := FCTe.Receb.EnderReceb.xLgr + ', ' + FCTe.Receb.EnderReceb.nro + ' - ' + FCTe.Receb.EnderReceb.xCpl;
        qrlCEPToma.Caption := CTeUtil.FormatarCEP(FormatFloat( '00000000', FCTe.Receb.EnderReceb.CEP));
        qrlMunToma.Caption := FCTe.Receb.EnderReceb.xMun+' - '+FCTe.Receb.EnderReceb.UF;
        qrlCnpjToma.Caption := CTeUtil.FormatarCNPJ(FCTe.Receb.CNPJCPF);
        qrlPaisToma.Caption := FCTe.Receb.EnderReceb.xPais;
        qrlInscEstToma.Caption := FCTe.Receb.IE;
        qrlFoneToma.Caption := CTeUtil.FormatarFone(FCTe.Receb.fone);
      end;
    tmDestinatario:
      begin
        qrlRazaoToma.Caption := FCTe.Dest.xNome;
        qrlEnderecoToma.Caption := FCTe.Dest.EnderDest.xLgr + ', ' + FCTe.Dest.EnderDest.nro + ' - ' + FCTe.Dest.EnderDest.xCpl;
        qrlCEPToma.Caption := CTeUtil.FormatarCEP(FormatFloat( '00000000', FCTe.Dest.EnderDest.CEP));
        qrlMunToma.Caption := FCTe.Dest.EnderDest.xMun+' - '+FCTe.Dest.EnderDest.UF;
        qrlCnpjToma.Caption := CTeUtil.FormatarCNPJ(FCTe.Dest.CNPJCPF);
        qrlPaisToma.Caption := FCTe.Dest.EnderDest.xPais;
        qrlInscEstToma.Caption := FCTe.Dest.IE;
        qrlFoneToma.Caption := CTeUtil.FormatarFone(FCTe.Dest.fone);
      end;
    end;
   end
   else begin
    qrlRazaoToma.Caption := FCTe.Ide.Toma4.xNome;
    qrlEnderecoToma.Caption := FCTe.Ide.Toma4.EnderToma.xLgr + ', ' + FCTe.Ide.Toma4.EnderToma.xNum + ' - ' + FCTe.Ide.Toma4.EnderToma.xCpl;
    qrlCEPToma.Caption := CTeUtil.FormatarCEP(FormatFloat( '00000000', FCTe.Ide.Toma4.EnderToma.CEP));
    qrlMunToma.Caption := FCTe.Ide.Toma4.EnderToma.xMun+' - '+FCTe.Ide.Toma4.EnderToma.UF;
    qrlCnpjToma.Caption := CTeUtil.FormatarCNPJ(FCTe.Ide.Toma4.CNPJCPF);
    qrlPaisToma.Caption := FCTe.Ide.Toma4.EnderToma.xPais;
    qrlInscEstToma.Caption := FCTe.Ide.Toma4.IE;
    qrlFoneToma.Caption := CTeUtil.FormatarFone(FCTe.Ide.Toma4.fone);
   end;

  qrlProdPredominante.Caption := FCTe.InfCarga.proPred;
  qrlOutrasCaracCarga.Caption := FCTe.InfCarga.xOutCat;
  qrlVlrTotalMerc.Caption := CteUtil.FormatarValor(msk15x2, FCTe.InfCarga.vMerc);

  for i := 1 to 4 do
    TQRLabel(FindComponent('qrlQtdUndMedida' + intToStr(i))).Caption := '';

  for i := 0 to FCTe.InfCarga.InfQ.Count - 1 do
    TQRLabel(FindComponent('qrlQtdUndMedida' + intToStr(i + 1))).Caption :=
      CteUtil.FormatarValor(msk6x3, FCTe.InfCarga.InfQ.Items[i].qCarga) + '/' +
      FCTe.InfCarga.InfQ.Items[i].tpMed;

  qrlNomeSeguradora.Caption := '';
  qrlRespSeguroMerc.Caption := '';
  qrlNroApolice.Caption := '';
  qrlNroAverbacao.Caption := '';

  if FCTe.InfSeg.Count > 0 then
  begin
    qrlNomeSeguradora.Caption := FCTe.InfSeg.Items[0].xSeg;
    qrlRespSeguroMerc.Caption := TpRspSeguroToStrText(FCTe.InfSeg.Items[0].respSeg);
    qrlNroApolice.Caption := FCTe.InfSeg.Items[0].nApol;
    qrlNroAverbacao.Caption := FCTe.InfSeg.Items[0].nAver;
  end;

  qrmCompNome1.Lines.Clear;
  qrmCompNome2.Lines.Clear;
  qrmCompNome3.Lines.Clear;
  qrmCompValor1.Lines.Clear;
  qrmCompValor2.Lines.Clear;
  qrmCompValor3.Lines.Clear;

  for i := 0 to FCTe.vPrest.comp.Count - 1 do
  begin
    case i of
      0..3:
        begin
          qrmCompNome1.Lines.Add(FCTe.vPrest.comp[i].xNome);
          qrmCompValor1.Lines.Add(CteUtil.FormatarValor(msk10x2, FCTe.vPrest.comp[i].vComp));
        end;
      4..7:
        begin
          qrmCompNome2.Lines.Add(FCTe.vPrest.comp[i].xNome);
          qrmCompValor2.Lines.Add(CteUtil.FormatarValor(msk10x2, FCTe.vPrest.comp[i].vComp));
        end;
      8..11:
        begin
          qrmCompNome3.Lines.Add(FCTe.vPrest.comp[i].xNome);
          qrmCompValor3.Lines.Add(CteUtil.FormatarValor(msk10x2, FCTe.vPrest.comp[i].vComp));
        end;
    end;
  end;

  qrlVlrTotServico.Caption := CteUtil.FormatarValor(msk13x2, FCTe.vPrest.vTPrest);
  qrlVlrTotReceber.Caption := CteUtil.FormatarValor(msk13x2, FCTe.vPrest.vRec);

  qrlSitTrib.Caption := CSTICMSToStr(FCTe.Imp.ICMS.SituTrib)+'-'+
                        CSTICMSToStrTagPosText(FCTe.Imp.ICMS.SituTrib);

  case FCTe.Imp.ICMS.SituTrib of
    cst00:
      begin
        qrlRedBaseCalc.Caption := '';
        qrlBaseCalc.Caption    := CteUtil.FormatarValor(msk9x2, FCTe.Imp.ICMS.CST00.vBC);
        qrlAliqICMS.Caption    := CteUtil.FormatarValor(mskAliq, FCTe.Imp.ICMS.CST00.pICMS);
        qrlVlrICMS.Caption     := CteUtil.FormatarValor(msk4x2, FCTe.Imp.ICMS.CST00.vICMS);
        qrlICMS_ST.Caption     := '';
      end;
    cst20:
      begin
        qrlRedBaseCalc.Caption := CteUtil.FormatarValor(mskAliq, FCTe.Imp.ICMS.CST20.pRedBC);
        qrlBaseCalc.Caption    := CteUtil.FormatarValor(msk9x2, FCTe.Imp.ICMS.CST20.vBC);
        qrlAliqICMS.Caption    := CteUtil.FormatarValor(mskAliq, FCTe.Imp.ICMS.CST20.pICMS);
        qrlVlrICMS.Caption     := CteUtil.FormatarValor(msk4x2, FCTe.Imp.ICMS.CST20.vICMS);
        qrlICMS_ST.Caption     := '';
        // CteUtil.FormatarValor(msk4x2, FCTe.Imp.ICMS.CST20.vICMS);
      end;
    cst40:
      begin
        qrlRedBaseCalc.Caption := '';
        qrlBaseCalc.Caption    := '';
        qrlAliqICMS.Caption    := '';
        qrlVlrICMS.Caption     := '';
        qrlICMS_ST.Caption     := '';
      end;
    cst41:
      begin
        qrlRedBaseCalc.Caption := '';
        qrlBaseCalc.Caption    := '';
        qrlAliqICMS.Caption    := '';
        qrlVlrICMS.Caption     := '';
        qrlICMS_ST.Caption     := '';
      end;
    cst45:
      begin
        qrlRedBaseCalc.Caption := '';
        qrlBaseCalc.Caption    := '';
        qrlAliqICMS.Caption    := '';
        qrlVlrICMS.Caption     := '';
        qrlICMS_ST.Caption     := '';
      end;
    cst51:
      begin
        qrlRedBaseCalc.Caption := '';
        qrlBaseCalc.Caption    := '';
        qrlAliqICMS.Caption    := '';
        qrlVlrICMS.Caption     := '';
        qrlICMS_ST.Caption     := '';
      end;
    cst80:
      begin
        qrlRedBaseCalc.Caption := '';
        qrlBaseCalc.Caption    := CteUtil.FormatarValor(msk9x2, FCTe.Imp.ICMS.CST80.vBC);
        qrlAliqICMS.Caption    := CteUtil.FormatarValor(mskAliq, FCTe.Imp.ICMS.CST80.pICMS);
        qrlVlrICMS.Caption     := CteUtil.FormatarValor(msk9x2, FCTe.Imp.ICMS.CST80.vICMS);
        qrlICMS_ST.Caption     := CteUtil.FormatarValor(msk9x2, FCTe.Imp.ICMS.CST80.vCred);
      end;
    cst81:
      begin
        qrlRedBaseCalc.Caption := CteUtil.FormatarValor(mskAliq, FCTe.Imp.ICMS.CST81.pRedBC);
        qrlBaseCalc.Caption    := CteUtil.FormatarValor(msk9x2, FCTe.Imp.ICMS.CST81.vBC);
        qrlAliqICMS.Caption    := CteUtil.FormatarValor(mskAliq, FCTe.Imp.ICMS.CST81.pICMS);
        qrlVlrICMS.Caption     := CteUtil.FormatarValor(msk9x2, FCTe.Imp.ICMS.CST81.vICMS);
        qrlICMS_ST.Caption     := '';
        // CteUtil.FormatarValor(msk9x2, FCTe.Imp.ICMS.CST81.vICMS);
      end;
    cst90:
      begin
        qrlRedBaseCalc.Caption := CteUtil.FormatarValor(mskAliq, FCTe.Imp.ICMS.CST90.pRedBC);
        qrlBaseCalc.Caption    := CteUtil.FormatarValor(msk9x2, FCTe.Imp.ICMS.CST90.vBC);
        qrlAliqICMS.Caption    := CteUtil.FormatarValor(mskAliq, FCTe.Imp.ICMS.CST90.pICMS);
        qrlVlrICMS.Caption     := CteUtil.FormatarValor(msk9x2, FCTe.Imp.ICMS.CST90.vICMS);
        qrlICMS_ST.Caption     := CteUtil.FormatarValor(msk4x2, FCTe.Imp.ICMS.CST90.vCred);
      end;
  end;
end;

procedure TfrmDACTeQRRetrato.qrbDadosExcEmitenteBeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  inherited;

  // As Linhas abaixo foram inseridas por Italo em 31/08/2010
  // Mensagem para modo Homologacao.

  qrlMsgTeste.Visible := False;
  qrlMsgTeste.Enabled := False;

  if FCTe.Ide.tpAmb = taHomologacao then
   begin
    qrlMsgTeste.Caption := 'AMBIENTE DE HOMOLOGAÇÃO - SEM VALOR FISCAL';
    qrlMsgTeste.Visible := True;
    qrlMsgTeste.Enabled := True;
   end else
   begin
    if FCTe.procCTe.cStat > 0 then
     begin
      if FCTe.procCTe.cStat = 101 then
       begin
        qrlMsgTeste.Caption := 'CT-e CANCELADO';
        qrlMsgTeste.Visible := True;
        qrlMsgTeste.Enabled := True;
       end;

      if FCTe.procCTe.cStat = 102 then
       begin
        qrlMsgTeste.Caption := 'CT-e DENEGADO';
        qrlMsgTeste.Visible := True;
        qrlMsgTeste.Enabled := True;
       end;

      if not FCTe.procCTe.cStat in [101, 102, 100] then
       begin
        qrlMsgTeste.Caption := FCTe.procCTe.xMotivo;
        qrlMsgTeste.Visible := True;
        qrlMsgTeste.Enabled := True;
       end;
     end else
     begin
      qrlMsgTeste.Caption := 'CT-E NÃO ENVIADO PARA SEFAZ';
      qrlMsgTeste.Visible := True;
      qrlMsgTeste.Enabled := True;
     end;
   end;

  qrlMsgTeste.Repaint;

//  qrlMsgTeste.Enabled := FCTe.Ide.tpAmb = taHomologacao;
  qrmObsExcEmitente.Lines.Clear;
//  qrmObsExcEmitente.Lines.Text := FCTe.Compl.xObs;
end;

procedure TfrmDACTeQRRetrato.qrbSistemaBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  inherited;
  qrlblSistema.Caption := FSistema + ' - ' + FUsuario;
end;

end.

