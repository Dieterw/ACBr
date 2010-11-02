unit Frm_SPEDFiscal;

{$IFDEF FPC}
  {$mode objfpc}{$H+}
{$ENDIF}

interface

uses
{$IFNDEF FPC}
  Windows, Messages,
{$ENDIF}
  SysUtils, Variants, Classes, Graphics, Controls, Forms, ACBrEFDBlocos,
  Dialogs, StdCtrls, ACBrSpedFiscal, ExtCtrls, ComCtrls, ACBrUtil, ACBrTXTClass;

type
  
  { TFrmSPEDFiscal }

  TFrmSPEDFiscal = class(TForm)
     btnB_0: TButton;
     btnB_1: TButton;
     btnB_C: TButton;
     btnB_D: TButton;
     btnB_E: TButton;
     btnB_H: TButton;
    btnError: TButton;
    btnTXT: TButton;
    btnB_9: TButton;
    cbConcomitante: TCheckBox;
    edBufNotas: TEdit;
    edNotas: TEdit;
    edBufLinhas: TEdit;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    memoError: TMemo;
    edtFile: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    memoTXT: TMemo;
    Label3: TLabel;
    ACBrSPEDFiscal1: TACBrSPEDFiscal;
    Label4: TLabel;
    Label5: TLabel;
    Panel1: TPanel;
    Panel2: TPanel;
    ProgressBar1: TProgressBar;
    procedure btnB_0Click(Sender: TObject);
    procedure btnB_9Click(Sender: TObject);
    procedure btnTXTClick(Sender: TObject);
    procedure btnB_1Click(Sender: TObject);
    procedure btnB_CClick(Sender: TObject);
    procedure btnB_DClick(Sender: TObject);
    procedure btnB_EClick(Sender: TObject);
    procedure btnB_HClick(Sender: TObject);
    procedure btnErrorClick(Sender: TObject);
    procedure edtFileChange(Sender: TObject);
    procedure cbConcomitanteClick(Sender: TObject);
    procedure ACBrSPEDFiscal1Error(const MsnError: AnsiString);
  private
     procedure LoadToMemo;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmSPEDFiscal: TFrmSPEDFiscal;

implementation

{$IFDEF FPC}
 {$R *.lfm}
{$ELSE}
 {$R *.dfm}
{$ENDIF}

procedure TFrmSPEDFiscal.ACBrSPEDFiscal1Error(const MsnError: AnsiString);
begin
   memoError.Lines.Add(MsnError);
end;

procedure TFrmSPEDFiscal.btnB_0Click(Sender: TObject);

const
strUNID: array[0..4] of string = ('PC', 'UN', 'LT', 'PC', 'MT');

var
int0150: integer;
int0175: integer;
int0300: integer;
int0190: integer;

begin
   // Alimenta o componente com informações para gerar todos os registros do
   // Bloco 0.

   cbConcomitante.Enabled := False ;
   btnB_0.Enabled := false;
   btnB_C.Enabled := True ;

   if cbConcomitante.Checked then
   begin
      with ACBrSpedFiscal1 do
      begin
         DT_INI := StrToDate('01/07/2009');
         DT_FIN := StrToDate('31/07/2009');
         LinhasBuffer := StrToIntDef( edBufLinhas.Text, 0 );

         IniciaGeracao;
      end;

      LoadToMemo;
   end;

   with ACBrSpedFiscal1.Bloco_0 do
   begin
      // Dados da Empresa
      with Registro0000New do
      begin
         COD_VER    := vlVersao102;
         COD_FIN    := raOriginal;
         NOME       := 'NOME DA EMPRESA';
         CNPJ       := '';
         CPF        := '00000000000'; // Deve ser uma informação valida
         UF         := 'ES';
         IE         := '082260133';
         COD_MUN    := 3200607;
         IM         := '';
         SUFRAMA    := '';
         IND_PERFIL := pfPerfilA;
         IND_ATIV   := atOutros;
      end;
      with Registro0001New do
      begin
         IND_MOV := imComDados;

         // FILHO - Dados complementares da Empresa
         with Registro0005New do
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
         // FILHO - Dados do contador.
         with Registro0100New do
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
//          Check(Reg0001.Registro0190.LocalizaRegistro(UNID), '(0-0190) UNIDADE MEDIDA: A unidade de medida "%s" foi duplicada na lista de registros 0190!', [UNID]);

         // FILHO
         for int0150 := 1 to 10 do
         begin
            // 10 Clientes
            with Registro0150New do
            begin
               COD_PART := IntToStr(int0150);
               NOME     := 'NOME DO CLIENTE';
               COD_PAIS := '001';
               CNPJ     := '123456789';
               CPF      := '123456789';
               IE       := '';
               COD_MUN  := 1;
               SUFRAMA  := '';
               ENDERECO := 'ENDERECO';
               NUM      := '';
               COMPL    := 'COMPLEMENTO';
               BAIRRO   := 'BAIRRO';
               //
               // FILHO - 5 Alterações para cada cliente
               for int0175 := 1 to 5 do
               begin
                  with Registro0175New do
                  begin
                     DT_ALT   := Date + int0175;
                     NR_CAMPO := IntToStr(int0175);
                     CONT_ANT := 'CAMPO ANTERIOR ' + IntToStr(int0175);
                  end;
               end;
            end;
         end;
         // FILHO
         // 4 Unidades de medida
         // Const strUNID, esta declarada no inicio deste evento.
         for int0190 := Low(strUNID) to High(strUNID) do
         begin
            if not Registro0190.LocalizaRegistro(strUNID[int0190]) then
            begin
               with Registro0190New do
               begin
                  UNID  := strUNID[int0190];
                  DESCR := 'Descricao ' + strUNID[int0190];
               end;
            end;
         end;
         // FILHO
         for int0300 := 1 to 10 do
         begin
            // 10 Bens Imobilizados
            with Registro0300New do
            begin
               COD_IND_BEM := FormatFloat('000000', int0300);
               IDENT_MERC  := 1;
               DESCR_ITEM  := 'DESCRIÇÃO DO ITEM';
               COD_PRNC    := '';
               COD_CTA     := '';
               NR_PARC     := 10;
               // FILHO
               with Registro0305New do
               begin
                  COD_CCUS     := '123';
                  VIDA_UTIL    := 60;
               end;
            end;
         end;
      end;
   end;

   if cbConcomitante.Checked then
   begin
      ACBrSPEDFiscal1.WriteBloco_0;
      LoadToMemo;
   end;
end;

procedure TFrmSPEDFiscal.btnB_9Click(Sender: TObject);
begin
   btnB_9.Enabled := False ;
   ACBrSPEDFiscal1.WriteBloco_9;
   LoadToMemo;

   // Habilita os botões
   btnB_0.Enabled := true;
   btnB_1.Enabled := true;
   btnB_C.Enabled := true;
   btnB_D.Enabled := true;
   btnB_E.Enabled := true;
   btnB_H.Enabled := true;

   cbConcomitante.Enabled := True ;
end;

procedure TFrmSPEDFiscal.btnTXTClick(Sender: TObject);
begin
   btnTXT.Enabled := False ;

   ACBrSPEDFiscal1.LinhasBuffer := StrToIntDef( edBufLinhas.Text, 0 );

   with ACBrSpedFiscal1 do
   begin
      DT_INI := StrToDate('01/07/2009');
      DT_FIN := StrToDate('31/07/2009');
   end;

   // Limpa a lista de erros.
   memoError.Lines.Clear;
   // Informa o pata onde será salvo o arquivo TXT.
   //   ACBrSpedFiscal1.Path := '.\Arquivo Sped TXT\';

   // Método que gera o arquivo TXT.
   ACBrSpedFiscal1.SaveFileTXT ;

   // Carrega o arquivo TXT no memo.
   LoadToMemo;

   // Habilita os botões
   btnB_0.Enabled := true;
   btnB_1.Enabled := true;
   btnB_C.Enabled := true;
   btnB_D.Enabled := true;
   btnB_E.Enabled := true;
   btnB_H.Enabled := true;
   btnTXT.Enabled := True ;
   cbConcomitante.Enabled := True ;
end;

procedure TFrmSPEDFiscal.btnErrorClick(Sender: TObject);
begin
   with ACBrSpedFiscal1 do
   begin
      DT_INI := StrToDate('01/07/2009');
      DT_FIN := StrToDate('01/07/2009');
   end;

   // Limpa a lista de erros.
   memoError.Lines.Clear;

   // Método que gera o arquivo TXT.
   ACBrSpedFiscal1.SaveFileTXT ;

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
   btnB_1.Enabled := false;
   btnB_9.Enabled := cbConcomitante.Checked ;

   // Alimenta o componente com informações para gerar todos os registros do
   // Bloco 1.
//   with ACBrSpedFiscal1.Bloco_1 do
//   begin
//      with Registro1001New do
//      begin
//        IND_MOV := 1;
//      end;
//   end;

   if cbConcomitante.Checked then
   begin
      ACBrSPEDFiscal1.WriteBloco_1;
      LoadToMemo;
   end;
end;

procedure TFrmSPEDFiscal.btnB_CClick(Sender: TObject);
var
INotas: Integer;
IItens: Integer;
NNotas: Integer;
BNotas: Integer;
begin
   // Alimenta o componente com informações para gerar todos os registros do
   // Bloco C.
   btnB_C.Enabled := false;
   btnB_D.Enabled := True ;

   NNotas := StrToInt64Def(edNotas.Text,1);
   BNotas := StrToInt64Def(edBufNotas.Text,1);

   ProgressBar1.Visible := cbConcomitante.Checked ;
   ProgressBar1.Max     := NNotas;
   ProgressBar1.Position:= 0 ;

   with ACBrSpedFiscal1.Bloco_C do
   begin
      with RegistroC001New do
      begin
         IND_MOV := imComDados;
         //
         for INotas := 1 to NNotas do
         begin
           with RegistroC100New do
           begin
             COD_PART      := '001';
             IND_EMIT      := edEmissaoPropria;
             IND_OPER      := tpEntradaAquisicao;
             COD_MOD       := '';
             COD_SIT       := sdRegular;
             SER           := '';
             NUM_DOC       := FormatFloat('NF000000',INotas);
             CHV_NFE       := '';
             DT_DOC        := Date();
             DT_E_S        := Date();
             VL_DOC        := 0;
             IND_PGTO      := tpSemPagamento;
             VL_DESC       := 0;
             VL_ABAT_NT    := 0;
             VL_MERC       := 0;
             IND_FRT       := tfSemCobrancaFrete;
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
               with RegistroC170New do   //Inicio Adicionar os Itens:
               begin
                  NUM_ITEM    := FormatFloat('000', IItens);
                  COD_ITEM    := FormatFloat('000000',StrToInt(NUM_ITEM));
                  DESCR_COMPL := FormatFloat('NF000000',INotas)+' -> ITEM '+COD_ITEM;
                  QTD         := 1;
                  UNID        := 'UN';
                  VL_ITEM     := 0;
                  VL_DESC     := 0;
                  IND_MOV     := mfNao;
                  CST_ICMS    := '001';
                  CFOP        := '1252';
                  COD_NAT     := '64';
                  VL_BC_ICMS  := 0;
                  ALIQ_ICMS   := 0;
                  VL_ICMS     := 0;
                  VL_BC_ICMS_ST := 0;
                  ALIQ_ST       := 0;
                  VL_ICMS_ST    := 0;
                  IND_APUR      := iaMensal;
                  CST_IPI       := ipiEntradaIsenta;
                  COD_ENQ       := '';
                  VL_BC_IPI     := 0;
                  ALIQ_IPI      := 0;
                  VL_IPI        := 0;
                  CST_PIS       := pisOutrasOperacoes;
                  VL_BC_PIS     := 0;
                  ALIQ_PIS_PERC := 0;
                  QUANT_BC_PIS  := 0;
                  ALIQ_PIS_R    := 0;
                  VL_PIS        := 0;
                  CST_COFINS    := cofinsOutrasOperacoes;
                  VL_BC_COFINS  := 0;
                  ALIQ_COFINS_PERC := 0;
                  QUANT_BC_COFINS  := 0;
                  ALIQ_COFINS_R    := 0;
                  VL_COFINS        := 0;
                  COD_CTA          := '000';
                end; //Fim dos Itens;
             end;
             //c190
             for IItens := 1 to 10 do
             begin
               with RegistroC190New do
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

           if cbConcomitante.Checked then
           begin
              if (INotas mod BNotas) = 0 then   // Gravar a cada N notas
              begin
                 // Grava registros na memoria para o TXT, e limpa memoria
                 ACBrSPEDFiscal1.WriteBloco_C( False );  // False, NAO fecha o Bloco
                 ProgressBar1.Position := INotas;
                 Application.ProcessMessages;
              end;
           end;
         end;
      end;
   end;

   if cbConcomitante.Checked then
   begin
      ACBrSPEDFiscal1.WriteBloco_C(True);  // True, fecha o Bloco
      LoadToMemo;
   end;

   ProgressBar1.Visible := False ;

end;

procedure TFrmSPEDFiscal.btnB_DClick(Sender: TObject);
begin
   // Alimenta o componente com informações para gerar todos os registros do
   // Bloco D.
//   with ACBrSpedFiscal1.Bloco_D do
//   begin
//      with RegistroD001New do
//      begin
//        IND_MOV := 1;
//      end;
//   end;
   btnB_D.Enabled := false;
   btnB_E.Enabled := True ;

   if cbConcomitante.Checked then
   begin
      ACBrSPEDFiscal1.WriteBloco_D;
      LoadToMemo;
   end;
end;

procedure TFrmSPEDFiscal.btnB_EClick(Sender: TObject);
begin
   // Alimenta o componente com informações para gerar todos os registros do
   // Bloco E.
   btnB_E.Enabled := false;
   btnB_H.Enabled := True ;

   with ACBrSpedFiscal1.Bloco_E do
   begin
      // Abertura do Bloco E
      with RegistroE001New do
      begin
         IND_MOV := imComDados;
         ///
         with RegistroE110New do
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
   end;

   if cbConcomitante.Checked then
   begin
      ACBrSPEDFiscal1.WriteBloco_E;
      LoadToMemo;
   end;
end;

procedure TFrmSPEDFiscal.btnB_HClick(Sender: TObject);
var
IInvent: integer;
begin
   btnB_H.Enabled := false;
   btnB_1.Enabled := True ;

   // Alimenta o componente com informações para gerar todos os registros do
   // Bloco H.
   with ACBrSpedFiscal1.Bloco_H do
   begin
      with RegistroH001New do
      begin
         IND_MOV := imComDados;
         //
         with RegistroH005New do
         begin
            DT_INV := Date;
            VL_INV := 1000;
            // FILHO
            for IInvent := 1 to 10 do
            begin
               with RegistroH010New do
               begin
                  COD_ITEM := FormatFloat('00000000000000', IInvent);
                  UNID := 'UN';
                  QTD  := 1;
                  VL_UNIT := 100;
                  VL_ITEM := 100;
                  IND_PROP := piInformante;
                  COD_PART := '';
                  TXT_COMPL := '';
                  COD_CTA := '';
               end;
            end;
         end;
      end;
   end;

   if cbConcomitante.Checked then
   begin
      ACBrSPEDFiscal1.WriteBloco_H;
      LoadToMemo;
   end;
end;

procedure TFrmSPEDFiscal.edtFileChange(Sender: TObject);
begin
   ACBrSPEDFiscal1.Arquivo := edtFile.Text ;
end;

procedure TFrmSPEDFiscal.LoadToMemo;
begin
   memoTXT.Lines.Clear;
   if FileExists( ACBrSpedFiscal1.Path + ACBrSpedFiscal1.Arquivo ) then
      memoTXT.Lines.LoadFromFile(ACBrSpedFiscal1.Path + ACBrSpedFiscal1.Arquivo);
end;

procedure TFrmSPEDFiscal.cbConcomitanteClick(Sender: TObject);
begin
   btnTXT.Enabled   := not cbConcomitante.Checked ;
   btnError.Enabled := btnTXT.Enabled ;

   edBufNotas.Enabled := cbConcomitante.Checked ;

   if not cbConcomitante.Checked then
   begin
      btnB_0.Enabled := True ;
      btnB_C.Enabled := False ;
      btnB_D.Enabled := False ;
      btnB_E.Enabled := False ;
      btnB_H.Enabled := False ;
      btnB_1.Enabled := False ;
      btnB_9.Enabled := False ;
   end;
end;

end.
