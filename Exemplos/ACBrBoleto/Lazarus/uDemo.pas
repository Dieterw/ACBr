unit uDemo; 

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, LResources, Forms, Controls, Graphics, Dialogs,
  StdCtrls, EditBtn, ACBrBoleto, ACBrBoletoFCFortesFr, ExtCtrls, MaskEdit;

type

  { TfrmDemo }

  TfrmDemo = class ( TForm )
     ACBrBoleto1: TACBrBoleto;
     ACBrBoletoFCFortes1: TACBrBoletoFCFortes;
     btnIncluiBoleto: TButton;
     btnIncluir10Boletos: TButton;
     btnGerarRemessa: TButton;
     btnImprimir: TButton;
     btnZerar: TButton;
     cbxAceite: TComboBox;
     Edit1: TEdit;
     Edit2: TEdit;
     edtMulta: TEdit;
     edtCEP: TMaskEdit;
     edtCPFCNPJ: TEdit;
     edtDataAbatimento: TDateEdit;
     edtDataDesconto: TDateEdit;
     edtDataProtesto: TDateEdit;
     edtEmail: TEdit;
     edtNossoNro: TEdit;
     edtUF: TEdit;
     edtCidade: TEdit;
     edtBairro: TEdit;
     edtComplemento: TEdit;
     edtNumero: TEdit;
     edtEndereco: TEdit;
     edtNome: TEdit;
     edtCarteira: TEdit;
     edtDataDoc: TDateEdit;
     edtEspecieDoc: TEdit;
     edtEspecieMod: TEdit;
     edtLocalPag: TEdit;
     edtNumeroDoc: TEdit;
     edtValorDoc: TEdit;
     edtMoraJuros: TEdit;
     edtValorAbatimento: TEdit;
     edtValorDesconto: TEdit;
     edtVencimento: TDateEdit;
     edtDataMora: TDateEdit;
     GroupBox1: TGroupBox;
     GroupBox2: TGroupBox;
     GroupBox3: TGroupBox;
     GroupBox4: TGroupBox;
     GroupBox5: TGroupBox;
     Label1: TLabel;
     Label10: TLabel;
     Label11: TLabel;
     Label12: TLabel;
     Label13: TLabel;
     Label14: TLabel;
     Label15: TLabel;
     Label16: TLabel;
     Label17: TLabel;
     Label18: TLabel;
     Label19: TLabel;
     Label2: TLabel;
     Label20: TLabel;
     Label21: TLabel;
     Label22: TLabel;
     Label23: TLabel;
     Label24: TLabel;
     Label25: TLabel;
     Label26: TLabel;
     Label27: TLabel;
     Label28: TLabel;
     Label29: TLabel;
     Label3: TLabel;
     Label30: TLabel;
     Label31: TLabel;
     Label4: TLabel;
     Label5: TLabel;
     Label6: TLabel;
     Label7: TLabel;
     Label8: TLabel;
     Label9: TLabel;
     memMensagem: TMemo;
     Panel1: TPanel;
     Panel2: TPanel;
     procedure btnIncluiBoletoClick ( Sender: TObject ) ;
     procedure btnIncluir10BoletosClick ( Sender: TObject ) ;
     procedure btnImprimirClick ( Sender: TObject ) ;
  private
     procedure Button1Click ( Sender: TObject ) ;
    { private declarations }
  public
    { public declarations }
  end; 

var
  frmDemo: TfrmDemo;

implementation

{$R *.lfm}

{ TfrmDemo }

procedure TfrmDemo.btnIncluir10BoletosClick ( Sender: TObject ) ;
var
  Titulo : TACBrTitulo;
  I      : Integer;
begin
   for I := 1 to 10 do
   begin
     Titulo:= ACBrBoleto1.CriarTituloNaLista;

     with Titulo do
     begin
        Vencimento        := StrToDateTime('10/05/2010');
        DataDocumento     := StrToDateTime('10/04/2010');
        NumeroDocumento   := '100001';
        EspecieDoc        := 'DM';
        Aceite            := 'S';
        DataProcessamento := Now;
        NossoNumero       := '0000000001';
        Carteira          := '19';
        ValorDocumento    := 100.35 * (I+0.5);
        Sacado.NomeSacado := 'Juliana Tamizou';
        Sacado.CNPJCPF    := '36054230867';
        Sacado.Logradouro := 'Rua Jose Afonso Tricta';
        Sacado.Numero     := '100';
        Sacado.Bairro     := 'Vila Esperanca';
        Sacado.Cidade     := 'Tatui';
        Sacado.UF         := 'SP';
        ValorAbatimento   := 10;

     end;
   end;
end;

procedure TfrmDemo.btnImprimirClick ( Sender: TObject ) ;
begin
   ACBrBoleto1.Imprimir;
end;

procedure TfrmDemo.btnIncluiBoletoClick ( Sender: TObject ) ;
var
  Titulo : TACBrTitulo;
begin
     Titulo := ACBrBoleto1.CriarTituloNaLista;

     with Titulo do
     begin
        Vencimento        := edtVencimento.Date;
        DataDocumento     := edtDataDoc.Date;
        NumeroDocumento   := edtNumeroDoc.Text;
        EspecieDoc        := edtEspecieDoc.Text;
        Aceite            := 'S';
        DataProcessamento := Now;
        NossoNumero       := edtNossoNro.Text;
        Carteira          := edtCarteira.Text;
        ValorDocumento    := StrToCurr(edtValorDoc.Text);
        Sacado.NomeSacado := edtNome.Text;
        Sacado.CNPJCPF    := edtCPFCNPJ.Text;
        Sacado.Logradouro := edtEndereco.Text;
        Sacado.Numero     := edtNumero.Text;
        Sacado.Bairro     := edtBairro.Text;
        Sacado.Cidade     := edtCidade.Text;
        Sacado.UF         := edtUF.Text;
        ValorAbatimento   := StrToCurrDef(edtMoraJuros.Text,0);
        LocalPagamento    := edtLocalPag.Text;
        ValorMoraJuros    := StrToCurrDef(edtMoraJuros.Text,0);
        ValorDesconto     := StrToCurrDef(edtValorDesconto.Text,0);
        ValorAbatimento   := StrToCurrDef(edtValorAbatimento.Text,0);
        DataMoraJuros     := edtDataMora.Date;
        DataDesconto      := edtDataDesconto.Date;
        DataAbatimento    := edtDataAbatimento.Date;
        DataProtesto      := edtDataProtesto.Date;
        PercentualMulta   := StrToCurrDef(edtMulta.Text,0);
        Mensagem.Text     := memMensagem.Text;
        TipoOcorrencia    := toRemessaBaixar;
     end;
end;

procedure TfrmDemo.Button1Click ( Sender: TObject ) ;
begin
   ACBrBoleto1.GerarRemessa( 1 );
end;

end.

