unit Frm_SPEDPisCofins;

{$IFDEF FPC}
  {$mode objfpc}{$H+}
{$ENDIF}

interface

uses
{$IFNDEF FPC}
  Windows, Messages,
{$ENDIF}
  SysUtils, Variants, Classes, Graphics, Controls, Forms, ACBrEPCBlocos,
  Dialogs, StdCtrls, ACBrSpedPisCofins, ExtCtrls, ComCtrls, ACBrUtil,
  ACBrTXTClass;

type
  
  { TFrmSPEDPisCofins }

  TFrmSPEDPisCofins = class(TForm)
    btnB_0: TButton;
    btnB_1: TButton;
    btnB_C: TButton;
    btnB_D: TButton;
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
    Label4: TLabel;
    Label5: TLabel;
    Panel1: TPanel;
    Panel2: TPanel;
    ProgressBar1: TProgressBar;
    ACBrSPEDPisCofins1: TACBrSPEDPisCofins;
    btnB_A: TButton;
    btnB_F: TButton;
    btnB_M: TButton;
    procedure btnB_0Click(Sender: TObject);
    procedure btnB_9Click(Sender: TObject);
    procedure btnTXTClick(Sender: TObject);
    procedure btnB_1Click(Sender: TObject);
    procedure btnB_CClick(Sender: TObject);
    procedure btnB_DClick(Sender: TObject);
    procedure btnErrorClick(Sender: TObject);
    procedure edtFileChange(Sender: TObject);
    procedure cbConcomitanteClick(Sender: TObject);
    procedure ACBrSPEDPisCofins1Error(const MsnError: AnsiString);
    procedure btnB_FClick(Sender: TObject);
    procedure btnB_MClick(Sender: TObject);
    procedure btnB_AClick(Sender: TObject);
  private
     procedure LoadToMemo;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmSPEDPisCofins: TFrmSPEDPisCofins;

implementation

uses
  ACBrEPCBloco_0, ACBrEPCBloco_1
, ACBrEPCBloco_A, ACBrEPCBloco_C, ACBrEPCBloco_D, ACBrEPCBloco_F
, ACBrEPCBloco_M;

{$IFDEF FPC}
 {$R *.lfm}
{$ELSE}
 {$R *.dfm}
{$ENDIF}

procedure TFrmSPEDPisCofins.ACBrSPEDPisCofins1Error(const MsnError: AnsiString);
begin
   memoError.Lines.Add(MsnError);
end;

procedure TFrmSPEDPisCofins.btnB_0Click(Sender: TObject);
const
  strUNID: array[0..4] of string = ('PC', 'UN', 'LT', 'PC', 'MT');

var
int0140: integer;
int0150: integer;
int0190: integer;
int0200: integer;

begin
   // Alimenta o componente com informações para gerar todos os registros do
   // Bloco 0.

   cbConcomitante.Enabled := False ;
   btnB_0.Enabled := false;
   btnB_C.Enabled := True ;

   if cbConcomitante.Checked then
   begin
      with ACBrSPEDPisCofins1 do
      begin
         DT_INI := StrToDate('01/04/2011');
         DT_FIN := StrToDate('30/04/2011');
         LinhasBuffer := StrToIntDef( edBufLinhas.Text, 0 );

         IniciaGeracao;
      end;

      LoadToMemo;
   end;

   with ACBrSPEDPisCofins1.Bloco_0 do
   begin
      // Dados da Empresa
      with Registro0000New do
      begin
         COD_VER          := vlVersao101;
         TIPO_ESCRIT      := tpEscrOriginal;
         IND_SIT_ESP      := indSitAbertura;
         NUM_REC_ANTERIOR := '';
         NOME             := 'NOME DA EMPRESA';
         CNPJ             := '123456789';
         UF               := 'ES';
         COD_MUN          := 3200607;
         SUFRAMA          := '';
         IND_NAT_PJ       := indNatPJSocEmpresariaGeral;
         IND_ATIV         := indAtivIndustrial;
      end;
      with Registro0001New do
      begin
         IND_MOV := imComDados;

         // FILHO - Dados do contador.
         with Registro0100New do
         begin
            NOME       := 'NOME DO CONTADOR';
            CPF        := '12345678900'; // Deve ser uma informação valida
            CRC        := '123456';
            CNPJ       := '123456789';
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

         // FILHO - Regime de Apuração
         with Registro0110New do
         begin
            COD_INC_TRIB  := codEscrOpIncNaoCumulativo;
            IND_APRO_CRED := indMetodoApropriacaoDireta;
            COD_TIPO_CONT := codIndTipoConExclAliqBasica;
         end;

         for int0140 := 1 to 10 do
         begin
         // FILHO
            with Registro0140New do
            begin
               COD_EST := IntToStr(int0140);
               NOME    := 'NOME DO ESTABELECIMENTO';
               CNPJ    := '123456789';
               UF      := '';
               IE      := '';
               COD_MUN := 0;
               IM      := '';
               SUFRAMA := '';
               //
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
                     COD_MUN  := 0;
                     SUFRAMA  := '';
                     ENDERECO := 'ENDERECO';
                     NUM      := '';
                     COMPL    := 'COMPLEMENTO';
                     BAIRRO   := 'BAIRRO';
                     //
                  end;
               end;
               // FILHO
               for int0190 := Low(strUNID) to High(strUNID) do
               begin
                  with Registro0190New do
                  begin
                     UNID  := strUNID[int0190];
                     DESCR := 'Descricao ' + strUNID[int0190];
                  end;
               end;
               // FILHO
               for int0200 := 1 to 10 do
               begin
                  // Cadastro dos Itens
                  with Registro0200New do
                  begin
                     COD_ITEM     := FormatFloat('000000', int0200);
                     DESCR_ITEM   := 'DESCRIÇÃO DO ITEM';
                     COD_BARRA    := '';
                     COD_ANT_ITEM := '';
                     UNID_INV     := '';
                     TIPO_ITEM    := tiMercadoriaRevenda;
                     COD_NCM      := '12345678';
                     EX_IPI       := '';
                     COD_GEN      := '';
                     COD_LST      := '';
                     ALIQ_ICMS    := 0;
                  end;
               end;
            end;
         end;
      end;
   end;

   if cbConcomitante.Checked then
   begin
      ACBrSPEDPisCofins1.WriteBloco_0;
      LoadToMemo;
   end;
end;

procedure TFrmSPEDPisCofins.btnB_9Click(Sender: TObject);
begin
   btnB_9.Enabled := False ;
   ACBrSPEDPisCofins1.WriteBloco_9;
   LoadToMemo;

   // Habilita os botões
   btnB_0.Enabled := true;
   btnB_1.Enabled := true;
   btnB_A.Enabled := true;
   btnB_C.Enabled := true;
   btnB_D.Enabled := true;
   btnB_F.Enabled := true;
   btnB_M.Enabled := true;

   cbConcomitante.Enabled := True ;
end;

procedure TFrmSPEDPisCofins.btnTXTClick(Sender: TObject);
begin
   btnTXT.Enabled := False ;

   ACBrSPEDPisCofins1.LinhasBuffer := StrToIntDef( edBufLinhas.Text, 0 );

   with ACBrSPEDPisCofins1 do
   begin
      DT_INI := StrToDate('01/04/2011');
      DT_FIN := StrToDate('30/04/2011');
   end;

   // Limpa a lista de erros.
   memoError.Lines.Clear;
   // Informa o pata onde será salvo o arquivo TXT.
   ACBrSPEDPisCofins1.Path := '.\';
   ACBrSPEDPisCofins1.Arquivo := edtFile.Text;

   // Método que gera o arquivo TXT.
   ACBrSPEDPisCofins1.SaveFileTXT ;

   // Carrega o arquivo TXT no memo.
   LoadToMemo;

   // Habilita os botões
   btnB_0.Enabled := true;
   btnB_1.Enabled := true;
   btnB_A.Enabled := true;
   btnB_C.Enabled := true;
   btnB_D.Enabled := true;
   btnB_F.Enabled := true;
   btnB_M.Enabled := true;
   btnTXT.Enabled := True ;
   cbConcomitante.Enabled := True ;
end;

procedure TFrmSPEDPisCofins.btnErrorClick(Sender: TObject);
begin
   with ACBrSPEDPisCofins1 do
   begin
      DT_INI := StrToDate('01/04/2011');
      DT_FIN := StrToDate('30/04/2011');
   end;

   // Limpa a lista de erros.
   memoError.Lines.Clear;

   // Método que gera o arquivo TXT.
   ACBrSPEDPisCofins1.SaveFileTXT ;

   // Habilita os botões
   btnB_0.Enabled := true;
   btnB_1.Enabled := true;
   btnB_A.Enabled := true;
   btnB_C.Enabled := true;
   btnB_D.Enabled := true;
   btnB_F.Enabled := true;
   btnB_M.Enabled := true;
end;

procedure TFrmSPEDPisCofins.btnB_1Click(Sender: TObject);
begin
   btnB_1.Enabled := false;
   btnB_9.Enabled := cbConcomitante.Checked ;

   // Alimenta o componente com informações para gerar todos os registros do
   // Bloco 1.
//   with ACBrSPEDPisCofins1.Bloco_1 do
//   begin
//      with Registro1001New do
//      begin
//        IND_MOV := 1;
//      end;
//   end;

   if cbConcomitante.Checked then
   begin
      ACBrSPEDPisCofins1.WriteBloco_1;
      LoadToMemo;
   end;
end;

procedure TFrmSPEDPisCofins.btnB_CClick(Sender: TObject);
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

   with ACBrSPEDPisCofins1.Bloco_C do
   begin
      with RegistroC001New do
      begin
         IND_MOV := imComDados;
         //
         for INotas := 1 to NNotas do
         begin
           with RegistroC010New do
           begin
              CNPJ := '123456789';
              IND_ESCRI := IndEscriConsolidado;
              with RegistroC100New do
              begin
                IND_OPER      := tpEntradaAquisicao;
                IND_EMIT      := edEmissaoPropria;
                COD_PART      := '001';
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
                VL_FRT        := 0;
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
                     NUM_ITEM         := FormatFloat('000', IItens);
                     COD_ITEM         := FormatFloat('000000',StrToInt(NUM_ITEM));
                     DESCR_COMPL      := FormatFloat('NF000000',INotas)+' -> ITEM '+COD_ITEM;
                     QTD              := 1;
                     UNID             := 'UN';
                     VL_ITEM          := 0;
                     VL_DESC          := 0;
                     IND_MOV          := mfNao;
                     CST_ICMS         := sticmsTributadaIntegralmente;
                     CFOP             := '1252';
                     COD_NAT          := '64';
                     VL_BC_ICMS       := 0;
                     ALIQ_ICMS        := 0;
                     VL_ICMS          := 0;
                     VL_BC_ICMS_ST    := 0;
                     ALIQ_ST          := 0;
                     VL_ICMS_ST       := 0;
                     IND_APUR         := iaMensal;
                     CST_IPI          := stipiEntradaIsenta;
                     COD_ENQ          := '';
                     VL_BC_IPI        := 0;
                     ALIQ_IPI         := 0;
                     VL_IPI           := 0;
                     CST_PIS          := stpisOutrasOperacoesSaida;
                     VL_BC_PIS        := 0;
                     ALIQ_PIS_PERC    := 0;
                     QUANT_BC_PIS     := 0;
                     ALIQ_PIS_R       := 0;
                     VL_PIS           := 0;
                     CST_COFINS       := stcofinsOutrasOperacoesSaida;
                     VL_BC_COFINS     := 0;
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
                     COD_MOD := '';
                     DT_REF_INI := Date;
                     DT_REF_FIN := Date;
                     COD_ITEM := '';
                     COD_NCM := '';
                     EX_IPI := '';
                     VL_TOT_ITEM := 0;
                  end;//Fim dos Itens;
                end;
              end;

              if cbConcomitante.Checked then
              begin
                 if (INotas mod BNotas) = 0 then   // Gravar a cada N notas
                 begin
                    // Grava registros na memoria para o TXT, e limpa memoria
                    ACBrSPEDPisCofins1.WriteBloco_C( False );  // False, NAO fecha o Bloco
                    ProgressBar1.Position := INotas;
                    Application.ProcessMessages;
                 end;
              end;
           end;   
         end;
      end;
   end;

   if cbConcomitante.Checked then
   begin
      ACBrSPEDPisCofins1.WriteBloco_C(True);  // True, fecha o Bloco
      LoadToMemo;
   end;

   ProgressBar1.Visible := False ;
end;

procedure TFrmSPEDPisCofins.btnB_DClick(Sender: TObject);
begin
   // Alimenta o componente com informações para gerar todos os registros do
   // Bloco D.
//   with ACBrSPEDPisCofins1.Bloco_D do
//   begin
//      with RegistroD001New do
//      begin
//        IND_MOV := 1;
//      end;
//   end;
   btnB_D.Enabled := false;

   if cbConcomitante.Checked then
   begin
      ACBrSPEDPisCofins1.WriteBloco_D;
      LoadToMemo;
   end;
end;

procedure TFrmSPEDPisCofins.edtFileChange(Sender: TObject);
begin
   ACBrSPEDPisCofins1.Arquivo := edtFile.Text ;
end;

procedure TFrmSPEDPisCofins.LoadToMemo;
begin
   memoTXT.Lines.Clear;
   if FileExists( ACBrSPEDPisCofins1.Path + ACBrSPEDPisCofins1.Arquivo ) then
      memoTXT.Lines.LoadFromFile(ACBrSPEDPisCofins1.Path + ACBrSPEDPisCofins1.Arquivo);
end;

procedure TFrmSPEDPisCofins.cbConcomitanteClick(Sender: TObject);
begin
   btnTXT.Enabled   := not cbConcomitante.Checked ;
   btnError.Enabled := btnTXT.Enabled ;

   edBufNotas.Enabled := cbConcomitante.Checked ;

   if not cbConcomitante.Checked then
   begin
      btnB_0.Enabled := True ;
      btnB_A.Enabled := False ;
      btnB_C.Enabled := False ;
      btnB_D.Enabled := False ;
      btnB_F.Enabled := False ;
      btnB_M.Enabled := False ;
      btnB_1.Enabled := False ;
      btnB_9.Enabled := False ;
   end;
end;

procedure TFrmSPEDPisCofins.btnB_FClick(Sender: TObject);
begin
   // Alimenta o componente com informações para gerar todos os registros do
   // Bloco F.
   with ACBrSPEDPisCofins1.Bloco_F do
   begin
      with RegistroF001New do
      begin
        IND_MOV := imComDados;
        with RegistroF010New do
        begin
           CNPJ := '123456789';
           with RegistroF100New do
           begin
              IND_OPER      := indRepCustosDespesasEncargos;
              COD_PART      := '001';
              COD_ITEM      := '000'; //Codigo do Item no registro 0200
              DT_OPER       := Date();
              VL_OPER       := 0;
              CST_PIS       := stpisOutrasOperacoesSaida;
              VL_BC_PIS     := 0;
              ALIQ_PIS      := 0;
              VL_PIS        := 0;
              CST_COFINS    := stcofinsOutrasOperacoesSaida;
              VL_BC_COFINS  := 0;
              ALIQ_COFINS   := 0;
              VL_COFINS     := 0;
              NAT_BC_CRED   := bccAqBensRevenda;
              IND_ORIG_CRED := opcMercadoInterno;
              COD_CTA       := '';
              COD_CCUS      := '123';
              DESC_DOC_OPER := ''; 
           end;
        end;
      end;
   end;
   btnB_F.Enabled := false;

   if cbConcomitante.Checked then
   begin
      ACBrSPEDPisCofins1.WriteBloco_F;
      LoadToMemo;
   end;
end;

procedure TFrmSPEDPisCofins.btnB_MClick(Sender: TObject);
begin
   // Alimenta o componente com informações para gerar todos os registros do
   // Bloco M.
   with ACBrSPEDPisCofins1.Bloco_M do
   begin
      with RegistroM001New do
      begin
        IND_MOV := imComDados;
         with RegistroM100New do
         begin
            COD_CRED       := '';
            IND_CRED_ORI   := TACBrIndCredOri(0);
            VL_BC_PIS      := 0;
            ALIQ_PIS       := 0;
            QUANT_BC_PIS   := 0;
            ALIQ_PIS_QUANT := 0;
            VL_CRED        := 0;
            VL_AJUS_ACRES  := 0;
            VL_AJUS_REDUC  := 0;
            VL_CRED_DIF    := 0;
            VL_CRED_DISP   := 0;
            IND_DESC_CRED  := TACBrIndDescCred(0);
            VL_CRED_DESC   := 0;
            SLD_CRED       := 0;
         end;
      end;
   end;
   btnB_M.Enabled := false;

   if cbConcomitante.Checked then
   begin
      ACBrSPEDPisCofins1.WriteBloco_M;
      LoadToMemo;
   end;
end;

procedure TFrmSPEDPisCofins.btnB_AClick(Sender: TObject);
var
INotas: Integer;
IItens: Integer;
NNotas: Integer;
BNotas: Integer;
begin
   // Alimenta o componente com informações para gerar todos os registros do
   // Bloco A.
   btnB_A.Enabled := false;

   NNotas := StrToInt64Def(edNotas.Text,1);
   BNotas := StrToInt64Def(edBufNotas.Text,1);

   ProgressBar1.Visible := cbConcomitante.Checked ;
   ProgressBar1.Max     := NNotas;
   ProgressBar1.Position:= 0 ;

   with ACBrSPEDPisCofins1.Bloco_A do
   begin
      with RegistroA001New do
      begin
         IND_MOV := imComDados;
         //
         for INotas := 1 to NNotas do
         begin
           with RegistroA010New do
           begin
              CNPJ := '123456789';
              with RegistroA100New do
              begin
                 IND_OPER      := itoContratado;
                 IND_EMIT      := iedfProprio;
                 COD_PART      := '001';
                 COD_SIT       := sdfRegular;
                 SER           := '';
                 SUB           := '';
                 NUM_DOC       := FormatFloat('NF000000',INotas);
                 CHV_NFSE      := '';
                 DT_DOC        := Date();
                 DT_EXE_SERV   := Date();
                 VL_DOC        := 0;
                 IND_PGTO      := tpSemPagamento;
                 VL_DESC       := 0;
                 VL_BC_PIS     := 0;
                 VL_PIS        := 0;
                 VL_BC_COFINS  := 0;
                 VL_COFINS     := 0;
                 VL_PIS_RET    := 0;
                 VL_COFINS_RET := 0;
                 VL_ISS        := 0;
                 //A170
                 for IItens := 1 to 10 do
                 begin
                   with RegistroA170New do   //Inicio Adicionar os Itens:
                   begin
                      NUM_ITEM         := IItens;
                      COD_ITEM         := IntToStr(NUM_ITEM);
                      DESCR_COMPL      := FormatFloat('NF000000',INotas)+' -> ITEM '+COD_ITEM;
                      VL_ITEM          := 0;
                      VL_DESC          := 0;
                      NAT_BC_CRED      := bccAqBensRevenda;
                      IND_ORIG_CRED    := opcMercadoInterno;
                      CST_PIS          := stpisOutrasOperacoesSaida;
                      VL_BC_PIS        := 0;
                      ALIQ_PIS         := 0;
                      VL_PIS           := 0;
                      CST_COFINS       := stcofinsOutrasOperacoesSaida;
                      VL_BC_COFINS     := 0;
                      ALIQ_COFINS      := 0;
                      VL_COFINS        := 0;
                      COD_CTA          := '000';
                      COD_CCUS         := '123';
                    end; //Fim dos Itens;
                 end;
              end;
              if cbConcomitante.Checked then
              begin
                 if (INotas mod BNotas) = 0 then   // Gravar a cada N notas
                 begin
                    // Grava registros na memoria para o TXT, e limpa memoria
                    ACBrSPEDPisCofins1.WriteBloco_A( False );  // False, NAO fecha o Bloco
                    ProgressBar1.Position := INotas;
                    Application.ProcessMessages;
                 end;
              end;
           end;
         end;
      end;
   end;
   if cbConcomitante.Checked then
   begin
      ACBrSPEDPisCofins1.WriteBloco_A(True);  // True, fecha o Bloco
      LoadToMemo;
   end;

   ProgressBar1.Visible := False ;   
end;

end.
