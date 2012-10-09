unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ACBrNFSe, pnfsConversao, ExtCtrls;

type
  TForm1 = class(TForm)
    btnGerar: TButton;
    ACBrNFSe1: TACBrNFSe;
    btnValida: TButton;
    OpenDialog1: TOpenDialog;
    btnEnvia: TButton;
    rgPadrao: TRadioGroup;
    procedure btnGerarClick(Sender: TObject);
    procedure btnEnviaClick(Sender: TObject);
    procedure btnValidaClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses
 ServiceGinfesImpl1;

{$R *.dfm}

procedure TForm1.btnGerarClick(Sender: TObject);
var
 i: Integer;
begin
 ACBrNFSe1.Configuracoes.Geral.PathSalvar  := 'C:\Erp\XML\';
 ACBrNFSe1.Configuracoes.Geral.Salvar      := True;
 ACBrNFSe1.Configuracoes.Geral.PathSchemas := 'C:\ACBrNovo\Exemplos\ACBrNFSe\Delphi\Schemas';
 ACBrNFSe1.Configuracoes.Geral.NameSpace   := 'http://www.portalfiscal.inf.br/nfe';

 //TnfsePadraoLayout = ( plABRASF, plGINFES );
 case rgPadrao.ItemIndex of
  0: ACBrNFSe1.Configuracoes.WebServices.PadraoLayout:=plABRASF;
  1: ACBrNFSe1.Configuracoes.WebServices.PadraoLayout:=plGINFES;
 end;
 ACBrNFSe1.Configuracoes.Certificados.NumeroSerie:='58 c1 98 1d c0 86 e7 2c 44 51 f3 06 fe 93 11 1a';

 ACBrNFSe1.NotasFiscais.Clear;

 with ACBrNFSe1 do
  begin
   NotasFiscais.NumeroLote:='0001';
   for i:=1 to 2 do
    begin
     with NotasFiscais.Add.NFSe do
      begin
       IdentificacaoRps.Numero := FormatFloat('#########0', i);
       IdentificacaoRps.Serie  := 'UNICA';
       // TnfseTipoRPS = ( trRPS, trNFConjugada, trCupom );
       IdentificacaoRps.Tipo   := trRPS;

       DataEmissao := now;
       
       // TnfseNaturezaOperacao = ( noTributacaoNoMunicipio, noTributacaoForaMunicipio, noIsencao, noImune, noSuspensaDecisaoJudicial, noSuspensaProcedimentoAdministrativo );
       NaturezaOperacao := noTributacaoNoMunicipio;

       // TnfseRegimeEspecialTributacao = ( retNenhum, retMicroempresaMunicipal, retEstimativa, retSociedadeProfissionais, retCooperativa, retMicroempresarioIndividual, retMicroempresarioEmpresaPP );
       RegimeEspecialTributacao := retMicroempresarioIndividual;

       // TnfseSimNao = ( snSim, snNao );
       OptanteSimplesNacional := snSim;

       // TnfseSimNao = ( snSim, snNao );
       IncentivadorCultural := snSim;

       // TnfseStatusRPS = ( srNormal, srCancelado );
       Status := srNormal;

       RpsSubstituido.Numero := FormatFloat('#########0', i);
       RpsSubstituido.Serie  := 'UNICA';
       // TnfseTipoRPS = ( trRPS, trNFConjugada, trCupom );
       RpsSubstituido.Tipo   := trRPS;

       Servico.Valores.ValorServicos          := 50.458;
       Servico.Valores.ValorDeducoes          := 50.1;
       Servico.Valores.ValorPis               := 10;
       Servico.Valores.ValorCofins            := 10;
       Servico.Valores.ValorInss              := 10;
       Servico.Valores.ValorIr                := 10;
       Servico.Valores.ValorCsll              := 10;
       // TnfseSimNao = ( snSim, snNao );
       Servico.Valores.IssRetido              := snSim;
       Servico.Valores.ValorIss               := 20.000;
       Servico.Valores.ValorIssRetido         := 19.547;
       Servico.Valores.OutrasRetencoes        := 10;
       Servico.Valores.BaseCalculo            := 10;
       Servico.Valores.Aliquota               := 10;
       Servico.Valores.ValorLiquidoNfse       := 10;
       Servico.Valores.DescontoIncondicionado := 10;
       Servico.Valores.DescontoCondicionado   := 10;
       Servico.ItemListaServico               := '1122';
       Servico.CodigoCnae                     := '123';
       Servico.CodigoTributacaoMunicipio      := '118879';
       Servico.Discriminacao                  := 'discriminacao';
       Servico.CodigoMunicipio                := '252587';

       Prestador.Cnpj               := '54773502000184';
       Prestador.InscricaoMunicipal := '123456';

       Tomador.IdentificacaoTomador.CpfCnpj.Cnpj       := '333';
       Tomador.IdentificacaoTomador.InscricaoMunicipal := '444';

       Tomador.RazaoSocial :='razao social';

       Tomador.Endereco.Endereco        := 'endereco';
       Tomador.Endereco.Numero          := 'numero';
       Tomador.Endereco.Complemento     := 'complemento';
       Tomador.Endereco.Bairro          := 'bairro';
       Tomador.Endereco.CodigoMunicipio := '11223';
       Tomador.Endereco.UF              := 'SP';
       Tomador.Endereco.CEP             := '07043010';

       Tomador.Contato.Telefone := '1124217591';
       Tomador.Contato.Email    := 'juaumkiko@msn.com';

       IntermediarioServico.RazaoSocial        := 'razao';
       IntermediarioServico.CpfCnpj.Cpf        := '11122';
       IntermediarioServico.InscricaoMunicipal := '12547478';

       ConstrucaoCivil.CodigoObra := '88888';
       ConstrucaoCivil.Art        := '433';
      end;
    end;
  end;

 ACBrNFSe1.NotasFiscais.GerarNFSe;
 ACBrNFSe1.NotasFiscais.Assinar;
end;

procedure TForm1.btnEnviaClick(Sender: TObject);
begin
 ACBrNFSe1.Enviar(1);
end;

procedure TForm1.btnValidaClick(Sender: TObject);
begin
 {a}
end;

end.
