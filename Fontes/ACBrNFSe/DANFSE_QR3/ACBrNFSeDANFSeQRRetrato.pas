{$I ACBr.inc}
unit ACBrNFSeDANFSeQRRetrato;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, QuickRpt, QRCtrls,  XMLIntf, XMLDoc, JPEG, DB, DBClient,
  pnfsConversao, ACBrNFSeDANFSEClass, ACBrNFSeDANFSeQR, ACBrNFSeDANFSeQRClass;

type

  TfqrDANFSeQRRetrato = class(TfqrDANFSeQR)
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
    qrb_1_Cabecalho: TQRBand;
    qrb_2_PrestadorServico: TQRChildBand;
    qrb_3_TomadorServico: TQRChildBand;
    qrb_4_HeaderItens: TQRBand;
    qrb_6_ISSQN: TQRBand;
    qrb_7_OutrasInformacoes: TQRChildBand;
    QRShape1: TQRShape;
    QRShape3: TQRShape;
    QRShape2: TQRShape;
    qrlNumNF0: TQRLabel;
    QRLabel13: TQRLabel;
    QRLabel12: TQRLabel;
    QRShape7: TQRShape;
    QRLabel29: TQRLabel;
    QRLabel30: TQRLabel;
    QRLabel31: TQRLabel;
    QRLabel32: TQRLabel;
    qrlPrestMunicipio: TQRLabel;
    qrlPrestInscMunicipal: TQRLabel;
    qrlPrestEndereco: TQRLabel;
    qrlPrestCNPJ: TQRLabel;
    QRShape12: TQRShape;
    QRShape52: TQRShape;
    QRShape53: TQRShape;
    QRShape54: TQRShape;
    QRShape55: TQRShape;
    QRLabel137: TQRLabel;
    QRLabel138: TQRLabel;
    QRLabel139: TQRLabel;
    qrlBaseCalc: TQRLabel;
    qrlValorISS: TQRLabel;
    QRShape56: TQRShape;
    qrmDadosAdicionais: TQRMemo;
    qrlMsgTeste: TQRLabel;
    qrb_5_Itens: TQRBand;
    qrmProdutoDescricao: TQRDBText;
    qrlDataHoraImpressao: TQRLabel;
    qrlSistema: TQRLabel;
    cdsItensXPROD: TStringField;
    cdsItensINFADIPROD: TStringField;
    cdsItensCSOSN: TStringField;
    qriLogo: TQRImage;
    qrlEmissao: TQRLabel;
    QRLabel8: TQRLabel;
    qrlCodVerificacao: TQRLabel;
    QRShape70: TQRShape;
    qriPrestLogo: TQRImage;
    QRLabel2: TQRLabel;
    QRLabel1: TQRLabel;
    qrlPrestNome: TQRLabel;
    QRLabel9: TQRLabel;
    qrlPrestUF: TQRLabel;
    QRLabel4: TQRLabel;
    QRLabel5: TQRLabel;
    qrlTomaCNPJ: TQRLabel;
    QRLabel11: TQRLabel;
    qrlTomaInscMunicipal: TQRLabel;
    QRLabel15: TQRLabel;
    qrlTomaNome: TQRLabel;
    QRLabel17: TQRLabel;
    qrlTomaEndereco: TQRLabel;
    QRLabel19: TQRLabel;
    qrlTomaMunicipio: TQRLabel;
    QRLabel21: TQRLabel;
    qrlTomaUF: TQRLabel;
    QRLabel10: TQRLabel;
    qrlTomaEmail: TQRLabel;
    QRLabel14: TQRLabel;
    QRShape4: TQRShape;
    qrlValorTotal: TQRLabel;
    QRShape5: TQRShape;
    QRLabel16: TQRLabel;
    qrlCodServico: TQRLabel;
    QRLabel3: TQRLabel;
    qrlAliquota: TQRLabel;
    QRShape6: TQRShape;
    QRLabel6: TQRLabel;
    QRShape8: TQRShape;
    QRLabel7: TQRLabel;
    qrlCompetencia: TQRLabel;
    QRShape9: TQRShape;
    QRLabel18: TQRLabel;
    qrlNumeroRps: TQRLabel;
    QRShape10: TQRShape;
    QRLabel20: TQRLabel;
    qrlNumNFSeSubstituida: TQRLabel;
    QRLabel22: TQRLabel;
    qrlPrestComplemento: TQRLabel;
    QRLabel23: TQRLabel;
    qrlPrestTelefone: TQRLabel;
    QRLabel24: TQRLabel;
    qrlPrestEmail: TQRLabel;
    QRLabel25: TQRLabel;
    qrlTomaComplemento: TQRLabel;
    QRLabel27: TQRLabel;
    qrlTomaTelefone: TQRLabel;
    qrsLinhaH1: TQRShape;
    qrlCodigoObra: TQRLabel;
    qrlCodObra: TQRLabel;
    qrlTituloConstCivil: TQRLabel;
    qrlCodigoArt: TQRLabel;
    qrlCodART: TQRLabel;
    QRLabel34: TQRLabel;
    qrlValorPIS: TQRLabel;
    QRLabel36: TQRLabel;
    qrlValorCOFINS: TQRLabel;
    QRLabel38: TQRLabel;
    qrlValorIR: TQRLabel;
    QRLabel40: TQRLabel;
    qrlValorINSS: TQRLabel;
    QRLabel42: TQRLabel;
    qrlValorCSLL: TQRLabel;
    QRLabel44: TQRLabel;
    QRShape13: TQRShape;
    QRShape14: TQRShape;
    QRLabel35: TQRLabel;
    QRLabel37: TQRLabel;
    QRLabel39: TQRLabel;
    QRLabel41: TQRLabel;
    QRLabel43: TQRLabel;
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
    QRShape15: TQRShape;
    QRShape16: TQRShape;
    qrlValorServicos1: TQRLabel;
    qrlValorServicos2: TQRLabel;
    qrlDescIncondicionado1: TQRLabel;
    qrlDescIncondicionado2: TQRLabel;
    qrlDescCondicionado: TQRLabel;
    qrlRetencoesFederais: TQRLabel;
    qrlOutrasRetencoes: TQRLabel;
    qrlValorIssRetido: TQRLabel;
    qrlValorLiquido: TQRLabel;
    QRShape17: TQRShape;
    qrlIncentivador: TQRLabel;
    qrlNatOperacao: TQRLabel;
    qrlValorDeducoes: TQRLabel;
    qrlRegimeEspecial: TQRLabel;
    qrlOpcaoSimples: TQRLabel;
    qrlISSReter: TQRLabel;
    qrmPrefeitura: TQRMemo;
    qrmDescricao: TQRMemo;
    procedure qrb_1_CabecalhoBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure qrb_2_PrestadorServicoBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure qrb_3_TomadorServicoBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure qrb_5_ItensBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure qrb_6_ISSQNBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure qrb_7_OutrasInformacoesBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure cdsItensAfterScroll(DataSet: TDataSet);
    procedure QRNFSeBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
  private
    { Private declarations }
    procedure Itens;
  public
    { Public declarations }
  end;


implementation

uses
 StrUtils, DateUtils, 
 ACBrUtil, ACBrDFeUtil, ACBrNFSeUtil, pnfsNFSe;

{$R *.dfm}

const
 _NUM_ITEMS_PAGE1      = 18;
 _NUM_ITEMS_OTHERPAGES = 50;

procedure TfqrDANFSeQRRetrato.cdsItensAfterScroll(DataSet: TDataSet);
//var
// intTamanhoDescricao: Integer;
begin
  inherited;

// intTamanhoDescricao:= Length(cdsItens.FieldByName( 'DESCRICAO' ).AsString);

end;

procedure TfqrDANFSeQRRetrato.Itens;
begin
 cdsItens.Close;
 cdsItens.CreateDataSet;
 cdsItens.Open;

 cdsItens.Append;
 cdsItens.FieldByName('DESCRICAO').AsString := FNFSe.Servico.Discriminacao;
 cdsItens.Post;

 cdsItens.First;
end;

procedure TfqrDANFSeQRRetrato.qrb_1_CabecalhoBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
var
 t: integer;
begin
  inherited;

 if (FLogo <> '') and FilesExists(FLogo)
  then begin
   qriLogo.Picture.LoadFromFile(FLogo);
  end;

 qrmPrefeitura.Lines.Clear;

 qrmPrefeitura.Lines.Add(StringReplace( FPrefeitura,
                         ';', #13#10, [rfReplaceAll,rfIgnoreCase] ) );

 qrlNumNF0.Caption  := FormatFloat('00000000000', StrToFloatDef(FNFSe.Numero, 0));
 qrlEmissao.Caption := DFeUtil.FormatDateTime(DateTimeToStr(FNFSe.DataEmissao));
 qrlCodVerificacao.Caption := FNFSe.CodigoVerificacao;
 t:=length(FNFSe.Competencia);
 if t=6
  then qrlCompetencia.Caption := Copy(FNFSe.Competencia, 5, 2) + '/' + Copy(FNFSe.Competencia, 1, 4)
  else qrlCompetencia.Caption := Copy(FNFSe.Competencia, 6, 2) + '/' + Copy(FNFSe.Competencia, 1, 4);
 qrlNumeroRPS.Caption := FNFSe.IdentificacaoRps.Numero;
 qrlNumNFSeSubstituida.Caption := FNFSe.NfseSubstituida;
end;

procedure TfqrDANFSeQRRetrato.qrb_2_PrestadorServicoBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  inherited;

 if (FPrestLogo <> '') and FilesExists(FPrestLogo)
  then begin
   qriPrestLogo.Picture.LoadFromFile(FPrestLogo);
  end;

 qrlPrestCNPJ.Caption := DFeUtil.FormatarCNPJ( FNFSe.PrestadorServico.IdentificacaoPrestador.Cnpj );
 qrlPrestInscMunicipal.Caption := FNFSe.PrestadorServico.IdentificacaoPrestador.InscricaoMunicipal;
 qrlPrestNome.Caption := FNFSe.PrestadorServico.RazaoSocial;
 qrlPrestEndereco.Caption := Trim( FNFSe.PrestadorServico.Endereco.Endereco )+', '+
                             Trim( FNFSe.PrestadorServico.Endereco.Numero )+' - '+
                             Trim( FNFSe.PrestadorServico.Endereco.Bairro )+
                             ' - CEP: '+
                             DFeUtil.FormatarCEP( DFeUtil.Poem_Zeros( FNFSe.PrestadorServico.Endereco.CEP, 8 ) );
 qrlPrestComplemento.Caption := FNFSe.PrestadorServico.Endereco.Complemento;
 qrlPrestTelefone.Caption := DFeUtil.FormatarFone( FNFSe.PrestadorServico.Contato.Telefone );
 qrlPrestMunicipio.Caption := FNFSe.PrestadorServico.Endereco.CodigoMunicipio +
  ' - ' + FNFSe.PrestadorServico.Endereco.xMunicipio;
 qrlPrestUF.Caption := FNFSe.PrestadorServico.Endereco.UF;
 qrlPrestEmail.Caption := FNFSe.PrestadorServico.Contato.Email;

end;

procedure TfqrDANFSeQRRetrato.qrb_3_TomadorServicoBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  inherited;

 if Length(FNFSe.Tomador.IdentificacaoTomador.CpfCnpj)<=11
  then qrlTomaCNPJ.Caption := DFeUtil.FormatarCPF( FNFSe.Tomador.IdentificacaoTomador.CpfCnpj )
  else qrlTomaCNPJ.Caption := DFeUtil.FormatarCNPJ( FNFSe.Tomador.IdentificacaoTomador.CpfCnpj );

 qrlTomaInscMunicipal.Caption := FNFSe.Tomador.IdentificacaoTomador.InscricaoMunicipal;
 qrlTomaNome.Caption := FNFSe.Tomador.RazaoSocial;
 qrlTomaEndereco.Caption := Trim( FNFSe.Tomador.Endereco.Endereco )+', '+
                            Trim( FNFSe.Tomador.Endereco.Numero )+' - '+
                            Trim( FNFSe.Tomador.Endereco.Bairro )+
                            ' - CEP: '+
                            DFeUtil.FormatarCEP( DFeUtil.Poem_Zeros( FNFSe.Tomador.Endereco.CEP, 8 ) );
 qrlTomaComplemento.Caption := FNFSe.Tomador.Endereco.Complemento;
 qrlTomaTelefone.Caption := DFeUtil.FormatarFone( FNFSe.Tomador.Contato.Telefone );
 qrlTomaMunicipio.Caption := FNFSe.Tomador.Endereco.CodigoMunicipio +
  ' - ' + FNFSe.Tomador.Endereco.xMunicipio;
 qrlTomaUF.Caption := FNFSe.Tomador.Endereco.UF;
 qrlTomaEmail.Caption := FNFSe.Tomador.Contato.Email;

 // Mensagem para modo Homologacao.
 qrlMsgTeste.Visible := False;
 qrlMsgTeste.Enabled := False;
 if FNFSe.NfseCancelamento.DataHora<>0
  then begin
   qrlMsgTeste.Caption  := 'NFS-e CANCELADA';
   qrlMsgTeste.Visible  := True;
   qrlMsgTeste.Enabled := True;
  end;
 qrlMsgTeste.Repaint;

(*
 if FNFSe.Ide.tpAmb = taHomologacao
  then begin
   qrlMsgTeste.Caption := 'AMBIENTE DE HOMOLOGAÇÃO - SEM VALOR FISCAL';
   qrlMsgTeste.Enabled := True;
   qrlMsgTeste.Visible := True;
  end
  else begin
   if FNFSe.procNFSe.cStat > 0
    then begin

     if FNFSe.procNFSe.cStat = 102
      then begin
       qrlMsgTeste.Caption  := 'NFS-e DENEGADA';
       qrlMsgTeste.Visible  := True;
       qrlMsgTeste.Enabled := True;
      end;

     if not FNFSe.procNFSe.cStat in [101, 102, 100]
      then begin
       qrlMsgTeste.Caption:=  FNFSe.procNFSe.xMotivo;
       qrlMsgTeste.Visible := True;
       qrlMsgTeste.Enabled := True;
      end;
    end
    else begin
     qrlMsgTeste.Caption  := 'NF-E NÃO ENVIADA PARA SEFAZ';
     qrlMsgTeste.Visible  := True;
     qrlMsgTeste.Enabled  := True;
    end;
  end;

*)
end;

procedure TfqrDANFSeQRRetrato.qrb_5_ItensBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  inherited;

 qrmDescricao.Lines.Clear;

 qrmDescricao.Lines.Add( StringReplace( FNFSe.Servico.Discriminacao,
                         ';', #13#10, [rfReplaceAll, rfIgnoreCase] ) );
end;

procedure TfqrDANFSeQRRetrato.qrb_6_ISSQNBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
var
 MostrarObra: Boolean;
begin
  inherited;

// qrlValorTotal.Caption := 'VALOR TOTAL DA NOTA = R$ '+
//    DFeUtil.FormatFloat( FNFSe.Servico.Valores.ValorLiquidoNfse );

 qrlValorTotal.Caption := 'VALOR TOTAL DA NOTA = R$ '+
    DFeUtil.FormatFloat( FNFSe.Servico.Valores.ValorServicos );

 if trim(FNFSe.Servico.Descricao) = ''
  then qrlCodServico.Caption := FNFSe.Servico.ItemListaServico + ' / ' +
                                FNFSe.Servico.CodigoTributacaoMunicipio + ' - ' +
                                FNFSe.Servico.xItemListaServico
  else qrlCodServico.Caption := FNFSe.Servico.ItemListaServico + ' / ' +
                                FNFSe.Servico.CodigoTributacaoMunicipio + ' - ' +
                                FNFSe.Servico.Descricao;

 qrlCodObra.Caption := FNFSe.ConstrucaoCivil.CodigoObra;
 qrlCodART.Caption  := FNFSe.ConstrucaoCivil.Art;

 MostrarObra := (qrlCodObra.Caption<>'') or (qrlCodART.Caption<>'');
 qrsLinhaH1.Enabled:=MostrarObra;
 qrlTituloConstCivil.Enabled:=MostrarObra;
 qrlCodigoObra.Enabled:=MostrarObra;
 qrlCodObra.Enabled:=MostrarObra;
 qrlCodigoArt.Enabled:=MostrarObra;
 qrlCodART.Enabled:=MostrarObra;

 qrlValorPIS.Caption    := DFeUtil.FormatFloat( FNFSe.Servico.Valores.ValorPis );
 qrlValorCOFINS.Caption := DFeUtil.FormatFloat( FNFSe.Servico.Valores.ValorCofins );
 qrlValorIR.Caption     := DFeUtil.FormatFloat( FNFSe.Servico.Valores.ValorIr );
 qrlValorINSS.Caption   := DFeUtil.FormatFloat( FNFSe.Servico.Valores.ValorInss );
 qrlValorCSLL.Caption   := DFeUtil.FormatFloat( FNFSe.Servico.Valores.ValorCsll );

 qrlValorServicos1.Caption      := DFeUtil.FormatFloat( FNFSe.Servico.Valores.ValorServicos );
 qrlDescIncondicionado1.Caption := DFeUtil.FormatFloat( FNFSe.Servico.Valores.DescontoIncondicionado );
 qrlDescCondicionado.Caption    := DFeUtil.FormatFloat( FNFSe.Servico.Valores.DescontoCondicionado );
 qrlRetencoesFederais.Caption   := DFeUtil.FormatFloat( FNFSe.Servico.Valores.ValorPis +
                                     FNFSe.Servico.Valores.ValorCofins + FNFSe.Servico.Valores.ValorInss +
                                     FNFSe.Servico.Valores.ValorIr + FNFSe.Servico.Valores.ValorCsll );
 qrlOutrasRetencoes.Caption     := DFeUtil.FormatFloat( FNFSe.Servico.Valores.OutrasRetencoes );
 qrlValorIssRetido.Caption      := DFeUtil.FormatFloat( FNFSe.Servico.Valores.ValorIssRetido );

 qrlValorLiquido.Caption := DFeUtil.FormatFloat( FNFSe.Servico.Valores.ValorLiquidoNfse );

 // TnfseNaturezaOperacao = ( noTributacaoNoMunicipio, noTributacaoForaMunicipio, noIsencao, noImune, noSuspensaDecisaoJudicial, noSuspensaProcedimentoAdministrativo )
 case FNFSe.NaturezaOperacao of
  noTributacaoNoMunicipio   : qrlNatOperacao.Caption := '1 - Tributação no município';
  noTributacaoForaMunicipio : qrlNatOperacao.Caption := '2 - Tributação fora do município';
  noIsencao                 : qrlNatOperacao.Caption := '3 - Isenção';
  noImune                   : qrlNatOperacao.Caption := '4 - Imune';
  noSuspensaDecisaoJudicial : qrlNatOperacao.Caption := '5 - Exigibilidade susp. por decisão judicial';

  noSuspensaProcedimentoAdministrativo : qrlNatOperacao.Caption := '6 - Exigibilidade susp. por proced. adm.';

  noTributacaoNoMunicipio51         : qrlNatOperacao.Caption := '51- Imposto devido em São Leopoldo, com obrigação de retenção na fonte';     // alterado por Rafael Müller para o provedor thema
  noTributacaoNoMunicipioSemISS52   : qrlNatOperacao.Caption := '52 - Imposto devido em São Leopoldo, sem obrigação de retenção na fonte';
  noNaoTributa58                    : qrlNatOperacao.Caption := '58 - Não tributável';
  noSimplesNacional59               : qrlNatOperacao.Caption := '59 - Imposto recolhido pelo regime único de arrecadação Simples Nacional';
  noTributacaoNoMunicipio61         : qrlNatOperacao.Caption := '61 - Imposto devido em São Leopoldo, com obrigação de retenção na fonte';
  noTributacaoNoMunicipioSemISS62   : qrlNatOperacao.Caption := '62 - Imposto devido em São Leopoldo, sem obrigação de retenção na fonte';
  noTributacaoForaMunicipio63       : qrlNatOperacao.Caption := '63 - Imposto devido fora de São Leopoldo, com obrigação de retenção na fonte';
  noTributacaoForaMunicipioSemISS64 : qrlNatOperacao.Caption := '64 - Imposto devido fora de São Leopoldo, sem obrigação de retenção na fonte';
  noNaoTributa68                    : qrlNatOperacao.Caption := '68 - Não tributável';
  noSimplesNacional69               : qrlNatOperacao.Caption := '69 - Imposto recolhido pelo regime único de arrecadação Simples Nacional';
  noNaoTributa78                    : qrlNatOperacao.Caption := '78 - Não tributável';
 end;

 // TnfseRegimeEspecialTributacao = ( retNenhum, retMicroempresaMunicipal, retEstimativa, retSociedadeProfissionais, retCooperativa, retMicroempresarioIndividual, retMicroempresarioEmpresaPP )
 case FNFSe.RegimeEspecialTributacao of
  retNenhum                    : qrlRegimeEspecial.Caption := '0 - Nenhum';
  retMicroempresaMunicipal     : qrlRegimeEspecial.Caption := '1 - Microempresa municipal';
  retEstimativa                : qrlRegimeEspecial.Caption := '2 - Estimativa';
  retSociedadeProfissionais    : qrlRegimeEspecial.Caption := '3 - Sociendade de profissionais';
  retCooperativa               : qrlRegimeEspecial.Caption := '4 - Cooperativa';
  retMicroempresarioIndividual : qrlRegimeEspecial.Caption := '5 - Microempresário Individual (MEI)';
  retMicroempresarioEmpresaPP  : qrlRegimeEspecial.Caption := '6 - Microempresário e Empresa de Pequeno Porte (ME EPP)';
 end;

 // TnfseSimNao = ( snSim, snNao )
 case FNFSe.OptanteSimplesNacional of
  snSim : qrlOpcaoSimples.Caption := 'Sim';
  snNao : qrlOpcaoSimples.Caption := 'Não';
 end;

 // TnfseSimNao = ( snSim, snNao )
 case FNFSe.IncentivadorCultural of
  snSim : qrlIncentivador.Caption := 'Sim';
  snNao : qrlIncentivador.Caption := 'Não';
 end;

 qrlValorServicos2.Caption      := DFeUtil.FormatFloat( FNFSe.Servico.Valores.ValorServicos );
 qrlValorDeducoes.Caption       := DFeUtil.FormatFloat( FNFSe.Servico.Valores.ValorDeducoes );
 qrlDescIncondicionado2.Caption := DFeUtil.FormatFloat( FNFSe.Servico.Valores.DescontoIncondicionado );
 qrlBaseCalc.Caption            := DFeUtil.FormatFloat( FNFSe.Servico.Valores.BaseCalculo );

 // Alterado por Italo em 16/01/2013
 if FNFSe.Servico.Valores.Aliquota >= 1.00
  then qrlAliquota.Caption := DFeUtil.FormatFloat( FNFSe.Servico.Valores.Aliquota )
  else qrlAliquota.Caption := DFeUtil.FormatFloat( FNFSe.Servico.Valores.Aliquota * 100 );

 // TnfseSimNao = ( snSim, snNao )
 case FNFSe.Servico.Valores.IssRetido of
  stRetencao     : qrlISSReter.Caption := 'Sim';
  stNormal       : qrlISSReter.Caption := 'Não';
  stSubstituicao : qrlISSReter.Caption := 'ST';
 end;
 qrlValorISS.Caption := DFeUtil.FormatFloat( FNFSe.Servico.Valores.ValorIss );

// qrlValorCredito.Caption := DFeUtil.FormatFloat( FNFSe.ValorCredito );

end;

procedure TfqrDANFSeQRRetrato.qrb_7_OutrasInformacoesBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  inherited;

 qrmDadosAdicionais.Lines.BeginUpdate;
 qrmDadosAdicionais.Lines.Clear;

 qrmDadosAdicionais.Lines.Add(StringReplace( FNFSe.OutrasInformacoes,
                         ';', #13#10, [rfReplaceAll,rfIgnoreCase] ) );

 qrmDadosAdicionais.Lines.EndUpdate;

 // imprime data e hora da impressao
 QrlDataHoraImpressao.Caption := 'DATA E HORA DA IMPRESSÃO: ' + FormatDateTime('dd/mm/yyyy hh:nn',Now);

 // imprime usuario
 if FUsuario <> ''
  then begin
   QrlDataHoraImpressao.Caption := QrlDataHoraImpressao.Caption + '   USUÁRIO: ' + FUsuario;
  end;

 // imprime sistema
 if FSistema <> ''
  then begin
   qrlSistema.Caption := 'Desenvolvido por ' + FSistema;
  end
  else begin
   qrlSistema.Caption := '';
  end;

end;

procedure TfqrDANFSeQRRetrato.QRNFSeBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
begin
  inherited;

 Itens;

 QRNFSe.ReportTitle := 'NFS-e: ' + FNFSe.Numero;

 QRNFSe.Page.TopMargin    := FMargemSuperior * 100;
 QRNFSe.Page.BottomMargin := FMargemInferior * 100;
 QRNFSe.Page.LeftMargin   := FMargemEsquerda * 100;
 QRNFSe.Page.RightMargin  := FMargemDireita  * 100;

end;

end.
