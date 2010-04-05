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

{******************************************************************************
| Historico
|
| 18/03/2010: André R. Langner
|  - Alterada fonte de Arial para Courier New.
|  - Ajuste na disposição de campos no DANFe.
|  - Impressao dos campos Fax, Email, Site referentes ao emitente.
|  - Adicionado campos qrlDataHoraImpressao, qrlSistema.
|  - Impressao de Data/Hora da impressao, Usuario, Sistema no rodapé do DANFe.
|  - Impressao de informacoes adicionais do item logo a baixo a sua descricao
|    em qrmProdutoDescricao.
|  - Impressao da Hora de Saida em qrlHoraSaida.
|  - Impressao de codigo de barras e chave em caso de impressao de formulário
|    de segurança
|  - Impressao de Local de Retirada e Local de Entrega em Informacoes Complementares.
|
| 15/12/2009: Emerson Crema
|  - Removida a rotina Detalhes e desenvolvida a Itens.
|  - Implementado ClientDataSet.
|  - Correcao no totalizador de paginas.
|
| 11/12/2009: Emerson Crema
|  - Ajuste no posicionamento das linhas e alinhamento de campos numéricos
|  - Alteracao da legenda 1-Saida, 2-Entrada, para 0-Entrada, 1- Saida.
|  - Alteracao da legenda 1-Emitente, 2-Destinatario, para
|    0-Emitente, 1-Destinatario.
|  - Incluida a mensagem para modo "homologação":
|    "Este documento não tem validade jurídica"
|    obs: precisa do componente QrAngLbl.
|  - Habilitada a banda qrsISSQN desde q FNFE.Total.ISSQNtot.vISS > 0.
|  - Preenchimento dos labels: qrlTotalServicos, qrlBaseISSQN, qrlValorISSQN.
|  - Implementada ajuste na lista de itens para + d 1 pagina.
|  - Implementado campo "Protocolo de autorizacao".
|  - Colocada a banda de "Identificacao do recebedor" no topo.
|
| 20/08/2009: Caique Rodrigues
|  - Doação units para geração do Danfe via QuickReport
|
| 16/12/2008: Wemerson Souto
|  - Doação do componente para o Projeto ACBr
|
******************************************************************************}

{$I ACBr.inc}

unit ACBrNFeDANFeQRRetrato;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, QuickRpt, QRCtrls,  XMLIntf, XMLDoc, MidasLib,
  JPEG, ACBrNFeDANFeQR, ACBrNFeQRCodeBar, pcnConversao, DB,
  DBClient, ACBrNFeDANFEClass, ACBrNFeDANFeQRClass{, QRPDFFilt {Descomentar para usar PDF};

type

  TfqrDANFeQRRetrato = class(TfqrDANFeQR)
    cdsItens: TClientDataSet;
    cdsItensCODIGO: TStringField;
    cdsItensDESCRICAO: TStringField;
    cdsItensNCM: TStringField;
    cdsItensCFOP: TStringField;
    cdsItensUNIDADE: TStringField;
    cdsItensQTDE: TStringField;
    cdsItensVALOR: TStringField;
    cdsItensTOTAL: TStringField;
    cdsItensCST: TStringField;
    cdsItensBICMS: TStringField;
    cdsItensALIQICMS: TStringField;
    cdsItensVALORICMS: TStringField;
    cdsItensALIQIPI: TStringField;
    cdsItensVALORIPI: TStringField;
    qrbRecibo: TQRBand;
    qrbDadosDanfe: TQRChildBand;
    qrbEmitenteDestinatario: TQRChildBand;
    qrbHeaderItens: TQRBand;
    QRShape1: TQRShape;
    QRLabel10: TQRLabel;
    QRShape3: TQRShape;
    QRShape2: TQRShape;
    QRShape101: TQRShape;
    qrlRecebemosDe1: TQRLabel;
    qrlNumNF0: TQRLabel;
    qrlSERIE0: TQRLabel;
    QRLabel14: TQRLabel;
    QRLabel13: TQRLabel;
    QRLabel12: TQRLabel;
    QRLabel11: TQRLabel;
    QRShape5: TQRShape;
    QRShape6: TQRShape;
    QRShape7: TQRShape;
    QRLabel17: TQRLabel;
    QRShape8: TQRShape;
    QRShape9: TQRShape;
    QRShape11: TQRShape;
    QRLabel29: TQRLabel;
    QRLabel30: TQRLabel;
    QRLabel31: TQRLabel;
    QRLabel32: TQRLabel;
    qrlNatOperacao: TQRLabel;
    qrlInscricaoEstadual: TQRLabel;
    qrlInscrEstSubst: TQRLabel;
    qrlCNPJ: TQRLabel;
    qrlFone: TQRLabel;
    qrmEmitente: TQRMemo;
    qrmEndereco: TQRMemo;
    qriLogo: TQRImage;
    qriBarCode: TQRImage;
    QRLabel2: TQRLabel;
    qrlChave: TQRLabel;
    QRLabel9: TQRLabel;
    qrlDescricao: TQRLabel;
    qrlProtocolo: TQRLabel;
    qrlSERIE1: TQRLabel;
    QRLabel22: TQRLabel;
    QRLabel18: TQRLabel;
    QRLabel19: TQRLabel;
    QRLabel20: TQRLabel;
    qrlNumNF1: TQRLabel;
    QRLabel24: TQRLabel;
    qrlPageNumber: TQRLabel;
    QRLabel26: TQRLabel;
    QRLabel27: TQRLabel;
    QRShape102: TQRShape;
    qrlEntradaSaida: TQRLabel;
    QRLabel1: TQRLabel;
    qrlblFatura: TQRLabel;
    QRLabel5: TQRLabel;
    QRLabel4: TQRLabel;
    QRShape12: TQRShape;
    QRShape15: TQRShape;
    QRShape16: TQRShape;
    QRShape17: TQRShape;
    QRShape18: TQRShape;
    QRShape19: TQRShape;
    QRShape20: TQRShape;
    QRShape13: TQRShape;
    QRShape14: TQRShape;
    QRShape21: TQRShape;
    QRShape22: TQRShape;
    QRShape23: TQRShape;
    qrshpFatura: TQRShape;
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
    qrlFatValor1: TQRLabel;
    qrlFatValor2: TQRLabel;
    qrlFatValor3: TQRLabel;
    qrlFatNum1: TQRLabel;
    qrlFatNum2: TQRLabel;
    qrlFatNum3: TQRLabel;
    QRShape106: TQRShape;
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
    qrlHoraSaida: TQRLabel;
    qrsRectProdutos: TQRShape;
    QRLabel141: TQRLabel;
    QRLabel142: TQRLabel;
    QRLabel143: TQRLabel;
    QRLabel144: TQRLabel;
    QRLabel145: TQRLabel;
    QRLabel146: TQRLabel;
    QRLabel147: TQRLabel;
    QRLabel148: TQRLabel;
    QRLabel149: TQRLabel;
    QRLabel150: TQRLabel;
    QRLabel151: TQRLabel;
    QRLabel152: TQRLabel;
    QRLabel153: TQRLabel;
    QRLabel156: TQRLabel;
    QRLabel154: TQRLabel;
    QRLabel157: TQRLabel;
    QRShape10: TQRShape;
    QRShape24: TQRShape;
    QRShape40: TQRShape;
    QRShape41: TQRShape;
    QRShape57: TQRShape;
    QRShape58: TQRShape;
    QRShape59: TQRShape;
    QRShape60: TQRShape;
    QRShape61: TQRShape;
    QRShape62: TQRShape;
    QRShape63: TQRShape;
    QRShape64: TQRShape;
    QRShape65: TQRShape;
    QRShape67: TQRShape;
    qrbItens: TQRBand;
    qrmProdutoCodigo: TQRDBText;
    qrmProdutoDescricao: TQRDBText;
    qrmProdutoNCM: TQRDBText;
    qrmProdutoCST: TQRDBText;
    qrmProdutoCFOP: TQRDBText;
    qrmProdutoUnidade: TQRDBText;
    qrmProdutoQTDE: TQRDBText;
    qrmProdutoValor: TQRDBText;
    qrmProdutoTotal: TQRDBText;
    qrmProdutoBCICMS: TQRDBText;
    qrmProdutoVALORICMS: TQRDBText;
    qrmProdutoALIQICMS: TQRDBText;
    qrmProdutoVALORIPI: TQRDBText;
    qrmProdutoALIQIPI: TQRDBText;
    QRShape4: TQRShape;
    QRShape66: TQRShape;
    qriBarCodeContingencia: TQRImage;
    qrbItensLine: TQRChildBand;
    QRShape68: TQRShape;
    qrs2: TQRShape;
    cdsItensXPROD: TStringField;
    cdsItensINFADIPROD: TStringField;
    qrs1: TQRShape;
    qrs3: TQRShape;
    qrs4: TQRShape;
    qrs5: TQRShape;
    qrs6: TQRShape;
    qrs7: TQRShape;
    qrs8: TQRShape;
    qrs9: TQRShape;
    qrs10: TQRShape;
    qrs11: TQRShape;
    qrs12: TQRShape;
    qrs13: TQRShape;
    qrs14: TQRShape;
    qrs15: TQRShape;
    qrbDadosAdicionais: TQRBand;
    QRShape56: TQRShape;
    QRLabel7: TQRLabel;
    QRLabel6: TQRLabel;
    qrmDadosAdicionais: TQRMemo;
    qrlDataHoraImpressao: TQRLabel;
    qrlSistema: TQRLabel;
    QRLabel100: TQRLabel;
    qrlMsgTeste: TQRLabel;
    rbDadosAdicionais: TQRShape;
    QRShape69: TQRShape;
    QRLabel3: TQRLabel;
    QRShape52: TQRShape;
    QRLabel137: TQRLabel;
    qrlInscMunicipal: TQRLabel;
    QRShape53: TQRShape;
    QRLabel138: TQRLabel;
    qrlTotalServicos: TQRLabel;
    QRShape54: TQRShape;
    QRLabel139: TQRLabel;
    qrlBaseISSQN: TQRLabel;
    QRShape55: TQRShape;
    QRLabel140: TQRLabel;
    qrlValorISSQN: TQRLabel;
    procedure QRNFeBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
    procedure qrbReciboBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure qrbEmitenteDestinatarioBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure qrbDadosAdicionais_BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure qrbDadosDanfeBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure cdsItensAfterScroll(DataSet: TDataSet);
  private
    { Private declarations }
    FTotalPages : integer ;
    procedure Itens ;
  public
    { Public declarations }
    procedure ProtocoloNFE( const sProtocolo : String ) ;
  end;


implementation

uses StrUtils, ACBrNFeUtil, pcnNFe, pcnSignature, DateUtils, ACBrNFe, ACBrUtil;

{$R *.dfm}

const
   _NUM_ITEMS_PAGE1      = 18 ;
   _NUM_ITEMS_OTHERPAGES = 50 ;

var
   FProtocoloNFE : String ;
   nItemControle : Integer ;

procedure TfqrDANFeQRRetrato.cdsItensAfterScroll(DataSet: TDataSet);
var
    intTamanhoDescricao,
    intTamanhoLinha,
    intDivisao,
    intResto   :Integer;
begin
  inherited;
    intTamanhoDescricao:= Length(cdsItens.FieldByName( 'DESCRICAO' ).AsString);
//    intTamanhoDescricao:= qrmProdutoDescricao.Lines.Count;
    intDivisao := intTamanhoDescricao DIV 35;
    intResto   := intTamanhoDescricao MOD 35;

    if intResto > 0 then
    begin
        intTamanhoLinha:= (11 * (intDivisao + 1));
    end else
    begin
        intTamanhoLinha:= (11 * intDivisao);
    end;                            


    if (intTamanhoDescricao <= 35) AND (cdsItens.FieldByName('INFADIPROD').AsString = '') then
    begin
        intTamanhoLinha := 12;
    end;
    if (intTamanhoDescricao <= 35) AND (cdsItens.FieldByName('INFADIPROD').AsString <> '') then
    begin
        intTamanhoLinha := 22;
    end;

    qrs1.Height:= intTamanhoLinha;
    qrs2.Height:= intTamanhoLinha;
    qrs3.Height:= intTamanhoLinha;
    qrs4.Height:= intTamanhoLinha;
    qrs5.Height:= intTamanhoLinha;
    qrs6.Height:= intTamanhoLinha;
    qrs7.Height:= intTamanhoLinha;
    qrs8.Height:= intTamanhoLinha;
    qrs9.Height:= intTamanhoLinha;
    qrs10.Height:= intTamanhoLinha;
    qrs11.Height:= intTamanhoLinha;
    qrs12.Height:= intTamanhoLinha;
    qrs13.Height:= intTamanhoLinha;
    qrs14.Height:= intTamanhoLinha;
    qrs15.Height:= intTamanhoLinha;

    if intTamanhoDescricao = 0 then
    begin
        qrs1.Visible:= False;
        qrs2.Visible:= False;
        qrs3.Visible:= False;
        qrs4.Visible:= False;
        qrs5.Visible:= False;
        qrs6.Visible:= False;
        qrs7.Visible:= False;
        qrs8.Visible:= False;
        qrs9.Visible:= False;
        qrs10.Visible:= False;
        qrs11.Visible:= False;
        qrs12.Visible:= False;
        qrs13.Visible:= False;
        qrs14.Visible:= False;
        qrs15.Visible:= False;
    end ;
    
    qrs1.Repaint ;
    qrs2.Repaint ;
    qrs3.Repaint ;
    qrs4.Repaint ;
    qrs5.Repaint ;
    qrs6.Repaint ;
    qrs7.Repaint ;
    qrs8.Repaint ;
    qrs9.Repaint ;
    qrs10.Repaint ;
    qrs11.Repaint ;
    qrs12.Repaint ;
    qrs13.Repaint ;
    qrs14.Repaint ;
    qrs15.Repaint ;
end;

procedure TfqrDANFeQRRetrato.Itens;
var
   nItem : Integer ;
   sCST, sBCICMS, sALIQICMS, sVALORICMS, sALIQIPI, sVALORIPI, sDESCRICAOPRODUTO : String ;
begin

   if QRNFe.PageNumber > 0 then
      exit ;

   cdsItens.CreateDataSet ;
   cdsItens.Open ;

   for nItem := 0 to ( FNFe.Det.Count - 1 ) do
   begin

      with FNFe.Det.Items[ nItem ] do
      begin

         with Prod do
         begin

            with Imposto.ICMS do
            begin

               sCST       := OrigToStr( orig ) + CSTICMSToStr( CST ) ;

               sBCICMS    := '0.00' ;
               sALIQICMS  := '0.00' ;
               sVALORICMS := '0.00' ;

               sALIQIPI   := '0.00' ;
               sVALORIPI  := '0.00' ;

               if (CST = cst00) then
               begin
                  sBCICMS    := NotaUtil.FormatFloat( VBC   ) ;
                  sALIQICMS  := NotaUtil.FormatFloat( PICMS ) ;
                  sVALORICMS := NotaUtil.FormatFloat( VICMS ) ;
               end
               else if (CST = cst10) then
               begin
                  sBCICMS    := NotaUtil.FormatFloat( VBC   ) ;
                  sALIQICMS  := NotaUtil.FormatFloat( PICMS ) ;
                  sVALORICMS := NotaUtil.FormatFloat( VICMS ) ;
               end
               else if (CST = cst20) then
               begin
                  sBCICMS    := NotaUtil.FormatFloat( VBC   ) ;
                  sALIQICMS  := NotaUtil.FormatFloat( PICMS ) ;
                  sVALORICMS := NotaUtil.FormatFloat( VICMS ) ;
               end
               else if (CST = cst30) then
               begin
                  sBCICMS    := NotaUtil.FormatFloat( VBCST   ) ;
                  sALIQICMS  := NotaUtil.FormatFloat( PICMSST ) ;
                  sVALORICMS := NotaUtil.FormatFloat( VICMSST ) ;
               end
               else if (CST = cst40) or (CST = cst41) or (CST = cst50) then
               begin
                  // Campos vazios
               end
               else if (CST = cst51) then
               begin
                  sBCICMS    := NotaUtil.FormatFloat( VBC   ) ;
                  sALIQICMS  := NotaUtil.FormatFloat( PICMS ) ;
                  sVALORICMS := NotaUtil.FormatFloat( VICMS ) ;
               end
               else if (CST = cst60) then
               begin
                  sBCICMS    := NotaUtil.FormatFloat( VBCST ) ;
                  sVALORICMS := NotaUtil.FormatFloat( VICMSST ) ;
               end
               else if (CST = cst70) then
               begin
                  sBCICMS    := NotaUtil.FormatFloat( VBC   ) ;
                  sALIQICMS  := NotaUtil.FormatFloat( PICMS ) ;
                  sVALORICMS := NotaUtil.FormatFloat( VICMS ) ;
               end
               else if (CST = cst90) then
               begin
                  sBCICMS    := NotaUtil.FormatFloat( VBC   ) ;
                  sALIQICMS  := NotaUtil.FormatFloat( PICMS ) ;
                  sVALORICMS := NotaUtil.FormatFloat( VICMS ) ;
               end;
            end;

            with Imposto.IPI do
            begin
               if (CST = ipi00) or (CST = ipi49) or
                  (CST = ipi50) or (CST = ipi99) then
               begin
                  sALIQIPI  := NotaUtil.FormatFloat( PIPI ) ;
                  sVALORIPI := NotaUtil.FormatFloat( VIPI ) ;
               end
            end;

            if infAdProd <> '' then
            begin
                sDESCRICAOPRODUTO:= xProd + #13 + infAdProd;
            end else
            begin
                sDESCRICAOPRODUTO:= xProd;
            end;

            cdsItens.Append ;
            cdsItens.FieldByName( 'CODIGO'    ).AsString := cProd ;
            cdsItens.FieldByName( 'DESCRICAO' ).AsString := sDESCRICAOPRODUTO ;
            cdsItens.FieldByName( 'NCM'       ).AsString := NCM ;
            cdsItens.FieldByName( 'CFOP'      ).AsString := CFOP ;
            cdsItens.FieldByName( 'UNIDADE'   ).AsString := UCom ;
            cdsItens.FieldByName( 'QTDE'      ).AsString := NotaUtil.FormatFloat( QCom ) ;
            cdsItens.FieldByName( 'VALOR'     ).AsString := NotaUtil.FormatFloat( VUnCom ) ;
            cdsItens.FieldByName( 'TOTAL'     ).AsString := NotaUtil.FormatFloat( VProd ) ;
            cdsItens.FieldByName( 'CST'       ).AsString := sCST ;
            cdsItens.FieldByName( 'BICMS'     ).AsString := sBCICMS ;
            cdsItens.FieldByName( 'ALIQICMS'  ).AsString := sALIQICMS ;
            cdsItens.FieldByName( 'VALORICMS' ).AsString := sVALORICMS ;
            cdsItens.FieldByName( 'ALIQIPI'   ).AsString := sALIQIPI ;
            cdsItens.FieldByName( 'VALORIPI'  ).AsString := sVALORIPI ;

            cdsItens.FieldByName( 'XPROD'     ).AsString := xProd ;
            cdsItens.FieldByName( 'INFADIPROD').AsString := infAdProd ;
            cdsItens.Post ;

         end;
         
      end ;

   end ;

   cdsItens.First ;

end;

procedure TfqrDANFeQRRetrato.ProtocoloNFE( const sProtocolo : String ) ;
begin
   FProtocoloNFE := sProtocolo ;
end ;

procedure TfqrDANFeQRRetrato.QRNFeBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
var
  nRestItens : Integer ;
begin
  inherited;
   Itens ;
   nItemControle := 0 ;
   FTotalPages   := 1 ;
   if ( FNFe.Det.Count > _NUM_ITEMS_PAGE1 ) then
   begin
      nRestItens := FNFe.Det.Count - _NUM_ITEMS_PAGE1 ;
      if nRestItens <= _NUM_ITEMS_OTHERPAGES then
         Inc( FTotalPages )
      else
      begin
         Inc( FTotalPages, nRestItens div _NUM_ITEMS_OTHERPAGES ) ;
         if ( nRestItens mod _NUM_ITEMS_OTHERPAGES ) > 0 then
            Inc( FTotalPages )
      end ;
   end ;

   QRNFe.Page.TopMargin    := FMargemSuperior * 100;
   QRNFe.Page.BottomMargin := FMargemInferior * 100;
   QRNFe.Page.LeftMargin   := FMargemEsquerda * 100;
   QRNFe.Page.RightMargin  := FMargemDireita  * 100;
end;

procedure TfqrDANFeQRRetrato.qrbReciboBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  inherited;
   PrintBand := QRNFe.PageNumber = 1 ;
   qrlNumNF0.Caption := FormatFloat( '000,000,000', FNFe.Ide.nNF ) ;
   qrlSERIE0.Caption := IntToStr( FNFe.Ide.serie ) ;
   qrlRecebemosDe1.Caption      := StringReplace(qrlRecebemosDe1.Caption,'%s',FNFe.Emit.xNome,[rfReplaceAll]);
end;

procedure TfqrDANFeQRRetrato.qrbEmitenteDestinatarioBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
var
   x : integer ;
begin
  inherited;
   PrintBand := QRNFe.PageNumber = 1 ;

   // Destinatario

   with FNFe.Dest do
   begin
      if Trim( CNPJCPF ) = ''                then qrlDestCNPJ.Caption := ''
      else if Length( Trim( CNPJCPF ) ) > 11 then qrlDestCNPJ.Caption := NotaUtil.FormatarCNPJ( CNPJCPF )
      else                                        qrlDestCNPJ.Caption := NotaUtil.FormatarCPF( CNPJCPF ) ;

      qrlDestIE.Caption   := IE ;
      qrlDestNome.Caption := XNome ;
      with EnderDest do
      begin
         qrlDestEndereco.Caption := XLgr + IfThen ( Nro = '0', '', ', ' + Nro ) ;
         qrlDestBairro.Caption   := XBairro ;
         qrlDestCidade.Caption   := XMun ;
         qrlDestUF.Caption       := UF ;
         qrlDestCEP.Caption      := NotaUtil.FormatarCEP( FormatFloat( '00000000', CEP ) ) ;
         qrlDestFONE.Caption     := NotaUtil.FormatarFone( Fone ) ;
      end;
   end;

   // Emissao, saida

   qrlEmissao.Caption   := NotaUtil.FormatDate(DateToStr(FNFe.Ide.dEmi)) ;
   qrlSaida.Caption     := IfThen( FNFe.Ide.DSaiEnt <> 0, NotaUtil.FormatDate(DateToStr(FNFe.Ide.dSaiEnt))) ;

    if FImprimeHoraSaida then
    begin
        if FHoraSaida = '' then
        begin
            qrlHoraSaida.Caption := FormatDateTime('hh:nn:ss',Now);
        end else
        begin
            qrlHoraSaida.Caption := FHoraSaida;
        end;
    end else
    begin
        qrlHoraSaida.Caption := '';
    end;
    
   // Faturas

   // Zera
   for x := 1 to 15 do
   begin
      TQRLabel( FindComponent( 'qrlFatNum'   + intToStr( x ) ) ).Caption := '' ;
      TQRLabel( FindComponent( 'qrlFatData'  + intToStr( x ) ) ).Caption := '' ;
      TQRLabel( FindComponent( 'qrlFatValor' + intToStr( x ) ) ).Caption := '' ;
   end ;
   // Adiciona
   for x := 0 to FNFe.Cobr.Dup.Count - 1 do with FNFe.Cobr.Dup[ x ] do
   begin
      TQRLabel( FindComponent( 'qrlFatNum'   + intToStr ( x + 1 ) ) ).Caption := NDup ;
      TQRLabel( FindComponent( 'qrlFatData'  + intToStr ( x + 1 ) ) ).Caption := NotaUtil.FormatDate( DateToStr(DVenc) ) ;
      TQRLabel( FindComponent( 'qrlFatValor' + intToStr ( x + 1 ) ) ).Caption := NotaUtil.FormatFloat(VDup) ;
   end;

//    if qrlFatNum1.Caption = '' then
//    begin
//        qrlFatNum2.Caption := '   PAGAMENTO À VISTA'
//    end;

   // Impostos

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
      qrlValorIPI.Caption      := NotaUtil.FormatFloat( VIPI ) ;
      qrlTotalNF.Caption       := NotaUtil.FormatFloat( VNF ) ;
   end;

   // Transporte

   with FNFe.Transp do
   begin
      qrlTransModFrete.Caption   := modFreteToStr( ModFrete ) ;
      qrlTransCodigoANTT.Caption := '' ;
      qrlTransPlaca.Caption      := '' ;
      qrlTransUFPlaca.Caption    := '' ;

      with Transporta do
      begin
         if Trim( CNPJCPF ) = ''                then qrlTransCNPJ.Caption := '' 
         else if Length( Trim( CNPJCPF ) ) > 11 then qrlTransCNPJ.Caption := NotaUtil.FormatarCNPJ( CNPJCPF )
         else                                        qrlTransCNPJ.Caption := NotaUtil.FormatarCPF( CNPJCPF ) ;

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

   if FNFe.Transp.Vol.Count > 0 then with FNFe.Transp.Vol[0] do
   begin
      qrlTransQTDE.Caption      := IntToStr(QVol) ;
      qrlTransEspecie.Caption   := Esp   ;
      qrlTransMarca.Caption     := Marca ;
      qrlTransNumeracao.Caption := NVol  ;
      qrlTransPesoLiq.Caption   := NotaUtil.FormatFloat( PesoL, '#,0.00##' ) ;
      qrlTransPesoBruto.Caption := NotaUtil.FormatFloat( PesoB, '#,0.00##' ) ;
   end
   else
   begin
      qrlTransQTDE.Caption      := '' ;
      qrlTransEspecie.Caption   := '' ;
      qrlTransMarca.Caption     := '' ;
      qrlTransNumeracao.Caption := '' ;
      qrlTransPesoLiq.Caption   := '' ;
      qrlTransPesoBruto.Caption := '' ;
   end;

   // Mensagem para modo Homologacao.

    if FNFe.Ide.tpAmb = taHomologacao then
    begin
        qrlMsgTeste.Caption := 'AMBIENTE DE HOMOLOGAÇÃO - SEM VALOR FISCAL';
        qrlMsgTeste.Enabled := True;
        qrlMsgTeste.Visible := True;
    end else
    begin
        if FNFe.procNFe.cStat > 0 then
        begin
            if FNFe.procNFe.cStat = 101 then
            begin
               qrlMsgTeste.Caption  := 'NF-e CANCELADA';
               qrlMsgTeste.Visible  := True;
               qrlMsgTeste.Enabled := True;
            end;

            if FNFe.procNFe.cStat = 102 then
            begin
               qrlMsgTeste.Caption  := 'NF-e DENEGADA';
               qrlMsgTeste.Visible  := True;
               qrlMsgTeste.Enabled := True;
            end;

            if not FNFe.procNFe.cStat in [101, 102, 100] then
            begin
                qrlMsgTeste.Caption:=  FNFe.procNFe.xMotivo;
                qrlMsgTeste.Visible := True;
                qrlMsgTeste.Enabled := True;
            end;
        end else
        begin
            qrlMsgTeste.Caption  := 'NF-E NÃO ENVIADA PARA SEFAZ';
            qrlMsgTeste.Visible  := True;
            qrlMsgTeste.Enabled  := True;
        end;
    end;

    qrlMsgTeste.Repaint;
      
end;

procedure TfqrDANFeQRRetrato.qrbDadosAdicionais_BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
var
   i: Integer;
begin
  inherited;
    PrintBand := QRNFe.PageNumber = 1 ;
    if not PrintBand then
    begin
        //qrbDadosAdicionais.Height := 0
    end else
    begin
        if FNFE.Total.ISSQNtot.vISS > 0 then
        begin
            qrlInscMunicipal.Caption := '' ;
            qrlTotalServicos.Caption := NotaUtil.FormatFloat( FNFE.Total.ISSQNtot.vServ ) ;
            qrlBaseISSQN.Caption     := NotaUtil.FormatFloat( FNFE.Total.ISSQNtot.vBC ) ;
            qrlValorISSQN.Caption    := NotaUtil.FormatFloat( FNFE.Total.ISSQNtot.vISS ) ;
        end else
        begin
            qrlInscMunicipal.Caption := '' ;
            qrlTotalServicos.Caption := '' ;
            qrlBaseISSQN.Caption     := '' ;
            qrlValorISSQN.Caption    := '' ;
        end ;

        with FNFe.InfAdic do
        begin
            qrmDadosAdicionais.Lines.BeginUpdate ;
            qrmDadosAdicionais.Lines.Clear ;
            for i := 0 to ObsCont.Count-1 do with ObsCont.Items[i] do
            begin
                qrmDadosAdicionais.Lines.Add( StringReplace( XCampo, '&lt;BR&gt;', #13#10, [rfReplaceAll,rfIgnoreCase] )+': '+
                                               StringReplace( XTexto, '&lt;BR&gt;', #13#10, [rfReplaceAll,rfIgnoreCase] ) );
            end;
            //**********************************************************************
            // informacoes complementares emitente
            if infCpl <> '' then
            begin
                qrmDadosAdicionais.Lines.Add(StringReplace( InfCpl, '&lt;BR&gt;', #13#10, [rfReplaceAll,rfIgnoreCase] ) ) ;
            end;
            //**********************************************************************
            // informacoes complementares interesse ao fisco
            if infAdFisco <> '' then
            begin
                qrmDadosAdicionais.Lines.Add(StringReplace( 'INFORMAÇÕES ADICIONAIS DE INTERESSE DO FISCO: ' +
                                                           infAdFisco,'&lt;BR&gt;', #13#10, [rfReplaceAll,rfIgnoreCase] ));
            end;
            //**********************************************************************
            // local de retirada
            with FNFe.Retirada do
            begin
                if xLgr <> '' then
                begin
                    qrmDadosAdicionais.Lines.Add(   'LOCAL DE RETIRADA: '                                                          +
                                                    StringReplace( xLgr, '&lt;BR&gt;',      #13#10, [rfReplaceAll,rfIgnoreCase] )  + ', ' +
                                                    StringReplace( nro, '&lt;BR&gt;',       #13#10, [rfReplaceAll,rfIgnoreCase] )  + '/' +
                                                    StringReplace( xCpl, '&lt;BR&gt;',      #13#10, [rfReplaceAll,rfIgnoreCase] )  + ' ' +
                                                    StringReplace( xBairro, '&lt;BR&gt;',   #13#10, [rfReplaceAll,rfIgnoreCase] )  + ' - ' +
                                                    StringReplace( xMun, '&lt;BR&gt;',      #13#10, [rfReplaceAll,rfIgnoreCase] )  + ' ' +
                                                    StringReplace( UF, '&lt;BR&gt;',        #13#10, [rfReplaceAll,rfIgnoreCase] )) ;
                end;
            end;
            //**********************************************************************
            // local de retirada
            with FNFe.Entrega do
            begin
                if xLgr <> '' then
                begin
                    qrmDadosAdicionais.Lines.Add(   'LOCAL DE ENTREGA: '                                                          +
                                                    StringReplace( xLgr, '&lt;BR&gt;',      #13#10, [rfReplaceAll,rfIgnoreCase] )  + ', ' +
                                                    StringReplace( nro, '&lt;BR&gt;',       #13#10, [rfReplaceAll,rfIgnoreCase] )  + '/' +
                                                    StringReplace( xCpl, '&lt;BR&gt;',      #13#10, [rfReplaceAll,rfIgnoreCase] )  + ' ' +
                                                    StringReplace( xBairro, '&lt;BR&gt;',   #13#10, [rfReplaceAll,rfIgnoreCase] )  + ' - ' +
                                                    StringReplace( xMun, '&lt;BR&gt;',      #13#10, [rfReplaceAll,rfIgnoreCase] )  + ' ' +
                                                    StringReplace( UF, '&lt;BR&gt;',        #13#10, [rfReplaceAll,rfIgnoreCase] )) ;
                end;
            end;

            if FNFe.Ide.tpEmis in [teContingencia, teFSDA] then
                qrmDadosAdicionais.Lines.Add('DANFE em Contingência - Impresso em decorrência de problemas técnicos.');
            if FNFe.Ide.tpEmis = teDPEC then
                qrmDadosAdicionais.Lines.Add('DANFE em Contingência - DPEC regularmente recebida pela Receita Federal do Brasil');
            //**********************************************************************
          qrmDadosAdicionais.Lines.Text:=StringReplace(qrmDadosAdicionais.Lines.Text,';',#13,[rfReplaceAll]);
          qrmDadosAdicionais.Lines.EndUpdate ;

            // imprime data e hora da impressao
            QrlDataHoraImpressao.Caption:= 'DATA E HORA DA IMPRESSÃO: ' + FormatDateTime('d/m/yyyy hh:nn',Now);

            // imprime usuario
            if FUsuario <> '' then
            begin
                QrlDataHoraImpressao.Caption:= QrlDataHoraImpressao.Caption + '   USUÁRIO: ' + FUsuario;
            end;

            // imprime sistema
            if FSistema <> '' then
            begin
                qrlSistema.Caption:= 'Desenvolvido por ' + FSistema;
            end else
            begin
                qrlSistema.Caption:= '';
            end;
        end;
    end;
end;

procedure TfqrDANFeQRRetrato.qrbDadosDanfeBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
var
    strChaveContingencia: string;
begin
  inherited;

   qrlPageNumber.Caption := format ( '%2.2d', [ QRNFe.PageNumber ] )
                    + '/' + format ( '%2.2d', [ FTotalPages ] ) ;

   if QRNFe.PageNumber = 1 then
   begin
      // Emitente

      with FNFe.Emit do
      begin
         qrlCNPJ.Caption              := NotaUtil.FormatarCNPJ( CNPJCPF  ) ;
         qrlInscrEstSubst.caption     := IEST ;
         qrlInscricaoEstadual.Caption := IE ;
         qrmEmitente.Lines.Text       := XNome ;
         with EnderEmit do
         begin
            qrmEndereco.Lines.Clear ;
            qrmEndereco.Lines.add ( XLgr + IfThen ( Nro = '0', '', ', ' + Nro ) + ' ' + XCpl + ' ' + XBairro ) ;
            qrmEndereco.Lines.add ( NotaUtil.FormatarCEP( IntToStr(CEP) ) + ' - ' + XMun + ' - ' + UF ) ;
            if Trim(FSite) <> '' then
            begin
               qrmEndereco.Lines.Add (FSite);
            end;

            if Trim(FEmail) <> '' then
            begin
               qrmEndereco.Lines.Add (FEmail);
            end;

            // telefone

            qrlFone.Caption:= '';

            if (fone <> '') and (FFax = '') then
            begin
                 qrlFone.Caption := 'FONE: ' + NotaUtil.FormatarFone( Fone );
            end;

            if (FFax <> '') and (fone = '') then
            begin
                qrlFone.Caption:= 'FAX: ' + FFax;
            end;

            if (FFax <> '') and (fone <> '') then
            begin
                qrlFone.Caption:= 'FONE: ' + NotaUtil.FormatarFone( Fone ) + #13 +'FAX: ' + FFax;
            end;

         end;

         if (FLogo <> '') and FilesExists(FLogo) then
         begin
             qriLogo.Picture.LoadFromFile(FLogo);
         end;

      end ;
      // Danfe

      qrlEntradaSaida.Caption := tpNFToStr( FNFe.Ide.tpNF ) ;
      qrlNumNF1.Caption       := FormatFloat( '000,000,000', FNFe.Ide.nNF ) ;
      qrlSERIE1.Caption       := IntToStr( FNFe.Ide.serie ) ;
      qrlChave.Caption        := NotaUtil.FormatarChaveAcesso( Copy ( FNFe.InfNFe.Id, 4, 44 ) ) ;
      qrlNatOperacao.Caption  := FNFe.Ide.natOp ;
       SetBarCodeImage( Copy ( FNFe.InfNFe.Id, 4, 44 ), qriBarCode ) ;

        // Normal **************************************************************
        if FNFe.Ide.tpEmis in [teNormal, teSCAN] then
        begin
            if FNFe.procNFe.cStat = 100 then
            begin
                qrlDescricao.Caption:= 'PROTOCOLO DE AUTORIZAÇÃO DE USO';
            end;

            if FNFe.procNFe.cStat = 101 then
            begin
                qrlDescricao.Caption:= 'PROTOCOLO DE HOMOLOGAÇÃO DE CANCELAMENTO';
            end;

            if FNFe.procNFe.cStat = 102 then
            begin
                qrlDescricao.Caption:= 'PROTOCOLO DE DENEGAÇÃO DE USO';
            end;

            if FProtocoloNFE <> '' then
                qrlProtocolo.Caption        := FProtocoloNFE
            else
                qrlProtocolo.Caption        :=  FNFe.procNFe.nProt + ' ' +
                                                NotaUtil.SeSenao(FNFe.procNFe.dhRecbto <> 0, DateTimeToStr(FNFe.procNFe.dhRecbto),'') ;
            qriBarCodeContingencia.Visible  := False;
        end;
        // Contingencia ********************************************************
        if FNFe.Ide.tpEmis in [teContingencia, teFSDA] then
        begin
            strChaveContingencia:= NotaUtil.GerarChaveContingencia(FNFe);
            SetBarCodeImage(strChaveContingencia,qriBarCodeContingencia);
            qriBarCodeContingencia.Visible  := True;
            qrlDescricao.Caption            := 'DADOS DA NF-E';
            qrlProtocolo.Caption            := NotaUtil.FormatarChaveContigencia(strChaveContingencia);
        end;
        // DPEC ****************************************************************
        if FNFe.Ide.tpEmis = teDPEC then
        begin
            qrlDescricao.Caption := 'NÚMERO DE REGISTRO DPEC';
            qrlProtocolo.Caption := FProtocoloNFE;
            //qrlProtocolo.Caption := FNFe.procNFe.nProt + ' '  +
            //                        NotaUtil.SeSenao(FNFe.procNFe.dhRecbto <> 0, DateTimeToStr(FNFe.procNFe.dhRecbto),'') ;
        end;
    //************************************************************************
    end ;
end;

end.
