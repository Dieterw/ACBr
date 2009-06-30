unit ACBrNFeDANFEQRDM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, QuickRpt, QRCtrls, StdCtrls,   DB, DBClient,
  IniFiles, MaskUtils, Mask, pcnNFe, pcnConversao ;

type
  TformACBrNFeQR = class(TForm)
    QuickRepDanfe: TQuickRep;
    QRBandDadosEmitenteChaveAcesso: TQRBand;
    QRLabel6: TQRLabel;
    QRImageLogoEmp: TQRImage;
    QRShape8: TQRShape;
    QRLabel7: TQRLabel;
    QRLabel8: TQRLabel;
    QRShape9: TQRShape;
    QRLabel9: TQRLabel;
    QRLabel10: TQRLabel;
    QRLEntrada_Saida: TQRLabel;
    QRLNumNota2: TQRLabel;
    QRLSerie2: TQRLabel;
    QRLNumPagina: TQRLabel;
    QRLRazao_Emit: TQRLabel;
    QRLFantasia_Emit: TQRLabel;
    QRLEndereco_Emit: TQRLabel;
    QRShape10: TQRShape;
    QRLabel14: TQRLabel;
    QRLNatOperacao: TQRLabel;
    QRShape12: TQRShape;
    QRShape6: TQRShape;
    QRShape11: TQRShape;
    QRLabel16: TQRLabel;
    QRLInscEstadual_Emit: TQRLabel;
    QRLabel18: TQRLabel;
    QRLInscEstadualSubst_Emit: TQRLabel;
    QRShape13: TQRShape;
    QRLCNPJ_Emit: TQRLabel;
    QRLabel19: TQRLabel;
    QRShape14: TQRShape;
    QRLabel17: TQRLabel;
    QRLChaveAcesso: TQRLabel;
    QRBandCabecalho: TQRBand;
    QRShape1: TQRShape;
    QRLabelRecebemosDe: TQRLabel;
    QRShape2: TQRShape;
    QRShape3: TQRShape;
    QRShape4: TQRShape;
    QRShape5: TQRShape;
    QRLabel3: TQRLabel;
    QRLabel4: TQRLabel;
    QRLabel5: TQRLabel;
    QRLNumNota: TQRLabel;
    QRLSerie: TQRLabel;
    QRBandDetalhe: TQRBand;
    ChildBandDadosDestRemetFatImpostos: TQRChildBand;
    QRLabel20: TQRLabel;
    QRLRazao_Dest2: TQRLabel;
    QRShape18: TQRShape;
    QRLCNPJCPF_Dest: TQRLabel;
    QRShape19: TQRShape;
    QRLEndereco_Dest: TQRLabel;
    QRShape21: TQRShape;
    QRShape22: TQRShape;
    QRLBairro_Dest: TQRLabel;
    QRShape17: TQRShape;
    QRLabel22: TQRLabel;
    QRLMunicipio_Dest: TQRLabel;
    QRShape24: TQRShape;
    QRLFoneFax_Dest: TQRLabel;
    QRLabel35: TQRLabel;
    QRShape25: TQRShape;
    QRShape26: TQRShape;
    QRShape27: TQRShape;
    QRShape28: TQRShape;
    QRLabel38: TQRLabel;
    QRLDataEmissao: TQRLabel;
    QRLDataEntrada: TQRLabel;
    QRLabel40: TQRLabel;
    QRLabel41: TQRLabel;
    QRLHoraSaida: TQRLabel;
    QRLCEP_Dest: TQRLabel;
    QRLInscEstadual_Dest: TQRLabel;
    QRLabel24: TQRLabel;
    QRShape20: TQRShape;
    QRLUF_Dest: TQRLabel;
    QRLabel28: TQRLabel;
    QRLValorTotalProd: TQRLabel;
    QRLValorTotalNota: TQRLabel;
    QRShape16: TQRShape;
    QRLabel21: TQRLabel;
    QRShape23: TQRShape;
    QRLabel23: TQRLabel;
    QRLBaseCalcICMS: TQRLabel;
    QRLabel29: TQRLabel;
    QRShape29: TQRShape;
    QRShape30: TQRShape;
    QRLabel26: TQRLabel;
    QRLValorTotalICMS: TQRLabel;
    QRLabel30: TQRLabel;
    QRLBaseCalcICMSSubst: TQRLabel;
    QRShape31: TQRShape;
    QRLabel33: TQRLabel;
    QRLValorICMSSubst: TQRLabel;
    QRShape32: TQRShape;
    QRLabel37: TQRLabel;
    QRShape33: TQRShape;
    QRLValorFrete: TQRLabel;
    QRLabel34: TQRLabel;
    QRShape34: TQRShape;
    QRShape35: TQRShape;
    QRLabel36: TQRLabel;
    QRLValorSeguro: TQRLabel;
    QRLabel42: TQRLabel;
    QRLValorDesconto: TQRLabel;
    QRShape36: TQRShape;
    QRLabel44: TQRLabel;
    QRLValorOutrasDespesas: TQRLabel;
    QRShape37: TQRShape;
    QRLValorTotalIPI: TQRLabel;
    QRLabel47: TQRLabel;
    QRShape38: TQRShape;
    QRLabel31: TQRLabel;
    QRShape39: TQRShape;
    QRLabel39: TQRLabel;
    QRLRazao_Transp: TQRLabel;
    QRLabel45: TQRLabel;
    QRShape41: TQRShape;
    QRLabel49: TQRLabel;
    QRShape42: TQRShape;
    QRLabel51: TQRLabel;
    QRLCodAntt: TQRLabel;
    QRShape43: TQRShape;
    QRLPlacaVeic: TQRLabel;
    QRLabel54: TQRLabel;
    QRLabel43: TQRLabel;
    QRLabel46: TQRLabel;
    QRShape40: TQRShape;
    QRLTipoFrete: TQRLabel;
    QRShape44: TQRShape;
    QRShape45: TQRShape;
    QRLabel48: TQRLabel;
    QRLUFPlaca_Transp: TQRLabel;
    QRLabel50: TQRLabel;
    QRLCNPJCPF_Transp: TQRLabel;
    QRShape46: TQRShape;
    QRLEnder_Transp: TQRLabel;
    QRLabel53: TQRLabel;
    QRShape47: TQRShape;
    QRLabel55: TQRLabel;
    QRLMunicipio_Trans: TQRLabel;
    QRShape51: TQRShape;
    QRShape52: TQRShape;
    QRLabel63: TQRLabel;
    QRLUF_Transp: TQRLabel;
    QRLabel65: TQRLabel;
    QRLInscEstad_Transp: TQRLabel;
    QRShape48: TQRShape;
    QRLQtd_Transp: TQRLabel;
    QRLabel56: TQRLabel;
    QRShape49: TQRShape;
    QRLabel57: TQRLabel;
    QRLEspecie: TQRLabel;
    QRShape50: TQRShape;
    QRShape53: TQRShape;
    QRLabel59: TQRLabel;
    QRLNumeracao_Transp: TQRLabel;
    QRLabel61: TQRLabel;
    QRLPesoBruto: TQRLabel;
    QRShape54: TQRShape;
    QRLMarca: TQRLabel;
    QRLabel58: TQRLabel;
    QRLabel52: TQRLabel;
    QRLPesoLiquido: TQRLabel;
    QRShape55: TQRShape;
    QRLabel60: TQRLabel;
    ChildBand1: TQRChildBand;
    QRLabel62: TQRLabel;
    QRShape57: TQRShape;
    QRLabel64: TQRLabel;
    QRShape58: TQRShape;
    QRLabel66: TQRLabel;
    QRShape59: TQRShape;
    QRLabel67: TQRLabel;
    QRShape60: TQRShape;
    QRShape61: TQRShape;
    QRLabel68: TQRLabel;
    QRLabel69: TQRLabel;
    QRShape62: TQRShape;
    QRLabel70: TQRLabel;
    QRShape64: TQRShape;
    QRLabel71: TQRLabel;
    QRShape65: TQRShape;
    QRLabel72: TQRLabel;
    QRShape56: TQRShape;
    QRLabel73: TQRLabel;
    QRShape66: TQRShape;
    QRLabel74: TQRLabel;
    QRShape67: TQRShape;
    QRLabel75: TQRLabel;
    QRShape68: TQRShape;
    QRLabel76: TQRLabel;
    QRShape69: TQRShape;
    QRLabel77: TQRLabel;
    QRShape70: TQRShape;
    QRShape71: TQRShape;
    QRShape72: TQRShape;
    QRShape73: TQRShape;
    QRShape74: TQRShape;
    QRShape75: TQRShape;
    QRShape76: TQRShape;
    QRShape77: TQRShape;
    QRShape78: TQRShape;
    QRShape79: TQRShape;
    QRShape80: TQRShape;
    QRShape81: TQRShape;
    QRShape82: TQRShape;
    ChildBandDetalhe: TQRChildBand;
    QRBandSumario: TQRBand;
    QRLabel78: TQRLabel;
    QRShape63: TQRShape;
    QRLInscMunic_Dest: TQRLabel;
    QRLabel81: TQRLabel;
    QRShape83: TQRShape;
    QRShape84: TQRShape;
    QRLabel82: TQRLabel;
    QRLValorTotalServicos: TQRLabel;
    QRLabel84: TQRLabel;
    QRLBaseCalcISSQN: TQRLabel;
    QRShape85: TQRShape;
    QRLabel86: TQRLabel;
    QRLValorISSQN: TQRLabel;
    QRLabel79: TQRLabel;
    QRDBText1: TQRDBText;
    QRDBText2: TQRDBText;
    RadioButton1: TRadioButton;
    QRLFatura: TQRLabel;
    QRShape7: TQRShape;
    QRLDadosAdic: TQRLabel;
    QRShape86: TQRShape;
    QRShape87: TQRShape;
    QRICodBarras: TQRImage;
    QRDBText3: TQRDBText;
    QRDBText4: TQRDBText;
    QRDBText5: TQRDBText;
    QRDBText6: TQRDBText;
    QRDBText7: TQRDBText;
    QRDBText8: TQRDBText;
    QRDBText9: TQRDBText;
    QRDBText10: TQRDBText;
    QRDBText11: TQRDBText;
    QRDBText12: TQRDBText;
    QRDBText13: TQRDBText;
    QRDBText14: TQRDBText;
    QRLabel25: TQRLabel;
    QRShape15: TQRShape;
    QRLabel1: TQRLabel;
    QRLabel2: TQRLabel;
    QRLabel11: TQRLabel;
    QRLabel12: TQRLabel;
    QRShape88: TQRShape;
    QRShape89: TQRShape;
    QRLRazao_Dest: TQRLabel;
    procedure ChildBandDadosDestRemetFatImpostosBeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
    procedure QRBandDadosEmitenteChaveAcessoBeforePrint(Sender: TQRCustomBand;var PrintBand: Boolean);
    procedure ChildBandDetalheBeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
    procedure QRBandDetalheAfterPrint(Sender: TQRCustomBand;BandPrinted: Boolean);
    procedure QuickRepDanfeBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
  private
    FNFe : TNFe;
    BitMap : TBitmap;
    ArquivoINI : TIniFile;
    procedure CarregaDadosParaQuickReport(Arquivo : String);

    function SomenteLetras(Texto : String) : String;
    function SomenteNumeros(Texto : String;RetornoDefault : String = '') : String;

    procedure ImprimeBitMap(Cnv: TCanvas; BitMap: TBitMap;  R: TRect);
  public
    { Public declarations }
    TotalPaginas : Integer;

    property NFe : TNFe read FNFe write FNFe;

    procedure CarregaDadosCabecalho;
    procedure CarregaDadosItens;
    procedure CarregaDadosRodape;
    procedure LimpaQrLabels;

  end;

var
  formACBrNFeQR: TformACBrNFeQR;

Const
  MascaraChaveAcesso = '99\.99\.99\.99\.999\.999\.9999\/99\-99\-999\.999\.999\-999\-999\.999\.999\-9;0';

implementation

uses ACBrNFe, ACBrNFeUtil;

{$R *.dfm}

procedure TformACBrNFeQR.ChildBandDetalheBeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
begin
//  PrintBand := ClientDataSetNF.RecNo = ClientDataSetNF.RecordCount;
end;



procedure TformACBrNFeQR.CarregaDadosCabecalho;
Var Ind : integer;
  function GeraCodigoBarras(ChaveAcesso : String) : TBitmap;
  var
//    BarCode: TBarcode;
    Bitmap: TBitmap;
  begin
//    BarCode := TBarcode.Create(nil);
    Bitmap := TBitmap.Create;
    Try
//      BarCode.Height := 80;
//      BarCode.Typ := bcCode128C;
//      BarCode.Ratio := 2;
//      BarCode.CheckSumMethod := csmNone;
//      BarCode.Modul := 1;
      Bitmap.HandleType := bmDDB;
      Bitmap.PixelFormat := pf1bit;
      Bitmap.Height := 92;
      Bitmap.Width := 478;
//      BarCode.Text := ChaveAcesso;
//      BarCode.DrawBarcode(Bitmap.Canvas);
      Result := Bitmap;
    Finally
      //Bitmap.Free;
//      BarCode.Free;
    End;
  end;
  Function InsereZeros(nInt,nTam:Integer):String;
  //
  // Colocar Zeros a esquerda
  //
  Var
    X: String;
    nI: Integer;
  Begin
    For nI := 1 To nTam Do X := X + '0';
      Begin
      X := X + IntToStr(nInt);
      End;
    Result := Copy(X,Length(X) - nTam + 1,nTam)
  end;
begin
  QRLabelRecebemosDe.Caption := 'RECEBI(EMOS) DE (' + FNFe.Emit.xNome  + ') OS PRODUTOS CONSTANTES DA NOTA FISCAL INDICADA AO LADO:';
  //Número da NF
  QRLNumNota.Caption := 'Nº. ' + FormatMaskText('999\.999\.999;0;_',  InsereZeros(FNFe.Ide.nNF,9));
  QRLNumNota2.Caption := QRLNumNota.Caption;
  //Série da NF
  QRLSerie.Caption := 'SÉRIE ' + FormatFloat('000',FNFe.Ide.Serie);
  QRLSerie2.Caption := QRLSerie.Caption;
  //Chave de acesso e código de barras da chave de acesso
  QRICodBarras.Picture.Bitmap := GeraCodigoBarras(FNFe.infNFe.ID);
  //QRLChaveAcesso.Caption := FormatMaskText(MascaraChaveAcesso,FormatZeros(44,ArquivoINI.ReadString('chaveacesso','ID','0')));
  QRLChaveAcesso.Caption := FormatMaskText(MascaraChaveAcesso,FNFe.infNFe.ID);
  //Entrada/Saida 0 = Entrada 1 = Saída
  QRLEntrada_Saida.Caption := NotaUtil.SeSenao(FNFe.Ide.TpNF=tnEntrada,'0','1');
  //Razão Social Empresa Emitente
  QRLRazao_Emit.Caption := FNFe.Emit.xNome;
  //Fantasia Empresa Emitente
  QRLFantasia_Emit.Caption := FNFe.Emit.xFant;
  //Dados do endereço do emitente
  QRLEndereco_Emit.Caption := SomenteLetras(FNFe.Emit.EnderEmit.xLgr) + ', ' +
                              SomenteNumeros(FNFe.Emit.EnderEmit.nro,'S/N');
  //Complemento
  if FNFe.Emit.EnderEmit.xCpl <> '' then
    QRLEndereco_Emit.Caption := QRLEndereco_Emit.Caption + ' ' +
                                FNFe.Emit.EnderEmit.xCpl;
  //Bairro / Cidade / UF / CEP
  QRLEndereco_Emit.Caption := QRLEndereco_Emit.Caption + ' ' +
                              FNFe.Emit.EnderEmit.xBairro + ' - ' +
                              FNFe.Emit.EnderEmit.xMun + ' - ' +
                              FNFe.Emit.EnderEmit.UF + ' CEP: ' +
                              IntToStr(FNFe.Emit.EnderEmit.CEP);
  //Fone
  if FNFe.Emit.EnderEmit.fone <> '' then
    QRLEndereco_Emit.Caption := QRLEndereco_Emit.Caption + ' Fone: ' +
                                FNFe.Emit.EnderEmit.fone;


  //Descrição CFOP
  QRLNatOperacao.Caption := FNFe.Ide.natOp;
  //Insc. Estadual Emitente
  QRLInscEstadual_Emit.Caption := FNFe.Emit.IE;
  //Insc. Estadual Subst. Trib Emitente
  QRLInscEstadualSubst_Emit.Caption := FNFe.Emit.IEST;
  //CNPJ
  QRLCNPJ_Emit.Caption := FNFe.Emit.CNPJCPF;

  //**** DATA EMISSÃO - DATA ENTRADA/SAIDA - HORA SAÍDA
  QRLDataEmissao.Caption := DateToStr(FNFe.Ide.dEmi);

  QRLDataEntrada.Caption := DateToStr(FNFe.Ide.dSaiEnt);

//  QRLHoraSaida.Caption   := ArquivoINI.ReadString('ide','dHoraSaida','');

  // **************** Dados do Destinatário
  //Razão Social
  QRLRazao_Dest.Caption := FNFe.Dest.xNome;
  QRLRazao_Dest2.Caption := QRLRazao_Dest.Caption;
  //CNPJ-CPF
  QRLCNPJCPF_Dest.Caption := FNFe.Dest.CNPJCPF;
  //Endereço
  QRLEndereco_Dest.Caption := FNFe.Dest.EnderDest.xLgr;
  QRLEndereco_Dest.Caption := QRLEndereco_Dest.Caption + ' ' +  SomenteNumeros(FNFe.Dest.EnderDest.nro,'S/N');
  if FNFe.Dest.EnderDest.xCpl <> '' then
    QRLEndereco_Dest.Caption := QRLEndereco_Dest.Caption +  FNFe.Dest.EnderDest.xCpl;

  //Bairro
  QRLBairro_Dest.Caption := FNFe.Dest.EnderDest.xBairro;
  //CEP
  QRLCEP_Dest.Caption := IntToStr(FNFe.Dest.EnderDest.CEP);
  //Municipio
  QRLMunicipio_Dest.Caption := FNFe.Dest.EnderDest.xMun;
  //Fone/FAX
  QRLFoneFax_Dest.Caption := FNFe.Dest.EnderDest.fone;
  //UF
  QRLUF_Dest.Caption := FNFe.Dest.EnderDest.UF;
  //Insc. Estadual
  QRLInscEstadual_Dest.Caption := FNFe.Dest.IE;
  //

  //********* FATURA
  for Ind := 0 to FNFe.Cobr.Dup.Count-1 do
  begin
    if Ind = 0 then
    begin
//      QRLFatura.Caption := IntToStr(FNFe.Cobr.Dup.Items[0].
      if (ArquivoINI.ReadString('dup=' + IntToStr(Ind),'dVenc','') <> '') and
         (ArquivoINI.ReadString('dup=' + IntToStr(Ind),'vDup','') <> '') then
      QRLFatura.Caption := QRLFatura.Caption + '  ' + ArquivoINI.ReadString('dup=' + IntToStr(Ind),'dVenc','') +
                           ' - ' +
                           ArquivoINI.ReadString('dup=' + IntToStr(Ind),'vDup','');
    end
    else
    begin

      QRLFatura.Caption := QRLFatura.Caption + ' | ' +
                           ArquivoINI.ReadString('dup=' + IntToStr(Ind),'nDup','') + ' ' +
                           ArquivoINI.ReadString('dup=' + IntToStr(Ind),'dVenc','') + ' - ' +
                           ArquivoINI.ReadString('dup=' + IntToStr(Ind),'vDup','')
    end;
  end;
  //Base Calc ICMS
  QRLBaseCalcICMS.Caption := FloatToStr(FNFe.Total.ICMSTot.vBC);
  //Valor do ICMS
  QRLValorTotalICMS.Caption := FloatToStr(FNFe.Total.ICMSTot.vICMS);
  //Base Calc ICMS Subst
  QRLBaseCalcICMSSubst.Caption := FloatToStr(FNFe.Total.ICMSTot.vBCST);
  //Valor do ICMS Subst
  QRLValorICMSSubst.Caption := FloatToStr(FNFe.Total.ICMSTot.vST);
  //Valor Total dos produtos
  QRLValorTotalProd.Caption := FloatToStr(FNFe.Total.ICMSTot.vProd);
  //Valor do Frete
  QRLValorFrete.Caption := FloatToStr(FNFe.Total.ICMSTot.vFrete);
  //Valor do Seguro
  QRLValorSeguro.Caption := FloatToStr(FNFe.Total.ICMSTot.vSeg);
  //Valor do Desconto
  QRLValorDesconto.Caption := FloatToStr(FNFe.Total.ICMSTot.vDesc);
  //Valor Outras Despesas Acessórias
  QRLValorOutrasDespesas.Caption := FloatToStr(FNFe.Total.ICMSTot.vOutro);
  //Valor do IPI
  QRLValorTotalIPI.Caption := FloatToStr(FNFe.Total.ICMSTot.vIPI);
  //Valor total da Nota
  QRLValorTotalNota.Caption := FloatToStr(FNFe.Total.ICMSTot.vNF);
  //*******  DADOS DO TRANSPORTADOR
  //Razão
  QRLRazao_Transp.Caption := FNFe.Transp.Transporta.xNome;
  //Tipo Frete
  QRLTipoFrete.Caption := modFreteToStr(FNFe.Transp.modFrete);

  //Cód. ANTT
  QRLCodAntt.Caption := FNFe.Transp.veicTransp.RNTC;
  //Placa do Veículo
  QRLPlacaVeic.Caption := FNFe.Transp.veicTransp.placa;
  //UF da Placa
  QRLUFPlaca_Transp.Caption := FNFe.Transp.veicTransp.UF;
  //CNPJ/CPF
  QRLCNPJCPF_Transp.Caption := FNFe.Transp.Transporta.CNPJCPF;
  //Endereço
  QRLEnder_Transp.Caption := FNFe.Transp.Transporta.xEnder;
  //Municipio
  QRLMunicipio_Trans.Caption := FNFe.Transp.Transporta.xMun;
  //UF
  QRLUF_Transp.Caption := FNFe.Transp.Transporta.UF;
  //Insc. Estadual
  QRLInscEstad_Transp.Caption := FNFe.Transp.Transporta.IE;
  //Quantidade
  QRLQtd_Transp.Caption := IntToStr(FNFe.Transp.Vol.Items[0].qVol);
  //Espécie
  QRLEspecie.Caption := FNFe.Transp.Vol.Items[0].esp;
  //Numeração
  QRLNumeracao_Transp.Caption := FNFe.Transp.Vol.Items[0].nVol;
  //Peso Bruto
  QRLPesoBruto.Caption := FloatToStr(FNFe.Transp.Vol.Items[0].pesoB);
  //Peso Liquido
  QRLPesoLiquido.Caption :=  FloatToStr(FNFe.Transp.Vol.Items[0].pesoL);
end;

procedure TformACBrNFeQR.CarregaDadosItens;
begin

end;

procedure TformACBrNFeQR.CarregaDadosParaQuickReport(Arquivo: String);
begin
  Try
    ArquivoINI := TiniFile.Create(Arquivo);

    if ArquivoINI.ReadString('Danfe', 'Preview','') = 'S' then
      QuickRepDanfe.Preview
    else
    begin
      if TotalPaginas > 1 then
        QuickRepDanfe.Preview
      else
        QuickRepDanfe.Print;
    end;
  Finally
    ArquivoINI.Free
  End;
end;

procedure TformACBrNFeQR.CarregaDadosRodape;
begin
  //Insc. Municipal
  QRLInscMunic_Dest.Caption := ArquivoINI.ReadString('emit','IM','');
  //Valor Total do serviços
  QRLValorTotalServicos.Caption := ArquivoINI.ReadString('ISSQNtot','vServ','');
  //Base de Calc. Issqn
  QRLBaseCalcISSQN.Caption := ArquivoINI.ReadString('ISSQNtot','vBC','');
  //Valor do ISSQN
  QRLValorISSQN.Caption := ArquivoINI.ReadString('ISSQNtot','vISS','');
  //Dados Adcionais
  QRLDadosAdic.Caption := ArquivoINI.ReadString('infAdic','infCpl','') + #13#10 +
                          'Protocolo: ' + ArquivoINI.ReadString('ProtocoloRecebimento', 'nProt', '') ;

end;

procedure TformACBrNFeQR.ChildBandDadosDestRemetFatImpostosBeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  PrintBand := QuickRepDanfe.PageNumber = 1;
end;

procedure TformACBrNFeQR.ImprimeBitMap(Cnv: TCanvas; BitMap: TBitMap; R: TRect);
 var
    Info : PBitMapInfo;
    InfoSize : DWORD;
    Image : Pointer;
    ImageSize : DWORD;
begin
  with BitMap do
  begin
    GetDIBSizes(Handle, InfoSize, ImageSize);
    GetMem(Info, InfoSize);
    Try
      Getmem(Image, ImageSize);
      Try
        GetDIB(Handle, Palette, Info^,Image^);
        with Info^.bmiHeader do
           StretchDIBits(Cnv.Handle, R.Left, R.Top, R.Right - R.Left, R.Bottom - R.Top,
           0, 0, biWidth, biHeight, Image, Info^,DIB_RGB_COLORS, SRCAND);
      Finally
        FreeMem(Image, ImageSize);
      end;
    Finally
       FreeMem(Info, InfoSize);
    end;
  end;
end;

procedure TformACBrNFeQR.LimpaQrLabels;
Var Ind : Integer;
begin
  for Ind := 0 to Self.ComponentCount - 1 do
  begin
    if Self.Components[Ind] is TQRLabel then
    begin
       if (Self.Components[Ind] as TQRLabel).Tag <> 99 then
         (Self.Components[Ind] as TQRLabel).Caption :=  '';
    end;
  end;
end;

procedure TformACBrNFeQR.QRBandDadosEmitenteChaveAcessoBeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  // - FL 1/1
  QRLNumPagina.Caption := ' - FL ' + IntToStr(QuickRepDanfe.QRPrinter.PageNumber) + '/' + IntToStr(TotalPaginas);
end;

procedure TformACBrNFeQR.QRBandDetalheAfterPrint(Sender: TQRCustomBand;BandPrinted: Boolean);
var
  R                    : TRect;
  X, Y                 : integer;
begin
  if FNFe.Ide.tpAmb = taHomologacao then
  begin
    BitMap := TBitMap.Create;
    BitMap.LoadFromFile('SemValorFiscal.bmp');

    for y := 0 to BitMap.height - 1 do
      for x := 0 to BitMap.width - 1 do
      begin
        if (x mod 2)=(y mod 2) then
          BitMap.canvas.pixels[x, y] := clWhite;
      end;


    with QuickRepDanfe.QRPrinter do
    begin
      Y := YPos(PaperLengthValue) div 6;
      X := XPos(PaperWidthValue) div 4;
      R := Rect(X, 2 * Y, 3 * X, 4 * Y);
      ImprimeBitMap(Canvas, BitMap, R);
    end;
  end;
end;

function TformACBrNFeQR.SomenteLetras(Texto: String): String;
Var I : Integer;
begin
  Result := '';
  if Trim(Texto )<> '' then
  begin
    for I := 0 to Length(Texto) do
      if Texto[I] in ['A'..'Z','a'..'z', ' '] then
        Result := Result + Texto[I];
  end;
end;

function TformACBrNFeQR.SomenteNumeros(Texto, RetornoDefault: String): String;
var
  I: Integer;
begin
  Result := '';
  if Trim(Texto )<> '' then
  begin
    for I := 0 to Length(Texto) do
      if Texto[I] in ['0'..'9'] then
        Result := Result + Texto[I];
  end;
end;

procedure TformACBrNFeQR.QuickRepDanfeBeforePrint(Sender: TCustomQuickRep;var PrintReport: Boolean);
begin
  if FileExists(ExtractFilePath(Application.ExeName) + 'LogoDanfe.gif') then
  begin
    QRImageLogoEmp.Picture.LoadFromFile(ExtractFilePath(Application.ExeName) + 'LogoDanfe.gif');
    QRImageLogoEmp.Refresh;
  end;
end;

end.
