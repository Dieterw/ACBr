unit Frm_SPEDFiscal;

{$IFDEF FPC}
{$mode objfpc}{$H+}
{$ENDIF}

interface

uses
{$IFNDEF FPC}
  Windows, Messages,
{$ELSE}
  LResources,
{$ENDIF}
  SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ACBrSpedFiscal, ExtCtrls, ACBrSped;

type
  TFrmSPEDFiscal = class(TForm)
    btnB_0: TButton;
    edtError: TMemo;
    edtFile: TEdit;
    btnTXT: TButton;
    btnB_1: TButton;
    btnB_C: TButton;
    btnB_D: TButton;
    btnB_E: TButton;
    btnB_H: TButton;
    Label1: TLabel;
    Label2: TLabel;
    edtTXT: TMemo;
    Label3: TLabel;
    Label4: TLabel;
    btnError: TButton;
    ACBrSPEDFiscal1: TACBrSPEDFiscal;
    procedure btnB_0Click(Sender: TObject);
    procedure btnTXTClick(Sender: TObject);
    procedure btnB_1Click(Sender: TObject);
    procedure btnB_CClick(Sender: TObject);
    procedure btnB_DClick(Sender: TObject);
    procedure btnB_EClick(Sender: TObject);
    procedure btnB_HClick(Sender: TObject);
    procedure ACBrSpedFiscal1Error(const MsnError: string);
    procedure btnErrorClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmSPEDFiscal: TFrmSPEDFiscal;

implementation

{$IFNDEF FPC}
{$R *.dfm}
{$ENDIF}

procedure TFrmSPEDFiscal.ACBrSpedFiscal1Error(const MsnError: string);
begin
   edtError.Lines.Add(MsnError);
end;

procedure TFrmSPEDFiscal.btnB_0Click(Sender: TObject);
begin
   // Alimenta o componente com informações para gerar todos os registros do
   // Bloco 0.
   with ACBrSpedFiscal1 do
   begin
      // Dados da Empresa
      with Bloco_0.Registro0000 do
      begin
         COD_VER    := 2;
         COD_FIN    := 0;
         NOME       := 'NOME DA EMPRESA';
         CNPJ       := '';
         CPF        := '00000000000'; // Deve ser uma informação valida
         UF         := 'ES';
         IE         := '082260133';
         COD_MUN    := 3200607;
         IM         := '';
         SUFRAMA    := '';
         IND_PERFIL := 'A';
         IND_ATIV   := 1;
      end;
      // Abertura do Bloco 1
      with Bloco_0.Registro0001 do
      begin
         IND_MOV := 0;
      end;
      // Dados complementares da Empresa
      with Bloco_0.Registro0005 do
      begin
         FANTASIA   := 'NOME FANTASSIA';
         CEP        := '29900000';
         ENDERECO   := 'ENDEREÇO DA EMPRESA';
         NUM        := 'S/N';
         COMPL      := '';
         BAIRRO     := 'BAIRRO';
         FONE       := '';
         FAX        := '';
         EMAIL      := 'email@email.com.br';
      end;
      // Dados do contador.
      with Bloco_0.Registro0100 do
      begin
         NOME       := 'NOME DO CONTADOR';
         CPF        := '00000000000'; // Deve ser uma informação valida
         CRC        := '123456';
         CNPJ       := '';
         CEP        := '';
         ENDERECO   := '';
         NUM        := '';
         COMPL      := '';
         BAIRRO     := '';
         FONE       := '';
         FAX        := '';
         EMAIL      := '';
         COD_MUN    := 3200607;
      end;
   end;
   btnB_0.Enabled := false;
end;

procedure TFrmSPEDFiscal.btnTXTClick(Sender: TObject);
begin
   with ACBrSpedFiscal1 do
   begin
      DT_INI := StrToDate('01/07/2009');
      DT_FIN := StrToDate('31/07/2009');
   end;

   // Limpa a lista de erros.
   edtError.Lines.Clear;
   // Informa o pata onde será salvo o arquivo TXT.
//   ACBrSpedFiscal1.Path := '.\Arquivo Sped TXT\';

   with ACBrSpedFiscal1 do
   begin
      // Método que gera o arquivo TXT.
      SaveFileTXT(edtFile.Text);
   end;
   // Carrega o arquivo TXT no memo.
   edtTXT.Lines.LoadFromFile(ACBrSpedFiscal1.Path + edtFile.Text);
   // Habilita os botões
   btnB_0.Enabled := true;
   btnB_1.Enabled := true;
   btnB_C.Enabled := true;
   btnB_D.Enabled := true;
   btnB_E.Enabled := true;
   btnB_H.Enabled := true;
end;

procedure TFrmSPEDFiscal.btnErrorClick(Sender: TObject);
begin
   with ACBrSpedFiscal1 do
   begin
      DT_INI := StrToDate('01/07/2009');
      DT_FIN := StrToDate('01/07/2009');
   end;

   // Limpa a lista de erros.
   edtError.Lines.Clear;
   // Informa o pata onde será salvo o arquivo TXT.
//   ACBrSpedFiscal1.Path := '.\Arquivo Sped TXT\';

   with ACBrSpedFiscal1 do
   begin
      // Método que gera o arquivo TXT.
      SaveFileTXT(edtFile.Text);
   end;
   // Habilita os botões
   btnB_0.Enabled := true;
   btnB_1.Enabled := true;
   btnB_C.Enabled := true;
   btnB_D.Enabled := true;
   btnB_E.Enabled := true;
   btnB_H.Enabled := true;
end;

procedure TFrmSPEDFiscal.btnB_1Click(Sender: TObject);
begin
   // Alimenta o componente com informações para gerar todos os registros do
   // Bloco 1.
   with ACBrSpedFiscal1.Bloco_1.Registro1001 do
   begin
      IND_MOV := 1;
   end;
   btnB_1.Enabled := false;
end;

procedure TFrmSPEDFiscal.btnB_CClick(Sender: TObject);
begin
   // Alimenta o componente com informações para gerar todos os registros do
   // Bloco C.
   with ACBrSpedFiscal1.Bloco_C.RegistroC001 do
   begin
      IND_MOV := 1;
   end;
   btnB_C.Enabled := false;
end;

procedure TFrmSPEDFiscal.btnB_DClick(Sender: TObject);
begin
   // Alimenta o componente com informações para gerar todos os registros do
   // Bloco D.
   with ACBrSpedFiscal1.Bloco_D.RegistroD001 do
   begin
      IND_MOV := 1;
   end;
   btnB_D.Enabled := false;
end;

procedure TFrmSPEDFiscal.btnB_EClick(Sender: TObject);
begin
   // Alimenta o componente com informações para gerar todos os registros do
   // Bloco E.
   with ACBrSpedFiscal1 do
   begin
      // Abertura do Bloco E
      with Bloco_E.RegistroE001 do
      begin
         IND_MOV := 0;
      end;
      with Bloco_E.RegistroE100 do
      begin

      end;
      with Bloco_E.RegistroE110 do
      begin
         VL_TOT_DEBITOS := 0;
         VL_AJ_DEBITOS := 0;
         VL_TOT_AJ_DEBITOS := 0;
         VL_ESTORNOS_CRED := 0;
         VL_TOT_CREDITOS := 0;
         VL_AJ_CREDITOS := 0;
         VL_TOT_AJ_CREDITOS := 0;
         VL_ESTORNOS_DEB := 0;
         VL_SLD_CREDOR_ANT := 0;
         VL_SLD_APURADO := 0;
         VL_TOT_DED := 0;
         VL_ICMS_RECOLHER := 0;
         VL_SLD_CREDOR_TRANSPORTAR := 0;
         DEB_ESP := 0;
      end;
   end;
   btnB_E.Enabled := false;
end;

procedure TFrmSPEDFiscal.btnB_HClick(Sender: TObject);
begin
   // Alimenta o componente com informações para gerar todos os registros do
   // Bloco H.
   with ACBrSpedFiscal1.Bloco_H.RegistroH001 do
   begin
      IND_MOV := 1;
   end;
   btnB_H.Enabled := false;
end;

initialization
{$IFDEF FPC}
   {$I Frm_SPEDFiscal.lrs}
{$ENDIF}

end.
