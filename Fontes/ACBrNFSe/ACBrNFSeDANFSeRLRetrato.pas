{$I ACBr.inc}

unit ACBrNFSeDANFSeRLRetrato;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, ACBrNFSeDANFSeRL, RLFilters, RLPDFFilter, RLReport, DB, DBClient,
  pnfsConversao, ACBrNFSeDANFSEClass, ACBrNFSeDANFSeRLClass;

type
  TfrlDANFSeRLRetrato = class(TfrlDANFSeRL)
    cdsItens: TClientDataSet;
    cdsItensDISCRIMINACAO: TStringField;
    rlbCabecalho: TRLBand;
    rllNumNF0: TRLLabel;
    RLLabel13: TRLLabel;
    RLLabel12: TRLLabel;
    rliLogo: TRLImage;
    rllEmissao: TRLLabel;
    RLLabel8: TRLLabel;
    rllCodVerificacao: TRLLabel;
    RLLabel7: TRLLabel;
    rllCompetencia: TRLLabel;
    RLLabel18: TRLLabel;
    rllNumeroRps: TRLLabel;
    RLLabel20: TRLLabel;
    rllNumNFSeSubstituida: TRLLabel;
    rlmPrefeitura: TRLMemo;
    rlbPrestador: TRLBand;
    RLLabel29: TRLLabel;
    RLLabel30: TRLLabel;
    RLLabel31: TRLLabel;
    RLLabel32: TRLLabel;
    rllPrestMunicipio: TRLLabel;
    rllPrestInscMunicipal: TRLLabel;
    rllPrestEndereco: TRLLabel;
    rllPrestCNPJ: TRLLabel;
    rliPrestLogo: TRLImage;
    RLLabel2: TRLLabel;
    RLLabel1: TRLLabel;
    rllPrestNome: TRLLabel;
    RLLabel9: TRLLabel;
    rllPrestUF: TRLLabel;
    RLLabel22: TRLLabel;
    rllPrestComplemento: TRLLabel;
    RLLabel23: TRLLabel;
    rllPrestTelefone: TRLLabel;
    RLLabel24: TRLLabel;
    rllPrestEmail: TRLLabel;
    rlbTomador: TRLBand;
    RLLabel4: TRLLabel;
    RLLabel5: TRLLabel;
    rllTomaCNPJ: TRLLabel;
    RLLabel11: TRLLabel;
    rllTomaInscMunicipal: TRLLabel;
    RLLabel15: TRLLabel;
    rllTomaNome: TRLLabel;
    RLLabel17: TRLLabel;
    rllTomaEndereco: TRLLabel;
    RLLabel19: TRLLabel;
    rllTomaMunicipio: TRLLabel;
    RLLabel21: TRLLabel;
    rllTomaUF: TRLLabel;
    RLLabel10: TRLLabel;
    rllTomaEmail: TRLLabel;
    RLLabel25: TRLLabel;
    rllTomaComplemento: TRLLabel;
    RLLabel27: TRLLabel;
    rllTomaTelefone: TRLLabel;
    rlbHeaderItens: TRLBand;
    RLLabel14: TRLLabel;
    rlbItens: TRLBand;
    rlmDescricao: TRLMemo;
    rlbISSQN: TRLBand;
    RLDraw52: TRLDraw;
    RLDraw53: TRLDraw;
    RLDraw54: TRLDraw;
    RLDraw55: TRLDraw;
    RLLabel137: TRLLabel;
    RLLabel138: TRLLabel;
    RLLabel139: TRLLabel;
    rllBaseCalc: TRLLabel;
    rllValorISS: TRLLabel;
    RLDraw4: TRLDraw;
    rllValorTotal: TRLLabel;
    RLLabel16: TRLLabel;
    rlmCodServico: TRLMemo;
    RLLabel3: TRLLabel;
    rllAliquota: TRLLabel;
    RLDraw6: TRLDraw;
    rlsLinhaH1: TRLDraw;
    rllCodigoObra: TRLLabel;
    rllCodObra: TRLLabel;
    rllTituloConstCivil: TRLLabel;
    rllCodigoArt: TRLLabel;
    rllCodART: TRLLabel;
    RLLabel34: TRLLabel;
    rllValorPIS: TRLLabel;
    RLLabel36: TRLLabel;
    rllValorCOFINS: TRLLabel;
    RLLabel38: TRLLabel;
    rllValorIR: TRLLabel;
    RLLabel40: TRLLabel;
    rllValorINSS: TRLLabel;
    RLLabel42: TRLLabel;
    rllValorCSLL: TRLLabel;
    RLLabel44: TRLLabel;
    RLDraw13: TRLDraw;
    RLDraw14: TRLDraw;
    RLLabel35: TRLLabel;
    RLLabel37: TRLLabel;
    RLLabel39: TRLLabel;
    RLLabel41: TRLLabel;
    RLLabel43: TRLLabel;
    RLLabel45: TRLLabel;
    RLLabel46: TRLLabel;
    RLLabel47: TRLLabel;
    RLLabel48: TRLLabel;
    RLLabel49: TRLLabel;
    RLLabel50: TRLLabel;
    RLLabel51: TRLLabel;
    RLLabel52: TRLLabel;
    RLLabel53: TRLLabel;
    RLLabel54: TRLLabel;
    RLLabel55: TRLLabel;
    RLLabel56: TRLLabel;
    RLDraw15: TRLDraw;
    RLDraw16: TRLDraw;
    rllValorServicos1: TRLLabel;
    rllValorServicos2: TRLLabel;
    rllDescIncondicionado1: TRLLabel;
    rllDescIncondicionado2: TRLLabel;
    rllDescCondicionado: TRLLabel;
    rllRetencoesFederais: TRLLabel;
    rllOutrasRetencoes: TRLLabel;
    rllValorIssRetido: TRLLabel;
    rllValorLiquido: TRLLabel;
    RLDraw17: TRLDraw;
    rllIncentivador: TRLLabel;
    rllNatOperacao: TRLLabel;
    rllValorDeducoes: TRLLabel;
    rllRegimeEspecial: TRLLabel;
    rllOpcaoSimples: TRLLabel;
    rllISSReter: TRLLabel;
    rllMsgTeste: TRLLabel;
    rbOutrasInformacoes: TRLBand;
    rlmDadosAdicionais: TRLMemo;
    rllDataHoraImpressao: TRLLabel;
    rllSistema: TRLLabel;
    RLLabel6: TRLLabel;
    dsItens: TDataSource;
    procedure rlbCabecalhoBeforePrint(Sender: TObject; var PrintIt: Boolean);
    procedure rlbPrestadorBeforePrint(Sender: TObject; var PrintIt: Boolean);
    procedure rlbTomadorBeforePrint(Sender: TObject; var PrintIt: Boolean);
    procedure rlbItensBeforePrint(Sender: TObject; var PrintIt: Boolean);
    procedure rlbISSQNBeforePrint(Sender: TObject; var PrintIt: Boolean);
    procedure rbOutrasInformacoesBeforePrint(Sender: TObject;
      var PrintIt: Boolean);
    procedure RLNFSeBeforePrint(Sender: TObject; var PrintIt: Boolean);
  private
    { Private declarations }
    procedure Itens;
  public
    { Public declarations }
  end;

var
  frlDANFSeRLRetrato: TfrlDANFSeRLRetrato;

implementation

uses
 StrUtils, DateUtils, ACBrUtil, pnfsNFSe, ACBrNFSeUtil, ACBrDFeUtil; //Astrogildo em 13/12/12

{$R *.dfm}

{ TfrlDANFSeRLRetrato }

procedure TfrlDANFSeRLRetrato.Itens;
begin
 cdsItens.Close;
 cdsItens.CreateDataSet;
 cdsItens.Open;

 cdsItens.Append;
 cdsItens.FieldByName('DISCRIMINACAO').AsString := FNFSe.Servico.Discriminacao;
 cdsItens.Post;

 cdsItens.First;
end;

procedure TfrlDANFSeRLRetrato.rbOutrasInformacoesBeforePrint(Sender: TObject;
  var PrintIt: Boolean);
begin
  inherited;
 rlmDadosAdicionais.Lines.BeginUpdate;
 rlmDadosAdicionais.Lines.Clear;

 rlmDadosAdicionais.Lines.Add(StringReplace( FNFSe.OutrasInformacoes,
                         ';', #13#10, [rfReplaceAll,rfIgnoreCase] ) );

 rlmDadosAdicionais.Lines.EndUpdate;

 // imprime data e hora da impressao
 rllDataHoraImpressao.Caption := 'DATA E HORA DA IMPRESSÃO: ' + FormatDateTime('dd/mm/yyyy hh:nn',Now);

 // imprime usuario
 if FUsuario <> ''
  then begin
   rllDataHoraImpressao.Caption := rllDataHoraImpressao.Caption + '   USUÁRIO: ' + FUsuario;
  end;

 // imprime sistema
 if FSistema <> ''
  then begin
   rllSistema.Caption := 'Desenvolvido por ' + FSistema;
  end
  else begin
   rllSistema.Caption := '';
  end;


end;

procedure TfrlDANFSeRLRetrato.rlbCabecalhoBeforePrint(Sender: TObject;
  var PrintIt: Boolean);
var
 t: integer;
begin
  inherited;

 if (FLogo <> '') and FilesExists(FLogo)
  then begin
   rliLogo.Picture.LoadFromFile(FLogo);
  end;

 rlmPrefeitura.Lines.Clear;

 rlmPrefeitura.Lines.Add(StringReplace( FPrefeitura,
                         ';', #13#10, [rfReplaceAll,rfIgnoreCase] ) );

 rllNumNF0.Caption  := {FormatDateTime('yyyy', FNFSe.DataEmissao)+}
                       FormatFloat('00000000000', StrToFloat(FNFSe.Numero));
 rllEmissao.Caption := DFeUtil.FormatDateTime(DateTimeToStr(FNFSe.DataEmissao));  //Astrogildo em 13/12/12
 rllCodVerificacao.Caption := FNFSe.CodigoVerificacao;
 t:=length(FNFSe.Competencia);
 if t=6
  then rllCompetencia.Caption := Copy(FNFSe.Competencia, 5, 2) + '/' + Copy(FNFSe.Competencia, 1, 4)
  else rllCompetencia.Caption := Copy(FNFSe.Competencia, 6, 2) + '/' + Copy(FNFSe.Competencia, 1, 4);
 rllNumeroRPS.Caption := FNFSe.IdentificacaoRps.Numero;
 rllNumNFSeSubstituida.Caption := FNFSe.NfseSubstituida;
end;

procedure TfrlDANFSeRLRetrato.rlbISSQNBeforePrint(Sender: TObject;
  var PrintIt: Boolean);
var
 MostrarObra: Boolean;
begin
  inherited;

// rllValorTotal.Caption := 'VALOR TOTAL DA NOTA = R$ '+
//    NotaUtil.FormatFloat( FNFSe.Servico.Valores.ValorLiquidoNfse );

 rllValorTotal.Caption := 'VALOR TOTAL DA NOTA = R$ '+
    DFeUtil.FormatFloat( FNFSe.Servico.Valores.ValorServicos ); //Astrogildo em 13/12/12

 rlmCodServico.Lines.Clear;
 rlmCodServico.Lines.Append(FNFSe.Servico.ItemListaServico + ' - '+
                            FNFSe.Servico.xItemListaServico);

 rllCodObra.Caption := FNFSe.ConstrucaoCivil.CodigoObra;
 rllCodART.Caption  := FNFSe.ConstrucaoCivil.Art;

 MostrarObra := (rllCodObra.Caption<>'') or (rllCodART.Caption<>'');
 rlsLinhaH1.Enabled:=MostrarObra;
 rllTituloConstCivil.Enabled:=MostrarObra;
 rllCodigoObra.Enabled:=MostrarObra;
 rllCodObra.Enabled:=MostrarObra;
 rllCodigoArt.Enabled:=MostrarObra;
 rllCodART.Enabled:=MostrarObra;

 rllValorPIS.Caption    := DFeUtil.FormatFloat( FNFSe.Servico.Valores.ValorPis );//Astrogildo em 13/12/12
 rllValorCOFINS.Caption := DFeUtil.FormatFloat( FNFSe.Servico.Valores.ValorCofins );//Astrogildo em 13/12/12
 rllValorIR.Caption     := DFeUtil.FormatFloat( FNFSe.Servico.Valores.ValorIr );//Astrogildo em 13/12/12
 rllValorINSS.Caption   := DFeUtil.FormatFloat( FNFSe.Servico.Valores.ValorInss );//Astrogildo em 13/12/12
 rllValorCSLL.Caption   := DFeUtil.FormatFloat( FNFSe.Servico.Valores.ValorCsll );//Astrogildo em 13/12/12

 rllValorServicos1.Caption      := DFeUtil.FormatFloat( FNFSe.Servico.Valores.ValorServicos );//Astrogildo em 13/12/12
 rllDescIncondicionado1.Caption := DFeUtil.FormatFloat( FNFSe.Servico.Valores.DescontoIncondicionado );//Astrogildo em 13/12/12
 rllDescCondicionado.Caption    := DFeUtil.FormatFloat( FNFSe.Servico.Valores.DescontoCondicionado );//Astrogildo em 13/12/12
 rllRetencoesFederais.Caption   := DFeUtil.FormatFloat( FNFSe.Servico.Valores.ValorPis +//Astrogildo em 13/12/12
                                     FNFSe.Servico.Valores.ValorCofins + FNFSe.Servico.Valores.ValorInss +
                                     FNFSe.Servico.Valores.ValorIr + FNFSe.Servico.Valores.ValorCsll );
 rllOutrasRetencoes.Caption     := DFeUtil.FormatFloat( FNFSe.Servico.Valores.OutrasRetencoes );//Astrogildo em 13/12/12
 rllValorIssRetido.Caption      := DFeUtil.FormatFloat( FNFSe.Servico.Valores.ValorIssRetido );//Astrogildo em 13/12/12

 rllValorLiquido.Caption := DFeUtil.FormatFloat( FNFSe.Servico.Valores.ValorLiquidoNfse );//Astrogildo em 13/12/12

 // TnfseNaturezaOperacao = ( noTributacaoNoMunicipio, noTributacaoForaMunicipio, noIsencao, noImune, noSuspensaDecisaoJudicial, noSuspensaProcedimentoAdministrativo )
 case FNFSe.NaturezaOperacao of
  noTributacaoNoMunicipio   : rllNatOperacao.Caption := '1 - Tributação no município';
  noTributacaoForaMunicipio : rllNatOperacao.Caption := '2 - Tributação fora do município';
  noIsencao                 : rllNatOperacao.Caption := '3 - Isenção';
  noImune                   : rllNatOperacao.Caption := '4 - Imune';
  noSuspensaDecisaoJudicial : rllNatOperacao.Caption := '5 - Exigibilidade susp. por decisão judicial';
  noSuspensaProcedimentoAdministrativo : rllNatOperacao.Caption := '6 - Exigibilidade susp. por proced. adm.';
 end;

 // TnfseRegimeEspecialTributacao = ( retNenhum, retMicroempresaMunicipal, retEstimativa, retSociedadeProfissionais, retCooperativa, retMicroempresarioIndividual, retMicroempresarioEmpresaPP )
 case FNFSe.RegimeEspecialTributacao of
  retNenhum                    : rllRegimeEspecial.Caption := '0 - Nenhum';
  retMicroempresaMunicipal     : rllRegimeEspecial.Caption := '1 - Microempresa municipal';
  retEstimativa                : rllRegimeEspecial.Caption := '2 - Estimativa';
  retSociedadeProfissionais    : rllRegimeEspecial.Caption := '3 - Sociendade de profissionais';
  retCooperativa               : rllRegimeEspecial.Caption := '4 - Cooperativa';
  retMicroempresarioIndividual : rllRegimeEspecial.Caption := '5 - Microempresário Individual (MEI)';
  retMicroempresarioEmpresaPP  : rllRegimeEspecial.Caption := '6 - Microempresário e Empresa de Pequeno Porte (ME EPP)';
 end;

 // TnfseSimNao = ( snSim, snNao )
 case FNFSe.OptanteSimplesNacional of
  snSim : rllOpcaoSimples.Caption := 'Sim';
  snNao : rllOpcaoSimples.Caption := 'Não';
 end;

 // TnfseSimNao = ( snSim, snNao )
 case FNFSe.IncentivadorCultural of
  snSim : rllIncentivador.Caption := 'Sim';
  snNao : rllIncentivador.Caption := 'Não';
 end;

 rllValorServicos2.Caption      := DFeUtil.FormatFloat( FNFSe.Servico.Valores.ValorServicos );//Astrogildo em 13/12/12
 rllValorDeducoes.Caption       := DFeUtil.FormatFloat( FNFSe.Servico.Valores.ValorDeducoes );//Astrogildo em 13/12/12
 rllDescIncondicionado2.Caption := DFeUtil.FormatFloat( FNFSe.Servico.Valores.DescontoIncondicionado );//Astrogildo em 13/12/12
 rllBaseCalc.Caption            := DFeUtil.FormatFloat( FNFSe.Servico.Valores.BaseCalculo );//Astrogildo em 13/12/12
 rllAliquota.Caption            := DFeUtil.FormatFloat( FNFSe.Servico.Valores.Aliquota );//Astrogildo em 13/12/12
 // TnfseSimNao = ( snSim, snNao )
 case FNFSe.Servico.Valores.IssRetido of
  stRetencao     : rllISSReter.Caption := 'Sim';//Astrogildo em 13/12/12
  stNormal       : rllISSReter.Caption := 'Não';//Astrogildo em 13/12/12
  stSubstituicao : rllISSReter.Caption := 'ST';//Astrogildo em 13/12/12
 end;
 rllValorISS.Caption := DFeUtil.FormatFloat( FNFSe.Servico.Valores.ValorIss );

// rllValorCredito.Caption := NotaUtil.FormatFloat( FNFSe.ValorCredito );

end;

procedure TfrlDANFSeRLRetrato.rlbItensBeforePrint(Sender: TObject;
  var PrintIt: Boolean);
begin
  inherited;

 rlmDescricao.Lines.Clear;

 rlmDescricao.Lines.Add( StringReplace( FNFSe.Servico.Discriminacao,
                         ';', #13#10, [rfReplaceAll, rfIgnoreCase] ) );

end;

procedure TfrlDANFSeRLRetrato.rlbPrestadorBeforePrint(Sender: TObject;
  var PrintIt: Boolean);
begin
  inherited;
 if (FPrestLogo <> '') and FilesExists(FPrestLogo)
  then begin
   rliPrestLogo.Picture.LoadFromFile(FPrestLogo);
  end;

 rllPrestCNPJ.Caption := DFeUtil.FormatarCNPJ( FNFSe.PrestadorServico.IdentificacaoPrestador.Cnpj );//Astrogildo em 13/12/12
 rllPrestInscMunicipal.Caption := FNFSe.PrestadorServico.IdentificacaoPrestador.InscricaoMunicipal;
 rllPrestNome.Caption := FNFSe.PrestadorServico.RazaoSocial;
 rllPrestEndereco.Caption := Trim( FNFSe.PrestadorServico.Endereco.Endereco )+', '+
                             Trim( FNFSe.PrestadorServico.Endereco.Numero )+' - '+
                             Trim( FNFSe.PrestadorServico.Endereco.Bairro )+
                             ' - CEP: '+
                             DFeUtil.FormatarCEP( DFeUtil.Poem_Zeros( FNFSe.PrestadorServico.Endereco.CEP, 8 ) );//Astrogildo em 13/12/12
 rllPrestComplemento.Caption := FNFSe.PrestadorServico.Endereco.Complemento;
 rllPrestTelefone.Caption := DFeUtil.FormatarFone( FNFSe.PrestadorServico.Contato.Telefone );//Astrogildo em 13/12/12
 rllPrestMunicipio.Caption := FNFSe.PrestadorServico.Endereco.CodigoMunicipio +
  ' - ' + FNFSe.PrestadorServico.Endereco.xMunicipio;
 rllPrestUF.Caption := FNFSe.PrestadorServico.Endereco.UF;
 rllPrestEmail.Caption := FNFSe.PrestadorServico.Contato.Email;

end;

procedure TfrlDANFSeRLRetrato.rlbTomadorBeforePrint(Sender: TObject;
  var PrintIt: Boolean);
begin
  inherited;

 if Length(FNFSe.Tomador.IdentificacaoTomador.CpfCnpj)<=11
  then rllTomaCNPJ.Caption := DFeUtil.FormatarCPF( FNFSe.Tomador.IdentificacaoTomador.CpfCnpj ) //Astrogildo em 13/12/12
  else rllTomaCNPJ.Caption := DFeUtil.FormatarCNPJ( FNFSe.Tomador.IdentificacaoTomador.CpfCnpj );//Astrogildo em 13/12/12

 rllTomaInscMunicipal.Caption := FNFSe.Tomador.IdentificacaoTomador.InscricaoMunicipal;
 rllTomaNome.Caption := FNFSe.Tomador.RazaoSocial;
 rllTomaEndereco.Caption := Trim( FNFSe.Tomador.Endereco.Endereco )+', '+
                            Trim( FNFSe.Tomador.Endereco.Numero )+' - '+
                            Trim( FNFSe.Tomador.Endereco.Bairro )+
                            ' - CEP: '+
                            DFeUtil.FormatarCEP( DFeUtil.Poem_Zeros( FNFSe.Tomador.Endereco.CEP, 8 ) );//Astrogildo em 13/12/12
 rllTomaComplemento.Caption := FNFSe.Tomador.Endereco.Complemento;
 rllTomaTelefone.Caption := DFeUtil.FormatarFone( FNFSe.Tomador.Contato.Telefone );//Astrogildo em 13/12/12
 rllTomaMunicipio.Caption := FNFSe.Tomador.Endereco.CodigoMunicipio +
  ' - ' + FNFSe.Tomador.Endereco.xMunicipio;
 rllTomaUF.Caption := FNFSe.Tomador.Endereco.UF;
 rllTomaEmail.Caption := FNFSe.Tomador.Contato.Email;

 // Mensagem para modo Homologacao.
 rllMsgTeste.Visible := False;
 rllMsgTeste.Enabled := False;
 if FNFSe.NfseCancelamento.DataHora<>0
  then begin
   rllMsgTeste.Caption  := 'NFS-e CANCELADA';
   rllMsgTeste.Visible  := True;
   rllMsgTeste.Enabled := True;
  end;
 rllMsgTeste.Repaint;
(*
 if FNFSe.Ide.tpAmb = taHomologacao
  then begin
   rllMsgTeste.Caption := 'AMBIENTE DE HOMOLOGAÇÃO - SEM VALOR FISCAL';
   rllMsgTeste.Enabled := True;
   rllMsgTeste.Visible := True;
  end
  else begin
   if FNFSe.procNFSe.cStat > 0
    then begin

     if FNFSe.procNFSe.cStat = 102
      then begin
       rllMsgTeste.Caption  := 'NFS-e DENEGADA';
       rllMsgTeste.Visible  := True;
       rllMsgTeste.Enabled := True;
      end;

     if not FNFSe.procNFSe.cStat in [101, 102, 100]
      then begin
       rllMsgTeste.Caption:=  FNFSe.procNFSe.xMotivo;
       rllMsgTeste.Visible := True;
       rllMsgTeste.Enabled := True;
      end;
    end
    else begin
     rllMsgTeste.Caption  := 'NF-E NÃO ENVIADA PARA SEFAZ';
     rllMsgTeste.Visible  := True;
     rllMsgTeste.Enabled  := True;
    end;
  end;

*)

end;

procedure TfrlDANFSeRLRetrato.RLNFSeBeforePrint(Sender: TObject;
  var PrintIt: Boolean);
begin
  inherited;
  Itens;

  RLNFSe.DataSource := dsItens;
  RLNFSe.Title := 'NFS-e: ' + FNFSe.Numero;

  RLNFSe.Margins.TopMargin    := FMargemSuperior * 10;
  RLNFSe.Margins.BottomMargin := FMargemInferior * 10;
  RLNFSe.Margins.LeftMargin   := FMargemEsquerda * 10;
  RLNFSe.Margins.RightMargin  := FMargemDireita * 10;

end;

end.
