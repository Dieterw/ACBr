{******************************************************************************}
{ Projeto: Componente ACBrNFe                                                  }
{  Biblioteca multiplataforma de componentes Delphi para emissão de Nota Fiscal}
{ eletrônica - NFe - http://www.nfe.fazenda.gov.br                          }
{                                                                              }
{ Direitos Autorais Reservados (c) 2008 Wemerson Souto                         }
{                                       Daniel Simoes de Almeida               }
{                                       André Ferreira de Moraes               }
{                                                                              }
{ Colaboradores nesse arquivo:                                                 }
{                                                                              }
{  Você pode obter a última versão desse arquivo na pagina do Projeto ACBr     }
{ Componentes localizado em http://www.sourceforge.net/projects/acbr           }
{                                                                              }
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
|* 16/12/2008: Wemerson Souto
|*  - Doação do componente para o Projeto ACBr
|* 09/03/2009: Dulcemar P.Zilli
|*  - Correcao impressão informações IPI
|* 11/03/2008: Dulcemar P.Zilli
|*  - Inclusão Observações Fisco
|* 11/03/2008: Dulcemar P.Zilli
|*  - Inclusão totais ISSQN
|* 23/06/2009: João H. Souza
|*  - Alterações diversas
******************************************************************************}
{$I ACBr.inc}

unit ACBrNFeDANFERave;

interface

uses Forms, SysUtils, Classes,
  RpDefine, RpDevice, RVClass, RVProj, RVCsBars, RVCsStd, RVCsData,
  RvDirectDataView, RVDataField,
  ACBrNFeDANFEClass, ACBrNFeDANFERaveDM, pcnNFe, pcnConversao;

type
  TACBrNFeDANFERave = class( TACBrNFeDANFEClass )
   private
    dmDanfe : TdmACBrNFeRave;
    FRaveFile: String;
    procedure ExecutaReport;
   public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure ImprimirDANFE(NFE : TNFe = nil); override ;
    procedure ImprimirDANFEPDF(NFE : TNFe = nil); override ;
  published
    property RavFile : String read FRaveFile write FRaveFile ;
  end;

implementation

uses ACBrNFe, ACBrNFeUtil, ACBrUtil, StrUtils, Dialogs;

constructor TACBrNFeDANFERave.Create(AOwner: TComponent);
begin
  inherited create( AOwner );
  dmDanfe := TdmACBrNFeRave.Create(Self);
  FRaveFile := '' ;
end;

destructor TACBrNFeDANFERave.Destroy;
begin

  dmDanfe.Free;
  inherited Destroy ;
end;

procedure TACBrNFeDANFERave.ExecutaReport;
var
   MyReport : TRaveReport;
   MyPage,MyPage2, MyPage3, MyPage4: TRavePage;
   MyBarcode: TRaveCode128BarCode;
   MyDataText01, MyDataText02: TRaveDataText;
   MyDataText1,MyDataText2,MyDataText3,MyDataText4,MyDataText5,MyDataText6: TRaveDataText;
   MyText1,MyText2,MyText3,MyText4: TRaveText;
   MySection: TRaveSection;
   MyDataView: TRaveDataView;
   MyFloatField,MyFloatField2: TRaveFloatField;

   vMargemInferiorAtual, vMargemInferior, vHeightPadrao: double;
begin
   try
      dmDanfe.RvProject.Open;
      with dmDanfe.RvProject.ProjMan do
      begin
         //contingencia
         MyPage := FindRaveComponent('GlobalDANFE',nil) as TRavePage;
         if ((dmDanfe.NFe.Ide.tpEmis = teNormal) or
             (dmDanfe.NFe.Ide.tpEmis = teDPEC) or
             (dmDanfe.NFe.Ide.tpEmis = teSCAN)) then
         begin
            //não exibe código de barras adicional
            MyBarcode := FindRaveComponent('BarCode_Contigencia',MyPage) as TRaveCode128BarCode;
            if (MyBarcode <> nil) then
               MyBarCode.Left := 30;
         end
         else if ((dmDanfe.NFe.Ide.tpEmis = teContingencia) or
                  (dmDanfe.NFe.Ide.tpEmis = teFSDA)) then
         begin
            //não exibe textos
            MyDataText01:=FindRaveComponent('DataText_DANFE1',MyPage) as TRaveDataText;
            MyDataText02:=FindRaveComponent('DataText_DANFE2',MyPage) as TRaveDataText;
            if (MyDataText01 <> nil) then
               MyDataText01.Left := 30;
            if (MyDataText02 <> nil) then
               MyDataText02.Left := 30;
         end;

         //quadro fatura
         if (length(dmDanfe.NFe.Cobr.Fat.nFat) <= 0) then
         begin
            MyPage2 := FindRaveComponent('GlobalFatura',nil) as TRavePage;
            MyText1 := FindRaveComponent('Fatura_nFat_C',MyPage2) as TRaveText;
            MyDataText1 := FindRaveComponent('Fatura_nFat',MyPage2) as TRaveDataText;
            MyText2 := FindRaveComponent('Fatura_vOrig_C',MyPage2) as TRaveText;
            MyDataText2 := FindRaveComponent('Fatura_vOrig',MyPage2) as TRaveDataText;
            MyText3 := FindRaveComponent('Fatura_vDesc_C',MyPage2) as TRaveText;
            MyDataText3 := FindRaveComponent('Fatura_vDesc',MyPage2) as TRaveDataText;
            MyText4 := FindRaveComponent('Fatura_vLiq_C',MyPage2) as TRaveText;
            MyDataText4 := FindRaveComponent('Fatura_vLiq',MyPage2) as TRaveDataText;
            if (MyText1 <> nil) then
               MyText1.Left := 30;
            if (MyText2 <> nil) then
               MyText2.Left := 30;
            if (MyText3 <> nil) then
               MyText3.Left := 30;
            if (MyText4 <> nil) then
               MyText4.Left := 30;
            if (MyDataText1 <> nil) then
               MyDataText1.Left := 30;
            if (MyDataText2 <> nil) then
               MyDataText2.Left := 30;
            if (MyDataText3 <> nil) then
               MyDataText3.Left := 30;
            if (MyDataText4 <> nil) then
               MyDataText4.Left := 30;
         end;

         //Casas Decimais (qCom)
         MyDataView := FindRaveComponent('CustomDadosProdutosCX',nil) as TRaveDataView;
         MyFloatField := FindRaveComponent('CustomDadosProdutosCXQCom',MyDataView) as TRaveFloatField;
         if (MyFloatField <> nil) then
         begin
            if FCasasDecimais._QCom=0 then
               MyFloatField.DisplayFormat:='#0'
            else if FCasasDecimais._QCom=1 then
               MyFloatField.DisplayFormat:='#,#0.0'
            else if FCasasDecimais._QCom=2 then
               MyFloatField.DisplayFormat:='#,##0.00'
            else if FCasasDecimais._QCom=3 then
               MyFloatField.DisplayFormat:='#,###0.000'
            else if FCasasDecimais._QCom=4 then
               MyFloatField.DisplayFormat:='#,####0.0000';
         end;
         //Casas Decimais (vUnCom)
         MyFloatField2 := FindRaveComponent('CustomDadosProdutosCXVUnCom',MyDataView) as TRaveFloatField;
         if (MyFloatField2 <> nil) then
         begin
            if FCasasDecimais._vUnCom=0 then
               MyFloatField2.DisplayFormat:='#0'
            else if FCasasDecimais._vUnCom=1 then
               MyFloatField2.DisplayFormat:='#,#0.0'
            else if FCasasDecimais._vUnCom=2 then
               MyFloatField2.DisplayFormat:='#,##0.00'
            else if FCasasDecimais._vUnCom=3 then
               MyFloatField2.DisplayFormat:='#,###0.000'
            else if FCasasDecimais._vUnCom=4 then
               MyFloatField2.DisplayFormat:='#,####0.0000';
         end;

         //Margem Inferior
         MyReport := FindRaveComponent('DANFE1',nil) as TRaveReport;
         MyPage3 := FindRaveComponent('Page1',MyReport) as TRavePage;
         MyDataText5 := FindRaveComponent('DataText1',MyPage3) as TRaveDataText;
         MyDataText6 := FindRaveComponent('DataText2',MyPage3) as TRaveDataText;
         MyPage4 := FindRaveComponent('GlobalDadosAdicionais',nil) as TRavePage;
         MySection := FindRaveComponent('Section_DadosAdicionais',MyPage4) as TRaveSection;
         if (MyDataText5 <> nil) then
         begin
            vMargemInferiorAtual:=(MyPage3.PageHeight-MyDataText5.Top);
            vHeightPadrao:=MyDataText5.Height;
         end
         else
         begin
            vMargemInferiorAtual:=0.8/2.54;
            vHeightPadrao:=0;
         end;
         vMargemInferior := FMargemInferior/2.54;
         if (MyDataText5 <> nil) then
            MyDataText5.Top := MyDataText5.Top-vHeightPadrao-(vMargemInferior-vMargemInferiorAtual);
         if (MyDataText6 <> nil) then
            MyDataText6.Top := MyDataText6.Top-vHeightPadrao-(vMargemInferior-vMargemInferiorAtual);
         if (MySection <> nil) then
            MySection.Height := MySection.Height-vHeightPadrao-(vMargemInferior-vMargemInferiorAtual);
      end;
   finally
      dmDanfe.RvProject.ExecuteReport('DANFE1');
      dmDanfe.RvProject.Close;
   end;
end;

procedure TACBrNFeDANFERave.ImprimirDANFE(NFE : TNFe = nil);
var
 i : Integer;
begin
  if FRaveFile = '' then
      raise Exception.Create(' Arquivo de Relatório nao informado.') ;

  if not FilesExists(FRaveFile) then
     raise Exception.Create('Arquivo '+FRaveFile+' Nao encontrado');

  {$IFDEF RAVE50VCL}
     RPDefine.DataID := IntToStr(Application.Handle);  // Evita msg de erro;...
  {$ENDIF}

  dmDanfe.RvProject.ProjectFile := FRaveFile ; //ExtractFileDir(application.ExeName)+'\Report\NotaFiscalEletronica.rav';

  dmDanfe.RvSystem1.DoNativeOutput := True;
  if MostrarPreview then
   begin
     dmDanfe.RvSystem1.DefaultDest    := rdPreview;
     dmDanfe.RvSystem1.SystemSetups:=dmDanfe.RvSystem1.SystemSetups + [ssAllowSetup];
   end
  else
   begin
     dmDanfe.RvSystem1.DefaultDest    := rdPrinter;
     dmDanfe.RvSystem1.SystemSetups:=dmDanfe.RvSystem1.SystemSetups - [ssAllowSetup];
   end;
  dmDanfe.RvSystem1.RenderObject   := nil;
  dmDanfe.RvSystem1.OutputFileName := '';
  dmDanfe.RvProject.Engine := dmDanfe.RvSystem1;
  dmDanfe.RvSystem1.TitlePreview:='Visualizar DANFE';
  dmDanfe.RvSystem1.TitleSetup:='Configurações';
  dmDanfe.RvSystem1.TitleStatus:='Status da Impressão';
  dmDanfe.RvSystem1.SystemFiler.StatusFormat:='Gerando página %p';
  dmDanfe.RvSystem1.SystemFiler.StreamMode:=smTempFile;
  dmDanfe.RvSystem1.SystemOptions:=[soShowStatus,soAllowPrintFromPreview,soPreviewModal];
  dmDanfe.RvSystem1.SystemPreview.FormState:=wsMaximized;
  dmDanfe.RvSystem1.SystemPreview.ZoomFactor:=100;
  dmDanfe.RvSystem1.SystemPrinter.Copies:=NumCopias;
  dmDanfe.RvSystem1.SystemPrinter.LinesPerInch:=8;
  dmDanfe.RvSystem1.SystemPrinter.StatusFormat:='Imprimindo página %p';
  dmDanfe.RvSystem1.SystemPrinter.Title:='NFe - Impressão do DANFE';
  dmDanfe.RvSystem1.SystemPrinter.Units:=unMM;
  dmDanfe.RvSystem1.SystemPrinter.UnitsFactor:=25.4;

  if Length(Impressora) > 0 then
     RpDev.SelectPrinter(Impressora, false);
//     dmDanfe.RvSystem1.BaseReport.SelectPrinter(Impressora);
  if NFE = nil then
   begin
     for i:= 0 to TACBrNFe(ACBrNFe).NotasFiscais.Count-1 do
      begin
        dmDanfe.NFe := TACBrNFe(ACBrNFe).NotasFiscais.Items[i].NFe;
        ExecutaReport;
      end;
   end
  else
   begin
     dmDanfe.NFe := NFE;
     ExecutaReport;
   end;
end;

procedure TACBrNFeDANFERave.ImprimirDANFEPDF(NFE : TNFe = nil);
var
 i : Integer;
 NomeArq : String;
begin
  if FRaveFile = '' then
      raise Exception.Create(' Arquivo de Relatório nao informado.') ;

  if not FilesExists(FRaveFile) then
     raise Exception.Create('Arquivo '+FRaveFile+' Nao encontrado');

  {$IFDEF RAVE50VCL}
     RPDefine.DataID := IntToStr(Application.Handle);  // Evita msg de erro;...
  {$ENDIF}

  dmDanfe.RvProject.ProjectFile := FRaveFile ; //ExtractFileDir(application.ExeName)+'\Report\NotaFiscalEletronica.rav';

  dmDanfe.RvSystem1.DefaultDest := rdFile;
  dmDanfe.RvSystem1.DoNativeOutput:=false;
  dmDanfe.RvSystem1.RenderObject:= dmDanfe.RvRenderPDF1;
  dmDanfe.RvSystem1.SystemSetups:=dmDanfe.RvSystem1.SystemSetups - [ssAllowSetup];
  dmDanfe.RvProject.Engine := dmDanfe.RvSystem1;
  dmDanfe.RvRenderPDF1.EmbedFonts:=False;
  dmDanfe.RvRenderPDF1.ImageQuality:=90;
  dmDanfe.RvRenderPDF1.MetafileDPI:=300;
  dmDanfe.RvRenderPDF1.UseCompression:=False;
  dmDanfe.RvRenderPDF1.Active:=True;

   if NFE = nil then
   begin
      for i:= 0 to TACBrNFe(ACBrNFe).NotasFiscais.Count-1 do
      begin
         dmDanfe.NFe := TACBrNFe(ACBrNFe).NotasFiscais.Items[i].NFe;
         NomeArq := TACBrNFe(ACBrNFe).NotasFiscais.Items[i].NFe.infNFe.ID;
         if length(NomeArq)>44 then
            NomeArq := copy(NomeArq,(length(NomeArq)-44)+1,44);
         if NotaUtil.EstaVazio(FPathArquivos) then
            NomeArq := PathWithDelim(TACBrNFe(ACBrNFe).Configuracoes.Geral.PathSalvar)+NomeArq
         else
            NomeArq := PathWithDelim(FPathArquivos)+NomeArq;
         dmDanfe.RvSystem1.OutputFileName := NomeArq+'.pdf';
         ExecutaReport;
      end;
   end
   else
   begin
      dmDanfe.NFe := NFE;
      NomeArq := NFe.infNFe.ID;
      if length(NomeArq)>44 then
         NomeArq := copy(NomeArq,(length(NomeArq)-44)+1,44);
      if NotaUtil.EstaVazio(FPathArquivos) then
         NomeArq := PathWithDelim(TACBrNFe(ACBrNFe).Configuracoes.Geral.PathSalvar)+NomeArq
      else
         NomeArq := PathWithDelim(FPathArquivos)+NomeArq;
      dmDanfe.RvSystem1.OutputFileName := NomeArq+'.pdf';
      ExecutaReport;
   end;

  dmDanfe.RvRenderPDF1.Active:=False;
end;


end.
