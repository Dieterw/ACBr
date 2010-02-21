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
    procedure ACBrPAFError(const MsnError: AnsiString);
    procedure btnDClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure PreencherHeader(Header: TRegistroX1);
    function GerarDados(Tipo: Char; Tam: integer): Variant;
    procedure btnEClick(Sender: TObject);
    procedure btnPClick(Sender: TObject);
    procedure btnRClick(Sender: TObject);
    procedure btnTClick(Sender: TObject);
  private
    { Private declarations }
    function QualquerNumero: Integer;
    function QualquerChar: Char;
  public
    { Public declarations }
  end;

const
     NUM_FAB      = 'NUMFAB78901234567890';
     MF_ADICIONAL = '';
     TIPO_ECF     = 'ECF-IF';
     MARCA_ECF    = 'ACBr';
     MODELO_ECF   = 'PAF';


var
  Form6: TForm6;

implementation

{$R *.dfm}

procedure TForm6.FormShow(Sender: TObject);
begin
     // os relatorios PAF estes parâmetros não são necessários
     ACBrPAF.CurMascara :='';
     ACBrPAF.Delimitador:='';
     ACBrPAF.AssDigital:=GerarDados('S',256); // esta linha deverá ser retirada do arquivo e colocar o seu EAD q só pode ser calculada após a geração do arquivo.

     edtCNPJ.Text:=GerarDados('I',14);
     edtIE.Text:=GerarDados('I',14);
     edtIM.Text:=GerarDados('I',14);
end;

procedure TForm6.ACBrPAFError(const MsnError: AnsiString);
begin
     logErros.Lines.Add(MsnError); // captura os erros encontrados pelo ACBrPAF
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
//     ACBrPAF.AssDigital:=GerarDados('S',256); // esta linha deverá ser retirada do arquivo e colocar o seu EAD q só pode ser calculada após a geração do arquivo.
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
       E2.NUM_FAB  :=NUM_FAB;
       E2.COD_MERC :=GerarDados('I',14);
       E2.DESC_MERC:=GerarDados('S',50);
       E2.UN_MED   :=GerarDados('S',2);
       E2.QTDE_EST :=GerarDados('I',3);
       E2.DT_EST   :=Date;
     end;
//     ACBrPAF.AssDigital:=GerarDados('S',256); // esta linha deverá ser retirada do arquivo e colocar o seu EAD q só pode ser calculada após a geração do arquivo.
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
//     ACBrPAF.AssDigital:=GerarDados('S',256); // esta linha deverá ser retirada do arquivo e colocar o seu EAD q só pode ser calculada após a geração do arquivo.
     ACBrPAF.SaveFileTXT_P('PAF_P.txt');
end;

procedure TForm6.btnRClick(Sender: TObject);
var
     R2: TRegistroR02;
     R3: TRegistroR03;
     R4: TRegistroR04;
     R5: TRegistroR05;
     R6: TRegistroR06;
     R7: TRegistroR07;
     i,j: integer;
begin
     // registro R1
     ACBrPAF.PAF_R.RegistroR01.NUM_FAB    :=NUM_FAB;
     ACBrPAF.PAF_R.RegistroR01.MF_ADICONAL:=MF_ADICIONAL;
     ACBrPAF.PAF_R.RegistroR01.TIPO_ECF   :=TIPO_ECF;
     ACBrPAF.PAF_R.RegistroR01.MARCA_ECF  :=MARCA_ECF;
     ACBrPAF.PAF_R.RegistroR01.MODELO_ECF :=MODELO_ECF;
     ACBrPAF.PAF_R.RegistroR01.VERSAO_SB  :='010101';
     ACBrPAF.PAF_R.RegistroR01.DT_INST_SB :=date;
     ACBrPAF.PAF_R.RegistroR01.HR_INST_SB :=time;
     ACBrPAF.PAF_R.RegistroR01.NUM_SEQ_ECF:=1;
     ACBrPAF.PAF_R.RegistroR01.CNPJ       :=edtCNPJ.Text;
     ACBrPAF.PAF_R.RegistroR01.IE         :=edtIE.Text;
     ACBrPAF.PAF_R.RegistroR01.CNPJ_SH    :=edtCNPJ.Text;
     ACBrPAF.PAF_R.RegistroR01.IE_SH      :=edtIE.Text;
     ACBrPAF.PAF_R.RegistroR01.IM_SH      :=edtIM.Text;
     ACBrPAF.PAF_R.RegistroR01.NOME_SH    :=edtRAZAO.Text;
     ACBrPAF.PAF_R.RegistroR01.NOME_PAF   :='PAFECF';
     ACBrPAF.PAF_R.RegistroR01.VER_PAF    :='0100';
     ACBrPAF.PAF_R.RegistroR01.COD_MD5    :=GerarDados('S',32);
     ACBrPAF.PAF_R.RegistroR01.DT_INI     :=Date;
     ACBrPAF.PAF_R.RegistroR01.DT_FIN     :=date;
     ACBrPAF.PAF_R.RegistroR01.ER_PAF_ECF :='0104';
     // registro R02 e R03
     ACBrPAF.PAF_R.RegistroR02.Clear;
     ACBrPAF.PAF_R.RegistroR03.Clear;
     for I := 1 to 10 do
     begin
       R2:=ACBrPAF.PAF_R.RegistroR02.New;
       R2.NUM_FAB     :=NUM_FAB;
       R2.MF_ADICIONAL:=MF_ADICIONAL;
       R2.MODELO_ECF  :=MODELO_ECF;
       R2.NUM_USU     :=1;
       R2.CRZ         :=GerarDados('I',3);
       R2.COO         :=GerarDados('I',3);
       R2.CRO         :=GerarDados('I',3);
       R2.DT_MOV      :=DATE;
       R2.DT_EMI      :=DATE;
       R2.HR_EMI      :=TIME;
       R2.VL_VBD      :=GerarDados('I',3);
       R2.PAR_ECF     :='';
       // registro R03 - colocado dentro do for do R02 porque o R03 são os detalhes do R02
       for J := 1 to 5 do
       begin
         R3:=ACBrPAF.PAF_R.RegistroR03.New;
         R3.NUM_FAB     :=R2.NUM_FAB;
         R3.MF_ADICIONAL:=R2.MF_ADICIONAL;
         R3.MODELO_ECF  :=R2.MODELO_ECF;
         R3.NUM_USU     :=R2.NUM_USU;
         R3.CRZ         :=R2.CRZ;
         R3.TOT_PARCIAL :=GerarDados('S',2);
         R3.VL_ACUM     :=GerarDados('I',2);
       end;
     end;
     // Registro R04 e R05
     ACBrPAF.PAF_R.RegistroR04.Clear;
     ACBrPAF.PAF_R.RegistroR05.Clear;
     for I := 1 to 10 do
     begin
       R4:=ACBrPAF.PAF_R.RegistroR04.New;
       R4.NUM_FAB     :=NUM_FAB;
       R4.MF_ADICIONAL:=MF_ADICIONAL;
       R4.MODELO_ECF  :=MODELO_ECF;
       R4.NUM_USU     :=1;
       R4.NUM_CONT    :=GerarDados('I',3);
       R4.COO         :=GerarDados('I',3);
       R4.DT_INI      :=date;
       R4.SUB_DOCTO   :=GerarDados('I',2);
       R4.SUB_DESCTO  :=GerarDados('I',2);
       R4.TP_DESCTO   :='V';
       R4.SUB_ACRES   :=0;
       R4.TP_ACRES    :='V';
       R4.VL_TOT      :=GerarDados('I',2);
       R4.CANC        :='N';
       R4.VL_CA       :=0;
       R4.ORDEM_DA    :='D';
       R4.NOME_CLI    :=GerarDados('S',50);
       R4.CNPJ_CPF    :=GerarDados('I',12);
       // Registro R05
       for J := 1 to RandomRange(1,4) do
       begin
         R5:=ACBrPAF.PAF_R.RegistroR05.New;
         R5.NUM_FAB      :=R4.NUM_FAB;
         R5.MF_ADICIONAL :=R4.MF_ADICIONAL;
         R5.MODELO_ECF   :=R4.MODELO_ECF;
         R5.NUM_USU      :=R4.NUM_USU;
         R5.COO          :=R4.COO;
         R5.NUM_CONT     :=R4.NUM_CONT;
         R5.NUM_ITEM     :=J;
         R5.COD_ITEM     :=GerarDados('I',14);
         R5.DESC_ITEM    :=GerarDados('S',50);
         R5.QTDE_ITEM    :=RandomRange(1,4);
         R5.UN_MED       :=GerarDados('S',2);
         R5.VL_UNIT      :=GerarDados('I',2);
         R5.DESCTO_ITEM  :=0;
         R5.ACRES_ITEM   :=0;
         R5.VL_TOT_ITEM  :=GerarDados('I',2);
         R5.COD_TOT_PARC :='FF';
         R5.IND_CANC     :='N';
         R5.QTDE_CANC    :=0;
         R5.VL_CANC      :=0;
         R5.VL_CANC_ACRES:=0;
         R5.IAT          :='A';
         R5.IPPT         :='T';
         R5.QTDE_DECIMAL :=2;
         R5.VL_DECIMAL   :=2;
       end;
     end;
     // Registro R06 e R07
     ACBrPAF.PAF_R.RegistroR06.Clear;
     ACBrPAF.PAF_R.RegistroR07.Clear;
     for I := 1 to 10 do
     begin
       R6:=ACBrPAF.PAF_R.RegistroR06.New;
       R6.NUM_FAB     :=NUM_FAB;
       R6.MF_ADICIONAL:=MF_ADICIONAL;
       R6.MODELO_ECF  :=MODELO_ECF;
       R6.NUM_USU     :=1;
       R6.NUM_CONT    :=GerarDados('I',3);
       R6.COO         :=GerarDados('I',3);
       R6.GNF         :=GerarDados('I',3);
       R6.GRG         :=GerarDados('I',3);
       R6.CDC         :=GerarDados('I',3);
       R6.DENOM       :=GerarDados('S',2);
       R6.DT_FIN      :=date;
       R6.HR_FIN      :=date;
       // Registro R07
       for J := 1 to 3 do
       begin
         R7:=ACBrPAF.PAF_R.RegistroR07.New;
         R7.NUM_FAB     :=R6.NUM_FAB;
         R7.MF_ADICIONAL:=R6.MF_ADICIONAL;
         R7.MODELO_ECF  :=R6.MODELO_ECF;
         R7.NUM_USU     :=R6.NUM_USU;
         R7.NUM_CONT    :=R6.NUM_CONT;
         R7.COO         :=R6.COO;
         R7.CCF         :=GerarDados('I',3);
         R7.GNF         :=R6.GNF;
         R7.MP          :=GerarDados('S',7);
         R7.VL_PAGTO    :=GerarDados('I',2);
         R7.IND_EST     :='N';
         R7.VL_EST      :=0;
       end;
     end;

//     ACBrPAF.AssDigital:=GerarDados('S',256); // esta linha deverá ser retirada do arquivo e colocar o seu EAD q só pode ser calculada após a geração do arquivo.
     ACBrPAF.SaveFileTXT_R('PAF_R.txt');
end;

procedure TForm6.btnTClick(Sender: TObject);
var
     T2: TRegistroT2;
     i: integer;
begin
     // registro T1
     PreencherHeader(ACBrPAF.PAF_T.RegistroT1); // preencher header do arquivo
     // registro T2
     ACBrPAF.PAF_T.RegistroT2.Clear;
     for I := 1 to 15 do
     begin
       T2:=ACBrPAF.PAF_T.RegistroT2.New;
       T2.DT_MOV     :=date;
       T2.TP_DOCTO   :=''; // não faz parte do ato/cotepe
       T2.SERIE      :=GerarDados('S',2);
       T2.NUM_BILH_I :=GerarDados('I',2);
       T2.NUM_BILH_F :=GerarDados('I',3);
       T2.NUM_ECF    :='001';
       T2.CRZ        :=GerarDados('I',3);
       T2.CFOP       :='5102';
       T2.VL_CONT    :=GerarDados('I',3);
       T2.VL_BASECALC:=GerarDados('I',3);
       T2.ALIQ       :=GerarDados('I',1);
       T2.VL_IMPOSTO :=GerarDados('I',3);
       T2.VL_ISENTAS :=GerarDados('I',3);
       T2.VL_OUTRAS  :=GerarDados('I',3);
     end;
//     ACBrPAF.AssDigital:=GerarDados('S',256); // esta linha deverá ser retirada do arquivo e colocar o seu EAD q só pode ser calculada após a geração do arquivo.
     ACBrPAF.SaveFileTXT_T('PAF_T.txt');
end;

end.

