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
|* 11/08/2010: Itamar Luiz Bermond
|*  - Inicio do desenvolvimento
|* 24/08/2010: Régys Silveira
|*  - Acerto nas diretivas de compilação para Delphi 2009 e superior
|*  - Acertos gerais no DANFE
|        . Layout
|        . Exibição da logomarca
|        . Tamanho das colunas para conter valores grandes
|        . marca d'agua para ambiente de homologação
|        . Adicionado o complemento a descrição da mercadoria
|        . Adicionado a origem no CST
|        . Acerto para mostrar o CST corretamente quando for Simples Nacional
|*  - Padronização da logomarca para utilizar o caminho como nos outros DANFEs
|*  - Acerto no CST para o Simples Nacional
|*  - Acertos no DANFE para o Simples Nacional
|* 25/08/2010: Régys Silveira
|*  - Configuração do preview do DANFE.
|* 26/08/2010: Régys Silveira, Itamar Bermond
|*  - Desmarcada a propriedade StoreInDFM do FastReport para não gravar
|*    o relatório no DFM e evitar o erro de compilação em versão menores
|*    do delphi, favor utilizar o arquivo externo.
******************************************************************************}
{$I ACBr.inc}

unit ACBrNFeDANFEFRDM;

interface

uses
  pcnEnvEventoNFe,
  SysUtils, Classes, ACBrNFeDANFEClass, pcnNFe, frxClass, frxExportPDF, DB,
  DBClient, frxDBSet, pcnConversao, frxBarcode;

type
  TdmACBrNFeFR = class(TDataModule)
    frxPDFExport: TfrxPDFExport;
    cdsIdentificacao: TClientDataSet;
    cdsEmitente: TClientDataSet;
    cdsDestinatario: TClientDataSet;
    cdsDadosProdutos: TClientDataSet;
    cdsParametros: TClientDataSet;
    cdsInformacoesAdicionais: TClientDataSet;
    cdsDuplicatas: TClientDataSet;
    cdsCalculoImposto: TClientDataSet;
    cdsTransportador: TClientDataSet;
    cdsVeiculo: TClientDataSet;
    cdsVolumes: TClientDataSet;
    cdsISSQN: TClientDataSet;
    cdsFatura: TClientDataSet;
    cdsLocalRetirada: TClientDataSet;
    cdsLocalEntrega: TClientDataSet;
    frxIdentificacao: TfrxDBDataset;
    frxEmitente: TfrxDBDataset;
    frxDestinatario: TfrxDBDataset;
    frxDadosProdutos: TfrxDBDataset;
    frxParametros: TfrxDBDataset;
    frxDuplicatas: TfrxDBDataset;
    frxCalculoImposto: TfrxDBDataset;
    frxTransportador: TfrxDBDataset;
    frxVeiculo: TfrxDBDataset;
    frxVolumes: TfrxDBDataset;
    frxISSQN: TfrxDBDataset;
    frxFatura: TfrxDBDataset;
    frxLocalRetirada: TfrxDBDataset;
    frxLocalEntrega: TfrxDBDataset;
    frxInformacoesAdicionais: TfrxDBDataset;
    frxBarCodeObject: TfrxBarCodeObject;
    frxReport: TfrxReport;
    cdsEventos: TClientDataSet;
    frxEventos: TfrxDBDataset;
    constructor Create(AOwner: TComponent); override;
  private
    FDANFEClassOwner: TACBrNFeDANFEClass;
    FNFe: TNFe;
    FEvento: TEventoNFe;
    procedure CarregaIdentificacao;
    procedure CarregaEmitente;
    procedure CarregaDestinatario;
    procedure CarregaDadosProdutos;
    procedure CarregaParametros;
    procedure CarregaCalculoImposto;
    procedure CarregaTransportador;
    procedure CarregaVeiculo;
    procedure CarregaVolumes;
    procedure CarregaDuplicatas;
    procedure CarregaISSQN;
    procedure CarregaLocalRetirada;
    procedure CarregaLocalEntrega;
    procedure CarregaFatura;
    procedure CarregaInformacoesAdicionais;
  public
    property NFe: TNFe read FNFe write FNFe;
    property Evento: TEventoNFe read FEvento write FEvento;
    property DANFEClassOwner: TACBrNFeDANFEClass read FDANFEClassOwner;
    procedure CarregaDadosNFe;
    procedure CarregaDadosEventos;
  end;

var
  dmACBrNFeFR: TdmACBrNFeFR;

implementation

uses ACBrNFe, ACBrNFeUtil, ACBrDFeUtil, StrUtils, Math;

{$R *.dfm}

type
  ArrOfStr = Array of String;
  TSplitResult = array of string;

{ TdmACBrNFeFR }

function SubstrCount(const ASubString, AString: string): Integer;
var
  i: integer;
begin
  Result := -1;
  i := 0;
  repeat
    Inc(Result);
    i := PosEx(ASubString, AString, i + 1);
  until i = 0;
end;

function Split(const ADelimiter, AString: string): TSplitResult;
var
  Step: ^String;
  Chr: PChar;
  iPos, iLast, iDelLen, iLen, x: integer;
label
  EndLoop;
begin
  SetLength(Result, SubstrCount(ADelimiter, AString) + 1);
  if High(Result) = 0 then
    Result[0] := AString
  else
  begin
    iDelLen := PCardinal(Cardinal(ADelimiter) - SizeOf(Cardinal))^;
    iLen := PCardinal(Cardinal(AString) - SizeOf(Cardinal))^;
    Step := @Result[0];
    iLast := 0;
    iPos := 0;
    repeat
      if iPos + iDelLen > iLen then
      begin
        if iLast <> iPos then
          iPos := iLen;
      end else
        for x := 1 to iDelLen do
          if AString[iPos + x] <> ADelimiter[x] then
            goto EndLoop;

      if iPos - iLast > 0 then
      begin
        SetLength(Step^, iPos - iLast);
        Chr := PChar(Step^);
        for x := 1 to PCardinal(Cardinal(Step^) - SizeOf(Cardinal))^ do
        begin
          Chr^ := AString[iLast + x];
          Inc(Chr);
        end;
      end else
        Step^ := '';

      Cardinal(Step) := Cardinal(Step) + SizeOf(Cardinal);
      iLast := iPos + iDelLen;

      EndLoop:
        Inc(iPos);
    until iLast >= iLen;
  end;
end;

function Explode(sPart, sInput: String): ArrOfStr;
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

function CollateBr(Str: String): String;
var
  Resultado,Temp: string;
  vChar: Char;
  Tamanho, i: integer;
begin
  Result := '';
  Tamanho := Length(str);
  i := 1;
  while i <= Tamanho do
  begin
    Temp := Copy(str,i,1);
    vChar := Temp[1];
    case vChar of
      'á', 'â', 'ã', 'à', 'ä', 'å', 'Á', 'Â', 'Ã', 'À', 'Ä', 'Å': Resultado := 'A';
      'é', 'ê', 'è', 'ë', 'É', 'Ê', 'È', 'Ë': Resultado := 'E';
      'í', 'î', 'ì', 'ï', 'Í', 'Î', 'Ì', 'Ï': Resultado := 'I';
      'ó', 'ô', 'õ', 'ò', 'ö', 'Ó', 'Ô', 'Õ', 'Ò', 'Ö': Resultado := 'O';
      'ú', 'û', 'ù', 'ü', 'Ú', 'Û', 'Ù', 'Ü': Resultado := 'U';
      'ç', 'Ç': Resultado := 'C';
      'ñ', 'Ñ': Resultado := 'N';
      'ý', 'ÿ', 'Ý', 'Y': Resultado := 'Y';
    else
      if vChar > #127 then Resultado := #32
      {$IFDEF DELPHI12_UP}
      else if CharInset(vChar, ['a'..'z','A'..'Z','0'..'9','-',' ']) then
      {$ELSE}
      else if vChar in ['a'..'z','A'..'Z','0'..'9','-',' '] then
      {$ENDIF}
        Resultado := UpperCase(vCHAR);
    end;
    Result := Result + Resultado;
    i := i + 1;
  end;
end;

procedure TdmACBrNFeFR.CarregaCalculoImposto;
begin
  with cdsCalculoImposto do
  begin
    Close;
    FieldDefs.Clear;
    FieldDefs.Add('VBC', ftFloat);
    FieldDefs.Add('VICMS', ftFloat);
    FieldDefs.Add('VBCST', ftFloat);
    FieldDefs.Add('VST', ftFloat);
    FieldDefs.Add('VProd', ftFloat);
    FieldDefs.Add('VFrete', ftFloat);
    FieldDefs.Add('VSeg', ftFloat);
    FieldDefs.Add('VDesc', ftFloat);
    FieldDefs.Add('VII', ftFloat);
    FieldDefs.Add('VIPI', ftFloat);
    FieldDefs.Add('VPIS', ftFloat);
    FieldDefs.Add('VCOFINS', ftFloat);
    FieldDefs.Add('VOutro', ftFloat);
    FieldDefs.Add('VNF', ftFloat);

    CreateDataSet;
    Append;

    with FNFe.Total.ICMSTot do
    begin
      FieldByName('VBC').AsFloat := DFeUtil.StringToFloatDef(FloatToStr(VBC), 0);
      FieldByName('VICMS').AsFloat := DFeUtil.StringToFloatDef(FloatToStr(VICMS), 0);
      FieldByName('VBCST').AsFloat := DFeUtil.StringToFloatDef(FloatToStr(VBCST), 0);
      FieldByName('VST').AsFloat := DFeUtil.StringToFloatDef(FloatToStr(VST), 0);
      FieldByName('VProd').AsFloat := DFeUtil.StringToFloatDef(FloatToStr(VProd), 0);
      FieldByName('VFrete').AsFloat := DFeUtil.StringToFloatDef(FloatToStr(VFrete), 0);
      FieldByName('VSeg').AsFloat := DFeUtil.StringToFloatDef(FloatToStr(VSeg), 0);
      FieldByName('VDesc').AsFloat := DFeUtil.StringToFloatDef(FloatToStr(VDesc), 0);
      FieldByName('VII').AsFloat := DFeUtil.StringToFloatDef(FloatToStr(VII), 0);
      FieldByName('VIPI').AsFloat := DFeUtil.StringToFloatDef(FloatToStr(VIPI), 0);
      FieldByName('VPIS').AsFloat := DFeUtil.StringToFloatDef(FloatToStr(VPIS), 0);
      FieldByName('VCOFINS').AsFloat := DFeUtil.StringToFloatDef(FloatToStr(VCOFINS), 0);
      FieldByName('VOutro').AsFloat := DFeUtil.StringToFloatDef(FloatToStr(VOutro), 0);
      FieldByName('VNF').AsFloat := DFeUtil.StringToFloatDef(FloatToStr(VNF), 0);
    end;

    Post;
  end;
end;

procedure TdmACBrNFeFR.CarregaDadosNFe;
begin
  CarregaIdentificacao;
  CarregaEmitente;
  CarregaDestinatario;
  CarregaDadosProdutos;
  CarregaParametros;
  CarregaCalculoImposto;
  CarregaTransportador;
  CarregaVeiculo;
  CarregaVolumes;
  CarregaDuplicatas;
  CarregaISSQN;
  CarregaLocalRetirada;
  CarregaLocalEntrega;
  CarregaFatura;
  CarregaInformacoesAdicionais;
end;

procedure TdmACBrNFeFR.CarregaDadosProdutos;
var
  i: Integer;
  vTemp2: TStringList;
  IndexCampo2: Integer;
  Campos2: TSplitResult;
  BufferXInfProd: String;
  TmpStr: String;
  j: Integer;
  wInfAdProd: String;
begin
  if not cdsParametros.Active then
    CarregaParametros;

  { dados dos produtos }
  with cdsDadosProdutos do
  begin
    Close;
    FieldDefs.Clear;
    FieldDefs.Add('CProd', ftString, 60); //Codigo
    FieldDefs.Add('cEAN', ftString, 60); //GTIN
    FieldDefs.Add('XProd', ftString, 120); //Descricao
    FieldDefs.Add('infAdProd', ftString, 500); //Inf. Adic. Produto
    FieldDefs.Add('NCM', ftString, 8); //NCM
    FieldDefs.Add('EXTIPI', ftString, 8); //EX_TIPI
    FieldDefs.Add('genero', ftString, 8); //genero
    FieldDefs.Add('CFOP', ftString, 4); //CFOP
    FieldDefs.Add('UCom', ftString, 6); //Unidade
    FieldDefs.Add('QCom', ftFloat); //Quantidade
    FieldDefs.Add('VUnCom', ftFloat); //ValorUnitario
    FieldDefs.Add('VProd', ftFloat); //ValorTotal
    FieldDefs.Add('cEANTrib', ftString, 60); //GTIN Trib.
    FieldDefs.Add('UTrib', ftString, 6); //Unidade
    FieldDefs.Add('QTrib', ftFloat); //Quantidade
    FieldDefs.Add('VUnTrib', ftFloat); //ValorUnitario
    FieldDefs.Add('vFrete', ftFloat); //Total do Frete
    FieldDefs.Add('vSeg', ftFloat); //Total do Seguro
    FieldDefs.Add('vDesc', ftString, 16); //Desconto
    FieldDefs.Add('ORIGEM', ftString, 1); //ORIGEM
    FieldDefs.Add('CST', ftString, 3); //CST
    FieldDefs.Add('VBC', ftFloat); //ValorBase
    FieldDefs.Add('PICMS', ftFloat); //Aliquota
    FieldDefs.Add('VICMS', ftFloat); //Valor
    FieldDefs.Add('VIPI', ftFloat); //Valor IPI
    FieldDefs.Add('PIPI', ftFloat); //Aliquota IPI

    CreateDataSet;

    for i := 0 to NFe.Det.Count - 1 do
    begin
      Append;

      with FNFe.Det.Items[i].Prod do
      begin
        FieldByName('cProd').AsString := cProd;
        FieldByName('cEAN').AsString := cEAN;
        FieldByName('XProd').AsString := StringReplace(xProd, ';', #13, [rfReplaceAll]);

        wInfAdProd := FNFe.Det.Items[i].infAdProd;
        vTemp2 := TStringList.Create;
        try
          if FDANFEClassOwner.ImprimirDetalhamentoEspecifico then
          begin
            { detalhamento especifico de veículos }
            if Trim(veicProd.chassi) <> '' then
            begin
              vTemp2.Add(' CHASSI: ' + veicProd.chassi);
              vTemp2.Add(' COMBUSTÍVEL: ' + veicProd.tpComb);
              vTemp2.Add(' COR: ' + veicProd.xCor);
              vTemp2.Add(' FAB./MOD.: ' + IntToStr(veicProd.anoFab) + '/' + IntToStr(veicProd.anoMod));
//              vTemp2.Add(' RENAVAM: ' + veicProd.RENAVAM); // Essa propriedade foi comentada na class, por isso comentei aqui tambem.
              vTemp2.Add(' Nº DO MOTOR: ' + veicProd.nMotor);

              if Trim(wInfAdProd) <> '' then
                 wInfAdProd := wInfAdProd + ';'; //insere quebra de linha antes do detalhamento

              wInfAdProd := wInfAdProd + vTemp2.Text;
              vTemp2.Clear;
            end;

            { detalhamento específico de medicamentos }
            if med.Count > 0 then
            begin
              for j := 0 to med.Count - 1 do
              begin
                with med.Items[j] do
                begin
                  vTemp2.Add('-LOTE: ' + nLote);
                  vTemp2.Add(' QTDADE: ' + DFeUtil.FormatFloat(qLote));
                  vTemp2.Add(' FABR.: ' + DFeUtil.FormatDate(DateToStr(dFab)));
                  vTemp2.Add(' VAL.: ' + DFeUtil.FormatDate(DateToStr(dVal)));
                  vTemp2.Add(DFeUtil.SeSenao(vPMC > 0, ' PMC: ' + DFeUtil.FormatFloat(vPMC), ''));
                end;
              end;

              if (Trim(wInfAdProd) <> '') then
                wInfAdProd := wInfAdProd + ';'; //insere quebra de linha antes do detalhamento

              wInfAdProd := wInfAdProd + vTemp2.Text;
              vTemp2.Clear;
            end;
          end;

          if Trim(winfAdProd) <> '' then
          begin
            Campos2 := Split(';', winfAdProd);
            for IndexCampo2 := 0 to Length(Campos2) - 1 do
              vTemp2.Add(Trim(Campos2[IndexCampo2]));
            TmpStr := vTemp2.Text;

            // Inserir a quebra de linha para ficar abaixo da descrição do produto
            BufferXInfProd := #13 + TmPStr;
          end
          else
            BufferXInfProd := '';

          FieldByName('infAdProd').AsString := BufferXInfProd;
        finally
          vTemp2.Free;
        end;

        FieldByName('NCM').AsString := NCM;
        FieldByName('EXTIPI').AsString := EXTIPI;
        FieldByName('genero').AsString := '';
        FieldByName('CFOP').AsString := CFOP;
        FieldByName('Ucom').AsString := UCom;
        FieldByName('QCom').AsFloat := DFeUtil.StringToFloatDef(FloatToStr(QCom), 0);
        FieldByName('VUnCom').AsFloat := DFeUtil.StringToFloatDef(FloatToStr(VUnCom), 0);

        if FDANFEClassOwner.ImprimirTotalLiquido then
          FieldByName('VProd').AsFloat := DFeUtil.StringToFloatDef(FloatToStr(VProd - vDesc), 0)
        else
          FieldByName('VProd').AsFloat := DFeUtil.StringToFloatDef(FloatToStr(VProd), 0);

        FieldByName('cEANTrib').AsString := cEANTrib;
        FieldByName('UTrib').AsString := uTrib;
        FieldByName('QTrib').AsFloat := DFeUtil.StringToFloatDef(FloatToStr(qTrib), 0);
        FieldByName('VUnTrib').AsFloat := DFeUtil.StringToFloatDef(FloatToStr(vUnTrib), 0);
        FieldByName('vFrete').AsFloat := DFeUtil.StringToFloatDef(FloatToStr(vFrete), 0);
        FieldByName('vSeg').AsFloat := DFeUtil.StringToFloatDef(FloatToStr(vSeg), 0);

        if FDANFEClassOwner.ImprimirDescPorc then
        begin
          if vDesc > 0 then
            FieldByName('vDesc').AsString := DFeUtil.FormatFloat(RoundTo(100 - ((((VUnCom * QCom) - vDesc) / (VUnCom * QCom)) * 100), -1)) + '%'
          else
            FieldByName('vDesc').AsString := DFeUtil.FormatFloat(vDesc);
        end
        else
          FieldByName('vDesc').AsString := DFeUtil.FormatFloat(vDesc);

        with FNFe.Det.Items[i].Imposto.ICMS do
        begin
          FieldByName('ORIGEM').AsString := OrigToStr(orig);

          case FNFe.Emit.CRT of
            crtSimplesNacional, crtSimplesExcessoReceita:
              begin
                case CSOSN of
                  csosn101, csosn102, csosn103, csosn201, csosn202, csosn203, csosn300, csosn400, csosn500, csosn900:
                    begin
                      FieldByName('CST').AsString  := CSOSNIcmsToStr(CSOSN);
                      FieldByName('VBC').AsFloat   := vBC;
                      FieldByName('PICMS').AsFloat := pICMS;
                      FieldByName('VICMS').AsFloat := vICMS;
                    end;
                end;
              end;
          else
            begin
              if CST = cst00 then
              begin
                FieldByName('CST').AsString := CSTICMSToStr(cst00);
                FieldByName('VBC').AsFloat := vBC;
                FieldByName('PICMS').AsFloat := pICMS;
                FieldByName('VICMS').AsFloat := vICMS;
              end
              else if CST = cst10 then
              begin
                FieldByName('CST').AsString := CSTICMSToStr(cst10);
                FieldByName('VBC').AsFloat := vBC;
                FieldByName('PICMS').AsFloat := pICMS;
                FieldByName('VICMS').AsFloat := vICMS;
              end
              else if CST = cst20 then
              begin
                FieldByName('CST').AsString := CSTICMSToStr(cst20);
                FieldByName('VBC').AsFloat := vBC;
                FieldByName('PICMS').AsFloat := pICMS;
                FieldByName('VICMS').AsFloat := vICMS;
              end
              else if CST = cst30 then
              begin
                FieldByName('CST').AsString := CSTICMSToStr(cst30);
                FieldByName('VBC').AsFloat := 0;
                FieldByName('PICMS').AsFloat := 0;
                FieldByName('VICMS').AsFloat := 0;
              end
              else if (CST = cst40) or (CST = cst41) or (CST = cst50) or (CST = cstRep41) then
              begin
                if (CST = cst40) then
                   FieldByName('CST').AsString := CSTICMSToStr(cst40)
                else if (CST = cst41) or (CST = cstRep41) then
                   FieldByName('CST').AsString := CSTICMSToStr(cst41)
                else if (CST = cst50) then
                   FieldByName('CST').AsString := CSTICMSToStr(cst50);
                FieldByName('VBC').AsFloat := 0;
                FieldByName('PICMS').AsFloat := 0;
                FieldByName('VICMS').AsFloat := 0;
              end
              else if (CST = cst51) then
              begin
                FieldByName('CST').AsString := CSTICMSToStr(cst51);
                FieldByName('VBC').AsFloat := vBC;
                FieldByName('PICMS').AsFloat := pICMS;
                FieldByName('VICMS').AsFloat := vICMS;
              end
              else if (CST = cst60) then
              begin
                FieldByName('CST').AsString := CSTICMSToStr(cst60);
                FieldByName('VBC').AsFloat := 0;
                FieldByName('PICMS').AsFloat := 0;
                FieldByName('VICMS').AsFloat := 0;
              end
              else if (CST = cst70) then
              begin
                FieldByName('CST').AsString := CSTICMSToStr(cst70);
                FieldByName('VBC').AsFloat := vBC;
                FieldByName('PICMS').AsFloat := pICMS;
                FieldByName('VICMS').AsFloat := vICMS;
              end
              else if (CST = cst90) then
              begin
                FieldByName('CST').AsString := CSTICMSToStr(cst90);
                FieldByName('VBC').AsFloat := vBC;
                FieldByName('PICMS').AsFloat := pICMS;
                FieldByName('VICMS').AsFloat := vICMS;
              end
              else if (CST = cstVazio) then
              begin
                FieldByName('CST').AsString := ' ';
                FieldByName('VBC').AsFloat := 0;
                FieldByName('PICMS').AsFloat := 0;
                FieldByName('VICMS').AsFloat := 0;
              end;
            end;
          end;
        end;

        with FNFe.Det.Items[i].Imposto.IPI do
        begin
          if (CST = ipi00) or (CST = ipi49) or (CST = ipi50) or (CST = ipi99) then
          begin
            FieldByName('VIPI').AsFloat := DFeUtil.StringToFloatDef(FloatToStr(VIPI), 0);
            FieldByName('PIPI').AsFloat := DFeUtil.StringToFloatDef(FloatToStr(PIPI), 0);
          end
          else if (CST = ipi01) or (CST = ipi02) or (CST = ipi03) or (CST = ipi04) or (CST = ipi51) or (CST = ipi52) or (CST = ipi53) or (CST = ipi54) or (CST = ipi55) then
          begin
            FieldByName('VIPI').AsFloat := 0;
            FieldByName('PIPI').AsFloat := 0;
          end
          else
          begin
            FieldByName('VIPI').AsFloat := 0;
            FieldByName('PIPI').AsFloat := 0;
          end;
        end;
      end;

      Post;
    end;
  end;
end;

procedure TdmACBrNFeFR.CarregaDestinatario;
begin
  { destinatário }
  with cdsDestinatario do
  begin
    Close;
    FieldDefs.Clear;
    FieldDefs.Add('CNPJCPF', ftString, 18);
    FieldDefs.Add('XNome', ftString, 60);
    FieldDefs.Add('XLgr', ftString, 60);
    FieldDefs.Add('Nro', ftString, 60);
    FieldDefs.Add('XCpl', ftString, 60);
    FieldDefs.Add('XBairro', ftString, 60);
    FieldDefs.Add('CMun', ftString, 7);
    FieldDefs.Add('XMun', ftString, 60);
    FieldDefs.Add('UF', ftString, 2);
    FieldDefs.Add('CEP', ftString, 9);
    FieldDefs.Add('CPais', ftString, 4);
    FieldDefs.Add('XPais', ftString, 60);
    FieldDefs.Add('Fone', ftString, 15);
    FieldDefs.Add('IE', ftString, 14);

    CreateDataSet;
    Append;

    with FNFe.Dest do
    begin
      if DFeUtil.NaoEstaVazio(CNPJCPF) then
       begin
         if Length(CNPJCPF) > 11 then
            FieldByName('CNPJCPF').AsString := DFeUtil.FormatarCNPJ(CNPJCPF)
         else
            FieldByName('CNPJCPF').AsString := DFeUtil.FormatarCPF(CNPJCPF);
       end
      else
         FieldByName('CNPJCPF').AsString := '';

      FieldByName('XNome').AsString := XNome;
      with EnderDest do
      begin
        FieldByName('XLgr').AsString := XLgr;
        FieldByName('Nro').AsString := Nro;
        FieldByName('XCpl').AsString := XCpl;
        FieldByName('XBairro').AsString := XBairro;
        FieldByName('CMun').AsString := IntToStr(CMun);
        FieldByName('XMun').AsString := CollateBr(XMun);
        FieldByName('UF').AsString := UF;
        FieldByName('CEP').AsString := DFeUtil.FormatarCEP(DFeUtil.Poem_Zeros(CEP, 8));
        FieldByName('CPais').AsString := IntToStr(CPais);
        FieldByName('XPais').AsString := XPais;
        FieldByName('Fone').AsString := DFeUtil.FormatarFone(Fone);
      end;
      FieldByName('IE').AsString := IE;
    end;

    Post;
  end;
end;

procedure TdmACBrNFeFR.CarregaDuplicatas;
var
  i: Integer;
begin
  with cdsDuplicatas do
  begin
    Close;
    FieldDefs.Clear;
    FieldDefs.Add('NDup', ftString, 60);
    FieldDefs.Add('DVenc', ftString, 10);
    FieldDefs.Add('VDup', ftFloat);

    CreateDataSet;

    for i := 0 to NFe.Cobr.Dup.Count - 1 do
    begin
      Append;
      with FNFe.Cobr.Dup[i] do
      begin
        FieldByName('NDup').AsString := NDup;
        FieldByName('DVenc').AsString := DFeUtil.FormatDate(DateToStr(DVenc));
        FieldByName('VDup').AsFloat := DFeUtil.StringToFloatDef(FloatToStr(VDup), 0);
      end;

      Post;
    end;
  end;
end;

procedure TdmACBrNFeFR.CarregaEmitente;
begin
  { emitente }
  with cdsEmitente do
  begin
    Close;
    FieldDefs.Clear;
    FieldDefs.Add('CNPJ', ftString, 18);
    FieldDefs.Add('XNome', ftString, 60);
    FieldDefs.Add('XFant', ftString, 60);
    FieldDefs.Add('XLgr', ftString, 60);
    FieldDefs.Add('Nro', ftString, 60);
    FieldDefs.Add('XCpl', ftString, 60);
    FieldDefs.Add('XBairro', ftString, 60);
    FieldDefs.Add('CMun', ftString, 7);
    FieldDefs.Add('XMun', ftString, 60);
    FieldDefs.Add('UF', ftString, 2);
    FieldDefs.Add('CEP', ftString, 9);
    FieldDefs.Add('CPais', ftString, 4);
    FieldDefs.Add('XPais', ftString, 60);
    FieldDefs.Add('Fone', ftString, 15);
    FieldDefs.Add('IE', ftString, 14);
    FieldDefs.Add('IM', ftString, 15);
    FieldDefs.Add('IEST', ftString, 15);
    FieldDefs.Add('CRT', ftString, 1);

    CreateDataSet;
    Append;

    with FNFe.Emit do
    begin
      FieldByName('CNPJ').AsString := DFeUtil.FormatarCNPJ(CNPJCPF);
      FieldByName('XNome').AsString := XNome;
      FieldByName('XFant').AsString := XFant;
      with EnderEmit do
      begin
        FieldByName('Xlgr').AsString := XLgr;
        FieldByName('Nro').AsString := Nro;
        FieldByName('XCpl').AsString := XCpl;
        FieldByName('XBairro').AsString := XBairro;
        FieldByName('CMun').AsString := IntToStr(CMun);
        FieldByName('XMun').AsString := CollateBr(XMun);
        FieldByName('UF').AsString := UF;
        FieldByName('CEP').AsString := DFeUtil.FormatarCEP(DFeUtil.Poem_Zeros(CEP, 8));
        FieldByName('CPais').AsString := IntToStr(CPais);
        FieldByName('XPais').AsString := XPais;
        FieldByName('Fone').AsString := DFeUtil.FormatarFone(Fone);
      end;
      FieldByName('IE').AsString := IE;
      FieldByName('IM').AsString := IM;
      FieldByName('IEST').AsString := IEST;
      FieldByName('CRT').AsString := CRTToStr(CRT);
    end;

    Post;
  end;
end;

procedure TdmACBrNFeFR.CarregaFatura;
begin
  with cdsFatura do
  begin
    Close;
    FieldDefs.Clear;
    FieldDefs.Add('Pagamento', ftString, 20);
    FieldDefs.Add('nFat', ftString, 60);
    FieldDefs.Add('vOrig', ftFloat);
    FieldDefs.Add('vDesc', ftFloat);
    FieldDefs.Add('vLiq', ftFloat);

    CreateDataSet;
    Append;

    if DFeUtil.EstaVazio(FNFe.Cobr.Fat.nFat) then
    begin
      if FNFe.Cobr.Dup.Count = 0 then
      begin
        if FNFe.Ide.indPag = ipVista then
          FieldByName('Pagamento').AsString := 'PAGAMENTO À VISTA'
        else if FNFe.Ide.indPag = ipPrazo then
          FieldByName('Pagamento').AsString := 'PAGAMENTO A PRAZO'
        else
          FieldByName('Pagamento').AsString := ''
      end
      else
        FieldByName('Pagamento').AsString := ''
    end
    else
      FieldByName('Pagamento').AsString := '';

    with FNFe.Cobr.Fat do
    begin
      FieldByName('nfat').AsString := nFat;
      FieldByName('vOrig').AsFloat := DFeUtil.StringToFloatDef(FloatToStr(vOrig), 0);
      FieldByName('vDesc').AsFloat := DFeUtil.StringToFloatDef(FloatToStr(vDesc), 0);
      FieldByName('vLiq').AsFloat := DFeUtil.StringToFloatDef(FloatToStr(vLiq), 0);
    end;

    Post;
  end;
end;

procedure TdmACBrNFeFR.CarregaIdentificacao;
begin
  with cdsIdentificacao do
  begin
    Close;
    FieldDefs.Clear;
    //FieldDefs.Add('Versao', ftString, 4);
    FieldDefs.Add('Id', ftString, 44);
    FieldDefs.Add('Chave', ftString, 60);
    FieldDefs.Add('CUF', ftString, 2);
    FieldDefs.Add('CNF', ftString, 9);
    FieldDefs.Add('NatOp', ftString, 60);
    FieldDefs.Add('IndPag', ftString, 1);
    FieldDefs.Add('Mod_', ftString, 2);
    FieldDefs.Add('Serie', ftString, 3);
    FieldDefs.Add('NNF', ftString, 11);
    FieldDefs.Add('DEmi', ftString, 10);
    FieldDefs.Add('DSaiEnt', ftString, 10);
    FieldDefs.Add('TpNF', ftString, 1);
    FieldDefs.Add('CMunFG', ftString, 7);
    FieldDefs.Add('TpImp', ftString, 1);
    FieldDefs.Add('TpEmis', ftString, 1);
    FieldDefs.Add('CDV', ftString, 1);
    FieldDefs.Add('TpAmb', ftString, 1);
    FieldDefs.Add('FinNFe', ftString, 1);
    FieldDefs.Add('ProcEmi', ftString, 1);
    FieldDefs.Add('VerProc', ftString, 20);
    FieldDefs.Add('HoraSaida', ftString, 10);

    CreateDataSet;
    Append;

    with FNFe.infNFe do
    begin
      //FieldByName('Versao').AsString := IntToStr(Versao);
      FieldByName('Id').AsString := DFeUtil.LimpaNumero(Id);
      FieldByName('Chave').AsString := NotaUtil.FormatarChaveAcesso(Id);
    end;

    with FNFe.Ide do
    begin
      FieldByName('CUF').AsString := IntToStr(CUF);
      FieldByName('CNF').AsString := IntToStr(CNF);
      FieldByName('NatOp').AsString := NatOp;
      FieldByName('IndPag').AsString := DFeUtil.SeSenao(IndPag = ipVista, '0', DFeUtil.SeSenao(IndPag = ipPrazo, '1', '2'));
      FieldByName('Mod_').AsString := IntToStr(Modelo);
      FieldByName('Serie').AsString := IntToStr(Serie);
      FieldByName('NNF').AsString := DFeUtil.FormatarNumeroDocumentoFiscal(IntToStr(NNF));
      FieldByName('DEmi').AsString := DFeUtil.FormatDate(DateToStr(DEmi));
      FieldByName('DSaiEnt').AsString := IfThen(DSaiEnt <> 0, DFeUtil.FormatDate(DateToStr(DSaiEnt)));
      FieldByName('TpNF').AsString := DFeUtil.SeSenao(TpNF = tnEntrada, '0', '1');
      FieldByName('CMunFG').AsString := IntToStr(CMunFG);
      FieldByName('TpImp').AsString := DFeUtil.SeSenao(TpImp = tiRetrato, '1', '2');
      FieldByName('TpEmis').AsString := DFeUtil.SeSenao(TpEmis = teNormal, '1', '5');
      FieldByName('CDV').AsString := IntToStr(CDV);
      FieldByName('TpAmb').AsString := DFeUtil.SeSenao(TpAmb = taHomologacao, '2', '1');
      FieldByName('FinNFe').AsString := DFeUtil.SeSenao(FinNFe = fnNormal, '1', DFeUtil.SeSenao(FinNFe = fnComplementar, '2', '3'));
      FieldByName('ProcEmi').AsString := DFeUtil.SeSenao(ProcEmi = peAplicativoContribuinte, '0', '');
      FieldByName('VerProc').AsString := VerProc;
    end;

    if FNFe.Ide.hSaiEnt = 0 then
      FieldByName('HoraSaida').AsString := ''
    else
      FieldByName('HoraSaida').AsString := TimeToStr(FNFe.Ide.hSaiEnt);

    Post;
  end;
end;

procedure TdmACBrNFeFR.CarregaInformacoesAdicionais;
var
  i: Integer;
  vTemp: TStringList;
  IndexCampo:Integer;
  Campos: TSplitResult;
  BufferInfCpl: String;
  TmpStr: String;
  wContingencia: string;
  wObs:string;
  wLinhasObs: integer;
begin
  with cdsInformacoesAdicionais do
  begin
    Close;
    FieldDefs.Clear;
    FieldDefs.Add('OBS', ftString, 6900);
    FieldDefs.Add('LinhasOBS', ftInteger);

    CreateDataSet;
    Append;

    wLinhasObs := 0;
    with FNFe.InfAdic do
    begin
      TmpStr := '';
      //Fisco
      if Length(InfAdFisco) = 0 then
        InfAdFisco := '';

      for i := 0 to ObsFisco.Count - 1 do
      begin
        with ObsFisco.Items[i] do
          TmpStr := TmpStr + XCampo + ': ' + XTexto + ';';
      end;
      wObs := TmpStr + InfAdFisco;
      TmpStr := '';

      //Inf. Complementar
      if Length(InfCpl) = 0 then
        InfCpl := '';

      for i := 0 to ObsCont.Count - 1 do
      begin
        with ObsCont.Items[i] do
          TmpStr := TmpStr + XCampo + ': ' + XTexto + ';';
      end;
      if Length(wObs) > 0 then
        wObs := wObs + ';';
      wObs := wObs + TmpStr + InfCpl;
      TmpStr := '';

      //Contingencia
      if FNFe.Ide.tpEmis=teNORMAL then
        wContingencia := ''
      else
      begin
        if (FNFe.Ide.tpEmis = teContingencia) or (FNFe.Ide.tpEmis = teFSDA) or (FNFe.Ide.tpEmis = teSCAN) then
          wContingencia := 'DANFE EM CONTINGÊNCIA, IMPRESSO EM DECORRÊNCIA DE PROBLEMAS TÉCNICOS'
        else if FNFe.Ide.tpEmis = teDPEC then
          wContingencia := 'DANFE IMPRESSO EM CONTINGÊNCIA - DPEC REGULARMENTE RECEBIDA PELA RECEITA FEDERAL DO BRASIL';
          wContingencia := wContingencia + ';' +
                           'DATA/HORA INÍCIO: ' + DFeUtil.SeSenao(FNFe.ide.dhCont = 0, ' ', DateTimeToStr(FNFe.ide.dhCont)) + ';'+
                           'MOTIVO CONTINGÊNCIA: ' + DFeUtil.SeSenao(DFeUtil.EstaVazio(FNFe.ide.xJust), ' ', FNFe.ide.xJust);
      end;
      if Length(wObs) > 0 then
        wObs := wObs + ';';
      wObs := wObs + wContingencia;

      vTemp := TStringList.Create;
      try
        if Trim(wObs) <> '' then
        begin
          Campos := Split(';', wObs);
          for IndexCampo := 0 to Length(Campos) - 1 do
              vTemp.Add(Campos[IndexCampo]);
           wLinhasObs := 1; //TotalObS(vTemp.Text);
           TmpStr := vTemp.Text;

           BufferInfCpl := TmpStr;
        end
        else
           BufferInfCpl := '';

      finally
        vTemp.Free;
      end;
    end;

    FieldByName('OBS').AsString        := BufferInfCpl;
    FieldByName('LinhasOBS').AsInteger := wLinhasObs;

    Post;
  end;
end;

procedure TdmACBrNFeFR.CarregaISSQN;
begin
  with cdsISSQN do
  begin
    Close;
    FieldDefs.Clear;
    FieldDefs.Add('vSERV', ftFloat);
    FieldDefs.Add('vBC', ftFloat);
    FieldDefs.Add('vISS', ftFloat);

    CreateDataSet;
    Append;
    with FNFe.Total.ISSQNtot do
    begin
      FieldByName('vSERV').AsFloat := DFeUtil.StringToFloatDef(FloatToStr(VServ), 0);
      FieldByName('vBC').AsFloat := DFeUtil.StringToFloatDef(FloatToStr(VBC), 0);
      FieldByName('vISS').AsFloat := DFeUtil.StringToFloatDef(FloatToStr(VISS), 0);
    end;
    Post;
  end;
end;

procedure TdmACBrNFeFR.CarregaLocalEntrega;
begin
  { local de entrega }
  with cdsLocalEntrega do
  begin
    Close;
    FieldDefs.Clear;
    FieldDefs.Add('CNPJ', ftString, 18); //recebe CPF tb
    FieldDefs.Add('XLgr', ftString, 60);
    FieldDefs.Add('Nro', ftString, 60);
    FieldDefs.Add('XCpl', ftString, 60);
    FieldDefs.Add('XBairro', ftString, 60);
    FieldDefs.Add('CMun', ftString, 7);
    FieldDefs.Add('XMun', ftString, 60);
    FieldDefs.Add('UF', ftString, 2);

    CreateDataSet;

    if DFeUtil.NaoEstaVazio(FNFe.Entrega.CNPJCPF) then
    begin
      Append;

      with FNFe.Entrega do
      begin
        if DFeUtil.NaoEstaVazio(CNPJCPF) then
        begin
          if Length(CNPJCPF) > 11 then
             FieldByName('CNPJ').AsString := DFeUtil.FormatarCNPJ(CNPJCPF)
          else
             FieldByName('CNPJ').AsString := DFeUtil.FormatarCPF(CNPJCPF);
        end
        else
           FieldByName('CNPJ').AsString := DFeUtil.FormatarCNPJ(DFeUtil.Poem_Zeros(0, 18));

        FieldByName('Xlgr').AsString := XLgr;
        FieldByName('Nro').AsString := Nro;
        FieldByName('XCpl').AsString := XCpl;
        FieldByName('XBairro').AsString := XBairro;
        FieldByName('CMun').AsString := inttostr(CMun);
        FieldByName('XMun').AsString := CollateBr(XMun);
        FieldByName('UF').AsString := UF;
      end;
      Post;
    end;
  end;
end;

procedure TdmACBrNFeFR.CarregaLocalRetirada;
begin
  { local de retirada }
  with cdsLocalRetirada do
  begin
    Close;
    FieldDefs.Clear;
    FieldDefs.Add('CNPJ', ftString, 18); //recebe CPF tb
    FieldDefs.Add('XLgr', ftString, 60);
    FieldDefs.Add('Nro', ftString, 60);
    FieldDefs.Add('XCpl', ftString, 60);
    FieldDefs.Add('XBairro', ftString, 60);
    FieldDefs.Add('CMun', ftString, 7);
    FieldDefs.Add('XMun', ftString, 60);
    FieldDefs.Add('UF', ftString, 2);

    CreateDataSet;

    if DFeUtil.NaoEstaVazio(FNFe.Retirada.CNPJCPF) then
    begin
      Append;

      with FNFe.Retirada do
      begin
        if DFeUtil.NaoEstaVazio(CNPJCPF) then
        begin
          if Length(CNPJCPF) > 11 then
             FieldByName('CNPJ').AsString := DFeUtil.FormatarCNPJ(CNPJCPF)
          else
             FieldByName('CNPJ').AsString := DFeUtil.FormatarCPF(CNPJCPF);
        end
        else
           FieldByName('CNPJ').AsString := DFeUtil.FormatarCNPJ(DFeUtil.Poem_Zeros(0, 18));

        FieldByName('Xlgr').AsString := XLgr;
        FieldByName('Nro').AsString := Nro;
        FieldByName('XCpl').AsString := XCpl;
        FieldByName('XBairro').AsString := XBairro;
        FieldByName('CMun').AsString := inttostr(CMun);
        FieldByName('XMun').AsString := CollateBr(XMun);
        FieldByName('UF').AsString := UF;
      end;
      Post;
    end;
  end;
end;

procedure TdmACBrNFeFR.CarregaParametros;
var
  vChave_Contingencia: String;
  vResumo: String;
begin
  { parâmetros }
  with cdsParametros do
  begin
    Close;
    FieldDefs.Clear;
    FieldDefs.Add('ResumoCanhoto', ftString, 200);
    FieldDefs.Add('Mensagem0', ftString, 60);
    FieldDefs.Add('Imagem', ftString, 256);
    FieldDefs.Add('Sistema', ftString, 60);
    FieldDefs.Add('Usuario', ftString, 60);
    FieldDefs.Add('Fax', ftString, 60);
    FieldDefs.Add('Site', ftString, 60);
    FieldDefs.Add('Email', ftString, 60);
    FieldDefs.Add('Desconto', ftString, 60);
    FieldDefs.Add('ChaveAcesso_Descricao', ftString, 90);
    FieldDefs.Add('Contingencia_ID', ftString, 36);
    FieldDefs.Add('Contingencia_Descricao', ftString, 60);
    FieldDefs.Add('Contingencia_Valor', ftString, 60);
    FieldDefs.Add('LinhasPorPagina', ftInteger);
    FieldDefs.Add('LogoExpandido', ftString, 1);
    CreateDataSet;
    Append;

    vResumo := '';
    if DANFEClassOwner.ExibirResumoCanhoto then
    begin
       if DFeUtil.EstaVazio(DANFEClassOwner.ExibirResumoCanhoto_Texto) then
          vResumo := 'Emissão: ' + DFeUtil.FormatDate(DateToStr(FNFe.Ide.DEmi)) + '  Dest/Reme: ' + FNFe.Dest.XNome + '  Valor Total: ' + DFeUtil.FormatFloat(FNFe.Total.ICMSTot.VNF)
       else
          vResumo := DANFEClassOwner.ExibirResumoCanhoto_Texto;
    end;
    FieldByName('ResumoCanhoto').AsString := vResumo;

    if (FNFe.Ide.TpAmb = taHomologacao) then
      FieldByName('Mensagem0').AsString := 'NFe sem Valor Fiscal - HOMOLOGAÇÃO'
    else
    begin
      if not (FNFe.Ide.tpEmis in [teContingencia, teFSDA]) then
      begin
        if ((DFeUtil.EstaVazio(FDANFEClassOwner.ProtocoloNFe)) and
            (DFeUtil.EstaVazio(FNFe.procNFe.nProt))) then
          FieldByName('Mensagem0').AsString := 'NFe sem Autorização de Uso da SEFAZ'
        else
        if (not ((DFeUtil.EstaVazio(FDANFEClassOwner.ProtocoloNFe)) and
           (DFeUtil.EstaVazio(FNFe.procNFe.nProt)))) and
           (FNFe.procNFe.cStat = 101) then
          FieldByName('Mensagem0').AsString := 'NFe Cancelada'
        else
        begin
          if FDANFEClassOwner.NFeCancelada then
            FieldByName('Mensagem0').AsString := 'NFe Cancelada'
          else
            FieldByName('Mensagem0').AsString := '';
        end;
      end
      else
        FieldByName('Mensagem0').AsString := '';
    end;

    // Carregamento da imagem
    if DANFEClassOwner.Logo <> '' then
      FieldByName('Imagem').AsString := DANFEClassOwner.Logo;

    if DANFEClassOwner.ExpandirLogoMarca then
      FieldByName('LogoExpandido').AsString := '1'
    else
      FieldByName('LogoExpandido').AsString := '0';
    
    if FDANFEClassOwner.Sistema <> '' then
      FieldByName('Sistema').AsString := FDANFEClassOwner.Sistema
    else
      FieldByName('Sistema').AsString := 'Projeto ACBr - http://acbr.sf.net';

    if FDANFEClassOwner.Usuario <> '' then
      FieldByName('Usuario').AsString := ' - ' + FDANFEClassOwner.Usuario
    else
      FieldByName('Usuario').AsString := '';

    if FDANFEClassOwner.Fax <> '' then
      FieldByName('Fax').AsString := ' - FAX ' + FDANFEClassOwner.Fax
    else
      FieldByName('Fax').AsString := '';

    FieldByName('Site').AsString := FDANFEClassOwner.Site;
    FieldByName('Email').AsString := FDANFEClassOwner.Email;

    if FDANFEClassOwner.ImprimirDescPorc then
      FieldByName('Desconto').AsString := 'DESC %'
    else
      FieldByName('Desconto').AsString := 'V.DESC.';

    if ((FNFe.Ide.tpEmis=teNormal) or (FNFe.Ide.tpEmis = teSCAN)) then
    begin
      FieldByName('ChaveAcesso_Descricao').AsString := 'CHAVE DE ACESSO';
      FieldByName('Contingencia_ID').AsString := '';

      if ((FDANFEClassOwner.NFeCancelada) or (FNFe.procNFe.cStat=101)) then
        FieldByName('Contingencia_Descricao').AsString := 'PROTOCOLO DE HOMOLOGAÇÃO DO CANCELAMENTO'
      else
        FieldByName('Contingencia_Descricao').AsString := 'PROTOCOLO DE AUTORIZAÇÃO DE USO';

      if DFeUtil.EstaVazio(FDANFEClassOwner.ProtocoloNFe) then
      begin
        if not (FNFe.Ide.tpEmis in [teContingencia, teFSDA]) and DFeUtil.EstaVazio(FNFe.procNFe.nProt) then
          FieldByName('Contingencia_Valor').AsString := 'NFe sem Autorização de Uso da SEFAZ'
        else
          FieldByName('Contingencia_Valor').AsString := FNFe.procNFe.nProt + ' ' + DFeUtil.SeSenao(FNFe.procNFe.dhRecbto <> 0, DateTimeToStr(FNFe.procNFe.dhRecbto), '');
      end
      else
        FieldByName('Contingencia_Valor').AsString := FDANFEClassOwner.ProtocoloNFe;
    end
    else
    begin
      vChave_Contingencia := NotaUtil.GerarChaveContingencia(FNFe);
      FieldByName('ChaveAcesso_Descricao').AsString := 'CHAVE DE ACESSO';
      FieldByName('Contingencia_ID').AsString := vChave_Contingencia;

      if ((FNFe.Ide.tpEmis = teContingencia) or (FNFe.Ide.tpEmis = teFSDA)) then
      begin
        FieldByName('Contingencia_Descricao').AsString := 'DADOS DA NF-E';
        FieldByName('Contingencia_Valor').AsString := NotaUtil.FormatarChaveContigencia(vChave_Contingencia);
      end
      else
      if (FNFe.Ide.tpEmis = teDPEC) then
      begin
        FieldByName('Contingencia_Descricao').AsString := 'NÚMERO DE REGISTRO DPEC';

        //precisa testar
        if DFeUtil.EstaVazio(FDANFEClassOwner.ProtocoloNFe) then
          raise EACBrNFeException.Create('Protocolo de Registro no DPEC não informado.')
        else
          FieldByName('Contingencia_Valor').AsString := FDANFEClassOwner.ProtocoloNFe;
      end;
    end;

    FieldByName('LinhasPorPagina').AsInteger := FDANFEClassOwner.ProdutosPorPagina;
    Post;
  end;
end;

procedure TdmACBrNFeFR.CarregaTransportador;
var
  wFrete: String;
begin
  with cdsTransportador do
  begin
    Close;
    FieldDefs.Clear;
    FieldDefs.Add('ModFrete', ftString, 14);
    FieldDefs.Add('CNPJCPF', ftString, 18);
    FieldDefs.Add('XNome', ftString, 60);
    FieldDefs.Add('IE', ftString, 14);
    FieldDefs.Add('XEnder', ftString, 60);
    FieldDefs.Add('XMun', ftString, 60);
    FieldDefs.Add('UF', ftString, 2);

    CreateDataSet;
    Append;

    with FNFe.Transp do
    begin
      case ModFrete of
        mfContaEmitente: wFrete:='0-EMITENTE';
        mfContaDestinatario: wFrete:='1-DEST/REM';
        mfContaTerceiros: wFrete:='2-TERCEIROS';
        mfSemFrete: wFrete:='9-SEM FRETE';
      end;
      FieldByName('ModFrete').AsString := wFrete;

      with Transporta do
      begin
        if DFeUtil.NaoEstaVazio(CNPJCPF) then
        begin
          if Length(CNPJCPF) > 11 then
            FieldByName('CNPJCPF').AsString := DFeUtil.FormatarCNPJ(CNPJCPF)
          else
            FieldByName('CNPJCPF').AsString := DFeUtil.FormatarCPF(CNPJCPF);
        end
        else
          FieldByName('CNPJCPF').AsString := '';

        FieldByName('XNome').AsString := XNome;
        FieldByName('IE').AsString := IE;
        FieldByName('XEnder').AsString := XEnder;
        FieldByName('XMun').AsString := CollateBr(XMun);
        FieldByName('UF').AsString := UF;
      end;
    end;

    Post;
  end;
end;

procedure TdmACBrNFeFR.CarregaVeiculo;
begin
  with cdsVeiculo do
  begin
    Close;
    FieldDefs.Clear;
    FieldDefs.Add('PLACA', ftString, 8);
    FieldDefs.Add('UF', ftString, 2);
    FieldDefs.Add('RNTC', ftString, 20);

    CreateDataSet;
    Append;

    with FNFe.Transp.VeicTransp do
    begin
      FieldByName('PLACA').AsString := Placa;
      FieldByName('UF').AsString := UF;
      FieldByName('RNTC').AsString := RNTC;
    end;

    Post;
  end;
end;

procedure TdmACBrNFeFR.CarregaVolumes;
var
  i: Integer;
begin
  with cdsVolumes do
  begin
    Close;
    FieldDefs.Clear;
    FieldDefs.Add('QVol', ftFloat);
    FieldDefs.Add('Esp', ftString, 60);
    FieldDefs.Add('Marca', ftString, 60);
    FieldDefs.Add('NVol', ftString, 60);
    FieldDefs.Add('PesoL', ftFloat);
    FieldDefs.Add('PesoB', ftFloat);

    CreateDataSet;

    for i := 0 to NFe.Transp.Vol.Count - 1 do
    begin
      Append;
      with FNFe.Transp.Vol[i] do
      begin
        FieldByName('QVol').AsFloat := DFeUtil.StringToFloatDef(IntToStr(QVol), 0);
        FieldByName('Esp').AsString := Esp;
        FieldByName('Marca').AsString := Marca;
        FieldByName('NVol').AsString := NVol;
        FieldByName('PesoL').AsFloat := DFeUtil.StringToFloatDef(FloatToStr(PesoL), 0);
        FieldByName('PesoB').AsFloat := DFeUtil.StringToFloatDef(FloatToStr(PesoB), 0);
      end;
      Post;
    end;

  end;
end;

procedure TdmACBrNFeFR.CarregaDadosEventos;
var
  i: Integer;
  CondicoesUso, Correcao: String;
begin
  with cdsEventos do
  begin
    Close;
    FieldDefs.Clear;

    FieldDefs.Add('DescricaoTipoEvento', ftString, 150);
    FieldDefs.Add('Modelo', ftString, 2);
    FieldDefs.Add('Serie', ftString, 3);
    FieldDefs.Add('Numero', ftString, 9);
    FieldDefs.Add('MesAno', ftString, 5);
    FieldDefs.Add('Barras', ftString, 44);
    FieldDefs.Add('ChaveAcesso', ftString, 60);

    FieldDefs.Add('cOrgao', ftInteger);
    FieldDefs.Add('tpAmb', ftString, 100);
    FieldDefs.Add('dhEvento', ftDateTime);
    FieldDefs.Add('TipoEvento', ftString, 6);
    FieldDefs.Add('DescEvento', ftString, 100);
    FieldDefs.Add('nSeqEvento', ftInteger);
    FieldDefs.Add('versaoEvento', ftString, 10);
    FieldDefs.Add('cStat', ftInteger);
    FieldDefs.Add('xMotivo', ftString, 100);
    FieldDefs.Add('nProt', ftString, 20);
    FieldDefs.Add('dhRegEvento', ftDateTime);

    FieldDefs.Add('xJust', ftBlob);
    FieldDefs.Add('xCondUso', ftBlob);
    FieldDefs.Add('xCorrecao', ftBlob);

    CreateDataSet;

    for i := 0 to FEvento.Evento.Count - 1 do
    begin
      Append;

      with Evento.Evento[i] do
      begin
        FieldByName('DescricaoTipoEvento').AsString := InfEvento.DescricaoTipoEvento(InfEvento.tpEvento);

        // nota fiscal eletronica
        FieldByName('Modelo').AsString      := Copy(InfEvento.chNFe, 21, 2);
        FieldByName('Serie').AsString       := Copy(InfEvento.chNFe, 23, 3);
        FieldByName('Numero').AsString      := Copy(InfEvento.chNFe, 26, 9);
        FieldByName('MesAno').AsString      := Copy(InfEvento.chNFe, 05, 2) + '/' + copy(InfEvento.chNFe, 03, 2);
        FieldByName('Barras').AsString      := InfEvento.chNFe;
        FieldByName('ChaveAcesso').AsString := NotaUtil.FormatarChaveAcesso(InfEvento.chNFe);

        // Carta de correção eletrônica
        FieldByName('cOrgao').AsInteger := InfEvento.cOrgao;

        case InfEvento.tpAmb of
          taProducao:    FieldByName('tpAmb').AsString := 'PRODUÇÃO';
          taHomologacao: FieldByName('tpAmb').AsString := 'HOMOLOGAÇÃO - SEM VALOR FISCAL';
        end;

        FieldByName('dhEvento').AsDateTime    := InfEvento.dhEvento;
        FieldByName('TipoEvento').AsString    := InfEvento.TipoEvento;
        FieldByName('DescEvento').AsString    := InfEvento.DescEvento;
        FieldByName('nSeqEvento').AsInteger   := InfEvento.nSeqEvento;
        FieldByName('versaoEvento').AsString  := InfEvento.versaoEvento;
        FieldByName('cStat').AsInteger        := RetInfEvento.cStat;
        FieldByName('xMotivo').AsString       := RetInfEvento.xMotivo;
        FieldByName('nProt').AsString         := RetInfEvento.nProt;
        FieldByName('dhRegEvento').AsDateTime := RetInfEvento.dhRegEvento;

        if InfEvento.tpEvento <> teCCe then
        begin
          FieldByName('xJust').AsString := InfEvento.detEvento.xJust;
        end
        else
        begin
          CondicoesUso := InfEvento.detEvento.xCondUso;
          CondicoesUso := StringReplace(CondicoesUso, 'com: I', 'com:'+#13+' I', [rfReplaceAll]);
          CondicoesUso := StringReplace(CondicoesUso, ';', ';' + #13, [rfReplaceAll]);

          Correcao := InfEvento.detEvento.xCorrecao;
          Correcao := StringReplace(InfEvento.detEvento.xCorrecao, ';', #13, [rfReplaceAll]);

          FieldByName('xCondUso').AsString  := CondicoesUso;
          FieldByName('xCorrecao').AsString := Correcao;
        end;
      end;

      Post;
    end;
  end;
end;

constructor TdmACBrNFeFR.Create(AOwner: TComponent);
begin
  inherited;
  FDANFEClassOwner := TACBrNFeDANFEClass(AOwner);
end;

end.

