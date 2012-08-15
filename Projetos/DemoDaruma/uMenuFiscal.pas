unit uMenuFiscal;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uBasicoModal, StdCtrls, ExtCtrls, Spin, ComCtrls;

type
  TfrmMenuFiscal = class(TfrmBasicoModal)
    grpMenuFiscalOpcoes: TGroupBox;
    Label31: TLabel;
    btnMenuFiscalLX: TButton;
    btnMenuFiscalLMFC: TButton;
    btnMenuFiscalLMFS: TButton;
    btnMenuFiscalMFDEspelho: TButton;
    btnMenuFiscalMFDArq: TButton;
    btnMenuFiscalRelMeiosPagto: TButton;
    btnMenuFiscalRelDAVEmitidos: TButton;
    btnMenuFiscalRelIdentPAFECF: TButton;
    pgcMenuFiscalTipo: TPageControl;
    tbsMenuFiscalTipoData: TTabSheet;
    Label24: TLabel;
    Label25: TLabel;
    edtDtInicial: TDateTimePicker;
    edtDtFinal: TDateTimePicker;
    tbsMenuFiscalTipoCOO: TTabSheet;
    Label26: TLabel;
    Label30: TLabel;
    edtNumInicial: TSpinEdit;
    edtNumFinal: TSpinEdit;
    chkMenuFiscalGerarArquivo: TCheckBox;
    chkMenuFiscalCotepe1704: TCheckBox;
    dlgDialogoSalvar: TSaveDialog;
    btnParametrosConfiguracao: TButton;
    procedure btnMenuFiscalLXClick(Sender: TObject);
    procedure btnMenuFiscalLMFCClick(Sender: TObject);
    procedure btnMenuFiscalLMFSClick(Sender: TObject);
    procedure btnMenuFiscalMFDEspelhoClick(Sender: TObject);
    procedure btnMenuFiscalMFDArqClick(Sender: TObject);
    procedure btnMenuFiscalRelMeiosPagtoClick(Sender: TObject);
    procedure btnMenuFiscalRelDAVEmitidosClick(Sender: TObject);
    procedure btnMenuFiscalRelIdentPAFECFClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnParametrosConfiguracaoClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmMenuFiscal: TfrmMenuFiscal;

implementation

uses
  uPrincipal, Math, StrUtils, ACBrECFClass, ACBrPAFClass;

{$R *.dfm}

procedure TfrmMenuFiscal.FormCreate(Sender: TObject);
begin
  inherited;

  pgcMenuFiscalTipo.ActivePageIndex := 0;
  edtDtInicial.Date := DATE;
  edtDtFinal.Date := DATE;
  edtNumInicial.Value := 1;
  edtNumFinal.Value := 10;
end;

procedure TfrmMenuFiscal.btnMenuFiscalLMFCClick(Sender: TObject);
var
  PathArquivo: string;
begin
  if chkMenuFiscalGerarArquivo.Checked then
  begin
    if dlgDialogoSalvar.Execute then
    begin
      PathArquivo := dlgDialogoSalvar.FileName;

      if chkMenuFiscalCotepe1704.Checked then
      begin
        if pgcMenuFiscalTipo.ActivePageIndex = 0 then
          frmPrincipal.ACBrECF1.PafMF_LMFC_Cotepe1704(edtDtInicial.Date, edtDtFinal.Date, PathArquivo)
        else
          frmPrincipal.ACBrECF1.PafMF_LMFC_Cotepe1704(edtNumInicial.Value, edtNumFinal.Value, PathArquivo);
      end
      else
      begin
        if pgcMenuFiscalTipo.ActivePageIndex = 0 then
          frmPrincipal.ACBrECF1.PafMF_LMFC_Espelho(edtDtInicial.Date, edtDtFinal.Date, PathArquivo)
        else
          frmPrincipal.ACBrECF1.PafMF_LMFC_Espelho(edtNumInicial.Value, edtNumFinal.Value, PathArquivo);
      end;

      ShowMessage(Format('Arquivo gerado com sucesso em:' + sLineBreak + ' "%s"', [PathArquivo]));
    end;
  end
  else
  begin
    if pgcMenuFiscalTipo.ActivePageIndex = 0 then
      frmPrincipal.ACBrECF1.PafMF_LMFC_Impressao(edtDtInicial.Date, edtDtFinal.Date)
    else
      frmPrincipal.ACBrECF1.PafMF_LMFC_Impressao(edtNumInicial.Value, edtNumFinal.Value);
  end;
end;

procedure TfrmMenuFiscal.btnMenuFiscalLMFSClick(Sender: TObject);
var
  PathArquivo: string;
begin
  if chkMenuFiscalGerarArquivo.Checked then
  begin
    if dlgDialogoSalvar.Execute then
    begin
      PathArquivo := dlgDialogoSalvar.FileName;
      if pgcMenuFiscalTipo.ActivePageIndex = 0 then
        frmPrincipal.ACBrECF1.PafMF_LMFS_Espelho(edtDtInicial.Date, edtDtFinal.Date, PathArquivo)
      else
        frmPrincipal.ACBrECF1.PafMF_LMFS_Espelho(edtNumInicial.Value, edtNumFinal.Value, PathArquivo);

      ShowMessage(Format('Arquivo gerado com sucesso em:' + sLineBreak + ' "%s"', [PathArquivo]));
    end;
  end
  else
  begin
    if pgcMenuFiscalTipo.ActivePageIndex = 0 then
      frmPrincipal.ACBrECF1.PafMF_LMFS_Impressao(edtDtInicial.Date, edtDtFinal.Date)
    else
      frmPrincipal.ACBrECF1.PafMF_LMFS_Impressao(edtNumInicial.Value, edtNumFinal.Value);
  end;
end;

procedure TfrmMenuFiscal.btnMenuFiscalLXClick(Sender: TObject);
begin
  frmPrincipal.ACBrECF1.PafMF_LX_Impressao;
end;

procedure TfrmMenuFiscal.btnMenuFiscalMFDArqClick(Sender: TObject);
var
  PathArquivo: string;
begin
  if dlgDialogoSalvar.Execute then
  begin
    PathArquivo := dlgDialogoSalvar.FileName;

    if pgcMenuFiscalTipo.ActivePageIndex = 0 then
      frmPrincipal.ACBrECF1.PafMF_MFD_Cotepe1704(edtDtInicial.Date, edtDtFinal.Date, PathArquivo)
    else
      frmPrincipal.ACBrECF1.PafMF_MFD_Cotepe1704(edtNumInicial.Value, edtNumFinal.Value, PathArquivo);

    ShowMessage(Format('Arquivo gerado com sucesso em:' + sLineBreak + ' "%s"', [PathArquivo]));
  end;
end;

procedure TfrmMenuFiscal.btnMenuFiscalMFDEspelhoClick(Sender: TObject);
var
  PathArquivo: string;
begin
  if dlgDialogoSalvar.Execute then
  begin
    PathArquivo := dlgDialogoSalvar.FileName;

    if pgcMenuFiscalTipo.ActivePageIndex = 0 then
      frmPrincipal.ACBrECF1.PafMF_MFD_Espelho(edtDtInicial.Date, edtDtFinal.Date, PathArquivo)
    else
      frmPrincipal.ACBrECF1.PafMF_MFD_Espelho(edtNumInicial.Value, edtNumFinal.Value, PathArquivo);

    ShowMessage(Format('Arquivo gerado com sucesso em:' + sLineBreak + ' "%s"', [PathArquivo]));
  end;
end;

procedure TfrmMenuFiscal.btnMenuFiscalRelDAVEmitidosClick(Sender: TObject);
var
  DAVs: TACBrECFDAVs;
  I: Integer;
const
  TipoDAV: array[0..1] of string = ('PEDIDO', 'ORCAMENTO');
  Valores: array[0..3] of Double = (1.00, 2.00, 3.50, 10.45);
  Datas:   array[0..4] of string = ('30/12/2000', '01/01/2011', '25/02/2010', '04/02/2011', '13/04/2011');
begin
  DAVs := TACBrECFDAVs.Create;
  try
    for I := 1 to 25 do
    begin
      with DAVs.New do
      begin
        Numero    := Format('%13.13d', [I]);
        COO_Dav   := RandomRange(0, 999999);
        COO_Cupom := RandomRange(0, 999999);
        Titulo    := RandomFrom(TipoDAV);
        DtEmissao := StrToDate(RandomFrom(Datas));
        Valor     := RandomFrom(Valores)
      end;
    end;

    frmPrincipal.ACBrECF1.PafMF_RelDAVEmitidos(DAVs, 'REFERENCIA: 00/00/0000 A 00/00/0000', 0);
  finally
    DAVs.Free;
  end;
end;

procedure TfrmMenuFiscal.btnMenuFiscalRelIdentPAFECFClick(Sender: TObject);
var
  IdentPaf: TACBrECFIdentificacaoPAF;
  I: Integer;
begin
  // Se NAO está usando o AAC, o Objeto IdentPAF deve ser instânciado e populado //
  IdentPaf := TACBrECFIdentificacaoPAF.Create;
  try
    IdentPaf.NumeroLaudo := 'ABC1234567890'; // retirar do laudo
    IdentPaf.VersaoER    := '01.07'; // retirar do laudo

    // preencher dados da empresa conforme o que foi informado no laudo de análise
    IdentPaf.Empresa.RazaoSocial := 'Razao social Empresa';
    IdentPaf.Empresa.CNPJ        := '01.222.333/00001-99';
    IdentPaf.Empresa.Endereco    := 'Rua da Felicidade, 1';
    IdentPaf.Empresa.Cidade      := 'SAO PAULO';
    IdentPaf.Empresa.Uf          := 'SP';
    IdentPaf.Empresa.Cep         := '99.999-999';
    IdentPaf.Empresa.Telefone    := '(99)1111.2222';
    IdentPaf.Empresa.Contato     := 'Nome do Contato';

    IdentPaf.Paf.Nome              := 'DemoECF';// preencher conforme o laudo
    IdentPaf.Paf.Versao            := 'v01.01.01'; // versão atual do aplicativo
    IdentPaf.Paf.PrincipalExe.Nome := UpperCase(ExtractFileName(ParamStr(0)));
    IdentPaf.Paf.PrincipalExe.MD5  := StringOfChar('X', 32); // md5 atual do aplicativo

    IdentPaf.ArquivoListaAutenticados.Nome := 'lista_arquivos.txt'; // nome do arquivo contendo a lista de autenticados
    IdentPaf.ArquivoListaAutenticados.MD5  := 'AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA'; // md5 do arquivo, mesmo que vai impresso nos cupons

    // adicionar os arquivos adicionados ao arquivo da lista de autenticados
    for I := 1 to 5 do
    begin
      with IdentPaf.OutrosArquivos.New do
      begin
        Nome := Format('Arquivo %3.3d', [I]);
        MD5  := StringOfChar('X', 32);
      end;
    end;

    // ecfs autorizados para funcionamento na máquina
    IdentPaf.ECFsAutorizados.clear;
    for I := 1 to 3 do
    begin
      with IdentPaf.ECFsAutorizados.New do
      begin
        NumeroSerie := StringOfChar('A', 15) ;
      end;
    end;

    frmPrincipal.ACBrECF1.PafMF_RelIdentificacaoPafECF(IdentPaf, 0);
  finally
    IdentPaf.Free;
  end;
end;

procedure TfrmMenuFiscal.btnMenuFiscalRelMeiosPagtoClick(Sender: TObject);
var
  FormasPagamento: TACBrECFFormasPagamento;
  I: Integer;
const
  arrayDescrTipo: array[0..3] of string = ('Nota Consumidor', 'Nota Fiscal', 'Cupom Não Fiscal', 'Cupom Fiscal');
  arrayDescrFormaPagto: array[0..3] of string = ('Dinheiro', 'Cheque', 'Cartão', 'Ticket');
  arrayDataLancamento: array[0..4] of String = ('01/01/2010', '31/12/2010', '04/05/2011', '02/01/2010', '03/05/2011');
  arrayValores: array[0..4] of Double = (10.56, 14.23, 0.00, 12.00, 1.20);
begin
  FormasPagamento := TACBrECFFormasPagamento.Create;
  try
    for I := 1 to 25 do
    begin
      with FormasPagamento.New do
      begin
        Descricao := RandomFrom(arrayDescrFormaPagto);
        TipoDoc   := RandomFrom(arrayDescrTipo);
        Data      := StrToDate(RandomFrom(arrayDataLancamento));
        Total     := RandomFrom(arrayValores);
      end;
    end;

    frmPrincipal.ACBrECF1.PafMF_RelMeiosPagamento(
      FormasPagamento,
      'PERIODO DE 01/01/2000 A 31/12/2000',
      0
    );
  finally
    FormasPagamento.Free;
  end;
end;

procedure TfrmMenuFiscal.btnParametrosConfiguracaoClick(Sender: TObject);
var
  Parametros: TACBrECFInfoPaf;
begin
  Parametros := TACBrECFInfoPaf.Create;
  try
    Parametros.TipoFuncionamento        := tpfEmRede;
    Parametros.TipoDesenvolvimento      := tpdExclusivoTerceirizado;
    Parametros.IntegracaoPAFECF         := tpiRetaguarda;
    Parametros.RealizaPreVenda          := True;
    Parametros.RealizaDAVECF            := True;
    Parametros.RealizaDAVNaoFiscal      := True;
    Parametros.RealizaDAVOS             := True;
    Parametros.IndiceTecnicoProd        := False;
    Parametros.BarSimilarECFRestaurante := True;
    Parametros.BarSimilarECFComum       := False;
    Parametros.TransportePassageiro     := True;
    Parametros.TotalizaValoresLista     := False;
    Parametros.TransfPreVenda           := True;
    Parametros.TransfDAV                := True;
    Parametros.RecompoeGT               := True;
    Parametros.ImpedeVendaVlrZero       := False;

    frmPrincipal.ACBrECF1.PafMF_RelParametrosConfiguracao(Parametros);
  finally
    Parametros.Free;
  end;
end;

end.
