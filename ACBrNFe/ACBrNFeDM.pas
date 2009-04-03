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
******************************************************************************}
unit ACBrNFeDM;

interface

uses
  Forms, SysUtils, Classes,
  RpRave, RpBase,
  RpSystem, RpDefine, RpCon, ACBrNFe_nfe, XMLIntf, XMLDoc, RpRender,
  RpRenderPDF;

type
  TdmACBrNFe = class(TDataModule)
    CustomDestinatarioCXN: TRvCustomConnection;
    RvSystem1: TRvSystem;
    RvProject: TRvProject;
    CustomEmitenteCXN: TRvCustomConnection;
    CustomDadosProdutosCXN: TRvCustomConnection;
    CustomTransportadorCXN: TRvCustomConnection;
    CustomCalculoImpostoCXN: TRvCustomConnection;
    CustomParametrosCXN: TRvCustomConnection;
    CustomDuplicatasCXN: TRvCustomConnection;
    CustomIdentificacaoCXN: TRvCustomConnection;
    CustomVeiculoCXN: TRvCustomConnection;
    CustomVolumesCXN: TRvCustomConnection;
    CustomInformacoesAdicionaisCXN: TRvCustomConnection;
    RvRenderPDF1: TRvRenderPDF;
    procedure CustomDestinatarioCXNGetCols(Connection: TRvCustomConnection);
    procedure CustomDestinatarioCXNGetRow(Connection: TRvCustomConnection);
    procedure CustomDestinatarioCXNOpen(Connection: TRvCustomConnection);
    procedure CustomEmitenteCXNGetCols(Connection: TRvCustomConnection);
    procedure CustomEmitenteCXNOpen(Connection: TRvCustomConnection);
    procedure CustomEmitenteCXNGetRow(Connection: TRvCustomConnection);
    procedure CustomCalculoImpostoCXNGetCols(
      Connection: TRvCustomConnection);
    procedure CustomCalculoImpostoCXNGetRow(
      Connection: TRvCustomConnection);
    procedure CustomCalculoImpostoCXNOpen(Connection: TRvCustomConnection);
    procedure CustomDadosProdutosCXNGetCols(
      Connection: TRvCustomConnection);
    procedure CustomDadosProdutosCXNOpen(Connection: TRvCustomConnection);
    procedure CustomDadosProdutosCXNGetRow(
      Connection: TRvCustomConnection);
    procedure CustomTransportadorCXNGetCols(
      Connection: TRvCustomConnection);
    procedure CustomTransportadorCXNGetRow(
      Connection: TRvCustomConnection);
    procedure CustomTransportadorCXNOpen(Connection: TRvCustomConnection);
    procedure CustomParametrosCXNGetCols(Connection: TRvCustomConnection);
    procedure CustomParametrosCXNOpen(Connection: TRvCustomConnection);
    procedure CustomParametrosCXNGetRow(Connection: TRvCustomConnection);
    procedure CustomIdentificacaoCXNGetCols(
      Connection: TRvCustomConnection);
    procedure CustomIdentificacaoCXNGetRow(
      Connection: TRvCustomConnection);
    procedure CustomIdentificacaoCXNOpen(Connection: TRvCustomConnection);
    procedure CustomDuplicatasCXNGetCols(Connection: TRvCustomConnection);
    procedure CustomDuplicatasCXNGetRow(Connection: TRvCustomConnection);
    procedure CustomDuplicatasCXNOpen(Connection: TRvCustomConnection);
    procedure CustomVeiculoCXNGetCols(Connection: TRvCustomConnection);
    procedure CustomVeiculoCXNGetRow(Connection: TRvCustomConnection);
    procedure CustomVeiculoCXNOpen(Connection: TRvCustomConnection);
    procedure CustomVolumesCXNGetCols(Connection: TRvCustomConnection);
    procedure CustomVolumesCXNGetRow(Connection: TRvCustomConnection);
    procedure CustomVolumesCXNOpen(Connection: TRvCustomConnection);
    procedure CustomInformacoesAdicionaisCXNGetCols(
      Connection: TRvCustomConnection);
    procedure CustomInformacoesAdicionaisCXNGetRow(
      Connection: TRvCustomConnection);
    procedure CustomInformacoesAdicionaisCXNOpen(
      Connection: TRvCustomConnection);
    procedure CustomObservacaoFiscoCXNGetCols(
      Connection: TRvCustomConnection);
    procedure CustomObservacaoFiscoCXNGetRow(
      Connection: TRvCustomConnection);
    procedure CustomObservacaoFiscoCXNOpen(
      Connection: TRvCustomConnection);
    procedure CustomISSQNCXNGetCols(Connection: TRvCustomConnection);
    procedure CustomISSQNCXNGetRow(Connection: TRvCustomConnection);
    procedure CustomISSQNCXNOpen(Connection: TRvCustomConnection);
  private
    { Private declarations }
    FNFe: IXMLTNFe;
    FLogo: String;
  public
    { Public declarations }
    procedure Imprimir(ANFe: IXMLTNFe; ALogo: String = '');
    procedure ImprimirPDF(ANFe: IXMLTNFe; ALogo: String = '');    
  end;

var
  dmACBrNFe: TdmACBrNFe;

implementation

uses ACBrNFeUtil, ACBrNFeConst, StrUtils ;

{$R *.dfm}

procedure TdmACBrNFe.Imprimir(ANFe: IXMLTNFe; ALogo: String);
begin
  FNFe  := ANFe;
  FLogo := ALogo;
  RvProject.ProjectFile := ExtractFileDir(application.ExeName)+'\Report\NotaFiscalEletronica.rav';
  RvProject.Execute;
end;

procedure TdmACBrNFe.ImprimirPDF(ANFe: IXMLTNFe; ALogo: String);
begin
  FNFe  := ANFe;
  FLogo := ALogo;

  RvSystem1.DefaultDest := rdFile;
  RvSystem1.DoNativeOutput:=false;
  RvSystem1.RenderObject:= RvRenderPDF1;
  RvSystem1.OutputFileName:=  ExtractFileDir(application.ExeName)+'\'+FNFe.InfNFe.Id+'.pdf';
  RvSystem1.SystemSetups:=RvSystem1.SystemSetups - [ssAllowSetup];
  RvProject.Engine := RvSystem1;

  RvProject.ProjectFile := ExtractFileDir(application.ExeName)+'\Report\NotaFiscalEletronica.rav';
  RvProject.Execute;

  RvSystem1.DoNativeOutput := True;
  RvSystem1.DefaultDest    := rdPrinter;
  RvSystem1.RenderObject   := nil;
  RvSystem1.OutputFileName := '';
  RvSystem1.SystemSetups:=RvSystem1.SystemSetups + [ssAllowSetup];
end;



procedure TdmACBrNFe.CustomDestinatarioCXNGetCols(
  Connection: TRvCustomConnection);
begin
  Connection.WriteField('CNPJCPF',dtString,18,'','');
  Connection.WriteField('XNome',dtString,60,'','');
  Connection.WriteField('XLgr',dtString,60,'','');
  Connection.WriteField('Nro',dtString,60,'','');
  Connection.WriteField('XCpl',dtString,60,'','');
  Connection.WriteField('XBairro',dtString,60,'','');
  Connection.WriteField('CMun',dtString,7,'','');
  Connection.WriteField('XMun',dtString,60,'','');
  Connection.WriteField('UF',dtString,2,'','');
  Connection.WriteField('CEP',dtString,9,'','');
  Connection.WriteField('CPais',dtString,4,'','');
  Connection.WriteField('XPais',dtString,60,'','');
  Connection.WriteField('Fone',dtString,15,'','');
  Connection.WriteField('IE',dtString,14,'','');
end;

procedure TdmACBrNFe.CustomDestinatarioCXNGetRow(
  Connection: TRvCustomConnection);
begin
  with FNFe.InfNFe.Dest do
  begin
    if NotaUtil.NaoEstaVazio(CNPJ) then
      Connection.WriteStrData('', NotaUtil.FormatarCNPJ(CNPJ))
    else
      Connection.WriteStrData('', NotaUtil.FormatarCPF(CPF));

    Connection.WriteStrData('', XNome);
    with EnderDest do
    begin
      Connection.WriteStrData('', XLgr);
      Connection.WriteStrData('', Nro);
      Connection.WriteStrData('', XCpl);
      Connection.WriteStrData('', XBairro);
      Connection.WriteStrData('', CMun);
      Connection.WriteStrData('', NotaUtil.ParseText(XMun,true));
      Connection.WriteStrData('', UF);
      Connection.WriteStrData('', NotaUtil.FormatarCEP(CEP));
      Connection.WriteStrData('', CPais);
      Connection.WriteStrData('', XPais);
      Connection.WriteStrData('', NotaUtil.FormatarFone(Fone));
    end;
    Connection.WriteStrData('', IE);
  end;

end;

procedure TdmACBrNFe.CustomDestinatarioCXNOpen(
  Connection: TRvCustomConnection);
begin
  Connection.DataRows := 1;
end;

procedure TdmACBrNFe.CustomEmitenteCXNGetCols(
  Connection: TRvCustomConnection);
begin
  //emit
  Connection.WriteField('CNPJ', dtString, 18, '', '');
  Connection.WriteField('XNome', dtString, 60, '', '');
  Connection.WriteField('XFant', dtString, 60, '', '');
  Connection.WriteField('XLgr', dtString, 60, '', '');
  Connection.WriteField('Nro', dtString, 60, '', '');
  Connection.WriteField('XCpl', dtString, 60, '', '');
  Connection.WriteField('XBairro', dtString, 60, '', '');
  Connection.WriteField('CMun', dtString, 7, '', '');
  Connection.WriteField('XMun', dtString, 60, '', '');
  Connection.WriteField('UF', dtString, 2, '', '');
  Connection.WriteField('CEP', dtString, 9, '', '');
  Connection.WriteField('CPais', dtString, 4, '', '');
  Connection.WriteField('XPais', dtString, 60, '', '');
  Connection.WriteField('Fone', dtString, 15, '', '');
  Connection.WriteField('IE', dtString, 14, '', '');

  Connection.WriteField('IM', dtString, 15, '', '');

end;

procedure TdmACBrNFe.CustomEmitenteCXNOpen(
  Connection: TRvCustomConnection);
begin
  Connection.DataRows := 1;
end;

procedure TdmACBrNFe.CustomEmitenteCXNGetRow(
  Connection: TRvCustomConnection);
begin
  with FNFe.InfNFe.Emit do
  begin
    Connection.WriteStrData('', NotaUtil.FormatarCNPJ(CNPJ));
    Connection.WriteStrData('', XNome);
    Connection.WriteStrData('', XFant);
    with EnderEmit do
    begin
      Connection.WriteStrData('', XLgr);
      Connection.WriteStrData('', Nro);
      Connection.WriteStrData('', XCpl);
      Connection.WriteStrData('', XBairro);
      Connection.WriteStrData('', CMun);
      Connection.WriteStrData('', NotaUtil.ParseText(XMun,true));
      Connection.WriteStrData('', UF);
      Connection.WriteStrData('', NotaUtil.FormatarCEP(CEP));
      Connection.WriteStrData('', CPais);
      Connection.WriteStrData('', XPais);
      Connection.WriteStrData('', NotaUtil.FormatarFone(Fone));
    end;
    Connection.WriteStrData('', IE);
    Connection.WriteStrData('', IM);
  end;
end;

procedure TdmACBrNFe.CustomCalculoImpostoCXNGetCols(
  Connection: TRvCustomConnection);
begin
  Connection.WriteField('VBC', dtFloat, 15, '', '');
  Connection.WriteField('VICMS', dtFloat, 15, '', '');
  Connection.WriteField('VBCST', dtFloat, 15, '', '');
  Connection.WriteField('VST', dtFloat, 15, '', '');
  Connection.WriteField('VProd', dtFloat, 15, '', '');
  Connection.WriteField('VFrete', dtFloat, 15, '', '');
  Connection.WriteField('VSeg', dtFloat, 15, '', '');
  Connection.WriteField('VDesc', dtFloat, 15, '', '');
  Connection.WriteField('VII', dtFloat, 15, '', '');
  Connection.WriteField('VIPI', dtFloat, 15, '', '');
  Connection.WriteField('VPIS', dtFloat, 15, '', '');
  Connection.WriteField('VCOFINS', dtFloat, 15, '', '');
  Connection.WriteField('VOutro', dtFloat, 15, '', '');
  Connection.WriteField('VNF', dtFloat, 15, '', '');
end;

procedure TdmACBrNFe.CustomCalculoImpostoCXNGetRow(
  Connection: TRvCustomConnection);
begin
  with FNFe.InfNFe.Total.ICMSTot do
  begin
    Connection.WriteFloatData('', NotaUtil.StringToFloatDef(VBC,0));
    Connection.WriteFloatData('', NotaUtil.StringToFloatDef(VICMS,0));
    Connection.WriteFloatData('', NotaUtil.StringToFloatDef(VBCST,0));
    Connection.WriteFloatData('', NotaUtil.StringToFloatDef(VST,0));
    Connection.WriteFloatData('', NotaUtil.StringToFloatDef(VProd,0));
    Connection.WriteFloatData('', NotaUtil.StringToFloatDef(VFrete,0));
    Connection.WriteFloatData('', NotaUtil.StringToFloatDef(VSeg,0));
    Connection.WriteFloatData('', NotaUtil.StringToFloatDef(VDesc,0));
    Connection.WriteFloatData('', NotaUtil.StringToFloatDef(VII,0));
    Connection.WriteFloatData('', NotaUtil.StringToFloatDef(VIPI,0));
    Connection.WriteFloatData('', NotaUtil.StringToFloatDef(VPIS,0));
    Connection.WriteFloatData('', NotaUtil.StringToFloatDef(VCOFINS,0));
    Connection.WriteFloatData('', NotaUtil.StringToFloatDef(VOutro,0));
    Connection.WriteFloatData('', NotaUtil.StringToFloatDef(VNF,0));
  end;
end;

procedure TdmACBrNFe.CustomCalculoImpostoCXNOpen(
  Connection: TRvCustomConnection);
begin
  Connection.DataRows := 1;
end;

procedure TdmACBrNFe.CustomDadosProdutosCXNGetCols(
  Connection: TRvCustomConnection);
begin
  Connection.WriteField('CProd', dtString, 60, '', ''); //Codigo
  Connection.WriteField('XProd', dtString, 120, '', ''); //Descricao
  Connection.WriteField('NCM', dtString, 8, '', ''); //NCM
  Connection.WriteField('CFOP', dtString, 4, '', ''); //CFOP
  Connection.WriteField('UCom', dtString, 6, '', ''); //Unidade
  Connection.WriteField('QCom', dtFloat, 12, '', ''); //Quantidade
  Connection.WriteField('VUnCom', dtFloat, 16, '', ''); //ValorUnitario
  Connection.WriteField('VProd', dtFloat, 15, '', ''); //ValorTotal
  Connection.WriteField('CST', dtString, 2, '', ''); //CST
  Connection.WriteField('VBC', dtFloat, 15, '', ''); //ValorBase
  Connection.WriteField('PICMS', dtFloat, 5, '', ''); //Aliquota
  Connection.WriteField('VICMS', dtFloat, 15, '', ''); //Valor
  Connection.WriteField('VIPI', dtFloat, 15, '', ''); //Valor IPI
  Connection.WriteField('PIPI', dtFloat, 5, '', ''); //Aliquota IPI
end;

procedure TdmACBrNFe.CustomDadosProdutosCXNOpen(
  Connection: TRvCustomConnection);
begin
  Connection.DataRows := FNFe.InfNFe.Det.Count;
end;

procedure TdmACBrNFe.CustomDadosProdutosCXNGetRow(
  Connection: TRvCustomConnection);
begin
  with FNFe.InfNFe.Det.Items[Connection.DataIndex] do
  begin
    with Prod do
    begin
      Connection.WriteStrData('', CProd);
      Connection.WriteStrData('', XProd);
      Connection.WriteStrData('', NCM);
      Connection.WriteStrData('', CFOP);
      Connection.WriteStrData('', UCom);
      Connection.WriteFloatData('', NotaUtil.StringToFloatDef(QCom,0));
      Connection.WriteFloatData('', NotaUtil.StringToFloatDef(VUnCom,0));
      Connection.WriteFloatData('', NotaUtil.StringToFloatDef(VProd,0));
      with Imposto.ICMS do
      begin
        if ICMS00.CST = '00' then
          begin
            Connection.WriteStrData('', ICMS00.CST);
            Connection.WriteFloatData('', NotaUtil.StringToFloatDef(ICMS00.VBC,0));
            Connection.WriteFloatData('', NotaUtil.StringToFloatDef(ICMS00.PICMS,0));
            Connection.WriteFloatData('', NotaUtil.StringToFloatDef(ICMS00.VICMS,0));
          end
        else if ICMS10.CST = '10' then
          begin
            Connection.WriteStrData('', ICMS10.CST);
            Connection.WriteFloatData('', NotaUtil.StringToFloatDef(ICMS10.VBC,0));
            Connection.WriteFloatData('', NotaUtil.StringToFloatDef(ICMS10.PICMS,0));
            Connection.WriteFloatData('', NotaUtil.StringToFloatDef(ICMS10.VICMS,0));
          end
        else if ICMS20.CST = '20' then
          begin
            Connection.WriteStrData('', ICMS20.CST);
            Connection.WriteFloatData('', NotaUtil.StringToFloatDef(ICMS20.VBC,0));
            Connection.WriteFloatData('', NotaUtil.StringToFloatDef(ICMS20.PICMS,0));
            Connection.WriteFloatData('', NotaUtil.StringToFloatDef(ICMS20.VICMS,0));
          end
        else if ICMS30.CST = '30' then
          begin
            Connection.WriteStrData('', ICMS30.CST);
            Connection.WriteFloatData('', NotaUtil.StringToFloatDef(ICMS30.VBCST,0));
            Connection.WriteFloatData('', NotaUtil.StringToFloatDef(ICMS30.PICMSST,0));
            Connection.WriteFloatData('', NotaUtil.StringToFloatDef(ICMS30.VICMSST,0));
          end
        else if (ICMS40.CST = '40') or (ICMS40.CST = '41') or (ICMS40.CST = '50') then
          begin
            Connection.WriteStrData('', ICMS40.CST);
            Connection.WriteFloatData('', 0);
            Connection.WriteFloatData('', 0);
            Connection.WriteFloatData('', 0);
          end
        else if (ICMS51.CST = '51') then
          begin
            Connection.WriteStrData('', ICMS51.CST);
            Connection.WriteFloatData('', NotaUtil.StringToFloatDef(ICMS51.VBC,0));
            Connection.WriteFloatData('', NotaUtil.StringToFloatDef(ICMS51.PICMS,0));
            Connection.WriteFloatData('', NotaUtil.StringToFloatDef(ICMS51.VICMS,0));
          end
        else if (ICMS60.CST = '60') then
          begin
            Connection.WriteStrData('', ICMS60.CST);
            Connection.WriteFloatData('', NotaUtil.StringToFloatDef(ICMS60.VBCST,0));
            Connection.WriteFloatData('', 0);
            Connection.WriteFloatData('', NotaUtil.StringToFloatDef(ICMS60.VICMSST,0));
          end
        else if (ICMS70.CST = '70') then
          begin
            Connection.WriteStrData('', ICMS70.CST);
            Connection.WriteFloatData('', NotaUtil.StringToFloatDef(ICMS70.VBC,0));
            Connection.WriteFloatData('', NotaUtil.StringToFloatDef(ICMS70.PICMS,0));
            Connection.WriteFloatData('', NotaUtil.StringToFloatDef(ICMS70.VICMS,0));
          end
        else if (ICMS90.CST = '90') then
          begin
            Connection.WriteStrData('', ICMS90.CST);
            Connection.WriteFloatData('', NotaUtil.StringToFloatDef(ICMS90.VBC,0));
            Connection.WriteFloatData('', NotaUtil.StringToFloatDef(ICMS90.PICMS,0));
            Connection.WriteFloatData('', NotaUtil.StringToFloatDef(ICMS90.VICMS,0));
          end;
      end;

      with Imposto.IPI do
      begin
        if (IPITrib.CST = '00') or (IPITrib.CST = '49') or
           (IPITrib.CST = '50') or (IPITrib.CST = '99') then
          begin
            Connection.WriteFloatData('', NotaUtil.StringToFloatDef(IPITrib.VIPI,0));
            Connection.WriteFloatData('', NotaUtil.StringToFloatDef(IPITrib.PIPI,0));
          end
        else if (IPINT.CST = '01') or (IPINT.CST = '02') or (IPINT.CST = '03') or
                (IPINT.CST = '04') or (IPINT.CST = '51') or (IPINT.CST = '52') or
                (IPINT.CST = '53') or (IPINT.CST = '54') or (IPINT.CST = '55') then
          begin
            Connection.WriteFloatData('', 0);
            Connection.WriteFloatData('', 0);
          end
        else
         begin
           Connection.WriteFloatData('', 0);
           Connection.WriteFloatData('', 0);
         end;
      end;
    end;
  end;
end;

procedure TdmACBrNFe.CustomTransportadorCXNGetCols(
  Connection: TRvCustomConnection);
begin
  Connection.WriteField('ModFrete', dtString, 1, '', '');
  Connection.WriteField('CNPJCPF', dtString,18,'','');
  Connection.WriteField('XNome', dtString,60,'','');
  Connection.WriteField('IE', dtString,14,'','');
  Connection.WriteField('XEnder', dtString,60,'','');
  Connection.WriteField('XMun', dtString,60,'','');
  Connection.WriteField('UF', dtString,2,'','');
end;

procedure TdmACBrNFe.CustomTransportadorCXNGetRow(
  Connection: TRvCustomConnection);
begin
  with FNFe.InfNFe.Transp do
  begin
    Connection.WriteStrData('', ModFrete);
    with Transporta do
    begin
      if NotaUtil.NaoEstaVazio(CNPJ) then
        Connection.WriteStrData('', NotaUtil.FormatarCNPJ(CNPJ))
      else 
        Connection.WriteStrData('', NotaUtil.FormatarCPF(CPF));
      Connection.WriteStrData('', XNome);
      Connection.WriteStrData('', IE);
      Connection.WriteStrData('', XEnder);
      Connection.WriteStrData('', NotaUtil.ParseText(XMun,true));
      Connection.WriteStrData('', UF);
    end;
  end;
end;

procedure TdmACBrNFe.CustomTransportadorCXNOpen(
  Connection: TRvCustomConnection);
begin
  Connection.DataRows := 1;
end;

procedure TdmACBrNFe.CustomParametrosCXNGetCols(
  Connection: TRvCustomConnection);
begin
  Connection.WriteField('Mensagem0', dtString, 60, '', '');
  Connection.WriteField('Imagem', dtBlob, 60, '', '');
end;

procedure TdmACBrNFe.CustomParametrosCXNOpen(
  Connection: TRvCustomConnection);
begin
  Connection.DataRows := 1;
end;

procedure TdmACBrNFe.CustomParametrosCXNGetRow(
  Connection: TRvCustomConnection);
var
  vStream: TMemoryStream;
begin
  with FNFe.InfNFe.Ide do
    Connection.WriteStrData('', NotaUtil.SeSenao(TpAmb = '2','Nota Fiscal sem valor Fiscal', ''));

  vStream := TMemoryStream.Create;
  try
    if NotaUtil.NaoEstaVazio(FLogo) then
    begin
      if FileExists(FLogo) then
        vStream.LoadFromFile(FLogo);
    end;
    vStream.Position := 0;
    Connection.WriteBlobData(vStream.Memory^, vStream.Size);
  finally
    vStream.Free;
  end;
end;

procedure TdmACBrNFe.CustomIdentificacaoCXNGetCols(
  Connection: TRvCustomConnection);
begin
  //Ide
  Connection.WriteField('Versao', dtString, 4, '', '');
  Connection.WriteField('Id', dtString, 44, '', '');
  Connection.WriteField('Chave', dtString, 60, '', '');
  Connection.WriteField('CUF', dtString, 2, '', '');
  Connection.WriteField('CNF', dtString, 9, '', '');
  Connection.WriteField('NatOp', dtString, 60, '', '');
  Connection.WriteField('IndPag', dtString, 1, '', '');
  Connection.WriteField('Mod_', dtString, 2, '', '');
  Connection.WriteField('Serie', dtString, 3, '', '');
  Connection.WriteField('NNF', dtString, 11, '', '');
  Connection.WriteField('DEmi', dtString, 10, '', '');
  Connection.WriteField('DSaiEnt', dtString, 10, '', '');
  Connection.WriteField('TpNF', dtString, 1, '', '');
  Connection.WriteField('CMunFG', dtString, 7, '', '');
  Connection.WriteField('TpImp', dtString, 1, '', '');
  Connection.WriteField('TpEmis', dtString, 1, '', '');
  Connection.WriteField('CDV', dtString, 1, '', '');
  Connection.WriteField('TpAmb', dtString, 1, '', '');
  Connection.WriteField('FinNFe', dtString, 1, '', '');
  Connection.WriteField('ProcEmi', dtString, 1, '', '');
  Connection.WriteField('VerProc', dtString, 20, '', '');
end;

procedure TdmACBrNFe.CustomIdentificacaoCXNGetRow(
  Connection: TRvCustomConnection);
begin
  with FNFe.InfNFe do
  begin
    Connection.WriteStrData('', Versao);
    Connection.WriteStrData('', NotaUtil.LimpaNumero(Id));
    Connection.WriteStrData('', NotaUtil.FormatarChaveAcesso(Id));
  end;

  with FNFe.InfNFe.Ide do
  begin
    Connection.WriteStrData('', CUF);
    Connection.WriteStrData('', CNF);
    Connection.WriteStrData('', NatOp);
    Connection.WriteStrData('', IndPag);
    Connection.WriteStrData('', Mod_);
    Connection.WriteStrData('', Serie);
    Connection.WriteStrData('', NotaUtil.FormatarNumeroDocumentoFiscal(NNF));
    Connection.WriteStrData('', NotaUtil.FormatDate(DEmi));
    Connection.WriteStrData('', IfThen(NotaUtil.NaoEstaVazio(DSaiEnt), NotaUtil.FormatDate(DSaiEnt)));
    Connection.WriteStrData('', TpNF);
    Connection.WriteStrData('', CMunFG);
    Connection.WriteStrData('', TpImp);
    Connection.WriteStrData('', TpEmis);
    Connection.WriteStrData('', CDV);
    Connection.WriteStrData('', TpAmb);
    Connection.WriteStrData('', FinNFe);
    Connection.WriteStrData('', ProcEmi);
    Connection.WriteStrData('', VerProc);
  end;
end;

procedure TdmACBrNFe.CustomIdentificacaoCXNOpen(
  Connection: TRvCustomConnection);
begin
  Connection.DataRows := 1;
end;

procedure TdmACBrNFe.CustomDuplicatasCXNGetCols(
  Connection: TRvCustomConnection);
begin
  Connection.WriteField('NDup', dtString, 60, '', '');
  Connection.WriteField('DVenc', dtString, 10, '', '');
  Connection.WriteField('VDup', dtFloat, 15, '', '');
end;

procedure TdmACBrNFe.CustomDuplicatasCXNGetRow(
  Connection: TRvCustomConnection);
begin
  with FNFe.InfNFe.Cobr.Dup[Connection.DataIndex] do
  begin
    Connection.WriteStrData('', NDup);
    Connection.WriteStrData('', NotaUtil.FormatDate(DVenc));
    Connection.WriteFloatData('', NotaUtil.StringToFloatDef(VDup,0));
  end;
end;

procedure TdmACBrNFe.CustomDuplicatasCXNOpen(
  Connection: TRvCustomConnection);
begin
  Connection.DataRows := FNFe.InfNFe.Cobr.Dup.Count;
end;

procedure TdmACBrNFe.CustomVeiculoCXNGetCols(
  Connection: TRvCustomConnection);
begin
  Connection.WriteField('PLACA', dtString,8,'','');
  Connection.WriteField('UF', dtString,2,'','');
  Connection.WriteField('RNTC', dtString,20,'','');
end;

procedure TdmACBrNFe.CustomVeiculoCXNGetRow(
  Connection: TRvCustomConnection);
begin
  with FNFe.InfNFe.Transp.VeicTransp do
  begin
    Connection.WriteStrData('', Placa);
    Connection.WriteStrData('', UF);
    Connection.WriteStrData('', RNTC);
  end;
end;

procedure TdmACBrNFe.CustomVeiculoCXNOpen(
  Connection: TRvCustomConnection);
begin
  Connection.DataRows := 1;
end;

procedure TdmACBrNFe.CustomVolumesCXNGetCols(
  Connection: TRvCustomConnection);
begin
  Connection.WriteField('QVol', dtFloat,15,'','');
  Connection.WriteField('Esp', dtString,60,'','');
  Connection.WriteField('Marca', dtString,60,'','');
  Connection.WriteField('NVol', dtString,60,'','');
  Connection.WriteField('PesoL', dtFloat,15,'','');
  Connection.WriteField('PesoB', dtFloat,15,'','');
end;

procedure TdmACBrNFe.CustomVolumesCXNGetRow(
  Connection: TRvCustomConnection);
begin
  with FNFe.InfNFe.Transp.Vol[Connection.DataIndex] do
  begin
    Connection.WriteFloatData('', NotaUtil.StringToFloatDef(QVol,0));
    Connection.WriteStrData('', Esp);
    Connection.WriteStrData('', Marca);
    Connection.WriteStrData('', NVol);
    Connection.WriteFloatData('', NotaUtil.StringToFloatDef(PesoL,0));
    Connection.WriteFloatData('', NotaUtil.StringToFloatDef(PesoB,0));
  end;
end;

procedure TdmACBrNFe.CustomVolumesCXNOpen(
  Connection: TRvCustomConnection);
begin
  Connection.DataRows := FNFe.InfNFe.Transp.Vol.Count;
end;

procedure TdmACBrNFe.CustomInformacoesAdicionaisCXNGetCols(
  Connection: TRvCustomConnection);
begin
  Connection.WriteField('OBS', dtMemo,5000,'','');
end;

type
  ArrOfStr = array of string;

function explode(sPart, sInput: string): ArrOfStr;
begin
  while Pos(sPart, sInput) <> 0 do
    begin
      SetLength(Result, Length(Result) + 1);
      Result[Length(Result) - 1] := Copy(sInput, 0, Pos(sPart, sInput) - 1);
      Delete(sInput, 1, Pos(sPart, sInput));
  end;

  SetLength(Result, Length(Result) + 1);
  Result[Length(Result) - 1] := sInput;
end;

function implode(sPart:string;tokens:ArrOfStr):string;
var i:integer;
begin
   result := '';
   for i := 0 to Length(tokens) - 1 do
     result:=result+(tokens[i])+sPart;
end;


procedure TdmACBrNFe.CustomInformacoesAdicionaisCXNGetRow(
  Connection: TRvCustomConnection);
var
  i: Integer;
  vTemp: TStringList;
  vStream: TMemoryStream;

  IndexCampo:Integer;
  Campos:ArrOfStr;
begin
  with FNFe.InfNFe.InfAdic do
  begin
    vTemp := TStringList.Create;
    vStream := TMemoryStream.Create;
    try
      for i:=0  to ObsCont.Count-1 do
      begin
        with ObsCont.Items[i] do
          vTemp.Add(XCampo+': '+XTexto);
      end;

      Campos := explode(';',InfCpl);
      for indexCampo:=0 to Length(Campos)-1 do
         vTemp.Add(Campos[indexCampo]);

      vTemp.SaveToStream(vStream);
      vStream.Position := 0;
      Connection.WriteBlobData(vStream.Memory^, vStream.Size);
    finally
      vTemp.Free;
      vStream.Free;
    end;
  end;
end;

procedure TdmACBrNFe.CustomInformacoesAdicionaisCXNOpen(
  Connection: TRvCustomConnection);
begin
  Connection.DataRows := 1;
end;

procedure TdmACBrNFe.CustomObservacaoFiscoCXNGetCols(
  Connection: TRvCustomConnection);
begin
  Connection.WriteField('OBSF', dtMemo,5000,'','');
end;

procedure TdmACBrNFe.CustomObservacaoFiscoCXNGetRow(
  Connection: TRvCustomConnection);
var
  i: Integer;
  vTemp: TStringList;
  vStream: TMemoryStream;
begin
  with FNFe.InfNFe.InfAdic do
  begin
    vTemp := TStringList.Create;
    vStream := TMemoryStream.Create;
    try
      for i:=0  to ObsFisco.Count-1 do
      begin
        with ObsFisco.Items[i] do
          vTemp.Add(XCampo+': '+XTexto);
      end;

      vTemp.Add(InfAdFisco);
      vTemp.SaveToStream(vStream);
      vStream.Position := 0;
      Connection.WriteBlobData(vStream.Memory^, vStream.Size);
    finally
      vTemp.Free;
      vStream.Free;
    end;
  end;

end;

procedure TdmACBrNFe.CustomObservacaoFiscoCXNOpen(
  Connection: TRvCustomConnection);
begin
  Connection.DataRows := 1;
end;

procedure TdmACBrNFe.CustomISSQNCXNGetCols(
  Connection: TRvCustomConnection);
begin
  Connection.WriteField('vSERV', dtFloat, 15, '', '');
  Connection.WriteField('vBC', dtFloat, 15, '', '');
  Connection.WriteField('vISS', dtFloat, 15, '', '');

end;

procedure TdmACBrNFe.CustomISSQNCXNGetRow(Connection: TRvCustomConnection);
begin
  with FNFe.InfNFe.Total.ISSQNtot do begin
    Connection.WriteFloatData('', NotaUtil.StringToFloatDef(VServ,0));
    Connection.WriteFloatData('', NotaUtil.StringToFloatDef(VBC,0));
    Connection.WriteFloatData('', NotaUtil.StringToFloatDef(VISS,0));
  end;
end;

procedure TdmACBrNFe.CustomISSQNCXNOpen(Connection: TRvCustomConnection);
begin
  Connection.DataRows := 1;
end;

initialization
  dmACBrNFe := TdmACBrNFe.Create(nil);

finalization
  dmACBrNFe.Free;

end.
