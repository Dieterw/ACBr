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
  Dialogs, StdCtrls, ACBrSpedFiscal, ExtCtrls, ACBrSped, ACBrUtilTXT;

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
    procedure ACBrSpedFiscal1Error(const MsnError: AnsiString);
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

procedure TFrmSPEDFiscal.ACBrSpedFiscal1Error(const MsnError: AnsiString);
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
         CPF        := '12345678900'; // Deve ser uma informação valida
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
//   with ACBrSpedFiscal1.Bloco_1.Registro1001 do
//   begin
//      IND_MOV := 1;
//   end;
   btnB_1.Enabled := false;
end;

procedure TFrmSPEDFiscal.btnB_CClick(Sender: TObject);
var
INotas: Integer;
IItens: Integer;
begin
   // Alimenta o componente com informações para gerar todos os registros do
   // Bloco C.
   with ACBrSpedFiscal1 do
   begin
     with Bloco_C.RegistroC001 do
     begin
        IND_MOV := 0;
     end;
     for INotas := 1 to 10 do
     begin
       with Bloco_C.RegistroC100.New do
       begin
         with Items[INotas-1] do
         begin
           COD_PART      := '001';
           IND_EMIT      := '';
           IND_OPER      := '';
           COD_MOD       := '';
           COD_SIT       := '';
           SER           := '';
           NUM_DOC       := FormatFloat('NF000000',INotas);
           CHV_NFE       := '';
           DT_DOC        := Date();
           DT_E_S        := Date();
           VL_DOC        := 0;
           IND_PGTO      := '';
           VL_DESC       := 0;
           VL_ABAT_NT    := 0;
           VL_MERC       := 0;
           IND_FRT       := '';
           VL_SEG        := 0;
           VL_OUT_DA     := 0;
           VL_BC_ICMS    := 0;
           VL_ICMS       := 0;
           VL_BC_ICMS_ST := 0;
           VL_ICMS_ST    := 0;
           VL_IPI        := 0;
           VL_PIS        := 0;
           VL_COFINS     := 0;
           VL_PIS_ST     := 0;
           VL_COFINS_ST  := 0;
           //c170
           for IItens := 1 to 10 do
           begin
             with RegistroC170.New do
             begin
                with Items[IItens-1] do//Inicio Adicionar os Itens:
                begin
                  NUM_ITEM    := FormatFloat('000', IItens);
                  COD_ITEM    := FormatFloat('000000',StrToInt(NUM_ITEM));
                  DESCR_COMPL := FormatFloat('NF000000',INotas)+' -> ITEM '+COD_ITEM;
                  QTD         := 1.12347;
                  UNID        := 'UN';
                  VL_ITEM     := 0;
                  VL_DESC     := 0;
                  IND_MOV     := 'X';
                  CST_ICMS    := '001';
                  CFOP        := '1252';
                  COD_NAT     := '64';
                  VL_BC_ICMS  := 0;
                  ALIQ_ICMS   := 0;
                  VL_ICMS     := 0;
                  VL_BC_ICMS_ST := 0;
                  ALIQ_ST       := 0;
                  VL_ICMS_ST    := 0;
                  IND_APUR      := 'Y';
                  CST_IPI       := '003';
                  COD_ENQ       := '';
                  VL_BC_IPI     := 0;
                  ALIQ_IPI      := 0;
                  VL_IPI        := 0;
                  CST_PIS       := '000';
                  VL_BC_PIS     := 0;
                  ALIQ_PIS_PERC := 0;
                  QUANT_BC_PIS  := 0;
                  ALIQ_PIS_R    := 0;
                  VL_PIS        := 0;
                  CST_COFINS    := '000';
                  VL_BC_COFINS  := 0;
                  ALIQ_COFINS_PERC := 0;
                  QUANT_BC_COFINS  := 0;
                  ALIQ_COFINS_R    := 0;
                  VL_COFINS        := 0;
                  COD_CTA          := '000';
                end;//Fim dos Itens;
             end;
           end;
           //c190
           for IItens := 1 to 10 do
           begin
             with RegistroC190.New do
             begin
               With Items[IItens-1] do//Inicio Adicionar os Itens:
               begin
                 CST_ICMS    := '001';
                 CFOP        := '1252';
                 ALIQ_ICMS   := 0;
                 VL_OPR      := 0;
                 VL_BC_ICMS  := 0;
                 VL_ICMS     := 0;
                 VL_BC_ICMS_ST := 0;
                 VL_ICMS_ST    := 0;
                 VL_RED_BC     := 0;
                 VL_IPI        := 0;
                 COD_OBS       := '000';
               end;//Fim dos Itens;
             end;
           end;
         end;
       end;
     end;
   end;
(*

   ACBrSpedFiscal1.Bloco_C.RegistroC400.New;
   ACBrSpedFiscal1.Bloco_C.RegistroC400.Items[0].COD_MOD := '';
   ACBrSpedFiscal1.Bloco_C.RegistroC400.Items[0].ECF_MOD := '';
   ACBrSpedFiscal1.Bloco_C.RegistroC400.Items[0].ECF_FAB := '';
   ACBrSpedFiscal1.Bloco_C.RegistroC400.Items[0].ECF_CX  := '';
   // ESSE É FILHO DO C400
   ACBrSpedFiscal1.Bloco_C.RegistroC400.Items[0].RegistroC405.New;
   ACBrSpedFiscal1.Bloco_C.RegistroC400.Items[0].RegistroC405.Items[0].DT_DOC      := Date;
   ACBrSpedFiscal1.Bloco_C.RegistroC400.Items[0].RegistroC405.Items[0].CRO         := 0;
   ACBrSpedFiscal1.Bloco_C.RegistroC400.Items[0].RegistroC405.Items[0].CRZ         := 0;
   ACBrSpedFiscal1.Bloco_C.RegistroC400.Items[0].RegistroC405.Items[0].NUM_COO_FIN := 0;
   ACBrSpedFiscal1.Bloco_C.RegistroC400.Items[0].RegistroC405.Items[0].GT_FIN      := 0;
   ACBrSpedFiscal1.Bloco_C.RegistroC400.Items[0].RegistroC405.Items[0].VL_BRT      := 0;
   // ESSE É FILHO DO C405
   ACBrSpedFiscal1.Bloco_C.RegistroC400.Items[0].RegistroC405.Items[0].RegistroC460.New;
   ACBrSpedFiscal1.Bloco_C.RegistroC400.Items[0].RegistroC405.Items[0].RegistroC460.Items[0].COD_MOD   := '';
   ACBrSpedFiscal1.Bloco_C.RegistroC400.Items[0].RegistroC405.Items[0].RegistroC460.Items[0].COD_SIT   := '';
   ACBrSpedFiscal1.Bloco_C.RegistroC400.Items[0].RegistroC405.Items[0].RegistroC460.Items[0].NUM_DOC   := '';
   ACBrSpedFiscal1.Bloco_C.RegistroC400.Items[0].RegistroC405.Items[0].RegistroC460.Items[0].DT_DOC    := Date;
   ACBrSpedFiscal1.Bloco_C.RegistroC400.Items[0].RegistroC405.Items[0].RegistroC460.Items[0].VL_DOC    := 0;
   ACBrSpedFiscal1.Bloco_C.RegistroC400.Items[0].RegistroC405.Items[0].RegistroC460.Items[0].VL_PIS    := 0;
   ACBrSpedFiscal1.Bloco_C.RegistroC400.Items[0].RegistroC405.Items[0].RegistroC460.Items[0].VL_COFINS := 0;
   ACBrSpedFiscal1.Bloco_C.RegistroC400.Items[0].RegistroC405.Items[0].RegistroC460.Items[0].CPF_CNPJ  := '';
   ACBrSpedFiscal1.Bloco_C.RegistroC400.Items[0].RegistroC405.Items[0].RegistroC460.Items[0].NOM_ADQ   := '';
   // ESSE É FILHO DO C460
   ACBrSpedFiscal1.Bloco_C.RegistroC400.Items[0].RegistroC405.Items[0].RegistroC460.Items[0].RegistroC470.New;
   ACBrSpedFiscal1.Bloco_C.RegistroC400.Items[0].RegistroC405.Items[0].RegistroC460.Items[0].RegistroC470.Items[0].COD_ITEM := '';
   ACBrSpedFiscal1.Bloco_C.RegistroC400.Items[0].RegistroC405.Items[0].RegistroC460.Items[0].RegistroC470.Items[0].QTD      := 0;
   ACBrSpedFiscal1.Bloco_C.RegistroC400.Items[0].RegistroC405.Items[0].RegistroC460.Items[0].RegistroC470.Items[0].QTD_CANC := 0;
   ACBrSpedFiscal1.Bloco_C.RegistroC400.Items[0].RegistroC405.Items[0].RegistroC460.Items[0].RegistroC470.Items[0].UNID     := '';
   ACBrSpedFiscal1.Bloco_C.RegistroC400.Items[0].RegistroC405.Items[0].RegistroC460.Items[0].RegistroC470.Items[0].VL_ITEM  := 0;
   ACBrSpedFiscal1.Bloco_C.RegistroC400.Items[0].RegistroC405.Items[0].RegistroC460.Items[0].RegistroC470.Items[0].CST_ICMS := '';
   ACBrSpedFiscal1.Bloco_C.RegistroC400.Items[0].RegistroC405.Items[0].RegistroC460.Items[0].RegistroC470.Items[0].CFOP     := '';
   ACBrSpedFiscal1.Bloco_C.RegistroC400.Items[0].RegistroC405.Items[0].RegistroC460.Items[0].RegistroC470.Items[0].ALIQ_ICMS:= 0;
   ACBrSpedFiscal1.Bloco_C.RegistroC400.Items[0].RegistroC405.Items[0].RegistroC460.Items[0].RegistroC470.Items[0].VL_PIS   := 0;
   ACBrSpedFiscal1.Bloco_C.RegistroC400.Items[0].RegistroC405.Items[0].RegistroC460.Items[0].RegistroC470.Items[0].VL_COFINS:= 0;
*)

{
   with ACBrSpedFiscal1 do
   begin
      // ESSE É O PAI
      Bloco_C.RegistroC400.New;
      with Bloco_C.RegistroC400.Items[0] do
      begin
         COD_MOD := '';
         ECF_MOD := '';
         ECF_FAB := '';
         ECF_CX  := '';
         // ESSE É FILHO DO C400
         RegistroC405.New;
         with RegistroC405.Items[0] do
         begin
            DT_DOC      := Date;
            CRO         := 0;
            CRZ         := 0;
            NUM_COO_FIN := 0;
            GT_FIN      := 0;
            VL_BRT      := 0;
            // ESSE É FILHO DO C405
            RegistroC460.New;
            with RegistroC460.Items[0] do
            begin
               COD_MOD   := '';
               COD_SIT   := '';
               NUM_DOC   := '';
               DT_DOC    := Date;
               VL_DOC    := 0;
               VL_PIS    := 0;
               VL_COFINS := 0;
               CPF_CNPJ  := '';
               NOM_ADQ   := '';
               // ESSE É FILHO DO C460
               RegistroC470.New;
               with RegistroC470.Items[0] do
               begin
                  COD_ITEM := '';
                  QTD      := 0;
                  QTD_CANC := 0;
                  UNID     := '';
                  VL_ITEM  := 0;
                  CST_ICMS := '';
                  CFOP     := '';
                  ALIQ_ICMS:= 0;
                  VL_PIS   := 0;
                  VL_COFINS:= 0;
               end;
            end;
         end;
       end;
   end;
 }
   btnB_C.Enabled := false;
end;

procedure TFrmSPEDFiscal.btnB_DClick(Sender: TObject);
begin
   // Alimenta o componente com informações para gerar todos os registros do
   // Bloco D.
//   with ACBrSpedFiscal1.Bloco_D.RegistroD001 do
//   begin
//      IND_MOV := 1;
//   end;
   btnB_D.Enabled := false;
end;

procedure TFrmSPEDFiscal.btnB_EClick(Sender: TObject);
var
  I: TACBrSPEDFiscal;
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
      with Bloco_E.RegistroE510.New do
      begin
         for I := 0 to 9 do
         begin
            CFOP        := '5102';
            CST_IPI     := '000';
            VL_CONT_IPI := 0;
            VL_BC_IPI   := 0;
            VL_IPI      := 0;
            // FILHO do E510
            with Items[I].RegistroE520.New do
            begin
               VL_SD_ANT_IPI := 0;
               VL_DEB_IPI    := 0;
               VL_CRED_IPI   := 0;
               VL_OD_IPI     := 0;
               VL_OC_IPI     := 0;
               VL_SC_IPI     := 0;
               VL_SD_IPI     := 0;
            end;
            // FILHO do E510
            with Items[I].RegistroE530.New do
            begin
               IND_AJ   := '';
               VL_AJ    := 0;
               COD_AJ   := '';
               IND_DOC  := '';
               NUM_DOC  := '';
               DESCR_AJ := '';
            end;
         end;
      end;
   end;
   btnB_E.Enabled := false;
end;

procedure TFrmSPEDFiscal.btnB_HClick(Sender: TObject);
var
IInvent: integer;
begin
   // Alimenta o componente com informações para gerar todos os registros do
   // Bloco H.
   with ACBrSpedFiscal1.Bloco_H.RegistroH001 do
   begin
      IND_MOV := 1;
   end;
   with ACBrSpedFiscal1.Bloco_H.RegistroH005 do
   begin
      with New do
      begin
         DT_INV := Date;
         VL_INV := 1000;
         for IInvent := 1 to 10 do
         begin
            with RegistroH010 do
            begin
               with New do
               begin
                  COD_ITEM := FormatFloat('00000000000000', IInvent);
                  UNID := 'UN';
                  QTD  := 1;
                  VL_UNIT := 100;
                  VL_ITEM := 100;
                  IND_PROP := '1';
                  COD_PART := '';
                  TXT_COMPL := '';
                  COD_CTA := '';
               end;
            end;
         end;
      end;
   end;
   btnB_H.Enabled := false;
end;

initialization
{$IFDEF FPC}
   {$I Frm_SPEDFiscal.lrs}
{$ENDIF}

end.
