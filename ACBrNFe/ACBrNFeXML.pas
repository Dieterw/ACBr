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
|* 09/03/2009: Dulcemar P. Zilli
|*  - Incluido IPI, II e  DI
|* 11/03/2009: Dulcemar P. Zilli
|*  - Observações do Fisco
|* 13/03/2009: Dulcemar P. Zilli
|*  - Incluida Informações Reboque Transportador
|* 14/03/2009: Dulcemar P. Zilli
|*  - Incluida Informações ISSQN, Retenções Tributos
|* 17/03/2009: Dulcemar P. Zilli
|*  - Separado unidade Tributavel da Unidade de Comercialização
|* 02/05/2009: João H. Souza
|*  - Inclusão: Frete, Seguro de DadosProduto
******************************************************************************}

unit ACBrNFeXML;

interface

uses
  Classes, SysUtils, 
  XMLIntf, XMLDoc, ACBrNFeTypes,
  ACBrNFe_nfe;

type

  TNotaFiscalXML = Class(TPersistent)
  private
    FNotaFiscal : TPersistent;
    FConfiguracoes : TPersistent;
    FMsg: WideString;
    FConfirmada: Boolean;
    FNFe: IXMLTNFe;
    FNFeChave: String;
    procedure ValidaIdentificacao;
    procedure ValidaEmitente;
    procedure ValidaDestinatario;
    procedure ValidaProdutos;
    procedure ValidaTranportador;
  public
    procedure GerarNFe;
    procedure Assinar;
    procedure Valida;
    procedure LoadFromFile(Const AFile: String);
    procedure SaveToFile(AFile: String='');
    procedure Imprimir;
    procedure ImprimirPDF;
    function GetNFeChave: String;
    property Msg: WideString read FMsg write FMsg;
    property Confirmada: Boolean read FConfirmada write FConfirmada;
    property NFe: IXMLTNFe read FNFe write FNFe;
    property NFeChave: String read FNFeChave write FNFeChave;
    constructor Create(AOwner: TPersistent; ANotaFiscalEletronica: TPersistent);reintroduce;
    destructor Destroy; override;
  published

  end;

implementation

uses ACBrNFeUtil, ACBrNFe, ACBrNFeConst,
     ACBrNFeNotasFiscais, ACBrNFeDM,
     ACBrNFeTransportador, ACBrNFeEmitente,
     ACBrNFeDestinatario, ACBrNFeFatura,
     ACBrNFeIdentificacao, ACBrNFeDadosAdicionais,
     ACBrNFeConfiguracoes;

{ TNotaFiscalXML }

procedure TNotaFiscalXML.Assinar;
var
  vXmlDoc: IXMLDocument;
  vAssinada : WideString;
begin

{$IFDEF ACBrNFeCAPICOM}
  if not(NotaUtil.Assinar(FNFe.XML, TConfiguracoes(FConfiguracoes).Certificados.GetCertificado , vAssinada, FMsg)) then
    raise Exception.Create('Falha ao assinar Nota Fiscal Eletrônica '+
                            FNFe.InfNFe.Ide.CNF+LineBreak+FMsg);
{$ELSE}
  if not(NotaUtil.Assinar(FNFe.XML, TConfiguracoes(FConfiguracoes).Certificados.Certificado , TConfiguracoes(FConfiguracoes).Certificados.Senha, vAssinada, FMsg)) then
    raise Exception.Create('Falha ao assinar Nota Fiscal Eletrônica '+
                            FNFe.InfNFe.Ide.CNF+LineBreak+FMsg);
{$ENDIF}

  vXmlDoc := LoadXMLData(vAssinada);
  vXmlDoc.Encoding := 'UTF-8';
  FNFe := GetNFe(vXmlDoc);
  if TConfiguracoes(FConfiguracoes).Geral.Salvar then
    TConfiguracoes(FConfiguracoes).Geral.Save(StringReplace(FNFe.InfNFe.Id, 'NFe', '', [rfIgnoreCase])+'-nfe.xml', NFe.XML);
end;

constructor TNotaFiscalXML.Create(AOwner: TPersistent; ANotaFiscalEletronica: TPersistent);
begin
  inherited Create;
  FNotaFiscal           := AOwner;
  FConfiguracoes        := TACBrNFe(ANotaFiscalEletronica).Configuracoes;
  FNFe                  := NewNFe;
  FConfirmada           := False;
end;

destructor TNotaFiscalXML.Destroy;
begin

  inherited;
end;

procedure TNotaFiscalXML.GerarNFe;
var
  i,x: Integer;
begin
  ValidaIdentificacao;
  ValidaEmitente;
  ValidaDestinatario;
  ValidaTranportador;
  ValidaProdutos;

  FNFe := NewNFe;
  with NotaFiscal(FNotaFiscal), FNFe.InfNFe do
  begin
    Versao    := NFenviNFe;
    Id        := 'NFe'+NotaUtil.ChaveAcesso(Emitente.Endereco.UFCodigo, Identificacao.DataEmissao, Emitente.Cnpj, Identificacao.Serie, Identificacao.Numero,Identificacao.Codigo);
  end;

  with NotaFiscal(FNotaFiscal) , FNFe.InfNFe.Ide do
  begin
    CUF     := IntToStr(Emitente.Endereco.UFCodigo);
    CNF     := NotaUtil.Poem_Zeros(Identificacao.Codigo, 9);
    NatOp   := NotaUtil.ParseText(Identificacao.NaturezaOperacao, True);
    IndPag  := IntToStr(Ord(Identificacao.FormaPagamento));
    Mod_    := NotaUtil.Poem_Zeros(Identificacao.Modelo, 2);
    Serie   := IntToStr(Identificacao.Serie);
    NNF     := IntToStr(Identificacao.Numero);
    DEmi    := FormatDateTime('YYYY-MM-DD', Identificacao.DataEmissao);
    if not(FormatDateTime('YYYY-MM-DD', Identificacao.DataSaida) = '1899-12-30') then
      DSaiEnt := FormatDateTime('YYYY-MM-DD', Identificacao.DataSaida);
    TpNF    := IntToStr(Ord(Identificacao.Tipo));
    CMunFG  := IntToStr(Emitente.Endereco.Cidade.Codigo);
    TpImp   := IntToStr(TConfiguracoes(FConfiguracoes).Geral.DANFECodigo);
    TpEmis  := IntToStr(TConfiguracoes(FConfiguracoes).Geral.FormaEmissaoCodigo);
    CDV     := NotaUtil.LasString(FNFe.InfNFe.Id);
    TpAmb   := IntToStr(TConfiguracoes(FConfiguracoes).WebServices.AmbienteCodigo);
    FinNFe  := IntToStr(Ord(Identificacao.Finalidade)+1);
    ProcEmi := '0';
    VerProc := NfVersao;
  end;

  with NotaFiscal(FNotaFiscal), FNFe.InfNFe.Emit do
  begin
    CNPJ  := Emitente.Cnpj;
    XNome := NotaUtil.ParseText(Emitente.Nome.RazaoSocial);
    if NotaUtil.NaoEstaVazio(Emitente.Nome.Fantasia) then
      XFant := NotaUtil.ParseText(Emitente.Nome.Fantasia);

    with EnderEmit do
    begin
      XLgr    := NotaUtil.ParseText(Emitente.Endereco.Logradouro);
      Nro     := Trim(Emitente.Endereco.Numero);
      if NotaUtil.NaoEstaVazio(Emitente.Endereco.Complemento) then
        XCpl := NotaUtil.ParseText(Emitente.Endereco.Complemento);
      XBairro := NotaUtil.ParseText(Emitente.Endereco.Bairro);
      CMun    := IntToStr(Emitente.Endereco.Cidade.Codigo);
      XMun    := NotaUtil.ParseText(Emitente.Endereco.Cidade.Descricao);
      UF      := Emitente.Endereco.UF;
      if NotaUtil.NaoEstaVazio(Emitente.Endereco.Cep) then
        CEP := Emitente.Endereco.Cep;
      if NotaUtil.NaoEstaZerado(Emitente.Endereco.Pais.Codigo) then
        CPais := NotaUtil.Poem_Zeros(Emitente.Endereco.Pais.Codigo, 4);
      if NotaUtil.NaoEstaVazio(Emitente.Endereco.Pais.Descricao) then
        XPais := NotaUtil.ParseText(Emitente.Endereco.Pais.Descricao);
      if NotaUtil.NaoEstaVazio(Emitente.Endereco.Fone) then
        Fone := Emitente.Endereco.Fone;
    end;
    IE := Emitente.IE;
    if NotaUtil.NaoEstaVazio(Emitente.IM) then
      IM := Emitente.IM;
    if NotaUtil.NaoEstaVazio(Emitente.IEST) then
      IEST := Emitente.IEST;
    if NotaUtil.NaoEstaVazio(Emitente.CNAE) then
      CNAE := Emitente.CNAE;

  end;

  with NotaFiscal(FNotaFiscal), FNFe.InfNFe.Dest do
  begin
    if Length(Destinatario.CNPJCPF) > 11 then
      CNPJ := Destinatario.CNPJCPF
    else
      CPF := Destinatario.CNPJCPF;

    XNome := NotaUtil.ParseText(Destinatario.NomeRazao);
    with EnderDest do
    begin
      XLgr    := NotaUtil.ParseText(Destinatario.Endereco.Logradouro);
      Nro     := Trim(Destinatario.Endereco.Numero);
      if NotaUtil.NaoEstaVazio(Destinatario.Endereco.Complemento) then
        XCpl    := NotaUtil.ParseText(Destinatario.Endereco.Complemento);
      XBairro := NotaUtil.ParseText(Destinatario.Endereco.Bairro, True);
      CMun    := IntToStr(Destinatario.Endereco.Cidade.Codigo);
      XMun    := NotaUtil.ParseText(Destinatario.Endereco.Cidade.Descricao);
      UF      := Destinatario.Endereco.UF;
      if NotaUtil.NaoEstaVazio(Destinatario.Endereco.Cep) then
        CEP     := Destinatario.Endereco.CEP;
      if NotaUtil.NaoEstaZerado(Destinatario.Endereco.Pais.Codigo) then
        CPais   := IntToStr(Destinatario.Endereco.Pais.Codigo);
      if NotaUtil.NaoEstaVazio(Destinatario.Endereco.Pais.Descricao) then
        XPais   := NotaUtil.ParseText(Destinatario.Endereco.Pais.Descricao);
      if NotaUtil.NaoEstaVazio(Destinatario.Endereco.Fone) then
        Fone    := Destinatario.Endereco.Fone;
    end;

    FNFe.InfNFe.Dest.IE   := Destinatario.IE;
    if Length(Destinatario.ISUF) > 0 then
       FNFe.InfNFe.Dest.ISUF := Destinatario.ISUF;
  end;

  with NotaFiscal(FNotaFiscal) do
  begin
    for i := 0 to DadosProdutos.Count-1 do
    begin
      with FNFe.InfNFe.Det.Add do
      begin
        NItem := IntToStr(i+1);
        with Prod do
        begin
          CProd    := DadosProdutos.Items[i].Codigo;
          CEAN := DadosProdutos.Items[i].EAN;
          XProd    := NotaUtil.ParseText(DadosProdutos.Items[i].Descricao);
          if NotaUtil.NaoEstaVazio(DadosProdutos.Items[i].NCM) then
            NCM := DadosProdutos.Items[i].NCM;
          CFOP     := IntToStr(DadosProdutos.Items[i].CFOP);

          UCom     := DadosProdutos.Items[i].Unidade;
          QCom     := NotaUtil.FormatFloat(DadosProdutos.Items[i].Quantidade, '0.0000');
          VUnCom   := NotaUtil.FormatFloat(DadosProdutos.Items[i].ValorUnitario, '0.0000');

          VProd    := NotaUtil.FormatFloat(DadosProdutos.Items[i].ValorTotal, '0.00');

          CEANTrib := DadosProdutos.Items[i].GTINUnidadeTributavel;
          if (Trim(DadosProdutos.Items[i].UnidadeTributavel) = '') then
            UTrib    := DadosProdutos.Items[i].Unidade
          else
            UTrib    := DadosProdutos.Items[i].UnidadeTributavel;
          QTrib    := NotaUtil.FormatFloat(DadosProdutos.Items[i].QuantidadeTributavel, '0.0000');
          VUnTrib  := NotaUtil.FormatFloat(DadosProdutos.Items[i].ValorUnitarioTributacao, '0.0000');

          if NotaUtil.NaoEstaZerado(DadosProdutos.Items[i].ValorFrete) then
            VFrete := NotaUtil.FormatFloat(DadosProdutos.Items[i].ValorFrete, '0.00');
          if NotaUtil.NaoEstaZerado(DadosProdutos.Items[i].ValorSeguro) then
            VSeg := NotaUtil.FormatFloat(DadosProdutos.Items[i].ValorSeguro, '0.00');
          if NotaUtil.NaoEstaZerado(DadosProdutos.Items[i].ValorDesconto) then
            VDesc := NotaUtil.FormatFloat(DadosProdutos.Items[i].ValorDesconto, '0.00');
        end;

        if NotaUtil.NaoEstaVazio(DadosProdutos.Items[i].DI.NumeroDI) then begin
          with Prod.DI.Add do begin
            with Prod.DI do begin
              NDI := DadosProdutos.Items[i].DI.NumeroDI;

              if not(FormatDateTime('YYYY-MM-DD', DadosProdutos.Items[i].DI.DataRegistroDI) = '1899-12-30') then
                DDI := FormatDateTime('YYYY-MM-DD', DadosProdutos.Items[i].DI.DataRegistroDI);

              if NotaUtil.NaoEstaVazio(DadosProdutos.Items[i].DI.LocalDesembaraco) then
                XLocDesemb := DadosProdutos.Items[i].DI.LocalDesembaraco;

              if NotaUtil.NaoEstaVazio(DadosProdutos.Items[i].DI.UFDesembaraco) then
                UFDesemb := DadosProdutos.Items[i].DI.UFDesembaraco;

              if not(FormatDateTime('YYYY-MM-DD', DadosProdutos.Items[i].DI.DataDesembaraco) = '1899-12-30') then
                DDesemb := FormatDateTime('YYYY-MM-DD', DadosProdutos.Items[i].DI.DataDesembaraco);

              if NotaUtil.NaoEstaVazio(DadosProdutos.Items[i].DI.CodigoExportador) then
                CExportador := DadosProdutos.Items[i].DI.CodigoExportador;

              for x:=0 to DadosProdutos.Items[i].DI.LADI.Count-1 do begin
                with prod.DI.Items[0].Adi.Add do begin
                  NAdicao := IntToStr(DadosProdutos.Items[i].DI.LADI.Items[x].NumeroAdicao);
                  NSeqAdic := IntToStr(x+1);
                  CFabricante := DadosProdutos.Items[i].DI.LADI.Items[x].CodigoFrabricante;
                  VDescDI := NotaUtil.FormatFloat(DadosProdutos.Items[i].DI.LADI.Items[x].ValorDesconto,'0.00');
                end;
              end;
            end;
          end;
        end;


        with DadosProdutos.Items[i].Tributos.ICMS do
        begin
          if CST = '00' then
            begin
              Imposto.ICMS.ICMS00.Orig  := IntToStr(Ord(ICMS00.Origem));
              Imposto.ICMS.ICMS00.CST   := CST;
              Imposto.ICMS.ICMS00.ModBC := IntToStr(Ord(ICMS00.Modalidade));
              Imposto.ICMS.ICMS00.VBC   := NotaUtil.FormatFloat(ICMS00.ValorBase, '0.00');
              Imposto.ICMS.ICMS00.PICMS := NotaUtil.FormatFloat(ICMS00.Aliquota, '0.00');
              Imposto.ICMS.ICMS00.VICMS := NotaUtil.FormatFloat(ICMS00.Valor, '0.00');
            end
          else if CST = '10' then
            begin
              Imposto.ICMS.ICMS10.Orig     := IntToStr(Ord(ICMS10.Origem));
              Imposto.ICMS.ICMS10.CST      := CST;
              Imposto.ICMS.ICMS10.ModBC    := IntToStr(Ord(ICMS10.Modalidade));
              Imposto.ICMS.ICMS10.VBC      := NotaUtil.FormatFloat(ICMS10.ValorBase, '0.00');
              Imposto.ICMS.ICMS10.PICMS    := NotaUtil.FormatFloat(ICMS10.Aliquota, '0.00');
              Imposto.ICMS.ICMS10.VICMS    := NotaUtil.FormatFloat(ICMS10.Valor, '0.00');
              Imposto.ICMS.ICMS10.ModBCST  := IntToStr(Ord(ICMS10.ModalidadeST));
              if not(ICMS10.PercentualMargemST = 0) then
                Imposto.ICMS.ICMS10.PMVAST   := NotaUtil.FormatFloat(ICMS10.PercentualMargemST, '0.00');
              if not(ICMS10.PercentualReducaoST = 0) then
                Imposto.ICMS.ICMS10.PRedBCST := NotaUtil.FormatFloat(ICMS10.PercentualReducaoST, '0.00');
              Imposto.ICMS.ICMS10.VBCST    := NotaUtil.FormatFloat(ICMS10.ValorBaseST, '0.00');
              Imposto.ICMS.ICMS10.PICMSST  := NotaUtil.FormatFloat(ICMS10.AliquotaST, '0.00');
              Imposto.ICMS.ICMS10.VICMSST  := NotaUtil.FormatFloat(ICMS10.ValorST, '0.00');
            end
          else if CST = '20' then
            begin
              Imposto.ICMS.ICMS20.Orig     := IntToStr(Ord(ICMS20.Origem));
              Imposto.ICMS.ICMS20.CST      := CST;
              Imposto.ICMS.ICMS20.ModBC    := IntToStr(Ord(ICMS20.Modalidade));
              Imposto.ICMS.ICMS20.PRedBC   := NotaUtil.FormatFloat(ICMS20.PercentualReducao, '0.00');
              Imposto.ICMS.ICMS20.VBC      := NotaUtil.FormatFloat(ICMS20.ValorBase, '0.00');
              Imposto.ICMS.ICMS20.PICMS    := NotaUtil.FormatFloat(ICMS20.Aliquota, '0.00');
              Imposto.ICMS.ICMS20.VICMS    := NotaUtil.FormatFloat(ICMS20.Valor, '0.00');
            end
          else if CST = '30' then
            begin
              Imposto.ICMS.ICMS30.Orig     := IntToStr(Ord(ICMS30.Origem));
              Imposto.ICMS.ICMS30.CST      := CST;
              Imposto.ICMS.ICMS30.ModBCST  := IntToStr(Ord(ICMS30.ModalidadeST));
              if not(ICMS30.PercentualMargemST = 0) then
                Imposto.ICMS.ICMS30.PMVAST   := NotaUtil.FormatFloat(ICMS30.PercentualMargemST, '0.00');
              if not(ICMS30.PercentualReducaoST = 0) then
                Imposto.ICMS.ICMS30.PRedBCST := NotaUtil.FormatFloat(ICMS30.PercentualReducaoST, '0.00');
              Imposto.ICMS.ICMS30.VBCST    := NotaUtil.FormatFloat(ICMS30.ValorBaseST, '0.00');
              Imposto.ICMS.ICMS30.PICMSST  := NotaUtil.FormatFloat(ICMS30.AliquotaST, '0.00');
              Imposto.ICMS.ICMS30.VICMSST  := NotaUtil.FormatFloat(ICMS30.ValorST, '0.00');
            end
          else if (CST = '40') or (CST = '41') or (CST = '50') then
            begin
              Imposto.ICMS.ICMS40.Orig := IntToStr(Ord(ICMS40_41_50.Origem));
              Imposto.ICMS.ICMS40.CST  := CST;
            end
          else if CST = '51' then
            begin
              Imposto.ICMS.ICMS51.Orig     := IntToStr(Ord(ICMS51.Origem));
              Imposto.ICMS.ICMS51.CST      := CST;
              Imposto.ICMS.ICMS51.ModBC    := IntToStr(Ord(ICMS51.Modalidade));
              if not(ICMS51.PercentualReducao = 0) then
                Imposto.ICMS.ICMS51.PRedBC := NotaUtil.FormatFloat(ICMS51.PercentualReducao, '0.00');
              if not(ICMS51.ValorBase = 0) then
                Imposto.ICMS.ICMS51.VBC := NotaUtil.FormatFloat(ICMS51.ValorBase, '0.00');
              if not(ICMS51.Aliquota = 0) then
                Imposto.ICMS.ICMS51.PICMS    := NotaUtil.FormatFloat(ICMS51.Aliquota, '0.00');
              if not(ICMS51.Valor = 0) then
                Imposto.ICMS.ICMS51.VICMS    := NotaUtil.FormatFloat(ICMS51.Valor, '0.00');
            end
          else if CST = '60' then
            begin
              Imposto.ICMS.ICMS60.Orig     := IntToStr(Ord(ICMS60.Origem));
              Imposto.ICMS.ICMS60.CST      := CST;
              Imposto.ICMS.ICMS60.VBCST    := NotaUtil.FormatFloat(ICMS60.ValorBaseST, '0.00');
              Imposto.ICMS.ICMS60.VICMSST  := NotaUtil.FormatFloat(ICMS60.ValorST, '0.00');
            end
          else if CST = '70' then
            begin
              Imposto.ICMS.ICMS70.Orig     := IntToStr(Ord(ICMS70.Origem));
              Imposto.ICMS.ICMS70.CST      := CST;
              Imposto.ICMS.ICMS70.ModBC    := IntToStr(Ord(ICMS70.Modalidade));
              Imposto.ICMS.ICMS70.PRedBC   := NotaUtil.FormatFloat(ICMS70.PercentualReducao, '0.00');
              Imposto.ICMS.ICMS70.VBC      := NotaUtil.FormatFloat(ICMS70.ValorBase, '0.00');
              Imposto.ICMS.ICMS70.PICMS    := NotaUtil.FormatFloat(ICMS70.Aliquota, '0.00');
              Imposto.ICMS.ICMS70.VICMS    := NotaUtil.FormatFloat(ICMS70.Valor, '0.00');
              Imposto.ICMS.ICMS70.ModBCST  := IntToStr(Ord(ICMS70.ModalidadeST));
              if not(ICMS70.PercentualMargemST = 0) then
                Imposto.ICMS.ICMS70.PMVAST   := NotaUtil.FormatFloat(ICMS70.PercentualMargemST, '0.00');
              if not(ICMS70.PercentualReducaoST = 0) then
                Imposto.ICMS.ICMS70.PRedBCST := NotaUtil.FormatFloat(ICMS70.PercentualReducaoST, '0.00');
              Imposto.ICMS.ICMS70.VBCST    := NotaUtil.FormatFloat(ICMS70.ValorBaseST, '0.00');
              Imposto.ICMS.ICMS70.PICMSST  := NotaUtil.FormatFloat(ICMS70.AliquotaST, '0.00');
              Imposto.ICMS.ICMS70.VICMSST  := NotaUtil.FormatFloat(ICMS70.ValorST, '0.00');
            end
          else if CST = '90' then
            begin
              Imposto.ICMS.ICMS90.Orig     := IntToStr(Ord(ICMS90.Origem));
              Imposto.ICMS.ICMS90.CST      := CST;
              Imposto.ICMS.ICMS90.ModBC    := IntToStr(Ord(ICMS90.Modalidade));
              if not(ICMS90.PercentualReducao = 0) then
                Imposto.ICMS.ICMS90.PRedBC   := NotaUtil.FormatFloat(ICMS90.PercentualReducao, '0.00');
              Imposto.ICMS.ICMS90.VBC      := NotaUtil.FormatFloat(ICMS90.ValorBase, '0.00');
              Imposto.ICMS.ICMS90.PICMS    := NotaUtil.FormatFloat(ICMS90.Aliquota, '0.00');
              Imposto.ICMS.ICMS90.VICMS    := NotaUtil.FormatFloat(ICMS90.Valor, '0.00');
              Imposto.ICMS.ICMS90.ModBCST  := IntToStr(Ord(ICMS90.ModalidadeST));
              if not(ICMS90.PercentualMargemST = 0) then
                Imposto.ICMS.ICMS90.PMVAST   := NotaUtil.FormatFloat(ICMS90.PercentualMargemST, '0.00');
              if not(ICMS90.PercentualReducaoST = 0) then
                Imposto.ICMS.ICMS90.PRedBCST := NotaUtil.FormatFloat(ICMS90.PercentualReducaoST, '0.00');
              Imposto.ICMS.ICMS90.VBCST    := NotaUtil.FormatFloat(ICMS90.ValorBaseST, '0.00');
              Imposto.ICMS.ICMS90.PICMSST  := NotaUtil.FormatFloat(ICMS90.AliquotaST, '0.00');
              Imposto.ICMS.ICMS90.VICMSST  := NotaUtil.FormatFloat(ICMS90.ValorST, '0.00');
            end
        end;

        with DadosProdutos.Items[i].Tributos.IPI do
        begin

          if trim(CST) <> '' then begin
            if (ClasseEnquadramento <> '') then
              Imposto.IPI.ClEnq := ClasseEnquadramento;
            if (CNPJProdutor <> '') then
              Imposto.IPI.CNPJProd := CNPJProdutor;
            if (CodigoSeloIPI <> '') then
              Imposto.IPI.CSelo := CodigoSeloIPI;
            if (QuantidadeSelos > 0) then
              Imposto.IPI.QSelo := NotaUtil.FormatFloat(QuantidadeSelos, '0');
            if (CodigoEnquadramento <> '') then
              Imposto.IPI.CEnq  := CodigoEnquadramento;

            if pos(CST, '00 49 50 99') > 0 then
              begin
                Imposto.IPI.IPITrib.CST     := CST;
                Imposto.IPI.IPITrib.VIPI  := NotaUtil.FormatFloat(Valor, '0.00');
                if (Quantidade > 0) then begin
                  Imposto.IPI.IPITrib.QUnid := NotaUtil.FormatFloat(Quantidade, '0.0000');
                  Imposto.IPI.IPITrib.VUnid := NotaUtil.FormatFloat(ValorUnidade, '0.0000');
                end else begin
                  Imposto.IPI.IPITrib.VBC     := NotaUtil.FormatFloat(ValorBase, '0.00');
                  Imposto.IPI.IPITrib.PIPI  := NotaUtil.FormatFloat(Aliquota, '0.00');
                end;
              end
            else if pos(CST, '01 02 03 04 05 51 52 53 54 55') > 0 then begin
              Imposto.IPI.IPINT.CST        := CST;
            end
          end;
        end;


        with DadosProdutos.Items[i].Tributos.II do
        begin
          {Gera somente se um dos campos foi informado diferente de 0 (zero)}
          if (ValorBase <> 0) then
            Imposto.II.VBC := NotaUtil.FormatFloat(ValorBase, '0.00');
          if (ValorDespAduaneiras <> 0) then
            Imposto.II.VDespAdu := NotaUtil.FormatFloat(ValorDespAduaneiras, '0.00');
          if (ValorII <> 0) then
            Imposto.II.VII := NotaUtil.FormatFloat(ValorII, '0.00');
          if (ValorIOF <> 0) then
            Imposto.II.VIOF := NotaUtil.FormatFloat(ValorIOF, '0.00');
        end;


        with DadosProdutos.Items[i].Tributos.PIS do
        begin
          if (CST = '01') or (CST = '02') then
            begin
              Imposto.PIS.PISAliq.CST  := CST;
              Imposto.PIS.PISAliq.VBC  := NotaUtil.FormatFloat(PIS01_02.ValorBase, '0.00');
              Imposto.PIS.PISAliq.PPIS := NotaUtil.FormatFloat(PIS01_02.Aliquota, '0.00');
              Imposto.PIS.PISAliq.VPIS := NotaUtil.FormatFloat(PIS01_02.Valor, '0.00');
            end
          else if CST = '03' then
            begin
              Imposto.PIS.PISQtde.CST       := CST;
              Imposto.PIS.PISQtde.QBCProd   := NotaUtil.FormatFloat(PIS03.Quantidade, '0.0000');
              Imposto.PIS.PISQtde.VAliqProd := NotaUtil.FormatFloat(PIS03.Aliquota, '0.0000');
              Imposto.PIS.PISQtde.VPIS      := NotaUtil.FormatFloat(PIS03.Valor, '0.0000');
            end
          else if (CST = '04') or (CST = '06') or (CST = '07') or (CST = '08') or (CST = '09') then
            begin
              Imposto.PIS.PISNT.CST := CST;
            end
          else if CST = '99' then
            begin
              Imposto.PIS.PISOutr.CST  := CST;
              Imposto.PIS.PISOutr.VPIS := NotaUtil.FormatFloat(PIS99.Valor, '0.00');
              if PIS99.TipoCalculo = tipCValor then
                begin
                  Imposto.PIS.PISOutr.QBCProd   := NotaUtil.FormatFloat(PIS99.Quantidade, '0.0000');
                  Imposto.PIS.PISOutr.VAliqProd := NotaUtil.FormatFloat(PIS99.Aliquota, '0.0000');
                end
              else
                begin
                  Imposto.PIS.PISOutr.VBC  := NotaUtil.FormatFloat(PIS99.ValorBase, '0.00');
                  Imposto.PIS.PISOutr.PPIS := NotaUtil.FormatFloat(PIS99.Aliquota, '0.00');
                end;
            end
        end;

        with DadosProdutos.Items[i].Tributos.PISST do
        begin
          if (ValorBase > 0) then begin
            Imposto.PISST.VBC := NotaUtil.FormatFloat(ValorBase, '0.00');
            Imposto.PISST.PPIS := NotaUtil.FormatFloat(AliquotaPerc, '0.00');
          end else if (Quantidade > 0) then begin
            Imposto.PISST.QBCProd := NotaUtil.FormatFloat(Quantidade, '0.0000');
            Imposto.PISST.VAliqProd := NotaUtil.FormatFloat(AliquotaValor, '0.0000');
          end;
          if (ValorPISST > 0) then
            Imposto.PISST.VPIS := NotaUtil.FormatFloat(ValorPISST, '0.00');

        end;

        with DadosProdutos.Items[i].Tributos.COFINS do
        begin
          if (CST = '01') or (CST = '02') then
            begin
              Imposto.COFINS.COFINSAliq.CST     := CST;
              Imposto.COFINS.COFINSAliq.VBC     := NotaUtil.FormatFloat(COFINS01_02.ValorBase, '0.00');
              Imposto.COFINS.COFINSAliq.PCOFINS := NotaUtil.FormatFloat(COFINS01_02.Aliquota, '0.00');
              Imposto.COFINS.COFINSAliq.VCOFINS := NotaUtil.FormatFloat(COFINS01_02.Valor, '0.00');
            end
          else if CST = '03' then
            begin
              Imposto.COFINS.COFINSQtde.CST       := CST;
              Imposto.COFINS.COFINSQtde.QBCProd   := NotaUtil.FormatFloat(COFINS03.Quantidade, '0.0000');
              Imposto.COFINS.COFINSQtde.VAliqProd := NotaUtil.FormatFloat(COFINS03.Aliquota, '0.0000');
              Imposto.COFINS.COFINSQtde.VCOFINS   := NotaUtil.FormatFloat(COFINS03.Valor, '0.00');
            end
          else if (CST = '04') or (CST = '06') or (CST = '07') or (CST = '08') or (CST = '09') then
            begin
              Imposto.COFINS.COFINSNT.CST := CST;
            end
          else if CST = '99' then
            begin
              Imposto.COFINS.COFINSOutr.CST  := CST;
              Imposto.COFINS.COFINSOutr.VCOFINS := NotaUtil.FormatFloat(COFINS99.Valor, '0.00');
              if COFINS99.TipoCalculo = tipCValor then
                begin
                  Imposto.COFINS.COFINSOutr.QBCProd   := NotaUtil.FormatFloat(COFINS99.Quantidade, '0.0000');
                  Imposto.COFINS.COFINSOutr.VAliqProd := NotaUtil.FormatFloat(COFINS99.Aliquota, '0.0000');
                end
              else
                begin
                  Imposto.COFINS.COFINSOutr.VBC     := NotaUtil.FormatFloat(COFINS99.ValorBase, '0.00');
                  Imposto.COFINS.COFINSOutr.PCOFINS := NotaUtil.FormatFloat(COFINS99.Aliquota, '0.00');
                end;
            end
        end;


        with DadosProdutos.Items[i].Tributos.COFINSST do
        begin
          if (ValorBase > 0) then begin
            Imposto.COFINSST.VBC := NotaUtil.FormatFloat(ValorBase, '0.00');
            Imposto.COFINSST.PCOFINS := NotaUtil.FormatFloat(AliquotaPerc, '0.00');
          end else if (Quantidade > 0) then begin
            Imposto.COFINSST.QBCProd := NotaUtil.FormatFloat(Quantidade, '0.0000');
            Imposto.COFINSST.VAliqProd := NotaUtil.FormatFloat(AliquotaValor, '0.0000');
          end;
          if (ValorCOFINSST > 0) then
            Imposto.COFINSST.VCOFINS := NotaUtil.FormatFloat(ValorCOFINSST, '0.00');

        end;

        with DadosProdutos.Items[i].Tributos.ISSQN do
        begin
          if (ValorBase > 0) or (Aliquota > 0) or (ValorISSQN > 0) or (CodigoServico <> '') then begin
            with Imposto.ISSQN do begin

              if (ValorBase > 0) then
                VBC := NotaUtil.FormatFloat(ValorBase, '0.00');
              if (Aliquota > 0) then
                VAliq := NotaUtil.FormatFloat(Aliquota, '0.00');
              if (ValorISSQN > 0) then
                VISSQN := NotaUtil.FormatFloat(ValorISSQN, '0.00');
              if (MunicipioFatoGerador > 0) then
                CMunFG := IntToStr(MunicipioFatoGerador);
              if (CodigoServico <> '') then
                CListServ := CodigoServico;
            end;
          end;  
        end;

      end;
    end;
  end;

  with NotaFiscal(FNotaFiscal), FNFe.InfNFe.Total.ICMSTot do
  begin
    VBC     := NotaUtil.FormatFloat(ValoresTotais.BaseICMS, '0.00');
    VICMS   := NotaUtil.FormatFloat(ValoresTotais.ValorICMS, '0.00');
    VBCST   := NotaUtil.FormatFloat(ValoresTotais.BaseICMSSubstituicao, '0.00');
    VST     := NotaUtil.FormatFloat(ValoresTotais.ValorICMSSubstituicao, '0.00');
    VProd   := NotaUtil.FormatFloat(ValoresTotais.ValorProduto, '0.00');
    VFrete  := NotaUtil.FormatFloat(ValoresTotais.ValorFrete, '0.00');
    VSeg    := NotaUtil.FormatFloat(ValoresTotais.ValorSeguro, '0.00');
    VDesc   := NotaUtil.FormatFloat(ValoresTotais.ValorDesconto, '0.00');
    VII     := NotaUtil.FormatFloat(ValoresTotais.ValorII, '0.00');
    VIPI    := NotaUtil.FormatFloat(ValoresTotais.ValorIPI, '0.00');
    VPIS    := NotaUtil.FormatFloat(ValoresTotais.ValorPIS, '0.00');
    VCOFINS := NotaUtil.FormatFloat(ValoresTotais.ValorCOFINS, '0.00');
    VOutro  := NotaUtil.FormatFloat(ValoresTotais.ValorOutrasDespesas, '0.00');
    VNF     := NotaUtil.FormatFloat(ValoresTotais.ValorNota, '0.00');

    With ValoresTotais.ISSQNTot, FNFe.InfNFe.Total.ISSQNtot do begin
      if NotaUtil.NaoEstaZerado(ValorServicos) then
        VServ := NotaUtil.FormatFloat(ValorServicos, '0.00');
      if NotaUtil.NaoEstaZerado(ValorBase) then
        VBC := NotaUtil.FormatFloat(ValorBase, '0.00');
      if NotaUtil.NaoEstaZerado(ValorISSQN) then
        VISS := NotaUtil.FormatFloat(ValorISSQN, '0.00');
      if NotaUtil.NaoEstaZerado(ValorPIS) then
        VPIS := NotaUtil.FormatFloat(ValorPIS, '0.00');
      if NotaUtil.NaoEstaZerado(ValorCOFINS) then
        VCOFINS := NotaUtil.FormatFloat(ValorCOFINS, '0.00');
    end;

    With ValoresTotais.Retencoes, FNFe.InfNFe.Total.RetTrib do begin
      if NotaUtil.NaoEstaZerado(ValorRetidoPIS) then
        VRetPIS := NotaUtil.FormatFloat(ValorRetidoPIS, '0.00');
      if NotaUtil.NaoEstaZerado(ValorRetidoCOFINS) then
        VRetCOFINS := NotaUtil.FormatFloat(ValorRetidoCOFINS, '0.00');
      if NotaUtil.NaoEstaZerado(ValorRetidoCSLL) then
        VRetCSLL := NotaUtil.FormatFloat(ValorRetidoCSLL, '0.00');
      if NotaUtil.NaoEstaZerado(BaseCalculoIRRF) then
        VBCIRRF := NotaUtil.FormatFloat(BaseCalculoIRRF, '0.00');
      if NotaUtil.NaoEstaZerado(ValorIRRF) then
        VIRRF := NotaUtil.FormatFloat(ValorIRRF, '0.00');
      if NotaUtil.NaoEstaZerado(ValorRetidoINSS) then
        VRetPrev := NotaUtil.FormatFloat(ValorRetidoINSS, '0.00');
    end;

  end;

  with NotaFiscal(FNotaFiscal), FNFe.InfNFe.Transp do
  begin
    ModFrete := IntToStr(Ord(Transportador.FretePorConta));
    if NotaUtil.NaoEstaVazio(Transportador.CnpjCpf) then
    begin
      if Length(Transportador.CnpjCpf) > 11 then
        Transporta.CNPJ := Transportador.CnpjCpf
      else
        Transporta.CPF := Transportador.CnpjCpf;
    end;

    if NotaUtil.NaoEstaVazio(Transportador.NomeRazao) then
      Transporta.XNome := NotaUtil.ParseText(Transportador.NomeRazao);
    if NotaUtil.NaoEstaVazio(Transportador.IE) then
      Transporta.IE := Transportador.IE;
    if NotaUtil.NaoEstaVazio(Transportador.Endereco) then
      Transporta.XEnder := Transportador.Endereco;
    if NotaUtil.NaoEstaVazio(Transportador.Cidade) then
      Transporta.XMun := Transportador.Cidade;
    if NotaUtil.NaoEstaVazio(Transportador.UF) then
      Transporta.UF := Transportador.UF;

    if NotaUtil.NaoEstaZerado(Transportador.RetencaoICMS.ValorServico) then
    begin
      with RetTransp do
      begin
        VServ    := NotaUtil.FormatFloat(Transportador.RetencaoICMS.ValorServico, '0.00');
        VBCRet   := NotaUtil.FormatFloat(Transportador.RetencaoICMS.ValorBase, '0.00');
        PICMSRet := NotaUtil.FormatFloat(Transportador.RetencaoICMS.Aliquota, '0.00');
        VICMSRet := NotaUtil.FormatFloat(Transportador.RetencaoICMS.Valor, '0.00');
        CFOP     := NotaUtil.Poem_Zeros(Transportador.RetencaoICMS.CFOP, 4);
        CMunFG   := NotaUtil.Poem_Zeros(Transportador.RetencaoICMS.Cidade, 7);
      end;
    end;

    if NotaUtil.NaoEstaVazio(Transportador.Veiculo.Placa) then
    begin
      with VeicTransp do
      begin
        Placa := Transportador.Veiculo.Placa;
        UF := Transportador.Veiculo.UF;
        if NotaUtil.NaoEstaVazio(Transportador.Veiculo.RNTC) then
          RNTC := Transportador.Veiculo.RNTC;
      end;
    end;

    for i:= 0 to Transportador.Reboque.Count -1 do begin
      with Reboque.Add do begin
        if NotaUtil.NaoEstaVazio(Transportador.Reboque.Items[i].Placa) then begin
          Placa := Transportador.Reboque.Items[i].Placa;
          if NotaUtil.NaoEstaVazio(Transportador.Reboque.Items[i].UF) then
            UF := Transportador.Reboque.Items[i].UF;
          if NotaUtil.NaoEstaVazio(Transportador.Reboque.Items[i].RNTC) then
            RNTC := Transportador.Reboque.Items[i].RNTC;
        end;
      end;
    end;

    for  i:=0  to Transportador.Volumes.Count-1 do
    begin
      with Vol.Add do
      begin
        if NotaUtil.NaoEstaZerado(Transportador.Volumes.Items[i].Quantidade) then
          QVol  := IntToStr(Transportador.Volumes.Items[i].Quantidade);
        if NotaUtil.NaoEstaVazio(Transportador.Volumes.Items[i].Especie) then
          Esp   := NotaUtil.ParseText(Transportador.Volumes.Items[i].Especie);
        if NotaUtil.NaoEstaVazio(Transportador.Volumes.Items[i].Marca) then
          Marca := NotaUtil.ParseText(Transportador.Volumes.Items[i].Marca);
        if NotaUtil.NaoEstaVazio(Transportador.Volumes.Items[i].Numeracao) then
          NVol  := Transportador.Volumes.Items[i].Numeracao;
        if NotaUtil.NaoEstaZerado(Transportador.Volumes.Items[i].PesoLiquido) then
          PesoL := NotaUtil.FormatFloat(Transportador.Volumes.Items[i].PesoLiquido, '0.000');
        if NotaUtil.NaoEstaZerado(Transportador.Volumes.Items[i].PesoBruto) then
          PesoB := NotaUtil.FormatFloat(Transportador.Volumes.Items[i].PesoBruto, '0.000');
      end;
    end;
  end;

  if NotaUtil.NaoEstaVazio(NotaFiscal(FNotaFiscal).Fatura.Numero) then
  begin
    with NotaFiscal(FNotaFiscal), FNFe.InfNFe.Cobr.Fat do
    begin
      NFat  := Fatura.Numero;
      VOrig := NotaUtil.FormatFloat(Fatura.ValorOriginal, '0.00');
      if NotaUtil.NaoEstaZerado(Fatura.ValorDesconto) then
         VDesc := NotaUtil.FormatFloat(Fatura.ValorDesconto, '0.00');
      VLiq  := NotaUtil.FormatFloat(Fatura.ValorLiquido, '0.00');
    end;
  end;

  if NotaUtil.NaoEstaZerado(NotaFiscal(FNotaFiscal).Fatura.Duplicatas.Count) then
  begin
    for i:= 0 to NotaFiscal(FNotaFiscal).Fatura.Duplicatas.Count-1 do
    begin
      with NotaFiscal(FNotaFiscal), FNFe.InfNFe.Cobr.Dup.Add do
      begin
        NDup  := Fatura.Duplicatas.Items[i].Numero;
        DVenc := FormatDateTime('YYYY-MM-DD', Fatura.Duplicatas.Items[i].DataVencimento);
        VDup  := NotaUtil.FormatFloat(Fatura.Duplicatas.Items[i].Valor, '0.00');
      end;
    end;
  end;

  if NotaUtil.NaoEstaVazio(NotaFiscal(FNotaFiscal).DadosAdicionais.Complemento) then
  begin
    with NotaFiscal(FNotaFiscal), FNFe.InfNFe.InfAdic do
      InfCpl := NotaUtil.ParseText(DadosAdicionais.Complemento);
  end;

  if NotaUtil.NaoEstaZerado(NotaFiscal(FNotaFiscal).DadosAdicionais.Informacoes.Count) then
  begin
    for i:= 0 to NotaFiscal(FNotaFiscal).DadosAdicionais.Informacoes.Count-1 do
    begin
      with NotaFiscal(FNotaFiscal), FNFe.InfNFe.InfAdic.ObsCont.Add do
      begin
        XCampo  := NotaUtil.ParseText(DadosAdicionais.Informacoes.Items[i].Campo);
        XTexto  := NotaUtil.ParseText(DadosAdicionais.Informacoes.Items[i].Texto);
      end;
    end;
  end;

  if NotaUtil.NaoEstaZerado(NotaFiscal(FNotaFiscal).DadosAdicionais.ObsFisco.Count) then
  begin
    for i:= 0 to NotaFiscal(FNotaFiscal).DadosAdicionais.ObsFisco.Count-1 do
    begin
      with NotaFiscal(FNotaFiscal), FNFe.InfNFe.InfAdic.ObsFisco.Add do
      begin
        XCampo  := NotaUtil.ParseText(DadosAdicionais.ObsFisco.Items[i].Campo);
        XTexto  := NotaUtil.ParseText(DadosAdicionais.ObsFisco.Items[i].Texto);
      end;
    end;
  end;

end;

procedure TNotaFiscalXML.Imprimir;
begin
  dmACBrNFe.Imprimir(FNFe, TConfiguracoes(FConfiguracoes).Geral.LogoMarca);
end;

procedure TNotaFiscalXML.ImprimirPDF;
begin
  dmACBrNFe.ImprimirPDF(FNFe, TConfiguracoes(FConfiguracoes).Geral.LogoMarca);
end;

procedure TNotaFiscalXML.LoadFromFile(Const AFile: String);
var
  vXmlDoc: IXMLDocument;
begin
  vXmlDoc := NewXMLDocument;
  vXmlDoc.LoadFromFile(AFile);
  FNFe := NewNFe;
  FNFe := GetNFe(vXmlDoc);
end;

function TNotaFiscalXML.GetNFeChave: String;
begin
  Result := StringReplace(FNFe.InfNFe.Id, 'NFe','', [rfIgnoreCase]);
end;

procedure TNotaFiscalXML.SaveToFile(AFile: String='');
var
  vXmlDoc: IXMLDocument;
begin
  if NotaUtil.EstaVazio(AFile) then
  begin
    AFile := TConfiguracoes(FConfiguracoes).Geral.PathSalvar;
    AFile := AFile+PathDelim+GetNFeChave+'-nfe.xml';
  end;

  ForceDirectories(ExtractFilePath(AFile));
  vXmlDoc := LoadXMLData(FNFe.XML);
  vXmlDoc.Encoding := 'UTF-8';
  vXmlDoc.SaveToFile(AFile);
end;

procedure TNotaFiscalXML.ValidaEmitente;
var
  vMsg: String;
begin
  vMsg := 'Falha na validação dos dados da nota '+
          IntToStr(NotaFiscal(FNotaFiscal).Identificacao.Numero)+LineBreak;
  with NotaFiscal(FNotaFiscal) do
  begin
    NotaUtil.TamanhoIgual(Emitente.CNPJ, 14, vMsg+'Emitente CNPJ inválido!');
    NotaUtil.EstaVazio(Emitente.Nome.RazaoSocial, vMsg+'Informar a Razão Social ou Nome do Emitente!');
    NotaUtil.EstaVazio(Emitente.Endereco.Logradouro, vMsg+'Informar o Logradouro no endereço do Emitente!');
    NotaUtil.EstaVazio(Emitente.Endereco.Bairro, vMsg+'Informar o Bairro no endereço do Emitente!');
    NotaUtil.TamanhoIgual(Emitente.Endereco.Cidade.Codigo, 7, vMsg+'Codigo da cidade no endereço do Emitente inválido!');
    NotaUtil.EstaVazio(Emitente.Endereco.Cidade.Descricao, vMsg+'Informar a Cidade no endereço do Emitente!');
    NotaUtil.validaUF(Emitente.Endereco.UF, vMsg+'UF no endereço do Emitente inválido!');
    NotaUtil.ValidaUFCidade(Emitente.Endereco.UFCodigo, Emitente.Endereco.Cidade.Codigo, 'Codigo da cidade não confere com a UF do Emitente!');
    if Length(IntToStr(Emitente.Endereco.Pais.Codigo)) > 4 then
      raise Exception.Create(vMsg+'Codigo do Pais no endereço do Emitente inválido!');
    NotaUtil.EstaVazio(Emitente.IE, vMsg+'Emitente IE inválido!');
  end;
end;

procedure TNotaFiscalXML.ValidaDestinatario;
var
  vMsg: String;
begin
  vMsg := 'Falha na validação dos dados da nota '+
          IntToStr(NotaFiscal(FNotaFiscal).Identificacao.Numero)+LineBreak;
  with NotaFiscal(FNotaFiscal) do
  begin
    if not(NotaUtil.TamanhoIgual(Destinatario.CNPJCPF, 11) or NotaUtil.TamanhoIgual(Destinatario.CNPJCPF,14)) then
      raise Exception.Create(vMsg+'Destinatário com CNPJ ou CPF inválido!');

    NotaUtil.EstaVazio(Destinatario.NomeRazao, vMsg+'Informar o Razão Social ou Nome do Destinatário!');
    NotaUtil.EstaVazio(Destinatario.Endereco.Logradouro, vMsg+'Informar o Logradouro no endereço do Destinatário!');
    NotaUtil.EstaVazio(Destinatario.Endereco.Bairro, vMsg+'Informar o Bairro no endereço do Destinatário!');
    NotaUtil.TamanhoIgual(Destinatario.Endereco.Cidade.Codigo, 7, vMsg+'Codigo da cidade no endereço do Destinatário inválido!');
    NotaUtil.EstaVazio(Destinatario.Endereco.Cidade.Descricao, vMsg+'Informar a Cidade no endereço do Destinatário!');
    NotaUtil.validaUF(Destinatario.Endereco.UF, vMsg+'UF no endereço do Destinatário inválido!');
    NotaUtil.ValidaUFCidade(Emitente.Endereco.UFCodigo, Emitente.Endereco.Cidade.Codigo, 'Codigo da cidade não confere com a UF do Destinatário!');
    if Length(IntToStr(Destinatario.Endereco.Pais.Codigo)) > 4 then
      raise Exception.Create(vMsg+'Codigo do Pais no endereço do Destinatário inválido!');
  end;
end;

procedure TNotaFiscalXML.ValidaProdutos;
var
  vMsg: String;
  i: Integer;
begin
  vMsg := 'Falha na validação dos dados da nota '+
          IntToStr(NotaFiscal(FNotaFiscal).Identificacao.Numero)+LineBreak;

  with NotaFiscal(FNotaFiscal) do
  begin
    NotaUtil.EstaZerado(DadosProdutos.Count, vMsg+'Nota Fiscal sem produtos informados!');

    for i := 0 to DadosProdutos.Count-1 do
    begin
      NotaUtil.EstaVazio(DadosProdutos.Items[i].Codigo, vMsg+'Produto '+QuotedStr(DadosProdutos.Items[i].Descricao)+' sem código!');
      NotaUtil.EstaVazio(DadosProdutos.Items[i].Descricao, vMsg+'Produto '+QuotedStr(DadosProdutos.Items[i].Codigo)+' sem descrição!');
      NotaUtil.TamanhoIgual(DadosProdutos.Items[i].CFOP, 4, vMsg+'Produto '+QuotedStr(DadosProdutos.Items[i].Codigo)+' com CFOP inválido!');
      NotaUtil.EstaVazio(DadosProdutos.Items[i].Unidade, vMsg+'Produto '+QuotedStr(DadosProdutos.Items[i].Codigo)+' sem unidade comercial!');
    end;
  end;
end;

procedure TNotaFiscalXML.ValidaTranportador;
var
  vMsg: String;
begin
  vMsg := 'Falha na validação dos dados da nota '+
          IntToStr(NotaFiscal(FNotaFiscal).Identificacao.Numero)+LineBreak;
  with NotaFiscal(FNotaFiscal) do
  begin
    if NotaUtil.NaoEstaVazio(Transportador.CNPJCPF) then
    begin
      if not(NotaUtil.TamanhoIgual(Transportador.CNPJCPF, 11) or NotaUtil.TamanhoIgual(Transportador.CNPJCPF, 14)) then
        raise Exception.Create(vMsg+'Transportador com CNPJ ou CPF inválido!');
    end;

    if NotaUtil.NaoEstaVazio(Transportador.Veiculo.Placa) or NotaUtil.NaoEstaVazio(Transportador.Veiculo.UF) then
    begin
      NotaUtil.EstaVazio(Transportador.Veiculo.Placa, vMsg+'Informar a Placa do Veiculo Transportador!');
      NotaUtil.EstaVazio(Transportador.Veiculo.UF, vMsg+'Informar a UF do Veiculo Transportador!');
    end;
  end;
end;

procedure TNotaFiscalXML.ValidaIdentificacao;
var
  vMsg: String;
begin
  vMsg := 'Falha na validação dos dados da nota '+
          IntToStr(NotaFiscal(FNotaFiscal).Identificacao.Numero)+LineBreak;
  with NotaFiscal(FNotaFiscal) do
  begin
    NotaUtil.EstaVazio(Identificacao.NaturezaOperacao, vMsg+'Informar a Natureza de Operação!');
    NotaUtil.EstaZerado(Identificacao.Modelo, vMsg+'Informar o Modelo do documento Fiscal!');
  end;
end;

procedure TNotaFiscalXML.Valida;
begin
  if not(NotaUtil.Valida(FNFe.XML, FMsg)) then
    raise Exception.Create('Falha na validação dos dados da nota '+
                            FNFe.InfNFe.Ide.CNF+LineBreak+FMsg);
end;

end.

