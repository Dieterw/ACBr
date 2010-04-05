{******************************************************************************}
{ Projeto: Componentes ACBr                                                    }
{  Biblioteca multiplataforma de componentes Delphi para interação com equipa- }
{ mentos de Automação Comercial utilizados no Brasil                           }
{                                                                              }
{ Direitos Autorais Reservados (c) 2009   Isaque Pinheiro                      }
{                                                                              }
{ Colaboradores nesse arquivo:                                                 }
{                                                                              }
{  Você pode obter a última versão desse arquivo na pagina do  Projeto ACBr    }
{ Componentes localizado em      http://www.sourceforge.net/projects/acbr      }
{                                                                              }
{  Esta biblioteca é software livre; você pode redistribuí-la e/ou modificá-la }
{ sob os termos da Licença Pública Geral Menor do GNU conforme publicada pela  }
{ Free Software Foundation; tanto a versão 2.1 da Licença, ou (a seu critério) }
{ qualquer versão posterior.                                                   }
{                                                                              }
{  Esta biblioteca é distribuída na expectativa de que seja útil, porém, SEM   }
{ NENHUMA GARANTIA; nem mesmo a garantia implícita de COMERCIABILIDADE OU      }
{ ADEQUAÇÃO A UMA FINALIDADE ESPECÍFICA. Consulte a Licença Pública Geral Menor}
{ do GNU para mais detalhes. (Arquivo LICENÇA.TXT ou LICENSE.TXT)              }
{                                                                              }
{  Você deve ter recebido uma cópia da Licença Pública Geral Menor do GNU junto}
{ com esta biblioteca; se não, escreva para a Free Software Foundation, Inc.,  }
{ no endereço 59 Temple Street, Suite 330, Boston, MA 02111-1307 USA.          }
{ Você também pode obter uma copia da licença em:                              }
{ http://www.opensource.org/licenses/lgpl-license.php                          }
{                                                                              }
{ Daniel Simões de Almeida  -  daniel@djsystem.com.br  -  www.djsystem.com.br  }
{              Praça Anita Costa, 34 - Tatuí - SP - 18270-410                  }
{                                                                              }
{******************************************************************************}

{******************************************************************************
|* Historico
|*
|* 10/04/2009: Isaque Pinheiro
|*  - Criação e distribuição da Primeira Versao
|* 21/02/2010: EMSoft Sistemas Ltda - RJ
|*  - Criação deste Demo
*******************************************************************************}

unit uFormPrincipal;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ACBrUtilTXT, ACBrPAF, ACBrPAF_D, ACBrPAF_E, ACBrPAF_P,
  ACBrPAF_R, ACBrPAF_T, ACBrPAFRegistros, Math;

type
  TForm6 = class(TForm)
    GroupBox1: TGroupBox;
    ACBrPAF: TACBrPAF;
    Label1: TLabel;
    edtUF: TEdit;
    Label2: TLabel;
    edtCNPJ: TEdit;
    Label3: TLabel;
    edtIE: TEdit;
    edtIM: TEdit;
    Label4: TLabel;
    edtRAZAO: TEdit;
    Label5: TLabel;
    GroupBox2: TGroupBox;
    logErros: TMemo;
    btnD: TButton;
    btnE: TButton;
    btnP: TButton;
    btnR: TButton;
    btnT: TButton;
    procedure btnDClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure PreencherHeader(Header: TRegistroX1);
    function GerarDados(Tipo: Char; Tam: integer): Variant;
    procedure btnEClick(Sender: TObject);
    procedure btnPClick(Sender: TObject);
    procedure btnRClick(Sender: TObject);
    procedure btnTClick(Sender: TObject);
    procedure ACBrPAFMsnError(const MsnError: String);
    procedure ACBrPAFPAFCalcEAD(Arquivo: String);
  private
    { Private declarations }
    function QualquerNumero: Integer;
    function QualquerChar: Char;
  public
    { Public declarations }
  end;

var
  Form6: TForm6;

implementation

const
     NUM_FAB      = 'NUMFAB78901234567890';
     MF_ADICIONAL = '';
     TIPO_ECF     = 'ECF-IF';
     MARCA_ECF    = 'ACBr';
     MODELO_ECF   = 'PAF';

{$R *.dfm}

procedure TForm6.FormShow(Sender: TObject);
begin
     // os relatorios PAF estes parâmetros não são necessários
//     ACBrPAF.CurMascara :='';
//     ACBrPAF.Delimitador:='';

     edtCNPJ.Text:=GerarDados('I',14);
     edtIE.Text:=GerarDados('I',14);
     edtIM.Text:=GerarDados('I',14);
end;

function TForm6.GerarDados(Tipo: Char; Tam: integer): Variant;
var
     i: integer;
     sTmp: String;
     R: Variant;
begin
     if Tipo='S' then begin
        sTmp:='';
        for I := 1 to Tam do sTmp:=sTmp+QualquerChar;
        R:=sTmp;
     end;
     if Tipo='I' then begin
        sTmp:='';
        for I := 1 to Tam do sTmp:=sTmp+IntToStr(QualquerNumero);
        R:=StrToInt64(sTmp);
     end;
     Result:=R;
end;

function TForm6.QualquerNumero: Integer;
begin
     Result:=Random(9); // 0..9
end;

function TForm6.QualquerChar: Char;
begin
     Result:=Chr(RandomRange(65,90)); // A..Z
end;

procedure TForm6.PreencherHeader(Header: TRegistroX1);
begin
     // o header dos relatórios PAF a maioria são todos iguais
     Header.UF         :=edtUF.Text;
     Header.CNPJ       :=edtCNPJ.Text;
     Header.IE         :=edtIE.Text;
     Header.IM         :=edtIM.Text;
     Header.RAZAOSOCIAL:=edtRAZAO.Text;
end;

procedure TForm6.btnDClick(Sender: TObject);
var
     D2: TRegistroD2;
     i: integer;
begin
     // registro D1
     PreencherHeader(ACBrPAF.PAF_D.RegistroD1); // preencher header do arquivo
     // registro D2
     ACBrPAF.PAF_D.RegistroD2.Clear;
     for I := 1 to 15 do
     begin
       D2:=ACBrPAF.PAF_D.RegistroD2.New;
       D2.NUM_FAB     :=NUM_FAB;
       D2.MF_ADICIONAL:=MF_ADICIONAL;
       D2.TIPO_ECF    :=TIPO_ECF;
       D2.MARCA_ECF   :=MARCA_ECF;
       D2.MODELO_ECF  :=MODELO_ECF;
       D2.COO         :=IntToStr(I*QualquerNumero);
       D2.NUM_DAV     :=IntToStr(I*QualquerNumero);
       D2.DT_DAV      :=Date-QualquerNumero;
       D2.TIT_DAV     :='Pedido';
       D2.VLT_DAV     :=GerarDados('I',2);
       D2.CCF         :=''; // não está no layout do ato/cotepe
     end;
     ACBrPAF.SaveFileTXT_D('PAF_D.txt');
end;



procedure TForm6.btnEClick(Sender: TObject);
var
     E2: TRegistroE2;
     i: integer;
begin
     // registro E1
     PreencherHeader(ACBrPAF.PAF_E.RegistroE1); // preencher header do arquivo
     // registro E2
     ACBrPAF.PAF_E.RegistroE2.Clear;
     for I := 1 to 15 do
     begin
       E2:=ACBrPAF.PAF_E.RegistroE2.New;
       E2.COD_MERC :=GerarDados('I',14);
       E2.DESC_MERC:=GerarDados('S',50);
       E2.UN_MED   :=GerarDados('S',2);
       E2.QTDE_EST :=GerarDados('I',3);
       E2.DT_EST   :=Date;
     end;
     ACBrPAF.SaveFileTXT_E('PAF_E.txt');
end;

procedure TForm6.btnPClick(Sender: TObject);
var
     P2: TRegistroP2;
     i: integer;
begin
     // registro P1
     PreencherHeader(ACBrPAF.PAF_P.RegistroP1); // preencher header do arquivo
     // registro P2
     ACBrPAF.PAF_P.RegistroP2.Clear;
     for I := 1 to 15 do
     begin
       P2:=ACBrPAF.PAF_P.RegistroP2.New;
       P2.COD_MERC_SERV :=GerarDados('I',14);
       P2.DESC_MERC_SERV:=GerarDados('S',50);
       P2.UN_MED        :=GerarDados('S',2);
       P2.IAT           :='A';
       P2.IPPT          :='T';
       P2.ST            :='FF';
       P2.ALIQ          :=0;
       P2.VL_UNIT       :=GerarDados('I',2);
     end;
     ACBrPAF.SaveFileTXT_P('PAF_P.txt');
end;

procedure TForm6.btnRClick(Sender: TObject);
var
     i,j: integer;
begin
     // Registro R1
     with ACBrPAF.PAF_R.RegistroR01 do
     begin
        // Comentei porque atribuindo as constantes ao gerar o R02 as propriedades
        // estavam vazias, não sei porque ?????

        // Descobri, é porque as constantes tem o mesmo noma das propriedades
        // ai ele ta buscando o valor das proprias propriedades e não das contantes.
        NUM_FAB     :='NUMFAB78901234567890'; //NUM_FAB;
        MF_ADICIONAL:=''; // MF_ADICIONAL;
        TIPO_ECF    :='ECF-IF'; // TIPO_ECF;
        MARCA_ECF   :='ACBr'; //MARCA_ECF;
        MODELO_ECF  :='PAF'; //MODELO_ECF;
        VERSAO_SB   :='010101';
        DT_INST_SB  :=date;
        HR_INST_SB  :=time;
        NUM_SEQ_ECF :=1;
        CNPJ        :=edtCNPJ.Text;
        IE          :=edtIE.Text;
        CNPJ_SH     :=edtCNPJ.Text;
        IE_SH       :=edtIE.Text;
        IM_SH       :=edtIM.Text;
        NOME_SH     :=edtRAZAO.Text;
        NOME_PAF    :='PAFECF';
        VER_PAF     :='0100';
        COD_MD5     :=GerarDados('S',32);
        DT_INI      :=Date;
        DT_FIN      :=date;
        ER_PAF_ECF  :='0104';
     end;
     // Registro R02 e R03
     for I := 1 to 10 do
     begin
       with ACBrPAF.PAF_R.RegistroR02.New do
       begin
          NUM_USU     :=1;
          CRZ         :=GerarDados('I',3);
          COO         :=GerarDados('I',3);
          CRO         :=GerarDados('I',3);
          DT_MOV      :=DATE;
          DT_EMI      :=DATE;
          HR_EMI      :=TIME;
          VL_VBD      :=GerarDados('I',3);
          PAR_ECF     :='';
          // Registro R03 - FILHO
          for J := 1 to 5 do
          begin
            with RegistroR03.New do
            begin
               TOT_PARCIAL :=GerarDados('S',2);
               VL_ACUM     :=GerarDados('I',2);
            end;
          end;
       end;
     end;
     // Registro R04 e R05
     for I := 1 to 10 do
     begin
       with ACBrPAF.PAF_R.RegistroR04.New do
       begin
          NUM_USU     :=1;
          NUM_CONT    :=GerarDados('I',3);
          COO         :=GerarDados('I',3);
          DT_INI      :=date;
          SUB_DOCTO   :=GerarDados('I',2);
          SUB_DESCTO  :=GerarDados('I',2);
          TP_DESCTO   :='V';
          SUB_ACRES   :=0;
          TP_ACRES    :='V';
          VL_TOT      :=GerarDados('I',2);
          CANC        :='N';
          VL_CA       :=0;
          ORDEM_DA    :='D';
          NOME_CLI    :=GerarDados('S',50);
          CNPJ_CPF    :=GerarDados('I',12);
          // Registro R05 - FILHO
          for J := 1 to RandomRange(1,4) do
          begin
            with RegistroR05.New do
            begin
               NUM_ITEM     :=J;
               COD_ITEM     :=GerarDados('I',14);
               DESC_ITEM    :=GerarDados('S',50);
               QTDE_ITEM    :=RandomRange(1,4);
               UN_MED       :=GerarDados('S',2);
               VL_UNIT      :=GerarDados('I',2);
               DESCTO_ITEM  :=0;
               ACRES_ITEM   :=0;
               VL_TOT_ITEM  :=GerarDados('I',2);
               COD_TOT_PARC :='FF';
               IND_CANC     :='N';
               QTDE_CANC    :=0;
               VL_CANC      :=0;
               VL_CANC_ACRES:=0;
               IAT          :='A';
               IPPT         :='T';
               QTDE_DECIMAL :=2;
               VL_DECIMAL   :=2;
            end;
          end;
       end;
     end;
     // Registro R06 e R07
     for I := 1 to 10 do
     begin
       with ACBrPAF.PAF_R.RegistroR06.New do
       begin
          NUM_USU     :=1;
          COO         :=GerarDados('I',3);
          GNF         :=GerarDados('I',3);
          GRG         :=GerarDados('I',3);
          CDC         :=GerarDados('I',3);
          DENOM       :=GerarDados('S',2);
          DT_FIN      :=date;
          HR_FIN      :=date;
          // Registro R07 - FILHO
          for J := 1 to 3 do
          begin
            with RegistroR07.New do
            begin
               CCF         :=GerarDados('I',3);
               MP          :=GerarDados('S',7);
               VL_PAGTO    :=GerarDados('I',2);
               IND_EST     :='N';
               VL_EST      :=0;
            end;
          end;
       end;
     end;
     ACBrPAF.SaveFileTXT_R('PAF_R.txt');
end;

procedure TForm6.btnTClick(Sender: TObject);
var
     i: integer;
begin
     // registro T1
     PreencherHeader(ACBrPAF.PAF_T.RegistroT1); // preencher header do arquivo
     // registro T2
     ACBrPAF.PAF_T.RegistroT2.Clear;
     for I := 1 to 15 do
     begin
       with ACBrPAF.PAF_T.RegistroT2.New do
       begin
          DT_MOV     :=date;
          TP_DOCTO   :=''; // não faz parte do ato/cotepe
          SERIE      :=GerarDados('S',2);
          NUM_BILH_I :=GerarDados('I',2);
          NUM_BILH_F :=GerarDados('I',3);
          NUM_ECF    :='001';
          CRZ        :=GerarDados('I',3);
          CFOP       :='5102';
          VL_CONT    :=GerarDados('I',3);
          VL_BASECALC:=GerarDados('I',3);
          ALIQ       :=GerarDados('I',1);
          VL_IMPOSTO :=GerarDados('I',3);
          VL_ISENTAS :=GerarDados('I',3);
          VL_OUTRAS  :=GerarDados('I',3);
       end;
     end;
     ACBrPAF.SaveFileTXT_T('PAF_T.txt');
end;

procedure TForm6.ACBrPAFMsnError(const MsnError: String);
begin
     logErros.Lines.Add(MsnError); // captura os erros encontrados pelo ACBrPAF
end;

procedure TForm6.ACBrPAFPAFCalcEAD(Arquivo: String);
begin
//
end;

end.

